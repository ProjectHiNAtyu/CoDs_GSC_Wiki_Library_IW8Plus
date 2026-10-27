// script_31af9060592e982c  (hash_31af9060592e982c.gscc) (size: 4198 Bytes / 0x1066 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x10249bc2 (270834626)
// size ...... 4198 (0x1066)
// includes .. 9   (offset: 0xf0e)
// strings ... 19  (offset: 0xf56)
// dev strs .. 0   (offset: 0x1066)
// exports ... 17  (offset: 0x7be)
// cseg ...... 0x16d + 0x651 (0x7be)
// imports ... 41  (offset: 0xa66)
// animtree1 . 0   (offset: 0x1066)
// animtree2 . 0   (offset: 0x1066)
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_collision;
#using scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_head;
#using scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_roar;
#using scripts\common\ai\aitypes\zombie_phobos\zombie_phobos_spit;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\common\values;

#namespace namespace_c0f9e550c4119589;

// Namespace namespace_c0f9e550c4119589
// Params 0
// Checksum 0xfb1bd5a2, Offset: 0x18b
// Size: 0x2
function function_6730a542a916ec66()
{
    
}

// Namespace namespace_c0f9e550c4119589
// Params 0
// Checksum 0xd2adb35d, Offset: 0x195
// Size: 0x2
function init_zombie_phobos_jumpout()
{
    
}

// Namespace namespace_c0f9e550c4119589
// Params 3
// Checksum 0xd10e3c8a, Offset: 0x19f
// Size: 0xb8
function jumpout_init( asmname, statename, params )
{
    self function_786bb6aa1b76c7ee( "is_outside_arena", 1 );
    self._blackboard.var_6391b373c0f57a6d = 1;
    zombie_phobos_collision::function_ce05ecd4fb90717( self );
    thread clear_adds();
    self settraversalattributes( self.origin, self.jumpout_target_position, self.jumpout_target_angles, ( 0, 0, 0 ) );
    thread utility::thread_on_notify( "roar_start", &on_roar_start, self, self, [ "jumpin_terminate" ] );
    thread utility::thread_on_notify( "jumpout_prep", &function_8b75520fc137317a, self, self, [ "jumpin_terminate" ] );
}

// Namespace namespace_c0f9e550c4119589
// Params 3
// Checksum 0xf6b5fb10, Offset: 0x25f
// Size: 0x6c
function jumpout_terminate( asmname, statename, params )
{
    self function_786bb6aa1b76c7ee( "is_outside_arena", 1 );
    zombie_phobos_head::reset_head();
    self notify( #"jumpout_terminate" );
    self settraversalattributes( self.origin, self.jumpin_target_position, self.angles, ( 0, 0, 0 ) );
}

// Namespace namespace_c0f9e550c4119589
// Params 3
// Checksum 0x58bde9c8, Offset: 0x2d3
// Size: 0xa2
function jumpin_init( asmname, statename, params )
{
    utility::function_7c10ea82c1e305b8( "out_of_arena", "off" );
    self animmode( "nogravity" );
    thread utility::thread_on_notify( "remove_immunity", &remove_immunity, self, self, [ "jumpin_terminate" ] );
    thread utility::thread_on_notify( "hit_ground", &hit_ground, self, self, [ "jumpin_terminate" ] );
    self settraversalattributes( self.origin, self.jumpin_target_position, self.angles, ( 0, 0, 0 ) );
}

// Namespace namespace_c0f9e550c4119589
// Params 3
// Checksum 0x2e64308c, Offset: 0x37d
// Size: 0x61
function jumpin_terminate( asmname, statename, params )
{
    self function_786bb6aa1b76c7ee( "is_outside_arena", 0 );
    val::reset_all( "out_of_arena" );
    self.var_cffd4250b352cef4 = 0;
    self notify( #"jumpin_terminate" );
    self._blackboard.var_6391b373c0f57a6d = 0;
}

// Namespace namespace_c0f9e550c4119589
// Params 3
// Checksum 0x4cb11fe7, Offset: 0x3e6
// Size: 0x65
function jumpout_chooseanim( asmname, statename, params )
{
    yaw = utility::getyawtospot( self.jumpout_target_position );
    alias = "normal";
    
    if ( abs( yaw ) > 135 )
    {
        alias = "180";
    }
    
    return asm::asm_chooseanim( asmname, statename, alias );
}

// Namespace namespace_c0f9e550c4119589
// Params 0
// Checksum 0x85fd0158, Offset: 0x454
// Size: 0xe
function function_7606688f5fd124c6()
{
    asm::asm_setstate( "jumpout_in" );
}

// Namespace namespace_c0f9e550c4119589
// Params 0, eflags: 0x4
// Checksum 0xa1101930, Offset: 0x46a
// Size: 0xc
function private remove_immunity()
{
    self.var_cffd4250b352cef4 = 0;
}

// Namespace namespace_c0f9e550c4119589
// Params 0, eflags: 0x4
// Checksum 0x349b8450, Offset: 0x47e
// Size: 0xa9
function private hit_ground()
{
    earthquake( 0.4, 3, self.origin, 2000 );
    players = getplayersinradius( self.origin, 2000 );
    
    foreach ( player in players )
    {
        player playrumbleonentity( "heavy_1s" );
    }
}

// Namespace namespace_c0f9e550c4119589
// Params 0, eflags: 0x4
// Checksum 0x68e5a0c9, Offset: 0x52f
// Size: 0xd5
function private clear_adds()
{
    self endon( #"death" );
    utility::ent_flag_set( "pause_add_spawning" );
    zombies = getaiarrayinradius( self.origin, 2000, self.team );
    
    foreach ( zombie in zombies )
    {
        if ( !isalive( zombie ) || !zombie val::get( "death" ) || self == zombie )
        {
            continue;
        }
        
        zombie kill();
        waitframe();
    }
}

// Namespace namespace_c0f9e550c4119589
// Params 0, eflags: 0x4
// Checksum 0x518ee49e, Offset: 0x60c
// Size: 0x84
function private on_roar_start()
{
    self endon( #"death" );
    zombie_phobos_roar::start_roar();
    thread zombie_phobos_roar::roar_rumble();
    zombie_phobos_spit::function_13c285f3a5c52573( self );
    level callback::callback( "phobos_flood_arena_vo" );
    utility::function_7c10ea82c1e305b8( "out_of_arena", "on" );
    self.var_cffd4250b352cef4 = 1;
    utility::delaythreadendon( 100, "jumpin_terminate", &cleanup_immune );
    utility::waittill_any( "roar_end", "jumpout_terminate" );
    zombie_phobos_roar::cleanup_roar();
    self notify( #"end_roar" );
}

// Namespace namespace_c0f9e550c4119589
// Params 0, eflags: 0x4
// Checksum 0xb19dcc1d, Offset: 0x698
// Size: 0x2
function private on_roar_end()
{
    
}

// Namespace namespace_c0f9e550c4119589
// Params 0, eflags: 0x4
// Checksum 0x77a7ee86, Offset: 0x6a2
// Size: 0x29
function private cleanup_immune()
{
    val::reset_all( "out_of_arena" );
    self.var_cffd4250b352cef4 = 0;
    utility::function_7c10ea82c1e305b8( "out_of_arena", "off" );
}

// Namespace namespace_c0f9e550c4119589
// Params 1, eflags: 0x4
// Checksum 0x1f439210, Offset: 0x6d3
// Size: 0xcd
function private function_8b75520fc137317a( yaw )
{
    self endon( #"death" );
    self endon( #"jumpout_terminate" );
    end_time = gettime() + utility::function_4b74c15943231980( level.framedurationseconds ) * 10;
    
    while ( gettime() < end_time )
    {
        new_yaw = math::function_5cf1e88395e33eba( self.origin, self.jumpout_target_position, getdvarfloat( @"hash_ef074e57c2a355fa", 5 ), self.angles[ 1 ] );
        self.angles = ( self.angles[ 0 ], new_yaw, self.angles[ 2 ] );
        self forceteleport( self.origin, self.angles );
        waitframe();
    }
}

/#

    // Namespace namespace_c0f9e550c4119589
    // Params 0, eflags: 0x4
    // Checksum 0x482b45f5, Offset: 0x7a8
    // Size: 0x16, Type: dev
    function private debug_jumpout()
    {
        return getdvarint( @"hash_339af1b3500c22f6", 0 ) > 0;
    }

#/
