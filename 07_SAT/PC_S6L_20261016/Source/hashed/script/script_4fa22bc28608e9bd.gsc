// script_4fa22bc28608e9bd  (hash_4fa22bc28608e9bd.gscc) (size: 11188 Bytes / 0x2bb4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1f999584 (530158980)
// size ...... 11188 (0x2bb4)
// includes .. 10  (offset: 0x28b4)
// strings ... 37  (offset: 0x2904)
// dev strs .. 11  (offset: 0x2b2c)
// exports ... 25  (offset: 0x18f8)
// cseg ...... 0x299 + 0x165f (0x18f8)
// imports ... 97  (offset: 0x1ce0)
// animtree1 . 0   (offset: 0x2bb4)
// animtree2 . 0   (offset: 0x2bb4)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_disciple\zombie_disciple;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\throttle;
#using scripts\common\utility;

#namespace namespace_d4e7a14ee55bd048;

// Namespace namespace_d4e7a14ee55bd048
// Params 1
// Checksum 0xe8c94d12, Offset: 0x2b7
// Size: 0x3d
function function_a13ce4b7ef033fc6( aitypescriptbundle )
{
    settings = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    
    if ( isdefined( settings ) )
    {
        utility::add_fx( "disciple_binding_trail_fx", settings.var_8417d5259afd45bd );
    }
}

// Namespace namespace_d4e7a14ee55bd048
// Params 0
// Checksum 0xda23f939, Offset: 0x2fc
// Size: 0x16
function function_475849a0c68c6e47()
{
    level.var_86b1a5e1af185c5d = [];
    
    /#
        function_6bac40e4542b29df();
    #/
}

// Namespace namespace_d4e7a14ee55bd048
// Params 0
// Checksum 0x55be3209, Offset: 0x31a
// Size: 0xc2
function init_zombie_disciple_bind()
{
    self.var_10f573f354866b22 = [];
    self.var_a1645724e5517713 = 0;
    self.var_7540cca05a1c9472 = 0;
    self.var_b71bb0b5b2399e34 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_853cccc95dc0ca6;
    self.var_86fae3f99538b683 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_406f8dce0b79bc09;
    self.var_e598aad55093504a = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.disablebind;
    callback::add( #"on_ai_killed", &function_bf731e5c7eae0684 );
    
    if ( self getaiblackboarddynamic( "can_bind_zombies" ) )
    {
        thread function_7abdb1f886503db2();
        thread function_75f2872d153ffa88();
    }
}

// Namespace namespace_d4e7a14ee55bd048
// Params 0
// Checksum 0xd99910b9, Offset: 0x3e4
// Size: 0x5b
function function_75f2872d153ffa88()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"bind_start" );
        utility::ent_flag_set( "playing_binding_anim" );
        childthread zombie_disciple_bind_loop();
        self waittill( #"bind_stop" );
        utility::ent_flag_clear( "playing_binding_anim" );
        self function_786bb6aa1b76c7ee( "in_bind", 0 );
    }
}

// Namespace namespace_d4e7a14ee55bd048
// Params 0
// Checksum 0xb2c6620c, Offset: 0x447
// Size: 0x1b
function function_87343acd4de8793d()
{
    return max( self.var_b71bb0b5b2399e34 - self.var_10f573f354866b22.size, 0 );
}

// Namespace namespace_d4e7a14ee55bd048
// Params 0
// Checksum 0x5b368e6d, Offset: 0x46b
// Size: 0xc4, Type: bool
function can_bind_zombies()
{
    if ( function_87343acd4de8793d() <= 0 || self.var_a1645724e5517713 > gettime() || utility::ent_flag( "playing_binding_anim" ) )
    {
        return false;
    }
    
    self.var_9512792ecf8ee81e = utility::function_8391781ea0784541( self.var_9512792ecf8ee81e );
    closest_target = function_47c86977a18df38b( self.var_9512792ecf8ee81e, self.origin );
    
    if ( isdefined( closest_target ) )
    {
        var_4985ccf57a66ed0b = 10000;
        
        if ( lengthsquared( closest_target.velocity ) > lengthsquared( self.velocity ) )
        {
            var_4985ccf57a66ed0b = 20000;
        }
        
        if ( distancesquared( closest_target.origin, self.origin ) < var_4985ccf57a66ed0b )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_d4e7a14ee55bd048
// Params 0
// Checksum 0xf3a9d935, Offset: 0x538
// Size: 0xe, Type: bool
function has_binding_zombies()
{
    return self.var_63907d2aff8c28db.size > 0;
}

// Namespace namespace_d4e7a14ee55bd048
// Params 1
// Checksum 0x9b5daaaf, Offset: 0x54f
// Size: 0x77
function function_bf731e5c7eae0684( params )
{
    if ( isplayer( params.eattacker ) && isdefined( self.var_10f573f354866b22 ) && self.var_10f573f354866b22.size >= 5 )
    {
        params.eattacker namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"disciple_cultivated" );
    }
    
    function_cd1baf9ffcd917cc( self.var_86fae3f99538b683 );
    level.var_86b1a5e1af185c5d[ self getentitynumber() ] = undefined;
}

// Namespace namespace_d4e7a14ee55bd048
// Params 0
// Checksum 0x7926bb23, Offset: 0x5ce
// Size: 0x317
function zombie_disciple_bind_loop()
{
    var_f90cb96dac6d45f5 = function_87343acd4de8793d();
    self.var_9512792ecf8ee81e = utility::function_8391781ea0784541( self.var_9512792ecf8ee81e );
    var_63907d2aff8c28db = utility::get_array_of_closest( self.origin, self.var_9512792ecf8ee81e, self.var_10f573f354866b22, var_f90cb96dac6d45f5, 200 );
    self.var_63907d2aff8c28db = function_46f9072493651dc9( var_63907d2aff8c28db );
    
    if ( self.var_63907d2aff8c28db.size <= 0 )
    {
        self function_786bb6aa1b76c7ee( "in_bind", 0 );
        return;
    }
    
    var_d1e3024e8fd86253 = 2000;
    var_d1e3024e8fd86253 += max( 0, self.var_63907d2aff8c28db.size - 1 ) * 2000;
    
    foreach ( zombie in self.var_63907d2aff8c28db )
    {
        zombie zombie_stun::stun_ai( var_d1e3024e8fd86253 / 1000 + 1 );
        zombie utility::ent_flag_set( "disciple_binding" );
    }
    
    initial_bind_time = 2000;
    
    if ( self.var_10f573f354866b22.size == 0 )
    {
        initial_bind_time *= 0.25;
    }
    
    bind_time_finished = gettime() + initial_bind_time;
    
    while ( true )
    {
        waitframe();
        self.var_63907d2aff8c28db = function_46f9072493651dc9( self.var_63907d2aff8c28db );
        
        if ( self.var_63907d2aff8c28db.size <= 0 )
        {
            break;
        }
        
        if ( !self getaiblackboarddynamic( "in_bind" ) )
        {
            break;
        }
        
        function_eba7523133f10744();
        
        if ( gettime() > bind_time_finished )
        {
            var_310366f5854fb0aa = utility::array_get_first_item( self.var_63907d2aff8c28db );
            var_310366f5854fb0aa zombie_stun::function_d738299157923d28();
            var_310366f5854fb0aa utility::ent_flag_clear( "disciple_binding" );
            function_bed09be6d0f32085( var_310366f5854fb0aa );
            bind_time_additional = 2000;
            
            if ( self.var_7540cca05a1c9472 < 5 )
            {
                bind_time_additional = 500;
            }
            
            bind_time_finished = gettime() + bind_time_additional;
            self.var_63907d2aff8c28db = arrayremove( self.var_63907d2aff8c28db, var_310366f5854fb0aa );
        }
    }
    
    self function_786bb6aa1b76c7ee( "in_bind", 0 );
    
    foreach ( zombie in self.var_63907d2aff8c28db )
    {
        if ( isdefined( zombie ) )
        {
            zombie zombie_stun::function_d738299157923d28();
            zombie utility::ent_flag_clear( "disciple_binding" );
            zombie utility::function_32b24db3127bff40( "bound", "bound_off" );
        }
    }
    
    self.var_59d2648db909ddd2 = undefined;
    self.var_63907d2aff8c28db = undefined;
    
    if ( self.var_7540cca05a1c9472 >= 5 )
    {
        self.var_a1645724e5517713 = gettime() + 10000;
    }
}

// Namespace namespace_d4e7a14ee55bd048
// Params 0
// Checksum 0x7d6cbbb0, Offset: 0x8ed
// Size: 0x17b
function function_eba7523133f10744()
{
    var_310366f5854fb0aa = utility::array_get_first_item( self.var_63907d2aff8c28db );
    
    if ( isalive( var_310366f5854fb0aa ) )
    {
        var_310366f5854fb0aa utility::function_32b24db3127bff40( "bound", "bound_in" );
        yaw_to_zombie = vectortoyaw( var_310366f5854fb0aa.origin - self.origin );
        yaw_diff = absangleclamp180( yaw_to_zombie - self.angles[ 1 ] );
        self orientmode( "face angle", yaw_to_zombie );
        
        if ( yaw_diff <= 30 && self.var_385d082dbe678eb6 != var_310366f5854fb0aa )
        {
            var_cfef7011ed933b53 = self getcentroid() + ( 0, 0, 20 );
            target_pos = var_310366f5854fb0aa.origin + ( 0, 0, 50 );
            var_a7366865b8939da9 = getdvarfloat( @"hash_7e729eb90dd89489", 400 );
            assert( var_a7366865b8939da9 > 0 );
            n_time = distance( var_cfef7011ed933b53, target_pos ) / var_a7366865b8939da9;
            var_8b3ae32294d459f9 = utility::spawn_model( "tag_origin", var_cfef7011ed933b53 );
            
            if ( isdefined( var_8b3ae32294d459f9 ) )
            {
                utility::function_32b24db3127bff40( "sound_vo", "bind_vo" );
                playfxontag( utility::getfx( "disciple_binding_trail_fx" ), var_8b3ae32294d459f9, "tag_origin" );
                var_8b3ae32294d459f9 moveto( target_pos, n_time );
                var_8b3ae32294d459f9 thread function_8b6076077ffecca5( var_310366f5854fb0aa );
            }
            
            self.var_385d082dbe678eb6 = var_310366f5854fb0aa;
        }
    }
}

// Namespace namespace_d4e7a14ee55bd048
// Params 1
// Checksum 0x8a380d27, Offset: 0xa70
// Size: 0xa8
function function_8b6076077ffecca5( var_5ddea964f429e3cf )
{
    self endon( #"death" );
    n_timeout = gettime() + 15000;
    
    while ( isdefined( var_5ddea964f429e3cf ) && gettime() < n_timeout && var_5ddea964f429e3cf utility::ent_flag( "disciple_binding" ) )
    {
        var_4193955b25309ca2 = getdvarfloat( @"hash_dbcf496cc1cc3580", 20 );
        
        if ( distancesquared( self.origin, var_5ddea964f429e3cf.origin + ( 0, 0, 50 ) ) < squared( var_4193955b25309ca2 ) )
        {
            self delete();
            return;
        }
        
        waitframe();
    }
    
    self delete();
}

// Namespace namespace_d4e7a14ee55bd048
// Params 1
// Checksum 0x509a7a3c, Offset: 0xb20
// Size: 0x165
function function_bed09be6d0f32085( zombie )
{
    if ( zombie utility::ent_flag( "disciple_bound" ) )
    {
        return;
    }
    
    callback::callback( "on_ai_bound" );
    zombie ai::set_ai_max_health( int( zombie.maxhealth * 2 ) );
    zombie.health = zombie.maxhealth;
    zombie.commander = self;
    zombie clearenemy();
    zombie clearpath();
    zombie callback::add( #"on_ai_killed", &function_9b8943b8c761cbed );
    zombie utility::ent_flag_set( "disciple_bound" );
    
    if ( issubstr( self.subclass, "zombie_disciple_skoll" ) )
    {
        zombie utility::function_32b24db3127bff40( "injected", "injected_on" );
        
        if ( issubstr( zombie.subclass, "zombie_vermin" ) )
        {
            zombie utility::function_32b24db3127bff40( "eyes", "injected_on" );
        }
        
        if ( issubstr( zombie.subclass, "zombie_base" ) )
        {
            zombie utility::function_32b24db3127bff40( "base", "base_injected_eyes" );
        }
    }
    else
    {
        zombie utility::function_32b24db3127bff40( "bound", "bound_on" );
    }
    
    zombie callback::callback( "on_ai_bound" );
    zombie thread function_75c64efd74f1a891();
    self.var_10f573f354866b22[ self.var_10f573f354866b22.size ] = zombie;
    self.var_7540cca05a1c9472++;
}

// Namespace namespace_d4e7a14ee55bd048
// Params 0
// Checksum 0xa23161f8, Offset: 0xc8d
// Size: 0xd8
function function_c074e62d548a63b5()
{
    assert( isalive( self ) );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    callback::callback( "on_ai_unbound" );
    ai::set_ai_max_health( int( self.maxhealth / 2 ) );
    var_fb2f98f9e8f799fa = self.health;
    self.health = self.maxhealth;
    self.commander = undefined;
    
    if ( var_fb2f98f9e8f799fa < self.maxhealth )
    {
        self dodamage( self.maxhealth - var_fb2f98f9e8f799fa, self.origin );
    }
    
    self clearenemy();
    self clearpath();
    callback::remove( #"on_ai_killed", &function_9b8943b8c761cbed );
    utility::ent_flag_clear( "disciple_bound" );
    utility::function_32b24db3127bff40( "bound", "bound_off" );
}

// Namespace namespace_d4e7a14ee55bd048
// Params 1
// Checksum 0x6e5fdff2, Offset: 0xd6d
// Size: 0x18e
function function_9b8943b8c761cbed( params )
{
    if ( isalive( self.commander ) && isdefined( self.commander.var_10f573f354866b22 ) )
    {
        self.commander.var_10f573f354866b22 = arrayremove( self.commander.var_10f573f354866b22, self );
        
        if ( self.commander.var_10f573f354866b22.size == 0 && self.commander.var_b515e2cd975f8465 )
        {
            self.commander.var_a9e9679c0535fe1b = 0;
            self.commander playsound( "vox_ai_aether_disciple_vulnerable" );
            
            if ( isdefined( level.var_23e78374f5295e4 ) && isdefined( level.players ) )
            {
                foreach ( player in level.players )
                {
                    player [[ level.var_23e78374f5295e4 ]]( 0 );
                }
            }
        }
        
        if ( self.commander._blackboard.var_ea5eb773cb969ee1 != 1 )
        {
            self.commander utility::function_32b24db3127bff40( "bound_audio", "bound_zombie_killed" );
        }
    }
}

// Namespace namespace_d4e7a14ee55bd048
// Params 1
// Checksum 0x1d87ddba, Offset: 0xf03
// Size: 0x16f
function function_cd1baf9ffcd917cc( var_86fae3f99538b683 )
{
    if ( isdefined( self.var_63907d2aff8c28db ) )
    {
        foreach ( zombie in self.var_63907d2aff8c28db )
        {
            if ( isdefined( zombie ) )
            {
                zombie zombie_stun::function_d738299157923d28();
                zombie utility::ent_flag_clear( "disciple_binding" );
                zombie utility::function_32b24db3127bff40( "bound", "bound_off" );
            }
        }
    }
    
    if ( isdefined( self.var_10f573f354866b22 ) )
    {
        foreach ( zombie in self.var_10f573f354866b22 )
        {
            if ( isalive( zombie ) )
            {
                if ( var_86fae3f99538b683 )
                {
                    zombie kill();
                    continue;
                }
                
                zombie zombie_stun::stun_ai( 0.5 );
                zombie utility::delaythread( 0.5, &function_c074e62d548a63b5 );
            }
        }
        
        self.var_10f573f354866b22 = [];
    }
}

// Namespace namespace_d4e7a14ee55bd048
// Params 0
// Checksum 0xef534aa, Offset: 0x107a
// Size: 0x1d3
function function_766769d2750f286f()
{
    if ( !self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_8f971c2cfc3d7b4e )
    {
        return;
    }
    
    level.var_86b1a5e1af185c5d[ self getentitynumber() ] = undefined;
    
    if ( function_87343acd4de8793d() <= 0 )
    {
        return;
    }
    
    if ( !isarray( self.var_9512792ecf8ee81e ) || self.var_9512792ecf8ee81e.size == 0 )
    {
        return;
    }
    
    if ( self.var_e598aad55093504a )
    {
        return;
    }
    
    var_3c987f7ce374dbe2 = 200;
    
    foreach ( target in self.var_9512792ecf8ee81e )
    {
        if ( !isalive( target ) )
        {
            continue;
        }
        
        if ( distancesquared( self.origin, target.origin ) > squared( 1000 ) )
        {
            continue;
        }
        
        if ( zombie_disciple::function_7e89c2b6e30b1cf3( target.origin ) )
        {
            continue;
        }
        
        var_be3d7ac84b588173 = function_47c86977a18df38b( level.var_86b1a5e1af185c5d, target.origin );
        
        if ( !isdefined( var_be3d7ac84b588173 ) || distance2dsquared( var_be3d7ac84b588173.origin, target.origin ) > squared( var_be3d7ac84b588173.radius ) )
        {
            var_9d65156c1526bf0a = spawnstruct();
            var_9d65156c1526bf0a.origin = target.origin;
            var_9d65156c1526bf0a.radius = 200;
            level.var_86b1a5e1af185c5d[ self getentitynumber() ] = var_9d65156c1526bf0a;
            return target;
        }
    }
}

// Namespace namespace_d4e7a14ee55bd048
// Params 0, eflags: 0x4
// Checksum 0xa9569ff6, Offset: 0x1256
// Size: 0x13b
function private function_4f5309583e4d133f()
{
    level endon( #"game_ended" );
    
    if ( isdefined( level.var_e6db27b9375ab51f ) )
    {
        return;
    }
    
    while ( true )
    {
        level.var_e6db27b9375ab51f = [];
        potential_targets = getaispeciesarray( "all", "zombie" );
        var_75bc8205d8096ce6 = 0;
        
        foreach ( target in potential_targets )
        {
            if ( issubstr( target.subclass, "zombie_disciple" ) )
            {
                var_75bc8205d8096ce6 = 1;
                continue;
            }
            
            if ( target utility::ent_flag( "disciple_binding" ) || target utility::ent_flag( "disciple_bound" ) )
            {
                continue;
            }
            
            if ( !target getscriptablehaspart( "bound" ) )
            {
                continue;
            }
            
            level.var_e6db27b9375ab51f[ level.var_e6db27b9375ab51f.size ] = target;
        }
        
        if ( !var_75bc8205d8096ce6 )
        {
            break;
        }
        
        wait 1;
    }
    
    level.var_e6db27b9375ab51f = undefined;
}

// Namespace namespace_d4e7a14ee55bd048
// Params 0, eflags: 0x4
// Checksum 0x81a97618, Offset: 0x1399
// Size: 0x20b
function private function_7abdb1f886503db2()
{
    self endon( #"death" );
    
    if ( !isdefined( level.disciple_bind_seek_throttle ) )
    {
        level.disciple_bind_seek_throttle = throttle::throttle_initialize( "disciple_bind_seek", 1 );
    }
    
    self.var_9512792ecf8ee81e = [];
    
    while ( true )
    {
        wait 0.1;
        throttle::throttle_wait_in_queue( level.disciple_bind_seek_throttle, self );
        self.var_9512792ecf8ee81e = [];
        
        if ( function_87343acd4de8793d() <= 0 )
        {
            continue;
        }
        
        var_404b3dba71c4c3ec = 1000;
        var_404b3dba71c4c3ec -= self.var_10f573f354866b22.size * 170;
        var_404b3dba71c4c3ec = max( var_404b3dba71c4c3ec, 200 );
        var_f509b12c5fe0b987 = [];
        var_e6db27b9375ab51f = getaiarrayinradius( self.origin, var_404b3dba71c4c3ec, self.team );
        
        foreach ( var_601ddb71ec5d213 in var_e6db27b9375ab51f )
        {
            if ( !isalive( var_601ddb71ec5d213 ) )
            {
                continue;
            }
            
            if ( var_601ddb71ec5d213.aicategory == "special" || var_601ddb71ec5d213.aicategory == "elite" || var_601ddb71ec5d213.aicategory == "hvt" || var_601ddb71ec5d213.aicategory == "boss" )
            {
                continue;
            }
            
            if ( var_601ddb71ec5d213 utility::ent_flag( "disciple_binding" ) || var_601ddb71ec5d213 utility::ent_flag( "disciple_bound" ) )
            {
                continue;
            }
            
            if ( !var_601ddb71ec5d213 isscriptable() )
            {
                continue;
            }
            
            if ( !var_601ddb71ec5d213 getscriptablehaspart( "bound" ) )
            {
                continue;
            }
            
            var_f509b12c5fe0b987[ var_f509b12c5fe0b987.size ] = var_601ddb71ec5d213;
            
            if ( var_f509b12c5fe0b987.size > self.var_b71bb0b5b2399e34 * 2 )
            {
                break;
            }
        }
        
        self.var_9512792ecf8ee81e = sortbydistance( var_f509b12c5fe0b987, self.origin );
    }
}

// Namespace namespace_d4e7a14ee55bd048
// Params 0, eflags: 0x4
// Checksum 0x469c29bf, Offset: 0x15ac
// Size: 0x1c4
function private function_75c64efd74f1a891()
{
    self endon( #"death" );
    
    if ( !isdefined( level.disciple_bound_wander_throttle ) )
    {
        level.disciple_bound_wander_throttle = throttle::throttle_initialize( "disciple_bound_wander", 1 );
    }
    
    var_f1dd0db8025c683f = self._blackboard.var_dd1cb4e12c4c12d2;
    self._blackboard.var_dd1cb4e12c4c12d2 = -1;
    s_attractor_temp = { #team:"neutral", #origin:self.origin };
    
    while ( true )
    {
        wait 0.1;
        throttle::throttle_wait_in_queue( level.disciple_bound_wander_throttle, self );
        
        if ( !isdefined( self.commander ) )
        {
            break;
        }
        
        if ( isdefined( self.enemy ) )
        {
            continue;
        }
        
        if ( distancesquared( self.commander.origin, self.origin ) < 40000 )
        {
            continue;
        }
        
        s_attractor_temp.origin = getclosestpointonnavmesh( self.commander.origin );
        zombie_attractor_manager::function_7eb1aaa8bc7cc15( s_attractor_temp );
        
        while ( true )
        {
            wait 0.1;
            throttle::throttle_wait_in_queue( level.disciple_bound_wander_throttle, self );
            
            if ( !isdefined( self.commander ) )
            {
                break;
            }
            
            if ( isdefined( self.enemy ) )
            {
                break;
            }
            
            if ( distancesquared( s_attractor_temp.origin, self.origin ) < 10000 )
            {
                break;
            }
        }
        
        zombie_attractor_manager::function_dcfb4c31f1d97cd2( s_attractor_temp );
        self._blackboard.var_b213ded5043dfa2b = self.origin;
    }
    
    self._blackboard.var_dd1cb4e12c4c12d2 = var_f1dd0db8025c683f;
}

/#

    // Namespace namespace_d4e7a14ee55bd048
    // Params 0, eflags: 0x4
    // Checksum 0xb9653b30, Offset: 0x1778
    // Size: 0x5a, Type: dev
    function private function_6bac40e4542b29df()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x3e>", "<dev string:x49>", &function_90858460fed3c6a1 );
        devgui::add_devgui_func( "<dev string:x54>", "<dev string:x5f>", &toggle_debug_bind );
        devgui::add_devgui_func( "<dev string:x6a>", "<dev string:x80>", &function_6b606a9c8bcc7c14 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_d4e7a14ee55bd048
    // Params 0, eflags: 0x4
    // Checksum 0xcce0c84, Offset: 0x17da
    // Size: 0x47, Type: dev
    function private function_90858460fed3c6a1()
    {
        disciple = ai::get_ai_closest( level.players[ 0 ].origin, undefined, undefined, "<dev string:x94>" );
        
        if ( isdefined( disciple ) )
        {
            disciple function_786bb6aa1b76c7ee( "<dev string:xa4>", 1 );
        }
    }

    // Namespace namespace_d4e7a14ee55bd048
    // Params 0, eflags: 0x4
    // Checksum 0x85b65d46, Offset: 0x1829
    // Size: 0x1a, Type: dev
    function private toggle_debug_bind()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xac>", @"hash_bcd6dcf5babd2641" );
    }

    // Namespace namespace_d4e7a14ee55bd048
    // Params 0, eflags: 0x4
    // Checksum 0xe0891822, Offset: 0x184b
    // Size: 0x42, Type: dev
    function private function_6b606a9c8bcc7c14()
    {
        disciple = ai::get_ai_closest( level.players[ 0 ].origin, undefined, undefined, "<dev string:x94>" );
        
        if ( isdefined( disciple ) )
        {
            disciple function_cd1baf9ffcd917cc();
        }
    }

    // Namespace namespace_d4e7a14ee55bd048
    // Params 2, eflags: 0x4
    // Checksum 0x2ac16fd7, Offset: 0x1895
    // Size: 0x63, Type: dev
    function private debug_print_bind( text, pos )
    {
        if ( getdvarint( @"hash_bcd6dcf5babd2641", 0 ) )
        {
            if ( !isdefined( pos ) )
            {
                pos = self.origin + ( 0, 0, 70 );
            }
            
            print3d( pos, "<dev string:xc0>" + text, ( 1, 0, 0 ) );
        }
    }

#/
