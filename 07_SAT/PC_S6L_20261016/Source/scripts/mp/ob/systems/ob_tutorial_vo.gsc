// scripts\mp\ob\systems\ob_tutorial_vo.gsc  (hash_31badac00bd53097.gscc) (size: 3433 Bytes / 0xd69 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x555875aa (1431860650)
// size ...... 3433 (0xd69)
// includes .. 4   (offset: 0xc49)
// strings ... 19  (offset: 0xc69)
// dev strs .. 0   (offset: 0xd69)
// exports ... 11  (offset: 0x7fd)
// cseg ...... 0x2da + 0x523 (0x7fd)
// imports ... 20  (offset: 0x9b5)
// animtree1 . 0   (offset: 0xd69)
// animtree2 . 0   (offset: 0xd69)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\gamescore;
#using scripts\mp\overlord;

#namespace ob_tutorial_vo;

// Namespace ob_tutorial_vo
// Params 0
// Checksum 0x56b79503, Offset: 0x2f8
// Size: 0x9f
function init()
{
    if ( !getdvarint( @"hash_464559793bf93309", 0 ) )
    {
        return;
    }
    
    level callback::add( #"player_item_pickup", &on_item_pickup );
    level callback::add( #"player_used_item", &on_item_used );
    level callback::add( #"player_item_drop", &on_item_dropped );
    level callback::add( "on_ammo_pouch_drop", &on_ammo_pouch_drop );
    level callback::add( "currency_add", &on_currency_add );
    level callback::add( "zm_packed_weapon", &function_6aa78523c1e4e229 );
    level callback::add( "on_armor_break", &on_armor_break );
}

// Namespace ob_tutorial_vo
// Params 1
// Checksum 0x9f9925d, Offset: 0x39f
// Size: 0x20
function on_armor_break( params )
{
    if ( isplayer( self ) )
    {
        thread function_1d6bfa2b58e4587f( "ravenov_tutorial_armor_broken" );
    }
}

// Namespace ob_tutorial_vo
// Params 1
// Checksum 0x678dd825, Offset: 0x3c7
// Size: 0x24
function function_6aa78523c1e4e229( params )
{
    utility::ent_flag_set( "pap_weapon" );
    thread function_1d6bfa2b58e4587f( "ravenov_tutorial_ready_for_higher_zone" );
}

// Namespace ob_tutorial_vo
// Params 1
// Checksum 0x78725f92, Offset: 0x3f3
// Size: 0x6c
function on_item_dropped( params )
{
    if ( isdefined( params.itembundle ) && isdefined( params.itembundle.subtype ) )
    {
        switch ( params.itembundle.subtype )
        {
            case #"hash_8499464a48c4e157":
                thread function_1d6bfa2b58e4587f( "ravenov_tutorial_sell_junk" );
                break;
        }
    }
}

// Namespace ob_tutorial_vo
// Params 1
// Checksum 0xc142109f, Offset: 0x467
// Size: 0x120
function on_item_pickup( params )
{
    if ( isdefined( params.itembundle.type ) )
    {
        switch ( params.itembundle.type )
        {
            case #"hash_c04d8180feb92b2b":
                if ( !function_916ec7ff57ccafa1( "ravenov_tutorial_rucksack_upgrade_use" ) )
                {
                    thread function_1d6bfa2b58e4587f( "ravenov_tutorial_rucksack_upgrade_collect" );
                }
                
                break;
            case #"hash_ab671284a3fc4e3d":
                if ( !function_916ec7ff57ccafa1( "ravenov_tutorial_perk_can_use" ) )
                {
                    thread function_1d6bfa2b58e4587f( "ravenov_tutorial_perk_can_collect" );
                }
                
                break;
            case #"hash_d80af4621c199350":
                if ( !function_916ec7ff57ccafa1( "ravenov_tutorial_armor_upgrade_use" ) )
                {
                    thread function_1d6bfa2b58e4587f( "ravenov_tutorial_armor_upgrade_collect" );
                }
                
                break;
        }
    }
    
    if ( isdefined( params.itembundle.subtype ) )
    {
        switch ( params.itembundle.subtype )
        {
            case #"hash_1780867e105363ce":
                if ( !function_916ec7ff57ccafa1( "ravenov_tutorial_aether_tool_use" ) )
                {
                    thread function_1d6bfa2b58e4587f( "ravenov_tutorial_aether_tool_collect" );
                }
                
                break;
        }
    }
}

// Namespace ob_tutorial_vo
// Params 1
// Checksum 0x3ab52190, Offset: 0x58f
// Size: 0xf0
function on_item_used( params )
{
    if ( isdefined( params.itembundle.type ) )
    {
        switch ( params.itembundle.type )
        {
            case #"hash_c04d8180feb92b2b":
                function_1d6bfa2b58e4587f( "ravenov_tutorial_rucksack_upgrade_use" );
                break;
            case #"hash_ab671284a3fc4e3d":
                function_1d6bfa2b58e4587f( "ravenov_tutorial_perk_can_use" );
                break;
            case #"hash_d80af4621c199350":
                function_1d6bfa2b58e4587f( "ravenov_tutorial_armor_upgrade_use" );
                break;
        }
    }
    
    if ( isdefined( params.itembundle.subtype ) )
    {
        switch ( params.itembundle.subtype )
        {
            case #"hash_1780867e105363ce":
                function_1d6bfa2b58e4587f( "ravenov_tutorial_aether_tool_collect" );
                function_1d6bfa2b58e4587f( "ravenov_tutorial_aether_tool_use" );
                break;
        }
    }
}

// Namespace ob_tutorial_vo
// Params 1
// Checksum 0x5e05c5e7, Offset: 0x687
// Size: 0x35
function on_ammo_pouch_drop( params )
{
    if ( isplayer( params.eattacker ) )
    {
        params.eattacker thread function_1d6bfa2b58e4587f( "ravenov_tutorial_ammo_pouch" );
    }
}

// Namespace ob_tutorial_vo
// Params 1
// Checksum 0x82f60a59, Offset: 0x6c4
// Size: 0x43
function on_currency_add( params )
{
    if ( utility::ent_flag( "pap_weapon" ) )
    {
        return;
    }
    
    n_current_essence = gamescore::getplayerscore( self );
    
    if ( n_current_essence >= 5000 )
    {
        thread function_1d6bfa2b58e4587f( "ravenov_tutorial_pap" );
    }
}

// Namespace ob_tutorial_vo
// Params 1
// Checksum 0xd30671e7, Offset: 0x70f
// Size: 0x83
function function_1d6bfa2b58e4587f( var_2a09f314bba98899 )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.var_b402fc263c825fcb ) )
    {
        self.var_b402fc263c825fcb = [];
    }
    
    if ( !function_916ec7ff57ccafa1( var_2a09f314bba98899 ) || getdvarint( @"hash_ac3a05ba7d5a924c", 0 ) )
    {
        self.var_b402fc263c825fcb[ var_2a09f314bba98899 ] = 1;
        self setplayerdata( level.var_6f9b00680ed002d8, "conversation_" + var_2a09f314bba98899, 1 );
        overlord::playconversation( var_2a09f314bba98899, [ self ], undefined, 0 );
    }
}

// Namespace ob_tutorial_vo
// Params 1
// Checksum 0xcd6dfd83, Offset: 0x79a
// Size: 0x62
function function_916ec7ff57ccafa1( var_2a09f314bba98899 )
{
    if ( !isplayer( self ) )
    {
        return 1;
    }
    
    if ( !isdefined( self.var_b402fc263c825fcb ) )
    {
        self.var_b402fc263c825fcb = [];
    }
    
    b_played_vo = self getplayerdata( level.var_6f9b00680ed002d8, "conversation_" + var_2a09f314bba98899 ) || self.var_b402fc263c825fcb[ var_2a09f314bba98899 ];
    return b_played_vo;
}

