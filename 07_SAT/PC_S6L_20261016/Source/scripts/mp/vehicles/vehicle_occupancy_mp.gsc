// scripts\mp\vehicles\vehicle_occupancy_mp.gsc  (hash_1222322394e3dde0.gscc) (size: 12195 Bytes / 0x2fa3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7de4f648 (2112157256)
// size ...... 12195 (0x2fa3)
// includes .. 23  (offset: 0x2dd7)
// strings ... 10  (offset: 0x2e8f)
// dev strs .. 8   (offset: 0x2f43)
// exports ... 24  (offset: 0x1dc3)
// cseg ...... 0xec + 0x1cd7 (0x1dc3)
// imports ... 93  (offset: 0x2183)
// animtree1 . 0   (offset: 0x2fa3)
// animtree2 . 0   (offset: 0x2fa3)
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_occupancy;
#using scripts\common\weapon;
#using scripts\mp\br\gametypes\br_instance_inventory;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\class;
#using scripts\mp\common\equipment\disguise;
#using scripts\mp\common\perks\perks;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\vehicles\vehicle_mp;

#namespace vehicle_occupancy_mp;

// Namespace vehicle_occupancy_mp
// Params 1
// Checksum 0x4ec7947f, Offset: 0x10a
// Size: 0x201
function vehicle_occupancy_mp_init( params )
{
    utility::registersharedfunc( #"vehicle_occupancy", #"onEnterVehicle", &vehicle_occupancy_mp_onentervehicle );
    utility::registersharedfunc( #"vehicle_occupancy", #"onExitVehicle", &vehicle_occupancy_mp_onexitvehicle );
    utility::registersharedfunc( #"vehicle_occupancy", #"registerInstance", &vehicle_occupancy_mp_registerinstance );
    utility::registersharedfunc( #"vehicle_occupancy", #"deregisterInstance", &vehicle_occupancy_mp_deregisterinstance );
    utility::registersharedfunc( #"vehicle_occupancy", #"updateOwner", &vehicle_occupancy_mp_updateowner );
    utility::registersharedfunc( #"vehicle_occupancy", #"registersentient", &vehicle_occupancy_mp_registersentient );
    utility::registersharedfunc( #"vehicle_occupancy", #"unregistersentient", &vehicle_occupancy_mp_unregistersentient );
    utility::registersharedfunc( #"vehicle_occupancy", #"issentient", &vehicle_occupancy_mp_issentient );
    utility::registersharedfunc( #"vehicle_occupancy", #"takeriotshield", &vehicle_occupancy_mp_takeriotshield );
    utility::registersharedfunc( #"vehicle_occupancy", #"giveriotshield", &vehicle_occupancy_mp_giveriotshield );
    utility::registersharedfunc( #"vehicle_occupancy", #"updateRiotShield", &vehicle_occupancy_mp_updateriotshield );
    utility::registersharedfunc( #"vehicle_occupancy", #"hideCashBag", &vehicle_occupancy_mp_hidecashbag );
    utility::registersharedfunc( #"vehicle_occupancy", #"showcashbag", &vehicle_occupancy_mp_showcashbag );
    utility::registersharedfunc( #"vehicle_occupancy", #"changedSeats", &vehicle_occupancy_mp_changedseats );
    val::group_register( "vehicle", [ "gesture", "killstreaks", "supers" ] );
    val::group_register( "vehicle_passenger", [ "gesture", "supers" ] );
    
    /#
        vehicle_occupancy_mp_debug_init();
    #/
}

// Namespace vehicle_occupancy_mp
// Params 4
// Checksum 0x73708660, Offset: 0x313
// Size: 0x129
function vehicle_occupancy_mp_onentervehicle( vehicle, newseatid, player, data )
{
    if ( perks::function_ae69f867e887ac4a( "specialty_ghost" ) )
    {
        player perk::giveperk( "specialty_ghost" );
    }
    
    if ( perks::function_ae69f867e887ac4a( "specialty_tracker_jammer" ) )
    {
        player perk::giveperk( "specialty_tracker_jammer" );
    }
    
    isbrgamemode = isbrgamemode();
    
    if ( !isbrgamemode || vehicle_occupancy::is_driver_seat( vehicle, newseatid ) )
    {
        player val::group_set( "vehicle", 0 );
    }
    else if ( isbrgamemode )
    {
        player val::group_set( "vehicle_passenger", 0 );
    }
    
    gametype = game_utility::getgametype();
    
    if ( gametype == "plunder" )
    {
        br_plunder::plunder_allowallrepositoryuseforplayer( player, 0, 1 );
    }
    
    utility::callsharedfunc( #"gametype", #"onplayerentervehicle", vehicle, player );
    
    if ( !isbrgamemode() )
    {
        vehicle_occupancy_mp_takeriotshield( player );
    }
    
    vehicle_occupancy_mp_updatemarkfilter( vehicle );
    
    if ( isdefined( level.disguisedata ) && vehicle_mp::function_a37d52efb9e9115a( vehicle ) )
    {
        player disguise::function_5f8ae5d89925e995( 1 );
    }
}

// Namespace vehicle_occupancy_mp
// Params 4
// Checksum 0x2a9d3e5c, Offset: 0x444
// Size: 0x14f
function vehicle_occupancy_mp_onexitvehicle( vehicle, oldseatid, player, data )
{
    if ( !data.playerdisconnect )
    {
        if ( !data.playerdeath )
        {
            player perk::removeperk( "specialty_ghost" );
            player perk::removeperk( "specialty_tracker_jammer" );
            isbrgamemode = isbrgamemode();
            
            if ( !isbrgamemode || vehicle_occupancy::is_driver_seat( vehicle, oldseatid ) )
            {
                player val::group_reset( "vehicle" );
            }
            else if ( isbrgamemode )
            {
                player val::group_reset( "vehicle_passenger" );
            }
            
            gametype = game_utility::getgametype();
            
            if ( gametype == "plunder" )
            {
                br_plunder::plunder_allowallrepositoryuseforplayer( player, 1, 1 );
            }
        }
        
        vehicle_occupancy_mp_giveriotshield( player, data.playerdeath, data.playerlaststand );
        
        if ( isdefined( level.disguisedata ) && vehicle_mp::function_a37d52efb9e9115a( vehicle ) )
        {
            player disguise::function_5f8ae5d89925e995( 0 );
        }
        
        player notify( #"vehicle_exit" );
        utility::callsharedfunc( #"gametype", #"hash_d4bfc76fc769af", vehicle, player );
        level thread function_836182fc935ac5a0( player, vehicle );
    }
    
    vehicle_occupancy_mp_updatemarkfilter( vehicle );
}

// Namespace vehicle_occupancy_mp
// Params 2
// Checksum 0xddc58c71, Offset: 0x59b
// Size: 0x51
function function_836182fc935ac5a0( player, vehicle )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player.lastvehicle = vehicle;
    wait 1;
    
    if ( isdefined( player ) && player.lastvehicle == vehicle )
    {
        player.lastvehicle = undefined;
    }
}

// Namespace vehicle_occupancy_mp
// Params 4
// Checksum 0x1582f2cb, Offset: 0x5f4
// Size: 0x9e
function vehicle_occupancy_mp_changedseats( player, vehicle, oldseatid, seatid )
{
    gametype = isbrgamemode();
    
    if ( gametype && isdefined( oldseatid ) && isdefined( seatid ) )
    {
        if ( vehicle_occupancy::is_driver_seat( vehicle, oldseatid ) )
        {
            player val::group_reset( "vehicle" );
            player val::group_set( "vehicle_passenger", 0 );
            return;
        }
        
        if ( vehicle_occupancy::is_driver_seat( vehicle, seatid ) )
        {
            player val::group_reset( "vehicle_passenger" );
            player val::group_set( "vehicle", 0 );
        }
    }
}

// Namespace vehicle_occupancy_mp
// Params 1
// Checksum 0xcbac2868, Offset: 0x69a
// Size: 0x195
function vehicle_occupancy_mp_updatemarkfilter( vehicle )
{
    if ( !isdefined( vehicle.occupants ) )
    {
        return;
    }
    
    if ( !isdefined( vehicle.marksenabled ) )
    {
        vehicle.marksenabled = 1;
    }
    
    var_7452a356399d032c = vehicle.marksenabled;
    occupants = vehicle_occupancy::get_all_occupants( vehicle );
    vehicle.marksenabled = occupants.size > 0;
    
    if ( var_7452a356399d032c && !vehicle.marksenabled )
    {
        vehicle disableplayermarks( #"killstreak" );
    }
    else if ( !var_7452a356399d032c && vehicle.marksenabled )
    {
        vehicle enableplayermarks( #"killstreak" );
    }
    
    if ( vehicle.marksenabled )
    {
        if ( level.teambased )
        {
            protectedteams = [];
            
            foreach ( occupant in occupants )
            {
                if ( isdefined( occupant.team ) && !arraycontains( protectedteams, occupant.team ) )
                {
                    protectedteams[ protectedteams.size ] = occupant.team;
                }
            }
            
            vehicle filteroutplayermarks( protectedteams );
            return;
        }
        
        vehicle filteroutplayermarks( occupants );
    }
}

// Namespace vehicle_occupancy_mp
// Params 1
// Checksum 0x63cf639c, Offset: 0x837
// Size: 0x18
function vehicle_occupancy_mp_registerinstance( vehicle )
{
    /#
        function_ea72bf26abba56df( vehicle );
    #/
}

// Namespace vehicle_occupancy_mp
// Params 1
// Checksum 0x9a231f51, Offset: 0x857
// Size: 0x18
function vehicle_occupancy_mp_deregisterinstance( vehicle )
{
    /#
        function_ce78b5f70b527b5c( vehicle );
    #/
}

// Namespace vehicle_occupancy_mp
// Params 4
// Checksum 0x7298c12f, Offset: 0x877
// Size: 0x61
function vehicle_occupancy_mp_hidecashbag( vehicle, newseatid, player, data )
{
    if ( isdefined( newseatid ) )
    {
        leveldataforseat = vehicle_occupancy::function_568cd324ac705619( vehicle vehicle::get_ref(), newseatid );
        
        if ( leveldataforseat.showcashbag )
        {
            return;
        }
    }
    
    player::function_988f8c8a0acafabf( player );
}

// Namespace vehicle_occupancy_mp
// Params 4
// Checksum 0x11656409, Offset: 0x8e0
// Size: 0x61
function vehicle_occupancy_mp_showcashbag( vehicle, oldseatid, player, data )
{
    if ( isdefined( oldseatid ) )
    {
        leveldataforseat = vehicle_occupancy::function_568cd324ac705619( vehicle vehicle::get_ref(), oldseatid );
        
        if ( leveldataforseat.showcashbag )
        {
            return;
        }
    }
    
    player::function_82e25e4a8962e68a( player );
}

// Namespace vehicle_occupancy_mp
// Params 1
// Checksum 0xfcc47f92, Offset: 0x949
// Size: 0x3b
function vehicle_occupancy_mp_updateowner( vehicle )
{
    vehicle_occupancy_mp_updatemarkfilter( vehicle );
    
    if ( isdefined( vehicle.owner ) )
    {
        vehicle.lastowner = vehicle.owner;
    }
}

// Namespace vehicle_occupancy_mp
// Params 3
// Checksum 0x511f8359, Offset: 0x98c
// Size: 0x2c2
function vehicle_occupancy_mp_takeriotshield( player, vehicle, newseatid )
{
    riotshieldweapon = undefined;
    riotshieldiscurrentprimary = undefined;
    var_cd7bb6f332ee144e = undefined;
    primaryweapons = player getweaponslistprimaries();
    
    foreach ( weapon in primaryweapons )
    {
        if ( isnullweapon( weapon ) )
        {
            continue;
        }
        
        if ( weapon_utility::isriotshield( weapon ) )
        {
            assert( !isdefined( riotshieldweapon ), "<dev string:x24>" );
            riotshieldweapon = weapon;
            
            if ( issameweapon( riotshieldweapon, player getcurrentprimaryweapon() ) )
            {
                riotshieldiscurrentprimary = 1;
            }
            
            continue;
        }
        
        if ( !isdefined( var_cd7bb6f332ee144e ) && !weapon::ismeleeoverrideweapon( weapon ) && !weapon::isunderwaterweapon( weapon ) && !weapon::isclimbweapon( weapon ) )
        {
            noaltweapon = weapon getnoaltweapon();
            
            if ( noaltweapon.inventorytype != "primary" )
            {
                continue;
            }
            
            var_cd7bb6f332ee144e = weapon;
        }
    }
    
    if ( !isdefined( riotshieldweapon ) && isbrgamemode() && common_inventory::function_5c64d2b24a8c3e18() && player common_inventory::function_d33e11a8dda3cb20() )
    {
        playerdataweapon = player common_inventory::function_7bf60ff8870e96b4();
        
        if ( isdefined( playerdataweapon ) && weapon_utility::isriotshield( playerdataweapon ) )
        {
            riotshieldweapon = playerdataweapon;
        }
    }
    
    weaponindex = 0;
    
    if ( isdefined( riotshieldweapon ) )
    {
        if ( isbrgamemode() && common_inventory::function_5c64d2b24a8c3e18() )
        {
            for ( i = 0; i < 3 ; i++ )
            {
                weapontocheck = br_pickups::function_5ef22d170cdde55e( player, i );
                
                if ( weapontocheck == riotshieldweapon )
                {
                    weaponindex = i;
                    
                    if ( br_instance_inventory::function_926a8f8643d34690() )
                    {
                        weaponmetadata = br_instance_inventory::function_6a05cf5689058e1f( player, i );
                        player.riotshieldmetadata = weaponmetadata;
                    }
                    
                    break;
                }
            }
        }
        
        if ( isbrgamemode() )
        {
            if ( weaponindex == 2 )
            {
                player common_inventory::function_56f7e890f83685bd();
            }
            else
            {
                player br_pickups::quickdropremoveweapon( riotshieldweapon );
            }
        }
        else
        {
            player inventory_utility::_takeweapon( riotshieldweapon );
        }
        
        player.riotshieldtaken = riotshieldweapon;
        player.riotshieldiscurrentprimary = riotshieldiscurrentprimary;
        
        if ( riotshieldiscurrentprimary )
        {
            vehicle_occupancy_mp_updateriotshield( player, vehicle, newseatid );
        }
        
        assert( isdefined( var_cd7bb6f332ee144e ), "<dev string:x76>" );
        player class::riotshieldonweaponchange( var_cd7bb6f332ee144e );
        player notify( #"modified_riot_shield" );
        player endon( #"modified_riot_shield" );
        player childthread inventory_utility::forcevalidweapon( var_cd7bb6f332ee144e );
    }
}

// Namespace vehicle_occupancy_mp
// Params 3
// Checksum 0x867df878, Offset: 0xc56
// Size: 0xf1
function vehicle_occupancy_mp_giveriotshield( player, fromdeath, fromlaststand )
{
    if ( isdefined( player.riotshieldtaken ) )
    {
        isbrgamemode = isbrgamemode();
        
        if ( !fromdeath && ( isbrgamemode || !fromlaststand ) )
        {
            if ( isbrgamemode )
            {
                player item_weapon::function_96add18b226ff731( player.riotshieldtaken, 1, undefined );
            }
            else
            {
                player inventory_utility::_giveweapon( player.riotshieldtaken );
            }
            
            player class::trackriotshield_tryreset();
            
            if ( player.riotshieldiscurrentprimary )
            {
                player notify( #"modified_riot_shield" );
                player endon( #"modified_riot_shield" );
                
                if ( !fromlaststand )
                {
                    player childthread inventory_utility::_switchtoweaponimmediate( player.riotshieldtaken );
                }
            }
        }
        
        player.riotshieldtaken = undefined;
        player.riotshieldiscurrentprimary = undefined;
        player notify( #"modified_riot_shield" );
    }
}

// Namespace vehicle_occupancy_mp
// Params 3
// Checksum 0x58a74aad, Offset: 0xd4f
// Size: 0x95
function vehicle_occupancy_mp_updateriotshield( player, vehicle, newseatid )
{
    if ( isdefined( player.riotshieldtaken ) && player.riotshieldiscurrentprimary )
    {
        if ( !isdefined( newseatid ) )
        {
            return;
        }
        
        if ( vehicle_occupancy::is_driver_seat( vehicle, newseatid ) )
        {
            return;
        }
        
        if ( vehicle_occupancy::function_b2d43c8350835934( vehicle, newseatid ) )
        {
            return;
        }
        
        leveldataforseat = vehicle_occupancy::function_568cd324ac705619( vehicle vehicle::get_ref(), newseatid );
        
        if ( isdefined( leveldataforseat.turretobjweapon ) )
        {
            return;
        }
        
        player.riotshieldiscurrentprimary = undefined;
    }
}

// Namespace vehicle_occupancy_mp
// Params 1
// Checksum 0x241f47f7, Offset: 0xdec
// Size: 0xfc
function vehicle_occupancy_mp_registersentient( vehicle )
{
    leveldataforvehicle = vehicle_occupancy::get_data( vehicle vehicle::get_ref() );
    
    if ( !isdefined( leveldataforvehicle.threatbiasgroup ) )
    {
        return;
    }
    
    if ( level.teambased )
    {
        team = vehicle.team;
        
        if ( vehicle.team == "neutral" )
        {
            team = undefined;
        }
        
        if ( !isdefined( team ) && isdefined( vehicle.owner ) )
        {
            team = vehicle.owner.team;
        }
        
        if ( isdefined( team ) )
        {
            if ( vehicle.sentientteam != team )
            {
                vehicle_occupancy_mp_unregistersentient( vehicle );
                vehicle sentientpoolmanager::registersentient( leveldataforvehicle.threatbiasgroup, team );
                vehicle.sentientteam = team;
            }
            
            return;
        }
        
        if ( isdefined( vehicle.sentientteam ) )
        {
            vehicle_occupancy_mp_unregistersentient( vehicle );
        }
    }
}

// Namespace vehicle_occupancy_mp
// Params 1
// Checksum 0x8d87b5a0, Offset: 0xef0
// Size: 0x24
function vehicle_occupancy_mp_unregistersentient( vehicle )
{
    vehicle notify( #"remove_sentient" );
    vehicle.sentientteam = undefined;
}

// Namespace vehicle_occupancy_mp
// Params 1
// Checksum 0xddcf4652, Offset: 0xf1c
// Size: 0x18, Type: bool
function vehicle_occupancy_mp_issentient( vehicle )
{
    return isdefined( vehicle.sentientteam );
}

/#

    // Namespace vehicle_occupancy_mp
    // Params 0
    // Checksum 0x1a86cc2b, Offset: 0xf3d
    // Size: 0x40, Type: dev
    function vehicle_occupancy_mp_debug_init()
    {
        if ( getdvarint( @"nodebug", 0 ) >= 1 )
        {
            return;
        }
        
        leveldata = vehicle_occupancy::get_level_data();
        leveldata.debuginstances = [];
        thread function_bf6fac01d16cb50c();
    }

    // Namespace vehicle_occupancy_mp
    // Params 1
    // Checksum 0xf82e352c, Offset: 0xf85
    // Size: 0x57, Type: dev
    function function_ea72bf26abba56df( vehicle )
    {
        leveldata = vehicle_occupancy::get_level_data();
        leveldata.debuginstances = function_5713d46873b29625( leveldata.debuginstances );
        leveldata.debuginstances[ leveldata.debuginstances.size ] = vehicle;
    }

    // Namespace vehicle_occupancy_mp
    // Params 1
    // Checksum 0x7b4763b8, Offset: 0xfe4
    // Size: 0x3e, Type: dev
    function function_ce78b5f70b527b5c( vehicle )
    {
        leveldata = vehicle_occupancy::get_level_data();
        leveldata.debuginstances = arrayremove( leveldata.debuginstances, vehicle );
    }

    // Namespace vehicle_occupancy_mp
    // Params 0
    // Checksum 0xe3c5ca6, Offset: 0x102a
    // Size: 0x5f, Type: dev
    function function_bf6fac01d16cb50c()
    {
        while ( true )
        {
            if ( getdvarint( @"hash_dd33e6bf6e533554", 0 ) != 0 || getdvarint( @"hash_5a20dfa97c106e84", 0 ) != 0 )
            {
                function_2f9d31704c31d8b5();
            }
            
            if ( getdvarint( @"hash_58b1b5f716ceb29b", 0 ) != 0 )
            {
                function_3f5617fdc9605f83();
            }
            
            wait level.framedurationseconds;
        }
    }

    // Namespace vehicle_occupancy_mp
    // Params 0
    // Checksum 0x90945119, Offset: 0x1091
    // Size: 0x60a, Type: dev
    function function_3f5617fdc9605f83()
    {
        leveldata = vehicle_occupancy::get_level_data();
        
        foreach ( vehicle in leveldata.debuginstances )
        {
            if ( !isdefined( vehicle ) )
            {
                continue;
            }
            
            vehicle thread utility::draw_ent_axis( ( 0, 0, 1 ), 1, 10 );
            leveldataforvehicle = vehicle_damage::get_data( vehicle vehicle::get_ref() );
            
            if ( !( isdefined( leveldataforvehicle ) && isdefined( leveldataforvehicle.explosionextents ) ) )
            {
                continue;
            }
            
            front = leveldataforvehicle.explosionextents.front;
            back = leveldataforvehicle.explosionextents.back;
            left = leveldataforvehicle.explosionextents.left;
            right = leveldataforvehicle.explosionextents.right;
            top = leveldataforvehicle.explosionextents.top;
            bottom = leveldataforvehicle.explosionextents.bottom;
            tfl = vehicle.origin;
            tfl += anglestoup( vehicle.angles ) * top;
            tfl += anglestoforward( vehicle.angles ) * front;
            tfl += anglestoright( vehicle.angles ) * -1 * left;
            tfr = vehicle.origin;
            tfr += anglestoup( vehicle.angles ) * top;
            tfr += anglestoforward( vehicle.angles ) * front;
            tfr += anglestoright( vehicle.angles ) * right;
            tbl = vehicle.origin;
            tbl += anglestoup( vehicle.angles ) * top;
            tbl += anglestoforward( vehicle.angles ) * -1 * back;
            tbl += anglestoright( vehicle.angles ) * -1 * left;
            tbr = vehicle.origin;
            tbr += anglestoup( vehicle.angles ) * top;
            tbr += anglestoforward( vehicle.angles ) * -1 * back;
            tbr += anglestoright( vehicle.angles ) * right;
            bfl = vehicle.origin;
            bfl += anglestoup( vehicle.angles ) * -1 * bottom;
            bfl += anglestoforward( vehicle.angles ) * front;
            bfl += anglestoright( vehicle.angles ) * -1 * left;
            bfr = vehicle.origin;
            bfr += anglestoup( vehicle.angles ) * -1 * bottom;
            bfr += anglestoforward( vehicle.angles ) * front;
            bfr += anglestoright( vehicle.angles ) * right;
            bbl = vehicle.origin;
            bbl += anglestoup( vehicle.angles ) * -1 * bottom;
            bbl += anglestoforward( vehicle.angles ) * -1 * back;
            bbl += anglestoright( vehicle.angles ) * -1 * left;
            bbr = vehicle.origin;
            bbr += anglestoup( vehicle.angles ) * -1 * bottom;
            bbr += anglestoforward( vehicle.angles ) * -1 * back;
            bbr += anglestoright( vehicle.angles ) * right;
            thread debug_utility::drawline( tfl, tfr, level.framedurationseconds, ( 1, 1, 1 ) );
            thread debug_utility::drawline( tfl, tbl, level.framedurationseconds, ( 1, 1, 1 ) );
            thread debug_utility::drawline( tfr, tbr, level.framedurationseconds, ( 1, 1, 1 ) );
            thread debug_utility::drawline( tbr, tbl, level.framedurationseconds, ( 1, 1, 1 ) );
            thread debug_utility::drawline( bfl, bfr, level.framedurationseconds, ( 1, 1, 1 ) );
            thread debug_utility::drawline( bfl, bbl, level.framedurationseconds, ( 1, 1, 1 ) );
            thread debug_utility::drawline( bfr, bbr, level.framedurationseconds, ( 1, 1, 1 ) );
            thread debug_utility::drawline( bbr, bbl, level.framedurationseconds, ( 1, 1, 1 ) );
            thread debug_utility::drawline( tfl, bfl, level.framedurationseconds, ( 1, 1, 1 ) );
            thread debug_utility::drawline( tfr, bfr, level.framedurationseconds, ( 1, 1, 1 ) );
            thread debug_utility::drawline( tbl, bbl, level.framedurationseconds, ( 1, 1, 1 ) );
            thread debug_utility::drawline( tbr, bbr, level.framedurationseconds, ( 1, 1, 1 ) );
        }
    }

    // Namespace vehicle_occupancy_mp
    // Params 0
    // Checksum 0x235036ff, Offset: 0x16a3
    // Size: 0x720, Type: dev
    function function_2f9d31704c31d8b5()
    {
        leveldata = vehicle_occupancy::get_level_data();
        
        foreach ( vehicle in leveldata.debuginstances )
        {
            if ( isdefined( vehicle ) )
            {
                leveldataforvehicle = undefined;
                vehicle thread utility::draw_ent_axis( ( 0, 0, 1 ), 1, 10 );
                
                if ( getdvarint( @"hash_5a20dfa97c106e84", 0 ) != 0 )
                {
                    front = getdvarfloat( @"hash_ae48fc0251f15678", 0 );
                    back = getdvarfloat( @"hash_27b66fa4ccb92042", 0 );
                    left = getdvarfloat( @"hash_1b55e0d66a16ab70", 0 );
                    right = getdvarfloat( @"hash_f9f204d56cd2b845", 0 );
                    top = getdvarfloat( @"hash_1e89088dab07f7fc", 0 );
                    bottom = getdvarfloat( @"hash_2346182109bbc14a", 0 );
                }
                else
                {
                    leveldataforvehicle = vehicle_occupancy::get_data( vehicle vehicle::get_ref() );
                    
                    if ( !( isdefined( leveldataforvehicle ) && isdefined( leveldataforvehicle.exitextents ) ) )
                    {
                        return;
                    }
                    
                    front = leveldataforvehicle.exitextents[ "<dev string:xd3>" ];
                    back = leveldataforvehicle.exitextents[ "<dev string:xd9>" ];
                    left = leveldataforvehicle.exitextents[ "<dev string:xde>" ];
                    right = leveldataforvehicle.exitextents[ "<dev string:xe3>" ];
                    top = leveldataforvehicle.exitextents[ "<dev string:xe9>" ];
                    bottom = leveldataforvehicle.exitextents[ "<dev string:xed>" ];
                }
                
                tfl = vehicle.origin;
                tfl += anglestoup( vehicle.angles ) * top;
                tfl += anglestoforward( vehicle.angles ) * front;
                tfl += anglestoright( vehicle.angles ) * -1 * left;
                tfr = vehicle.origin;
                tfr += anglestoup( vehicle.angles ) * top;
                tfr += anglestoforward( vehicle.angles ) * front;
                tfr += anglestoright( vehicle.angles ) * right;
                tbl = vehicle.origin;
                tbl += anglestoup( vehicle.angles ) * top;
                tbl += anglestoforward( vehicle.angles ) * -1 * back;
                tbl += anglestoright( vehicle.angles ) * -1 * left;
                tbr = vehicle.origin;
                tbr += anglestoup( vehicle.angles ) * top;
                tbr += anglestoforward( vehicle.angles ) * -1 * back;
                tbr += anglestoright( vehicle.angles ) * right;
                bfl = vehicle.origin;
                bfl += anglestoup( vehicle.angles ) * -1 * bottom;
                bfl += anglestoforward( vehicle.angles ) * front;
                bfl += anglestoright( vehicle.angles ) * -1 * left;
                bfr = vehicle.origin;
                bfr += anglestoup( vehicle.angles ) * -1 * bottom;
                bfr += anglestoforward( vehicle.angles ) * front;
                bfr += anglestoright( vehicle.angles ) * right;
                bbl = vehicle.origin;
                bbl += anglestoup( vehicle.angles ) * -1 * bottom;
                bbl += anglestoforward( vehicle.angles ) * -1 * back;
                bbl += anglestoright( vehicle.angles ) * -1 * left;
                bbr = vehicle.origin;
                bbr += anglestoup( vehicle.angles ) * -1 * bottom;
                bbr += anglestoforward( vehicle.angles ) * -1 * back;
                bbr += anglestoright( vehicle.angles ) * right;
                thread debug_utility::drawline( tfl, tfr, level.framedurationseconds, ( 1, 1, 1 ) );
                thread debug_utility::drawline( tfl, tbl, level.framedurationseconds, ( 1, 1, 1 ) );
                thread debug_utility::drawline( tfr, tbr, level.framedurationseconds, ( 1, 1, 1 ) );
                thread debug_utility::drawline( tbr, tbl, level.framedurationseconds, ( 1, 1, 1 ) );
                thread debug_utility::drawline( bfl, bfr, level.framedurationseconds, ( 1, 1, 1 ) );
                thread debug_utility::drawline( bfl, bbl, level.framedurationseconds, ( 1, 1, 1 ) );
                thread debug_utility::drawline( bfr, bbr, level.framedurationseconds, ( 1, 1, 1 ) );
                thread debug_utility::drawline( bbr, bbl, level.framedurationseconds, ( 1, 1, 1 ) );
                thread debug_utility::drawline( tfl, bfl, level.framedurationseconds, ( 1, 1, 1 ) );
                thread debug_utility::drawline( tfr, bfr, level.framedurationseconds, ( 1, 1, 1 ) );
                thread debug_utility::drawline( tbl, bbl, level.framedurationseconds, ( 1, 1, 1 ) );
                thread debug_utility::drawline( tbr, bbr, level.framedurationseconds, ( 1, 1, 1 ) );
                
                if ( isdefined( leveldataforvehicle ) )
                {
                    foreach ( exit in leveldataforvehicle.exitoffsets )
                    {
                        thread debug_utility::drawline( vehicle.origin, vehicle.origin + rotatevector( exit, vehicle.angles ), level.framedurationseconds, ( 0, 1, 1 ) );
                    }
                }
            }
        }
    }

#/
