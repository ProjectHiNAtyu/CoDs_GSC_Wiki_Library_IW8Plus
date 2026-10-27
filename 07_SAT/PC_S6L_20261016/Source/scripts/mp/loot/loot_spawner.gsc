// scripts\mp\loot\loot_spawner.gsc  (hash_6d7971e13b2e3b2a.gscc) (size: 4615 Bytes / 0x1207 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcc08bf42 (3423125314)
// size ...... 4615 (0x1207)
// includes .. 2   (offset: 0x107f)
// strings ... 17  (offset: 0x108f)
// dev strs .. 12  (offset: 0x116f)
// exports ... 13  (offset: 0xb8f)
// cseg ...... 0x1b1 + 0x9de (0xb8f)
// imports ... 24  (offset: 0xd97)
// animtree1 . 0   (offset: 0x1207)
// animtree2 . 0   (offset: 0x1207)
#using scripts\common\utility;
#using scripts\mp\loot\common_item;

#namespace loot_spawner;

// Namespace loot_spawner
// Params 0
// Checksum 0x54e0227b, Offset: 0x1cf
// Size: 0x49
function init()
{
    if ( isdefined( level.loot_spawner ) )
    {
        return;
    }
    
    initdvars();
    level._effect[ "vfx_golden_loot_explosion_flare" ] = loadfxasset( "vfx_iw8_br_gameplay_golden_loot_explo_flare" );
    level._effect[ "vfx_br_legendary_loot_glow" ] = loadfxasset( "missing" );
}

// Namespace loot_spawner
// Params 0
// Checksum 0x2b9b0d5b, Offset: 0x220
// Size: 0x135
function initdvars()
{
    if ( !isdefined( level.loot_spawner ) )
    {
        level.loot_spawner = spawnstruct();
        level.loot_spawner.ammo_types = [];
        level.loot_spawner.ammo_types[ "rifle" ] = "brloot_ammo_762";
        level.loot_spawner.ammo_types[ "mg" ] = "brloot_ammo_762";
        level.loot_spawner.ammo_types[ "pistol" ] = "brloot_ammo_919";
        level.loot_spawner.ammo_types[ "smg" ] = "brloot_ammo_919";
        level.loot_spawner.ammo_types[ "sniper" ] = "brloot_ammo_50cal";
        level.loot_spawner.ammo_types[ "rocketlauncher" ] = "brloot_ammo_rocket";
        level.loot_spawner.ammo_types[ "spread" ] = "brloot_ammo_12g";
    }
    
    level.loot_spawner.original_tables = [];
    level.loot_spawner.loot_tables = [];
}

// Namespace loot_spawner
// Params 2
// Checksum 0x720afff8, Offset: 0x35d
// Size: 0x85
function function_1fba34361fc70488( key, loottable )
{
    if ( !isdefined( level.loot_spawner ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    if ( !isdefined( level.loot_spawner.loot_tables[ key ] ) )
    {
        level.loot_spawner.loot_tables[ key ] = function_943aeb9e803dfd81( key, loottable );
        return;
    }
    
    assertmsg( "<dev string:x49>" + key + "<dev string:x6c>" );
}

// Namespace loot_spawner
// Params 2
// Checksum 0x2d937aed, Offset: 0x3ea
// Size: 0x53
function function_5a0bfef63c36a0f4( var_2ff8bbef64c7623c, var_65190659fbf3007a )
{
    if ( function_9cf6c013dce1b511( var_2ff8bbef64c7623c ) )
    {
        return;
    }
    
    if ( isdefined( level.loot_spawner.loot_tables[ var_2ff8bbef64c7623c ] ) )
    {
        level.loot_spawner.loot_tables[ var_2ff8bbef64c7623c ] = var_65190659fbf3007a;
    }
}

// Namespace loot_spawner
// Params 3
// Checksum 0x3c3cfc94, Offset: 0x445
// Size: 0xba
function function_61097f383bcc8ca0( key, itemid, spawnratio )
{
    if ( function_9cf6c013dce1b511( key ) )
    {
        return;
    }
    
    loot_table = level.loot_spawner.loot_tables[ key ];
    
    if ( !isdefined( loot_table[ itemid ] ) )
    {
        level.loot_spawner.original_tables[ key ][ itemid ] = spawnratio;
        level.loot_spawner.loot_tables[ key ] = function_943aeb9e803dfd81( key, level.loot_spawner.original_tables[ key ] );
        return;
    }
    
    assertmsg( itemid + "<dev string:x8d>" + key );
}

// Namespace loot_spawner
// Params 2
// Checksum 0x1509af6a, Offset: 0x507
// Size: 0xae
function function_517bb8cee555a903( key, itemid )
{
    if ( function_9cf6c013dce1b511( key ) )
    {
        return;
    }
    
    loot_table = level.loot_spawner.loot_tables[ key ];
    
    if ( isdefined( loot_table[ itemid ] ) )
    {
        level.loot_spawner.original_tables[ key ][ itemid ] = undefined;
        level.loot_spawner.loot_tables[ key ] = function_943aeb9e803dfd81( key, level.loot_spawner.original_tables[ key ] );
        return;
    }
    
    assertmsg( itemid + "<dev string:xac>" + key );
}

// Namespace loot_spawner
// Params 1
// Checksum 0x113fd7c9, Offset: 0x5bd
// Size: 0x2e
function function_47a3724edb6e958( key )
{
    if ( function_9cf6c013dce1b511( key ) )
    {
        return;
    }
    
    return level.loot_spawner.loot_tables[ key ];
}

// Namespace loot_spawner
// Params 1
// Checksum 0xdfb0ddd8, Offset: 0x5f4
// Size: 0x23, Type: bool
function function_388071020425b737( key )
{
    return isdefined( level.loot_spawner.loot_tables[ key ] );
}

// Namespace loot_spawner
// Params 5
// Checksum 0xcd9497e9, Offset: 0x620
// Size: 0x2a2
function function_13712906c9c40ca5( var_ce15b958527969cb, position, spawncount, spawnvfx, args )
{
    if ( function_9cf6c013dce1b511( var_ce15b958527969cb ) )
    {
        return;
    }
    
    loot_table = function_47a3724edb6e958( var_ce15b958527969cb );
    lootinfo = spawnstruct();
    lootinfo.dropcount = randomintrange( 1, 10 );
    lootinfo.heightoffset = 0;
    lootinfo.origin = position;
    
    if ( isstring( spawnvfx ) )
    {
    }
    else if ( spawnvfx )
    {
        playfx( utility::getfx( "vfx_golden_loot_explosion_flare" ), position );
    }
    
    for ( i = 0; i < spawncount ; i++ )
    {
        random_value = randomfloat( 1 );
        
        foreach ( key, entry in loot_table )
        {
            entry_floor_value = entry[ 2 ];
            entry_ceil_value = entry[ 3 ];
            
            if ( random_value >= entry_floor_value && random_value <= entry_ceil_value )
            {
                switch ( key )
                {
                    case #"hash_637736d2cc79a66a":
                        continue;
                    case #"hash_414a0057bc9c9914":
                        if ( !isdefined( args ) )
                        {
                            assert( isdefined( args[ "<dev string:xcc>" ] ), "<dev string:xd6>" );
                            continue;
                        }
                        
                        if ( !isdefined( args[ "eAttacker" ] ) )
                        {
                            assert( isdefined( args[ "<dev string:xcc>" ] ), "<dev string:x123>" );
                            continue;
                        }
                        
                        attacker = args[ "eAttacker" ];
                        weapon_class_killed_by = undefined;
                        
                        if ( isplayer( attacker ) || isbot( attacker ) || isagent( attacker ) )
                        {
                            weapon_class_killed_by = weaponclass( args[ "eAttacker" ] getcurrentweapon() );
                        }
                        
                        if ( !isdefined( weapon_class_killed_by ) )
                        {
                            continue;
                        }
                        
                        lootinfo.item = level.loot_spawner.ammo_types[ weapon_class_killed_by ];
                        
                        if ( !isdefined( lootinfo.item ) )
                        {
                            continue;
                        }
                        
                        break;
                    default:
                        lootinfo.item = key;
                        break;
                }
                
                lootinfo.dropcount += 2;
                thread spawnloot( lootinfo );
                waitframe();
            }
        }
    }
}

// Namespace loot_spawner
// Params 1
// Checksum 0x7e2d736f, Offset: 0x8ca
// Size: 0x3b, Type: bool
function function_9cf6c013dce1b511( key )
{
    if ( !isdefined( level.loot_spawner.loot_tables[ key ] ) )
    {
        assertmsg( "<dev string:x17b>" + key );
        return true;
    }
    
    return false;
}

// Namespace loot_spawner
// Params 1
// Checksum 0x3baa5a2e, Offset: 0x90e
// Size: 0x98
function spawnloot( lootinfo )
{
    itemname = lootinfo.item;
    spawnposition = lootinfo.origin + ( 0, 0, lootinfo.heightoffset );
    angles = ( 0, 0, 0 );
    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( spawnposition, angles );
    common_item::items_spawnitemfromscriptable( itemname, 1, spawnoptions );
    lootinfo.heightoffset += 3;
}

// Namespace loot_spawner
// Params 2
// Checksum 0xb7bc8ddc, Offset: 0x9ae
// Size: 0x1e0
function function_943aeb9e803dfd81( loot_table_key_name, loot_table )
{
    loot_table_entry = [];
    total_value = 0;
    
    foreach ( value in loot_table )
    {
        total_value += value;
    }
    
    index = 0;
    loot_table_key = getarraykeys( loot_table );
    previous_key = undefined;
    
    /#
        iprintln( "<dev string:x197>" );
        iprintln( "<dev string:x1c7>" + loot_table_key_name );
    #/
    
    foreach ( key, value in loot_table )
    {
        loot_table_entry[ key ] = [];
        normalized_value = value / total_value;
        
        if ( index == 0 )
        {
            floor_value = 0;
            ceil_value = normalized_value;
        }
        else
        {
            floor_value = previous_key[ 3 ];
            ceil_value = floor_value + normalized_value;
        }
        
        loot_table_entry[ key ] = [ value, normalized_value, floor_value, ceil_value ];
        previous_key = loot_table_entry[ key ];
        
        /#
            iprintln( key + "<dev string:x1d4>" + loot_table_entry[ key ][ 1 ] );
        #/
        
        index++;
    }
    
    /#
        iprintln( "<dev string:x197>" );
    #/
    
    level.loot_spawner.original_tables[ loot_table_key_name ] = loot_table;
    return loot_table_entry;
}

