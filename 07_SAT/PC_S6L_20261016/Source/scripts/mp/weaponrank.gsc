// scripts\mp\weaponrank.gsc  (hash_0a1acdaa4abd9dac.gscc) (size: 10305 Bytes / 0x2841 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6668f0fd (1718153469)
// size ...... 10305 (0x2841)
// includes .. 5   (offset: 0x2601)
// strings ... 15  (offset: 0x2629)
// dev strs .. 23  (offset: 0x271d)
// exports ... 37  (offset: 0x1899)
// cseg ...... 0x164 + 0x1735 (0x1899)
// imports ... 62  (offset: 0x1e61)
// animtree1 . 0   (offset: 0x2841)
// animtree2 . 0   (offset: 0x2841)
#using scripts\common\progression_utility;
#using scripts\common\weapon;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;

#namespace weaponrank;

// Namespace weaponrank
// Params 0
// Checksum 0x63bfb541, Offset: 0x182
// Size: 0xb3
function init()
{
    /#
        if ( getdvarint( @"hash_e6afce2cf5cf7515", 0 ) )
        {
            return;
        }
    #/
    
    if ( !isdefined( level.var_431d3dd6b0605770 ) )
    {
        level.var_431d3dd6b0605770 = getdvarint( @"hash_bd2bb9f10c3af5e8", 1 );
    }
    
    loadweaponranktable();
    level.activearmoryenabled = getdvarint( @"hash_53b03e37a92e4ce8", 1 ) == 1;
    level.var_c772be8094b38181 = getdvarfloat( @"hash_ca4ce52ff089426", 0.2 );
    level.var_8b100e8162654a78 = game_utility::function_52f600c9a675164c();
    addglobalweaponrankxpmultiplier( level.var_8b100e8162654a78, "online_global_weapon_xpscale" );
    level.var_bf6e0b80d2cc59ae = getgametypeweaponxpmultiplier();
    level thread onplayerconnect();
}

// Namespace weaponrank
// Params 0
// Checksum 0xad850cea, Offset: 0x23d
// Size: 0x72
function onplayerconnect()
{
    for ( ;; )
    {
        level waittill( #"connected", player );
        
        if ( !isai( player ) )
        {
            if ( level.weaponxpenabled )
            {
                var_94ac59e71acb4c18 = getdvarint( @"online_mp_party_weapon_xpscale" );
                isinparty = player getprivatepartysize() > 1;
                
                if ( isinparty )
                {
                    player addweaponrankxpmultiplier( var_94ac59e71acb4c18, "online_mp_party_weapon_xpscale" );
                }
            }
        }
    }
}

// Namespace weaponrank
// Params 2, eflags: 0x4
// Checksum 0xa1652b2d, Offset: 0x2b7
// Size: 0x1de
function private function_a7ffebf6a96595a0( projectref, weaponranktablebundle )
{
    assert( isdefined( level.var_d7d85d1113d7d3d2 ) );
    assert( !isdefined( level.var_d7d85d1113d7d3d2[ projectref ] ) );
    maxrank = weaponranktablebundle.maxrank;
    var_d52103b73d570051 = weaponranktablebundle.var_d52103b73d570051;
    var_2ac50a0e4ba913c0 = weaponranktablebundle.var_2ac50a0e4ba913c0;
    level.var_d7d85d1113d7d3d2[ projectref ] = spawnstruct();
    level.var_d7d85d1113d7d3d2[ projectref ].maxrank = maxrank;
    level.var_d7d85d1113d7d3d2[ projectref ].var_d52103b73d570051 = var_d52103b73d570051;
    level.var_d7d85d1113d7d3d2[ projectref ].var_2ac50a0e4ba913c0 = var_2ac50a0e4ba913c0;
    level.var_d7d85d1113d7d3d2[ projectref ].rankinfo = [];
    
    for ( rankid = 0; rankid <= maxrank ; rankid++ )
    {
        weaponranktableentry = progression_utility::function_7602a04bc7c08c34( weaponranktablebundle.weaponranklist[ rankid ].rank );
        rankinfo = spawnstruct();
        rankinfo.minxp = weaponranktableentry.minxp;
        rankinfo.xptonextrank = weaponranktableentry.xptonext;
        rankinfo.maxxp = weaponranktableentry.maxxp;
        level.var_d7d85d1113d7d3d2[ projectref ].rankinfo[ rankid ] = rankinfo;
        assert( rankinfo.minxp + rankinfo.xptonextrank == rankinfo.maxxp, "<dev string:x24>" + rankid + "<dev string:x3b>" + projectref + "<dev string:x49>" );
    }
}

// Namespace weaponrank
// Params 0
// Checksum 0xd8fc17c5, Offset: 0x49d
// Size: 0x552
function loadweaponranktable()
{
    if ( !isdefined( level.var_d7d85d1113d7d3d2 ) && game[ #"levelcache" ].var_d7d85d1113d7d3d2 )
    {
        level.var_d7d85d1113d7d3d2 = game[ #"levelcache" ].var_d7d85d1113d7d3d2;
        level.var_3c549d90fbff3cd0 = game[ #"levelcache" ].var_3c549d90fbff3cd0;
        level.var_dc1abb305baf0c52 = game[ #"levelcache" ].var_dc1abb305baf0c52;
        return;
    }
    
    level.var_d7d85d1113d7d3d2 = [];
    level.var_dc1abb305baf0c52 = 0;
    var_8dfdaabeb8f5f04a = progression_utility::function_7bde1faea3e37e6();
    
    if ( isdefined( var_8dfdaabeb8f5f04a ) )
    {
        assert( isdefined( var_8dfdaabeb8f5f04a.var_d7d85d1113d7d3d2 ) );
        level.var_dc1abb305baf0c52 = 1;
        
        foreach ( entry in var_8dfdaabeb8f5f04a.var_d7d85d1113d7d3d2 )
        {
            projectref = entry.projectref;
            weaponranktablebundle = getscriptbundle( entry.weaponranktable );
            function_a7ffebf6a96595a0( projectref, weaponranktablebundle );
        }
    }
    else
    {
        projectref = "all";
        weaponranktablebundle = progression_utility::getweaponranktablebundle();
        function_a7ffebf6a96595a0( projectref, weaponranktablebundle );
    }
    
    level.var_3c549d90fbff3cd0 = spawnstruct();
    level.var_3c549d90fbff3cd0.maxweaponranks = [];
    level.var_3c549d90fbff3cd0.maxweaponprestige = [];
    level.var_3c549d90fbff3cd0.var_1b3b791551432906 = [];
    var_f72de877ddcf00b7 = function_6964cf29cc187092();
    weaponsscriptbundle = weapon::function_16ff7d597f441100();
    
    if ( weaponsscriptbundle )
    {
        bundlevalues = [ #"ref", #"weaponprogression", #"hash_a9dd520c2fca5b", #"hash_8fda8cc8830728a4" ];
        
        foreach ( weaponname in weaponsscriptbundle )
        {
            /#
                if ( getdvarint( @"hash_76b61b42484b128f", 0 ) == 1 )
                {
                    println( "<dev string:x82>" + weaponname );
                }
            #/
            
            weaponscriptbundle = weapon::function_659a3e10e8d1c91c( weaponname, bundlevalues );
            
            if ( weaponscriptbundle )
            {
                rootname = weaponscriptbundle.ref;
                maxrank = weaponscriptbundle.weaponprogression.size;
                var_3a85739023e3cf42 = weaponscriptbundle.var_3a85739023e3cf42;
                
                if ( level.var_431d3dd6b0605770 && weaponscriptbundle.var_a1ce61685bb64675 )
                {
                    var_aecb159d1aa94bae = getscriptbundlefieldvalues( weaponscriptbundle.var_a1ce61685bb64675, bundlevalues );
                    
                    if ( var_aecb159d1aa94bae.ref )
                    {
                        var_8926f72ffef912e5 = var_aecb159d1aa94bae.ref;
                        maxrank = var_aecb159d1aa94bae.weaponprogression.size;
                        var_3a85739023e3cf42 = var_aecb159d1aa94bae.var_3a85739023e3cf42;
                    }
                }
                
                if ( !isdefined( rootname ) || rootname == "" || maxrank == 0 )
                {
                    continue;
                }
                
                /#
                    projectname = var_f72de877ddcf00b7[ rootname ];
                    
                    if ( !isdefined( projectname ) )
                    {
                        println( "<dev string:xa3>" + rootname + "<dev string:xba>" );
                    }
                #/
                
                level.var_3c549d90fbff3cd0.var_1b3b791551432906[ rootname ] = var_f72de877ddcf00b7[ rootname ];
                maxrank = int( maxrank );
                var_312b04b0a9d6b25 = getmaxweaponrank( var_8926f72ffef912e5 ?? rootname );
                assert( maxrank <= var_312b04b0a9d6b25, "<dev string:xd6>" + rootname + "<dev string:xe2>" + maxrank + "<dev string:xf7>" + var_312b04b0a9d6b25 );
                level.var_3c549d90fbff3cd0.maxweaponranks[ rootname ] = maxrank;
                var_63d82eecabc68b79 = int( var_3a85739023e3cf42.size - 1 );
                
                if ( var_63d82eecabc68b79 > 0 )
                {
                    level.var_3c549d90fbff3cd0.maxweaponprestige[ rootname ] = var_3a85739023e3cf42[ var_63d82eecabc68b79 ].prestige;
                }
            }
        }
    }
    
    assert( level.var_3c549d90fbff3cd0.maxweaponranks.size > 0, "<dev string:x124>" + getxhashsourcename( level.gamemodebundle.weaponlist ) + "<dev string:x153>" );
    
    if ( !isdefined( game[ #"levelcache" ] ) )
    {
        game[ #"levelcache" ] = {};
    }
    
    game[ #"levelcache" ].var_d7d85d1113d7d3d2 = level.var_d7d85d1113d7d3d2;
    game[ #"levelcache" ].var_3c549d90fbff3cd0 = level.var_3c549d90fbff3cd0;
    game[ #"levelcache" ].var_dc1abb305baf0c52 = level.var_dc1abb305baf0c52;
}

// Namespace weaponrank
// Params 1
// Checksum 0xbd45e7a1, Offset: 0x9f7
// Size: 0x58
function getplayerweaponrank( rootweapon )
{
    assert( weaponhasranks( rootweapon ) );
    weaponxp = getplayerweaponrankxp( rootweapon );
    weaponprestige = function_537a18f0105123c2( rootweapon );
    rank = getweaponrankforxp( rootweapon, weaponxp, weaponprestige );
    return rank;
}

// Namespace weaponrank
// Params 2
// Checksum 0xe3099b15, Offset: 0xa58
// Size: 0xf5
function getplayerweaponrankxp( rootweapon, type )
{
    assert( weaponshouldgetxp( rootweapon ), "<dev string:x16d>" );
    
    if ( !isdefined( type ) )
    {
        type = "all";
    }
    
    switch ( type )
    {
        case #"hash_fa24c8f6bd607cf8":
            mpxp = self getplayerdata( "common", "sharedProgression", "weaponLevel", rootweapon, "mpXP" );
            return mpxp;
        case #"hash_fa1ebcf6bd5bece6":
            cpxp = self getplayerdata( "common", "sharedProgression", "weaponLevel", rootweapon, "cpXP" );
            return cpxp;
        case #"hash_c482c6c109150a4":
            mpxp = self getplayerdata( "common", "sharedProgression", "weaponLevel", rootweapon, "mpXP" );
            cpxp = self getplayerdata( "common", "sharedProgression", "weaponLevel", rootweapon, "cpXP" );
            return ( mpxp + cpxp );
    }
}

// Namespace weaponrank
// Params 1
// Checksum 0x1c9c942a, Offset: 0xb55
// Size: 0x4a
function function_537a18f0105123c2( rootweapon )
{
    assert( weaponshouldgetxp( rootweapon ), "<dev string:x16d>" );
    prestige = self getplayerdata( "common", "sharedProgression", "weaponLevel", rootweapon, "prestige" );
    return prestige;
}

// Namespace weaponrank
// Params 1
// Checksum 0x1116daae, Offset: 0xba8
// Size: 0x79, Type: bool
function isplayerweaponatmaxxp( rootweapon )
{
    assert( weaponhasranks( rootweapon ) );
    currentxp = getplayerweaponrankxp( rootweapon );
    maxxp = getweaponmaxrankxp( rootweapon );
    maxweaponprestige = function_58b1211fcca8cea9( rootweapon );
    
    if ( maxweaponprestige > 0 )
    {
        maxxp *= maxweaponprestige;
    }
    
    var_a908114816db725b = function_dd221186b9c65113( rootweapon );
    return currentxp >= maxxp + var_a908114816db725b;
}

// Namespace weaponrank
// Params 1
// Checksum 0xf6d29e88, Offset: 0xc2a
// Size: 0x74
function weaponshouldgetxp( weapon )
{
    var_e899a72722c9f941 = getdvarint( @"hash_39c5e2e95ae3c2e6", 1 ) == 1;
    
    if ( !var_e899a72722c9f941 && self.pers[ "rank" ] < 3 && !getdvarint( @"force_challenges" ) )
    {
        return 0;
    }
    
    rootname = weapon::getweaponrootname( weapon );
    return weaponhasranks( rootname );
}

// Namespace weaponrank
// Params 1
// Checksum 0x4af317e, Offset: 0xca7
// Size: 0xbe
function weaponhasranks( rootname )
{
    if ( !isdefined( level.var_3c549d90fbff3cd0.maxweaponranks[ rootname ] ) )
    {
        return 0;
    }
    
    hasranks = level.var_3c549d90fbff3cd0.maxweaponranks[ rootname ] > 0;
    assert( !hasranks || isenumvaluevalid( "<dev string:x1af>", "<dev string:x1b6>", rootname ) || level.weaponmapdata[ rootname ].var_a1ce61685bb64675 && isenumvaluevalid( "<dev string:x1af>", "<dev string:x1b6>", level.weaponmapdata[ rootname ].var_a1ce61685bb64675 ), "<dev string:x1c4>" + rootname + "<dev string:x1c6>" );
    return hasranks;
}

// Namespace weaponrank
// Params 1
// Checksum 0xda969287, Offset: 0xd6e
// Size: 0x39
function getweaponmaxrankxp( rootweapon )
{
    assert( weaponhasranks( rootweapon ) );
    maxrank = getmaxweaponrankforrootweapon( rootweapon );
    return getweaponrankinfomaxxp( rootweapon, maxrank );
}

// Namespace weaponrank
// Params 1
// Checksum 0x97bb8fe6, Offset: 0xdb0
// Size: 0x3a, Type: bool
function function_d470ca0f7e34f679( rootweapon )
{
    weaponproject = function_30f0a3aa3c1905ea( rootweapon );
    return level.var_d7d85d1113d7d3d2[ weaponproject ].var_d52103b73d570051 ?? 0;
}

// Namespace weaponrank
// Params 1
// Checksum 0xf60bc014, Offset: 0xdf3
// Size: 0x3a, Type: bool
function function_d5b701bc5ecb8f40( rootweapon )
{
    weaponproject = function_30f0a3aa3c1905ea( rootweapon );
    return level.var_d7d85d1113d7d3d2[ weaponproject ].var_2ac50a0e4ba913c0 ?? 0;
}

// Namespace weaponrank
// Params 1
// Checksum 0xe0637d65, Offset: 0xe36
// Size: 0x36
function function_dd221186b9c65113( rootweapon )
{
    var_e3e9e55c4665e27d = function_d470ca0f7e34f679( rootweapon );
    var_52ee9cac2b1371f7 = function_d5b701bc5ecb8f40( rootweapon );
    return var_e3e9e55c4665e27d * var_52ee9cac2b1371f7;
}

// Namespace weaponrank
// Params 3
// Checksum 0x92a69ffd, Offset: 0xe75
// Size: 0x158
function getweaponrankforxp( rootweapon, xpval, prestige )
{
    if ( xpval == 0 )
    {
        return 0;
    }
    
    var_fbca620bb9b3e67 = getmaxweaponrankforrootweapon( rootweapon ) - 1;
    maxrankxp = getweaponrankinfominxp( rootweapon, var_fbca620bb9b3e67 );
    var_665da3b1829660cd = function_58b1211fcca8cea9( rootweapon );
    var_26023108040f1d01 = function_d5b701bc5ecb8f40( rootweapon );
    
    if ( isdefined( prestige ) )
    {
        if ( prestige > 0 )
        {
            xpval -= prestige * maxrankxp;
        }
    }
    else
    {
        prestige = 0;
        
        while ( xpval > maxrankxp && prestige < var_665da3b1829660cd )
        {
            xpval -= maxrankxp;
            prestige += 1;
        }
    }
    
    for ( rankid = var_fbca620bb9b3e67; rankid >= 0 ; rankid-- )
    {
        if ( xpval >= getweaponrankinfominxp( rootweapon, rankid ) )
        {
            if ( var_fbca620bb9b3e67 == rankid && prestige == var_665da3b1829660cd && var_26023108040f1d01 > 0 )
            {
                xpval -= maxrankxp;
                var_384cf7750a017ef0 = int( xpval / var_26023108040f1d01 );
                var_80d3cb3a68e9bbdc = rankid + var_384cf7750a017ef0;
                var_e3e9e55c4665e27d = function_d470ca0f7e34f679( rootweapon );
                
                if ( var_e3e9e55c4665e27d && var_80d3cb3a68e9bbdc > var_e3e9e55c4665e27d )
                {
                    assertmsg( "<dev string:x22c>" + rootweapon + "<dev string:x250>" + var_80d3cb3a68e9bbdc );
                    var_80d3cb3a68e9bbdc = var_e3e9e55c4665e27d;
                }
                
                return var_80d3cb3a68e9bbdc;
            }
            
            return rankid;
        }
    }
    
    return rankid;
}

// Namespace weaponrank
// Params 1
// Checksum 0xe1934c10, Offset: 0xfd6
// Size: 0x36, Type: bool
function getmaxweaponrankforrootweapon( rootweapon )
{
    assert( weaponhasranks( rootweapon ) );
    return level.var_3c549d90fbff3cd0.maxweaponranks[ rootweapon ] ?? 0;
}

// Namespace weaponrank
// Params 1
// Checksum 0x8455d753, Offset: 0x1015
// Size: 0x26, Type: bool
function function_58b1211fcca8cea9( rootweapon )
{
    return level.var_3c549d90fbff3cd0.maxweaponprestige[ rootweapon ] ?? 0;
}

// Namespace weaponrank
// Params 1
// Checksum 0xa016091d, Offset: 0x1044
// Size: 0x70
function function_30f0a3aa3c1905ea( rootweapon )
{
    if ( !level.var_dc1abb305baf0c52 )
    {
        return "all";
    }
    
    weaponproject = level.var_3c549d90fbff3cd0.var_1b3b791551432906[ rootweapon ];
    
    if ( !isdefined( weaponproject ) )
    {
        assertmsg( "<dev string:x257>" + rootweapon + "<dev string:x25f>" );
        weaponproject = getarraykey( level.var_d7d85d1113d7d3d2, 0 );
    }
    
    return weaponproject;
}

// Namespace weaponrank
// Params 1
// Checksum 0x8f358f45, Offset: 0x10bd
// Size: 0x4b
function getmaxweaponrank( rootweapon )
{
    weaponproject = function_30f0a3aa3c1905ea( rootweapon );
    assert( isdefined( level.var_d7d85d1113d7d3d2[ weaponproject ] ) );
    return level.var_d7d85d1113d7d3d2[ weaponproject ].maxrank;
}

// Namespace weaponrank
// Params 2
// Checksum 0x74b1b355, Offset: 0x1111
// Size: 0x60
function getweaponrankinfominxp( rootweapon, rankid )
{
    weaponproject = function_30f0a3aa3c1905ea( rootweapon );
    assert( isdefined( level.var_d7d85d1113d7d3d2[ weaponproject ] ) );
    return level.var_d7d85d1113d7d3d2[ weaponproject ].rankinfo[ rankid ].minxp;
}

// Namespace weaponrank
// Params 2
// Checksum 0xd8812e26, Offset: 0x117a
// Size: 0x60
function getweaponrankinfoxptonextrank( rootweapon, rankid )
{
    weaponproject = function_30f0a3aa3c1905ea( rootweapon );
    assert( isdefined( level.var_d7d85d1113d7d3d2[ weaponproject ] ) );
    return level.var_d7d85d1113d7d3d2[ weaponproject ].rankinfo[ rankid ].xptonextrank;
}

// Namespace weaponrank
// Params 2
// Checksum 0x74b1b355, Offset: 0x11e3
// Size: 0x60
function getweaponrankinfomaxxp( rootweapon, rankid )
{
    weaponproject = function_30f0a3aa3c1905ea( rootweapon );
    assert( isdefined( level.var_d7d85d1113d7d3d2[ weaponproject ] ) );
    return level.var_d7d85d1113d7d3d2[ weaponproject ].rankinfo[ rankid ].maxxp;
}

// Namespace weaponrank
// Params 1
// Checksum 0xc140d45a, Offset: 0x124c
// Size: 0x44
function remapscoreeventforweapon( event )
{
    switch ( event )
    {
        case #"hash_611825599f1b56f9":
            event = "kill_weapon";
            break;
        case #"hash_5b8ea26626b7f31e":
            event = "weapon_challenge";
            break;
    }
    
    return event;
}

// Namespace weaponrank
// Params 2
// Checksum 0xb968d498, Offset: 0x1299
// Size: 0x20
function addglobalweaponrankxpmultiplier( multiplier, ref )
{
    level addweaponrankxpmultiplier( multiplier, ref );
}

// Namespace weaponrank
// Params 0
// Checksum 0xce1c47b8, Offset: 0x12c1
// Size: 0x9
function getglobalweaponrankxpmultiplier()
{
    return level getweaponrankxpmultiplier();
}

// Namespace weaponrank
// Params 0
// Checksum 0xd4381b27, Offset: 0x12d3
// Size: 0x7, Type: bool
function getplatformweaponrankxpmultiplier()
{
    return true;
}

// Namespace weaponrank
// Params 1
// Checksum 0x3e4d3847, Offset: 0x12e3
// Size: 0x85
function function_48fb6ab05088b01f( objweapon )
{
    if ( !level.activearmoryenabled )
    {
        return 1;
    }
    
    if ( !isdefined( objweapon ) )
    {
        return 1;
    }
    
    rootweapon = weapon::getweaponrootname( objweapon );
    
    if ( isdefined( rootweapon ) && isdefined( level.weaponmapdata[ rootweapon ] ) && level.weaponmapdata[ rootweapon ].activearmoryenabled )
    {
        return ( 1 + level.var_c772be8094b38181 );
    }
    
    return 1;
}

// Namespace weaponrank
// Params 2
// Checksum 0xd970e520, Offset: 0x1371
// Size: 0x6a
function addweaponrankxpmultiplier( multiplier, ref )
{
    if ( !isdefined( self.weaponrankxpmultipliers ) )
    {
        self.weaponrankxpmultipliers = [];
    }
    
    if ( isdefined( self.weaponrankxpmultipliers[ ref ] ) )
    {
        self.weaponrankxpmultipliers[ ref ] = max( self.weaponrankxpmultipliers[ ref ], multiplier );
        return;
    }
    
    self.weaponrankxpmultipliers[ ref ] = multiplier;
}

// Namespace weaponrank
// Params 1
// Checksum 0xfe408843, Offset: 0x13e3
// Size: 0x20, Type: bool
function function_812f8acae19b656a( ref )
{
    return self.weaponrankxpmultipliers[ ref ] ?? 1;
}

// Namespace weaponrank
// Params 0
// Checksum 0xdd85fc30, Offset: 0x140c
// Size: 0xbe
function getweaponrankxpmultiplier()
{
    modifiertotal = 1;
    
    if ( isarray( self.weaponrankxpmultipliers ) )
    {
        foreach ( modifier in self.weaponrankxpmultipliers )
        {
            if ( !isdefined( modifier ) )
            {
                continue;
            }
            
            modifiertotal *= modifier;
        }
    }
    
    if ( isdefined( self.var_cbb73538dc6fd584 ) )
    {
        modifiertotal *= self.var_cbb73538dc6fd584;
    }
    
    return modifiertotal;
}

// Namespace weaponrank
// Params 1
// Checksum 0xf04127b7, Offset: 0x14d3
// Size: 0x16
function removeglobalweaponrankxpmultiplier( ref )
{
    level removeweaponrankxpmultiplier( ref );
}

// Namespace weaponrank
// Params 1
// Checksum 0x3264c65a, Offset: 0x14f1
// Size: 0x65
function removeweaponrankxpmultiplier( ref )
{
    if ( !isdefined( self.weaponrankxpmultipliers ) )
    {
        assertmsg( "<dev string:x2a9>" + ref + "<dev string:x2d5>" );
        return;
    }
    
    if ( !isdefined( self.weaponrankxpmultipliers[ ref ] ) )
    {
        assertmsg( "<dev string:x2a9>" + ref + "<dev string:x2fd>" );
        return;
    }
    
    self.rankxpmultipliers[ ref ] = undefined;
}

// Namespace weaponrank
// Params 1
// Checksum 0x65eda280, Offset: 0x155e
// Size: 0x5a
function getweaponrankxpmultipliertotal( objweapon )
{
    playermodifier = getweaponrankxpmultiplier();
    globalmodifier = getglobalweaponrankxpmultiplier();
    platformmodifier = getplatformweaponrankxpmultiplier();
    var_8a93663eb67f017b = function_48fb6ab05088b01f( objweapon );
    return playermodifier * globalmodifier * platformmodifier * var_8a93663eb67f017b;
}

// Namespace weaponrank
// Params 0
// Checksum 0x903f043c, Offset: 0x15c1
// Size: 0x23d
function getgametypeweaponxpmultiplier()
{
    var_1c85e92165640b45 = dvars::function_80a5871795f1cd82( "weapon_xp_scalar_override", 0 );
    
    if ( var_1c85e92165640b45 > 0 )
    {
        return var_1c85e92165640b45;
    }
    
    mapoverrides = level.gametypebundle.mapoverrides;
    
    if ( mapoverrides.size )
    {
        var_2fdeeb266e218e37 = getxhashasset( level.mapname );
        
        foreach ( override in mapoverrides )
        {
            if ( override.map == var_2fdeeb266e218e37 && isdefined( override.weaponxpscale ) && override.weaponxpscale != 1 )
            {
                return override.weaponxpscale;
            }
        }
    }
    
    mapsizeoverrides = level.gametypebundle.mapsizeoverrides;
    mapinfobundle = level.mapinfobundle;
    
    if ( mapsizeoverrides.size > 0 && isdefined( mapinfobundle.xpscalemapsize ) && mapinfobundle.xpscalemapsize != #"hash_9bfbc4397583e387" )
    {
        xpscalemapsize = mapinfobundle.xpscalemapsize;
        
        foreach ( override in mapsizeoverrides )
        {
            if ( override.xpscalemapsize == xpscalemapsize && isdefined( override.weaponxpscale ) && override.weaponxpscale != 1 )
            {
                return override.weaponxpscale;
            }
        }
    }
    
    return level.gametypebundle.var_ed58346ebaf593ae ?? 1;
}

// Namespace weaponrank
// Params 0
// Checksum 0x6dc500b8, Offset: 0x1807
// Size: 0x19, Type: bool
function getgametypekillsperhouravg()
{
    return level.gametypebundle.var_db4f76e2f612b980 ?? 0;
}

// Namespace weaponrank
// Params 0
// Checksum 0xe3d2230d, Offset: 0x1829
// Size: 0x6f
function getgametypekillspermatchmaximum()
{
    if ( !isdefined( level.gametypekillspermatchmax ) )
    {
        timelimit = game_utility_mp::function_82e3606d184524fe() ?? 0;
        winlimit = dvars::function_13909a5327c395b9( "winlimit" );
        
        if ( winlimit > 0 )
        {
            timelimit *= winlimit * 2 - 1;
        }
        
        level.gametypekillspermatchmax = getgametypekillsperhouravg() / 60 * timelimit / 60;
    }
    
    return level.gametypekillspermatchmax;
}

