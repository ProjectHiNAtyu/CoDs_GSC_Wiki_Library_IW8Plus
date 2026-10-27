// scripts\mp\common\equipment\blackhole_bomb.gsc  (hash_067d2049a4f9b9e9.gscc) (size: 21228 Bytes / 0x52ec / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc0fbb8da (3237722330)
// size ...... 21228 (0x52ec)
// includes .. 18  (offset: 0x4e38)
// strings ... 67  (offset: 0x4ec8)
// dev strs .. 3   (offset: 0x52c8)
// exports ... 46  (offset: 0x321c)
// cseg ...... 0x4e0 + 0x2d3c (0x321c)
// imports ... 178 (offset: 0x394c)
// animtree1 . 0   (offset: 0x52ec)
// animtree2 . 0   (offset: 0x52ec)
#using script_13865ca76df87ea;
#using script_16ea1b94f0f381b3;
#using scripts\anim\shared;
#using scripts\asm\asm;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\status_effects\effect_slow;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vortex;
#using scripts\common\weapon;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\flags;
#using scripts\mp\weapons;

#namespace blackhole_bomb;

// Namespace blackhole_bomb
// Params 0, eflags: 0x5
// Checksum 0x5a3ae1e2, Offset: 0x4fe
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"blackhole_bomb", undefined, &pre_main, &post_main );
}

// Namespace blackhole_bomb
// Params 0, eflags: 0x4
// Checksum 0x218f60f7, Offset: 0x523
// Size: 0xce
function private pre_main()
{
    level.blackhole_bomb_funcs[ "pull" ][ "zombie" ] = &function_3be377f9adc4f40c;
    level.blackhole_bomb_funcs[ "pull" ][ "soldier" ] = &function_c1c2f2a1e9c42068;
    level.blackhole_bomb_funcs[ "pull" ][ "dog" ] = &function_3be377f9adc4f40c;
    level.blackhole_bomb_funcs[ "damage" ][ "zombie" ] = &function_c6b33300a29814d6;
    level.blackhole_bomb_funcs[ "damage" ][ "soldier" ] = &function_e05f357b0d6a7276;
    level.blackhole_bomb_funcs[ "damage" ][ "dog" ] = &function_c6b33300a29814d6;
    level.blackhole_portal_player_search_throttle = throttle::throttle_initialize( "blackhole_portal_player_search", 1, 0.5 );
    level vortex::register_vortex_priority( "blackhole", 1 );
}

// Namespace blackhole_bomb
// Params 0, eflags: 0x4
// Checksum 0x2461ef81, Offset: 0x5f9
// Size: 0x15a
function private post_main()
{
    level endon( #"game_ended" );
    weapons::registerusedcallback( "blackhole_bomb", &blackhole_bomb_used );
    weapons::registeragentusedcallback( "blackhole_bomb", &blackhole_bomb_used );
    flags::function_2f3408423ccc9b2e( "prematch_done" );
    waittillframeend();
    assert( isdefined( level.equipment.callbacks ) );
    level.equipment.callbacks[ "equip_blackhole_bomb" ][ "onGive" ] = &blackhole_bomb_on_give;
    level.equipment.callbacks[ "equip_blackhole_bomb" ][ "onTake" ] = &function_224ff04440917dc2;
    assert( isdefined( level.equipment.table ) );
    
    if ( utility::issharedfuncdefined( #"medal", #"register_on_kill_medal_callback", 0 ) && isdefined( level.equipment.table[ "equip_blackhole_bomb" ].weaponname ) )
    {
        utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", level.equipment.table[ "equip_blackhole_bomb" ].weaponname, &function_9c37dab83025b0c2 );
    }
    
    level callback::add( #"on_ai_killed_medal", &function_bbd5ce0e67f46847 );
}

// Namespace blackhole_bomb
// Params 4, eflags: 0x4
// Checksum 0xf31f8821, Offset: 0x75b
// Size: 0xb6
function private blackhole_bomb_on_give( equipment_ref, slot, var_eb9f90c52851b4d9, attachments )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"blackhole_bomb_taken" );
    
    while ( true )
    {
        self waittill( #"offhand_pullback", objweapon );
        
        if ( getweaponrootstring( objweapon ) == "blackhole_bomb" )
        {
            utility::function_7c10ea82c1e305b8( "blackhole_bomb_fx", "grenade_pullback" );
            
            while ( self getheldoffhand() == objweapon && !self function_a6d700f2335edc93() )
            {
                waitframe();
            }
            
            utility::function_7c10ea82c1e305b8( "blackhole_bomb_fx", "off" );
        }
    }
}

// Namespace blackhole_bomb
// Params 2, eflags: 0x4
// Checksum 0x5f11a60a, Offset: 0x819
// Size: 0x32
function private function_224ff04440917dc2( equipment_ref, slot )
{
    self notify( #"blackhole_bomb_taken" );
    utility::function_32b24db3127bff40( "blackhole_bomb_fx", "off" );
}

// Namespace blackhole_bomb
// Params 1
// Checksum 0xf4d11f94, Offset: 0x853
// Size: 0x233
function blackhole_bomb_used( grenade )
{
    grenade endon( #"death" );
    grenade utility::registersharedfunc( #"blackhole_bomb", #"hash_754b989869c9d2cf", &function_e78db70eeb4a676c );
    grenade thread function_69ee950950db488c();
    var_2096094c4703a515 = grenade utility::waittill_any_return_params( "missile_stuck", "missile_water_impact" );
    
    if ( var_2096094c4703a515[ "message" ] == "missile_water_impact" )
    {
        grenade [[ level.var_3f5d2a9c52592654 ]]();
        grenade thread function_e78db70eeb4a676c();
        return;
    }
    else
    {
        hitent = var_2096094c4703a515[ 0 ];
    }
    
    is_first_update = 1;
    is_on_vehicle = hitent && hitent vehicle::is_vehicle();
    grenade.var_71926f64e81b08dd = is_on_vehicle ? 0.1 : 0.5;
    
    while ( true )
    {
        var_bc38bf8ebfecbcb = grenade function_d279b3fce7bd86f();
        grenade.closest_navmesh_point = var_bc38bf8ebfecbcb;
        
        if ( utility::issharedfuncdefined( #"equipment", #"hash_e0ab82e8a3d12d1d" ) && !grenade utility::callsharedfunc( #"equipment", #"hash_e0ab82e8a3d12d1d", grenade.origin, 0, [ "navobstacle_nonblocking", "navobstacle_fire" ], 1 ) )
        {
            break;
        }
        
        if ( !isdefined( var_bc38bf8ebfecbcb ) )
        {
            break;
        }
        
        if ( !isdefined( grenade.var_be3ddb862deb0056 ) )
        {
            grenade.var_be3ddb862deb0056 = grenade function_259eadb8cbb1422f( var_bc38bf8ebfecbcb, 60, 1000, 275, 10, 32, !is_on_vehicle );
            
            if ( !grenade.avoidteleport )
            {
                grenade thread function_8f3c979df66aa378( !is_on_vehicle );
            }
            
            grenade thread watch_grenade_tilt();
            grenade thread function_97482c68a6fe6018();
        }
        else
        {
            grenade.var_be3ddb862deb0056.var_acefecea26e4c38d = var_bc38bf8ebfecbcb;
        }
        
        /#
            grenade.var_be3ddb862deb0056 thread function_55d044c7cb253a62();
        #/
        
        wait grenade.var_71926f64e81b08dd;
        is_first_update = 0;
    }
    
    if ( is_first_update )
    {
        if ( isdefined( level.var_3f5d2a9c52592654 ) )
        {
            grenade [[ level.var_3f5d2a9c52592654 ]]();
        }
    }
    
    grenade function_e78db70eeb4a676c();
}

// Namespace blackhole_bomb
// Params 0, eflags: 0x4
// Checksum 0x59c1a35a, Offset: 0xa8e
// Size: 0xe1
function private function_d279b3fce7bd86f()
{
    closest_navmesh_point = getclosestpointonnavmesh( self.origin, undefined, 1, 0, 0, 0, 0, 0, [ "navobstacle_nonblocking", "navobstacle_fire" ], 1 );
    
    /#
        if ( getdvarint( @"scr_debug_vortex", 0 ) )
        {
            half_height = ( 0, 0, 80 );
            cylinder( self.origin - half_height, self.origin + half_height, sqrt( 16384 ), ( 0, 1, 1 ), 1, int( self.var_71926f64e81b08dd * 20 ) );
        }
    #/
    
    if ( isdefined( closest_navmesh_point ) )
    {
        if ( distance2dsquared( closest_navmesh_point, self.origin ) <= 16384 && abs( closest_navmesh_point[ 2 ] - self.origin[ 2 ] ) <= 80 )
        {
            return closest_navmesh_point;
        }
    }
}

// Namespace blackhole_bomb
// Params 0, eflags: 0x4
// Checksum 0xf0a2be1, Offset: 0xb78
// Size: 0x56
function private watch_grenade_tilt()
{
    self endon( #"death" );
    
    while ( true )
    {
        var_9adc7f978678a72a = vectordot( anglestoup( self.angles ), ( 0, 0, 1 ) );
        
        if ( var_9adc7f978678a72a < 0.7 )
        {
            function_e78db70eeb4a676c();
            break;
        }
        
        waitframe();
    }
}

// Namespace blackhole_bomb
// Params 0, eflags: 0x4
// Checksum 0xd2d45d2c, Offset: 0xbd6
// Size: 0x1b
function private function_97482c68a6fe6018()
{
    if ( isdefined( self ) )
    {
        self waittill( #"death" );
    }
    
    function_e78db70eeb4a676c();
}

// Namespace blackhole_bomb
// Params 0, eflags: 0x4
// Checksum 0x8eb8f538, Offset: 0xbf9
// Size: 0x3c
function private function_e78db70eeb4a676c()
{
    if ( isdefined( self.var_be3ddb862deb0056 ) )
    {
        self.var_be3ddb862deb0056 notify( #"vortex_implode" );
    }
    
    if ( isdefined( self ) )
    {
        utility::delaycallendon( 1.2, "death", &delete );
    }
}

// Namespace blackhole_bomb
// Params 0, eflags: 0x4
// Checksum 0xda73c0be, Offset: 0xc3d
// Size: 0x28
function private function_69ee950950db488c()
{
    self endon( #"death" );
    self endon( #"missile_stuck" );
    wait 10;
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace blackhole_bomb
// Params 0, eflags: 0x4
// Checksum 0x8baefb6f, Offset: 0xc6d
// Size: 0xe9
function private pull_enemies_in_range()
{
    level endon( #"game_ended" );
    callback::callback( "blackhole_bomb_start", self );
    thread function_88092fbe2b8dc3f3();
    thread function_846099c9d101fe8d();
    thread function_67108439b8a291f8();
    thread function_da55e9ccd3ff703c();
    self.grenade waittill( #"death" );
    callback::callback( "blackhole_bomb_end" );
    
    foreach ( agent in self.agents_pulled )
    {
        if ( !isalive( agent ) )
        {
            continue;
        }
        
        agent function_c421bc7468f607df( self );
    }
    
    self.agents_pulled = [];
}

// Namespace blackhole_bomb
// Params 1, eflags: 0x4
// Checksum 0xff2ac5a4, Offset: 0xd5e
// Size: 0x24f
function private function_4332649577eefb5( params )
{
    if ( isdefined( params ) && params.mode === "blackhole" )
    {
        if ( self.unittype == "soldier" )
        {
            self.blackhole_weapon_cache[ "left" ] = shared::getweaponforpos( "left" );
            self.blackhole_weapon_cache[ "right" ] = shared::getweaponforpos( "right" );
            
            foreach ( var_dc098d5212f5a2e1 in self.blackhole_weapon_cache )
            {
                if ( isdefined( var_dc098d5212f5a2e1 ) )
                {
                    shared::dropaiweapon( var_dc098d5212f5a2e1 );
                }
            }
            
            self.var_a13bed1ac47e1b2c = 1;
        }
        
        utility::function_7c10ea82c1e305b8( "blackhole_pulled", "blackhole_pulled_on" );
        
        if ( self.noragdoll || self.script_noragdoll || self.type == "zombie" && self.aicategory == "normal" )
        {
            self.forceannihilate = 1;
        }
        else
        {
            self.do_immediate_ragdoll = 1;
        }
        
        return;
    }
    
    if ( self.unittype == "soldier" )
    {
        if ( isdefined( self.blackhole_weapon_cache ) )
        {
            foreach ( var_e4d881ac5d33010f, var_dc098d5212f5a2e1 in self.blackhole_weapon_cache )
            {
                if ( isdefined( var_dc098d5212f5a2e1 ) )
                {
                    shared::placeweaponon( var_dc098d5212f5a2e1, var_e4d881ac5d33010f );
                }
            }
        }
        
        self.blackhole_weapon_cache = undefined;
        self.var_a13bed1ac47e1b2c = undefined;
    }
    
    utility::function_7c10ea82c1e305b8( "blackhole_pulled", "blackhole_pulled_off" );
    
    if ( self.noragdoll || self.script_noragdoll )
    {
        self.forceannihilate = undefined;
        return;
    }
    
    self.do_immediate_ragdoll = undefined;
}

// Namespace blackhole_bomb
// Params 1, eflags: 0x4
// Checksum 0x46da28af, Offset: 0xfb5
// Size: 0x59
function private function_c421bc7468f607df( var_be3ddb862deb0056 )
{
    is_removed = vortex::clear_vortex_state( "blackhole", var_be3ddb862deb0056 );
    
    if ( vortex::function_7e9f78caee66e33d( "blackhole" ) == 0 )
    {
        callback::remove( "on_vortex_pull_changed", &function_4332649577eefb5 );
        callback::remove( "on_vortex_pull_ended", &function_4332649577eefb5 );
    }
    
    return is_removed;
}

// Namespace blackhole_bomb
// Params 2
// Checksum 0x57431598, Offset: 0x1017
// Size: 0x1ab
function function_8a0e4d915f64425c( var_be3ddb862deb0056, is_pulled )
{
    assert( isagent( self ) );
    
    if ( is_pulled )
    {
        pull_origin = var_be3ddb862deb0056.var_acefecea26e4c38d;
        
        if ( !vortex::is_pulled() )
        {
            if ( self._blackboard.var_397bfb4ed7256a7a )
            {
                pull_origin = var_be3ddb862deb0056.vortex_center;
            }
        }
        else if ( self.var_507d3f5433b78f74 )
        {
            pull_origin = var_be3ddb862deb0056.vortex_center;
        }
        
        if ( vortex::function_7e9f78caee66e33d( "blackhole" ) == 0 )
        {
            callback::add( "on_vortex_pull_changed", &function_4332649577eefb5 );
            callback::add( "on_vortex_pull_ended", &function_4332649577eefb5 );
        }
        
        vortex_height = max( var_be3ddb862deb0056.vortex_center[ 2 ] - var_be3ddb862deb0056.var_acefecea26e4c38d[ 2 ], 0 );
        vortex_payload = { #mode:"blackhole", #height:vortex_height, #grenade:var_be3ddb862deb0056.grenade };
        is_new = vortex::set_vortex_state( "blackhole", var_be3ddb862deb0056, pull_origin, var_be3ddb862deb0056.death_range, vortex_payload );
        
        if ( is_new )
        {
            var_be3ddb862deb0056.agents_pulled[ var_be3ddb862deb0056.agents_pulled.size ] = self;
            self.vortex_pull_owner = var_be3ddb862deb0056.owner;
        }
        
        return;
    }
    
    is_removed = function_c421bc7468f607df( var_be3ddb862deb0056 );
    
    if ( is_removed )
    {
        var_be3ddb862deb0056.agents_pulled = arrayremove( var_be3ddb862deb0056.agents_pulled, self );
    }
}

// Namespace blackhole_bomb
// Params 2
// Checksum 0x1f3d03c0, Offset: 0x11ca
// Size: 0x127
function function_5fb80118ae8ab3b2( var_be3ddb862deb0056, damage_ratio )
{
    round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
    base_zombie_maxhealth = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
    var_749ae3de5300181e = 1;
    current_time = gettime();
    
    if ( !isdefined( self.vortex_damage_time ) || self.vortex_damage_time + 1000 <= current_time )
    {
        if ( isdefined( base_zombie_maxhealth ) && isent( self ) && isalive( self ) )
        {
            idflags = 536936448 | ( var_749ae3de5300181e ? 1073741824 : 0 );
            blackhole_damage = base_zombie_maxhealth * damage_ratio;
            self dodamage( blackhole_damage, var_be3ddb862deb0056.vortex_center, var_be3ddb862deb0056.grenade.owner, var_be3ddb862deb0056.grenade, "MOD_CRUSH", var_be3ddb862deb0056.grenade.weapon_object, "none", undefined, idflags );
            self.vortex_damage_time = current_time;
        }
    }
}

// Namespace blackhole_bomb
// Params 2, eflags: 0x4
// Checksum 0xdb77cb02, Offset: 0x12f9
// Size: 0x55
function private function_3be377f9adc4f40c( zombie, is_pulled )
{
    if ( !zombie.var_19238dbcc969affa || !zombie.var_5927d2279779cec0 || !zombie val::get( "allow_secondary_attack_damage" ) )
    {
        is_pulled = 0;
    }
    
    zombie thread function_8a0e4d915f64425c( self, is_pulled );
}

// Namespace blackhole_bomb
// Params 1, eflags: 0x4
// Checksum 0x526580f7, Offset: 0x1356
// Size: 0x13f
function private function_c6b33300a29814d6( zombie )
{
    if ( !zombie.var_19238dbcc969affa )
    {
        return;
    }
    
    if ( zombie.var_5927d2279779cec0 )
    {
        return;
    }
    
    damage_health_ratio = 0;
    var_8f69c955fdeea3da = 1;
    
    if ( isdefined( zombie.aicategory ) )
    {
        if ( zombie.subclass == "zombie_viper_mini_popcorn" )
        {
            var_8f69c955fdeea3da = 0.8;
        }
        else if ( zombie.aicategory == "normal" )
        {
            var_8f69c955fdeea3da = 0.6;
        }
        else if ( zombie.aicategory == "special" )
        {
            var_8f69c955fdeea3da = 0.7;
        }
        else if ( zombie.aicategory == "elite" || zombie.aicategory == "hvt" )
        {
            var_8f69c955fdeea3da = 0.7;
        }
        else if ( zombie.aicategory == "boss" )
        {
            var_8f69c955fdeea3da = 1;
        }
        
        damage_health_ratio = 2;
    }
    
    if ( var_8f69c955fdeea3da < 1 )
    {
        zombie effect_slow::slow( "blackhole", var_8f69c955fdeea3da, 0.5, self.grenade.owner, undefined, undefined, "dark" );
    }
    
    zombie function_5fb80118ae8ab3b2( self, damage_health_ratio );
}

// Namespace blackhole_bomb
// Params 2, eflags: 0x4
// Checksum 0x8f1e335e, Offset: 0x149d
// Size: 0x5d
function private function_c1c2f2a1e9c42068( soldier, is_pulled )
{
    if ( soldier ai::is_warlord() )
    {
        is_pulled = 0;
    }
    
    if ( soldier.bhasriotshieldattached && isdefined( soldier.deathfunction ) )
    {
        soldier [[ soldier.deathfunction ]]();
    }
    
    soldier thread function_8a0e4d915f64425c( self, is_pulled );
}

// Namespace blackhole_bomb
// Params 1, eflags: 0x4
// Checksum 0x543f7768, Offset: 0x1502
// Size: 0x58
function private function_e05f357b0d6a7276( soldier )
{
    if ( soldier ai::is_warlord() )
    {
        soldier effect_slow::slow( "blackhole", 0.7, 0.5, self.grenade.owner, undefined, undefined, "dark" );
        soldier function_5fb80118ae8ab3b2( self, 0.02 );
    }
}

// Namespace blackhole_bomb
// Params 0, eflags: 0x4
// Checksum 0xd10f763e, Offset: 0x1562
// Size: 0x325
function private function_88092fbe2b8dc3f3()
{
    level endon( #"game_ended" );
    self.grenade endon( #"death" );
    childthread function_2a53a7d6af18643c();
    
    while ( true )
    {
        affected_agents = getaiarrayinradius( self.vortex_center, self.var_1584d560f0aac804 );
        
        if ( isplayer( self.grenade.owner ) && utility::issharedfuncdefined( #"zm", #"hash_275603844e04e7ac" ) )
        {
            affected_agents = level [[ utility::getsharedfunc( #"zm", #"hash_275603844e04e7ac" ) ]]( affected_agents, self.grenade.owner );
        }
        
        self.agents_pulled = function_46f9072493651dc9( self.agents_pulled );
        affected_agents = arraycombineunique( affected_agents, self.agents_pulled );
        
        if ( affected_agents.size == 0 )
        {
            waitframe();
            continue;
        }
        
        pull_distance_squared = squared( self.var_1584d560f0aac804 + 200 );
        var_3ae58588ddfc1990 = 0;
        
        foreach ( agent in affected_agents )
        {
            if ( !isalive( agent ) )
            {
                continue;
            }
            
            if ( agent.team == self.team )
            {
                continue;
            }
            
            if ( agent val::get( "ignore_blackhole_bomb" ) )
            {
                continue;
            }
            
            var_b96b03906adea51d = distancesquared( agent.origin, self.vortex_center ) <= pull_distance_squared;
            
            if ( var_b96b03906adea51d && agent val::get( "postpone_vortex_pull" ) && !agent.var_f595acceb2eef9f1 )
            {
                agent.var_f595acceb2eef9f1 = 1;
                agent notify( #"hash_bd55c256afabba1c" );
                continue;
            }
            else if ( !agent val::get( "postpone_vortex_pull" ) && agent.var_f595acceb2eef9f1 )
            {
                agent.var_f595acceb2eef9f1 = undefined;
            }
            
            if ( var_b96b03906adea51d && getdvarint( @"hash_b85ad3ef347d0ba4", 0 ) )
            {
                var_46f1e4595cbe1609 = agent getcentroid();
                var_b96b03906adea51d = sighttracepassed( self.vortex_center, var_46f1e4595cbe1609, 0, agent, undefined, 1 );
                
                /#
                    if ( getdvarint( @"scr_debug_vortex", 0 ) )
                    {
                        line( self.vortex_center, var_46f1e4595cbe1609, var_b96b03906adea51d ? ( 0, 1, 0 ) : ( 1, 0, 0 ) );
                    }
                #/
            }
            
            var_73e8ec783c3c04b0 = level.blackhole_bomb_funcs[ "pull" ][ agent.unittype ];
            
            if ( isdefined( var_73e8ec783c3c04b0 ) )
            {
                self [[ var_73e8ec783c3c04b0 ]]( agent, var_b96b03906adea51d );
            }
            
            var_3ae58588ddfc1990++;
            
            if ( var_3ae58588ddfc1990 % 10 == 0 )
            {
                waitframe();
            }
        }
        
        if ( var_3ae58588ddfc1990 == 0 || var_3ae58588ddfc1990 % 10 > 0 )
        {
            waitframe();
        }
    }
}

// Namespace blackhole_bomb
// Params 0, eflags: 0x4
// Checksum 0x845d4154, Offset: 0x188f
// Size: 0x192
function private function_2a53a7d6af18643c()
{
    while ( true )
    {
        foreach ( agent in self.agents_pulled )
        {
            if ( !isalive( agent ) )
            {
                continue;
            }
            
            if ( agent vortex::function_9fe39de8aadab2b9( "blackhole", self ) )
            {
                agent.do_immediate_ragdoll = undefined;
                
                if ( isdefined( self.vortex ) )
                {
                    self.vortex setscriptablepartstate( "fake_gib_audio", "play_gib_audio" );
                }
                
                if ( agent.var_fe7f2e477eb71311 && isdefined( agent.asmname ) )
                {
                    agent.var_fe7f2e477eb71311 = undefined;
                    agent.var_56886d1cc8a39b2 = 1;
                    agent asm::asm_fireevent( agent.asmname, "vortex_death" );
                }
                else if ( !agent.var_56886d1cc8a39b2 )
                {
                    agent kill( self.vortex_center, self.grenade.owner, self.grenade, "MOD_CRUSH" );
                }
                
                if ( !isdefined( self.var_149b36509b54e9cc ) )
                {
                    self.var_149b36509b54e9cc = 0;
                }
                
                self.var_149b36509b54e9cc++;
            }
        }
        
        self.agents_pulled = function_46f9072493651dc9( self.agents_pulled );
        waitframe();
    }
}

// Namespace blackhole_bomb
// Params 0, eflags: 0x4
// Checksum 0x87436b, Offset: 0x1a29
// Size: 0x10f
function private function_846099c9d101fe8d()
{
    level endon( #"game_ended" );
    self.grenade endon( #"death" );
    
    while ( true )
    {
        affected_agents = getaiarrayinradius( self.vortex_center, self.damage_radius );
        
        foreach ( agent in affected_agents )
        {
            if ( !isalive( agent ) )
            {
                continue;
            }
            
            if ( agent.team == self.team )
            {
                continue;
            }
            
            damage_func = level.blackhole_bomb_funcs[ "damage" ][ agent.unittype ];
            
            if ( isdefined( damage_func ) )
            {
                self [[ damage_func ]]( agent );
            }
        }
        
        waitframe();
    }
}

// Namespace blackhole_bomb
// Params 0, eflags: 0x4
// Checksum 0xb161872b, Offset: 0x1b40
// Size: 0xf9
function private function_67108439b8a291f8()
{
    level endon( #"game_ended" );
    self.grenade endon( #"death" );
    
    while ( true )
    {
        var_cfa9f54569c2398a = vehicle_getarrayinradius( self.vortex_center, self.damage_radius );
        
        foreach ( vehicle in var_cfa9f54569c2398a )
        {
            if ( !isalive( vehicle ) )
            {
                continue;
            }
            
            if ( vehicle vehicle::is_destroyed() )
            {
                continue;
            }
            
            if ( vehicle.team == self.team )
            {
                continue;
            }
            
            vehicle function_5fb80118ae8ab3b2( self, 0.05 );
        }
        
        waitframe();
    }
}

// Namespace blackhole_bomb
// Params 0, eflags: 0x4
// Checksum 0x3b2b6ba0, Offset: 0x1c41
// Size: 0xf4
function private function_da55e9ccd3ff703c()
{
    level endon( #"game_ended" );
    self.grenade endon( #"death" );
    var_385af019de758c7b = self.damage_radius * self.damage_radius;
    
    while ( true )
    {
        affected_ents = damage_utility::function_cf1c753aefa70ea1( self.team );
        
        foreach ( ent in affected_ents )
        {
            if ( distancesquared( ent.origin, self.vortex_center ) <= var_385af019de758c7b )
            {
                ent function_5fb80118ae8ab3b2( self, 2 );
            }
        }
        
        waitframe();
    }
}

// Namespace blackhole_bomb
// Params 0, eflags: 0x4
// Checksum 0x3fcc7276, Offset: 0x1d3d
// Size: 0x40d
function private function_8e94cb708ba5ef56()
{
    level endon( #"game_ended" );
    var_c10b1d464f282634 = self.grenade.origin + ( 0, 0, 4 );
    self.grenade hideallparts();
    var_78ca9538691cea61 = spawn( "script_model", var_c10b1d464f282634 );
    var_78ca9538691cea61.angles = self.grenade.angles;
    blueprintindex = self.grenade.weapon_object.variantid;
    
    if ( !isdefined( blueprintindex ) )
    {
        blueprintindex = 0;
    }
    
    tableinfo = weapon::getequipmenttableinfo( "equip_blackhole_bomb" );
    bundle = tableinfo.bundle;
    genericblueprintname = namespace_de7b719e85d98dcc::function_9800c005d17e1d42( bundle, blueprintindex );
    
    if ( isdefined( genericblueprintname ) )
    {
        var_78ca9538691cea61 setgenericblueprintmodel( genericblueprintname, #"hash_13239327fd97153e" );
    }
    else
    {
        self.grenade function_aa8ac009edde3f04();
    }
    
    self.vortex = spawnscriptable( "equip_blackhole_bomb_vortex_t10_mp", self.grenade.origin, self.grenade.angles );
    self.vortex scriptablesetparententity( self.grenade );
    
    if ( isdefined( self.vortex ) )
    {
        self.vortex setscriptablepartstate( "vortex", "loop" );
    }
    
    owner = self.owner;
    
    if ( owner )
    {
        assert( !owner callback::exists( #"super_cancel", &vortex_cancel, self ) );
        owner callback::add( #"super_cancel", &vortex_cancel, self );
    }
    
    utility::waittill_notify_or_timeout( "vortex_implode", self.duration );
    
    if ( isdefined( var_78ca9538691cea61 ) )
    {
        var_78ca9538691cea61 delete();
    }
    
    if ( isdefined( self.vortex ) )
    {
        self.vortex setscriptablepartstate( "vortex", "implode" );
    }
    
    if ( isdefined( self.grenade ) )
    {
        self.grenade radiusdamage( self.vortex_center, 300, 500, 250, self.grenade.owner ?? self.grenade, "MOD_EXPLOSIVE", self.grenade.weapon_object );
        playrumbleonposition( "blackhole_bomb_implode", self.grenade.origin );
        earthquake( 0.8, 0.3, self.grenade.origin, 300 );
        
        foreach ( agentpulled in self.grenade.var_be3ddb862deb0056.agents_pulled )
        {
            if ( agentpulled.var_507d3f5433b78f74 )
            {
                agentpulled.forceannihilate = 1;
                agentpulled kill( self.vortex_center, self.grenade.owner, self.grenade, "MOD_CRUSH" );
            }
        }
        
        self.grenade utility::delaycallendon( 1, "death", &delete );
    }
    
    if ( isdefined( self.vortex ) )
    {
        self.vortex utility::delaycallendon( 7, "death", &freescriptable );
    }
    
    if ( owner )
    {
        assert( owner callback::exists( #"super_cancel", &vortex_cancel, self ) );
        owner callback::remove( #"super_cancel", &vortex_cancel, self );
    }
}

// Namespace blackhole_bomb
// Params 2, eflags: 0x4
// Checksum 0x75b7231e, Offset: 0x2152
// Size: 0x40
function private vortex_cancel( params, var_be3ddb862deb0056 )
{
    if ( var_be3ddb862deb0056.vortex )
    {
        var_be3ddb862deb0056.vortex freescriptable();
    }
    
    var_be3ddb862deb0056 notify( #"vortex_implode" );
}

// Namespace blackhole_bomb
// Params 1, eflags: 0x4
// Checksum 0x9abea77d, Offset: 0x219a
// Size: 0x26
function private get_vortex_center( var_d2dd063ccc9340a7 )
{
    return self.origin + var_d2dd063ccc9340a7 * anglestoup( self.angles );
}

// Namespace blackhole_bomb
// Params 7
// Checksum 0x6a600462, Offset: 0x21c9
// Size: 0x13b
function function_259eadb8cbb1422f( vortex_origin, var_d2dd063ccc9340a7, vortex_pull_radius, vortex_damage_radius, duration, death_range, is_static )
{
    var_be3ddb862deb0056 = spawnstruct();
    var_be3ddb862deb0056.var_acefecea26e4c38d = vortex_origin;
    var_be3ddb862deb0056.var_d2dd063ccc9340a7 = var_d2dd063ccc9340a7;
    var_be3ddb862deb0056.grenade = self;
    var_be3ddb862deb0056.team = self.team;
    var_be3ddb862deb0056.var_1584d560f0aac804 = vortex_pull_radius;
    var_be3ddb862deb0056.damage_radius = vortex_damage_radius;
    var_be3ddb862deb0056.death_range = death_range ?? 0;
    var_be3ddb862deb0056.duration = duration;
    var_be3ddb862deb0056.owner = self.owner;
    var_be3ddb862deb0056.agents_pulled = [];
    
    if ( is_static )
    {
        var_be3ddb862deb0056.vortex_center = var_be3ddb862deb0056.grenade get_vortex_center( var_be3ddb862deb0056.var_d2dd063ccc9340a7 );
    }
    else
    {
        var_be3ddb862deb0056 thread update_vortex_center();
    }
    
    var_be3ddb862deb0056 thread pull_enemies_in_range();
    var_be3ddb862deb0056 thread function_8e94cb708ba5ef56();
    return var_be3ddb862deb0056;
}

// Namespace blackhole_bomb
// Params 0, eflags: 0x4
// Checksum 0x1a1332ec, Offset: 0x230d
// Size: 0x40
function private update_vortex_center()
{
    self.grenade endon( #"death" );
    
    while ( true )
    {
        self.vortex_center = self.grenade get_vortex_center( self.var_d2dd063ccc9340a7 );
        waitframe();
    }
}

/#

    // Namespace blackhole_bomb
    // Params 0
    // Checksum 0xa829fea1, Offset: 0x2355
    // Size: 0xbf, Type: dev
    function function_55d044c7cb253a62()
    {
        if ( getdvarint( @"scr_debug_vortex", 0 ) )
        {
            vortex_debug_color = ( 0, 0, 0 );
            vortex_debug_duration = int( self.grenade.var_71926f64e81b08dd * 20 );
            debugstar( self.var_acefecea26e4c38d, vortex_debug_color, vortex_debug_duration, "<dev string:x24>" );
            debugstar( self.vortex_center, vortex_debug_color, vortex_debug_duration, "<dev string:x33>" );
            utility::draw_circle( self.vortex_center, self.var_1584d560f0aac804, vortex_debug_color, 1, 0, vortex_debug_duration );
            utility::draw_circle( self.vortex_center, self.damage_radius, vortex_debug_color, 1, 0, vortex_debug_duration );
        }
    }

#/

// Namespace blackhole_bomb
// Params 1
// Checksum 0x8b4d06f6, Offset: 0x241c
// Size: 0x1c8
function function_54f540c482b9ebca( var_1b293fdb25b93796 )
{
    self notify( #"hash_8caabc3af6c23f9a" );
    self endon( #"hash_8caabc3af6c23f9a" );
    self.anchor endon( #"death" );
    var_e23e7dbd5b176a13 = self.cached_exit_count;
    self.cached_exit_count = 0;
    
    for ( i = 0; i < var_e23e7dbd5b176a13 ; i++ )
    {
        var_457dec5d1f96dac7 = self.var_406c0fba251a0542[ i ];
        assert( isvector( var_457dec5d1f96dac7 ) );
        var_d8531ee3a6026a07 = distance2dsquared( self.anchor.origin, var_457dec5d1f96dac7 );
        
        if ( var_d8531ee3a6026a07 < 1000 || var_d8531ee3a6026a07 > 2000 )
        {
            continue;
        }
        
        self.var_406c0fba251a0542[ self.cached_exit_count ] = var_457dec5d1f96dac7;
        self.cached_exit_count++;
    }
    
    while ( self.cached_exit_count < var_1b293fdb25b93796 )
    {
        throttle_count = min( var_1b293fdb25b93796 - self.cached_exit_count, 2 );
        var_6ac984cc78c2f9dc = ai::function_7bcb54b16c07d1ec( throttle_count, self.anchor.origin, 160, 2000, 1000, 0 );
        
        foreach ( var_457dec5d1f96dac7 in var_6ac984cc78c2f9dc )
        {
            self.var_406c0fba251a0542[ self.cached_exit_count ] = var_457dec5d1f96dac7;
            self.cached_exit_count++;
        }
        
        waitframe();
    }
}

/#

    // Namespace blackhole_bomb
    // Params 0, eflags: 0x4
    // Checksum 0x541ee578, Offset: 0x25ec
    // Size: 0x7a, Type: dev
    function private function_b01850e92f2d2d52()
    {
        self.anchor endon( #"death" );
        
        while ( true )
        {
            if ( getdvarint( @"scr_debug_blackhole_teleport", 0 ) )
            {
                for ( i = 0; i < self.cached_exit_count ; i++ )
                {
                    debugstar( self.var_406c0fba251a0542[ i ], ( 1, 1, 1 ), 1, "<dev string:x41>" );
                }
            }
            
            waitframe();
        }
    }

#/

// Namespace blackhole_bomb
// Params 0, eflags: 0x4
// Checksum 0xb4fe905f, Offset: 0x266e
// Size: 0x49, Type: bool
function private function_3cb2e3fce066667a()
{
    return !self isonascender() && !self isonladder() && !self ismantling() && !isdefined( self.vehicle ) && val::get( "allow_movement" ) && val::get( "allow_teleport" );
}

// Namespace blackhole_bomb
// Params 0, eflags: 0x4
// Checksum 0xbc355073, Offset: 0x26c0
// Size: 0xb1
function private monitor_players_nearby()
{
    self.anchor endon( #"death" );
    
    while ( true )
    {
        throttle::throttle_wait_in_queue( level.blackhole_portal_player_search_throttle, self );
        var_bdc146d92862cbb8 = self.anchor get_vortex_center( self.var_d2dd063ccc9340a7 );
        self.nearby_players = getplayersinradius( var_bdc146d92862cbb8, 512 );
        
        /#
            if ( getdvarint( @"scr_debug_blackhole_teleport", 0 ) )
            {
                duration = int( 0.5 / level.framedurationseconds );
                sphere( var_bdc146d92862cbb8, 512, ( 1, 1, 1 ), 1, duration );
            }
        #/
    }
}

// Namespace blackhole_bomb
// Params 1, eflags: 0x4
// Checksum 0xecb0b441, Offset: 0x2779
// Size: 0x1d0
function private function_6e4bc65fe95ab552( player )
{
    if ( !isdefined( self.var_406c0fba251a0542 ) || self.cached_exit_count <= 0 )
    {
        return;
    }
    
    var_b9d56ba956688d36 = utility::array_slice( self.var_406c0fba251a0542, 0, self.cached_exit_count );
    shuffled_exits = arrayrandomize( var_b9d56ba956688d36 );
    var_2f9a3f2b525c0dda = [];
    
    foreach ( var_457dec5d1f96dac7 in shuffled_exits )
    {
        if ( namespace_9d8e359c3b1041e5::ispointinoutofboundssharedfunc( var_457dec5d1f96dac7, player.team ) )
        {
            continue;
        }
        
        var_2f9a3f2b525c0dda[ 0 ] = var_457dec5d1f96dac7;
        
        if ( positionwouldtelefrag( var_457dec5d1f96dac7 ) )
        {
            continue;
        }
        
        var_2f9a3f2b525c0dda[ 1 ] = var_457dec5d1f96dac7;
        var_3a0d28ac40a2195b = getplayersandaiarrayinradius( var_457dec5d1f96dac7, 250 );
        no_enemy_nearby = 1;
        
        foreach ( var_93637d803e02c1ec in var_3a0d28ac40a2195b )
        {
            if ( isdefined( var_93637d803e02c1ec.team ) && var_93637d803e02c1ec.team != player.team )
            {
                no_enemy_nearby = 0;
                break;
            }
        }
        
        if ( no_enemy_nearby )
        {
            return var_457dec5d1f96dac7;
        }
    }
    
    return var_2f9a3f2b525c0dda[ 1 ] ?? var_2f9a3f2b525c0dda[ 0 ] ?? shuffled_exits[ 0 ];
}

// Namespace blackhole_bomb
// Params 0, eflags: 0xc
// Checksum 0xb9b58e3b, Offset: 0x2952
// Size: 0x1bb
function private teleport_screen_flash()
{
    self notify( #"hash_6dd9bab0b449f29d" );
    self endon( #"hash_6dd9bab0b449f29d" );
    level endon( #"game_ended" );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.blackhole_teleport_overlay ) )
    {
        self.blackhole_teleport_overlay = newclienthudelem( self );
        self.blackhole_teleport_overlay.x = 0;
        self.blackhole_teleport_overlay.y = 0;
        self.blackhole_teleport_overlay setshader( "white", 640, 480 );
        self.blackhole_teleport_overlay.alignx = "left";
        self.blackhole_teleport_overlay.aligny = "top";
        self.blackhole_teleport_overlay.sort = 1;
        self.blackhole_teleport_overlay.horzalign = "fullscreen";
        self.blackhole_teleport_overlay.vertalign = "fullscreen";
        self.blackhole_teleport_overlay.alpha = 0;
        self.blackhole_teleport_overlay.foreground = 1;
        self.blackhole_teleport_overlay.archived = 0;
    }
    
    blackhole_teleport_overlay = self.blackhole_teleport_overlay;
    var_748d21f0ae3805f1 = 0.15;
    blackhole_teleport_overlay fadeovertime( var_748d21f0ae3805f1 );
    blackhole_teleport_overlay.alpha = 1;
    wait 0.7;
    var_748d21f0ae3805f1 = 0.7;
    
    if ( isdefined( blackhole_teleport_overlay ) )
    {
        blackhole_teleport_overlay fadeovertime( var_748d21f0ae3805f1 );
        blackhole_teleport_overlay.alpha = 0;
    }
    
    wait var_748d21f0ae3805f1;
    
    if ( isdefined( blackhole_teleport_overlay ) )
    {
        blackhole_teleport_overlay destroy();
    }
}

// Namespace blackhole_bomb
// Params 1, eflags: 0x4
// Checksum 0xfcdfaeb8, Offset: 0x2b15
// Size: 0x115
function private teleport_to_exit( var_457dec5d1f96dac7 )
{
    self endon( #"death" );
    portal = spawnscriptable( "equip_blackhole_bomb_portal_exit_t10_mp", var_457dec5d1f96dac7 );
    portal utility::delaycallendon( 7, "death", &freescriptable );
    destination = var_457dec5d1f96dac7 + ( 0, 0, 16 );
    val::set( "blackhole_teleport", "freezecontrols", 1 );
    val::set( "blackhole_teleport", "offhand_weapons", 0 );
    val::set( "blackhole_teleport", "fire", 0 );
    self playsoundevent( %"sndevent_kasimir_teleport" );
    thread teleport_screen_flash();
    wait 0.2;
    self setorigin( destination, 1 );
    waitframe();
    
    if ( isdefined( self ) )
    {
        val::reset_all( "blackhole_teleport" );
        utility::ent_flag_clear( "blackhole_teleporting" );
    }
    
    wait 0.2;
    playrumbleonposition( "blackhole_bomb_portal", var_457dec5d1f96dac7 );
    earthquake( 0.1, 0.5, var_457dec5d1f96dac7, 256 );
    callback::callback( "on_blackhole_bomb_teleport", { #var_457dec5d1f96dac7:var_457dec5d1f96dac7 } );
}

// Namespace blackhole_bomb
// Params 0, eflags: 0x4
// Checksum 0x7461c32c, Offset: 0x2c32
// Size: 0x26b
function private teleport_players()
{
    self.anchor endon( #"death" );
    
    while ( true )
    {
        foreach ( player in self.nearby_players )
        {
            if ( !level.var_bc75d47c88b4c3cc && self.cached_exit_count == 0 )
            {
                break;
            }
            
            if ( !isalive( player ) || !player jumpbuttonpressed() || !player function_3cb2e3fce066667a() )
            {
                continue;
            }
            
            can_affect = 1;
            
            if ( isplayer( self.anchor.owner ) && utility::issharedfuncdefined( #"zm", #"hash_95f8b65e45fc2ef4" ) )
            {
                can_affect = level [[ utility::getsharedfunc( #"zm", #"hash_95f8b65e45fc2ef4" ) ]]( self.anchor.owner, player );
            }
            
            if ( !can_affect )
            {
                continue;
            }
            
            if ( player utility::ent_flag( "blackhole_teleporting" ) )
            {
                continue;
            }
            
            player_eye = player geteye();
            var_bdc146d92862cbb8 = self.anchor get_vortex_center( self.var_d2dd063ccc9340a7 );
            
            if ( distancesquared( player_eye, var_bdc146d92862cbb8 ) > 4096 )
            {
                continue;
            }
            
            if ( !trace::ray_trace_passed( player_eye, var_bdc146d92862cbb8, player ) )
            {
                continue;
            }
            
            var_457dec5d1f96dac7 = undefined;
            
            if ( isdefined( level.var_38c5fa2d18ab8362 ) )
            {
                var_457dec5d1f96dac7 = self [[ level.var_38c5fa2d18ab8362 ]]( player );
            }
            else
            {
                var_457dec5d1f96dac7 = function_6e4bc65fe95ab552( player );
            }
            
            if ( isdefined( var_457dec5d1f96dac7 ) && isalive( player ) )
            {
                player utility::ent_flag_set( "blackhole_teleporting" );
                player thread teleport_to_exit( var_457dec5d1f96dac7 );
                
                if ( isdefined( self.anchor.var_be3ddb862deb0056 ) && self.anchor.owner == player )
                {
                    self.anchor.var_be3ddb862deb0056.teleportedowner = 1;
                }
                
                wait 0.1;
            }
        }
        
        waitframe();
    }
}

// Namespace blackhole_bomb
// Params 0, eflags: 0x4
// Checksum 0x328d2b63, Offset: 0x2ea5
// Size: 0x66
function private function_998d90b86a1d3909()
{
    self.anchor endon( #"death" );
    
    while ( true )
    {
        playrumbleonposition( "blackhole_bomb_portal", self.anchor.origin );
        earthquake( 0.1, 0.5, self.anchor.origin, 256 );
        wait 0.5;
    }
}

// Namespace blackhole_bomb
// Params 1
// Checksum 0xe3a2a089, Offset: 0x2f13
// Size: 0xba
function function_8f3c979df66aa378( is_static )
{
    level endon( #"game_ended" );
    var_5489a0edbdfeebfc = spawnstruct();
    var_5489a0edbdfeebfc.anchor = self;
    var_5489a0edbdfeebfc.var_d2dd063ccc9340a7 = 60;
    var_5489a0edbdfeebfc.nearby_players = [];
    var_5489a0edbdfeebfc.var_406c0fba251a0542 = [];
    var_5489a0edbdfeebfc.cached_exit_count = 0;
    
    if ( !level.var_bc75d47c88b4c3cc )
    {
        if ( is_static )
        {
            var_5489a0edbdfeebfc thread function_54f540c482b9ebca( 16 );
        }
        else
        {
            var_5489a0edbdfeebfc thread function_a18d7f7c09e76f74();
        }
        
        /#
            var_5489a0edbdfeebfc thread function_b01850e92f2d2d52();
        #/
    }
    
    var_5489a0edbdfeebfc thread function_998d90b86a1d3909();
    var_5489a0edbdfeebfc thread monitor_players_nearby();
    var_5489a0edbdfeebfc thread teleport_players();
}

// Namespace blackhole_bomb
// Params 0, eflags: 0x4
// Checksum 0xc26abb78, Offset: 0x2fd5
// Size: 0x74
function private function_a18d7f7c09e76f74()
{
    self.anchor endon( #"death" );
    var_7dfb97cb604f008 = undefined;
    
    while ( true )
    {
        if ( !isdefined( var_7dfb97cb604f008 ) || distancesquared( self.anchor.origin, var_7dfb97cb604f008 ) > 65536 )
        {
            thread function_54f540c482b9ebca( 16 );
            var_7dfb97cb604f008 = self.anchor.origin;
        }
        
        waitframe();
    }
}

// Namespace blackhole_bomb
// Params 4, eflags: 0x4
// Checksum 0xe7084594, Offset: 0x3051
// Size: 0xf8
function private function_9c37dab83025b0c2( victim, einflictor, smeansofdeath, sweapon )
{
    if ( !isdefined( einflictor.birthtime ) )
    {
        return;
    }
    
    if ( !isdefined( self.var_e5f71cd185c0c552 ) )
    {
        self.var_e5f71cd185c0c552 = [];
    }
    
    if ( !isdefined( self.var_e5f71cd185c0c552[ einflictor.birthtime ] ) )
    {
        self.var_e5f71cd185c0c552[ einflictor.birthtime ] = 0;
    }
    
    victim.is_tatical_kill = 1;
    
    if ( self.var_e5f71cd185c0c552[ einflictor.birthtime ] == 0 )
    {
        thread function_90a02e964e5bdd73( einflictor.birthtime );
    }
    
    self.var_e5f71cd185c0c552[ einflictor.birthtime ]++;
    
    if ( self.var_e5f71cd185c0c552[ einflictor.birthtime ] == 10 )
    {
        namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_eventhorizon" );
    }
}

// Namespace blackhole_bomb
// Params 1, eflags: 0x4
// Checksum 0x41e7e494, Offset: 0x3151
// Size: 0x2c
function private function_90a02e964e5bdd73( birth_time )
{
    self endon( #"death_or_disconnect" );
    wait 10;
    
    if ( isdefined( self ) )
    {
        self.var_e5f71cd185c0c552[ birth_time ] = undefined;
    }
}

// Namespace blackhole_bomb
// Params 1, eflags: 0x4
// Checksum 0xd414f419, Offset: 0x3185
// Size: 0x97
function private function_bbd5ce0e67f46847( params )
{
    if ( isdefined( params.victim ) && params.victim vortex::is_pulled() )
    {
        if ( isplayer( params.victim.vortex_pull_owner ) && !( params.attacker === params.victim.vortex_pull_owner ) )
        {
            params.victim.vortex_pull_owner namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"pull_assist" );
        }
    }
}

