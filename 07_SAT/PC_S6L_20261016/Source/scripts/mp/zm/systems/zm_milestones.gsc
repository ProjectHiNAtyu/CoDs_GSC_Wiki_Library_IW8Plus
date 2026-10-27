// scripts\mp\zm\systems\zm_milestones.gsc  (hash_623c7b4233affe68.gscc) (size: 1763 Bytes / 0x6e3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x518ee667 (1368319591)
// size ...... 1763 (0x6e3)
// includes .. 3   (offset: 0x6a7)
// strings ... 3   (offset: 0x6bf)
// dev strs .. 0   (offset: 0x6e3)
// exports ... 8   (offset: 0x443)
// cseg ...... 0x97 + 0x3ac (0x443)
// imports ... 10  (offset: 0x583)
// animtree1 . 0   (offset: 0x6e3)
// animtree2 . 0   (offset: 0x6e3)
#using scripts\common\callbacks;
#using scripts\mp\currency;
#using scripts\mp\zm\zm_utility;

#namespace zm_milestones;

// Namespace zm_milestones
// Params 0
// Checksum 0x5d1cdb66, Offset: 0xb5
// Size: 0x3e
function function_5b060a8b1988fdfa()
{
    if ( !level.gametypebundle.var_31ddb3c45c4638c7 )
    {
        return;
    }
    
    level callback::add( "on_round_end", &function_ad7ad35d507f260 );
    level callback::add( "on_item_cleanup", &function_5f8f3b4f553fdb68 );
}

// Namespace zm_milestones
// Params 1
// Checksum 0x87ee78, Offset: 0xfb
// Size: 0x12b
function function_ad7ad35d507f260( params )
{
    var_8d885b4aed0bef01 = zm_utility::get_round_number();
    
    if ( var_8d885b4aed0bef01 % 5 == 0 && var_8d885b4aed0bef01 > 5 )
    {
        foreach ( player in level.players )
        {
            player function_8bfc4687f3c5dc11( var_8d885b4aed0bef01 );
        }
    }
    
    if ( var_8d885b4aed0bef01 % 10 == 0 && var_8d885b4aed0bef01 >= 10 )
    {
        foreach ( player in level.players )
        {
            player function_3c8aad3c873b7c61();
        }
    }
}

// Namespace zm_milestones
// Params 1
// Checksum 0x23e53225, Offset: 0x22e
// Size: 0x4d
function function_8bfc4687f3c5dc11( var_8d885b4aed0bef01 )
{
    salvage_mod = get_salvage_modifier( var_8d885b4aed0bef01 );
    salvage_amount = salvage_mod * 100;
    salvage_amount = clamp( salvage_amount, 0, 500 );
    currency::add_currency_amount( #"salvage", salvage_amount );
}

// Namespace zm_milestones
// Params 0
// Checksum 0xaf408cc6, Offset: 0x283
// Size: 0x3c
function function_3c8aad3c873b7c61()
{
    salvage_reward = 50 * self.var_de7f96341fb651b * 0.5;
    currency::add_currency_amount( #"salvage", salvage_reward );
    self.var_de7f96341fb651b = 0;
}

// Namespace zm_milestones
// Params 1
// Checksum 0x252cace2, Offset: 0x2c7
// Size: 0x85
function get_salvage_modifier( var_8d885b4aed0bef01 )
{
    salvage_mod = 1;
    
    switch ( var_8d885b4aed0bef01 )
    {
        case 10:
            salvage_mod = 1;
            break;
        case 15:
            salvage_mod = 2;
            break;
        case 20:
            salvage_mod = 3;
            break;
        case 25:
            salvage_mod = 4;
            break;
        default:
            salvage_mod = 5;
            break;
    }
    
    return salvage_mod;
}

// Namespace zm_milestones
// Params 1
// Checksum 0xaffa0575, Offset: 0x355
// Size: 0x72
function get_rare_salvage_modifier( var_8d885b4aed0bef01 )
{
    rare_salvage_mod = 1;
    
    switch ( var_8d885b4aed0bef01 )
    {
        case 10:
            rare_salvage_mod = 2;
            break;
        case 15:
            rare_salvage_mod = 3;
            break;
        case 20:
            rare_salvage_mod = 4;
            break;
        default:
            rare_salvage_mod = 5;
            break;
    }
    
    return rare_salvage_mod;
}

// Namespace zm_milestones
// Params 1
// Checksum 0x88ba2dd8, Offset: 0x3d0
// Size: 0x73
function function_5f8f3b4f553fdb68( params )
{
    if ( params.item.type === "zmloot_salvage_perplayer" && isdefined( params.item.owningplayer ) && params.b_despawn )
    {
        params.item.owningplayer.var_de7f96341fb651b++;
    }
}

