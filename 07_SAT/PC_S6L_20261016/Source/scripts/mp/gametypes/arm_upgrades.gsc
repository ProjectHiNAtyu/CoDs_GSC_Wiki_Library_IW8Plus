// scripts\mp\gametypes\arm_upgrades.gsc  (hash_1d4b01c1ec829364.gscc) (size: 14693 Bytes / 0x3965 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6a730b40 (1785924416)
// size ...... 14693 (0x3965)
// includes .. 19  (offset: 0x366d)
// strings ... 35  (offset: 0x3705)
// dev strs .. 0   (offset: 0x3965)
// exports ... 28  (offset: 0x292d)
// cseg ...... 0x32e + 0x25ff (0x292d)
// imports ... 71  (offset: 0x2d8d)
// animtree1 . 0   (offset: 0x3965)
// animtree2 . 0   (offset: 0x3965)
#using script_2f4866552f0ba818;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\armor;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\dom;
#using scripts\mp\gametypes\obj_dom;
#using scripts\mp\hostmigration;
#using scripts\mp\loot\common_kiosk;
#using scripts\mp\parachute;
#using scripts\mp\playerlogic;
#using scripts\mp\spawnselection;

#namespace arm_upgrades;

// Namespace arm_upgrades
// Params 0
// Checksum 0x63903f39, Offset: 0x34c
// Size: 0x24
function function_df9885cfabd9f8ef()
{
    level.common_armory_kiosk = spawnstruct();
    level.common_armory_kiosk.instances = [];
}

// Namespace arm_upgrades
// Params 0
// Checksum 0x30e56e95, Offset: 0x378
// Size: 0xc3
function function_dfb2277145204ce4()
{
    closestobj = undefined;
    closestdist = undefined;
    
    foreach ( objective in level.objectives )
    {
        dist = distancesquared( self.origin, objective.curorigin );
        
        if ( !isdefined( closestobj ) || dist < closestdist )
        {
            closestobj = objective;
            closestdist = dist;
        }
    }
    
    return closestobj;
}

// Namespace arm_upgrades
// Params 0
// Checksum 0xa4bf1f5c, Offset: 0x444
// Size: 0xab4
function function_e4f4a4cdd42c6c59()
{
    level.var_99e6db424e4b2f5c = 1;
    level.armoronweaponswitchlongpress = 1;
    level.var_a2ab7330f59aea5c = 1;
    common_kiosk::init_kiosk();
    level.var_87a21a3e41dc2e5d = &function_87a21a3e41dc2e5d;
    level.var_89173a04bb110bf3 = &function_2baf9756bdb2454d;
    level.modifyvehicledamage = &modifyvehicledamage;
    level.var_6eeae967c1fdc9f2 = &function_6eeae967c1fdc9f2;
    level.var_d976510402a1c939 = getdvarfloat( @"hash_fd13071a3ec6f158", 0.85 );
    level.var_d9764e0402a1c2a0 = getdvarfloat( @"hash_fd130a1a3ec6f7f1", 0.7 );
    level.var_f2729d197dfe5995 = getdvarint( @"hash_8062b21f870de073", 12 );
    upgrades = [];
    upgrade = spawnstruct();
    upgrade.ref = "research_upgrade_uav";
    upgrade.purchased = 0;
    upgrade.requiresownership = 1;
    upgrade.persistentpurchase = 1;
    upgrade.purchasecount = 0;
    upgrade.var_bba93356690c1f19 = 10;
    upgrades[ upgrade.ref ] = upgrade;
    upgrade = spawnstruct();
    upgrade.ref = "research_upgrade_vehicle";
    upgrade.purchased = 0;
    upgrade.requiresownership = 1;
    upgrade.persistentpurchase = 1;
    upgrade.purchasecount = 0;
    upgrade.var_bba93356690c1f19 = 10;
    upgrades[ upgrade.ref ] = upgrade;
    upgrade = spawnstruct();
    upgrade.ref = "research_upgrade_defense";
    upgrade.purchased = 0;
    upgrade.requiresownership = 1;
    upgrade.persistentpurchase = 1;
    upgrade.purchasecount = 0;
    upgrade.var_bba93356690c1f19 = 10;
    upgrades[ upgrade.ref ] = upgrade;
    upgrade = spawnstruct();
    upgrade.ref = "uav_ping";
    upgrade.purchased = 0;
    upgrade.requiresownership = 1;
    upgrade.persistentpurchase = 1;
    upgrade.purchasecount = 0;
    upgrade.var_bba93356690c1f19 = 10;
    upgrades[ upgrade.ref ] = upgrade;
    upgrade = spawnstruct();
    upgrade.ref = "uav_ping_radius";
    upgrade.purchased = 0;
    upgrade.requiresownership = 1;
    upgrade.persistentpurchase = 1;
    upgrade.purchasecount = 0;
    upgrade.var_bba93356690c1f19 = 10;
    upgrades[ upgrade.ref ] = upgrade;
    upgrade = spawnstruct();
    upgrade.ref = "uav_ping_duration";
    upgrade.purchased = 0;
    upgrade.requiresownership = 1;
    upgrade.persistentpurchase = 1;
    upgrade.purchasecount = 0;
    upgrade.var_bba93356690c1f19 = 10;
    upgrades[ upgrade.ref ] = upgrade;
    upgrade = spawnstruct();
    upgrade.ref = "uav_ping_global";
    upgrade.purchased = 0;
    upgrade.requiresownership = 1;
    upgrade.persistentpurchase = 1;
    upgrade.purchasecount = 0;
    upgrade.var_bba93356690c1f19 = 10;
    upgrades[ upgrade.ref ] = upgrade;
    globalupgrades = [];
    upgrade = spawnstruct();
    upgrade.ref = "defense_spawn_armor_tier_1";
    upgrade.purchased = 0;
    upgrade.requiresownership = 0;
    upgrade.persistentpurchase = 1;
    upgrade.purchasecount = 0;
    upgrade.var_bba93356690c1f19 = 10;
    globalupgrades[ upgrade.ref ] = upgrade;
    upgrade = spawnstruct();
    upgrade.ref = "defense_spawn_armor_tier_2";
    upgrade.purchased = 0;
    upgrade.requiresownership = 0;
    upgrade.persistentpurchase = 1;
    upgrade.purchasecount = 0;
    upgrade.var_bba93356690c1f19 = 10;
    globalupgrades[ upgrade.ref ] = upgrade;
    upgrade = spawnstruct();
    upgrade.ref = "defense_spawn_plate_tier_1";
    upgrade.purchased = 0;
    upgrade.requiresownership = 0;
    upgrade.persistentpurchase = 1;
    upgrade.purchasecount = 0;
    upgrade.var_bba93356690c1f19 = 10;
    globalupgrades[ upgrade.ref ] = upgrade;
    upgrade = spawnstruct();
    upgrade.ref = "defense_spawn_plate_tier_2";
    upgrade.purchased = 0;
    upgrade.requiresownership = 0;
    upgrade.persistentpurchase = 1;
    upgrade.purchasecount = 0;
    upgrade.var_bba93356690c1f19 = 10;
    globalupgrades[ upgrade.ref ] = upgrade;
    upgrade = spawnstruct();
    upgrade.ref = "vehicle_defense_tier_1";
    upgrade.purchased = 0;
    upgrade.requiresownership = 0;
    upgrade.persistentpurchase = 1;
    upgrade.purchasecount = 0;
    upgrade.var_bba93356690c1f19 = 10;
    globalupgrades[ upgrade.ref ] = upgrade;
    upgrade = spawnstruct();
    upgrade.ref = "vehicle_defense_tier_2";
    upgrade.purchased = 0;
    upgrade.requiresownership = 0;
    upgrade.persistentpurchase = 1;
    upgrade.purchasecount = 0;
    upgrade.var_bba93356690c1f19 = 10;
    globalupgrades[ upgrade.ref ] = upgrade;
    upgrade = spawnstruct();
    upgrade.ref = "vehicle_apc_improved_ammo";
    upgrade.purchased = 0;
    upgrade.requiresownership = 0;
    upgrade.persistentpurchase = 1;
    upgrade.purchasecount = 0;
    upgrade.var_bba93356690c1f19 = 10;
    globalupgrades[ upgrade.ref ] = upgrade;
    level.upgradedflagcapturetime = getdvarfloat( @"hash_a19bc7851e3c41b6", level.flagcapturetime * 2 );
    level.buystations = [];
    level.var_7d730156a0475922 = [];
    
    foreach ( team in level.teamnamelist )
    {
        level.var_7d730156a0475922[ team ] = [];
    }
    
    tracecontents = trace::create_default_contents( 1 );
    
    while ( level.objectives.size == 0 )
    {
        waitframe();
    }
    
    radiantbuystations = [];
    radiantstations = utility::getstructarray( "buystation_loc", "targetname" );
    
    foreach ( ent in radiantstations )
    {
        radiantbuystations[ ent.script_label ] = ent;
    }
    
    foreach ( key, objective in level.objectives )
    {
        groundorigin = ( 0, 0, 0 );
        spawnangles = ( 0, 0, 0 );
        
        if ( isdefined( radiantbuystations[ key ] ) )
        {
            groundorigin = radiantbuystations[ key ].origin;
            spawnangles = radiantbuystations[ key ].angles;
        }
        else
        {
            groundorigin = utility::drop_to_ground( objective.curorigin + anglestoforward( objective.trigger.angles ) * 50, 50, -200, undefined, tracecontents );
            spawnangles = objective.trigger.angles;
        }
        
        buystation = spawnscriptable( "br_plunder_box", groundorigin, spawnangles );
        buystation.objectivekey = key;
        level.buystations[ key ] = buystation;
        buystation setscriptablepartstate( "br_plunder_box", "visible" );
        buystation.var_8eeb10a67fe3cf31 = 0;
        upgradestatus = spawnstruct();
        upgradestatus.tier = 0;
        upgradestatus.upgrades = upgrades;
        
        foreach ( team in level.teamnamelist )
        {
            level.var_7d730156a0475922[ team ][ key ] = upgradestatus;
        }
    }
    
    upgradestatus = spawnstruct();
    upgradestatus.upgrades = globalupgrades;
    
    foreach ( team in level.teamnamelist )
    {
        level.var_7d730156a0475922[ team ][ "global" ] = upgradestatus;
    }
    
    level thread function_af2e3a24124f6115();
}

// Namespace arm_upgrades
// Params 2
// Checksum 0x37a39b8a, Offset: 0xf00
// Size: 0xfa
function function_87a21a3e41dc2e5d( instance, player )
{
    if ( instance.var_8eeb10a67fe3cf31 || level.var_b9ea12c4f2229c53 )
    {
        player setclientomnvar( "ui_buystation_override", common_kiosk::function_9d041619b6fccf18( "personalOnly" ) );
    }
    
    shopoverride = getdvar( hashcat( @"scr_buystation_override", instance.objectivekey ), "" );
    
    if ( shopoverride != "" )
    {
        shopindex = common_kiosk::function_9d041619b6fccf18( shopoverride + "_tier_" + level.var_7d730156a0475922[ player.team ][ instance.objectivekey ].tier );
        
        if ( !isdefined( shopindex ) )
        {
            shopindex = common_kiosk::function_9d041619b6fccf18( shopoverride );
        }
        
        if ( isdefined( shopindex ) )
        {
            player setclientomnvar( "ui_buystation_override", shopindex );
        }
    }
    
    player function_6c5b315fa85a4f59( instance.objectivekey );
}

// Namespace arm_upgrades
// Params 1
// Checksum 0x8bbe2f4b, Offset: 0x1002
// Size: 0x2bc
function function_6c5b315fa85a4f59( objectivekey )
{
    omnvarvalue = 0;
    
    if ( level.var_7d730156a0475922[ self.team ][ objectivekey ].upgrades[ "uav_ping" ].purchased )
    {
        omnvarvalue += 1;
    }
    
    if ( level.var_7d730156a0475922[ self.team ][ objectivekey ].upgrades[ "uav_ping_radius" ].purchased )
    {
        omnvarvalue += 2;
    }
    
    if ( level.var_7d730156a0475922[ self.team ][ objectivekey ].upgrades[ "uav_ping_duration" ].purchased )
    {
        omnvarvalue += 4;
    }
    
    if ( level.var_7d730156a0475922[ self.team ][ objectivekey ].upgrades[ "uav_ping_global" ].purchased )
    {
        omnvarvalue += 8;
    }
    
    if ( level.var_7d730156a0475922[ self.team ][ "global" ].upgrades[ "defense_spawn_armor_tier_1" ].purchased )
    {
        omnvarvalue += 16;
    }
    
    if ( level.var_7d730156a0475922[ self.team ][ "global" ].upgrades[ "defense_spawn_armor_tier_2" ].purchased )
    {
        omnvarvalue += 32;
    }
    
    if ( level.var_7d730156a0475922[ self.team ][ "global" ].upgrades[ "defense_spawn_plate_tier_1" ].purchased )
    {
        omnvarvalue += 64;
    }
    
    if ( level.var_7d730156a0475922[ self.team ][ "global" ].upgrades[ "defense_spawn_plate_tier_2" ].purchased )
    {
        omnvarvalue += 128;
    }
    
    if ( level.var_7d730156a0475922[ self.team ][ "global" ].upgrades[ "vehicle_defense_tier_1" ].purchased )
    {
        omnvarvalue += 256;
    }
    
    if ( level.var_7d730156a0475922[ self.team ][ "global" ].upgrades[ "vehicle_defense_tier_2" ].purchased )
    {
        omnvarvalue += 512;
    }
    
    if ( level.var_7d730156a0475922[ self.team ][ "global" ].upgrades[ "vehicle_apc_improved_ammo" ].purchased )
    {
        omnvarvalue += 1024;
    }
    
    self setclientomnvar( "ui_upgrade_status", omnvarvalue );
}

// Namespace arm_upgrades
// Params 0
// Checksum 0x26ad4ac8, Offset: 0x12c6
// Size: 0x104
function function_af2e3a24124f6115()
{
    flags::gameflagwait( "prematch_done" );
    
    if ( level.var_576f7155d6a0fa48 )
    {
        return;
    }
    
    foreach ( key, buystation in level.buystations )
    {
        foreach ( team in level.teamnamelist )
        {
            buystation function_da6d0f03ca3101ad( key, team );
        }
    }
}

// Namespace arm_upgrades
// Params 0
// Checksum 0xdaafcce4, Offset: 0x13d2
// Size: 0xcb
function function_c7d2f4bdf8ac4c13()
{
    if ( !level.var_a2ab7330f59aea5c )
    {
        return;
    }
    
    if ( level.var_576f7155d6a0fa48 )
    {
        return;
    }
    
    foreach ( key, buystation in level.buystations )
    {
        ownerteam = level.objectives[ key ] gameobjects::getownerteam();
        
        if ( self.team == ownerteam )
        {
            buystation enablescriptableplayeruse( self );
            continue;
        }
        
        buystation disablescriptableplayeruse( self );
    }
}

// Namespace arm_upgrades
// Params 2
// Checksum 0x4577ba0e, Offset: 0x14a5
// Size: 0xe5
function function_6a2e5bbf85fdef54( key, team )
{
    if ( !level.var_a2ab7330f59aea5c )
    {
        return;
    }
    
    if ( level.var_576f7155d6a0fa48 )
    {
        return;
    }
    
    if ( !team_utility::isgameplayteam( team ) )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( player.team == team )
        {
            level.buystations[ key ] enablescriptableplayeruse( player );
            continue;
        }
        
        level.buystations[ key ] disablescriptableplayeruse( player );
    }
}

// Namespace arm_upgrades
// Params 2
// Checksum 0xae684f9d, Offset: 0x1592
// Size: 0xc2
function function_da6d0f03ca3101ad( key, team )
{
    if ( !level.var_a2ab7330f59aea5c )
    {
        return;
    }
    
    if ( !team_utility::isgameplayteam( team ) )
    {
        return;
    }
    
    players = teams::getteamdata( team, "players" );
    
    foreach ( player in players )
    {
        level.buystations[ key ] disablescriptableplayeruse( player );
    }
}

// Namespace arm_upgrades
// Params 3
// Checksum 0x1e16a103, Offset: 0x165c
// Size: 0xa5
function function_4aabf66864c03ef4( objectivekey, team, ref )
{
    if ( !level.var_a2ab7330f59aea5c )
    {
        return 0;
    }
    
    if ( isdefined( level.var_7d730156a0475922[ team ][ "global" ].upgrades[ ref ] ) )
    {
        upgradedata = level.var_7d730156a0475922[ team ][ "global" ].upgrades[ ref ];
    }
    else
    {
        upgradedata = level.var_7d730156a0475922[ team ][ objectivekey ].upgrades[ ref ];
    }
    
    return upgradedata.purchased;
}

// Namespace arm_upgrades
// Params 2
// Checksum 0x75cc21b3, Offset: 0x170a
// Size: 0x75, Type: bool
function function_bb6300af9683b504( player, ref )
{
    if ( !level.var_a2ab7330f59aea5c )
    {
        return false;
    }
    
    objective = player function_dfb2277145204ce4();
    
    if ( objective.ownerteam != player.team )
    {
        return false;
    }
    
    applypurchase( objective.objectivekey, player.team, ref );
    return true;
}

// Namespace arm_upgrades
// Params 3
// Checksum 0x650d7109, Offset: 0x1788
// Size: 0x2c8
function applypurchase( objectivekey, team, ref )
{
    if ( !level.var_a2ab7330f59aea5c )
    {
        return;
    }
    
    if ( isdefined( level.var_7d730156a0475922[ team ][ "global" ].upgrades[ ref ] ) )
    {
        objectivekey = "global";
    }
    
    upgradedata = level.var_7d730156a0475922[ team ][ objectivekey ].upgrades[ ref ];
    
    if ( isdefined( upgradedata ) && upgradedata.purchased == 0 )
    {
        upgradedata.purchasecount++;
        self iprintlnbold( "Upgrade contribution " + upgradedata.purchasecount + "/" + upgradedata.var_bba93356690c1f19 );
        
        if ( upgradedata.purchasecount == upgradedata.var_bba93356690c1f19 )
        {
            upgradedata.purchased = 1;
            
            switch ( ref )
            {
                case #"hash_9789620b82d8908c":
                case #"hash_f0fd4758cf2900f0":
                case #"hash_f4fe496941705c28":
                    upgradedata.purchased = 0;
                    upgradedata.purchasecount = 0;
                    level.var_7d730156a0475922[ team ][ objectivekey ].tier++;
                    break;
            }
        }
        else
        {
            return;
        }
    }
    
    switch ( ref )
    {
        case #"hash_e4154ddbab061c63":
            level.objectives[ objectivekey ] gameobjects::setusetime( level.upgradedflagcapturetime );
            objective_setstate( level.objectives[ objectivekey ].objidnum, 1 );
            break;
        case #"hash_bb639a6ed9e9b88a":
            function_3eb4b6239610469f( objectivekey, team );
            break;
        case #"hash_6235851dae0eeca8":
            level.objectives[ objectivekey ] thread function_bbf309f5a0e3adb7( team );
            break;
        case #"hash_fd8da3bdddb8e1c2":
            namespace_14ab7f658b8ad5e4::function_7f52fc1bdeee6bf6( objectivekey, 5, team );
            break;
        case #"hash_dda8890cb35ca0bf":
            groupname = ai_mp_controller::function_391d43ea550a7a49();
            agent = ai_mp_controller::ai_mp_requestspawnagent( "enemy_mp_jugg_base", level.objectives[ objectivekey ].trigger.origin, ( 0, 0, 0 ), "absolute", "everybody", "jugg", groupname, team );
            agent thread ai_behavior::behavior_GuardStationary( agent );
            break;
        case #"hash_6c0c806bbf705a0c":
            break;
        case #"hash_9789620b82d8908c":
        case #"hash_f0fd4758cf2900f0":
        case #"hash_f4fe496941705c28":
            level.buystations[ objectivekey ] thread upgradebuystation();
            break;
    }
}

// Namespace arm_upgrades
// Params 0
// Checksum 0x18bd39cf, Offset: 0x1a58
// Size: 0x2f
function upgradebuystation()
{
    self setscriptablepartstate( "br_plunder_box", "disabled" );
    wait 1;
    self setscriptablepartstate( "br_plunder_box", "opening" );
    common_kiosk::kioskfixupproneplayers();
}

// Namespace arm_upgrades
// Params 2
// Checksum 0x8334ecff, Offset: 0x1a8f
// Size: 0xca
function restoreupgrades( team, objectivekey )
{
    if ( !level.var_a2ab7330f59aea5c )
    {
        return;
    }
    
    foreach ( ref, upgrade in level.var_7d730156a0475922[ team ][ objectivekey ].upgrades )
    {
        if ( upgrade.purchased && upgrade.persistentpurchase )
        {
            applypurchase( team, objectivekey, ref );
        }
    }
}

// Namespace arm_upgrades
// Params 2
// Checksum 0x89752ea3, Offset: 0x1b61
// Size: 0xad
function function_db60687d3222dcb4( team, objectivekey )
{
    if ( !level.var_a2ab7330f59aea5c )
    {
        return;
    }
    
    foreach ( ref, upgrade in level.var_7d730156a0475922[ team ][ objectivekey ].upgrades )
    {
        removeupgrade( team, objectivekey, ref );
    }
}

// Namespace arm_upgrades
// Params 3
// Checksum 0xbb486d57, Offset: 0x1c16
// Size: 0x1a6
function removeupgrade( team, objectivekey, ref )
{
    if ( !level.var_a2ab7330f59aea5c )
    {
        return;
    }
    
    upgrade = level.var_7d730156a0475922[ team ][ objectivekey ].upgrades[ ref ];
    
    if ( !upgrade.requiresownership || upgrade.persistentpurchase )
    {
        return;
    }
    
    level.var_7d730156a0475922[ team ][ objectivekey ].upgrades[ ref ] = 0;
    
    switch ( ref )
    {
        case #"hash_e4154ddbab061c63":
            level.objectives[ objectivekey ] gameobjects::setusetime( level.flagcapturetime );
            objective_setstate( level.objectives[ objectivekey ].objidnum, 0 );
            break;
        case #"hash_bb639a6ed9e9b88a":
            foreach ( team in level.teamnamelist )
            {
                function_a5525b04de63004e( objectivekey, team );
            }
            
            break;
        case #"hash_6235851dae0eeca8":
            level.objectives[ objectivekey ] thread disableuavping();
            break;
        case #"hash_6c0c806bbf705a0c":
        case #"hash_dda8890cb35ca0bf":
        case #"hash_fd8da3bdddb8e1c2":
            break;
    }
}

// Namespace arm_upgrades
// Params 2
// Checksum 0xb6f23f86, Offset: 0x1dc4
// Size: 0xd3
function function_3eb4b6239610469f( key, team )
{
    if ( !level.var_a2ab7330f59aea5c )
    {
        return;
    }
    
    if ( !team_utility::isgameplayteam( team ) )
    {
        return;
    }
    
    level.var_7a8de06f0eab5cd0[ key ] show();
    players = teams::getteamdata( team, "players" );
    
    foreach ( player in players )
    {
        level.var_7a8de06f0eab5cd0[ key ] enablescriptableplayeruse( player );
    }
}

// Namespace arm_upgrades
// Params 2
// Checksum 0xa0403818, Offset: 0x1e9f
// Size: 0xd3
function function_a5525b04de63004e( key, team )
{
    if ( !level.var_a2ab7330f59aea5c )
    {
        return;
    }
    
    if ( !team_utility::isgameplayteam( team ) )
    {
        return;
    }
    
    level.var_7a8de06f0eab5cd0[ key ] hide();
    players = teams::getteamdata( team, "players" );
    
    foreach ( player in players )
    {
        level.var_7a8de06f0eab5cd0[ key ] disablescriptableplayeruse( player );
    }
}

// Namespace arm_upgrades
// Params 1
// Checksum 0x303b7bca, Offset: 0x1f7a
// Size: 0x1f1
function function_bbf309f5a0e3adb7( team )
{
    if ( !level.var_a2ab7330f59aea5c )
    {
        return;
    }
    
    if ( !team_utility::isgameplayteam( team ) )
    {
        return;
    }
    
    self endon( #"disableuavping" );
    
    while ( true )
    {
        radius = level.var_7d730156a0475922[ team ][ self.objectivekey ].upgrades[ "uav_ping_radius" ].purchased ? getdvarint( @"hash_6bbb6d984ba826b4", 3000 ) : getdvarint( @"hash_bbf08a38c88577", 1000 );
        duration = level.var_7d730156a0475922[ team ][ self.objectivekey ].upgrades[ "uav_ping_duration" ].purchased ? getdvarfloat( @"hash_d3e12b5a75c3aada", 2 ) : getdvarfloat( @"hash_e34e9ea29b7cc0a9", 4 );
        
        if ( level.var_7d730156a0475922[ team ][ self.objectivekey ].upgrades[ "uav_ping_global" ].purchased )
        {
            foreach ( objective in level.objectives )
            {
                if ( objective.ownerteam == team )
                {
                    triggerportableradarpingteam( objective.curorigin, team, radius, int( duration * 1000 ) );
                }
            }
        }
        else
        {
            triggerportableradarpingteam( self.curorigin, team, radius, int( duration * 1000 ) );
        }
        
        wait duration;
    }
}

// Namespace arm_upgrades
// Params 0
// Checksum 0xd9d327b1, Offset: 0x2173
// Size: 0x1c
function disableuavping()
{
    if ( !level.var_a2ab7330f59aea5c )
    {
        return;
    }
    
    self notify( #"disableuavping" );
}

// Namespace arm_upgrades
// Params 0
// Checksum 0xafcf64ff, Offset: 0x2197
// Size: 0x145
function skydiveredeploy()
{
    level thread br_contract_manager::utilflare_shootflare( self.origin, "revive" );
    spawnheight = getdvarfloat( @"hash_3db53fbbad853ffc", 8000 );
    spawnorigin = self.origin;
    spawnorigin += ( 0, 0, spawnheight );
    fadedownduration = 0;
    fadeupduration = 0.5;
    thread playerlogic::managerespawnfade( fadedownduration, fadeupduration );
    
    if ( fadedownduration > 0 )
    {
        self waittill( #"fadedown_complete" );
    }
    
    facingorigin = ( level.mapcorners[ 0 ].origin + level.mapcorners[ 1 ].origin ) * 0.5;
    toselection = facingorigin - spawnorigin;
    spawnangles = vectortoangles( vectornormalize( toselection ) );
    self setorigin( spawnorigin );
    self setplayerangles( spawnangles );
    
    if ( level.parachutecancutautodeploy )
    {
        self skydive_cutautodeployon();
    }
    else
    {
        self skydive_cutautodeployoff();
    }
    
    if ( level.parachutecancutparachute )
    {
        self skydive_cutparachuteon();
    }
    else
    {
        self skydive_cutparachuteoff();
    }
    
    thread parachute::startfreefall( level.parachutedeploydelay, 0, undefined, undefined, 1 );
}

// Namespace arm_upgrades
// Params 0
// Checksum 0x642b0b5, Offset: 0x22e4
// Size: 0x24d
function function_ab53d8d8cafe4f07()
{
    level endon( #"game_ended" );
    level waittill( #"prematch_done" );
    level thread spawnselection::updatefobindanger();
    
    while ( !level.gameended )
    {
        wait getdvarint( @"hash_ac8e27080e51148b", 20 );
        hostmigration::waittillhostmigrationdone();
        domflags = getowneddomflags();
        
        if ( !isdefined( level.cashtick ) )
        {
            level.cashtick = [];
        }
        
        foreach ( entry in level.teamnamelist )
        {
            level.cashtick[ entry ] = 0;
        }
        
        if ( domflags.size )
        {
            for ( i = 1; i < domflags.size ; i++ )
            {
                domflag = domflags[ i ];
                flagscore = gettime() - domflag.capturetime;
                
                for ( j = i - 1; j >= 0 && flagscore > gettime() - domflags[ j ].capturetime ; j-- )
                {
                    domflags[ j + 1 ] = domflags[ j ];
                }
                
                domflags[ j + 1 ] = domflag;
            }
            
            foreach ( domflag in domflags )
            {
                team = domflag gameobjects::getownerteam();
                assert( team_utility::isgameplayteam( team ) );
                var_d9425977785add8f = obj_dom::getteamflagcount( team );
                
                if ( var_d9425977785add8f >= level.flagsrequiredtoscore )
                {
                    level.cashtick[ team ] += level.var_f44b0da5db239f15;
                }
            }
        }
        
        updatecash();
    }
}

// Namespace arm_upgrades
// Params 0
// Checksum 0xbd2f5cf6, Offset: 0x2539
// Size: 0x10f
function updatecash()
{
    foreach ( entry in level.teamnamelist )
    {
        if ( level.cashtick[ entry ] > 0 )
        {
            foreach ( player in teams::getteamdata( entry, "players" ) )
            {
                player [[ level.var_cc4ceaea968640d2 ]]( level.cashtick[ entry ] );
            }
        }
    }
}

// Namespace arm_upgrades
// Params 0
// Checksum 0x36fc4a21, Offset: 0x2650
// Size: 0x8
function getowneddomflags()
{
    return dom::getowneddomflags();
}

// Namespace arm_upgrades
// Params 1
// Checksum 0xae0cfab0, Offset: 0x2661
// Size: 0x14f
function function_2baf9756bdb2454d( player )
{
    armorvalue = undefined;
    numplates = undefined;
    
    if ( level.var_7d730156a0475922[ player.team ][ "global" ].upgrades[ "defense_spawn_armor_tier_2" ].purchased )
    {
        armorvalue = player.maxarmorhealth;
    }
    else if ( level.var_7d730156a0475922[ player.team ][ "global" ].upgrades[ "defense_spawn_armor_tier_1" ].purchased )
    {
        armorvalue = level.spawnarmor + level.var_1bfbe247e8d32b1b;
    }
    
    if ( level.var_7d730156a0475922[ player.team ][ "global" ].upgrades[ "defense_spawn_plate_tier_2" ].purchased )
    {
        numplates = armor::function_db9ebf086f67fe92();
    }
    else if ( level.var_7d730156a0475922[ player.team ][ "global" ].upgrades[ "defense_spawn_plate_tier_1" ].purchased )
    {
        numplates = level.spawnarmorplates + 1;
    }
    
    return [ armorvalue, numplates ];
}

// Namespace arm_upgrades
// Params 1
// Checksum 0xf390951, Offset: 0x27b9
// Size: 0x11c
function modifyvehicledamage( data )
{
    switch ( data.victim vehicle::get_ref() )
    {
        case %"vehiclebundle:light_tank_mp":
        case %"hash_5d0aabf994c1e2ac":
            if ( level.var_7d730156a0475922[ data.victim.team ][ "global" ].upgrades[ "vehicle_defense_tier_2" ].purchased )
            {
                data.damage = int( data.damage * level.var_d9764e0402a1c2a0 );
            }
            else if ( level.var_7d730156a0475922[ data.victim.team ][ "global" ].upgrades[ "vehicle_defense_tier_1" ].purchased )
            {
                data.damage = int( data.damage * level.var_d976510402a1c939 );
            }
            
            break;
    }
    
    return data.damage;
}

// Namespace arm_upgrades
// Params 1
// Checksum 0xccabd4bf, Offset: 0x28de
// Size: 0x4e
function function_6eeae967c1fdc9f2( vehicle )
{
    if ( level.var_7d730156a0475922[ vehicle.team ][ "global" ].upgrades[ "vehicle_apc_improved_ammo" ].purchased )
    {
        return level.var_f2729d197dfe5995;
    }
}

