// scripts\mp\weaponmetadata.gsc  (hash_3b3991e0b89ff57b.gscc) (size: 6953 Bytes / 0x1b29 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9569d363 (2506740579)
// size ...... 6953 (0x1b29)
// includes .. 5   (offset: 0x1839)
// strings ... 37  (offset: 0x1861)
// dev strs .. 6   (offset: 0x1ad9)
// exports ... 7   (offset: 0x1295)
// cseg ...... 0x289 + 0x100c (0x1295)
// imports ... 38  (offset: 0x13ad)
// animtree1 . 0   (offset: 0x1b29)
// animtree2 . 0   (offset: 0x1b29)
#using scripts\common\callbacks;
#using scripts\common\script;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\common\utility\loot;

#namespace weaponmetadata;

// Namespace weaponmetadata
// Params 0
// Checksum 0x6032e168, Offset: 0x2a7
// Size: 0x859
function init_weaponmetadata()
{
    str_weapons_list = level.gametypebundle.var_8050dee6ba5824e3 ?? level.gamemodebundle.var_8050dee6ba5824e3;
    
    if ( !isdefined( str_weapons_list ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    s_bundle = getscriptbundle( "weaponmetadata:" + str_weapons_list );
    level.weaponmetadata = [];
    level.weaponmetadata[ "rarity_settings" ] = spawnstruct();
    level.weaponmetadata[ "pap_settings" ] = spawnstruct();
    level.weaponmetadata[ "magicbox_settings" ] = spawnstruct();
    level.weaponmetadata[ "dragonbreath_settings" ] = spawnstruct();
    level.weaponmetadata[ "wallbuy_settings" ] = spawnstruct();
    level.weaponmetadata[ "rarity_settings" ].var_92f45d84303abef2 = s_bundle.var_92f45d84303abef2;
    level.weaponmetadata[ "rarity_settings" ].var_2550ce6fe8f5f078 = s_bundle.var_2550ce6fe8f5f078;
    level.weaponmetadata[ "rarity_settings" ].var_5a183b53e6638a8f = s_bundle.var_5a183b53e6638a8f;
    level.weaponmetadata[ "rarity_settings" ].var_479d2715b4197011 = s_bundle.var_479d2715b4197011;
    level.weaponmetadata[ "rarity_settings" ].var_39165759050c65f5 = s_bundle.var_39165759050c65f5;
    level.weaponmetadata[ "rarity_settings" ].var_1cee31acf45cd3e8 = s_bundle.var_1cee31acf45cd3e8;
    level.weaponmetadata[ "pap_settings" ].var_7d839c8d6b962468 = s_bundle.var_7d839c8d6b962468;
    level.weaponmetadata[ "pap_settings" ].var_77a38153acdfba05 = s_bundle.var_77a38153acdfba05;
    level.weaponmetadata[ "pap_settings" ].var_23ec616b8fded652 = s_bundle.var_23ec616b8fded652;
    level.weaponmetadata[ "pap_settings" ].var_ec149227ba79bc67 = s_bundle.var_ec149227ba79bc67;
    level.weaponmetadata[ "dragonbreath_settings" ].dragonbreathdamage = s_bundle.dragonbreathdamage;
    level.weaponmetadata[ "dragonbreath_settings" ].var_731ad3a238456f7a = s_bundle.var_731ad3a238456f7a;
    level.weaponmetadata[ "dragonbreath_settings" ].var_731ad2a238456d47 = s_bundle.var_731ad2a238456d47;
    level.weaponmetadata[ "dragonbreath_settings" ].var_731ad1a238456b14 = s_bundle.var_731ad1a238456b14;
    level.weaponmetadata[ "dragonbreath_settings" ].var_731ad0a2384568e1 = s_bundle.var_731ad0a2384568e1;
    level.weaponmetadata[ "dragonbreath_settings" ].var_1a184b016fc08792 = s_bundle.var_1a184b016fc08792;
    level.weaponmetadata[ "dragonbreath_settings" ].var_794b911765c9a6db = s_bundle.var_794b911765c9a6db;
    level.weaponmetadata[ "dragonbreath_settings" ].var_3d9a237b6a338282 = s_bundle.var_3d9a237b6a338282;
    level.weaponmetadata[ "dragonbreath_settings" ].var_dbea0094be1481d3 = s_bundle.var_dbea0094be1481d3;
    level.weaponmetadata[ "dragonbreath_settings" ].var_fd572e316130fca1 = s_bundle.var_fd572e316130fca1;
    level.weaponmetadata[ "dragonbreath_settings" ].var_e87ad34435a5d344 = s_bundle.var_e87ad34435a5d344;
    level.weaponmetadata[ "dragonbreath_settings" ].var_777d257be1a4bbc8 = s_bundle.var_777d257be1a4bbc8;
    level.weaponmetadata[ "dragonbreath_settings" ].dragonbreathduration = s_bundle.dragonbreathduration;
    level.weaponmetadata[ "magicbox_settings" ].weaponitemspawnlist = s_bundle.var_60a8ed06e5b42e50;
    level.weaponmetadata[ "magicbox_settings" ].var_cdf3904616e50bf8 = s_bundle.var_4522bb5c729efb40;
    level.weaponmetadata[ "magicbox_settings" ].wonderweaponitemspawnlist = s_bundle.var_7b94d52e967d3b1;
    level.weaponmetadata[ "wallbuy_settings" ].var_6c0293f8e2c934b8 = s_bundle.var_6c0293f8e2c934b8;
    level.weaponmetadata[ "scene_weapons" ] = { #var_8d39fbd08006aa9e:[] };
    
    if ( isdefined( s_bundle.var_4f89042344f3ffde ) )
    {
        var_f2a6b751461c5334 = getscriptbundle( "currency:" + s_bundle.var_4f89042344f3ffde );
        level.weaponmetadata[ "wallbuy_settings" ].var_4f89042344f3ffde = var_f2a6b751461c5334.currencyname;
    }
    
    foreach ( n_index, var_fe68cd50dcda7fdc in s_bundle.weaponslist )
    {
        if ( !isdefined( var_fe68cd50dcda7fdc.var_ab4fac37130725c5 ) )
        {
            println( "<dev string:x4a>" + str_weapons_list + "<dev string:x78>" + n_index + "<dev string:x83>" );
            continue;
        }
        
        var_1b54c25a833e350a = getscriptbundle( var_fe68cd50dcda7fdc.var_ab4fac37130725c5 );
        
        if ( !isdefined( var_1b54c25a833e350a ) )
        {
            println( "<dev string:x9b>" + getxhashsourcename( var_fe68cd50dcda7fdc.var_ab4fac37130725c5 ) + "<dev string:xbc>" );
            continue;
        }
        
        weapon = makeweapon( var_1b54c25a833e350a.weapon );
        var_2e08e94c9cb1747c = weapon.var_1616e6fbba9a722d;
        
        if ( !isdefined( var_2e08e94c9cb1747c ) || var_2e08e94c9cb1747c == "" || var_2e08e94c9cb1747c == %"none" )
        {
            var_2e08e94c9cb1747c = var_1b54c25a833e350a.weapon;
        }
        
        if ( !isdefined( var_2e08e94c9cb1747c ) )
        {
            println( "<dev string:x9b>" + getxhashsourcename( var_fe68cd50dcda7fdc.var_ab4fac37130725c5 ) + "<dev string:xbc>" );
            continue;
        }
        
        level.weaponmetadata[ var_2e08e94c9cb1747c ] = var_1b54c25a833e350a;
        
        if ( var_1b54c25a833e350a.var_b900513016512646 )
        {
            weapon = weapon::buildweapon( weapon.basename );
            level.weaponmetadata[ "scene_weapons" ].var_8d39fbd08006aa9e[ level.weaponmetadata[ "scene_weapons" ].var_8d39fbd08006aa9e.size ] = weapon;
        }
    }
    
    level.var_de79f65048631206[ "none" ] = 0;
    level.var_de79f65048631206[ "fire" ] = 1;
    level.var_de79f65048631206[ "cold" ] = 2;
    level.var_de79f65048631206[ "toxic" ] = 3;
    level.var_de79f65048631206[ "electrical" ] = 4;
    level.var_de79f65048631206[ "dark" ] = 5;
    level.var_de79f65048631206[ "light" ] = 6;
    level.var_7f713ff739629360[ "fire" ] = "hitelementfire";
    level.var_7f713ff739629360[ "cold" ] = "hitelementcold";
    level.var_7f713ff739629360[ "toxic" ] = "hitelementtoxic";
    level.var_7f713ff739629360[ "electrical" ] = "hitelementelectrical";
    level.var_7f713ff739629360[ "dark" ] = "hitelementfire";
    level.var_7f713ff739629360[ "light" ] = "hitelementfire";
    level.var_c42dd935c4b19dde = &function_8ebb73e054860e6f;
    
    if ( isdefined( level.var_69dc634c8bc27aa ) )
    {
        [[ level.var_69dc634c8bc27aa ]]();
    }
    
    if ( isdefined( s_bundle.var_1b03830fed68fa7e ) )
    {
        callback::add( #"player_connect", &function_f5a4ca68b5d36e7e, { #var_1b03830fed68fa7e:s_bundle.var_1b03830fed68fa7e } );
    }
}

// Namespace weaponmetadata
// Params 2
// Checksum 0x909dc19a, Offset: 0xb08
// Size: 0x47c
function function_f5a4ca68b5d36e7e( sparams, var_650afee77554228c )
{
    self.favoriteweapons = [];
    
    foreach ( weaponentry in level.weaponmetadata )
    {
        if ( isdefined( weaponentry.weapon ) && isdefined( weaponentry.weaponclass ) && !weaponentry.iswonderweapon && weaponentry.canpap )
        {
            statsgroup = level.loadoutsgroup;
            
            if ( getprojectname() == "SAT" || getprojectname() == "SAW" )
            {
                statsgroup = "weaponsetups";
            }
            
            var_79746008438e13b6 = weaponentry.weapon;
            var_27e13673f63333b2 = script::strip_suffix( var_79746008438e13b6, "_mp" );
            weaponlootid = self getplayerdata( statsgroup, var_650afee77554228c.var_1b03830fed68fa7e, var_27e13673f63333b2, "weaponlootid" );
            
            if ( isdefined( weaponlootid ) && weaponlootid != 0 )
            {
                weaponstruct = spawnstruct();
                camoLootID = self getplayerdata( statsgroup, var_650afee77554228c.var_1b03830fed68fa7e, var_27e13673f63333b2, "camoLootID" );
                
                if ( camoLootID == 0 )
                {
                    camoref = "camo_none";
                }
                else
                {
                    camoref = loot::function_f54ecb89dfab8e8c( camoLootID );
                }
                
                if ( camoref.size == 0 )
                {
                    camoref = "camo_none";
                }
                
                camoref = getscriptbundlefieldvalue( hashcat( %"hash_1345cc24140e89b8", camoref ), #"ref" );
                
                if ( !isdefined( camoref ) || camoref.size == 0 )
                {
                    camoref = "camo_none";
                }
                
                weaponstruct.camoref = camoref;
                reticleLootID = self getplayerdata( statsgroup, var_650afee77554228c.var_1b03830fed68fa7e, var_27e13673f63333b2, "reticlelootid" );
                
                if ( reticleLootID == 0 )
                {
                    var_8da9d6b043cded0f = "none";
                }
                else
                {
                    var_8da9d6b043cded0f = loot::function_f54ecb89dfab8e8c( reticleLootID );
                    
                    if ( var_8da9d6b043cded0f.size == 0 )
                    {
                        var_8da9d6b043cded0f = "none";
                    }
                }
                
                weaponstruct.reticle = var_8da9d6b043cded0f;
                weaponstruct.attachments = [];
                weaponstruct.var_3bef5d07b66ae6b2 = [];
                weaponstruct.stickers = [];
                
                for ( i = 0; i < 17 ; i++ )
                {
                    attachmentlootid = self getplayerdata( statsgroup, var_650afee77554228c.var_1b03830fed68fa7e, var_27e13673f63333b2, "attachmentSetup", i, "attachmentlootid" );
                    
                    if ( attachmentlootid == 0 )
                    {
                        attachment = "none";
                    }
                    else
                    {
                        attachment = loot::function_f54ecb89dfab8e8c( attachmentlootid );
                    }
                    
                    attachment = weapon::function_668a13182805f553( var_27e13673f63333b2, attachment );
                    attachmentvariantid = self getplayerdata( statsgroup, var_650afee77554228c.var_1b03830fed68fa7e, var_27e13673f63333b2, "attachmentSetup", i, "attachmentVariantID" );
                    weaponstruct.attachments[ i ] = attachment;
                    weaponstruct.var_3bef5d07b66ae6b2[ i ] = attachmentvariantid;
                }
                
                for ( i = 0; i < 5 ; i++ )
                {
                    stickerlootid = self getplayerdata( statsgroup, var_650afee77554228c.var_1b03830fed68fa7e, var_27e13673f63333b2, "stickerlootids", i );
                    
                    if ( stickerlootid == 0 )
                    {
                        sticker = "sticker_none";
                    }
                    else
                    {
                        sticker = loot::function_f54ecb89dfab8e8c( stickerlootid );
                    }
                    
                    weaponstruct.stickers[ i ] = sticker;
                }
                
                cosmeticAttachmentLootID = self getplayerdata( statsgroup, var_650afee77554228c.var_1b03830fed68fa7e, var_27e13673f63333b2, "cosmeticAttachmentLootID" );
                
                if ( cosmeticAttachmentLootID == 0 )
                {
                    cosmeticattachment = "charm_none";
                }
                else
                {
                    cosmeticattachment = loot::function_f54ecb89dfab8e8c( cosmeticAttachmentLootID );
                }
                
                weaponstruct.cosmeticattachment = cosmeticattachment;
                weaponstruct.variantid = self getplayerdata( statsgroup, var_650afee77554228c.var_1b03830fed68fa7e, var_27e13673f63333b2, "weaponVariantID" );
                chromahash = self getplayerdata( statsgroup, var_650afee77554228c.var_1b03830fed68fa7e, var_27e13673f63333b2, "chroma" );
                
                if ( chromahash == %"" )
                {
                    weaponstruct.chroma = "none";
                }
                
                self.favoriteweapons[ var_79746008438e13b6 ] = weaponstruct;
            }
        }
    }
}

// Namespace weaponmetadata
// Params 1
// Checksum 0xff4bd850, Offset: 0xf8c
// Size: 0xe9
function function_c68204eff69ed046( weaponname )
{
    if ( isdefined( weaponname ) && isdefined( self.favoriteweapons[ weaponname ] ) )
    {
        weaponstruct = self.favoriteweapons[ weaponname ];
        var_27e13673f63333b2 = script::strip_suffix( weaponname, "_mp" );
        var_f581dedba4f25efb = weapon::function_2374da6f1b4fad4e( weaponname, weaponstruct.variantid );
        weapon = weapon::buildweapon( var_27e13673f63333b2, weaponstruct.attachments, weaponstruct.camoref, weaponstruct.reticle, weaponstruct.variantid, weaponstruct.var_3bef5d07b66ae6b2, weaponstruct.cosmeticattachment, weaponstruct.stickers, undefined, undefined, undefined, var_f581dedba4f25efb );
        function_788f97dda6180b0a( weapon, weaponstruct.chroma );
        return weapon;
    }
}

// Namespace weaponmetadata
// Params 2
// Checksum 0x5222ef99, Offset: 0x107e
// Size: 0x7c
function function_788f97dda6180b0a( weapon, chroma )
{
    if ( !isdefined( weapon ) || isnullweapon( weapon ) || !isdefined( chroma ) )
    {
        return;
    }
    
    if ( isxhashasset( chroma ) )
    {
        weapon withchroma( chroma );
        return;
    }
    
    if ( isstring( chroma ) && chroma != "none" )
    {
        weapon withchroma( chroma );
        return;
    }
    
    if ( isnumber( chroma ) && chroma != 0 )
    {
        weapon withchroma( chroma );
    }
}

// Namespace weaponmetadata
// Params 1
// Checksum 0x59802539, Offset: 0x1102
// Size: 0x13a
function set_current_weapon_level( var_6694135a711872c9 )
{
    currentweapon = self getcurrentweapon();
    camo = getweaponcamoname( currentweapon );
    reticle = function_4af0b444e167186d( currentweapon );
    variantid = getweaponvariantindex( currentweapon );
    var_39044599845b54cf = currentweapon;
    stickers = [ currentweapon.stickerslot0, currentweapon.stickerslot1, currentweapon.stickerslot2, currentweapon.stickerslot3, currentweapon.var_73762c7cb8b2063 ];
    currentattachments = currentweapon.attachments;
    var_f5e9dad8c485c904 = currentweapon.attachmentvarindices;
    var_101633ed971732ba = weapon::buildweapon( currentweapon.basename, currentattachments, camo, reticle, variantid, var_f5e9dad8c485c904, undefined, stickers );
    self takeweapon( var_39044599845b54cf );
    self giveweapon( var_101633ed971732ba );
    self switchtoweapon( var_101633ed971732ba );
    self givemaxammo( var_101633ed971732ba );
    utility::callsharedfunc( #"pack_a_punch", #"hash_4fb89d74adceafac", currentweapon, var_6694135a711872c9 );
}

// Namespace weaponmetadata
// Params 1
// Checksum 0x8acedb28, Offset: 0x1244
// Size: 0x50, Type: bool
function function_8ebb73e054860e6f( weapon )
{
    weapon_root_name = weapon.var_1616e6fbba9a722d;
    
    if ( isdefined( level.weaponmetadata[ weapon_root_name ] ) )
    {
        if ( level.weaponmetadata[ weapon_root_name ].var_33e6eb1cd0b65b0a )
        {
            return true;
        }
    }
    
    return false;
}

