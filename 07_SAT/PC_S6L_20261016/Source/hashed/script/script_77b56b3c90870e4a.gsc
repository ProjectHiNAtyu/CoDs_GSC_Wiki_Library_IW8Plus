// script_77b56b3c90870e4a  (hash_77b56b3c90870e4a.gscc) (size: 5974 Bytes / 0x1756 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4ae7461e (1256670750)
// size ...... 5974 (0x1756)
// includes .. 8   (offset: 0x1612)
// strings ... 14  (offset: 0x1652)
// dev strs .. 3   (offset: 0x1732)
// exports ... 11  (offset: 0xe96)
// cseg ...... 0x148 + 0xd4e (0xe96)
// imports ... 48  (offset: 0x104e)
// animtree1 . 0   (offset: 0x1756)
// animtree2 . 0   (offset: 0x1756)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_analytics;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\player;

#namespace activity_br_capture_point;

// Namespace activity_br_capture_point
// Params 0, eflags: 0x5
// Checksum 0x6f04f6f1, Offset: 0x166
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"activity_br_capture_point", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace activity_br_capture_point
// Params 0, eflags: 0x4
// Checksum 0xfb797bb3, Offset: 0x18f
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "BR_CAPTURE_POINT", &capture_point_activity_type_init );
}

// Namespace activity_br_capture_point
// Params 0
// Checksum 0x58834739, Offset: 0x1aa
// Size: 0x66
function capture_point_activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "BR_CAPTURE_POINT", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "BR_CAPTURE_POINT", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "BR_CAPTURE_POINT", 2, &activity_ended );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "BR_CAPTURE_POINT" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &player_left_activity, "BR_CAPTURE_POINT" );
}

// Namespace activity_br_capture_point
// Params 0, eflags: 0x4
// Checksum 0xb12c726d, Offset: 0x218
// Size: 0x32
function private activity_setup()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( self );
    activity_instance_common::function_46135a69bddfec2c( self );
}

// Namespace activity_br_capture_point
// Params 0, eflags: 0x4
// Checksum 0x911bf9eb, Offset: 0x252
// Size: 0x408
function private function_477932e3884ea1fd()
{
    activity = self;
    activity endon( #"activity_ended" );
    activity endon( #"instance_destroyed" );
    level endon( #"game_ended" );
    activity.capturetime = 0;
    activity function_aef36b276b04bf23();
    activity.starttime = gettime();
    targetactivity = activity_instance_common::function_a45920af4495e9f( self ).owningactivity ?? self;
    
    /#
        childthread function_ce0e2d07ff687f7d();
    #/
    
    activity_definition_utils::updateprogress( 0, targetactivity, 100 );
    
    if ( activity.var_332f929de1894b2b.capturesound )
    {
        activity.capturesound = utility::play_loopsound_in_space( activity.var_332f929de1894b2b.capturesound, activity_instance_common::function_776ee11e7acc64a5( activity ) );
    }
    
    while ( true )
    {
        activity function_aef36b276b04bf23();
        players = activity_instance_common::function_4225efca86f0dea9( activity );
        var_68e47303e96108c2 = 0;
        activity.var_4a62b0f6788ba18e = activity.capturetime / 1000 / activity.var_332f929de1894b2b.capturetime;
        
        foreach ( player in players )
        {
            player setclientomnvar( "ui_securing_progress", activity.var_4a62b0f6788ba18e );
            var_68e47303e96108c2 = var_68e47303e96108c2 || player::isreallyalive( player );
        }
        
        var_fc150b0094fe4f92 = targetactivity activity_definition_utils::function_837a0c8626c9b419();
        var_7553cce2fc4b1604 = activity_definition_utils::function_d32fa66f2924c90d( var_fc150b0094fe4f92 );
        
        if ( isdefined( var_7553cce2fc4b1604 ) )
        {
            focusedplayers = targetactivity activity_definition_utils::function_9a67de09579cf0a2();
            activity_definition_utils::updateprogress( int( activity.var_4a62b0f6788ba18e * 100 ), targetactivity, 100, { #players:focusedplayers } );
        }
        
        waitframe();
        
        if ( activity.capturingplayers > 0 )
        {
            activity.capturetime += activity.capturingplayers * level.frameduration;
        }
        else if ( activity.capturingplayers == 0 && activity.var_332f929de1894b2b.var_ea76efcec2f52e5c > 0 )
        {
            activity.capturetime -= activity.var_332f929de1894b2b.var_ea76efcec2f52e5c * level.frameduration;
        }
        
        if ( activity.capturetime >= activity.var_332f929de1894b2b.capturetime * 1000 )
        {
            activity.result = "succeeded";
            activity_definition_utils::function_a0a94881bc380bbf( 1, self, { #players:activity_instance_common::function_4225efca86f0dea9( activity ) } );
            activity_instance_common::endactivity( activity, 1 );
            break;
        }
        
        if ( activity.capturetime < 0 )
        {
            activity.result = "decayed";
            activity_instance_common::endactivity( activity, 0 );
            break;
        }
        
        timeremainingms = activity.var_332f929de1894b2b.var_93d21e3fbcd50ca8 * 1000 - gettime() - activity.starttime;
        
        if ( timeremainingms < 0 )
        {
            if ( !activity.var_332f929de1894b2b.var_77fd9939c712151c || activity.capturingplayers == 0 )
            {
                activity.result = "expired";
                activity_instance_common::endactivity( activity, 0 );
                break;
            }
        }
        
        if ( !var_68e47303e96108c2 )
        {
            activity.result = "participants_died";
            activity_instance_common::endactivity( activity, 0 );
            break;
        }
    }
}

// Namespace activity_br_capture_point
// Params 0, eflags: 0x4
// Checksum 0x4bc387f7, Offset: 0x662
// Size: 0x48e
function private function_aef36b276b04bf23()
{
    var_13e11de746892e66 = self.var_332f929de1894b2b.captureradius * self.var_332f929de1894b2b.captureradius;
    captureorigin = activity_instance_common::function_776ee11e7acc64a5( self );
    var_d2c434c9e44edf6d = squared( self.var_332f929de1894b2b.captureradius * 2 );
    var_af2efbc13d736e22 = 0;
    var_be30cdd048eb4d5d = [];
    
    foreach ( player in activity_instance_common::function_4225efca86f0dea9( self ) )
    {
        var_a72d50521669fc39 = distance2dsquared( player.origin, captureorigin );
        var_d0bafdea5ab9dc78 = 1;
        var_d0bafdea5ab9dc78 &= var_a72d50521669fc39 < var_13e11de746892e66;
        var_d0bafdea5ab9dc78 &= self.var_332f929de1894b2b.captureheight == 0 || abs( player.origin[ 2 ] - captureorigin[ 2 ] ) <= self.var_332f929de1894b2b.captureheight;
        var_d0bafdea5ab9dc78 &= !player::isinlaststand( player ) || self.var_332f929de1894b2b.var_ee2ff84181cb78d4;
        var_d0bafdea5ab9dc78 &= player::isreallyalive( player );
        
        if ( var_d0bafdea5ab9dc78 )
        {
            var_be30cdd048eb4d5d[ var_be30cdd048eb4d5d.size ] = player;
            var_af2efbc13d736e22++;
        }
        
        securingomnvar = player getclientomnvar( "ui_securing" );
        var_71feba3241243cd7 = securingomnvar == 46;
        var_71feba3241243cd7 |= securingomnvar == 47;
        var_9e75fd75ab7b99ba = var_d0bafdea5ab9dc78 || self.var_332f929de1894b2b.var_ea76efcec2f52e5c > 0 && var_71feba3241243cd7 && var_a72d50521669fc39 < var_d2c434c9e44edf6d;
        
        if ( var_9e75fd75ab7b99ba )
        {
            securetype = undefined;
            
            switch ( activity_instance_common::function_a45920af4495e9f( self ).var_f05781a0c58e1aaf ?? "" )
            {
                case #"hash_ad6cd9fa15067b56":
                    securetype = 46;
                    break;
                case #"hash_a017438730c08880":
                    securetype = 47;
                    break;
                default:
                    assertmsg( "<dev string:x24>" );
                    break;
            }
            
            player setclientomnvar( "ui_securing", securetype );
        }
        else
        {
            player setclientomnvar( "ui_securing", 0 );
        }
        
        additionaldata = activity_instance_common::function_a45920af4495e9f( self );
        
        if ( additionaldata.var_f05781a0c58e1aaf == "BONGO_REDEPLOY_STATION" )
        {
            if ( var_d0bafdea5ab9dc78 )
            {
                player br_public::updatebrscoreboardstat( "isInRedeployZone", 1 );
                continue;
            }
            
            player br_public::updatebrscoreboardstat( "isInRedeployZone", 0 );
        }
    }
    
    foreach ( player in additionaldata.owningactivity.playerparticipants )
    {
        player setclientomnvar( "ui_securing_players", var_af2efbc13d736e22 );
    }
    
    if ( var_af2efbc13d736e22 > 0 )
    {
        entities = getentarrayinradius( undefined, undefined, captureorigin, self.var_332f929de1894b2b.captureradius, 1 );
        
        if ( entities )
        {
            foreach ( ent in entities )
            {
                if ( self.var_332f929de1894b2b.captureheight == 0 || abs( ent.origin[ 2 ] - captureorigin[ 2 ] ) <= self.var_332f929de1894b2b.captureheight )
                {
                    if ( ent.var_57b273c971318b8f && ent.team == self.player.team )
                    {
                        var_af2efbc13d736e22++;
                    }
                }
            }
        }
    }
    
    self.var_21196410eda12485 = var_be30cdd048eb4d5d;
    self.capturingplayers = var_af2efbc13d736e22;
}

// Namespace activity_br_capture_point
// Params 1, eflags: 0x4
// Checksum 0xbd171276, Offset: 0xaf8
// Size: 0x10b
function private activity_ended( success )
{
    participatingplayers = activity_instance_common::function_4225efca86f0dea9( self );
    additionaldata = activity_instance_common::function_a45920af4495e9f( self );
    activity_definition_utils::updatetimer( 0, additionaldata.owningactivity ?? self );
    
    foreach ( player in participatingplayers )
    {
        player setclientomnvar( "ui_securing", 0 );
        
        if ( additionaldata.var_f05781a0c58e1aaf == "BONGO_REDEPLOY_STATION" )
        {
            player br_public::updatebrscoreboardstat( "isInRedeployZone", 0 );
        }
    }
    
    if ( self.capturesound )
    {
        self.capturesound stoploopsound( self.var_332f929de1894b2b.capturesound );
    }
}

// Namespace activity_br_capture_point
// Params 1, eflags: 0x4
// Checksum 0xf4c7e693, Offset: 0xc0b
// Size: 0xca
function private player_joined_activity( relevant_info_struct )
{
    function_aef36b276b04bf23();
    additionaldata = activity_instance_common::function_a45920af4495e9f( self );
    
    if ( additionaldata.var_f05781a0c58e1aaf != "BONGO_REDEPLOY_STATION" && additionaldata.var_f05781a0c58e1aaf != "BONGO_RELAY_ANTENNA" )
    {
        return;
    }
    
    foreach ( player in relevant_info_struct.playerlist )
    {
        br_analytics::function_63a0465c6e14c930( self, player );
    }
}

// Namespace activity_br_capture_point
// Params 1, eflags: 0x4
// Checksum 0xb00fbaf0, Offset: 0xcdd
// Size: 0xca
function private player_left_activity( relevant_info_struct )
{
    function_aef36b276b04bf23();
    additionaldata = activity_instance_common::function_a45920af4495e9f( self );
    
    if ( additionaldata.var_f05781a0c58e1aaf != "BONGO_REDEPLOY_STATION" && additionaldata.var_f05781a0c58e1aaf != "BONGO_RELAY_ANTENNA" )
    {
        return;
    }
    
    foreach ( player in relevant_info_struct.playerlist )
    {
        br_analytics::function_d9845418c8b51cff( self, player );
    }
}

/#

    // Namespace activity_br_capture_point
    // Params 0, eflags: 0x4
    // Checksum 0xe55fd05c, Offset: 0xdaf
    // Size: 0xe7, Type: dev
    function private function_ce0e2d07ff687f7d()
    {
        self endon( #"activity_ended" );
        self endon( #"instance_destroyed" );
        origin = activity_instance_common::function_776ee11e7acc64a5( self );
        
        while ( true )
        {
            print3d( origin + ( 0, 0, 128 ), self.capturingplayers + "<dev string:x49>", ( 0, 0.75, 0 ), 1, 1 );
            print3d( origin + ( 0, 0, 64 ), self.var_332f929de1894b2b.var_93d21e3fbcd50ca8 - ( gettime() - self.starttime ) / 1000 + "<dev string:x5c>", ( 0, 0.75, 0 ), 1, 1 );
            sphere( origin, self.var_332f929de1894b2b.captureradius, ( 0, 0.75, 0 ) );
            waitframe();
        }
    }

#/
