// scripts\mp\ai_loot.gsc  (hash_47921c3b43f0ab85.gscc) (size: 9220 Bytes / 0x2404 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcb2f520a (3408876042)
// size ...... 9220 (0x2404)
// includes .. 15  (offset: 0x2254)
// strings ... 25  (offset: 0x22cc)
// dev strs .. 0   (offset: 0x2404)
// exports ... 20  (offset: 0x16ac)
// cseg ...... 0x1f4 + 0x14b8 (0x16ac)
// imports ... 73  (offset: 0x19cc)
// animtree1 . 0   (offset: 0x2404)
// animtree2 . 0   (offset: 0x2404)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\br\gametypes\br_weapons;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\equipment;
#using scripts\mp\health_chunks;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_ammo;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\overseer;
#using scripts\mp\quick_use;

#namespace ai_loot;

// Namespace ai_loot
// Params 0
// Checksum 0xde5a747f, Offset: 0x212
// Size: 0x2
function function_69b4db6b064345dc()
{
    
}

// Namespace ai_loot
// Params 5
// Checksum 0xe8775675, Offset: 0x21c
// Size: 0x56
function function_452f7cba22550779( agent, var_f2bdcaecc57a341c, count = 1, var_d291ab4f1928dffa = 0, var_18150f14134e2cfd )
{
    function_bd50bceba9111126( agent, function_a8f0840f09bf684c( var_f2bdcaecc57a341c, count, var_d291ab4f1928dffa, var_18150f14134e2cfd ) );
}

// Namespace ai_loot
// Params 2, eflags: 0x4
// Checksum 0x4c8139f4, Offset: 0x27a
// Size: 0x34
function private function_bd50bceba9111126( agent, lootstruct )
{
    lootstruct = arraycombine( agent_utils::function_813fb93fad3172ab( agent ), [ lootstruct ] );
    agent_utils::function_fa8c97ce7495ecaf( agent, lootstruct );
}

// Namespace ai_loot
// Params 1
// Checksum 0x6ced7eda, Offset: 0x2b6
// Size: 0x3dc
function droplootonagentdeath( params )
{
    if ( getdvarint( @"hash_307fc239dc43be41", 0 ) )
    {
        return;
    }
    
    if ( params.smeansofdeath == "MOD_DESPAWN" )
    {
        return;
    }
    
    agent = self;
    
    if ( agent.nocorpse )
    {
        return;
    }
    
    if ( agent.skipdeathcount )
    {
        return;
    }
    
    if ( agent.dontdroploot )
    {
        return;
    }
    
    poiname = agent.poiname;
    killer = params.eattacker;
    agentid = agent.persistent_unique_id;
    agenttype = agent.agent_type;
    var_fa7003f246a2caa = getxhashasset( removesubstr( agenttype, "actor_" ) );
    agentweapon = agent.primaryweapon;
    killerweapon = undefined;
    killerclientnum = undefined;
    
    if ( isplayer( killer ) )
    {
        killerweapon = killer getcurrentweapon();
        killerclientnum = killer getentitynumber();
    }
    
    function_cf0a7d3e120e1d0a( agent, agenttype, agentweapon, killerweapon, undefined, killer, params.smeansofdeath );
    var_e14eeab1434328ea = 0;
    
    foreach ( var_1694b46e375c6a72 in level.gametypebundle.var_d4fb7d0cbe8b9ce9 )
    {
        if ( var_fa7003f246a2caa == var_1694b46e375c6a72.type )
        {
            var_e14eeab1434328ea = 1;
            break;
        }
    }
    
    dropweapon = agent.shoulddropweapon;
    shoulddropweapon = !var_e14eeab1434328ea && ( !isdefined( dropweapon ) || dropweapon );
    
    if ( isdefined( agentweapon ) && !( agentweapon.type == "none" ) && shoulddropweapon )
    {
        weaponinfostruct = spawnstruct();
        weaponinfostruct.ammoclipright = weaponclipsize( agentweapon );
        weaponinfostruct.ammoclipleft = weaponclipsize( agentweapon );
        weaponinfostruct.ammoclipalt = item_weapon::function_dc8d4a742844a795( agentweapon ) ? 0 : weaponclipsize( agentweapon getaltweapon() );
        weaponinfostruct.ammostock = weaponmaxammo( agentweapon );
        spawnoptions = common_item::items_initspawnoptions_spawnfromentity( agent );
        spawnoptions.spawnpositionindex = 1;
        item = item_weapon::function_53da2af5697709f8( agentweapon, weaponinfostruct, spawnoptions );
    }
    
    agentcategory = agent.category;
    
    if ( getdvarint( @"hash_b79ef01dd49b83d2", 0 ) || game_utility::getgametype() == "dmz" )
    {
        if ( !isdefined( level.var_58e7969b033c2b8f ) )
        {
            level.var_58e7969b033c2b8f = getdvarfloat( @"hash_2cac446c3fbe830f", 0 );
        }
        
        if ( randomfloat( 1 ) < level.var_58e7969b033c2b8f && isdefined( agent ) )
        {
            bloodpool = spawnscriptable( "vfx_dmz_blood_pool", agent.origin, agent.angles );
            spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( agent.origin, agent.angles );
            agentradio = namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( "brloot_dead_agent_radio", 1, spawnoptions );
            
            if ( isdefined( agentradio ) )
            {
                agentradio.entitynumber = agent getentitynumber();
                agentradio.poiname = poiname;
                agentradio.droppedteam = agent.agentteam;
                thread overseer::function_ba3ea791538298e5( agentradio );
            }
        }
    }
}

// Namespace ai_loot
// Params 1, eflags: 0x4
// Checksum 0x5d594347, Offset: 0x69a
// Size: 0x22c
function private smartloot( killer )
{
    if ( !isplayer( killer ) )
    {
        return;
    }
    
    if ( !isdefined( killer.smartloot ) )
    {
        killer.smartloot = [];
    }
    
    if ( killer health_chunks::function_57d7450ef7a9c202() && !quick_use::function_33ce1272468894c7( "BANDAGE" ) )
    {
        index = "health";
        
        if ( !isdefined( killer.smartloot[ index ] ) )
        {
            killer.smartloot[ index ] = 0;
        }
        
        killer.smartloot[ index ] += 5;
        
        if ( utility::percent_chance( killer.smartloot[ index ] ) )
        {
            killer.smartloot[ index ] = 0;
            itemlist = common_item::function_3c24841536dc783e( "HEALTH_ITEMS" );
            
            if ( isdefined( itemlist ) )
            {
                return function_c11af7a197679429( itemlist, 1 );
            }
            else
            {
                return;
            }
        }
    }
    
    index = "ammo";
    
    if ( !isdefined( killer.smartloot[ index ] ) )
    {
        killer.smartloot[ index ] = 0;
    }
    
    primary_weapons = killer getweaponslist( "primary" );
    
    foreach ( primary_weapon in primary_weapons )
    {
        currentammo = item_ammo::function_44b52f17768fb1c6( killer, primary_weapon );
        maxstock = killer item_ammo::function_9aecfd8b12f7ed0e( primary_weapon );
        
        if ( currentammo / maxstock < 0.2 )
        {
            killer.smartloot[ index ] += 5;
        }
    }
    
    if ( utility::percent_chance( killer.smartloot[ index ] ) )
    {
        killer.smartloot[ index ] = 0;
        itemlist = common_item::function_3c24841536dc783e( "AMMO_ITEMS" );
        
        if ( isdefined( itemlist ) )
        {
            return function_c11af7a197679429( itemlist, 1 );
        }
        
        return;
    }
}

// Namespace ai_loot
// Params 7, eflags: 0x4
// Checksum 0x228b6f3b, Offset: 0x8cf
// Size: 0x5d4
function private function_cf0a7d3e120e1d0a( agent, agenttype, agentweapon, killerweapon, dropstruct, killer, meansofdeath )
{
    lootpool = function_7dc243c344d79744( agent ) ?? [];
    
    if ( level.var_5e310e55990fb19d )
    {
        var_12fee30c020fef06 = smartloot( killer );
        
        if ( var_12fee30c020fef06 )
        {
            lootpool[ lootpool.size ] = { #count:1, #name:var_12fee30c020fef06[ 0 ] };
        }
    }
    
    items = [];
    spawnoptions = agent.var_1588af4d0f09a140 ? [[ agent.var_1588af4d0f09a140 ]]( agent ) : common_item::items_initspawnoptions_spawnfromentity( agent );
    var_5e76e05112324d92 = agent.var_5e76e05112324d92 ?? 1;
    var_a8ad20d7b22de9a8 = getdvarint( @"hash_df87d80be0df6f2e", var_5e76e05112324d92 );
    var_f3e1c515661e1636 = function_c1b26c964cbabf5d( agent );
    
    if ( isarray( var_f3e1c515661e1636 ) )
    {
        foreach ( scriptablename in var_f3e1c515661e1636 )
        {
            function_452f7cba22550779( agent, scriptablename );
        }
    }
    
    var_ef5c1d36f4119efa = agent.var_ef5c1d36f4119efa;
    
    if ( isdefined( var_ef5c1d36f4119efa ) && var_ef5c1d36f4119efa.size > 0 )
    {
        var_a8ad20d7b22de9a8 = max( var_a8ad20d7b22de9a8, var_ef5c1d36f4119efa.size );
        
        foreach ( lootitem in var_ef5c1d36f4119efa )
        {
            if ( !lootitem.bundlename )
            {
                continue;
            }
            
            if ( lootitem.var_18150f14134e2cfd && ![[ lootitem.var_18150f14134e2cfd ]]( lootitem ) )
            {
                continue;
            }
            
            item = agent function_795ec06f2c4a5ec9( lootitem.bundlename, lootitem.count ?? 1, lootitem.var_d291ab4f1928dffa, spawnoptions, killer );
            
            if ( item )
            {
                items[ items.size ] = item;
            }
        }
    }
    
    if ( !isdefined( level.var_69b45e51990d6138 ) )
    {
        level.var_69b45e51990d6138 = getdvarfloat( @"hash_e0f80a6c5e304fc9", 0 );
    }
    
    dropgrenade = agent.dropgrenade && utility::percent_chance( level.var_69b45e51990d6138 );
    
    if ( dropgrenade && isdefined( agent.grenadeweapon.basename ) )
    {
        var_165b2d4665b86fd7 = agent.grenadeweapon.basename;
        lootpool = function_ca8f8ab8fb7121e8( lootpool, var_165b2d4665b86fd7, agent.grenadeammo );
    }
    
    if ( !isdefined( level.var_4502d54533bb0ddc ) )
    {
        level.var_4502d54533bb0ddc = getdvarfloat( @"hash_e89c546506ea61af", 0 );
    }
    
    lootpool = function_21d6aa0392c54565( lootpool, agentweapon, killerweapon, level.var_4502d54533bb0ddc );
    
    if ( !isdefined( level.var_9117acba7adb0ee0 ) )
    {
        level.var_9117acba7adb0ee0 = getdvarfloat( @"hash_3545ca86ff96cb37", 1 );
    }
    
    if ( !isdefined( level.var_d58b900ae793f5a0 ) )
    {
        level.var_d58b900ae793f5a0 = getdvarint( @"hash_142657a7943b806a", 1 );
    }
    
    if ( var_a8ad20d7b22de9a8 == 0 && randomfloat( 1 ) > level.var_9117acba7adb0ee0 )
    {
        var_a8ad20d7b22de9a8 = int( ceil( 1 / level.var_9117acba7adb0ee0 ) + ( randomfloat( 1 ) < 0.4 ? 1 : 0 ) );
    }
    
    if ( isplayer( killer ) && isdefined( killer.perks[ "specialty_trait_ai_loot" ] ) && isdefined( level.perkbundles[ "specialty_trait_ai_loot" ] ) )
    {
        perkbundle = level.perkbundles[ "specialty_trait_ai_loot" ];
        
        if ( perkbundle.var_d977921acc2c9046 )
        {
            var_42315794e4ba84d9 = function_c11af7a197679429( perkbundle.var_d977921acc2c9046, 1 );
            
            if ( var_42315794e4ba84d9 )
            {
                foreach ( itemname in var_42315794e4ba84d9 )
                {
                    lootpool[ lootpool.size ] = { #name:itemname };
                }
            }
        }
    }
    
    if ( lootpool.size > 0 )
    {
        lootpool = arrayrandomize( lootpool );
        
        for ( i = 0; i < lootpool.size ; i++ )
        {
            data = lootpool[ i ];
            item = agent function_795ec06f2c4a5ec9( data.name, data.count, data.var_d291ab4f1928dffa, spawnoptions, killer );
            
            if ( item )
            {
                items[ items.size ] = item;
                
                if ( items.size >= var_a8ad20d7b22de9a8 )
                {
                    break;
                }
            }
        }
    }
    
    if ( items.size > 0 || self.backpack )
    {
        agent callback::callback( #"hash_21a45497e0cfe5a8", { #agent:self, #meansofdeath:meansofdeath, #killer:killer, #items:items } );
    }
}

// Namespace ai_loot
// Params 5
// Checksum 0xcd41d031, Offset: 0xeab
// Size: 0x25a
function function_795ec06f2c4a5ec9( bundlename, count, var_d291ab4f1928dffa = 0, spawnoptions, killer )
{
    if ( bundlename == %"hash_711f627a1b1ff5d7" || bundlename == %"hash_399b757e4deba84f" )
    {
        if ( self.var_1b1e8e95a7a7d01b )
        {
            self detach( "hat_child_hadir_gas_mask_wm_br", "j_head" );
        }
        
        self.radimmune = 0;
        self.var_1e2afba6dedb6c52 = 0;
        callback::callback( #"gasmask_dropped", { #attackers:self.attackerdata, #agenttier:self.tier } );
    }
    
    if ( level.var_d58b900ae793f5a0 && !self.var_15841f4e32e933a6 || var_d291ab4f1928dffa )
    {
        item = common_item::function_61c2c0251e742ffd( bundlename, count, spawnoptions );
        
        if ( item )
        {
            item.aidropped = 1;
            itembundle = common_item::function_6b8ff3d5f2688336( item );
            typeref = common_item::function_16e8c106491eeaca( itembundle );
            
            if ( itembundle.rarity >= 1 && typeref != "weapon" || typeref == "lethal" || typeref == "tactical" || typeref == "super" || typeref == "backpack_consumable" )
            {
                item thread common_item::function_5ce7004ad09f0dce( #"ai_drop" );
                
                if ( isplayer( killer ) && soundexists( "uin_dmz_valuable_loot_drop" ) )
                {
                    self playsoundtoplayer( "uin_dmz_valuable_loot_drop", killer );
                }
            }
            
            return item;
        }
        
        return;
    }
    
    if ( !isdefined( self.backpack ) )
    {
        spawnoptions.var_a8cf639dcda6a7e5 = undefined;
        positioningresults = common_item::function_d94b7cedcd3ae9d0( spawnoptions );
        self.backpack = spawnscriptable( "agent_backpack", positioningresults.finalorigin, positioningresults.finalangles, undefined, positioningresults.payload );
        self.backpack setscriptablepartstate( self.backpack function_84ad2f70189ee7c3(), "dropped" );
        self.backpack.contents = [];
    }
    
    common_cache::cache_additem( self.backpack, bundlename, count, 1 );
}

// Namespace ai_loot
// Params 1, eflags: 0x4
// Checksum 0x7444fb67, Offset: 0x110d
// Size: 0xb8
function private function_7dc243c344d79744( agent )
{
    tier = agent.tier ?? 0;
    list = agent.var_50e1da833a37c346 ?? level.gametypebundle.var_b8e070ed4786781c[ tier ].list;
    num = agent.var_5e76e05112324d92 ?? 1;
    lootpool = function_c11af7a197679429( list, num );
    
    for ( i = 0; i < lootpool.size ; i++ )
    {
        lootpool[ i ] = { #name:lootpool[ i ] };
    }
    
    return lootpool;
}

// Namespace ai_loot
// Params 3, eflags: 0x4
// Checksum 0x2be51ded, Offset: 0x11ce
// Size: 0x72
function private function_ca8f8ab8fb7121e8( lootpool, grenadetype, grenadecount )
{
    if ( grenadecount > 0 )
    {
        grenadecount = int( min( grenadecount, 2 ) );
        grenaderef = equipment_mp::function_fdc4a655fbde0dec( grenadetype );
        
        if ( isdefined( grenaderef ) )
        {
            lootpool[ lootpool.size ] = { #count:grenadecount, #name:common_item_database::function_a4f0a21951180013( grenaderef ) };
        }
    }
    
    return lootpool;
}

// Namespace ai_loot
// Params 4, eflags: 0x4
// Checksum 0x1a6285bf, Offset: 0x1249
// Size: 0xa2
function private function_21d6aa0392c54565( lootpool, agentweapon, killerweapon, chance )
{
    if ( !isdefined( agentweapon ) )
    {
        return lootpool;
    }
    
    if ( isdefined( chance ) && !utility::percent_chance( chance ) )
    {
        return lootpool;
    }
    
    scriptable = br_weapons::br_ammo_type_for_weapon( agentweapon );
    
    if ( isdefined( killerweapon ) && ( !isdefined( scriptable ) || utility::cointoss() ) )
    {
        scriptable = br_weapons::br_ammo_type_for_weapon( killerweapon ) ?? scriptable;
    }
    
    if ( isdefined( scriptable ) )
    {
        lootpool[ lootpool.size ] = { #name:common_item_database::function_ca9ca606e66b5911( scriptable ) };
    }
    
    return lootpool;
}

// Namespace ai_loot
// Params 2, eflags: 0x4
// Checksum 0x3c8cfddd, Offset: 0x12f4
// Size: 0x49
function private function_2e54941fa8ad6bed( lootpool, armorPlateCount )
{
    lootpool[ lootpool.size ] = { #count:armorPlateCount, #name:common_item_database::function_a4f0a21951180013( level.armorref ?? "equip_armorplate" ) };
    return lootpool;
}

// Namespace ai_loot
// Params 2, eflags: 0x4
// Checksum 0x336cdb33, Offset: 0x1346
// Size: 0x4d
function private function_372b5a3171d4ae66( agent, agenttype )
{
    tier = agent.tier;
    
    if ( issubstr( agenttype, "jugg" ) )
    {
        return 3;
    }
    else if ( tier > 1 )
    {
        return 2;
    }
    
    return 1;
}

// Namespace ai_loot
// Params 4, eflags: 0x4
// Checksum 0x88b291fe, Offset: 0x139c
// Size: 0x9a
function private function_a8f0840f09bf684c( var_f2bdcaecc57a341c, count, var_d291ab4f1928dffa, var_18150f14134e2cfd )
{
    struct = spawnstruct();
    
    if ( isxhashasset( var_f2bdcaecc57a341c ) )
    {
        struct.bundlename = var_f2bdcaecc57a341c;
    }
    else
    {
        struct.bundlename = common_item_database::function_ca9ca606e66b5911( var_f2bdcaecc57a341c );
    }
    
    struct.count = count ?? 1;
    struct.var_d291ab4f1928dffa = var_d291ab4f1928dffa ?? 0;
    struct.var_18150f14134e2cfd = var_18150f14134e2cfd;
    return struct;
}

// Namespace ai_loot
// Params 1, eflags: 0x4
// Checksum 0x3e34959c, Offset: 0x143f
// Size: 0x8d
function private function_fbf086ae2628c1ee( var_f82a23bd698da415 )
{
    result = 0;
    gametype = game_utility::getgametype();
    
    switch ( gametype )
    {
        case #"hash_f4afff6c03d92aa0":
            result = function_bd1b12ca929bcc66( var_f82a23bd698da415 );
            break;
        case #"hash_3c1c1566d7b3b870":
        case #"hash_dddecc2751311914":
        case #"hash_fa21c4f6bd5e3815":
            result = function_bc08972c02e0fed3( var_f82a23bd698da415 );
            break;
        default:
            return 0;
    }
    
    return result;
}

// Namespace ai_loot
// Params 1, eflags: 0x4
// Checksum 0x203cbcd4, Offset: 0x14d5
// Size: 0xe4, Type: bool
function private function_bd1b12ca929bcc66( var_f82a23bd698da415 )
{
    if ( getdvarint( @"hash_8fbb625100a40644", 1 ) == 0 )
    {
        return false;
    }
    
    if ( !isdefined( level.var_abc48709bc4e3298 ) )
    {
        level.var_abc48709bc4e3298 = 1;
    }
    
    if ( !isdefined( level.var_49fa36115b11c5b5 ) )
    {
        level.var_49fa36115b11c5b5 = function_11175d04b1a05e32( level.var_abc48709bc4e3298 );
    }
    
    if ( var_f82a23bd698da415 )
    {
        level.var_49fa36115b11c5b5 -= 3;
    }
    else
    {
        level.var_49fa36115b11c5b5 -= 1;
    }
    
    if ( level.var_49fa36115b11c5b5 <= 0 )
    {
        if ( level.var_abc48709bc4e3298 < level.var_85b3b139b14e4343 )
        {
            level.var_abc48709bc4e3298 += 1;
        }
        
        level.var_49fa36115b11c5b5 = function_11175d04b1a05e32( level.var_abc48709bc4e3298 );
        return true;
    }
    
    return false;
}

// Namespace ai_loot
// Params 1, eflags: 0x4
// Checksum 0xefaaa830, Offset: 0x15c2
// Size: 0xd, Type: bool
function private function_bc08972c02e0fed3( var_f82a23bd698da415 )
{
    return false;
}

// Namespace ai_loot
// Params 1, eflags: 0x4
// Checksum 0x351a2333, Offset: 0x15d8
// Size: 0x1a
function private function_11175d04b1a05e32( multiplier )
{
    return randomintrange( 3 * multiplier, 5 * multiplier );
}

// Namespace ai_loot
// Params 1
// Checksum 0x42cad9ce, Offset: 0x15fb
// Size: 0x6f
function function_c1b26c964cbabf5d( agent )
{
    if ( !isdefined( agent.subarea.poiname ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_8f31b53d7109a0b7[ agent.subarea.poiname ] ) )
    {
        return;
    }
    
    return [[ level.var_8f31b53d7109a0b7[ agent.subarea.poiname ] ]]( agent );
}

// Namespace ai_loot
// Params 2
// Checksum 0x953e105f, Offset: 0x1673
// Size: 0x39
function function_f894c641b3ccb9cc( poiname, function )
{
    if ( !isdefined( level.var_8f31b53d7109a0b7 ) )
    {
        level.var_8f31b53d7109a0b7 = [];
    }
    
    level.var_8f31b53d7109a0b7[ poiname ] = function;
}

