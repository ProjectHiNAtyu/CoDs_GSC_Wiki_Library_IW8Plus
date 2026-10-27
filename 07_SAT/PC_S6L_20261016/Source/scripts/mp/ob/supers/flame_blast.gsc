// scripts\mp\ob\supers\flame_blast.gsc  (hash_1a7366a16665f35f.gscc) (size: 10066 Bytes / 0x2752 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x85e44a46 (2246330950)
// size ...... 10066 (0x2752)
// includes .. 9   (offset: 0x25d6)
// strings ... 10  (offset: 0x261e)
// dev strs .. 13  (offset: 0x26b6)
// exports ... 32  (offset: 0x15ba)
// cseg ...... 0xd3 + 0x14e7 (0x15ba)
// imports ... 95  (offset: 0x1aba)
// animtree1 . 0   (offset: 0x2752)
// animtree2 . 0   (offset: 0x2752)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\common\utility\disconnect_event_aggregator;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\supers;

#namespace flame_blast;

// Namespace flame_blast
// Params 0, eflags: 0x5
// Checksum 0x9e6559be, Offset: 0xf1
// Size: 0x18
function private autoexec main()
{
    level callback::add( #"register_super", &register );
}

// Namespace flame_blast
// Params 1, eflags: 0x4
// Checksum 0x1266fd79, Offset: 0x111
// Size: 0x93
function private register( params )
{
    super_bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_flame_blast" );
    
    if ( !super_bundle )
    {
        return;
    }
    
    supers_mp::function_48aaa60b2ce7b8a1( "super_flame_blast", undefined, undefined, &begin_use, &end_use );
    disconnect_event_aggregator::function_f460203966e88ab0( &function_afb772a4db682a6c );
    
    if ( utility::issharedfuncdefined( #"zombie_utils", #"registerdamagecallback" ) )
    {
        utility::callsharedfunc( #"zombie_utils", #"registerdamagecallback", &function_17fdfda41f9aa95a );
    }
    
    agent_utils::register_soldier_damage_callback( &function_17fdfda41f9aa95a );
}

// Namespace flame_blast
// Params 1, eflags: 0x4
// Checksum 0x727924c, Offset: 0x1ac
// Size: 0x26
function private function_afb772a4db682a6c( player )
{
    if ( player.flame_blast_started )
    {
        player end_use( 1, undefined );
    }
}

// Namespace flame_blast
// Params 0, eflags: 0x4
// Checksum 0x575f1689, Offset: 0x1da
// Size: 0x14b, Type: bool
function private begin_use()
{
    if ( !function_41c8d34fadc925fc() )
    {
        function_9b0065d6803f0742( self, &"hash_1ca56e292c03f694" );
        return false;
    }
    
    super_bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_flame_blast" );
    assert( isdefined( super_bundle ), "<dev string:x24>" );
    
    if ( super_bundle.var_8b9eade13fbfb044 )
    {
        assert( !callback::exists( #"super_cancel", &cancel ) );
        callback::add( #"super_cancel", &cancel );
    }
    
    function_b7dee0546f8e82f2( super_bundle );
    function_bdb50900034e7660( super_bundle );
    radius = super_bundle.flameblastradius ?? 200;
    height = super_bundle.flameblastheight;
    assert( height, "<dev string:x7f>" );
    thread do_explosion_damage( super_bundle, self.origin, radius, height );
    thread function_b907d8e405b3b980( super_bundle, self.origin, radius, height );
    thread function_fb4fed778e9ab57b( super_bundle, self.origin, radius, height );
    thread do_player_damage( super_bundle );
    
    if ( callback::exists_any( #"super_flame_blast_begin_use" ) )
    {
        callback::callback( #"super_flame_blast_begin_use" );
    }
    
    self.flame_blast_started = 1;
    return true;
}

// Namespace flame_blast
// Params 0, eflags: 0x4
// Checksum 0xc8e7f8d1, Offset: 0x32e
// Size: 0x18, Type: bool
function private function_41c8d34fadc925fc()
{
    if ( !self isonground() || self isjumping() )
    {
        return false;
    }
    
    return true;
}

// Namespace flame_blast
// Params 2, eflags: 0x4
// Checksum 0xba6dd254, Offset: 0x34f
// Size: 0xf8
function private end_use( fromdeath, attacker )
{
    level notify( #"flame_blast_end" );
    super_bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_flame_blast" );
    
    if ( super_bundle.var_8b9eade13fbfb044 )
    {
        assert( callback::exists( #"super_cancel", &cancel ) );
        callback::remove( #"super_cancel", &cancel );
    }
    
    foreach ( enemy in self.var_1b5b2111ae751c19 )
    {
        enemy function_de4d91eee52329da();
    }
    
    self.flame_blast_started = undefined;
}

// Namespace flame_blast
// Params 1, eflags: 0x4
// Checksum 0x571ad6e4, Offset: 0x44f
// Size: 0x2c
function private cancel( params )
{
    self notify( #"cancel_flame_blast" );
    destroy_fx( 0 );
    supers_mp::reducesuperusepercent( 1 );
}

// Namespace flame_blast
// Params 4, eflags: 0x4
// Checksum 0x9735092f, Offset: 0x483
// Size: 0x13f
function private function_fb4fed778e9ab57b( super_bundle, origin, radius, height )
{
    level endon( #"flame_blast_end" );
    waitdamage = super_bundle.var_288ad51eba7047cd ?? 0.5;
    self.var_1b5b2111ae751c19 = [];
    var_d0001bcf8f86189b = self geteye();
    
    while ( true )
    {
        enemies = get_nearby_enemies( super_bundle, origin, radius, height, var_d0001bcf8f86189b, { #duration:waitdamage, #color:( 1, 1, 0 ) } );
        
        foreach ( enemy in enemies )
        {
            self.var_1b5b2111ae751c19[ enemy getentitynumber() ] = enemy;
        }
        
        function_e7ab43c2d4148ebe( super_bundle, origin, enemies );
        function_ff6c3cd4c74f2cf1( super_bundle, origin, radius );
        wait waitdamage;
    }
}

// Namespace flame_blast
// Params 6, eflags: 0x4
// Checksum 0x1bd57a85, Offset: 0x5ca
// Size: 0x2ae
function private get_nearby_enemies( super_bundle, origin, radius, height, var_d0001bcf8f86189b, debugdata )
{
    nearby_ai = [];
    closeenemies = utility::function_f754506ecfae9afb( origin, radius, self, height, 1 );
    
    /#
        if ( getdvarint( @"hash_8954426906d32a44", 0 ) )
        {
            color = debugdata.color ?? ( 0.9, 0.7, 0.6 );
            duration = int( ( debugdata.duration ?? 1 ) / level.framedurationseconds );
            cylinder( origin + ( 0, 0, height * -1 ), origin + ( 0, 0, height ), radius, color, 0, duration );
        }
    #/
    
    foreach ( enemy in closeenemies )
    {
        entity_eye_position = issentient( enemy ) ? enemy geteye() : enemy.origin;
        var_617f2876f4b4344e = [ enemy, self ];
        contents = trace::create_default_contents( 1 ) - trace::function_bbd81e56529ef225();
        var_f2716b310a97eb1d = function_ed493f19c9f2846c( enemy );
        
        if ( var_f2716b310a97eb1d.size != 0 )
        {
            var_617f2876f4b4344e = arraycombine( var_617f2876f4b4344e, var_f2716b310a97eb1d );
        }
        
        if ( isalive( enemy ) && player_utility::playersareenemies( self, enemy ) )
        {
            trace_data = trace::ray_trace( var_d0001bcf8f86189b, entity_eye_position, var_617f2876f4b4344e, contents, 0, 1, 0, undefined, self.team );
            
            if ( trace_data[ "fraction" ] == 1 )
            {
                nearby_ai[ nearby_ai.size ] = enemy;
            }
            
            /#
                if ( getdvarint( @"hash_5ca31b0f9ce65421", 0 ) )
                {
                    if ( trace_data[ "<dev string:xb5>" ] != 1 )
                    {
                        color = debugdata.color ?? ( 0.9, 0.7, 0.6 );
                        duration = int( ( debugdata.duration ?? 1 ) / level.framedurationseconds );
                        debugstar( trace_data[ "<dev string:xbe>" ], color, duration, "<dev string:xc7>" );
                        debugstar( entity_eye_position, color, duration, "<dev string:xd1>" );
                        debugstar( var_d0001bcf8f86189b, color, duration, "<dev string:xe0>" );
                        line( var_d0001bcf8f86189b, entity_eye_position, color, 1, 0, duration );
                    }
                }
            #/
        }
    }
    
    return nearby_ai;
}

// Namespace flame_blast
// Params 1, eflags: 0x4
// Checksum 0x7901c833, Offset: 0x881
// Size: 0x27, Type: bool
function private is_dawg( entity )
{
    return entity && entity.subclass == #"dawg";
}

// Namespace flame_blast
// Params 1, eflags: 0x4
// Checksum 0x9dee4d4e, Offset: 0x8b1
// Size: 0x4f
function private function_ed493f19c9f2846c( target_entity )
{
    var_f2716b310a97eb1d = [];
    
    if ( is_dawg( target_entity ) )
    {
        turret = target_entity.turret;
        
        if ( turret )
        {
            var_f2716b310a97eb1d = arraycombineunique( var_f2716b310a97eb1d, [ turret ] );
        }
    }
    
    return var_f2716b310a97eb1d;
}

// Namespace flame_blast
// Params 3, eflags: 0x4
// Checksum 0xdc008397, Offset: 0x909
// Size: 0x93
function private function_e7ab43c2d4148ebe( super_bundle, origin, enemies )
{
    foreach ( enemy in enemies )
    {
        enemy function_f70e161fdf33dc56( super_bundle, origin, self );
    }
}

// Namespace flame_blast
// Params 3, eflags: 0x4
// Checksum 0x5026c8f7, Offset: 0x9a4
// Size: 0x6b
function private function_f70e161fdf33dc56( super_bundle, origin, superowner )
{
    self.var_1e4e4f652a252568 = superowner;
    damage_amount = function_c3a70d235b81f22c( super_bundle, self );
    
    if ( !damage_amount )
    {
        return;
    }
    
    if ( isagent( self ) )
    {
        burn_enemy( origin );
    }
    else
    {
        burn_player();
    }
    
    do_fire_damage( super_bundle, damage_amount, superowner );
}

// Namespace flame_blast
// Params 1, eflags: 0x4
// Checksum 0x6de17197, Offset: 0xa17
// Size: 0x99
function private get_damage_weapon( weaponname )
{
    sweapon = "none";
    
    if ( isdefined( level.weaponmetadata[ weaponname ] ) )
    {
        if ( !isdefined( level.weaponmetadata[ weaponname ].weaponobj ) )
        {
            sweapon = makeweapon( level.weaponmetadata[ weaponname ].weapon );
            level.weaponmetadata[ weaponname ].weaponobj = sweapon;
        }
        else
        {
            sweapon = level.weaponmetadata[ weaponname ].weaponobj;
        }
    }
    
    return sweapon;
}

// Namespace flame_blast
// Params 1, eflags: 0x4
// Checksum 0x346e6652, Offset: 0xab9
// Size: 0xa2
function private burn_enemy( origin )
{
    self._blackboard.isburning = 1;
    self.flame_blast_burning = 1;
    self.var_553ae45c1a5786fb = gettime();
    self.burningdirection = undefined;
    right = anglestoright( self.angles );
    tofire = vectornormalize( origin - self.origin );
    
    if ( vectordot( right, tofire ) > 0 )
    {
        self.burningdirection = "right";
        return;
    }
    
    self.burningdirection = "left";
}

// Namespace flame_blast
// Params 0, eflags: 0x4
// Checksum 0xf69706fb, Offset: 0xb63
// Size: 0x11, Type: bool
function private function_af1feabe896eff01()
{
    return self.type == "zombie";
}

// Namespace flame_blast
// Params 0, eflags: 0x4
// Checksum 0x20fbc3da, Offset: 0xb7d
// Size: 0x4b
function private function_de4d91eee52329da()
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( isagent( self ) )
    {
        self._blackboard.isburning = 0;
        self.burningdirection = "none";
    }
    
    self.var_1e4e4f652a252568 = undefined;
    self.flame_blast_burning = undefined;
}

// Namespace flame_blast
// Params 2, eflags: 0x4
// Checksum 0xcb3eec36, Offset: 0xbd0
// Size: 0x59
function private function_c3a70d235b81f22c( super_bundle, entity )
{
    if ( isagent( self ) )
    {
        if ( function_af1feabe896eff01() )
        {
            return ( super_bundle.var_84fe22cbfdc61d91 ?? 0 );
        }
        
        return ( super_bundle.var_29765bd1f039ab28 ?? 0 );
    }
    
    return super_bundle.var_1f781c927b99e0b2 ?? 0;
}

// Namespace flame_blast
// Params 1, eflags: 0x4
// Checksum 0x29f339f5, Offset: 0xc31
// Size: 0xa8
function private function_17fdfda41f9aa95a( params )
{
    idamage = params.idamage;
    eattacker = params.eattacker;
    super_bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_flame_blast" );
    
    if ( idamage >= self.health && isdefined( self.var_1e4e4f652a252568 ) )
    {
        assist_scoreevent = super_bundle.var_df65658c763e5070;
        
        if ( isdefined( assist_scoreevent ) )
        {
            if ( self.var_1e4e4f652a252568 != eattacker )
            {
                self.var_1e4e4f652a252568 namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( assist_scoreevent );
            }
        }
    }
    
    return idamage;
}

// Namespace flame_blast
// Params 1, eflags: 0x4
// Checksum 0xd1288123, Offset: 0xce2
// Size: 0x4d
function private function_b7dee0546f8e82f2( super_bundle )
{
    part = super_bundle.var_46b65a752548b0e3;
    state = super_bundle.var_55aff9c7df6a0947;
    
    if ( part && state )
    {
        utility::function_32b24db3127bff40( part, state );
    }
}

// Namespace flame_blast
// Params 1, eflags: 0x4
// Checksum 0xcbc9a849, Offset: 0xd37
// Size: 0xed
function private function_bdb50900034e7660( super_bundle )
{
    scriptablename = super_bundle.flameblastfx;
    part = super_bundle.var_fb88104c534631fa;
    state = super_bundle.var_5ede313e527384e8;
    
    if ( isdefined( scriptablename ) && isdefined( part ) && isdefined( state ) )
    {
        position = utility::drop_to_ground( self.origin );
        
        if ( utility::ispointinwater( position ) )
        {
            waterheight = getwaterheightatlocation( position );
            position = ( position[ 0 ], position[ 1 ], waterheight );
            scriptablename = super_bundle.var_c934bec2e717fc41;
        }
        
        self.flame_blast_scriptable = spawnscriptable( scriptablename, position, ( 0, 0, 0 ) );
        self.flame_blast_scriptable setscriptablepartstate( part, state, 0 );
        thread destroy_fx( super_bundle.usetime );
    }
}

// Namespace flame_blast
// Params 1, eflags: 0x4
// Checksum 0x8812f755, Offset: 0xe2c
// Size: 0x3f
function private destroy_fx( time )
{
    self endon( #"cancel_flame_blast" );
    wait time;
    
    if ( self.flame_blast_scriptable )
    {
        self.flame_blast_scriptable freescriptable();
        self.flame_blast_scriptable = undefined;
    }
}

// Namespace flame_blast
// Params 0, eflags: 0x4
// Checksum 0x4e98a9ab, Offset: 0xe73
// Size: 0x11
function private burn_player()
{
    thread damage_effects::enableburnfxfortime( 0.5, undefined, undefined, undefined );
}

// Namespace flame_blast
// Params 4, eflags: 0x4
// Checksum 0x7222ba8c, Offset: 0xe8c
// Size: 0x143
function private do_explosion_damage( super_bundle, origin, radius, height )
{
    var_c7fa44315d610df6 = super_bundle.var_12a5ebc568d8a1e3;
    
    if ( var_c7fa44315d610df6 > 0 )
    {
        self radiusdamage( self.origin, radius, var_c7fa44315d610df6, var_c7fa44315d610df6, self, "MOD_EXPLOSIVE", undefined, 1 );
    }
    
    var_d0001bcf8f86189b = self geteye();
    closeenemies = get_nearby_enemies( super_bundle, origin, radius, height, var_d0001bcf8f86189b, { #duration:3, #color:( 1, 0, 0 ) } );
    
    foreach ( enemy in closeenemies )
    {
        enemy.var_1e4e4f652a252568 = self;
        var_b20ad3d70f5f7a15 = enemy function_890830d18c82b3c8( super_bundle );
        
        if ( var_b20ad3d70f5f7a15 > 0 )
        {
            enemy do_fire_damage( super_bundle, var_b20ad3d70f5f7a15, self );
        }
    }
}

// Namespace flame_blast
// Params 4, eflags: 0x4
// Checksum 0x986e7238, Offset: 0xfd7
// Size: 0x123
function private function_b907d8e405b3b980( super_bundle, origin, radius, height )
{
    duration_s = utility::callsharedfunc( #"flame_blast_upgrade", #"hash_64e64b094ad00886" ) ?? super_bundle.var_4a4198efc40ccb7a;
    var_d0001bcf8f86189b = self geteye();
    closeenemies = get_nearby_enemies( super_bundle, origin, radius, height, var_d0001bcf8f86189b, { #duration:duration_s, #color:( 0, 1, 1 ) } );
    
    foreach ( enemy in closeenemies )
    {
        enemy.var_1e4e4f652a252568 = self;
        enemy thread function_dba3cd0abc732f58( super_bundle, origin, self, duration_s );
    }
}

// Namespace flame_blast
// Params 1, eflags: 0x4
// Checksum 0x1591a0f9, Offset: 0x1102
// Size: 0x44
function private function_890830d18c82b3c8( super_bundle )
{
    if ( isagent( self ) )
    {
        if ( function_af1feabe896eff01() )
        {
            return super_bundle.var_3d965efbb33b49a7;
        }
        
        return super_bundle.var_9632ef6b9b2d61a2;
    }
    
    return super_bundle.var_aaa8db827459c6a8;
}

// Namespace flame_blast
// Params 3, eflags: 0x4
// Checksum 0xdf2db1e9, Offset: 0x114e
// Size: 0xe0
function private function_ff6c3cd4c74f2cf1( super_bundle, origin, radius )
{
    targets_in_radius = utility::callsharedfunc( #"gamemode", #"hash_c263cfe56b50336d", origin, radius );
    assert( targets_in_radius, "<dev string:xef>" );
    damageamount = super_bundle.var_dc3d95114a37a92d ?? 0;
    
    foreach ( target in targets_in_radius )
    {
        target do_fire_damage( super_bundle, damageamount, self );
    }
}

// Namespace flame_blast
// Params 3, eflags: 0x4
// Checksum 0x6758fdd5, Offset: 0x1236
// Size: 0xe3
function private do_fire_damage( super_bundle, amount, inflictor )
{
    if ( isent( self ) && !isalive( self ) )
    {
        return;
    }
    
    weaponxhash = getxhashasset( super_bundle.offhandweapon );
    weapon = get_damage_weapon( weaponxhash );
    
    if ( isent( self ) )
    {
        source_position = self.origin;
        
        if ( self tagexists( "j_spine4" ) )
        {
            source_position = self gettagorigin( "j_spine4" );
        }
        
        self dodamage( amount, source_position, inflictor, inflictor, "MOD_FIRE", weapon, "none", undefined );
        return;
    }
    
    if ( self.classname == "scriptable" )
    {
        self scriptabledodamage( amount, inflictor, inflictor, undefined, undefined, "MOD_FIRE", weapon );
        return;
    }
    
    assertmsg( "<dev string:x134>" );
}

// Namespace flame_blast
// Params 4, eflags: 0x4
// Checksum 0x73e3f321, Offset: 0x1321
// Size: 0xc2
function private function_dba3cd0abc732f58( super_bundle, origin, inflictor, duration_s )
{
    if ( !super_bundle.var_3c06577679b43e03 )
    {
        return;
    }
    
    assert( duration_s, "<dev string:x188>" );
    self endon( #"death_or_disconnect" );
    duration_ms = duration_s * 1000;
    tick = super_bundle.var_af8693704780a883;
    damage = function_211e3a537ce0fee1( super_bundle );
    start = gettime();
    final_time = start + duration_ms;
    
    while ( final_time >= gettime() )
    {
        do_fire_damage( super_bundle, damage, inflictor );
        wait tick;
    }
}

// Namespace flame_blast
// Params 1, eflags: 0x4
// Checksum 0xa48236c6, Offset: 0x13eb
// Size: 0x2c
function private function_211e3a537ce0fee1( super_bundle )
{
    if ( function_af1feabe896eff01() )
    {
        return super_bundle.var_6dfb53026ca6ffc1;
    }
    
    return super_bundle.var_c3f46f261bc87678;
}

// Namespace flame_blast
// Params 1, eflags: 0x4
// Checksum 0x5556ac7e, Offset: 0x1420
// Size: 0x19a
function private do_player_damage( super_bundle )
{
    level endon( #"flame_blast_end" );
    data = utility::callsharedfunc( #"flame_blast_upgrade", #"hash_4bed473d5147db4d" );
    
    if ( !data )
    {
        return;
    }
    
    assert( data.radius, "<dev string:x1c0>" );
    assert( data.height, "<dev string:x1f0>" );
    assert( data.tick, "<dev string:x220>" );
    
    while ( true )
    {
        var_d0001bcf8f86189b = self geteye();
        enemies = get_nearby_enemies( super_bundle, self.origin, data.radius, data.height, var_d0001bcf8f86189b, { #duration:data.tick, #color:( 1, 0, 1 ) } );
        
        foreach ( enemy in enemies )
        {
            self.var_1b5b2111ae751c19[ enemy getentitynumber() ] = enemy;
        }
        
        function_e7ab43c2d4148ebe( super_bundle, self.origin, enemies );
        wait data.tick;
    }
}

