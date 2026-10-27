// scripts\mp\common\utility\musicbank_utility.gsc  (hash_7c5632db7555b4f5.gscc) (size: 9900 Bytes / 0x26ac / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xded47a14 (3738466836)
// size ...... 9900 (0x26ac)
// includes .. 3   (offset: 0x2550)
// strings ... 13  (offset: 0x2568)
// dev strs .. 2   (offset: 0x2694)
// exports ... 35  (offset: 0x19ec)
// cseg ...... 0x11f + 0x18cd (0x19ec)
// imports ... 47  (offset: 0x1f64)
// animtree1 . 0   (offset: 0x26ac)
// animtree2 . 0   (offset: 0x26ac)
#using scripts\common\utility;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\teams;

#namespace musicbank_utility;

// Namespace musicbank_utility
// Params 0
// Checksum 0xfd06775a, Offset: 0x13d
// Size: 0x2a7
function init_musicbanks()
{
    if ( !( isdefined( level.gamemodebundle ) && isdefined( level.gametypebundle ) ) )
    {
        return;
    }
    
    if ( isdefined( level.gamemodebundle.musicbankdefault ) )
    {
        musicbank_load( level.gamemodebundle.musicbankdefault, #"default" );
    }
    
    mapinfo = getactivemapinfobundle();
    var_5708d08d1d02a6e0 = function_755e4a85f26ab8c0( mapinfo );
    
    if ( isdefined( mapinfo.var_7b2643292d43850b ) && mapinfo.var_7b2643292d43850b != %"" )
    {
        listbundle = getscriptbundle( mapinfo.var_7b2643292d43850b );
        
        foreach ( bundle in listbundle.musicbanklist )
        {
            musicbank_load( bundle.musicbank, undefined, var_5708d08d1d02a6e0 );
        }
    }
    else if ( isdefined( level.gametypebundle.musicbanklist ) )
    {
        listbundle = getscriptbundle( level.gametypebundle.musicbanklist );
        
        foreach ( bundle in listbundle.musicbanklist )
        {
            musicbank_load( bundle.musicbank, undefined, var_5708d08d1d02a6e0 );
        }
    }
    else if ( isdefined( level.gamemodebundle.musicbanklist ) )
    {
        listbundle = getscriptbundle( level.gamemodebundle.musicbanklist );
        
        foreach ( bundle in listbundle.musicbanklist )
        {
            musicbank_load( bundle.musicbank, undefined, var_5708d08d1d02a6e0 );
        }
    }
    
    init_musicbank_params();
}

// Namespace musicbank_utility
// Params 1
// Checksum 0x3fdb19a9, Offset: 0x3ec
// Size: 0x19b
function function_755e4a85f26ab8c0( mapinfo )
{
    var_5708d08d1d02a6e0 = [];
    
    if ( isdefined( mapinfo.var_2cbf900c178e69a8 ) && mapinfo.var_2cbf900c178e69a8 != %"" )
    {
        var_3cda5966d0c1aba1 = getscriptbundle( mapinfo.var_2cbf900c178e69a8 );
        
        foreach ( event in var_3cda5966d0c1aba1.musicevent )
        {
            var_5708d08d1d02a6e0[ var_5708d08d1d02a6e0.size ] = event;
        }
    }
    
    if ( isdefined( level.gametypebundle.var_2cbf900c178e69a8 ) && level.gametypebundle.var_2cbf900c178e69a8 != %"" )
    {
        var_82d32e5b22c5a6c5 = getscriptbundle( level.gametypebundle.var_2cbf900c178e69a8 );
        
        foreach ( event in var_82d32e5b22c5a6c5.musicevent )
        {
            var_5708d08d1d02a6e0[ var_5708d08d1d02a6e0.size ] = event;
        }
    }
    
    return var_5708d08d1d02a6e0;
}

// Namespace musicbank_utility
// Params 3
// Checksum 0xce54ae63, Offset: 0x590
// Size: 0x268
function musicbank_load( str_musicbank, var_3d784ff0eaf38cef, var_5708d08d1d02a6e0 )
{
    bundle = getscriptbundle( str_musicbank );
    
    if ( isdefined( bundle ) )
    {
        statekey = bundle.scriptid;
        
        if ( isdefined( var_3d784ff0eaf38cef ) )
        {
            statekey = var_3d784ff0eaf38cef;
        }
        
        if ( var_5708d08d1d02a6e0.size > 0 )
        {
            if ( isdefined( bundle.var_729199aa7771deeb ) )
            {
                var_74a48bab35cca7b = function_bf569ff9d7d76954( var_5708d08d1d02a6e0 );
                
                foreach ( var_8b471eb8181aa1e9 in var_74a48bab35cca7b )
                {
                    bundle.var_729199aa7771deeb[ var_8b471eb8181aa1e9.eventid ] = var_8b471eb8181aa1e9;
                }
            }
            else if ( isdefined( bundle.musicevent ) )
            {
                foreach ( event in var_5708d08d1d02a6e0 )
                {
                    bundle.musicevent[ bundle.musicevent.size ] = event;
                }
            }
        }
        
        if ( !isdefined( bundle.var_729199aa7771deeb ) || !isarray( bundle.var_729199aa7771deeb ) )
        {
            bundle.var_729199aa7771deeb = function_bf569ff9d7d76954( bundle.musicevent );
        }
        
        if ( isarray( bundle.var_729199aa7771deeb ) )
        {
            bundle.musicevent = undefined;
            
            foreach ( event in bundle.var_729199aa7771deeb )
            {
            }
        }
        
        audio_utility::function_23f0ab01b3a03ad1( "musicbank_bundles", statekey, bundle );
    }
}

// Namespace musicbank_utility
// Params 1
// Checksum 0x4fbb7d74, Offset: 0x800
// Size: 0xec
function function_bf569ff9d7d76954( var_dcc09b136378b561 )
{
    dict = undefined;
    
    if ( isarray( var_dcc09b136378b561 ) )
    {
        dict = [];
        
        foreach ( event in var_dcc09b136378b561 )
        {
            isvalidevent = isstruct( event ) && ( isstring( event.eventid ) || isxhash( event.eventid ) ) && isarray( event.musicstates );
            
            if ( isvalidevent )
            {
                dict[ event.eventid ] = event;
            }
        }
    }
    
    return dict;
}

// Namespace musicbank_utility
// Params 0
// Checksum 0xaa7ccf68, Offset: 0x8f5
// Size: 0x37
function init_musicbank_params()
{
    data = spawnstruct();
    data.music_disabled_globally = 0;
    data.disabled_events = [];
    level.var_122f0ec859569086 = data;
}

// Namespace musicbank_utility
// Params 0
// Checksum 0x31bbf4ac, Offset: 0x934
// Size: 0xde
function function_c5abc550e9f75f30()
{
    if ( !( isdefined( level.gamemodebundle ) && isdefined( level.gametypebundle ) ) )
    {
        return;
    }
    
    if ( !isdefined( game[ "musicbank_bundles" ] ) )
    {
        return;
    }
    
    function_a778b84b8e815f44();
    playbacktype = undefined;
    
    if ( level.gametypebundle.var_dfd5c868e0b0aa7e != #"no_override" )
    {
        playbacktype = level.gametypebundle.var_dfd5c868e0b0aa7e;
    }
    else
    {
        playbacktype = level.gamemodebundle.var_dfd5c868e0b0aa7e;
    }
    
    if ( isdefined( playbacktype ) )
    {
        switch ( playbacktype )
        {
            case #"list_order":
                function_3df6f124d6e45d3f();
                break;
            case #"randomize_set":
                function_24ea55c02c02d284();
                break;
            case #"faction_based":
                function_a85d9a3c4b066713();
                break;
        }
    }
}

// Namespace musicbank_utility
// Params 0
// Checksum 0xa0515572, Offset: 0xa1a
// Size: 0x4c
function function_3df6f124d6e45d3f()
{
    temparray = game[ "musicbank_bundles" ];
    temparray = arrayremove( temparray, temparray[ #"default" ] );
    firstbundle = utility::array_get_first_item( temparray );
    function_386364349468bbb3( firstbundle.scriptid );
}

// Namespace musicbank_utility
// Params 0
// Checksum 0xdee19b0f, Offset: 0xa6e
// Size: 0x113
function function_24ea55c02c02d284()
{
    if ( !isdefined( game[ "musicbank_bundles" ][ "global_random_bank" ] ) )
    {
        xhasharray = [];
        
        foreach ( datapoint in game[ "musicbank_bundles" ] )
        {
            if ( isstruct( datapoint ) && isdefined( datapoint.scriptid ) )
            {
                xhasharray[ xhasharray.size ] = datapoint.scriptid;
            }
        }
        
        musicbank = undefined;
        
        if ( xhasharray.size > 1 )
        {
            musicbank = xhasharray[ randomintrange( 1, xhasharray.size ) ];
        }
        
        if ( isdefined( musicbank ) )
        {
            game[ "musicbank_bundles" ][ "global_random_bank" ] = musicbank;
        }
    }
    
    if ( isdefined( game[ "musicbank_bundles" ][ "global_random_bank" ] ) )
    {
        function_386364349468bbb3( game[ "musicbank_bundles" ][ "global_random_bank" ] );
    }
}

// Namespace musicbank_utility
// Params 0
// Checksum 0x5536578d, Offset: 0xb89
// Size: 0x109
function function_a85d9a3c4b066713()
{
    if ( !isdefined( level.gamemodebundle.var_faf239404f56b013 ) )
    {
        return;
    }
    
    alliesfaction = teams::getteamvoiceinfix( "allies" );
    axisfaction = teams::getteamvoiceinfix( "axis" );
    var_748dc39c2072903b = teams::getteamvoiceinfix( "team_three" );
    str_musicbank = undefined;
    
    if ( isdefined( self.team ) )
    {
        switch ( self.team )
        {
            case #"hash_5f54b9bf7583687f":
                str_musicbank = level.gamemodebundle.var_faf239404f56b013 + alliesfaction;
                break;
            case #"hash_7c2d091e6337bf54":
                str_musicbank = level.gamemodebundle.var_faf239404f56b013 + axisfaction;
                break;
            case #"hash_11f9d28d306ceab7":
                str_musicbank = level.gamemodebundle.var_faf239404f56b013 + var_748dc39c2072903b;
                break;
        }
    }
    
    if ( isdefined( str_musicbank ) )
    {
        function_386364349468bbb3( str_musicbank );
    }
}

// Namespace musicbank_utility
// Params 1
// Checksum 0x63b88822, Offset: 0xc9a
// Size: 0x34
function function_386364349468bbb3( str_musicbank )
{
    if ( !isdefined( self.musicbankparams ) )
    {
        self.musicbankparams = [];
    }
    
    self.musicbankparams[ "musicbank" ] = str_musicbank;
}

// Namespace musicbank_utility
// Params 0
// Checksum 0xf2f23420, Offset: 0xcd6
// Size: 0x31
function function_a778b84b8e815f44()
{
    if ( !isdefined( self.musicbankparams ) )
    {
        self.musicbankparams = [];
    }
    
    self.musicbankparams[ "musicbankdefault" ] = #"default";
}

// Namespace musicbank_utility
// Params 1
// Checksum 0xe68b7cf8, Offset: 0xd0f
// Size: 0x86
function function_292d0c5a95501e81( str_musicbank )
{
    foreach ( player in level.players )
    {
        player function_386364349468bbb3( str_musicbank );
    }
}

// Namespace musicbank_utility
// Params 3
// Checksum 0xc5f587a5, Offset: 0xd9d
// Size: 0x10b
function function_5aca66c390aa347d( players, musicevent, trackarray )
{
    if ( is_music_disabled_globally() )
    {
        return;
    }
    
    if ( arraycontains( level.var_122f0ec859569086.disabled_events, musicevent ) )
    {
        return;
    }
    
    if ( !isdefined( players ) )
    {
        return;
    }
    
    if ( isplayer( players ) )
    {
        players = [ players ];
    }
    
    if ( isarray( players ) )
    {
        foreach ( player in players )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( isplayer( player ) && !isagent( player ) )
            {
                level thread function_859093e0ed5edcd6( player, musicevent, trackarray );
            }
        }
        
        return;
    }
    
    assertmsg( "<dev string:x24>" );
}

// Namespace musicbank_utility
// Params 3
// Checksum 0xe803e468, Offset: 0xeb0
// Size: 0x168
function function_859093e0ed5edcd6( player, musicevent, trackarray )
{
    if ( !isdefined( player.musicbankparams ) )
    {
        return;
    }
    
    if ( player.musicbankparams[ "music_disabled" ] )
    {
        return;
    }
    
    active_event = player.musicbankparams[ "activeEvent" ];
    
    if ( active_event == musicevent )
    {
        return;
    }
    
    eventdata = player function_bf29b32d284c6a8d( musicevent );
    
    if ( !isdefined( eventdata ) )
    {
        return;
    }
    
    event_statename = eventdata.statename;
    
    if ( !isdefined( event_statename ) )
    {
        return;
    }
    
    event_bucket = eventdata.eventbucket;
    
    if ( !function_627e5ec9546734df( event_bucket ) )
    {
        return;
    }
    
    event_priority = eventdata.eventpriority;
    
    if ( player function_f30434bb0103e318( event_priority ) )
    {
        return;
    }
    
    if ( player function_bb5615e55107cb71( musicevent ) )
    {
        return;
    }
    
    player notify( #"hash_852ea487435d0dbd" );
    eventstartdelay = eventdata.eventstartdelay;
    event_length = eventdata.eventlength;
    var_14cb719f9b895b63 = eventdata.var_92a6670f8e172ce7;
    player function_3f451ebacf2e4533( musicevent, event_length, event_priority, eventstartdelay );
    player function_7cdaea98282cdab0( musicevent, event_length, var_14cb719f9b895b63, eventstartdelay );
    level thread function_c855af206e3670e3( player, event_statename, trackarray, eventstartdelay );
}

// Namespace musicbank_utility
// Params 4
// Checksum 0xc127d5b, Offset: 0x1020
// Size: 0x7b
function function_c855af206e3670e3( player, event_statename, trackarray, eventstartdelay )
{
    player endon( #"disconnect" );
    player endon( #"hash_852ea487435d0dbd" );
    player endon( #"hash_25bfa197e16df507" );
    
    if ( eventstartdelay > 0 )
    {
        wait eventstartdelay;
    }
    
    if ( isdefined( player ) )
    {
        if ( isarray( trackarray ) )
        {
            player setplayermusicstate( event_statename, trackarray );
            return;
        }
        
        player setplayermusicstate( event_statename );
    }
}

// Namespace musicbank_utility
// Params 2
// Checksum 0xda31aa6f, Offset: 0x10a3
// Size: 0x12c
function function_4f253fd35ec68cbc( players, music_event_id )
{
    if ( isplayer( players ) )
    {
        players = [ players ];
    }
    
    if ( isarray( players ) )
    {
        foreach ( player in players )
        {
            if ( isplayer( player ) && !isagent( player ) )
            {
                active_event = player.musicbankparams[ "activeEvent" ];
                
                if ( isdefined( music_event_id ) )
                {
                    if ( active_event == music_event_id )
                    {
                        player function_fc6bd251f203728e();
                        player setplayermusicstate( "" );
                        player notify( #"hash_25bfa197e16df507" );
                    }
                    
                    continue;
                }
                
                player function_fc6bd251f203728e();
                player setplayermusicstate( "" );
                player notify( #"hash_25bfa197e16df507" );
            }
        }
        
        return;
    }
    
    assertmsg( "<dev string:x50>" );
}

// Namespace musicbank_utility
// Params 4
// Checksum 0x4f81317a, Offset: 0x11d7
// Size: 0x71
function function_3f451ebacf2e4533( musicevent, event_length, event_priority, eventstartdelay )
{
    if ( event_length != 0 )
    {
        self.musicbankparams[ "activeEvent" ] = musicevent;
        self.musicbankparams[ "activeEventPriority" ] = event_priority;
        
        if ( event_length > 0 )
        {
            thread function_4a869a690a26b441( eventstartdelay + event_length + 1 );
        }
        
        return;
    }
    
    function_fc6bd251f203728e();
}

// Namespace musicbank_utility
// Params 4
// Checksum 0xe17becbd, Offset: 0x1250
// Size: 0x7e
function function_7cdaea98282cdab0( musicevent, event_length, var_14cb719f9b895b63, eventstartdelay )
{
    if ( var_14cb719f9b895b63 <= 0 )
    {
        return;
    }
    
    timetowait = utility::function_4b74c15943231980( var_14cb719f9b895b63 );
    timetowait += utility::function_4b74c15943231980( eventstartdelay );
    
    if ( event_length > 0 )
    {
        timetowait += utility::function_4b74c15943231980( event_length );
    }
    
    self.musicbankparams[ "cooldownEndTimes" ][ musicevent ] = timetowait + gettime();
}

// Namespace musicbank_utility
// Params 1
// Checksum 0xa7f7d95e, Offset: 0x12d6
// Size: 0x2b4
function function_bf29b32d284c6a8d( music_event_id )
{
    if ( music_event_id == "" )
    {
        return;
    }
    
    statekey = self.musicbankparams[ "musicbank" ] ?? self.musicbankparams[ "musicbankdefault" ];
    
    if ( !isdefined( statekey ) )
    {
        return;
    }
    
    musicbank = audio_utility::function_72015cb5d5677cad( "musicbank_bundles", statekey );
    
    if ( !isdefined( musicbank ) )
    {
        return;
    }
    
    musicevent = undefined;
    musicbucket = musicbank.buckettype;
    
    if ( !isdefined( musicbucket ) )
    {
        musicbucket = "default";
    }
    
    if ( isarray( musicbank.var_729199aa7771deeb ) && isdefined( musicbank.var_729199aa7771deeb[ music_event_id ] ) )
    {
        musicevent = musicbank.var_729199aa7771deeb[ music_event_id ];
    }
    else if ( isarray( musicbank.musicevent ) )
    {
        foreach ( event in musicbank.musicevent )
        {
            if ( event.eventid == music_event_id )
            {
                musicevent = event;
                break;
            }
        }
    }
    
    if ( isdefined( musicevent ) )
    {
        statename = undefined;
        eventstartdelay = 0;
        eventlength = 0;
        eventpriority = 0;
        var_92a6670f8e172ce7 = 0;
        eventbucket = "default";
        music_state = utility::array_random( musicevent.musicstates );
        
        if ( isdefined( music_state ) )
        {
            statename = music_state.statename;
        }
        
        if ( isdefined( musicevent.eventstartdelay ) )
        {
            eventstartdelay = musicevent.eventstartdelay;
        }
        
        if ( isdefined( musicevent.eventlength ) )
        {
            eventlength = musicevent.eventlength;
        }
        
        if ( isdefined( musicevent.eventpriority ) )
        {
            eventpriority = musicevent.eventpriority;
        }
        
        if ( isdefined( musicevent.var_92a6670f8e172ce7 ) )
        {
            var_92a6670f8e172ce7 = musicevent.var_92a6670f8e172ce7;
        }
        
        if ( isdefined( musicevent.eventbucket ) )
        {
            eventbucket = musicevent.eventbucket;
        }
        
        return { #eventbucket:eventbucket, #var_92a6670f8e172ce7:var_92a6670f8e172ce7, #eventpriority:eventpriority, #eventlength:eventlength, #eventstartdelay:eventstartdelay, #statename:statename };
    }
}

// Namespace musicbank_utility
// Params 0
// Checksum 0x75cc82fc, Offset: 0x1593
// Size: 0x34, Type: bool
function function_96c166c09b344538()
{
    if ( level.gamemodebundle.var_4f105518d87a5e1 && isdefined( level.gamemodebundle.var_faf239404f56b013 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace musicbank_utility
// Params 1
// Checksum 0xb07dc0e6, Offset: 0x15d0
// Size: 0xe, Type: bool
function function_627e5ec9546734df( var_ba923614276cba64 )
{
    return true;
}

// Namespace musicbank_utility
// Params 0
// Checksum 0xe8cb9c17, Offset: 0x15e7
// Size: 0x1c, Type: bool
function is_music_disabled_globally()
{
    if ( level.var_122f0ec859569086.music_disabled_globally )
    {
        return true;
    }
    
    return false;
}

// Namespace musicbank_utility
// Params 0
// Checksum 0x5ae6f69b, Offset: 0x160c
// Size: 0x18
function function_2194c80dafa12a29()
{
    level.var_122f0ec859569086.music_disabled_globally = 1;
}

// Namespace musicbank_utility
// Params 0
// Checksum 0xb10c9846, Offset: 0x162c
// Size: 0x17
function function_633af2f4cf020850()
{
    level.var_122f0ec859569086.music_disabled_globally = 0;
}

// Namespace musicbank_utility
// Params 0
// Checksum 0xcd6bd46f, Offset: 0x164b
// Size: 0x2a
function function_9e41ebfa125d6fc1()
{
    if ( !isdefined( self.musicbankparams ) )
    {
        self.musicbankparams = [];
    }
    
    self.musicbankparams[ "music_disabled" ] = 1;
}

// Namespace musicbank_utility
// Params 0
// Checksum 0x42e5a0ff, Offset: 0x167d
// Size: 0x29
function function_7a910198a184c7b6()
{
    if ( !isdefined( self.musicbankparams ) )
    {
        self.musicbankparams = [];
    }
    
    self.musicbankparams[ "music_disabled" ] = 0;
}

// Namespace musicbank_utility
// Params 1
// Checksum 0xf3a206f9, Offset: 0x16ae
// Size: 0x54
function function_683e33ddcb824d18( eventid )
{
    if ( arraycontains( level.var_122f0ec859569086.disabled_events, eventid ) )
    {
        return;
    }
    
    level.var_122f0ec859569086.disabled_events[ level.var_122f0ec859569086.disabled_events.size ] = eventid;
}

// Namespace musicbank_utility
// Params 1
// Checksum 0xefc0c569, Offset: 0x170a
// Size: 0x55
function function_e146ca500a84f52f( eventid )
{
    if ( arraycontains( level.var_122f0ec859569086.disabled_events, eventid ) )
    {
        level.var_122f0ec859569086.disabled_events = arrayremove( level.var_122f0ec859569086.disabled_events, eventid );
    }
}

// Namespace musicbank_utility
// Params 1
// Checksum 0x701d413b, Offset: 0x1767
// Size: 0x4b, Type: bool
function function_f30434bb0103e318( incomingpriority )
{
    if ( isdefined( self.musicbankparams[ "activeEvent" ] ) )
    {
        if ( isdefined( self.musicbankparams[ "activeEventPriority" ] ) )
        {
            if ( self.musicbankparams[ "activeEventPriority" ] > incomingpriority )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace musicbank_utility
// Params 1
// Checksum 0x64e99c9c, Offset: 0x17bb
// Size: 0x2e
function function_4a869a690a26b441( waittime )
{
    self endon( #"disconnect" );
    self endon( #"hash_852ea487435d0dbd" );
    wait waittime;
    function_fc6bd251f203728e();
}

// Namespace musicbank_utility
// Params 0
// Checksum 0x907ea16d, Offset: 0x17f1
// Size: 0x36
function function_fc6bd251f203728e()
{
    if ( !isdefined( self.musicbankparams ) )
    {
        self.musicbankparams = [];
    }
    
    self.musicbankparams[ "activeEvent" ] = undefined;
    self.musicbankparams[ "activeEventPriority" ] = undefined;
}

// Namespace musicbank_utility
// Params 1
// Checksum 0xbbdca89f, Offset: 0x182f
// Size: 0x78, Type: bool
function function_bb5615e55107cb71( musicevent )
{
    if ( !isdefined( self.musicbankparams[ "cooldownEndTimes" ] ) )
    {
        self.musicbankparams[ "cooldownEndTimes" ] = [];
    }
    
    if ( isdefined( self.musicbankparams[ "cooldownEndTimes" ][ musicevent ] ) )
    {
        if ( gettime() < self.musicbankparams[ "cooldownEndTimes" ][ musicevent ] )
        {
            return true;
        }
        else
        {
            self.musicbankparams[ "cooldownEndTimes" ][ musicevent ] = undefined;
        }
    }
    
    return false;
}

// Namespace musicbank_utility
// Params 1
// Checksum 0x6cf74f4d, Offset: 0x18b0
// Size: 0x115, Type: bool
function function_cf0583320b8b0d2( music_event_id )
{
    if ( music_event_id == "" )
    {
        return false;
    }
    
    statekey = self.musicbankparams[ "musicbank" ] ?? self.musicbankparams[ "musicbankdefault" ];
    
    if ( !isdefined( statekey ) )
    {
        return false;
    }
    
    musicbank = audio_utility::function_72015cb5d5677cad( "musicbank_bundles", statekey );
    
    if ( !isdefined( musicbank ) )
    {
        return false;
    }
    
    musicbucket = musicbank.buckettype;
    
    if ( !isdefined( musicbucket ) )
    {
        musicbucket = "default";
    }
    
    foreach ( event in musicbank.musicevent )
    {
        if ( event.eventid == music_event_id )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace musicbank_utility
// Params 1
// Checksum 0xd065aeca, Offset: 0x19ce
// Size: 0x1d
function function_9f1344352533f3a7( player )
{
    return player.musicbankparams[ "activeEvent" ];
}

