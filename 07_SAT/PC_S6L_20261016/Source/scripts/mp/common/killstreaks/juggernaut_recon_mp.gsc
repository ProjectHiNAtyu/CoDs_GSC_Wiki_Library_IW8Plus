// scripts\mp\common\killstreaks\juggernaut_recon_mp.gsc  (hash_3a0b90603da96248.gscc) (size: 3058 Bytes / 0xbf2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe5d370a0 (3855839392)
// size ...... 3058 (0xbf2)
// includes .. 6   (offset: 0xb6e)
// strings ... 4   (offset: 0xb9e)
// dev strs .. 2   (offset: 0xbda)
// exports ... 15  (offset: 0x53a)
// cseg ...... 0x8a + 0x4b0 (0x53a)
// imports ... 33  (offset: 0x792)
// animtree1 . 0   (offset: 0xbf2)
// animtree2 . 0   (offset: 0xbf2)
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\juggernaut;
#using scripts\mp\weapons;

#namespace juggernaut_recon_mp;

// Namespace juggernaut_recon_mp
// Params 0, eflags: 0x1
// Checksum 0x3f0c82c, Offset: 0xa8
// Size: 0x1c
function autoexec main()
{
    utility::registersharedfunc( "juggernaut_recon", #"init", &init );
}

// Namespace juggernaut_recon_mp
// Params 0
// Checksum 0x54263e53, Offset: 0xcc
// Size: 0x1a6
function init()
{
    utility::registersharedfunc( #"juggernaut_recon", #"initconfig", &function_fe7bf4c56a0b8f53 );
    utility::registersharedfunc( #"juggernaut_recon", #"leveldata", &juggernaut_recon_leveldata );
    utility::registersharedfunc( #"juggernaut_recon", #"registeractionset", &juggernaut_recon_registeractionset );
    utility::registersharedfunc( #"juggernaut_recon", #"dropcratefromscriptedheli", &function_3daa4d55fdb3addb );
    utility::registersharedfunc( #"juggernaut_recon", #"makejuggernaut", &function_d41855cecb9243be );
    utility::registersharedfunc( #"juggernaut_recon", #"hash_49dedbde91ce22a4", &juggernaut_recon_watchpickup );
    utility::registersharedfunc( #"juggernaut_recon", #"getmovespeedscalar", &juggernaut_recon_getmovespeedscalar );
    utility::registersharedfunc( #"juggernaut_recon", #"updatemovespeedscale", &juggernaut_recon_updatemovespeedscale );
    utility::registersharedfunc( #"juggernaut_recon", #"allowactionset", &juggernaut_recon_allowactionset );
    utility::registersharedfunc( #"juggernaut_recon", #"decrementfauxvehiclecount", &juggernaut_recon_decrementfauxvehiclecount );
    utility::registersharedfunc( #"juggernaut_recon", #"incrementfauxvehiclecount", &juggernaut_recon_incrementfauxvehiclecount );
    utility::registersharedfunc( #"juggernaut_recon", #"hash_fd6ae1315c480eef", &function_c778bd3581a66edd );
    utility::registersharedfunc( #"juggernaut_recon", #"canreload", &juggernaut::jugg_canreload );
    utility::registersharedfunc( #"juggernaut_recon", #"canUseWeaponPickups", &juggernaut::jugg_canuseweaponpickups );
}

// Namespace juggernaut_recon_mp
// Params 0
// Checksum 0xca5c9ef0, Offset: 0x27a
// Size: 0x21
function juggernaut_recon_registeractionset()
{
    val::group_register( "fakeJugg", [ "slide", "prone" ] );
}

// Namespace juggernaut_recon_mp
// Params 8
// Checksum 0x1ae778e7, Offset: 0x2a3
// Size: 0x5c
function function_3daa4d55fdb3addb( owner, team, cratetype, position, angles, destination, data, streakinfo )
{
    return airdrop::dropcratefromscriptedheli( owner, team, cratetype, position, angles, destination, data, streakinfo );
}

// Namespace juggernaut_recon_mp
// Params 2
// Checksum 0x89ce3966, Offset: 0x308
// Size: 0x44, Type: bool
function function_d41855cecb9243be( config, streakinfo )
{
    bundle = level.streakglobals.streakbundles[ "juggernaut_recon" ];
    return juggernaut::jugg_makejuggernaut( config, streakinfo, bundle );
}

// Namespace juggernaut_recon_mp
// Params 0
// Checksum 0x3f69f740, Offset: 0x355
// Size: 0x50
function function_fe7bf4c56a0b8f53()
{
    bundle = level.streakglobals.streakbundles[ "juggernaut_recon" ];
    assert( bundle.juggernautconfig, "<dev string:x24>" );
    return juggernaut::jugg_createconfig( bundle.juggernautconfig );
}

// Namespace juggernaut_recon_mp
// Params 1
// Checksum 0x142d489a, Offset: 0x3ae
// Size: 0x14
function juggernaut_recon_leveldata( ref )
{
    return airdrop::getleveldata( ref );
}

// Namespace juggernaut_recon_mp
// Params 1
// Checksum 0x8c3a1f3d, Offset: 0x3cb
// Size: 0x15
function juggernaut_recon_watchpickup( droppingplayer )
{
    thread weapons::watchpickup( droppingplayer );
}

// Namespace juggernaut_recon_mp
// Params 0
// Checksum 0x4911df4b, Offset: 0x3e8
// Size: 0x63
function juggernaut_recon_getmovespeedscalar()
{
    bundle = level.streakglobals.streakbundles[ "juggernaut_recon" ];
    assert( bundle.juggernautconfig, "<dev string:x7a>" );
    var_52603d9eb229bc67 = getscriptbundle( bundle.juggernautconfig );
    return var_52603d9eb229bc67.movespeedscalar;
}

// Namespace juggernaut_recon_mp
// Params 0
// Checksum 0xa076ac7c, Offset: 0x454
// Size: 0x9
function juggernaut_recon_updatemovespeedscale()
{
    weapons::updatemovespeedscale();
}

// Namespace juggernaut_recon_mp
// Params 2
// Checksum 0x8ba5e2fe, Offset: 0x465
// Size: 0x1f
function juggernaut_recon_allowactionset( name, allow )
{
    val::group_set( name, allow );
}

// Namespace juggernaut_recon_mp
// Params 0
// Checksum 0xf89efbce, Offset: 0x48c
// Size: 0x9
function juggernaut_recon_decrementfauxvehiclecount()
{
    killstreak::decrementfauxvehiclecount();
}

// Namespace juggernaut_recon_mp
// Params 0
// Checksum 0xf89efbce, Offset: 0x49d
// Size: 0x9
function juggernaut_recon_incrementfauxvehiclecount()
{
    killstreak::incrementfauxvehiclecount();
}

// Namespace juggernaut_recon_mp
// Params 1
// Checksum 0xa9f9b701, Offset: 0x4ae
// Size: 0x8b, Type: bool
function function_c778bd3581a66edd( streakinfo )
{
    if ( getdvarint( @"hash_e33f3513a88f530c", 0 ) )
    {
        return true;
    }
    
    if ( killstreak::currentactivevehiclecount() >= killstreak::maxvehiclesallowed() || level.fauxvehiclecount + 1 >= killstreak::maxvehiclesallowed() )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"KILLSTREAKS/TOO_MANY_VEHICLES" );
        }
        
        return false;
    }
    
    return true;
}

