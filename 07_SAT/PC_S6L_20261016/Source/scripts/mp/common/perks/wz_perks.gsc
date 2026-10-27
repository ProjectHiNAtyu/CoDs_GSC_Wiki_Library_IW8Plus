// scripts\mp\common\perks\wz_perks.gsc  (hash_646ec7796410954f.gscc) (size: 9619 Bytes / 0x2593 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa0200906 (2686454022)
// size ...... 9619 (0x2593)
// includes .. 7   (offset: 0x24b3)
// strings ... 11  (offset: 0x24eb)
// dev strs .. 1   (offset: 0x2587)
// exports ... 30  (offset: 0x16db)
// cseg ...... 0x13f + 0x159c (0x16db)
// imports ... 75  (offset: 0x1b8b)
// animtree1 . 0   (offset: 0x2593)
// animtree2 . 0   (offset: 0x2593)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_dev;
#using scripts\mp\class;
#using scripts\mp\common\perks\perks;
#using scripts\mp\common\utility\perk;
#using scripts\mp\loot\common_item;

#namespace wz_perks;

// Namespace wz_perks
// Params 0, eflags: 0x1
// Checksum 0x96d980ca, Offset: 0x15d
// Size: 0x34
function autoexec init()
{
    if ( common_item::items_isenabled() && isbrgamemode() && level.gametype != "bongo" )
    {
        level.init_item_perk_override = &init_wz_perk;
    }
}

// Namespace wz_perks
// Params 0
// Checksum 0xbfcfda6c, Offset: 0x199
// Size: 0x1bd
function init_wz_perk()
{
    common_item::function_4b30c091d3b04a25( "perk" );
    common_item::function_84174b793b5fe9a7( "perk", #"use", &useperk );
    common_item::function_84174b793b5fe9a7( "perk", #"canautouse", &canautouse );
    common_item::function_84174b793b5fe9a7( "perk", #"hash_9e49dfaa7c147654", &function_b61432f518934c0f );
    callback::add( #"player_death", &onplayerdeath );
    thread function_5a5ce83a5fc1c82c();
    utility::registersharedfunc( #"perk", #"dropperks", &function_ee59ed919082db65 );
    utility::registersharedfunc( #"perk", #"hash_497188f48811df36", &function_7f245ad6b70c39c9 );
    utility::registersharedfunc( #"perk", #"hash_74e8b5fc11eb5789", &function_b6eab3b11516131e );
    utility::registersharedfunc( #"perk", #"dropspecialist", &dropspecialist );
    utility::registersharedfunc( #"perk", #"removespecialist", &removespecialist );
    utility::registersharedfunc( #"perk", #"hash_ff6f8c52b04ef8c2", &function_173a7a25c20d9891 );
    utility::registersharedfunc( #"perk", #"hash_33213c147fc82a20", &function_6a22240a701a68d3 );
    utility::registersharedfunc( #"perk", #"hash_2a5ab737103ff341", &function_8453bf6d1d43d60a );
    utility::registersharedfunc( #"perk", #"hash_f15a1c0958b41b8b", &function_70a5afcd0e05c214 );
    level callback::add( #"register_perk", &function_61cc3dc03e4c0b75 );
    level callback::add( "lootcache_looted", &function_971fe331e52e42bd );
    
    /#
        br_dev::registerhandlecommand( &handledevcommand );
    #/
}

// Namespace wz_perks
// Params 4
// Checksum 0x4f732e20, Offset: 0x35e
// Size: 0x28, Type: bool
function canautouse( itembundle, item, autouse, allowswap )
{
    return false;
}

// Namespace wz_perks
// Params 4
// Checksum 0x8a7f1bfb, Offset: 0x38f
// Size: 0x178
function useperk( itembundle, item, autouse, var_981c264073bf1154 )
{
    if ( function_b61432f518934c0f( itembundle, item, undefined, undefined ) )
    {
        if ( isdefined( itembundle.subtype ) )
        {
            switch ( itembundle.subtype )
            {
                case #"hash_2bee0bf604b15c84":
                    function_b6eab3b11516131e( itembundle.ref );
                    break;
                case #"hash_6c4c3516ab5ce943":
                    function_ec3ad05aae1b3c22( item );
                    return ( isdefined( item.count ) ? item.count - 1 : 0 );
            }
        }
        
        perk::giveperk( itembundle.ref );
        
        if ( itembundle.subtype == "field_guide" )
        {
            if ( !isdefined( self.fieldguides ) )
            {
                self.fieldguides = [];
            }
            
            self.fieldguides[ self.fieldguides.size ] = itembundle.ref;
        }
        else
        {
            if ( !isdefined( self.lootperks ) )
            {
                self.lootperks = [];
            }
            
            self.lootperks[ self.lootperks.size ] = itembundle.ref;
        }
        
        function_173a7a25c20d9891();
        return ( isdefined( item.count ) ? item.count - 1 : 0 );
    }
    
    return item.count;
}

// Namespace wz_perks
// Params 4
// Checksum 0x8fd48763, Offset: 0x510
// Size: 0xa2
function function_b61432f518934c0f( itembundle, item, autouse, allowswap )
{
    switch ( itembundle.subtype )
    {
        case #"hash_7d9b08b8097be120":
            return !isdefined( self.perks[ itembundle.ref ] );
        default:
            return ( !hasspecialist() && ( itembundle.subtype == "loadout" || !isdefined( self.perks[ itembundle.ref ] ) ) );
    }
}

// Namespace wz_perks
// Params 0
// Checksum 0x68d35c00, Offset: 0x5ba
// Size: 0x234
function function_5a5ce83a5fc1c82c()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        level waittill( #"hash_7dcad959a10ea3e5", player );
        
        if ( isdefined( player.lootperks ) )
        {
            foreach ( perk in player.lootperks )
            {
                if ( !isdefined( player.perks[ perk ] ) )
                {
                    player perk::giveperk( perk );
                }
            }
            
            if ( !player hasspecialist() )
            {
                spawnoptions = common_item::items_initspawnoptions_spawnfromposition( player.origin, player.angles );
                
                foreach ( perk in player getloadoutperks() )
                {
                    if ( arraycontains( player.lootperks, perk ) )
                    {
                        player function_19e456ae2c6452ec( perk, spawnoptions, 0 );
                    }
                }
            }
            else if ( getdvarint( @"br_perk_package_dropping_enabled", 1 ) )
            {
                player function_ef2b67ac76d8f44a();
            }
        }
        
        foreach ( perk in player.fieldguides )
        {
            if ( !isdefined( player.perks[ perk ] ) )
            {
                player perk::giveperk( perk );
            }
        }
        
        if ( isdefined( player ) )
        {
            player function_173a7a25c20d9891();
        }
    }
}

// Namespace wz_perks
// Params 1
// Checksum 0x3799a7fc, Offset: 0x7f6
// Size: 0xcb
function function_ee59ed919082db65( spawnoptions )
{
    if ( getdvarint( @"br_perk_package_dropping_enabled", 1 ) )
    {
        function_ef2b67ac76d8f44a( spawnoptions );
    }
    
    if ( !( isdefined( spawnoptions ) && isdefined( level.var_d846c03ec30479ec ) ) || !spawnoptions.isdeathevent )
    {
        return;
    }
    
    if ( hasspecialist() )
    {
        removespecialist();
        bundlename = utility::callsharedfunc( #"game", #"getItemBundleNameFromRef", level.var_d846c03ec30479ec );
        
        if ( bundlename && getscriptbundlefieldvalue( bundlename, #"hash_18f00030f4f94bce" ) && getdvarint( @"hash_3efd089f56708aee", 1 ) )
        {
            dropspecialist( spawnoptions );
        }
    }
    
    function_70a5afcd0e05c214();
    function_c746cd65360d1ca();
}

// Namespace wz_perks
// Params 1
// Checksum 0xbae422ce, Offset: 0x8c9
// Size: 0xf7
function function_b6eab3b11516131e( perkref )
{
    if ( getdvarint( @"br_perk_package_dropping_enabled", 1 ) )
    {
        function_ef2b67ac76d8f44a();
    }
    
    specialistperk = perkref;
    
    if ( isdefined( self.lootperks ) && isdefined( specialistperk ) )
    {
        spawnoptions = common_item::items_initspawnoptions_spawnfromposition( self.origin, self.angles );
        lootperks = arraycopy( self.lootperks );
        
        foreach ( perk in lootperks )
        {
            if ( perk != specialistperk )
            {
                function_19e456ae2c6452ec( perk, spawnoptions );
            }
        }
    }
}

// Namespace wz_perks
// Params 0
// Checksum 0x7c2aa3, Offset: 0x9c8
// Size: 0x87
function removespecialist()
{
    if ( self.hasspecialist && level.var_d846c03ec30479ec )
    {
        if ( isdefined( self.perks[ level.var_d846c03ec30479ec ] ) )
        {
            perk::removeperk( level.var_d846c03ec30479ec );
        }
        
        if ( self.lootperks && arraycontains( self.lootperks, level.var_d846c03ec30479ec ) )
        {
            self.lootperks = arrayremove( self.lootperks, level.var_d846c03ec30479ec );
        }
    }
}

// Namespace wz_perks
// Params 1
// Checksum 0xeab22fc, Offset: 0xa57
// Size: 0x57
function dropspecialist( var_3b8f1509495546fd )
{
    spawnoptions = var_3b8f1509495546fd ?? common_item::items_initspawnoptions_spawnfromposition( self.origin, self.angles );
    spawnoptions.critical = 1;
    common_item::function_325e28c0fb65c36a( level.var_d846c03ec30479ec, 1, spawnoptions );
}

// Namespace wz_perks
// Params 2
// Checksum 0x2427010c, Offset: 0xab6
// Size: 0x7e
function function_e8f7de6823c055cc( perk, removeperkfromplayer = 1 )
{
    if ( isdefined( perk ) && isdefined( self.lootperks ) && arraycontains( self.lootperks, perk ) )
    {
        self.lootperks = arrayremove( self.lootperks, perk );
        
        if ( removeperkfromplayer && isdefined( self.perks[ perk ] ) )
        {
            perk::removeperk( perk );
        }
        
        return 1;
    }
}

// Namespace wz_perks
// Params 3
// Checksum 0xa1bbec9a, Offset: 0xb3c
// Size: 0x6c
function function_19e456ae2c6452ec( perk, var_3b8f1509495546fd, removeperkfromplayer = 1 )
{
    if ( function_e8f7de6823c055cc( perk, removeperkfromplayer ) )
    {
        spawnoptions = var_3b8f1509495546fd ?? common_item::items_initspawnoptions_spawnfromposition( self.origin, self.angles );
        common_item::function_325e28c0fb65c36a( perk, 1, spawnoptions );
        return 1;
    }
}

// Namespace wz_perks
// Params 0
// Checksum 0xc423ccd0, Offset: 0xbb0
// Size: 0xa1
function function_70a5afcd0e05c214()
{
    if ( self.lootperks )
    {
        foreach ( perk in self.lootperks )
        {
            if ( isdefined( self.perks[ perk ] ) )
            {
                perk::removeperk( perk );
            }
        }
    }
    
    self.lootperks = undefined;
}

// Namespace wz_perks
// Params 0
// Checksum 0xdc6fb1b1, Offset: 0xc59
// Size: 0xa1
function function_c746cd65360d1ca()
{
    if ( self.fieldguides )
    {
        foreach ( perk in self.fieldguides )
        {
            if ( isdefined( self.perks[ perk ] ) )
            {
                perk::removeperk( perk );
            }
        }
    }
    
    self.fieldguides = undefined;
}

// Namespace wz_perks
// Params 1
// Checksum 0x880f5fb4, Offset: 0xd02
// Size: 0x1e
function onplayerdeath( data )
{
    data.victim function_173a7a25c20d9891();
}

// Namespace wz_perks
// Params 1
// Checksum 0xbafab928, Offset: 0xd28
// Size: 0xf0
function function_ec3ad05aae1b3c22( item )
{
    function_ef2b67ac76d8f44a();
    
    if ( isdefined( item.perks ) )
    {
        spawnoptions = common_item::items_initspawnoptions_spawnfromposition( self.origin, self.angles );
        
        foreach ( perk in item.perks )
        {
            class::loadout_giveperk( perk );
            
            if ( isdefined( self.lootperks ) && arraycontains( self.lootperks, perk ) )
            {
                function_19e456ae2c6452ec( perk, spawnoptions );
            }
        }
    }
    
    function_173a7a25c20d9891();
}

// Namespace wz_perks
// Params 1
// Checksum 0xfbf2f042, Offset: 0xe20
// Size: 0x4e
function function_ef2b67ac76d8f44a( var_3b8f1509495546fd )
{
    self notify( #"hash_7374678177842999" );
    self endon( #"hash_7374678177842999" );
    self endon( #"death_or_disconnect" );
    loadoutperks = getloadoutperks();
    return dropperkpack( loadoutperks, 1, var_3b8f1509495546fd );
}

// Namespace wz_perks
// Params 3
// Checksum 0x12de4ebb, Offset: 0xe77
// Size: 0x19f
function dropperkpack( perks, var_c33859008560e477, var_3b8f1509495546fd )
{
    if ( perks.size > 0 )
    {
        spawnoptions = var_3b8f1509495546fd ?? common_item::items_initspawnoptions_spawnfromposition( self.origin, self.angles );
        spawnoptions.payload = [ #"customperkpackage" ];
        perklist = [];
        
        foreach ( perk in perks )
        {
            perkid = level.var_d97c85f03eff6eca[ perk ];
            
            if ( isdefined( perkid ) )
            {
                spawnoptions.payload[ spawnoptions.payload.size ] = perkid + 1;
                perklist[ perklist.size ] = perk;
            }
            
            if ( var_c33859008560e477 && isdefined( self.perks[ perk ] ) )
            {
                class::loadout_removeperk( perk );
            }
        }
        
        while ( spawnoptions.payload.size < 5 )
        {
            spawnoptions.payload[ spawnoptions.payload.size ] = 0;
        }
        
        perksitem = common_item::items_spawnitemfromscriptable( "brloot_perk_custom_pack", 1, spawnoptions );
        perksitem.perks = perklist;
        spawnoptions.payload = undefined;
        return perksitem;
    }
}

// Namespace wz_perks
// Params 0
// Checksum 0x59fb7262, Offset: 0x101e
// Size: 0xcc
function getloadoutperks()
{
    var_d729a2def84cf0f6 = [];
    defaultperks = class::function_c8d9816a5c9f1f97( self );
    
    if ( isdefined( self.loadoutperks ) )
    {
        foreach ( perk in self.loadoutperks )
        {
            if ( isdefined( level.cacperks[ perk ] ) && !arraycontains( defaultperks, perk ) && !arraycontains( var_d729a2def84cf0f6, perk ) )
            {
                var_d729a2def84cf0f6[ var_d729a2def84cf0f6.size ] = perk;
            }
        }
    }
    
    return var_d729a2def84cf0f6;
}

// Namespace wz_perks
// Params 0
// Checksum 0xb9b77edd, Offset: 0x10f3
// Size: 0xaf
function function_7f245ad6b70c39c9()
{
    var_9d16f7c3b9d75309 = isdefined( self.lootperks ) ? arraycopy( self.lootperks ) : [];
    
    foreach ( perk in var_9d16f7c3b9d75309 )
    {
        if ( !isdefined( self.perks[ perk ] ) )
        {
            var_9d16f7c3b9d75309 = arrayremove( var_9d16f7c3b9d75309, perk );
        }
    }
    
    return var_9d16f7c3b9d75309;
}

// Namespace wz_perks
// Params 0
// Checksum 0x96e7ef14, Offset: 0x11ab
// Size: 0xae
function function_2dde7c1477a76dcf()
{
    var_6e1c6af78ad9291a = self.fieldguides ? arraycopy( self.fieldguides ) : [];
    
    foreach ( perk in var_6e1c6af78ad9291a )
    {
        if ( !isdefined( self.perks[ perk ] ) )
        {
            var_6e1c6af78ad9291a = arrayremove( var_6e1c6af78ad9291a, perk );
        }
    }
    
    return var_6e1c6af78ad9291a;
}

// Namespace wz_perks
// Params 0
// Checksum 0xd16ea8db, Offset: 0x1262
// Size: 0x16, Type: bool
function hasspecialist()
{
    return isdefined( self.perks[ level.var_d846c03ec30479ec ] );
}

// Namespace wz_perks
// Params 0
// Checksum 0x3482f94e, Offset: 0x1281
// Size: 0x120
function function_173a7a25c20d9891()
{
    lootedperks = function_7f245ad6b70c39c9();
    fieldguides = function_2dde7c1477a76dcf();
    loadoutperks = getloadoutperks();
    
    if ( fieldguides )
    {
        lootedperks = arraycombineunique( lootedperks, fieldguides );
    }
    
    packeddata = packperks( lootedperks, fieldguides );
    self setclientomnvar( "ui_br_perks_looted", packeddata );
    packeddata = packperks( loadoutperks );
    self setclientomnvar( "ui_br_perks_loadout", packeddata );
    
    if ( hasspecialist() )
    {
        loadoutperks = [ "specialty_specialist" ];
    }
    
    perks::setomnvarsforperklist( "ui_spawn_perk_", loadoutperks, [] );
    
    /#
        if ( self.var_ac16dedf8ba45d3a )
        {
            foreach ( callback in self.var_ac16dedf8ba45d3a )
            {
                self [[ callback ]]();
            }
        }
    #/
}

// Namespace wz_perks
// Params 0
// Checksum 0x97abfc22, Offset: 0x13a9
// Size: 0x45
function function_6a22240a701a68d3()
{
    perk::giveperk( "specialty_spawn_parachute_protection" );
    
    if ( !isdefined( self.fieldguides ) )
    {
        self.fieldguides = [];
    }
    
    self.fieldguides[ self.fieldguides.size ] = "specialty_spawn_parachute_protection";
    function_173a7a25c20d9891();
}

// Namespace wz_perks
// Params 0
// Checksum 0x4dbc8353, Offset: 0x13f6
// Size: 0x30
function function_8453bf6d1d43d60a()
{
    perk::removeperk( "specialty_spawn_parachute_protection" );
    self.fieldguides = arrayremove( self.fieldguides, "specialty_spawn_parachute_protection" );
    function_173a7a25c20d9891();
}

// Namespace wz_perks
// Params 2, eflags: 0x4
// Checksum 0xc8646311, Offset: 0x142e
// Size: 0x14d
function private packperks( perks, fieldguides )
{
    packeddata = 0;
    
    if ( hasspecialist() )
    {
        perkid = perks::function_6a1d4ff37648a594( level.var_d846c03ec30479ec );
        packeddata |= 1 << perkid;
    }
    else
    {
        foreach ( perkref in perks )
        {
            perkid = perks::function_6a1d4ff37648a594( perkref );
            
            if ( isdefined( perkid ) )
            {
                packeddata |= 1 << perkid;
            }
        }
    }
    
    foreach ( perkref in fieldguides )
    {
        perkid = perks::function_6a1d4ff37648a594( perkref );
        
        if ( isdefined( perkid ) )
        {
            packeddata |= 1 << perkid;
        }
    }
    
    return packeddata;
}

// Namespace wz_perks
// Params 1, eflags: 0x4
// Checksum 0x6fcafba0, Offset: 0x1584
// Size: 0x29
function private function_61cc3dc03e4c0b75( params )
{
    if ( level.var_d97c85f03eff6eca.size > 32 )
    {
        assertmsg( "<dev string:x24>" );
    }
}

// Namespace wz_perks
// Params 1, eflags: 0x4
// Checksum 0xc86b2062, Offset: 0x15b5
// Size: 0xd8
function private function_971fe331e52e42bd( params )
{
    if ( params.spawnoptions.analyticssource != #"br_loot_cache_locked" )
    {
        return;
    }
    
    if ( !isdefined( params.contentsspawned ) )
    {
        return;
    }
    
    foreach ( item in params.contentsspawned )
    {
        if ( item.type == #"brloot_perk_specialist_saw" )
        {
            item.critical = 1;
        }
    }
}

/#

    // Namespace wz_perks
    // Params 2, eflags: 0x4
    // Checksum 0xb97c310f, Offset: 0x1695
    // Size: 0x46, Type: dev
    function private handledevcommand( command, args )
    {
        switch ( command )
        {
            case #"dropperkpack":
                level.players[ 0 ] dropperkpack( args, 0 );
                break;
        }
    }

#/
