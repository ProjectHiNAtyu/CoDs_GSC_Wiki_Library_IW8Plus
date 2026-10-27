// scripts\mp\br\gametypes\br_activewarzone.gsc  (hash_4210f70884a7b430.gscc) (size: 7843 Bytes / 0x1ea3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x43f56741 (1140156225)
// size ...... 7843 (0x1ea3)
// includes .. 6   (offset: 0x1c8b)
// strings ... 34  (offset: 0x1cbb)
// dev strs .. 1   (offset: 0x1e97)
// exports ... 16  (offset: 0x13a7)
// cseg ...... 0x3b6 + 0xff1 (0x13a7)
// imports ... 51  (offset: 0x1627)
// animtree1 . 0   (offset: 0x1ea3)
// animtree2 . 0   (offset: 0x1ea3)
#using scripts\mp\agents\agent_utils;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\common\utility\game_utility;

#namespace br_activewarzone;

// Namespace br_activewarzone
// Params 0
// Checksum 0xbc605a6f, Offset: 0x3d4
// Size: 0x2e
function activewarzoneinit()
{
    logstring( "ActiveWarzone - Init" );
    ai_mp_controller::aibudget_registercategory( "activeWarzone" );
    br_circle::registercirclecallbacks( 10, &function_83fdbde0bde7b6e9 );
    level thread _watchforcircleclosure();
}

// Namespace br_activewarzone
// Params 0
// Checksum 0x34a64941, Offset: 0x40a
// Size: 0xc0
function function_82e8374a0533d4de()
{
    /#
    #/
    
    agents = function_3b71aa1bfab81002( "activeWarzone" );
    
    foreach ( agent in agents )
    {
        if ( isalive( agent ) && !br_circle_util::ispointinmulticircledanger( agent.origin ) )
        {
            logstring( "ActiveWarzone Kill Active AI in gas at " + agent.origin );
            agent kill();
        }
    }
    
    /#
    #/
}

// Namespace br_activewarzone
// Params 0
// Checksum 0xb5ac3c33, Offset: 0x4d2
// Size: 0xc8
function function_8dc9574aa63ad64b()
{
    /#
    #/
    
    agents = function_d396e3986bace4ee( "activeWarzone" );
    
    foreach ( agent in agents )
    {
        agentdata = function_c62e58693ace9312( agent );
        
        if ( !br_circle_util::ispointinmulticircledanger( agentdata.origin ) )
        {
            logstring( "ActiveWarzone Delete Dormant AI in gas at " + agentdata.origin );
            deletedormant( agent );
        }
    }
    
    /#
    #/
}

// Namespace br_activewarzone
// Params 3
// Checksum 0xcfa95911, Offset: 0x5a2
// Size: 0x162
function function_83fdbde0bde7b6e9( circleorigin, circleradius, thresholdradius )
{
    radiussqr = circleradius * circleradius;
    agents = function_8e8b213809f3c0ef( "activeWarzone" );
    
    foreach ( agent in agents )
    {
        if ( isint( agent ) )
        {
            agentdata = function_c62e58693ace9312( agent );
            distsqr = lengthsquared( agentdata.origin - circleorigin );
            
            if ( distsqr >= radiussqr )
            {
                logstring( "ActiveWarzone Delete Dormant AI in gas at " + agentdata.origin + " - gas center " + circleorigin + " r" + circleradius );
                deletedormant( agent );
            }
            
            continue;
        }
        
        distsqr = lengthsquared( agent.origin - circleorigin );
        
        if ( distsqr >= radiussqr )
        {
            logstring( "ActiveWarzone Kill Active AI in gas at " + agent.origin + " - gas center " + circleorigin + " r" + circleradius );
            agent kill();
        }
    }
}

// Namespace br_activewarzone
// Params 0
// Checksum 0x55f8b5a1, Offset: 0x70c
// Size: 0x2c0
function function_1f89f41b19597c4()
{
    if ( game_utility::function_238d71fc76232bef() )
    {
        return;
    }
    
    dormants = 0;
    denieds = 0;
    nonodes = 0;
    var_402124e03815bb9b = 0;
    volumes = getnoentvolumearray( "building_bounds", #script_noteworthy );
    
    for ( i = 0; i < volumes.size ; i++ )
    {
        aitype = ai_mp_controller::function_f7aef6871cda828( "pistol", 1 );
        agent = spawnai( aitype, volumes[ i ], volumes[ i ].origin, ( 0, 0, 0 ) );
        
        if ( isint( agent ) )
        {
            dormants++;
            var_402124e03815bb9b++;
            
            if ( dormants % 100 == 0 )
            {
                waitframe();
            }
            
            continue;
        }
        
        denieds++;
    }
    
    logstring( "ActiveWarzone - Living World Only Spawns " + var_402124e03815bb9b + "/" + volumes.size );
    level.var_be178957543dff4c = undefined;
    level.lwradius = undefined;
    level.lworigin = undefined;
    waitframe();
    waitframe();
    waitframe();
    
    foreach ( fortress in level.fortressstruct.unusedfortresses )
    {
        if ( !isdefined( fortress.spawnclosetnodes ) || fortress.spawnclosetnodes.size == 0 )
        {
            logstring( "Skipping unused fortresses for no guard nodes at " + fortress.origin );
            nonodes++;
            continue;
        }
        
        aitype = ai_mp_controller::function_f7aef6871cda828( "pistol", 1 );
        var_f6fc93bfefc95d44 = function_f485100614948473( fortress.fortresssize );
        
        for ( i = 0; i < var_f6fc93bfefc95d44 ; i++ )
        {
            spawnnode = fortress.spawnclosetnodes[ randomint( fortress.spawnclosetnodes.size ) ];
            agent = radius_spawnai( aitype, spawnnode.origin, spawnnode.angles, fortress.origin, 120 );
            
            if ( isint( agent ) )
            {
                dormants++;
                
                if ( dormants % 100 == 0 )
                {
                    waitframe();
                }
                
                continue;
            }
            
            denieds++;
        }
    }
    
    logstring( "ActiveWarzone - World AI Spawned Dormant " + dormants );
    logstring( "ActiveWarzone - World AI Denied Spawned " + denieds );
    logstring( "ActiveWarzone - Total Unused fortresses " + level.fortressstruct.unusedfortresses.size );
    logstring( "ActiveWarzone - Unused Fortresses skipped from no Guard Nodes " + nonodes );
    
    /#
        level thread function_b1f1615e42ecb25();
    #/
}

// Namespace br_activewarzone
// Params 1
// Checksum 0x1169e571, Offset: 0x9d4
// Size: 0x62
function br_activewarzone_revive( agent )
{
    agent = self;
    agent.var_8a9c24243e6665a1 = agent.maxsightdistsqrd;
    agent.maxsightdistsqrd = 230400;
    agent.accuracy = 0.4;
    agent setsightconfigtemplateoverride( "star_4" );
    agent.var_3d17d83febcd8fbf = 1;
}

// Namespace br_activewarzone
// Params 4, eflags: 0x4
// Checksum 0xa06ac331, Offset: 0xa3e
// Size: 0x196
function private spawnai( aitype, volume, spawnorigin, spawnangles )
{
    agent = ai_mp_controller::ai_mp_requestspawnagent( aitype, spawnorigin, spawnangles, "low", "activeWarzone", undefined, undefined, undefined, undefined, undefined, undefined, 0, 1, undefined, 1 );
    
    if ( isint( agent ) )
    {
        agent_utils::function_3d1ccb7ed2f7c332( agent, "active", &br_activewarzone_revive );
        patroldestination = undefined;
        bounds = volume getboundshalfsize();
        var_86098ed7a066554d = min( max( bounds[ 0 ], bounds[ 1 ] ), 360 );
        nodes = getnodesinradius( volume.origin, var_86098ed7a066554d, 0, 120, "Cover" );
        
        if ( nodes.size > 0 )
        {
            for ( i = 0; i < nodes.size ; i++ )
            {
                if ( ispointinvolume( nodes[ i ].origin, volume ) )
                {
                    patroldestination = nodes[ i ].origin;
                    break;
                }
            }
        }
        
        if ( isdefined( patroldestination ) )
        {
            pathstruct = spawnstruct();
            pathstruct.path = [ spawnorigin, patroldestination ];
            pathstruct.claimed = 0;
            pathstruct.pingpongpath = 1;
            ai_behavior::function_275a3085a93cd3ad( agent, [ agent ], pathstruct, volume.origin, var_86098ed7a066554d );
        }
        else
        {
            ai_behavior::function_7b154a7c7eb87672( agent, volume.origin, 120, 0 );
        }
    }
    
    return agent;
}

// Namespace br_activewarzone
// Params 5, eflags: 0x4
// Checksum 0xc382135d, Offset: 0xbdd
// Size: 0x196
function private radius_spawnai( aitype, spawnorigin, spawnangles, buildingcenterorigin, var_86098ed7a066554d )
{
    agent = ai_mp_controller::ai_mp_requestspawnagent( aitype, spawnorigin, spawnangles, "low", "activeWarzone", undefined, undefined, undefined, undefined, undefined, undefined, 0, 1, undefined, 1 );
    
    if ( isint( agent ) )
    {
        agent_utils::function_3d1ccb7ed2f7c332( agent, "active", &br_activewarzone_revive );
        patroldestination = undefined;
        var_b012b238e4b0f9d8 = ( buildingcenterorigin[ 0 ], buildingcenterorigin[ 1 ], spawnorigin[ 2 ] );
        nodes = getnodesinradius( var_b012b238e4b0f9d8, var_86098ed7a066554d, 0, 60, "Cover" );
        
        if ( nodes.size > 0 )
        {
            for ( i = 0; i < nodes.size ; i++ )
            {
                if ( distance2dsquared( spawnorigin, nodes[ i ].origin ) >= 9216 )
                {
                    patroldestination = nodes[ i ].origin;
                    break;
                }
            }
        }
        
        if ( !isdefined( patroldestination ) )
        {
            if ( distance2dsquared( spawnorigin, var_b012b238e4b0f9d8 ) >= 9216 )
            {
                patroldestination = var_b012b238e4b0f9d8;
            }
        }
        
        if ( isdefined( patroldestination ) )
        {
            pathstruct = spawnstruct();
            pathstruct.path = [ spawnorigin, patroldestination ];
            pathstruct.claimed = 0;
            pathstruct.pingpongpath = 1;
            ai_behavior::function_275a3085a93cd3ad( agent, [ agent ], pathstruct, var_b012b238e4b0f9d8, var_86098ed7a066554d );
        }
        else
        {
            var_b012b238e4b0f9d8 = ( buildingcenterorigin[ 0 ], buildingcenterorigin[ 1 ], spawnorigin[ 2 ] );
            ai_behavior::function_7b154a7c7eb87672( agent, var_b012b238e4b0f9d8, 120, 0 );
        }
    }
    
    return agent;
}

// Namespace br_activewarzone
// Params 0
// Checksum 0x1b56db7a, Offset: 0xd7c
// Size: 0x53
function function_75518ded03d0fe53()
{
    level endon( #"game_ended" );
    level waittill( #"infils_ready" );
    var_94ccdff4ee0f5e32 = getdvarint( @"hash_1f417cb6adc43c30", 240 );
    wait var_94ccdff4ee0f5e32;
    logstring( "ActiveWarzone - Updating AI weapons at " + var_94ccdff4ee0f5e32 + " seconds" );
    function_38963e91d4440eea();
}

// Namespace br_activewarzone
// Params 0
// Checksum 0x139e37b6, Offset: 0xdd7
// Size: 0x72
function _watchforcircleclosure()
{
    level endon( #"game_ended" );
    var_a7c7437462a16865 = getdvarint( @"hash_4dc5c5741b807bae", 5 );
    
    if ( var_a7c7437462a16865 )
    {
        while ( true )
        {
            level waittill( #"br_circle_set" );
            circleindex = level.br_circle.circleindex + 1;
            
            if ( circleindex >= var_a7c7437462a16865 )
            {
                function_e4a79ca4c6bb67e5();
                return;
            }
        }
    }
}

// Namespace br_activewarzone
// Params 1, eflags: 0x4
// Checksum 0xf4fdced2, Offset: 0xe51
// Size: 0x1a
function private deletedormant( id )
{
    agent_utils::function_585134f4744c6f80( id, "activeWarzone" );
}

// Namespace br_activewarzone
// Params 0, eflags: 0x4
// Checksum 0x7712e2c6, Offset: 0xe73
// Size: 0xaf
function private function_e4a79ca4c6bb67e5()
{
    logstring( "ActiveWarzone - Deleting All " + level.var_87bd0b3632631717.size + " dormant AI" );
    dormants = function_d396e3986bace4ee( "activeWarzone" );
    
    foreach ( id in dormants )
    {
        logstring( "ActiveWarzone - Deleting dormant id #" + id );
        deletedormant( id );
    }
}

// Namespace br_activewarzone
// Params 0, eflags: 0x4
// Checksum 0xd9dd0f6, Offset: 0xf2a
// Size: 0x121
function private function_38963e91d4440eea()
{
    dormants = function_d396e3986bace4ee( "activeWarzone" );
    logstring( "ActiveWarzone - Upgrading " + dormants.size + " dormant AI" );
    
    foreach ( id in dormants )
    {
        infopackage = agent_utils::function_d77442145c568a4e( id );
        
        if ( infopackage )
        {
            if ( randomint( 5 ) == 0 )
            {
                aitype = ai_mp_controller::function_f7aef6871cda828( "shotgun", 1 );
            }
            else
            {
                aitype = ai_mp_controller::function_f7aef6871cda828( "smg", 1 );
            }
            
            logstring( "ActiveWarzone - Upgrading dormant id #" + id + " to " + aitype );
            infopackage.aitype = aitype;
            agent_utils::function_86157c3fbf5fdea2( id, infopackage );
            continue;
        }
        
        logstring( "ActiveWarzone - Cant Find Dormant AI " + id + " - This should never happen" );
    }
}

// Namespace br_activewarzone
// Params 1, eflags: 0x4
// Checksum 0xf596a891, Offset: 0x1053
// Size: 0x60
function private function_f485100614948473( fortresssize )
{
    if ( fortresssize == "large" || fortresssize == "hero" )
    {
        return getdvarint( @"hash_3a990161316ef42c", 2 );
    }
    else if ( fortresssize == "medium" )
    {
        return getdvarint( @"hash_264c33ce5715aa10", 1 );
    }
    
    return getdvarint( @"hash_d4b060e8da9b92c0", 1 );
}

/#

    // Namespace br_activewarzone
    // Params 0
    // Checksum 0xf4d942f, Offset: 0x10bc
    // Size: 0x2eb, Type: dev
    function function_b1f1615e42ecb25()
    {
        level endon( #"game_ended" );
        color = ( 1, 0, 0 );
        
        while ( true )
        {
            if ( getdvarint( @"hash_7d784e3984c4b5b1", 0 ) )
            {
                foreach ( id in level.var_87bd0b3632631717 )
                {
                    dormant = agent_utils::function_d77442145c568a4e( id );
                    agentdata = function_c62e58693ace9312( id );
                    top = agentdata.origin + ( 0, 0, 72 );
                    cylinder( agentdata.origin, top, 30, color, 0, 60 );
                    print3d( top, "<dev string:x62>" + dormant.aitype, color, 1, 1, 60 );
                    
                    if ( isdefined( dormant.behaviorpackage.pathstruct ) && dormant.behaviorpackage.pathstruct.path.size > 1 )
                    {
                        if ( isvector( dormant.behaviorpackage.pathstruct.path[ 0 ] ) && isvector( dormant.behaviorpackage.pathstruct.path[ 1 ] ) )
                        {
                            cylinder( dormant.behaviorpackage.pathstruct.path[ 0 ], dormant.behaviorpackage.pathstruct.path[ 0 ] + ( 0, 0, 12 ), 15, ( 0, 1, 0 ), 0, 60 );
                            cylinder( dormant.behaviorpackage.pathstruct.path[ 1 ], dormant.behaviorpackage.pathstruct.path[ 1 ] + ( 0, 0, 12 ), 15, ( 0, 1, 0 ), 0, 60 );
                            line( dormant.behaviorpackage.pathstruct.path[ 0 ], dormant.behaviorpackage.pathstruct.path[ 1 ], color, 0, 0, 60 );
                        }
                    }
                }
            }
            
            wait 1;
        }
    }

#/
