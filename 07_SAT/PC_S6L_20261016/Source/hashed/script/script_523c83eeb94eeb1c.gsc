// script_523c83eeb94eeb1c  (hash_523c83eeb94eeb1c.gscc) (size: 1861 Bytes / 0x745 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xca2d2c2d (3391958061)
// size ...... 1861 (0x745)
// includes .. 9   (offset: 0x6d9)
// strings ... 2   (offset: 0x721)
// dev strs .. 0   (offset: 0x745)
// exports ... 8   (offset: 0x2d9)
// cseg ...... 0x94 + 0x245 (0x2d9)
// imports ... 25  (offset: 0x419)
// animtree1 . 0   (offset: 0x745)
// animtree2 . 0   (offset: 0x745)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_publicevent_traincircle;
#using scripts\mp\br\gametypes\br_publicevents;

#namespace namespace_eb37d051348adfc8;

// Namespace namespace_eb37d051348adfc8
// Params 0, eflags: 0x5
// Checksum 0x804bfd8e, Offset: 0xb2
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_5a5061317f3e90d3", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_eb37d051348adfc8
// Params 0, eflags: 0x4
// Checksum 0xaae5be30, Offset: 0xdb
// Size: 0x28
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "BR_PUBLIC_EVENT_TRAIN_CIRCLE", &activity_type_init );
    br_publicevents::function_54d95495df246a2b( getxhashasset( "BR_PUBLIC_EVENT_TRAIN_CIRCLE" ), &function_323fab1b62a2d5d4 );
}

// Namespace namespace_eb37d051348adfc8
// Params 1, eflags: 0x4
// Checksum 0xc338edc5, Offset: 0x10b
// Size: 0x50
function private function_323fab1b62a2d5d4( eventinfo )
{
    eventinfo.validatefunc = &br_publicevent_traincircle::validatefunc;
    eventinfo.canactivatefunc = &br_publicevent_traincircle::canactivatefunc;
    eventinfo.waitfunc = &br_publicevent_traincircle::waitfunc;
    eventinfo.postinitfunc = &br_publicevent_traincircle::postinitfunc;
}

// Namespace namespace_eb37d051348adfc8
// Params 0, eflags: 0x4
// Checksum 0x9d711a23, Offset: 0x163
// Size: 0x27
function private activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_TRAIN_CIRCLE", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_TRAIN_CIRCLE", 1, &function_477932e3884ea1fd );
}

// Namespace namespace_eb37d051348adfc8
// Params 0, eflags: 0x4
// Checksum 0x6ad4926d, Offset: 0x192
// Size: 0xde
function private activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance.var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( activity_instance );
    
    if ( !br_publicevent_traincircle::canactivatefunc() )
    {
        activity_instance_common::function_9aeeabe50fc9cc3e( self );
        return;
    }
    
    level.var_5ce976cd7a61808e = 1;
    br_circle::applycirclesettings();
    utility::flag_set( "br_pe_matchwide_complete" );
    level.var_64a2b866ed206e9e = activity_instance.var_332f929de1894b2b.var_721ea4f162303f3b;
    level.var_e7b31441dd59d0a5 = activity_instance.var_332f929de1894b2b.var_21f8c731bc5775f3;
    level.var_4391838d26dd3baf = activity_instance.var_673c7ee87efb9de6;
    level thread br_publicevent_traincircle::function_86c3c441bcd60a34();
    level callback::add( #"hash_f618f647217d4f3a", &_begin_activity, activity_instance );
}

// Namespace namespace_eb37d051348adfc8
// Params 2, eflags: 0x4
// Checksum 0x2be53a43, Offset: 0x278
// Size: 0x1e
function private _begin_activity( params, activity_instance )
{
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_eb37d051348adfc8
// Params 0, eflags: 0x4
// Checksum 0xa1e8bcf7, Offset: 0x29e
// Size: 0x3b
function private function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    br_publicevent_traincircle::function_b85902f6868a5b2d();
    activity_instance_common::endactivity( activity_instance, 1 );
}

