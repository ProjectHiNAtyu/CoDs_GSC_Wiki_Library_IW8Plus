// scripts\mp\br\gametypes\br_dev.gsc  (hash_173ce52127e2f80d.gscc) (size: 70729 Bytes / 0x11449 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x87504496 (2270184598)
// size ...... 70729 (0x11449)
// includes .. 75  (offset: 0x1049d)
// strings ... 3   (offset: 0x106f5)
// dev strs .. 244 (offset: 0x10725)
// exports ... 145 (offset: 0xaf6d)
// cseg ...... 0x74 + 0xaef9 (0xaf6d)
// imports ... 491 (offset: 0xc615)
// animtree1 . 0   (offset: 0x11449)
// animtree2 . 0   (offset: 0x11449)
#using script_16ea1b94f0f381b3;
#using script_239a365a92ee4476;
#using script_40c84f936810be73;
#using script_70ac8a06d80020b0;
#using scripts\common\callbacks;
#using scripts\common\script;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_tracking;
#using scripts\common\weapon;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\airdrop_loadout_crate;
#using scripts\mp\armor;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_analytics;
#using scripts\mp\br\gametypes\br_armory_kiosk;
#using scripts\mp\br\gametypes\br_c130;
#using scripts\mp\br\gametypes\br_callouts;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_dev_tests;
#using scripts\mp\br\gametypes\br_elite_broken_arrow;
#using scripts\mp\br\gametypes\br_exclusion_zone;
#using scripts\mp\br\gametypes\br_helicopters;
#using scripts\mp\br\gametypes\br_infils_util;
#using scripts\mp\br\gametypes\br_instance_inventory;
#using scripts\mp\br\gametypes\br_keypad_util;
#using scripts\mp\br\gametypes\br_multi_circle;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_rewards;
#using scripts\mp\br\gametypes\br_spawnrespawn;
#using scripts\mp\br\gametypes\br_spectate;
#using scripts\mp\br\gametypes\br_strongholds;
#using scripts\mp\br\gametypes\br_vehicles;
#using scripts\mp\br\gametypes\br_weapons;
#using scripts\mp\carriable;
#using scripts\mp\challenges;
#using scripts\mp\class;
#using scripts\mp\common\killstreaks\airstrike;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\perks\perks;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\pickups_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\dev;
#using scripts\mp\ftue\utility\ftue_progress;
#using scripts\mp\gamelogic;
#using scripts\mp\gamescore;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\largeuppernotification;
#using scripts\mp\laststand;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\menus;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\parachute;
#using scripts\mp\pickups_scriptable;
#using scripts\mp\playerhealth;
#using scripts\mp\supers;
#using scripts\mp\weapons;

#namespace br_dev;

// Namespace br_dev
// Params 0
// Checksum 0x184e514a, Offset: 0x92
// Size: 0x3d
function init()
{
    /#
        registerhandlecommand( &handledevcommand_br );
        level thread function_6d30b592e21540ac();
        level thread function_3986c11ac3d6ebd9();
        thread commandwatcher( @"hash_97cda940cb7bd182", &handlecommand );
    #/
    
    br_dev_tests::init();
}

// Namespace br_dev
// Params 2
// Checksum 0x298dd16e, Offset: 0xd7
// Size: 0xc5
function commandwatcher( dvarname, commandhandlerfunc )
{
    level notify( "commandWatcher_" + getxhashhexname( dvarname ) );
    level endon( "commandWatcher_" + getxhashhexname( dvarname ) );
    setdvar( dvarname, "" );
    
    while ( true )
    {
        waitframe();
        dvarvalue = getdvar( dvarname );
        
        if ( dvarvalue == "" )
        {
            continue;
        }
        
        setdvar( dvarname, "" );
        tokens = strtok( dvarvalue, " " );
        
        if ( !isdefined( tokens ) || tokens.size < 1 )
        {
            continue;
        }
        
        command = tokens[ 0 ];
        arglist = utility::array_slice( tokens, 1 );
        [[ commandhandlerfunc ]]( command, arglist );
    }
}

// Namespace br_dev
// Params 2
// Checksum 0xae7d48da, Offset: 0x1a4
// Size: 0x9b
function handlecommand( command, args )
{
    if ( !isdefined( level.handlecommandfuncs ) )
    {
        return;
    }
    
    foreach ( func in level.handlecommandfuncs )
    {
        [[ func ]]( command, args );
    }
}

// Namespace br_dev
// Params 1
// Checksum 0x18b044b2, Offset: 0x247
// Size: 0x39
function registerhandlecommand( func )
{
    if ( !isdefined( level.handlecommandfuncs ) )
    {
        level.handlecommandfuncs = [];
    }
    
    level.handlecommandfuncs[ level.handlecommandfuncs.size ] = func;
}

/#

    // Namespace br_dev
    // Params 2
    // Checksum 0x8d9daf75, Offset: 0x288
    // Size: 0x9e, Type: dev
    function handledevcommand( command, args )
    {
        if ( !isdefined( level.handledevcommandfuncs ) )
        {
            return;
        }
        
        foreach ( func in level.handledevcommandfuncs )
        {
            [[ func ]]( command, args );
        }
    }

    // Namespace br_dev
    // Params 3
    // Checksum 0xde713844, Offset: 0x32e
    // Size: 0x63, Type: dev
    function function_d21173c62eee72bb( firstplayer, command, args )
    {
        if ( args.size < 1 )
        {
            iprintlnbold( "<dev string:x24>" );
            return;
        }
        
        defname = args[ 0 ];
        
        if ( !isscriptabledefined( defname ) )
        {
            iprintlnbold( "<dev string:x40>" );
            return;
        }
        
        function_cbc83ab6068d4267( firstplayer, defname );
    }

    // Namespace br_dev
    // Params 3
    // Checksum 0xd528cf4a, Offset: 0x399
    // Size: 0x5b, Type: dev
    function function_3634182c82d661a1( firstplayer, command, args )
    {
        if ( args.size < 1 )
        {
            iprintlnbold( "<dev string:x53>" );
        }
        
        victimname = args[ 0 ];
        attackername = args[ 1 ];
        devkillplayer( victimname, attackername );
    }

    // Namespace br_dev
    // Params 3
    // Checksum 0x74dd499a, Offset: 0x3fc
    // Size: 0x6a, Type: dev
    function function_36381e2c82da64aa( firstplayer, command, args )
    {
        if ( args.size < 2 )
        {
            iprintlnbold( "<dev string:x71>" );
        }
        
        damageamt = args[ 0 ];
        victimname = args[ 1 ];
        attackername = args[ 2 ];
        function_1f19b81a419a44fd( victimname, attackername, damageamt );
    }

    // Namespace br_dev
    // Params 3
    // Checksum 0xb832d136, Offset: 0x46e
    // Size: 0x153, Type: dev
    function function_74de6c6813813dc2( firstplayer, command, args )
    {
        if ( args.size > 0 )
        {
            minradius = undefined;
            bdistance2d = undefined;
            maxradius = float( args[ 0 ] );
            
            if ( args.size > 1 )
            {
                minradius = float( args[ 1 ] );
                
                if ( args.size > 2 )
                {
                    bdistance2d = int( args[ 2 ] ) != 0;
                    points = getunusedlootcachepoints( firstplayer.origin, maxradius, minradius, bdistance2d );
                }
                else
                {
                    points = getunusedlootcachepoints( firstplayer.origin, maxradius, minradius );
                }
            }
            else
            {
                points = getunusedlootcachepoints( firstplayer.origin, maxradius );
            }
        }
        else
        {
            points = getunusedlootcachepoints();
        }
        
        foreach ( point in points )
        {
            debugstar( point.origin, ( 1, 0, 1 ), 100 );
        }
    }

    // Namespace br_dev
    // Params 3
    // Checksum 0xcf11eb7a, Offset: 0x5c9
    // Size: 0x17e, Type: dev
    function function_aaea7b37a8cfb067( firstplayer, command, args )
    {
        if ( args.size < 1 )
        {
            iprintlnbold( "<dev string:x98>" );
            return;
        }
        
        pointtype = int( args[ 0 ] );
        origin = undefined;
        maxradius = undefined;
        minradius = undefined;
        bdistance2d = undefined;
        
        if ( args.size > 1 )
        {
            origin = firstplayer.origin;
            maxradius = float( args[ 1 ] );
            
            if ( args.size > 2 )
            {
                minradius = float( args[ 2 ] );
                
                if ( args.size > 3 )
                {
                    bdistance2d = int( args[ 3 ] ) != 0;
                    points = getquestpoints( pointtype, origin, maxradius, minradius, bdistance2d );
                }
                else
                {
                    points = getquestpoints( pointtype, origin, maxradius, minradius );
                }
            }
            else
            {
                points = getquestpoints( pointtype, origin, maxradius );
            }
        }
        else
        {
            points = getquestpoints( pointtype );
        }
        
        foreach ( point in points )
        {
            debugstar( point.origin, ( 0, 1, 1 ), 100 );
        }
    }

    // Namespace br_dev
    // Params 3
    // Checksum 0x46bafe6d, Offset: 0x74f
    // Size: 0x6b6, Type: dev
    function function_11533aec29cc79ab( firstplayer, command, args )
    {
        reviver = undefined;
        revivee = undefined;
        var_3ece178bfc3d1896 = 1;
        itemdata = [ "<dev string:xe4>":[ "<dev string:xd7>":[], "<dev string:xd2>":[] ], "<dev string:xdc>":[ "<dev string:xd7>":[], "<dev string:xd2>":[] ] ];
        
        if ( args.size > 0 )
        {
            foreach ( arg in args )
            {
                lcarg = tolower( arg );
                multival = strtok( lcarg, "<dev string:xec>" );
                
                switch ( multival.size )
                {
                    case 2:
                        player = devgetplayerbyname( multival[ 1 ] );
                        
                        if ( isdefined( player ) )
                        {
                            switch ( multival[ 0 ] )
                            {
                                case #"hash_94a335b456789386":
                                    reviver = player;
                                    break;
                                case #"hash_94a348b45678b16f":
                                    revivee = player;
                                    break;
                            }
                        }
                        
                        break;
                    case 1:
                        var_9f877716d57f2e7d = issubstr( lcarg, "<dev string:xe4>" );
                        var_9f878016d57f4248 = issubstr( lcarg, "<dev string:xdc>" );
                        takeitem = getsubstr( lcarg, 0, 2 ) == "<dev string:xee>";
                        var_c084d2bd7040b7f3 = issubstr( lcarg, "<dev string:xf1>" );
                        var_be1d14cde7ac449b = issubstr( lcarg, "<dev string:xfb>" );
                        playerkey = undefined;
                        
                        if ( var_9f877716d57f2e7d )
                        {
                            playerkey = "<dev string:xe4>";
                        }
                        else if ( var_9f878016d57f4248 )
                        {
                            playerkey = "<dev string:xdc>";
                        }
                        
                        if ( isdefined( playerkey ) )
                        {
                            arrkey = undefined;
                            itemval = undefined;
                            
                            if ( takeitem )
                            {
                                arrkey = "<dev string:xd7>";
                            }
                            else
                            {
                                arrkey = "<dev string:xd2>";
                            }
                            
                            if ( var_c084d2bd7040b7f3 )
                            {
                                itemval = "<dev string:x108>";
                            }
                            else if ( var_be1d14cde7ac449b )
                            {
                                itemval = "<dev string:x125>";
                            }
                            
                            if ( isdefined( itemval ) )
                            {
                                var_6f733d28e33a8e7f = itemdata[ playerkey ][ arrkey ].size;
                                var_a78581b12c97272c = 1;
                                itemdata[ playerkey ][ arrkey ][ var_6f733d28e33a8e7f ] = itemval;
                            }
                        }
                        
                        if ( !var_a78581b12c97272c )
                        {
                            switch ( lcarg )
                            {
                                case #"hash_285e1562bf1a1d13":
                                    useselfrevive = 1;
                                    break;
                                default:
                                    player = devgetplayerbyname( lcarg );
                                    
                                    if ( isdefined( player ) )
                                    {
                                        if ( !isdefined( reviver ) )
                                        {
                                            reviver = player;
                                        }
                                    }
                                    
                                    break;
                            }
                        }
                        
                        break;
                    default:
                        break;
                }
            }
        }
        
        if ( !isdefined( reviver ) )
        {
            reviver = level.players[ 0 ];
        }
        
        attacker = undefined;
        
        foreach ( player in level.players )
        {
            if ( !isdefined( attacker ) && player.team != reviver.team && player::isreallyalive( player ) && !player::isinlaststand( player ) )
            {
                attacker = player;
            }
            
            if ( !isdefined( revivee ) && player != reviver && ( !var_3ece178bfc3d1896 || isbot( player ) ) && player.team == reviver.team && player::isreallyalive( player ) && !player::isinlaststand( player ) )
            {
                revivee = player;
            }
            
            if ( isdefined( revivee ) && isdefined( attacker ) )
            {
                break;
            }
        }
        
        if ( !isdefined( revivee ) )
        {
            return;
        }
        
        itemdata[ "<dev string:xe4>" ][ "<dev string:x149>" ] = revivee;
        itemdata[ "<dev string:xdc>" ][ "<dev string:x149>" ] = reviver;
        
        if ( useselfrevive && !revivee laststand::hasselfrevivetoken() )
        {
            revivee br_pickups::function_19f92529593d1af9( 1, 8548 );
        }
        
        foreach ( playerarr in itemdata )
        {
            foreach ( item in [ "<dev string:x125>", "<dev string:x108>" ] )
            {
                player = playerarr[ "<dev string:x149>" ];
                isperk = issubstr( item, "<dev string:x150>" );
                var_d115f1547e28f0c6 = issubstr( item, "<dev string:x15b>" );
                
                if ( arraycontains( playerarr[ "<dev string:xd2>" ], item ) )
                {
                    if ( isperk )
                    {
                        if ( !isdefined( player.perks[ item ] ) )
                        {
                            player perk::giveperk( item );
                        }
                    }
                    else if ( var_d115f1547e28f0c6 )
                    {
                        player function_7b2b41b2bfc4ac9f( item );
                    }
                }
                
                if ( arraycontains( playerarr[ "<dev string:xd7>" ], item ) )
                {
                    if ( isperk )
                    {
                        if ( isdefined( player.perks[ item ] ) )
                        {
                            player perk::removeperk( item );
                        }
                        
                        continue;
                    }
                    
                    if ( var_d115f1547e28f0c6 )
                    {
                        if ( player.platecarriertype == item )
                        {
                            player function_edce9ed18ff949fa();
                        }
                    }
                }
            }
        }
        
        lookpos = player_utility::getplayerlookatpos( reviver );
        revivee setorigin( lookpos );
        
        if ( player::isreallyalive( revivee ) )
        {
            if ( !player::isinlaststand( revivee ) )
            {
                revivee dodamage( 99999, attacker.origin, attacker, attacker, "<dev string:x169>" );
            }
            else if ( isdefined( revivee.var_8bec82459b31fc31 ) )
            {
                revivee.var_8bec82459b31fc31.curprogress = 0;
            }
        }
        
        if ( isbot( revivee ) && useselfrevive )
        {
            level.var_dce68d4837fb7c51 = 1;
            revivee.var_d58dcecf776f41ff = 1;
        }
        
        thread function_ae755e3fd5f2f41a( revivee );
    }

    // Namespace br_dev
    // Params 3
    // Checksum 0xeffee3bf, Offset: 0xe0d
    // Size: 0x59f, Type: dev
    function function_e031f9da097e5735( firstplayer, command, args )
    {
        if ( args.size > 0 )
        {
            equipref = args[ 0 ];
            lootbundle = getitemscriptbundle( equipref );
            assert( isdefined( lootbundle ), "<dev string:x177>" + equipref + "<dev string:x195>" );
            
            if ( isdefined( level.equipment.table[ lootbundle.ref ] ) )
            {
                itembundle = level.equipment.table[ lootbundle.ref ];
                
                if ( isdefined( itembundle.objweapon ) )
                {
                    weap = itembundle.objweapon;
                }
            }
            else if ( isdefined( level.superglobals.staticsuperdata[ lootbundle.ref ] ) )
            {
                itembundle = level.superglobals.staticsuperdata[ lootbundle.ref ];
                weap = itembundle.objweapon;
            }
            else if ( isdefined( level.streakglobals.streakbundles[ lootbundle.ref ] ) )
            {
                itembundle = level.streakglobals.streakbundles[ lootbundle.ref ];
            }
            
            assert( isdefined( itembundle ), "<dev string:x197>" + equipref + "<dev string:x195>" );
            victim = level.players[ 0 ];
            
            if ( args.size > 1 )
            {
                argplayer = devgetplayerbyname( args[ 1 ] );
                
                if ( isdefined( argplayer ) )
                {
                    victim = argplayer;
                }
            }
            
            attacker = function_22ab0439ba963dc2( victim );
            spawnpos = player_utility::getplayerlookatpos( victim );
            assert( isdefined( attacker ), "<dev string:x1ad>" );
            typeref = getscriptbundle( lootbundle.lootitemtype ).typeref;
            
            switch ( typeref )
            {
                case #"hash_1cac65e1b8bf24a7":
                    if ( isvalidweaponname( itembundle.droneweapon ) )
                    {
                        spawnpos += ( 0, 0, 250 );
                    }
                    
                    if ( !attacker val::get( "<dev string:x1dd>" ) )
                    {
                        foreach ( player in level.players )
                        {
                            if ( player != attacker && player.team != victim.team && player::isreallyalive( player ) && !player::isinlaststand( player ) && !player br_public::isplayerinorgoingtogulag() && player val::get( "<dev string:x1dd>" ) )
                            {
                                attacker = player;
                                break;
                            }
                        }
                    }
                    
                    attacker thread function_270657ff535092c3( itembundle, spawnpos, victim.angles );
                    break;
                case #"hash_e534fd8ec73eafb4":
                    if ( attacker supers_mp::issuperdisabled() )
                    {
                        foreach ( player in level.players )
                        {
                            if ( player != attacker && player.team != victim.team && player::isreallyalive( player ) && !player::isinlaststand( player ) && !player br_public::isplayerinorgoingtogulag() && !player supers_mp::issuperdisabled() )
                            {
                                attacker = player;
                                break;
                            }
                        }
                    }
                    
                    if ( itembundle.ref == "<dev string:x1f0>" )
                    {
                        attacker setorigin( spawnpos );
                        attacker setplayerangles( victim.angles + ( 0, 180, 0 ) );
                        attacker supers_mp::givesuper( itembundle.ref, 1, 1 );
                        attacker thread function_99b649d2e6a21e00( weap, 1 );
                        attacker supers_mp::beginsuperuse();
                    }
                    else if ( isdefined( weap ) && weapon::getweaponname( weap ) != %"super_default_mp" )
                    {
                        grenade = attacker weapon::_launchgrenade( weap, spawnpos + ( 0, 0, 5 ), ( 0, 0, 0 ), undefined, 0, undefined, 0 );
                        attacker weapons::grenadeused( grenade );
                    }
                    else
                    {
                        attacker setorigin( spawnpos );
                        attacker setplayerangles( victim.angles + ( 0, 180, 0 ) );
                        attacker supers_mp::givesuper( itembundle.ref, 1, 1 );
                        result = attacker function_99b649d2e6a21e00( weap );
                        
                        if ( result )
                        {
                            attacker supers_mp::beginsuperuse();
                        }
                    }
                    
                    break;
                default:
                    if ( isdefined( weap ) )
                    {
                        grenade = attacker weapon::_launchgrenade( weap, spawnpos + ( 0, 0, 5 ), ( 0, 0, 0 ), undefined, 0, undefined, 0 );
                        attacker weapons::grenadeused( grenade );
                    }
                    
                    break;
            }
        }
    }

    // Namespace br_dev
    // Params 0
    // Checksum 0x872b08d9, Offset: 0x13b4
    // Size: 0x13b, Type: dev
    function function_c53f0d261be077c9()
    {
        realhuman = undefined;
        
        foreach ( player in level.players )
        {
            if ( !isbot( player ) )
            {
                realhuman = player;
                break;
            }
        }
        
        if ( isdefined( realhuman ) )
        {
            foreach ( player in level.players )
            {
                if ( player != realhuman )
                {
                    botnum = player getentitynumber();
                    kick( botnum );
                }
            }
            
            level thread gamelogic_mp::endgame( realhuman.team, game[ "<dev string:x203>" ][ "<dev string:x20e>" ] );
        }
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0xf70969f6, Offset: 0x14f7
    // Size: 0xc6, Type: dev
    function function_83eeb89253f18e98( args )
    {
        if ( args.size < 3 )
        {
            iprintlnbold( "<dev string:x221>" );
            return;
        }
        
        playeridx = int( args[ 0 ] );
        
        foreach ( candidate in level.players )
        {
            if ( playeridx == candidate getentitynumber() )
            {
                candidate br_public::updatebrscoreboardstat( args[ 1 ], int( args[ 2 ] ) );
                return;
            }
        }
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0x7e18a34c, Offset: 0x15c5
    // Size: 0x36, Type: dev
    function function_dffc8fe39e2f7f0b( args )
    {
        if ( args.size < 1 )
        {
            iprintlnbold( "<dev string:x24c>" );
            return;
        }
        
        pointindex = int( args[ 0 ] );
    }

    // Namespace br_dev
    // Params 2
    // Checksum 0xf4bb079d, Offset: 0x1603
    // Size: 0x72, Type: dev
    function function_4cf94a841bd93dc9( args, firstplayer )
    {
        if ( args.size < 4 )
        {
            iprintlnbold( "<dev string:x264>" );
            return;
        }
        
        testloc = ( float( args[ 0 ] ), float( args[ 1 ] ), float( args[ 2 ] ) );
        yaw = float( args[ 3 ] );
        firstplayer notify( #"confirm_location", testloc, yaw );
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0x936bcff3, Offset: 0x167d
    // Size: 0x40, Type: dev
    function function_f1be88d003589c44( args )
    {
        if ( args.size < 1 )
        {
            iprintlnbold( "<dev string:x293>" );
            return;
        }
        
        circle = int( args[ 0 ] );
        level thread br_multi_circle::function_d7b471bd6367fcdc( circle );
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0x6d20b6e7, Offset: 0x16c5
    // Size: 0x70, Type: dev
    function function_e03a77e39e73ee05( args )
    {
        points = args[ 0 ];
        
        if ( isdefined( points ) )
        {
            points = float( points );
        }
        
        areacount = args[ 1 ];
        
        if ( isdefined( areacount ) )
        {
            areacount = int( areacount );
        }
        
        circleindex = args[ 2 ];
        
        if ( isdefined( circleindex ) )
        {
            circleindex = int( circleindex );
        }
        
        level thread br_circle::function_739ec06b6dd24e18( points, areacount, circleindex );
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0xf0c785f9, Offset: 0x173d
    // Size: 0x175, Type: dev
    function function_e06671e39ea44739( args )
    {
        if ( !level.player )
        {
            return;
        }
        
        if ( isdefined( level.var_d7e15c22445a9799 ) )
        {
            foreach ( index in level.var_d7e15c22445a9799 )
            {
                objidpoolmanager::returnobjectiveid( index );
            }
            
            level.var_d7e15c22445a9799 = undefined;
            return;
        }
        
        foreground = args[ 0 ];
        
        if ( !isdefined( foreground ) )
        {
            foreground = "<dev string:x2b3>";
        }
        
        var_9122cd1ca78d725b = 6;
        level.var_d7e15c22445a9799 = [];
        
        for ( i = 0; i < var_9122cd1ca78d725b ; i++ )
        {
            objectiveiconid = objidpoolmanager::requestobjectiveid( 1 );
            
            if ( objectiveiconid != -1 )
            {
                level.var_d7e15c22445a9799[ level.var_d7e15c22445a9799.size ] = objectiveiconid;
                origin = level.player.origin + ( 1, i - int( var_9122cd1ca78d725b / 2 ), 0 ) * 400;
                objidpoolmanager::objective_add_objective( objectiveiconid, "<dev string:x2d4>", origin, foreground );
                objidpoolmanager::update_objective_setbackground( objectiveiconid, i );
            }
        }
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0x260bdd0f, Offset: 0x18ba
    // Size: 0x3e, Type: dev
    function function_2592b8dc75b55429( args )
    {
        player = level.players[ 0 ];
        player.carryinghostage = !player.carryinghostage;
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0x4a406e83, Offset: 0x1900
    // Size: 0xbc, Type: dev
    function function_ac2e141c150a2d46( args )
    {
        pickup = getitemscriptbundle( args[ 0 ] );
        targetplayer = function_9970128b45efc7ef( args[ 1 ] );
        assert( isdefined( pickup ), "<dev string:x2db>" + args[ 0 ] + "<dev string:x195>" );
        
        if ( args.size > 1 )
        {
            assert( isdefined( targetplayer ), "<dev string:x2f8>" + args[ 1 ] + "<dev string:x313>" );
        }
        else
        {
            assert( isdefined( targetplayer ), "<dev string:x331>" );
        }
        
        spawnoptions = common_item::items_initspawnoptions_spawnfromposition( targetplayer.origin, targetplayer.angles );
        targetplayer common_item::function_61c2c0251e742ffd( pickup, undefined, spawnoptions );
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0xf5225d91, Offset: 0x19c4
    // Size: 0x3a, Type: dev
    function function_6b9d563403537553( args )
    {
        for ( index = 0; index < 20 ; index++ )
        {
            br_pickups::spawndebugpickupfromdevgui( args[ 0 ] );
            wait 0.3;
        }
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0x2cfbb33b, Offset: 0x1a06
    // Size: 0x88, Type: dev
    function function_4523b0688b76dda5( args )
    {
        foreach ( player in level.players )
        {
            player thread br_pickups::quickdropfill();
        }
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0x978a4bcb, Offset: 0x1a96
    // Size: 0x9a, Type: dev
    function function_9821bce5f8b8b373( args )
    {
        itemslotindex = int( args[ 0 ] );
        
        foreach ( player in level.players )
        {
            player thread br_pickups::quickdropitem( itemslotindex );
        }
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0x8453d88, Offset: 0x1b38
    // Size: 0xa0, Type: dev
    function function_85baded16e88218e( args )
    {
        host = gamelogic_mp::gethostplayer();
        
        if ( isdefined( host ) )
        {
            spawnorigin = host.origin + anglestoforward( host.angles ) * 100 + ( 0, 0, 10 );
            
            if ( utility::issharedfuncdefined( #"hash_b6012e9cfec6a673", #"spawncachesinglebase" ) )
            {
                [[ utility::getsharedfunc( #"hash_b6012e9cfec6a673", #"spawncachesinglebase" ) ]]( spawnorigin, host.angles );
            }
        }
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0x202b12ac, Offset: 0x1be0
    // Size: 0xa1, Type: dev
    function function_34d195558c695df1( args )
    {
        host = gamelogic_mp::gethostplayer();
        
        if ( isdefined( host ) )
        {
            if ( utility::issharedfuncdefined( #"hash_8538e247e32e58b9", #"hash_ec93c9158a4baba6" ) )
            {
                spawnorigin = host.origin + anglestoforward( host.angles ) * 100 + ( 0, 0, 10 );
                level thread [[ utility::getsharedfunc( #"hash_8538e247e32e58b9", #"hash_ec93c9158a4baba6" ) ]]( spawnorigin, host.angles );
            }
        }
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0xf22e73cc, Offset: 0x1c89
    // Size: 0xa6, Type: dev
    function function_ed5b46118e4d29fa( args )
    {
        host = gamelogic_mp::gethostplayer();
        
        if ( isdefined( host ) )
        {
            if ( utility::issharedfuncdefined( #"br_bunkers", #"hash_59e6035609a916a4" ) )
            {
                spawnorigin = host.origin + anglestoforward( host.angles ) * 100 + ( 0, 0, 10 );
                level thread [[ utility::getsharedfunc( #"br_bunkers", #"hash_59e6035609a916a4" ) ]]( spawnorigin, host.angles, "<dev string:x348>" );
            }
        }
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0xa707e060, Offset: 0x1d37
    // Size: 0xa1, Type: dev
    function function_96cedc53925f6e61( args )
    {
        host = gamelogic_mp::gethostplayer();
        
        if ( isdefined( host ) )
        {
            if ( utility::issharedfuncdefined( #"hash_8de533d93da8b08", #"hash_9e29a52cef7e79e4" ) )
            {
                spawnorigin = host.origin + anglestoforward( host.angles ) * 100 + ( 0, 0, 10 );
                level thread [[ utility::getsharedfunc( #"hash_8de533d93da8b08", #"hash_9e29a52cef7e79e4" ) ]]( spawnorigin, host.angles );
            }
        }
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0x254db7c8, Offset: 0x1de0
    // Size: 0x89, Type: dev
    function function_cb06ec147744b2f2( args )
    {
        foreach ( player in level.players )
        {
            player thread br_rewards::function_917052e8fdee7ef1();
            return;
        }
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0xf359c182, Offset: 0x1e71
    // Size: 0xb8, Type: dev
    function function_6955d797339e28ea( args )
    {
        foreach ( player in level.players )
        {
            player setorigin( ( 0, 0, 24000 ) );
            player thread parachute::startfreefall( 5, 0, undefined, ( 1, 0, 0 ) * br_c130::getc130speed() );
            return;
        }
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0x9ce1d1ca, Offset: 0x1f31
    // Size: 0x9a, Type: dev
    function function_4831fba5882c41ae( args )
    {
        amount = int( args[ 0 ] );
        
        foreach ( player in level.players )
        {
            player br_plunder::playerplunderpickup( amount );
        }
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0xb3045a87, Offset: 0x1fd3
    // Size: 0x88, Type: dev
    function function_c35b51d5605efcc9( args )
    {
        foreach ( player in level.players )
        {
            player br_plunder::playerthrowsmokesignal();
        }
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0xb0b56543, Offset: 0x2063
    // Size: 0x2c, Type: dev
    function function_bd904cf76f448053( args )
    {
        testcase = int( args[ 0 ] );
        level thread br::debugtestcirclevfx( testcase );
    }

    // Namespace br_dev
    // Params 2
    // Checksum 0x60826ba0, Offset: 0x2097
    // Size: 0x6e, Type: dev
    function function_7db448e4111ce4d2( args, firstplayer )
    {
        if ( args.size < 2 )
        {
            iprintlnbold( "<dev string:x34b>" );
            return;
        }
        
        type = args[ 0 ];
        
        if ( type == "<dev string:x366>" )
        {
            plunderamount = int( max( 0, int( args[ 1 ] ) / 100 ) );
            firstplayer br_plunder::playersetplundercount( plunderamount );
        }
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0x7e34f4ce, Offset: 0x210d
    // Size: 0x17d, Type: dev
    function function_514c1b786bc6405b( args )
    {
        if ( args.size < 1 )
        {
            iprintlnbold( "<dev string:x36e>" );
            return;
        }
        
        functable[ "<dev string:x397>" ] = &devgivemaxammo;
        functable[ "<dev string:x39c>" ] = &function_8a6e7fc3ea36ea1;
        functable[ "<dev string:x366>" ] = &function_e1cb6f80675e6790;
        functable[ "<dev string:x3a2>" ] = &function_f7a2660efda94d88;
        functable[ "<dev string:x3ad>" ] = &function_b9bb639b73455d35;
        functable[ "<dev string:x3b3>" ] = &function_4a6f979835660555;
        functable[ "<dev string:x3b8>" ] = &function_b8af141105d10c6;
        
        if ( args[ 0 ] == "<dev string:x3bc>" )
        {
            args = getarraykeys( functable );
        }
        
        foreach ( type in args )
        {
            foreach ( player in level.players )
            {
                utility::trycall( functable[ type ], player );
            }
        }
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0xfd9d5e97, Offset: 0x2292
    // Size: 0x12f, Type: dev
    function function_2bd961067ff07ae9( args )
    {
        if ( args.size < 1 )
        {
            iprintlnbold( "<dev string:x3c0>" );
            return;
        }
        
        functable[ "<dev string:x3a2>" ] = &function_9eb8d5334c9e53b6;
        
        if ( args[ 0 ] == "<dev string:x3bc>" )
        {
            args = getarraykeys( functable );
        }
        
        foreach ( type in args )
        {
            foreach ( player in level.players )
            {
                utility::trycall( functable[ type ], player );
            }
        }
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0xaf2da501, Offset: 0x23c9
    // Size: 0x1d2, Type: dev
    function function_3622202c82c235dd( args )
    {
        ammount = int( args[ 0 ] );
        
        if ( args.size == 3 )
        {
            team = args[ 1 ];
            index = int( args[ 2 ] );
            level.teamdata[ team ][ "<dev string:x3e9>" ][ index ] br_plunder::playerplunderpickup( ammount );
            return;
        }
        
        if ( args.size == 2 )
        {
            team = args[ 1 ];
            
            foreach ( player in level.teamdata[ team ][ "<dev string:x3e9>" ] )
            {
                player br_plunder::playerplunderpickup( ammount );
            }
            
            return;
        }
        
        foreach ( team, data in level.teamdata )
        {
            foreach ( player in data[ "<dev string:x3e9>" ] )
            {
                player br_plunder::playerplunderpickup( ammount );
            }
        }
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0x6b3e960e, Offset: 0x25a3
    // Size: 0x30, Type: dev
    function function_84c4ae6f6db8c5aa( args )
    {
        host = gamelogic_mp::gethostplayer();
        
        if ( isdefined( host ) )
        {
            host br_armory_kiosk::playerhandlecirclepickitem();
        }
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0x7d8fa643, Offset: 0x25db
    // Size: 0x45, Type: dev
    function function_afb6e5a757d5f266( args )
    {
        if ( args[ 0 ].size > 0 )
        {
            value = int( args[ 0 ] );
            host = gamelogic_mp::gethostplayer();
            host br_public::function_bb22d91d6d217fe1( value );
        }
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0xb350bb4, Offset: 0x2628
    // Size: 0x89, Type: dev
    function function_f7b728aa8ec546e0( args )
    {
        foreach ( player in level.players )
        {
            player thread br_instance_inventory::function_b73ad23f8ea8473f( player );
        }
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0xcbdbc16d, Offset: 0x26b9
    // Size: 0x89, Type: dev
    function function_3526962017391376( args )
    {
        foreach ( player in level.players )
        {
            player br_instance_inventory::function_e041481cd4c56f32( player );
        }
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0xbf8fbaf5, Offset: 0x274a
    // Size: 0x6b, Type: dev
    function function_c3e04bb348c51daf( args )
    {
        host = gamelogic_mp::gethostplayer();
        [ highestteam, highestscore ] = gamescore::gethighestscore();
        gamescore::setteamscore( host.team, highestscore + 1 );
        gamelogic_mp::forceend();
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0x66fcb608, Offset: 0x27bd
    // Size: 0x119, Type: dev
    function function_dc420be463831299( args )
    {
        if ( args.size < 1 )
        {
            iprintlnbold( "<dev string:x3f1>" );
            return;
        }
        
        winteam = args[ 0 ];
        
        if ( !isdefined( level.teamswithplayers ) || !arraycontains( level.teamswithplayers, winteam ) )
        {
            function_9a9e8983a2e4ab8f();
            
            if ( !isdefined( level.teamswithplayers ) || !arraycontains( level.teamswithplayers, winteam ) )
            {
                iprintlnbold( "<dev string:x415>" + winteam );
                return;
            }
        }
        
        if ( level.triggeredwincondition )
        {
            iprintlnbold( "<dev string:x424>" );
            return;
        }
        
        [ highestteam, highestscore ] = gamescore::gethighestscore();
        gamescore::setteamscore( winteam, highestscore + 1 );
        level.triggeredwincondition = 1;
        level.shownonspectatingwinnersplash = 1;
        level thread gamelogic_mp::endgame( winteam, game[ "<dev string:x203>" ][ "<dev string:x444>" ], game[ "<dev string:x203>" ][ "<dev string:x450>" ], 0, 1 );
    }

    // Namespace br_dev
    // Params 2
    // Checksum 0x948e01a2, Offset: 0x28de
    // Size: 0xff, Type: dev
    function function_e9f5260c8e20a94d( args, firstplayer )
    {
        if ( args[ 0 ] == "<dev string:x45d>" )
        {
            var_534dd45248c58e32 = 1;
        }
        else if ( args[ 0 ] == "<dev string:x460>" )
        {
            var_534dd45248c58e32 = 0;
        }
        else
        {
            iprintlnbold( "<dev string:x465>" );
            return;
        }
        
        if ( args.size == 2 )
        {
            player = devgetplayerbyname( args[ 1 ] );
            
            if ( !isdefined( player ) )
            {
                iprintlnbold( "<dev string:x497>" );
                return;
            }
            
            if ( utility::issharedfuncdefined( #"teamassim", #"requestnearbyteamchange" ) )
            {
                [[ utility::getsharedfunc( #"teamassim", #"requestnearbyteamchange" ) ]]( player, var_534dd45248c58e32 );
            }
            
            return;
        }
        
        if ( args.size == 1 )
        {
            if ( utility::issharedfuncdefined( #"teamassim", #"requestnearbyteamchange" ) )
            {
                [[ utility::getsharedfunc( #"teamassim", #"requestnearbyteamchange" ) ]]( firstplayer, var_534dd45248c58e32 );
            }
        }
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0x605dc8a6, Offset: 0x29e5
    // Size: 0x9e, Type: dev
    function function_e532b5b67db29854( args )
    {
        if ( args.size != 2 )
        {
            iprintlnbold( "<dev string:x4c6>" );
            return;
        }
        
        initialplayer = devgetplayerbyname( args[ 0 ] );
        var_59b5ae61b767c98e = devgetplayerbyname( args[ 1 ] );
        
        if ( !( isdefined( initialplayer ) && isdefined( var_59b5ae61b767c98e ) ) )
        {
            iprintlnbold( "<dev string:x4fa>" );
            return;
        }
        
        if ( utility::issharedfuncdefined( #"teamassim", #"assimilateplayer" ) )
        {
            [[ utility::getsharedfunc( #"teamassim", #"assimilateplayer" ) ]]( initialplayer, var_59b5ae61b767c98e, 0 );
        }
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0xaeac764e, Offset: 0x2a8b
    // Size: 0xab, Type: dev
    function function_ecf8ffb67697a1fb( args )
    {
        var_534dd45248c58e32 = 1;
        
        if ( isdefined( args[ 0 ] ) )
        {
            if ( args[ 0 ] == "<dev string:x45d>" )
            {
                var_534dd45248c58e32 = 1;
            }
            else if ( args[ 0 ] == "<dev string:x460>" )
            {
                var_534dd45248c58e32 = 0;
            }
        }
        
        host = gamelogic_mp::gethostplayer();
        assimplayer = host function_d660450ac1c6adde();
        
        if ( !isdefined( assimplayer ) )
        {
            return;
        }
        
        if ( utility::issharedfuncdefined( #"teamassim", #"senddirectassimrequest" ) )
        {
            [[ utility::getsharedfunc( #"teamassim", #"senddirectassimrequest" ) ]]( host, assimplayer, var_534dd45248c58e32, 0 );
        }
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0xaadc9afa, Offset: 0x2b3e
    // Size: 0x45, Type: dev
    function function_56a7f9b18ea1e332( args )
    {
        duration = int( args[ 0 ] ?? 60 );
        suffix = args[ 1 ] ?? "<dev string:x52b>";
        replacevisionset( duration, suffix );
    }

    // Namespace br_dev
    // Params 2
    // Checksum 0xfafe28dc, Offset: 0x2b8b
    // Size: 0xd3, Type: dev
    function function_37419f4d04404631( args, firstplayer )
    {
        if ( args.size < 1 )
        {
            iprintlnbold( "<dev string:x52c>" );
            return;
        }
        
        player = firstplayer;
        
        if ( args.size == 2 )
        {
            player = devgetplayerbyname( args[ 1 ] );
            
            if ( !isdefined( player ) )
            {
                iprintlnbold( "<dev string:x569>" );
                return;
            }
        }
        
        if ( args[ 0 ] == "<dev string:x59a>" )
        {
            player challenges::function_bf3b05129da76942();
            return;
        }
        
        if ( args[ 0 ] == "<dev string:x5a0>" )
        {
            player challenges::function_c3bb7e398db26f49();
            return;
        }
        
        if ( args[ 0 ] == "<dev string:x5a7>" )
        {
            var_400fd5601ee45aca = self.var_82a2163fbb84a684 ?? 0;
            println( "<dev string:x5ad>" + player.name + "<dev string:x5cd>" + var_400fd5601ee45aca );
        }
    }

    // Namespace br_dev
    // Params 2
    // Checksum 0x907c4948, Offset: 0x2c66
    // Size: 0x67, Type: dev
    function function_7a386b80b4b34075( args, firstplayer )
    {
        player = firstplayer;
        
        if ( args.size == 1 )
        {
            playername = args[ 1 ];
            player = devgetplayerbyname( playername );
            
            if ( !isdefined( player ) )
            {
                iprintlnbold( "<dev string:x5d8>" + playername );
                return;
            }
        }
        
        player challenges::function_b4cc5a958ed78618( 0, 0 );
    }

    // Namespace br_dev
    // Params 2
    // Checksum 0xc40a1b3e, Offset: 0x2cd5
    // Size: 0x11e, Type: dev
    function function_2b09ea4c927e76( args, firstplayer )
    {
        if ( args.size < 3 )
        {
            iprintlnbold( "<dev string:x605>" );
            return;
        }
        
        player = firstplayer;
        
        if ( args.size == 4 )
        {
            playername = args[ 3 ];
            player = devgetplayerbyname( playername );
            
            if ( !isdefined( player ) )
            {
                iprintlnbold( "<dev string:x5d8>" + playername );
                return;
            }
        }
        
        command = args[ 0 ];
        
        if ( command != "<dev string:x64e>" && command != "<dev string:x652>" )
        {
            iprintlnbold( "<dev string:x658>" + command );
            return;
        }
        
        var_3f3f2cbe130b4821 = args[ 1 ];
        gameflagname = args[ 2 ];
        
        if ( !challenges::function_313d1143e1ab651f( getxhash( var_3f3f2cbe130b4821 ) ) )
        {
            iprintlnbold( "<dev string:x679>" + var_3f3f2cbe130b4821 );
        }
        
        if ( command == "<dev string:x64e>" )
        {
            player challenges::function_8186522f0474f406( getxhash( var_3f3f2cbe130b4821 ), getxhash( gameflagname ) );
            return;
        }
        
        if ( command == "<dev string:x652>" )
        {
            player challenges::function_79cc4302a65cff47( getxhash( var_3f3f2cbe130b4821 ), getxhash( gameflagname ) );
        }
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0x4232f89, Offset: 0x2dfb
    // Size: 0x457, Type: dev
    function function_61ae5a39938ed425( args )
    {
        if ( !args.size )
        {
            return;
        }
        
        player = level.players[ 0 ];
        var_38ad128b17bfd95 = args[ 0 ];
        var_88308f2b09c5d260 = getdvarint( @"hash_218fd708a40f2f8f", 1 ) > 0;
        
        if ( args.size > 1 )
        {
            for ( i = 1; i < args.size ; i++ )
            {
                arg = args[ i ];
                
                switch ( arg )
                {
                    case #"hash_31100fbc01bd387c":
                    case #"hash_8328fb6e4f43ba45":
                        var_88308f2b09c5d260 = 1;
                        break;
                    case #"hash_311010bc01bd3a0f":
                    case #"hash_a9152f56f0c74738":
                        var_88308f2b09c5d260 = undefined;
                        break;
                    default:
                        argplayer = devgetplayerbyname( arg );
                        
                        if ( isdefined( argplayer ) )
                        {
                            player = argplayer;
                            break;
                        }
                        
                        break;
                }
            }
        }
        
        foreach ( func in [ &common_item::function_cf68ad18114498b2, &common_item::function_90c3e0c1fd55d6b6, &common_item_database::function_ca9ca606e66b5911 ] )
        {
            returnval = [[ func ]]( var_38ad128b17bfd95 );
            
            if ( isdefined( returnval ) )
            {
                if ( isxhashasset( returnval ) )
                {
                    weaponbundle = getscriptbundle( returnval );
                }
                
                if ( isstruct( weaponbundle ) )
                {
                    break;
                }
            }
        }
        
        if ( isdefined( weaponbundle ) )
        {
            spawnoptions = common_item::items_initspawnoptions_spawnfromposition( player.origin );
            
            if ( weaponbundle.var_d45ad5f713c5ee95 && isdefined( weaponbundle.scriptable ) )
            {
                if ( !var_88308f2b09c5d260 )
                {
                    if ( weaponbundle.var_b6f99e0fae8841b6 && weaponbundle.numattachments > 0 )
                    {
                        weaponobj = function_aeb51527e57974b5( weaponbundle.var_b6f99e0fae8841b6, weaponbundle.numattachments );
                    }
                    else
                    {
                        weaponobj = weapon::buildweapon( weaponbundle.baseweapon );
                    }
                }
                else
                {
                    weaponobj = function_1fb839e25a7e4f84( weaponbundle.scriptable );
                }
                
                weaponinfostruct = spawnstruct();
                weaponinfostruct.ammoclipright = isdefined( spawnoptions.overridecount ) ? common_item::function_44eacd480abb5b94( spawnoptions.overridecount ) : weaponclipsize( weaponobj );
                weaponinfostruct.ammoclipleft = isdefined( spawnoptions.overridecount ) ? common_item::function_5c3ce1ec7db94488( spawnoptions.overridecount ) : weaponclipsize( weaponobj );
                
                if ( !item_weapon::function_dc8d4a742844a795( weaponobj ) )
                {
                    weaponinfostruct.ammoclipalt = isdefined( spawnoptions.overridecount ) ? common_item::function_3b2613fcafd07797( spawnoptions.overridecount ) : weaponclipsize( weaponobj getaltweapon() );
                }
                else
                {
                    weaponinfostruct.ammoclipalt = 0;
                }
                
                weaponinfostruct.ammostock = weaponmaxammo( weaponobj );
                weaponinfostruct.rarity = weaponbundle.rarity;
                item = item_weapon::function_53da2af5697709f8( weaponobj, weaponinfostruct, spawnoptions );
                
                if ( isdefined( item ) )
                {
                    item.var_6828becb300b1c44 = spawnstruct();
                    item.var_6828becb300b1c44.itembundlename = item_weapon::function_3da93a43aae4473d( weaponbundle.baseweapon, weaponbundle.rarity, weaponobj.variantid );
                    item.var_6828becb300b1c44.attachments = weaponobj.attachments;
                    item.var_6828becb300b1c44.rarity = weaponbundle.rarity;
                    item.var_6828becb300b1c44.baseweapon = weaponbundle.baseweapon;
                    item.var_6828becb300b1c44.variantid = weaponobj.variantid;
                }
                
                return;
            }
            
            item_weapon::function_b960bc85ea91de14( weaponbundle, spawnoptions );
        }
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0xbab4245, Offset: 0x325a
    // Size: 0x291, Type: dev
    function function_de397f616eb8fa11( args )
    {
        revivee = level.players[ 0 ];
        
        if ( args.size > 0 )
        {
            foreach ( arg in args )
            {
                lcarg = tolower( arg );
                
                if ( lcarg == "<dev string:x6b1>" )
                {
                    var_a0c8ba69dca95741 = 1;
                    continue;
                }
                
                if ( lcarg == "<dev string:x6be>" )
                {
                    var_f209384779b3c431 = 1;
                    continue;
                }
                
                player = devgetplayerbyname( lcarg );
                
                if ( isdefined( player ) )
                {
                    revivee = player;
                }
            }
        }
        
        if ( !isdefined( revivee ) )
        {
            return;
        }
        
        attacker = undefined;
        
        foreach ( player in level.players )
        {
            if ( !isdefined( attacker ) && player.team != revivee.team && player::isreallyalive( player ) && !player::isinlaststand( player ) )
            {
                attacker = player;
                break;
            }
        }
        
        if ( !revivee laststand::hasselfrevivetoken() )
        {
            revivee br_pickups::function_19f92529593d1af9( 1, 8548 );
        }
        
        if ( var_a0c8ba69dca95741 && !isdefined( revivee.perks[ "<dev string:x125>" ] ) )
        {
            revivee perk::giveperk( "<dev string:x125>" );
        }
        
        if ( var_f209384779b3c431 )
        {
            revivee function_7b2b41b2bfc4ac9f( "<dev string:x108>" );
        }
        
        if ( isdefined( attacker ) )
        {
            damagepos = attacker.origin;
        }
        else
        {
            damagepos = revivee.origin;
        }
        
        if ( player::isreallyalive( revivee ) && !player::isinlaststand( revivee ) )
        {
            revivee dodamage( 99999, damagepos, attacker, attacker, "<dev string:x169>" );
        }
        else if ( isdefined( revivee.var_8bec82459b31fc31 ) )
        {
            revivee.var_8bec82459b31fc31.curprogress = 0;
        }
        
        thread function_ae755e3fd5f2f41a( revivee );
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0x5c0fed50, Offset: 0x34f3
    // Size: 0x145, Type: dev
    function function_b0b55b3bad476abb( args )
    {
        player = level.players[ 0 ];
        
        if ( args.size > 0 )
        {
            argplayer = devgetplayerbyname( args[ 0 ] );
            
            if ( isdefined( argplayer ) )
            {
                player = argplayer;
            }
        }
        
        player namespace_5ab67a14d18bea3f::function_9477f4690296f31();
        player br_pickups::function_402de4642e0ec93c( player );
        defaultperks = class::function_c8d9816a5c9f1f97( player );
        
        if ( isdefined( player.perks ) )
        {
            foreach ( perk, count in player.perks )
            {
                if ( isdefined( player.loadoutperks ) && arraycontains( player.loadoutperks, perk ) )
                {
                    player.loadoutperks = arrayremove( player.loadoutperks, perk );
                }
                
                if ( !arraycontains( defaultperks, perk ) )
                {
                    player perks::_unsetperk( perk );
                }
            }
        }
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0xaa093814, Offset: 0x3640
    // Size: 0x1f1, Type: dev
    function function_c0d51795ce8768b8( args )
    {
        if ( !args.size )
        {
            return;
        }
        
        victim = devgetplayerbyname( args[ 0 ] );
        attacker = undefined;
        
        if ( args.size > 1 )
        {
            attacker = devgetplayerbyname( args[ 0 ] );
        }
        else
        {
            foreach ( player in level.players )
            {
                if ( player.team != victim.team && player::isreallyalive( player ) )
                {
                    attacker = player;
                    break;
                }
            }
        }
        
        if ( isdefined( attacker ) && isdefined( victim ) )
        {
            currentperkpack = namespace_5ab67a14d18bea3f::function_1989761c60695d17( attacker );
            
            if ( !isdefined( currentperkpack ) || namespace_5ab67a14d18bea3f::function_e96bd96c3a428bb8( currentperkpack ) )
            {
                perkpackref = getarraykey( level.var_1fb5cc0c2fa6e2d8, randomint( level.var_1fb5cc0c2fa6e2d8.size ) );
                lootref = level.br_pickups.var_5515c706eaccd3[ perkpackref ];
                fakeent = spawnstruct();
                fakeent.scriptablename = lootref;
                attacker namespace_5ab67a14d18bea3f::function_d9e5280cbe50ff06( fakeent, 0, 0, undefined, 0 );
            }
            
            if ( isdefined( victim.perks[ "<dev string:x6cc>" ] ) )
            {
                victim perk::removeperk( "<dev string:x6cc>" );
            }
            
            player.var_70c1f4b75530023f = 0;
            victim.var_989cbec7b65bfb44 = 1;
            victim dodamage( 999999, attacker.origin, attacker, attacker, "<dev string:x169>" );
            victim.var_989cbec7b65bfb44 = undefined;
        }
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0x746895d7, Offset: 0x3839
    // Size: 0xec, Type: dev
    function function_942f5e41861f9a78( args )
    {
        if ( !isdefined( level.brwinnerscircle ) )
        {
            script::demoforcesre( "<dev string:x6e2>" );
            return;
        }
        
        if ( args.size > 0 )
        {
            scenename = args[ 0 ];
        }
        
        player = level.players[ 0 ];
        
        if ( args.size > 1 )
        {
            player = devgetplayerbyname( args[ 1 ] );
        }
        
        var_21a9fa3519bf626d = isdefined( scenename ) && player.var_58edfd73ba4630d9 != scenename;
        
        if ( !player.var_b8e3a58792aa396f || var_21a9fa3519bf626d )
        {
            player thread [[ level.brwinnerscircle.var_f78dd935033102ca ]]( scenename );
            player.var_b8e3a58792aa396f = 1;
            return;
        }
        
        player thread [[ level.brwinnerscircle.deactivate ]]();
        player.var_b8e3a58792aa396f = undefined;
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0xb939d93d, Offset: 0x392d
    // Size: 0xe4, Type: dev
    function handledevcommand_br_winners_circle( args )
    {
        if ( !isdefined( level.brwinnerscircle ) )
        {
            script::demoforcesre( "<dev string:x6e2>" );
            return;
        }
        
        if ( args.size > 0 )
        {
            scenename = args[ 0 ];
        }
        
        player = level.players[ 0 ];
        
        if ( args.size > 1 )
        {
            player = devgetplayerbyname( args[ 1 ] );
        }
        
        if ( !isdefined( level.brwinnerscircle.var_98a0a1962baa11dc ) )
        {
            winner = function_22ab0439ba963dc2( level.players[ 0 ] );
            [[ level.brwinnerscircle.setwinners ]]( winner.team, scenename );
        }
        
        player thread [[ level.brwinnerscircle.activatewinnerscircle ]]();
        player.var_b8e3a58792aa396f = undefined;
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0x4a0b2e9e, Offset: 0x3a19
    // Size: 0x94, Type: dev
    function function_4a71d5e8621ea231( args )
    {
        if ( !isdefined( level.brwinnerscircle ) )
        {
            script::demoforcesre( "<dev string:x6e2>" );
            return;
        }
        
        if ( args.size > 0 )
        {
            scenename = args[ 0 ];
        }
        
        player = function_22ab0439ba963dc2( level.players[ 0 ] );
        
        if ( args.size > 1 )
        {
            player = devgetplayerbyname( args[ 1 ] );
        }
        
        [[ level.brwinnerscircle.setwinners ]]( player.team, scenename );
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0xeea519dd, Offset: 0x3ab5
    // Size: 0x99, Type: dev
    function function_125c5a84accaf84e( args )
    {
        if ( !isdefined( level.brwinnerscircle ) )
        {
            script::demoforcesre( "<dev string:x6e2>" );
            return;
        }
        
        player = level.players[ 0 ];
        
        if ( args.size > 0 )
        {
            scenename = args[ 0 ];
        }
        
        if ( args.size > 1 )
        {
            skinoverride = getxhashasset( args[ 1 ] );
        }
        
        player thread [[ level.brwinnerscircle.var_39b5a2ab65a0aa6c ]]( skinoverride, scenename );
        player.var_b8e3a58792aa396f = 1;
    }

    // Namespace br_dev
    // Params 2
    // Checksum 0xbe05db2a, Offset: 0x3b56
    // Size: 0x2bc, Type: dev
    function function_93beff550d9f743b( args, firstplayer )
    {
        isfriendly = 1;
        
        if ( args.size > 0 )
        {
            isfriendly = int( args[ 0 ] );
        }
        
        airstrikeowner = undefined;
        
        if ( isfriendly )
        {
            teammates = teams::getteamdata( firstplayer.team, "<dev string:x3e9>" );
            
            if ( teammates.size > 1 )
            {
                foreach ( teammate in teammates )
                {
                    if ( teammate != firstplayer )
                    {
                        airstrikeowner = teammate;
                        break;
                    }
                }
            }
        }
        else
        {
            foreach ( teamname, teamdata in level.teamdata )
            {
                if ( teamname == firstplayer.team )
                {
                    continue;
                }
                
                teammembers = teams::getteamdata( teamname, "<dev string:x3e9>" );
                
                if ( teammembers.size > 0 )
                {
                    airstrikeowner = teammembers[ 0 ];
                    break;
                }
            }
        }
        
        if ( !airstrikeowner )
        {
            return;
        }
        
        streakinfo = spawnstruct();
        streakinfo.streakname = "<dev string:x702>";
        streakinfo.debug_state = "<dev string:x716>";
        streakinfo.shots_fired = 0;
        location = firstplayer.origin;
        animname = level.scr_anim[ streakinfo.streakname ][ "<dev string:x720>" ];
        strikeanimlength = getanimlength( animname );
        var_75da1ce20ce2f629 = utility::get_notetrack_time( animname, "<dev string:x730>" );
        var_f2b8f790428b478f = strikeanimlength - 5;
        airstrikeid = airstrike::airstrike_addactivestrike( location, airstrikeowner, var_f2b8f790428b478f );
        airstrikeowner thread airstrike::airstrike_watchkills( streakinfo, var_75da1ce20ce2f629 * 2, airstrikeid );
        airstrikeowner thread airstrike::watchairstrikeowner( airstrikeid );
        airstrikeowner thread airstrike::airstrike_watchgameend( streakinfo, airstrikeid );
        airstrikeowner airstrike::finishairstrikeusage( location, undefined, undefined, streakinfo, animname, airstrikeid );
        level thread airstrike::function_f767ade14cc614ec( airstrikeowner, airstrikeid, var_f2b8f790428b478f );
        hostmigration::waitlongdurationwithpause( strikeanimlength );
        level callback::callback( "<dev string:x737>", { #streakinfo:streakinfo } );
    }

    // Namespace br_dev
    // Params 2
    // Checksum 0xb4440570, Offset: 0x3e1a
    // Size: 0x41, Type: dev
    function function_a2d9e70bc702bee4( args, firstplayer )
    {
        platingtype = 0;
        
        if ( args.size > 0 )
        {
            platingtype = int( args[ 0 ] );
        }
        
        level thread function_996060e811b01e19( firstplayer, platingtype );
    }

    // Namespace br_dev
    // Params 2
    // Checksum 0x44f3de84, Offset: 0x3e63
    // Size: 0xef, Type: dev
    function function_c3ed930b9ef0b624( args, firstplayer )
    {
        if ( !isdefined( level.var_7f7f94535dc7a7b4 ) )
        {
            level.var_7f7f94535dc7a7b4 = 0;
        }
        
        characterkeys = getarraykeys( level.characters );
        
        for ( var_e18e2f3ab91f60f4 = 0; var_e18e2f3ab91f60f4 < characterkeys.size ; var_e18e2f3ab91f60f4++ )
        {
            characterindex = level.var_7f7f94535dc7a7b4 % characterkeys.size;
            character = level.characters[ characterkeys[ characterindex ] ];
            level.var_7f7f94535dc7a7b4++;
            
            if ( isbot( character ) && isalive( character ) && character.sessionstate == "<dev string:x74d>" && character.team == firstplayer.team )
            {
                br_pickups::br_forcegivecustompickupitem( character, "<dev string:x755>", 1 );
                break;
            }
        }
    }

    // Namespace br_dev
    // Params 2
    // Checksum 0x193f1c90, Offset: 0x3f5a
    // Size: 0x41, Type: dev
    function function_637b3d2a0f65875( args, firstplayer )
    {
        ftuetipindex = 31;
        
        if ( args.size > 0 )
        {
            ftuetipindex = int( args[ 0 ] );
        }
        
        firstplayer ftue_progress::function_d00c0941d634466b( ftuetipindex );
    }

    // Namespace br_dev
    // Params 2
    // Checksum 0x3c64b05f, Offset: 0x3fa3
    // Size: 0x71, Type: dev
    function function_3d0bb1028915b179( args, firstplayer )
    {
        if ( args.size > 0 )
        {
            tipname = getxhash( args[ 0 ] );
            firstplayer.var_11133cb0607b498f.completed[ tipname ] = 0;
            firstplayer.var_11133cb0607b498f.var_5e65254ccf9da32c[ tipname ] = 0;
            firstplayer namespace_44e8cefed76aa88e::function_5d5fef02540a4a39( tipname );
        }
    }

    // Namespace br_dev
    // Params 2
    // Checksum 0xe28a01e2, Offset: 0x401c
    // Size: 0xea, Type: dev
    function function_37aeb6327e360437( args, firstplayer )
    {
        if ( !( args.size == 2 || args.size == 3 ) )
        {
            var_2f861415e28dd1 = "<dev string:x76a>";
            iprintlnbold( var_2f861415e28dd1 );
            println( var_2f861415e28dd1 );
            return;
        }
        
        animname = args[ 0 ];
        interrupttype = int( args[ 1 ] );
        delayframes = 1;
        
        if ( isdefined( args[ 2 ] ) )
        {
            delayframes = int( args[ 2 ] );
        }
        
        if ( !( isstring( animname ) && isdefined( interrupttype ) && isdefined( delayframes ) && delayframes >= 0 ) )
        {
            var_ca95a3bcd31085c8 = "<dev string:x7a5>";
            iprintlnbold( var_ca95a3bcd31085c8 );
            println( var_ca95a3bcd31085c8 );
            return;
        }
        
        if ( interrupttype == 0 )
        {
            firstplayer notify( "<dev string:x7ee>" + animname );
            return;
        }
        
        firstplayer thread function_bfc2f4431f4918a2( animname, interrupttype, delayframes );
    }

    // Namespace br_dev
    // Params 2
    // Checksum 0xc3023c93, Offset: 0x410e
    // Size: 0xc8, Type: dev
    function function_39dc7f068b03537d( args, firstplayer )
    {
        if ( !isdefined( level.var_904f7a4736d5940e ) )
        {
            invalidmsg = "<dev string:x803>";
            iprintlnbold( invalidmsg );
            println( invalidmsg );
            return;
        }
        
        if ( args.size != 1 )
        {
            var_2f861415e28dd1 = "<dev string:x828>";
            iprintlnbold( var_2f861415e28dd1 );
            println( var_2f861415e28dd1 );
            return;
        }
        
        scanneridx = int( args[ 0 ] );
        
        if ( !isdefined( scanneridx ) )
        {
            var_ca95a3bcd31085c8 = "<dev string:x856>";
            iprintlnbold( var_ca95a3bcd31085c8 );
            println( var_ca95a3bcd31085c8 );
            return;
        }
        
        if ( scanneridx == 0 )
        {
            firstplayer notify( #"hash_fb35981a4d8a77d3" );
            return;
        }
        
        firstplayer thread function_a94841d21e0ca480( scanneridx - 1 );
    }

    // Namespace br_dev
    // Params 2
    // Checksum 0x174b2b, Offset: 0x41de
    // Size: 0x6d, Type: dev
    function function_79973ffebbec2336( args, firstplayer )
    {
        player = firstplayer;
        score = 1;
        
        if ( args.size > 0 )
        {
            score = int( args[ 0 ] );
        }
        
        if ( args.size > 1 )
        {
            player = devgetplayerbyname( args[ 1 ] );
        }
        
        level gamescore::giveteamscoreforobjective( player.team, score );
    }

    // Namespace br_dev
    // Params 2
    // Checksum 0x4e3f674d, Offset: 0x4253
    // Size: 0x7d, Type: dev
    function function_b1664aefea5510b5( args, firstplayer )
    {
        dropstruct = spawnstruct();
        
        if ( args.size > 0 )
        {
            dropstruct.forceevent = args[ 0 ];
        }
        
        dropstruct.var_87718c86296af9a4 = firstplayer.origin + ( 0, 0, 600 );
        [[ level.var_9fcd99965f9d0687 ]]( firstplayer.origin, dropstruct );
    }

    // Namespace br_dev
    // Params 2
    // Checksum 0x91d25ea2, Offset: 0x42d8
    // Size: 0x20c9, Type: dev
    function handledevcommand_br( command, args )
    {
        firstplayer = level.players[ 0 ];
        
        if ( !isdefined( firstplayer ) )
        {
            return;
        }
        
        switch ( getxhash( command ) )
        {
            case #"hash_b5ff0a9b78b51e72":
                function_d21173c62eee72bb( firstplayer, command, args );
                break;
            case #"hash_8cf4e07b5710301":
                br_vehicles::brvehiclesreset();
                break;
            case #"gr":
                resetglass();
                break;
            case #"kp":
                function_3634182c82d661a1( firstplayer, command, args );
                break;
            case #"hash_8ba4807b55e9cc5":
                function_36381e2c82da64aa( firstplayer, command, args );
                break;
            case #"drop":
                if ( args.size < 1 )
                {
                    iprintlnbold( "<dev string:x89a>" );
                }
                
                playername = args[ 0 ];
                function_a2c6661cdf88e2f1( playername );
                break;
            case #"dropinactivity":
                if ( args.size < 1 )
                {
                    iprintlnbold( "<dev string:x8af>" );
                }
                
                playername = args[ 0 ];
                function_a2c6661cdf88e2f1( playername, 1 );
                break;
            case #"drawnames":
                level thread function_2f082157f2412a77();
                break;
            case #"hash_c5015e71f675b2b9":
                firstplayer thread hud_message::showsplash( "<dev string:x8ce>" );
                break;
            case #"drawspectate":
                level thread function_9a570f56b58dc040();
                break;
            case #"winner":
                if ( args.size < 1 )
                {
                    iprintlnbold( "<dev string:x8d6>" );
                }
                
                winningteam = args[ 0 ];
                function_9a9e8983a2e4ab8f();
                
                if ( isdefined( level.teamswithplayers ) && arraycontains( level.teamswithplayers, winningteam ) )
                {
                    level thread function_e1a93748e6a76bf4( winningteam );
                }
                
                break;
            case #"hash_b82e11fa812ea11":
                function_c53f0d261be077c9();
                break;
            case #"hash_f444bcaa13323191":
                firstplayer br::droponplayerdeath();
                break;
            case #"playmovie":
                setomnvar( "<dev string:x8ef>", 1 );
                wait 5;
                setomnvar( "<dev string:x8ef>", -1 );
                break;
            case #"hash_b8dbe3327b7c60f5":
                firstplayer br_pickups::function_6ac9fd6a59587d24();
                break;
            case #"stat":
                function_83eeb89253f18e98( args );
                break;
            case #"bunker":
                bunkeridx = int( args[ 0 ] );
                firstplayer thread function_99ac9f6026f837f8( bunkeridx );
                break;
            case #"hash_cee9341e3fa354fd":
                function_74de6c6813813dc2( firstplayer, command, args );
                break;
            case #"hash_f5506e9a421b63a6":
                function_aaea7b37a8cfb067( firstplayer, command, args );
                break;
            case #"hash_ca563018f4283d62":
                function_dffc8fe39e2f7f0b( args );
                break;
            case #"hash_ad7b36745835097e":
                function_4cf94a841bd93dc9( args, firstplayer );
                break;
            case #"hash_457e0b7197870487":
                level thread br::brclosealldoors();
                break;
            case #"showcircles":
                level thread br_circle::function_caf9c07d71471a7c();
                break;
            case #"hash_f64c91e375ff2ed2":
                exclusion_zones::function_ba5f14de7783c3f0();
                break;
            case #"hash_463130f7d049b6de":
                exclusion_zones::function_3f2c0d88b393edc0();
                break;
            case #"hash_599f47fdda66d86c":
                exclusion_zones::function_2a52f92f8b6d9e94( 0 );
                break;
            case #"hash_5e65d1e602f57ce":
                exclusion_zones::function_2a52f92f8b6d9e94( 1 );
                break;
            case #"hash_c980280ee505561a":
                exclusion_zones::function_48addf7fcf93d9dd();
                break;
            case #"hash_8623755ac99e5388":
                exclusion_zones::function_8970e7e306cc4233();
                break;
            case #"hash_359d2efdcc194d0b":
                function_f1be88d003589c44( args );
                break;
            case #"hash_42b2fd9946d29c1a":
                level thread br_multi_circle::function_23e719f866c35f1d();
                break;
            case #"hidecircles":
                level thread br_circle::function_d77c846c9723ce93();
                break;
            case #"hash_60058ede9e643419":
                level thread br_circle::function_ec745e14474a5010();
                break;
            case #"hash_9073e93053d668aa":
                level thread br_circle::function_8d0e0ec09bdb1035();
                break;
            case #"showcirclecenters":
                level thread br_multi_circle::function_6a26e18509ebc65b();
                break;
            case #"hidecirclecenters":
                level thread br_multi_circle::function_6b1da0467bcbe34c();
                break;
            case #"hash_a80d820da8de59e4":
                level thread br_multi_circle::function_5c10608b47a4f791();
                break;
            case #"hash_9d7d84c3367a244b":
                level thread br_multi_circle::function_ff4c2b4a2efd2cce();
                break;
            case #"dcd":
                function_e03a77e39e73ee05( args );
                break;
            case #"hash_8dc5507b57b9942":
                br_circle::applycirclesettings();
                level thread br_multi_circle::function_b22f2da5fcf44995();
                level thread br_circle::_precalcsafecirclecenters();
                level thread br_multi_circle::function_b8bba7914486922b();
                break;
            case #"creloc":
                level thread br_circle::relocatecircles( firstplayer.origin );
                break;
            case #"ceo":
                if ( isdefined( level.player ) )
                {
                    br_circle::applycirclesettings();
                    level thread br_multi_circle::function_b22f2da5fcf44995();
                    level thread br_circle::_precalcsafecirclecenters( level.player.origin );
                    level thread br_multi_circle::function_b8bba7914486922b();
                }
                
                break;
            case #"hash_ce5a331f9f88bacd":
                br_circle_util::savecircles();
                break;
            case #"hash_365a8be93b57921c":
                br_circle_util::logtotalmatchtime();
                break;
            case #"hash_225e763cdc93f88d":
                level thread br_circle::function_f8f0a0bdd3398227( 10 );
                break;
            case #"dib":
                function_e06671e39ea44739( args );
                break;
            case #"hash_b721d45a8339b1d4":
                function_2592b8dc75b55429( args );
                break;
            case #"spawn_pickup":
                function_ac2e141c150a2d46( args );
                break;
            case #"hash_ddcf9aca56706877":
                br_pickups::spawndebugpickupfromdevgui( args[ 0 ], 0, args[ 1 ] );
                break;
            case #"hash_ed9aef9fbc11803b":
                br_pickups::spawndebugpickupfromdevgui( args[ 0 ], 1 );
                break;
            case #"spawn_all_pickups":
                br_pickups::function_79e841e11b415079();
                break;
            case #"hash_fd6895c392ca1a08":
                br_pickups::function_79e841e11b415079( 1 );
                break;
            case #"spawn_all_caches":
                br_pickups::function_aa23d7c84f09683f();
                break;
            case #"spawn_pickup_max":
                function_6b9d563403537553( args );
                break;
            case #"fill_quick_drop":
                function_4523b0688b76dda5( args );
                break;
            case #"quick_drop":
                function_9821bce5f8b8b373( args );
                break;
            case #"hash_eb1a77a71288ddff":
                function_85baded16e88218e( args );
                break;
            case #"spawn_drone_puzzle":
                function_34d195558c695df1( args );
                break;
            case #"hash_551273d38c2e439d":
                function_ed5b46118e4d29fa( args );
                break;
            case #"hash_3ff185cd63b9b7fa":
                function_96cedc53925f6e61( args );
                break;
            case #"hash_bb46e85d6554424a":
                if ( utility::issharedfuncdefined( #"elitearrow", #"hash_8b942b2d78109e52" ) )
                {
                    level thread [[ utility::getsharedfunc( #"elitearrow", #"hash_8b942b2d78109e52" ) ]]( 8, int( args[ 0 ] ) );
                }
                
                break;
            case #"hash_680b6ecb11dc9971":
                if ( utility::issharedfuncdefined( #"elitearrow", #"hash_8b942b2d78109e52" ) )
                {
                    level thread [[ utility::getsharedfunc( #"elitearrow", #"hash_8b942b2d78109e52" ) ]]( int( args[ 0 ] ) );
                }
                
                break;
            case #"hash_592e7e839aa6a054":
                if ( utility::issharedfuncdefined( #"elitearrow", #"hash_23e5e55f2d0f123" ) )
                {
                    level thread [[ utility::getsharedfunc( #"elitearrow", #"hash_23e5e55f2d0f123" ) ]]();
                }
                
                break;
            case #"force_eject":
                br_helicopters::forceejectall();
                break;
            case #"dropbagspawn":
                function_cb06ec147744b2f2( args );
                break;
            case #"dropbagcompute":
                level thread br_rewards::precomputedropbagpositions( 0 );
                break;
            case #"test_parachute":
                function_6955d797339e28ea( args );
                break;
            case #"give_plunder":
                function_4831fba5882c41ae( args );
                break;
            case #"hash_9d82e73e9fd303a8":
                function_c35b51d5605efcc9( args );
                break;
            case #"vfx_test":
                function_bd904cf76f448053( args );
                break;
            case #"hash_89bfe74b8d6fbd4a":
                level thread br_analytics::branalytics_endgame();
                break;
            case #"dca":
                level thread br_callouts::function_ba35b32b217357da();
                break;
            case #"hash_6b59beee9b4058":
                thread br_c130::function_f30ca7005ed4e05b();
                break;
            case #"hash_a96f546f0a0776bf":
                thread br_c130::function_ef24f22c617da156();
                break;
            case #"hash_a65a02fb1c4a0363":
                thread br_c130::function_e5ae8db74e375db2( args[ 0 ] );
                break;
            case #"set":
                function_7db448e4111ce4d2( args, firstplayer );
                break;
            case #"give":
                function_514c1b786bc6405b( args );
                break;
            case #"take":
                function_2bd961067ff07ae9( args );
                break;
            case #"GP":
                function_3622202c82c235dd( args );
                break;
            case #"testoob":
                thread br_c130::function_3817a624426a8b3();
                break;
            case #"drawoob":
                level thread draw_oob();
                break;
            case #"hash_90aa6378625575e6":
                level thread function_7fc0f81a33509018();
                break;
            case #"drawbounds":
                level thread draw_bounds();
                break;
            case #"invalidplayers":
                thread function_5fdbc2bd1ee88c59();
                break;
            case #"tbb":
                level thread function_862b9e36fce52294();
                break;
            case #"bc":
                level thread br_circle::function_3aab6f3bb1f831f7( args, "<dev string:x8fb>" );
                break;
            case #"bct":
                level thread function_f2d64b4f8362cdbb( args );
                break;
            case #"bsc":
                level thread br_circle::function_3aab6f3bb1f831f7( args, "<dev string:x906>" );
                break;
            case #"test_br_spawnrespawn":
                level thread function_f442fb6736ecf92b();
                break;
            case #"spawn_carriable":
                carriable::function_fea736cef62e8226( args[ 0 ] );
                break;
            case #"hash_9a360ad544af4d04":
                carriable::function_8390d3c9f27b19bf();
                break;
            case #"spawn_rcxd":
                level thread function_19e33a09ddd3ba4e();
                break;
            case #"hash_32affab3ba773ab9":
                level thread function_4eaee485c9149e4e();
                break;
            case #"show_carriables":
                level thread carriable::function_a9b5e8237eaa4b1c( args[ 0 ] );
                break;
            case #"kiosk_circle":
                function_84c4ae6f6db8c5aa( args );
                break;
            case #"holes":
                thread function_5bbf4b986080e3a0( args );
                break;
            case #"hash_be8dee148c38f081":
                if ( isdefined( level.var_376ea269d7b40d05 ) )
                {
                    level thread [[ level.var_376ea269d7b40d05 ]]( args[ 0 ] );
                }
                
                break;
            case #"hash_66fb6c67a00c7369":
                function_afb6e5a757d5f266( args );
                break;
            case #"hash_8d3a0ac8dbdc76dd":
                function_f7b728aa8ec546e0( args );
                break;
            case #"print_instance_inventory":
                function_3526962017391376( args );
                break;
            case #"hash_2939fe3c8a5ea5f0":
                namespace_e18d4996cbcfc831::activate();
                break;
            case #"hash_20e7d8f0ac70b353":
                namespace_e18d4996cbcfc831::activate_enemy();
                break;
            case #"hash_42ff1a5c8b293957":
                level thread function_2b58eeefe053f5f7( args );
                break;
            case #"hash_77e25b214344d914":
                if ( args.size == 1 )
                {
                    function_a8c37646d2124dae( firstplayer, args[ 0 ] );
                }
                
                break;
            case #"give_contract":
                if ( args.size == 2 )
                {
                    player = devgetplayerbyname( args[ 1 ] );
                    
                    if ( !isdefined( player ) )
                    {
                        iprintlnbold( "<dev string:x918>" );
                        break;
                    }
                    
                    br_contract_manager::function_e1384ed619bd6d5c( player, args[ 0 ] );
                }
                else if ( args.size == 1 )
                {
                    br_contract_manager::function_e1384ed619bd6d5c( firstplayer, args[ 0 ] );
                }
                
                break;
            case #"hash_28f73a27711fb4a6":
                function_c3e04bb348c51daf( args );
                break;
            case #"force_plunder_win":
                function_dc420be463831299( args );
                break;
            case #"hash_6089c4abf2218c08":
                function_e9f5260c8e20a94d( args, firstplayer );
                break;
            case #"hash_3efb3e39bd3a87f9":
                function_e532b5b67db29854( args );
                break;
            case #"hash_5f09f9407e63177e":
                function_ecf8ffb67697a1fb( args );
                break;
            case #"force_laststand":
                var_7988dd5cc9984163 = level.player;
                
                if ( args.size >= 1 )
                {
                    var_7988dd5cc9984163 = function_f3102eeb8dba9864( tolower( args[ 0 ] ) );
                }
                
                if ( isdefined( var_7988dd5cc9984163 ) )
                {
                    var_7988dd5cc9984163 dodamage( var_7988dd5cc9984163.health, var_7988dd5cc9984163.origin, var_7988dd5cc9984163 );
                }
                
                break;
            case #"resurgence":
            case #"br_casual_zombie":
            case #"gulag":
            case #"zxl":
            case #"zxp":
            case #"spdr":
            case #"gunroyale":
            case #"loaded":
            case #"plea":
            case #"zcl":
            case #"hash_8d54007b57556e5":
            case #"hash_8d92c07b5791dc0":
            case #"jsc":
                if ( utility::issharedfuncdefined( command, #"hash_92c69cebc395b9e7" ) )
                {
                    level thread [[ utility::getsharedfunc( command, #"hash_92c69cebc395b9e7" ) ]]( args );
                }
                
                break;
            case #"visionset":
                function_56a7f9b18ea1e332( args );
                break;
            case #"showsplash":
                showsplash( args[ 0 ], args[ 1 ] );
                break;
            case #"hash_9463d9ab9d5db9c4":
                function_37419f4d04404631( args, firstplayer );
                break;
            case #"hash_bb6281b5620794":
                function_7a386b80b4b34075( args, firstplayer );
                break;
            case #"hash_c652b18a966b2a5":
                function_2b09ea4c927e76( args, firstplayer );
                break;
            case #"hash_18c7580c013f704d":
                if ( !isdefined( level.arrow ) )
                {
                    return;
                }
                
                level.arrow.dvars.skiptoken = 1;
                host = gamelogic_mp::gethostplayer();
                tablet = br_elite_broken_arrow::function_5aa74efce0ddb257( host.origin, ( 0, 0, 0 ) );
                level.arrow.props.tablets[ level.arrow.props.tablets.size ] = tablet;
                
                if ( utility::issharedfuncdefined( #"elitechain", #"hash_9581852f94eedd8c" ) )
                {
                    level thread [[ utility::getsharedfunc( #"elitechain", #"hash_9581852f94eedd8c" ) ]]( tablet );
                }
                
                br_elite_broken_arrow::function_5ced56aa00d4886e();
                break;
            case #"spawnquestcircle":
                if ( args.size < 1 )
                {
                    iprintlnbold( "<dev string:x943>" );
                    break;
                }
                
                circleid = args[ 0 ];
                
                if ( isdefined( args[ 1 ] ) )
                {
                    size = int( args[ 1 ] );
                }
                else
                {
                    size = 6000;
                }
                
                testquestcircle = spawnstruct();
                testquestcircle game_utility::questcircle_create( circleid, level.players[ 0 ].origin, size );
                testquestcircle game_utility::questcircle_showtoall();
                break;
            case #"hash_9280ffca3aecebb1":
                if ( isdefined( level.var_cef046b41cf46986 ) && isdefined( level.var_cef046b41cf46986.debug_spawn ) )
                {
                    [[ level.var_cef046b41cf46986.debug_spawn ]]();
                }
                else
                {
                    iprintlnbold( "<dev string:x977>" );
                }
                
                break;
            case #"hash_e7be8fce990b403f":
                firstplayer br::givestandardtableloadout( 0, 1 );
                break;
            case #"backup_pistol":
                if ( isdefined( firstplayer.classstruct ) && isdefined( firstplayer.classstruct.var_183fb1979f9b8498 ) && !firstplayer hasweapon( firstplayer.classstruct.var_183fb1979f9b8498 ) )
                {
                    firstplayer class::function_9e101b7b7b333117( firstplayer.classstruct );
                }
                
                break;
            case #"hash_ce9d9f904459bca3":
                if ( args.size == 3 )
                {
                    pos = ( float( args[ 0 ] ), float( args[ 1 ] ), float( args[ 2 ] ) );
                }
                else
                {
                    pos = firstplayer.origin + anglestoforward( firstplayer.angles ) * 100;
                }
                
                airdrop_loadout_crate::spawnloadoutcrate( firstplayer, pos, 1 );
                break;
            case #"hash_81b3ead4c82e5088":
                firstplayer setorigin( br_public::droptogroundmultitrace( firstplayer.origin ) );
                firstplayer setvelocity( ( 0, 0, 0 ) );
                break;
            case #"hash_84fe25fa33e4ec85":
                utility::callsharedfunc( #"gametype", #"hash_84fe25fa33e4ec85", args[ 0 ], int( args[ 1 ] ) );
                break;
            case #"persistent_item":
                if ( args.size < 2 )
                {
                    iprintlnbold( "<dev string:x9b4>" );
                    break;
                }
                
                player = firstplayer;
                
                if ( args.size == 3 )
                {
                    player = devgetplayerbyname( args[ 2 ] );
                    
                    if ( !isdefined( player ) )
                    {
                        iprintlnbold( "<dev string:x9f1>" );
                        break;
                    }
                }
                
                if ( args[ 0 ] == "<dev string:xd2>" )
                {
                    player utility::callsharedfunc( #"loot", #"hash_533a821691e2894a", args[ 1 ] );
                }
                
                if ( args[ 0 ] == "<dev string:xd7>" )
                {
                    player utility::callsharedfunc( #"loot", #"hash_c185c6807d510ac7", args[ 1 ] );
                }
                
                break;
            case #"hash_e1e9fc3b80b662":
                lootid = undefined;
                platelevel = args.size > 1 && isdefined( args[ 1 ] ) ? args[ 1 ] : "<dev string:xa1f>";
                
                if ( !( isdefined( args ) && isdefined( args[ 0 ] ) ) || args[ 0 ] == "<dev string:x52b>" )
                {
                    lootid = loot::function_d3e3bcaea591a6a2( "<dev string:xa21>" + platelevel );
                }
                else if ( issubstr( args[ 0 ], "<dev string:xa37>" ) )
                {
                    lootid = loot::function_d3e3bcaea591a6a2( "<dev string:xa21>" + platelevel + "<dev string:xa3d>" );
                }
                else if ( issubstr( args[ 0 ], "<dev string:xa44>" ) )
                {
                    lootid = loot::function_d3e3bcaea591a6a2( "<dev string:xa21>" + platelevel + "<dev string:xa4a>" );
                }
                else if ( issubstr( args[ 0 ], "<dev string:xa51>" ) )
                {
                    lootid = loot::function_d3e3bcaea591a6a2( "<dev string:xa21>" + platelevel + "<dev string:xa59>" );
                }
                else if ( issubstr( args[ 0 ], "<dev string:xa62>" ) )
                {
                    lootid = loot::function_d3e3bcaea591a6a2( "<dev string:xa6b>" );
                }
                else if ( issubstr( args[ 0 ], "<dev string:xa89>" ) )
                {
                    lootid = loot::function_d3e3bcaea591a6a2( "<dev string:xa97>" );
                }
                
                if ( !isdefined( lootid ) )
                {
                    break;
                }
                
                foreach ( player in level.players )
                {
                    if ( !isbot( player ) )
                    {
                        continue;
                    }
                    
                    player.avoidkillstreakonspawntimer = undefined;
                    player br_pickups::lootitem( lootid, 1 );
                    player armor::setarmorhealth( player.maxarmorhealth );
                }
                
                break;
            case #"hash_bb5d23f4bd03cdd9":
                lootid = undefined;
                
                if ( issubstr( args[ 0 ], "<dev string:xaba>" ) )
                {
                    lootid = loot::function_d3e3bcaea591a6a2( "<dev string:xabf>" );
                }
                else if ( issubstr( args[ 0 ], "<dev string:xad4>" ) )
                {
                    lootid = loot::function_d3e3bcaea591a6a2( "<dev string:xadb>" );
                }
                else if ( issubstr( args[ 0 ], "<dev string:xaf2>" ) )
                {
                    lootid = loot::function_d3e3bcaea591a6a2( "<dev string:xaf8>" );
                }
                else if ( issubstr( args[ 0 ], "<dev string:xb0e>" ) )
                {
                    lootid = loot::function_d3e3bcaea591a6a2( "<dev string:xb15>" );
                }
                
                if ( !isdefined( lootid ) )
                {
                    break;
                }
                
                foreach ( player in level.players )
                {
                    if ( !isbot( player ) )
                    {
                        continue;
                    }
                    
                    player br_pickups::lootitem( lootid, 1 );
                }
                
                break;
            case #"force_spectate":
                foreach ( player in level.players )
                {
                    if ( isbot( player ) )
                    {
                        continue;
                    }
                    
                    player menus::handleteamchange( "<dev string:xb2c>", 3 );
                    break;
                }
                
                break;
            case #"hash_9a5e2d3639717068":
                function_9b0ca3a8cdb23fe4();
                break;
            case #"set_part_state":
                part = args[ 0 ];
                state = args[ 1 ];
                ent = function_6fba8bd6a17e904e( level.player );
                
                if ( isdefined( ent ) )
                {
                    result = ent utility::function_7c10ea82c1e305b8( part, state );
                    
                    if ( result )
                    {
                        color = ( 0, 1, 0 );
                        text = "<dev string:xb32>";
                    }
                    else
                    {
                        color = ( 1, 0, 0 );
                        text = "<dev string:xb3a>";
                    }
                    
                    iprintlnbold( text );
                    drawentitybounds( ent, color, 1, 20 );
                }
                else
                {
                    iprintlnbold( "<dev string:xb41>" );
                }
                
                break;
            case #"nv_on":
                level.players[ 0 ] nightvisionviewon();
                break;
            case #"nv_off":
                level.players[ 0 ] nightvisionviewoff();
                break;
            case #"blacksite_teleport":
                if ( !isdefined( level.var_9a4bff7f44a3e42a ) )
                {
                    break;
                }
                
                blacksite = undefined;
                
                if ( isdefined( firstplayer.blacksites ) && firstplayer.blacksites.size > 0 )
                {
                    blacksite = firstplayer.blacksite[ 0 ];
                }
                else if ( isdefined( level.fortressstruct.blacksites ) )
                {
                    blacksiteindex = randomint( level.fortressstruct.blacksites.size );
                    blacksite = level.fortressstruct.blacksites[ blacksiteindex ];
                }
                
                firstplayer [[ level.var_9a4bff7f44a3e42a ]]( blacksite );
                break;
            case #"hash_fb1bcec8b5f9b47":
                if ( !isdefined( level.var_c1b39306196e76aa ) )
                {
                    break;
                }
                
                blacksite = undefined;
                
                if ( isdefined( firstplayer.blacksites ) && firstplayer.blacksites.size > 0 )
                {
                    blacksite = firstplayer.blacksite[ 0 ];
                }
                else if ( isdefined( level.fortressstruct.blacksites ) )
                {
                    blacksiteindex = randomint( level.fortressstruct.blacksites.size );
                    blacksite = level.fortressstruct.blacksites[ blacksiteindex ];
                }
                
                firstplayer [[ level.var_c1b39306196e76aa ]]( blacksite );
                break;
            case #"mutation_test":
                realplayer = dev_mp::function_4838699531f3a587();
                
                if ( level.players.size <= 1 )
                {
                    setdvar( @"dev_spawnbots", 5 );
                    wait 5;
                }
                
                players = level.players;
                players = arrayremove( players, realplayer );
                var_b45cf2cd5c021f70 = 250;
                var_b8947bde7c1333a6 = 3;
                forwardoffset = anglestoforward( realplayer.angles ) * var_b45cf2cd5c021f70;
                rightoffset = anglestoright( realplayer.angles ) * var_b45cf2cd5c021f70;
                startspawnoffset = forwardoffset + ( 0, 0, 75 );
                
                for ( i = 0; i < players.size ; i++ )
                {
                    player = players[ i ];
                    
                    if ( !isalive( player ) )
                    {
                        continue;
                    }
                    
                    currspawnoffset = startspawnoffset;
                    currspawnoffset += rightoffset * ceil( i % var_b8947bde7c1333a6 / 2 ) * ( i % 2 ? 1 : -1 );
                    currspawnoffset += forwardoffset * floor( i / var_b8947bde7c1333a6 );
                    player setorigin( realplayer.origin + currspawnoffset );
                }
                
                wait 5;
                
                if ( utility::issharedfuncdefined( #"hash_f01e50862fbac503", #"hash_84b1db951b6dd324" ) )
                {
                    [[ utility::getsharedfunc( #"hash_f01e50862fbac503", #"hash_84b1db951b6dd324" ) ]]( players, args );
                }
                
                break;
            case #"cinematictest":
                var_3a2e6ef0dea2917f = args[ 0 ];
                omnvarvalue = undefined;
                
                if ( args.size > 1 )
                {
                    omnvarvalue = int( args[ 1 ] );
                }
                
                if ( !isdefined( omnvarvalue ) )
                {
                    omnvarvalue = 1;
                }
                
                firstplayer preloadcinematicforplayer( var_3a2e6ef0dea2917f );
                firstplayer playcinematicforplayer( var_3a2e6ef0dea2917f );
                firstplayer setclientomnvar( "<dev string:xb57>", omnvarvalue );
                wait 5;
                firstplayer setclientomnvar( "<dev string:xb57>", 0 );
                firstplayer stopcinematicforplayer();
                break;
            case #"hash_735358fa16fa73d1":
                player = firstplayer;
                dropstruct = pickups::function_f71dd588dc4f6288();
                player br_strongholds::function_e0fc600c4a7ef0ec( dropstruct, player::getteamarray( player.team, 0 ), player.team );
                blacksite = level.fortressstruct.var_30cc7babcbb0ca1a[ 0 ];
                blacksite notify( #"hash_5a37e7d305f6448a" );
                waitframe();
                boss = blacksite.bossagents[ 0 ];
                [ firstguard ] = function_3b71aa1bfab81002( "<dev string:xb70>" );
                agent_utility::killagent( firstguard );
                wait 1;
                aitype = namespace_9d8e359c3b1041e5::get_aitype_by_subclass_sharedfunc( "<dev string:xb7f>" )[ 0 ];
                namespace_9d8e359c3b1041e5::spawnnewaitype_sharedfunc( aitype, boss.origin, ( 0, 0, 0 ), boss.team );
                break;
            case #"hash_6773c874d7e79647":
                attacker = function_9970128b45efc7ef( args[ 0 ] );
                victim = args.size > 1 ? devgetplayerbyname( args[ 1 ] ) : undefined;
                
                if ( !victim )
                {
                    attackerorigin = attacker getorigin();
                    var_9c947ad4e8ef99f2 = undefined;
                    var_af9539b8c1dc70d6 = undefined;
                    
                    foreach ( player in level.players )
                    {
                        if ( player.team != attacker.team && player::isreallyalive( player ) )
                        {
                            var_5728332341f6c155 = distance( attackerorigin, player getorigin() );
                            
                            if ( !var_9c947ad4e8ef99f2 || var_5728332341f6c155 < var_af9539b8c1dc70d6 )
                            {
                                var_9c947ad4e8ef99f2 = player;
                                var_af9539b8c1dc70d6 = var_5728332341f6c155;
                            }
                        }
                    }
                    
                    victim = var_9c947ad4e8ef99f2;
                }
                
                if ( isdefined( attacker ) && isdefined( victim ) && isdefined( level.var_342a06ce4c8ccba1 ) )
                {
                    if ( !isdefined( attacker.perks[ "<dev string:xb8f>" ] ) )
                    {
                        attacker perk::giveperk( "<dev string:xb8f>" );
                    }
                    
                    victim thread [[ level.var_342a06ce4c8ccba1 ]]( attacker );
                }
                
                break;
            case #"hash_d60bebeaed508539":
                if ( args.size > 0 )
                {
                    perk = args[ 0 ];
                    player = level.players[ 0 ];
                    
                    if ( args.size > 1 )
                    {
                        player = devgetplayerbyname( args[ 1 ] );
                    }
                    
                    if ( isdefined( player ) && isdefined( perk ) )
                    {
                        player perk::giveperk( perk );
                    }
                }
                
                break;
            case #"spawn_loot_weapon":
                function_61ae5a39938ed425( args );
                break;
            case #"revive_test":
                function_11533aec29cc79ab( firstplayer, command, args );
                break;
            case #"self_revive_test":
                function_de397f616eb8fa11( args );
                break;
            case #"hash_4bfb981b5532af4e":
                function_b0b55b3bad476abb( args );
                break;
            case #"hash_aeaf84afd5f4e9cc":
                thread function_7f78009d80898e97();
                break;
            case #"hash_1403d205653419bf":
                function_c0d51795ce8768b8( args );
                break;
            case #"hash_d7270184b37b966a":
                iprintlnbold( "<dev string:xba3>" );
                break;
            case #"spawn_enemy_equipment":
                function_e031f9da097e5735( firstplayer, command, args );
                break;
            case #"team_circle":
                function_942f5e41861f9a78( args );
                break;
            case #"winners_circle":
                handledevcommand_br_winners_circle( args );
                break;
            case #"hash_d96037e88055054e":
                function_4a71d5e8621ea231( args );
                break;
            case #"hash_1233316d51dcc091":
                function_125c5a84accaf84e( args );
                break;
            case #"hash_772efa8e3a81d632":
                function_93beff550d9f743b( args, firstplayer );
                break;
            case #"hash_933c1e7fd31941f5":
                function_a2d9e70bc702bee4( args, firstplayer );
                break;
            case #"take_armor":
                firstplayer armor::setarmorhealth( 0, 1 );
                break;
            case #"hash_8bec82cd001f9819":
                function_c3ed930b9ef0b624( args, firstplayer );
                break;
            case #"hash_b5f98ff3a7f458b2":
                function_637b3d2a0f65875( args, firstplayer );
                break;
            case #"ftue_tip_test":
                function_3d0bb1028915b179( args, firstplayer );
                break;
            case #"interrupt_anim":
                function_37aeb6327e360437( args, firstplayer );
                break;
            case #"biometric_scanner_auto_use":
                function_39dc7f068b03537d( args, firstplayer );
                break;
            case #"hash_4e4552457a00368b":
                level notify( #"hash_ed72cd70352b01f0" );
                break;
            case #"give_score":
                function_79973ffebbec2336( args, firstplayer );
                break;
            case #"hash_97e7bbb0b431b440":
                function_b1664aefea5510b5( args, firstplayer );
                break;
            case #"give_temp_health":
                if ( args.size < 0 || args.size > 1 )
                {
                    iprintlnbold( "<dev string:xbcf>" );
                    return;
                }
                
                player = firstplayer function_db9292667443ade4() ?? firstplayer;
                
                if ( !isdefined( player ) )
                {
                    return;
                }
                
                temphealth = int( args[ 0 ] ?? 50 );
                playerhealth::function_ed81022bf9702b0a( player, temphealth );
                break;
            case #"hash_512adda57b31af5f":
                level notify( #"hash_512adda57b31af5f" );
                
                if ( args.size != 1 )
                {
                    iprintlnbold( "<dev string:xbf4>" );
                    return;
                }
                
                lootsubstring = args[ 0 ];
                loot = getlootscriptablearray();
                foundloot = [];
                
                foreach ( item in loot )
                {
                    if ( issubstr( item.type, lootsubstring ) )
                    {
                        foundloot[ foundloot.size ] = item;
                    }
                }
                
                thread function_da1f299823807b82( foundloot );
                break;
            case #"showteam":
                level thread function_a79e1b420b0853b9( args, firstplayer );
                break;
            case #"cradle_missile":
                function_a6ba308986cc9b36( args, firstplayer );
                break;
            default:
                break;
            case #"hash_5fe875204e011420":
                if ( utility::issharedfuncdefined( #"mutant_injection_br", #"hash_78f06b4988f69987" ) )
                {
                    firstplayer thread utility::callsharedfunc( #"mutant_injection_br", #"hash_78f06b4988f69987", firstplayer, args );
                }
                
                break;
        }
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0x5728b1f6, Offset: 0x63a9
    // Size: 0xf2, Type: dev
    function function_da1f299823807b82( lootitems )
    {
        self notify( #"hash_91a8c59dc8b89ec5" );
        self endon( #"hash_91a8c59dc8b89ec5" );
        level endon( #"hash_512adda57b31af5f" );
        
        if ( lootitems.size == 0 )
        {
            return;
        }
        
        while ( true )
        {
            foreach ( item in lootitems )
            {
                start = item.origin;
                end = start + ( 0, 0, 200 );
                line( start, end, ( 0, 1, 0 ) );
            }
            
            waitframe();
        }
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0xf01c93f0, Offset: 0x64a3
    // Size: 0xbf, Type: dev
    function function_9970128b45efc7ef( playername )
    {
        if ( isdefined( playername ) )
        {
            var_7237854e3be197ca = devgetplayerbyname( playername );
            
            if ( isdefined( var_7237854e3be197ca ) )
            {
                return var_7237854e3be197ca;
            }
        }
        
        foreach ( player in level.players )
        {
            if ( isdefined( player ) && !isbot( player ) && !player isplayerheadless() )
            {
                return player;
            }
        }
    }

    // Namespace br_dev
    // Params 2
    // Checksum 0x73d74995, Offset: 0x656a
    // Size: 0xb8, Type: dev
    function function_99b649d2e6a21e00( weaponobj, var_a0b14bd0de8298cb )
    {
        level endon( #"game_ended" );
        self endon( #"death_or_disconnect" );
        self notify( #"hash_1a0c8cc901734aef" );
        self endon( #"hash_1a0c8cc901734aef" );
        
        if ( isdefined( weaponobj ) )
        {
            if ( weapon::getweaponname( weaponobj ) == %"super_default_mp" )
            {
                return 1;
            }
            
            if ( !var_a0b14bd0de8298cb )
            {
                childthread function_5ea54bab870843e9( weaponobj );
                childthread function_e8d5b18488c4a1e3( weaponobj );
            }
            else
            {
                childthread function_9b08c75cfa2a0392( weaponobj );
                childthread function_b212ced7186840b4();
            }
            
            childthread function_e38e3b0ed0755bfc( 3 );
            self waittill( #"hash_b67bded55886af8", result );
            return result;
        }
        
        return 0;
    }

    // Namespace br_dev
    // Params 0, eflags: 0x4
    // Checksum 0x7521ce51, Offset: 0x662a
    // Size: 0x30, Type: dev
    function private function_b212ced7186840b4()
    {
        self endon( #"hash_b67bded55886af8" );
        utility::waittill_multiple( "<dev string:xc1a>", "<dev string:xc30>" );
        self notify( #"hash_b67bded55886af8", 1 );
    }

    // Namespace br_dev
    // Params 1, eflags: 0x4
    // Checksum 0xccbb0362, Offset: 0x6662
    // Size: 0x8d, Type: dev
    function private function_9b08c75cfa2a0392( weaponobj )
    {
        self endon( #"hash_b67bded55886af8" );
        
        if ( self.offhandweapon != weaponobj )
        {
            if ( self hasweapon( weaponobj ) )
            {
                self takeweapon( weaponobj );
            }
            
            self giveweapon( weaponobj );
        }
        
        while ( true )
        {
            if ( self.offhandweapon == weaponobj )
            {
                self [[ level.var_c6a23d27f33a948c ]]( weaponobj );
            }
            else
            {
                if ( self hasweapon( weaponobj ) )
                {
                    self takeweapon( weaponobj );
                }
                
                self giveweapon( weaponobj );
            }
            
            wait 0.5;
        }
    }

    // Namespace br_dev
    // Params 1, eflags: 0x4
    // Checksum 0x7506f197, Offset: 0x66f7
    // Size: 0x37, Type: dev
    function private function_5ea54bab870843e9( weaponobj )
    {
        self endon( #"hash_b67bded55886af8" );
        
        while ( true )
        {
            self notify( #"offhand_fired", weaponobj );
            wait 0.001;
        }
    }

    // Namespace br_dev
    // Params 1, eflags: 0x4
    // Checksum 0xa0f6943, Offset: 0x6736
    // Size: 0x2f, Type: dev
    function private function_e38e3b0ed0755bfc( seconds )
    {
        self endon( #"hash_b67bded55886af8" );
        wait seconds;
        self notify( #"hash_b67bded55886af8", "<dev string:xc43>" );
    }

    // Namespace br_dev
    // Params 1, eflags: 0x4
    // Checksum 0xcc57624e, Offset: 0x676d
    // Size: 0x3f, Type: dev
    function private function_e8d5b18488c4a1e3( weaponobj )
    {
        self endon( #"hash_b67bded55886af8" );
        result = supers_mp::function_d629c90761cd2a1c( weaponobj, 1 );
        self notify( #"hash_b67bded55886af8", result );
    }

    // Namespace br_dev
    // Params 3
    // Checksum 0x9297fe1d, Offset: 0x67b4
    // Size: 0x6e, Type: dev
    function function_612fc9491fb031c( ref, location, angles )
    {
        if ( isdefined( level.streakglobals.streakbundles[ ref ] ) )
        {
            itembundle = level.streakglobals.streakbundles[ ref ];
            
            if ( isdefined( itembundle ) )
            {
                return function_270657ff535092c3( itembundle, location, angles );
            }
        }
    }

    // Namespace br_dev
    // Params 3
    // Checksum 0xeb155e41, Offset: 0x682a
    // Size: 0xeb, Type: dev
    function function_270657ff535092c3( bundle, location, angles )
    {
        self notify( #"hash_db943684403c1921" );
        level endon( #"game_ended" );
        self endon( #"death_or_disconnect" );
        currentweapon = weapon::getweaponname( self.currentweapon );
        
        if ( iskillstreakweapon( currentweapon ) )
        {
            clearweapon( currentweapon );
        }
        
        streakinfo = killstreak_utility::createstreakinfo( bundle.killstreakref, self );
        killstreaks::awardkillstreak( bundle.killstreakref, "<dev string:xc4b>", undefined, undefined, undefined, 1 );
        killstreaks::setselectedkillstreak( 1 );
        result = deploykillstreak( bundle, location, angles, streakinfo );
        
        if ( br_pickups::haskillstreak( bundle.killstreakref ) )
        {
            killstreaks::removekillstreak( 1 );
        }
        
        return result;
    }

    // Namespace br_dev
    // Params 4
    // Checksum 0x7866529b, Offset: 0x691d
    // Size: 0x1cb, Type: dev
    function deploykillstreak( bundle, location, angles, streakinfo )
    {
        level endon( #"game_ended" );
        self endon( #"death_or_disconnect" );
        self endon( #"hash_db943684403c1921" );
        self notify( #"cancel_all_killstreak_deployments" );
        streakinfo.skipequippedstreakcheck = 1;
        streakinfo.targetoverride = location;
        streakinfo.targetanglesoverride = angles;
        streakinfo.bundle = bundle;
        
        if ( bundle.var_aa88a7c836c913d4 )
        {
            streakinfo.var_16f8d415b9d7937 = 0;
        }
        
        success = 0;
        ref = bundle.killstreakref;
        setupdata = level.killstreaksetups[ ref ];
        streakitem = killstreaks::createstreakitemstruct( bundle.killstreakref );
        streakitem.uniqueid = streakinfo.id;
        self.triggeringstreak = streakitem;
        self.kstargetlocation = location;
        result = function_dfb77d70b286eec9( streakinfo, bundle, setupdata.triggeredfunc );
        
        switch ( result )
        {
            case 0:
            case #"hash_9f42f01172413811":
            default:
                break;
            case 1:
            case #"hash_d0b13fcbe5e1d71a":
                success = 1;
                break;
        }
        
        if ( success && isdefined( setupdata.cleanupfunc ) )
        {
            [[ setupdata.cleanupfunc ]]();
        }
        
        self.triggeringstreak = undefined;
        return success;
    }

    // Namespace br_dev
    // Params 3
    // Checksum 0xf1d446cb, Offset: 0x6af0
    // Size: 0x97, Type: dev
    function function_dfb77d70b286eec9( streakinfo, bundle, triggerfunc )
    {
        level endon( #"game_ended" );
        self endon( #"death_or_disconnect" );
        playernotifies = [ "<dev string:xc8b>", "<dev string:xc73>", "<dev string:xc51>" ];
        childthread function_998428a6df55402f( streakinfo );
        childthread watchfortriggerreturn( triggerfunc, streakinfo );
        childthread function_650b32267e033120( playernotifies );
        self waittill( #"hash_59b3faf9fff573d5", result );
        return result;
    }

    // Namespace br_dev
    // Params 1, eflags: 0x4
    // Checksum 0x6f37950a, Offset: 0x6b8f
    // Size: 0x3d, Type: dev
    function private function_650b32267e033120( notifyarr )
    {
        self endon( #"hash_59b3faf9fff573d5" );
        notifyresult = utility::waittill_any_in_array_return( notifyarr );
        self notify( #"hash_59b3faf9fff573d5", notifyresult );
    }

    // Namespace br_dev
    // Params 1, eflags: 0x4
    // Checksum 0x4ed4778f, Offset: 0x6bd4
    // Size: 0x85, Type: dev
    function private function_998428a6df55402f( streakinfo )
    {
        self endon( #"hash_59b3faf9fff573d5" );
        weaponname = function_2d8dadf2d42f7404( streakinfo.bundle );
        
        if ( !isdefined( weaponname ) )
        {
            return;
        }
        
        weaponobj = makeweapon( weaponname );
        notifydata = function_98e535396c8f9bfd( streakinfo );
        
        if ( isdefined( notifydata ) )
        {
            while ( true )
            {
                callnotify( notifydata );
                wait notifydata.loopinterval;
            }
        }
    }

    // Namespace br_dev
    // Params 1, eflags: 0x4
    // Checksum 0x5ff2a953, Offset: 0x6c61
    // Size: 0x2aa, Type: dev
    function private callnotify( notifydata )
    {
        paramcount = 0;
        
        if ( isdefined( notifydata.params ) )
        {
            foreach ( index, item in notifydata.params )
            {
                count = index + 1;
                
                if ( count > paramcount )
                {
                    paramcount = count;
                }
            }
        }
        
        switch ( paramcount )
        {
            case 0:
                self notify( notifydata.msg );
                break;
            case 1:
                self notify( notifydata.msg, notifydata.params[ 0 ] );
                break;
            case 2:
                self notify( notifydata.msg, notifydata.params[ 0 ], notifydata.params[ 1 ] );
                break;
            case 3:
                self notify( notifydata.msg, notifydata.params[ 0 ], notifydata.params[ 1 ], notifydata.params[ 2 ] );
                break;
            case 4:
                self notify( notifydata.msg, notifydata.params[ 0 ], notifydata.params[ 1 ], notifydata.params[ 2 ], notifydata.params[ 3 ] );
                break;
            case 5:
                self notify( notifydata.msg, notifydata.params[ 0 ], notifydata.params[ 1 ], notifydata.params[ 2 ], notifydata.params[ 3 ], notifydata.params[ 4 ] );
                break;
            case 6:
                self notify( notifydata.msg, notifydata.params[ 0 ], notifydata.params[ 1 ], notifydata.params[ 2 ], notifydata.params[ 3 ], notifydata.params[ 4 ], notifydata.params[ 5 ] );
                break;
        }
    }

    // Namespace br_dev
    // Params 2, eflags: 0x4
    // Checksum 0xa0345c2c, Offset: 0x6f13
    // Size: 0x43, Type: dev
    function private watchfortriggerreturn( triggerfunc, streakinfo )
    {
        self endon( #"hash_59b3faf9fff573d5" );
        result = [[ triggerfunc ]]( streakinfo );
        self notify( #"hash_59b3faf9fff573d5", result );
    }

    // Namespace br_dev
    // Params 1, eflags: 0x4
    // Checksum 0x9379df51, Offset: 0x6f5e
    // Size: 0x12e, Type: dev
    function private function_2d8dadf2d42f7404( bundle )
    {
        if ( isvalidweaponname( bundle.var_74199c73017aa0db ) )
        {
            return bundle.var_74199c73017aa0db;
        }
        
        if ( isvalidweaponname( bundle.deployweapon ) )
        {
            return bundle.deployweapon;
        }
        
        if ( isvalidweaponname( bundle.deployweaponname ) )
        {
            return bundle.deployweaponname;
        }
        
        if ( isdefined( level.helperdronesettings[ bundle.killstreakref ] ) )
        {
            return level.helperdronesettings[ bundle.killstreakref ].deployweaponname;
        }
        
        if ( isdefined( level.airstrikesettings[ bundle.killstreakref ] ) )
        {
            return level.airstrikesettings[ bundle.killstreakref ].deployweaponobj.basename;
        }
        
        if ( bundle.streaktype == "<dev string:xc9c>" )
        {
            return "<dev string:xca4>";
        }
        
        if ( bundle.killstreakref == "<dev string:xcba>" )
        {
            return "<dev string:xcc5>";
        }
    }

    // Namespace br_dev
    // Params 1, eflags: 0x4
    // Checksum 0xa15a2c42, Offset: 0x7094
    // Size: 0x1e, Type: dev
    function private isvalidweaponname( value )
    {
        return value && value != "<dev string:xcda>";
    }

    // Namespace br_dev
    // Params 1, eflags: 0x4
    // Checksum 0x726ad9f6, Offset: 0x70ba
    // Size: 0x1e5, Type: dev
    function private function_98e535396c8f9bfd( streakinfo )
    {
        bundle = streakinfo.bundle;
        deployweapon = function_2d8dadf2d42f7404( bundle );
        deployweaponobj = makeweapon( deployweapon );
        
        if ( bundle.var_aa88a7c836c913d4 )
        {
            return { #params:[ deployweaponobj ], #loopinterval:0.001, #msg:"<dev string:xcdf>" };
        }
        
        switch ( deployweaponobj.type )
        {
            case #"hash_f43c177a8f2e82d9":
                return { #params:[ deployweaponobj ], #loopinterval:0.5, #msg:"<dev string:xcf4>" };
            case #"hash_9310b70fcf246a18":
                location = streakinfo.targetoverride;
                angles = streakinfo.targetanglesoverride;
                
                if ( !isdefined( location ) )
                {
                    location = anglestoforward( self.angles ) * 10;
                }
                
                if ( !isdefined( angles ) )
                {
                    angles = self.angles;
                }
                
                return { #params:[ undefined, deployweapon, location, angles ], #loopinterval:0.5, #msg:"<dev string:xd0d>" };
            case #"hash_e224d0b635d0dadd":
                grenade = weapon::_launchgrenade( deployweaponobj, streakinfo.targetoverride + ( 0, 0, 5 ), streakinfo.targetanglesoverride, undefined, 0 );
                return { #params:[ grenade, deployweaponobj ], #loopinterval:0.5, #msg:"<dev string:xd2c>" };
        }
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0xb98a9d3a, Offset: 0x72a7
    // Size: 0x14c, Type: dev
    function clearweapon( weapon )
    {
        switchweapon = undefined;
        
        if ( isdefined( self.primaryweapons ) )
        {
            weaponname = weapon;
            
            if ( isweapon( weapon ) )
            {
                weaponname = weapon::getweaponname( weapon );
            }
            
            var_a9af2764c020f52e = 0;
            
            foreach ( pweapon in self.primaryweapons )
            {
                if ( pweapon.basename != "<dev string:xcda>" && pweapon.basename != weaponname )
                {
                    var_a9af2764c020f52e = 1;
                    switchweapon = pweapon;
                    break;
                }
            }
            
            if ( !var_a9af2764c020f52e )
            {
                if ( isdefined( level.defaultfist ) )
                {
                    self giveweapon( level.defaultfist, undefined, undefined, undefined, 1 );
                    switchweapon = level.defaultfist;
                }
            }
        }
        
        self switchtoweaponimmediate( switchweapon );
        
        if ( inventory_utility::isswitchingtoweaponwithmonitoring( weapon ) )
        {
            inventory_utility::abortmonitoredweaponswitch( weapon );
            return;
        }
        
        inventory_utility::_takeweapon( weapon );
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0x5199174a, Offset: 0x73fb
    // Size: 0xf4, Type: dev
    function iskillstreakweapon( weapon )
    {
        weaponname = weapon;
        
        if ( isweapon( weapon ) )
        {
            weaponname = weapon::getweaponname( weapon );
        }
        
        if ( isdefined( level.streakglobals ) && isdefined( level.streakglobals.streakbundles ) )
        {
            foreach ( bundle in level.streakglobals.streakbundles )
            {
                if ( bundle.deployweaponname == weaponname || bundle.deployweapon == weaponname )
                {
                    return 1;
                }
            }
        }
        
        return 0;
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0xb4caf3f1, Offset: 0x74f7
    // Size: 0x88, Type: dev
    function givesuper( superref )
    {
        if ( !isdefined( superref ) || !isdefined( level.br_pickups.var_5515c706eaccd3[ superref ] ) )
        {
            return;
        }
        
        var_2a1146b60455d8b4 = level.br_pickups.var_5515c706eaccd3[ superref ];
        fakeent = spawnstruct();
        fakeent.scriptablename = var_2a1146b60455d8b4;
        fakeent.count = 1;
        br_pickups::takesuperpickup( fakeent );
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0x37880594, Offset: 0x7587
    // Size: 0x135, Type: dev
    function getitemscriptbundle( refname )
    {
        namechecks = [ refname, "<dev string:xd39>" + refname, "<dev string:xd40>" + refname ];
        
        foreach ( func in [ &common_item_database::function_a4f0a21951180013, &common_item_database::function_ca9ca606e66b5911 ] )
        {
            foreach ( namecheck in namechecks )
            {
                bundlename = [[ func ]]( namecheck );
                
                if ( isdefined( bundlename ) )
                {
                    return getscriptbundle( bundlename );
                }
            }
        }
    }

    // Namespace br_dev
    // Params 2
    // Checksum 0x1aeaac18, Offset: 0x76c4
    // Size: 0x10a, Type: dev
    function function_22ab0439ba963dc2( targetplayer, botsonly )
    {
        if ( !isdefined( botsonly ) )
        {
            botsonly = 0;
        }
        
        if ( !isdefined( targetplayer ) )
        {
            return;
        }
        
        if ( isstring( targetplayer ) )
        {
            targetplayer = devgetplayerbyname( targetplayer );
        }
        
        if ( !isplayer( targetplayer ) )
        {
            return;
        }
        
        foreach ( player in level.players )
        {
            if ( player.team != targetplayer.team && player::isreallyalive( player ) && !player::isinlaststand( player ) && !player br_public::isplayeringulag() && ( isbot( player ) || !botsonly ) )
            {
                return player;
            }
        }
    }

    // Namespace br_dev
    // Params 2
    // Checksum 0xc388bb51, Offset: 0x77d6
    // Size: 0x72, Type: dev
    function function_7b2b41b2bfc4ac9f( var_86695971b38f1b37, maxwaittimems )
    {
        br_pickups::function_402de4642e0ec93c( self, var_86695971b38f1b37 );
        waittime = 0;
        maxwaittime = 1000;
        
        if ( isdefined( maxwaittimems ) )
        {
            maxwaittime = maxwaittimems;
        }
        
        while ( self.platecarriertype != var_86695971b38f1b37 )
        {
            if ( waittime >= maxwaittime )
            {
                return;
            }
            
            waitframe();
            waittime += level.frameduration;
        }
        
        return 1;
    }

    // Namespace br_dev
    // Params 0
    // Checksum 0xd4c2132b, Offset: 0x7850
    // Size: 0x35, Type: dev
    function function_edce9ed18ff949fa()
    {
        var_476da819766fbb9b = level.platecarrierstartlevel;
        platescriptable = br_public::function_3a7d2e84c32519a9( var_476da819766fbb9b );
        function_7b2b41b2bfc4ac9f( platescriptable );
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0xe2622f5, Offset: 0x788d
    // Size: 0x152, Type: dev
    function function_ae755e3fd5f2f41a( revivee )
    {
        level endon( #"game_ended" );
        revivee endon( #"disconnect" );
        revivee notify( #"hash_c25154260119cdd0" );
        revivee.revivetimems = 0;
        revivee.var_c0a405b060f930c9 = 1;
        notifycalled = revivee utility::waittill_any_return( "<dev string:xd47>", "<dev string:xd5a>", "<dev string:xd6e>", "<dev string:xd74>" );
        
        if ( ( notifycalled == "<dev string:xd47>" || notifycalled == "<dev string:xd5a>" ) && isalive( revivee ) && isdefined( revivee.revivetimems ) && revivee.revivetimems > 0 )
        {
            targetms = 3000;
            framecount = int( targetms / level.frameduration + 0.5 );
            revivetimestr = "<dev string:xd8c>" + revivee.revivetimems + "<dev string:xd9d>";
            printtoscreen2d( 800, 300, revivetimestr, ( 1, 1, 1 ), 2, framecount );
        }
        
        if ( notifycalled != "<dev string:xd74>" )
        {
            revivee.var_c0a405b060f930c9 = undefined;
            revivee.revivetimems = undefined;
            revivee.var_d58dcecf776f41ff = undefined;
        }
    }

    // Namespace br_dev
    // Params 2
    // Checksum 0x55df113d, Offset: 0x79e7
    // Size: 0x109, Type: dev
    function function_cbc83ab6068d4267( player, defname )
    {
        playerorigin = player.origin;
        playerangles = player getplayerangles();
        playerforward = anglestoforward( playerangles );
        tracestart = ( playerorigin[ 0 ], playerorigin[ 1 ], playerorigin[ 2 ] + player getplayerviewheight() );
        traceend = tracestart + playerforward * 5000;
        tracecontents = trace::create_default_contents( 1 );
        trace = trace::ray_trace( tracestart, traceend, player, tracecontents );
        spawnorigin = tracestart + playerforward * 100;
        
        if ( trace[ "<dev string:xda1>" ] < 1 )
        {
            spawnorigin = trace[ "<dev string:xdaa>" ];
        }
        
        spawnorigin += ( 0, 0, 5 );
        scriptable = spawnscriptable( defname, spawnorigin, ( 0, 0, 0 ) );
        pickups::registerscriptableinstance( scriptable );
        return scriptable;
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0xf76ac620, Offset: 0x7af8
    // Size: 0x1d, Type: dev
    function function_bb6b1b28c82cf8ac( playername )
    {
        return strtok( playername, "<dev string:xdb3>" )[ 0 ];
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0xd6773cc5, Offset: 0x7b1d
    // Size: 0xaa, Type: dev
    function function_f3102eeb8dba9864( name )
    {
        foreach ( player in level.players )
        {
            shortname = function_bb6b1b28c82cf8ac( player.name );
            
            if ( tolower( shortname ) == name )
            {
                return player;
            }
        }
        
        return;
    }

    // Namespace br_dev
    // Params 2
    // Checksum 0xe76df8b, Offset: 0x7bcf
    // Size: 0x1b1, Type: dev
    function devkillplayer( victimname, attackername )
    {
        attacker = undefined;
        victimname = tolower( victimname );
        victim = function_f3102eeb8dba9864( victimname );
        
        if ( isdefined( attackername ) )
        {
            attackername = tolower( attackername );
            
            foreach ( player in level.players )
            {
                shortname = function_bb6b1b28c82cf8ac( player.name );
                
                if ( tolower( shortname ) == attackername )
                {
                    attacker = player;
                    break;
                }
            }
        }
        else
        {
            foreach ( player in level.players )
            {
                if ( victim.team != player.team )
                {
                    attacker = player;
                    break;
                }
            }
        }
        
        if ( isdefined( victim ) )
        {
            victim.var_989cbec7b65bfb44 = 1;
            victim dodamage( 999999, victim.origin, attacker, attacker, "<dev string:x169>" );
            victim.var_989cbec7b65bfb44 = undefined;
        }
    }

    // Namespace br_dev
    // Params 3
    // Checksum 0xa05dbc43, Offset: 0x7d88
    // Size: 0x23a, Type: dev
    function function_1f19b81a419a44fd( victimname, attackername, damage )
    {
        victim = undefined;
        attacker = undefined;
        victimname = tolower( victimname );
        attackerweapon = undefined;
        
        foreach ( player in level.players )
        {
            shortname = function_bb6b1b28c82cf8ac( player.name );
            
            if ( tolower( shortname ) == victimname )
            {
                victim = player;
                break;
            }
        }
        
        if ( isdefined( attackername ) )
        {
            attackername = tolower( attackername );
            
            foreach ( player in level.players )
            {
                shortname = function_bb6b1b28c82cf8ac( player.name );
                
                if ( tolower( shortname ) == attackername )
                {
                    attacker = player;
                    attackerweapon = attacker.primaryweapon;
                    break;
                }
            }
        }
        else
        {
            foreach ( player in level.players )
            {
                if ( victim.team != player.team )
                {
                    attacker = player;
                    break;
                }
            }
        }
        
        if ( isdefined( victim ) )
        {
            victim dodamage( float( damage ), victim.origin, attacker, attacker );
        }
    }

    // Namespace br_dev
    // Params 2
    // Checksum 0xb907e7df, Offset: 0x7fca
    // Size: 0xeb, Type: dev
    function function_a2c6661cdf88e2f1( playername, var_c24c0791c77046e )
    {
        playername = tolower( playername );
        
        foreach ( player in level.players )
        {
            shortname = function_bb6b1b28c82cf8ac( player.name );
            
            if ( tolower( shortname ) == playername )
            {
                clientnum = player getentitynumber();
                
                if ( var_c24c0791c77046e )
                {
                    kick( clientnum, &"EXE/PLAYERKICKED_INACTIVE", 1 );
                }
                else
                {
                    kick( clientnum );
                }
                
                break;
            }
        }
    }

    // Namespace br_dev
    // Params 0
    // Checksum 0x6c6bf69e, Offset: 0x80bd
    // Size: 0x88, Type: dev
    function function_db9292667443ade4()
    {
        start = self geteye();
        dir = anglestoforward( self getplayerangles() );
        end = start + 8000 * dir;
        trace = trace::_bullet_trace( start, end, 1, self );
        player = undefined;
        
        if ( isplayer( trace[ "<dev string:xdb5>" ] ) && player::isreallyalive( trace[ "<dev string:xdb5>" ] ) )
        {
            player = trace[ "<dev string:xdb5>" ];
        }
        
        return player;
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0xbe3fbf96, Offset: 0x814d
    // Size: 0xe2, Type: dev
    function function_cc1152acaa01f332( player )
    {
        angles = player getplayerangles();
        fwd = anglestoforward( angles );
        eye = player geteye();
        end = eye + fwd * 10000;
        traces = trace::ray_trace_get_all_results( eye, end );
        
        foreach ( trace in traces )
        {
            if ( !isdefined( trace[ "<dev string:xdb5>" ] ) )
            {
                return trace[ "<dev string:xdaa>" ];
            }
        }
        
        return;
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0xe3cf0093, Offset: 0x8237
    // Size: 0xe1, Type: dev
    function function_6fba8bd6a17e904e( player )
    {
        angles = player getplayerangles();
        fwd = anglestoforward( angles );
        eye = player geteye();
        end = eye + fwd * 10000;
        traces = trace::ray_trace_get_all_results( eye, end );
        
        foreach ( trace in traces )
        {
            if ( isdefined( trace[ "<dev string:xdb5>" ] ) )
            {
                return trace[ "<dev string:xdb5>" ];
            }
        }
        
        return;
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0x9e102207, Offset: 0x8320
    // Size: 0x15b, Type: dev
    function function_e1a93748e6a76bf4( winningteam )
    {
        setdvar( @"scr_gulag_shutdown", 2 );
        wait 2;
        
        foreach ( team in level.teamswithplayers )
        {
            if ( team != winningteam )
            {
                teamplayers = teams::getteamdata( team, "<dev string:x3e9>" );
                
                foreach ( player in teamplayers )
                {
                    if ( isalive( player ) )
                    {
                        player.var_989cbec7b65bfb44 = 1;
                        player dodamage( 999999, player.origin, player, player, "<dev string:x169>" );
                        player.var_989cbec7b65bfb44 = undefined;
                        wait 1;
                    }
                }
            }
        }
    }

    // Namespace br_dev
    // Params 0
    // Checksum 0xd053cee1, Offset: 0x8483
    // Size: 0xbc, Type: dev
    function function_9a9e8983a2e4ab8f()
    {
        foreach ( team in level.teamnamelist )
        {
            teamcount = teams::getteamdata( team, "<dev string:xdbc>" );
            
            if ( teamcount && !arraycontains( level.teamswithplayers, team ) )
            {
                level.teamswithplayers[ level.teamswithplayers.size ] = team;
            }
        }
    }

    // Namespace br_dev
    // Params 0
    // Checksum 0x1a698dd6, Offset: 0x8547
    // Size: 0x192, Type: dev
    function function_9a570f56b58dc040()
    {
        level endon( #"game_ended" );
        
        if ( level.var_d41e9d29c3e748dd )
        {
            return;
        }
        
        level.var_d41e9d29c3e748dd = 1;
        hudtext = function_817c24c6721f2313( "<dev string:xdc6>", 0.8 );
        hudtext hud_util::setpoint( "<dev string:xdce>", "<dev string:xdce>", 200, 160 );
        hudtext setdevtext( "<dev string:xdd6>" );
        
        for ( lastmessage = "<dev string:x52b>"; true ; lastmessage = nameinfo )
        {
            wait 0.1;
            
            if ( !isdefined( level.players ) || !level.players.size )
            {
                continue;
            }
            
            nameinfo = "<dev string:x52b>";
            function_9a9e8983a2e4ab8f();
            
            foreach ( teamname in level.teamswithplayers )
            {
                spectateassignment = "<dev string:xde9>";
                
                if ( isdefined( level.var_fe8ded9ed06c5b0a ) && isdefined( level.var_fe8ded9ed06c5b0a[ teamname ] ) )
                {
                    spectateassignment = level.var_fe8ded9ed06c5b0a[ teamname ];
                }
                
                nameinfo += "<dev string:xdf0>" + teamname + "<dev string:xdf3>" + spectateassignment + "<dev string:xdf8>";
            }
            
            if ( nameinfo != lastmessage )
            {
                hudtext setdevtext( nameinfo );
            }
        }
    }

    // Namespace br_dev
    // Params 0
    // Checksum 0x829234be, Offset: 0x86e1
    // Size: 0x43d, Type: dev
    function function_2f082157f2412a77()
    {
        level endon( #"game_ended" );
        
        if ( level.var_616e414a059d0e38 )
        {
            return;
        }
        
        level.var_616e414a059d0e38 = 1;
        hudtext = function_817c24c6721f2313( "<dev string:xdc6>", 0.8 );
        hudtext hud_util::setpoint( "<dev string:xdce>", "<dev string:xdce>", 20, 160 );
        hudtext setdevtext( "<dev string:xdfc>" );
        
        for ( lastmessage = "<dev string:x52b>"; true ; lastmessage = nameinfo )
        {
            waitframe();
            
            if ( !isdefined( level.players ) || !level.players.size )
            {
                continue;
            }
            
            nameinfo = "<dev string:x52b>";
            function_9a9e8983a2e4ab8f();
            var_4684bb6938a2a4dc = br_spectate::function_f60269abe1b22d3c();
            
            foreach ( teamname in level.teamswithplayers )
            {
                nameinfo += "<dev string:xdf0>" + teamname + "<dev string:xe11>";
                
                foreach ( player in player::getteamarray( teamname ) )
                {
                    entnum = player getentitynumber();
                    print3d( player.origin + ( 0, 0, 70 ), "<dev string:xe16>" + entnum + "<dev string:xe18>" + player.name, ( 1, 1, 1 ), 1, 0.4, 1 );
                    print3d( player.origin + ( 0, 0, 65 ), teamname + "<dev string:xe1b>" + player.health + player.armorhealth, ( 1, 1, 1 ), 1, 0.3, 1 );
                    isplayeralive = isalive( player ) && !player.gulag;
                    var_bfb527d1cdd2ab96 = utility::get_int_or_0( player.gulaguses );
                    playername = ( player.name ?? "<dev string:xe1e>" ) + "<dev string:xe25>" + var_bfb527d1cdd2ab96 + "<dev string:xe28>";
                    
                    if ( isplayeralive )
                    {
                        nameinfo += "<dev string:xe2a>" + playername + "<dev string:xe2f>";
                    }
                    else if ( !level.br_prematchstarted )
                    {
                        nameinfo += "<dev string:xe37>" + playername + "<dev string:xe3c>";
                    }
                    else if ( br_spectate::isvalidspectatetarget( player, var_4684bb6938a2a4dc ) )
                    {
                        nameinfo += "<dev string:xe43>" + playername + "<dev string:xe48>";
                    }
                    else if ( player.br_iseliminated )
                    {
                        nameinfo += "<dev string:xe37>" + playername + "<dev string:xe50>";
                        namecolor = player.killcam ? "<dev string:xe5d>" : "<dev string:xdf0>";
                        spectatingplayer = player getspectatingplayer();
                        
                        if ( isdefined( spectatingplayer ) )
                        {
                            nameinfo += "<dev string:xe60>" + namecolor + spectatingplayer.name + "<dev string:xe65>";
                        }
                        
                        if ( isdefined( level.var_fe8ded9ed06c5b0a ) && isdefined( level.var_fe8ded9ed06c5b0a[ player.team ] ) )
                        {
                            nameinfo += "<dev string:xe69>" + level.var_fe8ded9ed06c5b0a[ player.team ] + "<dev string:xe65>";
                        }
                    }
                    else
                    {
                        nameinfo += "<dev string:xe2a>" + playername + "<dev string:xe70>";
                    }
                    
                    nameinfo += "<dev string:xdf8>";
                }
            }
            
            if ( nameinfo.size > 1000 )
            {
                nameinfo = getsubstr( nameinfo, 0, 1000 );
            }
            
            if ( nameinfo != lastmessage )
            {
                hudtext setdevtext( nameinfo );
            }
        }
    }

    // Namespace br_dev
    // Params 2
    // Checksum 0x2653181f, Offset: 0x8b26
    // Size: 0xef, Type: dev
    function function_817c24c6721f2313( font, fontscale )
    {
        hudelem = newhudelem();
        hudelem.elemtype = "<dev string:xe7a>";
        hudelem.font = font;
        hudelem.fontscale = fontscale;
        hudelem.basefontscale = fontscale;
        hudelem.x = 0;
        hudelem.y = 0;
        hudelem.width = 0;
        hudelem.height = int( level.fontheight * fontscale );
        hudelem.xoffset = 0;
        hudelem.yoffset = 0;
        hudelem.children = [];
        hudelem hud_util::setparent( level.uiparent );
        hudelem.hidden = 0;
        return hudelem;
    }

    // Namespace br_dev
    // Params 0
    // Checksum 0x57dd30e5, Offset: 0x8c1d
    // Size: 0x8d, Type: dev
    function function_2ee13eddfbd7f93c()
    {
        foreach ( player in level.players )
        {
            if ( !isbot( player ) && !istestclient( player ) )
            {
                return player;
            }
        }
    }

    // Namespace br_dev
    // Params 0
    // Checksum 0xe2cc7be8, Offset: 0x8cb2
    // Size: 0x1d1, Type: dev
    function function_862b9e36fce52294()
    {
        notbot = function_2ee13eddfbd7f93c();
        
        if ( !isdefined( notbot ) )
        {
            iprintlnbold( "<dev string:xe7f>" );
            return;
        }
        
        if ( !level.br_prematchstarted )
        {
            level notify( #"forcematchstart" );
            wait 3;
        }
        
        var_3dbc89afc7cce1be = teams::getfriendlyplayers( notbot.team, 1 );
        
        if ( var_3dbc89afc7cce1be.size < 2 )
        {
            if ( level.maxteamsize < 2 )
            {
                level.maxteamsize = 2;
            }
            
            setdvar( @"hash_9e5da81386e98d36", notbot.team );
            setdvar( @"scr_spawnbots", 1 );
            
            while ( var_3dbc89afc7cce1be.size < 2 )
            {
                waitframe();
                var_3dbc89afc7cce1be = teams::getfriendlyplayers( notbot.team, 1 );
            }
            
            frameswaited = 0;
            
            while ( true )
            {
                if ( frameswaited > 100 )
                {
                    iprintlnbold( "<dev string:xe9d>" );
                    return;
                }
                
                friendlyready = 0;
                
                foreach ( player in var_3dbc89afc7cce1be )
                {
                    if ( player == notbot )
                    {
                        continue;
                    }
                    
                    if ( player.sessionstate != "<dev string:xec7>" )
                    {
                        friendlyready = 1;
                        break;
                    }
                }
                
                if ( friendlyready )
                {
                    break;
                }
                
                frameswaited++;
                waitframe();
            }
        }
        
        waittillframeend();
        setdvar( @"hash_12d23346fbacee91", 2 );
        setdvar( @"bot_disableattack", 1 );
        notbot.gulagloser = 1;
        notbot br::sendafksquadmembertogulag();
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0xbbac8e19, Offset: 0x8e8b
    // Size: 0xd1, Type: dev
    function function_99ac9f6026f837f8( bunkerindex )
    {
        player = self;
        player br_keypad_util::playersetkeypadstateindex( 1 );
        player br_keypad_util::playersetkeypadcodelengthindex( 8 );
        
        while ( true )
        {
            player waittill( #"luinotifyserver", message, value );
            
            if ( isdefined( message ) )
            {
                if ( message == "<dev string:xed1>" )
                {
                    if ( verifybunkercode( bunkerindex, value ) )
                    {
                        player br_keypad_util::playersetkeypadstateindex( 2 );
                        wait 2;
                        iprintlnbold( "<dev string:xee2>" );
                        break;
                    }
                    else
                    {
                        player br_keypad_util::playersetkeypadstateindex( 3 );
                        waitframe();
                        iprintlnbold( "<dev string:xf07>" );
                        player br_keypad_util::playersetkeypadstateindex( 1 );
                    }
                    
                    continue;
                }
                
                if ( message == "<dev string:xf2c>" )
                {
                    break;
                }
            }
        }
        
        player br_keypad_util::playersetkeypadstateindex( 0 );
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0x306e7ee6, Offset: 0x8f64
    // Size: 0xb2, Type: dev
    function devgetplayerbyname( playername )
    {
        playername = tolower( playername );
        
        foreach ( player in level.players )
        {
            shortname = function_bb6b1b28c82cf8ac( player.name );
            
            if ( tolower( shortname ) == playername )
            {
                return player;
            }
        }
        
        return;
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0x635d32e6, Offset: 0x901e
    // Size: 0x38, Type: dev
    function function_8a6e7fc3ea36ea1( player )
    {
        br_pickups::br_forcegivecustompickupitem( player, "<dev string:xf3b>", 1, level.br_pickups.maxcounts[ "<dev string:xf3b>" ] );
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0x84414e27, Offset: 0x905e
    // Size: 0x8b, Type: dev
    function devgivemaxammo( player )
    {
        foreach ( ammotype, maxcount in level.br_ammo_max )
        {
            br_weapons::br_ammo_give_type( player, ammotype, maxcount, 0 );
        }
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0x5a3e9b5e, Offset: 0x90f1
    // Size: 0x2b, Type: dev
    function function_e1cb6f80675e6790( player )
    {
        player br_plunder::playerplunderpickup( level.br_plunder.plunderlimit );
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0xa10fa052, Offset: 0x9124
    // Size: 0x18, Type: dev
    function function_b9bb639b73455d35( player )
    {
        player br_pickups::addrespawntoken();
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0xb7668039, Offset: 0x9144
    // Size: 0x18, Type: dev
    function function_f7a2660efda94d88( player )
    {
        player br_pickups::addselfrevivetoken();
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0x8d4c97c4, Offset: 0x9164
    // Size: 0x28, Type: dev
    function function_9eb8d5334c9e53b6( player )
    {
        if ( !isdefined( player.inlaststand ) )
        {
            player br_pickups::removeselfrevivetoken();
        }
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0xdb415df3, Offset: 0x9194
    // Size: 0x1f, Type: dev
    function function_4a6f979835660555( player )
    {
        br_pickups::br_forcegivecustompickupitem( player, "<dev string:x755>", 1 );
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0x403ec24d, Offset: 0x91bb
    // Size: 0x53, Type: dev
    function function_b8af141105d10c6( player )
    {
        randomweaponname = utility::random_key( level.commonitem.var_685573a854ce8718 );
        weaponobj = weapon::buildweapon( randomweaponname );
        player item_weapon::function_96add18b226ff731( weaponobj, 1, undefined );
    }

    // Namespace br_dev
    // Params 0
    // Checksum 0xde16e19a, Offset: 0x9216
    // Size: 0x9b, Type: dev
    function function_3986c11ac3d6ebd9()
    {
        killtriggers = getentarray( "<dev string:xf4e>", #classname );
        
        foreach ( trigger in killtriggers )
        {
            trigger.targetname = "<dev string:xf5b>";
        }
    }

    // Namespace br_dev
    // Params 0
    // Checksum 0x20097ea5, Offset: 0x92b9
    // Size: 0xda, Type: dev
    function function_5fdbc2bd1ee88c59()
    {
        host = gamelogic_mp::gethostplayer();
        
        foreach ( player in level.players )
        {
            if ( isdefined( player ) && !isalive( player ) && !player.br_iseliminated && !player.gulag )
            {
                if ( isdefined( host ) )
                {
                    host iprintlnbold( "<dev string:xf67>" + player.name + "<dev string:xf6f>" );
                }
            }
        }
    }

    // Namespace br_dev
    // Params 0
    // Checksum 0x37b79935, Offset: 0x939b
    // Size: 0x140, Type: dev
    function function_6d30b592e21540ac()
    {
        level endon( #"game_ended" );
        setdvarifuninitialized( @"hash_5ec38dd7bdfbfe50", 0 );
        
        while ( true )
        {
            if ( getdvarint( @"hash_5ec38dd7bdfbfe50", 0 ) )
            {
                squadleaderlist = [];
                
                foreach ( player in level.players )
                {
                    if ( player br_public::isplayerbrsquadleader() )
                    {
                        squadleaderlist[ squadleaderlist.size ] = player;
                    }
                }
                
                foreach ( player in squadleaderlist )
                {
                    player br::abandonbrsquadleader();
                }
                
                setdvar( @"hash_5ec38dd7bdfbfe50", 0 );
            }
            
            wait 1;
        }
    }

    // Namespace br_dev
    // Params 0
    // Checksum 0x37d4fb87, Offset: 0x94e3
    // Size: 0x125, Type: dev
    function function_f442fb6736ecf92b()
    {
        counter = getdvarint( @"hash_9d1ee47341b74924", 15 );
        abovePlayerCached = 0;
        aboveplayer = 0;
        othercount = 0;
        
        while ( counter > 0 )
        {
            spawnpoint = level.players[ 0 ] br_spawnrespawn::playergetrespawnpoint();
            level thread debug::drawsphere( spawnpoint.origin, 64, 60, ( 0, 1, 0 ) );
            aboveplayer = spawnpoint.type == "<dev string:xf7b>" ? aboveplayer + 1 : aboveplayer;
            abovePlayerCached = spawnpoint.type == "<dev string:xf87>" ? abovePlayerCached + 1 : abovePlayerCached;
            othercount = spawnpoint.type != "<dev string:xf7b>" && spawnpoint.type != "<dev string:xf87>" ? othercount + 1 : othercount;
            counter -= 1;
        }
        
        iprintlnbold( "<dev string:xf99>" + abovePlayerCached + "<dev string:xfa8>" + aboveplayer + "<dev string:xfb2>" + othercount );
    }

    // Namespace br_dev
    // Params 0
    // Checksum 0x33e2a779, Offset: 0x9610
    // Size: 0xed, Type: dev
    function function_19e33a09ddd3ba4e()
    {
        player = function_2ee13eddfbd7f93c();
        
        if ( !isdefined( player ) )
        {
            iprintlnbold( "<dev string:xe7f>" );
            return;
        }
        
        spawndata = spawnstruct();
        spawndata.origin = player.origin + ( 100, 0, 0 );
        spawndata.angles = player.angles;
        spawndata.modelname = "<dev string:xfba>";
        spawndata.vehicletype = "<dev string:xfc8>";
        spawndata.targetname = "<dev string:xfd4>";
        faildata = spawnstruct();
        vehicle = vehicle_tracking::spawn_vehicle( spawndata, faildata );
        player player::setusingremote( "<dev string:xfdd>" );
        vehicle setotherent( player );
        vehicle setentityowner( player );
        player controlslinkto( vehicle );
    }

    // Namespace br_dev
    // Params 0
    // Checksum 0x53a0b738, Offset: 0x9705
    // Size: 0x1e, Type: dev
    function function_4eaee485c9149e4e()
    {
        player = function_2ee13eddfbd7f93c();
        player function_bea9907eddd014e();
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0xc45c57d, Offset: 0x972b
    // Size: 0x564, Type: dev
    function function_5bbf4b986080e3a0( args )
    {
        var_8e9c19e285485a00 = 5000;
        var_63ac35a33b1ae8bf = 100;
        var_acb0643f12185de6 = 1000;
        var_e19d3f45bafc368f = br_public::function_5d8b60a1b01b8249();
        var_b5b42f7b65eecf19 = br_public::function_b4d14b7b48e551af();
        var_2462f5b6f3451c63 = 5000;
        var_d3e2e64845578711 = -18000 + var_e19d3f45bafc368f;
        const_player_radius = 15;
        resolution = 1000;
        precision = 5;
        var_696a09b2f6596fea = 8000;
        
        if ( args.size == 1 && int( args[ 0 ] ) == 0 )
        {
            if ( level.var_4c0de7af7e02a93f )
            {
                level notify( #"hash_5f8c6a0bebac92f" );
                level notify( #"showholes" );
                level.var_4c0de7af7e02a93f = undefined;
                level.holesa = [];
                level.holesb = [];
                level.var_55f7223069c0f490 = [];
                level.var_55f7253069c0fb29 = [];
                level.var_55f7243069c0f8f6 = [];
                level.var_17878cbb425313ba = [];
                level.var_17878bbb42531187 = [];
                level.var_38af93633a2a2518 = [];
                level.var_38af96633a2a2bb1 = [];
                return;
            }
        }
        else if ( args.size > 0 && int( args[ 0 ] ) > 1 )
        {
            resolution = int( args[ 0 ] );
            
            if ( args.size > 1 )
            {
                precision = int( max( 1, int( args[ 1 ] ) ) );
            }
            
            if ( args.size > 2 )
            {
                var_696a09b2f6596fea = int( max( 1, int( args[ 2 ] ) ) );
            }
        }
        
        level endon( #"hash_5f8c6a0bebac92f" );
        level.var_4c0de7af7e02a93f = 1;
        host = gamelogic_mp::gethostplayer();
        origin = host.origin;
        level.holesa = [];
        level.holesb = [];
        level.var_55f7223069c0f490 = [];
        level.var_55f7253069c0fb29 = [];
        level.var_55f7243069c0f8f6 = [];
        level.var_17878cbb425313ba = [];
        level.var_17878bbb42531187 = [];
        level.var_38af93633a2a2518 = [];
        level.var_38af96633a2a2bb1 = [];
        thread showholes();
        contents = trace::create_contents( 0, 1, 1, 1, 0, 0, 1 );
        org = trace::sphere_trace( origin + ( 0, 0, var_2462f5b6f3451c63 ), origin + ( 0, 0, var_d3e2e64845578711 ), const_player_radius, undefined, contents )[ "<dev string:xdaa>" ];
        checkheight = org[ 2 ] - var_acb0643f12185de6;
        count = 0;
        countglobal = 0;
        total = pow( 2 * resolution / precision, 2 ) * 1;
        x = -1 * resolution;
        
        while ( x <= resolution )
        {
            host iprintlnbold( "<dev string:xfe2>" + int( countglobal / total * 100 ) );
            y = -1 * resolution;
            
            while ( y <= resolution )
            {
                countglobal++;
                nextorg = ( x + origin[ 0 ], y + origin[ 1 ], origin[ 2 ] );
                nextorg2 = br_public::droptogroundmultitrace( nextorg );
                count++;
                
                if ( count >= var_696a09b2f6596fea )
                {
                    waitframe();
                    count = 0;
                }
                
                if ( nextorg2[ 2 ] < var_e19d3f45bafc368f )
                {
                    if ( level.holesa.size > var_8e9c19e285485a00 )
                    {
                        break;
                    }
                    
                    level.holesa[ level.holesa.size ] = nextorg + ( 0, 0, var_2462f5b6f3451c63 );
                    level.holesb[ level.holesb.size ] = nextorg2;
                }
                else
                {
                    count++;
                    
                    if ( count >= var_696a09b2f6596fea )
                    {
                        waitframe();
                        count = 0;
                    }
                    
                    var_3f85af203585e400 = trace::ray_trace( nextorg + ( 0, 0, var_2462f5b6f3451c63 ), nextorg + ( 0, 0, var_d3e2e64845578711 ), undefined, contents )[ "<dev string:xdaa>" ];
                    
                    if ( var_3f85af203585e400[ 2 ] < var_e19d3f45bafc368f )
                    {
                        if ( level.var_55f7223069c0f490.size > var_8e9c19e285485a00 )
                        {
                            break;
                        }
                        
                        level.var_55f7223069c0f490[ level.var_55f7223069c0f490.size ] = nextorg + ( 0, 0, var_2462f5b6f3451c63 );
                        level.var_55f7253069c0fb29[ level.var_55f7253069c0fb29.size ] = nextorg2;
                        level.var_55f7243069c0f8f6[ level.var_55f7243069c0f8f6.size ] = var_3f85af203585e400;
                    }
                    else if ( var_3f85af203585e400[ 2 ] < checkheight && level.var_17878cbb425313ba.size < var_63ac35a33b1ae8bf )
                    {
                        level.var_17878cbb425313ba[ level.var_17878cbb425313ba.size ] = nextorg + ( 0, 0, var_2462f5b6f3451c63 );
                        level.var_17878bbb42531187[ level.var_17878bbb42531187.size ] = var_3f85af203585e400;
                    }
                    else if ( ( abs( x ) == abs( resolution ) || x + precision > resolution ) && ( abs( y ) == abs( resolution ) || y + precision > resolution ) )
                    {
                        level.var_38af93633a2a2518[ level.var_38af93633a2a2518.size ] = nextorg + ( 0, 0, var_2462f5b6f3451c63 );
                        level.var_38af96633a2a2bb1[ level.var_38af96633a2a2bb1.size ] = nextorg2;
                    }
                }
                
                y += precision;
            }
            
            if ( level.holesa.size > var_8e9c19e285485a00 || level.var_55f7223069c0f490.size > var_8e9c19e285485a00 )
            {
                break;
            }
            
            x += precision;
        }
        
        host iprintlnbold( "<dev string:xfec>" + level.holesa.size + "<dev string:xff4>" + level.var_55f7223069c0f490.size + "<dev string:x1004>" + level.var_17878cbb425313ba.size );
    }

    // Namespace br_dev
    // Params 0
    // Checksum 0xd3713bf9, Offset: 0x9c97
    // Size: 0x1b1, Type: dev
    function showholes()
    {
        level notify( #"showholes" );
        level endon( #"showholes" );
        
        while ( true )
        {
            for ( i = 0; i < level.holesa.size ; i++ )
            {
                orga = level.holesa[ i ];
                orgb = level.holesb[ i ];
                line( orga, orgb, ( 1, 0, 0 ), 1, 1, 1 );
            }
            
            for ( i = 0; i < level.var_55f7223069c0f490.size ; i++ )
            {
                orga = level.var_55f7223069c0f490[ i ];
                orgb = level.var_55f7253069c0fb29[ i ];
                orgc = level.var_55f7243069c0f8f6[ i ];
                line( orga, orgb, ( 1, 1, 0 ), 1, 1, 1 );
                line( orgb, orgc, ( 1, 0, 0 ), 1, 1, 1 );
            }
            
            for ( i = 0; i < level.var_17878cbb425313ba.size ; i++ )
            {
                orga = level.var_17878cbb425313ba[ i ];
                orgb = level.var_17878bbb42531187[ i ];
                line( orga, orgb, ( 1, 0, 1 ), 1, 1, 1 );
            }
            
            for ( i = 0; i < level.var_38af93633a2a2518.size ; i++ )
            {
                orga = level.var_38af93633a2a2518[ i ];
                orgb = level.var_38af96633a2a2bb1[ i ];
                line( orga, orgb, ( 0, 1, 0 ), 1, 1, 1 );
            }
            
            waitframe();
        }
    }

    // Namespace br_dev
    // Params 2
    // Checksum 0x700e80c0, Offset: 0x9e50
    // Size: 0x1a7, Type: dev
    function function_a8c37646d2124dae( player, contractref )
    {
        if ( !isdefined( player ) )
        {
            return;
        }
        
        playerorigin = player.origin;
        playerangles = player getplayerangles();
        playerforward = anglestoforward( playerangles );
        tracestart = ( playerorigin[ 0 ], playerorigin[ 1 ], playerorigin[ 2 ] + player getplayerviewheight() );
        traceend = tracestart + playerforward * 5000;
        tracecontents = trace::create_default_contents( 0 );
        trace = trace::ray_trace( tracestart, traceend, player, tracecontents );
        
        if ( isdefined( trace[ "<dev string:xdb5>" ] ) )
        {
            br_contract_manager::function_e1384ed619bd6d5c( trace[ "<dev string:xdb5>" ], contractref );
            return;
        }
        
        closestplayer = undefined;
        closestdist = 0;
        
        foreach ( otherplayer in level.players )
        {
            if ( otherplayer == player )
            {
                continue;
            }
            
            dist = distance2dsquared( otherplayer.origin, trace[ "<dev string:xdaa>" ] );
            
            if ( closestdist == 0 || dist < closestdist )
            {
                closestdist = dist;
                closestplayer = otherplayer;
            }
        }
        
        if ( isdefined( closestplayer ) )
        {
            br_contract_manager::function_e1384ed619bd6d5c( closestplayer, contractref );
            return;
        }
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0xd6b0fc2c, Offset: 0x9fff
    // Size: 0xd3, Type: dev
    function function_2b58eeefe053f5f7( args )
    {
        skin = undefined;
        
        if ( args.size > 0 )
        {
            skin = args[ 0 ];
        }
        else
        {
            skin = br_infils_util::function_b331ca02076487e0();
        }
        
        host = gamelogic_mp::gethostplayer();
        start = host geteye();
        dir = anglestoforward( host getplayerangles() );
        end = start + 8000 * dir;
        trace = trace::_bullet_trace( start, end, 1, host );
        
        if ( trace[ "<dev string:xda1>" ] >= 1 )
        {
            return;
        }
        
        neworigin = trace[ "<dev string:xdaa>" ];
        newent = spawn( "<dev string:x100e>", neworigin );
        newent function_ce21f4102d5d17f6( skin, "<dev string:x101b>" );
    }

    // Namespace br_dev
    // Params 2
    // Checksum 0xc8659ef3, Offset: 0xa0da
    // Size: 0x27, Type: dev
    function showsplash( splash, splashlistoverride )
    {
        hud_util::showsplashtoall( splash, undefined, undefined, undefined, undefined, splashlistoverride );
    }

    // Namespace br_dev
    // Params 0
    // Checksum 0xaae59ae4, Offset: 0xa109
    // Size: 0x3c, Type: dev
    function function_9b0ca3a8cdb23fe4()
    {
        level endon( #"game_ended" );
        namespace_5168e34bf6216ecc::function_55220e3796325cea( level.players, "<dev string:x1034>" );
        waitframe();
        namespace_5168e34bf6216ecc::function_55220e3796325cea( level.players, "<dev string:x1048>" );
    }

    // Namespace br_dev
    // Params 0
    // Checksum 0x2bdc8e7b, Offset: 0xa14d
    // Size: 0x88, Type: dev
    function function_d660450ac1c6adde()
    {
        start = self geteye();
        dir = anglestoforward( self getplayerangles() );
        end = start + 8000 * dir;
        trace = trace::_bullet_trace( start, end, 1, self );
        player = undefined;
        
        if ( isplayer( trace[ "<dev string:xdb5>" ] ) && player::isreallyalive( trace[ "<dev string:xdb5>" ] ) )
        {
            player = trace[ "<dev string:xdb5>" ];
        }
        
        return player;
    }

    // Namespace br_dev
    // Params 0
    // Checksum 0xdcd49aeb, Offset: 0xa1dd
    // Size: 0x3b, Type: dev
    function function_7f78009d80898e97()
    {
        host = gamelogic_mp::gethostplayer();
        
        if ( isdefined( host.savedloadout ) )
        {
            host br::playerloadoutrestore();
            return;
        }
        
        host br::function_d8d054ee4230fa94();
    }

    // Namespace br_dev
    // Params 2
    // Checksum 0x38d63817, Offset: 0xa220
    // Size: 0x51, Type: dev
    function function_996060e811b01e19( victim, platingtype )
    {
        level endon( #"game_ended" );
        victim armor::function_6228482afe1de9bf( "<dev string:x105b>", platingtype );
        waitframe();
        waitframe();
        waitframe();
        waitframe();
        waitframe();
        waitframe();
        waitframe();
        function_1f19b81a419a44fd( victim.name, undefined, 300 );
    }

    // Namespace br_dev
    // Params 3
    // Checksum 0xcbcd119f, Offset: 0xa279
    // Size: 0x213, Type: dev
    function function_bfc2f4431f4918a2( targetanim, interrupttype, framedelay )
    {
        player = self;
        player notify( "<dev string:x7ee>" + targetanim );
        player endon( "<dev string:x7ee>" + targetanim );
        
        if ( interrupttype == 0 )
        {
            return;
        }
        
        while ( true )
        {
            player waittill( #"hash_9d8d4f12300d38a9", _anime, _duration );
            
            if ( _anime != targetanim )
            {
                continue;
            }
            
            var_2d63253c314a3505 = framedelay * getframeduration() / 1000;
            
            if ( var_2d63253c314a3505 )
            {
                wait var_2d63253c314a3505;
            }
            
            switch ( interrupttype )
            {
                case 1:
                    player armor::setarmorhealth( 0, 1 );
                    damagesuccess = player dodamage( player.health / 2, player.origin, player, player );
                    break;
                case 2:
                    player armor::setarmorhealth( 0, 1 );
                    damagesuccess = player dodamage( player.health, player.origin, player, player );
                    break;
                case 3:
                    player kill();
                    break;
                case 4:
                    player armor::setarmorhealth( 0, 1 );
                    damagesuccess = player dodamage( player.health, player.origin, player, player );
                    wait var_2d63253c314a3505;
                    player kill();
                    break;
                case 5:
                    player armor::setarmorhealth( 0, 1 );
                    damagesuccess = player dodamage( player.health / 2, player.origin, player, player );
                    wait var_2d63253c314a3505;
                    damagesuccess = player dodamage( player.health, player.origin, player, player );
                    wait var_2d63253c314a3505;
                    player kill();
                    break;
            }
            
            iprintln( "<dev string:x106d>" + targetanim + "<dev string:x107a>" + var_2d63253c314a3505 + "<dev string:x1082>" );
        }
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0x407672f8, Offset: 0xa494
    // Size: 0x1ed, Type: dev
    function function_a94841d21e0ca480( scanneridx )
    {
        if ( !utility::issharedfuncdefined( #"biometricscan", #"scanner_used" ) )
        {
            return;
        }
        
        player = self;
        player notify( #"hash_fb35981a4d8a77d3" );
        player endon( #"hash_fb35981a4d8a77d3" );
        
        if ( isdefined( level.var_904f7a4736d5940e[ scanneridx ] ) )
        {
            scanner = level.var_904f7a4736d5940e[ scanneridx ].biometric_scan_station;
        }
        else
        {
            return;
        }
        
        iprintln( "<dev string:x1084>" + scanneridx );
        wait 2;
        playerorigin = scanner.origin + 30 * anglestoforward( scanner.angles );
        playerangles = invertangles( scanner.angles );
        player setorigin( playerorigin );
        player setplayerangles( playerangles );
        player.health = player.maxhealth;
        iprintln( "<dev string:x10a5>" );
        wait 3;
        
        while ( true )
        {
            if ( !player::isreallyalive( player ) )
            {
                player waittill( #"parachute_landed" );
                player setorigin( playerorigin );
                player setplayerangles( playerangles );
                wait 1;
            }
            
            if ( !player hasweapon( "<dev string:x10d9>" ) )
            {
                player giveweapon( "<dev string:x10d9>" );
            }
            
            wait 0.05;
            [[ utility::getsharedfunc( #"biometricscan", #"scanner_used" ) ]]( scanner, "<dev string:x1145>", "<dev string:x1157>", player, 1 );
            
            while ( scanner getscriptablepartstate( "<dev string:x1145>" ) != "<dev string:x1157>" )
            {
                wait 0.1;
            }
            
            wait 1;
            
            if ( player::isinlaststand( player ) )
            {
                setdevdvar( @"hash_a28e203d53e8292d", 1 );
            }
            
            wait 1;
            
            if ( player::isreallyalive( player ) )
            {
                player.health = player.maxhealth;
            }
        }
    }

    // Namespace br_dev
    // Params 0
    // Checksum 0x99eaa217, Offset: 0xa689
    // Size: 0xda, Type: dev
    function draw_oob()
    {
        if ( utility::flag( "<dev string:x115e>" ) )
        {
            utility::flag_clear( "<dev string:x115e>" );
            return;
        }
        else
        {
            utility::flag_set( "<dev string:x115e>" );
        }
        
        level endon( #"draw_oob" );
        
        while ( true )
        {
            foreach ( trigger in level.outofboundstriggers )
            {
                drawtrigger( trigger, ( 1, 0, 0 ), 0, 1, 1, ( 1, 0, 0 ) );
            }
            
            waitframe();
        }
    }

    // Namespace br_dev
    // Params 0
    // Checksum 0x1b355516, Offset: 0xa76b
    // Size: 0x2e6, Type: dev
    function draw_bounds()
    {
        if ( utility::flag( "<dev string:x1167>" ) )
        {
            utility::flag_clear( "<dev string:x1167>" );
            return;
        }
        else
        {
            utility::flag_set( "<dev string:x1167>" );
        }
        
        level endon( #"hash_4a53d9a83cc17ef5" );
        zheight = parachute::getc130height();
        p1 = ( level.br_level.br_mapbounds[ 0 ][ 0 ], level.br_level.br_mapbounds[ 0 ][ 1 ], zheight );
        p2 = ( level.br_level.br_mapbounds[ 1 ][ 0 ], level.br_level.br_mapbounds[ 0 ][ 1 ], zheight );
        p3 = ( level.br_level.br_mapbounds[ 1 ][ 0 ], level.br_level.br_mapbounds[ 1 ][ 1 ], zheight );
        p4 = ( level.br_level.br_mapbounds[ 0 ][ 0 ], level.br_level.br_mapbounds[ 1 ][ 1 ], zheight );
        p5 = ( level.br_level.br_mapboundsfull[ 0 ][ 0 ], level.br_level.br_mapboundsfull[ 0 ][ 1 ], zheight );
        p6 = ( level.br_level.br_mapboundsfull[ 1 ][ 0 ], level.br_level.br_mapboundsfull[ 0 ][ 1 ], zheight );
        p7 = ( level.br_level.br_mapboundsfull[ 1 ][ 0 ], level.br_level.br_mapboundsfull[ 1 ][ 1 ], zheight );
        p8 = ( level.br_level.br_mapboundsfull[ 0 ][ 0 ], level.br_level.br_mapboundsfull[ 1 ][ 1 ], zheight );
        
        while ( true )
        {
            line( p1, p2, ( 0, 1, 0 ) );
            line( p2, p3, ( 0, 1, 0 ) );
            line( p3, p4, ( 0, 1, 0 ) );
            line( p4, p1, ( 0, 1, 0 ) );
            line( p5, p6, ( 1, 1, 0 ) );
            line( p6, p7, ( 1, 1, 0 ) );
            line( p7, p8, ( 1, 1, 0 ) );
            line( p8, p5, ( 1, 1, 0 ) );
            waitframe();
        }
    }

    // Namespace br_dev
    // Params 1
    // Checksum 0x545f5c6b, Offset: 0xaa59
    // Size: 0x9b, Type: dev
    function function_f2d64b4f8362cdbb( args )
    {
        if ( isdefined( args ) && args.size == 3 )
        {
            position = ( float( args[ 0 ] ), float( args[ 1 ] ), float( args[ 2 ] ) );
        }
        
        if ( !isdefined( position ) )
        {
            position = level.player.origin;
        }
        
        result = br_circle::_ispointinbadarea( position );
        iprintlnbold( "<dev string:x1173>" + position + "<dev string:x117d>" + ( result ? "<dev string:xdb3>" : "<dev string:x1181>" ) + "<dev string:x1187>" );
    }

    // Namespace br_dev
    // Params 0
    // Checksum 0x6a73657a, Offset: 0xaafc
    // Size: 0xda, Type: dev
    function function_7fc0f81a33509018()
    {
        if ( utility::flag( "<dev string:x1196>" ) )
        {
            utility::flag_clear( "<dev string:x1196>" );
            return;
        }
        else
        {
            utility::flag_set( "<dev string:x1196>" );
        }
        
        level endon( #"hash_18d28ec2a789e629" );
        
        while ( true )
        {
            foreach ( trigger in level.var_38e0cfd2f954b68f )
            {
                drawtrigger( trigger, ( 1, 0, 0 ), 0, 1, 1, ( 1, 0, 0 ) );
            }
            
            waitframe();
        }
    }

    // Namespace br_dev
    // Params 2, eflags: 0xc
    // Checksum 0x85f117c9, Offset: 0xabde
    // Size: 0x1bc, Type: dev
    function private function_a79e1b420b0853b9( args, firstplayer )
    {
        self notify( #"hash_6b99a982b0873b69" );
        self endon( #"hash_6b99a982b0873b69" );
        
        if ( args.size > 1 )
        {
            iprintlnbold( "<dev string:x11a0>" );
            return;
        }
        
        fontscale = args[ 0 ] ?? 5;
        
        if ( fontscale == 0 )
        {
            return;
        }
        
        var_23996e6f2b735cc0 = [];
        
        for ( teamindex = 0; teamindex < level.allteamnamelist.size ; teamindex++ )
        {
            var_3dfa022401a42ee7 = teamindex * 1.61803 * 3 % 3;
            teamcolor = ( clamp( abs( var_3dfa022401a42ee7 - 1.5 ) - 0.5, 0, 1 ), clamp( 1 - abs( var_3dfa022401a42ee7 - 1 ), 0, 1 ), clamp( 1 - abs( var_3dfa022401a42ee7 - 2 ), 0, 1 ) );
            var_23996e6f2b735cc0[ level.allteamnamelist[ teamindex ] ] = teamcolor;
        }
        
        while ( true )
        {
            foreach ( player in level.players )
            {
                print3d( player.origin + ( 0, 0, 72 ), player.team, var_23996e6f2b735cc0[ player.team ], 1, fontscale, 1, 1 );
            }
            
            waitframe();
        }
    }

    // Namespace br_dev
    // Params 2
    // Checksum 0xc678cafc, Offset: 0xada2
    // Size: 0x1cb, Type: dev
    function function_a6ba308986cc9b36( args, firstplayer )
    {
        if ( level.var_7b1e19bfcc13b90c )
        {
            level.var_7b1e19bfcc13b90c freescriptable();
        }
        
        if ( !level.var_34aef15c6a79901d )
        {
            dir = anglestoforward( firstplayer.angles );
            tracepoint = firstplayer.origin + dir * 200;
            level.var_34aef15c6a79901d = br_public::droptogroundmultitrace( tracepoint );
            level.var_637255c49121fe73 = firstplayer.angles;
        }
        
        if ( !level.devmissile )
        {
            level.devmissile = spawn( "<dev string:x100e>", level.var_34aef15c6a79901d );
            level.devmissile.angles = level.var_637255c49121fe73;
            level.devmissile setmodel( "<dev string:x11bc>" );
        }
        
        level.var_7b1e19bfcc13b90c = spawnscriptable( %"saw_scriptable_bongo_cradle_gas_bomb", level.var_34aef15c6a79901d, level.var_637255c49121fe73 );
        level.devmissile scriptmodelplayanim( "<dev string:x11e4>", "<dev string:x1204>" );
        wait getdvarfloat( @"scr_test_wait", 2.98 );
        level.var_7b1e19bfcc13b90c setscriptablepartstate( "<dev string:x1204>", "<dev string:x120c>" );
        level.devmissile waittillmatch( #"missile", #"end" );
        level.var_7b1e19bfcc13b90c setscriptablepartstate( "<dev string:x1204>", "<dev string:x1216>" );
        level.devmissile delete();
        wait getdvarfloat( @"hash_fd2901a9407ee3da", 15 );
        level.var_7b1e19bfcc13b90c setscriptablepartstate( "<dev string:x1204>", "<dev string:x121b>" );
    }

#/
