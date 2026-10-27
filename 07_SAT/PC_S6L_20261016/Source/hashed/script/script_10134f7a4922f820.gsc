// script_10134f7a4922f820  (hash_10134f7a4922f820.gscc) (size: 15026 Bytes / 0x3ab2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x74c48736 (1959036726)
// size ...... 15026 (0x3ab2)
// includes .. 17  (offset: 0x3662)
// strings ... 32  (offset: 0x36ea)
// dev strs .. 36  (offset: 0x38ba)
// exports ... 48  (offset: 0x1f36)
// cseg ...... 0x308 + 0x1c2e (0x1f36)
// imports ... 130 (offset: 0x26b6)
// animtree1 . 0   (offset: 0x3ab2)
// animtree2 . 0   (offset: 0x3ab2)
#using script_16ea1b94f0f381b3;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\br\br_quest_inventory;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_map_quest;
#using scripts\mp\challenges;
#using scripts\mp\common\equipment\claymore;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;

#namespace namespace_4ccadb5700124a4;

// Namespace namespace_4ccadb5700124a4
// Params 0, eflags: 0x5
// Checksum 0x4a8e5a83, Offset: 0x326
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"mtc_jackalope", #"br_map_quest", &pre_main, undefined );
}

// Namespace namespace_4ccadb5700124a4
// Params 0
// Checksum 0xcf7e6f97, Offset: 0x34f
// Size: 0x7a
function pre_main()
{
    quest = { #on_disabled:&on_disabled, #on_infil:&on_infil, #on_prematch_end:&on_prematch_end, #on_start:&on_start, #on_precache:&on_precache, #on_init:&on_init, #name:"mtc_jackalope" };
    br_map_quest::register( quest );
}

// Namespace namespace_4ccadb5700124a4
// Params 0
// Checksum 0x6ecf5387, Offset: 0x3d1
// Size: 0x28
function on_init()
{
    function_970d564ac5226b2e();
    setup_variables();
    function_1a00a5a2ba836d4d();
    setup_callbacks();
    
    /#
        debug_init();
    #/
}

// Namespace namespace_4ccadb5700124a4
// Params 0
// Checksum 0xb2941f53, Offset: 0x401
// Size: 0x2
function on_precache()
{
    
}

// Namespace namespace_4ccadb5700124a4
// Params 0
// Checksum 0x63e266d2, Offset: 0x40b
// Size: 0x2
function on_start()
{
    
}

// Namespace namespace_4ccadb5700124a4
// Params 0
// Checksum 0x8fa9bae3, Offset: 0x415
// Size: 0x2
function on_prematch_end()
{
    
}

// Namespace namespace_4ccadb5700124a4
// Params 0
// Checksum 0x744a1d7f, Offset: 0x41f
// Size: 0xa
function on_infil()
{
    level thread jackalope_spawn_manager();
}

// Namespace namespace_4ccadb5700124a4
// Params 0
// Checksum 0x5bb3fc58, Offset: 0x431
// Size: 0x2
function on_disabled()
{
    
}

// Namespace namespace_4ccadb5700124a4
// Params 0, eflags: 0x4
// Checksum 0xac31bd86, Offset: 0x43b
// Size: 0x2
function private function_970d564ac5226b2e()
{
    
}

// Namespace namespace_4ccadb5700124a4
// Params 0, eflags: 0x4
// Checksum 0x5aac455e, Offset: 0x445
// Size: 0xa4
function private setup_variables()
{
    level.jackalope = spawnstruct();
    level.jackalope.taxidermy_mount = getentitylessscriptablearray( "jackalope_taxidermy", "script_noteworthy" )[ 0 ];
    level.jackalope.speed = getdvarint( @"scr_jackalope_speed", 18 );
    level.jackalope.var_c8311f68a1a2f25e = squared( level.jackalope.speed );
    level.jackalope.tracker_weight = getdvarfloat( @"hash_1ea46955a22a2abc", 100 );
}

// Namespace namespace_4ccadb5700124a4
// Params 0, eflags: 0x4
// Checksum 0x7112e144, Offset: 0x4f1
// Size: 0x11e
function private function_1a00a5a2ba836d4d()
{
    level.jackalope.var_ce862fce1bd991fc = getdvarint( @"hash_bd56f6db97b3dc48", 60 );
    level.jackalope.var_ce631dce1bb322ae = getdvarint( @"hash_bd7aecdb97dc4102", 120 );
    assert( level.jackalope.var_ce862fce1bd991fc <= level.jackalope.var_ce631dce1bb322ae );
    level.jackalope.a_s_spawn_locations = utility::getstructarray( "jackalope_spawn", "script_noteworthy" );
    
    foreach ( s in level.jackalope.a_s_spawn_locations )
    {
        s build_jackalope_path();
    }
}

// Namespace namespace_4ccadb5700124a4
// Params 0, eflags: 0x4
// Checksum 0xeb682c73, Offset: 0x617
// Size: 0x32
function private setup_callbacks()
{
    level.jackalope.taxidermy_mount interaction::set_interact_hint_callback( &function_395dd9786b62b384 );
    scriptable::scriptable_addusedcallbackbypart( "jackalope_taxidermy_mount", &jackalope_taxidermy_mount_used );
}

// Namespace namespace_4ccadb5700124a4
// Params 2
// Checksum 0x5fd367fd, Offset: 0x651
// Size: 0xc8
function function_395dd9786b62b384( usable, player )
{
    if ( !isdefined( player ) )
    {
        return { #string:&"", #type:"HINT_NOICON" };
    }
    
    if ( !player br_quest_inventory::has_quest_item( "wz_consumable_quest_jackalope" ) )
    {
        return { #string:&"", #type:"HINT_NOICON" };
    }
    
    if ( usable getscriptablepartstate( "jackalope_taxidermy_mount" ) == "visible" )
    {
        return { #string:&"", #type:"HINT_NOICON" };
    }
    
    return { #string:&"mp_br_ingame/jackalope_taxidermy_mount", #type:"HINT_BUTTON" };
}

// Namespace namespace_4ccadb5700124a4
// Params 0
// Checksum 0x11578355, Offset: 0x722
// Size: 0xad
function build_jackalope_path()
{
    self.path = [];
    
    if ( !isdefined( self.target ) )
    {
        return;
    }
    
    self.path[ self.path.size ] = utility::getstruct( self.target, "targetname" );
    
    while ( isdefined( self.path[ self.path.size - 1 ].target ) )
    {
        self.path[ self.path.size ] = utility::getstruct( self.path[ self.path.size - 1 ].target, "targetname" );
    }
}

// Namespace namespace_4ccadb5700124a4
// Params 0
// Checksum 0xad77c3ec, Offset: 0x7d7
// Size: 0xe0
function jackalope_spawn_manager()
{
    level endon( #"game_ended" );
    level endon( #"jackalope_death" );
    level endon( #"hash_ab403a6631fb8b1d" );
    
    while ( true )
    {
        jackalope = jackalope_spawn();
        jackalope thread function_823df0f0fd5c9e48();
        jackalope thread jackalope_damage_watcher();
        jackalope jackalope_behavior();
        jackalope jackalope_despawn();
        
        if ( level.jackalope.var_ce862fce1bd991fc != level.jackalope.var_ce631dce1bb322ae )
        {
            cooldown = randomintrange( level.jackalope.var_ce862fce1bd991fc, level.jackalope.var_ce631dce1bb322ae + 1 );
        }
        else
        {
            cooldown = level.jackalope.var_ce862fce1bd991fc;
        }
        
        wait cooldown;
    }
}

// Namespace namespace_4ccadb5700124a4
// Params 0
// Checksum 0xc132ef51, Offset: 0x8bf
// Size: 0x3ba
function jackalope_spawn()
{
    level endon( #"game_ended" );
    s_spawn = undefined;
    roll = randomint( 100 );
    
    while ( !isdefined( s_spawn ) )
    {
        if ( roll < level.jackalope.tracker_weight )
        {
            trackers = [];
            
            foreach ( player in level.players )
            {
                if ( player::isreallyalive( player ) && isdefined( player.perks[ "specialty_combat_tracker" ] ) )
                {
                    trackers[ trackers.size ] = player;
                }
            }
            
            if ( trackers.size )
            {
                tracker = utility::array_random( trackers );
            }
            
            if ( tracker )
            {
                s_spawn = function_b21056d585c710d( level.jackalope.a_s_spawn_locations, tracker.origin );
            }
        }
        
        if ( !isdefined( s_spawn ) )
        {
            s_spawn = utility::array_random( level.jackalope.a_s_spawn_locations );
        }
        
        while ( s_spawn == level.jackalope.previous_spawn )
        {
            if ( level.jackalope.a_s_spawn_locations.size == 1 )
            {
                level notify( #"hash_ab403a6631fb8b1d" );
                return;
            }
            
            s_spawn = utility::array_random( level.jackalope.a_s_spawn_locations );
            waitframe();
        }
        
        if ( !function_9979dbe7a54a5b9c( s_spawn ) )
        {
            /#
                s_spawn notify( #"hash_d99e1d95502ab895" );
                
                foreach ( s in s_spawn.path )
                {
                    s notify( #"hash_d99e1d95502ab895" );
                }
            #/
            
            level.jackalope.a_s_spawn_locations = arrayremove( level.jackalope.a_s_spawn_locations, s_spawn );
            s_spawn = undefined;
            
            if ( !level.jackalope.a_s_spawn_locations.size )
            {
                level notify( #"hash_ab403a6631fb8b1d" );
                return;
            }
        }
    }
    
    level.jackalope.previous_spawn = s_spawn;
    
    /#
        if ( isdefined( level.jackalope.var_ca36ca60bda383fd ) )
        {
            for ( i = level.jackalope.var_ca36ca60bda383fd; i > 0 ; i-- )
            {
                debug::print3d( s_spawn.origin, i, undefined, 1, undefined, undefined, undefined, 25, 100 );
                wait 1;
            }
        }
    #/
    
    level thread jackalope_spawn_fx( s_spawn.origin );
    jackalope = spawn( "script_model", s_spawn.origin );
    jackalope.s_spawn = s_spawn;
    jackalope setscale( 1.5 );
    jackalope setmodel( "saw_mc_jackalope_01" );
    jackalope setcandamage( 1 );
    waitframe();
    jackalope setscriptablepartstate( "jackalope_animated", "idle" );
    
    /#
        if ( getdvarint( @"hash_a2b10fac35acf6b4" ) )
        {
            debug::sphere( jackalope, 150, "<dev string:x24>", undefined, "<dev string:x28>", "<dev string:x28>" );
        }
    #/
    
    return jackalope;
}

// Namespace namespace_4ccadb5700124a4
// Params 1, eflags: 0x4
// Checksum 0x6011ea23, Offset: 0xc82
// Size: 0x96, Type: bool
function private function_9979dbe7a54a5b9c( s_spawn )
{
    foreach ( s in s_spawn.path )
    {
        if ( br_circle::function_6bf5d4e680297398( s.origin ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace namespace_4ccadb5700124a4
// Params 1
// Checksum 0x9a982881, Offset: 0xd21
// Size: 0x39
function jackalope_spawn_fx( v_spawn )
{
    level endon( #"game_ended" );
    fx = spawnscriptable( "jackalope_spawn_fx", v_spawn );
    wait 2;
    fx freescriptable();
}

// Namespace namespace_4ccadb5700124a4
// Params 1
// Checksum 0x9a982881, Offset: 0xd62
// Size: 0x39
function jackalope_despawn_fx( v_spawn )
{
    level endon( #"game_ended" );
    fx = spawnscriptable( "jackalope_despawn_fx", v_spawn );
    wait 2;
    fx freescriptable();
}

// Namespace namespace_4ccadb5700124a4
// Params 0
// Checksum 0x3e209cb6, Offset: 0xda3
// Size: 0x227
function function_823df0f0fd5c9e48()
{
    level endon( #"game_ended" );
    self endon( #"entitydeleted" );
    contents = physics_createcontents( [ "physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_glass", "physicscontents_water" ] );
    
    while ( true )
    {
        foreach ( grenade in level.grenades )
        {
            if ( grenade.equipmentref != "equip_claymore" )
            {
                continue;
            }
            
            if ( distance2dsquared( self.origin, grenade.origin ) > squared( 100 ) )
            {
                continue;
            }
            
            forward = anglestoforward( grenade.angles );
            up = anglestoup( grenade.angles );
            btwn = self.origin - grenade.origin;
            var_5d36b0dd458f541d = vectordot( btwn, forward );
            
            if ( var_5d36b0dd458f541d > 90 )
            {
                continue;
            }
            
            var_e0c5702bc28fce7d = vectordot( btwn, up );
            
            if ( abs( var_e0c5702bc28fce7d ) > 32 )
            {
                continue;
            }
            
            var_da5b527c1a410a9f = vectornormalize( btwn );
            var_5a089502e5e472f7 = vectordot( var_da5b527c1a410a9f, forward );
            
            if ( var_5a089502e5e472f7 < 0.86602 )
            {
                continue;
            }
            
            ignorelist = [];
            castresults = physics_raycast( grenade.origin, self.origin, contents, ignorelist, 0, "physicsquery_closest", 1 );
            
            if ( castresults.size > 0 )
            {
                continue;
            }
            
            grenade thread claymore::claymore_explode( grenade.owner );
        }
        
        wait level.framedurationseconds;
    }
}

// Namespace namespace_4ccadb5700124a4
// Params 0
// Checksum 0xd5759e8a, Offset: 0xfd2
// Size: 0x46
function jackalope_damage_watcher()
{
    level endon( #"game_ended" );
    self endon( #"hash_606f5dbc09943e04" );
    self waittill( #"damage", damage, attacker );
    jackalope_death( attacker );
}

// Namespace namespace_4ccadb5700124a4
// Params 0
// Checksum 0x52d4c93f, Offset: 0x1020
// Size: 0x1b8
function jackalope_behavior()
{
    level endon( #"jackalope_death" );
    assert( isdefined( self.s_spawn ) && isdefined( self.s_spawn.path ) );
    
    foreach ( var_f78511be97bccc3f in self.s_spawn.path )
    {
        self setscriptablepartstate( "jackalope_animated", "run" );
        self.angles = vectortoangles( var_f78511be97bccc3f.origin - self.origin );
        
        while ( true )
        {
            if ( distance2dsquared( self.origin, var_f78511be97bccc3f.origin ) > level.jackalope.var_c8311f68a1a2f25e )
            {
                step = self.origin + vectornormalize( var_f78511be97bccc3f.origin - self.origin ) * level.jackalope.speed * 2;
                trace = getgroundposition( step, 5 );
                self moveto( trace, level.framedurationseconds * 2 );
            }
            else
            {
                self moveto( var_f78511be97bccc3f.origin, level.framedurationseconds );
                wait level.framedurationseconds;
                break;
            }
            
            wait level.framedurationseconds;
        }
    }
}

// Namespace namespace_4ccadb5700124a4
// Params 0
// Checksum 0xc08cf86b, Offset: 0x11e0
// Size: 0x25
function jackalope_despawn()
{
    self notify( #"hash_606f5dbc09943e04" );
    level thread jackalope_despawn_fx( self.origin );
    self delete();
}

// Namespace namespace_4ccadb5700124a4
// Params 1
// Checksum 0x901f67f6, Offset: 0x120d
// Size: 0x98
function jackalope_death( attacker )
{
    level notify( #"jackalope_death" );
    level thread jackalope_death_fx( self.origin );
    var_5941a494da8b8465 = common_cache::function_73fc13f2febd3a2( "br_quest_jackalope" );
    spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
    common_item::function_38cde6a6acb68ea6( var_5941a494da8b8465.spawnlistname, var_5941a494da8b8465.spawncount, spawnoptions );
    level.jackalope.taxidermy_mount setscriptablepartstate( "jackalope_taxidermy_mount", "invisible" );
    self delete();
}

// Namespace namespace_4ccadb5700124a4
// Params 1
// Checksum 0x9a982886, Offset: 0x12ad
// Size: 0x39
function jackalope_death_fx( v_spawn )
{
    level endon( #"game_ended" );
    fx = spawnscriptable( "jackalope_death_fx", v_spawn );
    wait 5;
    fx freescriptable();
}

// Namespace namespace_4ccadb5700124a4
// Params 6
// Checksum 0xad60dd9e, Offset: 0x12ee
// Size: 0x440
function jackalope_taxidermy_mount_used( scriptable, part, state, player, bautouse, usestring )
{
    level endon( #"game_ended" );
    
    if ( player br_quest_inventory::has_quest_item( "wz_consumable_quest_jackalope" ) )
    {
        player br_quest_inventory::consume_quest_item( "wz_consumable_quest_jackalope" );
        challenges::function_37e945722d6497f3( player, "manticore_sq_jackalope", 1, 1 );
        scriptable setscriptablepartstate( "jackalope_taxidermy_mount", "visible" );
        var_ded4e8183160df51 = scriptable.origin;
        var_ded4e8183160df51 += anglestoforward( scriptable.angles ) * ( 0, 0, -55 )[ 0 ];
        var_ded4e8183160df51 += anglestoright( scriptable.angles ) * ( 0, 0, -55 )[ 1 ];
        var_ded4e8183160df51 += ( 0, 0, ( 0, 0, -55 )[ 2 ] );
        var_40a0117d8c10e208 = scriptable.origin;
        var_40a0117d8c10e208 += anglestoforward( scriptable.angles ) * ( 30, 0, -73 )[ 0 ];
        var_40a0117d8c10e208 += anglestoright( scriptable.angles ) * ( 30, 0, -73 )[ 1 ];
        var_40a0117d8c10e208 += ( 0, 0, ( 30, 0, -73 )[ 2 ] );
        
        if ( game_utility::function_f24780eadd3fb772() < 3 )
        {
            static_fx = spawnscriptable( "jackalope_reward_static_fx", var_ded4e8183160df51 );
            mover = spawn( "script_model", var_ded4e8183160df51 + ( 0, 0, 200 ) );
            mobile_fx = spawnscriptable( "jackalope_reward_mobile_fx", mover.origin );
            mobile_fx scriptablesetparententity( mover );
            mover moveto( var_ded4e8183160df51, 2 );
            wait 2;
            bundle = common_item::function_cf68ad18114498b2( "specialty_specialist" );
            spawnoptions = common_item::function_f5dfaa3bbdf99a33( var_40a0117d8c10e208, var_ded4e8183160df51, scriptable.angles );
            spawnoptions.critical = 1;
            item = common_item::function_61c2c0251e742ffd( bundle, 1, spawnoptions );
            i = 0;
            
            while ( i < 2 )
            {
                if ( isdefined( item ) )
                {
                    mover.origin = item.origin;
                }
                
                wait level.framedurationseconds;
                i += level.framedurationseconds;
            }
            
            mobile_fx freescriptable();
            static_fx freescriptable();
            mover delete();
            return;
        }
        
        v_to_1 = var_ded4e8183160df51 + rotatevector( var_40a0117d8c10e208 - var_ded4e8183160df51, ( 0, -30, 0 ) );
        var_d8265398a3cee1b3 = spawnscriptable( "jackalope_reward_static_fx", var_ded4e8183160df51 );
        mover_1 = spawn( "script_model", var_ded4e8183160df51 + ( 0, 0, 200 ) );
        var_df2483bf8891f2db = spawnscriptable( "jackalope_reward_mobile_fx", mover_1.origin );
        var_df2483bf8891f2db scriptablesetparententity( mover_1 );
        mover_1 moveto( var_ded4e8183160df51, 2 );
        wait 1;
        v_to_2 = var_ded4e8183160df51 + rotatevector( var_40a0117d8c10e208 - var_ded4e8183160df51, ( 0, 30, 0 ) );
        var_d8265498a3cee3e6 = spawnscriptable( "jackalope_reward_static_fx", var_ded4e8183160df51 );
        mover_2 = spawn( "script_model", var_ded4e8183160df51 + ( 0, 0, 200 ) );
        var_df2484bf8891f50e = spawnscriptable( "jackalope_reward_mobile_fx", mover_2.origin );
        var_df2484bf8891f50e scriptablesetparententity( mover_2 );
        mover_2 moveto( var_ded4e8183160df51, 2 );
        wait 1;
        bundle = common_item::function_cf68ad18114498b2( "specialty_specialist" );
        spawnoptions = common_item::function_f5dfaa3bbdf99a33( v_to_1, var_ded4e8183160df51, scriptable.angles );
        spawnoptions.critical = 1;
        item = common_item::function_61c2c0251e742ffd( bundle, 1, spawnoptions );
        wait 1;
        bundle = common_item::function_cf68ad18114498b2( "specialty_specialist" );
        spawnoptions = common_item::function_f5dfaa3bbdf99a33( v_to_2, var_ded4e8183160df51, scriptable.angles );
        spawnoptions.critical = 1;
        item = common_item::function_61c2c0251e742ffd( bundle, 1, spawnoptions );
    }
}

/#

    // Namespace namespace_4ccadb5700124a4
    // Params 0
    // Checksum 0xbb67962a, Offset: 0x1736
    // Size: 0x5, Type: dev
    function function_281fd8b149568957()
    {
        
    }

    // Namespace namespace_4ccadb5700124a4
    // Params 0, eflags: 0x4
    // Checksum 0xd4215693, Offset: 0x1743
    // Size: 0x75, Type: dev
    function private debug_init()
    {
        devgui_init();
        utility::function_95db22f620602461( @"hash_a2b10fac35acf6b4", &function_3c67950bbac0b15f );
        utility::function_95db22f620602461( @"hash_9d160d97bbd4227f", &function_b67bc7af2b8d12a2 );
        utility::function_95db22f620602461( @"hash_257b990cdcbcdad7", &function_db526144ea812e5e );
        utility::function_95db22f620602461( @"hash_cc31e06dfc149a51", &function_109e56d7145bea60 );
        utility::function_95db22f620602461( @"scr_jackalope_spawn_delay", &function_3a954417744a193e );
    }

    // Namespace namespace_4ccadb5700124a4
    // Params 0, eflags: 0x4
    // Checksum 0xeb4a62fb, Offset: 0x17c0
    // Size: 0xce, Type: dev
    function private devgui_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x52>" + level.mapname + "<dev string:x61>" + "<dev string:x63>" + "<dev string:x61>" );
        devgui::add_devgui_func( "<dev string:x71>", "<dev string:x87>", &function_2b0452c0cda64cdd );
        devgui::add_devgui_func( "<dev string:xa3>", "<dev string:xbf>", &function_54d62dc04fbcee82 );
        devgui::add_devgui_func( "<dev string:xe1>", "<dev string:xf5>", &function_db526144ea812e5e );
        devgui::add_devgui_func( "<dev string:x10f>", "<dev string:x122>", &function_b49c3ed98f1bce8e );
        devgui::add_devgui_func( "<dev string:x13b>", "<dev string:x152>", &function_4f46af49a30f1e4f );
        devgui::add_devgui_func( "<dev string:x16f>", "<dev string:x18a>", &function_764a679cb8df84db );
        devgui::add_devgui_func( "<dev string:x1aa>", "<dev string:x1be>", &function_fa56cccdf5253cc8 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_4ccadb5700124a4
    // Params 0, eflags: 0x4
    // Checksum 0xbf2e4517, Offset: 0x1896
    // Size: 0x5b, Type: dev
    function private function_2b0452c0cda64cdd()
    {
        if ( !getdvarint( @"hash_a2b10fac35acf6b4" ) )
        {
            setdvar( @"hash_a2b10fac35acf6b4", 1 );
            iprintlnbold( "<dev string:x1d8>" );
            level thread function_3c67950bbac0b15f();
            return;
        }
        
        setdvar( @"hash_a2b10fac35acf6b4", 0 );
        iprintlnbold( "<dev string:x1f7>" );
        function_98a0f1cbb5ebe4e3();
    }

    // Namespace namespace_4ccadb5700124a4
    // Params 0, eflags: 0x4
    // Checksum 0x6c71077, Offset: 0x18f9
    // Size: 0x15d, Type: dev
    function private function_3c67950bbac0b15f()
    {
        foreach ( s in level.jackalope.a_s_spawn_locations )
        {
            debug::sphere( s, 1, "<dev string:x217>", undefined, "<dev string:x28>", "<dev string:x28>" );
            debug::sphere( s, 100, "<dev string:x217>", undefined, "<dev string:x28>", "<dev string:x28>" );
            assert( isdefined( s.path ) );
            debug::line( s, s.path[ 0 ], "<dev string:x217>", undefined, "<dev string:x28>", "<dev string:x28>" );
            
            if ( s.path.size > 1 )
            {
                for ( i = 0; i < s.path.size - 1 ; i++ )
                {
                    debug::line( s.path[ i ], s.path[ i + 1 ], "<dev string:x217>", undefined, "<dev string:x28>", "<dev string:x28>" );
                }
            }
        }
    }

    // Namespace namespace_4ccadb5700124a4
    // Params 0, eflags: 0x4
    // Checksum 0x54e7e747, Offset: 0x1a5e
    // Size: 0x11, Type: dev
    function private function_98a0f1cbb5ebe4e3()
    {
        level notify( #"hash_d99e1d95502ab895" );
    }

    // Namespace namespace_4ccadb5700124a4
    // Params 0, eflags: 0x4
    // Checksum 0x4b0b4719, Offset: 0x1a77
    // Size: 0x5a, Type: dev
    function private function_54d62dc04fbcee82()
    {
        if ( !getdvarint( @"hash_9d160d97bbd4227f" ) )
        {
            setdvar( @"hash_9d160d97bbd4227f", 1 );
            iprintlnbold( "<dev string:x21d>" );
            function_b67bc7af2b8d12a2();
            return;
        }
        
        setdvar( @"hash_9d160d97bbd4227f", 0 );
        iprintlnbold( "<dev string:x242>" );
        function_df6e1a3cc766f654();
    }

    // Namespace namespace_4ccadb5700124a4
    // Params 0, eflags: 0x4
    // Checksum 0xfc76acdd, Offset: 0x1ad9
    // Size: 0x53, Type: dev
    function private function_b67bc7af2b8d12a2()
    {
        debug::sphere( level.jackalope.taxidermy_mount, 1, "<dev string:x268>", undefined, "<dev string:x242>" );
        debug::sphere( level.jackalope.taxidermy_mount, 100, "<dev string:x268>", undefined, "<dev string:x242>" );
    }

    // Namespace namespace_4ccadb5700124a4
    // Params 0, eflags: 0x4
    // Checksum 0xda210d0d, Offset: 0x1b34
    // Size: 0x11, Type: dev
    function private function_df6e1a3cc766f654()
    {
        level notify( #"hash_3feddd807ca6749" );
    }

    // Namespace namespace_4ccadb5700124a4
    // Params 0, eflags: 0x4
    // Checksum 0x3b104ddf, Offset: 0x1b4d
    // Size: 0x5b, Type: dev
    function private function_fa56cccdf5253cc8()
    {
        if ( !getdvarint( @"hash_cc31e06dfc149a51" ) )
        {
            setdvar( @"hash_cc31e06dfc149a51", 1 );
            iprintlnbold( "<dev string:x26f>" );
            level thread function_109e56d7145bea60();
            return;
        }
        
        setdvar( @"hash_cc31e06dfc149a51", 0 );
        iprintlnbold( "<dev string:x28c>" );
        function_e8463101c64a5c7a();
    }

    // Namespace namespace_4ccadb5700124a4
    // Params 0, eflags: 0x4
    // Checksum 0x4d834aea, Offset: 0x1bb0
    // Size: 0xd, Type: dev
    function private function_109e56d7145bea60()
    {
        level thread function_8b9b3d808c9375c9();
    }

    // Namespace namespace_4ccadb5700124a4
    // Params 0, eflags: 0x4
    // Checksum 0x72c19b54, Offset: 0x1bc5
    // Size: 0xde, Type: dev
    function private function_8b9b3d808c9375c9()
    {
        level endon( #"game_ended" );
        level endon( #"hash_3055c978765a1ae7" );
        
        while ( !isdefined( level.player ) )
        {
            waitframe();
        }
        
        trace_contents = trace::create_contents( 1, 1, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0 );
        
        while ( true )
        {
            starttrace = level.player getvieworigin();
            endtrace = starttrace + anglestoforward( level.player getplayerangles() ) * 1000;
            trace = trace::ray_trace( starttrace, endtrace, level.player, trace_contents );
            sphere( trace[ "<dev string:x2aa>" ], 1, ( 1, 1, 1 ), 0, 1 );
            iprintlnbold( trace[ "<dev string:x2aa>" ] );
            waitframe();
        }
    }

    // Namespace namespace_4ccadb5700124a4
    // Params 0, eflags: 0x4
    // Checksum 0x51e969be, Offset: 0x1cab
    // Size: 0x11, Type: dev
    function private function_e8463101c64a5c7a()
    {
        level notify( #"hash_3055c978765a1ae7" );
    }

    // Namespace namespace_4ccadb5700124a4
    // Params 0, eflags: 0x4
    // Checksum 0xa8bf2fed, Offset: 0x1cc4
    // Size: 0x5c, Type: dev
    function private function_db526144ea812e5e()
    {
        if ( !getdvarint( @"hash_257b990cdcbcdad7" ) )
        {
            setdvar( @"hash_257b990cdcbcdad7", 1 );
            iprintlnbold( "<dev string:x2b3>" );
            level thread function_a9ac55f5b463c98e();
            return;
        }
        
        setdvar( @"hash_257b990cdcbcdad7", 0 );
        iprintlnbold( "<dev string:x2d0>" );
        level thread function_89a7035bb74cb1b0();
    }

    // Namespace namespace_4ccadb5700124a4
    // Params 0, eflags: 0x4
    // Checksum 0x8a9d2bd8, Offset: 0x1d28
    // Size: 0x2c, Type: dev
    function private function_a9ac55f5b463c98e()
    {
        while ( !isdefined( level.player ) )
        {
            waitframe();
        }
        
        level.player namespace_9d8e359c3b1041e5::giveperksharedfunc( "<dev string:x2ee>" );
    }

    // Namespace namespace_4ccadb5700124a4
    // Params 0, eflags: 0x4
    // Checksum 0x5dd77ef7, Offset: 0x1d5c
    // Size: 0x2c, Type: dev
    function private function_89a7035bb74cb1b0()
    {
        while ( !isdefined( level.player ) )
        {
            waitframe();
        }
        
        level.player namespace_9d8e359c3b1041e5::removeperksharedfunc( "<dev string:x2ee>" );
    }

    // Namespace namespace_4ccadb5700124a4
    // Params 0, eflags: 0x4
    // Checksum 0xfcff0240, Offset: 0x1d90
    // Size: 0xc5, Type: dev
    function private function_4f46af49a30f1e4f()
    {
        bundle = common_item::function_cf68ad18114498b2( "<dev string:x307>" );
        spawn_options = common_item::function_bc5ff2958b71a708( level.player.origin + anglestoforward( level.player getplayerangles() ) * 30 + ( 0, 0, 50 ), -1 * level.player getplayerangles() );
        spawn_options.critical = 1;
        spawn_options.var_f35b5b18b029c493 = 0;
        item = common_item::function_61c2c0251e742ffd( bundle, 1, spawn_options );
        level.jackalope.taxidermy_mount setscriptablepartstate( "<dev string:x325>", "<dev string:x33f>" );
    }

    // Namespace namespace_4ccadb5700124a4
    // Params 0, eflags: 0x4
    // Checksum 0x62e65ebd, Offset: 0x1e5d
    // Size: 0x3f, Type: dev
    function private function_764a679cb8df84db()
    {
        level.player setorigin( ( -8576, 10919, 961 ), 1 );
        level.player setplayerangles( ( 0, 245, 0 ), 1 );
    }

    // Namespace namespace_4ccadb5700124a4
    // Params 0, eflags: 0x4
    // Checksum 0x80ebd7d1, Offset: 0x1ea4
    // Size: 0x42, Type: dev
    function private function_b49c3ed98f1bce8e()
    {
        if ( !isdefined( level.jackalope.var_ca36ca60bda383fd ) )
        {
            iprintlnbold( "<dev string:x349>" );
            function_3a954417744a193e();
            return;
        }
        
        iprintlnbold( "<dev string:x365>" );
        function_203ae794becf0b40();
    }

    // Namespace namespace_4ccadb5700124a4
    // Params 0, eflags: 0x4
    // Checksum 0x1f4828b7, Offset: 0x1eee
    // Size: 0x28, Type: dev
    function private function_3a954417744a193e()
    {
        level.jackalope.var_ca36ca60bda383fd = getdvarint( @"scr_jackalope_spawn_delay", 10 );
    }

    // Namespace namespace_4ccadb5700124a4
    // Params 0, eflags: 0x4
    // Checksum 0x94a25822, Offset: 0x1f1e
    // Size: 0x18, Type: dev
    function private function_203ae794becf0b40()
    {
        level.jackalope.var_ca36ca60bda383fd = undefined;
    }

#/
