// scripts\mp\scavenger_bag.gsc  (hash_6871428755a3f5b5.gscc) (size: 7564 Bytes / 0x1d8c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa3462290 (2739282576)
// size ...... 7564 (0x1d8c)
// includes .. 8   (offset: 0x1ce0)
// strings ... 6   (offset: 0x1d20)
// dev strs .. 0   (offset: 0x1d8c)
// exports ... 14  (offset: 0x1498)
// cseg ...... 0x165 + 0x1333 (0x1498)
// imports ... 50  (offset: 0x16c8)
// animtree1 . 0   (offset: 0x1d8c)
// animtree2 . 0   (offset: 0x1d8c)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_ammo;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\loot\common_item_equipment;

#namespace scavenger_bag;

// Namespace scavenger_bag
// Params 0, eflags: 0x1
// Checksum 0x2a04290b, Offset: 0x183
// Size: 0xba
function autoexec init()
{
    if ( !common_item::items_isenabled() || getdvarint( @"hash_8e3def3daee1ae72", 0 ) )
    {
        return;
    }
    
    level.var_342a06ce4c8ccba1 = &function_cb0fb0fd1db1de62;
    utility::registersharedfunc( #"scavenger_bag", #"cleanup", &cleanup );
    utility::registersharedfunc( #"scavenger_bag", #"onscavengerbagpickup", &onscavengerbagpickup );
    utility::registersharedfunc( getxhash( "specialty_scavenger" ), #"dropscavengerfordeath", &function_cb0fb0fd1db1de62 );
    utility::registersharedfunc( getxhash( "specialty_scavenger" ), #"hash_4616a839d704d298", &function_a154fb0a7619a5bb );
    callback::add( #"player_death", &onplayerkilled );
}

// Namespace scavenger_bag
// Params 1
// Checksum 0xc9176a8, Offset: 0x245
// Size: 0xc6
function onplayerkilled( params )
{
    victim = params.victim;
    attacker = params.attacker;
    
    if ( !isplayer( victim ) || !isplayer( attacker ) || attacker.team == victim.team )
    {
        return;
    }
    
    bundle = function_644b710c85e33afa();
    
    if ( isdefined( attacker.perks[ "specialty_scavenger" ] ) || !bundle.rewarddata.var_e4e5e6d3cf8179f3 )
    {
        return;
    }
    
    victim utility::callsharedfunc( getxhash( "specialty_scavenger" ), #"hash_4616a839d704d298", attacker );
}

// Namespace scavenger_bag
// Params 1, eflags: 0x4
// Checksum 0x283343e3, Offset: 0x313
// Size: 0xdf
function private function_a154fb0a7619a5bb( attacker )
{
    victim = self;
    teammates = teams::getteamdata( attacker.team, "players" );
    
    foreach ( player in teammates )
    {
        if ( player == attacker )
        {
            continue;
        }
        
        if ( isdefined( player.perks[ "specialty_scavenger" ] ) && arraycontains( victim.attackers, player ) )
        {
            victim function_cb0fb0fd1db1de62( player );
            return;
        }
    }
}

// Namespace scavenger_bag
// Params 1, eflags: 0x4
// Checksum 0xe3f9d371, Offset: 0x3fa
// Size: 0xb4
function private function_644b710c85e33afa( player )
{
    if ( isdefined( level.perkbundles ) )
    {
        foreach ( perk, bundle in level.perkbundles )
        {
            if ( bundle.var_2ec7d9c3b596a87e && ( !player || isdefined( player.perks[ perk ] ) ) )
            {
                return bundle;
            }
        }
    }
}

// Namespace scavenger_bag
// Params 1
// Checksum 0x40dcb91, Offset: 0x4b6
// Size: 0x194
function function_cb0fb0fd1db1de62( attacker )
{
    spawnoptions = utility::callsharedfunc( #"game", #"initSpawnOptions_SpawnFromEntity", self );
    bundle = function_644b710c85e33afa( attacker );
    
    if ( bundle.rewarddata.var_e086d4b706035099 )
    {
        spawnoptions.var_c580c0e8b49f1fcc = 1;
        spawnoptions.var_4a4b419f66681601 = teams::getteamdata( attacker.team, "players" );
    }
    else
    {
        spawnoptions.payload = [ #"teamselect", attacker getentitynumber() ];
    }
    
    result = utility::callsharedfunc( #"game", #"spawnItemFromScriptable", bundle.rewarddata.var_fda77272ae10e333 ?? "brloot_scavenger_bag", 1, spawnoptions );
    
    if ( isarray( result ) )
    {
        foreach ( dropbag in result )
        {
            dropbag.bundle = bundle;
        }
    }
    else
    {
        result.owningplayer = attacker;
        result.bundle = bundle;
    }
    
    return result;
}

// Namespace scavenger_bag
// Params 1
// Checksum 0xa47987c3, Offset: 0x653
// Size: 0x7ba
function onscavengerbagpickup( bag )
{
    self endon( #"death_or_disconnect" );
    
    if ( bag.pickedup )
    {
        return;
    }
    
    bag.pickedup = 1;
    itembundle = bag.bundle ?? function_644b710c85e33afa();
    
    if ( isdefined( itembundle ) && isdefined( itembundle.rewarddata ) )
    {
        var_2d20018660eead01 = [];
        
        if ( isdefined( itembundle.rewarddata.var_63d188fd529a1f09 ) )
        {
            foreach ( ammorefill in itembundle.rewarddata.var_63d188fd529a1f09 )
            {
                if ( !isdefined( ammorefill.count ) || ammorefill.count <= 0 )
                {
                    continue;
                }
                
                switch ( ammorefill.ammotype )
                {
                    case #"hash_a19a4ba6a7f2411e":
                        if ( isvalidprimaryweapon( self.currentweapon ) )
                        {
                            weapon = self.currentweapon;
                            ammotype = item_ammo::function_b162feeed34a4640( weapon );
                            
                            if ( isdefined( ammotype ) && isdefined( weapon.clipsize ) )
                            {
                                var_8bb1b2bde27b267c = weapon.clipsize * ammorefill.count;
                                ammobundle = getscriptbundle( common_item_database::function_ca9ca606e66b5911( ammotype ) );
                                itemdata = [ ammobundle, var_8bb1b2bde27b267c, ammorefill.var_b75330c59c068662 ];
                                var_2d20018660eead01[ var_2d20018660eead01.size ] = itemdata;
                            }
                        }
                        
                        break;
                    case #"hash_3c1b790a8a5e1169":
                        foreach ( weapon in self.primaryweapons )
                        {
                            if ( isvalidprimaryweapon( weapon ) )
                            {
                                ammotype = item_ammo::function_b162feeed34a4640( weapon );
                                
                                if ( isdefined( ammotype ) && isdefined( weapon.clipsize ) )
                                {
                                    var_8bb1b2bde27b267c = weapon.clipsize * ammorefill.count;
                                    ammobundle = getscriptbundle( common_item_database::function_ca9ca606e66b5911( ammotype ) );
                                    itemdata = [ ammobundle, var_8bb1b2bde27b267c, ammorefill.var_b75330c59c068662 ];
                                    var_2d20018660eead01[ var_2d20018660eead01.size ] = itemdata;
                                }
                            }
                        }
                        
                        break;
                    case #"hash_80c875d361ce65d4":
                        if ( isdefined( self.primaryweaponobj ) && isvalidprimaryweapon( weapon ) )
                        {
                            weapon = self.primaryweaponobj;
                            ammotype = item_ammo::function_b162feeed34a4640( weapon );
                            
                            if ( isdefined( ammotype ) && isdefined( weapon.clipsize ) )
                            {
                                var_8bb1b2bde27b267c = weapon.clipsize * ammorefill.count;
                                ammobundle = getscriptbundle( common_item_database::function_ca9ca606e66b5911( ammotype ) );
                                var_2d20018660eead01[ var_2d20018660eead01.size ] = [ ammobundle, var_8bb1b2bde27b267c, ammorefill.var_b75330c59c068662 ];
                            }
                        }
                    case #"hash_511d3c24fcedcdb1":
                        if ( isdefined( self.secondaryweaponobj ) )
                        {
                            weapon = self.secondaryweaponobj;
                            ammotype = item_ammo::function_b162feeed34a4640( weapon );
                            
                            if ( isdefined( ammotype ) && isdefined( weapon.clipsize ) )
                            {
                                var_8bb1b2bde27b267c = weapon.clipsize * ammorefill.count;
                                ammobundle = getscriptbundle( common_item_database::function_ca9ca606e66b5911( ammotype ) );
                                var_2d20018660eead01[ var_2d20018660eead01.size ] = [ ammobundle, var_8bb1b2bde27b267c, ammorefill.var_b75330c59c068662 ];
                            }
                        }
                        
                        break;
                    case #"hash_339227cb650975db":
                    case #"hash_850999d7864fa3b4":
                        bundle = undefined;
                        equipdata = item_equipment::function_ba3a484954eaadec( item_equipment::get_equipment_slot( ammorefill.ammotype ) );
                        
                        if ( isdefined( equipdata ) )
                        {
                            bundle = getscriptbundle( equipdata.name );
                        }
                        
                        if ( isdefined( bundle ) && !istrue( bundle.var_2b0a27d4be7d298b ) )
                        {
                            itemdata = [ bundle, ammorefill.count, ammorefill.var_b75330c59c068662 ];
                            var_2d20018660eead01[ var_2d20018660eead01.size ] = itemdata;
                        }
                        
                        break;
                }
            }
        }
        
        if ( itembundle.rewarddata.itemrewards.size > 0 )
        {
            foreach ( reward in itembundle.rewarddata.itemrewards )
            {
                if ( isdefined( reward.lootitem ) && reward.count > 0 )
                {
                    bundle = getscriptbundle( reward.lootitem );
                    
                    if ( isdefined( bundle ) )
                    {
                        itemdata = [ bundle, reward.count, reward.var_b75330c59c068662 ];
                        var_2d20018660eead01[ var_2d20018660eead01.size ] = itemdata;
                    }
                }
            }
        }
        
        if ( var_2d20018660eead01.size > 0 )
        {
            var_91895ad8999914a0 = [];
            
            foreach ( arr in var_2d20018660eead01 )
            {
                bundle = arr[ 0 ];
                count = arr[ 1 ] ?? 0;
                overflow = arr[ 2 ];
                fakeitem = { #count:count, #type:bundle.scriptable };
                remainder = common_item::function_3f39e7be347cf7e1( bundle, fakeitem ) ?? 0;
                pickupcount = max( 0, count - remainder );
                
                if ( pickupcount <= 0 )
                {
                    pickupcount = common_inventory::function_7995ab7f567ba9d3( fakeitem, 0, 1 );
                    
                    if ( !isdefined( pickupcount ) )
                    {
                        pickupcount = 0;
                        name = bundle.scriptable ?? "none";
                        logstring( "Scavenger: undefined pickupCount for scriptable " + name );
                    }
                    
                    remainder = count - pickupcount;
                }
                
                if ( pickupcount > 0 )
                {
                    splashdata = [ bundle, pickupcount ];
                    var_91895ad8999914a0[ var_91895ad8999914a0.size ] = splashdata;
                }
                
                if ( remainder > 0 )
                {
                    toinventory = 0;
                    dropexcess = 0;
                    
                    switch ( overflow )
                    {
                        case #"hash_db653a4972b3c13b":
                            break;
                        case #"hash_5c4ac568e3fece4c":
                            if ( common_inventory::inventory_isenabled() )
                            {
                                toinventory = 1;
                                dropexcess = 0;
                            }
                            
                            break;
                        case #"hash_30b20a099c3735ec":
                            toinventory = 0;
                            dropexcess = 1;
                            break;
                        case #"hash_4fcc45434c474e9b":
                            toinventory = common_inventory::inventory_isenabled();
                            dropexcess = 1;
                            break;
                    }
                    
                    if ( toinventory || dropexcess )
                    {
                        function_665d612c9f61f923( bundle, remainder, toinventory, dropexcess );
                    }
                }
            }
        }
        
        function_56a2b3a9fdbdc3df( var_91895ad8999914a0 );
    }
}

// Namespace scavenger_bag
// Params 1, eflags: 0x4
// Checksum 0x9f1f51ab, Offset: 0xe15
// Size: 0xc5, Type: bool
function private isvalidprimaryweapon( weapon )
{
    if ( weapon.type == "none" )
    {
        return false;
    }
    
    if ( isdefined( weapon.attachmentshash ) )
    {
        foreach ( attachment in weapon.attachmentshash )
        {
            if ( attachment == %"backup_pistol" )
            {
                return false;
            }
        }
    }
    
    return weapon.inventorytype == "primary";
}

// Namespace scavenger_bag
// Params 1, eflags: 0x4
// Checksum 0x1e5dee7d, Offset: 0xee3
// Size: 0x184
function private function_56a2b3a9fdbdc3df( var_91895ad8999914a0 )
{
    if ( var_91895ad8999914a0.size > 0 )
    {
        if ( !isdefined( level.var_987dc5e38b12f25a ) )
        {
            level.var_987dc5e38b12f25a = [];
        }
        
        if ( !isdefined( level.var_987dc5e38b12f25a[ self.guid ] ) )
        {
            level.var_987dc5e38b12f25a[ self.guid ] = 0;
        }
        
        for ( quepos = level.var_987dc5e38b12f25a[ self.guid ]; quepos > 0 ; quepos-- )
        {
            self waittill( #"hash_26c2382f01b19365" );
        }
        
        level.var_987dc5e38b12f25a[ self.guid ]++;
        
        foreach ( dataarr in var_91895ad8999914a0 )
        {
            if ( dataarr.size > 0 )
            {
                bundle = dataarr[ 0 ];
                count = dataarr.size > 1 ? int( dataarr[ 1 ] ) : 0;
                item = dataarr.size > 2 ? dataarr[ 2 ] : undefined;
                common_item::function_29cda7adf128f6fb( bundle, count, item );
                waitframe();
            }
        }
        
        level.var_987dc5e38b12f25a[ self.guid ]--;
        self notify( #"hash_26c2382f01b19365" );
    }
}

// Namespace scavenger_bag
// Params 4, eflags: 0x4
// Checksum 0x736b01c8, Offset: 0x106f
// Size: 0x191
function private function_665d612c9f61f923( bundle, quantity, var_b81549fb0b60244b = 1, dropexcess = 1 )
{
    results = spawnstruct();
    remainingcount = quantity;
    itemsgiven = 0;
    itemsdropped = 0;
    
    if ( remainingcount > 0 && common_inventory::inventory_isenabled() && var_b81549fb0b60244b )
    {
        lootid = common_item::function_779887309ec71dfe( bundle );
        backpackslot = common_inventory::function_d57aa72eb94634f9( lootid );
        
        if ( isdefined( backpackslot ) )
        {
            slotcount = common_inventory::inventory_getquantityatbackpackindex( backpackslot );
            slotmaxcount = bundle.maxcount;
            var_a246995fe15084fe = min( slotmaxcount - slotcount, remainingcount );
            
            if ( var_a246995fe15084fe > 0 )
            {
                leftover = common_inventory::function_22c912d7a228afd8( backpackslot, lootid, var_a246995fe15084fe, !dropexcess );
                given = var_a246995fe15084fe - leftover;
                itemsgiven += given;
                remainingcount -= given;
            }
        }
    }
    else if ( dropexcess )
    {
        spawnoptions = utility::callsharedfunc( #"game", #"initSpawnOptions_SpawnFromEntity", self );
        common_item::function_61c2c0251e742ffd( bundle, quantity, spawnoptions );
        itemsdropped++;
    }
    
    results.initialcount = quantity;
    results.itemsremaining = remainingcount;
    results.itemsgiven = itemsgiven;
    results.itemsdropped = itemsdropped;
    return results;
}

// Namespace scavenger_bag
// Params 1
// Checksum 0x8359f435, Offset: 0x1209
// Size: 0xe5
function function_ed23732472a234de( player )
{
    playerbags = undefined;
    bundle = function_644b710c85e33afa();
    bagarr = getlootscriptablearray( bundle.rewarddata.var_fda77272ae10e333 ?? "brloot_scavenger_bag" );
    
    if ( bagarr.size > 0 )
    {
        foreach ( bag in bagarr )
        {
            if ( bag.owningplayer == player )
            {
                if ( !isdefined( playerbags ) )
                {
                    playerbags = [];
                }
                
                playerbags[ playerbags.size ] = bag;
            }
        }
    }
    
    return playerbags;
}

// Namespace scavenger_bag
// Params 1
// Checksum 0xee13d486, Offset: 0x12f7
// Size: 0x15
function function_b850b688c5fb69cc( bag )
{
    common_item::function_869d7676e359a627( bag );
}

// Namespace scavenger_bag
// Params 0
// Checksum 0x35810381, Offset: 0x1314
// Size: 0xa1
function function_b92932510eae5a66()
{
    level endon( #"game_ended" );
    
    if ( isplayer( self ) )
    {
        bagarr = function_ed23732472a234de( self );
        
        if ( bagarr.size > 0 )
        {
            foreach ( bag in bagarr )
            {
                function_b850b688c5fb69cc( bag );
            }
        }
    }
}

// Namespace scavenger_bag
// Params 0
// Checksum 0x71820473, Offset: 0x13bd
// Size: 0xdb
function cleanup()
{
    bundle = function_644b710c85e33afa( self );
    
    if ( bundle.rewarddata.var_e086d4b706035099 )
    {
        teammates = teams::getteamdata( self.team, "players" );
        
        foreach ( player in teammates )
        {
            if ( !isdefined( player.perks[ "specialty_scavenger" ] ) )
            {
                player function_b92932510eae5a66();
            }
        }
        
        return;
    }
    
    function_b92932510eae5a66();
}

