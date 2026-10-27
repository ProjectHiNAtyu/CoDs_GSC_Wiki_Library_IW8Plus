// scripts\mp\br\gametypes\br_rackets.gsc  (hash_15361dd7618df159.gscc) (size: 5474 Bytes / 0x1562 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe2ca354f (3804902735)
// size ...... 5474 (0x1562)
// includes .. 7   (offset: 0x1446)
// strings ... 16  (offset: 0x147e)
// dev strs .. 2   (offset: 0x154a)
// exports ... 12  (offset: 0xd82)
// cseg ...... 0x1d4 + 0xbae (0xd82)
// imports ... 42  (offset: 0xf62)
// animtree1 . 0   (offset: 0x1562)
// animtree2 . 0   (offset: 0x1562)
#using scripts\common\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\flags;
#using scripts\mp\objidpoolmanager;

#namespace br_rackets;

// Namespace br_rackets
// Params 0
// Checksum 0x4f2e1c9a, Offset: 0x1f2
// Size: 0x33d
function init()
{
    level.brgametype.racketsenabled = getdvarint( @"hash_158f6c01ccefb107", 0 ) == 1;
    
    if ( !level.brgametype.racketsenabled )
    {
        return;
    }
    
    level.brgametype.racketsnumber = getdvarint( @"hash_beef8246b709c849", 5 );
    level.brgametype.var_5e4a4a3341dd8134 = getdvarint( @"hash_ec1144da8d0ebb36", 4 );
    level.brgametype.var_d3a25a9e6dff7e4b = getdvarint( @"hash_ba144c4a820cd8f9", 1 );
    level.brgametype.var_67e26929d56f508 = getdvarint( @"hash_e2660ec466d23bf9", 100 );
    level.brgametype.var_e0533d9d06e53e5e = pow( getdvarint( @"hash_7000264c08e7ac45", 500 ), 2 );
    level.brgametype.var_92c71b64c7c15f2a = getdvarint( @"hash_3a8f51b0eaa8b895", 3 );
    level.brgametype.var_2a1349505ec4c80c = getdvarint( @"hash_22c52597541ec14c", 100 );
    var_2da5c596ed4b34b4 = utility::getstructarray( "racket", "targetname" );
    
    if ( var_2da5c596ed4b34b4.size == 0 || level.brgametype.racketsnumber == 0 )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    if ( var_2da5c596ed4b34b4.size < level.brgametype.racketsnumber )
    {
        assertmsg( "<dev string:x5b>" );
        level.brgametype.racketsnumber = var_2da5c596ed4b34b4.size;
    }
    
    var_2da5c596ed4b34b4 = arrayrandomize( var_2da5c596ed4b34b4 );
    
    foreach ( racket in var_2da5c596ed4b34b4 )
    {
        function_c90fc7899a1a8752( racket );
    }
    
    level.brgametype.activerackets = [];
    
    for ( i = 0; i < level.brgametype.racketsnumber ; i++ )
    {
        racket = var_2da5c596ed4b34b4[ i ];
        level.brgametype.activerackets[ level.brgametype.activerackets.size ] = racket;
    }
    
    flags::gameflagwait( "prematch_fade_done" );
    ai_mp_controller::aibudget_registercategory( "racket" );
    
    foreach ( racket in level.brgametype.activerackets )
    {
        thread racket_activate( racket );
    }
}

// Namespace br_rackets
// Params 1
// Checksum 0x6d6b1d5f, Offset: 0x537
// Size: 0x17f
function function_c90fc7899a1a8752( racket )
{
    racket.guardnodes = [];
    racket.cachenodes = [];
    racket.flagnodes = [];
    var_5a0da6fd00da6b8d = utility::getstructarray( racket.target, "targetname" );
    
    foreach ( node in var_5a0da6fd00da6b8d )
    {
        if ( !isdefined( node.script_noteworthy ) )
        {
            continue;
        }
        
        script_noteworthy = tolower( node.script_noteworthy );
        
        switch ( script_noteworthy )
        {
            case #"hash_7df245010bdec44e":
                racket.guardnodes[ racket.guardnodes.size ] = node;
                break;
            case #"hash_dc0a55772fe305c5":
                racket.cachenodes[ racket.cachenodes.size ] = node;
                break;
            case #"hash_f4cfb31523436f37":
                racket.flagnodes[ racket.flagnodes.size ] = node;
                break;
            default:
                break;
        }
    }
}

// Namespace br_rackets
// Params 1
// Checksum 0x4f4afd11, Offset: 0x6be
// Size: 0xc3
function racket_activate( racket )
{
    level endon( #"game_ended" );
    racket.agents = [];
    racket.guardnodes = arrayrandomize( racket.guardnodes );
    function_53fa6fe6644d0942( racket, level.brgametype.var_5e4a4a3341dd8134, 1 );
    function_53fa6fe6644d0942( racket, level.brgametype.var_d3a25a9e6dff7e4b, 2 );
    ai_mp_controller::function_7415f2b98f305b24( 0 );
    racket.cachenodes = arrayrandomize( racket.cachenodes );
    function_39c61219aaec7cab( racket );
    racket_spawnflags( racket );
    function_80a546d9de2e55fc( racket );
    thread function_42ecc6b1410b5278( racket );
}

// Namespace br_rackets
// Params 3
// Checksum 0x4b7f2691, Offset: 0x789
// Size: 0xe0
function function_53fa6fe6644d0942( racket, number, tier )
{
    if ( racket.guardnodes.size < number )
    {
        msg = "Not enough guard nodes with target : " + racket.target;
        assertmsg( msg );
        number = racket.guardnodes.size;
    }
    
    for ( i = 0; i < number ; i++ )
    {
        guardnode = racket.guardnodes[ 0 ];
        agent = function_8cde0d0fde87a3c5( racket, guardnode, tier );
        racket.agents[ racket.agents.size ] = agent;
        racket.guardnodes[ 0 ] = undefined;
        function_cdc669dbc8ea2101( racket.guardnodes );
    }
}

// Namespace br_rackets
// Params 3
// Checksum 0xcd29ec82, Offset: 0x871
// Size: 0x119
function function_8cde0d0fde87a3c5( racket, guardnode, tier )
{
    basetype = ai_mp_controller::function_3a4bd0fc4d6012b0();
    aitype = ai_mp_controller::function_f7aef6871cda828( basetype, tier );
    spawnlocation = getclosestpointonnavmesh( guardnode.origin + ( 0, 0, 30 ) );
    agent = ai_mp_controller::ai_mp_requestspawnagent( aitype, spawnlocation, undefined, "absolute", "racket" );
    
    if ( isagent( agent ) )
    {
        agent.health = level.brgametype.var_67e26929d56f508;
        agent.maxhealth = level.brgametype.var_67e26929d56f508;
        agent.combatmode = "cover";
        agent.maxsightdistsqrd = level.brgametype.var_e0533d9d06e53e5e;
        agent thread ai_behavior::behavior_GuardStationary( agent, 0, spawnlocation );
        agent thread agent_watchdeath( racket );
        return agent;
    }
}

// Namespace br_rackets
// Params 1
// Checksum 0x8630d689, Offset: 0x993
// Size: 0x116
function function_39c61219aaec7cab( racket )
{
    number = level.brgametype.var_92c71b64c7c15f2a;
    
    if ( racket.cachenodes.size < number )
    {
        msg = "Not enough cache nodes with target : " + racket.target;
        assertmsg( msg );
        number = racket.cachenodes.size;
    }
    
    for ( i = 0; i < number ; i++ )
    {
        node = racket.cachenodes[ i ];
        roll = randomint( 100 );
        cachetype = "br_loot_cache";
        
        if ( roll < level.brgametype.var_2a1349505ec4c80c )
        {
            cachetype = "br_loot_cache_lege";
        }
        
        scriptable = spawnscriptable( cachetype, node.origin, node.angles );
        scriptable setscriptablepartstate( "body", "closed_usable" );
    }
}

// Namespace br_rackets
// Params 1
// Checksum 0x6affcf97, Offset: 0xab1
// Size: 0xd6
function racket_spawnflags( racket )
{
    if ( racket.flagnodes.size < 0 )
    {
        msg = "No flag node found with target : " + racket.target;
        assertmsg( msg );
    }
    
    foreach ( node in racket.flagnodes )
    {
        utility::spawn_model( "fabric_rectangular_aq_flag_windlevel_2_konni", node.origin, node.angles );
    }
}

// Namespace br_rackets
// Params 1
// Checksum 0x3bdeb40d, Offset: 0xb8f
// Size: 0x75
function function_80a546d9de2e55fc( racket )
{
    objidnum = objidpoolmanager::requestobjectiveid( 99 );
    objidpoolmanager::objective_add_objective( objidnum, "active", racket.origin, "hud_icon_objective_rackets", "icon_regular" );
    objective_setbackground( objidnum, 1 );
    objective_setrotateonminimap( objidnum, 1 );
    objective_sethideelevation( objidnum, 1 );
    objidpoolmanager::objective_playermask_showtoall( objidnum );
    racket.objidnum = objidnum;
}

// Namespace br_rackets
// Params 1
// Checksum 0x34e7b47e, Offset: 0xc0c
// Size: 0x3b
function racket_clearobjectiveicon( racket )
{
    objective_delete( racket.objidnum );
    objidpoolmanager::returnobjectiveid( racket.objidnum );
    racket notify( #"cleared" );
}

// Namespace br_rackets
// Params 1
// Checksum 0xc8adb06b, Offset: 0xc4f
// Size: 0xd0
function function_42ecc6b1410b5278( racket )
{
    level endon( #"game_ended" );
    racket endon( #"cleared" );
    
    while ( true )
    {
        if ( br_circle::function_6bf5d4e680297398( racket.origin ) )
        {
            if ( racket.agents.size != 0 )
            {
                foreach ( agent in racket.agents )
                {
                    agent_utility::killagent( agent );
                }
            }
        }
        
        wait 1;
    }
}

// Namespace br_rackets
// Params 1
// Checksum 0x7340708b, Offset: 0xd27
// Size: 0x5b
function agent_watchdeath( racket )
{
    level endon( #"game_ended" );
    self waittill( #"death" );
    racket.agents = arrayremove( racket.agents, self );
    
    if ( racket.agents.size == 0 )
    {
        racket_clearobjectiveicon( racket );
    }
}

