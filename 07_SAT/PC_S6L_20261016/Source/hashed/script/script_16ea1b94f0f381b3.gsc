// script_16ea1b94f0f381b3  (hash_16ea1b94f0f381b3.gscc) (size: 30938 Bytes / 0x78da / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4559306f (1163473007)
// size ...... 30938 (0x78da)
// includes .. 1   (offset: 0x78c6)
// strings ... 1   (offset: 0x78ce)
// dev strs .. 0   (offset: 0x78da)
// exports ... 252 (offset: 0x49b6)
// cseg ...... 0x5c + 0x495a (0x49b6)
// imports ... 18  (offset: 0x7116)
// animtree1 . 0   (offset: 0x78da)
// animtree2 . 0   (offset: 0x78da)
#using scripts\common\utility;

#namespace namespace_9d8e359c3b1041e5;

// Namespace namespace_9d8e359c3b1041e5
// Params 4
// Checksum 0x2ef07ba7, Offset: 0x7a
// Size: 0x45
function scriptmodelplayanimdeltamotionsharedfunc( animname, notifystring, animstarttimeseconds, blendtype )
{
    return utility::callsharedfunc( #"anim", #"scriptmodelplayanimdeltamotion", animname, notifystring, animstarttimeseconds, blendtype );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 2
// Checksum 0xbd314036, Offset: 0xc8
// Size: 0x57
function activateperksharedfunc( perkname, var_f79322810142292e = 0 )
{
    if ( utility::issharedfuncdefined( #"perk", #"activatePerk" ) )
    {
        self [[ utility::getsharedfunc( #"perk", #"activatePerk" ) ]]( perkname, var_f79322810142292e );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 2
// Checksum 0x39af496d, Offset: 0x127
// Size: 0x4f
function perkpackage_giveoverridefieldupgradessharedfunc( fieldupgrade1, fieldupgrade2 )
{
    if ( utility::issharedfuncdefined( #"perk", #"perkpackage_giveoverridefieldupgrades" ) )
    {
        self [[ utility::getsharedfunc( #"perk", #"perkpackage_giveoverridefieldupgrades" ) ]]( fieldupgrade1, fieldupgrade2 );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 2
// Checksum 0xab6c3611, Offset: 0x17e
// Size: 0x4f
function giveperksharedfunc( perkname, parentperkname )
{
    if ( utility::issharedfuncdefined( #"perk", #"giveperk" ) )
    {
        self [[ utility::getsharedfunc( #"perk", #"giveperk" ) ]]( perkname, parentperkname );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x26192a39, Offset: 0x1d5
// Size: 0x45
function removeperksharedfunc( perkname )
{
    if ( utility::issharedfuncdefined( #"perk", #"removeperk" ) )
    {
        self [[ utility::getsharedfunc( #"perk", #"removeperk" ) ]]( perkname );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 5
// Checksum 0xd99e2eee, Offset: 0x222
// Size: 0x6e
function showsplashsharedfunc( ref, optionalnumber, playerforplayercard, altdisplayindex, var_4dd30bf63f0b5e8b )
{
    if ( utility::issharedfuncdefined( #"hud", #"showsplash" ) )
    {
        self [[ utility::getsharedfunc( #"hud", #"showsplash" ) ]]( ref, optionalnumber, playerforplayercard, altdisplayindex, var_4dd30bf63f0b5e8b );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 2
// Checksum 0xf547853f, Offset: 0x298
// Size: 0x4f
function showerrormessagesharedfunc( funcname, param )
{
    if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
    {
        self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( funcname, param );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x281305f8, Offset: 0x2ef
// Size: 0x49
function isfeaturedisabledsharedfunc( featurename )
{
    if ( utility::issharedfuncdefined( #"game", #"isfeaturedisabled" ) )
    {
        return [[ utility::getsharedfunc( #"game", #"isfeaturedisabled" ) ]]( featurename );
    }
    
    return 0;
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0x1d1ad97e, Offset: 0x340
// Size: 0x39
function checkforactiveobjicon()
{
    if ( utility::issharedfuncdefined( #"game", #"checkforactiveobjicon" ) )
    {
        self [[ utility::getsharedfunc( #"game", #"checkforactiveobjicon" ) ]]();
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0xb241cf14, Offset: 0x381
// Size: 0x39
function deletequestobjicon()
{
    if ( utility::issharedfuncdefined( #"game", #"deletequestobjicon" ) )
    {
        self [[ utility::getsharedfunc( #"game", #"deletequestobjicon" ) ]]();
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 2
// Checksum 0xa43e7bff, Offset: 0x3c2
// Size: 0x4e
function function_39104c6ed6c82786( fromorigin, fromangles )
{
    if ( utility::issharedfuncdefined( #"game", #"hash_da85e1cf6234f5f2" ) )
    {
        return [[ utility::getsharedfunc( #"game", #"hash_da85e1cf6234f5f2" ) ]]( fromorigin, fromangles );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 2
// Checksum 0x780de94d, Offset: 0x418
// Size: 0x4e
function initspawnoptions_spawnfrompositionsharedfunc( fromorigin, fromangles )
{
    if ( utility::issharedfuncdefined( #"game", #"initSpawnOptions_SpawnFromPosition" ) )
    {
        return [[ utility::getsharedfunc( #"game", #"initSpawnOptions_SpawnFromPosition" ) ]]( fromorigin, fromangles );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x4acfbd02, Offset: 0x46e
// Size: 0x44
function initspawnoptions_spawnfromentitysharedfunc( spawningentity )
{
    if ( utility::issharedfuncdefined( #"game", #"initSpawnOptions_SpawnFromEntity" ) )
    {
        return [[ utility::getsharedfunc( #"game", #"initSpawnOptions_SpawnFromEntity" ) ]]( spawningentity );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 3
// Checksum 0x8a520d1a, Offset: 0x4ba
// Size: 0x58
function spawnpickupfromlistsharedfunc( var_f1bc45484a606cd5, count, spawnoptions )
{
    if ( utility::issharedfuncdefined( #"game", #"spawnPickupFromList" ) )
    {
        [[ utility::getsharedfunc( #"game", #"spawnPickupFromList" ) ]]( var_f1bc45484a606cd5, count, spawnoptions );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0xa963971f, Offset: 0x51a
// Size: 0x44
function getscriptablefromlootidsharedfunc( lootid )
{
    if ( utility::issharedfuncdefined( #"game", #"getScriptableFromLootID" ) )
    {
        return [[ utility::getsharedfunc( #"game", #"getScriptableFromLootID" ) ]]( lootid );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 5
// Checksum 0xbf4d4931, Offset: 0x567
// Size: 0x64
function spawnnewitemfromscriptablesharedfunc( scriptablename, itemorigin, itemangles, overridecount, critical )
{
    spawnoptions = function_39104c6ed6c82786( itemorigin, itemangles );
    
    if ( isdefined( spawnoptions ) )
    {
        spawnoptions.critical = critical;
        return spawnitemfromscriptablesharedfunc( scriptablename, overridecount, spawnoptions );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 3
// Checksum 0xc7ead5f0, Offset: 0x5d4
// Size: 0x58
function spawnitemfromscriptablesharedfunc( scriptablename, count, spawnoptions )
{
    if ( utility::issharedfuncdefined( #"game", #"spawnItemFromScriptable" ) )
    {
        return [[ utility::getsharedfunc( #"game", #"spawnItemFromScriptable" ) ]]( scriptablename, count, spawnoptions );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 2
// Checksum 0xbd3d7f4b, Offset: 0x634
// Size: 0x50
function function_a7918caa4f9819eb( scriptablename, iscustomweapon )
{
    if ( utility::issharedfuncdefined( #"game", #"hash_9a424766e665a6f7" ) )
    {
        return [[ utility::getsharedfunc( #"game", #"hash_9a424766e665a6f7" ) ]]( scriptablename, iscustomweapon );
    }
    
    return 1;
}

// Namespace namespace_9d8e359c3b1041e5
// Params 8
// Checksum 0x66953f4d, Offset: 0x68d
// Size: 0x8c
function getitemdroporiginandanglessharedfunc( index, baseorigin, baseangles, ignoreent, var_8e48a889d5a11dee, optionaloverridedist, var_18608bd8660b3a19, var_11f401c17a8141c5 )
{
    if ( utility::issharedfuncdefined( #"game", #"getitemdroporiginandangles" ) )
    {
        [[ utility::getsharedfunc( #"game", #"getitemdroporiginandangles" ) ]]( index, baseorigin, baseangles, ignoreent, var_8e48a889d5a11dee, optionaloverridedist, var_18608bd8660b3a19, var_11f401c17a8141c5 );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 6
// Checksum 0x4126aafe, Offset: 0x721
// Size: 0x77
function br_forcegivecustompickupitemsharedfunc( player, scriptablename, var_90916fc4b2724efd, countoverride, fromkiosk, droppurchased )
{
    if ( utility::issharedfuncdefined( #"game", #"br_forcegivecustompickupitem" ) )
    {
        return [[ utility::getsharedfunc( #"game", #"br_forcegivecustompickupitem" ) ]]( player, scriptablename, var_90916fc4b2724efd, countoverride, fromkiosk, droppurchased );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 4
// Checksum 0xbef34f18, Offset: 0x7a0
// Size: 0x63
function branalytics_kiosk_purchaseitemsharedfunc( player, plunderspent, purchasetype, itemname )
{
    if ( utility::issharedfuncdefined( #"game", #"branalytics_kiosk_purchaseitem" ) )
    {
        return [[ utility::getsharedfunc( #"game", #"branalytics_kiosk_purchaseitem" ) ]]( player, plunderspent, purchasetype, itemname );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0xb8e8a09f, Offset: 0x80b
// Size: 0x44
function iskiosksharedfunc( scriptablename )
{
    if ( utility::issharedfuncdefined( #"game", #"isKiosk" ) )
    {
        return [[ utility::getsharedfunc( #"game", #"isKiosk" ) ]]( scriptablename );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x511bd72d, Offset: 0x857
// Size: 0x44
function cantakepickupsharedfunc( pickupent )
{
    if ( utility::issharedfuncdefined( #"game", #"cantakepickup" ) )
    {
        return [[ utility::getsharedfunc( #"game", #"cantakepickup" ) ]]( pickupent );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 3
// Checksum 0x3e442a07, Offset: 0x8a3
// Size: 0x58
function branalytics_kiosk_menu_eventsharedfunc( player, menuevent, menueventparam )
{
    if ( utility::issharedfuncdefined( #"game", #"branalytics_kiosk_menu_event" ) )
    {
        [[ utility::getsharedfunc( #"game", #"branalytics_kiosk_menu_event" ) ]]( player, menuevent, menueventparam );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 3
// Checksum 0x5cf20a63, Offset: 0x903
// Size: 0x59
function createquestobjiconsharedfunc( iconref, state, initalorigin )
{
    if ( utility::issharedfuncdefined( #"game", #"createquestobjicon" ) )
    {
        self [[ utility::getsharedfunc( #"game", #"createquestobjicon" ) ]]( iconref, state, initalorigin );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0xeed29b56, Offset: 0x964
// Size: 0x45
function showquestobjicontoplayersharedfunc( player )
{
    if ( utility::issharedfuncdefined( #"game", #"showquestobjicontoplayer" ) )
    {
        self [[ utility::getsharedfunc( #"game", #"showquestobjicontoplayer" ) ]]( player );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0xaab54468, Offset: 0x9b1
// Size: 0x45
function ispubliceventoftypeactivesharedfunc( eventtype )
{
    if ( utility::issharedfuncdefined( #"game", #"ispubliceventoftypeactive" ) )
    {
        return [[ utility::getsharedfunc( #"game", #"ispubliceventoftypeactive" ) ]]( eventtype );
    }
    
    return 0;
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0xd0e5430, Offset: 0x9ff
// Size: 0x45
function hidequestobjiconfromplayersharedfunc( player )
{
    if ( utility::issharedfuncdefined( #"game", #"hidequestobjiconfromplayer" ) )
    {
        self [[ utility::getsharedfunc( #"game", #"hidequestobjiconfromplayer" ) ]]( player );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0xc763c76d, Offset: 0xa4c
// Size: 0x39
function isbrpracticemodesharedfunc()
{
    if ( utility::issharedfuncdefined( #"game", #"isBrPracticeMode" ) )
    {
        return [[ utility::getsharedfunc( #"game", #"isBrPracticeMode" ) ]]();
    }
    
    return 0;
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0xc76928c3, Offset: 0xa8e
// Size: 0x38
function function_cddfe06629132726()
{
    if ( utility::issharedfuncdefined( #"game", #"hash_b4cec77d706797e" ) )
    {
        return [[ utility::getsharedfunc( #"game", #"hash_b4cec77d706797e" ) ]]();
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0x1dc92425, Offset: 0xace
// Size: 0x39
function respawntokendisabledsharedfunc()
{
    if ( utility::issharedfuncdefined( #"game", #"respawntokendisabled" ) )
    {
        return [[ utility::getsharedfunc( #"game", #"respawntokendisabled" ) ]]();
    }
    
    return 0;
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0x6ed3243b, Offset: 0xb10
// Size: 0x3a
function hasselfrevivetokensharedfunc()
{
    if ( utility::issharedfuncdefined( #"game", #"hasselfrevivetoken" ) )
    {
        return self [[ utility::getsharedfunc( #"game", #"hasselfrevivetoken" ) ]]();
    }
    
    return 0;
}

// Namespace namespace_9d8e359c3b1041e5
// Params 5
// Checksum 0x42b2e207, Offset: 0xb53
// Size: 0x6e
function forcegivekillstreaksharedfunc( killstreakref, dropcurrent, fromkiosk, droppurchased, var_6432f32bb6fece8b )
{
    if ( utility::issharedfuncdefined( #"game", #"forcegivekillstreak" ) )
    {
        return self [[ utility::getsharedfunc( #"game", #"forcegivekillstreak" ) ]]( killstreakref, dropcurrent, fromkiosk, droppurchased, var_6432f32bb6fece8b );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0xe9cc1664, Offset: 0xbca
// Size: 0x44
function traceselectedmaplocationsharedfunc( location )
{
    if ( utility::issharedfuncdefined( #"game", #"traceselectedmaplocation" ) )
    {
        return [[ utility::getsharedfunc( #"game", #"traceselectedmaplocation" ) ]]( location );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 2
// Checksum 0xbd7a6779, Offset: 0xc17
// Size: 0x4e
function getdefaultweaponammosharedfunc( weapon, maxammo )
{
    if ( utility::issharedfuncdefined( #"game", #"getDefaultWeaponAmmo" ) )
    {
        return [[ utility::getsharedfunc( #"game", #"getDefaultWeaponAmmo" ) ]]( weapon, maxammo );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0xf812cd1b, Offset: 0xc6e
// Size: 0x39
function isbackpackinventoryenabledsharedfunc()
{
    if ( utility::issharedfuncdefined( #"inventory", #"isbackpackinventoryenabled" ) )
    {
        return [[ utility::getsharedfunc( #"inventory", #"isbackpackinventoryenabled" ) ]]();
    }
    
    return 0;
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0x3849ce66, Offset: 0xcb0
// Size: 0x39
function function_cfb5f8c2e930a89b()
{
    if ( utility::issharedfuncdefined( #"game", #"hash_e07c5122ec5d1791" ) )
    {
        return [[ utility::getsharedfunc( #"game", #"hash_e07c5122ec5d1791" ) ]]();
    }
    
    return 0;
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0x72d5f6aa, Offset: 0xcf2
// Size: 0x39
function function_f67fae8ef25c92b9()
{
    if ( utility::issharedfuncdefined( #"game", #"hash_78190f991670e49f" ) )
    {
        return [[ utility::getsharedfunc( #"game", #"hash_78190f991670e49f" ) ]]();
    }
    
    return 0;
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x5084253, Offset: 0xd34
// Size: 0x45
function function_c1109cf6be986e40( weaponobj )
{
    if ( utility::issharedfuncdefined( #"game", #"hash_cd267422df2cef24" ) )
    {
        return [[ utility::getsharedfunc( #"game", #"hash_cd267422df2cef24" ) ]]( weaponobj );
    }
    
    return 0;
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x74f96efa, Offset: 0xd82
// Size: 0x45
function function_5d1edee14e4e4443( weaponobj )
{
    if ( utility::issharedfuncdefined( #"game", #"hash_bd49cc45c9c2df13" ) )
    {
        return [[ utility::getsharedfunc( #"game", #"hash_bd49cc45c9c2df13" ) ]]( weaponobj );
    }
    
    return 0;
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x88b81362, Offset: 0xdd0
// Size: 0x45
function function_89f71b1578cb1c33( weaponname )
{
    if ( utility::issharedfuncdefined( #"game", #"hash_1d1ab4a66f2da81f" ) )
    {
        return [[ utility::getsharedfunc( #"game", #"hash_1d1ab4a66f2da81f" ) ]]( weaponname );
    }
    
    return 0;
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0xf326ed23, Offset: 0xe1e
// Size: 0x39
function function_506b3af42c9059a8()
{
    if ( utility::issharedfuncdefined( #"game", #"hash_86d132fdc6e2d4c4" ) )
    {
        return [[ utility::getsharedfunc( #"game", #"hash_86d132fdc6e2d4c4" ) ]]();
    }
    
    return 0;
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0x5fc8023a, Offset: 0xe60
// Size: 0x39
function function_f04bdccad87bc790()
{
    if ( utility::issharedfuncdefined( #"game", #"hash_2f55f5162fdd4cf2" ) )
    {
        self [[ utility::getsharedfunc( #"game", #"hash_2f55f5162fdd4cf2" ) ]]();
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0xde2ea5d5, Offset: 0xea1
// Size: 0x44
function calculatepurchasexpsharedfunc( plunderspent )
{
    if ( utility::issharedfuncdefined( #"game", #"calculatepurchasexp" ) )
    {
        return [[ utility::getsharedfunc( #"game", #"calculatepurchasexp" ) ]]( plunderspent );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0x15549cb9, Offset: 0xeee
// Size: 0x39
function isanytutorialorbotpracticematchsharedfunc()
{
    if ( utility::issharedfuncdefined( #"game", #"isanytutorialorbotpracticematch" ) )
    {
        return [[ utility::getsharedfunc( #"game", #"isanytutorialorbotpracticematch" ) ]]();
    }
    
    return 0;
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x4d086cf8, Offset: 0xf30
// Size: 0x45
function registeronluieventcallbacksharedfunc( callback )
{
    if ( utility::issharedfuncdefined( #"game", #"registeronluieventcallback" ) )
    {
        level [[ utility::getsharedfunc( #"game", #"registeronluieventcallback" ) ]]( callback );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0xf5c30c91, Offset: 0xf7d
// Size: 0x45
function isloadoutindexdefaultsharedfunc( index )
{
    if ( utility::issharedfuncdefined( #"game", #"isloadoutindexdefault" ) )
    {
        return [[ utility::getsharedfunc( #"game", #"isloadoutindexdefault" ) ]]( index );
    }
    
    return 0;
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0xb78aca46, Offset: 0xfcb
// Size: 0x44
function getclasschoicesharedfunc( menuindex )
{
    if ( utility::issharedfuncdefined( #"game", #"getclasschoice" ) )
    {
        return [[ utility::getsharedfunc( #"game", #"getclasschoice" ) ]]( menuindex );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 2
// Checksum 0xc30b0ab5, Offset: 0x1018
// Size: 0x4f
function utilflare_shootflaresharedfunc( spawn_origin, flaretype )
{
    if ( utility::issharedfuncdefined( #"game", #"utilflare_shootflare" ) )
    {
        level thread [[ utility::getsharedfunc( #"game", #"utilflare_shootflare" ) ]]( spawn_origin, flaretype );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 3
// Checksum 0x2de38bab, Offset: 0x106f
// Size: 0x59
function isvalidpointinboundssharedfunc( point, checkbadcircleareas, var_566819e204437d34 )
{
    if ( utility::issharedfuncdefined( #"game", #"isvalidpointinbounds" ) )
    {
        return [[ utility::getsharedfunc( #"game", #"isvalidpointinbounds" ) ]]( point, checkbadcircleareas, var_566819e204437d34 );
    }
    
    return 0;
}

// Namespace namespace_9d8e359c3b1041e5
// Params 4
// Checksum 0x83cae52e, Offset: 0x10d1
// Size: 0x63
function initcirclepoststarttocircleindexsharedfunc( origin, startcircledelay, startcircleindex, startcircleclosetime )
{
    if ( utility::issharedfuncdefined( #"game", #"initcirclepoststarttocircleindex" ) )
    {
        [[ utility::getsharedfunc( #"game", #"initcirclepoststarttocircleindex" ) ]]( origin, startcircledelay, startcircleindex, startcircleclosetime );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0xf635a13d, Offset: 0x113c
// Size: 0x45
function isfeatureenabledsharedfunc( featurename )
{
    if ( utility::issharedfuncdefined( #"game", #"isfeatureenabled" ) )
    {
        return [[ utility::getsharedfunc( #"game", #"isfeatureenabled" ) ]]( featurename );
    }
    
    return 0;
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0x1751df33, Offset: 0x118a
// Size: 0x38
function spectate_initsharedfunc()
{
    if ( utility::issharedfuncdefined( #"game", #"spectate_init" ) )
    {
        [[ utility::getsharedfunc( #"game", #"spectate_init" ) ]]();
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x7aef6fda, Offset: 0x11ca
// Size: 0x44
function function_57de0ca2e80536a1( v_origin )
{
    if ( utility::issharedfuncdefined( #"game", #"roundNumberDifficulty" ) )
    {
        return [[ utility::getsharedfunc( #"game", #"roundNumberDifficulty" ) ]]( v_origin );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 2
// Checksum 0x788c219d, Offset: 0x1216
// Size: 0x4f
function getteamdatasharedfunc( team, property )
{
    if ( utility::issharedfuncdefined( #"game", #"getteamdata" ) )
    {
        return [[ utility::getsharedfunc( #"game", #"getteamdata" ) ]]( team, property );
    }
    
    return [];
}

// Namespace namespace_9d8e359c3b1041e5
// Params 3
// Checksum 0x123a085a, Offset: 0x126e
// Size: 0x3a
function registerscoreinfosharedfunc( type, category, value )
{
    return utility::callsharedfunc( #"game", #"registerscoreinfo", type, category, value );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 6
// Checksum 0xc6bd3df3, Offset: 0x12b1
// Size: 0x59
function trysaylocalsoundsharedfunc( player, soundtype, delay, targetent, location, var_eeb6a639148e00e7 )
{
    return utility::callsharedfunc( #"game", #"trysaylocalsound", player, soundtype, delay, targetent, location, var_eeb6a639148e00e7 );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x33ff4a39, Offset: 0x1313
// Size: 0x43
function addrecentattackersharedfunc( attacker )
{
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"game" ][ #"addrecentattacker" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( attacker );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x69f2f875, Offset: 0x135e
// Size: 0x26
function handlemovingplatformssharedfunc( data )
{
    return utility::callsharedfunc( #"game", #"handlemovingplatforms", data );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0x6c1e6575, Offset: 0x138d
// Size: 0x1b, Type: bool
function isteamreviveenabledsharedfunc()
{
    return istrue( utility::callsharedfunc( #"game", #"isteamreviveenabled" ) );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0xad2855ab, Offset: 0x13b1
// Size: 0x44
function handlemovingplatformtouchsharedfunc( data )
{
    if ( utility::issharedfuncdefined( #"game", #"handleMovingPlatformTouch" ) )
    {
        [[ utility::getsharedfunc( #"game", #"handleMovingPlatformTouch" ) ]]( data );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 10
// Checksum 0x39377479, Offset: 0x13fd
// Size: 0x83
function targetmarkergroup_onsharedfunc( markerwidgetname, showto, tomark, groupowner, friendlymarker, markonspawn, var_52abf1a1f858871c, var_1e1ecace3b3c2a63, var_ee7bc8b53cebd37e, var_def1ff63d8a13201 )
{
    return utility::callsharedfunc( #"game", #"targetmarkergroup_on", markerwidgetname, showto, tomark, groupowner, friendlymarker, markonspawn, var_52abf1a1f858871c, var_1e1ecace3b3c2a63, var_ee7bc8b53cebd37e, var_def1ff63d8a13201 );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0xcd3497e3, Offset: 0x1489
// Size: 0x26
function targetmarkergroup_offsharedfunc( targetmarkergroupid )
{
    return utility::callsharedfunc( #"game", #"targetmarkergroup_off", targetmarkergroupid );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 6
// Checksum 0x5d400422, Offset: 0x14b8
// Size: 0x59
function registersentientsharedfunc( threatbiasgroup, var_7abeff39c291fc41, islethal, var_29232a9774002e87, var_3b8ee7e3e8397398, var_d1d5db309b77a8bb )
{
    return utility::callsharedfunc( #"game", #"registersentient", threatbiasgroup, var_7abeff39c291fc41, islethal, var_29232a9774002e87, var_3b8ee7e3e8397398, var_d1d5db309b77a8bb );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 2
// Checksum 0xb199eb1, Offset: 0x151a
// Size: 0x30
function unregistersentientsharedfunc( poolid, keyid )
{
    return utility::callsharedfunc( #"game", #"unregistersentient", poolid, keyid );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 2
// Checksum 0x9dfe0566, Offset: 0x1553
// Size: 0x30
function registerentforoobsharedfunc( ent, ref )
{
    return utility::callsharedfunc( #"game", #"registerentforoob", ent, ref );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 2
// Checksum 0xb7094c36, Offset: 0x158c
// Size: 0x30
function clearoobsharedfunc( ent, fromdeath )
{
    return utility::callsharedfunc( #"game", #"clearoob", ent, fromdeath );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0xa9315720, Offset: 0x15c5
// Size: 0x26
function addspawnviewersharedfunc( entity )
{
    return utility::callsharedfunc( #"game", #"addspawnviewer", entity );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0xa7b207ff, Offset: 0x15f4
// Size: 0x26
function removespawnviewersharedfunc( entity )
{
    return utility::callsharedfunc( #"game", #"removespawnviewer", entity );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0xca116507, Offset: 0x1623
// Size: 0x27
function forcenetfieldhighlod_sharedfunc( set )
{
    utility::callsharedfunc( #"game", #"forcenetfieldhighlod", set );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 2
// Checksum 0xb7f100c4, Offset: 0x1652
// Size: 0x31, Type: bool
function ispointinoutofboundssharedfunc( pointtocheck, teamtocheck )
{
    return istrue( utility::callsharedfunc( #"game", #"ispointinoutofbounds", pointtocheck, teamtocheck ) );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0xcab4d122, Offset: 0x168c
// Size: 0x1b, Type: bool
function shouldmodesetsquadssharedfunc()
{
    return istrue( utility::callsharedfunc( #"game", #"shouldmodesetsquads" ) );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 4
// Checksum 0xa9846e60, Offset: 0x16b0
// Size: 0x63
function function_287accac73ec9c41( attacker, objweapon, inflictor, meansofdeath )
{
    if ( utility::issharedfuncdefined( #"game", #"non_player_add_ignore_damage_signature" ) )
    {
        return [[ utility::getsharedfunc( #"game", #"non_player_add_ignore_damage_signature" ) ]]( attacker, objweapon, inflictor, meansofdeath );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x828c3daa, Offset: 0x171c
// Size: 0x44
function function_cc18ed453e5ccdbc( id )
{
    if ( utility::issharedfuncdefined( #"game", #"non_player_remove_ignore_damage_signature" ) )
    {
        [[ utility::getsharedfunc( #"game", #"non_player_remove_ignore_damage_signature" ) ]]( id );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0xeae0b4b, Offset: 0x1768
// Size: 0x26
function hostmigration_waitlongdurationwithpausesharedfunc( duration )
{
    return utility::callsharedfunc( #"hostmigration", #"waitLongDurationWithPause", duration );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 2
// Checksum 0x4a7bf817, Offset: 0x1797
// Size: 0x30
function waittill_notify_or_timeout_hostmigration_pause( msg, duration )
{
    return utility::callsharedfunc( #"hostmigration", #"waittillNotifyOrTimeoutPause", msg, duration );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 5
// Checksum 0xcbee58df, Offset: 0x17d0
// Size: 0x4f
function magicbulletsharedfunc( objweapon, start, end, owner, event_ent )
{
    return utility::callsharedfunc( #"weapons", #"magicbullet", objweapon, start, end, owner, event_ent );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 7
// Checksum 0xeb429fb2, Offset: 0x1828
// Size: 0x82
function launchgrenadesharedfunc( weaponname, origin, velocity, var_f4f3f0356fef8102, notthrown, var_93e691e8536b5f6d, tickpercentoverride )
{
    if ( utility::issharedfuncdefined( #"weapons", #"_launchgrenade" ) )
    {
        return [[ utility::getsharedfunc( #"weapons", #"_launchgrenade" ) ]]( weaponname, origin, velocity, var_f4f3f0356fef8102, notthrown, var_93e691e8536b5f6d, tickpercentoverride );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0xbc5d9502, Offset: 0x18b3
// Size: 0x26
function setmissileminimapvisiblesharedfunc( set )
{
    return utility::callsharedfunc( #"weapons", #"setmissileminimapvisible", set );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0xd9fa5301, Offset: 0x18e2
// Size: 0x26
function function_bc3d11edade5004( set )
{
    return utility::callsharedfunc( #"weapons", #"hash_a02d1dbbb057f8b0", set );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0xa619b0ad, Offset: 0x1911
// Size: 0x26
function function_2774ff2792a00056( set )
{
    return utility::callsharedfunc( #"weapons", #"hash_b36b4b3fd3a15594", set );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0xa022db8, Offset: 0x1940
// Size: 0x26
function function_fe287412c2a2bb55( anchor )
{
    return utility::callsharedfunc( #"weapons", #"hash_3db33cbf4379d27d", anchor );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x781fa333, Offset: 0x196f
// Size: 0x26
function setmissileimpactminimapiconsharedfunc( iconname )
{
    return utility::callsharedfunc( #"weapons", #"setMissileImpactMinimapIcon", iconname );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0x884a4293, Offset: 0x199e
// Size: 0x1a
function saveweaponstatessharedfunc()
{
    return utility::callsharedfunc( #"weapons", #"saveweaponstates" );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x325b0e67, Offset: 0x19c1
// Size: 0x26
function switchtoweaponsharedfunc( weapon )
{
    return utility::callsharedfunc( #"weapons", #"switchtoweapon", weapon );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0xa47f7655, Offset: 0x19f0
// Size: 0x26
function switchtoweaponimmediatesharedfunc( weapon )
{
    return utility::callsharedfunc( #"weapons", #"switchtoweaponimmediate", weapon );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x9ed417f0, Offset: 0x1a1f
// Size: 0x26
function takeweaponsharedfunc( weapon )
{
    return utility::callsharedfunc( #"weapons", #"takeweapon", weapon );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 2
// Checksum 0x70110aae, Offset: 0x1a4e
// Size: 0x4e
function monitordisownedgrenadesharedfunc( player, grenade )
{
    if ( utility::issharedfuncdefined( #"weapons", #"monitordisownedgrenade" ) )
    {
        [[ utility::getsharedfunc( #"weapons", #"monitordisownedgrenade" ) ]]( player, grenade );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 3
// Checksum 0xe8b5b351, Offset: 0x1aa4
// Size: 0x58
function monitordisownedequipmentsharedfunc( player, equipment, var_6637462580611fe3 )
{
    if ( utility::issharedfuncdefined( #"weapons", #"monitordisownedequipment" ) )
    {
        [[ utility::getsharedfunc( #"weapons", #"monitordisownedequipment" ) ]]( player, equipment, var_6637462580611fe3 );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0xe645121b, Offset: 0x1b04
// Size: 0x44
function minedamagemonitorsharedfunc( hitsmax )
{
    if ( utility::issharedfuncdefined( #"weapons", #"minedamagemonitor" ) )
    {
        [[ utility::getsharedfunc( #"weapons", #"minedamagemonitor" ) ]]( hitsmax );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 4
// Checksum 0x6f176e37, Offset: 0x1b50
// Size: 0x63
function onequipmentplantedsharedfunc( newequipment, equipmentref, deletefunc, var_42107120e1dfe43b )
{
    if ( utility::issharedfuncdefined( #"weapons", #"onequipmentplanted" ) )
    {
        [[ utility::getsharedfunc( #"weapons", #"onequipmentplanted" ) ]]( newequipment, equipmentref, deletefunc, var_42107120e1dfe43b );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x9a4dfbfa, Offset: 0x1bbb
// Size: 0x44
function outlineequipmentforownersharedfunc( equipment )
{
    if ( utility::issharedfuncdefined( #"weapons", #"outlineequipmentforowner" ) )
    {
        [[ utility::getsharedfunc( #"weapons", #"outlineequipmentforowner" ) ]]( equipment );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0xc8c14727, Offset: 0x1c07
// Size: 0x38
function makeexplosiveunusuabletagsharedfunc()
{
    if ( utility::issharedfuncdefined( #"weapons", #"makeexplosiveunusuabletag" ) )
    {
        [[ utility::getsharedfunc( #"weapons", #"makeexplosiveunusuabletag" ) ]]();
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 3
// Checksum 0x79bb884e, Offset: 0x1c47
// Size: 0x58
function explosivetriggersharedfunc( target, graceperiod, notifystr )
{
    if ( utility::issharedfuncdefined( #"weapons", #"explosivetrigger" ) )
    {
        [[ utility::getsharedfunc( #"weapons", #"explosivetrigger" ) ]]( target, graceperiod, notifystr );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x8ccae800, Offset: 0x1ca7
// Size: 0x44
function removeequipsharedfunc( equip )
{
    if ( utility::issharedfuncdefined( #"weapons", #"removeequip" ) )
    {
        [[ utility::getsharedfunc( #"weapons", #"removeequip" ) ]]( equip );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 2
// Checksum 0xed17b4c9, Offset: 0x1cf3
// Size: 0x4e
function addlockedonsharedfunc( entity, attacker )
{
    if ( utility::issharedfuncdefined( #"weapons", #"addlockedon" ) )
    {
        [[ utility::getsharedfunc( #"weapons", #"addlockedon" ) ]]( entity, attacker );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 2
// Checksum 0x73b663f5, Offset: 0x1d49
// Size: 0x4e
function removelockedonsharedfunc( entity, attacker )
{
    if ( utility::issharedfuncdefined( #"weapons", #"removelockedon" ) )
    {
        [[ utility::getsharedfunc( #"weapons", #"removelockedon" ) ]]( entity, attacker );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0x718c3ea2, Offset: 0x1d9f
// Size: 0x38
function ismissilelauncherlockonallowedsharedfunc()
{
    if ( utility::issharedfuncdefined( #"weapons", #"isMissileLauncherLockOnAllowed" ) )
    {
        return [[ utility::getsharedfunc( #"weapons", #"isMissileLauncherLockOnAllowed" ) ]]();
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x183305f0, Offset: 0x1ddf
// Size: 0x44
function lockonlaunchergettargetarraysharedfunc( addcharacters )
{
    if ( utility::issharedfuncdefined( #"weapons", #"lockOnLauncherGetTargetArray" ) )
    {
        return [[ utility::getsharedfunc( #"weapons", #"lockOnLauncherGetTargetArray" ) ]]( addcharacters );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 3
// Checksum 0x39d219ca, Offset: 0x1e2b
// Size: 0x58
function remoteinteractsetupsharedfunc( var_bc3be370eac48043, allowdefuse, allowhack )
{
    if ( utility::issharedfuncdefined( #"equipment", #"remoteinteractsetup" ) )
    {
        [[ utility::getsharedfunc( #"equipment", #"remoteinteractsetup" ) ]]( var_bc3be370eac48043, allowdefuse, allowhack );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0xc4653b14, Offset: 0x1e8b
// Size: 0x38
function getmineignorelistsharedfunc()
{
    if ( utility::issharedfuncdefined( #"equipment", #"getMineIgnoreList" ) )
    {
        return [[ utility::getsharedfunc( #"equipment", #"getMineIgnoreList" ) ]]();
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0x9b33decf, Offset: 0x1ecc
// Size: 0x38
function watchflightcollisionsharedfunc()
{
    if ( utility::issharedfuncdefined( #"equipment", #"watchFlightCollision" ) )
    {
        [[ utility::getsharedfunc( #"equipment", #"watchFlightCollision" ) ]]();
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 12
// Checksum 0x3ebca4e2, Offset: 0x1f0c
// Size: 0xb5
function setheadiconfactionimagesharedfunc( showtoallfactions, offset, drawthroughgeo, maxdrawdist, naturaldist, delaytime, var_c6bd58f878e4420a, ownerinvisible, overrideorigin, showonminimap, image, iconsizes )
{
    if ( utility::issharedfuncdefined( #"hud", #"setHeadIconFactionImage" ) )
    {
        return [[ utility::getsharedfunc( #"hud", #"setHeadIconFactionImage" ) ]]( showtoallfactions, offset, drawthroughgeo, maxdrawdist, naturaldist, delaytime, var_c6bd58f878e4420a, ownerinvisible, overrideorigin, showonminimap, image, iconsizes );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 4
// Checksum 0x30111151, Offset: 0x1fca
// Size: 0x63
function function_aa75822b8899334( equipment, imageoverride, originoverride, var_2647798941f03f3b )
{
    if ( utility::issharedfuncdefined( #"hud", #"setheadiconequipment" ) )
    {
        return [[ utility::getsharedfunc( #"hud", #"setheadiconequipment" ) ]]( equipment, imageoverride, originoverride, var_2647798941f03f3b );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x584459a8, Offset: 0x2036
// Size: 0x44
function setheadicondeleteiconsharedfunc( icon )
{
    if ( utility::issharedfuncdefined( #"hud", #"setHeadIconDeleteIcon" ) )
    {
        [[ utility::getsharedfunc( #"hud", #"setHeadIconDeleteIcon" ) ]]( icon );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0xecdd74c8, Offset: 0x2082
// Size: 0x42
function function_b739495605e4ba8a( b_hide )
{
    if ( utility::issharedfuncdefined( #"hud", #"hash_6f07e8aa7e74982" ) )
    {
        utility::callsharedfunc( #"hud", #"hash_6f07e8aa7e74982", b_hide );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 11
// Checksum 0x1b7dcac8, Offset: 0x20cc
// Size: 0x8d
function shellshock_artilleryearthquakesharedfunc( position, duration, scalemax, scalemid, scalemin, radiusmax, radiusmid, radiusmin, ignoreclients, playrumble, var_ca144b5ca4279c98 )
{
    return utility::callsharedfunc( #"shellshock", #"artillery_earthquake", position, duration, scalemax, scalemid, scalemin, radiusmax, radiusmid, radiusmin, ignoreclients, playrumble, var_ca144b5ca4279c98 );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 4
// Checksum 0x4c74deef, Offset: 0x2162
// Size: 0x64
function givesuperpointssharedfunc( points, scoreevent, bypassdisable, pointsmultiplier )
{
    if ( utility::issharedfuncdefined( #"supers", #"givesuperpoints" ) )
    {
        self [[ utility::getsharedfunc( #"supers", #"givesuperpoints" ) ]]( points, scoreevent, bypassdisable, pointsmultiplier );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0xa75d6584, Offset: 0x21ce
// Size: 0x39
function getsuperpointsneededsharedfunc()
{
    if ( utility::issharedfuncdefined( #"supers", #"getsuperpointsneeded" ) )
    {
        self [[ utility::getsharedfunc( #"supers", #"getsuperpointsneeded" ) ]]();
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 4
// Checksum 0x93559b6b, Offset: 0x220f
// Size: 0x64
function givesupersharedfunc( superref, savesuperpoints, immediate, blueprintindex )
{
    if ( utility::issharedfuncdefined( #"supers", #"givesuper" ) )
    {
        self [[ utility::getsharedfunc( #"supers", #"givesuper" ) ]]( superref, savesuperpoints, immediate, blueprintindex );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x29b01446, Offset: 0x227b
// Size: 0x44
function getsuperbundlefromoffhandweaponnamesharedfunc( weaponname )
{
    if ( utility::issharedfuncdefined( #"supers", #"getSuperBundleFromOffhandWeaponName" ) )
    {
        return [[ utility::getsharedfunc( #"supers", #"getSuperBundleFromOffhandWeaponName" ) ]]( weaponname );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x97f73d95, Offset: 0x22c8
// Size: 0x44
function getsuperweaponsharedfunc( superref )
{
    if ( utility::issharedfuncdefined( #"supers", #"getSuperWeapon" ) )
    {
        return [[ utility::getsharedfunc( #"supers", #"getSuperWeapon" ) ]]( superref );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0xd41b1fc1, Offset: 0x2315
// Size: 0x46
function haskillstreaksharedfunc( killstreakref )
{
    if ( utility::issharedfuncdefined( #"player", #"haskillstreak" ) )
    {
        return self [[ utility::getsharedfunc( #"player", #"haskillstreak" ) ]]( killstreakref );
    }
    
    return 0;
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0xa9757f9, Offset: 0x2364
// Size: 0x3a
function issuperinusesharedfunc()
{
    if ( utility::issharedfuncdefined( #"player", #"issuperinuse" ) )
    {
        return self [[ utility::getsharedfunc( #"player", #"issuperinuse" ) ]]();
    }
    
    return 0;
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0x236e9c55, Offset: 0x23a7
// Size: 0x39
function getcurrentsuperrefsharedfunc()
{
    if ( utility::issharedfuncdefined( #"player", #"getcurrentsuperref" ) )
    {
        return self [[ utility::getsharedfunc( #"player", #"getcurrentsuperref" ) ]]();
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 5
// Checksum 0xccf8edf, Offset: 0x23e8
// Size: 0x6e
function forcegivesupersharedfunc( targetsupername, dropcurrent, fromkiosk, droppurchased, var_6432f32bb6fece8b )
{
    if ( utility::issharedfuncdefined( #"player", #"forcegivesuper" ) )
    {
        self [[ utility::getsharedfunc( #"player", #"forcegivesuper" ) ]]( targetsupername, dropcurrent, fromkiosk, droppurchased, var_6432f32bb6fece8b );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0xc4f95676, Offset: 0x245e
// Size: 0x39
function function_403389469efa28fe()
{
    if ( utility::issharedfuncdefined( #"player", #"br_ammo_player_max_out" ) )
    {
        self [[ utility::getsharedfunc( #"player", #"br_ammo_player_max_out" ) ]]();
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x301b3685, Offset: 0x249f
// Size: 0x45
function addrespawntokensharedfunc( skipsplash )
{
    if ( utility::issharedfuncdefined( #"player", #"addrespawntoken" ) )
    {
        self [[ utility::getsharedfunc( #"player", #"addrespawntoken" ) ]]( skipsplash );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x1f9561b9, Offset: 0x24ec
// Size: 0x45
function addselfrevivetokensharedfunc( skipsplash )
{
    if ( utility::issharedfuncdefined( #"player", #"addselfrevivetoken" ) )
    {
        self [[ utility::getsharedfunc( #"player", #"addselfrevivetoken" ) ]]( skipsplash );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 8
// Checksum 0x6d22fc06, Offset: 0x2539
// Size: 0x6e
function updatehitmarker_sharedfunc( markertype, killingblow, headshot, nonplayer, icontype, targetentnum, armorPlateCount, var_795e8a31194a39ac )
{
    return utility::callsharedfunc( #"hitmarker", #"updatehitmarker_sharedfunc", markertype, killingblow, headshot, nonplayer, icontype, targetentnum, armorPlateCount, var_795e8a31194a39ac );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x89446167, Offset: 0x25b0
// Size: 0x26
function updateDamageFeedback_SharedFunc( icontype )
{
    return utility::callsharedfunc( #"hitmarker", #"updateDamageFeedback_SharedFunc", icontype );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0x47542f68, Offset: 0x25df
// Size: 0x3e
function isjuggernautsharedfunc()
{
    if ( utility::issharedfuncdefined( #"player", #"isjuggernaut" ) )
    {
        return self [[ utility::getsharedfunc( #"player", #"isjuggernaut" ) ]]();
    }
    
    return 0;
}

// Namespace namespace_9d8e359c3b1041e5
// Params 4
// Checksum 0x81ba90da, Offset: 0x2625
// Size: 0x65
function additemtobackpacksharedfunc( lootid, pickup, dontdropleftover, param4 )
{
    if ( utility::issharedfuncdefined( #"player", #"addItemToBackpack" ) )
    {
        return self [[ utility::getsharedfunc( #"player", #"addItemToBackpack" ) ]]( lootid, pickup, dontdropleftover, param4 );
    }
    
    return 0;
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0xe694e160, Offset: 0x2693
// Size: 0x38
function getavailabledmzbackpackindexsharedfunc()
{
    if ( utility::issharedfuncdefined( #"player", #"getAvailableDMZBackpackIndex" ) )
    {
        return [[ utility::getsharedfunc( #"player", #"getAvailableDMZBackpackIndex" ) ]]();
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x2defcd34, Offset: 0x26d4
// Size: 0x45
function didextractwithweaponcasesharedfunc( player )
{
    if ( utility::issharedfuncdefined( #"dmz", #"didExtractWithWeaponCase" ) )
    {
        return [[ utility::getsharedfunc( #"dmz", #"didExtractWithWeaponCase" ) ]]( player );
    }
    
    return 0;
}

// Namespace namespace_9d8e359c3b1041e5
// Params 10
// Checksum 0x1445e34e, Offset: 0x2722
// Size: 0xa1
function doscoreeventsharedfunc( event, objweapon, pointsoverride, xpoverride, victim, var_ae2a12845c1ef7c1, dontwait, cankillchain, streakinfo, var_dd3dc966adfb966 )
{
    if ( utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
    {
        return [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( event, objweapon, pointsoverride, xpoverride, victim, var_ae2a12845c1ef7c1, dontwait, cankillchain, streakinfo, var_dd3dc966adfb966 );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 2
// Checksum 0x210af901, Offset: 0x27cc
// Size: 0x4f
function preloadandqueueclasssharedfunc( class, highpriorityload )
{
    if ( utility::issharedfuncdefined( #"player", #"preloadandqueueclass" ) )
    {
        return self [[ utility::getsharedfunc( #"player", #"preloadandqueueclass" ) ]]( class, highpriorityload );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0xbd7e8dfa, Offset: 0x2824
// Size: 0x39
function savefavoriteloadoutsharedfunc()
{
    if ( utility::issharedfuncdefined( #"player", #"saveFavoriteLoadout" ) )
    {
        return self [[ utility::getsharedfunc( #"player", #"saveFavoriteLoadout" ) ]]();
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 2
// Checksum 0x5805ee5a, Offset: 0x2866
// Size: 0x4e
function br_giveselectedclasssharedfunc( player, dropcurrent )
{
    if ( utility::issharedfuncdefined( #"player", #"br_giveselectedclass" ) )
    {
        [[ utility::getsharedfunc( #"player", #"br_giveselectedclass" ) ]]( player, dropcurrent );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0xc277b007, Offset: 0x28bc
// Size: 0x3a
function iseligibleforteamrevivesharedfunc()
{
    if ( utility::issharedfuncdefined( #"player", #"iseligibleforteamrevive" ) )
    {
        return self [[ utility::getsharedfunc( #"player", #"iseligibleforteamrevive" ) ]]();
    }
    
    return 0;
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x5b9ee971, Offset: 0x28ff
// Size: 0x45
function isrespawningfromtokensharedfunc( player )
{
    if ( utility::issharedfuncdefined( #"player", #"isrespawningfromtoken" ) )
    {
        return [[ utility::getsharedfunc( #"player", #"isrespawningfromtoken" ) ]]( player );
    }
    
    return 0;
}

// Namespace namespace_9d8e359c3b1041e5
// Params 4
// Checksum 0xdc0833d8, Offset: 0x294d
// Size: 0x69
function playergulagautowinsharedfunc( sponsor, tokenused, var_350c06308cd3d7e3, var_ec22479f7c93f2e0 )
{
    if ( utility::issharedfuncdefined( #"gulag", #"playergulagautowin" ) )
    {
        self [[ utility::getsharedfunc( #"gulag", #"playergulagautowin" ) ]]( "", sponsor, tokenused, var_350c06308cd3d7e3, var_ec22479f7c93f2e0 );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x4663f4b1, Offset: 0x29be
// Size: 0x45
function playerprestreamrespawnoriginsharedfunc( spawnpoint )
{
    if ( utility::issharedfuncdefined( #"player", #"playerprestreamrespawnorigin" ) )
    {
        return self [[ utility::getsharedfunc( #"player", #"playerprestreamrespawnorigin" ) ]]( spawnpoint );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x3f5c7dd3, Offset: 0x2a0c
// Size: 0x45
function gulagfadetoblacksharedfunc( fadespectators )
{
    if ( utility::issharedfuncdefined( #"gulag", #"gulagfadetoblack" ) )
    {
        self [[ utility::getsharedfunc( #"gulag", #"gulagfadetoblack" ) ]]( fadespectators );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0xc6cdcaf4, Offset: 0x2a59
// Size: 0x39
function gulagstreamexitsharedfunc()
{
    if ( utility::issharedfuncdefined( #"gulag", #"gulagstreamexit" ) )
    {
        self [[ utility::getsharedfunc( #"gulag", #"gulagstreamexit" ) ]]();
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 2
// Checksum 0x31bb96e7, Offset: 0x2a9a
// Size: 0x4f
function playerteleportgulagsharedfunc( origin, angles )
{
    if ( utility::issharedfuncdefined( #"gulag", #"playerteleportgulag" ) )
    {
        self [[ utility::getsharedfunc( #"gulag", #"playerteleportgulag" ) ]]( origin, angles );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0xdc4a9793, Offset: 0x2af1
// Size: 0x45
function playercleanupentondisconnectsharedfunc( ent )
{
    if ( utility::issharedfuncdefined( #"player", #"playercleanupentondisconnect" ) )
    {
        self [[ utility::getsharedfunc( #"player", #"playercleanupentondisconnect" ) ]]( ent );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0x2ee94e45, Offset: 0x2b3e
// Size: 0x39
function playerwaittillstreamhintcompletesharedfunc()
{
    if ( utility::issharedfuncdefined( #"player", #"playerwaittillstreamhintcomplete" ) )
    {
        self [[ utility::getsharedfunc( #"player", #"playerwaittillstreamhintcomplete" ) ]]();
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0x9b565bbc, Offset: 0x2b7f
// Size: 0x39
function playerclearstreamhintoriginsharedfunc()
{
    if ( utility::issharedfuncdefined( #"player", #"playerclearstreamhintorigin" ) )
    {
        self [[ utility::getsharedfunc( #"player", #"playerclearstreamhintorigin" ) ]]();
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0x920d092b, Offset: 0x2bc0
// Size: 0x39
function resetplayermovespeedscalesharedfunc()
{
    if ( utility::issharedfuncdefined( #"player", #"resetplayermovespeedscale" ) )
    {
        self [[ utility::getsharedfunc( #"player", #"resetplayermovespeedscale" ) ]]();
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0x2314005f, Offset: 0x2c01
// Size: 0x39
function gulagfadefromblacksharedfunc()
{
    if ( utility::issharedfuncdefined( #"gulag", #"gulagfadefromblack" ) )
    {
        self [[ utility::getsharedfunc( #"gulag", #"gulagfadefromblack" ) ]]();
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0xbd799a44, Offset: 0x2c42
// Size: 0x3d, Type: bool
function isplayeringulagsharedfunc()
{
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"gulag" ][ #"isplayeringulag" ];
    
    if ( var_32dbca3143d9c4a5 && self [[ var_32dbca3143d9c4a5 ]]() )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0x4051f298, Offset: 0x2c88
// Size: 0x3a
function isplayerinorgoingtogulagsharedfunc()
{
    if ( utility::issharedfuncdefined( #"gulag", #"isplayerinorgoingtogulag" ) )
    {
        return self [[ utility::getsharedfunc( #"gulag", #"isplayerinorgoingtogulag" ) ]]();
    }
    
    return 0;
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0xa66a4146, Offset: 0x2ccb
// Size: 0x3a
function isplayerwaitingresurgencerespawnsharedfunc()
{
    if ( utility::issharedfuncdefined( #"player", #"isPlayerWaitingResurgenceRespawn" ) )
    {
        return self [[ utility::getsharedfunc( #"player", #"isPlayerWaitingResurgenceRespawn" ) ]]();
    }
    
    return 0;
}

// Namespace namespace_9d8e359c3b1041e5
// Params 2
// Checksum 0x99bc5b62, Offset: 0x2d0e
// Size: 0x4f
function playerplunderkioskpurchasesharedfunc( amount, data )
{
    if ( utility::issharedfuncdefined( #"player", #"playerplunderkioskpurchase" ) )
    {
        self [[ utility::getsharedfunc( #"player", #"playerplunderkioskpurchase" ) ]]( amount, data );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 3
// Checksum 0x3d4e18e0, Offset: 0x2d65
// Size: 0x56
function setscriptmoverkillcamsharedfunc( killstring, offsetup, offsetback )
{
    if ( utility::issharedfuncdefined( #"player", #"setscriptmoverkillcam" ) )
    {
        utility::callsharedfunc( #"player", #"setscriptmoverkillcam", killstring, offsetup, offsetback );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 3
// Checksum 0x2893c191, Offset: 0x2dc3
// Size: 0x3a
function fadetoblackforplayersharedfunc( player, fadetoblack, fadetime )
{
    return utility::callsharedfunc( #"player", #"fadetoblackforplayer", player, fadetoblack, fadetime );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 5
// Checksum 0x93800eb6, Offset: 0x2e06
// Size: 0x4f
function shellshocksharedfunc( name, category, duration, animationresponse, interruptdelayms )
{
    return utility::callsharedfunc( #"player", #"shellshock", name, category, duration, animationresponse, interruptdelayms );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0xa04d75dc, Offset: 0x2e5e
// Size: 0x26
function stopshellshocksharedfunc( fromdeath )
{
    return utility::callsharedfunc( #"player", #"stopshellshock", fromdeath );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0x291e5fe2, Offset: 0x2e8d
// Size: 0x1a
function setdof_cruisefirstsharedfunc()
{
    return utility::callsharedfunc( #"player", #"setdof_cruisefirst" );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 3
// Checksum 0x3653d7a5, Offset: 0x2eb0
// Size: 0x3a
function freezecontrolssharedfunc( frozen, force, debug )
{
    return utility::callsharedfunc( #"player", #"freezecontrols", frozen, force, debug );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x87ba691f, Offset: 0x2ef3
// Size: 0x26
function getplayersuperfactionsharedfunc( player )
{
    return utility::callsharedfunc( #"player", #"getSuperFaction", player );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0xc78a0645, Offset: 0x2f22
// Size: 0x1a
function isalivesharedfunc()
{
    return utility::callsharedfunc( #"player", #"playerisalive" );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 4
// Checksum 0xa9c910f, Offset: 0x2f45
// Size: 0x45
function getplayersinradiussharedfunc( origin, radius, desiredteam, excludeent )
{
    return utility::callsharedfunc( #"player", #"getplayersinradius", origin, radius, desiredteam, excludeent );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 2
// Checksum 0x411d2031, Offset: 0x2f93
// Size: 0x30
function freezelookcontrolssharedfunc( frozen, force )
{
    return utility::callsharedfunc( #"player", #"freezelookcontrols", frozen, force );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x657a6a0d, Offset: 0x2fcc
// Size: 0x26
function enableplayerusesharedfunc( player )
{
    return utility::callsharedfunc( #"player", #"enableplayeruse", player );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x5e579f70, Offset: 0x2ffb
// Size: 0x26
function disableplayerusesharedfunc( player )
{
    return utility::callsharedfunc( #"player", #"disableplayeruse", player );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0xbddd15b8, Offset: 0x302a
// Size: 0x44
function setusingremotesharedfunc( remotename )
{
    if ( utility::issharedfuncdefined( #"player", #"setusingremote" ) )
    {
        [[ utility::getsharedfunc( #"player", #"setusingremote" ) ]]( remotename );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x69e681d7, Offset: 0x3076
// Size: 0x44
function clearusingremotesharedfunc( bypassweaponswitch )
{
    if ( utility::issharedfuncdefined( #"player", #"clearusingremote" ) )
    {
        [[ utility::getsharedfunc( #"player", #"clearusingremote" ) ]]( bypassweaponswitch );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x4f595465, Offset: 0x30c2
// Size: 0x46
function function_698ebbcc057b168f( name )
{
    if ( utility::issharedfuncdefined( #"player", #"hash_1f1ccdc6843fdbb" ) )
    {
        return self [[ utility::getsharedfunc( #"player", #"hash_1f1ccdc6843fdbb" ) ]]( name );
    }
    
    return 0;
}

// Namespace namespace_9d8e359c3b1041e5
// Params 2
// Checksum 0xef1c8714, Offset: 0x3111
// Size: 0x4f
function function_3533667d928bc2cf( name, scale )
{
    if ( utility::issharedfuncdefined( #"player", #"hash_c707c518748873ce" ) )
    {
        self [[ utility::getsharedfunc( #"player", #"hash_c707c518748873ce" ) ]]( name, scale );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0x3422d763, Offset: 0x3168
// Size: 0x39
function function_f44fe9161043ae23()
{
    if ( utility::issharedfuncdefined( #"weapons", #"updatemovespeedscale" ) )
    {
        self [[ utility::getsharedfunc( #"weapons", #"updatemovespeedscale" ) ]]();
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x663bc29, Offset: 0x31a9
// Size: 0x45
function function_e1ac55197494863e( name )
{
    if ( utility::issharedfuncdefined( #"player", #"hash_a769545511e9bef" ) )
    {
        self [[ utility::getsharedfunc( #"player", #"hash_a769545511e9bef" ) ]]( name );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 2
// Checksum 0x48ce421c, Offset: 0x31f6
// Size: 0x4e
function branalytics_inventory_snapshotsharedfunc( player, reason )
{
    if ( utility::issharedfuncdefined( #"dlog", #"branalytics_inventory_snapshot" ) )
    {
        [[ utility::getsharedfunc( #"dlog", #"branalytics_inventory_snapshot" ) ]]( player, reason );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 3
// Checksum 0xfb3bd70f, Offset: 0x324c
// Size: 0x58
function branalytics_kiosk_purchaseloadoutsharedfunc( player, plunderspent, loadoutdata )
{
    if ( utility::issharedfuncdefined( #"dlog", #"branalytics_kiosk_purchaseloadout" ) )
    {
        [[ utility::getsharedfunc( #"dlog", #"branalytics_kiosk_purchaseloadout" ) ]]( player, plunderspent, loadoutdata );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 3
// Checksum 0xf3e2cb0c, Offset: 0x32ac
// Size: 0x59
function waittill_confirm_or_cancelsharedfunc( confirmstring, cancelstring, endstring )
{
    if ( utility::issharedfuncdefined( #"killstreak", #"waittill_confirm_or_cancel" ) )
    {
        return self [[ utility::getsharedfunc( #"killstreak", #"waittill_confirm_or_cancel" ) ]]( confirmstring, cancelstring, endstring );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 4
// Checksum 0xdcb7dba3, Offset: 0x330e
// Size: 0x45
function killstreak_registerminimapinfosharedfunc( bundle, killstreak, enableping, var_13ecbe20ea1c02d7 )
{
    return utility::callsharedfunc( #"killstreak", #"killstreak_registerMinimapInfo", bundle, killstreak, enableping, var_13ecbe20ea1c02d7 );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 10
// Checksum 0xd686afba, Offset: 0x335c
// Size: 0x83
function killstreak_setupvehicledamagefunctionalitysharedfunc( streakname, killstreakvehicle, scorepopup, vodestroyed, destroyedsplash, var_c96bcef6709d6df1, var_d188942a41771ea1, premoddamagecallback, postmoddamagecallback, deathcallback )
{
    return utility::callsharedfunc( #"killstreak", #"killstreak_setupVehicleDamageFunctionality", streakname, killstreakvehicle, scorepopup, vodestroyed, destroyedsplash, var_c96bcef6709d6df1, var_d188942a41771ea1, premoddamagecallback, postmoddamagecallback, deathcallback );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 11
// Checksum 0xd3f7f164, Offset: 0x33e8
// Size: 0x8d
function getmodifiedantikillstreakdamagesharedfunc( attacker, objweapon, meansofdeath, amount, maxhealth, divisorlrg, divisormed, divisorlow, divisormelee, divisortick, explodeoverride )
{
    return utility::callsharedfunc( #"killstreak", #"getmodifiedantikillstreakdamage", attacker, objweapon, meansofdeath, amount, maxhealth, divisorlrg, divisormed, divisorlow, divisormelee, divisortick, explodeoverride );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x269b6b4a, Offset: 0x347e
// Size: 0x26
function killstreak_updatedamagestatesharedfunc( currenthealth )
{
    return utility::callsharedfunc( #"killstreak", #"killstreak_updateDamageState", currenthealth );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 2
// Checksum 0x2e0c2785, Offset: 0x34ad
// Size: 0x30
function function_99585ce0ed7d5df7( streakinfo, location )
{
    return utility::callsharedfunc( #"killstreak", #"hash_183e3c892b7ef047", streakinfo, location );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 8
// Checksum 0x97d52cf7, Offset: 0x34e6
// Size: 0x6e
function streakdeploy_doweaponfireddeploysharedfunc( streakinfo, weaponobj, firednotify, weapongivencallback, weaponswitchendedcallback, weaponfiredcallback, weaponcleanupcallback, weapontakencallback )
{
    return utility::callsharedfunc( #"killstreak", #"streakdeploy_doweaponfireddeploy", streakinfo, weaponobj, firednotify, weapongivencallback, weaponswitchendedcallback, weaponfiredcallback, weaponcleanupcallback, weapontakencallback );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0xe0f21071, Offset: 0x355d
// Size: 0x36
function playerkillstreakgetownerlookatignoreentssharedfunc()
{
    if ( utility::issharedfuncdefined( #"killstreak", #"playerkillstreakgetownerlookatignoreents" ) )
    {
        return utility::callsharedfunc( #"killstreak", #"playerkillstreakgetownerlookatignoreents" );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 6
// Checksum 0x8c4aafd4, Offset: 0x359c
// Size: 0x59
function killstreak_dangernotifyplayersinrangesharedfunc( owner, ownerteam, range, streakname, location, overrideheight )
{
    return utility::callsharedfunc( #"killstreak", #"killstreak_dangernotifyplayersinrange", owner, ownerteam, range, streakname, location, overrideheight );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 5
// Checksum 0xe6bafab5, Offset: 0x35fe
// Size: 0x4f
function registerkillstreaksharedfunc( streakname, triggeredfunc, availablefunc, directusefunc, cleanupfunc )
{
    return utility::callsharedfunc( #"killstreak", #"registerkillstreak", streakname, triggeredfunc, availablefunc, directusefunc, cleanupfunc );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 4
// Checksum 0xf3764534, Offset: 0x3656
// Size: 0x45
function registerkillstreakdamagedealingweaponsharedfunc( streakname, var_bf295ddc16ebf8a0, damagesize, isplayerweapon )
{
    return utility::callsharedfunc( #"killstreak", #"registerKillstreakDamageDealingWeapon", streakname, var_bf295ddc16ebf8a0, damagesize, isplayerweapon );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 9
// Checksum 0x17227814, Offset: 0x36a4
// Size: 0x78
function registerkillstreakstowableweaponsharedfunc( streakname, weaponname, getweaponnamecallback, genericblueprintweaponkey, var_1a104ca5d22453a3, var_6e414cc6090725b6, var_140b97aca7f94974, weaponswitchendedcallback, var_20404e66691c7ed8 )
{
    return utility::callsharedfunc( #"killstreak", #"registerKillstreakStowableWeapon", streakname, weaponname, getweaponnamecallback, genericblueprintweaponkey, var_1a104ca5d22453a3, var_6e414cc6090725b6, var_140b97aca7f94974, weaponswitchendedcallback, var_20404e66691c7ed8 );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 3
// Checksum 0xf5d3c55, Offset: 0x3725
// Size: 0x3a
function registervisibilityomnvarforkillstreaksharedfunc( streakname, omnvarid, omnvarvalue )
{
    return utility::callsharedfunc( #"killstreak", #"registervisibilityomnvarforkillstreak", streakname, omnvarid, omnvarvalue );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 2
// Checksum 0xba030c1e, Offset: 0x3768
// Size: 0x30
function createstreakinfosharedfunc( streakname, owner )
{
    return utility::callsharedfunc( #"killstreak", #"createstreakinfo", streakname, owner );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 11
// Checksum 0xb3952836, Offset: 0x37a1
// Size: 0x8d
function streakdeploy_doweapontabletdeploysharedfunc( streakinfo, weapongivencallback, weaponswitchendedcallback, weaponcleanupcallback, weapontakencallback, var_199122e4d3f907ba, var_572ea452a1bc65ed, var_35a34784f1c6d395, var_9e428c3b74527aba, var_75defa1f64eb375a, var_37ae78e0de4a6e53 )
{
    return utility::callsharedfunc( #"killstreak", #"streakdeploy_doweapontabletdeploy", streakinfo, weapongivencallback, weaponswitchendedcallback, weaponcleanupcallback, weapontakencallback, var_199122e4d3f907ba, var_572ea452a1bc65ed, var_35a34784f1c6d395, var_9e428c3b74527aba, var_75defa1f64eb375a, var_37ae78e0de4a6e53 );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0x7935c49c, Offset: 0x3837
// Size: 0x1a
function getkillstreakairstrikeheightentsharedfunc()
{
    return utility::callsharedfunc( #"killstreak", #"getkillstreakairstrikeheightent" );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 6
// Checksum 0xeb3b22e6, Offset: 0x385a
// Size: 0x59
function playkillstreaktacomdialogsharedfunc( streakinfo, legacydialog, dialog, bypasscooldown, delaytime, charactersuffix )
{
    return utility::callsharedfunc( #"killstreak", #"playKillstreakTacomDialog", streakinfo, legacydialog, dialog, bypasscooldown, delaytime, charactersuffix );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 2
// Checksum 0x3d79a430, Offset: 0x38bc
// Size: 0x30
function function_8511f2e8c683aba7( equipmentref, dialog )
{
    return utility::callsharedfunc( #"killstreak", #"hash_34bea0ae9eceb6a6", equipmentref, dialog );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 3
// Checksum 0xbc4c94d7, Offset: 0x38f5
// Size: 0x3a
function playkillstreakteamleaderdialogsharedfunc( streakinfo, legacydialog, dialog )
{
    return utility::callsharedfunc( #"killstreak", #"playKillstreakTeamLeaderDialog", streakinfo, legacydialog, dialog );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x2e058650, Offset: 0x3938
// Size: 0x45
function forceusekillstreaksharedfunc( killstreakref )
{
    if ( utility::issharedfuncdefined( #"killstreak", #"forceusekillstreak" ) )
    {
        return self [[ utility::getsharedfunc( #"killstreak", #"forceusekillstreak" ) ]]( killstreakref );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 3
// Checksum 0x71b554ec, Offset: 0x3986
// Size: 0x59
function showkillstreaksplashsharedfunc( splashref, streakval, fromcarepackage )
{
    if ( utility::issharedfuncdefined( #"airdrop", #"showkillstreaksplash" ) )
    {
        self thread [[ utility::getsharedfunc( #"airdrop", #"showkillstreaksplash" ) ]]( splashref, streakval, fromcarepackage );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 7
// Checksum 0x5ec3e6ae, Offset: 0x39e7
// Size: 0x83
function awardkillstreaksharedfunc( streakname, source, overridelifeid, var_469a3c9c3145a68, overrideowner, var_f9c6f25b7483dfe6, blueprintindex )
{
    if ( utility::issharedfuncdefined( #"killstreak", #"awardkillstreak" ) )
    {
        self [[ utility::getsharedfunc( #"killstreak", #"awardkillstreak" ) ]]( streakname, source, overridelifeid, var_469a3c9c3145a68, overrideowner, var_f9c6f25b7483dfe6, blueprintindex );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 2
// Checksum 0xf0163ef, Offset: 0x3a72
// Size: 0x30
function function_f6af4ffa6dbb4645( streakname, omnvarstate )
{
    return utility::callsharedfunc( #"killstreak", #"hash_925d159a404f2c61", streakname, omnvarstate );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x2575c82d, Offset: 0x3aab
// Size: 0x26
function restorekillstreakplayeranglessharedfunc( player )
{
    return utility::callsharedfunc( #"killstreak", #"restorekillstreakplayerangles", player );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0xe666050d, Offset: 0x3ada
// Size: 0x26
function recordkillstreakendstatssharedfunc( streakinfo )
{
    return utility::callsharedfunc( #"killstreak", #"recordkillstreakendstats", streakinfo );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0xdbeb3e27, Offset: 0x3b09
// Size: 0x26
function killstreak_setmainvisionsharedfunc( visionsetname )
{
    return utility::callsharedfunc( #"killstreak", #"killstreak_setMainVision", visionsetname );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x3af3f5cb, Offset: 0x3b38
// Size: 0x26
function killstreak_setsubvisionsharedfunc( visionsetinfo )
{
    return utility::callsharedfunc( #"killstreak", #"killstreak_setSubVision", visionsetinfo );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 8
// Checksum 0xdad2df73, Offset: 0x3b67
// Size: 0x6e
function streakdeploy_doweaponswitchdeploysharedfunc( streakinfo, weaponobj, keepweapon, weapongivencallback, weaponswitchendedcallback, weaponcleanupcallback, weapontakencallback, var_3a21d446a2f14d2c )
{
    return utility::callsharedfunc( #"killstreak", #"streakdeploy_doweaponswitchdeploy", streakinfo, weaponobj, keepweapon, weapongivencallback, weaponswitchendedcallback, weaponcleanupcallback, weapontakencallback, var_3a21d446a2f14d2c );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 3
// Checksum 0xe8456396, Offset: 0x3bde
// Size: 0x3a
function killstreak_switchbacklastweaponsharedfunc( deployweapon, immediateswitch, optionaltimedelay )
{
    return utility::callsharedfunc( #"killstreak", #"killstreak_switchBackLastWeapon", deployweapon, immediateswitch, optionaltimedelay );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0xc7536a1c, Offset: 0x3c21
// Size: 0x26
function getridofkillstreakdeployweaponsharedfunc( weaponobj )
{
    return utility::callsharedfunc( #"killstreak", #"getridofkillstreakdeployweapon", weaponobj );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 3
// Checksum 0x406de9a2, Offset: 0x3c50
// Size: 0x3a
function manualturret_disablefiresharedfunc( user, disabletime, enableendons )
{
    return utility::callsharedfunc( #"killstreak", #"manualturret_disablefire", user, disabletime, enableendons );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x7e624f0c, Offset: 0x3c93
// Size: 0x26
function manualturret_clearplacementinstructionssharedfunc( clearaction )
{
    return utility::callsharedfunc( #"killstreak", #"manualturret_clearplacementinstructions", clearaction );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 2
// Checksum 0x3ecd5201, Offset: 0x3cc2
// Size: 0x4f
function registerkillstreakweaponfiresharedfunc( streakinfo, weaponname )
{
    if ( utility::issharedfuncdefined( #"killstreak", #"registerKillstreakWeaponFire" ) )
    {
        self [[ utility::getsharedfunc( #"killstreak", #"registerKillstreakWeaponFire" ) ]]( streakinfo, weaponname );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x54c255a9, Offset: 0x3d19
// Size: 0x26
function function_19145ff013934a47( streakname )
{
    return utility::callsharedfunc( #"killstreak", #"hash_ae9fad232ee97408", streakname );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 3
// Checksum 0xe121bde2, Offset: 0x3d48
// Size: 0x3a
function vehicle_damage_clearvisualssharedfunc( data, changed, fromdeath )
{
    return utility::callsharedfunc( #"vehicle", #"vehicle_damage_clearvisuals", data, changed, fromdeath );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 2
// Checksum 0xe74226a7, Offset: 0x3d8b
// Size: 0x4e
function vehicleminesgetleveldataforminesharedfunc( equipref, create )
{
    if ( utility::issharedfuncdefined( #"vehicle", #"vehicleMinesGetLevelDataForMine" ) )
    {
        return [[ utility::getsharedfunc( #"vehicle", #"vehicleMinesGetLevelDataForMine" ) ]]( equipref, create );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x51c25788, Offset: 0x3de2
// Size: 0x26
function vehiclefindsafeexitpossharedfunc( guy )
{
    return utility::callsharedfunc( #"vehicle", #"vehicleFindSafeExitPos", guy );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 2
// Checksum 0xd5d21629, Offset: 0x3e11
// Size: 0x4e
function registerspawnsharedfunc( entcount, deletefunc )
{
    if ( utility::issharedfuncdefined( #"entity", #"registerspawn" ) )
    {
        [[ utility::getsharedfunc( #"entity", #"registerspawn" ) ]]( entcount, deletefunc );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0x8e2a5cb6, Offset: 0x3e67
// Size: 0x38
function deregisterspawnsharedfunc()
{
    if ( utility::issharedfuncdefined( #"entity", #"deregisterspawn" ) )
    {
        [[ utility::getsharedfunc( #"entity", #"deregisterspawn" ) ]]();
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0xc623b31a, Offset: 0x3ea7
// Size: 0x44
function removespawninfluencersharedfunc( handle )
{
    if ( utility::issharedfuncdefined( #"spawn", #"removeSpawnInfluencer" ) )
    {
        [[ utility::getsharedfunc( #"spawn", #"removeSpawnInfluencer" ) ]]( handle );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 5
// Checksum 0xb603706c, Offset: 0x3ef3
// Size: 0x6d
function addspawninfluencersharedfunc( influencerkey, pos, friendlyteam, playerowner, linkedent )
{
    if ( utility::issharedfuncdefined( #"spawn", #"addSpawnInfluencer" ) )
    {
        return [[ utility::getsharedfunc( #"spawn", #"addSpawnInfluencer" ) ]]( influencerkey, pos, friendlyteam, playerowner, linkedent );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x617173a1, Offset: 0x3f69
// Size: 0x26
function function_4c27e16d83fce53a( position )
{
    return utility::callsharedfunc( #"event", #"predatormissileimpact", position );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0xc9bca775, Offset: 0x3f98
// Size: 0x26
function function_1b4f3463636d75b5( position )
{
    return utility::callsharedfunc( #"event", #"largevehicleexplosion", position );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x6f15fce, Offset: 0x3fc7
// Size: 0x26
function function_3f6bebe1af42b0a8( damagedata )
{
    return utility::callsharedfunc( #"event", #"vehiclekilled", damagedata );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x1ce3d5d9, Offset: 0x3ff6
// Size: 0x26
function function_ed5039695a18b289( missile )
{
    return utility::callsharedfunc( #"event", #"missilefired", missile );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 4
// Checksum 0xb6de4cf3, Offset: 0x4025
// Size: 0x45
function emp_debuff_register_sharedfunc( entity, applycallback, startcallback, clearcallback )
{
    return utility::callsharedfunc( #"emp", #"emp_debuff_register", entity, applycallback, startcallback, clearcallback );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0xabeef314, Offset: 0x4073
// Size: 0x26
function emp_debuff_deregister_sharedfunc( entity )
{
    return utility::callsharedfunc( #"emp", #"emp_debuff_deregister", entity );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x31de12bd, Offset: 0x40a2
// Size: 0x26
function clear_empsharedfunc( fromdeath )
{
    return utility::callsharedfunc( #"emp", #"clear_emp", fromdeath );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0xa5a61701, Offset: 0x40d1
// Size: 0x26
function allow_empsharedfunc( status )
{
    return utility::callsharedfunc( #"emp", #"allow_emp", status );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0x8cc7ced8, Offset: 0x4100
// Size: 0x1a
function function_d2b2cb6a7fea26de()
{
    return utility::callsharedfunc( #"emp", #"emp_debuff_get_emp_count" );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0x450b594b, Offset: 0x4123
// Size: 0x1b, Type: bool
function is_empdsharedfunc()
{
    return istrue( utility::callsharedfunc( #"emp", #"is_empd" ) );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 2
// Checksum 0x360174f4, Offset: 0x4147
// Size: 0x30
function play_scramblesharedfunc( scramblelevel, isjammer )
{
    return utility::callsharedfunc( #"emp", #"play_scramble", scramblelevel, isjammer );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 2
// Checksum 0xa23b780a, Offset: 0x4180
// Size: 0x30
function stop_scramblesharedfunc( scramblelevel, isjammer )
{
    return utility::callsharedfunc( #"emp", #"stop_scramble", scramblelevel, isjammer );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 2
// Checksum 0x5ea2153b, Offset: 0x41b9
// Size: 0x30
function function_62b4af8718fa499b( optionalorigin, optionalradius )
{
    return utility::callsharedfunc( #"emp", #"emp_debuff_get_emp_ents", optionalorigin, optionalradius );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 3
// Checksum 0x643faf24, Offset: 0x41f2
// Size: 0x3a
function playsoundtoplayersharedfunc( aliasname, player, srcentity )
{
    return utility::callsharedfunc( #"sound", #"playsoundtoplayer", aliasname, player, srcentity );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 5
// Checksum 0xc3782704, Offset: 0x4235
// Size: 0x4f
function spawnfxforclientsharedfunc( fxid, position, player, forward, up )
{
    return utility::callsharedfunc( #"fx", #"spawnfxforclient", fxid, position, player, forward, up );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0xec0c7714, Offset: 0x428d
// Size: 0x1b
function setfxkilldefondeletesharedfunc()
{
    utility::callsharedfunc( #"fx", #"setfxkilldefondelete" );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 3
// Checksum 0x60f2565, Offset: 0x42b0
// Size: 0x3a
function function_bb9b98eb7368a15a( scriptbundle_name, current_round, var_97ec033c18291ffa )
{
    return utility::callsharedfunc( #"zombie", #"health_scaling_get_starting_health", scriptbundle_name, current_round, var_97ec033c18291ffa );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 3
// Checksum 0xe9f08c6b, Offset: 0x42f3
// Size: 0x3a
function function_870440d8340968c0( subclass, current_round, var_97ec033c18291ffa )
{
    return utility::callsharedfunc( #"zombie", #"health_scaling_get_subclass_health", subclass, current_round, var_97ec033c18291ffa );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0xcb470460, Offset: 0x4336
// Size: 0x26
function function_b2ccfa9f49ce6938( current_round )
{
    return utility::callsharedfunc( #"zombie", #"hash_e27e55920dabe660", current_round );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0xeb948671, Offset: 0x4365
// Size: 0x26
function function_e4935f0a53f85b86( current_round )
{
    return utility::callsharedfunc( #"zombie", #"hash_97c7552f5ba94f2c", current_round );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0xc22ac53f, Offset: 0x4394
// Size: 0x26
function function_ba64ecf971fcc9ba( current_round )
{
    return utility::callsharedfunc( #"zombie", #"hash_c726695b2536f1a", current_round );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0xa8fc758, Offset: 0x43c3
// Size: 0x1a
function function_6977eb27282ef178()
{
    return utility::callsharedfunc( #"zombie", #"ammo_mod_cooldown_init" );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 2
// Checksum 0x9a9e67f8, Offset: 0x43e6
// Size: 0x39, Type: bool
function function_f3b72bf1c0b8c737( w_current, inflictor = undefined )
{
    return istrue( utility::callsharedfunc( #"zombie", #"has_ammo_mod", w_current, inflictor ) );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 2
// Checksum 0xa53c9da0, Offset: 0x4428
// Size: 0x38
function function_30cd19b8533d27d2( w_current, inflictor = undefined )
{
    return utility::callsharedfunc( #"zombie", #"get_ammo_mod_name", w_current, inflictor );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x9890c033, Offset: 0x4469
// Size: 0x26
function getplayerweaponraritysharedfunc( weapon )
{
    return utility::callsharedfunc( #"zombie", #"GetPlayerWeaponRarity", weapon );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x89e6a582, Offset: 0x4498
// Size: 0x26
function function_1d4087075103b248( weapon )
{
    return utility::callsharedfunc( #"zombie", #"get_pap_level", weapon );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0xe53e3b88, Offset: 0x44c7
// Size: 0x26
function function_d14f9550ec3c9c39( dmg_struct )
{
    return utility::callsharedfunc( #"zombie", #"scaleUnderbarrelDamageByRound", dmg_struct );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0xa4506a0f, Offset: 0x44f6
// Size: 0x1a
function function_fd2dd8546ecc345e()
{
    return utility::callsharedfunc( #"zombie", #"disable_emergence_spawning_on_death" );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 10
// Checksum 0x56dc8472, Offset: 0x4519
// Size: 0x83
function onHumanoidAgentKilledCommon_SharedFunc( einflictor, eattacker, idamage, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration, dropweapons )
{
    return utility::callsharedfunc( #"ai", #"onHumanoidAgentKilledCommon_SharedFunc", einflictor, eattacker, idamage, smeansofdeath, objweapon, vdir, shitloc, timeoffset, deathanimduration, dropweapons );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 6
// Checksum 0x63cdeb7a, Offset: 0x45a5
// Size: 0x59
function spawnnewaitype_sharedfunc( aitype, position, angles, team, characterlistname, gender )
{
    return utility::callsharedfunc( #"ai", #"spawnnewaitype_sharedfunc", aitype, position, angles, team, characterlistname, gender );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 6
// Checksum 0x4af55814, Offset: 0x4607
// Size: 0x59
function animscripted_sharedfunc( anime, anim_string, org, animangles, anim_flag, dont_clear )
{
    return utility::callsharedfunc( #"ai", #"Animscripted_SharedFunc", anime, anim_string, org, animangles, anim_flag, dont_clear );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x6a5880f3, Offset: 0x4669
// Size: 0x26
function get_aitype_by_subclass_sharedfunc( subclass )
{
    return utility::callsharedfunc( #"ai", #"get_aitype_by_subclass_sharedfunc", subclass );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0x3a1064a, Offset: 0x4698
// Size: 0x1a
function get_aitype_default_spawn_team_SharedFunc()
{
    return utility::callsharedfunc( #"ai", #"get_aitype_default_spawn_team_SharedFunc" );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 11
// Checksum 0x48393288, Offset: 0x46bb
// Size: 0x8d
function displaydamagenumber_sharedfunc( eattacker, etargethit, shitloc, smeansofdeath, sweapon, idamage, vpoint, isimmnue, selement, biscritical, var_4f9d5587bf9a2b1e )
{
    return utility::callsharedfunc( #"ai", #"displaydamagenumber_sharedfunc", eattacker, etargethit, shitloc, smeansofdeath, sweapon, idamage, vpoint, isimmnue, selement, biscritical, var_4f9d5587bf9a2b1e );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0xdc9cf13c, Offset: 0x4751
// Size: 0x26
function giveaiweapon_sharedfunc( weapname )
{
    return utility::callsharedfunc( #"ai", #"giveAIWeapon", weapname );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0xf688a34d, Offset: 0x4780
// Size: 0x1a
function getfreeaicount_sharedfunc()
{
    return utility::callsharedfunc( #"ai", #"getfreeaicount" );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 2
// Checksum 0xfbfde330, Offset: 0x47a3
// Size: 0x30
function function_a0ae7f4d57eeafce( var_f6ea54cdc54d753, a_ai_types )
{
    return utility::callsharedfunc( #"zm_utility", #"hash_664f6f3563adae69", var_f6ea54cdc54d753, a_ai_types );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 2
// Checksum 0xde001884, Offset: 0x47dc
// Size: 0x4f
function showpoweruphudsharedfunc( powerupname, lifetime )
{
    if ( utility::issharedfuncdefined( #"powerups", #"showPowerupHud" ) )
    {
        self [[ utility::getsharedfunc( #"powerups", #"showPowerupHud" ) ]]( powerupname, lifetime );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0xd7dbabeb, Offset: 0x4833
// Size: 0x39
function dopowerupscoreeventsharedfunc()
{
    if ( utility::issharedfuncdefined( #"powerups", #"doPowerupScoreEvent" ) )
    {
        self [[ utility::getsharedfunc( #"powerups", #"doPowerupScoreEvent" ) ]]();
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 3
// Checksum 0x8e833686, Offset: 0x4874
// Size: 0x59
function droppowerupsharedfunc( powerupname, spawnpos, lifetimeOverride )
{
    if ( utility::issharedfuncdefined( #"powerups", #"dropPowerup" ) )
    {
        return self [[ utility::getsharedfunc( #"powerups", #"dropPowerup" ) ]]( powerupname, spawnpos, lifetimeOverride );
    }
}

// Namespace namespace_9d8e359c3b1041e5
// Params 0
// Checksum 0xedfce03a, Offset: 0x48d5
// Size: 0x1a
function function_9cce6b480d1d501a()
{
    return utility::callsharedfunc( #"points", #"get_points" );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x19abfc73, Offset: 0x48f8
// Size: 0x26
function function_95e6efa0e69ace16( points )
{
    return utility::callsharedfunc( #"points", #"set_points", points );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x4cf20155, Offset: 0x4927
// Size: 0x26
function function_c46160a261771d5d( points )
{
    return utility::callsharedfunc( #"points", #"add_points", points );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 1
// Checksum 0x2dd8fa47, Offset: 0x4956
// Size: 0x26
function function_6ea1ac037efdef01( points )
{
    return utility::callsharedfunc( #"points", #"take_points", points );
}

// Namespace namespace_9d8e359c3b1041e5
// Params 2
// Checksum 0xd1bb9a50, Offset: 0x4985
// Size: 0x30
function function_95538e4344ab0bfb( dvar_value, func )
{
    return utility::callsharedfunc( #"dev", #"register_dev_console_callback", dvar_value, func );
}

