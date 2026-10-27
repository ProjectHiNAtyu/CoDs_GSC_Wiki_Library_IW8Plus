// scripts\mp\ob\skills\skill_nuke.gsc  (hash_5f762bab1dd41428.gscc) (size: 6968 Bytes / 0x1b38 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x80f28194 (2163376532)
// size ...... 6968 (0x1b38)
// includes .. 7   (offset: 0x1980)
// strings ... 10  (offset: 0x19b8)
// dev strs .. 22  (offset: 0x1a30)
// exports ... 21  (offset: 0xf30)
// cseg ...... 0xfd + 0xe33 (0xf30)
// imports ... 60  (offset: 0x1278)
// animtree1 . 0   (offset: 0x1b38)
// animtree2 . 0   (offset: 0x1b38)
#using script_2fe74ee229c972c3;
#using scripts\asm\shared\mp\utility;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\ai_utility;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace skill_nuke;

// Namespace skill_nuke
// Params 0, eflags: 0x1
// Checksum 0x1e64711e, Offset: 0x11b
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"nuke", &init );
}

// Namespace skill_nuke
// Params 0
// Checksum 0x72b3266a, Offset: 0x13a
// Size: 0x8f
function init()
{
    utility::registersharedfunc( #"nuke", #"hash_f89602d29c289ca4", &function_1321989bae991e4f );
    utility::registersharedfunc( #"nuke", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"nuke", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    utility::registersharedfunc( #"nuke", #"hash_8698c290a2e85469", &get_skill_weapons );
    callback::add( #"on_ai_killed", &function_8c5e06ee1e60aeb7 );
}

// Namespace skill_nuke
// Params 1, eflags: 0x4
// Checksum 0xed5104da, Offset: 0x1d1
// Size: 0x6a
function private function_1321989bae991e4f( skill_bundle )
{
    if ( skill_bundle.nukecooldown )
    {
        skill_bundle.var_2a8236bbdf2c78ea = skill_bundle.nukecooldown * 1000;
    }
    
    if ( skill_bundle.var_403754e9a928d382 )
    {
        max_distance = skill_bundle.var_403754e9a928d382;
        skill_bundle.var_fce6bfd884532ef = max_distance * max_distance;
    }
}

// Namespace skill_nuke
// Params 1, eflags: 0x4
// Checksum 0x7a16e723, Offset: 0x243
// Size: 0x238, Type: bool
function private on_give_skill( skill_bundle )
{
    assert( skill_bundle.var_11ad8aac50b2d8ef, "<dev string:x24>" );
    assert( skill_bundle.nukechance, "<dev string:x5d>" );
    assert( skill_bundle.var_2a8236bbdf2c78ea, "<dev string:x8c>" );
    assert( skill_bundle.nukeradius, "<dev string:xbd>" );
    assert( skill_bundle.var_b7c413828e7feb66, "<dev string:xec>" );
    assert( skill_bundle.var_3cf1e2546ec17fba, "<dev string:x122>" );
    assert( skill_bundle.var_3c28c77147be8e4b, "<dev string:x135>" );
    
    /#
        if ( skill_bundle.var_6310609dfb87a8b7 )
        {
            assert( skill_bundle.var_401b329f4a6e6a16, "<dev string:x16c>" );
            assert( skill_bundle.var_5cad123bc74d04b0, "<dev string:x1a1>" );
            assert( skill_bundle.var_e3b94e9606e3d4c6, "<dev string:x1d6>" );
            assert( skill_bundle.var_805384def49de40d, "<dev string:x20d>" );
            assert( skill_bundle.var_3870da7b83f65428, "<dev string:x24b>" );
            assert( skill_bundle.var_b150bafd874b0402, "<dev string:x288>" );
            assert( skill_bundle.var_538475ccf1250454, "<dev string:x2c6>" );
            assert( skill_bundle.var_320b8f613ba5729c, "<dev string:x2ff>" );
            assert( skill_bundle.nukeweapon, "<dev string:x337>" );
            
            if ( skill_bundle.var_c73a49b200fec61e )
            {
                assert( skill_bundle.var_37c4522c26ca6db3, "<dev string:x366>" );
                assert( skill_bundle.var_7495b6ac618e7219, "<dev string:x3a3>" );
                assert( skill_bundle.var_8da03c1e2ae1242b, "<dev string:x3e0>" );
                assert( skill_bundle.var_403754e9a928d382, "<dev string:x424>" );
            }
        }
    #/
    
    self.var_b34bf39bda6da192 = { #cooldowntimestamp:undefined, #bundle:skill_bundle };
    
    /#
        thread function_79db424e287a0db4( skill_bundle );
    #/
    
    return true;
}

// Namespace skill_nuke
// Params 1, eflags: 0x4
// Checksum 0xa42b5fa1, Offset: 0x484
// Size: 0x16
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self.var_b34bf39bda6da192 = undefined;
}

// Namespace skill_nuke
// Params 1, eflags: 0x4
// Checksum 0xa8a2de0f, Offset: 0x4a2
// Size: 0x1c
function private get_skill_weapons( skill_bundle )
{
    return [ skill_bundle.nukeweapon ];
}

// Namespace skill_nuke
// Params 1, eflags: 0x4
// Checksum 0xbaba2fcb, Offset: 0x4c7
// Size: 0x12f
function private function_8c5e06ee1e60aeb7( params )
{
    attacker = params.eattacker;
    
    if ( !attacker )
    {
        return;
    }
    
    var_da55798eb12048a0 = attacker.var_b34bf39bda6da192;
    
    if ( !var_da55798eb12048a0 )
    {
        return;
    }
    
    bundle = var_da55798eb12048a0.bundle;
    var_d2d0379408c993f6 = function_67df803ff3ce4084();
    
    if ( !var_d2d0379408c993f6 || var_d2d0379408c993f6 != bundle.var_11ad8aac50b2d8ef )
    {
        return;
    }
    
    if ( !utility::percent_chance( bundle.nukechance ) )
    {
        return;
    }
    
    current_time = gettime();
    is_in_cooldown = var_da55798eb12048a0.cooldowntimestamp && current_time - var_da55798eb12048a0.cooldowntimestamp < bundle.var_2a8236bbdf2c78ea;
    
    if ( is_in_cooldown )
    {
        return;
    }
    
    var_da55798eb12048a0.cooldowntimestamp = current_time;
    origin = self.origin;
    angles = self.angles;
    attacker thread execute_explosion( bundle, origin, angles );
    attacker thread function_9464570ccdf080fd( bundle, origin, angles );
}

// Namespace skill_nuke
// Params 3, eflags: 0x4
// Checksum 0xd1a5580e, Offset: 0x5fe
// Size: 0x1bd
function private execute_explosion( bundle, origin, angles )
{
    level endon( #"game_ended" );
    explosion_scriptable = spawnscriptable( bundle.var_3c28c77147be8e4b, origin, angles );
    
    if ( explosion_scriptable )
    {
        explosion_scriptable utility::function_7c10ea82c1e305b8( "base", "on" );
    }
    
    wait bundle.var_b4855c47e18bb7e6 ?? 0;
    
    /#
        if ( getdvarint( @"hash_e53b9d7f6f2ac00b" ) )
        {
            sphere( origin, bundle.nukeradius, ( 0, 1, 0 ), 0, 100 );
        }
    #/
    
    enemies_in_range = getaiarrayinradius( origin, bundle.nukeradius );
    
    foreach ( enemy in enemies_in_range )
    {
        var_d2d0379408c993f6 = enemy function_67df803ff3ce4084();
        damage = var_d2d0379408c993f6 < bundle.var_11ad8aac50b2d8ef ? bundle.var_b7c413828e7feb66 : bundle.var_3cf1e2546ec17fba;
        enemy dodamage( damage, origin, self, self, "MOD_EXPLOSIVE", bundle.nukeweapon, "torso_upper" );
    }
    
    self notify( #"hash_a0a111c28421f704" );
    wait bundle.var_7100c6e772bd7553 ?? 0;
    
    if ( explosion_scriptable )
    {
        explosion_scriptable freescriptable();
    }
}

// Namespace skill_nuke
// Params 3, eflags: 0x4
// Checksum 0x77efba71, Offset: 0x7c3
// Size: 0x108
function private function_9464570ccdf080fd( bundle, origin, angles )
{
    level endon( #"game_ended" );
    
    if ( !bundle.var_6310609dfb87a8b7 )
    {
        return;
    }
    
    self waittill( #"hash_a0a111c28421f704" );
    spawn_group_id = ai_spawn_director::function_e19f6a00c4bb7490( "skill_" + #"nuke", 0, 1, 1, 0, 3 );
    ai_spawn_director::function_35aa3b1d92cd8207( "OnSpawned", spawn_group_id, &function_24bb5c2aa0708efb, { #bundle:bundle, #owner:self } );
    
    for ( i = 0; i < bundle.var_401b329f4a6e6a16 ; i++ )
    {
        pos_spawn = calculate_spawn_position( origin, bundle );
        
        if ( !pos_spawn )
        {
            continue;
        }
        
        ai_spawn_director::function_9893a28f1d682a28( spawn_group_id, bundle.var_5cad123bc74d04b0, pos_spawn, angles, 1, 0, 1, self.team );
        wait bundle.var_538475ccf1250454;
    }
}

// Namespace skill_nuke
// Params 2, eflags: 0x4
// Checksum 0x3b54ff5c, Offset: 0x8d3
// Size: 0x52
function private calculate_spawn_position( var_d0a9d177707a4448, bundle )
{
    if ( bundle.var_c73a49b200fec61e )
    {
        return function_7db62871c93c7eed( var_d0a9d177707a4448, bundle );
    }
    
    var_4d7d4fdebb3384d2 = getclosestpointonnavmesh( var_d0a9d177707a4448 );
    return is_valid_spawn_point( var_4d7d4fdebb3384d2, var_d0a9d177707a4448, bundle ) ? var_4d7d4fdebb3384d2 : undefined;
}

// Namespace skill_nuke
// Params 2, eflags: 0x4
// Checksum 0x672dfc37, Offset: 0x92e
// Size: 0xb4
function private function_7db62871c93c7eed( var_d0a9d177707a4448, bundle )
{
    max_radius = bundle.var_37c4522c26ca6db3;
    min_radius = bundle.var_7495b6ac618e7219;
    radius_step = bundle.var_8da03c1e2ae1242b;
    
    while ( max_radius > min_radius )
    {
        delta_x = randomfloatrange( max_radius * -1, max_radius );
        delta_y = randomfloatrange( max_radius * -1, max_radius );
        var_4d7d4fdebb3384d2 = getclosestpointonnavmesh( var_d0a9d177707a4448 + ( delta_x, delta_y, 0 ) );
        
        if ( is_valid_spawn_point( var_4d7d4fdebb3384d2, var_d0a9d177707a4448, bundle ) )
        {
            return var_4d7d4fdebb3384d2;
        }
        
        max_radius -= radius_step;
    }
}

// Namespace skill_nuke
// Params 3, eflags: 0x4
// Checksum 0x2b5f7ddf, Offset: 0x9eb
// Size: 0xcd, Type: bool
function private is_valid_spawn_point( var_4d7d4fdebb3384d2, var_d0a9d177707a4448, bundle )
{
    /#
        if ( getdvarint( @"hash_7959122f2167da4f", 0 ) == 1 )
        {
            max_distance = bundle.var_403754e9a928d382;
            debugstar( var_4d7d4fdebb3384d2, ( 1, 0, 0 ), 100, "<dev string:x463>" );
            debugstar( var_d0a9d177707a4448, ( 1, 0, 1 ), 100, "<dev string:x474>" );
            sphere( var_4d7d4fdebb3384d2, max_distance / 2, ( 0, 1, 1 ), 0, 100 );
            sphere( var_d0a9d177707a4448, max_distance / 2, ( 1, 0, 0 ), 0, 100 );
        }
    #/
    
    return distancesquared( var_4d7d4fdebb3384d2, var_d0a9d177707a4448 ) < bundle.var_fce6bfd884532ef;
}

// Namespace skill_nuke
// Params 0, eflags: 0x4
// Checksum 0x142c178, Offset: 0xac1
// Size: 0x86
function private function_67df803ff3ce4084()
{
    if ( self.type == "zombie" )
    {
        switch ( self.aicategory )
        {
            case #"hash_84fcf5e68d7230b2":
                return 1;
            case #"hash_8c089e813083e510":
                return 3;
            case #"hash_7b0e2f2ed84f34":
            case #"hash_4e47eb6c32f5b165":
            case #"hash_7e8a002ed096276c":
                return 4;
        }
        
        return;
    }
    
    if ( self.type == "human" )
    {
        return ai_utility::get_power_tier();
    }
}

// Namespace skill_nuke
// Params 4, eflags: 0x4
// Checksum 0x692d908c, Offset: 0xb50
// Size: 0x125
function private function_24bb5c2aa0708efb( groupid, userdata, zombie, agentindex )
{
    bundle = userdata.bundle;
    var_edf196138adf1c4 = userdata.owner.var_f6ce3f6c3c2ead86.bundle.var_2c3f6969e027207e ?? bundle.var_805384def49de40d;
    zombie set_zombie_difficulty( var_edf196138adf1c4 );
    zombie zombie_utils::function_c2cee1190760989c( userdata.owner, { #state:bundle.var_b150bafd874b0402, #part:bundle.var_3870da7b83f65428 } );
    zombie.owner = userdata.owner;
    zombie thread apply_damage_reduction( bundle );
    zombie function_664eafc84079325( zombie.origin, zombie.angles, bundle.var_320b8f613ba5729c );
    zombie thread auto_destroy( bundle.var_e3b94e9606e3d4c6 );
}

// Namespace skill_nuke
// Params 1, eflags: 0x4
// Checksum 0x84da5ab5, Offset: 0xc7d
// Size: 0x60
function private set_zombie_difficulty( roundnumber )
{
    if ( utility::issharedfuncdefined( #"region_difficulty_manager", #"hash_92c9697fbfaef62e" ) )
    {
        self.difficulty = utility::callsharedfunc( #"region_difficulty_manager", #"hash_92c9697fbfaef62e", roundnumber );
        zombie_utils::set_zombie_round_difficulty( roundnumber );
        return;
    }
    
    zombie_utils::set_zombie_round_difficulty( roundnumber, 0 );
}

// Namespace skill_nuke
// Params 3, eflags: 0x4
// Checksum 0x4851078b, Offset: 0xce5
// Size: 0x8e
function private function_664eafc84079325( position, angles, spawn_anim )
{
    move_delta = utility::function_80505911b6822d3( spawn_anim );
    angle_delta = utility::function_f59c00aad3d87ab9( spawn_anim );
    move_delta = rotatevector( move_delta, angles );
    start_origin = position - move_delta;
    start_angles = ( angles[ 0 ], angleclamp( angles[ 1 ] - angle_delta ), angles[ 2 ] );
    utility::animscriptedagent( spawn_anim, "spawn_end", start_origin, start_angles, "spawn_animating" );
}

// Namespace skill_nuke
// Params 1, eflags: 0x4
// Checksum 0x97521f13, Offset: 0xd7b
// Size: 0x7f
function private apply_damage_reduction( bundle )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( !bundle.var_39292570bc53ade5 )
    {
        return;
    }
    
    self.var_178270d5fd4af91b = bundle.var_39292570bc53ade5;
    zombie_utils::function_dfae6a5bd222c586( &on_zombie_damaged );
    self waittill( #"spawn_end" );
    self.var_178270d5fd4af91b = undefined;
    
    if ( isalive( self ) )
    {
        zombie_utils::function_10c0c35c21e3ed9d( &on_zombie_damaged );
    }
}

// Namespace skill_nuke
// Params 1, eflags: 0x4
// Checksum 0xb8d26d61, Offset: 0xe02
// Size: 0x3d
function private on_zombie_damaged( params )
{
    if ( !self.var_178270d5fd4af91b )
    {
        return params.idamage;
    }
    
    return params.idamage * ( 1 - self.var_178270d5fd4af91b );
}

// Namespace skill_nuke
// Params 1, eflags: 0x4
// Checksum 0x61d3115f, Offset: 0xe48
// Size: 0x44
function private auto_destroy( time )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( time )
    {
        wait time;
    }
    
    self dodamage( self.maxhealth, self.origin );
}

/#

    // Namespace skill_nuke
    // Params 1, eflags: 0xc
    // Checksum 0x67ad8d33, Offset: 0xe94
    // Size: 0x9c, Type: dev
    function private function_79db424e287a0db4( bundle )
    {
        self notify( #"hash_36efaedeb56b171b" );
        self endon( #"hash_36efaedeb56b171b" );
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_e50ac3d4804f30b8", 0 ) == 0 )
            {
                wait 0.1;
                continue;
            }
            
            thread execute_explosion( bundle, self.origin, self.angles );
            thread function_9464570ccdf080fd( bundle, self.origin, self.angles );
            setdvar( @"hash_e50ac3d4804f30b8", 0 );
        }
    }

#/
