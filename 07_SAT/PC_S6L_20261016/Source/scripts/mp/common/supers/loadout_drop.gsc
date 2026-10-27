// scripts\mp\common\supers\loadout_drop.gsc  (hash_5a2c903ccc17b2ad.gscc) (size: 2107 Bytes / 0x83b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x787be0ee (2021384430)
// size ...... 2107 (0x83b)
// includes .. 12  (offset: 0x76f)
// strings ... 8   (offset: 0x7cf)
// dev strs .. 0   (offset: 0x83b)
// exports ... 6   (offset: 0x417)
// cseg ...... 0xf6 + 0x321 (0x417)
// imports ... 21  (offset: 0x507)
// animtree1 . 0   (offset: 0x83b)
// animtree2 . 0   (offset: 0x83b)
#using scripts\common\ae_utility;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_tracking;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\challenges;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\scripted_weapons;
#using scripts\mp\supers;
#using scripts\mp\weapons;

#namespace loadout_drop;

// Namespace loadout_drop
// Params 0, eflags: 0x1
// Checksum 0x9019d67b, Offset: 0x114
// Size: 0x9
function autoexec main()
{
    loadoutdrop_init();
}

// Namespace loadout_drop
// Params 0
// Checksum 0x29ee84c6, Offset: 0x125
// Size: 0x43
function loadoutdrop_init()
{
    utility::flag_wait( "supers_initialized" );
    level.loadoutdropenabled = 1;
    weapons::registerusedcallback( "deploy_loadout_drop", &loadoutdrop_used );
    supers_mp::function_48aaa60b2ce7b8a1( "super_loadout_drop", undefined, undefined, &loadoutdrop_beginsuper, undefined, undefined, undefined, undefined, undefined, undefined );
}

// Namespace loadout_drop
// Params 0
// Checksum 0x88f9c611, Offset: 0x170
// Size: 0xb, Type: bool
function loadoutdrop_beginsuper()
{
    thread loadoutdrop_givedropweapon();
    return true;
}

// Namespace loadout_drop
// Params 0
// Checksum 0xd88fc1af, Offset: 0x184
// Size: 0x1a9
function loadoutdrop_givedropweapon()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    waitframe();
    streakinfo = killstreak_utility::createstreakinfo( "loadout_drop", self );
    streakinfo.deployweaponobj = scripted_weapons::get_scripted_weapon_object( #"deploy_loadout_drop" );
    
    if ( isdefined( level.var_d6dbcfd3322e6005 ) )
    {
        streakinfo.var_21f1b0b4d8d3ea8f = level.var_d6dbcfd3322e6005;
    }
    
    val::set( "giveDropWeapon", "killstreaks", 0 );
    deployresult = killstreakdeploy::streakdeploy_doweaponfireddeploy( streakinfo, streakinfo.deployweaponobj, "grenade_fire" );
    val::reset_all( "giveDropWeapon" );
    
    if ( deployresult )
    {
        streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
        battlechatter_mp::playkillstreakdeploydialog( streakinfo.streakname );
        
        if ( utility::issharedfuncdefined( #"supers", #"superusefinished" ) )
        {
            [[ utility::getsharedfunc( #"supers", #"superusefinished" ) ]]();
            challenges::function_a0936b0e5b4550f3( "super_loadout_drop", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"use" ) );
        }
        
        return;
    }
    
    if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
    {
        self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"MP/CANNOT_USE_GENERIC" );
    }
    
    if ( utility::issharedfuncdefined( #"supers", #"superusefinished" ) )
    {
        [[ utility::getsharedfunc( #"supers", #"superusefinished" ) ]]( 1 );
    }
}

// Namespace loadout_drop
// Params 1
// Checksum 0x855e7a22, Offset: 0x335
// Size: 0xe1, Type: bool
function loadoutdrop_used( grenade )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    streakinfo = killstreak_utility::createstreakinfo( "loadout_drop", self );
    deployweapon = utility::get_scripted_weapon_name( #"deploy_loadout_drop" ) ?? "deploy_loadout_drop_mp";
    streakinfo.deployweaponobj = makeweapon( deployweapon );
    
    if ( !vehicle_tracking::reserve_vehicle() || !level.loadoutdropenabled )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"KILLSTREAKS/AIR_SPACE_TOO_CROWDED" );
        }
        
        return false;
    }
    
    thread airdrop::airdropmarkerfired( streakinfo, streakinfo.deployweaponobj, grenade );
    return true;
}

