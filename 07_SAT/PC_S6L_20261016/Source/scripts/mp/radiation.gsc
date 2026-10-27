// scripts\mp\radiation.gsc  (hash_5ccc4374f6c041e3.gscc) (size: 12727 Bytes / 0x31b7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa5a0eae9 (2778786537)
// size ...... 12727 (0x31b7)
// includes .. 13  (offset: 0x2d93)
// strings ... 18  (offset: 0x2dfb)
// dev strs .. 58  (offset: 0x2eeb)
// exports ... 37  (offset: 0x1c73)
// cseg ...... 0x1f4 + 0x1a7f (0x1c73)
// imports ... 92  (offset: 0x223b)
// animtree1 . 0   (offset: 0x31b7)
// animtree2 . 0   (offset: 0x31b7)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\gasmask;
#using scripts\common\math;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\armor;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\vision_utility;
#using scripts\mp\emp_debuff;
#using scripts\mp\operator;

#namespace radiation;

// Namespace radiation
// Params 0, eflags: 0x5
// Checksum 0x9ed2a769, Offset: 0x212
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"radiation", undefined, &_pre_main_init, &_post_main_init );
}

// Namespace radiation
// Params 0, eflags: 0x4
// Checksum 0x4e8380d, Offset: 0x237
// Size: 0xfd
function private _pre_main_init()
{
    level.radiation = spawnstruct();
    level.radiation.instances = [];
    level.radiation.damageweapon = getdvar( @"hash_f08ac6061fce744a", "danger_circle_br" );
    level.radiation.var_f5ee7dc71b9a24d4 = getdvarint( @"hash_229c4da4191ab249", 1 ) != 0;
    level.radiation.coughchance = getdvarint( @"hash_1e0f719f2b363047", 20 );
    level.radiation.coughcooldown = getdvarint( @"hash_7f28cb77cb8b8417", 5 );
    utility::registersharedfunc( #"radiation", #"radiation_isinit", &_is_init );
    utility::registersharedfunc( #"radiation", #"radiation_signeddistancefromradiationcircle", &function_3667f46ce3bad59d );
    utility::flag_set( "radiation_initialized" );
}

// Namespace radiation
// Params 0, eflags: 0x4
// Checksum 0x95253c33, Offset: 0x33c
// Size: 0x1f
function private _post_main_init()
{
    /#
        level.radiation.var_80de0e76e5fcbe7b = undefined;
        thread _debug_devgui();
    #/
}

// Namespace radiation
// Params 6
// Checksum 0x9050493f, Offset: 0x363
// Size: 0x16e
function create( origin, radius, player_update_rate, quest_circle_template, show_br_circle, inverted )
{
    radius = float( radius );
    instance = spawnstruct();
    instance.origin = origin;
    instance.angles = ( 0, 0, 0 );
    instance.active = 1;
    instance.radius = radius;
    instance.radiussq = squared( radius );
    instance.tickrate = player_update_rate;
    instance.inverted = inverted;
    instance.var_29d1e60b94d4a86 = 0;
    
    if ( show_br_circle )
    {
        instance.brcircle = spawnbrcircle( origin[ 0 ], origin[ 1 ], radius );
    }
    
    if ( isdefined( quest_circle_template ) )
    {
        instance game_utility::questcircle_create( quest_circle_template, origin, radius );
        instance game_utility::questcircle_showtoall();
    }
    
    instance thread function_aa2c1f7c3c94a788();
    instance thread _players_update();
    instance callback::add( "player_entered_radiation", &_player_entered_radiation_callback );
    instance callback::add( "player_exited_radiation", &_player_exited_radiation_callback );
    level.radiation.instances[ level.radiation.instances.size ] = instance;
    return instance;
}

// Namespace radiation
// Params 3
// Checksum 0xc766ea84, Offset: 0x4da
// Size: 0xdd
function transform( new_origin, new_radius, duration )
{
    if ( new_origin == self.origin && new_radius == self.radius )
    {
        return;
    }
    
    new_radius = float( new_radius );
    callback::callback( "radiation_transform_started" );
    self notify( #"radiation_transform_started" );
    self.var_8583b749664e656a = 1;
    self.var_529f706a694afa7e = 0;
    self.transforming_startorigin = self.origin;
    self.transforming_startradius = self.radius;
    self.var_9990052340fe6496 = duration;
    self.transforming_goalorigin = new_origin;
    self.transforming_goalradius = new_radius;
    
    if ( isdefined( self.brcircle ) )
    {
        self.brcircle brcirclemoveto( new_origin[ 0 ], new_origin[ 1 ], new_radius, duration );
    }
}

// Namespace radiation
// Params 0
// Checksum 0x71936250, Offset: 0x5bf
// Size: 0xbf
function destroy()
{
    assert( self.active, "<dev string:x24>" );
    self.active = 0;
    callback::callback( "radiation_destroyed" );
    self notify( #"radiation_destroyed" );
    
    if ( game_utility::questcircle_exists() )
    {
        game_utility::questcircle_delete();
    }
    
    if ( isdefined( self.brcircle ) )
    {
        self.brcircle delete();
    }
    
    level.radiation.instances = arrayremove( level.radiation.instances, self );
    
    /#
        if ( self == level.radiation.var_80de0e76e5fcbe7b )
        {
            level.radiation.var_80de0e76e5fcbe7b = undefined;
        }
    #/
}

// Namespace radiation
// Params 3
// Checksum 0x6ccaeae, Offset: 0x686
// Size: 0x44
function function_a691540b0dbec3a0( var_77cfbecfe9e967fd, var_ad30c944bbd232d7, inside )
{
    self.visionset = var_77cfbecfe9e967fd;
    self.var_462dbaf335b5b786 = inside ?? 1;
    self.var_5658dafc2b6a1118 = var_ad30c944bbd232d7;
}

// Namespace radiation
// Params 4
// Checksum 0xaa5afff4, Offset: 0x6d2
// Size: 0x5c
function set_radar_scramble( should_scramble, scramble_level, var_dc1ece441baec1cb, inside )
{
    self.radarscramble = should_scramble;
    self.var_b7f75c78edeef401 = scramble_level;
    self.var_e6ace642339c2f41 = var_dc1ece441baec1cb ?? 0;
    self.var_5b9b5dabae9769 = inside ?? 1;
}

// Namespace radiation
// Params 1
// Checksum 0x42c9ff3c, Offset: 0x736
// Size: 0x23
function set_tick_rate( var_803ea8d304e3f41e )
{
    assert( var_803ea8d304e3f41e > 0 );
    self.tickrate = var_803ea8d304e3f41e;
}

// Namespace radiation
// Params 5
// Checksum 0xa50c2744, Offset: 0x761
// Size: 0xa6
function function_1de5a68ddcf339aa( var_5454f57201136c19, var_608be8a9cfbc6a3c, damage_increase_rate, damage_increase_max, var_8cc82c0aab989537 )
{
    self.var_29d1e60b94d4a86 = float( var_5454f57201136c19 );
    
    if ( isdefined( var_608be8a9cfbc6a3c ) && isdefined( damage_increase_rate ) )
    {
        assert( var_608be8a9cfbc6a3c != 0 && damage_increase_rate > 0, "<dev string:x70>" );
        self.var_4397dd1f9efe9c43 = float( var_608be8a9cfbc6a3c );
        self.var_80a80a635d565349 = float( damage_increase_rate );
        self.var_2b5cac0af83c3a4b = isdefined( damage_increase_max ) ? float( damage_increase_max ) : undefined;
        self.var_901e1b2081e1f305 = var_8cc82c0aab989537;
    }
}

// Namespace radiation
// Params 0
// Checksum 0x49061b8f, Offset: 0x80f
// Size: 0x30
function function_dd353ada13e719d2()
{
    if ( !self.var_8583b749664e656a )
    {
        return;
    }
    
    return distance2d( self.transforming_goalorigin, self.transforming_startorigin ) / self.var_9990052340fe6496;
}

// Namespace radiation
// Params 0
// Checksum 0xd815f855, Offset: 0x848
// Size: 0x2d
function function_76e0602fb7f0447e()
{
    if ( !self.var_8583b749664e656a )
    {
        return;
    }
    
    return ( self.transforming_goalradius - self.transforming_startradius ) / self.var_9990052340fe6496;
}

// Namespace radiation
// Params 1
// Checksum 0x7c5cc749, Offset: 0x87e
// Size: 0x4f
function is_position_inside( pos )
{
    if ( self.inverted )
    {
        return ( distance2dsquared( pos, self.origin ) > self.radiussq );
    }
    
    return distance2dsquared( pos, self.origin ) < self.radiussq;
}

// Namespace radiation
// Params 1
// Checksum 0xdc7a3972, Offset: 0x8d5
// Size: 0x25
function function_1cfc1ecb93409d26( pos )
{
    return distance2d( pos, self.origin ) - self.radius;
}

// Namespace radiation
// Params 1
// Checksum 0x2d09b61a, Offset: 0x903
// Size: 0x54
function function_ca7a405fde79979f( pos )
{
    if ( !self.var_8583b749664e656a )
    {
        return;
    }
    
    target_radius = distance2d( pos, self.transforming_startorigin );
    var_93b07ad8b3fd1ac0 = function_76e0602fb7f0447e();
    return ( target_radius - self.radius ) / var_93b07ad8b3fd1ac0;
}

// Namespace radiation
// Params 0
// Checksum 0x96bf24c0, Offset: 0x960
// Size: 0x11b
function function_6104e81286096d0()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( !player::isreallyalive() )
    {
        return;
    }
    
    if ( self.isjuggernaut )
    {
        return;
    }
    
    if ( gettime() < self.var_1121b62c259b160f )
    {
        return;
    }
    
    self.var_1121b62c259b160f = gettime() + level.radiation.coughcooldown;
    
    if ( !isai( self ) )
    {
        self playsoundtoplayer( #"gas_player_cough", self, self );
    }
    
    var_553ba779c31e442 = "allies_male_cough";
    defaultoperatorteam = operator::function_1e32019139bf7206();
    
    if ( defaultoperatorteam == "axis" )
    {
        if ( operator::isfemale() )
        {
            var_553ba779c31e442 = "axis_female_cough";
        }
        else
        {
            var_553ba779c31e442 = "axis_male_cough";
        }
    }
    else if ( operator::isfemale() )
    {
        var_553ba779c31e442 = "allies_female_cough";
    }
    else
    {
        var_553ba779c31e442 = "allies_male_cough";
    }
    
    var_8d27e0901584cdf7 = randomint( game[ "dialogue" ][ var_553ba779c31e442 ].size );
    coughsoundalias = game[ "dialogue" ][ var_553ba779c31e442 ][ var_8d27e0901584cdf7 ];
    self playsound( coughsoundalias, self, self );
}

// Namespace radiation
// Params 0
// Checksum 0x4183ac96, Offset: 0xa83
// Size: 0xc, Type: bool
function _is_init()
{
    return isdefined( level.radiation );
}

// Namespace radiation
// Params 1
// Checksum 0xa82f4259, Offset: 0xa98
// Size: 0x6c
function function_3667f46ce3bad59d( pos )
{
    closest_distance = 999999;
    var_9b81a65e54db8538 = sortbydistance( level.radiation.instances, pos );
    
    if ( var_9b81a65e54db8538.size > 0 )
    {
        return ( distance2d( pos, var_9b81a65e54db8538[ 0 ].origin ) - var_9b81a65e54db8538[ 0 ].radius );
    }
    
    return closest_distance;
}

// Namespace radiation
// Params 0, eflags: 0x4
// Checksum 0x8cb120f0, Offset: 0xb0d
// Size: 0x139
function private function_aa2c1f7c3c94a788()
{
    level endon( #"game_ended" );
    self endon( #"radiation_destroyed" );
    
    while ( self.active )
    {
        waitframe();
        
        if ( self.var_8583b749664e656a )
        {
            progress = self.var_529f706a694afa7e / self.var_9990052340fe6496;
            
            if ( progress >= 1 )
            {
                progress = 1;
            }
            
            self.origin = vectorlerp( self.transforming_startorigin, self.transforming_goalorigin, progress );
            self.radius = math::lerp( self.transforming_startradius, self.transforming_goalradius, progress );
            self.radiussq = self.radius * self.radius;
            
            if ( game_utility::questcircle_exists() )
            {
                game_utility::questcircle_move( self.origin );
                game_utility::function_d46d8731ed9d281( self.radius );
            }
            
            callback::callback( "radiation_transform_update" );
            self.var_529f706a694afa7e += level.framedurationseconds;
            
            if ( progress >= 1 )
            {
                self.var_8583b749664e656a = undefined;
                callback::callback( "radiation_transform_completed" );
            }
        }
    }
}

// Namespace radiation
// Params 0, eflags: 0x4
// Checksum 0xc91d23e4, Offset: 0xc4e
// Size: 0x41d
function private _players_update()
{
    level endon( #"game_ended" );
    self endon( #"radiation_destroyed" );
    self.player_enter_times = [];
    self.var_d543cc3cb6726b5d = [];
    
    while ( self.active )
    {
        wait self.tickrate;
        
        foreach ( player in level.players )
        {
            player_entity_number = player getentitynumber();
            player_inside_radiation = is_position_inside( player.origin );
            
            if ( player_inside_radiation )
            {
                if ( !isdefined( self.player_enter_times[ player_entity_number ] ) )
                {
                    self.player_enter_times[ player_entity_number ] = gettime();
                    self.var_d543cc3cb6726b5d[ player_entity_number ] = 0;
                    callback::callback( "player_entered_radiation", { #player:player } );
                }
            }
            else if ( isdefined( self.player_enter_times[ player_entity_number ] ) )
            {
                self.player_enter_times[ player_entity_number ] = undefined;
                self.var_d543cc3cb6726b5d[ player_entity_number ] = undefined;
                callback::callback( "player_exited_radiation", { #player:player } );
            }
            
            if ( !isalive( player ) )
            {
                continue;
            }
            
            if ( callback::response( 0, "player_should_immune_damage", { #player:player } ) )
            {
                continue;
            }
            
            damage = 0;
            
            if ( !player_inside_radiation || player.plotarmor )
            {
                damage = 0;
            }
            else if ( !self.var_901e1b2081e1f305 && isdefined( self.var_4397dd1f9efe9c43 ) && isdefined( self.var_80a80a635d565349 ) )
            {
                damage = self.var_29d1e60b94d4a86 + function_e304d19b9d6175b9( player_entity_number );
            }
            else
            {
                damage = self.var_29d1e60b94d4a86;
            }
            
            if ( gasmask::hasgasmask( player ) && !player.gasmaskswapinprogress )
            {
                if ( player_inside_radiation )
                {
                    if ( isdefined( level.var_548004405d16dcf8 ) )
                    {
                        player [[ level.var_548004405d16dcf8 ]]( "radiation" );
                    }
                    
                    if ( damage > 0 )
                    {
                        player gasmask::processdamage( damage );
                        damage = 0;
                    }
                }
                else if ( isdefined( level.var_7518fcc73a6d4676 ) )
                {
                    player [[ level.var_7518fcc73a6d4676 ]]( "radiation" );
                }
            }
            
            if ( player_inside_radiation && !player.plotarmor && self.var_901e1b2081e1f305 && isdefined( self.var_4397dd1f9efe9c43 ) && isdefined( self.var_80a80a635d565349 ) )
            {
                damage = self.var_29d1e60b94d4a86 + function_e304d19b9d6175b9( player_entity_number );
            }
            
            if ( damage > 0 )
            {
                if ( self.var_d543cc3cb6726b5d[ player_entity_number ] > 0 )
                {
                    damage += self.var_d543cc3cb6726b5d[ player_entity_number ];
                    self.var_d543cc3cb6726b5d[ player_entity_number ] = 0;
                }
                
                var_efa36c671b432ad5 = int( damage );
                var_aeee0b04c231d7db = damage - float( var_efa36c671b432ad5 );
                
                if ( var_aeee0b04c231d7db > 0.01 )
                {
                    self.var_d543cc3cb6726b5d[ player_entity_number ] = var_aeee0b04c231d7db;
                }
                
                if ( var_efa36c671b432ad5 <= 0 )
                {
                    assertmsg( "<dev string:xe5>" + damage + "<dev string:xfe>" + self.var_29d1e60b94d4a86 + "<dev string:x157>" );
                    var_efa36c671b432ad5 = self.var_29d1e60b94d4a86;
                }
                
                player dodamage( var_efa36c671b432ad5, player.origin, player, undefined, "MOD_TRIGGER_HURT", level.radiation.damageweapon );
                player armor::damagearmor( var_efa36c671b432ad5, undefined, player, "MOD_TRIGGER_HURT" );
                
                if ( randomint( 100 ) < level.radiation.coughchance )
                {
                    player function_6104e81286096d0();
                }
                
                player callback::callback( "radiation_damage_player", { #damage:var_efa36c671b432ad5, #radiation:self } );
            }
        }
    }
}

// Namespace radiation
// Params 1, eflags: 0x4
// Checksum 0x78ee5647, Offset: 0x1073
// Size: 0xa3
function private function_e304d19b9d6175b9( player_entity_number )
{
    assert( isdefined( self.player_enter_times[ player_entity_number ] ) );
    assert( isdefined( self.var_4397dd1f9efe9c43 ) && isdefined( self.var_80a80a635d565349 ) );
    var_abf5e957799f2893 = ( gettime() - self.player_enter_times[ player_entity_number ] ) / 1000;
    var_50137072cbdcbc36 = self.var_4397dd1f9efe9c43 * int( var_abf5e957799f2893 / self.var_80a80a635d565349 );
    
    if ( var_50137072cbdcbc36 > self.var_2b5cac0af83c3a4b )
    {
        var_50137072cbdcbc36 = self.var_2b5cac0af83c3a4b;
    }
    
    return var_50137072cbdcbc36;
}

// Namespace radiation
// Params 1
// Checksum 0x4014bc03, Offset: 0x111f
// Size: 0xc6
function _player_entered_radiation_callback( params )
{
    player = params.player;
    
    if ( isdefined( self.visionset ) )
    {
        if ( self.var_462dbaf335b5b786 )
        {
            player vision_utility::function_89d3efe42060754c( self.visionset, self.var_5658dafc2b6a1118 );
        }
        else
        {
            player vision_utility::function_6cb9d8e0202ee81( self.visionset, self.var_5658dafc2b6a1118 );
        }
    }
    
    if ( self.radarscramble )
    {
        if ( self.var_5b9b5dabae9769 )
        {
            player emp_debuff::play_scramble( self.var_b7f75c78edeef401, self.var_e6ace642339c2f41 );
            return;
        }
        
        player emp_debuff::stop_scramble( self.var_b7f75c78edeef401, self.var_e6ace642339c2f41 );
    }
}

// Namespace radiation
// Params 1
// Checksum 0x6dc9faaf, Offset: 0x11ed
// Size: 0xc6
function _player_exited_radiation_callback( params )
{
    player = params.player;
    
    if ( isdefined( self.visionset ) )
    {
        if ( self.var_462dbaf335b5b786 )
        {
            player vision_utility::function_6cb9d8e0202ee81( self.visionset, self.var_5658dafc2b6a1118 );
        }
        else
        {
            player vision_utility::function_89d3efe42060754c( self.visionset, self.var_5658dafc2b6a1118 );
        }
    }
    
    if ( self.radarscramble )
    {
        if ( self.var_5b9b5dabae9769 )
        {
            player emp_debuff::stop_scramble( self.var_b7f75c78edeef401, self.var_e6ace642339c2f41 );
            return;
        }
        
        player emp_debuff::play_scramble( self.var_b7f75c78edeef401, self.var_e6ace642339c2f41 );
    }
}

/#

    // Namespace radiation
    // Params 0, eflags: 0x4
    // Checksum 0xff972063, Offset: 0x12bb
    // Size: 0x1ee, Type: dev
    function private _debug_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x15a>" );
        devgui::add_devgui_func( "<dev string:x16b>", "<dev string:x17c>", &function_ae74a25d373a3d2d );
        devgui::add_devgui_func( "<dev string:x197>", "<dev string:x1a8>", &function_9acdbcddd716d0f5 );
        devgui::add_devgui_func( "<dev string:x1c3>", "<dev string:x1d1>", &function_eb686746b4c25e6a );
        devgui::add_devgui_func( "<dev string:x1e2>", "<dev string:x1f4>", &debug_deselect );
        devgui::add_devgui_func( "<dev string:x207>", "<dev string:x217>", &function_8b61ef883ae5aecf );
        devgui::function_cd4e263c1f3018ae( "<dev string:x231>", "<dev string:x24d>", &function_b9eea9f6cf3d7edf );
        devgui::function_cd4e263c1f3018ae( "<dev string:x26e>", "<dev string:x28a>", &function_b9eea9f6cf3d7edf );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2aa>", "<dev string:x2c9>", &function_b9eea9f6cf3d7edf );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2ed>", "<dev string:x310>", &function_fee517814fd7f539 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x333>", "<dev string:x356>", &function_fee517814fd7f539 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x379>", "<dev string:x39c>", &function_fee517814fd7f539 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x3bf>", "<dev string:x3e2>", &function_fee517814fd7f539 );
        devgui::add_devgui_func( "<dev string:x405>", "<dev string:x42c>", &function_ffe28724af750aa5 );
        devgui::add_devgui_func( "<dev string:x453>", "<dev string:x479>", &function_c34414dadda0fafe );
        devgui::add_devgui_func( "<dev string:x49f>", "<dev string:x4c5>", &function_83779d78ed08eba6 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x4eb>", "<dev string:x50f>", &function_bdee6b166dc94dee );
        devgui::function_cd4e263c1f3018ae( "<dev string:x533>", "<dev string:x557>", &function_bdee6b166dc94dee );
        devgui::function_cd4e263c1f3018ae( "<dev string:x57b>", "<dev string:x59f>", &function_bdee6b166dc94dee );
        devgui::function_cd4e263c1f3018ae( "<dev string:x5c3>", "<dev string:x5e7>", &function_bdee6b166dc94dee );
        devgui::function_cd4e263c1f3018ae( "<dev string:x60b>", "<dev string:x62f>", &function_bdee6b166dc94dee );
        devgui::function_cd4e263c1f3018ae( "<dev string:x653>", "<dev string:x677>", &function_bdee6b166dc94dee );
        devgui::function_77df7fe7dd273e10();
        level thread _debug_drawing();
    }

    // Namespace radiation
    // Params 0, eflags: 0x4
    // Checksum 0x1f1f9b55, Offset: 0x14b1
    // Size: 0x1f3, Type: dev
    function private _debug_drawing()
    {
        level endon( #"game_ended" );
        var_6e712c584c4b889c = 0;
        
        while ( true )
        {
            if ( var_6e712c584c4b889c != 5 )
            {
                var_6e712c584c4b889c += 1;
                waitframe();
                continue;
            }
            
            var_6e712c584c4b889c = 0;
            
            if ( isdefined( level.radiation.var_80de0e76e5fcbe7b ) )
            {
                cylinder( level.radiation.var_80de0e76e5fcbe7b.origin, level.radiation.var_80de0e76e5fcbe7b.origin + ( 0, 0, 10000 ), level.radiation.var_80de0e76e5fcbe7b.radius, ( 1, 0, 0 ), 0, 5 );
                line( level.radiation.var_80de0e76e5fcbe7b.origin - ( level.radiation.var_80de0e76e5fcbe7b.radius, 0, 0 ), level.radiation.var_80de0e76e5fcbe7b.origin + ( level.radiation.var_80de0e76e5fcbe7b.radius, 0, 0 ), ( 1, 0, 0 ), 1, 0, 5 );
                line( level.radiation.var_80de0e76e5fcbe7b.origin - ( 0, level.radiation.var_80de0e76e5fcbe7b.radius, 0 ), level.radiation.var_80de0e76e5fcbe7b.origin + ( 0, level.radiation.var_80de0e76e5fcbe7b.radius, 0 ), ( 1, 0, 0 ), 1, 0, 5 );
            }
        }
    }

    // Namespace radiation
    // Params 0
    // Checksum 0x55c33d5a, Offset: 0x16ac
    // Size: 0x28, Type: dev
    function function_ae74a25d373a3d2d()
    {
        return create( ( 0, 0, 0 ), 2048, 1.5, "<dev string:x69b>", 1 );
    }

    // Namespace radiation
    // Params 0
    // Checksum 0x95283325, Offset: 0x16dc
    // Size: 0x8c, Type: dev
    function function_9acdbcddd716d0f5()
    {
        player = level.players[ 0 ];
        forward = anglestoforward( player getplayerangles() );
        trace = trace::ray_trace( player geteye(), player geteye() + forward * 150000 );
        
        if ( isdefined( trace[ "<dev string:x6a9>" ] ) && trace[ "<dev string:x6b2>" ] < 1 )
        {
            return create( trace[ "<dev string:x6a9>" ], 2048, 1.5, "<dev string:x69b>", 1 );
        }
        
        return;
    }

    // Namespace radiation
    // Params 0
    // Checksum 0x5230c596, Offset: 0x1770
    // Size: 0xf9, Type: dev
    function function_eb686746b4c25e6a()
    {
        if ( level.radiation.instances.size == 0 )
        {
            return;
        }
        
        player = level.players[ 0 ];
        forward = anglestoforward( player getplayerangles() );
        trace = trace::ray_trace( player geteye(), player geteye() + forward * 150000 );
        
        if ( isdefined( trace[ "<dev string:x6a9>" ] ) && trace[ "<dev string:x6b2>" ] < 1 )
        {
            level.radiation.instances = sortbydistance( level.radiation.instances, trace[ "<dev string:x6a9>" ] );
            level.radiation.var_80de0e76e5fcbe7b = level.radiation.instances[ 0 ];
            return;
        }
        
        level.radiation.var_80de0e76e5fcbe7b = undefined;
    }

    // Namespace radiation
    // Params 0
    // Checksum 0xecd8614d, Offset: 0x1871
    // Size: 0x18, Type: dev
    function debug_deselect()
    {
        level.radiation.var_80de0e76e5fcbe7b = undefined;
    }

    // Namespace radiation
    // Params 0
    // Checksum 0x18abc57f, Offset: 0x1891
    // Size: 0x42, Type: dev
    function function_8b61ef883ae5aecf()
    {
        if ( !isdefined( level.radiation.var_80de0e76e5fcbe7b ) )
        {
            iprintlnbold( "<dev string:x6bb>" );
            return;
        }
        
        level.radiation.var_80de0e76e5fcbe7b destroy();
    }

    // Namespace radiation
    // Params 1
    // Checksum 0x3afc6cbe, Offset: 0x18db
    // Size: 0x13d, Type: dev
    function function_fee517814fd7f539( params )
    {
        if ( !isdefined( level.radiation.var_80de0e76e5fcbe7b ) )
        {
            iprintlnbold( "<dev string:x6e5>" );
            return;
        }
        
        direction = params[ 0 ];
        dist = int( params[ 1 ] );
        time = int( params[ 2 ] );
        offset = ( 0, 0, 0 );
        
        switch ( direction )
        {
            case #"hash_f96ec5f6bcd1b209":
                offset = ( 0, dist, 0 );
                break;
            case #"hash_f96ec4f6bcd1b076":
                offset = ( dist, 0, 0 );
                break;
            case #"hash_f95bc1f6bcc2a133":
                offset = ( 0, dist * -1, 0 );
                break;
            case #"hash_f95bc0f6bcc29fa0":
                offset = ( dist * -1, 0, 0 );
                break;
        }
        
        level.radiation.var_80de0e76e5fcbe7b transform( level.radiation.var_80de0e76e5fcbe7b.origin + offset, level.radiation.var_80de0e76e5fcbe7b.radius, time );
    }

    // Namespace radiation
    // Params 1
    // Checksum 0x6a46934f, Offset: 0x1a20
    // Size: 0xb0, Type: dev
    function function_b9eea9f6cf3d7edf( params )
    {
        if ( !isdefined( level.radiation.var_80de0e76e5fcbe7b ) )
        {
            iprintlnbold( "<dev string:x719>" );
            return;
        }
        
        increase = int( params[ 0 ] );
        time = int( params[ 1 ] );
        level.radiation.var_80de0e76e5fcbe7b transform( level.radiation.var_80de0e76e5fcbe7b.origin, level.radiation.var_80de0e76e5fcbe7b.radius + increase, time );
    }

    // Namespace radiation
    // Params 0
    // Checksum 0xec12bd9f, Offset: 0x1ad8
    // Size: 0x64, Type: dev
    function function_ffe28724af750aa5()
    {
        if ( !isdefined( level.radiation.var_80de0e76e5fcbe7b ) )
        {
            iprintlnbold( "<dev string:x741>" );
            return;
        }
        
        level.radiation.var_80de0e76e5fcbe7b.radarscramble = !level.radiation.var_80de0e76e5fcbe7b.radarscramble;
    }

    // Namespace radiation
    // Params 0
    // Checksum 0x3ab76323, Offset: 0x1b44
    // Size: 0x64, Type: dev
    function function_c34414dadda0fafe()
    {
        if ( !isdefined( level.radiation.var_80de0e76e5fcbe7b ) )
        {
            iprintlnbold( "<dev string:x79b>" );
            return;
        }
        
        level.radiation.var_80de0e76e5fcbe7b.var_5b9b5dabae9769 = !level.radiation.var_80de0e76e5fcbe7b.var_5b9b5dabae9769;
    }

    // Namespace radiation
    // Params 0
    // Checksum 0x344569e8, Offset: 0x1bb0
    // Size: 0x64, Type: dev
    function function_83779d78ed08eba6()
    {
        if ( !isdefined( level.radiation.var_80de0e76e5fcbe7b ) )
        {
            iprintlnbold( "<dev string:x818>" );
            return;
        }
        
        level.radiation.var_80de0e76e5fcbe7b.var_e6ace642339c2f41 = !level.radiation.var_80de0e76e5fcbe7b.var_e6ace642339c2f41;
    }

    // Namespace radiation
    // Params 1
    // Checksum 0xa898ac2f, Offset: 0x1c1c
    // Size: 0x57, Type: dev
    function function_bdee6b166dc94dee( params )
    {
        if ( !isdefined( level.radiation.var_80de0e76e5fcbe7b ) )
        {
            iprintlnbold( "<dev string:x885>" );
            return;
        }
        
        level.radiation.var_80de0e76e5fcbe7b.var_b7f75c78edeef401 = int( params[ 0 ] );
    }

#/
