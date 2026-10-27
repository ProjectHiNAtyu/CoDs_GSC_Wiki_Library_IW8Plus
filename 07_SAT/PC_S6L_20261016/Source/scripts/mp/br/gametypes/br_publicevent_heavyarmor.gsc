// scripts\mp\br\gametypes\br_publicevent_heavyarmor.gsc  (hash_719e019babd3e566.gscc) (size: 4332 Bytes / 0x10ec / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2046c2c4 (541508292)
// size ...... 4332 (0x10ec)
// includes .. 5   (offset: 0xfbc)
// strings ... 16  (offset: 0xfe4)
// dev strs .. 3   (offset: 0x10c8)
// exports ... 15  (offset: 0x934)
// cseg ...... 0x1df + 0x755 (0x934)
// imports ... 36  (offset: 0xb8c)
// animtree1 . 0   (offset: 0x10ec)
// animtree2 . 0   (offset: 0x10ec)
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\mp\armor;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_publicevents;

#namespace br_publicevent_heavyarmor;

// Namespace br_publicevent_heavyarmor
// Params 0, eflags: 0x1
// Checksum 0xbd57e79d, Offset: 0x1fd
// Size: 0x17
function autoexec main()
{
    br_publicevents::function_54d95495df246a2b( %"heavyarmor", &init );
}

// Namespace br_publicevent_heavyarmor
// Params 1
// Checksum 0xa9a88071, Offset: 0x21c
// Size: 0x76
function init( eventinfo )
{
    if ( !getdvarint( @"hash_44792e9d3f0215c4", 1 ) )
    {
        return;
    }
    
    eventinfo.waitfunc = &event_wait;
    eventinfo.activatefunc = &event_activate;
    eventinfo.postinitfunc = &event_post_init;
    eventinfo.deactivatefunc = &event_deactivate;
    initdialog();
    
    /#
        level thread debug_init();
    #/
}

// Namespace br_publicevent_heavyarmor
// Params 0
// Checksum 0x526dced4, Offset: 0x29a
// Size: 0x28
function initdialog()
{
    game[ "dialog" ][ "activateHeavyArmor" ] = "pblc_wzan_harb";
    game[ "dialog" ][ "heavyArmorNag" ] = "pblc_wzan_harn";
}

// Namespace br_publicevent_heavyarmor
// Params 0
// Checksum 0x6f6ae2de, Offset: 0x2ca
// Size: 0xbd
function event_post_init()
{
    level.pe_heavyarmor = spawnstruct();
    level.pe_heavyarmor.var_5f197bad0a9aa7d2 = getdvarint( @"hash_ffe403fdc0fe3ff9", 1 );
    level.pe_heavyarmor.var_ac765b716054b321 = getdvarint( @"hash_862b1fbe176484b0", 1 );
    level.pe_heavyarmor.var_993dc14fed0f7d23 = getdvarint( @"hash_9635c3c8b4f7d5bb", 0 );
    level.pe_heavyarmor.activationdelay = getdvarint( @"hash_a64f6d835ad204f1", 3 );
    level.pe_heavyarmor.var_5c1fdfccdec4dbc7 = getdvarint( @"hash_e7ce66ed5400ebae", 45 );
}

// Namespace br_publicevent_heavyarmor
// Params 0
// Checksum 0x9471b067, Offset: 0x38f
// Size: 0x2
function event_wait()
{
    
}

// Namespace br_publicevent_heavyarmor
// Params 0
// Checksum 0xdc4d4ae, Offset: 0x399
// Size: 0x1ac
function event_activate()
{
    level.pe_heavyarmor.timestarted = gettime();
    br_publicevents::showsplashtoall( "br_pe_heavyarmor_start", "splash_list_br_pe_heavyarmor" );
    
    if ( level.pe_heavyarmor.activationdelay > 0 )
    {
        wait level.pe_heavyarmor.activationdelay;
    }
    
    setomnvar( "ui_publicevent_heavyarmor_active", 1 );
    level.pe_heavyarmor_active = 1;
    
    if ( !utility::callsharedfunc( #"game", #"isCommonItemEnabled" ) )
    {
        level.br_pickups.maxcounts[ "brloot_armor_plate" ] = level.br_pickups.maxcounts[ "brloot_armor_plate" ] + 1;
    }
    
    foreach ( player in level.players )
    {
        br_public::brleaderdialogplayer( "activateHeavyArmor", player, 1, 0, 0, undefined, "dx_br_brdm_" );
        var_f0ede39b3ac80bde = player.armorhealth + ( level.pe_heavyarmor.var_5f197bad0a9aa7d2 ? player armor::function_cb22658f54166b6b() : 0 );
        player armor::refreshmaxarmorhealth( var_f0ede39b3ac80bde );
        player thread function_2cc0b78475a9193e();
        player thread function_e8443db002c143b0();
        player armor::function_d844468b44333411();
    }
    
    function_63d64c19f56369();
}

// Namespace br_publicevent_heavyarmor
// Params 0
// Checksum 0x568ff789, Offset: 0x54d
// Size: 0xf8
function event_deactivate()
{
    if ( level.pe_heavyarmor.var_993dc14fed0f7d23 )
    {
        setomnvar( "ui_publicevent_heavyarmor_active", 0 );
        level.pe_heavyarmor_active = 0;
        
        if ( !utility::callsharedfunc( #"game", #"isCommonItemEnabled" ) )
        {
            level.br_pickups.maxcounts[ "brloot_armor_plate" ] = level.br_pickups.maxcounts[ "brloot_armor_plate" ] - 1;
        }
        
        foreach ( player in level.players )
        {
            player armor::refreshmaxarmorhealth();
        }
    }
}

// Namespace br_publicevent_heavyarmor
// Params 0
// Checksum 0xb6f86bd8, Offset: 0x64d
// Size: 0x96
function function_2cc0b78475a9193e()
{
    player = self;
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    var_2b0c4a3052da4b1c = player armor::function_22290101992e4874();
    var_5f436e22fb01ee74 = player armor::function_33fbba4f082f4aec();
    var_5f94b8ea4ad4be98 = var_5f436e22fb01ee74;
    
    while ( var_5f436e22fb01ee74 > 0 )
    {
        if ( var_2b0c4a3052da4b1c < var_5f436e22fb01ee74 )
        {
            return;
        }
        
        player waittill( #"armor_plate_inserted" );
        var_2b0c4a3052da4b1c = player armor::function_22290101992e4874();
        var_5f436e22fb01ee74 = player armor::function_33fbba4f082f4aec();
    }
    
    player function_d75b955de26ebc3b( var_5f94b8ea4ad4be98 );
}

// Namespace br_publicevent_heavyarmor
// Params 0
// Checksum 0x82067576, Offset: 0x6eb
// Size: 0x5f
function function_e8443db002c143b0()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"heavy_armor_heard" );
    
    for ( var_5f436e22fb01ee74 = armor::function_33fbba4f082f4aec(); var_5f436e22fb01ee74 > 0 ; var_5f436e22fb01ee74 = armor::function_33fbba4f082f4aec() )
    {
        if ( armor::function_22290101992e4874() > 0 )
        {
            function_20116a329d9e801d();
        }
        
        wait 1;
    }
}

// Namespace br_publicevent_heavyarmor
// Params 0
// Checksum 0x684c61de, Offset: 0x752
// Size: 0x75
function function_20116a329d9e801d()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"armor_plate_inserted" );
    wait level.pe_heavyarmor.var_5c1fdfccdec4dbc7;
    
    if ( armor::function_33fbba4f082f4aec() == 0 )
    {
        return;
    }
    
    if ( armor::function_22290101992e4874() == 0 )
    {
        return;
    }
    
    br_public::brleaderdialogplayer( "heavyArmorNag", self, 1, 0, 0, undefined, "dx_br_brdm_" );
    self notify( #"heavy_armor_heard" );
}

// Namespace br_publicevent_heavyarmor
// Params 0
// Checksum 0xe70bf255, Offset: 0x7cf
// Size: 0x3f
function function_63d64c19f56369()
{
    currentcircleindex = level.br_circle.circleindex ?? 0;
    dlog_recordevent( "dlog_event_heavyarmor_match_event", [ "circle_index", currentcircleindex ] );
}

// Namespace br_publicevent_heavyarmor
// Params 1
// Checksum 0x33c822bc, Offset: 0x816
// Size: 0xb5
function function_d75b955de26ebc3b( var_5f94b8ea4ad4be98 )
{
    currentcircleindex = level.br_circle.circleindex ?? 0;
    currenttime = gettime();
    var_492a8db482462917 = currenttime - level.pe_heavyarmor.timestarted;
    dlog_recordevent( "dlog_event_heavyarmor_fully_plated", [ "circle_index", currentcircleindex, "time_since_heavyarmor", var_492a8db482462917, "initial_empty_plate_slot_count", var_5f94b8ea4ad4be98, "fill_new_slot_enabled", level.pe_heavyarmor.var_5f197bad0a9aa7d2 ] );
}

/#

    // Namespace br_publicevent_heavyarmor
    // Params 0
    // Checksum 0xac79eebc, Offset: 0x8d3
    // Size: 0x2e, Type: dev
    function debug_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x36>", "<dev string:x42>", &debug_start_event );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace br_publicevent_heavyarmor
    // Params 0
    // Checksum 0xfdbede9c, Offset: 0x909
    // Size: 0x2b, Type: dev
    function debug_start_event()
    {
        if ( !isdefined( level.pe_heavyarmor ) )
        {
            event_post_init();
        }
        
        level thread br_publicevents::function_3cacd19bcd0bc75b( %"heavyarmor" );
    }

#/
