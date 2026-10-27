// scripts\mp\br\gametypes\br_default_inventory.gsc  (hash_63a08d721a3267bc.gscc) (size: 37683 Bytes / 0x9333 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x46e5067c (1189414524)
// size ...... 37683 (0x9333)
// includes .. 33  (offset: 0x8c3f)
// strings ... 72  (offset: 0x8d47)
// dev strs .. 15  (offset: 0x927f)
// exports ... 97  (offset: 0x5f83)
// cseg ...... 0x63b + 0x5948 (0x5f83)
// imports ... 222 (offset: 0x6eab)
// animtree1 . 0   (offset: 0x9333)
// animtree2 . 0   (offset: 0x9333)
#using script_3a5f079804604bc4;
#using script_68bfedf2ed730bd;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\armor;
#using scripts\mp\br\gametypes\br_analytics;
#using scripts\mp\br\gametypes\br_elite_broken_arrow;
#using scripts\mp\br\gametypes\br_gametype_truckwar;
#using scripts\mp\br\gametypes\br_headgear;
#using scripts\mp\br\gametypes\br_instance_inventory;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_strongholds;
#using scripts\mp\br\gametypes\br_weapons;
#using scripts\mp\class;
#using scripts\mp\common\equipment\hb_sensor;
#using scripts\mp\common\utility\backpack;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\pickups_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\dmz\gametypes\dmz_dog_tag;
#using scripts\mp\equipment;
#using scripts\mp\flags;
#using scripts\mp\laststand;
#using scripts\mp\loot\common_instance_inventory;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\supers;
#using scripts\mp\talking_gun;
#using scripts\mp\weapons;

#namespace br_default_inventory;

// Namespace br_default_inventory
// Params 0
// Checksum 0xeef430d5, Offset: 0x659
// Size: 0xf0
function function_3c3f2e6d975dc468()
{
    if ( level.var_eda7b39474060e6 )
    {
        level.backpackdata = "dmzBackpack";
        level.backpacksize = "dmzBackpackSize";
    }
    else
    {
        level.backpackdata = "brBackpack";
        level.backpacksize = "brBackpackSize";
    }
    
    level.var_436cd27dd88105b1 = game_utility_mp::privatematch();
    
    if ( !isdefined( level.var_77acd6c239c79918 ) )
    {
        level.var_77acd6c239c79918 = [];
    }
    
    level.var_77acd6c239c79918[ level.var_77acd6c239c79918.size ] = "equip_c4";
    level.var_77acd6c239c79918[ level.var_77acd6c239c79918.size ] = "equip_throwing_knife";
    level.var_77acd6c239c79918[ level.var_77acd6c239c79918.size ] = "equip_claymore";
    level.var_77acd6c239c79918[ level.var_77acd6c239c79918.size ] = "equip_at_mine";
    level.var_77acd6c239c79918[ level.var_77acd6c239c79918.size ] = "equip_throwing_knife_fire";
}

// Namespace br_default_inventory
// Params 2
// Checksum 0x8321ac31, Offset: 0x751
// Size: 0xcf
function function_ba03dc5a721b978b( player, ammotype )
{
    if ( function_787d2ebb0cc2e86f( player ) )
    {
        playerdataweapon = function_3b4976a12ea5037b( player );
        weaponammotype = br_weapons::br_ammo_type_for_weapon( playerdataweapon );
        
        if ( isdefined( weaponammotype ) )
        {
            if ( isdefined( ammotype ) && ammotype != weaponammotype )
            {
                return;
            }
            
            weaponstockammo = player.br_ammo[ weaponammotype ];
            maxstock = level.var_9a6a4b42eba220f6[ weaponammotype ];
            weaponstockammo = int( min( weaponstockammo, maxstock ) );
            
            if ( weaponstockammo > 1023 )
            {
                assertmsg( "<dev string:x24>" + weaponstockammo + "<dev string:x65>" + playerdataweapon.basename );
            }
            
            player setclientomnvar( "ui_playerdata_weapon_ammo", weaponstockammo );
        }
    }
}

// Namespace br_default_inventory
// Params 5
// Checksum 0x88f120b7, Offset: 0x828
// Size: 0x54
function function_4494ac60be615891( player, weapon, var_fbbec105d2e96d39, metadata, dontupdateammo )
{
    if ( br_instance_inventory::function_926a8f8643d34690() )
    {
        br_instance_inventory::function_9e6e0e24612d44e0( player, weapon, var_fbbec105d2e96d39, metadata );
        return;
    }
    
    function_f2c0ee30b21c4387( player, weapon, dontupdateammo );
}

// Namespace br_default_inventory
// Params 3
// Checksum 0x829b2145, Offset: 0x884
// Size: 0x6d
function function_d037aa7c60e3b4ce( player, stickerslot, sticker )
{
    if ( sticker == "sticker_none" )
    {
        player setplayerdata( level.var_6f9b00680ed002d8, "dmzWeapon", "sticker", stickerslot, sticker );
        return;
    }
    
    player setplayerdata( level.var_6f9b00680ed002d8, "dmzWeapon", "sticker", stickerslot, getsubstr( sticker, 2 ) );
}

// Namespace br_default_inventory
// Params 3
// Checksum 0xfc3217bd, Offset: 0x8f9
// Size: 0x39d
function function_f2c0ee30b21c4387( player, weapon, dontupdateammo )
{
    rootname = weapon::getweaponrootname( weapon );
    variantid = weapon.variantid ?? 0;
    lootid = weapon::getweaponlootid( weapon );
    player setplayerdata( level.var_6f9b00680ed002d8, "dmzWeapon", "weapon", rootname );
    player setplayerdata( level.var_6f9b00680ed002d8, "dmzWeapon", "variantID", variantid );
    player setplayerdata( level.var_6f9b00680ed002d8, "dmzWeapon", "lootItemID", lootid );
    
    if ( !dontupdateammo )
    {
        player.weaponslotclip = player getweaponammoclip( weapon );
        player.var_ee5ceae7ad99228 = player getweaponammoclip( weapon, "left" );
        
        if ( weapon.hasalternate )
        {
            weaponalt = weapon getaltweapon();
            player.var_655fababc6344d9f = player getweaponammoclip( weaponalt );
        }
    }
    
    attachments = getweaponattachments( weapon );
    playerdataindex = 0;
    attachmenttoidmap = weapon.attachmentvarindices;
    maxprimaryattachments = weapon::getmaxprimaryattachments( player class::function_facf39de1a82731a() );
    
    for ( attachmentindex = 0; attachmentindex < attachments.size && playerdataindex < maxprimaryattachments ; attachmentindex++ )
    {
        if ( weapon::attachmentisselectable( weapon, attachments[ attachmentindex ] ) )
        {
            player setplayerdata( level.var_6f9b00680ed002d8, "dmzWeapon", "attachmentSetup", playerdataindex, "attachment", attachments[ attachmentindex ] );
            player setplayerdata( level.var_6f9b00680ed002d8, "dmzWeapon", "attachmentSetup", playerdataindex, "variantID", attachmenttoidmap[ attachments[ attachmentindex ] ] );
            playerdataindex++;
        }
    }
    
    for ( attachmentindex = playerdataindex; playerdataindex < maxprimaryattachments ; attachmentindex++ )
    {
        player setplayerdata( level.var_6f9b00680ed002d8, "dmzWeapon", "attachmentSetup", playerdataindex, "attachment", "none" );
        player setplayerdata( level.var_6f9b00680ed002d8, "dmzWeapon", "attachmentSetup", playerdataindex, "variantID", 0 );
        playerdataindex++;
    }
    
    if ( isdefined( weapon.camo ) )
    {
        player setplayerdata( level.var_6f9b00680ed002d8, "dmzWeapon", "camo", weapon.camo );
    }
    
    if ( isdefined( weapon.reticle ) )
    {
        player setplayerdata( level.var_6f9b00680ed002d8, "dmzWeapon", "reticle", weapon.reticle );
    }
    
    if ( isdefined( weapon.visual ) )
    {
        player setplayerdata( level.var_6f9b00680ed002d8, "dmzWeapon", "cosmeticAttachment", weapon.visual );
    }
    
    if ( isdefined( weapon.stickerslot0 ) )
    {
        function_d037aa7c60e3b4ce( player, 0, weapon.stickerslot0 );
    }
    
    if ( isdefined( weapon.stickerslot1 ) )
    {
        function_d037aa7c60e3b4ce( player, 1, weapon.stickerslot1 );
    }
    
    if ( isdefined( weapon.stickerslot2 ) )
    {
        function_d037aa7c60e3b4ce( player, 2, weapon.stickerslot2 );
    }
    
    if ( isdefined( weapon.stickerslot3 ) )
    {
        function_d037aa7c60e3b4ce( player, 3, weapon.stickerslot3 );
    }
    
    if ( isdefined( weapon.var_73762c7cb8b2063 ) )
    {
        function_d037aa7c60e3b4ce( player, 4, weapon.var_73762c7cb8b2063 );
    }
    
    function_3b53d6fa7c7ed259( player, weapon );
    function_ba03dc5a721b978b( player );
}

// Namespace br_default_inventory
// Params 2
// Checksum 0xf266d8db, Offset: 0xc9e
// Size: 0x32
function function_3b53d6fa7c7ed259( player, weapon = function_4a9e65f11966819f( player ) )
{
    player.playerdataweapon = weapon;
}

// Namespace br_default_inventory
// Params 1
// Checksum 0x30d10e5e, Offset: 0xcd8
// Size: 0x17
function function_3b4976a12ea5037b( player )
{
    return player.playerdataweapon;
}

// Namespace br_default_inventory
// Params 3
// Checksum 0x6d6a2ab9, Offset: 0xcf8
// Size: 0x1db
function function_4a9e65f11966819f( player, statsgroup = level.var_6f9b00680ed002d8, weaponkey = "dmzWeapon" )
{
    weapon = player getplayerdata( statsgroup, weaponkey, "weapon" );
    variantid = player getplayerdata( statsgroup, weaponkey, "variantID" );
    attachments = [];
    attachmentids = [];
    var_b3ca7b468de89ea3 = [];
    maxprimaryattachments = weapon::getmaxprimaryattachments( player class::function_facf39de1a82731a() );
    
    for ( attachmentindex = 0; attachmentindex < maxprimaryattachments ; attachmentindex++ )
    {
        attachments[ attachmentindex ] = player getplayerdata( statsgroup, weaponkey, "attachmentSetup", attachmentindex, "attachment" );
        attachmentids[ attachmentindex ] = player getplayerdata( statsgroup, weaponkey, "attachmentSetup", attachmentindex, "variantID" );
        slider1 = player getplayerdata( statsgroup, weaponkey, "attachmentSetup", attachmentindex, "customTune", 0 );
        slider2 = player getplayerdata( statsgroup, weaponkey, "attachmentSetup", attachmentindex, "customTune", 1 );
        tuningvalues = class::function_30bf6ea7991aec2a( slider1, slider2 );
        
        if ( isdefined( tuningvalues ) )
        {
            var_b3ca7b468de89ea3[ attachments[ attachmentindex ] ] = tuningvalues;
        }
    }
    
    camo = player getplayerdata( statsgroup, weaponkey, "camo" );
    reticle = player getplayerdata( statsgroup, weaponkey, "reticle" );
    cosmeticattachment = player getplayerdata( statsgroup, weaponkey, "cosmeticAttachment" );
    stickers = [];
    
    for ( stickerindex = 0; stickerindex < 5 ; stickerindex++ )
    {
        stickers[ stickerindex ] = player getplayerdata( statsgroup, weaponkey, "sticker", stickerindex );
    }
    
    return weapon::buildweapon( weapon, attachments, camo, reticle, variantid, attachmentids, cosmeticattachment, stickers );
}

// Namespace br_default_inventory
// Params 1
// Checksum 0xa65dc8b2, Offset: 0xedc
// Size: 0xa5
function function_787d2ebb0cc2e86f( player )
{
    ret = isdefined( player.playerdataweapon ) && player.playerdataweapon.basename != "none";
    
    /#
        if ( level.var_29494481caeebcbc && common_instance_inventory::isenabled() )
        {
            data = player getplayerdata( level.var_6f9b00680ed002d8, "<dev string:x7c>", "<dev string:x86>" );
            assert( data != "<dev string:x8d>" == ret, "<dev string:x92>" + data + "<dev string:xdd>" + ret );
        }
    #/
    
    return ret;
}

// Namespace br_default_inventory
// Params 1
// Checksum 0x43edc34a, Offset: 0xf8a
// Size: 0x25
function function_2a1febd848e9d620( player )
{
    return player getplayerdata( level.var_6f9b00680ed002d8, "dmzWeapon", "lootItemID" );
}

// Namespace br_default_inventory
// Params 1
// Checksum 0x6dfe7b18, Offset: 0xfb8
// Size: 0x27
function function_f7c0ab39bb3170f( player )
{
    if ( br_instance_inventory::function_926a8f8643d34690() )
    {
        br_instance_inventory::function_ce6e11615519b246( player );
    }
    
    function_41f1acd3a22c850e( player );
}

// Namespace br_default_inventory
// Params 3
// Checksum 0x7c48c168, Offset: 0xfe7
// Size: 0x208
function function_92c689bad6f37a9( player, statsgroup = level.var_6f9b00680ed002d8, weaponkey = "dmzWeapon" )
{
    if ( class::function_4d362babbfd5b4b1() )
    {
        player setplayerdata( statsgroup, weaponkey, "weaponLootID", 0 );
        player setplayerdata( statsgroup, weaponkey, "lootItemID", 0 );
        player setplayerdata( statsgroup, weaponkey, "camoLootID", 0 );
        player setplayerdata( statsgroup, weaponkey, "reticleLootID", 0 );
        player setplayerdata( statsgroup, weaponkey, "cosmeticAttachmentLootID", 0 );
        player setplayerdata( statsgroup, weaponkey, "weaponVariantID", 0 );
        player setplayerdata( statsgroup, weaponkey, "blueprintName", "" );
        
        for ( attachindex = 0; attachindex < 17 ; attachindex++ )
        {
            player setplayerdata( statsgroup, weaponkey, "attachmentSetup", attachindex, "attachmentLootID", 0 );
            player setplayerdata( statsgroup, weaponkey, "attachmentSetup", attachindex, "attachmentVariantID", 0 );
        }
        
        for ( stickerindex = 0; stickerindex < 5 ; stickerindex++ )
        {
            player setplayerdata( statsgroup, weaponkey, "stickerLootIDs", stickerindex, 0 );
        }
        
        return;
    }
    
    player setplayerdata( statsgroup, weaponkey, "weapon", "none" );
    player setplayerdata( statsgroup, weaponkey, "lootItemID", 0 );
    player setplayerdata( statsgroup, weaponkey, "camo", "camo_none" );
    player setplayerdata( statsgroup, weaponkey, "reticle", "none" );
    player setplayerdata( statsgroup, weaponkey, "cosmeticAttachment", "charm_none" );
    player setplayerdata( statsgroup, weaponkey, "variantID", 0 );
    player setplayerdata( statsgroup, weaponkey, "blueprintName", "" );
    
    for ( attachindex = 0; attachindex < 5 ; attachindex++ )
    {
        player setplayerdata( statsgroup, weaponkey, "attachmentSetup", attachindex, "attachment", "none" );
        player setplayerdata( statsgroup, weaponkey, "attachmentSetup", attachindex, "variantID", 0 );
    }
    
    for ( stickerindex = 0; stickerindex < 4 ; stickerindex++ )
    {
        player setplayerdata( statsgroup, weaponkey, "sticker", stickerindex, "sticker_none" );
    }
}

// Namespace br_default_inventory
// Params 3
// Checksum 0xca91cbd4, Offset: 0x11f7
// Size: 0x34
function function_a8cbf99045215e0b( player, statsgroup, weaponkey )
{
    function_92c689bad6f37a9( player, statsgroup, weaponkey );
    player.playerdataweapon = undefined;
}

// Namespace br_default_inventory
// Params 2
// Checksum 0xe2de7b15, Offset: 0x1233
// Size: 0x45
function function_41f1acd3a22c850e( player, weaponkey )
{
    function_a8cbf99045215e0b( player, undefined, "dmzWeapon" );
    player.weaponslotclip = undefined;
    player.var_655fababc6344d9f = undefined;
    player.var_ee5ceae7ad99228 = undefined;
}

// Namespace br_default_inventory
// Params 1
// Checksum 0xdee7fe79, Offset: 0x1280
// Size: 0x50
function function_c167a667afff77a0( lootid )
{
    if ( lootid == 0 )
    {
        return;
    }
    
    for ( i = 0; i < getplayerbackpacksize( self ) ; i++ )
    {
        currentlootid = getlootidatbackpackindex( i );
        
        if ( lootid == currentlootid )
        {
            return i;
        }
    }
}

// Namespace br_default_inventory
// Params 1
// Checksum 0xb9a3bb0, Offset: 0x12d9
// Size: 0x6f
function function_2dea722d6c0344( lootid )
{
    if ( lootid == 0 )
    {
        return;
    }
    
    indexes = [];
    
    for ( i = 0; i < getplayerbackpacksize( self ) ; i++ )
    {
        currentlootid = getlootidatbackpackindex( i );
        
        if ( lootid == currentlootid )
        {
            indexes[ i ] = getquantityatbackpackindex( i );
        }
    }
    
    indexes = tablesort( indexes );
    return indexes;
}

// Namespace br_default_inventory
// Params 0
// Checksum 0xb6c38e3, Offset: 0x1351
// Size: 0x7e, Type: bool
function function_b7b8a2d7ac9eb88b()
{
    /#
        if ( issubstr( level.mapname, "<dev string:xf5>" ) || level.mapname == "<dev string:x102>" )
        {
            return true;
        }
    #/
    
    var_dae3b14d684ab55b = game_utility_mp::privatematch() && !br_instance_inventory::function_926a8f8643d34690() && getdvarint( @"hash_6f45a6cbb79f0513", 0 ) == 0;
    return game_utility_mp::matchmakinggame() || var_dae3b14d684ab55b || getdvarint( @"force_ranking" );
}

// Namespace br_default_inventory
// Params 1
// Checksum 0x3725ca69, Offset: 0x13d8
// Size: 0xbc
function getinventoryweapons( player )
{
    weapons = [];
    primaries = player getweaponslistprimaries();
    
    foreach ( weapon in primaries )
    {
        if ( !weapons::isdroppableweapon( player, weapon ) || weaponinventorytype( weapon ) == "altmode" )
        {
            continue;
        }
        
        weapons[ weapons.size ] = weapon;
    }
    
    return weapons;
}

// Namespace br_default_inventory
// Params 0
// Checksum 0x9e3b12d3, Offset: 0x149d
// Size: 0x115
function snapshotbackpack()
{
    items = [];
    
    for ( i = 0; i < getplayerbackpacksize( self ) ; i++ )
    {
        [ lootid, quantity ] = function_c022fc696a9c0db2( i );
        
        if ( lootid != 0 )
        {
            item = spawnstruct();
            item.lootid = lootid;
            item.quantity = quantity;
            item.index = i;
            items[ items.size ] = item;
        }
    }
    
    if ( function_787d2ebb0cc2e86f( self ) )
    {
        item = spawnstruct();
        item.lootid = function_2a1febd848e9d620( self );
        item.quantity = 1;
        item.objweapon = function_3b4976a12ea5037b( self );
        weaponmetadata = br_instance_inventory::function_6a05cf5689058e1f( self, 2 );
        
        if ( isdefined( weaponmetadata ) )
        {
            item.metadata = weaponmetadata;
        }
        
        items[ items.size ] = item;
    }
    
    return items;
}

// Namespace br_default_inventory
// Params 1
// Checksum 0x8632b69f, Offset: 0x15bb
// Size: 0x57
function function_c022fc696a9c0db2( index )
{
    lootid = getlootidatbackpackindex( index );
    quantity = getquantityatbackpackindex( index );
    lootedquantity = function_41e5f27c84ad38e9( index );
    return [ lootid, quantity, lootedquantity ];
}

// Namespace br_default_inventory
// Params 2
// Checksum 0xde8767f3, Offset: 0x161b
// Size: 0x68
function function_6f2fadfc318b9264( index, amount )
{
    if ( !function_b7b8a2d7ac9eb88b() )
    {
        return;
    }
    
    oldamount = getquantityatbackpackindex( index );
    newamount = int( max( 0, oldamount + amount ) );
    lootid = getlootidatbackpackindex( index );
    function_6dae6e0cfd744f41( index, lootid, newamount );
}

// Namespace br_default_inventory
// Params 7
// Checksum 0xe914325e, Offset: 0x168b
// Size: 0x67
function function_5429728066900449( player, index, lootid, quantity, loadoutlocation, loadoutslot, lootedquantity = 0 )
{
    br_instance_inventory::function_43d0b80ae3044ee5( player, index, loadoutlocation, loadoutslot );
    player function_6dae6e0cfd744f41( index, lootid, quantity, undefined, lootedquantity );
}

// Namespace br_default_inventory
// Params 6
// Checksum 0xbabdbfad, Offset: 0x16fa
// Size: 0x9f
function function_d85bb3c0fe7a50a4( player, index, lootid, quantity, lootedquantity = 0, var_a41c16bd9265879e )
{
    oldlootid = player getplayerdata( level.var_6f9b00680ed002d8, level.backpackdata, index, "lootID" );
    
    if ( oldlootid != lootid && ( quantity > 0 || lootedquantity > 0 ) )
    {
        br_instance_inventory::function_36435954ba667ab8( player, index, lootid );
    }
    
    player function_6dae6e0cfd744f41( index, lootid, quantity, undefined, lootedquantity, var_a41c16bd9265879e );
}

// Namespace br_default_inventory
// Params 2
// Checksum 0x6f963c4f, Offset: 0x17a1
// Size: 0x1f
function function_8dd4724906f22d8c( player, index )
{
    br_instance_inventory::function_f927d5c3e2b0bdf0( player, index );
}

// Namespace br_default_inventory
// Params 4
// Checksum 0x98e8eff8, Offset: 0x17c8
// Size: 0x59
function function_d625d28b11a26654( player, index, quantity, var_ba8037d764bafa3f )
{
    if ( !isdefined( level.backpackdata ) )
    {
        return;
    }
    
    oldlootid = player getlootidatbackpackindex( index );
    player function_6dae6e0cfd744f41( index, oldlootid, quantity, var_ba8037d764bafa3f );
}

// Namespace br_default_inventory
// Params 6, eflags: 0x4
// Checksum 0xcc429bb9, Offset: 0x1829
// Size: 0x1fa
function private function_6dae6e0cfd744f41( index, lootid, quantity, var_ba8037d764bafa3f, lootedquantity, var_a41c16bd9265879e )
{
    if ( !function_b7b8a2d7ac9eb88b() )
    {
        return;
    }
    
    if ( !isdefined( lootedquantity ) )
    {
        lootedquantity = 0;
    }
    
    if ( !isdefined( quantity ) || quantity < 0 )
    {
        quantity = 0;
    }
    
    if ( !isdefined( lootid ) || lootid != 0 && quantity == 0 && !var_a41c16bd9265879e )
    {
        lootid = 0;
    }
    
    if ( level.var_436cd27dd88105b1 )
    {
        self setplayerdata( level.var_6f9b00680ed002d8, level.backpackdata, index, "lootID", 1 );
        self setplayerdata( level.var_6f9b00680ed002d8, level.backpackdata, index, "quantity", 1 );
    }
    
    self setplayerdata( level.var_6f9b00680ed002d8, level.backpackdata, index, "lootID", lootid );
    self setplayerdata( level.var_6f9b00680ed002d8, level.backpackdata, index, "quantity", quantity );
    self setplayerdata( level.var_6f9b00680ed002d8, level.backpackdata, index, "lootedQuantity", lootedquantity );
    
    if ( quantity == 0 && lootedquantity == 0 && !var_a41c16bd9265879e || lootid == 0 )
    {
        self setplayerdata( level.var_6f9b00680ed002d8, level.backpackdata, index, "lootID", 0 );
        self setplayerdata( level.var_6f9b00680ed002d8, level.backpackdata, index, "quantity", 0 );
        self setplayerdata( level.var_6f9b00680ed002d8, level.backpackdata, index, "lootedQuantity", 0 );
        
        if ( !var_ba8037d764bafa3f )
        {
            function_8dd4724906f22d8c( self, index );
        }
        
        return;
    }
    
    pickup = spawnstruct();
    pickup.scriptablename = loot::getScriptableFromLootID( lootid );
    br_analytics::branalytics_lootpickup( self, pickup.scriptablename, quantity );
}

// Namespace br_default_inventory
// Params 0
// Checksum 0x9faed554, Offset: 0x1a2b
// Size: 0x69
function function_791cfb45f0f0d66a()
{
    function_7fcce769f23a1428( self, 5, 1 );
    br_instance_inventory::function_3885ada2ac161b19( self );
    br_instance_inventory::function_1ab1d8636982f8eb( self );
    
    if ( game_utility::getgametype() == "dmz" )
    {
        br_pickups::function_402de4642e0ec93c( self );
        return;
    }
    
    var_476da819766fbb9b = level.platecarrierstartlevel;
    platescriptable = br_public::function_3a7d2e84c32519a9( var_476da819766fbb9b );
    br_pickups::function_402de4642e0ec93c( self, platescriptable );
}

// Namespace br_default_inventory
// Params 1
// Checksum 0x2d251a84, Offset: 0x1a9c
// Size: 0x4f
function clearbackpack( var_ba8037d764bafa3f )
{
    for ( packitemindex = 0; packitemindex < getplayerbackpacksize( self ) ; packitemindex++ )
    {
        function_39f0833282ad6f6( packitemindex, undefined, var_ba8037d764bafa3f );
    }
    
    if ( var_ba8037d764bafa3f )
    {
        self.var_43af94eb90e19dfa = 1;
    }
    
    function_791cfb45f0f0d66a();
}

// Namespace br_default_inventory
// Params 0
// Checksum 0x36a373f8, Offset: 0x1af3
// Size: 0xb0
function function_c0b169f62dbfe988()
{
    for ( packitemindex = 0; packitemindex < getplayerbackpacksize( self ) ; packitemindex++ )
    {
        if ( level.var_436cd27dd88105b1 )
        {
            self setplayerdata( level.var_6f9b00680ed002d8, level.backpackdata, packitemindex, "lootID", 1 );
            self setplayerdata( level.var_6f9b00680ed002d8, level.backpackdata, packitemindex, "quantity", 1 );
        }
        
        self setplayerdata( level.var_6f9b00680ed002d8, level.backpackdata, packitemindex, "lootID", 0 );
        self setplayerdata( level.var_6f9b00680ed002d8, level.backpackdata, packitemindex, "quantity", 0 );
    }
}

// Namespace br_default_inventory
// Params 2
// Checksum 0x11e34528, Offset: 0x1bab
// Size: 0x133
function canitemfitinbackpack( lootid, quantity )
{
    initialquantity = quantity;
    lootname = loot::getScriptableFromLootID( lootid );
    
    if ( !isdefined( lootname ) )
    {
        lootname = loot::function_f54ecb89dfab8e8c( lootid );
    }
    
    maxcount = level.br_pickups.var_3444316dc55e4b0a[ lootname ];
    
    if ( !isdefined( maxcount ) )
    {
        maxcount = level.br_pickups.maxcounts[ lootname ];
    }
    
    result = utility::callsharedfunc( #"gametype", #"canitemfitinbackpack", lootid, lootname, quantity, maxcount );
    
    if ( isdefined( result ) )
    {
        return result;
    }
    
    for ( i = 0; i < getplayerbackpacksize( self ) ; i++ )
    {
        currentlootid = getlootidatbackpackindex( i );
        
        if ( currentlootid == 0 && currentlootid != lootid )
        {
            return 1;
        }
        
        if ( currentlootid == lootid )
        {
            currentquantity = getquantityatbackpackindex( i );
            
            if ( currentquantity + quantity <= maxcount )
            {
                return 1;
            }
            
            quantity = currentquantity + quantity - maxcount;
        }
    }
    
    if ( quantity == initialquantity )
    {
        return 0;
    }
    
    return 1;
}

// Namespace br_default_inventory
// Params 3
// Checksum 0x8db4eef8, Offset: 0x1ce7
// Size: 0xe3
function function_58dd112b3bffe0d3( lootid, quantity, drop )
{
    if ( !isdefined( lootid ) )
    {
        return;
    }
    
    lootname = loot::getScriptableFromLootID( lootid );
    
    if ( !isdefined( lootname ) )
    {
        lootname = loot::function_f54ecb89dfab8e8c( lootid );
    }
    
    maxcount = level.br_pickups.var_3444316dc55e4b0a[ lootname ];
    
    if ( !isdefined( maxcount ) )
    {
        maxcount = level.br_pickups.maxcounts[ lootname ];
    }
    
    for ( i = 0; i < getplayerbackpacksize( self ) ; i++ )
    {
        currentlootid = getlootidatbackpackindex( i );
        
        if ( currentlootid == lootid )
        {
            if ( drop )
            {
                return i;
            }
            
            currentquantity = getquantityatbackpackindex( i );
            
            if ( currentquantity < maxcount )
            {
                return i;
            }
        }
    }
}

// Namespace br_default_inventory
// Params 1
// Checksum 0xade79566, Offset: 0x1dd3
// Size: 0x2a
function getlootidatbackpackindex( index )
{
    return self getplayerdata( level.var_6f9b00680ed002d8, level.backpackdata, index, "lootID" );
}

// Namespace br_default_inventory
// Params 1
// Checksum 0x93aab981, Offset: 0x1e06
// Size: 0x2a
function getquantityatbackpackindex( index )
{
    return self getplayerdata( level.var_6f9b00680ed002d8, level.backpackdata, index, "quantity" );
}

// Namespace br_default_inventory
// Params 1
// Checksum 0x83baad56, Offset: 0x1e39
// Size: 0x2a
function function_41e5f27c84ad38e9( index )
{
    return self getplayerdata( level.var_6f9b00680ed002d8, level.backpackdata, index, "lootedQuantity" );
}

// Namespace br_default_inventory
// Params 0
// Checksum 0xf9d29c2c, Offset: 0x1e6c
// Size: 0x3e
function getavailabledmzbackpackindex()
{
    for ( i = 0; i < getplayerbackpacksize( self ) ; i++ )
    {
        currentlootid = getlootidatbackpackindex( i );
        
        if ( currentlootid == 0 )
        {
            return i;
        }
    }
}

// Namespace br_default_inventory
// Params 1
// Checksum 0xfbb3ed2a, Offset: 0x1eb3
// Size: 0x47, Type: bool
function function_9ccb694d6c161351( lootid )
{
    scriptable = loot::getScriptableFromLootID( lootid );
    return isdefined( scriptable ) && level.br_pickups.br_itemtype[ scriptable ] == #"weaponcase";
}

// Namespace br_default_inventory
// Params 1
// Checksum 0x982b5e0a, Offset: 0x1f03
// Size: 0x28, Type: bool
function function_9d250a96d122e7a6( lootid )
{
    scriptable = loot::getScriptableFromLootID( lootid );
    return scriptable == "brloot_radioactive_charge";
}

// Namespace br_default_inventory
// Params 1
// Checksum 0x1c06700c, Offset: 0x1f34
// Size: 0x28, Type: bool
function function_5b4694471e56a8ef( lootid )
{
    scriptable = loot::getScriptableFromLootID( lootid );
    return scriptable == "brloot_volatile_decoy_grenade";
}

// Namespace br_default_inventory
// Params 1
// Checksum 0x770c3a22, Offset: 0x1f65
// Size: 0x12, Type: bool
function function_d1bdfe41ee9800f9( lootid )
{
    return lootid == 8525;
}

// Namespace br_default_inventory
// Params 3
// Checksum 0xf672a903, Offset: 0x1f80
// Size: 0x3b
function function_b0def2fa7869b25b( ref, type, quantity )
{
    lootid = loot::getlootidfromref( ref );
    return function_56e5a2e9514cd067( lootid, quantity );
}

// Namespace br_default_inventory
// Params 2
// Checksum 0xa9c99a49, Offset: 0x1fc4
// Size: 0x77
function function_56e5a2e9514cd067( lootid, quantity )
{
    assert( isdefined( lootid ) && isdefined( quantity ), "<dev string:x10c>" );
    
    if ( !( isdefined( lootid ) && isdefined( quantity ) ) )
    {
        return;
    }
    
    lootname = loot::getScriptableFromLootID( lootid );
    
    if ( !function_2fb5a15297b837d7( lootname ) )
    {
        return 0;
    }
    
    if ( br_pickups::function_bcc6dc9b2b7365e0( lootid ) )
    {
        return isdefined( getavailabledmzbackpackindex() );
    }
    
    return canitemfitinbackpack( lootid, quantity );
}

// Namespace br_default_inventory
// Params 1
// Checksum 0x1e993ce6, Offset: 0x2044
// Size: 0x73
function gettotalitemcountinbag( lootid )
{
    if ( !isdefined( lootid ) )
    {
        return 0;
    }
    
    backpacksize = getplayerbackpacksize( self );
    total = 0;
    
    for ( i = 0; i < backpacksize ; i++ )
    {
        slotlootid = getlootidatbackpackindex( i );
        
        if ( slotlootid == lootid )
        {
            total += getquantityatbackpackindex( i );
        }
    }
    
    return total;
}

// Namespace br_default_inventory
// Params 1
// Checksum 0x42741be7, Offset: 0x20c0
// Size: 0x62
function function_8ca9685ec86d37c1( var_8350fab4dc131852 )
{
    matchingitems = [];
    
    if ( isdefined( var_8350fab4dc131852 ) )
    {
        for ( i = 0; i < getplayerbackpacksize( self ) ; i++ )
        {
            slotlootid = getlootidatbackpackindex( i );
            
            if ( arraycontains( var_8350fab4dc131852, slotlootid ) )
            {
                matchingitems[ matchingitems.size ] = i;
            }
        }
    }
    
    return matchingitems;
}

// Namespace br_default_inventory
// Params 0
// Checksum 0xd9477be3, Offset: 0x212b
// Size: 0x76
function function_6cf02ae6b5f10a23()
{
    matchingitems = [];
    
    for ( i = 0; i < getplayerbackpacksize( self ) ; i++ )
    {
        slotlootid = getlootidatbackpackindex( i );
        ref = loot::function_f54ecb89dfab8e8c( slotlootid );
        
        if ( arraycontains( level.br_pickups.br_killstreakreference, ref ) )
        {
            matchingitems[ matchingitems.size ] = i;
        }
    }
    
    return matchingitems;
}

// Namespace br_default_inventory
// Params 5
// Checksum 0x13220120, Offset: 0x21aa
// Size: 0x50
function function_1df0c39d75e5fbc5( index, lootid, maxcount, pickupquantity, slotquantity )
{
    leftover = slotquantity + pickupquantity - maxcount;
    thread function_d625d28b11a26654( self, index, maxcount );
    return leftover;
}

// Namespace br_default_inventory
// Params 2, eflags: 0x4
// Checksum 0xd9fdb147, Offset: 0x2203
// Size: 0x1d7
function private setbackpackitem( lootid, pickup )
{
    if ( utility::issharedfuncdefined( #"gametype", #"setbackpackitem" ) )
    {
        result = utility::callsharedfunc( #"gametype", #"setbackpackitem", lootid, pickup );
        
        if ( result >= 0 )
        {
            return result;
        }
    }
    
    quantity = pickup.count;
    maxcount = level.br_pickups.var_3444316dc55e4b0a[ pickup.scriptablename ];
    
    if ( !isdefined( maxcount ) || maxcount == 0 )
    {
        maxcount = level.br_pickups.maxcounts[ pickup.scriptablename ];
    }
    
    ref = loot::function_f54ecb89dfab8e8c( lootid );
    
    if ( br_pickups::function_34f22d7446d00286( ref ) )
    {
        for ( i = 0; i < getplayerbackpacksize( self ) ; i++ )
        {
            currentlootid = getlootidatbackpackindex( i );
            
            if ( currentlootid == lootid )
            {
                slotquantity = getquantityatbackpackindex( i );
                
                if ( slotquantity + quantity <= maxcount )
                {
                    function_d85bb3c0fe7a50a4( self, i, lootid, slotquantity + quantity );
                    return 0;
                }
                else
                {
                    quantity = function_1df0c39d75e5fbc5( i, lootid, maxcount, quantity, slotquantity );
                }
            }
            
            if ( !isdefined( quantity ) )
            {
                quantity = 0;
            }
            
            if ( quantity <= 0 )
            {
                return 0;
            }
        }
    }
    
    for ( i = 0; i < getplayerbackpacksize( self ) ; i++ )
    {
        currentlootid = getlootidatbackpackindex( i );
        
        if ( currentlootid == 0 && currentlootid != lootid )
        {
            if ( quantity <= maxcount )
            {
                function_d85bb3c0fe7a50a4( self, i, lootid, quantity );
                return 0;
            }
            else
            {
                function_d85bb3c0fe7a50a4( self, i, lootid, maxcount );
                quantity -= maxcount;
            }
        }
        
        if ( quantity <= 0 )
        {
            return 0;
        }
    }
    
    return quantity;
}

// Namespace br_default_inventory
// Params 3
// Checksum 0xbaef53a8, Offset: 0x23e3
// Size: 0x6b
function additemtobackpackbyref( ref, type, quantity )
{
    lootid = loot::getlootidfromref( ref );
    fakepickup = spawnstruct();
    fakepickup.scriptablename = loot::getScriptableFromLootID( lootid );
    fakepickup.count = quantity;
    return additemtobackpack( lootid, fakepickup );
}

// Namespace br_default_inventory
// Params 5
// Checksum 0xf54b3db2, Offset: 0x2457
// Size: 0x626
function additemtobackpack( lootid, pickup, dontdropleftover, var_14b1046a6c91dad9, fromkiosk )
{
    assert( isdefined( lootid ) || isdefined( pickup ), "<dev string:x15f>" );
    
    if ( !( isdefined( lootid ) && isdefined( pickup ) ) )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( lootid, #"pickedUp" ) )
    {
        result = utility::callsharedfunc( lootid, #"pickedUp", pickup.instance, self );
        
        if ( isdefined( result ) )
        {
            return;
        }
    }
    
    if ( br_pickups::function_bcc6dc9b2b7365e0( lootid, pickup.scriptablename ) )
    {
        index = getavailabledmzbackpackindex();
        
        if ( !isdefined( index ) )
        {
            return 0;
        }
        
        function_6ed807ce42209fe5( lootid );
        thread function_d85bb3c0fe7a50a4( self, index, lootid, pickup.count, undefined, 1 );
        return 0;
    }
    else if ( br_pickups::function_e44a0803d593564( undefined, pickup.scriptablename ) )
    {
        index = getavailabledmzbackpackindex();
        
        if ( !isdefined( index ) )
        {
            return 0;
        }
        
        br_gametype_truckwar::function_337995b87b58fe3c();
    }
    else if ( br_pickups::function_1578d9983da7761a( pickup.scriptablename ) )
    {
        index = getavailabledmzbackpackindex();
        
        if ( !isdefined( index ) )
        {
            return 0;
        }
        
        br_elite_broken_arrow::function_5a5d9ae50671e96a( self, pickup, index );
    }
    
    talking_gun::function_e043166fb3a22498( self );
    
    if ( br_public::isammo( pickup.scriptablename ) )
    {
        if ( self.br_ammo[ pickup.scriptablename ] < level.var_9a6a4b42eba220f6[ pickup.scriptablename ] )
        {
            ammomissing = level.var_9a6a4b42eba220f6[ pickup.scriptablename ] - self.br_ammo[ pickup.scriptablename ];
            var_8bb1b2bde27b267c = int( min( ammomissing, pickup.count ) );
            
            if ( pickup.isautouse && br_pickups::function_b82b55355bb1c31f( pickup.scriptablename ) )
            {
                quantity = pickup.count - var_8bb1b2bde27b267c;
                dropstruct = pickups::function_f71dd588dc4f6288();
                
                if ( isdefined( var_14b1046a6c91dad9 ) )
                {
                    dropstruct.count = var_14b1046a6c91dad9;
                }
                
                dropinfo = pickups::getitemdroporiginandangles( dropstruct, self.origin, self.angles, self, undefined, pickup.overridedist, undefined, undefined, pickup.origin );
                item = br_pickups::spawnpickup( pickup.scriptablename, dropinfo, quantity, 1, undefined, 0 );
                return 0;
            }
            else
            {
                br_weapons::br_ammo_give_type( self, pickup.scriptablename, var_8bb1b2bde27b267c );
                pickup.count -= var_8bb1b2bde27b267c;
            }
        }
        else if ( pickup.isautouse && br_pickups::function_b82b55355bb1c31f( pickup.scriptablename ) && !getdvarint( @"hash_b5db5ff4b3f9e052", 0 ) && getdvarint( @"hash_d116b9023292a13e", 1 ) )
        {
            [ index, quantity ] = function_6aa57f97cc4e33f3( pickup.scriptablename );
            maxstack = function_fa36808768ac232( pickup.scriptablename );
            
            if ( quantity >= 0 && quantity + pickup.count > maxstack )
            {
                var_42698d12fe8d2dd9 = pickup.count;
                pickup.count = maxstack - quantity;
                var_42698d12fe8d2dd9 -= pickup.count;
                dropstruct = pickups::function_f71dd588dc4f6288();
                
                if ( isdefined( var_14b1046a6c91dad9 ) )
                {
                    dropstruct.count = var_14b1046a6c91dad9;
                }
                
                dropinfo = pickups::getitemdroporiginandangles( dropstruct, self.origin, self.angles, self, undefined, pickup.overridedist, undefined, undefined, pickup.origin );
                item = br_pickups::spawnpickup( pickup.scriptablename, dropinfo, var_42698d12fe8d2dd9, 1, undefined, 0 );
            }
        }
    }
    
    quantity = setbackpackitem( lootid, pickup );
    
    if ( lootid == armor::function_5bc2f16f9885ef8c() )
    {
        var_22a509995e00c122 = armor::function_d3aa416001bf116c();
        var_3e4a8206d50c9e34 = armor::function_22290101992e4874();
        br_public::updatebrscoreboardstat( "armorPlateCount", var_3e4a8206d50c9e34 + var_22a509995e00c122 );
        
        if ( getdvarint( @"hash_47b9da0c2a37475b", 0 ) )
        {
            self setclientomnvar( "ui_equipment_id_health_numStowed", var_22a509995e00c122 );
        }
    }
    
    if ( quantity > 0 )
    {
        if ( !dontdropleftover )
        {
            baseorigin = self.origin;
            baseangles = self.angles;
            dropstruct = pickups::function_f71dd588dc4f6288();
            overridedist = pickup.overridedist;
            overrideorigin = pickup.origin;
            
            if ( fromkiosk && isdefined( self.br_kiosk ) && isdefined( self.br_kiosk.dropstruct ) )
            {
                slotindex = self.br_kiosk br_pickups::function_ef8a0f215f5f8b92();
                self.br_kiosk.dropstruct.dropidx = slotindex;
                dropstruct = self.br_kiosk.dropstruct;
                baseorigin = self.br_kiosk.centerbottom ?? self.br_kiosk.origin;
                baseangles = self.br_kiosk.angles;
                overrideorigin = undefined;
                overridedist = undefined;
            }
            else if ( isdefined( pickup.dropstruct ) )
            {
                dropstruct = pickup.dropstruct;
            }
            
            dropinfo = pickups::getitemdroporiginandangles( dropstruct, baseorigin, baseangles, self, undefined, overridedist, undefined, undefined, overrideorigin );
            item = br_pickups::spawnpickup( pickup.scriptablename, dropinfo, quantity, 1, undefined, 0 );
            
            if ( isdefined( pickup.dropstruct ) )
            {
                pickup.dropstruct = dropstruct;
            }
            
            return 0;
        }
        else
        {
            return quantity;
        }
    }
    
    return 0;
}

// Namespace br_default_inventory
// Params 3
// Checksum 0x75d083dc, Offset: 0x2a86
// Size: 0x103
function function_39f0833282ad6f6( index, var_4151769dbb2c435a, var_ba8037d764bafa3f )
{
    if ( !function_b7b8a2d7ac9eb88b() )
    {
        return 0;
    }
    
    [ lootid, _, _ ] = function_c022fc696a9c0db2( index );
    currentquantity = getquantityatbackpackindex( index );
    
    if ( !isdefined( var_4151769dbb2c435a ) )
    {
        var_4151769dbb2c435a = currentquantity;
    }
    
    newquantity = int( max( 0, currentquantity - var_4151769dbb2c435a ) );
    thread function_d625d28b11a26654( self, index, newquantity, var_ba8037d764bafa3f );
    function_2a16a700fa75db2c( lootid );
    
    if ( lootid == armor::function_5bc2f16f9885ef8c() )
    {
        var_22a509995e00c122 = armor::function_d3aa416001bf116c();
        var_3e4a8206d50c9e34 = armor::function_22290101992e4874();
        br_public::updatebrscoreboardstat( "armorPlateCount", var_3e4a8206d50c9e34 + var_22a509995e00c122 );
        
        if ( getdvarint( @"hash_47b9da0c2a37475b", 0 ) )
        {
            self setclientomnvar( "ui_equipment_id_health_numStowed", var_22a509995e00c122 );
        }
    }
    
    return lootid;
}

// Namespace br_default_inventory
// Params 1
// Checksum 0xfeceb748, Offset: 0x2b92
// Size: 0x32, Type: bool
function function_511e6d4f61a60220( lootid )
{
    if ( !function_b7b8a2d7ac9eb88b() )
    {
        return false;
    }
    
    index = function_58dd112b3bffe0d3( lootid, undefined, 1 );
    return isdefined( index );
}

// Namespace br_default_inventory
// Params 2
// Checksum 0x3ab48eab, Offset: 0x2bcd
// Size: 0x73
function function_f0398a1e115d3553( lootid, quantity )
{
    if ( !function_b7b8a2d7ac9eb88b() )
    {
        return 0;
    }
    
    itemtype = loot::function_52cf8374c44a4ff5( lootid );
    
    if ( itemtype == "weapon" )
    {
        function_f7c0ab39bb3170f( self );
        return;
    }
    
    index = function_58dd112b3bffe0d3( lootid, undefined, 1 );
    
    if ( !isdefined( index ) )
    {
        return 0;
    }
    
    function_39f0833282ad6f6( index, quantity );
    return 1;
}

// Namespace br_default_inventory
// Params 1
// Checksum 0xcc537dca, Offset: 0x2c49
// Size: 0x7b
function function_a1bcc9f2ad9eef33( scriptablename )
{
    if ( !function_b7b8a2d7ac9eb88b() )
    {
        return 0;
    }
    
    lootid = loot::function_d3e3bcaea591a6a2( scriptablename );
    removedcount = 0;
    
    for ( i = 0; i < getplayerbackpacksize( self ) ; i++ )
    {
        if ( getlootidatbackpackindex( i ) == lootid )
        {
            removedcount += getquantityatbackpackindex( i );
            function_39f0833282ad6f6( i );
        }
    }
    
    return removedcount;
}

// Namespace br_default_inventory
// Params 2
// Checksum 0xe17f3b6d, Offset: 0x2ccd
// Size: 0x13e
function removesmallestitemstackbackpack( scriptablename, amountremoved )
{
    lootid = loot::function_d3e3bcaea591a6a2( scriptablename );
    assert( isdefined( lootid ), "<dev string:x1a9>" );
    
    if ( !isdefined( lootid ) )
    {
        return;
    }
    
    var_b92cc403285a534f = [];
    
    for ( i = 0; i < getplayerbackpacksize( self ) ; i++ )
    {
        if ( getlootidatbackpackindex( i ) == lootid )
        {
            var_b92cc403285a534f[ i ] = getquantityatbackpackindex( i );
        }
    }
    
    if ( var_b92cc403285a534f.size <= 0 )
    {
        return amountremoved;
    }
    
    var_911da54fd3f991a6 = tablesort( var_b92cc403285a534f );
    
    foreach ( index in var_911da54fd3f991a6 )
    {
        slotquantity = getquantityatbackpackindex( index );
        
        if ( amountremoved <= slotquantity )
        {
            function_39f0833282ad6f6( index, amountremoved );
            return 0;
        }
        
        amountremoved -= slotquantity;
        function_39f0833282ad6f6( index, slotquantity );
    }
    
    return amountremoved;
}

// Namespace br_default_inventory
// Params 1
// Checksum 0xfaf4d066, Offset: 0x2e14
// Size: 0xc8
function function_6aa57f97cc4e33f3( scriptablename )
{
    if ( !isdefined( scriptablename ) )
    {
        return;
    }
    
    lootid = loot::function_d3e3bcaea591a6a2( scriptablename );
    backpacksize = getplayerbackpacksize( self );
    largeststack = -1;
    largestindex = undefined;
    
    for ( i = 0; i < backpacksize ; i++ )
    {
        [ tmplootid, quantity, _ ] = function_c022fc696a9c0db2( i );
        
        if ( lootid == tmplootid && quantity > largeststack )
        {
            largeststack = quantity;
            largestindex = i;
        }
    }
    
    return [ largestindex, largeststack ];
}

// Namespace br_default_inventory
// Params 1
// Checksum 0x8136e3ac, Offset: 0x2ee5
// Size: 0xb3, Type: bool
function function_8200c6fadac262d4( scriptablename )
{
    if ( !isdefined( scriptablename ) )
    {
        return false;
    }
    
    maxcount = function_fa36808768ac232( scriptablename );
    lootid = loot::function_d3e3bcaea591a6a2( scriptablename );
    backpacksize = getplayerbackpacksize( self );
    
    for ( i = 0; i < backpacksize ; i++ )
    {
        [ tmplootid, quantity, _ ] = function_c022fc696a9c0db2( i );
        
        if ( lootid == tmplootid && quantity >= maxcount )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_default_inventory
// Params 1
// Checksum 0x7ab0dd5d, Offset: 0x2fa1
// Size: 0x44
function function_fa36808768ac232( scriptablename )
{
    if ( !( isdefined( scriptablename ) && isdefined( level.br_pickups.var_3444316dc55e4b0a[ scriptablename ] ) ) )
    {
        return;
    }
    
    return level.br_pickups.var_3444316dc55e4b0a[ scriptablename ];
}

// Namespace br_default_inventory
// Params 1
// Checksum 0xc15dcb0e, Offset: 0x2fee
// Size: 0x44
function function_bb231745c730734d( scriptablename )
{
    if ( !( isdefined( scriptablename ) && isdefined( level.br_pickups.var_33a79b2c287b7771[ scriptablename ] ) ) )
    {
        return;
    }
    
    return level.br_pickups.var_33a79b2c287b7771[ scriptablename ];
}

// Namespace br_default_inventory
// Params 1
// Checksum 0xa9cb1a62, Offset: 0x303b
// Size: 0xbe
function function_1c4df4a60ee9b86a( lootid )
{
    currentquantity = 0;
    index = function_c167a667afff77a0( lootid );
    
    if ( !isdefined( index ) )
    {
        return currentquantity;
    }
    
    backpacksize = getplayerbackpacksize( self );
    
    for ( i = index; i < backpacksize ; i++ )
    {
        [ tmplootid, _, _ ] = function_c022fc696a9c0db2( i );
        
        if ( lootid == tmplootid )
        {
            if ( br_pickups::function_bcc6dc9b2b7365e0( lootid ) )
            {
                currentquantity += 1;
                continue;
            }
            
            currentquantity = getquantityatbackpackindex( i ) + currentquantity;
        }
    }
    
    return currentquantity;
}

// Namespace br_default_inventory
// Params 1
// Checksum 0xb567379, Offset: 0x3102
// Size: 0xeb
function function_f901b681f79c70b9( lootid )
{
    index = function_c167a667afff77a0( lootid );
    
    if ( !isdefined( index ) )
    {
        return 0;
    }
    
    if ( !isdefined( self.team ) )
    {
        return function_1c4df4a60ee9b86a( index );
    }
    
    teamplayers = teams::getteamdata( self.team, "players" );
    teamquantity = 0;
    
    foreach ( player in teamplayers )
    {
        playerquantity = player function_1c4df4a60ee9b86a( lootid );
        teamquantity += playerquantity;
    }
    
    return teamquantity;
}

// Namespace br_default_inventory
// Params 1
// Checksum 0xbe0902bf, Offset: 0x31f6
// Size: 0x116
function function_6ed807ce42209fe5( lootid )
{
    if ( !isdefined( lootid ) )
    {
        return;
    }
    
    type = loot::function_52cf8374c44a4ff5( lootid );
    ref = loot::function_f54ecb89dfab8e8c( lootid );
    
    switch ( type )
    {
        case #"hash_1cac65e1b8bf24a7":
        case #"hash_27124c6c97ccffa1":
        case #"hash_325cb2e66f67d5b9":
        case #"hash_339227cb650975db":
        case #"hash_511d3c24fcedcdb1":
        case #"hash_850999d7864fa3b4":
        case #"hash_93c71e7b6c0b81d7":
        case #"hash_ab671284a3fc4e3d":
        case #"hash_b60679835e82a584":
        case #"hash_e534fd8ec73eafb4":
            return;
        case #"hash_7d516d84d0a82f2":
            if ( isdefined( level.var_621f7bbf74943efa ) && isdefined( level.var_621f7bbf74943efa[ "onPickup" ] ) && isdefined( level.var_621f7bbf74943efa[ "onPickup" ][ ref ] ) )
            {
                [[ level.var_621f7bbf74943efa[ "onPickup" ][ ref ] ]]( self );
            }
            
            return;
    }
}

// Namespace br_default_inventory
// Params 1
// Checksum 0x46ae761f, Offset: 0x3315
// Size: 0x12a
function function_2a16a700fa75db2c( lootid )
{
    if ( !isdefined( lootid ) )
    {
        return;
    }
    
    type = loot::function_52cf8374c44a4ff5( lootid );
    
    if ( !isdefined( type ) )
    {
        return;
    }
    
    ref = loot::function_f54ecb89dfab8e8c( lootid );
    
    switch ( type )
    {
        case #"hash_ff2e175bfcc4f32":
        case #"hash_1cac65e1b8bf24a7":
        case #"hash_27124c6c97ccffa1":
        case #"hash_325cb2e66f67d5b9":
        case #"hash_339227cb650975db":
        case #"hash_511d3c24fcedcdb1":
        case #"hash_850999d7864fa3b4":
        case #"hash_93c71e7b6c0b81d7":
        case #"hash_ab671284a3fc4e3d":
        case #"hash_b60679835e82a584":
        case #"hash_e534fd8ec73eafb4":
            return;
        case #"hash_7d516d84d0a82f2":
            if ( isdefined( level.var_621f7bbf74943efa ) && isdefined( level.var_621f7bbf74943efa[ "onDrop" ] ) && isdefined( level.var_621f7bbf74943efa[ "onDrop" ][ ref ] ) )
            {
                [[ level.var_621f7bbf74943efa[ "onDrop" ][ ref ] ]]( self );
            }
            
            return;
    }
}

// Namespace br_default_inventory
// Params 1
// Checksum 0x23150a25, Offset: 0x3448
// Size: 0x15, Type: bool
function function_46da5d3784eb9b40( lootid )
{
    return isdefined( function_c167a667afff77a0( lootid ) );
}

// Namespace br_default_inventory
// Params 1
// Checksum 0xb8ece7a3, Offset: 0x3466
// Size: 0x1b
function function_1923cc02d05e07c5( oldequipment )
{
    return arraycontains( level.var_77acd6c239c79918, oldequipment );
}

// Namespace br_default_inventory
// Params 3
// Checksum 0xae5bcc13, Offset: 0x348a
// Size: 0x208, Type: bool
function function_c9881d78b87650af( player, slot, oldequipment )
{
    if ( !( isdefined( player ) && isdefined( slot ) ) )
    {
        return false;
    }
    
    if ( function_1923cc02d05e07c5( oldequipment ) )
    {
        return false;
    }
    
    if ( getdvarint( @"hash_ced962345ff6ecd0", 0 ) )
    {
        return false;
    }
    
    var_b42870ef959951f8 = undefined;
    var_3a750069e1abea5 = "";
    var_ee98adae537b0397 = 0;
    var_98d9c7223174251f = 0;
    
    for ( packitemindex = 0; packitemindex < getplayerbackpacksize( player ) ; packitemindex++ )
    {
        quantity = player getquantityatbackpackindex( packitemindex );
        lootid = player getlootidatbackpackindex( packitemindex );
        
        if ( quantity > 0 && lootid > 0 )
        {
            type = loot::function_52cf8374c44a4ff5( lootid );
            assert( isdefined( type ), "<dev string:x1df>" + lootid + "<dev string:x1e8>" );
            
            if ( type == "equipment" )
            {
                itemref = loot::function_f54ecb89dfab8e8c( lootid );
                
                if ( itemref == oldequipment )
                {
                    var_b42870ef959951f8 = packitemindex;
                    var_3a750069e1abea5 = itemref;
                    var_ee98adae537b0397 = quantity;
                    var_98d9c7223174251f = lootid;
                    break;
                }
                
                if ( !isdefined( var_b42870ef959951f8 ) )
                {
                    itemslot = equipment_mp::getdefaultslot( itemref );
                    
                    if ( itemslot == slot )
                    {
                        var_b42870ef959951f8 = packitemindex;
                        var_3a750069e1abea5 = itemref;
                        var_ee98adae537b0397 = quantity;
                        var_98d9c7223174251f = lootid;
                    }
                }
            }
        }
    }
    
    if ( isdefined( var_b42870ef959951f8 ) )
    {
        player equipment_mp::giveequipment( var_3a750069e1abea5, slot );
        player equipment_mp::setequipmentammo( var_3a750069e1abea5, var_ee98adae537b0397 );
        
        if ( var_3a750069e1abea5 == "equip_hb_sensor" )
        {
            hb_sensor_equipment::function_567ca388ed18e28c( var_ee98adae537b0397 );
            function_39f0833282ad6f6( var_b42870ef959951f8 );
        }
        else
        {
            equipmax = player equipment_mp::getequipmentmaxammo( var_3a750069e1abea5 );
            newamount = min( equipmax, var_ee98adae537b0397 );
            oldamount = getquantityatbackpackindex( var_b42870ef959951f8 );
            player function_6f2fadfc318b9264( var_b42870ef959951f8, -1 * newamount );
            br_instance_inventory::function_b1116f6c1b474c9c( player, slot, var_98d9c7223174251f );
        }
        
        player setclientomnvar( "ui_notify_show_minimal_hud", gettime() );
        return true;
    }
    
    return false;
}

// Namespace br_default_inventory
// Params 2
// Checksum 0xe3b06eba, Offset: 0x369b
// Size: 0x150
function function_d06e80af607e8338( victim, dropstruct )
{
    backpackcontents = [];
    hasweaponcase = 0;
    
    for ( packitemindex = 0; packitemindex < getplayerbackpacksize( victim ) ; packitemindex++ )
    {
        quantity = victim getquantityatbackpackindex( packitemindex );
        lootid = victim getlootidatbackpackindex( packitemindex );
        
        if ( quantity > 0 && lootid > 0 )
        {
            if ( function_d1bdfe41ee9800f9( lootid ) )
            {
                victim br_strongholds::function_30128ad2ab80b07d( dropstruct, victim.blacksite );
                continue;
            }
            
            if ( isdefined( br_elite_broken_arrow::function_a246dc01c1d8e60e( lootid, 5 ) ) )
            {
                victim br_pickups::function_14e6129340c2ff2d( dropstruct, packitemindex, lootid );
                continue;
            }
            
            backpackcontents[ packitemindex ] = [];
            backpackcontents[ packitemindex ][ "lootID" ] = lootid;
            backpackcontents[ packitemindex ][ "quantity" ] = quantity;
        }
    }
    
    dogtag = undefined;
    
    if ( getdvarint( @"hash_6d0beef651f58a69", 0 ) )
    {
        victim br_pickups::dropdogtag( dropstruct );
    }
    else if ( dmz_dog_tag::hasdogtag( victim ) )
    {
        dmz_dog_tag::function_ff4a0e3c9d3674dc( victim, 0 );
        dogtag = [];
        dogtag[ "lootID" ] = dmz_dog_tag::function_d19864f8c32f315f( victim );
        dogtag[ "quantity" ] = 1;
    }
    
    return [ backpackcontents, hasweaponcase, dogtag ];
}

// Namespace br_default_inventory
// Params 2
// Checksum 0x836b6dd5, Offset: 0x37f4
// Size: 0x2ce
function function_74094436399c71fe( victim, dogtag )
{
    loadoutitems = victim function_af60747a2da55b77( 1, 1 );
    loadoutcontents = [];
    index = 0;
    firstweapon = 1;
    weaponslotcontents = undefined;
    weaponslotobj = undefined;
    var_f7cb5f756a346f4a = undefined;
    weapondropindex = undefined;
    
    if ( isdefined( loadoutitems ) )
    {
        foreach ( indextype, itemtype in loadoutitems )
        {
            if ( !itemtype.size )
            {
                loadoutcontents[ index ] = [];
                loadoutcontents[ index ][ "lootID" ] = 0;
                loadoutcontents[ index ][ "quantity" ] = 0;
                index++;
                continue;
            }
            
            foreach ( slotindex, slot in itemtype )
            {
                if ( !isdefined( slot ) && indextype != 1 )
                {
                    loadoutcontents[ index ] = [];
                    loadoutcontents[ index ][ "lootID" ] = 0;
                    loadoutcontents[ index ][ "quantity" ] = 0;
                    index++;
                    continue;
                }
                
                lootid = slot[ 0 ];
                quantity = slot[ 1 ];
                
                if ( !( isdefined( lootid ) && isdefined( quantity ) ) )
                {
                    continue;
                }
                
                if ( indextype == 1 )
                {
                    if ( itemtype.size > 1 )
                    {
                        if ( !firstweapon )
                        {
                            weaponslotcontents = lootid;
                            weaponslotobj = slot[ 2 ];
                        }
                        else
                        {
                            var_f7cb5f756a346f4a = slot[ 2 ];
                            weapondropindex = slotindex;
                        }
                        
                        firstweapon = 0;
                    }
                    
                    continue;
                }
                
                loadoutcontents[ index ] = [];
                loadoutcontents[ index ][ "lootID" ] = lootid;
                loadoutcontents[ index ][ "quantity" ] = quantity;
                index++;
            }
        }
    }
    
    if ( isdefined( dogtag ) )
    {
        loadoutcontents[ 8 ] = [];
        loadoutcontents[ 8 ][ "lootID" ] = dogtag[ "lootID" ];
        loadoutcontents[ 8 ][ "quantity" ] = dogtag[ "quantity" ];
        index++;
    }
    
    if ( isdefined( victim.var_c76f30f749911ef ) )
    {
        loadoutcontents[ 9 ] = [];
        loadoutcontents[ 9 ][ "lootID" ] = victim.backpackid;
        loadoutcontents[ 9 ][ "quantity" ] = 1;
        index++;
    }
    
    var_d80f548b9b26d1fb = undefined;
    return [ loadoutcontents, weaponslotobj, weaponslotcontents, var_d80f548b9b26d1fb, var_f7cb5f756a346f4a, weapondropindex ];
}

// Namespace br_default_inventory
// Params 2
// Checksum 0x3deeef4, Offset: 0x3acb
// Size: 0x693
function function_966bd6b9b374c712( victim, dropstruct )
{
    if ( victim.extracted )
    {
        return;
    }
    
    [ backpackcontents, hasweaponcase, dogtag ] = function_d06e80af607e8338( victim, dropstruct );
    [ loadoutcontents, var_9185433e2ad9ec33, var_38135a805694e23b, var_d770d062d2277817, var_f7cb5f756a346f4a, weapondropindex ] = function_74094436399c71fe( victim, dogtag );
    
    if ( backpackcontents.size > 0 || loadoutcontents.size > 0 )
    {
        if ( level.uselootablecorpse && game_utility_mp::isteamreviveenabled() && !getdvarint( @"scr_test_backpack", 0 ) )
        {
            weaponslotcontents = undefined;
            weaponslotobj = undefined;
            weaponslotclip = undefined;
            var_655fababc6344d9f = undefined;
            var_d80f548b9b26d1fb = undefined;
            var_e595072846ee89cd = undefined;
            var_57e4f32ca2ab5da8 = undefined;
            
            if ( function_787d2ebb0cc2e86f( victim ) )
            {
                weaponslotcontents = function_2a1febd848e9d620( victim );
                weaponslotobj = function_3b4976a12ea5037b( victim );
                weaponslotclip = victim.weaponslotclip ?? weaponclipsize( weaponslotobj );
                
                if ( weapon::isakimbo( weaponslotobj ) )
                {
                    var_57e4f32ca2ab5da8 = victim.var_ee5ceae7ad99228 ?? weaponclipsize( weaponslotobj );
                }
                
                if ( br_instance_inventory::function_926a8f8643d34690() )
                {
                    var_e595072846ee89cd = br_instance_inventory::function_6a05cf5689058e1f( self, 2 );
                }
                
                if ( weaponslotobj.hasalternate )
                {
                    weaponalt = weaponslotobj getaltweapon();
                    var_655fababc6344d9f = victim.var_655fababc6344d9f ?? weaponclipsize( weaponalt );
                }
            }
            
            var_280e5815dca53303 = undefined;
            
            if ( br_instance_inventory::function_926a8f8643d34690() && isdefined( var_9185433e2ad9ec33 ) && isdefined( var_38135a805694e23b ) )
            {
                var_280e5815dca53303 = br_instance_inventory::function_6a05cf5689058e1f( self, 1 );
            }
            
            br_teamrevive::function_68530aaf19ab95f3( victim, backpackcontents, 6, undefined, weaponslotcontents, weaponslotobj, weaponslotclip, var_655fababc6344d9f, var_d80f548b9b26d1fb, hasweaponcase, loadoutcontents, var_38135a805694e23b, var_9185433e2ad9ec33, var_e595072846ee89cd, var_280e5815dca53303, var_d770d062d2277817, var_57e4f32ca2ab5da8 );
        }
        else
        {
            dropinfo = pickups::getitemdroporiginandangles( dropstruct, victim.origin, victim.angles, victim );
            teamindex = function_f02c63b99c9614c9( level.allteamnamelist, victim.team );
            squadindex = victim.sessionuimemberindex;
            
            if ( squadindex < 0 && isdefined( victim.var_64f4581741c21af7 ) )
            {
                squadindex = victim.var_64f4581741c21af7;
            }
            
            spawnedbackpack = victim br_pickups::spawnpickup( function_f01e74b7f0c54677( self.attached_bag ), dropinfo, 1, undefined, undefined, undefined, teamindex, squadindex );
            
            if ( isdefined( spawnedbackpack ) )
            {
                if ( level.var_eda7b39474060e6 )
                {
                    spawnedbackpack.criticalitem = 1;
                }
                else if ( game_utility::getgametype() == "resurgence" )
                {
                    thread function_e9b807a15a8c58e5( spawnedbackpack );
                }
                else
                {
                    thread function_22538cc7bbfaead5( spawnedbackpack );
                }
                
                spawnedbackpack.contents = backpackcontents;
                spawnedbackpack.loadoutcontents = loadoutcontents;
                
                if ( function_787d2ebb0cc2e86f( victim ) )
                {
                    spawnedbackpack.weaponslotcontents = function_2a1febd848e9d620( victim );
                    spawnedbackpack.weaponslotobj = function_3b4976a12ea5037b( victim );
                    spawnedbackpack.weaponslotclip = victim.weaponslotclip ?? weaponclipsize( spawnedbackpack.weaponslotobj );
                    
                    if ( br_instance_inventory::function_926a8f8643d34690() )
                    {
                        spawnedbackpack.metadata = br_instance_inventory::function_6a05cf5689058e1f( self, 2 );
                    }
                    
                    if ( spawnedbackpack.weaponslotobj.hasalternate )
                    {
                        weaponalt = spawnedbackpack.weaponslotobj getaltweapon();
                        spawnedbackpack.var_655fababc6344d9f = victim.var_655fababc6344d9f ?? weaponclipsize( weaponalt );
                    }
                    
                    if ( weapon::isakimbo( spawnedbackpack.weaponslotobj ) )
                    {
                        spawnedbackpack.var_ee5ceae7ad99228 = victim.var_ee5ceae7ad99228 ?? weaponclipsize( spawnedbackpack.weaponslotobj );
                    }
                }
                
                spawnedbackpack.containertype = 6;
                spawnedbackpack.owner = victim;
                spawnedbackpack.backpacksize = getplayerbackpacksize( victim );
                victim.var_a883ec236391a6bf = spawnedbackpack;
                
                if ( isdefined( var_9185433e2ad9ec33 ) && isdefined( var_38135a805694e23b ) )
                {
                    spawnedbackpack.var_64df982caf48609c = var_38135a805694e23b;
                    spawnedbackpack.var_9185433e2ad9ec33 = var_9185433e2ad9ec33;
                    spawnedbackpack.var_d770d062d2277817 = var_d770d062d2277817;
                    spawnedbackpack.var_83d5ec579c0923f0 = victim getweaponammoclip( var_9185433e2ad9ec33 );
                    spawnedbackpack.var_d5f1431744f9428c = victim getweaponammoclip( var_9185433e2ad9ec33, "left" );
                    
                    if ( br_instance_inventory::function_926a8f8643d34690() )
                    {
                        spawnedbackpack.loadoutmetadata = br_instance_inventory::function_6a05cf5689058e1f( self, 1 );
                    }
                }
                
                foreach ( item in spawnedbackpack.contents )
                {
                    utility::callsharedfunc( item[ "lootID" ], #"hash_9f56ee5ad640666b", spawnedbackpack, victim );
                }
            }
        }
    }
    
    if ( isdefined( victim.attached_bag ) && !level.uselootablecorpse )
    {
        victim backpack::detachbag();
    }
    
    if ( isdefined( var_f7cb5f756a346f4a ) && br_pickups::shoulddropbrprimary( var_f7cb5f756a346f4a, victim ) )
    {
        newweapondrop = br_pickups::dropbrweapon( var_f7cb5f756a346f4a, dropstruct );
        
        if ( isdefined( newweapondrop ) )
        {
            if ( level.var_eda7b39474060e6 )
            {
                newweapondrop.criticalitem = 1;
            }
            else
            {
                thread function_22538cc7bbfaead5( newweapondrop );
            }
            
            if ( isdefined( newweapondrop.var_48da44f99291b04a ) )
            {
                victim.var_37cd7f847541be2d = newweapondrop.var_48da44f99291b04a;
            }
            
            if ( isdefined( weapondropindex ) && br_instance_inventory::function_926a8f8643d34690() )
            {
                newweapondrop.metadata = br_instance_inventory::function_6a05cf5689058e1f( self, weapondropindex );
            }
            
            victim.var_1f118d02fac7e8eb = newweapondrop;
        }
    }
    
    if ( function_66b3b70a06d417( victim ) )
    {
        victim.var_4a8058894fecbe92 = backpackcontents;
    }
    
    if ( br_instance_inventory::function_926a8f8643d34690() )
    {
        br_instance_inventory::function_9ffc5abb3b50d97d( victim );
    }
}

// Namespace br_default_inventory
// Params 1
// Checksum 0x1c5c9007, Offset: 0x4166
// Size: 0x56
function function_22538cc7bbfaead5( item )
{
    item endon( #"death" );
    level endon( #"game_ended" );
    item.criticalitem = 1;
    wait getdvarint( @"hash_2b4f8183903e67ef", 180 );
    
    if ( !isdefined( item ) )
    {
        return;
    }
    
    item.criticalitem = undefined;
}

// Namespace br_default_inventory
// Params 2
// Checksum 0xb0cc8d6b, Offset: 0x41c4
// Size: 0x60b
function function_89372de057456bf3( victim, dropstruct )
{
    backpackcontents = [];
    var_d732d9fb3715dcb = 0;
    hasweaponcase = 0;
    
    for ( packitemindex = 0; packitemindex < getplayerbackpacksize( victim ) ; packitemindex++ )
    {
        quantity = victim getquantityatbackpackindex( packitemindex );
        lootid = victim getlootidatbackpackindex( packitemindex );
        
        if ( quantity > 0 && lootid > 0 )
        {
            if ( dmz_dog_tag::function_7b2fcbd8d8d2e2a3( lootid ) )
            {
                dropinfo = pickups::getitemdroporiginandangles( dropstruct, victim.origin, victim.angles, victim );
                scriptable = loot::getScriptableFromLootID( lootid );
                br_pickups::spawnpickup( scriptable, dropinfo, quantity, 0, undefined, 0 );
                continue;
            }
            
            if ( function_d1bdfe41ee9800f9( lootid ) )
            {
                victim br_strongholds::function_30128ad2ab80b07d( dropstruct, victim.blacksite );
                continue;
            }
            
            if ( isdefined( br_elite_broken_arrow::function_a246dc01c1d8e60e( lootid, 5 ) ) )
            {
                victim br_pickups::function_14e6129340c2ff2d( dropstruct, packitemindex, lootid );
                continue;
            }
            
            backpackcontents[ packitemindex ] = [];
            backpackcontents[ packitemindex ][ "lootID" ] = lootid;
            backpackcontents[ packitemindex ][ "quantity" ] = quantity;
            
            if ( function_9ccb694d6c161351( lootid ) )
            {
                hasweaponcase = 1;
            }
            
            var_d732d9fb3715dcb++;
        }
    }
    
    if ( level.var_29494481caeebcbc && level.var_45a89e982ebc0183 )
    {
        if ( function_787d2ebb0cc2e86f( victim ) )
        {
            var_d732d9fb3715dcb++;
        }
    }
    
    if ( dmz_dog_tag::hasdogtag( victim ) )
    {
        dogtagscriptable = dmz_dog_tag::function_a084b2fcf3307a37( victim );
        dropinfo = pickups::getitemdroporiginandangles( dropstruct, victim.origin, victim.angles, victim );
        spawneddogtag = br_pickups::spawnpickup( dogtagscriptable, dropinfo, 1, 0, undefined, 0 );
        
        if ( isdefined( spawneddogtag ) )
        {
            dmz_dog_tag::function_ff4a0e3c9d3674dc( victim, 0 );
            victim.dogtag = spawneddogtag;
            
            if ( isdefined( victim.var_d5e836adfb09a0ef ) )
            {
                victim.var_d5e836adfb09a0ef[ victim.var_d5e836adfb09a0ef.size ] = spawneddogtag;
            }
        }
        
        if ( isdefined( level.var_cd27949416787694 ) && isdefined( level.var_cd27949416787694.var_5b2415e555a89a01 ) )
        {
            [[ level.var_cd27949416787694.var_5b2415e555a89a01 ]]( victim );
        }
    }
    
    if ( var_d732d9fb3715dcb > 0 )
    {
        if ( level.uselootablecorpse && game_utility_mp::isteamreviveenabled() )
        {
            weaponslotcontents = undefined;
            weaponslotobj = undefined;
            weaponslotclip = undefined;
            var_655fababc6344d9f = undefined;
            var_d80f548b9b26d1fb = undefined;
            var_e595072846ee89cd = undefined;
            var_ee5ceae7ad99228 = undefined;
            
            if ( function_787d2ebb0cc2e86f( victim ) )
            {
                weaponslotcontents = function_2a1febd848e9d620( victim );
                weaponslotobj = function_3b4976a12ea5037b( victim );
                weaponslotclip = victim.weaponslotclip ?? weaponclipsize( weaponslotobj );
                
                if ( br_instance_inventory::function_926a8f8643d34690() )
                {
                    var_e595072846ee89cd = br_instance_inventory::function_6a05cf5689058e1f( self, 2 );
                }
                
                if ( weaponslotobj.hasalternate )
                {
                    weaponalt = weaponslotobj getaltweapon();
                    var_655fababc6344d9f = victim.var_655fababc6344d9f ?? weaponclipsize( weaponalt );
                }
                
                if ( weapon::isakimbo( weaponslotobj ) )
                {
                    var_ee5ceae7ad99228 = victim.var_ee5ceae7ad99228 ?? weaponclipsize( weaponslotobj );
                }
            }
            
            br_teamrevive::function_68530aaf19ab95f3( victim, backpackcontents, 6, undefined, weaponslotcontents, weaponslotobj, weaponslotclip, var_655fababc6344d9f, var_d80f548b9b26d1fb, hasweaponcase, undefined, undefined, undefined, var_e595072846ee89cd, undefined, undefined, var_ee5ceae7ad99228 );
        }
        else
        {
            dropinfo = pickups::getitemdroporiginandangles( dropstruct, victim.origin, victim.angles, victim );
            teamindex = function_f02c63b99c9614c9( level.allteamnamelist, victim.team );
            squadindex = victim.sessionuimemberindex;
            spawnedbackpack = br_pickups::spawnpickup( function_f01e74b7f0c54677( self.attached_bag ), dropinfo, 1, undefined, undefined, undefined, teamindex, squadindex );
            
            if ( isdefined( spawnedbackpack ) )
            {
                spawnedbackpack.contents = backpackcontents;
                
                if ( level.var_29494481caeebcbc && level.var_45a89e982ebc0183 )
                {
                    if ( function_787d2ebb0cc2e86f( victim ) )
                    {
                        spawnedbackpack.weaponslotcontents = function_2a1febd848e9d620( victim );
                        spawnedbackpack.weaponslotobj = function_3b4976a12ea5037b( victim );
                        spawnedbackpack.weaponslotclip = victim.weaponslotclip ?? weaponclipsize( spawnedbackpack.weaponslotobj );
                        
                        if ( br_instance_inventory::function_926a8f8643d34690() )
                        {
                            spawnedbackpack.metadata = br_instance_inventory::function_6a05cf5689058e1f( self, 2 );
                        }
                        
                        if ( spawnedbackpack.weaponslotobj.hasalternate )
                        {
                            weaponalt = spawnedbackpack.weaponslotobj getaltweapon();
                            spawnedbackpack.var_655fababc6344d9f = victim.var_655fababc6344d9f ?? weaponclipsize( weaponalt );
                        }
                        
                        if ( weapon::isakimbo( spawnedbackpack.weaponslotobj ) )
                        {
                            spawnedbackpack.var_ee5ceae7ad99228 = victim.var_ee5ceae7ad99228 ?? weaponclipsize( spawnedbackpack.weaponslotobj );
                        }
                    }
                }
                
                spawnedbackpack.containertype = 6;
                spawnedbackpack.owner = victim;
                victim.var_a883ec236391a6bf = spawnedbackpack;
                
                foreach ( item in spawnedbackpack.contents )
                {
                    utility::callsharedfunc( item[ "lootID" ], #"hash_9f56ee5ad640666b", spawnedbackpack, victim );
                }
            }
        }
    }
    
    if ( isdefined( victim.attached_bag ) && !level.uselootablecorpse )
    {
        victim backpack::detachbag();
    }
}

// Namespace br_default_inventory
// Params 2
// Checksum 0x1f6fcce1, Offset: 0x47d7
// Size: 0x311
function function_7ee02b5481912409( victim, dropstruct )
{
    victim.var_d5e836adfb09a0ef = victim function_af60747a2da55b77();
    
    if ( level.var_32411caa1b74d35c && isdefined( victim.var_d5e836adfb09a0ef ) )
    {
        bagmodel = victim.attached_bag;
        
        if ( !isdefined( bagmodel ) )
        {
            bagmodel = "brloot_backpack";
        }
        
        loadoutcontents = [];
        index = 0;
        firstweapon = 1;
        weaponslotcontents = undefined;
        weaponslotobj = undefined;
        
        foreach ( indextype, itemtype in victim.var_d5e836adfb09a0ef )
        {
            if ( !itemtype.size )
            {
                continue;
            }
            
            foreach ( slot in itemtype )
            {
                if ( !isdefined( slot ) )
                {
                    continue;
                }
                
                lootid = slot[ 0 ];
                quantity = slot[ 1 ];
                
                if ( !lootid || !quantity )
                {
                    continue;
                }
                
                if ( indextype == 1 )
                {
                    if ( itemtype.size > 1 )
                    {
                        if ( !firstweapon )
                        {
                            weaponslotcontents = lootid;
                            weaponslotobj = slot[ 2 ];
                        }
                        
                        firstweapon = 0;
                    }
                    
                    continue;
                }
                
                loadoutcontents[ index ] = [];
                loadoutcontents[ index ][ "lootID" ] = lootid;
                loadoutcontents[ index ][ "quantity" ] = quantity;
                index++;
            }
        }
        
        if ( loadoutcontents.size > 0 )
        {
            dropinfo = pickups::getitemdroporiginandangles( dropstruct, victim.origin, victim.angles, victim );
            teamindex = function_f02c63b99c9614c9( level.allteamnamelist, victim.team );
            squadindex = victim.sessionuimemberindex;
            loadoutbackpack = br_pickups::spawnpickup( function_f01e74b7f0c54677( bagmodel ), dropinfo, 1, undefined, undefined, undefined, teamindex, squadindex );
            
            if ( !isdefined( loadoutbackpack ) )
            {
                return;
            }
            
            if ( isdefined( weaponslotcontents ) && isdefined( weaponslotobj ) )
            {
                loadoutbackpack.weaponslotcontents = weaponslotcontents;
                loadoutbackpack.weaponslotobj = weaponslotobj;
                
                if ( br_instance_inventory::function_926a8f8643d34690() )
                {
                    loadoutbackpack.metadata = br_instance_inventory::function_6a05cf5689058e1f( self, 1 );
                }
            }
            
            loadoutbackpack.contents = loadoutcontents;
            loadoutbackpack.containertype = 6;
            loadoutbackpack.owner = victim;
            victim.var_7389c8904dba82f7 = loadoutbackpack;
        }
    }
}

// Namespace br_default_inventory
// Params 4
// Checksum 0x843ae872, Offset: 0x4af0
// Size: 0x136
function function_ec61d7588b044316( player, lootid, quantity, indexlength )
{
    dropstruct = pickups::function_f71dd588dc4f6288();
    dropinfo = pickups::getitemdroporiginandangles( dropstruct, player.origin, player.angles, player );
    teamindex = function_f02c63b99c9614c9( level.allteamnamelist, player.team );
    squadindex = player.sessionuimemberindex;
    spawnedbackpack = br_pickups::spawnpickup( function_f01e74b7f0c54677( self.attached_bag ), dropinfo, 1, undefined, undefined, undefined, teamindex, squadindex );
    
    if ( isdefined( spawnedbackpack ) )
    {
        backpackcontents = [];
        
        for ( var_f4d0d32878a4ec21 = 0; var_f4d0d32878a4ec21 < indexlength ; var_f4d0d32878a4ec21++ )
        {
            backpackcontents[ var_f4d0d32878a4ec21 ] = [];
            backpackcontents[ var_f4d0d32878a4ec21 ][ "lootID" ] = lootid;
            backpackcontents[ var_f4d0d32878a4ec21 ][ "quantity" ] = quantity;
        }
        
        spawnedbackpack.contents = backpackcontents;
        spawnedbackpack.containertype = 6;
        spawnedbackpack.owner = player;
    }
}

// Namespace br_default_inventory
// Params 1
// Checksum 0x3a26e5fc, Offset: 0x4c2e
// Size: 0x7b
function function_f01e74b7f0c54677( xmodelname )
{
    if ( isdefined( xmodelname ) )
    {
        switch ( xmodelname )
        {
            case #"hash_dca6f419e607e1f7":
                return "brloot_backpack_player_small";
            case #"hash_d9938108fa8eb85f":
                return "brloot_backpack_player_medium";
            case #"hash_e3731b91d944f82f":
                return "brloot_backpack_player_large";
            case #"hash_e6d61aa8716cb5e3":
                return "brloot_backpack_player_secure";
            case #"hash_1dc65c7b5858c244":
                return "brloot_backpack_player_scav";
        }
    }
    
    return "brloot_backpack";
}

// Namespace br_default_inventory
// Params 1
// Checksum 0xa54d6725, Offset: 0x4cb2
// Size: 0x11e
function function_269d933ef7b39d72( player )
{
    var_6d9ba0f7d86e7134 = function_677447af306a9120( player );
    
    if ( var_6d9ba0f7d86e7134 != 0 )
    {
        backpacktype = function_3e0bcfe5e9c5bd35( var_6d9ba0f7d86e7134 );
        
        switch ( backpacktype )
        {
            case 1:
                return "parts_backpack_inventory_medium";
            case 2:
                return "parts_backpack_inventory_large";
            case 3:
                return "dmz_backpack_secured";
            case 4:
                return "dmz_backpack_scavenger";
            default:
                return "parts_backpack_inventory_small";
        }
        
        return "parts_backpack_inventory_small";
    }
    
    size = getplayerbackpacksize( player );
    
    switch ( size )
    {
        case 5:
            return "parts_backpack_inventory_small";
        case 7:
            return "parts_backpack_inventory_medium";
        case 9:
            return "parts_backpack_inventory_large";
        case 11:
            return "dmz_backpack_scavenger";
        default:
            return "parts_backpack_inventory_small";
    }
    
    return "parts_backpack_inventory_small";
}

// Namespace br_default_inventory
// Params 1
// Checksum 0xc74ee7d9, Offset: 0x4dd9
// Size: 0x6d
function function_52727e682b6bb2d3( lootname )
{
    if ( !isdefined( lootname ) )
    {
        return 5;
    }
    
    switch ( lootname )
    {
        case #"hash_75ca97f27fab119c":
            return 7;
        case #"hash_5cdbaa0bf3e5ebfe":
            return 9;
        case #"hash_7e7616dbf5a436f2":
            return 5;
        case #"hash_c2b5d7ec929a9d4a":
            return 11;
        default:
            break;
    }
    
    return 5;
}

// Namespace br_default_inventory
// Params 1
// Checksum 0x51124b03, Offset: 0x4e4f
// Size: 0x68
function function_4360250f13201aee( size )
{
    if ( isdefined( size ) )
    {
        switch ( size )
        {
            case 5:
                return;
            case 7:
                return loot::function_d3e3bcaea591a6a2( "brloot_backpack_medium" );
            case 9:
                return loot::function_d3e3bcaea591a6a2( "brloot_backpack_large" );
            default:
                break;
        }
    }
}

// Namespace br_default_inventory
// Params 1
// Checksum 0x177f37a3, Offset: 0x4ec0
// Size: 0x87
function function_3e0bcfe5e9c5bd35( lootid )
{
    if ( !isdefined( lootid ) )
    {
        return 0;
    }
    
    scriptablename = loot::getScriptableFromLootID( lootid );
    
    if ( !isdefined( scriptablename ) )
    {
        return 0;
    }
    
    switch ( scriptablename )
    {
        case #"hash_75ca97f27fab119c":
            return 1;
        case #"hash_5cdbaa0bf3e5ebfe":
            return 2;
        case #"hash_7e7616dbf5a436f2":
            return 3;
        case #"hash_c2b5d7ec929a9d4a":
            return 4;
        default:
            return 0;
    }
    
    return 0;
}

// Namespace br_default_inventory
// Params 1
// Checksum 0xc553d0a5, Offset: 0x4f50
// Size: 0x4d
function function_66b3b70a06d417( player )
{
    if ( player.extracted )
    {
        return function_4a6fe0e5b26a561d( player );
    }
    
    return ( function_4a6fe0e5b26a561d( player ) || player.var_43af94eb90e19dfa ) && getdvarint( @"hash_ff574f42cbb4f9f7", 1 );
}

// Namespace br_default_inventory
// Params 1
// Checksum 0xb1415a57, Offset: 0x4fa6
// Size: 0x4b, Type: bool
function function_4a6fe0e5b26a561d( player )
{
    var_6d9ba0f7d86e7134 = function_677447af306a9120( player );
    
    if ( var_6d9ba0f7d86e7134 == 0 )
    {
        return false;
    }
    
    securelootid = loot::function_d3e3bcaea591a6a2( "brloot_backpack_secure" );
    
    if ( !isdefined( securelootid ) )
    {
        return false;
    }
    
    return var_6d9ba0f7d86e7134 == securelootid;
}

// Namespace br_default_inventory
// Params 1
// Checksum 0xa44c5b17, Offset: 0x4ffa
// Size: 0x29
function function_677447af306a9120( player )
{
    if ( !isdefined( player.backpackid ) )
    {
        return 0;
    }
    
    return player.backpackid;
}

// Namespace br_default_inventory
// Params 1
// Checksum 0x2684585e, Offset: 0x502c
// Size: 0x31
function function_ea8b0d4fb96856a5( lootid )
{
    backpackname = loot::getScriptableFromLootID( lootid );
    
    if ( !isdefined( backpackname ) )
    {
        backpackname = loot::function_f54ecb89dfab8e8c( lootid );
    }
    
    return backpackname;
}

// Namespace br_default_inventory
// Params 0
// Checksum 0xb025ec83, Offset: 0x5066
// Size: 0x2f, Type: bool
function isbackpackinventoryenabled()
{
    if ( !isdefined( level.noinventory ) )
    {
        return false;
    }
    
    if ( !namespace_a974e4dd85555bc2::function_831861a029b85f4c() )
    {
        return false;
    }
    
    if ( !level.noinventory )
    {
        return true;
    }
    
    return false;
}

// Namespace br_default_inventory
// Params 1
// Checksum 0xdcd55d1, Offset: 0x509e
// Size: 0x5d
function function_2fb5a15297b837d7( itemname )
{
    var_7bd99e1c7579e4f4 = isbackpackinventoryenabled();
    
    if ( var_7bd99e1c7579e4f4 && utility::issharedfuncdefined( #"gametype", #"lootallowedinbackpack" ) )
    {
        var_7bd99e1c7579e4f4 = utility::callsharedfunc( #"gametype", #"lootallowedinbackpack", itemname );
    }
    
    return var_7bd99e1c7579e4f4;
}

// Namespace br_default_inventory
// Params 1
// Checksum 0x337b9535, Offset: 0x5104
// Size: 0x7b, Type: bool
function function_a073e760594105c6( player )
{
    for ( weaponindex = 0; weaponindex < 3 ; weaponindex++ )
    {
        var_e281cbb02eb921e1 = br_pickups::function_5ef22d170cdde55e( player, weaponindex );
        
        if ( isdefined( var_e281cbb02eb921e1 ) && !weapon::isfistsonly( var_e281cbb02eb921e1 ) && !weapon::isgunlessweapon( var_e281cbb02eb921e1 ) )
        {
            rootname = weapon::getweaponrootname( var_e281cbb02eb921e1 );
            
            if ( rootname != "none" )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace br_default_inventory
// Params 5
// Checksum 0x94136fbc, Offset: 0x5188
// Size: 0x63a
function function_7efe1c7f7b48fea7( itemtype, itemindex, var_5a243e377908307f, var_29cb73c63100f914, getsingle )
{
    var_5a243e377908307f = istrue( var_5a243e377908307f );
    
    switch ( itemtype )
    {
        case 0:
            if ( level.var_2be71dc0ef8c6dc2 )
            {
                plundercount = 0;
                
                if ( isdefined( self.plundercount ) && self.plundercount > 0 )
                {
                    plundercount = br_pickups::getquickdropplundercount( !istrue( getsingle ) );
                }
                
                if ( plundercount <= 0 )
                {
                    if ( var_5a243e377908307f )
                    {
                        return [ 8395, 0 ];
                    }
                    else
                    {
                        return;
                    }
                }
                
                if ( !var_29cb73c63100f914 )
                {
                    br_plunder::playersetplundercount( 0 );
                }
                
                return [ 8395, plundercount ];
            }
            
            dropinfo = br_plunder::function_45807c0351387038();
            var_a6085d27206e04f0 = dropinfo.var_a6085d27206e04f0;
            var_f8cbc86c55703cf4 = dropinfo.var_f8cbc86c55703cf4;
            
            if ( utility::issharedfuncdefined( #"gametype", #"hash_ddcd32d167d46c69" ) )
            {
                [ var_a6085d27206e04f0, var_f8cbc86c55703cf4 ] = utility::callsharedfunc( #"gametype", #"hash_ddcd32d167d46c69", var_a6085d27206e04f0, var_f8cbc86c55703cf4 );
            }
            
            self.plundercountondeath = var_a6085d27206e04f0;
            br_plunder::playersetplundercount( var_a6085d27206e04f0 );
            
            if ( var_f8cbc86c55703cf4 <= 0 )
            {
                if ( var_5a243e377908307f )
                {
                    return [ 8395, 0 ];
                }
                else
                {
                    return;
                }
            }
            
            return [ 8395, var_f8cbc86c55703cf4 ];
        case 1:
            if ( itemindex == 2 )
            {
                if ( !function_787d2ebb0cc2e86f( self ) )
                {
                    return [ 0, 0, undefined ];
                }
                
                lootid = self getplayerdata( level.var_6f9b00680ed002d8, "dmzWeapon", "lootItemID" );
                var_f7cb5f756a346f4a = function_3b4976a12ea5037b( self );
                return [ lootid, self getweaponammoclip( var_f7cb5f756a346f4a ), var_f7cb5f756a346f4a ];
            }
            
            var_f7cb5f756a346f4a = br_pickups::function_5ef22d170cdde55e( self, itemindex );
            
            if ( !isdefined( var_f7cb5f756a346f4a ) )
            {
                if ( var_5a243e377908307f )
                {
                    return [ 0, 0, undefined ];
                }
                else
                {
                    return;
                }
            }
            
            rootname = weapon::getweaponrootname( var_f7cb5f756a346f4a );
            variantid = var_f7cb5f756a346f4a.variantid;
            
            if ( !isdefined( var_f7cb5f756a346f4a.variantid ) )
            {
                variantid = 0;
            }
            
            lootid = weapon::getweaponlootid( var_f7cb5f756a346f4a );
            return [ lootid, self getweaponammoclip( var_f7cb5f756a346f4a ), var_f7cb5f756a346f4a ];
        case 10:
            return function_c022fc696a9c0db2( itemindex );
        case 2:
            slot = equipment_mp::function_b1928e5713e81b5e( itemindex );
            
            if ( !isdefined( self.equipment[ slot ] ) )
            {
                if ( var_5a243e377908307f )
                {
                    return [ 0, 0 ];
                }
                else
                {
                    return;
                }
            }
            
            ref = self.equipment[ slot ];
            var_f7e41c4e8421f7d3 = function_f02c63b99c9614c9( level.br_pickups.br_equipname, self.equipment[ slot ] );
            lootid = loot::function_d3e3bcaea591a6a2( var_f7e41c4e8421f7d3 );
            ammocount = 0;
            
            if ( ref == "equip_hb_sensor" )
            {
                ammocount = hb_sensor_equipment::function_4bae610387dbbea0();
            }
            else if ( getsingle )
            {
                ammocount = 1;
            }
            else
            {
                ammocount = equipment_mp::getequipmentslotammo( slot );
            }
            
            return [ lootid, ammocount ];
        case 3:
            if ( !isdefined( self.streakdata.streaks[ 1 ] ) )
            {
                if ( var_5a243e377908307f )
                {
                    return [ 0, 0 ];
                }
                else
                {
                    return;
                }
            }
            
            scriptable = level.br_pickups.var_5515c706eaccd3[ self.streakdata.streaks[ 1 ].streakname ];
            lootid = loot::function_d3e3bcaea591a6a2( scriptable );
            return [ lootid, 1 ];
        case 4:
            if ( !isdefined( self.equipment[ "super" ] ) )
            {
                if ( var_5a243e377908307f )
                {
                    return [ 0, 0 ];
                }
                else
                {
                    return;
                }
            }
            
            var_f7e41c4e8421f7d3 = function_f02c63b99c9614c9( level.br_pickups.br_equipname, self.equipment[ "super" ] );
            lootid = loot::function_d3e3bcaea591a6a2( var_f7e41c4e8421f7d3 );
            ammocount = br_pickups::function_d743bcc9a06c3bb2();
            
            if ( isdefined( ammocount ) && ammocount == 0 )
            {
                if ( self.var_33129007db246c94 || supers_mp::function_31f00fe6e0334d03() && supers_mp::issuperready() )
                {
                    ammocount = 1;
                }
            }
            
            if ( !isdefined( ammocount ) )
            {
                ammocount = 0;
            }
            
            return [ lootid, ammocount ];
        case 6:
            headgeartype = self.headgeartype;
            
            if ( !br_headgear::hasheadgear( headgeartype, self ) || self.var_e6e238756ba13f0c )
            {
                if ( var_5a243e377908307f )
                {
                    return [ 0, 0 ];
                }
                else
                {
                    return;
                }
            }
            
            headgearref = br_headgear::function_6435617c4427123a( headgeartype, self );
            lootid = loot::function_d3e3bcaea591a6a2( headgearref );
            quantity = br_headgear::function_d26be71b65916bb0( headgeartype, self );
            return [ lootid, quantity ];
        case 7:
            if ( !laststand::hasselfrevivetoken() )
            {
                if ( var_5a243e377908307f )
                {
                    return [ 0, 0 ];
                }
                else
                {
                    return;
                }
            }
            
            if ( game_utility::getgametype() == "resurgence" )
            {
                if ( level.br_circle.circleindex == 0 )
                {
                    if ( !isdefined( self.b_drop_self_revive ) )
                    {
                        self.b_drop_self_revive = 1;
                        
                        if ( var_5a243e377908307f )
                        {
                            return [ 0, 0 ];
                        }
                        else
                        {
                            return;
                        }
                    }
                }
            }
            
            selfreviveloot = br_public::function_a62f204c9c901e6f( self );
            lootid = loot::function_d3e3bcaea591a6a2( selfreviveloot );
            return [ lootid, 1 ];
        case 13:
            if ( var_5a243e377908307f )
            {
                return [ 0, 0 ];
            }
            else
            {
                return;
            }
        default:
            assertmsg( "<dev string:x203>" + itemtype );
            return;
    }
}

// Namespace br_default_inventory
// Params 1
// Checksum 0xefe9ac0b, Offset: 0x57ca
// Size: 0x2e
function getplayerbackpacksize( player )
{
    backpacksize = function_51749caf406febcf( player );
    
    if ( isdefined( backpacksize ) )
    {
        return backpacksize;
    }
    
    return 0;
}

// Namespace br_default_inventory
// Params 1
// Checksum 0x72c5e041, Offset: 0x5800
// Size: 0x66
function function_51749caf406febcf( player )
{
    if ( level.var_34f728a694b965f7 )
    {
        return level.var_415fc308a7faccd9;
    }
    
    if ( !( isdefined( level.var_6f9b00680ed002d8 ) && isdefined( level.backpacksize ) ) )
    {
        return;
    }
    
    if ( isbot( player ) )
    {
        return common_inventory::function_ddf98332913ae51();
    }
    
    return player getplayerdata( level.var_6f9b00680ed002d8, level.backpacksize );
}

// Namespace br_default_inventory
// Params 4
// Checksum 0xb0905ebb, Offset: 0x586f
// Size: 0xcf
function function_7fcce769f23a1428( player, size, var_756e9aa2b7f492de, backpackid )
{
    player.backpackid = backpackid;
    
    if ( !isdefined( backpackid ) )
    {
        player.backpackid = function_4360250f13201aee( size );
    }
    
    backpacktype = function_3e0bcfe5e9c5bd35( player.backpackid );
    player setclientomnvar( "ui_loot_backpack_type", backpacktype );
    player setplayerdata( level.var_6f9b00680ed002d8, level.backpacksize, size );
    player setplayerdata( level.var_6f9b00680ed002d8, "backpackSize", size );
    
    if ( var_756e9aa2b7f492de )
    {
        return;
    }
    
    var_71057ccb7dc45dc0 = function_269d933ef7b39d72( player );
    player backpack::attachbag( var_71057ccb7dc45dc0 );
}

// Namespace br_default_inventory
// Params 3
// Checksum 0xa5a29b7d, Offset: 0x5946
// Size: 0xdc
function function_c0277b9c26d57ffc( player, currentsize, backpackname )
{
    dropstruct = pickups::function_f71dd588dc4f6288();
    
    for ( i = currentsize; i < 11 ; i++ )
    {
        [ lootid, quantity, _ ] = function_c022fc696a9c0db2( i );
        
        if ( !( isdefined( lootid ) && isdefined( quantity ) ) )
        {
            continue;
        }
        
        if ( lootid == 0 || quantity == 0 )
        {
            continue;
        }
        
        br_pickups::function_1c6552d4cf849261( player, 10, i, 1 );
    }
    
    if ( !function_345a6d7c5fc381ea( backpackname ) && function_787d2ebb0cc2e86f( player ) )
    {
        br_pickups::quickdropweapon( player, 1, 2 );
    }
}

// Namespace br_default_inventory
// Params 1
// Checksum 0x37af8c42, Offset: 0x5a2a
// Size: 0x63, Type: bool
function function_345a6d7c5fc381ea( backpackname )
{
    if ( !isdefined( backpackname ) )
    {
        return false;
    }
    
    switch ( backpackname )
    {
        case #"hash_5cdbaa0bf3e5ebfe":
        case #"hash_75ca97f27fab119c":
            return true;
        case #"hash_7e7616dbf5a436f2":
        case #"hash_c2b5d7ec929a9d4a":
            return false;
        default:
            return false;
    }
    
    return false;
}

// Namespace br_default_inventory
// Params 2
// Checksum 0xdbfa9679, Offset: 0x5a96
// Size: 0xbb
function function_3e818c02bf6469d3( player, onconnect )
{
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    
    while ( br_instance_inventory::function_926a8f8643d34690() && !self function_bcc29d70f0e86b37() )
    {
        waitframe();
    }
    
    restored = br_instance_inventory::function_41b9f29c838850e9( player, onconnect );
    
    if ( !level.var_34f728a694b965f7 )
    {
        backpacksize = getplayerbackpacksize( player );
        backpackid = restored ? player.backpackid : undefined;
        function_7fcce769f23a1428( player, backpacksize, 1, backpackid );
    }
    
    flags::function_2f3408423ccc9b2e( "prematch_done" );
    restored = br_instance_inventory::function_de26efb0d098172f( player );
}

// Namespace br_default_inventory
// Params 3
// Checksum 0x1260dc3d, Offset: 0x5b59
// Size: 0x119
function function_af60747a2da55b77( doublebackpack, var_5a243e377908307f, var_29cb73c63100f914 )
{
    loadoutcontents = [];
    loadoutcontents[ 0 ] = [];
    loadoutcontents[ 0 ][ 0 ] = function_7efe1c7f7b48fea7( 0, 0, var_5a243e377908307f, var_29cb73c63100f914 );
    loadoutcontents[ 1 ] = [];
    loadoutcontents[ 1 ][ 0 ] = function_7efe1c7f7b48fea7( 1, 0, var_5a243e377908307f );
    loadoutcontents[ 1 ][ 1 ] = function_7efe1c7f7b48fea7( 1, 1, var_5a243e377908307f );
    loadoutcontents[ 2 ] = [];
    loadoutcontents[ 2 ][ 0 ] = function_7efe1c7f7b48fea7( 2, 0, var_5a243e377908307f );
    loadoutcontents[ 2 ][ 1 ] = function_7efe1c7f7b48fea7( 2, 1, var_5a243e377908307f );
    loadoutcontents[ 2 ][ 2 ] = function_7efe1c7f7b48fea7( 2, 2, var_5a243e377908307f );
    loadoutcontents[ 3 ] = [];
    
    if ( doublebackpack )
    {
        loadoutcontents[ 3 ][ 0 ] = function_7efe1c7f7b48fea7( 3, 0, var_5a243e377908307f );
    }
    
    loadoutcontents[ 4 ] = [];
    loadoutcontents[ 4 ][ 0 ] = function_7efe1c7f7b48fea7( 4, 0, var_5a243e377908307f );
    
    if ( doublebackpack )
    {
        loadoutcontents[ 6 ] = [];
        loadoutcontents[ 6 ][ 0 ] = function_7efe1c7f7b48fea7( 6, 0, var_5a243e377908307f );
        loadoutcontents[ 7 ] = [];
        loadoutcontents[ 7 ][ 0 ] = function_7efe1c7f7b48fea7( 7, 0, var_5a243e377908307f );
    }
    
    return loadoutcontents;
}

// Namespace br_default_inventory
// Params 1
// Checksum 0xe6d35598, Offset: 0x5c7b
// Size: 0x6f
function function_82aa3e95249d3364( player )
{
    if ( !level.var_eda7b39474060e6 || br_instance_inventory::function_926a8f8643d34690() || level.var_82aa3e95249d3364 )
    {
        player function_c0b169f62dbfe988();
        function_41f1acd3a22c850e( player );
        function_7fcce769f23a1428( player, 5, 1 );
        player setplayerdata( level.var_6f9b00680ed002d8, "dmzPlateCarrierLevel", 1 );
        function_41f1acd3a22c850e( player );
    }
}

// Namespace br_default_inventory
// Params 1
// Checksum 0xe2763998, Offset: 0x5cf2
// Size: 0x59, Type: bool
function function_387c873743af544a( itemtype )
{
    if ( !isdefined( itemtype ) )
    {
        return false;
    }
    
    itemtype = getxhash( itemtype );
    return itemtype == #"plunder" || itemtype == #"valuable" || itemtype == #"personal" || itemtype == #"dogtag";
}

// Namespace br_default_inventory
// Params 1
// Checksum 0xadaab667, Offset: 0x5d54
// Size: 0x71
function function_e9b807a15a8c58e5( backpack )
{
    if ( isdefined( self.dropped_backpack ) )
    {
        self.dropped_backpack.criticalitem = undefined;
        self.dropped_backpack notify( #"end_backpack_empty_watcher" );
    }
    
    self.dropped_backpack = backpack;
    self.dropped_backpack.criticalitem = 1;
    self.dropped_backpack thread backpack_empty_watcher();
}

// Namespace br_default_inventory
// Params 0
// Checksum 0x49a83943, Offset: 0x5dcd
// Size: 0xa9
function backpack_empty_watcher()
{
    level endon( #"game_ended" );
    self endon( #"end_backpack_empty_watcher" );
    
    while ( isdefined( self ) && !isdefined( self.loadoutcontents ) )
    {
        wait 0.05;
    }
    
    while ( isdefined( self ) && isdefined( self.loadoutcontents ) )
    {
        b_empty = 1;
        
        for ( i = 0; i < self.loadoutcontents.size - 1 ; i++ )
        {
            if ( self.loadoutcontents[ i ][ "quantity" ] )
            {
                b_empty = 0;
            }
        }
        
        if ( b_empty )
        {
            self.criticalitem = undefined;
            return;
        }
        
        wait 1;
    }
}

// Namespace br_default_inventory
// Params 2
// Checksum 0xd8c5db01, Offset: 0x5e7e
// Size: 0x105
function function_86f211f994ea95a3( itemsonspawn, quantity = 1 )
{
    items = strtok( itemsonspawn, "," );
    
    foreach ( itemname in items )
    {
        backpackindex = getavailabledmzbackpackindex();
        
        if ( !isdefined( backpackindex ) )
        {
            break;
        }
        
        fakepickup = spawnstruct();
        fakepickup.scriptablename = itemname;
        fakepickup.count = quantity;
        lootid = loot::function_d3e3bcaea591a6a2( fakepickup.scriptablename );
        additemtobackpack( lootid, fakepickup );
    }
}

