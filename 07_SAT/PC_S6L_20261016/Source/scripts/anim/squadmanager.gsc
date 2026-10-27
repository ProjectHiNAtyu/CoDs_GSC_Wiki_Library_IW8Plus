// scripts\anim\squadmanager.gsc  (hash_0c11d6400ba31ed7.gscc) (size: 5694 Bytes / 0x163e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdd62ff5b (3714252635)
// size ...... 5694 (0x163e)
// includes .. 1   (offset: 0x1562)
// strings ... 7   (offset: 0x156a)
// dev strs .. 9   (offset: 0x15d2)
// exports ... 19  (offset: 0xe7e)
// cseg ...... 0xac + 0xdd2 (0xe7e)
// imports ... 33  (offset: 0x1176)
// animtree1 . 0   (offset: 0x163e)
// animtree2 . 0   (offset: 0x163e)
#using scripts\anim\battlechatter_ai;

#namespace squadmanager;

// Namespace squadmanager
// Params 2
// Checksum 0x6adb199, Offset: 0xca
// Size: 0xd9
function createsquad( squadname, squadcreator )
{
    assert( !isdefined( anim.squads[ squadname ] ), "<dev string:x24>" );
    squad = spawnstruct();
    squad.squadname = squadname;
    anim.squads[ squadname ] = squad;
    squad.team = getsquadteam( squadcreator );
    squad.members = [];
    squad.squadlist = [];
    squad.cooldowntimes = [];
    squad.squadid = anim.squadindex.size;
    anim.squadindex[ squad.squadid ] = squad;
    level notify( "squad created " + squadname );
    InvalidOpCode( 0x97, "squad created " + squadname );
    // Unknown operator ( 0x97, t11, Black Ops 7 )
}

// Namespace squadmanager
// Params 1
// Checksum 0xf8c62863, Offset: 0x1d7
// Size: 0xff
function deletesquad( squadname )
{
    if ( squadname == "axis" || squadname == "team3" || squadname == "allies" || squadname == "neutral" )
    {
        return;
    }
    
    assert( isdefined( anim.squads[ squadname ] ), "<dev string:x74>" + squadname + "<dev string:x9e>" );
    squadid = anim.squads[ squadname ].squadid;
    squad = anim.squads[ squadname ];
    anim.squadindex[ squadid ] = anim.squadindex[ anim.squadindex.size - 1 ];
    anim.squadindex[ squadid ].squadid = squadid;
    anim.squadindex[ anim.squadindex.size - 1 ] = undefined;
    anim.squads[ squadname ] = undefined;
    InvalidOpCode( 0x97, "squad deleted " + squadname );
    // Unknown operator ( 0x97, t11, Black Ops 7 )
}

// Namespace squadmanager
// Params 1
// Checksum 0xa08eb15d, Offset: 0x2e0
// Size: 0x3e
function getsquadteam( squadcreator )
{
    if ( isdefined( squadcreator.team ) )
    {
        squadteam = squadcreator.team;
    }
    else
    {
        squadteam = "allies";
    }
    
    return squadteam;
}

// Namespace squadmanager
// Params 1
// Checksum 0x39d2f233, Offset: 0x327
// Size: 0x14c
function addtosquad( squadname )
{
    assert( issentient( self ), "<dev string:xb4>" );
    
    if ( !isdefined( squadname ) )
    {
        if ( isdefined( self.script_squadname ) )
        {
            squadname = self.script_squadname;
        }
        else
        {
            squadname = self.team;
        }
    }
    
    if ( !isdefined( anim.squads[ squadname ] ) )
    {
        InvalidOpCode( 0x97, squadname, self );
        // Unknown operator ( 0x97, t11, Black Ops 7 )
    }
    
    squad = anim.squads[ squadname ];
    
    if ( isdefined( self.squad ) )
    {
        if ( self.squad == squad )
        {
            return;
        }
        else
        {
            removefromsquad( self.squad, self.squadid );
        }
    }
    
    self.lastenemysighttime = 0;
    self.combattime = 0;
    self.starttime = gettime();
    
    if ( !isdefined( squad.var_6e56820d87b45e52 ) )
    {
        squad.var_6e56820d87b45e52 = 0;
    }
    
    squadid = squad.var_6e56820d87b45e52;
    squad.members[ squadid ] = self;
    squad.var_6e56820d87b45e52++;
    self.squad = squad;
    self.squadid = squadid;
    thread battlechatter_ai::addtosystem();
    thread memberdeathwaiter( squad, squadid );
}

// Namespace squadmanager
// Params 2
// Checksum 0x1cac3591, Offset: 0x47b
// Size: 0xda
function removefromsquad( squad, squadid )
{
    if ( !isdefined( squad ) )
    {
        return;
    }
    
    assert( isdefined( squadid ), "<dev string:xe6>" );
    
    if ( isdefined( self ) )
    {
        assert( squad.members.size != 0, "<dev string:x11d>" );
        assert( squad.members[ squadid ] == self, "<dev string:x14c>" );
    }
    else
    {
        assert( !isdefined( squad.members[ squadid ] ), "<dev string:x1ac>" );
    }
    
    squad.members[ squadid ] = undefined;
    
    if ( isdefined( self ) )
    {
        thread battlechatter_ai::removefromsystem( squad );
    }
    
    if ( squad.members.size == 0 )
    {
        deletesquad( squad.squadname );
    }
    
    if ( isdefined( self ) )
    {
        self notify( #"hash_9c6e504a4fb1eaff" );
    }
}

// Namespace squadmanager
// Params 3
// Checksum 0xedffb204, Offset: 0x55d
// Size: 0x4b
function function_c91ae5fb40561af8( statement, true_value, false_value )
{
    if ( statement )
    {
        if ( isfunction( true_value ) )
        {
            return [[ true_value ]]();
        }
        else
        {
            return true_value;
        }
    }
    
    if ( isfunction( false_value ) )
    {
        return [[ false_value ]]();
    }
    
    return false_value;
}

// Namespace squadmanager
// Params 0
// Checksum 0x6882e8d6, Offset: 0x5b0
// Size: 0xa6
function function_6067659389a2d575()
{
    start_index = randomint( self.members.size );
    
    for ( i = 0; i < self.members.size ; i++ )
    {
        index = ( start_index + i ) % self.members.size;
        guy = self.members[ index ];
        
        if ( !isalive( guy ) || !isdefined( guy.enemy ) || !guy.bisincombat )
        {
        }
    }
    
    return self.members[ start_index ];
}

// Namespace squadmanager
// Params 0
// Checksum 0xd60c2fac, Offset: 0x65f
// Size: 0x9c
function getenemyarray()
{
    array = [];
    
    foreach ( ai in getaiarray() )
    {
        if ( isenemyteam( self.team, ai.team ) )
        {
            array[ array.size ] = ai;
        }
    }
    
    return array;
}

// Namespace squadmanager
// Params 0
// Checksum 0x3302af85, Offset: 0x704
// Size: 0x3a, Type: bool
function enemyisincover()
{
    return isdefined( self.enemy ) && isdefined( self.enemy.node ) && isdefined( self.enemy.covernode );
}

// Namespace squadmanager
// Params 0
// Checksum 0xa1e9eb2f, Offset: 0x747
// Size: 0x12
function squadtracker()
{
    InvalidOpCode( 0x97, "squad deleted " + self.squadname );
    // Unknown operator ( 0x97, t11, Black Ops 7 )
}

// Namespace squadmanager
// Params 2
// Checksum 0x36ef0bdd, Offset: 0x763
// Size: 0x54
function memberdeathwaiter( squad, squadid )
{
    self endon( #"hash_9c6e504a4fb1eaff" );
    self waittill( #"death", attacker );
    
    if ( isdefined( self ) )
    {
        self.attacker = attacker;
    }
    
    removefromsquad( squad, squadid );
}

// Namespace squadmanager
// Params 0
// Checksum 0xd875f886, Offset: 0x7bf
// Size: 0x237
function updateall()
{
    neworigin = ( 0, 0, 0 );
    newheading = ( 0, 0, 0 );
    var_8c9fef9f88a4f6fa = 0;
    curenemy = undefined;
    isincombat = 0;
    needheading = !isdefined( self.enemy );
    
    if ( !needheading )
    {
        self.forward = vectornormalize( self.enemy.origin - self.origin );
    }
    
    foreach ( member in self.members )
    {
        if ( !isalive( member ) )
        {
            continue;
        }
        
        var_8c9fef9f88a4f6fa++;
        neworigin += member.origin;
        
        if ( needheading )
        {
            newheading += anglestoforward( member.angles );
        }
        
        if ( member.bisincombat )
        {
            isincombat = 1;
        }
        
        if ( isdefined( member.enemy ) && isdefined( member.enemy.squad ) )
        {
            if ( !isdefined( curenemy ) )
            {
                curenemy = member.enemy.squad;
                continue;
            }
            
            if ( member.enemy.squad.members.size > curenemy.members.size )
            {
                curenemy = member.enemy.squad;
            }
        }
    }
    
    if ( var_8c9fef9f88a4f6fa )
    {
        self.origin = neworigin / var_8c9fef9f88a4f6fa;
        
        if ( needheading )
        {
            self.forward = newheading / var_8c9fef9f88a4f6fa;
        }
    }
    else
    {
        self.origin = undefined;
        
        if ( needheading )
        {
            self.forward = undefined;
        }
    }
    
    self.isincombat = isincombat;
    self.enemy = curenemy;
}

// Namespace squadmanager
// Params 0
// Checksum 0x222ba24a, Offset: 0x9fe
// Size: 0x12
function updatememberstates()
{
    InvalidOpCode( 0x97, "squad deleted " + self.squadname );
    // Unknown operator ( 0x97, t11, Black Ops 7 )
}

// Namespace squadmanager
// Params 1
// Checksum 0xfb863deb, Offset: 0xa1a
// Size: 0xe9
function aiupdatecombat( timeslice )
{
    if ( !isdefined( self.combattime ) )
    {
        return;
    }
    
    if ( isdefined( self.lastenemysightpos ) )
    {
        if ( self.combattime < 0 )
        {
            self.combattime = timeslice;
        }
        else
        {
            self.combattime += timeslice;
        }
        
        self.lastenemysighttime = gettime();
        return;
    }
    else if ( self.bt_escaping || isdefined( self.asmname ) && self.asmname != "jackal" && self issuppressed() )
    {
        self.combattime += timeslice;
        return;
    }
    
    if ( self.combattime > 0 )
    {
        self.combattime = 0 - timeslice;
        return;
    }
    
    self.combattime -= timeslice;
}

// Namespace squadmanager
// Params 1
// Checksum 0xf605b4cb, Offset: 0xb0b
// Size: 0xb6
function aiupdatesuppressed( timeslice )
{
    if ( !isdefined( self.suppressedtime ) )
    {
        return;
    }
    
    if ( self.bt_escaping || isdefined( self.asmname ) && self.asmname != "jackal" && self issuppressed() )
    {
        if ( self.suppressedtime < 0 )
        {
            self.suppressedtime = timeslice;
            return;
        }
        
        self.suppressedtime += timeslice;
        return;
    }
    
    if ( self.suppressedtime > 0 )
    {
        self.suppressedtime = 0 - timeslice;
        return;
    }
    
    self.suppressedtime -= timeslice;
}

/#

    // Namespace squadmanager
    // Params 0
    // Checksum 0x1abd2c13, Offset: 0xbc9
    // Size: 0xf5, Type: dev
    function function_22816b67bec95a55()
    {
        if ( getdvarint( @"debug_squadmanager" ) < 1 )
        {
            return;
        }
        
        InvalidOpCode( 0x97, "<dev string:x207>" + self.squadname );
        // Unknown operator ( 0x97, t11, Black Ops 7 )
    }

    // Namespace squadmanager
    // Params 2
    // Checksum 0x603c1fb9, Offset: 0xcc6
    // Size: 0xb5, Type: dev
    function function_bc3faa80679170d1( pos, forward )
    {
        angles = vectortoangles( forward );
        range = 100;
        forward = anglestoforward( angles ) * range;
        right = anglestoright( angles ) * range;
        up = anglestoup( angles ) * range;
        _draw_arrow( pos, pos + forward, ( 1, 0, 0 ) );
        _draw_arrow( pos, pos + up, ( 0, 1, 0 ) );
        _draw_arrow( pos, pos + right, ( 0, 0, 1 ) );
    }

    // Namespace squadmanager
    // Params 3
    // Checksum 0x87ff98ab, Offset: 0xd83
    // Size: 0xfb, Type: dev
    function _draw_arrow( start, end, color )
    {
        angle = vectortoangles( end - start );
        dist = length( end - start );
        forward = anglestoforward( angle );
        forwardfar = forward * dist;
        arrow_size = 5;
        forwardclose = forward * ( dist - arrow_size );
        right = anglestoright( angle );
        leftdraw = right * arrow_size * -1;
        rightdraw = right * arrow_size;
        line( start, end, color, 1, 0, 1 );
        line( start, start + forwardfar, color, 1, 0, 1 );
        line( start + forwardfar, start + forwardclose + rightdraw, color, 1, 0, 1 );
        line( start + forwardfar, start + forwardclose + leftdraw, color, 1, 0, 1 );
    }

#/
