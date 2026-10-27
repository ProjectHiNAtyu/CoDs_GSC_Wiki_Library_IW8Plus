// scripts\mp\br\gametypes\br_publicevent_traincircle.gsc  (hash_4a95e4a0214a6314.gscc) (size: 2410 Bytes / 0x96a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc75d10c (209047820)
// size ...... 2410 (0x96a)
// includes .. 5   (offset: 0x8d2)
// strings ... 7   (offset: 0x8fa)
// dev strs .. 0   (offset: 0x96a)
// exports ... 12  (offset: 0x48a)
// cseg ...... 0x102 + 0x388 (0x48a)
// imports ... 21  (offset: 0x66a)
// animtree1 . 0   (offset: 0x96a)
// animtree2 . 0   (offset: 0x96a)
#using scripts\common\callbacks;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_publicevents;

#namespace br_publicevent_traincircle;

// Namespace br_publicevent_traincircle
// Params 0, eflags: 0x1
// Checksum 0xc5f5e866, Offset: 0x120
// Size: 0x17
function autoexec main()
{
    br_publicevents::function_54d95495df246a2b( %"traincircle", &init );
}

// Namespace br_publicevent_traincircle
// Params 1
// Checksum 0xde74974a, Offset: 0x13f
// Size: 0x61
function init( eventinfo )
{
    eventinfo.validatefunc = &validatefunc;
    eventinfo.postinitfunc = &postinitfunc;
    eventinfo.waitfunc = &waitfunc;
    eventinfo.canactivatefunc = &canactivatefunc;
    eventinfo.activatefunc = &activatefunc;
}

// Namespace br_publicevent_traincircle
// Params 0
// Checksum 0xc1b88d84, Offset: 0x1a8
// Size: 0x38, Type: bool
function validatefunc()
{
    if ( !br_public::function_9dc52a7da56f6544() )
    {
        return false;
    }
    
    if ( br_gametypes::isfeaturedisabled( #"circle" ) )
    {
        return false;
    }
    
    if ( br_gametypes::isfeaturedisabled( #"traincircle" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace br_publicevent_traincircle
// Params 0
// Checksum 0x940238da, Offset: 0x1e9
// Size: 0x53
function postinitfunc()
{
    level.br_pe_traincircle = spawnstruct();
    level.br_pe_traincircle.canactivate = 1;
    level thread function_7ce35c134aeb8e12();
    game[ "dialog" ][ "br_pe_traincircle_intro" ] = "urzk_wzan_rted";
    game[ "dialog" ][ "br_pe_traincircle_pre_attach" ] = "urzk_wzan_rted";
}

// Namespace br_publicevent_traincircle
// Params 0, eflags: 0x4
// Checksum 0x627767d4, Offset: 0x244
// Size: 0x24
function private function_7ce35c134aeb8e12()
{
    level waittill( #"calc_circle_centers" );
    level.br_pe_traincircle.canactivate = 0;
}

// Namespace br_publicevent_traincircle
// Params 0
// Checksum 0xf9d21c8a, Offset: 0x270
// Size: 0x20, Type: bool
function canactivatefunc()
{
    return level.br_pe_traincircle.canactivate && !br_public::function_73ed6e27eb5e7544();
}

// Namespace br_publicevent_traincircle
// Params 0
// Checksum 0x746fdb32, Offset: 0x299
// Size: 0x2
function waitfunc()
{
    
}

// Namespace br_publicevent_traincircle
// Params 0
// Checksum 0x7afa11ea, Offset: 0x2a3
// Size: 0x6c
function activatefunc()
{
    level.var_5ce976cd7a61808e = 1;
    br_circle::applycirclesettings();
    level.var_64a2b866ed206e9e = 1;
    level.var_e7b31441dd59d0a5 = getdvarint( @"hash_d9e4dfff23390df", 1 );
    level.var_4391838d26dd3baf = getdvarint( @"hash_27cbd3590b1532d1", 0 );
    level thread function_86c3c441bcd60a34();
    level callback::add( #"hash_f618f647217d4f3a", &function_b85902f6868a5b2d );
}

// Namespace br_publicevent_traincircle
// Params 0
// Checksum 0x8bab2e0e, Offset: 0x317
// Size: 0x64
function function_86c3c441bcd60a34()
{
    level endon( #"game_ended" );
    shouldshow = getdvarint( @"scr_br_pe_traincircle_intro_splash", 0 );
    
    if ( !shouldshow )
    {
        return;
    }
    
    level waittill( #"infils_ready" );
    br_publicevents::showsplashtoall( "br_pe_traincircle_attach", "splash_list_br_pe_traincircle_attach" );
    br_public::brleaderdialog( "br_pe_traincircle_intro", 1, undefined, undefined, 0, undefined, "dx_br_urzi_" );
}

// Namespace br_publicevent_traincircle
// Params 1
// Checksum 0xe244decc, Offset: 0x383
// Size: 0xbc
function function_b85902f6868a5b2d( params )
{
    shouldshow = getdvarint( @"scr_br_pe_traincircle_attach_splash", 1 );
    
    if ( !shouldshow )
    {
        return;
    }
    
    leadtime = getdvarint( @"hash_b7c431df670a8fa3", 0 );
    var_a5417c22c68254cb = level.br_level.br_circledelaytimes[ level.br_circle.circleindex ] + level.br_level.br_circleclosetimes[ level.br_circle.circleindex ];
    var_cc803c62858d4109 = max( var_a5417c22c68254cb - leadtime, 0 );
    level thread function_d557bc8c2491e23a( var_cc803c62858d4109 );
}

// Namespace br_publicevent_traincircle
// Params 1, eflags: 0x4
// Checksum 0xa356854e, Offset: 0x447
// Size: 0x43
function private function_d557bc8c2491e23a( delaytime )
{
    level endon( #"game_ended" );
    wait delaytime;
    br_publicevents::showsplashtoall( "br_pe_traincircle_attach", "splash_list_br_pe_traincircle_attach" );
    br_public::brleaderdialog( "br_pe_traincircle_pre_attach", 1, undefined, undefined, 0, undefined, "dx_br_urzi_" );
}

