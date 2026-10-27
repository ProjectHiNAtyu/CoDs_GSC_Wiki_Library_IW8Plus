// script_4ac0f54405ca6d0  (hash_04ac0f54405ca6d0.gscc) (size: 3225 Bytes / 0xc99 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2d5fe842 (761260098)
// size ...... 3225 (0xc99)
// includes .. 8   (offset: 0xb79)
// strings ... 14  (offset: 0xbb9)
// dev strs .. 1   (offset: 0xc8d)
// exports ... 9   (offset: 0x64d)
// cseg ...... 0x1df + 0x46e (0x64d)
// imports ... 34  (offset: 0x7b5)
// animtree1 . 0   (offset: 0xc99)
// animtree2 . 0   (offset: 0xc99)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\mp\br\br_activity_util;
#using scripts\mp\br\gametypes\br_publicevent_jailbreak;
#using scripts\mp\br\gametypes\br_publicevents;

#namespace namespace_f5124afb715983ae;

// Namespace namespace_f5124afb715983ae
// Params 0, eflags: 0x5
// Checksum 0x32cec35c, Offset: 0x1fd
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_8886b66735c5e923", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_f5124afb715983ae
// Params 0, eflags: 0x4
// Checksum 0x529bf912, Offset: 0x226
// Size: 0x28
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "BR_PUBLIC_EVENT_JAILBREAK", &activity_type_init );
    br_publicevents::function_54d95495df246a2b( getxhashasset( "BR_PUBLIC_EVENT_JAILBREAK" ), &function_323fab1b62a2d5d4 );
}

// Namespace namespace_f5124afb715983ae
// Params 1
// Checksum 0x86ebb1a7, Offset: 0x256
// Size: 0x2e
function function_323fab1b62a2d5d4( eventinfo )
{
    eventinfo.validatefunc = &br_publicevent_jailbreak::validatefunc;
    eventinfo.waitfunc = &br_publicevent_jailbreak::waitfunc;
}

// Namespace namespace_f5124afb715983ae
// Params 0
// Checksum 0x93d805bd, Offset: 0x28c
// Size: 0xbc
function activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_JAILBREAK", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_JAILBREAK", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_JAILBREAK", 3, &function_d4acef179eb9f9b2 );
    assert( isdefined( game[ "<dev string:x24>" ] ) );
    game[ "dialog" ][ "public_events_jailbreak_incoming_active" ] = "pblc_wzan_jbwr";
    game[ "dialog" ][ "public_events_jailbreak_incoming_active_alt" ] = "pblc_wzan_jbwr";
    game[ "dialog" ][ "public_events_jailbreak_now_active" ] = "pblc_wzan_jbct";
    game[ "dialog" ][ "public_events_jailbreak_now_active_alt" ] = "pblc_wzan_jbct";
    game[ "dialog" ][ "public_events_jailbreak_now_gulag" ] = "pblc_wzan_jbgn";
    game[ "dialog" ][ "public_events_jailbreak_now_spectate" ] = "pblc_wzan_jbsn";
}

// Namespace namespace_f5124afb715983ae
// Params 0
// Checksum 0xdbc3e440, Offset: 0x350
// Size: 0x46
function activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance.var_332f929de1894b2b = namespace_9085ae059032a84f::function_9129cd8075c85c09( activity_instance );
    thread function_f198246c39826f37( activity_instance );
}

// Namespace namespace_f5124afb715983ae
// Params 1
// Checksum 0x9713e73d, Offset: 0x39e
// Size: 0x25
function function_f198246c39826f37( activity_instance )
{
    br_publicevent_jailbreak::pauseallgulagfights( 1 );
    br_publicevent_jailbreak::waitforgulagfightstocomplete();
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_f5124afb715983ae
// Params 0
// Checksum 0xcd4d2239, Offset: 0x3cb
// Size: 0x256
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    eventduration = getdvarfloat( @"scr_br_pe_jailbreak_duration", activity_instance.var_332f929de1894b2b.respawndelay );
    br_activity_util::function_f255dbc3d969ce02( eventduration, 2 );
    
    if ( activity_instance.var_332f929de1894b2b.var_250c2d367b4b81e1 )
    {
        br_publicevent_jailbreak::playjailbreakvo( "now" );
    }
    
    if ( activity_instance.var_332f929de1894b2b.var_b72999e65b50ade )
    {
        br_publicevents::showsplashtoall( "br_pe_jailbreak_active" );
    }
    
    wait 1;
    additional_spawn_data = activity_instance_common::function_a45920af4495e9f( activity_instance );
    var_f5457b2113554e6c = activity_instance.var_332f929de1894b2b.var_f5457b2113554e6c;
    playerlist = br_publicevent_jailbreak::buildrespawnlist( var_f5457b2113554e6c );
    
    foreach ( player in playerlist )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( additional_spawn_data.block_team_list && isarray( additional_spawn_data.block_team_list ) && arraycontains( additional_spawn_data.block_team_list, player.team ) )
        {
            continue;
        }
        
        player thread br_publicevent_jailbreak::respawnplayer();
    }
    
    params = { #playercount:playerlist.size, #var_f5457b2113554e6c:var_f5457b2113554e6c };
    level callback::callback( #"jailbreak_event", params );
    
    if ( activity_instance.var_332f929de1894b2b.var_71e4d0dcffb5e219 )
    {
        br_publicevents::showsplashtoall( activity_instance.var_332f929de1894b2b.var_71e4d0dcffb5e219, undefined, { #optionalnumber:playerlist.size } );
    }
    
    level.var_5aaf221daf42f53c = undefined;
    level thread br_publicevent_jailbreak::forcestopwaitforgulagtoempty();
    br_publicevent_jailbreak::function_1f7d99f802aea4e4( playerlist );
    level notify( #"hash_edf2e0c2586d0e50" );
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_f5124afb715983ae
// Params 0
// Checksum 0x81e3480e, Offset: 0x629
// Size: 0x24
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    br_publicevent_jailbreak::pauseallgulagfights( 0 );
}

