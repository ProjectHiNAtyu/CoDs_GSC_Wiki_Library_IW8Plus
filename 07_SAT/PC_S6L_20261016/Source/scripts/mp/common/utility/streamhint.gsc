// scripts\mp\common\utility\streamhint.gsc  (hash_4ee44c794c53009e.gscc) (size: 3130 Bytes / 0xc3a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xffd773e7 (4292309991)
// size ...... 3130 (0xc3a)
// includes .. 0   (offset: 0xa96)
// strings ... 1   (offset: 0xa96)
// dev strs .. 29  (offset: 0xaa2)
// exports ... 7   (offset: 0x6c2)
// cseg ...... 0x6e + 0x654 (0x6c2)
// imports ... 21  (offset: 0x7da)
// animtree1 . 0   (offset: 0xc3a)
// animtree2 . 0   (offset: 0xc3a)
#namespace streamhint;

// Namespace streamhint
// Params 0
// Checksum 0xdd7634cd, Offset: 0x8c
// Size: 0x1b
function playerwaittillstreamhintcomplete()
{
    if ( self.prestreaminglocation )
    {
        self waittill( #"hash_2d0813a2d19b7c7e" );
    }
}

// Namespace streamhint
// Params 5
// Checksum 0xa80417, Offset: 0xaf
// Size: 0x3e
function playerstreamhintlocation( streamorigin, timeoutms, streamcustomization, extrawaittime, var_654469cb39851c3d )
{
    thread playerstreamhintlocationinternal( streamorigin, timeoutms, streamcustomization, extrawaittime, var_654469cb39851c3d );
}

// Namespace streamhint
// Params 5
// Checksum 0x71c2dd68, Offset: 0xf5
// Size: 0x4fc
function playerstreamhintlocationinternal( streamorigin, timeoutms, streamcustomization, extrawaittime, var_654469cb39851c3d )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isvector( streamorigin ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    self notify( #"hash_b70a0ed0949e821f" );
    self endon( #"hash_b70a0ed0949e821f" );
    self endon( #"disconnect" );
    waitforstreaming = !self isplayerheadless() && !isbot( self );
    
    if ( !waitforstreaming )
    {
        println( "<dev string:x64>" );
    }
    
    if ( !isdefined( timeoutms ) )
    {
        timeoutms = getdefaultstreamhinttimeoutms();
    }
    
    timeout = gettime() + timeoutms;
    self.prestreaminglocation = 1;
    self.var_7e28ad9fcf969ca = undefined;
    
    /#
        function_26c26f13f7d49175( "<dev string:x80>" + streamorigin[ 0 ] + "<dev string:xa7>" + streamorigin[ 1 ] + "<dev string:xa7>" + streamorigin[ 2 ] + "<dev string:xaa>" );
    #/
    
    if ( !self ispredictedstreamposready() )
    {
        /#
            function_26c26f13f7d49175( "<dev string:xad>" );
        #/
        
        self clearpredictedstreampos();
    }
    
    waitstarttime = gettime();
    currenttime = waitstarttime;
    
    if ( waitforstreaming )
    {
        println( "<dev string:xd9>" );
        waitframe();
        
        while ( true )
        {
            currenttime = gettime();
            
            if ( self.pers[ "streamSyncComplete" ] )
            {
                break;
            }
            
            if ( currenttime >= timeout )
            {
                break;
            }
            
            waitframe();
        }
    }
    
    /#
        timedouttext = "<dev string:xf4>" + timeoutms / 1000 + "<dev string:x100>";
        result = timedouttext;
        
        if ( self.pers[ "<dev string:x10a>" ] )
        {
            result = "<dev string:x11d>" + ( currenttime - waitstarttime ) / 1000 + "<dev string:x100>";
        }
        
        function_26c26f13f7d49175( "<dev string:x139>" + result + "<dev string:x14e>" );
    #/
    
    if ( function_bac26315148e18d3() )
    {
        println( "<dev string:x150>" );
        self predictstreamposuntilcleared( streamorigin );
    }
    
    if ( streamcustomization )
    {
        println( "<dev string:x179>" );
        self loadcustomizationplayerview( self );
    }
    
    if ( waitforstreaming )
    {
        waitframe();
        
        /#
            debugwaittime = getdvarfloat( @"hash_e799b8bb09ac23a4", 0 );
            
            if ( debugwaittime > 0 )
            {
                wait debugwaittime;
                function_26c26f13f7d49175( "<dev string:x196>" + debugwaittime + "<dev string:x1b9>" );
            }
        #/
        
        currenttime = gettime();
        
        if ( currenttime < timeout )
        {
            /#
                startms = currenttime;
            #/
            
            while ( true )
            {
                currenttime = gettime();
                
                if ( currenttime >= timeout )
                {
                    break;
                }
                
                ready = self ispredictedstreamposready();
                
                if ( ready )
                {
                    println( "<dev string:x1c4>" );
                    break;
                }
                
                waitframe();
            }
            
            /#
                result = timedouttext;
                
                if ( ready )
                {
                    result = "<dev string:x1e2>" + ( currenttime - startms ) / 1000 + "<dev string:x100>";
                }
                
                function_26c26f13f7d49175( "<dev string:x139>" + result + "<dev string:x14e>" );
            #/
        }
        
        if ( currenttime < timeout && streamcustomization )
        {
            /#
                startms = currenttime;
            #/
            
            while ( true )
            {
                currenttime = gettime();
                
                if ( currenttime >= timeout )
                {
                    break;
                }
                
                ready = self hasloadedcustomizationplayerview( self );
                
                if ( ready )
                {
                    println( "<dev string:x201>" );
                    break;
                }
                
                waitframe();
            }
            
            /#
                result = timedouttext;
                
                if ( ready )
                {
                    result = "<dev string:x1e2>" + ( currenttime - startms ) / 1000 + "<dev string:x100>";
                }
                
                function_26c26f13f7d49175( "<dev string:x139>" + result + "<dev string:x14e>" );
            #/
        }
        
        self.var_7e28ad9fcf969ca = 1;
        
        if ( extrawaittime )
        {
            var_68df72ab7a2b3c5d = getdvarint( @"hash_6f5f8daeb9f79d47", 5000 ) / 1000;
            wait var_68df72ab7a2b3c5d;
            
            /#
                function_26c26f13f7d49175( "<dev string:x21e>" + var_68df72ab7a2b3c5d + "<dev string:x1b9>" );
            #/
        }
        
        currenttime = gettime();
        
        if ( isdefined( var_654469cb39851c3d ) )
        {
            /#
                startms = currenttime;
            #/
            
            var_c044f1d106e95c6c = getdvarint( @"hash_9d5507c09010bae5", 2000 );
            timeout = currenttime + var_654469cb39851c3d;
            var_7ae62165182c2ce6 = 0;
            
            while ( true )
            {
                currenttime = gettime();
                
                if ( var_654469cb39851c3d != -1 )
                {
                    if ( currenttime >= timeout )
                    {
                        break;
                    }
                }
                else
                {
                    /#
                        function_26c26f13f7d49175( "<dev string:x244>" );
                    #/
                }
                
                if ( currenttime > var_7ae62165182c2ce6 )
                {
                    self predictstreamposuntilcleared( streamorigin );
                    var_7ae62165182c2ce6 = gettime() + var_c044f1d106e95c6c;
                }
                
                waitframe();
            }
            
            /#
                result = "<dev string:x278>" + ( currenttime - startms ) / 1000 + "<dev string:x100>";
                function_26c26f13f7d49175( "<dev string:x139>" + result + "<dev string:x14e>" );
            #/
        }
    }
    
    /#
        var_43f78349754581f3 = !waitforstreaming || self ispredictedstreamposready();
        var_4e3de697683e929b = ( currenttime - waitstarttime ) / 1000;
        println( "<dev string:x299>" + streamorigin[ 0 ] + "<dev string:xa7>" + streamorigin[ 1 ] + "<dev string:xa7>" + streamorigin[ 2 ] + "<dev string:x2d3>" + var_4e3de697683e929b + "<dev string:x2d9>" + ( var_43f78349754581f3 ? "<dev string:x2e5>" : "<dev string:x2ee>" ) + "<dev string:x2f8>" );
    #/
    
    self.prestreaminglocation = undefined;
    self notify( #"hash_2d0813a2d19b7c7e" );
}

// Namespace streamhint
// Params 0
// Checksum 0x784a59af, Offset: 0x5f9
// Size: 0x70, Type: bool
function function_bac26315148e18d3()
{
    if ( level.gamemodebundle.var_f650a8772dec6e45 )
    {
        return false;
    }
    
    return !isbrgamemode() || level.skipprematch || !isdefined( level.infilstruct.var_e3fb172254c8751 ) || level.infilstruct.var_2c8cdd72c4c046d7 || !getdvarint( @"hash_f49bd659b301fbb0", 1 );
}

// Namespace streamhint
// Params 0
// Checksum 0x52337ee0, Offset: 0x672
// Size: 0x12
function getdefaultstreamhinttimeoutms()
{
    return getdvarint( @"hash_aaffd5b201281ad4", 9000 );
}

/#

    // Namespace streamhint
    // Params 1
    // Checksum 0xbfcb858d, Offset: 0x68d
    // Size: 0x35, Type: dev
    function function_26c26f13f7d49175( msg )
    {
        if ( getdvarint( @"hash_542e2db225a880f3", 0 ) == 1 )
        {
            self iprintlnbold( msg );
            return;
        }
        
        println( msg );
    }

#/
