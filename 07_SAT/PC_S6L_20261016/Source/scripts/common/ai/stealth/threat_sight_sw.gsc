// scripts\common\ai\stealth\threat_sight_sw.gsc  (hash_4eee71e010baa1aa.gscc) (size: 12837 Bytes / 0x3225 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x43bc7848 (1136425032)
// size ...... 12837 (0x3225)
// includes .. 7   (offset: 0x30ad)
// strings ... 14  (offset: 0x30e5)
// dev strs .. 7   (offset: 0x31c9)
// exports ... 28  (offset: 0x21c1)
// cseg ...... 0x174 + 0x204d (0x21c1)
// imports ... 85  (offset: 0x2621)
// animtree1 . 0   (offset: 0x3225)
// animtree2 . 0   (offset: 0x3225)
#using scripts\common\ai\stealth\manager;
#using scripts\common\math;
#using scripts\common\scripted_widgets;
#using scripts\common\system;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\common\values;

#namespace threat_sight_sw;

// Namespace threat_sight_sw
// Params 0, eflags: 0x5
// Checksum 0xcd55946, Offset: 0x192
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"threat_sight_sw", undefined, undefined, &post_main );
}

// Namespace threat_sight_sw
// Params 0, eflags: 0x4
// Checksum 0xe844e56e, Offset: 0x1b3
// Size: 0x120
function private post_main()
{
    if ( !( isdefined( level.gamemodebundle ) && isdefined( level.gamemodebundle.stealthbundle ) ) )
    {
        return;
    }
    
    stealthbundle = getscriptbundle( level.gamemodebundle.stealthbundle );
    
    if ( !( isdefined( stealthbundle ) && isdefined( stealthbundle.threatsightwidget ) && isdefined( stealthbundle.threatsightanchor ) ) )
    {
        return;
    }
    
    level.var_872fce696809590e = stealthbundle.var_872fce696809590e ?? 10;
    setsaveddvar( @"compassstealthpipsenabled", 0 );
    setsaveddvar( @"ai_threatsightnotify", 1 );
    
    /#
        setdvarifuninitialized( @"debug_stealth_sw", 0 );
        setdvarifuninitialized( @"hash_8ff4f865ba57762a", 0 );
        setdvarifuninitialized( @"hash_4f768e3873fe79da", "<dev string:x24>" );
        setdvarifuninitialized( @"hash_6651037eca599785", 0 );
    #/
    
    level.var_5e0c0ecb2271d653 = &function_4ebd5f42728e4462;
    ui::lui_registercallback( "entity_stealth_display_hidden", &function_1725ddfb0d4b97d3 );
    thread function_b83935b88c43fecd();
    
    /#
        thread threat_sight_debug_watch();
    #/
}

// Namespace threat_sight_sw
// Params 1, eflags: 0x4
// Checksum 0x34c0fb4b, Offset: 0x2db
// Size: 0xb9
function private function_1725ddfb0d4b97d3( var_5ce68f4dfdbe312b )
{
    foreach ( player in level.players )
    {
        if ( isdefined( player.threat_sight_data.active[ var_5ce68f4dfdbe312b ] ) )
        {
            player function_9ce5a19f26ffb04a( player.threat_sight_data.active[ var_5ce68f4dfdbe312b ] );
        }
    }
}

// Namespace threat_sight_sw
// Params 0, eflags: 0x4
// Checksum 0x17db50fa, Offset: 0x39c
// Size: 0x146
function private function_b83935b88c43fecd()
{
    utility::flag_wait( "stealth_enabled" );
    
    if ( isdefined( level.stealth ) )
    {
        var_7401c3bb6c31a2d1 = level.stealth.fninitenemygame;
        level.stealth.fninitenemygame = &function_e0f9c6dea8b85fe9;
        
        if ( var_7401c3bb6c31a2d1 != level.stealth.fninitenemygame )
        {
            all_ai = getaiarray();
            
            foreach ( enemy in all_ai )
            {
                if ( !isdefined( enemy.team ) )
                {
                    continue;
                }
                
                switch ( enemy.team )
                {
                    case #"hash_1cd4e5e62debde85":
                    case #"hash_5f54b9bf7583687f":
                    case #"hash_e87767df2e5c3a68":
                        continue;
                }
                
                enemy thread [[ level.stealth.fninitenemygame ]]();
            }
        }
    }
}

// Namespace threat_sight_sw
// Params 4
// Checksum 0xef2b89fe, Offset: 0x4ea
// Size: 0x34
function function_4ebd5f42728e4462( var_31eaa9463f0da5cc, var_613baba72a1db93d, var_a728b522444f470f, var_9c8e7eb19941a901 )
{
    thread generic_entity_threat_sight_thread( var_31eaa9463f0da5cc, var_613baba72a1db93d, var_a728b522444f470f, var_9c8e7eb19941a901 );
}

// Namespace threat_sight_sw
// Params 4, eflags: 0xc
// Checksum 0x351edcc1, Offset: 0x526
// Size: 0x272
function private generic_entity_threat_sight_thread( var_31eaa9463f0da5cc, var_613baba72a1db93d, var_a728b522444f470f, var_9c8e7eb19941a901 )
{
    self notify( #"hash_a9e0877a7c31989f" );
    self endon( #"hash_a9e0877a7c31989f" );
    entity = self;
    level thread function_bb1c76f87a5bb1dd();
    
    if ( !isdefined( entity.threat_sight_data ) )
    {
        if ( !isdefined( var_9c8e7eb19941a901 ) )
        {
            var_9c8e7eb19941a901 = 0.1;
        }
        
        entity.threat_sight_data = spawnstruct();
        entity.threat_sight_data.sight = 0;
        entity.threat_sight_data.visible = 0;
        entity.threat_sight_data.fovcosine = cos( var_613baba72a1db93d );
        entity.threat_sight_data.rangesq = var_a728b522444f470f * var_a728b522444f470f;
        entity.threat_sight_data.rate = var_9c8e7eb19941a901;
    }
    
    var_124b6d2fb975ddc9 = 0;
    
    while ( isent( entity ) )
    {
        entity function_83d27934d6f90821();
        
        if ( entity.threat_sight_data.visible )
        {
            entity.threat_sight_data.sight += entity.threat_sight_data.rate * level.framedurationseconds;
            
            if ( !var_124b6d2fb975ddc9 && entity.threat_sight_data.sight >= 1 )
            {
                if ( isdefined( var_31eaa9463f0da5cc ) )
                {
                    entity thread [[ var_31eaa9463f0da5cc ]]( entity.threat_sight_data.var_584547698236b56d );
                }
                
                var_124b6d2fb975ddc9 = 1;
            }
        }
        else
        {
            entity.threat_sight_data.sight -= entity.threat_sight_data.rate * level.framedurationseconds * 2;
            var_124b6d2fb975ddc9 = 0;
        }
        
        entity.threat_sight_data.sight = clamp( entity.threat_sight_data.sight, 0, 1 );
        entity function_ce93864cf2b9db09( entity.threat_sight_data );
        waitframe();
    }
}

// Namespace threat_sight_sw
// Params 0, eflags: 0x4
// Checksum 0xacdde713, Offset: 0x7a0
// Size: 0x2b5
function private function_bb1c76f87a5bb1dd()
{
    level notify( #"hash_a73abc5a487ae026" );
    level endon( #"hash_a73abc5a487ae026" );
    
    if ( !isdefined( level.threat_sight_queue ) )
    {
        level.threat_sight_queue = spawnstruct();
    }
    
    while ( true )
    {
        var_839eff241de91a55 = 0;
        
        while ( isdefined( level.threat_sight_queue.head ) )
        {
            entity = level.threat_sight_queue utility::fifo_dequeue();
            
            if ( !isdefined( entity ) )
            {
                continue;
            }
            
            entity.threat_sight_data.visible = 0;
            entity.threat_sight_data.var_584547698236b56d = undefined;
            entity.threat_sight_data.state = "unaware";
            
            foreach ( player in level.players )
            {
                playereye = player geteye();
                delta = playereye - entity.origin;
                
                if ( lengthsquared( delta ) < entity.threat_sight_data.rangesq )
                {
                    dot = vectordot( vectornormalize( delta ), anglestoforward( entity.angles ) );
                    
                    if ( dot > entity.threat_sight_data.fovcosine )
                    {
                        var_839eff241de91a55 = 1;
                        
                        if ( sighttracepassed( entity.origin, playereye, 0, entity, player ) )
                        {
                            entity.threat_sight_data.visible = 1;
                            
                            if ( !isdefined( entity.threat_sight_data.var_584547698236b56d ) || distancesquared( entity.threat_sight_data.var_584547698236b56d.origin, entity.origin ) > distancesquared( player.origin, entity.origin ) )
                            {
                                entity.threat_sight_data.var_584547698236b56d = player;
                            }
                        }
                    }
                }
            }
            
            entity.threat_sight_data.pending = undefined;
            
            if ( var_839eff241de91a55 )
            {
                break;
            }
        }
        
        waitframe();
        
        if ( !isdefined( level.threat_sight_queue.head ) )
        {
            level waittill( #"hash_46ec97e68eb33e0a" );
        }
    }
}

// Namespace threat_sight_sw
// Params 0, eflags: 0x4
// Checksum 0xb679023a, Offset: 0xa5d
// Size: 0x5e
function private function_83d27934d6f90821()
{
    entity = self;
    
    if ( entity.threat_sight_data.pending )
    {
        return;
    }
    
    level.threat_sight_queue utility::fifo_enqueue( entity );
    entity.threat_sight_data.pending = 1;
    level notify( #"hash_46ec97e68eb33e0a" );
}

// Namespace threat_sight_sw
// Params 0, eflags: 0x4
// Checksum 0xd11ba170, Offset: 0xac3
// Size: 0x38
function private function_e0f9c6dea8b85fe9()
{
    if ( !isai( self ) )
    {
        return;
    }
    
    ai = self;
    ai.var_b3ba55ffd4536a8b = 0;
    ai thread function_b9755ffe168045bf();
    ai thread function_d920261e0e5c07a5();
}

// Namespace threat_sight_sw
// Params 0, eflags: 0x4
// Checksum 0x29300a45, Offset: 0xb03
// Size: 0x3d
function private function_d920261e0e5c07a5()
{
    while ( !isdefined( self.stealth.funcs ) )
    {
        waitframe();
    }
    
    self.stealth.funcs[ "spotted" ] = &function_ab67b9540accdd6d;
}

// Namespace threat_sight_sw
// Params 1
// Checksum 0xa0dc5725, Offset: 0xb48
// Size: 0x7f
function function_24984f755625d84b( player )
{
    assert( isent( self ) );
    assert( isplayer( player ) );
    ai = self;
    playernum = player getentitynumber();
    
    if ( !isdefined( ai.threat_sight_data[ playernum ] ) )
    {
        ai.threat_sight_data[ playernum ] = {};
    }
    
    threatsightdata = ai.threat_sight_data[ playernum ];
    return threatsightdata;
}

// Namespace threat_sight_sw
// Params 0, eflags: 0xc
// Checksum 0xee3c9c42, Offset: 0xbd0
// Size: 0x200
function private function_b9755ffe168045bf()
{
    self notify( #"hash_976b23fffd02ba03" );
    self endon( #"hash_976b23fffd02ba03" );
    assert( isai( self ) );
    ai = self;
    ai endon( #"death", #"hash_4daa813e845207a4" );
    ai childthread function_a8dcf9227537af49();
    ai childthread function_6812369be715062f();
    
    /#
        ai childthread function_dcedba6d0a6557c5();
    #/
    
    while ( isalive( ai ) )
    {
        ai waittill( #"hash_e65d744126e08be7", sight, visible, combat, var_584547698236b56d );
        
        if ( !isplayer( var_584547698236b56d ) )
        {
            continue;
        }
        
        playernum = var_584547698236b56d getentitynumber();
        var_fb92efd32b0efa48 = !isdefined( ai.threat_sight_data[ playernum ] );
        threatsightdata = ai function_24984f755625d84b( var_584547698236b56d );
        
        if ( !isdefined( threatsightdata.sight ) )
        {
            threatsightdata.sight = 0;
        }
        
        threatsightdata.var_584547698236b56d = var_584547698236b56d;
        
        if ( sight > 0 && threatsightdata.sight == 0 )
        {
            var_584547698236b56d notify( #"sighted", ai );
        }
        
        if ( visible && sight >= 0.5 && threatsightdata.sight < 0.5 )
        {
            ai notify( #"stealth_warning" );
        }
        
        var_b20ca5297d29602c = !( visible === threatsightdata.visible && sight === threatsightdata.sight ) || var_fb92efd32b0efa48;
        
        if ( var_b20ca5297d29602c )
        {
            threatsightdata.sight = sight;
            threatsightdata.visible = visible;
            threatsightdata.var_584547698236b56d = var_584547698236b56d;
            
            if ( !isdefined( threatsightdata.state ) )
            {
                threatsightdata.state = "unaware";
            }
            
            ai function_ce93864cf2b9db09( threatsightdata );
        }
    }
}

// Namespace threat_sight_sw
// Params 0, eflags: 0x4
// Checksum 0x7971588, Offset: 0xdd8
// Size: 0xa6
function private function_6812369be715062f()
{
    if ( !isdefined( level.var_6287fad3b7848872 ) )
    {
        return;
    }
    
    ai = self;
    ai waittill( #"takedown_begin" );
    
    foreach ( threatsightdata in ai.threat_sight_data )
    {
        ai function_ce93864cf2b9db09( threatsightdata );
    }
}

// Namespace threat_sight_sw
// Params 0, eflags: 0x4
// Checksum 0x945e508d, Offset: 0xe86
// Size: 0x116
function private function_a8dcf9227537af49()
{
    assert( isai( self ) );
    ai = self;
    
    while ( isalive( ai ) )
    {
        ai waittill( #"stealth_state_change", currentstate, previousstate );
        utility::flag_wait( "scripted_widgets_initialized" );
        
        foreach ( player in level.players )
        {
            threatsightdata = ai function_24984f755625d84b( player );
            threatsightdata.state = get_threat_state( currentstate );
            
            if ( threatsightdata.state == "combat" )
            {
                ai function_59a1fb3afc55567f( player );
                continue;
            }
            
            ai function_ce93864cf2b9db09( threatsightdata );
        }
    }
}

// Namespace threat_sight_sw
// Params 0, eflags: 0x4
// Checksum 0xa48ec5d5, Offset: 0xfa4
// Size: 0x7b
function private function_ab67b9540accdd6d()
{
    foreach ( player in level.players )
    {
        function_59a1fb3afc55567f( player );
    }
}

// Namespace threat_sight_sw
// Params 1, eflags: 0x4
// Checksum 0x361d7c89, Offset: 0x1027
// Size: 0x25
function private function_59a1fb3afc55567f( player )
{
    if ( isdefined( player.threat_sight_data ) )
    {
        player thread combat_started_thread( self );
    }
}

// Namespace threat_sight_sw
// Params 1, eflags: 0xc
// Checksum 0x38650c, Offset: 0x1054
// Size: 0x31f
function private combat_started_thread( ai )
{
    self notify( #"hash_beb6b390dbfcd4f7" );
    self endon( #"hash_beb6b390dbfcd4f7" );
    self endon( #"death_or_disconnect" );
    assert( isent( ai ) );
    player = self;
    var_5ce68f4dfdbe312b = ai getentitynumber();
    var_fb92efd32b0efa48 = 0;
    
    if ( player.threat_sight_data.var_82dd0de366d7fe8a[ var_5ce68f4dfdbe312b ] != ai )
    {
        var_fb92efd32b0efa48 = 1;
    }
    
    player.threat_sight_data.var_82dd0de366d7fe8a[ var_5ce68f4dfdbe312b ] = ai;
    var_3251e69b6c589a4 = player stealth_manager::anyone_in_combat();
    
    if ( !isdefined( player.threat_sight_data ) )
    {
        player.threat_sight_data = {};
    }
    
    if ( var_3251e69b6c589a4 )
    {
        var_3251e69b6c589a4 = 0;
        ais = getaiunittypearray( "bad_guys", "all" );
        
        foreach ( guy in ais )
        {
            if ( guy.bisincombat && !isdefined( player.threat_sight_data.var_82dd0de366d7fe8a[ guy getentitynumber() ] ) )
            {
                var_3251e69b6c589a4 = 1;
                break;
            }
        }
    }
    
    if ( var_fb92efd32b0efa48 )
    {
        waitframe();
    }
    
    playernum = self getentitynumber();
    
    if ( !var_3251e69b6c589a4 )
    {
        bestai = undefined;
        sorted = sortbydistance( player.threat_sight_data.var_82dd0de366d7fe8a, player.origin );
        
        foreach ( ai in sorted )
        {
            if ( isalive( ai ) )
            {
                if ( !isdefined( bestai ) )
                {
                    bestai = ai;
                }
                
                if ( player math::point_in_fov( ai.origin ) )
                {
                    bestai = ai;
                    break;
                }
            }
        }
        
        if ( isdefined( bestai ) )
        {
            threatsightdata = bestai function_24984f755625d84b( self );
            utility::callsharedfunc( #"analytics", #"playerspotted", player, bestai );
            self notify( #"spotted", bestai );
            threatsightdata.var_1dd31c9a4a09eb58 = gettime() + 1000;
            threatsightdata.state = "combat";
            bestai function_ce93864cf2b9db09( threatsightdata );
            bestai utility::delaythread( float( 1000 + level.frameduration ) / 1000, &function_ce93864cf2b9db09, threatsightdata );
        }
    }
    
    player.threat_sight_data.var_82dd0de366d7fe8a = [];
}

// Namespace threat_sight_sw
// Params 1
// Checksum 0x6accfb47, Offset: 0x137b
// Size: 0x226
function function_ce93864cf2b9db09( threat_sight_data )
{
    if ( !( isdefined( level.stealth.threatsightwidget ) && isdefined( level.stealth.threatsightanchor ) ) )
    {
        return;
    }
    
    assert( !isplayer( self ) );
    entity = self;
    refname = "overhead_stealth_display";
    
    if ( !isplayer( threat_sight_data.var_584547698236b56d ) )
    {
        return;
    }
    
    player = threat_sight_data.var_584547698236b56d;
    
    if ( !isdefined( threat_sight_data.sight ) )
    {
        threat_sight_data.sight = 0;
    }
    
    if ( !isdefined( threat_sight_data.visible ) )
    {
        threat_sight_data.visible = 0;
    }
    
    if ( !isdefined( threat_sight_data.state ) )
    {
        threat_sight_data.state = "unaware";
    }
    
    /#
        entity thread function_9da60eac3e228edf( threat_sight_data );
    #/
    
    var_10fa689428070864 = player val::get( "show_stealth_indicator" );
    var_66a0d313edaed7b5 = isdefined( player.var_66a0d313edaed7b5 ) && player.var_66a0d313edaed7b5.var_9815aa0d78be4b58 === entity;
    enabled = 0;
    
    if ( var_10fa689428070864 && ( !isai( self ) || isalive( self ) ) && !var_66a0d313edaed7b5 )
    {
        if ( threat_sight_data.var_1dd31c9a4a09eb58 > gettime() )
        {
            enabled = 1;
        }
        else
        {
            incombat = player stealth_manager::anyone_in_combat();
            
            if ( !incombat && threat_sight_data.sight > 0 )
            {
                enabled = 1;
            }
            else if ( !incombat && threat_sight_data.state == "investigate" )
            {
                enabled = 1;
            }
            else
            {
                enabled = !incombat && threat_sight_data.sight > 0 || isdefined( threat_sight_data.var_d109742a653a60af );
            }
        }
    }
    
    isactive = player scripted_widgets::anchored_is_active( entity, refname );
    
    if ( enabled )
    {
        player function_f83f4a1a3f0ac8df( entity );
        return;
    }
    
    player function_9ce5a19f26ffb04a( entity );
}

// Namespace threat_sight_sw
// Params 1, eflags: 0x4
// Checksum 0x26ef913d, Offset: 0x15a9
// Size: 0x273
function private function_f83f4a1a3f0ac8df( ai )
{
    assert( isplayer( self ) );
    player = self;
    var_5ce68f4dfdbe312b = ai getentitynumber();
    refname = "overhead_stealth_display";
    
    if ( !isdefined( player.threat_sight_data ) )
    {
        player.threat_sight_data = {};
    }
    
    isactive = player scripted_widgets::anchored_is_active( ai, refname );
    
    if ( !isactive )
    {
        if ( player.threat_sight_data.active.size >= level.var_872fce696809590e )
        {
            player function_c161f5dc4790ff4c( ai );
        }
        else
        {
            player scripted_widgets::anchored_add( ai, refname, level.stealth.threatsightwidget, level.stealth.threatsightanchor );
        }
    }
    
    var_b3ba55ffd4536a8b = ai.var_3c69bed64e3940d > 0;
    
    if ( ai.var_b3ba55ffd4536a8b != var_b3ba55ffd4536a8b )
    {
        ai.var_b3ba55ffd4536a8b = var_b3ba55ffd4536a8b;
        
        if ( var_b3ba55ffd4536a8b )
        {
            player scripted_widgets::anchored_set_state( ai, refname, "entity_has_armor" );
            waitframe();
        }
    }
    
    threatsightdata = ai function_24984f755625d84b( player );
    
    if ( threatsightdata.state == "combat" )
    {
        player scripted_widgets::function_74a4e8eebcc55bd6( ai, refname, threatsightdata.sight, 1 );
        player scripted_widgets::anchored_set_state( ai, refname, threatsightdata.state );
    }
    else
    {
        player scripted_widgets::function_74a4e8eebcc55bd6( ai, refname, threatsightdata.sight, threatsightdata.visible );
        
        if ( threatsightdata.sight > 0 )
        {
            if ( threatsightdata.sight == 1 )
            {
                player scripted_widgets::anchored_set_state( ai, refname, "warning" );
            }
            else if ( threatsightdata.state == "investigate" )
            {
                var_75e8a2de6d255dc1 = "hunting";
                player scripted_widgets::anchored_set_state( ai, refname, var_75e8a2de6d255dc1 );
            }
            else
            {
                player scripted_widgets::anchored_set_state( ai, refname, "unaware" );
            }
        }
        else if ( threatsightdata.state == "investigate" )
        {
            var_75e8a2de6d255dc1 = "hunting";
            player scripted_widgets::anchored_set_state( ai, refname, var_75e8a2de6d255dc1 );
        }
    }
    
    threatsightdata.laststate = threatsightdata.state;
    player.threat_sight_data.active[ var_5ce68f4dfdbe312b ] = ai;
}

// Namespace threat_sight_sw
// Params 1, eflags: 0x4
// Checksum 0xb6e33277, Offset: 0x1824
// Size: 0xbb
function private function_9ce5a19f26ffb04a( ai )
{
    assert( isplayer( self ) );
    player = self;
    
    if ( !isdefined( player.threat_sight_data ) )
    {
        player.threat_sight_data = {};
    }
    
    var_5ce68f4dfdbe312b = ai getentitynumber();
    refname = "overhead_stealth_display";
    isactive = player scripted_widgets::anchored_is_active( ai, refname );
    
    if ( isactive )
    {
        player scripted_widgets::anchored_remove( ai, refname );
    }
    
    if ( isdefined( player.threat_sight_data ) )
    {
        player.threat_sight_data.active[ var_5ce68f4dfdbe312b ] = undefined;
    }
    
    /#
        ai notify( #"hash_6591aaa3669da424" );
    #/
}

// Namespace threat_sight_sw
// Params 1, eflags: 0x4
// Checksum 0xb46d1f1c, Offset: 0x18e7
// Size: 0x166
function private function_c161f5dc4790ff4c( ai )
{
    assert( isplayer( self ) );
    player = self;
    
    if ( !isdefined( player.threat_sight_data ) )
    {
        player.threat_sight_data = {};
    }
    
    if ( !isdefined( player.threat_sight_data.var_385fd038d2016eb9 ) || player.threat_sight_data.var_4a7d87299f4df0b7 < gettime() )
    {
        player function_b4c238f56a53231e();
    }
    
    var_77a80f10019bb8a0 = distancesquared( player.origin, ai.origin );
    
    if ( !isdefined( player.threat_sight_data.var_bbab49237ffbc44d ) || var_77a80f10019bb8a0 < player.threat_sight_data.var_bbab49237ffbc44d )
    {
        for ( var_b2653741cdba6d4e = player.threat_sight_data.var_385fd038d2016eb9.size - 1; var_b2653741cdba6d4e >= 0 && !isdefined( player.threat_sight_data.var_385fd038d2016eb9[ var_b2653741cdba6d4e ] ) ; var_b2653741cdba6d4e-- )
        {
        }
        
        if ( var_b2653741cdba6d4e >= 0 )
        {
            var_bb5b45237fa2da63 = player.threat_sight_data.var_385fd038d2016eb9[ var_b2653741cdba6d4e ];
            player function_9ce5a19f26ffb04a( var_bb5b45237fa2da63 );
        }
        
        player function_b4c238f56a53231e();
    }
}

// Namespace threat_sight_sw
// Params 0, eflags: 0x4
// Checksum 0x70680ba2, Offset: 0x1a55
// Size: 0x156
function private function_b4c238f56a53231e()
{
    assert( isplayer( self ) );
    player = self;
    
    if ( !isdefined( player.threat_sight_data ) )
    {
        player.threat_sight_data = {};
    }
    
    player.threat_sight_data.var_4a7d87299f4df0b7 = gettime();
    player.threat_sight_data.active = function_dd31ebe361ca1538( player.threat_sight_data.active );
    player.threat_sight_data.var_385fd038d2016eb9 = sortbydistance( player.threat_sight_data.active, player.origin );
    
    if ( player.threat_sight_data.var_385fd038d2016eb9.size > 0 )
    {
        var_bb5b45237fa2da63 = player.threat_sight_data.var_385fd038d2016eb9[ player.threat_sight_data.var_385fd038d2016eb9.size - 1 ];
        player.threat_sight_data.var_bbab49237ffbc44d = distancesquared( player.origin, var_bb5b45237fa2da63.origin );
        return;
    }
    
    player.threat_sight_data.var_bbab49237ffbc44d = undefined;
}

// Namespace threat_sight_sw
// Params 1, eflags: 0x4
// Checksum 0xf61687b5, Offset: 0x1bb3
// Size: 0x41
function private get_threat_state( state )
{
    if ( state == 3 )
    {
        return "combat";
    }
    else if ( state == 2 )
    {
        return "hunting";
    }
    else if ( state == 1 )
    {
        return "investigate";
    }
    
    return "unaware";
}

// Namespace threat_sight_sw
// Params 0
// Checksum 0xb545d3d7, Offset: 0x1bfd
// Size: 0xca
function function_982fb0a2ccdc88e4()
{
    ai = self;
    
    foreach ( player in level.players )
    {
        threatsightdata = ai function_24984f755625d84b( player );
        threatsightdata.sight = 0;
        threatsightdata.visible = 1;
        threatsightdata.state = "combat";
        player function_f83f4a1a3f0ac8df( ai );
    }
}

/#

    // Namespace threat_sight_sw
    // Params 1, eflags: 0x4
    // Checksum 0x88687716, Offset: 0x1ccf
    // Size: 0x1cc, Type: dev
    function private function_9da60eac3e228edf( threat_sight_data )
    {
        assert( !isplayer( self ) );
        entity = self;
        entity notify( #"hash_6591aaa3669da424" );
        entity endon( #"hash_6591aaa3669da424" );
        entity endon( #"death" );
        
        while ( getdvarint( @"debug_stealth_sw", 0 ) )
        {
            if ( getdvarint( @"debug_stealth_sw", 0 ) > 1 )
            {
                threat_sight_data.sight = getdvarfloat( @"hash_8ff4f865ba57762a", 0 ) / 100;
                threat_sight_data.state = getdvar( @"hash_4f768e3873fe79da", "<dev string:x24>" );
                threat_sight_data.visible = getdvarint( @"hash_6651037eca599785", 0 );
                
                if ( threat_sight_data.state == "<dev string:x24>" )
                {
                    threat_sight_data.state = "<dev string:x25>";
                }
            }
            
            print3d( entity.origin + ( 0, 0, 70 ), "<dev string:x2d>" + threat_sight_data.sight, ( 1, 1, 1 ), 1, 0.25, 1, 1 );
            print3d( entity.origin + ( 0, 0, 65 ), "<dev string:x36>" + threat_sight_data.visible, ( 1, 1, 1 ), 1, 0.25, 1, 1 );
            print3d( entity.origin + ( 0, 0, 60 ), "<dev string:x3f>" + threat_sight_data.state, ( 1, 1, 1 ), 1, 0.25, 1, 1 );
            waitframe();
        }
    }

    // Namespace threat_sight_sw
    // Params 0, eflags: 0x4
    // Checksum 0xf4ddcbdc, Offset: 0x1ea3
    // Size: 0x12d, Type: dev
    function private threat_sight_debug_watch()
    {
        while ( true )
        {
            if ( getdvarint( @"debug_stealth_sw", 0 ) > 1 )
            {
                foreach ( ai in getaiarray() )
                {
                    if ( !isdefined( ai.threat_sight_data ) )
                    {
                        continue;
                    }
                    
                    foreach ( player in level.players )
                    {
                        threatsightdata = ai function_24984f755625d84b( player );
                        ai thread function_ce93864cf2b9db09( threatsightdata );
                    }
                }
            }
            
            wait 1;
        }
    }

    // Namespace threat_sight_sw
    // Params 0, eflags: 0x4
    // Checksum 0x57fdbe01, Offset: 0x1fd8
    // Size: 0x1e9, Type: dev
    function private function_dcedba6d0a6557c5()
    {
        if ( getdvarint( @"hash_9036f679297821bb", 0 ) > 0 )
        {
            ai = self;
            
            while ( true )
            {
                highestsight = 0;
                higheststate = undefined;
                dist = -1;
                
                foreach ( player in level.players )
                {
                    if ( player.sessionstate != "<dev string:x47>" )
                    {
                        continue;
                    }
                    
                    playernum = player getentitynumber();
                    threatsightdata = ai.threat_sight_data[ playernum ];
                    
                    if ( isdefined( threatsightdata.state ) )
                    {
                        higheststate = threatsightdata.state;
                    }
                    
                    if ( isdefined( threatsightdata.sight ) )
                    {
                        highestsight = max( highestsight, threatsightdata.sight );
                    }
                    
                    dist2d = distance2d( level.player.origin, ai.origin );
                    dist = dist >= 0 ? min( dist2d, dist ) : dist2d;
                }
                
                if ( isdefined( higheststate ) )
                {
                    print3d( ai.origin + ( 20, 0, 50 ), higheststate + "<dev string:x4f>" + highestsight, ( 0, 0, 1 ) );
                }
                
                print3d( ai.origin + ( 20, 0, 40 ), string( dist ), ( 1, 0, 0 ) );
                waitframe();
            }
        }
    }

#/
