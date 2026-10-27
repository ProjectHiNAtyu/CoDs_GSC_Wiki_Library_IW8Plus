// scripts\mp\zm\systems\weapons\zm_blackhole_bomb.gsc  (hash_515fd7416398bedb.gscc) (size: 2870 Bytes / 0xb36 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb9664498 (3110487192)
// size ...... 2870 (0xb36)
// includes .. 4   (offset: 0xaf2)
// strings ... 2   (offset: 0xb12)
// dev strs .. 1   (offset: 0xb2a)
// exports ... 8   (offset: 0x65e)
// cseg ...... 0x81 + 0x5dd (0x65e)
// imports ... 29  (offset: 0x79e)
// animtree1 . 0   (offset: 0xb36)
// animtree2 . 0   (offset: 0xb36)
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_player;

#namespace zm_blackhole_bomb;

// Namespace zm_blackhole_bomb
// Params 0, eflags: 0x5
// Checksum 0x633ffbb5, Offset: 0x9f
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"zm_blackhole_bomb", #"blackhole_bomb", &main, undefined );
}

// Namespace zm_blackhole_bomb
// Params 0, eflags: 0x4
// Checksum 0x315bf340, Offset: 0xc8
// Size: 0x65
function private main()
{
    level.var_bc75d47c88b4c3cc = 1;
    level.var_3f5d2a9c52592654 = &function_ee48ae614b52e217;
    level.var_38c5fa2d18ab8362 = &function_a2e1984a924f73ee;
    utility::registersharedfunc( #"zm_blackhole_bomb", #"hash_a036ff8b4156ec99", &function_2a49f9fa9277a208 );
    utility::registersharedfunc( #"zm_blackhole_bomb", #"hash_c75006e0ddcb3da4", &function_bcfc2c555363a3b5 );
}

// Namespace zm_blackhole_bomb
// Params 1
// Checksum 0xf7df1a24, Offset: 0x135
// Size: 0x6d
function function_2a49f9fa9277a208( destination_zones )
{
    if ( isarray( destination_zones ) )
    {
        if ( isplayer( self ) )
        {
            self.var_18b16b62bdc6de6c = destination_zones;
        }
        else
        {
            level.var_18b16b62bdc6de6c = destination_zones;
        }
        
        return;
    }
    
    if ( isstring( destination_zones ) )
    {
        if ( isplayer( self ) )
        {
            self.var_18b16b62bdc6de6c = [ destination_zones ];
            return;
        }
        
        level.var_18b16b62bdc6de6c = [ destination_zones ];
    }
}

// Namespace zm_blackhole_bomb
// Params 0
// Checksum 0xafcaed37, Offset: 0x1aa
// Size: 0x21
function function_bcfc2c555363a3b5()
{
    if ( isplayer( self ) )
    {
        self.var_18b16b62bdc6de6c = undefined;
        return;
    }
    
    level.var_18b16b62bdc6de6c = undefined;
}

// Namespace zm_blackhole_bomb
// Params 1, eflags: 0x4
// Checksum 0xe7805971, Offset: 0x1d3
// Size: 0x87, Type: bool
function private function_aa2c8c826e715283( player )
{
    if ( !isplayer( player ) )
    {
        return false;
    }
    
    if ( utility::issharedfuncdefined( #"game", #"isCommonItemEnabled" ) )
    {
        if ( !utility::callsharedfunc( #"game", #"isCommonItemEnabled" ) )
        {
            return false;
        }
        
        return ( utility::issharedfuncdefined( #"game", #"hash_6a1940cb87219089" ) && utility::issharedfuncdefined( #"game", #"getItemBundleNameFromRef" ) );
    }
    
    return false;
}

// Namespace zm_blackhole_bomb
// Params 0, eflags: 0x4
// Checksum 0x82161, Offset: 0x263
// Size: 0x17c
function private function_ee48ae614b52e217()
{
    if ( !isplayer( self.owner ) )
    {
        return;
    }
    
    if ( self.is_free_grenade )
    {
        println( "<dev string:x24>" );
        return;
    }
    
    if ( self.owner utility::ent_flag( "is_usurped_power_grabbed" ) || self.owner.var_87522aee8be7890b.ref || self.owner.var_819dfee5ff9a56d6 )
    {
        return;
    }
    
    if ( isdefined( level.var_6f5cbfe6aee65f4 ) && isdefined( self.equipmentref ) && isdefined( self.owner ) )
    {
        self.owner [[ level.var_6f5cbfe6aee65f4 ]]( self.equipmentref, "secondary", 1 );
        return;
    }
    
    if ( function_aa2c8c826e715283( self.owner ) )
    {
        item_bundle_name = utility::callsharedfunc( #"game", #"getItemBundleNameFromRef", self.equipmentref );
        
        if ( !isdefined( item_bundle_name ) )
        {
            return;
        }
        
        item_bundle = getscriptbundle( item_bundle_name );
        fake_item = spawnstruct();
        fake_item.count = 1;
        fake_item.type = item_bundle.scriptable;
        self.owner utility::callsharedfunc( #"game", #"hash_6a1940cb87219089", fake_item, 0 );
    }
}

// Namespace zm_blackhole_bomb
// Params 1, eflags: 0x4
// Checksum 0xefd7884e, Offset: 0x3e7
// Size: 0x276
function private function_a2e1984a924f73ee( player )
{
    teleport_zones = [];
    current_zone = zone_manager::function_90e5c3e2272b0130( player.origin );
    
    if ( isdefined( player.var_7ab4c9acb317c405 ) )
    {
        return player.var_7ab4c9acb317c405;
    }
    else if ( isdefined( player.var_18b16b62bdc6de6c ) )
    {
        teleport_zones = player.var_18b16b62bdc6de6c;
    }
    else if ( isdefined( level.var_18b16b62bdc6de6c ) )
    {
        teleport_zones = level.var_18b16b62bdc6de6c;
    }
    else if ( isdefined( current_zone ) )
    {
        var_c96b1c3cfbbd6aac = current_zone zone_manager::get_adjacent_zones( 1, 1 );
        teleport_zones = var_c96b1c3cfbbd6aac;
        
        foreach ( var_82733f6af6e5f6d7 in var_c96b1c3cfbbd6aac )
        {
            second_adjacent_zones = var_82733f6af6e5f6d7 zone_manager::get_adjacent_zones( 1, 1 );
            teleport_zones = arraycombineunique( teleport_zones, second_adjacent_zones );
        }
        
        teleport_zones = arrayremove( teleport_zones, current_zone );
    }
    else
    {
        teleport_zones = level zone_manager::get_active_zones();
    }
    
    teleport_zones = arrayrandomize( teleport_zones );
    var_9df8dd0741c4131f = undefined;
    
    foreach ( var_cecc19e6c4d98106 in teleport_zones )
    {
        zone_name = isstring( var_cecc19e6c4d98106 ) ? var_cecc19e6c4d98106 : var_cecc19e6c4d98106.zone_name;
        respawn_groups = zone_manager::function_9dd25e9fb0ecd45b( zone_name );
        
        if ( respawn_groups.size > 0 )
        {
            respawn_group = respawn_groups.size > 1 ? utility::array_random( respawn_groups ) : respawn_groups[ 0 ];
            spawn_location = player zm_player::function_d6478754a8814223( respawn_group );
            
            if ( isdefined( spawn_location ) )
            {
                if ( current_zone && respawn_group.zone_name == current_zone.zone_name )
                {
                    var_9df8dd0741c4131f = spawn_location.origin;
                    continue;
                }
                
                return spawn_location.origin;
            }
        }
    }
    
    return var_9df8dd0741c4131f;
}

