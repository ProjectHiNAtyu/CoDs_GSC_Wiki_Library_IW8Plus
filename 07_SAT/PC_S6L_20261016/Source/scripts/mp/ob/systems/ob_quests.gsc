// scripts\mp\ob\systems\ob_quests.gsc  (hash_4ab410c0ed8f2f8c.gscc) (size: 20211 Bytes / 0x4ef3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe0d010ff (3771732223)
// size ...... 20211 (0x4ef3)
// includes .. 11  (offset: 0x48df)
// strings ... 47  (offset: 0x4937)
// dev strs .. 46  (offset: 0x4c93)
// exports ... 27  (offset: 0x35c7)
// cseg ...... 0x432 + 0x3195 (0x35c7)
// imports ... 115 (offset: 0x39ff)
// animtree1 . 0   (offset: 0x4ef3)
// animtree2 . 0   (offset: 0x4ef3)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\mp\challenges\ob_challenges;
#using scripts\mp\gametypes\ob;
#using scripts\mp\hud_message;
#using scripts\mp\overlord;
#using scripts\mp\playerachievements;

#namespace ob_quests;

// Namespace ob_quests
// Params 0, eflags: 0x5
// Checksum 0x9ff6c1ab, Offset: 0x450
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"ob_quests", undefined, &_pre_main_init, undefined );
}

// Namespace ob_quests
// Params 0, eflags: 0x4
// Checksum 0x736c3219, Offset: 0x471
// Size: 0x160
function private _pre_main_init()
{
    /#
        if ( isofflinetoolrun( 31 ) )
        {
            return;
        }
    #/
    
    if ( !ob::get_ob_settings().var_f5fa39823e8b379c )
    {
        return;
    }
    
    setdvarifuninitialized( @"scr_ob_quests_enabled", 1 );
    
    /#
        setdvarifuninitialized( @"scr_ob_quests_debug", 0 );
        setdvarifuninitialized( @"scr_ob_quests_devgui", 0 );
        setdvarifuninitialized( @"hash_2bf6d08872eac6ce", 0 );
    #/
    
    if ( !quests_enabled() )
    {
        return;
    }
    
    level function_7c49cc858bf9c346();
    utility::registersharedfunc( #"ob_quest", #"get_active_quest", &get_active_quest );
    utility::registersharedfunc( #"ob_quest", #"is_quest_completed", &is_quest_completed );
    utility::registersharedfunc( #"ob_quest", #"hash_e98cb49910a093f9", &function_95e92b616270f44 );
    utility::registersharedfunc( #"ob_quest", #"hash_ac975ab816f57494", &function_7d94995331621e0d );
    level ui::lui_registercallback( "scoreboard_open", &function_1da22972ba25bc1f );
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"set_quest", &debug_set_quest );
    
    /#
        level thread function_fa6ff7b4bee6ad06();
    #/
    
    callback::add( #"hash_cc06eb1d45f33a0c", &function_a96ed90a51781e04 );
    callback::add( #"hash_22fdd0c3eb081084", &function_35c8829a652c7bee );
    callback::add( #"player_challenge_complete", &function_3a0d054fd55e24b8 );
}

// Namespace ob_quests
// Params 0
// Checksum 0xef2a52e5, Offset: 0x5d9
// Size: 0x3d, Type: bool
function quests_enabled()
{
    /#
        if ( isofflinetoolrun( 31 ) )
        {
            return false;
        }
    #/
    
    if ( !ob::get_ob_settings().var_f5fa39823e8b379c )
    {
        return false;
    }
    
    if ( !getdvarint( @"scr_ob_quests_enabled", 1 ) )
    {
        return false;
    }
    
    return true;
}

// Namespace ob_quests
// Params 0, eflags: 0x4
// Checksum 0x180f138d, Offset: 0x61f
// Size: 0x576
function private function_7c49cc858bf9c346()
{
    gamemodebundle = getgamemodescriptbundle();
    
    if ( !gamemodebundle.factionmissiontable )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    faction_mission_table = getscriptbundle( gamemodebundle.factionmissiontable );
    
    if ( !faction_mission_table )
    {
        assertmsg( "<dev string:x67>" );
        return;
    }
    
    var_a9236f789910bfc8 = faction_mission_table.var_ed62d22a8f52d519;
    
    if ( !tableexists( var_a9236f789910bfc8 ) )
    {
        assertmsg( "<dev string:xa9>" );
        return;
    }
    
    level.ob_quest_achievements = [];
    level.var_8e8450103b4f5ede = [];
    level.var_44a7bb8d4ccc1ade = [];
    level.var_c4d57d774e5f2d68 = 0;
    act_index = -1;
    lastquest = undefined;
    
    foreach ( entry in faction_mission_table.factionmissiontable )
    {
        if ( !entry.factionmission )
        {
            continue;
        }
        
        act_ref = getscriptbundlefieldvalue( entry.factionmission, #"ref" );
        
        if ( !act_ref )
        {
            continue;
        }
        
        act_ref = getxhash( act_ref );
        act_row = tablelookuprownum( var_a9236f789910bfc8, 1, act_ref );
        
        if ( !isdefined( act_row ) || act_row == -1 )
        {
            logstring( "[OB_QUESTS] Unable to find act ref [" + act_ref + "] in the quests csv." );
            continue;
        }
        
        act_id = tablelookupbyrow( var_a9236f789910bfc8, act_row, 0 );
        
        if ( !act_id || act_id == "" )
        {
            assertmsg( "<dev string:xdf>" + act_row + "<dev string:xf0>" );
            continue;
        }
        
        act_id = int( act_id );
        act_index += 1;
        act_quests = [];
        var_9e2d35cdf35d1890 = strtok( tablelookupbyrow( var_a9236f789910bfc8, act_row, 8 ), "|" );
        
        foreach ( act_quest_index, var_45704952f2a94cd in var_9e2d35cdf35d1890 )
        {
            act_quest_id = int( var_45704952f2a94cd );
            var_b1b84c0f6b0191e8 = tablelookuprownum( var_a9236f789910bfc8, 0, act_quest_id );
            
            if ( !isdefined( var_b1b84c0f6b0191e8 ) )
            {
                assertmsg( "<dev string:x115>" + act_quest_id + "<dev string:x13b>" );
                continue;
            }
            
            act_quest_challenges = [];
            var_28db6f91ef54f5a6 = strtok( tablelookupbyrow( var_a9236f789910bfc8, var_b1b84c0f6b0191e8, 8 ), "|" );
            
            foreach ( var_6737609a708cf45a, var_bda5b96995f59bfb in var_28db6f91ef54f5a6 )
            {
                var_966fdaea42c2c8ab = int( var_bda5b96995f59bfb );
                var_11d4fa2fb1e1b96a = tablelookuprownum( var_a9236f789910bfc8, 0, var_966fdaea42c2c8ab );
                
                if ( !isdefined( var_11d4fa2fb1e1b96a ) )
                {
                    assertmsg( "<dev string:x115>" + var_966fdaea42c2c8ab + "<dev string:x13b>" );
                    continue;
                }
                
                level.ob_quest_achievements[ var_966fdaea42c2c8ab ] = { #var_b5fc66c6d4a92f4c:int( tablelookupbyrow( var_a9236f789910bfc8, var_11d4fa2fb1e1b96a, 5 ) ), #ref:tablelookupbyrow( var_a9236f789910bfc8, var_11d4fa2fb1e1b96a, 1 ), #id:var_966fdaea42c2c8ab };
                level.var_8e8450103b4f5ede[ level.ob_quest_achievements[ var_966fdaea42c2c8ab ].ref ] = var_966fdaea42c2c8ab;
                act_quest_challenges[ var_6737609a708cf45a ] = level.ob_quest_achievements[ var_966fdaea42c2c8ab ];
            }
            
            splash_asset = tablelookupbyrow( var_a9236f789910bfc8, var_b1b84c0f6b0191e8, 4 );
            
            if ( splash_asset )
            {
                splash_ref = getscriptbundlefieldvalue( splash_asset, #"hash_2a40660de5663847" );
            }
            
            level.ob_quest_achievements[ act_quest_id ] = { #act_index:act_index, #act_id:act_id, #challenges:act_quest_challenges, #var_b5fc66c6d4a92f4c:1, #splash_ref:splash_ref, #ref:tablelookupbyrow( var_a9236f789910bfc8, var_b1b84c0f6b0191e8, 1 ), #id:act_quest_id };
            level.var_8e8450103b4f5ede[ level.ob_quest_achievements[ act_quest_id ].ref ] = act_quest_id;
            
            if ( lastquest )
            {
                lastquest.next = level.ob_quest_achievements[ act_quest_id ];
            }
            
            act_quests[ act_quest_index ] = level.ob_quest_achievements[ act_quest_id ];
            lastquest = level.ob_quest_achievements[ act_quest_id ];
        }
        
        level.ob_quest_achievements[ act_id ] = { #act_index:act_index, #quests:act_quests, #var_b5fc66c6d4a92f4c:1, #ref:act_ref, #id:act_id };
        level.var_8e8450103b4f5ede[ act_ref ] = act_id;
        level.var_44a7bb8d4ccc1ade[ act_id ] = level.ob_quest_achievements[ act_id ];
    }
}

// Namespace ob_quests
// Params 1
// Checksum 0x4497560, Offset: 0xb9d
// Size: 0x2d, Type: bool
function get_active_quest( player )
{
    return player.var_a1bb7e25335e7165.ref ?? #"";
}

// Namespace ob_quests
// Params 2
// Checksum 0x21c89c58, Offset: 0xbd3
// Size: 0xc1
function is_quest_completed( player, quest_ref )
{
    var_7df69d66d51f7524 = level.var_8e8450103b4f5ede[ quest_ref ];
    
    if ( !var_7df69d66d51f7524 )
    {
        assertmsg( "<dev string:x150>" + getxhashsourcename( quest_ref ) + "<dev string:x19c>" );
        return;
    }
    
    quest_act_index = level.ob_quest_achievements[ var_7df69d66d51f7524 ].act_index;
    var_b9870f8832b55167 = player.var_a1bb7e25335e7165.act_index ?? 0;
    
    if ( quest_act_index != var_b9870f8832b55167 )
    {
        return player getplayerdata( level.var_6f9b00680ed002d8, "actComplete", quest_act_index );
    }
    
    return player.ob_quests_complete[ var_7df69d66d51f7524 ];
}

// Namespace ob_quests
// Params 2
// Checksum 0x67385311, Offset: 0xc9c
// Size: 0xab, Type: bool
function function_95e92b616270f44( player, quest_challenge_ref )
{
    quest_challenge_ref = getxhash( quest_challenge_ref );
    quest_challenge_id = level.var_8e8450103b4f5ede[ quest_challenge_ref ];
    
    if ( !quest_challenge_id )
    {
        assertmsg( "<dev string:x19f>" + getxhashsourcename( quest_challenge_ref ) + "<dev string:x19c>" );
        return false;
    }
    
    if ( !isdefined( player.active_ob_quest_progress[ quest_challenge_id ] ) )
    {
        assertmsg( "<dev string:x1dc>" + getxhashsourcename( quest_challenge_ref ) + "<dev string:x19c>" );
        return false;
    }
    
    return player.active_ob_quest_progress[ quest_challenge_id ] >= level.ob_quest_achievements[ quest_challenge_id ].var_b5fc66c6d4a92f4c;
}

// Namespace ob_quests
// Params 1, eflags: 0x4
// Checksum 0xdac549d8, Offset: 0xd50
// Size: 0x112
function private function_3a0d054fd55e24b8( params )
{
    assert( isplayer( self ) );
    player = self;
    quest_challenge_id = params.id;
    
    if ( quest_challenge_id )
    {
        logstring( "[OB_QUESTS] Player " + ( player.name ?? "<" + player.guid + ">" ) + " AE pushback complete " + quest_challenge_id );
        player utility::ent_flag_set( "ae_quest_complete_" + quest_challenge_id );
        
        if ( isdefined( player.active_ob_quest_progress[ quest_challenge_id ] ) )
        {
            player setclientomnvar( "ui_ob_quest_complete", quest_challenge_id );
            player setclientomnvar( "ui_ob_quest_complete_next", 0 );
            player.active_ob_quest_progress[ quest_challenge_id ] = int( level.ob_quest_achievements[ quest_challenge_id ].var_b5fc66c6d4a92f4c );
            utility::callsharedfunc( #"ob_quest", #"hash_ac975ab816f57494", player, level.ob_quest_achievements[ quest_challenge_id ].ref, 0 );
        }
    }
}

// Namespace ob_quests
// Params 3, eflags: 0x4
// Checksum 0x20476adf, Offset: 0xe6a
// Size: 0x4ce
function private function_7d94995331621e0d( player, quest_challenge_ref, increase = 1 )
{
    quest_challenge_ref = getxhash( quest_challenge_ref );
    quest_challenge_id = level.var_8e8450103b4f5ede[ quest_challenge_ref ];
    
    if ( !quest_challenge_id )
    {
        assertmsg( "<dev string:x215>" + getxhashsourcename( quest_challenge_ref ) + "<dev string:x19c>" );
        return;
    }
    
    if ( !isdefined( player.active_ob_quest_progress[ quest_challenge_id ] ) )
    {
        return;
    }
    
    prevvalue = player.active_ob_quest_progress[ quest_challenge_id ];
    player.active_ob_quest_progress[ quest_challenge_id ] += increase;
    
    if ( player.active_ob_quest_progress[ quest_challenge_id ] >= level.ob_quest_achievements[ quest_challenge_id ].var_b5fc66c6d4a92f4c && prevvalue < player.active_ob_quest_progress[ quest_challenge_id ] )
    {
        logstring( "[OB_QUESTS] Player " + ( player.name ?? "<" + player.guid + ">" ) + " progress challenge complete " + quest_challenge_id );
        
        if ( player utility::ent_flag( "active_ob_quest_progress_fetched_initial" ) )
        {
            player setclientomnvar( "ui_ob_quest_complete", quest_challenge_id );
            player setclientomnvar( "ui_ob_quest_complete_next", 0 );
        }
    }
    
    quest_completed = 1;
    
    foreach ( challenge in player.var_a1bb7e25335e7165.challenges )
    {
        if ( player.active_ob_quest_progress[ challenge.id ] < challenge.var_b5fc66c6d4a92f4c )
        {
            quest_completed = 0;
            break;
        }
    }
    
    if ( quest_completed )
    {
        logstring( "[OB_QUESTS] Player ", player.name ?? "<" + player.guid + ">", " completed quest ", player.var_a1bb7e25335e7165.id );
        
        if ( player.var_a1bb7e25335e7165.splash_ref )
        {
            player thread hud_message::showsplash( player.var_a1bb7e25335e7165.splash_ref, undefined, undefined, undefined, 1 );
        }
        
        var_4d0c7ecb1ed568e2 = player.var_a1bb7e25335e7165.challenges;
        
        if ( !isdefined( player.ob_quests_complete ) )
        {
            player.ob_quests_complete = [];
        }
        
        player.ob_quests_complete[ player.var_a1bb7e25335e7165.id ] = 1;
        nextquest = player function_99f7966697c31b41( player.var_a1bb7e25335e7165.id );
        
        if ( !isdefined( nextquest ) )
        {
            logstring( "[OB_QUESTS] Player ", player.name ?? "<" + player.guid + ">", " completed available acts" );
            player thread function_cd8f0b0a0d949296();
            player.var_7cdaffa8a540311b = 1;
            player setclientomnvar( "ui_ob_quest_complete", quest_challenge_id );
            player setclientomnvar( "ui_ob_quest_complete_next", -1 );
            
            if ( player.var_a1bb7e25335e7165 )
            {
                player thread callback::callback( #"hash_f50f3f6010364e5f", { #questid:player.var_a1bb7e25335e7165.id, #quest:player.var_a1bb7e25335e7165 } );
            }
            
            return;
        }
        
        player setclientomnvar( "ui_ob_quest_complete", quest_challenge_id );
        player setclientomnvar( "ui_ob_quest_complete_next", nextquest.id );
        player.var_a1bb7e25335e7165 = nextquest;
        player.active_ob_quest_progress = [];
        
        foreach ( challenge in player.var_a1bb7e25335e7165.challenges )
        {
            player.active_ob_quest_progress[ challenge.id ] = 0;
        }
        
        player thread function_b2b4f660634c8712( player.var_a1bb7e25335e7165.id, 0, var_4d0c7ecb1ed568e2 );
        return;
    }
    
    player thread function_cd8f0b0a0d949296();
}

// Namespace ob_quests
// Params 1, eflags: 0x4
// Checksum 0x44b6cb3c, Offset: 0x1340
// Size: 0x2e7
function private function_99f7966697c31b41( questid )
{
    quest = level.ob_quest_achievements[ questid ];
    assert( isplayer( self ) );
    assert( quest );
    player = self;
    acts = get_acts();
    var_2aea4d53bf553af2 = quest.next.id ?? 0;
    var_d9a3cc2116a65543 = quest.next.act_index ?? -1;
    
    if ( var_d9a3cc2116a65543 > level.var_c4d57d774e5f2d68 )
    {
        var_d9a3cc2116a65543 = -1;
    }
    
    if ( var_d9a3cc2116a65543 != quest.act_index )
    {
        logstring( "[OB_QUESTS] Player ", player.name ?? "<" + player.guid + ">", " completed act ", quest.act_index );
        player setplayerdata( level.var_6f9b00680ed002d8, "actComplete", quest.act_index, 1 );
        player function_432458e83a394206( 4 );
        var_2aea4d53bf553af2 = 0;
        var_d9a3cc2116a65543 = int( max( 0, var_d9a3cc2116a65543 ) );
        var_33ddbb7494c3706e = var_d9a3cc2116a65543;
        
        while ( player getplayerdata( level.var_6f9b00680ed002d8, "actComplete", var_d9a3cc2116a65543 ) )
        {
            logstring( "[OB_QUESTS] Player ", player.name ?? "<" + player.guid + ">", " skipping completed act ", var_d9a3cc2116a65543 );
            
            if ( var_d9a3cc2116a65543 < level.var_c4d57d774e5f2d68 )
            {
                var_d9a3cc2116a65543++;
            }
            else
            {
                var_d9a3cc2116a65543 = 0;
            }
            
            if ( var_d9a3cc2116a65543 == var_33ddbb7494c3706e )
            {
                player setplayerdata( level.var_6f9b00680ed002d8, "activeQuestAct", level.var_c4d57d774e5f2d68 );
                player function_432458e83a394206( 4 );
                var_d9a3cc2116a65543 = -1;
                break;
            }
        }
        
        foreach ( act in acts )
        {
            if ( act.act_index == var_d9a3cc2116a65543 )
            {
                logstring( "[OB_QUESTS] Player ", player.name ?? "<" + player.guid + ">", " resuming act ", var_d9a3cc2116a65543 );
                var_2aea4d53bf553af2 = player getplayerdata( level.var_6f9b00680ed002d8, "activeQuestId", var_d9a3cc2116a65543 );
                
                if ( var_2aea4d53bf553af2 == 0 )
                {
                    var_2aea4d53bf553af2 = act.quests[ 0 ].id;
                }
                
                break;
            }
        }
    }
    
    nextquest = level.ob_quest_achievements[ var_2aea4d53bf553af2 ];
    return nextquest;
}

// Namespace ob_quests
// Params 1, eflags: 0x4
// Checksum 0x1d58c55b, Offset: 0x1630
// Size: 0x3f
function private function_a96ed90a51781e04( params )
{
    if ( self iscodcaster() || isai( self ) )
    {
        return;
    }
    
    if ( self.sessionuimemberindex < 0 )
    {
        return;
    }
    
    /#
        thread debug_player_display();
    #/
    
    thread function_b2b4f660634c8712( undefined );
}

// Namespace ob_quests
// Params 1, eflags: 0xc
// Checksum 0xd813e091, Offset: 0x1677
// Size: 0x199
function private player_ae_completion_wait( var_4d0c7ecb1ed568e2 )
{
    self notify( #"hash_7c9bfebf29da6e12" );
    self endon( #"hash_7c9bfebf29da6e12" );
    assert( isplayer( self ) );
    self endon( #"disconnect" );
    self endon( #"player_ae_completion_wait" );
    var_3bcc78fbcac94025 = "";
    
    foreach ( challenge in var_4d0c7ecb1ed568e2 )
    {
        var_3bcc78fbcac94025 = var_3bcc78fbcac94025 + challenge.id + " ";
    }
    
    logstring( "[OB_QUESTS] " + ( self.name ?? "<player>" ) + " wait AE complete " + var_3bcc78fbcac94025 );
    
    foreach ( challenge in var_4d0c7ecb1ed568e2 )
    {
        utility::ent_flag_wait( "ae_quest_complete_" + challenge.id );
        utility::ent_flag_clear( "ae_quest_complete_" + challenge.id, 1 );
    }
    
    self notify( #"player_ae_completion_wait" );
}

// Namespace ob_quests
// Params 3, eflags: 0xc
// Checksum 0xc6c73443, Offset: 0x1818
// Size: 0x6ff
function private function_b2b4f660634c8712( var_7df69d66d51f7524 = undefined, debugactivated = 0, var_4d0c7ecb1ed568e2 = undefined )
{
    self notify( #"hash_93bb2f3545ec69f0" );
    self endon( #"hash_93bb2f3545ec69f0" );
    assert( isplayer( self ) );
    self endon( #"disconnect" );
    updateactivation = !isdefined( var_7df69d66d51f7524 );
    activationupdated = 0;
    var_7023e45bc277bbc6 = 0;
    
    /#
        var_7023e45bc277bbc6 = function_81908bbb175c5e60();
    #/
    
    onlineae = function_16fc6320b8721acf() || var_7023e45bc277bbc6;
    
    if ( var_4d0c7ecb1ed568e2 )
    {
        if ( function_16fc6320b8721acf() )
        {
            thread player_ae_completion_wait( var_4d0c7ecb1ed568e2 );
            result = utility::waittill_any_timeout( 10, "player_ae_completion_wait" );
            self notify( #"player_ae_completion_wait" );
            
            if ( result && result == "timeout" )
            {
                logstring( "[OB_QUESTS] " + ( self.name ?? "<player>" ) + " wait AE TIMEOUT" );
            }
        }
        else
        {
            wait 1;
        }
    }
    
    quest_act_index = self getplayerdata( level.var_6f9b00680ed002d8, "activeQuestAct" );
    
    if ( var_7df69d66d51f7524 && isdefined( level.ob_quest_achievements[ var_7df69d66d51f7524 ].act_index ) )
    {
        var_21013a4d982d402c = level.ob_quest_achievements[ var_7df69d66d51f7524 ].act_index;
        
        if ( var_21013a4d982d402c != quest_act_index )
        {
            logstring( "[OB_QUESTS] " + ( self.name ?? "<player>" ) + " switched active act from " + quest_act_index + " to " + var_21013a4d982d402c );
            self setplayerdata( level.var_6f9b00680ed002d8, "activeQuestAct", var_21013a4d982d402c );
            quest_act_index = self getplayerdata( level.var_6f9b00680ed002d8, "activeQuestAct" );
            updateactivation = 1;
        }
    }
    
    if ( !var_7df69d66d51f7524 )
    {
        var_7df69d66d51f7524 = self getplayerdata( level.var_6f9b00680ed002d8, "activeQuestId", quest_act_index );
        logstring( "[OB_QUESTS] " + ( self.name ?? "<player>" ) + " connected with active quest " + var_7df69d66d51f7524 );
        var_7df69d66d51f7524 = getdvarint( @"hash_a0abc52b28d7ceb6", var_7df69d66d51f7524 );
        
        if ( var_7df69d66d51f7524 == 0 )
        {
            var_7df69d66d51f7524 = getdvarint( @"hash_8d5fce1bf41dd15f", 67152 );
        }
    }
    
    var_43943766151a09b3 = self getplayerdata( level.var_6f9b00680ed002d8, "actIntroVoPlayed", quest_act_index );
    
    if ( !var_43943766151a09b3 )
    {
        thread function_221f229b0d1df1e( quest_act_index );
        self setplayerdata( level.var_6f9b00680ed002d8, "actIntroVoPlayed", quest_act_index, 1 );
    }
    
    active_quest_id = var_7df69d66d51f7524;
    cur_quest_id = self getplayerdata( level.var_6f9b00680ed002d8, "activeQuestId", quest_act_index );
    self setplayerdata( level.var_6f9b00680ed002d8, "activeQuestId", quest_act_index, active_quest_id );
    self setplayerdata( level.var_6f9b00680ed002d8, "squadPMCMissionGroups", self.sessionuimemberindex, "missions", 0, "challengeID", active_quest_id );
    
    if ( cur_quest_id != active_quest_id || debugactivated )
    {
        logstring( "[OB_QUESTS] " + ( self.name ?? "<player>" ) + " switched active quest from " + cur_quest_id + " to " + active_quest_id );
        self function_432458e83a394206( 4 );
        
        if ( onlineae && ( debugactivated || var_7023e45bc277bbc6 ) )
        {
            function_52d6a5c1fa775669( active_quest_id, cur_quest_id ? cur_quest_id : self.var_a1bb7e25335e7165.id ?? 0 );
            activationupdated = 1;
        }
    }
    
    if ( onlineae && updateactivation && !activationupdated )
    {
        function_52d6a5c1fa775669( active_quest_id );
        activationupdated = 1;
    }
    
    if ( self.var_a1bb7e25335e7165 && active_quest_id && self.var_a1bb7e25335e7165.id != active_quest_id )
    {
        thread callback::callback( #"hash_f50f3f6010364e5f", { #questid:self.var_a1bb7e25335e7165.id, #quest:self.var_a1bb7e25335e7165 } );
    }
    
    self.var_a1bb7e25335e7165 = level.ob_quest_achievements[ active_quest_id ];
    
    if ( !self.var_a1bb7e25335e7165 )
    {
        if ( active_quest_id != 0 )
        {
            logstring( "[OB_QUESTS] " + ( self.name ?? "<player>" ) + " invalid quest ID:" + active_quest_id );
            
            /#
                iprintlnbold( "<dev string:x25b>" + ( self.name ?? "<dev string:x268>" ) + "<dev string:x271>" + active_quest_id );
            #/
        }
        
        return;
    }
    
    logstring( "[OB_QUESTS] Player ", self.name ?? "<player>", " started quest ", self.var_a1bb7e25335e7165.id );
    self.ob_quests_complete = [];
    act = level.ob_quest_achievements[ self.var_a1bb7e25335e7165.act_id ];
    
    for ( var_9c3b47fc1d714f47 = 0; var_9c3b47fc1d714f47 < act.quests.size ; var_9c3b47fc1d714f47++ )
    {
        quest = act.quests[ var_9c3b47fc1d714f47 ];
        
        if ( quest.id == active_quest_id )
        {
            break;
        }
        
        self.ob_quests_complete[ quest.id ] = 1;
    }
    
    self.active_ob_quest_progress = [];
    
    foreach ( challenge in self.var_a1bb7e25335e7165.challenges )
    {
        self.active_ob_quest_progress[ challenge.id ] = 0;
    }
    
    var_538c0694c880e740 = utility::callsharedfunc( #"squad_utility", #"getsquadmembers" );
    
    if ( var_538c0694c880e740.size == 0 )
    {
        var_538c0694c880e740[ 0 ] = self;
    }
    
    foreach ( sync_player in var_538c0694c880e740 )
    {
        for ( challenge_idx = 0; challenge_idx < 8 ; challenge_idx++ )
        {
            sync_player setplayerdata( level.var_6f9b00680ed002d8, "squadPMCMissionGroups", self.sessionuimemberindex, "missions", 0, "challengeProgress", challenge_idx, 0 );
        }
    }
    
    thread callback::callback( #"ob_quest_start", { #questid:active_quest_id, #quest:self.var_a1bb7e25335e7165 } );
    function_a93373a710abb4fe( 1, 1, 1 );
}

// Namespace ob_quests
// Params 1, eflags: 0x4
// Checksum 0xea931b80, Offset: 0x1f1f
// Size: 0x4e
function private function_221f229b0d1df1e( actindex )
{
    self endon( #"disconnect" );
    utility::ent_flag_wait( "ob_infil_boots_on_ground" );
    wait 10;
    var_2d96658ceae70e42 = actindex + 1;
    level overlord::playconversation( "vo_wlin_intro_act" + var_2d96658ceae70e42, [ self ] );
}

// Namespace ob_quests
// Params 0, eflags: 0x4
// Checksum 0x486ed120, Offset: 0x1f75
// Size: 0x1a, Type: bool
function private function_16fc6320b8721acf()
{
    if ( isdedicatedserver() && level.onlinegame )
    {
        return true;
    }
    
    return false;
}

// Namespace ob_quests
// Params 3, eflags: 0x4
// Checksum 0xb033b851, Offset: 0x1f98
// Size: 0x20e
function private function_a93373a710abb4fe( force = 0, synclocal = 1, pushprogress = 0 )
{
    assert( isplayer( self ) );
    self endon( #"disconnect" );
    
    if ( function_16fc6320b8721acf() )
    {
        if ( force || ( self.var_2bd608a223f1eb17 ?? 0 ) == 0 || gettime() - self.var_2bd608a223f1eb17 >= 60000 )
        {
            if ( !isdefined( self.active_ob_quest_progress_fetched ) )
            {
                self.active_ob_quest_progress_fetched = [];
            }
            
            self.var_2bd608a223f1eb17 = gettime();
            utility::ent_flag_clear( "active_ob_quest_progress_fetched" );
            
            foreach ( challenge in self.var_a1bb7e25335e7165.challenges )
            {
                self function_fdf029c4be6546a3( challenge.id );
                
                if ( !isdefined( self.active_ob_quest_progress_fetched[ challenge.id ] ) )
                {
                    self.active_ob_quest_progress_fetched[ challenge.id ] = {};
                }
                
                self.active_ob_quest_progress_fetched[ challenge.id ].pending = 1;
                
                if ( synclocal )
                {
                    self.active_ob_quest_progress_fetched[ challenge.id ].synclocal = 1;
                }
                
                if ( pushprogress )
                {
                    self.active_ob_quest_progress_fetched[ challenge.id ].pushprogress = 1;
                }
            }
            
            utility::ent_flag_wait( "active_ob_quest_progress_fetched" );
        }
    }
    else
    {
        utility::ent_flag_set( "active_ob_quest_progress_fetched" );
    }
    
    utility::ent_flag_set( "active_ob_quest_progress_fetched_initial" );
    thread function_cd8f0b0a0d949296();
}

// Namespace ob_quests
// Params 1, eflags: 0x4
// Checksum 0x26017c88, Offset: 0x21ae
// Size: 0x353
function private function_35c8829a652c7bee( params )
{
    if ( isdefined( self.active_ob_quest_progress[ params.achievementid ] ) )
    {
        target_progress_id = playerachievements::function_a550b9c75bcbee5e( "progress" );
        
        foreach ( progress_value in params.progressdata.progress_values )
        {
            if ( progress_value.progress_id == target_progress_id )
            {
                if ( self.active_ob_quest_progress_fetched[ params.achievementid ].pending )
                {
                    /#
                        self.active_ob_quest_progress_fetched[ params.achievementid ].var_b8739f85c673c81b = progress_value.progress;
                    #/
                    
                    if ( self.active_ob_quest_progress_fetched[ params.achievementid ].synclocal )
                    {
                        self.active_ob_quest_progress[ params.achievementid ] = progress_value.progress;
                        target = int( level.ob_quest_achievements[ params.achievementid ].var_b5fc66c6d4a92f4c ?? 0 );
                        
                        if ( target && progress_value.progress && int( progress_value.progress ) >= target )
                        {
                            utility::ent_flag_set( "ae_quest_complete_" + params.achievementid );
                        }
                        
                        self.active_ob_quest_progress_fetched[ params.achievementid ].synclocal = undefined;
                    }
                    
                    if ( self.active_ob_quest_progress_fetched[ params.achievementid ].pushprogress )
                    {
                        utility::callsharedfunc( #"ob_quest", #"hash_ac975ab816f57494", self, level.ob_quest_achievements[ params.achievementid ].ref, 0 );
                        self.active_ob_quest_progress_fetched[ params.achievementid ].pushprogress = undefined;
                    }
                    
                    self.active_ob_quest_progress_fetched[ params.achievementid ].pending = undefined;
                }
            }
        }
    }
    
    complete = 1;
    
    foreach ( var_e17aae2fee0bbda6 in self.active_ob_quest_progress_fetched )
    {
        if ( var_e17aae2fee0bbda6.pending )
        {
            complete = 0;
            break;
        }
    }
    
    if ( complete )
    {
        utility::ent_flag_set( "active_ob_quest_progress_fetched" );
        
        /#
            var_2c712ed15e30744d = self.active_ob_quest_progress_fetched;
        #/
        
        self.active_ob_quest_progress_fetched = undefined;
        
        /#
            self.active_ob_quest_progress_fetched = var_2c712ed15e30744d;
        #/
    }
}

// Namespace ob_quests
// Params 1, eflags: 0x4
// Checksum 0xb4efeaa0, Offset: 0x2509
// Size: 0x35e
function private function_cd8f0b0a0d949296( selfonly = 1 )
{
    assert( isplayer( self ) );
    var_538c0694c880e740 = utility::callsharedfunc( #"squad_utility", #"getsquadmembers" );
    
    if ( var_538c0694c880e740.size == 0 )
    {
        var_538c0694c880e740[ 0 ] = self;
    }
    
    foreach ( sync_player in var_538c0694c880e740 )
    {
        if ( !sync_player isconnected() )
        {
            continue;
        }
        
        if ( selfonly && sync_player != self )
        {
            continue;
        }
        
        dirty = 0;
        
        foreach ( member in var_538c0694c880e740 )
        {
            if ( member.sessionuimemberindex < 0 )
            {
                return;
            }
            
            if ( !member.var_a1bb7e25335e7165 )
            {
                continue;
            }
            
            entnum = member getentitynumber();
            questid = member.var_a1bb7e25335e7165.id;
            
            if ( sync_player getplayerdata( level.var_6f9b00680ed002d8, "squadPMCMissionGroups", member.sessionuimemberindex, "clientNum" ) != entnum )
            {
                dirty = 1;
                sync_player setplayerdata( level.var_6f9b00680ed002d8, "squadPMCMissionGroups", member.sessionuimemberindex, "clientNum", entnum );
            }
            
            if ( sync_player getplayerdata( level.var_6f9b00680ed002d8, "squadPMCMissionGroups", member.sessionuimemberindex, "missions", 0, "challengeID" ) != questid )
            {
                dirty = 1;
                sync_player setplayerdata( level.var_6f9b00680ed002d8, "squadPMCMissionGroups", member.sessionuimemberindex, "missions", 0, "challengeID", questid );
            }
            
            foreach ( var_36535aba8d3128e4, challenge in member.var_a1bb7e25335e7165.challenges )
            {
                progress = member.active_ob_quest_progress[ challenge.id ];
                
                if ( sync_player getplayerdata( level.var_6f9b00680ed002d8, "squadPMCMissionGroups", member.sessionuimemberindex, "missions", 0, "challengeProgress", var_36535aba8d3128e4 ) != progress )
                {
                    dirty = 1;
                    sync_player setplayerdata( level.var_6f9b00680ed002d8, "squadPMCMissionGroups", member.sessionuimemberindex, "missions", 0, "challengeProgress", var_36535aba8d3128e4, progress );
                }
            }
        }
        
        if ( dirty )
        {
            sync_player function_432458e83a394206( 4 );
        }
    }
}

// Namespace ob_quests
// Params 1, eflags: 0xc
// Checksum 0xcbfbe21a, Offset: 0x286f
// Size: 0x138
function private function_1da22972ba25bc1f( param )
{
    self notify( #"hash_3d4eb6de2a51e35f" );
    self endon( #"hash_3d4eb6de2a51e35f" );
    self endon( #"disconnect" );
    var_538c0694c880e740 = utility::callsharedfunc( #"squad_utility", #"getsquadmembers" );
    
    foreach ( member in var_538c0694c880e740 )
    {
        member thread function_a93373a710abb4fe();
    }
    
    foreach ( member in var_538c0694c880e740 )
    {
        member utility::ent_flag_wait( "active_ob_quest_progress_fetched" );
    }
    
    thread function_cd8f0b0a0d949296();
}

// Namespace ob_quests
// Params 1, eflags: 0x4
// Checksum 0xd4ec5c16, Offset: 0x29af
// Size: 0xde
function private debug_set_quest( params )
{
    players = [];
    
    if ( self == level )
    {
        players = level.players;
    }
    else if ( isplayer( self ) )
    {
        players = [ self ];
    }
    
    foreach ( player in players )
    {
        iprintlnbold( "[OB_QUESTS] Debug: Forcing quest ID " + params[ 0 ] + " for player " + ( player.name ?? "<player>" ) );
        player thread function_b2b4f660634c8712( int( params[ 0 ] ), 1 );
    }
}

// Namespace ob_quests
// Params 0, eflags: 0x4
// Checksum 0x5195a3a1, Offset: 0x2a95
// Size: 0xf, Type: bool
function private get_acts()
{
    return level.var_44a7bb8d4ccc1ade ?? [];
}

// Namespace ob_quests
// Params 2, eflags: 0x4
// Checksum 0x506c775b, Offset: 0x2aad
// Size: 0x176
function private get_act_challenges( var_a6dd379410a724e8, var_da0ef21a9707348f )
{
    challenges = [];
    
    if ( !isarray( var_da0ef21a9707348f ) )
    {
        var_da0ef21a9707348f = [ var_da0ef21a9707348f ];
    }
    
    if ( level.ob_quest_achievements[ var_a6dd379410a724e8 ].quests )
    {
        foreach ( quest in level.ob_quest_achievements[ var_a6dd379410a724e8 ].quests )
        {
            if ( quest.id && arraycontains( var_da0ef21a9707348f, quest.id ) )
            {
                continue;
            }
            
            foreach ( challenge in quest.challenges )
            {
                challenges[ challenges.size ] = int( challenge.id );
            }
        }
    }
    
    return challenges;
}

// Namespace ob_quests
// Params 2, eflags: 0xc
// Checksum 0x3d0c8d90, Offset: 0x2c2c
// Size: 0x251
function private function_52d6a5c1fa775669( var_df4780164b035ff3, var_36ca03c2f20c1b56 )
{
    self notify( #"hash_f862fd210caa0e69" );
    self endon( #"hash_f862fd210caa0e69" );
    assert( isplayer( self ) );
    player = self;
    activate = [];
    deactivate = [];
    
    if ( var_36ca03c2f20c1b56 )
    {
        acts = get_acts();
        
        foreach ( id, act in acts )
        {
            foreach ( quest in act.quests )
            {
                if ( quest.id == var_36ca03c2f20c1b56 )
                {
                    deactivate = get_act_challenges( id, var_df4780164b035ff3 );
                    break;
                }
            }
            
            if ( deactivate.size > 0 )
            {
                break;
            }
        }
    }
    
    if ( var_df4780164b035ff3 )
    {
        newquest = level.ob_quest_achievements[ var_df4780164b035ff3 ];
        
        if ( newquest )
        {
            foreach ( challenge in newquest.challenges )
            {
                activate[ activate.size ] = int( challenge.id );
            }
        }
    }
    
    assert( activate.size <= 50, "<dev string:x284>" );
    assert( deactivate.size <= 50, "<dev string:x2e5>" );
    player function_bde34fdb433f6ece( undefined, deactivate );
    player function_bde34fdb433f6ece( activate, undefined );
}

/#

    // Namespace ob_quests
    // Params 0, eflags: 0xc
    // Checksum 0x822faabf, Offset: 0x2e85
    // Size: 0x4f8, Type: dev
    function private debug_player_display()
    {
        self notify( #"hash_8167495a7aa6c118" );
        self endon( #"hash_8167495a7aa6c118" );
        assert( isplayer( self ) );
        player = self;
        player endon( #"disconnect" );
        lastfetch = gettime();
        
        while ( true )
        {
            wait 1;
            
            if ( getdvarint( @"scr_ob_quests_debug", 0 ) == 0 )
            {
                if ( player.var_21809754521d8530 )
                {
                    player.var_21809754521d8530 destroy();
                    player.var_21809754521d8530 = undefined;
                }
                
                continue;
            }
            
            if ( !player.var_21809754521d8530 )
            {
                hudelem = newclienthudelem( player );
                hudelem.alignx = "<dev string:x348>";
                hudelem.aligny = "<dev string:x34d>";
                hudelem.x = 50;
                hudelem.y = 50;
                hudelem.foreground = 1;
                hudelem.color = ( 1, 1, 1 );
                hudelem.fontscale = 1.25;
                hudelem.scramblerdisabled = 1;
                player.var_21809754521d8530 = hudelem;
            }
            
            msg = "<dev string:x351>";
            var_538c0694c880e740 = player utility::callsharedfunc( #"squad_utility", #"getsquadmembers" );
            
            foreach ( member in var_538c0694c880e740 )
            {
                if ( member.sessionuimemberindex < 0 )
                {
                    continue;
                }
                
                locationname = ob_challenges::function_5879d8d77ddcbe6e( member.origin ) ?? "<dev string:x35e>";
                questid = player getplayerdata( level.var_6f9b00680ed002d8, "<dev string:x35f>", member.sessionuimemberindex, "<dev string:x375>", 0, "<dev string:x37e>" );
                
                if ( questid )
                {
                    questname = getxhashsourcename( level.ob_quest_achievements[ questid ].ref );
                    msg += "<dev string:x38a>" + questname + "<dev string:x38d>" + member.name + "<dev string:x392>" + locationname + "<dev string:x397>";
                }
                else
                {
                    msg += "<dev string:x399>" + member.name + "<dev string:x392>" + locationname + "<dev string:x397>";
                }
                
                foreach ( var_36535aba8d3128e4, challenge in member.var_a1bb7e25335e7165.challenges )
                {
                    if ( !challenge.id )
                    {
                        continue;
                    }
                    
                    if ( member != player && getdvarint( @"scr_ob_quests_debug", 0 ) < 2 )
                    {
                        continue;
                    }
                    
                    challengename = getxhashsourcename( level.ob_quest_achievements[ challenge.id ].ref );
                    progress = player getplayerdata( level.var_6f9b00680ed002d8, "<dev string:x35f>", member.sessionuimemberindex, "<dev string:x375>", 0, "<dev string:x3b1>", var_36535aba8d3128e4 );
                    aeprogress = player.active_ob_quest_progress_fetched[ challenge.id ].var_b8739f85c673c81b;
                    target = int( level.ob_quest_achievements[ challenge.id ].var_b5fc66c6d4a92f4c );
                    completestatus = progress >= target ? "<dev string:x3c3>" : "<dev string:x3c7>";
                    msg += "<dev string:x3cc>" + completestatus + "<dev string:x3d1>" + progress + "<dev string:x3d5>" + target + "<dev string:x3d7>";
                    
                    if ( isdefined( aeprogress ) )
                    {
                        msg += "<dev string:x3db>" + aeprogress + "<dev string:x3d5>" + target + "<dev string:x3d7>";
                    }
                    
                    msg += challengename + "<dev string:x397>";
                }
            }
            
            msg = getsubstr( msg, 0, 1023 );
            player.var_21809754521d8530 setdevtext( msg );
            
            if ( lastfetch + 5000 <= gettime() && !player.var_7cdaffa8a540311b )
            {
                lastfetch = gettime();
                player thread function_a93373a710abb4fe( 1, 1, 1 );
            }
        }
    }

    // Namespace ob_quests
    // Params 0, eflags: 0x4
    // Checksum 0x6e738641, Offset: 0x3385
    // Size: 0x20d, Type: dev
    function private function_fa6ff7b4bee6ad06()
    {
        level waittill( #"player_spawned" );
        autoadd = getdvarint( @"scr_ob_quests_devgui", 0 ) != 0;
        dolog = getdvarint( @"hash_2bf6d08872eac6ce", 0 ) != 0;
        
        if ( !autoadd && !dolog )
        {
            return;
        }
        
        acts = get_acts();
        actindex = 0;
        var_fb1b17cf70885602 = 0;
        
        if ( dolog )
        {
            logstring( "<dev string:x3e0>" );
        }
        
        foreach ( act in acts )
        {
            actindex++;
            questindex = 0;
            
            foreach ( quest in act.quests )
            {
                questindex++;
                queststr = questindex < 10 ? "<dev string:x3fa>" + questindex : "<dev string:x35e>" + questindex;
                
                if ( autoadd )
                {
                    devgui::add_devgui_command( "<dev string:x3fc>" + actindex + "<dev string:x40a>" + queststr, "<dev string:x412>" + quest.id, var_fb1b17cf70885602 );
                }
                
                if ( dolog )
                {
                    logstring( "<dev string:x436>" + actindex + "<dev string:x40a>" + queststr + "<dev string:x450>" + quest.id + "<dev string:x477>" );
                }
                
                var_fb1b17cf70885602++;
            }
        }
        
        if ( dolog )
        {
            logstring( "<dev string:x47d>" );
        }
    }

    // Namespace ob_quests
    // Params 0, eflags: 0x4
    // Checksum 0xb3dd82a6, Offset: 0x359a
    // Size: 0x2d, Type: dev
    function private function_81908bbb175c5e60()
    {
        if ( getdvarint( @"force_ranking", 0 ) && getdvarint( @"force_challenges", 0 ) )
        {
            return 1;
        }
        
        return 0;
    }

#/
