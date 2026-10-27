// scripts\mp\ob\systems\loot_drop.gsc  (hash_0127f8e5756ef723.gscc) (size: 5227 Bytes / 0x146b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x73d7b699 (1943516825)
// size ...... 5227 (0x146b)
// includes .. 5   (offset: 0x1313)
// strings ... 18  (offset: 0x133b)
// dev strs .. 6   (offset: 0x141f)
// exports ... 5   (offset: 0xe1b)
// cseg ...... 0x1df + 0xc3c (0xe1b)
// imports ... 32  (offset: 0xee3)
// animtree1 . 0   (offset: 0x146b)
// animtree2 . 0   (offset: 0x146b)
#using scripts\common\callbacks;
#using scripts\common\throttle;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\ob\systems\region_difficulty_manager;

#namespace loot_drop;

// Namespace loot_drop
// Params 0
// Checksum 0x1ce65fe5, Offset: 0x1fd
// Size: 0x53b
function init_loot_drops()
{
    if ( !getdvarint( @"ob_loot_drops", 1 ) )
    {
        return;
    }
    
    level callback::add( #"on_ai_killed", &on_ai_killed );
    level.loot_drop_killed_throttle = throttle::throttle_initialize( "loot_drop_killed", 1, level.framedurationseconds );
    level.var_3327cc6ea7faa2ba = getdvarint( @"hash_1e0497d9069b47db", 0 );
    level.var_c7b2dce499efc86d = getdvarint( @"hash_133e4c334e41e879", 0 );
    level.var_c19d8506d5d4f3f = getdvarfloat( @"hash_837c6f2d5c3f6a9", 0 );
    level.var_7302605f19cbc5f2 = [ [], [ getdvarfloat( @"hash_a0615a22264154f4", 0.6 ), getdvarfloat( @"hash_a0615b2226415727", 0.4 ), getdvarfloat( @"hash_a0615c222641595a", 0 ), getdvarfloat( @"hash_a0615d2226415b8d", 0 ), getdvarfloat( @"hash_a061562226414c28", 0 ) ], [ getdvarfloat( @"hash_ad22f1222ef67009", 0 ), getdvarfloat( @"hash_ad22f0222ef66dd6", 0.7 ), getdvarfloat( @"hash_ad22ef222ef66ba3", 0.3 ), getdvarfloat( @"hash_ad22ee222ef66970", 0 ), getdvarfloat( @"hash_ad22f5222ef678d5", 0 ) ], [ getdvarfloat( @"hash_be4aa8223c81fa7e", 0 ), getdvarfloat( @"hash_be4aa9223c81fcb1", 0 ), getdvarfloat( @"hash_be4aa6223c81f618", 0.8 ), getdvarfloat( @"hash_be4aa7223c81f84b", 0.2 ), getdvarfloat( @"hash_be4aac223c82034a", 0 ) ], [ getdvarfloat( @"hash_cc263f22466db953", 0 ), getdvarfloat( @"hash_cc263e22466db720", 0 ), getdvarfloat( @"hash_cc264122466dbdb9", 0 ), getdvarfloat( @"hash_cc264022466dbb86", 0.9 ), getdvarfloat( @"hash_cc264322466dc21f", 0.1 ) ], [ getdvarfloat( @"hash_d8e7f6224f231ac8", 0 ), getdvarfloat( @"hash_d8e7f7224f231cfb", 0 ), getdvarfloat( @"hash_d8e7f8224f231f2e", 0 ), getdvarfloat( @"hash_d8e7f9224f232161", 0.9 ), getdvarfloat( @"hash_d8e7fa224f232394", 0.1 ) ] ];
    level.var_7302605f19cbc5f2[ 0 ] = level.var_7302605f19cbc5f2[ 1 ];
    
    if ( getdvarint( @"hash_2cdd89102afc865e", 0 ) )
    {
        level.var_b6c3ca068782a9cb = &function_984c034cc4b2a414;
        level.var_3836af4596707c8c = &soldier_drop_weapon;
    }
    
    level.var_2a0ead9138720590 = [];
    zone_list_bundle = getscriptbundlefieldvalues( level.gametypebundle.var_3842463aacfdc5ca, [ #"hash_11eb633eb96632df" ] );
    
    foreach ( entry in zone_list_bundle.zonedefs )
    {
        if ( !isdefined( entry.zonename ) )
        {
            continue;
        }
        
        level.var_2a0ead9138720590[ entry.zonename ] = [];
        zone_def_bundle = getscriptbundlefieldvalues( hashcat( %"itemspawnzonedef:", entry.zonedef ), [ #"hash_32a95aa45b53f917" ] );
        
        if ( !isdefined( zone_def_bundle.var_a72bc938c97bce90 ) )
        {
            continue;
        }
        
        foreach ( script_entry in zone_def_bundle.var_a72bc938c97bce90 )
        {
            if ( !isdefined( script_entry.scriptkey ) || script_entry.var_fc47c362d6d23c22 == 0 || !script_entry.itemspawnlist )
            {
                continue;
            }
            
            level.var_2a0ead9138720590[ entry.zonename ][ script_entry.scriptkey ] = { #quantity:script_entry.itemspawnquantity, #list:hashcat( %"itemspawnlist:", script_entry.itemspawnlist ) };
        }
    }
}

// Namespace loot_drop
// Params 1
// Checksum 0x83a1dc2c, Offset: 0x740
// Size: 0x518
function on_ai_killed( params )
{
    if ( self.var_a13bed1ac47e1b2c || self.b_in_spawn_closet || !( isdefined( self.origin ) && isdefined( self.subclass ) ) || level.var_3327cc6ea7faa2ba )
    {
        self.var_407c65c25802195b = undefined;
        return;
    }
    
    region = region_difficulty_manager::function_f9fbb630598afdc7( self.origin );
    
    if ( region.name == "scorpio_interior" )
    {
        zone_name = "scorpio_interior";
    }
    else
    {
        zone_name = region.difficultyint >= 2 ? "difficulty" + region.difficultyint : "global";
    }
    
    var_2a7d56c83949ea16 = level.var_2a0ead9138720590[ zone_name ];
    
    if ( !isdefined( var_2a7d56c83949ea16 ) )
    {
        if ( level.var_c7b2dce499efc86d )
        {
            logstring( "[OB_LOOT_DROP] failed to find a zone [" + zone_name + "]" );
        }
        
        self.var_407c65c25802195b = undefined;
        return;
    }
    
    loot_drops_key = self.var_e94a0381e288005e ?? getxhash( self.subclass );
    loot_drops = level.var_2a0ead9138720590[ zone_name ][ loot_drops_key ];
    
    if ( !loot_drops )
    {
        if ( level.var_c7b2dce499efc86d )
        {
            logstring( "[OB_LOOT_DROP] failed to find a script key [" + self.subclass + "] in zone [" + zone_name + "]" );
        }
        
        self.var_407c65c25802195b = undefined;
        return;
    }
    
    itemspawnlist = loot_drops.list;
    itemspawncount = loot_drops.quantity;
    
    if ( isdefined( self.override_zombie_droplist ) )
    {
        itemspawnlist = self.override_zombie_droplist;
    }
    
    /#
        forced_itemspawnlist = getdvar( @"scr_force_item_list", "<dev string:x24>" );
        
        if ( forced_itemspawnlist != "<dev string:x24>" )
        {
            itemspawnlist = forced_itemspawnlist;
        }
        
        subclass = self.subclass;
    #/
    
    spawn_pos = self.origin;
    weapon_item_name = undefined;
    
    if ( self.unittype == "soldier" && !self.alreadydroppedweapon && ( self.force_drop_weapon || randomfloat( 1 ) < level.var_c19d8506d5d4f3f ) )
    {
        weapon_item_name = function_984c034cc4b2a414( region );
        self.alreadydroppedweapon = 1;
    }
    
    loot_drop_event = spawnstruct();
    throttle::throttle_wait_in_queue( level.loot_drop_killed_throttle, loot_drop_event );
    spawn_options = common_item::items_initspawnoptions_spawnfromposition( spawn_pos );
    var_c7c306b169cf129b = common_item::function_38cde6a6acb68ea6( itemspawnlist, itemspawncount, spawn_options );
    
    if ( isdefined( weapon_item_name ) )
    {
        common_item::function_61c2c0251e742ffd( weapon_item_name, undefined, spawn_options );
    }
    
    if ( var_c7c306b169cf129b.size > 0 )
    {
        attacker = params.eattacker;
        meansofdeath = params.smeansofdeath;
        aiposition = self getcentroid();
        level callback::callback( #"hash_21a45497e0cfe5a8", { #agent:self, #aiposition:aiposition, #meansofdeath:meansofdeath, #attacker:attacker, #items:var_c7c306b169cf129b } );
    }
    
    if ( isdefined( self.var_407c65c25802195b ) )
    {
        if ( self.var_407c65c25802195b == 3 && var_c7c306b169cf129b.size > 0 )
        {
            foreach ( item in var_c7c306b169cf129b )
            {
                if ( issubstr( item.type, "obloot_item_select_weapon_" ) || issubstr( item.type, "obloot_item_select_scorestreak_" ) || item.type == "obloot_item_select_exotic_weapon" )
                {
                    item.var_df76d6977d8f4265 = 1;
                    break;
                }
            }
        }
        
        self.var_407c65c25802195b = undefined;
    }
    
    /#
        if ( level.var_c7b2dce499efc86d )
        {
            logstring( "<dev string:x25>" + subclass + "<dev string:x3a>" + getxhashsourcename( itemspawnlist ) + "<dev string:x43>" + itemspawncount );
            
            if ( var_c7c306b169cf129b.size > 0 )
            {
                foreach ( item in var_c7c306b169cf129b )
                {
                    logstring( "<dev string:x4d>" + getxhashsourcename( item.type ) );
                }
            }
            
            if ( isdefined( weapon_item_name ) )
            {
                logstring( "<dev string:x66>" + getxhashsourcename( weapon_item_name ) );
            }
        }
    #/
}

// Namespace loot_drop
// Params 1
// Checksum 0x6766f789, Offset: 0xc60
// Size: 0x17b
function function_984c034cc4b2a414( region )
{
    var_619aa3791b99968c = undefined;
    
    if ( arraycontains( strtok( self.lastweapon.basename, "_" ), "la" ) || arraycontains( strtok( self.lastweapon.basename, "_" ), "sn" ) )
    {
        var_619aa3791b99968c = self.lastweapon.basename;
    }
    else
    {
        var_619aa3791b99968c = self.primaryweapon.basename;
    }
    
    rarity = 0;
    
    if ( !isdefined( region ) )
    {
        region = region_difficulty_manager::function_f9fbb630598afdc7( self.origin );
    }
    
    rarity_chances = level.var_7302605f19cbc5f2[ region.difficultyint ];
    rarity_roll = randomfloat( 1 );
    
    for ( i = rarity_chances.size - 1; i > 0 ; i-- )
    {
        if ( rarity_roll < rarity_chances[ i ] )
        {
            rarity = i;
            break;
        }
        
        rarity_roll -= rarity_chances[ i ];
    }
    
    item_name = item_weapon::function_3da93a43aae4473d( var_619aa3791b99968c, rarity );
    
    if ( isdefined( item_name ) )
    {
        return item_name;
    }
    
    if ( level.var_c7b2dce499efc86d )
    {
        logstring( "[OB_LOOT_DROPS] Failed to find an item for the weapon " + ( var_619aa3791b99968c.basename ?? "undefined" ) + " with rarity " + rarity );
    }
    
    return %"hash_24d895f1ab8d269f";
}

// Namespace loot_drop
// Params 2
// Checksum 0x4ff080b0, Offset: 0xde3
// Size: 0x38
function soldier_drop_weapon( item_name, origin )
{
    spawn_options = common_item::items_initspawnoptions_spawnfromposition( origin );
    item_weapon::function_b960bc85ea91de14( getscriptbundle( item_name ), spawn_options );
}

