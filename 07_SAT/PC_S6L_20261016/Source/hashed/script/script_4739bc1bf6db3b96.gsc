// script_4739bc1bf6db3b96  (hash_4739bc1bf6db3b96.gscc) (size: 6741 Bytes / 0x1a55 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6123af87 (1629728647)
// size ...... 6741 (0x1a55)
// includes .. 5   (offset: 0x1929)
// strings ... 14  (offset: 0x1951)
// dev strs .. 7   (offset: 0x1a01)
// exports ... 18  (offset: 0xf3d)
// cseg ...... 0x13a + 0xe03 (0xf3d)
// imports ... 60  (offset: 0x120d)
// animtree1 . 0   (offset: 0x1a55)
// animtree2 . 0   (offset: 0x1a55)
#using script_747a3e7e01d497c7;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\utility;

#namespace zombie_aeon_fireball;

// Namespace zombie_aeon_fireball
// Params 1
// Checksum 0x119d31e2, Offset: 0x158
// Size: 0x3f
function precache( aitypescriptbundle )
{
    settings = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    
    if ( !isdefined( settings ) )
    {
        return;
    }
    
    utility::add_fx( "aeon_fireball_explode_fx", settings.var_229afe8ae44fbbf4 );
}

// Namespace zombie_aeon_fireball
// Params 0
// Checksum 0x83f3d2bd, Offset: 0x19f
// Size: 0x12a
function init_zombie_aeon_fireball()
{
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    self.fireball_marker_scriptable = settings.var_e12f499402a14c4e;
    self.fireball_cooldown = settings.fireballcooldown ?? 15;
    self.var_6df1c827f89530de = settings.var_8066d81ee1beb8a5 ?? 0.5;
    self.fireball_min_count = settings.var_18c7f6dfa5133e18 ?? 2;
    self.fireball_max_count = settings.var_851509acb00cc3b6 ?? 5;
    self.fireball_target_radius = settings.var_620729a4de15c9c8 ?? 600;
    self.var_421d77c0ad2c114e = settings.var_6c28101d18623c25 ?? 800;
    self.var_5ff7480462f1820b = settings.var_c857c2002e94a36b ?? 0.6;
    self.var_8ed5dbfb611909a7 = settings.var_2ac8f3ec010e3755 ?? 0.3;
    self.var_ca35f72ede1fcc85 = 0;
    self.active_fireballs = [];
    self.var_7f8ab9bb9f4957fc = &function_9416203139914738;
}

// Namespace zombie_aeon_fireball
// Params 0
// Checksum 0xf399abb, Offset: 0x2d1
// Size: 0x6f
function function_5ce011b9f8892d6d()
{
    self endon( #"death" );
    self endon( #"stop_fireballs" );
    
    while ( true )
    {
        var_cc8f8e7d2ce57f7 = ( gettime() - self.var_ca35f72ede1fcc85 ) / 1000;
        
        if ( var_cc8f8e7d2ce57f7 < self.fireball_cooldown )
        {
            wait 0.5;
            continue;
        }
        
        function_29ce95199d42d5c4();
        self.var_ca35f72ede1fcc85 = gettime();
        wait 1;
    }
}

// Namespace zombie_aeon_fireball
// Params 0
// Checksum 0x7c1275be, Offset: 0x348
// Size: 0xb4
function function_6315aec8c403efb5()
{
    self notify( #"stop_fireballs" );
    
    foreach ( fireball in self.active_fireballs )
    {
        if ( isdefined( fireball ) )
        {
            if ( isdefined( fireball.marker ) )
            {
                fireball.marker freescriptable();
            }
            
            fireball delete();
        }
    }
    
    self.active_fireballs = [];
}

// Namespace zombie_aeon_fireball
// Params 1
// Checksum 0xf7c9f813, Offset: 0x404
// Size: 0x69
function function_9e45e7dd08af62b6( params )
{
    var_cc8f8e7d2ce57f7 = ( gettime() - self.var_ca35f72ede1fcc85 ) / 1000;
    bypass_threshold = self.fireball_cooldown * self.var_6df1c827f89530de;
    
    if ( var_cc8f8e7d2ce57f7 >= bypass_threshold )
    {
        self.var_ca35f72ede1fcc85 = gettime() - self.fireball_cooldown * 1000;
    }
}

// Namespace zombie_aeon_fireball
// Params 0
// Checksum 0xeae4139c, Offset: 0x475
// Size: 0x1bf
function function_29ce95199d42d5c4()
{
    self endon( #"death" );
    
    if ( !isdefined( level.s_dark_heart ) )
    {
        level.s_dark_heart = utility::getstruct( "dark_heart", "targetname" );
    }
    
    var_c856392cb70eff5c = self function_f017e352a29a57a1( level.s_dark_heart.origin, 5000, 1 );
    players_near_heart = [];
    
    foreach ( player in var_c856392cb70eff5c )
    {
        if ( isplayer( player ) )
        {
            var_f1b807e36f506e21 = distance2d( player.origin, level.s_dark_heart.origin );
            
            if ( var_f1b807e36f506e21 <= self.var_421d77c0ad2c114e )
            {
                players_near_heart[ players_near_heart.size ] = player;
            }
        }
    }
    
    player_count = players_near_heart.size;
    player_count = max( player_count, 1 );
    t = ( player_count - 1 ) / 3;
    fireball_count = int( math::lerp( self.fireball_min_count, self.fireball_max_count, t ) );
    
    for ( i = 0; i < fireball_count ; i++ )
    {
        zombie_aeon_asm::function_a31680b57c8f7950( self );
        self waittill( #"aeon_projectile_shoot" );
        target = get_fireball_target( players_near_heart );
        thread function_623b53c05d07ecfe( target );
        wait self.var_8ed5dbfb611909a7;
    }
}

// Namespace zombie_aeon_fireball
// Params 2, eflags: 0x4
// Checksum 0xf377467c, Offset: 0x63c
// Size: 0x147
function private function_d3b61dcd8642795b( player, aeon )
{
    prediction_scale = getdvarfloat( @"hash_f5cece35b78e2d18", 1 );
    
    if ( prediction_scale <= 0 )
    {
        return player.origin;
    }
    
    velocity = player getvelocity();
    speed = length2d( velocity );
    min_speed = getdvarfloat( @"hash_5f8bbd3685b72a82", 20 );
    
    if ( speed < min_speed )
    {
        return player.origin;
    }
    
    launch_origin = aeon gettagorigin( "j_heart_up" );
    fireball_speed = getdvarfloat( @"hash_8e85b625f2eb9d9a", 500 );
    flight_dist = distance( launch_origin, player.origin );
    flight_time = flight_dist / fireball_speed;
    move_dir = vectornormalize2( velocity );
    predict_dist = speed * flight_time * prediction_scale;
    var_bcd5e7a7de38688b = getdvarfloat( @"hash_99cf20e6d0cec239", 500 );
    predict_dist = min( predict_dist, var_bcd5e7a7de38688b );
    predicted_pos = player.origin + move_dir * predict_dist;
    return predicted_pos;
}

// Namespace zombie_aeon_fireball
// Params 1, eflags: 0x4
// Checksum 0x8fc96e1d, Offset: 0x78c
// Size: 0x181
function private get_fireball_target( a_players )
{
    heart_origin = level.s_dark_heart.origin;
    target_pos = undefined;
    
    if ( a_players.size > 0 )
    {
        player = a_players[ randomint( a_players.size ) ];
        base_pos = function_d3b61dcd8642795b( player, self );
        var_c8289f9d9206a819 = ( randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ), 0 );
        var_c8289f9d9206a819 = vectornormalize( var_c8289f9d9206a819 );
        var_37fa6688249e2016 = randomfloatrange( 0, 50 );
        var_19f7155b91cc96bd = vectornormalize2( self.origin - base_pos );
        var_e6f6c361a4ebaa9a = 50;
        target_pos = base_pos + var_c8289f9d9206a819 * var_37fa6688249e2016 + var_19f7155b91cc96bd * var_e6f6c361a4ebaa9a;
    }
    else
    {
        angle = randomfloat( 360 );
        dist = randomfloatrange( 100, self.fireball_target_radius );
        offset = ( cos( angle ) * dist, sin( angle ) * dist, 0 );
        target_pos = heart_origin + offset;
    }
    
    aeon_ground = playerphysicstrace( self.origin, self.origin - ( 0, 0, 2000 ) );
    nav_pos = getclosestpointonnavmesh( target_pos, self );
    
    if ( nav_pos )
    {
        target_pos = ( target_pos[ 0 ], target_pos[ 1 ], aeon_ground[ 2 ] );
    }
    else
    {
        target_pos = aeon_ground;
    }
    
    if ( !isdefined( target_pos ) )
    {
        target_pos = heart_origin;
    }
    
    return target_pos;
}

// Namespace zombie_aeon_fireball
// Params 1, eflags: 0x4
// Checksum 0x2d1b7c1c, Offset: 0x916
// Size: 0x24c
function private function_623b53c05d07ecfe( target_pos )
{
    self endon( #"death" );
    var_2f053bc0c21de249 = [ "tag_fx_artery_1", "tag_fx_artery_2", "tag_fx_artery_3" ];
    var_4c19c47296b0ea53 = [ "artery1_flash", "artery2_flash", "artery3_flash" ];
    closest_dist = 999999;
    launch_tag_origin = self gettagorigin( "j_heart_up" );
    var_fe461e08bb25eb94 = undefined;
    
    for ( idx = 0; idx < var_2f053bc0c21de249.size ; idx++ )
    {
        tag_pos = self gettagorigin( var_2f053bc0c21de249[ idx ] );
        
        if ( isdefined( tag_pos ) )
        {
            dist = distance( tag_pos, target_pos );
            
            if ( dist < closest_dist )
            {
                closest_dist = dist;
                launch_tag_origin = tag_pos;
                var_fe461e08bb25eb94 = idx;
            }
        }
    }
    
    if ( isdefined( var_fe461e08bb25eb94 ) )
    {
        utility::function_7c10ea82c1e305b8( var_4c19c47296b0ea53[ var_fe461e08bb25eb94 ], "on" );
    }
    
    var_37c3df049d1e88ef = vectornormalize2( target_pos - launch_tag_origin );
    launch_origin = launch_tag_origin + ( 0, 0, getdvarfloat( @"hash_429010c94a909175", 0 ) ) + var_37c3df049d1e88ef * getdvarfloat( @"hash_f35dfaaefbe71a82", 0 );
    var_640e280f2ed8fb1a = vectornormalize( target_pos - launch_origin ) * getdvarfloat( @"hash_8e85b625f2eb9d9a", 500 );
    
    if ( !isdefined( var_640e280f2ed8fb1a ) )
    {
        return;
    }
    
    var_640e280f2ed8fb1a *= getdvarfloat( @"hash_c7aa55fa4fc6492a", 1 );
    fireball = magicgrenademanual( self.grenadeweapon, launch_origin, var_640e280f2ed8fb1a, self.var_d6894f01a36b4ff3.var_f3ce124063bf11bf, self );
    
    if ( !isdefined( fireball ) )
    {
        return;
    }
    
    fireball setmagicgrenadecollision( 0 );
    fireball thread utility::delaycall( 0.5, &setmagicgrenadecollision, 1 );
    marker = undefined;
    
    if ( isdefined( self.fireball_marker_scriptable ) )
    {
        marker = spawnscriptable( self.fireball_marker_scriptable, target_pos, ( 0, 0, 0 ) );
    }
    
    fireball.marker = marker;
    fireball.owner = self;
    self.active_fireballs[ self.active_fireballs.size ] = fireball;
    thread function_319cb72090c862ae( fireball );
    thread function_f852fafd2dc8d85e( fireball );
}

// Namespace zombie_aeon_fireball
// Params 3, eflags: 0x4
// Checksum 0xe278626f, Offset: 0xb6a
// Size: 0x1c2
function private function_2158050101b6910( fireball, var_1b09367d2088bed7, marker )
{
    if ( isdefined( marker ) )
    {
        marker freescriptable();
    }
    
    if ( !var_1b09367d2088bed7 )
    {
        return;
    }
    
    playfx( utility::getfx( "aeon_fireball_explode_fx" ), var_1b09367d2088bed7 );
    inner_radius = getdvarfloat( @"hash_ab4936c3ecb168f7", 100 );
    outer_radius = getdvarfloat( @"hash_cb7a7abf7bba87fe", 800 );
    players = function_d63fe6a4c08ba6f5( var_1b09367d2088bed7, outer_radius, 200 );
    
    foreach ( player in players )
    {
        if ( distance2d( player.origin, var_1b09367d2088bed7 ) < inner_radius )
        {
            player playrumbleonentity( "damage_heavy" );
            player earthquakeforplayer( getdvarfloat( @"hash_b50c55086016b95d", 0.9 ), 0.5, var_1b09367d2088bed7, outer_radius );
            
            if ( player.origin != var_1b09367d2088bed7 )
            {
                var_ee195fb25f938f8b = vectornormalize2( player.origin - var_1b09367d2088bed7 );
                player knockback( math::function_235fe1fdb403e4b2( var_ee195fb25f938f8b, 20 ), 300, 1 );
            }
            
            continue;
        }
        
        player playrumbleonentity( "light_1s" );
        player earthquakeforplayer( getdvarfloat( @"hash_e0b8b54f373b0636", 0.5 ), 0.5, var_1b09367d2088bed7, outer_radius );
    }
    
    self.active_fireballs = arrayremove( self.active_fireballs, fireball );
}

// Namespace zombie_aeon_fireball
// Params 1, eflags: 0x4
// Checksum 0x4f7807ab, Offset: 0xd34
// Size: 0x5f
function private function_319cb72090c862ae( fireball )
{
    self endon( #"death" );
    fireball endon( #"death" );
    marker = fireball.marker;
    fireball waittill( #"explode", origin );
    function_2158050101b6910( fireball, origin, marker );
}

// Namespace zombie_aeon_fireball
// Params 1, eflags: 0x4
// Checksum 0xb24503e9, Offset: 0xd9b
// Size: 0x47
function private function_f852fafd2dc8d85e( fireball )
{
    marker = fireball.marker;
    fireball waittill( #"death" );
    function_2158050101b6910( fireball, fireball.origin, marker );
}

// Namespace zombie_aeon_fireball
// Params 1
// Checksum 0x3e9ca2e7, Offset: 0xdea
// Size: 0x2a
function function_c291d57fcba11539( player )
{
    target_pos = function_d3b61dcd8642795b( player, self );
    thread function_623b53c05d07ecfe( target_pos );
}

// Namespace zombie_aeon_fireball
// Params 5, eflags: 0x4
// Checksum 0xde43c331, Offset: 0xe1c
// Size: 0x69
function private function_9416203139914738( damage, attacker, weapon, mod, vpoint )
{
    original_damage = damage;
    
    if ( isexplosivedamagemod( mod ) || mod == "MOD_IMPACT" )
    {
        damage *= getdvarfloat( @"hash_357aae916d12cfcc", 5 );
    }
    
    return damage;
}

/#

    // Namespace zombie_aeon_fireball
    // Params 0, eflags: 0x4
    // Checksum 0xde6a4930, Offset: 0xe8e
    // Size: 0x44, Type: dev
    function private function_97f8e1ef50104118()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x43>", "<dev string:x5a>", &function_610d6dc5b5bf1254 );
        devgui::add_devgui_func( "<dev string:x6e>", "<dev string:x84>", &toggle_debug_fireball );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_aeon_fireball
    // Params 0, eflags: 0x4
    // Checksum 0xa5a2b372, Offset: 0xeda
    // Size: 0x41, Type: dev
    function private function_610d6dc5b5bf1254()
    {
        aeon = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x98>" );
        
        if ( isdefined( aeon ) )
        {
            aeon function_29ce95199d42d5c4();
        }
    }

    // Namespace zombie_aeon_fireball
    // Params 0, eflags: 0x4
    // Checksum 0xb4b97e77, Offset: 0xf23
    // Size: 0x1a, Type: dev
    function private toggle_debug_fireball()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xa4>", @"hash_fabd1fce5e0c59bb" );
    }

#/
