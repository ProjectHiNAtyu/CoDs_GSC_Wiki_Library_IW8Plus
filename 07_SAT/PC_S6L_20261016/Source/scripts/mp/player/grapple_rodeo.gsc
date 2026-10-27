// scripts\mp\player\grapple_rodeo.gsc  (hash_6542881f28f0f6b1.gscc) (size: 2605 Bytes / 0xa2d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x212bcd3e (556518718)
// size ...... 2605 (0xa2d)
// includes .. 3   (offset: 0x9cd)
// strings ... 6   (offset: 0x9e5)
// dev strs .. 0   (offset: 0xa2d)
// exports ... 10  (offset: 0x495)
// cseg ...... 0xe1 + 0x3b4 (0x495)
// imports ... 32  (offset: 0x625)
// animtree1 . 0   (offset: 0xa2d)
// animtree2 . 0   (offset: 0xa2d)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\trace;

#namespace grapple_rodeo;

// Namespace grapple_rodeo
// Params 0, eflags: 0x5
// Checksum 0x71199456, Offset: 0xff
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"grappling_rodeo", #"grappling_hook", undefined, &post_main );
}

// Namespace grapple_rodeo
// Params 0, eflags: 0x4
// Checksum 0xe14d1cb7, Offset: 0x128
// Size: 0xa
function private post_main()
{
    level thread function_fd469ffb68d67e1f();
}

// Namespace grapple_rodeo
// Params 0, eflags: 0x4
// Checksum 0xa6b96322, Offset: 0x13a
// Size: 0x33
function private function_fd469ffb68d67e1f()
{
    level endon( #"game_ended" );
    
    while ( getdvarint( @"scr_rodeo_enabled", 0 ) == 0 )
    {
        waitframe();
    }
    
    function_a00085ff07d2a1d6();
    function_2bfbe9913fb85bca();
}

// Namespace grapple_rodeo
// Params 0, eflags: 0x4
// Checksum 0xdccf00c5, Offset: 0x175
// Size: 0x26
function private function_a00085ff07d2a1d6()
{
    level callback::add( "grappling_hook_onUsed", &function_ef4aa27500a1a944 );
    level callback::add( "grapple_onFired", &function_650556231d7a8bda );
}

// Namespace grapple_rodeo
// Params 0, eflags: 0x4
// Checksum 0xc0d23fd, Offset: 0x1a3
// Size: 0x3b
function private function_2bfbe9913fb85bca()
{
    setdvarifuninitialized( @"grapple_third_person", 0 );
    setdvarifuninitialized( @"scr_rodeo_enabled", 0 );
    setdvarifuninitialized( @"hash_cec3d9288cb961db", getdvarfloat( @"hash_46e1dacd83928399" ) );
}

// Namespace grapple_rodeo
// Params 1, eflags: 0x4
// Checksum 0x17ed8639, Offset: 0x1e6
// Size: 0x210
function private function_650556231d7a8bda( params )
{
    tag_weapon_left = self gettagorigin( "tag_weapon_left" );
    trace = trace::ray_trace( tag_weapon_left, tag_weapon_left + anglestoforward( self getplayerangles() ) * 2200 );
    rodeo_point = undefined;
    
    foreach ( hit in trace )
    {
        if ( isent( hit ) )
        {
            if ( hit.targetname == "s_test_rodeo" )
            {
                rodeo_point = hit;
                break;
            }
            
            if ( hit.script_noteworthy == "grapple_ridable_missile" )
            {
                params = spawnstruct();
                params.missile = hit;
                callback::callback( "grappling_hook_vehicle_ride", params );
                break;
            }
        }
    }
    
    if ( !isdefined( rodeo_point ) )
    {
        return;
    }
    
    setdvar( @"hash_46e1dacd83928399", 0 );
    self waittill( #"grapple_end" );
    
    if ( distance( self.origin, rodeo_point.origin ) > 120 )
    {
        setdvar( @"hash_46e1dacd83928399", getdvarfloat( @"hash_cec3d9288cb961db" ) );
        return;
    }
    
    s_test_rodeo = getent( rodeo_point.target, #targetname );
    s_test_rodeo.view_arcs = [ 90, 90, 20, 60 ];
    self dontinterpolate();
    self setorigin( s_test_rodeo.origin, 1 );
    self playerlinkto( s_test_rodeo );
    self.var_acc6c1949f5186b = 1;
    self setplayerangles( s_test_rodeo.angles );
    
    if ( function_cdd5d90ca1bfeb9f() )
    {
        self setcamerathirdperson( 1 );
    }
    
    thread function_480896ff0e386254();
}

// Namespace grapple_rodeo
// Params 0, eflags: 0x4
// Checksum 0x645b3209, Offset: 0x3fe
// Size: 0x22
function private function_480896ff0e386254()
{
    self endon( #"hash_b74a639a9cf451b3" );
    
    while ( !self jumpbuttonpressed() )
    {
        waitframe();
    }
    
    function_ef4aa27500a1a944();
}

// Namespace grapple_rodeo
// Params 1, eflags: 0x4
// Checksum 0xb6d7169a, Offset: 0x428
// Size: 0x54
function private function_ef4aa27500a1a944( params )
{
    if ( self.var_acc6c1949f5186b )
    {
        self.var_acc6c1949f5186b = 0;
        self unlink();
        
        if ( function_cdd5d90ca1bfeb9f() )
        {
            self setcamerathirdperson( 0 );
        }
        
        waitframe();
        setdvar( @"hash_46e1dacd83928399", getdvarfloat( @"hash_cec3d9288cb961db" ) );
    }
}

// Namespace grapple_rodeo
// Params 0, eflags: 0x4
// Checksum 0xbe73bb6, Offset: 0x484
// Size: 0x10
function private function_cdd5d90ca1bfeb9f()
{
    return getdvarint( @"grapple_third_person", 0 );
}

