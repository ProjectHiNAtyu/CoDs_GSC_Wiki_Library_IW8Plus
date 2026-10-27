// scripts\common\ai\aitypes\zombie_disciple\zombie_disciple_injection.gsc  (hash_667342288b9d34f2.gscc) (size: 6671 Bytes / 0x1a0f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x736fb710 (1936701200)
// size ...... 6671 (0x1a0f)
// includes .. 5   (offset: 0x188b)
// strings ... 18  (offset: 0x18b3)
// dev strs .. 0   (offset: 0x1a0f)
// exports ... 19  (offset: 0xecf)
// cseg ...... 0x1a9 + 0xd26 (0xecf)
// imports ... 54  (offset: 0x11c7)
// animtree1 . 0   (offset: 0x1a0f)
// animtree2 . 0   (offset: 0x1a0f)
#using scripts\common\ai\aitypes\shared\zombie\zombie_emergence_spawning;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace zombie_disciple_injection;

// Namespace zombie_disciple_injection
// Params 1
// Checksum 0x26276e9, Offset: 0x1c7
// Size: 0x54
function function_a4223c013b08ac4a( aitypescriptbundle )
{
    settings = zombie_utils::function_a225e7aa4a243fb2( aitypescriptbundle );
    
    if ( isdefined( settings ) )
    {
        utility::add_fx( "disciple_injection_fx", settings.var_4ea687b5fb6dcc6b );
        utility::add_fx( "disciple_injection_destroyed_fx", settings.var_5e8209667428f3c );
    }
}

// Namespace zombie_disciple_injection
// Params 0
// Checksum 0x578e7703, Offset: 0x223
// Size: 0x2f
function function_3a8c36860e641e85()
{
    if ( self getaiblackboarddynamic( "can_inject_zombies" ) )
    {
        callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_killed", &function_bf731e5c7eae0684 );
    }
}

// Namespace zombie_disciple_injection
// Params 0
// Checksum 0xf772d649, Offset: 0x25a
// Size: 0xb4
function init_zombie_disciple_injection()
{
    if ( self getaiblackboarddynamic( "can_inject_zombies" ) )
    {
        self.injected_zombies = [];
        self.var_e5e12423824e90f2 = [];
        self.injection_radius = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.injectionradius;
        self.var_483f00c8369de1a = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_d784ed8291c9f011 * 1000;
        self.var_4151d052dea500db = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_e36f61b9923cdf4d * 0.01;
        thread draw_vfx();
        thread function_6bcd5c1b970a527a();
        thread function_227109d03e8678f7();
    }
}

// Namespace zombie_disciple_injection
// Params 0
// Checksum 0xb990cab8, Offset: 0x316
// Size: 0x80
function draw_vfx()
{
    self endon( #"death" );
    waitframe();
    playfxontag( utility::getfx( "disciple_injection_fx" ), self, "tag_origin" );
    
    /#
        while ( true )
        {
            if ( getdvarint( @"hash_69344bf02dda50a4", -1 ) > 0 )
            {
                utility::draw_circle( self.origin + ( 0, 0, 30 ), self.injection_radius, ( 125, 216, 255 ), 0.7, 1 );
            }
            
            waitframe();
        }
    #/
}

// Namespace zombie_disciple_injection
// Params 0
// Checksum 0x293e5491, Offset: 0x39e
// Size: 0x85
function function_6bcd5c1b970a527a()
{
    self notify( #"hash_ada4ca5412177c48" );
    self endon( #"hash_ada4ca5412177c48" );
    self endon( #"death" );
    self waittill( #"hash_bbc17a460056247c" );
    self.injection_radius = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_33aeea10a3c3dd40;
    stopfxontag( utility::getfx( "disciple_injection_fx" ), self, "tag_origin" );
    playfxontag( utility::getfx( "disciple_injection_destroyed_fx" ), self, "tag_origin" );
}

// Namespace zombie_disciple_injection
// Params 0
// Checksum 0x3cf7e41f, Offset: 0x42b
// Size: 0xf6
function function_227109d03e8678f7()
{
    self notify( #"hash_8037a08e01c98235" );
    self endon( #"hash_8037a08e01c98235" );
    self endon( #"death" );
    self endon( #"injection_disabled" );
    
    while ( true )
    {
        if ( !self.b_in_spawn_closet )
        {
            injection_targets = getaiarrayinradius( self.origin, self.injection_radius, self.team );
            injection_targets = function_a0a62ccd176e0a7( injection_targets );
            
            foreach ( target in injection_targets )
            {
                inject_zombie( target );
                target thread function_6a727dcb89be0995();
            }
        }
        
        waitframe();
    }
}

// Namespace zombie_disciple_injection
// Params 1
// Checksum 0xd0fc0811, Offset: 0x529
// Size: 0xd6
function inject_zombie( target )
{
    target zombie_emergence_spawning::enable_emergence_spawning( 1 );
    target.disciple_parent = self;
    target callback::add( "on_zombie_ai_killed", &function_87d611813ccbbb48 );
    target utility::function_32b24db3127bff40( "injected", "injected_on" );
    
    if ( issubstr( target.subclass, "zombie_base" ) )
    {
        target utility::function_32b24db3127bff40( "base", "base_injected_eyes" );
    }
    
    if ( issubstr( target.subclass, "zombie_vermin" ) )
    {
        target utility::function_32b24db3127bff40( "eyes", "injected_on" );
    }
    
    if ( !arraycontains( self.injected_zombies, target ) )
    {
        self.injected_zombies[ self.injected_zombies.size ] = target;
    }
    
    target utility::ent_flag_set( "disciple_injected" );
}

// Namespace zombie_disciple_injection
// Params 0
// Checksum 0x401cff91, Offset: 0x607
// Size: 0x126
function function_f36332de3f55dc5f()
{
    self notify( #"uninjected" );
    
    if ( isarray( self.disciple_parent.injected_zombies ) )
    {
        self.disciple_parent.injected_zombies = arrayremove( self.disciple_parent.injected_zombies, self );
    }
    
    if ( isarray( self.disciple_parent.var_e5e12423824e90f2 ) )
    {
        self.disciple_parent.var_e5e12423824e90f2 = arrayremove( self.disciple_parent.var_e5e12423824e90f2, self );
    }
    
    self.disciple_parent = undefined;
    callback::remove( "on_zombie_ai_killed", &function_87d611813ccbbb48 );
    zombie_emergence_spawning::set_emergence_spawning_through_death_percentage( 0 );
    utility::function_32b24db3127bff40( "injected", "injected_off" );
    
    if ( issubstr( self.subclass, "zombie_base" ) )
    {
        utility::function_32b24db3127bff40( "base", "base_off" );
    }
    
    if ( issubstr( self.subclass, "zombie_vermin" ) )
    {
        utility::function_32b24db3127bff40( "eyes", "injected_off" );
    }
    
    utility::ent_flag_clear( "disciple_injected" );
}

// Namespace zombie_disciple_injection
// Params 0
// Checksum 0xd781befa, Offset: 0x735
// Size: 0x129
function function_6a727dcb89be0995()
{
    self endon( #"death" );
    self endon( #"uninjected" );
    
    if ( isalive( self.disciple_parent ) )
    {
        self.disciple_parent endon( #"death" );
        
        while ( distancesquared( self.origin, self.disciple_parent.origin ) < squared( self.disciple_parent.injection_radius ) )
        {
            wait 1;
        }
        
        var_86afef7038b54623 = gettime() + self.disciple_parent.var_483f00c8369de1a;
        
        while ( gettime() < var_86afef7038b54623 )
        {
            if ( !utility::ent_flag( "disciple_injected" ) )
            {
                return;
            }
            
            if ( !isdefined( self.disciple_parent ) )
            {
                break;
            }
            
            if ( !isalive( self.disciple_parent ) )
            {
                break;
            }
            
            if ( distancesquared( self.origin, self.disciple_parent.origin ) < squared( self.disciple_parent.injection_radius ) )
            {
                return;
            }
            
            waitframe();
        }
    }
    
    function_f36332de3f55dc5f();
}

// Namespace zombie_disciple_injection
// Params 1
// Checksum 0xde515b5f, Offset: 0x866
// Size: 0xee
function function_87d611813ccbbb48( params )
{
    zombie_emergence_spawning::enable_emergence_spawning( 1 );
    zombie_emergence_spawning::set_emergence_spawning_through_death_percentage( 100 );
    host_data_params = spawnstruct();
    host_data_params.disciple_parent = self.disciple_parent;
    host_data_params.var_b3e176999aae46d7 = &function_4068569709e4f66e;
    zombie_emergence_spawning::register_emergence_spawning_host_data( "disciple_parent", host_data_params );
    
    if ( isarray( self.disciple_parent.injected_zombies ) )
    {
        self.disciple_parent.injected_zombies = arrayremove( self.disciple_parent.injected_zombies, self );
    }
    
    if ( isarray( self.disciple_parent.var_e5e12423824e90f2 ) )
    {
        self.disciple_parent.var_e5e12423824e90f2 = arrayremove( self.disciple_parent.var_e5e12423824e90f2, self );
    }
}

// Namespace zombie_disciple_injection
// Params 2
// Checksum 0x243cd733, Offset: 0x95c
// Size: 0xbc
function function_4068569709e4f66e( disciple_parent, var_9ad7cc5d07653ebc )
{
    assert( isdefined( disciple_parent ) );
    
    if ( isalive( disciple_parent ) )
    {
        self.disciple_parent = disciple_parent;
        utility::function_32b24db3127bff40( "injected", "injected_on" );
        
        if ( issubstr( self.subclass, "zombie_vermin" ) )
        {
            utility::function_32b24db3127bff40( "eyes", "injected_on" );
        }
        
        if ( isarray( disciple_parent.injected_zombies ) )
        {
            arrayremove( disciple_parent.injected_zombies, self );
            
            if ( !arraycontains( disciple_parent.var_e5e12423824e90f2, self ) )
            {
                disciple_parent.var_e5e12423824e90f2[ disciple_parent.var_e5e12423824e90f2.size ] = self;
            }
        }
    }
}

// Namespace zombie_disciple_injection
// Params 1
// Checksum 0x5356ee11, Offset: 0xa20
// Size: 0x47
function function_bf731e5c7eae0684( params )
{
    self waittill( #"hash_225e213844501190" );
    function_996d90969edc4c0c();
    function_ab78ef0be5d2c258();
    utility::array_delete( self.injected_zombies );
    utility::array_delete( self.var_e5e12423824e90f2 );
}

// Namespace zombie_disciple_injection
// Params 0
// Checksum 0x7c553849, Offset: 0xa6f
// Size: 0xaf
function function_996d90969edc4c0c()
{
    if ( isarray( self.injected_zombies ) )
    {
        injected_zombies = utility::array_removedead_or_dying( self.injected_zombies );
        
        foreach ( zombie in injected_zombies )
        {
            thread cleanup_injected_zombie( zombie, self.var_4151d052dea500db, self.origin );
        }
    }
}

// Namespace zombie_disciple_injection
// Params 3
// Checksum 0x2b43ff49, Offset: 0xb26
// Size: 0x6a
function cleanup_injected_zombie( zombie, var_4151d052dea500db, damageorigin )
{
    zombie endon( #"death" );
    damage = zombie.maxhealth * var_4151d052dea500db;
    zombie dodamage( damage, damageorigin, self, self, "MOD_PROJECTILE_SPLASH", undefined );
    zombie zombie_knockdown::function_a113e6ee43535d37( damageorigin, damage );
    zombie function_f36332de3f55dc5f();
}

// Namespace zombie_disciple_injection
// Params 0
// Checksum 0x2040ac81, Offset: 0xb98
// Size: 0x9c
function function_ab78ef0be5d2c258()
{
    if ( isarray( self.var_e5e12423824e90f2 ) )
    {
        var_e5e12423824e90f2 = utility::array_removedead_or_dying( self.var_e5e12423824e90f2 );
        
        foreach ( zombie in var_e5e12423824e90f2 )
        {
            zombie kill();
            waitframe();
        }
    }
}

// Namespace zombie_disciple_injection
// Params 1
// Checksum 0xffea88ac, Offset: 0xc3c
// Size: 0xf2
function function_a0a62ccd176e0a7( target_array )
{
    targets = [];
    
    foreach ( candidate in target_array )
    {
        if ( !isalive( candidate ) )
        {
            continue;
        }
        
        if ( candidate == self )
        {
            continue;
        }
        
        if ( !candidate utility::ent_flag( "zombie_asm_init_finished" ) )
        {
            continue;
        }
        
        if ( candidate.b_in_spawn_closet )
        {
            continue;
        }
        
        if ( isdefined( candidate.disciple_parent ) )
        {
            continue;
        }
        
        if ( !issubstr( candidate.subclass, "zombie_base" ) )
        {
            continue;
        }
        
        targets[ targets.size ] = candidate;
    }
    
    return targets;
}

// Namespace zombie_disciple_injection
// Params 0
// Checksum 0xcbc95fbf, Offset: 0xd37
// Size: 0x11a
function function_2e8bd1df33064119()
{
    self endon( #"death" );
    self function_786bb6aa1b76c7ee( "can_inject_zombies", 0 );
    
    if ( self.injection_radius == self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_33aeea10a3c3dd40 )
    {
        stopfxontag( utility::getfx( "disciple_injection_destroyed_fx" ), self, "tag_origin" );
    }
    else
    {
        stopfxontag( utility::getfx( "disciple_injection_fx" ), self, "tag_origin" );
    }
    
    if ( isarray( self.injected_zombies ) )
    {
        injected_zombies = utility::array_removedead_or_dying( self.injected_zombies );
        
        foreach ( zombie in injected_zombies )
        {
            zombie thread function_f36332de3f55dc5f();
        }
    }
    
    self notify( #"injection_disabled" );
}

// Namespace zombie_disciple_injection
// Params 0
// Checksum 0x4e6a1431, Offset: 0xe59
// Size: 0x76
function function_ea90a13538922afa()
{
    if ( self.injection_radius == self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_33aeea10a3c3dd40 )
    {
        playfxontag( utility::getfx( "disciple_injection_destroyed_fx" ), self, "tag_origin" );
    }
    else
    {
        playfxontag( utility::getfx( "disciple_injection_fx" ), self, "tag_origin" );
        thread function_6bcd5c1b970a527a();
    }
    
    self function_786bb6aa1b76c7ee( "can_inject_zombies", 1 );
    thread function_227109d03e8678f7();
}

