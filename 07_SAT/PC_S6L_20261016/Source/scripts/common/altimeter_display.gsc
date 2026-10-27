// scripts\common\altimeter_display.gsc  (hash_3c1037650cdaa3f6.gscc) (size: 2451 Bytes / 0x993 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb0943066 (2962501734)
// size ...... 2451 (0x993)
// includes .. 4   (offset: 0x8db)
// strings ... 9   (offset: 0x8fb)
// dev strs .. 0   (offset: 0x993)
// exports ... 10  (offset: 0x543)
// cseg ...... 0x103 + 0x440 (0x543)
// imports ... 18  (offset: 0x6d3)
// animtree1 . 0   (offset: 0x993)
// animtree2 . 0   (offset: 0x993)
#using scripts\common\callbacks;
#using scripts\common\scripted_widgets;
#using scripts\common\system;
#using scripts\common\utility;

#namespace altimeter_display;

// Namespace altimeter_display
// Params 0, eflags: 0x5
// Checksum 0x55a35004, Offset: 0x121
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"altimeter_display", undefined, undefined, &post_main );
}

// Namespace altimeter_display
// Params 0, eflags: 0x4
// Checksum 0x848b9729, Offset: 0x142
// Size: 0x131
function private post_main()
{
    level.var_fcad5e0ef71703df = spawnstruct();
    level.var_fcad5e0ef71703df.widget = "scripted_widget_altimeter_display";
    level.var_fcad5e0ef71703df.max_altitude = getdvarint( @"scr_altimeter_display_max_altitude", 24000 );
    level.var_fcad5e0ef71703df.var_acd6678d79f63b7c = getdvarint( @"scr_altimeter_display_sea_altitude", 650 );
    level.var_fcad5e0ef71703df.behavior = getdvar( @"scr_altimeter_behavior", "default" );
    callback::add( #"player_spawned", &onplayerspawned );
    
    if ( isdefined( level.players ) )
    {
        foreach ( player in level.players )
        {
            player thread update_altimeter_display();
        }
    }
}

// Namespace altimeter_display
// Params 1
// Checksum 0x573e7b1d, Offset: 0x27b
// Size: 0x22
function function_6904759fef4a96fb( widget )
{
    level.var_fcad5e0ef71703df.widget = widget;
}

// Namespace altimeter_display
// Params 1
// Checksum 0x3e3be12f, Offset: 0x2a5
// Size: 0x22
function set_max_altitude( var_dc3be236543f1358 )
{
    level.var_fcad5e0ef71703df.max_altitude = var_dc3be236543f1358;
}

// Namespace altimeter_display
// Params 1
// Checksum 0xb11d337f, Offset: 0x2cf
// Size: 0x22
function function_894503ac1667338e( var_dc3be236543f1358 )
{
    level.var_fcad5e0ef71703df.var_acd6678d79f63b7c = var_dc3be236543f1358;
}

// Namespace altimeter_display
// Params 0, eflags: 0xc
// Checksum 0xdf9a27aa, Offset: 0x2f9
// Size: 0x61
function private update_altimeter_display()
{
    self notify( #"hash_a6f48bc925d84021" );
    self endon( #"hash_a6f48bc925d84021" );
    
    switch ( level.var_fcad5e0ef71703df.behavior )
    {
        case #"hash_7038dec66d8275be":
            function_32e2d6ba0a26e128();
            break;
        case #"hash_3f250fdff8bc69ff":
            function_c2d6840a0116e87d();
            break;
    }
}

// Namespace altimeter_display
// Params 0, eflags: 0x4
// Checksum 0x2be60543, Offset: 0x362
// Size: 0xcb
function private function_32e2d6ba0a26e128()
{
    self endon( #"death_or_disconnect" );
    
    if ( self._altimeter_display_updating )
    {
        return;
    }
    
    self._altimeter_display_updating = 1;
    
    while ( true )
    {
        self waittill( #"skydive_beginfreefall" );
        scripted_widgets::create( "altimeter", level.var_fcad5e0ef71703df.widget );
        fields = [];
        fields[ "sea_height" ] = level.var_fcad5e0ef71703df.var_acd6678d79f63b7c;
        fields[ "max_altitude" ] = level.var_fcad5e0ef71703df.max_altitude;
        scripted_widgets::function_dd7a63eea5bde0dc( "altimeter", fields, 1 );
        utility::waittill_any( "skydive_end", "last_stand_enter" );
        scripted_widgets::destroy( "altimeter" );
        waitframe();
    }
}

// Namespace altimeter_display
// Params 0, eflags: 0x4
// Checksum 0xebe2e59b, Offset: 0x435
// Size: 0xf3
function private function_c2d6840a0116e87d()
{
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"skydive_beginfreefall" );
        scripted_widgets::create( "altimeter", level.var_fcad5e0ef71703df.widget );
        fields = [];
        fields[ "sea_height" ] = level.var_fcad5e0ef71703df.var_acd6678d79f63b7c;
        fields[ "max_altitude" ] = level.var_fcad5e0ef71703df.max_altitude;
        scripted_widgets::function_dd7a63eea5bde0dc( "altimeter", fields, 1 );
        
        while ( true )
        {
            result = utility::waittill_any_return( "skydive_end", "last_stand_enter", "death", "skydive_interrupt" );
            
            if ( result == "skydive_end" || result == "skydive_interrupt" )
            {
                waitframe();
                
                if ( self isinfreefall() )
                {
                    continue;
                }
            }
            
            break;
        }
        
        scripted_widgets::destroy( "altimeter" );
    }
}

// Namespace altimeter_display
// Params 1, eflags: 0x4
// Checksum 0x5e15396b, Offset: 0x530
// Size: 0x13
function private onplayerspawned( params )
{
    thread update_altimeter_display();
}

