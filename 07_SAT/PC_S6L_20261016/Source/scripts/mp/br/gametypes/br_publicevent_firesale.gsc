// scripts\mp\br\gametypes\br_publicevent_firesale.gsc  (hash_048cb05dd32532fb.gscc) (size: 2971 Bytes / 0xb9b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf19ffca2 (4053793954)
// size ...... 2971 (0xb9b)
// includes .. 6   (offset: 0xab7)
// strings ... 13  (offset: 0xae7)
// dev strs .. 0   (offset: 0xb9b)
// exports ... 10  (offset: 0x63b)
// cseg ...... 0x160 + 0x4db (0x63b)
// imports ... 25  (offset: 0x7cb)
// animtree1 . 0   (offset: 0xb9b)
// animtree2 . 0   (offset: 0xb9b)
#using scripts\common\callbacks;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_common_kiosk;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_publicevents;
#using scripts\mp\hud_util;

#namespace br_publicevent_firesale;

// Namespace br_publicevent_firesale
// Params 0, eflags: 0x1
// Checksum 0x5c4586c2, Offset: 0x17e
// Size: 0x17
function autoexec main()
{
    br_publicevents::function_54d95495df246a2b( %"firesale", &init );
}

// Namespace br_publicevent_firesale
// Params 1
// Checksum 0x9e7a962d, Offset: 0x19d
// Size: 0x50
function init( eventinfo )
{
    eventinfo.canactivatefunc = &canactivatefunc;
    eventinfo.activatefunc = &activatefunc;
    eventinfo.waitfunc = &waitfunc;
    eventinfo.postinitfunc = &postinitfunc;
}

// Namespace br_publicevent_firesale
// Params 0
// Checksum 0x9046f50f, Offset: 0x1f5
// Size: 0x28
function postinitfunc()
{
    game[ "dialog" ][ "public_events_firesale_start" ] = "pblc_wzan_frsc";
    game[ "dialog" ][ "public_events_firesale_end" ] = "pblc_wzan_frsn";
}

// Namespace br_publicevent_firesale
// Params 0
// Checksum 0x940b7289, Offset: 0x225
// Size: 0x52, Type: bool
function canactivatefunc()
{
    if ( !isdefined( level.var_797b14a7ea4df55 ) )
    {
        return false;
    }
    
    if ( isdefined( level.br_circle ) && level.br_circle.circleindex <= 1 )
    {
        return true;
    }
    
    return level.common_armory_kiosk.var_fc040a52119313ae >= 1;
}

// Namespace br_publicevent_firesale
// Params 0
// Checksum 0xf626c4f3, Offset: 0x280
// Size: 0x2f
function waitfunc()
{
    level endon( #"game_ended" );
    level endon( #"cancel_public_event" );
    eventstarttime = calculateeventstarttime();
    wait eventstarttime;
}

// Namespace br_publicevent_firesale
// Params 0
// Checksum 0x45b4d6f4, Offset: 0x2b7
// Size: 0x15b
function activatefunc()
{
    level endon( #"game_ended" );
    br_publicevents::showsplashtoall( "br_pe_firesale_start" );
    br_public::brleaderdialog( "public_events_firesale_start", undefined, undefined, undefined, 1.5 );
    setomnvar( "ui_minimap_pulse", 1 );
    setomnvar( "ui_publicevent_timer_type", 1 );
    callback::callback( #"hash_dd36ab548337dd9a", { #objectivestate:"firesale" } );
    eventduration = getduration();
    eventendtime = gettime() + eventduration * 1000;
    setomnvar( "ui_publicevent_timer", eventendtime );
    
    if ( isdefined( level.var_65f58b7fd405d30b ) )
    {
        [[ level.var_65f58b7fd405d30b ]]();
    }
    
    level notify( #"hash_702c2ddc1c192a04" );
    thread function_bb2df381fb948e27( 1 );
    wait eventduration;
    
    if ( isdefined( level.var_3317f1328e7e9df3 ) )
    {
        [[ level.var_3317f1328e7e9df3 ]]();
    }
    
    br_publicevents::function_a1af4e372c2ecc3( %"firesale" );
    level notify( #"hash_521a13110d1a6dfd" );
    thread function_bb2df381fb948e27( 0 );
    hud_util::showsplashtoall( "br_pe_firesale_end" );
    br_public::brleaderdialog( "public_events_firesale_end", undefined, undefined, undefined, 1.5 );
    callback::callback( #"hash_dd36ab548337dd9a", { #objectivestate:"active" } );
    setomnvar( "ui_minimap_pulse", 0 );
    setomnvar( "ui_publicevent_timer_type", 0 );
}

// Namespace br_publicevent_firesale
// Params 0
// Checksum 0xf31751b7, Offset: 0x41a
// Size: 0xef
function getduration()
{
    eventduration = getdvarfloat( @"scr_br_pe_firesale_duration", 90 );
    var_c4da41271aab0252 = isdefined( level.br_circle ) && isdefined( level.br_circle.circleindex ) && level.br_circle.circleindex != -1;
    var_f1e0b0886a766c4a = getdvarint( @"hash_cc7fed1c42605966", 1 ) == 1;
    
    if ( var_f1e0b0886a766c4a && var_c4da41271aab0252 )
    {
        eventduration = min( eventduration, br_circle::function_f30ad5eda1a16d44() );
    }
    
    var_a4461e5fad29a954 = getdvarint( @"hash_18c9ea0970a9d3aa", 0 ) == 1;
    
    if ( var_a4461e5fad29a954 && var_c4da41271aab0252 )
    {
        eventduration = br_circle::function_f30ad5eda1a16d44();
    }
    
    minduration = getdvarfloat( @"scr_br_pe_firesale_minduration", 15 );
    eventduration = max( eventduration, minduration );
    return eventduration;
}

// Namespace br_publicevent_firesale
// Params 0
// Checksum 0xc86eb98f, Offset: 0x512
// Size: 0x51
function calculateeventstarttime()
{
    minstarttime = getdvarfloat( @"scr_br_pe_firesale_starttime_min", 795 );
    maxstarttime = getdvarfloat( @"scr_br_pe_firesale_starttime_max", 1110 );
    
    if ( maxstarttime > minstarttime )
    {
        return randomfloatrange( minstarttime, maxstarttime );
    }
    
    return minstarttime;
}

// Namespace br_publicevent_firesale
// Params 1
// Checksum 0xa2b7f7be, Offset: 0x56b
// Size: 0xd0
function function_bb2df381fb948e27( firesalestart )
{
    level endon( #"game_ended" );
    count = 0;
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( firesalestart )
        {
            br_common_kiosk::function_8c37d124818e1233( player, "publicevent" );
        }
        else
        {
            br_common_kiosk::function_a81ff2dd91265e8( player, "publicevent" );
        }
        
        count++;
        
        if ( count >= 20 )
        {
            count = 0;
            waitframe();
        }
    }
}

