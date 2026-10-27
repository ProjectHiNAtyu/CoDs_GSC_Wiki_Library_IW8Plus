// script_2e299f259c8724f3  (hash_2e299f259c8724f3.gscc) (size: 2918 Bytes / 0xb66 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa758b440 (2807608384)
// size ...... 2918 (0xb66)
// includes .. 5   (offset: 0xaaa)
// strings ... 10  (offset: 0xad2)
// dev strs .. 0   (offset: 0xb66)
// exports ... 12  (offset: 0x5e2)
// cseg ...... 0xf4 + 0x4ee (0x5e2)
// imports ... 26  (offset: 0x7c2)
// animtree1 . 0   (offset: 0xb66)
// animtree2 . 0   (offset: 0xb66)
#using scripts\common\system;
#using scripts\mp\br\gametypes\br_map_quest;
#using scripts\mp\common\utility\points;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;

#namespace quest_shower;

// Namespace quest_shower
// Params 0, eflags: 0x5
// Checksum 0x38961596, Offset: 0x112
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"shower", #"br_map_quest", &init, undefined );
}

// Namespace quest_shower
// Params 0
// Checksum 0x69c5fbb, Offset: 0x13b
// Size: 0x6c
function init()
{
    quest = { #on_infil:&on_infil, #on_prematch_end:&on_prematch_end, #on_start:&on_start, #on_precache:&on_precache, #on_init:&on_init, #name:"shower" };
    br_map_quest::register( quest );
}

// Namespace quest_shower
// Params 0
// Checksum 0x90a1c96b, Offset: 0x1af
// Size: 0x9
function on_init()
{
    set_dvars();
}

// Namespace quest_shower
// Params 0
// Checksum 0xc8a83518, Offset: 0x1c0
// Size: 0x2
function on_precache()
{
    
}

// Namespace quest_shower
// Params 0
// Checksum 0x19de4c99, Offset: 0x1ca
// Size: 0x2
function on_start()
{
    
}

// Namespace quest_shower
// Params 0
// Checksum 0xf59590a8, Offset: 0x1d4
// Size: 0x2
function on_prematch_end()
{
    
}

// Namespace quest_shower
// Params 0
// Checksum 0x75a9596b, Offset: 0x1de
// Size: 0x9
function on_infil()
{
    shower_spawn();
}

// Namespace quest_shower
// Params 0
// Checksum 0xbf241de7, Offset: 0x1ef
// Size: 0x1e
function set_dvars()
{
    br_map_quest::add_setting( "duration", 24 );
    br_map_quest::add_setting( "cooldown", 90 );
}

// Namespace quest_shower
// Params 0
// Checksum 0x1240a6c6, Offset: 0x215
// Size: 0x8f
function shower_spawn()
{
    shower = spawnscriptable( "escape_shower", ( -1804, 10544, 531 ) );
    shower.interact = interaction::register_scriptable_interact( shower, &shower_used );
    shower.duration = br_map_quest::get_setting( "duration" );
    shower.cooldowntime = br_map_quest::get_setting( "cooldown" );
    shower.var_475cea69b3c9a519 = getdvarint( @"hash_16fe69df6a566154", 1 ) ? 1 : 0;
}

// Namespace quest_shower
// Params 1
// Checksum 0xb0619c3b, Offset: 0x2ac
// Size: 0x5d
function shower_used( player )
{
    level endon( #"game_ended" );
    shower = self;
    shower thread shower_active();
    player points::doscoreevent( #"hash_54c60c293e561825" );
    wait shower.cooldowntime;
    shower setscriptablepartstate( "base", "alive" );
}

// Namespace quest_shower
// Params 0
// Checksum 0x6d712268, Offset: 0x311
// Size: 0x2d1
function shower_active()
{
    level endon( #"game_ended" );
    shower = self;
    maxinterval = int( shower.duration / 8 );
    var_b2192a2c255f23ab = [];
    var_a3c611cbbf552018 = 0;
    
    for ( i = 0; i < 8 ; i++ )
    {
        var_b2192a2c255f23ab[ i ] = randomintrange( 1, maxinterval + 1 );
        var_a3c611cbbf552018 += var_b2192a2c255f23ab[ i ];
    }
    
    var_a3c611cbbf552018 = shower.duration / var_a3c611cbbf552018;
    self setscriptablepartstate( "base", "in_use" );
    common_item::function_45c338c4003d5f13( shower, 0 );
    
    if ( shower.var_475cea69b3c9a519 )
    {
        items = [ [ "brloot_plunder_cash_uncommon_1", 3 ], [ "brloot_access_card_forgotten", 1 ], [ "brloot_plunder_cash_uncommon_1", 3 ] ];
        shower.var_475cea69b3c9a519 = 0;
    }
    else
    {
        items = [ [ "brloot_plunder_cash_uncommon_1", 7 ] ];
    }
    
    itemspawnoptions = common_item::items_initspawnoptions_spawnfromposition( ( -1782, 10545, 520 ), ( 0, -70, 0 ) );
    itemspawnoptions.var_12d76a8b35ac875d = 14;
    itemspawnoptions.dropradiusscale = 1.2;
    itemspawnoptions.var_8934e0ace9b7d996 = 0;
    itemspawnoptions.var_8958d2ace9e03584 = 1;
    itemspawnoptions.var_d72f168a0f299753 = 0;
    itemspawnoptions.var_d7522c8a0f500f6d = 1;
    
    foreach ( item in items )
    {
        ref = item[ 0 ];
        itemcount = item[ 1 ];
        
        for ( i = 0; i < itemcount ; i++ )
        {
            bundle = common_item::function_80af1e9daffacc7d( ref );
            spawnoptions = itemspawnoptions;
            
            if ( ref == "brloot_access_card_forgotten" )
            {
                spawnoptions.critical = 1;
            }
            
            loot_item = common_item::function_61c2c0251e742ffd( bundle, undefined, spawnoptions );
            shower.itemsdropped++;
            
            if ( shower.itemsdropped < 8 )
            {
                wait var_b2192a2c255f23ab[ shower.itemsdropped - 1 ] * var_a3c611cbbf552018;
            }
        }
    }
    
    shower setscriptablepartstate( "base", "stop_use" );
}

