// scripts\mp\ob\activities\ob_activity_quest_circle.gsc  (hash_3709aeb23bd5bdb5.gscc) (size: 2995 Bytes / 0xbb3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x22257102 (572879106)
// size ...... 2995 (0xbb3)
// includes .. 7   (offset: 0xb1b)
// strings ... 7   (offset: 0xb53)
// dev strs .. 1   (offset: 0xba7)
// exports ... 12  (offset: 0x637)
// cseg ...... 0xeb + 0x54c (0x637)
// imports ... 26  (offset: 0x817)
// animtree1 . 0   (offset: 0xbb3)
// animtree2 . 0   (offset: 0xbb3)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\spatial_zone_container;
#using scripts\common\system;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\ob\activities\ob_activity_definition_utils;

#namespace ob_activity_quest_circle;

// Namespace ob_activity_quest_circle
// Params 0, eflags: 0x5
// Checksum 0x6b2f37e4, Offset: 0x109
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_8577902fae53d3f6", #"activity_common", &init, undefined );
}

// Namespace ob_activity_quest_circle
// Params 0, eflags: 0x4
// Checksum 0x8540ef69, Offset: 0x132
// Size: 0x68
function private init()
{
    activity_common::function_2dd4f07fa5c3e911( "InstanceBegin", &function_48e49a495be3abc7 );
    activity_common::function_2dd4f07fa5c3e911( "InstanceEnd", &function_98e37b54c60ca5af );
    activity_common::function_2dd4f07fa5c3e911( "ActivityEnd", &on_activity_end );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &function_bbfe69caf3c664e7 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerFocusedOnActivity", &function_41b9be0725767299 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLoseFocusedOnActivity", &function_766eb6f0e6762e0a );
}

// Namespace ob_activity_quest_circle
// Params 1, eflags: 0x4
// Checksum 0x806ed511, Offset: 0x1a2
// Size: 0x38
function private function_48e49a495be3abc7( relevantinfostruct )
{
    var_bdff29cb8b08ca81 = activity_definition_utils::function_f9aac5b745dab95a( self );
    
    if ( var_bdff29cb8b08ca81 || !namespace_4a69edc3725e741::function_e0417ab27e1c8990( self ) )
    {
        return;
    }
    
    function_5b81267bf51af13e();
}

// Namespace ob_activity_quest_circle
// Params 1, eflags: 0x4
// Checksum 0x2769946, Offset: 0x1e2
// Size: 0x28
function private function_98e37b54c60ca5af( relevantinfostruct )
{
    if ( self.questcircleconfig )
    {
        self.questcircleconfig game_utility::questcircle_delete();
    }
}

// Namespace ob_activity_quest_circle
// Params 1, eflags: 0x4
// Checksum 0x2eb6be39, Offset: 0x212
// Size: 0x28
function private on_activity_end( relevantinfostruct )
{
    if ( self.questcircleconfig )
    {
        self.questcircleconfig game_utility::questcircle_delete();
    }
}

// Namespace ob_activity_quest_circle
// Params 1, eflags: 0x4
// Checksum 0x2d4b0cc8, Offset: 0x242
// Size: 0x56
function private function_bbfe69caf3c664e7( relevantinfostruct )
{
    if ( self.questcircleconfig )
    {
        player_list = relevantinfostruct.playerlist;
        function_fcb9978a40ba7cd( player_list );
        
        if ( !self.playerparticipants.size )
        {
            self.questcircleconfig game_utility::questcircle_delete();
        }
    }
}

// Namespace ob_activity_quest_circle
// Params 1, eflags: 0x4
// Checksum 0x6fa90858, Offset: 0x2a0
// Size: 0x38
function private function_41b9be0725767299( relevantinfostruct )
{
    if ( self.questcircleconfig )
    {
        player_list = relevantinfostruct.playerlist;
        function_21a76db20e18aea4( player_list );
    }
}

// Namespace ob_activity_quest_circle
// Params 1, eflags: 0x4
// Checksum 0xa9d0b51b, Offset: 0x2e0
// Size: 0x38
function private function_766eb6f0e6762e0a( relevantinfostruct )
{
    if ( self.questcircleconfig )
    {
        player_list = relevantinfostruct.playerlist;
        function_fcb9978a40ba7cd( player_list );
    }
}

// Namespace ob_activity_quest_circle
// Params 0, eflags: 0x4
// Checksum 0xfbeea073, Offset: 0x320
// Size: 0xe3
function private function_5b81267bf51af13e()
{
    quest_circle_config = {};
    zone_info_struct = namespace_4a69edc3725e741::function_b56b6f51a8627848( self );
    
    if ( zone_info_struct.usecustomdistance )
    {
        quest_circle_config.type = 0;
        quest_circle_config.radius = zone_info_struct.var_b41d7a0bdbf73429.customdistance;
    }
    else if ( zone_info_struct.var_bd1d6827ce0e7426 )
    {
        quest_circle_config.type = 1;
        quest_circle_config.linkedzone = zone_info_struct.spatialzonename[ 0 ].variant_object.spatialzonename;
        quest_circle_config.var_bb17488b0463057d = ( quest_circle_config.var_bb17488b0463057d ?? 100 ) / 100;
    }
    else
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    self.questcircleconfig = quest_circle_config;
}

// Namespace ob_activity_quest_circle
// Params 1, eflags: 0x4
// Checksum 0x8400c3de, Offset: 0x40b
// Size: 0x18b
function private function_21a76db20e18aea4( players )
{
    if ( !self.questcircleconfig game_utility::questcircle_exists() )
    {
        if ( self.questcircleconfig.type == 0 )
        {
            origin = activity_instance_common::function_776ee11e7acc64a5( self );
            radius = self.questcircleconfig.radius;
        }
        else if ( self.questcircleconfig.type == 1 )
        {
            spheres = spatial_zone_container::function_f7fc3e6c249a8256( self, self.questcircleconfig.linkedzone );
            origin = spatial_zone_container::function_2676e037929f0833( spheres[ 0 ] );
            radius = spatial_zone_container::function_231d9e91d8ef7b5f( spheres[ 0 ] ) * self.questcircleconfig.var_bb17488b0463057d;
        }
        
        templateid = self.var_dcfee9bbb5135a78 ?? "Search_Area_Activity_Ob";
        self.questcircleconfig game_utility::questcircle_create( templateid, origin, radius );
    }
    
    if ( self.questcircleconfig game_utility::questcircle_exists() )
    {
        foreach ( player in players )
        {
            self.questcircleconfig game_utility::questcircle_showtoplayer( player );
        }
    }
}

// Namespace ob_activity_quest_circle
// Params 1, eflags: 0x4
// Checksum 0x6dc452b6, Offset: 0x59e
// Size: 0x99
function private function_fcb9978a40ba7cd( players )
{
    if ( self.questcircleconfig game_utility::questcircle_exists() )
    {
        foreach ( player in players )
        {
            self.questcircleconfig game_utility::questcircle_hidefromplayer( player );
        }
    }
}

