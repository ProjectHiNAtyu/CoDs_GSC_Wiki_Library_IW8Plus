// script_4fb7a9021a570c8a  (hash_4fb7a9021a570c8a.gscc) (size: 12084 Bytes / 0x2f34 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb3700065 (3010461797)
// size ...... 12084 (0x2f34)
// includes .. 6   (offset: 0x2c5c)
// strings ... 12  (offset: 0x2c8c)
// dev strs .. 39  (offset: 0x2d4c)
// exports ... 35  (offset: 0x1cac)
// cseg ...... 0x15f + 0x1b4d (0x1cac)
// imports ... 80  (offset: 0x2224)
// animtree1 . 0   (offset: 0x2f34)
// animtree2 . 0   (offset: 0x2f34)
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\trace;
#using scripts\common\utility;

#namespace zombie_diana_targeting;

// Namespace zombie_diana_targeting
// Params 0
// Checksum 0x7fd4d09e, Offset: 0x17d
// Size: 0x2c
function function_78c0a88763d5eef()
{
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_damaged", &function_a38bc494a40d08f4 );
    
    /#
        function_8b74e66a370845d5();
    #/
}

// Namespace zombie_diana_targeting
// Params 0
// Checksum 0x7291d7e1, Offset: 0x1b1
// Size: 0x1f
function init_zombie_diana_targeting()
{
    self.var_c3cf35bf363a00b = [];
    utility::ent_flag_set( "look_for_burst_damage_target" );
    thread function_5a5780e9883b44d1();
}

// Namespace zombie_diana_targeting
// Params 0
// Checksum 0xa017436c, Offset: 0x1d8
// Size: 0x21, Type: bool
function function_380a323f0e968785()
{
    return self.var_19df53b70a9bef0f ?? self.var_b14209598a0140ab.origin;
}

// Namespace zombie_diana_targeting
// Params 0
// Checksum 0x9d832105, Offset: 0x202
// Size: 0x1c
function function_1c1a1c058945c19()
{
    return function_380a323f0e968785() - self.var_b14209598a0140ab.origin;
}

// Namespace zombie_diana_targeting
// Params 1
// Checksum 0x1c2b281f, Offset: 0x227
// Size: 0x17
function function_63056c67b91ac873( lookaheadsecs )
{
    self.var_6380b39e8a224568 = lookaheadsecs;
}

// Namespace zombie_diana_targeting
// Params 1
// Checksum 0xf7ed5913, Offset: 0x246
// Size: 0x2a
function set_diana_target( targetent )
{
    self notify( #"diana_target_changed" );
    self.var_b14209598a0140ab = targetent;
    thread function_e5aa317c447d5c3f();
}

// Namespace zombie_diana_targeting
// Params 0
// Checksum 0x88a7935, Offset: 0x278
// Size: 0xb
function get_diana_target()
{
    return self.var_b14209598a0140ab;
}

// Namespace zombie_diana_targeting
// Params 1
// Checksum 0x1b1d7730, Offset: 0x28c
// Size: 0x3a
function set_burst_damage_target( targetent )
{
    utility::ent_flag_clear( "look_for_burst_damage_target", 1 );
    self.var_2e75165fcf2e4f84 = targetent;
    self notify( #"hash_305e489cb15eeb6" );
    thread function_3b0a3ad5c9e80c99( targetent );
}

// Namespace zombie_diana_targeting
// Params 0
// Checksum 0x2d2a5944, Offset: 0x2ce
// Size: 0xb
function get_burst_damage_target()
{
    return self.var_2e75165fcf2e4f84;
}

// Namespace zombie_diana_targeting
// Params 0
// Checksum 0xb266a8d7, Offset: 0x2e2
// Size: 0x62
function function_f84be701d1a07953()
{
    if ( self.var_2e75165fcf2e4f84 )
    {
        return self.var_2e75165fcf2e4f84;
    }
    
    if ( !self.var_c3cf35bf363a00b || self.var_c3cf35bf363a00b.size == 0 )
    {
        return;
    }
    
    var_87eb6b8a41214e20 = getarraykey( self.var_c3cf35bf363a00b, 0 );
    var_ddc982744cbf2870 = getentbynum( var_87eb6b8a41214e20 );
    return var_ddc982744cbf2870;
}

// Namespace zombie_diana_targeting
// Params 2
// Checksum 0x9f805804, Offset: 0x34d
// Size: 0x2a
function set_armor_breaker_target( targetent, var_62648d68a3466dcb )
{
    self.var_e216086757da7be6 = targetent;
    thread function_d187fdc893cfd475( targetent, var_62648d68a3466dcb );
}

// Namespace zombie_diana_targeting
// Params 0
// Checksum 0xdcb30035, Offset: 0x37f
// Size: 0xb
function get_armor_breaker_target()
{
    return self.var_e216086757da7be6;
}

// Namespace zombie_diana_targeting
// Params 0
// Checksum 0x5917cf74, Offset: 0x393
// Size: 0x3a
function function_1b8b00a924346b36()
{
    self.var_c3cf35bf363a00b = undefined;
    utility::ent_flag_clear( "look_for_burst_damage_target", 1 );
    callback::get_template( self.animsetname ) callback::remove( "on_zombie_ai_damaged", &function_a38bc494a40d08f4 );
}

// Namespace zombie_diana_targeting
// Params 2
// Checksum 0x19eba0ae, Offset: 0x3d5
// Size: 0x58, Type: bool
function function_2477c9e1c078ed6b( player, startingpos )
{
    result = trace::ray_trace( startingpos ?? self gettagorigin( "tag_mouth_fx" ), player geteye(), [ self, player ], trace::create_default_contents() );
    return result[ "fraction" ] == 1;
}

// Namespace zombie_diana_targeting
// Params 1
// Checksum 0x6bd32b23, Offset: 0x436
// Size: 0x420
function function_a38bc494a40d08f4( params )
{
    self endon( #"death" );
    
    if ( !utility::ent_flag_exist( "look_for_burst_damage_target" ) )
    {
        return;
    }
    
    if ( self._blackboard.var_606bf8ea1f70975d == 0 )
    {
        return;
    }
    
    assert( isdefined( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb ), "<dev string:x24>" );
    var_5921ea6a7beaf7b9 = utility::function_4b74c15943231980( getdvarfloat( @"hash_f20071b5c1034654", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_7c49c1b8cacfbcf8 ) );
    
    if ( gettime() - params.timehit >= var_5921ea6a7beaf7b9 )
    {
        return;
    }
    
    if ( isdefined( params.eattacker ) )
    {
        var_d70e9d6742fce163 = params.eattacker getentitynumber();
        
        if ( !isplayer( params.eattacker ) )
        {
            if ( isdefined( self.var_c3cf35bf363a00b[ var_d70e9d6742fce163 ] ) )
            {
                self.var_c3cf35bf363a00b[ var_d70e9d6742fce163 ] = undefined;
                self.var_c3cf35bf363a00b[ var_d70e9d6742fce163 ] = undefined;
            }
            
            return;
        }
        
        var_c962ec5b95a1cf0 = getdvarint( @"hash_710214172cd8c65d", 1 );
        
        if ( var_c962ec5b95a1cf0 && ( params.eattacker.ignoreme && !params.eattacker.var_f468cf5c9e75db1 || params.eattacker.notarget || params.eattacker.aether_shroud_active || params.eattacker getthreatbiasgroup() == "ignored_by_zombies" || params.eattacker.inlaststand ) )
        {
            if ( isdefined( self.var_c3cf35bf363a00b[ var_d70e9d6742fce163 ] ) )
            {
                self.var_c3cf35bf363a00b[ var_d70e9d6742fce163 ] = undefined;
                self.var_c3cf35bf363a00b[ var_d70e9d6742fce163 ] = undefined;
            }
            
            return;
        }
        
        if ( !isdefined( self.var_c3cf35bf363a00b[ var_d70e9d6742fce163 ] ) )
        {
            self.var_c3cf35bf363a00b[ var_d70e9d6742fce163 ] = spawnstruct();
            self.var_c3cf35bf363a00b[ var_d70e9d6742fce163 ].var_1e552358f8a271be = [];
        }
        
        var_3799c3813662860b = 0;
        var_86b494bfb6e92287 = [];
        
        foreach ( damagetimestamp in self.var_c3cf35bf363a00b[ var_d70e9d6742fce163 ].var_1e552358f8a271be )
        {
            if ( params.timehit - damagetimestamp.timehit <= var_5921ea6a7beaf7b9 )
            {
                var_86b494bfb6e92287[ var_86b494bfb6e92287.size ] = damagetimestamp;
                var_3799c3813662860b += damagetimestamp.damage;
            }
        }
        
        var_3799c3813662860b += params.idamage;
        var_9a83a452be1e6e71 = var_3799c3813662860b / self.maxhealth;
        var_9a83a452be1e6e71 *= 100;
        
        if ( var_9a83a452be1e6e71 >= getdvarfloat( @"hash_c8ed8699dcc92d55", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_fcdef0c560686be7 ) )
        {
            set_burst_damage_target( params.eattacker );
            return;
        }
        
        self.var_c3cf35bf363a00b[ var_d70e9d6742fce163 ].var_1e552358f8a271be = var_86b494bfb6e92287;
        damagetimestamp = spawnstruct();
        damagetimestamp.timehit = params.timehit;
        damagetimestamp.damage = params.idamage;
        self.var_c3cf35bf363a00b[ var_d70e9d6742fce163 ].var_1e552358f8a271be[ self.var_c3cf35bf363a00b[ var_d70e9d6742fce163 ].var_1e552358f8a271be.size ] = damagetimestamp;
        self.var_c3cf35bf363a00b[ var_d70e9d6742fce163 ].var_9a83a452be1e6e71 = var_9a83a452be1e6e71;
        self.var_c3cf35bf363a00b = arraysort( self.var_c3cf35bf363a00b, undefined, &function_364e22185b34ec5 );
    }
}

// Namespace zombie_diana_targeting
// Params 0, eflags: 0x4
// Checksum 0xe1e5ad3b, Offset: 0x85e
// Size: 0xb8
function private function_e5aa317c447d5c3f()
{
    self endon( #"death" );
    self endon( #"diana_target_changed" );
    targetent = self.var_b14209598a0140ab;
    
    if ( !targetent )
    {
        self.var_19df53b70a9bef0f = undefined;
        return;
    }
    
    if ( !isent( targetent ) )
    {
        self.var_19df53b70a9bef0f = undefined;
        return;
    }
    
    while ( targetent && isalive( targetent ) )
    {
        lookaheadsecs = self.var_6380b39e8a224568 ?? getdvarfloat( @"hash_efdbf9332b514be8", 0.5 );
        self.var_19df53b70a9bef0f = targetent.origin + targetent getvelocity() * lookaheadsecs;
        waitframe();
    }
    
    self.var_19df53b70a9bef0f = undefined;
}

// Namespace zombie_diana_targeting
// Params 1, eflags: 0x4
// Checksum 0xcce30792, Offset: 0x91e
// Size: 0x15b
function private function_3b0a3ad5c9e80c99( targetent )
{
    self endon( #"death" );
    utility::ent_flag_set( "currently_holding_burst_target" );
    var_58484bfab39b6513 = gettime();
    var_5f4c37474c256dbe = utility::function_4b74c15943231980( getdvarfloat( @"hash_376bb3ab4c5804d9", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_36ecb1277ddef13d ) );
    
    while ( gettime() - var_58484bfab39b6513 <= var_5f4c37474c256dbe )
    {
        if ( !isdefined( self.var_14ac7f76b960e009 ) || self.var_14ac7f76b960e009.inlaststand || !isalive( self.var_14ac7f76b960e009 ) )
        {
            break;
        }
        
        if ( self.var_14ac7f76b960e009.ignoreme && !self.var_14ac7f76b960e009.var_f468cf5c9e75db1 || self.var_14ac7f76b960e009.notarget || self.var_14ac7f76b960e009.aether_shroud_active || self.var_14ac7f76b960e009 getthreatbiasgroup() == "ignored_by_zombies" )
        {
            break;
        }
        
        waitframe();
    }
    
    self.var_c3cf35bf363a00b = [];
    self.var_14ac7f76b960e009 = undefined;
    utility::ent_flag_clear( "currently_holding_burst_target" );
    utility::ent_flag_set( "look_for_burst_damage_target" );
}

// Namespace zombie_diana_targeting
// Params 2, eflags: 0x4
// Checksum 0x35e958f7, Offset: 0xa81
// Size: 0x133
function private function_d187fdc893cfd475( targetent, var_62648d68a3466dcb )
{
    self endon( #"death" );
    utility::ent_flag_set( "currently_holding_armor_breaker_target" );
    var_58484bfab39b6513 = gettime();
    var_5f4c37474c256dbe = utility::function_4b74c15943231980( getdvarfloat( @"hash_8adb1166d197f063", var_62648d68a3466dcb ) );
    
    while ( gettime() - var_58484bfab39b6513 <= var_5f4c37474c256dbe )
    {
        if ( !isdefined( self.var_e216086757da7be6 ) || self.var_e216086757da7be6.inlaststand || !isalive( self.var_e216086757da7be6 ) )
        {
            break;
        }
        
        if ( self.var_e216086757da7be6.ignoreme && !self.var_e216086757da7be6.var_f468cf5c9e75db1 || self.var_e216086757da7be6.notarget || self.var_e216086757da7be6.aether_shroud_active || self.var_e216086757da7be6 getthreatbiasgroup() == "ignored_by_zombies" )
        {
            break;
        }
        
        waitframe();
    }
    
    self.var_e216086757da7be6 = undefined;
    utility::ent_flag_clear( "currently_holding_armor_breaker_target" );
}

// Namespace zombie_diana_targeting
// Params 2, eflags: 0x4
// Checksum 0x3f6b2a4f, Offset: 0xbbc
// Size: 0x2c, Type: bool
function private function_364e22185b34ec5( a, b )
{
    return a.var_9a83a452be1e6e71 > b.var_9a83a452be1e6e71;
}

// Namespace zombie_diana_targeting
// Params 0, eflags: 0x4
// Checksum 0x7942d6bc, Offset: 0xbf1
// Size: 0x345
function private function_5a5780e9883b44d1()
{
    self endon( #"death" );
    utility::ent_flag_wait_or_timeout( "zombie_asm_init_finished", 1 );
    
    while ( true )
    {
        var_c962ec5b95a1cf0 = getdvarint( @"hash_710214172cd8c65d", 1 );
        self function_786bb6aa1b76c7ee( "can_see_enemy", 0 );
        self.var_6e49f7b694f29bf1 = [];
        self.var_5a45f7892b21bf46 = [];
        self.var_c15224f047a275e5 = [];
        self.var_8f07f1045f74e12e = [];
        self.var_72a0e559b86a40ea = 0;
        var_698515660f2946d8 = 0;
        aethershroudplayercount = 0;
        
        foreach ( player in level.players )
        {
            var_bbdc2572f9834a6a = self.var_4827856486127f11 && distance2dsquared( player.origin, self.var_4827856486127f11.tetherpoint ) < squared( self.var_4827856486127f11.tetherradius );
            var_294f88b3d6eefbf = var_c962ec5b95a1cf0 && ( !var_bbdc2572f9834a6a || !isalive( player ) || player.inlaststand || player.ignoreme && !player.var_f468cf5c9e75db1 || player.notarget || player.aether_shroud_active || player getthreatbiasgroup() == "ignored_by_zombies" || player.inlaststand || player.sessionstate != "playing" || player.sessionstate == "spectator" );
            playerknown = !var_294f88b3d6eefbf;
            
            if ( playerknown && function_2477c9e1c078ed6b( player ) )
            {
                if ( !self getaiblackboarddynamic( "can_see_enemy" ) )
                {
                    self function_786bb6aa1b76c7ee( "can_see_enemy", 1 );
                }
                
                self.var_6e49f7b694f29bf1[ self.var_6e49f7b694f29bf1.size ] = player;
            }
            
            var_3a5a5159ab71f121 = vectortoyaw( player.origin - self.origin );
            var_1952035eafbbafae = rotatepointaroundvector( anglestoup( self.angles ), ( -164.943, 1874.28, 467.953 ), var_3a5a5159ab71f121 );
            
            if ( playerknown && function_2477c9e1c078ed6b( player, self.origin + var_1952035eafbbafae ) )
            {
                self.var_8f07f1045f74e12e[ self.var_8f07f1045f74e12e.size ] = player;
            }
            
            if ( function_2477c9e1c078ed6b( player, self gettagorigin( "j_spine1" ) ) )
            {
                self.var_5a45f7892b21bf46[ self.var_5a45f7892b21bf46.size ] = player;
            }
            
            if ( var_bbdc2572f9834a6a )
            {
                self.var_c15224f047a275e5[ self.var_c15224f047a275e5.size ] = player;
                var_698515660f2946d8++;
            }
            
            if ( player.aether_shroud_active )
            {
                aethershroudplayercount++;
            }
        }
        
        if ( aethershroudplayercount == var_698515660f2946d8 )
        {
            self.var_72a0e559b86a40ea = 1;
        }
        
        waitframe();
    }
}

// Namespace zombie_diana_targeting
// Params 2
// Checksum 0x8f251199, Offset: 0xf3e
// Size: 0x275
function function_f90aee62f1529bd9( taskid, params )
{
    if ( get_burst_damage_target() && arraycontains( self.var_6e49f7b694f29bf1, get_burst_damage_target() ) )
    {
        self.var_5852d1bf7680339e = get_burst_damage_target();
        set_diana_target( get_burst_damage_target() );
        return anim.success;
    }
    
    if ( get_armor_breaker_target() && self.var_5852d1bf7680339e != get_armor_breaker_target() && arraycontains( self.var_6e49f7b694f29bf1, get_armor_breaker_target() ) )
    {
        self.var_5852d1bf7680339e = get_armor_breaker_target();
        set_diana_target( get_armor_breaker_target() );
        return anim.success;
    }
    
    foreach ( losplayer in self.var_6e49f7b694f29bf1 )
    {
        if ( losplayer == function_f84be701d1a07953() && self.var_5852d1bf7680339e != function_f84be701d1a07953() )
        {
            self.var_5852d1bf7680339e = function_f84be701d1a07953();
            set_diana_target( function_f84be701d1a07953() );
            return anim.success;
        }
        
        if ( losplayer.var_f468cf5c9e75db1 && self.var_5852d1bf7680339e != losplayer )
        {
            self.var_5852d1bf7680339e = losplayer;
            set_diana_target( losplayer );
            return anim.success;
        }
    }
    
    if ( !self.var_6e49f7b694f29bf1 || self.var_6e49f7b694f29bf1.size == 0 )
    {
        randompoint = utility::getrandompointincircle( self.var_4827856486127f11.tetherpoint, self.var_4827856486127f11.tetherradius );
        navpoint = getclosestpointonnavmesh( randompoint );
        
        if ( !navpoint )
        {
            navpoint = utility::drop_to_ground( self.var_4827856486127f11.tetherpoint );
        }
        
        targetplayer = { #origin:navpoint };
    }
    else
    {
        targetplayer = utility::array_random( self.var_6e49f7b694f29bf1 );
    }
    
    self.var_5852d1bf7680339e = targetplayer;
    set_diana_target( targetplayer );
    return anim.success;
}

// Namespace zombie_diana_targeting
// Params 2
// Checksum 0x4ea2d1f9, Offset: 0x11bc
// Size: 0x275
function function_4a0d0827a4aeb335( taskid, params )
{
    if ( get_burst_damage_target() && arraycontains( self.var_8f07f1045f74e12e, get_burst_damage_target() ) )
    {
        self.var_5852d1bf7680339e = get_burst_damage_target();
        set_diana_target( get_burst_damage_target() );
        return anim.success;
    }
    
    if ( get_armor_breaker_target() && self.var_5852d1bf7680339e != get_armor_breaker_target() && arraycontains( self.var_8f07f1045f74e12e, get_armor_breaker_target() ) )
    {
        self.var_5852d1bf7680339e = get_armor_breaker_target();
        set_diana_target( get_armor_breaker_target() );
        return anim.success;
    }
    
    foreach ( losplayer in self.var_8f07f1045f74e12e )
    {
        if ( losplayer == function_f84be701d1a07953() && self.var_5852d1bf7680339e != function_f84be701d1a07953() )
        {
            self.var_5852d1bf7680339e = function_f84be701d1a07953();
            set_diana_target( function_f84be701d1a07953() );
            return anim.success;
        }
        
        if ( losplayer.var_f468cf5c9e75db1 && self.var_5852d1bf7680339e != losplayer )
        {
            self.var_5852d1bf7680339e = losplayer;
            set_diana_target( losplayer );
            return anim.success;
        }
    }
    
    if ( !self.var_8f07f1045f74e12e || self.var_8f07f1045f74e12e.size == 0 )
    {
        randompoint = utility::getrandompointincircle( self.var_4827856486127f11.tetherpoint, self.var_4827856486127f11.tetherradius );
        navpoint = getclosestpointonnavmesh( randompoint );
        
        if ( !navpoint )
        {
            navpoint = utility::drop_to_ground( self.var_4827856486127f11.tetherpoint );
        }
        
        targetplayer = { #origin:navpoint };
    }
    else
    {
        targetplayer = utility::array_random( self.var_8f07f1045f74e12e );
    }
    
    self.var_5852d1bf7680339e = targetplayer;
    set_diana_target( targetplayer );
    return anim.success;
}

// Namespace zombie_diana_targeting
// Params 2
// Checksum 0xfca401e, Offset: 0x143a
// Size: 0x58
function function_10d6f02505095c17( taskid, params )
{
    if ( !self.var_6e49f7b694f29bf1 || self.var_6e49f7b694f29bf1.size == 0 && !self.var_8f07f1045f74e12e || self.var_8f07f1045f74e12e.size == 0 )
    {
        return 1.5;
    }
    
    return 1;
}

// Namespace zombie_diana_targeting
// Params 2
// Checksum 0x6c13c4b, Offset: 0x149b
// Size: 0x2e, Type: bool
function function_2b33707ad8c5ac95( taskid, params )
{
    return self.var_8f07f1045f74e12e && self.var_8f07f1045f74e12e.size > 0;
}

// Namespace zombie_diana_targeting
// Params 2
// Checksum 0x3e6a5fe3, Offset: 0x14d2
// Size: 0x2e, Type: bool
function function_b7c73a02d9ed9751( taskid, params )
{
    return self.var_6e49f7b694f29bf1 && self.var_6e49f7b694f29bf1.size > 0;
}

// Namespace zombie_diana_targeting
// Params 2
// Checksum 0x15467adb, Offset: 0x1509
// Size: 0x2f, Type: bool
function function_91f519746203686d( taskid, params )
{
    return !self.var_6e49f7b694f29bf1 || self.var_6e49f7b694f29bf1.size == 0;
}

// Namespace zombie_diana_targeting
// Params 2
// Checksum 0x5bcd1159, Offset: 0x1541
// Size: 0x28
function function_ea46d558f26ddbdd( taskid, params )
{
    return get_burst_damage_target() ? 1.5 : 1;
}

// Namespace zombie_diana_targeting
// Params 2
// Checksum 0xdeb2f919, Offset: 0x1572
// Size: 0x28
function function_5f58749846f33a09( taskid, params )
{
    return get_armor_breaker_target() ? 1.5 : 1;
}

// Namespace zombie_diana_targeting
// Params 2
// Checksum 0x7a5383c4, Offset: 0x15a3
// Size: 0x2b
function function_78f078359188e6c7( taskid, params )
{
    return self.var_72a0e559b86a40ea ? 1.5 : 1;
}

// Namespace zombie_diana_targeting
// Params 2
// Checksum 0xfa471bbd, Offset: 0x15d7
// Size: 0x27
function function_2f460c8a53065b7f( taskid, params )
{
    return self.var_72a0e559b86a40ea ? 0 : 1;
}

/#

    // Namespace zombie_diana_targeting
    // Params 0
    // Checksum 0x67983b6a, Offset: 0x1607
    // Size: 0x48, Type: dev
    function function_8b74e66a370845d5()
    {
        devgui::function_9082edeb5db93280( "<dev string:x97>" );
        devgui::add_devgui_func( "<dev string:xb8>", "<dev string:xe1>", &function_c7e28d7c265f134, 1 );
        devgui::add_devgui_func( "<dev string:x10a>", "<dev string:x117>", &function_9651d61160ff070, 1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zombie_diana_targeting
    // Params 0, eflags: 0x4
    // Checksum 0x88370ff0, Offset: 0x1657
    // Size: 0x7e, Type: dev
    function private function_c7e28d7c265f134()
    {
        diana = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x132>" );
        
        if ( isdefined( diana ) )
        {
            iprintlnbold( "<dev string:x13f>" + !diana utility::ent_flag_exist( "<dev string:x166>" ) );
            diana.var_c3cf35bf363a00b = [];
            
            if ( diana utility::ent_flag_exist( "<dev string:x166>" ) )
            {
                diana utility::ent_flag_clear( "<dev string:x166>", 1 );
            }
        }
    }

    // Namespace zombie_diana_targeting
    // Params 1, eflags: 0x4
    // Checksum 0xfc2ce990, Offset: 0x16dd
    // Size: 0xbd, Type: dev
    function private function_9651d61160ff070( params )
    {
        if ( !isdefined( level.var_7bd26040d8978c33 ) )
        {
            level.var_7bd26040d8978c33 = 0;
        }
        
        level.var_7bd26040d8978c33 = !level.var_7bd26040d8978c33;
        iprintln( "<dev string:x183>" + ( level.var_7bd26040d8978c33 ? "<dev string:x19b>" : "<dev string:x19e>" ) );
        
        if ( !level.var_7bd26040d8978c33 )
        {
            return;
        }
        
        diana = zombie_utils::get_closest_zombie( level.players[ 0 ].origin, undefined, "<dev string:x132>" );
        
        if ( isdefined( diana ) )
        {
            diana thread function_8f7d123772c50cd4();
            return;
        }
        
        iprintln( "<dev string:x1a2>" );
        level.var_7bd26040d8978c33 = 0;
    }

    // Namespace zombie_diana_targeting
    // Params 0, eflags: 0x4
    // Checksum 0xcb55ecff, Offset: 0x17a2
    // Size: 0x50a, Type: dev
    function private function_8f7d123772c50cd4()
    {
        self endon( #"death" );
        info_color = ( 1, 1, 0 );
        data_color = ( 1, 1, 1 );
        var_46f80a9e6eca7e30 = ( 1, 0.3, 0 );
        armor_breaker_color = ( 0.3, 0.6, 1 );
        leading_color = ( 0, 1, 0 );
        
        while ( level.var_7bd26040d8978c33 )
        {
            assert( isdefined( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb ), "<dev string:x24>" );
            var_103616073b00c03b = getdvarfloat( @"hash_c8ed8699dcc92d55", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_fcdef0c560686be7 );
            var_337cc78bd5a0df16 = getdvarfloat( @"hash_f20071b5c1034654", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_7c49c1b8cacfbcf8 );
            var_ad707ec52285270d = utility::function_4b74c15943231980( var_337cc78bd5a0df16 );
            holdtimesec = getdvarfloat( @"hash_376bb3ab4c5804d9", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_36ecb1277ddef13d );
            var_8a5da0cb66fb9282 = utility::ent_flag_exist( "<dev string:x166>" );
            bursttarget = get_burst_damage_target();
            armorbreaker = get_armor_breaker_target();
            var_22b65f6dbdf06919 = function_f84be701d1a07953();
            level debug::function_298a6c4895b8935d( ( 400, 600, 0 ) );
            level debug::function_ce323c1a383e915( "<dev string:x1cf>" + self.bossfightphase + "<dev string:x1f1>" + self._blackboard.var_606bf8ea1f70975d + "<dev string:x200>", info_color );
            level debug::function_ce323c1a383e915( "<dev string:x206>" + var_103616073b00c03b + "<dev string:x218>" + var_337cc78bd5a0df16 + "<dev string:x230>" + holdtimesec + "<dev string:x23b>", info_color );
            level debug::function_ce323c1a383e915( "<dev string:x23d>" + var_8a5da0cb66fb9282, data_color );
            
            if ( isdefined( bursttarget ) )
            {
                level debug::function_ce323c1a383e915( "<dev string:x25a>" + bursttarget getentitynumber(), var_46f80a9e6eca7e30 );
                level thread utility::draw_entity_bounds( bursttarget, 1, var_46f80a9e6eca7e30, 1, 0.2 );
            }
            else
            {
                level debug::function_ce323c1a383e915( "<dev string:x274>", data_color );
            }
            
            if ( isdefined( armorbreaker ) )
            {
                level debug::function_ce323c1a383e915( "<dev string:x28e>" + armorbreaker getentitynumber(), armor_breaker_color );
                level thread utility::draw_entity_bounds( armorbreaker, 1, armor_breaker_color, 1, 0.2 );
            }
            else
            {
                level debug::function_ce323c1a383e915( "<dev string:x2a9>", data_color );
            }
            
            if ( isdefined( var_22b65f6dbdf06919 ) )
            {
                level debug::function_ce323c1a383e915( "<dev string:x2c4>" + var_22b65f6dbdf06919 getentitynumber(), leading_color );
            }
            else
            {
                level debug::function_ce323c1a383e915( "<dev string:x2e0>", data_color );
            }
            
            if ( isdefined( self.var_c3cf35bf363a00b ) && self.var_c3cf35bf363a00b.size > 0 )
            {
                level debug::function_ce323c1a383e915( "<dev string:x2fc>" + var_103616073b00c03b + "<dev string:x32d>" + var_337cc78bd5a0df16 + "<dev string:x33a>", info_color );
                
                foreach ( entnumber, var_f305f4ecb2db5dd1 in self.var_c3cf35bf363a00b )
                {
                    recentdamage = 0;
                    hitcount = 0;
                    
                    foreach ( damagetimestamp in var_f305f4ecb2db5dd1.var_1e552358f8a271be )
                    {
                        if ( gettime() - damagetimestamp.timehit <= var_ad707ec52285270d )
                        {
                            recentdamage += damagetimestamp.damage;
                            hitcount++;
                        }
                    }
                    
                    pct = recentdamage / self.maxhealth * 100;
                    player = getentbynum( entnumber );
                    isleading = isdefined( var_22b65f6dbdf06919 ) && isdefined( player ) && var_22b65f6dbdf06919 == player;
                    linecolor = isleading ? leading_color : data_color;
                    level debug::function_ce323c1a383e915( "<dev string:x341>" + entnumber + "<dev string:x348>" + recentdamage + "<dev string:x34b>" + pct + "<dev string:x353>" + var_103616073b00c03b + "<dev string:x358>" + hitcount + "<dev string:x362>" + ( isleading ? "<dev string:x364>" : "<dev string:x36f>" ), linecolor );
                }
            }
            else
            {
                level debug::function_ce323c1a383e915( "<dev string:x370>", data_color );
            }
            
            level debug::function_9de8db536c079b2d();
            waitframe();
        }
    }

#/
