// scripts\mp\overseer.gsc  (hash_2880c23deadcdd8f.gscc) (size: 23469 Bytes / 0x5bad / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb20eb776 (2987308918)
// size ...... 23469 (0x5bad)
// includes .. 12  (offset: 0x55f5)
// strings ... 88  (offset: 0x5655)
// dev strs .. 7   (offset: 0x5b51)
// exports ... 65  (offset: 0x3ce9)
// cseg ...... 0x65b + 0x368e (0x3ce9)
// imports ... 114 (offset: 0x4711)
// animtree1 . 0   (offset: 0x5bad)
// animtree2 . 0   (offset: 0x5bad)
#using scripts\anim\battlechatter;
#using scripts\anim\dialogue;
#using scripts\common\utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_reinforcements;
#using scripts\mp\common\utility\entity;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\entityheadicons;
#using scripts\mp\pickups_scriptable;
#using scripts\mp\poi;

#namespace overseer;

// Namespace overseer
// Params 0
// Checksum 0xa7660083, Offset: 0x679
// Size: 0x75
function init_overseer()
{
    waitframe();
    
    if ( !poi::poi_issystemactive() )
    {
        return;
    }
    
    level.overseer = spawnstruct();
    function_6af7f01519bbc722();
    setdvarifuninitialized( @"hash_451b4b1e40b7b2ae", 2 );
    setdvarifuninitialized( @"hash_c32b050cf4dbed9c", 5 );
    function_9c70c35dfe7930a4();
    level waittill( #"matchstarttimer_done" );
    waitframe();
    function_111a7414d08fe83d();
    level thread function_4b6afa8ef51c7500();
    level thread function_25a45f056e2ccf4f();
    function_9f31aa04a91889a5();
}

// Namespace overseer
// Params 0
// Checksum 0x9cc10add, Offset: 0x6f6
// Size: 0x190
function function_6af7f01519bbc722()
{
    level.overseer.poi = [];
    
    foreach ( poiname, poi in level.poi )
    {
        level.overseer.poi[ poiname ] = spawnstruct();
        level.overseer.poi[ poiname ].overseerstate = 0;
        level.overseer.poi[ poiname ].name = poiname;
        level.overseer.poi[ poiname ].deadagents = [];
        level.overseer.poi[ poiname ].var_92c1b821e33d2d89 = 0;
        level.overseer.poi[ poiname ].var_85adfb59175c9303 = [];
        level.overseer.poi[ poiname ].var_ec857a9702e93e81 = [];
        level.overseer.poi[ poiname ].eventwaittime = 0;
    }
}

// Namespace overseer
// Params 0
// Checksum 0x518bbf1, Offset: 0x88e
// Size: 0x168
function function_9c70c35dfe7930a4()
{
    level.eventgraph = [];
    
    foreach ( poiname, poi in level.poi )
    {
        function_458a2d9f6b92cda5( poiname, 0, 1, 5, undefined );
        function_458a2d9f6b92cda5( poiname, 0, 2, 10, &function_27fd81ec2e9c5631 );
        function_458a2d9f6b92cda5( poiname, 0, 4, 0, &function_d24bf53ce40eb680 );
        function_458a2d9f6b92cda5( poiname, 0, 3, 0, &function_ed6e36fa635d0df2 );
        function_458a2d9f6b92cda5( poiname, 0, 5, 0, &function_44bfdc9060d73a36 );
        function_458a2d9f6b92cda5( poiname, 2, 1, 5, undefined );
        function_458a2d9f6b92cda5( poiname, 2, 2, 10, &function_27fd81ec2e9c5631 );
        function_458a2d9f6b92cda5( poiname, 2, 4, 0, &function_d24bf53ce40eb680 );
        function_458a2d9f6b92cda5( poiname, 2, 3, 0, &function_ed6e36fa635d0df2 );
        function_458a2d9f6b92cda5( poiname, 2, 5, 0, &function_44bfdc9060d73a36 );
        function_458a2d9f6b92cda5( poiname, 3, 1, 5, undefined );
        function_458a2d9f6b92cda5( poiname, 3, 2, 10, &function_27fd81ec2e9c5631 );
        function_458a2d9f6b92cda5( poiname, 3, 5, 0, &function_44bfdc9060d73a36 );
    }
}

// Namespace overseer
// Params 0
// Checksum 0x5c2e953f, Offset: 0x9fe
// Size: 0x85
function function_9f31aa04a91889a5()
{
    foreach ( poioverseer in level.overseer.poi )
    {
        poioverseer thread function_a4bf68f64d25b7c2();
    }
}

// Namespace overseer
// Params 0
// Checksum 0xeac7621a, Offset: 0xa8b
// Size: 0x15a
function function_111a7414d08fe83d()
{
    foreach ( player in level.players )
    {
        if ( isbot( player ) )
        {
            continue;
        }
        
        player.var_28c56b3d77144c95 = [];
        
        foreach ( poiname, poi in level.poi )
        {
            player.var_28c56b3d77144c95[ poiname ] = spawnstruct();
            player.var_28c56b3d77144c95[ poiname ].aliveagents = [];
            player.var_28c56b3d77144c95[ poiname ].deadagents = [];
            player.var_28c56b3d77144c95[ poiname ].eventcooldowns = [];
        }
    }
}

// Namespace overseer
// Params 5
// Checksum 0x5d5317c4, Offset: 0xbed
// Size: 0x12d
function function_458a2d9f6b92cda5( poiname, stateindex, eventindex, weight, eventcallback )
{
    if ( !( isdefined( poiname ) && isdefined( stateindex ) && isdefined( eventindex ) && isdefined( weight ) ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    if ( !isdefined( level.eventgraph[ poiname ] ) )
    {
        level.eventgraph[ poiname ] = [];
    }
    
    if ( !isdefined( level.eventgraph[ poiname ][ stateindex ] ) )
    {
        level.eventgraph[ poiname ][ stateindex ] = [];
    }
    
    level.eventgraph[ poiname ][ stateindex ][ eventindex ] = spawnstruct();
    level.eventgraph[ poiname ][ stateindex ][ eventindex ].weight = weight;
    level.eventgraph[ poiname ][ stateindex ][ eventindex ].event = eventcallback;
    
    if ( !isdefined( level.eventgraph[ poiname ][ stateindex ][ 0 ] ) )
    {
        level.eventgraph[ poiname ][ stateindex ][ 0 ] = 0;
    }
    
    level.eventgraph[ poiname ][ stateindex ][ 0 ] += weight;
}

// Namespace overseer
// Params 4
// Checksum 0xc5b10183, Offset: 0xd22
// Size: 0x171
function function_b809e13ad1cdc1bf( newweight, poiname, stateindex, eventindex )
{
    if ( !( isdefined( poiname ) && isdefined( stateindex ) && isdefined( eventindex ) && isdefined( newweight ) ) )
    {
        assertmsg( "<dev string:x63>" );
        return;
    }
    
    if ( !function_b835f458438d8185( poiname, stateindex, eventindex ) )
    {
        assertmsg( "<dev string:xa4>" );
        return;
    }
    
    statearray = stateindex;
    
    if ( !isarray( statearray ) )
    {
        statearray = [];
        statearray[ statearray.size ] = stateindex;
    }
    
    foreach ( state in statearray )
    {
        if ( !isdefined( level.eventgraph[ poiname ][ state ] ) )
        {
            continue;
        }
        
        weightdifference = newweight - level.eventgraph[ poiname ][ state ][ eventindex ].weight;
        level.eventgraph[ poiname ][ state ][ 0 ] += weightdifference;
        level.eventgraph[ poiname ][ state ][ eventindex ].weight = newweight;
    }
}

// Namespace overseer
// Params 3
// Checksum 0x5249a9af, Offset: 0xe9b
// Size: 0xe4, Type: bool
function function_b835f458438d8185( poiname, stateindex, eventindex )
{
    if ( !isdefined( level.eventgraph[ poiname ] ) )
    {
        return false;
    }
    
    statearray = stateindex;
    
    if ( !isarray( statearray ) )
    {
        statearray = [];
        statearray[ statearray.size ] = stateindex;
    }
    
    foreach ( state in statearray )
    {
        if ( isdefined( level.eventgraph[ poiname ][ state ] ) && isdefined( level.eventgraph[ poiname ][ state ][ eventindex ] ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace overseer
// Params 0
// Checksum 0x4901a03c, Offset: 0xf88
// Size: 0xc, Type: bool
function function_6fc3b08cbf3bade3()
{
    return isdefined( level.overseer );
}

// Namespace overseer
// Params 2
// Checksum 0xb5ed4437, Offset: 0xf9d
// Size: 0x58, Type: bool
function function_1477db41a0767b60( cooldownname, poiname )
{
    if ( !isdefined( self.var_28c56b3d77144c95[ poiname ].eventcooldowns[ cooldownname ] ) )
    {
        return false;
    }
    
    if ( self.var_28c56b3d77144c95[ poiname ].eventcooldowns[ cooldownname ] <= gettime() )
    {
        return false;
    }
    
    return true;
}

// Namespace overseer
// Params 1
// Checksum 0xd2949c1b, Offset: 0xffe
// Size: 0x5d
function function_efb33abd422ffc25( eventname )
{
    switch ( eventname )
    {
        case #"hash_5df1a64e881789c7":
            return 1;
        case #"hash_86f811bb481e7344":
            return ( self.stealth_bsmstate != 3 && self.stealth_bsmstate != 2 );
        default:
            return 1;
    }
}

// Namespace overseer
// Params 1
// Checksum 0x31b13367, Offset: 0x1063
// Size: 0x49, Type: bool
function function_8279cdd028a265c1( cooldownname )
{
    if ( !isdefined( self.overseercooldown ) )
    {
        return false;
    }
    
    if ( !isdefined( cooldownname ) )
    {
        return false;
    }
    
    if ( !isdefined( self.overseercooldown[ cooldownname ] ) )
    {
        return false;
    }
    
    return self.overseercooldown[ cooldownname ] >= gettime();
}

// Namespace overseer
// Params 2
// Checksum 0x34897f09, Offset: 0x10b5
// Size: 0x43
function function_e54b3b4485161a8( cooldownname, cooldowntime )
{
    if ( !isdefined( self.overseercooldown ) )
    {
        self.overseercooldown = [];
    }
    
    self.overseercooldown[ cooldownname ] = gettime() + cooldowntime * 1000;
}

// Namespace overseer
// Params 2
// Checksum 0xe4ee217e, Offset: 0x1100
// Size: 0x8f, Type: bool
function function_2425abf7bb721c33( var_f13dc378ca06868b, origin )
{
    if ( !isdefined( self.entitynumber ) )
    {
        return false;
    }
    
    if ( isdefined( var_f13dc378ca06868b[ self.entitynumber ] ) )
    {
        return false;
    }
    
    if ( isdefined( self.var_f6df5875385a1520 ) && self.var_f6df5875385a1520 + 120000 <= gettime() )
    {
        return false;
    }
    
    if ( !( isdefined( self.origin ) && isdefined( origin ) ) )
    {
        return false;
    }
    
    if ( distancesquared( origin, self.origin ) > 2250000 )
    {
        return false;
    }
    
    return true;
}

// Namespace overseer
// Params 4
// Checksum 0x3cad2e67, Offset: 0x1198
// Size: 0x14f
function function_e88e20369359006f( origin, radius, var_f13dc378ca06868b, poiname )
{
    var_37beb50840057c87 = getplayersinradius( origin, radius, "team_hundred_ninety_four" );
    var_37beb50840057c87 = arrayrandomize( var_37beb50840057c87 );
    var_69c4ef7b4b9521d2 = getplayersinradius( origin, 2000, "team_hundred_ninety_four", var_37beb50840057c87 );
    var_69c4ef7b4b9521d2 = arrayrandomize( var_69c4ef7b4b9521d2 );
    deadagents = [];
    
    foreach ( agent in level.overseer.poi[ poiname ].deadagents )
    {
        if ( agent function_2425abf7bb721c33( var_f13dc378ca06868b, origin ) )
        {
            deadagents[ agent.entitynumber ] = agent;
        }
    }
    
    deadagents = arrayrandomize( deadagents );
    splitindex = var_37beb50840057c87.size;
    aliveagents = arraycombine( var_37beb50840057c87, var_69c4ef7b4b9521d2 );
    return [ aliveagents, deadagents, splitindex ];
}

// Namespace overseer
// Params 4
// Checksum 0x3b349a3b, Offset: 0x12f0
// Size: 0x12e
function function_eb0b7453466bc02( speakerorigin, cooldownname, cooldowntime, poiname )
{
    players = getplayersinradius( speakerorigin, level.bcs_maxdist );
    
    if ( !isdefined( players ) )
    {
        return;
    }
    
    if ( !isarray( players ) && !isai( players ) )
    {
        players = [ players ];
    }
    
    foreach ( player in players )
    {
        if ( isai( player ) || isbot( player ) || !( isdefined( player.var_28c56b3d77144c95 ) && isdefined( player.var_28c56b3d77144c95[ poiname ] ) ) )
        {
            continue;
        }
        
        player.var_28c56b3d77144c95[ poiname ].eventcooldowns[ cooldownname ] = gettime() + cooldowntime * 1000;
    }
}

// Namespace overseer
// Params 2
// Checksum 0x792c7b36, Offset: 0x1426
// Size: 0x7e
function function_498013f8848a431b( poiname, newstate )
{
    switch ( newstate )
    {
        case 0:
        case 1:
            thread function_a4bf68f64d25b7c2();
            break;
        case 2:
        case 3:
            thread function_7f47641d16a263b3();
            break;
        case 4:
        default:
            break;
    }
}

// Namespace overseer
// Params 1
// Checksum 0x7af19e70, Offset: 0x14ac
// Size: 0x2c
function function_3002c0f3ec3bd22c( poiname )
{
    return level.overseer.poi[ poiname ].overseerstate;
}

// Namespace overseer
// Params 1
// Checksum 0x949fef4a, Offset: 0x14e1
// Size: 0x36
function function_3468ba8fbf602176( poiname )
{
    return level.overseer.poi[ poiname ].agentstates.stealth_bsmstate;
}

// Namespace overseer
// Params 4
// Checksum 0x18964496, Offset: 0x1520
// Size: 0xd4
function function_bb0dd21b82f0eb6( state, overseerspeaker, agentspeaker, faraway )
{
    assert( isdefined( state ), "<dev string:xe7>" );
    
    if ( !isdefined( state ) )
    {
        return;
    }
    
    if ( faraway )
    {
        sequence = function_71e56c017b43a36a();
    }
    
    sequence = undefined;
    
    switch ( state )
    {
        case 0:
        case 4:
            sequence = function_231bacc06d95932e( agentspeaker, overseerspeaker );
            break;
        case 1:
        case 2:
            sequence = function_711f7cea622966a3();
            break;
        case 3:
            sequence = function_6d9ffceaa86a8178();
            break;
        default:
            break;
    }
    
    return sequence;
}

// Namespace overseer
// Params 3
// Checksum 0x56a28e39, Offset: 0x15fd
// Size: 0x1fc
function function_8feb45855e5bd247( poiname, agentstate, eventname )
{
    if ( !( isdefined( poiname ) && isdefined( agentstate ) && isdefined( eventname ) ) )
    {
        return 0;
    }
    
    if ( !isalive( self ) )
    {
        return 0;
    }
    
    if ( isbot( self ) )
    {
        return 0;
    }
    
    if ( !isdefined( self.var_28c56b3d77144c95 ) )
    {
        return 0;
    }
    
    if ( !isdefined( self.var_28c56b3d77144c95[ poiname ] ) )
    {
        return 0;
    }
    
    switch ( agentstate )
    {
        case #"hash_343f075aa0daffe6":
            if ( !isdefined( self.var_28c56b3d77144c95[ poiname ].aliveagents ) )
            {
                return 0;
            }
            
            if ( self.var_28c56b3d77144c95[ poiname ].aliveagents.size == 0 )
            {
                return 0;
            }
            
            foreach ( agent in self.var_28c56b3d77144c95[ poiname ].aliveagents )
            {
                if ( agent function_efb33abd422ffc25( eventname ) && !agent function_8279cdd028a265c1( eventname ) )
                {
                    return 1;
                }
            }
            
            return 0;
        case #"hash_cf14c509efeb3c87":
            return ( isdefined( self.var_28c56b3d77144c95[ poiname ].deadagents ) && self.var_28c56b3d77144c95[ poiname ].deadagents.size != 0 );
        case #"hash_28fac2aca8cae4a5":
            return ( isdefined( level.overseer.poi[ poiname ].var_85adfb59175c9303 ) && level.overseer.poi[ poiname ].var_85adfb59175c9303.size != 0 );
        default:
            return 0;
    }
}

// Namespace overseer
// Params 3
// Checksum 0xf1a80064, Offset: 0x1801
// Size: 0x183
function function_7ea0bbb3ba8b2026( agentstate, poiname, eventname )
{
    assert( isdefined( agentstate ), "<dev string:x137>" );
    
    if ( !isdefined( agentstate ) )
    {
        return [ undefined, 0 ];
    }
    
    agentarray = [];
    
    switch ( agentstate )
    {
        case #"hash_343f075aa0daffe6":
            agentarray = self.var_28c56b3d77144c95[ poiname ].aliveagents;
            break;
        case #"hash_cf14c509efeb3c87":
            agentarray = self.var_28c56b3d77144c95[ poiname ].deadagents;
        default:
            break;
    }
    
    foreach ( index, agent in agentarray )
    {
        if ( !agent function_8279cdd028a265c1( eventname ) )
        {
            if ( agentstate == "alive" && !isalive( agent ) )
            {
                continue;
            }
            
            if ( index < self.var_28c56b3d77144c95[ poiname ].distanceindex )
            {
                return [ agent, 0 ];
            }
            
            return [ agent, 1 ];
        }
    }
    
    return [ undefined, 0 ];
}

// Namespace overseer
// Params 1
// Checksum 0xfa94e726, Offset: 0x198d
// Size: 0x6e
function function_d13df172195ff7ce( agentradio )
{
    level.overseer.poi[ agentradio.poi ].deadagents[ agentradio.entitynumber ] = agentradio;
    level.overseer.poi[ agentradio.poi ].var_92c1b821e33d2d89++;
}

// Namespace overseer
// Params 3
// Checksum 0x644d2764, Offset: 0x1a03
// Size: 0x54
function function_518eedf4308a16d9( sequence, waittime, priority )
{
    self notify( #"hash_c86547276766701c" );
    self endon( #"hash_c86547276766701c" );
    self endon( #"death" );
    wait waittime;
    battlechatter::function_b63bed8df8e4202a( "investigate", sequence, priority );
}

// Namespace overseer
// Params 2
// Checksum 0x30a5c9af, Offset: 0x1a5f
// Size: 0x12b
function function_ecbb5ce842a26e42( event_string, variant )
{
    char = "aqs" + string( variant ) + "_";
    countryid = "aqs";
    segs = strtok( event_string, "_" );
    alias = "";
    
    switch ( segs.size )
    {
        case 3:
            alias = "dx_bc_" + tolower( countryid ) + segs[ 0 ] + "_" + segs[ 1 ] + "_" + char + segs[ 2 ];
            break;
        case 2:
            alias = "dx_bc_" + tolower( countryid ) + segs[ 0 ] + "_" + char + segs[ 1 ];
            break;
        case 1:
            alias = "dx_bc_" + tolower( countryid ) + "_" + char + segs[ 0 ];
            break;
        default:
            assertmsg( "<dev string:x17f>" + event_string + "<dev string:x19d>" );
            break;
    }
    
    return alias;
}

// Namespace overseer
// Params 2
// Checksum 0x2fcb9c65, Offset: 0x1b93
// Size: 0x128
function function_ca112fc1366fc5ed( event_string, variant )
{
    char = "aqs1_";
    countryid = "aqld";
    segs = strtok( event_string, "_" );
    alias = "";
    
    switch ( segs.size )
    {
        case 3:
            alias = "dx_bc_" + tolower( countryid ) + segs[ 0 ] + "_" + segs[ 1 ] + "_" + char + segs[ 2 ];
            break;
        case 2:
            alias = "dx_bc_" + tolower( countryid ) + segs[ 0 ] + "_" + char + segs[ 1 ];
            break;
        case 1:
            alias = "dx_bc_" + tolower( countryid ) + "_" + char + segs[ 0 ];
            break;
        default:
            assertmsg( "<dev string:x17f>" + event_string + "<dev string:x19d>" );
            break;
    }
    
    alias = dialogue::get_radio_alias( alias );
    return alias;
}

// Namespace overseer
// Params 2
// Checksum 0x4fbc6888, Offset: 0x1cc4
// Size: 0x1d
function function_71b867f9d0a3324d( alias, variant )
{
    self playsoundonmovingent( alias );
}

// Namespace overseer
// Params 2
// Checksum 0x1e82ffab, Offset: 0x1cea
// Size: 0x1b
function function_7c63ca23747f1c40( alias, variant )
{
    self stopsounds();
}

// Namespace overseer
// Params 1
// Checksum 0x46cefdb1, Offset: 0x1d0e
// Size: 0x100
function function_4db4214f56bf878( sequence )
{
    self notify( #"overseer_chatter" );
    self endon( #"overseer_chatter" );
    self endon( #"death" );
    currentalias = undefined;
    variant = randomintrange( 1, 4 );
    
    foreach ( index, item in sequence )
    {
        if ( isdefined( currentalias ) )
        {
            self thread [[ level.vo_playsoundfunc ]]( currentalias );
            currentalias = undefined;
            waitframe();
            self waittill( #"dialogue_done" );
        }
        
        if ( isnumber( item ) )
        {
            wait item;
        }
        
        if ( isfunction( item ) )
        {
            currentalias = self [[ item ]]( sequence[ index + 1 ], variant );
        }
    }
}

// Namespace overseer
// Params 0
// Checksum 0xc2d54fa2, Offset: 0x1e16
// Size: 0x170
function function_a4bf68f64d25b7c2()
{
    self notify( #"changed_state" );
    level endon( #"game_ended" );
    self endon( #"changed_state" );
    self.overseerstate = 0;
    
    while ( true )
    {
        totalweight = level.eventgraph[ self.name ][ 0 ][ 0 ];
        probability = randomint( totalweight ) + 1;
        func = undefined;
        runningweight = 0;
        
        foreach ( eventindex, data in level.eventgraph[ self.name ][ 0 ] )
        {
            if ( eventindex == 0 )
            {
                continue;
            }
            
            runningweight += data.weight;
            
            if ( runningweight >= probability )
            {
                func = data.event;
                break;
            }
        }
        
        if ( isfunction( func ) )
        {
            self [[ func ]]( self.name );
        }
        
        wait self.eventwaittime + randomintrange( getdvarint( @"hash_451b4b1e40b7b2ae" ), getdvarint( @"hash_c32b050cf4dbed9c" ) );
    }
}

// Namespace overseer
// Params 0
// Checksum 0xad7873c9, Offset: 0x1f8e
// Size: 0x173
function function_7f47641d16a263b3()
{
    self notify( #"changed_state" );
    level endon( #"game_ended" );
    self endon( #"changed_state" );
    self.overseerstate = 2;
    
    while ( true )
    {
        totalweight = level.eventgraph[ self.name ][ 2 ][ 0 ];
        probability = randomint( totalweight ) + 1;
        func = undefined;
        runningweight = 0;
        
        foreach ( eventindex, data in level.eventgraph[ self.name ][ 2 ] )
        {
            if ( eventindex == 0 )
            {
                continue;
            }
            
            runningweight += data.weight;
            
            if ( runningweight >= probability )
            {
                func = data.event;
                break;
            }
        }
        
        if ( isfunction( func ) )
        {
            self [[ func ]]( self.name );
        }
        
        wait self.eventwaittime + randomintrange( getdvarint( @"hash_451b4b1e40b7b2ae" ), getdvarint( @"hash_c32b050cf4dbed9c" ) );
    }
}

// Namespace overseer
// Params 1
// Checksum 0x62b904d7, Offset: 0x2109
// Size: 0x1be
function function_27fd81ec2e9c5631( poiname )
{
    if ( !isdefined( level.poi[ poiname ][ "players" ] ) || level.poi[ poiname ][ "players" ].size == 0 )
    {
        return;
    }
    
    playedevent = 0;
    
    foreach ( player in level.poi[ poiname ][ "players" ] )
    {
        if ( !player function_8feb45855e5bd247( poiname, "alive", "check_in" ) || player function_1477db41a0767b60( "check_in", poiname ) )
        {
            continue;
        }
        
        [ agentspeaker, faraway ] = player function_7ea0bbb3ba8b2026( "alive", poiname, "check_in" );
        
        if ( !( isdefined( agentspeaker ) && isdefined( faraway ) ) )
        {
            continue;
        }
        
        playedevent = 1;
        sequence = function_bb0dd21b82f0eb6( self.overseerstate, undefined, agentspeaker, faraway );
        
        if ( faraway )
        {
            radiosound = function_9bd4d17675cc54f5();
            agentspeaker playsoundonmovingent( radiosound );
        }
        else
        {
            agentspeaker thread function_4db4214f56bf878( sequence );
        }
        
        function_eb0b7453466bc02( agentspeaker.origin, "check_in", 30, poiname );
        agentspeaker function_e54b3b4485161a8( "check_in", 120 );
    }
    
    if ( playedevent )
    {
        self.eventwaittime = 10;
    }
}

// Namespace overseer
// Params 1
// Checksum 0x32520d80, Offset: 0x22cf
// Size: 0x2ff
function function_ed6e36fa635d0df2( poiname )
{
    if ( !isdefined( level.poi[ poiname ][ "players" ] ) || level.poi[ poiname ][ "players" ].size == 0 )
    {
        return;
    }
    
    playedevent = 0;
    agentignored = 1;
    agentscontacted = [];
    
    foreach ( player in level.poi[ poiname ][ "players" ] )
    {
        if ( !player function_8feb45855e5bd247( poiname, "dead" ) || player function_1477db41a0767b60( "dead_agent_contacted", poiname ) )
        {
            continue;
        }
        
        [ agentspeaker, faraway ] = player function_7ea0bbb3ba8b2026( "dead", poiname, "check_in" );
        
        if ( !isdefined( agentspeaker ) )
        {
            continue;
        }
        
        playedevent = 1;
        probability = min( 100, level.overseer.poi[ poiname ].var_92c1b821e33d2d89 * 10 );
        ignore = utility::percent_chance( probability );
        agentspeaker notify( #"radio_spam" );
        agentscontacted[ agentscontacted.size ] = agentspeaker;
        
        if ( !ignore )
        {
            level.overseer.poi[ poiname ].var_85adfb59175c9303[ agentspeaker.entitynumber ] = undefined;
            ai_reinforcements::function_6f6dd03e6762a8ca( poiname, agentspeaker.origin );
            sequence = function_3c95d385650e5580();
            agentignored = 0;
        }
        else
        {
            sequence = function_c20174ca149ab8a0();
        }
        
        agentspeaker thread function_4db4214f56bf878( sequence );
        function_eb0b7453466bc02( agentspeaker.origin, "dead_agent_contacted", 120, poiname );
        agentspeaker function_e54b3b4485161a8( "check_in", 120 );
    }
    
    if ( playedevent )
    {
        if ( !agentignored )
        {
            function_b809e13ad1cdc1bf( 0, poiname, [ 0, 2 ], 3 );
            function_b809e13ad1cdc1bf( 10, poiname, [ 2 ], 4 );
        }
        
        self.eventwaittime = 0;
        wait 20;
        
        foreach ( agent in agentscontacted )
        {
            thread function_ba3ea791538298e5( agent );
        }
        
        if ( !agentignored )
        {
            function_498013f8848a431b( poiname, 2 );
        }
    }
}

// Namespace overseer
// Params 1
// Checksum 0xa1fff783, Offset: 0x25d6
// Size: 0x395
function function_d24bf53ce40eb680( poiname )
{
    if ( !isdefined( level.poi[ poiname ][ "players" ] ) || level.poi[ poiname ][ "players" ].size == 0 )
    {
        return;
    }
    
    var_5d719257085f0c4c = [];
    playedevent = 0;
    
    foreach ( player in level.poi[ poiname ][ "players" ] )
    {
        if ( !player function_8feb45855e5bd247( poiname, "alive", "reinforce_agent" ) || !player function_8feb45855e5bd247( poiname, "dead_contacted" ) || player function_1477db41a0767b60( "reinforce_agent", poiname ) )
        {
            continue;
        }
        
        [ agentspeaker, faraway ] = player function_7ea0bbb3ba8b2026( "alive", poiname, "reinforce_agent" );
        
        if ( !isdefined( agentspeaker ) )
        {
            continue;
        }
        
        playedevent = 1;
        sequence = function_fce1879fe9299c6a( agentspeaker, undefined );
        agentspeaker thread function_4db4214f56bf878( sequence );
        var_5d719257085f0c4c[ agentspeaker getentitynumber() ] = spawnstruct();
        var_5d719257085f0c4c[ agentspeaker getentitynumber() ].deadagent = utility::array_random( level.overseer.poi[ poiname ].var_85adfb59175c9303 );
        var_5d719257085f0c4c[ agentspeaker getentitynumber() ].agent = agentspeaker;
        function_eb0b7453466bc02( agentspeaker.origin, "reinforce_agent", 120, poiname );
    }
    
    if ( playedevent )
    {
        function_b809e13ad1cdc1bf( 0, poiname, 2, 4 );
        self.eventwaittime = 0;
        wait 10;
        
        foreach ( movedata in var_5d719257085f0c4c )
        {
            origin = getclosestpointonnavmesh( movedata.deadagent.origin + ( randomfloatrange( -256, 256 ), randomfloatrange( -256, 256 ), 0 ) );
            movedata.agent thread ai_behavior::behavior_combatRushOrigin( movedata.agent, origin );
            level.overseer.poi[ poiname ].agentstates = movedata.agent;
            level.overseer.poi[ poiname ].var_85adfb59175c9303[ movedata.deadagent.entitynumber ] = undefined;
            level.overseer.poi[ poiname ].var_92c1b821e33d2d89 = 0;
            level.overseer.poi[ poiname ].var_ec857a9702e93e81[ movedata.deadagent.entitynumber ] = movedata.deadagent;
        }
    }
}

// Namespace overseer
// Params 1
// Checksum 0x9930de3b, Offset: 0x2973
// Size: 0x1a5
function function_44bfdc9060d73a36( poiname )
{
    if ( !isdefined( level.poi[ poiname ][ "players" ] ) || level.poi[ poiname ][ "players" ].size == 0 )
    {
        return;
    }
    
    playedevent = 0;
    
    foreach ( player in level.poi[ poiname ][ "players" ] )
    {
        if ( !player function_8feb45855e5bd247( poiname, "alive", "outside_reinforce" ) || player function_1477db41a0767b60( "outside_reinforce", poiname ) )
        {
            continue;
        }
        
        [ agentspeaker, faraway ] = player function_7ea0bbb3ba8b2026( "alive", poiname, "outside_reinforce" );
        
        if ( !isdefined( agentspeaker ) )
        {
            continue;
        }
        
        playedevent = 1;
        sequence = function_fc08dfca7ff72d0f( agentspeaker );
        agentspeaker thread function_4db4214f56bf878( sequence );
        function_eb0b7453466bc02( agentspeaker.origin, "outside_reinforce", 120, poiname );
        agentspeaker function_e54b3b4485161a8( "outside_reinforce", 120 );
    }
    
    if ( playedevent )
    {
        function_b809e13ad1cdc1bf( 0, poiname, [ 0, 2 ], 4 );
        self.eventwaittime = 10;
    }
}

// Namespace overseer
// Params 0
// Checksum 0xf4e0d686, Offset: 0x2b20
// Size: 0x25d
function function_4b6afa8ef51c7500()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        foreach ( poiname, poi in level.poi )
        {
            if ( !isdefined( level.poi[ poiname ][ "players" ] ) )
            {
                continue;
            }
            
            foreach ( player in level.poi[ poiname ][ "players" ] )
            {
                if ( !isdefined( player.var_28c56b3d77144c95 ) || !isalive( player ) || !isdefined( player.origin ) || isbot( player ) )
                {
                    continue;
                }
                
                var_f13dc378ca06868b = level.overseer.poi[ poiname ].var_ec857a9702e93e81;
                [ aliveagents, deadagents, distanceindex ] = function_e88e20369359006f( player.origin, 1500, var_f13dc378ca06868b, poiname );
                player.var_28c56b3d77144c95[ poiname ].aliveagents = aliveagents;
                player.var_28c56b3d77144c95[ poiname ].distanceindex = distanceindex;
                player.var_28c56b3d77144c95[ poiname ].deadagents = deadagents;
                
                if ( player function_8feb45855e5bd247( poiname, "dead" ) )
                {
                    function_b809e13ad1cdc1bf( level.overseer.poi[ poiname ].var_92c1b821e33d2d89, poiname, [ 0, 2 ], 3 );
                }
            }
        }
        
        wait 5;
    }
}

// Namespace overseer
// Params 0
// Checksum 0xa6e7147, Offset: 0x2d85
// Size: 0xf7
function function_25a45f056e2ccf4f()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        foreach ( poioverseer in level.overseer.poi )
        {
            if ( !isdefined( poioverseer.agentstates ) )
            {
                continue;
            }
            
            agentstate = function_3468ba8fbf602176( poioverseer.name );
            
            if ( function_3002c0f3ec3bd22c( poioverseer.name ) != agentstate && agentstate != 4 )
            {
                poioverseer function_498013f8848a431b( poioverseer.name, agentstate );
            }
        }
        
        wait 1;
    }
}

// Namespace overseer
// Params 0
// Checksum 0xe5b97704, Offset: 0x2e84
// Size: 0xfe
function function_47458e4e3a41d593()
{
    alias = [];
    alias[ alias.size ] = "s_idnm_safi";
    alias[ alias.size ] = "s_idnm_abbasi";
    alias[ alias.size ] = "s_idnm_kinan";
    alias[ alias.size ] = "s_idnm_hamed";
    alias[ alias.size ] = "s_idnm_hadi";
    alias[ alias.size ] = "s_idnm_waseem";
    alias[ alias.size ] = "s_idnm_abuelbaz";
    alias[ alias.size ] = "s_idnm_beshara";
    alias[ alias.size ] = "s_idnm_kamal";
    alias[ alias.size ] = "s_idnm_abujamil";
    alias[ alias.size ] = "s_idnm_jabour";
    alias[ alias.size ] = "s_idnm_yaser";
    alias[ alias.size ] = "s_idnm_fayad";
    alias[ alias.size ] = "s_idnm_daoud";
    alias[ alias.size ] = "s_idnm_laham";
    alias[ alias.size ] = "s_idnm_abunazar";
    alias[ alias.size ] = "s_idnm_abuodeh";
    alias[ alias.size ] = "s_idnm_amran";
    alias[ alias.size ] = "s_idnm_basr";
    alias[ alias.size ] = "s_idnm_karam";
    alias[ alias.size ] = "s_idnm_brother";
    return utility::array_random( alias );
}

// Namespace overseer
// Params 0
// Checksum 0xae99857, Offset: 0x2f8b
// Size: 0x4e
function function_7ff7bf711aa5bf96()
{
    alias = [];
    alias[ alias.size ] = "s_idrr_nothinghere";
    alias[ alias.size ] = "s_idrr_allclear";
    alias[ alias.size ] = "s_idrr_weregoodbrother";
    alias[ alias.size ] = "s_idrr_goodhere";
    alias[ alias.size ] = "s_idrr_quietherebrother";
    return utility::array_random( alias );
}

// Namespace overseer
// Params 0
// Checksum 0x6f183269, Offset: 0x2fe2
// Size: 0x38
function function_ba0f596fee49bd82()
{
    alias = [];
    alias[ alias.size ] = "s_idlc_roger";
    alias[ alias.size ] = "s_idlc_copy";
    alias[ alias.size ] = "s_idlc_copythat";
    return utility::array_random( alias );
}

// Namespace overseer
// Params 2
// Checksum 0xcc476068, Offset: 0x3023
// Size: 0x8d
function function_231bacc06d95932e( agentspeaker, overseerspeaker )
{
    firstline = function_47458e4e3a41d593();
    secondline = function_7ff7bf711aa5bf96();
    lastline = function_ba0f596fee49bd82();
    sequence = [ &function_ca112fc1366fc5ed, firstline, 2, &function_ecbb5ce842a26e42, secondline, 2, &function_ca112fc1366fc5ed, lastline ];
    return sequence;
}

// Namespace overseer
// Params 0
// Checksum 0xfeef6173, Offset: 0x30b9
// Size: 0x43
function function_92aba5aafe46a243()
{
    alias = [];
    alias[ alias.size ] = "s_idli_areyouokaybrother";
    alias[ alias.size ] = "s_idli_areyouthere";
    alias[ alias.size ] = "s_idli_wheredyougo";
    alias[ alias.size ] = "s_idli_canyouhearme";
    return utility::array_random( alias );
}

// Namespace overseer
// Params 0
// Checksum 0x1ae6d776, Offset: 0x3105
// Size: 0x2d
function function_97d0ac5c9f908910()
{
    alias = [];
    alias[ alias.size ] = "s_comm_ret0";
    alias[ alias.size ] = "s_comm_reo0";
    return utility::array_random( alias );
}

// Namespace overseer
// Params 0
// Checksum 0x4e940e65, Offset: 0x313b
// Size: 0x2d
function function_840d9dc5424a7e79()
{
    alias = [];
    alias[ alias.size ] = "s_misc_con0";
    alias[ alias.size ] = "s_misc_con2";
    return utility::array_random( alias );
}

// Namespace overseer
// Params 0
// Checksum 0x8e622d3a, Offset: 0x3171
// Size: 0x7a
function function_3c95d385650e5580()
{
    firstline = function_47458e4e3a41d593();
    secondline = function_92aba5aafe46a243();
    lastline = function_97d0ac5c9f908910();
    sequence = [ &function_ca112fc1366fc5ed, firstline, 4, &function_ca112fc1366fc5ed, secondline, 4, &function_ca112fc1366fc5ed, lastline ];
    return sequence;
}

// Namespace overseer
// Params 0
// Checksum 0xa0a2bae2, Offset: 0x31f4
// Size: 0x7a
function function_c20174ca149ab8a0()
{
    firstline = function_47458e4e3a41d593();
    secondline = function_92aba5aafe46a243();
    lastline = function_840d9dc5424a7e79();
    sequence = [ &function_ca112fc1366fc5ed, firstline, 4, &function_ca112fc1366fc5ed, secondline, 4, &function_ca112fc1366fc5ed, lastline ];
    return sequence;
}

// Namespace overseer
// Params 0
// Checksum 0xb05093f6, Offset: 0x3277
// Size: 0x2d
function function_539c20a44baf57be()
{
    alias = [];
    alias[ alias.size ] = "s_comm_rhy0";
    alias[ alias.size ] = "s_conf_cop0";
    return utility::array_random( alias );
}

// Namespace overseer
// Params 0
// Checksum 0x6219aa30, Offset: 0x32ad
// Size: 0x38
function function_28d92a1047274e01()
{
    alias = [];
    alias[ alias.size ] = "s_seor_oft0";
    alias[ alias.size ] = "s_invt_ori0";
    alias[ alias.size ] = "s_geno_ocl1";
    return utility::array_random( alias );
}

// Namespace overseer
// Params 2
// Checksum 0x580f740b, Offset: 0x32ee
// Size: 0xab
function function_fce1879fe9299c6a( agentspeaker, overseerspeaker )
{
    firstline = function_47458e4e3a41d593();
    secondline = function_539c20a44baf57be();
    thirdline = "s_comm_alu0";
    fourthline = function_28d92a1047274e01();
    sequence = [ &function_ca112fc1366fc5ed, firstline, 2, &function_ecbb5ce842a26e42, secondline, 2, &function_ca112fc1366fc5ed, thirdline, &function_ca112fc1366fc5ed, fourthline ];
    return sequence;
}

// Namespace overseer
// Params 0
// Checksum 0x96d68a8d, Offset: 0x33a2
// Size: 0x43
function function_7dd0a5b779abc63f()
{
    alias = [];
    alias[ alias.size ] = "s_seor_orb1";
    alias[ alias.size ] = "s_seor_orb0";
    alias[ alias.size ] = "s_seor_osa1";
    alias[ alias.size ] = "s_seor_osa1";
    return utility::array_random( alias );
}

// Namespace overseer
// Params 0
// Checksum 0xf7fbe330, Offset: 0x33ee
// Size: 0x55
function function_711f7cea622966a3()
{
    firstline = function_47458e4e3a41d593();
    secondline = function_7dd0a5b779abc63f();
    sequence = [ &function_ca112fc1366fc5ed, firstline, 2, &function_ca112fc1366fc5ed, secondline ];
    return sequence;
}

// Namespace overseer
// Params 0
// Checksum 0x2ac9030, Offset: 0x344c
// Size: 0x55
function function_6d9ffceaa86a8178()
{
    firstline = function_47458e4e3a41d593();
    secondline = function_7dd0a5b779abc63f();
    sequence = [ &function_ca112fc1366fc5ed, firstline, 2, &function_ca112fc1366fc5ed, secondline ];
    return sequence;
}

// Namespace overseer
// Params 0
// Checksum 0xb5b0a130, Offset: 0x34aa
// Size: 0x2d
function function_bf8c904de01af9e()
{
    alias = [];
    alias[ alias.size ] = "s_moac_moa0";
    alias[ alias.size ] = "s_moac_mot0";
    return utility::array_random( alias );
}

// Namespace overseer
// Params 1
// Checksum 0x248b949e, Offset: 0x34e0
// Size: 0x5e
function function_fc08dfca7ff72d0f( agentspeaker )
{
    firstline = "s_comm_neb0";
    secondline = function_bf8c904de01af9e();
    sequence = [ &function_ca112fc1366fc5ed, firstline, 2, &function_ca112fc1366fc5ed, secondline ];
    return sequence;
}

// Namespace overseer
// Params 0
// Checksum 0xc8071454, Offset: 0x3547
// Size: 0xd2
function function_9bd4d17675cc54f5()
{
    alias = [];
    alias[ alias.size ] = "st_radioburst_10";
    alias[ alias.size ] = "st_radioburst_11";
    alias[ alias.size ] = "st_radioburst_12";
    alias[ alias.size ] = "st_radioburst_13";
    alias[ alias.size ] = "st_radioburst_14";
    alias[ alias.size ] = "st_radioburst_15";
    alias[ alias.size ] = "st_radioburst_16";
    alias[ alias.size ] = "st_radioburst_17";
    alias[ alias.size ] = "st_radioburst_18";
    alias[ alias.size ] = "st_radioburst_19";
    alias[ alias.size ] = "st_radioburst_20";
    alias[ alias.size ] = "st_radioburst_21";
    alias[ alias.size ] = "st_radioburst_22";
    alias[ alias.size ] = "st_radioburst_23";
    alias[ alias.size ] = "st_radioburst_24";
    alias[ alias.size ] = "st_radioburst_25";
    alias[ alias.size ] = "st_radioburst_26";
    return utility::array_random( alias );
}

// Namespace overseer
// Params 0
// Checksum 0x65f9c144, Offset: 0x3622
// Size: 0x55
function function_71e56c017b43a36a()
{
    firstline = function_9bd4d17675cc54f5();
    secondline = function_9bd4d17675cc54f5();
    sequence = [ &function_71b867f9d0a3324d, firstline, 4, &function_71b867f9d0a3324d, secondline ];
    return sequence;
}

// Namespace overseer
// Params 1
// Checksum 0xf762ff70, Offset: 0x3680
// Size: 0x39
function waitstopsounds( waittime )
{
    self notify( #"radio_marked" );
    self endon( #"death" );
    self endon( #"radio_marked" );
    wait waittime;
    self stopsounds();
}

// Namespace overseer
// Params 2
// Checksum 0xb74b4ed3, Offset: 0x36c1
// Size: 0x12d
function function_50a894673e81700d( agents, players )
{
    level endon( #"game_ended" );
    
    foreach ( agent in agents )
    {
        if ( isalive( agent ) )
        {
            agent playsoundonmovingent( "mp_dmz_overseer_radio_tag" );
            agent thread waitstopsounds( 0.75 );
            
            if ( isdefined( agent.var_cf9a421b0cee9456 ) )
            {
                entityheadicons::setheadicon_deleteicon( agent.var_cf9a421b0cee9456 );
            }
            
            icon = agent entityheadicons::setheadicon_singleimage( players, "hud_icon_head_marked", 8, 1 );
            agent.var_cf9a421b0cee9456 = icon;
            agent thread function_5889fad5f444606c( icon );
            agent thread function_7e8599a8dc8fb6c2( icon, getdvarfloat( @"hash_bb001ed900888502", 10 ) );
            wait randomfloatrange( 0.25, 0.4 );
        }
    }
}

// Namespace overseer
// Params 4
// Checksum 0xeb8ca074, Offset: 0x37f6
// Size: 0x1ca
function function_ec761202e0750a01( players, origin, team, agentteam )
{
    level endon( #"game_ended" );
    var_cfe0d114504b5e14 = 0;
    
    foreach ( player in players )
    {
        player player::showminimap();
        
        if ( !var_cfe0d114504b5e14 && isdefined( player.perks[ "specialty_pc_comms" ] ) )
        {
            var_cfe0d114504b5e14 = 1;
        }
    }
    
    var_d5d53bd7ec85198d = entity::function_cd55d7a649cb9c44( origin, 2000, agentteam );
    var_d5d53bd7ec85198d = sortbydistance( var_d5d53bd7ec85198d, origin );
    level thread function_50a894673e81700d( var_d5d53bd7ec85198d, players );
    thread function_db28d0a59c024e5c( players, origin, 2000, 12 );
    sweepcount = 0;
    var_c7793e307f354d97 = 3 + ( var_cfe0d114504b5e14 ? getdvarint( @"hash_1f416fc1d07d0b07", 2 ) : 0 );
    
    while ( sweepcount < var_c7793e307f354d97 )
    {
        triggerportableradarpingteam( origin, team, 2000, int( 2000 ) );
        sweepcount++;
        wait 2;
    }
    
    foreach ( player in players )
    {
        if ( isdefined( player ) )
        {
            player player::hideminimap();
        }
    }
}

// Namespace overseer
// Params 4
// Checksum 0x607dc441, Offset: 0x39c8
// Size: 0xa9
function function_db28d0a59c024e5c( players, origin, radius, time )
{
    struct = spawnstruct();
    struct.players = players;
    struct.origin = origin;
    struct.radius = radius;
    
    if ( !isdefined( level.var_465128b42ee87684 ) )
    {
        level.var_465128b42ee87684 = [];
    }
    
    level.var_465128b42ee87684[ level.var_465128b42ee87684.size ] = struct;
    wait time;
    level.var_465128b42ee87684 = arrayremove( level.var_465128b42ee87684, struct );
}

// Namespace overseer
// Params 1
// Checksum 0x21dacee3, Offset: 0x3a79
// Size: 0x68
function function_5889fad5f444606c( icon )
{
    self notify( #"hash_2541ac1d0328c46f" );
    self endon( #"hash_9fe9af8387f27118" );
    self endon( #"hash_2541ac1d0328c46f" );
    level endon( #"game_ended" );
    self waittill( #"death" );
    entityheadicons::setheadicon_deleteicon( icon );
    self.var_cf9a421b0cee9456 = undefined;
    self notify( #"hash_9fe9af8387f27118" );
}

// Namespace overseer
// Params 2
// Checksum 0x67c12777, Offset: 0x3ae9
// Size: 0x67
function function_7e8599a8dc8fb6c2( icon, waittime )
{
    self notify( #"headicon_timeout" );
    self endon( #"hash_9fe9af8387f27118" );
    self endon( #"headicon_timeout" );
    level endon( #"game_ended" );
    wait waittime;
    entityheadicons::setheadicon_deleteicon( icon );
    self.var_cf9a421b0cee9456 = undefined;
    self notify( #"hash_9fe9af8387f27118" );
}

// Namespace overseer
// Params 1
// Checksum 0x9655465c, Offset: 0x3b58
// Size: 0x119
function function_51eb09c3cc658225( instance )
{
    self notify( #"radio_activated" );
    instance notify( #"radio_spam" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"radio_activated" );
    poiname = instance.script_poi;
    radiopos = instance.origin;
    instance setscriptablepartstate( "brloot_dead_agent_radio", "pulse" );
    playsoundatpos( radiopos, "mp_dmz_overseer_radio_sweep" );
    players = teams::getteamdata( self.team, "players" );
    thread points::doscoreevent( #"dmz_radio_used" );
    
    if ( !isdefined( players ) )
    {
        return;
    }
    
    agentteam = level.var_7ba393bd5b21cc2d;
    
    if ( isdefined( instance.droppedteam ) )
    {
        agentteam = instance.droppedteam;
    }
    
    level thread function_ec761202e0750a01( players, radiopos, self.team, agentteam );
    wait 2;
    pickups::loothide( instance );
}

// Namespace overseer
// Params 1
// Checksum 0xd8bc40ad, Offset: 0x3c79
// Size: 0x70
function function_ba3ea791538298e5( agentradio )
{
    if ( !isdefined( agentradio ) )
    {
        return;
    }
    
    agentradio notify( #"radio_spam" );
    agentradio endon( #"radio_spam" );
    wait 3;
    
    while ( isdefined( agentradio ) && isdefined( agentradio.origin ) )
    {
        alias = function_9bd4d17675cc54f5();
        playsoundatpos( agentradio.origin, alias );
        wait 4;
    }
}

