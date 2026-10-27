// scripts\common\ai\stealth\event.gsc  (hash_614a6922f8440723.gscc) (size: 5452 Bytes / 0x154c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x255e142e (626922542)
// size ...... 5452 (0x154c)
// includes .. 5   (offset: 0x141c)
// strings ... 16  (offset: 0x1444)
// dev strs .. 4   (offset: 0x151c)
// exports ... 16  (offset: 0xd40)
// cseg ...... 0x164 + 0xbdc (0xd40)
// imports ... 36  (offset: 0xfc0)
// animtree1 . 0   (offset: 0x154c)
// animtree2 . 0   (offset: 0x154c)
#using scripts\common\ai\stealth\debug;
#using scripts\common\ai\stealth\utility;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;

#namespace event;

// Namespace event
// Params 0, eflags: 0x5
// Checksum 0xe44d905a, Offset: 0x182
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"stealth_events", #"val", &pre_main, undefined );
}

// Namespace event
// Params 0, eflags: 0x4
// Checksum 0x8eb230f8, Offset: 0x1ab
// Size: 0x4a
function private pre_main()
{
    if ( isdefined( level.gamemodebundle ) && isdefined( level.gamemodebundle.aieventlist ) )
    {
        val::set( "gamemodebundle", "ai_eventlist", level.gamemodebundle.aieventlist );
    }
}

// Namespace event
// Params 0
// Checksum 0xad713060, Offset: 0x1fd
// Size: 0x11
function event_init_entity()
{
    thread event_listener_thread();
    self function_1e7b05aee4b81c2c( 1 );
}

// Namespace event
// Params 0
// Checksum 0x780d64d6, Offset: 0x216
// Size: 0x92
function event_init_level()
{
    if ( !isdefined( level.stealth.event_priority ) )
    {
        level.stealth.event_priority = [];
    }
    
    level.stealth.event_priority[ "investigate" ] = 0;
    level.stealth.event_priority[ "cover_blown" ] = 1;
    level.stealth.event_priority[ "combat" ] = 2;
    level utility::set_stealth_func( "broadcast", &event_broadcast_generic );
}

// Namespace event
// Params 2
// Checksum 0x794c27fe, Offset: 0x2b0
// Size: 0xbc
function event_severity_compare( severitya, severityb )
{
    assert( isdefined( level.stealth ) );
    assert( isdefined( level.stealth.event_priority ) );
    assert( isdefined( level.stealth.event_priority[ severitya ] ) );
    assert( isdefined( level.stealth.event_priority[ severityb ] ) );
    result = level.stealth.event_priority[ severitya ] - level.stealth.event_priority[ severityb ];
    return result;
}

// Namespace event
// Params 0
// Checksum 0xa4ae53f1, Offset: 0x375
// Size: 0x23
function event_escalation_clear()
{
    self.stealth.event_escalation_count = undefined;
    self.event_escalation_scalar = 0;
}

// Namespace event
// Params 2
// Checksum 0x1899b7da, Offset: 0x3a0
// Size: 0xff
function function_4573594c8919d724( event, eventhandled )
{
    if ( isdefined( level.var_472bbfc72aecc961 ) )
    {
        thread [[ level.var_472bbfc72aecc961 ]]( event );
    }
    
    /#
        if ( event_debug_entindex() == -1 || event_debug_entindex() == self getentitynumber() )
        {
            if ( eventhandled )
            {
                if ( debug::debug_enabled() )
                {
                    typeorig = "<dev string:x24>";
                    
                    if ( isdefined( event.typeorig ) )
                    {
                        typeorig = "<dev string:x25>" + event.typeorig + "<dev string:x28>";
                    }
                    
                    event_str = "<dev string:x2a>" + event.type + typeorig;
                    thread debug::function_38a89e455afa7450( event_str, ( 1, 1, 1 ), 1, 0.5, ( 0, 0, 40 ), 4 );
                }
                
                self.stealth.ai_event = event.type;
            }
        }
    #/
}

// Namespace event
// Params 0
// Checksum 0xf8a41c09, Offset: 0x4a7
// Size: 0x15d
function event_listener_thread()
{
    self notify( #"event_listener_thread" );
    self endon( #"event_listener_thread" );
    self endon( #"death" );
    filterexclusions = [ "footstep", "footstep_sprint", "footstep_walk", "swim", "swim_sprint", "silenced_shot_impact", "gunshot_impact" ];
    
    while ( true )
    {
        utility::ent_flag_wait( "stealth_enabled" );
        self waittill( #"ai_events", events );
        
        if ( !utility::ent_flag( "stealth_enabled" ) )
        {
            continue;
        }
        
        if ( self.ignoreall || self isragdoll() )
        {
            continue;
        }
        
        foreach ( event in events )
        {
            if ( !isdefined( event.entity ) )
            {
                continue;
            }
            
            if ( event.var_4b40c269fda22791 )
            {
                function_4573594c8919d724( event, 1 );
            }
        }
    }
}

// Namespace event
// Params 1
// Checksum 0x2168d8e6, Offset: 0x60c
// Size: 0x3c
function entity_is_approved( entity )
{
    switch ( entity.classname )
    {
        case #"hash_adbcc9c8e4f8d955":
            return 1;
        default:
            return 0;
    }
}

// Namespace event
// Params 5
// Checksum 0x4f1c70cb, Offset: 0x650
// Size: 0x217
function event_broadcast_axis( eventtype, eventtypeperipheral, enemy, rangeauto, rangesight )
{
    ais = getaiunittypearray( "bad_guys", "all" );
    rangeautosq = squared( rangeauto );
    rangesightsq = squared( rangesight );
    myteam = self.team;
    
    if ( !isdefined( myteam ) )
    {
        myteam = self.agentteam;
    }
    
    assert( isdefined( myteam ) );
    var_b43a5d3c6f5d1f36 = issentient( enemy );
    
    foreach ( ai in ais )
    {
        if ( !isalive( ai ) )
        {
            continue;
        }
        
        if ( ai == self )
        {
            continue;
        }
        
        if ( ai.team != myteam )
        {
            continue;
        }
        
        if ( !isdefined( ai.stealth ) )
        {
            continue;
        }
        
        broadcast = 0;
        distsq = distancesquared( ai.origin, self.origin );
        
        if ( distsq <= rangeautosq )
        {
            broadcast = self hastacvis( ai );
        }
        
        if ( !broadcast && distsq <= rangesightsq )
        {
            if ( ai utility::is_visible( self ) || ai utility::is_visible( enemy ) )
            {
                broadcast = 1;
            }
        }
        
        if ( ai [[ ai.fnisinstealthcombat ]]() )
        {
            if ( broadcast )
            {
                ai getenemyinfo( enemy );
            }
            
            continue;
        }
        
        if ( broadcast )
        {
            if ( var_b43a5d3c6f5d1f36 && ai lastknowntime( enemy ) == 0 )
            {
                ai aieventlistenerevent( eventtype, enemy, self.origin );
                continue;
            }
            
            ai aieventlistenerevent( eventtype, enemy, enemy.origin );
        }
    }
}

// Namespace event
// Params 5
// Checksum 0x589f777c, Offset: 0x86f
// Size: 0x127
function event_broadcast_generic( eventtype, eventposition, eventradius, evententity, teamsoverride )
{
    ais = [];
    
    if ( isarray( teamsoverride ) )
    {
        ais = getaiarrayinradius( eventposition, eventradius, teamsoverride );
    }
    else
    {
        ais = getaiunittypearray( "bad_guys" );
    }
    
    if ( !isdefined( evententity ) )
    {
        evententity = level.player;
    }
    
    rangeautosq = squared( eventradius );
    
    foreach ( ai in ais )
    {
        if ( !isalive( ai ) )
        {
            continue;
        }
        
        if ( !isdefined( ai.stealth ) )
        {
            continue;
        }
        
        if ( distancesquared( ai.origin, eventposition ) <= rangeautosq )
        {
            ai aieventlistenerevent( eventtype, evententity, eventposition );
        }
    }
}

// Namespace event
// Params 7
// Checksum 0x89f746d9, Offset: 0x99e
// Size: 0x175
function event_broadcast_axis_by_tacsight( eventtype, enemy, eventposition, eventradius, bcheckfov, tacposition, var_12aa66f81c123c17 )
{
    ais = getaiunittypearray( "bad_guys", "all" );
    cradiussq = eventradius * eventradius;
    
    if ( !isdefined( bcheckfov ) )
    {
        bcheckfov = 1;
    }
    
    var_40ddde7caef69647 = undefined;
    
    if ( isdefined( var_12aa66f81c123c17 ) )
    {
        var_40ddde7caef69647 = var_12aa66f81c123c17 * var_12aa66f81c123c17;
    }
    
    if ( !isdefined( tacposition ) )
    {
        tacposition = eventposition;
    }
    
    foreach ( ai in ais )
    {
        if ( !isalive( ai ) )
        {
            continue;
        }
        
        if ( !isdefined( ai.stealth ) )
        {
            continue;
        }
        
        var_c79079c772b7e5a9 = distancesquared( ai.origin, eventposition );
        
        if ( var_c79079c772b7e5a9 > cradiussq )
        {
            continue;
        }
        
        var_32a7f634b9992e5c = bcheckfov;
        
        if ( bcheckfov && var_c79079c772b7e5a9 <= var_40ddde7caef69647 )
        {
            var_32a7f634b9992e5c = 0;
        }
        
        if ( !ai hastacvis( tacposition, var_32a7f634b9992e5c ) )
        {
            continue;
        }
        
        ai aieventlistenerevent( eventtype, enemy, eventposition );
    }
}

// Namespace event
// Params 7
// Checksum 0x5b709dac, Offset: 0xb1b
// Size: 0x53
function event_broadcast_axis_by_sight( eventtype, enemy, eventposition, eventradius, bcheckfov, tacposition, autorange )
{
    thread event_broadcast_axis_by_sight_thread( eventtype, enemy, eventposition, eventradius, bcheckfov, tacposition, autorange );
}

// Namespace event
// Params 7
// Checksum 0x18490878, Offset: 0xb76
// Size: 0x1b2
function event_broadcast_axis_by_sight_thread( eventtype, enemy, eventposition, eventradius, bcheckfov, tacposition, autorange )
{
    ais = getaiunittypearray( "bad_guys", "all" );
    cradiussq = eventradius * eventradius;
    
    if ( !isdefined( bcheckfov ) )
    {
        bcheckfov = 1;
    }
    
    if ( !isdefined( tacposition ) )
    {
        tacposition = eventposition;
    }
    
    var_6f2704227e3e6f69 = 3;
    traces_per_frame = 0;
    
    foreach ( ai in ais )
    {
        if ( !isalive( ai ) )
        {
            continue;
        }
        
        if ( !isdefined( ai.stealth ) )
        {
            continue;
        }
        
        distsq = distancesquared( ai.origin, eventposition );
        
        if ( distsq > cradiussq )
        {
            continue;
        }
        
        if ( distsq <= autorange * autorange )
        {
            ai aieventlistenerevent( eventtype, enemy, eventposition );
            continue;
        }
        
        if ( !ai hastacvis( tacposition, bcheckfov ) )
        {
            if ( bcheckfov && !ai aipointinfov( eventposition ) )
            {
                continue;
            }
            
            traces_per_frame++;
            
            if ( traces_per_frame > var_6f2704227e3e6f69 )
            {
                waitframe();
                traces_per_frame = 0;
                
                if ( !isalive( ai ) )
                {
                    continue;
                }
            }
            
            if ( !sighttracepassed( ai geteye(), eventposition, 0, enemy ) )
            {
                continue;
            }
        }
        
        ai aieventlistenerevent( eventtype, enemy, eventposition );
    }
}

// Namespace event
// Params 0
// Checksum 0xf73e6270, Offset: 0xd30
// Size: 0xf
function event_debug_entindex()
{
    return getdvarint( @"ai_debugentindex" );
}

