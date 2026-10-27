// scripts\mp\augments\deadwire_augments.gsc  (hash_5318bf47136c0e25.gscc) (size: 11389 Bytes / 0x2c7d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd0d21187 (3503427975)
// size ...... 11389 (0x2c7d)
// includes .. 12  (offset: 0x2a11)
// strings ... 36  (offset: 0x2a71)
// dev strs .. 0   (offset: 0x2c7d)
// exports ... 17  (offset: 0x1da5)
// cseg ...... 0x326 + 0x1a7f (0x1da5)
// imports ... 80  (offset: 0x204d)
// animtree1 . 0   (offset: 0x2c7d)
// animtree2 . 0   (offset: 0x2c7d)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\ai_utility;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\status_effects\effect_stun;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\ammomods\deadwire;

#namespace zombie_augments;

// Namespace zombie_augments
// Params 0, eflags: 0x5
// Checksum 0x341e10fa, Offset: 0x344
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"deadwire_augments", undefined, &init_deadwire_augments, undefined );
}

// Namespace zombie_augments
// Params 0
// Checksum 0x903255a3, Offset: 0x365
// Size: 0x173
function init_deadwire_augments()
{
    if ( !level.zombie_augments_in_use )
    {
        return;
    }
    
    var_d026fba7f85341e1 = level.zombie_augments[ #"deadwire_chain_lightning" ].var_9c428a695fb1a65c;
    
    if ( isdefined( var_d026fba7f85341e1 ) )
    {
        level._effect[ "chain_lightning_bolt" ] = loadfxasset( var_d026fba7f85341e1 );
    }
    
    lightning_strike_vfx = level.zombie_augments[ #"deadwire_lightning_strike" ].var_9c428a695fb1a65c;
    
    if ( isdefined( lightning_strike_vfx ) )
    {
        level._effect[ "lightning_strike" ] = loadfxasset( lightning_strike_vfx );
    }
    
    if ( !isdefined( level.deadwire_ball_lightning_contents ) )
    {
        content = [ "physicscontents_edge", "physicscontents_glass", "physicscontents_water", "physicscontents_missileclip", "physicscontents_item", "physicscontents_itemclip", "physicscontents_clipshot", "physicscontents_characterproxy", "physicscontents_playerclip" ];
        level.deadwire_ball_lightning_contents = physics_createcontents( content );
    }
    
    callback::add( "deadwire_stunned", &on_deadwire_stunned );
    callback::add( "deadwire_end", &on_deadwire_end );
    callback::add( "deadwire_orb_end", &on_deadwire_orb_end );
    callback::add( "deadwire_orb_created", &on_deadwire_orb_created );
    utility::registersharedfunc( #"zm", #"on_deadwire_lightning_strike", &on_deadwire_lightning_strike );
}

// Namespace zombie_augments
// Params 1, eflags: 0x4
// Checksum 0xe9993ce3, Offset: 0x4e0
// Size: 0x91
function private on_deadwire_orb_created( params )
{
    if ( isplayer( params.attacker ) )
    {
        thread function_4938a76e567318f8( params );
    }
    
    if ( isplayer( params.attacker ) && params.attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"deadwire_ball_lightning" ) )
    {
        thread deadwire_ball_lightning_move( params.attacker, params.zombie, params.vpoint );
    }
}

// Namespace zombie_augments
// Params 3, eflags: 0x4
// Checksum 0x583696e0, Offset: 0x579
// Size: 0x22c
function private deadwire_ball_lightning_move( player, zombie, vpoint )
{
    self endon( #"death" );
    
    if ( isdefined( zombie ) )
    {
        dir = zombie.origin - player.origin;
    }
    else if ( isdefined( vpoint ) )
    {
        dir = vpoint - player getcentroid();
    }
    else
    {
        dir = self.origin - player.origin;
    }
    
    groundpos = getgroundposition( self.origin, 1 );
    groundpos = ( groundpos[ 0 ], groundpos[ 1 ], groundpos[ 2 ] + 64 );
    self.origin = groundpos;
    dir = vectornormalize( dir );
    dir = ( dir[ 0 ], dir[ 1 ], 0 );
    last_update_time = gettime();
    
    while ( isdefined( self ) )
    {
        cur_time = gettime();
        delta_time = cur_time - last_update_time;
        
        if ( delta_time > 0 )
        {
            last_update_time = cur_time;
            nextpos = self.origin + dir * 30 / delta_time;
            var_ab26527ca6237708 = getaiarray();
            deadwire_orbs = getentarray( "deadwire_orb", "targetname" );
            ignoreents = arraycombine( deadwire_orbs, var_ab26527ca6237708 );
            ignoreents = arraycombine( level.players, ignoreents );
            traceresults = trace::sphere_trace( nextpos, nextpos, 16, ignoreents, level.deadwire_ball_lightning_contents, undefined, 1 );
            
            if ( traceresults[ "fraction" ] < 1 )
            {
                impactnormal = ( traceresults[ "normal" ] ?? dir ) * 1.57;
                
                if ( impactnormal[ 2 ] <= 0 )
                {
                    v_reflect = dir - 2 * vectordot( dir, impactnormal ) * impactnormal;
                    v_reflect = vectornormalize( v_reflect );
                    dir = v_reflect;
                }
                else
                {
                    dir *= -1;
                }
                
                self.origin += dir * 30 / delta_time;
            }
            else
            {
                self.origin += dir * 30 / delta_time;
            }
        }
        
        waitframe();
    }
}

// Namespace zombie_augments
// Params 1
// Checksum 0xb2c3a78e, Offset: 0x7ad
// Size: 0x53
function function_4938a76e567318f8( params )
{
    if ( params.var_2712320395f4ae2 || params.attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"deadwire_chain_lightning" ) )
    {
        on_deadwire_chain_lightning( params );
    }
}

// Namespace zombie_augments
// Params 1, eflags: 0x4
// Checksum 0xc6a1eeba, Offset: 0x808
// Size: 0xf4
function private on_deadwire_stunned( params )
{
    if ( !isplayer( params.attacker ) )
    {
        return;
    }
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( params.var_9f3ca9dcada2e0ef )
    {
        return;
    }
    
    if ( params.attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"hash_20438e41b7109065" ) )
    {
        function_5032dad5ac97b7a4( params.death, params.attacker, params.mod, params.sweapon, params.vpoint, params.shitloc, params.modelindex );
    }
    
    if ( params.attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"deadwire_lightning_strike" ) )
    {
        on_deadwire_lightning_strike( params );
    }
}

// Namespace zombie_augments
// Params 1, eflags: 0x4
// Checksum 0x3154173f, Offset: 0x904
// Size: 0x5ca
function private on_deadwire_lightning_strike( params )
{
    level endon( #"game_ended" );
    
    if ( !isplayer( params.attacker ) || !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( level.deadwire_lightning_strike_throttle ) )
    {
        level.deadwire_lightning_strike_throttle = throttle::throttle_initialize( "deadwire_lightning_strike", 1, level.framedurationseconds );
    }
    
    player = params.attacker;
    lightning_strike_scriptable = spawnscriptable( "ammomod_proc_deadwire_lightning_strike", self.origin );
    playsoundatpos( self.origin + ( 0, 0, 75 ), #"hash_f55d02ed9cf27f90" );
    radius = level.zombie_augments[ #"deadwire_lightning_strike" ].var_901a5f8724e17b24 ?? 500;
    zombies = getaiarrayinradius( self.origin, radius );
    zombie_health_bundle = level.gametypebundle.var_e039e3d3a8e46ee6 ?? "health_zombie_base";
    roundnumber = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
    base_zombie_maxhealth = namespace_9d8e359c3b1041e5::function_bb9b98eb7368a15a( zombie_health_bundle, roundnumber );
    var_acc753cf42a616aa = level.zombie_augments[ #"deadwire_lightning_strike" ].var_960a7c304b01eb3d ?? 0.2;
    var_12f063abe7d4b368 = level.zombie_augments[ #"deadwire_lightning_strike" ].var_db25e7202fb3bb57 ?? 0.1;
    strikedamage = int( base_zombie_maxhealth * var_acc753cf42a616aa );
    stundamage = int( base_zombie_maxhealth * var_12f063abe7d4b368 );
    stunduration = level.zombie_augments[ #"deadwire_lightning_strike" ].var_83dd17a5fc6725eb ?? 2;
    
    if ( params.attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"deadwire_extension" ) )
    {
        stunduration += stunduration * ( level.zombie_augments[ #"deadwire_extension" ].var_884fee97f4c95bc7 ?? 0.5 );
    }
    
    if ( params.attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"deadwire_damage_boost" ) )
    {
        strikedamage += int( strikedamage * ( level.zombie_augments[ #"deadwire_damage_boost" ].var_e3d0eb79fd6fe167 ?? 0.1 ) );
        stundamage += int( stundamage * ( level.zombie_augments[ #"deadwire_damage_boost" ].var_e3d0eb79fd6fe167 ?? 0.1 ) );
    }
    
    nearbyplayers = getplayersinradius( self.origin, 500 );
    
    foreach ( nearbyplayer in nearbyplayers )
    {
        nearbyplayer playrumbleonentity( "damage_light" );
        nearbyplayer earthquakeforplayer( 0.5, 0.75, self.origin, 500 );
    }
    
    foreach ( zombie in zombies )
    {
        if ( !isalive( zombie ) || zombie.team == player.team || isdefined( zombie.takedamage ) && !zombie.takedamage )
        {
            continue;
        }
        
        if ( player && utility::issharedfuncdefined( #"zm", #"hash_8e5cbc74839b479b" ) )
        {
            if ( !level [[ utility::getsharedfunc( #"zm", #"hash_8e5cbc74839b479b" ) ]]( player, zombie ) )
            {
                continue;
            }
        }
        
        if ( !zombie.magic_bullet_shield && !zombie.damageshield )
        {
            target_ai_tier = zombie ai_utility::get_ai_tier();
            zombie deadwire::check_scoreevent( strikedamage );
            zombie dodamage( strikedamage, zombie.origin, player, player, "MOD_ELEMENTAL_ELEC", params.sweapon, undefined, undefined, 536936448 );
            var_c6c7e49bbf95d83d = 0;
            
            if ( strikedamage >= zombie.health )
            {
                var_c6c7e49bbf95d83d = 1;
            }
            
            if ( ( target_ai_tier == 1 || target_ai_tier == 2 ) && !zombie utility::ent_flag( "deadwire_stunned" ) && !zombie is_ai_stunned() && isalive( zombie ) && zombie.health > 0 && !var_c6c7e49bbf95d83d )
            {
                zombie effect_stun::stun( "deadwire_lightning_strike", stunduration, player, undefined, undefined, "electrical" );
                zombie utility::ent_flag_set( "deadwire_stunned" );
                zombie thread lightning_strike_damage_thread( stundamage, player, params.sweapon );
                zombie thread function_1e0814637a0379c9();
            }
        }
        
        throttle::throttle_wait_in_queue( level.deadwire_lightning_strike_throttle, player );
    }
    
    wait 1;
    
    if ( isdefined( lightning_strike_scriptable ) )
    {
        lightning_strike_scriptable freescriptable();
    }
}

// Namespace zombie_augments
// Params 0, eflags: 0x4
// Checksum 0x41838d08, Offset: 0xed6
// Size: 0x41
function private function_1e0814637a0379c9()
{
    self endon( #"death" );
    deadwire::function_b63bfe497fdd29a5();
    callback::callback( "shocked" );
    
    while ( is_ai_stunned() )
    {
        waitframe();
    }
    
    deadwire::function_6c9041f038ca75a5();
    callback::callback( "shocked_end" );
}

// Namespace zombie_augments
// Params 3, eflags: 0x4
// Checksum 0x8da6a612, Offset: 0xf1f
// Size: 0x98
function private lightning_strike_damage_thread( stundamage, player, sweapon )
{
    self endon( #"death" );
    
    while ( isalive( self ) && is_ai_stunned() && !self.magic_bullet_shield && !self.damageshield )
    {
        deadwire::check_scoreevent( stundamage );
        self dodamage( stundamage, self.origin, player, player, "MOD_ELEMENTAL_ELEC", sweapon, undefined, undefined, 536936448 );
        wait 1;
    }
    
    utility::ent_flag_clear( "deadwire_stunned" );
}

// Namespace zombie_augments
// Params 1
// Checksum 0xec91feae, Offset: 0xfbf
// Size: 0x52e
function on_deadwire_chain_lightning( params )
{
    self endon( #"death" );
    
    if ( !isai( params.zombie ) )
    {
        return;
    }
    
    zombie = params.zombie;
    
    if ( zombie.var_6b869a91288da75f )
    {
        zombie.var_6b869a91288da75f = 0;
        return;
    }
    
    enemyai = getaiarrayinradius( self.origin, level.zombie_augments[ #"deadwire_chain_lightning" ].var_871b4e2b1d59c826 ?? 256 );
    
    foreach ( enemy in enemyai )
    {
        if ( !isalive( enemy ) || enemy.team == self.owner.team || isdefined( enemy.takedamage ) && !enemy.takedamage )
        {
            continue;
        }
        
        if ( self.owner && utility::issharedfuncdefined( #"zm", #"hash_8e5cbc74839b479b" ) )
        {
            if ( !level [[ utility::getsharedfunc( #"zm", #"hash_8e5cbc74839b479b" ) ]]( self.owner, enemy ) )
            {
                continue;
            }
        }
        
        if ( !enemy utility::ent_flag( "deadwire_stunned" ) && enemy != zombie && !enemy zombie_utils::function_bf1464d09f4e4b40() )
        {
            var_e2df0ee6ef993eb = enemy;
            break;
        }
    }
    
    var_73f48f1e926fe99e = level.zombie_augments[ #"deadwire_chain_lightning" ].var_ccaa993412c0d42f ?? 3;
    originzombie = zombie;
    var_3abb9f22b65c2916 = self;
    originchain = self.origin;
    
    for ( i = 0; i < var_73f48f1e926fe99e ; i++ )
    {
        if ( isdefined( var_e2df0ee6ef993eb ) )
        {
            start_point = originchain;
            
            if ( isalive( originzombie ) )
            {
                start_point = originzombie gettagorigin( "j_spine4", 1 ) ?? originchain;
            }
            
            originzombie = var_e2df0ee6ef993eb;
            var_3abb9f22b65c2916 = var_e2df0ee6ef993eb;
            originchain = var_e2df0ee6ef993eb.origin;
            var_3abb9f22b65c2916 thread function_94dda606b4a69149( start_point, var_e2df0ee6ef993eb, 0.15 );
            var_3abb9f22b65c2916 waittill( #"hash_db96ceadb4c31a63" );
            
            if ( isalive( var_e2df0ee6ef993eb ) )
            {
                var_e2df0ee6ef993eb.var_6b869a91288da75f = 1;
                var_e2df0ee6ef993eb.var_e137d49f289f0726 = level.zombie_augments[ #"deadwire_chain_lightning" ].var_141b0936f3a11396 ?? 0.5;
                
                if ( params.var_9f3ca9dcada2e0ef )
                {
                    var_e2df0ee6ef993eb deadwire::function_97d4335963cfad58( params.death, params.attacker, params.mod, params.sweapon, params.vpoint, params.shitloc, params.modelindex, params.var_2712320395f4ae2 );
                }
                else
                {
                    result_params = { #modelindex:params.modelindex, #shitloc:params.shitloc, #vpoint:params.vpoint, #sweapon:params.sweapon, #mod:params.mod, #attacker:params.attacker, #death:params.death };
                    var_e2df0ee6ef993eb deadwire::function_da9e946cbc502a41( result_params );
                }
                
                if ( isdefined( var_e2df0ee6ef993eb.deadwireorb ) )
                {
                    var_3abb9f22b65c2916 = var_e2df0ee6ef993eb.deadwireorb;
                }
            }
        }
        
        enemyai = getaiarrayinradius( originchain, level.zombie_augments[ #"deadwire_chain_lightning" ].var_871b4e2b1d59c826 ?? 256 );
        
        foreach ( enemy in enemyai )
        {
            if ( !isalive( enemy ) || enemy.team == self.owner.team || isdefined( enemy.takedamage ) && !enemy.takedamage )
            {
                continue;
            }
            
            if ( !enemy utility::ent_flag( "deadwire_stunned" ) && enemy != var_e2df0ee6ef993eb && !enemy zombie_utils::function_bf1464d09f4e4b40() )
            {
                var_e2df0ee6ef993eb = enemy;
                break;
            }
        }
        
        wait 0.2;
    }
}

// Namespace zombie_augments
// Params 3
// Checksum 0xd265a290, Offset: 0x14f5
// Size: 0x105
function function_94dda606b4a69149( start_point, ai_target, arc_travel_time )
{
    end_point = function_6e9b2982148bc1a2( ai_target );
    
    if ( !isdefined( end_point ) )
    {
        self notify( #"hash_db96ceadb4c31a63" );
        return;
    }
    
    var_a542a8f69a73e0fa = utility::spawn_tag_origin( start_point );
    var_a542a8f69a73e0fa show();
    bolt_fx = "chain_lightning_bolt";
    
    if ( isdefined( level._effect[ bolt_fx ] ) )
    {
        fx = playfxontag( level._effect[ bolt_fx ], var_a542a8f69a73e0fa, "tag_origin" );
    }
    
    while ( distance2d( var_a542a8f69a73e0fa.origin, end_point ) > 30 )
    {
        var_a542a8f69a73e0fa moveto( end_point, 0.15 );
        var_a542a8f69a73e0fa waittill( #"movedone" );
        
        if ( isalive( ai_target ) )
        {
            end_point = function_6e9b2982148bc1a2( ai_target );
        }
        else
        {
            break;
        }
        
        wait 0.5;
    }
    
    self notify( #"hash_db96ceadb4c31a63" );
    var_a542a8f69a73e0fa delete();
}

// Namespace zombie_augments
// Params 1
// Checksum 0x88744e31, Offset: 0x1602
// Size: 0x39
function function_6e9b2982148bc1a2( ai_target )
{
    end_point = ai_target gettagorigin( "j_spine4", 1 );
    
    if ( !isdefined( end_point ) )
    {
        end_point = ai_target.origin;
    }
    
    return end_point;
}

// Namespace zombie_augments
// Params 7, eflags: 0x4
// Checksum 0x8337da47, Offset: 0x1644
// Size: 0x41b
function private function_5032dad5ac97b7a4( death, attacker, mod, sweapon, vpoint, shitloc, modelindex )
{
    self endon( #"death" );
    var_65614d559662e52e = level.var_b7d9d7926154819d.ammomodbundles[ "deadwire" ].var_d208127147eabcce ?? 128;
    var_d67a8371ebe34343 = level.var_b7d9d7926154819d.ammomodbundles[ "deadwire" ].var_51d66b79243599fd ?? 0.01;
    var_64c3057772e890e3 = level.var_b7d9d7926154819d.ammomodbundles[ "deadwire" ].var_1f56a5bf31d3ae89 ?? 0.005;
    var_45b783e266e7e358 = level.var_b7d9d7926154819d.ammomodbundles[ "deadwire" ].var_a9ad3c62dfcc8a47 ?? 0.05;
    var_ea1307f000be7508 = level.var_b7d9d7926154819d.ammomodbundles[ "deadwire" ].var_9372fcf1a8535a8 ?? 0.2;
    var_dbc8e7e019acc253 = level.var_b7d9d7926154819d.ammomodbundles[ "deadwire" ].var_6190324ede7a1773 ?? 0.025;
    str_source_team = self.team;
    
    while ( gettime() < self.deadwire_end_time )
    {
        playfxontag( utility::getfx( "vfx_perk_dw_aoe_exp" ), self, "j_spine4" );
        var_e5f8ff6069bd05f1 = getaiarrayinradius( self.origin, var_65614d559662e52e );
        
        foreach ( zombie in var_e5f8ff6069bd05f1 )
        {
            if ( !isalive( zombie ) || zombie.team != str_source_team )
            {
                continue;
            }
            
            target_ai_tier = zombie ai_utility::get_ai_tier();
            
            if ( target_ai_tier == 2 )
            {
                var_be54cac8928065d0 = int( zombie.maxhealth * var_d67a8371ebe34343 );
            }
            else if ( target_ai_tier == 3 )
            {
                var_be54cac8928065d0 = int( zombie.maxhealth * var_64c3057772e890e3 );
            }
            else if ( isdefined( zombie.subclass ) && issubstr( zombie.subclass, "warlord" ) )
            {
                var_be54cac8928065d0 = int( zombie.maxhealth * var_64c3057772e890e3 );
            }
            else
            {
                var_be54cac8928065d0 = int( zombie.maxhealth * var_45b783e266e7e358 );
            }
            
            if ( attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"deadwire_damage_boost" ) )
            {
                var_be54cac8928065d0 += int( var_be54cac8928065d0 * ( level.zombie_augments[ #"deadwire_damage_boost" ].var_e3d0eb79fd6fe167 ?? 0.1 ) );
            }
            
            zombie val::set( "deadwire", "pain", 0 );
            
            if ( !zombie.magic_bullet_shield && !zombie.damageshield )
            {
                zombie deadwire::check_scoreevent( var_be54cac8928065d0 );
                zombie dodamage( var_be54cac8928065d0, zombie.origin, attacker, attacker, "MOD_ELEMENTAL_ELEC", sweapon, "none", undefined, 536936448 );
            }
            
            zombie val::reset( "deadwire", "pain" );
        }
        
        throttle::throttle_wait_in_queue( level.var_9a52e467395c0c0e, self );
    }
    
    params = spawnstruct();
    params.attacker = attacker;
    callback::callback( "shocked_end", params );
}

// Namespace zombie_augments
// Params 1, eflags: 0x4
// Checksum 0xa6944357, Offset: 0x1a67
// Size: 0x2ca
function private on_deadwire_orb_end( params )
{
    if ( isplayer( params.attacker ) && !self.var_3459569f97557c2f && params.attacker utility::callsharedfunc( #"zombie", #"player_has_augment", #"deadwire_aftershock" ) )
    {
        var_eac70aafdbc51fed = level.zombie_augments[ #"deadwire_aftershock" ].var_eac70aafdbc51fed ?? 0.33;
        var_eac70aafdbc51fed *= 100;
        var_d87d6fb54f9e98df = level.zombie_augments[ #"deadwire_aftershock" ].var_d87d6fb54f9e98df ?? 3;
        var_65614d559662e52e = level.var_b7d9d7926154819d.ammomodbundles[ "deadwire" ].var_d208127147eabcce ?? 128;
        zombies = getaiarrayinradius( self.origin, var_65614d559662e52e );
        
        if ( !isdefined( self.aftershockcount ) )
        {
            self.aftershockcount = 0;
        }
        
        if ( self.aftershockcount < var_d87d6fb54f9e98df )
        {
            foreach ( zombie in zombies )
            {
                if ( params.attacker && utility::issharedfuncdefined( #"zm", #"hash_8e5cbc74839b479b" ) )
                {
                    if ( !level [[ utility::getsharedfunc( #"zm", #"hash_8e5cbc74839b479b" ) ]]( params.attacker, zombie ) )
                    {
                        continue;
                    }
                }
                
                if ( utility::percent_chance( var_eac70aafdbc51fed ) && !zombie zombie_utils::function_bf1464d09f4e4b40() && zombie.team != params.attacker.team )
                {
                    self.aftershockcount++;
                    result_params = { #var_3459569f97557c2f:1, #modelindex:undefined, #shitloc:"none", #vpoint:zombie.origin, #sweapon:"<explicitweaponnone>", #mod:"MOD_ELEMENTAL_ELEC", #attacker:params.attacker, #death:params.death };
                    zombie thread deadwire::function_da9e946cbc502a41( result_params );
                    break;
                }
            }
        }
    }
}

// Namespace zombie_augments
// Params 1, eflags: 0x4
// Checksum 0x550f4d2d, Offset: 0x1d39
// Size: 0x2d
function private on_deadwire_end( params )
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( isdefined( self.var_e137d49f289f0726 ) )
    {
        self.var_e137d49f289f0726 = undefined;
    }
}

// Namespace zombie_augments
// Params 0, eflags: 0x4
// Checksum 0x345b8f4d, Offset: 0x1d6e
// Size: 0x37
function private is_ai_stunned()
{
    if ( self.type == "zombie" )
    {
        return zombie_stun::is_stunned();
    }
    
    return gettime() < self._blackboard.shockedendtime;
}

