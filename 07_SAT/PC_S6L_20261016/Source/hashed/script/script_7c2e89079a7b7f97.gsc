// script_7c2e89079a7b7f97  (hash_7c2e89079a7b7f97.gscc) (size: 8433 Bytes / 0x20f1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe3a7989e (3819411614)
// size ...... 8433 (0x20f1)
// includes .. 8   (offset: 0x1f4d)
// strings ... 25  (offset: 0x1f8d)
// dev strs .. 4   (offset: 0x20c1)
// exports ... 21  (offset: 0x1469)
// cseg ...... 0x1df + 0x128a (0x1469)
// imports ... 66  (offset: 0x17b1)
// animtree1 . 0   (offset: 0x20f1)
// animtree2 . 0   (offset: 0x20f1)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_damage;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\metabone;
#using scripts\common\utility;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\mp_agent_damage;

#namespace zombie_callisto_zombeehive;

// Namespace zombie_callisto_zombeehive
// Params 0
// Checksum 0x2bb2b56c, Offset: 0x1fd
// Size: 0x42
function function_8086ecde4f36a364()
{
    /#
        setup_zombees_devgui();
    #/
    
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_killed", &function_291175cbb5dc9a90 );
    level callback::add( #"on_molotov_impact", &on_molotov_impact );
}

// Namespace zombie_callisto_zombeehive
// Params 0
// Checksum 0x10014b79, Offset: 0x247
// Size: 0x167
function function_f79343a86c2508da()
{
    self.var_9034be615b59cf0f = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.zombeehivemodel;
    self.var_ba9b76291bd8aa93 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_89033a4e3168054b;
    self.zombeehive_damage_range = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_3e3cf9dc32878ed4;
    self.zombeehive_duration = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.zombeehiveduration;
    self.zombeehive_health_percentage = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_14ab5858b1531cb8 / 100;
    self.zombeehive_health_max = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_5384706a1e22f20e;
    self.var_a97d624fa9340047 = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.zombeehiveactivationdelay;
    self.var_c2c4733342e35fa9 = 3;
    self.var_5b93bea6034ba5cb = [ "tag_head_weakpoint", "tag_shoulder_weakpoint", "tag_spine_weakpoint" ];
    self.var_94de0b446b2f3e6f = [ "hive_head", "hive_shoulder", "hive_stomach" ];
}

// Namespace zombie_callisto_zombeehive
// Params 0
// Checksum 0xc1fd30a9, Offset: 0x3b6
// Size: 0xa2
function function_87b27756a8931417()
{
    foreach ( part in self.var_94de0b446b2f3e6f )
    {
        if ( metabone::get_metabone_state_name( part ) != "destroyed" )
        {
            utility::function_32b24db3127bff40( part, "attached" );
            continue;
        }
        
        utility::function_32b24db3127bff40( part, "destroyed" );
    }
}

// Namespace zombie_callisto_zombeehive
// Params 0
// Checksum 0x1803d3f1, Offset: 0x460
// Size: 0x80
function function_dabab364c6f054aa()
{
    foreach ( part in self.var_94de0b446b2f3e6f )
    {
        utility::function_32b24db3127bff40( part, "off" );
    }
}

// Namespace zombie_callisto_zombeehive
// Params 1
// Checksum 0x2cc88309, Offset: 0x4e8
// Size: 0x16f
function spawn_zombeehive( bone_tag )
{
    assert( isdefined( self.var_9034be615b59cf0f ) );
    assert( isdefined( bone_tag ) );
    start_position = self gettagorigin( bone_tag );
    hive = spawn( "script_model", start_position );
    hive setmodel( self.var_9034be615b59cf0f );
    hive.owner = self;
    hive.team = self.team;
    hive.tag = bone_tag;
    hive.var_d62ad5bfd64ba592 = "tag_origin";
    damage_utility::register_damageable_entity( hive, hive.team );
    
    if ( !isdefined( self.var_5ee266bc636192c ) )
    {
        self.var_5ee266bc636192c = [];
    }
    
    self.var_5ee266bc636192c[ bone_tag ] = hive;
    self.var_5b93bea6034ba5cb = arrayremove( self.var_5b93bea6034ba5cb, bone_tag );
    self.var_c2c4733342e35fa9--;
    
    if ( self.var_c2c4733342e35fa9 <= 0 )
    {
        self function_786bb6aa1b76c7ee( "zombeesattack_canattack", 0 );
    }
    
    health = min( self.maxhealth * self.zombeehive_health_percentage, self.zombeehive_health_max );
    hive thread drop_hive( self.var_ba9b76291bd8aa93, self.zombeehive_damage_range, health, self.zombeehive_duration, self.var_a97d624fa9340047 );
}

// Namespace zombie_callisto_zombeehive
// Params 0
// Checksum 0xc8e67498, Offset: 0x65f
// Size: 0x37
function function_c1e4372f46de0584()
{
    if ( self.var_c2c4733342e35fa9 <= 0 )
    {
        return;
    }
    
    index = randomintrange( 0, self.var_c2c4733342e35fa9 );
    return self.var_5b93bea6034ba5cb[ index ];
}

// Namespace zombie_callisto_zombeehive
// Params 5, eflags: 0x4
// Checksum 0xe75ac6e3, Offset: 0x69f
// Size: 0x1ad
function private drop_hive( var_38dad64a4a4916b4, var_f1ec09d80b804ab1, health, duration, activation_delay )
{
    self.owner endon( #"death" );
    self endon( #"death" );
    start_pos = self.origin;
    var_1da34d6eb2f7801f = 225;
    max_dist = 75;
    min_dist = 50;
    var_80cbf954897ba52a = -30;
    max_angle = 30;
    end_pos = function_1ca04135f0fb5fe2( start_pos, start_pos - self.owner.origin, min_dist, max_dist, var_80cbf954897ba52a, max_angle );
    end_pos = utility::drop_to_ground( end_pos, 0 );
    acceleration = -1 * self.owner function_88d2c65d5eed0e87();
    time = function_c5fccb058e4b5f2e( start_pos[ 2 ] - end_pos[ 2 ], var_1da34d6eb2f7801f, acceleration );
    initialv = ( end_pos[ 0 ] - start_pos[ 0 ], end_pos[ 1 ] - start_pos[ 1 ], 0 );
    initialv *= 1 / time;
    initialv += ( 0, 0, var_1da34d6eb2f7801f );
    childthread function_e94d1137ccb486da( initialv, ( 0, 0, acceleration ), time, end_pos );
    thread function_bb292e397079dfc3();
    wait time;
    self setcandamage( 1 );
    self.health = int( health );
    self.var_3343534bd4a927d8 = 1;
    thread function_574927fa0258d6b4();
    thread function_5e95ded5eb7db74a( duration );
    wait activation_delay;
    self setscriptablepartstate( "hive", "active" );
    thread function_91832b36c740563( var_f1ec09d80b804ab1, var_38dad64a4a4916b4 );
}

// Namespace zombie_callisto_zombeehive
// Params 4, eflags: 0xc
// Checksum 0x867088dd, Offset: 0x854
// Size: 0xf5
function private function_e94d1137ccb486da( initialv, acceleration, duration, end_pos )
{
    self notify( #"hash_e20fe4eaee60519" );
    self endon( #"hash_e20fe4eaee60519" );
    current_pos = self.origin;
    current_vel = initialv;
    elapsed_time = 0;
    timestep = 0.1;
    duration -= timestep;
    var_402653d154a75a2 = ( randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ) );
    var_402653d154a75a2 = vectornormalize( var_402653d154a75a2 );
    var_402653d154a75a2 *= 50 * duration / timestep;
    self rotateby( var_402653d154a75a2, duration );
    
    while ( elapsed_time < duration )
    {
        current_pos += current_vel * timestep;
        current_vel += acceleration * timestep;
        self moveto( current_pos, timestep );
        elapsed_time += timestep;
        wait timestep;
    }
    
    self moveto( end_pos, timestep );
}

// Namespace zombie_callisto_zombeehive
// Params 6, eflags: 0x4
// Checksum 0x41f544bd, Offset: 0x951
// Size: 0x94
function private function_1ca04135f0fb5fe2( initpos, forward, mindist, maxdist, var_93decdf767e26ae2, var_93bbb7f767bbf2c8 )
{
    theta = randomfloatrange( var_93decdf767e26ae2, var_93bbb7f767bbf2c8 );
    dir = rotatevector( ( forward[ 0 ], forward[ 1 ], 0 ), ( 0, theta, 0 ) );
    dir = vectornormalize( dir );
    dist = randomfloatrange( mindist, maxdist );
    end_pos = dir * dist + initpos;
    return end_pos;
}

// Namespace zombie_callisto_zombeehive
// Params 3, eflags: 0x4
// Checksum 0x1c7f979, Offset: 0x9ee
// Size: 0xf6
function private function_c5fccb058e4b5f2e( dist, initialvelocity, acceleration )
{
    a = acceleration * 0.5;
    b = initialvelocity;
    c = dist;
    time = 1;
    var_e08ff8590d9165e = b * b - 4 * a * c;
    
    if ( var_e08ff8590d9165e >= 0 && a > 0 )
    {
        time_minus = ( b * -1 - sqrt( var_e08ff8590d9165e ) ) / 2 * a;
        time_plus = ( b * -1 + sqrt( var_e08ff8590d9165e ) ) / 2 * a;
        
        if ( time_minus > 0 && time_plus > 0 )
        {
            if ( time_minus < time_plus )
            {
                time = time_minus;
            }
            else
            {
                time = time_plus;
            }
        }
        else if ( time_minus > 0 )
        {
            time = time_minus;
        }
        else if ( time_plus > 0 )
        {
            time = time_plus;
        }
    }
    
    return time;
}

// Namespace zombie_callisto_zombeehive
// Params 0, eflags: 0x4
// Checksum 0xd52d929e, Offset: 0xaed
// Size: 0x1e2
function private function_574927fa0258d6b4()
{
    self endon( #"death" );
    self.owner endon( #"death" );
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        
        if ( !isdefined( objweapon ) )
        {
            objweapon = level.weaponnone;
        }
        
        element = zombie_damage::get_element( objweapon, attacker, meansofdeath );
        dmgstruct = zombie_damage::build_damage_struct( inflictor, attacker, damage, idflags, meansofdeath, objweapon, point, direction_vec, undefined, undefined, undefined, undefined, objweapon );
        dmgstruct.idamage = zombie_damage::function_881dfa87252ee0ea( dmgstruct );
        damage = zombie_damage::function_cef159ba09a96f98( dmgstruct );
        
        if ( element == "fire" )
        {
            damage = int( damage * 1.5 );
        }
        
        self.health -= int( damage );
        var_c57ed7c52106c0f3 = 0;
        
        if ( self.health <= 0 )
        {
            var_c57ed7c52106c0f3 = 1;
        }
        
        if ( isplayer( attacker ) )
        {
            attacker namespace_9d8e359c3b1041e5::updatehitmarker_sharedfunc( "standard", var_c57ed7c52106c0f3 );
            
            if ( mp_agent_damage::function_e7d118eb7b017fa4() )
            {
                namespace_9d8e359c3b1041e5::displaydamagenumber_sharedfunc( attacker, self, "none", meansofdeath, objweapon, int( damage ), self.origin, 0, element, 0, 0 );
            }
        }
        
        playfx( utility::getfx( "callisto_armored_impact_fx" ), point );
        
        if ( var_c57ed7c52106c0f3 )
        {
            self notify( #"death" );
        }
    }
}

// Namespace zombie_callisto_zombeehive
// Params 1, eflags: 0x4
// Checksum 0xf959f01, Offset: 0xcd7
// Size: 0x3b
function private function_5e95ded5eb7db74a( duration )
{
    self endon( #"death" );
    self.owner endon( #"death" );
    wait duration;
    self notify( #"death" );
}

// Namespace zombie_callisto_zombeehive
// Params 0, eflags: 0x4
// Checksum 0x13f9fdae, Offset: 0xd1a
// Size: 0x75
function private function_bb292e397079dfc3()
{
    self waittill( #"death" );
    self setscriptablepartstate( "hive", "dead" );
    
    if ( isdefined( self.owner.var_5ee266bc636192c[ self.tag ] ) )
    {
        self.owner.var_5ee266bc636192c[ self.tag ] = undefined;
    }
    
    damage_utility::function_b84e11c8ca9801fe( self, self.team );
    waitframe();
    self delete();
}

// Namespace zombie_callisto_zombeehive
// Params 1, eflags: 0x4
// Checksum 0x9e7d6014, Offset: 0xd97
// Size: 0x89
function private function_291175cbb5dc9a90( params )
{
    foreach ( hive in self.var_5ee266bc636192c )
    {
        hive notify( #"death" );
    }
}

// Namespace zombie_callisto_zombeehive
// Params 1, eflags: 0x4
// Checksum 0x8988c3ba, Offset: 0xe28
// Size: 0x24d
function private on_molotov_impact( params )
{
    all_ai = getaispeciesarray( "all", "zombie" );
    radius = 40;
    
    if ( params.bundle.coredata.triggerradius && params.bundle.tendrildata.triggerradius )
    {
        radius = params.bundle.coredata.triggerradius + params.bundle.tendrildata.triggerradius + 8;
    }
    
    radiussqrd = radius * radius;
    
    foreach ( ai in all_ai )
    {
        if ( ai.subclass != "zombie_callisto" )
        {
            continue;
        }
        
        foreach ( hive in ai.var_5ee266bc636192c )
        {
            if ( distancesquared( params.grenade.origin, hive.origin ) <= radiussqrd )
            {
                if ( utility::issharedfuncdefined( #"molotov", #"hash_42699d8a779042f6" ) )
                {
                    hive thread [[ utility::getsharedfunc( #"molotov", #"hash_42699d8a779042f6" ) ]]( params.bundle.var_f81d0343e92b24c6 ?? 6, self, params.grenade, params.grenade );
                }
            }
        }
    }
}

// Namespace zombie_callisto_zombeehive
// Params 2, eflags: 0x4
// Checksum 0x68f3f8a1, Offset: 0x107d
// Size: 0x128
function private function_91832b36c740563( var_f1ec09d80b804ab1, var_38dad64a4a4916b4 )
{
    self endon( #"death" );
    
    while ( true )
    {
        wait 1;
        potential_targets = getplayersandaiarrayinradius( self.origin, var_f1ec09d80b804ab1 );
        
        /#
            if ( getdvarint( @"hash_7ef88fa841162238", 0 ) > 0 )
            {
                sphere( self.origin, var_f1ec09d80b804ab1, ( 255, 0, 0 ), 0, 30 );
            }
        #/
        
        foreach ( target in potential_targets )
        {
            if ( target.team != self.team && !isdefined( target.var_742c28a60b0d140d ) && isdefined( var_38dad64a4a4916b4 ) && var_38dad64a4a4916b4.size > 0 )
            {
                thread function_3060c43c7e7b4133( target, var_f1ec09d80b804ab1, var_38dad64a4a4916b4 );
            }
        }
    }
}

// Namespace zombie_callisto_zombeehive
// Params 3, eflags: 0x4
// Checksum 0x58eabc72, Offset: 0x11ad
// Size: 0x220
function private function_3060c43c7e7b4133( target, var_f1ec09d80b804ab1, var_38dad64a4a4916b4 )
{
    self endon( #"death" );
    target endon( #"death_or_disconnect" );
    damage_interval = 1;
    var_bba5db50e1875a1 = var_f1ec09d80b804ab1 * var_f1ec09d80b804ab1;
    target.var_742c28a60b0d140d = 1;
    target.var_4474fdcc11ad12d7 = gettime();
    target thread function_88ae78b65d26254( self );
    
    while ( distancesquared( self.origin, target.origin ) < var_bba5db50e1875a1 )
    {
        var_76bc92bf76b72731 = utility::function_6f5d2e1f1ff70482( gettime() - target.var_4474fdcc11ad12d7 );
        highest_struct = undefined;
        
        foreach ( struct in var_38dad64a4a4916b4 )
        {
            if ( !isdefined( struct.var_a95ee436898b4a2f ) )
            {
                struct.var_a95ee436898b4a2f = 0;
            }
            
            if ( !isdefined( highest_struct ) || highest_struct.var_a95ee436898b4a2f < var_76bc92bf76b72731 && struct.var_a95ee436898b4a2f > highest_struct.var_a95ee436898b4a2f )
            {
                highest_struct = struct;
            }
        }
        
        damage = int( highest_struct.damagetick );
        damage_interval = highest_struct.damageinterval;
        
        if ( isdefined( self.owner ) && isdefined( target ) && isdefined( damage ) )
        {
            target dodamage( damage, self.origin, self.owner, self, "MOD_PROJECTILE", "<explicitweaponnone>" );
            
            if ( isplayer( target ) )
            {
                target playsoundtoplayer( #"hash_cd2a97ee53f603ef", target );
            }
        }
        
        wait damage_interval ?? 1;
    }
    
    target notify( #"hash_bf6a9beec7c8d59b" );
    target.var_742c28a60b0d140d = undefined;
}

// Namespace zombie_callisto_zombeehive
// Params 1, eflags: 0x4
// Checksum 0x252ef76d, Offset: 0x13d5
// Size: 0x3c
function private function_88ae78b65d26254( hive )
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_bf6a9beec7c8d59b" );
    hive waittill( #"death" );
    self.var_742c28a60b0d140d = undefined;
}

/#

    // Namespace zombie_callisto_zombeehive
    // Params 0
    // Checksum 0x7b85bced, Offset: 0x1419
    // Size: 0x2e, Type: dev
    function setup_zombees_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x3e>", "<dev string:x4d>", &function_2cc32cd6e2f13057 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_callisto_zombeehive
    // Params 0, eflags: 0x4
    // Checksum 0x9ab45f01, Offset: 0x144f
    // Size: 0x1a, Type: dev
    function private function_2cc32cd6e2f13057()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x5e>", @"hash_7ef88fa841162238" );
    }

#/
