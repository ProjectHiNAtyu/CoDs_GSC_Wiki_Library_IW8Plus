// scripts\mp\ob\skills\skill_valkyrie.gsc  (hash_3c728bafbfd264a0.gscc) (size: 9432 Bytes / 0x24d8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc6810db9 (3330346425)
// size ...... 9432 (0x24d8)
// includes .. 9   (offset: 0x2350)
// strings ... 18  (offset: 0x2398)
// dev strs .. 8   (offset: 0x2478)
// exports ... 22  (offset: 0x1694)
// cseg ...... 0x13f + 0x1555 (0x1694)
// imports ... 80  (offset: 0x1a04)
// animtree1 . 0   (offset: 0x24d8)
// animtree2 . 0   (offset: 0x24d8)
#using script_16ea1b94f0f381b3;
#using script_2fe74ee229c972c3;
#using scripts\common\ai;
#using scripts\common\damage_effects;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\weapons;

#namespace skill_valkyrie;

// Namespace skill_valkyrie
// Params 0, eflags: 0x1
// Checksum 0x2d4837f5, Offset: 0x15d
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"valkyrie", &init );
}

// Namespace skill_valkyrie
// Params 0
// Checksum 0x51f9dacf, Offset: 0x17c
// Size: 0xb8
function init()
{
    utility::registersharedfunc( #"valkyrie", #"hash_f89602d29c289ca4", &function_1321989bae991e4f );
    utility::registersharedfunc( #"valkyrie", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"valkyrie", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
    utility::registersharedfunc( #"valkyrie", #"hash_8698c290a2e85469", &get_skill_weapons );
    weapons::registerusedcallback( "valkyrie_grenade", &weapon_used );
    
    /#
        namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_492a1568a847cc40", &function_4903043576843e8b );
        namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_deffdc1caf7d89fd", &function_7c8def2435280b18 );
    #/
}

// Namespace skill_valkyrie
// Params 1, eflags: 0x4
// Checksum 0xf23f7d6e, Offset: 0x23c
// Size: 0x140
function private function_1321989bae991e4f( skill_bundle )
{
    if ( skill_bundle.var_a2b32c29aecde6fa )
    {
        skill_bundle.var_d3e3858d329e7497 = [];
        
        foreach ( valkyrie_vfx_position in skill_bundle.var_a2b32c29aecde6fa )
        {
            angle = valkyrie_vfx_position.var_b4a48c5e30abf8de ?? 0;
            offset = valkyrie_vfx_position.var_64937bf3b4e799ec ?? 0;
            x = cos( angle ) * offset;
            y = sin( angle ) * offset;
            skill_bundle.var_d3e3858d329e7497[ skill_bundle.var_d3e3858d329e7497.size ] = ( x, y, 0 );
        }
    }
    
    if ( skill_bundle.var_204c3c1a8b3a7aa2 )
    {
        skill_bundle.var_70279050d6dd40ac = skill_bundle.var_204c3c1a8b3a7aa2 * skill_bundle.var_204c3c1a8b3a7aa2;
    }
}

// Namespace skill_valkyrie
// Params 1, eflags: 0x4
// Checksum 0x3f2e8204, Offset: 0x384
// Size: 0xcd, Type: bool
function private on_give_skill( skill_bundle )
{
    self.var_f3e6c12d6b50229a = { #oncooldown:0 };
    assert( skill_bundle.var_2f6c2aef13e4b0e9, "<dev string:x24>" + skill_bundle.skilllevel );
    assert( skill_bundle.var_204c3c1a8b3a7aa2 < skill_bundle.var_3c315dc341bfac14, "<dev string:x57>" );
    
    /#
        if ( skill_bundle.var_7427ca8d171a6d7f && !self tagexists( skill_bundle.var_7427ca8d171a6d7f ) )
        {
            assertmsg( "<dev string:x82>" + skill_bundle.var_7427ca8d171a6d7f + "<dev string:x87>" + skill_bundle.skilllevel );
        }
    #/
    
    thread monitor_wingsuit( skill_bundle, self.var_f3e6c12d6b50229a );
    return true;
}

// Namespace skill_valkyrie
// Params 1, eflags: 0x4
// Checksum 0xeb8e4ac9, Offset: 0x45a
// Size: 0x2a
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self notify( #"end_valkyrie" );
    self.var_f3e6c12d6b50229a = undefined;
    function_5b6cc3fe61c2b7f0( 0 );
}

// Namespace skill_valkyrie
// Params 1, eflags: 0x4
// Checksum 0x763cc5ad, Offset: 0x48c
// Size: 0x1c
function private get_skill_weapons( skill_bundle )
{
    return [ skill_bundle.valkyriegrenadeweapon ];
}

// Namespace skill_valkyrie
// Params 2, eflags: 0x4
// Checksum 0x57895660, Offset: 0x4b1
// Size: 0x3c
function private function_5b6cc3fe61c2b7f0( enable, instant )
{
    self setscriptablepartstate( "valkyrie_fx", enable ? "enabled" : "disabled" );
    set_wingsuit_vfx( !enable );
}

// Namespace skill_valkyrie
// Params 1, eflags: 0x4
// Checksum 0xba8c95ee, Offset: 0x4f5
// Size: 0x94
function private set_wingsuit_vfx( enable )
{
    if ( !self iswingsuitdeployed() )
    {
        return;
    }
    
    if ( !level.var_bb86f77304f193c4.wingsuitdata.scriptablepart )
    {
        return;
    }
    
    state = enable ? level.var_bb86f77304f193c4.wingsuitdata.var_f5aa4014b0fe262c : "off";
    self setscriptablepartstate( level.var_bb86f77304f193c4.wingsuitdata.scriptablepart, state, 0 );
}

// Namespace skill_valkyrie
// Params 2, eflags: 0x4
// Checksum 0x9603c0a, Offset: 0x591
// Size: 0x60
function private monitor_wingsuit( bundle, var_da55798eb12048a0 )
{
    self endon( #"disconnect", #"end_valkyrie" );
    
    while ( true )
    {
        self waittill( #"wingsuit_begin" );
        childthread monitor_grenade_throw( bundle, var_da55798eb12048a0 );
        self waittill( #"wingsuit_end" );
        function_5b6cc3fe61c2b7f0( 0, 1 );
    }
}

// Namespace skill_valkyrie
// Params 2, eflags: 0xc
// Checksum 0xbddf0f9a, Offset: 0x5f9
// Size: 0x43f
function private monitor_grenade_throw( bundle, var_da55798eb12048a0 )
{
    self notify( #"hash_2718667053c2dd46" );
    self endon( #"hash_2718667053c2dd46" );
    self endon( #"wingsuit_end" );
    var_6a60d15d10bd5883 = 0;
    valkyrie_on_player = 0;
    
    while ( true )
    {
        if ( var_da55798eb12048a0.oncooldown )
        {
            waitframe();
            continue;
        }
        
        start = self.origin;
        end = start - ( 0, 0, bundle.var_3c315dc341bfac14 ?? 0 );
        var_74c601fd3cd26c5d = trace::create_contents( 0, 1, 0, 0, 1 );
        trace_result = trace::ray_trace( start, end, undefined, var_74c601fd3cd26c5d );
        var_6a60d15d10bd5883 = trace_result[ "hittype" ] != "hittype_none" && distancesquared( start, trace_result[ "position" ] ) >= ( bundle.var_70279050d6dd40ac ?? 0 );
        
        if ( bundle.var_b25a4d69d2588f46 && var_6a60d15d10bd5883 )
        {
            var_1ee22348ced85e75 = utility::drop_to_ground( self.origin );
            ai_in_radius = getaiarrayinradius( var_1ee22348ced85e75, bundle.var_b25a4d69d2588f46 );
            var_4181133b64550dd7 = [];
            
            foreach ( ai in ai_in_radius )
            {
                if ( ai.origin[ 2 ] <= self.origin[ 2 ] )
                {
                    var_4181133b64550dd7[ var_4181133b64550dd7.size ] = ai;
                }
            }
            
            var_6a60d15d10bd5883 = var_4181133b64550dd7.size > 0;
            
            /#
                if ( getdvarint( @"hash_61cd72a74446bc26", 0 ) )
                {
                    var_6a60d15d10bd5883 = 1;
                }
            #/
        }
        
        if ( valkyrie_on_player != var_6a60d15d10bd5883 )
        {
            valkyrie_on_player = var_6a60d15d10bd5883;
            function_5b6cc3fe61c2b7f0( valkyrie_on_player );
        }
        
        if ( var_6a60d15d10bd5883 )
        {
            static_forward_offset = bundle.var_e81f176ee4e670af ?? 0;
            var_bced11f5318629ee = bundle.var_dbe5ecc4e87cd56e ?? 0;
            var_7527c657f605d1a4 = bundle.var_f881f505bd8f53c8 ?? 0;
            
            for ( grenade_counter = 0; grenade_counter < bundle.var_a46ec6c7fde9280c ; grenade_counter++ )
            {
                spawn_position = ( bundle.var_7427ca8d171a6d7f ? self gettagorigin( bundle.var_7427ca8d171a6d7f ) : self.origin ) + ( 0, 0, bundle.var_d6006fd31642b228 ?? 0 );
                forward_offset = static_forward_offset;
                
                if ( var_bced11f5318629ee > 0 )
                {
                    var_1ee22348ced85e75 = utility::drop_to_ground( self.origin );
                    height = self.origin[ 2 ] - var_1ee22348ced85e75[ 2 ];
                    height_clamp = clamp( height, var_bced11f5318629ee, var_7527c657f605d1a4 );
                    frac = ( height_clamp - var_bced11f5318629ee ) / ( var_7527c657f605d1a4 - var_bced11f5318629ee );
                    forward_offset = math::lerp( bundle.var_6ae6ac8d4809c945 ?? 0, static_forward_offset, frac );
                }
                
                forward = vectornormalize( math::vector_project_onto_plane( anglestoforward( self getplayerangles() ), ( 0, 0, 1 ) ) );
                impact_position = utility::drop_to_ground( spawn_position ) + forward * forward_offset;
                grenade_speed = vectornormalize( impact_position - spawn_position ) * ( bundle.var_537434b2cc832ce ?? 0 );
                
                /#
                    if ( getdvarint( @"hash_afe9809541cb48fe", 0 ) )
                    {
                        line( spawn_position, impact_position, ( 0, 1, 0 ), 1, 0, 300 );
                        sphere( impact_position, 50, ( 1, 0, 0 ), 0, 300 );
                    }
                #/
                
                function_6a60d15d10bd5883( bundle.valkyriegrenadeweapon, spawn_position, grenade_speed, bundle );
                wait bundle.var_2f689e5c85467908 ?? 0;
            }
        }
        
        var_da55798eb12048a0.oncooldown = 1;
        thread monitor_cooldown( var_da55798eb12048a0, bundle.var_3e0eb51d825ad091 ?? 0.1 );
    }
}

// Namespace skill_valkyrie
// Params 4, eflags: 0x4
// Checksum 0xb957bfbc, Offset: 0xa40
// Size: 0x50
function private function_6a60d15d10bd5883( weapon, origin, velocity, bundle )
{
    grenade = magicgrenademanual( weapon, origin, velocity, 0, self );
    
    if ( bundle )
    {
        grenade.var_38fa2975e0fdd7a2 = bundle;
    }
}

// Namespace skill_valkyrie
// Params 2, eflags: 0xc
// Checksum 0x909a9387, Offset: 0xa98
// Size: 0x52
function private monitor_cooldown( var_da55798eb12048a0, cooldown )
{
    self notify( #"hash_16ad734001698c5" );
    self endon( #"hash_16ad734001698c5" );
    self endon( #"disconnect", #"end_valkyrie" );
    wait cooldown;
    var_da55798eb12048a0.oncooldown = 0;
}

// Namespace skill_valkyrie
// Params 1, eflags: 0x4
// Checksum 0xbc6903f2, Offset: 0xaf2
// Size: 0x4c8
function private weapon_used( grenade )
{
    grenade endon( #"death" );
    grenade waittill( #"missile_stuck", stuck_to, hit_part, surface, var_93531e61285eba13, position, var_3cb607c143ecc1a3 );
    ground_normal = var_3cb607c143ecc1a3;
    angles = grenade.angles;
    
    if ( stuck_to )
    {
        result = utility::drop_to_ground( grenade.origin, 0, undefined, undefined, undefined, stuck_to, 1 );
        position = result[ 0 ];
        ground_normal = result[ 1 ];
        angles = math::build_matrix_from_up_and_angles( ground_normal, grenade.angles );
        grenade.origin = position;
        waitframe();
    }
    
    bundle = grenade.var_38fa2975e0fdd7a2;
    grenade setscriptablepartstate( "effects", bundle.var_5d342f7b4002d2cd );
    var_c2a5d39d67459394 = [];
    pool_offsets = bundle.var_d3e3858d329e7497 ?? [ ( 0, 0, 0 ) ];
    
    foreach ( offset in pool_offsets )
    {
        pos_offset = position + offset;
        vector_dot = vectordot( offset, ground_normal );
        spawn_point = pos_offset - vector_dot * ground_normal;
        napalm_scriptable = spawnscriptable( bundle.var_2f6c2aef13e4b0e9, spawn_point, angles );
        napalm_scriptable setscriptablepartstate( "effects", bundle.var_255a0386423b732a );
        var_c2a5d39d67459394[ var_c2a5d39d67459394.size ] = napalm_scriptable;
    }
    
    napalm_radius = bundle.var_39f926b8a714ccc0;
    napalm_damage_trigger = spawn( "trigger_rotatable_radius", position, 1, napalm_radius, bundle.var_162c07edfc488061 );
    napalm_damage_trigger.angles = angles;
    napalm_damage_trigger.entities_inside = [];
    napalm_damage_trigger.weapon_name = grenade.weapon_name;
    napalm_damage_trigger.owner = self;
    napalm_damage_trigger.burn_damage = bundle.var_cef5998a9f3bc35a;
    napalm_damage_trigger.burn_damage_tick = bundle.var_d41f7eec8a260db2 ?? 0.1;
    napalm_damage_trigger.damage_teammates = bundle.var_d4137b08835d24e0;
    
    if ( utility::issharedfuncdefined( #"game", #"makeenterexittrigger" ) )
    {
        [[ utility::getsharedfunc( #"game", #"makeenterexittrigger" ) ]]( napalm_damage_trigger, &function_5538304104699d56, &function_ccf50487ccae0a10 );
    }
    
    bad_place_half_size = ( napalm_radius, napalm_radius, 100 );
    bad_place_id = function_72d497037a6d71fb( position, bad_place_half_size, ( 0, 0, 0 ) );
    
    if ( bundle.var_1e53489cd9316806 )
    {
        flashbang_duration = bundle.var_1e53489cd9316806;
        ai_in_radius = getaiarrayinradius( grenade.origin, napalm_radius );
        
        foreach ( ai in ai_in_radius )
        {
            if ( !player_utility::isfriendly( ai.team ?? ai.agentteam, self ) )
            {
                if ( ai.type == "zombie" )
                {
                    ai utility::callsharedfunc( #"zombie", #"stunZombie", flashbang_duration, "stunned_on" );
                    continue;
                }
                
                ai notify( #"flashbang", ai.origin, 1, undefined, self, self.team, flashbang_duration );
            }
        }
    }
    
    /#
        if ( getdvarint( @"hash_88c8071ea10a17e8" ) )
        {
            sphere( napalm_damage_trigger.origin, napalm_radius, ( 0, 1, 0 ), 0, 150 );
        }
    #/
    
    thread function_957510786680f4b3( var_c2a5d39d67459394, napalm_damage_trigger, bundle.var_4da28f750c9f174e, bad_place_id );
    wait 2;
    
    if ( isdefined( grenade ) )
    {
        grenade delete();
    }
}

// Namespace skill_valkyrie
// Params 2, eflags: 0x4
// Checksum 0x491bc995, Offset: 0xfc2
// Size: 0xf8
function private function_5538304104699d56( entity, trigger )
{
    if ( ( isplayer( entity ) || isagent( entity ) ) && isalive( entity ) )
    {
        if ( !trigger.damage_teammates && player_utility::isfriendly( entity.team ?? entity.agentteam, trigger.owner ) )
        {
            return;
        }
        
        entnum = entity getentitynumber();
        
        if ( !trigger.entities_inside[ entnum ] )
        {
            trigger.entities_inside[ entnum ] = entity;
            entity thread burn_damage( trigger.burn_damage, trigger.burn_damage_tick, trigger.weapon_name, trigger.owner, trigger.origin );
            entity burn_state( trigger.origin );
        }
    }
}

// Namespace skill_valkyrie
// Params 2, eflags: 0x4
// Checksum 0x73d96038, Offset: 0x10c2
// Size: 0x74
function private function_ccf50487ccae0a10( entity, trigger )
{
    entnum = entity getentitynumber();
    
    if ( trigger.entities_inside[ entnum ] )
    {
        trigger.entities_inside[ entnum ] notify( #"hash_b66c37785c5c7da7" );
        trigger.entities_inside[ entnum ] function_5818a95f73539e5b();
        trigger.entities_inside[ entnum ] = undefined;
    }
}

// Namespace skill_valkyrie
// Params 5, eflags: 0x4
// Checksum 0x44ded550, Offset: 0x113e
// Size: 0x98
function private burn_damage( burn_damage, burn_damage_tick, weapon_name, inflictor, origin )
{
    self endon( #"hash_b66c37785c5c7da7", #"death_or_disconnect" );
    
    while ( true )
    {
        source_position = self tagexists( "j_spine4" ) ? self gettagorigin( "j_spine4" ) : self.origin;
        self dodamage( burn_damage, source_position, inflictor, inflictor, "MOD_FIRE", weapon_name, "torso_upper", undefined );
        wait burn_damage_tick;
    }
}

// Namespace skill_valkyrie
// Params 1, eflags: 0x4
// Checksum 0x2260c32f, Offset: 0x11de
// Size: 0xbd
function private burn_state( var_eb1f96c921ef5095 )
{
    if ( isagent( self ) )
    {
        if ( self._blackboard )
        {
            self._blackboard.isburning = 1;
        }
        
        self.var_553ae45c1a5786fb = gettime();
        self.burningdirection = undefined;
        right = anglestoright( self.angles );
        tofire = vectornormalize( var_eb1f96c921ef5095 - self.origin );
        
        if ( vectordot( right, tofire ) > 0 )
        {
            self.burningdirection = "right";
        }
        else
        {
            self.burningdirection = "left";
        }
        
        return;
    }
    
    thread damage_effects::enableburnfxfortime( 0.5, undefined, undefined, undefined );
}

// Namespace skill_valkyrie
// Params 0, eflags: 0x4
// Checksum 0x6831254d, Offset: 0x12a3
// Size: 0x2b
function private function_5818a95f73539e5b()
{
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( isagent( self ) )
    {
        level thread ai::remove_blackboard_isburning( self );
        self.burningdirection = "none";
    }
}

// Namespace skill_valkyrie
// Params 4, eflags: 0x4
// Checksum 0x65031b78, Offset: 0x12d6
// Size: 0x12d
function private function_957510786680f4b3( var_c2a5d39d67459394, napalm_damage_trigger, napalm_duration, bad_place_id )
{
    wait napalm_duration;
    
    foreach ( var_45d6c536d82b526f in var_c2a5d39d67459394 )
    {
        var_45d6c536d82b526f freescriptable();
    }
    
    if ( napalm_damage_trigger )
    {
        foreach ( entity in napalm_damage_trigger.entities_inside )
        {
            function_ccf50487ccae0a10( entity, napalm_damage_trigger );
        }
        
        napalm_damage_trigger delete();
    }
    
    if ( isdefined( bad_place_id ) )
    {
        destroynavobstacle( bad_place_id );
    }
}

/#

    // Namespace skill_valkyrie
    // Params 1, eflags: 0x4
    // Checksum 0x8dc2550b, Offset: 0x140b
    // Size: 0x16c, Type: dev
    function private function_4903043576843e8b( params )
    {
        if ( level.players.size > 1 )
        {
            printtoscreen2d( 500, 350, "<dev string:xe4>", ( 1, 0, 0 ), 1, 300 );
            return;
        }
        
        player = level.players[ 0 ];
        
        if ( !isdefined( player.activeskills[ #"valkyrie" ] ) )
        {
            printtoscreen2d( 500, 350, "<dev string:x12b>", ( 1, 0, 0 ), 1, 300 );
            return;
        }
        
        skill_bundle = level.skillbundles[ #"valkyrie" ][ player.activeskills[ #"valkyrie" ] ];
        forward = anglestoforward( player getplayerangles() ) * 500;
        var_870f06943fb1bf2b = player.origin + ( forward[ 0 ], forward[ 1 ], 0 );
        var_c512b47572fe9cea = var_870f06943fb1bf2b + ( 0, 0, skill_bundle.var_204c3c1a8b3a7aa2 );
        var_82e4ffd4c82c83c1 = var_870f06943fb1bf2b + ( 0, 0, skill_bundle.var_3c315dc341bfac14 );
        line( var_870f06943fb1bf2b, var_c512b47572fe9cea, ( 1, 0, 0 ), 1, 0, 1000 );
        line( var_c512b47572fe9cea, var_82e4ffd4c82c83c1, ( 0, 1, 0 ), 1, 0, 10000 );
    }

    // Namespace skill_valkyrie
    // Params 1, eflags: 0x4
    // Checksum 0xdf37fd5f, Offset: 0x157f
    // Size: 0x115, Type: dev
    function private function_7c8def2435280b18( params )
    {
        if ( level.players.size > 1 )
        {
            printtoscreen2d( 500, 350, "<dev string:x178>", ( 1, 0, 0 ), 1, 300 );
            return;
        }
        
        player = level.players[ 0 ];
        
        if ( !isdefined( player.activeskills[ #"valkyrie" ] ) )
        {
            printtoscreen2d( 500, 350, "<dev string:x1b9>", ( 1, 0, 0 ), 1, 300 );
            return;
        }
        
        skill_level = player.activeskills[ #"valkyrie" ];
        skill_bundle = level.skillbundles[ #"valkyrie" ][ skill_level ];
        forward = anglestoforward( player getplayerangles() ) * 1000;
        pos = player geteye();
        player function_6a60d15d10bd5883( skill_bundle.valkyriegrenadeweapon, pos, forward, skill_bundle );
    }

#/
