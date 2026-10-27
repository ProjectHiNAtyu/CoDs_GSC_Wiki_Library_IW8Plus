// scripts\mp\largeuppernotification.gsc  (hash_188008b85f8b14d4.gscc) (size: 1419 Bytes / 0x58b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6a60db8d (1784732557)
// size ...... 1419 (0x58b)
// includes .. 0   (offset: 0x54f)
// strings ... 4   (offset: 0x54f)
// dev strs .. 0   (offset: 0x58b)
// exports ... 5   (offset: 0x3a3)
// cseg ...... 0x138 + 0x26b (0x3a3)
// imports ... 8   (offset: 0x46b)
// animtree1 . 0   (offset: 0x58b)
// animtree2 . 0   (offset: 0x58b)
#namespace largeuppernotification;

// Namespace largeuppernotification
// Params 3
// Checksum 0x4f3a0d4b, Offset: 0x156
// Size: 0xa5
function function_55220e3796325cea( players, notifytype, timeoutoverride )
{
    if ( !isarray( players ) )
    {
        players = [ players ];
    }
    
    foreach ( player in players )
    {
        function_b7d4e746940be91d( player, notifytype, timeoutoverride );
    }
}

// Namespace largeuppernotification
// Params 3
// Checksum 0xdeda12dc, Offset: 0x203
// Size: 0xb8
function function_b7d4e746940be91d( player, notifytype, timeoutoverride )
{
    switch ( notifytype )
    {
        case #"hash_ec031320eb0c7285":
            notifytype = 1;
            break;
        case #"hash_eb8c170bf600e214":
            notifytype = 2;
            break;
        case #"hash_772448618dee9a9":
            notifytype = 3;
            break;
        case #"hash_33270e8005317cc4":
            notifytype = 4;
            break;
        case #"hash_10eb6d629315a914":
            notifytype = 5;
            break;
        default:
            notifytype = 0;
            break;
    }
    
    if ( notifytype > 0 )
    {
        player setclientomnvar( "ui_upper_notification_type", notifytype );
        dangernotifyresetforplayer( player, timeoutoverride );
    }
}

// Namespace largeuppernotification
// Params 2
// Checksum 0xc3a37cba, Offset: 0x2c3
// Size: 0x59
function dangernotifyresetforplayer( player, timeoutoverride )
{
    playerid = player getxuid();
    
    if ( !isdefined( timeoutoverride ) )
    {
        timeoutoverride = 4;
    }
    
    level notify( "upper_notification_start_" + playerid );
    level thread watchdangerresetaction( player, playerid, "death_or_disconnect" );
    level thread watchdangerresetaction( player, playerid, undefined, timeoutoverride );
}

// Namespace largeuppernotification
// Params 4
// Checksum 0x6db0ba94, Offset: 0x324
// Size: 0x7f
function watchdangerresetaction( player, playerid, action, timeout )
{
    level endon( "upper_notification_start_" + playerid );
    level endon( "upper_notification_finished_" + playerid );
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
        player setclientomnvar( "ui_upper_notification_type", 0 );
    }
    
    level notify( "upper_notification_finished_" + playerid );
}

