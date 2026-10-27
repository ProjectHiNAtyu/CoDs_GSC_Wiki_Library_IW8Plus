// scripts\mp\ftue\br\ftue_mission_zero.gsc  (hash_66e2848255f003a2.gscc) (size: 4979 Bytes / 0x1373 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5b01449d (1526809757)
// size ...... 4979 (0x1373)
// includes .. 13  (offset: 0x120b)
// strings ... 21  (offset: 0x1273)
// dev strs .. 0   (offset: 0x1373)
// exports ... 23  (offset: 0x967)
// cseg ...... 0x1e5 + 0x782 (0x967)
// imports ... 43  (offset: 0xcff)
// animtree1 . 0   (offset: 0x1373)
// animtree2 . 0   (offset: 0x1373)
#using script_239a365a92ee4476;
#using script_45e6947be98e16e3;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\armor;
#using scripts\mp\br\br_activity_util;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\ftue\utility\ftue_loadout;
#using scripts\mp\ftue\utility\ftue_player;
#using scripts\mp\ftue\utility\ftue_tip;

#namespace ftue_mission_zero;

// Namespace ftue_mission_zero
// Params 0, eflags: 0x5
// Checksum 0x505cefd6, Offset: 0x203
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_f1e30c37fc11d10a", #"br_ftue", undefined, &post_main );
}

// Namespace ftue_mission_zero
// Params 0
// Checksum 0xaf1234db, Offset: 0x22c
// Size: 0x3d
function post_main()
{
    if ( getdvarint( @"hash_f2fe1c66207a3882", 0 ) )
    {
        namespace_44e8cefed76aa88e::function_feeeaf4be5bd0641( &function_69d58ce278635296 );
        utility::registersharedfunc( #"ftue", #"hash_8003d8d4e79536cc", &function_fff9742a58fd8853 );
    }
}

// Namespace ftue_mission_zero
// Params 0
// Checksum 0xd02ce04e, Offset: 0x271
// Size: 0x152
function function_69d58ce278635296()
{
    ftue_tip::function_d454ba9425f5164c( 39, "matchTacmap" );
    ftue_tip::function_d454ba9425f5164c( 35, "matchMove", &function_5f40afcfabcc811a, &function_632d75591835138b );
    ftue_tip::function_d454ba9425f5164c( 40, "matchBuyStation", &condbuystation );
    ftue_tip::function_d454ba9425f5164c( 41, "matchContracts", &condcontracts );
    ftue_tip::function_d454ba9425f5164c( 42, "matchVehicle", &condvehicle );
    ftue_tip::function_d454ba9425f5164c( 43, "matchLoadoutDrops", &function_7defb44feb548fc0 );
    ftue_tip::function_d454ba9425f5164c( 44, "matchClosingCircle", &function_bbaacccd47ff41ad );
    ftue_tip::function_d454ba9425f5164c( 45, "matchKillEnemy", &function_b9acaaee6946028a );
    ftue_tip::function_d454ba9425f5164c( 46, "prematchArmorPlate", &condarmorplate );
    ftue_tip::function_d454ba9425f5164c( 50, "matchGulag", &condgulag );
    ftue_tip::function_d454ba9425f5164c( 51, "matchReviving", &function_f16e4bdf3fb607b5 );
    ftue_tip::function_d454ba9425f5164c( 52, "matchBuyBack", &condbuyback );
    ftue_tip::function_d454ba9425f5164c( 53, "matchStaticBuyStation" );
    ftue_tip::function_d454ba9425f5164c( 54, "matchStaticLoadoutDrop" );
    
    if ( getdvarint( @"hash_9ca05ad5a307aace", 0 ) == 1 )
    {
        ftue_tip::function_d454ba9425f5164c( 47, "TacMapBuyStation", undefined, &function_7f93fd816329d931 );
        ftue_tip::function_d454ba9425f5164c( 48, "TacMapContract", undefined, &function_9b2491591964413 );
        ftue_tip::function_d454ba9425f5164c( 49, "TacMapLoadoutDrop", undefined, &function_24b68ec2d75c94ca );
    }
}

// Namespace ftue_mission_zero
// Params 0
// Checksum 0x7aa5a39e, Offset: 0x3cb
// Size: 0x3, Type: bool
function function_fff9742a58fd8853()
{
    return false;
}

// Namespace ftue_mission_zero
// Params 1
// Checksum 0xfc9ae574, Offset: 0x3d7
// Size: 0x11
function function_5f40afcfabcc811a( params )
{
    return self isonground();
}

// Namespace ftue_mission_zero
// Params 2
// Checksum 0xae36dcbd, Offset: 0x3f1
// Size: 0x69
function function_632d75591835138b( tipid, notificationid )
{
    self setftuetipid( level.ftuetips_table[ #"prematchshoot" ].id );
    waitframe();
    self setftuetipid( level.ftuetips_table[ #"prematchmove" ].id );
    waitframe();
    self notify( #"currentContextualTipCompleted" );
}

// Namespace ftue_mission_zero
// Params 1
// Checksum 0x31bb7a40, Offset: 0x462
// Size: 0x15, Type: bool
function condbuystation( params )
{
    return namespace_727c07157c884ff5::function_ab3300532cd9a40f( 1500 );
}

// Namespace ftue_mission_zero
// Params 1
// Checksum 0x2750a35d, Offset: 0x480
// Size: 0x24, Type: bool
function condcontracts( params )
{
    tablet = br_activity_util::function_68f2ccbc07be54d( 1000 );
    return isdefined( tablet );
}

// Namespace ftue_mission_zero
// Params 1
// Checksum 0x54191991, Offset: 0x4ad
// Size: 0x23
function condvehicle( params )
{
    vehicle = vehicle::is_near_vehicle( 3500 );
    return vehicle;
}

// Namespace ftue_mission_zero
// Params 1
// Checksum 0x8a781cd7, Offset: 0x4d9
// Size: 0x47, Type: bool
function function_7defb44feb548fc0( params )
{
    var_83a852dd48d458ec = ftue_loadout::function_70e44dcf20375ded();
    
    if ( !var_83a852dd48d458ec )
    {
        return false;
    }
    
    var_e33007e788481556 = sortbydistancecullbyradius( var_83a852dd48d458ec, self.origin, 3500 );
    return var_e33007e788481556.size > 0;
}

// Namespace ftue_mission_zero
// Params 1
// Checksum 0xcaa663e, Offset: 0x529
// Size: 0x22, Type: bool
function function_bbaacccd47ff41ad( params )
{
    return level.br_circle.circleindex >= 1;
}

// Namespace ftue_mission_zero
// Params 1
// Checksum 0xe293cd7e, Offset: 0x554
// Size: 0x22, Type: bool
function function_b9acaaee6946028a( params )
{
    return level.br_circle.circleindex >= 2;
}

// Namespace ftue_mission_zero
// Params 1
// Checksum 0x93d5addd, Offset: 0x57f
// Size: 0x14, Type: bool
function condarmorplate( params )
{
    return armor::function_22290101992e4874() > 0;
}

// Namespace ftue_mission_zero
// Params 1
// Checksum 0x9eeddd5c, Offset: 0x59c
// Size: 0x12, Type: bool
function condgulag( params )
{
    return br_public::isplayeringulag();
}

// Namespace ftue_mission_zero
// Params 1
// Checksum 0xebcf7c7c, Offset: 0x5b7
// Size: 0xad, Type: bool
function function_f16e4bdf3fb607b5( params )
{
    if ( self.team )
    {
        foreach ( player in teams::getteamdata( self.team, "players" ) )
        {
            if ( player != self && player.inlaststand )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace ftue_mission_zero
// Params 1
// Checksum 0xe1fceee5, Offset: 0x66d
// Size: 0xb7, Type: bool
function condbuyback( params )
{
    if ( self.team )
    {
        foreach ( player in teams::getteamdata( self.team, "players" ) )
        {
            if ( player != self )
            {
                if ( !player::isreallyalive( player ) && !player ftue_player::function_9d071da696dadadd() )
                {
                    return true;
                }
            }
        }
    }
    
    return false;
}

// Namespace ftue_mission_zero
// Params 0
// Checksum 0x1f759aa, Offset: 0x72d
// Size: 0x9f
function function_20e8ed5be7df8b43()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    level endon( #"endgame" );
    
    for ( var_fbcf925a4a966dfd = 0; !var_fbcf925a4a966dfd ; var_fbcf925a4a966dfd = 1 )
    {
        self waittill( #"luinotifyserver", channel, class );
        
        if ( channel == "buy_menu_option_selected" || channel == "buy_menu_open" )
        {
        }
    }
    
    ftue_tip::function_c9cca7ed21647155( #"buy_station" );
    waitframe();
    ftue_tip::function_e1b6c8c6f8f3dc45( 1 );
    waitframe();
    self notify( #"currentContextualTipCompleted" );
}

// Namespace ftue_mission_zero
// Params 2
// Checksum 0x8b591551, Offset: 0x7d4
// Size: 0x29
function function_7f93fd816329d931( tipid, notificationid )
{
    thread function_20e8ed5be7df8b43();
    waitframe();
    self notify( #"currentContextualTipCompleted" );
}

// Namespace ftue_mission_zero
// Params 0
// Checksum 0x435f127, Offset: 0x805
// Size: 0x70
function function_4de35be9d4e84087()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    var_6c7bdefb3a465f71 = 0;
    
    while ( !var_6c7bdefb3a465f71 )
    {
        var_6c7bdefb3a465f71 = self.activities.participatingactivities.size > 0;
        waitframe();
    }
    
    ftue_tip::function_c9cca7ed21647155( #"contract" );
    waitframe();
    ftue_tip::function_e1b6c8c6f8f3dc45( 1 );
    waitframe();
    self notify( #"currentContextualTipCompleted" );
}

// Namespace ftue_mission_zero
// Params 2
// Checksum 0x94bedc56, Offset: 0x87d
// Size: 0x29
function function_9b2491591964413( tipid, notificationid )
{
    thread function_4de35be9d4e84087();
    waitframe();
    self notify( #"currentContextualTipCompleted" );
}

// Namespace ftue_mission_zero
// Params 0
// Checksum 0xb967553c, Offset: 0x8ae
// Size: 0x88
function function_2b3c4208cb4eaf22()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    var_d531b5112faf946b = 0;
    
    while ( !var_d531b5112faf946b )
    {
        self waittill( #"luinotifyserver", channel, class );
        
        if ( channel == "open_loadout_bag" )
        {
            var_d531b5112faf946b = 1;
        }
        
        waitframe();
    }
    
    ftue_tip::function_c9cca7ed21647155( #"loadout_equip" );
    waitframe();
    ftue_tip::function_e1b6c8c6f8f3dc45( 1 );
    waitframe();
    self notify( #"currentContextualTipCompleted" );
}

// Namespace ftue_mission_zero
// Params 2
// Checksum 0x81375e46, Offset: 0x93e
// Size: 0x29
function function_24b68ec2d75c94ca( tipid, notificationid )
{
    thread function_2b3c4208cb4eaf22();
    waitframe();
    self notify( #"currentContextualTipCompleted" );
}

