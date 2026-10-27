// scripts\mp\br\gametypes\br_killstreaks.gsc  (hash_08706ed8c5212a15.gscc) (size: 3858 Bytes / 0xf12 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa7eb0ca8 (2817199272)
// size ...... 3858 (0xf12)
// includes .. 4   (offset: 0xe4a)
// strings ... 11  (offset: 0xe6a)
// dev strs .. 0   (offset: 0xf12)
// exports ... 13  (offset: 0x93e)
// cseg ...... 0x28a + 0x6b4 (0x93e)
// imports ... 27  (offset: 0xb46)
// animtree1 . 0   (offset: 0xf12)
// animtree2 . 0   (offset: 0xf12)
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\hud_util;

#namespace br_killstreaks;

// Namespace br_killstreaks
// Params 0
// Checksum 0xe90ae1d3, Offset: 0x2a8
// Size: 0x1a
function init()
{
    level.var_abfa95c246ced9c3 = getdvarint( @"hash_b59ab75a606e3255", 1 );
}

// Namespace br_killstreaks
// Params 0
// Checksum 0x82604942, Offset: 0x2ca
// Size: 0xd, Type: bool
function playercanpickupkillstreak()
{
    return !isdefined( self.brkillstreak );
}

// Namespace br_killstreaks
// Params 1
// Checksum 0x935d215b, Offset: 0x2e0
// Size: 0x5b
function takekillstreakpickup( pickupent )
{
    gamestring = level.br_pickups.br_equipname[ pickupent.scriptablename ];
    self.brkillstreak = gamestring;
    playerkillstreakhud( gamestring );
    playergivetriggerweapon();
    thread playerhandlekillstreak( gamestring );
}

// Namespace br_killstreaks
// Params 1
// Checksum 0xc202616b, Offset: 0x343
// Size: 0xe9
function playerkillstreakhud( streakname )
{
    self.brkillstreakhudlabel = hud_util::createfontstring( "default", 0.75 );
    self.brkillstreakhudlabel hud_util::setpoint( "CENTER", "BOTTOM LEFT", 270, -70 );
    self.brkillstreakhudlabel.label = &"mp/br_activate_killstreak";
    bundle = level.streakglobals.streakbundles[ streakname ];
    icon = isdefined( bundle ) && isdefined( bundle.hudicon ) ? bundle.var_beb3ca5439b2fee : "";
    self.brkillstreakhudicon = hud_util::createicon( icon, 30, 30 );
    self.brkillstreakhudicon hud_util::setpoint( "CENTER", "BOTTOM LEFT", 270, -45 );
}

// Namespace br_killstreaks
// Params 0
// Checksum 0xcc2c27ba, Offset: 0x434
// Size: 0x25
function playergivetriggerweapon()
{
    self giveweapon( "super_default_mp" );
    self setweaponammoclip( "super_default_mp", 1 );
    self assignweaponoffhandspecial( "super_default_mp" );
}

// Namespace br_killstreaks
// Params 1
// Checksum 0xab6e52f7, Offset: 0x461
// Size: 0x72
function playerhandlekillstreak( gamestring )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"special_weapon_fired", objweapon );
        result = playertriggerkillstreak();
        
        if ( result )
        {
            playerremovekillstreak();
            return;
        }
        
        self setweaponammoclip( "super_default_mp", 1 );
    }
}

// Namespace br_killstreaks
// Params 0
// Checksum 0x28d0f3a9, Offset: 0x4db
// Size: 0x3d, Type: bool
function playertriggerkillstreak()
{
    if ( !isalive( self ) )
    {
        return false;
    }
    
    struct = killstreaks::createstreakitemstruct( self.brkillstreak );
    result = killstreaks::triggerkillstreak( struct );
    return istrue( result );
}

// Namespace br_killstreaks
// Params 0
// Checksum 0xc4f4b8e8, Offset: 0x521
// Size: 0x4d
function playerremovekillstreak()
{
    self takeweapon( "super_default_mp" );
    self.brkillstreak = undefined;
    
    if ( isdefined( self.brkillstreakhudlabel ) )
    {
        self.brkillstreakhudlabel destroy();
    }
    
    if ( isdefined( self.brkillstreakhudicon ) )
    {
        self.brkillstreakhudicon destroy();
    }
}

// Namespace br_killstreaks
// Params 3
// Checksum 0x5d842c36, Offset: 0x576
// Size: 0xa5
function function_ba7d7d41b60cc61e( players, notifytype, timeoutoverride )
{
    if ( !isarray( players ) )
    {
        players = [ players ];
    }
    
    foreach ( player in players )
    {
        dangernotifyplayer( player, notifytype, timeoutoverride );
    }
}

// Namespace br_killstreaks
// Params 5
// Checksum 0xebe63cd4, Offset: 0x623
// Size: 0x233
function dangernotifyplayer( player, notifytype, timeoutoverride, isfriendlyplayer, owner )
{
    notifynumber = 0;
    
    switch ( notifytype )
    {
        case #"hash_b4ac3581c343a029":
            notifynumber = 1;
            break;
        case #"hash_8c766d6477287bb6":
            notifynumber = 2;
            break;
        case #"hash_256bff2a9cc092c8":
            notifynumber = 3;
            break;
        case #"hash_6f819beef2080ba9":
            notifynumber = 4;
            break;
        case #"hash_13b68af513c903e8":
            notifynumber = 5;
            break;
        case #"hash_80c5f88142053bf4":
            notifynumber = 6;
            break;
        case #"hash_72237571b4515421":
        case #"hash_b3b9048fbdb1c48f":
            notifynumber = 7;
            break;
        case #"hash_6cf2279b8aabef9f":
            notifynumber = 8;
            break;
        case #"hash_e71cf650b470aa20":
            notifynumber = 9;
            break;
        case #"hash_422614db7b615a5b":
            notifynumber = 10;
            break;
        case #"hash_eaa69e667c221114":
            notifynumber = 11;
            break;
        case #"hash_e5ede0f09328ea53":
            notifynumber = 12;
            break;
        case #"hash_ca1da21e366e13f":
        case #"hash_634b246c3da5c56f":
        case #"hash_e171e5b86ef0a4cc":
            notifynumber = 13;
            break;
        case #"hash_42fd64e842a4c3d7":
            notifynumber = 14;
            break;
        case #"hash_577495088db80465":
            notifynumber = 16;
            break;
        case #"hash_9956fc544449f64":
            notifynumber = 17;
            break;
        case #"hash_2cb2b7f44f2f6237":
            notifynumber = 18;
            break;
        case #"hash_568092dc521d2e1d":
            notifynumber = 19;
            break;
        default:
            break;
    }
    
    if ( notifynumber == 12 )
    {
        dialogalias = "uav_use_enemy_br";
        
        if ( isfriendlyplayer )
        {
            dialogalias = "uav_use_friendly_br";
        }
        
        level thread br_public::brleaderdialogplayer( dialogalias, player, 1, 0, 2 );
    }
    else
    {
        killstreak_utility::function_19118c649ca7f73e( player, notifytype, owner );
    }
    
    if ( notifynumber > 0 )
    {
        player setclientomnvar( "ui_br_danger_warning", notifynumber );
        dangernotifyresetforplayer( player, timeoutoverride );
    }
}

// Namespace br_killstreaks
// Params 2
// Checksum 0x9cae3f17, Offset: 0x85e
// Size: 0x59
function dangernotifyresetforplayer( player, timeoutoverride )
{
    playerid = player getxuid();
    
    if ( !isdefined( timeoutoverride ) )
    {
        timeoutoverride = 4;
    }
    
    level notify( "danger_notify_start_" + playerid );
    level thread watchdangerresetaction( player, playerid, "death_or_disconnect" );
    level thread watchdangerresetaction( player, playerid, undefined, timeoutoverride );
}

// Namespace br_killstreaks
// Params 4
// Checksum 0x1fbf48f7, Offset: 0x8bf
// Size: 0x7f
function watchdangerresetaction( player, playerid, action, timeout )
{
    level endon( "danger_notify_start_" + playerid );
    level endon( "danger_notify_finished_" + playerid );
    level endon( #"game_ended" );
    
    if ( isdefined( action ) )
    {
        player waittill( action );
    }
    else if ( isdefined( timeout ) )
    {
        wait timeout;
    }
    
    if ( isdefined( player ) )
    {
        player setclientomnvar( "ui_br_danger_warning", 0 );
    }
    
    level notify( "danger_notify_finished_" + playerid );
}

