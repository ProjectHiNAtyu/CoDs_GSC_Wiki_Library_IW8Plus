// scripts\mp\emote.gsc  (hash_5cc5299a9510992c.gscc) (size: 6824 Bytes / 0x1aa8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4dc7e42 (81559106)
// size ...... 6824 (0x1aa8)
// includes .. 5   (offset: 0x1958)
// strings ... 12  (offset: 0x1980)
// dev strs .. 12  (offset: 0x1a18)
// exports ... 22  (offset: 0xef8)
// cseg ...... 0x145 + 0xdb3 (0xef8)
// imports ... 59  (offset: 0x1268)
// animtree1 . 0   (offset: 0x1aa8)
// animtree2 . 0   (offset: 0x1aa8)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\values;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\lui_game_event_aggregator;

#namespace emote;

// Namespace emote
// Params 0, eflags: 0x4
// Checksum 0x40cfa7e4, Offset: 0x163
// Size: 0x8b
function private function_b4ed2fe24e3ab836()
{
    if ( !isdefined( level.enableemotes ) )
    {
        gametypeenabled = isdefined( level.gametypebundle ) && level.gametypebundle.enableemotes;
        dvarenabled = getdvarint( @"emote_enabled", 0 );
        var_859c71bff84e3e41 = level.var_2365b8b3e3338fa1.size > 0;
        level.enableemotes = gametypeenabled && dvarenabled && var_859c71bff84e3e41;
    }
    
    return level.enableemotes;
}

// Namespace emote
// Params 0
// Checksum 0x777af634, Offset: 0x1f7
// Size: 0x24, Type: bool
function function_f881ff5e4bf78f33()
{
    if ( isbot( self ) )
    {
        return false;
    }
    
    if ( istestclient( self ) )
    {
        return false;
    }
    
    if ( !function_b4ed2fe24e3ab836() )
    {
        return false;
    }
    
    return true;
}

/#

    // Namespace emote
    // Params 0
    // Checksum 0xba621b4, Offset: 0x224
    // Size: 0x6c, Type: dev
    function function_192b5b9454e6e45d()
    {
        emotecount = level.var_2365b8b3e3338fa1.size;
        randomemotes = [];
        
        for ( i = 0; i < 5 && i < 50 ; i++ )
        {
            randomnum = randomint( emotecount );
            
            if ( !arraycontains( randomemotes, randomnum ) )
            {
                randomemotes[ i ] = randomnum;
            }
        }
        
        return randomemotes;
    }

    // Namespace emote
    // Params 0
    // Checksum 0x65543254, Offset: 0x298
    // Size: 0x110, Type: dev
    function function_e2ecf094f8c263c8()
    {
        if ( getdvarint( @"hash_5a9af98eef0e266c", 0 ) == 0 )
        {
            return 0;
        }
        
        self function_205a64f1accda4f7();
        randomemotes = function_192b5b9454e6e45d();
        emotereflist = [];
        count = 0;
        
        foreach ( key, value in level.var_2365b8b3e3338fa1 )
        {
            if ( arraycontains( randomemotes, count ) )
            {
                emotereflist[ emotereflist.size ] = level.var_2365b8b3e3338fa1[ key ];
            }
            
            count++;
        }
        
        self.var_3418ca1423e0fc6d = emotereflist;
        
        for ( i = 0; i < emotereflist.size ; i++ )
        {
            self giveloadoutemote( emotereflist[ i ].emote );
        }
        
        return 1;
    }

    // Namespace emote
    // Params 0
    // Checksum 0xe38e8328, Offset: 0x3b0
    // Size: 0x123, Type: dev
    function function_3abfe2dea26d0fc5()
    {
        if ( getdvarint( @"hash_19c43a6af325f2a9", 0 ) == 0 )
        {
            return 0;
        }
        
        self function_205a64f1accda4f7();
        
        if ( !isdefined( level.sameemotes ) )
        {
            level.sameemotes = function_192b5b9454e6e45d();
        }
        
        emotereflist = [];
        count = 0;
        
        foreach ( key, value in level.var_2365b8b3e3338fa1 )
        {
            if ( arraycontains( level.sameemotes, count ) )
            {
                emotereflist[ emotereflist.size ] = level.var_2365b8b3e3338fa1[ key ];
            }
            
            count++;
        }
        
        self.var_3418ca1423e0fc6d = emotereflist;
        
        for ( i = 0; i < emotereflist.size ; i++ )
        {
            self giveloadoutemote( emotereflist[ i ].emote );
        }
        
        return 1;
    }

    // Namespace emote
    // Params 0
    // Checksum 0x9debf128, Offset: 0x4db
    // Size: 0x23, Type: dev
    function function_8352e283a18190a1()
    {
        if ( getdvarint( @"hash_3167ff41b7e15145", 0 ) == 0 )
        {
            return 0;
        }
        
        self function_205a64f1accda4f7();
        return 1;
    }

    // Namespace emote
    // Params 0
    // Checksum 0xd9025fd3, Offset: 0x506
    // Size: 0x5b, Type: dev
    function dev_give_loadout()
    {
        if ( !function_b4ed2fe24e3ab836() )
        {
            return 0;
        }
        
        if ( getdvarint( @"hash_ff07a78ec4f2b7f9", -1 ) == self getentitynumber() )
        {
            return 1;
        }
        else if ( function_8352e283a18190a1() )
        {
            return 1;
        }
        else if ( function_3abfe2dea26d0fc5() )
        {
            return 1;
        }
        else if ( function_e2ecf094f8c263c8() )
        {
            return 1;
        }
        
        return 0;
    }

#/

// Namespace emote
// Params 1
// Checksum 0xcf0a43d, Offset: 0x569
// Size: 0x8a
function giveemotes( emotereflist )
{
    /#
        if ( dev_give_loadout() )
        {
            return;
        }
    #/
    
    if ( !function_f881ff5e4bf78f33() )
    {
        return;
    }
    
    self function_205a64f1accda4f7();
    assert( emotereflist.size == 5, "<dev string:x24>" + emotereflist.size + "<dev string:x4c>" + 5 + "<dev string:x59>" );
    self.var_3418ca1423e0fc6d = emotereflist;
    
    for ( i = 0; i < emotereflist.size ; i++ )
    {
        self giveloadoutemote( emotereflist[ i ].emote );
    }
}

// Namespace emote
// Params 0
// Checksum 0xd30fec53, Offset: 0x5fb
// Size: 0x10e
function create_customization()
{
    if ( !function_f881ff5e4bf78f33() )
    {
        return;
    }
    
    emoteloadout = [];
    
    for ( i = 0; i < 5 ; i++ )
    {
        emotelootid = 0;
        
        if ( !isagent( self ) )
        {
            if ( level.gamemodebundle.var_38512d10cd15416d )
            {
                emotelootid = self getplayerdata( level.loadoutsgroup, "customizations", "emotes", i );
            }
            else
            {
                emotelootid = self getplayerdata( level.loadoutsgroup, "customizationSetup", "emoteCustomization", "emotes", i );
            }
        }
        
        emoteref = "defaultemote";
        
        if ( isdefined( emotelootid ) && emotelootid != 0 )
        {
            var_b3d4cf0a44bdf443 = loot::function_f54ecb89dfab8e8c( emotelootid );
            
            if ( isdefined( level.var_ef0ca6f8b69428d5[ var_b3d4cf0a44bdf443 ] ) )
            {
                emoteref = level.var_ef0ca6f8b69428d5[ var_b3d4cf0a44bdf443 ];
            }
        }
        
        emote = level.var_2365b8b3e3338fa1[ emoteref ];
        
        if ( isdefined( emote ) )
        {
            emoteloadout[ i ] = emote;
        }
    }
    
    return emoteloadout;
}

// Namespace emote
// Params 0
// Checksum 0x985fd0b7, Offset: 0x712
// Size: 0x31
function function_9ad8e0320f92c37a()
{
    inwinnerscircle = self getclientomnvar( "post_game_state" ) == 6;
    
    if ( !inwinnerscircle )
    {
        return ( self getclientomnvar( "ui_open_menu_from_script" ) == 5 );
    }
    
    return inwinnerscircle;
}

// Namespace emote
// Params 2
// Checksum 0xba2b6767, Offset: 0x74c
// Size: 0x1f
function emote_monitor( notification, slotindex )
{
    thread emote_monitor_threaded( notification, slotindex );
}

// Namespace emote
// Params 2, eflags: 0x4
// Checksum 0x76ba4bc4, Offset: 0x773
// Size: 0xeb
function private emote_monitor_threaded( notification, slotindex )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( notification == "try_emote3p" )
    {
        if ( !val::get( "allow_emote" ) || self isonascender() || self function_41360f0bcfc012aa() )
        {
            return;
        }
        
        emote = undefined;
        
        if ( slotindex != 99 )
        {
            emote = function_d97161a916a220af( slotindex );
            
            if ( !isdefined( emote ) )
            {
                return;
            }
            
            self playemote( emote );
            callback::callback( #"hash_61bdb5dfdbcf747f" );
        }
        
        wait 1;
        allowemote = 1;
        
        while ( self isemoteactive() || self function_985124b0e1e74f2e() )
        {
            if ( allowemote )
            {
                allowemote = 0;
                self setclientomnvar( "can_emote", 0 );
            }
            
            waitframe();
        }
        
        if ( !function_9ad8e0320f92c37a() )
        {
            self setclientomnvar( "can_emote", 1 );
        }
    }
}

// Namespace emote
// Params 1
// Checksum 0xb8650f92, Offset: 0x866
// Size: 0x40
function function_d97161a916a220af( slotindex )
{
    assert( slotindex < 5, "<dev string:x63>" + slotindex + "<dev string:x83>" + 5 );
    return self.var_3418ca1423e0fc6d[ slotindex ].emote;
}

// Namespace emote
// Params 1
// Checksum 0x8b29e9f5, Offset: 0x8af
// Size: 0x18
function function_29633c8e381fcedc( emoteref )
{
    return level.var_2365b8b3e3338fa1[ emoteref ];
}

// Namespace emote
// Params 0
// Checksum 0xbcf64db2, Offset: 0x8d0
// Size: 0x20
function emote_init()
{
    level lui_game_event_aggregator::registeronluieventcallback( &emote_monitor );
    
    /#
        thread function_9d432ce233175405();
    #/
    
    function_8cdb7620217d8a50();
}

// Namespace emote
// Params 0
// Checksum 0x14c32907, Offset: 0x8f8
// Size: 0x206
function function_8cdb7620217d8a50()
{
    /#
        if ( getdvarint( @"hash_e6afce2cf5cf7515", 0 ) == 1 )
        {
            return;
        }
        
        if ( getdvarint( @"hash_742caa13b3c2e685" ) == 1 )
        {
            return;
        }
    #/
    
    if ( isdefined( level.var_34ac945848b5f9da ) )
    {
        return;
    }
    
    level.var_2365b8b3e3338fa1 = [];
    level.var_34ac945848b5f9da = [];
    level.var_cc9cc8c2c246b01d = [];
    level.var_ef0ca6f8b69428d5 = [];
    gamemodebundle = level.gamemodebundle;
    
    if ( !isdefined( gamemodebundle.emote_list ) )
    {
        return;
    }
    
    var_897a73128ee1f2ee = getscriptbundle( gamemodebundle.emote_list );
    
    /#
        if ( !isdefined( var_897a73128ee1f2ee ) )
        {
            println( "<dev string:xa4>" + gamemodebundle.emote_list );
            return;
        }
    #/
    
    emotelist = var_897a73128ee1f2ee.var_414c5ef2f3fb4926;
    
    for ( i = 0; i < emotelist.size ; i++ )
    {
        if ( !isdefined( emotelist[ i ].emotebundle ) )
        {
            continue;
        }
        
        emotebundle = getscriptbundlefieldvalues( emotelist[ i ].emotebundle, [ #"emote", #"lootid", #"emoteanims", #"isinspect" ] );
        
        if ( !isdefined( emotebundle.emote ) )
        {
            continue;
        }
        
        emoteref = emotebundle.emote;
        lootidref = loot::function_f54ecb89dfab8e8c( emotebundle.lootid );
        level.var_2365b8b3e3338fa1[ emoteref ] = emotebundle;
        level.var_34ac945848b5f9da[ i ] = emoteref;
        level.var_cc9cc8c2c246b01d[ emoteref ] = i;
        
        if ( isdefined( lootidref ) )
        {
            level.var_ef0ca6f8b69428d5[ lootidref ] = emoteref;
        }
        
        /#
            devgui::add_devgui_command( "<dev string:xcd>" + getxhashsourcename( emotebundle.emote ), "<dev string:xe0>" + i, i + 2 );
        #/
    }
}

// Namespace emote
// Params 1
// Checksum 0x81456a8f, Offset: 0xb06
// Size: 0xd2, Type: bool
function function_8aae11cc20c2103f( emoteindex )
{
    emoteref = function_6cbf78a9ccc07ff3( emoteindex );
    emotebundle = function_29633c8e381fcedc( emoteref );
    
    if ( !isdefined( emotebundle.emoteanims ) )
    {
        return false;
    }
    
    foreach ( var_28527e593c2cef13 in emotebundle.emoteanims )
    {
        if ( !isdefined( var_28527e593c2cef13.emoteanim ) )
        {
            return false;
        }
    }
    
    return !emotebundle.isinspect;
}

// Namespace emote
// Params 3
// Checksum 0xe6f05573, Offset: 0xbe1
// Size: 0x164
function function_e517ecb74bbd6b77( players, playerindex, emoteindex )
{
    if ( !function_8aae11cc20c2103f( emoteindex ) )
    {
        assertmsg( "<dev string:xfa>" + emoteindex + "<dev string:x11d>" );
        return;
    }
    
    if ( isbrgamemode() )
    {
        animomnvar = "ui_br_winners_circle_emote_" + playerindex;
    }
    else
    {
        animomnvar = "ui_winners_circle_emote_" + playerindex;
    }
    
    foreach ( player in players )
    {
        player setclientomnvar( animomnvar, -1 );
    }
    
    wait 0.1;
    
    foreach ( player in players )
    {
        if ( isdefined( player ) )
        {
            player setclientomnvar( animomnvar, emoteindex );
            
            /#
                player givedebugemote( level.var_34ac945848b5f9da[ emoteindex ] );
            #/
        }
    }
}

// Namespace emote
// Params 1
// Checksum 0x537ea05e, Offset: 0xd4d
// Size: 0x40
function function_6cbf78a9ccc07ff3( emoteid )
{
    function_8cdb7620217d8a50();
    
    if ( isdefined( level.var_34ac945848b5f9da[ emoteid ] ) )
    {
        return level.var_34ac945848b5f9da[ emoteid ];
    }
    
    println( "<dev string:x152>" + emoteid );
}

// Namespace emote
// Params 1
// Checksum 0xe3e41e8c, Offset: 0xd96
// Size: 0x40
function function_205b1d52b38d3b0e( emoteref )
{
    function_8cdb7620217d8a50();
    
    if ( isdefined( level.var_cc9cc8c2c246b01d[ emoteref ] ) )
    {
        return level.var_cc9cc8c2c246b01d[ emoteref ];
    }
    
    println( "<dev string:x176>" + emoteref );
}

/#

    // Namespace emote
    // Params 0
    // Checksum 0x17bca100, Offset: 0xddf
    // Size: 0x119, Type: dev
    function function_9d432ce233175405()
    {
        setdevdvarifuninitialized( @"hash_d409fce76dc4f7d0", -1 );
        setdevdvarifuninitialized( @"hash_704b8ef083391bdf", -1 );
        
        while ( true )
        {
            emoteentnum = getdvarint( @"hash_7aa9e293ab799b62", 0 );
            debugplay = getdvarint( @"hash_d409fce76dc4f7d0", -1 );
            
            if ( debugplay != -1 )
            {
                emoteent = getentbynum( emoteentnum );
                emote = emoteent function_d97161a916a220af( 0 );
                emoteent playemote( emote );
                setdevdvar( @"hash_d409fce76dc4f7d0", -1 );
            }
            
            var_59d24730c2e1b92d = getdvarint( @"hash_704b8ef083391bdf", -1 );
            
            if ( var_59d24730c2e1b92d != -1 )
            {
                emoteent = getentbynum( emoteentnum );
                emoteent givedebugemote( level.var_34ac945848b5f9da[ var_59d24730c2e1b92d ] );
                emoteent.var_3418ca1423e0fc6d[ 0 ].emote = level.var_34ac945848b5f9da[ var_59d24730c2e1b92d ];
                setdevdvar( @"hash_704b8ef083391bdf", -1 );
            }
            
            wait 1;
        }
    }

#/
