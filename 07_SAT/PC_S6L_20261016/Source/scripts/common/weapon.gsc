// scripts\common\weapon.gsc  (hash_74f99c09414692fa.gscc) (size: 40569 Bytes / 0x9e79 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6a5ce249 (1784472137)
// size ...... 40569 (0x9e79)
// includes .. 3   (offset: 0x9179)
// strings ... 189 (offset: 0x9191)
// dev strs .. 50  (offset: 0x9be5)
// exports ... 129 (offset: 0x68f1)
// cseg ...... 0xdba + 0x5b37 (0x68f1)
// imports ... 163 (offset: 0x7d19)
// animtree1 . 0   (offset: 0x9e79)
// animtree2 . 0   (offset: 0x9e79)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;

#namespace weapon;

// Namespace weapon
// Params 0, eflags: 0x5
// Checksum 0x2839f1ff, Offset: 0xdd8
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"common_weapons", undefined, &weapons_init, undefined );
}

// Namespace weapon
// Params 0
// Checksum 0xb5397081, Offset: 0xdf9
// Size: 0x284
function weapons_init()
{
    initializemines();
    level.maxattachments = [];
    maxattachments = level.gamemodebundle.maxattachments;
    maxattachmentsprimary = { #gunfighter:level.gamemodebundle.maxattachments.gunfighterprimary, #standard:isdefined( maxattachments ) ? maxattachments.defaultprimary : 8 };
    level.maxattachments[ level.maxattachments.size ] = maxattachmentsprimary;
    maxattachmentssecondary = { #gunfighter:level.gamemodebundle.maxattachments.gunfightersecondary, #standard:isdefined( maxattachments ) ? maxattachments.defaultsecondary : 5 };
    level.maxattachments[ level.maxattachments.size ] = maxattachmentssecondary;
    maxattachmentstertiary = { #flyswatter:level.gamemodebundle.maxattachments.flyswattertertiary, #gunfighter:level.gamemodebundle.maxattachments.gunfightertertiary, #standard:isdefined( maxattachments ) ? maxattachments.defaulttertiary : 5 };
    level.maxattachments[ level.maxattachments.size ] = maxattachmentstertiary;
    level.var_e0dc368290d94a40 = [];
    
    if ( isdefined( level.gamemodebundle.var_74c8e9104c137cd4 ) )
    {
        foreach ( attachment in level.gamemodebundle.var_74c8e9104c137cd4 )
        {
            level.var_e0dc368290d94a40[ level.var_e0dc368290d94a40.size ] = attachment.attachment;
        }
    }
    else
    {
        level.var_e0dc368290d94a40 = [ "laserir_box", "laserir_cyl", "laserir_pstl" ];
    }
    
    level callback::add( #"hash_500e33f5505ca842", &function_3c1487d3e0c3cf41 );
}

/#

    // Namespace weapon
    // Params 9
    // Checksum 0x7dfa2a10, Offset: 0x1085
    // Size: 0x7e, Type: dev
    function validateweapon( rootname, attachments, camo, reticle, variantid, attachmentids, cosmeticattachment, stickers, hasnvg )
    {
        if ( !iskillstreakplayerweapon( rootname ) )
        {
            rootname = getweaponrootname( rootname );
        }
        
        if ( !validateweaponassetnamemap( rootname ) )
        {
            return 0;
        }
        
        return 1;
    }

#/

// Namespace weapon
// Params 1
// Checksum 0x33c27b03, Offset: 0x110b
// Size: 0x96
function function_a972ae5c8fb5933( weaponinfo )
{
    return buildweapon( weaponinfo.weaponref, weaponinfo.attachmentrefs, weaponinfo.weaponcamo, weaponinfo.weaponreticle, weaponinfo.weaponvariant, weaponinfo.attachmentids, weaponinfo.weaponcosmetic, weaponinfo.weaponstickers, weaponinfo.hasnvg, weaponinfo.attachmenttuning, weaponinfo.iscustom, weaponinfo.blueprintattachmentignorelist );
}

// Namespace weapon
// Params 13
// Checksum 0xb8aaa94, Offset: 0x11aa
// Size: 0x44a
function buildweapon( rootname, attachments, camo = "camo_none", reticle, variantid, attachmentids, cosmeticattachment, stickers, hasnvg, attachmenttuning, iscustom, blueprintattachmentignorelist, serialvalue )
{
    if ( "none" == rootname || !isdefined( rootname ) )
    {
        return level.weaponnone;
    }
    
    if ( isdefined( attachments ) )
    {
        assert( isarray( attachments ), "<dev string:x24>" );
    }
    else
    {
        attachments = [];
    }
    
    if ( isstring( reticle ) )
    {
        reticlestring = reticle;
        
        if ( reticle == "none" )
        {
            reticle = %"";
        }
        else
        {
            if ( !isstartstr( reticle, "reticledata:" ) )
            {
                reticle = "reticledata:" + reticle;
            }
            
            reticle = getxhashasset( reticle );
        }
    }
    
    if ( isdefined( variantid ) && ( isstring( variantid ) && variantid == "-1" || isint( variantid ) && variantid <= 0 ) )
    {
        variantid = undefined;
    }
    
    /#
        if ( getdvarint( @"hash_4a51ce524748b7b4", 0 ) )
        {
            foreach ( attachment_name in attachments )
            {
                validate_weapon_attachment( attachment_name );
            }
        }
    #/
    
    weaponassetname = weaponassetnamemap( rootname );
    weaponobj = buildweaponinternal( weaponassetname, attachments, camo, reticle, variantid, attachmentids, cosmeticattachment, stickers, iscustom, blueprintattachmentignorelist, serialvalue );
    
    /#
        if ( isdefined( weaponobj.camo ) )
        {
            assert( function_2b94fc4d332569a5( weaponobj ), "<dev string:x53>" + weaponobj.camo + "<dev string:x79>" + weaponobj.basename );
        }
    #/
    
    if ( !isdefined( weaponobj ) )
    {
        logstring( "[WEAPON] BuildWeaponInternal() FAILED" + " | rootName: " + ( rootname ?? "undefined" ) + " | weaponAssetName: " + ( weaponassetname ?? "undefined" ) + " | attachments: " + ( isarray( attachments ) ? "count=" + attachments.size : "not array" ) + " | camo: " + ( camo ?? "undefined" ) + " | reticle: " + ( isstring( reticlestring ) ? reticlestring : "not string" ) + " | variantID: " + ( variantid ?? "undefined" ) + " | attachmentIDs: " + ( isarray( attachmentids ) ? "count=" + attachmentids.size : "not array" ) + " | cosmeticAttachment: " + ( isstring( cosmeticattachment ) ? cosmeticattachment : "not string" ) + " | stickers: " + ( isarray( stickers ) ? "count=" + stickers.size : "not array" ) + " | hasNVG: " + ( hasnvg ? "true" : "false" ) + " | attachmentTuning: " + ( isarray( attachmenttuning ) ? "count=" + attachmenttuning.size : "not array" ) + " | isCustom: " + ( iscustom ? "true" : "false" ) + " | blueprintAttachmentIgnoreList: " + ( isarray( blueprintattachmentignorelist ) ? "count=" + blueprintattachmentignorelist.size : "not array" ) + " | serial: " + ( serialvalue ?? "undefined" ) );
        return;
    }
    
    if ( hasnvg )
    {
        if ( weaponsupportslaserir( weaponobj ) && function_ad2262e5ff0331a3( weaponobj ) )
        {
            nvgattachment = getweaponnvgattachment( weaponobj );
            
            if ( nvgattachment != "invalid" && ( isdefined( weaponobj.attachments ) && !arraycontains( weaponobj.attachments, nvgattachment ) || !isdefined( weaponobj.attachments ) ) )
            {
                weaponobj = weaponobj withattachment( nvgattachment );
            }
        }
    }
    
    if ( isdefined( level.var_cfde89929188f64e ) && isdefined( weaponobj ) )
    {
        weaponobj = self [[ level.var_cfde89929188f64e ]]( weaponobj );
    }
    
    return weaponobj;
}

/#

    // Namespace weapon
    // Params 1, eflags: 0x4
    // Checksum 0x77e43950, Offset: 0x15fd
    // Size: 0x59, Type: dev
    function private validate_weapon_attachment( attachment_name )
    {
        if ( isdefined( attachment_name ) && attachment_name != "<dev string:x8c>" )
        {
            attachment_category = getscriptbundlefieldvalue( hashcat( %"hash_3c2c9813bb16552f", attachment_name ), #"category" );
            assert( isdefined( attachment_category ), "<dev string:x91>" );
        }
    }

#/

// Namespace weapon
// Params 1
// Checksum 0x45f0a2ec, Offset: 0x165e
// Size: 0x5e
function function_d2c8356dc369d9ce( weaponstring )
{
    attachments = getweapondefaultattachments( weaponstring );
    weaponobj = makeweapon( weaponstring, attachments );
    
    if ( isdefined( level.var_cfde89929188f64e ) && isdefined( weaponobj ) && isweapon( weaponobj ) )
    {
        weaponobj = self [[ level.var_cfde89929188f64e ]]( weaponobj );
    }
    
    return weaponobj;
}

// Namespace weapon
// Params 3
// Checksum 0xab89a83d, Offset: 0x16c5
// Size: 0x145
function giveweaponblueprint( weaponassetname, blueprint, camo )
{
    if ( !weaponexists( weaponassetname ) )
    {
        if ( isdefined( level.weaponmapdata[ weaponassetname ] ) )
        {
            weaponassetname = level.weaponmapdata[ weaponassetname ].assetname;
        }
        else
        {
            logstring( "[WEAPON] giveWeaponBlueprint FAILED, weaponAssetName is not in level.weaponMapData" + " | weaponAssetName: " + ( weaponassetname ?? "undefined" ) + " | blueprint: " + ( blueprint ?? "undefined" ) + " | camo: " + ( camo ?? "undefined" ) );
            return;
        }
    }
    
    variantid = 0;
    
    if ( isxhashasset( blueprint ) )
    {
        blueprints = getweaponblueprintnames( weaponassetname );
        
        foreach ( variant, id in blueprints )
        {
            if ( blueprint == variant )
            {
                variantid = id;
                break;
            }
        }
    }
    else
    {
        variantid = blueprint ?? 0;
    }
    
    return buildweapon( weaponassetname, undefined, camo, undefined, variantid );
}

// Namespace weapon
// Params 0
// Checksum 0x5255d06f, Offset: 0x1813
// Size: 0x7
function get_build_weapon()
{
    return &buildweapon;
}

// Namespace weapon
// Params 1
// Checksum 0x5d6ad0e8, Offset: 0x1823
// Size: 0x17
function isattachmentironsdefault( attachment )
{
    return issubstr( attachment, "ironsdefault_" );
}

// Namespace weapon
// Params 1
// Checksum 0x9c445952, Offset: 0x1843
// Size: 0x40
function attachmentmap_tocategory( attachmentname )
{
    assert( isdefined( level.var_cd6bd69e56b4e5b4 ), "<dev string:xd0>" );
    
    if ( isdefined( level.var_cd6bd69e56b4e5b4[ attachmentname ] ) )
    {
        return level.var_cd6bd69e56b4e5b4[ attachmentname ];
    }
}

// Namespace weapon
// Params 1
// Checksum 0xe5a970b0, Offset: 0x188c
// Size: 0x105
function attachmentmap_toextra( attachmentname )
{
    assert( isdefined( level.var_2e4b961b65909f5a ), "<dev string:x11e>" );
    
    if ( isdefined( level.var_2e4b961b65909f5a[ attachmentname ] ) )
    {
        extraattachments = [];
        extraattachmentlist = level.var_2e4b961b65909f5a[ attachmentname ];
        
        foreach ( entry in extraattachmentlist )
        {
            if ( !isdefined( entry.attachmentextra ) || entry.attachmentextra == "" )
            {
                continue;
            }
            
            extraattachments[ entry.attachmentextra ] = entry.attachmentextra;
        }
        
        return extraattachments;
    }
    
    return;
}

// Namespace weapon
// Params 0, eflags: 0x4
// Checksum 0xf407bf65, Offset: 0x1999
// Size: 0x4ac
function private buildattachmentmaps()
{
    assert( !isdefined( level.var_2e4b961b65909f5a ), "<dev string:x169>" );
    assert( !isdefined( level.weaponattachments ), "<dev string:x1ae>" );
    assert( !isdefined( level.weaponattachmentsmap ), "<dev string:x1f8>" );
    assert( isdefined( level.weaponmapdata ), "<dev string:x246>" );
    
    if ( game[ #"levelcache" ].weaponattachments )
    {
        level.var_2e4b961b65909f5a = game[ #"levelcache" ].var_2e4b961b65909f5a;
        level.weaponattachments = game[ #"levelcache" ].weaponattachments;
        level.var_cd6bd69e56b4e5b4 = game[ #"levelcache" ].var_cd6bd69e56b4e5b4;
        return;
    }
    
    level.var_2e4b961b65909f5a = [];
    level.weaponattachments = [];
    level.var_cd6bd69e56b4e5b4 = [];
    function_ea865062f19beca0();
    slotarray = [];
    
    foreach ( slot in level.attachmentslotarray )
    {
        slotarray[ slotarray.size ] = slot;
    }
    
    var_e5042059ee422f62 = [ #"lootid", #"category", #"hideinui", #"hash_febd8701371cdffe" ];
    
    foreach ( weaponnamekey in level.weaponmapdata )
    {
        if ( isdefined( weaponnamekey.assetname ) && isdefined( weaponnamekey.group ) )
        {
            foreach ( slot in slotarray )
            {
                var_bba76b2d884ae9dc = function_2e5ecdd8ac47f308( weaponnamekey.assetname, slot, 1 );
                
                if ( isdefined( var_bba76b2d884ae9dc ) )
                {
                    foreach ( attachment in var_bba76b2d884ae9dc )
                    {
                        attachmentdataname = function_333a08591af6b59( weaponnamekey.assetname, attachment );
                        
                        if ( isdefined( attachmentdataname ) )
                        {
                            bundle = getscriptbundlefieldvalues( attachmentdataname, var_e5042059ee422f62 );
                            
                            if ( isdefined( bundle.lootid ) )
                            {
                                if ( isdefined( level.weaponattachments[ attachment ] ) )
                                {
                                    continue;
                                }
                                
                                if ( ( bundle.var_7253350d567fa007.size ?? 0 ) > 0 )
                                {
                                    if ( !isdefined( level.var_2e4b961b65909f5a[ attachment ] ) )
                                    {
                                        level.var_2e4b961b65909f5a[ attachment ] = bundle.var_7253350d567fa007;
                                    }
                                }
                                
                                if ( bundle.hideinui )
                                {
                                    level.weaponattachments[ attachment ] = 0;
                                    continue;
                                }
                                
                                category = bundle.category;
                                
                                if ( isdefined( category ) && bundle.category != "NONE" )
                                {
                                    level.weaponattachments[ attachment ] = bundle.lootid;
                                    level.var_cd6bd69e56b4e5b4[ attachment ] = category;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    if ( !isdefined( game[ #"levelcache" ] ) )
    {
        game[ #"levelcache" ] = {};
    }
    
    game[ #"levelcache" ].var_2e4b961b65909f5a = level.var_2e4b961b65909f5a;
    game[ #"levelcache" ].weaponattachments = level.weaponattachments;
    game[ #"levelcache" ].var_cd6bd69e56b4e5b4 = level.var_cd6bd69e56b4e5b4;
}

// Namespace weapon
// Params 0
// Checksum 0x8085f9c5, Offset: 0x1e4d
// Size: 0x14c
function function_f0809b09de2ec21b()
{
    assert( isdefined( level.weaponmapdata ), "<dev string:x285>" );
    blueprintsarray = [];
    
    foreach ( weapon in level.weaponmapdata )
    {
        blueprints = getweaponblueprintnames( weapon.assetname );
        
        if ( blueprints.size > 0 )
        {
            blueprintsarray[ weapon.assetname ] = [];
            
            foreach ( id in blueprints )
            {
                blueprintsarray[ weapon.assetname ][ blueprintsarray[ weapon.assetname ].size ] = id;
            }
        }
    }
    
    return blueprintsarray;
}

// Namespace weapon
// Params 1
// Checksum 0xd33d4803, Offset: 0x1fa2
// Size: 0x216
function weaponattachremoveextraattachments( attachments )
{
    assert( isdefined( level.var_2e4b961b65909f5a ), "<dev string:x2cf>" );
    extraattachmentlist = [];
    
    foreach ( attachment in attachments )
    {
        var_f14127ae795ac414 = attachmentmap_toextra( attachment );
        
        if ( isdefined( var_f14127ae795ac414 ) )
        {
            extraattachmentlist[ extraattachmentlist.size ] = var_f14127ae795ac414;
        }
    }
    
    attachmentsfiltered = [];
    
    foreach ( attachment in attachments )
    {
        isextraattachment = 0;
        
        foreach ( extraattachments in extraattachmentlist )
        {
            foreach ( extraattach in extraattachments )
            {
                if ( attachment == extraattach )
                {
                    isextraattachment = 1;
                    break;
                }
            }
        }
        
        if ( !isextraattachment )
        {
            attachmentsfiltered[ attachmentsfiltered.size ] = attachment;
        }
    }
    
    return attachmentsfiltered;
}

// Namespace weapon
// Params 1
// Checksum 0xd80c61d0, Offset: 0x21c1
// Size: 0x17
function isakimbo( weapon )
{
    return getweaponhasperk( weapon, "specialty_akimbo" );
}

// Namespace weapon
// Params 2
// Checksum 0xea37d107, Offset: 0x21e1
// Size: 0x74
function getattachmentlootid( weaponname, attachref )
{
    if ( !isdefined( level.weaponattachments[ attachref ] ) )
    {
        lootinfo = utility::callsharedfunc( #"loot", #"getLootItemInfoFromRef", attachref );
        level.weaponattachments[ attachref ] = lootinfo.itemid ?? 0;
    }
    
    return level.weaponattachments[ attachref ];
}

// Namespace weapon
// Params 0
// Checksum 0x19a5feb9, Offset: 0x225e
// Size: 0xc7
function buildweaponrootlist()
{
    rootweapons = [];
    
    foreach ( weapon, data in level.weaponmapdata )
    {
        if ( isdefined( data.group ) )
        {
            if ( !issubstr( data.group, "weapon_" ) )
            {
                continue;
            }
            
            if ( data.group == "weapon_other" )
            {
                continue;
            }
            
            rootweapons[ rootweapons.size ] = weapon;
        }
    }
    
    return rootweapons;
}

/#

    // Namespace weapon
    // Params 1
    // Checksum 0x11c369f4, Offset: 0x232e
    // Size: 0x35, Type: dev
    function validateweaponassetnamemap( weaponroot )
    {
        if ( iskillstreakweapon( weaponroot ) )
        {
            return 1;
        }
        
        return isdefined( level.weaponmapdata[ weaponroot ].assetname );
    }

#/

// Namespace weapon
// Params 1
// Checksum 0xc05a5071, Offset: 0x236b
// Size: 0x63
function weaponassetnamemap( weaponroot )
{
    if ( weaponexists( weaponroot ) )
    {
        return weaponroot;
    }
    
    if ( iskillstreakweapon( weaponroot ) )
    {
        return weaponroot;
    }
    
    var_7237854e3be197ca = level.weaponmapdata[ weaponroot ].assetname;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    assertmsg( "<dev string:x323>" + weaponroot );
    return weaponroot;
}

// Namespace weapon
// Params 1
// Checksum 0x7cc1bb44, Offset: 0x23d7
// Size: 0x4e
function weapongroupmap( weaponroot )
{
    var_7237854e3be197ca = level.weaponmapdata[ weaponroot ].group;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    assert( isdefined( level.weaponmapdata ), "<dev string:x361>" );
}

// Namespace weapon
// Params 1
// Checksum 0xbd5bbb2b, Offset: 0x242e
// Size: 0x30, Type: bool
function weapondefinedinstatstable( weaponroot )
{
    assert( isdefined( level.weaponmapdata ), "<dev string:x3a1>" );
    return isdefined( level.weaponmapdata[ weaponroot ] );
}

// Namespace weapon
// Params 0, eflags: 0x4
// Checksum 0xc63b94f9, Offset: 0x2467
// Size: 0x6dc
function private buildweaponmap()
{
    assert( !isdefined( level.weaponmapdata ), "<dev string:x3e2>" );
    
    if ( game[ #"levelcache" ].weaponmapdata )
    {
        level.weaponmapdata = game[ #"levelcache" ].weaponmapdata;
        level.weapongroupdata = game[ #"levelcache" ].weapongroupdata;
        level.weaponlistbundle = game[ #"levelcache" ].weaponlistbundle;
        return;
    }
    
    level.weaponmapdata = [];
    level.weapongroupdata = [];
    weaponsscriptbundle = function_16ff7d597f441100();
    
    if ( isdefined( weaponsscriptbundle ) )
    {
        bundlevalues = [ #"ref", #"group", #"displayorder", #"asset", #"assetrefsp", #"name", #"perk", #"speedscale", #"hash_1469d2b702a6d5f8", #"lootid", #"botpersonality", #"isactivearmory", #"isknife", #"issharpmelee", #"hash_33b5234e67b833b8", #"hash_8fda8cc8830728a4" ];
        
        foreach ( weaponname in weaponsscriptbundle )
        {
            weaponscriptbundle = function_659a3e10e8d1c91c( weaponname, bundlevalues );
            weapon = weaponscriptbundle.ref;
            weapon_asset = undefined;
            
            if ( weaponexists( weaponscriptbundle.asset ) )
            {
                weapon_asset = weaponscriptbundle.asset;
            }
            
            if ( utility::issp() && weaponexists( weaponscriptbundle.assetrefsp ) )
            {
                weapon_asset = weaponscriptbundle.assetrefsp;
            }
            
            if ( isdefined( weapon_asset ) )
            {
                level.weaponmapdata[ weapon ] = spawnstruct();
                group = weaponscriptbundle.group;
                
                if ( group )
                {
                    level.weaponmapdata[ weapon ].group = group;
                    uidisplayorder = weaponscriptbundle.displayorder ?? 0;
                    
                    if ( uidisplayorder > -1 )
                    {
                        if ( !isdefined( level.weapongroupdata[ group ] ) )
                        {
                            level.weapongroupdata[ group ] = [];
                        }
                        
                        level.weapongroupdata[ group ][ level.weapongroupdata[ group ].size ] = weapon;
                    }
                    else
                    {
                        level.weaponmapdata[ weapon ].uihidden = 1;
                    }
                }
                
                assetname = weapon_asset;
                
                if ( assetname )
                {
                    level.weaponmapdata[ weapon ].assetname = assetname;
                }
                
                locname = weaponscriptbundle.name;
                
                if ( isdefined( locname ) && locname != &"" )
                {
                    level.weaponmapdata[ weapon ].locname = locname;
                }
                
                perk = weaponscriptbundle.perk;
                
                if ( perk )
                {
                    level.weaponmapdata[ weapon ].perk = perk;
                }
                
                level.weaponmapdata[ weapon ].weaponlootid = weaponscriptbundle.lootid;
                movespeed = weaponscriptbundle.speedscale;
                
                if ( isdefined( movespeed ) )
                {
                    level.weaponmapdata[ weapon ].speed = movespeed;
                    assert( movespeed > 0 && movespeed <= 1, "<dev string:x414>" + weapon );
                }
                
                var_d1f25dd2efe2402f = weaponscriptbundle.var_d1f25dd2efe2402f;
                
                if ( isdefined( var_d1f25dd2efe2402f ) )
                {
                    level.weaponmapdata[ weapon ].var_d1f25dd2efe2402f = var_d1f25dd2efe2402f;
                }
                
                activearmoryenabled = weaponscriptbundle.isactivearmory;
                
                if ( isdefined( activearmoryenabled ) )
                {
                    level.weaponmapdata[ weapon ].activearmoryenabled = activearmoryenabled;
                }
                
                if ( isequipmentaddon( weapon ) )
                {
                    level.weaponmapdata[ weapon ].isequipmentaddon = 1;
                }
                
                isknife = weaponscriptbundle.isknife;
                
                if ( isknife )
                {
                    level.weaponmapdata[ weapon ].isknife = 1;
                }
                
                issharpmelee = weaponscriptbundle.issharpmelee;
                
                if ( issharpmelee )
                {
                    level.weaponmapdata[ weapon ].issharpmelee = 1;
                }
                
                var_f95b721efa3c0163 = weaponscriptbundle.var_f95b721efa3c0163;
                
                if ( var_f95b721efa3c0163 )
                {
                    level.weaponmapdata[ weapon ].var_f95b721efa3c0163 = 1;
                }
                
                level.weaponmapdata[ weapon ].var_f94272fc69a3d88c = function_c37ac3c4f987e506( weaponname, #"hash_3930a0914066f49d", undefined );
                
                if ( level.var_431d3dd6b0605770 && weaponscriptbundle.var_a1ce61685bb64675 )
                {
                    var_a0ef3eb4cc0fb2d5 = getscriptbundlefieldvalues( weaponscriptbundle.var_a1ce61685bb64675, [ #"ref", #"lootid", #"activearmoryenabled" ] );
                    
                    if ( var_a0ef3eb4cc0fb2d5.lootid )
                    {
                        level.weaponmapdata[ weapon ].var_a1ce61685bb64675 = var_a0ef3eb4cc0fb2d5.ref;
                        level.weaponmapdata[ weapon ].var_3e7499a2a2de17ea = var_a0ef3eb4cc0fb2d5.lootid;
                        level.weaponmapdata[ weapon ].activearmoryenabled = var_a0ef3eb4cc0fb2d5.activearmoryenabled;
                    }
                }
            }
        }
    }
    
    if ( !isdefined( game[ #"levelcache" ] ) )
    {
        game[ #"levelcache" ] = {};
    }
    
    game[ #"levelcache" ].weaponmapdata = level.weaponmapdata;
    game[ #"levelcache" ].weapongroupdata = level.weapongroupdata;
    game[ #"levelcache" ].weaponlistbundle = level.weaponlistbundle;
}

// Namespace weapon
// Params 0, eflags: 0x4
// Checksum 0x36e6b719, Offset: 0x2b4b
// Size: 0x318
function private function_47c21f91a5f180b8()
{
    assert( !isdefined( level.weaponmappedcamos ), "<dev string:x44a>" );
    
    if ( game[ #"levelcache" ].weaponmappedcamos )
    {
        level.weaponmappedcamos = game[ #"levelcache" ].weaponmappedcamos;
        return;
    }
    
    level.weaponmappedcamos = [];
    camolistbundle = undefined;
    camofields = [ #"ref", #"weaponref", #"lootid", #"weaponclass" ];
    
    if ( isdefined( level.gamemodebundle.weaponcamolist ) )
    {
        camolistbundle = getscriptbundle( level.gamemodebundle.weaponcamolist );
    }
    
    if ( !( isdefined( camolistbundle ) && isdefined( camolistbundle.camo_list ) ) )
    {
        return;
    }
    
    foreach ( camoname in camolistbundle.camo_list )
    {
        if ( !isdefined( camoname.camodata ) )
        {
            continue;
        }
        
        camobundle = getscriptbundlefieldvalues( camoname.camodata, camofields );
        
        /#
            function_ce79080c3dd2d8ba( camobundle.ref, camoname.camodata );
        #/
        
        mappings = [ camobundle.weaponref, camobundle.weaponclass ];
        pathway = undefined;
        
        foreach ( param in mappings )
        {
            if ( tolower( param ) != "none" )
            {
                if ( isdefined( pathway ) )
                {
                    assertmsg( "<dev string:x486>" );
                    println( getxhashsourcename( camoname.camodata ) + "<dev string:x4ba>" );
                    break;
                }
                
                pathway = param;
            }
        }
        
        if ( isdefined( pathway ) )
        {
            if ( !isdefined( level.weaponmappedcamos[ pathway ] ) )
            {
                level.weaponmappedcamos[ pathway ] = [];
            }
            
            level.weaponmappedcamos[ pathway ][ camobundle.ref ] = camobundle.lootid;
        }
    }
    
    /#
        function_1f7dda67483b1149();
    #/
    
    if ( !isdefined( game[ #"levelcache" ] ) )
    {
        game[ #"levelcache" ] = {};
    }
    
    game[ #"levelcache" ].weaponmappedcamos = level.weaponmappedcamos;
}

/#

    // Namespace weapon
    // Params 2
    // Checksum 0x9b4aac5b, Offset: 0x2e6b
    // Size: 0x67, Type: dev
    function function_ce79080c3dd2d8ba( camoreference, bundlename )
    {
        if ( !isdefined( level.var_63473892ef2a718e ) )
        {
            level.var_63473892ef2a718e = [];
        }
        
        if ( !isdefined( level.var_63473892ef2a718e[ camoreference ] ) )
        {
            level.var_63473892ef2a718e[ camoreference ] = [];
        }
        
        level.var_63473892ef2a718e[ camoreference ][ level.var_63473892ef2a718e[ camoreference ].size ] = bundlename;
    }

    // Namespace weapon
    // Params 0
    // Checksum 0x170bd8de, Offset: 0x2eda
    // Size: 0xb9, Type: dev
    function function_1f7dda67483b1149()
    {
        if ( !isdefined( level.var_63473892ef2a718e ) )
        {
            println( "<dev string:x4f9>" );
            return;
        }
        
        foreach ( camoname, camo in level.var_63473892ef2a718e )
        {
            if ( camo.size == 1 )
            {
                level.var_63473892ef2a718e[ camoname ] = undefined;
            }
        }
        
        level.var_63473892ef2a718e = function_f943bef551ff028c( level.var_63473892ef2a718e );
    }

#/

// Namespace weapon
// Params 1
// Checksum 0x141a512d, Offset: 0x2f9b
// Size: 0x6d
function function_d5894d0f984841a( rootname )
{
    weaponclass = level.weaponmapdata[ rootname ].group ?? undefined;
    rootcamos = level.weaponmappedcamos[ rootname ] ?? [];
    classcamos = level.weaponmappedcamos[ weaponclass ] ?? [];
    return arraycombine( rootcamos, classcamos );
}

// Namespace weapon
// Params 1
// Checksum 0x81afdfc4, Offset: 0x3011
// Size: 0x1d9
function function_2b94fc4d332569a5( objweapon )
{
    if ( !isweapon( objweapon ) )
    {
        assertmsg( "<dev string:x52c>" );
        return;
    }
    else if ( !isdefined( objweapon.camo ) )
    {
        return;
    }
    
    rootname = getweaponrootstring( objweapon );
    weaponclass = level.weaponmapdata[ rootname ].group ?? undefined;
    mappings = [ rootname, weaponclass ];
    lootid = function_9fda321f45a32fa3( mappings, objweapon.camo );
    
    if ( !isdefined( lootid ) )
    {
        /#
            if ( isdefined( level.var_63473892ef2a718e[ objweapon.camo ] ) )
            {
                bundles = level.var_63473892ef2a718e[ objweapon.camo ];
                bundle_names = [];
                
                for ( i = 0; i < bundles.size && i < 5 ; i++ )
                {
                    if ( !isdefined( bundle_names ) )
                    {
                        bundle_names = [];
                    }
                    
                    bundle_names[ bundle_names.size ] = getxhashsourcename( bundles[ i ] );
                }
                
                assertmsg( "<dev string:x556>" + "<dev string:x576>" + objweapon.basename + "<dev string:x580>" + objweapon.camo + "<dev string:x588>" + bundles.size + "<dev string:x59d>" + "<dev string:x5a1>" + function_5d044133536d0766( "<dev string:x5a3>", bundle_names ) + ( bundles.size > 5 ? "<dev string:x5a6>" : "<dev string:x5ae>" ) + "<dev string:x5b1>" );
            }
        #/
        
        itemstruct = utility::callsharedfunc( #"loot", #"getLootItemInfoFromRef", objweapon.camo );
        
        if ( isdefined( itemstruct ) )
        {
            lootid = itemstruct.itemid;
        }
    }
    
    return lootid;
}

// Namespace weapon
// Params 2
// Checksum 0x4cd68430, Offset: 0x31f3
// Size: 0x9f
function function_9fda321f45a32fa3( mappings, camo )
{
    foreach ( param in mappings )
    {
        var_7237854e3be197ca = level.weaponmappedcamos[ param ][ camo ];
        
        if ( isdefined( var_7237854e3be197ca ) )
        {
            return var_7237854e3be197ca;
        }
    }
}

// Namespace weapon
// Params 2
// Checksum 0xcc02b5be, Offset: 0x329b
// Size: 0x89
function getweaponattachmentdefaultattachments( weaponassetname, attachments )
{
    if ( isdefined( attachments ) )
    {
        sortedattachments = utility::alphabetize( attachments );
        
        for ( attachmentindex = 0; attachmentindex < sortedattachments.size ; attachmentindex++ )
        {
            attachment = sortedattachments[ attachmentindex ];
            
            if ( attachment != "none" && ( attachmentindex == 0 || attachment != sortedattachments[ attachmentindex - 1 ] ) )
            {
                weaponassetname = weaponassetname + "+" + attachment;
            }
        }
    }
    
    return getweapondefaultattachments( weaponassetname );
}

// Namespace weapon
// Params 2
// Checksum 0x44fe4de8, Offset: 0x332d
// Size: 0xcf
function getbaseweaponattachdefaulttoidmap( weapon, attachments )
{
    assetname = getweaponassetname( weapon );
    
    if ( !isdefined( assetname ) )
    {
        assetname = weapon;
    }
    
    defaultattachments = getweaponattachmentdefaultattachments( assetname, attachments );
    
    if ( isdefined( defaultattachments ) && defaultattachments.size > 0 )
    {
        defaulttoidmap = [];
        
        foreach ( defaultattachment in defaultattachments )
        {
            defaulttoidmap[ defaultattachment ] = 0;
        }
        
        return defaulttoidmap;
    }
}

// Namespace weapon
// Params 1
// Checksum 0x3e3bac4e, Offset: 0x3405
// Size: 0xd9
function parseattachdefaulttoidmap( attachmentdefaults )
{
    if ( attachmentdefaults != "" )
    {
        defaultkvps = strtok( attachmentdefaults, " " );
        defaulttoidmap = [];
        
        foreach ( kvp in defaultkvps )
        {
            pair = strtok( kvp, "|" );
            
            if ( pair.size == 2 )
            {
                defaulttoidmap[ pair[ 0 ] ] = int( pair[ 1 ] );
                continue;
            }
            
            defaulttoidmap[ pair[ 0 ] ] = 0;
        }
        
        return defaulttoidmap;
    }
}

// Namespace weapon
// Params 1
// Checksum 0x53a7b49f, Offset: 0x34e7
// Size: 0x22
function getweaponassetname( rootname )
{
    return level.weaponmapdata[ rootname ].assetname;
}

// Namespace weapon
// Params 1
// Checksum 0x80728dce, Offset: 0x3512
// Size: 0x48
function getweaponname( weapon )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "<dev string:x5de>" );
        return "none";
    }
    
    if ( isweapon( weapon ) )
    {
        return weapon.basename;
    }
    
    return getweaponassetname( weapon ) ?? weapon;
}

// Namespace weapon
// Params 1
// Checksum 0xa3a06680, Offset: 0x3563
// Size: 0x48
function isfistweaponobject( weaponobj )
{
    if ( weaponobj === level.defaultfist )
    {
        return 1;
    }
    
    rootname = getweaponrootname( weaponobj );
    return level.weaponmapdata[ rootname ].var_f95b721efa3c0163;
}

// Namespace weapon
// Params 1
// Checksum 0x49a47607, Offset: 0x35b4
// Size: 0x28
function isfistweapon( weapon )
{
    weaponobj = utility::function_64003742d8f5c781( weapon );
    return isfistweaponobject( weaponobj );
}

// Namespace weapon
// Params 1
// Checksum 0x31809ab, Offset: 0x35e5
// Size: 0x28, Type: bool
function isunderwaterweaponobject( weaponobj )
{
    return weaponobj === level.defaultswimweapon || weaponobj === level.var_f51157de397416bd;
}

// Namespace weapon
// Params 1
// Checksum 0x44333dfe, Offset: 0x3616
// Size: 0x28, Type: bool
function isunderwaterweapon( weapon )
{
    weaponobj = utility::function_64003742d8f5c781( weapon );
    return isunderwaterweaponobject( weaponobj );
}

// Namespace weapon
// Params 1
// Checksum 0x20d7255a, Offset: 0x3647
// Size: 0x18, Type: bool
function isclimbweaponobject( weaponobj )
{
    return weaponobj === level.var_f8ac15ada97a702a;
}

// Namespace weapon
// Params 1
// Checksum 0x21b5dac7, Offset: 0x3668
// Size: 0x28, Type: bool
function isclimbweapon( weapon )
{
    weaponobj = utility::function_64003742d8f5c781( weapon );
    return isclimbweaponobject( weaponobj );
}

// Namespace weapon
// Params 1
// Checksum 0x74bd05c9, Offset: 0x3699
// Size: 0x47
function function_170e300815e9c1a2( weaponobj )
{
    cachedvalue = level.weaponrootcache[ weaponobj.basename ];
    
    if ( isdefined( cachedvalue ) )
    {
        return cachedvalue;
    }
    
    return function_bed9d35e3ab4a80c( weaponobj.basename );
}

// Namespace weapon
// Params 1
// Checksum 0x924f2e18, Offset: 0x36e9
// Size: 0x53, Type: bool
function function_52f1736c4c1b06d4( weapon )
{
    if ( !weapon )
    {
        return false;
    }
    
    weaponroot = function_170e300815e9c1a2( weapon );
    
    if ( !weaponroot )
    {
        return false;
    }
    
    weaponrarity = function_c37ac3c4f987e506( weaponroot, #"rarity" );
    return weaponrarity == "EXOTIC";
}

// Namespace weapon
// Params 1
// Checksum 0x4a675c3a, Offset: 0x3745
// Size: 0x83, Type: bool
function function_6a1dd038cf91761d( weapon )
{
    if ( !weapon )
    {
        return false;
    }
    
    weaponroot = function_170e300815e9c1a2( weapon );
    
    if ( !weaponroot )
    {
        return false;
    }
    
    if ( isdefined( weapon.override ) && issubstr( weapon.override, "royalty" ) || isdefined( weapon.dynamic ) && issubstr( weapon.dynamic, "royalty" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace weapon
// Params 1
// Checksum 0xae84116e, Offset: 0x37d1
// Size: 0x76
function getweaponrootname( weapon )
{
    if ( isweapon( weapon ) )
    {
        return function_170e300815e9c1a2( weapon );
    }
    else if ( isstring( weapon ) )
    {
        cachedvalue = level.weaponrootcache[ weapon ];
        
        if ( isdefined( cachedvalue ) )
        {
            return cachedvalue;
        }
        
        return function_bed9d35e3ab4a80c( weapon );
    }
    else if ( !isdefined( weapon ) )
    {
        return "none";
    }
    
    assertmsg( "<dev string:x618>" );
    return "none";
}

// Namespace weapon
// Params 1, eflags: 0x4
// Checksum 0x5b2bfa1, Offset: 0x3850
// Size: 0x4b4
function private function_bed9d35e3ab4a80c( weaponname )
{
    if ( !isstring( weaponname ) )
    {
        return "none";
    }
    
    if ( !isdefined( level.weaponrootcache ) )
    {
        level.weaponrootcache = [];
    }
    
    if ( getdvarint( @"hash_4d6608977410d9b7", 0 ) == 1 )
    {
        rootname = undefined;
        
        if ( isdefined( level.weaponmapdata[ weaponname ] ) )
        {
            return weaponname;
        }
        else
        {
            foreach ( rootname, data in level.weaponmapdata )
            {
                if ( weaponname === level.weaponmapdata[ rootname ].assetname )
                {
                    level.weaponrootcache[ weaponname ] = rootname;
                    return rootname;
                }
            }
        }
    }
    
    if ( weaponname == "iw9_lm_dblmg_jup_sp_v1" || weaponname == "iw9_lm_dblmg_jup_mp" || weaponname == "iw9_lm_dblmg_jup" )
    {
        return "iw9_lm_dblmg_jup";
    }
    
    if ( weaponname == "jup_p33_me_tac_knife03_v6501" )
    {
        return "iw9_me_knife";
    }
    
    originalname = weaponname;
    tokens = strtok( weaponname, "_" );
    toksize = tokens.size;
    
    if ( toksize == 0 )
    {
        return "none";
    }
    
    index = 0;
    
    if ( tokens[ 0 ] == "alt" )
    {
        index++;
    }
    
    if ( tokens[ index ] == "iw8" || tokens[ index ] == "iw9" || tokens[ index ] == "t10" || tokens[ index ] == "jup" || tokens[ index ] == "sat" || tokens[ index ] == "rex" || tokens[ index ] == "zul" || tokens[ index ] == "kra" )
    {
        var_aedd151289ff3a0d = 0;
        classtokens = [ "ar", "sm", "lm", "sh", "sn", "dm", "pi", "la", "me", "br", "sl", "ks", "pw", "ww" ];
        
        if ( tokens[ index ] == "jup" && toksize >= 4 && arraycontains( classtokens, tokens[ index + 2 ] ) )
        {
            weaponname = function_5d044133536d0766( "_", tokens, index, 4 );
            var_aedd151289ff3a0d = isdefined( level.weaponmapdata[ weaponname ] );
            
            if ( !var_aedd151289ff3a0d )
            {
                var_75f736509be71099 = 0;
                tmptokens = [];
                
                if ( tokens[ index + 1 ] == "iw9" )
                {
                    var_75f736509be71099 = index + 1;
                }
                else
                {
                    var_75f736509be71099 = index + 2;
                    tmptokens[ tmptokens.size ] = "iw9";
                }
                
                for ( i = var_75f736509be71099; i < tokens.size ; i++ )
                {
                    tmptokens[ tmptokens.size ] = tokens[ i ];
                }
                
                tokens = tmptokens;
                toksize = tokens.size;
            }
        }
        
        if ( !var_aedd151289ff3a0d )
        {
            if ( isdefined( tokens[ index + 1 ] ) && arraycontains( classtokens, tokens[ index + 1 ] ) )
            {
                is_zombie_weapon = tokens.size >= index + 2 && tokens[ index + 2 ] == "zombie";
                
                if ( tokens.size >= index + 4 && tokens[ index ] == "t10" && tokens[ index + 3 ] != "mp" || is_zombie_weapon )
                {
                    weaponname = tokens[ index ] + "_" + tokens[ index + 1 ] + "_" + tokens[ index + 2 ] + "_" + tokens[ index + 3 ];
                }
                else if ( tokens.size >= index + 4 && tokens[ index ] == "zul" && tokens[ index + 1 ] == "pw" )
                {
                    weaponname = tokens[ index ] + "_" + tokens[ index + 1 ] + "_" + tokens[ index + 2 ] + "_" + tokens[ index + 3 ];
                }
                else
                {
                    weaponname = tokens[ index ] + "_" + tokens[ index + 1 ] + "_" + tokens[ index + 2 ];
                }
            }
            else
            {
                weaponname = tokens[ index ] + "_" + tokens[ index + 1 ];
            }
        }
    }
    
    if ( level.weaponrootcache.size > 400 )
    {
        level.weaponrootcache = [];
    }
    
    level.weaponrootcache[ originalname ] = weaponname;
    return weaponname;
}

// Namespace weapon
// Params 1
// Checksum 0xc6486578, Offset: 0x3d0d
// Size: 0x179
function getweaponclasstoken( weapon )
{
    weaponobj = utility::function_64003742d8f5c781( weapon );
    rootname = getweaponrootname( weaponobj );
    weapongroup = weapongroupmap( rootname );
    potentialtoken = "ar";
    
    switch ( weapongroup )
    {
        case #"hash_8af0086b038622b5":
        case #"hash_dd616da0b395a0b0":
            potentialtoken = "ar";
            break;
        case #"hash_bef5ec0b3e197ae":
            potentialtoken = "lm";
            break;
        case #"hash_c095d67337b1f5a1":
            potentialtoken = "ar";
            break;
        case #"hash_47368bc0d2ef1565":
            potentialtoken = "dm";
            break;
        case #"hash_34340d457a63e7f1":
            potentialtoken = "ar";
            break;
        case #"hash_ab10f9c080fe4faf":
            potentialtoken = "sm";
            break;
        case #"hash_16cf6289ab06bd30":
            potentialtoken = "sh";
            break;
        case #"hash_9d18adab1b65a661":
            potentialtoken = "la";
            break;
        case #"hash_86b11ac21f992552":
        case #"hash_a1f27f97be15d620":
            potentialtoken = "me";
            break;
        case #"hash_2535634d8bb5c955":
            potentialtoken = "ww";
            break;
        default:
            assertmsg( "<dev string:x65d>" + weaponobj.basenamehash );
            return;
    }
    
    return potentialtoken;
}

// Namespace weapon
// Params 2
// Checksum 0x8385b2a6, Offset: 0x3e8f
// Size: 0xfb
function function_2374da6f1b4fad4e( weaponname, variantid )
{
    if ( !isdefined( weaponname ) || weaponname == "none" || !isdefined( variantid ) || variantid == 0 )
    {
        return [];
    }
    
    ignorelist = [];
    var_3c796252addcd009 = function_7d4df70b836c0973( weaponname, variantid );
    var_b19fd3e8f03cc95c = %"hash_6064c8c15b75fb65";
    
    foreach ( attachment, override in var_3c796252addcd009 )
    {
        category = attachmentmap_tocategory( attachment );
        
        if ( isdefined( category ) && category != var_b19fd3e8f03cc95c )
        {
            ignorelist[ ignorelist.size ] = attachment;
        }
    }
    
    return ignorelist;
}

// Namespace weapon
// Params 2
// Checksum 0xf3594939, Offset: 0x3f93
// Size: 0x1c
function issilencerattach( weapon, attachment )
{
    return issilencedattachment( weapon, attachment );
}

// Namespace weapon
// Params 1
// Checksum 0x28f36f62, Offset: 0x3fb8
// Size: 0xd5, Type: bool
function weaponsupportslaserir( weaponobj )
{
    if ( isminigunweapon( weaponobj ) )
    {
        return false;
    }
    
    switch ( weaponobj.basenamehash )
    {
        case %"hash_73d81ba1da5e262":
        case %"iw9_lm_dblmg_execution_mp":
        case %"iw9_me_riotshield_mp":
            return false;
    }
    
    if ( iskillstreakweapon( weaponobj ) )
    {
        return false;
    }
    
    if ( isdefined( weaponobj ) && isdefined( weaponobj.variantid ) && weaponobj.extra == "charlie725_doom_blueprint_tuning" )
    {
        return false;
    }
    
    class = weaponclass( weaponobj );
    return class == "rifle" || class == "mg" || class == "sniper" || class == "smg" || class == "spread";
}

// Namespace weapon
// Params 1
// Checksum 0x9c49eed9, Offset: 0x4096
// Size: 0x54, Type: bool
function iskillstreakplayerweapon( weapon )
{
    weapname = getweaponname( weapon );
    
    if ( issubstr( weapname, "_mp" ) )
    {
        if ( iskillstreakweaponname( weapname ) )
        {
            if ( function_10d338d2560c67b2( weapname ) || isminigunweapon( weapname ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace weapon
// Params 1
// Checksum 0x67632458, Offset: 0x40f3
// Size: 0x7e, Type: bool
function issuperuseweapon( weapon )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "<dev string:x6ab>" );
        return false;
    }
    
    weaponnamekey = isxhashasset( weapon ) ? weapon : isstring( weapon ) ? getxhashasset( weapon ) : weapon.basenamehash;
    
    if ( function_bebce04e93b55bfc( weaponnamekey ) )
    {
        return true;
    }
    
    return isdefined( level.superglobals.superweapons[ weaponnamekey ] );
}

// Namespace weapon
// Params 1
// Checksum 0x9b4b8a3, Offset: 0x417a
// Size: 0x70, Type: bool
function issupergestureweapon( weapon )
{
    weaponobj = utility::function_64003742d8f5c781( weapon );
    
    if ( !isdefined( weaponobj ) )
    {
        return false;
    }
    
    switch ( weaponobj.basenamehash )
    {
        case %"battlerage_nebulizer_mp":
        case %"electric_discharge_mp":
        case %"tempv_mp":
        case %"emp_pulse_device_mp":
            return true;
    }
    
    return false;
}

// Namespace weapon
// Params 1
// Checksum 0x2af3c737, Offset: 0x41f3
// Size: 0x55
function function_bebce04e93b55bfc( var_b541b98c7febbc0 )
{
    if ( !isdefined( var_b541b98c7febbc0 ) )
    {
        assertmsg( "<dev string:x6ed>" );
        return 0;
    }
    
    switch ( var_b541b98c7febbc0 )
    {
        case %"iw9_pi_stimpistol_mp":
        case %"iw9_oxygenmask_mp":
            return 1;
        default:
            return 0;
    }
}

// Namespace weapon
// Params 1
// Checksum 0x2d3f6a5d, Offset: 0x4250
// Size: 0x78, Type: bool
function function_dec9dc19786bb57a( weapon )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "<dev string:x734>" );
        return false;
    }
    
    weapname = undefined;
    
    if ( isweapon( weapon ) )
    {
        if ( isnullweapon( weapon ) )
        {
            return false;
        }
        
        weapname = weapon.basename;
    }
    else
    {
        if ( weapon == "none" )
        {
            return false;
        }
        
        weapname = weapon;
    }
    
    return weapname == "iw9_oxygenmask" || weapname == "iw9_oxygenmask_mp";
}

// Namespace weapon
// Params 1
// Checksum 0x59bc558d, Offset: 0x42d1
// Size: 0x53, Type: bool
function isminigunweapon( weapon )
{
    weapon = utility::function_64003742d8f5c781( weapon );
    
    if ( !isdefined( weapon ) )
    {
        assertmsg( "<dev string:x778>" );
        return false;
    }
    
    weaponroot = function_170e300815e9c1a2( weapon );
    return istrue( function_c37ac3c4f987e506( weaponroot, #"isminigun", 0 ) );
}

// Namespace weapon
// Params 1
// Checksum 0xf2a734fc, Offset: 0x432d
// Size: 0x19, Type: bool
function iskillstreakweaponname( weaponname )
{
    return isdefined( level.killstreakweaponmap[ weaponname ] );
}

// Namespace weapon
// Params 1
// Checksum 0x95647f9c, Offset: 0x434f
// Size: 0x1a, Type: bool
function iskillstreakweapon( weapon )
{
    return iskillstreakweaponname( getweaponname( weapon ) );
}

// Namespace weapon
// Params 1
// Checksum 0xcae80949, Offset: 0x4372
// Size: 0x19, Type: bool
function function_10d338d2560c67b2( weaponname )
{
    return isdefined( level.var_4d7a26dff433ac89[ weaponname ] );
}

// Namespace weapon
// Params 1
// Checksum 0x6033ac8b, Offset: 0x4394
// Size: 0x19, Type: bool
function function_597e1c0b6df2fada( weaponname )
{
    return isdefined( level.var_4295719b442b453d[ weaponname ] );
}

// Namespace weapon
// Params 1
// Checksum 0xb0b6bafb, Offset: 0x43b6
// Size: 0x28, Type: bool
function function_1344ad15d2d7bd21( weapon )
{
    weaponname = getweaponname( weapon );
    return function_597e1c0b6df2fada( weaponname );
}

// Namespace weapon
// Params 1
// Checksum 0xe14dcd8d, Offset: 0x43e7
// Size: 0x7b, Type: bool
function function_6011e4dd56d52c6f( weapon )
{
    weaponname = getweaponname( weapon );
    
    if ( !isdefined( level.killstreakweaponmap[ weaponname ] ) )
    {
        return false;
    }
    
    streakname = level.killstreakweaponmap[ weaponname ];
    bundle = level.streakglobals.streakbundles[ streakname ];
    
    if ( bundle.var_6437ad480a081375 )
    {
        return false;
    }
    
    return true;
}

// Namespace weapon
// Params 2
// Checksum 0xab265c20, Offset: 0x446b
// Size: 0x44
function registerkillstreakweaponmap( streakname, var_bf295ddc16ebf8a0 )
{
    if ( !isdefined( level.killstreakweaponmap ) )
    {
        level.killstreakweaponmap = [];
    }
    
    level.killstreakweaponmap[ var_bf295ddc16ebf8a0 ] = streakname;
    registerkillstreakweapon( getxhashasset( streakname ) );
}

// Namespace weapon
// Params 1
// Checksum 0xd80804e5, Offset: 0x44b7
// Size: 0x31
function registerplayerkillstreakweapon( weaponname )
{
    if ( !isdefined( level.var_4d7a26dff433ac89 ) )
    {
        level.var_4d7a26dff433ac89 = [];
    }
    
    level.var_4d7a26dff433ac89[ weaponname ] = 1;
}

// Namespace weapon
// Params 0
// Checksum 0xee0eef51, Offset: 0x44f0
// Size: 0x483
function initkillstreakweaponmap()
{
    if ( !isdefined( level.killstreakweaponmap ) )
    {
        level.killstreakweaponmap = [];
    }
    
    level.killstreakweaponmap[ "tacops_beacon_mp" ] = "marker";
    level.killstreakweaponmap[ "radar_drone_proj_mp" ] = "radar_drone_recon";
    level.killstreakweaponmap[ "gunship_105mm_mp" ] = "gunship";
    level.killstreakweaponmap[ "manual_turret_mp" ] = "manual_turret";
    level.killstreakweaponmap[ "nuke_mp" ] = "nuke";
    level.killstreakweaponmap[ "artillery_mp" ] = "precision_airstrike";
    level.killstreakweaponmap[ "iw9_spotter_scope_mp" ] = "precision_airstrike";
    level.killstreakweaponmap[ "deploy_airdrop_mp" ] = "airdrop";
    level.killstreakweaponmap[ "deploy_airdrop_sticky_mp" ] = "airdrop";
    level.killstreakweaponmap[ "nuke_multi_mp" ] = "nuke_multi";
    level.killstreakweaponmap[ "cruise_proj_mp" ] = "cruise_predator";
    level.killstreakweaponmap[ "pac_sentry_turret_mp" ] = "pac_sentry";
    level.killstreakweaponmap[ "toma_proj_mp" ] = "toma_strike";
    level.killstreakweaponmap[ "iw9_laser_large_ir_mp" ] = "toma_strike";
    level.killstreakweaponmap[ "chopper_gunner_turret_mp" ] = "chopper_gunner";
    level.killstreakweaponmap[ "chopper_gunner_proj_mp" ] = "chopper_gunner";
    level.killstreakweaponmap[ "chopper_gunner_turret_cp" ] = "chopper_gunner";
    level.killstreakweaponmap[ "chopper_gunner_proj_cp" ] = "chopper_gunner";
    level.killstreakweaponmap[ "fuelstrike_proj_mp" ] = "fuel_airstrike";
    level.killstreakweaponmap[ "chopper_support_turret_mp" ] = "chopper_support";
    level.killstreakweaponmap[ "chopper_support_turret_br" ] = "chopper_support";
    level.killstreakweaponmap[ "deploy_sentry_mp" ] = "sentry_gun";
    level.killstreakweaponmap[ "sentry_turret_mp" ] = "sentry_gun";
    level.killstreakweaponmap[ "hover_jet_turret_mp" ] = "hover_jet";
    level.killstreakweaponmap[ "hover_jet_proj_mp" ] = "hover_jet";
    level.killstreakweaponmap[ "hover_jet_bomb_mp" ] = "hover_jet";
    level.killstreakweaponmap[ "iw9_minigunksjugg_mp" ] = "juggernaut";
    level.killstreakweaponmap[ "iw9_minigunksjugg_reload_mp" ] = "juggernaut";
    level.killstreakweaponmap[ "deploy_juggernaut_mp" ] = "juggernaut";
    level.killstreakweaponmap[ "assault_drone_mp" ] = "assault_drone";
    level.killstreakweaponmap[ "assault_drone_danger_mp" ] = "assault_drone";
    level.killstreakweaponmap[ "airdrop_escort_turret_mp" ] = "airdrop_escort";
    level.killstreakweaponmap[ "super_laser_charge_mp" ] = "super_laser_charge";
    level.killstreakweaponmap[ "electric_discharge_mp" ] = "super_electric_discharge";
    level.killstreakweaponmap[ "high_jump_mp" ] = "super_high_jump";
    level.killstreakweaponmap[ "airdrop_escort_turret_ballistics_mp" ] = "airdrop_escort";
    level.killstreakweaponmap[ "chopper_gunner_turret_ballistics_mp" ] = "chopper_gunner";
    level.killstreakweaponmap[ "hover_jet_turret_ballistics_mp" ] = "hover_jet";
    level.killstreakweaponmap[ "switchblade_drone_mp" ] = "switchblade_drone";
    level.killstreakweaponmap[ "lrad_mp" ] = "lrad";
    level.killstreakweaponmap[ "deploy_remote_turret_mp" ] = "remote_turret";
    level.killstreakweaponmap[ "remote_turret_mp" ] = "remote_turret";
    level.killstreakweaponmap[ "loitering_munition_proj_mp" ] = "loitering_munition";
    level.killstreakweaponmap[ "deploy_missileturret_jup_mp" ] = "missile_turret";
    level.killstreakweaponmap[ "missile_turret_proj_jup_mp" ] = "missile_turret";
    level.killstreakweaponmap[ "drone_swarm_drone_mp" ] = "drone_swarm";
    level.killstreakweaponmap[ "toma_proj_jup_mp" ] = "toma_strike";
    level.killstreakweaponmap[ "bunker_buster_proj_jup_mp" ] = "bunker_buster";
    
    foreach ( killstreak, killstreakweapon in level.killstreakweaponmap )
    {
        registerkillstreakweapon( getxhashasset( killstreak ) );
    }
}

// Namespace weapon
// Params 1
// Checksum 0xb1d6f24c, Offset: 0x497b
// Size: 0x62, Type: bool
function function_ea0f95c57e71d5b4( weapon )
{
    weaponname = getweaponname( weapon );
    
    if ( isdefined( level.killstreakweaponmap[ weaponname ] ) )
    {
        switch ( weaponname )
        {
            case #"hash_10480ca9423043c7":
            case #"hash_4cdc20240e59faaf":
            case #"hash_9acbd2b1e30a8e0e":
                return true;
        }
    }
    
    return false;
}

// Namespace weapon
// Params 2
// Checksum 0x4a395cd6, Offset: 0x49e6
// Size: 0x12b, Type: bool
function function_47517374aa9c98b7( weapon, attachmentname )
{
    if ( attachmentname == "none" )
    {
        return true;
    }
    
    if ( !isdefined( weapon ) || isstring( weapon ) && ( weapon == "none" || weapon == "" ) )
    {
        return false;
    }
    
    if ( level.var_97c435b95635519c.weapon == weapon )
    {
        weaponasset = level.var_97c435b95635519c.weaponasset;
        weaponattachments = level.var_97c435b95635519c.weaponattachments;
    }
    else
    {
        rootname = getweaponrootname( weapon );
        weaponasset = weaponassetnamemap( rootname );
        weaponattachments = function_94e534c2a4d98789( weaponasset );
        level.var_97c435b95635519c = { #weaponattachments:weaponattachments, #weaponasset:weaponasset, #weapon:weapon };
    }
    
    attachmentslot = getattachmentslot( weaponasset, attachmentname );
    attachmentarray = weaponattachments[ attachmentslot ];
    
    if ( isdefined( attachmentarray ) && arraycontains( attachmentarray, attachmentname ) )
    {
        return true;
    }
    
    return false;
}

// Namespace weapon
// Params 2
// Checksum 0x8c845ee0, Offset: 0x4b1a
// Size: 0x6a
function function_668a13182805f553( weapon, playerdatavalue )
{
    if ( function_47517374aa9c98b7( weapon, playerdatavalue ) )
    {
        return playerdatavalue;
    }
    
    println( "<dev string:x7b9>" + playerdatavalue );
    rootname = getweaponrootname( weapon );
    weaponasset = weaponassetnamemap( rootname );
    return getattachmentfromslotandindex( weaponasset, "receiver", 0 );
}

// Namespace weapon
// Params 1
// Checksum 0xff2813c5, Offset: 0x4b8c
// Size: 0x8e
function getweaponnvgattachment( weaponobj )
{
    foreach ( attachment in level.var_e0dc368290d94a40 )
    {
        if ( weaponobj canuseattachment( attachment ) )
        {
            return attachment;
        }
    }
    
    return "invalid";
}

/#

    // Namespace weapon
    // Params 10
    // Checksum 0xf8d1b04a, Offset: 0x4c23
    // Size: 0x136, Type: dev
    function function_12fc9c4fd8c1475( itemname, rarity, lootid, baseweapon, attachments, fullweaponname, titlestring, descstring, icon, pickupsound )
    {
        str = "<dev string:x7e5>";
        str += "<dev string:x5a3>" + itemname;
        str += "<dev string:x5a3>" + "<dev string:x7ea>";
        str += "<dev string:x5a3>" + rarity;
        str += "<dev string:x5a3>";
        str += "<dev string:x5a3>" + lootid;
        str += "<dev string:x5a3>";
        str += "<dev string:x5a3>";
        str += "<dev string:x5a3>" + baseweapon;
        str += "<dev string:x5a3>";
        str += "<dev string:x5a3>" + attachments;
        str += "<dev string:x5a3>" + fullweaponname;
        str += "<dev string:x5a3>" + function_a31c333e503a3fb0( titlestring );
        str += "<dev string:x5a3>" + function_a31c333e503a3fb0( descstring );
        str += "<dev string:x5a3>" + icon;
        str += "<dev string:x5a3>" + pickupsound;
        return str;
    }

#/

// Namespace weapon
// Params 0
// Checksum 0xa811aee6, Offset: 0x4d61
// Size: 0x7d
function function_f763315b54ffbd()
{
    attachmentlist = [];
    numrows = tablelookupgetnumrows( "mp/attachmenttable.csv" );
    
    for ( index = 0; index < numrows ; index++ )
    {
        attachmentname = tablelookupbyrow( "mp/attachmenttable.csv", index, 4 );
        
        if ( attachmentname == "" )
        {
            continue;
        }
        
        assert( !isdefined( attachmentlist[ attachmentname ] ), "<dev string:x7f1>" + attachmentname );
        attachmentlist[ attachmentname ] = attachmentname;
    }
    
    return attachmentlist;
}

// Namespace weapon
// Params 0
// Checksum 0xd8856aa, Offset: 0x4de7
// Size: 0x122
function function_16ff7d597f441100()
{
    var_7237854e3be197ca = level.weaponlistbundle;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    weaponslist = level.gametypebundle.weaponlist ?? level.gamemodebundle.weaponlist;
    
    if ( weaponslist )
    {
        weaponlistbundle = getscriptbundle( weaponslist );
        
        if ( isdefined( weaponlistbundle.weapons ) )
        {
            level.weaponlistbundle = [];
            
            foreach ( index, struct in weaponlistbundle.weapons )
            {
                if ( isdefined( struct.weapondata ) )
                {
                    level.weaponlistbundle[ index ] = struct.weapondata;
                }
            }
            
            return level.weaponlistbundle;
        }
    }
}

// Namespace weapon
// Params 2
// Checksum 0xc340a05d, Offset: 0x4f11
// Size: 0x2a
function function_659a3e10e8d1c91c( weapon, keys )
{
    return getscriptbundlefieldvalues( hashcat( %"weapondata:", weapon ), keys );
}

// Namespace weapon
// Params 2
// Checksum 0x96bf15ea, Offset: 0x4f44
// Size: 0x2a
function function_e0801e95ac4c4925( attachment, keys )
{
    return getscriptbundlefieldvalues( hashcat( %"hash_3c2c9813bb16552f", attachment ), keys );
}

// Namespace weapon
// Params 3
// Checksum 0xb6ed4be7, Offset: 0x4f77
// Size: 0x53
function function_c37ac3c4f987e506( weapon, key, def )
{
    if ( !isdefined( weapon ) )
    {
        return;
    }
    
    value = getscriptbundlefieldvalue( hashcat( %"weapondata:", weapon ), key );
    
    if ( !isdefined( value ) )
    {
        return def;
    }
    
    return value;
}

// Namespace weapon
// Params 1
// Checksum 0xcb9d91bd, Offset: 0x4fd3
// Size: 0xa9
function function_94e534c2a4d98789( weapon )
{
    slotarray = function_ea865062f19beca0();
    allattachments = [];
    
    foreach ( slot in slotarray )
    {
        var_bba76b2d884ae9dc = function_2e5ecdd8ac47f308( weapon, slot );
        allattachments[ slot ] = var_bba76b2d884ae9dc;
    }
    
    return allattachments;
}

// Namespace weapon
// Params 0
// Checksum 0xb45d068f, Offset: 0x5085
// Size: 0x1a9
function function_ea865062f19beca0()
{
    if ( !isdefined( level.attachmentslotarray ) )
    {
        level.attachmentslotarray = [];
        level.attachmentslotarray[ level.attachmentslotarray.size ] = "receiver";
        level.attachmentslotarray[ level.attachmentslotarray.size ] = "frontpiece";
        level.attachmentslotarray[ level.attachmentslotarray.size ] = "backpiece";
        level.attachmentslotarray[ level.attachmentslotarray.size ] = "magazine";
        level.attachmentslotarray[ level.attachmentslotarray.size ] = "override";
        level.attachmentslotarray[ level.attachmentslotarray.size ] = "muzzle";
        level.attachmentslotarray[ level.attachmentslotarray.size ] = "reargrip";
        level.attachmentslotarray[ level.attachmentslotarray.size ] = "trigger";
        level.attachmentslotarray[ level.attachmentslotarray.size ] = "extra";
        level.attachmentslotarray[ level.attachmentslotarray.size ] = "scope";
        level.attachmentslotarray[ level.attachmentslotarray.size ] = "scopealt";
        level.attachmentslotarray[ level.attachmentslotarray.size ] = "underbarrel";
        level.attachmentslotarray[ level.attachmentslotarray.size ] = "modifier";
        level.attachmentslotarray[ level.attachmentslotarray.size ] = "conversionkit";
        level.attachmentslotarray[ level.attachmentslotarray.size ] = "other";
    }
    
    return level.attachmentslotarray;
}

// Namespace weapon
// Params 1
// Checksum 0xc57d0f49, Offset: 0x5237
// Size: 0x68
function function_42e884104fc16220( weapon )
{
    weaponobj = utility::function_64003742d8f5c781( weapon );
    
    if ( !isdefined( weaponobj ) )
    {
        return 0;
    }
    
    currentweapon = 0;
    
    switch ( weaponobj.basenamehash )
    {
        case %"super_remote_map_mp":
        case %"ks_remote_map_mp":
            currentweapon = 1;
            break;
    }
    
    return currentweapon;
}

// Namespace weapon
// Params 1
// Checksum 0xd261d9de, Offset: 0x52a8
// Size: 0x74
function isdeploytablet( weapon )
{
    weaponobj = utility::function_64003742d8f5c781( weapon );
    
    if ( !isdefined( weaponobj ) )
    {
        return 0;
    }
    
    currentweapon = 0;
    
    switch ( weaponobj.basenamehash )
    {
        case %"ks_remote_device_mp":
        case %"super_remote_device_mp":
        case %"hash_6faa69ebfba55c59":
            currentweapon = 1;
            break;
    }
    
    return currentweapon;
}

// Namespace weapon
// Params 1
// Checksum 0x75cf1c9c, Offset: 0x5325
// Size: 0x34, Type: bool
function function_2c9350ef77bdf665( weapon )
{
    weaponname = weapon.basename;
    
    if ( !isdefined( weaponname ) )
    {
        return false;
    }
    
    return weaponname == "super_remote_map_mp";
}

// Namespace weapon
// Params 1
// Checksum 0x4ff9f6c4, Offset: 0x5362
// Size: 0x4b, Type: bool
function getweaponlootid( weaponobj )
{
    if ( !isweapon( weaponobj ) )
    {
        assertmsg( "<dev string:x834>" );
        return false;
    }
    
    return weaponobj.weaponblueprint.lootid ?? weaponobj.baseweaponlootid;
}

// Namespace weapon
// Params 1
// Checksum 0x8840824e, Offset: 0x53b6
// Size: 0x9b
function function_d54329f1701d6349( weapon )
{
    weaponlootid = 0;
    weaponname = undefined;
    
    if ( isweapon( weapon ) )
    {
        weaponname = weapon.basename;
    }
    else
    {
        assert( isstring( weapon ) );
        weaponname = weapon;
    }
    
    if ( isdefined( weaponname ) )
    {
        weaponrootname = getweaponrootname( weaponname );
        
        if ( isdefined( level.weaponmapdata[ weaponrootname ].weaponlootid ) )
        {
            weaponlootid = level.weaponmapdata[ weaponrootname ].weaponlootid;
        }
    }
    
    return weaponlootid;
}

// Namespace weapon
// Params 1
// Checksum 0x2583a75a, Offset: 0x545a
// Size: 0xed
function function_57559cfce1d2812d( weapon )
{
    if ( getdvarint( @"hash_8f727124cb64ae24", 1 ) == 1 )
    {
        weaponlootid = function_d54329f1701d6349( weapon );
        
        if ( weaponlootid != 0 )
        {
            return weaponlootid;
        }
    }
    
    if ( !isdefined( level.specialweaponlist ) )
    {
        level.specialweaponlist = [];
    }
    
    weaponname = function_59714dddb66e6b88( weapon );
    
    if ( !isdefined( weaponname ) )
    {
        return 0;
    }
    
    if ( isdefined( level.specialweaponlist[ weaponname ] ) )
    {
        return level.specialweaponlist[ weaponname ];
    }
    
    id = tablelookup( "loot/special_weapon_ids.csv", 1, weaponname, 0 );
    
    if ( !isdefined( id ) || id == "0" || id == "" )
    {
        return 0;
    }
    
    id = int( id );
    
    if ( isdefined( id ) )
    {
        level.specialweaponlist[ weaponname ] = id;
        return id;
    }
    
    return getweaponlootid( weapon );
}

// Namespace weapon
// Params 1
// Checksum 0xf1aeede3, Offset: 0x5550
// Size: 0xb4
function function_59714dddb66e6b88( weapon )
{
    weaponname = "";
    weaponobj = utility::function_64003742d8f5c781( weapon );
    
    if ( !isdefined( weaponobj ) )
    {
        return weaponname;
    }
    
    switch ( weaponobj.basenamehash )
    {
        case %"iw9_mg_mrap_mp":
        case %"iw9_tur_mrap_mp":
            weaponname = "iw9_tur_mrap_mp";
            break;
        case %"iw9_mg_patrol_boat_back_mp":
        case %"iw9_mg_patrol_boat_front_mp":
            weaponname = "iw9_mg_patrol_boat_front_mp";
            break;
        case %"iw9_mg_cougar_mp":
        case %"iw9_tur_cougar_mp":
            weaponname = "iw9_tur_cougar_mp";
            break;
    }
    
    return weaponname;
}

// Namespace weapon
// Params 0
// Checksum 0x9ec84b2e, Offset: 0x560d
// Size: 0x41
function getgrenadeinpullback()
{
    if ( !isdefined( self.gestureweapon ) )
    {
        return self getheldoffhand();
    }
    
    offhandweapon = self getheldoffhand();
    
    if ( offhandweapon == makeweaponfromstring( self.gestureweapon ) )
    {
        return nullweapon();
    }
    
    return offhandweapon;
}

// Namespace weapon
// Params 1
// Checksum 0x5d4c8b6a, Offset: 0x5657
// Size: 0x1d, Type: bool
function isweaponequipment( weapon )
{
    return weapon.inventorytype == "offhand";
}

// Namespace weapon
// Params 1
// Checksum 0x73814307, Offset: 0x567d
// Size: 0x1d, Type: bool
function isweaponitem( weapon )
{
    return weapon.inventorytype == "item";
}

// Namespace weapon
// Params 1
// Checksum 0x73396185, Offset: 0x56a3
// Size: 0x58
function isequipmentprimary( ref )
{
    if ( isdefined( ref ) && isdefined( level.equipment.table[ ref ] ) )
    {
        return ( level.equipment.table[ ref ].defaultslot == "primary" );
    }
    
    return 0;
}

// Namespace weapon
// Params 1
// Checksum 0x54e22509, Offset: 0x5703
// Size: 0x62, Type: bool
function isequipmentsecondary( ref )
{
    if ( isdefined( level.equipment.table[ ref ] ) )
    {
        if ( level.equipment.table[ ref ].defaultslot == "secondary" )
        {
            return true;
        }
    }
    
    if ( level.var_b8686b90947d6097 )
    {
        return true;
    }
    
    return false;
}

// Namespace weapon
// Params 1
// Checksum 0x83f3c190, Offset: 0x576e
// Size: 0xc4
function getequipmenttableinfo( ref )
{
    if ( isdefined( ref ) && !isdefined( level.equipment.table[ ref ] ) && !isdefined( level.equipment.protable[ ref ] ) )
    {
        assertmsg( "<dev string:x86d>" + ref + "<dev string:x8c1>" );
    }
    
    var_7237854e3be197ca = level.equipment.table[ ref ];
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    if ( level.var_ac98e7cc4b10cb11 )
    {
        var_7781459233518d3c = getxhashasset( ref );
        
        if ( isdefined( var_7781459233518d3c ) )
        {
            return level.equipment.protable[ var_7781459233518d3c ];
        }
    }
}

// Namespace weapon
// Params 3
// Checksum 0xa30a9ecb, Offset: 0x583a
// Size: 0x109
function buildequipment( weaponname, variantid, attachments )
{
    if ( !isdefined( weaponname ) )
    {
        return;
    }
    
    if ( !isdefined( attachments ) )
    {
        attachments = [];
    }
    
    if ( variantid > 0 )
    {
        weapon = makeweapon( weaponname, attachments, undefined, undefined, variantid );
        svariantid = weaponname + "|" + string( variantid );
        variantattachments = level.equipmentblueprints[ svariantid ];
        
        if ( variantattachments )
        {
            foreach ( attachment, variant in variantattachments )
            {
                weapon = weapon withattachment( attachment, variant );
            }
        }
    }
    else
    {
        weapon = function_d2c8356dc369d9ce( weaponname );
        weapon = weapon withattachments( attachments );
    }
    
    return weapon;
}

// Namespace weapon
// Params 1
// Checksum 0xca7f8662, Offset: 0x594c
// Size: 0x32
function function_fdc4a655fbde0dec( weaponname )
{
    if ( !isxhashasset( weaponname ) )
    {
        if ( !isdefined( weaponname ) )
        {
            return;
        }
        
        weaponname = getxhashasset( weaponname );
    }
    
    return level.var_1de668bdb367b433[ weaponname ];
}

// Namespace weapon
// Params 1
// Checksum 0x701cd376, Offset: 0x5987
// Size: 0x126
function function_5c326751c7802342( tableinfo )
{
    weapon = undefined;
    variantid = undefined;
    attachments = undefined;
    equipmentlist = self getweaponslistoffhands();
    
    foreach ( equip in equipmentlist )
    {
        equipref = function_fdc4a655fbde0dec( equip.basenamehash );
        
        if ( equipref == tableinfo.ref )
        {
            variantid = equip.variantid;
            attachments = equip.attachments;
            break;
        }
    }
    
    if ( variantid > 0 || attachments.size > 0 )
    {
        weapon = buildequipment( tableinfo.weaponname, variantid, attachments );
    }
    else
    {
        weapon = tableinfo.objweapon;
    }
    
    return weapon;
}

// Namespace weapon
// Params 1
// Checksum 0x6026f6e3, Offset: 0x5ab6
// Size: 0x4a
function getequipmentammo( ref )
{
    tableinfo = getequipmenttableinfo( ref );
    
    if ( !isdefined( tableinfo ) )
    {
        return;
    }
    
    weapon = function_5c326751c7802342( tableinfo );
    
    if ( !isdefined( weapon ) )
    {
        return 0;
    }
    
    return self getammocount( weapon );
}

// Namespace weapon
// Params 1
// Checksum 0x48315e38, Offset: 0x5b09
// Size: 0x1b, Type: bool
function isequipmentaddon( weapon )
{
    if ( weapon == "iw9_knifestab" )
    {
        return true;
    }
    
    return false;
}

// Namespace weapon
// Params 1
// Checksum 0x739c0445, Offset: 0x5b2d
// Size: 0x24, Type: bool
function function_ad2262e5ff0331a3( weapon )
{
    if ( function_180f246714b6c204( weapon ) )
    {
        return false;
    }
    
    if ( function_7974b348bf7596e9( weapon ) )
    {
        return false;
    }
    
    return true;
}

// Namespace weapon
// Params 1
// Checksum 0x9a57c231, Offset: 0x5b5a
// Size: 0x1f, Type: bool
function isspreadweapon( objweapon )
{
    return isdefined( objweapon ) && weaponclass( objweapon ) == "spread";
}

// Namespace weapon
// Params 1
// Checksum 0xc49d076f, Offset: 0x5b82
// Size: 0x98
function iswonderweapon( weapon )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "<dev string:x8c3>" );
        return 0;
    }
    
    if ( !isdefined( level.weaponmetadata ) )
    {
        return 0;
    }
    
    if ( isstring( weapon ) )
    {
        weapon = makeweapon( weapon );
    }
    
    hash_weapon_name = weapon.var_1616e6fbba9a722d;
    
    if ( !isdefined( hash_weapon_name ) )
    {
        return 0;
    }
    
    metadata = level.weaponmetadata[ hash_weapon_name ];
    
    if ( isdefined( metadata.iswonderweapon ) )
    {
        return metadata.iswonderweapon;
    }
    
    return 0;
}

// Namespace weapon
// Params 1
// Checksum 0x805220a4, Offset: 0x5c23
// Size: 0x98
function function_3e8739d232e1b023( weapon )
{
    if ( !isdefined( weapon ) )
    {
        assertmsg( "<dev string:x902>" );
        return 0;
    }
    
    if ( !isdefined( level.weaponmetadata ) )
    {
        return 0;
    }
    
    if ( isstring( weapon ) )
    {
        weapon = makeweapon( weapon );
    }
    
    hash_weapon_name = weapon.var_1616e6fbba9a722d;
    
    if ( !isdefined( hash_weapon_name ) )
    {
        return 0;
    }
    
    metadata = level.weaponmetadata[ hash_weapon_name ];
    
    if ( isdefined( metadata.var_3e8739d232e1b023 ) )
    {
        return metadata.var_3e8739d232e1b023;
    }
    
    return 0;
}

// Namespace weapon
// Params 0
// Checksum 0x5f535a4b, Offset: 0x5cc4
// Size: 0x74
function function_ebf195b764552e41()
{
    if ( !self )
    {
        return 0;
    }
    
    if ( self == level.weaponnone )
    {
        return 1;
    }
    
    hash_weapon_name = self.var_1616e6fbba9a722d;
    
    if ( !hash_weapon_name )
    {
        return 0;
    }
    
    if ( level.weaponmetadata )
    {
        metadata = level.weaponmetadata[ hash_weapon_name ];
        
        if ( metadata.var_ebf195b764552e41 )
        {
            return metadata.var_ebf195b764552e41;
        }
    }
    
    return 0;
}

// Namespace weapon
// Params 1
// Checksum 0xc22f6015, Offset: 0x5d41
// Size: 0x1b
function isbackuppistol( weapon )
{
    return weapon hasattachmenthash( %"backup_pistol" );
}

// Namespace weapon
// Params 0, eflags: 0x5
// Checksum 0x799cecf, Offset: 0x5d65
// Size: 0x51
function private autoexec function_99b866e5ee9fe6d3()
{
    /#
        setdevdvar( @"hash_c30411f274497e85", "<dev string:x944>" );
    #/
    
    if ( !isdefined( level.var_431d3dd6b0605770 ) )
    {
        level.var_431d3dd6b0605770 = getdvarint( @"hash_bd2bb9f10c3af5e8", 1 );
    }
    
    buildweaponmap();
    buildattachmentmaps();
    function_47c21f91a5f180b8();
}

// Namespace weapon
// Params 2
// Checksum 0xb90282a, Offset: 0x5dbe
// Size: 0x15c, Type: bool
function fixupplayerweapons( player, weapon )
{
    currentplayerweapons = player getweaponslistprimaries();
    dirtyprimary = 1;
    dirtysecondary = 1;
    weaponname = undefined;
    weaponobj = utility::function_64003742d8f5c781( weapon );
    
    if ( isweapon( weapon ) )
    {
        weaponname = getcompleteweaponname( weapon );
    }
    
    foreach ( currentweapon in currentplayerweapons )
    {
        if ( player.primaryweaponobj == currentweapon )
        {
            dirtyprimary = 0;
        }
        else if ( player.secondaryweaponobj == currentweapon )
        {
            dirtysecondary = 0;
        }
        
        if ( !dirtyprimary && !dirtysecondary )
        {
            break;
        }
    }
    
    if ( dirtyprimary )
    {
        player.primaryweapon = weaponname;
        player.primaryweaponobj = weaponobj;
    }
    else if ( dirtysecondary )
    {
        player.secondaryweapon = weaponname;
        player.secondaryweaponobj = weaponobj;
    }
    
    return dirtyprimary || dirtysecondary;
}

// Namespace weapon
// Params 2
// Checksum 0x13156b2a, Offset: 0x5f23
// Size: 0x72
function getmaxattachments( slot, wildcard )
{
    maxattachments = level.maxattachments[ slot ];
    
    if ( wildcard == "wildcard_gunfighter" )
    {
        return maxattachments.gunfighter;
    }
    else if ( wildcard == "wildcard_flyswatter" && slot == 2 )
    {
        return maxattachments.flyswatter;
    }
    
    return maxattachments.standard;
}

// Namespace weapon
// Params 1
// Checksum 0xe3148791, Offset: 0x5f9e
// Size: 0x15
function getmaxprimaryattachments( wildcard )
{
    return getmaxattachments( 0, wildcard );
}

// Namespace weapon
// Params 1
// Checksum 0xbc020e75, Offset: 0x5fbc
// Size: 0x16
function getmaxsecondaryattachments( wildcard )
{
    return getmaxattachments( 1, wildcard );
}

// Namespace weapon
// Params 1
// Checksum 0x2c8ac4b8, Offset: 0x5fdb
// Size: 0x16
function function_222f1c49e082a080( wildcard )
{
    return getmaxattachments( 2, wildcard );
}

// Namespace weapon
// Params 0
// Checksum 0x9d85cd7c, Offset: 0x5ffa
// Size: 0xd
function function_45ab75ece154ca8f()
{
    return getmaxprimaryattachments( "wildcard_gunfighter" );
}

// Namespace weapon
// Params 0
// Checksum 0x8a48e432, Offset: 0x6010
// Size: 0xd
function function_a7a39da0cf2d5b5b()
{
    return getmaxsecondaryattachments( "wildcard_gunfighter" );
}

// Namespace weapon
// Params 0
// Checksum 0xf9f087fb, Offset: 0x6026
// Size: 0xd
function function_bedf9f9cfa13920d()
{
    return function_222f1c49e082a080( "wildcard_gunfighter" );
}

// Namespace weapon
// Params 0
// Checksum 0xf46c72d6, Offset: 0x603c
// Size: 0xc
function getslotcount()
{
    return level.maxattachments.size;
}

// Namespace weapon
// Params 0
// Checksum 0xda06c322, Offset: 0x6051
// Size: 0x22, Type: bool
function function_89d2d0588f2def25()
{
    return self.mineid && level.var_4aa2b67bae0df4a0[ self.mineid ];
}

// Namespace weapon
// Params 0
// Checksum 0x56918527, Offset: 0x607c
// Size: 0x39, Type: bool
function function_7e51eda73b48a495()
{
    return self.mineid && self.team && level.var_ab949d4d01af0a68[ self.team ][ self.mineid ];
}

// Namespace weapon
// Params 0
// Checksum 0x53eadbc9, Offset: 0x60be
// Size: 0x9
function registermine()
{
    function_684646ff6cec7318();
}

// Namespace weapon
// Params 0
// Checksum 0x42a61e2e, Offset: 0x60cf
// Size: 0x9
function deregistermine()
{
    function_dbdd90c189df6c61();
}

// Namespace weapon
// Params 2
// Checksum 0x8ae5df30, Offset: 0x60e0
// Size: 0x49, Type: bool
function minechangeteam( oldteam, newteam )
{
    if ( !level.var_4aa2b67bae0df4a0[ self.mineid ] )
    {
        return false;
    }
    
    function_dbdd90c189df6c61();
    self.team = newteam;
    function_684646ff6cec7318();
    return true;
}

// Namespace weapon
// Params 0
// Checksum 0x4bd1e636, Offset: 0x6132
// Size: 0xf
function function_438072bd0efdcff3()
{
    return arraycopy( level.var_4aa2b67bae0df4a0 );
}

// Namespace weapon
// Params 1
// Checksum 0xf44cda8f, Offset: 0x614a
// Size: 0x1c
function function_556df87f7e3366bb( team )
{
    return arraycopy( level.var_ab949d4d01af0a68[ team ] );
}

// Namespace weapon
// Params 0
// Checksum 0xb2a6b8e6, Offset: 0x616f
// Size: 0xb
function function_3aafcaf7ff6dea9e()
{
    return level.var_4aa2b67bae0df4a0;
}

// Namespace weapon
// Params 1
// Checksum 0x1fd1ccc5, Offset: 0x6183
// Size: 0xf7
function function_84ab82bdba5dfb9d( team )
{
    result = [];
    
    foreach ( mines in level.var_ab949d4d01af0a68 )
    {
        foreach ( m in mines )
        {
            result[ result.size ] = m;
        }
    }
    
    return result;
}

// Namespace weapon
// Params 0, eflags: 0x4
// Checksum 0xaad8ac20, Offset: 0x6283
// Size: 0x22
function private initializemines()
{
    level.var_4aa2b67bae0df4a0 = [];
    level.var_ab949d4d01af0a68 = [];
    level.var_f7303e01ed5fe77f = 9999;
}

// Namespace weapon
// Params 0, eflags: 0x4
// Checksum 0xaa387017, Offset: 0x62ad
// Size: 0x94
function private function_684646ff6cec7318()
{
    self.mineid = level.var_f7303e01ed5fe77f;
    level.var_f7303e01ed5fe77f++;
    level.var_4aa2b67bae0df4a0[ self.mineid ] = self;
    
    if ( self.team )
    {
        if ( !isdefined( level.var_ab949d4d01af0a68[ self.team ] ) )
        {
            level.var_ab949d4d01af0a68[ self.team ] = [];
        }
        
        level.var_ab949d4d01af0a68[ self.team ][ level.var_ab949d4d01af0a68[ self.team ].size ] = self;
    }
}

// Namespace weapon
// Params 0, eflags: 0x4
// Checksum 0x5a7b220b, Offset: 0x6349
// Size: 0x59
function private function_dbdd90c189df6c61()
{
    if ( self.mineid )
    {
        level.var_4aa2b67bae0df4a0[ self.mineid ] = undefined;
        
        if ( self.team )
        {
            level.var_ab949d4d01af0a68[ self.team ] = arrayremove( level.var_ab949d4d01af0a68[ self.team ], self );
        }
    }
}

// Namespace weapon
// Params 1, eflags: 0x4
// Checksum 0x11969718, Offset: 0x63aa
// Size: 0xa1
function private function_3c1487d3e0c3cf41( params )
{
    foreach ( trigger in params.var_619d6a48f5a56867 )
    {
        level.var_619d6a48f5a56867[ trigger.entnum ?? utility::get_entity_number( trigger ) ] = trigger;
    }
}

// Namespace weapon
// Params 1
// Checksum 0xfa98eae1, Offset: 0x6453
// Size: 0x9c, Type: bool
function function_ecbdce6df0e16a2a( var_7a7a769159687e6d )
{
    foreach ( var_4f16c60769e4f39a in level.var_619d6a48f5a56867 )
    {
        if ( var_4f16c60769e4f39a.weaponfilter[ var_7a7a769159687e6d ] && self istouching( var_4f16c60769e4f39a ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace weapon
// Params 2
// Checksum 0xc836c471, Offset: 0x64f8
// Size: 0x131
function giveandfireoffhandreliable( objweapon, var_48e9b160167e8daf )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    heldoffhand = getgrenadeinpullback();
    
    if ( isdefined( heldoffhand ) && !isnullweapon( heldoffhand ) )
    {
        self notify( #"hash_3ab39a4e976b0270", objweapon );
        return 0;
    }
    
    objweapon = utility::function_64003742d8f5c781( objweapon );
    
    if ( !isdefined( objweapon ) )
    {
        self notify( #"hash_3ab39a4e976b0270", objweapon );
        return 0;
    }
    
    self giveandfireoffhand( objweapon );
    
    if ( !self hasweapon( objweapon ) )
    {
        self notify( #"hash_3ab39a4e976b0270", objweapon );
        return 0;
    }
    
    if ( isdefined( var_48e9b160167e8daf ) )
    {
        self notify( var_48e9b160167e8daf );
    }
    
    result = spawnstruct();
    result childthread function_34d323a1366782ec( self, objweapon );
    result childthread function_5fe9c9d0b33ce41d( self, objweapon );
    result waittill( #"race_start" );
    waittillframeend();
    result notify( #"race_end" );
    
    if ( result.success )
    {
        self notify( #"hash_81f31920b90c5146", objweapon );
        return 1;
    }
    
    if ( result.failure )
    {
        self notify( #"hash_3ab39a4e976b0270", objweapon );
        return 0;
    }
}

// Namespace weapon
// Params 2
// Checksum 0xafbe55a, Offset: 0x6631
// Size: 0x4a
function function_34d323a1366782ec( player, objweapon )
{
    self endon( #"race_end" );
    player waittillmatch( #"offhand_fired", objweapon );
    self.success = 1;
    self notify( #"race_start" );
}

// Namespace weapon
// Params 2
// Checksum 0xb92e8264, Offset: 0x6683
// Size: 0xd8
function function_5fe9c9d0b33ce41d( player, objweapon )
{
    self endon( #"race_end" );
    timeouttime = gettime() + 5000;
    
    if ( level.gamemodebundle.var_236bc7922709ea15 )
    {
        timeouttime = gettime() + function_8cef655bb1c925da( objweapon ) + weaponfiretime( objweapon ) * 1000 + 1000;
    }
    
    waitframe();
    
    for ( hasweapon = player hasweapon( objweapon ); hasweapon && gettime() < timeouttime ; hasweapon = player hasweapon( objweapon ) )
    {
        player utility::waittill_notify_or_timeout( "weapon_taken", ( timeouttime - gettime() ) * 0.001 );
    }
    
    if ( hasweapon )
    {
        player takeweapon( objweapon );
    }
    
    self.failure = 1;
    self notify( #"race_start" );
}

// Namespace weapon
// Params 4
// Checksum 0x12ac12c5, Offset: 0x6763
// Size: 0x18e
function function_e418c15787e60727( player, isinvehicle, var_1d1dfe33560343fd, var_8184f8af249bea93 )
{
    usereloadconfig = player getcurrentusereloadconfig();
    
    if ( var_1d1dfe33560343fd )
    {
        clipfull = var_8184f8af249bea93;
    }
    else
    {
        weapon = player getcurrentweapon();
        clipfull = player getweaponammoclip( weapon ) >= weapon.clipsize;
    }
    
    entity = player getplayeruseentity( 1 );
    caninteract = isdefined( entity ) || isinvehicle;
    hasconflict = caninteract && !clipfull;
    
    if ( usereloadconfig == 0 )
    {
        return { #var_54453e630bc1ba7d:1, #var_d9982fb23eaa73df:!hasconflict, #var_17a7b9ae2a4d76d5:0, #tapToReload:1 };
    }
    
    if ( usereloadconfig == 1 )
    {
        return { #var_54453e630bc1ba7d:!hasconflict, #var_d9982fb23eaa73df:1, #var_17a7b9ae2a4d76d5:1, #tapToReload:0 };
    }
    
    if ( usereloadconfig == 2 )
    {
        return { #var_54453e630bc1ba7d:!hasconflict, #var_d9982fb23eaa73df:1, #var_17a7b9ae2a4d76d5:1, #tapToReload:!hasconflict };
    }
    
    if ( usereloadconfig == 3 )
    {
        return { #var_54453e630bc1ba7d:1, #var_d9982fb23eaa73df:!hasconflict, #var_17a7b9ae2a4d76d5:!hasconflict, #tapToReload:1 };
    }
}

