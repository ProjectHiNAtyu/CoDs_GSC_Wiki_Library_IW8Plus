// scripts\mp\gametypes\dead_drop.gsc  (hash_2cc6455920627806.gscc) (size: 9867 Bytes / 0x268b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8a981ac7 (2325224135)
// size ...... 9867 (0x268b)
// includes .. 17  (offset: 0x2497)
// strings ... 18  (offset: 0x251f)
// dev strs .. 6   (offset: 0x262b)
// exports ... 12  (offset: 0x196b)
// cseg ...... 0x1ba + 0x17b1 (0x196b)
// imports ... 78  (offset: 0x1b4b)
// animtree1 . 0   (offset: 0x268b)
// animtree2 . 0   (offset: 0x268b)
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_default_inventory;
#using scripts\mp\br\gametypes\br_instance_inventory;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\pickups_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\flags;
#using scripts\mp\gametypes\extraction_container;
#using scripts\mp\loot;
#using scripts\mp\pickups_scriptable;
#using scripts\mp\poi;

#namespace dead_drop;

// Namespace dead_drop
// Params 0
// Checksum 0xc3a998fb, Offset: 0x1d8
// Size: 0x43a
function init_dead_drop()
{
    if ( getdvarint( @"scr_dmz_dead_drop_enabled", 1 ) == 0 )
    {
        return;
    }
    
    scriptable::scriptable_addusedcallbackbypart( "body_dead_drop", &extraction_container::function_e1dbb4b44225d9a2 );
    utility::flag_wait( "scriptables_ready" );
    level.deaddrops = [];
    alldeaddrops = getentitylessscriptablearray( "scriptable_dmz_dead_drop", #classname );
    var_c2acc6e506e2b603 = utility::getstructarray( "dead_drop", "targetname" );
    
    foreach ( deaddrop in var_c2acc6e506e2b603 )
    {
        defname = "dmz_dead_drop";
        
        if ( isdefined( deaddrop.var_2599cb25aa99b093 ) && int( deaddrop.var_2599cb25aa99b093 ) == 1 )
        {
            defname = "dmz_dead_drop_transaction_drawer";
        }
        
        scriptable = spawnscriptable( defname, deaddrop.origin, deaddrop.angles );
        alldeaddrops[ alldeaddrops.size ] = scriptable;
    }
    
    alldeaddrops = arrayrandomize( alldeaddrops );
    deaddropcount = alldeaddrops.size;
    
    if ( level.mapname == "mp_bio_lab" )
    {
        deaddropcount = getdvarint( @"hash_b17c7dabc88f3082", 1 );
    }
    
    if ( game_utility::function_87c1e942653b7c63() )
    {
        var_5d5b333a99febad9 = [ ( 10021, 21237, 308 ), ( 9406, 6453, 354 ), ( 28068, -16832, 627 ), ( -14881, -34634, 530 ), ( -24077, -19468, 396 ), ( -34730, 20647, -397 ) ];
        removedlocs = [];
        
        foreach ( loc in alldeaddrops )
        {
            foreach ( filter in var_5d5b333a99febad9 )
            {
                if ( distancesquared( loc.origin, filter ) < 250000 )
                {
                    pickups::loothide( loc, "body_dead_drop" );
                    removedlocs[ removedlocs.size ] = loc;
                }
            }
        }
        
        alldeaddrops = arrayremove( alldeaddrops, removedlocs );
    }
    
    var_f0bb259933784fe0 = 0;
    
    foreach ( deaddrop in alldeaddrops )
    {
        if ( var_f0bb259933784fe0 >= deaddropcount )
        {
            pickups::loothide( deaddrop, "body_dead_drop" );
            continue;
        }
        
        deaddrop setscriptablepartstate( "body_dead_drop", "closed_usable" );
        deaddrop.usedcallback = &deaddrop_used;
        deaddrop.var_444df56487288e2a = &function_8b9bd0ff7603f401;
        deaddrop.onclosedcallback = &function_eb42502f11f2dd9;
        deaddrop.noweaponslot = !getdvarint( @"hash_6ee9465e13d271e5", 1 );
        level.deaddrops[ level.deaddrops.size ] = deaddrop;
        var_f0bb259933784fe0++;
    }
    
    /#
        thread function_b3cd5eca8243ebf8();
        thread function_76daf2f64012e2cb();
        thread function_62d70f2446b03428( alldeaddrops );
        thread function_b149779b75eea9e6( alldeaddrops );
        thread function_63a895fb3b518c2a();
    #/
    
    utility::flag_set( "dead_drops_init" );
}

// Namespace dead_drop
// Params 6
// Checksum 0x147d29eb, Offset: 0x61a
// Size: 0x7d
function deaddrop_used( instance, part, state, player, bautouse, usestring )
{
    if ( instance getscriptablepartstate( "body_dead_drop" ) != "partially_opening_unusable" )
    {
        instance setscriptablepartstate( "body_dead_drop", "partially_opening_unusable" );
    }
    
    if ( isdefined( instance.var_bcc4c3302aeae433 ) )
    {
        [[ instance.var_bcc4c3302aeae433 ]]( player );
    }
}

// Namespace dead_drop
// Params 7
// Checksum 0x705b4a83, Offset: 0x69f
// Size: 0xcc
function function_8b9bd0ff7603f401( container, player, lootid, quantity, itemtype, itemindex, containerindex )
{
    noextract = undefined;
    callback::callback( "item_added_to_dead_drop", { #lootid:lootid, #deaddrop:container, #player:player } );
    backpackquantity = quantity;
    
    if ( itemtype == 10 )
    {
        backpackquantity = player br_default_inventory::getquantityatbackpackindex( itemindex );
    }
    
    if ( !isdefined( itemtype ) )
    {
        itemtype = 0;
    }
    
    if ( !isdefined( itemindex ) )
    {
        itemindex = 0;
    }
    
    player notify( #"hash_7bc3c8dcaac66cf0", itemtype, itemindex, lootid, backpackquantity );
    return [ lootid, noextract ];
}

// Namespace dead_drop
// Params 2
// Checksum 0xb023bf71, Offset: 0x774
// Size: 0xaa6
function function_eb42502f11f2dd9( container, opener )
{
    container setscriptablepartstate( "body_dead_drop", "partially_closing_unusable" );
    player = opener;
    
    if ( !( isdefined( player ) && isdefined( container ) ) )
    {
        return;
    }
    
    if ( isdefined( container.playeropen[ player.guid ] ) )
    {
        container.playeropen[ player.guid ] = undefined;
    }
    
    var_7561a7f44b738d86 = extraction_container::function_1cf7382eb22db968( container.playercontents[ player.guid ].contents );
    
    if ( isdefined( container.var_77512f5d6b032ab9 ) )
    {
        [[ container.var_77512f5d6b032ab9 ]]( var_7561a7f44b738d86, opener );
    }
    
    totalcash = 0;
    
    foreach ( index, item in var_7561a7f44b738d86 )
    {
        if ( !isdefined( item.lootid ) )
        {
            continue;
        }
        
        ref = loot::function_f54ecb89dfab8e8c( item.lootid );
        scriptableref = level.br_pickups.var_5515c706eaccd3[ ref ];
        itemtype = undefined;
        
        if ( isdefined( scriptableref ) )
        {
            itemtype = level.br_pickups.br_itemtype[ scriptableref ];
        }
        
        if ( isdefined( itemtype ) && !item.noextract )
        {
            if ( itemtype == #"plunder" )
            {
                totalcash += item.quantity;
                continue;
            }
            
            if ( getdvarint( @"hash_6d4fb2de66a0bd7", 1 ) || br_default_inventory::function_387c873743af544a( itemtype ) )
            {
                if ( isdefined( scriptableref ) && isdefined( level.br_pickups.br_value[ scriptableref ] ) )
                {
                    cashvalue = level.br_pickups.br_value[ scriptableref ];
                    quantity = item.quantity;
                    
                    if ( br_pickups::function_bcc6dc9b2b7365e0( item.lootid ) )
                    {
                        quantity = 1;
                    }
                    
                    totalcash += quantity * cashvalue;
                }
            }
        }
    }
    
    weaponitem = undefined;
    
    if ( !container.noweaponslot && !container.playercontents[ player.guid ].var_758b843ffc08c9b2 )
    {
        weaponslotid = player loot_mp::function_6d3e17fbc5d75dde( "loot_container_weapon" );
        
        if ( weaponslotid )
        {
            weaponitem = spawnstruct();
            weaponitem.lootid = weaponslotid;
            weaponitem.quantity = 1;
            weaponitem.pastteam = container.playercontents[ player.guid ].var_d80f548b9b26d1fb;
            var_7561a7f44b738d86[ var_7561a7f44b738d86.size ] = weaponitem;
            totalcash += getdvarint( @"hash_6bf1f5da160e1cc", 400 );
        }
    }
    
    method = 0;
    method = challenges::function_a23641f33e985edb( method, ae_utility::function_2d1565a236387b2( #"loot_method_bitfield", #"dead_drop" ) );
    poi = function_c35deb137e75e1f2( container );
    var_1f5a8342ac4abf70 = 0;
    
    foreach ( index, item in container.playercontents[ player.guid ].contents )
    {
        if ( item[ "lootID" ] == 0 || item[ "quantity" ] == 0 )
        {
            continue;
        }
        
        ref = loot::function_f54ecb89dfab8e8c( item[ "lootID" ] );
        scriptableref = level.br_pickups.var_5515c706eaccd3[ ref ];
        itemtype = undefined;
        
        if ( isdefined( scriptableref ) )
        {
            itemtype = level.br_pickups.br_itemtype_string[ scriptableref ];
        }
        
        if ( !container.playercontents[ player.guid ].contents[ index ][ "noExtract" ] )
        {
            result = challenges::reportlootitemevent( player, container.playercontents[ player.guid ].contents[ index ][ "lootID" ], itemtype, method, container.playercontents[ player.guid ].contents[ index ][ "quantity" ] );
            var_1f5a8342ac4abf70 = result || var_1f5a8342ac4abf70;
            
            if ( !getdvarint( @"hash_6d4fb2de66a0bd7", 1 ) && !result && !br_default_inventory::function_387c873743af544a( itemtype ) )
            {
                continue;
            }
            
            container.playercontents[ player.guid ].contents[ index ][ "lootID" ] = 0;
            container.playercontents[ player.guid ].contents[ index ][ "quantity" ] = 0;
        }
    }
    
    if ( isdefined( weaponitem ) )
    {
        lootsource = 0;
        
        if ( isdefined( weaponitem.pastteam ) && isdefined( player.team ) && weaponitem.pastteam != player.team )
        {
            lootsource = challenges::function_a23641f33e985edb( lootsource, ae_utility::function_2d1565a236387b2( #"loot_source", #"enemy_player" ) );
        }
        
        result = challenges::reportlootitemevent( player, weaponitem.lootid, "weapon", method, weaponitem.quantity, lootsource );
        var_1f5a8342ac4abf70 = result || var_1f5a8342ac4abf70;
        player setclientomnvar( "loot_container_weapon", 0 );
        container.playercontents[ player.guid ].weaponslotcontents = 0;
        container.playercontents[ player.guid ].weaponslotobj = undefined;
        container.playercontents[ player.guid ].var_d80f548b9b26d1fb = undefined;
        container.playercontents[ player.guid ].metadata = undefined;
        container.playercontents[ player.guid ].var_758b843ffc08c9b2 = undefined;
    }
    
    if ( br_instance_inventory::function_926a8f8643d34690() )
    {
        var_2c5706a169373e02 = br_instance_inventory::function_ba4e5cfedfe04b10( player );
        reductionamount = function_53746bc1fffa38f3( totalcash, player );
        
        if ( reductionamount > 0 )
        {
            cooldownratio = br_instance_inventory::function_e78a9f9fcb7496cf();
            scoreoverride = int( getdvarint( @"hash_fabc6973e3e762a1", 200 ) * totalcash / cooldownratio );
            player thread points::doscoreevent( #"dmz_dead_drop", undefined, scoreoverride, scoreoverride );
            
            if ( var_2c5706a169373e02 && !var_1f5a8342ac4abf70 )
            {
                lowestcooldown = br_instance_inventory::function_99a1c747e9d8f29a( player );
                
                if ( !isdefined( lowestcooldown ) )
                {
                    utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"player_dead_drop_cooldown_finish", [ player ] );
                }
                else
                {
                    tmpcooldown = lowestcooldown - getsystemtime();
                    
                    if ( tmpcooldown < 1800 )
                    {
                        utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"player_dead_drop_cooldown_low", [ player ] );
                    }
                    else if ( tmpcooldown >= 1800 && tmpcooldown < 3600 )
                    {
                        utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"player_dead_drop_cooldown_medium", [ player ] );
                    }
                    else
                    {
                        utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"player_dead_drop_cooldown_high", [ player ] );
                    }
                }
            }
            
            if ( !isdefined( player.var_5758fea90c2799d6 ) )
            {
                player.var_5758fea90c2799d6 = 0;
            }
            
            player.var_5758fea90c2799d6 += scoreoverride;
        }
        
        if ( !isdefined( player.var_3989e9812cde057b ) )
        {
            player.var_3989e9812cde057b = 0;
        }
        
        player.var_3989e9812cde057b += totalcash;
        
        if ( !isdefined( player.var_f557e3ebce01f637 ) )
        {
            player.var_f557e3ebce01f637 = 0;
        }
        
        player.var_f557e3ebce01f637 += reductionamount;
    }
    
    if ( var_1f5a8342ac4abf70 )
    {
        utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"player_item_dead_drop_taken", [ player ] );
    }
    
    /#
        if ( getdvarint( @"scr_dmz_dead_drop_test", 0 ) && !br_instance_inventory::function_926a8f8643d34690() )
        {
            cooldownratio = br_instance_inventory::function_e78a9f9fcb7496cf();
            reductionamount = int( getdvarint( @"hash_fabc6973e3e762a1", 200 ) * totalcash / cooldownratio );
            testval = getdvarint( @"hash_52618bf1bf36e20", 0 );
            
            if ( reductionamount > 0 )
            {
                scoreoverride = int( 200 * totalcash / cooldownratio );
                player thread points::doscoreevent( #"dmz_dead_drop", undefined, scoreoverride, scoreoverride );
                
                if ( testval == 0 )
                {
                    utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"player_dead_drop_cooldown_finish", [ player ] );
                }
                else if ( testval == 1 )
                {
                    utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"player_dead_drop_cooldown_low", [ player ] );
                }
                else if ( testval == 2 )
                {
                    utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"player_dead_drop_cooldown_medium", [ player ] );
                }
                else if ( testval == 3 )
                {
                    utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"player_dead_drop_cooldown_high", [ player ] );
                }
            }
            
            if ( testval == 4 )
            {
                utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"player_item_dead_drop_taken", [ player ] );
            }
        }
    #/
}

// Namespace dead_drop
// Params 3
// Checksum 0xe44d77b6, Offset: 0x1222
// Size: 0x5f
function function_53746bc1fffa38f3( totalcash, player, reductionmodifier = 1 )
{
    cooldownratio = br_instance_inventory::function_e78a9f9fcb7496cf();
    reductionamount = int( 3600 * totalcash / cooldownratio * reductionmodifier );
    br_instance_inventory::function_3273e9456e3ea26( player, reductionamount );
    return reductionamount;
}

// Namespace dead_drop
// Params 1
// Checksum 0xb784888d, Offset: 0x128a
// Size: 0x45
function function_c35deb137e75e1f2( container )
{
    if ( !isdefined( container.script_poi ) )
    {
        container.script_poi = poi::poi_findpoioriginisin( container.origin, 0, 1 );
    }
    
    return container.script_poi;
}

/#

    // Namespace dead_drop
    // Params 0
    // Checksum 0x5f846774, Offset: 0x12d8
    // Size: 0x114, Type: dev
    function function_b3cd5eca8243ebf8()
    {
        level endon( #"game_ended" );
        setdevdvar( @"scr_spawn_dead_drop", 0 );
        level.var_62b87da7d906143b = [];
        
        while ( true )
        {
            spawndrop = getdvarint( @"scr_spawn_dead_drop", 0 );
            
            if ( spawndrop )
            {
                setdevdvar( @"scr_spawn_dead_drop", 0 );
                item = spawnscriptable( "<dev string:x24>", level.players[ 0 ].origin, level.players[ 0 ].angles );
                item setscriptablepartstate( "<dev string:x32>", "<dev string:x41>" );
                item.usedcallback = &deaddrop_used;
                item.var_444df56487288e2a = &function_8b9bd0ff7603f401;
                item.onclosedcallback = &function_eb42502f11f2dd9;
                item.noweaponslot = !getdvarint( @"hash_6ee9465e13d271e5", 0 );
                level.var_62b87da7d906143b[ level.var_62b87da7d906143b.size ] = item;
            }
            
            waitframe();
        }
    }

    // Namespace dead_drop
    // Params 0
    // Checksum 0xfc544902, Offset: 0x13f4
    // Size: 0x173, Type: dev
    function function_76daf2f64012e2cb()
    {
        level endon( #"game_ended" );
        setdevdvar( @"hash_1795f8de9b946d21", "<dev string:x4f>" );
        
        while ( true )
        {
            var_5856e607be73b4e3 = getdvar( @"hash_1795f8de9b946d21", "<dev string:x4f>" );
            
            if ( var_5856e607be73b4e3 != "<dev string:x4f>" )
            {
                setdevdvar( @"hash_1795f8de9b946d21", "<dev string:x4f>" );
                
                if ( level.var_62b87da7d906143b.size == 0 )
                {
                    continue;
                }
                
                foreach ( deaddrop in level.var_62b87da7d906143b )
                {
                    lootid = loot::function_d3e3bcaea591a6a2( var_5856e607be73b4e3 );
                    weaponobj = undefined;
                    quantity = undefined;
                    
                    if ( pickups::isweaponpickup( var_5856e607be73b4e3 ) )
                    {
                        weaponobj = br_pickups::getfullweaponobjfromscriptablename( var_5856e607be73b4e3 );
                        quantity = weaponclipsize( weaponobj );
                    }
                    else
                    {
                        quantity = level.br_pickups.counts[ var_5856e607be73b4e3 ];
                    }
                    
                    if ( !( isdefined( lootid ) && isdefined( quantity ) ) )
                    {
                        continue;
                    }
                    
                    extraction_container::function_2a28497226027a50( level.players, deaddrop, lootid, quantity, weaponobj, 1, 1 );
                }
            }
            
            waitframe();
        }
    }

    // Namespace dead_drop
    // Params 1
    // Checksum 0xc75515a4, Offset: 0x156f
    // Size: 0x17f, Type: dev
    function function_62d70f2446b03428( alldeaddrops )
    {
        level endon( #"game_ended" );
        setdevdvar( @"scr_show_dead_drop", 0 );
        
        while ( true )
        {
            shoulddraw = getdvarint( @"scr_show_dead_drop", 0 );
            
            if ( shoulddraw )
            {
                foreach ( deaddrop in level.deaddrops )
                {
                    utility::draw_circle( deaddrop.origin + ( 0, 0, 20 ), 50, ( 0, 1, 0 ), 1, 0, 1 );
                }
                
                foreach ( deaddrop in alldeaddrops )
                {
                    utility::draw_circle( deaddrop.origin, 50, ( 1, 0, 0 ), 1, 0, 1 );
                }
            }
            
            waitframe();
        }
    }

    // Namespace dead_drop
    // Params 1
    // Checksum 0xd28798c8, Offset: 0x16f6
    // Size: 0xc5, Type: dev
    function function_b149779b75eea9e6( alldeaddrops )
    {
        level endon( #"game_ended" );
        
        if ( !flags::gameflag( "<dev string:x50>" ) )
        {
            level flags::gameflagwait( "<dev string:x50>" );
        }
        
        foreach ( deaddrop in alldeaddrops )
        {
            level thread utility::callsharedfunc( #"persistent_missions", #"hash_31394c904d3a0e36", level.players, deaddrop );
        }
    }

    // Namespace dead_drop
    // Params 0
    // Checksum 0xef0be0fa, Offset: 0x17c3
    // Size: 0x1a8, Type: dev
    function function_63a895fb3b518c2a()
    {
        level endon( #"game_ended" );
        
        if ( !flags::gameflag( "<dev string:x50>" ) )
        {
            level flags::gameflagwait( "<dev string:x50>" );
        }
        
        setdevdvar( @"hash_a064eaf3659203b1", 0 );
        
        while ( true )
        {
            if ( !isdefined( level.var_62b87da7d906143b ) || level.var_62b87da7d906143b.size <= 0 )
            {
                waitframe();
                continue;
            }
            
            botuse = getdvarint( @"hash_a064eaf3659203b1", 0 );
            
            if ( botuse )
            {
                setdevdvar( @"hash_a064eaf3659203b1", 0 );
                selectedbot = undefined;
                
                foreach ( player in level.players )
                {
                    if ( isbot( player ) && isalive( player ) )
                    {
                        selectedbot = player;
                        break;
                    }
                }
                
                if ( !isdefined( selectedbot ) )
                {
                    waitframe();
                    continue;
                }
                
                deaddrop = level.var_62b87da7d906143b[ 0 ];
                
                if ( !isdefined( deaddrop ) )
                {
                    waitframe();
                    continue;
                }
                
                forward = anglestoforward( deaddrop.angles );
                selectedbot setorigin( deaddrop.origin + forward * 50 );
                waitframe();
                selectedbot botlookatpoint( deaddrop.origin, 10 );
                waitframe();
                selectedbot botpressbutton( "<dev string:x5e>", 1 );
            }
            
            waitframe();
        }
    }

#/
