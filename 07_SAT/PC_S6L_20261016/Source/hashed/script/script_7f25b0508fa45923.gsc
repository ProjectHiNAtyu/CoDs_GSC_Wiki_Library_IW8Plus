// script_7f25b0508fa45923  (hash_7f25b0508fa45923.gscc) (size: 2956 Bytes / 0xb8c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3b6b646f (996893807)
// size ...... 2956 (0xb8c)
// includes .. 8   (offset: 0xa68)
// strings ... 10  (offset: 0xaa8)
// dev strs .. 4   (offset: 0xb54)
// exports ... 5   (offset: 0x6e8)
// cseg ...... 0xd5 + 0x613 (0x6e8)
// imports ... 23  (offset: 0x7b0)
// animtree1 . 0   (offset: 0xb8c)
// animtree2 . 0   (offset: 0xb8c)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\hud_util;
#using scripts\common\system;
#using scripts\common\values;
#using scripts\mp\coop;
#using scripts\mp\gametypes\ob_gametype_story_mission;
#using scripts\mp\ob\systems\ob_exfil;
#using scripts\mp\ob\systems\ob_exfil_trans;

#namespace ob_story_mission_activity_return;

/#

    // Namespace ob_story_mission_activity_return
    // Params 0
    // Checksum 0xe9e524b1, Offset: 0xf3
    // Size: 0x5, Type: dev
    function function_151d753a7e697233()
    {
        
    }

#/

// Namespace ob_story_mission_activity_return
// Params 0, eflags: 0x5
// Checksum 0xd4d8e925, Offset: 0x100
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ob_story_mission_activity_return", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace ob_story_mission_activity_return
// Params 0, eflags: 0x4
// Checksum 0xff293d8d, Offset: 0x129
// Size: 0x34
function private function_538033a540e63c70()
{
    level.current_activity_name = "ACTIVITY_STORY_RETURN";
    activity_common::registeractivitytype( "ACTIVITY_STORY_RETURN", &ob_gametype_story_mission::activity_type_init );
    activity_common::function_944074f3079c1d4e( "ACTIVITY_STORY_RETURN", 1, &function_477932e3884ea1fd );
}

// Namespace ob_story_mission_activity_return
// Params 0
// Checksum 0xc7f22672, Offset: 0x165
// Size: 0x583
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    level.current_activity = activity_instance;
    var_64ffacba090c91be = undefined;
    setnojiptime( 1 );
    
    if ( level.var_bb86f77304f193c4.var_85d3e2feeb63a69c )
    {
        foreach ( player in level.players )
        {
            if ( player.sessionstate == "playing" )
            {
                player.b_completed_exfil = 1;
                player.s_exfil = { #noreport:1 };
                level thread ob_exfil::function_7945ba0143ab037d( player );
            }
        }
        
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        player val::set( "activity_return", "damage", 0 );
        player val::set( "activity_return", "death", 0 );
        player val::set( "activity_return", "ignoreme", 1 );
        player setclientdvar( @"ui_opensummary", getdvarint( @"hash_b96228242dc09e3e", 0 ) );
        
        if ( !isdefined( var_64ffacba090c91be ) )
        {
            var_64ffacba090c91be = player;
        }
    }
    
    if ( isfunction( level.var_7229e74abf36c408 ) )
    {
        level [[ level.var_7229e74abf36c408 ]]();
    }
    
    ob_exfil_trans::function_a19af5e33ad1e493();
    
    if ( !level.onlinegame )
    {
        foreach ( player in level.players )
        {
            player val::set( "activity_return", "world_fade", 1 );
            player val::set( "activity_return", "show_hud", 0 );
            player thread hud_util::fade_out( 0, level.var_8899b54bb25b4c92 ?? "black" );
        }
        
        binkcinematic = getdvar( @"hash_ca08f59b64628422", "" );
        
        if ( binkcinematic )
        {
            coop::play_cinematic( binkcinematic, { #fadestartnone:1, #countdown:0 } );
        }
        
        foreach ( player in level.players )
        {
            player val::reset_all( "activity_return" );
            player hud_util::fade_in( 0, "black" );
        }
        
        /#
            hudelem = newhudelem();
            hudelem.alignx = "<dev string:x24>";
            hudelem.aligny = "<dev string:x2b>";
            hudelem.x = 320;
            hudelem.y = 320;
            hudelem.foreground = 1;
            hudelem.color = ( 1, 0.33, 0.33 );
            hudelem.fontscale = 2;
            hudelem setdevtext( "<dev string:x32>" );
        #/
    }
    else
    {
        if ( level.coop_reload == 2 )
        {
            foreach ( player in level.players )
            {
                player val::set( "activity_return", "world_fade", 1 );
                player val::set( "activity_return", "show_hud", 0 );
                player thread hud_util::fade_out( 0, level.var_8899b54bb25b4c92 ?? "black" );
            }
            
            /#
                hudelem = newhudelem();
                hudelem.alignx = "<dev string:x24>";
                hudelem.aligny = "<dev string:x2b>";
                hudelem.x = 320;
                hudelem.y = 320;
                hudelem.foreground = 1;
                hudelem.color = ( 1, 0.33, 0.33 );
                hudelem.fontscale = 2;
                hudelem setdevtext( "<dev string:x4b>" );
            #/
            
            wait 3;
        }
        
        level thread ob_exfil_trans::function_5f3a1579cbc6ac1e( var_64ffacba090c91be );
    }
    
    activity_instance waittill( #"hash_1e9bc5e84aa89155" );
}

