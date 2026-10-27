// scripts\mp\potg.gsc  (hash_71cdf59d18e9f382.gscc) (size: 43610 Bytes / 0xaa5a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7f436a5d (2135124573)
// size ...... 43610 (0xaa5a)
// includes .. 11  (offset: 0x9c7e)
// strings ... 178 (offset: 0x9cd6)
// dev strs .. 69  (offset: 0xa65a)
// exports ... 117 (offset: 0x701e)
// cseg ...... 0x10e1 + 0x5f3d (0x701e)
// imports ... 193 (offset: 0x8266)
// animtree1 . 0   (offset: 0xaa5a)
// animtree2 . 0   (offset: 0xaa5a)
#using scripts\common\utility;
#using scripts\mp\action_park_utility;
#using scripts\mp\common\utility\disconnect_event_aggregator;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\streamhint;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\equipment;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\hud_message;
#using scripts\mp\potg_events;

#namespace potg;

/#

    // Namespace potg
    // Params 4, eflags: 0x4
    // Checksum 0x4e9a9373, Offset: 0x10ff
    // Size: 0xcf, Type: dev
    function private potg_debugprint( tag, severity, msg, throttlems )
    {
        if ( !getdvarint( @"scr_potg_debug", 0 ) )
        {
            return;
        }
        
        if ( isdefined( throttlems ) )
        {
            if ( !isdefined( level.var_691c6259f18e695d ) )
            {
                level.var_691c6259f18e695d = [];
            }
            
            tagkey = "<dev string:x24>" + tag;
            lastlog = level.var_691c6259f18e695d[ tagkey ];
            
            if ( !isdefined( lastlog ) )
            {
                lastlog = 0;
            }
            
            nowms = gettime();
            
            if ( nowms - lastlog < throttlems )
            {
                return;
            }
            
            level.var_691c6259f18e695d[ tagkey ] = nowms;
        }
        
        println( severity + "<dev string:x2a>" + tag + "<dev string:x31>" + msg );
    }

#/

// Namespace potg
// Params 0
// Checksum 0x9603a894, Offset: 0x11d6
// Size: 0x4ad
function init()
{
    if ( isbrgamemode() && !utility::callsharedfunc( #"gametype", #"hash_e5435a50cbd76321" ) || game[ "isLaunchChunk" ] )
    {
        level.potgenabled = 0;
        return;
    }
    
    if ( !isdefined( level.potgenabled ) || level.potgenabled )
    {
        level.potgenabled = level.finalkillcamtype == 1;
    }
    
    if ( !level.potgenabled )
    {
        return;
    }
    
    flags::gameflaginit( "potg_finalized", 0 );
    globals = spawnstruct();
    level.potgglobals = globals;
    globals.curpotgscene = undefined;
    globals.systemfinalized = 0;
    globals.entities = [];
    globals.settings = [];
    globals.settingtypes = [];
    globals.nextsceneid = 0;
    globals.lastarchivetime = -1;
    globals.archiveinprogress = 0;
    loadeventtable();
    setdvarifuninitialized( @"hash_a8bb6306d8624c5c", 25 );
    
    if ( level.gametypebundle.var_2e615b9703b5b0be )
    {
        if ( !isdefined( game[ "potg" ] ) )
        {
            bundle = level.gametypebundle;
            var_e6c5fb2be1f8d7ee = bundle.var_eeb536ea4c4c97e2 - bundle.var_4c0af980ab3f2227 + bundle.var_3229fe2c82b3fde0;
            var_e6e90d2be21f473c = bundle.var_ee9240ea4c266628 - bundle.var_4c0af980ab3f2227 + bundle.var_3229fe2c82b3fde0;
            potg = spawnstruct();
            potg.var_8c1d4228f7ca0146 = int( var_e6c5fb2be1f8d7ee * 1000 );
            potg.var_8bfa3428f7a39ac4 = int( var_e6e90d2be21f473c * 1000 );
            potg.var_7d5f8db16cedd1f = int( bundle.var_4c0af980ab3f2227 * 1000 );
            potg.var_a1a2555d8a38a158 = int( bundle.var_3229fe2c82b3fde0 * 1000 );
            potg.var_254eeada3a032160 = int( bundle.var_a0e287cf17363da8 * 1000 );
            potg.var_db439556526cc0d4 = bundle.var_b58c15144530b534 ?? 0;
            potg.recipients = [];
            potg.catalystevents = [];
            potg.var_c6661476672b530d = [];
            potg.var_61a8ea389aa982cb = [ #"equip_c4", #"equip_landmine", #"equip_gas_trap_plantable", #"equip_ied", #"equip_shockstick", #"equip_claymore" ];
            potg.var_ee79af9acc5f435f = [ #"hash_3f6c05eec1499c1":#"rcxd", #"rcxd_triple":#"rcxd", #"hash_c3fd87c346ad7988":#"landmine", #"landmine_triple":#"landmine", #"hash_f8bbc327ab75a3ea":#"ied", #"ied_triple":#"ied" ];
            
            if ( isdefined( bundle.var_52f5fc301487c282 ) && bundle.var_52f5fc301487c282.size > 0 )
            {
                potg.var_c6661476672b530d = arraysort( bundle.var_52f5fc301487c282, undefined, &function_e242cf869d6baaa4 );
            }
            
            potg_events::function_580c8afef4c35991();
            game[ "potg" ] = potg;
        }
        
        if ( isdefined( level.gametypebundle.var_891e42f30fdc94ac ) )
        {
            level thread function_29e13e23551bccd();
        }
    }
    else
    {
        potg_events::init();
        setdvarifuninitialized( @"potg_action_duration_max", 8000 );
        setdvarifuninitialized( @"potg_action_duration_min", 3000 );
        setdvarifuninitialized( @"potg_buffer_duration", 3500 );
        setdvarifuninitialized( @"potg_min_scene_score", 420 );
    }
    
    /#
        setdevdvarifuninitialized( @"potg_debug_print", 0 );
        setdevdvarifuninitialized( @"hash_a8d6f0b654204b81", 0 );
        setdevdvarifuninitialized( @"potg_datalog", 0 );
        setdevdvarifuninitialized( @"hash_ba2d7c5976a9ec58", 0 );
        setdevdvarifuninitialized( @"hash_c2407250e6c4bbbc", 0 );
    #/
    
    thread onplayerconnect();
    disconnect_event_aggregator::registerondisconnecteventcallback( &onplayerdisconnect );
    
    if ( isbrgamemode() && utility::callsharedfunc( #"gametype", #"hash_e5435a50cbd76321" ) )
    {
        thread function_49fc8e0ab0059d8();
    }
}

// Namespace potg
// Params 0
// Checksum 0x9273fa01, Offset: 0x168b
// Size: 0x51
function getminimumscorerequired()
{
    if ( getdvarint( @"potg_min_scene_score_override", 0 ) == 1 )
    {
        return 0;
    }
    
    if ( level.gametypebundle.var_2e615b9703b5b0be )
    {
        return game[ "potg" ].var_db439556526cc0d4;
    }
    
    return getdvarint( @"potg_min_scene_score" );
}

// Namespace potg
// Params 0
// Checksum 0x3c1c7d86, Offset: 0x16e4
// Size: 0x3b
function getactionscenedurationmax()
{
    if ( level.gametypebundle.var_2e615b9703b5b0be )
    {
        return game[ "potg" ].var_8c1d4228f7ca0146;
    }
    
    return getdvarint( @"potg_action_duration_max" );
}

// Namespace potg
// Params 0
// Checksum 0x3c35e608, Offset: 0x1727
// Size: 0x3b
function getactionscenedurationmin()
{
    if ( level.gametypebundle.var_2e615b9703b5b0be )
    {
        return game[ "potg" ].var_8bfa3428f7a39ac4;
    }
    
    return getdvarint( @"potg_action_duration_min" );
}

// Namespace potg
// Params 0
// Checksum 0xaf4c8b29, Offset: 0x176a
// Size: 0x3b
function function_e00ccbdcccb98ad2()
{
    if ( level.gametypebundle.var_2e615b9703b5b0be )
    {
        return game[ "potg" ].var_7d5f8db16cedd1f;
    }
    
    return getdvarint( @"potg_buffer_duration" );
}

// Namespace potg
// Params 0
// Checksum 0x1ec97837, Offset: 0x17ad
// Size: 0x3b
function function_66c368e2a3500fb5()
{
    if ( level.gametypebundle.var_2e615b9703b5b0be )
    {
        return game[ "potg" ].var_a1a2555d8a38a158;
    }
    
    return getdvarint( @"potg_buffer_duration" );
}

// Namespace potg
// Params 0
// Checksum 0x2dae4ad2, Offset: 0x17f0
// Size: 0x3b
function function_bafc3c79c3176080()
{
    if ( level.gametypebundle.var_2e615b9703b5b0be )
    {
        return game[ "potg" ].var_254eeada3a032160;
    }
    
    return getdvarint( @"potg_buffer_duration" );
}

// Namespace potg
// Params 0
// Checksum 0x1df588f5, Offset: 0x1833
// Size: 0x12
function getwholescenedurationmin()
{
    return getactionscenedurationmin() + function_bafc3c79c3176080() * 2;
}

// Namespace potg
// Params 0
// Checksum 0x5574d991, Offset: 0x184e
// Size: 0x16
function getwholescenedurationmax()
{
    return getactionscenedurationmax() + function_66c368e2a3500fb5() + function_e00ccbdcccb98ad2();
}

// Namespace potg
// Params 0
// Checksum 0x1fc348fb, Offset: 0x186d
// Size: 0xe6
function loadeventtable()
{
    if ( level.gametypebundle.var_2e615b9703b5b0be )
    {
        return;
    }
    
    globals = level.potgglobals;
    
    for ( rowindex = 0; true ; rowindex++ )
    {
        eventref = tablelookupbyrow( "mp/potg_event_table.csv", rowindex, 0 );
        
        if ( !isdefined( eventref ) || eventref == "" )
        {
            break;
        }
        
        globals.eventtable[ eventref ] = [];
        score = tablelookupbyrow( "mp/potg_event_table.csv", rowindex, 1 );
        globals.eventtable[ eventref ][ "score" ] = float( score );
        addon = tablelookupbyrow( "mp/potg_event_table.csv", rowindex, 2 );
        globals.eventtable[ eventref ][ "addOn" ] = addon != "";
    }
}

// Namespace potg
// Params 0
// Checksum 0x664366b9, Offset: 0x195b
// Size: 0x77
function onplayerconnect()
{
    level endon( #"game_ended" );
    var_c29f6be03d50a70d = 0;
    
    if ( isbrgamemode() && utility::callsharedfunc( #"gametype", #"hash_e5435a50cbd76321" ) )
    {
        var_c29f6be03d50a70d = 1;
    }
    
    while ( true )
    {
        level waittill( #"connected", player );
        
        if ( isbot( player ) )
        {
            continue;
        }
        
        player thread registerplayer( var_c29f6be03d50a70d );
    }
}

// Namespace potg
// Params 1
// Checksum 0x8538bf1a, Offset: 0x19da
// Size: 0x6c
function registerplayer( var_c29f6be03d50a70d )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( var_c29f6be03d50a70d )
    {
        flags::function_2f3408423ccc9b2e( "potg_br_initialized" );
    }
    
    registerpotgentity( self );
    
    /#
        self.var_d38aff41cbc29824 = [];
        thread function_df8cae4b4d61077c();
    #/
    
    thread updateplayerrecording();
    
    /#
        if ( !game_utility_mp::lpcfeaturegated() )
        {
            thread function_b75793cc5721fc6c();
        }
    #/
}

/#

    // Namespace potg
    // Params 0
    // Checksum 0x9eb6c7de, Offset: 0x1a4e
    // Size: 0x41, Type: dev
    function function_df8cae4b4d61077c()
    {
        level endon( #"game_ended" );
        self endon( #"disconnect" );
        thread function_274f6f05653ed7eb( "<dev string:x36>" );
        thread function_274f6f05653ed7eb( "<dev string:x45>" );
        thread function_274f6f05653ed7eb( "<dev string:x4b>" );
    }

    // Namespace potg
    // Params 1
    // Checksum 0xefd8c0d7, Offset: 0x1a97
    // Size: 0xcf, Type: dev
    function function_274f6f05653ed7eb( notifyname )
    {
        level endon( #"game_ended" );
        self endon( #"disconnect" );
        
        while ( true )
        {
            self waittill( notifyname );
            entry = notifyname + "<dev string:x60>" + gettime() + "<dev string:x64>" + self.fauxdead;
            
            if ( self.var_d38aff41cbc29824.size >= 20 )
            {
                newlog = [];
                
                for ( i = 1; i < self.var_d38aff41cbc29824.size ; i++ )
                {
                    newlog[ newlog.size ] = self.var_d38aff41cbc29824[ i ];
                }
                
                self.var_d38aff41cbc29824 = newlog;
            }
            
            self.var_d38aff41cbc29824[ self.var_d38aff41cbc29824.size ] = entry;
        }
    }

#/

// Namespace potg
// Params 0
// Checksum 0xafce238c, Offset: 0x1b6e
// Size: 0x3c
function function_49fc8e0ab0059d8()
{
    flags::gameflaginit( "potg_br_initialized", 0 );
    level.potgenabled = 0;
    flags::function_2f3408423ccc9b2e( "prematch_fade_done" );
    level.potgenabled = 1;
    flags::gameflagset( "potg_br_initialized" );
}

// Namespace potg
// Params 0
// Checksum 0x328ee1c7, Offset: 0x1bb2
// Size: 0x175
function updateplayerrecording()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"spawned_player" );
        println( "<dev string:x6f>" + self.name + "<dev string:x7c>" + gettime() + "<dev string:x8f>" + getentitypotgdata( self ).recordingenabledcount );
        startrecording();
        self waittill( #"death" );
        println( "<dev string:x6f>" + self.name + "<dev string:xa7>" + gettime() + "<dev string:x64>" + self.fauxdead + "<dev string:x8f>" + getentitypotgdata( self ).recordingenabledcount );
        
        if ( !self.fauxdead )
        {
            self waittill( #"death_delay_finished" );
        }
        
        /#
            println( "<dev string:x6f>" + self.name + "<dev string:xb1>" + getentitypotgdata( self ).recordingenabledcount );
            
            if ( !isrecordingenabled() )
            {
                println( "<dev string:x6f>" + self.name + "<dev string:xdb>" );
                
                for ( i = 0; i < self.var_d38aff41cbc29824.size ; i++ )
                {
                    println( "<dev string:xfe>" + self.var_d38aff41cbc29824[ i ] );
                }
            }
        #/
        
        stoprecording();
    }
}

// Namespace potg
// Params 1
// Checksum 0x1eb8d196, Offset: 0x1d2f
// Size: 0x49
function onplayerdisconnect( player )
{
    deregisterpotgentity( player );
    var_7ae7ed4a25e5e8a6 = getcurpotgscene();
    
    if ( var_7ae7ed4a25e5e8a6.primaryentity == player )
    {
        resetpotg();
        logstring( "^5[POTG] RESETTING POTG DUE TO PLAYER DISCONNECT" );
    }
}

// Namespace potg
// Params 0
// Checksum 0x1637d56a, Offset: 0x1d80
// Size: 0x2a
function resetpotg()
{
    level.potgglobals.curpotgscene = undefined;
    level.potgglobals.var_4a42bed215732bce = 0;
}

// Namespace potg
// Params 1
// Checksum 0xeb0a80ac, Offset: 0x1db2
// Size: 0x2b
function onroundended( winner )
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    potg_events::onroundended( winner );
    waitframe();
    thread finalizepotgsystem();
}

// Namespace potg
// Params 0
// Checksum 0x9de1b919, Offset: 0x1de5
// Size: 0x92
function shouldskippotg()
{
    currscene = getcurpotgscene();
    
    if ( !level.potgglobals.systemfinalized )
    {
        return !level.potgenabled;
    }
    
    if ( isdefined( currscene ) && isdefined( currscene.primaryentity ) )
    {
        return ( currscene.score < getminimumscorerequired() );
    }
    
    if ( !isdefined( currscene ) )
    {
        logstring( "^5[POTG] END MATCH FLOW -- Skipping POTG because current POTG Scene is undefined " );
    }
    else if ( !isdefined( currscene.primaryentity ) )
    {
        logstring( "^5[POTG] END MATCH FLOW -- Skipping POTG because current POTG Scene's primary entity is undefined " );
    }
    
    return 1;
}

// Namespace potg
// Params 0
// Checksum 0xa17a168, Offset: 0x1e7f
// Size: 0x71
function finalizepotgsystem()
{
    level notify( #"potg_finalize" );
    finalizeallrecordings();
    waittillframeend();
    level.potgglobals.systemfinalized = 1;
    
    if ( shouldskippotg() )
    {
        level flags::gameflagset( "potg_finalized" );
        return;
    }
    
    potgscene = getcurpotgscene();
    
    if ( isdefined( potgscene ) )
    {
        finalizescene( potgscene );
    }
    
    level flags::gameflagset( "potg_finalized" );
}

// Namespace potg
// Params 0
// Checksum 0x1b164092, Offset: 0x1ef8
// Size: 0x16, Type: bool
function issystemfinalized()
{
    return istrue( level.potgglobals.systemfinalized );
}

// Namespace potg
// Params 0
// Checksum 0x3d5e8546, Offset: 0x1f17
// Size: 0x3e
function function_754f8cbf0dd72c21()
{
    if ( level.gametypebundle.var_2e615b9703b5b0be )
    {
        return level.gametypebundle.finalkillcamtype;
    }
    
    return getmatchrulesdata( "commonOption", "killcamType" );
}

// Namespace potg
// Params 1
// Checksum 0xee709243, Offset: 0x1f5d
// Size: 0xec
function registerpotgentity( entity )
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    globals = level.potgglobals;
    assert( isdefined( entity ) && !isdefined( globals.entities[ entity.potgid ?? getentityid( entity ) ] ) );
    newstruct = { #var_48122f38d549fb4b:[], #var_192e5329efb5972c:0, #nexteventid:0, #lastrecordingstarttime:-1, #recordingenabledcount:0, #events:[], #entity:entity };
    globals.entities[ entity.potgid ?? getentityid( entity ) ] = newstruct;
    function_e8b8c5ac26c646b3( entity, "REGISTERED" );
}

// Namespace potg
// Params 1
// Checksum 0xde240842, Offset: 0x2051
// Size: 0x5f
function deregisterpotgentity( entity )
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    level.potgglobals.entities[ entity.potgid ?? getentityid( entity ) ] = undefined;
    entity notify( #"hash_34f1ace26713b3b2" );
    function_e8b8c5ac26c646b3( entity, "DEREGISTERED" );
}

// Namespace potg
// Params 1
// Checksum 0x2166ac51, Offset: 0x20b8
// Size: 0x36
function getentitypotgdata( entity )
{
    return level.potgglobals.entities[ entity.potgid ?? getentityid( entity ) ];
}

// Namespace potg
// Params 1
// Checksum 0x7f371f30, Offset: 0x20f7
// Size: 0x22, Type: bool
function getentityid( entity )
{
    return entity.potgid ?? function_79f9bd2ff8b12eda( entity );
}

// Namespace potg
// Params 1, eflags: 0x4
// Checksum 0xbe898b95, Offset: 0x2122
// Size: 0x29
function private function_79f9bd2ff8b12eda( entity )
{
    entity.potgid = entity getentitynumber();
    return entity.potgid;
}

// Namespace potg
// Params 0
// Checksum 0xc8848df7, Offset: 0x2154
// Size: 0x7e
function startrecording()
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    if ( issystemfinalized() )
    {
        return;
    }
    
    entdata = getentitypotgdata( self );
    assert( isdefined( entdata ) );
    assert( !issystemfinalized(), "<dev string:x10d>" );
    
    if ( entdata.recordingenabledcount == 0 )
    {
        onrecordingstarted( entdata );
    }
    
    entdata.recordingenabledcount++;
    function_14b11fe54592d39c( self, "START" );
}

// Namespace potg
// Params 1
// Checksum 0x4b4c5ccc, Offset: 0x21da
// Size: 0x1c
function onrecordingstarted( entdata )
{
    entdata.lastrecordingstarttime = gettime();
}

// Namespace potg
// Params 0
// Checksum 0xf88d791a, Offset: 0x21fe
// Size: 0x84
function stoprecording()
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    if ( issystemfinalized() )
    {
        return;
    }
    
    entdata = getentitypotgdata( self );
    assert( isdefined( entdata ) );
    assert( entdata.recordingenabledcount > 0, "<dev string:x14e>" );
    entdata.recordingenabledcount--;
    
    if ( entdata.recordingenabledcount == 0 )
    {
        onrecordingstopped( entdata );
    }
    
    function_14b11fe54592d39c( self, "STOP" );
}

// Namespace potg
// Params 1
// Checksum 0x23615ea0, Offset: 0x228a
// Size: 0x44
function forcestoprecording( entdata )
{
    entdata.recordingenabledcount = 0;
    entdata.entity onrecordingstopped( entdata );
    function_14b11fe54592d39c( entdata.entity, "FORCE-STOP" );
}

// Namespace potg
// Params 1
// Checksum 0x80e9ecfa, Offset: 0x22d6
// Size: 0x32
function onrecordingstopped( entdata )
{
    potg_events::onpotgrecordingstopped();
    entdata.entity notify( #"potg_stop_recording" );
    removeallevents( entdata );
}

// Namespace potg
// Params 1
// Checksum 0x3a911cbf, Offset: 0x2310
// Size: 0x4c, Type: bool
function isrecordingenabled( entdata )
{
    if ( !level.potgenabled )
    {
        return false;
    }
    
    if ( issystemfinalized() )
    {
        return false;
    }
    
    if ( !isdefined( entdata ) )
    {
        entdata = getentitypotgdata( self );
    }
    
    assert( isdefined( entdata ) );
    return entdata.recordingenabledcount > 0;
}

// Namespace potg
// Params 0
// Checksum 0xed70ff83, Offset: 0x2365
// Size: 0x114
function finalizeallrecordings()
{
    globals = level.potgglobals;
    
    foreach ( entdata in globals.entities )
    {
        if ( !isdefined( entdata.entity ) )
        {
            continue;
        }
        
        if ( isplayer( entdata.entity ) )
        {
            var_a8c36f66c485273b = function_b489dd728d45043e( entdata.var_48122f38d549fb4b );
            entdata.entity dlog_recordplayerevent( "dlog_event_mp_potg_personal_best", [ "personal_best_potg_events", var_a8c36f66c485273b, "personal_potg_score", entdata.var_192e5329efb5972c ] );
        }
        
        forcestoprecording( entdata );
    }
    
    function_888d91c84eda8969();
}

// Namespace potg
// Params 9
// Checksum 0x3d4b7c2a, Offset: 0x2481
// Size: 0x4de
function processevent( eventref, starttime, endtime, psoffsettime, scoreoverride, scoremultiplier, eventinfo, objweapon, smeansofdeath )
{
    if ( !level.potgenabled )
    {
        return;
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isbot( self ) )
    {
        return;
    }
    
    /#
        if ( eventref == #"kill" )
        {
            potg_debugprint( "<dev string:x1b2>", "<dev string:x1b8>", "<dev string:x1bb>" + "<dev string:x1d8>" + endtime + "<dev string:x1e0>" + objweapon.basename, undefined );
        }
        
        potg_debugprint( "<dev string:x1b2>", "<dev string:x1b8>", "<dev string:x1ed>" + "<dev string:x1fa>" + eventref + "<dev string:x206>" + endtime + "<dev string:x1e0>" + ( isdefined( objweapon ) ? objweapon.basename : "<dev string:x211>" ), undefined );
    #/
    
    if ( level.gametypebundle.var_2e615b9703b5b0be )
    {
        if ( !isxhash( eventref ) )
        {
            eventref = getxhash( eventref );
        }
        
        if ( !eventtable_isevent( eventref ) )
        {
            return;
        }
    }
    else
    {
        assert( isdefined( level.potgglobals.eventtable[ eventref ] ), "<dev string:x21b>" + eventref );
    }
    
    if ( !isdefined( starttime ) )
    {
        starttime = gettime();
    }
    
    if ( !isdefined( endtime ) )
    {
        endtime = starttime;
    }
    
    assert( endtime >= starttime );
    assert( starttime <= gettime() );
    assert( endtime <= gettime() );
    entdata = getentitypotgdata( self );
    assert( isdefined( entdata ) );
    
    if ( !isrecordingenabled( entdata ) )
    {
        return;
    }
    
    newevent = spawnstruct();
    player = self;
    score = undefined;
    
    if ( isdefined( scoreoverride ) )
    {
        score = scoreoverride;
    }
    else
    {
        score = eventtable_getscore( eventref, player );
    }
    
    if ( isdefined( scoremultiplier ) )
    {
        score *= scoremultiplier;
    }
    
    if ( isdefined( level.gamemodebundle.var_296d43831b436c4c ) && level.gamemodebundle.var_296d43831b436c4c != 1 && eventref == #"kill" )
    {
        equipmentref = equipment_mp::getequipmentreffromweapon( objweapon );
        
        if ( isdefined( equipmentref ) )
        {
            islethal = equipment_mp::isequipmentlethal( equipmentref );
            istactical = equipment_mp::isequipmenttactical( equipmentref );
            
            if ( islethal || istactical )
            {
                score *= level.gamemodebundle.var_296d43831b436c4c;
            }
        }
    }
    
    playerhealthratio = int( clamp( player.health / player.maxhealth * 127, 0, 127 ) );
    newevent.eventref = eventref;
    newevent.starttime = starttime;
    newevent.endtime = endtime;
    newevent.score = score;
    newevent.psoffsettime = psoffsettime;
    newevent.playerhealthratio = playerhealthratio;
    newevent.ismultikill = istrue( eventinfo.ismultikill );
    newevent.var_2627d300cc19e67e = function_2627d300cc19e67e( eventref );
    newevent.smeansofdeath = smeansofdeath;
    newevent.var_5df854f1f75793cf = game[ "potg" ].var_ee79af9acc5f435f[ eventref ];
    newevent.attackerorigin = player.origin;
    
    if ( isdefined( objweapon ) )
    {
        newevent.objweapon = objweapon;
    }
    
    if ( isdefined( eventinfo ) )
    {
        newevent.var_9f71c6384859861d = istrue( eventinfo.var_9f71c6384859861d );
        
        if ( isdefined( eventinfo.killcamentindex ) )
        {
            newevent.killcamentindex = eventinfo.killcamentindex;
            newevent.killcamentstarttime = eventinfo.killcamentstarttime;
            newevent.killcamentstickstolookatent = eventinfo.killcamentstickstolookatent;
            newevent.killcamlookatentityindex = eventinfo.killcamlookatentityindex;
            
            if ( !newevent.var_5df854f1f75793cf )
            {
                newevent.starttime = eventinfo.killcamentstarttime;
            }
        }
    }
    
    eventid = entdata.nexteventid;
    entdata.events[ eventid ] = newevent;
    entdata.nexteventid++;
    removeoldevents( entdata );
    verifymultikills( entdata );
    
    /#
        function_a6db4721e3a8cb3d( eventref );
    #/
    
    debug_printevent( self, eventref, score, starttime, endtime );
    
    if ( !eventtable_isaddonevent( eventref ) )
    {
        thread waitandnominatepotg( entdata );
    }
}

// Namespace potg
// Params 1
// Checksum 0xdb1d38e9, Offset: 0x2967
// Size: 0x120
function verifymultikills( entdata )
{
    var_e89baebcebae2576 = [];
    
    foreach ( eventid, event in entdata.events )
    {
        if ( event.ismultikill )
        {
            if ( !function_ef56bdd7cea9f0bd( event, entdata ) )
            {
                var_e89baebcebae2576[ var_e89baebcebae2576.size ] = eventid;
            }
        }
    }
    
    foreach ( var_f312dd1c7a4c603a in var_e89baebcebae2576 )
    {
        entdata.events[ var_f312dd1c7a4c603a ] = undefined;
    }
}

// Namespace potg
// Params 2
// Checksum 0x544b7805, Offset: 0x2a8f
// Size: 0x17a, Type: bool
function function_ef56bdd7cea9f0bd( multikillevent, entdata )
{
    var_71b3def4493e577d = 0;
    
    switch ( multikillevent.eventref )
    {
        case #"double":
            var_71b3def4493e577d = 2;
            break;
        case #"triple":
            var_71b3def4493e577d = 3;
            break;
        case #"four":
            var_71b3def4493e577d = 4;
            break;
        case #"five":
            var_71b3def4493e577d = 5;
            break;
        case #"six":
            var_71b3def4493e577d = 6;
            break;
        case #"seven":
            var_71b3def4493e577d = 7;
            break;
        case #"eight":
            var_71b3def4493e577d = 8;
            break;
        default:
            break;
    }
    
    var_5c3587a0244c7df0 = 0;
    
    foreach ( event in entdata.events )
    {
        if ( event.eventref == multikillevent.eventref )
        {
            break;
        }
        
        if ( event.var_9f71c6384859861d )
        {
            var_5c3587a0244c7df0 += 1;
        }
    }
    
    return var_5c3587a0244c7df0 >= var_71b3def4493e577d;
}

// Namespace potg
// Params 1
// Checksum 0x4cfca43d, Offset: 0x2c12
// Size: 0x110
function waitandnominatepotg( entdata )
{
    entity = entdata.entity;
    entity endon( #"disconnect" );
    entity endon( #"hash_34f1ace26713b3b2" );
    entity notify( #"hash_3c8e39d8e1200cb5" );
    entity endon( #"hash_3c8e39d8e1200cb5" );
    waittillframeend();
    
    if ( !isrecordingenabled( entdata ) )
    {
        return;
    }
    
    totalscore = calculatepotgscore( entdata.events );
    
    if ( totalscore > getminimumscorerequired() && ( totalscore > getbestpotgscore() || totalscore > level.potgglobals.entities[ entity.potgid ?? getentityid( entity ) ].var_192e5329efb5972c ) )
    {
        newscene = createscenefromnewevent( entdata, totalscore );
        
        if ( isdefined( newscene ) )
        {
            entity thread waitformorerecordingtimeforscene( newscene );
        }
        
        return;
    }
    
    function_ae6d8e82bd7a79ce( entity, totalscore, entdata.events.size );
}

// Namespace potg
// Params 1
// Checksum 0x46b23ad8, Offset: 0x2d2a
// Size: 0xad
function removeoldevents( entdata )
{
    oldesttime = getcurwindowstarttime();
    
    foreach ( eventkey, eventdata in entdata.events )
    {
        if ( eventdata.starttime < oldesttime )
        {
            entdata.events[ eventkey ] = undefined;
        }
    }
}

// Namespace potg
// Params 1
// Checksum 0x2c122df1, Offset: 0x2ddf
// Size: 0x19
function removeallevents( entdata )
{
    entdata.events = [];
}

// Namespace potg
// Params 2
// Checksum 0x3bfd3c4, Offset: 0x2e00
// Size: 0x162
function createscenefromnewevent( entdata, totalscore )
{
    scene = spawnstruct();
    scene.primaryentity = entdata.entity;
    scene.events = entdata.events;
    scene.score = totalscore;
    scene.sceneid = level.potgglobals.nextsceneid;
    level.potgglobals.nextsceneid++;
    assert( entdata.events.size > 0 );
    scene.actionstarttime = undefined;
    scene.actionendtime = undefined;
    scene.playerhealthratio = undefined;
    scene.var_df0519c0d8a13bbb = 0;
    scene.var_f12d8ea92054e01e = 0;
    scene.objweapon = undefined;
    function_396fd56d2837f07b( entdata.events, scene );
    
    if ( scene.actionendtime < scene.actionstarttime )
    {
        return;
    }
    
    assert( isdefined( entdata.lastrecordingstarttime ) );
    scene.recordingstarttime = entdata.lastrecordingstarttime;
    scene.playbackstarttime = undefined;
    scene.playbackendtime = undefined;
    return scene;
}

// Namespace potg
// Params 2
// Checksum 0x6ebfb48d, Offset: 0x2f6b
// Size: 0x1c6
function function_396fd56d2837f07b( events, scene )
{
    foreach ( event in events )
    {
        if ( !isdefined( scene.actionstarttime ) || event.starttime < scene.actionstarttime )
        {
            scene.actionstarttime = event.starttime;
        }
        
        if ( !isdefined( scene.actionendtime ) || event.endtime > scene.actionendtime )
        {
            scene.actionendtime = event.endtime;
        }
        
        if ( event.var_9f71c6384859861d && event.endtime >= scene.var_f12d8ea92054e01e )
        {
            function_abc612f6b1659fd3( event, scene );
        }
        
        if ( isdefined( event.playerhealthratio ) )
        {
            if ( scene.playerhealthratio != event.playerhealthratio )
            {
                scene.playerhealthratio = event.playerhealthratio;
            }
        }
        else
        {
            scene.playerhealthratio = 127;
        }
        
        if ( isdefined( event.objweapon ) )
        {
            if ( scene.objweapon != event.objweapon )
            {
                scene.objweapon = event.objweapon;
            }
        }
    }
}

// Namespace potg
// Params 2
// Checksum 0x3b2997be, Offset: 0x3139
// Size: 0x96
function function_6150b67a9fc857c3( events, scene )
{
    foreach ( event in events )
    {
        if ( event.var_2627d300cc19e67e )
        {
            function_abc612f6b1659fd3( event, scene );
        }
    }
}

// Namespace potg
// Params 2
// Checksum 0xb3938031, Offset: 0x31d7
// Size: 0x19a
function function_471631964d9ac318( events, scene )
{
    foreach ( event in events )
    {
        if ( event.var_5df854f1f75793cf )
        {
            scene.var_df0519c0d8a13bbb = event.starttime;
            scene.var_f12d8ea92054e01e = event.endtime;
            scene.actionendtime = event.endtime;
            scene.smeansofdeath = event.smeansofdeath;
            
            if ( event.killcamentstarttime <= scene.playbackstarttime )
            {
                scene.var_5df854f1f75793cf = event.var_5df854f1f75793cf;
                scene.killcamentstarttime = scene.playbackstarttime;
            }
            else
            {
                scene.var_5df854f1f75793cf = undefined;
                scene.killcamentstarttime = event.killcamentstarttime;
            }
            
            scene.killcamentindex = event.killcamentindex;
            scene.killcamentstickstolookatent = event.killcamentstickstolookatent;
            scene.killcamlookatentityindex = event.killcamlookatentityindex;
        }
    }
}

// Namespace potg
// Params 2
// Checksum 0x75da836c, Offset: 0x3379
// Size: 0x10b
function function_abc612f6b1659fd3( event, scene )
{
    scene.var_df0519c0d8a13bbb = event.starttime;
    scene.var_f12d8ea92054e01e = event.endtime;
    scene.actionendtime = event.endtime;
    scene.smeansofdeath = event.smeansofdeath;
    
    if ( isdefined( event.killcamentindex ) )
    {
        scene.killcamentindex = event.killcamentindex;
        scene.killcamentstarttime = event.killcamentstarttime;
        scene.killcamentstickstolookatent = event.killcamentstickstolookatent;
        scene.killcamlookatentityindex = event.killcamlookatentityindex;
        return;
    }
    
    scene.killcamentindex = undefined;
    scene.killcamentstarttime = undefined;
    scene.killcamentstickstolookatent = undefined;
    scene.killcamlookatentityindex = undefined;
}

// Namespace potg
// Params 1
// Checksum 0x90599bf9, Offset: 0x348c
// Size: 0x1b, Type: bool
function doesscenehaveenoughtotalrecordingtime( scene )
{
    return getmaxsceneduration( scene ) >= getwholescenedurationmin();
}

// Namespace potg
// Params 1
// Checksum 0xe6c87334, Offset: 0x34b0
// Size: 0x8e, Type: bool
function doesscenehaveenoughbufferrecordingtime( scene )
{
    assert( isdefined( scene.playbackstarttime ) );
    assert( isdefined( scene.playbackendtime ) );
    var_af28c091cc4d26df = scene.actionstarttime - scene.playbackstarttime >= function_bafc3c79c3176080();
    var_38df27a73192b244 = scene.playbackendtime - scene.actionendtime >= function_bafc3c79c3176080();
    return var_af28c091cc4d26df && var_38df27a73192b244;
}

// Namespace potg
// Params 1
// Checksum 0xe1a778f8, Offset: 0x3547
// Size: 0x4b
function getmaxsceneduration( scene )
{
    assert( isdefined( scene.recordingstarttime ) );
    assert( isdefined( scene.playbackendtime ) );
    return scene.playbackendtime - scene.recordingstarttime;
}

// Namespace potg
// Params 1
// Checksum 0x26f86e2c, Offset: 0x359b
// Size: 0x28f
function waitformorerecordingtimeforscene( scene )
{
    self endon( #"disconnect" );
    self endon( #"hash_34f1ace26713b3b2" );
    level endon( #"game_ended" );
    actionendtime = scene.actionstarttime + getactionscenedurationmax();
    scene.lastspawntime = self.lastspawntime;
    function_fe55157f3ef56c71( scene, "Waiting... (" + actionendtime - gettime() + "ms)" );
    result = "no_wait";
    
    if ( actionendtime > gettime() )
    {
        thread watchpendingscenetimeout( actionendtime );
        result = utility::waittill_any_return_no_endon_death( "potg_pending_scene_timeout", "potg_stop_recording" );
        self notify( #"hash_e8344174e879a585" );
    }
    
    function_fe55157f3ef56c71( scene, "Done (" + result + ")" );
    function_396fd56d2837f07b( scene.events, scene );
    function_6150b67a9fc857c3( scene.events, scene );
    calcsceneplaybacktimes( scene );
    function_471631964d9ac318( scene.events, scene );
    scene.lastplayerdeathtime = self.deathtime;
    function_4ddfc83650ff4338( scene );
    
    if ( !doesscenehaveenoughtotalrecordingtime( scene ) )
    {
        function_948be00de9108e99( scene.primaryentity, scene, "Not enough recording time" );
        return;
    }
    
    if ( !doesscenehaveenoughbufferrecordingtime( scene ) )
    {
        function_948be00de9108e99( scene.primaryentity, scene, "Not enough buffer time" );
        return;
    }
    
    entityid = scene.primaryentity.potgid ?? getentityid( scene.primaryentity );
    
    if ( scene.score > level.potgglobals.entities[ entityid ].var_192e5329efb5972c )
    {
        level.potgglobals.entities[ entityid ].var_192e5329efb5972c = scene.score;
        level.potgglobals.entities[ entityid ].var_48122f38d549fb4b = scene.events;
    }
    
    if ( scene.score > getminimumscorerequired() && scene.score > getbestpotgscore() )
    {
        setcurpotgscene( scene );
        return;
    }
    
    function_948be00de9108e99( scene.primaryentity, scene, "Worse than current POTG (Delayed)" );
}

// Namespace potg
// Params 1
// Checksum 0x61b8cf02, Offset: 0x3832
// Size: 0xad
function function_4ddfc83650ff4338( scene )
{
    if ( !isdefined( scene.lastplayerdeathtime ) || scene.var_5df854f1f75793cf )
    {
        return;
    }
    
    if ( scene.lastplayerdeathtime <= scene.playbackendtime && scene.lastplayerdeathtime >= scene.playbackstarttime )
    {
        debuffmodifier = level.gametypebundle.var_342f3331bbeb5c9b ?? 1;
        scene.score *= debuffmodifier;
        scene.playerdeathpresent = 1;
    }
}

// Namespace potg
// Params 1
// Checksum 0xc46ce2d6, Offset: 0x38e7
// Size: 0x40
function watchpendingscenetimeout( endtime )
{
    self endon( #"hash_e8344174e879a585" );
    timetowait = endtime - gettime();
    wait timetowait * 0.001;
    self notify( #"potg_pending_scene_timeout" );
}

// Namespace potg
// Params 1
// Checksum 0x4b1ed5f3, Offset: 0x392f
// Size: 0xf4
function calculatepotgscore( events )
{
    killcount = 0;
    scoretotal = 0;
    
    foreach ( eventdata in events )
    {
        scoretotal += eventdata.score;
        
        if ( eventdata.eventref == "kill" || eventdata.eventref == #"kill" )
        {
            killcount++;
        }
    }
    
    if ( killcount > 2 )
    {
        score = eventtable_getscore( "triple_kill" );
        scoretotal += score;
    }
    
    return scoretotal;
}

// Namespace potg
// Params 1
// Checksum 0x999101a1, Offset: 0x3a2c
// Size: 0x97
function setcurpotgscene( scene )
{
    assert( doesscenehaveenoughtotalrecordingtime( scene ) );
    
    if ( !isdefined( level.potgglobals.curpotgscene ) )
    {
        if ( !isdefined( level.potgglobals.var_4a42bed215732bce ) || scene.score > level.potgglobals.var_4a42bed215732bce )
        {
            level.potgglobals.var_4a42bed215732bce = scene.score;
        }
    }
    
    thread requestarchive( scene );
}

// Namespace potg
// Params 0
// Checksum 0x2137a3dc, Offset: 0x3acb
// Size: 0x2d
function getcurpotgscene()
{
    if ( !level.potgenabled )
    {
        logstring( "^5[POTG] END MATCH FLOW -- Cannot get current POTG scene because POTG is disabled on the level" );
        return;
    }
    
    return level.potgglobals.curpotgscene;
}

// Namespace potg
// Params 0
// Checksum 0x94f94881, Offset: 0x3b01
// Size: 0x6b
function getbestpotgscore()
{
    if ( !level.potgenabled )
    {
        return -1;
    }
    
    globals = level.potgglobals;
    
    if ( !isdefined( globals.curpotgscene ) )
    {
        if ( !isdefined( globals.var_4a42bed215732bce ) )
        {
            return -1;
        }
        
        return globals.var_4a42bed215732bce;
    }
    
    return globals.curpotgscene.score;
}

// Namespace potg
// Params 0
// Checksum 0x8f272337, Offset: 0x3b75
// Size: 0xd
function getcurwindowstarttime()
{
    return gettime() - getactionscenedurationmax();
}

// Namespace potg
// Params 0
// Checksum 0xf88cda97, Offset: 0x3b8b
// Size: 0x6f, Type: bool
function function_4758d0aee5ea85d0()
{
    if ( self.connectedpostgame )
    {
        return true;
    }
    
    if ( !isdefined( self.timeplayed ) || self.timeplayed[ "total" ] < 1 || self.pers[ "participation" ] < 1 )
    {
        return true;
    }
    
    if ( !self.pers[ "hasDoneAnyCombat" ] )
    {
        return true;
    }
    
    return !isdefined( level.placement );
}

// Namespace potg
// Params 2
// Checksum 0x8d911519, Offset: 0x3c03
// Size: 0xae
function eventtable_getscore( eventref, player )
{
    if ( level.gametypebundle.var_2e615b9703b5b0be )
    {
        if ( !isxhash( eventref ) )
        {
            eventref = getxhash( eventref );
        }
        
        if ( !isdefined( level.scoreinfo[ eventref ] ) )
        {
            return 0;
        }
        
        basescore = level.scoreinfo[ eventref ][ #"potgscore" ];
        scoremodifier = getscoremodifier( eventref, player );
        return ( basescore * scoremodifier );
    }
    
    return level.potgglobals.eventtable[ eventref ][ "score" ];
}

// Namespace potg
// Params 1
// Checksum 0x1d3fc0ed, Offset: 0x3cb9
// Size: 0x36, Type: bool
function function_2627d300cc19e67e( eventref )
{
    if ( !isdefined( level.scoreinfo[ eventref ] ) )
    {
        return false;
    }
    
    return istrue( level.scoreinfo[ eventref ][ #"hash_ddc6a1b45a3259d9" ] );
}

// Namespace potg
// Params 2
// Checksum 0x26e1aa5a, Offset: 0x3cf8
// Size: 0x4f
function getscoremodifier( eventref, player )
{
    scoremodifier = 1;
    scoremodifier *= function_6a1588cbcf0543ae( eventref );
    scoremodifier *= function_372fdd3fa94fe7ef( player );
    scoremodifier *= function_a442325ca9a7a69( player );
    return scoremodifier;
}

// Namespace potg
// Params 1
// Checksum 0x25f31208, Offset: 0x3d50
// Size: 0xd6
function function_6a1588cbcf0543ae( eventref )
{
    if ( !game_utility_mp::isroundbased() || level.currentround == 1 )
    {
        return 1;
    }
    
    if ( !isdefined( level.gametypebundle.var_d3b41dd4ad3d596a ) )
    {
        return 1;
    }
    
    if ( !isdefined( game[ "potg" ].catalystevents[ level.currentround - 1 ] ) )
    {
        return 1;
    }
    
    if ( !isdefined( eventref ) )
    {
        return 1;
    }
    
    prevevent = game[ "potg" ].catalystevents[ level.currentround - 1 ];
    var_116a123abf103d99 = prevevent == eventref;
    
    if ( var_116a123abf103d99 )
    {
        return level.gametypebundle.var_d3b41dd4ad3d596a;
    }
    
    return 1;
}

// Namespace potg
// Params 1
// Checksum 0x6c188d1, Offset: 0x3e2f
// Size: 0x7e
function function_372fdd3fa94fe7ef( player )
{
    if ( !game_utility_mp::isroundbased() || level.currentround == 1 )
    {
        return 1;
    }
    
    if ( !isdefined( level.gametypebundle.var_4cc42d1a3023e18f ) )
    {
        return 1;
    }
    
    if ( !isdefined( player ) )
    {
        return 1;
    }
    
    if ( player.var_4d0b7799aa2e868b )
    {
        return level.gametypebundle.var_4cc42d1a3023e18f;
    }
    
    return 1;
}

// Namespace potg
// Params 1
// Checksum 0xeb9a3a13, Offset: 0x3eb6
// Size: 0xec
function function_a442325ca9a7a69( player )
{
    if ( !isdefined( level.gametypebundle.var_52f5fc301487c282 ) || level.gametypebundle.var_52f5fc301487c282.size == 0 )
    {
        return 1;
    }
    
    if ( !isplayer( player ) )
    {
        return 1;
    }
    
    var_3d6cc86c3a810fd7 = player getplayerdata( level.var_6f9b00680ed002d8, "roundsSinceLastPOTG" );
    var_6f4a3c0baa6503dc = game[ "potg" ].var_c6661476672b530d;
    
    if ( var_3d6cc86c3a810fd7 < var_6f4a3c0baa6503dc[ 0 ].roundssincelastpotg )
    {
        return 1;
    }
    
    for ( i = var_6f4a3c0baa6503dc.size - 1; i >= 0 ; i-- )
    {
        if ( var_3d6cc86c3a810fd7 >= var_6f4a3c0baa6503dc[ i ].roundssincelastpotg )
        {
            return var_6f4a3c0baa6503dc[ i ].modifier;
        }
    }
    
    return 1;
}

// Namespace potg
// Params 0
// Checksum 0x5632af0c, Offset: 0x3fab
// Size: 0x126
function function_af8afd2fd11b3b25()
{
    var_263cc2dcec41e2e8 = game[ "potg" ].recipients[ level.currentround ];
    var_44c6d1ffb152c319 = level.potgglobals.entities[ var_263cc2dcec41e2e8 ].entity;
    var_44c6d1ffb152c319 setplayerdata( level.var_6f9b00680ed002d8, "roundsSinceLastPOTG", 0 );
    
    foreach ( player in level.players )
    {
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( player == var_44c6d1ffb152c319 )
        {
            continue;
        }
        
        roundssincelastpotg = player getplayerdata( level.var_6f9b00680ed002d8, "roundsSinceLastPOTG" );
        player setplayerdata( level.var_6f9b00680ed002d8, "roundsSinceLastPOTG", roundssincelastpotg + 1 );
    }
}

// Namespace potg
// Params 2
// Checksum 0xa62d9a03, Offset: 0x40d9
// Size: 0x2c, Type: bool
function function_e242cf869d6baaa4( var_ff3161a1b8c58664, var_4ab7088ed158eab1 )
{
    return var_ff3161a1b8c58664.modifier < var_4ab7088ed158eab1.modifier;
}

// Namespace potg
// Params 1
// Checksum 0xa0253a73, Offset: 0x410e
// Size: 0x45
function eventtable_isaddonevent( eventref )
{
    if ( level.gametypebundle.var_2e615b9703b5b0be )
    {
        return 0;
    }
    
    return istrue( level.potgglobals.eventtable[ eventref ][ "addOn" ] );
}

// Namespace potg
// Params 1
// Checksum 0xf466e139, Offset: 0x415b
// Size: 0x7f
function eventtable_isevent( eventref )
{
    if ( level.gametypebundle.var_2e615b9703b5b0be )
    {
        if ( !isxhash( eventref ) )
        {
            eventref = getxhash( eventref );
        }
        
        potgscore = level.scoreinfo[ eventref ][ #"potgscore" ];
        
        if ( !isdefined( potgscore ) )
        {
            return 0;
        }
        
        return ( potgscore > 0 );
    }
    
    return isdefined( level.potgglobals.eventtable[ eventref ] );
}

// Namespace potg
// Params 0
// Checksum 0x6f775472, Offset: 0x41e2
// Size: 0xfa
function function_29e13e23551bccd()
{
    level endon( #"game_ended" );
    level flags::gameflagwait( "prematch_done" );
    currround = level.currentround;
    prevround = currround - 1;
    cooldownrounds = level.gametypebundle.var_891e42f30fdc94ac;
    
    for ( round = 1; round < currround ; round++ )
    {
        var_263cc2dcec41e2e8 = game[ "potg" ].recipients[ round ];
        var_44c6d1ffb152c319 = level.potgglobals.entities[ var_263cc2dcec41e2e8 ].entity;
        
        if ( !isdefined( var_44c6d1ffb152c319 ) )
        {
            continue;
        }
        
        var_3d6cc86c3a810fd7 = prevround - round;
        
        if ( var_3d6cc86c3a810fd7 >= cooldownrounds )
        {
            var_44c6d1ffb152c319.var_4d0b7799aa2e868b = 0;
            continue;
        }
        
        var_44c6d1ffb152c319.var_4d0b7799aa2e868b = 1;
    }
}

// Namespace potg
// Params 1
// Checksum 0x70b17dd8, Offset: 0x42e4
// Size: 0xec
function finalizescene( scene )
{
    assert( issystemfinalized() || getdvarint( @"hash_a8d6f0b654204b81" ) );
    scene.finalized = 1;
    
    if ( level.gametypebundle.var_2e615b9703b5b0be )
    {
        game[ "potg" ].recipients[ level.currentround ] = scene.primaryentity.potgid ?? getentityid( scene.primaryentity );
        game[ "potg" ].catalystevents[ level.currentround ] = utility::array_get_first_item( scene.events ).eventref;
        level function_af8afd2fd11b3b25();
    }
    
    calcscenepsoffset( scene );
    resetscorefeedcontrolomnvar();
    debug_scenefinalized( scene );
}

// Namespace potg
// Params 0
// Checksum 0x9a22e9de, Offset: 0x43d8
// Size: 0xc6
function resetscorefeedcontrolomnvar()
{
    foreach ( player in level.players )
    {
        player setclientomnvar( "ui_potg_score_event_control", -1 );
        player setclientomnvar( "ui_score_event_list_0", -1 );
        player setclientomnvar( "ui_score_event_list_1", -1 );
        player setclientomnvar( "ui_score_event_list_2", -1 );
        player setclientomnvar( "ui_score_event_list_3", -1 );
        player setclientomnvar( "ui_score_event_list_4", -1 );
    }
}

// Namespace potg
// Params 1
// Checksum 0x70076859, Offset: 0x44a6
// Size: 0xd9
function calcsceneplaybacktimes( scene )
{
    idealstarttime = scene.actionstarttime - function_e00ccbdcccb98ad2();
    idealendtime = scene.actionendtime + function_66c368e2a3500fb5();
    
    if ( idealstarttime < scene.lastspawntime && scene.lastspawntime < scene.actionendtime )
    {
        scene.playbackstarttime = scene.lastspawntime;
        logstring( "^5[POTG] CLAMPING IDEAL START TIME ( " + idealstarttime + "ms ) to last spawn time ( " + scene.lastspawntime + "ms ) -- Scene #" + scene.sceneid );
    }
    else
    {
        scene.playbackstarttime = idealstarttime;
    }
    
    scene.playbackendtime = idealendtime;
}

// Namespace potg
// Params 1
// Checksum 0xfad3cb64, Offset: 0x4587
// Size: 0x177
function calcscenepsoffset( scene )
{
    psoffsettimes = [];
    
    foreach ( event in scene.events )
    {
        if ( isdefined( event.psoffsettime ) && !isdefined( psoffsettimes[ event.endtime ] ) )
        {
            psoffsettimes[ event.endtime ] = event.psoffsettime;
        }
    }
    
    if ( psoffsettimes.size <= 0 )
    {
        scene.psoffsettime = 0;
        return;
    }
    
    var_bd9b077c40d007d2 = 0;
    
    foreach ( time in psoffsettimes )
    {
        var_bd9b077c40d007d2 += time;
    }
    
    var_dd0ea8288be58e20 = var_bd9b077c40d007d2 / psoffsettimes.size;
    scene.psoffsettime = int( var_dd0ea8288be58e20 );
}

// Namespace potg
// Params 0
// Checksum 0xcb6fe75, Offset: 0x4706
// Size: 0x623
function getfinalpotginfo()
{
    assert( level.potgenabled, "<dev string:x234>" );
    assert( issystemfinalized() || getdvarint( @"hash_a8d6f0b654204b81" ) );
    potgscene = getcurpotgscene();
    
    if ( !isdefined( potgscene ) )
    {
        return;
    }
    
    info = spawnstruct();
    info.potgscene = potgscene;
    info.starttime = potgscene.playbackstarttime;
    info.endtime = potgscene.playbackendtime;
    info.spectateentity = potgscene.primaryentity;
    info.psoffsettime = potgscene.psoffsettime ?? 0;
    info.var_df0519c0d8a13bbb = potgscene.var_df0519c0d8a13bbb;
    info.var_f12d8ea92054e01e = potgscene.var_f12d8ea92054e01e;
    info.killcamentstarttime = potgscene.killcamentstarttime;
    info.killcamentindex = potgscene.killcamentindex;
    info.killcamentstickstolookatent = potgscene.killcamentstickstolookatent;
    info.killcamlookatentityindex = potgscene.killcamlookatentityindex;
    info.objweapon = potgscene.objweapon;
    info.smeansofdeath = potgscene.smeansofdeath;
    info.var_5df854f1f75793cf = potgscene.var_5df854f1f75793cf;
    killtimes = [];
    assignedfirst = 0;
    
    foreach ( event in potgscene.events )
    {
        if ( event.eventref == #"kill" )
        {
            killtimes[ killtimes.size ] = event.endtime;
            
            /#
                potg_debugprint( "<dev string:x262>", "<dev string:x1b8>", "<dev string:x26c>" + "<dev string:x277>" + event.endtime + "<dev string:x1e0>" + ( isdefined( event.objweapon ) ? event.objweapon.basename : "<dev string:x211>" ) + "<dev string:x282>" + isdefined( info.firstweapon ), undefined );
            #/
            
            if ( !assignedfirst )
            {
                info.prestreamorigin = event.attackerorigin;
                assignedfirst = 1;
            }
            
            if ( !isdefined( info.firstweapon ) && isdefined( event.objweapon ) )
            {
                info.firstweapon = function_296c5de29e610d83( info.spectateentity, event.objweapon );
                info.scene_node = function_aadca4cf85492afd( getweapontype( info.firstweapon ) );
                
                /#
                    potg_debugprint( "<dev string:x262>", "<dev string:x1b8>", "<dev string:x29b>" + "<dev string:x2c0>" + ( isdefined( event.objweapon ) ? event.objweapon.basename : "<dev string:x211>" ) + "<dev string:x2cf>" + ( isdefined( info.firstweapon ) ? info.firstweapon.basename : "<dev string:x211>" ), undefined );
                #/
            }
        }
    }
    
    info.killtimes = killtimes;
    
    if ( !isdefined( info.firstweapon ) && isdefined( potgscene.objweapon ) )
    {
        info.firstweapon = function_296c5de29e610d83( info.spectateentity, potgscene.objweapon );
        info.scene_node = function_aadca4cf85492afd( getweapontype( info.firstweapon ) );
        
        /#
            potg_debugprint( "<dev string:x262>", "<dev string:x2de>", "<dev string:x2e1>" + "<dev string:x337>" + ( isdefined( potgscene.objweapon ) ? potgscene.objweapon.basename : "<dev string:x211>" ) + "<dev string:x2cf>" + ( isdefined( info.firstweapon ) ? info.firstweapon.basename : "<dev string:x211>" ), undefined );
        #/
    }
    
    /#
        if ( !isdefined( info.firstweapon ) )
        {
            potg_debugprint( "<dev string:x262>", "<dev string:x346>", "<dev string:x349>" + "<dev string:x380>" + ( isdefined( info.spectateentity ) ? info.spectateentity.name : "<dev string:x211>" ) + "<dev string:x39e>" + isdefined( potgscene.objweapon ), undefined );
        }
        
        potg_debugprint( "<dev string:x262>", "<dev string:x1b8>", "<dev string:x3bc>" + "<dev string:x3d6>" + ( isdefined( info.spectateentity ) ? info.spectateentity.name : "<dev string:x211>" ) + "<dev string:x3e8>" + ( isdefined( info.firstweapon ) ? info.firstweapon.basename : "<dev string:x211>" ) + "<dev string:x3fa>" + ( isdefined( info.objweapon ) ? info.objweapon.basename : "<dev string:x211>" ) + "<dev string:x40c>" + killtimes.size, undefined );
    #/
    
    if ( isdefined( info.spectateentity ) )
    {
        function_b9862652ed6904ce( info.spectateentity, info.starttime, info.endtime );
    }
    
    return info;
}

// Namespace potg
// Params 2
// Checksum 0xdb012fd4, Offset: 0x4d32
// Size: 0x183
function function_296c5de29e610d83( potgplayer, weaponobj )
{
    weapongroup = weapon::function_820c0dca2415bd8( weaponobj );
    
    if ( !weapon::iscacprimaryorsecondary( weaponobj, weapongroup ) || weapon::function_ea250bfa8e4c904b( weaponobj, weapongroup ) )
    {
        primaryweapon = potgplayer.primaryweaponobj;
        
        if ( isdefined( primaryweapon ) )
        {
            /#
                potg_debugprint( "<dev string:x41e>", "<dev string:x2de>", "<dev string:x428>" + "<dev string:x46e>" + ( isdefined( weaponobj ) ? weaponobj.basename : "<dev string:x211>" ) + "<dev string:x47d>" + primaryweapon.basename, undefined );
            #/
            
            return primaryweapon;
        }
        else
        {
            /#
                potg_debugprint( "<dev string:x41e>", "<dev string:x2de>", "<dev string:x48c>" + "<dev string:x4c1>" + ( isdefined( weaponobj ) ? weaponobj.basename : "<dev string:x211>" ) + "<dev string:x4d3>" + ( isdefined( potgplayer.classstruct.loadoutprimary ) ? potgplayer.classstruct.loadoutprimary.basename : "<dev string:x211>" ), undefined );
            #/
            
            return potgplayer.classstruct.loadoutprimary;
        }
    }
    
    /#
        potg_debugprint( "<dev string:x41e>", "<dev string:x1b8>", "<dev string:x4e5>" + "<dev string:x4f5>" + ( isdefined( weaponobj ) ? weaponobj.basename : "<dev string:x211>" ), undefined );
    #/
    
    return weaponobj;
}

// Namespace potg
// Params 1
// Checksum 0xa8af991c, Offset: 0x4ebe
// Size: 0x14b
function getweapontype( weaponobj )
{
    weapongroup = weapon::function_820c0dca2415bd8( weaponobj );
    
    if ( weapon::iscacmeleeweapon( weaponobj, weapongroup ) )
    {
        return "knife";
    }
    else if ( weapon::iscacsecondaryweapongroup( weapongroup, weaponobj ) )
    {
        return "pistol";
    }
    
    class = weaponclass( weaponobj );
    
    if ( isdefined( class ) )
    {
        switch ( class )
        {
            case #"hash_8cdaf2e4ecfe5b51":
                return "ar";
            case #"hash_fa24dff6bd60a12d":
                return "lmg";
            case #"hash_900cb96c552c5e8e":
                return "smg";
            case #"hash_690c0d6a821b42e":
                return "shotgun";
            case #"hash_6191aaef9f922f96":
                return "sniper";
            default:
                /#
                    potg_debugprint( "<dev string:x502>", "<dev string:x2de>", "<dev string:x50d>" + "<dev string:x4f5>" + ( isdefined( weaponobj ) ? weaponobj.basename : "<dev string:x211>" ) + "<dev string:x53e>" + class, undefined );
                #/
                
                return;
        }
    }
    
    /#
        potg_debugprint( "<dev string:x502>", "<dev string:x2de>", "<dev string:x54b>" + "<dev string:x4f5>" + ( isdefined( weaponobj ) ? weaponobj.basename : "<dev string:x211>" ), undefined );
    #/
}

// Namespace potg
// Params 2
// Checksum 0x7d0074a1, Offset: 0x5011
// Size: 0x76
function function_860e1cd14d89a6da( potginfo, var_ab468eb700fb827a = undefined )
{
    if ( !var_ab468eb700fb827a && isdefined( potginfo.firstweapon ) )
    {
        return potginfo.firstweapon;
    }
    
    if ( isdefined( potginfo.spectateentity ) )
    {
        return potginfo.spectateentity.currentweapon;
    }
    
    return gamelogic_mp::gethostplayer( 1 ).currentweapon;
}

// Namespace potg
// Params 2
// Checksum 0xca075f51, Offset: 0x5090
// Size: 0xab
function hintlocation( potginfo, duration )
{
    if ( isdefined( potginfo ) )
    {
        prestreamorigin = potginfo.prestreamorigin;
        
        foreach ( player in level.players )
        {
            player thread streamhint::playerstreamhintlocation( prestreamorigin, duration );
        }
    }
}

// Namespace potg
// Params 1
// Checksum 0x10f98b2c, Offset: 0x5143
// Size: 0xea
function function_99a290ec4fc479c( weapontype )
{
    if ( isdefined( weapontype ) )
    {
        if ( action_park_utility::is_enabled() )
        {
            scene_struct_array = utility::getstructarray( "scene_potg_loc_" + weapontype, "script_label" );
            arena_scene_struct_array = [];
            
            if ( scene_struct_array.size > 0 )
            {
                for ( i = 0; i < scene_struct_array.size ; i++ )
                {
                    struct = scene_struct_array[ i ];
                    target_label = "scene_potg_loc_" + weapontype;
                    
                    if ( struct.script_label == target_label && isdefined( struct.script_noteworthy ) && getxhash( struct.script_noteworthy ) == action_park_utility::get_combo_label() )
                    {
                        arena_scene_struct_array[ arena_scene_struct_array.size ] = struct;
                    }
                }
            }
            
            return arena_scene_struct_array;
        }
        else
        {
            scene_struct_array = utility::getstructarray( "scene_potg_loc_" + weapontype, "script_noteworthy" );
            return scene_struct_array;
        }
        
        return;
    }
    
    return;
}

// Namespace potg
// Params 1
// Checksum 0x3c6c1da4, Offset: 0x5235
// Size: 0x8f
function function_aadca4cf85492afd( weapontype )
{
    if ( isdefined( weapontype ) )
    {
        scene_struct_array = function_99a290ec4fc479c( weapontype );
        
        if ( scene_struct_array.size > 0 )
        {
            randomindex = randomint( scene_struct_array.size );
            return scene_struct_array[ randomindex ];
        }
    }
    
    scene_struct_array = utility::getstructarray( "bestplay_loc", "script_noteworthy" );
    
    if ( scene_struct_array.size > 0 )
    {
        randomindex = randomint( scene_struct_array.size );
        return scene_struct_array[ randomindex ];
    }
    
    scene_node = utility::getstruct( "match_end_cam", "targetname" );
    
    if ( isdefined( scene_node ) )
    {
        return scene_node;
    }
}

// Namespace potg
// Params 1
// Checksum 0xbb110f55, Offset: 0x52cd
// Size: 0x33
function function_f3e3504d21033a7( weapontype )
{
    if ( isdefined( weapontype ) )
    {
        scene_struct_array = function_99a290ec4fc479c( weapontype );
        
        if ( scene_struct_array.size > 0 )
        {
            return scene_struct_array.size;
        }
    }
    
    return 0;
}

// Namespace potg
// Params 3
// Checksum 0x2dd424b3, Offset: 0x5309
// Size: 0x90
function function_55bc1ddd313f9156( potginfo, weapontype = undefined, sceneindex = undefined )
{
    if ( isdefined( weapontype ) )
    {
        scene_struct_array = function_99a290ec4fc479c( weapontype );
        
        if ( scene_struct_array.size > 0 )
        {
            if ( sceneindex >= 0 && sceneindex < scene_struct_array.size )
            {
                return scene_struct_array[ sceneindex ];
            }
            else
            {
                randomindex = randomint( scene_struct_array.size );
                return scene_struct_array[ randomindex ];
            }
        }
    }
    
    if ( isdefined( potginfo ) )
    {
        return potginfo.scene_node;
    }
}

// Namespace potg
// Params 1
// Checksum 0x77e99367, Offset: 0x53a2
// Size: 0x176
function requestarchive( scene )
{
    level endon( #"potg_finalize" );
    scene.primaryentity endon( #"disconnect" );
    level notify( #"hash_9e3be118cd1f5ff6" );
    level endon( #"hash_9e3be118cd1f5ff6" );
    starttime = scene.playbackstarttime;
    endtime = scene.playbackendtime;
    archivetimems = getdvarint( @"hash_a8bb6306d8624c5c" ) * 1000;
    assert( endtime > starttime );
    assert( endtime - starttime <= archivetimems, "<dev string:x581>" );
    assert( gettime() - archivetimems <= starttime, "<dev string:x5d6>" );
    var_5bccb81b78534c94 = starttime + archivetimems;
    var_cac26d6835064601 = var_5bccb81b78534c94 - gettime();
    assert( var_cac26d6835064601 >= 0 );
    function_fbfa0c121ef06b30( var_cac26d6835064601 * 0.001 );
    level utility::waittill_any_timeout( var_cac26d6835064601 * 0.001, "start_game_ended", "game_ended", "round_end" );
    
    if ( scene.score >= getbestpotgscore() )
    {
        if ( level.potgglobals.archiveinprogress )
        {
            logstring( "^5[POTG] CANNOT ARCHIVE SCENE #" + scene.sceneid + " WHILE ANOTHER SCENE IS IN THE PROCESS OF BEING ARCHIVED ----- timestamp: " + gettime() );
            return;
        }
        
        thread archivecurrentgamestate( scene );
    }
}

// Namespace potg
// Params 1
// Checksum 0xd460fa30, Offset: 0x5520
// Size: 0x30b
function archivecurrentgamestate( scene )
{
    level endon( #"game_ended" );
    level.potgglobals.archiveinprogress = 1;
    logstring( "^5[POTG] ARCHIVING IN PROGRESS... timestamp: " + gettime() );
    savepotgdata();
    level waittill( #"hash_f5f843fcb7f5dbc", archiveresult );
    
    if ( archiveresult )
    {
        logstring( "^5[POTG] ARCHIVE RESULT: SUCCESSFUL. ----- timestamp: " + gettime() );
        archivestarttimems = getpotgstarttime();
        potgduration = getpotgduration();
        archiveendtimems = archivestarttimems + potgduration;
        logstring( "^5[POTG] ARCHIVE START TIME (ms): " + archivestarttimems );
        logstring( "^5[POTG] ARCHIVE END TIME (ms): " + archiveendtimems );
        logstring( "^5[POTG] POTG DURATION (ms): " + potgduration );
        level.potgglobals.curpotgscene = scene;
        function_7a991e71a1c7dae7( scene );
        
        /#
            potg_debugprint( "<dev string:x62d>", "<dev string:x1b8>", "<dev string:x635>" + "<dev string:x661>" + ( isdefined( scene.primaryentity ) ? scene.primaryentity.name : "<dev string:x211>" ) + "<dev string:x672>" + scene.score + "<dev string:x683>" + archivestarttimems + "<dev string:x694>" + archiveendtimems, undefined );
        #/
        
        if ( level.gamemodebundle.var_9d5788eccc5658fb )
        {
            if ( isdefined( level.var_e5c1a60c8fcb0e03 ) && level.var_e5c1a60c8fcb0e03 != scene.primaryentity )
            {
                level.var_e5c1a60c8fcb0e03 thread hud_message::showsplash( "callout_best_play_lost", undefined, level.var_e5c1a60c8fcb0e03 );
            }
            
            level.var_e5c1a60c8fcb0e03 = scene.primaryentity;
            scene.primaryentity thread hud_message::showsplash( "callout_best_play_earned", undefined, scene.primaryentity );
        }
        
        var_719c3dce472f847a = level.potgglobals.lastarchivetime;
        level.potgglobals.lastarchivetime = gettime();
        timesincelastarchive = -1;
        
        if ( var_719c3dce472f847a > 0 )
        {
            timesincelastarchive = level.potgglobals.lastarchivetime - var_719c3dce472f847a;
            
            if ( timesincelastarchive < getrapidarchivewarningrate() )
            {
                logstring( "^5[POTG] ARCHIVING TOO FREQUENTLY -- " + timesincelastarchive + "MS since last archive" );
            }
        }
        
        function_c8fd14643a45cafa( scene, archivestarttimems, archiveendtimems, potgduration );
    }
    else
    {
        level.potgglobals.var_4a42bed215732bce = undefined;
        logstring( "^5[POTG] ARCHIVE RESULT: FAILED... DISCARDING THIS SCENE AND REVERTING TO PREVIOUS BEST PLAY" );
        
        /#
            potg_debugprint( "<dev string:x62d>", "<dev string:x346>", "<dev string:x6a5>" + "<dev string:x661>" + ( isdefined( scene.primaryentity ) ? scene.primaryentity.name : "<dev string:x211>" ) + "<dev string:x672>" + scene.score, undefined );
        #/
        
        function_ca29ca2e12f1901f( scene );
    }
    
    level.potgglobals.archiveinprogress = 0;
}

// Namespace potg
// Params 4
// Checksum 0x4941141c, Offset: 0x5833
// Size: 0x131
function function_c8fd14643a45cafa( scene, archivestarttimems, archiveendtimems, potgduration )
{
    var_a8c36f66c485273b = function_b489dd728d45043e( scene.events );
    var_16ce39a3fe33e26c = [ "total_score", scene.score, "scene_start_time", scene.playbackstarttime, "scene_end_time", scene.playbackendtime, "archive_start_time", archivestarttimems, "archive_end_time", archiveendtimems, "initial_time_clamping", archivestarttimems - scene.playbackstarttime, "end_time_clamping", scene.playbackendtime - archiveendtimems ];
    
    if ( isplayer( scene.primaryentity ) )
    {
        scene.primaryentity dlog_recordplayerevent( "dlog_event_mp_potg_archive_success", [ "potg_score_events", var_a8c36f66c485273b, "potg_info", var_16ce39a3fe33e26c ] );
    }
}

// Namespace potg
// Params 1
// Checksum 0x475af4cd, Offset: 0x596c
// Size: 0x122
function function_b489dd728d45043e( events )
{
    var_a8c36f66c485273b = [];
    idx = 0;
    
    foreach ( event in events )
    {
        potg_score_event = [];
        potg_score_event[ 0 ] = "event_ref";
        potg_score_event[ 1 ] = event.eventref;
        potg_score_event[ 2 ] = "event_score";
        potg_score_event[ 3 ] = event.score;
        potg_score_event[ 4 ] = "start_time";
        potg_score_event[ 5 ] = event.starttime;
        potg_score_event[ 6 ] = "end_time";
        potg_score_event[ 7 ] = event.endtime;
        potg_score_event[ 8 ] = "highlight_event";
        potg_score_event[ 9 ] = event.var_2627d300cc19e67e;
        var_a8c36f66c485273b[ idx ] = potg_score_event;
        idx++;
    }
    
    return var_a8c36f66c485273b;
}

// Namespace potg
// Params 1
// Checksum 0x200e87b5, Offset: 0x5a97
// Size: 0xfe
function function_ca29ca2e12f1901f( scene )
{
    var_a8c36f66c485273b = function_b489dd728d45043e( scene.events );
    var_16ce39a3fe33e26c = [ "total_score", scene.score, "scene_start_time", scene.playbackstarttime, "scene_end_time", scene.playbackendtime, "archive_start_time", -1, "archive_end_time", -1, "initial_time_clamping", -1, "end_time_clamping", -1 ];
    
    if ( isplayer( scene.primaryentity ) )
    {
        scene.primaryentity dlog_recordplayerevent( "dlog_event_mp_potg_archive_failure", [ "potg_score_events", var_a8c36f66c485273b, "potg_info", var_16ce39a3fe33e26c ] );
    }
}

// Namespace potg
// Params 0
// Checksum 0xf27480aa, Offset: 0x5b9d
// Size: 0x1a
function getrapidarchivewarningrate()
{
    return getdvarint( @"hash_a8bb6306d8624c5c" ) * 1000 - getwholescenedurationmax();
}

// Namespace potg
// Params 4
// Checksum 0xd11428d3, Offset: 0x5bc0
// Size: 0x91
function function_b81e83c33eb842b0( starttimems, endtimems, var_74f7df8e07c18fdd, var_ba3b32fb2c49af54 )
{
    if ( getdvarint( @"potg_debug_print", 0 ) == 0 )
    {
        return;
    }
    
    if ( var_74f7df8e07c18fdd != starttimems )
    {
        logstring( "^5[POTG] Clamping playback start time...  " );
        logstring( "^5[POTG] Designated start time: " + starttimems );
        logstring( "^5[POTG] Clamped start time: " + var_74f7df8e07c18fdd );
    }
    
    if ( var_ba3b32fb2c49af54 != endtimems )
    {
        logstring( "^5[POTG] Clamping playback end time...  " );
        logstring( "^5[POTG] Designated end time: " + endtimems );
        logstring( "^5[POTG] Clamped end time: " + var_ba3b32fb2c49af54 );
    }
}

// Namespace potg
// Params 0
// Checksum 0x6679545c, Offset: 0x5c59
// Size: 0x30
function datalog_getlogversion()
{
    if ( getdvarint( @"scr_playtest_qa", 0 ) != 0 )
    {
        return -1;
    }
    
    if ( getdvarint( @"scr_playtest", 0 ) != 0 )
    {
        return 9;
    }
    
    return -1;
}

// Namespace potg
// Params 0
// Checksum 0x882006a, Offset: 0x5c92
// Size: 0x11, Type: bool
function datalog_isloggingenabled()
{
    return getdvarint( @"potg_datalog" ) != 0;
}

// Namespace potg
// Params 1
// Checksum 0x4ab412c9, Offset: 0x5cac
// Size: 0x1ff
function datalog_scenefinalized( scene )
{
    if ( !datalog_isloggingenabled() )
    {
        return;
    }
    
    scriptversion = datalog_getlogversion();
    dlog_recordevent( "mpscript_potg", [ "score", scene.score, "duration", scene.playbackendtime - scene.playbackstarttime, "start_time", scene.playbackstarttime, "action_start_offset", scene.actionstarttime - scene.playbackstarttime, "action_end_offset", scene.actionendtime - scene.playbackstarttime, "entity_id", scene.primaryentity.potgid ?? getentityid( scene.primaryentity ), "script_version", scriptversion ] );
    
    foreach ( event in scene.events )
    {
        dlog_recordevent( "mpscript_potg_final_events", [ "event_ref", event.eventref, "score", event.score, "start_time", event.playbackstarttime, "end_time", event.playbackendtime, "script_version", scriptversion ] );
    }
}

// Namespace potg
// Params 3
// Checksum 0xf6018013, Offset: 0x5eb3
// Size: 0xd9
function datalog_newevent( event, id, entity )
{
    if ( !datalog_isloggingenabled() )
    {
        return;
    }
    
    dlog_recordevent( "mpscript_potg_events", [ "event_ref", event.eventref, "score", event.score, "start_time", event.starttime, "end_time", event.endtime, "event_id", id, "entity_id", entity.potgid ?? getentityid( entity ), "script_version", datalog_getlogversion() ] );
}

// Namespace potg
// Params 5
// Checksum 0xb25ee62d, Offset: 0x5f94
// Size: 0xf9
function datalog_archivesaved( requesttime, archivestarttime, archiveduration, desiredscenestarttime, desiredsceneendtime )
{
    if ( getdvarint( @"potg_debug_archive", 0 ) == 0 )
    {
        return;
    }
    
    dlog_recordevent( "mpscript_potg_archive", [ "requestTime", requesttime, "archiveStartTime", archivestarttime, "archiveDuration", archiveduration, "desiredSceneStartTime", desiredscenestarttime, "desiredSceneEndTime", desiredsceneendtime, "playerCount", level.players.size, "tickRate", int( 1 / level.framedurationseconds ), "dedi", isdedicatedserver() ? 1 : 0, "version", 0 ] );
}

// Namespace potg
// Params 2
// Checksum 0x231408f, Offset: 0x6095
// Size: 0x4d
function debug_watcharchivesize( prevstarttime, scene )
{
    if ( getdvarint( @"potg_debug_print" ) == 0 )
    {
        return;
    }
    
    requesttime = gettime();
    thread debug_watcharchivefinished( requesttime, prevstarttime, scene );
    thread debug_watcharchiveinterrupted( requesttime, scene );
}

// Namespace potg
// Params 3
// Checksum 0x8d3b79d4, Offset: 0x60ea
// Size: 0x89
function debug_watcharchivefinished( requesttime, prevstarttime, scene )
{
    if ( getdvarint( @"potg_debug_print" ) == 0 )
    {
        return;
    }
    
    level notify( #"hash_a073e52cf1272bc2" );
    level endon( #"hash_a073e52cf1272bc2" );
    
    while ( true )
    {
        curstarttime = getpotgstarttime();
        
        if ( curstarttime != prevstarttime )
        {
            level notify( #"hash_63e034b7c55b4a29" );
            debug_logarchiveresult( 1, scene, requesttime, curstarttime, getpotgduration() );
            break;
        }
        
        waitframe();
    }
}

// Namespace potg
// Params 2
// Checksum 0x737c6bf6, Offset: 0x617b
// Size: 0x4c
function debug_watcharchiveinterrupted( requesttime, scene )
{
    if ( getdvarint( @"potg_debug_print" ) == 0 )
    {
        return;
    }
    
    level endon( #"hash_63e034b7c55b4a29" );
    level waittill( #"hash_a073e52cf1272bc2" );
    debug_logarchiveresult( 0, scene, requesttime );
}

// Namespace potg
// Params 5
// Checksum 0xe21c2bc1, Offset: 0x61cf
// Size: 0x150
function debug_logarchiveresult( result, scene, requesttime, finalstarttime, finalduration )
{
    if ( getdvarint( @"potg_debug_print" ) == 0 )
    {
        return;
    }
    
    if ( result )
    {
        thread datalog_archivesaved( requesttime, finalstarttime, finalduration, scene.playbackstarttime, scene.playbackendtime );
    }
    
    logstring( "^5[POTG] Archive Result: " );
    logstring( "^5[POTG]\tResult: " + ( result ? "Finished" : "Interrupted" ) );
    logstring( "^5[POTG]\tRequest Time: " + requesttime );
    logstring( "^5[POTG]\tRequest Processing Time: " + gettime() - requesttime );
    
    if ( result )
    {
        logstring( "^5[POTG]\tArchive Start Time: " + finalstarttime );
        logstring( "^5[POTG]\tArchive Duration: " + finalduration );
        logstring( "^5[POTG]\tRequested Duration: " + scene.playbackendtime - scene.playbackstarttime );
        logstring( "^5[POTG]\tScene Start Time: " + scene.playbackstarttime );
        logstring( "^5[POTG]\tScene End Time: " + scene.playbackendtime );
        logstring( "^5[POTG]\tStart Clipping: " + finalstarttime - scene.playbackstarttime );
        logstring( "^5[POTG]\tEnd Clipping: " + scene.playbackendtime - finalstarttime + finalduration );
    }
}

// Namespace potg
// Params 2
// Checksum 0xc1e5919c, Offset: 0x6327
// Size: 0x6d
function debug_print( text, entity )
{
    if ( getdvarint( @"potg_debug_print" ) == 0 )
    {
        return;
    }
    
    entitytext = function_ceee585761848687( entity );
    
    if ( entitytext != "" )
    {
        entitytext = "(" + entitytext + ")";
    }
    
    logstring( "^5[POTG]" + entitytext + ": " + text );
}

// Namespace potg
// Params 1
// Checksum 0x39ac0d30, Offset: 0x639c
// Size: 0x70
function function_ceee585761848687( entity )
{
    if ( getdvarint( @"potg_debug_print" ) == 0 )
    {
        return;
    }
    
    entitytext = "";
    
    if ( isent( entity ) )
    {
        if ( isplayer( entity ) )
        {
            entitytext = entity.name;
        }
        else
        {
            entitytext = string( entity.potgid ?? getentityid( entity ) );
        }
    }
    
    return entitytext;
}

// Namespace potg
// Params 2
// Checksum 0x7e713c0, Offset: 0x6415
// Size: 0x39
function function_e8b8c5ac26c646b3( entity, registered )
{
    if ( getdvarint( @"potg_debug_print" ) == 0 )
    {
        return;
    }
    
    debug_print( "Register - " + registered, entity );
}

// Namespace potg
// Params 2
// Checksum 0x696ea6d8, Offset: 0x6456
// Size: 0x6c
function function_14b11fe54592d39c( entity, changetype )
{
    if ( getdvarint( @"potg_debug_print" ) == 0 )
    {
        return;
    }
    
    filterid = getdvarint( @"hash_c50427c6f2e00c08", -1 );
    
    if ( filterid != -1 && getentityid( entity ) != filterid )
    {
        return;
    }
    
    debug_print( "Recording - " + changetype, entity );
}

// Namespace potg
// Params 0
// Checksum 0x3609d82b, Offset: 0x64ca
// Size: 0x21
function function_888d91c84eda8969()
{
    if ( getdvarint( @"potg_debug_print" ) == 0 )
    {
        return;
    }
    
    debug_print( "Recording FINALIZED" );
}

// Namespace potg
// Params 5
// Checksum 0x1026c178, Offset: 0x64f3
// Size: 0xb9
function debug_printevent( entity, eventref, eventscore, starttime, endtime )
{
    if ( getdvarint( @"potg_debug_print" ) == 0 )
    {
        return;
    }
    
    filterid = getdvarint( @"hash_c50427c6f2e00c08", -1 );
    
    if ( filterid != -1 && getentityid( entity ) != filterid )
    {
        return;
    }
    
    if ( isxhash( eventref ) )
    {
        eventref = getxhashhexname( eventref );
    }
    
    debug_print( "New Event: " + eventref + " +" + eventscore + " pts (S: " + starttime + ", E: " + endtime + ")", entity );
}

// Namespace potg
// Params 3
// Checksum 0xbe329ca7, Offset: 0x65b4
// Size: 0xa9
function function_ae6d8e82bd7a79ce( entity, score, eventcount )
{
    if ( getdvarint( @"potg_debug_print" ) == 0 )
    {
        return;
    }
    
    filterid = getdvarint( @"hash_c50427c6f2e00c08", -1 );
    
    if ( filterid != -1 && getentityid( entity ) != filterid )
    {
        return;
    }
    
    debug_print( "New Scene Rejected", entity );
    debug_print( "\tScore: " + score, entity );
    debug_print( "\tBest Score: " + getbestpotgscore(), entity );
    debug_print( "\tEventCount: " + eventcount, entity );
}

// Namespace potg
// Params 3
// Checksum 0x80a1f397, Offset: 0x6665
// Size: 0xf8
function function_948be00de9108e99( entity, scene, reason )
{
    if ( getdvarint( @"potg_debug_print" ) == 0 )
    {
        return;
    }
    
    filterid = getdvarint( @"hash_c50427c6f2e00c08", -1 );
    
    if ( filterid != -1 && getentityid( entity ) != filterid )
    {
        return;
    }
    
    debug_print( "Pending Scene #" + scene.sceneid + " Rejected - " + reason, entity );
    debug_print( "\tScore: " + scene.score, entity );
    debug_print( "\tBest Score: " + getbestpotgscore(), entity );
    debug_print( "\tEventCount: " + scene.events.size, entity );
    function_6ab70ccc40b1e349( scene );
    function_deb3cddfbf4998d6( scene.events );
    debug_print( "\n" );
}

// Namespace potg
// Params 2
// Checksum 0x1cda1ab3, Offset: 0x6765
// Size: 0x90
function function_fe55157f3ef56c71( scene, text )
{
    if ( getdvarint( @"potg_debug_print" ) == 0 )
    {
        return;
    }
    
    filterid = getdvarint( @"hash_c50427c6f2e00c08", -1 );
    
    if ( filterid != -1 && getentityid( scene.primaryentity ) != filterid )
    {
        return;
    }
    
    debug_print( "Pending Scene #" + scene.sceneid + " - " + text, scene.primaryentity );
}

// Namespace potg
// Params 1
// Checksum 0x8a4ee9fe, Offset: 0x67fd
// Size: 0xb7
function function_7a991e71a1c7dae7( scene )
{
    if ( getdvarint( @"potg_debug_print" ) == 0 )
    {
        return;
    }
    
    debug_print( "NEW POTG: Scene #" + scene.sceneid + ", Score: " + scene.score + ", Entity: " + function_ceee585761848687( scene.primaryentity ) );
    debug_print( "MAP: " + level.mapname + " -- GAMETYPE: " + level.gametype );
    function_7bb100d0a2edb8bd( scene );
    function_6ab70ccc40b1e349( scene );
    function_deb3cddfbf4998d6( scene.events );
    debug_print( "\n" );
}

// Namespace potg
// Params 1
// Checksum 0x962136a3, Offset: 0x68bc
// Size: 0xb7
function debug_scenefinalized( scene )
{
    if ( getdvarint( @"potg_debug_print" ) == 0 )
    {
        return;
    }
    
    debug_print( "Viewing POTG: Scene #" + scene.sceneid + ", Score: " + scene.score + ", Entity: " + function_ceee585761848687( scene.primaryentity ) );
    debug_print( "MAP: " + level.mapname + " -- GAMETYPE: " + level.gametype );
    function_7bb100d0a2edb8bd( scene );
    function_6ab70ccc40b1e349( scene );
    function_deb3cddfbf4998d6( scene.events );
    debug_print( "\n" );
}

// Namespace potg
// Params 1
// Checksum 0xbdba62e6, Offset: 0x697b
// Size: 0x133
function function_7bb100d0a2edb8bd( scene )
{
    if ( getdvarint( @"potg_debug_print" ) == 0 )
    {
        return;
    }
    
    debug_print( "\tPlayback Start Time: " + scene.playbackstarttime );
    debug_print( "\tPlayback End Time: " + scene.playbackendtime );
    debug_print( "\tTotal Duration: " + scene.playbackendtime - scene.playbackstarttime );
    debug_print( "\tAction Start Time: " + scene.actionstarttime );
    debug_print( "\tAction End Time: " + scene.actionendtime );
    debug_print( "\tAction Duration: " + scene.actionendtime - scene.actionstarttime );
    debug_print( "\tPre-Action Duration: " + scene.actionstarttime - scene.playbackstarttime );
    debug_print( "\tPost-Action Duration: " + scene.playbackendtime - scene.actionendtime );
    debug_print( "\tAction End Offset: " + scene.actionendtime - scene.playbackstarttime );
}

// Namespace potg
// Params 1
// Checksum 0xc6d0708f, Offset: 0x6ab6
// Size: 0x12f
function function_6ab70ccc40b1e349( scene )
{
    if ( !isdefined( scene ) )
    {
        return;
    }
    
    if ( getdvarint( @"potg_debug_print" ) == 0 )
    {
        return;
    }
    
    if ( !level.gametypebundle.var_2e615b9703b5b0be )
    {
        return;
    }
    
    if ( isdefined( scene.events ) && utility::array_get_first_item( scene.events ).eventref )
    {
        debug_print( "\tCatalyst Event: " + getxhashhexname( utility::array_get_first_item( scene.events ).eventref ) );
    }
    
    if ( isdefined( scene.primaryentity ) )
    {
        debug_print( "\tIn-Match Player Featuring Debuff Modifier: " + function_372fdd3fa94fe7ef( scene.primaryentity ) );
        debug_print( "\tPersistent Player Profile Weighting Modifier: " + function_a442325ca9a7a69( scene.primaryentity ) );
    }
    
    if ( scene.playerdeathpresent )
    {
        debug_print( "\tPlayer Death Debuff Modifier: " + ( level.gametypebundle.var_342f3331bbeb5c9b ?? 1 ) );
        debug_print( "\tTime of death: " + scene.lastplayerdeathtime );
    }
}

// Namespace potg
// Params 1
// Checksum 0x3a31a4a9, Offset: 0x6bed
// Size: 0x1a3
function function_deb3cddfbf4998d6( events )
{
    if ( getdvarint( @"potg_debug_print" ) == 0 )
    {
        return;
    }
    
    debug_print( "\tEvents:" );
    
    foreach ( event in events )
    {
        var_436b64213d137818 = getxhashhexname( event.eventref );
        
        if ( level.gametypebundle.var_2e615b9703b5b0be )
        {
            if ( function_6a1588cbcf0543ae( event.eventref ) == 1 )
            {
                debug_print( "\t\t" + var_436b64213d137818 + " = +" + event.score + " pts" + "\t\t( timestamp: " + event.endtime + ")" );
            }
            else
            {
                debug_print( "\t\t" + var_436b64213d137818 + " = +" + event.score + " pts" + "\t\t(Event Debuff Modifier = " + function_6a1588cbcf0543ae( event.eventref ) + ")" + "\t( timestamp: " + event.endtime + ")" );
            }
            
            continue;
        }
        
        debug_print( "\t\t" + var_436b64213d137818 + " = +" + event.score + " pts" );
    }
}

// Namespace potg
// Params 1
// Checksum 0x8bfa58c1, Offset: 0x6d98
// Size: 0x34
function function_fbfa0c121ef06b30( waittime )
{
    if ( getdvarint( @"potg_debug_print" ) == 0 )
    {
        return;
    }
    
    debug_print( "POTG Requesting Archive, waiting " + waittime + "s " );
}

/#

    // Namespace potg
    // Params 0
    // Checksum 0x1fa783d0, Offset: 0x6dd4
    // Size: 0x1b5, Type: dev
    function function_b75793cc5721fc6c()
    {
        if ( getdvarint( @"nodebug", 0 ) >= 1 )
        {
            return;
        }
        
        level endon( #"game_ended" );
        self endon( #"disconnect" );
        self.var_20fd030eb7ada77e = [];
        self.var_4fbf6790a1f1d110 = [];
        self.var_570c6cab071d43ef = 0;
        
        if ( isai( self ) )
        {
            return;
        }
        
        while ( true )
        {
            if ( getdvarint( @"hash_c2407250e6c4bbbc" ) == 1 && self ishost() )
            {
                foreach ( id, time in self.var_4fbf6790a1f1d110 )
                {
                    if ( gettime() - time > 5000 )
                    {
                        self.var_4fbf6790a1f1d110[ id ] = undefined;
                        self.var_20fd030eb7ada77e[ id ] = undefined;
                    }
                }
                
                displaycount = int( min( 10, self.var_20fd030eb7ada77e.size ) );
                
                if ( displaycount > 0 )
                {
                    startid = self.var_570c6cab071d43ef - 1;
                    endid = int( max( 0, startid - displaycount - 1 ) );
                    texty = 400;
                    
                    for ( id = startid; id >= endid ; id-- )
                    {
                        printtoscreen2d( 100, texty, self.var_20fd030eb7ada77e[ id ], ( 1, 0.5, 0.7 ), 1.5 );
                        texty += 20;
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace potg
    // Params 1
    // Checksum 0xcb03ec58, Offset: 0x6f91
    // Size: 0x8d, Type: dev
    function function_a6db4721e3a8cb3d( eventref )
    {
        dvarvalue = getdvarint( @"hash_c2407250e6c4bbbc" );
        
        if ( isxhash( eventref ) )
        {
            eventref = getxhashsourcename( eventref );
        }
        
        if ( dvarvalue == 1 )
        {
            self.var_20fd030eb7ada77e[ self.var_570c6cab071d43ef ] = eventref;
            self.var_4fbf6790a1f1d110[ self.var_570c6cab071d43ef ] = gettime();
            self.var_570c6cab071d43ef++;
            return;
        }
        
        if ( dvarvalue == 2 )
        {
            debug_print( eventref );
        }
    }

#/
