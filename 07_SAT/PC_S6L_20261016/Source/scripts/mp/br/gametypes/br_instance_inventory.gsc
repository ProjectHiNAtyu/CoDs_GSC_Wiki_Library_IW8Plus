// scripts\mp\br\gametypes\br_instance_inventory.gsc  (hash_069ea0c12304c130.gscc) (size: 41969 Bytes / 0xa3f1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x95a022e8 (2510299880)
// size ...... 41969 (0xa3f1)
// includes .. 20  (offset: 0x9d1d)
// strings ... 44  (offset: 0x9dbd)
// dev strs .. 49  (offset: 0xa155)
// exports ... 132 (offset: 0x66f5)
// cseg ...... 0x2ba + 0x643b (0x66f5)
// imports ... 232 (offset: 0x7b95)
// animtree1 . 0   (offset: 0xa3f1)
// animtree2 . 0   (offset: 0xa3f1)
#using scripts\common\ae_utility;
#using scripts\common\gasmask;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\armor;
#using scripts\mp\br\gametypes\br_default_inventory;
#using scripts\mp\br\gametypes\br_dmz_inventory;
#using scripts\mp\br\gametypes\br_gametype_dmz;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\challenges;
#using scripts\mp\class;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\teams;
#using scripts\mp\equipment;
#using scripts\mp\hud_util;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\operator;
#using scripts\mp\supers;
#using scripts\mp\weapons;

#namespace br_instance_inventory;

// Namespace br_instance_inventory
// Params 0
// Checksum 0xc5c95547, Offset: 0x2d8
// Size: 0xd4
function init()
{
    utility::registersharedfunc( #"instanceInventory", #"getupgradecount", &getupgradecount );
    utility::registersharedfunc( #"instanceInventory", #"hash_4d5a3eae568d5bf5", &function_a06f3442460db38d );
    utility::registersharedfunc( #"instanceInventory", #"getnumstartupgradeplates", &getnumstartupgradeplates );
    utility::registersharedfunc( #"instanceInventory", #"isenabled", &function_926a8f8643d34690 );
    utility::registersharedfunc( #"instanceInventory", #"inventoryisvalid", &inventoryisvalid );
    utility::registersharedfunc( #"instanceInventory", #"hash_4cd131c09ba7529a", &function_81d251869e7458a5 );
    utility::registersharedfunc( #"instanceInventory", #"hash_10edfd81317fb1b4", &function_b20335f6717f79ab );
}

// Namespace br_instance_inventory
// Params 0
// Checksum 0xe40eaa0d, Offset: 0x3b4
// Size: 0x86
function initteamdatafields()
{
    foreach ( team in level.teamnamelist )
    {
        level.teamdata[ team ][ "extractedStashItems" ] = [];
    }
}

// Namespace br_instance_inventory
// Params 2
// Checksum 0x4f824b5e, Offset: 0x442
// Size: 0x57
function function_cf3a7f7cf63fd736( player, lootid )
{
    extractedstashitems = teams::getteamdata( player.team, "extractedStashItems" );
    extractedstashitems[ lootid ] = 1;
    teams::setteamdata( player.team, "extractedStashItems", extractedstashitems );
}

// Namespace br_instance_inventory
// Params 0
// Checksum 0x3632bf88, Offset: 0x4a1
// Size: 0x2e
function function_926a8f8643d34690()
{
    if ( !isdefined( level.instance_inventory_enabled ) )
    {
        level.instance_inventory_enabled = getdvarint( @"hash_a31e837c3d3a9c9", 0 );
    }
    
    return level.instance_inventory_enabled;
}

// Namespace br_instance_inventory
// Params 0
// Checksum 0x2a7aff5c, Offset: 0x4d8
// Size: 0x2e
function function_e19d6e094a0f9a89()
{
    if ( !isdefined( level.var_10aa664933a3ead0 ) )
    {
        level.var_10aa664933a3ead0 = getdvarint( @"hash_3a0b46b826670c2b", 0 );
    }
    
    return level.var_10aa664933a3ead0;
}

// Namespace br_instance_inventory
// Params 0
// Checksum 0x69fcff3, Offset: 0x50f
// Size: 0x2f
function function_75674668346b4a49()
{
    if ( !isdefined( level.var_6c42738614c97ab5 ) )
    {
        level.var_6c42738614c97ab5 = getdvarint( @"hash_effdf75f46ecb806", 1 );
    }
    
    return level.var_6c42738614c97ab5;
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0xc26d2e9e, Offset: 0x547
// Size: 0x12
function inventoryisvalid( player )
{
    return player function_bcc29d70f0e86b37();
}

// Namespace br_instance_inventory
// Params 4
// Checksum 0x3fef678d, Offset: 0x562
// Size: 0x331
function function_b20335f6717f79ab( player, struct, class, var_4d5575c6f9ec8a5b )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    classindex = class::getclassindex( class );
    self.class_num = classindex;
    struct.loadoutarchetype = class::cac_getcharacterarchetype();
    primaryweaponstruct = getloadoutweaponstruct( self, 0 );
    struct.loadoutprimary = primaryweaponstruct.weaponref;
    maxprimaryattachments = weapon::getmaxprimaryattachments( class::function_facf39de1a82731a() );
    
    for ( attachmentindex = 0; attachmentindex < maxprimaryattachments ; attachmentindex++ )
    {
        struct.loadoutprimaryattachments[ attachmentindex ] = primaryweaponstruct.attachmentrefs[ attachmentindex ];
        struct.loadoutprimaryattachmentids[ attachmentindex ] = primaryweaponstruct.attachmentids[ attachmentindex ];
        tuningvalues = primaryweaponstruct.var_b3ca7b468de89ea3[ attachmentindex ];
        
        if ( isdefined( tuningvalues ) )
        {
            struct.var_57a15af46a205668[ struct.loadoutprimaryattachments[ attachmentindex ] ] = tuningvalues;
        }
    }
    
    struct.loadoutprimarycamo = primaryweaponstruct.weaponcamo;
    struct.loadoutprimaryreticle = primaryweaponstruct.weaponreticle;
    struct.loadoutprimarylootitemid = primaryweaponstruct.lootitemid;
    struct.loadoutprimaryvariantid = primaryweaponstruct.weaponvariant;
    struct.loadoutprimarycosmeticattachment = primaryweaponstruct.weaponcosmetic;
    
    for ( stickerindex = 0; stickerindex < 5 ; stickerindex++ )
    {
        struct.loadoutprimarystickers[ stickerindex ] = primaryweaponstruct.weaponstickers[ stickerindex ];
    }
    
    secondaryweaponstruct = getloadoutweaponstruct( self, 1 );
    struct.loadoutsecondary = secondaryweaponstruct.weaponref;
    maxsecondaryattachments = weapon::getmaxsecondaryattachments( class::function_facf39de1a82731a() );
    
    for ( attachmentindex = 0; attachmentindex < maxsecondaryattachments ; attachmentindex++ )
    {
        struct.loadoutsecondaryattachments[ attachmentindex ] = secondaryweaponstruct.attachmentrefs[ attachmentindex ];
        struct.loadoutsecondaryattachmentids[ attachmentindex ] = secondaryweaponstruct.attachmentids[ attachmentindex ];
        tuningvalues = undefined;
        
        if ( isdefined( tuningvalues ) )
        {
            struct.var_f2b8977772330320[ struct.loadoutsecondaryattachments[ attachmentindex ] ] = tuningvalues;
        }
    }
    
    struct.loadoutsecondarycamo = secondaryweaponstruct.weaponcamo;
    struct.loadoutsecondaryreticle = secondaryweaponstruct.weaponreticle;
    struct.loadoutsecondarylootitemid = secondaryweaponstruct.lootitemid;
    struct.loadoutsecondaryvariantid = secondaryweaponstruct.weaponvariant;
    struct.loadoutsecondarycosmeticattachment = secondaryweaponstruct.weaponcosmetic;
    
    for ( stickerindex = 0; stickerindex < 5 ; stickerindex++ )
    {
        struct.loadoutsecondarystickers[ stickerindex ] = secondaryweaponstruct.weaponstickers[ stickerindex ];
    }
    
    function_81d251869e7458a5( self, struct );
}

// Namespace br_instance_inventory
// Params 2
// Checksum 0xee6c644b, Offset: 0x89b
// Size: 0x252
function function_81d251869e7458a5( player, struct )
{
    if ( !function_926a8f8643d34690() || !inventoryisvalid( player ) )
    {
        return;
    }
    
    lootid = player function_41f811caf4053d98( 1, 2 ).lootid;
    loottype = loot::function_52cf8374c44a4ff5( lootid );
    
    if ( loottype == "weapon" )
    {
        loottype = "equipment";
    }
    
    if ( loottype == "equipment" )
    {
        struct.loadoutequipmentprimary = loot::function_f54ecb89dfab8e8c( lootid );
        struct.var_a1191d5606e653f0 = function_4d465a88a4c974d3( lootid );
        
        if ( struct.var_a1191d5606e653f0 > 0 )
        {
            struct.loadoutequipmentprimary = equipment_mp::function_e7be0aab8fa729de( struct.loadoutequipmentprimary );
        }
    }
    
    lootid = player function_41f811caf4053d98( 1, 3 ).lootid;
    loottype = loot::function_52cf8374c44a4ff5( lootid );
    
    if ( loottype == "weapon" )
    {
        loottype = "equipment";
    }
    
    if ( loottype == "equipment" )
    {
        struct.loadoutequipmentsecondary = loot::function_f54ecb89dfab8e8c( lootid );
        struct.var_9481e959139fe88 = function_4d465a88a4c974d3( lootid );
        
        if ( struct.var_9481e959139fe88 > 0 )
        {
            struct.loadoutequipmentsecondary = equipment_mp::function_e7be0aab8fa729de( struct.loadoutequipmentsecondary );
        }
    }
    
    lootid = player function_41f811caf4053d98( 1, 4 ).lootid;
    loottype = loot::function_52cf8374c44a4ff5( lootid );
    
    if ( loottype == "super" )
    {
        struct.loadoutfieldupgrade1 = loot::function_f54ecb89dfab8e8c( lootid );
    }
    
    operatorskin = function_8685c66344a4bff0( player );
    struct.loadoutstreaksfilled = 1;
    lootid = player function_41f811caf4053d98( 65535, 0 ).lootid;
    loottype = loot::function_52cf8374c44a4ff5( lootid );
    
    if ( loottype == "killstreak" )
    {
        struct.loadoutkillstreak1 = loot::function_f54ecb89dfab8e8c( lootid );
        return;
    }
    
    if ( isdefined( operatorskin ) )
    {
        defaultkillstreak = operator::function_233474e80ffd30( operatorskin );
        
        if ( isdefined( defaultkillstreak ) )
        {
            assert( loot::function_52cf8374c44a4ff5( defaultkillstreak ) == "<dev string:x24>" );
            struct.loadoutkillstreak1 = loot::function_f54ecb89dfab8e8c( defaultkillstreak );
            function_26cf1ad6f45e326d( player, defaultkillstreak );
        }
    }
}

// Namespace br_instance_inventory
// Params 3
// Checksum 0xeda67570, Offset: 0xaf5
// Size: 0x4b2
function function_4da778f38e8b3044( player, location, sublocation )
{
    struct = spawnstruct();
    instance = player function_41f811caf4053d98( location, sublocation );
    
    if ( level.var_d7a6922678396d33 && ( !isdefined( instance ) || instance.lootid == 0 ) )
    {
        struct.lootitemid = 0;
        struct.weaponref = level.defaultfist;
        struct.weaponvariant = 0;
    }
    else
    {
        loottype = loot::function_52cf8374c44a4ff5( instance.lootid );
        
        if ( loottype == "weapon" )
        {
            struct.lootitemid = instance.lootid;
        }
        else
        {
            struct.lootitemid = 0;
        }
        
        struct.weaponref = loot::function_f54ecb89dfab8e8c( struct.lootitemid );
        struct.weaponvariant = function_4d465a88a4c974d3( struct.lootitemid );
    }
    
    struct.attachmentrefs = [];
    struct.attachmentids = [];
    struct.var_b3ca7b468de89ea3 = [];
    struct.weaponcamo = "none";
    struct.weaponreticle = "none";
    struct.weaponcosmetic = "none";
    struct.weaponstickers = [];
    
    if ( struct.lootitemid == 0 )
    {
        return struct;
    }
    
    rootname = weapon::getweaponrootname( struct.weaponref );
    weaponassetname = weapon::weaponassetnamemap( rootname );
    childids = instance.var_a834790f492b07f8;
    
    for ( attachmentoffset = 0; attachmentoffset <= 4 ; attachmentoffset++ )
    {
        attachref = "none";
        attachlootid = 0;
        attachmentindex = 0 + attachmentoffset;
        struct.attachmentids[ attachmentoffset ] = 0;
        
        if ( isdefined( childids[ attachmentindex ] ) )
        {
            attachlootid = childids[ attachmentindex ];
            loottype = loot::function_52cf8374c44a4ff5( attachlootid );
            
            if ( isdefined( attachlootid ) && attachlootid != 0 && loottype == "attachment" )
            {
                attachref = loot::function_5fea6a6dee392b8( attachlootid, weaponassetname );
                struct.attachmentids[ attachmentoffset ] = weapons::function_5a8beea9d65ebe8f( weaponassetname, attachref, childids[ attachmentindex ] );
            }
        }
        
        struct.attachmentrefs[ attachmentoffset ] = attachref;
    }
    
    if ( isdefined( instance.var_c11bbd62e8f23645 ) )
    {
        for ( i = 2; i <= 6 ; i++ )
        {
            value = function_9513862f69ec0498( i, instance, 1 );
            
            if ( isdefined( value ) && int( value ) != 0 )
            {
                value = int( value );
                valuex = value & 255;
                valuey = value >> 8;
                struct.var_b3ca7b468de89ea3[ i - 2 ] = [ function_4bd7309db3ebaf5c( valuex ), function_4bd7309db3ebaf5c( valuey ) ];
            }
        }
    }
    
    loottype = loot::function_52cf8374c44a4ff5( childids[ 5 ] );
    
    if ( isdefined( childids[ 5 ] ) && loottype == "camo" )
    {
        weaponcamo = loot::function_f54ecb89dfab8e8c( childids[ 5 ] );
        bundledata = getscriptbundlefieldvalues( weaponcamo, [ #"ref" ] );
        struct.weaponcamo = bundledata.ref;
    }
    
    loottype = loot::function_52cf8374c44a4ff5( childids[ 6 ] );
    
    if ( isdefined( childids ) && isdefined( childids[ 6 ] && isdefined( loottype ) && loottype == "reticle" ) )
    {
        struct.weaponreticle = loot::function_f54ecb89dfab8e8c( childids[ 6 ] );
    }
    
    loottype = loot::function_52cf8374c44a4ff5( childids[ 7 ] );
    
    if ( isdefined( childids[ 7 ] ) && isdefined( loottype ) && ( loottype == "gun_screen" || loottype == "weapon_charm" ) )
    {
        struct.weaponcosmetic = loot::function_f54ecb89dfab8e8c( childids[ 7 ] );
    }
    
    for ( stickeroffset = 0; stickeroffset <= 4 ; stickeroffset++ )
    {
        stickerref = "sticker_none";
        stickerindex = stickeroffset + 8;
        loottype = loot::function_52cf8374c44a4ff5( childids[ stickerindex ] );
        
        if ( isdefined( childids[ stickerindex ] ) && loottype == "sticker" )
        {
            lootid = childids[ stickerindex ];
            
            if ( isdefined( lootid ) && lootid != 0 )
            {
                stickerref = loot::function_f54ecb89dfab8e8c( lootid );
            }
        }
        
        struct.weaponstickers[ stickeroffset ] = stickerref;
    }
    
    return struct;
}

// Namespace br_instance_inventory
// Params 2
// Checksum 0xbe705c9b, Offset: 0xfb0
// Size: 0x35
function getloadoutweaponstruct( player, weaponslot )
{
    sublocation = function_bbf8e7e9f82d2b2( weaponslot );
    return function_4da778f38e8b3044( player, 1, sublocation );
}

// Namespace br_instance_inventory
// Params 3, eflags: 0x4
// Checksum 0xf6292d11, Offset: 0xfee
// Size: 0x58
function private function_b86acd5b5496f84d( player, location, sublocation )
{
    instance = player function_41f811caf4053d98( location, sublocation );
    
    if ( instance.instanceid != "0" )
    {
        player function_1fe0234f56138fe1( instance.instanceid );
    }
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0xb3919da1, Offset: 0x104e
// Size: 0x19
function function_bbf8e7e9f82d2b2( weaponslot )
{
    return weaponslot == 0 ? 0 : 1;
}

// Namespace br_instance_inventory
// Params 2
// Checksum 0x7c5b107c, Offset: 0x1070
// Size: 0x54
function function_843e185e3cd37eb1( player, slot )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    if ( slot == 2 )
    {
        return player function_41f811caf4053d98( 2, 0 );
    }
    
    instanceslot = function_bbf8e7e9f82d2b2( slot );
    return player function_41f811caf4053d98( 1, instanceslot );
}

// Namespace br_instance_inventory
// Params 4
// Checksum 0x8750c105, Offset: 0x10cc
// Size: 0xc1
function function_9e6e0e24612d44e0( player, weaponobj, var_fbbec105d2e96d39, metadata )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    if ( var_fbbec105d2e96d39 )
    {
        function_b86acd5b5496f84d( player, 2, 0 );
    }
    
    function_5b445333c898cc36( player, 11, 2, 0, weaponobj );
    function_1623eb4516fd9e08( player, 2, 0 );
    
    if ( isdefined( metadata ) )
    {
        instance = player function_41f811caf4053d98( 2, 0 );
        securemetadata = function_81744e4202152fa2( metadata[ 0 ] );
        var_c11bbd62e8f23645 = function_81744e4202152fa2( metadata[ 1 ] );
        function_7ccc2499aab17e71( player, instance, securemetadata, var_c11bbd62e8f23645 );
        
        /#
            debugprintmetadata( player function_41f811caf4053d98( 2, 0 ) );
        #/
    }
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0xde5c2858, Offset: 0x1195
// Size: 0xc4
function function_81744e4202152fa2( metadata )
{
    metadataarray = [];
    
    if ( isdefined( metadata ) )
    {
        foreach ( data in metadata )
        {
            currentsize = metadataarray.size;
            metadataarray[ currentsize ] = [];
            metadataarray[ currentsize ][ 0 ] = data.key;
            metadataarray[ currentsize ][ 1 ] = int( data.value );
        }
    }
    
    return metadataarray;
}

// Namespace br_instance_inventory
// Params 4
// Checksum 0xa1353911, Offset: 0x1262
// Size: 0x245
function function_a13ba32f33d59647( keys, values, instance, var_c11bbd62e8f23645 )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    if ( !( isdefined( keys ) && isdefined( values ) && isdefined( instance ) ) )
    {
        return;
    }
    
    if ( !isarray( keys ) )
    {
        keys = [ keys ];
    }
    
    if ( !isarray( values ) )
    {
        values = [ values ];
    }
    
    if ( keys.size != values.size )
    {
        assertmsg( "<dev string:x2f>" );
    }
    
    var_92b95b284f1a3092 = [];
    oldmetadata = instance.metadata;
    
    if ( var_c11bbd62e8f23645 )
    {
        oldmetadata = instance.var_c11bbd62e8f23645;
    }
    
    var_6a8192f6dc846d84 = 0;
    
    if ( var_c11bbd62e8f23645 )
    {
        var_6a8192f6dc846d84 = 0;
    }
    
    foreach ( index, key in keys )
    {
        unusedslot = undefined;
        
        foreach ( dataindex, data in oldmetadata )
        {
            if ( data.key == key )
            {
                currentsize = var_92b95b284f1a3092.size;
                var_92b95b284f1a3092[ currentsize ] = [];
                var_92b95b284f1a3092[ currentsize ][ 0 ] = key;
                var_92b95b284f1a3092[ currentsize ][ 1 ] = values[ index ];
                unusedslot = undefined;
                break;
            }
            
            if ( data.key == var_6a8192f6dc846d84 )
            {
                unusedslot = dataindex;
            }
        }
        
        if ( isdefined( unusedslot ) )
        {
            oldmetadata[ unusedslot ].key = key;
            oldmetadata[ unusedslot ].value = values[ index ];
            currentsize = var_92b95b284f1a3092.size;
            var_92b95b284f1a3092[ currentsize ] = [];
            var_92b95b284f1a3092[ currentsize ][ 0 ] = key;
            var_92b95b284f1a3092[ currentsize ][ 1 ] = values[ index ];
        }
    }
    
    return var_92b95b284f1a3092;
}

// Namespace br_instance_inventory
// Params 4
// Checksum 0x99673f4b, Offset: 0x14b0
// Size: 0x2fe
function function_1623eb4516fd9e08( player, location, sublocation, dontupdateammo )
{
    weaponstruct = function_4da778f38e8b3044( player, location, sublocation );
    rootname = weapon::getweaponrootname( weaponstruct.weaponref );
    player setplayerdata( level.var_6f9b00680ed002d8, "dmzWeapon", "weapon", rootname );
    player setplayerdata( level.var_6f9b00680ed002d8, "dmzWeapon", "variantID", weaponstruct.weaponvariant );
    player setplayerdata( level.var_6f9b00680ed002d8, "dmzWeapon", "lootItemID", weaponstruct.lootitemid );
    playerdataindex = 0;
    
    if ( isdefined( weaponstruct.attachmentrefs ) )
    {
        for ( attachmentindex = 0; attachmentindex < weaponstruct.attachmentrefs.size ; attachmentindex++ )
        {
            player setplayerdata( level.var_6f9b00680ed002d8, "dmzWeapon", "attachmentSetup", playerdataindex, "attachment", weaponstruct.attachmentrefs[ attachmentindex ] );
            player setplayerdata( level.var_6f9b00680ed002d8, "dmzWeapon", "attachmentSetup", playerdataindex, "variantID", weaponstruct.attachmentids[ attachmentindex ] );
            
            if ( isdefined( weaponstruct.var_b3ca7b468de89ea3[ attachmentindex ] ) )
            {
                player setplayerdata( level.var_6f9b00680ed002d8, "dmzWeapon", "attachmentSetup", playerdataindex, "customTune", 0, function_cc48710279fdc53e( weaponstruct.var_b3ca7b468de89ea3[ attachmentindex ][ 0 ] ) );
                player setplayerdata( level.var_6f9b00680ed002d8, "dmzWeapon", "attachmentSetup", playerdataindex, "customTune", 1, function_cc48710279fdc53e( weaponstruct.var_b3ca7b468de89ea3[ attachmentindex ][ 1 ] ) );
            }
            
            playerdataindex++;
        }
    }
    
    if ( isdefined( weaponstruct.weaponcamo ) )
    {
        player setplayerdata( level.var_6f9b00680ed002d8, "dmzWeapon", "camo", weaponstruct.weaponcamo );
    }
    
    if ( isdefined( weaponstruct.weaponreticle ) )
    {
        player setplayerdata( level.var_6f9b00680ed002d8, "dmzWeapon", "reticle", weaponstruct.weaponreticle );
    }
    
    if ( isdefined( weaponstruct.weaponcosmetic ) )
    {
        player setplayerdata( level.var_6f9b00680ed002d8, "dmzWeapon", "cosmeticAttachment", weaponstruct.weaponcosmetic );
    }
    
    if ( isdefined( weaponstruct.weaponstickers ) )
    {
        for ( stickerindex = 0; stickerindex < weaponstruct.weaponstickers.size ; stickerindex++ )
        {
            if ( isdefined( weaponstruct.weaponstickers[ stickerindex ] ) )
            {
                player setplayerdata( level.var_6f9b00680ed002d8, "dmzWeapon", "sticker", stickerindex, weaponstruct.weaponstickers[ stickerindex ] );
            }
        }
    }
    
    br_default_inventory::function_3b53d6fa7c7ed259( player );
    
    if ( !dontupdateammo )
    {
        br_default_inventory::function_ba03dc5a721b978b( player );
    }
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0x6760d412, Offset: 0x17b6
// Size: 0x3e
function function_ce6e11615519b246( player )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    var_1827e45669a6c403 = player function_41f811caf4053d98( 2, 0 );
    player function_1fe0234f56138fe1( var_1827e45669a6c403.instanceid );
}

// Namespace br_instance_inventory
// Params 5
// Checksum 0x83a9cddb, Offset: 0x17fc
// Size: 0xd3
function function_72c9ea7f1f09c391( player, weaponobj, weaponslot, var_fbbec105d2e96d39, metadata )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    sublocation = function_bbf8e7e9f82d2b2( weaponslot );
    
    if ( var_fbbec105d2e96d39 )
    {
        function_b86acd5b5496f84d( player, 1, sublocation );
    }
    
    function_5b445333c898cc36( player, 11, 1, sublocation, weaponobj );
    
    if ( isdefined( metadata ) )
    {
        instance = player function_41f811caf4053d98( 1, sublocation );
        securemetadata = function_81744e4202152fa2( metadata[ 0 ] );
        var_c11bbd62e8f23645 = function_81744e4202152fa2( metadata[ 1 ] );
        function_7ccc2499aab17e71( player, instance, securemetadata, var_c11bbd62e8f23645 );
        
        /#
            debugprintmetadata( player function_41f811caf4053d98( 1, sublocation ) );
        #/
    }
}

// Namespace br_instance_inventory
// Params 5
// Checksum 0x98a331b5, Offset: 0x18d7
// Size: 0x338
function function_5b445333c898cc36( player, kind, location, sublocation, weaponobj )
{
    rootname = weapon::getweaponrootname( weaponobj );
    lootid = weapon::getweaponlootid( weaponobj );
    attachmentindex = 0;
    subcomponents = [];
    
    for ( var_ae71f5b7a842cc31 = 0; var_ae71f5b7a842cc31 <= 12 ; var_ae71f5b7a842cc31++ )
    {
        subcomponents[ var_ae71f5b7a842cc31 ] = 0;
    }
    
    if ( isdefined( weaponobj.attachments ) )
    {
        foreach ( attachment in weaponobj.attachments )
        {
            if ( utility::issharedfuncdefined( #"weapons", #"hash_35d31d8d23e44a0" ) )
            {
                if ( [[ utility::getsharedfunc( #"weapons", #"hash_35d31d8d23e44a0" ) ]]( weaponobj, attachment ) )
                {
                    if ( isdefined( weaponobj.attachmentvarindices ) && isdefined( weaponobj.attachmentvarindices[ attachment ] ) )
                    {
                        attachmentlootid = weapons::function_1136b3843dc9e18d( weaponobj.basename, attachment, weaponobj.attachmentvarindices[ attachment ] );
                        
                        if ( !isdefined( attachmentlootid ) )
                        {
                            attachmentlootid = weapon::getattachmentlootid( rootname, attachment );
                        }
                        
                        subcomponents[ attachmentindex ] = attachmentlootid;
                    }
                    else
                    {
                        subcomponents[ attachmentindex ] = weapon::getattachmentlootid( rootname, attachment );
                    }
                    
                    attachmentindex += 1;
                }
            }
        }
    }
    
    if ( isdefined( weaponobj.camo ) )
    {
        subcomponents[ 5 ] = loot::getlootidfromref( weaponobj.camo );
    }
    
    if ( isdefined( weaponobj.reticle ) )
    {
        subcomponents[ 6 ] = loot::getlootidfromref( weaponobj.radical );
    }
    
    if ( isdefined( weaponobj.stickerslot0 ) && weaponobj.stickerslot0 != "sticker_none" )
    {
        subcomponents[ 8 ] = loot::getlootidfromref( weaponobj.stickerslot0 );
    }
    
    if ( isdefined( weaponobj.stickerslot1 ) && weaponobj.stickerslot1 != "sticker_none" )
    {
        subcomponents[ 9 ] = loot::getlootidfromref( weaponobj.stickerslot1 );
    }
    
    if ( isdefined( weaponobj.stickerslot2 ) && weaponobj.stickerslot2 != "sticker_none" )
    {
        subcomponents[ 10 ] = loot::getlootidfromref( weaponobj.stickerslot2 );
    }
    
    if ( isdefined( weaponobj.stickerslot3 ) && weaponobj.stickerslot3 != "sticker_none" )
    {
        subcomponents[ 11 ] = loot::getlootidfromref( weaponobj.stickerslot3 );
    }
    
    if ( isdefined( weaponobj.var_73762c7cb8b2063 ) && weaponobj.var_73762c7cb8b2063 != "sticker_none" )
    {
        subcomponents[ 12 ] = loot::getlootidfromref( weaponobj.var_73762c7cb8b2063 );
    }
    
    player function_c178641b0ba5bf6f( lootid, kind, location, sublocation, subcomponents );
}

// Namespace br_instance_inventory
// Params 4
// Checksum 0x421bdbbf, Offset: 0x1c17
// Size: 0x8f
function function_43d0b80ae3044ee5( player, index, loadoutlocation, loadoutslot )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    backpackindex = 1 + index;
    assert( backpackindex < 12, "<dev string:x75>" + index );
    backpackinstance = player function_41f811caf4053d98( 2, backpackindex );
    loadoutinstance = player function_41f811caf4053d98( loadoutlocation, loadoutslot );
    swapinstances( player, backpackinstance, loadoutinstance, 2, loadoutlocation, backpackindex, loadoutslot );
}

// Namespace br_instance_inventory
// Params 3
// Checksum 0xd5436cfa, Offset: 0x1cae
// Size: 0x79
function function_98d8598f81420818( player, index, loadoutslot )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    backpackindex = 1 + index;
    assert( backpackindex <= 12, "<dev string:x75>" + index );
    backpackinstance = player function_41f811caf4053d98( 2, backpackindex );
    player function_dfc68fe01598eb1a( backpackinstance.instanceid, 1, loadoutslot );
}

// Namespace br_instance_inventory
// Params 3
// Checksum 0x9afa45b7, Offset: 0x1d2f
// Size: 0x96
function function_36435954ba667ab8( player, index, lootid )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    backpackindex = 1 + index;
    assert( backpackindex < 12, "<dev string:x75>" + index );
    kind = 13;
    lootscriptable = loot::getScriptableFromLootID( lootid );
    
    if ( br_pickups::iskey( lootscriptable ) || br_pickups::function_659a09a211112eaa( lootscriptable ) )
    {
        kind = 15;
    }
    
    player function_c178641b0ba5bf6f( lootid, kind, 2, backpackindex, [] );
}

// Namespace br_instance_inventory
// Params 3
// Checksum 0xde53538, Offset: 0x1dcd
// Size: 0x5c
function function_b1116f6c1b474c9c( player, slot, lootid )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    instanceslot = function_5755958875a31ff8( slot );
    
    if ( !isdefined( instanceslot ) )
    {
        return;
    }
    
    if ( lootid == 0 )
    {
        return;
    }
    
    player function_c178641b0ba5bf6f( lootid, 13, 1, instanceslot, [] );
}

// Namespace br_instance_inventory
// Params 2
// Checksum 0xbd8ecc78, Offset: 0x1e31
// Size: 0x2f
function function_26cf1ad6f45e326d( player, lootid )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    player function_c178641b0ba5bf6f( lootid, 13, 65535, 0, [] );
}

// Namespace br_instance_inventory
// Params 2
// Checksum 0xb6ea0e2a, Offset: 0x1e68
// Size: 0x30
function function_b3ac69700bb1c081( player, lootid )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    player function_c178641b0ba5bf6f( lootid, 13, 65535, 1, [] );
}

// Namespace br_instance_inventory
// Params 2
// Checksum 0x86595dba, Offset: 0x1ea0
// Size: 0x30
function function_db51f2f309aa5754( player, lootid )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    player function_c178641b0ba5bf6f( lootid, 13, 65535, 3, [] );
}

// Namespace br_instance_inventory
// Params 2
// Checksum 0xc2f4931e, Offset: 0x1ed8
// Size: 0x30
function function_41df234a9777485a( player, lootid )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    player function_c178641b0ba5bf6f( lootid, 13, 65535, 4, [] );
}

// Namespace br_instance_inventory
// Params 2
// Checksum 0xa036a24a, Offset: 0x1f10
// Size: 0x30
function function_f3867fdc89c40513( player, lootid )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    player function_c178641b0ba5bf6f( lootid, 13, 65535, 2, [] );
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0xb4b0593e, Offset: 0x1f48
// Size: 0x86
function function_8685c66344a4bff0( player )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    operatorinstance = player function_41f811caf4053d98( 65535, 6 );
    
    if ( isdefined( operatorinstance ) && operatorinstance.instanceid != "0" )
    {
        if ( isdefined( operatorinstance.var_a834790f492b07f8[ 0 ] ) )
        {
            skinref = loot::function_f54ecb89dfab8e8c( operatorinstance.var_a834790f492b07f8[ 0 ] );
            
            if ( isdefined( skinref ) )
            {
                return operator::function_c203df33ce95f84c( skinref );
            }
        }
    }
}

// Namespace br_instance_inventory
// Params 3
// Checksum 0x4cc2b3da, Offset: 0x1fd6
// Size: 0x13d
function function_2c2d8215279b82ec( player, streak, perklootid )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    streakinstance = player function_41f811caf4053d98( 65535, 5 );
    subcomponents = [];
    numperks = 0;
    
    if ( isdefined( streakinstance ) && streakinstance.instanceid != "0" )
    {
        if ( isdefined( streakinstance.var_a834790f492b07f8 ) )
        {
            subcomponents = streakinstance.var_a834790f492b07f8;
            
            for ( perkindex = 0; perkindex <= 9 ; perkindex++ )
            {
                if ( subcomponents[ perkindex ] != 0 )
                {
                    numperks++;
                }
            }
        }
    }
    
    if ( isdefined( perklootid ) )
    {
        assert( numperks <= 9 );
        newperkindex = int( min( numperks, 9 ) );
        subcomponents[ newperkindex ] = perklootid;
    }
    
    function_aea1e0f4c9f696f4( player );
    player function_c178641b0ba5bf6f( loot::getlootidfromref( "dmz_exfil_streak" ), 15, 65535, 5, subcomponents );
    streakinstance = player function_41f811caf4053d98( 65535, 5 );
    newmetadata = function_a13ba32f33d59647( [ 2 ], [ streak ], streakinstance );
    function_7ccc2499aab17e71( player, streakinstance, newmetadata );
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0xcf7cf964, Offset: 0x211b
// Size: 0x24
function function_4ada68d31f55a039( player )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    function_b86acd5b5496f84d( player, 1, 12 );
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0x299d7b41, Offset: 0x2147
// Size: 0x24
function function_83bd703a16ccb4e1( player )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    function_b86acd5b5496f84d( player, 1, 13 );
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0x5d10748e, Offset: 0x2173
// Size: 0x24
function function_f0568f5eb07d293e( player )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    function_b86acd5b5496f84d( player, 1, 14 );
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0x8055bbcf, Offset: 0x219f
// Size: 0x24
function function_2d30854f8d502e12( player )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    function_b86acd5b5496f84d( player, 1, 15 );
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0x7cac328f, Offset: 0x21cb
// Size: 0x24
function function_47debdb2dc37fa17( player )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    function_b86acd5b5496f84d( player, 1, 16 );
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0xf1799447, Offset: 0x21f7
// Size: 0x39
function function_7ef1298fd0cf6a2( player )
{
    function_4ada68d31f55a039( player );
    function_83bd703a16ccb4e1( player );
    function_f0568f5eb07d293e( player );
    function_2d30854f8d502e12( player );
    function_47debdb2dc37fa17( player );
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0x5569f923, Offset: 0x2238
// Size: 0x25
function function_aea1e0f4c9f696f4( player )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    function_b86acd5b5496f84d( player, 65535, 5 );
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0x4bfb60b5, Offset: 0x2265
// Size: 0xb4
function function_d697313dc15ad4e1( player )
{
    if ( !function_926a8f8643d34690() )
    {
        return [ 0, [] ];
    }
    
    streakinstance = player function_41f811caf4053d98( 65535, 5 );
    
    if ( isdefined( streakinstance ) && streakinstance.instanceid != "0" )
    {
        if ( isdefined( streakinstance.var_a834790f492b07f8 ) && isdefined( streakinstance.metadata ) )
        {
            streak = function_9513862f69ec0498( 2, streakinstance );
            
            if ( !isdefined( streak ) )
            {
                streak = 0;
            }
            
            return [ int( streak ), streakinstance.var_a834790f492b07f8 ];
        }
    }
    
    return [ 0, [] ];
}

// Namespace br_instance_inventory
// Params 2
// Checksum 0x5252f356, Offset: 0x2322
// Size: 0x52
function function_f927d5c3e2b0bdf0( player, index )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    index += 1;
    assert( index >= 1 && index <= 12, "<dev string:xa9>" + index );
    function_b86acd5b5496f84d( player, 2, index );
}

// Namespace br_instance_inventory
// Params 3
// Checksum 0x5c76e70, Offset: 0x237c
// Size: 0x75
function function_1e5fd659146e4d80( player, slot, var_e108f07ba8fae9fd )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    if ( var_e108f07ba8fae9fd && !function_5b82134531831158( player, slot ) )
    {
        return;
    }
    
    if ( slot == 2 )
    {
        function_b86acd5b5496f84d( player, 2, 0 );
        return;
    }
    
    instanceslot = function_bbf8e7e9f82d2b2( slot );
    function_b86acd5b5496f84d( player, 1, instanceslot );
}

// Namespace br_instance_inventory
// Params 2
// Checksum 0xa9b60929, Offset: 0x23f9
// Size: 0x49
function function_ba66e7c85bc79054( player, slot )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    instanceslot = function_5755958875a31ff8( slot );
    
    if ( !isdefined( instanceslot ) )
    {
        return;
    }
    
    function_b86acd5b5496f84d( player, 1, instanceslot );
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0x42c2e18a, Offset: 0x244a
// Size: 0x24
function function_7575906b0512f675( player )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    function_b86acd5b5496f84d( player, 65535, 0 );
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0x12113da2, Offset: 0x2476
// Size: 0x25
function function_bf3288672a33d4a2( player )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    function_b86acd5b5496f84d( player, 65535, 4 );
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0x79157048, Offset: 0x24a3
// Size: 0x25
function function_29eb2f072ac8b7ac( player )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    function_b86acd5b5496f84d( player, 65535, 3 );
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0x7e3e7b6e, Offset: 0x24d0
// Size: 0x25
function function_3885ada2ac161b19( player )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    function_b86acd5b5496f84d( player, 65535, 1 );
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0x45311000, Offset: 0x24fd
// Size: 0x25
function function_1ab1d8636982f8eb( player )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    function_b86acd5b5496f84d( player, 65535, 2 );
}

// Namespace br_instance_inventory
// Params 7, eflags: 0x4
// Checksum 0xd332f99b, Offset: 0x252a
// Size: 0x82
function private swapinstances( player, instance1, instance2, location1, location2, var_5ee1b59c14923d9e, var_5ee1b49c14923b6b )
{
    player function_dfc68fe01598eb1a( instance1.instanceid, 2, 13 );
    player function_dfc68fe01598eb1a( instance2.instanceid, location1, var_5ee1b59c14923d9e );
    player function_dfc68fe01598eb1a( instance1.instanceid, location2, var_5ee1b49c14923b6b );
}

// Namespace br_instance_inventory
// Params 5
// Checksum 0xb0a2988b, Offset: 0x25b4
// Size: 0x141
function function_b67271a75d20395f( player, var_1fa81a0e31f08222, location, sublocation, var_3a5eefa6c4a5557c )
{
    weaponinstance = player function_41f811caf4053d98( location, sublocation );
    
    if ( weaponinstance.instanceid != "0" && weaponinstance.lootid != 0 && weaponinstance.kind != 11 )
    {
        insuredslot = function_9513862f69ec0498( 15, weaponinstance, 1 );
        
        if ( function_2b7aebec4979c868( player, weaponinstance ) > getsystemtime() )
        {
            player function_1fe0234f56138fe1( weaponinstance.instanceid );
        }
        else if ( var_3a5eefa6c4a5557c[ insuredslot ] )
        {
            player function_1fe0234f56138fe1( weaponinstance.instanceid );
        }
        else
        {
            var_3a5eefa6c4a5557c[ insuredslot ] = 1;
            newmetadata = function_a13ba32f33d59647( [ 1 ], [ var_1fa81a0e31f08222 ], weaponinstance );
            
            if ( isdefined( newmetadata ) )
            {
                function_7ccc2499aab17e71( player, weaponinstance, newmetadata );
            }
            
            weaponinstance = player function_41f811caf4053d98( location, sublocation );
            
            /#
                debugprintmetadata( weaponinstance );
            #/
            
            player.var_6e667199e1eb456[ player.var_6e667199e1eb456.size ] = weaponinstance;
            return var_3a5eefa6c4a5557c;
        }
    }
    
    return var_3a5eefa6c4a5557c;
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0xe92d7fbc, Offset: 0x26fe
// Size: 0x84
function function_5de91f11cdddbbc4( player )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    if ( isdefined( player.var_6e667199e1eb456 ) )
    {
        return;
    }
    
    player.var_6e667199e1eb456 = [];
    var_1fa81a0e31f08222 = function_73b33c06af05a74a( player );
    var_3a5eefa6c4a5557c = [];
    var_3a5eefa6c4a5557c = function_b67271a75d20395f( player, var_1fa81a0e31f08222, 2, 0, var_3a5eefa6c4a5557c );
    var_3a5eefa6c4a5557c = function_b67271a75d20395f( player, var_1fa81a0e31f08222, 1, 0, var_3a5eefa6c4a5557c );
    var_3a5eefa6c4a5557c = function_b67271a75d20395f( player, var_1fa81a0e31f08222, 1, 1, var_3a5eefa6c4a5557c );
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0x35c5889, Offset: 0x278a
// Size: 0x11f
function function_db289c3d41d799a8( player )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    player.initialequipment = [];
    lethalinstance = player function_41f811caf4053d98( 1, 2 );
    
    if ( lethalinstance.instanceid != "0" && lethalinstance.lootid != 0 )
    {
        player.initialequipment[ 2 ] = lethalinstance.lootid;
    }
    
    tacticalinstance = player function_41f811caf4053d98( 1, 3 );
    
    if ( tacticalinstance.instanceid != "0" && tacticalinstance.lootid != 0 )
    {
        player.initialequipment[ 3 ] = tacticalinstance.lootid;
    }
    
    fieldupgradeinstance = player function_41f811caf4053d98( 1, 4 );
    
    if ( fieldupgradeinstance.instanceid != "0" && fieldupgradeinstance.lootid != 0 )
    {
        player.initialequipment[ 4 ] = fieldupgradeinstance.lootid;
    }
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0x7ee15c6a, Offset: 0x28b1
// Size: 0x190
function function_2c3478576a392389( player )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    println( player.name + "<dev string:xe0>" );
    function_1623eb4516fd9e08( player, 2, 0 );
    
    for ( backpackindex = 0; backpackindex < 11 ; backpackindex++ )
    {
        lootinstance = player function_41f811caf4053d98( 2, 1 + backpackindex );
        lootid = lootinstance.lootid;
        quantity = function_9513862f69ec0498( 3, lootinstance, 0 );
        quantity = int( quantity ?? 1 );
        player setplayerdata( level.var_6f9b00680ed002d8, "dmzBackpack", backpackindex, "lootID", lootid );
        player setplayerdata( level.var_6f9b00680ed002d8, "dmzBackpack", backpackindex, "quantity", quantity );
        player br_dmz_inventory::function_8cd50c5d893b2696( lootid );
    }
    
    println( player.name + "<dev string:x10c>" );
    
    for ( backpackindex = 0; backpackindex < 11 ; backpackindex++ )
    {
        lootid = player common_inventory::inventory_getlootidatbackpackindex( backpackindex );
        quantity = player br_default_inventory::getquantityatbackpackindex( backpackindex );
        ref = loot::function_f54ecb89dfab8e8c( lootid );
        
        /#
            println( "<dev string:x11b>" + backpackindex + "<dev string:x11d>" + lootid + "<dev string:x124>" + ref + "<dev string:x127>" + lootid );
            println( "<dev string:x11b>" + backpackindex + "<dev string:x12b>" + lootid + "<dev string:x124>" + ref + "<dev string:x127>" + quantity );
        #/
    }
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0xe97ec8, Offset: 0x2a49
// Size: 0x5c
function function_5755958875a31ff8( equipmentslot )
{
    switch ( equipmentslot )
    {
        case #"hash_325cb2e66f67d5b9":
            return 2;
        case #"hash_511d3c24fcedcdb1":
            return 3;
        case #"hash_e534fd8ec73eafb4":
            return 4;
        case #"hash_723175e1d432ccef":
        default:
            return;
    }
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0xca023f90, Offset: 0x2aad
// Size: 0x63
function function_c9159ed09ca117f1( player )
{
    walletinstance = player function_41f811caf4053d98( 1, 5 );
    
    if ( function_902ad22eabe0eeeb( player, 28 ) && isdefined( walletinstance ) && walletinstance.instanceid != "0" )
    {
        return walletinstance.quantity;
    }
    
    return function_e02bce4d8037e728( player );
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0xcfde5042, Offset: 0x2b18
// Size: 0x5c
function function_ae63647d5316af78( player )
{
    walletinstance = player function_41f811caf4053d98( 1, 5 );
    
    if ( function_902ad22eabe0eeeb( player, 28 ) && isdefined( walletinstance ) && walletinstance.instanceid != "0" )
    {
        return walletinstance.quantity;
    }
    
    return 0;
}

// Namespace br_instance_inventory
// Params 2
// Checksum 0x5c4d3b95, Offset: 0x2b7c
// Size: 0x68
function function_478ce990fa01c15c( player, quantity )
{
    walletinstance = player function_41f811caf4053d98( 1, 5 );
    
    if ( function_902ad22eabe0eeeb( player, 28 ) && isdefined( walletinstance ) && walletinstance.instanceid != "0" )
    {
        player function_c17a2151cfca6224( walletinstance.instanceid, quantity );
    }
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0xe4d95fbe, Offset: 0x2bec
// Size: 0x5b
function function_c9b15d9526c2a885( player )
{
    var_74660e749529d73d = 0;
    
    if ( function_902ad22eabe0eeeb( player, 28 ) )
    {
        var_74660e749529d73d = 10000;
        var_f634d7f16fcd291e = int( min( getupgradecount( player, 15 ), 18 ) );
        
        if ( isdefined( var_f634d7f16fcd291e ) )
        {
            var_74660e749529d73d += var_f634d7f16fcd291e * 5000;
        }
    }
    
    return var_74660e749529d73d;
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0x63e160a, Offset: 0x2c50
// Size: 0xc1
function bankcash( player )
{
    if ( !function_902ad22eabe0eeeb( player, 28 ) )
    {
        return;
    }
    
    plundercount = 0;
    
    if ( isdefined( player.plundercount ) && player.plundercount > 0 )
    {
        plundercount = player.plundercount;
    }
    
    var_74660e749529d73d = function_c9b15d9526c2a885( player );
    cashbalance = player function_d11510ad4f90a3b4();
    balancespace = var_74660e749529d73d - cashbalance;
    
    if ( balancespace > 0 )
    {
        intobalance = 0;
        
        if ( balancespace >= plundercount )
        {
            intobalance = plundercount;
        }
        else
        {
            intobalance = balancespace;
        }
        
        player function_e9f2cdc9af3ba749( intobalance );
        plundercount -= intobalance;
    }
    
    function_478ce990fa01c15c( player, plundercount );
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0x7bc00d51, Offset: 0x2d19
// Size: 0x66
function function_38fa0fc4dc8c6178( player )
{
    var_74660e749529d73d = function_c9b15d9526c2a885( player );
    cashbalance = player function_d11510ad4f90a3b4();
    
    if ( cashbalance > var_74660e749529d73d )
    {
        player function_fe0f77569a3d77a8( var_74660e749529d73d );
    }
    
    walletcash = function_ae63647d5316af78( player );
    
    if ( walletcash > 25000 )
    {
        function_478ce990fa01c15c( player, 25000 );
    }
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0xbe8fd3fd, Offset: 0x2d87
// Size: 0x77
function savecash( player )
{
    plundercount = 0;
    
    if ( isdefined( player.plundercount ) && player.plundercount > 0 )
    {
        plundercount = player.plundercount;
    }
    
    if ( function_902ad22eabe0eeeb( player, 28 ) )
    {
        function_478ce990fa01c15c( player, plundercount );
        return;
    }
    
    player setplayerdata( level.var_6f9b00680ed002d8, "dmzPocketCash", plundercount );
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0x1ebc6a0e, Offset: 0x2e06
// Size: 0x2b
function function_e8c1b0854cf1e3e2( player )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    function_a11a8bd2cccf057a( player, 1 );
    function_5fb19cc857e53cb1( player );
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0x8140c8dc, Offset: 0x2e39
// Size: 0x23a
function function_bed0e5a9d95456d4( player )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    ownedstashitems = [];
    player.pers[ "telemetry" ].var_a18bd6cd1fda5b25 = [];
    var_4a6fe0e5b26a561d = br_default_inventory::function_66b3b70a06d417( player );
    extractedstashitems = teams::getteamdata( player.team, "extractedStashItems" );
    
    for ( backpackindex = 0; backpackindex < 11 ; backpackindex++ )
    {
        lootinstance = player function_41f811caf4053d98( 2, 1 + backpackindex );
        
        if ( lootinstance.instanceid != "0" )
        {
            scriptableref = loot::getScriptableFromLootID( lootinstance.lootid );
            
            if ( isdefined( scriptableref ) )
            {
                var_659a09a211112eaa = br_pickups::function_659a09a211112eaa( scriptableref );
                player.pers[ "telemetry" ].var_a18bd6cd1fda5b25[ backpackindex ] = 0;
                
                if ( !br_pickups::iskey( scriptableref ) && !var_659a09a211112eaa && !var_4a6fe0e5b26a561d )
                {
                    player br_default_inventory::function_39f0833282ad6f6( backpackindex );
                    player.pers[ "telemetry" ].var_a18bd6cd1fda5b25[ backpackindex ] = 1;
                    continue;
                }
                
                if ( var_659a09a211112eaa )
                {
                    ownedstashitems[ lootinstance.lootid ] = 1;
                    currentquantity = player br_default_inventory::getquantityatbackpackindex( backpackindex );
                    function_292fa6eedc00d8d0( player, lootinstance, currentquantity );
                }
            }
        }
    }
    
    if ( var_4a6fe0e5b26a561d )
    {
        function_a11a8bd2cccf057a( player );
    }
    
    foreach ( stashitemid, _ in extractedstashitems )
    {
        if ( !ownedstashitems[ stashitemid ] )
        {
            backpackindex = player br_default_inventory::getavailabledmzbackpackindex();
            
            if ( isdefined( backpackindex ) )
            {
                br_default_inventory::function_d85bb3c0fe7a50a4( player, backpackindex, stashitemid, 1 );
            }
        }
    }
    
    function_5fb19cc857e53cb1( player );
    function_98bfd9349e0b7c6f( player );
    bankcash( player );
}

// Namespace br_instance_inventory
// Params 3
// Checksum 0x2f6f5636, Offset: 0x307b
// Size: 0x51
function function_292fa6eedc00d8d0( player, lootinstance, quantity )
{
    newmetadata = function_a13ba32f33d59647( [ 3 ], [ quantity ], lootinstance );
    
    if ( isdefined( newmetadata ) )
    {
        function_7ccc2499aab17e71( player, lootinstance, newmetadata );
    }
}

// Namespace br_instance_inventory
// Params 3
// Checksum 0x4d47eb1, Offset: 0x30d4
// Size: 0x14b
function function_a11a8bd2cccf057a( player, var_de167d7c29b87d73, infil )
{
    for ( backpackindex = 0; backpackindex < 11 ; backpackindex++ )
    {
        lootinstance = player function_41f811caf4053d98( 2, 1 + backpackindex );
        
        if ( lootinstance.instanceid != "0" )
        {
            if ( function_a6000dbe75c3408c( lootinstance.lootid, var_de167d7c29b87d73, infil ) )
            {
                function_f927d5c3e2b0bdf0( player, backpackindex );
                
                if ( var_de167d7c29b87d73 )
                {
                    method = challenges::function_a23641f33e985edb( 0, ae_utility::function_2d1565a236387b2( #"loot_method_bitfield", #"extract" ) );
                    challenges::reportlootitemevent( player, lootinstance.lootid, undefined, method, 1, 0 );
                }
                
                continue;
            }
            
            if ( !infil )
            {
                if ( isdefined( player.var_4a8058894fecbe92 ) && !player.extracted && player.var_4a8058894fecbe92[ backpackindex ][ "lootID" ] == lootinstance.lootid )
                {
                    currentquantity = player.var_4a8058894fecbe92[ backpackindex ][ "quantity" ];
                    
                    if ( !isdefined( currentquantity ) )
                    {
                        currentquantity = 1;
                    }
                }
                
                function_292fa6eedc00d8d0( player, lootinstance, currentquantity );
            }
        }
    }
}

// Namespace br_instance_inventory
// Params 3
// Checksum 0xda9916fa, Offset: 0x3227
// Size: 0x59, Type: bool
function function_a6000dbe75c3408c( lootid, var_de167d7c29b87d73, infil )
{
    return !var_de167d7c29b87d73 && !( infil && level.var_e0e923b5d7a7d542 ) && br_default_inventory::function_9ccb694d6c161351( lootid ) || br_default_inventory::function_9d250a96d122e7a6( lootid ) || br_default_inventory::function_5b4694471e56a8ef( lootid );
}

// Namespace br_instance_inventory
// Params 3
// Checksum 0xe50551a0, Offset: 0x3289
// Size: 0xad, Type: bool
function isdeaddropitem( lootid, var_de167d7c29b87d73, infil )
{
    scriptablename = loot::getScriptableFromLootID( lootid );
    issuperpower = isdefined( scriptablename ) && supers_mp::issuperpower( scriptablename );
    var_fedf4df091ef9a4e = isdefined( scriptablename ) && ( issuperpower || br_pickups::istempv( scriptablename ) );
    return !var_de167d7c29b87d73 && !( infil && level.var_e0e923b5d7a7d542 ) && br_default_inventory::function_9ccb694d6c161351( lootid ) || var_fedf4df091ef9a4e && !var_de167d7c29b87d73 && !infil || issuperpower && var_de167d7c29b87d73;
}

// Namespace br_instance_inventory
// Params 1, eflags: 0x4
// Checksum 0x2c2add86, Offset: 0x333f
// Size: 0x3f
function private function_98bfd9349e0b7c6f( player )
{
    if ( !level.var_724d02c20b4150fb )
    {
        return;
    }
    
    if ( !isdefined( player.var_e248fd8806924e22 ) )
    {
        return;
    }
    
    function_1e5fd659146e4d80( player, player.var_e248fd8806924e22 );
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0xfe15ee7b, Offset: 0x3386
// Size: 0x121
function function_7c3d5606261c1cc0( player )
{
    if ( !level.var_724d02c20b4150fb )
    {
        return;
    }
    
    foreach ( weaponslot in [ 0, 1 ] )
    {
        weapon = br_pickups::function_5ef22d170cdde55e( player, weaponslot );
        
        if ( isdefined( weapon ) && weaponclass( weapon ) == "sniper" && weapon hasattachment( "unique_sn_alpha50_stpats" ) )
        {
            player.var_e248fd8806924e22 = weaponslot;
            return;
        }
    }
    
    if ( !isdefined( player.var_e248fd8806924e22 ) )
    {
        weapon = br_default_inventory::function_3b4976a12ea5037b( player );
        
        if ( isdefined( weapon ) && weaponclass( weapon ) == "sniper" && weapon hasattachment( "unique_sn_alpha50_stpats" ) )
        {
            player.var_e248fd8806924e22 = 2;
        }
    }
}

// Namespace br_instance_inventory
// Params 2, eflags: 0x4
// Checksum 0xaf3446ae, Offset: 0x34af
// Size: 0x102
function private function_ea038b9b69942891( weaponinstance, prefix )
{
    itemref = loot::function_f54ecb89dfab8e8c( weaponinstance.lootid );
    prefix = prefix + " ID: " + weaponinstance.lootid + " " + itemref + " ";
    
    if ( isdefined( weaponinstance.var_a834790f492b07f8 ) )
    {
        foreach ( childindex, childlootid in weaponinstance.var_a834790f492b07f8 )
        {
            if ( isdefined( childlootid ) && childlootid != 0 )
            {
                prefix = prefix + " Child " + childindex + ": " + childlootid + " ";
            }
        }
    }
    
    return prefix;
}

// Namespace br_instance_inventory
// Params 2, eflags: 0x4
// Checksum 0x85e00781, Offset: 0x35ba
// Size: 0x49
function private function_964c50c7ef3e1e41( instance, prefix )
{
    itemref = loot::function_f54ecb89dfab8e8c( instance.lootid );
    return prefix + instance.lootid + " " + itemref;
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0x22ef0ac7, Offset: 0x360c
// Size: 0x44
function function_e02bce4d8037e728( player )
{
    cash = player getplayerdata( level.var_6f9b00680ed002d8, "dmzPocketCash" );
    player setplayerdata( level.var_6f9b00680ed002d8, "dmzPocketCash", 0 );
    return cash;
}

// Namespace br_instance_inventory
// Params 2
// Checksum 0x462ae312, Offset: 0x3659
// Size: 0x3ce, Type: bool
function function_41b9f29c838850e9( player, onconnect )
{
    if ( !function_926a8f8643d34690() )
    {
        return false;
    }
    
    operatorskin = function_8685c66344a4bff0( player );
    backpackinstance = player function_41f811caf4053d98( 65535, 1 );
    defaultbackpack = operator::function_bb4618718e086740( operatorskin );
    scriptable = loot::getScriptableFromLootID( backpackinstance.lootid );
    
    if ( backpackinstance.instanceid != "0" && isdefined( scriptable ) && br_pickups::function_cfce107ef35a347e( scriptable ) )
    {
        backpacksize = br_default_inventory::function_52727e682b6bb2d3( loot::getScriptableFromLootID( backpackinstance.lootid ) );
        br_default_inventory::function_7fcce769f23a1428( player, backpacksize, undefined, backpackinstance.lootid );
    }
    else if ( isdefined( operatorskin ) && isdefined( defaultbackpack ) )
    {
        scriptable = loot::getScriptableFromLootID( defaultbackpack );
        assert( br_pickups::function_cfce107ef35a347e( scriptable ) );
        function_b3ac69700bb1c081( player, defaultbackpack );
        backpacksize = br_default_inventory::function_52727e682b6bb2d3( scriptable );
        br_default_inventory::function_7fcce769f23a1428( player, backpacksize, undefined, defaultbackpack );
    }
    else
    {
        br_default_inventory::function_7fcce769f23a1428( player, 5 );
    }
    
    var_1827e45669a6c403 = player function_41f811caf4053d98( 2, 0 );
    loottype = loot::function_52cf8374c44a4ff5( var_1827e45669a6c403.lootid );
    
    if ( var_1827e45669a6c403.instanceid != "0" && var_1827e45669a6c403.lootid > 0 )
    {
        currentbackpack = loot::function_f54ecb89dfab8e8c( br_default_inventory::function_677447af306a9120( player ) );
        var_6046dbc89191c40c = br_default_inventory::function_345a6d7c5fc381ea( currentbackpack );
        
        if ( loottype == "weapon" && var_6046dbc89191c40c )
        {
            function_1623eb4516fd9e08( player, 2, 0, onconnect );
        }
        else
        {
            function_ce6e11615519b246( player );
        }
    }
    
    gasmaskinstance = player function_41f811caf4053d98( 65535, 4 );
    
    if ( gasmaskinstance.instanceid != "0" )
    {
        scriptable = loot::getScriptableFromLootID( gasmaskinstance.lootid );
        
        if ( isdefined( scriptable ) && br_pickups::isgasmask( scriptable ) )
        {
            player gasmask::init( undefined, scriptable );
        }
        else
        {
            function_bf3288672a33d4a2( player );
        }
    }
    else if ( isdefined( operatorskin ) )
    {
        defaultgasmask = operator::function_4c23b4a4c457f40b( operatorskin );
        
        if ( isdefined( defaultgasmask ) )
        {
            scriptable = loot::getScriptableFromLootID( defaultgasmask );
            assert( br_pickups::isgasmask( scriptable ) );
            function_41df234a9777485a( player, defaultgasmask );
            player gasmask::init( undefined, scriptable );
        }
    }
    
    selfreviveinstance = player function_41f811caf4053d98( 65535, 3 );
    scriptable = loot::getScriptableFromLootID( selfreviveinstance.lootid );
    defaultselfrevive = undefined;
    
    if ( isdefined( operatorskin ) )
    {
        defaultselfrevive = operator::function_5b6aad02fe43f871( operatorskin );
    }
    
    if ( selfreviveinstance.instanceid != "0" && isdefined( scriptable ) && br_pickups::isrevivepickup( scriptable ) )
    {
        player br_pickups::function_19f92529593d1af9( 1, selfreviveinstance.lootid );
    }
    else if ( isdefined( defaultselfrevive ) )
    {
        assert( br_pickups::isrevivepickup( loot::getScriptableFromLootID( defaultselfrevive ) ) );
        function_db51f2f309aa5754( player, defaultselfrevive );
        player br_pickups::function_19f92529593d1af9( 1, defaultselfrevive );
    }
    
    var_7ea2bf559d0db7d7 = player function_41f811caf4053d98( 65535, 5 );
    featureref = loot::function_f54ecb89dfab8e8c( var_7ea2bf559d0db7d7.lootid );
    
    if ( var_7ea2bf559d0db7d7.instanceid != "0" && isdefined( featureref ) && featureref == "dmz_exfil_streak" )
    {
        br_gametype_dmz::function_ae81222733a057cc( player );
    }
    else
    {
        player br_gametype_dmz::function_ff01c205a999d3ae();
    }
    
    function_a11a8bd2cccf057a( player, 0, 1 );
    function_5de91f11cdddbbc4( player );
    function_db289c3d41d799a8( player );
    return true;
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0x15bf92bc, Offset: 0x3a30
// Size: 0xe4
function function_de26efb0d098172f( player )
{
    if ( !function_926a8f8643d34690() )
    {
        return 0;
    }
    
    selfreviveinstance = player function_41f811caf4053d98( 65535, 3 );
    defaultselfrevive = undefined;
    operatorskin = function_8685c66344a4bff0( player );
    
    if ( isdefined( operatorskin ) )
    {
        defaultselfrevive = operator::function_5b6aad02fe43f871( operatorskin );
    }
    
    if ( selfreviveinstance.instanceid == "0" && !isdefined( defaultselfrevive ) && isdefined( player.team ) )
    {
        if ( function_902ad22eabe0eeeb( player, 30 ) )
        {
            teamplayers = teams::getteamdata( player.team, "players" );
            
            if ( isdefined( teamplayers ) && teamplayers.size == 1 )
            {
                function_db51f2f309aa5754( player, loot::getlootidfromref( "brloot_self_revive" ) );
                player br_pickups::function_19f92529593d1af9( 1 );
            }
        }
    }
}

// Namespace br_instance_inventory
// Params 2
// Checksum 0xabc8ed58, Offset: 0x3b1c
// Size: 0x5e
function function_3273e9456e3ea26( player, reductiontime )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    function_17cf8db03925278f( player, function_9a3bfdd3aa3af505( player, 0 ), reductiontime );
    function_17cf8db03925278f( player, function_9a3bfdd3aa3af505( player, 1 ), reductiontime );
    function_17cf8db03925278f( player, function_9a3bfdd3aa3af505( player, 2 ), reductiontime );
}

// Namespace br_instance_inventory
// Params 3
// Checksum 0x477cc5d4, Offset: 0x3b82
// Size: 0x7e
function function_17cf8db03925278f( player, instance, reductiontime )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    currentcooldown = int( instance.cooldownexpiration ?? 0 );
    
    if ( currentcooldown <= getsystemtime() )
    {
        return;
    }
    
    newcooldown = int( max( currentcooldown - reductiontime, 0 ) );
    player function_86c4417b398dd00( instance.instanceid, newcooldown );
}

// Namespace br_instance_inventory
// Params 2, eflags: 0x4
// Checksum 0x90d7ef6, Offset: 0x3c08
// Size: 0xb4
function private function_d7c9d1b869d0c19c( player, instance )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    currentcooldown = function_2b7aebec4979c868( player, instance );
    
    if ( currentcooldown > getsystemtime() )
    {
        return;
    }
    
    newcooldown = function_8f6940f94f97b5aa();
    
    if ( getdvarint( @"hash_6dc2f0452c76707d", 1 ) || getdvarint( @"hash_257cb72a99900ef2", 1 ) )
    {
        newcooldown = function_52ff7827e27cac9e( player, instance );
    }
    
    newcooldown = getsystemtime() + newcooldown;
    insuredinstance = function_cb3d350bbce3b87e( player, instance );
    player function_86c4417b398dd00( insuredinstance.instanceid, int( newcooldown ) );
}

// Namespace br_instance_inventory
// Params 2
// Checksum 0x6da314a3, Offset: 0x3cc4
// Size: 0x1f
function function_9a3bfdd3aa3af505( player, index )
{
    return player function_41f811caf4053d98( 5, index );
}

// Namespace br_instance_inventory
// Params 2
// Checksum 0x7d3a2e81, Offset: 0x3cec
// Size: 0xd1
function function_cb3d350bbce3b87e( player, instance )
{
    if ( !( isdefined( instance ) && isdefined( player ) && isdefined( instance.var_c11bbd62e8f23645 ) ) )
    {
        return 0;
    }
    
    foreach ( data in instance.var_c11bbd62e8f23645 )
    {
        if ( data.key == 15 )
        {
            return player function_41f811caf4053d98( 5, int( data.value ) - 1 );
        }
    }
}

// Namespace br_instance_inventory
// Params 2
// Checksum 0x367f2099, Offset: 0x3dc5
// Size: 0x39, Type: bool
function function_2b7aebec4979c868( player, instance )
{
    insuredinstance = function_cb3d350bbce3b87e( player, instance );
    return insuredinstance.cooldownexpiration ?? 0;
}

// Namespace br_instance_inventory
// Params 2
// Checksum 0x4b4edac3, Offset: 0x3e07
// Size: 0x13c
function function_52ff7827e27cac9e( player, instance )
{
    if ( !( isdefined( instance ) && isdefined( player ) && isdefined( instance.var_c11bbd62e8f23645 ) ) )
    {
        return 0;
    }
    
    insuredslot = function_9513862f69ec0498( 15, instance, 1 );
    
    if ( !isdefined( insuredslot ) )
    {
        return function_8f6940f94f97b5aa();
    }
    
    potentialcooldown = function_2daebbc84012609d( instance );
    
    if ( potentialcooldown > 0 )
    {
        return potentialcooldown;
    }
    
    if ( !getdvarint( @"hash_6dc2f0452c76707d", 1 ) )
    {
        return function_8f6940f94f97b5aa();
    }
    
    basecooldown = undefined;
    
    switch ( insuredslot )
    {
        case #"hash_31100fbc01bd387c":
            basecooldown = getdvarint( @"hash_618c3ca8c4897d2c", 7200 );
            break;
        case #"hash_311012bc01bd3d35":
            basecooldown = getdvarint( @"hash_618c3fa8c48983c5", 14400 );
            break;
        case #"hash_311011bc01bd3ba2":
            basecooldown = getdvarint( @"hash_618c3ea8c4898192", 21600 );
            break;
        default:
            basecooldown = function_8f6940f94f97b5aa();
            break;
    }
    
    var_169df7d81e5e1135 = function_e7d0a9ebc17e1239( player, insuredslot );
    return max( 0, basecooldown - basecooldown * var_169df7d81e5e1135 );
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0xeb8b9505, Offset: 0x3f4c
// Size: 0x8d
function function_2daebbc84012609d( instance )
{
    if ( !isdefined( instance.lootid ) || instance.lootid == 0 )
    {
        return 0;
    }
    
    ref = loot::function_f54ecb89dfab8e8c( instance.lootid );
    
    if ( !isdefined( ref ) )
    {
        return 0;
    }
    
    rootname = weapon::getweaponrootname( ref );
    variantid = function_4d465a88a4c974d3( instance.lootid );
    cooldown = 0;
    return cooldown;
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0xcde7851a, Offset: 0x3fe2
// Size: 0x79
function function_ba4e5cfedfe04b10( player )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    for ( i = 0; i < 3 ; i++ )
    {
        instance = function_9a3bfdd3aa3af505( player, i );
        
        if ( !isdefined( instance ) )
        {
            continue;
        }
        
        currentcooldown = int( instance.cooldownexpiration ?? 0 );
        
        if ( currentcooldown > getsystemtime() )
        {
            return 1;
        }
    }
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0xa63237f8, Offset: 0x4063
// Size: 0xab
function function_99a1c747e9d8f29a( player )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    if ( !function_ba4e5cfedfe04b10( player ) )
    {
        return;
    }
    
    mincooldown = undefined;
    
    for ( i = 0; i < 3 ; i++ )
    {
        instance = function_9a3bfdd3aa3af505( player, i );
        
        if ( !isdefined( instance ) )
        {
            continue;
        }
        
        currentcooldown = int( instance.cooldownexpiration ?? 0 );
        
        if ( currentcooldown > getsystemtime() )
        {
            if ( !isdefined( mincooldown ) )
            {
                mincooldown = currentcooldown;
                continue;
            }
            
            mincooldown = int( min( mincooldown, currentcooldown ) );
        }
    }
    
    return mincooldown;
}

// Namespace br_instance_inventory
// Params 0
// Checksum 0x68b161d, Offset: 0x4117
// Size: 0x12
function function_8f6940f94f97b5aa()
{
    return getdvarint( @"scr_default_weapon_cooldown", 14400 );
}

// Namespace br_instance_inventory
// Params 0
// Checksum 0x2da2307f, Offset: 0x4132
// Size: 0x12
function function_e78a9f9fcb7496cf()
{
    return getdvarint( @"hash_c5ac098e3a15af33", 3000 );
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0xa156555a, Offset: 0x414d
// Size: 0xd9
function getcurrentweaponinstances( player )
{
    currentweaponinstances = [];
    var_1827e45669a6c403 = player function_41f811caf4053d98( 2, 0 );
    
    if ( var_1827e45669a6c403.instanceid != "0" && var_1827e45669a6c403.lootid != 0 )
    {
        currentweaponinstances[ currentweaponinstances.size ] = var_1827e45669a6c403;
    }
    
    primaryweaponinstance = player function_41f811caf4053d98( 1, 0 );
    
    if ( primaryweaponinstance.instanceid != "0" && primaryweaponinstance.lootid != 0 )
    {
        currentweaponinstances[ currentweaponinstances.size ] = primaryweaponinstance;
    }
    
    secondaryweaponinstance = player function_41f811caf4053d98( 1, 1 );
    
    if ( secondaryweaponinstance.instanceid != "0" && secondaryweaponinstance.lootid != 0 )
    {
        currentweaponinstances[ currentweaponinstances.size ] = secondaryweaponinstance;
    }
    
    return currentweaponinstances;
}

// Namespace br_instance_inventory
// Params 2
// Checksum 0xdce50bfa, Offset: 0x422f
// Size: 0xc9
function function_55fad71e8e81e9f0( player, weaponslot )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    weaponinstance = function_843e185e3cd37eb1( player, weaponslot );
    
    foreach ( instance in player.var_6e667199e1eb456 )
    {
        sameweapon = undefined;
        
        if ( function_113616b084beaf67( instance, weaponinstance ) )
        {
            return function_9513862f69ec0498( 15, weaponinstance, 1 );
        }
    }
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0xec7b7062, Offset: 0x4301
// Size: 0x160
function function_5fb19cc857e53cb1( player )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    if ( !isdefined( player.var_6e667199e1eb456 ) )
    {
        return;
    }
    
    currentweaponinstances = getcurrentweaponinstances( player );
    
    foreach ( instance in player.var_6e667199e1eb456 )
    {
        sameweapon = undefined;
        
        foreach ( currentinstance in currentweaponinstances )
        {
            if ( function_113616b084beaf67( instance, currentinstance ) )
            {
                sameweapon = currentinstance;
                break;
            }
        }
        
        if ( !isdefined( sameweapon ) )
        {
            function_d7c9d1b869d0c19c( player, instance );
            continue;
        }
        
        if ( sameweapon.kind != 14 )
        {
            function_1c2ce7050bd814fd( player, sameweapon );
        }
    }
}

// Namespace br_instance_inventory
// Params 2
// Checksum 0x5fd1cc93, Offset: 0x4469
// Size: 0xfb
function function_1c2ce7050bd814fd( player, instance )
{
    player function_1fe0234f56138fe1( instance.instanceid );
    player function_c178641b0ba5bf6f( instance.lootid, 14, instance.location, instance.sublocation, instance.var_a834790f492b07f8 );
    custominstance = player function_41f811caf4053d98( instance.location, instance.sublocation );
    
    if ( isdefined( instance.metadata ) )
    {
        newmetadata = function_81744e4202152fa2( instance.metadata );
        player function_c0d5d134ef5e068( custominstance.instanceid, 0, newmetadata );
    }
    
    if ( isdefined( instance.var_c11bbd62e8f23645 ) )
    {
        newmetadata = function_81744e4202152fa2( instance.var_c11bbd62e8f23645 );
        player function_c0d5d134ef5e068( custominstance.instanceid, 1, newmetadata );
    }
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0x1d19d945, Offset: 0x456c
// Size: 0xa4
function function_15887a0388913565( player )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    if ( !isdefined( player.var_6e667199e1eb456 ) )
    {
        return;
    }
    
    foreach ( instance in player.var_6e667199e1eb456 )
    {
        function_d7c9d1b869d0c19c( player, instance );
    }
}

// Namespace br_instance_inventory
// Params 4
// Checksum 0x22426a89, Offset: 0x4618
// Size: 0x58
function function_7ccc2499aab17e71( player, instance, metadata, var_c11bbd62e8f23645 )
{
    player function_c0d5d134ef5e068( instance.instanceid, 0, metadata );
    
    if ( isdefined( var_c11bbd62e8f23645 ) )
    {
        player function_c0d5d134ef5e068( instance.instanceid, 1, var_c11bbd62e8f23645 );
    }
}

// Namespace br_instance_inventory
// Params 3
// Checksum 0x6fc69677, Offset: 0x4678
// Size: 0xe1
function function_7d75082adab2ad30( key, metadata, var_fdb039ad3e8ca8ba )
{
    if ( isdefined( metadata ) )
    {
        foreach ( data in metadata )
        {
            if ( key == data.key )
            {
                if ( var_fdb039ad3e8ca8ba )
                {
                    return [ data.value, data.valuelow, data.valuehigh ];
                }
                
                return data.value;
            }
        }
    }
}

// Namespace br_instance_inventory
// Params 4
// Checksum 0xcbe190b, Offset: 0x4762
// Size: 0x68
function function_9513862f69ec0498( key, instance, var_c11bbd62e8f23645, var_fdb039ad3e8ca8ba )
{
    if ( !( isdefined( key ) && isdefined( instance ) ) )
    {
        return;
    }
    
    metadata = instance.metadata;
    
    if ( var_c11bbd62e8f23645 )
    {
        metadata = instance.var_c11bbd62e8f23645;
    }
    
    return function_7d75082adab2ad30( key, metadata, var_fdb039ad3e8ca8ba );
}

// Namespace br_instance_inventory
// Params 3
// Checksum 0xb2f0190a, Offset: 0x47d3
// Size: 0xa8
function function_15d4066789db807c( key, value, metadata )
{
    foreach ( data in metadata )
    {
        if ( key == data.key )
        {
            data.value = value;
        }
    }
    
    return metadata;
}

// Namespace br_instance_inventory
// Params 2, eflags: 0x4
// Checksum 0x1f2a7814, Offset: 0x4884
// Size: 0x87, Type: bool
function private function_113616b084beaf67( originalinstance, currentinstance )
{
    var_c87b75bffa55c1a9 = function_9513862f69ec0498( 1, originalinstance );
    var_f19dedcd90cc0a43 = function_9513862f69ec0498( 1, currentinstance );
    
    if ( !( isdefined( var_c87b75bffa55c1a9 ) && isdefined( var_f19dedcd90cc0a43 ) ) )
    {
        return false;
    }
    
    if ( var_c87b75bffa55c1a9 == var_f19dedcd90cc0a43 )
    {
        var_ba1a0b90fdafb91f = function_9513862f69ec0498( 15, originalinstance, 1 );
        var_f94ad5ca1fe3ad75 = function_9513862f69ec0498( 15, currentinstance, 1 );
        return ( var_ba1a0b90fdafb91f == var_f94ad5ca1fe3ad75 );
    }
    
    return false;
}

// Namespace br_instance_inventory
// Params 3, eflags: 0x4
// Checksum 0xf1fd4cf4, Offset: 0x4914
// Size: 0x5c
function private function_e0102812e8b32990( player, location, sublocation )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    instance = player function_41f811caf4053d98( location, sublocation );
    return [ instance.metadata, instance.var_c11bbd62e8f23645 ];
}

// Namespace br_instance_inventory
// Params 1, eflags: 0x4
// Checksum 0xec30b398, Offset: 0x4979
// Size: 0x36
function private function_4e566b2102dcb480( instance )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    return [ instance.metadata, instance.var_c11bbd62e8f23645 ];
}

// Namespace br_instance_inventory
// Params 2
// Checksum 0x8b2c81fb, Offset: 0x49b8
// Size: 0x53
function function_6a05cf5689058e1f( player, slot )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    location = 1;
    sublocation = slot;
    
    if ( slot == 2 )
    {
        location = 2;
        sublocation = 0;
    }
    
    return function_e0102812e8b32990( player, location, sublocation );
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0xde55d57e, Offset: 0x4a14
// Size: 0x106
function function_a06f3442460db38d( player )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    var_c669166873e45e91 = player function_41f811caf4053d98( 65535, 2 );
    operatorskin = function_8685c66344a4bff0( player );
    var_5ae22c86235c7b1f = operator::function_4c7f17b5ae87e7be( operatorskin );
    platescriptable = loot::getScriptableFromLootID( var_c669166873e45e91.lootid );
    
    if ( var_c669166873e45e91.instanceid != "0" && br_public::function_d115f1547e28f0c6( platescriptable ) )
    {
        platelevel = br_pickups::function_402de4642e0ec93c( player, platescriptable, 1 );
        return;
    }
    
    if ( isdefined( operatorskin ) && isdefined( var_5ae22c86235c7b1f ) )
    {
        scriptable = loot::getScriptableFromLootID( var_c669166873e45e91.lootid );
        assert( br_public::function_d115f1547e28f0c6( scriptable ) );
        function_f3867fdc89c40513( player, var_5ae22c86235c7b1f );
        platelevel = br_pickups::function_402de4642e0ec93c( player, loot::getScriptableFromLootID( var_5ae22c86235c7b1f ), 1 );
        return;
    }
    
    br_pickups::function_f315be762bc7a779( player );
}

// Namespace br_instance_inventory
// Params 5
// Checksum 0x11019f6f, Offset: 0x4b22
// Size: 0x199
function function_e3303c5fbf83d1c3( player, instance, paramoffset, unlockeventparams, var_64feb473633a5d17 )
{
    lootid = weapons::function_636e43f4bcdc20b5( instance.lootid );
    
    if ( !isdefined( lootid ) || lootid == 0 )
    {
        return [ unlockeventparams, paramoffset ];
    }
    
    if ( !isdefined( var_64feb473633a5d17[ lootid ] ) )
    {
        unlockeventparams[ unlockeventparams.size ] = paramoffset;
        unlockeventparams[ unlockeventparams.size ] = lootid;
        var_64feb473633a5d17[ lootid ] = 1;
        paramoffset += 1;
    }
    
    variantref = loot::function_f54ecb89dfab8e8c( lootid );
    rootname = weapon::getweaponrootname( variantref );
    assetname = weapon::getweaponassetname( rootname );
    attachmentsbundles = function_d71c82dac3ffb910( assetname );
    
    foreach ( bundle in attachmentsbundles )
    {
        if ( isdefined( bundle ) )
        {
            attachmentlootid = bundle.lootid;
        }
        
        if ( !isdefined( attachmentlootid ) )
        {
            continue;
        }
        
        if ( !isdefined( var_64feb473633a5d17[ attachmentlootid ] ) )
        {
            unlockeventparams[ unlockeventparams.size ] = paramoffset;
            unlockeventparams[ unlockeventparams.size ] = attachmentlootid;
            var_64feb473633a5d17[ attachmentlootid ] = 1;
            paramoffset += 1;
        }
    }
    
    return [ unlockeventparams, paramoffset, var_64feb473633a5d17 ];
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0x5d521995, Offset: 0x4cc4
// Size: 0x331
function unlockitems( player )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    aeeventname = #"dmz_give_loot";
    aeeventid = ae_utility::function_8645a430dc4bffb9( aeeventname );
    unlockeventparams = [];
    var_64feb473633a5d17 = [];
    unlockeventparams[ unlockeventparams.size ] = ae_utility::function_70b8bc68f3d8031e( aeeventname, #"version" );
    unlockeventparams[ unlockeventparams.size ] = 1;
    var_b5e0bc8772b58b40 = ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loot_id" );
    var_4d0deed528845c35 = var_b5e0bc8772b58b40;
    primaryinstance = player function_41f811caf4053d98( 1, 0 );
    [ unlockeventparams, var_4d0deed528845c35, var_64feb473633a5d17 ] = function_e3303c5fbf83d1c3( player, primaryinstance, var_4d0deed528845c35, unlockeventparams, var_64feb473633a5d17 );
    secondaryinstance = player function_41f811caf4053d98( 1, 1 );
    [ unlockeventparams, var_4d0deed528845c35, var_64feb473633a5d17 ] = function_e3303c5fbf83d1c3( player, secondaryinstance, var_4d0deed528845c35, unlockeventparams, var_64feb473633a5d17 );
    var_1827e45669a6c403 = player function_41f811caf4053d98( 2, 0 );
    [ unlockeventparams, var_4d0deed528845c35, var_64feb473633a5d17 ] = function_e3303c5fbf83d1c3( player, var_1827e45669a6c403, var_4d0deed528845c35, unlockeventparams, var_64feb473633a5d17 );
    lethalinstance = player function_41f811caf4053d98( 1, 2 );
    unlockeventparams[ unlockeventparams.size ] = var_4d0deed528845c35;
    unlockeventparams[ unlockeventparams.size ] = lethalinstance.lootid;
    var_64feb473633a5d17[ lethalinstance.lootid ] = 1;
    var_4d0deed528845c35++;
    tacticalinstance = player function_41f811caf4053d98( 1, 3 );
    unlockeventparams[ unlockeventparams.size ] = var_4d0deed528845c35;
    unlockeventparams[ unlockeventparams.size ] = tacticalinstance.lootid;
    var_64feb473633a5d17[ tacticalinstance.lootid ] = 1;
    var_4d0deed528845c35++;
    fieldupgradeinstance = player function_41f811caf4053d98( 1, 4 );
    unlockeventparams[ unlockeventparams.size ] = var_4d0deed528845c35;
    unlockeventparams[ unlockeventparams.size ] = fieldupgradeinstance.lootid;
    var_64feb473633a5d17[ fieldupgradeinstance.lootid ] = 1;
    var_4d0deed528845c35++;
    killstreakinstance = player function_41f811caf4053d98( 65535, 0 );
    unlockeventparams[ unlockeventparams.size ] = var_4d0deed528845c35;
    unlockeventparams[ unlockeventparams.size ] = killstreakinstance.lootid;
    var_64feb473633a5d17[ killstreakinstance.lootid ] = 1;
    var_4d0deed528845c35++;
    
    for ( backpackindex = 1; backpackindex <= 12 ; backpackindex++ )
    {
        backpackinstance = player function_41f811caf4053d98( 2, backpackindex );
        
        if ( !isdefined( var_64feb473633a5d17[ backpackinstance.lootid ] ) )
        {
            unlockeventparams[ unlockeventparams.size ] = var_4d0deed528845c35;
            unlockeventparams[ unlockeventparams.size ] = backpackinstance.lootid;
            var_64feb473633a5d17[ backpackinstance.lootid ] = 1;
            var_4d0deed528845c35++;
        }
    }
    
    var_57428ff197753ac7 = var_4d0deed528845c35 - ae_utility::function_70b8bc68f3d8031e( aeeventname, #"loot_id" );
    assert( var_57428ff197753ac7 <= 49, "<dev string:x138>" + var_57428ff197753ac7 + "<dev string:x15b>" + 49 + "<dev string:x182>" );
    
    if ( utility::issharedfuncdefined( #"challenges", #"reportchallengeuserserializedeventwrapper" ) )
    {
        player utility::callsharedfunc( #"challenges", #"reportchallengeuserserializedeventwrapper", aeeventid, unlockeventparams );
    }
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0xab636ea3, Offset: 0x4ffd
// Size: 0xb3
function function_9ffc5abb3b50d97d( player )
{
    if ( function_5b82134531831158( player, 0 ) )
    {
        function_b86acd5b5496f84d( player, 1, 0 );
    }
    
    if ( function_5b82134531831158( player, 1 ) )
    {
        function_b86acd5b5496f84d( player, 1, 1 );
    }
    
    function_ce6e11615519b246( player );
    function_ba66e7c85bc79054( player, "primary" );
    function_ba66e7c85bc79054( player, "secondary" );
    function_ba66e7c85bc79054( player, "super" );
    function_7575906b0512f675( player );
    function_bf3288672a33d4a2( player );
    function_29eb2f072ac8b7ac( player );
    function_3885ada2ac161b19( player );
    function_1ab1d8636982f8eb( player );
    
    if ( !br_default_inventory::function_66b3b70a06d417( player ) )
    {
        function_e87bca754cd59b02( player );
    }
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0x28176452, Offset: 0x50b8
// Size: 0x15f
function function_b9ffb0377c528974( player )
{
    if ( !isdefined( player.initialequipment ) )
    {
        return;
    }
    
    if ( isdefined( player.initialequipment[ 2 ] ) )
    {
        equipref = loot::function_f54ecb89dfab8e8c( player.initialequipment[ 2 ] );
        isselectable = equipment_mp::isequipmentselectable( equipref );
        
        if ( isselectable )
        {
            player function_c178641b0ba5bf6f( player.initialequipment[ 2 ], 13, 1, 2, [] );
        }
    }
    
    if ( isdefined( player.initialequipment[ 3 ] ) )
    {
        equipref = loot::function_f54ecb89dfab8e8c( player.initialequipment[ 3 ] );
        isselectable = equipment_mp::isequipmentselectable( equipref );
        
        if ( isselectable )
        {
            player function_c178641b0ba5bf6f( player.initialequipment[ 3 ], 13, 1, 3, [] );
        }
    }
    
    if ( isdefined( player.initialequipment[ 4 ] ) )
    {
        superref = loot::function_f54ecb89dfab8e8c( player.initialequipment[ 4 ] );
        var_d4ee70327fda7d31 = supers_mp::function_3d6f3b9b75f1a86( superref );
        unlocksublocation = supers_mp::function_f8f61f6a3f73eff2( superref );
        
        if ( !var_d4ee70327fda7d31 || isdefined( unlocksublocation ) && function_902ad22eabe0eeeb( player, unlocksublocation ) )
        {
            player function_c178641b0ba5bf6f( player.initialequipment[ 4 ], 13, 1, 4, [] );
        }
    }
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0xc7bff6cf, Offset: 0x521f
// Size: 0x28
function function_de078ebf28199dd9( player )
{
    function_9fae6f8f377b222c( player );
    function_478ce990fa01c15c( player, 0 );
    function_b9ffb0377c528974( player );
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0xcce007f9, Offset: 0x524f
// Size: 0xc1
function function_9fae6f8f377b222c( player )
{
    function_15887a0388913565( player );
    function_b86acd5b5496f84d( player, 1, 0 );
    function_b86acd5b5496f84d( player, 1, 1 );
    function_ce6e11615519b246( player );
    function_ba66e7c85bc79054( player, "primary" );
    function_ba66e7c85bc79054( player, "secondary" );
    function_ba66e7c85bc79054( player, "super" );
    function_7575906b0512f675( player );
    function_bf3288672a33d4a2( player );
    function_29eb2f072ac8b7ac( player );
    function_3885ada2ac161b19( player );
    function_1ab1d8636982f8eb( player );
    function_aea1e0f4c9f696f4( player );
    function_7ef1298fd0cf6a2( player );
    
    if ( !br_default_inventory::function_66b3b70a06d417( player ) )
    {
        function_e87bca754cd59b02( player );
        return;
    }
    
    function_a11a8bd2cccf057a( player );
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0xc442205c, Offset: 0x5318
// Size: 0x3c
function function_e87bca754cd59b02( player )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    for ( backpackindex = 0; backpackindex < 11 ; backpackindex++ )
    {
        function_f927d5c3e2b0bdf0( player, backpackindex );
    }
}

/#

    // Namespace br_instance_inventory
    // Params 1
    // Checksum 0x68251750, Offset: 0x535c
    // Size: 0x2df, Type: dev
    function function_e041481cd4c56f32( player )
    {
        if ( !inventoryisvalid( player ) )
        {
            return;
        }
        
        primaryinstance = player function_41f811caf4053d98( 1, 0 );
        weaponstring = "<dev string:x1e5>";
        println( function_ea038b9b69942891( primaryinstance, weaponstring ) );
        secondaryinstance = player function_41f811caf4053d98( 1, 1 );
        weaponstring = "<dev string:x1f7>";
        println( function_ea038b9b69942891( secondaryinstance, weaponstring ) );
        var_1827e45669a6c403 = player function_41f811caf4053d98( 2, 0 );
        weaponstring = "<dev string:x209>";
        println( function_ea038b9b69942891( var_1827e45669a6c403, weaponstring ) );
        lethalinstance = player function_41f811caf4053d98( 1, 2 );
        println( "<dev string:x21a>" + lethalinstance.lootid );
        tacticalinstance = player function_41f811caf4053d98( 1, 3 );
        println( "<dev string:x238>" + tacticalinstance.lootid );
        fieldupgradeinstance = player function_41f811caf4053d98( 1, 4 );
        println( "<dev string:x258>" + fieldupgradeinstance.lootid );
        killstreakinstance = player function_41f811caf4053d98( 65535, 0 );
        println( "<dev string:x273>" + killstreakinstance.lootid );
        gasmaskinstance = player function_41f811caf4053d98( 65535, 4 );
        println( "<dev string:x28b>" + gasmaskinstance.lootid );
        backpackinstance = player function_41f811caf4053d98( 65535, 1 );
        println( "<dev string:x2a1>" + backpackinstance.lootid );
        selfreviveinstance = player function_41f811caf4053d98( 65535, 3 );
        println( "<dev string:x2b7>" + selfreviveinstance.lootid );
        var_58caca511d01c9f7 = player function_41f811caf4053d98( 1, 12 );
        println( "<dev string:x2d0>" + var_58caca511d01c9f7.lootid );
        var_3c403dab5af0fe5f = player function_41f811caf4053d98( 1, 13 );
        println( "<dev string:x2ed>" + var_3c403dab5af0fe5f.lootid );
        var_f38f508f91d148ac = player function_41f811caf4053d98( 1, 14 );
        println( "<dev string:x309>" + var_f38f508f91d148ac.lootid );
        var_a83427d7a98ef920 = player function_41f811caf4053d98( 1, 15 );
        println( "<dev string:x324>" + var_a83427d7a98ef920.lootid );
        var_e06a074047acec81 = player function_41f811caf4053d98( 1, 16 );
        println( "<dev string:x341>" + var_e06a074047acec81.lootid );
        
        for ( backpackindex = 1; backpackindex <= 12 ; backpackindex++ )
        {
            backpackinstance = player function_41f811caf4053d98( 2, backpackindex );
            println( "<dev string:x35d>" + backpackindex + "<dev string:x36c>" + backpackinstance.lootid );
        }
    }

#/

// Namespace br_instance_inventory
// Params 1
// Checksum 0xe82d6f52, Offset: 0x5643
// Size: 0x5e
function function_e591bfac2b8eccb7( player )
{
    var_7d64f8a3fc875ac9 = 7;
    player.var_3e00f0eda2ed92fb = [];
    
    for ( i = 0; i <= var_7d64f8a3fc875ac9 ; i++ )
    {
        player.var_3e00f0eda2ed92fb[ i ] = hud_util::createfontstring( "default", 0.8 );
    }
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0x25855bf, Offset: 0x56a9
// Size: 0x5be
function function_b73ad23f8ea8473f( player )
{
    if ( !inventoryisvalid( player ) )
    {
        return;
    }
    
    while ( true )
    {
        if ( !isdefined( player.var_3e00f0eda2ed92fb ) )
        {
            function_e591bfac2b8eccb7( player );
        }
        
        primaryinstance = player function_41f811caf4053d98( 1, 0 );
        
        /#
            player.var_3e00f0eda2ed92fb[ 0 ] setdevtext( function_ea038b9b69942891( primaryinstance, "<dev string:x1e5>" ) );
        #/
        
        player.var_3e00f0eda2ed92fb[ 0 ] hud_util::setpoint( "TOPLEFT", "TOPLEFT", 250, 30 );
        player.var_3e00f0eda2ed92fb[ 0 ] clearalltextafterhudelem();
        secondaryinstance = player function_41f811caf4053d98( 1, 1 );
        
        /#
            player.var_3e00f0eda2ed92fb[ 1 ] setdevtext( function_ea038b9b69942891( secondaryinstance, "<dev string:x1f7>" ) );
        #/
        
        player.var_3e00f0eda2ed92fb[ 1 ] hud_util::setpoint( "TOPLEFT", "TOPLEFT", 250, 40 );
        player.var_3e00f0eda2ed92fb[ 1 ] clearalltextafterhudelem();
        var_1827e45669a6c403 = player function_41f811caf4053d98( 2, 0 );
        
        /#
            player.var_3e00f0eda2ed92fb[ 2 ] setdevtext( function_ea038b9b69942891( var_1827e45669a6c403, "<dev string:x209>" ) );
        #/
        
        player.var_3e00f0eda2ed92fb[ 2 ] hud_util::setpoint( "TOPLEFT", "TOPLEFT", 250, 50 );
        player.var_3e00f0eda2ed92fb[ 2 ] clearalltextafterhudelem();
        lethalinstance = player function_41f811caf4053d98( 1, 2 );
        tacticalinstance = player function_41f811caf4053d98( 1, 3 );
        
        /#
            player.var_3e00f0eda2ed92fb[ 3 ] setdevtext( function_964c50c7ef3e1e41( lethalinstance, "<dev string:x21a>" ) + "<dev string:x372>" + function_964c50c7ef3e1e41( tacticalinstance, "<dev string:x374>" ) );
        #/
        
        player.var_3e00f0eda2ed92fb[ 3 ] hud_util::setpoint( "TOPLEFT", "TOPLEFT", 250, 60 );
        player.var_3e00f0eda2ed92fb[ 3 ] clearalltextafterhudelem();
        player.var_3e00f0eda2ed92fb[ 3 ].archived = 0;
        fieldupgradeinstance = player function_41f811caf4053d98( 1, 4 );
        killstreakinstance = player function_41f811caf4053d98( 65535, 0 );
        
        /#
            player.var_3e00f0eda2ed92fb[ 4 ] setdevtext( function_964c50c7ef3e1e41( fieldupgradeinstance, "<dev string:x395>" ) + "<dev string:x372>" + function_964c50c7ef3e1e41( killstreakinstance, "<dev string:x3ba>" ) );
        #/
        
        player.var_3e00f0eda2ed92fb[ 4 ] hud_util::setpoint( "TOPLEFT", "TOPLEFT", 250, 80 );
        player.var_3e00f0eda2ed92fb[ 4 ] clearalltextafterhudelem();
        player.var_3e00f0eda2ed92fb[ 4 ].archived = 0;
        gasmaskinstance = player function_41f811caf4053d98( 65535, 4 );
        backpackinstance = player function_41f811caf4053d98( 65535, 1 );
        var_c669166873e45e91 = player function_41f811caf4053d98( 65535, 2 );
        selfreviveinstance = player function_41f811caf4053d98( 65535, 3 );
        
        /#
            player.var_3e00f0eda2ed92fb[ 5 ] setdevtext( function_964c50c7ef3e1e41( gasmaskinstance, "<dev string:x28b>" ) + "<dev string:x372>" + function_964c50c7ef3e1e41( backpackinstance, "<dev string:x3d4>" ) + "<dev string:x372>" + function_964c50c7ef3e1e41( selfreviveinstance, "<dev string:x3eb>" ) + "<dev string:x372>" + function_964c50c7ef3e1e41( var_c669166873e45e91, "<dev string:x405>" ) );
        #/
        
        player.var_3e00f0eda2ed92fb[ 5 ] hud_util::setpoint( "TOPLEFT", "TOPLEFT", 250, 100 );
        player.var_3e00f0eda2ed92fb[ 5 ] clearalltextafterhudelem();
        player.var_3e00f0eda2ed92fb[ 5 ].archived = 0;
        var_58caca511d01c9f7 = player function_41f811caf4053d98( 1, 12 );
        var_3c403dab5af0fe5f = player function_41f811caf4053d98( 1, 13 );
        var_f38f508f91d148ac = player function_41f811caf4053d98( 1, 14 );
        var_a83427d7a98ef920 = player function_41f811caf4053d98( 1, 15 );
        var_e06a074047acec81 = player function_41f811caf4053d98( 1, 16 );
        
        /#
            player.var_3e00f0eda2ed92fb[ 6 ] setdevtext( function_964c50c7ef3e1e41( var_58caca511d01c9f7, "<dev string:x421>" ) + "<dev string:x372>" + function_964c50c7ef3e1e41( var_3c403dab5af0fe5f, "<dev string:x438>" ) + "<dev string:x372>" + function_964c50c7ef3e1e41( var_f38f508f91d148ac, "<dev string:x44f>" ) + "<dev string:x372>" + function_964c50c7ef3e1e41( var_a83427d7a98ef920, "<dev string:x465>" ) + "<dev string:x372>" + function_964c50c7ef3e1e41( var_e06a074047acec81, "<dev string:x47d>" ) );
        #/
        
        player.var_3e00f0eda2ed92fb[ 6 ] hud_util::setpoint( "TOPLEFT", "TOPLEFT", 250, 140 );
        player.var_3e00f0eda2ed92fb[ 6 ] clearalltextafterhudelem();
        player.var_3e00f0eda2ed92fb[ 6 ].archived = 0;
        backpackstring = "Backpack Items: ";
        
        for ( backpackindex = 1; backpackindex <= 12 ; backpackindex++ )
        {
            backpackinstance = player function_41f811caf4053d98( 2, backpackindex );
            backpackstring = backpackstring + function_964c50c7ef3e1e41( backpackinstance, "" ) + ", ";
        }
        
        /#
            player.var_3e00f0eda2ed92fb[ 7 ] setdevtext( backpackstring );
        #/
        
        player.var_3e00f0eda2ed92fb[ 7 ] hud_util::setpoint( "TOPLEFT", "TOPLEFT", 250, 190 );
        player.var_3e00f0eda2ed92fb[ 7 ] clearalltextafterhudelem();
        player.var_3e00f0eda2ed92fb[ 7 ].archived = 0;
        wait 3;
    }
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0x62ea0fbf, Offset: 0x5c6f
// Size: 0x5c
function function_73b33c06af05a74a( player )
{
    if ( !isdefined( level.var_dcf14cc71588a322 ) )
    {
        level.var_dcf14cc71588a322 = 0;
    }
    
    if ( !isdefined( player.var_1fa81a0e31f08222 ) )
    {
        player.var_1fa81a0e31f08222 = level.var_dcf14cc71588a322;
        level.var_dcf14cc71588a322++;
    }
    
    return player.var_1fa81a0e31f08222;
}

// Namespace br_instance_inventory
// Params 0
// Checksum 0xebb05634, Offset: 0x5cd4
// Size: 0x2e
function function_39eb177301b22065()
{
    if ( !isdefined( level.var_324e02e9cbfa8793 ) )
    {
        level.var_324e02e9cbfa8793 = getdvarint( @"hash_b39534cbfce013c4", 0 );
    }
    
    return level.var_324e02e9cbfa8793;
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0x4fdb8588, Offset: 0x5d0b
// Size: 0x101, Type: bool
function function_3fb45a56195cbfa2( player )
{
    if ( player.var_290d4d2254c00062 )
    {
        return true;
    }
    
    ticketid = loot::getlootidfromref( "loot_key_gold_door" );
    
    if ( !isdefined( ticketid ) )
    {
        return false;
    }
    
    for ( backpackindex = 14; backpackindex >= 1 ; backpackindex-- )
    {
        backpackinstance = player function_41f811caf4053d98( 2, backpackindex );
        
        if ( backpackinstance.instanceid != "0" && backpackinstance.lootid == ticketid )
        {
            player.var_290d4d2254c00062 = 1;
            
            if ( backpackindex <= 12 )
            {
                var_4071bcb00aad446f = backpackindex - 1;
                player setplayerdata( level.var_6f9b00680ed002d8, "dmzBackpack", var_4071bcb00aad446f, "lootID", 0 );
                player setplayerdata( level.var_6f9b00680ed002d8, "dmzBackpack", var_4071bcb00aad446f, "quantity", 0 );
            }
            
            function_b86acd5b5496f84d( player, 2, backpackindex );
            return true;
        }
    }
    
    return false;
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0x2af53089, Offset: 0x5e15
// Size: 0xd9
function function_491497f7c079c6e1( player )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    if ( !player isfireteamleader() )
    {
        return;
    }
    
    if ( !function_3fb45a56195cbfa2( player ) && function_39eb177301b22065() )
    {
        fireteammembers = player getfireteammembers();
        kick( player getentitynumber(), &"exe/playerkicked_no_bio_lab_ticket" );
        
        foreach ( fireteammember in fireteammembers )
        {
            kick( fireteammember getentitynumber(), &"exe/playerkicked_no_bio_lab_ticket" );
        }
    }
}

// Namespace br_instance_inventory
// Params 2
// Checksum 0xcb00475d, Offset: 0x5ef6
// Size: 0x3d, Type: bool
function function_5b82134531831158( player, slot )
{
    if ( !( isdefined( player ) && isdefined( player.insuredslots ) ) )
    {
        return true;
    }
    
    return !player.insuredslots[ slot ];
}

// Namespace br_instance_inventory
// Params 4
// Checksum 0x6ef4b2b5, Offset: 0x5f3c
// Size: 0x168
function function_cbd51514c40a0b0f( player, weaponindex, oldinstance, newinstance )
{
    if ( !function_926a8f8643d34690() )
    {
        return;
    }
    
    newmetadata = function_4e566b2102dcb480( newinstance );
    
    if ( function_9513862f69ec0498( 7, newinstance, 1 ) )
    {
        newmetadata[ 1 ] = function_15d4066789db807c( 7, 0, newmetadata[ 1 ] );
    }
    
    var_78f3437ed75d0ca8 = [];
    
    for ( attachmentoffset = 0; attachmentoffset <= 4 ; attachmentoffset++ )
    {
        attachmentindex = 0 + attachmentoffset;
        oldtuning = function_9513862f69ec0498( 2 + attachmentoffset, oldinstance, 1 );
        
        if ( isdefined( oldtuning ) && oldinstance.var_a834790f492b07f8[ attachmentindex ] != 0 )
        {
            var_78f3437ed75d0ca8[ oldinstance.var_a834790f492b07f8[ attachmentindex ] ] = oldtuning;
        }
    }
    
    for ( attachmentoffset = 0; attachmentoffset <= 4 ; attachmentoffset++ )
    {
        attachmentindex = 0 + attachmentoffset;
        oldtuning = 0;
        
        if ( isdefined( var_78f3437ed75d0ca8[ newinstance.var_a834790f492b07f8[ attachmentindex ] ] ) )
        {
            oldtuning = var_78f3437ed75d0ca8[ newinstance.var_a834790f492b07f8[ attachmentindex ] ];
        }
        
        newmetadata[ 1 ] = function_15d4066789db807c( 2 + attachmentoffset, oldtuning, newmetadata[ 1 ] );
    }
    
    securemetadata = function_81744e4202152fa2( newmetadata[ 0 ] );
    var_c11bbd62e8f23645 = function_81744e4202152fa2( newmetadata[ 1 ] );
    function_7ccc2499aab17e71( player, newinstance, securemetadata, var_c11bbd62e8f23645 );
}

// Namespace br_instance_inventory
// Params 0, eflags: 0x4
// Checksum 0x7a78aeb2, Offset: 0x60ac
// Size: 0x32
function private function_558bd431b283bbab()
{
    if ( !isdefined( level.var_4398e1e72f9e4002 ) )
    {
        level.var_4398e1e72f9e4002 = getdvarfloat( @"hash_4d31327236448d75", 0.05 );
    }
    
    return level.var_4398e1e72f9e4002;
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0x2386f233, Offset: 0x60e7
// Size: 0x37
function function_e8c80d2fa9b2512e( player )
{
    if ( !function_926a8f8643d34690() )
    {
        return 0;
    }
    
    upgradecount = getupgradecount( player, 14 );
    return upgradecount * function_558bd431b283bbab();
}

// Namespace br_instance_inventory
// Params 0, eflags: 0x4
// Checksum 0x7e5ff362, Offset: 0x6127
// Size: 0x32
function private function_a9acb66e35043a48()
{
    if ( !isdefined( level.armor_plate_discount ) )
    {
        level.armor_plate_discount = getdvarfloat( @"hash_aad2dc8050226460", 0.04 );
    }
    
    return level.armor_plate_discount;
}

// Namespace br_instance_inventory
// Params 0, eflags: 0x4
// Checksum 0x892a513, Offset: 0x6162
// Size: 0x32
function private function_5724821303485dd9()
{
    if ( !isdefined( level.var_176bcb49685bdbd1 ) )
    {
        level.var_176bcb49685bdbd1 = getdvarfloat( @"hash_1c2dc077c5758375", 0.05 );
    }
    
    return level.var_176bcb49685bdbd1;
}

// Namespace br_instance_inventory
// Params 0, eflags: 0x4
// Checksum 0x674e79cc, Offset: 0x619d
// Size: 0x32
function private getkillstreakdiscount()
{
    if ( !isdefined( level.killstreak_discount ) )
    {
        level.killstreak_discount = getdvarfloat( @"hash_c9a496baf46a5a42", 0.05 );
    }
    
    return level.killstreak_discount;
}

// Namespace br_instance_inventory
// Params 0, eflags: 0x4
// Checksum 0xe3104d1f, Offset: 0x61d8
// Size: 0x32
function private function_e9126db43d093bb4()
{
    if ( !isdefined( level.var_331a47d5363b6e94 ) )
    {
        level.var_331a47d5363b6e94 = getdvarfloat( @"hash_ae4f2b9bfc7f50a8", 0.05 );
    }
    
    return level.var_331a47d5363b6e94;
}

// Namespace br_instance_inventory
// Params 2
// Checksum 0x88299ed9, Offset: 0x6213
// Size: 0xaf
function function_fde5b7f7bf99327e( player, itemdata )
{
    if ( !function_926a8f8643d34690() )
    {
        return 0;
    }
    
    if ( itemdata.ref == "armor" )
    {
        upgradecount = getupgradecount( player, 13 );
        return ( function_a9acb66e35043a48() * upgradecount );
    }
    
    if ( itemdata.ref == "dmz_exfil_personal" )
    {
        upgradecount = getupgradecount( player, 11 );
        return ( function_5724821303485dd9() * upgradecount );
    }
    
    if ( itemdata.type == "killstreak" )
    {
        upgradecount = getupgradecount( player, 12 );
        return ( getkillstreakdiscount() * upgradecount );
    }
}

// Namespace br_instance_inventory
// Params 2
// Checksum 0xdd89298f, Offset: 0x62ca
// Size: 0x8d
function function_e7d0a9ebc17e1239( player, insuredslot )
{
    var_f9e9e04098b5c3cf = undefined;
    
    switch ( insuredslot )
    {
        case #"hash_31100fbc01bd387c":
            var_f9e9e04098b5c3cf = 16;
            break;
        case #"hash_311012bc01bd3d35":
            var_f9e9e04098b5c3cf = 17;
            break;
        case #"hash_311011bc01bd3ba2":
            var_f9e9e04098b5c3cf = 18;
            break;
    }
    
    if ( isdefined( var_f9e9e04098b5c3cf ) )
    {
        upgradecount = getupgradecount( player, var_f9e9e04098b5c3cf );
        return ( upgradecount * function_e9126db43d093bb4() );
    }
    
    return 0;
}

// Namespace br_instance_inventory
// Params 1, eflags: 0x4
// Checksum 0x42f89e86, Offset: 0x635f
// Size: 0x3b
function private function_9a0213362a902bc3( player )
{
    baseplates = level.spawnarmorplates;
    
    if ( !function_926a8f8643d34690() )
    {
        return baseplates;
    }
    
    return baseplates + getupgradecount( player, 29 );
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0xa57ade23, Offset: 0x63a3
// Size: 0x37
function getnumstartupgradeplates( player )
{
    var_3c9b8cee9fb2782a = armor::function_db9ebf086f67fe92();
    upgradecount = function_9a0213362a902bc3( player );
    return min( upgradecount, var_3c9b8cee9fb2782a );
}

// Namespace br_instance_inventory
// Params 1
// Checksum 0x7fc36473, Offset: 0x63e3
// Size: 0x45
function function_2b6831d1c23b80fd( player )
{
    if ( !function_926a8f8643d34690() )
    {
        return 0;
    }
    
    var_92de4061c012ef13 = function_9a0213362a902bc3( player );
    var_3c9b8cee9fb2782a = armor::function_db9ebf086f67fe92();
    return max( 0, var_92de4061c012ef13 - var_3c9b8cee9fb2782a );
}

// Namespace br_instance_inventory
// Params 2
// Checksum 0xb4770350, Offset: 0x6431
// Size: 0x2d, Type: bool
function function_902ad22eabe0eeeb( player, sublocation )
{
    if ( !function_926a8f8643d34690() )
    {
        return true;
    }
    
    return getupgradecount( player, sublocation ) > 0;
}

// Namespace br_instance_inventory
// Params 2
// Checksum 0xce518792, Offset: 0x6467
// Size: 0x30
function getupgradecount( player, sublocation )
{
    if ( function_e19d6e094a0f9a89() )
    {
        return 1;
    }
    
    return player function_d2d396f77637ea86( sublocation ) ?? 0;
}

// Namespace br_instance_inventory
// Params 2
// Checksum 0xd21f0ec0, Offset: 0x649f
// Size: 0xc2
function function_f27d28bab3135f68( team, sublocation )
{
    var_af1b313561dc03b7 = 0;
    players = teams::getteamdata( team, "players" );
    
    foreach ( player in players )
    {
        upgradecount = getupgradecount( player, sublocation );
        var_af1b313561dc03b7 = max( upgradecount, var_af1b313561dc03b7 );
    }
    
    return int( var_af1b313561dc03b7 );
}

/#

    // Namespace br_instance_inventory
    // Params 1
    // Checksum 0x584c5c70, Offset: 0x656a
    // Size: 0x18b, Type: dev
    function debugprintmetadata( instance )
    {
        println( "<dev string:x494>" + instance.instanceid );
        
        if ( isdefined( instance.metadata ) )
        {
            println( "<dev string:x4b4>" );
            
            foreach ( data in instance.metadata )
            {
                println( "<dev string:x4c5>" + data.key + "<dev string:x4cb>" + data.value );
            }
        }
        
        if ( isdefined( instance.var_c11bbd62e8f23645 ) )
        {
            println( "<dev string:x4d5>" );
            
            foreach ( data in instance.var_c11bbd62e8f23645 )
            {
                println( "<dev string:x4c5>" + data.key + "<dev string:x4cb>" + data.value );
            }
        }
        
        println( "<dev string:x4e8>" );
    }

#/
