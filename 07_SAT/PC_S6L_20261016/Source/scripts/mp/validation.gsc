// scripts\mp\validation.gsc  (hash_57753f84d1563669.gscc) (size: 39562 Bytes / 0x9a8a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfecfc385 (4275028869)
// size ...... 39562 (0x9a8a)
// includes .. 16  (offset: 0x8f52)
// strings ... 136 (offset: 0x8fd2)
// dev strs .. 23  (offset: 0x994a)
// exports ... 41  (offset: 0x7412)
// cseg ...... 0xb60 + 0x68b2 (0x7412)
// imports ... 149 (offset: 0x7a7a)
// animtree1 . 0   (offset: 0x9a8a)
// animtree2 . 0   (offset: 0x9a8a)
#using script_5c80e17482acb972;
#using scripts\common\killstreaks\killstreak_common;
#using scripts\common\script;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\class;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\perks\perks;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\equipment;
#using scripts\mp\loot;
#using scripts\mp\supers;

#namespace validation;

// Namespace validation
// Params 2
// Checksum 0xb1ea600f, Offset: 0xb7e
// Size: 0x16, Type: bool
function isitemunlocked( foo, bar )
{
    return false;
}

// Namespace validation
// Params 3
// Checksum 0x7954c63c, Offset: 0xb9d
// Size: 0xa9
function validationerror( errortype, slot, item )
{
    errorstring = errortype;
    
    if ( isdefined( slot ) )
    {
        errorstring = errorstring + "_" + slot;
    }
    
    if ( isdefined( item ) )
    {
        errorstring = errorstring + " - " + item;
    }
    
    /#
        if ( getdvarint( @"scr_validate_print", 0 ) == 1 )
        {
            println( errorstring );
        }
    #/
    
    if ( getdvarint( @"scr_validate_assert", 0 ) == 1 )
    {
        assertmsg( errorstring );
    }
    
    if ( getdvarint( @"scr_validate_record", 0 ) == 1 )
    {
        class::recordvalidationinfraction();
    }
}

// Namespace validation
// Params 2
// Checksum 0x51346987, Offset: 0xc4e
// Size: 0x43
function isvalidattachmentunlock( weaponrootname, attachmentbasename )
{
    checkvalidattachmentunlock = getdvarint( @"scr_checkvalidattachmentunlock", 0 ) == 1;
    
    if ( checkvalidattachmentunlock )
    {
        return weapon::attachmentisselectablerootname( weaponrootname, attachmentbasename );
    }
    
    return 1;
}

// Namespace validation
// Params 0
// Checksum 0xb44fd7de, Offset: 0xc9a
// Size: 0x1d5
function function_a360601d1cdfc8()
{
    var_d275275b9c49f288 = getdvarint( @"hash_838359d5ebdcc7e0", 0 );
    
    if ( var_d275275b9c49f288 == 0 )
    {
        return;
    }
    
    for ( loadoutindex = 0; loadoutindex < 12 ; loadoutindex++ )
    {
        loadoutisinuse = self getplayerdata( level.loadoutdata, "squadMembers", "loadouts", loadoutindex, "inUse" );
        
        if ( loadoutisinuse == 1 )
        {
            for ( weaponindex = 0; weaponindex < 2 ; weaponindex++ )
            {
                weaponname = class::cac_getweapon( loadoutindex, weaponindex );
                weaponVariantID = class::cac_getweaponvariantid( loadoutindex, weaponindex );
                weaponlootitemid = class::cac_getweaponlootitemid( loadoutindex, weaponindex );
                wildcard = class::function_facf39de1a82731a();
                attachments = [];
                attachmentsids = [];
                maxattachments = weaponindex == 0 ? weapon::getmaxprimaryattachments( wildcard ) : weapon::getmaxsecondaryattachments( wildcard );
                maxstickers = weaponindex == 0 ? class::function_b6a916f16fba9df2() : class::function_9df021ae03066e();
                
                for ( attachmentindex = 0; attachmentindex < maxattachments ; attachmentindex++ )
                {
                    attachmentname = class::cac_getweaponattachment( loadoutindex, weaponindex, attachmentindex );
                    attachments[ attachmentindex ] = attachmentname;
                    attachmentsids[ attachmentindex ] = class::cac_getweaponattachmentid( loadoutindex, weaponindex, attachmentindex );
                }
                
                camoname = class::cac_getweaponcamo( loadoutindex, weaponindex );
                charmname = class::cac_getweaponcosmeticattachment( loadoutindex, weaponindex );
                stickers = [];
                
                for ( stickerindex = 0; stickerindex < maxstickers ; stickerindex++ )
                {
                    stickers[ stickerindex ] = class::cac_getweaponsticker( loadoutindex, weaponindex, stickerindex );
                }
                
                function_4dbb536e59c57493( weaponname, weaponVariantID, weaponlootitemid, attachments, attachmentsids, camoname, charmname, stickers );
            }
        }
    }
}

// Namespace validation
// Params 2
// Checksum 0x308d18bb, Offset: 0xe77
// Size: 0x159
function getcamolootid( weaponname, weaponcamo )
{
    category = getscriptbundlefieldvalue( weaponcamo, #"camocategory" );
    
    if ( category == %"hash_28350f68699c29d8" )
    {
        if ( isdefined( level.weaponmappedcamos[ weaponname ][ weaponcamo ] ) )
        {
            return level.weaponmappedcamos[ weaponname ][ weaponcamo ];
        }
        else
        {
            lootid = loot::getlootidfromref( weaponcamo );
            
            if ( lootid == 0 )
            {
                script::demoforcesre( "getCamoLootID: weaponName/weaponCamo [" + weaponname + "/" + weaponcamo + "] not in level.weaponMappedCamos" );
            }
            
            return lootid;
        }
        
        return;
    }
    
    if ( category == %"hash_4776f6cb4face6d7" )
    {
        weaponclass = "";
        weaponscriptbundle = weapon::function_659a3e10e8d1c91c( weaponname, [ #"menuclass" ] );
        
        if ( isdefined( weaponscriptbundle ) )
        {
            weaponclass = weaponscriptbundle.menuclass;
        }
        
        if ( weaponclass && isdefined( level.weaponmappedcamos[ weaponclass ][ weaponcamo ] ) )
        {
            return level.weaponmappedcamos[ weaponclass ][ weaponcamo ];
        }
        else
        {
            lootid = loot::getlootidfromref( weaponcamo );
            
            if ( lootid == 0 )
            {
                script::demoforcesre( "getCamoLootID: weaponName/weaponCamo [" + weaponname + "/" + weaponcamo + "] not in level.weaponMappedCamos" );
            }
            
            return lootid;
        }
        
        return;
    }
    
    return loot::getlootidfromref( weaponcamo );
}

// Namespace validation
// Params 1
// Checksum 0x6b9d18b5, Offset: 0xfd8
// Size: 0x1dd, Type: bool
function function_ec25cb1dcf5577f8( weaponlootid )
{
    if ( getdvarint( @"hash_272c95c93da464bb", 0 ) == 0 )
    {
        return false;
    }
    
    var_a430cd1fbb56d236 = [ 11354, 11344, 11338, 11352, 11318, 11337, 11340, 11323, 11331, 11307, 11317, 11324, 11328, 11351, 11357, 11355, 11315, 11367, 11320, 11353 ];
    var_59871fc4a7328e21 = [ 11354, 11356, 11374, 11344, 11317, 11352 ];
    
    if ( isbrgamemode() )
    {
        foreach ( var_e9ddaed9c1a7615f in var_a430cd1fbb56d236 )
        {
            if ( var_e9ddaed9c1a7615f == weaponlootid )
            {
                return true;
            }
        }
    }
    else if ( utility::ismp() )
    {
        foreach ( var_e9ddaed9c1a7615f in var_59871fc4a7328e21 )
        {
            if ( var_e9ddaed9c1a7615f == weaponlootid )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace validation
// Params 8
// Checksum 0x648c596e, Offset: 0x11be
// Size: 0x490
function function_4dbb536e59c57493( weaponname, weaponVariantID, weaponlootitemid, attachments, attachmentsids, camoname, charmname, stickers )
{
    var_8a9fe7aa2cde3afe = [];
    var_5eb6a7d026bf79e5 = getdvarint( @"hash_c876f19dd06eb2cf", 0 );
    var_d9d69a5f1a330d03 = weaponVariantID != 0;
    var_d4b4c74e68b295f6 = weaponname + "|" + weaponVariantID;
    var_8ee8571c52dcf9e1 = 0;
    
    if ( weaponlootitemid != 0 )
    {
        var_8ee8571c52dcf9e1 = weaponlootitemid;
    }
    else if ( isdefined( level.weaponmapdata[ weaponname ] ) )
    {
        var_8ee8571c52dcf9e1 = level.weaponmapdata[ weaponname ].weaponlootid;
    }
    
    if ( !function_ec25cb1dcf5577f8( var_8ee8571c52dcf9e1 ) )
    {
        var_8a9fe7aa2cde3afe[ var_8a9fe7aa2cde3afe.size ] = var_8ee8571c52dcf9e1;
    }
    
    weaponclass = "";
    weaponscriptbundle = weapon::function_659a3e10e8d1c91c( weaponname, [ #"menuclass" ] );
    
    if ( isdefined( weaponscriptbundle ) )
    {
        weaponclass = weaponscriptbundle.menuclass;
    }
    
    if ( isdefined( weaponclass ) && weaponclass != "weapon_melee" && weaponclass != "weapon_melee2" )
    {
        var_287b4b3237470d77 = getweapondefaultattachments( weapon::getdefaultweaponbasename( weaponname ) );
        
        foreach ( attachmentindex, attachmentname in attachments )
        {
            if ( attachmentname != "none" )
            {
                var_55a69b6209a6c8c3 = 1;
                
                if ( var_5eb6a7d026bf79e5 == 1 && weapon::isattachmentironsdefault( attachmentname ) )
                {
                    continue;
                }
                
                if ( attachmentsids[ attachmentindex ] != 0 )
                {
                    weaponbasename = weapon::getdefaultweaponbasename( weaponname );
                    blueprints = function_d3cb2c9aad7e9c4( weaponbasename, attachmentname );
                    
                    foreach ( variantindex, attachmentdata in blueprints )
                    {
                        if ( variantindex == attachmentsids[ attachmentindex ] && isdefined( attachmentdata ) )
                        {
                            var_8a9fe7aa2cde3afe[ var_8a9fe7aa2cde3afe.size ] = attachmentdata.lootid;
                            break;
                        }
                    }
                }
                
                if ( var_55a69b6209a6c8c3 )
                {
                    var_eb9250eaa558612c = hashcat( %"hash_3c2c9813bb16552f", attachmentname );
                    var_1bbc49bd2994cfc0 = getscriptbundlefieldvalue( var_eb9250eaa558612c, #"category" );
                    attachmentcategory = "";
                    
                    if ( var_1bbc49bd2994cfc0 )
                    {
                        attachmentcategory = getscriptbundlefieldvalue( var_1bbc49bd2994cfc0, #"ref" );
                    }
                    
                    if ( attachmentcategory == "receiver" )
                    {
                        continue;
                    }
                    
                    isdefaultattachment = 0;
                    
                    foreach ( defaultattachmentname in var_287b4b3237470d77 )
                    {
                        if ( defaultattachmentname == attachmentname )
                        {
                            isdefaultattachment = 1;
                            break;
                        }
                    }
                    
                    if ( isdefaultattachment )
                    {
                        continue;
                    }
                    
                    attachmentscriptbundle = getscriptbundlefieldvalue( var_eb9250eaa558612c, #"lootid" );
                    
                    if ( attachmentscriptbundle )
                    {
                        var_8a9fe7aa2cde3afe[ var_8a9fe7aa2cde3afe.size ] = attachmentscriptbundle.lootid;
                    }
                }
            }
        }
    }
    
    camoid = getcamolootid( weaponname, camoname );
    var_8a9fe7aa2cde3afe[ var_8a9fe7aa2cde3afe.size ] = camoid;
    charmid = loot::getlootidfromref( charmname );
    var_8a9fe7aa2cde3afe[ var_8a9fe7aa2cde3afe.size ] = charmid;
    
    foreach ( sticker in stickers )
    {
        if ( sticker != "sticker_none" )
        {
            stickerlootid = loot::getlootidfromref( sticker );
            var_8a9fe7aa2cde3afe[ var_8a9fe7aa2cde3afe.size ] = stickerlootid;
        }
    }
    
    self function_49bdd1291f4756ca( var_8a9fe7aa2cde3afe );
}

// Namespace validation
// Params 1
// Checksum 0xcaeeaeb, Offset: 0x1656
// Size: 0x12b
function function_abb8988ba0ff79e0( classstruct )
{
    var_d275275b9c49f288 = getdvarint( @"hash_838359d5ebdcc7e0", 0 );
    
    if ( var_d275275b9c49f288 == 0 )
    {
        return;
    }
    
    if ( isbrgamemode() || level.leagueplaymatch || !level.rankedmatch || !level.matchmakingmatch || !level.onlinestatsenabled )
    {
        return;
    }
    
    function_4dbb536e59c57493( classstruct.loadoutprimary, classstruct.loadoutprimaryvariantid, classstruct.loadoutprimarylootitemid, classstruct.loadoutprimaryattachments, classstruct.loadoutprimaryattachmentids, classstruct.loadoutprimarycamo, classstruct.loadoutprimarycosmeticattachment, classstruct.loadoutprimarystickers );
    function_4dbb536e59c57493( classstruct.loadoutsecondary, classstruct.loadoutsecondaryvariantid, classstruct.loadoutsecondarylootitemid, classstruct.loadoutsecondaryattachments, classstruct.loadoutsecondaryattachmentids, classstruct.loadoutsecondarycamo, classstruct.loadoutsecondarycosmeticattachment, classstruct.loadoutsecondarystickers );
}

// Namespace validation
// Params 2
// Checksum 0xf5696496, Offset: 0x1789
// Size: 0x1f06
function validateloadout( loadout, class )
{
    if ( level.gamemodebundle.var_88a15fb9fa8c3ae4 )
    {
        return;
    }
    
    var_b71e159670bde512 = isdefined( level.gamemodebundle ) && level.gamemodebundle.var_ed83f0f1668a6ed2;
    var_b3698f4df0fcbd33 = 0;
    
    if ( var_b71e159670bde512 )
    {
        assert( !level.var_ac98e7cc4b10cb11, "<dev string:x24>" );
        loadout = namespace_aa91747accf9e514::overrideweapons( loadout );
        vestperk = namespace_aa91747accf9e514::function_e90603b85d730587( loadout );
        
        if ( vestperk == "specialty_null" && level.allowperks )
        {
            var_b3698f4df0fcbd33 = 1;
        }
    }
    
    fallbackloadout = function_b7ff987740639b18();
    function_abb8988ba0ff79e0( loadout );
    replaceweapon = 0;
    var_25cd9baa4bdd20fd = "";
    var_93a9b19d51571653 = weapon::getweaponrootname( loadout.loadoutprimary );
    
    if ( !weapon::weapondefinedinstatstable( var_93a9b19d51571653 ) && !self.var_2516791e1cd27f66 )
    {
        replaceweapon = 1;
        var_25cd9baa4bdd20fd += ( loadout.loadoutprimary ?? "" ) + " : primary_weaponDefinedInStatsTable, ";
    }
    else if ( isweaponuihidden( loadout.loadoutprimary ) )
    {
        replaceweapon = 1;
        var_25cd9baa4bdd20fd += ( loadout.loadoutprimary ?? "" ) + " : primary_isWeaponUIHidden, ";
    }
    
    var_3349ff2ffef57c34 = istrue( getdvarint( @"scr_loadout_validate_banned_items", 0 ) );
    
    if ( var_3349ff2ffef57c34 && loot::isitembannedbyref( loadout.loadoutprimary ) )
    {
        replaceweapon = 1;
        var_25cd9baa4bdd20fd += ( loadout.loadoutprimary ?? "" ) + " : primary_isItemBannedByRef, ";
    }
    
    underkillperkname = "specialty_underkill";
    var_750e2e75213e3a5c = !perkisrestricted( underkillperkname ) && arraycontains( loadout.loadoutperks, underkillperkname );
    var_75eb61fb3f9cef0 = 0;
    var_782b47f9249e4fb6 = isdefined( level.gamemodebundle ) && level.gamemodebundle.var_782b47f9249e4fb6;
    
    if ( var_b71e159670bde512 && loadout.loadoutprimary != "none" && level.perkbundles[ vestperk ].var_3289ad77b9ef2523.primary == 0 )
    {
        var_b3698f4df0fcbd33 = 1;
    }
    
    if ( !var_b71e159670bde512 )
    {
        switch ( level.gamemodebundle.var_ff164eb2cd7a2415 )
        {
            case #"wildcard":
                var_75eb61fb3f9cef0 = loadout.loadoutwildcard == "wildcard_overkill";
                break;
            case #"perk":
                overkillperkname = "specialty_munitions_2";
                var_75eb61fb3f9cef0 = !perkisrestricted( overkillperkname ) && arraycontains( loadout.loadoutperks, overkillperkname );
                break;
            case #"always":
                var_75eb61fb3f9cef0 = 1;
                break;
            default:
                var_82398dc51ef3243c = "";
                valuestring = level.gamemodebundle.var_ff164eb2cd7a2415;
                
                /#
                    var_82398dc51ef3243c = getgamemodescriptbundlename();
                    valuestring = getxhashsourcename( level.gamemodebundle.var_ff164eb2cd7a2415 );
                #/
                
                throw( "gamemodebundle " + var_82398dc51ef3243c + " has unsupported loadoutOverkillMechanism value: " + valuestring );
                break;
        }
    }
    
    primaryisempty = !isdefined( level.loadoutprimary ) || level.loadoutprimary == "none" || level.loadoutprimary == "" || issubstr( level.loadoutprimary, "me_fists" );
    
    if ( !var_b71e159670bde512 && !weapon::iscacprimaryweapon( loadout.loadoutprimary ) && !var_750e2e75213e3a5c && !var_75eb61fb3f9cef0 && !level.var_5297cc84d8e87d08 && !level.gamemodebundle.var_c3ee258e4ff9837a && !( primaryisempty && var_782b47f9249e4fb6 ) )
    {
        replaceweapon = 1;
        var_25cd9baa4bdd20fd += ( loadout.loadoutprimary ?? "" ) + " : primary_isCACPrimaryWeapon, ";
    }
    
    restricteditemreplaced = 0;
    var_1d31cc3aaec45dc0 = 0;
    primaryweaponclass = weapon::function_c37ac3c4f987e506( loadout.loadoutprimary, #"menuclass" );
    
    if ( weaponisrestricted( var_93a9b19d51571653 ) || isdefined( primaryweaponclass ) && function_16ede83265750fcb( primaryweaponclass ) )
    {
        replaceweapon = 1;
        restricteditemreplaced = 1;
        var_25cd9baa4bdd20fd += ( loadout.loadoutprimary ?? "" ) + " : primary_restrictedItemReplaced, ";
    }
    
    if ( !isdefined( primaryweaponclass ) && !self isplayerheadless() && isdefined( class ) && issubstr( class, "custom" ) && !( level.gamemodebundle.var_c3ee258e4ff9837a && issubstr( loadout.loadoutprimary, "me_fists" ) ) )
    {
        var_1e0f0a9fe60edc25 = loadout.loadoutprimary ?? "";
        
        if ( !arraycontains( [ "none", "t10_me_fists_mp" ], var_1e0f0a9fe60edc25 ) )
        {
            script::function_2e2007575f92910d( "CER-400502: weap bundle not found for " + var_1e0f0a9fe60edc25 + " for " + ( self getplayerunoid() ?? "" ) + " weapon replaced " + ( var_25cd9baa4bdd20fd ?? "" ) + " class : " + ( class ?? "" ) );
        }
    }
    
    if ( !getdvarint( @"hash_3cbf443b6eb24372", 0 ) )
    {
        if ( var_93a9b19d51571653 && !arraycontains( level.weaponlistbundle, var_93a9b19d51571653 ) )
        {
            replaceweapon = 1;
            var_25cd9baa4bdd20fd += ( loadout.loadoutprimary ?? "" ) + " : primary_invalidWeapon, ";
        }
    }
    
    var_c4fce1a57baead11 = getdvarint( @"scr_validate_required_attachments", 1 );
    var_1a6c64acb495495d = strtok( getdvar( @"scr_validate_required_attachments_list", "" ), "," );
    
    if ( replaceweapon )
    {
        loadout = replaceprimaryweapon( loadout );
    }
    else
    {
        if ( isweaponvariantlocked( loadout.loadoutprimary, loadout.loadoutprimaryvariantid ) )
        {
            loadout.loadoutprimaryvariantid = -1;
        }
        
        var_e1c19dc6ef3b6290 = weapon::buildweapon( loadout.loadoutprimary, loadout.loadoutprimaryattachments );
        
        for ( i = 0; i < loadout.loadoutprimaryattachments.size ; i++ )
        {
            attachment = loadout.loadoutprimaryattachments[ i ];
            
            if ( attachment != "none" )
            {
                attachmentscriptbundle = getscriptbundle( hashcat( %"hash_3c2c9813bb16552f", attachment ) );
                
                if ( attachmentisrestricted( attachment, loadout.loadoutprimary ) || var_3349ff2ffef57c34 && loot::isitembannedbyref( attachment ) )
                {
                    if ( isdefined( attachmentscriptbundle ) && attachmentscriptbundle.isamp )
                    {
                        for ( j = 0; j < loadout.loadoutprimaryattachments.size ; j++ )
                        {
                            loadout.loadoutprimaryattachments[ j ] = "none";
                        }
                        
                        break;
                    }
                    
                    loadout.loadoutprimaryattachments[ i ] = "none";
                    var_1d31cc3aaec45dc0 = 1;
                    var_25cd9baa4bdd20fd += ( loadout.loadoutprimary ?? "" ) + " attachment " + attachment + " : restricted or banned, ";
                    var_e1c19dc6ef3b6290 = weapon::buildweapon( loadout.loadoutprimary, loadout.loadoutprimaryattachments );
                    continue;
                }
                
                if ( var_c4fce1a57baead11 && ( var_1a6c64acb495495d.size == 0 || arraycontains( var_1a6c64acb495495d, attachment ) ) )
                {
                    var_38ede57d1fc04b0a = 0;
                    requiredattachments = getrequiredattachments( weapon::getdefaultweaponbasename( loadout.loadoutprimary ), attachment );
                    
                    foreach ( requiredattachment in requiredattachments )
                    {
                        if ( !var_e1c19dc6ef3b6290 hasattachment( requiredattachment ) )
                        {
                            var_25cd9baa4bdd20fd += ( loadout.loadoutprimary ?? "" ) + " attachment " + attachment + " : missing required attachment " + requiredattachment + ", ";
                            var_38ede57d1fc04b0a = 1;
                            break;
                        }
                    }
                    
                    if ( var_38ede57d1fc04b0a )
                    {
                        loadout.loadoutprimaryattachments[ i ] = "none";
                        var_e1c19dc6ef3b6290 = weapon::buildweapon( loadout.loadoutprimary, loadout.loadoutprimaryattachments );
                    }
                }
            }
        }
    }
    
    replaceweapon = 0;
    var_ce5c19abc9a61b03 = weapon::getweaponrootname( loadout.loadoutsecondary );
    
    if ( !weapon::weapondefinedinstatstable( var_ce5c19abc9a61b03 ) && var_ce5c19abc9a61b03 != "none" )
    {
        replaceweapon = 1;
        var_25cd9baa4bdd20fd += ( loadout.loadoutsecondary ?? "" ) + " : secondary_weaponDefinedInStatsTable, ";
    }
    else if ( isweaponuihidden( loadout.loadoutsecondary ) )
    {
        replaceweapon = 1;
        var_25cd9baa4bdd20fd += ( loadout.loadoutsecondary ?? "" ) + " : secondary_isWeaponUIHidden, ";
    }
    
    if ( var_b71e159670bde512 && loadout.loadoutsecondary != "none" && level.perkbundles[ vestperk ].var_3289ad77b9ef2523.secondary == 0 )
    {
        var_b3698f4df0fcbd33 = 1;
    }
    
    if ( var_3349ff2ffef57c34 && loot::isitembannedbyref( loadout.loadoutsecondary ) )
    {
        replaceweapon = 1;
        var_25cd9baa4bdd20fd += ( loadout.loadoutsecondary ?? "" ) + " : secondary_isItemBannedByRef, ";
    }
    
    if ( weapon::iscacprimaryweapon( loadout.loadoutsecondary ) && !var_75eb61fb3f9cef0 && !level.gamemodebundle.var_c3ee258e4ff9837a )
    {
        replaceweapon = 1;
        var_25cd9baa4bdd20fd += ( loadout.loadoutsecondary ?? "" ) + " : secondary_isCACPrimaryWeapon, ";
    }
    
    secondaryweaponclass = weapon::function_c37ac3c4f987e506( loadout.loadoutsecondary, #"menuclass" );
    
    if ( !isdefined( secondaryweaponclass ) && !self isplayerheadless() && isdefined( class ) && issubstr( class, "custom" ) )
    {
        var_90120dfdb593d745 = loadout.loadoutsecondary ?? "";
        
        if ( !arraycontains( [ "none", "t10_me_fists_mp" ], var_90120dfdb593d745 ) )
        {
            script::function_2e2007575f92910d( "CER-400502: weap bundle not found for " + var_90120dfdb593d745 + " for " + ( self getplayerunoid() ?? "" ) + " weapon replaced " + ( var_25cd9baa4bdd20fd ?? "" ) + " class : " + ( class ?? "" ) );
        }
    }
    
    if ( weaponisrestricted( var_ce5c19abc9a61b03 ) || isdefined( secondaryweaponclass ) && function_16ede83265750fcb( secondaryweaponclass ) )
    {
        replaceweapon = 1;
        restricteditemreplaced = 1;
        var_25cd9baa4bdd20fd += ( loadout.loadoutsecondary ?? "" ) + " : secondary_WeaponIsRestricted, ";
    }
    
    if ( !getdvarint( @"hash_3cbf443b6eb24372", 0 ) )
    {
        if ( var_ce5c19abc9a61b03 && !arraycontains( level.weaponlistbundle, var_ce5c19abc9a61b03 ) )
        {
            replaceweapon = 1;
            var_25cd9baa4bdd20fd += ( loadout.loadoutsecondary ?? "" ) + " : secondary_invalidWeapon, ";
        }
    }
    
    if ( replaceweapon )
    {
        loadout = replacesecondaryweapon( loadout );
    }
    else
    {
        if ( isweaponvariantlocked( loadout.loadoutsecondary, loadout.loadoutsecondaryvariantid ) )
        {
            loadout.loadoutsecondaryvariantid = -1;
        }
        
        var_e1c19dc6ef3b6290 = weapon::buildweapon( loadout.loadoutsecondary, loadout.loadoutsecondaryattachments );
        
        for ( i = 0; i < loadout.loadoutsecondaryattachments.size ; i++ )
        {
            attachment = loadout.loadoutsecondaryattachments[ i ];
            
            if ( attachment != "none" )
            {
                if ( attachmentisrestricted( attachment, loadout.loadoutsecondary ) || var_3349ff2ffef57c34 && loot::isitembannedbyref( attachment ) )
                {
                    attachmentscriptbundle = getscriptbundle( hashcat( %"hash_3c2c9813bb16552f", attachment ) );
                    
                    if ( isdefined( attachmentscriptbundle ) && attachmentscriptbundle.isamp )
                    {
                        for ( j = 0; j < loadout.loadoutsecondaryattachments.size ; j++ )
                        {
                            loadout.loadoutsecondaryattachments[ j ] = "none";
                        }
                        
                        break;
                    }
                    
                    loadout.loadoutsecondaryattachments[ i ] = "none";
                    var_1d31cc3aaec45dc0 = 1;
                    var_25cd9baa4bdd20fd += ( loadout.loadoutsecondary ?? "" ) + " attachment " + attachment + " : restricted or banned, ";
                    var_e1c19dc6ef3b6290 = weapon::buildweapon( loadout.loadoutsecondary, loadout.loadoutsecondaryattachments );
                    continue;
                }
                
                if ( var_c4fce1a57baead11 && ( var_1a6c64acb495495d.size == 0 || arraycontains( var_1a6c64acb495495d, attachment ) ) )
                {
                    var_38ede57d1fc04b0a = 0;
                    requiredattachments = getrequiredattachments( weapon::getdefaultweaponbasename( loadout.loadoutsecondary ), attachment );
                    
                    foreach ( requiredattachment in requiredattachments )
                    {
                        if ( !var_e1c19dc6ef3b6290 hasattachment( requiredattachment ) )
                        {
                            var_25cd9baa4bdd20fd += ( loadout.loadoutsecondary ?? "" ) + " attachment " + attachment + " : missing required attachment " + requiredattachment + ", ";
                            var_38ede57d1fc04b0a = 1;
                            break;
                        }
                    }
                    
                    if ( var_38ede57d1fc04b0a )
                    {
                        loadout.loadoutsecondaryattachments[ i ] = "none";
                        var_e1c19dc6ef3b6290 = weapon::buildweapon( loadout.loadoutsecondary, loadout.loadoutsecondaryattachments );
                    }
                }
            }
        }
    }
    
    if ( level.tertiaryweaponslotenabled && getdvarint( @"scr_validate_tertiary", 1 ) )
    {
        replaceweapon = 0;
        var_e1c078c88c4135c3 = weapon::getweaponrootname( loadout.loadouttertiary );
        
        if ( !weapon::weapondefinedinstatstable( var_e1c078c88c4135c3 ) )
        {
            replaceweapon = 1;
        }
        else if ( isweaponuihidden( loadout.loadouttertiary ) )
        {
            replaceweapon = 1;
        }
        
        if ( var_3349ff2ffef57c34 && loot::isitembannedbyref( loadout.loadouttertiary ) )
        {
            replaceweapon = 1;
        }
        
        var_950f3368446421b7 = weapon::getweapongroup( loadout.loadouttertiary );
        var_be0ec98b46b8b28 = loadout.loadoutwildcard ? getxhash( loadout.loadoutwildcard ) : #"none";
        
        if ( var_be0ec98b46b8b28 == #"wildcard_flyswatter" )
        {
            if ( !( weapon::iscacmeleeweapon( loadout.loadouttertiary, var_950f3368446421b7 ) || weapon::function_ea250bfa8e4c904b( loadout.loadouttertiary, var_950f3368446421b7 ) ) )
            {
                replaceweapon = 1;
            }
        }
        else if ( !weapon::iscacmeleeweapon( loadout.loadouttertiary, var_950f3368446421b7 ) && !level.gamemodebundle.var_c3ee258e4ff9837a )
        {
            replaceweapon = 1;
        }
        
        var_685d13ad69b5050c = weapon::function_c37ac3c4f987e506( loadout.loadouttertiary, #"menuclass" );
        
        if ( weaponisrestricted( var_e1c078c88c4135c3 ) || isdefined( var_685d13ad69b5050c ) && function_16ede83265750fcb( var_685d13ad69b5050c ) )
        {
            replaceweapon = 1;
        }
        
        if ( !getdvarint( @"hash_3cbf443b6eb24372", 0 ) )
        {
            if ( var_e1c078c88c4135c3 && !arraycontains( level.weaponlistbundle, var_e1c078c88c4135c3 ) )
            {
                replaceweapon = 1;
                var_25cd9baa4bdd20fd += ( loadout.loadouttertiary ?? "" ) + " : tertiary_invalidWeapon, ";
            }
        }
        
        if ( replaceweapon )
        {
            loadout = function_53e777daf2ac63ac( loadout );
        }
        else
        {
            if ( isweaponvariantlocked( loadout.loadouttertiary, loadout.loadouttertiaryvariantid ) )
            {
                loadout.loadouttertiaryvariantid = -1;
            }
            
            var_e1c19dc6ef3b6290 = weapon::buildweapon( loadout.loadouttertiary, loadout.loadoutTertiaryAttachments );
            
            for ( i = 0; i < loadout.loadoutTertiaryAttachments.size ; i++ )
            {
                attachment = loadout.loadoutTertiaryAttachments[ i ];
                
                if ( attachment != "none" )
                {
                    if ( attachmentisrestricted( attachment, loadout.loadouttertiary ) || var_3349ff2ffef57c34 && loot::isitembannedbyref( attachment ) )
                    {
                        attachmentscriptbundle = getscriptbundle( hashcat( %"hash_3c2c9813bb16552f", attachment ) );
                        
                        if ( isdefined( attachmentscriptbundle ) && attachmentscriptbundle.isamp )
                        {
                            for ( j = 0; j < loadout.loadoutTertiaryAttachments.size ; j++ )
                            {
                                loadout.loadoutTertiaryAttachments[ j ] = "none";
                            }
                            
                            break;
                        }
                        
                        loadout.loadoutTertiaryAttachments[ i ] = "none";
                        var_1d31cc3aaec45dc0 = 1;
                        var_e1c19dc6ef3b6290 = weapon::buildweapon( loadout.loadouttertiary, loadout.loadoutTertiaryAttachments );
                        continue;
                    }
                    
                    if ( var_c4fce1a57baead11 && ( var_1a6c64acb495495d.size == 0 || arraycontains( var_1a6c64acb495495d, attachment ) ) )
                    {
                        var_38ede57d1fc04b0a = 0;
                        requiredattachments = getrequiredattachments( weapon::getdefaultweaponbasename( loadout.loadouttertiary ), attachment );
                        
                        foreach ( requiredattachment in requiredattachments )
                        {
                            if ( !var_e1c19dc6ef3b6290 hasattachment( requiredattachment ) )
                            {
                                var_38ede57d1fc04b0a = 1;
                                break;
                            }
                        }
                        
                        if ( var_38ede57d1fc04b0a )
                        {
                            loadout.loadoutTertiaryAttachments[ i ] = "none";
                            var_e1c19dc6ef3b6290 = weapon::buildweapon( loadout.loadouttertiary, loadout.loadoutTertiaryAttachments );
                        }
                    }
                }
            }
        }
    }
    
    replaceperkpackage = 0;
    var_b2bb15966a591cfd = getmatchrulesdata( "commonOption", "replaceIndividualRestrictedPerks" );
    var_f6f0fa81ba32b4ef = 0;
    var_a0f7e6a0d9fae6b7 = 0;
    var_bf3779007fd5e544 = 0;
    var_679cfb6c6f813df0 = 0;
    var_3d7f14aeddd3e92b = 0;
    var_54a10836d2410b55 = [];
    var_42bc243e6f765840 = [];
    
    foreach ( idx, perk in loadout.loadoutperks )
    {
        banned = var_3349ff2ffef57c34 && loot::isitembannedbyref( perk );
        
        if ( banned )
        {
            if ( var_b71e159670bde512 )
            {
                var_42bc243e6f765840[ var_42bc243e6f765840.size ] = perk;
            }
            else
            {
                replaceperkpackage = 1;
            }
            
            continue;
        }
        
        slot = perks::getperkslot( perk );
        
        if ( var_b71e159670bde512 && isdefined( perk ) && isdefined( level.perkbundles[ perk ] ) )
        {
            if ( !namespace_aa91747accf9e514::function_beaff1c3af9e5d5( perk, vestperk ) )
            {
                var_b3698f4df0fcbd33 = 1;
                var_3d7f14aeddd3e92b = 1;
                break;
            }
            
            if ( level.perkbundles[ perk ].var_bd1b34729a3981d5 == "vest" )
            {
                var_f6f0fa81ba32b4ef += 1;
            }
            else if ( level.perkbundles[ perk ].var_bd1b34729a3981d5 == "gloves" )
            {
                var_a0f7e6a0d9fae6b7 += 1;
            }
            else if ( level.perkbundles[ perk ].var_bd1b34729a3981d5 == "footwear" )
            {
                var_bf3779007fd5e544 += 1;
            }
            else if ( level.perkbundles[ perk ].var_bd1b34729a3981d5 == "gear" )
            {
                var_679cfb6c6f813df0 += 1;
                var_54a10836d2410b55[ var_54a10836d2410b55.size ] = perk;
            }
        }
        
        if ( isdefined( fallbackloadout.perks ) && !isdefined( slot ) )
        {
            replaceperkpackage = 1;
            break;
        }
        
        if ( perkisrestricted( perk ) || isdefined( level.var_66a4df12ef1a8c25 ) && ![[ level.var_66a4df12ef1a8c25 ]]( perk ) )
        {
            if ( var_b2bb15966a591cfd )
            {
                if ( idx < fallbackloadout.perks.size )
                {
                    loadout.loadoutperks[ idx ] = fallbackloadout.perks[ idx ];
                }
                
                continue;
            }
            
            replaceperkpackage = 1;
            break;
        }
    }
    
    if ( var_b71e159670bde512 )
    {
        foreach ( bannedperk in var_42bc243e6f765840 )
        {
            if ( isdefined( level.perkbundles[ bannedperk ] ) )
            {
                var_bd1b34729a3981d5 = level.perkbundles[ bannedperk ].var_bd1b34729a3981d5;
                
                if ( var_bd1b34729a3981d5 == "vest" )
                {
                    var_b3698f4df0fcbd33 = 1;
                    var_3d7f14aeddd3e92b = 1;
                    break;
                }
                else if ( var_bd1b34729a3981d5 == "gloves" )
                {
                    fallbackgloves = loot::function_f54ecb89dfab8e8c( getdvarint( @"hash_b3bbb60b1e889be1", 27383 ) );
                    
                    if ( !isdefined( fallbackgloves ) || fallbackgloves == "" )
                    {
                        assertmsg( "<dev string:xbe>" );
                        var_b3698f4df0fcbd33 = 1;
                        var_3d7f14aeddd3e92b = 1;
                        break;
                    }
                    
                    idx = function_f02c63b99c9614c9( loadout.loadoutperks, bannedperk );
                    loadout.loadoutperks[ idx ] = fallbackgloves;
                    continue;
                }
                else if ( var_bd1b34729a3981d5 == "footwear" )
                {
                    var_53ba7476c3429f57 = loot::function_f54ecb89dfab8e8c( getdvarint( @"hash_53905541db28577e", 27380 ) );
                    
                    if ( !isdefined( var_53ba7476c3429f57 ) || var_53ba7476c3429f57 == "" )
                    {
                        assertmsg( "<dev string:xe5>" );
                        var_b3698f4df0fcbd33 = 1;
                        var_3d7f14aeddd3e92b = 1;
                        break;
                    }
                    
                    idx = function_f02c63b99c9614c9( loadout.loadoutperks, bannedperk );
                    loadout.loadoutperks[ idx ] = var_53ba7476c3429f57;
                    continue;
                }
                else if ( var_bd1b34729a3981d5 == "gear" )
                {
                    var_a69ac3498a44f866 = loot::function_f54ecb89dfab8e8c( getdvarint( @"hash_4b76b53b637fdc12", 27396 ) );
                    var_a69ac2498a44f633 = loot::function_f54ecb89dfab8e8c( getdvarint( @"hash_526440cce2f5bb00", 27367 ) );
                    
                    if ( !isdefined( var_a69ac3498a44f866 ) || var_a69ac3498a44f866 == "" )
                    {
                        assertmsg( "<dev string:x10e>" );
                        var_b3698f4df0fcbd33 = 1;
                        var_3d7f14aeddd3e92b = 1;
                        break;
                    }
                    
                    if ( !isdefined( var_a69ac2498a44f633 ) || var_a69ac2498a44f633 == "" )
                    {
                        assertmsg( "<dev string:x133>" );
                        var_b3698f4df0fcbd33 = 1;
                        var_3d7f14aeddd3e92b = 1;
                        break;
                    }
                    
                    fallbackgear = var_a69ac3498a44f866;
                    
                    if ( isdefined( function_f02c63b99c9614c9( loadout.loadoutperks, var_a69ac3498a44f866 ) ) )
                    {
                        fallbackgear = var_a69ac2498a44f633;
                    }
                    
                    idx = function_f02c63b99c9614c9( loadout.loadoutperks, bannedperk );
                    loadout.loadoutperks[ idx ] = fallbackgear;
                    continue;
                }
            }
            
            loadout.loadoutperks = arrayremove( loadout.loadoutperks, bannedperk );
        }
        
        if ( var_f6f0fa81ba32b4ef > 1 || var_a0f7e6a0d9fae6b7 > 1 || var_bf3779007fd5e544 > 1 || var_679cfb6c6f813df0 > 2 )
        {
            var_b3698f4df0fcbd33 = 1;
            var_3d7f14aeddd3e92b = 1;
        }
        else if ( var_679cfb6c6f813df0 == 2 && ( level.perkbundles[ vestperk ].var_3289ad77b9ef2523.gearone == 0 || level.perkbundles[ vestperk ].var_3289ad77b9ef2523.geartwo == 0 ) )
        {
            if ( level.perkbundles[ vestperk ].var_3289ad77b9ef2523.gearone == 0 && level.perkbundles[ vestperk ].var_3289ad77b9ef2523.geartwo == 0 )
            {
                loadout.loadoutperks = arrayremove( loadout.loadoutperks, var_54a10836d2410b55[ 0 ] );
                loadout.loadoutperks = arrayremove( loadout.loadoutperks, var_54a10836d2410b55[ 1 ] );
            }
            else
            {
                loadout.loadoutperks = arrayremove( loadout.loadoutperks, var_54a10836d2410b55[ 1 ] );
            }
        }
    }
    
    if ( !isdefined( loadout.loadoutperks ) || replaceperkpackage == 1 )
    {
        if ( var_b71e159670bde512 )
        {
            var_b3698f4df0fcbd33 = 1;
            var_3d7f14aeddd3e92b = 1;
        }
        else
        {
            loadout = replaceperkpackage( loadout );
        }
    }
    
    if ( function_748c1d3f0ccb3d75( "wildcard_perkstreak" ) )
    {
        loadout.loadoutusingspecialist = 0;
    }
    
    if ( var_b71e159670bde512 )
    {
        if ( loadout.loadoutequipmentprimary != "none" )
        {
            if ( level.perkbundles[ vestperk ].var_3289ad77b9ef2523.lethal == 0 )
            {
                var_b3698f4df0fcbd33 = 1;
            }
            else if ( !equipment_mp::isequipmentprimary( loadout.loadoutequipmentprimary ) || !equipment_mp::isequipmentselectable( loadout.loadoutequipmentprimary ) || equipmentisrestricted( loadout.loadoutequipmentprimary ) )
            {
                loadout = namespace_aa91747accf9e514::function_57e0f5dfb9ead678( loadout );
            }
        }
        else if ( loadout.loadoutextraequipmentprimary != 0 )
        {
            if ( level.perkbundles[ vestperk ].var_3289ad77b9ef2523.lethaltwo == 0 )
            {
                var_b3698f4df0fcbd33 = 1;
            }
            else if ( !equipment_mp::isequipmentprimary( loadout.loadoutextraequipmentprimary ) || !equipment_mp::isequipmentselectable( loadout.loadoutextraequipmentprimary ) || equipmentisrestricted( loadout.loadoutextraequipmentprimary ) )
            {
                loadout = namespace_aa91747accf9e514::function_57e0f5dfb9ead678( loadout );
            }
        }
    }
    else if ( !equipment_mp::isequipmentprimary( loadout.loadoutequipmentprimary ) || !equipment_mp::isequipmentselectable( loadout.loadoutequipmentprimary ) )
    {
        loadout.loadoutequipmentprimary = fallbackloadout.var_b2a605ec88afbe46;
        loadout.loadoutEquipmentPrimaryAttachments = fallbackloadout.var_8f9811ff4f8b2570;
    }
    else if ( equipmentisrestricted( loadout.loadoutequipmentprimary ) )
    {
        loadout.loadoutequipmentprimary = fallbackloadout.var_b2a605ec88afbe46;
        loadout.loadoutEquipmentPrimaryAttachments = fallbackloadout.var_8f9811ff4f8b2570;
        restricteditemreplaced = 1;
    }
    
    if ( level.var_ac98e7cc4b10cb11 )
    {
        var_25cd9baa4bdd20fd += function_b113dedb3e85f07e( loadout, class, 0, var_3349ff2ffef57c34 );
    }
    
    if ( var_b71e159670bde512 )
    {
        if ( loadout.loadoutequipmentsecondary != "none" )
        {
            if ( level.perkbundles[ vestperk ].var_3289ad77b9ef2523.tactical == 0 )
            {
                var_b3698f4df0fcbd33 = 1;
            }
            else if ( !equipment_mp::isequipmentsecondary( loadout.loadoutequipmentsecondary ) || !equipment_mp::isequipmentselectable( loadout.loadoutequipmentsecondary ) || equipmentisrestricted( loadout.loadoutequipmentsecondary ) )
            {
                loadout = namespace_aa91747accf9e514::function_c7ed4fc5660296e8( loadout );
            }
        }
        else if ( loadout.loadoutextraequipmentsecondary != 0 )
        {
            if ( level.perkbundles[ vestperk ].var_3289ad77b9ef2523.tacticaltwo == 0 )
            {
                var_b3698f4df0fcbd33 = 1;
            }
            else if ( !equipment_mp::isequipmentsecondary( loadout.loadoutextraequipmentsecondary ) || !equipment_mp::isequipmentselectable( loadout.loadoutextraequipmentsecondary ) || equipmentisrestricted( loadout.loadoutextraequipmentsecondary ) )
            {
                loadout = namespace_aa91747accf9e514::function_c7ed4fc5660296e8( loadout );
            }
        }
    }
    else if ( !equipment_mp::isequipmentsecondary( loadout.loadoutequipmentsecondary ) || !equipment_mp::isequipmentselectable( loadout.loadoutequipmentsecondary ) )
    {
        loadout.loadoutequipmentsecondary = fallbackloadout.var_d74f6d4995ceb3ba;
        loadout.loadoutEquipmentSecondaryAttachments = fallbackloadout.var_33a08535d9321d5c;
    }
    else if ( equipmentisrestricted( loadout.loadoutequipmentsecondary ) )
    {
        loadout.loadoutequipmentsecondary = fallbackloadout.var_d74f6d4995ceb3ba;
        loadout.loadoutEquipmentSecondaryAttachments = fallbackloadout.var_33a08535d9321d5c;
        restricteditemreplaced = 1;
    }
    
    if ( level.var_ac98e7cc4b10cb11 )
    {
        var_25cd9baa4bdd20fd += function_b113dedb3e85f07e( loadout, class, 1, var_3349ff2ffef57c34 );
    }
    
    if ( level.var_613ba3e28ca2d235 )
    {
        if ( !equipment_mp::function_700ea1d803c019b8( loadout.loadoutEquipmentTertiary ) || !equipment_mp::isequipmentselectable( loadout.loadoutEquipmentTertiary ) )
        {
            loadout.loadoutEquipmentTertiary = fallbackloadout.var_9b33eed8f7cc774a;
            loadout.loadoutEquipmentTertiaryAttachments = fallbackloadout.var_7ef9f8f8563260c;
        }
        else if ( equipmentisrestricted( loadout.loadoutEquipmentTertiary ) )
        {
            loadout.loadoutEquipmentTertiary = fallbackloadout.var_9b33eed8f7cc774a;
            loadout.loadoutEquipmentTertiaryAttachments = fallbackloadout.var_7ef9f8f8563260c;
            restricteditemreplaced = 1;
        }
        
        if ( level.var_ac98e7cc4b10cb11 )
        {
            var_25cd9baa4bdd20fd += function_b113dedb3e85f07e( loadout, class, 2, var_3349ff2ffef57c34 );
        }
    }
    
    if ( var_b71e159670bde512 )
    {
        if ( level.perkbundles[ vestperk ].var_3289ad77b9ef2523.super == 0 )
        {
            if ( isdefined( loadout.loadoutfieldupgrade1 ) && loadout.loadoutfieldupgrade1 != "none" )
            {
                var_b3698f4df0fcbd33 = 1;
            }
        }
        else
        {
            banned = var_3349ff2ffef57c34 && loot::isitembannedbyref( loadout.loadoutfieldupgrade1 );
            
            if ( banned )
            {
                loadout = namespace_aa91747accf9e514::overridesuper( loadout );
            }
        }
    }
    else if ( superisrestricted( loadout.loadoutfieldupgrade1 ) )
    {
        loadout.loadoutfieldupgrade1 = fallbackloadout.var_df4518bcb104ee03;
        loadout.loadoutFieldUpgrade1Attachments = fallbackloadout.var_c123516f43e77547;
    }
    else if ( superisrestricted( loadout.loadoutfieldupgrade2 ) )
    {
        loadout.loadoutfieldupgrade2 = fallbackloadout.var_df4519bcb104f036;
        loadout.loadoutFieldUpgrade2Attachments = fallbackloadout.var_77ff83b5a333940;
    }
    
    if ( level.var_ac98e7cc4b10cb11 )
    {
        var_25cd9baa4bdd20fd += function_9a1e302d35e14ece( loadout, class, 0, var_3349ff2ffef57c34 );
        var_25cd9baa4bdd20fd += function_9a1e302d35e14ece( loadout, class, 1, var_3349ff2ffef57c34 );
    }
    
    function_c2e2d9c009e5f509( loadout, fallbackloadout );
    
    if ( var_b71e159670bde512 && var_b3698f4df0fcbd33 )
    {
        loadout = namespace_aa91747accf9e514::function_7538c728b6a4bb0b( loadout );
    }
    
    if ( isdefined( loadout.loadoutwildcard ) && function_748c1d3f0ccb3d75( loadout.loadoutwildcard ) )
    {
        loadout.loadoutwildcard = fallbackloadout.wildcard;
    }
    
    return var_25cd9baa4bdd20fd;
}

// Namespace validation
// Params 4
// Checksum 0x92aedbfc, Offset: 0x3698
// Size: 0x47f
function function_b113dedb3e85f07e( loadout, class, slotindex, var_3349ff2ffef57c34 )
{
    var_25cd9baa4bdd20fd = "";
    var_bb3ff7e06365746b = " equipment : ";
    equipref = "none";
    equipattachments = [];
    
    switch ( slotindex )
    {
        case 0:
            var_bb3ff7e06365746b = " primary_equipment : ";
            equipref = loadout.loadoutequipmentprimary;
            equipattachments = loadout.loadoutEquipmentPrimaryAttachments;
            break;
        case 1:
            var_bb3ff7e06365746b = " secondary_equipment : ";
            equipref = loadout.loadoutequipmentsecondary;
            equipattachments = loadout.loadoutEquipmentSecondaryAttachments;
            break;
        case 2:
            var_bb3ff7e06365746b = " tertiary_equipment : ";
            equipref = loadout.loadoutEquipmentTertiary;
            equipattachments = loadout.loadoutEquipmentTertiaryAttachments;
            break;
        default:
            assertmsg( "<dev string:x159>" );
            break;
    }
    
    if ( equipref != "none" && equipattachments.size > 0 )
    {
        var_92ea170e6e2fb236 = equipment_mp::getequipmenttableinfo( equipref );
        var_128567545a5fba8f = equipment_mp::function_f3104335c7fe8d43( var_92ea170e6e2fb236 );
        
        if ( isweapon( var_128567545a5fba8f ) && !isnullweapon( var_128567545a5fba8f ) )
        {
            invalidattachments = [];
            var_91100cb37d8d7417 = [];
            verifiedattachments = [];
            
            foreach ( attachment in equipattachments )
            {
                if ( function_bae3683b8b39a171( var_128567545a5fba8f, attachment ) && !attachmentisrestricted( attachment, getweaponbasename( var_128567545a5fba8f ) ) && !( var_3349ff2ffef57c34 && loot::isitembannedbyref( attachment ) ) )
                {
                    verifiedattachments[ verifiedattachments.size ] = attachment;
                    continue;
                }
                
                if ( function_bae3683b8b39a171( var_128567545a5fba8f, attachment ) && attachmentisrestricted( attachment, getweaponbasename( var_128567545a5fba8f ) ) && !( var_3349ff2ffef57c34 && loot::isitembannedbyref( attachment ) ) )
                {
                    var_91100cb37d8d7417[ var_91100cb37d8d7417.size ] = attachment;
                    continue;
                }
                
                invalidattachments[ invalidattachments.size ] = attachment;
            }
            
            if ( invalidattachments.size > 0 || var_91100cb37d8d7417.size > 0 )
            {
                if ( invalidattachments.size > 0 )
                {
                    var_25cd9baa4bdd20fd += ( equipref ?? "undefined" ) + var_bb3ff7e06365746b + "invalid attachments [ ";
                    
                    foreach ( invalidattachment in invalidattachments )
                    {
                        var_25cd9baa4bdd20fd += ( invalidattachment ?? "undefined" ) + " ";
                    }
                    
                    var_25cd9baa4bdd20fd += "], ";
                }
                
                switch ( slotindex )
                {
                    case 0:
                        loadout.loadoutEquipmentPrimaryAttachments = verifiedattachments;
                        break;
                    case 1:
                        loadout.loadoutEquipmentSecondaryAttachments = verifiedattachments;
                        break;
                    case 2:
                        loadout.loadoutEquipmentTertiaryAttachments = verifiedattachments;
                        break;
                    default:
                        break;
                }
            }
        }
        else
        {
            var_25cd9baa4bdd20fd += ( equipref ?? "undefined" ) + var_bb3ff7e06365746b + "cannot find valid weapon object, ";
            
            switch ( slotindex )
            {
                case 0:
                    loadout.loadoutEquipmentPrimaryAttachments = [];
                    break;
                case 1:
                    loadout.loadoutEquipmentSecondaryAttachments = [];
                    break;
                case 2:
                    loadout.loadoutEquipmentTertiaryAttachments = [];
                    break;
                default:
                    break;
            }
        }
    }
    else
    {
        switch ( slotindex )
        {
            case 0:
                loadout.loadoutEquipmentPrimaryAttachments = [];
                break;
            case 1:
                loadout.loadoutEquipmentSecondaryAttachments = [];
                break;
            case 2:
                loadout.loadoutEquipmentTertiaryAttachments = [];
                break;
            default:
                break;
        }
    }
    
    return var_25cd9baa4bdd20fd;
}

// Namespace validation
// Params 4
// Checksum 0x4841a2e5, Offset: 0x3b20
// Size: 0x45e
function function_9a1e302d35e14ece( loadout, class, slotindex, var_3349ff2ffef57c34 )
{
    var_25cd9baa4bdd20fd = "";
    var_bb3ff7e06365746b = " field_upgrade : ";
    superref = "none";
    superattachments = [];
    
    switch ( slotindex )
    {
        case 0:
            var_bb3ff7e06365746b = " field_upgrade_1 : ";
            superref = loadout.loadoutfieldupgrade1;
            superattachments = loadout.loadoutFieldUpgrade1Attachments;
            break;
        case 1:
            var_bb3ff7e06365746b = " field_upgrade_2 : ";
            superref = loadout.loadoutfieldupgrade2;
            superattachments = loadout.loadoutFieldUpgrade2Attachments;
            break;
        default:
            assertmsg( "<dev string:x190>" );
            break;
    }
    
    if ( superref != "none" && superattachments.size > 0 )
    {
        var_deab6db716beff4b = supers_mp::function_4b7b32d1d5b0c427( superref );
        var_4588ed7d75a32bf6 = var_deab6db716beff4b.objweapon;
        
        if ( var_deab6db716beff4b.weapon == %"super_default_mp" || var_deab6db716beff4b.weapon == %"super_minor_default_mp" )
        {
            if ( var_deab6db716beff4b.weapontype == "BULLETWEAPON" && var_deab6db716beff4b.useweapon )
            {
                var_4588ed7d75a32bf6 = var_deab6db716beff4b.useweapon;
            }
        }
        
        if ( isweapon( var_4588ed7d75a32bf6 ) && !isnullweapon( var_4588ed7d75a32bf6 ) )
        {
            invalidattachments = [];
            var_91100cb37d8d7417 = [];
            verifiedattachments = [];
            
            foreach ( attachment in superattachments )
            {
                if ( function_bae3683b8b39a171( var_4588ed7d75a32bf6, attachment ) && !attachmentisrestricted( attachment, getweaponbasename( var_4588ed7d75a32bf6 ) ) && !( var_3349ff2ffef57c34 && loot::isitembannedbyref( attachment ) ) )
                {
                    verifiedattachments[ verifiedattachments.size ] = attachment;
                    continue;
                }
                
                if ( function_bae3683b8b39a171( var_4588ed7d75a32bf6, attachment ) && attachmentisrestricted( attachment, getweaponbasename( var_4588ed7d75a32bf6 ) ) && !( var_3349ff2ffef57c34 && loot::isitembannedbyref( attachment ) ) )
                {
                    var_91100cb37d8d7417[ var_91100cb37d8d7417.size ] = attachment;
                    continue;
                }
                
                invalidattachments[ invalidattachments.size ] = attachment;
            }
            
            if ( invalidattachments.size > 0 || var_91100cb37d8d7417.size > 0 )
            {
                if ( invalidattachments.size > 0 )
                {
                    var_25cd9baa4bdd20fd += ( superref ?? "undefined" ) + var_bb3ff7e06365746b + "invalid attachments [ ";
                    
                    foreach ( invalidattachment in invalidattachments )
                    {
                        var_25cd9baa4bdd20fd += ( invalidattachment ?? "undefined" ) + " ";
                    }
                    
                    var_25cd9baa4bdd20fd += "], ";
                }
                
                switch ( slotindex )
                {
                    case 0:
                        loadout.loadoutFieldUpgrade1Attachments = verifiedattachments;
                        break;
                    case 1:
                        loadout.loadoutFieldUpgrade2Attachments = verifiedattachments;
                        break;
                    default:
                        break;
                }
            }
        }
        else
        {
            var_25cd9baa4bdd20fd += ( superref ?? "undefined" ) + var_bb3ff7e06365746b + "cannot find valid weapon object, ";
            
            switch ( slotindex )
            {
                case 0:
                    loadout.loadoutFieldUpgrade1Attachments = [];
                    break;
                case 1:
                    loadout.loadoutFieldUpgrade2Attachments = [];
                    break;
                default:
                    break;
            }
        }
    }
    else
    {
        switch ( slotindex )
        {
            case 0:
                loadout.loadoutFieldUpgrade1Attachments = [];
                break;
            case 1:
                loadout.loadoutFieldUpgrade2Attachments = [];
                break;
            default:
                break;
        }
    }
    
    return var_25cd9baa4bdd20fd;
}

// Namespace validation
// Params 1
// Checksum 0x37ad899c, Offset: 0x3f87
// Size: 0x1b
function validatekillstreaks( loadout )
{
    function_c2e2d9c009e5f509( loadout, function_b7ff987740639b18() );
}

// Namespace validation
// Params 2, eflags: 0x4
// Checksum 0x7c88e44b, Offset: 0x3faa
// Size: 0x88e
function private function_c2e2d9c009e5f509( loadout, fallbackloadout )
{
    if ( getdvarint( @"hash_b3ea759858e46e8e", 0 ) || level.gametypebundle.var_c6111448f0b1fb58 )
    {
        return;
    }
    
    replacekillstreaks = 0;
    isanymlgmatch = game_utility_mp::isanymlgmatch();
    var_3349ff2ffef57c34 = istrue( getdvarint( @"scr_loadout_validate_banned_items", 0 ) );
    
    if ( !isanymlgmatch && ( loadout.loadoutkillstreak1 == "none" || loadout.loadoutkillstreak2 == "none" || loadout.loadoutkillstreak3 == "none" ) )
    {
        replacekillstreaks = 1;
    }
    
    if ( !replacekillstreaks )
    {
        bundle = level.streakglobals.streakbundles[ loadout.loadoutkillstreak1 ];
        
        if ( !( isanymlgmatch && loadout.loadoutkillstreak1 == "none" ) && !bundle.var_883566fc1e9d2da3 )
        {
            replacekillstreaks = 1;
        }
        
        bundle = level.streakglobals.streakbundles[ loadout.loadoutkillstreak2 ];
        
        if ( !( isanymlgmatch && loadout.loadoutkillstreak2 == "none" ) && !bundle.var_883566fc1e9d2da3 )
        {
            replacekillstreaks = 1;
        }
        
        bundle = level.streakglobals.streakbundles[ loadout.loadoutkillstreak3 ];
        
        if ( !( isanymlgmatch && loadout.loadoutkillstreak3 == "none" ) && !bundle.var_883566fc1e9d2da3 )
        {
            replacekillstreaks = 1;
        }
    }
    
    if ( !replacekillstreaks )
    {
        if ( killstreakisrestricted( loadout.loadoutkillstreak1 ) || var_3349ff2ffef57c34 && loot::isitembannedbyref( loadout.loadoutkillstreak1 ) )
        {
            loadout.loadoutkillstreak1 = fallbackloadout.fallbackkillstreaks[ 0 ];
            restricteditemreplaced = 1;
        }
        
        if ( killstreakisrestricted( loadout.loadoutkillstreak2 ) || var_3349ff2ffef57c34 && loot::isitembannedbyref( loadout.loadoutkillstreak2 ) )
        {
            loadout.loadoutkillstreak2 = fallbackloadout.fallbackkillstreaks[ 1 ];
            restricteditemreplaced = 1;
        }
        
        if ( killstreakisrestricted( loadout.loadoutkillstreak3 ) || var_3349ff2ffef57c34 && loot::isitembannedbyref( loadout.loadoutkillstreak3 ) )
        {
            loadout.loadoutkillstreak3 = fallbackloadout.fallbackkillstreaks[ 2 ];
            restricteditemreplaced = 1;
        }
    }
    
    if ( !replacekillstreaks && level.var_ac98e7cc4b10cb11 )
    {
        var_b7290c3fe281a35f = level.vintageModeEnabled;
        loadout.loadoutkillstreak1 = function_d522d7a366c9e4f5( loadout.loadoutkillstreak1, fallbackloadout.fallbackkillstreaks[ 0 ], var_3349ff2ffef57c34, var_b7290c3fe281a35f );
        loadout.loadoutkillstreak2 = function_d522d7a366c9e4f5( loadout.loadoutkillstreak2, fallbackloadout.fallbackkillstreaks[ 1 ], var_3349ff2ffef57c34, var_b7290c3fe281a35f );
        loadout.loadoutkillstreak3 = function_d522d7a366c9e4f5( loadout.loadoutkillstreak3, fallbackloadout.fallbackkillstreaks[ 2 ], var_3349ff2ffef57c34, var_b7290c3fe281a35f );
    }
    
    if ( !replacekillstreaks )
    {
        if ( loadout.loadoutkillstreak1 == loadout.loadoutkillstreak2 && loadout.loadoutkillstreak1 != "none" )
        {
            replacekillstreaks = 1;
        }
        else if ( loadout.loadoutkillstreak1 == loadout.loadoutkillstreak3 && loadout.loadoutkillstreak1 != "none" )
        {
            replacekillstreaks = 1;
        }
        else if ( loadout.loadoutkillstreak2 == loadout.loadoutkillstreak3 && loadout.loadoutkillstreak2 != "none" )
        {
            replacekillstreaks = 1;
        }
    }
    
    if ( !replacekillstreaks )
    {
        if ( level.gamemodebundle.streaktypeenabled )
        {
            streaktype = killstreaks::getstreaktype( loadout );
            var_5ee8454ece2dbf6f = killstreak_utility::function_87741a4d2a352cec( loadout.loadoutkillstreak1 );
            var_5ee8464ece2dc1a2 = killstreak_utility::function_87741a4d2a352cec( loadout.loadoutkillstreak2 );
            var_5ee8474ece2dc3d5 = killstreak_utility::function_87741a4d2a352cec( loadout.loadoutkillstreak3 );
            cost1 = getscriptbundlefieldvalue( var_5ee8454ece2dbf6f, streaktype.cost_field ) ?? 0;
            cost2 = getscriptbundlefieldvalue( var_5ee8464ece2dc1a2, streaktype.cost_field ) ?? 0;
            cost3 = getscriptbundlefieldvalue( var_5ee8474ece2dc3d5, streaktype.cost_field ) ?? 0;
            assert( cost1, getscriptbundlefieldvalue( var_5ee8454ece2dbf6f, #"hash_fac9242d98a23ee8" ) + "<dev string:x1ce>" + streaktype.cost_field + "<dev string:x1f2>" + cost1 + "<dev string:x1f7>" );
            assert( cost2, getscriptbundlefieldvalue( var_5ee8464ece2dc1a2, #"hash_fac9242d98a23ee8" ) + "<dev string:x1ce>" + streaktype.cost_field + "<dev string:x1f2>" + cost2 + "<dev string:x1f7>" );
            assert( cost3, getscriptbundlefieldvalue( var_5ee8474ece2dc3d5, #"hash_fac9242d98a23ee8" ) + "<dev string:x1ce>" + streaktype.cost_field + "<dev string:x1f2>" + cost3 + "<dev string:x1f7>" );
        }
        else if ( level.gamemodebundle.streakearn == #"score" )
        {
            bundle = level.streakglobals.streakbundles[ loadout.loadoutkillstreak1 ];
            cost1 = bundle.scorecost ?? 0;
            bundle = level.streakglobals.streakbundles[ loadout.loadoutkillstreak2 ];
            cost2 = bundle.scorecost ?? 0;
            bundle = level.streakglobals.streakbundles[ loadout.loadoutkillstreak3 ];
            cost3 = bundle.scorecost ?? 0;
        }
        else
        {
            bundle = level.streakglobals.streakbundles[ loadout.loadoutkillstreak1 ];
            cost1 = bundle.kills ?? 0;
            bundle = level.streakglobals.streakbundles[ loadout.loadoutkillstreak2 ];
            cost2 = bundle.kills ?? 0;
            bundle = level.streakglobals.streakbundles[ loadout.loadoutkillstreak3 ];
            cost3 = bundle.kills ?? 0;
        }
        
        if ( cost1 != 0 && cost1 == cost2 )
        {
            replacekillstreaks = 1;
        }
        else if ( cost1 != 0 && cost1 == cost3 )
        {
            replacekillstreaks = 1;
        }
        else if ( cost2 != 0 && cost2 == cost3 )
        {
            replacekillstreaks = 1;
        }
    }
    
    if ( getdvarint( @"elt_killstreaks", 0 ) > 0 )
    {
        replacekillstreaks = 0;
    }
    
    if ( replacekillstreaks )
    {
        if ( level.gamemodebundle.streaktypeenabled )
        {
            loadout.loadoutstreaktype = killstreaks::getstreaktype();
        }
        
        loadout.loadoutkillstreak1 = fallbackloadout.fallbackkillstreaks[ 0 ];
        loadout.loadoutkillstreak2 = fallbackloadout.fallbackkillstreaks[ 1 ];
        loadout.loadoutkillstreak3 = fallbackloadout.fallbackkillstreaks[ 2 ];
        loadout.loadoutKillstreak1BlueprintIndex = 0;
        loadout.loadoutKillstreak2BlueprintIndex = 0;
        loadout.loadoutKillstreak3BlueprintIndex = 0;
    }
    
    if ( level.gametype == "conf_v" )
    {
        loadout.loadoutkillstreak1 = "none";
        loadout.loadoutkillstreak2 = "electric_discharge";
        loadout.loadoutkillstreak3 = "laser_charge";
    }
    
    if ( level.var_9394f65c684e87fb )
    {
        loadout.loadoutkillstreak1 = getdvar( hashcat( @"hash_7129c8b31055dff8", 1 ), "switchblade_drone" );
        loadout.loadoutkillstreak2 = getdvar( hashcat( @"hash_7129c8b31055dff8", 2 ), "cruise_predator" );
        loadout.loadoutkillstreak3 = getdvar( hashcat( @"hash_7129c8b31055dff8", 3 ), "fuel_airstrike" );
    }
    
    return loadout;
}

// Namespace validation
// Params 4, eflags: 0x4
// Checksum 0xda33e4f4, Offset: 0x4841
// Size: 0x9a
function private function_d522d7a366c9e4f5( ksref, fallback, var_3349ff2ffef57c34, var_b7290c3fe281a35f )
{
    bundle = killstreak::function_85b2d8e857ab4898( ksref );
    
    if ( bundle.var_f306b2ded8a0a34c )
    {
        if ( function_3d2874ededc5b56a( bundle.var_f306b2ded8a0a34c ) || var_3349ff2ffef57c34 && loot::isitembannedbyref( bundle.var_f306b2ded8a0a34c ) )
        {
            if ( var_b7290c3fe281a35f )
            {
                self.pers[ #"hash_5358b5a919fe00a6" ][ ksref ] = undefined;
            }
            else
            {
                ksref = fallback;
            }
        }
    }
    
    return ksref;
}

// Namespace validation
// Params 1
// Checksum 0xb6b4feb1, Offset: 0x48e4
// Size: 0x41f
function function_433259b02f4ab842( struct )
{
    if ( getdvarint( @"scr_validate_assert_weapons", 0 ) == 0 )
    {
        return;
    }
    
    if ( isbot( self ) && !getdvarint( @"hash_6608fe8c037cc532", 0 ) )
    {
        return;
    }
    
    userid = player::getuniqueid();
    
    if ( !isdefined( userid ) )
    {
        userid = "UNKNOWN";
    }
    
    if ( level.tertiaryweaponslotenabled )
    {
        if ( isdefined( struct.var_9dcef9a8722c3abb ) && struct.var_9dcef9a8722c3abb != level.weaponnone )
        {
            tertiaryfound = 0;
            
            foreach ( weapon in self.primaryinventory )
            {
                if ( weapon == struct.var_9dcef9a8722c3abb )
                {
                    tertiaryfound = 1;
                    break;
                }
            }
            
            var_acf0d50e485d65b9 = 0;
            
            foreach ( weapon in self.meleeweapons )
            {
                if ( weapon == struct.var_9dcef9a8722c3abb )
                {
                    var_acf0d50e485d65b9 = 1;
                    break;
                }
            }
            
            assert( tertiaryfound, "<dev string:x1f9>" + userid + "<dev string:x21c>" + struct.loadouttertiary + "<dev string:x1f7>" );
            
            if ( tertiaryfound && !var_acf0d50e485d65b9 )
            {
                assertmsg( "<dev string:x241>" );
            }
        }
    }
    else
    {
        assert( !isdefined( struct.var_9dcef9a8722c3abb ), "<dev string:x288>" );
    }
    
    var_b8ea9717c7d162e1 = 0;
    var_e8131e3f43557178 = isdefined( struct.loadoutprimaryobject ) && weapon::isprimaryweapon( struct.loadoutprimaryobject );
    var_b56a73c2e92ebf6f = struct.loadoutprimaryobject == struct.loadoutsecondaryobject;
    
    if ( var_b56a73c2e92ebf6f )
    {
        var_b8ea9717c7d162e1--;
    }
    
    if ( var_e8131e3f43557178 )
    {
        var_b8ea9717c7d162e1++;
    }
    
    if ( isdefined( struct.loadoutsecondaryobject ) && struct.loadoutsecondaryobject.basename != "none" )
    {
        var_b8ea9717c7d162e1++;
    }
    
    if ( isdefined( struct.var_183fb1979f9b8498 ) && !struct.disablebackuppistol )
    {
        var_b8ea9717c7d162e1++;
    }
    
    if ( self.primaryweapons.size < var_b8ea9717c7d162e1 )
    {
        assertmsg( "<dev string:x1f9>" + userid + "<dev string:x2f4>" );
        return;
    }
    
    var_9542a293f548877f = self.primaryweapons[ 0 ];
    var_9542a193f548854c = self.primaryweapons[ 1 ];
    hasprimaryweapon = 1;
    
    if ( var_e8131e3f43557178 && var_9542a293f548877f != struct.loadoutprimaryobject )
    {
        if ( var_9542a193f548854c != struct.loadoutprimaryobject )
        {
            hasprimaryweapon = 0;
            assertmsg( "<dev string:x31b>" + userid + "<dev string:x340>" );
        }
        else
        {
            println( "<dev string:x366>" + userid + "<dev string:x38c>" );
        }
    }
    
    if ( isdefined( struct.loadoutsecondaryobject ) && struct.loadoutsecondaryobject.basename != "none" )
    {
        if ( !( hasprimaryweapon && var_b56a73c2e92ebf6f ) && var_9542a193f548854c != struct.loadoutsecondaryobject )
        {
            if ( var_9542a293f548877f != struct.loadoutsecondaryobject )
            {
                assertmsg( "<dev string:x31b>" + userid + "<dev string:x3ae>" );
            }
            else
            {
                println( "<dev string:x366>" + userid + "<dev string:x3d6>" );
            }
        }
        
        return;
    }
    
    println( "<dev string:x366>" + userid + "<dev string:x3fa>" );
}

// Namespace validation
// Params 8
// Checksum 0xb4f05cf, Offset: 0x4d0b
// Size: 0x2fe
function validateweapon( validationdata, weapon, attachments, camo, reticle, lootitemid, variantid, issecondary )
{
    rootweaponname = weapon::getweaponrootname( weapon );
    var_1705a60a4de538e4 = weapon::iscacsecondaryweapon( weapon );
    weaponslot = issecondary ? "secondary" : "primary";
    itemslot = issecondary ? 4 : 1;
    
    if ( isdefined( weapon ) && weapon != "none" && !weapon::isfistweapon( weapon ) )
    {
        validationdata.pointcost++;
        
        if ( issecondary )
        {
            if ( !var_1705a60a4de538e4 )
            {
                validationdata.pointcost++;
                validationdata.wildcards[ "overkill" ] = 1;
            }
        }
        else if ( var_1705a60a4de538e4 )
        {
            validationerror( "secondaryAsPrimary", undefined, weapon );
            validationdata.invaliditems[ itemslot ] = 1;
        }
        
        if ( !weapon::weapondefinedinstatstable( rootweaponname ) )
        {
            validationerror( "unknownWeapon", weaponslot, weapon );
            validationdata.invaliditems[ itemslot ] = 1;
        }
        else if ( level.weaponmapdata[ rootweaponname ].uihidden )
        {
            validationerror( "unreleasedWeapon", weaponslot, weapon );
            validationdata.invaliditems[ itemslot ] = 1;
        }
        
        if ( !isitemunlocked( rootweaponname, "weapon" ) && !weaponunlocksvialoot( rootweaponname ) )
        {
            validationerror( "lockedWeapon", weaponslot, weapon );
            validationdata.invaliditems[ itemslot ] = 1;
        }
        
        if ( lootitemid == 0 )
        {
            if ( variantid != -1 )
            {
                validationerror( "emptyItemIDMismatch", weaponslot, weapon );
                validationdata.invaliditems[ itemslot ] = 1;
            }
        }
        else if ( variantid == -1 )
        {
            validationerror( "emptyVariantIDMismatch", weaponslot, weapon );
            validationdata.invaliditems[ itemslot ] = 1;
        }
        else
        {
            if ( !loot_mp::isweaponitem( lootitemid ) )
            {
                validationerror( "nonWeaponLootItemID", weaponslot, weapon );
                validationdata.invaliditems[ itemslot ] = 1;
            }
            
            var_91e96db701f8fac8 = loot_mp::getlootweaponref( lootitemid );
            
            if ( !isdefined( var_91e96db701f8fac8 ) )
            {
                validationerror( "badLootItemID", weaponslot, weapon );
                validationdata.invaliditems[ itemslot ] = 1;
            }
            else
            {
                variantref = loot_mp::lookupvariantref( weapon, variantid );
                
                if ( !isdefined( variantref ) )
                {
                    validationerror( "badVariantRef", weaponslot, weapon );
                    validationdata.invaliditems[ itemslot ] = 1;
                }
                else if ( variantref != var_91e96db701f8fac8 )
                {
                    validationerror( "lootDataMismatch", weaponslot, weapon );
                    validationdata.invaliditems[ itemslot ] = 1;
                }
            }
        }
        
        validateattachments( validationdata, attachments, weapon, rootweaponname, weaponslot );
    }
}

// Namespace validation
// Params 5
// Checksum 0x421c63eb, Offset: 0x5011
// Size: 0x2be
function validateattachments( validationdata, attachments, weapon, rootweaponname, weaponslot )
{
    weapongroup = weapon::weapongroupmap( weapon );
    unlockcategory = getsubstr( weapongroup, 7 ) + "Attach";
    itemslot = weaponslot == "primary" ? 2 : 5;
    var_ad92f966f6773005 = 0;
    var_f2664b87d796a072 = 0;
    var_6b30e911ce93f97e = weaponslot == "primary" ? 2 : 2;
    
    foreach ( attachmentindex, attachment in attachments )
    {
        isoptic = 0;
        
        if ( isdefined( attachment ) && attachment != "none" )
        {
            attachmenttype = weapon::getattachmenttype( attachment );
            
            if ( attachmenttype )
            {
                if ( isdefined( attachment ) )
                {
                    if ( attachmenttype == "rail" )
                    {
                        isoptic = 1;
                    }
                }
            }
            
            unlockitem = rootweaponname + "+" + attachment;
            
            if ( !isitemunlocked( unlockitem, unlockcategory ) )
            {
                validationerror( "lockedAttachment", weaponslot, attachment );
                validationdata.invaliditems[ itemslot ][ validationdata.invaliditems[ itemslot ].size ] = attachmentindex;
            }
            
            if ( !weapon::attachmentisselectable( rootweaponname, attachment ) )
            {
                validationerror( "nonSelectableAttachment", weaponslot, attachment );
                validationdata.invaliditems[ itemslot ][ validationdata.invaliditems[ itemslot ].size ] = attachmentindex;
            }
            
            if ( isoptic )
            {
                var_ad92f966f6773005++;
                validationdata.pointcost++;
                continue;
            }
            
            var_f2664b87d796a072++;
            
            if ( var_f2664b87d796a072 <= var_6b30e911ce93f97e )
            {
                validationdata.pointcost++;
                continue;
            }
            
            validationdata.wildcards[ weaponslot + "_attachment_" + var_f2664b87d796a072 + 1 ] = 1;
            validationdata.pointcost += 2;
        }
    }
    
    if ( var_f2664b87d796a072 > 5 )
    {
        validationerror( "tooManyAttachments", weaponslot, var_f2664b87d796a072 );
        validationdata.invaliditems[ weaponslot == "primary" ? 3 : 6 ] = 1;
    }
    
    if ( var_ad92f966f6773005 > 1 )
    {
        validationerror( "tooManyOpticAttachments", weaponslot, var_ad92f966f6773005 );
        validationdata.invaliditems[ weaponslot == "primary" ? 3 : 6 ] = 1;
    }
}

// Namespace validation
// Params 3
// Checksum 0xb1dabf17, Offset: 0x52d7
// Size: 0x2a7
function validateperks( validationdata, perks, archetype )
{
    perkcounts = [];
    perkcounts[ 1 ] = 0;
    perkcounts[ 2 ] = 0;
    perkcounts[ 3 ] = 0;
    
    foreach ( perk in perks )
    {
        if ( isdefined( perk ) && perk != "none" )
        {
            if ( !perks::function_ae69f867e887ac4a( perk ) )
            {
                validationerror( "invalidPerk", undefined, perk );
                validationdata.invaliditems[ 9 ][ validationdata.invaliditems[ 9 ].size ] = perk;
            }
            
            slot = perks::getperkslot( perk );
            
            if ( isdefined( slot ) )
            {
                perkcounts[ slot ]++;
                
                if ( perkcounts[ slot ] > 2 )
                {
                    validationerror( "tooManyPerks", slot, perk );
                    validationdata.invaliditems[ 9 ][ validationdata.invaliditems[ 9 ].size ] = perk;
                }
                
                if ( !isitemunlocked( perk, "perk" ) )
                {
                    validationerror( "lockedPerk", slot, perk );
                    validationdata.invaliditems[ 9 ][ validationdata.invaliditems[ 9 ].size ] = perk;
                }
                
                if ( perkcounts[ slot ] == 1 )
                {
                    validationdata.pointcost++;
                }
                else
                {
                    validationdata.wildcards[ "extra_perk_" + slot ] = 1;
                    validationdata.pointcost += 2;
                }
                
                continue;
            }
            
            if ( isdefined( level.menurigperks[ perk ] ) )
            {
                if ( level.menurigperks[ perk ].archetype != archetype )
                {
                    validationerror( "rigPerkOnWrongRig", undefined, perk );
                    validationdata.invaliditems[ 9 ][ validationdata.invaliditems[ 9 ].size ] = perk;
                }
                
                if ( !isitemunlocked( perk, "trait" ) )
                {
                    validationerror( "lockedRigPerk", slot, perk );
                    validationdata.invaliditems[ 9 ][ validationdata.invaliditems[ 9 ].size ] = perk;
                }
                
                continue;
            }
            
            validationerror( "unknownPerkType", undefined, perk );
            validationdata.invaliditems[ 9 ][ validationdata.invaliditems[ 9 ].size ] = perk;
        }
    }
}

// Namespace validation
// Params 4
// Checksum 0x691b785, Offset: 0x5586
// Size: 0x1c4
function validatestreaks( validationdata, streak1, streak2, streak3 )
{
    streaks = [ streak1, streak2, streak3 ];
    
    foreach ( streak in streaks )
    {
        if ( streak == "none" )
        {
            continue;
        }
        
        setupinfo = killstreaks::getkillstreaksetupinfo( streak );
        
        if ( !isdefined( setupinfo ) )
        {
            validationerror( "unknownStreak", undefined, streak );
            validationdata.invaliditems[ 12 ] = 1;
        }
        
        if ( !isitemunlocked( streak, "killstreak" ) )
        {
            validationerror( "lockedStreak", undefined, streak );
            validationdata.invaliditems[ 12 ] = 1;
        }
    }
    
    if ( streak1 == streak2 && streak1 != "none" )
    {
        validationerror( "duplicateStreak", undefined, streak1 );
        validationdata.invaliditems[ 12 ] = 1;
        return;
    }
    
    if ( streak1 == streak3 && streak1 != "none" )
    {
        validationerror( "duplicateStreak", undefined, streak1 );
        validationdata.invaliditems[ 12 ] = 1;
        return;
    }
    
    if ( streak2 == streak3 && streak2 != "none" )
    {
        validationerror( "duplicateStreak", undefined, streak2 );
        validationdata.invaliditems[ 12 ] = 1;
    }
}

// Namespace validation
// Params 2
// Checksum 0xc9ad499c, Offset: 0x5752
// Size: 0x77
function validatearchetype( validationdata, archetype )
{
    if ( !isdefined( level.archetypeids[ archetype ] ) )
    {
        validationerror( "unknownArchetype", undefined, archetype );
        validationdata.invaliditems[ 10 ] = 1;
    }
    
    if ( !isitemunlocked( archetype, "rig" ) )
    {
        validationerror( "lockedArchetype", undefined, archetype );
        validationdata.invaliditems[ 10 ] = 1;
    }
}

// Namespace validation
// Params 2
// Checksum 0xd1cd8aa6, Offset: 0x57d1
// Size: 0xa3
function validatesuper( validationdata, super )
{
    if ( !isdefined( super ) || super == "none" )
    {
        return;
    }
    
    superdata = level.superglobals.staticsuperdata[ super ];
    
    if ( !isdefined( superdata ) )
    {
        validationerror( "unknownSuper", undefined, super );
        validationdata.invaliditems[ 11 ] = 1;
    }
    
    if ( !isitemunlocked( super, "super" ) )
    {
        validationerror( "lockedSuper", undefined, super );
        validationdata.invaliditems[ 11 ] = 1;
    }
}

// Namespace validation
// Params 1
// Checksum 0xaebd3086, Offset: 0x587c
// Size: 0xc
function validatewildcards( validationdata )
{
    
}

// Namespace validation
// Params 1
// Checksum 0x71dfaa5, Offset: 0x5890
// Size: 0x42
function fixloadout( loadout )
{
    newloadout = class::loadout_getclassstruct();
    newloadout.loadoutarchetype = "archetype_assault";
    newloadout.loadoutprimary = "iw9_ar_mike4";
    return newloadout;
}

// Namespace validation
// Params 2
// Checksum 0xc37bb1ca, Offset: 0x58db
// Size: 0x1d7
function fixweapon( loadout, weaponslot )
{
    assert( isxhash( weaponslot ) );
    
    if ( weaponslot == #"primary" )
    {
        loadout.loadoutprimary = "iw9_ar_mike4";
        loadout.loadoutprimarycamo = "none";
        loadout.loadoutprimaryreticle = "none";
        loadout.loadoutprimarylootitemid = 0;
        loadout.loadoutprimaryvariantid = -1;
        maxprimaryattachments = weapon::function_45ab75ece154ca8f();
        
        for ( attachindex = 0; attachindex < maxprimaryattachments ; attachindex++ )
        {
            loadout.loadoutprimaryattachments[ attachindex ] = "none";
        }
        
        return;
    }
    
    if ( weaponslot == #"secondary" )
    {
        loadout.loadoutsecondary = "none";
        loadout.loadoutsecondarycamo = "none";
        loadout.loadoutsecondaryreticle = "none";
        loadout.loadoutsecondarylootitemid = 0;
        loadout.loadoutsecondaryvariantid = -1;
        maxsecondaryattachments = weapon::function_a7a39da0cf2d5b5b();
        
        for ( attachindex = 0; attachindex < maxsecondaryattachments ; attachindex++ )
        {
            loadout.loadoutsecondaryattachments[ attachindex ] = "none";
        }
        
        return;
    }
    
    loadout.loadouttertiary = "none";
    loadout.loadouttertiarycamo = "none";
    loadout.loadouttertiaryreticle = "none";
    loadout.loadoutTertiaryLootItemID = 0;
    loadout.loadouttertiaryvariantid = -1;
    var_dc1543b984237bf8 = weapon::function_bedf9f9cfa13920d();
    
    for ( attachindex = 0; attachindex < var_dc1543b984237bf8 ; attachindex++ )
    {
        loadout.loadoutTertiaryAttachments[ attachindex ] = "none";
    }
}

// Namespace validation
// Params 3
// Checksum 0x49130e4d, Offset: 0x5aba
// Size: 0x8c
function fixattachment( loadout, weaponslot, attachmentindex )
{
    assert( isxhash( weaponslot ) );
    
    if ( weaponslot == #"primary" )
    {
        loadout.loadoutprimaryattachments[ attachmentindex ] = "none";
        return;
    }
    
    if ( weaponslot == #"secondary" )
    {
        loadout.loadoutsecondaryattachments[ attachmentindex ] = "none";
        return;
    }
    
    loadout.loadoutTertiaryAttachments[ attachmentindex ] = "none";
}

// Namespace validation
// Params 2
// Checksum 0x9cf6d1ce, Offset: 0x5b4e
// Size: 0x5f
function fixpower( loadout, powerslot )
{
    if ( powerslot == "primary" )
    {
        loadout.loadoutpowerprimary = "none";
        loadout.loadoutextrapowerprimary = 0;
        return;
    }
    
    loadout.loadoutpowersecondary = "none";
    loadout.loadoutextrapowersecondary = 0;
}

// Namespace validation
// Params 2
// Checksum 0x45a5e27e, Offset: 0x5bb5
// Size: 0x32
function fixperk( loadout, perk )
{
    loadout.loadoutperks = arrayremove( loadout.loadoutperks, perk );
}

// Namespace validation
// Params 1
// Checksum 0xa2262314, Offset: 0x5bef
// Size: 0x3f
function fixkillstreaks( loadout )
{
    loadout.loadoutkillstreak1 = "none";
    loadout.loadoutkillstreak2 = "none";
    loadout.loadoutkillstreak3 = "none";
}

// Namespace validation
// Params 1
// Checksum 0x56936815, Offset: 0x5c36
// Size: 0xb5
function fixarchetype( loadout )
{
    loadout.loadoutarchetype = "archetype_assault";
    fixsuper( loadout );
    
    foreach ( perk in loadout.loadoutperks )
    {
        if ( isdefined( level.menurigperks[ perk ] ) )
        {
            fixperk( loadout, perk );
            break;
        }
    }
}

// Namespace validation
// Params 1
// Checksum 0x2f0ba9ed, Offset: 0x5cf3
// Size: 0x1d
function fixsuper( loadout )
{
    loadout.loadoutsuper = "none";
}

// Namespace validation
// Params 2
// Checksum 0x98fef400, Offset: 0x5d18
// Size: 0x2b8
function fixinvaliditems( loadout, invaliditems )
{
    if ( isdefined( invaliditems[ 0 ] ) )
    {
        loadout = fixloadout( loadout );
        return loadout;
    }
    
    if ( isdefined( invaliditems[ 1 ] ) )
    {
        fixweapon( loadout, #"primary" );
    }
    else if ( isdefined( invaliditems[ 3 ] ) )
    {
        maxprimaryattachments = weapon::function_45ab75ece154ca8f();
        
        for ( attachindex = 0; attachindex < maxprimaryattachments ; attachindex++ )
        {
            fixattachment( loadout, #"primary", attachindex );
        }
    }
    else
    {
        foreach ( attachindex in invaliditems[ 2 ] )
        {
            fixattachment( loadout, #"primary", attachindex );
        }
    }
    
    if ( isdefined( invaliditems[ 4 ] ) )
    {
        fixweapon( loadout, #"secondary" );
    }
    else if ( isdefined( invaliditems[ 6 ] ) )
    {
        maxsecondaryattachments = weapon::function_a7a39da0cf2d5b5b();
        
        for ( attachindex = 0; attachindex < maxsecondaryattachments ; attachindex++ )
        {
            fixattachment( loadout, #"secondary", attachindex );
        }
    }
    else
    {
        foreach ( attachindex in invaliditems[ 5 ] )
        {
            fixattachment( loadout, #"secondary", attachindex );
        }
    }
    
    if ( level.tertiaryweaponslotenabled )
    {
    }
    
    if ( isdefined( invaliditems[ 7 ] ) )
    {
        fixpower( loadout, "primary" );
    }
    
    if ( isdefined( invaliditems[ 8 ] ) )
    {
        fixpower( loadout, "secondary" );
    }
    
    foreach ( perk in invaliditems[ 9 ] )
    {
        fixperk( loadout, perk );
    }
    
    if ( isdefined( invaliditems[ 10 ] ) )
    {
        fixarchetype( loadout );
    }
    else if ( isdefined( invaliditems[ 11 ] ) )
    {
        fixarchetype( loadout );
    }
    
    if ( isdefined( invaliditems[ 12 ] ) )
    {
        fixkillstreaks( loadout );
    }
    
    return loadout;
}

// Namespace validation
// Params 1
// Checksum 0xdaddd450, Offset: 0x5fd9
// Size: 0xd, Type: bool
function weaponunlocksvialoot( weaponref )
{
    return false;
}

// Namespace validation
// Params 1
// Checksum 0x81e28b27, Offset: 0x5fef
// Size: 0x33, Type: bool
function isweaponuihidden( weaponrootname )
{
    return isdefined( level.weaponmapdata[ weaponrootname ] ) && level.weaponmapdata[ weaponrootname ].uihidden;
}

// Namespace validation
// Params 2
// Checksum 0xc80d571d, Offset: 0x602b
// Size: 0x48, Type: bool
function isweaponvariantlocked( weaponrootname, variantid )
{
    if ( getdvarint( @"hash_13bf7800793023ef", 0 ) == 1 && game_utility_mp::isanymlgmatch() )
    {
        return true;
    }
    
    if ( !isdefined( variantid ) || variantid <= 0 )
    {
        return false;
    }
    
    return false;
}

// Namespace validation
// Params 1
// Checksum 0xaf71ecfe, Offset: 0x607c
// Size: 0x25a
function function_892a7fecd8df995e( fallbackloadout )
{
    primary = getmatchrulesdata( "commonOption", "restrictedPrimaryFallback" );
    
    if ( primary )
    {
        fallbackloadout.fallbackprimary = primary;
    }
    
    secondary = getmatchrulesdata( "commonOption", "restrictedSecondaryFallback" );
    
    if ( secondary )
    {
        fallbackloadout.fallbacksecondary = secondary;
    }
    
    tertiary = getmatchrulesdata( "commonOption", "restrictedTertiaryFallback" );
    
    if ( tertiary )
    {
        fallbackloadout.fallbacktertiary = tertiary;
    }
    
    perk1 = getmatchrulesdata( "commonOption", "restrictedPerk1Fallback" );
    
    if ( perk1 )
    {
        fallbackloadout.baseperks[ 0 ] = perk1;
        fallbackloadout.perks[ 0 ] = perk1;
    }
    
    perk2 = getmatchrulesdata( "commonOption", "restrictedPerk2Fallback" );
    
    if ( perk2 )
    {
        fallbackloadout.baseperks[ 1 ] = perk2;
        fallbackloadout.perks[ 1 ] = perk2;
    }
    
    perk3 = getmatchrulesdata( "commonOption", "restrictedPerk3Fallback" );
    
    if ( perk3 )
    {
        fallbackloadout.bonusperk = perk3;
        fallbackloadout.perks[ 2 ] = perk3;
    }
    
    perk4 = getmatchrulesdata( "commonOption", "restrictedUltimatePerkFallback" );
    
    if ( perk4 )
    {
        fallbackloadout.ultimateperk = perk4;
        fallbackloadout.perks[ 3 ] = perk4;
    }
    
    lethal = getmatchrulesdata( "commonOption", "restrictedLethalFallback" );
    
    if ( isdefined( lethal ) && lethal != "none" )
    {
        fallbackloadout.var_b2a605ec88afbe46 = lethal;
    }
    
    tactical = getmatchrulesdata( "commonOption", "restrictedTacticalFallback" );
    
    if ( isdefined( tactical ) && tactical != "none" )
    {
        fallbackloadout.var_d74f6d4995ceb3ba = tactical;
    }
    
    if ( level.var_613ba3e28ca2d235 )
    {
        tertiary = getmatchrulesdata( "commonOption", "restrictedTertiaryFallback" );
        
        if ( isdefined( tertiary ) && tertiary != "none" )
        {
            fallbackloadout.var_9b33eed8f7cc774a = tertiary;
        }
    }
    
    wildcard = getmatchrulesdata( "commonOption", "restrictedWildcardFallback" );
    
    if ( wildcard )
    {
        fallbackloadout.wildcard = wildcard;
    }
}

// Namespace validation
// Params 0
// Checksum 0x7ac812a1, Offset: 0x62de
// Size: 0xca2
function function_b7ff987740639b18()
{
    var_7237854e3be197ca = level.fallbackloadout;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    gametypebundle = level.gametypebundle;
    gamemodebundle = level.gamemodebundle;
    fallbackloadout = spawnstruct();
    var_58de392d641e85d5 = getdvarint( @"hash_1c46edd4b28ec23", 17748 );
    var_5b4e989fa27882c1 = getdvarint( @"hash_3ac8e9ebdf483563", 17761 );
    var_6c06f458257b1151 = getdvarint( @"hash_d53048159c275db5", 17750 );
    fallbackloadout.fallbackprimary = loot::function_f54ecb89dfab8e8c( var_58de392d641e85d5 );
    fallbackloadout.var_44457469fb8c9678 = [];
    fallbackloadout.var_44457469fb8c9678[ 0 ] = "none";
    fallbackloadout.var_44457469fb8c9678[ 1 ] = "none";
    fallbackloadout.var_44457469fb8c9678[ 2 ] = "none";
    fallbackloadout.var_44457469fb8c9678[ 3 ] = "none";
    fallbackloadout.var_44457469fb8c9678[ 4 ] = "none";
    fallbackloadout.var_44457469fb8c9678[ 5 ] = "none";
    fallbackloadout.var_b6984909a0cc8b96 = "camo_none";
    fallbackloadout.fallbackprimaryreticle = "none";
    fallbackloadout.fallbackprimaryvariantid = -1;
    fallbackloadout.var_bd4d407391a7489f = [];
    fallbackloadout.var_102c36ef606d3628 = "charm_none";
    fallbackloadout.var_4f5276082dee83f6[ 0 ] = "sticker_none";
    fallbackloadout.var_4f5276082dee83f6[ 1 ] = "sticker_none";
    fallbackloadout.var_4f5276082dee83f6[ 2 ] = "sticker_none";
    fallbackloadout.var_4f5276082dee83f6[ 3 ] = "sticker_none";
    fallbackloadout.var_4f5276082dee83f6[ 4 ] = "sticker_none";
    fallbackloadout.fallbacksecondary = loot::function_f54ecb89dfab8e8c( var_5b4e989fa27882c1 );
    fallbackloadout.var_ba7ffbd0e938d884 = [];
    fallbackloadout.var_ba7ffbd0e938d884[ 0 ] = "none";
    fallbackloadout.var_ba7ffbd0e938d884[ 1 ] = "none";
    fallbackloadout.var_ba7ffbd0e938d884[ 2 ] = "none";
    fallbackloadout.var_ba7ffbd0e938d884[ 3 ] = "none";
    fallbackloadout.var_ba7ffbd0e938d884[ 4 ] = "none";
    fallbackloadout.var_1b790cdd5b3c440a = "camo_none";
    fallbackloadout.fallbacksecondaryreticle = "none";
    fallbackloadout.fallbacksecondaryvariantid = -1;
    fallbackloadout.var_6568a94ead6a1b13 = [];
    fallbackloadout.var_44e71dc382bd433c = "charm_none";
    fallbackloadout.var_d185b1ab244f9c3a[ 0 ] = "sticker_none";
    fallbackloadout.var_d185b1ab244f9c3a[ 1 ] = "sticker_none";
    fallbackloadout.var_d185b1ab244f9c3a[ 2 ] = "sticker_none";
    fallbackloadout.var_d185b1ab244f9c3a[ 3 ] = "sticker_none";
    fallbackloadout.var_d185b1ab244f9c3a[ 4 ] = "sticker_none";
    fallbackloadout.fallbacktertiary = loot::function_f54ecb89dfab8e8c( var_6c06f458257b1151 );
    fallbackloadout.var_b61c143379286d54 = [];
    var_dc1543b984237bf8 = weapon::function_bedf9f9cfa13920d();
    
    for ( attachmentindex = 0; attachmentindex < var_dc1543b984237bf8 ; attachmentindex++ )
    {
        fallbackloadout.var_b61c143379286d54[ attachmentindex ] = "none";
    }
    
    fallbackloadout.var_565c632822e6203a = "camo_none";
    fallbackloadout.var_a5b42256d2d43746 = "none";
    fallbackloadout.var_fd24ef55414f5b7e = 0;
    fallbackloadout.var_5802400f46d8a93e = -1;
    fallbackloadout.var_84441526fc6e65e3 = [];
    fallbackloadout.var_7978cfcef78769cc = "charm_none";
    fallbackloadout.var_cb6d984741f029ea = [];
    
    for ( stickerindex = 0; stickerindex < 4 ; stickerindex++ )
    {
        fallbackloadout.var_cb6d984741f029ea[ stickerindex ] = "sticker_none";
    }
    
    fallbackloadout.perks = class::function_c8d9816a5c9f1f97();
    
    if ( level.gametypebundle.var_ced1c75623f19307 )
    {
        fallbackloadout.var_b2a605ec88afbe46 = "none";
        fallbackloadout.var_8f9811ff4f8b2570 = [];
        fallbackloadout.var_d74f6d4995ceb3ba = "none";
        fallbackloadout.var_33a08535d9321d5c = [];
        
        if ( level.var_613ba3e28ca2d235 )
        {
            fallbackloadout.var_9b33eed8f7cc774a = "none";
            fallbackloadout.var_7ef9f8f8563260c = [];
        }
    }
    else
    {
        fallbackloadout.var_b2a605ec88afbe46 = "equip_frag";
        fallbackloadout.var_8f9811ff4f8b2570 = [];
        fallbackloadout.var_d74f6d4995ceb3ba = "equip_flash";
        fallbackloadout.var_33a08535d9321d5c = [];
        
        if ( level.var_613ba3e28ca2d235 )
        {
            fallbackloadout.var_9b33eed8f7cc774a = "equip_concussion";
            fallbackloadout.var_7ef9f8f8563260c = [];
        }
    }
    
    fallbackloadout.fallbackkillstreaks = [];
    
    if ( gamemodebundle.streaktypeenabled )
    {
        streaktype = killstreaks::getstreaktype();
        
        foreach ( fallback in streaktype.default_selections )
        {
            fallbackloadout.fallbackkillstreaks[ fallbackloadout.fallbackkillstreaks.size ] = getscriptbundlefieldvalue( fallback.streak, #"hash_fac9242d98a23ee8" ) ?? "none";
        }
    }
    else
    {
        fallbackloadout.fallbackkillstreaks[ 0 ] = gametypebundle.fallbackkillstreak0 ?? gamemodebundle.fallbackkillstreak0 ?? "none";
        fallbackloadout.fallbackkillstreaks[ 1 ] = gametypebundle.fallbackkillstreak1 ?? gamemodebundle.fallbackkillstreak1 ?? "none";
        fallbackloadout.fallbackkillstreaks[ 2 ] = gametypebundle.fallbackkillstreak2 ?? gamemodebundle.fallbackkillstreak2 ?? "none";
    }
    
    fallbackloadout.var_df4518bcb104ee03 = gametypebundle.var_df4518bcb104ee03 ?? gamemodebundle.var_df4518bcb104ee03 ?? "super_trophy";
    fallbackloadout.var_df4519bcb104f036 = gametypebundle.var_df4519bcb104f036 ?? gamemodebundle.var_df4519bcb104f036 ?? "super_ammo_drop";
    fallbackloadout.var_c123516f43e77547 = [];
    fallbackloadout.var_77ff83b5a333940 = [];
    fallbackloadout.wildcard = "none";
    
    if ( game_utility_mp::isanymlgmatch() )
    {
        leagueplaydata = gametypebundle.leagueplaydata;
        leagueplaybundle = getscriptbundle( leagueplaydata.leagueplaybundle );
        var_257850eb27cccb38 = getscriptbundle( leagueplaybundle.fallbackloadout );
        var_a85edcbad1c11ad3 = getscriptbundle( leagueplaybundle.fallbackkillstreaks );
        fallbackloadout.fallbackprimary = var_257850eb27cccb38.primaryweapon.weapon;
        fallbackloadout.var_44457469fb8c9678 = [];
        fallbackloadout.var_44457469fb8c9678[ 0 ] = var_257850eb27cccb38.primaryweapon.attachment1;
        fallbackloadout.var_44457469fb8c9678[ 1 ] = var_257850eb27cccb38.primaryweapon.attachment2;
        fallbackloadout.var_44457469fb8c9678[ 2 ] = var_257850eb27cccb38.primaryweapon.attachment3;
        fallbackloadout.var_44457469fb8c9678[ 3 ] = var_257850eb27cccb38.primaryweapon.attachment4;
        fallbackloadout.var_44457469fb8c9678[ 4 ] = var_257850eb27cccb38.primaryweapon.attachment5;
        fallbackloadout.var_44457469fb8c9678[ 5 ] = var_257850eb27cccb38.primaryweapon.attachment6;
        fallbackloadout.var_b6984909a0cc8b96 = var_257850eb27cccb38.primaryweapon.camo;
        fallbackloadout.var_fb03c20051055e7e = var_257850eb27cccb38.primaryweapon.reticle;
        fallbackloadout.fallbackprimaryvariantid = isdefined( var_257850eb27cccb38.primaryweapon.variantid ) ? int( var_257850eb27cccb38.primaryweapon.variantid ) : -1;
        fallbackloadout.fallbacksecondary = var_257850eb27cccb38.secondaryweapon.weapon;
        fallbackloadout.var_ba7ffbd0e938d884 = [];
        fallbackloadout.var_ba7ffbd0e938d884[ 0 ] = var_257850eb27cccb38.secondaryweapon.attachment1;
        fallbackloadout.var_ba7ffbd0e938d884[ 1 ] = var_257850eb27cccb38.secondaryweapon.attachment2;
        fallbackloadout.var_ba7ffbd0e938d884[ 2 ] = var_257850eb27cccb38.secondaryweapon.attachment3;
        fallbackloadout.var_ba7ffbd0e938d884[ 3 ] = var_257850eb27cccb38.secondaryweapon.attachment4;
        fallbackloadout.var_ba7ffbd0e938d884[ 4 ] = var_257850eb27cccb38.secondaryweapon.attachment5;
        fallbackloadout.var_1b790cdd5b3c440a = var_257850eb27cccb38.secondaryweapon.camo;
        fallbackloadout.fallbacksecondaryreticle = var_257850eb27cccb38.secondaryweapon.reticle;
        fallbackloadout.fallbacksecondaryvariantid = isdefined( var_257850eb27cccb38.secondaryweapon.variantid ) ? int( var_257850eb27cccb38.secondaryweapon.variantid ) : -1;
        fallbackloadout.var_6568a94ead6a1b13 = [];
        fallbackloadout.perks = [];
        fallbackloadout.perks[ 0 ] = var_257850eb27cccb38.perks.perk1;
        fallbackloadout.perks[ 1 ] = var_257850eb27cccb38.perks.perk2;
        fallbackloadout.perks[ 2 ] = var_257850eb27cccb38.perks.perk3;
        fallbackloadout.perks[ 3 ] = var_257850eb27cccb38.perks.perk4;
        fallbackloadout.bonusperk = var_257850eb27cccb38.perks.perkbonus;
        fallbackloadout.wildcard = var_257850eb27cccb38.wildcard.wildcard;
        fallbackloadout.var_b2a605ec88afbe46 = var_257850eb27cccb38.equipment.primary;
        fallbackloadout.var_d74f6d4995ceb3ba = var_257850eb27cccb38.equipment.secondary;
        
        if ( level.var_613ba3e28ca2d235 )
        {
            fallbackloadout.var_9b33eed8f7cc774a = var_257850eb27cccb38.equipment.tertiary;
        }
        
        fallbackloadout.fallbackkillstreaks[ 0 ] = var_a85edcbad1c11ad3.killstreak_list[ 0 ].ref;
        fallbackloadout.fallbackkillstreaks[ 1 ] = var_a85edcbad1c11ad3.killstreak_list[ 1 ].ref;
        fallbackloadout.fallbackkillstreaks[ 2 ] = var_a85edcbad1c11ad3.killstreak_list[ 2 ].ref;
        fallbackloadout.var_df4518bcb104ee03 = var_257850eb27cccb38.fieldUpgrades.fieldupgrade1 ?? "none";
        fallbackloadout.var_df4519bcb104f036 = var_257850eb27cccb38.fieldUpgrades.fieldupgrade2 ?? "none";
    }
    else if ( game_utility_mp::function_57f7c589ea92d695() )
    {
        fallbackloadout.fallbacksecondary = "none";
    }
    else
    {
        function_892a7fecd8df995e( fallbackloadout );
    }
    
    level.fallbackloadout = fallbackloadout;
    return fallbackloadout;
}

// Namespace validation
// Params 1
// Checksum 0x3bdc1130, Offset: 0x6f89
// Size: 0x16c
function replaceprimaryweapon( loadout )
{
    fallbackloadout = function_b7ff987740639b18();
    loadout.loadoutprimary = fallbackloadout.fallbackprimary;
    loadout.loadoutprimaryattachments = fallbackloadout.var_44457469fb8c9678;
    loadout.loadoutprimarycamo = fallbackloadout.var_b6984909a0cc8b96;
    loadout.loadoutprimaryreticle = fallbackloadout.fallbackprimaryreticle;
    loadout.loadoutprimaryvariantid = fallbackloadout.fallbackprimaryvariantid;
    loadout.loadoutprimaryattachmentids = fallbackloadout.var_bd4d407391a7489f;
    loadout.loadoutprimarycosmeticattachment = fallbackloadout.var_102c36ef606d3628;
    loadout.loadoutprimarystickers[ 0 ] = fallbackloadout.var_4f5276082dee83f6[ 0 ];
    loadout.loadoutprimarystickers[ 1 ] = fallbackloadout.var_4f5276082dee83f6[ 1 ];
    loadout.loadoutprimarystickers[ 2 ] = fallbackloadout.var_4f5276082dee83f6[ 2 ];
    loadout.loadoutprimarystickers[ 3 ] = fallbackloadout.var_4f5276082dee83f6[ 3 ];
    loadout.loadoutprimarystickers[ 4 ] = fallbackloadout.var_4f5276082dee83f6[ 4 ];
    
    if ( !isdefined( loadout.loadoutprimary ) )
    {
        script::function_2e2007575f92910d( "[replacePrimaryWeapon] bad fallbackLoadout primary" );
    }
    
    return loadout;
}

// Namespace validation
// Params 1
// Checksum 0x7d3327b7, Offset: 0x70fe
// Size: 0x16c
function replacesecondaryweapon( loadout )
{
    fallbackloadout = function_b7ff987740639b18();
    loadout.loadoutsecondary = fallbackloadout.fallbacksecondary;
    loadout.loadoutsecondaryattachments = fallbackloadout.var_ba7ffbd0e938d884;
    loadout.loadoutsecondarycamo = fallbackloadout.var_1b790cdd5b3c440a;
    loadout.loadoutsecondaryreticle = fallbackloadout.fallbacksecondaryreticle;
    loadout.loadoutsecondaryvariantid = fallbackloadout.fallbacksecondaryvariantid;
    loadout.loadoutsecondaryattachmentids = fallbackloadout.var_6568a94ead6a1b13;
    loadout.loadoutsecondarycosmeticattachment = fallbackloadout.var_44e71dc382bd433c;
    loadout.loadoutsecondarystickers[ 0 ] = fallbackloadout.var_d185b1ab244f9c3a[ 0 ];
    loadout.loadoutsecondarystickers[ 1 ] = fallbackloadout.var_d185b1ab244f9c3a[ 1 ];
    loadout.loadoutsecondarystickers[ 2 ] = fallbackloadout.var_d185b1ab244f9c3a[ 2 ];
    loadout.loadoutsecondarystickers[ 3 ] = fallbackloadout.var_d185b1ab244f9c3a[ 3 ];
    loadout.loadoutsecondarystickers[ 4 ] = fallbackloadout.var_d185b1ab244f9c3a[ 4 ];
    
    if ( !isdefined( loadout.loadoutsecondary ) )
    {
        script::function_2e2007575f92910d( "[replaceSecondaryWeapon] bad fallbackLoadout secondary" );
    }
    
    return loadout;
}

// Namespace validation
// Params 1
// Checksum 0x5e6d8e30, Offset: 0x7273
// Size: 0x113
function function_53e777daf2ac63ac( loadout )
{
    fallbackloadout = function_b7ff987740639b18();
    loadout.loadouttertiary = fallbackloadout.fallbacktertiary;
    loadout.loadoutTertiaryAttachments = fallbackloadout.var_b61c143379286d54;
    loadout.loadouttertiarycamo = fallbackloadout.var_565c632822e6203a;
    loadout.loadouttertiaryreticle = fallbackloadout.var_a5b42256d2d43746;
    loadout.loadouttertiaryvariantid = fallbackloadout.var_5802400f46d8a93e;
    loadout.loadoutTertiaryAttachmentIDs = fallbackloadout.var_84441526fc6e65e3;
    loadout.loadoutTertiaryCosmeticAttachment = fallbackloadout.var_7978cfcef78769cc;
    
    for ( stickerindex = 0; stickerindex < 4 ; stickerindex++ )
    {
        loadout.loadoutTertiaryStickers[ stickerindex ] = fallbackloadout.var_cb6d984741f029ea[ stickerindex ];
    }
    
    if ( !isdefined( loadout.loadouttertiary ) )
    {
        script::function_2e2007575f92910d( "[replaceTertiaryWeapon] bad fallbackLoadout tertiary" );
    }
    
    return loadout;
}

// Namespace validation
// Params 1
// Checksum 0x5dc570a5, Offset: 0x738f
// Size: 0x82
function replaceperkpackage( loadout )
{
    fallbackloadout = function_b7ff987740639b18();
    
    for ( i = 0; i < loadout.loadoutperks.size ; i++ )
    {
        if ( i >= fallbackloadout.perks.size )
        {
            println( "<dev string:x424>" );
            continue;
        }
        
        loadout.loadoutperks[ i ] = fallbackloadout.perks[ i ];
    }
    
    return loadout;
}

