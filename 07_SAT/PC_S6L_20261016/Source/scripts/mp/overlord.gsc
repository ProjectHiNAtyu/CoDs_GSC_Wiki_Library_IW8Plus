// scripts\mp\overlord.gsc  (hash_15cfcb3ef3b9c20b.gscc) (size: 20763 Bytes / 0x511b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa9b35f43 (2847104835)
// size ...... 20763 (0x511b)
// includes .. 5   (offset: 0x4f6f)
// strings ... 19  (offset: 0x4f97)
// dev strs .. 3   (offset: 0x50f7)
// exports ... 49  (offset: 0x3a63)
// cseg ...... 0x1c3 + 0x38a0 (0x3a63)
// imports ... 101 (offset: 0x420b)
// animtree1 . 0   (offset: 0x511b)
// animtree2 . 0   (offset: 0x511b)
#using scripts\anim\dialogue;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;

#namespace overlord;

// Namespace overlord
// Params 0
// Checksum 0x179d3676, Offset: 0x1e1
// Size: 0x128
function init()
{
    if ( !function_c883d9cdcde00d28() )
    {
        return;
    }
    
    level.overlord = spawnstruct();
    level.overlord.events = [];
    level.overlord.conversations = [];
    level.setoverlordlockedpriority = &setoverlordlockedpriority;
    level thread function_d32ac434b327259b();
    level.overlord.var_ef8e3b0c4aa6baf3 = getdvarint( @"hash_99ee36f514cfdc16", 3 );
    utility::registersharedfunc( #"overlord", #"hash_82f680233629c231", &playevent );
    utility::registersharedfunc( #"overlord", #"hash_399ec4a29126e3f5", &function_be2d6dc71f97faa6 );
    utility::registersharedfunc( #"overlord", #"hash_371847cfe0f17dce", &function_3aaf8e5681173423 );
    utility::registersharedfunc( #"overlord", #"hash_5041a8f1a1c8b981", &function_e155a19c69aed191 );
    
    if ( getdvarint( @"scr_overlord_enemy_proximity_enabled", 1 ) && utility::ismp() )
    {
        level thread function_8934b0432be77501();
    }
    
    /#
        if ( false )
        {
            level thread function_f456a592022bf8f5();
        }
    #/
}

// Namespace overlord
// Params 1
// Checksum 0x76ea4a5d, Offset: 0x311
// Size: 0x34
function function_ddcc4b96977bcf4a( var_42bf68013ededdd4 )
{
    if ( !isarray( var_42bf68013ededdd4 ) && isstring( var_42bf68013ededdd4 ) )
    {
        var_42bf68013ededdd4 = [ var_42bf68013ededdd4 ];
    }
    
    level.var_b4ff1ca2ef8c9305 = var_42bf68013ededdd4;
}

// Namespace overlord
// Params 0
// Checksum 0x4dc45193, Offset: 0x34d
// Size: 0x23
function function_c883d9cdcde00d28()
{
    return getdvarint( @"scr_overlord_enabled", istrue( level.gamemodebundle.overlordenable ) );
}

// Namespace overlord
// Params 0, eflags: 0x4
// Checksum 0x40f9876a, Offset: 0x379
// Size: 0x117
function private function_b8e43078bcbd5bd()
{
    var_cdebd47e2f76e4d7 = function_af16d381f297c419();
    
    foreach ( csv in var_cdebd47e2f76e4d7 )
    {
        for ( row = 0; true ; row++ )
        {
            ref = tablelookupbyrow( csv, row, 0 );
            
            if ( ref == "" )
            {
                break;
            }
            
            alias = tablelookupbyrow( csv, row, 1 );
            priority = int( tablelookupbyrow( csv, row, 2 ) );
            cooldown = int( tablelookupbyrow( csv, row, 3 ) );
            timeout = int( tablelookupbyrow( csv, row, 4 ) );
            registerevent( ref, alias, priority, cooldown, timeout );
        }
    }
}

// Namespace overlord
// Params 0, eflags: 0x4
// Checksum 0xdcc9b0ab, Offset: 0x498
// Size: 0x54d
function private function_d32ac434b327259b()
{
    waitframe();
    function_b8e43078bcbd5bd();
    
    if ( !level.gamemodebundle.overlordenable )
    {
        return;
    }
    
    var_29f06dd51e9d58fd = getscriptbundlenames( #"dialogueoverlord" );
    
    foreach ( str_bundle in var_29f06dd51e9d58fd )
    {
        s_bundle = getscriptbundle( str_bundle );
        var_c271848dc9bc3142 = undefined;
        
        if ( isdefined( s_bundle ) )
        {
            if ( isdefined( s_bundle.gametypewhitelist ) && s_bundle.gametypewhitelist.size )
            {
                foreach ( s_gametype in s_bundle.gametypewhitelist )
                {
                    if ( getxhash( level.gametype ) == s_gametype.gametype )
                    {
                        var_c271848dc9bc3142 = 0;
                        break;
                    }
                    
                    if ( isdefined( level.var_9be576d6189d0c55 ) )
                    {
                        gametype = [[ level.var_9be576d6189d0c55 ]]();
                        
                        if ( gametype == s_gametype.gametype )
                        {
                            var_c271848dc9bc3142 = 0;
                            break;
                        }
                        
                        continue;
                    }
                    
                    var_c271848dc9bc3142 = 1;
                }
            }
            else if ( isdefined( s_bundle.var_9ce6acbcbb4de5c7 ) && s_bundle.var_9ce6acbcbb4de5c7.size )
            {
                foreach ( s_gametype in s_bundle.var_9ce6acbcbb4de5c7 )
                {
                    if ( getxhash( level.gametype ) == s_gametype.gametype )
                    {
                        var_c271848dc9bc3142 = 1;
                        break;
                    }
                }
            }
            
            if ( var_c271848dc9bc3142 )
            {
                continue;
            }
            
            foreach ( var_7836a3e8bbaaf33e in s_bundle.overlordevents )
            {
                if ( isdefined( var_7836a3e8bbaaf33e.alias ) )
                {
                    timeout = lookupsoundlength( var_7836a3e8bbaaf33e.alias, 1 ) / 1000 + 0.25;
                    registerevent( var_7836a3e8bbaaf33e.ref ?? var_7836a3e8bbaaf33e.alias, var_7836a3e8bbaaf33e.alias, var_7836a3e8bbaaf33e.priority, var_7836a3e8bbaaf33e.cooldown, timeout, var_7836a3e8bbaaf33e.speakerasset, var_7836a3e8bbaaf33e.delaybefore, var_7836a3e8bbaaf33e.delayafter, var_7836a3e8bbaaf33e.var_73f6b935645e7cfc );
                }
            }
            
            foreach ( s_conversation in s_bundle.conversations )
            {
                level.overlord.conversations[ s_conversation.conversationname ] = s_conversation;
                
                foreach ( var_5dbf98f197b02dc9 in s_conversation.soundevents )
                {
                    if ( isdefined( var_5dbf98f197b02dc9.alias ) )
                    {
                        eventref = var_5dbf98f197b02dc9.ref ?? var_5dbf98f197b02dc9.alias;
                        
                        if ( !isdefined( level.overlord.events[ eventref ] ) )
                        {
                            registerevent( eventref, var_5dbf98f197b02dc9.alias, var_5dbf98f197b02dc9.priority, var_5dbf98f197b02dc9.cooldown, utility::function_6f5d2e1f1ff70482( lookupsoundlength( var_5dbf98f197b02dc9.alias, 1 ) ) + 0.25, var_5dbf98f197b02dc9.speakerasset, var_5dbf98f197b02dc9.delaybefore, var_5dbf98f197b02dc9.delayafter, var_5dbf98f197b02dc9.var_73f6b935645e7cfc );
                        }
                    }
                }
            }
        }
    }
    
    utility::flag_set( "overlord_ready" );
}

// Namespace overlord
// Params 1
// Checksum 0x3223cc61, Offset: 0x9ed
// Size: 0x173
function function_b606cb1cebb2a4f5( str_bundle )
{
    if ( level.gamemodebundle.overlordenable )
    {
        s_bundle = getscriptbundle( "dialogueoverlord:" + str_bundle );
        
        if ( isdefined( s_bundle ) )
        {
            foreach ( var_7836a3e8bbaaf33e in s_bundle.overlordevents )
            {
                if ( isdefined( var_7836a3e8bbaaf33e.alias ) )
                {
                    timeout = lookupsoundlength( var_7836a3e8bbaaf33e.alias, 1 ) / 1000 + 2;
                    registerevent( var_7836a3e8bbaaf33e.ref, var_7836a3e8bbaaf33e.alias, var_7836a3e8bbaaf33e.priority, var_7836a3e8bbaaf33e.cooldown, timeout, var_7836a3e8bbaaf33e.speakerasset, var_7836a3e8bbaaf33e.delaybefore, var_7836a3e8bbaaf33e.delayafter, var_7836a3e8bbaaf33e.var_73f6b935645e7cfc );
                    continue;
                }
                
                if ( isdefined( var_7836a3e8bbaaf33e.ref ) )
                {
                    level.overlord.events[ var_7836a3e8bbaaf33e.ref ] = undefined;
                }
            }
        }
    }
}

// Namespace overlord
// Params 0, eflags: 0x4
// Checksum 0x8b8a33ca, Offset: 0xb68
// Size: 0x79
function private function_af16d381f297c419()
{
    if ( level.gamemodebundle.overlordenable )
    {
        if ( isdefined( level.var_b4ff1ca2ef8c9305 ) )
        {
            return level.var_b4ff1ca2ef8c9305;
        }
        else if ( isdefined( level.gamemodebundle.var_5d3ce7f48b3d30ab ) )
        {
            return [ level.gamemodebundle.var_5d3ce7f48b3d30ab ];
        }
    }
    
    return [ getdvar( @"hash_97efde55df4bcccd", "mp_cp/overlord_dmz.csv" ) ];
}

// Namespace overlord
// Params 9, eflags: 0x4
// Checksum 0x9f1ae82d, Offset: 0xbea
// Size: 0x103
function private registerevent( ref, alias, priority, cooldown, timeout, speakerasset, delaybefore, delayafter, var_73f6b935645e7cfc )
{
    event = spawnstruct();
    event.ref = ref;
    event.alias = alias;
    event.priority = priority ?? 75;
    event.cooldown = cooldown * 1000;
    event.timeout = timeout;
    event.speakerasset = speakerasset;
    event.delaybefore = delaybefore;
    event.delayafter = delayafter;
    event.var_73f6b935645e7cfc = var_73f6b935645e7cfc;
    level.overlord.events[ ref ] = event;
}

// Namespace overlord
// Params 4
// Checksum 0xf53ed483, Offset: 0xcf5
// Size: 0xd0
function function_6aacf43cc824bd3f( eventref, players, includedeadplayers, var_e384c22ada921327 )
{
    if ( !isdefined( level.overlord ) )
    {
        return 0;
    }
    
    if ( !( isdefined( eventref ) && isdefined( var_e384c22ada921327 ) ) )
    {
        return 0;
    }
    
    event = level.overlord.events[ eventref ];
    
    if ( !isdefined( event ) )
    {
        return 0;
    }
    
    if ( !isdefined( event.playhistory ) )
    {
        event.playhistory = [];
    }
    
    if ( event.playhistory[ var_e384c22ada921327 ] )
    {
        return 0;
    }
    
    eventplayed = playevent( eventref, players, 0, includedeadplayers, 0 );
    
    if ( eventplayed )
    {
        event.playhistory[ var_e384c22ada921327 ] = 1;
    }
}

// Namespace overlord
// Params 5
// Checksum 0x5a5e5915, Offset: 0xdcd
// Size: 0x645
function playevent( eventref, players, delay, includedeadplayers, var_6bf0a3568d4d9081 )
{
    if ( !isdefined( level.overlord ) )
    {
        return 0;
    }
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    if ( utility::flag( "overlord_disabled" ) )
    {
        return 0;
    }
    
    event = level.overlord.events[ eventref ];
    
    if ( isstring( eventref ) && !isdefined( event ) )
    {
        eventref = getxhash( eventref );
        event = level.overlord.events[ eventref ];
    }
    
    if ( !isdefined( event ) )
    {
        foreach ( eventstruct in level.overlord.events )
        {
            if ( eventref == eventstruct.alias )
            {
                event = eventstruct;
                break;
            }
        }
    }
    
    if ( !isdefined( event ) )
    {
        return 0;
    }
    
    if ( !soundexists( event.alias ) )
    {
        return 0;
    }
    
    if ( getdvarint( @"hash_ec5ffe1a34b9c8a3", 0 ) )
    {
        var_fac353c81d16854c = 0;
        b_should_interrupt = 0;
        
        foreach ( player in players )
        {
            if ( player function_5b9a94f0c7f2bb5b() || player function_2a4336a2a72f769c() )
            {
                var_fac353c81d16854c = 1;
            }
            
            if ( var_fac353c81d16854c )
            {
                b_should_interrupt = player shouldinterrupt( event );
                break;
            }
        }
        
        if ( var_fac353c81d16854c && !b_should_interrupt )
        {
            function_7e3bc1e7ad5c43eb( players );
        }
        
        waittillframeend();
    }
    
    var_d5c918b5b5c6da53 = event.delaybefore ?? 0;
    var_a39ec58f9e622178 = event.delayafter ?? 0;
    n_vo_wait = event.timeout ?? 0;
    var_cfac47227e7f8e92 = var_d5c918b5b5c6da53 + n_vo_wait + var_a39ec58f9e622178;
    
    foreach ( player in players )
    {
        if ( isdefined( player ) )
        {
            player.var_5d3b2a20a597a075 = { #eventref:eventref, #priority:event.priority, #endtime:gettime() + var_cfac47227e7f8e92 * 1000, #starttime:gettime() };
        }
    }
    
    if ( var_d5c918b5b5c6da53 > 0 )
    {
        wait var_d5c918b5b5c6da53;
    }
    
    utility::flag_waitopen( "overlord_paused" );
    var_b4bc3c241f710bbd = 0;
    lineplayed = 0;
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !isalive( player ) && !includedeadplayers )
        {
            continue;
        }
        
        player endon( getxhashhexname( eventref ) + "_endon" );
        player function_3ef24b8449e99bf4();
        
        if ( !player function_982ce2981b4530b9( eventref ) )
        {
            continue;
        }
        
        interruptcurrent = player shouldinterrupt( event ) || b_should_interrupt;
        var_56a524600ddc96f2 = event.timeout;
        
        if ( !interruptcurrent && !getdvarint( @"hash_ec5ffe1a34b9c8a3", 0 ) )
        {
            foreach ( var_a5e7b5f3802fb434, n_start_time in player.var_d83c183af7229499 )
            {
                var_56a524600ddc96f2 += level.overlord.events[ var_a5e7b5f3802fb434 ].timeout;
            }
        }
        
        if ( function_57fd9ae440a33a1a( event.speakerasset ) )
        {
            if ( !var_b4bc3c241f710bbd )
            {
                level.overlord.speaker_to_ent[ event.speakerasset ] thread dialogue::say( event.alias );
                var_b4bc3c241f710bbd = 1;
                lineplayed = 1;
            }
        }
        else
        {
            player queuedialogforplayer( #"queue1", event.alias, getxhashhexname( event.alias ), var_56a524600ddc96f2, "overlord", interruptcurrent, undefined, event.timeout );
            lineplayed = 1;
        }
        
        player.var_d83c183af7229499[ eventref ] = gettime();
        var_85f9b34a2668217c = function_f0eea7d189f26968( event, player );
        player val::set( "overlord", "allow_battlechatter_vo", 0 );
        player function_ecbb2f0677a0d29f( eventref, event.alias, var_85f9b34a2668217c, n_vo_wait, var_a39ec58f9e622178 );
        player utility::delaythreadendon( n_vo_wait + var_a39ec58f9e622178, [ "disconnect" ], &function_b44d0360a0214d28, event.alias, var_85f9b34a2668217c );
        player utility::delaythreadendon( n_vo_wait + var_a39ec58f9e622178, [ "disconnect" ], &val::reset, "overlord", "allow_battlechatter_vo" );
    }
    
    if ( var_6bf0a3568d4d9081 && n_vo_wait > 0 )
    {
        wait n_vo_wait;
    }
    
    if ( var_a39ec58f9e622178 > 0 )
    {
        wait var_a39ec58f9e622178;
    }
    
    return lineplayed;
}

// Namespace overlord
// Params 2, eflags: 0x4
// Checksum 0x60b38f05, Offset: 0x141b
// Size: 0x29
function private function_b44d0360a0214d28( str_vo_alias, str_vo_speaker )
{
    function_b1266db3e4de32f0( str_vo_alias, str_vo_speaker );
    self.var_5d3b2a20a597a075 = undefined;
}

// Namespace overlord
// Params 1, eflags: 0x4
// Checksum 0xb36df6fd, Offset: 0x144c
// Size: 0xa1
function private function_7e3bc1e7ad5c43eb( players )
{
    while ( true )
    {
        var_d592a89fb3c95647 = 1;
        
        foreach ( player in players )
        {
            if ( player function_3802335534c6ffd3() )
            {
                var_d592a89fb3c95647 = 0;
                break;
            }
        }
        
        if ( var_d592a89fb3c95647 )
        {
            return;
        }
        
        waitframe();
    }
}

// Namespace overlord
// Params 0
// Checksum 0x8483414b, Offset: 0x14f5
// Size: 0x73, Type: bool
function function_3802335534c6ffd3()
{
    assert( isplayer( self ) );
    player = self;
    
    if ( player function_2a4336a2a72f769c() && gettime() < player.var_5d3b2a20a597a075.endtime || player function_5b9a94f0c7f2bb5b() && gettime() < player.var_54025b165a4e02d8.endtime )
    {
        return true;
    }
    
    return false;
}

// Namespace overlord
// Params 1
// Checksum 0xe116eea6, Offset: 0x1571
// Size: 0x25
function function_f2fedd3be0be82ef( a_players = level.players )
{
    function_e155a19c69aed191( a_players );
}

// Namespace overlord
// Params 1
// Checksum 0x82b555e, Offset: 0x159e
// Size: 0x93
function function_e155a19c69aed191( players )
{
    foreach ( player in players )
    {
        player function_798dc57a283c8509();
        player end_overlord_event();
        player stopsoundchannel( "voice_radio_2d" );
    }
}

// Namespace overlord
// Params 6
// Checksum 0x11a90ff3, Offset: 0x1639
// Size: 0x792
function playconversation( conversationname, players, n_delay_before, var_3226ffc41619dbe2, location, group )
{
    level endon( #"hash_61db21d769f4ca03" );
    
    if ( !isdefined( players ) )
    {
        players = level.players;
    }
    
    if ( !isdefined( var_3226ffc41619dbe2 ) )
    {
        var_3226ffc41619dbe2 = 0;
    }
    
    if ( !isdefined( group ) )
    {
        group = "overlord";
    }
    
    var_124350ea4800601f = group == "overlord_intel";
    
    if ( isdefined( n_delay_before ) )
    {
        wait n_delay_before;
    }
    
    if ( utility::flag( "overlord_disabled" ) )
    {
        return;
    }
    
    s_conversation = level.overlord.conversations[ conversationname ];
    
    if ( isstring( conversationname ) && !isdefined( s_conversation ) )
    {
        conversationname = getxhash( conversationname );
        s_conversation = level.overlord.conversations[ conversationname ];
    }
    
    if ( isdefined( s_conversation ) )
    {
        var_1b50543a2597b875 = 0;
        
        foreach ( soundevent in s_conversation.soundevents )
        {
            var_1b50543a2597b875 += soundevent.priority ?? 75;
        }
        
        var_e59d4f30463e5d1a = var_1b50543a2597b875 / s_conversation.soundevents.size;
        var_fac353c81d16854c = 0;
        var_b28a10ad812b9acf = -1;
        
        foreach ( player in players )
        {
            if ( player function_5b9a94f0c7f2bb5b() )
            {
                var_fac353c81d16854c = 1;
                var_b28a10ad812b9acf = player.var_54025b165a4e02d8.priority;
                break;
            }
            
            if ( player function_2a4336a2a72f769c() )
            {
                var_fac353c81d16854c = 1;
                var_b28a10ad812b9acf = player.var_5d3b2a20a597a075.priority;
            }
        }
        
        if ( !var_124350ea4800601f && var_fac353c81d16854c && var_e59d4f30463e5d1a <= var_b28a10ad812b9acf && !var_3226ffc41619dbe2 )
        {
            function_7e3bc1e7ad5c43eb( players );
        }
        else
        {
            var_3226ffc41619dbe2 = 1;
            
            foreach ( player in players )
            {
                if ( player function_5b9a94f0c7f2bb5b() )
                {
                    player function_798dc57a283c8509();
                    continue;
                }
                
                if ( player function_2a4336a2a72f769c() )
                {
                    player end_overlord_event();
                }
            }
            
            waittillframeend();
        }
        
        var_b09a27514d46423 = function_e4b6b75b01ea6bc9( conversationname );
        
        foreach ( player in players )
        {
            if ( isdefined( player ) )
            {
                player.var_54025b165a4e02d8 = { #conversationname:conversationname, #priority:var_e59d4f30463e5d1a, #endtime:gettime() + var_b09a27514d46423 * 1000, #starttime:gettime() };
                player endon( getxhashhexname( conversationname ) + "_endon" );
            }
        }
        
        foreach ( n_event, var_5dbf98f197b02dc9 in s_conversation.soundevents )
        {
            if ( !isdefined( var_5dbf98f197b02dc9.alias ) )
            {
                foreach ( player in players )
                {
                    if ( isdefined( player ) && n_event >= s_conversation.soundevents.size - 1 )
                    {
                        player.var_54025b165a4e02d8 = undefined;
                    }
                }
                
                continue;
            }
            
            if ( isdefined( var_5dbf98f197b02dc9.delaybefore ) )
            {
                wait var_5dbf98f197b02dc9.delaybefore;
            }
            
            utility::flag_waitopen( "overlord_paused" );
            eventref = var_5dbf98f197b02dc9.alias;
            n_vo_wait = level.overlord.events[ eventref ].timeout;
            var_a39ec58f9e622178 = var_5dbf98f197b02dc9.delayafter ?? 0;
            var_b4bc3c241f710bbd = 0;
            
            if ( !var_124350ea4800601f )
            {
                foreach ( player in players )
                {
                    if ( isdefined( player ) )
                    {
                        player function_3ef24b8449e99bf4();
                        var_85f9b34a2668217c = function_f0eea7d189f26968( var_5dbf98f197b02dc9, player );
                        player val::set( "overlord", "allow_battlechatter_vo", 0 );
                        player function_ecbb2f0677a0d29f( conversationname, var_5dbf98f197b02dc9.alias, var_85f9b34a2668217c, n_vo_wait, var_a39ec58f9e622178 );
                        
                        if ( function_57fd9ae440a33a1a( var_5dbf98f197b02dc9.speakerasset ) )
                        {
                            if ( !var_b4bc3c241f710bbd )
                            {
                                level.overlord.speaker_to_ent[ var_5dbf98f197b02dc9.speakerasset ] thread dialogue::say( var_5dbf98f197b02dc9.alias );
                                var_b4bc3c241f710bbd = 1;
                            }
                            
                            continue;
                        }
                        
                        player queuedialogforplayer( #"queue1", var_5dbf98f197b02dc9.alias, getxhashhexname( var_5dbf98f197b02dc9.alias ), n_vo_wait, group, var_3226ffc41619dbe2, location, n_vo_wait );
                    }
                }
                
                wait n_vo_wait + var_a39ec58f9e622178;
                
                foreach ( player in players )
                {
                    if ( isdefined( player ) )
                    {
                        var_85f9b34a2668217c = function_f0eea7d189f26968( var_5dbf98f197b02dc9, player );
                        player function_b1266db3e4de32f0( var_5dbf98f197b02dc9.alias, var_85f9b34a2668217c );
                        player val::reset( "overlord", "allow_battlechatter_vo" );
                        
                        if ( n_event >= s_conversation.soundevents.size - 1 )
                        {
                            player.var_54025b165a4e02d8 = undefined;
                        }
                    }
                }
                
                continue;
            }
            
            if ( isdefined( location ) )
            {
                playsoundatpos( location, var_5dbf98f197b02dc9.alias );
                wait n_vo_wait + var_a39ec58f9e622178;
            }
        }
        
        return 1;
    }
    
    return 0;
}

// Namespace overlord
// Params 1
// Checksum 0xc1d2cc5e, Offset: 0x1dd4
// Size: 0x275
function function_e4b6b75b01ea6bc9( conversationname )
{
    if ( isdefined( level.overlord.conversations[ conversationname ].var_b09a27514d46423 ) )
    {
        return level.overlord.conversations[ conversationname ].var_b09a27514d46423;
    }
    
    s_conversation = level.overlord.conversations[ conversationname ];
    
    if ( isstring( conversationname ) && !isdefined( s_conversation ) )
    {
        conversationname = getxhash( conversationname );
        s_conversation = level.overlord.conversations[ conversationname ];
    }
    
    var_b09a27514d46423 = 0;
    
    foreach ( var_5dbf98f197b02dc9 in s_conversation.soundevents )
    {
        if ( isdefined( var_5dbf98f197b02dc9.delaybefore ) )
        {
            var_b09a27514d46423 += var_5dbf98f197b02dc9.delaybefore;
        }
        
        if ( isdefined( var_5dbf98f197b02dc9.alias ) )
        {
            eventref = var_5dbf98f197b02dc9.alias;
            
            if ( !isdefined( level.overlord.events[ eventref ] ) )
            {
                registerevent( eventref, var_5dbf98f197b02dc9.alias, var_5dbf98f197b02dc9.priority, var_5dbf98f197b02dc9.cooldown, utility::function_6f5d2e1f1ff70482( lookupsoundlength( var_5dbf98f197b02dc9.alias, 1 ) ) + 0.25, var_5dbf98f197b02dc9.speakerasset, var_5dbf98f197b02dc9.delaybefore, var_5dbf98f197b02dc9.delayafter, var_5dbf98f197b02dc9.var_73f6b935645e7cfc );
            }
            
            var_b09a27514d46423 += level.overlord.events[ eventref ].timeout;
        }
        
        if ( isdefined( var_5dbf98f197b02dc9.delayafter ) )
        {
            var_b09a27514d46423 += var_5dbf98f197b02dc9.delayafter;
        }
    }
    
    level.overlord.conversations[ conversationname ].var_b09a27514d46423 = var_b09a27514d46423;
    return level.overlord.conversations[ conversationname ].var_b09a27514d46423;
}

// Namespace overlord
// Params 5, eflags: 0x4
// Checksum 0x6f568083, Offset: 0x2052
// Size: 0xa5
function private function_ecbb2f0677a0d29f( var_1dc0c251ad7100fe, str_vo_alias, var_85f9b34a2668217c, n_vo_wait, var_a39ec58f9e622178 )
{
    if ( !isdefined( self.var_3f334ef2f451c86 ) )
    {
        self.var_3f334ef2f451c86 = [];
    }
    
    if ( !isdefined( self.var_e71ef6cee3b92903 ) )
    {
        self.var_e71ef6cee3b92903 = [];
    }
    
    self.var_3f334ef2f451c86[ self.var_3f334ef2f451c86.size ] = str_vo_alias;
    
    if ( isdefined( var_85f9b34a2668217c ) )
    {
        self.var_e71ef6cee3b92903[ self.var_e71ef6cee3b92903.size ] = var_85f9b34a2668217c;
    }
    
    thread function_7678502ce4da9855( var_1dc0c251ad7100fe, str_vo_alias, var_85f9b34a2668217c, n_vo_wait, var_a39ec58f9e622178 );
    function_f5994012a6e47d2a();
}

// Namespace overlord
// Params 5, eflags: 0x4
// Checksum 0x7ec0e71, Offset: 0x20ff
// Size: 0xf1
function private function_7678502ce4da9855( var_1dc0c251ad7100fe, str_vo_alias, str_vo_speaker, n_vo_wait, var_a39ec58f9e622178 = 0 )
{
    self endon( getxhashhexname( str_vo_alias ) + "_endon" );
    msg = utility::waittill_any_timeout( n_vo_wait + var_a39ec58f9e622178 + level.framedurationseconds, getxhashhexname( var_1dc0c251ad7100fe ) + "_endon", "end_overlord_event", "disconnect" );
    
    if ( isdefined( self ) )
    {
        if ( isdefined( self.var_54025b165a4e02d8 ) && self.var_54025b165a4e02d8.conversationname == var_1dc0c251ad7100fe )
        {
            self.var_54025b165a4e02d8 = undefined;
        }
        else if ( isdefined( self.var_5d3b2a20a597a075 ) && self.var_5d3b2a20a597a075.eventref == var_1dc0c251ad7100fe )
        {
            self.var_5d3b2a20a597a075 = undefined;
        }
        
        thread function_b1266db3e4de32f0( str_vo_alias, str_vo_speaker );
    }
}

// Namespace overlord
// Params 2, eflags: 0x4
// Checksum 0x55dd35d2, Offset: 0x21f8
// Size: 0x108
function private function_b1266db3e4de32f0( str_vo_alias, var_85f9b34a2668217c )
{
    self notify( getxhashhexname( str_vo_alias ) + "_endon" );
    
    if ( isarray( self.var_3f334ef2f451c86 ) )
    {
        self.var_3f334ef2f451c86 = arrayremove( self.var_3f334ef2f451c86, str_vo_alias );
    }
    
    if ( isdefined( var_85f9b34a2668217c ) && isarray( self.var_e71ef6cee3b92903 ) )
    {
        foreach ( index, speaker in self.var_e71ef6cee3b92903 )
        {
            if ( speaker == var_85f9b34a2668217c )
            {
                self.var_e71ef6cee3b92903[ index ] = undefined;
                self.var_e71ef6cee3b92903 = function_5713d46873b29625( self.var_e71ef6cee3b92903 );
                break;
            }
        }
    }
    
    function_f5994012a6e47d2a( var_85f9b34a2668217c );
}

// Namespace overlord
// Params 0, eflags: 0x4
// Checksum 0xcef8c4fb, Offset: 0x2308
// Size: 0x35
function private function_798dc57a283c8509()
{
    if ( function_5b9a94f0c7f2bb5b() )
    {
        self notify( getxhashhexname( self.var_54025b165a4e02d8.conversationname ) + "_endon" );
        self.var_54025b165a4e02d8 = undefined;
    }
}

// Namespace overlord
// Params 0, eflags: 0x4
// Checksum 0x56599249, Offset: 0x2345
// Size: 0x35
function private end_overlord_event()
{
    if ( function_2a4336a2a72f769c() )
    {
        self notify( getxhashhexname( self.var_5d3b2a20a597a075.eventref ) + "_endon" );
        self.var_5d3b2a20a597a075 = undefined;
    }
}

// Namespace overlord
// Params 1, eflags: 0x4
// Checksum 0xd99441a7, Offset: 0x2382
// Size: 0xa4
function private function_f5994012a6e47d2a( var_8f504e21a91cd373 )
{
    if ( !isarray( self.var_e71ef6cee3b92903 ) || self.var_e71ef6cee3b92903.size == 0 )
    {
        str_vo_speaker = undefined;
    }
    else
    {
        str_vo_speaker = self.var_e71ef6cee3b92903[ self.var_e71ef6cee3b92903.size - 1 ];
    }
    
    if ( !isdefined( str_vo_speaker ) || str_vo_speaker == "" )
    {
        if ( isdefined( level.var_8b4ae0e9bea5384c ) )
        {
            self [[ level.var_8b4ae0e9bea5384c ]]( var_8f504e21a91cd373 );
        }
        
        return;
    }
    
    if ( isdefined( level.var_e0b31e63f5a29e85 ) )
    {
        self [[ level.var_e0b31e63f5a29e85 ]]( str_vo_speaker );
    }
}

// Namespace overlord
// Params 0
// Checksum 0x2d3292d1, Offset: 0x242e
// Size: 0x18, Type: bool
function function_5b9a94f0c7f2bb5b()
{
    if ( isdefined( self ) && isdefined( self.var_54025b165a4e02d8 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace overlord
// Params 0
// Checksum 0xf626cdb2, Offset: 0x244f
// Size: 0x18, Type: bool
function function_2a4336a2a72f769c()
{
    if ( isdefined( self ) && isdefined( self.var_5d3b2a20a597a075 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace overlord
// Params 1
// Checksum 0xa99a6bbf, Offset: 0x2470
// Size: 0xa0, Type: bool
function function_dce0a14273dfa0a8( a_players = level.players )
{
    foreach ( player in a_players )
    {
        if ( player function_2a4336a2a72f769c() || player function_5b9a94f0c7f2bb5b() )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace overlord
// Params 1
// Checksum 0x36983de2, Offset: 0x2519
// Size: 0x2b
function function_29d8b7aaf2aa133a( a_players = level.players )
{
    while ( function_dce0a14273dfa0a8( a_players ) )
    {
        waitframe();
    }
}

// Namespace overlord
// Params 2
// Checksum 0x5d0c0db1, Offset: 0x254c
// Size: 0x2d
function function_e6108fa010209ab0( var_85f9b34a2668217c, ent )
{
    level.overlord.speaker_to_ent[ var_85f9b34a2668217c ] = ent;
}

// Namespace overlord
// Params 2, eflags: 0x4
// Checksum 0xe74bb74b, Offset: 0x2581
// Size: 0x17f
function private function_f0eea7d189f26968( var_4898937df57cfd50, player )
{
    if ( !isdefined( var_4898937df57cfd50.var_73f6b935645e7cfc ) || var_4898937df57cfd50.var_73f6b935645e7cfc == 0 )
    {
        var_85f9b34a2668217c = var_4898937df57cfd50.speakerasset;
    }
    else if ( isdefined( player ) && isdefined( level.overlord.speaker_to_ent[ var_4898937df57cfd50.speakerasset ] ) )
    {
        if ( var_4898937df57cfd50.var_73f6b935645e7cfc == -1 )
        {
        }
        else if ( var_4898937df57cfd50.var_73f6b935645e7cfc > 0 )
        {
            if ( distance( player.origin, level.overlord.speaker_to_ent[ var_4898937df57cfd50.speakerasset ].origin ) <= var_4898937df57cfd50.var_73f6b935645e7cfc )
            {
                var_85f9b34a2668217c = var_4898937df57cfd50.speakerasset;
            }
        }
        else if ( var_4898937df57cfd50.var_73f6b935645e7cfc < 0 )
        {
            if ( distance( player.origin, level.overlord.speaker_to_ent[ var_4898937df57cfd50.speakerasset ].origin ) > abs( var_4898937df57cfd50.var_73f6b935645e7cfc ) )
            {
                var_85f9b34a2668217c = var_4898937df57cfd50.speakerasset;
            }
        }
    }
    else if ( var_4898937df57cfd50.var_73f6b935645e7cfc != -1 )
    {
        var_85f9b34a2668217c = var_4898937df57cfd50.speakerasset;
    }
    
    return var_85f9b34a2668217c;
}

// Namespace overlord
// Params 1
// Checksum 0x62b3d0a8, Offset: 0x2709
// Size: 0x4d, Type: bool
function function_57fd9ae440a33a1a( var_85f9b34a2668217c )
{
    ent_speaker = level.overlord.speaker_to_ent[ var_85f9b34a2668217c ];
    
    if ( isdefined( ent_speaker ) && ( !isai( ent_speaker ) || isalive( ent_speaker ) ) )
    {
        return true;
    }
    
    return false;
}

// Namespace overlord
// Params 5
// Checksum 0xaa407684, Offset: 0x275f
// Size: 0xa3
function function_3aaf8e5681173423( eventref, team, squadindex, delay, includedeadplayers )
{
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    players = isdefined( team ) && isdefined( squadindex ) && utility::issharedfuncdefined( #"game", #"getsquadmates" ) ? [[ utility::getsharedfunc( #"game", #"getsquadmates" ) ]]( team, squadindex ) : level.players;
    playevent( eventref, players, delay, includedeadplayers );
}

// Namespace overlord
// Params 4
// Checksum 0xb0113039, Offset: 0x280a
// Size: 0x68
function function_be2d6dc71f97faa6( eventref, team, delay, includedeadplayers )
{
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    players = isdefined( team ) ? teams::getteamdata( team, "players" ) : level.players;
    playevent( eventref, players, delay, includedeadplayers );
}

// Namespace overlord
// Params 7
// Checksum 0x3913d6eb, Offset: 0x287a
// Size: 0xff
function function_5226f9b674411bef( eventrefs, end_flag, var_8b04137784706899, var_afe81a7ad568d937, team, start_delay, includedeadplayers )
{
    level endon( end_flag );
    
    if ( utility::flag( end_flag ) )
    {
        return;
    }
    
    if ( isdefined( start_delay ) )
    {
        wait start_delay;
    }
    
    players = isdefined( team ) ? teams::getteamdata( team, "players" ) : level.players;
    lastevent = undefined;
    possibleevents = eventrefs;
    
    while ( true )
    {
        if ( eventrefs.size > 1 )
        {
            chosenevent = utility::array_random( possibleevents );
            possibleevents = arrayremove( possibleevents, chosenevent );
            possibleevents[ possibleevents.size ] = lastevent;
            lastevent = chosenevent;
        }
        else
        {
            chosenevent = possibleevents[ 0 ];
        }
        
        playevent( chosenevent, players, undefined, includedeadplayers );
        
        if ( !isdefined( var_afe81a7ad568d937 ) )
        {
            wait var_8b04137784706899;
            continue;
        }
        
        wait randomfloatrange( var_8b04137784706899, var_afe81a7ad568d937 );
    }
}

// Namespace overlord
// Params 1
// Checksum 0x4592c3b2, Offset: 0x2981
// Size: 0x49, Type: bool
function function_982ce2981b4530b9( eventref )
{
    if ( level.overlord.events[ eventref ].priority < self.overlordlockedpriority )
    {
        return false;
    }
    
    return !isdefined( self.var_d83c183af7229499[ eventref ] );
}

// Namespace overlord
// Params 0
// Checksum 0x789561b8, Offset: 0x29d3
// Size: 0x186
function function_3ef24b8449e99bf4()
{
    if ( !isdefined( self.var_d83c183af7229499 ) )
    {
        self.var_d83c183af7229499 = [];
        return;
    }
    
    var_7915d05cdd4d4c5c = [];
    currenttime = gettime();
    
    foreach ( eventref, n_start_time in self.var_d83c183af7229499 )
    {
        if ( !isdefined( level.overlord.events[ eventref ] ) )
        {
            continue;
        }
        
        n_time_to_remove = n_start_time + utility::function_4b74c15943231980( level.overlord.events[ eventref ].timeout ) + level.overlord.events[ eventref ].cooldown;
        
        if ( n_time_to_remove < currenttime )
        {
            var_7915d05cdd4d4c5c[ eventref ] = n_start_time;
        }
    }
    
    foreach ( eventref, n_start_time in var_7915d05cdd4d4c5c )
    {
        self.var_d83c183af7229499[ eventref ] = undefined;
    }
}

// Namespace overlord
// Params 2
// Checksum 0x6424e5d5, Offset: 0x2b61
// Size: 0xd9, Type: bool
function function_b329f59a03497e56( player, eventref )
{
    if ( !isdefined( player.var_d83c183af7229499 ) )
    {
        return false;
    }
    
    if ( !isdefined( player.var_d83c183af7229499[ eventref ] ) )
    {
        return false;
    }
    
    if ( !isdefined( level.overlord.events[ eventref ] ) )
    {
        return false;
    }
    
    if ( !isdefined( level.overlord.events[ eventref ].cooldown ) )
    {
        return false;
    }
    
    lasttime = player.var_d83c183af7229499[ eventref ];
    cooldowntime = level.overlord.events[ eventref ].cooldown;
    currenttime = gettime();
    return lasttime + cooldowntime >= currenttime;
}

// Namespace overlord
// Params 1
// Checksum 0x508d0c1b, Offset: 0x2c43
// Size: 0x149, Type: bool
function shouldinterrupt( event )
{
    if ( function_5b9a94f0c7f2bb5b() )
    {
        if ( event.priority > self.var_54025b165a4e02d8.priority )
        {
            function_798dc57a283c8509();
            return true;
        }
        else if ( getdvarint( @"hash_ec5ffe1a34b9c8a3", 0 ) )
        {
            return false;
        }
    }
    
    if ( getdvarint( @"hash_ec5ffe1a34b9c8a3", 0 ) )
    {
        if ( function_2a4336a2a72f769c() && event.priority > self.var_5d3b2a20a597a075.priority )
        {
            end_overlord_event();
            return true;
        }
        else
        {
            return false;
        }
    }
    else
    {
        foreach ( eventref, n_start_time in self.var_d83c183af7229499 )
        {
            if ( event.priority <= level.overlord.events[ eventref ].priority )
            {
                return false;
            }
        }
    }
    
    return true;
}

// Namespace overlord
// Params 1
// Checksum 0xadd053a8, Offset: 0x2d95
// Size: 0x48
function function_2fb527a541b257( var_f1fbc291f2430b1e = 1 )
{
    if ( var_f1fbc291f2430b1e )
    {
        utility::flag_clear( "overlord_disabled" );
        return;
    }
    
    utility::flag_set( "overlord_disabled" );
    level notify( #"hash_61db21d769f4ca03" );
    function_f2fedd3be0be82ef();
}

// Namespace overlord
// Params 1
// Checksum 0xa1da0608, Offset: 0x2de5
// Size: 0x35
function function_724ca7b94bf1fb66( b_paused = 1 )
{
    if ( b_paused )
    {
        utility::flag_set( "overlord_paused" );
        return;
    }
    
    utility::flag_clear( "overlord_paused" );
}

// Namespace overlord
// Params 1, eflags: 0x4
// Checksum 0xfeaa5521, Offset: 0x2e22
// Size: 0x2d, Type: bool
function private function_b6d4dbab59e23dd4( player )
{
    var_2bcb9505ac92059b = isdefined( player.perks[ "specialty_pc_stealth" ] );
    return !var_2bcb9505ac92059b;
}

// Namespace overlord
// Params 1, eflags: 0x4
// Checksum 0x1fdbf689, Offset: 0x2e58
// Size: 0x85, Type: bool
function private isvalidplayer( player )
{
    additionalchecks = 1;
    
    if ( isfunction( level.var_2ead7b56ac622344 ) )
    {
        additionalchecks = [[ level.var_2ead7b56ac622344 ]]( player );
    }
    
    return isdefined( player.team ) && isdefined( player.origin ) && isalive( player ) && !isdefined( player.fauxdead ) && !player.delayedspawnedplayernotify && additionalchecks;
}

// Namespace overlord
// Params 0
// Checksum 0xb374984a, Offset: 0x2ee6
// Size: 0x460
function function_8934b0432be77501()
{
    proximitydistancesq = getdvarint( @"scr_overlord_enemy_proximity_radius", 4096 );
    proximitydistancesq *= proximitydistancesq;
    ignoretime = getdvarfloat( @"hash_32244d6acf101808", 60 );
    trackedteams = [];
    
    foreach ( team in level.teamnamelist )
    {
        trackedteams[ team ] = [];
    }
    
    while ( true )
    {
        validplayers = [];
        
        foreach ( player in level.players )
        {
            if ( isvalidplayer( player ) )
            {
                validplayers[ validplayers.size ] = player;
            }
        }
        
        partition = utility::create_partition( validplayers, 2500, 1 );
        
        foreach ( player in validplayers )
        {
            if ( !isvalidplayer( player ) )
            {
                continue;
            }
            
            foreach ( playerarray in partition utility::function_92fef8fe5211a388( player.origin ) )
            {
                foreach ( testplayer in playerarray )
                {
                    if ( !isvalidplayer( testplayer ) || !function_b6d4dbab59e23dd4( testplayer ) )
                    {
                        continue;
                    }
                    
                    if ( player.team == testplayer.team || distancesquared( player.origin, testplayer.origin ) > proximitydistancesq )
                    {
                        continue;
                    }
                    
                    var_5bf2f08fe4d22f25 = function_70f4065e38bf4c38( player, testplayer, trackedteams, ignoretime );
                    
                    if ( var_5bf2f08fe4d22f25 )
                    {
                        testplayers = teams::getteamdata( testplayer.team, "players" );
                        eventplayers = teams::getteamdata( player.team, "players" );
                        var_5242bc54fa607311 = [];
                        
                        foreach ( eventplayer in eventplayers )
                        {
                            if ( getdvarint( @"hash_c53afaea3f55391a", 0 ) && isdefined( eventplayer.perks[ "specialty_pc_comms" ] ) )
                            {
                                continue;
                            }
                            
                            var_5242bc54fa607311[ var_5242bc54fa607311.size ] = eventplayer;
                        }
                        
                        level thread playevent( testplayers.size > level.overlord.var_ef8e3b0c4aa6baf3 ? "nearby_big_team" : "player_enemy_player_nearby", var_5242bc54fa607311 );
                        trackedteams[ player.team ][ testplayer.team ] = gettime();
                    }
                }
            }
            
            waitframe();
        }
        
        wait 3;
    }
}

// Namespace overlord
// Params 1
// Checksum 0xaba2b0a7, Offset: 0x334e
// Size: 0x3b5
function function_e4b131025a62a0f9( player )
{
    player notify( #"hash_93c1e3a2e9da1586" );
    player endon( #"disconnect" );
    player endon( #"death" );
    level endon( #"game_ended" );
    player endon( #"hash_93c1e3a2e9da1586" );
    proximitydistancesq = getdvarint( @"scr_overlord_enemy_proximity_radius", 4096 );
    proximitydistancesq *= proximitydistancesq;
    ignoretime = getdvarfloat( @"hash_32244d6acf101808", 60 );
    trackedteams = [];
    
    foreach ( team in level.teamnamelist )
    {
        trackedteams[ team ] = [];
    }
    
    while ( true )
    {
        validplayers = [];
        
        foreach ( validplayer in level.players )
        {
            if ( isvalidplayer( validplayer ) )
            {
                validplayers[ validplayers.size ] = validplayer;
            }
        }
        
        partition = utility::create_partition( validplayers, 2500, 1 );
        
        foreach ( playerarray in partition utility::function_92fef8fe5211a388( player.origin ) )
        {
            foreach ( testplayer in playerarray )
            {
                if ( !isvalidplayer( testplayer ) || !function_b6d4dbab59e23dd4( testplayer ) )
                {
                    continue;
                }
                
                if ( player.team == testplayer.team || distancesquared( player.origin, testplayer.origin ) > proximitydistancesq )
                {
                    continue;
                }
                
                var_5bf2f08fe4d22f25 = !isdefined( trackedteams[ player.team ][ testplayer.team ] ) || ( gettime() - trackedteams[ player.team ][ testplayer.team ] ) / 1000 > ignoretime;
                
                if ( var_5bf2f08fe4d22f25 )
                {
                    testplayers = teams::getteamdata( testplayer.team, "players" );
                    playevent( testplayers.size > level.overlord.var_ef8e3b0c4aa6baf3 ? "nearby_big_team" : "player_enemy_player_nearby", [ player ] );
                    trackedteams[ player.team ][ testplayer.team ] = gettime();
                }
            }
        }
        
        wait 3;
    }
}

// Namespace overlord
// Params 1
// Checksum 0x1d6a47fb, Offset: 0x370b
// Size: 0x17
function setoverlordlockedpriority( val )
{
    self.overlordlockedpriority = val;
}

// Namespace overlord
// Params 3
// Checksum 0x5daa60f6, Offset: 0x372a
// Size: 0x98
function function_887cf4f7cba8cfa8( players, tag, priority )
{
    foreach ( player in players )
    {
        player val::set( tag, "overlord_locked_priority", priority );
    }
}

// Namespace overlord
// Params 2
// Checksum 0x1d70650c, Offset: 0x37ca
// Size: 0x8d
function function_ec9b8fd48f81a9e7( players, tag )
{
    foreach ( player in players )
    {
        player val::reset( tag, "overlord_locked_priority" );
    }
}

// Namespace overlord
// Params 4
// Checksum 0xacd68a90, Offset: 0x385f
// Size: 0xc8
function function_70f4065e38bf4c38( player, testplayer, trackedteams, ignoretime )
{
    var_5bf2f08fe4d22f25 = !isdefined( trackedteams[ player.team ][ testplayer.team ] ) || ( gettime() - trackedteams[ player.team ][ testplayer.team ] ) / 1000 > ignoretime;
    
    if ( getdvarint( @"hash_c53afaea3f55391a", 0 ) )
    {
        testplayers = teams::getteamdata( testplayer.team, "players" );
        return ( var_5bf2f08fe4d22f25 && testplayers.size > level.overlord.var_ef8e3b0c4aa6baf3 );
    }
    
    return var_5bf2f08fe4d22f25;
}

/#

    // Namespace overlord
    // Params 0
    // Checksum 0x42e7f37, Offset: 0x3930
    // Size: 0x133, Type: dev
    function function_f456a592022bf8f5()
    {
        flags::gameflagwait( "<dev string:x24>" );
        yinterval = 30;
        xpos = 300;
        
        while ( true )
        {
            player = level.players[ 0 ];
            ypos = 100;
            printtoscreen2d( xpos, ypos, "<dev string:x32>", ( 1, 1, 1 ), 1, 3 );
            ypos += yinterval;
            
            if ( isdefined( player.var_d83c183af7229499 ) )
            {
                foreach ( index, event in player.var_d83c183af7229499 )
                {
                    eventname = getxhashsourcename( index );
                    printtoscreen2d( xpos, ypos, eventname + "<dev string:x41>" + event, ( 1, 1, 1 ), 1, 3 );
                    ypos += yinterval;
                }
            }
            
            waitframe();
        }
    }

#/
