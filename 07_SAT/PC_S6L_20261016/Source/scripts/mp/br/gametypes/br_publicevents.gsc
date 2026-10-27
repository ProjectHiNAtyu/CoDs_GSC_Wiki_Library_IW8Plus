// scripts\mp\br\gametypes\br_publicevents.gsc  (hash_4d5934d09ed188d8.gscc) (size: 18536 Bytes / 0x4868 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x42c1166f (1119950447)
// size ...... 18536 (0x4868)
// includes .. 11  (offset: 0x4448)
// strings ... 27  (offset: 0x44a0)
// dev strs .. 41  (offset: 0x463c)
// exports ... 51  (offset: 0x2e64)
// cseg ...... 0x26f + 0x2bf5 (0x2e64)
// imports ... 103 (offset: 0x365c)
// animtree1 . 0   (offset: 0x4868)
// animtree2 . 0   (offset: 0x4868)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\script;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_analytics;
#using scripts\mp\br\gametypes\br_dev;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_publicevents_meter;
#using scripts\mp\flags;
#using scripts\mp\hud_message;

#namespace br_publicevents;

// Namespace br_publicevents
// Params 0
// Checksum 0xe140afa8, Offset: 0x28d
// Size: 0x260
function init()
{
    var_2228cb5a427df43f = 1;
    var_ddeced6ab97712ac = 1;
    
    if ( getdvarint( @"hash_18afe7a288a4b1e4", 0 ) )
    {
        var_2228cb5a427df43f = 0;
        var_ddeced6ab97712ac = 0;
    }
    
    if ( getdvarint( @"hash_64f25bc4bc682cfe", 0 ) )
    {
        var_ddeced6ab97712ac = 0;
    }
    
    level.br_pe_enabled = 0;
    
    if ( !var_2228cb5a427df43f )
    {
        level notify( #"disable_public_event" );
        return;
    }
    
    publiceventlistbundle = function_7963b081587bb05d();
    
    if ( !isdefined( publiceventlistbundle ) )
    {
        return;
    }
    
    level.br_pe_data = [];
    function_1c4dba123670fb2c( publiceventlistbundle );
    level.br_pe_enabled = 1;
    br_dev::registerhandlecommand( &handledevcommand_publicevents );
    
    if ( !var_ddeced6ab97712ac )
    {
        return;
    }
    
    level.var_26ceb2fe24492935 = getdvarint( @"hash_965692fa542f0728", 1 ) == 1;
    level.var_e08c76fe0142bf9e = utility::function_edc4cc03e9e60b3e( @"hash_b5088319799172eb", 0, publiceventlistbundle.var_7312570a9c18605a );
    level.var_2dd23ec206fdf50a = utility::function_edc4cc03e9e60b3e( @"hash_90afac1657855099", 2, publiceventlistbundle.var_258e5963cc95147 );
    level.var_51259c14b4430a60 = utility::function_edc4cc03e9e60b3e( @"hash_23b4b411c19d8090", 5, publiceventlistbundle.initialdelay );
    level.var_79a6713373eda9c1 = utility::function_edc4cc03e9e60b3e( @"hash_a03801ae050ddf71", 8, publiceventlistbundle.subsequentdelay );
    level.var_468043fac43b5981 = function_e7fff3950cd3b406( utility::function_49a778e73bbb0f58( @"hash_d3da8cf30df8bef5", "", publiceventlistbundle.eventchances ) );
    level.var_cf3042bf3f1ed573 = 0;
    
    if ( function_925770b6e1a406f7() )
    {
        function_79ccfb77844eb541();
    }
    
    if ( function_e5783afe603c8f2b() )
    {
        level.var_41740947a9e0ecd0 = function_e7fff3950cd3b406( utility::function_49a778e73bbb0f58( @"hash_955b56c18d2a6100", "", publiceventlistbundle.var_c3b971eb450b2e5f ) );
        level.var_7b71dfe065d9a6f2 = function_ff66cb5b79ca6483( publiceventlistbundle.overtimeeventlist, "Overtime Events List" );
    }
    
    level.var_740e6a1633340d77 = utility::function_edc4cc03e9e60b3e( @"hash_6bfe84439d5b902e", 0, publiceventlistbundle.var_11b5834723c26880 );
    level.var_9652504dbe90daef = function_ff66cb5b79ca6483( publiceventlistbundle.matchwideeventlist, "Match-wide Events List" );
    
    if ( br_publicevents_meter::function_3579c7d501f13cef() )
    {
        level thread br_publicevents_meter::init();
    }
    
    thread function_989066750d103d20();
    utility::flag_set( "br_pe_init_completed" );
}

// Namespace br_publicevents
// Params 0
// Checksum 0x71fc4fdb, Offset: 0x4f5
// Size: 0x27
function function_989066750d103d20()
{
    if ( publiceventsenabled() )
    {
        if ( function_925770b6e1a406f7() )
        {
            level thread function_71ff50ded8bbd326();
            return;
        }
        
        level thread publiceventsmanager();
    }
}

// Namespace br_publicevents
// Params 1
// Checksum 0x8a9a98aa, Offset: 0x524
// Size: 0x1b4
function function_1c4dba123670fb2c( publiceventlistbundle )
{
    level notify( #"init_public_event" );
    profilestart();
    
    foreach ( publiceventconfig in publiceventlistbundle.var_f5d19c2b31830f8c )
    {
        function_b5a3148fd9d1d335( publiceventconfig, 0, publiceventlistbundle.var_251f8c4c5bdff133 );
    }
    
    foreach ( var_54a34a24ee812c2 in publiceventlistbundle.matchwideeventlist )
    {
        function_b5a3148fd9d1d335( var_54a34a24ee812c2, 1, publiceventlistbundle.var_251f8c4c5bdff133 );
    }
    
    foreach ( var_9f3c02585d5407dd in publiceventlistbundle.overtimeeventlist )
    {
        function_b5a3148fd9d1d335( var_9f3c02585d5407dd, 1, publiceventlistbundle.var_251f8c4c5bdff133 );
    }
    
    profilestop();
    function_3000980ac8a874d6();
}

// Namespace br_publicevents
// Params 3
// Checksum 0x97bde4ef, Offset: 0x6e0
// Size: 0x11f
function function_b5a3148fd9d1d335( eventconfig, var_c2b2680ee1609c1f, var_251f8c4c5bdff133 )
{
    if ( !isdefined( eventconfig.event ) )
    {
        /#
            function_49a141b589d5b344( "<dev string:x24>" + getdvar( @"scr_br_publiceventlist", "<dev string:x5c>" ) );
        #/
        
        return;
    }
    
    if ( !( eventconfig.weight > 0 || getdvarint( @"hash_c786dd248ea290e7", 0 ) ) )
    {
        /#
            function_49a141b589d5b344( "<dev string:x74>" + eventconfig.event + "<dev string:x8e>" + getdvar( @"scr_br_publiceventlist", "<dev string:x5c>" ) );
        #/
        
        return;
    }
    
    hashedreference = getxhashasset( function_a27dd7013e673e94( eventconfig.event ) );
    
    if ( var_c2b2680ee1609c1f && isdefined( level.br_pe_data[ hashedreference ] ) )
    {
        /#
            function_49a141b589d5b344( "<dev string:x74>" + eventconfig.event + "<dev string:xb1>" + getdvar( @"scr_br_publiceventlist", "<dev string:x5c>" ) );
        #/
        
        return;
    }
    
    publiceventinit( eventconfig, var_251f8c4c5bdff133 );
}

// Namespace br_publicevents
// Params 0
// Checksum 0x535b4ec3, Offset: 0x807
// Size: 0xf5
function function_3000980ac8a874d6()
{
    foreach ( eventdata in level.br_pe_data )
    {
        if ( eventdata.weight <= 0 && !function_45b6054ec3f6ce04( eventdata ) )
        {
            continue;
        }
        
        if ( isdefined( eventdata.validatefunc ) && ![[ eventdata.validatefunc ]]() )
        {
            eventdata.isinvalid = 1;
            continue;
        }
        
        if ( isdefined( eventdata.postinitfunc ) )
        {
            eventdata [[ eventdata.postinitfunc ]]();
            eventdata.var_ff10bc75a7f4c276 = 1;
        }
    }
}

// Namespace br_publicevents
// Params 0, eflags: 0x4
// Checksum 0x6bebcb3c, Offset: 0x904
// Size: 0x2d
function private function_79ccfb77844eb541()
{
    var_a30b483136c617b = spawnstruct();
    var_a30b483136c617b.weight = 0;
    registerpublicevent( "", var_a30b483136c617b );
}

// Namespace br_publicevents
// Params 1
// Checksum 0x6284c3c2, Offset: 0x939
// Size: 0xa3
function function_e7fff3950cd3b406( string )
{
    circleeventweights = [];
    var_71326f85c423ef7d = strtok( string, " " );
    
    foreach ( weight in var_71326f85c423ef7d )
    {
        circleeventweights[ circleeventweights.size ] = float( weight );
    }
    
    return circleeventweights;
}

// Namespace br_publicevents
// Params 2
// Checksum 0xd514e7bb, Offset: 0x9e5
// Size: 0xac
function registerpublicevent( eventtype, eventinfo )
{
    assert( isdefined( level.br_pe_data ) );
    assert( !isdefined( level.br_pe_data[ eventtype ] ) );
    
    if ( !isdefined( eventinfo.active ) )
    {
        eventinfo.active = 0;
    }
    
    if ( !isdefined( eventinfo.weight ) )
    {
        eventinfo.weight = 1;
    }
    
    if ( function_925770b6e1a406f7() )
    {
        if ( !isdefined( eventinfo.maxtimes ) )
        {
            eventinfo.maxtimes = 1;
        }
    }
    
    level.br_pe_data[ eventtype ] = eventinfo;
    return eventinfo;
}

// Namespace br_publicevents
// Params 0
// Checksum 0x96ae0f0d, Offset: 0xa9a
// Size: 0x82
function function_ba5a796958d4925a()
{
    cancelupcomingpublicevents();
    
    foreach ( eventtype, eventdata in level.br_pe_data )
    {
        function_a1af4e372c2ecc3( eventtype );
    }
}

// Namespace br_publicevents
// Params 0
// Checksum 0xac407873, Offset: 0xb24
// Size: 0x18
function cancelupcomingpublicevents()
{
    level notify( #"cancel_public_event" );
    level.var_cf3042bf3f1ed573 = 0;
}

// Namespace br_publicevents
// Params 0
// Checksum 0x746db1d1, Offset: 0xb44
// Size: 0x88
function publiceventsenabled()
{
    if ( !level.br_pe_enabled )
    {
        return 0;
    }
    
    forceeventtype = getdvar( @"hash_c164d00b9c54b5b8", "" );
    
    if ( forceeventtype != "" )
    {
        return 1;
    }
    
    if ( function_925770b6e1a406f7() )
    {
        return function_3b64f205ed1ae384();
    }
    
    eventcount = getpubliceventcount();
    
    if ( !eventcount )
    {
        return 0;
    }
    
    eventchance = getpubliceventchance();
    
    if ( eventchance <= 0 )
    {
        return 0;
    }
    
    return 1;
}

// Namespace br_publicevents
// Params 2
// Checksum 0x9c0dd9e1, Offset: 0xbd4
// Size: 0xb2, Type: bool
function shoulddopublicevent( currentcircle, var_4991a0a860520390 )
{
    eventchance = getpubliceventchance();
    
    if ( function_925770b6e1a406f7() )
    {
        if ( var_4991a0a860520390 )
        {
            eventchance = level.var_740e6a1633340d77;
        }
        else if ( isdefined( currentcircle ) )
        {
            if ( isdefined( level.var_468043fac43b5981[ currentcircle ] ) )
            {
                eventchance = level.var_468043fac43b5981[ currentcircle ];
            }
            else
            {
                /#
                    if ( function_e5783afe603c8f2b() )
                    {
                        function_49a141b589d5b344( "<dev string:xd8>" + currentcircle );
                    }
                    else
                    {
                        function_49a141b589d5b344( "<dev string:x12c>" + currentcircle );
                    }
                #/
                
                return false;
            }
        }
    }
    
    if ( eventchance <= 0 )
    {
        return false;
    }
    
    return randomfloat( 1 ) <= eventchance;
}

// Namespace br_publicevents
// Params 0
// Checksum 0xabdc6005, Offset: 0xc8f
// Size: 0xd, Type: bool
function function_c0107b0309333b0d()
{
    return level.var_cf3042bf3f1ed573 > 0;
}

// Namespace br_publicevents
// Params 0
// Checksum 0x4f15a063, Offset: 0xca5
// Size: 0x11
function getpubliceventcount()
{
    return getdvarint( @"scr_br_pe_count", 1 );
}

// Namespace br_publicevents
// Params 0
// Checksum 0x5469abf9, Offset: 0xcbf
// Size: 0x14
function getpubliceventchance()
{
    return getdvarfloat( @"scr_br_pe_chance", 0 );
}

// Namespace br_publicevents
// Params 0
// Checksum 0x8f076ba7, Offset: 0xcdc
// Size: 0x19, Type: bool
function multiplepubliceventsenabled()
{
    numevents = getpubliceventcount();
    return numevents != 1;
}

// Namespace br_publicevents
// Params 0
// Checksum 0x1069f0e0, Offset: 0xcfe
// Size: 0xad
function publiceventsmanager()
{
    level endon( #"cancel_public_event" );
    flags::gameflagwait( "prematch_done" );
    
    if ( multiplepubliceventsenabled() )
    {
        var_7a01b33a746031c0 = getdvarfloat( @"hash_a02772622b60d034", 240 );
        var_79dec93a743a1a6a = getdvarfloat( @"hash_a04a60622b86f056", 360 );
        
        for ( numevents = getpubliceventcount(); numevents ; numevents-- )
        {
            waittime = randomfloatrange( var_7a01b33a746031c0, var_79dec93a743a1a6a );
            wait waittime;
            
            if ( shoulddopublicevent() )
            {
                choosepubliceventtype( 1 );
            }
        }
        
        return;
    }
    
    if ( shoulddopublicevent() )
    {
        choosepubliceventtype( 0 );
    }
}

// Namespace br_publicevents
// Params 0
// Checksum 0x5622fa02, Offset: 0xdb3
// Size: 0x12a
function validateevents()
{
    validtypes = [];
    
    foreach ( eventtype, eventdata in level.br_pe_data )
    {
        if ( eventdata.weight <= 0 )
        {
            /#
                function_49a141b589d5b344( getxhashsourcename( eventtype ) + "<dev string:x180>" );
            #/
            
            continue;
        }
        
        if ( eventdata.isinvalid )
        {
            /#
                function_49a141b589d5b344( getxhashsourcename( eventtype ) + "<dev string:x1a1>" );
            #/
            
            continue;
        }
        
        if ( isdefined( eventdata.canactivatefunc ) && ![[ eventdata.canactivatefunc ]]() )
        {
            /#
                function_49a141b589d5b344( getxhashsourcename( eventtype ) + "<dev string:x1de>" );
            #/
            
            continue;
        }
        
        /#
            function_49a141b589d5b344( getxhashsourcename( eventtype ) + "<dev string:x213>" );
        #/
        
        validtypes[ validtypes.size ] = eventtype;
    }
    
    return validtypes;
}

// Namespace br_publicevents
// Params 5
// Checksum 0xc2f9b52, Offset: 0xee6
// Size: 0x2f9
function function_3e35c38ef2ede68( eventtypes, currentcircle, var_d2e7a677c8ce883a, var_8b2c031b9f7820df, var_4991a0a860520390 )
{
    shortlist = spawnstruct();
    shortlist.types = [];
    shortlist.weights = [];
    
    if ( !var_4991a0a860520390 && !var_8b2c031b9f7820df )
    {
        foreach ( eventtype in eventtypes )
        {
            eventdata = level.br_pe_data[ eventtype ];
            assert( isdefined( eventdata ) );
            eventweight = eventdata.weight;
            weights = var_d2e7a677c8ce883a ? eventdata.var_6dc02acf6b07a4a7 : eventdata.circleeventweights;
            
            if ( isdefined( currentcircle ) && isdefined( weights ) && isdefined( weights[ currentcircle ] ) )
            {
                eventweight = weights[ currentcircle ];
            }
            
            shortlist.types[ shortlist.types.size ] = eventtype;
            shortlist.weights[ shortlist.weights.size ] = eventweight;
        }
    }
    else if ( var_4991a0a860520390 )
    {
        weights = level.var_9652504dbe90daef.weights;
        
        foreach ( eventtype in eventtypes )
        {
            if ( !isdefined( weights[ eventtype ] ) )
            {
                continue;
            }
            
            shortlist.types[ shortlist.types.size ] = eventtype;
            shortlist.weights[ shortlist.weights.size ] = weights[ eventtype ];
        }
    }
    else
    {
        weights = level.var_7b71dfe065d9a6f2.weights;
        
        foreach ( eventtype in eventtypes )
        {
            if ( !isdefined( weights[ eventtype ] ) )
            {
                continue;
            }
            
            shortlist.types[ shortlist.types.size ] = eventtype;
            shortlist.weights[ shortlist.weights.size ] = weights[ eventtype ];
        }
    }
    
    return shortlist;
}

// Namespace br_publicevents
// Params 5
// Checksum 0xcad8d571, Offset: 0x11e8
// Size: 0xd0
function getweightedsum( eventtypes, currentcircle, var_d2e7a677c8ce883a, var_8b2c031b9f7820df, var_4991a0a860520390 )
{
    shortlist = function_3e35c38ef2ede68( eventtypes, currentcircle, var_d2e7a677c8ce883a, var_8b2c031b9f7820df, var_4991a0a860520390 );
    weightedsum = 0;
    
    foreach ( weight in shortlist.weights )
    {
        weightedsum += weight;
    }
    
    return weightedsum;
}

// Namespace br_publicevents
// Params 6
// Checksum 0xcf8a7fe0, Offset: 0x12c1
// Size: 0xf2
function findeventforchosenweight( eventtypes, chosenweight, currentcircle, var_d2e7a677c8ce883a, var_8b2c031b9f7820df, var_4991a0a860520390 )
{
    shortlist = function_3e35c38ef2ede68( eventtypes, currentcircle, var_d2e7a677c8ce883a, var_8b2c031b9f7820df, var_4991a0a860520390 );
    weightedsum = 0;
    
    foreach ( i, weight in shortlist.weights )
    {
        weightedsum += weight;
        
        if ( chosenweight <= weightedsum )
        {
            return shortlist.types[ i ];
        }
    }
    
    return "";
}

// Namespace br_publicevents
// Params 5
// Checksum 0xe75beed6, Offset: 0x13bc
// Size: 0x1d0
function choosepubliceventtype( skipwait, currentcircle, var_d2e7a677c8ce883a = 0, var_8b2c031b9f7820df, var_4991a0a860520390 )
{
    validtypes = undefined;
    
    if ( function_925770b6e1a406f7() && !var_4991a0a860520390 && !var_8b2c031b9f7820df )
    {
        /#
            function_49a141b589d5b344( "<dev string:x222>" + currentcircle );
        #/
        
        validtypes = function_cd854224794a74a( currentcircle, var_d2e7a677c8ce883a );
    }
    else if ( var_4991a0a860520390 )
    {
        /#
            function_49a141b589d5b344( "<dev string:x240>" );
        #/
        
        validtypes = function_d30b4377c664584a( level.var_9652504dbe90daef );
    }
    else if ( var_8b2c031b9f7820df )
    {
        /#
            function_49a141b589d5b344( "<dev string:x266>" );
        #/
        
        validtypes = function_d30b4377c664584a( level.var_7b71dfe065d9a6f2 );
    }
    else
    {
        validtypes = validateevents();
    }
    
    if ( function_925770b6e1a406f7() )
    {
        assert( validtypes.size != 0, "<dev string:x283>" );
    }
    
    weightedsum = getweightedsum( validtypes, currentcircle, var_d2e7a677c8ce883a, var_8b2c031b9f7820df, var_4991a0a860520390 );
    randchoice = randomfloat( weightedsum );
    eventtype = findeventforchosenweight( validtypes, randchoice, currentcircle, var_d2e7a677c8ce883a, var_8b2c031b9f7820df, var_4991a0a860520390 );
    
    /#
        function_49a141b589d5b344( "<dev string:x2d1>" + getxhashsourcename( eventtype ) );
    #/
    
    forceeventtype = getdvar( @"hash_c164d00b9c54b5b8", "" );
    
    if ( forceeventtype != "" )
    {
        /#
            function_49a141b589d5b344( "<dev string:x2e2>" + getxhashsourcename( forceeventtype ) );
        #/
        
        eventtype = getxhashasset( forceeventtype );
    }
    
    if ( isdefined( currentcircle ) )
    {
        /#
            circleindex = currentcircle ?? "<dev string:x303>";
            println( "<dev string:x30b>" + circleindex + "<dev string:x322>" + getxhashsourcename( eventtype ) );
        #/
    }
    
    level runpubliceventoftype( eventtype, skipwait, currentcircle, var_d2e7a677c8ce883a, var_8b2c031b9f7820df, var_4991a0a860520390 );
}

// Namespace br_publicevents
// Params 1
// Checksum 0x8019770, Offset: 0x1594
// Size: 0x70
function activateevent( eventdata )
{
    level endon( #"game_ended" );
    level endon( #"cancel_public_event" );
    level notify( #"br_pe_start" );
    
    if ( isdefined( eventdata.activatefunc ) )
    {
        eventdata [[ eventdata.activatefunc ]]();
    }
    
    level.var_cf3042bf3f1ed573 -= 1;
    level notify( #"br_pe_end" );
}

// Namespace br_publicevents
// Params 1
// Checksum 0x8395d769, Offset: 0x160c
// Size: 0x84
function function_35f8c70d3c2a0c42( currenttimeinterval )
{
    if ( isdefined( currenttimeinterval ) && isdefined( level.var_41740947a9e0ecd0[ currenttimeinterval + 1 ] ) )
    {
        if ( isdefined( level.var_41740947a9e0ecd0[ currenttimeinterval ] ) )
        {
            timetowait = level.var_41740947a9e0ecd0[ currenttimeinterval + 1 ] - level.var_41740947a9e0ecd0[ currenttimeinterval ];
            
            if ( timetowait < 0 )
            {
                /#
                    function_49a141b589d5b344( "<dev string:x325>" + currenttimeinterval + "<dev string:x337>" );
                #/
                
                return -1;
            }
            
            return timetowait;
        }
    }
    
    return -1;
}

// Namespace br_publicevents
// Params 6
// Checksum 0x88e8758c, Offset: 0x1699
// Size: 0x336
function runpubliceventoftype( eventtype, skipwait, currentcircle, var_d2e7a677c8ce883a, var_8b2c031b9f7820df, var_4991a0a860520390 )
{
    level endon( #"game_ended" );
    level endon( #"cancel_public_event" );
    assert( eventtype == "<dev string:x361>" || isxhashasset( eventtype ), "<dev string:x362>" );
    
    if ( eventtype == "" && !function_925770b6e1a406f7() )
    {
        /#
            function_49a141b589d5b344( "<dev string:x3a1>" );
        #/
        
        return;
    }
    
    eventdata = level.br_pe_data[ eventtype ];
    assert( isdefined( eventdata ) );
    
    if ( isdefined( eventdata.waitfunc ) && !skipwait )
    {
        eventdata [[ eventdata.waitfunc ]]();
    }
    
    if ( getdvarint( @"hash_a1b1b3ba057f4935", 1 ) > 0 )
    {
        while ( function_c0107b0309333b0d() )
        {
            level utility::waittill_any( "br_pe_end", "cancel_public_event" );
            waitframe();
        }
    }
    
    level.var_cf3042bf3f1ed573 += 1;
    var_57ce8d2715ed3c74 = getxhashhexname( eventtype );
    eventdata.active = 1;
    br_analytics::branalytics_publiceventstarted( eventtype );
    utility::callsharedfunc( #"gametype", #"onpublicevent", var_57ce8d2715ed3c74, "start" );
    
    if ( function_925770b6e1a406f7() && !var_4991a0a860520390 )
    {
        level.var_145664258ebb6728 = 1;
        
        /#
            function_49a141b589d5b344( "<dev string:x3c2>" + getxhashsourcename( eventtype ) );
        #/
        
        level thread activateevent( eventdata );
        
        if ( !var_d2e7a677c8ce883a )
        {
            if ( !isdefined( level.var_e9d6b5d6fc8c12f0 ) )
            {
                level.var_e9d6b5d6fc8c12f0 = [];
            }
            
            if ( !isdefined( level.var_e9d6b5d6fc8c12f0[ eventtype ] ) )
            {
                level.var_e9d6b5d6fc8c12f0[ eventtype ] = 0;
            }
            
            level.var_e9d6b5d6fc8c12f0[ eventtype ]++;
            
            if ( isdefined( currentcircle ) )
            {
                level.var_ca6eda4bfb5635fa[ eventtype ] = currentcircle;
            }
        }
        
        if ( !var_8b2c031b9f7820df )
        {
            if ( function_e5783afe603c8f2b() )
            {
                waittime = function_35f8c70d3c2a0c42( currentcircle );
                
                if ( waittime >= 0 )
                {
                    wait waittime;
                }
                else
                {
                    flags::gameflagwait( "overtime_started" );
                    level.var_71b2c81f06e046d3 = 1;
                }
            }
            else
            {
                level waittill( #"br_circle_set" );
            }
            
            function_a1af4e372c2ecc3( eventtype );
            level notify( #"hash_e5d092842f93cb47" );
        }
        
        return;
    }
    
    if ( var_4991a0a860520390 )
    {
        level.var_9404097602f37b4c = eventtype;
        oldactivecount = level.var_cf3042bf3f1ed573;
        
        /#
            function_49a141b589d5b344( "<dev string:x3c2>" + getxhashsourcename( eventtype ) );
        #/
        
        level thread activateevent( eventdata );
        
        if ( oldactivecount == level.var_cf3042bf3f1ed573 )
        {
            assertmsg( "<dev string:x3d5>" + getxhashsourcename( eventtype ) + "<dev string:x3e6>" );
        }
        
        function_a1af4e372c2ecc3( eventtype );
        return;
    }
    
    level activateevent( eventdata );
    
    if ( eventdata.active )
    {
        utility::callsharedfunc( #"gametype", #"onpublicevent", var_57ce8d2715ed3c74, "end" );
    }
    
    eventdata.active = 0;
    br_analytics::branalytics_publiceventended( eventtype );
}

// Namespace br_publicevents
// Params 1
// Checksum 0x794a5ac2, Offset: 0x19d7
// Size: 0x94
function function_a1af4e372c2ecc3( eventtype )
{
    if ( ispubliceventoftypeactive( eventtype ) )
    {
        var_57ce8d2715ed3c74 = getxhashhexname( eventtype );
        eventdata = level.br_pe_data[ eventtype ];
        
        if ( isdefined( eventdata.deactivatefunc ) )
        {
            eventdata [[ eventdata.deactivatefunc ]]();
        }
        
        utility::callsharedfunc( #"gametype", #"onpublicevent", var_57ce8d2715ed3c74, "end" );
        eventdata.active = 0;
        br_analytics::branalytics_publiceventended( eventtype );
    }
}

// Namespace br_publicevents
// Params 1
// Checksum 0xcbbc3710, Offset: 0x1a73
// Size: 0x57, Type: bool
function ispubliceventoftypeactive( eventtype )
{
    if ( !level.br_pe_enabled || !isdefined( level.br_pe_data ) )
    {
        return false;
    }
    
    eventdata = level.br_pe_data[ eventtype ];
    
    if ( !isdefined( eventdata ) )
    {
        return false;
    }
    
    return istrue( eventdata.active );
}

// Namespace br_publicevents
// Params 3
// Checksum 0xb49f94c0, Offset: 0x1ad3
// Size: 0xa8
function showsplashtoall( splashname, splashlistoverride, options )
{
    foreach ( player in level.players )
    {
        player hud_message::showsplash( splashname, options.optionalnumber, undefined, undefined, undefined, splashlistoverride );
    }
}

// Namespace br_publicevents
// Params 1
// Checksum 0xb996471a, Offset: 0x1b83
// Size: 0x2c
function function_ada8caf396d3a59d( waittime )
{
    level endon( #"game_ended" );
    
    if ( isdefined( waittime ) )
    {
        wait waittime;
    }
    
    setomnvar( "ui_minimap_pulse", 0 );
}

/#

    // Namespace br_publicevents
    // Params 1
    // Checksum 0xf233e8bf, Offset: 0x1bb7
    // Size: 0xfa, Type: dev
    function function_3cacd19bcd0bc75b( eventtype )
    {
        self notify( #"hash_e55fb1bb04801843" );
        self endon( #"hash_e55fb1bb04801843" );
        level.var_cf3042bf3f1ed573 = 0;
        hashedreference = getxhashasset( eventtype );
        
        if ( !isdefined( level.br_pe_data[ hashedreference ] ) )
        {
            var_c61ac37da174e60a = spawnstruct();
            [[ level.var_aa0ee7c65411867d[ hashedreference ] ]]( var_c61ac37da174e60a );
            registerpublicevent( hashedreference, var_c61ac37da174e60a );
        }
        
        if ( !level.br_pe_data[ hashedreference ].var_ff10bc75a7f4c276 )
        {
            if ( isdefined( level.br_pe_data[ hashedreference ].postinitfunc ) )
            {
                level.br_pe_data[ hashedreference ] [[ level.br_pe_data[ hashedreference ].postinitfunc ]]();
            }
            
            level.br_pe_data[ hashedreference ].var_ff10bc75a7f4c276 = 1;
        }
        
        level runpubliceventoftype( hashedreference, 1 );
    }

#/

// Namespace br_publicevents
// Params 2
// Checksum 0xee4f3fc1, Offset: 0x1cb9
// Size: 0x3b
function handledevcommand_publicevents( command, args )
{
    /#
        switch ( command )
        {
            case #"hash_94b933c8d88ea90f":
                thread function_3cacd19bcd0bc75b( args[ 0 ] );
                break;
        }
    #/
}

// Namespace br_publicevents
// Params 0
// Checksum 0x39eaa683, Offset: 0x1cfc
// Size: 0xc, Type: bool
function function_925770b6e1a406f7()
{
    return istrue( level.var_26ceb2fe24492935 );
}

// Namespace br_publicevents
// Params 0
// Checksum 0xb86c2367, Offset: 0x1d11
// Size: 0xc, Type: bool
function function_e5783afe603c8f2b()
{
    return istrue( level.var_e08c76fe0142bf9e );
}

// Namespace br_publicevents
// Params 0
// Checksum 0xd37e5484, Offset: 0x1d26
// Size: 0x29
function function_9b2475065b8664d()
{
    level endon( #"game_ended" );
    level waittill( #"bmo_overtime_start" );
    level thread choosepubliceventtype( 1, undefined, 0, 1 );
}

// Namespace br_publicevents
// Params 0
// Checksum 0x81512ffa, Offset: 0x1d57
// Size: 0xf3
function function_3b64f205ed1ae384()
{
    if ( br_gametypes::isfeatureenabled( #"hash_7bf340059947e149" ) )
    {
        flags::function_2f3408423ccc9b2e( "customGametypeCirclesInit" );
    }
    
    if ( level.var_740e6a1633340d77 > 0 )
    {
        return 1;
    }
    
    var_b42e0aaf6d28b394 = getdvarint( @"hash_f6d47ba2ae075d35", level.br_level.br_circleradii.size - 1 );
    
    if ( var_b42e0aaf6d28b394 <= 0 )
    {
        return 0;
    }
    
    var_a5764b208f9a65cd = 0;
    
    foreach ( chance in level.var_468043fac43b5981 )
    {
        if ( chance > 0 )
        {
            var_a5764b208f9a65cd = 1;
            break;
        }
    }
    
    return var_a5764b208f9a65cd;
}

// Namespace br_publicevents
// Params 0
// Checksum 0x70bc43cb, Offset: 0x1e53
// Size: 0x1e6
function function_71ff50ded8bbd326()
{
    level endon( #"cancel_public_event" );
    level endon( #"game_ended" );
    
    if ( shoulddopublicevent( undefined, 1 ) )
    {
        level choosepubliceventtype( 1, undefined, undefined, 0, 1 );
    }
    
    flags::gameflagwait( "prematch_done" );
    level.var_e9d6b5d6fc8c12f0 = [];
    level.var_ca6eda4bfb5635fa = [];
    var_1af098c95a3e834e = 0;
    var_5e7d0027e1c6069d = 0;
    
    if ( !function_e5783afe603c8f2b() )
    {
        var_5e7d0027e1c6069d = level.br_level.br_circleradii.size - 1;
    }
    else
    {
        var_eb46e5e1fa0031d = level.var_41740947a9e0ecd0.size;
        var_5e7d0027e1c6069d = var_eb46e5e1fa0031d;
    }
    
    while ( var_1af098c95a3e834e < var_5e7d0027e1c6069d )
    {
        if ( var_1af098c95a3e834e == 0 )
        {
            if ( !function_e5783afe603c8f2b() )
            {
                level waittill( #"br_circle_set" );
            }
            else
            {
                level thread function_9b2475065b8664d();
                wait level.var_41740947a9e0ecd0[ 0 ];
            }
            
            wait level.var_51259c14b4430a60;
        }
        else
        {
            if ( level.var_145664258ebb6728 || function_e5783afe603c8f2b() )
            {
                level waittill( #"hash_e5d092842f93cb47" );
            }
            else
            {
                level waittill( #"br_circle_set" );
            }
            
            wait level.var_79a6713373eda9c1;
        }
        
        if ( level.var_dd4a28dda4db0752 == 0 )
        {
            skipwait = 0;
        }
        else
        {
            skipwait = 1;
        }
        
        currentcircle = var_1af098c95a3e834e;
        
        if ( !function_e5783afe603c8f2b() )
        {
            currentcircle = level.br_circle.circleindex;
        }
        
        if ( level.var_71b2c81f06e046d3 )
        {
            level thread choosepubliceventtype( 1, currentcircle, 0, 1 );
        }
        else if ( shoulddopublicevent( currentcircle ) )
        {
            level thread choosepubliceventtype( skipwait, currentcircle, 0 );
        }
        else
        {
            println( "<dev string:x30b>" + currentcircle + "<dev string:x418>" );
            level notify( #"br_pe_no_event" );
            level.var_145664258ebb6728 = 0;
        }
        
        var_1af098c95a3e834e++;
    }
}

// Namespace br_publicevents
// Params 2
// Checksum 0xd01f4b51, Offset: 0x2041
// Size: 0x28e
function function_cd854224794a74a( currentcircle, var_d2e7a677c8ce883a )
{
    validtypes = [];
    
    foreach ( eventtype, eventdata in level.br_pe_data )
    {
        if ( eventdata.weight <= 0 )
        {
            /#
                function_49a141b589d5b344( getxhashsourcename( eventtype ) + "<dev string:x180>" );
            #/
            
            continue;
        }
        
        if ( eventdata.isinvalid )
        {
            /#
                function_49a141b589d5b344( getxhashsourcename( eventtype ) + "<dev string:x1a1>" );
            #/
            
            continue;
        }
        
        if ( isdefined( eventdata.canactivatefunc ) && ![[ eventdata.canactivatefunc ]]() )
        {
            /#
                function_49a141b589d5b344( getxhashsourcename( eventtype ) + "<dev string:x1de>" );
            #/
            
            continue;
        }
        
        weights = var_d2e7a677c8ce883a ? eventdata.var_6dc02acf6b07a4a7 : eventdata.circleeventweights;
        
        if ( isdefined( weights ) )
        {
            if ( weights[ currentcircle ] <= 0 )
            {
                /#
                    function_49a141b589d5b344( getxhashsourcename( eventtype ) + "<dev string:x180>" );
                #/
                
                continue;
            }
            else if ( !isdefined( weights[ currentcircle ] ) )
            {
                /#
                    function_49a141b589d5b344( getxhashsourcename( eventtype ) + "<dev string:x41f>" + currentcircle );
                #/
                
                continue;
            }
        }
        
        if ( !var_d2e7a677c8ce883a )
        {
            if ( isdefined( level.var_e9d6b5d6fc8c12f0 ) && isdefined( level.var_e9d6b5d6fc8c12f0[ eventtype ] ) )
            {
                if ( level.var_e9d6b5d6fc8c12f0[ eventtype ] >= eventdata.maxtimes )
                {
                    /#
                        function_49a141b589d5b344( getxhashsourcename( eventtype ) + "<dev string:x45e>" );
                    #/
                    
                    continue;
                }
            }
            
            if ( isdefined( level.var_ca6eda4bfb5635fa ) && isdefined( level.var_ca6eda4bfb5635fa[ eventtype ] ) )
            {
                var_fecb624fd3b8d0db = currentcircle - level.var_ca6eda4bfb5635fa[ eventtype ];
                
                if ( var_fecb624fd3b8d0db >= level.var_2dd23ec206fdf50a + 1 )
                {
                    level.var_ca6eda4bfb5635fa[ eventtype ] = undefined;
                }
                else
                {
                    /#
                        function_49a141b589d5b344( getxhashsourcename( eventtype ) + "<dev string:x493>" );
                    #/
                    
                    continue;
                }
            }
        }
        
        /#
            function_49a141b589d5b344( getxhashsourcename( eventtype ) + "<dev string:x213>" );
        #/
        
        validtypes[ validtypes.size ] = eventtype;
    }
    
    if ( validtypes.size == 0 )
    {
        validtypes[ validtypes.size ] = "";
    }
    
    return validtypes;
}

/#

    // Namespace br_publicevents
    // Params 1
    // Checksum 0xc381e8a9, Offset: 0x22d8
    // Size: 0x30, Type: dev
    function function_49a141b589d5b344( message )
    {
        if ( getdvarint( @"hash_909fa2d0703b8e6b", 0 ) == 1 )
        {
            logstring( "<dev string:x4f8>" + message );
        }
    }

#/

// Namespace br_publicevents
// Params 1
// Checksum 0x9002a17a, Offset: 0x2310
// Size: 0x98, Type: bool
function function_45b6054ec3f6ce04( eventdata )
{
    if ( isdefined( eventdata.var_6dc02acf6b07a4a7 ) )
    {
        foreach ( weight in eventdata.var_6dc02acf6b07a4a7 )
        {
            if ( weight > 0 )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace br_publicevents
// Params 0
// Checksum 0xda56dd2, Offset: 0x23b1
// Size: 0x139
function function_7963b081587bb05d()
{
    dvarval = getdvar( @"scr_br_publiceventlist", "" );
    
    if ( dvarval != "" )
    {
        pe_list = getscriptbundle( hashcat( %"publiceventlist:", dvarval ) ) ?? getscriptbundle( hashcat( %"activitynexuspubliceventlist:", dvarval ) );
        var_7237854e3be197ca = pe_list;
        
        if ( isdefined( var_7237854e3be197ca ) )
        {
            return var_7237854e3be197ca;
        }
    }
    
    if ( isdefined( level.gametypebundle.var_dbc45e0dbdf23a01 ) && level.gametypebundle.var_dbc45e0dbdf23a01 != "" )
    {
        pe_list = getscriptbundle( level.gametypebundle.var_dbc45e0dbdf23a01 );
        var_7237854e3be197ca = pe_list;
        
        if ( isdefined( var_7237854e3be197ca ) )
        {
            return var_7237854e3be197ca;
        }
    }
    
    if ( !isdefined( pe_list ) )
    {
        pe_list = getscriptbundle( "publiceventlist:" + "wz_publiceventlist_none" ) ?? getscriptbundle( "activitynexuspubliceventlist:" + "wz_publiceventlist_none" );
        var_7237854e3be197ca = pe_list;
        
        if ( isdefined( var_7237854e3be197ca ) )
        {
            return var_7237854e3be197ca;
        }
    }
    
    if ( !isdefined( pe_list ) )
    {
        script::demoforcesre( "Public event list \"" + pe_list + "\" not found. Make sure it's included in feature target" );
        return;
    }
    
    /#
        function_49a141b589d5b344( "<dev string:x4fd>" + pe_list + "<dev string:x51a>" );
    #/
}

// Namespace br_publicevents
// Params 1
// Checksum 0x2097d1cb, Offset: 0x24f2
// Size: 0x181, Type: bool
function function_e8846b0fa06e4b93( event )
{
    publiceventlistbundle = function_7963b081587bb05d();
    
    if ( !isdefined( publiceventlistbundle ) )
    {
        return false;
    }
    
    if ( getdvarint( @"hash_4558abf9d259b284", 0 ) == 1 )
    {
        return true;
    }
    
    publiceventconfig = undefined;
    
    foreach ( config in publiceventlistbundle.var_f5d19c2b31830f8c )
    {
        if ( config.event == event )
        {
            publiceventconfig = config;
            break;
        }
    }
    
    if ( !isdefined( event ) )
    {
        return false;
    }
    
    if ( !( publiceventconfig.maxtimes > 0 ) )
    {
        return false;
    }
    
    weights = strtok( publiceventconfig.circleweights, " " );
    
    foreach ( weight in weights )
    {
        if ( float( weight ) > 0 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_publicevents
// Params 2
// Checksum 0x42be65a0, Offset: 0x267c
// Size: 0x39
function function_54d95495df246a2b( reference, callback )
{
    if ( !isdefined( level.var_aa0ee7c65411867d ) )
    {
        level.var_aa0ee7c65411867d = [];
    }
    
    level.var_aa0ee7c65411867d[ reference ] = callback;
}

// Namespace br_publicevents
// Params 2
// Checksum 0x8e75b42b, Offset: 0x26bd
// Size: 0x18a
function publiceventinit( eventinfo, var_b20cad623fd9d986 )
{
    reference = function_d15b54469ad16c93( eventinfo.event );
    hashedreference = getxhashasset( reference );
    infokey = function_a27dd7013e673e94( eventinfo.event );
    var_ab16d0f8ec614cde = getxhashasset( infokey );
    
    if ( !isdefined( level.var_aa0ee7c65411867d[ hashedreference ] ) )
    {
        /#
            function_49a141b589d5b344( "<dev string:x74>" + reference + "<dev string:x51c>" );
        #/
        
        return;
    }
    
    var_e71479b6df47cbe4 = hashcat( @"hash_ad3fe107b8245cbc", infokey );
    
    if ( getdvarint( var_e71479b6df47cbe4, 0 ) == 1 )
    {
        /#
            function_49a141b589d5b344( "<dev string:x545>" + infokey );
        #/
        
        return;
    }
    
    /#
        function_49a141b589d5b344( "<dev string:x56d>" + infokey );
    #/
    
    if ( var_b20cad623fd9d986 )
    {
        eventinfo.activatefunc = &function_aa3653128a468972;
        eventinfo.deactivatefunc = &function_2af00d583c312c1c;
        activity_definition_utils::function_74af1ab4059e3c06( eventinfo.event, eventinfo.event );
    }
    
    [[ level.var_aa0ee7c65411867d[ hashedreference ] ]]( eventinfo );
    
    if ( isdefined( eventinfo.circleweights ) )
    {
        eventinfo.circleeventweights = function_e7fff3950cd3b406( eventinfo.circleweights );
        eventinfo.var_6dc02acf6b07a4a7 = br_publicevents_meter::function_8ef0c602af29d92c( infokey );
        function_1f6672db105a0720( eventinfo, infokey );
    }
    
    registerpublicevent( var_ab16d0f8ec614cde, eventinfo );
}

// Namespace br_publicevents
// Params 0
// Checksum 0x784dd84b, Offset: 0x284f
// Size: 0x12
function function_aa3653128a468972()
{
    activity_instance_common::function_9b387cb1af0d5b4b( self.event );
}

// Namespace br_publicevents
// Params 0
// Checksum 0x5b01616b, Offset: 0x2869
// Size: 0xb9
function function_2af00d583c312c1c()
{
    foreach ( activity in activity_common::function_394486cf35d84dc8() )
    {
        if ( activity.varianttag == self.event )
        {
            if ( activity_instance_common::getactivitystate( activity ) == "Active" )
            {
                activitysuccess = 0;
                activity_instance_common::endactivity( activity, activitysuccess );
                continue;
            }
            
            activity_instance_common::function_9aeeabe50fc9cc3e( activity );
        }
    }
}

// Namespace br_publicevents
// Params 2
// Checksum 0xc12b31a7, Offset: 0x292a
// Size: 0x138
function function_ff66cb5b79ca6483( bundlelist, debuglabel = "" )
{
    specialevents = spawnstruct();
    specialevents.types = [];
    specialevents.weights = [];
    
    /#
        specialevents.debuglabel = debuglabel;
    #/
    
    foreach ( specialevent in bundlelist )
    {
        if ( !isdefined( specialevent.event ) )
        {
            continue;
        }
        
        reference = function_a27dd7013e673e94( specialevent.event );
        hashedreference = getxhashasset( reference );
        specialevents.types[ specialevents.types.size ] = hashedreference;
        specialevents.weights[ hashedreference ] = specialevent.weight;
    }
    
    return specialevents;
}

// Namespace br_publicevents
// Params 1
// Checksum 0x32a98511, Offset: 0x2a6b
// Size: 0x1bf
function function_d30b4377c664584a( specialeventlist )
{
    validtypes = [];
    
    foreach ( eventtype in specialeventlist.types )
    {
        if ( specialeventlist.weights[ eventtype ] <= 0 )
        {
            /#
                function_49a141b589d5b344( getxhashsourcename( eventtype ) + "<dev string:x180>" );
            #/
            
            continue;
        }
        
        if ( !isdefined( level.br_pe_data[ eventtype ] ) )
        {
            /#
                var_58aa535a4699a453 = specialeventlist.debuglabel ?? "<dev string:x361>";
                script::demoforcesre( "<dev string:x5a4>" + getxhashsourcename( eventtype ) + "<dev string:x5ae>" + var_58aa535a4699a453 + "<dev string:x5b8>" );
            #/
            
            continue;
        }
        
        if ( level.br_pe_data[ eventtype ].isinvalid )
        {
            /#
                function_49a141b589d5b344( getxhashsourcename( eventtype ) + "<dev string:x1a1>" );
            #/
            
            continue;
        }
        
        if ( isdefined( level.br_pe_data[ eventtype ].canactivatefunc ) && ![[ level.br_pe_data[ eventtype ].canactivatefunc ]]() )
        {
            /#
                function_49a141b589d5b344( getxhashsourcename( eventtype ) + "<dev string:x1de>" );
            #/
            
            continue;
        }
        
        /#
            function_49a141b589d5b344( getxhashsourcename( eventtype ) + "<dev string:x213>" );
        #/
        
        validtypes[ validtypes.size ] = eventtype;
    }
    
    if ( validtypes.size == 0 )
    {
        validtypes[ validtypes.size ] = "";
    }
    
    return validtypes;
}

// Namespace br_publicevents
// Params 2
// Checksum 0xe19656bc, Offset: 0x2c33
// Size: 0x129
function function_1f6672db105a0720( eventinfo, eventname )
{
    dvarbase = hashcat( @"hash_abb46656d4b7e51c", eventname, "_" );
    eventinfo.weight = getdvarfloat( hashcat( dvarbase, "weight" ), eventinfo.weight );
    eventinfo.maxtimes = getdvarint( hashcat( dvarbase, "max_times" ), eventinfo.maxtimes );
    circleweights = getdvar( hashcat( dvarbase, "circle_weights" ), "" );
    
    if ( circleweights != "" )
    {
        eventinfo.circleeventweights = function_e7fff3950cd3b406( circleweights );
    }
    
    if ( isdefined( level.var_9652504dbe90daef ) )
    {
        hashedname = getxhashasset( eventname );
        var_85f073c4eca7c3d0 = level.var_9652504dbe90daef.weights[ hashedname ];
        
        if ( isdefined( var_85f073c4eca7c3d0 ) )
        {
            level.var_9652504dbe90daef.weights[ hashedname ] = getdvarfloat( hashcat( dvarbase, "matchwide_weight" ), var_85f073c4eca7c3d0 );
        }
    }
}

// Namespace br_publicevents
// Params 1, eflags: 0x4
// Checksum 0x6b20625f, Offset: 0x2d64
// Size: 0x8e
function private function_d15b54469ad16c93( eventasset )
{
    var_251f8c4c5bdff133 = function_7963b081587bb05d().var_251f8c4c5bdff133;
    eventbundle = var_251f8c4c5bdff133 ? getscriptbundle( "activitydefinition:" + eventasset ) : getscriptbundle( "publicevent:" + eventasset );
    
    if ( !isdefined( eventbundle ) )
    {
        script::demoforcesre( "Could not find publicevent asset: " + eventasset );
        return;
    }
    
    return var_251f8c4c5bdff133 ? activity_definition_utils::function_9129cd8075c85c09( eventbundle ).activitytype : eventbundle.ref;
}

// Namespace br_publicevents
// Params 1, eflags: 0x4
// Checksum 0x92ba6980, Offset: 0x2dfb
// Size: 0x68
function private function_a27dd7013e673e94( eventasset )
{
    var_251f8c4c5bdff133 = function_7963b081587bb05d().var_251f8c4c5bdff133;
    
    if ( var_251f8c4c5bdff133 )
    {
        return eventasset;
    }
    
    eventbundle = getscriptbundle( "publicevent:" + eventasset );
    
    if ( !isdefined( eventbundle ) )
    {
        script::demoforcesre( "Could not find publicevent asset: " + eventasset );
        return;
    }
    
    return eventbundle.ref;
}

