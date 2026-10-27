// scripts\mp\ob\supers\annihilator.gsc  (hash_7bf383739b7ccf76.gscc) (size: 2014 Bytes / 0x7de / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb93d35d2 (3107796434)
// size ...... 2014 (0x7de)
// includes .. 3   (offset: 0x7a2)
// strings ... 1   (offset: 0x7ba)
// dev strs .. 1   (offset: 0x7d2)
// exports ... 10  (offset: 0x39a)
// cseg ...... 0x6d + 0x32d (0x39a)
// imports ... 21  (offset: 0x52a)
// animtree1 . 0   (offset: 0x7de)
// animtree2 . 0   (offset: 0x7de)
#using scripts\common\callbacks;
#using scripts\mp\common\utility\points;
#using scripts\mp\supers;

#namespace annihilator;

// Namespace annihilator
// Params 0, eflags: 0x5
// Checksum 0x78b0a385, Offset: 0x8b
// Size: 0x18
function private autoexec main()
{
    level callback::add( #"register_super", &register );
}

// Namespace annihilator
// Params 1, eflags: 0x4
// Checksum 0x1db6786, Offset: 0xab
// Size: 0x9a
function private register( params )
{
    staticdata = level.superglobals.staticsuperdata[ "super_annihilator" ];
    
    if ( !isdefined( staticdata ) )
    {
        return;
    }
    
    bundle = staticdata.bundle;
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    level callback::add( #"on_ai_killed", &function_dc09e88dc727432d );
    level callback::add( #"player_death", &function_dc09e88dc727432d );
    supers_mp::function_48aaa60b2ce7b8a1( "super_annihilator", undefined, undefined, &begin_use, &end_use );
}

// Namespace annihilator
// Params 0
// Checksum 0xbc9bfacf, Offset: 0x14d
// Size: 0x76, Type: bool
function begin_use()
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_annihilator" );
    
    if ( !isdefined( bundle ) )
    {
        assertmsg( "<dev string:x24>" );
        return false;
    }
    
    if ( bundle.var_8b9eade13fbfb044 && !callback::exists( #"super_cancel", &cancel ) )
    {
        callback::add( #"super_cancel", &cancel );
    }
    
    thread function_81dec571c9ccd00a( bundle );
    return true;
}

// Namespace annihilator
// Params 2
// Checksum 0x1b56c40d, Offset: 0x1cc
// Size: 0x61
function end_use( fromdeath, attacker )
{
    if ( callback::exists( #"super_cancel", &cancel ) )
    {
        callback::remove( #"super_cancel", &cancel );
    }
    
    if ( fromdeath )
    {
        return;
    }
    
    self notify( #"annihilator_end" );
    function_f115db87963d3c01();
    change_weapon_on_ladder();
}

// Namespace annihilator
// Params 1, eflags: 0x4
// Checksum 0xf8a4194e, Offset: 0x235
// Size: 0x18
function private cancel( params )
{
    supers_mp::reducesuperusepercent( 1 );
}

// Namespace annihilator
// Params 0, eflags: 0x4
// Checksum 0x782336db, Offset: 0x255
// Size: 0x2d
function private change_weapon_on_ladder()
{
    if ( self isonladder() )
    {
        currentweapon = self getcurrentweapon();
        self setweaponammostock( currentweapon, 0 );
        self setweaponammoclip( currentweapon, 0 );
    }
}

// Namespace annihilator
// Params 0, eflags: 0x4
// Checksum 0x90e3a074, Offset: 0x28a
// Size: 0x4b
function private function_f115db87963d3c01()
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_annihilator" );
    
    if ( isdefined( bundle.var_5d7006fb6c782ce2 ) )
    {
        weapon = self getcurrentweapon();
        thread points::doscoreevent( bundle.var_5d7006fb6c782ce2, weapon );
    }
}

// Namespace annihilator
// Params 1, eflags: 0x4
// Checksum 0xb7af9591, Offset: 0x2dd
// Size: 0x46
function private function_dc09e88dc727432d( params )
{
    attacker = params.eattacker ?? params.attacker;
    
    if ( !isdefined( attacker ) )
    {
        return;
    }
    
    attacker notify( #"annihilator_kill" );
}

// Namespace annihilator
// Params 1, eflags: 0x4
// Checksum 0x5e9c5133, Offset: 0x32b
// Size: 0x6f
function private function_81dec571c9ccd00a( bundle )
{
    self endon( #"annihilator_end" );
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( bundle.eliminationscoreevent ) )
    {
        return;
    }
    
    while ( true )
    {
        self waittill( #"annihilator_kill" );
        weapon = self getcurrentweapon();
        thread points::doscoreevent( bundle.eliminationscoreevent, weapon );
    }
}

