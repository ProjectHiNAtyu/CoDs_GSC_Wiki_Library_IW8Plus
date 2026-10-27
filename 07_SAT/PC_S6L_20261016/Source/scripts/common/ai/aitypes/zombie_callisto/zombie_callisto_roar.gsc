// scripts\common\ai\aitypes\zombie_callisto\zombie_callisto_roar.gsc  (hash_7bb672bdd28d0faf.gscc) (size: 2492 Bytes / 0x9bc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xdd0e8b33 (3708717875)
// size ...... 2492 (0x9bc)
// includes .. 4   (offset: 0x8f8)
// strings ... 3   (offset: 0x918)
// dev strs .. 9   (offset: 0x950)
// exports ... 11  (offset: 0x40c)
// cseg ...... 0x8c + 0x380 (0x40c)
// imports ... 29  (offset: 0x5c4)
// animtree1 . 0   (offset: 0x9bc)
// animtree2 . 0   (offset: 0x9bc)
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\devgui;
#using scripts\common\utility;

#namespace zombie_callisto_roar;

/#

    // Namespace zombie_callisto_roar
    // Params 0
    // Checksum 0x13db7332, Offset: 0xaa
    // Size: 0xc, Type: dev
    function function_2add3f1f5708b07c()
    {
        setup_roar_devgui();
    }

#/

// Namespace zombie_callisto_roar
// Params 0
// Checksum 0x6e3c1a69, Offset: 0xbe
// Size: 0x9
function init_zombie_callisto_roar()
{
    thread roar_listener();
}

// Namespace zombie_callisto_roar
// Params 0, eflags: 0x4
// Checksum 0xf15583d1, Offset: 0xcf
// Size: 0x2a
function private roar_listener()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"roar_start" );
        thread on_roar();
    }
}

// Namespace zombie_callisto_roar
// Params 0, eflags: 0x4
// Checksum 0xe41944bc, Offset: 0x101
// Size: 0x3a
function private on_roar()
{
    self endon( #"death" );
    self endon( #"end_roar" );
    thread roar_rumble();
    self waittill( #"roar_end" );
    self function_786bb6aa1b76c7ee( "in_roar", 0 );
}

// Namespace zombie_callisto_roar
// Params 0, eflags: 0x4
// Checksum 0x853f9bf7, Offset: 0x143
// Size: 0xf1
function private roar_rumble()
{
    self endon( #"death" );
    self endon( #"end_roar" );
    var_899f13d46cd7e7c8 = 600;
    
    while ( self getaiblackboarddynamic( "in_roar" ) )
    {
        earthquake( 0.28, 2.3, self.origin, var_899f13d46cd7e7c8 );
        players = getplayersinradius( self.origin, var_899f13d46cd7e7c8 );
        
        foreach ( player in players )
        {
            if ( !player utility::ent_flag( "callisto_roar_rumble" ) )
            {
                thread roar_rumble_on_player( player, var_899f13d46cd7e7c8 );
            }
        }
        
        wait 1;
    }
}

// Namespace zombie_callisto_roar
// Params 2, eflags: 0x4
// Checksum 0xdde6849d, Offset: 0x23c
// Size: 0xee
function private roar_rumble_on_player( player, var_899f13d46cd7e7c8 )
{
    player endon( #"death_or_disconnect" );
    assert( !player utility::ent_flag( "<dev string:x24>" ) );
    player utility::ent_flag_set( "callisto_roar_rumble" );
    player playrumblelooponentity( "steady_rumble" );
    
    while ( true )
    {
        var_6406b411db6be5c4 = isalive( self );
        var_142023f7e745d008 = 0;
        var_7eb7e23ce7ac5e38 = 0;
        
        if ( var_6406b411db6be5c4 )
        {
            var_48607cfdb87ffbae = distance2dsquared( self.origin, player.origin );
            var_142023f7e745d008 = var_48607cfdb87ffbae > squared( var_899f13d46cd7e7c8 );
            var_7eb7e23ce7ac5e38 = !self getaiblackboarddynamic( "in_roar" );
        }
        
        if ( !var_6406b411db6be5c4 || var_7eb7e23ce7ac5e38 || var_142023f7e745d008 )
        {
            player utility::ent_flag_clear( "callisto_roar_rumble" );
            player stoprumble( "steady_rumble" );
            return;
        }
        
        waitframe();
    }
}

/#

    // Namespace zombie_callisto_roar
    // Params 0
    // Checksum 0x3a7fa634, Offset: 0x332
    // Size: 0x44, Type: dev
    function setup_roar_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x39>" );
        devgui::add_devgui_func( "<dev string:x53>", "<dev string:x5e>", &function_6167bd4dd082d22 );
        devgui::add_devgui_func( "<dev string:x72>", "<dev string:x7d>", &toggle_debug_roar );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_callisto_roar
    // Params 0, eflags: 0x4
    // Checksum 0xbda2a06b, Offset: 0x37e
    // Size: 0x44, Type: dev
    function private function_6167bd4dd082d22()
    {
        callisto = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x91>" );
        
        if ( isdefined( callisto ) )
        {
            asm::function_7256f5ba459c840b( "<dev string:xa1>" );
        }
    }

    // Namespace zombie_callisto_roar
    // Params 1, eflags: 0x4
    // Checksum 0x822ed35f, Offset: 0x3ca
    // Size: 0x24, Type: dev
    function private toggle_debug_roar( params )
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xa9>", @"hash_2355de33292cc664" );
    }

    // Namespace zombie_callisto_roar
    // Params 0, eflags: 0x4
    // Checksum 0x6c2931b6, Offset: 0x3f6
    // Size: 0x16, Type: dev
    function private debug_roar()
    {
        return getdvarint( @"hash_2355de33292cc664", 0 ) > 0;
    }

#/
