// script_239a365a92ee4476  (hash_239a365a92ee4476.gscc) (size: 20382 Bytes / 0x4f9e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe1af7cd0 (3786374352)
// size ...... 20382 (0x4f9e)
// includes .. 19  (offset: 0x4cae)
// strings ... 31  (offset: 0x4d46)
// dev strs .. 14  (offset: 0x4ef6)
// exports ... 74  (offset: 0x319a)
// cseg ...... 0x34c + 0x2e4e (0x319a)
// imports ... 131 (offset: 0x3d2a)
// animtree1 . 0   (offset: 0x4f9e)
// animtree2 . 0   (offset: 0x4f9e)
#using script_254c2e2a2c8207f8;
#using script_45e6947be98e16e3;
#using scripts\common\callbacks;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\lui_game_event_aggregator;
#using scripts\mp\flags;
#using scripts\mp\ftue\utility\ftue_cash;
#using scripts\mp\ftue\utility\ftue_enemy;
#using scripts\mp\ftue\utility\ftue_gulag;
#using scripts\mp\ftue\utility\ftue_objectives;
#using scripts\mp\ftue\utility\ftue_player;
#using scripts\mp\ftue\utility\ftue_progress;
#using scripts\mp\ftue\utility\ftue_telemetry;
#using scripts\mp\ftue\utility\ftue_tip;
#using scripts\mp\ftue\utility\ftue_utility;
#using scripts\mp\gamelogic;
#using scripts\mp\matchdata;

#namespace namespace_44e8cefed76aa88e;

// Namespace namespace_44e8cefed76aa88e
// Params 4
// Checksum 0x4b627b5b, Offset: 0x36a
// Size: 0xea
function init( datacallback, var_12d20f36b49af28f, var_d40c86f220099742, playertriggercallback )
{
    namespace_c6146975db76fd48::function_7ee9a231857d626a();
    level function_91fc167ffee8264b( datacallback );
    level function_910c88a001f48b7();
    level ftue_progress::function_2f77d23c606e433f();
    function_e71cd02f96fba4d0();
    level.var_a0091bd8bb5fd717.var_12d20f36b49af28f = var_12d20f36b49af28f;
    level.var_a0091bd8bb5fd717.var_d40c86f220099742 = var_d40c86f220099742;
    callback::add( #"player_connect", &onplayerconnect );
    callback::add( #"player_disconnect", &onplayerdisconnect );
    
    if ( isdefined( playertriggercallback ) )
    {
        utility::registersharedfunc( #"ftue", #"player_action", playertriggercallback );
    }
    
    level.var_9adfdadf7cab77a7 = [];
    level.var_e7cd3b12c7adf1f7 = [];
    level thread function_2d9cb28aa2cec6e2();
    level thread function_b2123343a0352f10();
}

// Namespace namespace_44e8cefed76aa88e
// Params 1
// Checksum 0x190403b8, Offset: 0x45c
// Size: 0x18
function function_5ac7a56ac91c3eb( var_9e3e9773e1153bd3 )
{
    return level.var_2e3590a0be8bd1ef[ var_9e3e9773e1153bd3 ];
}

// Namespace namespace_44e8cefed76aa88e
// Params 1
// Checksum 0x8312efb4, Offset: 0x47d
// Size: 0x18
function function_dd657225807f6f99( tooltipid )
{
    return level.var_13483806c100ad3e[ tooltipid ];
}

// Namespace namespace_44e8cefed76aa88e
// Params 0
// Checksum 0xd03d97e3, Offset: 0x49e
// Size: 0x35
function function_e71cd02f96fba4d0()
{
    level endon( #"game_ended" );
    
    if ( !isdefined( level.var_9398dff023585316 ) )
    {
        level waittill( #"lui_game_event_aggregator_initialized" );
    }
    
    lui_game_event_aggregator::registeronluieventcallback( &function_7843e081ad320a10 );
}

// Namespace namespace_44e8cefed76aa88e
// Params 2
// Checksum 0xd9b1d820, Offset: 0x4db
// Size: 0x6f
function function_7843e081ad320a10( event, value )
{
    assert( isplayer( self ) );
    
    if ( isdefined( event ) && isdefined( value ) && event == "ftue_tips_disabled" )
    {
        wantenabled = !value;
        
        if ( self.ftuetips_enabled != wantenabled )
        {
            if ( wantenabled )
            {
                function_40b5609a0e802d3a();
                return;
            }
            
            function_c3e46b280777d277( 0 );
        }
    }
}

// Namespace namespace_44e8cefed76aa88e
// Params 1
// Checksum 0x4212c6bd, Offset: 0x552
// Size: 0xaf
function function_91fc167ffee8264b( datacallback )
{
    level.var_a0091bd8bb5fd717 = spawnstruct();
    level.var_a0091bd8bb5fd717.var_f35c0fc707decd5d = 1000;
    level.var_a0091bd8bb5fd717.var_42d57ddfb7f56dab = getdvarint( @"hash_a6dc72b6202f816a", 0 );
    level.var_a0091bd8bb5fd717.contextualtips = [];
    level.var_a0091bd8bb5fd717.var_831abb8d864ee6f9 = [];
    level.var_a0091bd8bb5fd717.var_c6b2d55070c7f917 = [];
    function_c897896a5129cc8();
    level function_feeeaf4be5bd0641( datacallback );
    level.ftuedata = spawnstruct();
}

// Namespace namespace_44e8cefed76aa88e
// Params 0
// Checksum 0x7cff359b, Offset: 0x609
// Size: 0x102
function function_8accd685751e98e0()
{
    allcompleted = 1;
    completedamount = 0;
    
    foreach ( key, var_b9c3747859752811 in level.var_a0091bd8bb5fd717.contextualtips )
    {
        completed = ftue_progress::function_23632e49519e1ef7( function_5ac7a56ac91c3eb( key ) );
        
        if ( level.var_a0091bd8bb5fd717.var_42d57ddfb7f56dab )
        {
            completed = 0;
        }
        
        self.var_11133cb0607b498f.completed[ key ] = completed;
        
        if ( completed )
        {
            completedamount++;
            continue;
        }
        
        allcompleted = 0;
    }
    
    self.var_11133cb0607b498f.var_cdf8f9cd67258dc = completedamount;
    return allcompleted;
}

// Namespace namespace_44e8cefed76aa88e
// Params 0
// Checksum 0x768310bb, Offset: 0x714
// Size: 0x16a
function function_edcb1f79645dde9d()
{
    playerexpertise = self.expertisedata;
    assert( isdefined( playerexpertise ), "<dev string:x24>" );
    
    foreach ( key, var_b9c3747859752811 in level.var_a0091bd8bb5fd717.contextualtips )
    {
        assert( isdefined( var_b9c3747859752811.var_887f369888f42d5b ), "<dev string:x42>" );
        
        if ( !arraycontains( var_b9c3747859752811.var_887f369888f42d5b, -1 ) && !arraycontains( var_b9c3747859752811.var_887f369888f42d5b, playerexpertise ) )
        {
            level.var_a0091bd8bb5fd717.var_2c4b83c6e35f4377 = arrayremove( level.var_a0091bd8bb5fd717.var_2c4b83c6e35f4377, key );
            level.var_a0091bd8bb5fd717.var_4d8b48f577abb6f1 = arrayremove( level.var_a0091bd8bb5fd717.var_4d8b48f577abb6f1, key );
            level.var_a0091bd8bb5fd717.var_8bc515be625d3f6d = arrayremove( level.var_a0091bd8bb5fd717.var_8bc515be625d3f6d, key );
        }
    }
}

// Namespace namespace_44e8cefed76aa88e
// Params 0
// Checksum 0x93da0ba7, Offset: 0x886
// Size: 0x10
function function_40b5609a0e802d3a()
{
    ftue_tip::ftue_tip_initplayer();
    function_e151a36bd54e3276();
}

// Namespace namespace_44e8cefed76aa88e
// Params 1
// Checksum 0xa65b0d4e, Offset: 0x89e
// Size: 0x77
function function_c3e46b280777d277( disconnect )
{
    level.var_9adfdadf7cab77a7 = arrayremove( level.var_9adfdadf7cab77a7, self );
    level.var_e7cd3b12c7adf1f7 = arrayremove( level.var_e7cd3b12c7adf1f7, self );
    
    if ( !disconnect && self.ftuetips_enabled )
    {
        ftue_tip::function_e1b6c8c6f8f3dc45( 0 );
        self notify( #"currentContextualTipAborted" );
        self notify( #"hash_44f28431f45beba6" );
        self.ftuetips_enabled = 0;
    }
}

// Namespace namespace_44e8cefed76aa88e
// Params 1, eflags: 0x4
// Checksum 0xbaa953f0, Offset: 0x91d
// Size: 0x13
function private onplayerconnect( player )
{
    function_40b5609a0e802d3a();
}

// Namespace namespace_44e8cefed76aa88e
// Params 1, eflags: 0x4
// Checksum 0xbe11c90e, Offset: 0x938
// Size: 0x15
function private onplayerdisconnect( player )
{
    function_c3e46b280777d277( 1 );
}

// Namespace namespace_44e8cefed76aa88e
// Params 0, eflags: 0x4
// Checksum 0xdf880e4d, Offset: 0x955
// Size: 0x7e
function private function_e151a36bd54e3276()
{
    if ( isbot( self ) )
    {
        return;
    }
    
    self.ftuetips_enabled = ftue_progress::function_ee2163604314c218();
    
    if ( !game_utility_mp::onlinestatsenabled() )
    {
        return;
    }
    
    if ( isdefined( level.var_a0091bd8bb5fd717.var_12d20f36b49af28f ) )
    {
        tipsenabled = self [[ level.var_a0091bd8bb5fd717.var_12d20f36b49af28f ]]();
    }
    else
    {
        tipsenabled = 1;
    }
    
    if ( tipsenabled )
    {
        function_352ec412c63dd0c9();
        return;
    }
    
    self.ftuetips_enabled = 0;
}

// Namespace namespace_44e8cefed76aa88e
// Params 0, eflags: 0x4
// Checksum 0x89e124e5, Offset: 0x9db
// Size: 0x32
function private function_352ec412c63dd0c9()
{
    self.ftuetips_enabled = ftue_progress::function_ee2163604314c218();
    function_7d843a58ec4d6f6c( level.var_a0091bd8bb5fd717.var_d40c86f220099742 );
    thread playerendgame();
}

// Namespace namespace_44e8cefed76aa88e
// Params 0
// Checksum 0x13386d4e, Offset: 0xa15
// Size: 0x20
function function_fd6a22ea6579c76()
{
    playedmatches = ftue_progress::function_1b4dcded8ba60625() + 1;
    ftue_telemetry::function_394c8146182787a9( playedmatches );
}

// Namespace namespace_44e8cefed76aa88e
// Params 1
// Checksum 0x3e33eb71, Offset: 0xa3d
// Size: 0xb1
function function_7d843a58ec4d6f6c( var_d40c86f220099742 )
{
    self.var_11133cb0607b498f = spawnstruct();
    self.var_11133cb0607b498f.completed = [];
    self.var_11133cb0607b498f.manualtips = [];
    self.var_11133cb0607b498f.var_5e65254ccf9da32c = [];
    self.var_11133cb0607b498f.cooldown = 0;
    function_8accd685751e98e0();
    self [[ var_d40c86f220099742 ]]();
    function_1b856db89817804a();
    function_bc90906860706bb4();
    function_edcb1f79645dde9d();
    function_8e3d6d2720ee4430();
    level ui::lui_registercallback( "force_tooltip_execute", &function_2abaf6f7f24e246c );
    level thread function_1c1399a08f3370ac( self );
}

// Namespace namespace_44e8cefed76aa88e
// Params 0, eflags: 0x4
// Checksum 0xce531bcd, Offset: 0xaf6
// Size: 0x2d
function private playerendgame()
{
    self endon( #"disconnect" );
    childthread function_c7cc7786156b2dad();
    utility::waittill_any_return( "br_player_aar_data_set", "disconnect" );
    onendgame();
}

// Namespace namespace_44e8cefed76aa88e
// Params 0, eflags: 0x4
// Checksum 0xe5ed707, Offset: 0xb2b
// Size: 0x5a
function private onendgame()
{
    assert( isplayer( self ) );
    matchtime = gettime();
    matchtime = matchdata::gettimefrommatchstart( matchtime ) * 0.001;
    matchtime = int( matchtime );
    ftue_progress::function_bff6c3b0092a56bb( matchtime );
    playedmatches = ftue_progress::function_1bd78cb3a25a72c8();
    ftue_telemetry::function_81211bd09c666dd2( playedmatches, 0 );
}

// Namespace namespace_44e8cefed76aa88e
// Params 1
// Checksum 0x8cdb10f7, Offset: 0xb8d
// Size: 0xa9
function function_2abaf6f7f24e246c( tooltipid )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( self.var_11133cb0607b498f.var_9756c278fa24746f != "" )
    {
        ftue_tip::function_953a5a3682bc5957();
        self notify( #"currentContextualTipAborted" );
        waitframe();
    }
    
    tooltipkey = function_dd657225807f6f99( tooltipid );
    childthread function_2a7eba1cf2f28e03( tooltipkey );
    self.var_11133cb0607b498f.var_13793e920abd0acc = 1;
    self waittill( #"currentContextualTipCompleted" );
    self.var_11133cb0607b498f.var_13793e920abd0acc = 0;
}

// Namespace namespace_44e8cefed76aa88e
// Params 0
// Checksum 0xd5530742, Offset: 0xc3e
// Size: 0xa9, Type: bool
function function_f2d0caf56f57225f()
{
    foreach ( tipkey, var_b9c3747859752811 in level.var_a0091bd8bb5fd717.contextualtips )
    {
        if ( var_b9c3747859752811.var_dd0eac742e1ea485 && !self.var_11133cb0607b498f.completed[ tipkey ] )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_44e8cefed76aa88e
// Params 0
// Checksum 0x47ee3bd5, Offset: 0xcf0
// Size: 0xa9, Type: bool
function function_fbd9272aaaa9699()
{
    foreach ( tipkey, var_b9c3747859752811 in level.var_a0091bd8bb5fd717.contextualtips )
    {
        if ( var_b9c3747859752811.var_7df69b09c1a2a1c9 && !self.var_11133cb0607b498f.completed[ tipkey ] )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_44e8cefed76aa88e
// Params 0
// Checksum 0xf674a596, Offset: 0xda2
// Size: 0x11
function function_1b856db89817804a()
{
    self.expertisedata = ftue_progress::function_1a1277c0b2dc47a6();
}

// Namespace namespace_44e8cefed76aa88e
// Params 1
// Checksum 0x393ba486, Offset: 0xdbb
// Size: 0xee
function function_1c1399a08f3370ac( player )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    
    if ( !player.hasspawned )
    {
        player waittill( #"spawned_player" );
    }
    
    wait 1;
    level.var_9adfdadf7cab77a7[ level.var_9adfdadf7cab77a7.size ] = player;
    player.var_11133cb0607b498f.var_fbd9272aaaa9699 = player function_fbd9272aaaa9699();
    player.var_11133cb0607b498f.var_f2d0caf56f57225f = player function_f2d0caf56f57225f();
    
    if ( player.var_11133cb0607b498f.var_fbd9272aaaa9699 || player.var_11133cb0607b498f.var_f2d0caf56f57225f )
    {
        level.var_e7cd3b12c7adf1f7[ level.var_e7cd3b12c7adf1f7.size ] = player;
    }
    
    level notify( #"hash_a0774b9aef73c0a0", player );
}

// Namespace namespace_44e8cefed76aa88e
// Params 0
// Checksum 0xf90ab0d7, Offset: 0xeb1
// Size: 0x3
function function_53d566d20a414fe0()
{
    waitframe();
}

// Namespace namespace_44e8cefed76aa88e
// Params 0, eflags: 0x4
// Checksum 0xbe595c43, Offset: 0xebc
// Size: 0x169
function private function_2d9cb28aa2cec6e2()
{
    level endon( #"game_ended" );
    maxwork = getdvarint( @"hash_9a44c0fad5ccdc87", 150 );
    assert( maxwork > 0, "<dev string:x60>" );
    basecost = getdvarint( @"hash_26bc207d8b1fa10e", 10 );
    assert( basecost > 0, "<dev string:xbc>" );
    fullcost = getdvarint( @"hash_22c9be4203eb9036", 50 );
    assert( fullcost > 0, "<dev string:x115>" );
    
    while ( true )
    {
        totalwork = 0;
        function_53d566d20a414fe0();
        currenttime = gettime();
        
        foreach ( player in level.var_9adfdadf7cab77a7 )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( player function_83906410c3e1b017( currenttime ) )
            {
                totalwork += fullcost;
                player function_2f5f63c7a754472b();
            }
            else
            {
                totalwork += basecost;
            }
            
            if ( totalwork >= maxwork )
            {
                totalwork = 0;
                function_53d566d20a414fe0();
                currenttime = gettime();
            }
        }
    }
}

// Namespace namespace_44e8cefed76aa88e
// Params 1
// Checksum 0xbedd4285, Offset: 0x102d
// Size: 0x1c2, Type: bool
function function_baae09a419ce59e2( typemask )
{
    self.nearbyenemies = undefined;
    self.nearbyallies = undefined;
    self.allallies = undefined;
    var_bf72eee9e6c7f825 = self.var_11133cb0607b498f.var_fbd9272aaaa9699;
    var_2ccde3dccc5f611b = self.var_11133cb0607b498f.var_f2d0caf56f57225f;
    
    if ( !var_bf72eee9e6c7f825 && !var_2ccde3dccc5f611b )
    {
        return false;
    }
    
    nearbyenemies = [];
    nearbyallies = [];
    origin = self.origin;
    assert( -1 );
    assert( -1 );
    ents = getentitiesinradiusfrompartitiongrid( origin, 2755, typemask, [ self ] );
    
    if ( var_bf72eee9e6c7f825 )
    {
        allies = function_9a53e3b03233a420( self, ents, 1 );
        
        foreach ( checkplayer in allies )
        {
            if ( distancesquared( checkplayer.origin, origin ) <= 1000000 )
            {
                nearbyallies[ nearbyallies.size ] = checkplayer;
            }
        }
    }
    
    if ( var_2ccde3dccc5f611b )
    {
        nearbyenemies = function_9a53e3b03233a420( self, ents, 0 );
    }
    
    if ( nearbyenemies.size != 0 )
    {
        self.nearbyenemies = nearbyenemies;
    }
    
    if ( nearbyallies.size != 0 )
    {
        self.nearbyallies = nearbyallies;
    }
    
    if ( var_bf72eee9e6c7f825 )
    {
        self.allallies = function_9a53e3b03233a420( self, level.players, 1 );
    }
    
    return true;
}

// Namespace namespace_44e8cefed76aa88e
// Params 0
// Checksum 0x9edc7c67, Offset: 0x11f8
// Size: 0x18d
function function_b2123343a0352f10()
{
    level endon( #"game_ended" );
    updatetime = 1000 * getdvarint( @"hash_1da7540b953c3277", 2 );
    maxprocess = getdvarint( @"hash_661fbc0e07f4c8bf", 2 );
    typemask = createentitytypemask( [ "etype_player" ] );
    
    if ( level.var_e7cd3b12c7adf1f7.size == 0 )
    {
        level waittill( #"hash_a0774b9aef73c0a0" );
    }
    
    while ( true )
    {
        waitframe();
        starttime = gettime();
        searchplayers = [];
        processcount = 0;
        
        foreach ( player in level.var_e7cd3b12c7adf1f7 )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( player function_baae09a419ce59e2( typemask ) )
            {
                processcount++;
                searchplayers[ searchplayers.size ] = player;
            }
            
            if ( maxprocess > 0 && processcount >= maxprocess )
            {
                processcount = 0;
                waitframe();
            }
        }
        
        level.var_e7cd3b12c7adf1f7 = searchplayers;
        endtime = gettime();
        deltatime = endtime - starttime;
        
        if ( deltatime < updatetime )
        {
            waittime = ( updatetime - deltatime ) / 1000;
            wait waittime;
        }
    }
}

// Namespace namespace_44e8cefed76aa88e
// Params 0, eflags: 0x4
// Checksum 0x8184de73, Offset: 0x138d
// Size: 0x11
function private function_545fad5497d7e38f()
{
    self.var_748dffc202f20964 = namespace_727c07157c884ff5::function_d6346b47316cfeca();
}

// Namespace namespace_44e8cefed76aa88e
// Params 1
// Checksum 0x77278115, Offset: 0x13a6
// Size: 0x10b
function function_cd5c9127e93ad450( var_1513bb446989f245 )
{
    var_47ebe6ddefb98c8 = self.var_11133cb0607b498f.manualtips[ 0 ];
    
    if ( isdefined( var_1513bb446989f245 ) )
    {
        if ( isdefined( var_47ebe6ddefb98c8 ) )
        {
            manualtip = level.var_a0091bd8bb5fd717.contextualtips[ var_47ebe6ddefb98c8 ];
            launchtip = level.var_a0091bd8bb5fd717.contextualtips[ var_1513bb446989f245 ];
            
            if ( launchtip.priority <= manualtip.priority )
            {
                var_1513bb446989f245 = var_47ebe6ddefb98c8;
                self.var_11133cb0607b498f.manualtips[ 0 ] = undefined;
                function_cdc669dbc8ea2101( self.var_11133cb0607b498f.manualtips );
            }
        }
    }
    else if ( isdefined( var_47ebe6ddefb98c8 ) )
    {
        var_1513bb446989f245 = var_47ebe6ddefb98c8;
        self.var_11133cb0607b498f.manualtips[ 0 ] = undefined;
        function_cdc669dbc8ea2101( self.var_11133cb0607b498f.manualtips );
    }
    else
    {
        return;
    }
    
    childthread function_99686d64b251d964( var_1513bb446989f245 );
}

// Namespace namespace_44e8cefed76aa88e
// Params 1, eflags: 0x4
// Checksum 0x7343f49c, Offset: 0x14b9
// Size: 0x4e, Type: bool
function private function_83906410c3e1b017( processtime )
{
    if ( !ftue_tip::function_bb643ddeb2f6e3fc() )
    {
        return false;
    }
    
    if ( isdefined( self.var_11133cb0607b498f.var_9756c278fa24746f ) )
    {
        return false;
    }
    
    if ( self.var_11133cb0607b498f.cooldown > processtime )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_44e8cefed76aa88e
// Params 0, eflags: 0x4
// Checksum 0x7ceacc97, Offset: 0x1510
// Size: 0x34
function private function_d31f525ba3649912()
{
    return gamelogic_mp::inprematch() ? level.var_a0091bd8bb5fd717.var_4d8b48f577abb6f1 : level.var_a0091bd8bb5fd717.var_2c4b83c6e35f4377;
}

// Namespace namespace_44e8cefed76aa88e
// Params 0, eflags: 0x4
// Checksum 0xf7142318, Offset: 0x154d
// Size: 0xb4
function private function_2f5f63c7a754472b()
{
    function_545fad5497d7e38f();
    var_1513bb446989f245 = undefined;
    var_32513ae15c2daf6e = function_d31f525ba3649912();
    
    foreach ( tipkey in var_32513ae15c2daf6e )
    {
        var_2a7eba1cf2f28e03 = function_80a717d47aebbf56( tipkey );
        
        if ( var_2a7eba1cf2f28e03 )
        {
            var_1513bb446989f245 = tipkey;
            break;
        }
    }
    
    function_cd5c9127e93ad450( var_1513bb446989f245 );
}

// Namespace namespace_44e8cefed76aa88e
// Params 1
// Checksum 0x1cf4bac2, Offset: 0x1609
// Size: 0x99
function function_d2c3978b9eb0b507( tipkey )
{
    self.var_11133cb0607b498f.completed[ tipkey ] = 1;
    self.var_11133cb0607b498f.var_cdf8f9cd67258dc++;
    
    if ( self.var_11133cb0607b498f.var_bf72eee9e6c7f825 )
    {
        self.var_11133cb0607b498f.var_bf72eee9e6c7f825 = function_fbd9272aaaa9699();
    }
    
    if ( self.var_11133cb0607b498f.var_2ccde3dccc5f611b )
    {
        self.var_11133cb0607b498f.var_2ccde3dccc5f611b = function_f2d0caf56f57225f();
    }
}

// Namespace namespace_44e8cefed76aa88e
// Params 1
// Checksum 0xc958af28, Offset: 0x16aa
// Size: 0x196
function function_99686d64b251d964( tipkey )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self.var_11133cb0607b498f.var_9756c278fa24746f = tipkey;
    childthread function_2a7eba1cf2f28e03( tipkey );
    childthread function_687a422100371f8d( tipkey );
    tipresult = utility::waittill_any_return( "currentContextualTipCompleted", "currentContextualTipAborted" );
    function_d2c3978b9eb0b507( tipkey );
    
    if ( isdefined( tipresult ) )
    {
        if ( tipresult == "currentContextualTipCompleted" )
        {
            /#
                childthread ftue_utility::printtoscreen( "<dev string:x16e>" + getxhashsourcename( tipkey ) );
            #/
            
            ftue_progress::function_d00c0941d634466b( function_5ac7a56ac91c3eb( tipkey ) );
            
            if ( self.var_11133cb0607b498f.var_cdf8f9cd67258dc >= level.var_a0091bd8bb5fd717.var_f35c0fc707decd5d )
            {
                return;
            }
        }
        else
        {
            /#
                childthread ftue_utility::printtoscreen( "<dev string:x189>" + getxhashsourcename( tipkey ) );
            #/
        }
    }
    else
    {
        self notify( #"currentContextualTipAborted", "death" );
        ftue_tip::function_e1b6c8c6f8f3dc45( 0, level.ftuedata.var_8e6073bcd0a30366 );
        
        /#
            childthread ftue_utility::printtoscreen( "<dev string:x1a2>" + getxhashsourcename( tipkey ) );
        #/
    }
    
    if ( isdefined( self.var_11133cb0607b498f ) )
    {
        self.var_11133cb0607b498f.var_9756c278fa24746f = undefined;
        tooltipcooldown = utility::callsharedfunc( #"ftue", #"hash_8003d8d4e79536cc" );
        self.var_11133cb0607b498f.cooldown = gettime() + ( tooltipcooldown ?? 12 ) * 1000;
    }
}

// Namespace namespace_44e8cefed76aa88e
// Params 0
// Checksum 0xf79f2c28, Offset: 0x1848
// Size: 0x1c
function function_c7cc7786156b2dad()
{
    utility::waittill_any_ents( level, "game_ended", self, "br_team_fully_eliminated" );
    ftue_tip::function_953a5a3682bc5957();
}

// Namespace namespace_44e8cefed76aa88e
// Params 1
// Checksum 0xfa1b4093, Offset: 0x186c
// Size: 0x1c0
function function_80a717d47aebbf56( var_85ef3afebb115c38 )
{
    var_b9c3747859752811 = level.var_a0091bd8bb5fd717.contextualtips[ var_85ef3afebb115c38 ];
    
    /#
        if ( self.var_11133cb0607b498f.var_13793e920abd0acc )
        {
            return 0;
        }
    #/
    
    if ( self.var_11133cb0607b498f.completed[ var_85ef3afebb115c38 ] )
    {
        return 0;
    }
    
    if ( !var_b9c3747859752811.inprematch && ( !flags::gameflagexists( "infil_animatic_complete" ) || !flags::gameflag( "infil_animatic_complete" ) ) && !level.br_infils_disabled )
    {
        return 0;
    }
    
    result = 1;
    
    if ( isdefined( var_b9c3747859752811.condfunc ) )
    {
        result = self [[ var_b9c3747859752811.condfunc ]]( var_b9c3747859752811.var_dd8cecd01ff5f6a2 );
    }
    else if ( isdefined( var_b9c3747859752811.initconditions ) )
    {
        foreach ( condition in var_b9c3747859752811.initconditions )
        {
            if ( isdefined( condition.params ) )
            {
                var_d59b1caa429f8a39 = self [[ level.var_31ba871bbc6d3d12[ condition.func ] ]]( condition.params );
            }
            else
            {
                var_d59b1caa429f8a39 = self [[ level.var_31ba871bbc6d3d12[ condition.func ] ]]();
            }
            
            result = result && var_d59b1caa429f8a39;
        }
    }
    
    return result;
}

// Namespace namespace_44e8cefed76aa88e
// Params 1
// Checksum 0x6bbcfe3f, Offset: 0x1a35
// Size: 0x167
function function_687a422100371f8d( var_85ef3afebb115c38 )
{
    var_b9c3747859752811 = level.var_a0091bd8bb5fd717.contextualtips[ var_85ef3afebb115c38 ];
    self endon( #"currentContextualTipCompleted" );
    self endon( #"currentContextualTipAborted" );
    
    if ( isdefined( var_b9c3747859752811.endconditions ) )
    {
        var_3c05b5b4ac807227 = 0;
        
        while ( !var_3c05b5b4ac807227 )
        {
            waitframe();
            
            foreach ( condition in var_b9c3747859752811.endconditions )
            {
                if ( isdefined( condition.params ) )
                {
                    endconditioncompleted = self [[ level.var_31ba871bbc6d3d12[ condition.func ] ]]( condition.params );
                }
                else
                {
                    endconditioncompleted = self [[ level.var_31ba871bbc6d3d12[ condition.func ] ]]();
                }
                
                if ( endconditioncompleted )
                {
                    if ( isdefined( condition.action ) )
                    {
                        self [[ level.var_31ba871bbc6d3d12[ condition.action ] ]]();
                    }
                    
                    var_3c05b5b4ac807227 = 1;
                    break;
                }
            }
        }
    }
}

// Namespace namespace_44e8cefed76aa88e
// Params 0
// Checksum 0xa861e467, Offset: 0x1ba4
// Size: 0x18
function function_1dfa54f0932ed337()
{
    level.ftuedata.var_358e62e099df6129 = 1;
}

// Namespace namespace_44e8cefed76aa88e
// Params 0
// Checksum 0x620dc6e, Offset: 0x1bc4
// Size: 0x18
function function_e61183d7d5fa1528()
{
    level.ftuedata.pauseinterupt = 1;
}

// Namespace namespace_44e8cefed76aa88e
// Params 0
// Checksum 0x496498f9, Offset: 0x1be4
// Size: 0x17
function function_964b5a8132caf917()
{
    level.ftuedata.pauseinterupt = 0;
}

// Namespace namespace_44e8cefed76aa88e
// Params 1, eflags: 0x4
// Checksum 0xa71a20a, Offset: 0x1c03
// Size: 0x125
function private function_f4602b2aef7eb271( var_85ef3afebb115c38 )
{
    if ( !level.ftuedata.var_358e62e099df6129 )
    {
        return;
    }
    
    self endon( #"currentContextualTipCompleted" );
    self endon( #"currentContextualTipAborted" );
    
    while ( true )
    {
        if ( !level.ftuedata.pauseinterupt )
        {
            assertmsg( "<dev string:x1c4>" );
            
            foreach ( checkkey in level.var_a0091bd8bb5fd717.var_2c4b83c6e35f4377 )
            {
                if ( checkkey == var_85ef3afebb115c38 )
                {
                    continue;
                }
                
                caninterrupt = function_80a717d47aebbf56( checkkey );
                
                if ( caninterrupt )
                {
                    println( "<dev string:x1f6>" + var_85ef3afebb115c38 + "<dev string:x20f>" + checkkey );
                    break;
                }
            }
        }
        
        wait 1;
    }
}

// Namespace namespace_44e8cefed76aa88e
// Params 1
// Checksum 0x19cb71d3, Offset: 0x1d30
// Size: 0xa3
function function_2a7eba1cf2f28e03( var_85ef3afebb115c38 )
{
    self endon( #"currentContextualTipCompleted" );
    self endon( #"currentContextualTipAborted" );
    
    /#
        childthread ftue_utility::printtoscreen( "<dev string:x216>" + getxhashsourcename( var_85ef3afebb115c38 ) );
    #/
    
    var_b9c3747859752811 = level.var_a0091bd8bb5fd717.contextualtips[ var_85ef3afebb115c38 ];
    
    if ( isdefined( var_b9c3747859752811.execfunc ) )
    {
        self [[ var_b9c3747859752811.execfunc ]]( var_85ef3afebb115c38, var_b9c3747859752811.notificationid );
        return;
    }
    
    self [[ level.var_31ba871bbc6d3d12[ var_b9c3747859752811.function ] ]]();
}

// Namespace namespace_44e8cefed76aa88e
// Params 0
// Checksum 0x32f43d32, Offset: 0x1ddb
// Size: 0x1b
function function_6291cd8333172ce2()
{
    level.var_31ba871bbc6d3d12[ #"hash_95626095fb1efab5" ] = &function_3a9798f980a93566;
}

// Namespace namespace_44e8cefed76aa88e
// Params 1
// Checksum 0x372f0c90, Offset: 0x1dfe
// Size: 0x300
function function_feeeaf4be5bd0641( datacallback )
{
    if ( !ftue_progress::ftue_enabled() )
    {
        return;
    }
    
    function_6291cd8333172ce2();
    
    if ( isdefined( datacallback ) )
    {
        [[ datacallback ]]();
    }
    
    if ( !level.var_a0091bd8bb5fd717.contextualtips )
    {
        return;
    }
    
    level.var_a0091bd8bb5fd717.contextualtips = function_f8ca8b8b5478c9e4( level.var_a0091bd8bb5fd717.contextualtips );
    level.var_a0091bd8bb5fd717.var_2c4b83c6e35f4377 = function_6b9eaed849cd531d( level.var_a0091bd8bb5fd717.contextualtips, &function_4ca05cbdb79315f );
    level.var_a0091bd8bb5fd717.var_2c4b83c6e35f4377 = function_15b890379302d591( level.var_a0091bd8bb5fd717.var_2c4b83c6e35f4377 );
    level.var_a0091bd8bb5fd717.var_8bc515be625d3f6d = [];
    level.var_a0091bd8bb5fd717.var_4d8b48f577abb6f1 = [];
    
    foreach ( tipkey in level.var_a0091bd8bb5fd717.var_2c4b83c6e35f4377 )
    {
        contextualtip = level.var_a0091bd8bb5fd717.contextualtips[ tipkey ];
        
        if ( contextualtip.inprematch )
        {
            level.var_a0091bd8bb5fd717.var_4d8b48f577abb6f1[ level.var_a0091bd8bb5fd717.var_4d8b48f577abb6f1.size ] = tipkey;
            continue;
        }
        
        if ( contextualtip.ingulag )
        {
            level.var_a0091bd8bb5fd717.var_8bc515be625d3f6d[ level.var_a0091bd8bb5fd717.var_8bc515be625d3f6d.size ] = tipkey;
        }
    }
    
    level.var_a0091bd8bb5fd717.var_2c4b83c6e35f4377 = arrayremove( level.var_a0091bd8bb5fd717.var_2c4b83c6e35f4377, level.var_a0091bd8bb5fd717.var_4d8b48f577abb6f1 );
    level.var_a0091bd8bb5fd717.var_2c4b83c6e35f4377 = arrayremove( level.var_a0091bd8bb5fd717.var_2c4b83c6e35f4377, level.var_a0091bd8bb5fd717.var_8bc515be625d3f6d );
    
    foreach ( player in level.var_9adfdadf7cab77a7 )
    {
        if ( !isdefined( player ) )
        {
            player function_8accd685751e98e0();
        }
    }
}

// Namespace namespace_44e8cefed76aa88e
// Params 1
// Checksum 0xb58bd4af, Offset: 0x2106
// Size: 0xb5
function function_f8ca8b8b5478c9e4( contextualtips )
{
    if ( !isdefined( contextualtips ) )
    {
        return;
    }
    
    filteredtips = [];
    
    foreach ( key, item in contextualtips )
    {
        if ( getdvarint( hashcat( @"hash_b04566e984b5cad4", item.id ), 0 ) != 0 )
        {
            continue;
        }
        
        filteredtips[ key ] = item;
    }
    
    return filteredtips;
}

// Namespace namespace_44e8cefed76aa88e
// Params 1
// Checksum 0xd95405dd, Offset: 0x21c4
// Size: 0xcd
function function_15b890379302d591( contextualtips )
{
    filteredtips = [];
    
    foreach ( tipkey in contextualtips )
    {
        contextualtip = level.var_a0091bd8bb5fd717.contextualtips[ tipkey ];
        
        if ( !isdefined( contextualtip.condfunc ) && !isdefined( contextualtip.initconditions ) )
        {
            continue;
        }
        
        filteredtips[ filteredtips.size ] = tipkey;
    }
    
    return filteredtips;
}

// Namespace namespace_44e8cefed76aa88e
// Params 1
// Checksum 0x1060a955, Offset: 0x229a
// Size: 0x186
function function_5d5fef02540a4a39( tipkey )
{
    if ( !self.ftuetips_enabled || !( isdefined( level.var_a0091bd8bb5fd717 ) && isdefined( self.var_11133cb0607b498f ) ) )
    {
        return;
    }
    
    contextualtip = level.var_a0091bd8bb5fd717.contextualtips[ tipkey ];
    assert( isdefined( contextualtip ) );
    
    if ( self.var_11133cb0607b498f.completed[ tipkey ] )
    {
        return 0;
    }
    
    if ( self.var_11133cb0607b498f.var_5e65254ccf9da32c[ tipkey ] )
    {
        return 0;
    }
    
    self.var_11133cb0607b498f.var_5e65254ccf9da32c[ tipkey ] = 1;
    checkpriority = contextualtip.priority;
    manualtips = self.var_11133cb0607b498f.manualtips;
    var_5a10fc0246a23a68 = [];
    
    for ( var_b7c9065829b91dac = 0; var_b7c9065829b91dac < manualtips.size ; var_b7c9065829b91dac++ )
    {
        var_658dc98b005c3934 = manualtips[ var_b7c9065829b91dac ];
        var_2a7b1046dff72c9d = level.var_a0091bd8bb5fd717.contextualtips[ var_658dc98b005c3934 ];
        
        if ( var_2a7b1046dff72c9d.priority < checkpriority )
        {
            break;
        }
        
        var_5a10fc0246a23a68[ var_5a10fc0246a23a68.size ] = var_658dc98b005c3934;
    }
    
    var_5a10fc0246a23a68[ var_5a10fc0246a23a68.size ] = tipkey;
    
    while ( var_b7c9065829b91dac < manualtips.size )
    {
        var_5a10fc0246a23a68[ var_5a10fc0246a23a68.size ] = manualtips[ var_b7c9065829b91dac ];
        var_b7c9065829b91dac++;
    }
    
    self.var_11133cb0607b498f.manualtips = var_5a10fc0246a23a68;
}

// Namespace namespace_44e8cefed76aa88e
// Params 2
// Checksum 0xb6c86543, Offset: 0x2428
// Size: 0x2c, Type: bool
function function_4ca05cbdb79315f( tipa, tipb )
{
    return tipa.priority >= tipb.priority;
}

// Namespace namespace_44e8cefed76aa88e
// Params 2
// Checksum 0xc2feab6b, Offset: 0x245d
// Size: 0x11e
function function_6b9eaed849cd531d( array, compare_func )
{
    arrayaux = [];
    
    foreach ( key, item in array )
    {
        if ( !isdefined( arrayaux ) )
        {
            arrayaux = [];
        }
        
        arrayaux[ arrayaux.size ] = key;
    }
    
    assert( isdefined( array ), "<dev string:x230>" );
    assert( isdefined( compare_func ), "<dev string:x243>" );
    
    for ( j = 1; j < arrayaux.size ; j++ )
    {
        key = arrayaux[ j ];
        
        for ( i = j - 1; i >= 0 && ![[ compare_func ]]( array[ arrayaux[ i ] ], array[ key ] ) ; i-- )
        {
            arrayaux[ i + 1 ] = arrayaux[ i ];
        }
        
        arrayaux[ i + 1 ] = key;
    }
    
    return arrayaux;
}

// Namespace namespace_44e8cefed76aa88e
// Params 0
// Checksum 0x15922d32, Offset: 0x2584
// Size: 0x216
function function_910c88a001f48b7()
{
    level.var_a0091bd8bb5fd717.var_831abb8d864ee6f9[ "GulagStarted" ] = spawnstruct();
    level.var_a0091bd8bb5fd717.var_831abb8d864ee6f9[ "GulagStarted" ].function = &function_ba1f580e4af99c77;
    level.var_a0091bd8bb5fd717.var_831abb8d864ee6f9[ "GulagStarted" ].expirationtime = 5;
    level.var_a0091bd8bb5fd717.var_831abb8d864ee6f9[ "GulagStarted" ].completionmessage = "IsGulagStarted";
    level.var_a0091bd8bb5fd717.var_831abb8d864ee6f9[ "GulagStarted" ].expirationfunction = &function_286d5db696ae8958;
    level.var_a0091bd8bb5fd717.var_831abb8d864ee6f9[ "GulagStarted" ].expirationmessage = "gulagFinished";
    level.var_a0091bd8bb5fd717.var_831abb8d864ee6f9[ "EnemiesInMinimap" ] = spawnstruct();
    level.var_a0091bd8bb5fd717.var_831abb8d864ee6f9[ "EnemiesInMinimap" ].function = &function_4ca6987da0b833f6;
    level.var_a0091bd8bb5fd717.var_831abb8d864ee6f9[ "EnemiesInMinimap" ].expirationtime = 5;
    level.var_a0091bd8bb5fd717.var_831abb8d864ee6f9[ "EnemiesInMinimap" ].completionmessage = "AreEnemiesInMinimap";
    level.var_a0091bd8bb5fd717.var_831abb8d864ee6f9[ "PlayerShotByEnemy" ] = spawnstruct();
    level.var_a0091bd8bb5fd717.var_831abb8d864ee6f9[ "PlayerShotByEnemy" ].function = &function_e9f6e9ed11e0f19a;
    level.var_a0091bd8bb5fd717.var_831abb8d864ee6f9[ "PlayerShotByEnemy" ].expirationtime = 10;
    level.var_a0091bd8bb5fd717.var_831abb8d864ee6f9[ "PlayerShotByEnemy" ].completionmessage = "IsPlayerShotByEnemy";
}

// Namespace namespace_44e8cefed76aa88e
// Params 0
// Checksum 0x705818fd, Offset: 0x27a2
// Size: 0xce
function function_bc90906860706bb4()
{
    self.var_11133cb0607b498f.eventscondition = [];
    
    foreach ( key, eventcondition in level.var_a0091bd8bb5fd717.var_831abb8d864ee6f9 )
    {
        self.var_11133cb0607b498f.eventscondition[ key ] = spawnstruct();
        self.var_11133cb0607b498f.eventscondition[ key ].isactive = 0;
    }
}

// Namespace namespace_44e8cefed76aa88e
// Params 0
// Checksum 0xaf1ee202, Offset: 0x2878
// Size: 0x86
function function_8e3d6d2720ee4430()
{
    foreach ( key, eventcondition in level.var_a0091bd8bb5fd717.var_831abb8d864ee6f9 )
    {
        thread function_b41d5f213056189a( eventcondition, key );
    }
}

// Namespace namespace_44e8cefed76aa88e
// Params 2
// Checksum 0x3d8c77b8, Offset: 0x2906
// Size: 0xe2
function function_b41d5f213056189a( eventcondition, key )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self.var_11133cb0607b498f.eventscondition[ key ].isactive = 0;
        self childthread [[ eventcondition.function ]]( eventcondition );
        self waittill( eventcondition.completionmessage );
        self.var_11133cb0607b498f.eventscondition[ key ].isactive = 1;
        
        if ( isdefined( eventcondition.expirationfunction ) )
        {
            self childthread [[ eventcondition.expirationfunction ]]();
            self waittill( eventcondition.expirationmessage );
        }
        
        if ( isdefined( eventcondition.expirationtime ) )
        {
            wait eventcondition.expirationtime;
        }
    }
}

// Namespace namespace_44e8cefed76aa88e
// Params 2
// Checksum 0xc94716ce, Offset: 0x29f0
// Size: 0x57
function function_d3aca0739ae1dc47( position, spawndelay )
{
    if ( !isdefined( level.var_a0091bd8bb5fd717.var_7ae780ad4ab7db45 ) )
    {
        return;
    }
    
    if ( isdefined( spawndelay ) )
    {
        wait spawndelay;
    }
    
    level.var_a0091bd8bb5fd717.var_7ae780ad4ab7db45.origin = position;
}

// Namespace namespace_44e8cefed76aa88e
// Params 0
// Checksum 0x39ce8838, Offset: 0x2a4f
// Size: 0xe1
function function_c897896a5129cc8()
{
    level.var_a0091bd8bb5fd717.var_c6b2d55070c7f917[ 0 ] = "brloot_plunder_cash_uncommon_1";
    level.var_a0091bd8bb5fd717.var_c6b2d55070c7f917[ 1 ] = "brloot_plunder_cash_uncommon_2";
    level.var_a0091bd8bb5fd717.var_c6b2d55070c7f917[ 2 ] = "brloot_plunder_cash_uncommon_3";
    level.var_a0091bd8bb5fd717.var_c6b2d55070c7f917[ 3 ] = "brloot_plunder_cash_common_1";
    level.var_a0091bd8bb5fd717.var_c6b2d55070c7f917[ 4 ] = "brloot_plunder_cash_rare_1";
    level.var_a0091bd8bb5fd717.var_c6b2d55070c7f917[ 5 ] = "brloot_plunder_cash_rare_2";
    level.var_a0091bd8bb5fd717.var_c6b2d55070c7f917[ 6 ] = "brloot_plunder_cash__epic_1";
    level.var_a0091bd8bb5fd717.var_c6b2d55070c7f917[ 7 ] = "brloot_plunder_cash__epic_2";
}

// Namespace namespace_44e8cefed76aa88e
// Params 0
// Checksum 0xb1278e7a, Offset: 0x2b38
// Size: 0x3b
function disconnectally()
{
    self.var_11133cb0607b498f.deadally waittill( #"disconnect" );
    ftue_tip::function_953a5a3682bc5957();
    self notify( #"currentContextualTipAborted" );
    function_652cb32b0791d63b();
}

// Namespace namespace_44e8cefed76aa88e
// Params 0
// Checksum 0xa110bd83, Offset: 0x2b7b
// Size: 0x4e
function function_652cb32b0791d63b()
{
    if ( isdefined( self.var_11133cb0607b498f.var_c248dbe32bfe6ad2.waypoint ) )
    {
        ftue_objectives::function_ecadaaabe4a83e9b( self.var_11133cb0607b498f.var_c248dbe32bfe6ad2.waypoint );
    }
    
    function_978a635698fb9bb1();
}

// Namespace namespace_44e8cefed76aa88e
// Params 0
// Checksum 0x5ac38d87, Offset: 0x2bd1
// Size: 0x120
function function_a08b4ff6b1683c15()
{
    self.var_11133cb0607b498f.var_bdcc1fed73c1b7fb.closedcash = undefined;
    
    while ( !isdefined( self.var_11133cb0607b498f.var_bdcc1fed73c1b7fb.closedcash ) )
    {
        params = spawnstruct();
        params.mindistance = 50;
        params.maxdistance = 700;
        namespace_727c07157c884ff5::function_5b93b34229d4622a( params );
        waitframe();
    }
    
    if ( isdefined( self.var_11133cb0607b498f.var_bdcc1fed73c1b7fb.closedcash ) )
    {
        waypointposition = self.var_11133cb0607b498f.var_bdcc1fed73c1b7fb.closedcash.origin + ( 0, 0, 1 );
        self.var_11133cb0607b498f.var_c248dbe32bfe6ad2.cashwaypoint = ftue_objectives::function_518a2916085fd4f8( waypointposition, &"ftue_mobile/pick_up", "icon_waypoint_objective_general", 15, self, 1 );
        childthread ftue_cash::function_e0f6f50293235438( &function_978a635698fb9bb1 );
    }
}

// Namespace namespace_44e8cefed76aa88e
// Params 0
// Checksum 0x2bebb2e7, Offset: 0x2cf9
// Size: 0x46
function function_978a635698fb9bb1()
{
    if ( self.var_11133cb0607b498f.var_c248dbe32bfe6ad2.cashwaypoint )
    {
        ftue_objectives::function_ecadaaabe4a83e9b( self.var_11133cb0607b498f.var_c248dbe32bfe6ad2.cashwaypoint );
    }
}

// Namespace namespace_44e8cefed76aa88e
// Params 0
// Checksum 0xeb0f00df, Offset: 0x2d47
// Size: 0xe1
function function_e8e0cd2122423b49()
{
    self.var_11133cb0607b498f.deadally endon( #"disconnect" );
    self endon( #"currentContextualTipCompleted" );
    self endon( #"currentContextualTipAborted" );
    self.var_11133cb0607b498f.currentbuystation = undefined;
    
    while ( !isdefined( self.var_11133cb0607b498f.currentbuystation ) )
    {
        namespace_727c07157c884ff5::function_4e28a5536a8acba2( 1500 );
        waitframe();
    }
    
    if ( isdefined( self.var_11133cb0607b498f.currentbuystation ) )
    {
        self.var_11133cb0607b498f.var_c248dbe32bfe6ad2.waypoint = ftue_objectives::function_518a2916085fd4f8( self.var_11133cb0607b498f.currentbuystation.origin, &"ftue_mobile/open", "icon_waypoint_objective_general", 40, self );
        childthread function_5340a0f3aa69154b();
    }
}

// Namespace namespace_44e8cefed76aa88e
// Params 0
// Checksum 0xc338d53e, Offset: 0x2e30
// Size: 0x13d
function function_5340a0f3aa69154b()
{
    self.var_11133cb0607b498f.deadally endon( #"disconnect" );
    self endon( #"currentContextualTipCompleted" );
    self endon( #"currentContextualTipAborted" );
    waypointenabled = 1;
    
    while ( isdefined( self.var_11133cb0607b498f.var_c248dbe32bfe6ad2.waypoint ) )
    {
        dist = distancesquared( self.origin, self.var_11133cb0607b498f.currentbuystation.origin );
        
        if ( dist <= 14400 && waypointenabled )
        {
            waypointenabled = 0;
            ftue_objectives::function_ecadaaabe4a83e9b( self.var_11133cb0607b498f.var_c248dbe32bfe6ad2.waypoint );
        }
        
        if ( dist >= 17280 && !waypointenabled )
        {
            waypointenabled = 1;
            self.var_11133cb0607b498f.var_c248dbe32bfe6ad2.waypoint = ftue_objectives::function_518a2916085fd4f8( self.var_11133cb0607b498f.currentbuystation.origin, &"ftue_mobile/open", "icon_waypoint_objective_general", 40, self );
        }
        
        waitframe();
    }
}

// Namespace namespace_44e8cefed76aa88e
// Params 0
// Checksum 0x1f0626f8, Offset: 0x2f75
// Size: 0x73
function function_9c608c0dcdddc9a7()
{
    self.var_11133cb0607b498f.var_cf82970e3c0a2bc6.notweapons[ 0 ] = "iw9_armor_plate_deploy_mp";
    self.var_11133cb0607b498f.var_cf82970e3c0a2bc6.notweapons[ 1 ] = "iw9_laser_large_ir_mp";
    self.var_11133cb0607b498f.var_cf82970e3c0a2bc6.notweapons[ 2 ] = "iw9_spotter_scope_mp";
}

// Namespace namespace_44e8cefed76aa88e
// Params 1
// Checksum 0x889e64a0, Offset: 0x2ff0
// Size: 0x24
function function_ba1f580e4af99c77( eventcondition )
{
    ftue_gulag::function_f7131f34eebc5cf1( &function_fcabacd1877fbbb0 );
    ftue_gulag::function_725d6f11db45df9( &function_61abd09e72592cae );
}

// Namespace namespace_44e8cefed76aa88e
// Params 0
// Checksum 0xccc9e7a, Offset: 0x301c
// Size: 0xe
function function_286d5db696ae8958()
{
    ftue_gulag::function_a271dc26dac2b2e8( &function_117db84cdc1d2adb );
}

// Namespace namespace_44e8cefed76aa88e
// Params 1
// Checksum 0xcb93e288, Offset: 0x3032
// Size: 0x18
function function_117db84cdc1d2adb( message )
{
    self notify( #"gulagFinished" );
}

// Namespace namespace_44e8cefed76aa88e
// Params 1
// Checksum 0x8716cd35, Offset: 0x3052
// Size: 0x18
function function_fcabacd1877fbbb0( var_c9b0d6a83e847963 )
{
    self notify( #"IsGulagStarted" );
}

// Namespace namespace_44e8cefed76aa88e
// Params 1
// Checksum 0xfc9973a6, Offset: 0x3072
// Size: 0x22
function function_61abd09e72592cae( var_c9b0d6a83e847963 )
{
    self.var_11133cb0607b498f.var_212fa58e67e8e5a9 = 1;
}

// Namespace namespace_44e8cefed76aa88e
// Params 1
// Checksum 0x1070e9e6, Offset: 0x309c
// Size: 0x18
function function_4ca6987da0b833f6( eventcondition )
{
    childthread ftue_enemy::function_ce599a01d4e10939( &function_a284c54d7902ee89 );
}

// Namespace namespace_44e8cefed76aa88e
// Params 0
// Checksum 0x7b2121ae, Offset: 0x30bc
// Size: 0xe
function function_a284c54d7902ee89()
{
    self notify( #"AreEnemiesInMinimap" );
}

// Namespace namespace_44e8cefed76aa88e
// Params 1
// Checksum 0x9af7e6a5, Offset: 0x30d2
// Size: 0x18
function function_e9f6e9ed11e0f19a( eventcondition )
{
    ftue_player::ftue_player_isplayershotbyenemy( &function_a7aa4fd13955ee3d );
}

// Namespace namespace_44e8cefed76aa88e
// Params 1
// Checksum 0x8e3c2be4, Offset: 0x30f2
// Size: 0x18
function function_a7aa4fd13955ee3d( eventcondition )
{
    self notify( #"IsPlayerShotByEnemy" );
}

// Namespace namespace_44e8cefed76aa88e
// Params 0
// Checksum 0xd6652a53, Offset: 0x3112
// Size: 0x15
function function_3a9798f980a93566()
{
    ftue_tip::function_953a5a3682bc5957();
    self notify( #"currentContextualTipAborted" );
}

/#

    // Namespace namespace_44e8cefed76aa88e
    // Params 1
    // Checksum 0x7286b469, Offset: 0x312f
    // Size: 0x6b, Type: dev
    function function_4030773d862a10c6( tipkey )
    {
        if ( !isdefined( tipkey ) )
        {
            return;
        }
        
        var_86b9c6f933af035a = getxhash( tipkey );
        
        if ( !isdefined( level.var_a0091bd8bb5fd717.contextualtips[ var_86b9c6f933af035a ] ) )
        {
            return;
        }
        
        level.players[ 0 ] function_3a9798f980a93566();
        level.players[ 0 ] function_5d5fef02540a4a39( var_86b9c6f933af035a );
    }

#/
