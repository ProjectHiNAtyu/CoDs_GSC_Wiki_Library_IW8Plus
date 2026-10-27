// scripts\mp\br\gametypes\br_dev_phoenix.gsc  (hash_1fc1bd37ff22a221.gscc) (size: 21967 Bytes / 0x55cf / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x64a23437 (1688351799)
// size ...... 21967 (0x55cf)
// includes .. 26  (offset: 0x4c87)
// strings ... 135 (offset: 0x4d57)
// dev strs .. 0   (offset: 0x55cf)
// exports ... 32  (offset: 0x36f7)
// cseg ...... 0x989 + 0x2d6e (0x36f7)
// imports ... 126 (offset: 0x3bf7)
// animtree1 . 0   (offset: 0x55cf)
// animtree2 . 0   (offset: 0x55cf)
#using scripts\common\game_utility;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_assassination_quest;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_gulag;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_quest_util;
#using scripts\mp\br\gametypes\br_spectate;
#using scripts\mp\br\gametypes\br_utility;
#using scripts\mp\br\gametypes\br_vip_quest;
#using scripts\mp\common\killstreaks\uav;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\streamhint;
#using scripts\mp\common\utility\teams;
#using scripts\mp\gamelogic;
#using scripts\mp\gamescore;
#using scripts\mp\loot\common_item;
#using scripts\mp\parachute;
#using scripts\mp\playerlogic;
#using scripts\mp\team_assimilation;

#namespace br_dev_phoenix;

// Namespace br_dev_phoenix
// Params 0
// Checksum 0x9988fa09, Offset: 0x9a7
// Size: 0x54
function init()
{
    level.var_6786987c6b7d2cc5 = getdvarint( @"scr_br_playtest_tool_phoenix", 0 );
    level.var_5363d30f7db7284f = getdvarint( @"hash_10d7b61bff0b17a3", 1 );
    
    if ( !getdvarint( @"dlog_is_playtest", 0 ) )
    {
        return;
    }
    
    level thread function_6786987c6b7d2cc5();
    level thread function_5363d30f7db7284f();
}

// Namespace br_dev_phoenix
// Params 0
// Checksum 0xa64d3997, Offset: 0xa03
// Size: 0x4bf
function function_6786987c6b7d2cc5()
{
    if ( !level.var_6786987c6b7d2cc5 )
    {
        return;
    }
    
    level endon( #"game_ended" );
    wait 10;
    
    while ( true )
    {
        playercommandname = "";
        var_2cfe5d889dd8bd00 = 0;
        
        while ( true )
        {
            playercommandname = getdvar( @"scr_br_dev_respawn" );
            
            if ( playercommandname != "" )
            {
                setdvar( @"scr_br_dev_respawn", "" );
                var_2cfe5d889dd8bd00 = 1;
                break;
            }
            
            playercommandname = getdvar( @"hash_dcbb0a9ee95ae26" );
            
            if ( playercommandname != "" )
            {
                setdvar( @"hash_dcbb0a9ee95ae26", "" );
                var_2cfe5d889dd8bd00 = 2;
                break;
            }
            
            playercommandname = getdvar( @"hash_5752f63f26ab4917" );
            
            if ( playercommandname != "" )
            {
                setdvar( @"hash_5752f63f26ab4917", "" );
                var_2cfe5d889dd8bd00 = 3;
                break;
            }
            
            playercommandname = getdvar( @"hash_a592a729d729c65a" );
            
            if ( playercommandname != "" )
            {
                setdvar( @"hash_a592a729d729c65a", "" );
                var_2cfe5d889dd8bd00 = 4;
                break;
            }
            
            playercommandname = getdvar( @"scr_br_dev_third_person" );
            
            if ( playercommandname != "" )
            {
                setdvar( @"scr_br_dev_third_person", "" );
                var_2cfe5d889dd8bd00 = 5;
                break;
            }
            
            playercommandname = getdvar( @"hash_5556ca8eeeed2341" );
            
            if ( playercommandname != "" )
            {
                setdvar( @"hash_5556ca8eeeed2341", "" );
                var_2cfe5d889dd8bd00 = 6;
                break;
            }
            
            playercommandname = getdvar( @"scr_br_dev_spectator" );
            
            if ( playercommandname != "" )
            {
                setdvar( @"scr_br_dev_spectator", "" );
                var_2cfe5d889dd8bd00 = 7;
                break;
            }
            
            playercommandname = getdvar( @"scr_br_dev_report_bug" );
            
            if ( playercommandname != "" )
            {
                setdvar( @"scr_br_dev_report_bug", "" );
                var_2cfe5d889dd8bd00 = 8;
                break;
            }
            
            playercommandname = getdvar( @"scr_br_dev_spawn_item" );
            
            if ( playercommandname != "" )
            {
                setdvar( @"scr_br_dev_spawn_item", "" );
                var_2cfe5d889dd8bd00 = 9;
                break;
            }
            
            playercommandname = getdvar( @"hash_9d6f9499c51c772d" );
            
            if ( playercommandname != "" )
            {
                setdvar( @"hash_9d6f9499c51c772d", "" );
                var_2cfe5d889dd8bd00 = 10;
                break;
            }
            
            playercommandname = getdvar( @"scr_br_dev_spectate" );
            
            if ( playercommandname != "" )
            {
                setdvar( @"scr_br_dev_spectate", "" );
                var_2cfe5d889dd8bd00 = 11;
                break;
            }
            
            wait 0.5;
        }
        
        arguments = strtok( playercommandname, getdvar( @"hash_c72daf352ff527f5", "^P^" ) );
        whitelist = tolower( getdvar( @"scr_br_redeploy_playtester" ) );
        
        if ( function_fbc59b746ba75d01( whitelist, arguments[ 0 ] ) )
        {
            foreach ( player in level.players )
            {
                if ( issubstr( tolower( player.name ), tolower( arguments[ 0 ] ) ) )
                {
                    if ( !isdefined( player.var_af699ab3fa68a2a5 ) )
                    {
                        player.var_af699ab3fa68a2a5 = 0;
                    }
                    
                    player.var_af699ab3fa68a2a5++;
                    
                    switch ( var_2cfe5d889dd8bd00 )
                    {
                        case 1:
                            player thread function_98c2e165c13fdded( arguments[ 1 ] );
                            break;
                        case 2:
                            player function_48c7f8a4903ccdc7();
                            break;
                        case 3:
                            player function_8f8c0d4f06b86517();
                            break;
                        case 4:
                            player thread function_d7bc22958167cdf7();
                            break;
                        case 5:
                            player thread phoenix_thirdperson();
                            break;
                        case 6:
                            player thread function_efd93e620247840( arguments[ 1 ] );
                            break;
                        case 7:
                            player thread phoenix_spectator();
                            break;
                        case 8:
                            player function_52b04ca9882db97e( arguments[ 1 ], arguments[ 2 ] );
                            break;
                        case 9:
                            player phoenix_spawnitem( arguments[ 1 ] );
                            break;
                        case 10:
                            player function_f2dfe2e42e36522d();
                            break;
                        case 11:
                            player function_26766fc312653351();
                            break;
                        default:
                            break;
                    }
                }
            }
        }
    }
}

// Namespace br_dev_phoenix
// Params 1
// Checksum 0x29e5b611, Offset: 0xeca
// Size: 0x28b
function function_98c2e165c13fdded( var_b88ebdde385e90e4 )
{
    player = self;
    player endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    foreach ( var_62907f979dd81398 in level.players )
    {
        if ( tolower( var_62907f979dd81398.name ) == tolower( var_b88ebdde385e90e4 ) )
        {
            var_b88ebdde385e90e4 = var_62907f979dd81398;
            break;
        }
        
        if ( issubstr( tolower( var_62907f979dd81398.name ), tolower( var_b88ebdde385e90e4 ) ) )
        {
            var_b88ebdde385e90e4 = var_62907f979dd81398;
            break;
        }
    }
    
    if ( isstring( var_b88ebdde385e90e4 ) || var_b88ebdde385e90e4.var_473751b3f0fb23b5 || !level.br_prematchstarted )
    {
        return;
    }
    
    var_b88ebdde385e90e4.var_473751b3f0fb23b5 = 1;
    
    if ( !isalive( var_b88ebdde385e90e4 ) && !var_b88ebdde385e90e4 br_public::isplayerinorgoingtogulag() )
    {
        teammate = var_b88ebdde385e90e4;
        teammates = level.teamdata[ var_b88ebdde385e90e4.team ][ "players" ];
        
        foreach ( p in teammates )
        {
            if ( p == var_b88ebdde385e90e4 )
            {
                continue;
            }
            
            teammate = p;
        }
        
        if ( isdefined( teammate ) )
        {
            teammate = teammates[ 0 ];
            teammate br_pickups::addrespawntoken( 1 );
            var_b88ebdde385e90e4 thread br_gulag::playergulagautowin( "phoenix", teammate, 1, 1 );
            var_b88ebdde385e90e4 phoenix_printlog( "phx_respawn" );
            redeploytype = "redeploy_self";
            
            if ( player != var_b88ebdde385e90e4 )
            {
                redeploytype = "redeploy_other";
            }
            
            var_b88ebdde385e90e4 phoenix_dlogevent( "redeploy", redeploytype, 1 );
            player playlocalsound( "ui_select_purchase_confirm" );
        }
    }
    else
    {
        player playlocalsound( "fly_pickup_deny" );
        redeploytype = "redeploy_self";
        
        if ( player != var_b88ebdde385e90e4 )
        {
            redeploytype = "redeploy_other";
        }
        
        var_b88ebdde385e90e4 phoenix_dlogevent( "redeploy", redeploytype, 0 );
    }
    
    wait 3;
    var_b88ebdde385e90e4.var_473751b3f0fb23b5 = undefined;
}

// Namespace br_dev_phoenix
// Params 2
// Checksum 0xbfb78bd8, Offset: 0x115d
// Size: 0x136, Type: bool
function function_fbc59b746ba75d01( whitelist, var_5f1b20a210ec981f )
{
    if ( whitelist == "any" )
    {
        return true;
    }
    else
    {
        var_25007f7844a6b748 = strtok( whitelist, " " );
        
        if ( arraycontains( var_25007f7844a6b748, tolower( var_5f1b20a210ec981f ) ) )
        {
            return true;
        }
    }
    
    playerdenied = level.players[ 0 ];
    
    foreach ( player in level.players )
    {
        if ( tolower( player.name ) == tolower( var_5f1b20a210ec981f ) )
        {
            playerdenied = player;
            break;
        }
        
        if ( issubstr( tolower( player.name ), tolower( var_5f1b20a210ec981f ) ) )
        {
            playerdenied = player;
            break;
        }
    }
    
    playerdenied playlocalsound( "fly_pickup_deny" );
    playerdenied phoenix_dlogevent( "access_denied", "access_denied", 0 );
    return false;
}

// Namespace br_dev_phoenix
// Params 0
// Checksum 0xd597b061, Offset: 0x129c
// Size: 0x73
function function_48c7f8a4903ccdc7()
{
    player = self;
    
    if ( !isdefined( player.gulaguses ) )
    {
        player.gulaguses = 0;
    }
    
    player.gulaguses -= 1;
    player playlocalsound( "ui_select_purchase_confirm" );
    player phoenix_printlog( "phx_add_gulag_try" );
    player phoenix_dlogevent( "add_gulag_use", "gulag_use_self", 1 );
}

// Namespace br_dev_phoenix
// Params 0
// Checksum 0x88dad952, Offset: 0x1317
// Size: 0x174
function function_8f8c0d4f06b86517()
{
    player = self;
    params = [];
    params[ params.size ] = "clientID";
    params[ params.size ] = player.clientid;
    params[ params.size ] = "origin";
    params[ params.size ] = player.origin;
    params[ params.size ] = "session";
    params[ params.size ] = player.sessionstate;
    params[ params.size ] = "health";
    params[ params.size ] = player.health;
    params[ params.size ] = "armor";
    params[ params.size ] = player.armorhealth;
    params[ params.size ] = "currentWeapon";
    
    if ( isdefined( player.currentweapon ) )
    {
        params[ params.size ] = player.currentweapon.basename;
    }
    else
    {
        params[ params.size ] = "undefined";
    }
    
    gulaguses = -1;
    
    if ( isdefined( player.gulaguses ) )
    {
        gulaguses += player.gulaguses;
    }
    
    params[ params.size ] = "gulag_uses";
    params[ params.size ] = gulaguses;
    params[ params.size ] = "is_eliminated";
    params[ params.size ] = istrue( player.br_iseliminated );
    player playlocalsound( "ui_select_purchase_confirm" );
    player phoenix_printlog( "phx_player_info", params );
    player phoenix_dlogevent( "print_log", "log_self", 1 );
}

// Namespace br_dev_phoenix
// Params 0
// Checksum 0x7cd9a2b1, Offset: 0x1493
// Size: 0xac
function function_d7bc22958167cdf7()
{
    player = self;
    player endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( player.var_754822a1f3c5ba1e )
    {
        return;
    }
    
    player.var_754822a1f3c5ba1e = 1;
    player.plotarmor = 1;
    player hudoutlineenableforclients( level.players, "outlinefill_depth_yellow" );
    player phoenix_printlog( "phx_afk" );
    player phoenix_dlogevent( "afk", "afk_self", 1 );
    wait 10;
    player.var_754822a1f3c5ba1e = undefined;
    player.plotarmor = undefined;
    player hudoutlinedisableforclient( player );
}

// Namespace br_dev_phoenix
// Params 0
// Checksum 0xbd9b3130, Offset: 0x1547
// Size: 0x233
function phoenix_thirdperson()
{
    player = self;
    player endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( player.phoenixthirdperson )
    {
        player playlocalsound( "fly_pickup_deny" );
        return;
    }
    
    player.phoenixthirdperson = 1;
    player playlocalsound( "ui_select_purchase_confirm" );
    player phoenix_printlog( "phx_third_person" );
    player phoenix_dlogevent( "third_person", "third_person_self", 1 );
    positionone = player.origin + ( 90, 0, 50 );
    positiontwo = player.origin + ( 0, 90, 50 );
    positionthree = player.origin + ( -90, 0, 50 );
    positionfour = player.origin + ( 0, -90, 50 );
    camera = spawn( "script_model", positionone );
    camera setmodel( "tag_origin" );
    camera.angles = ( 0, -180, 0 );
    player cameralinkto( camera, "tag_origin", 1, 1 );
    wait 3;
    camera moveto( positiontwo, 2.8, 0.1, 0.1 );
    camera rotateto( ( 0, -90, 0 ), 2.8, 0.1, 0.1 );
    wait 2.9;
    camera moveto( positionthree, 2.8, 0.1, 0.1 );
    camera rotateto( ( 0, 0, 0 ), 2.8, 0.1, 0.1 );
    wait 2.9;
    camera moveto( positionfour, 2.8, 0.1, 0.1 );
    camera rotateto( ( 0, 90, 0 ), 2.8, 0.1, 0.1 );
    wait 3.5;
    player cameraunlink();
    camera delete();
    player.phoenixthirdperson = undefined;
}

// Namespace br_dev_phoenix
// Params 1
// Checksum 0x517d6548, Offset: 0x1782
// Size: 0x177
function function_efd93e620247840( var_38e2c746c80924e1 )
{
    player = self;
    player endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( player.phoenixteleporting )
    {
        player playlocalsound( "fly_pickup_deny" );
        return;
    }
    
    player.phoenixteleporting = 1;
    
    switch ( var_38e2c746c80924e1 )
    {
        case #"hash_beb0467de4253023":
        case #"hash_d6a050caa23f4f81":
        case #"hash_fa18b9f6bd576aff":
            player function_570a854b577dee33( var_38e2c746c80924e1 );
            break;
        case #"hash_1a86166c17e05dc1":
        case #"hash_7ec20b2ed0c1c55b":
        case #"hash_b111a4547c7d9125":
            player function_b3be92693b8de650( var_38e2c746c80924e1 );
            break;
        case #"hash_973d1db8b6644466":
        case #"hash_d22bc78737d8a069":
        case #"hash_d6b0aad9e5d85db2":
        case #"hash_f5ec2f86008e0bc0":
            player function_890574330fae3332( var_38e2c746c80924e1 );
            break;
        case #"hash_87d1443ef2805760":
            player function_d7b5f77add23d015( var_38e2c746c80924e1 );
            break;
        case #"hash_c518111e891b32a4":
            player function_e651688b0b72af9( var_38e2c746c80924e1 );
            break;
        case #"hash_c574c6c109cbbf7":
            player function_d4ef6109d34ac74();
            break;
        default:
            player playlocalsound( "fly_pickup_deny" );
            break;
    }
    
    wait 3;
    player.phoenixteleporting = undefined;
}

// Namespace br_dev_phoenix
// Params 1
// Checksum 0x53f1ae2e, Offset: 0x1901
// Size: 0x38f
function function_570a854b577dee33( var_38e2c746c80924e1 )
{
    player = self;
    params = [];
    params[ params.size ] = "teleport_type";
    params[ params.size ] = "Objective";
    params[ params.size ] = "teleport_target";
    params[ params.size ] = var_38e2c746c80924e1;
    params[ params.size ] = "success";
    
    switch ( var_38e2c746c80924e1 )
    {
        case #"hash_d6a050caa23f4f81":
            if ( isdefined( level.br_armory_kiosk ) && level.br_armory_kiosk.scriptables.size > 0 )
            {
                playerorigin = function_c111a8465fa52332( level.br_armory_kiosk.scriptables, 100 );
                player function_852452aebf0743d5( playerorigin );
                params[ params.size ] = 1;
                player playlocalsound( "ui_select_purchase_confirm" );
                player phoenix_printlog( "phx_teleport", params );
                player phoenix_dlogevent( "teleport", "buystation", 1 );
            }
            else if ( isdefined( level.common_armory_kiosk.var_940cbeb74e784467 ) && level.common_armory_kiosk.var_940cbeb74e784467.size > 0 )
            {
                playerorigin = function_c111a8465fa52332( level.common_armory_kiosk.var_940cbeb74e784467, 100 );
                player function_852452aebf0743d5( playerorigin );
                params[ params.size ] = 1;
                player playlocalsound( "ui_select_purchase_confirm" );
                player phoenix_printlog( "phx_teleport", params );
                player phoenix_dlogevent( "teleport", "buystation", 1 );
            }
            else
            {
                params[ params.size ] = 0;
                player playlocalsound( "fly_pickup_deny" );
                player phoenix_printlog( "phx_teleport", params );
                player phoenix_dlogevent( "teleport", "buystation", 0 );
            }
            
            break;
        case #"hash_beb0467de4253023":
            if ( isdefined( level.fortressstruct ) && isdefined( level.fortressstruct.chosenfortresses ) && level.fortressstruct.chosenfortresses.size > 0 )
            {
                strongholdorigin = function_c111a8465fa52332( level.fortressstruct.chosenfortresses, 700 );
                playerorigin = getclosestpointonnavmesh( strongholdorigin );
                player function_852452aebf0743d5( playerorigin );
                params[ params.size ] = 1;
                player playlocalsound( "ui_select_purchase_confirm" );
                player phoenix_printlog( "phx_teleport", params );
                player phoenix_dlogevent( "teleport", "stronghold", 1 );
            }
            else
            {
                params[ params.size ] = 0;
                player playlocalsound( "fly_pickup_deny" );
                player phoenix_printlog( "phx_teleport", params );
                player phoenix_dlogevent( "teleport", "stronghold", 0 );
            }
            
            break;
        case #"hash_fa18b9f6bd576aff":
            agents = function_3b71aa1bfab81002( "activeWarzone" );
            
            if ( isdefined( agents ) && agents.size > 0 )
            {
                playerorigin = function_c111a8465fa52332( agents, 900 );
                player function_852452aebf0743d5( playerorigin );
                params[ params.size ] = 1;
                player playlocalsound( "ui_select_purchase_confirm" );
                player phoenix_printlog( "phx_teleport", params );
                player phoenix_dlogevent( "teleport", "active_wz", 1 );
            }
            else
            {
                params[ params.size ] = 0;
                player playlocalsound( "fly_pickup_deny" );
                player phoenix_printlog( "phx_teleport", params );
                player phoenix_dlogevent( "teleport", "active_wz", 0 );
            }
            
            break;
        default:
            break;
    }
}

// Namespace br_dev_phoenix
// Params 2
// Checksum 0x5bf3d5ff, Offset: 0x1c98
// Size: 0xbe
function function_c111a8465fa52332( var_30b3dc22aa725f31, extraheight )
{
    if ( level.br_circle_disabled )
    {
        object = utility::array_get_first_item( var_30b3dc22aa725f31 );
        playerorigin = object.origin + ( 0, 0, extraheight );
        return playerorigin;
    }
    
    var_629b68b71e024697 = 1;
    playerorigin = utility::array_random( var_30b3dc22aa725f31 ).origin;
    attempts = 30;
    
    while ( var_629b68b71e024697 )
    {
        attempts--;
        
        if ( attempts <= 0 )
        {
            break;
        }
        
        playerorigin = utility::array_random( var_30b3dc22aa725f31 ).origin + ( 0, 0, extraheight );
        
        if ( br_circle::ispointincurrentsafecircle( playerorigin ) )
        {
            var_629b68b71e024697 = 0;
        }
    }
    
    return playerorigin;
}

// Namespace br_dev_phoenix
// Params 1
// Checksum 0x2899432d, Offset: 0x1d5f
// Size: 0xf8
function function_b3be92693b8de650( var_38e2c746c80924e1 )
{
    player = self;
    mappedvehiclename = function_d1b9ce828b615d25( var_38e2c746c80924e1 );
    playerorigin = function_e1745b31e165e350( mappedvehiclename );
    params = [];
    params[ params.size ] = "teleport_type";
    params[ params.size ] = "Vehicle";
    params[ params.size ] = "teleport_target";
    params[ params.size ] = mappedvehiclename;
    params[ params.size ] = "success";
    
    if ( isdefined( playerorigin ) )
    {
        player function_852452aebf0743d5( playerorigin );
        params[ params.size ] = 1;
        player playlocalsound( "ui_select_purchase_confirm" );
        player phoenix_printlog( "phx_teleport", params );
        player phoenix_dlogevent( "teleport", var_38e2c746c80924e1, 1 );
        return;
    }
    
    params[ params.size ] = 0;
    player playlocalsound( "fly_pickup_deny" );
    player phoenix_printlog( "phx_teleport", params );
    player phoenix_dlogevent( "teleport", var_38e2c746c80924e1, 0 );
}

// Namespace br_dev_phoenix
// Params 1
// Checksum 0x56a1b8e5, Offset: 0x1e5f
// Size: 0xbe
function function_e1745b31e165e350( var_38e2c746c80924e1 )
{
    playerorigin = undefined;
    
    if ( isdefined( level.vehicle.instances ) )
    {
        foreach ( vehicleref, var_b62aa59a8dd1456a in level.vehicle.instances )
        {
            if ( vehicleref == var_38e2c746c80924e1 )
            {
                playerorigin = function_c111a8465fa52332( var_b62aa59a8dd1456a, 90 );
                return playerorigin;
            }
        }
    }
}

// Namespace br_dev_phoenix
// Params 1
// Checksum 0x1c29ce36, Offset: 0x1f25
// Size: 0xf8
function function_890574330fae3332( var_38e2c746c80924e1 )
{
    player = self;
    var_8560a162f4651858 = function_1dab678557e739db( var_38e2c746c80924e1 );
    playerorigin = function_1643e6de4f0b38ba( var_8560a162f4651858 );
    params = [];
    params[ params.size ] = "teleport_type";
    params[ params.size ] = "Contract";
    params[ params.size ] = "teleport_target";
    params[ params.size ] = var_8560a162f4651858;
    params[ params.size ] = "success";
    
    if ( isdefined( playerorigin ) )
    {
        player function_852452aebf0743d5( playerorigin );
        params[ params.size ] = 1;
        player playlocalsound( "ui_select_purchase_confirm" );
        player phoenix_printlog( "phx_teleport", params );
        player phoenix_dlogevent( "teleport", var_38e2c746c80924e1, 1 );
        return;
    }
    
    params[ params.size ] = 0;
    player playlocalsound( "fly_pickup_deny" );
    player phoenix_printlog( "phx_teleport", params );
    player phoenix_dlogevent( "teleport", var_38e2c746c80924e1, 0 );
}

// Namespace br_dev_phoenix
// Params 1
// Checksum 0x2cc4d759, Offset: 0x2025
// Size: 0xe3
function function_1643e6de4f0b38ba( var_38e2c746c80924e1 )
{
    if ( isdefined( level.contractmanager.activetablets ) )
    {
        foreach ( tablet in level.contractmanager.activetablets )
        {
            if ( tablet.type == var_38e2c746c80924e1 )
            {
                navmeshpoint = getclosestpointonnavmesh( tablet.origin );
                
                if ( !level.br_circle_disabled || br_circle::ispointincurrentsafecircle( navmeshpoint ) )
                {
                    return navmeshpoint;
                }
            }
        }
    }
}

// Namespace br_dev_phoenix
// Params 1
// Checksum 0xc7aa2477, Offset: 0x2110
// Size: 0x82
function function_1dab678557e739db( var_38e2c746c80924e1 )
{
    switch ( var_38e2c746c80924e1 )
    {
        case #"hash_973d1db8b6644466":
            return "brloot_assassination_phone";
        case #"hash_d6b0aad9e5d85db2":
            return "brloot_elite_arrow_phone";
        case #"hash_f5ec2f86008e0bc0":
            return "brloot_vip_phone";
        case #"hash_d22bc78737d8a069":
            return "brloot_safecracker_phone";
        case #"hash_bf5597954aaed3d7":
            return "brloot_intel_phone";
        default:
            return "";
    }
}

// Namespace br_dev_phoenix
// Params 1
// Checksum 0xc81a69e9, Offset: 0x219a
// Size: 0x94
function function_d1b9ce828b615d25( var_38e2c746c80924e1 )
{
    switch ( var_38e2c746c80924e1 )
    {
        case #"hash_1a86166c17e05dc1":
            return "veh9_sedan_hatchback_1985";
        case #"hash_7ec20b2ed0c1c55b":
            return "veh9_patrol_boat";
        case #"hash_b111a4547c7d9125":
            return "little_bird";
        case #"hash_c662d84c73daa0a8":
            return "veh9_techo_rebel_armor";
        case #"hash_1437f66e1532d8e9":
            return "veh9_apc_8x8";
        case #"hash_6322326c3d8587ce":
            return "veh9_utv";
        default:
            return "";
    }
}

// Namespace br_dev_phoenix
// Params 1
// Checksum 0xb902bab0, Offset: 0x2236
// Size: 0x19
function function_e651688b0b72af9( var_38e2c746c80924e1 )
{
    player = self;
}

// Namespace br_dev_phoenix
// Params 0
// Checksum 0x310771a, Offset: 0x2257
// Size: 0x13e
function function_d4ef6109d34ac74()
{
    player = self;
    c130height = parachute::getc130height();
    playerorigin = ( player.origin[ 0 ], player.origin[ 1 ], c130height );
    params = [];
    params[ params.size ] = "teleport_type";
    params[ params.size ] = "Air";
    params[ params.size ] = "teleport_target";
    params[ params.size ] = "Center Map";
    params[ params.size ] = "success";
    
    if ( isdefined( playerorigin ) )
    {
        player function_852452aebf0743d5( playerorigin );
        params[ params.size ] = 1;
        falltime = 0;
        
        if ( isdefined( level.parachutedeploydelay ) )
        {
            falltime = level.parachutedeploydelay;
        }
        
        player thread parachute::startfreefall( falltime, 0, undefined, undefined, 1 );
        player playlocalsound( "ui_select_purchase_confirm" );
        player phoenix_printlog( "phx_teleport", params );
        player phoenix_dlogevent( "teleport", "air", 1 );
        return;
    }
    
    params[ params.size ] = 0;
    player playlocalsound( "fly_pickup_deny" );
    player phoenix_printlog( "phx_teleport", params );
    player phoenix_dlogevent( "teleport", "air", 0 );
}

// Namespace br_dev_phoenix
// Params 1
// Checksum 0x44325e49, Offset: 0x239d
// Size: 0x1b5
function function_d7b5f77add23d015( var_38e2c746c80924e1 )
{
    player = self;
    params = [];
    params[ params.size ] = "teleport_type";
    params[ params.size ] = "Player";
    params[ params.size ] = "teleport_target";
    params[ params.size ] = var_38e2c746c80924e1;
    params[ params.size ] = "success";
    playerfound = undefined;
    
    foreach ( p in level.players )
    {
        if ( tolower( p.name ) == tolower( var_38e2c746c80924e1 ) )
        {
            playerfound = p;
            break;
        }
        
        if ( issubstr( tolower( p.name ), tolower( var_38e2c746c80924e1 ) ) )
        {
            playerfound = p;
            break;
        }
    }
    
    if ( isdefined( playerfound ) )
    {
        navmeshpoint = getclosestpointonnavmesh( playerfound.origin + ( 50, 50, 0 ) );
        player function_852452aebf0743d5( navmeshpoint );
        params[ params.size ] = 1;
        player playlocalsound( "ui_select_purchase_confirm" );
        player phoenix_printlog( "phx_teleport", params );
        player phoenix_dlogevent( "teleport", var_38e2c746c80924e1, 1 );
        return;
    }
    
    params[ params.size ] = 0;
    player playlocalsound( "fly_pickup_deny" );
    player phoenix_printlog( "phx_teleport", params );
    player phoenix_dlogevent( "teleport", var_38e2c746c80924e1, 0 );
}

// Namespace br_dev_phoenix
// Params 1
// Checksum 0x90d66b94, Offset: 0x255a
// Size: 0x3b
function function_852452aebf0743d5( location )
{
    player = self;
    player setpredictedstreamloaddist( 0 );
    player streamhint::playerstreamhintlocation( location );
    player setorigin( location, 1, 1 );
}

// Namespace br_dev_phoenix
// Params 0
// Checksum 0xf010d66f, Offset: 0x259d
// Size: 0x55a
function phoenix_spectator()
{
    player = self;
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    
    if ( player.phoenixspectating || !level.br_prematchstarted )
    {
        player playlocalsound( "fly_pickup_deny" );
        return;
    }
    
    if ( !isalive( player ) && !player br_public::isplayerinorgoingtogulag() )
    {
        teammate = player;
        teammates = level.teamdata[ player.team ][ "players" ];
        
        foreach ( p in teammates )
        {
            if ( p == player )
            {
                continue;
            }
            
            teammate = p;
        }
        
        if ( isdefined( teammate ) )
        {
            teammate = teammates[ 0 ];
            teammate br_pickups::addrespawntoken( 1 );
            player thread br_gulag::playergulagautowin( "phoenix", teammate, 1, 1 );
            wait 8;
            
            if ( !isdefined( player ) )
            {
                return;
            }
        }
    }
    
    player.phoenixspectating = 1;
    player playlocalsound( "ui_select_purchase_confirm" );
    player phoenix_printlog( "phx_spectator" );
    player phoenix_dlogevent( "spectator", "spectator_self", 1 );
    
    if ( isdefined( level.parachuterestoreweaponscb ) )
    {
        player [[ level.parachuterestoreweaponscb ]]();
    }
    
    player player_utility::function_dbe5a52a6654a982( 1 );
    player player_utility::function_9d378d725bb4831e( "br_dev_phoenix::phoenix_spectator()" );
    player sethidenameplate( 1 );
    player setthreatbiasgroup();
    var_992bb763319f789b = player.origin;
    uavowner = player;
    uavtype = "directional_uav";
    uaventityless = 1;
    uavduration = 9999;
    streakinfo = killstreak_utility::createstreakinfo( "directional_uav", player );
    streakinfo.skipequippedstreakcheck = 1;
    uav::uav_create( var_992bb763319f789b, uavowner, uavtype, streakinfo, uaventityless, uavduration );
    var_54745f5d4457de70 = br_assassination_quest::function_8225394f018d1121();
    var_b2bda848c0b13a5f = br_vip_quest::function_8225394f018d1121();
    
    if ( var_54745f5d4457de70 )
    {
        quests = br_quest_util::getquestdata( "assassination" );
        instancebounty = undefined;
        
        if ( isdefined( quests ) )
        {
            foreach ( instance in quests.instances )
            {
                if ( instance.targetteam == player.team )
                {
                    instancebounty = instance;
                }
            }
        }
        
        instancebounty br_assassination_quest::quest_onplayerdisconnect( player );
    }
    
    if ( var_b2bda848c0b13a5f )
    {
        player thread br_vip_quest::function_70920ea0d73dd21c( 0 );
    }
    
    player.gulaguses = 50;
    player.plotarmor = 1;
    br_utility::markplayeraseliminated( player, "phoenix_spectator" );
    player playerlogic::removefromlivescount();
    br::shutdowngulagforalivecount();
    [ brbonusxp, var_245a2f5a93850587, var_33c0e792d2053e19 ] = player br::calculatebrbonusxp( 150, player.team );
    
    if ( brbonusxp > 0 )
    {
        player br::givebrbonusxp( brbonusxp, undefined, "disconnect" );
        player.matchbonus = var_245a2f5a93850587;
        player.placementbonus = var_33c0e792d2053e19;
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"seasonalevents" ][ #"hash_8952a213e730d2de" ];
        
        if ( var_32dbca3143d9c4a5 && player [[ var_32dbca3143d9c4a5 ]]() )
        {
            gamelogic_mp::function_a7f2ba55c82bfa95( player );
        }
    }
    
    player br::droponplayerdeath();
    player br::setplacementstats( 150 );
    gamelogic_mp::_setplayerteamrank( player, 150 );
    br::updateclientmatchdata( player );
    level thread br::updateplayerandteamcountui();
    level notify( #"player_killed" );
    player playerlogic::removeplayerondisconnect();
    player game_utility_common::removefromparticipantsarray();
    player game_utility_common::removefromcharactersarray();
    player player_utility::removefromdismembermentlist();
    
    if ( isdefined( player.team ) )
    {
        player playerlogic::removefromteamcount();
        
        if ( arraycontains( level.teamdata[ player.team ][ "alivePlayers" ], player ) )
        {
            playerlogic::removefromalivecount( 1, "disconnect" );
            teams::validatealivecount( "disconnect", player.team, player );
        }
    }
    
    team_assimilation::function_aa6d43748d8cc8f4( player, "permanent" );
    
    if ( level.gameended )
    {
        player gamescore::removedisconnectedplayerfromplacement();
    }
    
    aliveplayers = teams::getteamdata( player.team, "alivePlayers" );
    
    if ( aliveplayers.size == 1 )
    {
        thread br::onteameliminated( player.team );
        gamelogic_mp::default_ondeadevent( player.team );
    }
}

// Namespace br_dev_phoenix
// Params 2
// Checksum 0x449e2ff2, Offset: 0x2aff
// Size: 0x83
function function_52b04ca9882db97e( var_f3312996d37da505, var_3df065893600d281 )
{
    player = self;
    params = [];
    params[ params.size ] = "bug_text";
    params[ params.size ] = var_3df065893600d281;
    params[ params.size ] = "success";
    params[ params.size ] = 1;
    player playlocalsound( "ui_select_purchase_confirm" );
    player phoenix_printlog( "phx_report_bug", params );
    player phoenix_dlogevent( "report_bug", "report_bug", 1 );
}

// Namespace br_dev_phoenix
// Params 1
// Checksum 0xb775723a, Offset: 0x2b8a
// Size: 0x10d
function phoenix_spawnitem( var_49e5f96516c95f22 )
{
    player = self;
    var_a2df0c82c76f136f = loot::getScriptableFromLootID( int( var_49e5f96516c95f22 ) );
    
    if ( !isdefined( var_a2df0c82c76f136f ) || var_a2df0c82c76f136f == "" )
    {
        player playlocalsound( "fly_pickup_deny" );
        return;
    }
    
    spawnpos = player.origin + anglestoforward( player.angles ) * 80 + ( 0, 0, 12 );
    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( spawnpos );
    itembundle = common_item::function_80af1e9daffacc7d( var_a2df0c82c76f136f );
    itemcount = undefined;
    
    if ( itembundle.subtype == "cash" )
    {
        itemcount = 4 * common_item::function_ea3b3088d82fd357( itembundle, spawnoptions );
    }
    
    common_item::function_61c2c0251e742ffd( itembundle, itemcount, spawnoptions );
    player playlocalsound( "ui_select_purchase_confirm" );
    player phoenix_printlog( "phx_spawn_item" );
    player phoenix_dlogevent( "spawn_item", var_a2df0c82c76f136f, 1 );
}

// Namespace br_dev_phoenix
// Params 1
// Checksum 0xdbd5bac5, Offset: 0x2c9f
// Size: 0x7d
function function_2625acdd7525078c( var_49e5f96516c95f22 )
{
    if ( !tableexists( "mp/phoenix_loot_spawns.csv" ) )
    {
        return "";
    }
    
    var_ad9cb6ed4c6a08ac = tablelookup( "mp/phoenix_loot_spawns.csv", 0, var_49e5f96516c95f22, 1 );
    var_9a9a6c52101f7a60 = tablelookup( "mp/phoenix_loot_spawns.csv", 0, var_49e5f96516c95f22, 2 );
    
    if ( !( isdefined( var_ad9cb6ed4c6a08ac ) && isdefined( var_9a9a6c52101f7a60 ) ) )
    {
        var_ad9cb6ed4c6a08ac = "";
        var_9a9a6c52101f7a60 = "";
    }
    
    return [ var_9a9a6c52101f7a60, tolower( var_ad9cb6ed4c6a08ac ) ];
}

// Namespace br_dev_phoenix
// Params 2
// Checksum 0x6b26dd87, Offset: 0x2d25
// Size: 0x312
function phoenix_printlog( type, params )
{
    if ( getdvarint( @"hash_88f35895cd0e137f", 1 ) )
    {
        stringtoprint = self.name;
        
        switch ( type )
        {
            case #"hash_d10dfc9ce7eaf70c":
                stringtoprint += " respawned";
                break;
            case #"hash_1edd30af4e8b4f2":
                stringtoprint += " added gulag try";
                break;
            case #"hash_4f35658654dbef96":
                stringtoprint += " logged player info";
                break;
            case #"hash_5902810481a12a54":
                stringtoprint += " became AFK";
                break;
            case #"hash_a94de925f6ae81b7":
                stringtoprint += " toggled 3rd person";
                break;
            case #"hash_cde3b66436b549d3":
                stringtoprint += " teleported";
                break;
            case #"hash_d2f305d005b70205":
                stringtoprint += " became spectator";
                break;
            case #"hash_a4372a9927732a8b":
                stringtoprint += " reported bug";
                break;
            case #"hash_71869d25fdf5e767":
                stringtoprint += " spawned item";
                break;
            case #"hash_911afdff14f6cbc9":
                stringtoprint += " cleared debug text";
                break;
            case #"hash_f3926178936396e7":
                stringtoprint += " spectates #1 player";
                break;
            default:
                stringtoprint += " activated dev feature";
                break;
        }
        
        stringtoprint += " via Playtest Tool.";
        iprintln( stringtoprint );
    }
    
    if ( !getdvarint( @"hash_97d81bda0ebee89a", 0 ) )
    {
        return;
    }
    
    delim = "^Z^";
    str = "[PHOENIX] ";
    str += type + delim;
    str += "time" + delim;
    str += gettime() / 1000 + delim;
    str += "player_name" + delim;
    str += self.name + delim;
    str += "match_id" + delim;
    str += getonlinematchid();
    
    if ( isdefined( params ) )
    {
        if ( params.size > 0 )
        {
            str += delim;
        }
        
        idx = 0;
        
        while ( idx + 1 < params.size )
        {
            key = params[ idx ];
            val = params[ idx + 1 ];
            str += key + delim;
            
            if ( !isdefined( val ) )
            {
                str += "undefined";
            }
            else if ( isstruct( val ) )
            {
                str += "struct";
            }
            else if ( isint( val ) || isfloat( val ) || isstring( val ) )
            {
                str += val;
            }
            else if ( isvector( val ) )
            {
                str += "[" + val[ 0 ] + "," + val[ 1 ] + "," + val[ 2 ] + "]";
            }
            else
            {
                str += "\"PHOENIX_TYPE_ERROR\"";
            }
            
            if ( idx + 2 < params.size )
            {
                str += delim;
            }
            
            idx += 2;
        }
    }
    
    logstring( str );
}

// Namespace br_dev_phoenix
// Params 0
// Checksum 0x1070dcfe, Offset: 0x303f
// Size: 0x3e
function function_f2dfe2e42e36522d()
{
    player = self;
    player playlocalsound( "ui_select_purchase_confirm" );
    player phoenix_printlog( "phx_clear_debug" );
    player phoenix_dlogevent( "clear_debug", "clear_debug", 1 );
}

// Namespace br_dev_phoenix
// Params 0
// Checksum 0x6aac10e8, Offset: 0x3085
// Size: 0xa7
function function_26766fc312653351()
{
    player = self;
    targetplayertospectate = player function_58f492083bec4b36();
    
    if ( !isdefined( targetplayertospectate ) || player == targetplayertospectate )
    {
        player playlocalsound( "fly_pickup_deny" );
        player phoenix_dlogevent( "spectate_top", "spectate_top", 0 );
        return;
    }
    
    player playlocalsound( "ui_select_purchase_confirm" );
    player phoenix_printlog( "phx_spectate" );
    player phoenix_dlogevent( "spectate_top", "spectate_top", 1 );
    
    if ( player getspectatingplayer() == targetplayertospectate )
    {
        return;
    }
    
    if ( isalive( player ) )
    {
        player kill();
    }
    
    br_spectate::assignspectatortospectateplayer( player, targetplayertospectate );
}

// Namespace br_dev_phoenix
// Params 0
// Checksum 0x3cfda9fe, Offset: 0x3134
// Size: 0xc5
function function_58f492083bec4b36()
{
    player = self;
    highestkills = 0;
    var_c2e68ceb38b7320a = player;
    
    foreach ( p in level.players )
    {
        if ( !isalive( p ) )
        {
            continue;
        }
        
        if ( p.kills >= highestkills )
        {
            highestkills = p.kills;
            var_c2e68ceb38b7320a = p;
        }
    }
    
    return var_c2e68ceb38b7320a;
}

// Namespace br_dev_phoenix
// Params 3
// Checksum 0xea300e2b, Offset: 0x3202
// Size: 0x252
function phoenix_dlogevent( var_bac8d56b4efdb00c, targetnamecommand, successcommand )
{
    player = self;
    eventparams = [];
    eventparams[ eventparams.size ] = "game_time";
    currenttime = gettime() / ( 1000 ?? 0 );
    eventparams[ eventparams.size ] = currenttime;
    eventparams[ eventparams.size ] = "num_player_used_command";
    var_c8c93a2112c51b90 = player.var_af699ab3fa68a2a5 ?? 1;
    eventparams[ eventparams.size ] = var_c8c93a2112c51b90;
    eventparams[ eventparams.size ] = "player_using_controller";
    var_eb281fc9c72e83aa = player usinggamepad() ?? 0;
    eventparams[ eventparams.size ] = var_eb281fc9c72e83aa;
    eventparams[ eventparams.size ] = "game_type";
    currentgametype = game_utility::getgametype() ?? "";
    eventparams[ eventparams.size ] = currentgametype;
    eventparams[ eventparams.size ] = "num_players_match";
    var_6a4ca50b8dd4f251 = int( level.players.size ) ?? 0;
    eventparams[ eventparams.size ] = var_6a4ca50b8dd4f251;
    eventparams[ eventparams.size ] = "map_name";
    mapname = level.mapname ?? "";
    eventparams[ eventparams.size ] = mapname;
    eventparams[ eventparams.size ] = "playlist_id";
    playlistid = getplaylistid() ?? 0;
    eventparams[ eventparams.size ] = playlistid;
    eventparams[ eventparams.size ] = "playlist_name";
    var_26c7fe44e2669ceb = getplaylistname() ?? "";
    eventparams[ eventparams.size ] = var_26c7fe44e2669ceb;
    eventparams[ eventparams.size ] = "player_name_used";
    playername = "_" + ( tolower( player.name ) ?? "" );
    eventparams[ eventparams.size ] = playername;
    eventparams[ eventparams.size ] = "player_name_used_on";
    playerusedon = "_" + ( tolower( player.name ) ?? "" );
    eventparams[ eventparams.size ] = playerusedon;
    eventparams[ eventparams.size ] = "command_type";
    eventparams[ eventparams.size ] = var_bac8d56b4efdb00c ?? "";
    eventparams[ eventparams.size ] = "target_name_command";
    eventparams[ eventparams.size ] = targetnamecommand ?? "";
    eventparams[ eventparams.size ] = "command_success";
    eventparams[ eventparams.size ] = successcommand ?? 0;
    player dlog_recordplayerevent( "dlog_event_phoenix_dev", eventparams );
}

// Namespace br_dev_phoenix
// Params 0
// Checksum 0xdcfe6e94, Offset: 0x345c
// Size: 0x29b
function function_5363d30f7db7284f()
{
    if ( !level.var_5363d30f7db7284f )
    {
        return;
    }
    
    level waittill( #"prematch_done" );
    prematchduration = int( gettime() / 1000 );
    matchstart = gettime();
    soloteams = 0;
    duoteams = 0;
    trioteams = 0;
    quadteams = 0;
    
    foreach ( specificteam in level.teamdata )
    {
        if ( isdefined( specificteam[ "teamCount" ] ) )
        {
            switch ( specificteam[ "teamCount" ] )
            {
                case 1:
                    soloteams++;
                    break;
                case 2:
                    duoteams++;
                    break;
                case 3:
                    trioteams++;
                    break;
                case 4:
                    quadteams++;
                    break;
                default:
                    break;
            }
        }
    }
    
    eventparams = [];
    eventparams[ eventparams.size ] = "sub_game_type";
    eventparams[ eventparams.size ] = game_utility::getgametype();
    playlist_id = 0;
    playlist_name = "";
    
    if ( game_utility_mp::matchmakinggame() )
    {
        playlist_id = getplaylistid();
        playlist_name = getplaylistname();
    }
    
    eventparams[ eventparams.size ] = "playlist_id";
    eventparams[ eventparams.size ] = playlist_id;
    eventparams[ eventparams.size ] = "playlist_name";
    eventparams[ eventparams.size ] = playlist_name;
    eventparams[ eventparams.size ] = "prematch_duration";
    eventparams[ eventparams.size ] = prematchduration;
    eventparams[ eventparams.size ] = "num_players";
    eventparams[ eventparams.size ] = int( level.players.size );
    eventparams[ eventparams.size ] = "num_solo_teams";
    eventparams[ eventparams.size ] = soloteams;
    eventparams[ eventparams.size ] = "num_duo_teams";
    eventparams[ eventparams.size ] = duoteams;
    eventparams[ eventparams.size ] = "num_trio_teams";
    eventparams[ eventparams.size ] = trioteams;
    eventparams[ eventparams.size ] = "num_quad_teams";
    eventparams[ eventparams.size ] = quadteams;
    eventparams[ eventparams.size ] = "match_duration";
    eventparams[ eventparams.size ] = 0;
    dlog_recordevent( "dlog_event_playtest_data", eventparams );
    level utility::waittill_any( "game_ended", "game_cleanup" );
    matchduration = int( ( gettime() - matchstart ) / 1000 );
    eventparams[ eventparams.size - 1 ] = matchduration;
    dlog_recordevent( "dlog_event_playtest_data", eventparams );
}

