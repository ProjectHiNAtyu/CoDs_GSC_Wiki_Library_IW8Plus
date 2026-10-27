// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_sq_twins.gsc  (hash_7d8e7eda693b4b2c.gscc) (size: 6072 Bytes / 0x17b8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbc0f5258 (3155120728)
// size ...... 6072 (0x17b8)
// includes .. 11  (offset: 0x15c8)
// strings ... 28  (offset: 0x1620)
// dev strs .. 0   (offset: 0x17b8)
// exports ... 16  (offset: 0xd3c)
// cseg ...... 0x2fb + 0xa41 (0xd3c)
// imports ... 51  (offset: 0xfbc)
// animtree1 . 0   (offset: 0x17b8)
// animtree2 . 0   (offset: 0x17b8)
#using scripts\common\callbacks;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\loot\common_item;
#using scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_sq_twins_cs;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_reward_bundle;
#using scripts\mp\zm\systems\zm_round_spawning;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_ruby_sq_twins;

// Namespace zm_sat_ruby_sq_twins
// Params 0, eflags: 0x5
// Checksum 0x19ba3856, Offset: 0x319
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"hash_dc50ed9d1317a8fa", #"zm_quest", &function_df6cd058a20c334b, &function_6ad42473e01dcf28 );
}

// Namespace zm_sat_ruby_sq_twins
// Params 0, eflags: 0x4
// Checksum 0x939efa3e, Offset: 0x346
// Size: 0x10f
function private function_df6cd058a20c334b()
{
    if ( !getdvarint( @"hash_3a9ff30b9c2ea1f1", 0 ) || !getmatchrulesdata( "zmData", "sideContentEnabled" ) )
    {
        return;
    }
    
    level.var_3d074dfa9f1794bb = zm_quest::get_quest( #"hash_dc50ed9d1317a8fa" );
    level._effect[ "ruby_sq_tw_spawn" ] = loadfxasset( "vfx_sat_zm_two_sisters_spawn" );
    level._effect[ "ruby_sq_reward_spawn" ] = loadfxasset( "vfx_t10_levels_zm_opal_ritual_bowl_transition" );
    zm_quest::register_quest_step( #"hash_dc50ed9d1317a8fa", #"hash_5c37e5de259860dd", &function_a7b5ce20ce2f0fd2 );
    zm_quest::register_quest_step( #"hash_dc50ed9d1317a8fa", #"hash_5c37e4de25985f2a", &function_a7b5cf20ce2f1205 );
    zm_quest::register_quest_step( #"hash_dc50ed9d1317a8fa", #"hash_5c37e3de25985d77", &function_a7b5cc20ce2f0b6c );
    zm_quest::register_quest_step( #"hash_dc50ed9d1317a8fa", #"hash_5c37e2de25985bc4", &function_a7b5cd20ce2f0d9f );
    zm_quest::register_quest_step( #"hash_dc50ed9d1317a8fa", #"hide_and_seek", &setup_hide_and_seek );
    zm_sat_ruby_sq_twins_cs::main();
}

// Namespace zm_sat_ruby_sq_twins
// Params 0, eflags: 0x4
// Checksum 0xf7da34de, Offset: 0x45d
// Size: 0x52
function private function_6ad42473e01dcf28()
{
    level callback::add( "museum_exhibit_interact", &function_9ddef256632b3f6c );
    
    if ( !getdvarint( @"hash_3a9ff30b9c2ea1f1", 0 ) || !getmatchrulesdata( "zmData", "sideContentEnabled" ) )
    {
        return;
    }
    
    zm_save::function_1f44a48caae2acbf();
    level thread zm_quest::start_quest( #"hash_dc50ed9d1317a8fa" );
}

// Namespace zm_sat_ruby_sq_twins
// Params 1, eflags: 0x4
// Checksum 0x1b91f809, Offset: 0x4b7
// Size: 0xb6
function private function_9ddef256632b3f6c( params )
{
    if ( params.exhibit_name != "vo_twins" )
    {
        return;
    }
    
    if ( !getdvarint( @"hash_3a9ff30b9c2ea1f1", 0 ) || !getmatchrulesdata( "zmData", "sideContentEnabled" ) || level utility::flag( "ruby_ee_tw_start" ) || !zm_round_spawning::is_special_round( zm_utility::get_round_number() ) )
    {
        playsoundatpos( params.interact.origin, "amb_ee_ts_radio_static" );
        return;
    }
    
    playsoundatpos( params.interact.origin, "amb_ee_ts_sister_dissolve" );
    wait 5;
    level utility::flag_set( "ruby_ee_tw_start" );
}

// Namespace zm_sat_ruby_sq_twins
// Params 1, eflags: 0x4
// Checksum 0x1f80a652, Offset: 0x575
// Size: 0x4a
function private function_33362e20417d3a18( params )
{
    if ( !params.interact.var_6769eb6aa44f1537 )
    {
        return;
    }
    
    level notify( #"hash_54d05a1409bb7f91" );
    wait 8;
    params.interact.var_6769eb6aa44f1537 = undefined;
}

// Namespace zm_sat_ruby_sq_twins
// Params 0, eflags: 0x4
// Checksum 0xe03fcd75, Offset: 0x5c7
// Size: 0xeb
function private setup_next_speaker()
{
    if ( !isdefined( level.var_3d074dfa9f1794bb.a_used_speakers ) )
    {
        level.var_3d074dfa9f1794bb.a_used_speakers = [];
    }
    
    var_32a3107e997acd94 = utility::getstructarray( "ruby_museum_interact" );
    
    do
    {
        s_speaker = utility::array_random( var_32a3107e997acd94 );
    }
    while ( s_speaker.script_noteworthy == "vo_twins" || s_speaker.script_noteworthy == "ruby_museum_rocket" || arraycontains( level.var_3d074dfa9f1794bb.a_used_speakers, s_speaker ) );
    
    s_speaker.interact.var_6769eb6aa44f1537 = 1;
    level.var_3d074dfa9f1794bb.a_used_speakers[ level.var_3d074dfa9f1794bb.a_used_speakers.size ] = s_speaker;
    level thread function_12996950fae749c2( s_speaker );
    return s_speaker;
}

// Namespace zm_sat_ruby_sq_twins
// Params 1, eflags: 0x4
// Checksum 0x56b93f0f, Offset: 0x6bb
// Size: 0x3e
function private function_12996950fae749c2( s_speaker )
{
    level endon( #"hash_54d05a1409bb7f91" );
    
    while ( true )
    {
        wait randomintrange( 10, 20 );
        playsoundatpos( s_speaker.origin, "amb_ee_ts_sister_static" );
    }
}

// Namespace zm_sat_ruby_sq_twins
// Params 2, eflags: 0x4
// Checksum 0x8cbc96e3, Offset: 0x701
// Size: 0x22
function private function_a7b5ce20ce2f0fd2( b_skipped, b_save_restored )
{
    level utility::flag_wait( "ruby_ee_tw_start" );
}

// Namespace zm_sat_ruby_sq_twins
// Params 2, eflags: 0x4
// Checksum 0xad8fc84d, Offset: 0x72b
// Size: 0x6b
function private function_a7b5cf20ce2f1205( b_skipped, b_save_restored )
{
    level waittill( #"on_round_end" );
    s_speaker = setup_next_speaker();
    level callback::add( "museum_exhibit_interact", &function_33362e20417d3a18 );
    level waittill( #"hash_54d05a1409bb7f91" );
    playsoundatpos( s_speaker.origin, "amb_ee_ts_sister_dissolve" );
    wait 5;
}

// Namespace zm_sat_ruby_sq_twins
// Params 2, eflags: 0x4
// Checksum 0xf109981b, Offset: 0x79e
// Size: 0x59
function private function_a7b5cc20ce2f0b6c( b_skipped, b_save_restored )
{
    level waittill( #"on_round_end" );
    s_speaker = setup_next_speaker();
    level waittill( #"hash_54d05a1409bb7f91" );
    playsoundatpos( s_speaker.origin, "amb_ee_ts_sister_dissolve" );
    wait 5;
}

// Namespace zm_sat_ruby_sq_twins
// Params 2, eflags: 0x4
// Checksum 0x860ea88d, Offset: 0x7ff
// Size: 0x59
function private function_a7b5cd20ce2f0d9f( b_skipped, b_save_restored )
{
    level waittill( #"on_round_end" );
    s_speaker = setup_next_speaker();
    level waittill( #"hash_54d05a1409bb7f91" );
    playsoundatpos( s_speaker.origin, "amb_ee_ts_sister_dissolve" );
    wait 5;
}

// Namespace zm_sat_ruby_sq_twins
// Params 2, eflags: 0x4
// Checksum 0x8b46b05f, Offset: 0x860
// Size: 0x2a
function private setup_hide_and_seek( b_skipped, b_save_restored )
{
    level thread function_a3096f29d8e54667();
    level utility::flag_wait( "ruby_sq_tw_complete" );
}

// Namespace zm_sat_ruby_sq_twins
// Params 0, eflags: 0x4
// Checksum 0x5a3e0efc, Offset: 0x892
// Size: 0x19b
function private function_a3096f29d8e54667()
{
    var_aeed8c2ff147e9bf = [ "sat_cin_zm_vig_fly_sisters_standing", "sat_cin_zm_vig_fly_sisters_dance", "sat_cin_zm_vig_fly_sisters_chalk_both" ];
    var_1fb0e131c89db725 = utility::getstructarray( "ruby_sq_tw_scenes" );
    
    foreach ( str_scene in var_aeed8c2ff147e9bf )
    {
        scene::add_scene_func( str_scene, &function_bdfe82a43bd1c0f9, "callback_play" );
    }
    
    while ( true )
    {
        s_scene = utility::array_random( var_1fb0e131c89db725 );
        str_scene = utility::array_random( var_aeed8c2ff147e9bf );
        str_shot = undefined;
        
        if ( str_scene == "sat_cin_zm_vig_fly_sisters_standing" )
        {
            str_shot = "idle_holding_hands";
        }
        
        playfx( level._effect[ "ruby_sq_tw_spawn" ], s_scene.origin );
        s_scene.script_scenescriptbundle = str_scene;
        s_scene thread scene::play( undefined, str_shot );
        
        /#
            level thread utility::draw_circle( s_scene.origin, 48, ( 0, 1, 0 ), 1, 0, 999 );
        #/
        
        s_scene waittill( #"hash_c0a3113a12eab159" );
        level utility::flag_set( "ruby_sq_tw_complete" );
        playsoundatpos( s_scene.origin, "amb_ee_ts_sister_dissolve" );
        level waittill( #"on_round_end" );
    }
}

// Namespace zm_sat_ruby_sq_twins
// Params 0, eflags: 0x4
// Checksum 0xc76bc43, Offset: 0xa35
// Size: 0x203
function private function_bdfe82a43bd1c0f9()
{
    a_ents = scene::get_entities();
    
    foreach ( ent in a_ents )
    {
        ent.var_2fc3a5fb762afb6e = 1;
        ent setscriptablepartstate( "reveal", "reveal_in" );
    }
    
    trigger = spawn( "trigger_radius", self.origin, 0, 200, 100 );
    trigger playloopsound( "amb_ee_ts_sister_music_lp" );
    
    while ( trigger )
    {
        trigger waittill( #"trigger", player );
        
        if ( isplayer( player ) )
        {
            break;
        }
    }
    
    trigger stoploopsound( "amb_ee_ts_sister_music_lp" );
    trigger delete();
    self notify( #"hash_c0a3113a12eab159" );
    
    foreach ( ent in a_ents )
    {
        ent setscriptablepartstate( "reveal", "reveal_out" );
    }
    
    wait 3;
    level thread function_4500aa8d71c49672( self.origin );
    scene::stop();
    
    foreach ( ent in a_ents )
    {
        ent delete();
    }
}

// Namespace zm_sat_ruby_sq_twins
// Params 1, eflags: 0x4
// Checksum 0xa083e354, Offset: 0xc40
// Size: 0xfc
function private function_4500aa8d71c49672( v_loc )
{
    playfx( level._effect[ "ruby_sq_reward_spawn" ], v_loc );
    var_8b5270de14dff72e = arrayrandomize( zm_round_reward_bundle::function_8cbad2bff5b7cc1( "zm_round_reward_bundle_ee_rewards", "Default" ) );
    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( v_loc );
    
    for ( i = 0; i < var_8b5270de14dff72e.size ; i++ )
    {
        itemspawnentryname = var_8b5270de14dff72e[ i ];
        spawneditems = common_item::function_61c2c0251e742ffd( itemspawnentryname, undefined, spawnoptions );
    }
    
    if ( !isdefined( level.var_3d074dfa9f1794bb.var_92517bb9342029dc ) )
    {
        level.var_3d074dfa9f1794bb.var_92517bb9342029dc = 0;
    }
    
    if ( level.var_3d074dfa9f1794bb.var_92517bb9342029dc < 2 )
    {
        level.var_3d074dfa9f1794bb.var_92517bb9342029dc++;
        common_item::function_61c2c0251e742ffd( %"hash_71e529b5059c785a", 1, spawnoptions );
    }
}

