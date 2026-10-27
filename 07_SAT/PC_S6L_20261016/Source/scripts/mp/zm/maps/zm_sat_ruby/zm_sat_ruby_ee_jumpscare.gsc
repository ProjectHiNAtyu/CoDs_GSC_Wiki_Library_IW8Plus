// scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_ee_jumpscare.gsc  (hash_04b83724b6ad1f6d.gscc) (size: 2853 Bytes / 0xb25 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe02ae69 (235056745)
// size ...... 2853 (0xb25)
// includes .. 6   (offset: 0xa11)
// strings ... 16  (offset: 0xa41)
// dev strs .. 0   (offset: 0xb25)
// exports ... 8   (offset: 0x59d)
// cseg ...... 0x197 + 0x406 (0x59d)
// imports ... 28  (offset: 0x6dd)
// animtree1 . 0   (offset: 0xb25)
// animtree2 . 0   (offset: 0xb25)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\maps\zm_sat_ruby\zm_sat_ruby_telescope;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;

#namespace zm_sat_ruby_ee_jumpscare;

// Namespace zm_sat_ruby_ee_jumpscare
// Params 0, eflags: 0x5
// Checksum 0xd288724d, Offset: 0x1b5
// Size: 0x25
function private autoexec __init__system__()
{
    system::register( #"hash_83497d29c3f8c7ff", #"zm_quest", &function_c0f1d42a2695c1d4, &function_dbcfc02d389f395 );
}

// Namespace zm_sat_ruby_ee_jumpscare
// Params 0, eflags: 0x4
// Checksum 0x745e94ed, Offset: 0x1e2
// Size: 0x64
function private function_c0f1d42a2695c1d4()
{
    if ( !getdvarint( @"hash_3a9ff30b9c2ea1f1", 0 ) || !getmatchrulesdata( "zmData", "sideContentEnabled" ) )
    {
        return;
    }
    
    level._effect[ "ruby_js_image" ] = loadfxasset( "vfx_sat_levels_zm_ruby_jump_scare_camera" );
    zm_quest::register_quest_step( #"hash_83497d29c3f8c7ff", #"activate_jumpscare", &function_3b75b34199b08e80, &do_jumpscare );
}

// Namespace zm_sat_ruby_ee_jumpscare
// Params 0, eflags: 0x4
// Checksum 0x30f15e91, Offset: 0x24e
// Size: 0x4d
function private function_dbcfc02d389f395()
{
    if ( !getdvarint( @"hash_3a9ff30b9c2ea1f1", 0 ) || !getmatchrulesdata( "zmData", "sideContentEnabled" ) )
    {
        return;
    }
    
    level utility::flag_wait( "zm_init_done" );
    zm_save::function_1f44a48caae2acbf();
    level thread zm_quest::start_quest( #"hash_83497d29c3f8c7ff" );
}

// Namespace zm_sat_ruby_ee_jumpscare
// Params 2, eflags: 0x4
// Checksum 0x73a3187b, Offset: 0x2a3
// Size: 0xe5
function private function_3b75b34199b08e80( b_skipped, b_save_restored )
{
    if ( b_skipped || b_save_restored )
    {
        return;
    }
    
    level utility::flag_wait( "ruby_telescope_setup_complete" );
    var_1be5586316eb3191 = utility::getstruct( "ruby_ee_js" );
    var_e08fb3ecef124223 = utility::spawn_model( %"sat_zm_pipe_organ_regurgirator_skull", var_1be5586316eb3191.origin, var_1be5586316eb3191.angles, undefined, 0.3 );
    zm_sat_ruby_telescope::function_b095db21aed570fe( var_e08fb3ecef124223, 0, var_1be5586316eb3191 );
    level callback::add( "telescope_target_acquired", &check_for_jumpscare, { #var_6fd95b8f4f5f8d63:var_e08fb3ecef124223 } );
    level utility::flag_wait( "ruby_js_play" );
    level.ruby_telescope.var_e08fb3ecef124223 = var_e08fb3ecef124223;
    level callback::remove( "telescope_target_acquired", &check_for_jumpscare, { #var_6fd95b8f4f5f8d63:var_e08fb3ecef124223 } );
}

// Namespace zm_sat_ruby_ee_jumpscare
// Params 2, eflags: 0x4
// Checksum 0xfac981ec, Offset: 0x390
// Size: 0x44
function private check_for_jumpscare( params, info )
{
    if ( params.ent != info.var_6fd95b8f4f5f8d63 )
    {
        return;
    }
    
    level notify( #"hash_d45f00309d87f964" );
    level thread function_8e001968c6c7f832();
}

// Namespace zm_sat_ruby_ee_jumpscare
// Params 0, eflags: 0x4
// Checksum 0xa9f39718, Offset: 0x3dc
// Size: 0x4d
function private function_8e001968c6c7f832()
{
    level endon( #"hash_6c9d582df1401e3d" );
    level endon( #"telescope_finish" );
    level endon( #"ruby_js_play" );
    level waittill( #"hash_d45f00309d87f964" );
    level waittill( #"hash_d45f00309d87f964" );
    level utility::flag_set( "ruby_js_play" );
}

// Namespace zm_sat_ruby_ee_jumpscare
// Params 2, eflags: 0x4
// Checksum 0x1e09958b, Offset: 0x431
// Size: 0x16c
function private do_jumpscare( b_skipped, b_save_restored )
{
    if ( b_save_restored )
    {
        return;
    }
    
    level utility::flag_set( "ruby_js_play" );
    player = level.ruby_telescope.user;
    
    /#
        if ( b_skipped )
        {
            player = level.players[ 0 ];
        }
    #/
    
    if ( isalive( player ) && level.ruby_telescope.mdl_viewpoint )
    {
        level utility::flag_set( "ruby_js_active" );
        player notifyonplayercommandremove( "telescope_exit", "+stance" );
        player notifyonplayercommandremove( "telescope_exit", "+prone" );
        player notifyonplayercommandremove( "telescope_exit", "+movedown" );
        player playsoundtoplayer( "evt_ruby_ee_jump_scare_stinger", player );
        playfxontagforclients( level._effect[ "ruby_js_image" ], level.ruby_telescope.mdl_viewpoint, "tag_player", player );
        wait 1;
        level utility::flag_clear( "ruby_js_active" );
        level.ruby_telescope.telescope_interact thread zm_sat_ruby_telescope::function_72b79a760dd653d6( player );
    }
    
    if ( level.ruby_telescope.var_e08fb3ecef124223 )
    {
        zm_sat_ruby_telescope::function_b28785f5286548e3( level.ruby_telescope.var_e08fb3ecef124223 );
        level.ruby_telescope.var_e08fb3ecef124223 delete();
    }
}

