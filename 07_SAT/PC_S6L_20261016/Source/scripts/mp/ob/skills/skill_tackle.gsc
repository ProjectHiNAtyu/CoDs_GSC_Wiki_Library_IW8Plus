// scripts\mp\ob\skills\skill_tackle.gsc  (hash_0beecf26ae2251f7.gscc) (size: 8535 Bytes / 0x2157 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8cb440da (2360623322)
// size ...... 8535 (0x2157)
// includes .. 8   (offset: 0x1f03)
// strings ... 10  (offset: 0x1f43)
// dev strs .. 29  (offset: 0x1ffb)
// exports ... 19  (offset: 0x138f)
// cseg ...... 0xd2 + 0x12bd (0x138f)
// imports ... 69  (offset: 0x1687)
// animtree1 . 0   (offset: 0x2157)
// animtree2 . 0   (offset: 0x2157)
#using script_2fe74ee229c972c3;
#using scripts\common\ai\ai_utility;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\debug;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;

#namespace skill_tackle;

// Namespace skill_tackle
// Params 0, eflags: 0x1
// Checksum 0xc1401cd, Offset: 0xf0
// Size: 0x17
function autoexec main()
{
    shared_skills::function_b667da63ece9b966( #"tackle", &init );
}

// Namespace skill_tackle
// Params 0
// Checksum 0x94d36a14, Offset: 0x10f
// Size: 0x5c
function init()
{
    utility::registersharedfunc( #"tackle", #"hash_f89602d29c289ca4", &function_1321989bae991e4f );
    utility::registersharedfunc( #"tackle", #"ongiveskill", &on_give_skill );
    utility::registersharedfunc( #"tackle", #"hash_4aa03f4559ac50a5", &function_c51f1692ecb73bfe );
}

// Namespace skill_tackle
// Params 1, eflags: 0x4
// Checksum 0x9416d5b3, Offset: 0x173
// Size: 0x141
function private function_1321989bae991e4f( skill_bundle )
{
    if ( skill_bundle.var_b909bdb22582657e )
    {
        skill_bundle.var_4057364fc632a931 = cos( skill_bundle.var_b909bdb22582657e );
    }
    
    if ( skill_bundle.var_2e2837251d31b4de )
    {
        skill_bundle.var_7fe9d3200ccffe6e = skill_bundle.var_2e2837251d31b4de * 1000;
    }
    
    if ( skill_bundle.var_16c073dfa9e65763 )
    {
        skill_bundle.var_105ac08be9f9b9c9 = function_32ce5cfd06e32e8( skill_bundle.var_16c073dfa9e65763 );
    }
    
    if ( skill_bundle.var_cea44f4fb98c0b1c )
    {
        skill_bundle.var_6516b73c3f893132 = function_32ce5cfd06e32e8( skill_bundle.var_cea44f4fb98c0b1c );
    }
    
    if ( skill_bundle.var_bdee3b84de3a10e3 )
    {
        skill_bundle.var_e3cc95f4635b355b = int( skill_bundle.var_bdee3b84de3a10e3 * 1000 );
    }
    
    if ( skill_bundle.tacklevfx )
    {
        fx_asset = loadfxasset( skill_bundle.tacklevfx );
        fx_id = "tackle_fx_" + skill_bundle.skilllevel;
        level._effect[ fx_id ] = fx_asset;
        skill_bundle.var_1c1ff60bc3b88289 = fx_id;
    }
}

// Namespace skill_tackle
// Params 1, eflags: 0x4
// Checksum 0x27cea2d0, Offset: 0x2bc
// Size: 0x47
function private function_32ce5cfd06e32e8( struct_array )
{
    new_array = [];
    
    for ( i = 0; i < struct_array.size ; i++ )
    {
        new_array[ i ] = struct_array[ i ].value;
    }
    
    return new_array;
}

// Namespace skill_tackle
// Params 1, eflags: 0x4
// Checksum 0x4c6aa945, Offset: 0x30c
// Size: 0x2f7, Type: bool
function private on_give_skill( skill_bundle )
{
    assert( skill_bundle.tackleradius, "<dev string:x24>" );
    assert( skill_bundle.tacklefov, "<dev string:x57>" );
    assert( skill_bundle.var_b909bdb22582657e, "<dev string:x87>" );
    assert( skill_bundle.var_270f168d182cb34, "<dev string:xbf>" );
    assert( skill_bundle.var_21eb78406f81976e, "<dev string:xfb>" );
    assert( skill_bundle.var_3076b357495c4467, "<dev string:x140>" );
    assert( skill_bundle.var_82fc54f2e2e27aa7, "<dev string:x179>" );
    assert( skill_bundle.tacklerumble, "<dev string:x1b3>" );
    assert( skill_bundle.var_6a30821f5d4aae85, "<dev string:x1e6>" );
    assert( skill_bundle.var_fc37ccc93a64baa1, "<dev string:x21d>" );
    assert( skill_bundle.var_150f76e40400cef, "<dev string:x257>" );
    assert( skill_bundle.var_4df57e0b5aba62af, "<dev string:x28f>" );
    assert( skill_bundle.var_8958b16310527118, "<dev string:x2cd>" );
    assert( skill_bundle.var_2e2837251d31b4de, "<dev string:x30a>" );
    assert( skill_bundle.var_200aa1f2bb3a2d50, "<dev string:x34a>" );
    assert( skill_bundle.tacklegesture, "<dev string:x388>" );
    assert( skill_bundle.tacklesound, "<dev string:x3bc>" );
    assert( skill_bundle.var_a34ca8a75744b54d, "<dev string:x3ee>" );
    assert( skill_bundle.var_1eab59bbf557ff46, "<dev string:x425>" );
    assert( skill_bundle.var_2ae520d6933cda02, "<dev string:x465>" );
    assert( skill_bundle.var_a098ee7c9b4c9eff, "<dev string:x4a7>" );
    assert( skill_bundle.var_2617aba17f609a43, "<dev string:x4e6>" );
    assert( skill_bundle.var_bb19ce2f5f43aee3, "<dev string:x52e>" );
    assert( skill_bundle.var_41a68ac6125e08ed, "<dev string:x577>" );
    assert( skill_bundle.var_51036942be2cccf4, "<dev string:x5ba>" );
    assert( skill_bundle.var_1397a9f93e2a2aaf, "<dev string:x602>" );
    assert( skill_bundle.var_e3cc95f4635b355b, "<dev string:x643>" );
    self.var_fb34526a94337689 = { #var_15b6249d440374d6:0, #var_1cc0e6d9ba565be9:[], #var_94ef6a2f469258ec:[], #bundle:skill_bundle };
    thread monitor_knockdown( self.var_fb34526a94337689, skill_bundle );
    thread function_fca2a72e66bf656( self.var_fb34526a94337689, skill_bundle );
    
    /#
        thread function_3f3bbc19959572de();
    #/
    
    return true;
}

// Namespace skill_tackle
// Params 1, eflags: 0x4
// Checksum 0x19fdbaa5, Offset: 0x60c
// Size: 0x49
function private function_c51f1692ecb73bfe( skill_bundle )
{
    self notify( #"tackle_end" );
    function_51c2be70ebd50079( self.var_fb34526a94337689 );
    utility::function_32b24db3127bff40( skill_bundle.var_1eab59bbf557ff46, "exit" );
    self.var_fb34526a94337689 = undefined;
}

// Namespace skill_tackle
// Params 2
// Checksum 0xd6d562c, Offset: 0x65d
// Size: 0x1a4
function monitor_knockdown( var_da55798eb12048a0, bundle )
{
    self notify( #"hash_1b951d71749597f0" );
    self endon( #"hash_1b951d71749597f0" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self endon( #"tackle_end" );
    
    while ( true )
    {
        if ( self issprintsliding() || self isdiving() )
        {
            var_acdd0dd280358ffb = 0;
            targets = sortbydistance( self function_906f4c75be23ff6c( bundle.tackleradius, bundle.tacklefov, 65536, 0 ), self.origin );
            
            foreach ( target in targets )
            {
                if ( !function_cdc6ba2733ec6e0e( target, var_da55798eb12048a0, bundle ) )
                {
                    continue;
                }
                
                var_da55798eb12048a0.var_94ef6a2f469258ec[ var_da55798eb12048a0.var_94ef6a2f469258ec.size ] = target;
                var_acdd0dd280358ffb = 1;
                function_979058a3af3f844( target, bundle );
                tackle_enemy( target, bundle );
            }
            
            if ( var_acdd0dd280358ffb )
            {
                thread function_e0a1908b1bf40ac4( bundle );
            }
        }
        else if ( var_da55798eb12048a0.var_94ef6a2f469258ec.size )
        {
            utility::function_32b24db3127bff40( bundle.var_1eab59bbf557ff46, "exit" );
            var_da55798eb12048a0.var_94ef6a2f469258ec = [];
        }
        
        wait 0.1;
    }
}

// Namespace skill_tackle
// Params 2, eflags: 0x4
// Checksum 0xee43e7b3, Offset: 0x809
// Size: 0xfb
function private tackle_enemy( target, bundle )
{
    if ( target.type == "zombie" )
    {
        target utility::callsharedfunc( #"zombie", #"knockdownzombie", self.origin, bundle.var_270f168d182cb34 );
        target dodamage( bundle.var_3076b357495c4467, target.origin, self, self, "MOD_IMPACT", "<explicitweaponnone>", "torso_upper" );
        return;
    }
    
    if ( target.type == "human" )
    {
        target notify( #"flashbang", target.origin, 1, undefined, self, self.team, bundle.var_21eb78406f81976e );
        target dodamage( bundle.var_82fc54f2e2e27aa7, target.origin, self, self, "MOD_IMPACT", "<explicitweaponnone>", "torso_upper" );
    }
}

// Namespace skill_tackle
// Params 2, eflags: 0x4
// Checksum 0xd42fecd2, Offset: 0x90c
// Size: 0x12b
function private function_979058a3af3f844( target, bundle )
{
    utility::function_32b24db3127bff40( bundle.var_1eab59bbf557ff46, "on" );
    self playrumbleonentity( bundle.tacklerumble );
    self earthquakeforplayer( bundle.var_6a30821f5d4aae85, bundle.var_fc37ccc93a64baa1, self.origin, bundle.var_150f76e40400cef );
    currentweapon = self getcurrentweapon();
    
    if ( !isnullweapon( currentweapon ) )
    {
        self playgestureviewmodel( bundle.tacklegesture );
    }
    
    if ( bundle.var_1c1ff60bc3b88289 && level._effect[ bundle.var_1c1ff60bc3b88289 ] )
    {
        var_26ca9e95c20edfd9 = ( target.origin[ 0 ], target.origin[ 1 ], target.origin[ 2 ] + bundle.var_a34ca8a75744b54d );
        playfx( utility::getfx( bundle.var_1c1ff60bc3b88289 ), var_26ca9e95c20edfd9 );
    }
    
    self playsoundevent( bundle.tacklesound, target );
}

// Namespace skill_tackle
// Params 1, eflags: 0x4
// Checksum 0xf1db887a, Offset: 0xa3f
// Size: 0x85
function private function_e0a1908b1bf40ac4( bundle )
{
    if ( !self.var_1242add814c91d87 || gettime() > self.var_1242add814c91d87 )
    {
        self.var_1242add814c91d87 = gettime() + bundle.var_7fe9d3200ccffe6e;
        self playrumbleonentity( bundle.var_4df57e0b5aba62af );
        self earthquakeforplayer( bundle.var_8958b16310527118, bundle.var_2e2837251d31b4de, self.origin, bundle.var_200aa1f2bb3a2d50 );
    }
}

// Namespace skill_tackle
// Params 2, eflags: 0xc
// Checksum 0xae4ca9c0, Offset: 0xacc
// Size: 0x31d
function private function_fca2a72e66bf656( var_da55798eb12048a0, bundle )
{
    self notify( #"hash_8a453c3cfaeeca9a" );
    self endon( #"hash_8a453c3cfaeeca9a" );
    self endon( #"death_or_disconnect" );
    self endon( #"tackle_end" );
    was_super_sprinting = 0;
    
    while ( true )
    {
        /#
            if ( getdvarint( @"hash_36705f3a978e1e9c", 0 ) )
            {
                printtoscreen2d( 500, 350, "<dev string:x68e>" + string( bundle.var_2ae520d6933cda02 ), ( 1, 1, 1 ), 2 );
                debug::sphere( self, bundle.var_2ae520d6933cda02, ( 0, 1, 0 ), 0.1 );
            }
        #/
        
        function_3e72c3b0556cc507( var_da55798eb12048a0 );
        
        if ( self issupersprinting() )
        {
            was_super_sprinting = 1;
            nearby_ai = sortbydistance( self function_906f4c75be23ff6c( bundle.var_2ae520d6933cda02, bundle.var_a098ee7c9b4c9eff, 65536, 0 ), self.origin );
            
            if ( !nearby_ai.size )
            {
                utility::function_32b24db3127bff40( bundle.var_1eab59bbf557ff46, "exit" );
            }
            
            foreach ( agent in nearby_ai )
            {
                if ( !function_cdc6ba2733ec6e0e( agent, var_da55798eb12048a0, bundle ) )
                {
                    continue;
                }
                
                function_979058a3af3f844( agent, bundle );
                function_5c2b96e818bdd1fb( agent, bundle );
                function_dfa85d3585daeb31( agent, bundle );
                agent.var_c58c857ad6f00d4c = 1;
                var_da55798eb12048a0.var_1cc0e6d9ba565be9[ var_da55798eb12048a0.var_1cc0e6d9ba565be9.size ] = agent;
                
                if ( agent.type == "zombie" )
                {
                    agent dodamage( bundle.var_2617aba17f609a43, agent.origin, self, self, "MOD_IMPACT", "<explicitweaponnone>", "torso_upper" );
                    continue;
                }
                
                if ( agent.type == "human" )
                {
                    agent dodamage( bundle.var_bb19ce2f5f43aee3, agent.origin, self, self, "MOD_IMPACT", "<explicitweaponnone>", "torso_upper" );
                }
            }
        }
        else if ( was_super_sprinting )
        {
            was_super_sprinting = 0;
            
            for ( i = var_da55798eb12048a0.var_15b6249d440374d6; i < var_da55798eb12048a0.var_1cc0e6d9ba565be9.size ; i++ )
            {
                target = var_da55798eb12048a0.var_1cc0e6d9ba565be9[ i ];
                
                if ( isalive( target ) )
                {
                    target.var_cfc1534f0964700c = gettime() + bundle.var_e3cc95f4635b355b;
                }
            }
            
            var_da55798eb12048a0.var_15b6249d440374d6 = var_da55798eb12048a0.var_1cc0e6d9ba565be9.size;
            utility::function_32b24db3127bff40( bundle.var_1eab59bbf557ff46, "exit" );
        }
        
        wait 0.1;
    }
}

// Namespace skill_tackle
// Params 3, eflags: 0x4
// Checksum 0x916b8cb4, Offset: 0xdf1
// Size: 0x12f, Type: bool
function private function_cdc6ba2733ec6e0e( target, var_da55798eb12048a0, bundle )
{
    if ( target.var_c58c857ad6f00d4c || arraycontains( var_da55798eb12048a0.var_94ef6a2f469258ec, target ) )
    {
        return false;
    }
    
    if ( target.team == self.team )
    {
        return false;
    }
    
    if ( !isalive( target ) )
    {
        return false;
    }
    
    if ( target zombie_utils::function_bf1464d09f4e4b40() )
    {
        return false;
    }
    
    if ( !target val::get( "damage" ) )
    {
        return false;
    }
    
    tracecontents = trace::create_contents( 0, 1 );
    result = trace::ray_trace( self geteye(), target geteye(), [ self, target ], tracecontents, 0, 0, 0, undefined, self.team );
    
    if ( result[ "fraction" ] < 1 )
    {
        return false;
    }
    
    view_forward = anglestoforward( self getplayerangles() );
    movement_dir = vectornormalize( self getvelocity() );
    cos_current_angle = vectordot( view_forward, movement_dir );
    
    if ( cos_current_angle < bundle.var_4057364fc632a931 )
    {
        return false;
    }
    
    return true;
}

// Namespace skill_tackle
// Params 2, eflags: 0x4
// Checksum 0x77352438, Offset: 0xf29
// Size: 0x8b
function private function_5c2b96e818bdd1fb( agent, bundle )
{
    tiers_base = bundle.var_105ac08be9f9b9c9;
    agent_tier = agent ai_utility::get_power_tier();
    
    if ( tiers_base && arraycontains( tiers_base, agent_tier ) )
    {
        if ( bundle.var_41a68ac6125e08ed )
        {
            agent utility::callsharedfunc( #"zombie", #"knockdownzombie", self.origin, bundle.var_1397a9f93e2a2aaf );
        }
    }
}

// Namespace skill_tackle
// Params 2, eflags: 0x4
// Checksum 0x1206875e, Offset: 0xfbc
// Size: 0xc4
function private function_dfa85d3585daeb31( agent, bundle )
{
    tiers_advanced = bundle.var_6516b73c3f893132;
    agent_tier = agent ai_utility::get_power_tier();
    
    if ( tiers_advanced && arraycontains( tiers_advanced, agent_tier ) )
    {
        stun_duration = bundle.var_51036942be2cccf4;
        
        if ( stun_duration )
        {
            if ( agent.type == "zombie" )
            {
                agent zombie_stun::stun_ai( stun_duration );
                return;
            }
            
            if ( agent.type == "human" )
            {
                agent notify( #"flashbang", agent.origin, 1, undefined, self, self.team, stun_duration );
            }
        }
    }
}

/#

    // Namespace skill_tackle
    // Params 0, eflags: 0x4
    // Checksum 0x7e371386, Offset: 0x1088
    // Size: 0xe4, Type: dev
    function private function_3f3bbc19959572de()
    {
        self endon( #"tackle_end" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_d66d5547ef0843ce", 0 ) )
            {
                origin = self.origin;
                view_forward = anglestoforward( self getplayerangles() );
                movement_dir = vectornormalize( self getvelocity() );
                debug::line( origin, origin + view_forward * 500, ( 0, 0, 1 ), 1 );
                debug::line( origin, origin + movement_dir * 500, ( 1, 0, 0 ), 1 );
                
                if ( length( movement_dir ) > 0 )
                {
                    cos = vectordot( view_forward, movement_dir );
                    angle = acos( cos );
                    iprintlnbold( "<dev string:x6aa>" + angle );
                }
            }
            
            wait 0.1;
        }
    }

#/

// Namespace skill_tackle
// Params 1, eflags: 0x4
// Checksum 0x16a4dcc2, Offset: 0x1174
// Size: 0x159
function private function_3e72c3b0556cc507( var_da55798eb12048a0 )
{
    targets_to_remove = [];
    
    foreach ( target in var_da55798eb12048a0.var_1cc0e6d9ba565be9 )
    {
        remove_target = 0;
        
        if ( !isalive( target ) )
        {
            remove_target = 1;
        }
        else if ( target.var_cfc1534f0964700c <= gettime() )
        {
            remove_target = 1;
            function_2605535e3313b912( target );
        }
        
        if ( remove_target )
        {
            targets_to_remove[ targets_to_remove.size ] = target;
            var_da55798eb12048a0.var_15b6249d440374d6--;
        }
    }
    
    foreach ( target in targets_to_remove )
    {
        var_da55798eb12048a0.var_1cc0e6d9ba565be9 = arrayremove( var_da55798eb12048a0.var_1cc0e6d9ba565be9, target );
    }
}

// Namespace skill_tackle
// Params 1, eflags: 0x4
// Checksum 0x96ecd62e, Offset: 0x12d5
// Size: 0x90
function private function_51c2be70ebd50079( var_da55798eb12048a0 )
{
    foreach ( target in var_da55798eb12048a0.var_1cc0e6d9ba565be9 )
    {
        if ( isalive( target ) )
        {
            function_2605535e3313b912( target );
        }
    }
}

// Namespace skill_tackle
// Params 1, eflags: 0x4
// Checksum 0x93d11dac, Offset: 0x136d
// Size: 0x22
function private function_2605535e3313b912( target )
{
    target.var_cfc1534f0964700c = undefined;
    target.var_c58c857ad6f00d4c = undefined;
}

