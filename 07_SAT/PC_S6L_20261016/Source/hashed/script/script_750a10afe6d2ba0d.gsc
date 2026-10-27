// script_750a10afe6d2ba0d  (hash_750a10afe6d2ba0d.gscc) (size: 15431 Bytes / 0x3c47 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf60a6eb0 (4127878832)
// size ...... 15431 (0x3c47)
// includes .. 11  (offset: 0x38eb)
// strings ... 20  (offset: 0x3943)
// dev strs .. 34  (offset: 0x3a8b)
// exports ... 40  (offset: 0x2723)
// cseg ...... 0x26d + 0x24b6 (0x2723)
// imports ... 91  (offset: 0x2d63)
// animtree1 . 0   (offset: 0x3c47)
// animtree2 . 0   (offset: 0x3c47)
#using script_4fb7a9021a570c8a;
#using script_726b7f033a90911c;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_weather_ash;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace namespace_a3bd843d6751814b;

// Namespace namespace_a3bd843d6751814b
// Params 2
// Checksum 0x90a18214, Offset: 0x28b
// Size: 0x4c
function function_3a9122eed114c07e( var_e917a56fdbc933d8, var_80c704f236f3564c )
{
    self function_786bb6aa1b76c7ee( "spawned_outside_ar", istrue( var_80c704f236f3564c ) );
    self.var_e19abb9365bc6b53 = var_e917a56fdbc933d8;
    
    if ( !isdefined( self.var_3ba5cca41a170ce1 ) )
    {
        self.var_3ba5cca41a170ce1 = 1;
    }
    
    thread function_f900d61db7dd0ca3();
}

// Namespace namespace_a3bd843d6751814b
// Params 0
// Checksum 0x51b037b, Offset: 0x2df
// Size: 0x41
function function_7cc2d4c4ce0ff8f1()
{
    self.var_897917611f631e21 = 1;
    self function_786bb6aa1b76c7ee( "in_assault_rounds_necrotic_beam", 1 );
    utility::waittill_notify_or_timeout( "necrotic_beam_end", 6 );
    self function_786bb6aa1b76c7ee( "in_assault_rounds_necrotic_beam", 0 );
    self.var_897917611f631e21 = undefined;
}

// Namespace namespace_a3bd843d6751814b
// Params 0, eflags: 0x4
// Checksum 0x4e942f3a, Offset: 0x328
// Size: 0x179
function private function_f900d61db7dd0ca3()
{
    self endon( #"death" );
    utility::ent_flag_wait_or_timeout( "zombie_diana_init_finished", 1 );
    self.var_d4f29f1205f3f7b9 = 0;
    self.var_736ad81cb3c31ad1 = 0;
    function_ddb360712f0a4a00();
    n_round = zm_utility::get_round_number();
    
    if ( n_round >= 20 || self getaiblackboarddynamic( "spawned_outside_ar" ) )
    {
        thread function_aac3640314955f0c();
    }
    
    if ( n_round >= 35 )
    {
        thread function_a97c728429e8c828( n_round );
        level scriptable::scriptable_adddamagedcallback( &function_44250a01ec80281e );
        level scriptable::scriptable_adddamagedcallback( &function_e7c571eab9b851fa );
    }
    
    if ( !level callback::exists( #"player_connect", &function_b9c1642bde47c11b ) )
    {
        level callback::add( #"player_connect", &function_b9c1642bde47c11b );
        level callback::add( #"player_disconnect", &function_8965ecaf1516540f );
        level callback::add( #"player_death", &function_6e281df8bb1784d6 );
    }
    
    callback::add( "on_zombie_ai_killed", &function_fd8c7377d1f93a26 );
    function_d01faf834b8475dc();
    self.var_e1e39ae3d1e328f2 = 0;
    self.var_ff219f9194fe30f9 = 0;
    self.var_ac4465b1f1aa0df3 = [];
    self.var_b63aa83ef70de29e = gettime();
    self.var_8a7fa492a053f745 = utility::function_4b74c15943231980( 14 + randomint( 7 ) );
    
    if ( n_round >= 10 )
    {
        thread function_c10dfd5544222fa();
    }
    
    if ( !level.var_2f33c6849dafc762 )
    {
        level thread function_853d74f79e93cbc9( n_round );
    }
    
    utility::ent_flag_set( "diana_init_assault_rounds_complete" );
}

// Namespace namespace_a3bd843d6751814b
// Params 1, eflags: 0xc
// Checksum 0x62729aa6, Offset: 0x4a9
// Size: 0x115
function private function_853d74f79e93cbc9( var_49f7091014d2c59 )
{
    self notify( #"hash_a597b44615b44afd" );
    self endon( #"hash_a597b44615b44afd" );
    level waittill( #"ar_wave_changed" );
    level.var_2f33c6849dafc762 = 1;
    level waittill( #"hash_c579d65184bf3689" );
    level.ar_root.ar_diana utility::ent_flag_wait_or_timeout( "diana_init_assault_rounds_complete", 1 );
    level.ar_root.ar_diana.var_3ba5cca41a170ce1 = 2;
    
    if ( var_49f7091014d2c59 >= 10 )
    {
        level.ar_root.ar_diana.var_8a7fa492a053f745 *= level.ar_root.var_c3964a7cd5a623f7 ?? 1;
    }
    
    if ( var_49f7091014d2c59 >= 35 )
    {
        level.ar_root.ar_diana function_ddb360712f0a4a00();
    }
    
    level.var_2f33c6849dafc762 = undefined;
}

// Namespace namespace_a3bd843d6751814b
// Params 0, eflags: 0xc
// Checksum 0xff8da28c, Offset: 0x5c6
// Size: 0x5a
function private function_aac3640314955f0c()
{
    self notify( #"hash_bde0c2abcbe3f9e4" );
    self endon( #"hash_bde0c2abcbe3f9e4" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"hash_77c5e586a6415185" );
        self.var_e4bcc3933afa5b26 = gettime();
        self notify( #"necrotic_projectile_start", 0, 0, 1, 1 );
    }
}

// Namespace namespace_a3bd843d6751814b
// Params 0, eflags: 0xc
// Checksum 0xa59cd274, Offset: 0x628
// Size: 0xaa
function private function_c10dfd5544222fa()
{
    self notify( #"hash_bb3dce9bc376b09c" );
    self endon( #"hash_bb3dce9bc376b09c" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"ar_summon_agnis_fire" );
        self.var_e1e39ae3d1e328f2++;
        self.var_ff219f9194fe30f9++;
        self.var_b63aa83ef70de29e = gettime();
        self.var_8a7fa492a053f745 = utility::function_4b74c15943231980( 14 + randomint( 7 ) );
        self notify( #"necrotic_projectile_start", 1, 0, 1, 1 );
        thread function_cd24e2f8667dc286();
        
        if ( self.var_ff219f9194fe30f9 >= function_f13a4029609c63a4( zm_utility::get_round_number() ) )
        {
            break;
        }
    }
}

// Namespace namespace_a3bd843d6751814b
// Params 0, eflags: 0x4
// Checksum 0xb885072, Offset: 0x6da
// Size: 0x4f
function private function_cd24e2f8667dc286()
{
    utility::waittill_any_in_array_or_timeout( [ "death", "necrotic_projectile_end" ], 10 );
    level.ar_root.var_a686c3ff0479034e = 0;
    
    if ( self && isalive( self ) )
    {
        self function_786bb6aa1b76c7ee( "in_ar_summon_agni_zombies", 0 );
    }
}

// Namespace namespace_a3bd843d6751814b
// Params 0, eflags: 0x4
// Checksum 0x6fcd59d8, Offset: 0x731
// Size: 0x1be
function private function_5c3543b723d1bb33()
{
    var_db5414021f73489e = 200;
    projectilestart = self gettagorigin( "tag_mouth_fx", 1 );
    
    if ( !isdefined( projectilestart ) )
    {
        projectilestart = self.origin + ( 0, 0, var_db5414021f73489e );
    }
    
    playersingame = arrayrandomize( level.players );
    
    if ( self getaiblackboarddynamic( "spawned_outside_ar" ) )
    {
        return function_66db41943e50e27( playersingame );
    }
    
    var_e66c62379dc98c74 = function_211da89ccef3a1dd();
    validtargets = [];
    
    foreach ( player in playersingame )
    {
        if ( !isalive( player ) || player.ignoreme || player.notarget || player.aether_shroud_active || player getthreatbiasgroup() == "ignored_by_zombies" || player.inlaststand || player.sessionstate != "playing" )
        {
            continue;
        }
        
        if ( isdefined( player.inlaststand ) && player.inlaststand )
        {
            continue;
        }
        
        if ( var_e66c62379dc98c74 && !function_436a2455f977a988( player, var_e66c62379dc98c74 ) )
        {
            continue;
        }
        
        if ( zombie_diana_targeting::function_2477c9e1c078ed6b( player ) )
        {
            validtargets[ validtargets.size ] = player;
        }
    }
    
    if ( validtargets.size <= 0 )
    {
        return function_64578d086f44bdb();
    }
    
    return validtargets[ randomint( validtargets.size ) ];
}

// Namespace namespace_a3bd843d6751814b
// Params 1, eflags: 0x4
// Checksum 0xdcb61188, Offset: 0x8f7
// Size: 0x298
function private function_66db41943e50e27( playersingame )
{
    if ( zm_sat_hornet_weather_ash::function_989fd2b3918fb9da() )
    {
        ashtargets = [];
        
        foreach ( player in playersingame )
        {
            if ( !isalive( player ) || player.ignoreme || player.notarget || player.aether_shroud_active || player getthreatbiasgroup() == "ignored_by_zombies" || player.inlaststand || player.sessionstate != "playing" )
            {
                continue;
            }
            
            if ( isdefined( player.inlaststand ) && player.inlaststand )
            {
                continue;
            }
            
            if ( !player.b_in_ash )
            {
                continue;
            }
            
            if ( zombie_diana_targeting::function_2477c9e1c078ed6b( player ) )
            {
                ashtargets[ ashtargets.size ] = player;
            }
        }
        
        if ( ashtargets.size > 0 )
        {
            return ashtargets[ randomint( ashtargets.size ) ];
        }
    }
    
    closestplayer = undefined;
    closestdistsq = undefined;
    
    foreach ( player in playersingame )
    {
        if ( !isalive( player ) || player.ignoreme || player.notarget || player.aether_shroud_active || player getthreatbiasgroup() == "ignored_by_zombies" || player.inlaststand || player.sessionstate != "playing" )
        {
            continue;
        }
        
        if ( isdefined( player.inlaststand ) && player.inlaststand )
        {
            continue;
        }
        
        if ( zombie_diana_targeting::function_2477c9e1c078ed6b( player ) )
        {
            distsq = distancesquared( self.origin, player.origin );
            
            if ( !isdefined( closestdistsq ) || distsq < closestdistsq )
            {
                closestdistsq = distsq;
                closestplayer = player;
            }
        }
    }
    
    return closestplayer;
}

// Namespace namespace_a3bd843d6751814b
// Params 0, eflags: 0x4
// Checksum 0xdf266846, Offset: 0xb98
// Size: 0x1c4
function private function_64578d086f44bdb()
{
    if ( level.players.size == 0 )
    {
        return;
    }
    
    playersingame = arrayrandomize( level.players );
    var_e66c62379dc98c74 = function_211da89ccef3a1dd();
    
    foreach ( player in playersingame )
    {
        if ( !isalive( player ) || player.ignoreme || player.notarget || player.aether_shroud_active || player getthreatbiasgroup() == "ignored_by_zombies" || player.inlaststand || player.sessionstate != "playing" )
        {
            continue;
        }
        
        if ( var_e66c62379dc98c74 && !function_436a2455f977a988( player, var_e66c62379dc98c74 ) )
        {
            continue;
        }
        
        playertacpoint = findclosesttacpoint( player.origin );
        
        if ( !playertacpoint )
        {
            continue;
        }
        
        var_34ac6fe65d588af5 = function_a2b8118bc03b66ac( playertacpoint );
        
        if ( !var_34ac6fe65d588af5 )
        {
            continue;
        }
        
        var_b5c8b28106687939 = distancesquared( player.origin, var_34ac6fe65d588af5 );
        
        if ( !isdefined( var_91b08fc612a71230 ) )
        {
            var_91b08fc612a71230 = var_b5c8b28106687939;
        }
        
        if ( var_b5c8b28106687939 <= var_91b08fc612a71230 )
        {
            var_91b08fc612a71230 = var_b5c8b28106687939;
            var_ffa2aa205a947885 = var_34ac6fe65d588af5;
        }
    }
    
    if ( var_ffa2aa205a947885 )
    {
        var_c2c65e42e44d788e = { #origin:var_ffa2aa205a947885 };
        return var_c2c65e42e44d788e;
    }
}

// Namespace namespace_a3bd843d6751814b
// Params 1, eflags: 0x4
// Checksum 0x16f44074, Offset: 0xd65
// Size: 0xc5
function private function_a2b8118bc03b66ac( playertacpoint )
{
    var_4d542f2d965a05b5 = 300;
    var_4e77b650e97eefed = 8;
    var_17ca6970e5d1c653 = ai::function_7bcb54b16c07d1ec( 1, playertacpoint.origin, 1, var_4d542f2d965a05b5, 50, 0, undefined, undefined, undefined, var_4e77b650e97eefed );
    
    foreach ( var_b956df46e3d76548 in var_17ca6970e5d1c653 )
    {
        if ( function_142d935271c541cc( var_b956df46e3d76548 ) )
        {
            return var_b956df46e3d76548;
        }
    }
}

// Namespace namespace_a3bd843d6751814b
// Params 1, eflags: 0x4
// Checksum 0xba4eac1e, Offset: 0xe33
// Size: 0x77, Type: bool
function private function_142d935271c541cc( var_19e8a077aed745dc )
{
    var_a717adefe6cf1477 = findclosesttacpoint( var_19e8a077aed745dc );
    
    if ( !tacpointexposedtosky( var_a717adefe6cf1477 ) )
    {
        return false;
    }
    
    var_47a4a6a0afd9ebbf = isdefined( zone_manager::function_90e5c3e2272b0130( var_19e8a077aed745dc ) );
    
    if ( !var_47a4a6a0afd9ebbf )
    {
        return false;
    }
    
    result = trace::ray_trace( self gettagorigin( "tag_mouth_fx" ), var_19e8a077aed745dc, [ self ], trace::create_world_contents() );
    return result[ "fraction" ] == 1;
}

// Namespace namespace_a3bd843d6751814b
// Params 0, eflags: 0x4
// Checksum 0x2d9ae341, Offset: 0xeb3
// Size: 0xb7
function private function_211da89ccef3a1dd()
{
    a_targets = level.ar_root.current_target;
    
    if ( !a_targets || isarray( a_targets ) && !a_targets.size )
    {
        return;
    }
    
    if ( isarray( level.ar_root.current_target ) )
    {
        currenttarget = a_targets[ 0 ];
    }
    else
    {
        currenttarget = level.ar_root.current_target;
    }
    
    capture_zone = zone_manager::function_90e5c3e2272b0130( currenttarget.origin );
    
    if ( !capture_zone )
    {
        return;
    }
    
    var_e66c62379dc98c74 = [ capture_zone.zone_name ];
    return var_e66c62379dc98c74;
}

// Namespace namespace_a3bd843d6751814b
// Params 2, eflags: 0x4
// Checksum 0xbdad1f89, Offset: 0xf73
// Size: 0xb0, Type: bool
function private function_436a2455f977a988( player, var_e66c62379dc98c74 )
{
    var_77898ab40e53d0ae = player zone_manager::get_current_zone();
    
    if ( !var_77898ab40e53d0ae )
    {
        return false;
    }
    
    foreach ( valid_name in var_e66c62379dc98c74 )
    {
        if ( issubstr( var_77898ab40e53d0ae.zone_name, valid_name ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_a3bd843d6751814b
// Params 2, eflags: 0x4
// Checksum 0xc4725f3a, Offset: 0x102c
// Size: 0xb0, Type: bool
function private function_69184ca3d461c7e1( origin, var_e66c62379dc98c74 )
{
    target_zone = zone_manager::function_90e5c3e2272b0130( origin );
    
    if ( !target_zone )
    {
        return false;
    }
    
    foreach ( valid_name in var_e66c62379dc98c74 )
    {
        if ( issubstr( target_zone.zone_name, valid_name ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_a3bd843d6751814b
// Params 1, eflags: 0x4
// Checksum 0x2de0316a, Offset: 0x10e5
// Size: 0xa2
function private function_98a890e6ec6a8dfc( n_round )
{
    var_6727f9e23fd5b684 = level.ar_root.ar_diana.var_3ba5cca41a170ce1 >= 2 ? level.ar_root.var_c3964a7cd5a623f7 : 1;
    
    if ( self getaiblackboarddynamic( "spawned_outside_ar" ) )
    {
        return utility::function_4b74c15943231980( 8 );
    }
    else if ( n_round < 50 )
    {
        return utility::function_4b74c15943231980( 24 * var_6727f9e23fd5b684 );
    }
    else if ( n_round < 100 )
    {
        return utility::function_4b74c15943231980( 20 * var_6727f9e23fd5b684 );
    }
    
    return utility::function_4b74c15943231980( 16 * var_6727f9e23fd5b684 );
}

// Namespace namespace_a3bd843d6751814b
// Params 1, eflags: 0x4
// Checksum 0x58b723c8, Offset: 0x1190
// Size: 0x35
function private function_f13a4029609c63a4( n_round )
{
    if ( n_round <= 30 )
    {
        return 2;
    }
    else if ( n_round <= 50 )
    {
        return 3;
    }
    else if ( n_round <= 100 )
    {
        return 4;
    }
    
    return 5;
}

// Namespace namespace_a3bd843d6751814b
// Params 1, eflags: 0xc
// Checksum 0xba2ed670, Offset: 0x11ce
// Size: 0x309
function private function_a97c728429e8c828( round )
{
    self notify( #"hash_d73a04bc753446d0" );
    self endon( #"hash_d73a04bc753446d0" );
    self endon( #"death" );
    self function_786bb6aa1b76c7ee( "in_assault_rounds_necrotic_beam", 0 );
    level.var_27972945ecc79c98 = {};
    level.var_27972945ecc79c98.var_16e45c9ea220659b = [];
    
    if ( round < 50 )
    {
        level.var_27972945ecc79c98.maxuses = 1;
        var_352317d25b3ab68a = { #var_24c392ef769e4ccb:0.5, #capturepoint:1 };
        level.var_27972945ecc79c98.var_16e45c9ea220659b[ level.var_27972945ecc79c98.var_16e45c9ea220659b.size ] = var_352317d25b3ab68a;
    }
    else if ( round < 100 )
    {
        level.var_27972945ecc79c98.maxuses = 2;
        var_a247db174774a548 = { #var_24c392ef769e4ccb:0.75, #capturepoint:1 };
        var_fcda8eda3679922a = { #var_24c392ef769e4ccb:0.5, #capturepoint:2 };
        level.var_27972945ecc79c98.var_16e45c9ea220659b[ level.var_27972945ecc79c98.var_16e45c9ea220659b.size ] = var_a247db174774a548;
        level.var_27972945ecc79c98.var_16e45c9ea220659b[ level.var_27972945ecc79c98.var_16e45c9ea220659b.size ] = var_fcda8eda3679922a;
    }
    else
    {
        level.var_27972945ecc79c98.maxuses = 2;
        var_a247db174774a548 = { #var_24c392ef769e4ccb:0.75, #capturepoint:1 };
        var_fcda8eda3679922a = { #var_24c392ef769e4ccb:0.75, #capturepoint:2 };
        level.var_27972945ecc79c98.var_16e45c9ea220659b[ level.var_27972945ecc79c98.var_16e45c9ea220659b.size ] = var_a247db174774a548;
        level.var_27972945ecc79c98.var_16e45c9ea220659b[ level.var_27972945ecc79c98.var_16e45c9ea220659b.size ] = var_fcda8eda3679922a;
    }
    
    if ( !level.var_27972945ecc79c98.maxuses )
    {
        return;
    }
    
    level.var_27972945ecc79c98.var_10bba0690d7721f = 0;
    
    for ( var_35454f44dc6b647e = 0; var_35454f44dc6b647e < level.var_27972945ecc79c98.maxuses ; var_35454f44dc6b647e++ )
    {
        level waittill( #"hash_2d8da929e6e4c1ff" );
        
        if ( self getaiblackboarddynamic( "in_necrotic_projectile" ) || self.var_982ca07527b7a9b9 )
        {
            utility::waittill_any_in_array_or_timeout( [ "necrotic_projectile_end", "assault_rounds_intro_end" ], 12 );
            wait 0.1;
        }
        
        self function_786bb6aa1b76c7ee( "in_assault_rounds_necrotic_beam", 1 );
        self function_786bb6aa1b76c7ee( "in_necrotic_breath_attack", 0 );
        utility::waittill_notify_or_timeout( "necrotic_beam_end", 6 );
        self function_786bb6aa1b76c7ee( "in_assault_rounds_necrotic_beam", 0 );
    }
}

// Namespace namespace_a3bd843d6751814b
// Params 11, eflags: 0x4
// Checksum 0xfe4fad7b, Offset: 0x14df
// Size: 0x159
function private function_44250a01ec80281e( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname )
{
    if ( isdefined( instance.type ) && getxhashasset( instance.type ) != %"zm_sat_hornet_komainu" )
    {
        return;
    }
    
    if ( !isscriptedai( eattacker ) || eattacker.team != zm_utility::get_zombie_team() )
    {
        return;
    }
    
    var_a5fff7fa83d85151 = level.var_27972945ecc79c98.var_16e45c9ea220659b[ level.var_27972945ecc79c98.var_10bba0690d7721f ];
    
    if ( var_a5fff7fa83d85151.var_24c392ef769e4ccb && level.ar_root.current_target_health <= level.ar_root.current_max_health * var_a5fff7fa83d85151.var_24c392ef769e4ccb )
    {
        level notify( #"hash_2d8da929e6e4c1ff" );
        level.var_27972945ecc79c98.var_10bba0690d7721f++;
        level scriptable::function_dc174fecebb79952( &function_44250a01ec80281e );
    }
}

// Namespace namespace_a3bd843d6751814b
// Params 11, eflags: 0x4
// Checksum 0x9a6cd4d0, Offset: 0x1640
// Size: 0x159
function private function_e7c571eab9b851fa( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname )
{
    if ( isdefined( instance.type ) && getxhashasset( instance.type ) != %"hash_51378b2eaa60d43" )
    {
        return;
    }
    
    if ( !isscriptedai( eattacker ) || eattacker.team != zm_utility::get_zombie_team() )
    {
        return;
    }
    
    var_a5fff7fa83d85151 = level.var_27972945ecc79c98.var_16e45c9ea220659b[ level.var_27972945ecc79c98.var_10bba0690d7721f ];
    
    if ( var_a5fff7fa83d85151.var_24c392ef769e4ccb && level.ar_root.current_target_health <= level.ar_root.current_max_health * var_a5fff7fa83d85151.var_24c392ef769e4ccb )
    {
        level notify( #"hash_2d8da929e6e4c1ff" );
        level.var_27972945ecc79c98.var_10bba0690d7721f++;
        level scriptable::function_dc174fecebb79952( &function_e7c571eab9b851fa );
    }
}

// Namespace namespace_a3bd843d6751814b
// Params 0, eflags: 0x4
// Checksum 0xc789bb90, Offset: 0x17a1
// Size: 0x4d
function private function_b858e4a1d63bb289()
{
    structname = "ar_beam_" + self.var_e19abb9365bc6b53 + "_" + self.var_3ba5cca41a170ce1;
    beamendpoint = utility::getstruct( structname, "targetname" );
    
    if ( !beamendpoint )
    {
        return;
    }
    
    return beamendpoint;
}

// Namespace namespace_a3bd843d6751814b
// Params 0, eflags: 0x4
// Checksum 0x3d2b25c4, Offset: 0x17f7
// Size: 0x218
function private function_ddb360712f0a4a00()
{
    var_1821b22d33493b39 = self.var_e19abb9365bc6b53 + "_" + self.var_3ba5cca41a170ce1;
    
    switch ( var_1821b22d33493b39 )
    {
        case #"hash_3fb3e28ca5159c0f":
            var_eae9ccfd2469d520 = 2.5;
            var_abec8411e225b966 = 0.125;
            var_d1d146f4a8aa850b = 300;
            beamvelocity = 1500;
            break;
        case #"hash_3fb3e38ca5159da2":
            var_bf44f13272202612 = -60;
            var_eae9ccfd2469d520 = 2.2;
            var_abec8411e225b966 = 0.125;
            var_d1d146f4a8aa850b = 200;
            beamvelocity = 1500;
            break;
        case #"hash_4774d78ca93c887e":
            var_bf44f13272202612 = -45;
            var_eae9ccfd2469d520 = 2.25;
            var_abec8411e225b966 = 0.125;
            var_d1d146f4a8aa850b = 250;
            beamvelocity = 500;
            break;
        case #"hash_4774d68ca93c86eb":
            var_eae9ccfd2469d520 = 2.25;
            var_abec8411e225b966 = 0.12;
            var_d1d146f4a8aa850b = 250;
            beamvelocity = 550;
            break;
        case #"hash_4e6cb08cacc57819":
            var_eae9ccfd2469d520 = 2.2;
            var_abec8411e225b966 = 0.11;
            var_d1d146f4a8aa850b = 200;
            beamvelocity = 800;
            break;
        case #"hash_4e6cad8cacc57360":
            var_eae9ccfd2469d520 = 2.2;
            var_abec8411e225b966 = 0.1;
            var_d1d146f4a8aa850b = 90;
            beamvelocity = 700;
            break;
        case #"hash_549aa58cafaf3008":
            var_eae9ccfd2469d520 = 2.5;
            var_abec8411e225b966 = 0.1;
            var_d1d146f4a8aa850b = 150;
            beamvelocity = 1000;
            break;
        case #"hash_549aa88cafaf34c1":
            var_eae9ccfd2469d520 = 2.2;
            var_abec8411e225b966 = 0.08;
            var_d1d146f4a8aa850b = 200;
            beamvelocity = 1600;
            break;
    }
    
    self.var_bf44f13272202612 = getdvarfloat( @"hash_fa616db0c910241", var_bf44f13272202612 ?? -70 );
    self.var_eae9ccfd2469d520 = getdvarfloat( @"hash_97affe66caaf61e0", var_eae9ccfd2469d520 );
    self.var_abec8411e225b966 = getdvarfloat( @"hash_179a41b7d41a6caf", var_abec8411e225b966 );
    self.var_6d139d6f89ee9f49 = getdvarfloat( @"hash_e3faf3074e42aeb0", beamvelocity );
    self.var_92cadc58744429e8 = getdvarfloat( @"hash_8bcc8e2e2cc7cb86", var_d1d146f4a8aa850b );
}

// Namespace namespace_a3bd843d6751814b
// Params 2
// Checksum 0xe66adf57, Offset: 0x1a17
// Size: 0xb8
function function_cb740a51baec8fc7( taskid, params )
{
    n_round = zm_utility::get_round_number();
    
    if ( n_round < 20 && !self getaiblackboarddynamic( "spawned_outside_ar" ) )
    {
        return anim.failure;
    }
    
    cooldown = function_98a890e6ec6a8dfc( n_round );
    var_2fa808a2a658dd5f = gettime() - ( self.var_e4bcc3933afa5b26 ?? 0 );
    
    if ( var_2fa808a2a658dd5f <= cooldown )
    {
        return anim.failure;
    }
    
    target = function_5c3543b723d1bb33();
    
    if ( target )
    {
        zombie_diana_targeting::set_diana_target( target );
        return anim.success;
    }
    
    return anim.failure;
}

// Namespace namespace_a3bd843d6751814b
// Params 2
// Checksum 0xc3c7f116, Offset: 0x1ad8
// Size: 0x79
function function_e745ea87769a811e( taskid, params )
{
    var_cd91e6d17888d203 = function_b858e4a1d63bb289();
    
    if ( var_cd91e6d17888d203 && ( level.var_27972945ecc79c98 || self.var_897917611f631e21 ) )
    {
        zombie_diana_targeting::set_diana_target( var_cd91e6d17888d203 );
        self notify( #"necrotic_beam_start", var_cd91e6d17888d203.origin );
        return anim.success;
    }
    
    return anim.failure;
}

// Namespace namespace_a3bd843d6751814b
// Params 2
// Checksum 0x57d20b35, Offset: 0x1b5a
// Size: 0x196
function function_c1d3c35d6f4546a5( taskid, params )
{
    n_round = zm_utility::get_round_number();
    
    if ( n_round < 10 )
    {
        return anim.failure;
    }
    
    if ( self getaiblackboarddynamic( "spawned_outside_ar" ) )
    {
        return anim.failure;
    }
    
    var_e780ae614ef05a11 = function_f13a4029609c63a4( n_round );
    
    if ( self.var_ff219f9194fe30f9 >= var_e780ae614ef05a11 )
    {
        return anim.failure;
    }
    
    var_788496dfcf788f4d = gettime() - ( self.var_b63aa83ef70de29e ?? 0 );
    
    if ( var_788496dfcf788f4d <= ( self.var_8a7fa492a053f745 ?? 0 ) )
    {
        return anim.failure;
    }
    
    target = function_1acf4250a0e1500c();
    
    if ( !target )
    {
        if ( level.ar_root.var_a686c3ff0479034e )
        {
            level.ar_root.var_a686c3ff0479034e = 0;
        }
        
        return anim.failure;
    }
    
    if ( !function_1ee0cbf4c51992de() )
    {
        if ( !level.ar_root.var_a686c3ff0479034e )
        {
            level.ar_root.var_a686c3ff0479034e = 1;
        }
        
        return anim.failure;
    }
    
    if ( !level.ar_root.var_a686c3ff0479034e )
    {
        level.ar_root.var_a686c3ff0479034e = 1;
    }
    
    zombie_diana_targeting::set_diana_target( target );
    self.var_ac4465b1f1aa0df3[ self.var_ac4465b1f1aa0df3.size ] = target;
    return anim.success;
}

// Namespace namespace_a3bd843d6751814b
// Params 0, eflags: 0x4
// Checksum 0x7e512e7f, Offset: 0x1cf9
// Size: 0x4e, Type: bool
function private function_1ee0cbf4c51992de()
{
    spawn_limit = level.ar_root.var_2476fef49008ba4e[ level.players.size - 1 ];
    active_zombies_count = zm_utility::get_active_zombies_count();
    return active_zombies_count + self.var_8ef0695e15c92a76 <= spawn_limit;
}

// Namespace namespace_a3bd843d6751814b
// Params 0, eflags: 0x4
// Checksum 0x1a7aa39f, Offset: 0x1d50
// Size: 0xf4
function private function_1acf4250a0e1500c()
{
    structname = "ar_summon_agnis_" + self.var_e19abb9365bc6b53 + "_" + self.var_3ba5cca41a170ce1;
    var_ab65f1a58c957fd4 = utility::getstructarray( structname, "targetname" );
    
    if ( !var_ab65f1a58c957fd4.size )
    {
        return;
    }
    
    a_available = [];
    
    foreach ( spot in var_ab65f1a58c957fd4 )
    {
        if ( !arraycontains( self.var_ac4465b1f1aa0df3, spot ) )
        {
            a_available[ a_available.size ] = spot;
        }
    }
    
    if ( !a_available.size )
    {
        return;
    }
    
    selected = utility::array_random( a_available );
    return selected;
}

// Namespace namespace_a3bd843d6751814b
// Params 0, eflags: 0x4
// Checksum 0x6f447f2a, Offset: 0x1e4d
// Size: 0x73
function private function_d01faf834b8475dc()
{
    switch ( level.players.size )
    {
        case 1:
            n_count = 3;
            break;
        case 2:
            n_count = 4;
            break;
        case 3:
            n_count = 4;
            break;
        default:
            n_count = 5;
            break;
    }
    
    zombie_diana_summon_agni_zombies::function_9c7d278fe17b7c00( n_count );
}

// Namespace namespace_a3bd843d6751814b
// Params 1, eflags: 0x4
// Checksum 0x5571d436, Offset: 0x1ec8
// Size: 0x46
function private function_b9c1642bde47c11b( params )
{
    if ( level.ar_root.ar_diana.var_8ef0695e15c92a76 )
    {
        level.ar_root.ar_diana function_d01faf834b8475dc();
    }
}

// Namespace namespace_a3bd843d6751814b
// Params 1, eflags: 0x4
// Checksum 0x678fc0b6, Offset: 0x1f16
// Size: 0x46
function private function_8965ecaf1516540f( params )
{
    if ( level.ar_root.ar_diana.var_8ef0695e15c92a76 )
    {
        level.ar_root.ar_diana function_d01faf834b8475dc();
    }
}

// Namespace namespace_a3bd843d6751814b
// Params 1, eflags: 0x4
// Checksum 0x1ddaf818, Offset: 0x1f64
// Size: 0x46
function private function_6e281df8bb1784d6( params )
{
    if ( level.ar_root.ar_diana.var_8ef0695e15c92a76 )
    {
        level.ar_root.ar_diana function_d01faf834b8475dc();
    }
}

// Namespace namespace_a3bd843d6751814b
// Params 1, eflags: 0x4
// Checksum 0xf74b7805, Offset: 0x1fb2
// Size: 0x63
function private function_fd8c7377d1f93a26( params )
{
    level callback::remove( #"player_connect", &function_b9c1642bde47c11b );
    level callback::remove( #"player_disconnect", &function_8965ecaf1516540f );
    level callback::remove( #"player_death", &function_6e281df8bb1784d6 );
    level.ar_root.var_a686c3ff0479034e = 0;
}

/#

    // Namespace namespace_a3bd843d6751814b
    // Params 0
    // Checksum 0x5e40d8a4, Offset: 0x201d
    // Size: 0x130, Type: dev
    function function_6ddfd90eb0ccc9a2()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x4c>", "<dev string:x69>", &function_f68c5147fa99ddad );
        devgui::add_devgui_func( "<dev string:x80>", "<dev string:x97>", &function_bf33551af4759ba1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xae>", "<dev string:xd8>", &function_a39dccd0ea42b61d, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xed>", "<dev string:x117>", &function_a39dccd0ea42b61d, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x12c>", "<dev string:x156>", &function_a39dccd0ea42b61d, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x16b>", "<dev string:x195>", &function_a39dccd0ea42b61d, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1aa>", "<dev string:x1d4>", &function_a39dccd0ea42b61d, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x1e9>", "<dev string:x213>", &function_a39dccd0ea42b61d, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x228>", "<dev string:x252>", &function_a39dccd0ea42b61d, 1 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x267>", "<dev string:x291>", &function_a39dccd0ea42b61d, 1 );
        devgui::add_devgui_func( "<dev string:x2a6>", "<dev string:x2c6>", &function_2f2ff0bb6fcedc5f );
        devgui::add_devgui_func( "<dev string:x2e0>", "<dev string:x2f9>", &function_c75da6ec78d41572 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_a3bd843d6751814b
    // Params 1
    // Checksum 0x9e256b24, Offset: 0x2155
    // Size: 0x62, Type: dev
    function function_f68c5147fa99ddad( params )
    {
        diana = level.ar_root.ar_diana;
        
        if ( !isalive( diana ) )
        {
            return;
        }
        
        diana.var_b14209598a0140ab = level.players[ 0 ];
        diana notify( #"necrotic_projectile_start", 0, 0, 0, 1 );
    }

    // Namespace namespace_a3bd843d6751814b
    // Params 1
    // Checksum 0x693ecc68, Offset: 0x21bf
    // Size: 0x59, Type: dev
    function function_bf33551af4759ba1( params )
    {
        diana = level.ar_root.ar_diana;
        
        if ( !isalive( diana ) )
        {
            return;
        }
        
        diana.var_b14209598a0140ab = level.players[ 0 ];
        diana function_7cc2d4c4ce0ff8f1();
    }

    // Namespace namespace_a3bd843d6751814b
    // Params 1
    // Checksum 0x8f290858, Offset: 0x2220
    // Size: 0x1ff, Type: dev
    function function_a39dccd0ea42b61d( params )
    {
        if ( !isdefined( params[ 0 ] ) )
        {
            return;
        }
        
        diana = level.ar_root.ar_diana;
        
        if ( !isalive( diana ) )
        {
            return;
        }
        
        token = params[ 0 ];
        
        switch ( token )
        {
            case #"hash_115bfc04dde8de39":
                diana.var_e19abb9365bc6b53 = "<dev string:x319>";
                diana.var_3ba5cca41a170ce1 = 1;
                break;
            case #"hash_115bf904dde8d980":
                diana.var_e19abb9365bc6b53 = "<dev string:x319>";
                diana.var_3ba5cca41a170ce1 = 2;
                break;
            case #"hash_fa18d504d173a794":
                diana.var_e19abb9365bc6b53 = "<dev string:x32f>";
                diana.var_3ba5cca41a170ce1 = 1;
                break;
            case #"hash_fa18d804d173ac4d":
                diana.var_e19abb9365bc6b53 = "<dev string:x32f>";
                diana.var_3ba5cca41a170ce1 = 2;
                break;
            case #"hash_110ae04d4fc972f":
                diana.var_e19abb9365bc6b53 = "<dev string:x345>";
                diana.var_3ba5cca41a170ce1 = 1;
                break;
            case #"hash_110af04d4fc98c2":
                diana.var_e19abb9365bc6b53 = "<dev string:x345>";
                diana.var_3ba5cca41a170ce1 = 2;
                break;
            case #"hash_2642bf04e8827232":
                diana.var_e19abb9365bc6b53 = "<dev string:x35b>";
                diana.var_3ba5cca41a170ce1 = 1;
                break;
            case #"hash_2642be04e882709f":
                diana.var_e19abb9365bc6b53 = "<dev string:x35b>";
                diana.var_3ba5cca41a170ce1 = 2;
                break;
            default:
                return;
        }
        
        diana function_ddb360712f0a4a00();
        diana.var_b14209598a0140ab = level.players[ 0 ];
        diana function_7cc2d4c4ce0ff8f1();
    }

    // Namespace namespace_a3bd843d6751814b
    // Params 1
    // Checksum 0xc9e03338, Offset: 0x2427
    // Size: 0x63, Type: dev
    function function_2f2ff0bb6fcedc5f( params )
    {
        diana = level.ar_root.ar_diana;
        
        if ( !isalive( diana ) )
        {
            return;
        }
        
        diana.var_b14209598a0140ab = level.players[ 0 ];
        diana notify( #"necrotic_projectile_start", 1, 0, 0, 1 );
    }

    // Namespace namespace_a3bd843d6751814b
    // Params 1
    // Checksum 0x9336d94a, Offset: 0x2492
    // Size: 0x45, Type: dev
    function function_c75da6ec78d41572( params )
    {
        if ( level.var_b05b9b7eb4c6d57 )
        {
            level.var_b05b9b7eb4c6d57 = 0;
            level notify( #"hash_e4a9e9acab3ad057" );
            return;
        }
        
        level.var_b05b9b7eb4c6d57 = 1;
        level thread function_69cd2244d3f1d9e2();
    }

    // Namespace namespace_a3bd843d6751814b
    // Params 0
    // Checksum 0x5af66ea3, Offset: 0x24df
    // Size: 0x244, Type: dev
    function function_69cd2244d3f1d9e2()
    {
        level endon( #"hash_e4a9e9acab3ad057" );
        var_683480005b7ca111 = [ "<dev string:x319>", "<dev string:x32f>", "<dev string:x345>", "<dev string:x35b>" ];
        var_c2624adec70d2b42 = [ 1, 2 ];
        
        while ( true )
        {
            foreach ( var_e917a56fdbc933d8 in var_683480005b7ca111 )
            {
                foreach ( capturepoint in var_c2624adec70d2b42 )
                {
                    structname = "<dev string:x36a>" + var_e917a56fdbc933d8 + "<dev string:x37b>" + capturepoint;
                    var_1fffbca07ddaae4e = utility::getstructarray( structname, "<dev string:x37d>" );
                    
                    foreach ( idx, loc in var_1fffbca07ddaae4e )
                    {
                        debugstar( loc.origin, ( 1, 0.5, 0 ), level.frameduration );
                        print3d( loc.origin + ( 0, 0, 20 ), var_e917a56fdbc933d8 + "<dev string:x37b>" + capturepoint + "<dev string:x388>" + idx + "<dev string:x38b>", ( 1, 0.5, 0 ), 1, 0.5, level.frameduration );
                    }
                }
            }
            
            waitframe();
        }
    }

#/
