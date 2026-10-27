// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_quest_ww.gsc  (hash_73e00865c3ff30e9.gscc) (size: 55855 Bytes / 0xda2f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x871435dd (2266248669)
// size ...... 55855 (0xda2f)
// includes .. 27  (offset: 0xcb6b)
// strings ... 232 (offset: 0xcc43)
// dev strs .. 9   (offset: 0xd9c3)
// exports ... 116 (offset: 0x87df)
// cseg ...... 0x1763 + 0x707c (0x87df)
// imports ... 363 (offset: 0x99ff)
// animtree1 . 0   (offset: 0xda2f)
// animtree2 . 0   (offset: 0xda2f)
#using script_236edd51aea4c314;
#using script_aa3bac81ad4fc8e;
#using scripts\anim\dialogue;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\magicbox;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_floating_rocks;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_sa;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_util;
#using scripts\mp\zm\spawners\zone_spawner;
#using scripts\mp\zm\systems\zm_cleanup_mgr;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_locust_quest_ww;

// Namespace zm_sat_locust_quest_ww
// Params 0, eflags: 0x5
// Checksum 0x699d2ed1, Offset: 0x1781
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"hash_709d77ab2b2005c5", #"zm_quest", &pre_main, &post_main );
}

// Namespace zm_sat_locust_quest_ww
// Params 0, eflags: 0x4
// Checksum 0x6a423048, Offset: 0x17ae
// Size: 0x35c
function private pre_main()
{
    if ( !getdvarint( @"hash_42cdb7fc777fae63", 0 ) )
    {
        return;
    }
    
    level.quest_ww = spawnstruct();
    level.quest_ww.var_b60c1fd3b1677216 = [];
    level.quest_ww.var_770c7f37c9e3f8b8 = getdvarint( @"hash_6d0beee32f12ec66", 8 );
    level.quest_ww.var_b86e2286c92d1298 = getdvarint( @"hash_6aa0b6c480b579ae", 12 );
    level.quest_ww.var_3e6e28049fd7e7c5 = getdvarint( @"hash_112028fbfcea3173", 8 );
    zm_quest::register_quest_step( #"hash_709d77ab2b2005c5", #"collect_parts", &function_7d6d613ab952c071, &function_60062348e78b78d6 );
    zm_quest::register_quest_step( #"hash_709d77ab2b2005c5", #"access_crypt", &function_7d6d5e3ab952b9d8, &function_60062248e78b76a3 );
    zm_quest::register_quest_step( #"hash_709d77ab2b2005c5", #"place_chain", &function_d83b7c9dbb71bb4c, &function_7820966986bcfeef );
    zm_quest::register_quest_step( #"hash_709d77ab2b2005c5", #"reveal_crypt", &function_d83b7f9dbb71c1e5, &function_7820976986bd0122 );
    zm_quest::register_quest_step( #"hash_709d77ab2b2005c5", #"crypt_puzzle", &function_7d6d5f3ab952bc0b, &function_60062148e78b7470 );
    zm_quest::register_quest_step( #"hash_709d77ab2b2005c5", #"place_lantern", &function_e963d59dc8feaa07, &function_66f87d6979309cf4 );
    zm_quest::register_quest_step( #"hash_709d77ab2b2005c5", #"solve_lantern", &function_e963d69dc8feac3a, &function_66f880697930a38d );
    zm_quest::register_quest_step( #"hash_709d77ab2b2005c5", #"follow_astrid", &function_7d6d643ab952c70a, &function_60062848e78b83d5 );
    zm_quest::register_quest_step( #"hash_709d77ab2b2005c5", #"through_market", &function_31f8869dfe36254a, &function_cc5da069c3749c2d );
    zm_quest::register_quest_step( #"hash_709d77ab2b2005c5", #"hash_8608a512dec03657", &function_31f8859dfe362317, &function_cc5d9d69c3749594 );
    zm_quest::register_quest_step( #"hash_709d77ab2b2005c5", #"through_town", &function_31f8849dfe3620e4, &function_cc5d9e69c37497c7 );
    zm_quest::register_quest_step( #"hash_709d77ab2b2005c5", #"hash_b5da1436fd9abf9f", &function_31f8839dfe361eb1, &function_cc5d9b69c374912e );
    zm_quest::register_quest_step( #"hash_709d77ab2b2005c5", #"first_platform", &function_7d6d653ab952c93d, &function_60062748e78b81a2 );
    zm_quest::register_quest_step( #"hash_709d77ab2b2005c5", #"access_first_platform", &function_3fd49f9e08230205, &function_c0b54769bbf47a32 );
    zm_quest::register_quest_step( #"hash_709d77ab2b2005c5", #"complete_first_platform", &function_3fd49c9e0822fb6c, &function_c0b54669bbf477ff );
    zm_quest::register_quest_step( #"hash_709d77ab2b2005c5", #"second_platform", &function_7d6d623ab952c2a4, &function_60062648e78b7f6f );
    zm_quest::register_quest_step( #"hash_709d77ab2b2005c5", #"access_second_platform", &function_1529189de92bdd20, &function_af8e3269ae6a5403 );
    zm_quest::register_quest_step( #"hash_709d77ab2b2005c5", #"complete_second_platform", &function_15291b9de92be3b9, &function_af8e3369ae6a5636 );
    zm_quest::register_quest_step( #"hash_709d77ab2b2005c5", #"enter_lighthouse", &function_7d6d633ab952c4d7, &function_60062548e78b7d3c );
    zm_quest::register_quest_step( #"hash_709d77ab2b2005c5", #"craft_ww", &function_7d6d583ab952aca6, &function_60062c48e78b8ca1 );
}

// Namespace zm_sat_locust_quest_ww
// Params 0, eflags: 0x4
// Checksum 0xb11e00ac, Offset: 0x1b12
// Size: 0x8c
function private post_main()
{
    magicbox::function_2e49cd8681e36211( 1 );
    
    if ( !getdvarint( @"hash_42cdb7fc777fae63", 0 ) )
    {
        return;
    }
    
    /#
        if ( isofflinetoolrun( 31 ) )
        {
            return;
        }
    #/
    
    level thread function_34b1bfdc9b9b643f();
    level thread function_82ddcd178f598134();
    level thread function_1734d59763d5edca();
    level thread function_9d0a4e3f78f7f571();
    level thread function_c947b5662067ef3();
    level thread init_platforms();
    level thread init_lighthouse();
    zm_save::function_1f44a48caae2acbf();
    function_6965e07e21a497ba();
    
    /#
        debug_init();
    #/
    
    level thread zm_quest::start_quest( #"hash_709d77ab2b2005c5" );
}

// Namespace zm_sat_locust_quest_ww
// Params 0, eflags: 0x4
// Checksum 0xdeaad002, Offset: 0x1ba6
// Size: 0x144
function private init_platforms()
{
    utility::flag_wait( "scriptables_ready" );
    platform_1 = {};
    platform_1.clip = getent( "wwq_path_1_clip", #targetname );
    platform_1.var_d3823b80b1397854 = getent( "wwq_path_1_tube", #targetname );
    platform_2 = {};
    platform_2.var_d3823b80b1397854 = getent( "wwq_path_2_tube", #targetname );
    platform_2.blocker = getent( "wwq_lh_blocker", #targetname );
    platform_2.blocker.rubble = getent( "wwq_rubble", #targetname );
    sky_clips = getentarray( "lighthouse_skyclip", #targetname );
    platform_2.blocker.rubble hide();
    zm_sat_locust_util::function_295a36ef38f5acae( #"ww_platform_1", platform_1 );
    zm_sat_locust_util::function_295a36ef38f5acae( #"ww_platform_2", platform_2 );
    zm_sat_locust_util::function_295a36ef38f5acae( #"ww_platform_skyclip", sky_clips );
    level callback::add( "on_zombie_ai_killed", &on_zombie_killed );
}

// Namespace zm_sat_locust_quest_ww
// Params 1, eflags: 0x4
// Checksum 0xd7faee04, Offset: 0x1cf2
// Size: 0x6a
function private on_zombie_killed( params )
{
    zone = zone_manager::get_current_zone();
    
    if ( zone.zone_name == "zone_lighthouse_int_puzzle" || zone.zone_name == "zone_lighthouse_int_puzzle_3" )
    {
        utility::ent_flag_set( "dissolve_purple" );
        utility::ent_flag_set( "dark_aether_bubble" );
        self.var_a13bed1ac47e1b2c = 1;
    }
}

// Namespace zm_sat_locust_quest_ww
// Params 1, eflags: 0x4
// Checksum 0x515e49b0, Offset: 0x1d64
// Size: 0xfa
function private on_platform_zone_changed( params )
{
    prev_zone = params.previous_zone_struct;
    new_zone = params.zone_struct;
    
    if ( bgb::is_active( "anywhere_but_here" ) || bgb::is_active( "nowhere_but_there" ) )
    {
        return;
    }
    
    if ( prev_zone.zone_name == "zone_lighthouse_int_puzzle" )
    {
        if ( !( new_zone.zone_name == "zone_lighthouse_int_puzzle_2" || new_zone.zone_name == "zone_downtown_dock" || new_zone.zone_name == "zone_lighthouse" ) )
        {
            zm_sat_locust_floating_rocks::function_b8628007359aae67();
            return;
        }
        
        return;
    }
    
    if ( prev_zone.zone_name == "zone_lighthouse_int_puzzle_3" )
    {
        if ( !( new_zone.zone_name == "zone_lighthouse_int_puzzle_2" || new_zone.zone_name == "zone_lighthouse_int_puzzle_4" ) )
        {
            zm_sat_locust_floating_rocks::function_b8628007359aae67();
            return;
        }
    }
}

// Namespace zm_sat_locust_quest_ww
// Params 0, eflags: 0xc
// Checksum 0x26b63f4e, Offset: 0x1e66
// Size: 0x171
function private function_46c6f25766d87633()
{
    self notify( #"hash_92230617a1bd378" );
    self endon( #"hash_92230617a1bd378" );
    level endon( #"game_ended" );
    level endon( #"ww_step_08" );
    
    for ( ;; )
    {
        foreach ( player in level.players )
        {
            if ( !isalive( player ) )
            {
                continue;
            }
            
            if ( player.is_resetting )
            {
                continue;
            }
            
            if ( player function_265bf714eef2b2a5( self.var_d3823b80b1397854, ( 0, 0, -8 ), player getboundshalfsize() ) )
            {
                if ( utility::flag( "ww_step_08" ) )
                {
                    spawn_point = player zone_manager::function_aeaa8dd788ed9b16( undefined, 0, undefined, undefined, undefined, 1 );
                }
                else if ( utility::flag( "ww_reset" ) )
                {
                    reset_zones = [ "zone_downtown", "zone_downtown_dock", "zone_downtown_meadhall", "zone_downtown_middle_street" ];
                    spawn_point = player zone_manager::function_aeaa8dd788ed9b16( undefined, 0, undefined, reset_zones, undefined, 1 );
                }
                
                player thread zm_sat_locust_floating_rocks::function_b8628007359aae67( spawn_point );
            }
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_locust_quest_ww
// Params 0, eflags: 0x4
// Checksum 0xaceaac7e, Offset: 0x1fdf
// Size: 0xe8
function private init_lighthouse()
{
    utility::flag_wait( "scriptables_ready" );
    utility::add_fx( "lighthouse_light_fx", "vfx_sat_levels_zm_locust_lighthouse_light" );
    lighthouse_light = getent( "lighthouse_light", #targetname );
    lighthouse_light forcenetfieldhighlod( 1 );
    var_fa64d5e8c08839e5 = getent( "lighthouse_lgt_2", #targetname );
    var_fa64d5e8c08839e5 linkto( lighthouse_light );
    lighthouse_light.starting_angles = lighthouse_light.angles;
    lighthouse_light thread function_64ef5a7ebb109000();
    zm_sat_locust_util::function_295a36ef38f5acae( #"ww_lighthouse_light", lighthouse_light );
    blocker = getent( "wwq_lh_door_clip", #targetname );
    blocker.door = getent( "wwq_door_2", #targetname );
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_33e2a7ad596be4d9", blocker );
}

// Namespace zm_sat_locust_quest_ww
// Params 0, eflags: 0x4
// Checksum 0x73db058, Offset: 0x20cf
// Size: 0x5e
function private function_64ef5a7ebb109000()
{
    self endon( #"lighthouse_off" );
    activateworldevent( "we_lighthouse_light" );
    self setscriptablepartstate( "base", "on" );
    playfxontag( utility::getfx( "lighthouse_light_fx" ), self, "tag_beam" );
    
    while ( true )
    {
        self rotateyaw( 360, 15 );
        self waittill( #"rotatedone" );
    }
}

// Namespace zm_sat_locust_quest_ww
// Params 0
// Checksum 0xedfb293a, Offset: 0x2135
// Size: 0x52
function function_d9bd466e1cf4c4a4()
{
    self notify( #"lighthouse_off" );
    deactivateworldevent( "we_lighthouse_light" );
    self rotateto( self.starting_angles, 1 );
    self setscriptablepartstate( "base", "off" );
    killfxontag( utility::getfx( "lighthouse_light_fx" ), self, "tag_beam" );
}

// Namespace zm_sat_locust_quest_ww
// Params 6, eflags: 0xc
// Checksum 0x895b3f2b, Offset: 0x218f
// Size: 0xc54
function private astrid_follow_path( flag, first = 0, skipped = 0, skip_initial = 0, step_ref, spawns_platforms = 0 )
{
    self notify( #"hash_5387d4962bec44ba" );
    self endon( #"hash_5387d4962bec44ba" );
    level endon( flag );
    zm_sat_locust_util::function_82f9bbbcb47ef102( #"hash_709d77ab2b2005c5", step_ref, "[astrid_follow_path] ENTER | flag: " + flag + " | first: " + first + " | skipped: " + skipped + " | skip_initial: " + skip_initial + " | spawns_platforms: " + spawns_platforms );
    astrid = zm_sat_locust_util::get_quest_reference( #"ww_astrid" );
    zm_sat_locust_util::function_82f9bbbcb47ef102( #"hash_709d77ab2b2005c5", step_ref, "[astrid_follow_path] astrid defined: " + isdefined( astrid ) + " | astrid.path defined: " + isdefined( astrid.path ) + " | astrid.origin: " + astrid.origin );
    can_skip = 0;
    
    if ( skipped )
    {
        zm_sat_locust_util::function_82f9bbbcb47ef102( #"hash_709d77ab2b2005c5", step_ref, "[astrid_follow_path] SKIP PATH - fast forwarding astrid position" );
        var_bb760a9ce53f7c96 = astrid.path;
        
        for ( ;; )
        {
            if ( !isdefined( var_bb760a9ce53f7c96.target ) )
            {
                zm_sat_locust_util::function_82f9bbbcb47ef102( #"hash_709d77ab2b2005c5", step_ref, "[astrid_follow_path] SKIP PATH - no more targets, breaking" );
                break;
            }
            
            if ( can_skip && var_bb760a9ce53f7c96.script_noteworthy == "end" )
            {
                zm_sat_locust_util::function_82f9bbbcb47ef102( #"hash_709d77ab2b2005c5", step_ref, "[astrid_follow_path] SKIP PATH - found 'end' node, breaking" );
                astrid.path = var_bb760a9ce53f7c96;
                break;
            }
            
            var_bb760a9ce53f7c96 = utility::getstruct( var_bb760a9ce53f7c96.target );
            
            if ( !isdefined( var_bb760a9ce53f7c96 ) )
            {
                zm_sat_locust_util::function_82f9bbbcb47ef102( #"hash_709d77ab2b2005c5", step_ref, "[astrid_follow_path] SKIP PATH - getstruct returned undefined, breaking" );
                break;
            }
            
            astrid scriptmodelclearanim();
            astrid dontinterpolate();
            astrid.origin = var_bb760a9ce53f7c96.origin;
            astrid.angles = var_bb760a9ce53f7c96.angles;
            can_skip = 1;
        }
        
        if ( astrid.Holdout && zm_sat_locust_util::is_holdout_event_active( astrid.Holdout.name ) )
        {
            zm_sat_locust_util::function_82f9bbbcb47ef102( #"hash_709d77ab2b2005c5", step_ref, "[astrid_follow_path] SKIP PATH - ending active holdout: " + astrid.Holdout.name );
            zm_sat_locust_util::end_holdout_event( astrid.Holdout.name );
            level thread zm_sat_locust_util::function_e87fbeb96f6b390f( #"hash_709d77ab2b2005c5", astrid.Holdout.step_ref );
            astrid.Holdout = undefined;
        }
        
        zm_sat_locust_util::function_82f9bbbcb47ef102( #"hash_709d77ab2b2005c5", step_ref, "[astrid_follow_path] SKIP PATH - setting flag: " + flag );
        utility::flag_set( flag );
    }
    
    this_loc = astrid.path;
    
    if ( isdefined( this_loc.target ) )
    {
        var_bb760a9ce53f7c96 = utility::getstruct( this_loc.target );
    }
    
    zm_sat_locust_util::function_82f9bbbcb47ef102( #"hash_709d77ab2b2005c5", step_ref, "[astrid_follow_path] this_loc defined: " + isdefined( this_loc ) + " | this_loc.target defined: " + isdefined( this_loc.target ) + " | next_loc defined: " + isdefined( var_bb760a9ce53f7c96 ) );
    
    if ( first )
    {
        zm_sat_locust_util::function_82f9bbbcb47ef102( #"hash_709d77ab2b2005c5", step_ref, "[astrid_follow_path] FIRST - playing intro scene" );
        var_2bb3c93124521d70 = [ "intro_spawn", "intro_dialogue", "teleport_out" ];
        level thread function_739003bbba5c3ec7( 12 );
        this_loc scene::play( astrid, var_2bb3c93124521d70 );
        zm_sat_locust_util::function_82f9bbbcb47ef102( #"hash_709d77ab2b2005c5", step_ref, "[astrid_follow_path] FIRST - intro scene completed" );
        closest_player = zm_sat_locust_util::get_closest_hero( astrid.origin, 256 );
        level thread function_f60e2ecf41697e81( closest_player );
        astrid scriptmodelclearanim();
        waitframe();
        
        if ( isdefined( var_bb760a9ce53f7c96 ) )
        {
            zm_sat_locust_util::function_82f9bbbcb47ef102( #"hash_709d77ab2b2005c5", step_ref, "[astrid_follow_path] FIRST - starting wisp move" );
            astrid function_381bb66e5c649be7( this_loc, var_bb760a9ce53f7c96 );
            zm_sat_locust_util::function_82f9bbbcb47ef102( #"hash_709d77ab2b2005c5", step_ref, "[astrid_follow_path] FIRST - wisp move completed" );
        }
        
        if ( zm_quest::function_b0a5181ebe7bb905() )
        {
            utility::flag_set( "ww_dm_follow" );
            level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
        }
    }
    
    zm_sat_locust_util::function_82f9bbbcb47ef102( #"hash_709d77ab2b2005c5", step_ref, "[astrid_follow_path] entering main loop | can_skip: " + can_skip + " | skip_initial: " + skip_initial );
    iteration = 0;
    
    for ( ;; )
    {
        iteration++;
        zm_sat_locust_util::function_82f9bbbcb47ef102( #"hash_709d77ab2b2005c5", step_ref, "[astrid_follow_path] LOOP iteration " + iteration + " | this_loc.target defined: " + isdefined( this_loc.target ) + " | can_skip: " + can_skip + " | skip_initial: " + skip_initial );
        
        if ( !isdefined( this_loc.target ) )
        {
            zm_sat_locust_util::function_82f9bbbcb47ef102( #"hash_709d77ab2b2005c5", step_ref, "[astrid_follow_path] LOOP BREAK - this_loc.target is undefined" );
            break;
        }
        
        if ( can_skip && this_loc.script_noteworthy == "end" )
        {
            zm_sat_locust_util::function_82f9bbbcb47ef102( #"hash_709d77ab2b2005c5", step_ref, "[astrid_follow_path] LOOP BREAK - found 'end' node with can_skip" );
            astrid.path = this_loc;
            break;
        }
        
        if ( skip_initial )
        {
            zm_sat_locust_util::function_82f9bbbcb47ef102( #"hash_709d77ab2b2005c5", step_ref, "[astrid_follow_path] LOOP CONTINUE - skip_initial, skipping first node" );
            skip_initial = 0;
            continue;
        }
        
        var_bb760a9ce53f7c96 = utility::getstruct( this_loc.target );
        
        if ( !isdefined( var_bb760a9ce53f7c96 ) )
        {
            zm_sat_locust_util::function_82f9bbbcb47ef102( #"hash_709d77ab2b2005c5", step_ref, "[astrid_follow_path] LOOP BREAK - next_loc getstruct returned undefined" );
            break;
        }
        
        zm_sat_locust_util::function_82f9bbbcb47ef102( #"hash_709d77ab2b2005c5", step_ref, "[astrid_follow_path] moving astrid to next_loc | origin: " + var_bb760a9ce53f7c96.origin + " | script_string: " + var_bb760a9ce53f7c96.script_string + " | script_noteworthy: " + var_bb760a9ce53f7c96.script_noteworthy + " | script_label: " + var_bb760a9ce53f7c96.script_label + " | radius: " + var_bb760a9ce53f7c96.radius );
        astrid dontinterpolate();
        astrid.origin = var_bb760a9ce53f7c96.origin;
        astrid.angles = var_bb760a9ce53f7c96.angles;
        waitframe();
        var_2bb3c93124521d70 = [ "teleport_in", "wait_idle" ];
        var_bb760a9ce53f7c96 thread scene::play( astrid, var_2bb3c93124521d70 );
        
        if ( astrid )
        {
            wait 0.25;
            astrid show();
        }
        
        zm_sat_locust_util::function_82f9bbbcb47ef102( #"hash_709d77ab2b2005c5", step_ref, "[astrid_follow_path] astrid shown, waiting for player proximity | radius: " + ( var_bb760a9ce53f7c96.script_radius ?? 600 ) + " | astrid.origin: " + astrid.origin + " | next_loc.origin: " + var_bb760a9ce53f7c96.origin );
        player = zm_sat_locust_util::function_abbae1f498a00649( flag, var_bb760a9ce53f7c96.origin + ( 0, 0, 40 ), var_bb760a9ce53f7c96.script_radius ?? 600 );
        zm_sat_locust_util::function_82f9bbbcb47ef102( #"hash_709d77ab2b2005c5", step_ref, "[astrid_follow_path] player proximity triggered | player defined: " + isdefined( player ) );
        astrid.player_trigger = player;
        exit_anim = "teleport_out";
        
        if ( var_bb760a9ce53f7c96.script_label == "right" )
        {
            exit_anim = "teleport_right";
        }
        else if ( var_bb760a9ce53f7c96.script_label == "left" )
        {
            exit_anim = "teleport_left";
        }
        
        if ( isdefined( var_bb760a9ce53f7c96.script_string ) )
        {
            zm_sat_locust_util::function_82f9bbbcb47ef102( #"hash_709d77ab2b2005c5", step_ref, "[astrid_follow_path] HOLDOUT NODE - starting holdout: " + var_bb760a9ce53f7c96.script_string + " | spawn_zone: " + var_bb760a9ce53f7c96.script_parameters + " | holdout_radius: " + var_bb760a9ce53f7c96.radius );
            level thread function_739003bbba5c3ec7( 17 );
            var_2bb3c93124521d70 = [ "weakened_intro", "weakened_dialogue", "weakened_idle" ];
            var_bb760a9ce53f7c96 thread scene::play( astrid, var_2bb3c93124521d70 );
            zm_sat_locust_util::function_d500031798dc2c12( #"hash_709d77ab2b2005c5", step_ref );
            var_5cfd36d664316522 = level.players.size == 1 ? level.quest_ww.var_770c7f37c9e3f8b8 : level.quest_ww.var_b86e2286c92d1298;
            params = { #step_ref:step_ref, #radius:var_bb760a9ce53f7c96.radius, #pending_count:0, #absorb_count:0, #var_201aaa0c57618626:0, #on_zombie_killed:&function_97e29f763b6c5d12, #max_active_zombies:var_5cfd36d664316522, #var_98f23c369371e8ec:1, #var_d346909023f61570:1, #difficulty_round_number:function_679d83d9264e985f(), #spawner_zombie_type:"zombie_base_luna", #var_1e899b25f3766233:1, #spawn_zones:[ zone_manager::get_zone_struct( var_bb760a9ce53f7c96.script_parameters ) ], #name:var_bb760a9ce53f7c96.script_string };
            astrid.Holdout = params;
            
            if ( zm_quest::function_b0a5181ebe7bb905() )
            {
                astrid game_utility::questcircle_create( "testCircle_Orange", astrid.origin, params.radius );
                astrid game_utility::questcircle_showtoall();
            }
            
            zm_sat_locust_util::function_82f9bbbcb47ef102( #"hash_709d77ab2b2005c5", step_ref, "[astrid_follow_path] HOLDOUT - calling holdout_event (BLOCKING) | name: " + params.name + " | max_active: " + var_5cfd36d664316522 );
            zm_sat_locust_util::holdout_event( params );
            zm_sat_locust_util::function_82f9bbbcb47ef102( #"hash_709d77ab2b2005c5", step_ref, "[astrid_follow_path] HOLDOUT - holdout_event returned | absorb_count: " + params.absorb_count + " | pending_count: " + params.pending_count );
            zm_sat_locust_util::function_e87fbeb96f6b390f( #"hash_709d77ab2b2005c5", step_ref );
            
            if ( zm_quest::function_b0a5181ebe7bb905() )
            {
                astrid game_utility::questcircle_delete();
            }
            
            astrid dialogue::stop_dialogue( 1, 1 );
            level thread function_739003bbba5c3ec7( 6 );
            
            if ( spawns_platforms && zm_quest::function_b0a5181ebe7bb905() )
            {
                utility::flag_set( "ww_dm_spawn_platforms" );
                level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
            }
            
            var_2bb3c93124521d70 = spawns_platforms ? [ "powered_up", "summon_platforms", exit_anim ] : [ "powered_up", exit_anim ];
            zm_sat_locust_util::function_82f9bbbcb47ef102( #"hash_709d77ab2b2005c5", step_ref, "[astrid_follow_path] HOLDOUT - playing post-holdout shots | spawns_platforms: " + spawns_platforms + " | exit_anim: " + exit_anim );
        }
        else
        {
            zm_sat_locust_util::function_82f9bbbcb47ef102( #"hash_709d77ab2b2005c5", step_ref, "[astrid_follow_path] NORMAL NODE - no holdout" );
            var_400457ef54b7f0f = getdvarint( @"hash_aa859622b58a4108", 50 );
            
            if ( var_400457ef54b7f0f > randomint( 100 ) && !utility::flag( "ww_step_05" ) )
            {
                level thread function_739003bbba5c3ec7( 4 );
                astrid dialogue::say_self( "dx_zm_lown_low2_alvn_lw2astbrdcrm" );
            }
            
            var_2bb3c93124521d70 = spawns_platforms ? [ "summon_platforms", exit_anim ] : [ exit_anim ];
        }
        
        if ( var_bb760a9ce53f7c96.target )
        {
            zm_sat_locust_util::function_82f9bbbcb47ef102( #"hash_709d77ab2b2005c5", step_ref, "[astrid_follow_path] playing exit scene (BLOCKING) | has next target: true" );
            var_bb760a9ce53f7c96 scene::play( astrid, var_2bb3c93124521d70 );
            zm_sat_locust_util::function_82f9bbbcb47ef102( #"hash_709d77ab2b2005c5", step_ref, "[astrid_follow_path] exit scene completed" );
        }
        else
        {
            zm_sat_locust_util::function_82f9bbbcb47ef102( #"hash_709d77ab2b2005c5", step_ref, "[astrid_follow_path] FINAL NODE - playing exit scene (threaded) and breaking" );
            var_bb760a9ce53f7c96 scene::add_scene_func( var_bb760a9ce53f7c96, &function_2fd466df37571031, "callback_done" );
            var_bb760a9ce53f7c96 thread scene::play( astrid, var_2bb3c93124521d70 );
            break;
        }
        
        astrid scriptmodelclearanim();
        can_skip = 1;
        waitframe();
        this_loc = var_bb760a9ce53f7c96;
        
        if ( isdefined( this_loc.target ) )
        {
            var_bb760a9ce53f7c96 = utility::getstruct( this_loc.target );
        }
        
        zm_sat_locust_util::function_82f9bbbcb47ef102( #"hash_709d77ab2b2005c5", step_ref, "[astrid_follow_path] starting wisp move to next node | this_loc.origin: " + this_loc.origin + " | next_loc defined: " + isdefined( var_bb760a9ce53f7c96 ) );
        astrid function_381bb66e5c649be7( this_loc, var_bb760a9ce53f7c96 );
        zm_sat_locust_util::function_82f9bbbcb47ef102( #"hash_709d77ab2b2005c5", step_ref, "[astrid_follow_path] wisp move completed | astrid.origin: " + astrid.origin );
    }
    
    zm_sat_locust_util::function_82f9bbbcb47ef102( #"hash_709d77ab2b2005c5", step_ref, "[astrid_follow_path] EXIT - setting flag: " + flag );
    utility::flag_set( flag );
}

// Namespace zm_sat_locust_quest_ww
// Params 0, eflags: 0x4
// Checksum 0x96f3ea6e, Offset: 0x2deb
// Size: 0x3a
function private function_2fd466df37571031()
{
    [ astrid ] = scene::get_entities();
    astrid hide();
    scene::remove_scene_func( self, &function_2fd466df37571031, "callback_done" );
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0xc
// Checksum 0xf0e4f013, Offset: 0x2e2d
// Size: 0x20d
function private function_381bb66e5c649be7( this_loc, var_bb760a9ce53f7c96 )
{
    self notify( #"hash_8d550f754e0d5915" );
    self endon( #"hash_8d550f754e0d5915" );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        zm_quest::function_61f7df5fddf96cd1();
    }
    
    if ( self.wisp )
    {
        self.wisp setscriptablepartstate( #"default", #"off" );
        self.wisp delete();
    }
    
    self.wisp = utility::spawn_model( %"sat_zm_actor_dewey_02", this_loc.origin + ( 0, 0, 48 ), self.angles );
    self.wisp setscriptablepartstate( #"default", #"created" );
    move_direction = vectornormalize( var_bb760a9ce53f7c96.origin - self.origin );
    var_3f76cbde1c9556de = distance( self.origin, var_bb760a9ce53f7c96.origin );
    var_3905b7e97a5918b8 = var_3f76cbde1c9556de * 0.5;
    var_1bd34eb538aefa50 = self.wisp.origin + move_direction * var_3905b7e97a5918b8;
    self.wisp moveto( var_1bd34eb538aefa50, 2 );
    
    for ( i = 0; i < 3 ; i++ )
    {
        level thread zm_sat_locust_util::function_e202f5a7f8d0e89f( this_loc.origin + ( 0, 0, 48 ), var_1bd34eb538aefa50 + utility::randomvectorrange( -16, 16 ) );
    }
    
    self.wisp waittill( #"movedone" );
    
    if ( self.wisp )
    {
        self.wisp setscriptablepartstate( #"default", #"off" );
        self.wisp delete();
    }
    
    wait 0.25;
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        zm_quest::function_a62dc5b7c911530();
    }
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0xb5373731, Offset: 0x3042
// Size: 0xb7
function private function_97e29f763b6c5d12( params, additional_params )
{
    if ( !params.eattacker || params.eattacker.classname == "worldspawn" )
    {
        return;
    }
    
    astrid = zm_sat_locust_util::get_quest_reference( #"ww_astrid" );
    zm_sat_locust_util::function_82f9bbbcb47ef102( #"hash_709d77ab2b2005c5", additional_params.step_ref, "astrid: " + isdefined( astrid ) );
    
    if ( distance2dsquared( self getcentroid(), astrid.origin ) > squared( additional_params.radius ) )
    {
        return;
    }
    
    level thread function_d35b9af266495e5a( self, astrid, additional_params );
}

// Namespace zm_sat_locust_quest_ww
// Params 3, eflags: 0x4
// Checksum 0x952b4f7e, Offset: 0x3101
// Size: 0x13d
function private function_d35b9af266495e5a( zombie, astrid, params )
{
    level endon( #"ww_step_04" );
    
    if ( params.pending_count + params.absorb_count >= level.quest_ww.var_3e6e28049fd7e7c5 )
    {
        return;
    }
    
    params.pending_count++;
    zm_sat_locust_util::function_e202f5a7f8d0e89f( zombie getcentroid(), astrid gettagorigin( "j_spineupper" ), #"soul_capture" );
    astrid = zm_sat_locust_util::get_quest_reference( #"ww_astrid" );
    astrid setscriptablepartstate( #"effects", #"soul_capture" );
    params.pending_count--;
    params.absorb_count++;
    
    if ( params.absorb_count >= level.quest_ww.var_3e6e28049fd7e7c5 && zm_sat_locust_util::is_holdout_event_active( params.name ) )
    {
        zm_sat_locust_util::end_holdout_event( params.name );
        return;
    }
    
    level zm_sat_locust_util::function_68d02dd51f9cb2d4( #"hash_709d77ab2b2005c5", params.step_ref, undefined, undefined, params.absorb_count );
}

// Namespace zm_sat_locust_quest_ww
// Params 0, eflags: 0x4
// Checksum 0xf2a8bf27, Offset: 0x3246
// Size: 0x32
function private function_679d83d9264e985f()
{
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        round_difficulty = zm_utility::get_round_number();
    }
    else
    {
        round_difficulty = clampint( zm_utility::get_round_number(), 10, 20 );
    }
    
    return round_difficulty;
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0x37cb0cda, Offset: 0x3281
// Size: 0x75
function private function_7d6d613ab952c071( skipped, save_restored )
{
    zm_sat_locust_util::log_quest_step( 1, #"collect_parts", skipped, save_restored );
    ww_lighthouse_middle = getnoentvolumearray( "ww_lighthouse_middle", #targetname )[ 0 ];
    ww_lighthouse_middle thread function_dfd3d34858418f3a( 1 );
    
    if ( skipped || save_restored )
    {
        return;
    }
    
    level thread parts_monitor();
    utility::flag_wait( "ww_step_01" );
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0x5cca7e11, Offset: 0x32fe
// Size: 0x258
function private function_60062348e78b78d6( skipped, save_restored )
{
    profilestart();
    zm_sat_locust_util::log_quest_step( 0, #"collect_parts", skipped, save_restored );
    
    if ( skipped || save_restored )
    {
        utility::flag_set( "ww_step_01" );
        
        if ( skipped && !save_restored )
        {
            if ( !zm_quest::is_quest_complete( #"locust_quest_pap" ) )
            {
                pap_quest = zm_quest::get_quest( #"locust_quest_pap" );
                
                foreach ( step in pap_quest.steps )
                {
                    zm_quest::function_e65609834444650c( step, save_restored, skipped );
                }
            }
            
            if ( !zm_quest::is_quest_complete( #"hash_eb1a9e1e9b73ed64" ) )
            {
                chain_quest = zm_quest::get_quest( #"hash_eb1a9e1e9b73ed64" );
                
                foreach ( step in chain_quest.steps )
                {
                    zm_quest::function_e65609834444650c( step, save_restored, skipped );
                }
            }
            
            if ( !zm_quest::is_quest_complete( #"hash_4f8df8efe261fec1" ) )
            {
                lantern_quest = zm_quest::get_quest( #"hash_4f8df8efe261fec1" );
                
                foreach ( step in lantern_quest.steps )
                {
                    zm_quest::function_e65609834444650c( step, save_restored, skipped );
                }
            }
        }
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    profilestop();
}

// Namespace zm_sat_locust_quest_ww
// Params 0, eflags: 0x4
// Checksum 0xe2bf1a49, Offset: 0x355e
// Size: 0x2b
function private parts_monitor()
{
    level endon( #"ww_step_01" );
    utility::flag_wait_all( "ww_billiam_core", "ww_burgess_core" );
    utility::flag_set( "ww_step_01" );
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0x1803014b, Offset: 0x3591
// Size: 0x36
function private function_7d6d5e3ab952b9d8( skipped, save_restored )
{
    zm_sat_locust_util::log_quest_step( 1, #"access_crypt", skipped, save_restored );
    
    if ( skipped || save_restored )
    {
        return;
    }
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0xdb0b1a4a, Offset: 0x35cf
// Size: 0x6b
function private function_60062248e78b76a3( skipped, save_restored )
{
    profilestart();
    zm_sat_locust_util::log_quest_step( 0, #"access_crypt", skipped, save_restored );
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( #"ww_crypt_door" ) )
    {
        door_chain = zm_sat_locust_util::get_quest_reference( #"ww_crypt_door" );
        door_chain delete();
    }
    
    utility::flag_set( "ww_step_02" );
    profilestop();
}

// Namespace zm_sat_locust_quest_ww
// Params 0, eflags: 0x4
// Checksum 0x53f540d5, Offset: 0x3642
// Size: 0x1e9
function private function_34b1bfdc9b9b643f()
{
    utility::flag_wait( "scriptables_ready" );
    crypt_door_blocker = getentarray( "village_crypt_door", #targetname )[ 0 ];
    crypt_door_blocker.doors = getentarray( "wwq_door_1", #targetname );
    crypt_door_blocker.locking_mechanism = getent( "crypt_locking_mechanism", #targetname );
    crypt_door_blocker.locking_mechanism scriptmodelplayanim( "sat_zm_locust_billiam_closing_anim", "crypt_unlocking", undefined, 8 );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        hint = utility::callsharedfunc( #"directed_mode", #"get_interact_func", #"hash_d3a172311502ebff" );
    }
    
    var_edb6d83a514892f8 = utility::getstruct( "cr_do_ch" );
    crypt_door_chain = interaction::register_interact( var_edb6d83a514892f8.origin, 64, &function_eab6307d51704314, hint );
    crypt_door_blocker.chain = crypt_door_chain;
    crypt_door_blocker.chain setusableenabled( 1 );
    var_97e3e5dfef8ae5bb = utility::getstruct( "cr_do_fx" );
    crypt_door_blocker.door_fx = spawnscriptable( %"sat_zm_locust_billiam_door_fx", var_97e3e5dfef8ae5bb.origin, var_97e3e5dfef8ae5bb.angles );
    zm_sat_locust_util::function_295a36ef38f5acae( #"ww_crypt_door", crypt_door_blocker );
    
    if ( zm_save::function_1dda3554974a999e() )
    {
        utility::flag_wait( "zm_save_level_restore_keys_complete" );
        crypt_open = zm_quest::function_73720cdf21c3cfd7( #"hash_709d77ab2b2005c5", #"crypt_open" );
        crypt_step_done = zm_quest::is_quest_step_complete( #"hash_709d77ab2b2005c5", #"reveal_crypt" );
        
        if ( crypt_open && !crypt_step_done )
        {
            utility::flag_set( "ww_step_02_a" );
            level function_4d7c22337a40fb0b( undefined, 1 );
        }
    }
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0xa0877208, Offset: 0x3833
// Size: 0x42
function private function_d83b7c9dbb71bb4c( skipped, save_restored )
{
    zm_sat_locust_util::log_quest_step( 1, #"place_chain", skipped, save_restored );
    
    if ( skipped || save_restored )
    {
        return;
    }
    
    utility::flag_wait( "ww_step_02_a" );
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0xfc48e497, Offset: 0x387d
// Size: 0xcc
function private function_7820966986bcfeef( skipped, save_restored )
{
    profilestart();
    zm_sat_locust_util::log_quest_step( 0, #"place_chain", skipped, save_restored );
    
    if ( skipped || save_restored )
    {
        if ( zm_sat_locust_util::function_3112dc4740eb8499( #"ww_crypt_door" ) )
        {
            crypt_door = zm_sat_locust_util::get_quest_reference( #"ww_crypt_door" );
            crypt_door.chain function_eab6307d51704314();
        }
        else if ( !utility::flag( "ww_step_02_a" ) )
        {
            utility::flag_set( "ww_step_02_a" );
            
            if ( zm_quest::function_b0a5181ebe7bb905() )
            {
                level thread zm_quest::update_round_cap( 8, 1, 0 );
            }
        }
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    profilestop();
}

// Namespace zm_sat_locust_quest_ww
// Params 1, eflags: 0x4
// Checksum 0x81905951, Offset: 0x3951
// Size: 0x135
function private function_eab6307d51704314( player )
{
    crypt_door_blocker = zm_sat_locust_util::get_quest_reference( #"ww_crypt_door" );
    
    if ( !isdefined( player ) )
    {
        utility::flag_set( "ww_step_02_a" );
        
        if ( zm_quest::function_b0a5181ebe7bb905() )
        {
            level thread zm_quest::update_round_cap( 8, 1, 0 );
        }
        
        crypt_door_blocker.locking_mechanism setscriptablepartstate( "model", "chain_visible" );
        interaction::set_interact_use_callback( &function_ddb359e9dfd0ef5b );
        self setusableenabled( 1 );
        return;
    }
    
    if ( !zm_quest::is_quest_complete( #"hash_eb1a9e1e9b73ed64" ) )
    {
        return;
    }
    
    playsoundatpos( self.origin, "evt_ww_chain_placed" );
    earthquake( 0.33, 1, self.origin, 64 );
    playrumbleonposition( "grenade_rumble", self.origin );
    zm_sat_locust_util::function_63a23256772ea1b9( player );
    self setusableenabled( 0 );
    level thread battlechatter_mp::trysaylocalsound( player, #"bc_flavor_player_positive" );
    crypt_door_blocker.locking_mechanism setscriptablepartstate( "model", "chain_visible" );
    utility::flag_set_delayed( "ww_step_02_a", 1 );
    interaction::set_interact_use_callback( &function_ddb359e9dfd0ef5b );
    self setusableenabled( 1 );
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0xdb44bd35, Offset: 0x3a8e
// Size: 0x42
function private function_d83b7f9dbb71c1e5( skipped, save_restored )
{
    zm_sat_locust_util::log_quest_step( 1, #"reveal_crypt", skipped, save_restored );
    
    if ( skipped || save_restored )
    {
        return;
    }
    
    utility::flag_wait( "ww_step_02_b" );
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0x2a21159e, Offset: 0x3ad8
// Size: 0x64
function private function_7820976986bd0122( skipped, save_restored )
{
    profilestart();
    zm_sat_locust_util::log_quest_step( 0, #"reveal_crypt", skipped, save_restored );
    
    if ( skipped || save_restored )
    {
        level function_4d7c22337a40fb0b( undefined, 1 );
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    profilestop();
}

// Namespace zm_sat_locust_quest_ww
// Params 1, eflags: 0x4
// Checksum 0xad2df8d5, Offset: 0x3b44
// Size: 0x1c
function private function_ddb359e9dfd0ef5b( player )
{
    self setusableenabled( 0 );
    thread function_ccf5f00230e7e1db( player );
}

// Namespace zm_sat_locust_quest_ww
// Params 1, eflags: 0xc
// Checksum 0xf36bed31, Offset: 0x3b68
// Size: 0xfb
function private function_ccf5f00230e7e1db( player )
{
    self notify( #"hash_19fec044ed02be7" );
    self endon( #"hash_19fec044ed02be7" );
    
    if ( !isdefined( self.repair_time_remaining ) )
    {
        self.repair_time_remaining = 10;
    }
    
    self.repairing = 1;
    self notify( #"door_repairing" );
    wait 0.1;
    thread function_3d1473103dfb46dd();
    params = { #hud_description:&"hash_1e12cbfe476a9402", #use_object:self, #hold_time:self.repair_time_remaining, #craft_reason:#"crypt_door_repair" };
    result = player zm_quest::function_e4eb2d1c1bd8fc4e( params );
    self.repairing = 0;
    
    if ( result )
    {
        thread function_4d7c22337a40fb0b( player );
        return;
    }
    
    wait 0.1;
    thread function_3ac792cef455887e();
    utility::delaycall( 0.1, &setusableenabled, 1 );
}

// Namespace zm_sat_locust_quest_ww
// Params 0, eflags: 0x4
// Checksum 0xcc1dff9f, Offset: 0x3c6b
// Size: 0xe4
function private function_3d1473103dfb46dd()
{
    crypt_door_blocker = zm_sat_locust_util::get_quest_reference( #"ww_crypt_door" );
    start_time = gettime();
    anim_start_time = 10 - self.repair_time_remaining;
    crypt_door_blocker.locking_mechanism setscriptablepartstate( "fx", "opening" );
    crypt_door_blocker.locking_mechanism scriptmodelplayanim( "sat_zm_locust_billiam_opening_anim", "crypt_unlocking", anim_start_time );
    
    while ( self.repairing )
    {
        waitframe();
    }
    
    crypt_door_blocker.locking_mechanism setscriptablepartstate( "fx", "stop_opening" );
    end_time = gettime();
    use_time = ( end_time - start_time ) / 1000;
    self.repair_time_remaining = max( self.repair_time_remaining - use_time + 0.1, 0 );
}

// Namespace zm_sat_locust_quest_ww
// Params 0, eflags: 0x4
// Checksum 0x237a22ec, Offset: 0x3d57
// Size: 0xb8
function private function_3ac792cef455887e()
{
    crypt_door_blocker = zm_sat_locust_util::get_quest_reference( #"ww_crypt_door" );
    var_ad1ea99fc9bf2e2d = gettime();
    self.closing = 1;
    thread function_8339d3664248aa42( crypt_door_blocker.locking_mechanism );
    
    while ( !self.repairing && self.closing )
    {
        waitframe();
    }
    
    if ( self.repairing )
    {
        rewind_time = ( gettime() - var_ad1ea99fc9bf2e2d ) / 1000 * 6;
        self.repair_time_remaining = min( self.repair_time_remaining + rewind_time + 0.6, 10 );
        self.closing = 0;
    }
}

// Namespace zm_sat_locust_quest_ww
// Params 1, eflags: 0x4
// Checksum 0xf327f376, Offset: 0x3e17
// Size: 0xc5
function private function_8339d3664248aa42( locking_mechanism )
{
    self endon( #"door_repairing" );
    modified_repair_time = self.repair_time_remaining / 6;
    close_time = 1.66667 - modified_repair_time - 0.25;
    locking_mechanism setscriptablepartstate( "fx", "closing" );
    locking_mechanism scriptmodelplayanim( "sat_zm_locust_billiam_closing_anim", "crypt_unlocking", modified_repair_time * 2, 2 );
    
    if ( close_time > 0 )
    {
        wait close_time;
    }
    else
    {
        waittillframeend();
    }
    
    self.closing = 0;
    self.repair_time_remaining = 10;
    locking_mechanism setscriptablepartstate( "fx", "slam_shut" );
    earthquake( 0.35, 0.25, locking_mechanism.origin, 450 );
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0x2fd657b8, Offset: 0x3ee4
// Size: 0x234
function private function_4d7c22337a40fb0b( player, skipped = 0 )
{
    zm_quest::function_4eefe6de31f5ddab( #"hash_709d77ab2b2005c5", #"crypt_open", 1 );
    
    if ( utility::flag( "ww_step_02_b" ) )
    {
        return;
    }
    
    utility::flag_set( "zone_village_crypt_opened" );
    crypt_door_blocker = zm_sat_locust_util::get_quest_reference( #"ww_crypt_door" );
    blocker = crypt_door_blocker;
    doors = blocker.doors;
    locking_mechanism = blocker.locking_mechanism;
    time = !skipped ? 1.5 : level.framedurationseconds;
    locking_mechanism setscriptablepartstate( "model", "chain_hidden" );
    locking_mechanism setscriptablepartstate( "fx", "doors_opening" );
    locking_mechanism notsolid();
    
    if ( player )
    {
        player thread zm_vo::function_8c1a12974bd11f01( #"hash_e0a3833cbf58736c", #"hash_5212ed7ec42f115a" );
    }
    
    foreach ( door in doors )
    {
        door rotateyaw( door.script_noteworthy == "left" ? 120 : -120, time );
    }
    
    if ( !skipped )
    {
        blocker.door_fx setscriptablepartstate( "fx", "opening" );
        earthquake( 0.33, 1, blocker.origin, 64 );
        playrumbleonposition( "grenade_rumble", blocker.origin );
        wait time / 2;
    }
    else
    {
        locking_mechanism scriptmodelplayanim( "sat_zm_locust_billiam_opening_anim", "crypt_unlocking", undefined, 8 );
    }
    
    blocker connectpaths();
    blocker.chain delete();
    blocker delete();
    utility::flag_set( "ww_step_02_b" );
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0x6abece41, Offset: 0x4120
// Size: 0x73
function private function_7d6d5f3ab952bc0b( skipped, save_restored )
{
    zm_sat_locust_util::log_quest_step( 1, #"crypt_puzzle", skipped, save_restored );
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( #"ww_crypt_door" ) )
    {
        crypt_door = zm_sat_locust_util::get_quest_reference( #"ww_crypt_door" );
        crypt_door.chain delete();
    }
    
    if ( skipped || save_restored )
    {
        return;
    }
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0x53a0f2c2, Offset: 0x419b
// Size: 0x42
function private function_60062148e78b7470( skipped, save_restored )
{
    profilestart();
    zm_sat_locust_util::log_quest_step( 0, #"crypt_puzzle", skipped, save_restored );
    
    if ( skipped || save_restored )
    {
        utility::flag_set( "ww_step_03" );
    }
    
    profilestop();
}

// Namespace zm_sat_locust_quest_ww
// Params 0, eflags: 0x4
// Checksum 0x6b2accfe, Offset: 0x41e5
// Size: 0x10d
function private function_82ddcd178f598134()
{
    utility::flag_wait( "scriptables_ready" );
    var_6628460af75e6020 = utility::getstruct( "cr_la_lo" );
    var_bf9b63afc23ac168 = spawnscriptable( %"sat_zm_interact_locust", var_6628460af75e6020.origin + ( 0, 0, 4 ), var_6628460af75e6020.angles );
    crypt_lantern = utility::spawn_model( %"sat_wm_ww_locust_rec_prop", var_6628460af75e6020.origin, var_6628460af75e6020.angles, undefined, 0.67 );
    crypt_lantern.failed = 0;
    crypt_lantern hide();
    interaction::register_scriptable_interact( var_bf9b63afc23ac168, &function_1034031afb760d40 );
    constellations = function_53f4cb8199723ecd( var_6628460af75e6020.origin, 300, 30 );
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_90013a88c1591def", crypt_lantern );
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_190817d488858e56", var_bf9b63afc23ac168 );
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_c98526cdf85af191", constellations );
}

// Namespace zm_sat_locust_quest_ww
// Params 1, eflags: 0x4
// Checksum 0xb1cad1fb, Offset: 0x42fa
// Size: 0x67
function private function_4b476356c6be9b6b( yaw )
{
    if ( yaw >= 20 && yaw <= 65 )
    {
        return 1;
    }
    
    if ( yaw >= 110 && yaw <= 155 )
    {
        return 2;
    }
    
    if ( yaw >= 200 && yaw <= 245 )
    {
        return 3;
    }
    
    if ( yaw >= 290 && yaw <= 335 )
    {
        return 4;
    }
}

// Namespace zm_sat_locust_quest_ww
// Params 4, eflags: 0x4
// Checksum 0x658f6c62, Offset: 0x436a
// Size: 0x15e
function private function_53f4cb8199723ecd( origin, radius, points, padding )
{
    constellation_points = [];
    random_points = utility::function_950fed9c7e18b522( origin, radius, points, 0, padding );
    
    foreach ( point in random_points )
    {
        angles = vectortoangles( point - origin );
        yaw = angles[ 1 ];
        quad = function_4b476356c6be9b6b( yaw );
        
        if ( !isdefined( quad ) )
        {
            continue;
        }
        
        z_height = randomintrange( 74, 134 );
        point = ( point[ 0 ], point[ 1 ], z_height );
        angles = ( angles[ 0 ], angles[ 1 ], randomintrange( -50, 50 ) );
        constellation = { #yaw:yaw, #quad:quad, #angles:angles, #origin:point };
        constellation_points[ constellation_points.size ] = constellation;
    }
    
    return constellation_points;
}

// Namespace zm_sat_locust_quest_ww
// Params 0, eflags: 0x4
// Checksum 0xf62aa59e, Offset: 0x44d1
// Size: 0x118
function private function_1734d59763d5edca()
{
    code_walls = [];
    var_49847d1b8112b2c2 = utility::getstructarray( "cr_co_wa" );
    
    foreach ( var_d00b39dfc3c0d445 in var_49847d1b8112b2c2 )
    {
        code_wall = utility::spawn_model( %"sat_zm_constellation_evan", var_d00b39dfc3c0d445.origin, var_d00b39dfc3c0d445.angles );
        code_wall.script_index = var_d00b39dfc3c0d445.script_index;
        code_wall hide();
        code_wall forcenetfieldhighlod( 1 );
        code_walls[ code_wall.script_index ] = code_wall;
    }
    
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_96b27119d936f549", code_walls );
    level.quest_ww.code_idx = 0;
}

// Namespace zm_sat_locust_quest_ww
// Params 0, eflags: 0x4
// Checksum 0x87bbb8aa, Offset: 0x45f1
// Size: 0x103
function private function_9d0a4e3f78f7f571()
{
    code_sites = [];
    var_5f3203ffe2e609bf = utility::getstructarray( "cr_co_si" );
    
    foreach ( var_51184a74dc06c636 in var_5f3203ffe2e609bf )
    {
        code_site = utility::spawn_model( %"sat_zm_constellation_evan", var_51184a74dc06c636.origin, var_51184a74dc06c636.angles );
        code_site.script_index = var_51184a74dc06c636.script_index;
        code_site hide();
        code_site forcenetfieldhighlod( 1 );
        code_sites[ code_site.script_index ] = code_site;
    }
    
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_7f9c7f6342c2d8a", code_sites );
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0x15e81ba7, Offset: 0x46fc
// Size: 0xac
function private function_e963d59dc8feaa07( skipped, save_restored )
{
    zm_sat_locust_util::log_quest_step( 1, #"place_lantern", skipped, save_restored );
    
    if ( skipped || save_restored )
    {
        return;
    }
    
    var_bf9b63afc23ac168 = zm_sat_locust_util::get_quest_reference( #"hash_190817d488858e56" );
    var_bf9b63afc23ac168 setscriptablepartstate( "interact", "enabled_64" );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        hint = utility::callsharedfunc( #"directed_mode", #"get_interact_func", %"sat_wm_ww_locust_rec_prop" );
        var_bf9b63afc23ac168 interaction::set_interact_hint_callback( hint );
    }
    
    utility::flag_wait( "ww_step_03_a" );
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0x433ce2b4, Offset: 0x47b0
// Size: 0x8f
function private function_66f87d6979309cf4( skipped, save_restored )
{
    profilestart();
    zm_sat_locust_util::log_quest_step( 0, #"place_lantern", skipped, save_restored );
    
    if ( skipped || save_restored )
    {
        if ( zm_sat_locust_util::function_3112dc4740eb8499( #"hash_190817d488858e56" ) )
        {
            var_bf9b63afc23ac168 = zm_sat_locust_util::get_quest_reference( #"hash_190817d488858e56" );
            var_bf9b63afc23ac168 function_1034031afb760d40();
        }
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    profilestop();
}

// Namespace zm_sat_locust_quest_ww
// Params 1, eflags: 0x4
// Checksum 0xb4b5066f, Offset: 0x4847
// Size: 0xac
function private function_1034031afb760d40( player )
{
    utility::flag_set( "ww_step_03_a" );
    crypt_lantern = zm_sat_locust_util::get_quest_reference( #"hash_90013a88c1591def" );
    crypt_lantern show();
    crypt_lantern setscriptablepartstate( #"body", #"visible" );
    crypt_lantern setscriptablepartstate( #"effects", #"crypt" );
    crypt_lantern playloopsound( "mus_constellation_loop" );
    self freescriptable();
    interaction::register_interact( crypt_lantern, 64, &function_c103bc2134fb03e1 );
    crypt_lantern setusableenabled( 0 );
    
    if ( player )
    {
        zm_sat_locust_util::function_63a23256772ea1b9( player );
        level thread function_b662116e38a91d3b();
    }
}

// Namespace zm_sat_locust_quest_ww
// Params 0, eflags: 0x4
// Checksum 0x824cba3b, Offset: 0x48fb
// Size: 0x4d
function private function_b662116e38a91d3b()
{
    set_1 = [ "dx_zm_lown_low2_lvtw_lw2pllana1ln1", "dx_zm_lown_low2_detw_lw2pllana1ln2" ];
    set_2 = [ "dx_zm_lown_low2_detw_lw2pllana2ln1", "dx_zm_lown_low2_lvtw_lw2pllana2ln2" ];
    zm_sat_locust_util::function_1d7335486cb891d8( set_1, set_2, 1 );
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0x64ee589d, Offset: 0x4950
// Size: 0x5d
function private function_e963d69dc8feac3a( skipped, save_restored )
{
    zm_sat_locust_util::log_quest_step( 1, #"solve_lantern", skipped, save_restored );
    
    if ( skipped || save_restored )
    {
        return;
    }
    
    level thread function_9f2ee58cdca459e9( level.quest_ww.code_idx );
    utility::flag_wait( "ww_step_03_b" );
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0x8294e162, Offset: 0x49b5
// Size: 0x1d7
function private function_66f880697930a38d( skipped, save_restored )
{
    profilestart();
    zm_sat_locust_util::log_quest_step( 0, #"solve_lantern", skipped, save_restored );
    
    if ( skipped || save_restored )
    {
        utility::flag_set( "ww_step_03_b" );
    }
    
    code_wall = zm_sat_locust_util::get_quest_reference( #"hash_96b27119d936f549" );
    code_site = zm_sat_locust_util::get_quest_reference( #"hash_7f9c7f6342c2d8a" );
    delete_objs = arraycombine( code_wall, code_site );
    utility::array_delete( delete_objs );
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( #"hash_c98526cdf85af191" ) )
    {
        constellations = zm_sat_locust_util::get_quest_reference( #"hash_c98526cdf85af191" );
        
        foreach ( constellation in constellations )
        {
            if ( isdefined( constellation.object ) )
            {
                constellation.object delete();
            }
        }
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    crypt_lantern = zm_sat_locust_util::get_quest_reference( #"hash_90013a88c1591def" );
    crypt_lantern setscriptablepartstate( #"body", #"hidden" );
    crypt_lantern setscriptablepartstate( #"effects", #"disabled" );
    crypt_lantern stoploopsound( "mus_constellation_loop" );
    playsoundatpos( crypt_lantern.origin, "mus_constellation_stinger" );
    crypt_lantern hide();
    profilestop();
}

// Namespace zm_sat_locust_quest_ww
// Params 1, eflags: 0xc
// Checksum 0xf1f711b6, Offset: 0x4b94
// Size: 0x4a8
function private function_9f2ee58cdca459e9( code_index )
{
    self notify( #"hash_afd70d945d198160" );
    self endon( #"hash_afd70d945d198160" );
    level endon( #"ww_step_03_b" );
    level endon( #"ww_step_03" );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    zm_sat_locust_util::function_82f9bbbcb47ef102( #"hash_709d77ab2b2005c5", #"solve_lantern", "constellation index: " + code_index );
    base_code = function_c3494fbaee83d3aa();
    game_code = zm_sat_locust_util::get_quest_reference( #"hash_269c0a0b24041534" );
    
    if ( code_index >= 0 )
    {
        crypt_code = utility::array_slice( game_code, code_index, game_code.size );
    }
    
    base_code = arrayremove( base_code, crypt_code );
    var_cb5369743609abbe = zm_sat_locust_util::get_quest_reference( #"hash_90013a88c1591def" );
    quads = [];
    constellations = zm_sat_locust_util::get_quest_reference( #"hash_c98526cdf85af191" );
    
    foreach ( idx, constellation in constellations )
    {
        if ( isdefined( constellation.object ) )
        {
            constellation.object delete();
        }
        
        origin = constellation.origin;
        angles = ( 0, vectortoyaw( var_cb5369743609abbe.origin - origin ), 0 );
        constellation.object = utility::spawn_model( %"sat_zm_constellation_evan", origin, angles );
        constellation.object.constellation = constellation;
        constellation.object forcenetfieldhighlod( 1 );
        
        if ( !isdefined( quads[ constellation.quad - 1 ] ) )
        {
            quads[ constellation.quad - 1 ] = [];
        }
        
        quads[ constellation.quad - 1 ][ quads[ constellation.quad - 1 ].size ] = constellation;
    }
    
    for ( i = 0; i < quads.size ; i++ )
    {
        has_special = 0;
        base_chance = 100 / quads[ i ].size;
        random_quads = arrayrandomize( quads[ i ] );
        
        foreach ( idx, constellation in random_quads )
        {
            if ( !has_special && utility::percent_chance( base_chance * ( idx + 1 ) ) )
            {
                has_special = 1;
                constellation.letter = game_code[ i ];
                constellation.special = 1;
            }
            else
            {
                constellation.letter = base_code[ idx % base_code.size ];
                constellation.special = 0;
            }
            
            constellation.object setscriptablepartstate( getxhash( "type_" + constellation.letter ), #"active" );
            wait randomfloatrange( 0.05, 0.2 );
        }
        
        assert( has_special, "<dev string:x24>" );
    }
    
    /#
        specials = function_85c78ea46077db9( constellations, #letter, game_code[ code_index ] );
        assert( specials.size == 1, "<dev string:x46>" );
    #/
    
    var_cb5369743609abbe setscriptablepartstate( #"effects", #"crypt" );
    function_c094c9a1a3eb063d( constellations, var_cb5369743609abbe );
    
    if ( code_index == 0 )
    {
        code_wall = zm_sat_locust_util::get_quest_reference( #"hash_96b27119d936f549" );
        
        foreach ( entry in code_wall )
        {
            entry setscriptablepartstate( "type_" + game_code[ entry.script_index ], #"active" );
            entry show();
        }
    }
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0x66a13844, Offset: 0x5044
// Size: 0x5c
function private function_c094c9a1a3eb063d( constellations, var_cb5369743609abbe )
{
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        hint = utility::callsharedfunc( #"directed_mode", #"get_interact_string", #"constellation_capture" );
    }
    
    utility::array_thread( constellations, &function_673f5663037d10a, var_cb5369743609abbe, hint );
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0xc
// Checksum 0x24a5757b, Offset: 0x50a8
// Size: 0xe5
function private function_673f5663037d10a( pivot, hint )
{
    self notify( #"hash_3277a4bc6f7b39a" );
    self endon( #"hash_3277a4bc6f7b39a" );
    self.object endon( #"death" );
    directed_mode = zm_quest::function_b0a5181ebe7bb905();
    
    if ( directed_mode )
    {
        game_code = zm_sat_locust_util::get_quest_reference( #"hash_269c0a0b24041534" );
        curr_letter = game_code[ level.quest_ww.code_idx ] == self.letter;
    }
    
    interaction::register_interact( self.object, 36, &function_dc799b7cc58574ac, hint );
    self.object childthread function_88055a836028b536( pivot, curr_letter );
    self.object childthread zm_sat_locust_util::function_3fa3cd4714495cf7( 300, 70, pivot, 1, undefined, 1 );
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0xb95e43f2, Offset: 0x5195
// Size: 0x17b
function private function_88055a836028b536( pivot, objective = 0 )
{
    if ( objective )
    {
        utility::function_32b24db3127bff40( #"objective", #"enabled" );
    }
    
    for ( ;; )
    {
        angles = vectortoangles( self.origin - pivot.origin );
        yaw = angles[ 1 ];
        quad = function_4b476356c6be9b6b( yaw );
        
        if ( quad != self.constellation.quad )
        {
            if ( !isdefined( quad ) && self function_45c212dce7227aa7() )
            {
                utility::function_32b24db3127bff40( getxhash( "type_" + self.constellation.letter ), #"deactivate" );
                self setusableenabled( 0 );
                
                if ( objective )
                {
                    utility::function_32b24db3127bff40( #"objective", #"disabled" );
                }
            }
            else if ( isdefined( quad ) && !self function_45c212dce7227aa7() )
            {
                utility::function_32b24db3127bff40( getxhash( "type_" + self.constellation.letter ), #"active" );
                self setusableenabled( 1 );
                
                if ( objective )
                {
                    utility::function_32b24db3127bff40( #"objective", #"enabled" );
                }
            }
            
            self.constellation.quad = quad;
        }
        
        waitframe();
    }
}

// Namespace zm_sat_locust_quest_ww
// Params 1, eflags: 0xc
// Checksum 0x8004e50c, Offset: 0x5318
// Size: 0x68e
function private function_dc799b7cc58574ac( player )
{
    self notify( #"hash_f29a5d58545c74d5" );
    self endon( #"hash_f29a5d58545c74d5" );
    level endon( #"ww_step_03_b" );
    level endon( #"ww_step_03" );
    level endon( #"ww_step_04" );
    zm_sat_locust_util::function_63a23256772ea1b9( player );
    code = zm_sat_locust_util::get_quest_reference( #"hash_269c0a0b24041534" );
    idx = level.quest_ww.code_idx;
    letter = self.constellation.letter;
    valid = code[ idx ] == letter;
    
    if ( valid )
    {
        level.quest_ww.code_idx++;
    }
    
    zm_sat_locust_util::function_82f9bbbcb47ef102( #"hash_709d77ab2b2005c5", #"solve_lantern", "constellation index: " + idx + " | valid: " + valid );
    origin = self.origin;
    function_382d34d96df75056();
    var_cb5369743609abbe = zm_sat_locust_util::get_quest_reference( #"hash_90013a88c1591def" );
    zm_sat_locust_util::function_e202f5a7f8d0e89f( origin, var_cb5369743609abbe.origin, #"constellation" );
    code_site = zm_sat_locust_util::get_quest_reference( #"hash_7f9c7f6342c2d8a" );
    code_site[ idx ] setscriptablepartstate( "type_" + letter, #"active" );
    code_site[ idx ] show();
    code_site[ idx ].letter = letter;
    assert( isdefined( code_site[ idx ].letter ) );
    
    /#
        level notify( #"debug_show_code" );
    #/
    
    if ( valid )
    {
        if ( level.quest_ww.code_idx == code.size )
        {
            zm_sat_locust_util::function_82f9bbbcb47ef102( #"hash_709d77ab2b2005c5", #"solve_lantern", "constellation puzzle done" );
            var_cb5369743609abbe setscriptablepartstate( #"status", #"complete" );
            utility::flag_set( "ww_step_03_b" );
            return;
        }
        else
        {
            zm_sat_locust_util::function_82f9bbbcb47ef102( #"hash_709d77ab2b2005c5", #"solve_lantern", "constellation puzzle continue" );
            var_cb5369743609abbe setscriptablepartstate( #"status", #"success" );
            var_cb5369743609abbe utility::delaycall( level.framedurationseconds, &setscriptablepartstate, #"status", #"default" );
        }
    }
    else
    {
        zm_sat_locust_util::function_82f9bbbcb47ef102( #"hash_709d77ab2b2005c5", #"solve_lantern", "constellation puzzle failed" );
        
        if ( !var_cb5369743609abbe.failed_dialogue )
        {
            level thread battlechatter_mp::trysaylocalsound( player, #"bc_flavor_player_negative" );
        }
        
        var_cb5369743609abbe.failed = 1;
        var_cb5369743609abbe.failed_dialogue = 1;
        release_amount = level.quest_ww.code_idx + 1;
        level.quest_ww.code_idx = 0;
        
        if ( !zm_quest::function_b0a5181ebe7bb905() )
        {
            var_cb5369743609abbe setusableenabled( 1 );
            var_cb5369743609abbe setscriptablepartstate( #"status", #"failed" );
            level waittill( "ww_step_03_b" + "_redo" );
        }
        else
        {
            zm_quest::function_b5d75b34f712db9a();
        }
        
        var_cb5369743609abbe.failed = 0;
        var_cb5369743609abbe setscriptablepartstate( #"status", #"released" );
        
        foreach ( site in code_site )
        {
            if ( !isdefined( site.letter ) )
            {
                continue;
            }
            
            site setscriptablepartstate( getxhash( "type_" + site.letter ), #"hidden" );
            site.letter = undefined;
        }
        
        game_code = zm_sat_locust_util::get_quest_reference( #"hash_269c0a0b24041534" );
        code_wall = zm_sat_locust_util::get_quest_reference( #"hash_96b27119d936f549" );
        
        foreach ( entry in code_wall )
        {
            entry setscriptablepartstate( getxhash( "type_" + game_code[ entry.script_index ] ), #"hidden" );
        }
        
        points = function_53f4cb8199723ecd( var_cb5369743609abbe.origin, 300, 20 );
        
        for ( i = 1; i <= release_amount ; i++ )
        {
            point = undefined;
            
            foreach ( p in points )
            {
                if ( p.quad == i )
                {
                    point = p.origin;
                    break;
                }
            }
            
            if ( i != release_amount )
            {
                level thread zm_sat_locust_util::function_e202f5a7f8d0e89f( var_cb5369743609abbe.origin, point, #"constellation" );
                continue;
            }
            
            zm_sat_locust_util::function_e202f5a7f8d0e89f( var_cb5369743609abbe.origin, point, #"constellation" );
        }
        
        wait 0.25;
        
        if ( zm_quest::is_quest_step_complete( #"hash_709d77ab2b2005c5", #"solve_lantern" ) )
        {
            return;
        }
        
        zm_sat_locust_util::function_82f9bbbcb47ef102( #"hash_709d77ab2b2005c5", #"solve_lantern", "constellation puzzle reset" );
        function_6965e07e21a497ba();
    }
    
    constellations = function_53f4cb8199723ecd( var_cb5369743609abbe.origin, 300, 30 );
    zm_sat_locust_util::function_222215ce3aef9da1( #"hash_c98526cdf85af191", constellations );
    level thread function_9f2ee58cdca459e9( level.quest_ww.code_idx );
}

// Namespace zm_sat_locust_quest_ww
// Params 0, eflags: 0x4
// Checksum 0x71c9469c, Offset: 0x59ae
// Size: 0xe4
function private function_6965e07e21a497ba()
{
    base_code = function_c3494fbaee83d3aa();
    index_code = getarraykeys( base_code );
    text_code = [];
    number_code = 0;
    
    for ( i = 4; i > 0 ; i-- )
    {
        idx = utility::array_random( index_code );
        index_code[ idx ] = undefined;
        number_code += int( pow( 10, i - 1 ) ) * ( idx + 1 );
        text_code[ text_code.size ] = base_code[ idx ];
    }
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( #"hash_269c0a0b24041534" ) )
    {
        zm_sat_locust_util::function_222215ce3aef9da1( #"hash_269c0a0b24041534", text_code );
    }
    else
    {
        zm_sat_locust_util::function_295a36ef38f5acae( #"hash_269c0a0b24041534", text_code );
    }
    
    zm_quest::function_4eefe6de31f5ddab( #"hash_709d77ab2b2005c5", #"number", number_code );
    return text_code;
}

// Namespace zm_sat_locust_quest_ww
// Params 0, eflags: 0x4
// Checksum 0xfb4c7e3c, Offset: 0x5a9b
// Size: 0x62
function private function_c3494fbaee83d3aa()
{
    code = [ "a", "b", "c", "d", "e", "f", "g", "h", "i" ];
    return code;
}

// Namespace zm_sat_locust_quest_ww
// Params 0, eflags: 0x4
// Checksum 0xd9dc4271, Offset: 0x5b06
// Size: 0xaa
function private function_382d34d96df75056()
{
    constellations = zm_sat_locust_util::get_quest_reference( #"hash_c98526cdf85af191" );
    
    foreach ( constellation in constellations )
    {
        constellation.object delete();
        constellation.letter = undefined;
        constellation.special = undefined;
    }
}

// Namespace zm_sat_locust_quest_ww
// Params 1, eflags: 0x4
// Checksum 0x458b2a45, Offset: 0x5bb8
// Size: 0x42
function private function_c103bc2134fb03e1( player )
{
    if ( level.quest_ww.code_idx == 0 )
    {
        level notify( "ww_step_03_b" + "_redo" );
    }
    
    self setusableenabled( 0 );
    zm_sat_locust_util::function_63a23256772ea1b9( player );
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0x516f66a0, Offset: 0x5c02
// Size: 0x36
function private function_7d6d643ab952c70a( skipped, save_restored )
{
    zm_sat_locust_util::log_quest_step( 1, #"follow_astrid", skipped, save_restored );
    
    if ( skipped || save_restored )
    {
        return;
    }
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0xef60899f, Offset: 0x5c40
// Size: 0x37
function private function_60062848e78b83d5( skipped, save_restored )
{
    profilestart();
    zm_sat_locust_util::log_quest_step( 0, #"follow_astrid", skipped, save_restored );
    utility::flag_set( "ww_step_04" );
    profilestop();
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0xd8127564, Offset: 0x5c7f
// Size: 0x67
function private function_31f8869dfe36254a( skipped, save_restored )
{
    zm_sat_locust_util::log_quest_step( 1, #"through_market", skipped, save_restored );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread zm_quest::update_round_cap( 9, 1, 0 );
    }
    
    if ( skipped || save_restored )
    {
        return;
    }
    
    level thread astrid_follow_path( "ww_step_04_a", 1 );
    utility::flag_wait( "ww_step_04_a" );
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0xd3d8b22e, Offset: 0x5cee
// Size: 0x5c
function private function_cc5da069c3749c2d( skipped, save_restored )
{
    profilestart();
    zm_sat_locust_util::log_quest_step( 0, #"through_market", skipped, save_restored );
    
    if ( skipped || save_restored )
    {
        level astrid_follow_path( "ww_step_04_a", 1, 1 );
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        utility::flag_set( "ww_dm_follow" );
    }
    
    profilestop();
}

// Namespace zm_sat_locust_quest_ww
// Params 1, eflags: 0x4
// Checksum 0x46d0a467, Offset: 0x5d52
// Size: 0x73
function private function_f60e2ecf41697e81( player )
{
    set_1 = [ "dx_zm_lown_low2_lvtw_lw2flwasta1ln1", "dx_zm_lown_low2_detw_lw2flwasta1ln2" ];
    set_2 = [ "dx_zm_lown_low2_detw_lw2flwasta2ln1", "dx_zm_lown_low2_lvtw_lw2flwasta2ln2" ];
    zm_sat_locust_util::function_1d7335486cb891d8( set_1, set_2 );
    
    if ( player && isalive( player ) )
    {
        player thread zm_vo::function_8c1a12974bd11f01( #"wwq_follow_astrid" );
    }
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0x5edef1f2, Offset: 0x5dcd
// Size: 0x8e
function private function_31f8859dfe362317( skipped, save_restored )
{
    zm_sat_locust_util::log_quest_step( 1, #"hash_8608a512dec03657", skipped, save_restored );
    
    if ( skipped || save_restored )
    {
        return;
    }
    
    if ( utility::flag( "ww_reset" ) && zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    level thread astrid_follow_path( "ww_step_04_b", 0, 0, 1, #"hash_8608a512dec03657" );
    utility::flag_wait( "ww_step_04_b" );
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0xa2b03bea, Offset: 0x5e63
// Size: 0x6b
function private function_cc5d9d69c3749594( skipped, save_restored )
{
    profilestart();
    zm_sat_locust_util::log_quest_step( 0, #"hash_8608a512dec03657", skipped, save_restored );
    
    if ( skipped || save_restored )
    {
        level astrid_follow_path( "ww_step_04_b", 0, 1, 1 );
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    profilestop();
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0xcbd49fc8, Offset: 0x5ed6
// Size: 0x4f
function private function_31f8849dfe3620e4( skipped, save_restored )
{
    zm_sat_locust_util::log_quest_step( 1, #"through_town", skipped, save_restored );
    
    if ( skipped || save_restored )
    {
        return;
    }
    
    level thread astrid_follow_path( "ww_step_04_c" );
    utility::flag_wait( "ww_step_04_c" );
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0xe180f8f5, Offset: 0x5f2d
// Size: 0x69
function private function_cc5d9e69c37497c7( skipped, save_restored )
{
    profilestart();
    zm_sat_locust_util::log_quest_step( 0, #"through_town", skipped, save_restored );
    
    if ( skipped || save_restored )
    {
        level astrid_follow_path( "ww_step_04_c", 0, 1 );
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    profilestop();
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0x78960ba5, Offset: 0x5f9e
// Size: 0x5f
function private function_31f8839dfe361eb1( skipped, save_restored )
{
    zm_sat_locust_util::log_quest_step( 1, #"hash_b5da1436fd9abf9f", skipped, save_restored );
    
    if ( skipped || save_restored )
    {
        return;
    }
    
    level thread astrid_follow_path( "ww_step_04_d", 0, 0, 1, #"hash_b5da1436fd9abf9f", 1 );
    level waittill( #"astrid_summon_platform" );
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0x92309aeb, Offset: 0x6005
// Size: 0x77
function private function_cc5d9b69c374912e( skipped, save_restored )
{
    profilestart();
    zm_sat_locust_util::log_quest_step( 0, #"hash_b5da1436fd9abf9f", skipped, save_restored );
    
    if ( skipped || save_restored )
    {
        level astrid_follow_path( "ww_step_04_d", 0, 1, 1 );
        utility::flag_set( "ww_dm_spawn_platforms" );
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    profilestop();
}

// Namespace zm_sat_locust_quest_ww
// Params 0, eflags: 0x4
// Checksum 0x78afff54, Offset: 0x6084
// Size: 0x6f
function private function_c947b5662067ef3()
{
    astrid_loc = utility::getstruct( "ww_astrid" );
    astrid = utility::spawn_model( %"xcomposite_sat_zmb_dlc3_npc_astrid", astrid_loc.origin, astrid_loc.angles );
    astrid.path = astrid_loc;
    astrid hide();
    zm_sat_locust_util::function_295a36ef38f5acae( #"ww_astrid", astrid );
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0x7a307259, Offset: 0x60fb
// Size: 0x36
function private function_7d6d653ab952c93d( skipped, save_restored )
{
    zm_sat_locust_util::log_quest_step( 1, #"first_platform", skipped, save_restored );
    
    if ( skipped || save_restored )
    {
        return;
    }
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0xb338adf0, Offset: 0x6139
// Size: 0x37
function private function_60062748e78b81a2( skipped, save_restored )
{
    profilestart();
    zm_sat_locust_util::log_quest_step( 0, #"first_platform", skipped, save_restored );
    utility::flag_set( "ww_step_05" );
    profilestop();
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0xe044bc8d, Offset: 0x6178
// Size: 0x241
function private function_3fd49f9e08230205( skipped, save_restored )
{
    zm_sat_locust_util::log_quest_step( 1, #"access_first_platform", skipped, save_restored );
    utility::flag_clear( "ww_reset" );
    platform_1 = zm_sat_locust_util::get_quest_reference( #"ww_platform_1" );
    
    if ( isdefined( platform_1.var_d3823b80b1397854 ) )
    {
        platform_1 thread function_46c6f25766d87633();
    }
    
    if ( skipped || save_restored )
    {
        level thread zm_sat_locust_floating_rocks::show_group( "wwq_path_1", 1, 1 );
    }
    else
    {
        astrid = zm_sat_locust_util::get_quest_reference( #"ww_astrid" );
        earthquake_org = astrid.origin;
        earthquake( 0.15, 10, earthquake_org, 1024 );
        level thread zm_sat_locust_floating_rocks::show_group( "wwq_path_1", 1, 1, [ 0.65, 0.75 ] );
        level waittill( #"wwq_path_1" );
        earthquake( 0.35, 1.25, earthquake_org, 1024 );
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    platform_1.clip hide();
    platform_1.var_d3823b80b1397854 show();
    level callback::add( "zone_changed", &on_platform_zone_changed );
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( #"ww_platform_skyclip" ) )
    {
        sky_clips = zm_sat_locust_util::get_quest_reference( #"ww_platform_skyclip" );
        
        foreach ( clip in sky_clips )
        {
            clip hide();
        }
    }
    
    zone_manager::set_zone_enabled( "zone_lighthouse_int_puzzle", 1 );
    utility::flag_set( "zone_lighthouse_int_puzzle_unlocked" );
    
    if ( skipped || save_restored )
    {
        return;
    }
    
    level callback::add( "zone_changed", &function_5e7628ba44a5d977 );
    utility::flag_wait( "ww_step_05_a" );
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0xdb629aa4, Offset: 0x63c1
// Size: 0xb8
function private function_c0b54769bbf47a32( skipped, save_restored )
{
    profilestart();
    zm_sat_locust_util::log_quest_step( 0, #"access_first_platform", skipped, save_restored );
    
    if ( skipped || save_restored )
    {
        utility::flag_set( "ww_step_05_a" );
    }
    
    level callback::remove( "zone_changed", &function_5e7628ba44a5d977 );
    zone_manager::set_zone_enabled( "zone_lighthouse_int_puzzle_2", 1 );
    utility::flag_set( "zone_lighthouse_int_puzzle_2_unlocked" );
    zone_manager::set_zone_enabled( "zone_lighthouse_int_puzzle_4", 1 );
    utility::flag_set( "zone_lighthouse_int_puzzle_4_unlocked" );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread zm_quest::update_round_cap( 10, 1, 0 );
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    profilestop();
}

// Namespace zm_sat_locust_quest_ww
// Params 1, eflags: 0x4
// Checksum 0x1b2310be, Offset: 0x6481
// Size: 0x36
function private function_5e7628ba44a5d977( params )
{
    if ( params.zone_struct.zone_name == "zone_lighthouse_int_puzzle" )
    {
        utility::flag_set( "ww_step_05_a" );
    }
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0xc7a53705, Offset: 0x64bf
// Size: 0x108
function private function_3fd49c9e0822fb6c( skipped, save_restored )
{
    zm_sat_locust_util::log_quest_step( 1, #"complete_first_platform", skipped, save_restored );
    level thread platforms_timeout_watcher();
    
    if ( skipped || save_restored )
    {
        return;
    }
    
    params = { #flag:"ww_step_05_b", #spawn_zones:[ zone_manager::get_zone_struct( "zone_lighthouse_int_puzzle" ) ], #aitypes:[ { #type:"zombie_base", #weight:70 }, { #type:"zombie_base_armored_heavy", #weight:30 } ], #count:8 };
    level thread function_e3fda40c3fe2b3cd( params );
    utility::flag_wait( "ww_step_04_d" );
    level thread astrid_follow_path( "ww_step_05_b", 0, 0, 1 );
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_a7b7555998e8ee50", params );
    utility::flag_wait( "ww_step_05_b" );
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0xc569cfbc, Offset: 0x65cf
// Size: 0x79
function private function_c0b54669bbf477ff( skipped, save_restored )
{
    profilestart();
    zm_sat_locust_util::log_quest_step( 0, #"complete_first_platform", skipped, save_restored );
    
    if ( skipped || save_restored )
    {
        level thread astrid_follow_path( "ww_step_05_b", 0, 1 );
    }
    
    level thread function_365c3e506147f11c( skipped || save_restored );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    profilestop();
}

// Namespace zm_sat_locust_quest_ww
// Params 1, eflags: 0x4
// Checksum 0xc31a7520, Offset: 0x6650
// Size: 0x91
function private function_365c3e506147f11c( skipped )
{
    if ( utility::flag( "zone_lighthouse_barrier_broken" ) )
    {
        return;
    }
    
    utility::flag_set( "zone_lighthouse_barrier_broken" );
    blocker = zm_sat_locust_util::get_quest_reference( #"hash_33e2a7ad596be4d9" );
    
    if ( !skipped )
    {
        blocker.door rotateyaw( -95, 1.5 );
        wait 0.75;
    }
    else
    {
        blocker.door rotateyaw( -95, level.framedurationseconds );
    }
    
    blocker connectpaths();
    blocker delete();
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0x113e0a24, Offset: 0x66e9
// Size: 0x7d
function private function_7d6d623ab952c2a4( skipped, save_restored )
{
    zm_sat_locust_util::log_quest_step( 1, #"second_platform", skipped, save_restored );
    
    if ( skipped || save_restored )
    {
        return;
    }
    
    astrid = zm_sat_locust_util::get_quest_reference( #"ww_astrid" );
    player = astrid.player_trigger;
    
    if ( player )
    {
        player thread zm_vo::function_8c1a12974bd11f01( #"wwq_enter_lighthouse" );
    }
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0xd93da694, Offset: 0x676e
// Size: 0x37
function private function_60062648e78b7f6f( skipped, save_restored )
{
    profilestart();
    zm_sat_locust_util::log_quest_step( 0, #"second_platform", skipped, save_restored );
    utility::flag_set( "ww_step_06" );
    profilestop();
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0xa88637ff, Offset: 0x67ad
// Size: 0x77
function private function_1529189de92bdd20( skipped, save_restored )
{
    zm_sat_locust_util::log_quest_step( 0, #"access_second_platform", skipped, save_restored );
    
    if ( skipped || save_restored )
    {
        return;
    }
    
    level thread astrid_follow_path( "ww_step_06_a", 0, 0, 1, undefined, 1 );
    
    if ( !utility::flag( "ww_virgil_shown" ) )
    {
        activateworldevent( "we_lighthouse_water" );
        level thread function_5ae3aca17197e2b3();
    }
    
    level waittill( #"astrid_summon_platform" );
}

// Namespace zm_sat_locust_quest_ww
// Params 0, eflags: 0x4
// Checksum 0x5f33d1e8, Offset: 0x682c
// Size: 0x74
function private function_5ae3aca17197e2b3()
{
    level endon( #"ww_step_08" );
    utility::flag_wait( "begin_round_logic" );
    scene_struct = utility::getstruct( "ww_virgil_appear" );
    scene_struct scene::add_scene_func( scene_struct, &function_4f2a72acde6192c6, "callback_init" );
    scene_struct thread scene::init();
    level waittill( #"prestream_virgil_lighthouse" );
    scene_struct thread scene::pre_stream( [ scene_struct.shadowsmith ] );
}

// Namespace zm_sat_locust_quest_ww
// Params 0, eflags: 0x4
// Checksum 0x4b6b30db, Offset: 0x68a8
// Size: 0x7f
function private function_4f2a72acde6192c6()
{
    [ shadowsmith ] = scene::get_entities();
    shadowsmith.is_immune = 1;
    var_5239473c3fae77e8 = utility::spawn_tag_origin( shadowsmith.origin, ( 0, 0, 0 ) );
    shadowsmith linkto( var_5239473c3fae77e8 );
    shadowsmith.link = var_5239473c3fae77e8;
    shadowsmith invisiblenotsolid();
    self.shadowsmith = shadowsmith;
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0x7e460696, Offset: 0x692f
// Size: 0xa4
function private function_af8e3269ae6a5403( skipped, save_restored )
{
    profilestart();
    platform_2 = zm_sat_locust_util::get_quest_reference( #"ww_platform_2" );
    platform_2.blocker hide();
    
    if ( isdefined( platform_2.var_d3823b80b1397854 ) )
    {
        platform_2.var_d3823b80b1397854 show();
        platform_2 thread function_46c6f25766d87633();
    }
    
    zone_manager::set_zone_enabled( "zone_lighthouse_int_puzzle_3", 1 );
    utility::flag_set( "zone_lighthouse_int_puzzle_3_unlocked" );
    
    if ( skipped || save_restored )
    {
        level thread astrid_follow_path( "ww_step_06_a", 0, 1, 1, undefined, 1 );
    }
    
    profilestop();
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0xc194a712, Offset: 0x69db
// Size: 0x161
function private function_15291b9de92be3b9( skipped, save_restored )
{
    zm_sat_locust_util::log_quest_step( 1, #"complete_second_platform", skipped, save_restored );
    level notify( #"hash_10c7b8fbcd3c41e9" );
    level thread platforms_timeout_watcher();
    
    if ( skipped || save_restored )
    {
        level thread zm_sat_locust_floating_rocks::show_group( "wwq_path_2", 1, 1 );
        return;
    }
    else
    {
        level thread function_31dcac3514df7831();
        level thread function_3767fb7ddd656bf1( "wwq_path_2", "ww_li_ba_pl" );
        zm_sat_locust_floating_rocks::show_group( "wwq_path_2", 1, 1, [ 0.4, 0.5 ] );
    }
    
    params = { #flag:"ww_step_06_b", #spawn_zones:[ zone_manager::get_zone_struct( "zone_lighthouse_int_puzzle_3" ) ], #aitypes:[ { #type:"zombie_base", #weight:80 }, { #type:"zombie_base_luna", #weight:20 } ], #count:10 };
    level thread function_e3fda40c3fe2b3cd( params );
    utility::flag_wait( "ww_step_06_a" );
    level thread astrid_follow_path( "ww_step_06_b" );
    zm_sat_locust_util::function_295a36ef38f5acae( #"hash_fef47572de8da397", params );
    utility::flag_wait( "ww_step_06_b" );
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0x9f044526, Offset: 0x6b44
// Size: 0x6e
function private function_3767fb7ddd656bf1( notify_string, struct_targetname )
{
    level endon( #"zm_game_over" );
    v_location = utility::getstruct( struct_targetname );
    navobstacle = function_8bf6c5fe849106c4( v_location.origin, ( 0, 0, 0 ), 6, 128, 96 );
    level waittill( notify_string );
    destroynavobstacle( navobstacle );
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0x74231715, Offset: 0x6bba
// Size: 0x69
function private function_af8e3369ae6a5636( skipped, save_restored )
{
    profilestart();
    zm_sat_locust_util::log_quest_step( 0, #"complete_second_platform", skipped, save_restored );
    
    if ( skipped || save_restored )
    {
        level astrid_follow_path( "ww_step_06_b", 0, 1 );
    }
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    profilestop();
}

// Namespace zm_sat_locust_quest_ww
// Params 0, eflags: 0x4
// Checksum 0x8fa83a56, Offset: 0x6c2b
// Size: 0xab
function private function_31dcac3514df7831()
{
    if ( utility::flag( "ww_virgil_shown" ) )
    {
        return;
    }
    
    utility::flag_wait( "begin_round_logic" );
    utility::flag_set( "ww_virgil_shown" );
    scene_struct = utility::getstruct( "ww_virgil_appear" );
    scene_struct scene::add_scene_func( scene_struct, &function_f74dd452b046070e, "callback_play" );
    scene_struct scene::add_scene_func( scene_struct, &function_f08e257d4eed6584, "callback_done" );
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"hash_e8405c2a169a1526" );
    shot_list = [ "intro", "outro" ];
    scene_struct thread scene::play( undefined, shot_list );
}

// Namespace zm_sat_locust_quest_ww
// Params 0, eflags: 0x4
// Checksum 0x2e0df9be, Offset: 0x6cde
// Size: 0x94
function private function_f74dd452b046070e()
{
    if ( !self.shadowsmith )
    {
        [ shadowsmith ] = scene::get_entities();
        shadowsmith.is_immune = 1;
        shadowsmith invisiblenotsolid();
        wait 0.1;
    }
    else
    {
        shadowsmith = self.shadowsmith;
    }
    
    if ( shadowsmith.link )
    {
        shadowsmith.link unlink();
        shadowsmith.link delete();
    }
    
    shadowsmith visiblesolid();
    shadowsmith setsolid( 0 );
}

// Namespace zm_sat_locust_quest_ww
// Params 0, eflags: 0x4
// Checksum 0xf976f4b2, Offset: 0x6d7a
// Size: 0xc
function private function_f08e257d4eed6584()
{
    deactivateworldevent( "we_lighthouse_water" );
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0xf0d4eec, Offset: 0x6d8e
// Size: 0x42
function private function_7d6d633ab952c4d7( skipped, save_restored )
{
    zm_sat_locust_util::log_quest_step( 1, #"enter_lighthouse", skipped, save_restored );
    
    if ( skipped || save_restored )
    {
        return;
    }
    
    utility::flag_wait( "ww_step_07" );
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0x91d0351d, Offset: 0x6dd8
// Size: 0x7f
function private function_60062548e78b7d3c( skipped, save_restored )
{
    profilestart();
    zm_sat_locust_util::log_quest_step( 0, #"enter_lighthouse", skipped, save_restored );
    
    if ( skipped || save_restored )
    {
        utility::flag_set( "ww_step_07" );
    }
    
    zone_manager::set_zone_enabled( "zone_lighthouse_int_puzzle_5", 1 );
    utility::flag_set( "zone_lighthouse_int_puzzle_5_unlocked" );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    profilestop();
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0x6b57cea4, Offset: 0x6e5f
// Size: 0x157
function private function_7d6d583ab952aca6( skipped, save_restored )
{
    zm_sat_locust_util::log_quest_step( 1, #"craft_ww", skipped, save_restored );
    
    if ( skipped || save_restored )
    {
        return;
    }
    
    wait 1.5;
    lantern_location = utility::getstruct( "li_de_in" );
    crypt_lantern = zm_sat_locust_util::get_quest_reference( #"hash_90013a88c1591def" );
    zm_sat_locust_util::function_82f9bbbcb47ef102( #"hash_709d77ab2b2005c5", #"craft_ww", "lantern: " + isdefined( crypt_lantern ) + " | pre warp org: " + crypt_lantern.origin + " | post warp org: " + lantern_location.origin );
    crypt_lantern.origin = lantern_location.origin;
    crypt_lantern.angles = lantern_location.angles;
    crypt_lantern show();
    crypt_lantern setscriptablepartstate( #"body", #"visible" );
    crypt_lantern setscriptablepartstate( #"effects", #"lighthouse_uncharged" );
    lighthouse_light = zm_sat_locust_util::get_quest_reference( #"ww_lighthouse_light" );
    wait 5;
    lighthouse_light thread function_d9bd466e1cf4c4a4();
    level thread function_722f98d8815d32e( crypt_lantern );
    utility::flag_wait( "ww_step_08" );
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0xd4788efd, Offset: 0x6fbe
// Size: 0x250
function private function_60062c48e78b8ca1( skipped, save_restored )
{
    profilestart();
    zm_sat_locust_util::log_quest_step( 0, #"craft_ww", skipped, save_restored );
    zm_sat_locust_sa::function_93f25e062d584684( "lighthouse" );
    level callback::remove( "on_zombie_ai_killed", &on_zombie_killed );
    function_7fd05a1a50b6c183();
    function_ffd2e29239fafc39();
    platforms_kill_zombies();
    level thread function_f06053b30c7a7fd();
    zone_spawner::function_2ce7db1d59b307d8( "zone_lighthouse_int_puzzle" );
    zone_spawner::function_2ce7db1d59b307d8( "zone_lighthouse_int_puzzle_3" );
    level callback::add( "fasttravel_finished", &function_3550fa8b6afc3006 );
    level utility::delaythread( 15, &callback::remove, "fasttravel_finished", &function_3550fa8b6afc3006 );
    lighthouse_light = zm_sat_locust_util::get_quest_reference( #"ww_lighthouse_light" );
    lighthouse_light utility::delaythread( 5, &function_64ef5a7ebb109000 );
    level callback::remove( #"player_used_item", &function_ed82df944bd97d07 );
    level callback::remove( #"hash_b0301b9d692ed6b1", &function_138c7b0b31e8b1b5 );
    
    if ( skipped || save_restored )
    {
        utility::flag_set( "ww_step_08" );
        
        if ( !save_restored )
        {
            /#
                player = level.player ?? level.players[ 0 ];
                function_3f18dfc7f3bbf774( 1, undefined, undefined, player );
                player namespace_e625df044ece0a58::function_1873ace2fc909565( 100 );
            #/
        }
    }
    
    platform_2 = zm_sat_locust_util::get_quest_reference( #"ww_platform_2" );
    platform_2 utility::delaythread( 0.25, &function_46c6f25766d87633 );
    magicbox::function_6c4ffb8218367c4b( %"hash_4e5e12b8328b46fd", 3 );
    magicbox::function_2e49cd8681e36211( 0 );
    ww_kill_triggers = getnoentvolumearray( "ww_kill_trigger", #targetname );
    utility::array_thread( ww_kill_triggers, &floating_kill_triggers );
    ww_lighthouse_middle = getnoentvolumearray( "ww_lighthouse_middle", #targetname )[ 0 ];
    ww_lighthouse_middle thread function_dfd3d34858418f3a();
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( #"hash_90013a88c1591def" ) )
    {
        var_cb5369743609abbe = zm_sat_locust_util::get_quest_reference( #"hash_90013a88c1591def" );
        var_cb5369743609abbe delete();
    }
    
    level thread respawn_ww_monitor();
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
    
    profilestop();
}

// Namespace zm_sat_locust_quest_ww
// Params 1, eflags: 0x4
// Checksum 0x64d9f1cc, Offset: 0x7216
// Size: 0x116
function private function_722f98d8815d32e( crypt_lantern )
{
    astrid = zm_sat_locust_util::get_quest_reference( #"ww_astrid" );
    zm_sat_locust_util::function_82f9bbbcb47ef102( #"hash_709d77ab2b2005c5", #"craft_ww", "astrid: " + isdefined( crypt_lantern ) );
    var_fc4be8392a15b161 = utility::getstruct( "ww_astrid_lighthouse" );
    var_888b2cd32ee08825 = utility::getstruct( "li_ww_lo" );
    var_fc4be8392a15b161 thread scene::play( astrid );
    level waittill( #"astrid_start_energy_blast" );
    crypt_lantern setscriptablepartstate( #"effects", #"lighthouse_charged" );
    crypt_lantern moveby( ( 0, 0, 21 ), 2.75, 0.5, 0.5 );
    crypt_lantern rotateby( ( 0, 3600, 0 ), 3.6, 1, 1 );
    level waittill( #"astrid_swap_lantern" );
    level thread function_3f18dfc7f3bbf774( 0, var_888b2cd32ee08825.origin, var_888b2cd32ee08825.angles );
    crypt_lantern delete();
}

// Namespace zm_sat_locust_quest_ww
// Params 4, eflags: 0x4
// Checksum 0x4923ea2f, Offset: 0x7334
// Size: 0x172
function private function_3f18dfc7f3bbf774( skipped = 0, spawn_origin = ( 0, 0, 0 ), spawn_angles = ( 0, 0, 0 ), player )
{
    spawnoptions = common_item::function_bc5ff2958b71a708( spawn_origin, spawn_angles );
    spawnoptions.var_17415ad785d0eab6 = "brloot_weapon_ww_locust";
    itembundle = getscriptbundle( %"hash_4e5e12b8328b46fd" );
    item = item_weapon::function_b960bc85ea91de14( itembundle, spawnoptions );
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( #"ww_pickup_item" ) )
    {
        zm_sat_locust_util::function_222215ce3aef9da1( #"ww_pickup_item", item );
    }
    else
    {
        zm_sat_locust_util::function_295a36ef38f5acae( #"ww_pickup_item", item );
    }
    
    if ( skipped )
    {
        if ( player )
        {
            level common_item::items_scriptable_used( item, item function_84ad2f70189ee7c3(), #"visible_original_position_subtle_outline", player, 0 );
        }
        
        return;
    }
    
    level callback::add( #"player_used_item", &function_ed82df944bd97d07 );
    level callback::add( #"hash_b0301b9d692ed6b1", &function_138c7b0b31e8b1b5 );
    waitframe();
    item utility::function_7c10ea82c1e305b8( "spawn_fx", "max_charge" );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        zm_quest::function_b5d75b34f712db9a();
        item setscriptablepartstate( #"objective", #"enabled" );
    }
}

// Namespace zm_sat_locust_quest_ww
// Params 1, eflags: 0x4
// Checksum 0xd1a9dc19, Offset: 0x74ae
// Size: 0xd0
function private function_ed82df944bd97d07( params )
{
    if ( !zm_sat_locust_util::function_3112dc4740eb8499( #"ww_pickup_item" ) )
    {
        return;
    }
    
    ww = zm_sat_locust_util::get_quest_reference( #"ww_pickup_item" );
    
    if ( params.item != ww )
    {
        return;
    }
    
    thread function_c080999fe682834b();
    level musicbank_utility::function_5aca66c390aa347d( level.players, #"hash_a7f923e8264a1ae4" );
    thread utility::callsharedfunc( #"intel", #"collect_intel", "zmintel_sat_locust_artifact_2" );
    level callback::remove( #"player_used_item", &function_ed82df944bd97d07 );
    level callback::remove( #"hash_b0301b9d692ed6b1", &function_138c7b0b31e8b1b5 );
    zm_sat_locust_sa::function_93f25e062d584684( "lighthouse" );
    utility::flag_set( "ww_step_08" );
}

// Namespace zm_sat_locust_quest_ww
// Params 0, eflags: 0x4
// Checksum 0xe753bfa5, Offset: 0x7586
// Size: 0x119
function private function_f06053b30c7a7fd()
{
    wait 3.5;
    lighthouse_trigger = getnoentvolumearray( "ww_lighthouse_top", #targetname )[ 0 ];
    
    foreach ( player in utility::get_alive_players() )
    {
        if ( player istouching( lighthouse_trigger ) && !player.var_d1c4c78b9fb7d153 )
        {
            player notify( #"hash_544a6aa7b92eaeb5" );
        }
    }
    
    wait 2.5;
    zone_manager::set_zone_enabled( "zone_lighthouse_int_puzzle", 0 );
    zone_manager::set_zone_enabled( "zone_lighthouse_int_puzzle_3", 0 );
    zone_manager::set_zone_enabled( "zone_lighthouse_int_puzzle_5", 0 );
    
    if ( zm_quest::function_b0a5181ebe7bb905() )
    {
        wait 2;
        utility::flag_set( "ww_dm_exit_lighthouse" );
        level thread utility::callsharedfunc( #"locust_dm", #"hash_2105e0b9cf6e1f5b" );
    }
}

// Namespace zm_sat_locust_quest_ww
// Params 0, eflags: 0x4
// Checksum 0x9cfc3188, Offset: 0x76a7
// Size: 0x6e
function private function_c080999fe682834b()
{
    level endon( #"zm_game_over" );
    self endon( #"death_or_disconnect" );
    
    if ( self.var_420915a121e1cc41 )
    {
        val::set( #"ww_quest", "usability", 0 );
        self waittill( #"hash_b4a67d49d98f7e29" );
        val::reset( #"ww_quest", "usability" );
    }
    
    thread zm_vo::function_8c1a12974bd11f01( #"wwq_pick_up_ww" );
}

// Namespace zm_sat_locust_quest_ww
// Params 1, eflags: 0x4
// Checksum 0xdeb41def, Offset: 0x771d
// Size: 0x72
function private function_138c7b0b31e8b1b5( params )
{
    if ( !arraycontains( level.var_db1ca16030498d75.interactions, params.interact ) )
    {
        item = zm_sat_locust_util::get_quest_reference( #"ww_pickup_item" );
        level common_item::items_scriptable_used( item, item function_84ad2f70189ee7c3(), #"visible_original_position_subtle_outline", params.player, 0 );
    }
}

// Namespace zm_sat_locust_quest_ww
// Params 0, eflags: 0x4
// Checksum 0x216afad8, Offset: 0x7797
// Size: 0x42
function private floating_kill_triggers()
{
    level endon( #"zm_game_over" );
    wait 1.5;
    
    for ( ;; )
    {
        self waittill( #"trigger", entity );
        
        if ( isscriptedai( entity ) )
        {
            entity kill_zombie();
        }
    }
}

// Namespace zm_sat_locust_quest_ww
// Params 0, eflags: 0x4
// Checksum 0x4942a581, Offset: 0x77e1
// Size: 0xa2
function private kill_zombie()
{
    self endon( #"death" );
    zombie = self;
    
    if ( zombie val::get( "ignore_cleanup" ) || zombie.b_ignore_cleanup || zombie.aicategory == "special" || zombie.aicategory == "elite" || zombie.aicategory == "hvt" )
    {
        zombie.var_a13bed1ac47e1b2c = 1;
        zombie zm_sat_locust_util::function_44f5bec4abb163f1( 1 );
        return;
    }
    
    zombie zm_cleanup_manager::function_44f5bec4abb163f1( 1, 1 );
}

// Namespace zm_sat_locust_quest_ww
// Params 1, eflags: 0x4
// Checksum 0x1b3de62e, Offset: 0x788b
// Size: 0xd6
function private function_e3fda40c3fe2b3cd( params )
{
    if ( params.flag )
    {
        level endon( params.flag );
    }
    
    if ( level.var_a009ab14ee0d3223.state == 0 && !utility::flag( "begin_round_logic" ) )
    {
        utility::flag_wait( "begin_round_logic" );
    }
    
    if ( level.var_a009ab14ee0d3223.state == 1 )
    {
        while ( !zm_utility::function_922d522db5f1ceda( params.count, [ "normal" ], undefined ) )
        {
            wait 0.5;
        }
    }
    
    while ( params.count > 0 )
    {
        zombie = zm_sat_locust_util::spawn_quest_zombie( params );
        
        if ( zombie )
        {
            params.count--;
        }
    }
}

// Namespace zm_sat_locust_quest_ww
// Params 1, eflags: 0x4
// Checksum 0xf9a77fa8, Offset: 0x7969
// Size: 0x51
function private function_3550fa8b6afc3006( params )
{
    if ( self.var_420915a121e1cc41 )
    {
        zone = zone_manager::function_90e5c3e2272b0130( self.origin );
        
        if ( zone.is_enabled )
        {
            return;
        }
        
        waitframe();
        self notify( #"hash_544a6aa7b92eaeb5", 1 );
    }
}

// Namespace zm_sat_locust_quest_ww
// Params 1, eflags: 0xc
// Checksum 0xde2869d3, Offset: 0x79c2
// Size: 0x3f
function private function_739003bbba5c3ec7( blocking_time )
{
    self notify( #"hash_c636c2cbdde0e98b" );
    self endon( #"hash_c636c2cbdde0e98b" );
    utility::flag_set( "locust_skip_round_vo" );
    wait blocking_time;
    utility::flag_clear( "locust_skip_round_vo" );
}

// Namespace zm_sat_locust_quest_ww
// Params 1, eflags: 0xc
// Checksum 0x6db0d34c, Offset: 0x7a09
// Size: 0xce
function private function_dfd3d34858418f3a( immediate = 0 )
{
    self notify( #"hash_a225e823277ba953" );
    self endon( #"hash_a225e823277ba953" );
    level endon( #"zm_game_over" );
    level endon( #"game_ended" );
    level endon( #"hash_10c7b8fbcd3c41e9" );
    
    if ( !immediate )
    {
        wait 5;
    }
    
    for ( ;; )
    {
        self waittill( #"trigger", entity );
        
        if ( isplayer( entity ) )
        {
            if ( entity.is_resetting )
            {
                continue;
            }
            
            if ( !ispointinvolume( entity.origin, self, 1 ) )
            {
                continue;
            }
            
            spawn_point = entity zone_manager::function_aeaa8dd788ed9b16( undefined, 0, undefined, undefined, undefined, 1 );
            entity thread zm_sat_locust_floating_rocks::function_b8628007359aae67( spawn_point );
        }
    }
}

// Namespace zm_sat_locust_quest_ww
// Params 0, eflags: 0x4
// Checksum 0xc326fbee, Offset: 0x7adf
// Size: 0x140
function private respawn_ww_monitor()
{
    level endon( #"zm_game_over" );
    level endon( #"game_ended" );
    level callback::add( #"player_death", &function_674f565359a341d1 );
    level callback::add( #"player_disconnect", &function_674f565359a341d1 );
    level callback::add( #"player_item_drop", &function_c855f7617917942e );
    var_6628460af75e6020 = utility::getstruct( "cr_la_lo" );
    
    for ( ;; )
    {
        level.quest_ww utility::ent_flag_wait( "is_ww_resp" );
        spawnoptions = common_item::function_bc5ff2958b71a708( var_6628460af75e6020.origin + ( 0, 0, 40 ), ( 0, 30, 0 ) );
        spawnoptions.var_17415ad785d0eab6 = "brloot_weapon_ww_locust";
        spawnoptions.var_fd47e835523b473f = 1;
        spawnoptions.critical = 1;
        itembundle = getscriptbundle( %"hash_4e5e12b8328b46fd" );
        item = item_weapon::function_b960bc85ea91de14( itembundle, spawnoptions );
        item utility::function_7c10ea82c1e305b8( "spawn_fx", "max_charge" );
        level.quest_ww utility::ent_flag_clear( "is_ww_resp" );
    }
}

// Namespace zm_sat_locust_quest_ww
// Params 1, eflags: 0x4
// Checksum 0x56ee8b43, Offset: 0x7c27
// Size: 0x6f
function private function_674f565359a341d1( sparams )
{
    player = sparams.victim ?? self;
    
    if ( player function_3343f083309374e3() || level.quest_ww.var_b60c1fd3b1677216.size > 0 )
    {
        return;
    }
    
    level.quest_ww utility::ent_flag_set( "is_ww_resp" );
    
    /#
        logstring( "<dev string:x74>" );
    #/
}

// Namespace zm_sat_locust_quest_ww
// Params 1, eflags: 0x4
// Checksum 0xda47ea05, Offset: 0x7c9e
// Size: 0x127
function private function_c855f7617917942e( sparams )
{
    waitframe();
    
    if ( sparams.item.weaponobj.basename != "sat_ww_locust_zm" )
    {
        return;
    }
    
    if ( !isdefined( level.quest_ww.var_b60c1fd3b1677216 ) )
    {
        level.quest_ww.var_b60c1fd3b1677216 = [];
    }
    
    level.quest_ww.var_b60c1fd3b1677216[ level.quest_ww.var_b60c1fd3b1677216.size ] = sparams.item;
    sparams.item waittill( #"death" );
    
    if ( function_3343f083309374e3() || sparams.item.pickedup )
    {
        level.quest_ww.var_b60c1fd3b1677216 = arrayremove( level.quest_ww.var_b60c1fd3b1677216, sparams.item );
        return;
    }
    
    level.quest_ww utility::ent_flag_set( "is_ww_resp" );
    
    /#
        logstring( "<dev string:xb1>" );
    #/
}

// Namespace zm_sat_locust_quest_ww
// Params 0, eflags: 0x4
// Checksum 0x59bffd56, Offset: 0x7dcd
// Size: 0x104, Type: bool
function private function_3343f083309374e3()
{
    foreach ( player in utility::get_alive_players() )
    {
        if ( player == self )
        {
            continue;
        }
        
        foreach ( weapon in player.weaponlist )
        {
            if ( weapon.basename != "sat_ww_locust_zm" )
            {
                continue;
            }
            
            return true;
        }
    }
    
    return false;
}

// Namespace zm_sat_locust_quest_ww
// Params 2, eflags: 0x4
// Checksum 0xb2b9006a, Offset: 0x7eda
// Size: 0x1aa
function private function_7fd05a1a50b6c183( reset_zones, var_b4751bb5cda927c4 = 1 )
{
    platform_2 = zm_sat_locust_util::get_quest_reference( #"ww_platform_2" );
    platform_players = arraycombineunique( zone_manager::get_zone_occupants( "zone_lighthouse_int_puzzle" ), zone_manager::get_zone_occupants( "zone_lighthouse_int_puzzle_3" ), zone_manager::get_zone_occupants( "zone_lighthouse_int_puzzle_4" ) );
    
    foreach ( player in platform_players )
    {
        spawn_point = player zone_manager::function_aeaa8dd788ed9b16( undefined, 0, undefined, reset_zones, undefined, 1 );
        player thread zm_sat_locust_floating_rocks::function_b8628007359aae67( spawn_point );
    }
    
    if ( var_b4751bb5cda927c4 )
    {
        foreach ( player in utility::get_alive_players() )
        {
            if ( player istouching( platform_2.blocker ) || player istouching( platform_2.blocker.rubble ) )
            {
                spawn_point = player zone_manager::function_aeaa8dd788ed9b16( undefined, 0, undefined, reset_zones, undefined, 1 );
                player thread zm_sat_locust_floating_rocks::function_b8628007359aae67( spawn_point );
            }
        }
    }
}

// Namespace zm_sat_locust_quest_ww
// Params 1, eflags: 0x4
// Checksum 0xf5fc67d4, Offset: 0x808c
// Size: 0x10f
function private function_ffd2e29239fafc39( show_rubble = 1 )
{
    level callback::remove( "zone_changed", &on_platform_zone_changed );
    platform_1 = zm_sat_locust_util::get_quest_reference( #"ww_platform_1" );
    platform_2 = zm_sat_locust_util::get_quest_reference( #"ww_platform_2" );
    zm_sat_locust_floating_rocks::hide_group( [ "wwq_path_1", "wwq_path_2" ], 1, 1 );
    platform_1.clip show();
    platform_1.var_d3823b80b1397854 hide();
    platform_2.var_d3823b80b1397854 hide();
    
    if ( show_rubble )
    {
        platform_2.blocker show();
        platform_2.blocker.rubble show();
    }
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( #"ww_platform_skyclip" ) )
    {
        sky_clips = zm_sat_locust_util::get_quest_reference( #"ww_platform_skyclip" );
        utility::array_call( sky_clips, &show );
    }
}

// Namespace zm_sat_locust_quest_ww
// Params 0, eflags: 0x4
// Checksum 0x5d353ddb, Offset: 0x81a3
// Size: 0x177
function private platforms_kill_zombies()
{
    removeallcorpses();
    zombies = zm_utility::get_active_zombies();
    valid_zombies = [];
    
    foreach ( zombie in zombies )
    {
        zone = zombie zone_manager::get_current_zone();
        
        if ( zone.zone_name == "zone_lighthouse_int_puzzle" || zone.zone_name == "zone_lighthouse_int_puzzle_3" )
        {
            valid_zombies[ valid_zombies.size ] = zombie;
        }
    }
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( #"hash_a7b7555998e8ee50" ) )
    {
        var_1b880641ae3c4e6b = zm_sat_locust_util::get_quest_reference( #"hash_a7b7555998e8ee50" );
        zm_sat_locust_util::function_7bf944a5a2b76f39( #"hash_a7b7555998e8ee50" );
    }
    
    if ( zm_sat_locust_util::function_3112dc4740eb8499( #"hash_fef47572de8da397" ) )
    {
        var_ebaf66003b273334 = zm_sat_locust_util::get_quest_reference( #"hash_fef47572de8da397" );
        zm_sat_locust_util::function_7bf944a5a2b76f39( #"hash_fef47572de8da397" );
    }
    
    valid_zombies = arraycombineunique( valid_zombies, var_1b880641ae3c4e6b.var_4c6516944983d5d8 ?? [], var_ebaf66003b273334.var_4c6516944983d5d8 ?? [] );
    utility::array_thread( valid_zombies, &kill_zombie );
}

// Namespace zm_sat_locust_quest_ww
// Params 0, eflags: 0xc
// Checksum 0xe703cb5d, Offset: 0x8322
// Size: 0x2d6
function private platforms_timeout_watcher()
{
    self notify( #"hash_2ba6347d9b6c0d5e" );
    self endon( #"hash_2ba6347d9b6c0d5e" );
    level endon( #"game_ended" );
    level endon( #"zm_game_over" );
    level endon( #"ww_step_07" );
    round_gate = getdvarint( @"hash_607341848463e7b2", 50 );
    platform_timeout = getdvarfloat( @"hash_3b5d1b9a9aa35013", 15 );
    
    if ( round_gate == 0 )
    {
        return;
    }
    
    while ( zm_utility::get_round_number() < round_gate )
    {
        level waittill( #"on_round_start" );
    }
    
    wait platform_timeout * 60;
    reset_zones = [ "zone_downtown", "zone_downtown_dock", "zone_downtown_meadhall", "zone_downtown_middle_street" ];
    function_7fd05a1a50b6c183( reset_zones, 0 );
    function_ffd2e29239fafc39( 0 );
    platforms_kill_zombies();
    scene_struct = utility::getstruct( "ww_virgil_appear" );
    
    if ( scene_struct scene::get_state() != "Playing" )
    {
        [ virgil ] = scene_struct scene::get_entities();
        
        if ( virgil.link )
        {
            virgil.link unlink();
            virgil.link delete();
        }
        
        scene_struct scene::cleanup( 1 );
    }
    
    utility::flag_set( "ww_reset" );
    astrid_loc = utility::getstruct( "ww_astrid" );
    astrid = zm_sat_locust_util::get_quest_reference( #"ww_astrid" );
    astrid.path = astrid_loc;
    utility::flag_clear( "zone_lighthouse_int_puzzle_unlocked" );
    utility::flag_clear( "zone_lighthouse_int_puzzle_3_unlocked" );
    utility::flag_clear( "zone_lighthouse_int_puzzle_4_unlocked" );
    zone_manager::set_zone_enabled( "zone_lighthouse_int_puzzle", 0 );
    zone_manager::set_zone_enabled( "zone_lighthouse_int_puzzle_3", 0 );
    zone_manager::set_zone_enabled( "zone_lighthouse_int_puzzle_4", 0 );
    
    if ( !utility::flag( "ww_step_05_b" ) )
    {
        utility::flag_clear( "zone_lighthouse_int_puzzle_2_unlocked" );
        zone_manager::set_zone_enabled( "zone_lighthouse_int_puzzle_2", 0 );
    }
    
    utility::flag_clear( "ww_step_04" );
    utility::flag_clear( "ww_step_04_a" );
    utility::flag_clear( "ww_step_04_b" );
    utility::flag_clear( "ww_step_04_c" );
    utility::flag_clear( "ww_step_04_d" );
    utility::flag_clear( "ww_step_05" );
    utility::flag_clear( "ww_step_05_a" );
    utility::flag_clear( "ww_step_05_b" );
    utility::flag_clear( "ww_step_06" );
    utility::flag_clear( "ww_step_06_a" );
    utility::flag_clear( "ww_step_06_b" );
    utility::flag_clear( "ww_dm_follow" );
    utility::flag_clear( "ww_dm_spawn_platforms" );
    level thread zm_quest::function_80abdea0cd4c89a7( #"hash_709d77ab2b2005c5", #"hash_8608a512dec03657" );
}

/#

    // Namespace zm_sat_locust_quest_ww
    // Params 0, eflags: 0x4
    // Checksum 0xf3812370, Offset: 0x8600
    // Size: 0xc, Type: dev
    function private debug_init()
    {
        devgui_init();
    }

    // Namespace zm_sat_locust_quest_ww
    // Params 0, eflags: 0x4
    // Checksum 0x256953b0, Offset: 0x8614
    // Size: 0x3b, Type: dev
    function private devgui_init()
    {
        zm_quest::function_1b5b11caffa04d9a( #"hash_709d77ab2b2005c5", #"crypt_puzzle" );
        devgui::add_devgui_func( "<dev string:xf1>", "<dev string:xfb>", &function_cd426d24a5d5afd8 );
        zm_quest::function_c1400a2f4670c23f();
    }

    // Namespace zm_sat_locust_quest_ww
    // Params 0, eflags: 0x4
    // Checksum 0xa98db667, Offset: 0x8657
    // Size: 0xd, Type: dev
    function private function_cd426d24a5d5afd8()
    {
        level thread debug_show_code();
    }

    // Namespace zm_sat_locust_quest_ww
    // Params 0, eflags: 0x4
    // Checksum 0x6eea74a0, Offset: 0x866c
    // Size: 0x173, Type: dev
    function private debug_show_code()
    {
        level notify( #"debug_show_code" );
        level endon( #"debug_show_code" );
        
        if ( zm_sat_locust_util::function_3112dc4740eb8499( #"hash_269c0a0b24041534" ) )
        {
            code = zm_sat_locust_util::get_quest_reference( #"hash_269c0a0b24041534" );
        }
        else
        {
            code = function_6965e07e21a497ba();
        }
        
        iprintlnbold( "<dev string:x108>" + code[ 0 ] + code[ 1 ] + code[ 2 ] + code[ 3 ] );
        constellations = zm_sat_locust_util::get_quest_reference( #"hash_c98526cdf85af191" );
        
        foreach ( constellation in constellations )
        {
            if ( !isdefined( constellation.object ) )
            {
                return;
            }
            
            debug::sphere( constellation.object, 10, constellation.special && constellation.letter == code[ level.quest_ww.code_idx ] ? ( 0, 1, 0 ) : ( 1, 0, 0 ), 30, "<dev string:x114>", "<dev string:x124>" );
        }
    }

#/
