// scripts\mp\zm\ztron\ztron_weather.gsc  (hash_7390fc30ef0c4bdc.gscc) (size: 7393 Bytes / 0x1ce1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1885a689 (411412105)
// size ...... 7393 (0x1ce1)
// includes .. 6   (offset: 0x1af5)
// strings ... 11  (offset: 0x1b25)
// dev strs .. 21  (offset: 0x1bc1)
// exports ... 21  (offset: 0x1269)
// cseg ...... 0x14c + 0x111d (0x1269)
// imports ... 42  (offset: 0x15b1)
// animtree1 . 0   (offset: 0x1ce1)
// animtree2 . 0   (offset: 0x1ce1)
#using script_4bf17c7c52d3ed18;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_main;
#using scripts\mp\zm\ztron\ztron_vfx;

#namespace ztron_weather;

// Namespace ztron_weather
// Params 0
// Checksum 0xd6b3d647, Offset: 0x16a
// Size: 0x257
function init()
{
    level.ztron.weather = spawnstruct();
    level.ztron.weather.currentconfig = undefined;
    weatherbundle = getscriptbundle( %"hash_7acd4e32c073cce" );
    level.ztron.weather.enabled = weatherbundle.var_f0607bd0a95e7f35;
    
    if ( level.ztron.weather.enabled )
    {
        level.ztron.weather.weatherconfig = [];
        
        foreach ( index, config in weatherbundle.var_dad545d56c6d105d )
        {
            config.index = index;
            level.ztron.weather.weatherconfig[ config.arenaname ] = config;
        }
        
        level.ztron.weather.var_aa0cce5602cde086 = [];
        
        foreach ( config in weatherbundle.var_36cde0699d460e4f )
        {
            level.ztron.weather.var_aa0cce5602cde086[ config.type ] = config;
            utility::add_fx( "ztron_weather_" + config.type, config.scenefx );
        }
        
        /#
            init_ztron_weather_devgui();
        #/
    }
    
    level.ztron.var_d2cdda04885d49d2 = 0;
}

// Namespace ztron_weather
// Params 0
// Checksum 0x626fb75e, Offset: 0x3c9
// Size: 0x34
function main()
{
    self notify( #"hash_a4daf3f299790ff6" );
    self endon( #"hash_a4daf3f299790ff6" );
    level endon( #"ztron_game_is_over" );
    function_118f675e6049a8e0();
    resetlightstate();
}

// Namespace ztron_weather
// Params 0
// Checksum 0x1a2216fe, Offset: 0x405
// Size: 0x20
function function_118f675e6049a8e0()
{
    profilestart();
    level.ztron.var_fa9ef452c4700db8 = [];
    resetweather();
    profilestop();
}

// Namespace ztron_weather
// Params 5
// Checksum 0x6bec898e, Offset: 0x42d
// Size: 0x242
function function_c66678f1a8379c69( arenaname, weathertype, var_5ef40f1d34fcd67d, notewait, roundmask = 15 )
{
    profilestart();
    assert( isdefined( weathertype ), "<dev string:x24>" );
    assert( var_5ef40f1d34fcd67d >= 0 && var_5ef40f1d34fcd67d <= 100, "<dev string:x3f>" );
    
    if ( !isdefined( level.ztron.weather.weatherconfig[ arenaname ] ) )
    {
        assertmsg( "<dev string:x62>" + arenaname + "<dev string:x82>" );
        profilestop();
        return;
    }
    
    weatherpattern = spawnstruct();
    weatherpattern.type = weathertype;
    weatherpattern.chance = var_5ef40f1d34fcd67d;
    weatherpattern.weight = 1;
    weatherpattern.index = level.ztron.weather.weatherconfig[ arenaname ].index;
    weatherpattern.roundmask = roundmask;
    
    foreach ( weather in level.ztron.weather.weatherconfig[ arenaname ].var_b7d73c550e910ff8 )
    {
        if ( weather.weather == weathertype )
        {
            found = 1;
            weatherpattern.weight = weather.weatherweight;
            break;
        }
    }
    
    if ( found )
    {
        level.ztron.var_fa9ef452c4700db8[ level.ztron.var_fa9ef452c4700db8.size ] = weatherpattern;
        
        if ( isdefined( notewait ) )
        {
            level thread function_5f41209984bdae7( notewait );
        }
    }
    else
    {
        assertmsg( "<dev string:x9d>" + weathertype + "<dev string:xaf>" + arenaname );
    }
    
    profilestop();
}

// Namespace ztron_weather
// Params 1
// Checksum 0xe5ae9b81, Offset: 0x677
// Size: 0x62
function function_5f41209984bdae7( note )
{
    level notify( "kill_" + note );
    level endon( "kill_" + note );
    
    while ( true )
    {
        self waittill( note );
        type = function_fac71ebf61f6b039();
        ztron_debug::debugmsg( "Weather trigger change on note: " + note + "   Weather set to type: " + ( type ?? "not defined" ) );
    }
}

// Namespace ztron_weather
// Params 0
// Checksum 0xcb80a170, Offset: 0x6e1
// Size: 0x150
function function_fac71ebf61f6b039()
{
    profilestart();
    
    if ( level.ztron.var_fa9ef452c4700db8.size == 0 )
    {
        profilestop();
        return undefined;
    }
    
    localweather = arrayrandomize( level.ztron.var_fa9ef452c4700db8 );
    
    foreach ( weather in localweather )
    {
        idx = 4 - level.ztron.arena_rounds_left;
        bit = 1 << idx;
        
        if ( ( weather.roundmask & bit ) == 0 )
        {
            continue;
        }
        
        roll = randomint( 100 );
        
        if ( roll < weather.chance )
        {
            setweather( weather.type, weather.weight );
            profilestop();
            return weather.type;
        }
    }
    
    setweather( "Sunny", 1 );
    profilestop();
    return "Sunny";
}

// Namespace ztron_weather
// Params 0
// Checksum 0x2dddec30, Offset: 0x83b
// Size: 0x23
function function_e43312a4fcdadc8a()
{
    setomnvar( "ztron_weather_dust", 0 );
    setomnvar( "ztron_weather_wetness", 0 );
    setomnvar( "ztron_weather_snow", 0 );
}

// Namespace ztron_weather
// Params 0
// Checksum 0x61fec7f5, Offset: 0x866
// Size: 0x6b
function resetweather()
{
    function_e43312a4fcdadc8a();
    
    if ( isdefined( level.ztron.weather.currentfx ) )
    {
        level.ztron.weather.currentfx = ztron_vfx::stopfx( level.ztron.weather.currentfx );
    }
}

// Namespace ztron_weather
// Params 2
// Checksum 0xef84c6b4, Offset: 0x8d9
// Size: 0x2e1
function setweather( weathertype, value )
{
    resetweather();
    
    switch ( weathertype )
    {
        case #"hash_bebb517756471c2c":
            break;
        case #"hash_8c9319cf2fe96de5":
            setomnvar( "ztron_weather_dust", value );
            break;
        case #"hash_15e95a0e184b2218":
            setomnvar( "ztron_weather_wetness", value );
            break;
        case #"hash_e19944f87352932":
            setomnvar( "ztron_weather_snow", value );
            break;
        default:
            assert( 0, "<dev string:xd8>" + weathertype );
            break;
    }
    
    var_aa0cce5602cde086 = level.ztron.weather.var_aa0cce5602cde086[ weathertype ];
    
    if ( isdefined( var_aa0cce5602cde086.scenefx ) )
    {
        state = ztron_main::function_4da200e9b8d58a3c();
        origin = undefined;
        
        if ( state == 1 )
        {
            origin = level.ztron.active_arena.center.origin;
            
            if ( weathertype == "Snow" )
            {
                points = [];
                spots = level.ztron.active_arena.lootspots;
                
                foreach ( spot in spots )
                {
                    points[ points.size ] = spot.origin;
                }
                
                var_ec886a5687d95420 = level.ztron.game_laps;
                
                if ( randomint( 100 ) <= 1 )
                {
                    var_ec886a5687d95420 += 1;
                }
                
                for ( i = 0; i < var_ec886a5687d95420 ; i++ )
                {
                    points = arrayrandomize( points );
                    ztron_hazard_tornado::create_tornado( origin, points );
                }
            }
        }
        else if ( state == 3 )
        {
            origin = level.ztron.var_8a9067aa4cd65369.var_5290e343e7cabade;
        }
        else if ( state == 5 )
        {
            origin = level.ztron.slayer.active_arena.center.origin;
        }
        
        if ( isdefined( origin ) )
        {
            level.ztron.weather.currentfx = ztron_vfx::function_574a3236c59da7d8( "ztron_weather_" + var_aa0cce5602cde086.type, origin );
        }
    }
}

// Namespace ztron_weather
// Params 1
// Checksum 0xe872a2cd, Offset: 0xbc2
// Size: 0x60
function setlightstate( state )
{
    if ( !( getdvarint( @"hash_35f771b555f29316", 1 ) == 1 ) )
    {
        return;
    }
    
    level.ztron.var_d2cdda04885d49d2 = state;
    function_662cbbb51a33fd();
    ztron_debug::debugmsg( "^^^^ LightState being set to:" + level.ztron.var_d2cdda04885d49d2 );
}

// Namespace ztron_weather
// Params 1
// Checksum 0x49c75465, Offset: 0xc2a
// Size: 0x5b
function resetlightstate( lightstate = 0 )
{
    if ( !( getdvarint( @"hash_35f771b555f29316", 1 ) == 1 ) )
    {
        return;
    }
    
    level.ztron.var_d2cdda04885d49d2 = lightstate;
    setlightstate( level.ztron.var_d2cdda04885d49d2 );
}

// Namespace ztron_weather
// Params 0
// Checksum 0x8b3a91cd, Offset: 0xc8d
// Size: 0x48
function function_8bfe19c4541053f2()
{
    if ( !( getdvarint( @"hash_35f771b555f29316", 1 ) == 1 ) )
    {
        return;
    }
    
    lightstate = level.ztron.var_d2cdda04885d49d2 + 1;
    
    if ( lightstate > 3 )
    {
        lightstate = 0;
    }
    
    return lightstate;
}

// Namespace ztron_weather
// Params 0
// Checksum 0x3e595c9b, Offset: 0xcde
// Size: 0x60
function inclightstate()
{
    if ( !( getdvarint( @"hash_35f771b555f29316", 1 ) == 1 ) )
    {
        return;
    }
    
    level.ztron.var_d2cdda04885d49d2 = function_8bfe19c4541053f2();
    setlightstate( level.ztron.var_d2cdda04885d49d2 );
    return level.ztron.var_d2cdda04885d49d2;
}

// Namespace ztron_weather
// Params 0
// Checksum 0xaf5e6edb, Offset: 0xd47
// Size: 0x7b
function function_662cbbb51a33fd()
{
    foreach ( player in level.players )
    {
        player function_71715e0f568a17c();
    }
}

// Namespace ztron_weather
// Params 0
// Checksum 0x83fd9091, Offset: 0xdca
// Size: 0xa8
function function_71715e0f568a17c()
{
    if ( self.ztron.var_d2cdda04885d49d2 && self.ztron.var_d2cdda04885d49d2 != level.ztron.var_d2cdda04885d49d2 )
    {
        function_35de8f488e8ade0a();
    }
    
    if ( level.ztron.var_d2cdda04885d49d2 != 0 )
    {
        self function_a565dafac620d68e( function_bcb7a022d76a0f25( level.ztron.var_d2cdda04885d49d2 ) );
        self.ztron.var_d2cdda04885d49d2 = level.ztron.var_d2cdda04885d49d2;
    }
}

// Namespace ztron_weather
// Params 0
// Checksum 0x89b5abc7, Offset: 0xe7a
// Size: 0x4a
function function_35de8f488e8ade0a()
{
    if ( self.ztron.var_d2cdda04885d49d2 )
    {
        self function_72cf2eee8e035013( function_bcb7a022d76a0f25( self.ztron.var_d2cdda04885d49d2 ) );
        self.ztron.var_d2cdda04885d49d2 = undefined;
    }
}

// Namespace ztron_weather
// Params 1
// Checksum 0xb933f6fc, Offset: 0xecc
// Size: 0x7f
function function_bcb7a022d76a0f25( state )
{
    switch ( state )
    {
        case 1:
            return %"hw_sat_lightstate_force_1";
        case 2:
            return %"hw_sat_lightstate_force_2";
        case 3:
            return %"hw_sat_lightstate_force_3";
        default:
            assert( 0, "<dev string:xef>" + state );
            return %"";
    }
}

/#

    // Namespace ztron_weather
    // Params 1
    // Checksum 0xf8af645b, Offset: 0xf53
    // Size: 0x1c8, Type: dev
    function function_3e55a54591eb3a41( params )
    {
        weather = params[ 0 ];
        activeconfig = level.ztron.var_fa9ef452c4700db8;
        
        if ( isdefined( activeconfig ) )
        {
            foreach ( weatherconfig in activeconfig )
            {
                if ( weatherconfig.type == weather )
                {
                    setweather( weather, weatherconfig.weight );
                    return;
                }
            }
        }
        
        if ( ztron_main::function_4da200e9b8d58a3c() == 1 )
        {
            var_f8eee19cbf24bb49 = level.ztron.weather.weatherconfig[ level.ztron.active_arena.name ];
            
            if ( var_f8eee19cbf24bb49 )
            {
                foreach ( weathercfg in var_f8eee19cbf24bb49.var_b7d73c550e910ff8 )
                {
                    if ( weathercfg.weather == weather )
                    {
                        setweather( weather, weathercfg.weatherweight );
                        return;
                    }
                }
            }
        }
        
        setweather( weather, 1 );
    }

    // Namespace ztron_weather
    // Params 1
    // Checksum 0x8dc7ae6b, Offset: 0x1123
    // Size: 0x2b, Type: dev
    function debug_set_light( params )
    {
        state = int( params[ 0 ] );
        setlightstate( state );
    }

    // Namespace ztron_weather
    // Params 0
    // Checksum 0xcd0d492e, Offset: 0x1156
    // Size: 0x113, Type: dev
    function init_ztron_weather_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x105>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x116>", "<dev string:x11c>" + "<dev string:x116>", &function_3e55a54591eb3a41 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x128>", "<dev string:x11c>" + "<dev string:x128>", &function_3e55a54591eb3a41 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x12d>", "<dev string:x11c>" + "<dev string:x131>", &function_3e55a54591eb3a41 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x139>", "<dev string:x11c>" + "<dev string:x139>", &function_3e55a54591eb3a41 );
        devgui::function_77df7fe7dd273e10();
        
        if ( getdvarint( @"hash_35f771b555f29316", 1 ) == 1 )
        {
            devgui::function_9082edeb5db93280( "<dev string:x13e>" );
            devgui::function_cd4e263c1f3018ae( "<dev string:x14d>", "<dev string:x15b>" + 0, &debug_set_light );
            devgui::function_cd4e263c1f3018ae( "<dev string:x16a>", "<dev string:x15b>" + 1, &debug_set_light );
            devgui::function_cd4e263c1f3018ae( "<dev string:x175>", "<dev string:x15b>" + 2, &debug_set_light );
            devgui::function_cd4e263c1f3018ae( "<dev string:x180>", "<dev string:x15b>" + 3, &debug_set_light );
            devgui::function_77df7fe7dd273e10();
        }
    }

#/
