// scripts\mp\ai_behavior.gsc  (hash_120270bd0a747a35.gscc) (size: 73154 Bytes / 0x11dc2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5f3b24d1 (1597711569)
// size ...... 73154 (0x11dc2)
// includes .. 26  (offset: 0x113b2)
// strings ... 114 (offset: 0x11482)
// dev strs .. 39  (offset: 0x11bc6)
// exports ... 164 (offset: 0xc3be)
// cseg ...... 0x823 + 0xbb9b (0xc3be)
// imports ... 415 (offset: 0xdd5e)
// animtree1 . 0   (offset: 0x11dc2)
// animtree2 . 0   (offset: 0x11dc2)
#using script_16ea1b94f0f381b3;
#using script_2c7c69eb6ac4b999;
#using scripts\asm\asm_bb;
#using scripts\common\ai;
#using scripts\common\ai\stealth\enemy;
#using scripts\common\ai\stealth\group;
#using scripts\common\ai\stealth\utility;
#using scripts\common\ai_formation;
#using scripts\common\ai_group_patrol;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\ai_fortress;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\ai_reinforcements;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\equipment\molotov;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\pickups_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\dmz\gametypes\dmz_ai;
#using scripts\mp\flags;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\pickups_scriptable;
#using scripts\mp\poi;

#namespace ai_behavior;

// Namespace ai_behavior
// Params 0
// Checksum 0xf160403b, Offset: 0x841
// Size: 0x8d
function behavior_init()
{
    function_223e7c840bdf1243();
    level.var_3785341350ae5ae7 = getdvarint( @"hash_830b3724421f829e", 1 );
    level.var_77df8198c8d34fb4 = 3;
    level.var_3921db498cf440f7 = 2;
    level.var_845e167e54b7d89b = 40;
    level.var_7f7812da196c52e = getdvarint( @"hash_f34e4fbaeb441e24", 2048 );
    level.var_eac3f9c5596f9273 = getdvarint( @"hash_d376208bc97461f5", 1028 );
    level.var_20660ebd4bdc345b = getdvarint( @"hash_8a909a349168d2c5", 1028 );
}

// Namespace ai_behavior
// Params 0
// Checksum 0xa0dc0bf8, Offset: 0x8d6
// Size: 0x3e
function function_223e7c840bdf1243()
{
    utility::registersharedfunc( #"pyro", #"hash_559ad6ce148c89f3", &molotov::molotov_used );
    utility::registersharedfunc( #"hash_f2797ede5d5d50a7", #"hash_55bb0997b208356b", &cqb_releasenode );
}

// Namespace ai_behavior
// Params 4
// Checksum 0xec79cd8e, Offset: 0x91c
// Size: 0x42
function function_4a3c03bb49dd5d76( origin, goalradius, var_392bcba6a6d20446, debugstring )
{
    _setgoalpos( origin, goalradius, undefined, debugstring );
    
    if ( var_392bcba6a6d20446 )
    {
        level thread ai_watchforbadpath( self );
    }
}

// Namespace ai_behavior
// Params 4
// Checksum 0x56489b03, Offset: 0x966
// Size: 0x196
function _setgoalpos( origin, goalradius, var_f0d2e4ade0883512, debugstring )
{
    if ( self.fixednode || !isalive( self ) || isdefined( self.vehicle ) )
    {
        return;
    }
    
    safeorigin = self getclosestreachablepointonnavmesh( origin );
    
    if ( !isdefined( safeorigin ) )
    {
        println( "<dev string:x24>" + origin );
        return;
    }
    
    if ( !isdefined( self.origin ) )
    {
        assertmsg( "<dev string:x63>" );
        return;
    }
    
    if ( !var_f0d2e4ade0883512 )
    {
        function_7bbd01e514ea0578( goalradius );
    }
    
    dist = distance( self.origin, safeorigin );
    
    if ( dist < 12500 && dist > 20 )
    {
        if ( false )
        {
            thread debug::drawsphere( safeorigin, 32, 10, ( 0, 1, 0 ) );
        }
        
        self setgoalpos( safeorigin );
    }
    else if ( dist >= 12500 && !self.guardwanderactive )
    {
        assertmsg( "<dev string:x9b>" + dist + "<dev string:xd7>" + safeorigin + "<dev string:xe2>" + self.origin + "<dev string:xf1>" + origin + "<dev string:xfb>" + self getentitynumber() );
        thread behavior_GuardWander( self, 1024 );
    }
    
    /#
        if ( 0 && isstring( debugstring ) )
        {
            print3d( origin + ( 0, 0, 32 ), debugstring, ( 0, 1, 0 ), 1, 1.5, 400, 1 );
        }
    #/
}

// Namespace ai_behavior
// Params 1
// Checksum 0xcf4c4c3a, Offset: 0xb04
// Size: 0x2f
function function_7bbd01e514ea0578( goalradius = 128 )
{
    self.goalradius = int( goalradius );
    self.script_goalradius = goalradius;
}

// Namespace ai_behavior
// Params 2
// Checksum 0x2a3f9a46, Offset: 0xb3b
// Size: 0x1d
function function_c146762c6c30eb97( agent, targetent )
{
    agent setgoalentity( targetent );
}

// Namespace ai_behavior
// Params 1
// Checksum 0x50601a18, Offset: 0xb60
// Size: 0x14
function function_8b90cbb5fb2f0d36( node )
{
    self setgoalnode( node );
}

// Namespace ai_behavior
// Params 1
// Checksum 0x11bafe6f, Offset: 0xb7c
// Size: 0x42
function function_b49820d3792f8b12( origin )
{
    if ( isnavmeshloaded() )
    {
        navmeshorigin = getclosestpointonnavmesh( origin );
    }
    else
    {
        navmeshorigin = origin;
    }
    
    groundorigin = utility::drop_to_ground( navmeshorigin, 64 );
    return groundorigin;
}

// Namespace ai_behavior
// Params 0
// Checksum 0x70e23f2c, Offset: 0xbc7
// Size: 0x2d
function function_1035cc9dfcff38d0()
{
    level endon( #"game_ended" );
    
    while ( !flags::gameflagexists( "prematch_done" ) )
    {
        waitframe();
    }
    
    flags::gameflagwait( "prematch_done" );
}

// Namespace ai_behavior
// Params 8
// Checksum 0x1801b879, Offset: 0xbfc
// Size: 0x164
function behavior_GuardStationary( agent, var_f7f19be7cc8a29e8, origin, var_9e49ac0d46d4a83, var_9b8779fb8afb73af, var_9b6467fb8ad50461, interactionuseradius, var_45a604112622f547 )
{
    savedorigin = origin;
    
    if ( isagent( agent ) && !isdefined( origin ) )
    {
        savedorigin = agent.origin;
    }
    
    if ( var_f7f19be7cc8a29e8 )
    {
        function_2aa2d25463c152b4( agent, savedorigin, var_f7f19be7cc8a29e8, undefined, undefined, var_9e49ac0d46d4a83, var_9b8779fb8afb73af, var_9b6467fb8ad50461, interactionuseradius, var_45a604112622f547 );
    }
    else
    {
        function_7b154a7c7eb87672( agent, savedorigin, 25, 5, var_9e49ac0d46d4a83, var_9b8779fb8afb73af, var_9b6467fb8ad50461, interactionuseradius, var_45a604112622f547 );
    }
    
    if ( isint( agent ) )
    {
        return;
    }
    
    agent endon( #"death" );
    agent endon( #"stealth_investigate" );
    agent endon( #"stealth_hunt" );
    agent endon( #"stealth_combat" );
    agent endon( #"startCombatRush" );
    function_1035cc9dfcff38d0();
    wait 1;
    
    if ( isdefined( origin ) && distance2dsquared( origin, agent.origin ) > 4096 )
    {
        agent function_4a3c03bb49dd5d76( origin, 32, 1, "behavior_GuardStationary" );
        agent waittill( #"goal" );
    }
    else if ( !isdefined( origin ) )
    {
        origin = agent.origin;
    }
    
    if ( !var_f7f19be7cc8a29e8 )
    {
        agent behavior_executebehaviorpackage( agent );
    }
}

// Namespace ai_behavior
// Params 10
// Checksum 0xef0f9cb2, Offset: 0xd68
// Size: 0x3b8
function behavior_GuardWander( agent, radius = 100, radiusvariance = 50, origin, var_b1f82de8abaad546, var_9e49ac0d46d4a83 = 0, var_9b8779fb8afb73af, var_9b6467fb8ad50461, interactionuseradius, var_aaf6f0ce2cb6508 )
{
    savedorigin = origin;
    
    if ( isagent( agent ) && !isdefined( origin ) )
    {
        savedorigin = agent.origin;
    }
    
    function_7b154a7c7eb87672( agent, savedorigin, radius, radiusvariance, undefined, undefined, undefined, undefined, var_aaf6f0ce2cb6508 );
    
    if ( isint( agent ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_76e37dcc8fbd3461 ) )
    {
        level.var_76e37dcc8fbd3461 = 50;
    }
    
    agent endon( #"death" );
    agent endon( #"stealth_investigate" );
    agent endon( #"stealth_hunt" );
    agent endon( #"stealth_combat" );
    agent endon( #"startCombatRush" );
    agent endon( #"hash_b82de4299d909fce" );
    agent notify( #"guardwander" );
    agent endon( #"guardwander" );
    function_1035cc9dfcff38d0();
    wait randomfloatrange( 0.5, 7 );
    
    if ( isdefined( origin ) && distance2dsquared( origin, agent.origin ) > 4096 )
    {
        agent function_4a3c03bb49dd5d76( origin, 32, 1, "behavior_GuardWander" );
        agent waittill( #"goal" );
    }
    
    originalorigin = agent.origin;
    max = radius + radiusvariance;
    
    if ( !isdefined( radiusvariance ) || radiusvariance <= 0 )
    {
        min = 0;
    }
    else
    {
        min = max( 0, radius - radiusvariance );
    }
    
    agent.guardwanderactive = 1;
    
    if ( var_b1f82de8abaad546 > 0 )
    {
        agent thread function_a444e1084227f427( agent, var_b1f82de8abaad546, "alert" );
    }
    
    while ( !isdefined( agent.enemy ) )
    {
        angle = randomfloatrange( 0, 360 );
        dist = randomfloatrange( min, max );
        random_x = cos( angle ) * dist;
        random_y = sin( angle ) * dist;
        var_cbf0098919b9f972 = ( originalorigin[ 0 ] + random_x, originalorigin[ 1 ] + random_y, originalorigin[ 2 ] );
        [ var_301dec880c0f9e02, var_9ac2a9920107bedc ] = [ 1, 3 ];
        
        if ( agent.insidegoalvolume )
        {
            var_cf1067342515b44a = ispointinvolume( var_cbf0098919b9f972, agent.insidegoalvolume );
        }
        else
        {
            var_d54ac6752a8a019e = 1;
        }
        
        if ( var_cf1067342515b44a || var_d54ac6752a8a019e )
        {
            agent _setgoalpos( var_cbf0098919b9f972, min / 2 );
            agent thread function_7d1c597e7c5c5b7b( agent, 20 );
            msg = agent utility::waittill_any_return( "goal", "refreshGoalPos" );
            
            if ( !var_9e49ac0d46d4a83 && function_6d4b291a7628fac3( agent ) )
            {
                if ( randomintrange( 0, 100 ) < level.var_76e37dcc8fbd3461 )
                {
                    function_8dab18257ee1b60( agent, savedorigin, var_9b8779fb8afb73af, var_9b6467fb8ad50461, interactionuseradius );
                    [ var_301dec880c0f9e02, var_9ac2a9920107bedc ] = [ 0.25, 0.5 ];
                }
            }
        }
        else
        {
            [ var_301dec880c0f9e02, var_9ac2a9920107bedc ] = [ 0.25, 0.5 ];
        }
        
        wait randomfloatrange( var_301dec880c0f9e02, var_9ac2a9920107bedc );
    }
}

// Namespace ai_behavior
// Params 3
// Checksum 0x4bad758, Offset: 0x1128
// Size: 0x6e
function function_a444e1084227f427( agent, time, demeanor )
{
    if ( !isdefined( agent.stealth_idledemeanor ) )
    {
        return;
    }
    
    agent endon( #"death" );
    wait time;
    
    if ( isagent( agent ) && isalive( agent ) )
    {
        agent.stealth_idledemeanor = demeanor;
        agent.var_b52fca22f7f1e144 = demeanor;
    }
}

// Namespace ai_behavior
// Params 4
// Checksum 0x19701d8f, Offset: 0x119e
// Size: 0x200
function behavior_combatWander( agent, radius, radiusvariance, origin )
{
    savedorigin = origin;
    
    if ( isagent( agent ) && !isdefined( origin ) )
    {
        savedorigin = agent.origin;
    }
    
    if ( !isdefined( radius ) )
    {
        radius = 1000;
    }
    
    if ( !isdefined( radiusvariance ) || radiusvariance <= 0 )
    {
        radiusvariance = 200;
    }
    
    function_95ada18faf94770a( agent, savedorigin, radius, radiusvariance );
    
    if ( isint( agent ) )
    {
        return;
    }
    
    agent endon( #"death" );
    agent endon( #"stealth_investigate" );
    agent endon( #"stealth_hunt" );
    agent endon( #"stealth_combat" );
    agent endon( #"startCombatRush" );
    function_1035cc9dfcff38d0();
    wait 1;
    
    if ( isdefined( origin ) && distance2dsquared( origin, agent.origin ) > 4096 )
    {
        agent function_4a3c03bb49dd5d76( origin, 32, 1, "behavior_combatWander" );
        agent waittill( #"goal" );
    }
    
    originalorigin = agent.origin;
    min = radius - radiusvariance;
    max = radius + radiusvariance;
    
    while ( true )
    {
        random_x = randomfloatrange( min, max ) * ( randomint( 100 ) > 50 ? 1 : -1 );
        random_y = randomfloatrange( min, max ) * ( randomint( 100 ) > 50 ? 1 : -1 );
        var_cbf0098919b9f972 = ( originalorigin[ 0 ] + random_x, originalorigin[ 1 ] + random_y, originalorigin[ 2 ] );
        
        if ( distance2d( agent.origin, var_cbf0098919b9f972 ) > 20 )
        {
            agent _setgoalpos( var_cbf0098919b9f972, 8 );
            agent thread function_7d1c597e7c5c5b7b( agent );
            agent utility::waittill_any( "goal", "refreshGoalPos" );
        }
        
        wait randomfloatrange( 7.5, 10.5 );
    }
}

// Namespace ai_behavior
// Params 2
// Checksum 0x98b3bf91, Offset: 0x13a6
// Size: 0x57
function function_7d1c597e7c5c5b7b( agent, time )
{
    agent endon( #"goal" );
    agent endon( #"death" );
    waittime = 5;
    
    if ( isdefined( time ) )
    {
        waittime = time;
    }
    
    wait waittime;
    agent notify( #"refreshGoalPos" );
}

// Namespace ai_behavior
// Params 6
// Checksum 0xa4fe59d6, Offset: 0x1405
// Size: 0xa40
function behavior_patrol( var_2079bcd3b73e0438, pathstruct, startindex, goalradiusoverride, idletimeoverride, patrolgroupname )
{
    if ( !isdefined( var_2079bcd3b73e0438[ 0 ] ) )
    {
        return;
    }
    
    level endon( #"game_ended" );
    var_a4c60ebde94bc5ca = 0;
    
    foreach ( agent in var_2079bcd3b73e0438 )
    {
        behaviorpackage = function_342e7d77531fb6e3( agent );
        
        if ( !isdefined( behaviorpackage ) || behaviorpackage.behavior != "patrol" )
        {
            if ( level.allowdormancy && !isdefined( patrolgroupname ) )
            {
                function_275a3085a93cd3ad( agent, [ agent ], pathstruct, undefined, undefined, undefined, startindex, pathstruct.path[ 0 ].entity_id );
            }
            else
            {
                function_275a3085a93cd3ad( agent, var_2079bcd3b73e0438, pathstruct, undefined, undefined, patrolgroupname, startindex, pathstruct.path[ 0 ].entity_id );
            }
        }
        
        if ( isagent( agent ) )
        {
            agent notify( #"patrolstart" );
            agent endon( #"patrolstart" );
            agent endon( #"death" );
            agent endon( #"stealth_investigate" );
            agent endon( #"stealth_hunt" );
            agent endon( #"stealth_combat" );
            agent endon( #"startCombatRush" );
            var_a4c60ebde94bc5ca = 1;
        }
    }
    
    if ( !var_a4c60ebde94bc5ca )
    {
        return;
    }
    
    path = pathstruct.path;
    var_18181408efe42afd = 15;
    var_967fc36d3ba6aa4b = 20;
    var_7146a4adf211bd59 = 512;
    
    if ( isdefined( path[ 0 ].var_92b1a3b684bf39fb ) )
    {
        var_18181408efe42afd = int( path[ 0 ].var_92b1a3b684bf39fb );
    }
    
    if ( isdefined( path[ 0 ].var_928e99b68498dc45 ) )
    {
        var_967fc36d3ba6aa4b = int( path[ 0 ].var_928e99b68498dc45 );
    }
    
    if ( isdefined( path[ 0 ].script_interactionuseradius ) )
    {
        var_7146a4adf211bd59 = int( path[ 0 ].script_interactionuseradius );
    }
    
    if ( isdefined( path[ 0 ].var_b6302b531260c98a ) )
    {
        var_6002f78c7953f738 = path[ 0 ].var_b6302b531260c98a;
    }
    
    if ( isdefined( path[ 0 ].script_requiredtags ) )
    {
        var_2f7d6653647c6a50 = path[ 0 ].script_requiredtags;
    }
    
    foreach ( agent in var_2079bcd3b73e0438 )
    {
        function_d96bc4334a12b251( agent, var_2f7d6653647c6a50, var_6002f78c7953f738 );
    }
    
    level thread behavior_patroldeathwatcher( var_2079bcd3b73e0438 );
    pathstruct.claimed = 1;
    index = 1;
    forwarddirection = 1;
    
    if ( isdefined( startindex ) )
    {
        index = startindex;
        index = int( min( index, path.size - 1 ) );
        index = int( max( index, 0 ) );
    }
    
    function_1035cc9dfcff38d0();
    
    if ( level.var_3785341350ae5ae7 )
    {
        formationtype = ai_formation::function_b9c3c25d5af126df( pathstruct );
        var_70f3cb4ca4223d26 = 0;
        
        if ( isdefined( level.var_efaf119164401d47[ patrolgroupname ] ) && level.var_efaf119164401d47[ patrolgroupname ].array.size > 0 )
        {
            var_70f3cb4ca4223d26 = 1;
        }
        
        if ( isdefined( patrolgroupname ) && isdefined( formationtype ) )
        {
            ai_group_patrol::function_180fa7e21b662f2f( patrolgroupname, var_2079bcd3b73e0438, formationtype, level.var_3921db498cf440f7, level.var_845e167e54b7d89b );
        }
        
        if ( var_70f3cb4ca4223d26 )
        {
            return;
        }
    }
    
    idledemeanor = ai_formation::function_93024c73fc4ba7e6( pathstruct );
    
    if ( isdefined( idledemeanor ) && idledemeanor != "patrol" )
    {
        foreach ( agent in var_2079bcd3b73e0438 )
        {
            agent.stealth_idledemeanor = idledemeanor;
            agent.var_b52fca22f7f1e144 = idledemeanor;
        }
    }
    
    var_851c1661bf9885c2 = 16384;
    interactionuseradius = var_7146a4adf211bd59;
    requiredtags = var_2f7d6653647c6a50;
    forbiddentags = var_6002f78c7953f738;
    
    if ( var_2079bcd3b73e0438.size > 1 )
    {
        wait 1;
    }
    
    while ( true )
    {
        if ( patrolgroupname && level.var_efaf119164401d47[ patrolgroupname ] )
        {
            var_2079bcd3b73e0438 = level.var_efaf119164401d47[ patrolgroupname ].array;
        }
        
        if ( isvector( path[ index ] ) )
        {
            point = path[ index ];
        }
        else
        {
            point = path[ index ].origin;
        }
        
        if ( level.var_3785341350ae5ae7 && isdefined( patrolgroupname ) && var_2079bcd3b73e0438.size )
        {
            point = var_2079bcd3b73e0438[ 0 ] getclosestreachablepointonnavmesh( point );
            
            foreach ( agent in var_2079bcd3b73e0438 )
            {
                agent _setgoalpos( point, goalradiusoverride ?? 128 );
            }
            
            thread ai_group_patrol::set_goal( patrolgroupname, point );
            wait 1;
            
            while ( distance2dsquared( var_2079bcd3b73e0438[ 0 ].origin, point ) > var_851c1661bf9885c2 )
            {
                thread ai_group_patrol::set_goal( patrolgroupname, point );
                wait 1;
            }
        }
        else
        {
            foreach ( agentindex, agent in var_2079bcd3b73e0438 )
            {
                if ( agentindex != 0 )
                {
                    random_x = randomfloatrange( 30, 31 ) * ( utility::cointoss() ? 1 : -1 );
                    random_y = randomfloatrange( 30, 31 ) * ( utility::cointoss() ? 1 : -1 );
                    point = ( point[ 0 ] + random_x, point[ 1 ] + random_y, point[ 2 ] );
                }
                
                agent _setgoalpos( point, goalradiusoverride ?? 128 );
                
                if ( var_2079bcd3b73e0438.size > 1 )
                {
                    wait randomfloatrange( 1.5, 2.5 );
                }
            }
            
            waitframe();
            
            if ( var_2079bcd3b73e0438.size )
            {
                var_2079bcd3b73e0438[ 0 ] utility::waittill_any( "bt_goal", "goal" );
            }
        }
        
        if ( !isdefined( path[ index ].script_interactionmode ) || path[ index ].script_interactionmode == "Don't Use Random" )
        {
            var_53d650c5d08cb307 = 1;
        }
        else
        {
            var_53d650c5d08cb307 = 0;
        }
        
        if ( isdefined( path[ index ].var_92b1a3b684bf39fb ) )
        {
            var_9b8779fb8afb73af = int( path[ index ].var_92b1a3b684bf39fb );
        }
        else
        {
            var_9b8779fb8afb73af = var_18181408efe42afd;
        }
        
        if ( isdefined( path[ index ].var_928e99b68498dc45 ) )
        {
            var_9b6467fb8ad50461 = int( path[ index ].var_928e99b68498dc45 );
        }
        else
        {
            var_9b6467fb8ad50461 = var_967fc36d3ba6aa4b;
        }
        
        foreach ( agent in var_2079bcd3b73e0438 )
        {
            function_e90bab991abbb836( agent, requiredtags, forbiddentags );
        }
        
        if ( isdefined( path[ index ].script_interactionuseradius ) )
        {
            interactionuseradius = int( path[ index ].script_interactionuseradius );
        }
        else
        {
            interactionuseradius = var_7146a4adf211bd59;
        }
        
        if ( isdefined( path[ index ].var_b6302b531260c98a ) )
        {
            forbiddentags = path[ index ].var_b6302b531260c98a;
        }
        else
        {
            forbiddentags = var_6002f78c7953f738;
        }
        
        if ( isdefined( path[ index ].script_requiredtags ) )
        {
            requiredtags = path[ index ].script_requiredtags;
        }
        else
        {
            requiredtags = var_2f7d6653647c6a50;
        }
        
        foreach ( agent in var_2079bcd3b73e0438 )
        {
            function_d96bc4334a12b251( agent, requiredtags, forbiddentags );
        }
        
        if ( isdefined( path[ index ].var_9060939adf946 ) )
        {
            interactionchance = int( path[ index ].var_9060939adf946 );
        }
        else
        {
            interactionchance = level.var_2e19dce62d41e878;
        }
        
        roll = randomintrange( 0, 100 );
        
        if ( function_6d4b291a7628fac3( var_2079bcd3b73e0438[ 0 ] ) && roll < interactionchance )
        {
            if ( level.var_3785341350ae5ae7 && isdefined( patrolgroupname ) )
            {
                var_2079bcd3b73e0438 = level.var_efaf119164401d47[ patrolgroupname ].array;
            }
            
            function_ae925e02fa53d09a( var_2079bcd3b73e0438, point, patrolgroupname, var_9b8779fb8afb73af, var_9b6467fb8ad50461, interactionuseradius, var_53d650c5d08cb307 );
            waittime = 1;
        }
        else if ( isdefined( path[ index ].script_waittime ) )
        {
            waittime = int( path[ index ].script_waittime );
        }
        else
        {
            waittime = 5;
        }
        
        wait waittime;
        
        if ( forwarddirection )
        {
            index++;
        }
        else
        {
            index--;
        }
        
        if ( !isdefined( path[ index ] ) )
        {
            if ( !pathstruct.pingpongpath )
            {
                index = 0;
                continue;
            }
            
            if ( forwarddirection )
            {
                index = path.size - 2;
                forwarddirection = 0;
                continue;
            }
            
            index = 1;
            forwarddirection = 1;
        }
    }
}

// Namespace ai_behavior
// Params 1
// Checksum 0xc60683bc, Offset: 0x1e4d
// Size: 0x20f
function behavior_patroldeathwatcher( var_2079bcd3b73e0438 )
{
    level endon( #"game_ended" );
    
    foreach ( agent in var_2079bcd3b73e0438 )
    {
        agent endon( #"stealth_investigate" );
        agent endon( #"stealth_hunt" );
        agent endon( #"stealth_combat" );
    }
    
    var_60f4cfeb484fbf7c = 0;
    
    while ( !var_60f4cfeb484fbf7c )
    {
        foreach ( agent in var_2079bcd3b73e0438 )
        {
            if ( isdefined( agent ) && !isalive( agent ) )
            {
                var_60f4cfeb484fbf7c = 1;
            }
        }
        
        wait 1;
    }
    
    wait 2.5;
    
    foreach ( agent in var_2079bcd3b73e0438 )
    {
        if ( isalive( agent ) )
        {
            event = spawnstruct();
            event.type = "investigate";
            event.typeorig = "found_corpse";
            event.origin = agent.origin;
            event.investigate_pos = agent.origin;
            agent enemy::bt_set_stealth_state( "investigate", event );
        }
    }
}

// Namespace ai_behavior
// Params 1
// Checksum 0x7578ff40, Offset: 0x2064
// Size: 0xb6
function function_95907b4a97fb73ca( params )
{
    if ( params.tostate == 3 )
    {
        function_87cd3d367cd6278c();
        utility::callsharedfunc( #"quickkill", #"hash_999e397b8bdb47c5", self );
        return;
    }
    
    if ( params.tostate == 2 )
    {
        if ( self.goalradius < level.var_eac3f9c5596f9273 )
        {
            self.goalradius = level.var_eac3f9c5596f9273;
        }
        
        return;
    }
    
    if ( params.tostate == 1 )
    {
        if ( self.goalradius < level.var_20660ebd4bdc345b )
        {
            self.goalradius = level.var_20660ebd4bdc345b;
        }
    }
}

// Namespace ai_behavior
// Params 0
// Checksum 0x4d8b7f09, Offset: 0x2122
// Size: 0x37e, Type: bool
function function_87cd3d367cd6278c()
{
    agent = self;
    agent notify( #"endBadPathHandler" );
    
    if ( isdefined( agent.behaviorpackage ) && isdefined( agent.behaviorpackage.combatcenter ) && isdefined( agent.behaviorpackage.combatradius ) )
    {
        agent setgoalpos( agent.behaviorpackage.combatcenter, agent.behaviorpackage.combatradius );
        
        if ( isdefined( agent.var_8a9c24243e6665a1 ) )
        {
            agent.maxsightdistsqrd = agent.var_8a9c24243e6665a1;
        }
    }
    else if ( !agent.combatrushing )
    {
        if ( !isdefined( agent.insidegoalvolume ) && isdefined( agent.agentstruct.fortress ) && agent.var_9798188c1cb9a97b && !agent getgoalentity() )
        {
            if ( agent.agentstruct.fortress.fortressvolumes[ 0 ] && ispointinvolume( agent.origin, agent.agentstruct.fortress.fortressvolumes[ 0 ] ) )
            {
                agent setgoalvolumeauto( agent.agentstruct.fortress.fortressvolumes[ 0 ] );
                agent.doambush = 1;
            }
        }
        else if ( isdefined( agent.insidegoalvolume ) && agent.var_9798188c1cb9a97b && !agent getgoalentity() )
        {
            if ( ispointinvolume( agent.origin, agent.insidegoalvolume ) )
            {
                agent setgoalvolumeauto( agent.insidegoalvolume );
                agent.doambush = 1;
            }
        }
        else if ( isdefined( agent.insidegoalvolume ) && !agent.var_9798188c1cb9a97b && !agent getgoalentity() && !agent.vehicle )
        {
            if ( ispointinvolume( agent.origin, agent.insidegoalvolume ) )
            {
                agent setgoalvolumeauto( agent.insidegoalvolume );
            }
            
            agent.doambush = 0;
        }
        else if ( agent.combatrole == 1 )
        {
            combatradius = 256;
            goalheight = 128;
        }
        else if ( agent.combatrole == 2 )
        {
            combatradius = 50;
            goalheight = 50;
        }
        else if ( isdefined( agent.vehicle_position ) )
        {
            combatradius = agent.goalradius_override ?? 1024;
            goalheight = agent.goalheight_override ?? 1024;
        }
        else
        {
            combatradius = agent.goalradius_override ?? level.var_7f7812da196c52e;
            goalheight = agent.goalheight_override ?? 1024;
        }
        
        if ( combatradius )
        {
            agent.goalradius = combatradius;
        }
        
        if ( goalheight )
        {
            agent.goalheight = goalheight;
        }
    }
    
    if ( agent.var_c92a7956029e02a5 && agent.var_c92a7956029e02a5 != agent getsightconfigtemplateoverride() )
    {
        ai_mp_controller::function_5e5e47ecbf6befd4( agent );
    }
    
    return false;
}

// Namespace ai_behavior
// Params 4
// Checksum 0x308f12c8, Offset: 0x24a9
// Size: 0x11d
function function_d5e7cf61659cb6e( agent, timeout = 120, var_1dd507e22c604dcf = 5, controlleanout = 0 )
{
    self notify( #"hash_a58b198fa9c98cc5" );
    self endon( #"hash_a58b198fa9c98cc5" );
    agent endon( #"death" );
    agent.disabledropfromcombat = 1;
    agent.var_a2181954345d15e9 = 1;
    
    if ( controlleanout )
    {
        agent._blackboard.var_f74fb3b375109c97 = 1;
    }
    
    if ( timeout > 0 )
    {
        agent utility::waittill_any_timeout( timeout, "cancelMaintainCombat" );
    }
    else
    {
        agent waittill( #"cancelMaintainCombat" );
    }
    
    wait randomfloatrange( 0, var_1dd507e22c604dcf );
    agent.disabledropfromcombat = 0;
    agent.var_a2181954345d15e9 = 0;
    
    if ( controlleanout && isalive( agent ) && agent._blackboard )
    {
        agent._blackboard.var_f74fb3b375109c97 = 0;
    }
}

// Namespace ai_behavior
// Params 5
// Checksum 0xf0f53bef, Offset: 0x25ce
// Size: 0x226
function behavior_pushplayer( player, agent, var_9bc63c17711bfd10 = 15, var_a0e2e05358801372 = 30, subarea )
{
    if ( !isagent( agent ) )
    {
        return;
    }
    
    agent endon( #"death" );
    player endon( #"death_or_disconnect" );
    agent.pushingplayer = 1;
    
    if ( agent.vehicle )
    {
        while ( agent.vehicle )
        {
            wait 1;
        }
    }
    
    agent enemy::bt_set_stealth_state( "combat", undefined );
    agent thread function_d5e7cf61659cb6e( agent, var_a0e2e05358801372, 2 );
    starlevel = utility::callsharedfunc( #"starsystem", #"hash_e7536c049ffc3673", subarea.poiname ) ?? 1;
    goalradius = level.reinforcementoptions.var_3c17fb08cc27f877[ starlevel ];
    originvariance = goalradius;
    
    while ( player.compromised )
    {
        var_9d0ff85a7a7d307f = 0;
        var_5183f77657167773 = 0;
        
        if ( distance( agent.origin, player.origin ) < 12500 )
        {
            var_9d0ff85a7a7d307f = 1;
        }
        
        if ( distancesquared( agent.goalpos, player.origin ) > 1048576 )
        {
            var_5183f77657167773 = 1;
        }
        
        if ( var_9d0ff85a7a7d307f && var_5183f77657167773 )
        {
            agent thread behavior_combatRushOrigin( agent, player.origin, originvariance, goalradius );
        }
        
        wait var_9bc63c17711bfd10;
    }
    
    if ( distance( agent.origin, player.origin ) < 12500 && distancesquared( agent.goalpos, player.origin ) > 262144 )
    {
        agent thread behavior_combatRushOrigin( agent, player.origin, 1024, 1024 );
    }
    
    agent notify( #"cancelMaintainCombat" );
    agent.pushingplayer = 0;
}

// Namespace ai_behavior
// Params 1
// Checksum 0xfea01ff1, Offset: 0x27fc
// Size: 0x9a
function function_cda4be962775bad7( pathstructarray )
{
    foreach ( pathstruct in pathstructarray )
    {
        if ( pathstruct.claimed )
        {
            continue;
        }
        
        pathstruct.claimed = 1;
        return pathstruct;
    }
}

// Namespace ai_behavior
// Params 1
// Checksum 0xe956c1d3, Offset: 0x289f
// Size: 0x1da
function function_f9ddb917447a3aee( agent )
{
    agent endon( #"death" );
    var_e12b9532c99264bd = getdvarint( @"hash_401ebd6ca7f17d87", 0 );
    
    while ( true )
    {
        if ( [[ agent.fnisinstealthidle ]]() )
        {
            if ( agent.leftidle )
            {
                agent.leftidle = 0;
                function_8e2d27e509a0d4d3( agent );
            }
            
            agent.var_f201afcfca83cb9e = 0;
        }
        else if ( [[ agent.fnisinstealthinvestigate ]]() )
        {
            agent.leftidle = 1;
            agent.var_f201afcfca83cb9e = 0;
        }
        else if ( [[ agent.fnisinstealthcombat ]]() )
        {
            agent.leftidle = 1;
            agent.var_f201afcfca83cb9e = 0;
            
            if ( var_e12b9532c99264bd <= 0 )
            {
                wait 5;
                continue;
            }
            
            if ( isdefined( agent.behaviorpackage ) && agent.behaviorpackage.behavior == "guard" )
            {
                wait 5;
                continue;
            }
            
            if ( isdefined( agent.enemy ) )
            {
                agent getenemyinfo( agent.enemy );
                
                if ( issubstr( agent.script_stealthgroup, "fortress" ) )
                {
                    wait 10;
                    continue;
                }
                
                roll = randomint( 100 );
                
                if ( roll > var_e12b9532c99264bd )
                {
                    _setgoalpos( agent.enemy.origin, 1000 );
                }
                
                wait 10;
            }
        }
        else if ( [[ agent.fnisinstealthhunt ]]() )
        {
            agent.leftidle = 1;
            
            if ( !agent.var_f201afcfca83cb9e && level.var_8c351edc899ab15e )
            {
                agent thread function_2a431b3c96f629c1( agent );
            }
        }
        
        wait 5;
    }
}

// Namespace ai_behavior
// Params 1
// Checksum 0x5b01cf32, Offset: 0x2a81
// Size: 0x1a8
function function_2a431b3c96f629c1( agent )
{
    self notify( #"hash_119fa332a26e2b37" );
    self endon( #"hash_119fa332a26e2b37" );
    agent endon( #"death" );
    agent endon( #"stealth_combat" );
    agent endon( #"startCombatRush" );
    agent endon( #"hash_38f3389d2550761b" );
    interval = 1;
    curtime = 0;
    agent.var_f201afcfca83cb9e = 1;
    
    while ( curtime < level.var_4bf7c002c2c0e0a8 )
    {
        wait interval;
        curtime += interval;
        
        if ( agent.combatrushing )
        {
            return;
        }
    }
    
    groupmembers = function_87885190c2114c94( agent.script_stealthgroup );
    
    foreach ( member in groupmembers )
    {
        if ( isalive( member ) && !isint( member ) && [[ member.fnisinstealthhunt ]]() )
        {
            member notify( #"hash_38f3389d2550761b" );
            member enemy::bt_set_stealth_state( "idle", undefined );
            member.stealth_idledemeanor = "patrol";
            member.var_b52fca22f7f1e144 = "alert";
            member.var_7a84781005a5b751 = 0;
            member.var_f201afcfca83cb9e = 0;
        }
    }
}

// Namespace ai_behavior
// Params 1
// Checksum 0x76d55653, Offset: 0x2c31
// Size: 0x162
function function_8e2d27e509a0d4d3( agent )
{
    if ( !isdefined( agent.behaviorpackage ) )
    {
        function_2aa2d25463c152b4( agent );
    }
    
    if ( agent.behaviorpackage.behavior == "patrol" )
    {
        agentarray = [];
        
        foreach ( otheragent in agent.behaviorpackage.var_2079bcd3b73e0438 )
        {
            if ( isalive( otheragent ) && isdefined( agent.behaviorpackage ) && isdefined( otheragent.behaviorpackage ) && isdefined( otheragent.behaviorpackage.pathstruct ) && agent.behaviorpackage.pathstruct == otheragent.behaviorpackage.pathstruct )
            {
                agentarray[ agentarray.size ] = otheragent;
            }
        }
        
        agent.behaviorpackage.var_2079bcd3b73e0438 = agentarray;
    }
    
    behavior_executebehaviorpackage( agent );
}

// Namespace ai_behavior
// Params 8
// Checksum 0xf8e1a92d, Offset: 0x2d9b
// Size: 0x148
function function_556a769454945ed0( agent, var_4d7e648c9d0ab87a, originvariance, goalradiusoverride, var_349676481fc57c94, var_922c962b84963468, rushgroup, var_9110dea815bfb02b )
{
    agent endon( #"death" );
    var_deca68afcb94b42c = var_4d7e648c9d0ab87a;
    function_6e0cb9d89b94ba96( agent, var_deca68afcb94b42c, originvariance, goalradiusoverride, var_349676481fc57c94, var_922c962b84963468, rushgroup, var_9110dea815bfb02b );
    
    foreach ( index, reinforceorigin in var_4d7e648c9d0ab87a )
    {
        agent thread behavior_combatRushOrigin( agent, reinforceorigin, originvariance, goalradiusoverride, var_349676481fc57c94, var_922c962b84963468, rushgroup, 1, var_9110dea815bfb02b );
        agent waittill( #"hash_66eb8219383213f4" );
        var_deca68afcb94b42c = arrayremove( var_deca68afcb94b42c, reinforceorigin );
        function_6e0cb9d89b94ba96( agent, var_deca68afcb94b42c, originvariance, goalradiusoverride, var_349676481fc57c94, var_922c962b84963468, rushgroup, var_9110dea815bfb02b );
        waitframe();
        
        if ( !isdefined( var_4d7e648c9d0ab87a[ index + 1 ] ) )
        {
            if ( isdefined( var_9110dea815bfb02b ) )
            {
                [[ var_9110dea815bfb02b ]]( agent );
                continue;
            }
            
            agent thread behavior_GuardWander( agent, var_349676481fc57c94, originvariance, reinforceorigin );
        }
    }
}

// Namespace ai_behavior
// Params 11
// Checksum 0xbd084c51, Offset: 0x2eeb
// Size: 0x692
function behavior_combatRushOrigin( agent, reinforceorigin, originvariance = 128, goalradiusoverride = 256, var_349676481fc57c94 = 768, var_922c962b84963468 = 1, rushgroup, var_36097a64e5b87849, var_9110dea815bfb02b, targetent, patrolgroupname )
{
    if ( !isalive( agent ) || !isdefined( reinforceorigin ) )
    {
        return;
    }
    
    if ( isdefined( reinforceorigin ) && !isvector( reinforceorigin ) )
    {
        return;
    }
    
    if ( agent.behaviorpackage.behavior != "combatRush" )
    {
        agent.var_fec5f738525a9585 = agent.behaviorpackage;
    }
    
    agent leaveinteraction();
    
    if ( isagent( agent ) && distance( agent.origin, reinforceorigin ) > 12500 )
    {
        assertmsg( "<dev string:x10a>" + reinforceorigin + "<dev string:x143>" + agent.origin + "<dev string:x169>" );
        
        /#
            print3d( agent.origin, "<dev string:x16b>", ( 1, 0, 0 ), 1, 5, 60, 1 );
            level thread debug_utility::drawsphere( agent.origin, 256, 60, ( 0, 1, 0 ) );
            level thread debug_utility::drawsphere( reinforceorigin, 256, 60, ( 1, 1, 0 ) );
            level thread debug_utility::drawline( agent.origin, reinforceorigin, 60, ( 1, 1, 0 ) );
        #/
        
        agent thread behavior_GuardWander( agent, 1024 );
        return;
    }
    
    if ( !var_36097a64e5b87849 )
    {
        function_f776bf0051e1b3e5( agent, reinforceorigin, originvariance, goalradiusoverride, var_349676481fc57c94, var_922c962b84963468, rushgroup, var_9110dea815bfb02b, patrolgroupname );
    }
    
    if ( isint( agent ) )
    {
        return;
    }
    
    agent endon( #"death" );
    agent endon( #"hash_7078c4bdb4d4c709" );
    agent notify( #"startCombatRush" );
    agent notify( #"endcqb" );
    agent.combatrushing = 1;
    agent.stealth_idledemeanor = "combat";
    agent.var_b52fca22f7f1e144 = "combat";
    
    if ( !isdefined( patrolgroupname ) && level.var_eba22ed94ea6dae9 && level.var_3785341350ae5ae7 )
    {
        patrolgroupname = ai_formation::function_e9aabb85b0d12949();
    }
    
    if ( isdefined( patrolgroupname ) )
    {
        agent clearbtgoal( 0 );
        agent clearbtgoal( 1 );
        agent clearbtgoal( 3 );
        var_70f3cb4ca4223d26 = 0;
        
        if ( isdefined( level.var_efaf119164401d47[ patrolgroupname ] ) )
        {
            var_70f3cb4ca4223d26 = 1;
        }
        
        ai_group_patrol::function_180fa7e21b662f2f( patrolgroupname, agent, 3 );
        
        if ( !var_70f3cb4ca4223d26 )
        {
            wait 1;
            thread ai_group_patrol::set_goal( patrolgroupname, reinforceorigin );
        }
        
        wait 2;
        msg = agent utility::waittill_any_return( "bt_goal" );
    }
    else
    {
        navadjustedorigin = reinforceorigin;
        
        if ( originvariance > 0 )
        {
            navadjustedorigin += ( randomfloatrange( -1 * originvariance, originvariance ), randomfloatrange( -1 * originvariance, originvariance ), 0 );
        }
        
        navadjustedorigin = function_b49820d3792f8b12( navadjustedorigin );
        
        if ( isdefined( agent.script_stealthgroup ) )
        {
            agent.var_1d328097c8f5909c = navadjustedorigin;
        }
        
        agent function_4a3c03bb49dd5d76( navadjustedorigin, goalradiusoverride, !var_922c962b84963468, "behavior_combatRushOrigin" );
        
        while ( true )
        {
            dist = distance2d( agent.origin, navadjustedorigin );
            time = max( dist / 50, 10 );
            msg = "badMessage";
            
            while ( agent pathdisttogoal() == 0 )
            {
                waitframe();
            }
            
            if ( var_922c962b84963468 )
            {
                msg = agent utility::waittill_any_timeout( time, "goal", "goal_reached", "bt_goal" );
            }
            else
            {
                msg = agent utility::waittill_any_timeout( time, "goal", "goal_reached", "bad_path", "endBadPathHandler", "bt_goal" );
                agent notify( #"endBadPathHandler" );
            }
            
            if ( msg != "bt_goal" || distance2d( agent.origin, navadjustedorigin ) < goalradiusoverride )
            {
                break;
            }
        }
    }
    
    if ( agent.goalradius > var_349676481fc57c94 )
    {
        updatedgoalradius = agent.goalradius;
    }
    else
    {
        updatedgoalradius = var_349676481fc57c94;
    }
    
    agent thread function_b92ab5b3325ac1f1( agent, 1, updatedgoalradius );
    
    if ( !var_36097a64e5b87849 )
    {
        var_cd782f5a1e1f59bb = 0;
        
        if ( isdefined( var_9110dea815bfb02b ) )
        {
            [[ var_9110dea815bfb02b ]]( agent, targetent );
        }
        else if ( agent.var_fec5f738525a9585 )
        {
            wait randomfloatrange( 3, 6 );
            
            if ( isdefined( agent.var_fec5f738525a9585 ) )
            {
                if ( isdefined( agent.var_fec5f738525a9585.origin ) && distance2dsquared( agent.var_fec5f738525a9585.origin, agent.origin ) > 262144 )
                {
                    agent function_4a3c03bb49dd5d76( agent.var_fec5f738525a9585.origin, 256, "behavior_combatRushOrigin" );
                    agent waittill( #"goal" );
                }
                
                agent.var_fec5f738525a9585.var_12289852ec70e858 = 1;
                agent.startinteractionimmediate = 0;
                agent.behaviorpackage = agent.var_fec5f738525a9585;
                
                if ( ![[ agent.fnisinstealthcombat ]]() )
                {
                    behavior_executebehaviorpackage( agent );
                }
            }
            else
            {
                var_cd782f5a1e1f59bb = 1;
            }
        }
        else
        {
            var_cd782f5a1e1f59bb = 1;
        }
        
        if ( var_cd782f5a1e1f59bb )
        {
            random_x = randomfloatrange( 512, 1024 ) * ( randomint( 100 ) > 50 ? 1 : -1 );
            random_y = randomfloatrange( 512, 1024 ) * ( randomint( 100 ) > 50 ? 1 : -1 );
            var_8e5c08510f32db68 = ( reinforceorigin[ 0 ] + random_x, reinforceorigin[ 1 ] + random_y, reinforceorigin[ 2 ] );
            var_8e5c08510f32db68 = agent getclosestreachablepointonnavmesh( var_8e5c08510f32db68, 0 );
            agent clearbtgoal( 0 );
            agent clearbtgoal( 1 );
            agent clearbtgoal( 3 );
            function_7b154a7c7eb87672( agent, var_8e5c08510f32db68, 512, originvariance );
            
            if ( ![[ agent.fnisinstealthcombat ]]() )
            {
                behavior_executebehaviorpackage( agent );
            }
        }
    }
    
    agent notify( #"hash_66eb8219383213f4" );
    
    if ( agent.var_a2181954345d15e9 )
    {
        agent notify( #"cancelMaintainCombat" );
    }
    
    agent.var_1e0ecc16c74773d8 = 0;
}

// Namespace ai_behavior
// Params 5
// Checksum 0x253b3d4f, Offset: 0x3585
// Size: 0xc9
function function_b92ab5b3325ac1f1( agent, var_bf76e1b2dd0b2e6f, var_eaef7e6ae5e721d4, var_62f4d3dfa8470174, var_e683f37894236a3a )
{
    agent endon( #"death" );
    agent notify( #"hash_46ea59967ccb08dd" );
    agent clearbtgoal( 0 );
    agent clearbtgoal( 1 );
    agent function_7bbd01e514ea0578( var_eaef7e6ae5e721d4 );
    agent.combatrushing = 0;
    
    if ( !var_bf76e1b2dd0b2e6f )
    {
        function_2aa2d25463c152b4( agent );
        
        if ( !isdefined( var_62f4d3dfa8470174 ) )
        {
            var_62f4d3dfa8470174 = 2;
        }
        
        if ( !isdefined( var_e683f37894236a3a ) )
        {
            var_e683f37894236a3a = 8;
        }
        
        wait randomintrange( var_62f4d3dfa8470174, var_e683f37894236a3a );
    }
    
    agent notify( #"endBadPathHandler" );
    
    if ( isdefined( agent.script_stealthgroup ) )
    {
        function_85d73c227497b93b( agent.script_stealthgroup );
    }
}

// Namespace ai_behavior
// Params 6
// Checksum 0x715a589, Offset: 0x3656
// Size: 0xe9
function function_ec923793c93489ea( agent, abortdistance, validtargetdist, navadjustedorigin, var_922c962b84963468, var_36097a64e5b87849 )
{
    agent notify( #"hash_46ea59967ccb08dd" );
    agent endon( #"hash_46ea59967ccb08dd" );
    
    if ( !isdefined( validtargetdist ) )
    {
        validtargetdist = 1024;
    }
    
    while ( agent pathdisttogoal() == 0 )
    {
        waitframe();
    }
    
    waitframe();
    
    while ( agent pathdisttogoal() > min( 128, abortdistance ) || agent.combatrushing )
    {
        if ( agent isknownenemyinradius( agent.origin, validtargetdist ) && agent.combatrushing )
        {
            agent thread function_b72d8af48880734d( validtargetdist, agent.scriptgoalpos, var_922c962b84963468, var_36097a64e5b87849 );
            agent.combatrushing = 0;
            agent notify( #"hash_7078c4bdb4d4c709" );
        }
        
        waitframe();
    }
}

// Namespace ai_behavior
// Params 4
// Checksum 0x459e162e, Offset: 0x3747
// Size: 0x14e
function function_b72d8af48880734d( validtargetdist, navadjustedorigin, var_922c962b84963468, var_36097a64e5b87849 )
{
    self notify( #"engaging_nearby" );
    self endon( #"engaging_nearby" );
    self endon( #"death" );
    self setbtgoalpos( 1, self.origin );
    self setbtgoalradius( 1, validtargetdist );
    anchor = self.origin;
    self requestcoverfind( 0, 0 );
    losttimer = 3;
    has_enemy = 1;
    
    while ( has_enemy )
    {
        while ( self isknownenemyinradius( anchor, validtargetdist ) )
        {
            wait 2;
        }
        
        curtime = 0;
        
        for ( has_enemy = 0; curtime <= losttimer && !has_enemy ; has_enemy = 1 )
        {
            wait 1;
            curtime++;
            
            if ( self isknownenemyinradius( anchor, validtargetdist ) )
            {
            }
        }
    }
    
    self clearbtgoal( 1 );
    waitframe();
    
    /#
        if ( getdvarint( @"hash_ed4743622c486038", 0 ) )
        {
            print3d( self.origin + ( 0, 0, 100 ), "<dev string:x18a>", ( 1, 1, 1 ), 1, 2, 300, 1 );
        }
    #/
    
    thread behavior_combatRushOrigin( self, navadjustedorigin, 0, undefined, undefined, var_922c962b84963468, undefined, var_36097a64e5b87849 );
}

// Namespace ai_behavior
// Params 1
// Checksum 0xdf398034, Offset: 0x389d
// Size: 0x9d
function function_85d73c227497b93b( groupname )
{
    group = group::getgroup( groupname );
    
    foreach ( member in group.members )
    {
        member notify( #"endBadPathHandler" );
    }
}

// Namespace ai_behavior
// Params 1
// Checksum 0x1ff26e4a, Offset: 0x3942
// Size: 0x2b
function function_87885190c2114c94( groupname )
{
    group = group::getgroup( groupname );
    return group.members;
}

// Namespace ai_behavior
// Params 1
// Checksum 0xf2df5096, Offset: 0x3976
// Size: 0x70
function ai_watchforbadpath( agent )
{
    level endon( #"game_ended" );
    agent endon( #"death" );
    agent endon( #"endBadPathHandler" );
    
    while ( true )
    {
        agent waittill( #"bad_path", badpathpos );
        [[ level.ai_badPathHandler ]]( agent, badpathpos );
        agent notify( #"endBadPathHandler" );
    }
}

// Namespace ai_behavior
// Params 2
// Checksum 0x91a9d322, Offset: 0x39ee
// Size: 0x192
function ai_badPathHandler( agent, badpathpos )
{
    agent notify( #"hash_7078c4bdb4d4c709" );
    
    if ( isdefined( agent.vehicle ) )
    {
        return;
    }
    
    possiblelocs = level.var_3844b0a832d9229d;
    origin = undefined;
    
    if ( possiblelocs && possiblelocs.size > 0 )
    {
        possibleloc = function_47c86977a18df38b( possiblelocs, badpathpos, 12500 );
        
        if ( isdefined( possibleloc ) )
        {
            origin = possibleloc.origin;
        }
        else
        {
            origin = agent.origin;
        }
    }
    else
    {
        origin = agent.origin;
    }
    
    dist = distance( agent.origin, origin );
    
    if ( dist >= 12500 )
    {
        assertmsg( "<dev string:x1a0>" + dist + "<dev string:xd7>" + origin + "<dev string:xe2>" + agent.origin );
        agent thread behavior_GuardWander( agent, 1024 );
    }
    else
    {
        agent function_4a3c03bb49dd5d76( origin, 2048, undefined, "ai_badPathHandler" );
        agent setbtgoalpos( 0, origin );
        agent setbtgoalpos( 1, origin );
    }
    
    if ( false )
    {
        thread debug::drawsphere( agent.origin, 32, 15, ( 1, 0, 1 ) );
        thread debug::drawsphere( origin, 32, 15, ( 1, 0, 1 ) );
        thread debug_utility::drawline( agent.origin, origin, 15, ( 1, 1, 0 ) );
    }
}

// Namespace ai_behavior
// Params 4
// Checksum 0x27d1ed86, Offset: 0x3b88
// Size: 0x2cc, Type: bool
function function_628be322cfae6d24( spawnpos, spawnradius, checkradius = 1000, spawnheight )
{
    var_c8791386f56d8c07 = getdvarfloat( @"hash_7cea12faaeb9d47" );
    checkinfluence = 0;
    
    if ( var_c8791386f56d8c07 > 0 )
    {
        checkinfluence = ( var_c8791386f56d8c07 - checkradius ) / var_c8791386f56d8c07;
    }
    
    influence = getplayerinfluenceatposition( spawnpos, 0 );
    
    if ( influence > checkinfluence )
    {
        if ( spawnheight > 0 )
        {
            humanheightoffset = ( 0, 0, spawnheight );
        }
        else
        {
            humanheightoffset = ( 0, 0, 60 );
        }
        
        players = utility::playersincylinder( spawnpos, checkradius );
        
        if ( players.size >= 9 )
        {
            return false;
        }
        
        foreach ( player in players )
        {
            visibility = 0;
            playereyepos = player geteye();
            
            if ( spawnradius > 100 )
            {
                spawntoplayer = player.origin - spawnpos;
                
                if ( length( spawntoplayer ) < spawnradius + 20 )
                {
                    return false;
                }
                
                leftedge = spawnradius * vectornormalize( rotatevector( spawntoplayer, ( 0, 90, 0 ) ) );
                rightedge = spawnradius * vectornormalize( rotatevector( spawntoplayer, ( 0, -90, 0 ) ) );
                leftedge = getclosestpointonnavmesh( spawnpos + leftedge );
                rightedge = getclosestpointonnavmesh( spawnpos + rightedge );
                leftvisibility = 0;
                rightvisibility = 0;
                middlevisibility = 0;
                
                if ( utility::within_fov( player.origin, player.angles, leftedge, 0 ) )
                {
                    leftvisibility = spawnsighttrace( undefined, leftedge + humanheightoffset, playereyepos );
                }
                
                if ( utility::within_fov( player.origin, player.angles, rightedge, 0 ) )
                {
                    rightvisibility = spawnsighttrace( undefined, rightedge + humanheightoffset, playereyepos );
                }
                
                if ( utility::within_fov( player.origin, player.angles, spawnpos, 0 ) )
                {
                    middlevisibility = spawnsighttrace( undefined, spawnpos + humanheightoffset, playereyepos );
                }
                
                visibility = max( max( leftvisibility, rightvisibility ), middlevisibility );
            }
            else if ( utility::within_fov( player.origin, player.angles, spawnpos, 0 ) )
            {
                visibility = spawnsighttrace( undefined, spawnpos + humanheightoffset, playereyepos );
            }
            
            if ( visibility > 0.1 )
            {
                return false;
            }
        }
    }
    
    return true;
}

// Namespace ai_behavior
// Params 2
// Checksum 0x7fd41f80, Offset: 0x3e5d
// Size: 0x2a5
function function_c916e757809745f2( origin, subarea )
{
    var_7237854e3be197ca = origin;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    level.var_2cd6aaf6ae3a56bb++;
    
    if ( level.var_2cd6aaf6ae3a56bb % level.var_1cbf5a9865b66dea == 0 )
    {
        possibleplayertargets = [];
        var_81af5dce2020a2f = level.agentarray;
        
        if ( poi::poi_issystemactive() )
        {
            budgetname = subarea.areaname + "_" + subarea.subareaname;
            var_81af5dce2020a2f = function_a664b3eb3bcb4e15( budgetname, "everybody" );
        }
        
        foreach ( agent in var_81af5dce2020a2f )
        {
            if ( isint( agent ) )
            {
                continue;
            }
            
            if ( isalive( agent.enemy ) && isplayer( agent.enemy ) )
            {
                possibleplayertargets[ possibleplayertargets.size ] = agent.enemy;
            }
        }
        
        if ( possibleplayertargets.size > 0 )
        {
            player = utility::array_random( possibleplayertargets );
            return player.origin;
        }
    }
    
    if ( poi::poi_issystemactive() )
    {
        potentialnodes = sortbydistance( level.heli_unloadnodes, subarea.volume.origin );
        
        if ( !isdefined( potentialnodes[ 0 ] ) || distance2dsquared( potentialnodes[ 0 ].origin, subarea.volume.origin ) > 9000000 )
        {
            return;
        }
        
        tempnodes = [];
        
        foreach ( node in potentialnodes )
        {
            if ( distance2dsquared( node.origin, subarea.volume.origin ) < 9000000 )
            {
                tempnodes[ tempnodes.size ] = node;
                continue;
            }
            
            break;
        }
        
        return utility::array_random( tempnodes ).origin;
    }
}

// Namespace ai_behavior
// Params 3
// Checksum 0x5dae554a, Offset: 0x410a
// Size: 0x40
function function_dd20baf66d4e59c3( agent, origin, radius )
{
    agent endon( #"death" );
    
    while ( true )
    {
        wait 4;
        function_4a3c03bb49dd5d76( origin, radius );
    }
}

// Namespace ai_behavior
// Params 1
// Checksum 0xcfa25754, Offset: 0x4152
// Size: 0x109
function function_6908997e400bc2ad( agent )
{
    level endon( #"game_ended" );
    agent endon( #"death" );
    agent endon( #"alerted_to_player" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            if ( isalive( player ) )
            {
                if ( function_1fa9762560af683b( agent, player ) )
                {
                    agent.goalradius = 1024;
                    agent.dont_enter_combat = 0;
                    agent.combatmode = "cover";
                    agent setcanusecover( 1 );
                    agent notify( #"alerted_to_player" );
                    return;
                }
            }
        }
        
        wait 0.1;
    }
}

// Namespace ai_behavior
// Params 1
// Checksum 0x2fda77bd, Offset: 0x4263
// Size: 0x86
function function_ffdd5c3ea89c08e9( agent )
{
    level endon( #"game_ended" );
    agent endon( #"death" );
    agent endon( #"alerted_to_player" );
    agent waittill( #"damage", idamage, eattacker );
    agent.goalradius = 250;
    agent.dont_enter_combat = 0;
    agent setcanusecover( 0 );
    agent notify( #"alerted_to_player" );
}

// Namespace ai_behavior
// Params 2
// Checksum 0x8e2df205, Offset: 0x42f1
// Size: 0x58, Type: bool
function function_1fa9762560af683b( agent, player )
{
    incloserange = distance( agent.origin, player.origin ) <= 256;
    inplainsight = agent cansee( player );
    return incloserange && inplainsight;
}

// Namespace ai_behavior
// Params 1
// Checksum 0x5d161d1a, Offset: 0x4352
// Size: 0x1b5
function function_af0c2637d8cb3c96( event )
{
    if ( !level.var_477715688f562bf0 )
    {
        return;
    }
    
    if ( event.receiver.agentteam != event.entity.team )
    {
        return;
    }
    
    if ( ai_fortress::function_a38917c33bb50ae3( event.receiver.origin ) )
    {
        return;
    }
    
    investigatingagent = event.receiver;
    corpse = event.entity;
    setcorpseseen( corpse, 0 );
    investigatingagent endon( #"death" );
    corpseorigin = getcorpseorigin( corpse );
    wait 3;
    nearbyplayers = ai_reinforcements::function_770007e7eafcc318( investigatingagent.origin, 1 );
    temparray = [];
    
    foreach ( player in nearbyplayers )
    {
        if ( ai_reinforcements::function_a97a541ec800e47c( player, 1, 1, 100, 32, corpseorigin ) )
        {
            temparray[ temparray.size ] = player;
        }
    }
    
    nearbyplayers = temparray;
    
    if ( !investigatingagent dmz_ai::function_fb0f68f6b97f7f6c() )
    {
        thread ai_reinforcements::function_90d71d4c606852e2( "enemy_found_body", nearbyplayers );
    }
    
    /#
        if ( level.var_95a3e1453148b015 )
        {
            printtoscreen2d( 550, 500, "<dev string:x1e2>", ( 1, 0, 0 ), 2, 100 );
        }
    #/
}

// Namespace ai_behavior
// Params 1
// Checksum 0x87ac2bf0, Offset: 0x450f
// Size: 0x92
function function_93267155d194b847( event )
{
    if ( !level.var_477715688f562bf0 )
    {
        return;
    }
    
    if ( event.receiver.agentteam != event.entity.team )
    {
        return;
    }
    
    if ( ai_fortress::function_a38917c33bb50ae3( event.receiver.origin ) )
    {
        return;
    }
    
    event.receiver endon( #"death" );
    event.receiver thread function_b060a593549234a9( event );
}

// Namespace ai_behavior
// Params 1
// Checksum 0xd3b9ccc5, Offset: 0x45a9
// Size: 0x217
function function_b060a593549234a9( event )
{
    investigatingagent = event.receiver;
    corpse = event.entity;
    level endon( #"game_ended" );
    investigatingagent endon( #"death" );
    investigatingagent.startinteractionimmediate = 0;
    investigatingagent.var_88af750d8cd349c1 = 0;
    corpseorigin = getcorpseorigin( corpse );
    investigatingagent thread function_4a3c03bb49dd5d76( corpseorigin, 16 );
    
    /#
    #/
    
    wait 2;
    
    if ( isdefined( corpse ) )
    {
        setcorpseseen( corpse, 1 );
        setcorpsefound( corpse, 1 );
    }
    
    if ( !investigatingagent dmz_ai::function_fb0f68f6b97f7f6c() )
    {
        investigatingagent thread function_d8cf7f7e0992841b( investigatingagent, 4, 5, "deadbody_investigate01", corpseorigin );
    }
    
    if ( !isdefined( investigatingagent.subarea ) )
    {
        investigatingagent.subarea = utility::callsharedfunc( #"poi", #"hash_8dbb0d45f903ae1c", investigatingagent.origin );
    }
    
    wait 6;
    nearbyplayers = ai_reinforcements::function_770007e7eafcc318( investigatingagent.origin, 1 );
    temparray = [];
    
    foreach ( player in nearbyplayers )
    {
        if ( ai_reinforcements::function_a97a541ec800e47c( player, 1, 1, 6, 768, corpseorigin ) )
        {
            temparray[ temparray.size ] = player;
        }
    }
    
    nearbyplayers = temparray;
    
    if ( !investigatingagent dmz_ai::function_fb0f68f6b97f7f6c() )
    {
        thread ai_reinforcements::function_90d71d4c606852e2( "enemy_report_body", nearbyplayers, 0.5 );
    }
    
    /#
        if ( level.var_95a3e1453148b015 )
        {
            printtoscreen2d( 550, 500, "<dev string:x20d>", ( 1, 0, 0 ), 2, 100 );
        }
    #/
    
    ai_reinforcements::function_74b2cd4f14144719( investigatingagent.subarea );
}

// Namespace ai_behavior
// Params 3
// Checksum 0x2e64ec, Offset: 0x47c8
// Size: 0xca
function function_6f5f8a55c6841cd9( origin, radius, var_5f8e7e4164bfb5a3 )
{
    agents = utility::function_1b1340a94b43b874( origin, radius, 0 );
    
    if ( !isdefined( var_5f8e7e4164bfb5a3 ) )
    {
        var_5f8e7e4164bfb5a3 = origin;
    }
    
    foreach ( agent in agents )
    {
        if ( agent.unittype == "civilian" )
        {
            continue;
        }
        
        agent aieventlistenerevent( "gunshot", self, var_5f8e7e4164bfb5a3 );
    }
}

// Namespace ai_behavior
// Params 3
// Checksum 0x4052e69, Offset: 0x489a
// Size: 0xf1
function function_d51a816fd9f14805( nodes, optional_arrived_at_node_func, start_moving_func )
{
    assert( isdefined( nodes ) );
    
    if ( isarray( nodes ) && nodes.size < 1 )
    {
        nodes = self.spawnpoint function_c7d14fb0b2ce90bf();
        
        if ( nodes.size == 0 )
        {
            self notify( #"reached_path_end" );
            
            if ( isdefined( optional_arrived_at_node_func ) )
            {
                [[ optional_arrived_at_node_func ]]();
            }
            
            return;
        }
    }
    else if ( !isarray( nodes ) )
    {
        nodes = [ nodes ];
    }
    
    for ( i = 0; i < nodes.size ; i++ )
    {
        if ( isvector( nodes[ i ] ) )
        {
            struct = spawnstruct();
            struct.origin = nodes[ i ];
            struct.angles = ( 0, 0, 0 );
            nodes[ i ] = struct;
        }
    }
    
    function_d1e2d45e96a02013( nodes, optional_arrived_at_node_func, start_moving_func );
}

// Namespace ai_behavior
// Params 0
// Checksum 0xeb03ed39, Offset: 0x4993
// Size: 0x3d
function function_c7d14fb0b2ce90bf()
{
    path_array = function_7e959ca5b630d41();
    
    if ( path_array.size < 1 )
    {
        if ( isdefined( self.target ) )
        {
            path_array = function_d6b572d321be8035( self.target );
        }
    }
    
    return path_array;
}

// Namespace ai_behavior
// Params 1
// Checksum 0x2ecbf564, Offset: 0x49d9
// Size: 0xf4
function function_d6b572d321be8035( target )
{
    goals = getnodearray( target, #targetname );
    new_goals = utility::getstructarray( target, "targetname" );
    
    foreach ( new in new_goals )
    {
        goals[ goals.size ] = new;
    }
    
    new_goals = getentarray( target, #targetname );
    
    for ( i = 0; i < new_goals.size ; i++ )
    {
        new = new_goals[ i ];
        
        if ( !function_c6027ebc9c2e52e( new ) )
        {
            continue;
        }
        
        goals[ goals.size ] = new;
    }
    
    return goals;
}

// Namespace ai_behavior
// Params 1
// Checksum 0xe860b437, Offset: 0x4ad6
// Size: 0x5e, Type: bool
function function_c6027ebc9c2e52e( object )
{
    if ( isspawner( object ) )
    {
        return false;
    }
    
    switch ( object.code_classname )
    {
        case #"hash_1b79c5d9e0f9886a":
        case #"hash_5e0756fcd4e0adcd":
        case #"hash_8040aa10d9cac1e8":
        case #"hash_81903cb95a447b8c":
            return false;
    }
    
    return true;
}

// Namespace ai_behavior
// Params 0
// Checksum 0x1e8dae9e, Offset: 0x4b3d
// Size: 0x58
function function_7e959ca5b630d41()
{
    goals = [];
    
    if ( isdefined( self.script_linkto ) )
    {
        linked_ents = utility::get_linked_ents();
        linked_structs = utility::get_linked_structs();
        linked_nodes = utility::get_linked_nodes();
        goals = arraycombine( linked_ents, linked_structs, linked_nodes );
    }
    
    return goals;
}

// Namespace ai_behavior
// Params 0
// Checksum 0xb27522c4, Offset: 0x4b9e
// Size: 0x77
function _behavior_gotonodeend()
{
    self notify( #"_behavior_gotonodeend" );
    self endon( #"_behavior_gotonodeend" );
    self endon( #"death" );
    level endon( #"game_ended" );
    self.using_goto_node = 1;
    result = utility::waittill_any_return( "reached_path_end", "stop_going_to_node" );
    self.using_goto_node = undefined;
    self.patharray = undefined;
    self.patharrayindex = undefined;
}

// Namespace ai_behavior
// Params 1
// Checksum 0x4cd5dc0c, Offset: 0x4c1d
// Size: 0xbd
function function_1afef6581e887d27( array )
{
    if ( array.size == 1 )
    {
        return array[ 0 ];
    }
    
    array = arrayrandomize( array );
    least_used = array[ 0 ];
    
    if ( !isdefined( least_used.used_time ) )
    {
        least_used.used_time = 0;
    }
    
    for ( i = 0; i < array.size ; i++ )
    {
        node = array[ i ];
        
        if ( !isdefined( node.used_time ) )
        {
            node.used_time = 0;
        }
        
        if ( node.used_time < least_used.used_time )
        {
            least_used = node;
        }
    }
    
    least_used.used_time = gettime();
    return least_used;
}

// Namespace ai_behavior
// Params 2
// Checksum 0xbcce727f, Offset: 0x4ce3
// Size: 0xae
function function_19b8948e17649ad2( node, startnode )
{
    array = [];
    count = 0;
    
    while ( true )
    {
        array[ array.size ] = node;
        count++;
        
        if ( count == 16 )
        {
            break;
        }
        
        if ( function_72000ec2cbeb41e8( node ) )
        {
            break;
        }
        
        if ( !isdefined( node.target ) && !isdefined( node.script_linkto ) )
        {
            break;
        }
        
        nextnode_array = node function_c7d14fb0b2ce90bf();
        
        if ( !nextnode_array.size )
        {
            break;
        }
        
        node = function_1afef6581e887d27( nextnode_array );
        
        if ( node == startnode )
        {
            break;
        }
    }
    
    return array;
}

// Namespace ai_behavior
// Params 3
// Checksum 0x86fee1df, Offset: 0x4d9a
// Size: 0xc5
function function_3be1f2f8802af35b( patharray, optional_arrived_at_node_func, start_moving_func )
{
    self setgoalpath( patharray );
    
    for ( i = 0; i < patharray.size ; i++ )
    {
        index = i;
        tempnode = patharray[ i ];
        self.currentnode = tempnode;
        function_b360902c88b7164b( tempnode );
        patharrayindex = waittill_subgoal();
        
        if ( index == patharray.size - 1 )
        {
            self waittill( #"goal" );
            break;
        }
        
        tempnode notify( #"trigger", self );
        function_58f20d0534ba09df( tempnode, optional_arrived_at_node_func );
        function_22c2b3085fe5e9d1( tempnode );
        function_466588637f6e5702( tempnode, start_moving_func );
    }
}

// Namespace ai_behavior
// Params 1
// Checksum 0xc94e27c6, Offset: 0x4e67
// Size: 0x18, Type: bool
function is_specified_unittype( unittype )
{
    return self.unittype == unittype;
}

// Namespace ai_behavior
// Params 1
// Checksum 0x3a008a5, Offset: 0x4e88
// Size: 0x48
function function_d1c916b412f81db( demeanor )
{
    demeanor = function_3babe2c8966a71eb( demeanor );
    
    if ( is_specified_unittype( "civilian" ) )
    {
        asm_bb::bb_setcivilianstate( demeanor );
        return;
    }
    
    if ( !is_specified_unittype( "juggernaut" ) )
    {
        utility::demeanor_override( demeanor );
    }
}

// Namespace ai_behavior
// Params 1
// Checksum 0x431939d, Offset: 0x4ed8
// Size: 0x43
function function_3babe2c8966a71eb( demeanor )
{
    switch ( demeanor )
    {
        case #"hash_46fdaf04e9be63e4":
        case #"hash_d320ccf96c495f71":
            return "patrol";
        default:
            return demeanor;
    }
}

// Namespace ai_behavior
// Params 1
// Checksum 0xce5699ca, Offset: 0x4f23
// Size: 0xc
function function_b360902c88b7164b( node )
{
    
}

// Namespace ai_behavior
// Params 2
// Checksum 0xc66b37b7, Offset: 0x4f37
// Size: 0x84
function function_58f20d0534ba09df( node, optional_arrived_at_node_func )
{
    if ( isdefined( optional_arrived_at_node_func ) )
    {
        [[ optional_arrived_at_node_func ]]( node );
    }
    
    if ( isdefined( node.script_flag_set ) )
    {
        utility::flag_set( node.script_flag_set );
    }
    
    if ( isdefined( node.script_ent_flag_set ) )
    {
        utility::ent_flag_set( node.script_ent_flag_set );
    }
    
    if ( isdefined( node.script_flag_clear ) )
    {
        utility::flag_clear( node.script_flag_clear );
    }
}

// Namespace ai_behavior
// Params 1
// Checksum 0x353f7350, Offset: 0x4fc3
// Size: 0x12d
function function_22c2b3085fe5e9d1( node )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( !level.global_stealth_broken && !self.entered_combat && isdefined( node.script_animation_type ) )
    {
        var_7fa94724ad3568a4 = undefined;
        var_369611401648c14f = strtok( node.script_animation_type, "," );
        var_7fa94724ad3568a4 = utility::array_random( var_369611401648c14f );
        
        if ( isdefined( var_7fa94724ad3568a4 ) )
        {
            if ( !node.script_looping )
            {
                self.single_loop = 1;
            }
            else
            {
                self.single_loop = undefined;
            }
            
            /#
                print3d( self.origin + ( 0, 0, 64 ), "<dev string:x233>" + node.script_animation_type, ( 1, 1, 0 ), 1, 0.5, 60, 1 );
            #/
            
            self.playing_skit = 1;
            function_5d547737c0bc4f79( node, var_7fa94724ad3568a4 );
            self.playing_skit = undefined;
            
            while ( self.playing_skit )
            {
                wait 0.05;
            }
        }
    }
}

// Namespace ai_behavior
// Params 2
// Checksum 0xfc461e8d, Offset: 0x50f8
// Size: 0x82
function function_5d547737c0bc4f79( node, var_7fa94724ad3568a4 )
{
    self endon( #"death" );
    
    if ( self.single_loop )
    {
        self endon( "patrol_" + var_7fa94724ad3568a4 + "_loop" );
    }
    
    _setgoalpos( node.origin, undefined, 1 );
    self thread [[ level.spawn_skits[ var_7fa94724ad3568a4 ].skit_func ]]();
    
    while ( self.playing_skit )
    {
        wait 0.05;
    }
}

// Namespace ai_behavior
// Params 2
// Checksum 0x9b462cca, Offset: 0x5182
// Size: 0x145
function function_466588637f6e5702( node, start_moving_func )
{
    if ( isdefined( node.script_soundalias ) )
    {
        if ( soundexists( node.script_soundalias ) )
        {
            self playsound( node.script_soundalias );
        }
    }
    
    if ( isdefined( node.script_forcegoal ) )
    {
        function_7bbd01e514ea0578( node.script_forcegoal );
    }
    
    if ( isdefined( self.post_wait_func ) )
    {
        [[ self.post_wait_func ]]();
    }
    
    if ( isdefined( node.script_delay_post ) )
    {
        wait node.script_delay_post;
    }
    
    while ( isdefined( node.script_requires_player ) )
    {
        node.script_requires_player = 0;
        
        if ( function_bffa515489052a6f( node, &function_c7d14fb0b2ce90bf ) )
        {
            node.script_requires_player = 1;
            node notify( #"script_requires_player" );
            break;
        }
        
        wait 0.25;
    }
    
    if ( isdefined( node.script_demeanor_post ) )
    {
        function_d1c916b412f81db( node.script_demeanor_post );
    }
    
    if ( isdefined( start_moving_func ) )
    {
        [[ start_moving_func ]]( node );
    }
    
    if ( node.script_death )
    {
        agent_utils::despawnagent();
    }
    
    if ( node.script_delete )
    {
        self delete();
    }
}

// Namespace ai_behavior
// Params 2
// Checksum 0xfa27880, Offset: 0x52cf
// Size: 0x237
function function_bffa515489052a6f( node, get_target_func )
{
    for ( i = 0; i < level.players.size ; i++ )
    {
        player = level.players[ i ];
        
        if ( distancesquared( player.origin, node.origin ) < distancesquared( self.origin, node.origin ) )
        {
            return 1;
        }
        
        if ( !isdefined( node.script_dist_only ) )
        {
            vec = anglestoforward( self.angles );
            
            if ( isdefined( node.target ) )
            {
                temp = node [[ get_target_func ]]( node.target );
                
                if ( temp.size == 1 )
                {
                    vec = vectornormalize( temp[ 0 ].origin - node.origin );
                }
                else if ( isdefined( node.angles ) )
                {
                    vec = anglestoforward( node.angles );
                }
            }
            else if ( isdefined( node.angles ) )
            {
                vec = anglestoforward( node.angles );
            }
            
            vec2 = [];
            vec2[ vec2.size ] = vectornormalize( player.origin - self.origin );
            
            foreach ( value in vec2 )
            {
                if ( vectordot( vec, value ) > 0 )
                {
                    return 1;
                }
            }
        }
        
        dist = 300;
        
        if ( node.script_requires_player > dist )
        {
            dist = node.script_requires_player;
        }
        
        if ( distancesquared( player.origin, self.origin ) < squared( dist ) )
        {
            return 1;
        }
        
        return 0;
    }
}

// Namespace ai_behavior
// Params 0
// Checksum 0xdad56e4d, Offset: 0x550e
// Size: 0x29
function waittill_subgoal()
{
    self endon( #"goal" );
    self waittill( #"subgoal", index );
    return index;
}

// Namespace ai_behavior
// Params 1
// Checksum 0xf9e8eeb7, Offset: 0x5540
// Size: 0x114, Type: bool
function function_72000ec2cbeb41e8( arrivaltarget )
{
    if ( !isdefined( arrivaltarget ) )
    {
        return true;
    }
    
    if ( !isdefined( arrivaltarget.target ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_delay ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_delay_min ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_delay_max ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_wait ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_wait_add ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_wait_min ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_wait_max ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_flag_wait ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_ent_flag_wait ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_delay_post ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_requires_player ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_idle ) )
    {
        return true;
    }
    
    if ( isdefined( arrivaltarget.script_stopnode ) )
    {
        return true;
    }
    
    return false;
}

// Namespace ai_behavior
// Params 3
// Checksum 0x1c1cc72, Offset: 0x565d
// Size: 0x207
function function_d1e2d45e96a02013( node, optional_arrived_at_node_func, start_moving_func )
{
    self notify( #"stop_going_to_node" );
    self endon( #"stop_going_to_node" );
    self endon( #"death" );
    level endon( #"game_ended" );
    
    if ( !isarray( node ) )
    {
        node = [ node ];
    }
    
    thread _behavior_gotonodeend();
    usingpatharray = 0;
    patharray = undefined;
    startnode = node[ 0 ];
    
    for ( ;; )
    {
        if ( !usingpatharray )
        {
            node = function_1afef6581e887d27( node );
            patharray = function_19b8948e17649ad2( node, startnode );
            
            if ( patharray.size > 1 )
            {
                usingpatharray = 1;
            }
        }
        
        self.currentnode = node;
        
        if ( usingpatharray )
        {
            node = patharray[ patharray.size - 1 ];
            function_3be1f2f8802af35b( patharray, optional_arrived_at_node_func, start_moving_func );
            patharray = undefined;
            usingpatharray = 0;
        }
        else
        {
            function_b360902c88b7164b( node );
            function_2a3690c290c05cd1( node );
            self waittill( #"goal" );
        }
        
        node notify( #"trigger", self );
        function_58f20d0534ba09df( node, optional_arrived_at_node_func );
        function_22c2b3085fe5e9d1( node );
        node utility::script_delay();
        
        if ( isdefined( node.script_flag_wait ) )
        {
            utility::flag_wait( node.script_flag_wait );
        }
        
        if ( isdefined( node.script_ent_flag_wait ) )
        {
            utility::ent_flag_wait( node.script_ent_flag_wait );
        }
        
        node utility::script_wait();
        function_466588637f6e5702( node, start_moving_func );
        
        if ( !isdefined( node.target ) && !isdefined( node.script_linkto ) )
        {
            break;
        }
        
        nextnode_array = node function_c7d14fb0b2ce90bf();
        
        if ( !nextnode_array.size )
        {
            break;
        }
        
        node = nextnode_array;
    }
    
    self notify( #"reached_path_end" );
    
    if ( isdefined( self.script_forcegoal ) )
    {
        return;
    }
    
    volume = self getgoalvolume();
    
    if ( isdefined( volume ) )
    {
        self setgoalvolumeauto( volume, volume function_abd522221ae34ef7() );
    }
}

// Namespace ai_behavior
// Params 0
// Checksum 0xa094a91a, Offset: 0x586c
// Size: 0x24
function function_abd522221ae34ef7()
{
    if ( isdefined( self.goalvolumecoveryaw ) )
    {
        return anglestoforward( ( 0, self.goalvolumecoveryaw, 0 ) );
    }
    
    return;
}

// Namespace ai_behavior
// Params 1
// Checksum 0x5c628e51, Offset: 0x5898
// Size: 0x21
function function_638d8da7c8aaee71( node )
{
    function_8b90cbb5fb2f0d36( node );
    self notify( #"go_to_node_new_goal" );
}

// Namespace ai_behavior
// Params 1
// Checksum 0x30d4254, Offset: 0x58c1
// Size: 0x6f
function function_2a3690c290c05cd1( ent )
{
    if ( isnode( ent ) )
    {
        function_638d8da7c8aaee71( ent );
    }
    else if ( isstruct( ent ) )
    {
        function_b31f9cf70a9dadfd( ent );
    }
    else if ( isent( ent ) )
    {
        function_f6b884f68095b07e( ent );
    }
    
    if ( isstruct( ent ) || isnode( ent ) )
    {
        ent.patrol_stop = function_72000ec2cbeb41e8( ent );
    }
}

// Namespace ai_behavior
// Params 1
// Checksum 0x30bc38f8, Offset: 0x5938
// Size: 0x46
function function_f6b884f68095b07e( ent )
{
    if ( ent.code_classname == "info_volume" )
    {
        self setgoalvolumeauto( ent, ent function_abd522221ae34ef7() );
        self notify( #"go_to_node_new_goal" );
        return;
    }
    
    function_b31f9cf70a9dadfd( ent );
}

// Namespace ai_behavior
// Params 1
// Checksum 0xdd50a67a, Offset: 0x5986
// Size: 0x2a
function function_b31f9cf70a9dadfd( ent )
{
    _setgoalpos( ent.origin );
    self notify( #"go_to_node_new_goal" );
}

// Namespace ai_behavior
// Params 2
// Checksum 0x10c3b41d, Offset: 0x59b8
// Size: 0x61
function function_26b05394190932b2( agent, behaviorpackage )
{
    if ( isagent( agent ) )
    {
        agent.behaviorpackage = behaviorpackage;
        return;
    }
    
    if ( isint( agent ) && isdefined( level.var_87bd0b3632631717[ agent ] ) )
    {
        level.var_87bd0b3632631717[ agent ].behaviorpackage = behaviorpackage;
    }
}

// Namespace ai_behavior
// Params 10
// Checksum 0xb08a38a5, Offset: 0x5a21
// Size: 0x85
function function_2aa2d25463c152b4( agent, origin, var_f7f19be7cc8a29e8, combatcenter, combatradius, var_9e49ac0d46d4a83, var_9b8779fb8afb73af, var_9b6467fb8ad50461, interactionuseradius, var_45a604112622f547 )
{
    behaviorpackage = function_3c539d9c25a3c11( origin, var_f7f19be7cc8a29e8, combatcenter, combatradius, var_9e49ac0d46d4a83, var_9b8779fb8afb73af, var_9b6467fb8ad50461, interactionuseradius, var_45a604112622f547 );
    function_26b05394190932b2( agent, behaviorpackage );
}

// Namespace ai_behavior
// Params 9
// Checksum 0x4e48acff, Offset: 0x5aae
// Size: 0x101
function function_3c539d9c25a3c11( origin, var_f7f19be7cc8a29e8, combatcenter, combatradius, var_9e49ac0d46d4a83, var_9b8779fb8afb73af, var_9b6467fb8ad50461, interactionuseradius, var_45a604112622f547 )
{
    behaviorpackage = spawnstruct();
    behaviorpackage.behavior = "guard";
    behaviorpackage.origin = origin;
    behaviorpackage.var_f7f19be7cc8a29e8 = var_f7f19be7cc8a29e8;
    
    if ( isdefined( combatcenter ) && isdefined( combatradius ) )
    {
        behaviorpackage.combatcenter = combatcenter;
        behaviorpackage.combatradius = combatradius;
    }
    
    behaviorpackage.var_9e49ac0d46d4a83 = var_9e49ac0d46d4a83;
    behaviorpackage.var_9b8779fb8afb73af = var_9b8779fb8afb73af;
    behaviorpackage.var_9b6467fb8ad50461 = var_9b6467fb8ad50461;
    behaviorpackage.interactionuseradius = interactionuseradius;
    behaviorpackage.var_aaf6f0ce2cb6508 = var_45a604112622f547;
    return behaviorpackage;
}

// Namespace ai_behavior
// Params 9
// Checksum 0xc361d21f, Offset: 0x5bb8
// Size: 0x7b
function function_7b154a7c7eb87672( agent, origin, radius, radiusvariance, var_9e49ac0d46d4a83, var_9b8779fb8afb73af, var_9b6467fb8ad50461, interactionuseradius, var_aaf6f0ce2cb6508 )
{
    behaviorpackage = function_410c08c436c905ad( origin, radius, radiusvariance, var_9e49ac0d46d4a83, var_9b8779fb8afb73af, var_9b6467fb8ad50461, interactionuseradius, var_aaf6f0ce2cb6508 );
    function_26b05394190932b2( agent, behaviorpackage );
}

// Namespace ai_behavior
// Params 8
// Checksum 0xbee5693e, Offset: 0x5c3b
// Size: 0xde
function function_410c08c436c905ad( origin, radius, radiusvariance, var_9e49ac0d46d4a83, var_9b8779fb8afb73af, var_9b6467fb8ad50461, interactionuseradius, var_aaf6f0ce2cb6508 )
{
    behaviorpackage = spawnstruct();
    behaviorpackage.behavior = "wander";
    behaviorpackage.origin = origin;
    behaviorpackage.radius = radius;
    behaviorpackage.radiusvariance = radiusvariance;
    behaviorpackage.var_9e49ac0d46d4a83 = var_9e49ac0d46d4a83;
    behaviorpackage.var_9b8779fb8afb73af = var_9b8779fb8afb73af;
    behaviorpackage.var_9b6467fb8ad50461 = var_9b6467fb8ad50461;
    behaviorpackage.interactionuseradius = interactionuseradius;
    behaviorpackage.var_aaf6f0ce2cb6508 = var_aaf6f0ce2cb6508;
    return behaviorpackage;
}

// Namespace ai_behavior
// Params 4
// Checksum 0xb3f0dde6, Offset: 0x5d22
// Size: 0x47
function function_95ada18faf94770a( agent, origin, radius, radiusvariance )
{
    behaviorpackage = function_84680c74cd499085( origin, radius, radiusvariance );
    function_26b05394190932b2( agent, behaviorpackage );
}

// Namespace ai_behavior
// Params 3
// Checksum 0x35ac7428, Offset: 0x5d71
// Size: 0x6b
function function_84680c74cd499085( origin, radius, radiusvariance )
{
    behaviorpackage = spawnstruct();
    behaviorpackage.behavior = "combatwander";
    behaviorpackage.origin = origin;
    behaviorpackage.radius = radius;
    behaviorpackage.radiusvariance = radiusvariance;
    return behaviorpackage;
}

// Namespace ai_behavior
// Params 8
// Checksum 0xc361d242, Offset: 0x5de5
// Size: 0x71
function function_275a3085a93cd3ad( agent, var_2079bcd3b73e0438, pathstruct, combatcenter, combatradius, patrolgroupname, startnodeindex, var_6ad087de43fd7dae )
{
    behaviorpackage = function_a84ed0efdb11fa6a( var_2079bcd3b73e0438, pathstruct, combatcenter, combatradius, patrolgroupname, startnodeindex, var_6ad087de43fd7dae );
    function_26b05394190932b2( agent, behaviorpackage );
}

// Namespace ai_behavior
// Params 7
// Checksum 0xec67cb45, Offset: 0x5e5e
// Size: 0xd3
function function_a84ed0efdb11fa6a( var_2079bcd3b73e0438, pathstruct, combatcenter, combatradius, patrolgroupname, startnodeindex, var_6ad087de43fd7dae )
{
    behaviorpackage = spawnstruct();
    behaviorpackage.behavior = "patrol";
    behaviorpackage.pathstruct = pathstruct;
    behaviorpackage.var_2079bcd3b73e0438 = var_2079bcd3b73e0438;
    
    if ( isdefined( combatcenter ) && isdefined( combatradius ) )
    {
        behaviorpackage.combatcenter = combatcenter;
        behaviorpackage.combatradius = combatradius;
    }
    
    behaviorpackage.patrolgroupname = patrolgroupname;
    behaviorpackage.startnodeindex = startnodeindex;
    behaviorpackage.var_aaf6f0ce2cb6508 = var_6ad087de43fd7dae;
    return behaviorpackage;
}

// Namespace ai_behavior
// Params 9
// Checksum 0xa8113c20, Offset: 0x5f3a
// Size: 0x7b
function function_f776bf0051e1b3e5( agent, reinforceorigin, originvariance, goalradiusoverride, var_349676481fc57c94, var_922c962b84963468, rushgroup, var_9110dea815bfb02b, patrolgroupname )
{
    behaviorpackage = function_f518ee53ac67fece( reinforceorigin, originvariance, goalradiusoverride, var_349676481fc57c94, var_922c962b84963468, rushgroup, var_9110dea815bfb02b, patrolgroupname );
    function_26b05394190932b2( agent, behaviorpackage );
}

// Namespace ai_behavior
// Params 8
// Checksum 0xa63415a5, Offset: 0x5fbd
// Size: 0xde
function function_f518ee53ac67fece( reinforceorigin, originvariance, goalradiusoverride, var_349676481fc57c94, var_922c962b84963468, rushgroup, var_9110dea815bfb02b, patrolgroupname )
{
    behaviorpackage = spawnstruct();
    behaviorpackage.behavior = "combatRush";
    behaviorpackage.reinforceorigin = reinforceorigin;
    behaviorpackage.originvariance = originvariance;
    behaviorpackage.goalradiusoverride = goalradiusoverride;
    behaviorpackage.var_349676481fc57c94 = var_349676481fc57c94;
    behaviorpackage.var_922c962b84963468 = var_922c962b84963468;
    behaviorpackage.rushgroup = rushgroup;
    behaviorpackage.var_9110dea815bfb02b = var_9110dea815bfb02b;
    behaviorpackage.patrolgroupname = patrolgroupname;
    return behaviorpackage;
}

// Namespace ai_behavior
// Params 9
// Checksum 0x8c58d09d, Offset: 0x60a4
// Size: 0x7b
function function_6e0cb9d89b94ba96( agent, var_4d7e648c9d0ab87a, originvariance, goalradiusoverride, var_349676481fc57c94, var_922c962b84963468, rushgroup, var_9110dea815bfb02b, patrolgroupname )
{
    behaviorpackage = function_47e31a3a6941c95b( var_4d7e648c9d0ab87a, originvariance, goalradiusoverride, var_349676481fc57c94, var_922c962b84963468, rushgroup, var_9110dea815bfb02b, patrolgroupname );
    function_26b05394190932b2( agent, behaviorpackage );
}

// Namespace ai_behavior
// Params 8
// Checksum 0x4d511c71, Offset: 0x6127
// Size: 0xde
function function_47e31a3a6941c95b( var_4d7e648c9d0ab87a, originvariance, goalradiusoverride, var_349676481fc57c94, var_922c962b84963468, rushgroup, var_9110dea815bfb02b, patrolgroupname )
{
    behaviorpackage = spawnstruct();
    behaviorpackage.behavior = "combatRushChain";
    behaviorpackage.var_4d7e648c9d0ab87a = var_4d7e648c9d0ab87a;
    behaviorpackage.originvariance = originvariance;
    behaviorpackage.goalradiusoverride = goalradiusoverride;
    behaviorpackage.var_349676481fc57c94 = var_349676481fc57c94;
    behaviorpackage.var_922c962b84963468 = var_922c962b84963468;
    behaviorpackage.rushgroup = rushgroup;
    behaviorpackage.var_9110dea815bfb02b = var_9110dea815bfb02b;
    behaviorpackage.patrolgroupname = patrolgroupname;
    return behaviorpackage;
}

// Namespace ai_behavior
// Params 5
// Checksum 0xa3292b94, Offset: 0x620e
// Size: 0x52
function function_6469bb607db9810f( agent, cqbnodes, var_d772a8f3355e702, var_71df46e3638ed06f, var_b78728c1900ec028 )
{
    behaviorpackage = function_6f83c708c971b902( cqbnodes, var_d772a8f3355e702, var_71df46e3638ed06f, var_b78728c1900ec028 );
    function_26b05394190932b2( agent, behaviorpackage );
}

// Namespace ai_behavior
// Params 4
// Checksum 0x65d13e51, Offset: 0x6268
// Size: 0x82
function function_6f83c708c971b902( cqbnodes, var_d772a8f3355e702, var_71df46e3638ed06f, var_b78728c1900ec028 )
{
    behaviorpackage = spawnstruct();
    behaviorpackage.behavior = "cqb";
    behaviorpackage.cqbnodes = cqbnodes;
    behaviorpackage.var_d772a8f3355e702 = var_d772a8f3355e702;
    behaviorpackage.var_71df46e3638ed06f = var_71df46e3638ed06f;
    behaviorpackage.var_b78728c1900ec028 = var_b78728c1900ec028;
    return behaviorpackage;
}

// Namespace ai_behavior
// Params 6
// Checksum 0xa67c2f58, Offset: 0x62f3
// Size: 0x5d
function function_62f6c7608c9b47d4( agent, var_60c0a7aa474ac04b, origin, goalradius, var_237f941b0d8d1b9a, var_52813ffe13d27b0c )
{
    behaviorpackage = function_67303f3b22bcefad( agent, var_60c0a7aa474ac04b, origin, goalradius, var_237f941b0d8d1b9a, var_52813ffe13d27b0c );
    function_26b05394190932b2( agent, behaviorpackage );
}

// Namespace ai_behavior
// Params 6
// Checksum 0x9f9f9fab, Offset: 0x6358
// Size: 0x94
function function_67303f3b22bcefad( agent, var_60c0a7aa474ac04b, origin, goalradius, var_237f941b0d8d1b9a, var_52813ffe13d27b0c )
{
    behaviorpackage = spawnstruct();
    behaviorpackage.behavior = "boundingOverwatch";
    behaviorpackage.origin = origin;
    behaviorpackage.goalradius = goalradius;
    behaviorpackage.var_237f941b0d8d1b9a = var_237f941b0d8d1b9a;
    behaviorpackage.var_52813ffe13d27b0c = var_52813ffe13d27b0c;
    return behaviorpackage;
}

// Namespace ai_behavior
// Params 9
// Checksum 0x849abec8, Offset: 0x63f5
// Size: 0x7b
function function_4ac94b7dfaad6e92( agent, origin, requiredtags, forbiddentags, interactionmode, var_9b8779fb8afb73af, var_9b6467fb8ad50461, interactionuseradius, var_aaf6f0ce2cb6508 )
{
    behaviorpackage = function_9f72445c611c1b5f( origin, requiredtags, forbiddentags, interactionmode, var_9b8779fb8afb73af, var_9b6467fb8ad50461, interactionuseradius, var_aaf6f0ce2cb6508 );
    function_26b05394190932b2( agent, behaviorpackage );
}

// Namespace ai_behavior
// Params 8
// Checksum 0xc3db98ea, Offset: 0x6478
// Size: 0xde
function function_9f72445c611c1b5f( origin, requiredtags, forbiddentags, interactionmode, var_9b8779fb8afb73af, var_9b6467fb8ad50461, interactionuseradius, var_aaf6f0ce2cb6508 )
{
    behaviorpackage = spawnstruct();
    behaviorpackage.behavior = "forcedInteraction";
    behaviorpackage.origin = origin;
    behaviorpackage.requiredtags = requiredtags;
    behaviorpackage.forbiddentags = forbiddentags;
    behaviorpackage.interactionmode = interactionmode;
    behaviorpackage.var_9b8779fb8afb73af = var_9b8779fb8afb73af;
    behaviorpackage.var_9b6467fb8ad50461 = var_9b6467fb8ad50461;
    behaviorpackage.interactionuseradius = interactionuseradius;
    behaviorpackage.var_aaf6f0ce2cb6508 = var_aaf6f0ce2cb6508;
    return behaviorpackage;
}

// Namespace ai_behavior
// Params 1
// Checksum 0x91dcc538, Offset: 0x655f
// Size: 0x55
function function_342e7d77531fb6e3( agent )
{
    if ( isagent( agent ) )
    {
        return agent.behaviorpackage;
    }
    
    if ( isdefined( level.var_87bd0b3632631717[ agent ] ) && isint( agent ) )
    {
        return level.var_87bd0b3632631717[ agent ].behaviorpackage;
    }
}

// Namespace ai_behavior
// Params 1
// Checksum 0x9f61e885, Offset: 0x65bd
// Size: 0x402
function behavior_executebehaviorpackage( agent )
{
    agent endon( #"death" );
    
    if ( !isdefined( agent.behaviorpackage ) )
    {
        return;
    }
    
    bp = agent.behaviorpackage;
    
    switch ( agent.behaviorpackage.behavior )
    {
        case #"hash_7df245010bdec44e":
            agent thread behavior_GuardStationary( agent, bp.var_f7f19be7cc8a29e8, bp.origin, bp.var_9e49ac0d46d4a83, bp.var_9b8779fb8afb73af, bp.var_9b6467fb8ad50461, bp.interactionuseradius, bp.var_aaf6f0ce2cb6508 );
            break;
        case #"hash_4e0c042fa0220574":
            if ( isdefined( level.overridebehavior_guardwander ) )
            {
                agent thread [[ level.overridebehavior_guardwander ]]( agent, bp.radius, bp.radiusvariance, bp.origin, undefined, undefined, undefined, undefined, undefined, bp.var_aaf6f0ce2cb6508 );
            }
            else
            {
                agent thread behavior_GuardWander( agent, bp.radius, bp.radiusvariance, bp.origin, undefined, bp.var_9e49ac0d46d4a83, bp.var_9b8779fb8afb73af, bp.var_9b6467fb8ad50461, bp.interactionuseradius, bp.var_aaf6f0ce2cb6508 );
            }
            
            break;
        case #"hash_f18555ca1d8ebdc0":
            agent thread behavior_combatWander( agent, bp.radius, bp.radiusvariance, bp.origin );
            break;
        case #"hash_9128327eb51e0b7b":
            startnodeindex = undefined;
            
            if ( isdefined( bp.var_fd204967f81acf49 ) && bp.var_fd204967f81acf49 != -1 )
            {
                startnodeindex = bp.var_fd204967f81acf49;
                bp.var_fd204967f81acf49 = undefined;
            }
            else if ( isdefined( bp.startnodeindex ) )
            {
                startnodeindex = bp.startnodeindex;
            }
            
            level thread behavior_patrol( [ agent ], bp.pathstruct, startnodeindex, undefined, undefined, bp.patrolgroupname );
            agent thread function_5729c009c3042549( agent, undefined, "patrol" );
            break;
        case #"hash_10c1fbec939bdcf7":
            assert( distance( agent.origin, bp.reinforceorigin ) < 12500, "<dev string:x23a>" );
            agent thread behavior_combatRushOrigin( agent, bp.reinforceorigin, bp.originvariance, bp.goalradiusoverride, bp.var_349676481fc57c94, bp.var_922c962b84963468, bp.rushgroup );
            break;
        case #"hash_baf8d28f880e18c":
            agent thread function_556a769454945ed0( agent, bp.var_4d7e648c9d0ab87a, bp.originvariance, bp.goalradiusoverride, bp.var_349676481fc57c94, bp.var_922c962b84963468, bp.rushgroup );
            break;
        case #"hash_1a53266c17b7d481":
            agent thread behavior_cqb( agent, bp.cqbnodes, bp.var_d772a8f3355e702, bp.var_71df46e3638ed06f, bp.var_b78728c1900ec028 );
            break;
        case #"hash_ca822159b667f028":
            agent thread function_5c6cec6f0ce57f4( agent, bp.origin, bp.requiredtags, bp.forbiddentags, bp.interactionmode, bp.var_9b8779fb8afb73af, bp.var_9b6467fb8ad50461, bp.interactionuseradius, bp.var_12289852ec70e858 );
            break;
    }
}

// Namespace ai_behavior
// Params 2
// Checksum 0x621fcb43, Offset: 0x69c7
// Size: 0x6d
function function_52624f664c165308( agent, targetent )
{
    node = agent findbestcovernode( undefined, 0, agent.origin );
    
    if ( isdefined( node ) )
    {
        if ( agent.node != node )
        {
            agent.keepclaimednode = 0;
            agent.keepclaimednodeifvalid = 0;
            agent usecovernode( node );
        }
    }
}

// Namespace ai_behavior
// Params 2
// Checksum 0xbd361369, Offset: 0x6a3c
// Size: 0xb9
function function_5b781b37954f36ba( covernodetag, agents )
{
    if ( !agents )
    {
        return;
    }
    
    if ( !isarray( agents ) && isagent( agents ) )
    {
        agents = [ agents ];
    }
    
    foreach ( agent in agents )
    {
        agent.var_34675b8a999ae793 = 10000;
        agent function_82940ab77128faa1( covernodetag );
    }
}

// Namespace ai_behavior
// Params 1
// Checksum 0x8000a6d3, Offset: 0x6afd
// Size: 0x16
function function_ac7b3b30d7cd9ac0( agents )
{
    function_5b781b37954f36ba( undefined, agents );
}

// Namespace ai_behavior
// Params 5
// Checksum 0xac64ceba, Offset: 0x6b1b
// Size: 0x17f
function behavior_cqb( agent, cqbnodes, var_d772a8f3355e702, var_71df46e3638ed06f, var_b78728c1900ec028 )
{
    function_6469bb607db9810f( agent, cqbnodes, var_d772a8f3355e702, var_71df46e3638ed06f, var_b78728c1900ec028 );
    
    if ( isint( agent ) )
    {
        return;
    }
    
    if ( !isdefined( cqbnodes ) || cqbnodes.size == 0 )
    {
        cqbstruct = function_d0bbcf89dc23b3b3( agent.origin, 512, 1 );
        cqbnodes = arraycombine( cqbstruct.cqbcovernodes, cqbstruct.var_8144cabf597859eb );
        
        if ( cqbnodes.size < 2 )
        {
            cqbnodes = arraycombine( cqbnodes, cqbstruct.var_ec741bb10c6a8231 );
        }
        
        if ( cqbnodes.size == 0 )
        {
            return;
        }
        
        cqbnodes = function_e539e9538e19483d( agent.origin, cqbnodes, 2 );
        
        if ( cqbnodes.size == 0 )
        {
            return;
        }
        
        cqbnodes = arrayrandomize( cqbnodes );
    }
    
    agent.balwayscoverexposed = 1;
    agent thread function_b9d8b7534babdade( agent, cqbnodes[ 0 ].origin, var_d772a8f3355e702, var_71df46e3638ed06f, var_b78728c1900ec028 );
    
    if ( !isdefined( cqbnodes[ 0 ].script_noteworthy ) || isdefined( cqbnodes[ 0 ].script_noteworthy ) && !issubstr( cqbnodes[ 0 ].script_noteworthy, "dont_move" ) )
    {
        agent thread function_4245d4a63e9444d( agent, cqbnodes );
        
        /#
            if ( false )
            {
                agent thread function_293c17d0a3b70621( agent, cqbnodes );
            }
        #/
        
        return;
    }
    
    /#
        if ( false )
        {
            agent thread function_ff449be32e0ccd07( agent, cqbnodes[ 0 ] );
        }
    #/
}

// Namespace ai_behavior
// Params 3
// Checksum 0xaa271ba5, Offset: 0x6ca2
// Size: 0x206
function function_d0bbcf89dc23b3b3( origin, searchradius, var_a5b259280161c6ee )
{
    while ( !isdefined( level.struct_class_names ) )
    {
        waitframe();
    }
    
    cqbcovernodes = [];
    var_8144cabf597859eb = [];
    var_ec741bb10c6a8231 = [];
    nodesaround = getnodesinradius( origin, searchradius, 0, searchradius );
    
    foreach ( node in nodesaround )
    {
        if ( isdefined( node.targetname ) && issubstr( tolower( node.targetname ), "traverse" ) )
        {
            continue;
        }
        
        if ( isdefined( node.type ) && ( issubstr( tolower( node.type ), "begin" ) || issubstr( tolower( node.type ), "end" ) || issubstr( tolower( node.type ), "path" ) ) )
        {
            continue;
        }
        
        if ( isdefined( node.script_noteworthy ) && issubstr( node.script_noteworthy, "cqb_node" ) )
        {
            if ( issubstr( node.script_noteworthy, "dont_move" ) )
            {
                var_8144cabf597859eb[ var_8144cabf597859eb.size ] = node;
            }
            else
            {
                cqbcovernodes[ cqbcovernodes.size ] = node;
            }
            
            continue;
        }
        
        if ( var_a5b259280161c6ee )
        {
            var_ec741bb10c6a8231[ var_ec741bb10c6a8231.size ] = node;
        }
    }
    
    struct = spawnstruct();
    struct.cqbcovernodes = arrayrandomize( cqbcovernodes );
    struct.var_8144cabf597859eb = arrayrandomize( var_8144cabf597859eb );
    struct.var_ec741bb10c6a8231 = arrayrandomize( var_ec741bb10c6a8231 );
    return struct;
}

// Namespace ai_behavior
// Params 1
// Checksum 0xc4f04a0d, Offset: 0x6eb1
// Size: 0x8f
function function_cc48d4b6e20f0e6a( cqbnodes )
{
    cqbnodes = arrayrandomize( cqbnodes );
    
    foreach ( node in cqbnodes )
    {
        if ( !node.claimed )
        {
            return node;
        }
    }
}

// Namespace ai_behavior
// Params 5
// Checksum 0x2b56a467, Offset: 0x6f49
// Size: 0x393
function function_e539e9538e19483d( origin, cqbnodes, numnodes, maxheightdifference, var_6fbcef64348a5fa2 )
{
    nodessorted = sortbydistance( cqbnodes, origin );
    selectednodes = [];
    var_e774d26f1cb60e7 = 4096;
    
    if ( !isdefined( numnodes ) )
    {
        numnodes = 1;
    }
    
    if ( !isdefined( maxheightdifference ) )
    {
        maxheightdifference = 75;
    }
    
    foreach ( node in nodessorted )
    {
        if ( selectednodes.size == numnodes )
        {
            return selectednodes;
        }
        
        if ( node.reserved )
        {
            continue;
        }
        
        if ( !var_6fbcef64348a5fa2 && node.claimed )
        {
            continue;
        }
        
        if ( abs( origin[ 2 ] - node.origin[ 2 ] ) >= maxheightdifference )
        {
            continue;
        }
        
        nodetooclose = 0;
        
        foreach ( selectednode in selectednodes )
        {
            if ( distance2dsquared( selectednode.origin, node.origin ) < var_e774d26f1cb60e7 )
            {
                nodetooclose = 1;
                break;
            }
        }
        
        if ( nodetooclose )
        {
            continue;
        }
        
        var_8c46a5043dec1bf4 = isdefined( node.script_noteworthy ) && issubstr( node.script_noteworthy, "dont_move" );
        
        if ( var_8c46a5043dec1bf4 && selectednodes.size > 0 )
        {
            continue;
        }
        
        node.reserved = 1;
        selectednodes[ selectednodes.size ] = node;
        
        if ( var_8c46a5043dec1bf4 )
        {
            return selectednodes;
        }
    }
    
    foreach ( node in nodessorted )
    {
        if ( selectednodes.size == numnodes )
        {
            return selectednodes;
        }
        
        if ( !var_6fbcef64348a5fa2 && node.claimed )
        {
            continue;
        }
        
        if ( abs( origin[ 2 ] - node.origin[ 2 ] ) >= maxheightdifference )
        {
            continue;
        }
        
        foreach ( selectednode in selectednodes )
        {
            if ( distance2dsquared( selectednode.origin, node.origin ) < var_e774d26f1cb60e7 )
            {
            }
        }
        
        var_8c46a5043dec1bf4 = isdefined( node.script_noteworthy ) && issubstr( node.script_noteworthy, "dont_move" );
        
        if ( var_8c46a5043dec1bf4 && selectednodes.size > 0 )
        {
            continue;
        }
        
        selectednodes[ selectednodes.size ] = node;
        
        if ( var_8c46a5043dec1bf4 )
        {
            return selectednodes;
        }
    }
    
    return selectednodes;
}

// Namespace ai_behavior
// Params 1
// Checksum 0x98b79ca8, Offset: 0x72e5
// Size: 0x20
function cqb_claimnode( node )
{
    if ( isdefined( node ) )
    {
        node.claimed = 1;
    }
}

// Namespace ai_behavior
// Params 1
// Checksum 0xcb491dfa, Offset: 0x730d
// Size: 0x1f
function cqb_releasenode( node )
{
    if ( isdefined( node ) )
    {
        node.claimed = 0;
    }
}

// Namespace ai_behavior
// Params 2
// Checksum 0xa4851041, Offset: 0x7334
// Size: 0xae, Type: bool
function cqb_usenode( agent, node )
{
    if ( !isdefined( node ) || node.claimed )
    {
        return false;
    }
    
    agent.keepclaimednode = 0;
    cqb_claimnode( node );
    agent.cqbnode = node;
    agent usecovernode( node );
    agent function_4a3c03bb49dd5d76( node.origin, 32 );
    agent.alertlevel = "combat";
    
    /#
        if ( false )
        {
            agent thread debug::drawsphere( node.origin, 25, 5, ( 1, 1, 0 ) );
        }
    #/
    
    return true;
}

// Namespace ai_behavior
// Params 4
// Checksum 0xa83ad00c, Offset: 0x73eb
// Size: 0x140
function function_4245d4a63e9444d( agent, nodes, waitmin, waitmax )
{
    agent endon( #"death" );
    agent endon( #"endcqb" );
    
    if ( !isdefined( nodes ) || nodes.size <= 1 )
    {
        return;
    }
    
    if ( !isdefined( waitmin ) )
    {
        waitmin = 8;
    }
    
    if ( !isdefined( waitmax ) )
    {
        waitmax = 12;
    }
    
    switchtime = randomintrange( waitmin, waitmax );
    currenttime = 0;
    interval = 1;
    var_5253e5f87da1b737 = 0;
    node = agent.cqbnode;
    
    if ( !isdefined( node ) )
    {
        node = function_cc48d4b6e20f0e6a( nodes );
        var_5253e5f87da1b737 = cqb_usenode( agent, node );
        
        /#
            if ( false )
            {
                thread function_ff449be32e0ccd07( agent, node, switchtime );
            }
        #/
    }
    
    while ( true )
    {
        if ( currenttime >= switchtime )
        {
            switchtime = randomintrange( waitmin, waitmax );
            currenttime = 0;
            
            if ( !agent isinscriptedstate() )
            {
                if ( var_5253e5f87da1b737 )
                {
                    cqb_releasenode( node );
                }
                
                node = function_cc48d4b6e20f0e6a( nodes );
                var_5253e5f87da1b737 = cqb_usenode( agent, node );
                
                /#
                    if ( false )
                    {
                        thread function_ff449be32e0ccd07( agent, node, switchtime );
                    }
                #/
            }
        }
        
        wait 1;
        currenttime += interval;
    }
}

// Namespace ai_behavior
// Params 5
// Checksum 0x6068ab51, Offset: 0x7533
// Size: 0x23c
function function_b9d8b7534babdade( agent, origin, var_d772a8f3355e702, var_71df46e3638ed06f, var_b78728c1900ec028 )
{
    agent endon( #"death" );
    interval = 1;
    var_67ca9262d24548fd = 1;
    enemylist = [];
    var_2e8014b77ffab97 = 0;
    var_8eb95464b5505e70 = 0;
    var_22e245fdaa676667 = 2;
    
    while ( var_67ca9262d24548fd )
    {
        foreach ( enemy in enemylist )
        {
            isenemyalive = isalive( enemy );
            canseeenemy = undefined;
            
            if ( isenemyalive )
            {
                canseeenemy = agent cansee( enemy );
            }
            
            if ( !isenemyalive || !canseeenemy || canseeenemy && ( enemy.inlaststand || !isalive( enemy ) ) )
            {
                enemylist = arrayremove( enemylist, enemy );
            }
        }
        
        enemy = agent.enemy;
        
        if ( isdefined( enemy ) && !arraycontains( enemylist, enemy ) )
        {
            enemylist[ enemylist.size ] = enemy;
        }
        
        foreach ( enemy in enemylist )
        {
            canseeenemy = agent cansee( enemy );
            
            if ( canseeenemy && !var_2e8014b77ffab97 )
            {
                var_2e8014b77ffab97 = 1;
                var_8eb95464b5505e70 = 0;
                break;
            }
        }
        
        if ( var_2e8014b77ffab97 )
        {
            if ( var_8eb95464b5505e70 >= var_22e245fdaa676667 )
            {
                var_67ca9262d24548fd = 0;
                continue;
            }
            else if ( enemylist.size == 0 )
            {
                var_2e8014b77ffab97 = 0;
            }
            else
            {
                var_8eb95464b5505e70 += interval;
            }
        }
        
        wait interval;
    }
    
    agent notify( #"endcqb" );
    agent function_4a3c03bb49dd5d76( origin, 1024 );
}

// Namespace ai_behavior
// Params 5
// Checksum 0x28eace61, Offset: 0x7777
// Size: 0x1b3
function behavior_boundingoverwatch( agents, origin, goalradius = 512, var_237f941b0d8d1b9a = 512, var_52813ffe13d27b0c = 1024 )
{
    if ( !isdefined( agents ) )
    {
        return;
    }
    
    if ( agents.size == 1 )
    {
        return;
    }
    
    target = level.players[ 0 ];
    
    foreach ( agent in agents )
    {
        if ( !isalive( agent ) )
        {
            /#
                if ( isdefined( agent.agentteam ) )
                {
                    println( "<dev string:x28a>" + agent.agentteam );
                }
            #/
            
            assertmsg( "<dev string:x2c5>" );
            continue;
        }
        
        function_d9fa623cfa155963( agent );
        agent leaveinteraction();
        agent.ignoreall = 0;
        agent enemy::bt_event_combat();
        agent.timetolosetargetatlkp = 1000000;
        agent getenemyinfo( target );
        agent.goalradius = 8192;
    }
    
    squadid = squad::function_996c0da2e8fc48ea( agents );
    function_3d5548507404db97( squadid, var_237f941b0d8d1b9a );
    function_368baa9132995931( squadid, var_52813ffe13d27b0c );
    setboundingoverwatchgoalradius( squadid, goalradius );
    function_2cc87713d26a171a( squadid, 1 );
    function_1e0d730061e96ada( squadid, 1.5 );
    setboundingoverwatchtarget( squadid, target );
}

// Namespace ai_behavior
// Params 0
// Checksum 0xfe39f16c, Offset: 0x7932
// Size: 0x5c9
function skit_init()
{
    function_4a0fe8694796f82e();
    level.var_a3624f98cf9c4d05 = getdvarint( @"hash_b4f6115f28d29917", 1 );
    level.var_547b6548c7fa08d9 = getdvarint( @"hash_5c7629c7b598096", 1 );
    level.var_6ca32a2bbad53019 = getdvarint( @"hash_6a81d72d5848072e", 0 );
    level.var_76e37dcc8fbd3461 = getdvarint( @"hash_881ac523ec0951c8", 50 );
    level.var_2e19dce62d41e878 = getdvarint( @"hash_2a4f4a889b10cb97", 50 );
    level.var_e5b801b45ce4df87 = getdvarint( @"hash_94a5257f83d0fb94", 50 );
    level.var_c0767c3b34d748f0 = getdvarfloat( @"hash_357703a36eeb389f", 45 );
    level.skitstruct = spawnstruct();
    level.skitstruct.interactionlist = [ "idle_cellphone", "idle_drinking", "idle_humming", "idle_radio", "idle_rail_lookover", "idle_scratching", "idle_smoke", "idle_staring", "idle_stretching", "idle_wreck_investigate", "idle_wreck_investigate_fast", "idle_tablet_scanning", "idle_tablet_inventory", "idle_phone_talk_stand", "idle_phone_talk_crouch", "idle_tying_shoe", "idle_patrol_search_forward", "idle_patrol_search_left", "idle_patrol_search_right", "idle_patrol_search_ground", "idle_patrol_looking_up", "patrol_radio_check_in01", "patrol_radio_check_in02" ];
    level.skitstruct.var_24f851e1a7d0844a = [ "idle_cellphone", "idle_humming", "idle_radio", "idle_rail_lookover", "idle_scratching", "idle_staring", "idle_stretching", "idle_wreck_investigate", "idle_wreck_investigate_fast", "idle_tablet_scanning", "idle_tablet_inventory", "idle_phone_talk_stand", "idle_phone_talk_crouch", "idle_tying_shoe", "idle_patrol_search_forward", "idle_patrol_search_left", "idle_patrol_search_right", "idle_patrol_search_ground", "idle_patrol_looking_up", "patrol_radio_check_in01", "patrol_radio_check_in02" ];
    level.skitstruct.interactionlist_alert = [ "idle_patrol_search_forward", "idle_patrol_search_left", "idle_patrol_search_right", "idle_patrol_search_ground", "idle_patrol_looking_up", "idle_patrol_search_doorway", "patrol_radio_check_in01", "patrol_radio_check_in02" ];
    moving_interacts = function_24e9e867df213b84( "moving", "information_tag", ( 0, 0, 0 ) );
    level.interactiondata = spawnstruct();
    
    foreach ( interact in moving_interacts )
    {
        id = interact;
        level.interactiondata.moving_interactions[ id ] = spawnstruct();
        level.interactiondata.moving_interactions[ id ].movepoints = [];
        level.interactiondata.moving_interactions[ id ].origin = getinteractionorigin( id );
        level.interactiondata.moving_interactions[ id ].angles = getinteractionangles( id );
        level.interactiondata.moving_interactions[ id ].var_c5a212fe4ddc89b1 = id;
        startstruct = utility::function_b7f3d374aa10aa51( "move_start", "targetname", level.interactiondata.moving_interactions[ id ].origin, 16 );
        startstruct = startstruct[ 0 ];
        
        if ( !startstruct )
        {
            assertmsg( "<dev string:x2f9>" + string( level.interactiondata.moving_interactions[ id ].origin ) );
            return;
        }
        
        if ( !startstruct.target )
        {
            assertmsg( "<dev string:x337>" + string( level.interactiondata.moving_interactions[ id ].origin ) );
            return;
        }
        
        destinationpoint = utility::getstruct( startstruct.target, "targetname" );
        level.interactiondata.moving_interactions[ id ].movepoints[ 0 ] = destinationpoint;
        
        while ( destinationpoint.target )
        {
            destinationpoint = utility::getstruct( destinationpoint.target, "targetname" );
            
            if ( arraycontains( level.interactiondata.moving_interactions[ id ].movepoints, destinationpoint ) )
            {
                break;
            }
            
            level.interactiondata.moving_interactions[ id ].movepoints[ level.interactiondata.moving_interactions[ id ].movepoints.size ] = destinationpoint;
        }
    }
    
    ai_mp_controller::function_2b1cc53b284373( &function_711538a33b44aefa );
}

// Namespace ai_behavior
// Params 4
// Checksum 0x36170ebc, Offset: 0x7f03
// Size: 0x145
function function_994eab109bcc3ad8( agents, interaction, forceteleport = 0, var_58a35439f3ac4eb5 = 1 )
{
    if ( !isarray( agents ) )
    {
        agents = [ agents ];
    }
    
    if ( agents.size > 1 && forceteleport == 1 )
    {
        foreach ( npc in agents )
        {
            npc thread function_b1c56c3a9572159( npc, interaction, forceteleport );
            wait var_58a35439f3ac4eb5;
        }
        
        return;
    }
    
    foreach ( npc in agents )
    {
        npc thread function_b1c56c3a9572159( npc, interaction, forceteleport );
    }
}

// Namespace ai_behavior
// Params 3
// Checksum 0x4a3842ec, Offset: 0x8050
// Size: 0xca
function function_b1c56c3a9572159( npc, interaction, forceteleport )
{
    startloc = getinteractionorigin( interaction );
    startangles = getinteractionangles( interaction );
    
    if ( isdefined( npc getinteractionid() ) )
    {
        npc leaveinteraction();
        waitframe();
    }
    
    npc clearbtgoal( 0 );
    npc clearbtgoal( 1 );
    npc clearbtgoal( 3 );
    npc function_8dea53a2dfc74f94( 0 );
    npc function_a47253874da73280( startloc );
    npc function_ad85ecc3923456f4( 8 );
    
    if ( forceteleport )
    {
        npc forceteleport( startloc, startangles, 30000, 1 );
        waitframe();
    }
    
    npc function_895b16b8fcd857ba( interaction );
    npc function_4a3c03bb49dd5d76( startloc, 8, 0 );
    npc waittill( #"goal" );
    npc waittill( #"interaction_ended" );
}

// Namespace ai_behavior
// Params 4
// Checksum 0x22822cdc, Offset: 0x8122
// Size: 0x1d8
function function_d96bc4334a12b251( agent, requiredtags, forbiddentags, infotags )
{
    if ( isstring( requiredtags ) )
    {
        requiredtags = strtok( requiredtags, "," );
    }
    
    if ( isarray( requiredtags ) )
    {
        foreach ( tag in requiredtags )
        {
            function_504d66a126d75fe5( agent, tag, "required_tag" );
        }
    }
    
    if ( isstring( forbiddentags ) )
    {
        forbiddentags = strtok( forbiddentags, "," );
    }
    
    if ( isarray( forbiddentags ) )
    {
        foreach ( tag in forbiddentags )
        {
            function_504d66a126d75fe5( agent, tag, "forbidden_tag" );
        }
    }
    
    if ( isstring( infotags ) )
    {
        infotags = strtok( infotags, "," );
    }
    
    if ( isarray( infotags ) )
    {
        foreach ( tag in infotags )
        {
            function_504d66a126d75fe5( agent, tag, "information_tag" );
        }
    }
}

// Namespace ai_behavior
// Params 4
// Checksum 0x921e153a, Offset: 0x8302
// Size: 0x1d8
function function_e90bab991abbb836( agent, requiredtags, forbiddentags, infotags )
{
    if ( isstring( requiredtags ) )
    {
        requiredtags = strtok( requiredtags, "," );
    }
    
    if ( isarray( requiredtags ) )
    {
        foreach ( tag in requiredtags )
        {
            function_d53921d7d94a5f4f( agent, tag, "required_tag" );
        }
    }
    
    if ( isstring( forbiddentags ) )
    {
        forbiddentags = strtok( forbiddentags, "," );
    }
    
    if ( isarray( forbiddentags ) )
    {
        foreach ( tag in forbiddentags )
        {
            function_d53921d7d94a5f4f( agent, tag, "forbidden_tag" );
        }
    }
    
    if ( isstring( infotags ) )
    {
        infotags = strtok( infotags, "," );
    }
    
    if ( isarray( infotags ) )
    {
        foreach ( tag in infotags )
        {
            function_d53921d7d94a5f4f( agent, tag, "information_tag" );
        }
    }
}

// Namespace ai_behavior
// Params 5
// Checksum 0x3fa5a794, Offset: 0x84e2
// Size: 0x175
function function_58c5b133b541be00( interactionorigin, interactionangles = ( 0, 0, 0 ), specificinteraction, agentidledemeanor, var_9a9cc7d47e36ed83 )
{
    if ( agentidledemeanor && agentidledemeanor == "alert" )
    {
        interactionlist = level.skitstruct.interactionlist_alert;
    }
    else if ( var_9a9cc7d47e36ed83 )
    {
        interactionlist = level.skitstruct.var_24f851e1a7d0844a;
    }
    else
    {
        interactionlist = level.skitstruct.interactionlist;
    }
    
    if ( interactionlist.size == 0 )
    {
        return;
    }
    
    struct = spawnstruct();
    interaction = specificinteraction ?? utility::array_random( interactionlist );
    struct.interactionid = spawninteraction( interaction, interactionorigin, interactionangles );
    
    if ( !struct.interactionid )
    {
        return;
    }
    
    struct.interactionorigin = getinteractionorigin( struct.interactionid );
    struct.interactionangles = getinteractionangles( struct.interactionid );
    struct.in_use = 0;
    
    if ( getdvarint( @"scr_debug_ai_interactions", 0 ) )
    {
        level thread debug::drawsphere( struct.interactionorigin, 64, 1, ( 0, 0, 1 ) );
    }
    
    return struct;
}

// Namespace ai_behavior
// Params 1
// Checksum 0x8eb79bcb, Offset: 0x8660
// Size: 0x112
function function_c60e67787847eadd( interactionnode )
{
    if ( !isdefined( interactionnode ) || !isdefined( interactionnode.interactionid ) || !function_e0737745ca681ec7( interactionnode.interactionid ) )
    {
        return;
    }
    
    if ( getdvarint( @"scr_debug_ai_interactions", 0 ) )
    {
        level thread debug::drawsphere( interactionnode.interactionorigin, 64, 5, ( 1, 0, 0 ) );
    }
    
    while ( true )
    {
        if ( !isdefined( interactionnode ) || !isdefined( interactionnode.interactionid ) || !function_e0737745ca681ec7( interactionnode.interactionid ) )
        {
            return;
        }
        
        if ( getbsequsers( interactionnode.interactionid ).size == 0 )
        {
            break;
        }
        
        waitframe();
        
        if ( !isdefined( interactionnode ) || !isdefined( interactionnode.interactionid ) || !function_e0737745ca681ec7( interactionnode.interactionid ) )
        {
            return;
        }
    }
    
    despawninteraction( interactionnode.interactionid );
    interactionnode = undefined;
    
    if ( self.interactionnode )
    {
        self.interactionnode = undefined;
    }
}

// Namespace ai_behavior
// Params 1
// Checksum 0xc34d85c1, Offset: 0x877a
// Size: 0x14
function skit_istraversing( agent )
{
    return ai::is_doing_traversal( agent );
}

// Namespace ai_behavior
// Params 6
// Checksum 0x50ddcbb5, Offset: 0x8797
// Size: 0x19f
function function_eb19f1b87c41eddb( agent, interactionnode, var_d160b7c2a204378c = 0, var_9b8779fb8afb73af = 15, var_9b6467fb8ad50461 = 20, var_7e13ca19764be1c2 = 0 )
{
    while ( skit_istraversing( agent ) )
    {
        waitframe();
    }
    
    if ( !isdefined( interactionnode ) || !isdefined( interactionnode.interactionid ) )
    {
        return;
    }
    
    agent function_895b16b8fcd857ba( interactionnode.interactionid );
    agent thread function_ab146f06c5aa306e();
    interactionnode.inuse = 1;
    looptime = randomintrange( var_9b8779fb8afb73af, var_9b6467fb8ad50461 );
    agent.var_2a83cd5a466893d4 = looptime;
    agent thread function_e9038a3f58a4b8d7( agent, interactionnode.interactionid );
    
    if ( getdvarint( @"scr_debug_ai_interactions", 0 ) )
    {
        level thread debug::drawsphere( interactionnode.interactionorigin, 64, 5, ( 0, 1, 0 ) );
    }
    
    if ( var_7e13ca19764be1c2 )
    {
        msg = agent utility::waittill_any_return( "death", "bad_path", "release_interaction" );
    }
    else
    {
        msg = agent utility::waittill_any_return( "death", "stealth_combat", "combat", "cover_blown", "event_combat", "bad_path", "release_interaction" );
    }
    
    interactionnode.inuse = 0;
    
    if ( isalive( agent ) )
    {
        agent notify( #"release_interaction" );
    }
    
    if ( var_d160b7c2a204378c )
    {
        agent function_c60e67787847eadd( interactionnode );
    }
}

// Namespace ai_behavior
// Params 2, eflags: 0x4
// Checksum 0x553149e3, Offset: 0x893e
// Size: 0x72
function private function_e9038a3f58a4b8d7( agent, interactionid )
{
    level endon( #"game_ended" );
    agent endon( #"release_interaction" );
    agent endon( #"death" );
    
    while ( !agent getinteractionid() || agent getinteractionid() != interactionid )
    {
        waitframe();
    }
    
    agent waittill( #"cap_exit_completed" );
    waitframe();
    agent notify( #"release_interaction" );
}

// Namespace ai_behavior
// Params 3
// Checksum 0x2618bc2d, Offset: 0x89b8
// Size: 0x1fa
function function_5729c009c3042549( agent, var_a10c7073f11439e, var_fa70351b97855b82 )
{
    self notify( #"hash_9b602f1b96351a1c" );
    self endon( #"hash_9b602f1b96351a1c" );
    level endon( #"game_ended" );
    agent endon( #"death" );
    
    if ( !isdefined( agent ) || isint( agent ) )
    {
        return;
    }
    
    if ( isdefined( var_a10c7073f11439e ) )
    {
        if ( !isarray( var_a10c7073f11439e ) )
        {
            var_a10c7073f11439e = [ var_a10c7073f11439e ];
        }
        
        foreach ( tag in var_a10c7073f11439e )
        {
            agent function_504d66a126d75fe5( agent, tag, "information_tag" );
        }
    }
    
    defaulttag = "patrol";
    hunttag = "hunt";
    
    switch ( var_fa70351b97855b82 )
    {
        case #"hash_7df245010bdec44e":
            defaulttag = "guard";
            break;
        case #"hash_9128327eb51e0b7b":
        default:
            break;
    }
    
    agent function_504d66a126d75fe5( agent, defaulttag, "information_tag" );
    
    while ( true )
    {
        if ( agent utility::is_idling() )
        {
            agent function_d53921d7d94a5f4f( agent, hunttag, "information_tag" );
            agent function_504d66a126d75fe5( agent, defaulttag, "information_tag" );
        }
        else if ( agent utility::is_investigating() || agent utility::is_hunting() )
        {
            agent function_d53921d7d94a5f4f( agent, defaulttag, "information_tag" );
            agent function_504d66a126d75fe5( agent, hunttag, "information_tag" );
        }
        else if ( agent utility::function_4d40994d0dcca395() )
        {
            agent function_d53921d7d94a5f4f( agent, defaulttag, "information_tag" );
            agent function_d53921d7d94a5f4f( agent, hunttag, "information_tag" );
        }
        
        wait 10;
    }
}

// Namespace ai_behavior
// Params 3, eflags: 0x4
// Checksum 0xba7d7062, Offset: 0x8bba
// Size: 0x45
function private function_504d66a126d75fe5( agent, tag, taglist )
{
    if ( !isdefined( agent ) || isint( agent ) )
    {
        return;
    }
    
    if ( !agent function_eeb44e7e1581a907( tag, taglist ) )
    {
        agent function_b67bf8a76e649311( tag, taglist );
    }
}

// Namespace ai_behavior
// Params 3, eflags: 0x4
// Checksum 0x94d29d84, Offset: 0x8c07
// Size: 0x44
function private function_d53921d7d94a5f4f( agent, tag, taglist )
{
    if ( !isdefined( agent ) || isint( agent ) )
    {
        return;
    }
    
    if ( agent function_eeb44e7e1581a907( tag, taglist ) )
    {
        agent function_d68a061580d864b6( tag, taglist );
    }
}

// Namespace ai_behavior
// Params 6, eflags: 0xc
// Checksum 0x3cd7ad23, Offset: 0x8c53
// Size: 0x1c0
function private function_8dab18257ee1b60( agent, origin, var_9b8779fb8afb73af = 15, var_9b6467fb8ad50461 = 20, interactionuseradius = 512, var_53d650c5d08cb307 = 0 )
{
    self notify( #"hash_971d6f88d605fb64" );
    self endon( #"hash_971d6f88d605fb64" );
    level endon( #"game_ended" );
    agent endon( #"death" );
    
    if ( !function_6d4b291a7628fac3( agent ) )
    {
        return;
    }
    
    roll = randomintrange( 0, 100 );
    
    if ( !var_53d650c5d08cb307 && getdvarint( @"hash_42b8127f02bb4c1c", 1 ) > 0 )
    {
        if ( roll < level.var_e5b801b45ce4df87 )
        {
            agent function_8dea53a2dfc74f94( 0 );
            function_a14cf0d304e085fc( agent, var_9b8779fb8afb73af, var_9b6467fb8ad50461 );
            return;
        }
    }
    
    if ( level.var_a3624f98cf9c4d05 )
    {
        if ( getdvarint( @"scr_debug_ai_interactions", 0 ) )
        {
            level thread debug::drawsphere( origin, 64, 5, ( 0, 1, 0 ) );
        }
        
        agent function_a47253874da73280( origin );
        agent function_ad85ecc3923456f4( interactionuseradius );
        agent function_8dea53a2dfc74f94( 1 );
        looptime = randomintrange( var_9b8779fb8afb73af, var_9b6467fb8ad50461 );
        agent.var_2a83cd5a466893d4 = looptime;
        wait 1;
        
        if ( agent getinteractionid() )
        {
            wait looptime;
        }
        
        agent leaveinteraction();
        agent function_8dea53a2dfc74f94( 0 );
    }
    else
    {
        agent function_8dea53a2dfc74f94( 0 );
        function_a14cf0d304e085fc( agent, var_9b8779fb8afb73af, var_9b6467fb8ad50461 );
    }
    
    if ( level.var_547b6548c7fa08d9 )
    {
        if ( !level.var_a3624f98cf9c4d05 )
        {
            agent thread function_6b6f3932b45a62c3();
        }
        
        return;
    }
    
    function_a14cf0d304e085fc( agent, var_9b8779fb8afb73af, var_9b6467fb8ad50461 );
}

// Namespace ai_behavior
// Params 1
// Checksum 0x352cac0a, Offset: 0x8e1b
// Size: 0x39
function function_711538a33b44aefa( params )
{
    agent = self;
    
    if ( agent.interactionnode )
    {
        function_c60e67787847eadd( agent.interactionnode );
    }
}

// Namespace ai_behavior
// Params 5, eflags: 0x4
// Checksum 0xdb20cd18, Offset: 0x8e5c
// Size: 0x188
function private function_a14cf0d304e085fc( agent, var_9b8779fb8afb73af, var_9b6467fb8ad50461, var_c59a8ee0f66286ac = 1, deleteaftertime = 10 )
{
    if ( !isdefined( agent getinteractionid() ) )
    {
        if ( agent.var_ce2f8b4ca895561 || agent.var_1e2afba6dedb6c52 || agent.tier == 3 )
        {
            var_9a9cc7d47e36ed83 = 1;
        }
        
        interactionnode = function_58c5b133b541be00( agent.origin, agent.angles, undefined, agent.stealth_idledemeanor, var_9a9cc7d47e36ed83 );
        
        if ( !isdefined( interactionnode ) )
        {
            return;
        }
        
        agent.interactionnode = interactionnode;
        agent function_eb19f1b87c41eddb( agent, interactionnode, 0, var_9b8779fb8afb73af, var_9b6467fb8ad50461 );
        
        if ( var_c59a8ee0f66286ac )
        {
            while ( true )
            {
                if ( !isdefined( interactionnode ) || !isdefined( interactionnode.interactionid ) || !function_e0737745ca681ec7( interactionnode.interactionid ) )
                {
                    return;
                }
                
                if ( getbsequsers( interactionnode.interactionid ).size == 0 )
                {
                    break;
                }
                
                waitframe();
                
                if ( !isdefined( interactionnode ) || !isdefined( interactionnode.interactionid ) || !function_e0737745ca681ec7( interactionnode.interactionid ) )
                {
                    return;
                }
            }
            
            despawninteraction( interactionnode.interactionid );
            return;
        }
        
        if ( deleteaftertime > 0 )
        {
            level thread function_11590c7525c68d6e( interactionnode, deleteaftertime );
        }
    }
}

// Namespace ai_behavior
// Params 9
// Checksum 0x6a2861b8, Offset: 0x8fec
// Size: 0x18a
function function_d8cf7f7e0992841b( agent, var_9b8779fb8afb73af, var_9b6467fb8ad50461, interactionname, var_b6cedac20dcbf7b4, var_73a0527e4e01274e, var_c59a8ee0f66286ac = 1, deleteaftertime = 10, var_7e13ca19764be1c2 = 0 )
{
    if ( !isdefined( agent getinteractionid() ) )
    {
        origin = var_b6cedac20dcbf7b4 ?? agent.origin;
        angles = var_73a0527e4e01274e ?? agent.angles;
        interactionnode = function_58c5b133b541be00( origin, angles, interactionname, agent.stealth_idledemeanor );
        
        if ( !isdefined( interactionnode ) )
        {
            return;
        }
        
        function_eb19f1b87c41eddb( agent, interactionnode, 0, var_9b8779fb8afb73af, var_9b6467fb8ad50461, var_7e13ca19764be1c2 );
        
        if ( var_c59a8ee0f66286ac )
        {
            while ( true )
            {
                if ( !isdefined( interactionnode ) || !isdefined( interactionnode.interactionid ) || !function_e0737745ca681ec7( interactionnode.interactionid ) )
                {
                    return;
                }
                
                if ( getbsequsers( interactionnode.interactionid ).size == 0 )
                {
                    break;
                }
                
                waitframe();
                
                if ( !isdefined( interactionnode ) || !isdefined( interactionnode.interactionid ) || !function_e0737745ca681ec7( interactionnode.interactionid ) )
                {
                    return;
                }
            }
            
            despawninteraction( interactionnode.interactionid );
            return;
        }
        
        if ( deleteaftertime > 0 )
        {
            level thread function_11590c7525c68d6e( interactionnode, deleteaftertime );
        }
    }
}

// Namespace ai_behavior
// Params 2
// Checksum 0x38c4d5fe, Offset: 0x917e
// Size: 0xa3
function function_11590c7525c68d6e( interactionnode, deleteaftertime )
{
    wait deleteaftertime;
    
    while ( true )
    {
        if ( !isdefined( interactionnode ) || !isdefined( interactionnode.interactionid ) || !function_e0737745ca681ec7( interactionnode.interactionid ) )
        {
            return;
        }
        
        if ( getbsequsers( interactionnode.interactionid ).size == 0 )
        {
            break;
        }
        
        waitframe();
        
        if ( !isdefined( interactionnode ) || !isdefined( interactionnode.interactionid ) || !function_e0737745ca681ec7( interactionnode.interactionid ) )
        {
            return;
        }
    }
    
    despawninteraction( interactionnode.interactionid );
}

// Namespace ai_behavior
// Params 5, eflags: 0x4
// Checksum 0xbdc08c3c, Offset: 0x9229
// Size: 0xbe
function private function_606aaea2a6942f7e( bool = 1, var_d2333c193f6671d = self.origin, searchradius = 1024, var_592cd3ba70d8eae7 = 5, looping_interaction = 0 )
{
    if ( level.var_a3624f98cf9c4d05 )
    {
        self function_8dea53a2dfc74f94( bool );
        
        if ( bool )
        {
            self function_a47253874da73280( var_d2333c193f6671d );
            self function_ad85ecc3923456f4( searchradius );
            
            if ( var_592cd3ba70d8eae7 > 0 )
            {
                self function_85f2abc1aa558cc4( var_592cd3ba70d8eae7 );
            }
            
            self.var_49a6665e8484d186 = 1;
            thread function_ab146f06c5aa306e();
        }
        
        if ( looping_interaction )
        {
            self.var_88af750d8cd349c1 = 1;
        }
    }
}

// Namespace ai_behavior
// Params 0
// Checksum 0xe5a1531e, Offset: 0x92ef
// Size: 0x8, Type: bool
function function_f2b0e1b62f57ce9()
{
    return istrue( self getinteractionid() );
}

// Namespace ai_behavior
// Params 0
// Checksum 0xd4584596, Offset: 0x9300
// Size: 0x88
function function_5a3ac98c90419d38()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    current_bool = 0;
    
    while ( true )
    {
        self waittill( #"cap_start" );
        new_bool = 0;
        
        while ( function_f2b0e1b62f57ce9() )
        {
            new_bool = 1;
            
            if ( new_bool != current_bool )
            {
                current_bool = new_bool;
                function_283c0c5c3be67d23( 1, "outline_nodepth_green" );
            }
            
            wait 1;
        }
        
        new_bool = 0;
        
        if ( new_bool != current_bool )
        {
            current_bool = new_bool;
            function_283c0c5c3be67d23();
        }
    }
}

// Namespace ai_behavior
// Params 0, eflags: 0xc
// Checksum 0xe03f9e4e, Offset: 0x9390
// Size: 0x8b
function private function_ab146f06c5aa306e()
{
    self notify( #"hash_d36c53c43e487411" );
    self endon( #"hash_d36c53c43e487411" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self waittill( #"cap_start" );
    interaction_id = self getinteractionid();
    [ hiddenranges, spottedranges ] = function_5da49a96518cc157( interaction_id );
    self waittill( #"cap_exit_completed" );
}

// Namespace ai_behavior
// Params 0, eflags: 0x4
// Checksum 0xc38d873, Offset: 0x9423
// Size: 0x7
function private function_f00f43d9e63e0915()
{
    return "sightless";
}

// Namespace ai_behavior
// Params 1, eflags: 0x4
// Checksum 0xdd337527, Offset: 0x9433
// Size: 0x6d
function private function_5da49a96518cc157( interaction_id )
{
    hiddenranges[ "prone" ] = 1000;
    hiddenranges[ "crouch" ] = 2000;
    hiddenranges[ "stand" ] = 2750;
    spottedranges[ "prone" ] = 1500;
    spottedranges[ "crouch" ] = 2500;
    spottedranges[ "stand" ] = 3250;
    return [ hiddenranges, spottedranges ];
}

// Namespace ai_behavior
// Params 0, eflags: 0xc
// Checksum 0x7ac1e4c1, Offset: 0x94a9
// Size: 0x20f
function private function_6b6f3932b45a62c3()
{
    self notify( #"hash_7cd1f32bafa4cf9d" );
    self endon( #"hash_7cd1f32bafa4cf9d" );
    level endon( #"game_ended" );
    self endon( #"death" );
    interaction_state = 0;
    using_interaction = 0;
    joining_interaction = 0;
    interaction = undefined;
    
    while ( true )
    {
        interaction_state = self getinteractionid();
        
        if ( isdefined( interaction_state ) )
        {
            if ( isdefined( interaction ) )
            {
                if ( isdefined( level.available_interactions ) && isstruct( interaction ) )
                {
                    level.available_interactions[ level.available_interactions.size ] = interaction;
                }
                
                interaction = undefined;
            }
            
            joining_interaction = 0;
            
            if ( !using_interaction )
            {
                function_283c0c5c3be67d23( 1, "outline_nodepth_green" );
                using_interaction = 1;
            }
            
            function_df682e760bd6cef8();
        }
        else if ( using_interaction )
        {
            if ( isdefined( level.available_interactions ) && isstruct( interaction ) )
            {
                level.available_interactions[ level.available_interactions.size ] = interaction;
            }
            
            interaction = undefined;
            behavior_executebehaviorpackage( self );
            function_283c0c5c3be67d23();
            using_interaction = 0;
            joining_interaction = 0;
        }
        else if ( !joining_interaction )
        {
            function_283c0c5c3be67d23( 1, "outline_nodepth_orange" );
            
            if ( !level.var_a3624f98cf9c4d05 )
            {
                if ( level.available_interactions.size > 0 )
                {
                    interaction = function_47c86977a18df38b( level.available_interactions, self.origin, 5000 );
                    
                    if ( isdefined( interaction ) )
                    {
                        self function_895b16b8fcd857ba( interaction.interactionid );
                        thread function_4a3c03bb49dd5d76( interaction.origin, 16, 1 );
                        level.available_interactions = arrayremove( level.available_interactions, interaction );
                        joining_interaction = 1;
                    }
                }
                else
                {
                    interaction = self function_9bbbb957fbf8847e( "patrol", "information_tag" );
                    
                    if ( isdefined( interaction ) )
                    {
                        thread function_4a3c03bb49dd5d76( getinteractionorigin( interaction ), 16, 1 );
                    }
                }
            }
            else
            {
                interaction = self function_9bbbb957fbf8847e( "patrol", "information_tag" );
                
                if ( isdefined( interaction ) )
                {
                    thread function_4a3c03bb49dd5d76( getinteractionorigin( interaction ), 16, 1 );
                }
            }
        }
        
        wait 0.25;
    }
}

// Namespace ai_behavior
// Params 0, eflags: 0xc
// Checksum 0x681a080c, Offset: 0x96c0
// Size: 0x30
function private function_df682e760bd6cef8()
{
    self notify( #"hash_24c712f49474202b" );
    self endon( #"hash_24c712f49474202b" );
    level endon( #"game_ended" );
    wait level.var_c0767c3b34d748f0;
}

// Namespace ai_behavior
// Params 3
// Checksum 0x8da98f65, Offset: 0x96f8
// Size: 0x67
function function_283c0c5c3be67d23( bool = 0, outline = "outline_nodepth_green", var_7f8b0cd9a51f380 = 0 )
{
    if ( getdvarint( @"hash_ac0feddd08642de3", 0 ) || var_7f8b0cd9a51f380 )
    {
        if ( bool )
        {
            self hudoutlineenable( outline );
            return;
        }
        
        self hudoutlinedisable();
    }
}

// Namespace ai_behavior
// Params 0
// Checksum 0x4c10efca, Offset: 0x9767
// Size: 0xee
function function_4a0fe8694796f82e()
{
    var_c93ed91825255484 = utility::getstructarray( "info_act", "script_noteworthy" );
    
    foreach ( node in var_c93ed91825255484 )
    {
        subarea = utility::callsharedfunc( #"poi", #"hash_8dbb0d45f903ae1c", node.origin );
        
        if ( isdefined( subarea ) )
        {
            if ( !isdefined( subarea.interactionnodes ) )
            {
                subarea.interactionnodes = [];
            }
            
            subarea.interactionnodes[ subarea.interactionnodes.size ] = node;
        }
    }
}

// Namespace ai_behavior
// Params 7
// Checksum 0x2aeff662, Offset: 0x985d
// Size: 0x177
function function_ae925e02fa53d09a( agents, var_b2042ead97677c93, patrolgroupname, var_9b8779fb8afb73af, var_9b6467fb8ad50461, interactionuseradius, var_53d650c5d08cb307 = 0 )
{
    numagents = agents.size;
    
    foreach ( agent in agents )
    {
        agent.patrolinteracting = 1;
        agent thread function_b02c50168bd7e841( agent, var_b2042ead97677c93, patrolgroupname, var_9b8779fb8afb73af, var_9b6467fb8ad50461, interactionuseradius, var_53d650c5d08cb307 );
    }
    
    var_7a2d8b4a123ac16 = numagents;
    
    while ( var_7a2d8b4a123ac16 > 0 )
    {
        var_7a2d8b4a123ac16 = numagents;
        
        foreach ( agent in agents )
        {
            if ( !isalive( agent ) || !agent.patrolinteracting )
            {
                var_7a2d8b4a123ac16--;
            }
        }
        
        waitframe();
    }
}

// Namespace ai_behavior
// Params 7
// Checksum 0x7e929386, Offset: 0x99dc
// Size: 0xbe
function function_b02c50168bd7e841( agent, var_b2042ead97677c93, patrolgroupname, var_9b8779fb8afb73af, var_9b6467fb8ad50461, interactionuseradius, var_53d650c5d08cb307 = 0 )
{
    agent endon( #"death" );
    radiussquared = 16384;
    
    while ( distance2dsquared( agent.origin, var_b2042ead97677c93 ) > radiussquared )
    {
        wait 1;
    }
    
    agent clearbtgoal( 0 );
    agent clearbtgoal( 1 );
    agent clearbtgoal( 3 );
    agent function_8dab18257ee1b60( agent, var_b2042ead97677c93, var_9b8779fb8afb73af, var_9b6467fb8ad50461, interactionuseradius, var_53d650c5d08cb307 );
    wait 1;
    agent.patrolinteracting = 0;
}

// Namespace ai_behavior
// Params 1
// Checksum 0x6798430b, Offset: 0x9aa2
// Size: 0xa3, Type: bool
function function_6d4b291a7628fac3( agent )
{
    if ( !isdefined( agent ) || isint( agent ) )
    {
        return false;
    }
    
    if ( agent.var_4958644852c3cc3c )
    {
        return false;
    }
    
    if ( isdefined( agent.vehicle ) )
    {
        return false;
    }
    
    agent_type = tolower( agent.agent_type );
    isriot = issubstr( agent_type, "riot" );
    isanimal = issubstr( agent_type, "wolf" ) || issubstr( agent_type, "dog" );
    
    if ( isriot || isanimal )
    {
        return false;
    }
    
    return true;
}

// Namespace ai_behavior
// Params 9
// Checksum 0xb5739352, Offset: 0x9b4e
// Size: 0x182
function function_5c6cec6f0ce57f4( agent, origin, requiredtags, forbiddentags, interactionmode, var_9b8779fb8afb73af = 20, var_9b6467fb8ad50461 = 25, interactionuseradius = 512, var_12289852ec70e858 = 0 )
{
    if ( isint( agent ) )
    {
        return;
    }
    
    if ( !isdefined( origin ) )
    {
        origin = agent.origin;
    }
    
    agent endon( #"death" );
    agent endon( #"stealth_investigate" );
    agent endon( #"stealth_hunt" );
    agent endon( #"stealth_combat" );
    agent endon( #"startCombatRush" );
    agent endon( #"hash_b82de4299d909fce" );
    function_1035cc9dfcff38d0();
    wait 1;
    function_d96bc4334a12b251( agent, requiredtags, forbiddentags );
    
    if ( !var_12289852ec70e858 && interactionmode == "Endless One Node" && gettime() - agent.birthtime < 3000 && distance2dsquared( agent.origin, origin ) < 65536 )
    {
        agent.startinteractionimmediate = 1;
    }
    
    if ( interactionmode == "Endless One Node" )
    {
        agent thread function_569313b9be62b1bf( agent, origin, interactionuseradius );
        return;
    }
    
    agent function_283c0c5c3be67d23( 1, "outline_nodepth_green" );
    agent function_2bed913502e8e410( agent, origin, interactionuseradius, var_9b8779fb8afb73af, var_9b6467fb8ad50461 );
}

// Namespace ai_behavior
// Params 5
// Checksum 0xcedbbeaa, Offset: 0x9cd8
// Size: 0x97
function function_569313b9be62b1bf( agent, origin, interactionuseradius = 512, var_9b8779fb8afb73af, var_9b6467fb8ad50461 )
{
    self notify( #"hash_55989a25068cdbae" );
    self endon( #"hash_55989a25068cdbae" );
    agent function_a47253874da73280( origin );
    agent function_ad85ecc3923456f4( interactionuseradius );
    agent.var_49a6665e8484d186 = 1;
    agent.var_88af750d8cd349c1 = 1;
    agent function_8dea53a2dfc74f94( 1 );
    agent function_283c0c5c3be67d23( 1, "outline_nodepth_cyan" );
}

// Namespace ai_behavior
// Params 5
// Checksum 0x83896751, Offset: 0x9d77
// Size: 0xf7
function function_2bed913502e8e410( agent, origin, interactionuseradius = 512, var_9b8779fb8afb73af = 15, var_9b6467fb8ad50461 = 20 )
{
    self notify( #"hash_9576e46795cfebb7" );
    self endon( #"hash_9576e46795cfebb7" );
    level endon( #"game_ended" );
    agent endon( #"death" );
    agent endon( #"hash_b82de4299d909fce" );
    
    while ( !isdefined( agent.enemy ) )
    {
        agent function_a47253874da73280( origin );
        agent function_ad85ecc3923456f4( interactionuseradius );
        agent function_8dea53a2dfc74f94( 1 );
        
        while ( !agent getinteractionid() )
        {
            waitframe();
        }
        
        looptime = randomintrange( var_9b8779fb8afb73af, var_9b6467fb8ad50461 );
        agent.var_2a83cd5a466893d4 = looptime;
        
        while ( agent getinteractionid() )
        {
            wait 0.25;
        }
    }
}

// Namespace ai_behavior
// Params 1
// Checksum 0x87ce2471, Offset: 0x9e76
// Size: 0x53
function function_9e0cd236b437e0f6( timeout )
{
    self notify( #"hash_c1c9a016ba42ff42" );
    self endon( #"hash_c1c9a016ba42ff42" );
    utility::waittill_any_in_array_or_timeout( [ "end_disperse", "game_ended", "death" ], timeout );
    self.var_ee914ad666562200 = 0;
}

// Namespace ai_behavior
// Params 3
// Checksum 0xa6ba2193, Offset: 0x9ed1
// Size: 0x118
function function_e28790b34530b29( var_e94b81e2231e2a9, vector, ignorenode )
{
    potentialnodes = getlinkednodes( var_e94b81e2231e2a9 );
    
    if ( !potentialnodes )
    {
        return;
    }
    
    highestdot = -1;
    var_4775b837a43daa6a = var_e94b81e2231e2a9;
    
    foreach ( node in potentialnodes )
    {
        if ( node == var_e94b81e2231e2a9 || node == ignorenode )
        {
            continue;
        }
        
        var_caf47d8893520554 = vectornormalize2( self.origin - node.origin );
        dot = vectordot( vector, var_caf47d8893520554 );
        
        if ( dot > 0 && dot > highestdot )
        {
            highestdot = dot;
            var_4775b837a43daa6a = node;
        }
    }
    
    return var_4775b837a43daa6a;
}

// Namespace ai_behavior
// Params 2
// Checksum 0x78ba7fd7, Offset: 0x9ff2
// Size: 0x862
function function_3ac31cb42020b04b( player, squadid )
{
    self notify( #"hash_d5eb751618cfb342" );
    self endon( #"hash_d5eb751618cfb342" );
    self endon( #"death" );
    
    /#
        if ( !level.colordeck )
        {
            level.colordeck = utility::create_deck( [ ( 1, 0, 0 ), ( 0, 1, 0 ), ( 0, 0, 1 ), ( 1, 1, 0 ), ( 1, 0, 1 ), ( 0, 1, 1 ), ( 0.9, 0.45, 0.9 ), ( 0.75, 0.75, 0.75 ), ( 1, 1, 1 ), ( 0.24, 0.36, 0.6 ) ] );
        }
        
        debug_color = level.colordeck utility::deck_draw();
        drawdebug = getdvarint( @"hash_4a24904261af67d7", 0 );
    #/
    
    function_5700c9c066b8f48b( squadid );
    squaddies = aigetsquadmembers( squadid );
    endtime = level.var_85106271d80e943c ?? 15000;
    
    foreach ( member in squaddies )
    {
        member.disperseparams = spawnstruct();
        member.disperseparams.endtime = gettime() + endtime;
        member val::reset( "agent_disperse", "disabledropfromcombat" );
        member val::set( "agent_disperse", "disabledropfromcombat", 1 );
        wait randomfloatrange( 0.3, 0.6 );
        member clearbtgoal( 0 );
        member thread function_1a5acd5a31a629f3( player );
        
        if ( member.enemy && member.enemy != player )
        {
            foreach ( othermember in squaddies )
            {
                if ( othermember == member )
                {
                    continue;
                }
                
                othermember function_6f48355e7c01f891( member );
                othermember notify( #"end_disperse" );
                othermember val::reset( "agent_disperse", "disabledropfromcombat" );
                othermember.disperseparams = undefined;
            }
            
            member notify( #"end_disperse" );
            member val::reset( "agent_disperse", "disabledropfromcombat" );
            member.disperseparams = undefined;
            function_7c3c26c149d3370e( squadid );
            return;
        }
    }
    
    if ( !player || !player::isinlaststand( player ) )
    {
        foreach ( member in squaddies )
        {
            member notify( #"end_disperse" );
            member val::reset( "agent_disperse", "disabledropfromcombat" );
            member.disperseparams = undefined;
        }
        
        function_7c3c26c149d3370e( squadid );
        return;
    }
    
    baserange = level.var_b23f2dff710a71ce ?? 750;
    traveldist = baserange - distance( self.origin, player.origin );
    var_435c736f07ef8567 = vectornormalize2( self.origin - player.origin );
    var_c91df154a78b4d68 = self function_c0c45783d07df34c( self.origin + var_435c736f07ef8567 * traveldist );
    targetpos = var_c91df154a78b4d68;
    
    /#
        if ( drawdebug )
        {
            utility::draw_circle( targetpos, 8, debug_color, 1, 0, int( endtime / getframeduration() ) );
            thread utility::draw_line_for_time( self.origin, targetpos, 1, 1, 1, endtime / 1000 );
            thread utility::function_95445a6684f51c52( squadid + "<dev string:x37b>", self.origin + ( 0, 0, -16 ), debug_color, 1, 0.75, endtime / 1000 );
            thread utility::function_95445a6684f51c52( squadid + "<dev string:x38a>", targetpos, debug_color, 1, 0.75, endtime / 1000 );
        }
    #/
    
    var_3d8b6c4c308f0ffe = player getnearesttacpoint();
    
    if ( var_3d8b6c4c308f0ffe && var_3d8b6c4c308f0ffe.var_e94b81e2231e2a9 )
    {
        var_82706b543826cb95 = function_e28790b34530b29( var_3d8b6c4c308f0ffe.var_e94b81e2231e2a9, var_435c736f07ef8567 );
        
        if ( var_82706b543826cb95 && var_82706b543826cb95 != var_3d8b6c4c308f0ffe.var_e94b81e2231e2a9 )
        {
            curdist = distance( var_3d8b6c4c308f0ffe.var_e94b81e2231e2a9.origin, var_82706b543826cb95.origin );
            
            if ( curdist < baserange )
            {
                var_74a17ff37e043cc0 = function_e28790b34530b29( var_82706b543826cb95, var_435c736f07ef8567, var_3d8b6c4c308f0ffe.var_e94b81e2231e2a9 );
                
                if ( var_82706b543826cb95 != var_74a17ff37e043cc0 )
                {
                    var_82706b543826cb95 = var_74a17ff37e043cc0;
                }
            }
            
            /#
                if ( drawdebug )
                {
                    utility::draw_circle( var_82706b543826cb95.origin, 8, debug_color, 1, 0, int( endtime / getframeduration() ) );
                    thread utility::function_95445a6684f51c52( squadid + "<dev string:x39f>", var_82706b543826cb95.origin, debug_color, 1, 0.75, endtime / 1000 );
                }
            #/
            
            navzoneindex = getzoneindexforzonenode( var_82706b543826cb95 );
            possiblepoints = getzonetacpoints( navzoneindex );
            
            if ( possiblepoints )
            {
                chosenpoint = possiblepoints[ randomint( possiblepoints.size ) ];
                targetpos = chosenpoint.origin;
                
                /#
                    if ( drawdebug )
                    {
                        utility::draw_circle( targetpos, 8, debug_color, 1, 0, int( endtime / getframeduration() ) );
                        thread utility::function_95445a6684f51c52( squadid + "<dev string:x3b4>" + ( 0, 0, -16 ), targetpos, debug_color, 1, 0.75, endtime / 1000 );
                    }
                #/
            }
        }
        
        var_7e1f8e9f852dcf49 = function_4eb12d429d3e4cf6( targetpos, 360, player.origin, targetpos );
        
        if ( var_7e1f8e9f852dcf49 )
        {
            targetpos = var_7e1f8e9f852dcf49;
        }
        else
        {
            targetpos = self getclosestreachablepointonnavmesh( targetpos );
        }
    }
    else
    {
        var_7e1f8e9f852dcf49 = function_4eb12d429d3e4cf6( var_c91df154a78b4d68, 256, player.origin, var_c91df154a78b4d68 );
        
        if ( var_7e1f8e9f852dcf49 )
        {
            targetpos = self getclosestreachablepointonnavmesh( var_7e1f8e9f852dcf49 );
            
            /#
                if ( drawdebug )
                {
                    utility::draw_circle( targetpos, 8, debug_color, 1, 0, int( endtime / getframeduration() ) );
                    utility::function_95445a6684f51c52( squadid + "<dev string:x3d1>" + ( 0, 0, -16 ), targetpos, debug_color, 1, 0.75, endtime / 1000 );
                }
            #/
        }
        else
        {
            targetpos = self getclosestreachablepointonnavmesh( var_c91df154a78b4d68 );
        }
    }
    
    if ( targetpos )
    {
        navpoints = getrandomnavpoints( targetpos, 250, squaddies.size );
        
        foreach ( member in squaddies )
        {
            if ( !isdefined( navindex ) )
            {
                navindex = 0;
            }
            
            agent_type = tolower( member.agent_type );
            
            if ( issubstr( agent_type, "riot" ) )
            {
                member thread function_9e0cd236b437e0f6( endtime );
                member.var_ee914ad666562200 = 1;
            }
            
            member setbtgoalpos( 0, navpoints[ navindex ] );
            member setbtgoalradius( 0, 96 );
            navindex++;
        }
    }
}

// Namespace ai_behavior
// Params 1
// Checksum 0x83d6201d, Offset: 0xa85c
// Size: 0xb2
function function_1a5acd5a31a629f3( player )
{
    self endon( #"death" );
    self endon( #"end_disperse" );
    
    while ( gettime() < self.disperseparams.endtime && isdefined( player ) && player::isinlaststand( player ) )
    {
        if ( self.enemy && self.enemy != player )
        {
            break;
        }
        
        wait 0.5;
    }
    
    val::reset( "agent_disperse", "disabledropfromcombat" );
    self.disperseparams = undefined;
    self notify( #"end_disperse" );
    self clearbtgoal( 0 );
    function_7c3c26c149d3370e( function_8398629a6c526ce3( self ) );
}

// Namespace ai_behavior
// Params 4
// Checksum 0x1b703c1c, Offset: 0xa916
// Size: 0x1aa
function function_9d2c1316475075bb( agent, itemtype, var_3dcfda70c12cc8a1, behaviortimeout = -1 )
{
    self notify( #"hash_4392ab4a6cdf38a7" );
    self endon( #"hash_4392ab4a6cdf38a7" );
    agent endon( #"death" );
    agent endon( #"cancelbehavior" );
    agent.encounterbehavior = "searchingForItem";
    behaviorcenter = agent.origin;
    lootitem = undefined;
    starttime = gettime();
    
    if ( behaviortimeout > 0 )
    {
        endtime = starttime + behaviortimeout * 1000;
    }
    
    while ( !lootitem )
    {
        wait 1;
        
        if ( endtime && gettime() > endtime )
        {
            return;
        }
        
        lootitem = function_ed178fae14313f3d( agent, itemtype );
        
        if ( !lootitem && var_3dcfda70c12cc8a1 )
        {
            random_x = randomfloatrange( 256, 512 ) * ( randomint( 100 ) > 50 ? 1 : -1 );
            random_y = randomfloatrange( 256, 512 ) * ( randomint( 100 ) > 50 ? 1 : -1 );
            var_cbf0098919b9f972 = ( behaviorcenter[ 0 ] + random_x, behaviorcenter[ 1 ] + random_y, behaviorcenter[ 2 ] );
            
            if ( distance2d( agent.origin, var_cbf0098919b9f972 ) > 16 )
            {
                agent _setgoalpos( var_cbf0098919b9f972, 8 );
                agent thread function_7d1c597e7c5c5b7b( agent );
                agent utility::waittill_any_timeout( 6, "goal" );
            }
        }
        
        agent.goalradius = 1024;
    }
    
    return lootitem;
}

// Namespace ai_behavior
// Params 2
// Checksum 0xe316a380, Offset: 0xaac9
// Size: 0xc0
function function_ed178fae14313f3d( agent, itemtype )
{
    scriptablesarray = getlootscriptablearrayinradius( undefined, undefined, agent.origin, 1024 );
    
    foreach ( scriptable in scriptablesarray )
    {
        if ( scriptable.type == itemtype && !scriptable.var_ee6ebfea66bb219e )
        {
            return scriptable;
        }
    }
}

// Namespace ai_behavior
// Params 3
// Checksum 0x4a2e80ac, Offset: 0xab91
// Size: 0x1cd
function function_14da6b9ee8501532( agent, lootitem, var_3ea5c5f9eb4a37a )
{
    self notify( #"hash_5ae4b0020364caed" );
    self endon( #"hash_5ae4b0020364caed" );
    agent endon( #"death" );
    agent endon( #"itemclaimed" );
    agent.encounterbehavior = "pickingUpItem";
    itemtype = lootitem.type;
    
    if ( !isdefined( lootitem.var_ee6ebfea66bb219e ) )
    {
        lootitem.var_ee6ebfea66bb219e = agent;
        level thread function_6efe5e8fcef7c39c( agent, lootitem );
    }
    
    agent thread function_f3ecd0cc2ab380fb( agent, lootitem );
    agent.startinteractionimmediate = 0;
    agent.disablearrivals = 0;
    agent.disableexits = 0;
    agent thread function_d8cf7f7e0992841b( agent, 1, 2, "pickup_weapon01", lootitem.origin, undefined, 1, -1, 1 );
    agent waittill( #"pickup_item" );
    
    if ( !lootitem )
    {
        agent thread function_47fd28ec3cfc5130( agent, itemtype );
        agent notify( #"itemclaimed" );
    }
    
    if ( issubstr( itemtype, "loot_weapon" ) )
    {
        bundlename = lootitem.var_6828becb300b1c44.itembundlename;
        
        if ( !isdefined( bundlename ) )
        {
            agent thread function_47fd28ec3cfc5130( agent, itemtype );
            agent notify( #"itemclaimed" );
        }
        
        weaponobj = item_weapon::function_477bf1207c6672a5( getscriptbundle( bundlename ) );
        agent agent_utils::overrideagentsettings( undefined, undefined, weaponobj );
    }
    
    if ( lootitem getscriptableisreserved() && lootitem getscriptableisloot() )
    {
        lootitem pickups::deletescriptableinstance();
    }
    
    agent.encounterbehavior = "none";
    
    if ( isdefined( var_3ea5c5f9eb4a37a ) )
    {
        agent thread [[ var_3ea5c5f9eb4a37a ]]( agent );
    }
}

// Namespace ai_behavior
// Params 2
// Checksum 0xa00328e6, Offset: 0xad66
// Size: 0x3a
function function_6efe5e8fcef7c39c( agent, lootitem )
{
    while ( isdefined( lootitem ) )
    {
        if ( !isalive( agent ) )
        {
            lootitem.var_ee6ebfea66bb219e = undefined;
            return;
        }
        
        wait 0.5;
    }
}

// Namespace ai_behavior
// Params 3
// Checksum 0xf9c9a6f9, Offset: 0xada8
// Size: 0xb3
function function_f3ecd0cc2ab380fb( agent, lootitem, var_fbba6922d2534c2 = 1 )
{
    self notify( #"hash_a76ba9c5886ba74a" );
    self endon( #"hash_a76ba9c5886ba74a" );
    itemtype = lootitem.type;
    agent endon( #"death" );
    
    while ( isdefined( lootitem ) && !lootitem.var_ee6ebfea66bb219e )
    {
        waitframe();
    }
    
    if ( isdefined( lootitem ) && lootitem.var_ee6ebfea66bb219e == agent )
    {
        return;
    }
    
    agent notify( #"itemclaimed" );
    
    if ( var_fbba6922d2534c2 )
    {
        agent thread function_47fd28ec3cfc5130( agent, itemtype );
    }
}

// Namespace ai_behavior
// Params 5
// Checksum 0xaaea7fde, Offset: 0xae63
// Size: 0xd6
function function_47fd28ec3cfc5130( agent, itemtype, var_3ea5c5f9eb4a37a, var_3dcfda70c12cc8a1 = 1, var_3a237ab5e312f9ba = 1 )
{
    self notify( #"hash_af0cfc551b759f59" );
    self endon( #"hash_af0cfc551b759f59" );
    agent endon( #"death" );
    agent endon( #"cancelbehavior" );
    agent.encounterbehavior = "searchingForItem";
    
    while ( agent.primaryweapon.classname == "none" )
    {
        targetitem = function_9d2c1316475075bb( agent, itemtype, var_3dcfda70c12cc8a1 );
        
        if ( isdefined( targetitem ) )
        {
            agent function_14da6b9ee8501532( agent, targetitem, var_3ea5c5f9eb4a37a );
        }
        
        if ( !var_3a237ab5e312f9ba )
        {
            return;
        }
    }
}

// Namespace ai_behavior
// Params 1
// Checksum 0x606d9533, Offset: 0xaf41
// Size: 0x11c
function function_636d98a4963fbcc( agent )
{
    self notify( #"hash_bd2cb1f07a989cb1" );
    self endon( #"hash_bd2cb1f07a989cb1" );
    agent endon( #"death" );
    agent endon( #"cancelbehavior" );
    agent.encounterbehavior = "babyWander";
    behaviorcenter = agent.origin;
    
    while ( true )
    {
        random_x = randomfloatrange( 64, 128 ) * ( randomint( 100 ) > 50 ? 1 : -1 );
        random_y = randomfloatrange( 64, 128 ) * ( randomint( 100 ) > 50 ? 1 : -1 );
        var_cbf0098919b9f972 = ( behaviorcenter[ 0 ] + random_x, behaviorcenter[ 1 ] + random_y, behaviorcenter[ 2 ] );
        
        if ( distance2d( agent.origin, var_cbf0098919b9f972 ) > 16 )
        {
            agent _setgoalpos( var_cbf0098919b9f972, 8 );
            agent thread function_7d1c597e7c5c5b7b( agent );
            agent utility::waittill_any_timeout( 6, "goal" );
        }
        
        wait randomfloatrange( 1, 3 );
    }
}

// Namespace ai_behavior
// Params 1
// Checksum 0x2cd834ec, Offset: 0xb065
// Size: 0xbb
function function_54575350214cae8b( agent )
{
    if ( agent.leaderscore )
    {
        return;
    }
    
    min = 0;
    max = 100;
    offset = ( agent.tier - 1 ) * 200;
    
    if ( issubstr( agent.agent_type, "squadlead" ) )
    {
        offset += 100;
    }
    
    min += offset;
    max += offset;
    
    if ( agent.primaryweapon.basename == "none" )
    {
        agent.leaderscore = min;
        return;
    }
    
    agent.leaderscore = randomfloatrange( min, max );
}

// Namespace ai_behavior
// Params 3
// Checksum 0xe6550700, Offset: 0xb128
// Size: 0x239
function function_6e3aa7093cbf0f38( agents, fleedistance, specificleader )
{
    if ( isagent( agents ) )
    {
        agents = [ agents ];
    }
    
    if ( specificleader && isagent( specificleader ) )
    {
        leader = specificleader;
    }
    else
    {
        leader = utility::array_random( agents );
    }
    
    leader notify( #"cancelbehavior" );
    leader.encounterbehavior = "fleeing";
    
    foreach ( agent in agents )
    {
        agent notify( #"cancelbehavior" );
        agent.encounterbehavior = "fleeing";
    }
    
    startorigin = leader.origin;
    fleeorigin = getclosestpointonnavmesh( startorigin + rotatevector( ( fleedistance, 0, 0 ), ( 0, randomfloatrange( 0, 359 ), 0 ) ) );
    
    if ( leader.followers )
    {
        arraycombine( leader.followers, agents );
    }
    else
    {
        leader.followers = agents;
    }
    
    leader thread behavior_combatRushOrigin( leader, fleeorigin, 256, undefined, undefined, undefined, undefined, undefined, &function_793734276ff6943 );
    
    foreach ( agent in agents )
    {
        if ( agent == leader )
        {
            continue;
        }
        
        agent setgoalentity( leader, 500 );
        
        if ( agent.primaryweapon.basename == "none" )
        {
            agent function_7bbd01e514ea0578( 256 );
        }
        else
        {
            agent function_7bbd01e514ea0578( 100 );
        }
        
        agent notify( #"cancelbehavior" );
    }
}

// Namespace ai_behavior
// Params 2
// Checksum 0xc6a63ca8, Offset: 0xb369
// Size: 0xe2
function function_793734276ff6943( agent, targetent )
{
    agent.encounterbehavior = "none";
    
    foreach ( follower in agent.followers )
    {
        follower thread behavior_GuardWander( follower, 512 );
        follower.encounterbehavior = "none";
    }
    
    agent.followers = [];
    
    if ( agent.var_b5cd713a6b7796cf )
    {
        agent thread [[ agent.var_b5cd713a6b7796cf ]]( agent );
    }
}

// Namespace ai_behavior
// Params 3
// Checksum 0x42e31636, Offset: 0xb453
// Size: 0x352
function function_e860796c11b80742( agents, searchdistance, specificleader )
{
    if ( isagent( agents ) )
    {
        agents = [ agents ];
    }
    
    if ( specificleader && isagent( specificleader ) )
    {
        leader = specificleader;
    }
    else
    {
        agents = arrayrandomize( agents );
        
        foreach ( agent in agents )
        {
            if ( agent.primaryweapon.basename != "none" )
            {
                leader = agent;
                break;
            }
        }
        
        leader = utility::array_random( agents );
    }
    
    leader notify( #"cancelbehavior" );
    leader.encounterbehavior = "huntingEnemies";
    
    foreach ( agent in agents )
    {
        agent notify( #"cancelbehavior" );
        agent.encounterbehavior = "huntingEnemies";
    }
    
    var_5d5cda2fe522c69 = getaiarrayinradius( leader.origin, 10000 );
    
    foreach ( ent in var_5d5cda2fe522c69 )
    {
        if ( isalive( ent ) && isagent( ent ) && issubstr( ent.agent_type, "enemy" ) )
        {
            targetenemy = ent;
            break;
        }
    }
    
    if ( leader.followers )
    {
        arraycombine( leader.followers, agents );
    }
    else
    {
        leader.followers = agents;
    }
    
    leader thread behavior_combatRushOrigin( leader, targetenemy.origin, 256, undefined, undefined, undefined, undefined, undefined, &function_f7d1f7b45f650083 );
    
    foreach ( agent in agents )
    {
        if ( agent == leader )
        {
            continue;
        }
        
        agent setgoalentity( leader, 500 );
        
        if ( agent.primaryweapon.basename == "none" )
        {
            agent function_7bbd01e514ea0578( 256 );
        }
        else
        {
            agent function_7bbd01e514ea0578( 100 );
        }
        
        agent notify( #"cancelbehavior" );
    }
}

// Namespace ai_behavior
// Params 2
// Checksum 0xe9800806, Offset: 0xb7ad
// Size: 0xe2
function function_f7d1f7b45f650083( agent, targetent )
{
    agent.encounterbehavior = "none";
    
    foreach ( follower in agent.followers )
    {
        follower thread behavior_GuardWander( follower, 512 );
        follower.encounterbehavior = "none";
    }
    
    agent.followers = [];
    
    if ( agent.var_b5cd713a6b7796cf )
    {
        agent thread [[ agent.var_b5cd713a6b7796cf ]]( agent );
    }
}

// Namespace ai_behavior
// Params 2
// Checksum 0xf288a32b, Offset: 0xb897
// Size: 0x15
function function_1a38bc1daa22e6b( agent, players )
{
    
}

// Namespace ai_behavior
// Params 2
// Checksum 0xf381df8b, Offset: 0xb8b4
// Size: 0x15
function function_b55995c1eac6c2d4( agent, player )
{
    
}

// Namespace ai_behavior
// Params 2
// Checksum 0x181bccbe, Offset: 0xb8d1
// Size: 0x42
function function_982f22468c28a21b( agent, lootitem )
{
    if ( lootitem )
    {
        pingindex = level.players[ 0 ] calloutmarkerping::function_920a63c06abdefe8( lootitem.index );
    }
}

// Namespace ai_behavior
// Params 2
// Checksum 0xc5bc433d, Offset: 0xb91b
// Size: 0x71
function ai_droploot( agent, lootitem )
{
    dropstruct = pickups::function_f71dd588dc4f6288();
    droporigin = agent.origin;
    dropangles = agent.angles;
    spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( droporigin, dropangles );
    namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( lootitem, 1, spawnoptions );
}

/#

    // Namespace ai_behavior
    // Params 0
    // Checksum 0x3e2ada0c, Offset: 0xb994
    // Size: 0x2de, Type: dev
    function function_1b8d4963cd0cf97d()
    {
        while ( !isdefined( level.struct_class_names ) )
        {
            waitframe();
        }
        
        cqbspawns = utility::getstructarray( "<dev string:x3e5>", "<dev string:x3f2>" );
        spawnnode = utility::array_random( cqbspawns );
        cqbcovernodes = [];
        var_8144cabf597859eb = [];
        nodesaround = getnodesinradius( spawnnode.origin, 512, 0, 512 );
        
        foreach ( node in nodesaround )
        {
            if ( isdefined( node.script_noteworthy ) && issubstr( node.script_noteworthy, "<dev string:x404>" ) )
            {
                if ( issubstr( node.script_noteworthy, "<dev string:x40d>" ) )
                {
                    node.var_a27a7618c2d6de44 = 1;
                    var_8144cabf597859eb[ var_8144cabf597859eb.size ] = node;
                    continue;
                }
                
                cqbcovernodes[ cqbcovernodes.size ] = node;
            }
        }
        
        wait 10;
        covernode = cqbcovernodes[ 0 ];
        aitype = ai_mp_controller::function_f7aef6871cda828( "<dev string:x417>" );
        level.cqbagent = ai_mp_controller::ai_mp_requestspawnagent( aitype, covernode.origin, spawnnode.angles, "<dev string:x41a>", "<dev string:x41f>", "<dev string:x42e>" );
        
        if ( isdefined( level.cqbagent ) )
        {
            level thread function_da2319a87bd58fab( level.cqbagent, cqbcovernodes );
            level thread function_b9d8b7534babdade( level.cqbagent, covernode.origin );
        }
        
        covernode = cqbcovernodes[ 1 ];
        aitype = ai_mp_controller::function_f7aef6871cda828( "<dev string:x417>" );
        level.cqbagent = ai_mp_controller::ai_mp_requestspawnagent( aitype, covernode.origin, spawnnode.angles, "<dev string:x41a>", "<dev string:x41f>", "<dev string:x42e>" );
        
        if ( isdefined( level.cqbagent ) )
        {
            level thread function_da2319a87bd58fab( level.cqbagent, cqbcovernodes );
            level thread function_b9d8b7534babdade( level.cqbagent, covernode.origin );
        }
        
        covernode = var_8144cabf597859eb[ 0 ];
        aitype = ai_mp_controller::function_f7aef6871cda828( "<dev string:x434>" );
        level.cqbagent = ai_mp_controller::ai_mp_requestspawnagent( aitype, covernode.origin, spawnnode.angles, "<dev string:x41a>", "<dev string:x41f>", "<dev string:x42e>" );
        
        if ( isdefined( level.cqbagent ) )
        {
            cqb_usenode( level.cqbagent, covernode );
            level thread function_b9d8b7534babdade( level.cqbagent, covernode.origin );
        }
    }

    // Namespace ai_behavior
    // Params 2
    // Checksum 0x1fc8ccff, Offset: 0xbc7a
    // Size: 0xa5, Type: dev
    function function_da2319a87bd58fab( agent, nodes )
    {
        agent endon( #"death" );
        agent endon( #"endcqb" );
        switchtime = 5;
        currenttime = 0;
        interval = 1;
        node = undefined;
        
        while ( true )
        {
            if ( currenttime >= switchtime )
            {
                currenttime = 0;
                cqb_releasenode( node );
                node = function_cc48d4b6e20f0e6a( nodes );
                cqb_usenode( agent, node );
                thread function_ff449be32e0ccd07( agent, node, switchtime );
            }
            
            wait 1;
            currenttime += interval;
        }
    }

    // Namespace ai_behavior
    // Params 2
    // Checksum 0x1a12d393, Offset: 0xbd27
    // Size: 0x14f, Type: dev
    function function_293c17d0a3b70621( agent, nodes )
    {
        agent endon( #"death" );
        
        while ( true )
        {
            foreach ( node in nodes )
            {
                sphere( node.origin, 32, ( 1, 1, 0 ) );
                
                foreach ( node2 in nodes )
                {
                    if ( node == node2 )
                    {
                        continue;
                    }
                    
                    line( node.origin, node2.origin, ( 0, 1, 0 ) );
                }
            }
            
            waitframe();
        }
    }

    // Namespace ai_behavior
    // Params 3
    // Checksum 0x93cb22eb, Offset: 0xbe7e
    // Size: 0xc0, Type: dev
    function function_ff449be32e0ccd07( agent, node, time )
    {
        if ( !isdefined( node ) )
        {
            return;
        }
        
        agent endon( #"death" );
        interval = 0.05;
        currenttime = 0;
        
        while ( !isdefined( time ) || currenttime < time )
        {
            agent thread debug::drawsphere( node.origin, 16, interval, ( 1, 0, 1 ) );
            agent thread debug_utility::drawline( node.origin, agent.origin, interval, ( 0, 1, 1 ) );
            wait interval;
            currenttime += interval;
        }
    }

    // Namespace ai_behavior
    // Params 2
    // Checksum 0x92371ab8, Offset: 0xbf46
    // Size: 0xfe, Type: dev
    function function_c1de6a348f373711( agent, nodes )
    {
        agent endon( #"death" );
        interval = 0.05;
        
        while ( true )
        {
            foreach ( node in nodes )
            {
                agent thread debug::drawsphere( agent.origin, 16, 0.05, ( 0, 0, 1 ) );
                agent thread debug_utility::drawline( node.origin, agent.origin, interval, ( 0, 1, 0 ) );
            }
            
            wait interval;
        }
    }

    // Namespace ai_behavior
    // Params 0
    // Checksum 0xec6a27f6, Offset: 0xc04c
    // Size: 0x372, Type: dev
    function function_2272871b72e71f8c()
    {
        level endon( #"game_ended" );
        agents = [];
        interval = 0.05;
        
        while ( true )
        {
            if ( getdvarint( @"hash_b85b66dbdc0853f9", 0 ) == 1 )
            {
                foreach ( agent in agents )
                {
                    agent kill();
                }
                
                waitframe();
                team = level.players[ 0 ].team;
                
                if ( isbrgamemode() )
                {
                    team = "<dev string:x43c>";
                }
                
                agents = ai_reinforcements::function_ee97bd279a52ed16( 4, level.players[ 0 ].origin, "<dev string:x455>", "<dev string:x41f>", "<dev string:x45e>", undefined, team, undefined, 256, 257 );
                setdevdvar( @"hash_b85b66dbdc0853f9", 0 );
            }
            
            if ( getdvarint( @"hash_b85b66dbdc0853f9", 0 ) == 2 )
            {
                if ( level.var_3785341350ae5ae7 )
                {
                    patrolgroupname = ai_formation::function_e9aabb85b0d12949();
                }
                
                foreach ( agent in agents )
                {
                    agent thread behavior_combatRushOrigin( agent, level.players[ 0 ].origin, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, patrolgroupname );
                }
                
                setdevdvar( @"hash_b85b66dbdc0853f9", 0 );
            }
            
            if ( getdvarint( @"hash_b85b66dbdc0853f9", 0 ) == 3 )
            {
                agents = ai_reinforcements::function_d0a9530035c6dc35( level.players[ 0 ].origin, 50000, level.players[ 0 ].team, 100, "<dev string:x46d>", undefined, undefined, 1 );
                setdevdvar( @"hash_b85b66dbdc0853f9", 0 );
            }
            
            if ( getdvarint( @"hash_b85b66dbdc0853f9", 0 ) == 4 )
            {
                foreach ( agent in agents )
                {
                    agent thread function_556a769454945ed0( agent, level.var_6702dfa878d76075 );
                }
                
                setdevdvar( @"hash_b85b66dbdc0853f9", 0 );
            }
            
            foreach ( agent in agents )
            {
                agent thread debug::drawsphere( agent.origin, 32, interval, ( 1, 0, 1 ) );
            }
            
            wait interval;
        }
    }

#/
