// script_75b994f10201e95c  (hash_75b994f10201e95c.gscc) (size: 11360 Bytes / 0x2c60 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5a0c8f1a (1510772506)
// size ...... 11360 (0x2c60)
// includes .. 7   (offset: 0x2a68)
// strings ... 25  (offset: 0x2aa0)
// dev strs .. 6   (offset: 0x2c18)
// exports ... 24  (offset: 0x1fc4)
// cseg ...... 0x1f9 + 0x1dcb (0x1fc4)
// imports ... 55  (offset: 0x2384)
// animtree1 . 0   (offset: 0x2c60)
// animtree2 . 0   (offset: 0x2c60)
#using scripts\common\callbacks;
#using scripts\common\omnvar_utility;
#using scripts\common\telemetry_utils;
#using scripts\common\utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\flags;
#using scripts\mp\poi;

#namespace namespace_8cdbb6d4564d9fae;

// Namespace namespace_8cdbb6d4564d9fae
// Params 0
// Checksum 0xecfc3009, Offset: 0x217
// Size: 0x5e0
function init()
{
    if ( getdvarint( @"scr_mp_billboards_enabled", 0 ) == 0 )
    {
        return;
    }
    
    if ( !flags::gameflagexists( "billboard_init_done" ) )
    {
        flags::gameflaginit( "billboard_init_done", 0 );
    }
    
    level.billboards = {};
    level.billboards.billboardtypeslist = game_utility_mp::function_cb7ed8e67866f9d0( "brbillboardtypeslist" );
    level waittill( #"player_spawned" );
    function_a9cee6ad7200dd95();
    
    if ( level.billboards.ents.size == 0 )
    {
        return;
    }
    
    advertisementbundle = game_utility_mp::function_cb7ed8e67866f9d0( "digitalbillboardadvertisements" );
    
    if ( !isdefined( advertisementbundle ) )
    {
        return;
    }
    
    var_b313639b42bd4991 = randomint( advertisementbundle.advertisementsets.size );
    advertisementset = advertisementbundle.advertisementsets[ var_b313639b42bd4991 ];
    
    if ( !isdefined( advertisementset ) )
    {
        return;
    }
    
    level.billboards.regularads = advertisementset.advertisementlist;
    level.billboards.var_c7ebdf4727a42f5b = advertisementbundle.var_ff09d9f4763c4bf6;
    var_847911eabf5d74b0 = level.billboards.regularads.size;
    
    if ( var_847911eabf5d74b0 == 0 )
    {
        return;
    }
    
    level.billboards.gameplayevents = advertisementbundle.gameplayevents;
    level.billboards.unifieddisplay = 0;
    level.billboards.var_14b4e18257743c16 = getdvarint( @"scr_mp_billboards_advertisement_display_time", 7 );
    function_968696929dcabe76();
    function_2c1d829dc47df355();
    cooldown = getdvarint( @"scr_mp_billboards_gameplay_events_cooldown", 0 );
    
    if ( cooldown <= 0 )
    {
        cooldown = ( level.billboards.var_1d9a1a7255ac310d + 1 ) * level.billboards.var_14b4e18257743c16;
    }
    
    level.billboards.var_a7c3bb9d60254dfe = cooldown;
    level.billboards.var_2a540eee8597a302 = [];
    level.billboards.var_55c6b7d9e0bc13b9 = [];
    level.billboards.var_63c167b9421bbb9d = getdvarint( @"hash_1269103b21c7f6f7", 30 );
    level.billboards.var_77d70ecb1881998 = getdvarint( @"hash_1c5ef8df610ff0d2", 1 ) == 1;
    assert( var_847911eabf5d74b0 <= 10, "<dev string:x24>" );
    flags::gameflaginit( "billboard_advertisement_ready", 1 );
    level function_979fcac256953b9( var_b313639b42bd4991 + 1 );
    level thread function_22ccacc9387a9264( var_847911eabf5d74b0 );
    
    if ( getdvarint( @"hash_1ecb4ee1b513876d", 0 ) == 0 && isdefined( level.billboards.gameplayevents ) && level.billboards.gameplayevents.size > 0 )
    {
        level.billboards.gameplaytriggers = [];
        level.billboards.var_5072e428ff93ef4c = getdvarint( @"hash_d1a7be783ab881f9", 0 );
        
        if ( getdvarint( @"hash_e8af522d932e0df6", 1 ) == 1 )
        {
            if ( level.billboards.var_77d70ecb1881998 )
            {
                level.billboards.var_bdd574e7f14d1c37 = level.billboards.var_63c167b9421bbb9d;
            }
            else
            {
                level.billboards.var_bccbd19db92d0ac9 = getdvarint( @"hash_83eb61fd6910d5df", 10 );
                level.billboards.var_bdd574e7f14d1c37 = getdvarint( @"hash_3ae7b8bc6636fb3d", 20 );
            }
            
            function_d89f723a1b6fa8de( "highActivity", &function_1c601409b6e08d2 );
        }
        
        if ( getdvarint( @"scr_mp_billboards_kill_events_enabled", 0 ) == 1 )
        {
            var_3940d82f9d9d8c5e = getdvar( @"hash_2695369ab6b17928", "10 15 20" );
            
            if ( var_3940d82f9d9d8c5e != "" )
            {
                level.billboards.var_3940d82f9d9d8c5e = strtok( var_3940d82f9d9d8c5e, " " );
                level.billboards.var_f4e8cc42a9f8d536 = 0;
                level.billboards.var_bb87c6779e01772e = 0;
                callback::add( "br_player_killed", &billboards_onplayerkilled );
                
                if ( level.billboards.var_77d70ecb1881998 )
                {
                    level.billboards.var_4e53afbe849a32a7 = level.billboards.var_63c167b9421bbb9d;
                    function_d89f723a1b6fa8de( "killWarning", &function_5813d91738a2887 );
                }
                else
                {
                    level.billboards.var_4e53afbe849a32a7 = getdvarint( @"scr_mp_billboards_kill_warning_time", 20 );
                    
                    for ( i = 0; i < level.billboards.var_3940d82f9d9d8c5e.size ; i++ )
                    {
                        function_d89f723a1b6fa8de( "killWarning" + i, &function_b17d9bd4602b18e7, i + 1 );
                    }
                }
            }
        }
        
        if ( level.billboards.var_77d70ecb1881998 )
        {
            if ( getdvarint( @"hash_e5890eadf0fb0052", 1 ) == 1 )
            {
                level.billboards.var_6a9cb092a896da58 = level.billboards.var_63c167b9421bbb9d;
                function_d89f723a1b6fa8de( "topScorer", &function_8e02f557d6496836 );
            }
            
            level thread function_821562e9aee4355f();
        }
        else
        {
            level thread function_12102d9732523b54();
        }
    }
    
    level thread function_cd3c9638ebb95fcf();
    
    if ( level.billboards.var_77d70ecb1881998 )
    {
        callback::add( #"prematch_done", &function_b5e2d0b4b8c2a9a0 );
    }
    
    flags::gameflagset( "billboard_init_done" );
}

// Namespace namespace_8cdbb6d4564d9fae
// Params 0
// Checksum 0xbd2053a0, Offset: 0x7ff
// Size: 0x19, Type: bool
function function_8f8e633d55c4fe83()
{
    return level.billboards.var_77d70ecb1881998 ?? 0;
}

// Namespace namespace_8cdbb6d4564d9fae
// Params 0
// Checksum 0xd48541e, Offset: 0x821
// Size: 0x2ec
function function_a9cee6ad7200dd95()
{
    level.billboards.ents = [];
    billboardtypeslist = level.billboards.billboardtypeslist;
    
    if ( !isdefined( billboardtypeslist ) )
    {
        return;
    }
    
    foreach ( type in billboardtypeslist.billboardtypes )
    {
        billboards = getentitylessscriptablearray( "scriptable_" + type.billboardtype, "classname" );
        var_a3de4dbd4875fe63 = [];
        usedpois = [];
        
        foreach ( billboard in billboards )
        {
            poi = poi::poi_findpoioriginisin( billboard.origin );
            
            /#
                if ( !isdefined( poi ) )
                {
                    poi = "<dev string:x78>";
                }
            #/
            
            if ( !isdefined( var_a3de4dbd4875fe63[ poi ] ) )
            {
                var_a3de4dbd4875fe63[ poi ] = [];
                usedpois[ usedpois.size ] = poi;
            }
            
            var_a3de4dbd4875fe63[ poi ][ var_a3de4dbd4875fe63[ poi ].size ] = billboard;
        }
        
        foreach ( poi in usedpois )
        {
            index = randomint( type.numstates );
            
            foreach ( billboard in var_a3de4dbd4875fe63[ poi ] )
            {
                state = index % type.numstates + 1;
                billboard.state = "rt" + state;
                billboard setscriptablepartstate( "root", billboard.state );
                index++;
            }
        }
        
        level.billboards.ents = arraycombine( level.billboards.ents, billboards );
    }
}

// Namespace namespace_8cdbb6d4564d9fae
// Params 0
// Checksum 0x229751d9, Offset: 0xb15
// Size: 0x64
function function_6a821b52c829cafd()
{
    mapinfo = getmapscriptbundle();
    
    if ( !isdefined( mapinfo.billboardtypeslist ) )
    {
        return;
    }
    
    var_7237854e3be197ca = getscriptbundle( mapinfo.billboardtypeslist );
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    assertmsg( "<dev string:x7f>" + mapinfo.billboardtypeslist + "<dev string:x95>" );
}

// Namespace namespace_8cdbb6d4564d9fae
// Params 1, eflags: 0x4
// Checksum 0xe6f81339, Offset: 0xb81
// Size: 0x119
function private function_22ccacc9387a9264( var_847911eabf5d74b0 )
{
    displaytime = level.billboards.var_14b4e18257743c16;
    
    if ( level.billboards.var_77d70ecb1881998 )
    {
        displaytime = level.billboards.var_63c167b9421bbb9d;
    }
    
    for ( i = 0; i < var_847911eabf5d74b0 ; i++ )
    {
        var_6b6475db59e8c4c1 = { #displaytime:displaytime, #unifieddisplay:level.billboards.regularads[ i ].unifieddisplay, #index:i, #type:3 };
        level.billboards.var_2a540eee8597a302[ level.billboards.var_2a540eee8597a302.size ] = var_6b6475db59e8c4c1;
    }
    
    level.billboards.var_2a540eee8597a302 = arrayrandomize( level.billboards.var_2a540eee8597a302 );
}

// Namespace namespace_8cdbb6d4564d9fae
// Params 0
// Checksum 0x1c3f282d, Offset: 0xca2
// Size: 0x130
function function_821562e9aee4355f()
{
    randomarray = [];
    
    foreach ( gameplaytrigger in level.billboards.gameplaytriggers )
    {
        gameplayeventindex = level.billboards.var_9ee1b2068170dd[ gameplaytrigger.eventname ];
        var_56c2b45daf75ba80 = { #gameplaytrigger:gameplaytrigger, #unifieddisplay:level.billboards.gameplayevents[ gameplayeventindex ].var_5789a34a121a69e3.unifieddisplay, #index:gameplayeventindex, #type:2 };
        randomarray[ randomarray.size ] = var_56c2b45daf75ba80;
    }
    
    level.billboards.var_55c6b7d9e0bc13b9 = arrayrandomize( randomarray );
}

// Namespace namespace_8cdbb6d4564d9fae
// Params 0, eflags: 0x4
// Checksum 0xcaa218c3, Offset: 0xdda
// Size: 0x2ed
function private function_cd3c9638ebb95fcf()
{
    level endon( #"game_ended" );
    adcounter = 0;
    var_372c2209c890c285 = level.billboards.var_2a540eee8597a302;
    
    if ( level.billboards.var_77d70ecb1881998 )
    {
        gameplaycounter = 0;
        frequency = level.billboards.var_5072e428ff93ef4c;
    }
    else
    {
        frequency = level.billboards.var_1d9a1a7255ac310d;
        var_a4ac487358abd703 = 0;
    }
    
    while ( true )
    {
        if ( !level.billboards.var_77d70ecb1881998 )
        {
            flags::gameflagwait( "billboard_advertisement_ready" );
            var_ff09d9f4763c4bf6 = level.billboards.var_ff09d9f4763c4bf6;
            level notify( #"hash_51837797c13e683a" );
            
            if ( var_ff09d9f4763c4bf6.size > 0 )
            {
                level function_c211820c4715c5c9( 1, var_ff09d9f4763c4bf6[ var_a4ac487358abd703 ].id + 1 );
                function_3997d64232a83ee1( var_ff09d9f4763c4bf6[ var_a4ac487358abd703 ].unifieddisplay );
                wait var_ff09d9f4763c4bf6[ var_a4ac487358abd703 ].duration;
                var_a4ac487358abd703 = ( var_a4ac487358abd703 + 1 ) % var_ff09d9f4763c4bf6.size;
            }
        }
        
        for ( i = 0; i < frequency ; i++ )
        {
            flags::gameflagwait( "billboard_advertisement_ready" );
            randomstruct = var_372c2209c890c285[ adcounter ];
            type = randomstruct.type;
            counter = randomstruct.index;
            unifieddisplay = randomstruct.unifieddisplay;
            displaytime = randomstruct.displaytime;
            level function_c211820c4715c5c9( type, counter + 1 );
            function_3997d64232a83ee1( unifieddisplay );
            adcounter = ( adcounter + 1 ) % var_372c2209c890c285.size;
            wait displaytime;
        }
        
        if ( level.billboards.var_77d70ecb1881998 )
        {
            var_ad38c8b49d923406 = level.billboards.var_55c6b7d9e0bc13b9;
            randomstruct = var_ad38c8b49d923406[ gameplaycounter ];
            type = randomstruct.type;
            counter = randomstruct.index;
            unifieddisplay = randomstruct.unifieddisplay;
            gameplaytrigger = randomstruct.gameplaytrigger;
            displaytime = undefined;
            optionalparam = undefined;
            
            if ( isdefined( gameplaytrigger ) )
            {
                result = [[ gameplaytrigger.trigger ]]( gameplaytrigger.triggerparam );
                
                if ( !isdefined( result ) )
                {
                    gameplaycounter = ( gameplaycounter + 1 ) % var_ad38c8b49d923406.size;
                    waitframe();
                    continue;
                }
                
                displaytime = result.displayduration;
                optionalparam = result.optionalparam;
            }
            
            level function_c211820c4715c5c9( type, counter + 1, optionalparam );
            function_3997d64232a83ee1( unifieddisplay );
            gameplaycounter = ( gameplaycounter + 1 ) % var_ad38c8b49d923406.size;
            wait displaytime;
        }
    }
}

// Namespace namespace_8cdbb6d4564d9fae
// Params 1
// Checksum 0x65f53aa4, Offset: 0x10cf
// Size: 0xe6
function function_3997d64232a83ee1( var_553f2f6688db26e8 )
{
    if ( level.billboards.unifieddisplay == var_553f2f6688db26e8 )
    {
        return;
    }
    
    foreach ( billboard in level.billboards.ents )
    {
        state = "rt1";
        
        if ( !var_553f2f6688db26e8 )
        {
            state = billboard.state;
        }
        
        billboard setscriptablepartstate( "root", state );
    }
    
    level.billboards.unifieddisplay = var_553f2f6688db26e8;
}

// Namespace namespace_8cdbb6d4564d9fae
// Params 0
// Checksum 0x2b40f367, Offset: 0x11bd
// Size: 0x19b
function function_12102d9732523b54()
{
    level endon( #"game_ended" );
    flags::gameflagwait( "prematch_done" );
    
    while ( true )
    {
        foreach ( gameplaytrigger in level.billboards.gameplaytriggers )
        {
            if ( isdefined( gameplaytrigger.triggerparam ) )
            {
                result = [[ gameplaytrigger.trigger ]]( gameplaytrigger.triggerparam );
            }
            else
            {
                result = [[ gameplaytrigger.trigger ]]();
            }
            
            if ( !isdefined( result ) )
            {
                continue;
            }
            
            flags::gameflagclear( "billboard_advertisement_ready" );
            gameplayeventindex = level.billboards.var_9ee1b2068170dd[ gameplaytrigger.eventname ];
            level function_c211820c4715c5c9( 2, gameplayeventindex + 1, result.optionalparam );
            function_3997d64232a83ee1( level.billboards.gameplayevents[ gameplayeventindex ].var_5789a34a121a69e3.unifieddisplay );
            wait result.displayduration;
            flags::gameflagset( "billboard_advertisement_ready" );
            wait level.billboards.var_a7c3bb9d60254dfe;
            break;
        }
        
        wait 2;
    }
}

// Namespace namespace_8cdbb6d4564d9fae
// Params 1
// Checksum 0x68a31ea5, Offset: 0x1360
// Size: 0x4b
function function_545ace7125934651( poiname )
{
    timestampwarning = telemetry_utils::get_time_from_match_start( gettime() );
    dlog_recordevent( "dlog_event_br_billboard_poi_warning", [ "poi_name", poiname, "timestamp_warning", timestampwarning ] );
}

// Namespace namespace_8cdbb6d4564d9fae
// Params 1
// Checksum 0xcb116157, Offset: 0x13b3
// Size: 0x19b
function billboards_onplayerkilled( deathdata )
{
    if ( !isdefined( level.billboards.var_3940d82f9d9d8c5e ) )
    {
        return;
    }
    
    if ( !isdefined( deathdata.attacker ) )
    {
        return;
    }
    
    attacker = deathdata.attacker;
    
    if ( !isplayer( attacker ) )
    {
        if ( !isplayer( attacker.owner ) )
        {
            return;
        }
        
        attacker = attacker.owner;
    }
    
    if ( level.billboards.var_77d70ecb1881998 )
    {
        if ( attacker.pers[ "kills" ] + 1 > level.billboards.var_bb87c6779e01772e )
        {
            level.billboards.var_dc403929cc622e57 = attacker getentitynumber();
            level.billboards.var_bb87c6779e01772e = attacker.pers[ "kills" ] + 1;
        }
        
        return;
    }
    
    if ( level.billboards.var_f4e8cc42a9f8d536 < level.billboards.var_3940d82f9d9d8c5e.size && attacker.pers[ "kills" ] + 1 >= int( level.billboards.var_3940d82f9d9d8c5e[ level.billboards.var_f4e8cc42a9f8d536 ] ) )
    {
        level.billboards.var_dc403929cc622e57 = attacker getentitynumber();
        level.billboards.var_f4e8cc42a9f8d536++;
    }
}

// Namespace namespace_8cdbb6d4564d9fae
// Params 0
// Checksum 0x783a2da, Offset: 0x1556
// Size: 0x112
function function_968696929dcabe76()
{
    var_989c428e30b97dee = getdvar( @"hash_4bb0610b77a65173", "" );
    var_8f92be248a9bd33f = [];
    
    if ( var_989c428e30b97dee != "" )
    {
        var_8f92be248a9bd33f = strtok( var_989c428e30b97dee, "," );
    }
    
    var_55839969f1fbbab = getdvar( @"hash_1d3125d35a55efdd", "" );
    var_6098f0d64c922e60 = [];
    
    if ( var_55839969f1fbbab != "" )
    {
        var_6098f0d64c922e60 = strtok( var_55839969f1fbbab, "," );
        
        for ( i = 0; i < var_6098f0d64c922e60.size ; i++ )
        {
            var_6098f0d64c922e60[ i ] = int( var_6098f0d64c922e60[ i ] );
        }
    }
    
    level.billboards.var_1d9a1a7255ac310d = getdvarint( @"hash_fc255bcf24c83b71", level.billboards.regularads.size );
    level.billboards.var_ff09d9f4763c4bf6 = [];
    
    for ( i = 0; i < var_8f92be248a9bd33f.size ; i++ )
    {
        thread function_6db1c08954c39c65( var_8f92be248a9bd33f[ i ], var_6098f0d64c922e60[ i ] );
    }
}

// Namespace namespace_8cdbb6d4564d9fae
// Params 0
// Checksum 0x783fcf7d, Offset: 0x1670
// Size: 0xcb
function function_2c1d829dc47df355()
{
    var_9ee1b2068170dd = [];
    index = 0;
    
    foreach ( gameplayevent in level.billboards.gameplayevents )
    {
        eventname = gameplayevent.eventname;
        
        if ( eventname )
        {
            var_9ee1b2068170dd[ eventname ] = index;
        }
        
        index++;
    }
    
    level.billboards.var_9ee1b2068170dd = var_9ee1b2068170dd;
}

// Namespace namespace_8cdbb6d4564d9fae
// Params 3
// Checksum 0x94169afd, Offset: 0x1743
// Size: 0xd5
function function_c211820c4715c5c9( advertisementtype, index, optionalparam )
{
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            player omnvar_utility::function_85d5f88af471ac4b( "ui_mp_billboards_advertisement_data", 0, 2, advertisementtype );
            player omnvar_utility::function_85d5f88af471ac4b( "ui_mp_billboards_advertisement_data", 7, 5, index );
            
            if ( isdefined( optionalparam ) )
            {
                player omnvar_utility::function_85d5f88af471ac4b( "ui_mp_billboards_advertisement_data", 12, 8, optionalparam );
            }
        }
    }
}

// Namespace namespace_8cdbb6d4564d9fae
// Params 1
// Checksum 0xc07eb41d, Offset: 0x1820
// Size: 0x96
function function_979fcac256953b9( var_a97f767bb9da1d8b )
{
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            player omnvar_utility::function_85d5f88af471ac4b( "ui_mp_billboards_advertisement_data", 2, 5, var_a97f767bb9da1d8b );
        }
    }
}

// Namespace namespace_8cdbb6d4564d9fae
// Params 2
// Checksum 0x67af2466, Offset: 0x18be
// Size: 0xf8
function function_6db1c08954c39c65( data, duration )
{
    level endon( #"game_ended" );
    level waittill( #"hash_51837797c13e683a" );
    
    if ( !isdefined( duration ) )
    {
        duration = level.billboards.var_14b4e18257743c16;
    }
    
    index = function_4e1effd94ea1f9ea( data, level.billboards.var_c7ebdf4727a42f5b );
    
    if ( !isdefined( index ) )
    {
        return;
    }
    
    featured = spawnstruct();
    featured.id = index;
    featured.duration = duration;
    featured.unifieddisplay = level.billboards.var_c7ebdf4727a42f5b[ index ].unifieddisplay;
    level.billboards.var_ff09d9f4763c4bf6[ level.billboards.var_ff09d9f4763c4bf6.size ] = featured;
}

// Namespace namespace_8cdbb6d4564d9fae
// Params 2
// Checksum 0xd8846726, Offset: 0x19be
// Size: 0x4c
function function_4e1effd94ea1f9ea( adname, availableads )
{
    if ( isdefined( adname ) )
    {
        for ( i = 0; i < availableads.size ; i++ )
        {
            if ( adname == availableads[ i ].advertisementsequence )
            {
                return i;
            }
        }
    }
}

// Namespace namespace_8cdbb6d4564d9fae
// Params 3
// Checksum 0x387081bb, Offset: 0x1a13
// Size: 0x1a5
function function_d89f723a1b6fa8de( eventname, func, triggerparam )
{
    if ( !isdefined( level.billboards.gameplaytriggers ) )
    {
        return;
    }
    
    neweventindex = level.billboards.var_9ee1b2068170dd[ eventname ];
    
    if ( !isdefined( neweventindex ) )
    {
        assertmsg( "<dev string:xa3>" + eventname + "<dev string:xb7>" );
        return;
    }
    
    triggerstruct = spawnstruct();
    triggerstruct.eventname = eventname;
    triggerstruct.trigger = func;
    triggerstruct.triggerparam = triggerparam;
    insertat = level.billboards.gameplaytriggers.size;
    index = 0;
    
    foreach ( gameplaytrigger in level.billboards.gameplaytriggers )
    {
        eventindex = level.billboards.var_9ee1b2068170dd[ gameplaytrigger.eventname ];
        
        if ( eventindex > neweventindex )
        {
            insertat = index;
            break;
        }
        
        index++;
    }
    
    arrayinsert( level.billboards.gameplaytriggers, triggerstruct, insertat );
}

// Namespace namespace_8cdbb6d4564d9fae
// Params 2, eflags: 0x40 variadic
// Checksum 0x4160a29e, Offset: 0x1bc0
// Size: 0x16c
function function_1c601409b6e08d2( ... )
{
    highestplayernum = 0;
    result = undefined;
    poiname = undefined;
    
    foreach ( tag, poi in level.poi )
    {
        if ( !isdefined( poi[ "calloutIndex" ] ) )
        {
            continue;
        }
        
        poiplayers = poi[ "players" ];
        var_e7e6bc3e2848373e = highestplayernum;
        
        if ( !level.billboards.var_77d70ecb1881998 )
        {
            var_e7e6bc3e2848373e = max( level.billboards.var_bccbd19db92d0ac9, highestplayernum );
        }
        
        if ( poiplayers.size >= var_e7e6bc3e2848373e )
        {
            highestplayernum = poiplayers.size;
            optionalparam = poi[ "calloutIndex" ];
            poiname = tag;
        }
    }
    
    if ( highestplayernum > 0 )
    {
        result = spawnstruct();
        result.displayduration = level.billboards.var_bdd574e7f14d1c37;
        result.optionalparam = optionalparam;
        function_545ace7125934651( poiname );
    }
    
    return result;
}

// Namespace namespace_8cdbb6d4564d9fae
// Params 1
// Checksum 0x206fa252, Offset: 0x1d35
// Size: 0xa3
function function_b17d9bd4602b18e7( triggerparam )
{
    result = undefined;
    
    if ( isdefined( level.billboards.var_dc403929cc622e57 ) && level.billboards.var_f4e8cc42a9f8d536 == triggerparam )
    {
        result = spawnstruct();
        result.displayduration = level.billboards.var_4e53afbe849a32a7;
        result.optionalparam = level.billboards.var_dc403929cc622e57;
        level.billboards.var_dc403929cc622e57 = undefined;
    }
    
    return result;
}

// Namespace namespace_8cdbb6d4564d9fae
// Params 2, eflags: 0x44 variadic
// Checksum 0x1ffe6ff4, Offset: 0x1de1
// Size: 0x76
function private function_5813d91738a2887( ... )
{
    result = undefined;
    
    if ( isdefined( level.billboards.var_dc403929cc622e57 ) )
    {
        result = { #optionalparam:level.billboards.var_dc403929cc622e57, #displayduration:level.billboards.var_4e53afbe849a32a7 };
    }
    
    return result;
}

// Namespace namespace_8cdbb6d4564d9fae
// Params 2, eflags: 0x44 variadic
// Checksum 0xc597ad51, Offset: 0x1e60
// Size: 0x11e
function private function_8e02f557d6496836( ... )
{
    result = undefined;
    highestscore = 0;
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) && utility::issharedfuncdefined( #"score", #"hash_a9494f7ac7475784" ) )
        {
            playerscore = [[ utility::getsharedfunc( #"score", #"hash_a9494f7ac7475784" ) ]]( player );
            
            if ( playerscore > highestscore )
            {
                result = { #optionalparam:player getentitynumber(), #displayduration:level.billboards.var_6a9cb092a896da58 };
                highestscore = playerscore;
            }
        }
    }
    
    return result;
}

// Namespace namespace_8cdbb6d4564d9fae
// Params 2, eflags: 0x40 variadic
// Checksum 0x24a99d65, Offset: 0x1f87
// Size: 0x3d
function function_b5e2d0b4b8c2a9a0( ... )
{
    level.billboards.var_dc403929cc622e57 = undefined;
    level.billboards.var_bb87c6779e01772e = 0;
}

