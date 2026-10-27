// scripts\mp\weapons.gsc  (hash_64d6db6054238125.gscc) (size: 120990 Bytes / 0x1d89e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9a458eb7 (2588249783)
// size ...... 120990 (0x1d89e)
// includes .. 82  (offset: 0x1c132)
// strings ... 287 (offset: 0x1c3c2)
// dev strs .. 49  (offset: 0x1d62e)
// exports ... 306 (offset: 0x1319e)
// cseg ...... 0x18cc + 0x118d2 (0x1319e)
// imports ... 751 (offset: 0x1616e)
// animtree1 . 0   (offset: 0x1d89e)
// animtree2 . 0   (offset: 0x1d89e)
#using script_13865ca76df87ea;
#using script_3e14de319bce19ea;
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\equipment_common;
#using scripts\common\game_utility;
#using scripts\common\missilelauncher;
#using scripts\common\script;
#using scripts\common\shellshock_utility;
#using scripts\common\telemetry_utils;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_tracking;
#using scripts\common\weapon;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\challenges;
#using scripts\mp\class;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\common\equipment\advanced_supply_drop;
#using scripts\mp\common\equipment\bunkerbuster;
#using scripts\mp\common\equipment\mini_missile;
#using scripts\mp\common\equipment\weapon_drop;
#using scripts\mp\common\killstreaks\juggernaut;
#using scripts\mp\common\perks\perkfunctions;
#using scripts\mp\common\supers\vehicle_drop;
#using scripts\mp\common\utility\callback_group;
#using scripts\mp\common\utility\damage;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\entity;
#using scripts\mp\common\utility\equipment_utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\usability;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\common\weapons\drone_launcher;
#using scripts\mp\crossbow;
#using scripts\mp\damagefeedback;
#using scripts\mp\ent_manager;
#using scripts\mp\entityheadicons;
#using scripts\mp\equipment;
#using scripts\mp\events;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gameplay_telemetry;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\war;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\javelin;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\movers;
#using scripts\mp\mtx_weapon;
#using scripts\mp\outofbounds;
#using scripts\mp\persistence;
#using scripts\mp\playerstats_interface;
#using scripts\mp\potg_events;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\shellshock;
#using scripts\mp\stamina;
#using scripts\mp\supers;
#using scripts\mp\talking_gun;
#using scripts\mp\weapons_dev;

#namespace weapons;

// Namespace weapons
// Params 1
// Checksum 0x559499b6, Offset: 0x18ea
// Size: 0x1b
function attachmentgroup( attachmentname )
{
    return tablelookup( "mp/attachmenttable.csv", 4, attachmentname, 2 );
}

// Namespace weapons
// Params 0
// Checksum 0xf75e12dc, Offset: 0x190e
// Size: 0x2e
function function_2d7d4a0c3b3e066c()
{
    if ( !isdefined( level.var_5c7f9525696adf93 ) )
    {
        level.var_5c7f9525696adf93 = [];
    }
    
    if ( !isdefined( level.var_f0d83b0ef733dfbf ) )
    {
        level.var_f0d83b0ef733dfbf = [];
    }
}

// Namespace weapons
// Params 0
// Checksum 0xdc14dca1, Offset: 0x1944
// Size: 0x54b
function init()
{
    level.var_d05f91bb4bf281d9 = 0;
    
    if ( !isdefined( level.var_43ea0dc79d4f6473 ) )
    {
        level.var_43ea0dc79d4f6473 = [];
    }
    
    if ( !isdefined( level.var_45a830706d2e9574 ) )
    {
        level.var_45a830706d2e9574 = [];
    }
    
    level.scavenger_altmode = 1;
    level.scavenger_secondary = 1;
    
    if ( !isdefined( level.blockweapondrops ) )
    {
        level.blockweapondrops = getmatchrulesdata( "commonOption", "blockWeaponEntityDrops" );
    }
    
    if ( !isdefined( level.var_fe0e5f06ec7d82bf ) )
    {
        level.var_fe0e5f06ec7d82bf = getmatchrulesdata( "commonOption", "blockBRWeaponEntityDrops" );
    }
    
    level.maxperplayerexplosives = max( dvars::getintproperty( @"scr_maxperplayerexplosives", 2 ), 1 );
    level.riotshieldxpbullets = dvars::getintproperty( @"scr_riotshieldxpbullets", 15 );
    weapondeletedist = getdvarint( @"scr_weapondeletedist", 96 );
    level.weapondeletedistsq = weapondeletedist * weapondeletedist;
    level.var_b98cf52a78774e58 = getdvarint( @"hash_6985738ed49f9de5", 0 );
    
    switch ( dvars::getintproperty( @"perk_scavengermode", 0 ) )
    {
        case 1:
            level.scavenger_altmode = 0;
            break;
        case 2:
            level.scavenger_secondary = 0;
            break;
        case 3:
            level.scavenger_altmode = 0;
            level.scavenger_secondary = 0;
            break;
    }
    
    if ( getbuildversion() != "SHIP" )
    {
        weapons_dev::weapdev_init();
    }
    
    level._effect[ "emp_stun" ] = loadfxasset( "vfx_core_mp_equip_emp_grenade" );
    level._effect[ "equipment_explode" ] = loadfxasset( "vfx_iw7_requests_mp_generic_equip_explo" );
    level._effect[ "equipment_smoke" ] = loadfxasset( "vfx_core_mp_strk_sg_damage_blacksmoke" );
    level._effect[ "equipment_sparks" ] = loadfxasset( "vfx_core_mp_strk_sentry_gun_explo" );
    level._effect[ "glsmoke" ] = loadfxasset( "vfx_iw8_mp_equip_smoke_grenade_gren_ch" );
    level._effect[ "xmike109ThermiteBounce" ] = loadfxasset( "vfx_iw8_mp_equip_xmike109_thermite_bounce" );
    level._effect[ "vfx_snap_gren_pulse" ] = loadfxasset( "vfx_core_equip_snap_gren_pulse" );
    
    if ( !isdefined( level.var_44cdf5fee6853ac5 ) )
    {
        level.var_44cdf5fee6853ac5 = [];
    }
    
    level.var_44cdf5fee6853ac5[ level.var_44cdf5fee6853ac5.size ] = #"hash_ce1e1c4b483183ee";
    
    if ( !isdefined( level.var_44cdf5fee6853ac5 ) )
    {
        level.var_44cdf5fee6853ac5 = [];
    }
    
    level.var_44cdf5fee6853ac5[ level.var_44cdf5fee6853ac5.size ] = #"sat_sl_crossbow_mp";
    
    if ( !isdefined( level.var_44cdf5fee6853ac5 ) )
    {
        level.var_44cdf5fee6853ac5 = [];
    }
    
    level.var_44cdf5fee6853ac5[ level.var_44cdf5fee6853ac5.size ] = #"sat_ar_falcon_mp";
    
    if ( !isdefined( level.var_44cdf5fee6853ac5 ) )
    {
        level.var_44cdf5fee6853ac5 = [];
    }
    
    level.var_44cdf5fee6853ac5[ level.var_44cdf5fee6853ac5.size ] = #"sat_sl_sargas_mp";
    entity::placeequipmentfailedinit();
    level.weaponconfigs = [];
    
    if ( !isdefined( level.weapondropfunction ) )
    {
        level.weapondropfunction = &dropweaponfordeath;
    }
    
    var_7a1ce3345ada882e = 25;
    level.sticky_minedetectiondot = cos( var_7a1ce3345ada882e );
    level.sticky_minedetectionmindist = 15;
    level.sticky_minedetectiongraceperiod = 0.35;
    level.sticky_minedetonateradius = 256;
    level.minedetectiongraceperiod = 0.3;
    level.primary_weapon_array = [];
    level.side_arm_array = [];
    level.grenade_array = [];
    level.missile_array = [];
    level.inventory_array = [];
    callback::add( #"player_spawned", &onplayerspawned );
    callback::add( #"player_death", &onplayerdeath );
    callback::add( #"player_laststand_exit", &function_c614aaeb1d4d8bc6 );
    callback::add( #"hash_edf8432901e795b", &function_aa43500709df6ef2 );
    callback::add( #"hash_92ba82e85aebcd61", &function_62b79abda49d3731 );
    level thread onplayerconnect();
    outline::initoutlineoccluders();
    init_function_refs();
    function_2d7d4a0c3b3e066c();
    level.onweapondropcreated = callback_group::callback_create();
    level.onweapondroppickedup = callback_group::callback_create();
    level.var_2b4420abc0ce551c = throttle::throttle_initialize( "DroneLauncher", 10, level.framedurationseconds, 50 );
    level.weaponnone = makeweapon( "none" );
    function_8f294795729e4b0();
    
    if ( getdvarint( @"perk_graverobber_enabled" ) == 1 )
    {
        level thread savegraverobberammo();
    }
    
    /#
        setdevdvar( @"hash_10368af4dee3ba2c", 0 );
        setdevdvarifuninitialized( @"hash_eb7d16d9fa10a208", 1225000000 );
    #/
    
    level.gamemodebundle.gunshieldenabled = level.gamemodebundle.gunshieldenabled && !function_4042d2fbe6237835( #"hash_3d32c35e8ac8445e" );
    utility::registersharedfunc( #"weapons", #"hash_4ccf3b3fcf5ae366", &function_4512b7715789e4cf );
    utility::registersharedfunc( #"weapons", #"updatemovespeedscale", &updatemovespeedscale );
}

// Namespace weapons
// Params 0
// Checksum 0xca0544ec, Offset: 0x1e97
// Size: 0x3a9
function function_8f294795729e4b0()
{
    overridevalues = istrue( level.gametypebundle.var_522fda318743931a );
    level.shotgunsettings = {};
    level.shotgunsettings.maxdamage = overridevalues ? level.gametypebundle.shotgunoverrides.maxdamage : 200;
    level.shotgunsettings.maxdamagefast = overridevalues ? level.gametypebundle.shotgunoverrides.maxdamagefast : 120;
    level.shotgunsettings.var_e2d6f278a43050bd = overridevalues ? level.gametypebundle.shotgunoverrides.var_e2d6f278a43050bd : 300;
    level.shotgunsettings.var_bd28e04a5ae50091 = overridevalues ? level.gametypebundle.shotgunoverrides.var_bd28e04a5ae50091 : 20;
    level.shotgunsettings.var_b0a6ec759ea967db = overridevalues ? level.gametypebundle.shotgunoverrides.var_b0a6ec759ea967db : 4;
    level.shotgunsettings.var_2f74da3d7b6984ef = overridevalues ? level.gametypebundle.shotgunoverrides.var_3aad247df9640df3 : 2;
    level.shotgunsettings.var_e7ad8546bc2aa446 = overridevalues ? level.gametypebundle.shotgunoverrides.var_116f55d8852120c2 : 2;
    level.shotgunsettings.var_7fffe485f8d41378 = overridevalues ? level.gametypebundle.shotgunoverrides.var_b4991abbbfedd426 : 4;
    level.shotgunsettings.var_ffd662859bc49103 = overridevalues ? level.gametypebundle.shotgunoverrides.var_2babe1b770186da7 : 3;
    level.shotgunsettings.var_4a2f2b202a6e379 = overridevalues && level.gametypebundle.shotgunoverrides.var_d20d808529da7b3e;
    
    if ( level.shotgunsettings.var_4a2f2b202a6e379 && isdefined( level.gametypebundle.shotgunoverrides.var_12c55c68b6495e0 ) )
    {
        var_297efaef311f0361 = [];
        
        foreach ( shex in level.gametypebundle.shotgunoverrides.var_12c55c68b6495e0 )
        {
            var_297efaef311f0361[ shex.weapon ] = shex.var_b88e186fd6433d43;
        }
        
        level.shotgunsettings.var_377891bb83de6bbb = var_297efaef311f0361;
    }
    
    level.shotgunsettings.var_ef779d3586800fe = overridevalues ? level.gametypebundle.shotgunoverrides.var_ef779d3586800fe : 0.1;
}

// Namespace weapons
// Params 0
// Checksum 0x7005650e, Offset: 0x2248
// Size: 0x288
function savegraverobberammo()
{
    while ( true )
    {
        if ( isdefined( level.players ) )
        {
            foreach ( player in level.players )
            {
                if ( !isdefined( player ) )
                {
                    continue;
                }
                
                if ( isdefined( player.perks[ "specialty_scrap_weapons" ] ) )
                {
                    weapon = player getcurrentweapon();
                    player getcurrentweapon();
                    
                    if ( !isdefined( weapon ) )
                    {
                        continue;
                    }
                    
                    if ( !isdefined( player.graverobberammo ) )
                    {
                        player.graverobberammo = spawnstruct();
                        player.graverobberammo = spawnstruct();
                        player.graverobberammo = spawnstruct();
                    }
                    
                    if ( isdefined( player.graverobberammo.currentweapon ) && player.graverobberammo.currentweapon.weapon.basename != "none" && player.graverobberammo.currentweapon.weapon != weapon )
                    {
                        player.graverobberammo.lastweapon = player.graverobberammo.currentweapon;
                        player.graverobberammo.currentweapon = spawnstruct();
                    }
                    
                    player.graverobberammo.currentweapon = spawnstruct();
                    player.graverobberammo.currentweapon.weapon = weapon;
                    player.graverobberammo.currentweapon.rightclip = player getweaponammoclip( weapon, "right" );
                    player.graverobberammo.currentweapon.leftclip = player getweaponammoclip( weapon, "left" );
                    player.graverobberammo.currentweapon.stock = player getweaponammostock( weapon );
                    continue;
                }
                
                player.graverobberammo = undefined;
            }
        }
        
        waitframe();
    }
}

// Namespace weapons
// Params 1
// Checksum 0x60bf324c, Offset: 0x24d8
// Size: 0x14
function enablevisibilitycullingforclient( client )
{
    self hudoutlinedisableforclient( client );
}

// Namespace weapons
// Params 0
// Checksum 0x876f9019, Offset: 0x24f4
// Size: 0x58
function onplayerconnect()
{
    for ( ;; )
    {
        level waittill( #"connected", player );
        player.hits = [];
        player.agenthits = [];
        player.playerhits = [];
        gamelogic_mp::sethasdonecombat( player, 0 );
        player thread watchmissileusage();
    }
}

// Namespace weapons
// Params 0, eflags: 0xc
// Checksum 0xc156a006, Offset: 0x2554
// Size: 0xd7
function private watchchangeweapon()
{
    self notify( #"hash_283a96c1824a986e" );
    self endon( #"hash_283a96c1824a986e" );
    self endon( #"death_or_disconnect", #"joined_spectators", #"faux_spawn" );
    level endon( #"game_ended" );
    weaponcallbackparams = {};
    
    while ( true )
    {
        objweapon = self getcurrentweapon();
        
        if ( !isundefinedweapon( objweapon ) && objweapon != self.lastweaponobj )
        {
            weaponcallbackparams.lastweapon = self.lastweaponobj;
            dochangeweapon( objweapon );
            weaponcallbackparams.weapon = objweapon;
            callback::callback( #"player_weapon_change", weaponcallbackparams );
        }
        
        utility::waittill_any( "weapon_change", "pickedupweapon", "changed_kit" );
        waittillframeend();
    }
}

// Namespace weapons
// Params 1, eflags: 0x4
// Checksum 0x2ec1778a, Offset: 0x2633
// Size: 0x8d
function private dochangeweapon( objweapon )
{
    var_cbe6ee21dddcac3c = self.lastnormalweaponobj;
    logchangeweapon( objweapon );
    updateweaponspeed( objweapon );
    function_8a7193fb82f2181b();
    updatelastweaponobj( objweapon );
    savealtstates();
    function_7cc000a4d4bc9a60();
    updatelauncherusage( objweapon );
    updateweaponperks( objweapon );
    updatesniperglint( objweapon );
    stamina::onweaponchange();
    mtx_weapon::function_215f432bc7345e71( objweapon );
    events::updateweaponchangetime( objweapon, var_cbe6ee21dddcac3c );
    perkfunctions::updateweaponkick();
}

// Namespace weapons
// Params 2
// Checksum 0x6c2e50df, Offset: 0x26c8
// Size: 0xd9
function function_937faff615744271( objweapon, clip_percentage )
{
    var_83a8675f9e45e80d = self getcurrentweaponclipammo();
    var_da5b372f327ba5dd = self getweaponammostock( objweapon );
    clipsize = weaponclipsize( objweapon );
    
    if ( objweapon.isdualwield )
    {
        var_83a8675f9e45e80d = min( self getweaponammoclip( objweapon, "left" ), self getweaponammoclip( objweapon, "right" ) );
    }
    
    var_72d67e120021f85a = clip_percentage ? int( clipsize * clip_percentage ) : clipsize - var_83a8675f9e45e80d;
    var_e392b5f1c97d0e20 = min( var_72d67e120021f85a, clipsize - var_83a8675f9e45e80d );
    var_c386183cf6f60834 = int( min( var_e392b5f1c97d0e20, var_da5b372f327ba5dd ) );
    
    if ( var_c386183cf6f60834 > 0 )
    {
        self setweaponammoclip( objweapon, var_83a8675f9e45e80d + var_c386183cf6f60834 );
        self setweaponammostock( objweapon, var_da5b372f327ba5dd - var_c386183cf6f60834 );
    }
}

// Namespace weapons
// Params 1
// Checksum 0xcd3d91d9, Offset: 0x27a9
// Size: 0x3e, Type: bool
function function_f83f305d51b08718( objweapon )
{
    rootname = weapon::function_170e300815e9c1a2( objweapon );
    
    if ( rootname == "iw8_lm_sierrax" && objweapon hasattachment( "stocksaw_sierrax" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace weapons
// Params 1, eflags: 0x4
// Checksum 0x72b43009, Offset: 0x27f0
// Size: 0x132
function private logchangeweapon( objweapon )
{
    if ( !isdefined( self.lastweaponobj ) )
    {
        return;
    }
    
    currentweaponname = objweapon.basename;
    
    if ( !isdefined( currentweaponname ) || currentweaponname == "none" )
    {
        return;
    }
    
    secondaryweaponname = "none";
    
    if ( self.equippedweapons.size > 1 )
    {
        secondaryweaponname = self.equippedweapons[ 1 ].basename;
        
        if ( secondaryweaponname == currentweaponname )
        {
            secondaryweaponname = self.equippedweapons[ 0 ].basename;
        }
    }
    
    if ( isdefined( self.primaryweaponobj ) && !( self.primaryweaponobj === self.var_709577f800a50e3b ) )
    {
        self setclientweaponinfo( 0, getcompleteweaponname( self.primaryweaponobj ) );
        self.var_709577f800a50e3b = self.primaryweaponobj;
    }
    
    if ( isdefined( self.secondaryweaponobj ) && !( self.secondaryweaponobj === self.var_d0dcd97d91a4a748 ) )
    {
        self setclientweaponinfo( 1, getcompleteweaponname( self.secondaryweaponobj ) );
        self.var_d0dcd97d91a4a748 = self.secondaryweaponobj;
    }
}

// Namespace weapons
// Params 1, eflags: 0x4
// Checksum 0x195c3a88, Offset: 0x292a
// Size: 0x26
function private updateweaponperks( currentweaponobj )
{
    self.prevweaponobj = doweaponperkupdate( self.prevweaponobj, currentweaponobj );
}

// Namespace weapons
// Params 1, eflags: 0x4
// Checksum 0x35226027, Offset: 0x2958
// Size: 0x20
function private updatesniperglint( objweapon )
{
    if ( sniperglint_supported( objweapon ) )
    {
        childthread sniperglint_manage( objweapon );
    }
}

// Namespace weapons
// Params 1
// Checksum 0xca84e6d8, Offset: 0x2980
// Size: 0x341
function updatelauncherusage( weapon )
{
    var_1157c57f8da8f90d = isdefined( game[ "inLiveLobby" ] );
    
    if ( !var_1157c57f8da8f90d && !flags::gameflag( "prematch_done" ) && weapon_utility::islockonlauncher( weapon ) )
    {
        val::set( "prematch", "ads", 0 );
    }
    else
    {
        val::reset( "prematch", "ads" );
    }
    
    switch ( weapon.var_1616e6fbba9a722d )
    {
        default:
            rootname = weapon::function_170e300815e9c1a2( weapon );
            
            for ( i = 0; i < level.var_5c7f9525696adf93.size ; i++ )
            {
                usagefunc = level.var_5c7f9525696adf93[ i ];
                self [[ usagefunc ]]( rootname );
            }
            
            break;
        case %"hash_3cbf2f62e249c164":
            if ( !weapon hasattachment( "rex_rec_rpapa8_lockon" ) )
            {
                break;
            }
        case %"t10_la_p18_stisaac":
        case %"iw9_la_gromeo":
        case %"sat_la_fang":
        case %"rex_la_gromeo":
        case %"t10_ks_m202":
            thread missilelauncher::initmissilelauncherusage();
            break;
        case %"rex_la_juliet":
        case %"iw9_la_juliet":
            thread javelin::javelin_reset();
            break;
        case %"hash_1ecced4654d496da":
        case %"iw9_dm_crossbow":
            thread crossbow::initcrossbowusage();
            break;
    }
    
    self notify( #"end_launcher" );
    
    if ( isdefined( self.perks[ "specialty_fastreload_launchers" ] ) )
    {
        islauncher = weaponclass( weapon.basename ) == "rocketlauncher" || weapon.basename == "iw8_la_kgolf_mp";
        
        if ( islauncher && !self.fastreloadlaunchers )
        {
            perk::giveperk( "specialty_fastreload" );
            self.fastreloadlaunchers = 1;
        }
        else if ( self.fastreloadlaunchers )
        {
            perk::removeperk( "specialty_fastreload" );
            self.fastreloadlaunchers = undefined;
        }
    }
    
    switch ( weapon.basenamehash )
    {
        default:
            for ( i = 0; i < level.var_f0d83b0ef733dfbf.size ; i++ )
            {
                usagefunc = level.var_f0d83b0ef733dfbf[ i ];
                self [[ usagefunc ]]( weapon.basename );
            }
            
            break;
        case %"hash_69ff06249cfcdedc":
            if ( !weapon hasattachment( "rex_rec_rpapa8_lockon" ) )
            {
                break;
            }
        case %"rex_la_gromeo_mp":
        case %"sat_la_fang_mp":
        case %"iw9_la_gromeo_mp":
        case %"t10_la_p18_stisaac_mp":
        case %"t10_ks_m202":
            thread missilelauncher::missilelauncherusageloop();
            break;
        case %"zul_la_maryland_mp":
        case %"zul_la_louisiana_mp":
        case %"rex_la_juliet_mp":
        case %"iw9_la_juliet_mp":
            thread javelin::javelinusageloop();
            break;
        case %"jup_jp31_dm_compound_mp":
        case %"iw9_dm_crossbow_mp":
            thread crossbow::crossbowusageloop( weapon );
            break;
    }
}

// Namespace weapons
// Params 1
// Checksum 0x72c2ce3d, Offset: 0x2cc9
// Size: 0x31
function setlastdroppableweaponobj( weaponobj )
{
    self.lastdroppableweaponobj = weaponobj;
    
    if ( isdefined( level.lastdroppableweaponchanged ) )
    {
        self [[ level.lastdroppableweaponchanged ]]();
    }
}

// Namespace weapons
// Params 1, eflags: 0x4
// Checksum 0xecf9184f, Offset: 0x2d02
// Size: 0xa0
function private updatelastweaponobj( objnewweapon )
{
    noaltweapon = objnewweapon getnoaltweapon();
    
    if ( isnullweapon( noaltweapon ) )
    {
        noaltweapon = objnewweapon;
    }
    
    self.lastweaponobj = objnewweapon;
    
    if ( function_1b01bc71375a78f1( objnewweapon ) )
    {
        self.var_983a3526ad5f8a6a = objnewweapon;
    }
    
    if ( isnormallastweapon( objnewweapon ) )
    {
        self.lastnormalweaponobj = objnewweapon;
    }
    
    if ( isdroppableweapon( self, noaltweapon ) )
    {
        setlastdroppableweaponobj( noaltweapon );
    }
    
    weapongroup = weapon::function_820c0dca2415bd8( objnewweapon );
    
    if ( weapon::iscacprimaryorsecondary( objnewweapon, weapongroup ) )
    {
        self.lastcacweaponobj = objnewweapon;
    }
}

// Namespace weapons
// Params 1, eflags: 0x4
// Checksum 0xdc97fad2, Offset: 0x2daa
// Size: 0x90
function private updateweaponspeed( objnewweapon )
{
    function_1be79f01c9145d95( objnewweapon );
    
    if ( objnewweapon.basename == "none" )
    {
        return;
    }
    
    if ( weapon::function_d4dcd88477cfa8ca( objnewweapon.basenamehash ) || weapon::iskillstreakweaponname( objnewweapon.basename ) || weapon::isfistweaponobject( objnewweapon ) || objnewweapon.inventorytype == "primary" || objnewweapon.inventorytype == "altmode" )
    {
        updatemovespeedscale();
    }
}

// Namespace weapons
// Params 1, eflags: 0x4
// Checksum 0x140f55bc, Offset: 0x2e42
// Size: 0x64
function private function_1be79f01c9145d95( objweapon )
{
    if ( !isdefined( self.var_63ebfc652a316399 ) )
    {
        self.var_63ebfc652a316399 = 0;
    }
    
    supportsjog = function_841d763e94e796ae( objweapon );
    
    if ( supportsjog == self.var_63ebfc652a316399 )
    {
        val::set( "weaponJogState", "jog", supportsjog );
        self.var_63ebfc652a316399 = !supportsjog;
    }
}

// Namespace weapons
// Params 1, eflags: 0x4
// Checksum 0x8c97d334, Offset: 0x2eae
// Size: 0x15, Type: bool
function private function_841d763e94e796ae( objweapon )
{
    return !weapon_utility::isriotshieldobject( objweapon );
}

// Namespace weapons
// Params 0
// Checksum 0x816fc350, Offset: 0x2ecc
// Size: 0x12c
function function_8a7193fb82f2181b()
{
    if ( !isdefined( self.lastweaponobj ) || isnullweapon( self.lastweaponobj ) )
    {
        return;
    }
    
    weaponname = weapon::function_170e300815e9c1a2( self.lastweaponobj );
    currenttime = telemetry_utils::get_time_from_match_start( gettime() );
    
    if ( !isdefined( self.pers[ "currentWeaponStartTime" ] ) )
    {
        self.pers[ "currentWeaponStartTime" ] = 0;
    }
    
    totaltime = currenttime - self.pers[ "currentWeaponStartTime" ];
    telemetry_data = { #weaponobj:self.lastweaponobj, #variantid:getweaponvariantindex( self.lastweaponobj ), #statupdates:[ { #value:totaltime, #name:"timeUsed" } ], #fullweaponname:getcompleteweaponname( self.lastweaponobj ), #weaponname:weaponname };
    telemetry_utils::function_af2d366f9522f76f( "callback_update_weapon_stats", telemetry_data );
    self.pers[ "currentWeaponStartTime" ] = currenttime;
}

// Namespace weapons
// Params 1
// Checksum 0xea71d02e, Offset: 0x3000
// Size: 0x201
function onplayerspawned( params )
{
    gamelogic_mp::sethasdonecombat( self, 0 );
    
    if ( !isdefined( self.trackingweapon ) )
    {
        persistence::persclear_stats();
    }
    
    if ( !isdefined( self.plantedlethalequip ) )
    {
        self.plantedlethalequip = [];
    }
    
    if ( !isdefined( self.plantedtacticalequip ) )
    {
        self.plantedtacticalequip = [];
    }
    
    if ( level.var_613ba3e28ca2d235 && !isdefined( self.var_68db24a5acce8b08 ) )
    {
        self.var_68db24a5acce8b08 = [];
    }
    
    if ( !isdefined( self.plantedsuperequip ) )
    {
        self.plantedsuperequip = [];
    }
    
    if ( !isdefined( self.plantedhackedequip ) )
    {
        self.plantedhackedequip = [];
    }
    
    self.prevweaponobj = undefined;
    self.lastweaponobj = undefined;
    thread watchchangeweapon();
    thread watchweaponusage();
    thread watchgrenadeusage();
    thread function_9e3462ad5091450d();
    thread watchequipmentonspawn();
    
    if ( game_utility_mp::onlinestatsenabled() )
    {
        thread watchfornearmisswhizby();
    }
    
    if ( !game_utility_mp::runleanthreadmode() )
    {
        thread watchdropweapons();
        thread watchweaponpickup();
    }
    
    self.lasthittime = [];
    self.droppeddeathweapon = undefined;
    weapon_utility::function_b6883e5e149bdb1f();
    self.lastnormalweaponobj = self.spawnweaponobj ?? nullweapon();
    self.var_983a3526ad5f8a6a = self.spawnweaponobj ?? nullweapon();
    self.lastcacweaponobj = self.spawnweaponobj ?? nullweapon();
    setlastdroppableweaponobj( self.spawnweaponobj ?? nullweapon() );
    gamescore::initassisttrackers();
    currentcamo = getweaponcamoname( self getcurrentweapon() );
    thread runcamoscripts( currentcamo );
    self.var_3edfd0e6cc4a1686 = undefined;
    thread function_489824b64b3a33ef();
    
    if ( level.gamemodebundle.var_e1c050717d0c2b22 )
    {
        thread function_7c254433f5f99915();
        thread function_b217ecdbbe7a2ff3();
        thread function_3226c0a2c58ef50b();
    }
    
    if ( level.gamemodebundle.var_a2cfc829ed654455 )
    {
        thread function_c8710a52eed8ac0b();
    }
}

// Namespace weapons
// Params 1, eflags: 0x4
// Checksum 0xe3391c8b, Offset: 0x3209
// Size: 0x1e
function private onplayerdeath( params )
{
    params.victim function_4b2218329e58e4ac();
}

// Namespace weapons
// Params 1, eflags: 0x4
// Checksum 0x403328a3, Offset: 0x322f
// Size: 0x13
function private function_c614aaeb1d4d8bc6( params )
{
    function_4b2218329e58e4ac();
}

// Namespace weapons
// Params 0
// Checksum 0x986ae434, Offset: 0x324a
// Size: 0x1a1
function savealtstates()
{
    self.pers[ "altStates" ] = [];
    
    if ( !isundefinedweapon( self.primaryweaponobj ) )
    {
        foreach ( objweapon in self.primaryinventory )
        {
            if ( objweapon == self.primaryweaponobj && shouldweaponsavealtstate( objweapon ) && self isalternatemode( objweapon, 1 ) )
            {
                var_bda53394c108f2e = weapon::getcompleteweaponnamenoalt( objweapon );
                self.pers[ "altStates" ][ var_bda53394c108f2e ] = 1;
            }
        }
    }
    
    if ( !isundefinedweapon( self.secondaryweaponobj ) )
    {
        foreach ( objweapon in self.primaryinventory )
        {
            if ( objweapon == self.secondaryweaponobj && shouldweaponsavealtstate( objweapon ) && self isalternatemode( objweapon, 1 ) )
            {
                var_bda53394c108f2e = weapon::getcompleteweaponnamenoalt( objweapon );
                self.pers[ "altStates" ][ var_bda53394c108f2e ] = 1;
            }
        }
    }
}

// Namespace weapons
// Params 0
// Checksum 0xd3370508, Offset: 0x33f3
// Size: 0x1f4
function savetogglescopestates()
{
    self.pers[ "toggleScopeStates" ] = [];
    self.pers[ "toggleCantedAdsStates" ] = [];
    self.pers[ "tacticalADSStates" ] = [];
    weapons = self.primaryinventory;
    
    foreach ( objweapon in weapons )
    {
        if ( !isundefinedweapon( self.primaryweaponobj ) && objweapon == self.primaryweaponobj || !isundefinedweapon( self.secondaryweaponobj ) && objweapon == self.secondaryweaponobj )
        {
            var_bda53394c108f2e = undefined;
            
            if ( isdefined( objweapon.scope ) && istogglescope( objweapon, objweapon.scope ) )
            {
                var_bda53394c108f2e = weapon::getcompleteweaponnamenoalt( objweapon );
                self.pers[ "toggleScopeStates" ][ var_bda53394c108f2e ] = self gethybridscopestate( objweapon );
                
                if ( getweaponhasperk( objweapon, "specialty_snapshot_lens" ) )
                {
                    self.pers[ "toggleScopeStates" ][ var_bda53394c108f2e ] = 0;
                }
            }
            
            if ( self function_d72cc834ae654298( objweapon ) )
            {
                var_bda53394c108f2e = weapon::getcompleteweaponnamenoalt( objweapon );
                self.pers[ "toggleCantedAdsStates" ][ var_bda53394c108f2e ] = self function_aaac87409bf90eba( objweapon );
            }
            
            if ( self cantacticalads( objweapon ) )
            {
                if ( !isdefined( var_bda53394c108f2e ) )
                {
                    var_bda53394c108f2e = weapon::getcompleteweaponnamenoalt( objweapon );
                }
                
                self.pers[ "tacticalADSStates" ][ var_bda53394c108f2e ] = self function_25af1328b3e8da54( objweapon, 1 );
                
                if ( !isalive( self ) && self function_2f54b45b6609127e() )
                {
                    self.pers[ "tacticalADSStates" ][ var_bda53394c108f2e ] = 0;
                }
            }
        }
    }
}

// Namespace weapons
// Params 0
// Checksum 0x14573767, Offset: 0x35ef
// Size: 0x179
function function_7cc000a4d4bc9a60()
{
    self.pers[ "LaserToggleStates" ] = [];
    
    if ( !isundefinedweapon( self.primaryweaponobj ) )
    {
        foreach ( objweapon in self.primaryinventory )
        {
            if ( objweapon == self.primaryweaponobj )
            {
                var_bda53394c108f2e = weapon::getcompleteweaponnamenoalt( objweapon );
                self.pers[ "LaserToggleStates" ][ var_bda53394c108f2e ] = self function_7cc893ebe37f811a( objweapon );
            }
        }
    }
    
    if ( !isundefinedweapon( self.secondaryweaponobj ) )
    {
        foreach ( objweapon in self.primaryinventory )
        {
            if ( objweapon == self.secondaryweaponobj )
            {
                var_bda53394c108f2e = weapon::getcompleteweaponnamenoalt( objweapon );
                self.pers[ "LaserToggleStates" ][ var_bda53394c108f2e ] = self function_7cc893ebe37f811a( objweapon );
            }
        }
    }
}

// Namespace weapons
// Params 1
// Checksum 0xda7d8133, Offset: 0x3770
// Size: 0xe0
function updatetogglescopestate( objweapon )
{
    var_bda53394c108f2e = weapon::getcompleteweaponnamenoalt( objweapon );
    
    if ( isdefined( self.pers[ "toggleScopeStates" ][ var_bda53394c108f2e ] ) )
    {
        self sethybridscopestate( objweapon, self.pers[ "toggleScopeStates" ][ var_bda53394c108f2e ] );
    }
    else if ( isdefined( self.pers[ "toggleCantedAdsStates" ][ var_bda53394c108f2e ] ) )
    {
        self function_aef8cd8182fae1b6( objweapon, self.pers[ "toggleCantedAdsStates" ][ var_bda53394c108f2e ] );
    }
    else if ( self function_d72cc834ae654298( objweapon ) )
    {
        self function_aef8cd8182fae1b6( objweapon, 1 );
    }
    
    if ( self hasweapon( objweapon ) && self cantacticalads( objweapon ) && isdefined( self.pers[ "tacticalADSStates" ][ var_bda53394c108f2e ] ) )
    {
        self function_c263e67f8d9fe588( objweapon, self.pers[ "tacticalADSStates" ][ var_bda53394c108f2e ] );
    }
}

// Namespace weapons
// Params 1
// Checksum 0xd167b32d, Offset: 0x3858
// Size: 0x72
function function_bc0af64402b25353( objweapon )
{
    if ( self.var_c99cd485dda40b28 && self function_c73449308bae68f3( objweapon ) )
    {
        self function_58dc67c4bcfa1ef3( objweapon, 1 );
        return;
    }
    
    var_bda53394c108f2e = weapon::getcompleteweaponnamenoalt( objweapon );
    
    if ( isdefined( self.pers[ "LaserToggleStates" ][ var_bda53394c108f2e ] ) )
    {
        self function_58dc67c4bcfa1ef3( objweapon, self.pers[ "LaserToggleStates" ][ var_bda53394c108f2e ] );
    }
}

// Namespace weapons
// Params 1
// Checksum 0x85201c94, Offset: 0x38d2
// Size: 0x9d
function updatesavedaltstate( objweapon )
{
    assert( !objweapon.isalternate, "<dev string:x24>" );
    
    if ( isdefined( self.pers[ "altStates" ] ) && objweapon.hasalternate && function_657930e1b2d76f( objweapon ) )
    {
        var_bda53394c108f2e = weapon::getcompleteweaponnamenoalt( objweapon );
        
        if ( isdefined( self.pers[ "altStates" ][ var_bda53394c108f2e ] ) && self.pers[ "altStates" ][ var_bda53394c108f2e ] )
        {
            objweapon = objweapon getaltweapon();
        }
    }
    
    return objweapon;
}

// Namespace weapons
// Params 2
// Checksum 0x87fc61d4, Offset: 0x3978
// Size: 0xa2, Type: bool
function istogglescope( weapon, attachment )
{
    if ( getprojectname() == "REX" )
    {
        if ( isdefined( attachment ) && isdefined( weapon ) )
        {
            attachmentdata = function_333a08591af6b59( weapon, attachment );
            
            if ( !isdefined( attachmentdata ) )
            {
                return false;
            }
            
            attachmentbundle = getscriptbundle( attachmentdata );
            subcategory = attachmentbundle.subcategories[ 0 ].subcategory;
            return ( subcategory == "VARIABLE_ZOOM" || function_111dde386d2981b4( weapon ) );
        }
    }
    
    return isdefined( attachment ) && getattachmentbasetype( weapon, attachment ) == "hybrid";
}

// Namespace weapons
// Params 1
// Checksum 0xba16e5fb, Offset: 0x3a23
// Size: 0x19, Type: bool
function function_657930e1b2d76f( objweapon )
{
    if ( objweapon function_9f32f77e19c99f48() )
    {
        return false;
    }
    
    return true;
}

// Namespace weapons
// Params 1
// Checksum 0xfc06a05b, Offset: 0x3a45
// Size: 0x3b, Type: bool
function shouldweaponsavealtstate( objweapon )
{
    return objweapon.hasalternate && !weapon::function_251a6cf32459b82d( objweapon ) && shouldattachmentsavealtstate( objweapon, objweapon.underbarrel );
}

// Namespace weapons
// Params 2
// Checksum 0x868ba9b9, Offset: 0x3a89
// Size: 0x49, Type: bool
function shouldattachmentsavealtstate( objweapon, attachunique )
{
    basetype = getattachmentbasetype( objweapon, attachunique );
    var_e262fdea95ea1845 = basetype == "alt_mode_save";
    return isattachmentselectfire( objweapon, attachunique ) || var_e262fdea95ea1845;
}

// Namespace weapons
// Params 2
// Checksum 0x262b6ffc, Offset: 0x3adb
// Size: 0x30, Type: bool
function isattachmentselectfire( weapon, attachment )
{
    basetype = getattachmentbasetype( weapon, attachment );
    return basetype == "selectfire";
}

// Namespace weapons
// Params 1
// Checksum 0x1ac97760, Offset: 0x3b14
// Size: 0xd, Type: bool
function isattachmentgrenadelauncher( attachunique )
{
    return false;
}

// Namespace weapons
// Params 2
// Checksum 0x4de36c70, Offset: 0x3b2a
// Size: 0x91
function weaponperkupdate( currweaponobj, prevweaponobj )
{
    if ( !isundefinedweapon( prevweaponobj ) )
    {
        var_d30524e4044640f4 = weapon::function_170e300815e9c1a2( prevweaponobj );
        perkremove = weapon::weaponperkmap( var_d30524e4044640f4 );
        
        if ( isdefined( perkremove ) )
        {
            weapon_removeperk( perkremove );
        }
    }
    
    if ( !isundefinedweapon( currweaponobj ) )
    {
        var_fbc5fb196e15cf0b = weapon::function_170e300815e9c1a2( currweaponobj );
        perkadd = weapon::weaponperkmap( var_fbc5fb196e15cf0b );
        
        if ( isdefined( perkadd ) )
        {
            weapon_giveperk( perkadd );
        }
    }
}

// Namespace weapons
// Params 2
// Checksum 0xaea90985, Offset: 0x3bc3
// Size: 0x73
function function_f1fb7eab04f0e9ac( currweaponobj, prevweaponobj )
{
    if ( level.gamemodebundle.var_a08b609de29036c2 )
    {
        if ( !isundefinedweapon( prevweaponobj ) )
        {
            if ( prevweaponobj.ismelee )
            {
                weapon_removeperk( "specialty_infinite_tacsprint" );
            }
        }
        
        if ( !isundefinedweapon( currweaponobj ) )
        {
            if ( currweaponobj.ismelee )
            {
                weapon_giveperk( "specialty_infinite_tacsprint" );
            }
        }
    }
}

// Namespace weapons
// Params 2
// Checksum 0xb84042da, Offset: 0x3c3e
// Size: 0x113
function weaponattachmentperkupdate( currweaponobj, prevweaponobj )
{
    if ( isdefined( prevweaponobj ) )
    {
        perks = prevweaponobj function_4effdad40704b4c5();
        
        foreach ( perk in perks )
        {
            weapon_removeperk( perk );
        }
    }
    
    if ( isdefined( currweaponobj ) )
    {
        perks = currweaponobj function_4effdad40704b4c5();
        
        foreach ( perk in perks )
        {
            weapon_giveperk( perk );
        }
    }
}

// Namespace weapons
// Params 2, eflags: 0x4
// Checksum 0xc48c99ee, Offset: 0x3d59
// Size: 0x41
function private doweaponperkupdate( prevweaponobj, currweaponobj = self getcurrentweapon() )
{
    weaponattachmentperkupdate( currweaponobj, prevweaponobj );
    weaponperkupdate( currweaponobj, prevweaponobj );
    function_f1fb7eab04f0e9ac( currweaponobj, prevweaponobj );
    return currweaponobj;
}

// Namespace weapons
// Params 0
// Checksum 0xca51aaa0, Offset: 0x3da3
// Size: 0x4c
function watchweaponperkupdates()
{
    self endon( #"death_or_disconnect", #"faux_spawn", #"giveloadout_start" );
    prevweaponobj = undefined;
    
    while ( true )
    {
        prevweaponobj = doweaponperkupdate( prevweaponobj );
        self waittill( #"weapon_change" );
    }
}

// Namespace weapons
// Params 1
// Checksum 0x3260b309, Offset: 0x3df7
// Size: 0x99, Type: bool
function sniperglint_supported( weapon )
{
    if ( isnullweapon( weapon ) || !isdefined( weapon.scope ) || weaponclass( weapon ) == "rocketlauncher" )
    {
        return false;
    }
    
    class = weaponclass( weapon );
    
    if ( self isalternatemode( weapon ) && ( class == "grenade" || class == "spread" ) )
    {
        return false;
    }
    
    if ( self isalternatemode( weapon ) && getweaponhasperk( weapon, "specialty_apex_knives" ) )
    {
        return false;
    }
    
    return function_16b573d555897cc8() || function_1239bb212a835f4a();
}

// Namespace weapons
// Params 0, eflags: 0x4
// Checksum 0x77618053, Offset: 0x3e99
// Size: 0x8a, Type: bool
function private function_16b573d555897cc8()
{
    return isdefined( self.perks[ "specialty_glintxsml" ] ) || isdefined( self.perks[ "specialty_glintsml" ] ) || isdefined( self.perks[ "specialty_glintmed" ] ) || isdefined( self.perks[ "specialty_glintlrg" ] ) || isdefined( self.perks[ "specialty_glintxlrg" ] ) || isdefined( self.perks[ "specialty_glint_smart" ] ) || isdefined( self.perks[ "specialty_glint_shotgun_strobe" ] );
}

// Namespace weapons
// Params 0, eflags: 0x4
// Checksum 0x63c69298, Offset: 0x3f2c
// Size: 0x12, Type: bool
function private function_1239bb212a835f4a()
{
    return isdefined( self.perks[ "specialty_range_indicator" ] );
}

// Namespace weapons
// Params 1
// Checksum 0x36ddbf5f, Offset: 0x3f47
// Size: 0xd1
function sniperglint_manage( objweapon )
{
    self notify( #"hash_f4005c10ec3f84ec" );
    self endon( #"hash_f4005c10ec3f84ec" );
    self endon( #"weapon_change" );
    waitframe();
    thread sniperglint_cleanup();
    self.glinton = 0;
    istogglescope = istogglescope( objweapon, objweapon.scope );
    
    if ( function_1239bb212a835f4a() )
    {
        function_32d679bcfb391db5( objweapon );
    }
    
    while ( true )
    {
        if ( self playerads() > 0.5 && self hasweapon( objweapon ) && !( istogglescope && self gethybridscopestate( objweapon ) ) )
        {
            if ( !self.glinton )
            {
                sniperglint_add();
            }
        }
        else if ( self.glinton )
        {
            sniperglint_remove();
        }
        
        waitframe();
    }
}

// Namespace weapons
// Params 0
// Checksum 0x41e64f11, Offset: 0x4020
// Size: 0x3e
function sniperglint_cleanup()
{
    utility::waittill_any( "death_or_disconnect", "weapon_change" );
    
    if ( isdefined( self.glinton ) && self.glinton )
    {
        sniperglint_remove();
        self.glinton = undefined;
    }
}

// Namespace weapons
// Params 0
// Checksum 0x9304205b, Offset: 0x4066
// Size: 0x188
function sniperglint_add()
{
    assert( isdefined( self.glinton ), "<dev string:x5d>" );
    assert( !isdefined( self.glinton ) || self.glinton == 0, "<dev string:x97>" );
    
    if ( isdefined( self.perks[ "specialty_noglint" ] ) )
    {
        self setscriptablepartstate( "sniperGlint", "sniperGlintOff", 0 );
        self.glinton = 0;
        return;
    }
    
    if ( isdefined( self.perks[ "specialty_glintxsml" ] ) )
    {
        self setscriptablepartstate( "sniperGlint", "sniperGlintXsml", 0 );
    }
    else if ( isdefined( self.perks[ "specialty_glintsml" ] ) )
    {
        self setscriptablepartstate( "sniperGlint", "sniperGlintSml", 0 );
    }
    else if ( isdefined( self.perks[ "specialty_glintmed" ] ) )
    {
        self setscriptablepartstate( "sniperGlint", "sniperGlintMed", 0 );
    }
    else if ( isdefined( self.perks[ "specialty_glintlrg" ] ) )
    {
        self setscriptablepartstate( "sniperGlint", "sniperGlintLrg", 0 );
    }
    else if ( isdefined( self.perks[ "specialty_glintxlrg" ] ) )
    {
        self setscriptablepartstate( "sniperGlint", "sniperGlintXlrg", 0 );
    }
    else if ( isdefined( self.perks[ "specialty_glint_smart" ] ) )
    {
        self setscriptablepartstate( "sniperGlint", "sniperGlintSmart", 0 );
    }
    else if ( isdefined( self.perks[ "specialty_glint_shotgun_strobe" ] ) )
    {
        self setscriptablepartstate( "sniperGlint", "shotgunStrobeGlint", 0 );
    }
    
    self.glinton = 1;
}

// Namespace weapons
// Params 0
// Checksum 0xee1ea2ce, Offset: 0x41f6
// Size: 0x61
function sniperglint_remove()
{
    assert( isdefined( self.glinton ), "<dev string:xd5>" );
    assert( !isdefined( self.glinton ) || self.glinton == 1, "<dev string:x112>" );
    
    if ( isdefined( self ) )
    {
        self setscriptablepartstate( "sniperGlint", "sniperGlintOff", 0 );
        self.glinton = 0;
    }
}

// Namespace weapons
// Params 2
// Checksum 0x38fae5f2, Offset: 0x425f
// Size: 0x47
function function_b01f7046ffaa9bac( maxthreshold, minthreshold )
{
    if ( hasomnvar( "ui_damage_range_max_threshold" ) )
    {
        self setclientomnvar( "ui_damage_range_max_threshold", maxthreshold );
    }
    
    if ( hasomnvar( "ui_damage_range_min_threshold" ) )
    {
        self setclientomnvar( "ui_damage_range_min_threshold", minthreshold );
    }
}

// Namespace weapons
// Params 2, eflags: 0x4
// Checksum 0x3e87238e, Offset: 0x42ae
// Size: 0x19, Type: bool
function private function_283ce31a450cda6f( key, val )
{
    return val == 0;
}

// Namespace weapons
// Params 1
// Checksum 0x464b281f, Offset: 0x42d0
// Size: 0x91
function function_32d679bcfb391db5( weapon )
{
    ranges = function_cc6d8e547793427a( weapon );
    
    if ( !isdefined( ranges ) || ranges.size == 0 )
    {
        function_b01f7046ffaa9bac( 0, 0 );
        return;
    }
    
    ranges = arrayremoveduplicates( ranges );
    ranges = arraysort( ranges );
    ranges = utility::function_6ed29b1b786df49a( ranges, &function_283ce31a450cda6f );
    
    if ( ranges.size == 0 )
    {
        function_b01f7046ffaa9bac( 0, 0 );
    }
    
    maxthreshold = ranges[ 0 ];
    minthreshold = ranges[ ranges.size - 1 ];
    function_b01f7046ffaa9bac( maxthreshold, minthreshold );
}

// Namespace weapons
// Params 1
// Checksum 0x80692edb, Offset: 0x4369
// Size: 0x68
function sniperadsblur( weapon )
{
    self endon( #"weapon_change" );
    self.sniperblur = 0;
    
    while ( true )
    {
        if ( self playerads() > 0.65 && !self.sniperblur )
        {
            thread sniperadsblur_execute( weapon );
        }
        else if ( self playerads() <= 0.65 )
        {
            sniperadsblur_remove();
        }
        
        waitframe();
    }
}

// Namespace weapons
// Params 1
// Checksum 0xfbce7195, Offset: 0x43d9
// Size: 0x51
function sniperadsblur_execute( weapon )
{
    self notify( #"hash_51ba092be22ff4b6" );
    self endon( #"hash_51ba092be22ff4b6" );
    self.sniperblur = 1;
    self setblurforplayer( 25, 0.1 );
    wait 0.1;
    self setblurforplayer( 0, getsniperadsblurtime( weapon ) );
}

// Namespace weapons
// Params 0
// Checksum 0x319a8d92, Offset: 0x4432
// Size: 0x20
function sniperadsblur_remove()
{
    self notify( #"hash_51ba092be22ff4b6" );
    self setblurforplayer( 0, 0 );
    self.sniperblur = 0;
}

// Namespace weapons
// Params 1
// Checksum 0x680c97d8, Offset: 0x445a
// Size: 0x74
function getsniperadsblurtime( weapon )
{
    blurtime = 0.3;
    
    switch ( weapon.basename )
    {
        case #"hash_720415103e03ae2":
            blurtime = 0.18;
            break;
        case #"hash_b9e0da8080aefc13":
            blurtime = 0.12;
            break;
        case #"hash_1c4e9e71e522fc4f":
            blurtime = 0.12;
            break;
    }
    
    return blurtime;
}

// Namespace weapons
// Params 0
// Checksum 0x8d7db9d1, Offset: 0x44d7
// Size: 0x10a
function watchsniperboltactionkills()
{
    self endon( #"death_or_disconnect" );
    thread watchsniperboltactionkills_ondeath();
    
    if ( !isdefined( self.pers[ "recoilReduceKills" ] ) )
    {
        self.pers[ "recoilReduceKills" ] = 0;
    }
    
    self setclientomnvar( "weap_sniper_display_state", self.pers[ "recoilReduceKills" ] );
    
    while ( true )
    {
        self waittill( #"got_a_kill", victim, sweapon, meansofdeath );
        weapon = utility::function_64003742d8f5c781( sweapon );
        
        if ( isrecoilreducingweapon( weapon ) )
        {
            kills = self.pers[ "recoilReduceKills" ] + 1;
            self.pers[ "recoilReduceKills" ] = int( min( kills, 4 ) );
            self setclientomnvar( "weap_sniper_display_state", self.pers[ "recoilReduceKills" ] );
            
            if ( kills <= 4 )
            {
                stancerecoilupdate( self getstance() );
            }
        }
    }
}

// Namespace weapons
// Params 0
// Checksum 0x7b0dfc2b, Offset: 0x45e9
// Size: 0x44
function watchsniperboltactionkills_ondeath()
{
    self notify( #"hash_8673ea663157827d" );
    self endon( #"hash_8673ea663157827d" );
    self endon( #"disconnect" );
    self waittill( #"death" );
    self.pers[ "recoilReduceKills" ] = 0;
}

// Namespace weapons
// Params 1
// Checksum 0x8c6bfbe4, Offset: 0x4635
// Size: 0xd, Type: bool
function isrecoilreducingweapon( weapon )
{
    return false;
}

// Namespace weapons
// Params 0
// Checksum 0x51d078eb, Offset: 0x464b
// Size: 0x37
function getrecoilreductionvalue()
{
    if ( !isdefined( self.pers[ "recoilReduceKills" ] ) )
    {
        self.pers[ "recoilReduceKills" ] = 0;
    }
    
    return self.pers[ "recoilReduceKills" ] * 3;
}

// Namespace weapons
// Params 1
// Checksum 0xf099428d, Offset: 0x468b
// Size: 0x41, Type: bool
function ishackweapon( weapon )
{
    if ( weapon == "radar_mp" || weapon == "airstrike_mp" || weapon == "helicopter_mp" )
    {
        return true;
    }
    
    if ( weapon == "briefcase_bomb_mp" )
    {
        return true;
    }
    
    return false;
}

// Namespace weapons
// Params 1
// Checksum 0xba908af7, Offset: 0x46d5
// Size: 0x86, Type: bool
function isbombplantweapon( var_eadb663a1292c9e8 )
{
    switch ( var_eadb663a1292c9e8 )
    {
        case %"counter_attack_bomb_silent_mp":
        case %"briefcase_defuse_silent_mp":
        case %"briefcase_bomb_defuse_mp":
        case %"counter_attack_bomb_mp":
        case %"briefcase_bomb_mp_nuke":
        case %"counter_attack_bomb_defuse_mp":
        case %"briefcase_silent_mp":
        case %"briefcase_bomb_mp":
        case %"counter_attack_bomb_defuse_silent_mp":
            return true;
    }
    
    return false;
}

// Namespace weapons
// Params 3
// Checksum 0xadd268b8, Offset: 0x4764
// Size: 0x64f
function function_22b8cd3c832b3d36( dropweapon, attacker, smeansofdeath )
{
    if ( getdvarint( @"hash_7862a785c8e6d973", 0 ) )
    {
        if ( smeansofdeath == "MOD_EXECUTION" )
        {
            rootname = weapon::getweaponrootname( attacker.prevweaponobj );
            weaponclass = weapon::function_c37ac3c4f987e506( rootname, #"classdata" );
        }
        else
        {
            rootname = weapon::getweaponrootname( attacker.currentweapon );
            weaponclass = weapon::function_c37ac3c4f987e506( rootname, #"classdata" );
        }
        
        if ( !isdefined( weaponclass ) || weaponclass == "melee" || weaponclass == "melee2" || weaponclass == "none" )
        {
            return;
        }
        
        if ( smeansofdeath == "MOD_EXECUTION" )
        {
            ammotype = getweaponammopoolname( attacker.prevweaponobj );
        }
        else
        {
            ammotype = getweaponammopoolname( attacker.currentweapon );
        }
    }
    else
    {
        rootname = weapon::getweaponrootname( dropweapon );
        weaponclass = weapon::function_c37ac3c4f987e506( rootname, #"classdata" );
        
        if ( !isdefined( weaponclass ) || weaponclass == "melee" || weaponclass == "melee2" || weaponclass == "none" )
        {
            return;
        }
        
        ammotype = getweaponammopoolname( dropweapon );
    }
    
    if ( !isdefined( ammotype ) )
    {
        return;
    }
    
    if ( isplayer( attacker ) && isdefined( attacker.perks[ "specialty_scavenger" ] ) )
    {
        hasscav = 1;
    }
    
    if ( isdefined( level.gamemodebundle.var_9711caed9adc1ece ) )
    {
        var_8294eeb5d705086b = getscriptbundle( level.gamemodebundle.var_9711caed9adc1ece );
        var_c02b0763dfa87fd = var_8294eeb5d705086b.var_ab2032ab39a0e386;
    }
    
    if ( ammotype != %"WEAPON/AMMO_POOL_LAUNCHER" )
    {
        foreach ( ref in var_c02b0763dfa87fd )
        {
            if ( ref.var_2c7f7e08b1af9739 == ammotype )
            {
                var_48853ed7df574338 = ref.var_c8bffad89bf9a090;
                lootid = getscriptbundlefieldvalue( ref.var_e4c9e8e917e9708c, #"lootid" );
                pickupalias = ref.var_3e115338586fbac9;
                break;
            }
        }
    }
    else if ( ammotype == %"WEAPON/AMMO_POOL_LAUNCHER" )
    {
        if ( hasscav )
        {
            foreach ( ref in var_c02b0763dfa87fd )
            {
                if ( ref.var_2c7f7e08b1af9739 == ammotype )
                {
                    var_48853ed7df574338 = ref.var_c8bffad89bf9a090;
                    lootid = getscriptbundlefieldvalue( ref.var_e4c9e8e917e9708c, #"lootid" );
                    pickupalias = ref.var_3e115338586fbac9;
                    break;
                }
            }
        }
        else
        {
            var_48853ed7df574338 = undefined;
        }
    }
    
    if ( isdefined( var_48853ed7df574338 ) )
    {
        thread function_7a1747185b4c0c43( var_48853ed7df574338, ammotype, lootid, self.origin, smeansofdeath, pickupalias );
        
        if ( var_48853ed7df574338 != "mp_ammo_pickup_pi" )
        {
            if ( getdvarint( @"hash_7862a785c8e6d973", 0 ) )
            {
                foreach ( gun in attacker.primaryinventory )
                {
                    ammopool = getweaponammopoolname( gun );
                    
                    if ( ammopool == %"hash_2a5b2d215472036e" )
                    {
                        foreach ( ref in var_c02b0763dfa87fd )
                        {
                            if ( ref.var_2c7f7e08b1af9739 == ammopool )
                            {
                                var_74c06235e3416eb5 = ref.var_c8bffad89bf9a090;
                                pistollootid = getscriptbundlefieldvalue( ref.var_e4c9e8e917e9708c, #"lootid" );
                                var_39065cfa6666db6f = ref.var_3e115338586fbac9;
                                break;
                            }
                        }
                        
                        thread function_7a1747185b4c0c43( var_74c06235e3416eb5, ammopool, pistollootid, self.origin, smeansofdeath, var_39065cfa6666db6f );
                        break;
                    }
                }
                
                return;
            }
            
            foreach ( gun in self.primaryinventory )
            {
                ammopool = getweaponammopoolname( gun );
                
                if ( ammopool == %"hash_2a5b2d215472036e" )
                {
                    foreach ( ref in var_c02b0763dfa87fd )
                    {
                        if ( ref.var_2c7f7e08b1af9739 == ammopool )
                        {
                            var_74c06235e3416eb5 = ref.var_c8bffad89bf9a090;
                            pistollootid = getscriptbundlefieldvalue( ref.var_e4c9e8e917e9708c, #"lootid" );
                            var_39065cfa6666db6f = ref.var_3e115338586fbac9;
                            break;
                        }
                    }
                    
                    thread function_7a1747185b4c0c43( var_74c06235e3416eb5, ammopool, pistollootid, self.origin, smeansofdeath, var_39065cfa6666db6f );
                    break;
                }
            }
        }
    }
}

// Namespace weapons
// Params 6
// Checksum 0xf86c0d1, Offset: 0x4dbb
// Size: 0x219
function function_7a1747185b4c0c43( scriptablename, ammotype, lootid, pos, smeansofdeath, pickupalias )
{
    xoffset = randomintrange( 10, 25 );
    
    if ( utility::cointoss() )
    {
        xoffset *= -1;
    }
    
    yoffset = randomfloatrange( 3, 30 );
    
    if ( utility::percent_chance( 35 ) )
    {
        yoffset *= -1;
    }
    
    randpos = pos + ( xoffset, yoffset, 15 );
    tracestart = randpos;
    ground = randpos + ( 0, 0, -300 );
    traceresults = trace::ray_trace( tracestart, ground, self );
    pickuppos = traceresults[ "position" ];
    
    if ( smeansofdeath != "MOD_MELEE_TAKEDOWN" || smeansofdeath != "MOD_EXECUTION" )
    {
        ammopickup = utility::function_38add6d321fde077( scriptablename, pos + ( 0, 0, 45 ), pickuppos );
        
        while ( ammopickup getscriptablepartstate( #"mp_ammo_pickup", 1 ) != "arc_done" )
        {
            waitframe();
        }
    }
    else
    {
        ammopickup = utility::function_38add6d321fde077( scriptablename, pos + ( 0, 0, 15 ), pickuppos );
        
        while ( ammopickup getscriptablepartstate( #"mp_ammo_pickup", 1 ) != "arc_done" )
        {
            waitframe();
        }
    }
    
    ammopickup.origin += ( 0, 0, -5.75 );
    ammopickup.ammotype = ammotype;
    ammopickup.lootid = lootid;
    
    if ( isdefined( pickupalias ) )
    {
        ammopickup.pickupalias = pickupalias;
    }
    
    var_6e58a480b76dce7c = spawn( "trigger_radius", ammopickup.origin, 0, 20, 20 );
    ammopickup.triggerent = var_6e58a480b76dce7c;
    var_6e58a480b76dce7c.instance = ammopickup;
    var_6e58a480b76dce7c thread function_ff634af289e4e1c9();
    ammopickup thread function_23bc31b596881603();
}

// Namespace weapons
// Params 6
// Checksum 0xaac605e3, Offset: 0x4fdc
// Size: 0x250
function function_c5a38e4f8016cfe3( instance, part, state, player, bautouse, usestring )
{
    if ( !player hasperk( "specialty_scavenger" ) && instance.ammotype == %"WEAPON/AMMO_POOL_LAUNCHER" )
    {
        return;
    }
    
    matchinggun = undefined;
    
    foreach ( gun in player.primaryinventory )
    {
        ammotype = getweaponammopoolname( gun );
        
        if ( ammotype == instance.ammotype )
        {
            maxstock = weaponmaxammo( gun );
            currentstock = player getweaponammostock( gun );
            
            if ( currentstock < maxstock )
            {
                matchinggun = gun;
                break;
            }
        }
    }
    
    if ( !isdefined( matchinggun ) )
    {
        return;
    }
    
    clipsize = weaponclipsize( matchinggun );
    currentstock = player getweaponammostock( matchinggun );
    
    if ( clipsize == 1 )
    {
        var_8bb1b2bde27b267c = 1;
    }
    else if ( clipsize <= 50 )
    {
        var_8bb1b2bde27b267c = int( clipsize / 2 );
    }
    else
    {
        var_8bb1b2bde27b267c = int( clipsize / 3 );
    }
    
    if ( weaponmaxammo( matchinggun ) > currentstock + var_8bb1b2bde27b267c )
    {
        ammogiven = var_8bb1b2bde27b267c;
    }
    else if ( weaponmaxammo( matchinggun ) <= currentstock + var_8bb1b2bde27b267c )
    {
        ammogiven = weaponmaxammo( matchinggun ) - currentstock;
    }
    
    if ( !isdefined( instance.pickupalias ) )
    {
        pickupalias = "fly_pickup_ammo_generic";
    }
    else
    {
        pickupalias = instance.pickupalias;
    }
    
    player playlocalsound( pickupalias );
    player setweaponammostock( matchinggun, currentstock + var_8bb1b2bde27b267c );
    
    if ( getdvarint( @"hash_bcc494117c9168d6", level.gamemodebundle.var_95fe0ab63727eb94 ) )
    {
        player function_c0653262a9ca772b( instance.lootid, ammogiven );
    }
    
    instance notify( #"hash_8bb929bb7478adb6" );
    instance function_bdc367810c9045c3();
}

// Namespace weapons
// Params 2
// Checksum 0x1ce0657b, Offset: 0x5234
// Size: 0x79
function function_c0653262a9ca772b( lootid, amount )
{
    if ( !isdefined( self.lootitems ) )
    {
        self.lootitems = [];
    }
    
    if ( amount <= 0 )
    {
        return;
    }
    
    if ( isdefined( self.lootitems[ lootid ] ) )
    {
        self.lootitems[ lootid ] += amount;
        return;
    }
    
    self.lootitems[ lootid ] = amount;
    thread function_94c33bd87f397056( lootid );
}

// Namespace weapons
// Params 1
// Checksum 0xb41c6b68, Offset: 0x52b5
// Size: 0x33
function function_94c33bd87f397056( lootid )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    wait 0.3;
    thread function_4740d5f73c232aa5( lootid );
}

// Namespace weapons
// Params 1
// Checksum 0x20be67aa, Offset: 0x52f0
// Size: 0x93
function function_4740d5f73c232aa5( lootid )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( isdefined( self.lootitems[ lootid ] ) )
    {
        self setclientomnvar( "ui_loot_splash_item_quantity", self.lootitems[ lootid ] );
        self setclientomnvar( "ui_loot_splash_item_id", lootid );
        self.lootitems = function_a5c1175d3ea3c25a( self.lootitems, self.lootitems[ lootid ] );
    }
    
    waitframe();
    self setclientomnvar( "ui_loot_splash_item_quantity", 0 );
    self setclientomnvar( "ui_loot_splash_item_id", 0 );
}

// Namespace weapons
// Params 0
// Checksum 0x6f8cb4f2, Offset: 0x538b
// Size: 0x7b
function function_ff634af289e4e1c9()
{
    level endon( #"game_ended" );
    self endon( #"hash_b7a1c82d81ff0022" );
    self endon( #"hash_8bb929bb7478adb6" );
    
    while ( isdefined( self ) )
    {
        self waittill( #"trigger", player );
        
        if ( isplayer( player ) && isalive( player ) && !isbot( player ) )
        {
            function_c5a38e4f8016cfe3( self.instance, undefined, undefined, player, undefined, undefined );
        }
    }
}

// Namespace weapons
// Params 0
// Checksum 0x9134f412, Offset: 0x540e
// Size: 0x16
function function_bdc367810c9045c3()
{
    self.triggerent delete();
    self freescriptable();
}

// Namespace weapons
// Params 0
// Checksum 0x4fd1ebab, Offset: 0x542c
// Size: 0x38
function function_23bc31b596881603()
{
    level endon( #"game_ended" );
    self endon( #"hash_8bb929bb7478adb6" );
    wait 60;
    self.triggerent notify( #"hash_b7a1c82d81ff0022" );
    function_bdc367810c9045c3();
}

// Namespace weapons
// Params 4
// Checksum 0xaf0fc0ee, Offset: 0x546c
// Size: 0x1bc
function dropweaponfordeath( attacker, smeansofdeath, weaponoverride, damage )
{
    if ( level.blockweapondrops )
    {
        return;
    }
    
    if ( isdefined( self.droppeddeathweapon ) )
    {
        return;
    }
    
    foreach ( weapon in self.weaponlist )
    {
        if ( function_77cf0915f575a9d9( weapon ) )
        {
            function_3d7733188308dfdd( attacker, smeansofdeath, weapon, damage );
        }
    }
    
    if ( attacker == self || smeansofdeath == "MOD_SUICIDE" )
    {
        return;
    }
    
    objweapon = weaponoverride ?? self.lastdroppableweaponobj;
    
    if ( !isdefined( objweapon ) )
    {
        /#
            if ( getdvarint( @"scr_dropdebug" ) == 1 )
            {
                println( "<dev string:x154>" );
            }
        #/
        
        return;
    }
    
    if ( objweapon.basename == "none" )
    {
        /#
            if ( getdvarint( @"scr_dropdebug" ) == 1 )
            {
                println( "<dev string:x174>" );
            }
        #/
        
        return;
    }
    
    if ( !self hasweapon( objweapon ) )
    {
        /#
            if ( getdvarint( @"scr_dropdebug" ) == 1 )
            {
                println( "<dev string:x197>" + objweapon.basename + "<dev string:x1c3>" );
            }
        #/
        
        return;
    }
    
    if ( isdefined( level.gamemodemaydropweapon ) && !self [[ level.gamemodemaydropweapon ]]( objweapon ) )
    {
        return;
    }
    
    return function_3d7733188308dfdd( attacker, smeansofdeath, objweapon, damage );
}

// Namespace weapons
// Params 4
// Checksum 0x2cecdb96, Offset: 0x5631
// Size: 0x272
function function_3d7733188308dfdd( attacker, smeansofdeath, objweapon, damage )
{
    objweapon = objweapon getnoaltweapon();
    clipammor = 0;
    clipammol = 0;
    stockammo = 0;
    
    if ( !weapon_utility::isriotshield( objweapon ) )
    {
        if ( !self anyammoforweaponmodes( objweapon ) )
        {
            return;
        }
        
        clipammor = self getweaponammoclip( objweapon, "right" );
        clipammol = self getweaponammoclip( objweapon, "left" );
        
        if ( !clipammor && !clipammol )
        {
            return;
        }
        
        stockammo = self getweaponammostock( objweapon );
        stockmax = weaponmaxammo( objweapon );
        
        if ( stockammo > stockmax )
        {
            stockammo = stockmax;
        }
        
        item = self dropitem( objweapon );
        
        if ( !isdefined( item ) )
        {
            return;
        }
        
        if ( getdvarint( @"hash_3f6e527d9cd7c26c", 0 ) )
        {
            clipmax = weaponclipsize( objweapon );
            
            if ( clipammol == 0 )
            {
                if ( clipmax <= 50 )
                {
                    diff = clipmax - clipammor;
                    stockammo = clipmax + diff;
                }
                else
                {
                    stockammo = int( clipmax * 0.75 );
                }
            }
            else if ( clipammol > 0 )
            {
                diffl = clipmax - clipammol;
                diffr = clipmax - clipammor;
                stockammo = clipmax + diffl + diffr;
            }
        }
        
        if ( level.clearstockondrop )
        {
            stockammo = 0;
        }
        
        item itemweaponsetammo( clipammor, stockammo, clipammol );
        weapongroup = weapon::getweapongroup( objweapon );
        
        if ( smeansofdeath != "MOD_EXECUTION" && smeansofdeath != "MOD_MELEE_TAKEDOWN" )
        {
            thread weapon_utility::dropweaponfordeathlaunch( item, weapongroup, damage, self.angles );
        }
    }
    else
    {
        item = self dropitem( objweapon );
        
        if ( !isdefined( item ) )
        {
            return;
        }
        
        item itemweaponsetammo( 1, 1, 0 );
    }
    
    item sethintdisplayrange( 96 );
    item setuserange( 96 );
    self.droppeddeathweapon = 1;
    item.owner = self;
    item.targetname = "dropped_weapon";
    item.objweapon = objweapon;
    
    if ( getdvarint( @"hash_3f6e527d9cd7c26c", 0 ) )
    {
        if ( isdefined( attacker ) )
        {
            thread function_22b8cd3c832b3d36( objweapon, attacker, smeansofdeath );
        }
    }
    
    item thread watchpickup( self );
    
    if ( !getdvarint( @"hash_5781276c128bb3eb", 0 ) )
    {
        item thread deletepickupafterawhile();
    }
    
    item thread function_c8f008596f23a5f3( self );
    item thread function_cceb3c0efd97117d( self );
    return item;
}

// Namespace weapons
// Params 1
// Checksum 0x28eae8f6, Offset: 0x58ac
// Size: 0xf8
function function_c8f008596f23a5f3( player )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( !game_utility_mp::isteamreviveenabled() )
    {
        return;
    }
    
    self endon( #"death" );
    player endon( #"disconnect" );
    wait 2;
    distsq = distance2dsquared( player.origin, self.origin );
    
    if ( distsq < level.weapondeletedistsq )
    {
        teammates = teams::getfriendlyplayers( player.team );
        
        foreach ( friendly in teammates )
        {
            self hidefromplayer( friendly );
        }
    }
}

// Namespace weapons
// Params 1
// Checksum 0x5a6eb9a4, Offset: 0x59ac
// Size: 0x22e
function forcedropweapon( weaponoverride )
{
    if ( level.blockweapondrops )
    {
        return 0;
    }
    
    if ( isdefined( self.droppeddeathweapon ) )
    {
        return 0;
    }
    
    objweapon = self.lastdroppableweaponobj;
    
    if ( isdefined( weaponoverride ) )
    {
        objweapon = weaponoverride;
    }
    
    if ( !isdefined( objweapon ) )
    {
        /#
            if ( getdvarint( @"scr_dropdebug" ) == 1 )
            {
                println( "<dev string:x154>" );
            }
        #/
        
        return 0;
    }
    
    if ( objweapon.basename == "none" )
    {
        /#
            if ( getdvarint( @"scr_dropdebug" ) == 1 )
            {
                println( "<dev string:x174>" );
            }
        #/
        
        return 0;
    }
    
    if ( !self hasweapon( objweapon ) )
    {
        /#
            if ( getdvarint( @"scr_dropdebug" ) == 1 )
            {
                println( "<dev string:x197>" + objweapon.basename + "<dev string:x1c3>" );
            }
        #/
        
        return -1;
    }
    
    if ( isdefined( level.gamemodemaydropweapon ) && !self [[ level.gamemodemaydropweapon ]]( objweapon ) )
    {
        return 0;
    }
    
    objweapon = objweapon getnoaltweapon();
    clipammor = 0;
    clipammol = 0;
    stockammo = 0;
    
    if ( !weapon_utility::isriotshield( objweapon ) )
    {
        stockammo = self getweaponammostock( objweapon );
        stockmax = weaponmaxammo( objweapon );
        
        if ( stockammo > stockmax )
        {
            stockammo = stockmax;
        }
        
        item = self dropitem( objweapon );
        
        if ( !isdefined( item ) )
        {
            return 0;
        }
        
        if ( !self anyammoforweaponmodes( objweapon ) )
        {
            item makeunusable();
        }
        
        if ( level.clearstockondrop )
        {
            stockammo = 0;
        }
        
        item itemweaponsetammo( clipammor, stockammo, clipammol );
    }
    else
    {
        item = self dropitem( objweapon );
        
        if ( !isdefined( item ) )
        {
            return 0;
        }
        
        item itemweaponsetammo( 1, 1, 0 );
    }
    
    item sethintdisplayrange( 96 );
    item setuserange( 96 );
    item.owner = self;
    item.targetname = "dropped_weapon";
    item.objweapon = objweapon;
    item thread watchpickup( self );
    
    if ( !getdvarint( @"hash_5781276c128bb3eb", 0 ) )
    {
        item thread deletepickupafterawhile();
    }
    
    return 1;
}

// Namespace weapons
// Params 2
// Checksum 0xb3cd0333, Offset: 0x5be3
// Size: 0xbd, Type: bool
function detachifattached( model, basetag )
{
    attachsize = self getattachsize();
    
    for ( i = 0; i < attachsize ; i++ )
    {
        attach = self getattachmodelname( i );
        
        if ( attach != model )
        {
            continue;
        }
        
        tag = self getattachtagname( i );
        self detach( model, tag );
        
        if ( tag != basetag )
        {
            attachsize = self getattachsize();
            
            for ( i = 0; i < attachsize ; i++ )
            {
                tag = self getattachtagname( i );
                
                if ( tag != basetag )
                {
                    continue;
                }
                
                model = self getattachmodelname( i );
                self detach( model, tag );
                break;
            }
        }
        
        return true;
    }
    
    return false;
}

// Namespace weapons
// Params 0
// Checksum 0x7f52001e, Offset: 0x5ca9
// Size: 0x19
function deletepickupafterawhile()
{
    self endon( #"death" );
    wait 60;
    pickupdelete( self );
}

// Namespace weapons
// Params 1
// Checksum 0xf905c81d, Offset: 0x5cca
// Size: 0x2f
function function_cceb3c0efd97117d( player )
{
    player endon( #"disconnect" );
    player waittill( #"trigger_removed" );
    pickupdelete( self );
}

// Namespace weapons
// Params 1
// Checksum 0x9b621230, Offset: 0x5d01
// Size: 0x28
function pickupdelete( pickup )
{
    if ( !isdefined( pickup ) )
    {
        return;
    }
    
    pickup notify( #"weapon_pickup_cancelled" );
    pickup delete();
}

// Namespace weapons
// Params 1
// Checksum 0xe3a7f797, Offset: 0x5d31
// Size: 0x60b
function watchpickup( droppingplayer )
{
    self notify( #"hash_b3051a73ec430f5b" );
    self endon( #"hash_b3051a73ec430f5b" );
    self endon( #"weapon_pickup_cancelled" );
    weaponowner = self.owner;
    weaponobj = self.objweapon;
    level.onweapondropcreated callback_group::callback_trigger( self, droppingplayer, weaponobj );
    weapname = getcompleteweaponname( self.objweapon );
    
    while ( true )
    {
        self waittill( #"trigger", player, droppeditem );
        previousweapon = undefined;
        var_2c437e7a33abb0f5 = level.cyberemp.carrier == player;
        var_649f0efcb2891d06 = game_utility::getgametype() == "cyber" && ( isdefined( droppeditem ) || var_2c437e7a33abb0f5 ) && level.allowempweapon;
        
        if ( var_649f0efcb2891d06 )
        {
            weapons = player inventory_utility::getcurrentprimaryweaponsminusalt();
            
            if ( weapons.size > 2 )
            {
                var_f0019a101c0cde30 = 0;
                var_ce6cfb44205989c6 = 0;
                var_b32189b7de0e42a3 = 0;
                var_c15259833e7ef367 = 0;
                
                foreach ( weapon in weapons )
                {
                    if ( weapon.basename == "iw9_cyberemp_mp" )
                    {
                        var_f0019a101c0cde30 = 1;
                    }
                    
                    if ( weapon::function_e93a21a657377115( weapon ) )
                    {
                        var_ce6cfb44205989c6 = 1;
                    }
                    
                    if ( weapon::isunderwaterweapon( weapon ) )
                    {
                        var_b32189b7de0e42a3 = 1;
                    }
                    
                    if ( weapon::isclimbweapon( weapon ) )
                    {
                        var_c15259833e7ef367 = 1;
                    }
                }
                
                if ( isdefined( player.primaryweapon ) && player.primaryweapon != "iw9_cyberemp_mp" )
                {
                    previousweapon = player.primaryweaponobj;
                }
                else if ( isdefined( player.secondaryweapon ) && player.secondaryweapon != "iw9_cyberemp_mp" )
                {
                    previousweapon = player.secondaryweaponobj;
                }
                
                weaponcount = weapons.size;
                
                if ( var_ce6cfb44205989c6 )
                {
                    weaponcount--;
                }
                
                if ( var_b32189b7de0e42a3 )
                {
                    weaponcount--;
                }
                
                if ( var_c15259833e7ef367 )
                {
                    weaponcount--;
                }
                
                if ( !var_f0019a101c0cde30 || weaponcount > 3 )
                {
                    var_3a133a1f61fd3bc5 = undefined;
                    
                    if ( previousweapon.basename != "none" )
                    {
                        var_3a133a1f61fd3bc5 = previousweapon;
                    }
                    
                    result = player forcedropweapon( var_3a133a1f61fd3bc5 );
                    
                    if ( var_2c437e7a33abb0f5 )
                    {
                        player val::set( "cyber_emp", "weapon_switch", 0 );
                        player val::set( "cyber_emp", "weapon_pickup", 0 );
                        player val::set( "cyber_emp", "usability", 0 );
                        player thread waitthengivecyberweapon( result == 0 );
                    }
                    
                    if ( result == 0 )
                    {
                        player val::reset_all( "cyber_emp" );
                        return;
                    }
                }
            }
            else if ( var_2c437e7a33abb0f5 )
            {
                player val::set( "cyber_emp", "weapon_switch", 0 );
                player val::set( "cyber_emp", "weapon_pickup", 0 );
                player val::set( "cyber_emp", "usability", 0 );
                player thread waitthengivecyberweapon();
            }
            else if ( isdefined( droppeditem ) )
            {
                previousweapon = player.lastdroppableweaponobj;
            }
            else
            {
                previousweapon = player getcurrentweapon();
            }
        }
        else if ( isdefined( droppeditem ) )
        {
            previousweapon = player.lastdroppableweaponobj;
        }
        else
        {
            previousweapon = player getcurrentweapon();
        }
        
        if ( isdefined( droppeditem ) && !isdefined( droppeditem.objweapon ) )
        {
            droppeditem.objweapon = previousweapon;
        }
        
        graverobberenabled = isdefined( player.perks[ "specialty_scrap_weapons" ] ) && getdvarint( @"perk_graverobber_enabled" ) == 1;
        player thread watchpickupcomplete( weaponobj, previousweapon, graverobberenabled );
        level.onweapondroppickedup callback_group::callback_trigger( self, player, weaponobj );
        player notify( #"weapon_pickup", weaponobj, droppeditem );
        
        if ( isdefined( droppeditem ) )
        {
            player.lastweaponpickuptime = gettime();
            
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
            {
                if ( isdefined( player.leaderboarddata[ "weaponPickups" ] ) )
                {
                    player.leaderboarddata[ "weaponPickups" ] = player.leaderboarddata[ "weaponPickups" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "weaponPickups" ] ) )
                {
                    [[ level.leaderboardfunc[ "weaponPickups" ] ]]( player, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x1c5>" );
                
                if ( isdefined( player.pers[ "weaponPickups" ] ) )
                {
                    player.pers[ "weaponPickups" ] = player.pers[ "weaponPickups" ] + 1;
                }
            }
        }
        
        dirty = weapon::fixupplayerweapons( player, weaponobj );
        
        if ( dirty )
        {
            player gameplay_telemetry::function_3e91d2222fa2419f();
        }
        
        if ( isdefined( droppeditem ) && graverobberenabled )
        {
            droppeditem delete();
        }
        
        if ( isdefined( droppeditem ) || dirty )
        {
            break;
        }
    }
    
    assert( isdefined( player.tookweaponfrom ) );
    
    if ( isdefined( droppeditem ) )
    {
        player weapon_utility::function_cd7fc4f6ba97876c( droppeditem, droppeditem.objweapon );
        droppeditem thread watchpickup( player );
    }
    
    var_2fda11e1ae1629cd = {};
    var_2fda11e1ae1629cd.var_3a1cc6241650f669 = player.tookweaponfrom[ weapname ].var_3a1cc6241650f669 ?? weaponowner;
    var_2fda11e1ae1629cd.var_e01941ff17446ef3 = weaponowner;
    player.tookweaponfrom[ weapname ] = var_2fda11e1ae1629cd;
}

// Namespace weapons
// Params 1
// Checksum 0xae58d65b, Offset: 0x6344
// Size: 0x6e
function waitthengivecyberweapon( var_19f9590509f695d6 )
{
    self endon( #"death_or_disconnect" );
    self notify( #"hash_9565b10d2d1cc7c8" );
    self endon( #"hash_9565b10d2d1cc7c8" );
    
    while ( self.currentweapon.basename == "none" )
    {
        waitframe();
    }
    
    inventory_utility::_giveweapon( "iw9_cyberemp_mp" );
    
    if ( !var_19f9590509f695d6 )
    {
        val::reset_all( "cyber_emp" );
    }
}

// Namespace weapons
// Params 3
// Checksum 0x90ede287, Offset: 0x63ba
// Size: 0x108
function watchpickupcomplete( desiredweapon, previousweapon, graverobberenabled )
{
    self endon( #"death_or_disconnect" );
    self notify( #"hash_ba23ce6c83b5fd10" );
    self endon( #"hash_ba23ce6c83b5fd10" );
    startingweapon = self.currentweapon;
    success = 0;
    
    if ( startingweapon == desiredweapon )
    {
        success = 1;
    }
    else
    {
        while ( true )
        {
            waitframe();
            currentweapon = self.currentweapon;
            
            if ( issameweapon( startingweapon, currentweapon, 0 ) )
            {
                continue;
            }
            
            if ( issameweapon( desiredweapon, currentweapon, 0 ) )
            {
                success = 1;
            }
            else
            {
                success = 0;
            }
            
            break;
        }
    }
    
    if ( success )
    {
        level notify( #"weapon_pickup_success", self, desiredweapon );
        
        if ( weapon::isminigunweapon( desiredweapon ) )
        {
            juggernaut::juggernautweaponpickedup( desiredweapon, previousweapon );
        }
        
        thread notifyuiofpickedupweapon();
    }
    
    if ( utility::callsharedfunc( #"game", #"isCommonItemEnabled" ) )
    {
        item_weapon::function_96add18b226ff731( desiredweapon, 1 );
    }
}

// Namespace weapons
// Params 2
// Checksum 0xdd3d5dea, Offset: 0x64ca
// Size: 0x15
function getrandomgraverobberattachment( currentweapon, var_4c9d638916229e9f )
{
    
}

// Namespace weapons
// Params 2
// Checksum 0x390859a7, Offset: 0x64e8
// Size: 0x2c7
function addattachmenttoweapon( newweapon, newattachment )
{
    variantid = getweaponvariantindex( newweapon );
    newweapon = newweapon getnoaltweapon();
    attachmenttoidmap = newweapon.attachmentvarindices;
    attachments = [];
    
    foreach ( attachment, id in attachmenttoidmap )
    {
        attachments[ attachments.size ] = attachment;
    }
    
    failed = 0;
    
    if ( arraycontains( attachments, newattachment ) )
    {
        failed = 1;
    }
    else if ( !newweapon canuseattachment( newattachment ) )
    {
        failed = 1;
    }
    
    if ( failed )
    {
        return;
    }
    
    attachments = weapon::weaponattachremoveextraattachments( attachments );
    var_c84cf1d3502a1321 = [];
    
    foreach ( idx, attachment in attachments )
    {
        var_c84cf1d3502a1321[ idx ] = attachmenttoidmap[ attachment ];
    }
    
    attachments[ attachments.size ] = newattachment;
    var_c84cf1d3502a1321[ var_c84cf1d3502a1321.size ] = 0;
    camo = newweapon.camo;
    stickers = [];
    
    if ( isdefined( newweapon.stickerslot0 ) )
    {
        stickers[ stickers.size ] = newweapon.stickerslot0;
    }
    
    if ( isdefined( newweapon.stickerslot1 ) )
    {
        stickers[ stickers.size ] = newweapon.stickerslot1;
    }
    
    if ( isdefined( newweapon.stickerslot2 ) )
    {
        stickers[ stickers.size ] = newweapon.stickerslot2;
    }
    
    if ( isdefined( newweapon.stickerslot3 ) )
    {
        stickers[ stickers.size ] = newweapon.stickerslot3;
    }
    
    if ( isdefined( newweapon.var_73762c7cb8b2063 ) )
    {
        stickers[ stickers.size ] = newweapon.var_73762c7cb8b2063;
    }
    
    hasnvg = utility::function_2a082dafe6f4bd5b();
    attachment1slot = getattachmentslot( newweapon, newattachment );
    
    for ( idx = 0; idx < attachments.size ; idx++ )
    {
        attachment2slot = getattachmentslot( newweapon, attachments[ idx ] );
        
        if ( attachment1slot == attachment2slot && attachments[ idx ] != newattachment )
        {
            attachments[ idx ] = undefined;
            
            if ( isint( idx ) )
            {
                function_cdc669dbc8ea2101( attachments );
            }
        }
    }
    
    newweapon = weapon::buildweapon( weapon::getweaponrootname( newweapon ), attachments, camo, "none", variantid, var_c84cf1d3502a1321, undefined, stickers, hasnvg );
    return newweapon;
}

// Namespace weapons
// Params 3
// Checksum 0xa2c3619c, Offset: 0x67b8
// Size: 0xfb
function function_777e95225ed7341c( weaponname, numattachments, var_63f8f8401ad6157e )
{
    var_5d8cc93233d1451a = weaponname;
    newweaponobj = undefined;
    
    if ( !isweapon( weaponname ) )
    {
        var_5d8cc93233d1451a = makeweapon( weaponname );
    }
    
    attachments = function_300b8e06e0756ba5( var_5d8cc93233d1451a, numattachments, var_63f8f8401ad6157e );
    
    foreach ( attachment in attachments )
    {
        newweaponobj = addattachmenttoweapon( var_5d8cc93233d1451a, attachment );
        
        if ( isdefined( newweaponobj ) )
        {
            var_5d8cc93233d1451a = newweaponobj;
        }
        
        /#
            if ( !isdefined( newweaponobj ) )
            {
                iprintlnbold( "<dev string:x1eb>" + weaponname + "<dev string:x1fe>" + attachment );
            }
        #/
    }
    
    return var_5d8cc93233d1451a;
}

// Namespace weapons
// Params 5
// Checksum 0xf730d0f3, Offset: 0x68bc
// Size: 0x29b
function function_300b8e06e0756ba5( weaponobj, numattachments, var_63f8f8401ad6157e, excludeslots, minpriority )
{
    random_attachments = [];
    var_aaed1ea3e5d2ae9a = weapon::function_ea865062f19beca0();
    var_aaed1ea3e5d2ae9a = arrayrandomize( var_aaed1ea3e5d2ae9a );
    
    if ( isdefined( excludeslots ) )
    {
        foreach ( slot in excludeslots )
        {
            if ( arraycontains( var_aaed1ea3e5d2ae9a, slot ) )
            {
                var_aaed1ea3e5d2ae9a = arrayremove( var_aaed1ea3e5d2ae9a, slot );
            }
        }
    }
    
    foreach ( slotkey in var_aaed1ea3e5d2ae9a )
    {
        if ( var_63f8f8401ad6157e && slotkey == "scope" )
        {
            continue;
        }
        
        attachment_array = function_2e5ecdd8ac47f308( weaponobj, slotkey );
        
        if ( attachment_array.size > 0 && random_attachments.size < numattachments )
        {
            if ( isdefined( minpriority ) )
            {
                var_4eab462fa86fe02b = getcompleteweaponname( weaponobj );
                var_ec341faaf8aa5dcd = [];
                
                foreach ( attachment in attachment_array )
                {
                    attachpriority = getattachmentslotpriority( var_4eab462fa86fe02b, attachment );
                    
                    if ( attachpriority < minpriority )
                    {
                        continue;
                    }
                    
                    var_ec341faaf8aa5dcd[ var_ec341faaf8aa5dcd.size ] = attachment;
                }
                
                attachment_array = var_ec341faaf8aa5dcd;
            }
            
            if ( attachment_array.size > 0 )
            {
                arrayindex = randomint( attachment_array.size );
                random_attachments[ random_attachments.size ] = attachment_array[ arrayindex ];
            }
        }
        
        if ( random_attachments.size >= numattachments )
        {
            break;
        }
    }
    
    if ( var_63f8f8401ad6157e )
    {
        array_scope = function_2e5ecdd8ac47f308( weaponobj, "scope" );
        
        if ( array_scope.size > 0 )
        {
            arrayindex = randomint( array_scope.size );
            random_attachments[ random_attachments.size ] = array_scope[ arrayindex ];
            
            if ( random_attachments.size > numattachments )
            {
                random_attachments[ 0 ] = undefined;
                function_cdc669dbc8ea2101( random_attachments );
            }
        }
    }
    
    return random_attachments;
}

// Namespace weapons
// Params 2
// Checksum 0x5491ad1f, Offset: 0x6b60
// Size: 0x1ca
function getammooverride( weaponobj, forceclipsize = 0 )
{
    if ( forceclipsize )
    {
        return weaponclipsize( weaponobj );
    }
    
    baseweapon = weaponobj getbaseweapon();
    baseclipsize = weaponclipsize( baseweapon );
    var_bf7798d24f699644 = weaponclipsize( weaponobj );
    clipsize = baseclipsize;
    
    if ( getweaponhasperk( weaponobj, "specialty_smags" ) )
    {
        clipsize = int( max( baseclipsize, var_bf7798d24f699644 ) );
    }
    
    rootname = weapon::getweaponrootname( weaponobj );
    ammooverride = 30;
    
    if ( weaponobj.isalternate )
    {
    }
    else
    {
        switch ( weaponobj.classname )
        {
            case #"hash_690c0d6a821b42e":
                switch ( rootname )
                {
                    case #"hash_30551216cbfc3a26":
                        ammooverride = 6;
                        break;
                    case #"hash_68a11d587d71608f":
                        ammooverride = 8;
                        break;
                    default:
                        ammooverride = int( min( clipsize, 30 ) );
                        break;
                }
                
                break;
            case #"hash_6191aaef9f922f96":
                switch ( rootname )
                {
                    case #"hash_8d9ae5e5dd390b4b":
                        ammooverride = 3;
                        break;
                    case #"hash_ed18de054b1e0b57":
                        ammooverride = 7;
                        break;
                    case #"hash_4cf812ccab9e4993":
                        if ( weaponobj hasattachment( "sat_ub_crossbar_sn_baltic" ) )
                        {
                            ammooverride = 100;
                        }
                        else
                        {
                            ammooverride = int( min( clipsize, 30 ) );
                        }
                        
                        break;
                    default:
                        ammooverride = int( min( clipsize, 30 ) );
                        break;
                }
                
                break;
            default:
                ammooverride = int( min( clipsize, 30 ) );
                break;
        }
    }
    
    return ammooverride;
}

// Namespace weapons
// Params 0
// Checksum 0x11fa8a0f, Offset: 0x6d33
// Size: 0x2
function notifyuiofpickedupweapon()
{
    
}

// Namespace weapons
// Params 0
// Checksum 0xe89e83d5, Offset: 0x6d3d
// Size: 0x63
function itemremoveammofromaltmodes()
{
    var_f90a2383b1e75f89 = getcompleteweaponname( self.objweapon );
    var_a336b672bf5a3f96 = weaponaltweaponname( var_f90a2383b1e75f89 );
    
    for ( altindex = 1; var_a336b672bf5a3f96 != "none" && var_a336b672bf5a3f96 != var_f90a2383b1e75f89 ; altindex++ )
    {
        self itemweaponsetammo( 0, 0, 0, altindex );
        var_a336b672bf5a3f96 = weaponaltweaponname( var_a336b672bf5a3f96 );
    }
}

// Namespace weapons
// Params 2
// Checksum 0x97a4663c, Offset: 0x6da8
// Size: 0x76
function function_edc8b4335dbc2596( attacker, meansofdeath )
{
    self endon( #"spawned_player" );
    level endon( #"game_ended" );
    
    if ( !function_8fdfeaee1addd1cf( attacker, meansofdeath ) )
    {
        return;
    }
    
    if ( isdefined( meansofdeath ) && ( meansofdeath == "MOD_EXECUTION" || meansofdeath == "MOD_MELEE_TAKEDOWN" ) )
    {
        wait 1.5;
        
        if ( !function_8fdfeaee1addd1cf( attacker, meansofdeath ) )
        {
            return;
        }
    }
    
    thread function_7dfc43a5e39b596b( attacker );
}

// Namespace weapons
// Params 2
// Checksum 0x2334a6d4, Offset: 0x6e26
// Size: 0x35, Type: bool
function function_8fdfeaee1addd1cf( attacker, meansofdeath )
{
    if ( !isdefined( attacker ) )
    {
        return false;
    }
    
    if ( attacker == self )
    {
        return false;
    }
    
    if ( !isplayer( attacker ) )
    {
        return false;
    }
    
    return true;
}

// Namespace weapons
// Params 1
// Checksum 0x84d24dfb, Offset: 0x6e64
// Size: 0xd7
function function_7dfc43a5e39b596b( attacker )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    droparmor = self dropscavengerbag( "armor_mp", "j_head" );
    
    if ( !isdefined( droparmor ) )
    {
        return;
    }
    
    droparmor endon( #"death", #"armorRemoved" );
    droparmor ent_manager::registerspawn( 2, &function_69d73eabcee26b57 );
    droparmor setusableenabled( 0 );
    droparmor showonlytoplayer( attacker );
    droparmor.owner = attacker;
    droparmor.team = attacker.team;
    droparmor.count = 1;
    droparmor thread function_693deade46811c50();
    droparmor thread function_1cfae81d070fb581();
    droparmor thread armortimeoutthink();
    droparmor thread function_25002fc05092781c();
    outline::outlineenableforplayer( droparmor, attacker, "shimmer_default", "level_script" );
}

// Namespace weapons
// Params 1
// Checksum 0xd5fa1b6a, Offset: 0x6f43
// Size: 0x22
function armoronuse( player )
{
    self.armorref notify( #"scavenger", player );
}

// Namespace weapons
// Params 0
// Checksum 0x8b21daaf, Offset: 0x6f6d
// Size: 0x1c4
function function_693deade46811c50()
{
    self endon( #"armorRemoved" );
    level endon( #"game_ended" );
    player = undefined;
    
    while ( true )
    {
        self waittill( #"scavenger_armor", player );
        assert( isdefined( player ) );
        
        if ( player == self.owner && !player vehicle::is_in_vehicle() )
        {
            break;
        }
    }
    
    player = self.owner;
    player notify( #"armor_pickup" );
    player function_6b25350e3eb96bfa( self );
    
    if ( !isdefined( player.pers[ "armorPickedUp" ] ) )
    {
        player.pers[ "armorPickedUp" ] = 0;
    }
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
    {
        if ( isdefined( player.leaderboarddata[ "armorPickedUp" ] ) )
        {
            player.leaderboarddata[ "armorPickedUp" ] = player.leaderboarddata[ "armorPickedUp" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "armorPickedUp" ] ) )
        {
            [[ level.leaderboardfunc[ "armorPickedUp" ] ]]( player, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x1c5>" );
        
        if ( isdefined( player.pers[ "armorPickedUp" ] ) )
        {
            player.pers[ "armorPickedUp" ] = player.pers[ "armorPickedUp" ] + 1;
        }
    }
    
    if ( isdefined( self.useobj ) )
    {
        self.useobj delete();
    }
    
    self notify( #"death" );
    self notify( #"armorRemoved" );
}

// Namespace weapons
// Params 1
// Checksum 0xda99b572, Offset: 0x7139
// Size: 0x112
function function_6b25350e3eb96bfa( armor )
{
    if ( br_pickups::pickupissameasequipmentslot( level.armorref ?? "equip_armorplate", "health" ) )
    {
        if ( isdefined( self.perks[ "specialty_fast_armor" ] ) && isdefined( self.armorhealth ) && isdefined( self.maxarmorhealth ) && self.armorhealth < self.maxarmorhealth )
        {
            result = perkfunctions::function_4cd566e687b2f810( armor );
            
            if ( result == 1 )
            {
                return 1;
            }
        }
        
        if ( function_f70fe4ac9d3d3e84() )
        {
            equipment_mp::incrementequipmentslotammo( "health", 1 );
            return 1;
        }
        else
        {
            return 0;
        }
        
        return;
    }
    
    if ( !isdefined( self.equipment[ "health" ] ) || equipment_mp::getequipmentslotammo( "health" ) == 0 )
    {
        equipment_mp::giveequipment( level.armorref ?? "equip_armorplate", "health" );
        equipment_mp::setequipmentammo( level.armorref ?? "equip_armorplate", 1 );
        return 1;
    }
    
    return 0;
}

// Namespace weapons
// Params 0
// Checksum 0x7f72b939, Offset: 0x7253
// Size: 0x33
function function_69d73eabcee26b57()
{
    if ( isdefined( self.useobj ) )
    {
        self.useobj delete();
    }
    
    if ( self )
    {
        self notify( #"armorRemoved" );
        self delete();
    }
}

// Namespace weapons
// Params 0
// Checksum 0x86c0fcce, Offset: 0x728e
// Size: 0x68
function function_1cfae81d070fb581()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    utility::waittill_any( "armorRemoved", "armor_timeout" );
    
    if ( isdefined( self ) )
    {
        if ( isdefined( self.useobj ) )
        {
            self.useobj delete();
        }
        
        ent_manager::deregisterspawn();
        
        if ( self )
        {
            self notify( #"armorRemoved" );
            self delete();
        }
    }
}

// Namespace weapons
// Params 0
// Checksum 0x510606eb, Offset: 0x72fe
// Size: 0x42
function armortimeoutthink()
{
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    level endon( #"game_ended" );
    wait 30;
    
    if ( isdefined( self ) )
    {
        self notify( #"armor_timeout" );
    }
}

// Namespace weapons
// Params 0
// Checksum 0xe16f3411, Offset: 0x7348
// Size: 0x34
function function_25002fc05092781c()
{
    self endon( #"armorRemoved" );
    level endon( #"game_ended" );
    self waittill( #"death" );
    waittillframeend();
    self notify( #"armorRemoved" );
}

// Namespace weapons
// Params 0
// Checksum 0x6ef5db1e, Offset: 0x7384
// Size: 0x2c, Type: bool
function function_f70fe4ac9d3d3e84()
{
    if ( equipment_mp::getequipmentslotammo( "health" ) < equipment_mp::getequipmentmaxammo( level.armorref ?? "equip_armorplate" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace weapons
// Params 2
// Checksum 0x6052d898, Offset: 0x73b9
// Size: 0xb4
function useholdthink( player, usetime )
{
    self.curprogress = 0;
    self.inuse = 1;
    self.userate = 0;
    self.usetime = usetime;
    movers::script_mover_link_to_use_object( player );
    player val::set( "useHold", "weapon", 0 );
    result = useholdthinkloop( player );
    
    if ( isalive( player ) )
    {
        player val::reset_all( "useHold" );
    }
    
    if ( isdefined( player ) )
    {
        movers::script_mover_unlink_from_use_object( player );
    }
    
    if ( !isdefined( self ) )
    {
        return 0;
    }
    
    self.inuse = 0;
    self.curprogress = 0;
    return result;
}

// Namespace weapons
// Params 1
// Checksum 0xca0e369c, Offset: 0x7476
// Size: 0x33, Type: bool
function useholdthinkloop( player )
{
    result = internal_useholdthinkloop( player );
    
    if ( isdefined( self ) )
    {
        player gameobjects::updateuiprogress( self, 0 );
    }
    
    return istrue( result );
}

// Namespace weapons
// Params 1
// Checksum 0x98f323ba, Offset: 0x74b2
// Size: 0xb9, Type: bool
function internal_useholdthinkloop( player )
{
    self endon( #"hash_ec4b1720aa8f8b98" );
    
    while ( player isplayerusing( self ) )
    {
        if ( !player movers::script_mover_use_can_link( self ) )
        {
            return false;
        }
        
        self.curprogress += level.framedurationseconds * self.userate;
        
        if ( isdefined( self.objectivescaler ) )
        {
            self.userate = 1 * self.objectivescaler;
        }
        else
        {
            self.userate = 1;
        }
        
        player gameobjects::updateuiprogress( self, 1 );
        
        if ( self.curprogress >= self.usetime )
        {
            return player::isreallyalive( player );
        }
        
        waitframe();
    }
    
    return false;
}

// Namespace weapons
// Params 0
// Checksum 0xee7eeba, Offset: 0x7574
// Size: 0x90
function createuseent()
{
    useent = spawn( "script_origin", self.origin );
    useent.targetname = "createUseEnt";
    useent.curprogress = 0;
    useent.usetime = 0;
    useent.userate = 3000;
    useent.inuse = 0;
    useent.id = self.id;
    useent linkto( self );
    useent thread deleteuseent( self );
    return useent;
}

// Namespace weapons
// Params 1
// Checksum 0x1c20f2ed, Offset: 0x760d
// Size: 0xc5
function deleteuseent( owner )
{
    self endon( #"death" );
    owner waittill( #"death" );
    
    if ( isdefined( self.usedby ) )
    {
        foreach ( player in self.usedby )
        {
            player setclientomnvar( "ui_securing", 0 );
            player.ui_securing = undefined;
        }
    }
    
    if ( self )
    {
        self delete();
    }
}

// Namespace weapons
// Params 1
// Checksum 0x59d44832, Offset: 0x76da
// Size: 0x6e, Type: bool
function isplayerusing( weapon )
{
    return !level.gameended && isdefined( weapon ) && player::isreallyalive( self ) && self usebuttonpressed() && !self isonladder() && !self meleebuttonpressed() && weapon.curprogress < weapon.usetime && !self.teleporting;
}

// Namespace weapons
// Params 2
// Checksum 0x68fda441, Offset: 0x7751
// Size: 0x47, Type: bool
function weaponcanstoreaccuracystats( objweapon, weapongroup = weapon::getweapongroup( objweapon ) )
{
    if ( weapon::iscacmeleeweapon( objweapon, weapongroup ) )
    {
        return false;
    }
    
    return weapon::iscacprimaryweapongroup( weapongroup ) || weapon::iscacsecondaryweapongroup( weapongroup, objweapon );
}

// Namespace weapons
// Params 1
// Checksum 0xf8097b23, Offset: 0x77a1
// Size: 0xd5
function watchweaponusage( weaponhand )
{
    self endon( #"death_or_disconnect", #"faux_spawn" );
    level endon( #"game_ended" );
    
    for ( ;; )
    {
        self waittill( #"weapon_fired", objweapon );
        
        switch ( weaponclass( objweapon ) )
        {
            case #"hash_61e969dacaaf9881":
                continue;
            case #"hash_e224d0b635d0dadd":
                if ( issubstr( objweapon.basename, "la_mike32" ) )
                {
                    continue;
                }
                
                break;
        }
        
        if ( weapon::function_d4dcd88477cfa8ca( objweapon.basenamehash ) )
        {
            continue;
        }
        
        if ( isdefined( level.var_86f911ce75014794 ) && level.var_86f911ce75014794[ objweapon.basename ] )
        {
            continue;
        }
        
        onweaponfired( objweapon );
    }
}

// Namespace weapons
// Params 2
// Checksum 0x37fe2358, Offset: 0x787e
// Size: 0x2b2
function onweaponfired( objweapon, missileent )
{
    gamelogic_mp::sethasdonecombat( self, 1 );
    self.lastshotfiredtime = gettime();
    
    if ( objweapon.killstreakdeploycategory == #"none" && !objweapon issilenced() )
    {
        self.var_5a4003bfe509b071 = self.lastshotfiredtime;
    }
    
    codcasterclientmatchdata::function_35da766061f19c58( 0, 1 );
    
    if ( !isdefined( self.pers[ "shotsFired" ] ) )
    {
        self.pers[ "shotsFired" ] = 0;
    }
    
    var_663e36b24edc4251 = utility::getsharedfunc( #"shot_trace", #"hash_480a3c5f1868a487" );
    
    if ( var_663e36b24edc4251 )
    {
        foreach ( user in level.var_9aa8bcd75d91c871 )
        {
            if ( user != self )
            {
                user thread [[ var_663e36b24edc4251 ]]( self );
            }
        }
    }
    
    params = { #objweapon:objweapon };
    callback::callback( #"player_weapon_fire", params );
    
    if ( isai( self ) )
    {
        if ( level.var_43517c54ad74e3aa )
        {
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "shotsFired" ] ) )
                {
                    self.leaderboarddata[ "shotsFired" ] = self.leaderboarddata[ "shotsFired" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "shotsFired" ] ) )
                {
                    [[ level.leaderboardfunc[ "shotsFired" ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x1c5>" );
                
                if ( isdefined( self.pers[ "shotsFired" ] ) )
                {
                    self.pers[ "shotsFired" ] = self.pers[ "shotsFired" ] + 1;
                }
            }
        }
        
        var_bda53394c108f2e = getcompleteweaponname( objweapon );
        
        if ( issubstr( var_bda53394c108f2e, "jup_jp22_la_dromeo" ) )
        {
            self setweaponammoclip( objweapon, 999 );
            isoutbreak = game_utility::getgametype() == "ob";
            
            if ( isoutbreak )
            {
                thread drone_launcher::function_8ad2a1f5e1172a3b( objweapon, missileent );
            }
            else
            {
                thread drone_launcher::function_38bca77bc997c0f7( objweapon, missileent );
            }
        }
    }
    else
    {
        thread processactiveshots( objweapon, missileent );
    }
    
    thread namespace_4c6ef5221f3fa284::trylogcombatinstanceshot( objweapon );
}

// Namespace weapons
// Params 2
// Checksum 0x2d5f0f27, Offset: 0x7b38
// Size: 0x376
function processactiveshots( objweapon, missileent )
{
    self endon( #"disconnect" );
    var_bda53394c108f2e = getcompleteweaponname( objweapon );
    notifystring = "processActiveShots_" + var_bda53394c108f2e;
    self notify( notifystring );
    self endon( notifystring );
    
    if ( !isdefined( self.activeshots[ var_bda53394c108f2e ] ) )
    {
        self.activeshots[ var_bda53394c108f2e ] = 0;
    }
    
    self.activeshots[ var_bda53394c108f2e ]++;
    
    if ( !isdefined( self.activemissiles ) )
    {
        self.activemissiles = [];
    }
    
    self.endmatchstats[ "totalShots" ] = ( self.endmatchstats[ "totalShots" ] ?? 0 ) + 1;
    
    if ( issubstr( var_bda53394c108f2e, "jup_jp22_la_dromeo" ) )
    {
        self setweaponammoclip( objweapon, 999 );
        thread drone_launcher::function_38bca77bc997c0f7( objweapon, missileent );
    }
    
    if ( isdefined( missileent ) )
    {
        if ( !isdefined( self.activemissiles[ var_bda53394c108f2e ] ) )
        {
            self.activemissiles[ var_bda53394c108f2e ] = [];
        }
        
        foreach ( var_38582dfb49b5e2e2, misslearray in self.activemissiles )
        {
            self.activemissiles[ var_38582dfb49b5e2e2 ] = function_46f9072493651dc9( misslearray );
        }
        
        self.activemissiles[ var_bda53394c108f2e ][ self.activemissiles[ var_bda53394c108f2e ].size ] = missileent;
    }
    
    gamelogic_mp::setweaponstat( objweapon, 1, "shots" );
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
    {
        if ( isdefined( self.leaderboarddata[ "shotsFired" ] ) )
        {
            self.leaderboarddata[ "shotsFired" ] = self.leaderboarddata[ "shotsFired" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "shotsFired" ] ) )
        {
            [[ level.leaderboardfunc[ "shotsFired" ] ]]( self, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x1c5>" );
        
        if ( isdefined( self.pers[ "shotsFired" ] ) )
        {
            self.pers[ "shotsFired" ] = self.pers[ "shotsFired" ] + 1;
        }
    }
    
    weaponname = objweapon.basename;
    
    if ( !isdefined( self.pers[ "weap_shotFired" ][ weaponname ] ) )
    {
        self.pers[ "weap_shotFired" ][ weaponname ] = 0;
    }
    
    self.pers[ "weap_shotFired" ][ weaponname ]++;
    var_f485a2c9a458e19a = self.pers[ "weap_shotFired" ][ weaponname ];
    shothit = self.pers[ "weap_shotHit" ][ weaponname ] ?? 0;
    var_cef9affae1f4ddd3 = shothit / max( var_f485a2c9a458e19a, 1 ) * 100;
    thread gameplay_telemetry::function_83a6a8db9fcbb065( "weap_accuracy", objweapon.basename, 15, var_cef9affae1f4ddd3 );
    params = { #objweapon:objweapon };
    callback::callback( #"hash_474490f7ce8b74d0", params );
    watchformiss( objweapon, var_bda53394c108f2e );
    function_9cb486eaa036e4c2( objweapon, var_bda53394c108f2e );
}

// Namespace weapons
// Params 2, eflags: 0x4
// Checksum 0x37bcf4f1, Offset: 0x7eb6
// Size: 0x2d4
function private function_9cb486eaa036e4c2( objweapon, var_bda53394c108f2e )
{
    weapongroup = weapon::function_820c0dca2415bd8( objweapon );
    totalshots = self.activeshots[ var_bda53394c108f2e ];
    hitshots = self.hits[ var_bda53394c108f2e ] ?? 0;
    var_e8bbd2922b0e3779 = self.agenthits[ var_bda53394c108f2e ] ?? 0;
    var_6bcd5139db5b3e1 = self.playerhits[ var_bda53394c108f2e ] ?? 0;
    var_564bddeb755ce345 = self.bothits[ var_bda53394c108f2e ] ?? 0;
    missedshots = totalshots - hitshots;
    
    if ( !isdefined( self.pers[ "telemetry" ].player_hits ) )
    {
        self.pers[ "telemetry" ].player_hits = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].bot_hits ) )
    {
        self.pers[ "telemetry" ].bot_hits = 0;
    }
    
    if ( !isdefined( self.pers[ "telemetry" ].agent_hits ) )
    {
        self.pers[ "telemetry" ].agent_hits = 0;
    }
    
    self.pers[ "telemetry" ].player_hits = self.pers[ "telemetry" ].player_hits + var_6bcd5139db5b3e1 - var_564bddeb755ce345;
    self.pers[ "telemetry" ].bot_hits = self.pers[ "telemetry" ].bot_hits + var_564bddeb755ce345;
    self.pers[ "telemetry" ].agent_hits = self.pers[ "telemetry" ].agent_hits + var_e8bbd2922b0e3779;
    
    if ( weaponcanstoreaccuracystats( objweapon, weapongroup ) )
    {
        gamelogic_mp::setweaponstat( objweapon, hitshots, "hits" );
        gamelogic_mp::setweaponstat( objweapon, var_e8bbd2922b0e3779, "ai_hits" );
        gamelogic_mp::setweaponstat( objweapon, var_6bcd5139db5b3e1, "player_hits" );
        
        if ( game_utility_mp::onlinestatsenabled() )
        {
            playerstats_interface::addtoplayerstatbuffered( totalshots, "combatStats", "totalShots" );
            playerstats_interface::addtoplayerstatbuffered( missedshots, "combatStats", "misses" );
        }
    }
    
    events::shotmissed( totalshots, hitshots );
    self.activeshots[ var_bda53394c108f2e ] = 0;
    self.hits[ var_bda53394c108f2e ] = 0;
    self.agenthits[ var_bda53394c108f2e ] = 0;
    self.playerhits[ var_bda53394c108f2e ] = 0;
    self.bothits[ var_bda53394c108f2e ] = 0;
    
    if ( isdefined( self.activemissiles[ var_bda53394c108f2e ] ) )
    {
        self.activemissiles[ var_bda53394c108f2e ] = [];
    }
}

// Namespace weapons
// Params 2, eflags: 0x4
// Checksum 0xf11bd371, Offset: 0x8192
// Size: 0xd4
function private watchformiss( objweapon, var_bda53394c108f2e )
{
    self endon( #"disconnect" );
    
    if ( isdefined( self.activemissiles[ var_bda53394c108f2e ] ) )
    {
        while ( true )
        {
            activemissiles = 0;
            
            foreach ( missile in self.activemissiles[ var_bda53394c108f2e ] )
            {
                if ( isdefined( missile ) )
                {
                    activemissiles++;
                }
            }
            
            if ( activemissiles == 0 )
            {
                break;
            }
            
            waitframe();
        }
        
        return;
    }
    
    wait 6;
}

// Namespace weapons
// Params 0
// Checksum 0x4cfa09c5, Offset: 0x826e
// Size: 0x4b
function watchfornearmisswhizby()
{
    self endon( #"death_or_disconnect", #"faux_spawn" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"attackerbulletwhizby" );
        playerstats_interface::addtoplayerstatbuffered( 1, "combatStats", "nearMisses" );
    }
}

// Namespace weapons
// Params 7
// Checksum 0x715f36aa, Offset: 0x82c1
// Size: 0x92f
function checkhit( objweapon, einflictor, victim, shitloc, idamage, weapongroup, smeansofdeath )
{
    self endon( #"disconnect" );
    
    if ( issimulationplayer( self ) )
    {
        return;
    }
    
    var_bda53394c108f2e = getcompleteweaponname( objweapon );
    
    if ( objweapon.isalternate )
    {
        attachmentshash = objweapon.attachmentshash;
        
        if ( arraycontains( attachmentshash, %"shotgun" ) || arraycontains( attachmentshash, %"gl" ) || arraycontains( attachmentshash, %"glsmoke" ) || arraycontains( attachmentshash, %"hash_5b3947e74154e87e" ) || arraycontains( attachmentshash, %"hash_3e65e4d17a5a9c24" ) || arraycontains( attachmentshash, %"hash_6cb20acfc976c49d" ) || arraycontains( attachmentshash, %"hash_79058544ef505b97" ) || arraycontains( attachmentshash, %"hash_6008dd373e12472d" ) || arraycontains( attachmentshash, %"hash_6087a64d4c29c5b1" ) )
        {
            self.hits[ var_bda53394c108f2e ] = 1;
            
            if ( isdefined( victim ) )
            {
                if ( isagent( victim ) )
                {
                    self.agenthits[ var_bda53394c108f2e ] = 1;
                }
                else if ( isplayer( victim ) )
                {
                    self.playerhits[ var_bda53394c108f2e ] = 1;
                }
            }
        }
    }
    
    if ( !isdefined( weapongroup ) )
    {
        weapongroup = weapon::getweapongroup( objweapon );
    }
    
    if ( !weaponcanstoreaccuracystats( objweapon, weapongroup ) )
    {
        return;
    }
    
    is_melee_button_pressed = self meleebuttonpressed();
    
    if ( is_melee_button_pressed && objweapon.basename != "iw8_knife_mp" )
    {
        return;
    }
    
    if ( !class::ismeleeweapon( objweapon ) && utility::ismeleedamage( smeansofdeath ) )
    {
        return;
    }
    
    if ( !isdefined( self.hits[ var_bda53394c108f2e ] ) )
    {
        self.hits[ var_bda53394c108f2e ] = 0;
    }
    
    if ( !isdefined( self.agenthits[ var_bda53394c108f2e ] ) )
    {
        self.agenthits[ var_bda53394c108f2e ] = 0;
    }
    
    if ( !isdefined( self.playerhits[ var_bda53394c108f2e ] ) )
    {
        self.playerhits[ var_bda53394c108f2e ] = 0;
    }
    
    if ( !isdefined( self.bothits[ var_bda53394c108f2e ] ) )
    {
        self.bothits[ var_bda53394c108f2e ] = 0;
    }
    
    switch ( weaponclass( objweapon ) )
    {
        case #"hash_6191aaef9f922f96":
        case #"hash_719417cb1de832b6":
        case #"hash_8cdaf2e4ecfe5b51":
        case #"hash_900cb96c552c5e8e":
        case #"hash_fa24dff6bd60a12d":
            self.hits[ var_bda53394c108f2e ]++;
            
            if ( isplayer( victim ) )
            {
                self.playerhits[ var_bda53394c108f2e ]++;
                
                if ( isbot( victim ) )
                {
                    self.bothits[ var_bda53394c108f2e ]++;
                }
            }
            else if ( isagent( victim ) )
            {
                self.agenthits[ var_bda53394c108f2e ]++;
            }
            
            break;
        case #"hash_690c0d6a821b42e":
            if ( !isdefined( self.var_39a2b93c1dbac9f0 ) )
            {
                self.var_39a2b93c1dbac9f0 = { #maxshot:0, #hitcounter:0, #shots:[] };
            }
            
            shotindex = self.pers[ "weap_shotFired" ][ objweapon.basename ] ?? 0;
            
            if ( self.var_39a2b93c1dbac9f0.maxshot < shotindex )
            {
                self.var_39a2b93c1dbac9f0.maxshot = shotindex;
                self.var_39a2b93c1dbac9f0.hitcounter++;
            }
            
            hitcount = self.var_39a2b93c1dbac9f0.hitcounter;
            var_19f0a73acf49d85e = hitcount % 20;
            
            if ( !isdefined( self.var_39a2b93c1dbac9f0.shots[ var_19f0a73acf49d85e ] ) )
            {
                self.var_39a2b93c1dbac9f0.shots[ var_19f0a73acf49d85e ] = {};
            }
            
            var_1f95af808c5dc83a = self.var_39a2b93c1dbac9f0.shots[ var_19f0a73acf49d85e ];
            var_45dd59f6a080706c = ( hitcount + 10 ) % 20;
            self.var_39a2b93c1dbac9f0.shots[ var_45dd59f6a080706c ] = undefined;
            isplayer = isplayer( victim );
            isbot = isbot( victim );
            var_9190fd161e51822d = !var_1f95af808c5dc83a.hitcounted;
            var_ba0d51f7f8e26172 = isplayer && !var_1f95af808c5dc83a.var_f0838760f3e04dc6;
            var_9b1643b456aaeeda = isplayer && isbot && !var_1f95af808c5dc83a.var_974374cba436a4aa;
            var_bc1bbbdc80144f0e = !isplayer && !isbot && isagent( victim ) && !var_1f95af808c5dc83a.var_b1ffaef71a3a3f1e;
            
            if ( var_9190fd161e51822d )
            {
                self.hits[ var_bda53394c108f2e ] += 1;
                var_1f95af808c5dc83a.hitcounted = 1;
            }
            
            if ( var_ba0d51f7f8e26172 )
            {
                self.playerhits[ var_bda53394c108f2e ] += 1;
                var_1f95af808c5dc83a.var_f0838760f3e04dc6 = 1;
            }
            
            if ( var_9b1643b456aaeeda )
            {
                self.bothits[ var_bda53394c108f2e ] += 1;
                var_1f95af808c5dc83a.var_974374cba436a4aa = 1;
            }
            
            if ( var_bc1bbbdc80144f0e )
            {
                self.agenthits[ var_bda53394c108f2e ] += 1;
                var_1f95af808c5dc83a.var_b1ffaef71a3a3f1e = 1;
            }
            
            break;
        case #"hash_61e969dacaaf9881":
        case #"hash_e224d0b635d0dadd":
            if ( einflictor )
            {
                if ( !isdefined( einflictor.var_1f95af808c5dc83a ) )
                {
                    einflictor.var_1f95af808c5dc83a = {};
                }
                
                var_1f95af808c5dc83a = einflictor.var_1f95af808c5dc83a;
                isplayer = isplayer( victim );
                isbot = isbot( victim );
                var_9190fd161e51822d = !var_1f95af808c5dc83a.hitcounted;
                var_ba0d51f7f8e26172 = isplayer && !var_1f95af808c5dc83a.var_f0838760f3e04dc6;
                var_9b1643b456aaeeda = isplayer && isbot && !var_1f95af808c5dc83a.var_974374cba436a4aa;
                var_bc1bbbdc80144f0e = !isplayer && !isbot && isagent( victim ) && !var_1f95af808c5dc83a.var_b1ffaef71a3a3f1e;
                
                if ( var_9190fd161e51822d )
                {
                    self.hits[ var_bda53394c108f2e ] += 1;
                    var_1f95af808c5dc83a.hitcounted = 1;
                }
                
                if ( var_ba0d51f7f8e26172 )
                {
                    self.playerhits[ var_bda53394c108f2e ] += 1;
                    var_1f95af808c5dc83a.var_f0838760f3e04dc6 = 1;
                }
                
                if ( var_9b1643b456aaeeda )
                {
                    self.bothits[ var_bda53394c108f2e ] += 1;
                    var_1f95af808c5dc83a.var_974374cba436a4aa = 1;
                }
                
                if ( var_bc1bbbdc80144f0e )
                {
                    self.agenthits[ var_bda53394c108f2e ] += 1;
                    var_1f95af808c5dc83a.var_b1ffaef71a3a3f1e = 1;
                }
            }
            
            break;
        default:
            break;
    }
    
    if ( weapon_utility::isriotshieldobject( objweapon ) || objweapon.basename == "iw8_knife_mp" )
    {
        thread gamelogic_mp::threadedsetweaponstatbyname( objweapon, self.hits[ var_bda53394c108f2e ], "hits" );
        self.hits[ var_bda53394c108f2e ] = 0;
        thread gamelogic_mp::threadedsetweaponstatbyname( objweapon, self.agenthits[ var_bda53394c108f2e ], "ai_hits" );
        self.agenthits[ var_bda53394c108f2e ] = 0;
        thread gamelogic_mp::threadedsetweaponstatbyname( objweapon, self.playerhits[ var_bda53394c108f2e ], "player_hits" );
        self.playerhits[ var_bda53394c108f2e ] = 0;
    }
    
    if ( !is_melee_button_pressed )
    {
        codcasterclientmatchdata::function_35da766061f19c58( 1, 1 );
    }
    
    if ( !isdefined( self.lasthittime[ var_bda53394c108f2e ] ) )
    {
        self.lasthittime[ var_bda53394c108f2e ] = 0;
    }
    
    currenttime = gettime();
    
    if ( self.lasthittime[ var_bda53394c108f2e ] == currenttime )
    {
        return;
    }
    
    self.lasthittime[ var_bda53394c108f2e ] = currenttime;
    
    if ( game_utility_mp::onlinestatsenabled() )
    {
        totalshots = playerstats_interface::getplayerstat( "combatStats", "totalShots" );
        hits = playerstats_interface::getplayerstat( "combatStats", "hits" ) + 1;
        
        if ( hits <= totalshots )
        {
            playerstats_interface::setplayerstatbuffered( hits, "combatStats", "hits" );
            playerstats_interface::setplayerstatbuffered( int( totalshots - hits ), "combatStats", "misses" );
        }
    }
    
    thread events::shothit();
    thread namespace_4c6ef5221f3fa284::function_788c4ebdd65b5c58( victim, shitloc, idamage );
    
    if ( weapongroup == "weapon_lmg" )
    {
        if ( !isdefined( self.shotslandedlmg ) )
        {
            self.shotslandedlmg = 1;
        }
        else
        {
            self.shotslandedlmg++;
        }
    }
    
    self.pers[ "lastDamageTime" ] = currenttime;
    
    if ( isdefined( victim ) )
    {
        victim.lasttimedamaged = currenttime;
        
        if ( victim.hasresolute && !player::isinlaststand( victim ) )
        {
            victim.lastshottime = currenttime;
            victim notify( #"resolute_shot" );
        }
    }
}

// Namespace weapons
// Params 4
// Checksum 0x3c77a249, Offset: 0x8bf8
// Size: 0x115, Type: bool
function friendlyfirecheck( owner, attacker, forcedfriendlyfirerule, forced )
{
    if ( !( isdefined( owner ) && isdefined( owner.team ) ) )
    {
        return true;
    }
    
    if ( !level.teambased )
    {
        return true;
    }
    
    friendlyfirerule = level.friendlyfire;
    
    if ( isdefined( forcedfriendlyfirerule ) )
    {
        friendlyfirerule = forcedfriendlyfirerule;
    }
    
    if ( friendlyfirerule != 0 )
    {
        return true;
    }
    
    if ( attacker == owner || attacker.owner == owner )
    {
        return true;
    }
    
    attackerteam = undefined;
    
    if ( isdefined( attacker.owner ) )
    {
        attackerteam = attacker.owner.team;
    }
    else if ( isdefined( attacker.team ) )
    {
        attackerteam = attacker.team;
    }
    
    if ( !isdefined( attackerteam ) )
    {
        return true;
    }
    
    if ( attackerteam != owner.team )
    {
        return true;
    }
    
    if ( attacker.var_f8f3389a826c5d19 )
    {
        return true;
    }
    
    return false;
}

// Namespace weapons
// Params 0
// Checksum 0x71e2a0, Offset: 0x8d16
// Size: 0x88
function watchequipmentonspawn()
{
    self notify( #"hash_bf537236b20f6249" );
    self endon( #"hash_bf537236b20f6249" );
    self endon( #"spawned_player", #"disconnect", #"faux_spawn" );
    deletedisparateplacedequipment();
    var_38aaae91731d75c1 = dvars::getintproperty( @"scr_deleteexplosivesonspawn", 1 ) && ( !isdefined( self.perks[ "specialty_rugged_eqp" ] ) || !checkequipforrugged() );
    
    if ( var_38aaae91731d75c1 )
    {
        deleteplacedequipment();
    }
}

// Namespace weapons
// Params 0
// Checksum 0x6aa581e3, Offset: 0x8da6
// Size: 0x41
function getallequip()
{
    allequip = arraycombine( self.plantedlethalequip, self.plantedtacticalequip, self.var_68db24a5acce8b08, self.plantedsuperequip, self.plantedhackedequip );
    return allequip;
}

// Namespace weapons
// Params 1
// Checksum 0xae4b5c46, Offset: 0x8df0
// Size: 0xd2
function removeequip( equip )
{
    if ( isdefined( self.plantedlethalequip ) )
    {
        self.plantedlethalequip = arrayremove( self.plantedlethalequip, equip );
    }
    
    if ( isdefined( self.plantedtacticalequip ) )
    {
        self.plantedtacticalequip = arrayremove( self.plantedtacticalequip, equip );
    }
    
    if ( level.var_613ba3e28ca2d235 && isdefined( self.var_68db24a5acce8b08 ) )
    {
        self.var_68db24a5acce8b08 = arrayremove( self.var_68db24a5acce8b08, equip );
    }
    
    if ( isdefined( self.plantedsuperequip ) )
    {
        self.plantedsuperequip = arrayremove( self.plantedsuperequip, equip );
    }
    
    if ( isdefined( self.plantedhackedequip ) )
    {
        self.plantedhackedequip = arrayremove( self.plantedhackedequip, equip );
    }
}

// Namespace weapons
// Params 0
// Checksum 0xd93001c7, Offset: 0x8eca
// Size: 0xa7, Type: bool
function checkequipforrugged()
{
    equipment = arraycombine( self.plantedtacticalequip, self.plantedlethalequip, self.var_68db24a5acce8b08 );
    
    foreach ( equip in equipment )
    {
        if ( isdefined( equip.hasruggedeqp ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace weapons
// Params 0
// Checksum 0xf43345fc, Offset: 0x8f7a
// Size: 0x47
function watchgrenadeusage()
{
    self notify( #"hash_59c75b5f02339562" );
    self endon( #"hash_59c75b5f02339562" );
    self endon( #"spawned_player", #"disconnect", #"faux_spawn" );
    
    while ( true )
    {
        watchgrenadethrows();
    }
}

// Namespace weapons
// Params 0
// Checksum 0xfec321f4, Offset: 0x8fc9
// Size: 0x9a
function function_9e3462ad5091450d()
{
    self notify( #"hash_472afbb0e5475115" );
    self endon( #"hash_472afbb0e5475115" );
    self endon( #"spawned_player", #"disconnect", #"faux_spawn" );
    
    while ( true )
    {
        self waittill( #"grenade_pullback", weaponobject );
        var_7a7a769159687e6d = weaponobject.var_25b0062cbe4d9c99;
        
        if ( isdefined( level.var_45a830706d2e9574[ var_7a7a769159687e6d ] ) )
        {
            self thread [[ level.var_45a830706d2e9574[ var_7a7a769159687e6d ] ]]( { #weaponobject:weaponobject } );
        }
    }
}

// Namespace weapons
// Params 0
// Checksum 0x6ec6b84b, Offset: 0x906b
// Size: 0x35
function watchgrenadethrows()
{
    grenade = waittill_grenade_throw();
    grenadeused( grenade );
    
    if ( isdefined( grenade ) )
    {
        grenade setentityhudoutlinedata( 3, self.team );
    }
}

// Namespace weapons
// Params 2
// Checksum 0xcc853132, Offset: 0x90a8
// Size: 0x46
function registerusedcallback( var_7a7a769159687e6d, callback )
{
    var_7a7a769159687e6d = getxhash( var_7a7a769159687e6d );
    assert( !isdefined( level.var_43ea0dc79d4f6473[ var_7a7a769159687e6d ] ), "<dev string:x200>" );
    level.var_43ea0dc79d4f6473[ var_7a7a769159687e6d ] = callback;
}

// Namespace weapons
// Params 1
// Checksum 0xbc4bfd27, Offset: 0x90f6
// Size: 0x20
function deregisterusedcallback( var_7a7a769159687e6d )
{
    var_7a7a769159687e6d = getxhash( var_7a7a769159687e6d );
    level.var_43ea0dc79d4f6473[ var_7a7a769159687e6d ] = undefined;
}

// Namespace weapons
// Params 1
// Checksum 0x22574870, Offset: 0x911e
// Size: 0x26
function getusedcallback( var_7a7a769159687e6d )
{
    assert( isxhash( var_7a7a769159687e6d ) );
    return level.var_43ea0dc79d4f6473[ var_7a7a769159687e6d ];
}

/#

    // Namespace weapons
    // Params 2
    // Checksum 0x2d665dd8, Offset: 0x914d
    // Size: 0x23, Type: dev
    function overrideusedcallback( weaponrootstring, callback )
    {
        assert( 0, "<dev string:x26b>" );
    }

#/

// Namespace weapons
// Params 2
// Checksum 0x593ddea2, Offset: 0x9178
// Size: 0x46
function function_2cd25260a11d5e40( var_7a7a769159687e6d, callback )
{
    var_7a7a769159687e6d = getxhash( var_7a7a769159687e6d );
    assert( !isdefined( level.var_45a830706d2e9574[ var_7a7a769159687e6d ] ), "<dev string:x2af>" );
    level.var_45a830706d2e9574[ var_7a7a769159687e6d ] = callback;
}

// Namespace weapons
// Params 1
// Checksum 0x6e6d00cf, Offset: 0x91c6
// Size: 0x20
function function_cda458ca9f121037( var_7a7a769159687e6d )
{
    var_7a7a769159687e6d = getxhash( var_7a7a769159687e6d );
    level.var_45a830706d2e9574[ var_7a7a769159687e6d ] = undefined;
}

// Namespace weapons
// Params 1
// Checksum 0xd95e56af, Offset: 0x91ee
// Size: 0x18
function function_83214e36c3a780f1( weaponrootstring )
{
    return level.var_45a830706d2e9574[ weaponrootstring ];
}

/#

    // Namespace weapons
    // Params 2
    // Checksum 0x2b38ed76, Offset: 0x920f
    // Size: 0x23, Type: dev
    function function_f2d7e3d2819ed22d( weaponrootstring, callback )
    {
        assert( 0, "<dev string:x26b>" );
    }

#/

// Namespace weapons
// Params 2
// Checksum 0xf49d5dd4, Offset: 0x923a
// Size: 0x54
function function_e143510ea2d98f60( weaponrootstring, callback )
{
    if ( !isdefined( level.var_fa15a56efdf3bbf2 ) )
    {
        level.var_fa15a56efdf3bbf2 = [];
    }
    
    assert( !isdefined( level.var_fa15a56efdf3bbf2[ weaponrootstring ] ), "<dev string:x31f>" );
    level.var_fa15a56efdf3bbf2[ weaponrootstring ] = callback;
}

// Namespace weapons
// Params 1
// Checksum 0xcfa4dae9, Offset: 0x9296
// Size: 0x44
function function_622fd25a029f07c9( basenamehash )
{
    assert( isxhashasset( basenamehash ), "<dev string:x345>" );
    
    if ( !isdefined( level.var_fe3993a23186adc9 ) )
    {
        level.var_fe3993a23186adc9 = [];
    }
    
    level.var_fe3993a23186adc9[ basenamehash ] = 1;
}

// Namespace weapons
// Params 2
// Checksum 0x58922333, Offset: 0x92e2
// Size: 0x5c
function registeragentusedcallback( var_7a7a769159687e6d, callback )
{
    var_7a7a769159687e6d = getxhash( var_7a7a769159687e6d );
    
    if ( !isdefined( level.var_70894b09d7ed4da0 ) )
    {
        level.var_70894b09d7ed4da0 = [];
    }
    
    assert( !isdefined( level.var_70894b09d7ed4da0[ var_7a7a769159687e6d ] ), "<dev string:x38e>" );
    level.var_70894b09d7ed4da0[ var_7a7a769159687e6d ] = callback;
}

// Namespace weapons
// Params 2
// Checksum 0xe48ceade, Offset: 0x9346
// Size: 0x54
function function_345fed126ca0b41d( weaponrootstring, callback )
{
    if ( !isdefined( level.var_408dcda44d2d0d39 ) )
    {
        level.var_408dcda44d2d0d39 = [];
    }
    
    assert( !isdefined( level.var_408dcda44d2d0d39[ weaponrootstring ] ), "<dev string:x3b6>" );
    level.var_408dcda44d2d0d39[ weaponrootstring ] = callback;
}

// Namespace weapons
// Params 1
// Checksum 0xe2420d32, Offset: 0x93a2
// Size: 0x622
function grenadeused( grenade )
{
    if ( !isdefined( grenade ) )
    {
        return;
    }
    
    if ( !isdefined( grenade.weapon_name ) )
    {
        return;
    }
    
    weaponrootname = getweaponrootstring( grenade.weapon_object );
    var_7a7a769159687e6d = grenade.weapon_object.var_25b0062cbe4d9c99;
    
    if ( var_7a7a769159687e6d == #"deploy_weapondrop" )
    {
        return;
    }
    
    if ( isplayer( self ) )
    {
        if ( !weapon::issuperweapon( grenade.weapon_object ) )
        {
            gamelogic_mp::setweaponstat( grenade.weapon_object, 1, "shots" );
        }
        
        gamelogic_mp::sethasdonecombat( self, 1 );
        
        if ( isdefined( grenade.equipmentref ) )
        {
            islethal = equipment_mp::isequipmentlethal( grenade.equipmentref );
            istactical = equipment_mp::isequipmenttactical( grenade.equipmentref );
            potg_events::grenadethrownevent( islethal );
            
            if ( isdefined( istactical ) && self isthrowingbackgrenade() && getdvarint( @"hash_61a8d5707f364581", 1 ) )
            {
                self function_4bdf2fa26c2d815d();
                objweapon = makeweapon( grenade.weapon_name );
                ammo = self getweaponammoclip( objweapon );
                newammo = int( max( ammo - 1, 0 ) );
                self setweaponammoclip( objweapon, newammo );
            }
            
            blueprintindex = grenade.weapon_object.variantid;
            
            if ( !isdefined( blueprintindex ) )
            {
                blueprintindex = 0;
            }
            
            if ( blueprintindex > 0 )
            {
                tableinfo = weapon::getequipmenttableinfo( grenade.equipmentref );
                genericblueprintname = namespace_de7b719e85d98dcc::function_9800c005d17e1d42( tableinfo.bundle, blueprintindex );
                
                if ( isdefined( genericblueprintname ) )
                {
                    self function_b06c41e6d4ed36c( genericblueprintname );
                }
            }
        }
        
        talking_gun::function_f91612e697751a26( self, grenade );
        
        if ( weapon::issuperweapon( grenade.weapon_object ) )
        {
            if ( !val::get( "supers" ) || self.carryinghostage )
            {
                if ( isbrgamemode() )
                {
                    if ( player::isinlaststand( self ) )
                    {
                        superref = supers_mp::getsuperrefforsuperweapon( grenade.weapon_object );
                        self.var_5ad7275235a06b0 = superref;
                    }
                }
            }
        }
    }
    
    if ( weapon::function_33e74163843b348e( grenade.weapon_object ) )
    {
        grenade thread function_c1f70f7e383be433( self );
        return;
    }
    
    grenade thread battlechatter_mp::grenadeproximitytracking();
    grenade.spawnpos = grenade.origin;
    
    if ( isdefined( grenade.bundle.var_16c873d42266cc14 ) )
    {
        assert( isdefined( level.var_408dcda44d2d0d39[ weaponrootname ] ), "<dev string:x3de>" );
        
        if ( !isdefined( self.var_311a70e979ef8608 ) )
        {
            self.var_311a70e979ef8608 = [];
        }
        
        if ( !isdefined( self.var_311a70e979ef8608[ weaponrootname ] ) )
        {
            self.var_311a70e979ef8608[ weaponrootname ] = [];
        }
        
        self.var_311a70e979ef8608[ weaponrootname ] = utility::function_8391781ea0784541( self.var_311a70e979ef8608[ weaponrootname ] );
        self.var_311a70e979ef8608[ weaponrootname ][ self.var_311a70e979ef8608[ weaponrootname ].size ] = grenade;
        
        if ( self.var_311a70e979ef8608[ weaponrootname ].size > grenade.bundle.var_16c873d42266cc14 )
        {
            self.var_311a70e979ef8608[ weaponrootname ][ 0 ] thread [[ level.var_408dcda44d2d0d39[ weaponrootname ] ]]();
        }
    }
    
    if ( isagent( self ) && level.var_70894b09d7ed4da0[ var_7a7a769159687e6d ] )
    {
        self thread [[ level.var_70894b09d7ed4da0[ var_7a7a769159687e6d ] ]]( grenade );
    }
    else
    {
        if ( isdefined( self.perks[ "specialty_cricket" ] ) && equipment_mp::isequipmenttactical( grenade.equipmentref ) )
        {
            shouldreturn = function_7a47d284e204463a( grenade, weaponrootname );
            
            if ( shouldreturn )
            {
                return;
            }
        }
        
        if ( isdefined( level.var_43ea0dc79d4f6473[ var_7a7a769159687e6d ] ) )
        {
            self thread [[ level.var_43ea0dc79d4f6473[ var_7a7a769159687e6d ] ]]( grenade );
        }
        else
        {
            switch ( var_7a7a769159687e6d )
            {
                case #"frag_grenade":
                    if ( grenade.ticks >= 1 )
                    {
                        grenade.iscooked = 1;
                    }
                    
                    grenade.originalowner = self;
                    grenade thread delayshow( 0.05 );
                    break;
                case #"semtex":
                    assertmsg( "<dev string:x424>" );
                    break;
                case #"sticky_grenade":
                    assertmsg( "<dev string:x463>" );
                    break;
                case #"hash_7ad980a3dbbd2cf7":
                    thread advanced_supply_drop::function_59bfaa376651f224( grenade );
                    break;
                case #"deploy_weapondrop":
                    thread weapon_drop::weapondrop_used( grenade );
                    break;
                case #"decon_station":
                case #"reinforcement_flare":
                    self thread [[ utility::getsharedfunc( weaponrootname, #"grenadeused" ) ]]( grenade );
                    break;
                case #"hash_c30af218f069fadf":
                    if ( utility::issharedfuncdefined( #"super_evg", #"evg_used" ) )
                    {
                        self thread [[ utility::getsharedfunc( #"super_evg", #"evg_used" ) ]]( grenade );
                    }
                    
                    break;
                case #"deploy_vehicle_drop":
                    thread vehicle_drop::vehicledrop_used( grenade );
                    break;
                default:
                    if ( isdefined( level.ongrenadeused ) )
                    {
                        [[ level.ongrenadeused ]]( grenade.weapon_name, grenade );
                    }
                    
                    break;
            }
            
            if ( level.gamemodebundle.var_318d99125d1f4c40 )
            {
                if ( weapon::issuperweapon( grenade.weapon_object ) )
                {
                    grenade thread outlinesuperequipmentforplayer( grenade, grenade.owner );
                }
                else
                {
                    grenade thread outlineequipmentforowner( grenade );
                }
            }
        }
    }
    
    bundle = equipment_mp::getEquipmentBundleFromWeaponName( grenade.weapon_name );
    
    if ( bundle.var_96d8711bab7c45d8 )
    {
        grenade thread shellshock::grenade_earthquake( bundle.earthquakescale, undefined, bundle.earthquakeduration_s );
    }
}

// Namespace weapons
// Params 1
// Checksum 0x671ac65f, Offset: 0x99cc
// Size: 0x35
function delayshow( delaytime )
{
    if ( self isscriptable() )
    {
        wait delaytime;
        
        if ( isdefined( self ) )
        {
            self setscriptablepartstate( #"visibility", #"show", 0 );
        }
    }
}

// Namespace weapons
// Params 0
// Checksum 0x13d2794b, Offset: 0x9a09
// Size: 0x45
function watchgrenadedeath()
{
    self waittill( #"death" );
    
    if ( isdefined( self.knife_trigger ) )
    {
        self.knife_trigger delete();
    }
    
    if ( isdefined( self.useobj_trigger ) )
    {
        self.useobj_trigger delete();
    }
}

// Namespace weapons
// Params 1
// Checksum 0x3c30be08, Offset: 0x9a56
// Size: 0x39
function function_8faeea4faeccf09b( target )
{
    if ( !isdefined( level.var_6a03c9a63e214bb7 ) )
    {
        level.var_6a03c9a63e214bb7 = [];
    }
    
    level.var_6a03c9a63e214bb7[ level.var_6a03c9a63e214bb7.size ] = target;
}

// Namespace weapons
// Params 1
// Checksum 0xd511e089, Offset: 0x9a97
// Size: 0x3a
function function_6c80db7e6f7d2191( target )
{
    if ( !isdefined( level.var_6a03c9a63e214bb7 ) )
    {
        level.var_6a03c9a63e214bb7 = [];
    }
    
    level.var_6a03c9a63e214bb7 = arrayremove( level.var_6a03c9a63e214bb7, target );
}

// Namespace weapons
// Params 1
// Checksum 0xb584fabc, Offset: 0x9ad9
// Size: 0x39
function function_ef0cb557b1a93af9( target )
{
    if ( !isdefined( level.special_lockon_target_list ) )
    {
        level.special_lockon_target_list = [];
    }
    
    level.special_lockon_target_list[ level.special_lockon_target_list.size ] = target;
}

// Namespace weapons
// Params 1
// Checksum 0x5ca5a43d, Offset: 0x9b1a
// Size: 0x3a
function function_d5eafafe8f6a97bf( target )
{
    if ( !isdefined( level.special_lockon_target_list ) )
    {
        level.special_lockon_target_list = [];
    }
    
    level.special_lockon_target_list = arrayremove( level.special_lockon_target_list, target );
}

// Namespace weapons
// Params 1
// Checksum 0xdac4e38a, Offset: 0x9b5c
// Size: 0x8be
function lockonlaunchers_gettargetarray( addcharacters )
{
    targets = [];
    var_215f461ee332af42 = 0;
    
    /#
        var_215f461ee332af42 = getdvarint( @"hash_10368af4dee3ba2c", 0 );
    #/
    
    if ( isdefined( level.special_lockon_target_list ) )
    {
        level.special_lockon_target_list = function_5713d46873b29625( level.special_lockon_target_list );
        
        foreach ( special_target in level.special_lockon_target_list )
        {
            targets[ targets.size ] = special_target;
        }
    }
    
    if ( level.teambased )
    {
        if ( addcharacters == 1 )
        {
            foreach ( char in level.characters )
            {
                if ( isalive( char ) && ( char.team != self.team || var_215f461ee332af42 ) )
                {
                    targets[ targets.size ] = char;
                }
            }
        }
        
        if ( isdefined( level.activekillstreaks ) )
        {
            foreach ( streak in level.activekillstreaks )
            {
                if ( streak.affectedbylockon && ( streak.team != self.team || var_215f461ee332af42 ) )
                {
                    targets[ targets.size ] = streak;
                }
            }
        }
        
        if ( isdefined( level.cratedropdata ) )
        {
            if ( isdefined( level.cratedropdata.ac130s ) )
            {
                foreach ( ac130 in level.cratedropdata.ac130s )
                {
                    if ( isdefined( ac130 ) && ( ac130.team != self.team || var_215f461ee332af42 ) )
                    {
                        targets[ targets.size ] = ac130;
                    }
                }
            }
        }
        
        foreach ( vehicleref in vehicle::function_75acd2d48a8f3605( 1 ) )
        {
            vehicles = vehicle_tracking::get_game_instances( vehicleref );
            
            foreach ( vehicle in vehicles )
            {
                if ( isdefined( vehicle ) && !vehicle.disablelockon && ( !vehicle::is_friendly_to_player( vehicle, self ) || var_215f461ee332af42 ) )
                {
                    targets[ targets.size ] = vehicle;
                }
            }
        }
        
        if ( isdefined( level.loot_choppers ) )
        {
            foreach ( lootchopper in level.loot_choppers )
            {
                if ( isdefined( lootchopper ) )
                {
                    targets[ targets.size ] = lootchopper;
                }
            }
        }
        
        foreach ( generic_target in level.var_6a03c9a63e214bb7 )
        {
            if ( isdefined( generic_target ) && ( generic_target.team != self.team || var_215f461ee332af42 ) )
            {
                targets[ targets.size ] = generic_target;
            }
        }
    }
    else
    {
        if ( addcharacters == 1 )
        {
            foreach ( char in level.characters )
            {
                if ( !isalive( char ) && !var_215f461ee332af42 )
                {
                    continue;
                }
                
                targets[ targets.size ] = char;
            }
        }
        
        if ( isdefined( level.activekillstreaks ) )
        {
            foreach ( streak in level.activekillstreaks )
            {
                if ( streak.affectedbylockon && ( isdefined( streak.owner ) && streak.owner != self || var_215f461ee332af42 ) )
                {
                    targets[ targets.size ] = streak;
                }
            }
        }
        
        if ( isdefined( level.cratedropdata ) )
        {
            if ( isdefined( level.cratedropdata.ac130s ) )
            {
                foreach ( ac130 in level.cratedropdata.ac130s )
                {
                    if ( ac130.owner != self || var_215f461ee332af42 )
                    {
                        targets[ targets.size ] = ac130;
                    }
                }
            }
        }
        
        foreach ( vehicleref in vehicle::function_75acd2d48a8f3605( 1 ) )
        {
            vehicles = vehicle_tracking::get_game_instances( vehicleref );
            
            foreach ( vehicle in vehicles )
            {
                if ( vehicle.disablelockon )
                {
                    continue;
                }
                
                if ( !isdefined( vehicle.owner ) )
                {
                    targets[ targets.size ] = vehicle;
                    continue;
                }
                
                if ( vehicle.owner != self || var_215f461ee332af42 )
                {
                    targets[ targets.size ] = vehicle;
                }
            }
        }
        
        foreach ( generic_target in level.var_6a03c9a63e214bb7 )
        {
            if ( isdefined( generic_target ) && ( generic_target.owner != self || var_215f461ee332af42 ) )
            {
                targets[ targets.size ] = generic_target;
            }
        }
    }
    
    return targets;
}

// Namespace weapons
// Params 1, eflags: 0x4
// Checksum 0xc85c2362, Offset: 0xa423
// Size: 0x83, Type: bool
function private istouchingkillborder( triggerlist )
{
    foreach ( trigger in triggerlist )
    {
        if ( self istouching( trigger ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace weapons
// Params 3
// Checksum 0xa60121c1, Offset: 0xa4af
// Size: 0x96
function watchkillbordernotify( var_7732000cafff0bb1, additionalendon, updaterate )
{
    self notify( #"hash_314913ae81de3a1a" );
    self endon( #"hash_314913ae81de3a1a" );
    self endon( #"death" );
    level endon( #"game_ended" );
    
    if ( !isdefined( level.kill_border_triggers ) )
    {
        return;
    }
    
    if ( additionalendon )
    {
        self endon( additionalendon );
    }
    
    if ( !isdefined( updaterate ) )
    {
        updaterate = 0.05;
    }
    
    while ( true )
    {
        if ( istouchingkillborder( level.kill_border_triggers ) )
        {
            self notify( var_7732000cafff0bb1 );
            return;
        }
        
        wait updaterate;
    }
}

// Namespace weapons
// Params 3
// Checksum 0x75ce33, Offset: 0xa54d
// Size: 0xbc
function function_4e52e334301e8205( var_92c7a9690918beaa, additionalendon, updaterate )
{
    self notify( #"hash_edb511c676e38ba9" );
    self endon( #"hash_edb511c676e38ba9" );
    self endon( #"death" );
    level endon( #"game_ended" );
    assert( isstring( var_92c7a9690918beaa ) || isfunction( var_92c7a9690918beaa ), "<dev string:x4b2>" );
    
    if ( !isdefined( level.outofboundstriggers ) )
    {
        return;
    }
    
    if ( additionalendon )
    {
        self endon( additionalendon );
    }
    
    if ( !isdefined( updaterate ) )
    {
        updaterate = 0.05;
    }
    
    while ( true )
    {
        if ( outofbounds::istouchingoobtrigger() )
        {
            if ( isstring( var_92c7a9690918beaa ) )
            {
                self notify( var_92c7a9690918beaa );
                return;
            }
            
            self thread [[ var_92c7a9690918beaa ]]();
            return;
        }
        
        wait updaterate;
    }
}

// Namespace weapons
// Params 3
// Checksum 0xe1c29f05, Offset: 0xa611
// Size: 0x97
function watchkillbordercallback( var_e110a5ffe429abf3, additionalendon, updaterate )
{
    self notify( #"hash_f7f02b53dc36baa0" );
    self endon( #"hash_f7f02b53dc36baa0" );
    self endon( #"death" );
    level endon( #"game_ended" );
    
    if ( !isdefined( level.kill_border_triggers ) )
    {
        return;
    }
    
    if ( additionalendon )
    {
        self endon( additionalendon );
    }
    
    if ( !isdefined( updaterate ) )
    {
        updaterate = 0.05;
    }
    
    while ( true )
    {
        if ( istouchingkillborder( level.kill_border_triggers ) )
        {
            self thread [[ var_e110a5ffe429abf3 ]]();
            return;
        }
        
        wait updaterate;
    }
}

// Namespace weapons
// Params 0
// Checksum 0x562ec3bb, Offset: 0xa6b0
// Size: 0x58
function watchmissileusage()
{
    self endon( #"disconnect" );
    
    for ( ;; )
    {
        [ objweapon, missile ] = waittill_missile_fire();
        
        if ( missile )
        {
            updatemissilefire( missile, objweapon );
            onweaponfired( objweapon, missile );
        }
    }
}

// Namespace weapons
// Params 2
// Checksum 0xa6b39678, Offset: 0xa710
// Size: 0x4f3
function updatemissilefire( missile, objweapon )
{
    missiletarget = undefined;
    isunderbarrel = 0;
    
    if ( isdefined( objweapon.underbarrel ) && objweapon.underbarrel == missile.weapon_name )
    {
        isunderbarrel = 1;
        var_c894e02c18455b66 = level.var_a62610653347fd8d;
        
        foreach ( wpnperk, callback in level.var_a62610653347fd8d )
        {
            if ( getweaponhasperk( objweapon, wpnperk ) )
            {
                self thread [[ callback ]]( missile, 1, objweapon );
            }
        }
    }
    
    rootname = getweaponrootstring( objweapon );
    
    if ( isdefined( level.var_fa15a56efdf3bbf2[ rootname ] ) )
    {
        self thread [[ level.var_fa15a56efdf3bbf2[ rootname ] ]]( missile, objweapon );
    }
    else if ( getweaponhasperk( objweapon, "specialty_ub_guided_missile" ) )
    {
        thread mini_missile::function_f86bb4a3d9295e09( missile );
    }
    else
    {
        switch ( missile.weapon_name )
        {
            case #"hash_13a265ac820ea0df":
            case #"hash_179c50123571b55a":
            case #"hash_3e782fd775b72022":
                missiletarget = self.missilelaunchertarget;
                level thread battlechatter_mp::launcherfired( missile );
                break;
            case #"hash_13608f01c909bed3":
            case #"hash_348ae4b5cc97ad79":
            case #"hash_5940f97bde194c9e":
                missiletarget = self.missilelaunchertarget;
                level thread battlechatter_mp::launcherfired( missile );
                break;
            case #"hash_5c272c0617caebf0":
            case #"hash_a273a49e013eb008":
                missiletarget = self.javelin.target;
                level thread battlechatter_mp::javelinfired( self.team, self.javelin.target.origin );
                break;
            default:
                break;
        }
    }
    
    level callback::callback( #"missile_fire", { #missile:missile } );
    
    if ( missile.weapon_name == "jup_jp26_la_mike32_mp" && isdefined( missile.weapon_object ) )
    {
        thread function_4a9cbe22925eadad( missile );
    }
    
    if ( weapon_utility::islockonlauncher( missile.weapon_object ) && isdefined( missiletarget ) )
    {
        missile.lockontarget = missiletarget;
        level notify( #"stinger_fired", self, missile, missiletarget );
        thread weapon_utility::watchtargetlockedontobyprojectile( missiletarget, missile );
    }
    
    if ( isplayer( self ) )
    {
        missile.adsfire = player::isplayerads();
    }
    
    if ( !isunderbarrel && isexplosivemissile( missile.weapon_name ) && !function_3449c2aa88466a5c( missile.weapon_name ) && !function_37d07ef0a6646973( missile.weapon_object ) )
    {
        scale = 1;
        
        if ( issmallmissile( missile.weapon_name ) )
        {
            scale = 0.65;
        }
        
        if ( missile.weapon_name == "jup_jp26_la_mike32_mp" )
        {
            scale = 0.4;
        }
        
        if ( level.gamemodebundle.var_a7942ed2171ed387 && function_4042d2fbe6237835( #"hash_b9eab515e3e4d1af" ) )
        {
            level.gamemodebundle.var_a7942ed2171ed387 = 0;
        }
        
        if ( level.gamemodebundle.var_a7942ed2171ed387 )
        {
            shellshockdata = weapon_utility::function_73b6be1968a97ac3( objweapon, scale );
            performshellshock = shellshockdata.enable;
            duration = shellshockdata.duration;
            scalemin = shellshockdata.scalemin;
            scalemid = shellshockdata.scalemid;
            scalemax = shellshockdata.scalemax;
            rangemin = shellshockdata.rangemin;
            rangemid = shellshockdata.rangemid;
            rangemax = shellshockdata.rangemax;
            screenshakerange = shellshockdata.screenshakerange;
            rumbletype = shellshockdata.rumbletype;
            var_3ad138cd8205b8f2 = 0;
            
            if ( !weapon::iskillstreakweapon( objweapon ) )
            {
                var_3ad138cd8205b8f2 = 1;
            }
            
            if ( performshellshock )
            {
                missile thread shellshock::generic_earthquake( duration, scalemin, scalemid, scalemax, rangemin, rangemid, rangemax, screenshakerange, rumbletype, 1, var_3ad138cd8205b8f2 );
            }
        }
        else
        {
            missile thread shellshock::grenade_earthquake( scale );
        }
    }
    
    events::missilefired( missile );
}

// Namespace weapons
// Params 1
// Checksum 0xc3fb566f, Offset: 0xac0b
// Size: 0x33, Type: bool
function function_37d07ef0a6646973( weapon )
{
    if ( !isdefined( weapon.var_5e3a1c87edc1edd5 ) )
    {
        return false;
    }
    
    return weapon.var_5e3a1c87edc1edd5 == #"smoke_wall";
}

// Namespace weapons
// Params 1
// Checksum 0x3c77cd76, Offset: 0xac47
// Size: 0xd, Type: bool
function issmallmissile( weapon )
{
    return false;
}

// Namespace weapons
// Params 1
// Checksum 0x63384263, Offset: 0xac5d
// Size: 0x68, Type: bool
function isexplosivemissile( weapon )
{
    baseweaponname = getweaponbasename( weapon );
    
    switch ( baseweaponname )
    {
        case #"hash_1e6ad4ef0904a0f1":
        case #"hash_1ee2bbd1bc80ea9a":
        case #"hash_4f9064f9a7a4b7d1":
        case #"hash_b833f98278746f9b":
        case #"hash_fe08358bc8f9a34a":
            return false;
    }
    
    return true;
}

// Namespace weapons
// Params 1
// Checksum 0x8935c626, Offset: 0xacce
// Size: 0x39, Type: bool
function function_3449c2aa88466a5c( weapon_name )
{
    if ( !isdefined( level.var_44cdf5fee6853ac5 ) )
    {
        return false;
    }
    
    if ( isdefined( weapon_name ) && arraycontains( level.var_44cdf5fee6853ac5, weapon_name ) )
    {
        return true;
    }
    
    return false;
}

// Namespace weapons
// Params 1
// Checksum 0x8ca1e73b, Offset: 0xad10
// Size: 0x5a
function movingplatformdetonate( data )
{
    if ( !( isdefined( data.lasttouchedplatform ) && isdefined( data.lasttouchedplatform.destroyexplosiveoncollision ) ) || data.lasttouchedplatform.destroyexplosiveoncollision )
    {
        self notify( #"detonateexplosive" );
    }
}

// Namespace weapons
// Params 3
// Checksum 0x81a3ea6a, Offset: 0xad72
// Size: 0x8d
function monitordisownedequipment( player, equipment, var_6637462580611fe3 )
{
    level endon( #"game_ended" );
    equipment endon( #"death" );
    equipment notify( #"hash_6631440040531bc7" );
    equipment endon( #"hash_6631440040531bc7" );
    
    if ( var_6637462580611fe3 )
    {
        player utility::waittill_any( "joined_team", "disconnect" );
    }
    else
    {
        player utility::waittill_any( "joined_team", "joined_spectators", "disconnect" );
    }
    
    equipment deleteexplosive();
}

// Namespace weapons
// Params 2
// Checksum 0x876b7b49, Offset: 0xae07
// Size: 0x66
function monitordisownedgrenade( player, grenade )
{
    level endon( #"game_ended" );
    grenade endon( #"death", #"mine_planted" );
    utility::waittill_any_ents( player, "joined_team", player, "joined_spectators", player, "disconnect", level, "prematch_cleanup" );
    
    if ( isdefined( grenade ) )
    {
        grenade delete();
    }
}

// Namespace weapons
// Params 1
// Checksum 0x5bf3cc4b, Offset: 0xae75
// Size: 0x23, Type: bool
function isplantedequipment( ent )
{
    return ent weapon::function_89d2d0588f2def25() || ent.planted;
}

// Namespace weapons
// Params 2
// Checksum 0x817f4fd, Offset: 0xaea1
// Size: 0xa6
function getmaxplantedlethalequip( player, equipmentref )
{
    var_865670405c10e9f6 = level.gamemodebundle.maxplantedlethalequip ?? 2;
    
    if ( isdefined( self.perks[ "specialty_mod_planted_equipment_max" ] ) )
    {
        var_865670405c10e9f6 += [[ utility::getsharedfunc( #"specialty_mod_planted_equipment_max", #"hash_7fe8e2da0940d7c8" ) ]]( equipmentref );
    }
    
    /#
        overridemax = getdvarint( @"hash_f35cb6d0fbb90304", 0 );
        
        if ( overridemax > 0 )
        {
            var_865670405c10e9f6 = overridemax;
        }
    #/
    
    var_865670405c10e9f6 = getdvarint( @"hash_f378eaa0e2c019fa", var_865670405c10e9f6 );
    return var_865670405c10e9f6;
}

// Namespace weapons
// Params 2
// Checksum 0x3700035d, Offset: 0xaf50
// Size: 0x95
function getmaxplantedtacticalequip( player, equipmentref )
{
    var_6e951758e94ef5bf = level.gamemodebundle.maxplantedtacticalequip ?? 2;
    
    if ( isdefined( self.perks[ "specialty_mod_planted_equipment_max" ] ) )
    {
        var_6e951758e94ef5bf += [[ utility::getsharedfunc( #"specialty_mod_planted_equipment_max", #"hash_7fe8e2da0940d7c8" ) ]]( equipmentref );
    }
    
    /#
        overridemax = getdvarint( @"hash_fa291a82a43e1ab1", 0 );
        
        if ( overridemax > 0 )
        {
            var_6e951758e94ef5bf = overridemax;
        }
    #/
    
    return var_6e951758e94ef5bf;
}

// Namespace weapons
// Params 1
// Checksum 0xa93a0b4, Offset: 0xafee
// Size: 0x17e
function getmaxplantedsuperequip( equipmentref )
{
    var_f738e4f156d1305f = level.gamemodebundle.var_bacbf5f873f2be5b ?? 2;
    var_b2a8a3ec98751c6e = level.gamemodebundle.var_a84198bab6eb036a ?? 0;
    var_f676ea921baaa211 = var_f738e4f156d1305f;
    var_d674e0ce07eeaf5 = 0;
    
    if ( isdefined( self.plantedsuperequip ) )
    {
        foreach ( plantedequip in self.plantedsuperequip )
        {
            if ( !( isdefined( plantedequip ) && isdefined( plantedequip.equipmentref ) ) )
            {
                continue;
            }
            
            if ( plantedequip.equipmentref != equipmentref )
            {
                var_d674e0ce07eeaf5 = 1;
                break;
            }
        }
    }
    
    if ( var_d674e0ce07eeaf5 && var_b2a8a3ec98751c6e > 0 )
    {
        var_f676ea921baaa211 = var_b2a8a3ec98751c6e;
    }
    
    if ( isdefined( self.perks[ "specialty_mod_planted_equipment_max" ] ) )
    {
        var_f676ea921baaa211 += [[ utility::getsharedfunc( #"specialty_mod_planted_equipment_max", #"hash_7fe8e2da0940d7c8" ) ]]( equipmentref );
    }
    
    overridemax = getdvarint( @"hash_52498acd75a3603e", 0 );
    
    if ( overridemax > 0 )
    {
        var_f676ea921baaa211 = overridemax;
    }
    
    return var_f676ea921baaa211;
}

// Namespace weapons
// Params 0
// Checksum 0xdf6c20f9, Offset: 0xb175
// Size: 0x4e
function function_326b4d176f82a819()
{
    maxtaccover = level.gamemodebundle.var_e63bf2e5db49eb98 ?? 2;
    
    /#
        overridemax = getdvarint( @"hash_1bee9e56c38d1214", 0 );
        
        if ( overridemax > 0 )
        {
            maxtaccover = overridemax;
        }
    #/
    
    return maxtaccover;
}

// Namespace weapons
// Params 0
// Checksum 0x51d52939, Offset: 0xb1cc
// Size: 0x4e
function getmaxplantedhackedequip()
{
    var_527acaf74a0353b0 = level.gamemodebundle.maxplantedhackedequip ?? 3;
    
    /#
        overridemax = getdvarint( @"hash_bc9519b8f9c0eaf0", 0 );
        
        if ( overridemax > 0 )
        {
            var_527acaf74a0353b0 = overridemax;
        }
    #/
    
    return var_527acaf74a0353b0;
}

// Namespace weapons
// Params 5
// Checksum 0x70466884, Offset: 0xb223
// Size: 0xc0
function onequipmentplanted( newequipment, equipmentref, deletefunc, var_42107120e1dfe43b, var_f82f6cda7a84783a )
{
    newequipment.equipmentref = equipmentref;
    newequipment.deletefunc = deletefunc;
    newequipment.planted = 1;
    
    if ( !isagent( self ) )
    {
        updateplantedarray( newequipment, var_42107120e1dfe43b );
    }
    
    newequipment weapon::registermine();
    
    if ( !var_f82f6cda7a84783a )
    {
        newequipment enableplayermarks( #"equipment" );
        
        if ( level.teambased )
        {
            newequipment filteroutplayermarks( self.team );
        }
        else
        {
            newequipment filteroutplayermarks( self );
        }
    }
    
    newequipment notify( #"mine_planted" );
}

// Namespace weapons
// Params 2
// Checksum 0x67186538, Offset: 0xb2eb
// Size: 0x391
function updateplantedarray( equipment, var_42107120e1dfe43b )
{
    plantedarray = undefined;
    maxsize = 0;
    slot = equipment_mp::findequipmentslot( equipment.equipmentref );
    
    if ( equipment.ishacked )
    {
        plantedarray = equipment.owner.plantedhackedequip;
        maxsize = getmaxplantedhackedequip();
    }
    else if ( equipment.issuper )
    {
        plantedarray = equipment.owner.plantedsuperequip;
        
        if ( equipment.bundle.var_e9babb227a735930 )
        {
            maxsize = equipment.bundle.var_e9babb227a735930;
        }
        else if ( equipment.equipmentref == "equip_tac_cover" )
        {
            maxsize = function_326b4d176f82a819();
        }
        else
        {
            maxsize = getmaxplantedsuperequip( equipment.equipmentref );
        }
    }
    else if ( slot == "primary" || equipment_mp::isequipmentlethal( equipment.equipmentref ) )
    {
        plantedarray = equipment.owner.plantedlethalequip;
        maxsize = getmaxplantedlethalequip( self, equipment.equipmentref );
    }
    else if ( slot == "secondary" || equipment_mp::isequipmenttactical( equipment.equipmentref ) )
    {
        plantedarray = equipment.owner.plantedtacticalequip;
        maxsize = getmaxplantedtacticalequip( self, equipment.equipmentref );
    }
    else if ( slot == "tertiary" )
    {
        plantedarray = equipment.owner.var_68db24a5acce8b08;
    }
    
    if ( var_42107120e1dfe43b )
    {
        maxsize = var_42107120e1dfe43b;
    }
    
    if ( !isdefined( plantedarray ) )
    {
        issuper = equipment.issuper;
        equipmentref = equipment.equipmentref;
        
        if ( !isdefined( issuper ) )
        {
            issuper = "undefined";
        }
        
        if ( !isdefined( slot ) )
        {
            slot = "undefined";
        }
        
        if ( !isdefined( equipmentref ) )
        {
            equipmentref = "undefined";
        }
        
        message = "isSuper: " + issuper + ", slot: " + slot + ", equipmentRef: " + equipmentref + ", allowed: " + equipment_mp::is_equipment_slot_allowed( "super" );
        script::demoforcesre( message );
        return;
    }
    
    plantedarray = function_5713d46873b29625( plantedarray );
    
    if ( plantedarray.size > 0 )
    {
        if ( plantedarray.size && plantedarray.size >= maxsize )
        {
            var_62d4361ee3009114 = plantedarray[ 0 ];
            plantedarray = arrayremove( plantedarray, var_62d4361ee3009114 );
            var_62d4361ee3009114 deleteexplosive();
        }
    }
    
    plantedarray[ plantedarray.size ] = equipment;
    
    if ( equipment.ishacked )
    {
        equipment.owner.plantedhackedequip = plantedarray;
        return;
    }
    
    if ( equipment.issuper )
    {
        equipment.owner.plantedsuperequip = plantedarray;
        return;
    }
    
    if ( slot == "primary" || equipment_mp::isequipmentlethal( equipment.equipmentref ) )
    {
        equipment.owner.plantedlethalequip = plantedarray;
        return;
    }
    
    if ( slot == "secondary" || equipment_mp::isequipmenttactical( equipment.equipmentref ) )
    {
        equipment.owner.plantedtacticalequip = plantedarray;
        return;
    }
    
    if ( slot == "tertiary" )
    {
        equipment.owner.var_68db24a5acce8b08 = plantedarray;
    }
}

// Namespace weapons
// Params 1
// Checksum 0xe4bd1169, Offset: 0xb684
// Size: 0xe1
function setplantedequipmentuse( enabled )
{
    allequip = getallequip();
    
    foreach ( equip in allequip )
    {
        if ( isdefined( equip.trigger ) && isdefined( equip.owner ) )
        {
            if ( enabled )
            {
                equip.trigger enableplayeruse( equip.owner );
                continue;
            }
            
            equip.trigger disableplayeruse( equip.owner );
        }
    }
}

// Namespace weapons
// Params 2
// Checksum 0x8d7a302c, Offset: 0xb76d
// Size: 0x2f
function cleanupequipment( equipkillcament, equiptrigger )
{
    if ( isdefined( equipkillcament ) )
    {
        equipkillcament delete();
    }
    
    if ( isdefined( equiptrigger ) )
    {
        equiptrigger delete();
    }
}

// Namespace weapons
// Params 4
// Checksum 0x663ad0df, Offset: 0xb7a4
// Size: 0x1d7
function equipmenthit( owner, attacker, objweapon, meansofdeath )
{
    if ( player_utility::playersareenemies( attacker, owner ) )
    {
        if ( !isdefined( objweapon ) )
        {
            return;
        }
        
        if ( weapon::iskillstreakweapon( objweapon.basename ) )
        {
            return;
        }
        
        var_bda53394c108f2e = getcompleteweaponname( objweapon );
        
        if ( !isdefined( attacker.lasthittime ) )
        {
            attacker.lasthittime = [];
        }
        
        if ( !isdefined( attacker.lasthittime[ var_bda53394c108f2e ] ) )
        {
            attacker.lasthittime[ var_bda53394c108f2e ] = 0;
        }
        
        if ( attacker.lasthittime[ var_bda53394c108f2e ] == gettime() )
        {
            return;
        }
        
        attacker.lasthittime[ var_bda53394c108f2e ] = gettime();
        attacker thread gamelogic_mp::threadedsetweaponstatbyname( objweapon, 1, "hits" );
        
        if ( game_utility_mp::onlinestatsenabled() )
        {
            totalshots = attacker playerstats_interface::getplayerstat( "combatStats", "totalShots" );
            hits = attacker playerstats_interface::getplayerstat( "combatStats", "hits" ) + 1;
            
            if ( hits <= totalshots )
            {
                playerstats_interface::setplayerstatbuffered( hits, "combatStats", "hits" );
                playerstats_interface::setplayerstatbuffered( int( totalshots - hits ), "combatStats", "misses" );
            }
        }
        
        if ( isdefined( meansofdeath ) && utility::isbulletdamage( meansofdeath ) || damage::isprojectiledamage( meansofdeath ) )
        {
            attacker.pers[ "lastDamageTime" ] = gettime();
            weapongroup = weapon::getweapongroup( objweapon.basename );
            
            if ( weapongroup == "weapon_lmg" )
            {
                if ( !isdefined( attacker.shotslandedlmg ) )
                {
                    attacker.shotslandedlmg = 1;
                    return;
                }
                
                attacker.shotslandedlmg++;
            }
        }
    }
}

// Namespace weapons
// Params 0
// Checksum 0x215ae31c, Offset: 0xb983
// Size: 0xae
function deleteexplosive()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    sentientpoolmanager::unregistersentient( self.sentientpool, self.sentientpoolindex );
    
    if ( weapon::function_89d2d0588f2def25() )
    {
        weapon::deregistermine();
    }
    
    self disableplayermarks( #"equipment" );
    
    if ( isdefined( self.deletefunc ) )
    {
        self thread [[ self.deletefunc ]]();
        self notify( #"deleted_equipment" );
        return;
    }
    
    equipkillcament = self.killcament;
    equiptrigger = self.trigger;
    cleanupequipment( equipkillcament, equiptrigger );
    self notify( #"deleted_equipment" );
    self delete();
}

// Namespace weapons
// Params 1
// Checksum 0x79c86d31, Offset: 0xba39
// Size: 0x9f
function makeexplosiveusable( offset )
{
    assert( isdefined( self.owner ) );
    self setotherent( self.owner );
    
    if ( !isdefined( offset ) )
    {
        offset = 10;
    }
    
    trigger = spawn( "script_origin", self.origin + offset * anglestoup( self.angles ) );
    trigger.targetname = "makeExplosiveUsable";
    trigger linkto( self );
    self.trigger = trigger;
    trigger.owner = self;
    thread makeexplosiveusableinternal();
    return trigger;
}

// Namespace weapons
// Params 0
// Checksum 0x1d4b0e93, Offset: 0xbae1
// Size: 0x51
function makeexplosiveusableinternal()
{
    self endon( #"makeExplosiveUnusable" );
    trigger = self.trigger;
    watchexplosiveusable();
    
    if ( isdefined( self ) )
    {
        trigger = self.trigger;
        self.trigger = undefined;
    }
    
    if ( isdefined( trigger ) )
    {
        trigger delete();
    }
}

// Namespace weapons
// Params 0
// Checksum 0xebe4e39f, Offset: 0xbb3a
// Size: 0x3a
function makeexplosiveunusable()
{
    self notify( #"makeExplosiveUnusable" );
    trigger = self.trigger;
    self.trigger = undefined;
    
    if ( isdefined( trigger ) )
    {
        trigger delete();
    }
}

// Namespace weapons
// Params 0
// Checksum 0x8cae43e5, Offset: 0xbb7c
// Size: 0x198
function watchexplosiveusable()
{
    owner = self.owner;
    trigger = self.trigger;
    weaponname = self.weapon_name;
    self endon( #"death" );
    trigger endon( #"death" );
    owner endon( #"disconnect" );
    level endon( #"game_ended" );
    trigger setcursorhint( "HINT_NOICON" );
    trigger usability::setselfusable( owner );
    trigger childthread usability::notusableforjoiningplayers( owner );
    trigger childthread usability::notusableafterownerchange( owner, self );
    trigger setexplosiveusablehintstring( self.weapon_name );
    
    while ( true )
    {
        trigger waittillmatch( #"trigger", owner );
        
        if ( isdefined( weaponname ) )
        {
            rootname = getweaponrootstring( self.weapon_object );
            
            if ( isdefined( rootname ) )
            {
                interactablecallback = function_59c5a7085adef7d( rootname );
                
                if ( isdefined( interactablecallback ) )
                {
                    self thread [[ interactablecallback ]]();
                }
            }
            
            owner notify( #"equipment_pickup" );
            owner notify( #"scavenged_ammo", weaponname );
            attachments = getweapondefaultattachments( weaponname );
            objweapon = makeweapon( weaponname, attachments );
        }
        
        equipmentref = equipment_mp::getequipmentreffromweapon( makeweapon( self.weapon_name ) );
        
        if ( isdefined( equipmentref ) && self.owner equipment_mp::hasequipment( equipmentref ) )
        {
            self.owner equipment_mp::incrementequipmentammo( equipmentref, 1 );
        }
        
        thread deleteexplosive();
        return;
    }
}

// Namespace weapons
// Params 1, eflags: 0x4
// Checksum 0x354ac470, Offset: 0xbd1c
// Size: 0x8f, Type: bool
function private function_aa2c8c826e715283( player )
{
    if ( !isplayer( player ) )
    {
        return false;
    }
    
    if ( utility::issharedfuncdefined( #"game", #"isCommonItemEnabled" ) )
    {
        if ( !utility::callsharedfunc( #"game", #"isCommonItemEnabled" ) )
        {
            return false;
        }
        
        if ( !( utility::issharedfuncdefined( #"game", #"hash_6a1940cb87219089" ) && utility::issharedfuncdefined( #"game", #"getItemBundleNameFromRef" ) ) )
        {
            return false;
        }
        
        return true;
    }
    
    return false;
}

// Namespace weapons
// Params 2
// Checksum 0x5ae2cb08, Offset: 0xbdb4
// Size: 0x57
function function_1d6e543fafed66c9( rootname, callback )
{
    if ( !isdefined( level.var_7e8c04dfe3e97f46 ) )
    {
        level.var_7e8c04dfe3e97f46 = [];
    }
    
    assert( !isdefined( level.var_7e8c04dfe3e97f46[ rootname ] ), "<dev string:x4f6>" + rootname );
    level.var_7e8c04dfe3e97f46[ rootname ] = callback;
}

// Namespace weapons
// Params 1
// Checksum 0x386c8f61, Offset: 0xbe13
// Size: 0x18
function function_59c5a7085adef7d( rootname )
{
    return level.var_7e8c04dfe3e97f46[ rootname ];
}

// Namespace weapons
// Params 2
// Checksum 0x122695e8, Offset: 0xbe34
// Size: 0xe6
function makeexplosiveusabletag( tagname, isgrenade )
{
    self endon( #"death" );
    self endon( #"makeExplosiveUnusable" );
    owner = self.owner;
    weaponname = self.weapon_name;
    
    if ( !isdefined( isgrenade ) )
    {
        isgrenade = 0;
    }
    
    usability::setselfusable( owner );
    
    if ( isgrenade )
    {
        self enablemissilehint( 1 );
    }
    else
    {
        self setcursorhint( "HINT_NOICON" );
    }
    
    self sethinttag( tagname );
    self setuserange( 72 );
    setexplosiveusablehintstring( self.weapon_name );
    childthread usability::notusableforjoiningplayers( owner );
    childthread usability::notusableafterownerchange( owner, self );
    
    while ( true )
    {
        self waittillmatch( #"trigger", owner );
        result = function_4903ae0fe1ab99d2( owner, weaponname );
        
        if ( result )
        {
            return;
        }
    }
}

// Namespace weapons
// Params 2
// Checksum 0x66dc0ca2, Offset: 0xbf22
// Size: 0x3cb, Type: bool
function function_4903ae0fe1ab99d2( owner, weaponname )
{
    if ( !isdefined( owner ) )
    {
        return false;
    }
    
    if ( owner.isjuggernaut )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            owner [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"killstreaks/jugg_cannot_be_picked_up" );
        }
        
        return false;
    }
    
    objweapon = undefined;
    
    if ( isdefined( weaponname ) )
    {
        rootname = getweaponrootstring( self.weapon_object );
        
        if ( isdefined( rootname ) )
        {
            interactablecallback = function_59c5a7085adef7d( rootname );
            
            if ( isdefined( interactablecallback ) )
            {
                self thread [[ interactablecallback ]]();
            }
        }
        
        owner notify( #"equipment_pickup" );
        owner notify( #"scavenged_ammo", weaponname );
        attachments = getweapondefaultattachments( weaponname );
        objweapon = makeweapon( weaponname, attachments );
    }
    
    if ( isdefined( objweapon ) )
    {
        equipmentref = equipment_mp::getequipmentreffromweapon( objweapon );
        
        if ( isdefined( equipmentref ) )
        {
            if ( owner equipment_mp::hasequipment( equipmentref ) )
            {
                if ( isbrgamemode() && common_inventory::function_7ec5937e3b3d86e0( loot::function_3bbf7813accff0d9( equipmentref ) ) && owner equipment_mp::getequipmentammo( equipmentref ) >= owner equipment_mp::getequipmentmaxammo( equipmentref ) )
                {
                    lootid = loot::getlootidfromref( equipmentref );
                    result = owner common_inventory::function_e332683b9ad5368b( lootid, 1 );
                    
                    if ( result )
                    {
                        owner common_inventory::function_d3959596f4031a1d( lootid, 1 );
                    }
                    else
                    {
                        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
                        {
                            owner [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"mp/deny_equip_pickup" );
                        }
                        
                        if ( soundexists( "fly_pickup_deny" ) )
                        {
                            owner playlocalsound( "fly_pickup_deny" );
                        }
                        
                        return false;
                    }
                }
                else if ( owner equipment_mp::getequipmentammo( equipmentref ) < owner equipment_mp::getequipmentmaxammo( equipmentref ) )
                {
                    owner equipment_mp::incrementequipmentammo( equipmentref, 1 );
                }
                else
                {
                    self.owner hud_message::showerrormessage( %"mp/deny_equip_pickup" );
                    return false;
                }
            }
            else if ( isdefined( level.onnewequipmentpickup ) )
            {
                [[ level.onnewequipmentpickup ]]( self.owner, equipmentref );
            }
            else if ( function_aa2c8c826e715283( self.owner ) )
            {
                itembundlename = utility::callsharedfunc( #"game", #"getItemBundleNameFromRef", equipmentref );
                itembundle = getscriptbundle( itembundlename );
                fakeitem = spawnstruct();
                fakeitem.count = 1;
                fakeitem.type = itembundle.scriptable;
                fakeitem.fromground = 1;
                self.owner utility::callsharedfunc( #"game", #"hash_6a1940cb87219089", fakeitem, 0 );
            }
            else
            {
                owner hud_message::showerrormessage( %"mp/deny_equip_pickup" );
                return false;
            }
            
            callbackparams = { #equipmentref:equipmentref, #player:owner };
            owner callback::callback( #"equipment_reclaimed", callbackparams );
        }
    }
    
    if ( isdefined( weaponname ) )
    {
        bundle = equipment_mp::getEquipmentBundleFromWeaponName( weaponname );
        owner playlocalsound( bundle.var_cea6f704b7baafe0 ?? "scavenger_pack_pickup" );
        var_385eff4adb59c71c = bundle.var_ceb00304b7c4e8f2;
        
        if ( isdefined( var_385eff4adb59c71c ) )
        {
            owner playsound( var_385eff4adb59c71c, owner );
        }
        
        owner thread equipment_mp::function_f6c5b0762bf2879e( bundle );
    }
    
    if ( isdefined( self.useobj ) )
    {
        self.useobj delete();
    }
    
    thread deleteexplosive();
    return true;
}

// Namespace weapons
// Params 0
// Checksum 0x42db007b, Offset: 0xc2f6
// Size: 0x14
function makeexplosiveunusuabletag()
{
    self notify( #"makeExplosiveUnusable" );
    self makeunusable();
}

// Namespace weapons
// Params 1
// Checksum 0x561b753d, Offset: 0xc312
// Size: 0x42
function setexplosiveusablehintstring( weaponname )
{
    weaponbundle = equipment_mp::getEquipmentBundleFromWeaponName( weaponname );
    
    if ( !isdefined( weaponbundle.pickuphintstring ) )
    {
        return;
    }
    
    self sethintstring( weaponbundle.pickuphintstring );
}

// Namespace weapons
// Params 2
// Checksum 0xebed5987, Offset: 0xc35c
// Size: 0x96
function explosivehandlemovers( parent, var_49d1afce8c81ecb6 )
{
    data = spawnstruct();
    data.linkparent = parent;
    data.deathoverridecallback = &movingplatformdetonate;
    data.endonstring = "death";
    
    if ( utility::is_moving_platform_ent( parent ) )
    {
        data.var_f07590e06f628942 = 1;
        self setmissileantilagged( 1 );
    }
    
    if ( !var_49d1afce8c81ecb6 )
    {
        data.invalidparentoverridecallback = &utility::empty_init_func;
    }
    
    thread movers::handle_moving_platforms( data );
}

// Namespace weapons
// Params 3
// Checksum 0x218db24a, Offset: 0xc3fa
// Size: 0x4b
function explosivetrigger( target, graceperiod, notifystr )
{
    if ( isplayer( target ) && isdefined( target.perks[ "specialty_delaymine" ] ) )
    {
        graceperiod = level.delayminetime;
    }
    
    wait graceperiod;
}

// Namespace weapons
// Params 4
// Checksum 0x44a36f62, Offset: 0xc44d
// Size: 0x4f1
function getdamageableents( pos, radius, dolos, startradius )
{
    ents = [];
    
    if ( !isdefined( dolos ) )
    {
        dolos = 0;
    }
    
    if ( !isdefined( startradius ) )
    {
        startradius = 0;
    }
    
    radiussq = radius * radius;
    players = level.players;
    
    for ( i = 0; i < players.size ; i++ )
    {
        if ( !isalive( players[ i ] ) || players[ i ].sessionstate != "playing" )
        {
            continue;
        }
        
        playerpos = damage::get_damageable_player_pos( players[ i ] );
        distsq = distancesquared( pos, playerpos );
        
        if ( distsq < radiussq && ( !dolos || weapondamagetracepassed( pos, playerpos, startradius, players[ i ] ) ) )
        {
            ents[ ents.size ] = damage::get_damageable_player( players[ i ], playerpos );
        }
    }
    
    grenades = getentarray( "grenade", #classname );
    
    for ( i = 0; i < grenades.size ; i++ )
    {
        entpos = damage::get_damageable_grenade_pos( grenades[ i ] );
        distsq = distancesquared( pos, entpos );
        
        if ( distsq < radiussq && ( !dolos || weapondamagetracepassed( pos, entpos, startradius, grenades[ i ] ) ) )
        {
            ents[ ents.size ] = damage::get_damageable_grenade( grenades[ i ], entpos );
        }
    }
    
    destructibles = getentarray( "destructible", #targetname );
    
    for ( i = 0; i < destructibles.size ; i++ )
    {
        entpos = destructibles[ i ].origin;
        distsq = distancesquared( pos, entpos );
        
        if ( distsq < radiussq && ( !dolos || weapondamagetracepassed( pos, entpos, startradius, destructibles[ i ] ) ) )
        {
            newent = spawnstruct();
            newent.isplayer = 0;
            newent.isadestructable = 0;
            newent.entity = destructibles[ i ];
            newent.damagecenter = entpos;
            ents[ ents.size ] = newent;
        }
    }
    
    destructables = getentarray( "destructable", #targetname );
    
    for ( i = 0; i < destructables.size ; i++ )
    {
        entpos = destructables[ i ].origin;
        distsq = distancesquared( pos, entpos );
        
        if ( distsq < radiussq && ( !dolos || weapondamagetracepassed( pos, entpos, startradius, destructables[ i ] ) ) )
        {
            newent = spawnstruct();
            newent.isplayer = 0;
            newent.isadestructable = 1;
            newent.entity = destructables[ i ];
            newent.damagecenter = entpos;
            ents[ ents.size ] = newent;
        }
    }
    
    sentries = getentarray( "misc_turret", #classname );
    
    foreach ( sentry in sentries )
    {
        entpos = sentry.origin + ( 0, 0, 32 );
        distsq = distancesquared( pos, entpos );
        
        if ( distsq < radiussq && ( !dolos || weapondamagetracepassed( pos, entpos, startradius, sentry ) ) )
        {
            switch ( sentry.model )
            {
                case #"hash_599bc2324c763cb":
                case #"hash_b0754ce41d06cdb":
                case #"hash_cc323017c363eb7d":
                case #"hash_fb287221737ad80c":
                    ents[ ents.size ] = damage::get_damageable_sentry( sentry, entpos );
                    break;
            }
        }
    }
    
    mines = getentarray( "script_model", #classname );
    
    foreach ( mine in mines )
    {
        if ( mine.model != "projectile_bouncing_betty_grenade" && mine.model != "ims_scorpion_body" )
        {
            continue;
        }
        
        entpos = mine.origin + ( 0, 0, 32 );
        distsq = distancesquared( pos, entpos );
        
        if ( distsq < radiussq && ( !dolos || weapondamagetracepassed( pos, entpos, startradius, mine ) ) )
        {
            ents[ ents.size ] = damage::get_damageable_mine( mine, entpos );
        }
    }
    
    return ents;
}

// Namespace weapons
// Params 4
// Checksum 0xff8ce128, Offset: 0xc947
// Size: 0x162, Type: bool
function weapondamagetracepassed( from, to, startradius, ent )
{
    midpos = undefined;
    diff = to - from;
    
    if ( lengthsquared( diff ) < startradius * startradius )
    {
        return true;
    }
    
    dir = vectornormalize( diff );
    midpos = from + ( dir[ 0 ] * startradius, dir[ 1 ] * startradius, dir[ 2 ] * startradius );
    trace = trace::_bullet_trace( midpos, to, 0, ent );
    
    if ( getdvarint( @"scr_damage_debug" ) != 0 || getdvarint( @"scr_debugmines" ) != 0 )
    {
        thread debugprint( from, ".dmg" );
        
        if ( isdefined( ent ) )
        {
            thread debugprint( to, "." + ent.classname );
        }
        else
        {
            thread debugprint( to, ".undefined" );
        }
        
        if ( trace[ "fraction" ] == 1 )
        {
            thread debugline( midpos, to, ( 1, 1, 1 ) );
        }
        else
        {
            thread debugline( midpos, trace[ "position" ], ( 1, 0.9, 0.8 ) );
            thread debugline( trace[ "position" ], to, ( 1, 0.4, 0.3 ) );
        }
    }
    
    return trace[ "fraction" ] == 1;
}

// Namespace weapons
// Params 7
// Checksum 0xff0e4d1d, Offset: 0xcab2
// Size: 0x13c
function damageent( einflictor, eattacker, idamage, smeansofdeath, objweapon, damagepos, damagedir )
{
    if ( isplayer( self ) )
    {
        self.damageorigin = damagepos;
        self.entity thread [[ level.callbackplayerdamage ]]( einflictor, eattacker, idamage, 0, smeansofdeath, objweapon, damagepos, damagedir, "none", 0 );
        return;
    }
    
    if ( self.isadestructable && ( objweapon.basename == "artillery_mp" || objweapon.basename == "claymore_mp" || objweapon.basename == "jup_claymore_mp" || objweapon.basename == "jup_claymore_cp" || objweapon.basename == "stealth_bomb_mp" ) )
    {
        return;
    }
    
    self.entity notify( #"damage", idamage, eattacker, ( 0, 0, 0 ), ( 0, 0, 0 ), "MOD_EXPLOSIVE", "", "", "", undefined, objweapon );
}

// Namespace weapons
// Params 3
// Checksum 0xb7a38a31, Offset: 0xcbf6
// Size: 0x4c
function debugline( a, b, color )
{
    /#
        for ( i = 0; i < 600 ; i++ )
        {
            line( a, b, color );
            wait 0.05;
        }
    #/
}

/#

    // Namespace weapons
    // Params 4
    // Checksum 0xaee9ac9b, Offset: 0xcc4a
    // Size: 0x125, Type: dev
    function debugcircle( center, radius, color, segments )
    {
        if ( !isdefined( segments ) )
        {
            segments = 16;
        }
        
        anglefrac = 360 / segments;
        circlepoints = [];
        
        for ( i = 0; i < segments ; i++ )
        {
            angle = anglefrac * i;
            xadd = cos( angle ) * radius;
            yadd = sin( angle ) * radius;
            x = center[ 0 ] + xadd;
            y = center[ 1 ] + yadd;
            z = center[ 2 ];
            circlepoints[ circlepoints.size ] = ( x, y, z );
        }
        
        for ( i = 0; i < circlepoints.size ; i++ )
        {
            start = circlepoints[ i ];
            
            if ( i + 1 >= circlepoints.size )
            {
                end = circlepoints[ 0 ];
            }
            else
            {
                end = circlepoints[ i + 1 ];
            }
            
            thread debugline( start, end, color );
        }
    }

#/

// Namespace weapons
// Params 2
// Checksum 0xd72e8760, Offset: 0xcd77
// Size: 0x42
function debugprint( pt, txt )
{
    /#
        for ( i = 0; i < 600 ; i++ )
        {
            print3d( pt, txt );
            wait 0.05;
        }
    #/
}

// Namespace weapons
// Params 5
// Checksum 0xde99ddb8, Offset: 0xcdc1
// Size: 0x31a
function onweapondamage( einflictor, objweapon, meansofdeath, damage, eattacker )
{
    self endon( #"death_or_disconnect" );
    
    if ( !player::isreallyalive( self ) )
    {
        return;
    }
    
    if ( meansofdeath == "MOD_IMPACT" && objweapon.classname == "grenade" )
    {
        return;
    }
    
    if ( level.gamemodebundle.var_face7704d44fc8aa && utility::isexplosivedamage( meansofdeath ) )
    {
        shellshock_utility::_shellshock( level.gamemodebundle.var_96041ca3580f2e63, #"explosion", 0.5 );
        return;
    }
    
    if ( isdefined( einflictor.equipmentref ) )
    {
        bundle = equipment_mp::function_c90a9aa89b223dd7( einflictor.equipmentref );
    }
    
    if ( isdefined( bundle ) )
    {
        if ( bundle.var_aea89582ef521b57.skip )
        {
            return;
        }
        
        if ( isdefined( bundle.var_aea89582ef521b57.shock ) )
        {
            shellshock_utility::_shellshock( bundle.var_aea89582ef521b57.shock, bundle.var_aea89582ef521b57.category ?? #"top", bundle.var_aea89582ef521b57.duration ?? 0.1 );
            return;
        }
    }
    
    if ( isai( eattacker ) && level.gamemodebundle.var_4444f95e927b4270 )
    {
        return;
    }
    
    weaponrootname = getweaponrootstring( objweapon );
    
    switch ( weaponrootname )
    {
        case #"hash_cd288ca229b9529":
        case #"hash_45125a8f171b4fb9":
        case #"hash_4c57dd619266bfc9":
        case #"hash_4c57df619266c2ef":
        case #"hash_4d63389017f81514":
        case #"hash_8670ac083666f3a4":
        case #"hash_89a5836ac6557236":
        case #"hash_c9a436974fe60919":
        case #"hash_e042760d17966848":
        case #"hash_e2e031b6aef9b78e":
            break;
        case #"hash_582fe5fd91d16d23":
        case #"hash_a0319e349a692b8f":
            shellshock_utility::_shellshock( %"thermite_mp", #"explosion", 0.5 );
            break;
        case #"hash_36b7174a04de8799":
        case #"hash_5d11ac1131cddab1":
        case #"hash_720535feb098085f":
        case #"hash_7c03088193266bc4":
        case #"hash_9d57562863499a06":
        case #"hash_f75c745bccd09240":
        case #"hash_fa1e80f6bd5b8e72":
            shellshock_utility::_shellshock( %"frag_grenade_mp", #"explosion", 2 );
            break;
        case #"hash_76e24481ceb557a7":
            shellshock_utility::_shellshock( %"light_damage_mp", #"damage", 0.2 );
            break;
        default:
            shellshock::shellshockondamage( meansofdeath, damage );
            break;
    }
}

// Namespace weapons
// Params 1, eflags: 0x4
// Checksum 0x93706a28, Offset: 0xd0e3
// Size: 0x14b
function private function_f87bf608e1a4cf64( objweapon )
{
    /#
        assert( isdefined( level.killstreakweaponmap ), "<dev string:x52d>" );
        assert( isdefined( level.superglobals ), "<dev string:x57d>" );
        assert( isdefined( level.defaultknifestab ), "<dev string:x5c6>" );
    #/
    
    var_eadb663a1292c9e8 = objweapon.basenamehash;
    
    if ( !isdefined( level.var_d27568d3c12c520e[ var_eadb663a1292c9e8 ] ) )
    {
        if ( !isdefined( level.var_d27568d3c12c520e ) )
        {
            level.var_d27568d3c12c520e = [];
        }
        
        isnormallastweapon = var_eadb663a1292c9e8 != %"none" && objweapon.classname != "turret" && !weapon::function_d4dcd88477cfa8ca( var_eadb663a1292c9e8 ) && !weapon::iskillstreakweaponname( objweapon.baseweaponname ) && !weapon::function_e93a21a657377115( objweapon ) && !weapon::function_4c948bc86e32680a( var_eadb663a1292c9e8 ) && !weapon::isclimbweaponobject( objweapon ) && ( objweapon.inventorytype == "primary" || objweapon.inventorytype == "altmode" );
        level.var_d27568d3c12c520e[ var_eadb663a1292c9e8 ] = isnormallastweapon;
    }
    
    return level.var_d27568d3c12c520e[ var_eadb663a1292c9e8 ];
}

// Namespace weapons
// Params 1
// Checksum 0x88ad17ef, Offset: 0xd237
// Size: 0x37, Type: bool
function isnormallastweapon( objweapon )
{
    assert( isweapon( objweapon ), "<dev string:x613>" );
    return function_f87bf608e1a4cf64( objweapon ) && !weapon::isbackuppistol( objweapon );
}

// Namespace weapons
// Params 1, eflags: 0x4
// Checksum 0xe3d1e140, Offset: 0xd277
// Size: 0x16f
function private function_332fbb2b4f3ecb4e( objweapon )
{
    /#
        assert( isdefined( level.killstreakweaponmap ), "<dev string:x647>" );
        assert( isdefined( level.superglobals ), "<dev string:x696>" );
        assert( isdefined( level.defaultfist ), "<dev string:x6de>" );
    #/
    
    var_eadb663a1292c9e8 = objweapon.basenamehash;
    
    if ( !isdefined( level.var_d163cf3023878336[ var_eadb663a1292c9e8 ] ) )
    {
        if ( !isdefined( level.var_d163cf3023878336 ) )
        {
            level.var_d163cf3023878336 = [];
        }
        
        weapongroup = weapon::function_820c0dca2415bd8( objweapon );
        isdroppableweapon = var_eadb663a1292c9e8 != %"none" && objweapon.inventorytype == "primary" && !weapon::iskillstreakweaponname( objweapon.basename ) && !weapon::function_d4dcd88477cfa8ca( var_eadb663a1292c9e8 ) && !weapon::isfistweaponobject( objweapon ) && !isbombplantweapon( var_eadb663a1292c9e8 ) && objweapon.classname != "turret" && ( weapon::iscacprimaryweapon( objweapon, weapongroup ) || weapon::iscacsecondaryweapon( objweapon, weapongroup ) ) && !weapon::isunderwaterweaponobject( objweapon ) && !weapon::isclimbweaponobject( objweapon );
        level.var_d163cf3023878336[ var_eadb663a1292c9e8 ] = isdroppableweapon;
    }
    
    return level.var_d163cf3023878336[ var_eadb663a1292c9e8 ];
}

// Namespace weapons
// Params 2
// Checksum 0xea18ad2e, Offset: 0xd3ef
// Size: 0x65, Type: bool
function isdroppableweapon( player, objweapon )
{
    assert( isweapon( objweapon ), "<dev string:x725>" );
    return function_332fbb2b4f3ecb4e( objweapon ) && !weapon::isbackuppistol( objweapon ) && ( level.gametypebundle.var_9957553c90f0f08e || !weapon::iscurrenttertiaryweapon( player, objweapon ) );
}

// Namespace weapons
// Params 1
// Checksum 0xdac517e4, Offset: 0xd45d
// Size: 0x13a
function function_1b01bc71375a78f1( objweapon )
{
    var_eadb663a1292c9e8 = objweapon.basenamehash;
    
    if ( !isdefined( level.var_12f0abfa1a0afb08[ var_eadb663a1292c9e8 ] ) )
    {
        if ( !isdefined( level.var_12f0abfa1a0afb08 ) )
        {
            level.var_12f0abfa1a0afb08 = [];
        }
        
        var_1344ad15d2d7bd21 = weapon::function_1344ad15d2d7bd21( objweapon );
        var_e0108b1955ca6157 = weapon::iskillstreakweaponname( objweapon.basename ) && !var_1344ad15d2d7bd21;
        var_dc0ab3bd303a8ac7 = var_1344ad15d2d7bd21 || objweapon.inventorytype == "primary" || objweapon.inventorytype == "altmode";
        var_1b01bc71375a78f1 = var_eadb663a1292c9e8 != %"none" && objweapon.classname != "turret" && !weapon::function_d4dcd88477cfa8ca( var_eadb663a1292c9e8 ) && !var_e0108b1955ca6157 && !weapon::function_e93a21a657377115( objweapon ) && !weapon::function_4c948bc86e32680a( var_eadb663a1292c9e8 ) && !weapon::isclimbweaponobject( objweapon ) && var_dc0ab3bd303a8ac7;
        level.var_12f0abfa1a0afb08[ var_eadb663a1292c9e8 ] = var_1b01bc71375a78f1;
    }
    
    return level.var_12f0abfa1a0afb08[ var_eadb663a1292c9e8 ];
}

// Namespace weapons
// Params 0
// Checksum 0x4c35a01, Offset: 0xd5a0
// Size: 0xd8
function updatemovespeedonweaponchange()
{
    self endon( #"death_or_disconnect", #"faux_spawn" );
    
    while ( true )
    {
        self waittill( #"weapon_change", objnewweapon );
        
        if ( objnewweapon.basename == "none" )
        {
            continue;
        }
        else if ( weapon::issuperweapon( objnewweapon.basename ) )
        {
            updatemovespeedscale();
            continue;
        }
        else if ( weapon::iskillstreakweapon( objnewweapon.basename ) )
        {
            continue;
        }
        else if ( weapon::isfistweapon( objnewweapon ) )
        {
            updatemovespeedscale();
            continue;
        }
        else if ( objnewweapon.inventorytype != "primary" && objnewweapon.inventorytype != "altmode" )
        {
            continue;
        }
        
        updatemovespeedscale();
    }
}

// Namespace weapons
// Params 1
// Checksum 0xd2d35c91, Offset: 0xd680
// Size: 0x111
function getweaponspeedslowest( weaponlist )
{
    slowestspeed = 2;
    
    if ( weaponlist.size )
    {
        foreach ( weapon in weaponlist )
        {
            if ( weapon::iskillstreakweaponname( weapon.basename ) )
            {
                weaponspeed = killstreak_utility::getkillstreakmovespeedscale( weapon );
            }
            else if ( weapon::function_bfe11051df303c94( weapon ) )
            {
                weaponspeed = getgamemodeweaponspeed( weapon );
            }
            else
            {
                weaponspeed = getweaponspeed( weapon );
            }
            
            if ( weaponspeed == 0 )
            {
                continue;
            }
            
            if ( weaponspeed < slowestspeed )
            {
                slowestspeed = weaponspeed;
            }
        }
        
        /#
            if ( slowestspeed == 2 )
            {
                assertmsg( "<dev string:x758>" );
            }
        #/
    }
    else
    {
        slowestspeed = 0.85;
    }
    
    return slowestspeed;
}

// Namespace weapons
// Params 1
// Checksum 0xf190095f, Offset: 0xd79a
// Size: 0xcb
function getweaponspeed( weapon )
{
    rootweapon = weapon::function_170e300815e9c1a2( weapon );
    
    /#
        if ( isdefined( rootweapon ) && !( isdefined( level.weaponmapdata[ rootweapon ] ) && isdefined( level.weaponmapdata[ rootweapon ].speed ) ) )
        {
            println( "<dev string:x775>" + rootweapon + "<dev string:x79e>" );
            return 1;
        }
    #/
    
    if ( !( isdefined( rootweapon ) && isdefined( level.weaponmapdata[ rootweapon ] ) && isdefined( level.weaponmapdata[ rootweapon ].speed ) ) )
    {
        assertmsg( "<dev string:x7bd>" + rootweapon );
        return 1;
    }
    
    return level.weaponmapdata[ rootweapon ].speed;
}

// Namespace weapons
// Params 1
// Checksum 0xc3e4977c, Offset: 0xd86e
// Size: 0x11
function getgamemodeweaponspeed( weapon )
{
    return 0.93;
}

// Namespace weapons
// Params 1
// Checksum 0x4173ca92, Offset: 0xd888
// Size: 0x40
function clampweaponspeed( value )
{
    assert( value >= 0 && value <= 1, "<dev string:x7e9>" + value );
    return clamp( value, 0, 1 );
}

// Namespace weapons
// Params 1
// Checksum 0x7241ea67, Offset: 0xd8d1
// Size: 0x106
function updateviewkickscale( perc )
{
    if ( isdefined( perc ) )
    {
        self.viewkickscale = perc;
    }
    
    if ( isdefined( self.overchargeviewkickscale ) )
    {
        perc = self.overchargeviewkickscale;
    }
    else if ( isdefined( self.overrideviewkickscale ) )
    {
        perc = self.overrideviewkickscale;
        flinchtype = weapon::weapongetflinchtype( self getcurrentweapon() );
        
        if ( flinchtype == 1 )
        {
            perc = self.overrideviewkickscalepistol;
        }
        else if ( flinchtype == 3 )
        {
            perc = self.overrideviewkickscaledmr;
        }
        else if ( flinchtype == 4 )
        {
            perc = self.overrideviewkickscalesniper;
        }
    }
    else if ( isdefined( self.viewkickscale ) )
    {
        perc = self.viewkickscale;
    }
    else
    {
        perc = 1;
    }
    
    assert( perc >= 0 && perc <= 1, "<dev string:x813>" );
    perc = clamp( perc, 0, 1 );
    self setviewkickscale( perc );
}

// Namespace weapons
// Params 0
// Checksum 0xfea990bf, Offset: 0xd9df
// Size: 0x10
function function_1a21795a419517d7()
{
    return getdvarint( @"hash_443d1da7a531d52f", 0 );
}

// Namespace weapons
// Params 0
// Checksum 0xaa6e9d09, Offset: 0xd9f8
// Size: 0x52f
function updatemovespeedscale()
{
    if ( function_1a21795a419517d7() )
    {
        common::function_79211cd1f2b54512();
        return;
    }
    
    speedperc = undefined;
    maxspeedboost = level.gametypebundle.var_94feb4984cb0762a ?? level.gamemodebundle.maxspeedboost ?? 1.08;
    maxspeedboost = isdefined( self.perks[ "specialty_super_speed_script" ] ) ? getdvarfloat( @"hash_94084550cb0f64e7", 2 ) : maxspeedboost;
    
    if ( getdvarint( @"hash_92bf2c85743f3db6", 0 ) )
    {
        var_d065771694596a53 = function_a74eb793b3c462d2();
        
        if ( isdefined( var_d065771694596a53 ) )
        {
            maxspeedboost = var_d065771694596a53;
        }
    }
    
    if ( isdefined( self.playerstreakspeedscale ) )
    {
        speedperc = 1;
        speedperc += self.playerstreakspeedscale;
    }
    else
    {
        speedperc = getplayerspeedbyweapon();
        
        if ( isdefined( self.overrideweaponspeed_speedscale ) )
        {
            speedperc = self.overrideweaponspeed_speedscale;
        }
        
        chilldata = self.chill_data;
        
        if ( isdefined( chilldata.speedmod ) )
        {
            speedperc += chilldata.speedmod;
        }
        
        if ( isdefined( self.gasspeedmod ) )
        {
            speedperc += self.gasspeedmod;
        }
        
        if ( isdefined( self.poisonspeedmod ) )
        {
            speedperc += self.poisonspeedmod;
        }
        
        if ( isdefined( self.disabledspeedmod ) )
        {
            speedperc += self.disabledspeedmod;
        }
        
        if ( isdefined( self.bulletDamageMeleeSlowMod ) )
        {
            speedperc += self.bulletDamageMeleeSlowMod;
        }
        
        if ( isdefined( self.var_63c0fb8343d7d16d ) )
        {
            speedperc += self.var_63c0fb8343d7d16d;
        }
        
        if ( isdefined( self.remoterobotspeed ) )
        {
            speedperc += self.remoterobotspeed;
        }
        
        if ( isdefined( self.speedonkillmod ) )
        {
            speedperc += self.speedonkillmod;
        }
        
        if ( isdefined( self.momentumspeedincrease ) )
        {
            speedperc += self.momentumspeedincrease;
        }
    }
    
    self.weaponspeed = speedperc;
    assert( isdefined( self.weaponspeed ) );
    assert( isdefined( self.movespeedscaler ) );
    
    if ( !isdefined( self.combatspeedscalar ) )
    {
        self.combatspeedscalar = 1;
    }
    
    speedperc += self.movespeedscaler - 1;
    speedperc += self.combatspeedscalar - 1;
    
    if ( isdefined( self.var_2d0e74f429afe5a0 ) )
    {
        foreach ( extraspeed in self.var_2d0e74f429afe5a0 )
        {
            speedperc += extraspeed;
        }
    }
    
    if ( isdefined( self.var_e5996377e9a13e32 ) )
    {
        foreach ( var_b39e5fef59c72627 in self.var_e5996377e9a13e32 )
        {
            speedperc *= var_b39e5fef59c72627;
        }
    }
    
    if ( isdefined( self.var_77a21d85c8390691 ) )
    {
        speedperc += self.var_77a21d85c8390691 - 1;
    }
    
    if ( isdefined( self.fastcrouchspeedmod ) )
    {
        speedperc += self.fastcrouchspeedmod;
    }
    
    if ( !isdefined( self.playerstreakspeedscale ) && isdefined( self.outlanderspeedmod ) )
    {
        speedperc += self.outlanderspeedmod;
    }
    
    if ( isdefined( self.var_923f8270632d115c ) )
    {
        speedperc += self.var_923f8270632d115c;
    }
    
    if ( isdefined( self.var_d33bc9b8c3cec4b1 ) && self.inlaststand && !isdefined( self.ishaywire ) )
    {
        speedperc += self.var_d33bc9b8c3cec4b1;
    }
    
    if ( isdefined( self.resolutespeedmod ) )
    {
        speedperc += self.resolutespeedmod;
    }
    
    if ( isdefined( self.perkzombielegsspeedmod ) )
    {
        speedperc += self.perkzombielegsspeedmod;
    }
    
    if ( isdefined( self.var_e4a9297720ec2e5 ) )
    {
        speedperc += self.var_e4a9297720ec2e5;
    }
    
    if ( isdefined( self.riftspeedmod ) )
    {
        speedperc += self.riftspeedmod;
    }
    
    if ( isdefined( self.skillspeedmod ) )
    {
        speedperc += self.skillspeedmod;
    }
    
    if ( self.stancespeedmod )
    {
        speedperc += self.stancespeedmod;
    }
    
    if ( getdvarint( @"hash_b7318d7f06303895", 0 ) == 0 )
    {
        speedperc = clamp( speedperc, 0, maxspeedboost );
    }
    
    /#
        movespeedtest = getdvarfloat( @"movespeed_test", 1 );
        
        if ( movespeedtest != 1 )
        {
            self setmovespeedscale( movespeedtest );
            return;
        }
    #/
    
    self.var_10642c4e8e304f16 = speedperc;
    self setmovespeedscale( speedperc );
}

// Namespace weapons
// Params 2
// Checksum 0x779699f5, Offset: 0xdf2f
// Size: 0x39
function addextramovespeed( str_id, value )
{
    if ( !isdefined( self.var_2d0e74f429afe5a0 ) )
    {
        self.var_2d0e74f429afe5a0 = [];
    }
    
    self.var_2d0e74f429afe5a0[ str_id ] = value;
}

// Namespace weapons
// Params 1
// Checksum 0x8f7f02cf, Offset: 0xdf70
// Size: 0x2f
function removeextramovespeed( str_id )
{
    assert( isdefined( self.var_2d0e74f429afe5a0 ), "<dev string:x850>" );
    self.var_2d0e74f429afe5a0[ str_id ] = undefined;
}

// Namespace weapons
// Params 1
// Checksum 0x5ee94905, Offset: 0xdfa7
// Size: 0x19, Type: bool
function function_67041fa03f87323c( str_id )
{
    return isdefined( self.var_2d0e74f429afe5a0[ str_id ] );
}

// Namespace weapons
// Params 2
// Checksum 0xdbf8220d, Offset: 0xdfc9
// Size: 0x39
function function_4512b7715789e4cf( str_id, value )
{
    if ( !isdefined( self.var_e5996377e9a13e32 ) )
    {
        self.var_e5996377e9a13e32 = [];
    }
    
    self.var_e5996377e9a13e32[ str_id ] = value;
}

// Namespace weapons
// Params 1
// Checksum 0x2311b937, Offset: 0xe00a
// Size: 0x2f
function function_986fc44dada307f4( str_id )
{
    assert( isdefined( self.var_e5996377e9a13e32 ), "<dev string:x874>" );
    self.var_e5996377e9a13e32[ str_id ] = undefined;
}

// Namespace weapons
// Params 1
// Checksum 0xa1490b5b, Offset: 0xe041
// Size: 0x19, Type: bool
function function_8131aea7eb196354( str_id )
{
    return isdefined( self.var_e5996377e9a13e32[ str_id ] );
}

// Namespace weapons
// Params 2
// Checksum 0xd0ece402, Offset: 0xe063
// Size: 0x6f
function function_6dc9cf7257519243( str_id, max_speed_override_value )
{
    if ( !isarray( self.var_80e0fc2d2fd3d654 ) )
    {
        self.var_80e0fc2d2fd3d654 = [];
    }
    
    if ( !isdefined( self.var_8f5343205d4cc42f ) )
    {
        self.var_8f5343205d4cc42f = max_speed_override_value;
    }
    
    if ( max_speed_override_value > self.var_8f5343205d4cc42f )
    {
        self.var_8f5343205d4cc42f = max_speed_override_value;
    }
    
    self.var_80e0fc2d2fd3d654[ str_id ] = max_speed_override_value;
}

// Namespace weapons
// Params 1
// Checksum 0x1288e974, Offset: 0xe0da
// Size: 0xc8
function function_c0a6483a3e0d7ebe( str_id )
{
    self.var_80e0fc2d2fd3d654[ str_id ] = undefined;
    
    if ( self.var_80e0fc2d2fd3d654.size == 0 )
    {
        self.var_8f5343205d4cc42f = undefined;
        return;
    }
    
    self.var_8f5343205d4cc42f = 0;
    
    foreach ( speedoverride in self.var_80e0fc2d2fd3d654 )
    {
        if ( speedoverride > self.var_8f5343205d4cc42f )
        {
            self.var_8f5343205d4cc42f = speedoverride;
        }
    }
}

// Namespace weapons
// Params 0
// Checksum 0x3819b2bc, Offset: 0xe1aa
// Size: 0xb
function function_a74eb793b3c462d2()
{
    return self.var_8f5343205d4cc42f;
}

// Namespace weapons
// Params 1
// Checksum 0x5324b43a, Offset: 0xe1be
// Size: 0x46
function weapon_giveperk( perkname )
{
    if ( !isdefined( self.weaponperks ) )
    {
        self.weaponperks = [];
    }
    
    if ( weapon_hasperk( perkname ) )
    {
        return;
    }
    
    perk::giveperk( perkname );
    self.weaponperks[ perkname ] = 1;
}

// Namespace weapons
// Params 1
// Checksum 0xd3256f95, Offset: 0xe20c
// Size: 0x2c
function weapon_removeperk( perkname )
{
    if ( weapon_hasperk( perkname ) )
    {
        perk::removeperk( perkname );
        self.weaponperks[ perkname ] = undefined;
    }
}

// Namespace weapons
// Params 1
// Checksum 0x7d72ce1d, Offset: 0xe240
// Size: 0x19, Type: bool
function weapon_hasperk( perkname )
{
    return istrue( self.weaponperks[ perkname ] );
}

// Namespace weapons
// Params 0
// Checksum 0x9f6f9f00, Offset: 0xe262
// Size: 0x1a5
function getplayerspeedbyweapon()
{
    weaponspeed = 1;
    self.weaponlist = self getweaponslistprimaries();
    
    if ( !self.weaponlist.size )
    {
        weaponspeed = 0.85;
    }
    else
    {
        objweapon = self getcurrentweapon();
        
        if ( !isdefined( objweapon ) )
        {
            weaponspeed = getweaponspeedslowest( self.weaponlist );
        }
        else if ( weapon::function_bfe11051df303c94( objweapon ) )
        {
            weaponspeed = getgamemodeweaponspeed( objweapon );
        }
        else if ( weapon::iskillstreakweaponname( objweapon.basename ) )
        {
            weaponspeed = killstreak_utility::getkillstreakmovespeedscale( objweapon );
        }
        else if ( weapon::function_4c948bc86e32680a( objweapon.basenamehash ) )
        {
            weaponspeed = 0.85;
        }
        else
        {
            if ( objweapon.inventorytype != "primary" && objweapon.inventorytype != "altmode" || weapon::function_e93a21a657377115( objweapon ) )
            {
                objweapon = self.lastnormalweaponobj;
            }
            
            if ( !self hasweapon( objweapon ) )
            {
                weaponspeed = getweaponspeedslowest( self.weaponlist );
            }
            else
            {
                weaponspeed = getweaponspeed( objweapon );
                
                /#
                    if ( !isdefined( weaponspeed ) || weaponspeed == 0 )
                    {
                        weaponspeed = 1;
                    }
                #/
                
                if ( game_utility::function_d3f8957534dc62af() )
                {
                    class = weaponclass( objweapon );
                    
                    if ( isdefined( level.var_838828a17c03692f[ class ] ) )
                    {
                        weaponspeed = level.var_838828a17c03692f[ class ];
                    }
                }
            }
        }
    }
    
    weaponspeed = clampweaponspeed( weaponspeed );
    
    if ( isdefined( self.overrideweaponspeed_speedscale ) && function_1a21795a419517d7() )
    {
        weaponspeed = self.overrideweaponspeed_speedscale;
    }
    
    return weaponspeed;
}

// Namespace weapons
// Params 0
// Checksum 0xb4a6515b, Offset: 0xe410
// Size: 0xed
function stancerecoiladjuster()
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    self endon( #"death_or_disconnect", #"faux_spawn" );
    self notifyonplayercommand( "adjustedStance", "+stance" );
    self notifyonplayercommand( "adjustedStance", "+goStand" );
    
    if ( !self isconsoleplayer() && !isai( self ) )
    {
        self notifyonplayercommand( "adjustedStance", "+togglecrouch" );
        self notifyonplayercommand( "adjustedStance", "toggleprone" );
        self notifyonplayercommand( "adjustedStance", "+movedown" );
        self notifyonplayercommand( "adjustedStance", "-movedown" );
        self notifyonplayercommand( "adjustedStance", "+prone" );
        self notifyonplayercommand( "adjustedStance", "-prone" );
    }
    
    for ( ;; )
    {
        utility::waittill_any( "adjustedStance", "sprint_begin", "weapon_change" );
        wait 0.5;
        stance = self getstance();
        stancerecoilupdate( stance );
    }
}

// Namespace weapons
// Params 1
// Checksum 0xd41e990a, Offset: 0xe505
// Size: 0x138
function stancerecoilupdate( stance )
{
    weapon = self getcurrentprimaryweapon();
    sniperreduction = 0;
    
    if ( isrecoilreducingweapon( weapon ) )
    {
        sniperreduction = getrecoilreductionvalue();
    }
    
    if ( stance == "prone" )
    {
        weapgroup = weapon::getweapongroup( weapon );
        
        if ( weapgroup == "weapon_lmg" )
        {
            utility::setrecoilscale( 0, 0 );
        }
        else if ( weapgroup == "weapon_sniper" )
        {
            if ( weapon hasattachment( "barrelbored" ) )
            {
                utility::setrecoilscale( 0, 0 + sniperreduction );
            }
            else
            {
                utility::setrecoilscale( 0, 0 + sniperreduction );
            }
        }
        else
        {
            utility::setrecoilscale();
        }
        
        return;
    }
    
    if ( stance == "crouch" )
    {
        weapgroup = weapon::getweapongroup( weapon );
        
        if ( weapgroup == "weapon_lmg" )
        {
            utility::setrecoilscale( 0, 0 );
        }
        else if ( weapgroup == "weapon_sniper" )
        {
            if ( weapon hasattachment( "barrelbored" ) )
            {
                utility::setrecoilscale( 0, 0 + sniperreduction );
            }
            else
            {
                utility::setrecoilscale( 0, 0 + sniperreduction );
            }
        }
        else
        {
            utility::setrecoilscale();
        }
        
        return;
    }
    
    if ( sniperreduction > 0 )
    {
        utility::setrecoilscale( 0, sniperreduction );
        return;
    }
    
    utility::setrecoilscale();
}

// Namespace weapons
// Params 0
// Checksum 0x9dc42f06, Offset: 0xe645
// Size: 0x14e
function deleteallgrenades()
{
    if ( isdefined( level.grenades ) )
    {
        foreach ( grenade in level.grenades )
        {
            if ( isdefined( grenade ) && !grenade.exploding && !isplantedequipment( grenade ) )
            {
                grenade delete();
            }
        }
    }
    
    if ( isdefined( level.missiles ) )
    {
        foreach ( missile in level.missiles )
        {
            if ( isdefined( missile ) && !missile.exploding && !isplantedequipment( missile ) )
            {
                missile delete();
            }
        }
    }
}

// Namespace weapons
// Params 0
// Checksum 0xb6f4d075, Offset: 0xe79b
// Size: 0x4
function minegettwohitthreshold()
{
    return 80;
}

// Namespace weapons
// Params 0
// Checksum 0xd46135ba, Offset: 0xe7a8
// Size: 0x35, Type: bool
function function_38d242db575562b9()
{
    if ( self.isequipment && isdefined( self.bundle ) )
    {
        return ( self.bundle.var_43e37758f47c2542 ?? 0 );
    }
    
    return false;
}

// Namespace weapons
// Params 4
// Checksum 0x76fd4ec8, Offset: 0xe7e6
// Size: 0x110
function function_2f8a8c370d418aef( attackerplayer, var_7731d58f6f82f082, damagefeedback, isdestroyed )
{
    damagefeedbackcategory = undefined;
    var_795e8a31194a39ac = { #victimentity:var_7731d58f6f82f082.victim };
    
    if ( utility::isbulletdamage( var_7731d58f6f82f082.mod ) )
    {
        damagefeedbackcategory = 3;
        
        if ( isdefined( var_7731d58f6f82f082.victim.weapon_object ) )
        {
            var_256fdc12660ff342 = weapon::getequipmenttype( var_7731d58f6f82f082.victim.weapon_object );
        }
        
        if ( isdefined( var_256fdc12660ff342 ) && ( var_256fdc12660ff342 == "lethal" || var_256fdc12660ff342 == "tactical" || var_256fdc12660ff342 == "super" ) )
        {
            var_7731d58f6f82f082 = undefined;
            var_795e8a31194a39ac.var_f561a4dd442b0d91 = 1;
            var_795e8a31194a39ac.var_4dba57e6e29ded8e = 1;
        }
    }
    else
    {
        damagefeedbackcategory = 2;
    }
    
    attackerplayer damagefeedback::updatedamagefeedback( damagefeedback, isdestroyed, undefined, undefined, undefined, undefined, undefined, undefined, var_795e8a31194a39ac, var_7731d58f6f82f082, undefined, damagefeedbackcategory );
}

// Namespace weapons
// Params 2
// Checksum 0xe2be28e2, Offset: 0xe8fe
// Size: 0x608
function minedamagemonitor( hitsmax, var_64fd1fda14bc4550 )
{
    self endon( #"mine_selfdestruct" );
    self endon( #"death" );
    self setcandamage( 1 );
    self.maxhealth = 999999;
    self.health = self.maxhealth;
    attacker = undefined;
    hits = hitsmax ?? 1;
    damagefeedback = "hitequip";
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        objweapon = weapon::mapweapon( objweapon, inflictor );
        utility::callsharedfunc( #"equipment_interaction", #"on_hit", self, attacker, inflictor, objweapon );
        
        if ( utility::callsharedfunc( #"equipment_interaction", #"ignore_damage", self, attacker, inflictor, objweapon ) )
        {
            continue;
        }
        
        attackerplayer = attacker;
        
        if ( !isplayer( attacker ) && !isagent( attacker ) )
        {
            if ( isplayer( attacker.owner ) )
            {
                attackerplayer = attacker.owner;
            }
        }
        
        if ( !game_utility_common::isgameparticipant( attackerplayer ) )
        {
            continue;
        }
        
        if ( isdefined( objweapon ) && isendstr( objweapon.basename, "betty_mp" ) )
        {
            continue;
        }
        
        if ( !var_64fd1fda14bc4550 && !friendlyfirecheck( self.owner, attackerplayer ) )
        {
            continue;
        }
        
        if ( damage::non_player_should_ignore_damage( attackerplayer, objweapon, inflictor, type ) )
        {
            continue;
        }
        
        if ( objweapon.isemp )
        {
            continue;
        }
        
        incominghits = 0;
        
        if ( damage >= function_38d242db575562b9() )
        {
            incominghits = damage::isfmjdamage( objweapon, type ) || damage >= 80 ? 2 : 1;
        }
        
        hits -= incominghits;
        equipmenthit( self.owner, attackerplayer, objweapon, type );
        
        if ( hits <= 0 )
        {
            break;
        }
        
        if ( damagefeedback::isusingstackablehitmarker() )
        {
            var_7731d58f6f82f082 = { #mod:type, #direction_vec:direction_vec, #point:point, #objweapon:objweapon, #victim:self };
            function_2f8a8c370d418aef( attackerplayer, var_7731d58f6f82f082, damagefeedback, 0 );
            continue;
        }
        
        attackerplayer damagefeedback::updatedamagefeedback( damagefeedback );
    }
    
    if ( isdefined( supers_mp::issuper( self.superref ) ) )
    {
        equipment_utility::function_9b8126f6415066aa( attacker );
        attacker battlechatter_mp::onfieldupgradedestroy( { #victim:self, #objweapon:objweapon, #meansofdeath:type } );
    }
    
    if ( isfunction( inflictor.var_57fc77af24a8791e ) )
    {
        inflictor [[ inflictor.var_57fc77af24a8791e ]]();
    }
    
    if ( isdefined( attacker ) && isdefined( attacker.perks[ "specialty_traceback" ] ) && utility::issharedfuncdefined( #"traceback", #"try_traceback" ) )
    {
        attacker [[ utility::getsharedfunc( #"traceback", #"try_traceback" ) ]]( self );
    }
    
    self notify( #"mine_destroyed" );
    self notify( #"enemy_destroyed_equipment", attacker );
    
    if ( isdefined( type ) && ( issubstr( type, "MOD_GRENADE" ) || issubstr( type, "MOD_EXPLOSIVE" ) ) )
    {
        self.waschained = 1;
    }
    
    if ( isdefined( idflags ) && idflags & 8 )
    {
        self.wasdamagedfrombulletpenetration = 1;
    }
    
    if ( isdefined( idflags ) && idflags & 256 )
    {
        self.wasdamagedfrombulletricochet = 1;
    }
    
    self.wasdamaged = 1;
    
    if ( isdefined( attackerplayer ) )
    {
        self.damagedby = attackerplayer;
    }
    
    if ( isdefined( self.killcament ) )
    {
        self.killcament.damagedby = attackerplayer;
    }
    
    if ( isplayer( attackerplayer ) )
    {
        if ( damagefeedback::isusingstackablehitmarker() )
        {
            var_7731d58f6f82f082 = { #mod:type, #direction_vec:direction_vec, #point:point, #objweapon:objweapon, #victim:self };
            function_2f8a8c370d418aef( attackerplayer, var_7731d58f6f82f082, damagefeedback, 1 );
        }
        else
        {
            attackerplayer damagefeedback::updatedamagefeedback( damagefeedback );
        }
        
        if ( attackerplayer != self.owner && isdefined( self.owner.team ) && attackerplayer.team != self.owner.team )
        {
            attackerplayer equipment_mp::function_ada7da3083a6c593( self, objweapon );
            attackerplayer battlechatter_mp::equipmentdestroyed( self );
            challenges::equipmentdestroyed( self, inflictor, attacker, damage, idflags, undefined, objweapon, undefined, attackerplayer.modifiers );
            
            if ( self.isequipment || self.issuper )
            {
                var_7754a4583dbe5809 = inflictor.streakinfo;
                
                if ( !isdefined( var_7754a4583dbe5809 ) )
                {
                    var_7754a4583dbe5809 = inflictor.var_ec0bb630fbaa253a[ objweapon.basename ];
                }
                
                events::killedequipment( self.owner, attacker, objweapon, var_7754a4583dbe5809 );
            }
            
            params = { #equipmentref:self.superref ?? self.equipmentref, #inflictor:inflictor, #player:attacker, #event:#"on_destroyed_equipment" };
            level callback::callback( #"hash_6c71d319dc089c27", params );
        }
    }
    
    self notify( #"detonateexplosive", attackerplayer, objweapon );
}

// Namespace weapons
// Params 0
// Checksum 0xaed28f8e, Offset: 0xef0e
// Size: 0x52
function mineselfdestruct()
{
    self endon( #"mine_triggered" );
    self endon( #"mine_destroyed" );
    self endon( #"death" );
    wait level.mineselfdestructtime + randomfloat( 0.4 );
    self notify( #"mine_selfdestruct" );
    self notify( #"detonateexplosive" );
}

// Namespace weapons
// Params 0
// Checksum 0x2fe6bc9c, Offset: 0xef68
// Size: 0x204
function mineexplodeonnotify()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    self waittill( #"detonateexplosive", attacker );
    
    if ( !( isdefined( self ) && isdefined( self.owner ) ) )
    {
        return;
    }
    
    if ( !isdefined( attacker ) )
    {
        attacker = self.owner;
    }
    
    config = self.config;
    vfxtag = config.vfxtag;
    
    if ( !isdefined( vfxtag ) )
    {
        vfxtag = "tag_fx";
    }
    
    tagorigin = self gettagorigin( vfxtag );
    
    if ( !isdefined( tagorigin ) )
    {
        tagorigin = self gettagorigin( "tag_origin" );
    }
    
    self notify( #"explode", tagorigin );
    waitframe();
    
    if ( !( isdefined( self ) && isdefined( self.owner ) ) )
    {
        return;
    }
    
    self hide();
    
    if ( isdefined( config.onexplodefunc ) )
    {
        self thread [[ config.onexplodefunc ]]();
    }
    
    if ( isdefined( config.onexplodesfx ) )
    {
        self playsound( config.onexplodesfx );
    }
    
    onexplodevfx = config.onexplodevfx ?? level.mine_explode;
    playfx( onexplodevfx, tagorigin );
    minedamagemin = config.minedamagemin ?? level.minedamagemin;
    minedamagemax = config.minedamagemax ?? level.minedamagemax;
    minedamageradius = config.minedamageradius ?? level.minedamageradius;
    
    if ( minedamagemax > 0 )
    {
        self radiusdamage( self.origin, minedamageradius, minedamagemax, minedamagemin, attacker, "MOD_EXPLOSIVE", self.weapon_name );
    }
    
    if ( isdefined( self.owner ) )
    {
        self.owner thread dialog::leaderdialogonplayer( "mine_destroyed", undefined, undefined, self.origin );
    }
    
    wait 0.2;
    deleteexplosive();
}

// Namespace weapons
// Params 0
// Checksum 0x8fc3f5a6, Offset: 0xf174
// Size: 0x17e
function function_c744ba16f0b27657()
{
    var_e7d57b6062e09179 = getdvarint( @"hash_225e942096726fc0", 1 );
    
    if ( isdefined( self.plantedlethalequip ) )
    {
        foreach ( equip in self.plantedlethalequip )
        {
            if ( isdefined( equip ) )
            {
                if ( equip.equipmentref != "equip_at_mine" || var_e7d57b6062e09179 == 1 )
                {
                    equip deleteexplosive();
                }
            }
        }
    }
    
    if ( isdefined( self.plantedlethalequip ) )
    {
        foreach ( equip in self.plantedlethalequip )
        {
            if ( equip.equipmentref == "equip_at_mine" && var_e7d57b6062e09179 == 0 )
            {
                continue;
            }
            
            self.plantedlethalequip = arrayremove( self.plantedlethalequip, equip );
        }
        
        return;
    }
    
    self.plantedlethalequip = [];
}

// Namespace weapons
// Params 4
// Checksum 0xea93cb6e, Offset: 0xf2fa
// Size: 0xc4
function function_7ccba8d0579ee4fc( equipmentlist, protectequip, var_ec20c219de776913, var_cbdabd721a2ef0d )
{
    returnarray = [];
    
    if ( isdefined( equipmentlist ) )
    {
        foreach ( index, equip in equipmentlist )
        {
            if ( [[ var_cbdabd721a2ef0d ]]( equip, protectequip, var_ec20c219de776913 ) )
            {
                equip deleteexplosive();
                equipmentlist[ index ] = undefined;
            }
        }
        
        returnarray = function_5713d46873b29625( equipmentlist );
    }
    
    return returnarray;
}

// Namespace weapons
// Params 3
// Checksum 0x8c5a3d5d, Offset: 0xf3c7
// Size: 0x29
function function_b05746869c4d6295( equip, protectequip, var_ec20c219de776913 )
{
    function_d08e9d9923bdcee9( equip, protectequip, var_ec20c219de776913 );
}

// Namespace weapons
// Params 3
// Checksum 0xb6aba1fb, Offset: 0xf3f8
// Size: 0x7d, Type: bool
function function_d08e9d9923bdcee9( equip, protectequip, var_ec20c219de776913 )
{
    if ( equip.issuper && !var_ec20c219de776913 )
    {
        return false;
    }
    
    if ( protectequip )
    {
        return ![[ utility::getsharedfunc( #"specialty_mod_planted_equipment_death", #"hash_c0350b9bbb29318b" ) ]]( equip.equipmentref );
    }
    
    if ( equip.bundle.persist_through_death )
    {
        return false;
    }
    
    return true;
}

// Namespace weapons
// Params 1
// Checksum 0x4b7976c1, Offset: 0xf47e
// Size: 0x130
function deleteplacedequipment( var_8bdd11dc1b7a989 )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    var_7a15f5f452cd4937 = isdefined( self.perks[ "specialty_mod_planted_equipment_death" ] );
    
    if ( !var_7a15f5f452cd4937 )
    {
        callback::callback( #"hash_24b3af63a40d9840" );
    }
    
    if ( war::function_cb4f30fbcf17ff2() )
    {
        function_c744ba16f0b27657();
    }
    else
    {
        self.plantedlethalequip = function_7ccba8d0579ee4fc( self.plantedlethalequip, var_7a15f5f452cd4937, undefined, &function_d08e9d9923bdcee9 );
    }
    
    self.plantedtacticalequip = function_7ccba8d0579ee4fc( self.plantedtacticalequip, var_7a15f5f452cd4937, undefined, &function_d08e9d9923bdcee9 );
    
    if ( level.var_613ba3e28ca2d235 )
    {
        self.var_68db24a5acce8b08 = function_7ccba8d0579ee4fc( self.var_68db24a5acce8b08, var_7a15f5f452cd4937, undefined, &function_d08e9d9923bdcee9 );
    }
    
    var_e9a465fd82a47943 = ( var_8bdd11dc1b7a989 ?? game_utility_mp::isanymlgmatch() ) || level.superglobals.var_a817308d8d92ff8c;
    self.plantedhackedequip = function_7ccba8d0579ee4fc( self.plantedhackedequip, var_7a15f5f452cd4937, var_e9a465fd82a47943, &function_b05746869c4d6295 );
    self.plantedsuperequip = function_7ccba8d0579ee4fc( self.plantedsuperequip, var_7a15f5f452cd4937, var_e9a465fd82a47943, &function_d08e9d9923bdcee9 );
}

// Namespace weapons
// Params 0
// Checksum 0xfb71084e, Offset: 0xf5b6
// Size: 0x2a6
function deletedisparateplacedequipment()
{
    lethal = equipment_mp::getcurrentequipment( "primary" );
    
    foreach ( equip in self.plantedlethalequip )
    {
        if ( isdefined( equip ) && !equip.bundle.persist_through_death )
        {
            if ( !( isdefined( equip.equipmentref ) && isdefined( lethal ) ) || equip.equipmentref != lethal )
            {
                if ( equip.equipmentref != "equip_at_mine" || getdvarint( @"hash_225e942096726fc0", 1 ) == 1 )
                {
                    equip deleteexplosive();
                }
            }
        }
    }
    
    tactical = equipment_mp::getcurrentequipment( "secondary" );
    
    foreach ( equip in self.plantedtacticalequip )
    {
        if ( isdefined( equip ) && !equip.bundle.persist_through_death )
        {
            if ( !( isdefined( equip.equipmentref ) && isdefined( tactical ) ) || equip.equipmentref != tactical )
            {
                equip deleteexplosive();
            }
        }
    }
    
    if ( level.var_613ba3e28ca2d235 )
    {
        tertiary = equipment_mp::getcurrentequipment( "tertiary" );
        
        foreach ( equip in self.var_68db24a5acce8b08 )
        {
            if ( isdefined( equip ) && !equip.bundle.persist_through_death )
            {
                if ( !( isdefined( equip.equipmentref ) && isdefined( tertiary ) ) || equip.equipmentref != tertiary )
                {
                    equip deleteexplosive();
                }
            }
        }
    }
}

// Namespace weapons
// Params 2
// Checksum 0xdd0570, Offset: 0xf864
// Size: 0x10a
function equipmentdeletevfx( position, angles )
{
    if ( isdefined( position ) )
    {
        if ( isdefined( angles ) )
        {
            forward = anglestoforward( angles );
            up = anglestoup( angles );
            playfx( utility::getfx( "equipment_explode" ), position, forward, up );
            playfx( utility::getfx( "equipment_smoke" ), position, forward, up );
        }
        else
        {
            playfx( utility::getfx( "equipment_explode" ), position );
            playfx( utility::getfx( "equipment_smoke" ), position );
        }
        
        playsoundatpos( position, "mp_killstreak_disappear" );
        return;
    }
    
    if ( isdefined( self ) )
    {
        origin = self.origin;
        forward = anglestoforward( self.angles );
        up = anglestoup( self.angles );
        playfx( utility::getfx( "equipment_explode" ), origin, forward, up );
        playfx( utility::getfx( "equipment_smoke" ), origin, forward, up );
        self playsound( "mp_killstreak_disappear" );
    }
}

// Namespace weapons
// Params 5
// Checksum 0xf0b8d0bd, Offset: 0xf976
// Size: 0x360
function grenadestuckto( grenade, stuckto, ignoresplash, var_7f3fdce4d25dd061 = 0, var_b36f1004c0031c91 )
{
    player = self;
    
    if ( !isplayer( player ) && !isagent( player ) )
    {
        assertmsg( "<dev string:x898>" );
        
        if ( isdefined( self.owner ) )
        {
            player = self.owner;
        }
    }
    
    if ( !isdefined( grenade ) )
    {
        return;
    }
    
    if ( !isdefined( player ) )
    {
        grenade.stuckenemyentity = stuckto;
        stuckto.stuckbygrenade = grenade;
        stuckto.stuckbygrenadeowner = grenade.owner;
        return;
    }
    
    if ( level.teambased && stuckto.team == player.team )
    {
        grenade.isstuck = "friendly";
        return;
    }
    
    var_e82e27d4ca35d1ea = grenade.bundle.var_7fee7a3848ebc7b6;
    var_47c9c0e518a36d58 = grenade.bundle.var_47c9c0e518a36d58 ?? 0;
    var_619ef5004de57bf0 = 0;
    
    if ( !isdefined( var_e82e27d4ca35d1ea ) && isdefined( grenade.weapon_name ) )
    {
        switch ( grenade.weapon_name )
        {
            case #"hash_1b88dcbd82bcbda7":
                var_e82e27d4ca35d1ea = #"semtex_cer";
                var_47c9c0e518a36d58 = 1;
                break;
            case #"hash_3bd24ab285a16b1e":
                var_619ef5004de57bf0 = 2;
                break;
            case #"hash_e5bd5c73b30f4a5":
            case #"hash_4b87af60037f526f":
                var_e82e27d4ca35d1ea = #"semtex_stuck";
                break;
            case #"hash_a6a89d9bef5cf698":
                var_619ef5004de57bf0 = 1;
                break;
            case #"hash_ab3485fa6834de47":
                var_e82e27d4ca35d1ea = #"molotov_stuck";
                break;
            case #"hash_4c7de5619284e175":
                var_e82e27d4ca35d1ea = #"thermite_attacker_stuck";
                break;
            case #"hash_4a85ee2b82965fe2":
                var_e82e27d4ca35d1ea = #"sonar_pulse_stuck";
                break;
            case #"hash_954bb5f200a1b95a":
                var_e82e27d4ca35d1ea = #"shock_stick_stuck";
                break;
            case #"hash_c4b9b21ecac2ced4":
            case #"hash_d6565ec12efca627":
                var_e82e27d4ca35d1ea = #"bunkerbuster_stuck";
                break;
        }
    }
    
    grenade.var_b36f1004c0031c91 = var_b36f1004c0031c91;
    grenade.isstuck = "enemy";
    grenade.stuckenemyentity = stuckto;
    stuckto.stuckbygrenade = grenade;
    stuckto.stuckbygrenadeowner = grenade.owner;
    
    if ( hasomnvar( o"ui_grenade_stuck_type" ) && isplayer( stuckto ) )
    {
        stuckto setclientomnvar( o"ui_grenade_stuck_type", var_619ef5004de57bf0 );
    }
    
    player notify( #"grenade_stuck_enemy" );
    stuckto notify( #"hash_f87944a3f6b5abe3", grenade );
    stuckto battlechatter_mp::function_72f2f594b3fdfcc2( grenade );
    
    if ( !ignoresplash && isplayer( player ) )
    {
        player grenadestucktosplash( var_e82e27d4ca35d1ea, stuckto, var_7f3fdce4d25dd061, var_47c9c0e518a36d58 );
        challenges::function_3d7a169dbae062fb( grenade.equipmentref, player, undefined, ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"stuck" ), undefined, var_7f3fdce4d25dd061 );
    }
}

// Namespace weapons
// Params 4
// Checksum 0x9777cc64, Offset: 0xfcde
// Size: 0x117
function grenadestucktosplash( var_e82e27d4ca35d1ea, stuckto, var_7f3fdce4d25dd061, var_47c9c0e518a36d58 )
{
    player = self;
    
    if ( ( isplayer( stuckto ) || isagent( stuckto ) ) && isdefined( var_e82e27d4ca35d1ea ) )
    {
        if ( isdefined( player.owner ) )
        {
            player = player.owner;
        }
        
        splashplayer = var_47c9c0e518a36d58 ? stuckto : player;
        
        if ( level.gamemodebundle.var_d27c489050e42598 )
        {
            splashplayer setclientomnvar( "ui_grenade_stuck_notify", gettime() );
        }
        else if ( getprojectname() != "JUP" )
        {
            if ( isplayer( splashplayer ) )
            {
                splashplayer thread hud_message::showsplash( var_e82e27d4ca35d1ea, undefined, undefined, undefined, 1, undefined, 1 );
            }
        }
    }
    
    if ( var_7f3fdce4d25dd061 )
    {
        player thread points::doscoreevent( #"long_semtex" );
        stuckto.var_2ce333df9ce87760[ player.guid ] = 1;
        return;
    }
    
    player thread points::doscoreevent( #"explosive_stick" );
}

// Namespace weapons
// Params 2
// Checksum 0xb53837aa, Offset: 0xfdfd
// Size: 0x163
function function_f38c6bdea2fb97f3( geostuck, waterstuck )
{
    if ( !isdefined( self ) || !geostuck && !waterstuck )
    {
        return;
    }
    
    ent = spawnstruct();
    
    if ( geostuck )
    {
        thread function_4c76ab0eac0570c3( "missile_stuck", ent );
    }
    
    if ( waterstuck )
    {
        thread function_4c76ab0eac0570c3( "missile_water_impact", ent );
    }
    
    ent waittill( #"returned", msg, param1, param2, param3, param4, param5, param6, param7, param8 );
    ent notify( #"die" );
    explodeinfo = spawnstruct();
    explodeinfo.msg = msg;
    explodeinfo.param1 = param1;
    explodeinfo.param2 = param2;
    explodeinfo.param3 = param3;
    explodeinfo.param4 = param4;
    explodeinfo.param5 = param5;
    explodeinfo.param6 = param6;
    explodeinfo.param7 = param7;
    explodeinfo.param8 = param8;
    return explodeinfo;
}

// Namespace weapons
// Params 2
// Checksum 0x32d98b7f, Offset: 0xff69
// Size: 0x9f
function function_4c76ab0eac0570c3( msg, ent )
{
    if ( msg != "death" )
    {
        self endon( #"death" );
    }
    
    ent endon( #"die" );
    self waittill( msg, param1, param2, param3, param4, param5, param6, param7 );
    ent notify( #"returned", msg, param1, param2, param3, param4, param5, param6, param7 );
}

// Namespace weapons
// Params 0, eflags: 0x4
// Checksum 0xffcc49be, Offset: 0x10010
// Size: 0xc
function private function_4b2218329e58e4ac()
{
    self.var_2ce333df9ce87760 = undefined;
}

// Namespace weapons
// Params 1
// Checksum 0x120b6b15, Offset: 0x10024
// Size: 0x6a
function outlineequipmentforowner( equipment )
{
    if ( !level.gamemodebundle.var_318d99125d1f4c40 )
    {
        return;
    }
    
    id = outline::outlineenableforplayer( equipment, equipment.owner, "equipment_own", "lowest" );
    equipment utility::waittill_any( "death", "ownerChanged" );
    outline::outlinedisable( id, equipment );
}

// Namespace weapons
// Params 2
// Checksum 0x8a475315, Offset: 0x10096
// Size: 0x38
function outlinesuperequipment( equipment, player )
{
    if ( level.teambased )
    {
        thread outlinesuperequipmentforteam( equipment, player );
        return;
    }
    
    thread outlinesuperequipmentforplayer( equipment, player );
}

// Namespace weapons
// Params 2
// Checksum 0x42a717f3, Offset: 0x100d6
// Size: 0x56
function outlinesuperequipmentforteam( equipment, player )
{
    id = outline::outlineenableforteam( equipment, player.team, "outline_nodepth_cyan", "killstreak" );
    equipment waittill( #"death" );
    outline::outlinedisable( id, equipment );
}

// Namespace weapons
// Params 2
// Checksum 0x301589f0, Offset: 0x10134
// Size: 0x4c
function outlinesuperequipmentforplayer( equipment, player )
{
    id = outline::outlineenableforplayer( equipment, player, "super_own", "killstreak" );
    equipment waittill( #"death" );
    outline::outlinedisable( id, equipment );
}

// Namespace weapons
// Params 2
// Checksum 0x861f8d69, Offset: 0x10188
// Size: 0x6d
function trace_impale( vpoint, endpoint )
{
    contents = physics_createcontents( [ "physicscontents_glass", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_item" ] );
    trace = trace::ray_trace_detail( vpoint, endpoint, level.players, contents, undefined, 1 );
    return trace;
}

// Namespace weapons
// Params 2
// Checksum 0x7d614ea7, Offset: 0x101fe
// Size: 0x2b
function impale_endpoint( vpoint, vdir )
{
    endpoint = vpoint + vdir * 4096;
    return endpoint;
}

// Namespace weapons
// Params 12
// Checksum 0xd2ab6aad, Offset: 0x10232
// Size: 0x396
function impale( eattacker, evictim, objweapon, vpointclient, vpoint, vdir, shitloc, spartname, var_56243ba4fafee4a5, var_ea333e2537a8fa73, var_2e6727b4a3db5100, isagent )
{
    evictim endon( #"death_or_disconnect" );
    
    if ( !isdefined( evictim ) )
    {
        return;
    }
    
    if ( isagent )
    {
        corpse = evictim;
    }
    else if ( isdefined( evictim.body ) )
    {
        corpse = evictim.body;
    }
    else
    {
        return;
    }
    
    if ( isagent )
    {
        if ( isdefined( corpse.aicategory ) && ( corpse.aicategory == "special" || corpse.aicategory == "elite" || corpse.aicategory == "hvt" || corpse.aicategory == "boss" ) )
        {
            return;
        }
    }
    
    isprojectile = isdefined( var_ea333e2537a8fa73 );
    
    if ( isprojectile )
    {
        isimpaling = 1;
    }
    else
    {
        playfx( utility::getfx( "penetration_railgun_impact" ), vpoint );
        endpoint = impale_endpoint( vpoint, vdir );
        trace = trace_impale( vpoint, endpoint );
        endpoint = trace[ "position" ] - vdir * 12;
        flightdist = length( endpoint - vpoint );
        flighttime = flightdist / 1000;
        flighttime = max( flighttime, 0.05 );
        assert( flightdist / flighttime <= 1100, "<dev string:x8c1>" );
        
        if ( trace[ "hittype" ] != "hittype_world" )
        {
            flighttime = 0;
        }
        
        isimpaling = flighttime > 0.05;
    }
    
    corpse startragdoll();
    waitframe();
    
    if ( isimpaling )
    {
        linkoffset = ( 0, 0, 0 );
        linkangles = ( 0, 0, 0 );
        
        if ( isprojectile )
        {
            if ( !isdefined( var_ea333e2537a8fa73 ) )
            {
                println( "<dev string:x901>" );
                return;
            }
            
            linktoent = var_ea333e2537a8fa73;
            tag = var_ea333e2537a8fa73 function_cb497b712374573a( 0 );
            var_906272d4623c6846 = function_d1f5683bc057754e( objweapon );
            offset = var_2e6727b4a3db5100 - var_906272d4623c6846;
            linkoffset = ( offset * 20, 0, 0 );
        }
        else
        {
            var_3a917e7a3a52cc20 = vdir;
            var_d69085ed57b2f74e = anglestoup( eattacker.angles );
            var_a94f3c9cf87dce8f = vectorcross( var_3a917e7a3a52cc20, var_d69085ed57b2f74e );
            railent = utility::spawn_tag_origin( vpoint, axistoangles( var_3a917e7a3a52cc20, var_a94f3c9cf87dce8f, var_d69085ed57b2f74e ) );
            tag = "tag_origin";
            railent moveto( endpoint, flighttime );
            linktoent = railent;
        }
        
        constraint = spawnragdollconstraint( corpse, shitloc, spartname, var_56243ba4fafee4a5, !isdefined( var_ea333e2537a8fa73 ) );
        
        if ( !isdefined( constraint ) )
        {
            return;
        }
        
        constraint.origin = linktoent.origin;
        constraint.angles = linktoent.angles;
        constraint linkto( linktoent, tag, linkoffset, linkangles );
        
        if ( isprojectile )
        {
            thread function_8cde12af5893e312( var_ea333e2537a8fa73, constraint );
            thread spear_impact_effects( corpse, var_ea333e2537a8fa73, objweapon, shitloc );
            return;
        }
        
        if ( flighttime > 1 )
        {
            thread impale_detachaftertime( constraint, 1 );
        }
        
        thread impale_cleanup( evictim, linktoent, flighttime + 0.25 );
        linktoent thread impale_effects( endpoint, flighttime );
    }
}

// Namespace weapons
// Params 4
// Checksum 0xab015faf, Offset: 0x105d0
// Size: 0x114
function spear_impact_effects( corpsetable, var_ea333e2537a8fa73, objweapon, shitloc )
{
    if ( !isdefined( objweapon ) || !isdefined( objweapon.basename ) || !isdefined( objweapon.variantid ) )
    {
        return;
    }
    
    if ( objweapon.basenamehash != %"jup_jp23_me_spear_mp" )
    {
        return;
    }
    
    state = "none";
    
    if ( objweapon.variantid == 1 )
    {
        state = "gilmanMelee";
    }
    else if ( objweapon.variantid == 2 )
    {
        state = "blackcell_s5Melee";
    }
    else
    {
        return;
    }
    
    level endon( #"game_ended" );
    var_ea333e2537a8fa73 endon( #"death" );
    var_ea333e2537a8fa73 utility::waittill_any_timeout( 6, "missile_stuck" );
    var_fba1b8c73840523b = "mtxDeath";
    
    if ( corpsetable isscriptable() && corpsetable getscriptablehaspart( var_fba1b8c73840523b ) && corpsetable getscriptableparthasstate( var_fba1b8c73840523b, state ) )
    {
        corpsetable setscriptablepartstate( var_fba1b8c73840523b, state, 0 );
    }
}

// Namespace weapons
// Params 7
// Checksum 0x13d30598, Offset: 0x106ec
// Size: 0xf5
function launch( eattacker, evictim, objweapon, vdir, magnitude, shitloc, isagent )
{
    if ( !isdefined( evictim ) )
    {
        return;
    }
    
    if ( isagent )
    {
        corpse = evictim;
    }
    else if ( isdefined( evictim.body ) )
    {
        corpse = evictim.body;
    }
    else
    {
        return;
    }
    
    if ( isagent )
    {
        if ( isdefined( corpse.aicategory ) && ( corpse.aicategory == "special" || corpse.aicategory == "elite" || corpse.aicategory == "hvt" || corpse.aicategory == "boss" ) )
        {
            return;
        }
    }
    
    corpse startragdollfromimpact( shitloc, vdir * magnitude );
}

// Namespace weapons
// Params 2
// Checksum 0xa22de9f, Offset: 0x107e9
// Size: 0x3c
function function_8cde12af5893e312( var_ea333e2537a8fa73, constraint )
{
    level endon( #"game_ended" );
    var_ea333e2537a8fa73 waittill( #"death" );
    
    if ( isdefined( constraint ) )
    {
        constraint delete();
    }
}

// Namespace weapons
// Params 2
// Checksum 0x6bc8d32a, Offset: 0x1082d
// Size: 0x25
function impale_detachaftertime( constraint, time )
{
    wait time;
    
    if ( isdefined( constraint ) )
    {
        constraint delete();
    }
}

// Namespace weapons
// Params 2
// Checksum 0xf7ba8139, Offset: 0x1085a
// Size: 0x3b
function impale_effects( endpoint, time )
{
    wait clamp( time - 0.05, 0.05, 20 );
    playfx( utility::getfx( "penetration_railgun_impact" ), endpoint );
}

// Namespace weapons
// Params 3
// Checksum 0x890d6f5c, Offset: 0x1089d
// Size: 0x3a
function impale_cleanup( evictim, railent, time )
{
    if ( isdefined( evictim ) )
    {
        evictim utility::waittill_any_timeout( time, "death_or_disconnect" );
    }
    
    railent delete();
}

// Namespace weapons
// Params 0
// Checksum 0xe6fb19b5, Offset: 0x108df
// Size: 0x2f, Type: bool
function isstunned()
{
    return isdefined( self.debuffedbyplayers[ "concussion_grenade_mp" ] ) || isdefined( self.isstunned ) && self.isstunned > 0;
}

// Namespace weapons
// Params 0
// Checksum 0x2801b229, Offset: 0x10917
// Size: 0x28
function setplayerblinded()
{
    if ( !isdefined( self.isblinded ) )
    {
        self.isblinded = 1;
        return;
    }
    
    self.isblinded++;
}

// Namespace weapons
// Params 0
// Checksum 0x9cc3fa86, Offset: 0x10947
// Size: 0x3b
function setplayerunblinded()
{
    assert( isdefined( self.isblinded ), "<dev string:x935>" );
    assert( self.isblinded > 0, "<dev string:x985>" );
    self.isblinded--;
}

// Namespace weapons
// Params 0
// Checksum 0x76512a7c, Offset: 0x1098a
// Size: 0x1f, Type: bool
function isblinded()
{
    return isdefined( self.debuffedbyplayers[ "flash_grenade_mp" ] ) || self.flashbanged;
}

// Namespace weapons
// Params 1
// Checksum 0xef9f9795, Offset: 0x109b2
// Size: 0x4c, Type: bool
function isblindedby( player )
{
    if ( !isdefined( player ) )
    {
        return false;
    }
    
    weapon = "flash_grenade_mp";
    entnum = player getentitynumber();
    
    if ( isdefined( self.debuffedbyplayers[ weapon ][ entnum ] ) )
    {
        return true;
    }
    
    return false;
}

// Namespace weapons
// Params 1
// Checksum 0xeb4c41c0, Offset: 0x10a07
// Size: 0x4c, Type: bool
function isstunnedby( player )
{
    if ( !isdefined( player ) )
    {
        return false;
    }
    
    weapon = "concussion_grenade_mp";
    entnum = player getentitynumber();
    
    if ( isdefined( self.debuffedbyplayers[ weapon ][ entnum ] ) )
    {
        return true;
    }
    
    return false;
}

// Namespace weapons
// Params 0
// Checksum 0x1beea025, Offset: 0x10a5c
// Size: 0x12, Type: bool
function isstunnedorblinded()
{
    return isblinded() || isstunned();
}

// Namespace weapons
// Params 0
// Checksum 0x1ec53cbc, Offset: 0x10a77
// Size: 0x3c
function applyweaponsonicstun()
{
    self endon( #"death_or_disconnect" );
    wait 0.1;
    
    if ( isplayer( self ) && !isbot( self ) )
    {
        self playlocalsound( "sonic_shotgun_debuff" );
        self setsoundsubmix( "sonic_shotgun_impact" );
    }
}

// Namespace weapons
// Params 0
// Checksum 0x40aff43e, Offset: 0x10abb
// Size: 0x77
function watchinvalidweaponchange()
{
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        self waittill( #"weapon_switch_invalid", invalidweapon );
        currentweapon = self getcurrentweapon();
        
        if ( currentweapon.inventorytype == "item" || currentweapon.inventorytype == "exclusive" )
        {
            inventory_utility::_switchtoweapon( self.lastdroppableweaponobj );
        }
    }
}

// Namespace weapons
// Params 1
// Checksum 0x11f790b8, Offset: 0x10b3a
// Size: 0xc4, Type: bool
function weaponhasselectableoptic( fullweaponname )
{
    rootweapon = weapon::getweaponrootname( fullweaponname );
    attachments = getweaponattachments( fullweaponname );
    
    foreach ( attachment in attachments )
    {
        group = attachmentgroup( attachment );
        
        if ( group == "rail" )
        {
            if ( weapon::attachmentisselectable( rootweapon, attachment ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace weapons
// Params 0
// Checksum 0x8b8cfb0c, Offset: 0x10c07
// Size: 0x5b
function watchweaponpickup()
{
    self endon( #"disconnect" );
    self notify( #"hash_b995469b570bac10" );
    self endon( #"hash_b995469b570bac10" );
    
    while ( true )
    {
        self waittill( #"trigger", newweaponobj, droppedweaponobj, pickupent );
    }
}

// Namespace weapons
// Params 0
// Checksum 0x34e947fe, Offset: 0x10c6a
// Size: 0xa5
function watchdropweapons()
{
    self endon( #"disconnect" );
    self notify( #"hash_ba20732c65289cf6" );
    self endon( #"hash_ba20732c65289cf6" );
    
    while ( true )
    {
        self waittill( #"weapon_dropped", droppedent, objweapon );
        
        if ( isdefined( droppedent ) && isdefined( objweapon ) )
        {
            if ( getdvarint( @"hash_204f67bbaa6705ea", 0 ) && getdvarint( @"hash_28e678788a4ce3a5", 1 ) )
            {
                droppedent function_76025bf1685180e2( 1 );
            }
            
            if ( droppedent physics_getnumbodies() > 0 )
            {
                droppedent physics_registerforcollisioncallback();
                droppedent thread weapondrop_physics_callback_monitor();
            }
        }
    }
}

// Namespace weapons
// Params 0
// Checksum 0x4a9f2041, Offset: 0x10d17
// Size: 0xb4
function weapondrop_physics_callback_monitor()
{
    self endon( #"death" );
    self endon( #"timeout" );
    thread weapondrop_physics_timeout( 2 );
    self waittill( #"collision", body0, body1, flag0, flag1, position, normal, impulse, ent );
    surface = physics_getsurfacetypefromflags( flag1 );
    surfacetype = surface[ "name" ] ?? "";
    function_acdca5c5e8c63f62( surfacetype );
}

// Namespace weapons
// Params 1
// Checksum 0x3634b518, Offset: 0x10dd3
// Size: 0x9a
function function_acdca5c5e8c63f62( surfacetype )
{
    assert( isstring( surfacetype ), "<dev string:xa03>" );
    surfacetype = function_41bec0232e24ee41( surfacetype, "surftype_" );
    
    if ( isstartstr( surfacetype, "user_terrain" ) )
    {
        user_number = removesubstr( function_41bec0232e24ee41( surfacetype, "user_terrain" ), "_" );
        surfacetype = "user_terrain_" + user_number;
    }
    
    if ( isstartstr( surfacetype, "unused" ) )
    {
        user_number = removesubstr( function_41bec0232e24ee41( surfacetype, "unused" ), "_" );
        surfacetype = "unused_" + user_number;
    }
    
    self playweapondropsound( surfacetype );
}

// Namespace weapons
// Params 1
// Checksum 0xe2ef47d5, Offset: 0x10e75
// Size: 0x1b
function weapondrop_physics_timeout( time )
{
    wait time;
    self notify( #"timeout" );
}

// Namespace weapons
// Params 2
// Checksum 0x298c3e88, Offset: 0x10e98
// Size: 0xef
function function_c1f70f7e383be433( player, weaponnameoverride )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    if ( !isdefined( self.weapon_name ) && isdefined( weaponnameoverride ) )
    {
        self.weapon_name = weaponnameoverride;
    }
    
    self waittill( #"missile_stuck", stuckto, stuckpart );
    var_1d8a4d3922a29fad = 45;
    timeoutoverride = getdvarint( @"hash_1471cf85cde4d3e2", -1 );
    
    if ( timeoutoverride >= 0 )
    {
        var_1d8a4d3922a29fad = timeoutoverride;
    }
    
    thread function_4d59cb33b88451e( var_1d8a4d3922a29fad );
    thread watchgrenadedeath();
    objweapon = self.weapon_object;
    
    if ( getdvarint( @"hash_7d5af95f63f152ae", 0 ) )
    {
        thread function_5436b957e7c48cc2( player, objweapon );
    }
    
    thread function_682b579d80b25464( player, objweapon );
    thread watchweapondrop();
}

// Namespace weapons
// Params 1
// Checksum 0x2127c7e1, Offset: 0x10f8f
// Size: 0x33
function function_4d59cb33b88451e( timeoutduration )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    hostmigration::waitlongdurationwithhostmigrationpause( timeoutduration );
    self delete();
}

// Namespace weapons
// Params 2
// Checksum 0xb34d030c, Offset: 0x10fca
// Size: 0xdd
function function_682b579d80b25464( player, weapon )
{
    if ( getdvarint( @"hash_d8f0a05f42bcd86b", 0 ) )
    {
        return;
    }
    
    self endon( #"death" );
    level endon( #"game_ended" );
    trigger = spawn( "trigger_radius", self.origin - ( 0, 0, 40 ), 0, 64, 64 );
    trigger enablelinkto();
    trigger linkto( self );
    self.knife_trigger = trigger;
    trigger endon( #"death" );
    
    while ( true )
    {
        trigger waittill( #"trigger", player );
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( player function_170a4b35e4cdcc88( self ) )
        {
            player function_921a8d432faad901( weapon, 1 );
            self delete();
            break;
        }
    }
}

// Namespace weapons
// Params 2
// Checksum 0xd7186206, Offset: 0x110af
// Size: 0xdc
function function_5436b957e7c48cc2( player, weapon )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    useobj = spawn( "script_model", self.origin );
    useobj linkto( self );
    self.useobj_trigger = useobj;
    useobj makeusable();
    useobj setcursorhint( "HINT_NOICON" );
    useobj sethintonobstruction( "show" );
    useobj sethintstring( &"weapon/pickup_spear" );
    useobj sethintdisplayfov( 360 );
    useobj setusefov( 360 );
    useobj sethintdisplayrange( 64 );
    useobj setuserange( 64 );
    useobj setusepriority( 0 );
    useobj waittill( #"trigger", player );
    player function_921a8d432faad901( weapon, 0 );
    self delete();
}

// Namespace weapons
// Params 0, eflags: 0x4
// Checksum 0x7054a55c, Offset: 0x11193
// Size: 0x3d
function private watchweapondrop()
{
    self endon( #"death" );
    
    if ( !weapon::function_33e74163843b348e( self.weapon_object ) )
    {
        return;
    }
    
    self.owner waittill( #"hash_e35c59b0ff4cf4bb" );
    self delete();
}

// Namespace weapons
// Params 1
// Checksum 0x355eccc3, Offset: 0x111d8
// Size: 0x112
function function_170a4b35e4cdcc88( var_67c4a7e26c38cc17 )
{
    if ( isdefined( var_67c4a7e26c38cc17.owner ) && self != var_67c4a7e26c38cc17.owner )
    {
        return 0;
    }
    
    currentweapons = self getweaponslistprimaries();
    var_939bfe001664c52b = 0;
    var_a29bc8eba2f5796f = 0;
    
    foreach ( weapon in currentweapons )
    {
        if ( weapon::function_33e74163843b348e( weapon ) && self getweaponammoclip( weapon ) < weaponclipsize( weapon ) )
        {
            var_939bfe001664c52b = 1;
            break;
        }
        
        if ( weapon::isfistweapon( weapon ) )
        {
            var_939bfe001664c52b = 1;
            break;
        }
        
        if ( !weapon.isalternate )
        {
            var_a29bc8eba2f5796f++;
        }
    }
    
    if ( var_a29bc8eba2f5796f < 2 )
    {
        var_939bfe001664c52b = 1;
    }
    
    return var_939bfe001664c52b;
}

// Namespace weapons
// Params 2
// Checksum 0x531b558f, Offset: 0x112f3
// Size: 0x3f3
function function_921a8d432faad901( objweapon, var_8af26e78d4eb35e9 )
{
    assert( isweapon( objweapon ) );
    var_fbf52781a23e4114 = objweapon getnoaltweapon();
    currentweapon = self getcurrentweapon();
    currentweapons = self getweaponslistprimaries();
    
    if ( self hasweapon( objweapon ) )
    {
        ammoinclip = self getweaponammoclip( objweapon );
        clipsize = weaponclipsize( objweapon );
        
        if ( !var_8af26e78d4eb35e9 && ammoinclip > 0 )
        {
            if ( clipsize == 1 )
            {
                self dropitem( objweapon );
                inventory_utility::_giveweapon( var_fbf52781a23e4114 );
            }
        }
        else if ( !issubstr( currentweapon.basename, objweapon.basename ) )
        {
            inventory_utility::_takeweapon( objweapon );
            inventory_utility::_giveweapon( var_fbf52781a23e4114 );
        }
        
        var_bc2b88d7f86c136e = self getweaponammoclip( currentweapon ) == 0 && weapon::function_33e74163843b348e( currentweapon );
        var_1f5413729b80918a = weapon::isfistweapon( currentweapon );
        
        if ( !var_8af26e78d4eb35e9 || var_1f5413729b80918a || var_bc2b88d7f86c136e )
        {
            inventory_utility::_switchtoweapon( var_fbf52781a23e4114 );
        }
        
        newammo = int( min( clipsize, ammoinclip + 1 ) );
        self setweaponammoclip( var_fbf52781a23e4114, newammo );
        
        if ( issubstr( currentweapon.basename, "me_spear_mp" ) )
        {
            self playsoundtoplayer( #"weap_pickup_spear_plr", self );
            self playsoundtoteam( #"weap_pickup_spear", self.team, self );
            self playsoundtoteam( #"weap_pickup_spear", game_utility_mp::getotherteam( self.team )[ 0 ], self );
        }
        
        return;
    }
    
    var_d58cb3df58e0d6ee = undefined;
    var_2109956c0add144b = 0;
    
    foreach ( weapon in currentweapons )
    {
        if ( weapon.isalternate )
        {
            continue;
        }
        
        if ( issubstr( weapon.basename, "uplinkball" ) )
        {
            continue;
        }
        
        if ( weapon::isunderwaterweapon( weapon ) || weapon::isclimbweapon( weapon ) )
        {
            continue;
        }
        
        var_11bd1278ed6c10a5 = self getweaponammoclip( weapon ) == 0 && weapon::function_33e74163843b348e( weapon );
        
        if ( !isdefined( var_d58cb3df58e0d6ee ) && ( function_cf3bf3f907e806d2( weapon ) || var_11bd1278ed6c10a5 ) )
        {
            var_d58cb3df58e0d6ee = weapon;
        }
        
        var_2109956c0add144b++;
    }
    
    assert( !var_8af26e78d4eb35e9 || isdefined( var_d58cb3df58e0d6ee ) || var_2109956c0add144b < 2 );
    var_f7cb5f756a346f4a = undefined;
    
    if ( isdefined( var_d58cb3df58e0d6ee ) )
    {
        var_f7cb5f756a346f4a = var_d58cb3df58e0d6ee;
    }
    else if ( var_2109956c0add144b >= 2 )
    {
        var_f7cb5f756a346f4a = currentweapon;
    }
    
    var_31fcf66f2547d687 = !var_8af26e78d4eb35e9 || isdefined( var_f7cb5f756a346f4a ) && issubstr( currentweapon.basename, var_f7cb5f756a346f4a.basename );
    
    if ( isdefined( var_f7cb5f756a346f4a ) )
    {
        var_11bd1278ed6c10a5 = self getweaponammoclip( var_f7cb5f756a346f4a ) == 0 && weapon::function_33e74163843b348e( var_f7cb5f756a346f4a );
        var_8eb964a959ce878d = weapon::isfistweapon( var_f7cb5f756a346f4a );
        candrop = function_44775172d6dd7e71( var_f7cb5f756a346f4a ) && !var_11bd1278ed6c10a5;
        
        if ( candrop )
        {
            droppeditem = self dropitem( var_f7cb5f756a346f4a );
            
            if ( isdefined( droppeditem ) )
            {
                weapon_utility::function_cd7fc4f6ba97876c( droppeditem, var_f7cb5f756a346f4a );
                droppeditem thread watchpickup( self );
                droppeditem thread deletepickupafterawhile();
            }
        }
        else if ( !candrop && !( var_8eb964a959ce878d && var_2109956c0add144b < 2 ) && !( var_11bd1278ed6c10a5 && var_2109956c0add144b < 2 ) )
        {
            self takeweapon( var_f7cb5f756a346f4a );
        }
    }
    
    inventory_utility::_giveweapon( var_fbf52781a23e4114 );
    self setweaponammoclip( var_fbf52781a23e4114, 1 );
    
    if ( var_31fcf66f2547d687 )
    {
        inventory_utility::_switchtoweapon( var_fbf52781a23e4114 );
    }
    
    weapon::fixupplayerweapons( self, var_fbf52781a23e4114 );
}

// Namespace weapons
// Params 1
// Checksum 0xced86ff1, Offset: 0x116ee
// Size: 0x28
function function_6831567befa159a1( objweapon )
{
    callback::callback( #"player_offhand_pullback", { #objweapon:objweapon } );
}

// Namespace weapons
// Params 4
// Checksum 0xc688fc41, Offset: 0x1171e
// Size: 0x143
function callback_finishweaponchange( objnewweapon, objoldweapon, var_fab3eda217de7fb0, var_2e2cc966586ca8f7 )
{
    updatecamoscripts( objnewweapon, objoldweapon );
    callbackdata = self.weaponchangecallbacks;
    
    if ( isdefined( callbackdata ) )
    {
        foreach ( callback in callbackdata.callbacks )
        {
            self [[ callback ]]( objnewweapon, objoldweapon );
        }
        
        foreach ( callback in callbackdata.oneshotcallbacks )
        {
            self [[ callback ]]( objnewweapon, objoldweapon );
        }
        
        callbackdata.oneshotcallbacks = [];
    }
}

// Namespace weapons
// Params 2
// Checksum 0x97199d4c, Offset: 0x11869
// Size: 0x2f
function updatecamoscripts( objnewweapon, objoldweapon )
{
    clearcamoscripts( getweaponcamoname( objoldweapon ) );
    runcamoscripts( getweaponcamoname( objnewweapon ) );
}

// Namespace weapons
// Params 1
// Checksum 0xdbabbb02, Offset: 0x118a0
// Size: 0x34
function runcamoscripts( camo )
{
    if ( !isdefined( camo ) )
    {
        return;
    }
    
    switch ( camo )
    {
        case #"hash_321cd27e72303c85":
            thread blood_camo_84();
            break;
    }
}

// Namespace weapons
// Params 1
// Checksum 0x716f5a33, Offset: 0x118dc
// Size: 0x39
function clearcamoscripts( camo )
{
    if ( !isdefined( camo ) )
    {
        return;
    }
    
    switch ( camo )
    {
        case #"hash_321cd27e72303c85":
            self notify( #"hash_a839cc60a44bbc49" );
            break;
    }
}

// Namespace weapons
// Params 0
// Checksum 0x38adf9a1, Offset: 0x1191d
// Size: 0x9c
function blood_camo_84()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_a839cc60a44bbc49" );
    
    if ( isdefined( self.bloodcamokillcount ) )
    {
        self setscriptablepartstate( "camo_84", self.bloodcamokillcount + "_kills" );
    }
    else
    {
        self.bloodcamokillcount = 0;
    }
    
    while ( self.bloodcamokillcount < 13 )
    {
        self waittill( #"kill_event_buffered" );
        self.bloodcamokillcount += 1;
        self setscriptablepartstate( "camo_84", self.bloodcamokillcount + "_kills" );
    }
}

// Namespace weapons
// Params 0
// Checksum 0xe8a401e0, Offset: 0x119c1
// Size: 0x8
function getactiveequipmentarray()
{
    return weapon::function_3aafcaf7ff6dea9e();
}

// Namespace weapons
// Params 0
// Checksum 0xc5ad010f, Offset: 0x119d2
// Size: 0x10
function init_function_refs()
{
    level.getactiveequipmentarray = &getactiveequipmentarray;
}

// Namespace weapons
// Params 0
// Checksum 0x85389ca4, Offset: 0x119ea
// Size: 0x136
function waittill_grenade_throw()
{
    while ( true )
    {
        self waittill( #"grenade_fire", grenade, objweapon, tickpercent, originalowner );
        
        if ( !grenade || !weapon::grenadethrown( grenade ) )
        {
            continue;
        }
        
        grenadeinitialize( grenade, objweapon, tickpercent, originalowner );
        grenade thread function_9fd2f27ef5182cad();
        
        if ( isdefined( originalowner ) && originalowner != self )
        {
            equipmentref = objweapon.equipmentref ?? equipment_mp::getequipmentreffromweapon( objweapon );
            bundle = level.equipment.table[ equipmentref ].bundle;
            
            if ( !bundle.var_1a0dc0c9ed072bc )
            {
                level thread battlechatter_mp::trysaylocalsound( self, #"bc_equipment_action_grenade_throwback" );
            }
        }
        
        self.var_100d1ec32fd4d973 = gettime();
        self.var_c4c535d1f47c26f2 = grenade;
        self notify( #"grenade_thrown", grenade );
        callback::callback( #"grenade_fire", { #originalowner:originalowner, #grenade:grenade } );
        return grenade;
    }
}

// Namespace weapons
// Params 4
// Checksum 0x6756da9c, Offset: 0x11b28
// Size: 0x32f
function grenadeinitialize( grenade, weapon_object, tickpercent, originalowner )
{
    assert( isdefined( self ), "<dev string:xa3e>" );
    assert( isdefined( grenade ), "<dev string:xa6b>" );
    
    if ( !isdefined( grenade ) )
    {
        return;
    }
    
    if ( !isdefined( grenade.weapon_object ) )
    {
        grenade.weapon_object = weapon_object;
    }
    
    if ( !isdefined( grenade.weapon_name ) )
    {
        grenade.weapon_name = weapon_object.basename;
    }
    
    if ( !isdefined( grenade.owner ) )
    {
        grenade.owner = self;
    }
    
    if ( !isdefined( grenade.team ) )
    {
        grenade.team = self.team;
    }
    
    if ( !isdefined( grenade.tickpercent ) )
    {
        grenade.tickpercent = tickpercent;
    }
    
    grenade.var_b62d290bca467227 = 1;
    
    if ( !isdefined( grenade.ticks ) && isdefined( grenade.tickpercent ) )
    {
        grenade.ticks = int( ceil( 4 * tickpercent ) );
    }
    
    equipmentref = equipment_mp::getequipmentreffromweapon( weapon_object );
    
    if ( isdefined( equipmentref ) )
    {
        grenade.equipmentref = equipmentref;
        grenade.isequipment = 1;
        
        if ( isdefined( self.pers[ #"hash_ddf4800634d16ffd" ][ equipmentref ] ) )
        {
            grenade.bundle = equipment::function_3637cad9a44ab42( equipmentref );
            grenade.equipmentref = grenade.bundle.var_6bda5cfddf2527bd;
        }
        else
        {
            grenade.bundle = equipment_mp::getEquipmentBundleFromWeaponName( grenade.weapon_name );
        }
        
        if ( equipmentref == "equip_smoke" )
        {
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( grenade.owner ) ) )
            {
                if ( isdefined( grenade.owner.leaderboarddata[ "smokesUsed" ] ) )
                {
                    grenade.owner.leaderboarddata[ "smokesUsed" ] = grenade.owner.leaderboarddata[ "smokesUsed" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "smokesUsed" ] ) )
                {
                    [[ level.leaderboardfunc[ "smokesUsed" ] ]]( grenade.owner, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x1c5>" );
                
                if ( isdefined( grenade.owner.pers[ "smokesUsed" ] ) )
                {
                    grenade.owner.pers[ "smokesUsed" ] = grenade.owner.pers[ "smokesUsed" ] + 1;
                }
            }
        }
    }
    
    grenade.threwback = isdefined( originalowner ) && grenade.owner != originalowner;
}

// Namespace weapons
// Params 0
// Checksum 0xc5d15115, Offset: 0x11e5f
// Size: 0xc8
function function_9fd2f27ef5182cad()
{
    self endon( #"death" );
    self endon( #"game_ended" );
    
    if ( self.owner )
    {
        self.owner endon( #"hash_30fbe118c19be039" );
    }
    
    for ( lastposition = self.origin; true ; lastposition = self.origin )
    {
        msg = utility::waittill_any_return( "missile_stuck", "missile_bounced" );
        
        if ( msg == "missile_stuck" )
        {
            break;
        }
        
        deltaposition = self.origin - lastposition;
        vectorlength = length( deltaposition );
        
        if ( vectorlength < 30 )
        {
            break;
        }
    }
    
    self.var_b62d290bca467227 = 0;
}

// Namespace weapons
// Params 0
// Checksum 0xcb3ed911, Offset: 0x11f2f
// Size: 0xec
function waittill_missile_fire()
{
    self waittill( #"missile_fire", missile, objweapon );
    
    if ( isdefined( missile ) )
    {
        if ( !isdefined( missile.weapon_name ) )
        {
            if ( objweapon.isalternate )
            {
                missile.weapon_name = weapon::getaltmodeweapon( objweapon );
            }
            else
            {
                missile.weapon_name = objweapon.basename;
            }
        }
        
        if ( !isdefined( missile.owner ) )
        {
            missile.owner = self;
        }
        
        if ( !isdefined( missile.team ) )
        {
            missile.team = self.team;
        }
        
        if ( !isdefined( missile.weapon_object ) )
        {
            missile.weapon_object = objweapon;
        }
        
        missile.var_b62d290bca467227 = 1;
    }
    
    return [ objweapon, missile ];
}

// Namespace weapons
// Params 1, eflags: 0x4
// Checksum 0x8214490, Offset: 0x12024
// Size: 0x13
function private function_aa43500709df6ef2( params )
{
    thread function_68f065f2098a33e6();
}

// Namespace weapons
// Params 0, eflags: 0x4
// Checksum 0x9ffc6e81, Offset: 0x1203f
// Size: 0x40
function private function_68f065f2098a33e6()
{
    self notify( #"hash_afde5a4853ea7d6f" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_afde5a4853ea7d6f" );
    utility::waittill_any( "beginC130", "recycled_to_uibot" );
    thread damage_effects::clearburning( 1 );
}

// Namespace weapons
// Params 1, eflags: 0x4
// Checksum 0xce464f7e, Offset: 0x12087
// Size: 0x18
function private function_62b79abda49d3731( params )
{
    self notify( #"hash_afde5a4853ea7d6f" );
}

// Namespace weapons
// Params 1
// Checksum 0x830f15da, Offset: 0x120a7
// Size: 0x83
function function_636e43f4bcdc20b5( lootid )
{
    if ( utility::callsharedfunc( #"game", #"isCommonItemEnabled" ) )
    {
        variantref = utility::callsharedfunc( #"game", #"hash_ca4103c28ac67fef", lootid );
        
        if ( !isdefined( variantref ) )
        {
            variantref = loot::function_f54ecb89dfab8e8c( lootid );
        }
    }
    else
    {
        variantref = loot::function_f54ecb89dfab8e8c( lootid );
    }
    
    baseweaponref = weapon::getweaponrootname( variantref );
    return loot::getlootidfromref( baseweaponref );
}

// Namespace weapons
// Params 3
// Checksum 0xfbebf74, Offset: 0x12133
// Size: 0xb8
function function_5a8beea9d65ebe8f( weaponassetname, attachment, variantlootid )
{
    blueprints = function_d3cb2c9aad7e9c4( weaponassetname, attachment );
    
    foreach ( variantindex, attachmentdata in blueprints )
    {
        attachmentlootid = attachmentdata.lootid;
        
        if ( variantlootid == attachmentlootid )
        {
            return variantindex;
        }
    }
    
    return 0;
}

// Namespace weapons
// Params 3
// Checksum 0x4b114f36, Offset: 0x121f4
// Size: 0xab
function function_1136b3843dc9e18d( weaponassetname, attachment, variantid )
{
    blueprints = function_d3cb2c9aad7e9c4( weaponassetname, attachment );
    
    foreach ( variantindex, attachmentdata in blueprints )
    {
        if ( variantindex == variantid )
        {
            return attachmentdata.lootid;
        }
    }
}

// Namespace weapons
// Params 2
// Checksum 0x4e98c359, Offset: 0x122a8
// Size: 0x1df
function recommendedstatusbyseason( objweapon, inflictor )
{
    var_acd22f882b1f3e9d = [];
    
    if ( isdefined( objweapon ) )
    {
        var_317fb98e33a23481 = weapon::getweaponrootname( objweapon );
        weaponbundle = weapon::function_659a3e10e8d1c91c( var_317fb98e33a23481, [ #"recommendedentries" ] );
        
        if ( isdefined( weaponbundle ) )
        {
            if ( isdefined( weaponbundle.recommendedentries ) )
            {
                indexmodifier = 0;
                
                foreach ( index, recentry in weaponbundle.recommendedentries )
                {
                    localindex = index + indexmodifier;
                    
                    if ( isdefined( weaponbundle.recommendedentries[ index ].priority ) )
                    {
                        if ( int( weaponbundle.recommendedentries[ index ].season ) == localindex )
                        {
                            var_acd22f882b1f3e9d[ var_acd22f882b1f3e9d.size ] = weaponbundle.recommendedentries[ index ].priority;
                        }
                        else
                        {
                            var_58f03cff221a9fdd = localindex;
                            
                            while ( var_58f03cff221a9fdd < int( weaponbundle.recommendedentries[ index ].season ) )
                            {
                                var_acd22f882b1f3e9d[ var_acd22f882b1f3e9d.size ] = 0;
                                var_58f03cff221a9fdd++;
                                indexmodifier++;
                            }
                            
                            var_acd22f882b1f3e9d[ var_acd22f882b1f3e9d.size ] = weaponbundle.recommendedentries[ index ].priority;
                        }
                        
                        continue;
                    }
                    
                    var_acd22f882b1f3e9d[ var_acd22f882b1f3e9d.size ] = 0;
                }
                
                while ( var_acd22f882b1f3e9d.size < 7 )
                {
                    var_acd22f882b1f3e9d[ var_acd22f882b1f3e9d.size ] = 0;
                }
                
                return var_acd22f882b1f3e9d;
            }
            else
            {
                return;
            }
        }
        else
        {
            return;
        }
        
        return;
    }
    
    return;
}

// Namespace weapons
// Params 1
// Checksum 0xafaf6607, Offset: 0x1248f
// Size: 0x23a
function function_4a9cbe22925eadad( missile )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( missile.weapon_object ) )
    {
        return;
    }
    
    if ( !isdefined( missile.weapon_object.override ) )
    {
        return;
    }
    
    overrideattachment = missile.weapon_object.override;
    
    switch ( overrideattachment )
    {
        case #"hash_dae501c7958e0d14":
            spawnpos = self geteye();
            launchvelocity = missile getmissilevelocity();
            var_63a12cdb804a93ab = "jup_semtex_mike32_mp";
            
            if ( isdefined( missile.weapon_object.weaponblueprint ) && isdefined( missile.weapon_object.weaponblueprint.lootid ) && missile.weapon_object.weaponblueprint.lootid == 68641 )
            {
                var_63a12cdb804a93ab = "jup_semtex_mike32_v5008_mp";
            }
            
            grenade = weapon::_launchgrenade( var_63a12cdb804a93ab, spawnpos, launchvelocity, undefined, 1, grenade );
            grenade hide();
            grenadeinitialize( grenade, makeweapon( var_63a12cdb804a93ab ) );
            assert( isdefined( level.var_43ea0dc79d4f6473[ #"semtex" ] ) || isdefined( level.var_43ea0dc79d4f6473[ #"sticky_grenade" ] ), "<dev string:xaa2>" );
            
            if ( isdefined( level.var_43ea0dc79d4f6473[ #"semtex" ] ) )
            {
                self thread [[ level.var_43ea0dc79d4f6473[ #"semtex" ] ]]( grenade );
            }
            else if ( isdefined( level.var_43ea0dc79d4f6473[ #"sticky_grenade" ] ) )
            {
                self thread [[ level.var_43ea0dc79d4f6473[ #"sticky_grenade" ] ]]( grenade );
            }
            
            missile notify( #"death" );
            missile hide();
            waitframe();
            waitframe();
            missile delete();
            grenade show();
            break;
        case #"hash_fad9e06cbc21bdd4":
            thread bunkerbuster::gl_used( missile, 1, self.currentprimaryweapon );
            break;
        default:
            break;
    }
}

// Namespace weapons
// Params 1
// Checksum 0xc3f5a715, Offset: 0x126d1
// Size: 0x19, Type: bool
function function_f86e6c03e72fa66b( weaponrootname )
{
    return isdefined( level.var_43aee273edb1cb64[ weaponrootname ] );
}

// Namespace weapons
// Params 2
// Checksum 0x7017626a, Offset: 0x126f3
// Size: 0x7c
function function_1c8762319abef400( grenade, callbackfn )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    grenade endon( #"death" );
    grenade endon( #"explode" );
    self endon( #"swapLoadout" );
    childthread function_40730451387ab4();
    thread function_3f5908c9f25c0773( grenade );
    self waittill( #"detonate" );
    
    if ( isdefined( callbackfn ) )
    {
        grenade [[ callbackfn ]]();
    }
}

// Namespace weapons
// Params 1
// Checksum 0x184696d9, Offset: 0x12777
// Size: 0x72
function function_3f5908c9f25c0773( grenade )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    grenade endon( #"death" );
    grenade endon( #"explode" );
    val::set( "cricket", "offhand_secondary_weapons", 0 );
    utility::waittill_any( "death", "swapLoadout", "detonate" );
    val::reset_all( "cricket" );
}

// Namespace weapons
// Params 0
// Checksum 0x3820aa87, Offset: 0x127f1
// Size: 0x4f
function function_40730451387ab4()
{
    self notifyonplayercommand( "giveCricketClacker", "+smoke" );
    
    while ( true )
    {
        self waittill( #"giveCricketClacker" );
        
        if ( function_9ab8dcfafe5c88da() )
        {
            self notifyonplayercommandremove( "giveCricketClacker", "+smoke" );
            self notify( #"detonate" );
            break;
        }
    }
}

// Namespace weapons
// Params 0
// Checksum 0x298a9b0e, Offset: 0x12848
// Size: 0x1c, Type: bool
function function_9ab8dcfafe5c88da()
{
    if ( !player::isreallyalive( self ) )
    {
        return false;
    }
    
    if ( utility::isusingremote() )
    {
        return false;
    }
    
    return true;
}

// Namespace weapons
// Params 1
// Checksum 0x5e8d513d, Offset: 0x1286d
// Size: 0x29
function function_9b1da4271649e52( weaponrootname )
{
    if ( isdefined( level.var_43aee273edb1cb64[ weaponrootname ] ) )
    {
        return level.var_43aee273edb1cb64[ weaponrootname ];
    }
}

// Namespace weapons
// Params 0
// Checksum 0x705ee89f, Offset: 0x1289e
// Size: 0x8
function _detonate()
{
    self detonate();
}

// Namespace weapons
// Params 2
// Checksum 0xf32dd5a6, Offset: 0x128ae
// Size: 0xb5, Type: bool
function function_7a47d284e204463a( grenade, weaponrootname )
{
    thread outline::outlineenableforteam( grenade, self.team, "equip_cricket_outline", "perk_superior" );
    grenade.headiconid = entityheadicons::setheadicon_equipment( grenade );
    grenade thread makeexplosiveusabletag( "tag_origin", 1 );
    thread function_ac18388ecb251ca2( grenade );
    isshockstick = grenade.weapon_object.var_5e3a1c87edc1edd5 == #"shockstick";
    
    if ( function_f86e6c03e72fa66b( weaponrootname ) || isshockstick )
    {
        thread function_1c8762319abef400( grenade, function_9b1da4271649e52( weaponrootname ) );
        
        if ( !isshockstick )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace weapons
// Params 1
// Checksum 0xf97467d3, Offset: 0x1296c
// Size: 0x88
function function_ac18388ecb251ca2( grenade )
{
    level endon( #"game_ended" );
    setdvar( @"hash_951759aeea8e4651", grenade getentitynumber() );
    msg = utility::waittill_any_ents_return_no_endon_death( self, "swapLoadout", grenade, "death", self, "death_or_disconnect", grenade, "explode" );
    
    if ( isdefined( grenade ) )
    {
        if ( isdefined( grenade.headiconid ) )
        {
            grenade entityheadicons::setheadicon_deleteicon( grenade.headiconid );
        }
        
        grenade delete();
    }
}

// Namespace weapons
// Params 0
// Checksum 0xed3fe480, Offset: 0x129fc
// Size: 0xdf
function function_7c254433f5f99915()
{
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        self waittill( #"melee_swipe_start", var_3e3b9c78efcf30a6 );
        
        switch ( var_3e3b9c78efcf30a6 )
        {
            case 3:
                if ( battlechatter_mp::function_fb3633bb3479f698( #"hash_3bb19cbb2a3baabc" ) )
                {
                    level thread battlechatter_mp::trysaylocalsound( self, #"hash_3bb19cbb2a3baabc" );
                }
                
                break;
            case 2:
                if ( battlechatter_mp::function_fb3633bb3479f698( #"hash_7d0fc60f01adbfba" ) )
                {
                    level thread battlechatter_mp::trysaylocalsound( self, #"hash_7d0fc60f01adbfba" );
                }
                
                break;
            case 0:
                if ( battlechatter_mp::function_fb3633bb3479f698( #"hash_2e89120e7f4980cf" ) )
                {
                    level thread battlechatter_mp::trysaylocalsound( self, #"hash_2e89120e7f4980cf" );
                }
            default:
                break;
        }
        
        waitframe();
    }
}

// Namespace weapons
// Params 0
// Checksum 0xe8460877, Offset: 0x12ae3
// Size: 0xaf
function function_b217ecdbbe7a2ff3()
{
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        staggertype = utility::waittill_any_return( "poiseKnockdown", "poiseStagger" );
        
        switch ( staggertype )
        {
            case #"hash_b664b86fd4abec71":
                if ( battlechatter_mp::function_fb3633bb3479f698( #"hash_ba22c4f7d1828668" ) )
                {
                    level thread battlechatter_mp::trysaylocalsound( self, #"hash_ba22c4f7d1828668" );
                }
                
                break;
            case #"hash_d8390ceebb007b12":
            default:
                if ( battlechatter_mp::function_fb3633bb3479f698( #"hash_bc5154f78f5b2af0" ) )
                {
                    level thread battlechatter_mp::trysaylocalsound( self, #"hash_bc5154f78f5b2af0" );
                }
                
                break;
        }
        
        waitframe();
    }
}

// Namespace weapons
// Params 0
// Checksum 0x60594025, Offset: 0x12b9a
// Size: 0xe7
function function_3226c0a2c58ef50b()
{
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        attacktype = utility::waittill_any_return( "frontKicked", "heavyAttacked", "lightAttacked" );
        
        switch ( attacktype )
        {
            case #"hash_14d40b4714759957":
                if ( battlechatter_mp::function_fb3633bb3479f698( #"hash_8ad24b4ad34d11f9" ) )
                {
                    level thread battlechatter_mp::trysaylocalsound( self, #"hash_8ad24b4ad34d11f9" );
                }
                
                break;
            case #"hash_278f28958beef58d":
                if ( battlechatter_mp::function_fb3633bb3479f698( #"hash_a53803fd5b3cdcb" ) )
                {
                    level thread battlechatter_mp::trysaylocalsound( self, #"hash_a53803fd5b3cdcb" );
                }
                
                break;
            case #"hash_aaa54aeb544c7326":
            default:
                if ( battlechatter_mp::function_fb3633bb3479f698( #"hash_ee5555c391301c0e" ) )
                {
                    level thread battlechatter_mp::trysaylocalsound( self, #"hash_ee5555c391301c0e" );
                }
                
                break;
        }
        
        waitframe();
    }
}

// Namespace weapons
// Params 0
// Checksum 0x1d1e1711, Offset: 0x12c89
// Size: 0x50
function function_489824b64b3a33ef()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"poiseKnockdown" );
        thread shellshock_utility_cpmp::_shellshock( %"concussion_grenade_mp", #"stun", 1.5, 1 );
        waitframe();
    }
}

// Namespace weapons
// Params 0
// Checksum 0xf0974f43, Offset: 0x12ce1
// Size: 0x28
function denyusage()
{
    hud_message::showerrormessage( %"MP/CANNOT_USE_GENERIC" );
    self playsoundtoplayer( #"ui_select_purchase_deny", self );
    self canceloffhands();
}

// Namespace weapons
// Params 2
// Checksum 0x519f3691, Offset: 0x12d11
// Size: 0x324
function function_e9702cd6c6aeec0f( grenade, normal )
{
    if ( level.gamemodebundle.var_e9702cd6c6aeec0f && level.killcam )
    {
        killcament = undefined;
        radius = 1;
        startpos = grenade.origin + normal * 12;
        navmeshpos = getclosestpointonnavmesh( startpos );
        navmeshpos = ( navmeshpos[ 0 ], navmeshpos[ 1 ], startpos[ 2 ] );
        endpos = startpos + vectornormalize( navmeshpos - startpos ) * 25;
        content_override = trace::create_contents( 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1 );
        pathtrace = trace::sphere_trace( startpos, endpos, radius, [ grenade ], content_override );
        
        /#
        #/
        
        if ( pathtrace[ "fraction" ] == 1 )
        {
            var_20782d25c7070db7 = pathtrace[ "position" ];
        }
        else if ( pathtrace[ "fraction" ] == 0 )
        {
            startpos = pathtrace[ "position" ] + pathtrace[ "normal" ] * radius;
            endpos = startpos + vectornormalize( navmeshpos - startpos ) * 25;
            pathtrace = trace::sphere_trace( startpos, endpos, radius, [ grenade ], content_override );
            
            if ( pathtrace[ "fraction" ] == 0 )
            {
                var_20782d25c7070db7 = pathtrace[ "position" ];
            }
            else
            {
                var_20782d25c7070db7 = pathtrace[ "position" ] + pathtrace[ "normal" ] * radius;
            }
        }
        else
        {
            var_20782d25c7070db7 = pathtrace[ "position" ] + pathtrace[ "normal" ] * radius;
        }
        
        var_eb297cb422dbb1cd = var_20782d25c7070db7;
        uptrace = trace::sphere_trace( var_eb297cb422dbb1cd, var_eb297cb422dbb1cd + ( 0, 0, 50 ), radius, [ grenade ], content_override );
        downtrace = trace::sphere_trace( var_eb297cb422dbb1cd, var_eb297cb422dbb1cd + ( 0, 0, -50 ), radius, [ grenade ], content_override );
        
        if ( pathtrace[ "fraction" ] > 0 && uptrace[ "fraction" ] == 0 && downtrace[ "fraction" ] == 0 )
        {
            var_eb297cb422dbb1cd += uptrace[ "normal" ] * radius;
            uptrace = trace::sphere_trace( var_eb297cb422dbb1cd, var_eb297cb422dbb1cd + ( 0, 0, 50 ), radius, [ grenade ], content_override );
            downtrace = trace::sphere_trace( var_eb297cb422dbb1cd, var_eb297cb422dbb1cd + ( 0, 0, -50 ), radius, [ grenade ], content_override );
        }
        
        if ( uptrace[ "fraction" ] == 1 && downtrace[ "fraction" ] == 1 )
        {
            spawnorigin = var_20782d25c7070db7;
        }
        else
        {
            upposition = uptrace[ "position" ];
            downposition = downtrace[ "position" ];
            spawnorigin = ( upposition + downposition ) * 0.5;
        }
        
        /#
        #/
        
        killcament = spawn( "script_model", spawnorigin );
        killcament setscriptmoverkillcam( "explosive" );
        killcament linkto( grenade );
        grenade.killcament = killcament;
        level thread function_f2e8687424258253( grenade );
    }
}

// Namespace weapons
// Params 1
// Checksum 0x754fc50f, Offset: 0x1303d
// Size: 0x3e
function function_f2e8687424258253( grenade )
{
    killcament = grenade.killcament;
    grenade waittill( #"death" );
    wait 5;
    killcament delete();
}

// Namespace weapons
// Params 0
// Checksum 0x5dd255fd, Offset: 0x13083
// Size: 0x11b
function function_c8710a52eed8ac0b()
{
    self notify( #"hash_bc010af7a1ca018c" );
    self endon( #"hash_bc010af7a1ca018c" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    moving = 0;
    var_a7c6c3ae47fb4a7c = 0;
    
    while ( true )
    {
        while ( self.var_d194b79ba8a86a7c )
        {
            waitframe();
        }
        
        velocity = length( self getvelocity() );
        var_9443af8a66d75c29 = getdvarint( @"hash_e27b16db4789aa0", 75 );
        
        if ( !moving && velocity >= var_9443af8a66d75c29 && self playermount() < 0.1 )
        {
            moving = 1;
        }
        else if ( moving && ( velocity < var_9443af8a66d75c29 || self playermount() > 0 ) )
        {
            moving = 0;
        }
        
        if ( moving && var_a7c6c3ae47fb4a7c == 0 )
        {
            var_a7c6c3ae47fb4a7c = 1;
            recoilpercent = getdvarint( @"hash_3cc4ed231156f055", 125 );
            self player_recoilscaleon( recoilpercent );
        }
        else if ( moving == 0 && var_a7c6c3ae47fb4a7c )
        {
            var_a7c6c3ae47fb4a7c = 0;
            self player_recoilscaleon( 100 );
        }
        
        waitframe();
    }
}

