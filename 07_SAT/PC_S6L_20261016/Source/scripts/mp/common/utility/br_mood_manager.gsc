// scripts\mp\common\utility\br_mood_manager.gsc  (hash_737a4939d5e0cab9.gscc) (size: 16645 Bytes / 0x4105 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x33b328c (54211212)
// size ...... 16645 (0x4105)
// includes .. 6   (offset: 0x3f75)
// strings ... 8   (offset: 0x3fa5)
// dev strs .. 14  (offset: 0x4049)
// exports ... 43  (offset: 0x2a65)
// cseg ...... 0x13f + 0x2926 (0x2a65)
// imports ... 120 (offset: 0x311d)
// animtree1 . 0   (offset: 0x4105)
// animtree2 . 0   (offset: 0x4105)
#using scripts\common\devgui;
#using scripts\common\script;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\connect_event_aggregator;
#using scripts\mp\common\utility\rejoin_utility;

#namespace br_mood_manager;

// Namespace br_mood_manager
// Params 0, eflags: 0x5
// Checksum 0x1cb06489, Offset: 0x15d
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"mood", undefined, &function_ac067f4d72bb3e9c, undefined );
}

// Namespace br_mood_manager
// Params 0
// Checksum 0xb052d427, Offset: 0x17e
// Size: 0xb5
function function_ac067f4d72bb3e9c()
{
    if ( !function_f51188ec6e9c8aa9() )
    {
        return;
    }
    
    function_7c78f54e336550a7();
    moodset = getdvar( @"hash_814a58e4f810f2d8", "" );
    moodlist = getdvar( @"scr_br_moodlist_set", "" );
    
    if ( moodset != "" )
    {
        thread setup( moodset );
    }
    else if ( moodlist != "" )
    {
        thread init( moodlist );
    }
    
    utility::registersharedfunc( #"mood", #"hash_408d0ea08812995c", &setmood );
    utility::registersharedfunc( #"mood", #"hash_bbfd57d533279922", &function_bf459c78a80c2d59 );
}

// Namespace br_mood_manager
// Params 0
// Checksum 0x3a4d0ccc, Offset: 0x23b
// Size: 0x11
function function_f51188ec6e9c8aa9()
{
    return getdvarint( @"scr_br_mood_manager", 1 );
}

// Namespace br_mood_manager
// Params 0
// Checksum 0x84210c96, Offset: 0x255
// Size: 0xf8
function function_7c78f54e336550a7()
{
    if ( isdefined( level.moodmanager ) )
    {
        return;
    }
    
    level.moodmanager = spawnstruct();
    level.moodmanager.var_cc343d98e880aeab = getdvarint( @"hash_62d527faf49570ed", 0 );
    level.moodmanager.var_e3c0748df502aef0 = getdvarint( @"hash_37763c7311e5b8da", 256 );
    level.moodmanager.defaultsunintensity = getdvarfloat( @"hash_d1676be1e671f038", 0.306 );
    level.moodmanager.var_7750f007a6b7ef32 = getdvarfloat( @"hash_8eebbbe30d21a94a", 1 );
    level.moodmanager.var_f0823717a9745a32 = getdvarfloat( @"hash_64e3e719e88b3ffa", 0.922347 );
    level.moodmanager.var_a392964fa0b71627 = getdvarfloat( @"hash_2b9d51c935985eff", 0.870588 );
}

// Namespace br_mood_manager
// Params 1
// Checksum 0x28fd193, Offset: 0x355
// Size: 0x181
function init( moodlist )
{
    if ( !isdefined( moodlist ) || moodlist == "" )
    {
        return;
    }
    
    scriptbundle = getscriptbundle( hashcat( %"hash_2bbcecc836419d0b", moodlist ) );
    
    if ( !isdefined( scriptbundle ) )
    {
        return;
    }
    
    moodlist = scriptbundle.var_de53f2a3aaa742d3;
    
    if ( !isdefined( moodlist ) || moodlist.size == 0 )
    {
        return;
    }
    
    totalweight = 0;
    weightoverrides = strtok( getdvar( @"hash_8422039c51781bf1", "" ), " " );
    
    for ( k = 0; k < moodlist.size ; k++ )
    {
        if ( weightoverrides.size > 0 )
        {
            moodlist[ k ].weight = int( utility::function_e153375527829ec3( weightoverrides[ k ], 0 ) );
        }
        
        if ( !isdefined( moodlist[ k ].weight ) )
        {
            moodlist[ k ].weight = 0;
        }
        
        totalweight += moodlist[ k ].weight;
    }
    
    randomnumber = randomfloat( totalweight );
    cumulativeweight = 0;
    
    for ( i = 0; i < moodlist.size ; i++ )
    {
        nextweight = cumulativeweight + moodlist[ i ].weight;
        
        if ( nextweight > randomnumber )
        {
            chosenmood = moodlist[ i ];
            setup( chosenmood.moodset );
            return;
        }
        
        cumulativeweight = nextweight;
    }
}

// Namespace br_mood_manager
// Params 1
// Checksum 0x2da843d5, Offset: 0x4de
// Size: 0x189
function setup( moodset )
{
    if ( !isdefined( moodset ) || moodset == "" )
    {
        return;
    }
    
    scriptbundle = getscriptbundle( hashcat( %"hash_7d9482f6248686c3", moodset ) );
    
    if ( !isdefined( scriptbundle.moods ) || scriptbundle.moods.size == 0 )
    {
        return;
    }
    
    level.var_12b9bf87168a77e8 = [];
    level.moods = scriptbundle.moods;
    
    for ( i = 0; i < level.moods.size ; i++ )
    {
        if ( level.moods[ i ].state )
        {
            level.moods[ i ].state = getscriptbundle( hashcat( %"hash_6b3d349b362ec62", level.moods[ i ].state ) );
        }
    }
    
    initialmood = function_cd004a4b67ff71fc();
    
    if ( isdefined( initialmood ) && isdefined( initialmood.state ) )
    {
        level thread function_964750cdbf2c9b2e( initialmood );
    }
    
    level thread rejoincallback();
    
    if ( getdvarint( @"hash_826be4f15ac0748e", 1 ) == 1 )
    {
        level thread watchcircles();
        level thread watchtime();
    }
    
    level thread onsetupmoodset();
    
    if ( isdmzgamemode() )
    {
        level thread function_6112383182a2a4cc();
    }
    
    level thread overridedvars( scriptbundle.dvars );
    
    /#
        level thread debug_init();
    #/
}

// Namespace br_mood_manager
// Params 0
// Checksum 0xa0d4ff6a, Offset: 0x66f
// Size: 0x5a
function onsetupmoodset()
{
    level endon( #"game_ended" );
    level waittill( #"hash_d4f457172265279c" );
    
    if ( utility::issharedfuncdefined( #"mood", #"onsetupmoodset" ) )
    {
        [[ utility::getsharedfunc( #"mood", #"onsetupmoodset" ) ]]( level.moods );
    }
}

// Namespace br_mood_manager
// Params 1
// Checksum 0x91bc96d2, Offset: 0x6d1
// Size: 0x19e
function setmood( mood )
{
    if ( !isdefined( mood.state ) )
    {
        return;
    }
    
    if ( level.moodmanager.currentmood.transitiontype == "circles" && mood.transitiontype == "circles" )
    {
        circleindexa = mood.circleindex ?? 0;
        circleindexb = level.moodmanager.currentmood.circleindex ?? 0;
        
        if ( circleindexa == circleindexb )
        {
            return;
        }
    }
    
    level.moodmanager.oldmood = level.moodmanager.currentmood;
    level.moodmanager.currentmood = mood;
    
    if ( getdvarint( @"hash_9e046b4cbe0b3242", -1 ) > -1 )
    {
        level.moodmanager.currentmood.transitiontime = getdvarint( @"hash_9e046b4cbe0b3242" );
    }
    
    level thread function_639be4c7ffba1794();
    level function_de5e08deeaf7f9db();
    level function_3535e8726e6a2afc();
    level thread function_7ffaee0d0102641a();
    level thread function_6e07e5e1698d1e17();
    level thread function_ff93ee945347dff();
    
    if ( utility::issharedfuncdefined( #"mood", #"onsetmood" ) )
    {
        [[ utility::getsharedfunc( #"mood", #"onsetmood" ) ]]( mood, level.moodmanager.oldmood );
    }
}

// Namespace br_mood_manager
// Params 2
// Checksum 0x90fe31ce, Offset: 0x877
// Size: 0x1da
function function_bf459c78a80c2d59( player, mood )
{
    if ( !isplayer( player ) || !isdefined( mood.state ) )
    {
        return;
    }
    
    if ( !isdefined( player.moodmanager ) )
    {
        player.moodmanager = {};
    }
    
    if ( !isdefined( player.moodmanager.currentmood ) )
    {
        player.moodmanager.currentmood = level.moodmanager.currentmood;
    }
    
    if ( player.moodmanager.currentmood.transitiontype == "circles" && mood.transitiontype == "circles" )
    {
        circleindexa = mood.circleindex ?? 0;
        circleindexb = player.moodmanager.currentmood.circleindex ?? 0;
        
        if ( circleindexa == circleindexb )
        {
            return;
        }
    }
    
    player.moodmanager.oldmood = player.moodmanager.currentmood;
    player.moodmanager.currentmood = mood;
    player thread function_639be4c7ffba1794();
    player function_de5e08deeaf7f9db( 0 );
    player function_3535e8726e6a2afc( 0 );
    player thread function_7ffaee0d0102641a();
    player thread function_6e07e5e1698d1e17();
    player thread function_ff93ee945347dff( 0 );
    
    if ( utility::issharedfuncdefined( #"mood", #"hash_5fcb261d318a7b2e" ) )
    {
        [[ utility::getsharedfunc( #"mood", #"hash_5fcb261d318a7b2e" ) ]]( player, mood, player.oldmood );
    }
}

// Namespace br_mood_manager
// Params 0
// Checksum 0x9753aeb8, Offset: 0xa59
// Size: 0x69
function switchvisionsets()
{
    suffix = self.moodmanager.currentmood.state.visionsetsuffix ?? "";
    duration = function_ca4aaf7543a9afe();
    
    if ( isplayer( self ) )
    {
        self function_193fd33c1d11be88( duration, suffix );
        return;
    }
    
    replacevisionset( duration, suffix );
}

// Namespace br_mood_manager
// Params 0
// Checksum 0x2a076b73, Offset: 0xaca
// Size: 0x4e8
function handlepbg()
{
    bank = self.moodmanager.currentmood.state.scriptbank;
    index = self.moodmanager.currentmood.state.scriptindex;
    lightstate = self.moodmanager.currentmood.state.lightstate;
    lightstateweights = self.moodmanager.currentmood.state.lightstateweights;
    
    if ( self.moodmanager.currentmood.state.var_b20df9b0702fd709 )
    {
        lightstateweights = [ self.moodmanager.currentmood.state.var_6ad9ff16d468b84a ?? 0, self.moodmanager.currentmood.state.var_fa31499c8a4fd6eb ?? 0, self.moodmanager.currentmood.state.var_4760544fa9c8d42c ?? 0, self.moodmanager.currentmood.state.var_82c5373cf4ba88bd ?? 0, self.moodmanager.currentmood.state.var_a125f5b469a5761e ?? 0, self.moodmanager.currentmood.state.var_3877086e9eb9a95f ?? 0, self.moodmanager.currentmood.state.var_1c1688d038e0ef70 ?? 0, self.moodmanager.currentmood.state.var_99b2062277aa8fc1 ?? 0 ];
    }
    
    duration = function_ca4aaf7543a9afe();
    clientnum = isplayer( self ) ? self getplayerclientnum() : undefined;
    
    if ( bank > 0 && bank <= 8 )
    {
        if ( isdefined( clientnum ) )
        {
            function_ad915db840c90fb3( 1023, bank, duration, undefined, self );
        }
        else
        {
            function_ad915db840c90fb3( 1023, bank, duration );
        }
    }
    
    if ( index > 0 && index <= 32 )
    {
        function_5c5a58d4d56c8f25( 1023, index, 1, duration, clientnum );
    }
    else if ( index == 0 )
    {
        function_5c5a58d4d56c8f25( 1023, index, 0, duration, clientnum );
    }
    
    if ( lightstateweights.size == 8 )
    {
        function_957b0668cfe50a27( 1023, lightstateweights[ 0 ], lightstateweights[ 1 ], lightstateweights[ 2 ], lightstateweights[ 3 ], lightstateweights[ 4 ], lightstateweights[ 5 ], lightstateweights[ 6 ], lightstateweights[ 7 ], duration, clientnum );
    }
    else if ( lightstate > 0 )
    {
        function_7aee8a80a20e0ab4( 1023, lightstate, duration, clientnum );
    }
    
    if ( isplayer( self ) )
    {
        if ( isdefined( self.moodmanager.oldmood.state.postfxbundle ) )
        {
            pbgpostfxbundleend( self, self.moodmanager.oldmood.state.postfxbundle );
        }
        
        if ( isdefined( self.moodmanager.currentmood.state.postfxbundle ) )
        {
            pbgpostfxbundlestart( self, self.moodmanager.currentmood.state.postfxbundle );
        }
        
        return;
    }
    
    if ( isdefined( level.moodmanager.oldmood.state.postfxbundle ) )
    {
        pbgpostfxbundleend( #"all", level.moodmanager.oldmood.state.postfxbundle );
    }
    
    if ( isdefined( level.moodmanager.currentmood.state.postfxbundle ) )
    {
        pbgpostfxbundlestart( #"all", level.moodmanager.currentmood.state.postfxbundle );
    }
}

// Namespace br_mood_manager
// Params 0
// Checksum 0xd97134bd, Offset: 0xfba
// Size: 0x6a
function function_639be4c7ffba1794()
{
    mood = self.moodmanager.currentmood;
    
    switch ( mood.state.var_2505db218d1cc06a )
    {
        case #"hash_8937406c51be4990":
            thread handlepbg();
            break;
        case #"hash_4bbfcf4e978d515f":
            thread switchvisionsets();
            break;
    }
}

// Namespace br_mood_manager
// Params 1
// Checksum 0x18486ff, Offset: 0x102c
// Size: 0x9e
function function_964750cdbf2c9b2e( mood )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( mood.state ) )
    {
        return;
    }
    
    connect_event_aggregator::registeronconnectcallback( &function_a880fe6fadddbac7 );
    level.moodmanager.currentmood = mood;
    level thread function_7ffaee0d0102641a();
    level thread function_6e07e5e1698d1e17( 1 );
    level thread function_639be4c7ffba1794();
    
    if ( utility::issharedfuncdefined( #"mood", #"onsetmood" ) )
    {
        [[ utility::getsharedfunc( #"mood", #"onsetmood" ) ]]( mood, undefined );
    }
}

// Namespace br_mood_manager
// Params 0
// Checksum 0xf4020444, Offset: 0x10d2
// Size: 0x1b
function rejoincallback()
{
    level utility::flag_wait( "StartGameTypeCallbackFinished" );
    rejoin_utility::function_70467cdf042579e5( &onrejoin );
}

// Namespace br_mood_manager
// Params 1
// Checksum 0xf254eff2, Offset: 0x10f5
// Size: 0x16
function onrejoin( player )
{
    player function_a880fe6fadddbac7( 0 );
}

// Namespace br_mood_manager
// Params 1
// Checksum 0xf54c4088, Offset: 0x1113
// Size: 0x31
function function_a880fe6fadddbac7( waittillspawned )
{
    self.moodmanager = {};
    thread function_de5e08deeaf7f9db( waittillspawned );
    thread function_3535e8726e6a2afc( waittillspawned );
    thread function_ff93ee945347dff( waittillspawned );
}

// Namespace br_mood_manager
// Params 0
// Checksum 0x357be7ba, Offset: 0x114c
// Size: 0x5d
function watchcircles()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"br_circle_set" );
        newmood = function_6dda56b16765f725( level.br_circle.circleindex );
        
        if ( isdefined( newmood ) )
        {
            setmood( newmood );
            continue;
        }
        
        continue;
    }
}

// Namespace br_mood_manager
// Params 0
// Checksum 0xa0247939, Offset: 0x11b1
// Size: 0xca
function watchtime()
{
    level endon( #"game_ended" );
    level waittill( #"prematch_fade_done" );
    
    if ( !isdefined( level.starttime ) )
    {
        level.starttime = gettime();
    }
    
    waittime = 60;
    newmood = undefined;
    var_1e9447da91469c37 = 1;
    
    if ( isdmzgamemode() )
    {
        var_1e9447da91469c37 = 0;
    }
    
    while ( true )
    {
        if ( isdefined( newmood ) )
        {
            setmood( newmood );
            newmood = undefined;
            waittime = 60;
            continue;
        }
        else
        {
            newmood = function_ba6b6822605f18c0( waittime, var_1e9447da91469c37 );
            var_1e9447da91469c37 = 0;
        }
        
        if ( isdefined( newmood ) )
        {
            waittime = newmood.starttime * 60 - ( gettime() - level.starttime ) / 1000;
            waittime = max( waittime, 0 );
        }
        
        wait waittime;
    }
}

// Namespace br_mood_manager
// Params 1
// Checksum 0x774f12ad, Offset: 0x1283
// Size: 0xd2
function function_6dda56b16765f725( index )
{
    foreach ( mood in level.moods )
    {
        if ( mood.transitiontype != "circles" )
        {
            continue;
        }
        
        if ( !isdefined( mood.circleindex ) )
        {
            if ( index == 0 )
            {
                mood.circleindex = index;
                return mood;
            }
            
            continue;
        }
        
        if ( mood.circleindex == index )
        {
            return mood;
        }
    }
}

// Namespace br_mood_manager
// Params 2
// Checksum 0x93711b9c, Offset: 0x135e
// Size: 0x13f
function function_ba6b6822605f18c0( timedelta, var_1e9447da91469c37 )
{
    if ( isdmzgamemode() )
    {
        if ( !isdefined( level.starttime ) )
        {
            level.starttime = gettime();
        }
    }
    
    currenttime = gettime() - level.starttime;
    currenttime *= 0.001;
    
    foreach ( mood in level.moods )
    {
        if ( mood.transitiontype != "time" )
        {
            continue;
        }
        
        if ( !isdefined( mood.starttime ) )
        {
            mood.starttime = 0;
        }
        
        if ( var_1e9447da91469c37 && mood.starttime == 0 )
        {
            return mood;
        }
        
        moodtime = mood.starttime * 60;
        
        if ( moodtime > currenttime && moodtime - currenttime <= timedelta )
        {
            return mood;
        }
    }
}

// Namespace br_mood_manager
// Params 1
// Checksum 0x70850fb2, Offset: 0x14a6
// Size: 0x81
function function_de5e08deeaf7f9db( waittillspawned = 1 )
{
    exploders = self.moodmanager.currentmood.state.exploders;
    
    if ( !isdefined( exploders ) || exploders.size == 0 )
    {
        return;
    }
    
    for ( i = 0; i < exploders.size ; i++ )
    {
        exploders[ i ] thread handleexploder( i, self, waittillspawned );
    }
}

// Namespace br_mood_manager
// Params 3
// Checksum 0x2c259968, Offset: 0x152f
// Size: 0x19d
function handleexploder( index, var_426ef0b7b90aefcc, waittillspawned )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    explodersdelay = var_426ef0b7b90aefcc.moodmanager.currentmood.explodersdelay;
    
    if ( isdefined( explodersdelay[ index ] ) && isdefined( explodersdelay[ index ].delay ) && explodersdelay.size > 0 )
    {
        delay = explodersdelay[ index ].delay;
        
        /#
            if ( level.moodmanager.var_4fbdbd14d38f325a )
            {
                delay = 0;
            }
        #/
        
        wait delay;
    }
    
    if ( !isdefined( var_426ef0b7b90aefcc ) )
    {
        return;
    }
    
    if ( self.active )
    {
        if ( isdefined( level.var_12b9bf87168a77e8 ) && level.var_12b9bf87168a77e8[ self.name ] )
        {
            return;
        }
        
        if ( isplayer( var_426ef0b7b90aefcc ) )
        {
            if ( waittillspawned )
            {
                var_426ef0b7b90aefcc waittill( #"spawned_player" );
            }
            
            activateclientexploder( self.name, var_426ef0b7b90aefcc, gettime(), level.moodmanager.var_e3c0748df502aef0 );
        }
        else
        {
            activateclientexploder( self.name, level.players, gettime(), level.moodmanager.var_e3c0748df502aef0 );
            level.var_12b9bf87168a77e8[ self.name ] = 1;
        }
        
        return;
    }
    
    stopclientexploder( self.name );
    level.var_12b9bf87168a77e8[ self.name ] = undefined;
}

// Namespace br_mood_manager
// Params 0
// Checksum 0x44cc31e7, Offset: 0x16d4
// Size: 0xbc
function function_57a65e4a46e01044()
{
    exploders = level.moodmanager.currentmood.state.exploders;
    
    if ( !isdefined( exploders ) || exploders.size == 0 )
    {
        return;
    }
    
    if ( !isdefined( level.var_12b9bf87168a77e8 ) )
    {
        level.var_12b9bf87168a77e8 = [];
    }
    
    for ( i = 0; i < exploders.size ; i++ )
    {
        if ( exploders[ i ].active )
        {
            level.var_12b9bf87168a77e8[ exploders[ i ].name ] = 1;
            continue;
        }
        
        level.var_12b9bf87168a77e8[ exploders[ i ].name ] = undefined;
    }
}

// Namespace br_mood_manager
// Params 1
// Checksum 0x6735f23e, Offset: 0x1798
// Size: 0x81
function function_3535e8726e6a2afc( waittillspawned = 1 )
{
    soundeffects = self.moodmanager.currentmood.state.soundeffects;
    
    if ( !isdefined( soundeffects ) || soundeffects.size == 0 )
    {
        return;
    }
    
    for ( i = 0; i < soundeffects.size ; i++ )
    {
        soundeffects[ i ] thread function_1583ccb36c170262( i, self, waittillspawned );
    }
}

// Namespace br_mood_manager
// Params 3
// Checksum 0xdb6202cb, Offset: 0x1821
// Size: 0x10a
function function_1583ccb36c170262( index, var_426ef0b7b90aefcc, waittillspawned )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    id = self.id ?? "";
    state = self.state ?? "";
    fadetime = 10;
    fadetimes = var_426ef0b7b90aefcc.moodmanager.currentmood.var_3fd63b24b9a5e20f;
    
    if ( isdefined( fadetimes[ index ] ) )
    {
        fadetime = fadetimes[ index ].fadetime ?? fadetime;
    }
    
    /#
        if ( level.moodmanager.var_4fbdbd14d38f325a )
        {
            fadetime = 0;
        }
    #/
    
    if ( isplayer( var_426ef0b7b90aefcc ) )
    {
        if ( waittillspawned )
        {
            var_426ef0b7b90aefcc waittill( #"spawned_player" );
        }
        
        setaudiotriggerstate( id, state, fadetime, var_426ef0b7b90aefcc );
        return;
    }
    
    setaudiotriggerstate( id, state, fadetime );
}

// Namespace br_mood_manager
// Params 1
// Checksum 0xfd4beac3, Offset: 0x1933
// Size: 0x10a
function function_ff93ee945347dff( waittillspawned = 1 )
{
    changes = self.moodmanager.currentmood.state.var_71bd09b8435b6192;
    
    if ( !isdefined( changes ) || changes.size == 0 )
    {
        return;
    }
    
    players = isplayer( self ) ? [ self ] : level.players;
    
    foreach ( player in players )
    {
        for ( i = 0; i < changes.size ; i++ )
        {
            changes[ i ] thread function_f00da0af9633e79f( player, waittillspawned );
        }
    }
}

// Namespace br_mood_manager
// Params 2
// Checksum 0x9be76fe, Offset: 0x1a45
// Size: 0x41
function function_f00da0af9633e79f( player, waittillspawned )
{
    if ( waittillspawned )
    {
        player waittill( #"spawned_player" );
    }
    
    player setscriptablepartstate( self.part, self.state );
}

// Namespace br_mood_manager
// Params 2
// Checksum 0x5a514953, Offset: 0x1a8e
// Size: 0x201
function function_7ffaee0d0102641a( var_3d637d32396a2f2d, duration )
{
    self notify( #"hash_a859194f9048eb10" );
    self endon( #"hash_a859194f9048eb10" );
    level endon( #"game_ended" );
    
    if ( self.moodmanager.currentmood.transitiontype == "circles" && self.moodmanager.currentmood.circleindex == -1 && !level.moodmanager.debugtransition )
    {
        level waittill( #"prematch_fade_done" );
        prematch = 1;
    }
    
    if ( !isdefined( var_3d637d32396a2f2d ) )
    {
        var_3d637d32396a2f2d = self.moodmanager.currentmood.state.sunlight;
    }
    
    if ( !isdefined( var_3d637d32396a2f2d ) )
    {
        return;
    }
    
    sunlight = [];
    
    if ( var_3d637d32396a2f2d.color )
    {
        tokens = strtok( var_3d637d32396a2f2d.color, " " );
        red = float( tokens[ 0 ] );
        green = float( tokens[ 1 ] );
        blue = float( tokens[ 2 ] );
        
        if ( red != 0 )
        {
            sunlight[ sunlight.size ] = red;
        }
        
        if ( green != 0 || sunlight.size > 0 )
        {
            if ( sunlight.size == 0 )
            {
                sunlight[ sunlight.size ] = 0;
            }
            
            sunlight[ sunlight.size ] = green;
        }
        
        if ( blue != 0 || sunlight.size > 0 )
        {
            if ( sunlight.size == 0 )
            {
                sunlight[ sunlight.size ] = 0;
                sunlight[ sunlight.size ] = 0;
            }
            
            sunlight[ sunlight.size ] = blue;
        }
    }
    
    sunlight[ sunlight.size ] = var_3d637d32396a2f2d.intensity;
    
    if ( !isdefined( duration ) )
    {
        duration = function_ca4aaf7543a9afe();
    }
    
    if ( prematch )
    {
        duration = 0;
    }
    
    thread function_d846297e8800b60d( sunlight, duration );
}

// Namespace br_mood_manager
// Params 2
// Checksum 0x835cdbc3, Offset: 0x1c97
// Size: 0x2ce
function function_d846297e8800b60d( final, time )
{
    self notify( #"hash_b02b51c2339dd101" );
    self endon( #"hash_b02b51c2339dd101" );
    level endon( #"game_ended" );
    
    if ( !isdefined( final ) )
    {
        return;
    }
    
    if ( isplayer( self ) )
    {
        self endon( #"disconnect" );
    }
    
    /#
        if ( level.moodmanager.var_4fbdbd14d38f325a )
        {
            time = 0;
        }
    #/
    
    changecolor = isdefined( final[ 0 ] ) && isdefined( final[ 1 ] ) && isdefined( final[ 2 ] );
    changeintensity = isdefined( final[ 3 ] ) || isdefined( final[ 0 ] ) && !changecolor;
    
    if ( !changecolor && !changeintensity )
    {
        return;
    }
    
    if ( !isdefined( self.moodmanager.var_2831d21dd1736ee ) )
    {
        self.moodmanager.var_2831d21dd1736ee = [];
    }
    
    initial = [];
    
    if ( changecolor )
    {
        initial[ 0 ] = self.moodmanager.var_2831d21dd1736ee[ 0 ] ?? level.moodmanager.var_7750f007a6b7ef32;
        initial[ 1 ] = self.moodmanager.var_2831d21dd1736ee[ 1 ] ?? level.moodmanager.var_f0823717a9745a32;
        initial[ 2 ] = self.moodmanager.var_2831d21dd1736ee[ 2 ] ?? level.moodmanager.var_a392964fa0b71627;
    }
    
    if ( changeintensity )
    {
        if ( changecolor )
        {
            index = 3;
        }
        else
        {
            index = 0;
        }
        
        initial[ index ] = self.moodmanager.var_2831d21dd1736ee[ 3 ] ?? level.moodmanager.defaultsunintensity;
    }
    
    if ( time > 0 )
    {
        range = [];
        
        for ( i = 0; i < final.size ; i++ )
        {
            if ( isdefined( final[ i ] ) && isdefined( initial[ i ] ) )
            {
                range[ i ] = final[ i ] - initial[ i ];
            }
        }
        
        next = initial;
        interval = 0.25;
        count = int( time / interval );
        
        if ( count > 0 )
        {
            delta = [];
            
            for ( i = 0; i < range.size ; i++ )
            {
                if ( isdefined( range[ i ] ) )
                {
                    delta[ i ] = range[ i ] / count;
                }
            }
            
            while ( count )
            {
                for ( i = 0; i < delta.size ; i++ )
                {
                    if ( isdefined( delta[ i ] ) )
                    {
                        next[ i ] += delta[ i ];
                    }
                }
                
                function_c78d9f144ef2e001( changecolor, changeintensity, next );
                wait interval;
                count--;
            }
        }
    }
    
    function_c78d9f144ef2e001( changecolor, changeintensity, final );
}

// Namespace br_mood_manager
// Params 3
// Checksum 0x840c5131, Offset: 0x1f6d
// Size: 0x18f
function function_c78d9f144ef2e001( var_4478dc1d6cecfa25, var_879e0df3d81639cf, sundata )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( var_4478dc1d6cecfa25 && var_879e0df3d81639cf )
    {
        if ( isplayer( self ) )
        {
            self function_b9142e9874ec1be9( sundata[ 0 ], sundata[ 1 ], sundata[ 2 ], sundata[ 3 ] );
        }
        else
        {
            setsuncolorandintensity( sundata[ 0 ], sundata[ 1 ], sundata[ 2 ], sundata[ 3 ] );
        }
        
        self.moodmanager.var_2831d21dd1736ee[ 0 ] = sundata[ 0 ];
        self.moodmanager.var_2831d21dd1736ee[ 1 ] = sundata[ 1 ];
        self.moodmanager.var_2831d21dd1736ee[ 2 ] = sundata[ 2 ];
        self.moodmanager.var_2831d21dd1736ee[ 3 ] = sundata[ 3 ];
        return;
    }
    
    if ( var_4478dc1d6cecfa25 )
    {
        if ( isplayer( self ) )
        {
            self function_b9142e9874ec1be9( sundata[ 0 ], sundata[ 1 ], sundata[ 2 ] );
        }
        else
        {
            setsuncolorandintensity( sundata[ 0 ], sundata[ 1 ], sundata[ 2 ] );
        }
        
        self.moodmanager.var_2831d21dd1736ee[ 0 ] = sundata[ 0 ];
        self.moodmanager.var_2831d21dd1736ee[ 1 ] = sundata[ 1 ];
        self.moodmanager.var_2831d21dd1736ee[ 2 ] = sundata[ 2 ];
        return;
    }
    
    if ( var_879e0df3d81639cf )
    {
        if ( isplayer( self ) )
        {
            self function_b9142e9874ec1be9( sundata[ 0 ] );
        }
        else
        {
            setsuncolorandintensity( sundata[ 0 ] );
        }
        
        self.moodmanager.var_2831d21dd1736ee[ 3 ] = sundata[ 0 ];
    }
}

// Namespace br_mood_manager
// Params 1
// Checksum 0x44cedb47, Offset: 0x2104
// Size: 0x24a
function function_6e07e5e1698d1e17( prematch )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( self.moodmanager.currentmood.state.configuration ) || self.moodmanager.currentmood.state.configuration == "" )
    {
        return;
    }
    
    if ( isdefined( self.moodmanager.currentmood.var_2e53a8970a361140 ) )
    {
        delay = self.moodmanager.currentmood.var_2e53a8970a361140;
        
        /#
            if ( level.moodmanager.var_4fbdbd14d38f325a )
            {
                delay = 0;
            }
        #/
        
        wait delay;
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    duration = 0;
    
    if ( prematch )
    {
        duration = 100;
    }
    else if ( level.moodmanager.var_cc343d98e880aeab > 0 )
    {
        duration = level.moodmanager.var_cc343d98e880aeab * 1000;
    }
    else
    {
        duration = function_ca4aaf7543a9afe();
        duration *= 1000;
    }
    
    /#
        if ( level.moodmanager.var_4fbdbd14d38f325a )
        {
            duration = 0;
        }
    #/
    
    if ( isplayer( self ) )
    {
        if ( isdefined( self.var_4ed02e5599c2bc8 ) )
        {
            self function_72cf2eee8e035013( self.var_4ed02e5599c2bc8 );
        }
        
        self function_cfc82469cc424810( self.moodmanager.currentmood.state.configuration, int( max( 1, duration ) ), "MIDDLE" );
    }
    else
    {
        if ( isdefined( self.var_4ed02e5599c2bc8 ) )
        {
            hwconfiguratorremoveasset( self.var_4ed02e5599c2bc8 );
        }
        
        function_592878987c62a1a9( self.moodmanager.currentmood.state.configuration, int( max( 1, duration ) ), "MIDDLE" );
    }
    
    self.var_4ed02e5599c2bc8 = self.moodmanager.currentmood.state.configuration;
}

// Namespace br_mood_manager
// Params 0
// Checksum 0xc02b1c0, Offset: 0x2356
// Size: 0x30
function function_cd004a4b67ff71fc()
{
    initialmood = undefined;
    
    if ( isdmzgamemode() )
    {
        initialmood = function_ba6b6822605f18c0( 0, 1 );
    }
    else
    {
        initialmood = function_6dda56b16765f725( -1 );
    }
    
    return initialmood;
}

// Namespace br_mood_manager
// Params 0
// Checksum 0x358346b4, Offset: 0x238f
// Size: 0x22
function function_6112383182a2a4cc()
{
    level endon( #"game_ended" );
    level waittill( #"prematch_fade_done" );
    function_57a65e4a46e01044();
}

// Namespace br_mood_manager
// Params 1
// Checksum 0x1fb71805, Offset: 0x23b9
// Size: 0x131
function overridedvars( dvars )
{
    if ( getdvarint( @"hash_ad3c6321de2d697f", 1 ) <= 0 )
    {
        return;
    }
    
    if ( !isdefined( dvars ) || dvars.size == 0 )
    {
        return;
    }
    
    foreach ( dvar in dvars )
    {
        if ( isdefined( dvar ) && isdefined( dvar.name ) && isdefined( dvar.value ) )
        {
            if ( isdvardefined( dvar.name ) )
            {
                setdvar( dvar.name, dvar.value );
                continue;
            }
            
            dvarname = getxhashhexname( dvar.name );
            
            /#
                dvarname = getxhashsourcename( dvar.name );
            #/
            
            script::demoforcesre( "Trying to override an undefined dvar \"" + dvarname + "\". The dvar must either be defined in a playlist, .cfg file or through command line arguments." );
        }
    }
}

// Namespace br_mood_manager
// Params 0
// Checksum 0x9f10eae0, Offset: 0x24f2
// Size: 0x5d
function function_ca4aaf7543a9afe()
{
    /#
        if ( level.moodmanager.var_4fbdbd14d38f325a )
        {
            return 0;
        }
    #/
    
    mood = self.moodmanager.currentmood;
    
    if ( mood.transitiontime > 0 )
    {
        return mood.transitiontime;
    }
    
    return 0;
}

/#

    // Namespace br_mood_manager
    // Params 0
    // Checksum 0x3fea01aa, Offset: 0x2557
    // Size: 0xc, Type: dev
    function debug_init()
    {
        devgui_init();
    }

    // Namespace br_mood_manager
    // Params 0
    // Checksum 0x5b6c8da1, Offset: 0x256b
    // Size: 0x1c0, Type: dev
    function devgui_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x35>", "<dev string:x3f>", &function_2cf977cefe276c88 );
        devgui::add_devgui_func( "<dev string:x49>", "<dev string:x68>", &function_e7475ca139958afe );
        devgui::add_devgui_func( "<dev string:x78>", "<dev string:x90>", &function_98f25536a53894b3 );
        devgui::function_77df7fe7dd273e10();
        
        for ( i = 0; i < level.moods.size ; i++ )
        {
            if ( isdefined( level.moods[ i ].state ) && isdefined( level.moods[ i ].state.visionsetsuffix ) && level.moods[ i ].state.visionsetsuffix != "<dev string:xa4>" && level.moods[ i ].state.var_2505db218d1cc06a == "<dev string:xa5>" )
            {
                moodname = level.moods[ i ].state.visionsetsuffix;
            }
            else
            {
                moodname = i;
            }
            
            devgui::function_9082edeb5db93280( "<dev string:xaf>" + moodname );
            devgui::function_77df7fe7dd273e10();
            devgui::function_9082edeb5db93280( "<dev string:xaf>" + moodname + "<dev string:xc5>" );
            devgui::function_cd4e263c1f3018ae( "<dev string:xa4>", "<dev string:xd8>" + i, &function_2ac2895b48715c00 );
            devgui::function_77df7fe7dd273e10();
            devgui::function_9082edeb5db93280( "<dev string:xaf>" + moodname + "<dev string:xf0>" );
            devgui::function_cd4e263c1f3018ae( "<dev string:xa4>", "<dev string:x104>" + i, &function_65e17f332fc5e41a );
            devgui::function_77df7fe7dd273e10();
        }
    }

    // Namespace br_mood_manager
    // Params 1
    // Checksum 0xe49d675f, Offset: 0x2733
    // Size: 0x60, Type: dev
    function function_2ac2895b48715c00( params )
    {
        index = int( params[ 0 ] );
        level.moodmanager.debugtransition = 1;
        setmood( level.moods[ index ] );
        level.moodmanager.debugtransition = 0;
    }

    // Namespace br_mood_manager
    // Params 1
    // Checksum 0xf5507988, Offset: 0x279b
    // Size: 0x8b, Type: dev
    function function_65e17f332fc5e41a( params )
    {
        level.moodmanager.var_4fbdbd14d38f325a = 1;
        level.moodmanager.debugtransition = 1;
        index = int( params[ 0 ] );
        setmood( level.moods[ index ] );
        level.moodmanager.var_4fbdbd14d38f325a = 0;
        level.moodmanager.debugtransition = 0;
    }

    // Namespace br_mood_manager
    // Params 0
    // Checksum 0x6ec0ac50, Offset: 0x282e
    // Size: 0x12c, Type: dev
    function function_2cf977cefe276c88()
    {
        if ( !isdefined( level.moodmanager.var_2831d21dd1736ee ) )
        {
            return;
        }
        
        final = level.moodmanager.var_2831d21dd1736ee;
        resetcolor = isdefined( final[ 0 ] ) && isdefined( final[ 1 ] ) && isdefined( final[ 2 ] );
        resetintensity = isdefined( final[ 3 ] );
        
        if ( resetcolor && resetintensity )
        {
            setsuncolorandintensity( level.moodmanager.var_7750f007a6b7ef32, level.moodmanager.var_f0823717a9745a32, level.moodmanager.var_a392964fa0b71627, level.moodmanager.defaultsunintensity );
            return;
        }
        
        if ( resetcolor )
        {
            setsuncolorandintensity( level.moodmanager.var_7750f007a6b7ef32, level.moodmanager.var_f0823717a9745a32, level.moodmanager.var_a392964fa0b71627 );
            return;
        }
        
        if ( resetintensity )
        {
            setsuncolorandintensity( level.moodmanager.defaultsunintensity );
        }
    }

    // Namespace br_mood_manager
    // Params 0
    // Checksum 0xadd9b76d, Offset: 0x2962
    // Size: 0x3a, Type: dev
    function function_e7475ca139958afe()
    {
        replacevisionset( 0, "<dev string:xa4>" );
        
        if ( isdefined( level.moodmanager.currentmood ) )
        {
            level.moodmanager.currentmood = undefined;
        }
    }

    // Namespace br_mood_manager
    // Params 0
    // Checksum 0x458f539e, Offset: 0x29a4
    // Size: 0xc1, Type: dev
    function function_98f25536a53894b3()
    {
        function_2cf977cefe276c88();
        function_e7475ca139958afe();
        function_19ffd6b727e8cba2();
        
        if ( isdefined( level.var_12b9bf87168a77e8 ) )
        {
            foreach ( explodername, active in level.var_12b9bf87168a77e8 )
            {
                if ( level.var_12b9bf87168a77e8[ explodername ] )
                {
                    stopclientexploder( explodername );
                    level.var_12b9bf87168a77e8[ explodername ] = undefined;
                }
            }
            
            level.var_12b9bf87168a77e8 = undefined;
        }
    }

#/
