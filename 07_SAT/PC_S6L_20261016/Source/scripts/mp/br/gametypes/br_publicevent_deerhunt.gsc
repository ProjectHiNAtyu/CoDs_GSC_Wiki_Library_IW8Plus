// scripts\mp\br\gametypes\br_publicevent_deerhunt.gsc  (hash_3e8dd79be5388745.gscc) (size: 1686 Bytes / 0x696 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3d499f90 (1028235152)
// size ...... 1686 (0x696)
// includes .. 3   (offset: 0x5fa)
// strings ... 9   (offset: 0x612)
// dev strs .. 0   (offset: 0x696)
// exports ... 7   (offset: 0x32e)
// cseg ...... 0xd3 + 0x25b (0x32e)
// imports ... 15  (offset: 0x446)
// animtree1 . 0   (offset: 0x696)
// animtree2 . 0   (offset: 0x696)
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_codmas_vo;
#using scripts\mp\br\gametypes\br_publicevents;

#namespace br_publicevent_deerhunt;

// Namespace br_publicevent_deerhunt
// Params 0, eflags: 0x1
// Checksum 0xfedd78a4, Offset: 0xf1
// Size: 0x17
function autoexec main()
{
    br_publicevents::function_54d95495df246a2b( %"deerhunt", &init );
}

// Namespace br_publicevent_deerhunt
// Params 1
// Checksum 0x7946498a, Offset: 0x110
// Size: 0x76
function init( event_info )
{
    if ( !getdvarint( @"hash_c533a4ead2de511f", 0 ) || !getdvarint( @"hash_85b3a0aeeded84f3", 0 ) )
    {
        return;
    }
    
    event_info.waitfunc = &event_wait;
    event_info.activatefunc = &event_activate;
    event_info.postinitfunc = &event_post_init;
    event_info.deactivatefunc = &event_deactivate;
}

// Namespace br_publicevent_deerhunt
// Params 0
// Checksum 0x1ca8702, Offset: 0x18e
// Size: 0xac
function event_post_init()
{
    foreach ( vo in arraycombine( [ "puea", "pue2" ], [ "pex1", "pex2" ] ) )
    {
        game[ "dialog" ][ "deerhunt_" + vo ] = vo + "_zosa_coma";
    }
}

// Namespace br_publicevent_deerhunt
// Params 0
// Checksum 0x71bf8ca0, Offset: 0x242
// Size: 0x2
function event_wait()
{
    
}

// Namespace br_publicevent_deerhunt
// Params 0
// Checksum 0x7c7b090, Offset: 0x24c
// Size: 0xcc
function event_activate()
{
    br_publicevents::showsplashtoall( "br_pe_deerhunt_start", "splash_list_br_pe_deerhunt" );
    var_dae02c70c384a593 = "deerhunt_" + utility::array_random( [ "puea", "pue2" ] );
    br_codmas_vo::function_408703e87d31b651( var_dae02c70c384a593, undefined, undefined, undefined, 1.5 );
    br_codmas_vo::function_408703e87d31b651( "deerhunt_" + utility::array_random( [ "pex1", "pex2" ] ), undefined, undefined, undefined, 2 + br_codmas_vo::function_e6129eefe5880321( var_dae02c70c384a593 ) );
    
    if ( utility::issharedfuncdefined( #"zombie_reindeer", #"hash_3e545630041357b6" ) )
    {
        self [[ utility::getsharedfunc( #"zombie_reindeer", #"hash_3e545630041357b6" ) ]]( getdvarint( @"hash_be080ad3f3856c5b", 3 ) );
    }
}

// Namespace br_publicevent_deerhunt
// Params 0
// Checksum 0x9acd8ab6, Offset: 0x320
// Size: 0xe
function event_deactivate()
{
    level notify( #"event_deactivated" );
}

