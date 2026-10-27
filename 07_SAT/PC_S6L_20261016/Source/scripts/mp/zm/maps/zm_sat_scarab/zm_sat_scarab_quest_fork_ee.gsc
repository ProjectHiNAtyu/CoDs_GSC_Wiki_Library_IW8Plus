// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_quest_fork_ee.gsc  (hash_36cfd0084bdbc280.gscc) (size: 19795 Bytes / 0x4d53 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3a22b01d (975351837)
// size ...... 19795 (0x4d53)
// includes .. 18  (offset: 0x4817)
// strings ... 68  (offset: 0x48a7)
// dev strs .. 4   (offset: 0x4d23)
// exports ... 33  (offset: 0x3143)
// cseg ...... 0x5e0 + 0x2b63 (0x3143)
// imports ... 142 (offset: 0x366b)
// animtree1 . 0   (offset: 0x4d53)
// animtree2 . 0   (offset: 0x4d53)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\pack_a_punch;
#using scripts\mp\player_banter;
#using scripts\mp\zm\systems\agent_manager;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\zm_player;

#namespace zm_sat_scarab_quest_fork_ee;

// Namespace zm_sat_scarab_quest_fork_ee
// Params 0, eflags: 0x5
// Checksum 0xc1bb6a59, Offset: 0x5fe
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_20698c81753fa56b", undefined, undefined, &postmain_init );
}

// Namespace zm_sat_scarab_quest_fork_ee
// Params 0, eflags: 0x4
// Checksum 0x1827f142, Offset: 0x61f
// Size: 0x285
function private postmain_init()
{
    if ( !getdvarint( @"hash_1339f37dad46cdfd", 0 ) )
    {
        return;
    }
    
    level utility::flag_wait_all( "zm_quest_initialized", "scriptables_ready", "wallbuy_ready" );
    level.scarab_fork_ee = zm_quest::get_quest( #"hash_653e5e819076b55a" );
    
    foreach ( quest_step_ref in [ #"hash_da0727eda1d3180c", #"hash_86f7e9d256d5e4cf", #"hash_4511780ffaf8aafd" ] )
    {
        level zm_quest::register_quest_step( #"hash_653e5e819076b55a", quest_step_ref, &setup_dummy_step, &cleanup_dummy_step );
    }
    
    foreach ( s_wallbuy_locations in level.var_caf65b937e9cbfaf )
    {
        if ( !isdefined( level.scarab_fork_ee.var_4319044cd39cfdf1 ) )
        {
            level.scarab_fork_ee.var_4319044cd39cfdf1 = [];
        }
        
        level.scarab_fork_ee.var_4319044cd39cfdf1[ level.scarab_fork_ee.var_4319044cd39cfdf1.size ] = s_wallbuy_locations.wallbuy_scriptable;
    }
    
    level.scarab_fork_ee.a_triggers = getentarray( "fork_trigger", #targetname );
    level utility::add_fx( "fork_ee_hint", "vfx_t10_levels_zm_topaz_book_ambient" );
    level utility::add_fx( "fork_ee_hvt_start", "vfx_sat_levels_zm_firefly_phone_booth_spawn" );
    level utility::add_fx( "fork_ee_hvt_end", "vfx_sat_levels_zm_firefly_phone_booth_trail" );
    level.scarab_fork_ee.var_b42fbbba0f91c4d = 0;
    level callback::add( #"hash_6e3acfc32f60c580", &function_d41e2f20454856b7 );
    level thread function_5282a131705cca4d();
    namespace_9d8e359c3b1041e5::function_95538e4344ab0bfb( #"hash_d0c7d27688f73898", &function_59bb0530c0d91f80 );
    
    /#
        level thread setup_fork_ee_devgui();
    #/
    
    level zm_save::function_1f44a48caae2acbf();
    level zm_quest::start_quest( #"hash_653e5e819076b55a" );
}

// Namespace zm_sat_scarab_quest_fork_ee
// Params 1, eflags: 0x4
// Checksum 0x691fe7d5, Offset: 0x8ac
// Size: 0xf0
function private function_d41e2f20454856b7( sparams )
{
    level.scarab_fork_ee.var_4319044cd39cfdf1 = [];
    
    foreach ( s_wallbuy_locations in level.var_caf65b937e9cbfaf )
    {
        if ( !isdefined( level.scarab_fork_ee.var_4319044cd39cfdf1 ) )
        {
            level.scarab_fork_ee.var_4319044cd39cfdf1 = [];
        }
        
        level.scarab_fork_ee.var_4319044cd39cfdf1[ level.scarab_fork_ee.var_4319044cd39cfdf1.size ] = s_wallbuy_locations.wallbuy_scriptable;
    }
}

// Namespace zm_sat_scarab_quest_fork_ee
// Params 1, eflags: 0x4
// Checksum 0xd4152136, Offset: 0x9a4
// Size: 0xe9
function private function_5282a131705cca4d( sparams )
{
    level utility::flag_wait( "wallbuy_ready" );
    
    foreach ( trigger in level.scarab_fork_ee.a_triggers )
    {
        wallbuy_scriptable = function_47c86977a18df38b( level.scarab_fork_ee.var_4319044cd39cfdf1, trigger.origin, 256 );
        
        if ( !wallbuy_scriptable || !wallbuy_scriptable getscriptablehaspart( "wallbuy" ) )
        {
            continue;
        }
        
        wallbuy_scriptable.var_8f971982b0ee9b70 = 1;
    }
}

// Namespace zm_sat_scarab_quest_fork_ee
// Params 1, eflags: 0x4
// Checksum 0x2727a70e, Offset: 0xa95
// Size: 0x1a2
function private function_59bb0530c0d91f80( sparams )
{
    if ( !isdefined( sparams[ 0 ] ) )
    {
        return;
    }
    
    weaponidx = int( sparams[ 0 ] );
    
    if ( !isdefined( [ %"hash_5cbebf1bee04d1f3", %"hash_faffbe41573e52" ][ weaponidx ] ) )
    {
        return;
    }
    
    var_d6ba54ca8914813 = undefined;
    
    foreach ( trigger in level.scarab_fork_ee.a_triggers )
    {
        if ( !trigger.script_noteworthy || int( trigger.script_noteworthy ) != weaponidx )
        {
            continue;
        }
        
        var_d6ba54ca8914813 = trigger;
        break;
    }
    
    if ( !isdefined( var_d6ba54ca8914813 ) )
    {
        return;
    }
    
    player = isplayer( self ) ? self : level.players[ 0 ];
    var_9905d057ba995d31 = function_47c86977a18df38b( level.scarab_fork_ee.var_4319044cd39cfdf1, player.origin, 256 );
    
    if ( !isdefined( var_9905d057ba995d31 ) )
    {
        return;
    }
    
    if ( var_9905d057ba995d31 utility::ent_flag( "is_gwy_t_o" ) )
    {
        return;
    }
    
    if ( isplayer( self ) )
    {
        self notify( #"equip_finished_with_deploy_weapon" );
    }
    
    level.scarab_fork_ee utility::ent_flag_set( "co_up_on_wb" );
    var_9905d057ba995d31 thread function_72143c168f4eb66c( weaponidx );
}

// Namespace zm_sat_scarab_quest_fork_ee
// Params 2, eflags: 0x4
// Checksum 0xe0df57af, Offset: 0xc3f
// Size: 0x2c2
function private setup_dummy_step( b_skipped, b_save_restored )
{
    self.callbacks_to_remove = [];
    
    if ( self.ref == #"hash_da0727eda1d3180c" )
    {
        self.var_4aed8c2f655ddd8f = [ "np_purchased" ];
        self.callbacks_to_remove[ "on_pap_machine_purchase" ] = &on_pap_purchased;
        level.scarab_fork_ee.var_31b6fa9f9bad22c9 = 0;
        level callback::add( "on_pap_machine_purchase", &on_pap_purchased );
    }
    else if ( self.ref == #"hash_86f7e9d256d5e4cf" )
    {
        self.var_4aed8c2f655ddd8f = [ "co_up_on_wb" ];
        
        if ( !b_skipped && !b_save_restored )
        {
            level utility::array_thread( level.scarab_fork_ee.a_triggers, &function_560171a12563de0b );
            level utility::array_thread( level.scarab_fork_ee.a_triggers, &function_ce9e9c48a6bc38fa );
        }
    }
    else
    {
        self.var_4aed8c2f655ddd8f = [ "fork_insert" ];
        
        if ( b_save_restored && zm_save::function_fcccc3d2a616b1c7() && self.completed )
        {
            level thread function_ec2b0c5b9f2936f4();
        }
    }
    
    if ( b_skipped || b_save_restored )
    {
        foreach ( flag in self.var_4aed8c2f655ddd8f )
        {
            level.scarab_fork_ee utility::ent_flag_set( flag );
        }
        
        foreach ( callback, func in self.callbacks_to_remove )
        {
            level callback::remove( callback, func );
        }
        
        return;
    }
    
    level.scarab_fork_ee utility::ent_flag_wait_all_array( self.var_4aed8c2f655ddd8f );
    
    foreach ( callback, func in self.callbacks_to_remove )
    {
        level callback::remove( callback, func );
    }
}

// Namespace zm_sat_scarab_quest_fork_ee
// Params 0, eflags: 0x4
// Checksum 0xa46b7515, Offset: 0xf09
// Size: 0xdf
function private function_ec2b0c5b9f2936f4()
{
    level utility::flag_wait( "begin_round_logic" );
    
    foreach ( player in level.players )
    {
        if ( !zm_player::function_f37cfdf04b932a03( player ) )
        {
            continue;
        }
        
        corruptedweapon = function_bab2e52d54846f71( player );
        
        if ( !corruptedweapon )
        {
            continue;
        }
        
        function_e222e0cf2540f313();
    }
    
    if ( !level callback::exists( #"player_used_item", &function_54dbafbce87cb13c ) )
    {
        level callback::add( #"player_used_item", &function_54dbafbce87cb13c );
    }
}

// Namespace zm_sat_scarab_quest_fork_ee
// Params 2, eflags: 0x4
// Checksum 0x94bd094b, Offset: 0xff0
// Size: 0x126
function private cleanup_dummy_step( b_skipped, b_save_restored )
{
    if ( !isdefined( self.var_4aed8c2f655ddd8f ) )
    {
        self.var_4aed8c2f655ddd8f = [];
    }
    
    foreach ( flag in self.var_4aed8c2f655ddd8f )
    {
        level.scarab_fork_ee utility::ent_flag_set( flag );
    }
    
    foreach ( callback, func in self.callbacks_to_remove )
    {
        level callback::remove( callback, func );
    }
}

// Namespace zm_sat_scarab_quest_fork_ee
// Params 1
// Checksum 0xf7228920, Offset: 0x111e
// Size: 0xbf
function on_pap_purchased( sparams )
{
    if ( !isdefined( level.scarab_fork_ee.var_31b6fa9f9bad22c9 ) )
    {
        level.scarab_fork_ee.var_31b6fa9f9bad22c9 = 0;
    }
    
    level.scarab_fork_ee.var_31b6fa9f9bad22c9++;
    var_33e1927459b41f61 = [ 3, 4, 5, 5 ][ level.players.size - 1 ];
    
    if ( level.scarab_fork_ee.var_31b6fa9f9bad22c9 < var_33e1927459b41f61 )
    {
        return;
    }
    
    level.scarab_fork_ee utility::ent_flag_set( "np_purchased" );
    level callback::remove( "on_pap_machine_purchase", &on_pap_purchased );
}

// Namespace zm_sat_scarab_quest_fork_ee
// Params 0
// Checksum 0xb878a33, Offset: 0x11e5
// Size: 0xcd
function function_560171a12563de0b()
{
    level.scarab_fork_ee endon( #"fork_insert" );
    
    while ( true )
    {
        self waittill( #"damage", idamage, eattacker, vdir, vpoint, smeansofdeath, modelname, attachtagname, spartname, dflags, objweapon, origin, angles, normal, einflictor, time );
        thread function_7186c21e50783260( eattacker, einflictor );
    }
}

// Namespace zm_sat_scarab_quest_fork_ee
// Params 0
// Checksum 0xc784492d, Offset: 0x12ba
// Size: 0x1d8
function function_ce9e9c48a6bc38fa()
{
    level.scarab_fork_ee endon( #"fork_insert" );
    
    while ( true )
    {
        wait 2;
        
        if ( !level utility::flag( "its_raining" ) )
        {
            continue;
        }
        
        if ( !level.scarab_fork_ee utility::ent_flag( "np_purchased" ) )
        {
            continue;
        }
        
        foreach ( trigger in level.scarab_fork_ee.a_triggers )
        {
            wallbuy_scriptable = function_47c86977a18df38b( level.scarab_fork_ee.var_4319044cd39cfdf1, trigger.origin, 256 );
            
            if ( !wallbuy_scriptable || !wallbuy_scriptable getscriptablehaspart( "wallbuy" ) || !wallbuy_scriptable.var_5499b4433cb4a919 )
            {
                continue;
            }
            
            if ( wallbuy_scriptable utility::ent_flag( "is_gwy_t_o" ) || wallbuy_scriptable.e_hint_fx_tag )
            {
                continue;
            }
            
            wallbuy_scriptable.e_hint_fx_tag = utility::spawn_model( "tag_origin", wallbuy_scriptable.origin + ( 0, 0, -6 ), ( 0, 0, 0 ) );
            playfxontag( utility::getfx( "fork_ee_hint" ), wallbuy_scriptable.e_hint_fx_tag, "tag_origin" );
            wallbuy_scriptable.e_hint_fx_tag thread utility::function_fb5b19421bb35e50( level, "on_round_end" );
            wallbuy_scriptable.e_hint_fx_tag thread utility::function_fb5b19421bb35e50( level.scarab_fork_ee, "fork_insert" );
        }
    }
}

// Namespace zm_sat_scarab_quest_fork_ee
// Params 2
// Checksum 0x6d7d6907, Offset: 0x149a
// Size: 0x236
function function_7186c21e50783260( eattacker, einflictor )
{
    if ( ( level.scarab_fork_ee.var_b42fbbba0f91c4d ?? 0 ) > 3 )
    {
        return;
    }
    
    if ( level utility::flag( "is_gwy_t_o" ) )
    {
        return;
    }
    
    if ( !level utility::flag( "its_raining" ) )
    {
        return;
    }
    
    if ( !isplayer( eattacker ) )
    {
        return;
    }
    
    if ( einflictor.weapon_name == "t10_inc_fire_zm_scarab_torch" || einflictor.fireball || einflictor.weapon_name == "t10_inc_fire_zm_scarab_torch_cosmic" )
    {
        fireball = einflictor.fireball ?? einflictor;
    }
    
    if ( !isdefined( fireball ) )
    {
        return;
    }
    
    wallbuy_scriptable = function_47c86977a18df38b( level.scarab_fork_ee.var_4319044cd39cfdf1, self.origin, 256 );
    
    if ( !wallbuy_scriptable || !wallbuy_scriptable getscriptablehaspart( "wallbuy" ) )
    {
        return;
    }
    
    if ( !wallbuy_scriptable.var_5499b4433cb4a919 )
    {
        return;
    }
    
    if ( !fireball.equipinfo.var_997d4b6005a845d1 )
    {
        return;
    }
    
    if ( wallbuy_scriptable utility::ent_flag( "is_gwy_t_o" ) )
    {
        return;
    }
    
    var_25630a15f3dd2724 = 0;
    
    foreach ( player in level.players )
    {
        if ( !zm_player::function_f37cfdf04b932a03( player ) )
        {
            continue;
        }
        
        corruptedweapon = function_bab2e52d54846f71( player );
        
        if ( !corruptedweapon )
        {
            continue;
        }
        
        var_25630a15f3dd2724 = 1;
        break;
    }
    
    if ( var_25630a15f3dd2724 )
    {
        return;
    }
    
    level.scarab_fork_ee utility::ent_flag_set( "co_up_on_wb" );
    eattacker notify( #"equip_finished_with_deploy_weapon" );
    level.scarab_fork_ee.var_b42fbbba0f91c4d++;
    wallbuy_scriptable thread function_72143c168f4eb66c( int( self.script_noteworthy ) );
}

// Namespace zm_sat_scarab_quest_fork_ee
// Params 1, eflags: 0x4
// Checksum 0xa0df80a3, Offset: 0x16d8
// Size: 0x34c
function private function_72143c168f4eb66c( var_9b314d09f38d373b )
{
    utility::ent_flag_set( "is_gwy_t_o" );
    level utility::flag_set( "is_gwy_t_o" );
    
    if ( self.var_5499b4433cb4a919 )
    {
        self.var_5499b4433cb4a919 hide();
    }
    
    if ( self.e_hint_fx_tag )
    {
        self.e_hint_fx_tag delete();
    }
    
    foreach ( player in level.players )
    {
        self function_d6a7b7ef13a57f38( player );
    }
    
    self function_7653c765b6c7b815();
    tear_scriptable = spawnscriptable( "scriptable_fork_ee_dark_tear", self.origin + ( -1, -1, -64 ), self.angles + ( 0, 90, 0 ) );
    tear_scriptable.var_9b314d09f38d373b = var_9b314d09f38d373b;
    wait 3;
    zombie = tear_scriptable function_55fda024e4767c62( self );
    
    if ( isdefined( zombie ) )
    {
        e_fx_tag = zombie.e_fx_tag;
        msg = zombie utility::waittill_any_timeout( 90, "death" );
        
        if ( msg == "death" )
        {
            thread function_c0942aadf9e665c4( tear_scriptable );
            e_fx_tag.origin = zombie.origin + ( 0, 0, 48 );
            waitframe();
            playfxontag( utility::getfx( "fork_ee_hvt_end" ), e_fx_tag, "tag_origin" );
            e_fx_tag moveto( self.origin, 1 );
            wait 2;
            e_fx_tag.origin -= ( 0, 0, 64 );
            waitframe();
            playfxontag( utility::getfx( "fork_ee_hvt_start" ), e_fx_tag, "tag_origin" );
            wait 1;
            stopfxontag( utility::getfx( "fork_ee_hvt_start" ), e_fx_tag, "tag_origin" );
            function_859c1bc22820dfca( tear_scriptable );
            tear_scriptable utility::ent_flag_wait_or_timeout( "is_cw_t_from_gwy_t", 15 );
            e_fx_tag delete();
        }
    }
    
    if ( tear_scriptable )
    {
        tear_scriptable utility::function_7c10ea82c1e305b8( "tear", "implode" );
        
        if ( tear_scriptable.var_2a527f9b81fa7569 )
        {
            tear_scriptable.var_2a527f9b81fa7569 freescriptable();
        }
    }
    
    if ( self.var_5499b4433cb4a919 )
    {
        self.var_5499b4433cb4a919 show();
    }
    
    foreach ( player in level.players )
    {
        self function_6113853a877d5460( player );
    }
    
    self function_e203bba36cfb19d0();
    wait 2;
    tear_scriptable freescriptable();
    utility::ent_flag_clear( "is_gwy_t_o" );
    level utility::flag_clear( "is_gwy_t_o" );
    level callback::remove( #"player_used_item", &function_32b11eb7f8d8ff88, tear_scriptable );
}

// Namespace zm_sat_scarab_quest_fork_ee
// Params 1, eflags: 0x4
// Checksum 0xe3942919, Offset: 0x1a2c
// Size: 0x2fb
function private function_55fda024e4767c62( wallbuy_scriptable )
{
    level endon( #"game_ended" );
    groundpos = getgroundposition( self.origin, 8 );
    var_eecb0ede8440097e = getclosestpointonnavmesh( groundpos );
    e_fx_tag = utility::spawn_model( "tag_origin", wallbuy_scriptable.origin, wallbuy_scriptable.angles );
    playfxontag( utility::getfx( "fork_ee_hvt_end" ), e_fx_tag, "tag_origin" );
    e_fx_tag moveto( var_eecb0ede8440097e + ( 0, 0, 48 ), 1 );
    wait 1;
    stopfxontag( utility::getfx( "fork_ee_hvt_end" ), e_fx_tag, "tag_origin" );
    e_fx_tag.origin = var_eecb0ede8440097e;
    waitframe();
    playfxontag( utility::getfx( "fork_ee_hvt_start" ), e_fx_tag, "tag_origin" );
    wait 1;
    stopfxontag( utility::getfx( "fork_ee_hvt_start" ), e_fx_tag, "tag_origin" );
    zombie = agent_manager::spawn_agent( "zombie_loom_hvt", var_eecb0ede8440097e, ( 0, 0, 0 ), "team_two_hundred" );
    
    if ( isdefined( zombie ) )
    {
        zombie.var_8986d0eef2b93060 = zombie.kiastring;
        zombie.kiastring = #"zombie_kia_mission_kill";
        zombie utility::function_7c10ea82c1e305b8( "base", "base_purple_eyes" );
        zombie zombie_utils::function_a8ce00e0448cb6f0( level.gametypebundle.var_25934546ad2751f3 && level.gametypebundle.var_ed84de94958fe6c0 && ( "run" == "super_sprint" || "run" == "sprint" ) ? "run" : level.gametypebundle.var_25934546ad2751f3 && "run" == "super_sprint" ? "sprint" : level.gametypebundle.var_ed84de94958fe6c0 && "run" == "sprint" ? "run" : "run", "fork_ee", 6 );
        zombie_round_difficulty = max( zm_round_logic::get_rb_round_number(), 10 );
        zombie zombie_utils::set_zombie_round_difficulty( zombie_round_difficulty + 2 );
        zombie val::set( "fork_ee", "ignore_cleanup", 1 );
        zombie.b_cleanup_no_respawn = 1;
        zombie.no_powerups = 1;
        zombie.var_15598d8e493afe88 = 1;
        zombie.timespawned = gettime();
        zombie.var_7ee152b43c7188e1 = 1;
        zombie.disable_brain_rot = 1;
        zombie.ignore_enemy_count = 1;
        zombie.var_a13bed1ac47e1b2c = 1;
        zombie.var_e7095781f14d8c2d = 1;
        zombie.e_fx_tag = e_fx_tag;
    }
    else
    {
        e_fx_tag delete();
    }
    
    return zombie;
}

// Namespace zm_sat_scarab_quest_fork_ee
// Params 1, eflags: 0x4
// Checksum 0x9af86bc7, Offset: 0x1d30
// Size: 0x126
function private function_c0942aadf9e665c4( tear_scriptable )
{
    target_angle = ( angleclamp180( 360 - self.angles[ 0 ] ), angleclamp180( self.angles[ 1 ] - 180 ), angleclamp180( 360 - self.angles[ 2 ] ) );
    var_6c6f89721539621b = self.origin + ( 0, 0, -124 );
    item_bundle = getscriptbundle( [ %"hash_5cbebf1bee04d1f3", %"hash_faffbe41573e52" ][ tear_scriptable.var_9b314d09f38d373b ] );
    spawnoptions = common_item::function_bc5ff2958b71a708( var_6c6f89721539621b, target_angle );
    spawnoptions.var_fd47e835523b473f = 1;
    spawnoptions.dropradiusscale = 0;
    spawnoptions.critical = 1;
    tear_scriptable.var_2a527f9b81fa7569 = item_weapon::function_b960bc85ea91de14( item_bundle, spawnoptions );
    
    if ( !isdefined( tear_scriptable.var_2a527f9b81fa7569 ) )
    {
        return;
    }
    
    tear_scriptable.var_2a527f9b81fa7569 function_7653c765b6c7b815();
    return tear_scriptable.var_2a527f9b81fa7569;
}

// Namespace zm_sat_scarab_quest_fork_ee
// Params 1, eflags: 0x4
// Checksum 0xe65263bf, Offset: 0x1e5f
// Size: 0x19f
function private function_859c1bc22820dfca( tear_scriptable )
{
    var_2a527f9b81fa7569 = tear_scriptable.var_2a527f9b81fa7569;
    
    if ( !isdefined( var_2a527f9b81fa7569 ) )
    {
        return;
    }
    
    var_2a527f9b81fa7569.e_mover = utility::spawn_model( "tag_origin", var_2a527f9b81fa7569.origin, var_2a527f9b81fa7569.angles );
    var_2a527f9b81fa7569 scriptablesetparententity( var_2a527f9b81fa7569.e_mover );
    self.var_2a527f9b81fa7569 = var_2a527f9b81fa7569;
    var_2a527f9b81fa7569.e_mover.origin += ( 0, 0, 124 );
    var_5534ee0990246282 = ( 0, -5, 0 );
    var_cd42b2a7832a77a8 = var_2a527f9b81fa7569.e_mover localtoworldcoords( var_5534ee0990246282 );
    targetposworld = var_2a527f9b81fa7569.e_mover localtoworldcoords( ( 0, 8, 0 ) );
    var_2a527f9b81fa7569.e_mover.origin = var_cd42b2a7832a77a8;
    var_2a527f9b81fa7569.e_mover moveto( targetposworld, 1 );
    playsoundatpos( self.origin, "evt_zm_core_wallbuy_purchase" );
    tear_scriptable.var_2a527f9b81fa7569 = var_2a527f9b81fa7569;
    level callback::remove( #"player_used_item", &function_32b11eb7f8d8ff88, tear_scriptable );
    level callback::add( #"player_used_item", &function_32b11eb7f8d8ff88, tear_scriptable );
    wait 2;
    var_2a527f9b81fa7569.e_mover delete();
    var_2a527f9b81fa7569 thread function_aa04f0de7fd161cc();
}

// Namespace zm_sat_scarab_quest_fork_ee
// Params 0, eflags: 0x4
// Checksum 0xba9a3bd5, Offset: 0x2006
// Size: 0xb3
function private function_aa04f0de7fd161cc()
{
    self endon( #"death" );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            corruptedweapon = function_bab2e52d54846f71( player );
            
            if ( corruptedweapon )
            {
                self disablescriptableplayeruse( player );
                continue;
            }
            
            self enablescriptableplayeruse( player );
        }
        
        wait 1;
    }
}

// Namespace zm_sat_scarab_quest_fork_ee
// Params 2, eflags: 0x4
// Checksum 0x6b91eaf5, Offset: 0x20c1
// Size: 0x3e0
function private function_32b11eb7f8d8ff88( sparams, tear_scriptable )
{
    self endon( #"death_or_disconnect", #"scarab_cor_weap_pl_restore" );
    
    if ( !( isdefined( sparams ) && isdefined( sparams.item.weaponobj ) ) )
    {
        return;
    }
    
    if ( self.interactions_disabled )
    {
        return;
    }
    
    if ( !zm_player::function_f37cfdf04b932a03( self ) )
    {
        return;
    }
    
    if ( !arraycontains( [ "sat_dm_tasman_mp", "sat_sh_terrier_mp" ], sparams.itembundle.baseweapon ) )
    {
        return;
    }
    
    if ( tear_scriptable && tear_scriptable.var_2a527f9b81fa7569 != sparams.item )
    {
        return;
    }
    
    tear_scriptable utility::ent_flag_set( "is_cw_t_from_gwy_t" );
    self canceloffhands();
    self releaseoffhand();
    killstreakdeploy::streakdeploy_cancelalldeployments();
    self notify( #"equip_deploy_cancel" );
    self switchtoweaponimmediate( sparams.item.weaponobj );
    
    if ( !self.var_6e0ef4595783b19b )
    {
        self.var_6e0ef4595783b19b = 1;
        level thread player_banter::play_banter_vo( #"hash_51441f287470dfc9", [ self ] );
    }
    
    level.var_db52bcfd04d45a7a[ 0 ].var_370acb837a3a86c3.interact.var_30d174d0f64b3709 = &function_5c2046ec0beb4d1c;
    self.var_64959b130d778640 = [ sparams.item.weaponobj ];
    self notify( #"equip_finished_with_deploy_weapon" );
    val::set_array( "is_cw_t_from_gwy_t", [ "weapon_pickup", "weapon_switch", "allow_scripted_bgb_use", "supers", "killstreaks" ], 0 );
    val::set_array( "is_cw_t_from_gwy_t", [ "disallow_weapon_wallbuy", "disallow_magicbox" ], 1 );
    self.var_bf04dca5dc0d2edc = 1;
    
    if ( !isdefined( self.var_b8f7685b92948edf ) )
    {
        self.var_b8f7685b92948edf = [];
    }
    
    self.var_b8f7685b92948edf[ self.var_b8f7685b92948edf.size ] = &function_72a8e3b2588248bb;
    utility::thread_on_notify( "death", &function_72a8e3b2588248bb, self, self, [ "scarab_cor_weap_pl_restore" ], undefined, 1 );
    utility::thread_on_notify( "last_stand_enter", &function_72a8e3b2588248bb, self, self, [ "death_or_disconnect", "scarab_cor_weap_pl_restore" ], undefined, 1 );
    utility::thread_on_notify( "weapon_switch_started", &function_72a8e3b2588248bb, self, self, [ "death_or_disconnect", "scarab_cor_weap_pl_restore" ] );
    thread function_50fb1117c3eb8839();
    utility::function_7c10ea82c1e305b8( "corrupted_fx", "unstable_on" );
    self.var_3c6c5d22d924de00 = 1;
    thread function_28d1daba18cef62a( sparams.item.weaponobj );
    player = undefined;
    
    while ( player != self )
    {
        level waittill( #"hash_b2701c15341273e2", player, var_579b0337ef215f84, var_101633ed971732ba );
    }
    
    if ( !level callback::exists( #"player_used_item", &function_54dbafbce87cb13c ) )
    {
        level callback::add( #"player_used_item", &function_54dbafbce87cb13c );
    }
    
    level.scarab_fork_ee utility::ent_flag_set( "fork_insert" );
    level.scarab_fork_ee notify( #"fork_insert" );
    level.var_db52bcfd04d45a7a[ 0 ].var_370acb837a3a86c3.interact.var_30d174d0f64b3709 = undefined;
    self.var_64959b130d778640 = undefined;
    
    if ( !self.var_99750288e275d312 )
    {
        self.var_99750288e275d312 = 1;
        level thread player_banter::play_banter_vo( #"hash_de509228c5070931", [ self ] );
    }
    
    utility::delaycallendon( 1, "corrupted_weapon_dropped", &forceweaponinspect );
    function_72a8e3b2588248bb( undefined, undefined, 1 );
}

// Namespace zm_sat_scarab_quest_fork_ee
// Params 1, eflags: 0x4
// Checksum 0x388db877, Offset: 0x24a9
// Size: 0x2f
function private function_28d1daba18cef62a( var_314dc2f0270b7f13 )
{
    wait 3;
    w_current = self getcurrentweapon();
    
    if ( w_current != var_314dc2f0270b7f13 )
    {
        thread function_72a8e3b2588248bb();
        return;
    }
}

// Namespace zm_sat_scarab_quest_fork_ee
// Params 1, eflags: 0x4
// Checksum 0xc1c8b7d6, Offset: 0x24e0
// Size: 0xa5
function private function_54dbafbce87cb13c( sparams )
{
    self endon( #"death_or_disconnect", #"scarab_cor_weap_pl_restore" );
    
    if ( !( isdefined( sparams ) && isdefined( sparams.item.weaponobj ) ) )
    {
        return;
    }
    
    if ( self.interactions_disabled )
    {
        return;
    }
    
    if ( !zm_player::function_f37cfdf04b932a03( self ) )
    {
        return;
    }
    
    if ( !function_990f0605ed12ecf6( sparams.item.weaponobj ) )
    {
        return;
    }
    
    if ( function_d7c5362769797706( sparams.item.weaponobj ) )
    {
        return;
    }
    
    function_72a8e3b2588248bb( undefined, undefined, 1 );
}

// Namespace zm_sat_scarab_quest_fork_ee
// Params 1, eflags: 0x4
// Checksum 0x7b5caeca, Offset: 0x258d
// Size: 0x97
function private function_bab2e52d54846f71( player )
{
    var_3df86f0b126863ab = player getweaponslistall();
    
    foreach ( weapon in var_3df86f0b126863ab )
    {
        if ( !function_990f0605ed12ecf6( weapon ) )
        {
            continue;
        }
        
        return weapon;
    }
}

// Namespace zm_sat_scarab_quest_fork_ee
// Params 1
// Checksum 0xdd27157c, Offset: 0x262d
// Size: 0xc8, Type: bool
function function_990f0605ed12ecf6( weaponobj )
{
    if ( !arraycontains( [ "sat_dm_tasman_mp", "sat_sh_terrier_mp" ], weaponobj.basename ) )
    {
        return false;
    }
    
    var_8ba0caf06a755539 = function_f02c63b99c9614c9( [ "sat_dm_tasman_mp", "sat_sh_terrier_mp" ], weaponobj.basename );
    
    if ( !weaponobj hasattachment( [ "sat_zm_dm_corrupted_tasman", "sat_zm_sh_corrupted_terrier" ][ var_8ba0caf06a755539 ] ) && !weaponobj hasattachment( [ "sat_zm_dm_corrupted_tasman_pack", "sat_zm_sh_corrupted_terrier_pack" ][ var_8ba0caf06a755539 ] ) && !weaponobj hasattachment( [ "sat_zm_dm_corrupted_tasman_pack4", "sat_zm_sh_corrupted_terrier_pack4" ][ var_8ba0caf06a755539 ] ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_scarab_quest_fork_ee
// Params 1
// Checksum 0x2bd20603, Offset: 0x26fe
// Size: 0xc7, Type: bool
function function_d7c5362769797706( weaponobj )
{
    if ( !arraycontains( [ "sat_dm_tasman_mp", "sat_sh_terrier_mp" ], weaponobj.basename ) )
    {
        return false;
    }
    
    var_8ba0caf06a755539 = function_f02c63b99c9614c9( [ "sat_dm_tasman_mp", "sat_sh_terrier_mp" ], weaponobj.basename );
    
    if ( !weaponobj hasattachment( [ "sat_zm_dm_corrupted_tasman", "sat_zm_sh_corrupted_terrier" ][ var_8ba0caf06a755539 ] ) )
    {
        return false;
    }
    
    if ( weaponobj hasattachment( [ "sat_zm_dm_corrupted_tasman_pack", "sat_zm_sh_corrupted_terrier_pack" ][ var_8ba0caf06a755539 ] ) || weaponobj hasattachment( [ "sat_zm_dm_corrupted_tasman_pack4", "sat_zm_sh_corrupted_terrier_pack4" ][ var_8ba0caf06a755539 ] ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_scarab_quest_fork_ee
// Params 4, eflags: 0x4
// Checksum 0xc7ff4c87, Offset: 0x27ce
// Size: 0x115
function private function_5c2046ec0beb4d1c( usable, player, hintstring_obj, cost )
{
    w_current = player getcurrentweapon();
    var_951c89546ec50477 = player pack_a_punch::get_pap_level( w_current );
    var_8ba0caf06a755539 = function_f02c63b99c9614c9( [ "sat_dm_tasman_mp", "sat_sh_terrier_mp" ], w_current.basename );
    
    if ( arraycontains( [ "sat_dm_tasman_mp", "sat_sh_terrier_mp" ], w_current.basename ) && w_current hasattachment( [ "sat_zm_dm_corrupted_tasman", "sat_zm_sh_corrupted_terrier" ][ var_8ba0caf06a755539 ] ) && var_951c89546ec50477 == 0 )
    {
        hintstring_obj.var_2947462488e8ec80 = 1;
        hintstring_obj.var_776a268784e089af = undefined;
        hintstring_obj.icon_text_value = undefined;
        hintstring_obj.description = &"hash_67936d27aab30afe";
        hintstring_obj.buttoncallout = &"hash_424a3418db6c03b";
    }
    
    return hintstring_obj;
}

// Namespace zm_sat_scarab_quest_fork_ee
// Params 0, eflags: 0x4
// Checksum 0xc27e17e2, Offset: 0x28ec
// Size: 0x75
function private function_50fb1117c3eb8839()
{
    self endon( #"death_or_disconnect", #"scarab_cor_weap_pl_restore", #"last_stand_enter" );
    damagepertick = self.maxhealth * 5 * 0.01;
    tickinterval = 1;
    
    while ( true )
    {
        self dodamage( damagepertick, self.origin, self, undefined, "MOD_UNKNOWN", undefined, undefined, undefined, 536936448 );
        wait tickinterval;
    }
}

// Namespace zm_sat_scarab_quest_fork_ee
// Params 3
// Checksum 0xcaa72f24, Offset: 0x2969
// Size: 0x267
function function_72a8e3b2588248bb( check_volume, fromlaststand, var_8524a28c6d549805 )
{
    self endon( #"disconnect" );
    
    if ( self.var_b8f7685b92948edf )
    {
        self.var_b8f7685b92948edf = arrayremove( self.var_b8f7685b92948edf, &function_72a8e3b2588248bb );
    }
    
    val::reset_all( "is_cw_t_from_gwy_t" );
    self.var_bf04dca5dc0d2edc = 0;
    self.var_3c6c5d22d924de00 = 0;
    
    if ( !var_8524a28c6d549805 && isalive( self ) )
    {
        corruptedweapon = function_bab2e52d54846f71( self );
        
        if ( corruptedweapon )
        {
            weaponinfo = item_weapon::items_weapon_removeweapon( { #var_5156a93210ad2807:1, #dontdrop:1, #weapon:corruptedweapon } );
            
            if ( issameweapon( corruptedweapon, self.var_3bf72dcd2775aa78 ) )
            {
                self.var_3bf72dcd2775aa78 = undefined;
                self.var_1dbdf5cd10dc5432 = undefined;
            }
        }
        
        currentweapon = self getcurrentweapon();
        
        if ( currentweapon.basename == "none" )
        {
            inventory_utility::forcevalidweapon();
        }
        
        if ( fromlaststand )
        {
            self.var_fba35c30b168d4c = 1;
            self.laststandoldweaponobj = self getcurrentweapon();
            self.healing_aura_secondary_weapon = undefined;
            
            foreach ( weapon in self getweaponslistprimaries() )
            {
                if ( isweapon( weapon ) && !weapon.ismelee )
                {
                    self.healing_aura_secondary_weapon = weapon;
                    self.var_8e2afd0861231a4f = pack_a_punch::get_pap_level( weapon ) ?? 0;
                    self.healing_aura_secondary_weapon_rarity = item_weapon::function_fb81bd2fe070faa6( weapon ) ?? 0;
                    break;
                }
            }
        }
        
        level.var_db52bcfd04d45a7a[ 0 ].var_370acb837a3a86c3.interact.var_30d174d0f64b3709 = undefined;
        self.var_64959b130d778640 = undefined;
    }
    else if ( isalive( self ) )
    {
        function_e222e0cf2540f313();
    }
    
    if ( isalive( self ) )
    {
        utility::function_7c10ea82c1e305b8( "corrupted_fx", "unstable_off" );
    }
    
    self notify( #"scarab_cor_weap_pl_restore" );
}

// Namespace zm_sat_scarab_quest_fork_ee
// Params 0, eflags: 0x4
// Checksum 0xe56f66e2, Offset: 0x2bd8
// Size: 0x5c
function private function_e222e0cf2540f313()
{
    if ( !callback::exists( #"hash_474490f7ce8b74d0", &function_8474fa222fdbf169 ) )
    {
        callback::add( #"hash_474490f7ce8b74d0", &function_8474fa222fdbf169 );
    }
    
    if ( !callback::exists( #"player_item_drop", &function_ee92a724c61ab89c ) )
    {
        callback::add( #"player_item_drop", &function_ee92a724c61ab89c );
    }
}

// Namespace zm_sat_scarab_quest_fork_ee
// Params 1, eflags: 0x4
// Checksum 0x114adacf, Offset: 0x2c3c
// Size: 0xcc
function private function_ee92a724c61ab89c( sparams )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    waitframe();
    
    if ( !( isdefined( sparams ) && isdefined( sparams.item.weaponobj ) ) )
    {
        return;
    }
    
    if ( !function_990f0605ed12ecf6( sparams.item.weaponobj ) )
    {
        return;
    }
    
    sparams.item thread function_aa04f0de7fd161cc();
    sparams.item.weaponobj notify( #"corrupted_weapon_dropped" );
    self.var_e4873fd259ae5ed4 = 0;
    callback::remove( #"hash_474490f7ce8b74d0", &function_8474fa222fdbf169 );
    callback::remove( #"player_item_drop", &function_ee92a724c61ab89c );
}

// Namespace zm_sat_scarab_quest_fork_ee
// Params 0, eflags: 0x4
// Checksum 0x6f0dc93d, Offset: 0x2d10
// Size: 0xa7
function private function_c17c9b1d061563d1()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    w_current = self getcurrentweapon();
    corruptedweapon = function_bab2e52d54846f71( self );
    
    if ( !isdefined( corruptedweapon ) )
    {
        return;
    }
    
    corruptedweapon endon( #"corrupted_weapon_dropped" );
    
    if ( w_current == corruptedweapon )
    {
        self givemaxammo( corruptedweapon );
    }
    
    while ( corruptedweapon )
    {
        self waittill( #"weapon_change", new_weapon );
        corruptedweapon = function_bab2e52d54846f71( self );
        
        if ( new_weapon != corruptedweapon )
        {
            self notify( #"hash_d9a98a355733692f" );
            continue;
        }
        
        thread function_fa19762924cba50f( corruptedweapon );
    }
}

// Namespace zm_sat_scarab_quest_fork_ee
// Params 1, eflags: 0x4
// Checksum 0xb26963e9, Offset: 0x2dbf
// Size: 0x97
function private function_fa19762924cba50f( corruptedweapon )
{
    self endon( #"death_or_disconnect", #"hash_d9a98a355733692f" );
    corruptedweapon endon( #"corrupted_weapon_dropped" );
    
    while ( true )
    {
        self waittill( #"reload_ammo_added" );
        n_stock_max = utility::get_max_stock_ammo( corruptedweapon );
        n_stock_current = self getweaponammostock( corruptedweapon );
        
        if ( n_stock_current >= n_stock_max )
        {
            continue;
        }
        
        var_15d5097abd846ed4 = n_stock_max - n_stock_current;
        stockammo = var_15d5097abd846ed4 + n_stock_current;
        self setweaponammostock( corruptedweapon, stockammo );
    }
}

// Namespace zm_sat_scarab_quest_fork_ee
// Params 1, eflags: 0x4
// Checksum 0xbc65f981, Offset: 0x2e5e
// Size: 0x295
function private function_8474fa222fdbf169( sparams )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    objweaponfired = sparams.objweapon;
    
    if ( self.var_e4873fd259ae5ed4 )
    {
        return;
    }
    
    if ( !function_990f0605ed12ecf6( objweaponfired ) )
    {
        corruptedweapon = function_bab2e52d54846f71( self );
        
        if ( !corruptedweapon )
        {
            callback::remove( #"hash_474490f7ce8b74d0", &function_8474fa222fdbf169 );
        }
        
        return;
    }
    
    objweaponfired endon( #"corrupted_weapon_dropped" );
    self.var_e4873fd259ae5ed4 = 1;
    
    if ( !isdefined( self.var_aa4741d9de5a3a66 ) )
    {
        self.var_aa4741d9de5a3a66 = 0;
    }
    
    if ( !isdefined( self.var_7b434fb27fec5383 ) )
    {
        self.var_7b434fb27fec5383 = 0;
    }
    
    if ( [ "sat_dm_tasman_mp", "sat_sh_terrier_mp" ][ 0 ] == objweaponfired.basename )
    {
        wait 0.5;
    }
    else
    {
        wait 0.2;
    }
    
    self.var_e4873fd259ae5ed4 = 0;
    var_f485a2c9a458e19a = self.pers[ "weap_shotFired" ][ objweaponfired.basename ] ?? 0;
    shothit = self.pers[ "weap_shotHit" ][ objweaponfired.basename ] ?? 0;
    var_701b291133f6c8ea = shothit - self.var_7b434fb27fec5383;
    var_154533317b385267 = var_f485a2c9a458e19a - self.var_aa4741d9de5a3a66;
    wasshothit = var_701b291133f6c8ea > 0;
    wasshotfired = var_154533317b385267 > 0;
    self.var_aa4741d9de5a3a66 = var_f485a2c9a458e19a;
    self.var_7b434fb27fec5383 = shothit;
    var_7eb0ecb5814c8b85 = var_701b291133f6c8ea / max( var_154533317b385267, 1 ) * 100;
    
    if ( wasshotfired && ( wasshothit || var_7eb0ecb5814c8b85 >= 80 ) )
    {
        return;
    }
    
    damage = self.maxhealth * 10 * 0.01;
    var_e65f2c92d267a8d3 = self.health - damage;
    
    if ( var_e65f2c92d267a8d3 <= 0 )
    {
        damage = self.health - 1;
    }
    
    self dodamage( damage, self.origin, self, self, "MOD_UNKNOWN", "<explicitweaponnone>", "none", undefined, 536936448 );
    self.var_e4873fd259ae5ed4 = 0;
    utility::function_32b24db3127bff40( "corrupted_fx", "on" );
    self notify( #"playing_corrupted_fx" );
    utility::delaythreadendon( 0.75, "playing_corrupted_fx", &utility::function_32b24db3127bff40, "corrupted_fx", "off" );
}

/#

    // Namespace zm_sat_scarab_quest_fork_ee
    // Params 0
    // Checksum 0xf9e4be9f, Offset: 0x30fb
    // Size: 0x48, Type: dev
    function setup_fork_ee_devgui()
    {
        zm_quest::function_bc99f123a684344f( #"hash_653e5e819076b55a" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x24>", "<dev string:x41>", &function_59bb0530c0d91f80 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x5a>", "<dev string:x7b>", &function_59bb0530c0d91f80 );
        zm_quest::function_394bdba74beda0aa();
    }

#/
