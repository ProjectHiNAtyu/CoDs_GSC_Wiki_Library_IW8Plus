// scripts\mp\br\br_quest_inventory.gsc  (hash_22bf2244ec619ed7.gscc) (size: 9604 Bytes / 0x2584 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf141299b (4047579547)
// size ...... 9604 (0x2584)
// includes .. 7   (offset: 0x2344)
// strings ... 19  (offset: 0x237c)
// dev strs .. 1   (offset: 0x2578)
// exports ... 30  (offset: 0x178c)
// cseg ...... 0x15e + 0x162e (0x178c)
// imports ... 53  (offset: 0x1c3c)
// animtree1 . 0   (offset: 0x2584)
// animtree2 . 0   (offset: 0x2584)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\rejoin_utility;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_quest;

#namespace br_quest_inventory;

// Namespace br_quest_inventory
// Params 0, eflags: 0x5
// Checksum 0x9d18ba72, Offset: 0x17c
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"br_quest_inventory", undefined, &pre_main, &post_main );
}

// Namespace br_quest_inventory
// Params 0, eflags: 0x4
// Checksum 0xe051f7ba, Offset: 0x1a1
// Size: 0x43
function private pre_main()
{
    if ( !isdefined( level.br_quest_inventory ) )
    {
        level.br_quest_inventory = {};
    }
    
    if ( !isdefined( level.br_quest_inventory.item_funcs ) )
    {
        level.br_quest_inventory.item_funcs = [];
    }
}

// Namespace br_quest_inventory
// Params 0, eflags: 0x4
// Checksum 0x62c390b4, Offset: 0x1ec
// Size: 0x12
function private post_main()
{
    if ( function_7ba89b2f24296197() )
    {
        init_player_callbacks();
    }
}

// Namespace br_quest_inventory
// Params 0, eflags: 0x4
// Checksum 0xc97ad45f, Offset: 0x206
// Size: 0x4d
function private init_player_callbacks()
{
    callback::add( #"player_connect", &on_player_connect );
    callback::add( #"player_disconnect", &on_player_disconnect );
    callback::add( #"player_death", &on_player_death );
    rejoin_utility::function_70467cdf042579e5( &on_player_rejoin );
}

// Namespace br_quest_inventory
// Params 0, eflags: 0x4
// Checksum 0xbc9d4254, Offset: 0x25b
// Size: 0x26
function private function_7ba89b2f24296197()
{
    return utility::function_edc4cc03e9e60b3e( @"br_quest_inventory_active", 1, level.gametypebundle.var_180cf541342782bd );
}

// Namespace br_quest_inventory
// Params 0
// Checksum 0x1baa56d1, Offset: 0x28a
// Size: 0x163
function function_6de76e05c2eed706()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( !function_7ba89b2f24296197() )
    {
        return;
    }
    
    for ( i = 0; i < 8 ; i++ )
    {
        id = self getplayerdata( level.var_6f9b00680ed002d8, "brQuestItems", i, "lootID" );
        
        if ( id != 0 )
        {
            quantity = self getplayerdata( level.var_6f9b00680ed002d8, "brQuestItems", i, "quantity" );
            ownerid = self getplayerdata( level.var_6f9b00680ed002d8, "brQuestItems", i, "owner" );
            self setplayerdata( level.var_6f9b00680ed002d8, "brQuestItems", i, "lootID", 0 );
            self setplayerdata( level.var_6f9b00680ed002d8, "brQuestItems", i, "quantity", 0 );
            self setplayerdata( level.var_6f9b00680ed002d8, "brQuestItems", i, "owner", self getentitynumber() );
            waitframe();
            self setplayerdata( level.var_6f9b00680ed002d8, "brQuestItems", i, "lootID", id );
            self setplayerdata( level.var_6f9b00680ed002d8, "brQuestItems", i, "quantity", quantity );
            self setplayerdata( level.var_6f9b00680ed002d8, "brQuestItems", i, "owner", ownerid );
        }
    }
}

// Namespace br_quest_inventory
// Params 0
// Checksum 0x9750418e, Offset: 0x3f5
// Size: 0x9a
function reset_player_inventory()
{
    if ( !function_7ba89b2f24296197() )
    {
        return;
    }
    
    player = self;
    
    for ( i = 0; i < 8 ; i++ )
    {
        player setplayerdata( level.var_6f9b00680ed002d8, "brQuestItems", i, "lootID", 0 );
        player setplayerdata( level.var_6f9b00680ed002d8, "brQuestItems", i, "quantity", 0 );
        player setplayerdata( level.var_6f9b00680ed002d8, "brQuestItems", i, "owner", player getentitynumber() );
    }
    
    player.var_3e44f73e8503e4d8 = undefined;
}

// Namespace br_quest_inventory
// Params 0
// Checksum 0xba6049df, Offset: 0x497
// Size: 0x4
function function_93d24fdd85a5eb60()
{
    return 8;
}

// Namespace br_quest_inventory
// Params 0
// Checksum 0x34e7e8f0, Offset: 0x4a4
// Size: 0x12c
function function_b6b94b71f52f7da9()
{
    if ( !function_7ba89b2f24296197() )
    {
        return;
    }
    
    spawn_options = common_item::items_initspawnoptions_spawnfromentity( self );
    
    for ( i = 0; i < 8 ; i++ )
    {
        id = self getplayerdata( level.var_6f9b00680ed002d8, "brQuestItems", i, "lootID" );
        
        if ( id != 0 )
        {
            quantity = self getplayerdata( level.var_6f9b00680ed002d8, "brQuestItems", i, "quantity" );
            ownerid = self getplayerdata( level.var_6f9b00680ed002d8, "brQuestItems", i, "owner" );
            bundle = common_item::function_b202b16941992cca( id );
            drop_quest_item( bundle.ref, quantity, ownerid, spawn_options );
        }
        
        self setplayerdata( level.var_6f9b00680ed002d8, "brQuestItems", i, "lootID", 0 );
        self setplayerdata( level.var_6f9b00680ed002d8, "brQuestItems", i, "quantity", 0 );
        self setplayerdata( level.var_6f9b00680ed002d8, "brQuestItems", i, "owner", self getentitynumber() );
    }
}

// Namespace br_quest_inventory
// Params 2
// Checksum 0x2f29ddcd, Offset: 0x5d8
// Size: 0x32
function consume_quest_item( item_ref, item_count = 1 )
{
    if ( !function_7ba89b2f24296197() )
    {
        return;
    }
    
    return function_62b098d49777c11b( item_ref, item_count );
}

// Namespace br_quest_inventory
// Params 2
// Checksum 0xddbd6a03, Offset: 0x613
// Size: 0x63
function has_quest_item( item_ref, min_count = 1 )
{
    if ( !function_7ba89b2f24296197() )
    {
        return;
    }
    
    slot = function_e5584a893a392326( item_ref );
    
    if ( slot >= 0 )
    {
        return ( self getplayerdata( level.var_6f9b00680ed002d8, "brQuestItems", slot, "quantity" ) >= min_count );
    }
    
    return 0;
}

// Namespace br_quest_inventory
// Params 0
// Checksum 0x6387e187, Offset: 0x67f
// Size: 0x4b
function function_af13d37b0a69d8bc()
{
    if ( !function_7ba89b2f24296197() )
    {
        return;
    }
    
    for ( i = 0; i < 8 ; i++ )
    {
        if ( self getplayerdata( level.var_6f9b00680ed002d8, "brQuestItems", i, "lootID" ) != 0 )
        {
            return 1;
        }
    }
    
    return 0;
}

// Namespace br_quest_inventory
// Params 1
// Checksum 0xd70fb832, Offset: 0x6d3
// Size: 0x59
function get_quest_item_amount( item_ref )
{
    if ( !function_7ba89b2f24296197() )
    {
        return;
    }
    
    if ( has_quest_item( item_ref ) )
    {
        slot = function_e5584a893a392326( item_ref );
        
        if ( slot >= 0 )
        {
            return self getplayerdata( level.var_6f9b00680ed002d8, "brQuestItems", slot, "quantity" );
        }
    }
    
    return 0;
}

// Namespace br_quest_inventory
// Params 1
// Checksum 0x400dc3c, Offset: 0x735
// Size: 0x43
function get_quest_item_id( slot )
{
    if ( !function_7ba89b2f24296197() )
    {
        return;
    }
    
    if ( slot < 0 || slot >= 8 )
    {
        return 0;
    }
    
    return self getplayerdata( level.var_6f9b00680ed002d8, "brQuestItems", slot, "lootID" );
}

// Namespace br_quest_inventory
// Params 4
// Checksum 0x745480f7, Offset: 0x781
// Size: 0x251
function add_quest_item( item_ref, item_count = 1, override, params )
{
    if ( !function_7ba89b2f24296197() )
    {
        return;
    }
    
    item_bundle = common_item::function_cf68ad18114498b2( item_ref );
    max_count = common_item::function_38334193bd9b5956( item_bundle );
    ownerid = params.scriptable.ownerid ?? self getentitynumber();
    slot = function_e5584a893a392326( item_ref );
    
    if ( slot >= 0 )
    {
        count = self getplayerdata( level.var_6f9b00680ed002d8, "brQuestItems", slot, "quantity" );
        var_760a5cad841eb3c7 = self getplayerdata( level.var_6f9b00680ed002d8, "brQuestItems", slot, "owner" );
        self setplayerdata( level.var_6f9b00680ed002d8, "brQuestItems", slot, "owner", ownerid );
        
        if ( count >= max_count )
        {
            thread quest_item_delayed_respawn( item_ref, item_count, var_760a5cad841eb3c7, %"hash_1f1ba741624917ed" );
            return;
        }
        
        new_item_count = count + item_count;
        
        if ( override )
        {
            new_item_count = item_count;
        }
        
        remaining_count = maxint( 0, new_item_count - max_count );
        self setplayerdata( level.var_6f9b00680ed002d8, "brQuestItems", slot, "quantity", minint( new_item_count, max_count ) );
        self.var_3e44f73e8503e4d8 = 1;
        thread quest_item_delayed_respawn( item_ref, remaining_count, var_760a5cad841eb3c7, %"hash_5862a715bc03fa42" );
        return;
    }
    
    slot = function_58d2f24fb6624294();
    
    if ( slot >= 0 )
    {
        remaining_count = maxint( 0, item_count - max_count );
        id = common_item::items_getlootidfromref( item_ref );
        self setplayerdata( level.var_6f9b00680ed002d8, "brQuestItems", slot, "lootID", id );
        self setplayerdata( level.var_6f9b00680ed002d8, "brQuestItems", slot, "quantity", minint( item_count, max_count ) );
        self setplayerdata( level.var_6f9b00680ed002d8, "brQuestItems", slot, "owner", ownerid );
        self.var_3e44f73e8503e4d8 = 1;
        
        if ( remaining_count > 0 )
        {
            thread quest_item_delayed_respawn( item_ref, remaining_count, ownerid, %"hash_1f1ba741624917ed" );
        }
        
        return;
    }
    
    thread quest_item_delayed_respawn( item_ref, item_count, ownerid, %"hash_5862a715bc03fa42" );
}

// Namespace br_quest_inventory
// Params 1
// Checksum 0xba01de87, Offset: 0x9da
// Size: 0x1da
function on_quest_item_used( params )
{
    if ( !function_7ba89b2f24296197() )
    {
        return;
    }
    
    item = params.bundle.ref;
    count = params.scriptable.count;
    add_quest_item( item, count, undefined, params );
    lootid = params.bundle.ref ? common_item::function_779887309ec71dfe( params.bundle ) : 0;
    typestring = common_item::function_16e8c106491eeaca( params.bundle );
    itemname = params.bundle.scriptable;
    itemorigin = params.scriptable.origin ?? self.origin;
    quest_item_analytics( undefined, lootid, typestring, itemorigin, itemname, params.scriptable.critical );
    
    if ( isdefined( level.br_quest_inventory.item_funcs[ item ] ) )
    {
        foreach ( funcs in level.br_quest_inventory.item_funcs[ item ] )
        {
            if ( isdefined( funcs.used ) )
            {
                profilestart();
                self [[ funcs.used ]]( params );
                profilestop();
            }
        }
    }
}

// Namespace br_quest_inventory
// Params 1, eflags: 0x4
// Checksum 0xed4fa68d, Offset: 0xbbc
// Size: 0x3c
function private on_player_connect( params )
{
    if ( !self.var_3de83f810a82a04c )
    {
        reset_player_inventory();
        self.var_3de83f810a82a04c = 1;
    }
    
    callback::add( "quest_item_used", &on_quest_item_used );
}

// Namespace br_quest_inventory
// Params 1, eflags: 0x4
// Checksum 0x29175796, Offset: 0xc00
// Size: 0x2b
function private on_player_disconnect( params )
{
    if ( !self.var_3e44f73e8503e4d8 )
    {
        return;
    }
    
    function_b6b94b71f52f7da9();
    self.var_3e44f73e8503e4d8 = undefined;
}

// Namespace br_quest_inventory
// Params 1, eflags: 0x4
// Checksum 0x51b20844, Offset: 0xc33
// Size: 0x56
function private on_player_death( params )
{
    player = params.victim;
    
    if ( !player.var_3e44f73e8503e4d8 || player.var_d4c84561f42b4612 )
    {
        return;
    }
    
    player function_b6b94b71f52f7da9();
    player.var_3e44f73e8503e4d8 = undefined;
}

// Namespace br_quest_inventory
// Params 1, eflags: 0x4
// Checksum 0x4dc51b1f, Offset: 0xc91
// Size: 0x41
function private on_player_rejoin( player )
{
    if ( !player.var_3e44f73e8503e4d8 || player.var_d4c84561f42b4612 || !player function_af13d37b0a69d8bc() )
    {
        return;
    }
    
    player thread function_6de76e05c2eed706();
}

// Namespace br_quest_inventory
// Params 1, eflags: 0x4
// Checksum 0x9da81d17, Offset: 0xcda
// Size: 0x5e
function private function_e5584a893a392326( item_ref )
{
    id = common_item::items_getlootidfromref( item_ref );
    
    for ( i = 0; i < 8 ; i++ )
    {
        if ( self getplayerdata( level.var_6f9b00680ed002d8, "brQuestItems", i, "lootID" ) === id )
        {
            return i;
        }
    }
    
    return -1;
}

// Namespace br_quest_inventory
// Params 0, eflags: 0x4
// Checksum 0xdeadbd95, Offset: 0xd41
// Size: 0x41
function private function_58d2f24fb6624294()
{
    for ( i = 0; i < 8 ; i++ )
    {
        if ( self getplayerdata( level.var_6f9b00680ed002d8, "brQuestItems", i, "lootID" ) == 0 )
        {
            return i;
        }
    }
    
    return -1;
}

// Namespace br_quest_inventory
// Params 0, eflags: 0x4
// Checksum 0x9b536853, Offset: 0xd8b
// Size: 0x61
function private function_2072313c0e4c867b()
{
    slot = 7;
    lootid = 0;
    
    while ( slot > 0 )
    {
        lootid = self getplayerdata( level.var_6f9b00680ed002d8, "brQuestItems", slot, "lootID" );
        isemptyslot = lootid == 0;
        
        if ( !isemptyslot )
        {
            return lootid;
        }
        
        slot -= 1;
    }
    
    return lootid;
}

// Namespace br_quest_inventory
// Params 2, eflags: 0x4
// Checksum 0x75369b, Offset: 0xdf5
// Size: 0x115, Type: bool
function private function_62b098d49777c11b( item_ref, num_removed = 1 )
{
    slot = function_e5584a893a392326( item_ref );
    
    if ( slot >= 0 )
    {
        count = self getplayerdata( level.var_6f9b00680ed002d8, "brQuestItems", slot, "quantity" );
        
        if ( count - num_removed < 0 )
        {
            return false;
        }
        
        remainder = maxint( count - num_removed, 0 );
        
        if ( remainder == 0 )
        {
            self setplayerdata( level.var_6f9b00680ed002d8, "brQuestItems", slot, "lootID", 0 );
            self setplayerdata( level.var_6f9b00680ed002d8, "brQuestItems", slot, "owner", self getentitynumber() );
        }
        
        self setplayerdata( level.var_6f9b00680ed002d8, "brQuestItems", slot, "quantity", remainder );
    }
    else
    {
        return false;
    }
    
    lootid = 0;
    
    if ( !function_af13d37b0a69d8bc() )
    {
        self.var_3e44f73e8503e4d8 = undefined;
    }
    else
    {
        lootid = function_2072313c0e4c867b();
    }
    
    common_item_quest::function_19b7bcd568b698f3( lootid );
    return true;
}

// Namespace br_quest_inventory
// Params 4, eflags: 0x4
// Checksum 0xc05972d6, Offset: 0xf13
// Size: 0x3e6
function private drop_quest_item( item_ref, item_count, ownerid, spawn_options )
{
    params = { #spawn_options:spawn_options, #ownerid:ownerid, #ref:item_ref };
    
    if ( isdefined( level.br_quest_inventory.item_funcs[ item_ref ] ) )
    {
        foreach ( funcs in level.br_quest_inventory.item_funcs[ item_ref ] )
        {
            if ( isdefined( funcs.on_drop ) )
            {
                profilestart();
                self [[ funcs.on_drop ]]( params );
                profilestop();
            }
        }
    }
    
    callback::callback( item_ref + "_" + "quest_item_on_drop", params );
    bundle = common_item::function_cf68ad18114498b2( item_ref );
    
    if ( bundle.nonstackable && item_count > 1 )
    {
        for ( i = 0; i < item_count ; i++ )
        {
            scriptable = common_item::function_61c2c0251e742ffd( bundle, 1, spawn_options );
            scriptable.ownerid = params.ownerid;
            params = { #count:1, #scriptable:scriptable, #bundle:bundle };
            
            if ( isdefined( level.br_quest_inventory.item_funcs[ item_ref ] ) )
            {
                foreach ( funcs in level.br_quest_inventory.item_funcs[ item_ref ] )
                {
                    if ( isdefined( funcs.dropped ) )
                    {
                        profilestart();
                        self [[ funcs.dropped ]]( params );
                        profilestop();
                    }
                }
            }
        }
    }
    else
    {
        scriptable = common_item::function_61c2c0251e742ffd( bundle, item_count, params.spawn_options );
        scriptable.ownerid = params.ownerid;
        params = { #count:item_count, #scriptable:scriptable, #bundle:bundle };
        
        if ( isdefined( level.br_quest_inventory.item_funcs[ item_ref ] ) )
        {
            foreach ( funcs in level.br_quest_inventory.item_funcs[ item_ref ] )
            {
                if ( isdefined( funcs.dropped ) )
                {
                    profilestart();
                    self [[ funcs.dropped ]]( params );
                    profilestop();
                }
            }
        }
    }
    
    lootid = bundle.ref ? common_item::function_779887309ec71dfe( bundle ) : 0;
    typestring = common_item::function_16e8c106491eeaca( bundle );
    itemname = bundle.scriptable;
    itemorigin = self.origin;
    quest_item_analytics( lootid, undefined, typestring, itemorigin, itemname, spawn_options.critical );
    function_62b098d49777c11b( item_ref );
}

// Namespace br_quest_inventory
// Params 4, eflags: 0x4
// Checksum 0x3ec3e1ec, Offset: 0x1301
// Size: 0x199
function private quest_item_delayed_respawn( item_ref, count, ownerid, errormessage )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    waitframe();
    params = { #ownerid:ownerid, #spawn_options:common_item::items_initspawnoptions_spawnfromentity( self ) };
    
    if ( isdefined( level.br_quest_inventory.item_funcs[ item_ref ] ) )
    {
        foreach ( funcs in level.br_quest_inventory.item_funcs[ item_ref ] )
        {
            if ( isdefined( funcs.delayed_respawn ) )
            {
                profilestart();
                self [[ funcs.delayed_respawn ]]( params );
                profilestop();
            }
        }
    }
    
    callback::callback( item_ref + "_" + "quest_item_delayed_respawn", params );
    
    if ( count > 0 )
    {
        /#
            iprintlnbold( "<dev string:x24>" );
        #/
        
        hud_message::showerrormessage( errormessage );
        bundle = common_item::function_cf68ad18114498b2( item_ref );
        scriptable = common_item::function_61c2c0251e742ffd( bundle, count, params.spawn_options );
        scriptable.ownerid = params.ownerid;
    }
}

// Namespace br_quest_inventory
// Params 2
// Checksum 0x7358db43, Offset: 0x14a2
// Size: 0xe5
function register_quest_item_funcs( items, func )
{
    if ( !isarray( items ) )
    {
        items = [ items ];
    }
    
    foreach ( item in items )
    {
        if ( !isdefined( level.br_quest_inventory.item_funcs[ item ] ) )
        {
            level.br_quest_inventory.item_funcs[ item ] = [];
        }
        
        level.br_quest_inventory.item_funcs[ item ][ self.name ] = func;
    }
}

// Namespace br_quest_inventory
// Params 1
// Checksum 0x7960f664, Offset: 0x158f
// Size: 0xc6
function function_636783f9390ac35d( items )
{
    if ( !isarray( items ) )
    {
        items = [ items ];
    }
    
    foreach ( item in items )
    {
        if ( !isdefined( level.br_quest_inventory.item_funcs[ item ] ) )
        {
            continue;
        }
        
        level.br_quest_inventory.item_funcs[ item ][ self.name ] = undefined;
    }
}

// Namespace br_quest_inventory
// Params 6
// Checksum 0x8848ae25, Offset: 0x165d
// Size: 0x12f
function quest_item_analytics( droppedid, stowedid, typestring, itemorigin, itemname, critical )
{
    self dlog_recordplayerevent( "dlog_event_player_br_quest_item", [ "dropped", droppedid ?? 0, "stowed", stowedid ?? 0, "type", isxhashasset( typestring ) ? typestring : getxhashasset( tolower( typestring ) ?? "" ), "item_x", itemorigin[ 0 ], "item_y", itemorigin[ 1 ], "item_z", itemorigin[ 2 ], "item_name", isxhashasset( itemname ) ? itemname : getxhashasset( tolower( itemname ) ?? "" ), "circle_index", level.br_circle.circleindex ?? -1, "critical", critical ?? 0 ] );
}

