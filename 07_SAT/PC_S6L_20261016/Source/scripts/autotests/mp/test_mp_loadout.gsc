// scripts\autotests\mp\test_mp_loadout.gsc  (hash_31c022c59d7efc2e.gscc) (size: 13908 Bytes / 0x3654 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa3851c62 (2743409762)
// size ...... 13908 (0x3654)
// includes .. 8   (offset: 0x3228)
// strings ... 63  (offset: 0x3268)
// dev strs .. 0   (offset: 0x3654)
// exports ... 24  (offset: 0x266c)
// cseg ...... 0x6f8 + 0x1f74 (0x266c)
// imports ... 55  (offset: 0x2a2c)
// animtree1 . 0   (offset: 0x3654)
// animtree2 . 0   (offset: 0x3654)
#using scripts\autotests\autotests;
#using scripts\autotests\autotests_utility;
#using scripts\autotests\autotests_utility_bot;
#using scripts\autotests\autotests_utility_player;
#using scripts\common\weapon;
#using scripts\mp\class;
#using scripts\mp\common\utility\loot;
#using scripts\mp\validation;

#namespace test_mp_loadout;

// Namespace test_mp_loadout/testautomation
// Params 0, eflags: 0x20
// Checksum 0x985cae2c, Offset: 0x716
// Size: 0x26
function event_handler[testautomation] main()
{
    autotests::register_tests( "scripts/autotests/mp/test_mp_loadout.gsc", #"test", &start_test, &setup, &cleanup );
}

// Namespace test_mp_loadout
// Params 0
// Checksum 0x21129087, Offset: 0x744
// Size: 0x1ac, Type: bool
function start_test()
{
    player = autotests_utility_player::get_player();
    autotests::push_function( "Prematch completed" );
    test_result_int = player autotests_utility::test_prematch_done() ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Prematch completed", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_loadout.gsc", 45 );
    autotests::pop_function( "Prematch completed" );
    autotests::test_assert_return( test_result_int );
    testcases = function_c8b39bada1a18f12();
    autotests::push_function( "Weapon validation works" );
    test_result_int = player function_4a06ce3f3e6b5e5( testcases ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Weapon validation works", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_loadout.gsc", 48 );
    autotests::pop_function( "Weapon validation works" );
    autotests::test_assert_return( test_result_int );
    testcases = function_86b8e588938f4e09();
    autotests::push_function( "Attachment validation works" );
    test_result_int = player test_attachments( testcases ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Attachment validation works", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_loadout.gsc", 51 );
    autotests::pop_function( "Attachment validation works" );
    autotests::test_assert_return( test_result_int );
    testcases = function_8f4709154c296741();
    autotests::push_function( "Perk validation works" );
    test_result_int = player test_perks( testcases ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Perk validation works", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_loadout.gsc", 54 );
    autotests::pop_function( "Perk validation works" );
    autotests::test_assert_return( test_result_int );
    testcases = function_825d3c9305163f9f();
    autotests::push_function( "Equipment validation works" );
    test_result_int = player function_5d23f1300f341e55( testcases ) ?? 0;
    test_result_int = autotests::function_e496a326e5d58a25( "Equipment validation works", test_result_int, undefined, undefined, "scripts/autotests/mp/test_mp_loadout.gsc", 57 );
    autotests::pop_function( "Equipment validation works" );
    autotests::test_assert_return( test_result_int );
    return false;
}

// Namespace test_mp_loadout
// Params 0, eflags: 0x4
// Checksum 0x237acc76, Offset: 0x8f9
// Size: 0x113
function private setup()
{
    autotests::function_5c8c87763724c132();
    autotests_utility::setup();
    player = autotests_utility_player::get_player();
    var_63a718d91714219d = autotests::function_36ed835262a19e53( "Player found?", player, "scripts/autotests/mp/test_mp_loadout.gsc", 68 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    bundle = autotests::get_test_bundle( self.test.xhash_ref );
    level.autotests.test_runtime.bundle = bundle;
    autotests::set_dvar( @"unlockallitems", 0 );
    level.autotests.test_runtime.var_ff164eb2cd7a2415 = level.gamemodebundle.var_ff164eb2cd7a2415;
    setup_refs();
    setup_banned_items( bundle, level.autotests.test_runtime.banneditems );
    return 1;
}

// Namespace test_mp_loadout
// Params 0, eflags: 0x4
// Checksum 0x705351c6, Offset: 0xa15
// Size: 0x48
function private cleanup()
{
    autotests_utility_bot::kick_all_bots();
    autotests_utility::cleanup();
    level.gamemodebundle.var_ff164eb2cd7a2415 = level.autotests.test_runtime.var_ff164eb2cd7a2415;
    loot::function_36413802e4a9f188();
}

// Namespace test_mp_loadout
// Params 0, eflags: 0x4
// Checksum 0xef1c9305, Offset: 0xa65
// Size: 0x39f
function private setup_refs()
{
    fallbackloadout = validation::function_b7ff987740639b18();
    [ var_43a009d2d9b82ac2, pibasename ] = autotests_utility::function_fc09add23c4398c1( "pi", 0, fallbackloadout.fallbacksecondary );
    level.autotests.test_runtime.var_43a009d2d9b82ac2 = var_43a009d2d9b82ac2;
    [ var_45d14500581f17bf, smbasename ] = autotests_utility::function_fc09add23c4398c1( "sm", 0, fallbackloadout.fallbackprimary );
    level.autotests.test_runtime.var_45d14500581f17bf = var_45d14500581f17bf;
    [ var_3fa95b44fb04da83, var_30e5f5c3e8d34f44 ] = autotests_utility::function_fc09add23c4398c1( "sm", 1, fallbackloadout.fallbackprimary );
    level.autotests.test_runtime.var_3fa95b44fb04da83 = var_3fa95b44fb04da83;
    [ var_ccaa2f35b6c7a8ae, shbasename ] = autotests_utility::function_fc09add23c4398c1( "sh", 0, fallbackloadout.fallbackprimary );
    level.autotests.test_runtime.var_ccaa2f35b6c7a8ae = var_ccaa2f35b6c7a8ae;
    [ var_93e08faf02964be2, arbasename ] = autotests_utility::function_fc09add23c4398c1( "ar", 0, fallbackloadout.fallbackprimary );
    level.autotests.test_runtime.var_93e08faf02964be2 = var_93e08faf02964be2;
    [ var_7e9bf83562354b71, meleebasename ] = autotests_utility::function_fc09add23c4398c1( "me", 0, fallbackloadout.fallbacktertiary, undefined, undefined, "weapon_melee2" );
    level.autotests.test_runtime.var_7e9bf83562354b71 = var_7e9bf83562354b71;
    [ var_9315750321bb1e1, var_3bd049bc9cc7c464 ] = autotests_utility::function_fc09add23c4398c1( "me", 1, fallbackloadout.fallbacktertiary, undefined, undefined, "weapon_melee2" );
    level.autotests.test_runtime.var_9315750321bb1e1 = var_9315750321bb1e1;
    level.autotests.test_runtime.smattachments = getweapondefaultattachments( smbasename );
    level.autotests.test_runtime.piattachments = getweapondefaultattachments( pibasename );
    shattachments = getweapondefaultattachments( shbasename );
    var_9e5e18b15d5f4e84 = shattachments[ shattachments.size - 1 ];
    shattachments[ shattachments.size - 1 ] = undefined;
    level.autotests.test_runtime.shattachments = shattachments;
    level.autotests.test_runtime.var_9e5e18b15d5f4e84 = var_9e5e18b15d5f4e84;
    banneditems = [ var_3fa95b44fb04da83, var_9315750321bb1e1, var_9e5e18b15d5f4e84 ];
    level.autotests.test_runtime.banneditems = banneditems;
}

// Namespace test_mp_loadout
// Params 0, eflags: 0x4
// Checksum 0x9208dd39, Offset: 0xe0c
// Size: 0x478
function private function_c8b39bada1a18f12()
{
    testcases = [];
    testcases[ testcases.size ] = function_48659094169156d5( 1, "Test valid primary", level.autotests.test_runtime.var_45d14500581f17bf, "Primary", undefined, 0, 1 );
    testcases[ testcases.size ] = function_48659094169156d5( 1, "Test banned primary", level.autotests.test_runtime.var_3fa95b44fb04da83, "Primary", undefined, 0, 0 );
    testcases[ testcases.size ] = function_48659094169156d5( 1, "Test giving pistol as primary (give wildcard)", level.autotests.test_runtime.var_43a009d2d9b82ac2, "Primary", #"wildcard", 1, 1 );
    testcases[ testcases.size ] = function_48659094169156d5( 1, "Test giving pistol as primary (no wildcard)", level.autotests.test_runtime.var_43a009d2d9b82ac2, "Primary", #"wildcard", 0, 0 );
    testcases[ testcases.size ] = function_48659094169156d5( 1, "Test giving pistol as primary (give perk)", level.autotests.test_runtime.var_43a009d2d9b82ac2, "Primary", #"perk", 1, 1 );
    testcases[ testcases.size ] = function_48659094169156d5( 1, "Test giving pistol as primary (no perk)", level.autotests.test_runtime.var_43a009d2d9b82ac2, "Primary", #"perk", 0, 0 );
    testcases[ testcases.size ] = function_48659094169156d5( 1, "Test giving pistol as primary (always)", level.autotests.test_runtime.var_43a009d2d9b82ac2, "Primary", #"always", undefined, 1 );
    testcases[ testcases.size ] = function_48659094169156d5( 1, "Test giving pistol as secondary (no wildcard)", level.autotests.test_runtime.var_43a009d2d9b82ac2, "Secondary", #"wildcard", 0, 1 );
    testcases[ testcases.size ] = function_48659094169156d5( 1, "Test giving pistol as secondary (no perk)", level.autotests.test_runtime.var_43a009d2d9b82ac2, "Secondary", #"perk", 0, 1 );
    testcases[ testcases.size ] = function_48659094169156d5( 1, "Test giving pistol as secondary (always)", level.autotests.test_runtime.var_43a009d2d9b82ac2, "Secondary", #"always", undefined, 1 );
    testcases[ testcases.size ] = function_48659094169156d5( 1, "Test sm secondary (give wildcard)", level.autotests.test_runtime.var_45d14500581f17bf, "Secondary", #"wildcard", 1, 1 );
    testcases[ testcases.size ] = function_48659094169156d5( 1, "Test sm secondary (no wildcard)", level.autotests.test_runtime.var_45d14500581f17bf, "Secondary", #"wildcard", 0, 0 );
    testcases[ testcases.size ] = function_48659094169156d5( 1, "Test sm secondary (give perk)", level.autotests.test_runtime.var_45d14500581f17bf, "Secondary", #"perk", 1, 1 );
    testcases[ testcases.size ] = function_48659094169156d5( 1, "Test sm secondary (no perk)", level.autotests.test_runtime.var_45d14500581f17bf, "Secondary", #"perk", 0, 0 );
    testcases[ testcases.size ] = function_48659094169156d5( 1, "Test sm secondary (always)", level.autotests.test_runtime.var_45d14500581f17bf, "Secondary", #"always", undefined, 1 );
    testcases[ testcases.size ] = function_48659094169156d5( 1, "Test me tertiary", level.autotests.test_runtime.var_7e9bf83562354b71, "Tertiary", undefined, undefined, 1 );
    testcases[ testcases.size ] = function_48659094169156d5( 1, "Test pi tertiary", level.autotests.test_runtime.var_43a009d2d9b82ac2, "Tertiary", undefined, undefined, 0 );
    testcases[ testcases.size ] = function_48659094169156d5( 1, "Test banned tertiary", level.autotests.test_runtime.var_9315750321bb1e1, "Tertiary", undefined, undefined, 0 );
    return testcases;
}

// Namespace test_mp_loadout
// Params 7, eflags: 0x4
// Checksum 0x32095d5f, Offset: 0x128d
// Size: 0x90
function private function_48659094169156d5( active, name, weaponref, weaponslot, overkillmechanism, giveoverkill, shouldpass )
{
    return { #shouldpass:shouldpass, #giveoverkill:giveoverkill, #overkillmechanism:overkillmechanism, #weaponslot:weaponslot, #weaponref:weaponref, #name:name, #active:active };
}

// Namespace test_mp_loadout
// Params 0, eflags: 0x4
// Checksum 0xe27483a3, Offset: 0x1326
// Size: 0x3c6
function private function_86b8e588938f4e09()
{
    testcases = [];
    var_b404c0303e872784 = weapon::getmaxprimaryattachments();
    var_a99010684f3e4377 = weapon::getmaxprimaryattachments( "wildcard_gunfighter" );
    piattachments = [];
    smattachments = [];
    
    for ( index = 0; index < var_b404c0303e872784 ; index++ )
    {
        smattachments[ smattachments.size ] = level.autotests.test_runtime.smattachments[ index ];
        piattachments[ piattachments.size ] = level.autotests.test_runtime.piattachments[ index ];
    }
    
    var_45d14500581f17bf = level.autotests.test_runtime.var_45d14500581f17bf;
    var_43a009d2d9b82ac2 = level.autotests.test_runtime.var_43a009d2d9b82ac2;
    var_ccaa2f35b6c7a8ae = level.autotests.test_runtime.var_ccaa2f35b6c7a8ae;
    var_63a718d91714219d = autotests::function_e5041006e5cc3d56( "SMG " + var_45d14500581f17bf + " has enough attachments for invalid test?", level.autotests.test_runtime.smattachments.size, var_b404c0303e872784 + 1, "scripts/autotests/mp/test_mp_loadout.gsc", 194 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    var_63a718d91714219d = autotests::function_e5041006e5cc3d56( "Pi " + var_43a009d2d9b82ac2 + " has enough attachments for invalid test?", level.autotests.test_runtime.piattachments.size, var_b404c0303e872784 + 1, "scripts/autotests/mp/test_mp_loadout.gsc", 195 );
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
    
    testcases[ testcases.size ] = function_df6cc1bcf22a8aa0( 1, "Test default max num sm attachments", var_45d14500581f17bf, "Primary", smattachments, 0, 1 );
    testcases[ testcases.size ] = function_df6cc1bcf22a8aa0( 1, "Test default max num pi attachments", var_43a009d2d9b82ac2, "Secondary", piattachments, 0, 1 );
    shattachments = [];
    shattachments[ shattachments.size ] = level.autotests.test_runtime.shattachments[ index ];
    shattachments[ shattachments.size ] = level.autotests.test_runtime.var_9e5e18b15d5f4e84;
    testcases[ testcases.size ] = function_df6cc1bcf22a8aa0( 1, "Test banned sh attachment", var_ccaa2f35b6c7a8ae, "Primary", shattachments, 0, 0 );
    
    if ( false )
    {
        testcases[ testcases.size ] = function_df6cc1bcf22a8aa0( 1, "Test too many sm attachments", var_45d14500581f17bf, "Primary", level.autotests.test_runtime.smattachments, 0, 0 );
        testcases[ testcases.size ] = function_df6cc1bcf22a8aa0( 1, "Test too many pi attachments", var_43a009d2d9b82ac2, "Secondary", level.autotests.test_runtime.piattachments, 0, 0 );
    }
    
    if ( 0 && var_b404c0303e872784 != var_a99010684f3e4377 )
    {
        piattachments = [];
        smattachments = [];
        
        for ( index = 0; index < var_a99010684f3e4377 ; index++ )
        {
            smattachments = level.autotests.test_runtime.smattachments[ index ];
            piattachments = level.autotests.test_runtime.piattachments[ index ];
        }
        
        testcases[ testcases.size ] = function_df6cc1bcf22a8aa0( 1, "Test default max num sm attachments", var_45d14500581f17bf, "Primary", smattachments, 1, 1 );
        testcases[ testcases.size ] = function_df6cc1bcf22a8aa0( 1, "Test default max num pi attachments", var_43a009d2d9b82ac2, "Secondary", piattachments, 1, 1 );
    }
    else
    {
        autotests::report_info( "Skip gunfighter checks as gunfighter not supported in current mode" );
    }
    
    return testcases;
}

// Namespace test_mp_loadout
// Params 7, eflags: 0x4
// Checksum 0x8ae1ead1, Offset: 0x16f5
// Size: 0x90
function private function_df6cc1bcf22a8aa0( active, name, weaponref, weaponslot, attachmentrefs, givegunfighter, shouldpass )
{
    return { #shouldpass:shouldpass, #hasgunfighter:givegunfighter, #attachmentrefs:attachmentrefs, #weaponslot:weaponslot, #weaponref:weaponref, #name:name, #active:active };
}

// Namespace test_mp_loadout
// Params 2, eflags: 0x4
// Checksum 0xf7802a95, Offset: 0x178e
// Size: 0xda
function private setup_banned_items( bundle, var_59fa6a8f5a4a4007 )
{
    banneditems = arraycopy( var_59fa6a8f5a4a4007 );
    
    for ( index = 0; index < banneditems.size ; index++ )
    {
        banneditems[ banneditems.size ] = bundle.var_738aec820910dd90[ index ].itemref;
    }
    
    if ( !banneditems.size )
    {
        return;
    }
    
    autotests::set_dvar( @"scr_loadout_validate_banned_items", 1 );
    itemrefs = "";
    
    for ( index = 0; index < banneditems.size ; index++ )
    {
        banneditem = banneditems[ index ];
        itemrefs += banneditem;
        
        if ( index != banneditems.size - 1 )
        {
            itemrefs += "|";
        }
    }
    
    autotests::set_dvar( @"hash_18d43c13f449a92b", itemrefs );
    loot::function_36413802e4a9f188();
}

// Namespace test_mp_loadout
// Params 1, eflags: 0x4
// Checksum 0xf0c63640, Offset: 0x1870
// Size: 0xa0
function private function_28a57d0ecea5acbf( cases )
{
    if ( !isdefined( cases ) )
    {
        return [];
    }
    
    ret = [];
    
    foreach ( testcase in cases )
    {
        if ( testcase.active )
        {
            ret[ ret.size ] = testcase;
        }
    }
    
    return ret;
}

// Namespace test_mp_loadout
// Params 0, eflags: 0x4
// Checksum 0xce4e7aca, Offset: 0x1919
// Size: 0x3c
function private function_8f4709154c296741()
{
    bundle = level.autotests.test_runtime.bundle;
    return function_28a57d0ecea5acbf( bundle.var_75dd79c4f2b25cea );
}

// Namespace test_mp_loadout
// Params 0, eflags: 0x4
// Checksum 0x77f6c4c2, Offset: 0x195e
// Size: 0x3c
function private function_825d3c9305163f9f()
{
    bundle = level.autotests.test_runtime.bundle;
    return function_28a57d0ecea5acbf( bundle.var_894b0e2dbf6d7f3a );
}

// Namespace test_mp_loadout
// Params 0, eflags: 0x4
// Checksum 0x5dc50729, Offset: 0x19a3
// Size: 0x40
function private function_73558af6263ca519()
{
    class = "custom1";
    struct = class::loadout_getclassstruct();
    var_4d5575c6f9ec8a5b = class::function_ad7e91d3dac61546();
    class::loadout_updateclasscustom( struct, class, var_4d5575c6f9ec8a5b );
    return struct;
}

// Namespace test_mp_loadout
// Params 4, eflags: 0x4
// Checksum 0xeedbe650, Offset: 0x19ec
// Size: 0x1e9
function private function_642692fa47462209( weaponref, slot, overkillmechanism, giveoverkill )
{
    struct = function_73558af6263ca519();
    
    switch ( slot )
    {
        case #"hash_fccfcd8277773719":
            struct.loadoutprimary = weaponref;
            break;
        case #"hash_4ca1718be0cc7311":
            struct.loadoutsecondary = weaponref;
            break;
        case #"hash_acf717b438051903":
            struct.loadouttertiary = weaponref;
            break;
    }
    
    level.gamemodebundle.var_ff164eb2cd7a2415 = overkillmechanism ?? level.gamemodebundle.var_ff164eb2cd7a2415;
    
    if ( giveoverkill )
    {
        switch ( level.gamemodebundle.var_ff164eb2cd7a2415 )
        {
            case #"wildcard":
                struct.loadoutwildcard = "wildcard_overkill";
                break;
            case #"perk":
                struct.loadoutperks[ struct.loadoutperks.size ] = "specialty_munitions_2";
                break;
            case #"always":
                break;
            default:
                break;
        }
    }
    
    var_25cd9baa4bdd20fd = validation::validateloadout( struct );
    
    switch ( slot )
    {
        case #"hash_fccfcd8277773719":
            return ( struct.loadoutprimary == weaponref );
        case #"hash_4ca1718be0cc7311":
            return ( struct.loadoutsecondary == weaponref );
        case #"hash_acf717b438051903":
            return ( struct.loadouttertiary == weaponref );
    }
    
    var_63a718d91714219d = 1;
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace test_mp_loadout
// Params 1, eflags: 0x4
// Checksum 0x5a3edf17, Offset: 0x1bdd
// Size: 0x93
function private function_5b3d472351a90dd0( var_74247ea4bbdcc695 )
{
    refs = [];
    
    foreach ( struct in var_74247ea4bbdcc695 )
    {
        refs[ refs.size ] = struct.value;
    }
    
    return refs;
}

// Namespace test_mp_loadout
// Params 4, eflags: 0x4
// Checksum 0x4e7b084b, Offset: 0x1c79
// Size: 0x18f
function private function_77a15d6ae313cfc9( weaponref, slot, attachmentrefs, hasgunfighter )
{
    struct = function_73558af6263ca519();
    
    switch ( slot )
    {
        case #"hash_fccfcd8277773719":
            struct.loadoutprimary = weaponref;
            struct.loadoutprimaryattachments = arraycopy( attachmentrefs );
            break;
        case #"hash_4ca1718be0cc7311":
            struct.loadoutsecondary = weaponref;
            struct.loadoutsecondaryattachments = arraycopy( attachmentrefs );
            break;
        case #"hash_acf717b438051903":
            struct.loadouttertiary = weaponref;
            struct.loadoutTertiaryAttachments = arraycopy( attachmentrefs );
            break;
    }
    
    struct.loadoutwildcard = hasgunfighter ? "wildcard_gunfighter" : "wildcard_none";
    var_25cd9baa4bdd20fd = validation::validateloadout( struct );
    
    switch ( slot )
    {
        case #"hash_fccfcd8277773719":
            return arraycompare( struct.loadoutprimaryattachments, attachmentrefs );
        case #"hash_4ca1718be0cc7311":
            return arraycompare( struct.loadoutsecondaryattachments, attachmentrefs );
        case #"hash_acf717b438051903":
            return arraycompare( struct.loadoutTertiaryAttachments, attachmentrefs );
    }
    
    var_63a718d91714219d = 1;
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace test_mp_loadout
// Params 1, eflags: 0x4
// Checksum 0x3fb0a1f0, Offset: 0x1e10
// Size: 0x53
function private check_perk_validation( perkrefs )
{
    struct = function_73558af6263ca519();
    struct.loadoutperks = arraycopy( perkrefs );
    var_25cd9baa4bdd20fd = validation::validateloadout( struct );
    return arraycompare( struct.loadoutperks, perkrefs );
}

// Namespace test_mp_loadout
// Params 2, eflags: 0x4
// Checksum 0xe9db150d, Offset: 0x1e6c
// Size: 0xe8
function private function_41edf86eb1cba3f5( equipmentref, equipmenttype )
{
    struct = function_73558af6263ca519();
    
    switch ( equipmenttype )
    {
        case #"hash_bcda913af2b6eabb":
            struct.loadoutequipmentprimary = equipmentref;
            break;
        case #"hash_7b1a9c590ae0ac94":
            struct.loadoutequipmentsecondary = equipmentref;
            break;
    }
    
    var_25cd9baa4bdd20fd = validation::validateloadout( struct );
    
    switch ( equipmenttype )
    {
        case #"hash_bcda913af2b6eabb":
            return ( struct.loadoutequipmentprimary == equipmentref );
        case #"hash_7b1a9c590ae0ac94":
            return ( struct.loadoutequipmentsecondary == equipmentref );
    }
    
    var_63a718d91714219d = 1;
    
    if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
    {
        if ( autotests::function_561cb32cd7469145() )
        {
            return;
        }
        
        autotests::test_assert_return( var_63a718d91714219d );
    }
}

// Namespace test_mp_loadout
// Params 1, eflags: 0x4
// Checksum 0xbd003729, Offset: 0x1f5c
// Size: 0x1ae
function private function_4a06ce3f3e6b5e5( testcases )
{
    foreach ( testcase in testcases )
    {
        autotests::report_info( "Testing " + testcase.weaponref );
        
        if ( testcase.shouldpass )
        {
            var_63a718d91714219d = autotests::function_d84657f448aaeef6( testcase.name + " correctly passes " + testcase.weaponslot + " Validation", function_642692fa47462209( testcase.weaponref, testcase.weaponslot, testcase.overkillmechanism, testcase.giveoverkill ), "scripts/autotests/mp/test_mp_loadout.gsc", 461 );
            
            if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
            {
                if ( autotests::function_561cb32cd7469145() )
                {
                    return;
                }
                
                autotests::test_assert_return( var_63a718d91714219d );
            }
            
            continue;
        }
        
        var_63a718d91714219d = autotests::function_ae5837f8e14d9b71( testcase.name + " correctly fails " + testcase.weaponslot + "  Validation", function_642692fa47462209( testcase.weaponref, testcase.weaponslot, testcase.overkillmechanism, testcase.giveoverkill ), "scripts/autotests/mp/test_mp_loadout.gsc", 465 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
}

// Namespace test_mp_loadout
// Params 1, eflags: 0x4
// Checksum 0x76375e93, Offset: 0x2112
// Size: 0x23a
function private test_attachments( testcases )
{
    foreach ( testcase in testcases )
    {
        attachmentstring = "";
        spacer = "";
        
        foreach ( attachmentref in testcase.attachmentrefs )
        {
            attachmentstring += spacer;
            attachmentstring += attachmentref;
            spacer = ", ";
        }
        
        autotests::report_info( "Testing " + testcase.weaponref );
        autotests::report_info( "Attachments " + attachmentstring );
        
        if ( testcase.shouldpass )
        {
            var_63a718d91714219d = autotests::function_d84657f448aaeef6( testcase.name + " correctly passes attachment Validation", function_77a15d6ae313cfc9( testcase.weaponref, testcase.weaponslot, testcase.attachmentrefs, testcase.hasgunfighter ), "scripts/autotests/mp/test_mp_loadout.gsc", 488 );
            
            if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
            {
                if ( autotests::function_561cb32cd7469145() )
                {
                    return;
                }
                
                autotests::test_assert_return( var_63a718d91714219d );
            }
            
            continue;
        }
        
        var_63a718d91714219d = autotests::function_ae5837f8e14d9b71( testcase.name + " correctly fails attachment Validation", function_77a15d6ae313cfc9( testcase.weaponref, testcase.weaponslot, testcase.attachmentrefs, testcase.hasgunfighter ), "scripts/autotests/mp/test_mp_loadout.gsc", 492 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
}

// Namespace test_mp_loadout
// Params 1, eflags: 0x4
// Checksum 0x7c3d8401, Offset: 0x2354
// Size: 0x1b2
function private test_perks( testcases )
{
    foreach ( testcase in testcases )
    {
        autotests::report_info( "Testing " + testcase.var_79bb0194285050e + ", " + testcase.var_3518afd46aac831d + ", " + testcase.var_13f7efe7a522d64c );
        
        if ( testcase.shouldpass )
        {
            var_63a718d91714219d = autotests::function_d84657f448aaeef6( testcase.name + " correctly passes perk Validation", check_perk_validation( [ testcase.var_79bb0194285050e, testcase.var_3518afd46aac831d, testcase.var_13f7efe7a522d64c ] ), "scripts/autotests/mp/test_mp_loadout.gsc", 505 );
            
            if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
            {
                if ( autotests::function_561cb32cd7469145() )
                {
                    return;
                }
                
                autotests::test_assert_return( var_63a718d91714219d );
            }
            
            continue;
        }
        
        var_63a718d91714219d = autotests::function_ae5837f8e14d9b71( testcase.name + " correctly fails perk Validation", check_perk_validation( [ testcase.var_79bb0194285050e, testcase.var_3518afd46aac831d, testcase.var_13f7efe7a522d64c ] ), "scripts/autotests/mp/test_mp_loadout.gsc", 509 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
}

// Namespace test_mp_loadout
// Params 1, eflags: 0x4
// Checksum 0xc5f6df96, Offset: 0x250e
// Size: 0x15e
function private function_5d23f1300f341e55( testcases )
{
    foreach ( testcase in testcases )
    {
        autotests::report_info( "Testing " + testcase.equipmentref );
        
        if ( testcase.shouldpass )
        {
            var_63a718d91714219d = autotests::function_d84657f448aaeef6( testcase.name + " correctly passes equipment Validation", function_41edf86eb1cba3f5( testcase.equipmentref, testcase.equipmenttype ), "scripts/autotests/mp/test_mp_loadout.gsc", 522 );
            
            if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
            {
                if ( autotests::function_561cb32cd7469145() )
                {
                    return;
                }
                
                autotests::test_assert_return( var_63a718d91714219d );
            }
            
            continue;
        }
        
        var_63a718d91714219d = autotests::function_ae5837f8e14d9b71( testcase.name + " correctly fails equipment Validation", function_41edf86eb1cba3f5( testcase.equipmentref, testcase.equipmenttype ), "scripts/autotests/mp/test_mp_loadout.gsc", 526 );
        
        if ( !autotests::function_5a030dd4450c1448( var_63a718d91714219d ) )
        {
            if ( autotests::function_561cb32cd7469145() )
            {
                return;
            }
            
            autotests::test_assert_return( var_63a718d91714219d );
        }
    }
}

