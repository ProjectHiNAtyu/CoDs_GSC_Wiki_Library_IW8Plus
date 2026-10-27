// scripts\common\ai\smartobjects\hunt_point.gsc  (hash_2d14618ec28851bb.gscc) (size: 1979 Bytes / 0x7bb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xba5552bf (3126153919)
// size ...... 1979 (0x7bb)
// includes .. 6   (offset: 0x6f3)
// strings ... 11  (offset: 0x723)
// dev strs .. 0   (offset: 0x7bb)
// exports ... 7   (offset: 0x3ef)
// cseg ...... 0xff + 0x2f0 (0x3ef)
// imports ... 17  (offset: 0x507)
// animtree1 . 0   (offset: 0x7bb)
// animtree2 . 0   (offset: 0x7bb)
#using scripts\anim\battlechatter;
#using scripts\asm\asm;
#using scripts\asm\gesture;
#using scripts\common\ai\smartobjects\utility;
#using scripts\common\ai\stealth\group;
#using scripts\common\utility;

#namespace hunt_point;

// Namespace hunt_point
// Params 0
// Checksum 0xdb632666, Offset: 0x11d
// Size: 0x18
function main()
{
    utility::add_smartobject_type( "hunt_point", &getinfo, &canuse );
}

// Namespace hunt_point
// Params 1
// Checksum 0x5eda9dd1, Offset: 0x13d
// Size: 0xe, Type: bool
function canuse( object )
{
    return true;
}

// Namespace hunt_point
// Params 0
// Checksum 0xccbc42fa, Offset: 0x154
// Size: 0x5f
function getinfo()
{
    info = utility::createsmartobjectinfo();
    info.fnonuse = &onuse;
    info.var_8305aedf56bda069 = 1;
    info.radiussqrd = 3600;
    info.nextusetime = 0;
    info utility::addsmartobjectanim( "loop" );
    return info;
}

// Namespace hunt_point
// Params 1
// Checksum 0xdf42703c, Offset: 0x1bc
// Size: 0x183
function onuse( object )
{
    var_bf74509b62df74c2 = self._blackboard.var_478ad046301809a4;
    pod = undefined;
    assert( isdefined( pod ) );
    job = pod group::function_3d7d78fa51b4c2e3( self );
    otherguy = job.guys[ 0 ];
    
    if ( self == otherguy )
    {
        otherguy = job.guys[ 1 ];
    }
    
    var_f1a81a1f1d44c63f = otherguy.var_30e8635fc82c36d7;
    
    if ( self == job.leader )
    {
        exit_wait = randomintrange( 1200, 2800 );
        self.var_1d328097c8f5909c = self.origin;
        self.var_fb8a7aa17ec3708 = 1;
        self.var_51c18c65e845d655 = exit_wait;
        gesture::ai_request_gesture( "military_point", var_bf74509b62df74c2, 1000, "first_hunt_gesture" );
        self waittill( #"first_hunt_gesture" );
        
        if ( !isdefined( var_f1a81a1f1d44c63f ) )
        {
            gesture::ai_request_gesture( "talk", undefined, 1000, "hunt_gesture" );
        }
        else
        {
            otherguy utility::delaycall( 0.5, &glanceatpos, var_f1a81a1f1d44c63f, 300 );
            gesture::ai_request_gesture( "military_point", var_f1a81a1f1d44c63f, 1000, "hunt_gesture" );
        }
    }
    else
    {
        gesture::ai_request_gesture( "yes", undefined, 1000, "hunt_gesture" );
    }
    
    thread waitforgesture( "hunt_gesture" );
    battlechatter::set_cooldown( "coordinate", 20 );
}

// Namespace hunt_point
// Params 1
// Checksum 0xb2b834d3, Offset: 0x347
// Size: 0x7c
function waitforgesture( flag )
{
    self endon( #"death" );
    self endon( #"smartobject_logic_finished" );
    self setlookatentity();
    childthread waitforgesture_timeout( 10 );
    
    while ( true )
    {
        self waittill( flag, status );
        
        if ( status == "gesture_finish" || status == "gesture_cancel" )
        {
            break;
        }
    }
    
    asm::asm_fireevent( self.asmname, "smartobject_finished" );
}

// Namespace hunt_point
// Params 1
// Checksum 0x54d949c, Offset: 0x3cb
// Size: 0x24
function waitforgesture_timeout( t )
{
    wait t;
    asm::asm_fireevent( self.asmname, "smartobject_finished" );
}

