// script_2913428424697f6c  (hash_2913428424697f6c.gscc) (size: 6379 Bytes / 0x18eb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbbb31540 (3149075776)
// size ...... 6379 (0x18eb)
// includes .. 7   (offset: 0x182f)
// strings ... 10  (offset: 0x1867)
// dev strs .. 0   (offset: 0x18eb)
// exports ... 22  (offset: 0xe83)
// cseg ...... 0x154 + 0xd2f (0xe83)
// imports ... 52  (offset: 0x11f3)
// animtree1 . 0   (offset: 0x18eb)
// animtree2 . 0   (offset: 0x18eb)
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\loot\common_item;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace namespace_4e36c859ad6a5d59;

// Namespace namespace_4e36c859ad6a5d59
// Params 0, eflags: 0x5
// Checksum 0xca162c7, Offset: 0x172
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_967d3f854aebc3ea", #"ztron_item", undefined, &init );
}

// Namespace namespace_4e36c859ad6a5d59
// Params 0
// Checksum 0x879d07bb, Offset: 0x19b
// Size: 0x143
function init()
{
    ztron_item::function_5844a9c240f7dc8d( #"egg", #"postspawnitem", &egg_spawn );
    ztron_item::function_5844a9c240f7dc8d( #"golden_egg", #"postspawnitem", &golden_egg_spawn );
    ztron_item::function_5844a9c240f7dc8d( #"big_egg", #"postspawnitem", &big_egg_spawn );
    ztron_item::function_5844a9c240f7dc8d( #"egg", #"canautouse", &function_c76acc85010f00dc );
    ztron_item::function_5844a9c240f7dc8d( #"golden_egg", #"canautouse", &function_c76acc85010f00dc );
    ztron_item::function_5844a9c240f7dc8d( #"big_egg", #"canautouse", &function_c76acc85010f00dc );
    ztron_item::function_5844a9c240f7dc8d( #"egg", #"hash_3836c356bfe5bc30", &function_3329baeeb894491b );
    ztron_item::function_5844a9c240f7dc8d( #"golden_egg", #"hash_3836c356bfe5bc30", &function_3329baeeb894491b );
    ztron_item::function_5844a9c240f7dc8d( #"big_egg", #"hash_3836c356bfe5bc30", &function_3329baeeb894491b );
    utility::add_fx( "ztron_egg_hatching_fireworks", "vfx_sat_zm_hatching_fireworks_ztron" );
    ztron_sound::function_4ac735395b173fe( "ztron_pickup_egg_hatch_OS", "evt_ztron_egg_hatch" );
    ztron_sound::function_4ac735395b173fe( "ztron_pickup_egg_died_OS", "evt_ztron_egg_death" );
}

// Namespace namespace_4e36c859ad6a5d59
// Params 1, eflags: 0x4
// Checksum 0x2376c9a5, Offset: 0x2e6
// Size: 0x2c
function private function_3329baeeb894491b( params )
{
    params.modelspinning = 0;
    params.availablezoffset = 20;
    return params;
}

// Namespace namespace_4e36c859ad6a5d59
// Params 1, eflags: 0x4
// Checksum 0xeedf721a, Offset: 0x31b
// Size: 0xd, Type: bool
function private function_c76acc85010f00dc( params )
{
    return false;
}

// Namespace namespace_4e36c859ad6a5d59
// Params 2, eflags: 0x4
// Checksum 0x17674442, Offset: 0x331
// Size: 0x172
function private function_147225f2560e00a4( item, params )
{
    egg = item;
    egg.team = level.players[ 0 ].team;
    egg solid();
    egg setcandamage( 1 );
    
    if ( isdefined( egg.team ) )
    {
        egg makeentitysentient( egg.team );
    }
    
    egg.isegg = 1;
    egg.health = 200;
    egg.curhealth = egg.health;
    egg.maxhealth = egg.health;
    egg.attracted_zombies = [];
    egg.hatchmanually = params.hatchmanually;
    egg.disablelaunch = params.disablelaunch;
    egg.takedamage = 1;
    egg.collide_with_ai = 1;
    radius = params.var_8112c2cb42fc763c ?? 256;
    egg.attractor = zombie_attractor_manager::add_attractor( egg, 0, radius, 1, &function_c8c3aa5f3586e574, &function_f7dd6a51b272751f, 0, undefined, 1 );
    egg.attractor.egg = egg;
    return egg;
}

// Namespace namespace_4e36c859ad6a5d59
// Params 2, eflags: 0x4
// Checksum 0x2f11440b, Offset: 0x4ac
// Size: 0x61
function private function_c8c3aa5f3586e574( attractor, zombie )
{
    dir = vectornormalize( attractor.source.origin - zombie.origin );
    return attractor.source.origin - 24 * dir;
}

// Namespace namespace_4e36c859ad6a5d59
// Params 2, eflags: 0x4
// Checksum 0xf35d2d9b, Offset: 0x516
// Size: 0xcd
function private function_f7dd6a51b272751f( attractor, zombie )
{
    count = 0;
    
    foreach ( guy in level.ztron.zombies )
    {
        if ( guy.target_attractor == attractor )
        {
            count++;
        }
    }
    
    if ( count > 5 )
    {
        return 0;
    }
    
    return zombie.ztron.var_ae555ddb6e30a0b0;
}

// Namespace namespace_4e36c859ad6a5d59
// Params 2, eflags: 0x4
// Checksum 0xc7a6dbe1, Offset: 0x5ec
// Size: 0x9e
function private big_egg_spawn( item, params )
{
    egg = function_147225f2560e00a4( item, params );
    egg.health += 1250;
    egg.curhealth = egg.health;
    egg.maxhealth = egg.health;
    egg.var_cfbd36844d0bb17d = 1;
    egg.hatchtime = randomfloatrange( 20, 30 );
    egg thread eggthink();
}

// Namespace namespace_4e36c859ad6a5d59
// Params 2, eflags: 0x4
// Checksum 0xde46fbe3, Offset: 0x692
// Size: 0xab
function private golden_egg_spawn( item, params )
{
    egg = function_147225f2560e00a4( item, params );
    egg.isegg = 1;
    egg.health += 250;
    egg.curhealth = egg.health;
    egg.maxhealth = egg.health;
    egg.golden = 1;
    egg.hatchtime = randomfloatrange( 20, 30 );
    egg thread eggthink();
}

// Namespace namespace_4e36c859ad6a5d59
// Params 2, eflags: 0x4
// Checksum 0xfdb29c6f, Offset: 0x745
// Size: 0x55
function private egg_spawn( item, params )
{
    egg = function_147225f2560e00a4( item, params );
    egg.isegg = 1;
    egg.hatchtime = randomfloatrange( 15, 25 );
    egg thread eggthink();
}

// Namespace namespace_4e36c859ad6a5d59
// Params 2, eflags: 0x4
// Checksum 0xab17c791, Offset: 0x7a2
// Size: 0x4e
function private egg_hop( var_8a0fa0c0747220c5, strength = 50 )
{
    if ( var_8a0fa0c0747220c5 )
    {
        dir = ( randomfloatrange( -40, 40 ), randomfloatrange( -40, 40 ), strength * 3 );
        egg_launch( dir );
    }
}

// Namespace namespace_4e36c859ad6a5d59
// Params 0, eflags: 0xc
// Checksum 0xbdd0eb0c, Offset: 0x7f8
// Size: 0xab
function private function_cdc54ed30341c4a()
{
    self notify( #"hash_eebd5ee5f5ee21b8" );
    self endon( #"hash_eebd5ee5f5ee21b8" );
    self endon( #"explode", #"item_cleared" );
    
    for ( i = 0; i < 40 ; i++ )
    {
        if ( !isdefined( self ) )
        {
            break;
        }
        
        egg_hop( !( i % 3 ), i * 4 + 20 );
        
        if ( i < 5 )
        {
            wait randomfloatrange( 0.5, 1.25 );
            continue;
        }
        
        if ( i < 8 )
        {
            wait randomfloatrange( 0.25, 0.75 );
            continue;
        }
        
        wait randomfloatrange( 0.25, 0.5 );
    }
}

// Namespace namespace_4e36c859ad6a5d59
// Params 1, eflags: 0x4
// Checksum 0x3f423c0f, Offset: 0x8ab
// Size: 0x1d
function private egg_launch( dir )
{
    self physicslaunchserver( self.origin, dir );
}

// Namespace namespace_4e36c859ad6a5d59
// Params 1, eflags: 0x4
// Checksum 0x84e9ff13, Offset: 0x8d0
// Size: 0x2b
function private function_fe11ae11573452c( timesec )
{
    self endon( #"explode", #"item_cleared" );
    wait timesec;
    thread function_cdc54ed30341c4a();
}

// Namespace namespace_4e36c859ad6a5d59
// Params 0, eflags: 0xc
// Checksum 0xc87a7c62, Offset: 0x903
// Size: 0x78
function private eggthink()
{
    self notify( #"hash_ce1f6527b08d694f" );
    self endon( #"hash_ce1f6527b08d694f" );
    self endon( #"item_cleared" );
    wait 0.1;
    
    if ( !self.disablelaunch )
    {
        egg_launch( ( 0, 0, 5 ) );
    }
    
    thread function_b37d0f13e3503339();
    thread function_4d9ba37c011360b5();
    
    if ( !self.hatchmanually )
    {
        thread function_11b925d295f56c6( self.hatchtime );
    }
}

// Namespace namespace_4e36c859ad6a5d59
// Params 1
// Checksum 0x64190e66, Offset: 0x983
// Size: 0x270
function function_11b925d295f56c6( hatchtime )
{
    self endon( #"explode", #"item_cleared" );
    thread function_fe11ae11573452c( hatchtime - 9 );
    hatchat = gettime() + hatchtime * 1000;
    var_36f1c7eedaf9ffeb = self.origin;
    
    while ( hatchat > gettime() )
    {
        if ( isdefined( self ) )
        {
            var_36f1c7eedaf9ffeb = self.origin;
        }
        
        wait 0.1;
    }
    
    origin = ztron_util::function_3fe38741460a4a49( var_36f1c7eedaf9ffeb, 10 ) + ( 0, 0, 12 );
    
    if ( utility::issharedfuncdefined( #"egg", #"spawnprize" ) )
    {
        utility::callsharedfunc( #"egg", #"spawnprize", origin );
    }
    else
    {
        if ( isdefined( self.var_ab11c629789b279a ) )
        {
            var_ab11c629789b279a = self.var_ab11c629789b279a;
        }
        else if ( self.golden )
        {
            var_ab11c629789b279a = ztron_item::function_71e133b37011bee6( "ztron_extra_life" );
        }
        else if ( self.var_cfbd36844d0bb17d )
        {
            var_ab11c629789b279a = %"hash_15f9ca363930826e";
        }
        else
        {
            spawnlist = utility::callsharedfunc( #"egg", #"getspawnlist" );
            
            if ( isdefined( spawnlist ) )
            {
                var_ab11c629789b279a = common_item::items_selectfromlist( spawnlist, 1 )[ 0 ];
            }
            else
            {
                var_ab11c629789b279a = ztron_item::function_f3613b119900d057( #"egg" );
            }
        }
        
        params = spawnstruct();
        params.launchforce = ( randomintrange( -10, 10 ), randomintrange( -10, 10 ), 500 );
        
        if ( level.ztron.var_291105dfc6b5a9b8 == 3 || var_ab11c629789b279a == %"hash_15f9ca363930826e" )
        {
            params.overridelifetime = 9999;
        }
        
        ztron_item::requestspawnitem( var_ab11c629789b279a, origin, undefined, undefined, params );
    }
    
    ztron_sound::ztron_playsound( "ztron_pickup_egg_hatch_OS", origin );
    
    if ( gettime() < level.ztron.var_29c73ec85b0cb9c6 )
    {
        spawnoptions = ztron_item::function_41854e96b8bf4a06( origin + ( 0, 0, 28 ) );
        ztron_item::function_d3d82aa8c393b166( origin, randomint( 8 ) + 1, 60, spawnoptions );
    }
    
    playfx( utility::getfx( "ztron_egg_hatching_fireworks" ), origin );
    self notify( #"hatched" );
    ztron_egg_delete();
}

// Namespace namespace_4e36c859ad6a5d59
// Params 0, eflags: 0xc
// Checksum 0x56df2513, Offset: 0xbfb
// Size: 0x5b
function private function_4d9ba37c011360b5()
{
    self notify( #"hash_4179f3efc8af5a53" );
    self endon( #"hash_4179f3efc8af5a53" );
    self endon( #"item_cleared" );
    
    while ( true )
    {
        level waittill( #"nuke_detonation", param );
        egg_launch( ( 0, 0, 200 ) );
    }
}

// Namespace namespace_4e36c859ad6a5d59
// Params 0, eflags: 0xc
// Checksum 0xaa81279b, Offset: 0xc5e
// Size: 0x1a4
function private function_b37d0f13e3503339()
{
    self notify( #"hash_2468c496bc684b71" );
    self endon( #"hash_2468c496bc684b71" );
    self endon( #"hatched" );
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, vpoint );
        
        if ( isdefined( attacker.team ) && attacker.team != "team_two_hundred" )
        {
            self.health += damage;
            
            if ( self.health > self.maxhealth )
            {
                self.health = self.maxhealth;
            }
        }
        else
        {
            self.curhealth -= damage;
        }
        
        dolaunch = 1;
        
        if ( isdefined( attacker ) && attacker isegg() )
        {
            dolaunch = 0;
        }
        
        if ( dolaunch )
        {
            dir = vectornormalize( ( direction_vec[ 0 ], direction_vec[ 1 ], 0 ) );
            dir = dir * 70 + ( 0, 0, 100 );
            egg_launch( dir );
        }
        
        if ( self.curhealth < 0 )
        {
            self notify( #"explode" );
            playfx( utility::getfx( "ztron_egg_explode" ), self.origin );
            ztron_sound::ztron_playsound( "ztron_pickup_egg_died_OS", self.origin );
            radiusdamage( self.origin, 72, 2000, 1000, self, "MOD_EXPLOSIVE" );
            ztron_egg_delete();
        }
    }
}

// Namespace namespace_4e36c859ad6a5d59
// Params 0
// Checksum 0x363b7966, Offset: 0xe0a
// Size: 0x1b
function ztron_egg_delete()
{
    profilestart();
    zombie_attractor_manager::remove_attractor( self.attractor );
    thread function_e7bbe21000471cba();
    profilestop();
}

// Namespace namespace_4e36c859ad6a5d59
// Params 0
// Checksum 0x22b8c14d, Offset: 0xe2d
// Size: 0x18, Type: bool
function isegg()
{
    return self.var_cfbd36844d0bb17d || self.isegg;
}

// Namespace namespace_4e36c859ad6a5d59
// Params 1, eflags: 0x4
// Checksum 0x29f79094, Offset: 0xe4e
// Size: 0x35
function private function_e7bbe21000471cba( time = 0.1 )
{
    if ( time < 0.1 )
    {
        time = 0.1;
    }
    
    wait time;
    thread ztron_item::clearitem( self );
}

