// scripts\mp\seasonalevents.gsc  (hash_6187721eaae1fecb.gscc) (size: 7599 Bytes / 0x1daf / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe1e4e02a (3789873194)
// size ...... 7599 (0x1daf)
// includes .. 5   (offset: 0x1c9b)
// strings ... 12  (offset: 0x1cc3)
// dev strs .. 7   (offset: 0x1d5b)
// exports ... 18  (offset: 0x13e7)
// cseg ...... 0x11d + 0x12ca (0x13e7)
// imports ... 46  (offset: 0x16b7)
// animtree1 . 0   (offset: 0x1daf)
// animtree2 . 0   (offset: 0x1daf)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\operator;
#using scripts\mp\playerachievements;

#namespace seasonal_events;

// Namespace seasonal_events
// Params 0, eflags: 0x1
// Checksum 0x6a0c5ba8, Offset: 0x13b
// Size: 0x98
function autoexec function_fece30de29d145a7()
{
    utility::registersharedfunc( #"seasonalevents", #"init", &init );
    utility::registersharedfunc( #"seasonalevents", #"hash_9ac2b9e8f2f956fc", &function_2a5243859d5a7917 );
    utility::registersharedfunc( #"seasonalevents", #"hash_b7f17adcf8b16e89", &function_dbcd2af4c9b3e742 );
    utility::registersharedfunc( #"seasonalevents", #"hash_8e0285feedbf6bcf", &function_748c3b7fe3d362fe );
    utility::registersharedfunc( #"seasonalevents", #"hash_b798047a7a76866f", &function_8dbb04cc287ad6a );
}

// Namespace seasonal_events
// Params 1, eflags: 0x4
// Checksum 0x2d08d376, Offset: 0x1db
// Size: 0x13a
function private on_player_connect( params )
{
    update_winners_circle();
    init_mastery_achievements();
    
    if ( level.var_267cd48e4d3a2bc1 && isdefined( level.seasonalevents ) )
    {
        currenttime = function_a88ec804d23ea62();
        
        foreach ( event in level.seasonalevents )
        {
            iseventactive = function_d2e4ad256ce3861a( currenttime, event.starttime, event.endtime );
            
            if ( event.var_7ccebe94c50ff4c8 != iseventactive )
            {
                event.var_7ccebe94c50ff4c8 = iseventactive;
                println( "<dev string:x24>" + ( level.var_b04ccf08e93f813 ?? 0 ) + "<dev string:x4e>" + event.dvarsuffix + "<dev string:x73>" + event.var_7ccebe94c50ff4c8 );
            }
        }
    }
}

// Namespace seasonal_events
// Params 2, eflags: 0x4
// Checksum 0x471cebb8, Offset: 0x31d
// Size: 0x2b
function private function_5394ebc0c703ea17( var_844499143bc349f6, dvarsuffix )
{
    return hashcat( @"hash_88ee7db03151b840", var_844499143bc349f6, "_", dvarsuffix );
}

// Namespace seasonal_events
// Params 1, eflags: 0x4
// Checksum 0xd9ec4694, Offset: 0x351
// Size: 0x11
function private function_6e56a70463e4347b( i )
{
    return i + 1;
}

// Namespace seasonal_events
// Params 3, eflags: 0x4
// Checksum 0xa926bd96, Offset: 0x36b
// Size: 0x2a, Type: bool
function private function_d2e4ad256ce3861a( currenttime, starttime, endtime )
{
    return currenttime >= starttime && currenttime < endtime;
}

// Namespace seasonal_events
// Params 0, eflags: 0x4
// Checksum 0xde521e44, Offset: 0x39e
// Size: 0x37
function private function_a88ec804d23ea62()
{
    var_42c03680eb636de = getsystemtime();
    currenttime = var_42c03680eb636de;
    
    if ( level.var_267cd48e4d3a2bc1 )
    {
        currenttime = var_42c03680eb636de + function_abfe5010d7e3f1e1();
    }
    
    return currenttime;
}

// Namespace seasonal_events
// Params 0, eflags: 0x4
// Checksum 0xa4a42f49, Offset: 0x3de
// Size: 0x126
function private update_winners_circle()
{
    if ( getdvarint( @"hash_2fba87a13d2a72f2" ) && level.gametypebundle.var_4691e4f847f109a5 )
    {
        /#
            force_event = getdvarint( @"hash_4848accb7f9d6b3", -1 );
            
            if ( force_event >= 0 )
            {
                setomnvar( "<dev string:x92>", force_event );
                return;
            }
        #/
        
        currenttime = function_a88ec804d23ea62();
        
        foreach ( eventidx, event in level.seasonalevents )
        {
            if ( !function_d2e4ad256ce3861a( currenttime, event.starttime, event.endtime ) )
            {
                continue;
            }
            
            if ( isdefined( event.winnerscircledata ) )
            {
                setomnvar( "ui_winners_circle_event", eventidx );
                return;
            }
        }
        
        setomnvar( "ui_winners_circle_event", -1 );
    }
}

// Namespace seasonal_events
// Params 0, eflags: 0x4
// Checksum 0xfb39bc6c, Offset: 0x50c
// Size: 0xc8
function private init_mastery_achievements()
{
    currenttime = function_a88ec804d23ea62();
    
    foreach ( event in level.seasonalevents )
    {
        if ( !function_d2e4ad256ce3861a( currenttime, event.starttime, event.endtime ) )
        {
            continue;
        }
        
        if ( event.masterychallenge )
        {
            playerachievements::getstate( self, event.masterychallenge );
        }
    }
}

// Namespace seasonal_events
// Params 0, eflags: 0x4
// Checksum 0xc14927d4, Offset: 0x5dc
// Size: 0x666
function private function_de0447cf9e2376fa()
{
    if ( isdefined( level.seasonalevents ) )
    {
        return;
    }
    
    eventsystem = level.projectbundle.var_465061fbebcd06fb;
    var_32f121465ee6eeb7 = isdefined( eventsystem ) ? getscriptbundle( eventsystem ) : undefined;
    
    if ( !isdefined( var_32f121465ee6eeb7 ) )
    {
        return;
    }
    
    level.var_267cd48e4d3a2bc1 = getdvarint( @"hash_dec5cd614ac064d", 0 ) && !level.leagueplaymatch && !level.var_309e3d9dac389de6;
    seasonalevents = [];
    var_2e505f49537f4ff2 = undefined;
    
    if ( getdvarint( @"hash_1286ccb2658d4dbb", 0 ) )
    {
        var_2e505f49537f4ff2 = getscriptbundle( var_32f121465ee6eeb7.testeventlist );
    }
    else
    {
        var_2e505f49537f4ff2 = getscriptbundle( var_32f121465ee6eeb7.eventlist );
    }
    
    level.var_bb60ec50aed6acb1 = 0;
    currenttime = function_a88ec804d23ea62();
    
    if ( isdefined( var_2e505f49537f4ff2 ) )
    {
        foreach ( assetref in var_2e505f49537f4ff2.events )
        {
            if ( !isdefined( assetref.eventdata ) )
            {
                continue;
            }
            
            bundledata = getscriptbundle( assetref.eventdata );
            
            if ( !isdefined( bundledata ) )
            {
                continue;
            }
            
            eventDisabled = getdvarint( function_5394ebc0c703ea17( "eventDisabled", bundledata.dvarsuffix ) );
            
            if ( eventDisabled )
            {
                continue;
            }
            
            starttime = getdvar( function_5394ebc0c703ea17( "startTime", bundledata.dvarsuffix ), bundledata.starttime );
            endtime = getdvar( function_5394ebc0c703ea17( "endTime", bundledata.dvarsuffix ), bundledata.endtime );
            starttime = starttime ? int( starttime ) : 0;
            endtime = endtime ? int( endtime ) : 9000000000;
            var_7ccebe94c50ff4c8 = function_d2e4ad256ce3861a( currenttime, starttime, endtime );
            killdropconfig = bundledata.template == "MYSTERY_BOX" ? bundledata.templatedata.mysteryboxdata.killdropconfig : bundledata.templatedata.var_6d758f0d37e445b5.killdropconfig;
            stopDropsOnComplete = getdvarint( function_5394ebc0c703ea17( "stopDropsOnComplete", bundledata.dvarsuffix ), killdropconfig.stopDropsOnComplete ?? 1 );
            var_9d90d6a249880dca = [];
            var_42ed96217f9f6149 = 0;
            
            for ( i = 0; i < bundledata.var_df196e5d49e0ceec.size ; i++ )
            {
                var_b15ec449f6e9e1b5 = bundledata.var_df196e5d49e0ceec[ i ];
                var_1f5e268350ef8dd7 = var_b15ec449f6e9e1b5.featuredperklootid;
                var_1f5e268350ef8dd7 = getdvar( function_5394ebc0c703ea17( "featuredPerkLootID_" + function_6e56a70463e4347b( i ), bundledata.dvarsuffix ), var_1f5e268350ef8dd7 );
                var_1f5e268350ef8dd7 = var_1f5e268350ef8dd7 ? int( var_1f5e268350ef8dd7 ) : 0;
                
                if ( var_1f5e268350ef8dd7 == 0 )
                {
                    continue;
                }
                
                var_a7a7cd6e2f0a5442 = { #var_c07834dfd5f680cd:var_b15ec449f6e9e1b5.var_c07834dfd5f680cd, #var_1f5e268350ef8dd7:var_1f5e268350ef8dd7 };
                
                if ( var_b15ec449f6e9e1b5.var_863a6ed39b24406d )
                {
                    var_a7a7cd6e2f0a5442.percentbonus = var_b15ec449f6e9e1b5.var_bd6d30a29db5650d / 100;
                }
                else
                {
                    var_a7a7cd6e2f0a5442.extrabonus = var_b15ec449f6e9e1b5.var_bd6d30a29db5650d;
                }
                
                var_9d90d6a249880dca[ var_1f5e268350ef8dd7 ] = var_a7a7cd6e2f0a5442;
                var_42ed96217f9f6149 = 1;
                level.var_bb60ec50aed6acb1 = 1;
            }
            
            pointscategories = [];
            
            for ( i = 0; i < bundledata.templatedata.var_46a0f31a846d7413.pointscategories.size ; i++ )
            {
                key = bundledata.templatedata.var_46a0f31a846d7413.pointscategories[ i ].key;
                key = getdvar( function_5394ebc0c703ea17( "pointsCategoryKey_" + function_6e56a70463e4347b( i ), bundledata.dvarsuffix ), key );
                pointscategories[ pointscategories.size ] = key;
            }
            
            eventdata = { #winnerscircledata:bundledata.winnerscircledata, #var_42ed96217f9f6149:var_42ed96217f9f6149, #pointscategories:pointscategories, #var_9d90d6a249880dca:var_9d90d6a249880dca, #stopDropsOnComplete:stopDropsOnComplete, #var_7ccebe94c50ff4c8:var_7ccebe94c50ff4c8, #endtime:endtime, #starttime:starttime, #dvarsuffix:bundledata.dvarsuffix, #template:bundledata.template };
            var_8c4436ae82decf7d = tablelookuprownum( level.projectbundle.var_7ab00b87d7fb6fe6, 1, bundledata.challengereference );
            
            if ( var_8c4436ae82decf7d >= 0 )
            {
                eventdata.masterychallenge = int( tablelookupbyrow( level.projectbundle.var_7ab00b87d7fb6fe6, var_8c4436ae82decf7d, 0 ) );
                eventdata.masterycompletion = int( tablelookupbyrow( level.projectbundle.var_7ab00b87d7fb6fe6, var_8c4436ae82decf7d, 4 ) );
            }
            
            seasonalevents[ seasonalevents.size ] = eventdata;
        }
    }
    
    level.seasonalevents = seasonalevents;
    update_winners_circle();
    
    foreach ( player in level.players )
    {
        player init_mastery_achievements();
    }
}

// Namespace seasonal_events
// Params 0, eflags: 0x4
// Checksum 0xf057598f, Offset: 0xc4a
// Size: 0x34
function private init()
{
    level.var_b04ccf08e93f813 = 0;
    function_de0447cf9e2376fa();
    
    if ( level.var_267cd48e4d3a2bc1 )
    {
        callback::add( #"player_connect", &on_player_connect );
    }
}

// Namespace seasonal_events
// Params 1, eflags: 0x4
// Checksum 0x60fe64a3, Offset: 0xc86
// Size: 0xd9
function private function_2a5243859d5a7917( params )
{
    if ( level.var_267cd48e4d3a2bc1 )
    {
        currenttime = function_a88ec804d23ea62();
        
        foreach ( event in level.seasonalevents )
        {
            if ( !event.var_42ed96217f9f6149 )
            {
                continue;
            }
            
            if ( function_d2e4ad256ce3861a( currenttime, event.starttime, event.endtime ) )
            {
                return 1;
            }
        }
        
        return 0;
    }
    
    return level.var_bb60ec50aed6acb1;
}

// Namespace seasonal_events
// Params 1, eflags: 0x4
// Checksum 0x218437a6, Offset: 0xd68
// Size: 0x138
function private function_748c3b7fe3d362fe( params )
{
    var_c07834dfd5f680cd = params.var_c07834dfd5f680cd;
    
    if ( !var_c07834dfd5f680cd )
    {
        assertmsg( "<dev string:xaa>" );
        return;
    }
    
    if ( !isdefined( self.var_68f56ad6f1483544 ) )
    {
        self.var_68f56ad6f1483544 = [];
    }
    
    bonusinfo = self.var_68f56ad6f1483544[ var_c07834dfd5f680cd ];
    
    if ( !bonusinfo.var_9374768edd45ae01 )
    {
        self.var_68f56ad6f1483544[ var_c07834dfd5f680cd ] = structcopy( function_28340cd0137ff791( params ) );
        self.var_68f56ad6f1483544[ var_c07834dfd5f680cd ].var_9374768edd45ae01 = 1;
        bonusinfo = self.var_68f56ad6f1483544[ var_c07834dfd5f680cd ];
    }
    
    if ( bonusinfo && !bonusinfo.var_dd13a915ed42b77c )
    {
        if ( bonusinfo.percentbonus )
        {
            return [ int( ( params.basevalue ?? 0 ) * bonusinfo.percentbonus ), bonusinfo.var_1f5e268350ef8dd7 ];
        }
        
        return [ bonusinfo.extrabonus ?? 0, bonusinfo.var_1f5e268350ef8dd7 ];
    }
    
    return [ 0, 0 ];
}

// Namespace seasonal_events
// Params 1, eflags: 0x4
// Checksum 0xe68d9d15, Offset: 0xea9
// Size: 0x1be
function private function_28340cd0137ff791( params )
{
    var_c07834dfd5f680cd = params.var_c07834dfd5f680cd;
    
    if ( !var_c07834dfd5f680cd )
    {
        assertmsg( "<dev string:xf1>" );
        return;
    }
    
    [ var_962602f37ee300e2, var_7a7f7d66f297edf7, var_7d1157c4b4b08b6d ] = function_ad07e92361be985d();
    currenttime = function_a88ec804d23ea62();
    
    foreach ( event in level.seasonalevents )
    {
        if ( !function_d2e4ad256ce3861a( currenttime, event.starttime, event.endtime ) )
        {
            continue;
        }
        
        foreach ( lootid, lootinfo in event.var_9d90d6a249880dca )
        {
            if ( lootinfo.var_c07834dfd5f680cd != var_c07834dfd5f680cd )
            {
                continue;
            }
            
            if ( var_962602f37ee300e2 == lootid || var_7a7f7d66f297edf7 == lootid || var_7d1157c4b4b08b6d == lootid )
            {
                return lootinfo;
            }
        }
    }
    
    return { #var_dd13a915ed42b77c:1 };
}

// Namespace seasonal_events
// Params 0, eflags: 0x4
// Checksum 0x229a63e1, Offset: 0x1070
// Size: 0xde
function private function_abfe5010d7e3f1e1()
{
    timewarpoffset = 0;
    
    if ( level.var_267cd48e4d3a2bc1 )
    {
        foreach ( player in level.players )
        {
            timeWarpOffsetSeconds = player getplayerdata( "common", "timeWarpOffsetSeconds" ) ?? 0;
            
            if ( timeWarpOffsetSeconds > timewarpoffset )
            {
                timewarpoffset = timeWarpOffsetSeconds;
            }
        }
        
        if ( level.var_b04ccf08e93f813 < timewarpoffset )
        {
            println( "<dev string:x13a>" + timewarpoffset );
            level.var_b04ccf08e93f813 = timewarpoffset;
        }
    }
    
    return timewarpoffset;
}

// Namespace seasonal_events
// Params 0
// Checksum 0x2cac3e1e, Offset: 0x1157
// Size: 0xb8
function function_ad07e92361be985d()
{
    player = self;
    var_962602f37ee300e2 = undefined;
    var_7a7f7d66f297edf7 = undefined;
    var_7d1157c4b4b08b6d = undefined;
    
    if ( isdefined( player.operatorcustomization.skinlootid ) )
    {
        var_962602f37ee300e2 = player.operatorcustomization.skinlootid;
    }
    
    var_aa1a608286de80e = utility::ismp() && !isbrgamemode() && game_utility::getgametype() != "ob";
    
    if ( var_aa1a608286de80e )
    {
        var_7a7f7d66f297edf7 = player operator::function_ce41b4b58036e41c( 0 );
        var_7d1157c4b4b08b6d = player operator::function_ce41b4b58036e41c( 1 );
    }
    
    return [ var_962602f37ee300e2, var_7a7f7d66f297edf7, var_7d1157c4b4b08b6d ];
}

// Namespace seasonal_events
// Params 0, eflags: 0x4
// Checksum 0x13ff079b, Offset: 0x1218
// Size: 0x153, Type: bool
function private function_dbcd2af4c9b3e742()
{
    assert( isdefined( level.seasonalevents ) );
    assert( isplayer( self ) );
    [ var_962602f37ee300e2, var_7a7f7d66f297edf7, var_7d1157c4b4b08b6d ] = function_ad07e92361be985d();
    currenttime = function_a88ec804d23ea62();
    
    foreach ( event in level.seasonalevents )
    {
        if ( !function_d2e4ad256ce3861a( currenttime, event.starttime, event.endtime ) )
        {
            continue;
        }
        
        var_bf1fc9c0a898b250 = getarraykeys( event.var_9d90d6a249880dca );
        
        if ( var_962602f37ee300e2 && arraycontains( var_bf1fc9c0a898b250, var_962602f37ee300e2 ) )
        {
            return true;
        }
        
        if ( var_7a7f7d66f297edf7 && arraycontains( var_bf1fc9c0a898b250, var_7a7f7d66f297edf7 ) )
        {
            return true;
        }
        
        if ( var_7d1157c4b4b08b6d && arraycontains( var_bf1fc9c0a898b250, var_7d1157c4b4b08b6d ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace seasonal_events
// Params 0
// Checksum 0xc39062aa, Offset: 0x1374
// Size: 0x73
function function_8dbb04cc287ad6a()
{
    bundledata = level.seasonalevents[ getomnvar( "ui_winners_circle_event" ) ];
    
    if ( isdefined( bundledata.winnerscircledata ) )
    {
        return { #align_ent:{ #angles:( 0, 0, 0 ), #origin:( 0, 0, -15550 ) }, #bundledata:bundledata };
    }
}

