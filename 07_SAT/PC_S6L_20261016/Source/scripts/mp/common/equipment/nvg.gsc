// scripts\mp\common\equipment\nvg.gsc  (hash_7897affa175bfab6.gscc) (size: 5002 Bytes / 0x138a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x20d920b0 (551100592)
// size ...... 5002 (0x138a)
// includes .. 6   (offset: 0x11f2)
// strings ... 24  (offset: 0x1222)
// dev strs .. 0   (offset: 0x138a)
// exports ... 21  (offset: 0xa3a)
// cseg ...... 0x19a + 0x8a0 (0xa3a)
// imports ... 38  (offset: 0xd82)
// animtree1 . 0   (offset: 0x138a)
// animtree2 . 0   (offset: 0x138a)
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\analyticslog;
#using scripts\mp\br\gametypes\br_default_inventory;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\flags;

#namespace nvg;

// Namespace nvg
// Params 0
// Checksum 0xf7e170f9, Offset: 0x1b8
// Size: 0xb0
function runnvg()
{
    val::nuke( "nvg" );
    
    if ( !flags::gameflag( "prematch_done" ) && isdefined( self.infil ) )
    {
        val::set( "runNVG", "nvg", 0 );
        thread allownvgsatmatchstart();
    }
    else
    {
        val::reset_all( "runNVG" );
    }
    
    if ( !isdefined( self.pers[ "useNVG" ] ) )
    {
        self.pers[ "useNVG" ] = 0;
    }
    
    if ( !isdefined( self.pers[ "killstreak_forcedNVGOff" ] ) )
    {
        self.pers[ "killstreak_forcedNVGOff" ] = 0;
    }
    
    thread function_3cacc0efc9e11170();
    thread function_56123d6181dc1406();
    thread nvg_monitor();
}

// Namespace nvg
// Params 0
// Checksum 0xfee4d85f, Offset: 0x270
// Size: 0x3e
function allownvgsatmatchstart()
{
    self notify( #"hash_858974e8e59205d6" );
    self endon( #"hash_858974e8e59205d6" );
    self endon( #"disconnect" );
    flags::gameflagwait( "prematch_done" );
    val::reset_all( "runNVG" );
}

// Namespace nvg
// Params 1
// Checksum 0xaa8238c7, Offset: 0x2b6
// Size: 0x3c
function clearnvg( clearmodel )
{
    if ( isdefined( self.nvg3rdpersonmodel ) )
    {
        if ( clearmodel )
        {
            self detach( self.nvg3rdpersonmodel, "j_head" );
        }
        
        self.nvg3rdpersonmodel = undefined;
    }
}

// Namespace nvg
// Params 0
// Checksum 0x7497a4d5, Offset: 0x2fa
// Size: 0x4d
function savenvgstate()
{
    if ( self isnightvisionon() )
    {
        self.pers[ "useNVG" ] = 1;
        return;
    }
    
    if ( !self isnightvisionon() && !self.pers[ "killstreak_forcedNVGOff" ] )
    {
        self.pers[ "useNVG" ] = 0;
    }
}

// Namespace nvg
// Params 0
// Checksum 0x410c2f72, Offset: 0x34f
// Size: 0xa9
function nvg_monitor()
{
    self notify( #"hash_bcd4445eb0a3afb" );
    self endon( #"hash_bcd4445eb0a3afb" );
    self endon( #"disconnect" );
    
    while ( true )
    {
        result = utility::waittill_any_return( "night_vision_on", "night_vision_off", "death" );
        
        if ( !isdefined( result ) )
        {
            continue;
        }
        
        if ( result == "death" )
        {
            if ( isbrgamemode() && game_utility::getgametype() == "dmz" )
            {
                self nightvisionviewoff( 1 );
                nvgtoggle( 0 );
            }
            
            break;
        }
        
        enabled = result == "night_vision_on";
        nvgtoggle( enabled );
    }
}

// Namespace nvg
// Params 1
// Checksum 0xe7c7dd43, Offset: 0x400
// Size: 0x9d
function nvgtoggle( isenabled )
{
    savenvgstate();
    nvg_update3rdperson( isenabled );
    
    if ( isenabled )
    {
        level notify( #"hash_d94a0708ab9a7c55" );
    }
    
    function_137d72b11872dddf( isenabled );
    var_92a7c5d235ba6859 = gettime();
    duration = var_92a7c5d235ba6859 - ( isdefined( self.var_16a022999cfde024 ) ? self.var_a7a18d0e9d96f58a : 0 );
    analyticslog::logevent_nvgtoggled( gettime(), self.lifeid, self.origin, isenabled, duration, "none" );
    self.var_a7a18d0e9d96f58a = var_92a7c5d235ba6859;
}

// Namespace nvg
// Params 0
// Checksum 0xab655875, Offset: 0x4a5
// Size: 0x98
function function_3cacc0efc9e11170()
{
    level endon( #"game_ended" );
    self notify( #"nvg_monitorblocking" );
    self endon( #"nvg_monitorblocking" );
    thread nvg_watchgameended();
    self endon( #"disconnect" );
    
    while ( true )
    {
        self waittill( #"pickup_object" );
        childthread function_52f4a4182eecfa26();
        
        if ( utility::is_player_gamepad_enabled() )
        {
            function_c3a79132fb26cc7e( 0 );
        }
        
        utility::waittill_any( "manual_drop", "force_manual_drop", "manual_drop_cleanup", "bomb_planted", "death" );
        
        if ( utility::is_player_gamepad_enabled() )
        {
            function_c3a79132fb26cc7e( 1 );
        }
    }
}

// Namespace nvg
// Params 0
// Checksum 0xc8e9db48, Offset: 0x545
// Size: 0x34
function nvg_watchgameended()
{
    self endon( #"nvg_monitorblocking" );
    self endon( #"disconnect" );
    level waittill( #"start_game_ended" );
    
    if ( isdefined( self ) )
    {
        function_c3a79132fb26cc7e( 0 );
    }
}

// Namespace nvg
// Params 1
// Checksum 0x97fdff7, Offset: 0x581
// Size: 0x38
function function_137d72b11872dddf( isenabled )
{
    togglelight = isenabled ? "on" : "off";
    self setscriptablepartstate( "3PLight", togglelight, 0 );
}

// Namespace nvg
// Params 0
// Checksum 0x802da890, Offset: 0x5c1
// Size: 0xca
function function_56123d6181dc1406()
{
    level endon( #"game_ended" );
    self notify( #"hash_631229f66b0bb06c" );
    self endon( #"hash_631229f66b0bb06c" );
    self endon( #"disconnect" );
    self endon( #"death" );
    
    while ( true )
    {
        childthread function_9d21f3cb9cbff047( "grenade_pullback" );
        childthread function_9d21f3cb9cbff047( "weapon_switch" );
        childthread function_9d21f3cb9cbff047( "offhand_end" );
        self waittill( #"hash_a53f98f3b83ff269", newweapon );
        
        if ( !isdefined( newweapon ) || !function_50f2960cc66d5e9b( newweapon ) )
        {
            function_d540b9a052b971d7( 1 );
        }
        else
        {
            function_d540b9a052b971d7( 0 );
        }
        
        if ( self.pers[ "useNVG" ] )
        {
            function_137d72b11872dddf( function_938e6eaf1e289d9f() );
        }
    }
}

// Namespace nvg
// Params 1
// Checksum 0x826a0472, Offset: 0x693
// Size: 0x38
function function_9d21f3cb9cbff047( waittillstring )
{
    self endon( #"hash_a53f98f3b83ff269" );
    self waittill( waittillstring, weapon );
    self notify( #"hash_a53f98f3b83ff269", weapon );
}

// Namespace nvg
// Params 0
// Checksum 0x89f22f1d, Offset: 0x6d3
// Size: 0x1a
function function_938e6eaf1e289d9f()
{
    cantoggle = istrue( self.var_89a0227aedb04d0c );
    return cantoggle;
}

// Namespace nvg
// Params 1
// Checksum 0x492d74d2, Offset: 0x6f6
// Size: 0x29
function function_d540b9a052b971d7( cantoggle )
{
    if ( cantoggle )
    {
        self.var_89a0227aedb04d0c = 1;
        return;
    }
    
    self.var_89a0227aedb04d0c = undefined;
}

// Namespace nvg
// Params 1
// Checksum 0xc6adc74e, Offset: 0x727
// Size: 0x8a
function function_50f2960cc66d5e9b( weapon )
{
    if ( !isdefined( weapon.basenamehash ) )
    {
        return 0;
    }
    
    switch ( weapon.basenamehash )
    {
        case %"super_remote_map_mp":
        case %"hb_sensor_mp":
        case %"ks_remote_device_mp":
        case %"ks_remote_map_mp":
        case %"super_remote_device_mp":
        case %"iw9_me_riotshield_mp":
            return 1;
        default:
            return 0;
    }
}

// Namespace nvg
// Params 0
// Checksum 0xbb8c3cf1, Offset: 0x7b9
// Size: 0x55
function function_52f4a4182eecfa26()
{
    self endon( #"manual_drop" );
    self endon( #"force_manual_drop" );
    self notify( #"hash_bbde4cfb14e56980" );
    self endon( #"hash_bbde4cfb14e56980" );
    
    while ( true )
    {
        self waittill( #"input_type_changed" );
        function_c3a79132fb26cc7e( !utility::is_player_gamepad_enabled() );
    }
}

// Namespace nvg
// Params 1
// Checksum 0xb68474ea, Offset: 0x816
// Size: 0x32
function function_c3a79132fb26cc7e( isallowed )
{
    if ( isallowed )
    {
        val::reset_all( "blockNVGs" );
        return;
    }
    
    val::set( "blockNVGs", "nvg", 0 );
}

// Namespace nvg
// Params 0
// Checksum 0xbff38ce5, Offset: 0x850
// Size: 0x77
function nvg_get3rdpersonupmodel()
{
    modelup = undefined;
    
    if ( isdefined( level.nvgheadoverrides[ self.operatorcustomization.head ] ) )
    {
        modelup = level.nvgheadoverrides[ self.operatorcustomization.head ][ "up" ];
    }
    
    modeloverride = getdvar( @"hash_59fbd1482230b72f" );
    
    if ( modeloverride )
    {
        modelup = modeloverride;
    }
    
    return modelup;
}

// Namespace nvg
// Params 0
// Checksum 0x1f325fa4, Offset: 0x8d0
// Size: 0x77
function nvg_get3rdpersondownmodel()
{
    modeldown = undefined;
    
    if ( isdefined( level.nvgheadoverrides[ self.operatorcustomization.head ] ) )
    {
        modeldown = level.nvgheadoverrides[ self.operatorcustomization.head ][ "down" ];
    }
    
    modeloverride = getdvar( @"hash_59fbd1482230b72f" );
    
    if ( modeloverride )
    {
        modeldown = modeloverride;
    }
    
    return modeldown;
}

// Namespace nvg
// Params 1
// Checksum 0x1a58d505, Offset: 0x950
// Size: 0xc0
function nvg_update3rdperson( enabled )
{
    if ( isdefined( self.nvg3rdpersonmodel ) )
    {
        self detach( self.nvg3rdpersonmodel, "j_head" );
        self.nvg3rdpersonmodel = undefined;
    }
    
    if ( getdvarint( @"hash_e3e35ec6cd674ca", 0 ) == 1 )
    {
        return;
    }
    
    if ( enabled )
    {
        modeldown = nvg_get3rdpersondownmodel();
        
        if ( isdefined( modeldown ) )
        {
            self.nvg3rdpersonmodel = modeldown;
            self attach( self.nvg3rdpersonmodel, "j_head" );
        }
        
        return;
    }
    
    modelup = nvg_get3rdpersonupmodel();
    
    if ( isdefined( modelup ) )
    {
        self.nvg3rdpersonmodel = modelup;
        self attach( self.nvg3rdpersonmodel, "j_head" );
    }
}

// Namespace nvg
// Params 0
// Checksum 0xcaf4e32b, Offset: 0xa18
// Size: 0x21, Type: bool
function function_c58b7b66805088f5()
{
    return utility::function_2a082dafe6f4bd5b() && !br_default_inventory::isbackpackinventoryenabled() && !self.gulag;
}

