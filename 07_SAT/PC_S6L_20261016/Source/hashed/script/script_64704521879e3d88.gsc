// script_64704521879e3d88  (hash_64704521879e3d88.gscc) (size: 21313 Bytes / 0x5341 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x93f77b87 (2482469767)
// size ...... 21313 (0x5341)
// includes .. 13  (offset: 0x508d)
// strings ... 35  (offset: 0x50f5)
// dev strs .. 0   (offset: 0x5341)
// exports ... 35  (offset: 0x3971)
// cseg ...... 0x288 + 0x36e9 (0x3971)
// imports ... 137 (offset: 0x3ee9)
// animtree1 . 0   (offset: 0x5341)
// animtree2 . 0   (offset: 0x5341)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai;
#using scripts\common\ai\ai_utility;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\shared\zombie\zombie_vox;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\callbacks;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vortex;

#namespace shadow_rift_common;

// Namespace shadow_rift_common
// Params 1
// Checksum 0x3824226, Offset: 0x2a6
// Size: 0x88
function load_fx( vfx_used )
{
    foreach ( key, ref in vfx_used )
    {
        level._effect[ key ] = loadfxasset( ref );
    }
}

// Namespace shadow_rift_common
// Params 12
// Checksum 0x660e4192, Offset: 0x336
// Size: 0xf3
function function_cbc3615eabf02728( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, var_e5e377349bdef1e4, var_fb01fe2bccef07e4, var_d0cdbed8690f0d14, btargeted, var_31389415574c377f )
{
    ai_tier = get_agent_tier( var_31389415574c377f );
    validtarget = ai_tier == 1 || ai_tier == 2 || function_88a7be98d80a32bb( attacker, var_31389415574c377f );
    
    if ( isplayer( attacker ) && validtarget )
    {
        vortex_origin = self.origin;
        vortex_angles = self.angles;
        level thread function_259eadb8cbb1422f( vortex_origin, vortex_angles, attacker, var_e5e377349bdef1e4, var_fb01fe2bccef07e4, var_d0cdbed8690f0d14, btargeted, sweapon, self, var_31389415574c377f );
    }
}

// Namespace shadow_rift_common
// Params 12
// Checksum 0x2e817c06, Offset: 0x431
// Size: 0xac
function function_e6b7819ffce8e058( death, attacker, mod, sweapon, vpoint, shitloc, modelindex, var_e5e377349bdef1e4, var_fb01fe2bccef07e4, var_d0cdbed8690f0d14, btargeted, var_31389415574c377f )
{
    vortex_origin = self.origin;
    vortex_angles = self.angles;
    level thread function_3eadf2eaa292354( attacker, vortex_origin, vortex_angles, btargeted, self, var_31389415574c377f, sweapon, var_e5e377349bdef1e4, var_fb01fe2bccef07e4 );
}

// Namespace shadow_rift_common
// Params 3, eflags: 0x4
// Checksum 0x11e57e51, Offset: 0x4e5
// Size: 0x70
function private function_dfbb94c411dbcae2( center, radius, deg )
{
    x = cos( deg );
    x *= radius;
    x += center[ 0 ];
    y = sin( deg );
    y *= radius;
    y += center[ 1 ];
    z = center[ 2 ];
    return ( x, y, z );
}

// Namespace shadow_rift_common
// Params 1, eflags: 0x4
// Checksum 0xe477914e, Offset: 0x55e
// Size: 0x104
function private function_8e94cb708ba5ef56( var_31389415574c377f )
{
    level endon( #"game_ended" );
    self endon( #"shadow_rift_stop_effect" );
    scriptable = var_31389415574c377f.scriptable;
    vortex_duration = var_31389415574c377f.vortexduration;
    implode_default_wait = 5;
    
    if ( vortex_duration == 0 )
    {
        return;
    }
    
    if ( scriptable )
    {
        self.vortex = spawnscriptable( scriptable, self.origin );
    }
    
    if ( isdefined( self.vortex ) )
    {
        if ( isdefined( vortex_duration ) )
        {
            self.vortex setscriptablepartstate( "vortex", "loop" );
        }
        else
        {
            self.vortex setscriptablepartstate( "vortex", "implode" );
        }
    }
    
    wait vortex_duration ?? implode_default_wait;
    
    if ( isdefined( self.vortex ) )
    {
        if ( isdefined( vortex_duration ) )
        {
            self.vortex setscriptablepartstate( "vortex", "implode" );
            wait implode_default_wait;
        }
    }
    
    cleanup_vortex();
}

// Namespace shadow_rift_common
// Params 9
// Checksum 0xaecc2473, Offset: 0x66a
// Size: 0x16d
function function_3eadf2eaa292354( attacker, vortex_origin, vortex_angles, btargeted, zombie, var_31389415574c377f, sweapon, var_e5e377349bdef1e4, var_fb01fe2bccef07e4 )
{
    var_be3ddb862deb0056 = spawnstruct();
    var_be3ddb862deb0056.origin = vortex_origin + ( 0, 0, 8 );
    var_be3ddb862deb0056.vortex_center = vortex_origin + ( 0, 0, 8 );
    var_be3ddb862deb0056.var_acefecea26e4c38d = vortex_origin;
    var_be3ddb862deb0056.angles = vortex_angles;
    var_be3ddb862deb0056.team = attacker.team;
    var_be3ddb862deb0056.attacker = attacker;
    var_be3ddb862deb0056.var_85f453af14d029c0 = sweapon;
    var_be3ddb862deb0056.owner = attacker;
    var_be3ddb862deb0056.id = var_31389415574c377f.vortexid;
    var_be3ddb862deb0056.agentsteleported = 0;
    var_be3ddb862deb0056.agents_pulled = [];
    var_be3ddb862deb0056 thread function_8e94cb708ba5ef56( var_31389415574c377f );
    var_be3ddb862deb0056.var_6920e7234e859622 = 1;
    var_be3ddb862deb0056.var_278fa0e078307ea6 = 0;
    var_be3ddb862deb0056 thread lethal_teleport( var_e5e377349bdef1e4, var_fb01fe2bccef07e4, 0, btargeted, var_31389415574c377f, zombie );
    var_be3ddb862deb0056 thread function_b4a5e0240aaef9c9( btargeted, var_31389415574c377f, var_e5e377349bdef1e4, var_fb01fe2bccef07e4 );
}

// Namespace shadow_rift_common
// Params 3, eflags: 0x4
// Checksum 0x8d2d5570, Offset: 0x7df
// Size: 0xe6
function private pull_agent( agent, is_pulled, var_31389415574c377f )
{
    if ( agent.var_a030c596845bf88f && gettime() < agent.var_a030c596845bf88f )
    {
        return 0;
    }
    
    ai_tier = agent get_agent_tier( var_31389415574c377f );
    
    if ( agent.type == "human" )
    {
        if ( !var_31389415574c377f.var_1e10035c05af2275 && ai_tier != 1 && ai_tier != 2 || ai_tier > var_31389415574c377f.var_f85a69b9c91db75c )
        {
            is_pulled = 0;
        }
    }
    else if ( !agent.var_19238dbcc969affa || !agent.var_5927d2279779cec0 || !agent val::get( "allow_secondary_attack_damage" ) )
    {
        is_pulled = 0;
    }
    
    agent thread function_8a0e4d915f64425c( self, is_pulled );
    return is_pulled;
}

// Namespace shadow_rift_common
// Params 5, eflags: 0x4
// Checksum 0x560d3674, Offset: 0x8ce
// Size: 0x281
function private function_2a53a7d6af18643c( starttime, btargeted, var_31389415574c377f, var_e5e377349bdef1e4 = 0, var_fb01fe2bccef07e4 = 0 )
{
    level endon( #"game_ended" );
    self endon( #"end_black_hole" );
    var_13beb1c9ed47c866 = [ "normal", "special" ];
    blackholeduration = var_31389415574c377f.vortexduration * 1000;
    var_b2dd3f86af2d2115 = var_31389415574c377f.var_b2dd3f86af2d2115 ?? 0;
    var_b2dd3f86af2d2115 += var_31389415574c377f.var_b066533f67522edb ?? 0;
    var_b2dd3f86af2d2115 += var_e5e377349bdef1e4;
    
    while ( gettime() - starttime < blackholeduration )
    {
        foreach ( agent in self.agents_pulled )
        {
            if ( !isalive( agent ) )
            {
                continue;
            }
            
            if ( isdefined( var_b2dd3f86af2d2115 ) )
            {
                if ( self.var_6920e7234e859622 < var_b2dd3f86af2d2115 )
                {
                    if ( agent function_980314e6f2b553fd( var_31389415574c377f, self, var_13beb1c9ed47c866, self.attacker ) && ( agent vortex::function_9fe39de8aadab2b9( "blackhole", self ) || distancesquared( agent.origin, self.origin ) < 1024 ) )
                    {
                        agent thread function_c421bc7468f607df( self );
                        thread lethal_teleport( var_e5e377349bdef1e4, var_fb01fe2bccef07e4, 0, btargeted, var_31389415574c377f, agent );
                        self.var_6920e7234e859622++;
                    }
                }
                
                continue;
            }
            
            if ( !agent.var_1dad73b45c2c9459 && !agent.var_b9b6fe510dcc3093 && self.var_278fa0e078307ea6 < var_31389415574c377f.var_5971e13c19dcfb76 )
            {
                if ( agent vortex::function_9fe39de8aadab2b9( "blackhole", self ) || distancesquared( agent.origin, self.origin ) < 1024 )
                {
                    agent thread function_c421bc7468f607df( self );
                    thread function_d6f795e57c8c0636( 0, btargeted, var_31389415574c377f, agent );
                    agent.var_1dad73b45c2c9459 = 1;
                    self.var_278fa0e078307ea6++;
                }
            }
        }
        
        self.agents_pulled = function_46f9072493651dc9( self.agents_pulled );
        waitframe();
    }
}

// Namespace shadow_rift_common
// Params 1, eflags: 0x4
// Checksum 0x235f7a53, Offset: 0xb57
// Size: 0x27
function private function_c421bc7468f607df( var_be3ddb862deb0056 )
{
    is_removed = vortex::clear_vortex_state( "blackhole", var_be3ddb862deb0056 );
    return is_removed;
}

// Namespace shadow_rift_common
// Params 2
// Checksum 0x28b9b435, Offset: 0xb87
// Size: 0x18c
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
                pull_origin = var_be3ddb862deb0056.vortex_center ?? var_be3ddb862deb0056.var_acefecea26e4c38d;
            }
        }
        else if ( self.var_507d3f5433b78f74 )
        {
            pull_origin = var_be3ddb862deb0056.vortex_center ?? var_be3ddb862deb0056.var_acefecea26e4c38d;
        }
        
        vortex_height = max( var_be3ddb862deb0056.origin[ 2 ] - var_be3ddb862deb0056.var_acefecea26e4c38d[ 2 ], 0 );
        vortex_payload = { #mode:"blackhole", #height:vortex_height };
        is_new = vortex::set_vortex_state( "blackhole", var_be3ddb862deb0056, pull_origin, var_be3ddb862deb0056.death_range, vortex_payload, var_be3ddb862deb0056.id );
        
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

// Namespace shadow_rift_common
// Params 4
// Checksum 0x705a3f66, Offset: 0xd1b
// Size: 0x2e3
function function_b4a5e0240aaef9c9( btargeted, var_31389415574c377f, var_e5e377349bdef1e4 = 0, var_fb01fe2bccef07e4 = 0 )
{
    level endon( #"game_ended" );
    starttime = gettime();
    thread function_2a53a7d6af18643c( starttime, btargeted, var_31389415574c377f, var_e5e377349bdef1e4, var_fb01fe2bccef07e4 );
    blackholeduration = var_31389415574c377f.vortexduration * 1000;
    var_f5b7538cf8c3d162 = 0;
    var_7525425de19f712 = var_31389415574c377f.var_8c067c10e669edaa ?? 10;
    var_7525425de19f712 = var_e5e377349bdef1e4 ? var_7525425de19f712 + var_e5e377349bdef1e4 : var_7525425de19f712;
    n_pull_radius = var_31389415574c377f.black_hole_pull_radius ?? 120;
    n_pull_radius = var_fb01fe2bccef07e4 ? n_pull_radius + var_fb01fe2bccef07e4 : n_pull_radius;
    
    while ( gettime() - starttime < blackholeduration )
    {
        nearby_ai = getaiarrayinradius( self.origin, n_pull_radius );
        
        foreach ( agent in nearby_ai )
        {
            if ( !isalive( agent ) )
            {
                continue;
            }
            
            if ( agent.team == self.team )
            {
                continue;
            }
            
            if ( self.owner && utility::issharedfuncdefined( #"zm", #"hash_8e5cbc74839b479b" ) )
            {
                if ( !level [[ utility::getsharedfunc( #"zm", #"hash_8e5cbc74839b479b" ) ]]( self.owner, agent ) )
                {
                    continue;
                }
            }
            
            if ( var_f5b7538cf8c3d162 < var_7525425de19f712 && ( agent.unittype == "zombie" || agent.unittype == "soldier" || agent.unittype == "juggernaut" ) && !agent vortex::is_pulled() )
            {
                was_pulled = pull_agent( agent, 1, var_31389415574c377f );
                
                if ( was_pulled )
                {
                    var_f5b7538cf8c3d162++;
                }
                
                thread function_aade1111b17cbbc7( agent, var_31389415574c377f );
            }
        }
        
        wait 0.25;
    }
    
    foreach ( agent in self.agents_pulled )
    {
        agent function_c421bc7468f607df( self );
    }
    
    self notify( #"end_black_hole" );
}

// Namespace shadow_rift_common
// Params 2, eflags: 0x4
// Checksum 0x96510eef, Offset: 0x1006
// Size: 0xe4
function private function_aade1111b17cbbc7( agent, var_31389415574c377f )
{
    damage_amount = var_31389415574c377f.var_9fda953f6a78a6e9;
    var_af20df805aa22681 = var_31389415574c377f.var_80d8746f96740494;
    
    if ( !damage_amount || !var_af20df805aa22681 )
    {
        return;
    }
    
    self endon( #"end_black_hole" );
    agent endon( #"death" );
    level endon( #"game_ended" );
    meansofdeath = var_31389415574c377f.vortexdamagetype ?? "MOD_ELEMENTAL_DARK";
    
    while ( true )
    {
        if ( !function_e7523d3855a04364( agent ) )
        {
            wait var_af20df805aa22681;
            continue;
        }
        
        agent dodamage( damage_amount, agent.origin, self.attacker, self.attacker, meansofdeath, self.var_85f453af14d029c0, "none", undefined );
        wait var_af20df805aa22681;
    }
}

// Namespace shadow_rift_common
// Params 10
// Checksum 0x57f573d9, Offset: 0x10f2
// Size: 0x126
function function_259eadb8cbb1422f( vortex_origin, vortex_angles, attacker, var_e5e377349bdef1e4, var_fb01fe2bccef07e4, var_d0cdbed8690f0d14, btargeted, sweapon, zombie, var_31389415574c377f )
{
    var_be3ddb862deb0056 = spawnstruct();
    var_be3ddb862deb0056.origin = vortex_origin + ( 0, 0, 8 );
    var_be3ddb862deb0056.angles = vortex_angles;
    var_be3ddb862deb0056.team = attacker.team;
    var_be3ddb862deb0056.attacker = attacker;
    var_be3ddb862deb0056.var_85f453af14d029c0 = sweapon;
    var_be3ddb862deb0056.zombie = zombie;
    var_be3ddb862deb0056.agentsteleported = 0;
    var_be3ddb862deb0056 thread function_8e94cb708ba5ef56( var_31389415574c377f );
    var_be3ddb862deb0056 thread lethal_teleport( var_e5e377349bdef1e4, var_fb01fe2bccef07e4, var_d0cdbed8690f0d14, btargeted, var_31389415574c377f );
    var_be3ddb862deb0056 thread function_d6f795e57c8c0636( var_d0cdbed8690f0d14, btargeted, var_31389415574c377f );
    
    if ( isplayer( attacker ) )
    {
        attacker callback::callback( "player_shadowvortex_started", var_be3ddb862deb0056 );
    }
    
    return var_be3ddb862deb0056;
}

// Namespace shadow_rift_common
// Params 4, eflags: 0x4
// Checksum 0xb798138c, Offset: 0x1221
// Size: 0x7c4
function private function_d6f795e57c8c0636( var_d0cdbed8690f0d14 = 0, btargeted, var_31389415574c377f, solo_force_teleport )
{
    level endon( #"game_ended" );
    wait 0.2;
    
    if ( !isplayer( self.attacker ) )
    {
        return;
    }
    
    playerorigin = self.attacker.origin;
    var_28e455bb877720ee = level.zombie_augments[ #"shadowvortex_topple_danger" ].var_28e455bb877720ee ?? 3;
    var_16f497ab21cef70 = level.zombie_augments[ #"shadowvortex_topple_danger" ].var_2710706fb4978b5c ?? 0;
    var_d8db9ee46aa8824e = var_31389415574c377f.var_16689710f73bec72;
    var_c78bc7419d98ebef = var_31389415574c377f.teleportradius ?? 0;
    var_f7ee62c54cc9896e = var_31389415574c377f.teleportdistance;
    nonlethalzombies = getaiarrayinradius( self.origin, var_c78bc7419d98ebef );
    var_5ab9536edccec064 = self.attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"shadowvortex_big_game" );
    
    if ( var_d0cdbed8690f0d14 )
    {
        var_d8db9ee46aa8824e += var_16f497ab21cef70;
    }
    
    if ( isdefined( solo_force_teleport ) )
    {
        nonlethalzombies = [ solo_force_teleport ];
    }
    
    teleportedzombies = 0;
    
    foreach ( zombie in nonlethalzombies )
    {
        if ( zombie.magic_bullet_shield || zombie.damageshield )
        {
            continue;
        }
        
        if ( zombie zombie_utils::function_bf1464d09f4e4b40() )
        {
            continue;
        }
        
        if ( zombie.aisettings.var_eb0346702e39f265 || zombie.var_eb92c31552620100 )
        {
            continue;
        }
        
        if ( self.attacker && utility::issharedfuncdefined( #"zm", #"hash_8e5cbc74839b479b" ) )
        {
            if ( !level [[ utility::getsharedfunc( #"zm", #"hash_8e5cbc74839b479b" ) ]]( self.attacker, zombie ) )
            {
                continue;
            }
        }
        
        if ( zombie.is_living_world_ai && !zombie.var_9686e1897a9ce028 )
        {
            continue;
        }
        
        if ( zombie ai::get_ignoreme() )
        {
            continue;
        }
        
        if ( zombie.var_b9b6fe510dcc3093 )
        {
            continue;
        }
        
        if ( isalive( zombie ) && teleportedzombies < var_d8db9ee46aa8824e )
        {
            ai_tier = zombie get_agent_tier( var_31389415574c377f );
            var_eeec6b132754ef16 = var_5ab9536edccec064 && ai_tier == 3;
            var_a488f29c0eca439b = var_eeec6b132754ef16 || ai_tier == 1 || ai_tier == 2;
            
            if ( var_a488f29c0eca439b )
            {
                var_9eae09d64026502d = utility::getfx( var_31389415574c377f.var_ea11f196c7e0e9a4 );
                
                if ( isdefined( var_9eae09d64026502d ) && !var_d0cdbed8690f0d14 )
                {
                    warp_fx = ( zombie.origin[ 0 ], zombie.origin[ 1 ], zombie.origin[ 2 ] + 48 );
                    playfx( var_9eae09d64026502d, warp_fx );
                }
                
                if ( !var_d0cdbed8690f0d14 )
                {
                    lookdegree = 0;
                    
                    if ( isdefined( self.attacker.angles ) )
                    {
                        lookdegree = self.attacker.angles[ 1 ];
                    }
                    
                    if ( isdefined( lookdegree ) )
                    {
                        if ( utility::cointoss() )
                        {
                            lookdegree += randomintrange( 0, 35 );
                        }
                        else
                        {
                            lookdegree -= randomintrange( 0, 35 );
                        }
                    }
                    else
                    {
                        lookdegree = 0;
                    }
                    
                    var_366a13b083936e31 = self.origin;
                    
                    if ( isplayer( self.attacker ) )
                    {
                        var_366a13b083936e31 = self.attacker.origin;
                    }
                    
                    randompoint = function_dfbb94c411dbcae2( var_366a13b083936e31, var_f7ee62c54cc9896e, lookdegree );
                    randompoint = getclosestpointonnavmesh( randompoint );
                    
                    if ( function_d3d81b6230917c26( randompoint ) )
                    {
                        leftlook = lookdegree - 90;
                        randompoint = function_dfbb94c411dbcae2( var_366a13b083936e31, var_f7ee62c54cc9896e, leftlook );
                        randompoint = getclosestpointonnavmesh( randompoint );
                    }
                    
                    if ( function_d3d81b6230917c26( randompoint ) )
                    {
                        rightlook = lookdegree + 90;
                        randompoint = function_dfbb94c411dbcae2( var_366a13b083936e31, var_f7ee62c54cc9896e, rightlook );
                        randompoint = getclosestpointonnavmesh( randompoint );
                    }
                    
                    if ( function_d3d81b6230917c26( randompoint ) )
                    {
                        lookdegree += 180;
                        randompoint = function_dfbb94c411dbcae2( var_366a13b083936e31, var_f7ee62c54cc9896e, lookdegree );
                        randompoint = getclosestpointonnavmesh( randompoint );
                    }
                    
                    if ( !function_d3d81b6230917c26( randompoint ) && !var_d0cdbed8690f0d14 )
                    {
                        zombie forceteleport( randompoint, zombie.angles, var_f7ee62c54cc9896e, 1 );
                        waitframe();
                        
                        if ( var_31389415574c377f.var_f032212aab7d207b )
                        {
                            zombie vortex::clear_all_vortex_state();
                        }
                        
                        if ( isdefined( var_9eae09d64026502d ) )
                        {
                            warp_fx = ( zombie.origin[ 0 ], zombie.origin[ 1 ], zombie.origin[ 2 ] + 48 );
                            playfx( var_9eae09d64026502d, warp_fx );
                        }
                        
                        zombie.var_1dad73b45c2c9459 = undefined;
                        
                        if ( self.attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"shadowvortex_reload" ) )
                        {
                            self.attacker function_cb6fbf007bbdb7b6();
                        }
                        
                        teleportedzombies++;
                        function_dd38b076abd20919( zombie, var_31389415574c377f );
                        self.agentsteleported++;
                        
                        if ( self.agentsteleported == 5 )
                        {
                            if ( isplayer( self.attacker ) )
                            {
                                self.attacker namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_graviton" );
                                
                                if ( utility::issharedfuncdefined( #"challenges", #"hash_4dbee06d8fb19056" ) )
                                {
                                    self.attacker utility::callsharedfunc( #"challenges", #"hash_4dbee06d8fb19056", #"medal_graviton" );
                                }
                            }
                        }
                    }
                }
                
                if ( var_d0cdbed8690f0d14 )
                {
                    round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.attacker.origin );
                    base_zombie_maxhealth = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
                    var_8d2325a3c1b80415 = level.zombie_augments[ #"shadowvortex_topple_danger" ].var_81ef84674f0f7ae3 ?? 0.5;
                    var_2f015c89b1727ac9 = int( base_zombie_maxhealth * var_8d2325a3c1b80415 );
                    var_2f015c89b1727ac9 += 1;
                    
                    if ( ai_tier == 2 )
                    {
                        zombie zombie_stun::stun_ai( var_28e455bb877720ee );
                    }
                    else if ( ai_tier == 1 )
                    {
                        zombie zombie_knockdown::function_6fc167d4a3590991( self.origin );
                    }
                    
                    waitframe();
                    
                    if ( isalive( zombie ) )
                    {
                        zombie.var_e797f68de73ece4e = "_svortex";
                        zombie.shadow_vortex_killed = 1;
                        zombie.var_c13640c265c43c23 = 1;
                        
                        if ( !zombie.magic_bullet_shield && !zombie.damageshield )
                        {
                            zombie dodamage( var_2f015c89b1727ac9, zombie.origin, self.attacker, self.attacker, "MOD_ELEMENTAL_DARK", self.var_85f453af14d029c0, "none", undefined, 1073807360 );
                        }
                        
                        if ( isalive( zombie ) )
                        {
                            if ( zombie.var_e797f68de73ece4e == "_svortex" )
                            {
                                zombie.var_e797f68de73ece4e = undefined;
                            }
                            
                            zombie.shadow_vortex_killed = 0;
                            zombie.var_c13640c265c43c23 = 0;
                        }
                    }
                }
            }
        }
    }
}

// Namespace shadow_rift_common
// Params 2
// Checksum 0xaf61732f, Offset: 0x19ed
// Size: 0x4c
function function_dd38b076abd20919( agent, var_31389415574c377f )
{
    if ( !agent || !var_31389415574c377f.pullcooldown )
    {
        return;
    }
    
    agent.var_a030c596845bf88f = gettime() + var_31389415574c377f.pullcooldown * 1000;
}

// Namespace shadow_rift_common
// Params 6, eflags: 0x4
// Checksum 0x7db3d314, Offset: 0x1a41
// Size: 0x14b1
function private lethal_teleport( var_e5e377349bdef1e4 = 0, var_fb01fe2bccef07e4 = 0, var_d0cdbed8690f0d14 = 0, btargeted = 0, var_31389415574c377f, solo_force_teleport )
{
    level endon( #"game_ended" );
    self endon( #"shadow_rift_stop_effect" );
    
    if ( !isplayer( self.attacker ) )
    {
        return;
    }
    
    var_b2dd3f86af2d2115 = var_31389415574c377f.var_b2dd3f86af2d2115 ?? 0;
    
    if ( var_31389415574c377f.isblackhole )
    {
        var_b2dd3f86af2d2115 += var_31389415574c377f.var_b066533f67522edb ?? 0;
    }
    
    if ( var_d0cdbed8690f0d14 )
    {
        var_16f497ab21cef70 = level.zombie_augments[ #"shadowvortex_topple_danger" ].var_2710706fb4978b5c ?? 0;
        var_b2dd3f86af2d2115 -= var_16f497ab21cef70;
    }
    
    var_b2dd3f86af2d2115 += var_e5e377349bdef1e4;
    var_50e8690d7b5bc3ae = var_31389415574c377f.lethalradius ?? 0;
    var_50e8690d7b5bc3ae += var_50e8690d7b5bc3ae * var_fb01fe2bccef07e4;
    nearbyai = getaiarrayinradius( self.origin, var_50e8690d7b5bc3ae );
    round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
    zombie_base_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
    var_ad5d8364fc4272f = var_31389415574c377f.var_ad5d8364fc4272f ?? var_31389415574c377f.var_689497f14fbdff16 ?? 0;
    var_1553227ca5278f0a = int( zombie_base_health * var_ad5d8364fc4272f );
    var_ef42dddd4158dd1 = [];
    var_13beb1c9ed47c866 = [ "normal", "special" ];
    lethalteleported = 0;
    
    if ( isagent( solo_force_teleport ) )
    {
        nearbyai = [ solo_force_teleport ];
    }
    
    foreach ( agent in nearbyai )
    {
        if ( !function_8e7c887f9cb0acbf( var_31389415574c377f ) && lethalteleported >= var_b2dd3f86af2d2115 )
        {
            break;
        }
        
        if ( !agent function_980314e6f2b553fd( var_31389415574c377f, self, var_13beb1c9ed47c866, self.attacker ) )
        {
            continue;
        }
        
        if ( self.attacker && utility::issharedfuncdefined( #"zm", #"hash_8e5cbc74839b479b" ) )
        {
            if ( !level [[ utility::getsharedfunc( #"zm", #"hash_8e5cbc74839b479b" ) ]]( self.attacker, agent ) )
            {
                continue;
            }
        }
        
        if ( self.attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"shadowvortex_reload" ) )
        {
            self.attacker function_cb6fbf007bbdb7b6();
        }
        
        lethalteleported++;
        function_dd38b076abd20919( agent, var_31389415574c377f );
        
        if ( !isdefined( var_31389415574c377f.var_6e746602bc0b018 ) || randomfloat( 1 ) <= var_31389415574c377f.var_6e746602bc0b018 )
        {
            var_9eae09d64026502d = utility::getfx( var_31389415574c377f.var_ea11f196c7e0e9a4 );
            
            if ( isdefined( var_9eae09d64026502d ) )
            {
                warp_fx = ( agent.origin[ 0 ], agent.origin[ 1 ], agent.origin[ 2 ] + 48 );
                playfx( var_9eae09d64026502d, warp_fx );
            }
            
            agent.var_b9b6fe510dcc3093 = 1;
            agent.var_fad926dc8ac76bc5 = 1;
            agent.ignore_enemy_count = 1;
            agent.ignoreme = 1;
            agent val::set( "shadow_vortex", "ignore_cleanup", 1 );
            agent val::set( "shadow_vortex", "pain", 0 );
            agent val::set( "shadow_vortex", "special_pain", 0 );
            agent.ignoreall = 1;
            agent notify( #"shadow_vortex_lethal_teleport_start" );
            agent val::set( "shadow_vortex", "hide", 1 );
            agent stun_ai_common( self.attacker, 0.5 );
            
            if ( var_31389415574c377f.var_7e920a3a1c9817ff )
            {
                agent val::set( "shadow_vortex", "damage", 0 );
            }
            
            self.agentsteleported++;
            
            if ( var_31389415574c377f.var_12f51ba01dc7e6b7 && self.agentsteleported == 5 && isplayer( self.attacker ) )
            {
                self.attacker namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_graviton" );
                
                if ( utility::issharedfuncdefined( #"challenges", #"hash_4dbee06d8fb19056" ) )
                {
                    self.attacker utility::callsharedfunc( #"challenges", #"hash_4dbee06d8fb19056", #"medal_graviton" );
                }
            }
            
            if ( isdefined( var_31389415574c377f.teleportscoreevent ) )
            {
                self.attacker namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( var_31389415574c377f.teleportscoreevent );
            }
            
            if ( agent.var_fad926dc8ac76bc5 )
            {
                agent.shadow_vortex_killed = 1;
            }
            
            var_ef42dddd4158dd1[ var_ef42dddd4158dd1.size ] = agent;
        }
    }
    
    wait 1;
    
    if ( var_ef42dddd4158dd1.size > 0 )
    {
        var_897b5456e28e1ffc = var_31389415574c377f.var_e20efab7b51bd48c;
        var_5f401c2d1bf9702 = var_31389415574c377f.var_20de0b221fc3e282;
        var_5d0ebc2d1991ee8 = var_31389415574c377f.var_20baf5221f9d6a68;
        tracecontents = trace::create_contents( 0, 1, 1, 1, 1, 1, 1, 0, 1, 0, 1 );
        droppoint = ( 0, 0, 0 );
        movehelper = spawn( "script_model", droppoint );
        movehelper setmodel( "tag_origin" );
        
        if ( !isdefined( self.var_6edfc3ea4d5bf1ca ) )
        {
            self.var_6edfc3ea4d5bf1ca = [];
        }
        
        self.var_6edfc3ea4d5bf1ca[ self.var_6edfc3ea4d5bf1ca.size ] = movehelper;
        self.var_1d5644f532a9c8d3 = var_ef42dddd4158dd1;
        
        foreach ( agent in var_ef42dddd4158dd1 )
        {
            if ( !function_e7523d3855a04364( agent ) )
            {
                continue;
            }
            
            heightdrop = randomintrange( var_5f401c2d1bf9702, var_5d0ebc2d1991ee8 );
            var_366a13b083936e31 = self.origin;
            lookdegree = 0;
            ai_tier = agent get_agent_tier( var_31389415574c377f );
            
            if ( isplayer( self.attacker ) )
            {
                if ( isdefined( self.attacker.angles ) )
                {
                    lookdegree = self.attacker.angles[ 1 ];
                }
                
                if ( isdefined( lookdegree ) )
                {
                    if ( utility::cointoss() )
                    {
                        lookdegree += randomintrange( 0, 35 );
                    }
                    else
                    {
                        lookdegree -= randomintrange( 0, 35 );
                    }
                }
                else
                {
                    lookdegree = 0;
                }
                
                var_366a13b083936e31 = self.attacker.origin;
            }
            
            finalpoint = function_dfbb94c411dbcae2( var_366a13b083936e31, var_897b5456e28e1ffc, lookdegree );
            
            if ( btargeted && isplayer( self.attacker ) )
            {
                var_da240dd623954f38 = getaiarrayinradius( self.attacker.origin, var_897b5456e28e1ffc );
                var_da240dd623954f38 = arrayremove( var_da240dd623954f38, agent );
                var_650eadbc4f4339ed = var_da240dd623954f38;
                
                foreach ( var_e28102573ab86b9b in var_650eadbc4f4339ed )
                {
                    if ( var_e28102573ab86b9b.var_fad926dc8ac76bc5 )
                    {
                        var_da240dd623954f38 = arrayremove( var_da240dd623954f38, var_e28102573ab86b9b );
                    }
                }
                
                foreach ( var_e28102573ab86b9b in var_650eadbc4f4339ed )
                {
                    if ( var_e28102573ab86b9b.is_living_world_ai && !var_e28102573ab86b9b.var_9686e1897a9ce028 )
                    {
                        var_da240dd623954f38 = arrayremove( var_da240dd623954f38, var_e28102573ab86b9b );
                    }
                }
                
                if ( isplayer( self.attacker ) )
                {
                    if ( utility::issharedfuncdefined( #"zm", #"hash_275603844e04e7ac" ) )
                    {
                        var_da240dd623954f38 = level [[ utility::getsharedfunc( #"zm", #"hash_275603844e04e7ac" ) ]]( var_da240dd623954f38, self.attacker );
                    }
                }
                
                if ( var_da240dd623954f38.size >= 1 )
                {
                    var_da240dd623954f38 = sortbydistance( var_da240dd623954f38, self.attacker.origin );
                    targetzombie = var_da240dd623954f38[ 0 ];
                    targetvelocity = targetzombie getentityvelocity();
                    predictedvel = 1 * targetvelocity;
                    finalpoint = targetzombie.origin + predictedvel;
                    target_ai_tier = targetzombie get_agent_tier( var_31389415574c377f );
                    
                    if ( target_ai_tier == 2 || target_ai_tier == 3 )
                    {
                        finalpoint = getclosestpointonnavmesh( finalpoint );
                    }
                }
                else
                {
                    finalpoint = getclosestpointonnavmesh( finalpoint );
                }
            }
            else
            {
                finalpoint = getclosestpointonnavmesh( finalpoint );
            }
            
            if ( function_d3d81b6230917c26( finalpoint ) )
            {
                leftlook = lookdegree - 90;
                finalpoint = function_dfbb94c411dbcae2( var_366a13b083936e31, var_897b5456e28e1ffc, leftlook );
                finalpoint = getclosestpointonnavmesh( finalpoint );
            }
            
            if ( function_d3d81b6230917c26( finalpoint ) )
            {
                rightlook = lookdegree + 90;
                finalpoint = function_dfbb94c411dbcae2( var_366a13b083936e31, var_897b5456e28e1ffc, rightlook );
                finalpoint = getclosestpointonnavmesh( finalpoint );
            }
            
            if ( function_d3d81b6230917c26( finalpoint ) )
            {
                lookdegree += 180;
                finalpoint = function_dfbb94c411dbcae2( var_366a13b083936e31, var_897b5456e28e1ffc, lookdegree );
                finalpoint = getclosestpointonnavmesh( finalpoint );
                
                if ( function_d3d81b6230917c26( finalpoint ) )
                {
                    finalpoint = getclosestpointonnavmesh( self.origin );
                }
            }
            
            droppoint = ( finalpoint[ 0 ], finalpoint[ 1 ], finalpoint[ 2 ] + heightdrop );
            var_33bc801eccfa2774 = heightdrop * heightdrop;
            var_9348ab4b28e58ab8 = 0;
            traceresults = trace::ray_trace( finalpoint, droppoint, level.players, tracecontents );
            
            if ( traceresults[ "fraction" ] < 1 )
            {
                droppoint = traceresults[ "position" ] + ( 0, 0, -32 );
                var_9348ab4b28e58ab8 = 1;
            }
            
            if ( var_9348ab4b28e58ab8 )
            {
                var_33bc801eccfa2774 = distancesquared( droppoint, finalpoint );
            }
            
            movehelper.origin = droppoint;
            var_397b25b754138098 = utility::getfx( var_31389415574c377f.var_75653cbca1a6c623 );
            
            if ( isdefined( var_397b25b754138098 ) )
            {
                playfx( var_397b25b754138098, droppoint );
            }
            
            if ( ai::is_doing_traversal( agent ) )
            {
                agent finishtraverse();
            }
            
            if ( agent islinked() )
            {
                agent motionwarpcancel();
                agent unlink( 1 );
                waitframe();
                
                if ( !function_e7523d3855a04364( agent ) )
                {
                    continue;
                }
            }
            
            agent animmode( "noclip" );
            agent forceteleport( droppoint, agent.angles );
            agent val::reset( "shadow_vortex", "hide" );
            
            if ( var_31389415574c377f.var_6b095645e9b1c002 )
            {
                agent.var_9124acfff1db61fc = 1;
            }
            
            waitframe();
            
            if ( function_e7523d3855a04364( agent ) )
            {
                if ( ai_tier == 1 )
                {
                    agent zombie_vox::function_5ac4bed4a907abf5( "pain_electric_vox" );
                    agent zombie_knockdown::function_6fc167d4a3590991( droppoint );
                }
                else if ( ai_tier == 2 || ai_tier == 3 )
                {
                    agent zombie_stun::stun_ai( 0.5 );
                }
                
                var_32fb29e75e025144 = undefined;
                var_a33bdecf7c6e7da9 = utility::getfx( var_31389415574c377f.var_e085937a3498110c );
                
                if ( isdefined( var_a33bdecf7c6e7da9 ) )
                {
                    var_32fb29e75e025144 = playfxontag( var_a33bdecf7c6e7da9, agent, "tag_origin" );
                }
                
                if ( isent( agent ) )
                {
                    agent motionwarpcancel();
                    agent linkto( movehelper, "tag_origin" );
                }
                else
                {
                    continue;
                }
                
                droptime = var_33bc801eccfa2774 / 360000;
                droptime *= droptime;
                droptime = clamp( droptime, 0.2, 2 );
                var_15ec1da330890eb8 = droptime + 0.15;
                movehelper moveto( finalpoint, droptime, 0.2 );
                wait var_15ec1da330890eb8;
                
                if ( !function_e7523d3855a04364( agent, 1 ) )
                {
                    continue;
                }
                
                if ( var_31389415574c377f.var_f032212aab7d207b )
                {
                    agent vortex::clear_all_vortex_state();
                }
                
                var_8aa959f473df5188 = var_31389415574c377f.var_8aa959f473df5188 ?? 512;
                var_33a64f87796575e0 = var_31389415574c377f.var_33a64f87796575e0 ?? 0.5;
                var_cffd95997102c756 = var_31389415574c377f.var_cffd95997102c756 ?? 0.75;
                
                if ( var_8aa959f473df5188 && var_33a64f87796575e0 && var_cffd95997102c756 )
                {
                    nearbyplayers = getplayersinradius( finalpoint, var_8aa959f473df5188 );
                    
                    foreach ( player in nearbyplayers )
                    {
                        player earthquakeforplayer( var_33a64f87796575e0, var_cffd95997102c756, finalpoint, var_8aa959f473df5188 );
                    }
                }
                
                var_2b50ab2e6fdd4512 = ai_tier == 2 || ai_tier == 3;
                
                if ( var_2b50ab2e6fdd4512 )
                {
                    agent playsound( "prj_ammomod_shadowvortex_biggame_land" );
                    var_6734a8a0fda72d7f = utility::getfx( var_31389415574c377f.var_224f265fd5efc9ff );
                    
                    if ( isdefined( var_6734a8a0fda72d7f ) )
                    {
                        playfx( var_6734a8a0fda72d7f, finalpoint );
                    }
                }
                
                if ( isdefined( var_32fb29e75e025144 ) )
                {
                    killfxontag( var_32fb29e75e025144, agent, "tag_origin" );
                }
                
                agent motionwarpcancel();
                agent unlink();
                var_3a0b7cb9ee0ec955 = 0;
                damagetype = var_31389415574c377f.vortexdamagetype ?? "MOD_ELEMENTAL_DARK";
                
                if ( ai_tier == 1 )
                {
                    if ( !isdefined( var_31389415574c377f.var_689497f14fbdff16 ) || var_31389415574c377f.var_689497f14fbdff16 >= 1 )
                    {
                        if ( var_31389415574c377f.var_3dd9bd4460531c30 && isplayer( self.attacker ) && self.attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"shadowvortex_explosive_rain" ) )
                        {
                            agent.forceannihilate = 1;
                        }
                        else if ( utility::percent_chance( 30 ) )
                        {
                            agent thread namespace_b76ff2659823e89d::function_ea9f5a702fae84ee();
                            agent thread namespace_b76ff2659823e89d::function_6903092d09bd9aa8();
                        }
                        else if ( utility::cointoss() )
                        {
                            agent thread namespace_b76ff2659823e89d::function_ea9f5a702fae84ee();
                        }
                        else
                        {
                            agent thread namespace_b76ff2659823e89d::function_6903092d09bd9aa8();
                        }
                        
                        if ( agent.magic_bullet_shield )
                        {
                            agent ai::stop_magic_bullet_shield();
                        }
                        
                        if ( isplayer( self.attacker ) )
                        {
                            params = spawnstruct();
                            params.agent = agent;
                            params.attacker = self.attacker;
                            level callback::callback( "inc_dark_kill", params );
                            
                            if ( function_ee0f88d8bc33bb80() )
                            {
                                level callback::callback( "shadowvortex_kill", params );
                                agent.var_e797f68de73ece4e = "_svortex";
                            }
                            
                            agent.shadow_vortex_killed = 1;
                            var_3a0b7cb9ee0ec955 = 1;
                            var_cbfa9122d492f18f = agent.var_65de3f7c461c1611;
                            
                            if ( function_e7523d3855a04364( agent ) )
                            {
                                agent kill( agent.origin, self.attacker, undefined, undefined, self.var_85f453af14d029c0 );
                            }
                        }
                        else if ( function_e7523d3855a04364( agent ) )
                        {
                            agent kill( agent.origin, undefined, undefined, undefined, self.var_85f453af14d029c0 );
                        }
                    }
                    else
                    {
                        agent reset_agent();
                        damage = var_1553227ca5278f0a;
                        damageflags = 65536;
                        
                        if ( agent.type == "zombie" )
                        {
                            damageflags |= 1073741824;
                        }
                        else if ( agent.type == "human" )
                        {
                            damage = agent.maxhealth * var_ad5d8364fc4272f;
                        }
                        
                        if ( function_e7523d3855a04364( agent ) )
                        {
                            var_3a0b7cb9ee0ec955 = agent dodamage( damage, agent.origin, self.attacker, self.attacker, damagetype, self.var_85f453af14d029c0, "none", undefined, damageflags );
                        }
                    }
                }
                else
                {
                    agent reset_agent();
                    
                    if ( isplayer( self.attacker ) )
                    {
                        if ( var_2b50ab2e6fdd4512 )
                        {
                            if ( !isdefined( var_31389415574c377f.var_9aac268dc1b55d9b ) )
                            {
                                if ( ai_tier == 3 )
                                {
                                    var_1553227ca5278f0a *= 5;
                                }
                                
                                if ( agent.health <= var_1553227ca5278f0a )
                                {
                                    agent.var_e797f68de73ece4e = "_svortex";
                                    agent.shadow_vortex_killed = 1;
                                }
                                
                                idflags = 65536;
                                idflags |= 536870912;
                                idflags |= 1073741824;
                                
                                if ( function_e7523d3855a04364( agent ) )
                                {
                                    var_3a0b7cb9ee0ec955 = agent dodamage( var_1553227ca5278f0a, self.origin, self.attacker, self.attacker, damagetype, self.var_85f453af14d029c0, "none", undefined, idflags );
                                }
                            }
                            else
                            {
                                agent.var_dcf8da1beef94913 = 1;
                                agent stun_ai_common( self.attacker, var_31389415574c377f.var_9aac268dc1b55d9b );
                                agent thread clear_stun_flag( var_31389415574c377f.var_9aac268dc1b55d9b );
                            }
                        }
                    }
                }
                
                if ( btargeted && isplayer( self.attacker ) && !self.attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"shadowvortex_explosive_rain" ) )
                {
                    targetedzombies = getaiarrayinradius( agent.origin, 64 );
                    
                    foreach ( var_68f35c9afc52ae25 in targetedzombies )
                    {
                        if ( isalive( var_68f35c9afc52ae25 ) )
                        {
                            if ( var_68f35c9afc52ae25.health - zombie_base_health <= 0 )
                            {
                                var_68f35c9afc52ae25.var_e797f68de73ece4e = "_svortex";
                                agent.shadow_vortex_killed = 1;
                            }
                            
                            if ( !var_68f35c9afc52ae25.magic_bullet_shield && !var_68f35c9afc52ae25.damageshield )
                            {
                                var_68f35c9afc52ae25 dodamage( zombie_base_health, agent.origin, self.attacker, self.attacker, damagetype, self.var_85f453af14d029c0, "none", undefined, 65536 );
                            }
                        }
                        
                        waitframe();
                    }
                }
                
                if ( var_3a0b7cb9ee0ec955 )
                {
                    if ( !isalive( agent ) )
                    {
                        if ( var_31389415574c377f.killscoreevent )
                        {
                            self.attacker namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( var_31389415574c377f.killscoreevent );
                        }
                    }
                    else if ( var_31389415574c377f.var_9ea8fb6ead11365d && var_31389415574c377f.assistscoreevent )
                    {
                        self.attacker [[ var_31389415574c377f.var_9ea8fb6ead11365d ]]( agent, var_31389415574c377f.assistscoreevent, var_31389415574c377f.var_1727c27c7fb52001 );
                    }
                }
                
                var_5f9ed310c8592ec0 = spawnstruct();
                var_5f9ed310c8592ec0.agent = agent;
                var_5f9ed310c8592ec0.player = self.attacker;
                var_5f9ed310c8592ec0.sweapon = self.var_85f453af14d029c0;
                var_5f9ed310c8592ec0.var_cbfa9122d492f18f = var_cbfa9122d492f18f;
                level callback::callback( "shadowvortex_zombiedropped", var_5f9ed310c8592ec0 );
            }
            
            self.var_1d5644f532a9c8d3 = arrayremove( self.var_1d5644f532a9c8d3, agent );
            
            if ( !var_31389415574c377f.var_349d07d5a721454c )
            {
                waittime = randomfloatrange( 1, 2 );
                wait waittime;
            }
        }
        
        if ( isdefined( movehelper ) )
        {
            if ( isdefined( self.var_6edfc3ea4d5bf1ca ) )
            {
                self.var_6edfc3ea4d5bf1ca = arrayremove( self.var_6edfc3ea4d5bf1ca, movehelper );
            }
            
            movehelper delete();
        }
    }
}

// Namespace shadow_rift_common
// Params 1, eflags: 0x4
// Checksum 0xe2bd191c, Offset: 0x2efa
// Size: 0x25
function private clear_stun_flag( duration )
{
    self endon( #"death" );
    wait duration;
    self.var_dcf8da1beef94913 = undefined;
}

// Namespace shadow_rift_common
// Params 1
// Checksum 0xf0eddcf1, Offset: 0x2f27
// Size: 0x39
function function_99944af57c3d2c54( zone_name )
{
    if ( !isdefined( level.var_626b7543bcb27cac ) )
    {
        level.var_626b7543bcb27cac = [];
    }
    
    level.var_626b7543bcb27cac[ level.var_626b7543bcb27cac.size ] = zone_name;
}

// Namespace shadow_rift_common
// Params 1
// Checksum 0xc686ef2b, Offset: 0x2f68
// Size: 0x31
function function_4ad7dc3777476127( zone_name )
{
    zones = level.var_626b7543bcb27cac;
    level.var_626b7543bcb27cac = arrayremove( zones, zone_name );
}

// Namespace shadow_rift_common
// Params 1, eflags: 0x4
// Checksum 0x18ffadc1, Offset: 0x2fa1
// Size: 0x12c, Type: bool
function private function_d3d81b6230917c26( v_destination )
{
    waterz = getwaterheightatlocation( v_destination );
    
    if ( isdefined( waterz ) )
    {
        if ( waterz + 24 >= v_destination[ 2 ] )
        {
            return true;
        }
    }
    
    if ( utility::issharedfuncdefined( #"zombie", #"hash_bad01cbc996e3dba" ) )
    {
        if ( !utility::callsharedfunc( #"zombie", #"hash_bad01cbc996e3dba", v_destination ) )
        {
            return true;
        }
        else if ( isdefined( level.var_626b7543bcb27cac ) && utility::issharedfuncdefined( #"zombie", #"hash_907ea089ee1bd681" ) )
        {
            foreach ( zone_name in level.var_626b7543bcb27cac )
            {
                if ( utility::callsharedfunc( #"zombie", #"hash_907ea089ee1bd681", v_destination, zone_name ) )
                {
                    return true;
                }
            }
        }
    }
    
    return false;
}

// Namespace shadow_rift_common
// Params 1, eflags: 0x4
// Checksum 0x3462c8ea, Offset: 0x30d6
// Size: 0x19, Type: bool
function private function_8e7c887f9cb0acbf( var_31389415574c377f )
{
    return var_31389415574c377f.var_b2dd3f86af2d2115 < 0;
}

// Namespace shadow_rift_common
// Params 0, eflags: 0x4
// Checksum 0x4eb49ce8, Offset: 0x30f8
// Size: 0x6e
function private reset_agent()
{
    self.var_fad926dc8ac76bc5 = undefined;
    self.ignore_enemy_count = 0;
    self.ignoreme = 0;
    val::reset( "shadow_vortex", "ignore_cleanup" );
    val::reset( "shadow_vortex", "pain" );
    val::reset( "shadow_vortex", "special_pain" );
    self.ignoreall = 0;
    val::reset( "shadow_vortex", "damage" );
}

// Namespace shadow_rift_common
// Params 2, eflags: 0x4
// Checksum 0x9abb47ac, Offset: 0x316e
// Size: 0x3c
function private stun_soldier( attacker, duration )
{
    self notify( #"flashbang", self.origin, 1, undefined, attacker, attacker.team, duration );
}

// Namespace shadow_rift_common
// Params 2, eflags: 0x4
// Checksum 0x93d8ce73, Offset: 0x31b2
// Size: 0x4f
function private stun_ai_common( attacker, duration )
{
    if ( self.type == "zombie" )
    {
        zombie_stun::stun_ai( duration );
        return;
    }
    
    if ( self.type == "human" )
    {
        stun_soldier( attacker, duration );
    }
}

// Namespace shadow_rift_common
// Params 0, eflags: 0x4
// Checksum 0x8318803a, Offset: 0x3209
// Size: 0x5f, Type: bool
function private function_ee0f88d8bc33bb80()
{
    return isdefined( self.var_85f453af14d029c0 ) && !isstring( self.var_85f453af14d029c0 ) && !isxhash( self.var_85f453af14d029c0 ) && !isxhashasset( self.var_85f453af14d029c0 ) && self.var_85f453af14d029c0.basename != "t10_inc_dark_zm";
}

// Namespace shadow_rift_common
// Params 4, eflags: 0x4
// Checksum 0x644b0a02, Offset: 0x3271
// Size: 0x237, Type: bool
function private function_980314e6f2b553fd( var_31389415574c377f, vortex, var_684a8d8f1d914997, owning_player )
{
    if ( !isplayer( owning_player ) )
    {
        return false;
    }
    
    if ( self.magic_bullet_shield || self.damageshield )
    {
        return false;
    }
    
    if ( self.var_fad926dc8ac76bc5 )
    {
        return false;
    }
    
    if ( !utility::callsharedfunc( #"player", #"playersareenemies", self, vortex ) )
    {
        return false;
    }
    
    if ( zombie_utils::function_bf1464d09f4e4b40() )
    {
        return false;
    }
    
    if ( val::get( "shadow_rift_lethal_tele_immune" ) )
    {
        return false;
    }
    
    if ( self.aisettings.var_eb0346702e39f265 || self.var_eb92c31552620100 )
    {
        return false;
    }
    
    if ( self.is_living_world_ai && !self.var_9686e1897a9ce028 )
    {
        return false;
    }
    
    if ( ai::get_ignoreme() )
    {
        return false;
    }
    
    if ( self.var_9124acfff1db61fc && var_31389415574c377f.var_6b095645e9b1c002 )
    {
        return false;
    }
    
    if ( var_31389415574c377f.var_4ffaa10c855d8342 && self.ridingvehicle )
    {
        return false;
    }
    
    ai_tier = get_agent_tier( var_31389415574c377f );
    
    if ( !var_31389415574c377f.var_f85a69b9c91db75c && ai_tier != 1 && ai_tier != 2 && !function_88a7be98d80a32bb( vortex.attacker, var_31389415574c377f ) )
    {
        return false;
    }
    else if ( ai_tier > var_31389415574c377f.var_f85a69b9c91db75c )
    {
        return false;
    }
    
    if ( var_31389415574c377f.var_e3fd399dcc0598da && !owning_player [[ var_31389415574c377f.var_e3fd399dcc0598da ]]( self, vortex, var_31389415574c377f ) )
    {
        return false;
    }
    
    foreach ( var_9e16d60d58da566d in var_31389415574c377f.var_31dfe1fbbd9a619d )
    {
        if ( var_9e16d60d58da566d.assetref == self.subclass )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace shadow_rift_common
// Params 2, eflags: 0x4
// Checksum 0xb595c937, Offset: 0x34b1
// Size: 0x6d
function private function_88a7be98d80a32bb( attacker, var_31389415574c377f )
{
    ai_tier = get_agent_tier( var_31389415574c377f );
    is_big_game = ai_tier == 3;
    is_valid_big_game = is_big_game && attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"shadowvortex_big_game" );
    return is_valid_big_game;
}

// Namespace shadow_rift_common
// Params 1, eflags: 0x4
// Checksum 0xc245053a, Offset: 0x3527
// Size: 0x2c
function private function_e7cb4b73736f595c( categories )
{
    return isdefined( self.aicategory ) ? arraycontains( categories, self.aicategory ) : 0;
}

// Namespace shadow_rift_common
// Params 0, eflags: 0x4
// Checksum 0x1884b9a7, Offset: 0x355c
// Size: 0x1f1
function private function_cb6fbf007bbdb7b6()
{
    if ( isplayer( self ) )
    {
        reloadpercent = level.zombie_augments[ #"shadowvortex_reload" ].var_d5c85dfae62e1610;
        reloadmax = level.zombie_augments[ #"shadowvortex_reload" ].var_88384f310a506dab ?? 15;
        currentweapon = self getcurrentweapon();
        maxclipammo = weaponclipsize( currentweapon );
        var_bbc21d630608de47 = int( maxclipammo * reloadpercent );
        currentclipammo = self getweaponammoclip( currentweapon );
        currentstockammo = self getweaponammostock( currentweapon );
        var_bbc21d630608de47 = var_bbc21d630608de47 > reloadmax ? reloadmax : var_bbc21d630608de47;
        
        if ( currentstockammo > 0 && !function_fbb6adbc1a89658a( currentweapon ) )
        {
            if ( currentweapon.isdualwield )
            {
                var_506693b2ebc6da6a = self getweaponammoclip( currentweapon, "left" );
                
                if ( var_506693b2ebc6da6a < maxclipammo )
                {
                    if ( var_bbc21d630608de47 > currentstockammo )
                    {
                        var_bbc21d630608de47 = currentstockammo;
                    }
                    
                    amountmissing = maxclipammo - var_506693b2ebc6da6a;
                    
                    if ( var_506693b2ebc6da6a + var_bbc21d630608de47 > maxclipammo )
                    {
                        var_bbc21d630608de47 = amountmissing;
                    }
                    
                    var_3bfcf90943caa6b3 = currentstockammo - var_bbc21d630608de47;
                    self setweaponammoclip( currentweapon, var_506693b2ebc6da6a + var_bbc21d630608de47, "left" );
                    self setweaponammostock( currentweapon, currentstockammo - var_bbc21d630608de47 );
                }
                
                if ( var_3bfcf90943caa6b3 > 0 )
                {
                    var_bbc21d630608de47 = int( maxclipammo * reloadpercent );
                    var_bbc21d630608de47 = var_bbc21d630608de47 > reloadmax ? reloadmax : var_bbc21d630608de47;
                    
                    if ( var_bbc21d630608de47 > var_3bfcf90943caa6b3 )
                    {
                        var_bbc21d630608de47 = var_3bfcf90943caa6b3;
                    }
                    
                    if ( currentclipammo < maxclipammo )
                    {
                        amountmissing = maxclipammo - currentclipammo;
                        
                        if ( currentclipammo + var_bbc21d630608de47 > maxclipammo )
                        {
                            var_bbc21d630608de47 = amountmissing;
                        }
                        
                        self setweaponammoclip( currentweapon, currentclipammo + var_bbc21d630608de47 );
                        self setweaponammostock( currentweapon, var_3bfcf90943caa6b3 - var_bbc21d630608de47 );
                    }
                }
                
                return;
            }
            
            if ( var_bbc21d630608de47 > currentstockammo )
            {
                var_bbc21d630608de47 = currentstockammo;
            }
            
            if ( currentclipammo < maxclipammo )
            {
                amountmissing = maxclipammo - currentclipammo;
                
                if ( currentclipammo + var_bbc21d630608de47 > maxclipammo )
                {
                    var_bbc21d630608de47 = amountmissing;
                }
                
                self setweaponammoclip( currentweapon, currentclipammo + var_bbc21d630608de47 );
                self setweaponammostock( currentweapon, currentstockammo - var_bbc21d630608de47 );
            }
        }
    }
}

// Namespace shadow_rift_common
// Params 0
// Checksum 0x4106910a, Offset: 0x3755
// Size: 0xc3
function function_69287c66c1bbed9b()
{
    self notify( #"shadow_rift_stop_effect" );
    cleanup_vortex();
    function_40976eb11a890682();
    
    foreach ( agent in self.var_1d5644f532a9c8d3 )
    {
        if ( function_e7523d3855a04364( agent ) )
        {
            agent reset_agent();
            agent.skipdeathcount = 1;
            agent.nocorpse = 1;
            agent kill();
        }
    }
}

// Namespace shadow_rift_common
// Params 0, eflags: 0x4
// Checksum 0xb2082468, Offset: 0x3820
// Size: 0x1c
function private cleanup_vortex()
{
    if ( self.vortex )
    {
        self.vortex freescriptable();
    }
}

// Namespace shadow_rift_common
// Params 0, eflags: 0x4
// Checksum 0x2448397b, Offset: 0x3844
// Size: 0x96
function private function_40976eb11a890682()
{
    if ( isdefined( self.var_6edfc3ea4d5bf1ca ) )
    {
        foreach ( movehelper in self.var_6edfc3ea4d5bf1ca )
        {
            if ( isdefined( movehelper ) )
            {
                movehelper delete();
            }
        }
        
        self.var_6edfc3ea4d5bf1ca = undefined;
    }
}

// Namespace shadow_rift_common
// Params 2, eflags: 0x4
// Checksum 0xc912342e, Offset: 0x38e2
// Size: 0x54, Type: bool
function private function_e7523d3855a04364( agent, var_d5a0b16c335fa049 = 0 )
{
    if ( !agent || !isalive( agent ) )
    {
        return false;
    }
    
    if ( var_d5a0b16c335fa049 )
    {
        return true;
    }
    
    return !agent.magic_bullet_shield && !agent.damageshield;
}

// Namespace shadow_rift_common
// Params 1, eflags: 0x4
// Checksum 0x5fed7861, Offset: 0x393f
// Size: 0x31
function private get_agent_tier( var_31389415574c377f )
{
    return var_31389415574c377f.var_2a910b69b3bb40ff ? self [[ var_31389415574c377f.var_2a910b69b3bb40ff ]]() : ai_utility::get_ai_tier();
}

