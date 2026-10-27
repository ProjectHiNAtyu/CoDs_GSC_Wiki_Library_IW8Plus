// script_d74ae0b4aa21186  (hash_0d74ae0b4aa21186.gscc) (size: 14879 Bytes / 0x3a1f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4145090a (1095043338)
// size ...... 14879 (0x3a1f)
// includes .. 3   (offset: 0x37f7)
// strings ... 10  (offset: 0x380f)
// dev strs .. 27  (offset: 0x389f)
// exports ... 54  (offset: 0x2787)
// cseg ...... 0x10a + 0x267d (0x2787)
// imports ... 62  (offset: 0x2ff7)
// animtree1 . 0   (offset: 0x3a1f)
// animtree2 . 0   (offset: 0x3a1f)
#using script_4a941421347ff7df;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace mind;

// Namespace mind
// Params 1
// Checksum 0x9c862902, Offset: 0x128
// Size: 0x8e
function globalinitialize( var_5b7eea6e9ab39773 )
{
    assert( !isbrgamemode(), "<dev string:x24>" );
    
    if ( isdefined( level.mind ) )
    {
        return;
    }
    
    level.mind = spawnstruct();
    level.mind.callbacks = [];
    registercallback( "GetDecisionSet", var_5b7eea6e9ab39773 );
    level.mind.events = spawnstruct();
    level.mind.decisions = mind_config::function_d4ff4acc71410acb();
}

// Namespace mind
// Params 0
// Checksum 0x7ea84873, Offset: 0x1be
// Size: 0x56
function initialize()
{
    assert( !isbrgamemode(), "<dev string:x24>" );
    assert( isdefined( level.mind ) );
    
    if ( isdefined( self.mind ) )
    {
        return;
    }
    
    self.mind = spawnstruct();
    function_4527cf1bb8590dc8();
    function_a617f26ac603355a();
    function_661b41eca2a758ab();
}

// Namespace mind
// Params 0
// Checksum 0x851d12b6, Offset: 0x21c
// Size: 0x17
function start()
{
    function_d561a22a98e68be4();
    childthread function_282dffe171ee4f7a();
    thread watchendthread();
}

// Namespace mind
// Params 0, eflags: 0x4
// Checksum 0xd02b87e, Offset: 0x23b
// Size: 0x64
function private watchendthread()
{
    self.mind.isupdating = 1;
    result = utility::function_22939e0bc589604e( 0, level, "game_ended", self, "bot_suspended", self, "death_or_disconnect", self, "exit_autopilot" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.mind.isupdating = undefined;
    function_3bf4ad46124d112c();
}

// Namespace mind
// Params 0
// Checksum 0x95c297b5, Offset: 0x2a7
// Size: 0x7a
function update()
{
    starttimeus = getsystemtimeinmicroseconds();
    function_fde41d4e2f7838d6();
    currenttimeus = getsystemtimeinmicroseconds();
    
    if ( currenttimeus < starttimeus )
    {
        elapsedtimeus = 2147483647 - starttimeus + 1 + currenttimeus;
    }
    else
    {
        elapsedtimeus = currenttimeus - starttimeus;
    }
    
    waittimesec = 0.1 - elapsedtimeus * 1e-06;
    
    if ( waittimesec > 0 )
    {
        wait waittimesec;
        return;
    }
    
    wait 0.001;
}

// Namespace mind
// Params 0, eflags: 0x4
// Checksum 0x9c67142c, Offset: 0x329
// Size: 0x10
function private function_fde41d4e2f7838d6()
{
    function_87afd998d1bd9001();
    function_d2537dbb6622358b();
}

// Namespace mind
// Params 1
// Checksum 0x9e547601, Offset: 0x341
// Size: 0x23, Type: bool
function function_9121f9013f21ae76( callbackname )
{
    return isdefined( level.mind.callbacks[ callbackname ] );
}

// Namespace mind
// Params 2
// Checksum 0x57cfd166, Offset: 0x36d
// Size: 0x7c
function registercallback( callbackname, function )
{
    if ( !isdefined( level.mind.callbacks ) )
    {
        assertmsg( "<dev string:x64>" );
        return;
    }
    
    if ( isdefined( function ) && function_9121f9013f21ae76( callbackname ) )
    {
        assertmsg( "<dev string:x81>" + callbackname + "<dev string:xa5>" );
        return;
    }
    
    level.mind.callbacks[ callbackname ] = function;
}

// Namespace mind
// Params 3
// Checksum 0xba92578c, Offset: 0x3f1
// Size: 0xaf
function runcallback( callbackname, param1, param2 )
{
    if ( !isdefined( level.mind.callbacks ) )
    {
        assertmsg( "<dev string:x64>" );
        return;
    }
    
    if ( function_9121f9013f21ae76( callbackname ) )
    {
        if ( isdefined( param2 ) )
        {
            return [[ level.mind.callbacks[ callbackname ] ]]( param1, param2 );
        }
        
        if ( isdefined( param1 ) )
        {
            return [[ level.mind.callbacks[ callbackname ] ]]( param1 );
        }
        
        return [[ level.mind.callbacks[ callbackname ] ]]();
    }
}

// Namespace mind
// Params 0
// Checksum 0x8a5b8eda, Offset: 0x4a8
// Size: 0x40
function function_4527cf1bb8590dc8()
{
    self.mind.eventstream = spawnstruct();
    self.mind.eventstream.events = [];
    mind_config::createevents();
}

// Namespace mind
// Params 0
// Checksum 0x5041dd63, Offset: 0x4f0
// Size: 0x21
function function_1d123cae6381160b()
{
    event = spawnstruct();
    event.evaluated = 0;
    return event;
}

// Namespace mind
// Params 0
// Checksum 0x1a3f5d99, Offset: 0x51a
// Size: 0x93
function function_87afd998d1bd9001()
{
    foreach ( event in self.mind.eventstream.events )
    {
        event.evaluated = 0;
    }
}

// Namespace mind
// Params 0
// Checksum 0xdc3fc4aa, Offset: 0x5b5
// Size: 0x16a
function function_a617f26ac603355a()
{
    decisionmaker = spawnstruct();
    decisionmaker.decisions = [];
    
    /#
        decisionmaker.debuginfo = "<dev string:xaf>";
    #/
    
    descriptions = level.mind.decisions;
    decisionnames = mind_config::function_ad32ada0fcba9ef0();
    
    if ( isdefined( decisionnames ) )
    {
        foreach ( decisionname in decisionnames )
        {
            desc = descriptions[ decisionname ];
            assert( isdefined( desc ), "<dev string:xb0>" + decisionname );
            var_15b413370ccb0131 = desc.var_15b413370ccb0131;
            assert( isdefined( var_15b413370ccb0131 ), "<dev string:xc8>" + decisionname );
            decision = self [[ var_15b413370ccb0131 ]]();
            
            if ( !isdefined( decision ) )
            {
                continue;
            }
            
            decision.name = decisionname;
            decisionmaker.decisions[ decisionname ] = decision;
        }
    }
    
    self.mind.decisionmaker = decisionmaker;
    function_c3a38ac432d32220();
}

// Namespace mind
// Params 5
// Checksum 0xfcc5ebc1, Offset: 0x727
// Size: 0x126
function function_6e220221dd563155( scoremethod, var_825062482a3cc550, var_632fd07dcaa0186a = 1000, var_4e250044c834f802, decisionswitches )
{
    assert( var_632fd07dcaa0186a >= 100 );
    decision = { #decisionswitches:decisionswitches, #var_4e250044c834f802:var_4e250044c834f802, #nextupdatetime:0, #var_632fd07dcaa0186a:var_632fd07dcaa0186a, #actiongenerator:var_825062482a3cc550, #evaluatescore:scoremethod, #score:0, #disabledflags:0 };
    
    if ( isdefined( decisionswitches ) )
    {
        foreach ( decisionswitch in decisionswitches )
        {
            decisionswitch.decision = decision;
        }
    }
    
    return decision;
}

// Namespace mind
// Params 1
// Checksum 0x67d71230, Offset: 0x856
// Size: 0x53
function function_6060622222c6aa90( var_632fd07dcaa0186a )
{
    assert( var_632fd07dcaa0186a >= 100 );
    
    if ( var_632fd07dcaa0186a == self.var_632fd07dcaa0186a )
    {
        return;
    }
    
    self.nextupdatetime += var_632fd07dcaa0186a - self.var_632fd07dcaa0186a;
    self.var_632fd07dcaa0186a = var_632fd07dcaa0186a;
}

// Namespace mind
// Params 0
// Checksum 0x2cd6e0c9, Offset: 0x8b1
// Size: 0x1fe
function function_d2537dbb6622358b()
{
    finaldecision = undefined;
    currenttime = gettime();
    
    foreach ( decision in self.mind.decisionmaker.decisions )
    {
        decision.generatedaction = undefined;
        
        if ( decision.disabledflags || currenttime < decision.nextupdatetime )
        {
            decision.var_75adc6a4401f1ff3 = 0;
            decision.score = 0;
            continue;
        }
        
        decision.var_75adc6a4401f1ff3 = 1;
        decision.nextupdatetime += decision.var_632fd07dcaa0186a;
        
        if ( decision.nextupdatetime <= currenttime )
        {
            decision.nextupdatetime = currenttime + decision.var_632fd07dcaa0186a;
        }
        
        decision.score = function_b14686a1e123c743( decision );
        
        if ( decision.score > 0 )
        {
            if ( !isdefined( finaldecision ) || decision.score > finaldecision.score )
            {
                finaldecision = decision;
            }
        }
    }
    
    if ( isdefined( finaldecision ) )
    {
        betterdecision = function_e8ea31f5c9e5b83a( finaldecision );
        
        if ( isdefined( betterdecision ) )
        {
            finaldecision = betterdecision;
        }
        
        if ( finaldecision function_669975634ad67cef( self ) )
        {
            function_a5344d67cd900d9b( finaldecision.generatedaction, finaldecision.score );
        }
    }
    
    /#
        self.mind.decisionmaker.debuginfo = "<dev string:xaf>";
    #/
}

// Namespace mind
// Params 1
// Checksum 0x7dfc63d4, Offset: 0xab7
// Size: 0x152
function function_e8ea31f5c9e5b83a( decision )
{
    if ( !decision function_669975634ad67cef( self ) )
    {
        return;
    }
    
    exclusivegroup = decision.generatedaction.exclusivegroup;
    
    foreach ( executing in self.mind.var_60ea789328f81d85.actions )
    {
        if ( exclusivegroup == executing.exclusivegroup )
        {
            targetdecision = executing.decision;
            
            if ( !targetdecision.disabledflags && !targetdecision.var_75adc6a4401f1ff3 )
            {
                targetdecision.generatedaction = undefined;
                score = function_b14686a1e123c743( targetdecision );
                
                if ( score >= decision.score )
                {
                    targetdecision.score = score;
                    return targetdecision;
                }
                else
                {
                    targetdecision.generatedaction = undefined;
                }
            }
            
            break;
        }
    }
}

// Namespace mind
// Params 1, eflags: 0x4
// Checksum 0xb4db5e25, Offset: 0xc12
// Size: 0x3f
function private function_b14686a1e123c743( decision )
{
    score = decision [[ decision.evaluatescore ]]( self );
    
    if ( !isdefined( score ) )
    {
        decision enabledecision( 0, 2 );
        return 0;
    }
    
    return score;
}

// Namespace mind
// Params 1
// Checksum 0xd7ee48dc, Offset: 0xc5a
// Size: 0x77
function function_669975634ad67cef( bot )
{
    if ( isdefined( self.generatedaction ) )
    {
        return 1;
    }
    
    if ( isdefined( self.actiongenerator ) )
    {
        self.generatedaction = self [[ self.actiongenerator ]]( bot );
        assert( isdefined( self.generatedaction ) );
        return 1;
    }
    
    assertmsg( "<dev string:xf7>" + self.name + "<dev string:x121>" );
    return 0;
}

/#

    // Namespace mind
    // Params 1
    // Checksum 0x229d07e7, Offset: 0xcd9
    // Size: 0x1b8, Type: dev
    function function_36d91754a4470861( var_3539ccf1ca4b5d2a )
    {
        assert( !isdefined( var_3539ccf1ca4b5d2a ) || var_3539ccf1ca4b5d2a > 0 );
        decisionmaker = self.mind.decisionmaker;
        
        if ( decisionmaker.debuginfo.size > 0 )
        {
            return decisionmaker.debuginfo;
        }
        
        var_992292637bfcfc42 = function_913cc9cac6344be( decisionmaker.decisions );
        debuginfo = "<dev string:xaf>";
        count = 0;
        
        foreach ( decision in var_992292637bfcfc42 )
        {
            score = int( decision.score );
            
            if ( score <= 0 )
            {
                break;
            }
            
            if ( debuginfo.size > 0 )
            {
                debuginfo += "<dev string:x123>";
            }
            
            if ( isdefined( decision.generatedaction ) )
            {
                name = decision.generatedaction getdescription();
            }
            else
            {
                name = decision.name;
            }
            
            debuginfo += score + "<dev string:x127>" + name;
            count++;
            
            if ( count == var_3539ccf1ca4b5d2a )
            {
                break;
            }
        }
        
        if ( debuginfo.size > 0 )
        {
            println( "<dev string:x129>" + self getentitynumber() + "<dev string:x144>" + debuginfo );
        }
        
        decisionmaker.debuginfo = debuginfo;
        return debuginfo;
    }

    // Namespace mind
    // Params 0
    // Checksum 0x417de5fd, Offset: 0xe99
    // Size: 0x51, Type: dev
    function getdescription()
    {
        var_7de2c32605b1fdee = 25;
        description = self.description;
        len = description.size;
        
        if ( len > var_7de2c32605b1fdee )
        {
            description = getsubstr( description, 0, var_7de2c32605b1fdee - 3 ) + "<dev string:x147>";
        }
        
        return description;
    }

#/

// Namespace mind
// Params 1
// Checksum 0xf86e2319, Offset: 0xef2
// Size: 0x1d
function function_913cc9cac6344be( decisions )
{
    return function_7243d45b5d82f431( decisions, #score, 1 );
}

// Namespace mind
// Params 1
// Checksum 0x47acb65b, Offset: 0xf18
// Size: 0xf0
function function_5af570cf416d892e( argument )
{
    action = self.ongoingaction;
    
    if ( !isdefined( action ) )
    {
        return 0;
    }
    
    if ( !isdefined( action.var_2a6412b65b3b85dc ) )
    {
        return 0;
    }
    
    currentargument = action.argument;
    
    if ( isdefined( currentargument ) != isdefined( argument ) )
    {
        return 0;
    }
    
    if ( isdefined( currentargument ) )
    {
        if ( isdefined( self.var_4e250044c834f802 ) )
        {
            if ( ![[ self.var_4e250044c834f802 ]]( currentargument, argument ) )
            {
                return 0;
            }
        }
        else
        {
            assert( !isstruct( currentargument ), "<dev string:x14b>" );
            
            if ( currentargument != argument )
            {
                return 0;
            }
        }
    }
    
    sunkcost = ( gettime() - action.createtime ) * action.var_2a6412b65b3b85dc * 0.001;
    
    if ( sunkcost > action.var_4d6e31701cd8323 )
    {
        sunkcost = action.var_4d6e31701cd8323;
    }
    
    return sunkcost;
}

// Namespace mind
// Params 3
// Checksum 0x127755da, Offset: 0x1011
// Size: 0x51
function function_11fa8f666f12008b( toenable, callbackevent, checkfunc )
{
    assert( isdefined( toenable ) && isdefined( callbackevent ) );
    return { #toenable:toenable, #checkfunc:checkfunc, #callbackevent:callbackevent };
}

// Namespace mind
// Params 4
// Checksum 0x5462957, Offset: 0x106b
// Size: 0x6b
function function_3bb7909e5a86e8f( toenable, var_d183fae00e665a75, notificationsignal, checkfunc )
{
    assert( isdefined( toenable ) && isdefined( var_d183fae00e665a75 ) && isdefined( notificationsignal ) );
    return { #toenable:toenable, #checkfunc:checkfunc, #var_d183fae00e665a75:var_d183fae00e665a75, #notificationsignal:notificationsignal };
}

// Namespace mind
// Params 1
// Checksum 0x95f61a56, Offset: 0x10df
// Size: 0x23
function function_112fc691aa2a03af( var_cc9b167afa884a52 )
{
    assert( isdefined( var_cc9b167afa884a52 ) );
    return { #var_cc9b167afa884a52:var_cc9b167afa884a52 };
}

// Namespace mind
// Params 2
// Checksum 0x1db9dd08, Offset: 0x110b
// Size: 0xb9
function function_8a6d2c7bff38fe07( enabled, var_4114d7a3a198cf1e )
{
    foreach ( name, decision in self.mind.decisionmaker.decisions )
    {
        if ( isdefined( var_4114d7a3a198cf1e ) && arraycontains( var_4114d7a3a198cf1e, name ) )
        {
            continue;
        }
        
        decision enabledecision( enabled, 1 );
    }
}

// Namespace mind
// Params 2, eflags: 0x4
// Checksum 0xfd7d432a, Offset: 0x11cc
// Size: 0x5f
function private enabledecision( enabled, flag )
{
    if ( function_c0af675935ac3052( enabled, flag ) )
    {
        return;
    }
    
    if ( enabled )
    {
        self.disabledflags &= ~flag;
        self.nextupdatetime = 0;
        return;
    }
    
    self.disabledflags |= flag;
}

// Namespace mind
// Params 2, eflags: 0x4
// Checksum 0xbfb0858c, Offset: 0x1233
// Size: 0x26, Type: bool
function private function_c0af675935ac3052( enabled, flag )
{
    return enabled == ( self.disabledflags & flag ) == 0;
}

// Namespace mind
// Params 0, eflags: 0x4
// Checksum 0x9723b28, Offset: 0x1262
// Size: 0x1b4
function private function_d561a22a98e68be4()
{
    foreach ( decision in self.mind.decisionmaker.decisions )
    {
        if ( decision function_f8c4aecf5db4fadc() )
        {
            decision enabledecision( 0, 2 );
            continue;
        }
        
        decision.nextupdatetime = 0;
        decision enabledecision( 1, 2 );
        
        if ( !isdefined( decision.decisionswitches ) )
        {
            continue;
        }
        
        foreach ( decisionswitch in decision.decisionswitches )
        {
            assert( isdefined( decisionswitch.callbackevent ) || isdefined( decisionswitch.notificationsignal ) || isdefined( decisionswitch.var_cc9b167afa884a52 ) );
            
            if ( isdefined( decisionswitch.callbackevent ) )
            {
                callback::add( decisionswitch.callbackevent, &function_b9c9d259a9c4f031, decisionswitch );
                continue;
            }
            
            if ( isdefined( decisionswitch.notificationsignal ) )
            {
                childthread function_6a3297d7c0fbea0( decisionswitch );
            }
        }
    }
}

// Namespace mind
// Params 0, eflags: 0x4
// Checksum 0xed39c0ee, Offset: 0x141e
// Size: 0x131
function private function_3bf4ad46124d112c()
{
    foreach ( decision in self.mind.decisionmaker.decisions )
    {
        if ( !isdefined( decision.decisionswitches ) )
        {
            continue;
        }
        
        foreach ( decisionswitch in decision.decisionswitches )
        {
            if ( isdefined( decisionswitch.callbackevent ) )
            {
                callback::remove( decisionswitch.callbackevent, &function_b9c9d259a9c4f031, decisionswitch );
            }
        }
    }
}

// Namespace mind
// Params 0, eflags: 0x4
// Checksum 0x77bfff73, Offset: 0x1557
// Size: 0x14c
function private function_f8c4aecf5db4fadc()
{
    /#
        var_ef9faa040e431733 = 0;
        
        foreach ( decisionswitch in self.decisionswitches )
        {
            if ( isdefined( decisionswitch.var_cc9b167afa884a52 ) )
            {
                var_ef9faa040e431733++;
                continue;
            }
            
            assert( isdefined( decisionswitch.callbackevent ) != isdefined( decisionswitch.notificationsignal ) );
        }
        
        assert( var_ef9faa040e431733 <= 1, "<dev string:x197>" );
    #/
    
    foreach ( decisionswitch in self.decisionswitches )
    {
        if ( isdefined( decisionswitch.var_cc9b167afa884a52 ) )
        {
            return [[ decisionswitch.var_cc9b167afa884a52 ]]();
        }
    }
    
    return 0;
}

// Namespace mind
// Params 1, eflags: 0x4
// Checksum 0x6e5d0edf, Offset: 0x16ac
// Size: 0x54
function private function_6a3297d7c0fbea0( decisionswitch )
{
    while ( true )
    {
        decisionswitch.var_d183fae00e665a75 waittill( decisionswitch.notificationsignal, var_f62392c0cb304499 );
        notificationparams = [ var_f62392c0cb304499 ];
        function_b9c9d259a9c4f031( notificationparams, decisionswitch );
    }
}

// Namespace mind
// Params 2, eflags: 0x4
// Checksum 0x7908d4d0, Offset: 0x1708
// Size: 0x99
function private function_b9c9d259a9c4f031( params, decisionswitch )
{
    if ( !isdefined( decisionswitch.checkfunc ) )
    {
        triggered = 1;
    }
    else
    {
        if ( decisionswitch.decision function_c0af675935ac3052( decisionswitch.toenable, 2 ) )
        {
            return;
        }
        
        triggered = decisionswitch.decision [[ decisionswitch.checkfunc ]]( params, self );
    }
    
    if ( triggered )
    {
        decisionswitch.decision enabledecision( decisionswitch.toenable, 2 );
    }
}

// Namespace mind
// Params 2
// Checksum 0x8be695dc, Offset: 0x17a9
// Size: 0x53
function function_1ee329c7a6e496b9( var_1593cce019846706, metatag )
{
    assert( isdefined( var_1593cce019846706 ), "<dev string:x1f8>" );
    constants = spawnstruct();
    [[ var_1593cce019846706 ]]( constants );
    constants.var_90b09a5366e16d3e = metatag ?? "";
    return constants;
}

// Namespace mind
// Params 2
// Checksum 0x5f293151, Offset: 0x1805
// Size: 0x66
function function_9a8a822b063d346( var_1593cce019846706, metatag )
{
    assert( isstruct( self ), "<dev string:x23e>" );
    assert( isdefined( var_1593cce019846706 ) && isdefined( metatag ), "<dev string:x287>" );
    var_9fcf76a44f30678c = structcopy( self, 1 );
    [[ var_1593cce019846706 ]]( var_9fcf76a44f30678c );
    var_9fcf76a44f30678c.var_90b09a5366e16d3e = metatag;
    return var_9fcf76a44f30678c;
}

// Namespace mind
// Params 2
// Checksum 0xafa27188, Offset: 0x1874
// Size: 0xf8
function function_5a8d4f1e3543b4ba( createmethod, var_a338a6117a34cd53 )
{
    assert( isdefined( createmethod ), "<dev string:x2bf>" );
    desc = spawnstruct();
    desc.var_15b413370ccb0131 = createmethod;
    
    if ( isdefined( var_a338a6117a34cd53 ) )
    {
        constantsmap = [];
        constantslist = [[ var_a338a6117a34cd53 ]]();
        
        foreach ( constants in constantslist )
        {
            if ( isdefined( constants.var_90b09a5366e16d3e ) )
            {
                constantsmap[ constants.var_90b09a5366e16d3e ] = constants;
            }
        }
        
        desc.constantsmap = constantsmap;
    }
    
    return desc;
}

// Namespace mind
// Params 0
// Checksum 0xdc496b9b, Offset: 0x1975
// Size: 0x12e
function function_c3a38ac432d32220()
{
    assert( isdefined( self.mind ) && isdefined( self.mind.decisionmaker ) );
    decisionmaker = self.mind.decisionmaker;
    descriptions = level.mind.decisions;
    matchlist = mind_config::function_9104eae940a20cf2();
    
    foreach ( name, decision in decisionmaker.decisions )
    {
        desc = descriptions[ name ];
        assert( isdefined( desc ) );
        
        if ( isdefined( desc.constantsmap ) )
        {
            decision.constants = mind_config::function_45262766d75ca7f5( desc.constantsmap, matchlist );
        }
    }
}

// Namespace mind
// Params 0
// Checksum 0x1cb67aea, Offset: 0x1aab
// Size: 0x5b
function function_661b41eca2a758ab()
{
    var_60ea789328f81d85 = spawnstruct();
    var_60ea789328f81d85.actions = [];
    var_60ea789328f81d85.var_2a0fe45866847b3c = mind_config::function_118a22c088e91252();
    
    /#
        var_60ea789328f81d85.debuginfo = "<dev string:xaf>";
    #/
    
    self.mind.var_60ea789328f81d85 = var_60ea789328f81d85;
}

// Namespace mind
// Params 9
// Checksum 0xb96e6266, Offset: 0x1b0e
// Size: 0x180
function createactionbase( name, argument, exclusivegroup, description, processmethod, decision, endhandler, var_2a6412b65b3b85dc, var_4d6e31701cd8323 )
{
    assert( !isdefined( var_2a6412b65b3b85dc ) || var_2a6412b65b3b85dc > 0 );
    assert( !isdefined( var_4d6e31701cd8323 ) || var_4d6e31701cd8323 > 0 );
    assert( isdefined( var_2a6412b65b3b85dc ) || !isdefined( var_4d6e31701cd8323 ), "<dev string:x306>" );
    
    if ( !isdefined( description ) )
    {
        assertmsg( "<dev string:x33b>" + name + "<dev string:x356>" );
        description = "";
    }
    
    action = spawnstruct();
    action.name = name;
    action.argument = argument;
    action.exclusivegroup = exclusivegroup;
    action.description = name;
    
    if ( description.size > 0 )
    {
        action.description += " " + description;
    }
    
    action.processmethod = processmethod;
    action.decision = decision;
    action.endhandler = endhandler;
    action.var_2a6412b65b3b85dc = var_2a6412b65b3b85dc;
    action.var_4d6e31701cd8323 = var_4d6e31701cd8323;
    action.createtime = gettime();
    return action;
}

// Namespace mind
// Params 2, eflags: 0x4
// Checksum 0x71043a68, Offset: 0x1c97
// Size: 0x72
function private function_a5344d67cd900d9b( action, score )
{
    actiondata = { #score:score, #action:action };
    self.mind.var_60ea789328f81d85.requestedactions[ action.exclusivegroup ] = actiondata;
    self notify( #"hash_198e4a9ee19d8ba8", actiondata );
}

// Namespace mind
// Params 0, eflags: 0x4
// Checksum 0x236f29a5, Offset: 0x1d11
// Size: 0x14f
function private function_282dffe171ee4f7a()
{
    self.mind.var_60ea789328f81d85.requestedactions = [];
    
    while ( true )
    {
        self waittill( #"hash_198e4a9ee19d8ba8", actiondata );
        self.mind.var_60ea789328f81d85.requestedactions[ actiondata.action.exclusivegroup ] = undefined;
        executeaction( actiondata.action, actiondata.score );
        
        while ( self.mind.var_60ea789328f81d85.requestedactions.size != 0 )
        {
            [ firstkey ] = getarraykeys( self.mind.var_60ea789328f81d85.requestedactions );
            actiondata = self.mind.var_60ea789328f81d85.requestedactions[ firstkey ];
            self.mind.var_60ea789328f81d85.requestedactions[ firstkey ] = undefined;
            executeaction( actiondata.action, actiondata.score );
        }
    }
}

// Namespace mind
// Params 2
// Checksum 0x11c2638d, Offset: 0x1e68
// Size: 0xfc
function executeaction( action, score )
{
    var_60ea789328f81d85 = self.mind.var_60ea789328f81d85;
    
    foreach ( executing in var_60ea789328f81d85.actions )
    {
        if ( action.description == executing.description )
        {
            return;
        }
    }
    
    action.score = score;
    action.decision.ongoingaction = action;
    action.var_8816216d76c96233 = var_60ea789328f81d85;
    startaction( action );
}

// Namespace mind
// Params 1
// Checksum 0xd71dc713, Offset: 0x1f6c
// Size: 0x18b
function startaction( action )
{
    var_60ea789328f81d85 = self.mind.var_60ea789328f81d85;
    
    if ( action.exclusivegroup != "" )
    {
        removers = [];
        
        foreach ( executing in var_60ea789328f81d85.actions )
        {
            if ( action.exclusivegroup == executing.exclusivegroup )
            {
                removers[ removers.size ] = executing;
            }
        }
        
        if ( removers.size > 0 )
        {
            foreach ( removing in removers )
            {
                endaction( removing );
            }
        }
    }
    
    var_60ea789328f81d85.actions[ var_60ea789328f81d85.actions.size ] = action;
    
    /#
        var_60ea789328f81d85.debuginfo = "<dev string:xaf>";
    #/
    
    thread actionthread( action );
}

// Namespace mind
// Params 1
// Checksum 0x813c316, Offset: 0x20ff
// Size: 0x111
function actionthread( action )
{
    level endon( #"game_ended" );
    endconditions = [ "bot_suspended", "death_or_disconnect", "exit_autopilot", action.description ];
    
    foreach ( condition in endconditions )
    {
        self endon( condition );
    }
    
    thread function_29a4cbecd3a5305a( endconditions, action );
    action.lasterror = action [[ action.processmethod ]]( self );
    
    /#
        if ( isdefined( action.lasterror ) )
        {
            action.var_a70272792c7974c1 = gettime();
        }
    #/
    
    self notify( action.description );
}

// Namespace mind
// Params 2
// Checksum 0xe8ade619, Offset: 0x2218
// Size: 0x1a8
function function_29a4cbecd3a5305a( endconditions, action )
{
    runcallback( "OnBotActionStart", self, action );
    function_b66942a10dd4a542( endconditions );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    runcallback( "OnBotActionEnd", self, action );
    action.completed = 1;
    action.decision.ongoingaction = undefined;
    var_60ea789328f81d85 = self.mind.var_60ea789328f81d85;
    var_60ea789328f81d85.actions = arrayremove( var_60ea789328f81d85.actions, action );
    
    if ( isdefined( action.endhandler ) )
    {
        lasterror = [[ action.endhandler ]]( action );
        
        if ( isdefined( lasterror ) )
        {
            action.lasterror = lasterror;
            
            /#
                action.var_a70272792c7974c1 = gettime();
            #/
        }
    }
    
    if ( isdefined( var_60ea789328f81d85.var_2a0fe45866847b3c ) )
    {
        [[ var_60ea789328f81d85.var_2a0fe45866847b3c ]]( action );
    }
    
    /#
        if ( isdefined( action.lasterror ) && action.lasterror.size > 0 )
        {
            var_60ea789328f81d85.lasterror = action.lasterror + "<dev string:x123>" + action getdescription() + "<dev string:x123>" + action.exclusivegroup;
            var_60ea789328f81d85.var_a70272792c7974c1 = action.var_a70272792c7974c1;
        }
        
        var_60ea789328f81d85.debuginfo = "<dev string:xaf>";
    #/
    
    self notify( action.description + "Ended" );
}

// Namespace mind
// Params 1
// Checksum 0xdfa01332, Offset: 0x23c8
// Size: 0x4d
function function_b66942a10dd4a542( messages )
{
    assert( messages.size > 0, "<dev string:x3e3>" );
    
    for ( i = 0; i < messages.size ; i++ )
    {
        self endon( messages[ i ] );
    }
    
    level waittill( #"game_ended" );
}

// Namespace mind
// Params 1
// Checksum 0xdc376149, Offset: 0x241d
// Size: 0x3e
function endaction( action )
{
    if ( action.completed )
    {
        return;
    }
    
    self notify( action.description );
    self waittill( action.description + "Ended" );
}

// Namespace mind
// Params 1
// Checksum 0xa11581e5, Offset: 0x2463
// Size: 0xaf, Type: bool
function function_8df460a06ac96fc1( decisionname )
{
    foreach ( action in self.mind.var_60ea789328f81d85.actions )
    {
        if ( action.decision.name == decisionname )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace mind
// Params 0
// Checksum 0x482b1443, Offset: 0x251b
// Size: 0x4, Type: bool
function function_c47a284545576f7a()
{
    return isdefined( self );
}

/#

    // Namespace mind
    // Params 0
    // Checksum 0xa5a3b5a, Offset: 0x2528
    // Size: 0x174, Type: dev
    function function_c5aeddd244a1f2b9()
    {
        var_60ea789328f81d85 = self.mind.var_60ea789328f81d85;
        
        if ( var_60ea789328f81d85.debuginfo.size > 0 )
        {
            return var_60ea789328f81d85.debuginfo;
        }
        
        debuginfo = "<dev string:xaf>";
        
        foreach ( action in var_60ea789328f81d85.actions )
        {
            if ( debuginfo.size > 0 )
            {
                debuginfo += "<dev string:x123>";
            }
            
            group = action.exclusivegroup;
            name = action.description;
            
            if ( isdefined( action.executingstatus ) && action.executingstatus.size > 0 )
            {
                name += "<dev string:x413>" + action.executingstatus;
            }
            
            debuginfo += group + "<dev string:x127>" + name;
        }
        
        if ( debuginfo.size > 0 )
        {
            println( "<dev string:x417>" + self getentitynumber() + "<dev string:x144>" + debuginfo );
        }
        
        var_60ea789328f81d85.debuginfo = debuginfo;
        return debuginfo;
    }

    // Namespace mind
    // Params 0
    // Checksum 0x28af5641, Offset: 0x26a4
    // Size: 0x8d, Type: dev
    function function_359be5e5e82f9bae()
    {
        if ( !isdefined( self.mind.var_60ea789328f81d85.lasterror ) )
        {
            return;
        }
        
        timesec = int( ( gettime() - self.mind.var_60ea789328f81d85.var_a70272792c7974c1 ) * 0.001 );
        return self.mind.var_60ea789328f81d85.lasterror + "<dev string:x123>" + timesec + "<dev string:x436>";
    }

    // Namespace mind
    // Params 1
    // Checksum 0x4fc3f26, Offset: 0x2739
    // Size: 0x4e, Type: dev
    function function_fce0e7ad88c9e106( status )
    {
        assert( isdefined( status ) );
        
        if ( self.executingstatus == status )
        {
            return;
        }
        
        self.executingstatus = status;
        self.var_8816216d76c96233.debuginfo = "<dev string:xaf>";
    }

#/
