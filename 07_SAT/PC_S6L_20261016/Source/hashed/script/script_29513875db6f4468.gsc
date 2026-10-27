// script_29513875db6f4468  (hash_29513875db6f4468.gscc) (size: 2693 Bytes / 0xa85 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbe3ce40f (3191661583)
// size ...... 2693 (0xa85)
// includes .. 3   (offset: 0x9ad)
// strings ... 14  (offset: 0x9c5)
// dev strs .. 0   (offset: 0xa85)
// exports ... 12  (offset: 0x569)
// cseg ...... 0x13f + 0x42a (0x569)
// imports ... 21  (offset: 0x749)
// animtree1 . 0   (offset: 0xa85)
// animtree2 . 0   (offset: 0xa85)
#using scripts\common\omnvar_utility;
#using scripts\common\system;
#using scripts\common\utility;

#namespace namespace_48bd447b87ff9a87;

// Namespace namespace_48bd447b87ff9a87
// Params 0, eflags: 0x5
// Checksum 0xafb55a1f, Offset: 0x15d
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"player_frozen", undefined, undefined, &init );
}

// Namespace namespace_48bd447b87ff9a87
// Params 0
// Checksum 0x556b017e, Offset: 0x17e
// Size: 0x47
function init()
{
    if ( getdvarint( @"hash_49e9955ad4b63d20", 1 ) )
    {
        omnvar_utility::function_848be99d5f69a20e( "ui_br_player_is_in_gas", &function_4fc4826a46b3f57e );
        omnvar_utility::function_848be99d5f69a20e( "swim_under_water", &function_cea6728424784910 );
        omnvar_utility::function_848be99d5f69a20e( "ui_br_altimeter_state", &updateplayerinair );
    }
}

// Namespace namespace_48bd447b87ff9a87
// Params 0, eflags: 0x4
// Checksum 0x21b8b4d8, Offset: 0x1cd
// Size: 0x4b
function private function_54916447bd75e2b5()
{
    if ( !isdefined( self.var_29a43f37bcf15b2 ) )
    {
        self.var_29a43f37bcf15b2 = { #iceanimtime:0, #var_9a219c724e072a4e:0, #var_86ff4fb6fade1e0c:[ "isInAir":0, "isInWater":0, "isInGas":0 ] };
    }
}

// Namespace namespace_48bd447b87ff9a87
// Params 0, eflags: 0x4
// Checksum 0x95572fb7, Offset: 0x220
// Size: 0xa7
function private function_4f3f443dffb4705a()
{
    var_41e99880342a5c29 = int( round( self.var_29a43f37bcf15b2.iceanimtime / 4, 0.25 ) * 100 );
    outrostate = "reverse_100";
    
    switch ( var_41e99880342a5c29 )
    {
        case 0:
            outrostate = "reset";
            break;
        case 25:
            outrostate = "reverse_25";
            break;
        case 50:
            outrostate = "reverse_50";
            break;
        case 75:
            outrostate = "reverse_75";
            break;
    }
    
    return outrostate;
}

// Namespace namespace_48bd447b87ff9a87
// Params 0, eflags: 0x4
// Checksum 0xf9e3c0ed, Offset: 0x2d0
// Size: 0x3d
function private function_c9f2521b575057d5()
{
    level endon( #"game_ended" );
    self endon( #"hash_b5ed3293ec389fef" );
    self endon( #"death_or_disconnect" );
    
    while ( self.spawninginprogress )
    {
        waitframe();
    }
    
    function_8ac234b23e174c0();
}

// Namespace namespace_48bd447b87ff9a87
// Params 0, eflags: 0x4
// Checksum 0xcdcb18ec, Offset: 0x315
// Size: 0x84
function private function_c196437ac77a06d4()
{
    level endon( #"game_ended" );
    self endon( #"hash_b5ed3293ec389fef" );
    self endon( #"death_or_disconnect" );
    self.var_29a43f37bcf15b2.iceanimtime = 0;
    
    while ( self.var_29a43f37bcf15b2.iceanimtime < 4 )
    {
        wait 1;
        self.var_29a43f37bcf15b2.iceanimtime += 1;
    }
}

// Namespace namespace_48bd447b87ff9a87
// Params 0, eflags: 0x4
// Checksum 0xeb6a9092, Offset: 0x3a1
// Size: 0x93
function private function_8ac234b23e174c0()
{
    var_9a219c724e072a4e = istrue( function_f02c63b99c9614c9( self.var_29a43f37bcf15b2.var_86ff4fb6fade1e0c, 1 ) );
    
    if ( self.var_29a43f37bcf15b2.var_9a219c724e072a4e != var_9a219c724e072a4e )
    {
        self.var_29a43f37bcf15b2.var_9a219c724e072a4e = var_9a219c724e072a4e;
        
        if ( var_9a219c724e072a4e )
        {
            self setscriptablepartstate( "ice_build_FX", "forward" );
            thread function_c196437ac77a06d4();
            return;
        }
        
        self notify( #"hash_b5ed3293ec389fef" );
        self setscriptablepartstate( "ice_build_FX", function_4f3f443dffb4705a() );
    }
}

// Namespace namespace_48bd447b87ff9a87
// Params 2, eflags: 0x4
// Checksum 0x24ffa85a, Offset: 0x43c
// Size: 0x8b, Type: bool
function private function_ec02b0c98bb46794( source, var_9a219c724e072a4e )
{
    if ( !self isscriptable() || !self getscriptablehaspart( "ice_build_FX" ) )
    {
        return false;
    }
    
    function_54916447bd75e2b5();
    
    if ( self.var_29a43f37bcf15b2.var_86ff4fb6fade1e0c[ source ] == var_9a219c724e072a4e )
    {
        return false;
    }
    
    self.var_29a43f37bcf15b2.var_86ff4fb6fade1e0c[ source ] = var_9a219c724e072a4e;
    
    if ( self.spawninginprogress )
    {
        thread function_c9f2521b575057d5();
    }
    else
    {
        function_8ac234b23e174c0();
    }
    
    return true;
}

// Namespace namespace_48bd447b87ff9a87
// Params 1
// Checksum 0xbc9c1a6, Offset: 0x4d0
// Size: 0x52
function function_4fc4826a46b3f57e( isingas )
{
    var_38a2c913430c102 = isdefined( self.var_2f8b6417bc00b4a0 );
    
    if ( function_ec02b0c98bb46794( "isInGas", var_38a2c913430c102 ) )
    {
        if ( var_38a2c913430c102 )
        {
            thread utility::play_loop_sound_on_entity( "br_circle_proximity_lp_storm" );
            return;
        }
        
        utility::stop_loop_sound_on_entity( "br_circle_proximity_lp_storm" );
    }
}

// Namespace namespace_48bd447b87ff9a87
// Params 1
// Checksum 0x8a2c92fd, Offset: 0x52a
// Size: 0x1a
function function_cea6728424784910( isInWater )
{
    function_ec02b0c98bb46794( "isInWater", isInWater );
}

// Namespace namespace_48bd447b87ff9a87
// Params 1
// Checksum 0xf09ca4e8, Offset: 0x54c
// Size: 0x1d
function updateplayerinair( altimeterstate )
{
    function_ec02b0c98bb46794( "isInAir", altimeterstate == 1 );
}

