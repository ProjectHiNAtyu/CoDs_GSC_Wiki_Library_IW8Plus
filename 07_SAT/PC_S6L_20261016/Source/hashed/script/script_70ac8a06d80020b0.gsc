// script_70ac8a06d80020b0  (hash_70ac8a06d80020b0.gscc) (size: 13639 Bytes / 0x3547 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9ea7ddcc (2661801420)
// size ...... 13639 (0x3547)
// includes .. 12  (offset: 0x334b)
// strings ... 11  (offset: 0x33ab)
// dev strs .. 14  (offset: 0x347b)
// exports ... 50  (offset: 0x201b)
// cseg ...... 0x135 + 0x1ee6 (0x201b)
// imports ... 94  (offset: 0x27eb)
// animtree1 . 0   (offset: 0x3547)
// animtree2 . 0   (offset: 0x3547)
#using scripts\mp\class;
#using scripts\mp\common\perks\perks;
#using scripts\mp\common\utility\connect_event_aggregator;
#using scripts\mp\common\utility\disconnect_event_aggregator;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\pickups_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\flags;
#using scripts\mp\hud_util;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_item;

#namespace namespace_5ab67a14d18bea3f;

// Namespace namespace_5ab67a14d18bea3f
// Params 0
// Checksum 0x94627ccc, Offset: 0x153
// Size: 0x47
function br_perkpack_init()
{
    connect_event_aggregator::registeronconnectcallback( &onplayerconnect );
    disconnect_event_aggregator::registerondisconnecteventcallback( &onplayerdisconnect );
    function_1b51b4d8a088b488();
    level.var_13ae011cc0799458 = getdvarint( @"hash_d676c30878594b5b", 1 );
    level.var_66a4df12ef1a8c25 = &function_66a4df12ef1a8c25;
}

// Namespace namespace_5ab67a14d18bea3f
// Params 0
// Checksum 0xd97eef00, Offset: 0x1a2
// Size: 0x20
function function_43c57123ed24d409()
{
    if ( isbrgamemode() )
    {
        return ( getdvarint( @"br_perk_package_enabled", 1 ) > 0 );
    }
    
    return 0;
}

// Namespace namespace_5ab67a14d18bea3f
// Params 0
// Checksum 0xe6b88f4c, Offset: 0x1ca
// Size: 0x1b, Type: bool
function function_cdd20dc4a098f17()
{
    return function_43c57123ed24d409() && getdvarint( @"br_perk_package_dropping_enabled", 1 );
}

// Namespace namespace_5ab67a14d18bea3f
// Params 0
// Checksum 0x704fac1d, Offset: 0x1ee
// Size: 0x9
function function_9636ab4181562460()
{
    function_9477f4690296f31();
}

// Namespace namespace_5ab67a14d18bea3f
// Params 1
// Checksum 0xce46acc3, Offset: 0x1ff
// Size: 0x55, Type: bool
function function_66a4df12ef1a8c25( var_d2aa8eeadda7d8e9 )
{
    if ( !level.var_13ae011cc0799458 || !isdefined( level.perkbundles ) )
    {
        return true;
    }
    
    if ( !isdefined( level.perkbundles[ var_d2aa8eeadda7d8e9 ] ) )
    {
        return false;
    }
    
    return !level.perkbundles[ var_d2aa8eeadda7d8e9 ].brdisabled;
}

// Namespace namespace_5ab67a14d18bea3f
// Params 0, eflags: 0x4
// Checksum 0x3231c462, Offset: 0x25d
// Size: 0x22b
function private function_1b51b4d8a088b488()
{
    if ( !isdefined( level.var_1fb5cc0c2fa6e2d8 ) )
    {
        level.var_1fb5cc0c2fa6e2d8 = [];
    }
    
    bundlename = getdvar( @"hash_23b1b8f92f4a2d96", "perkpackagelist_wz" );
    scriptbundle = getscriptbundle( hashcat( %"perkpackagelist:", bundlename ) );
    
    if ( isdefined( scriptbundle ) )
    {
        foreach ( packagestruct in scriptbundle.packages )
        {
            packageref = packagestruct.package;
            
            if ( isdefined( packageref ) )
            {
                packagebundle = getscriptbundle( hashcat( %"perkpackage:", packageref ) );
                
                if ( isdefined( packagebundle ) )
                {
                    if ( isvalidperk( packagebundle.perks.baseperk1 ) )
                    {
                        level.var_1fb5cc0c2fa6e2d8[ packageref ][ "perk" + 1 ] = packagebundle.perks.baseperk1;
                    }
                    
                    if ( isvalidperk( packagebundle.perks.baseperk2 ) )
                    {
                        level.var_1fb5cc0c2fa6e2d8[ packageref ][ "perk" + 2 ] = packagebundle.perks.baseperk2;
                    }
                    
                    if ( isvalidperk( packagebundle.perks.bonusperk ) )
                    {
                        level.var_1fb5cc0c2fa6e2d8[ packageref ][ "perk" + 3 ] = packagebundle.perks.bonusperk;
                    }
                    
                    if ( isvalidperk( packagebundle.perks.ultimateperk ) )
                    {
                        level.var_1fb5cc0c2fa6e2d8[ packageref ][ "perk" + 4 ] = packagebundle.perks.ultimateperk;
                    }
                }
            }
        }
    }
}

// Namespace namespace_5ab67a14d18bea3f
// Params 0
// Checksum 0x33efe586, Offset: 0x490
// Size: 0xe
function function_f52cc8dddb3769c5()
{
    return function_3047b58b80729e2f( function_6e89cf28e8010430() );
}

// Namespace namespace_5ab67a14d18bea3f
// Params 1
// Checksum 0x8f42f614, Offset: 0x4a7
// Size: 0x8c, Type: bool
function function_3047b58b80729e2f( perks )
{
    if ( perks.size > 0 )
    {
        foreach ( perk in perks )
        {
            if ( isvalidperk( perk ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace namespace_5ab67a14d18bea3f
// Params 0
// Checksum 0xa5c930c7, Offset: 0x53c
// Size: 0x5e
function function_6e89cf28e8010430()
{
    if ( isdefined( self.var_24633d8241ca5c23 ) && isdefined( self.var_24633d8241ca5c23.perks ) && self.var_24633d8241ca5c23.perks.size > 0 )
    {
        return self.var_24633d8241ca5c23.perks;
    }
    
    return getloadoutperks();
}

// Namespace namespace_5ab67a14d18bea3f
// Params 0
// Checksum 0x36696539, Offset: 0x5a2
// Size: 0xba
function getloadoutperks()
{
    if ( !isdefined( self.pers ) )
    {
        return;
    }
    
    perks = [];
    
    if ( isdefined( self.loadoutperks ) )
    {
        foreach ( perk in self.loadoutperks )
        {
            slot = perks::getperkslot( perk );
            
            if ( isdefined( slot ) )
            {
                perks[ perks.size ] = perk;
            }
        }
    }
    
    return perks;
}

// Namespace namespace_5ab67a14d18bea3f
// Params 1, eflags: 0x4
// Checksum 0xf4938b49, Offset: 0x665
// Size: 0xbe
function private function_bbd1f6a6f748bb0c( backpackindex )
{
    lootname = undefined;
    lootid = common_inventory::inventory_getlootidatbackpackindex( backpackindex );
    
    if ( isdefined( lootid ) )
    {
        lootname = loot::getScriptableFromLootID( lootid );
        
        if ( !isdefined( lootname ) )
        {
            lootname = loot::function_f54ecb89dfab8e8c( lootid );
        }
        
        if ( function_e96bd96c3a428bb8( lootname ) )
        {
            perkstruct = function_5c326b2975c5f49b( backpackindex );
            
            if ( isdefined( perkstruct ) && isdefined( perkstruct.perks ) )
            {
                return [ lootname, perkstruct.perks ];
            }
            
            return;
        }
        
        perks = function_956a00060715cb3a( lootname );
        
        if ( perks.size > 0 )
        {
            return [ lootname, perks ];
        }
    }
}

// Namespace namespace_5ab67a14d18bea3f
// Params 1, eflags: 0x4
// Checksum 0x37061a9f, Offset: 0x72c
// Size: 0xc0
function private function_7f729d536724f4f( scriptent )
{
    entname = scriptent.scriptablename;
    perkarr = undefined;
    
    if ( isdefined( scriptent.perks ) )
    {
        perkarr = scriptent.perks;
    }
    else if ( isdefined( scriptent.instance ) && isdefined( scriptent.instance.perks ) )
    {
        perkarr = scriptent.instance.perks;
    }
    else if ( isdefined( entname ) )
    {
        perks = function_956a00060715cb3a( entname );
        
        if ( perks.size > 0 )
        {
            perkarr = perks;
        }
    }
    
    return [ entname, perkarr ];
}

// Namespace namespace_5ab67a14d18bea3f
// Params 0, eflags: 0x4
// Checksum 0x9d666ab6, Offset: 0x7f5
// Size: 0x31
function private function_396a41763fd8610b()
{
    return [ self.var_24633d8241ca5c23.var_3cb7bc08e98113e2, self.var_24633d8241ca5c23.perks ];
}

// Namespace namespace_5ab67a14d18bea3f
// Params 1, eflags: 0x4
// Checksum 0x4cbbfdb0, Offset: 0x82f
// Size: 0x26, Type: bool
function private isvalidperk( perk )
{
    return perk && perk != "none" && perk != "specialty_null";
}

// Namespace namespace_5ab67a14d18bea3f
// Params 1
// Checksum 0xad01f4c6, Offset: 0x85e
// Size: 0xe0
function function_956a00060715cb3a( lootref )
{
    if ( isdefined( lootref ) && isdefined( level.br_pickups ) && isdefined( level.br_pickups.br_lootreference[ lootref ] ) )
    {
        externalref = level.br_pickups.br_lootreference[ lootref ];
        
        if ( isdefined( externalref ) && isdefined( level.var_1fb5cc0c2fa6e2d8[ externalref ] ) && isdefined( level.var_1fb5cc0c2fa6e2d8[ externalref ] ) )
        {
            perks = [];
            
            for ( i = 1; i <= 4 ; i++ )
            {
                key = "perk" + i;
                
                if ( isdefined( level.var_1fb5cc0c2fa6e2d8[ externalref ][ key ] ) )
                {
                    perks[ key ] = level.var_1fb5cc0c2fa6e2d8[ externalref ][ key ];
                }
            }
            
            return perks;
        }
    }
}

// Namespace namespace_5ab67a14d18bea3f
// Params 1, eflags: 0x4
// Checksum 0x18657331, Offset: 0x946
// Size: 0x12e
function private giveperk( perk )
{
    var_d561c51adcd2c614 = isvalidperk( perk ) && !isdefined( self.perks[ perk ] );
    
    if ( var_d561c51adcd2c614 && perkisrestricted( perk ) )
    {
        return;
    }
    
    if ( var_d561c51adcd2c614 )
    {
        class::loadout_giveperk( perk );
    }
    
    slot = perks::getperkslot( perk );
    
    if ( isdefined( slot ) )
    {
        var_c9af326916e11f87 = [ "loadoutPerks", "loadoutStandardPerks" ];
        
        foreach ( perskey in var_c9af326916e11f87 )
        {
            if ( isdefined( self.pers[ perskey ] ) && !arraycontains( self.pers[ perskey ], perk ) )
            {
                self.pers[ perskey ][ self.pers[ perskey ].size ] = perk;
            }
        }
    }
}

// Namespace namespace_5ab67a14d18bea3f
// Params 1, eflags: 0x4
// Checksum 0xf855766b, Offset: 0xa7c
// Size: 0x138
function private removeperk( perk )
{
    if ( isvalidperk( perk ) && isdefined( self.perks[ perk ] ) )
    {
        if ( isdefined( self.loadoutperks ) && arraycontains( self.loadoutperks, perk ) )
        {
            class::loadout_removeperk( perk );
        }
        else
        {
            perk::removeperk( perk );
        }
        
        if ( !isdefined( self.perks[ perk ] ) )
        {
            if ( isdefined( self.pers ) )
            {
                foreach ( perskey in [ "loadoutPerks", "loadoutStandardPerks" ] )
                {
                    if ( isdefined( self.pers[ perskey ] ) && arraycontains( self.pers[ perskey ], perk ) )
                    {
                        self.pers[ perskey ] = arrayremove( self.pers[ perskey ], perk );
                    }
                }
            }
        }
    }
}

// Namespace namespace_5ab67a14d18bea3f
// Params 1
// Checksum 0xf44e5566, Offset: 0xbbc
// Size: 0x1a
function function_1989761c60695d17( player )
{
    return function_4369e50a95cc3940( player function_6e89cf28e8010430() );
}

// Namespace namespace_5ab67a14d18bea3f
// Params 1
// Checksum 0xe53a30b6, Offset: 0xbdf
// Size: 0x188
function function_4369e50a95cc3940( perks )
{
    if ( !function_3047b58b80729e2f( perks ) )
    {
        return;
    }
    
    foreach ( packref, perkpack in level.var_1fb5cc0c2fa6e2d8 )
    {
        matchingpack = 1;
        
        if ( perkpack.size > 0 )
        {
            for ( i = 0; i + 1 <= 4 ; i++ )
            {
                packperk = "none";
                currentperk = "none";
                key = "perk" + i + 1;
                
                if ( isvalidperk( perkpack[ key ] ) )
                {
                    packperk = perkpack[ key ];
                }
                else if ( i < perkpack.size && isvalidperk( perkpack[ i ] ) )
                {
                    packperk = perkpack[ i ];
                }
                
                if ( isvalidperk( perks[ key ] ) )
                {
                    currentperk = perks[ key ];
                }
                else if ( i < perks.size && isvalidperk( perks[ i ] ) )
                {
                    currentperk = perks[ i ];
                }
                
                if ( packperk != currentperk )
                {
                    matchingpack = 0;
                    break;
                }
            }
        }
        else
        {
            matchingpack = 0;
        }
        
        if ( matchingpack )
        {
            var_7237854e3be197ca = function_5f9f617c656b5d34( packref );
            
            if ( isdefined( var_7237854e3be197ca ) )
            {
                return var_7237854e3be197ca;
            }
        }
    }
    
    return "brloot_perkpack_custom";
}

// Namespace namespace_5ab67a14d18bea3f
// Params 2
// Checksum 0x95d24449, Offset: 0xd70
// Size: 0x148
function function_b8607e1395b295a( perks, isspecialistbonus )
{
    if ( !isdefined( self.var_24633d8241ca5c23 ) )
    {
        self.var_24633d8241ca5c23 = spawnstruct();
    }
    
    if ( !isdefined( self.var_24633d8241ca5c23.perks ) )
    {
        self.var_24633d8241ca5c23.perks = [];
    }
    else
    {
        clearplayerperks();
    }
    
    if ( perks.size > 0 )
    {
        perkpackref = function_4369e50a95cc3940( perks );
        self.var_24633d8241ca5c23.var_3cb7bc08e98113e2 = perkpackref;
        
        for ( i = 0; i + 1 <= 4 ; i++ )
        {
            key = "perk" + i + 1;
            
            if ( isvalidperk( perks[ key ] ) )
            {
                self.var_24633d8241ca5c23.perks[ key ] = perks[ key ];
                continue;
            }
            
            if ( i < perks.size && isvalidperk( perks[ i ] ) )
            {
                self.var_24633d8241ca5c23.perks[ key ] = perks[ i ];
            }
        }
        
        function_de9d6c6a37213f43( isspecialistbonus );
        function_8d4aa4343657c235();
        
        /#
            function_83fa37eb26cd032d();
        #/
        
        return;
    }
    
    function_9477f4690296f31();
}

// Namespace namespace_5ab67a14d18bea3f
// Params 0
// Checksum 0x993a3805, Offset: 0xec0
// Size: 0xa9
function function_9477f4690296f31()
{
    clearplayerperks();
    
    if ( !isdefined( self.var_24633d8241ca5c23 ) )
    {
        self.var_24633d8241ca5c23 = spawnstruct();
    }
    
    if ( !isdefined( self.var_24633d8241ca5c23.perks ) )
    {
        self.var_24633d8241ca5c23.perks = [];
    }
    
    self.var_24633d8241ca5c23.var_3cb7bc08e98113e2 = undefined;
    
    for ( i = 1; i <= 4 ; i++ )
    {
        self.var_24633d8241ca5c23.perks[ "perk" + i ] = undefined;
    }
    
    function_8d4aa4343657c235();
    
    /#
        function_83fa37eb26cd032d();
    #/
}

// Namespace namespace_5ab67a14d18bea3f
// Params 0
// Checksum 0x63bd919, Offset: 0xf71
// Size: 0x37
function function_8d4aa4343657c235()
{
    perksarray = arraycopy( function_6e89cf28e8010430() );
    function_cdc669dbc8ea2101( perksarray );
    perks::function_8165040202c6ebe5( perksarray );
    perks::setomnvarsforperklist( "ui_spawn_perk_", perksarray, [] );
}

// Namespace namespace_5ab67a14d18bea3f
// Params 1, eflags: 0x4
// Checksum 0xc54e46e3, Offset: 0xfb0
// Size: 0xc7
function private function_de9d6c6a37213f43( isspecialistbonus )
{
    if ( isspecialistbonus )
    {
        perks::addspecialistbonus();
        return;
    }
    
    if ( !( isdefined( self.var_24633d8241ca5c23 ) && isdefined( self.var_24633d8241ca5c23.perks ) ) )
    {
        return;
    }
    
    for ( i = 1; i <= 4 ; i++ )
    {
        if ( isdefined( self.var_24633d8241ca5c23.perks[ "perk" + i ] ) )
        {
            perk = self.var_24633d8241ca5c23.perks[ "perk" + i ];
            
            if ( isvalidperk( perk ) && !isdefined( self.perks[ perk ] ) )
            {
                giveperk( perk );
            }
        }
    }
}

// Namespace namespace_5ab67a14d18bea3f
// Params 0, eflags: 0x4
// Checksum 0xcb4fd621, Offset: 0x107f
// Size: 0xda
function private clearplayerperks()
{
    if ( isdefined( self.perks[ "specialty_specialist_bonus" ] ) )
    {
        perks::removespecialistbonus();
    }
    
    if ( !( isdefined( self.var_24633d8241ca5c23 ) && isdefined( self.var_24633d8241ca5c23.perks ) ) )
    {
        return;
    }
    
    foreach ( perk in self.var_24633d8241ca5c23.perks )
    {
        removeperk( perk );
    }
    
    self.var_24633d8241ca5c23.perks = [];
}

// Namespace namespace_5ab67a14d18bea3f
// Params 1
// Checksum 0xa99840f8, Offset: 0x1161
// Size: 0x3d
function function_5f9f617c656b5d34( ref )
{
    if ( isdefined( level.br_pickups.var_5515c706eaccd3[ ref ] ) )
    {
        return level.br_pickups.var_5515c706eaccd3[ ref ];
    }
}

// Namespace namespace_5ab67a14d18bea3f
// Params 0
// Checksum 0xa0b469b1, Offset: 0x11a6
// Size: 0x11
function function_3a6825469c3df4a3()
{
    return getdvarint( @"br_perk_package_inventory_items_enabled", 1 );
}

// Namespace namespace_5ab67a14d18bea3f
// Params 5
// Checksum 0x56948c4a, Offset: 0x11c0
// Size: 0x1bc, Type: bool
function function_d9e5280cbe50ff06( scriptent, var_aae9f097a53d9da7, bautouse, backpackindex, backpackequip )
{
    lootname = undefined;
    perks = undefined;
    
    if ( isdefined( backpackindex ) )
    {
        if ( bautouse && ( !isdefined( backpackequip ) || backpackequip == 0 ) )
        {
            [ lootname, perks ] = function_7f729d536724f4f( scriptent );
        }
        else
        {
            [ lootname, perks ] = function_bbd1f6a6f748bb0c( backpackindex );
        }
    }
    else if ( isdefined( scriptent ) )
    {
        [ lootname, perks ] = function_7f729d536724f4f( scriptent );
    }
    
    if ( isdefined( scriptent ) )
    {
        if ( var_aae9f097a53d9da7 )
        {
            overridedroporigin = undefined;
            
            if ( isdefined( scriptent.origin ) )
            {
                overridedroporigin = scriptent.origin;
            }
            else if ( isdefined( scriptent.instance ) && isdefined( scriptent.instance.origin ) )
            {
                overridedroporigin = scriptent.instance.origin;
            }
            
            dropstruct = pickups::function_f71dd588dc4f6288();
            dropperkpack( undefined, undefined, undefined, overridedroporigin );
        }
        else if ( isdefined( self.var_24633d8241ca5c23.var_3cb7bc08e98113e2 ) )
        {
            if ( function_e96bd96c3a428bb8( self.var_24633d8241ca5c23.var_3cb7bc08e98113e2 ) )
            {
                function_62b6609bf67a7ad7( backpackindex, function_6e89cf28e8010430() );
            }
        }
    }
    
    isspecialistbonus = lootname == "brloot_perkpack_specialist_jup";
    function_b8607e1395b295a( perks, isspecialistbonus );
    return true;
}

// Namespace namespace_5ab67a14d18bea3f
// Params 4
// Checksum 0xdb228d1, Offset: 0x1385
// Size: 0x264
function dropperkpack( origin, angles, backpackindex, droporiginoverride )
{
    assert( isdefined( self ), "<dev string:x24>" );
    scriptablename = undefined;
    item = undefined;
    
    if ( function_cdd20dc4a098f17() )
    {
        if ( !isdefined( backpackindex ) )
        {
            scriptablename = function_1989761c60695d17( self );
        }
        else
        {
            lootid = common_inventory::inventory_getlootidatbackpackindex( backpackindex );
            scriptablename = loot::function_f54ecb89dfab8e8c( lootid );
        }
        
        if ( isdefined( scriptablename ) )
        {
            spawnoptions = common_item::items_initspawnoptions_spawnfromposition( self.origin, self.angles );
            perkset = undefined;
            
            if ( function_e96bd96c3a428bb8( scriptablename ) )
            {
                if ( isdefined( backpackindex ) )
                {
                    perkdata = function_5c326b2975c5f49b( backpackindex );
                    
                    if ( isdefined( perkdata ) )
                    {
                        perkset = perkdata.perks;
                    }
                    
                    function_23d779bf689b8a89( backpackindex );
                }
                else if ( self.var_24633d8241ca5c23.perks.size > 0 )
                {
                    perkset = self.var_24633d8241ca5c23.perks;
                }
                else
                {
                    perkset = getloadoutperks();
                }
                
                spawnoptions.payload = [ #"customperkpackage" ];
                
                if ( isdefined( perkset ) )
                {
                    foreach ( perk in perkset )
                    {
                        perkid = level.var_fadc1b38f6006441[ perk ];
                        assert( isdefined( perkid ), "<dev string:x4a>" + perk + "<dev string:x57>" );
                        
                        if ( isdefined( perkid ) )
                        {
                            spawnoptions.payload[ spawnoptions.payload.size ] = perkid + 1;
                        }
                    }
                }
            }
            
            common_item::items_spawnnewitemfromscriptable( scriptablename, self.origin, self.angles, undefined, undefined, spawnoptions.payload );
            
            if ( isdefined( item ) && isdefined( perkset ) )
            {
                item.perks = arraycopy( perkset );
            }
        }
    }
    
    if ( !isdefined( backpackindex ) )
    {
        function_9477f4690296f31();
    }
    
    return item;
}

// Namespace namespace_5ab67a14d18bea3f
// Params 0
// Checksum 0x4fb4b01e, Offset: 0x15f2
// Size: 0x2e
function onplayerconnect()
{
    function_9636ab4181562460();
    thread function_b8c53ddf3dec0666();
    
    /#
        if ( getdvarint( @"hash_157ce918a8602734", 0 ) == 1 )
        {
            thread function_a86fbcae26f2f766();
        }
    #/
}

// Namespace namespace_5ab67a14d18bea3f
// Params 1
// Checksum 0xa7919cf9, Offset: 0x1628
// Size: 0x1f
function onplayerdisconnect( player )
{
    if ( !isbot( player ) )
    {
        player function_e0f0230ab16dedf7();
    }
}

// Namespace namespace_5ab67a14d18bea3f
// Params 2
// Checksum 0x58e0f129, Offset: 0x164f
// Size: 0x38
function onplayerkilled( attacker, victim )
{
    if ( isbot( victim ) )
    {
        return;
    }
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        return;
    }
    
    victim function_9477f4690296f31();
}

// Namespace namespace_5ab67a14d18bea3f
// Params 0
// Checksum 0x3b6ef8b5, Offset: 0x168f
// Size: 0xc
function function_f05e2b1cd574f56a()
{
    self.var_24633d8241ca5c23 = undefined;
}

// Namespace namespace_5ab67a14d18bea3f
// Params 0
// Checksum 0xbf5fc506, Offset: 0x16a3
// Size: 0xc
function function_61d9db25c63ec377()
{
    self.var_c39f0af8e3ad1702 = undefined;
}

// Namespace namespace_5ab67a14d18bea3f
// Params 0
// Checksum 0x2e57fb32, Offset: 0x16b7
// Size: 0xc7
function function_84153bd067382799()
{
    if ( !isdefined( self.perkpackdisplays ) )
    {
        return;
    }
    
    if ( self.perkpackdisplays.size > 0 )
    {
        foreach ( elem in self.perkpackdisplays )
        {
            if ( isdefined( elem.parent ) )
            {
                elem.parent hud_util::removechild( elem );
            }
        }
    }
    
    self.perkpackdisplays = undefined;
    self.var_c08dc700a855ef66 = undefined;
}

// Namespace namespace_5ab67a14d18bea3f
// Params 0
// Checksum 0x41261b75, Offset: 0x1786
// Size: 0x1e
function function_e0f0230ab16dedf7()
{
    function_f05e2b1cd574f56a();
    function_61d9db25c63ec377();
    function_fc44f7ff045237a2();
    function_84153bd067382799();
}

// Namespace namespace_5ab67a14d18bea3f
// Params 1
// Checksum 0x4a62dfb4, Offset: 0x17ac
// Size: 0x1d, Type: bool
function function_e96bd96c3a428bb8( ref )
{
    if ( !isdefined( ref ) )
    {
        return false;
    }
    
    return ref == "brloot_perkpack_custom";
}

// Namespace namespace_5ab67a14d18bea3f
// Params 1
// Checksum 0xe9329cf5, Offset: 0x17d2
// Size: 0x28, Type: bool
function function_85f1b1e637ab489f( lootid )
{
    scriptablename = loot::getScriptableFromLootID( lootid );
    return function_e96bd96c3a428bb8( scriptablename );
}

// Namespace namespace_5ab67a14d18bea3f
// Params 1
// Checksum 0x2d8c8b2f, Offset: 0x1803
// Size: 0x8e, Type: bool
function isperkpack( lootref )
{
    if ( function_e96bd96c3a428bb8( lootref ) )
    {
        return true;
    }
    
    if ( isdefined( lootref ) && isdefined( level.br_pickups ) && isdefined( level.br_pickups.br_lootreference[ lootref ] ) )
    {
        externalref = level.br_pickups.br_lootreference[ lootref ];
        return ( isdefined( externalref ) && isdefined( level.var_1fb5cc0c2fa6e2d8[ externalref ] ) && isdefined( level.var_1fb5cc0c2fa6e2d8[ externalref ] ) );
    }
    
    return false;
}

// Namespace namespace_5ab67a14d18bea3f
// Params 1
// Checksum 0xdf700ca1, Offset: 0x189a
// Size: 0x28, Type: bool
function function_1c1e64d89a28c070( lootid )
{
    scriptablename = loot::getScriptableFromLootID( lootid );
    return isperkpack( scriptablename );
}

// Namespace namespace_5ab67a14d18bea3f
// Params 0
// Checksum 0x1ee30567, Offset: 0x18cb
// Size: 0xb2
function function_b8c53ddf3dec0666()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"giveloadout" );
        
        if ( !level.br_prematchffa || flags::gameflagexists( "prematch_done" ) && flags::gameflag( "prematch_done" ) )
        {
            if ( !isdefined( self.perks[ "specialty_specialist_bonus" ] ) )
            {
                if ( player::isreallyalive( self ) && function_f52cc8dddb3769c5() )
                {
                    perks = getloadoutperks();
                    function_b8607e1395b295a( perks );
                }
                else
                {
                    function_9477f4690296f31();
                }
            }
            
            /#
                thread function_83fa37eb26cd032d();
            #/
        }
        
        waitframe();
    }
}

// Namespace namespace_5ab67a14d18bea3f
// Params 2
// Checksum 0xf912df18, Offset: 0x1985
// Size: 0x49
function function_dec1f5b8973708a9( backpackindex, itement )
{
    perkdata = function_5c326b2975c5f49b( backpackindex );
    itement.perks = perkdata.perks;
    function_23d779bf689b8a89( backpackindex );
}

// Namespace namespace_5ab67a14d18bea3f
// Params 2
// Checksum 0xc4708f8e, Offset: 0x19d6
// Size: 0x3a
function function_564bc0f74d98e10( backpackindex, itement )
{
    if ( !isdefined( itement.perks ) )
    {
        return;
    }
    
    function_62b6609bf67a7ad7( backpackindex, itement.perks );
}

// Namespace namespace_5ab67a14d18bea3f
// Params 2
// Checksum 0xf3c8b49f, Offset: 0x1a18
// Size: 0xa4
function function_234be6c92a754af9( perkpackent, var_58915b9c0f14e794 )
{
    if ( perkpackent.scriptablename != "brloot_perkpack_custom" )
    {
        return;
    }
    
    if ( !isdefined( var_58915b9c0f14e794 ) || var_58915b9c0f14e794.size <= 0 )
    {
        [ lootref, perks ] = function_396a41763fd8610b();
        
        if ( perks.size > 0 )
        {
            perkpackent.perks = perks;
        }
        else
        {
            perkpackent.perks = getloadoutperks();
        }
        
        return;
    }
    
    perkpackent.perks = var_58915b9c0f14e794;
}

// Namespace namespace_5ab67a14d18bea3f
// Params 1
// Checksum 0x20377e7b, Offset: 0x1ac4
// Size: 0x6d
function function_5c326b2975c5f49b( backpackindex )
{
    if ( !( isdefined( self.var_b0b6e06db97e4775 ) && isdefined( backpackindex ) ) )
    {
        return;
    }
    
    for ( i = 0; i < self.var_b0b6e06db97e4775.size ; i++ )
    {
        if ( self.var_b0b6e06db97e4775[ i ].index == backpackindex )
        {
            return self.var_b0b6e06db97e4775[ i ];
        }
    }
}

// Namespace namespace_5ab67a14d18bea3f
// Params 2
// Checksum 0xc323276b, Offset: 0x1b3a
// Size: 0x136
function function_62b6609bf67a7ad7( index, perks )
{
    if ( isdefined( function_5c326b2975c5f49b( index ) ) )
    {
        function_23d779bf689b8a89( index );
    }
    
    if ( !isdefined( self.var_b0b6e06db97e4775 ) )
    {
        self.var_b0b6e06db97e4775 = [];
    }
    
    perklist = [];
    perkarr = perks;
    
    if ( ( !isdefined( perkarr ) || perkarr.size <= 0 ) && function_f52cc8dddb3769c5() )
    {
        perkarr = getloadoutperks();
    }
    
    if ( perkarr.size > 0 )
    {
        for ( i = 0; i + 1 <= 4 ; i++ )
        {
            key = "perk" + i + 1;
            
            if ( isdefined( perkarr[ key ] ) )
            {
                perklist[ key ] = perkarr[ key ];
                continue;
            }
            
            if ( i < perkarr.size )
            {
                perklist[ key ] = perkarr[ i ];
            }
        }
    }
    
    if ( perklist.size > 0 )
    {
        arrindex = self.var_b0b6e06db97e4775.size;
        self.var_b0b6e06db97e4775[ arrindex ] = spawnstruct();
        self.var_b0b6e06db97e4775[ arrindex ].index = index;
        self.var_b0b6e06db97e4775[ arrindex ].perks = perklist;
    }
}

// Namespace namespace_5ab67a14d18bea3f
// Params 1
// Checksum 0x29f9653c, Offset: 0x1c78
// Size: 0x104
function function_23d779bf689b8a89( backpackindex )
{
    if ( !( isdefined( self.var_b0b6e06db97e4775 ) && isdefined( backpackindex ) ) )
    {
        return;
    }
    
    removeitems = [];
    
    for ( i = 0; i < self.var_b0b6e06db97e4775.size ; i++ )
    {
        if ( self.var_b0b6e06db97e4775[ i ].index == backpackindex )
        {
            removeitems[ removeitems.size ] = self.var_b0b6e06db97e4775[ i ];
        }
    }
    
    if ( removeitems.size > 0 )
    {
        foreach ( item in removeitems )
        {
            self.var_b0b6e06db97e4775 = arrayremove( self.var_b0b6e06db97e4775, item );
        }
    }
}

// Namespace namespace_5ab67a14d18bea3f
// Params 0
// Checksum 0x48eca500, Offset: 0x1d84
// Size: 0x1b
function function_fc44f7ff045237a2()
{
    if ( !isdefined( self.var_b0b6e06db97e4775 ) )
    {
        return;
    }
    
    self.var_b0b6e06db97e4775 = undefined;
}

/#

    // Namespace namespace_5ab67a14d18bea3f
    // Params 0
    // Checksum 0x6770a3b, Offset: 0x1da7
    // Size: 0x119, Type: dev
    function function_a86fbcae26f2f766()
    {
        level endon( #"game_ended" );
        self endon( #"disconnect" );
        
        if ( isbot( self ) || getdvarint( @"hash_157ce918a8602734", 0 ) != 1 )
        {
            return;
        }
        
        xoffset = 5;
        yoffset = -80;
        yoffsetincrement = 10;
        var_f1aa20864c57f70e = hud_util::createfontstring( "<dev string:x6e>", 1 );
        var_f1aa20864c57f70e hud_util::setpoint( "<dev string:x76>", "<dev string:x76>", xoffset, yoffset );
        self.perkpackdisplays[ "<dev string:x7b>" ] = var_f1aa20864c57f70e;
        
        for ( i = 1; i <= 4 ; i++ )
        {
            var_34bfa480c4f8462 = hud_util::createfontstring( "<dev string:x6e>", 1 );
            var_34bfa480c4f8462 hud_util::setpoint( "<dev string:x76>", "<dev string:x76>", xoffset, yoffset + yoffsetincrement * ( i - 1 + 1 ) );
            self.perkpackdisplays[ "<dev string:x88>" + i ] = var_34bfa480c4f8462;
        }
        
        self.var_c08dc700a855ef66 = 1;
        function_83fa37eb26cd032d();
    }

    // Namespace namespace_5ab67a14d18bea3f
    // Params 0
    // Checksum 0xebf3d3c, Offset: 0x1ec8
    // Size: 0x153, Type: dev
    function function_83fa37eb26cd032d()
    {
        if ( !isplayer( self ) || isbot( self ) )
        {
            return;
        }
        
        if ( !function_43c57123ed24d409() || getdvarint( @"hash_157ce918a8602734", 0 ) != 1 )
        {
            return;
        }
        
        if ( !isdefined( self.pers[ "<dev string:x8d>" ] ) )
        {
            return;
        }
        
        if ( !flags::gameflag( "<dev string:x93>" ) )
        {
            return;
        }
        
        if ( !self.var_c08dc700a855ef66 )
        {
            function_a86fbcae26f2f766();
        }
        
        [ lootref, perks ] = function_396a41763fd8610b();
        var_3588b684abcc38d4 = 0;
        
        if ( isdefined( lootref ) )
        {
            self.perkpackdisplays[ "<dev string:x7b>" ] setdevtext( "<dev string:xa1>" + lootref );
        }
        else
        {
            self.perkpackdisplays[ "<dev string:x7b>" ] setdevtext( "<dev string:xad>" );
        }
        
        for ( i = 1; i <= 4 ; i++ )
        {
            perkname = "<dev string:xba>";
            
            if ( isdefined( perks[ "<dev string:x88>" + i ] ) )
            {
                perkname = perks[ "<dev string:x88>" + i ];
            }
            
            self.perkpackdisplays[ "<dev string:x88>" + i ] setdevtext( "<dev string:xbb>" + i + "<dev string:xc1>" + perkname );
        }
    }

#/
