// scripts\mp\common\killstreaks\reaper_drone.gsc  (hash_071c4df2b9bb357c.gscc) (size: 52863 Bytes / 0xce7f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7c52c688 (2085799560)
// size ...... 52863 (0xce7f)
// includes .. 19  (offset: 0xbb93)
// strings ... 224 (offset: 0xbc2b)
// dev strs .. 20  (offset: 0xcb9f)
// exports ... 112 (offset: 0x82df)
// cseg ...... 0x1467 + 0x6e78 (0x82df)
// imports ... 299 (offset: 0x945f)
// animtree1 . 1   (offset: 0xccb3)
// animtree2 . 28  (offset: 0xccbf)
#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\targetmarkergroups;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_omnvar_utility;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\hostmigration;
#using scripts\mp\sentientpoolmanager;

#namespace reaper_drone;

// Namespace reaper_drone
// Params 0, eflags: 0x1
// Checksum 0xecbbaf97, Offset: 0x1485
// Size: 0x17
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( getxhash( "reaper_drone" ), &init );
}

// Namespace reaper_drone
// Params 0
// Checksum 0xe8b3c327, Offset: 0x14a4
// Size: 0x142
function init()
{
    if ( utility::issharedfuncdefined( #"killstreak", #"registerkillstreak" ) )
    {
        [[ utility::getsharedfunc( #"killstreak", #"registerkillstreak" ) ]]( "reaper_drone", &function_e2d8901aa82cb5f1 );
    }
    
    bundle = level.streakglobals.streakbundles[ "reaper_drone" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    /#
        setdevdvarifuninitialized( @"scr_reaper_drone_timeout", bundle.reaperdrone_lifetime );
        setdevdvarifuninitialized( @"hash_413d547c976e2cbb", 0 );
        setdevdvarifuninitialized( @"hash_da3918131a0e213c", 0 );
        setdevdvarifuninitialized( @"hash_80dbf36211dd4563", 0 );
        setdevdvarifuninitialized( @"scr_reaper_drone_crash_type", 0 );
        setdevdvarifuninitialized( @"hash_f3b9f79a2bbabbe6", 0 );
        setdevdvarifuninitialized( @"scr_debug_reaper_drone", 0 );
        setdevdvarifuninitialized( @"hash_70773afbc2169291", 0 );
        setdevdvarifuninitialized( @"hash_45ff6a164a5b1654", 0 );
    #/
    
    level thread function_9742f1bba28d4743();
    level function_7e1f53fab39eec90();
    level function_4a93194c2a208f0e();
    level function_f9cb89c47283fc75();
    level function_37f79d193d2fbdd6();
    level function_383d90193d7c30af();
    level function_afb947c50d86b5d0();
    thread function_cbe5fd2f297d38b6();
}

// Namespace reaper_drone
// Params 1
// Checksum 0xf8c04943, Offset: 0x15ee
// Size: 0xe, Type: bool
function function_6d4fcc49ae6e409a( streakinfo )
{
    return true;
}

// Namespace reaper_drone
// Params 0
// Checksum 0x361cdd35, Offset: 0x1605
// Size: 0x52
function function_9742f1bba28d4743()
{
    level endon( #"game_ended" );
    utility::flag_wait( "onStartGameTypeFinished" );
    
    if ( isdefined( level.mapcenter ) )
    {
        level.var_360674e8272fbd31 = level.mapcenter;
        return;
    }
    
    level.var_360674e8272fbd31 = ( 0, 0, 0 );
}

// Namespace reaper_drone
// Params 0
// Checksum 0x67674d05, Offset: 0x165f
// Size: 0xc2
function function_7e1f53fab39eec90()
{
    bundle = level.streakglobals.streakbundles[ "reaper_drone" ];
    level.reaperdrone_speed[ "move" ] = 250;
    level.reaperdrone_speed[ "rotate" ] = 120;
    level.var_c510eb825f2464fe = makeweapon( bundle.deployweaponname );
    level.physicssphereradius[ bundle.var_547f5a486c2b88c2 ] = 1000;
    level.physicssphereforce[ bundle.var_547f5a486c2b88c2 ] = 6;
    level.weaponreloadtime[ bundle.var_547f5a486c2b88c2 ] = bundle.var_5eea3f80228d03e7;
    level.var_83fb6ee584b8beee = [];
}

// Namespace reaper_drone
// Params 0
// Checksum 0x43139e50, Offset: 0x1729
// Size: 0xb5
function function_4a93194c2a208f0e()
{
    val::group_register( "reaperDroneIntro", [ "allow_jump", "usability", "killstreaks", "supers", "gesture", "fire", "weapon_switch", "allow_movement", "offhand_weapons", "shellshock" ] );
    val::group_register( "reaperDroneUse", [ "usability", "killstreaks", "supers", "gesture", "weapon_switch", "allow_movement", "shellshock" ] );
}

#using_animtree( "script_model" );

// Namespace reaper_drone
// Params 0
// Checksum 0xd1ff6a3e, Offset: 0x17e6
// Size: 0x5b6
function function_f9cb89c47283fc75()
{
    level.scr_animtree[ "reaper_drone" ] = #animtree;
    animindex = "intro_reaper_drone";
    level.scr_anim[ "reaper_drone" ][ animindex ] = %mp_acharlie130_intro;
    animindex = "intro_reaper_drone_exterior";
    level.scr_anim[ "reaper_drone" ][ animindex ] = %iw9_mp_acharlie130_intro;
    animindex = "intro_gunner";
    level.scr_anim[ "reaper_drone" ][ animindex ] = %vm_ks_gunship_player_intro;
    animindex = "intro_co_gunner";
    level.scr_anim[ "reaper_drone" ][ animindex ] = %wm_ks_gunship_pilot2_intro;
    animindex = "intro_desk";
    level.scr_anim[ "reaper_drone" ][ animindex ] = %vm_ks_gunship_desk_intro;
    animindex = "intro_clipboard_1";
    level.scr_anim[ "reaper_drone" ][ animindex ] = %vm_ks_gunship_clipboard1_intro;
    animindex = "intro_clipboard_2";
    level.scr_anim[ "reaper_drone" ][ animindex ] = %vm_ks_gunship_clipboard2_intro;
    animindex = "intro_paper";
    level.scr_anim[ "reaper_drone" ][ animindex ] = %vm_ks_gunship_paper1_intro;
    animindex = "intro_pen_1";
    level.scr_anim[ "reaper_drone" ][ animindex ] = %vm_ks_gunship_pen1_intro;
    animindex = "intro_pen_2";
    level.scr_anim[ "reaper_drone" ][ animindex ] = %vm_ks_gunship_pen2_intro;
    animindex = "intro_smartphone";
    level.scr_anim[ "reaper_drone" ][ animindex ] = %vm_ks_gunship_smartphone1_intro;
    animindex = "intro_tablet";
    level.scr_anim[ "reaper_drone" ][ animindex ] = %vm_ks_gunship_tablet1_intro;
    animindex = "intro_binder";
    level.scr_anim[ "reaper_drone" ][ animindex ] = %vm_ks_gunship_binder_intro;
    animindex = "intro_joystick";
    level.scr_anim[ "reaper_drone" ][ animindex ] = %vm_ks_gunship_joystick_intro;
    animindex = "outro_gunner";
    level.scr_anim[ "reaper_drone" ][ animindex ] = %vm_ks_gunship_player_outro;
    animindex = "outro_co_gunner";
    level.scr_anim[ "reaper_drone" ][ animindex ] = %wm_ks_gunship_pilot2_outro;
    animindex = "outro_desk";
    level.scr_anim[ "reaper_drone" ][ animindex ] = %vm_ks_gunship_desk_outro;
    animindex = "outro_clipboard_1";
    level.scr_anim[ "reaper_drone" ][ animindex ] = %vm_ks_gunship_clipboard1_outro;
    animindex = "outro_clipboard_2";
    level.scr_anim[ "reaper_drone" ][ animindex ] = %vm_ks_gunship_clipboard2_outro;
    animindex = "outro_paper";
    level.scr_anim[ "reaper_drone" ][ animindex ] = %vm_ks_gunship_paper1_outro;
    animindex = "outro_pen_1";
    level.scr_anim[ "reaper_drone" ][ animindex ] = %vm_ks_gunship_pen1_outro;
    animindex = "outro_pen_2";
    level.scr_anim[ "reaper_drone" ][ animindex ] = %vm_ks_gunship_pen2_outro;
    animindex = "outro_smartphone";
    level.scr_anim[ "reaper_drone" ][ animindex ] = %vm_ks_gunship_smartphone1_outro;
    animindex = "outro_tablet";
    level.scr_anim[ "reaper_drone" ][ animindex ] = %vm_ks_gunship_tablet1_outro;
    animindex = "outro_binder";
    level.scr_anim[ "reaper_drone" ][ animindex ] = %vm_ks_gunship_binder_outro;
    animindex = "outro_joystick";
    level.scr_anim[ "reaper_drone" ][ animindex ] = %vm_ks_gunship_joystick_outro;
    animindex = "outro_gunship_death";
    level.scr_anim[ "reaper_drone" ][ animindex ] = %mp_acharlie130_death;
    
    foreach ( animindex, scr_anim in level.scr_anim[ "reaper_drone" ] )
    {
        level.scr_animlength[ "reaper_drone" ][ animindex ] = animation::get_scr_animlength( "reaper_drone", animindex );
    }
    
    bundle = level.streakglobals.streakbundles[ "reaper_drone" ];
    level.var_e52fe44e53a7205 = [];
    level.var_e52fe44e53a7205[ "reaper_drone_exterior" ] = bundle.var_7fedadd3f3af6615;
    level.var_e52fe44e53a7205[ "gunner" ] = "body_sp_ally_sensor_operator_vm_1_1_noface";
    level.var_e52fe44e53a7205[ "co_gunner" ] = "fullbody_sp_ally_sensor_operator_wm_1_1";
    level.var_e52fe44e53a7205[ "desk" ] = "misc_gunship_interior_desk";
    level.var_e52fe44e53a7205[ "clipboard_1" ] = "misc_un_office_clipboard_01";
    level.var_e52fe44e53a7205[ "clipboard_2" ] = "misc_un_office_clipboard_01";
    level.var_e52fe44e53a7205[ "paper" ] = "misc_un_office_paper_01";
    level.var_e52fe44e53a7205[ "pen_1" ] = "misc_un_office_pen_01";
    level.var_e52fe44e53a7205[ "pen_2" ] = "misc_un_office_pen_01";
    level.var_e52fe44e53a7205[ "smartphone" ] = "offhand1h_smartphone_static_v0";
    level.var_e52fe44e53a7205[ "tablet" ] = "offhand2h_tablet_static_v0";
    level.var_e52fe44e53a7205[ "binder" ] = "misc_un_office_binder_open";
    level.var_e52fe44e53a7205[ "joystick" ] = "misc_gunship_interior_joystick";
    level.reaperdrone_animtype = getdvarint( @"hash_da3918131a0e213c", 0 );
}

// Namespace reaper_drone
// Params 0
// Checksum 0x451a6393, Offset: 0x1da4
// Size: 0x1d3
function function_37f79d193d2fbdd6()
{
    game[ "dialog" ][ "reaper_drone" + "_use" ] = "killstreak_remote_operator" + "_request_response";
    game[ "dialog" ][ "reaper_drone" + "_leave" ] = "killstreak_remote_operator" + "_leave";
    game[ "dialog" ][ "reaper_drone" + "_engage" ] = "killstreak_remote_operator" + "_engage";
    game[ "dialog" ][ "reaper_drone" + "_random_radio" ] = "killstreak_remote_operator" + "_radio_chatter";
    game[ "dialog" ][ "reaper_drone" + "_flares" ] = "killstreak_remote_operator" + "_flare_release";
    game[ "dialog" ][ "reaper_drone" + "_light_damage" ] = "killstreak_remote_operator" + "_light_damage";
    game[ "dialog" ][ "reaper_drone" + "_med_damage" ] = "killstreak_remote_operator" + "_med_damage";
    game[ "dialog" ][ "reaper_drone" + "_heavy_damage" ] = "killstreak_remote_operator" + "_heavy_damage";
    game[ "dialog" ][ "reaper_drone" + "_lockedon" ] = "killstreak_remote_operator" + "_missile_lock_warning";
    game[ "dialog" ][ "reaper_drone" + "_crash" ] = "killstreak_remote_operator" + "_crash";
    game[ "dialog" ][ "reaper_drone" + "_hit_target" ] = "killstreak_remote_operator" + "_hit_target";
    game[ "dialog" ][ "reaper_drone" + "_miss_target" ] = "killstreak_remote_operator" + "_miss_target";
    game[ "dialog" ][ "reaper_drone" + "_spotted_single_target" ] = "killstreak_remote_operator" + "_target_spotted_single";
    game[ "dialog" ][ "reaper_drone" + "_spotted_multi_target" ] = "killstreak_remote_operator" + "_miss_target";
    game[ "dialog" ][ "reaper_drone" + "_hellfire_reload" ] = "killstreak_remote_operator" + "_hellfire_reload";
}

// Namespace reaper_drone
// Params 0
// Checksum 0x3ecd8787, Offset: 0x1f7f
// Size: 0x4d
function function_383d90193d7c30af()
{
    level._effect[ "clouds" ] = loadfxasset( "vfx_iw8_mp_strk_ac130_view_clouds" );
    level._effect[ "gunship_flares" ] = loadfxasset( "vfx_iw8_mp_strk_ac130_flares" );
    level._effect[ "camera_spotlight" ] = loadfxasset( "vfx_iw8_mp_strk_ac130_ir_spotlight" );
}

// Namespace reaper_drone
// Params 0
// Checksum 0x21e82907, Offset: 0x1fd4
// Size: 0x1f
function function_afb947c50d86b5d0()
{
    if ( isdefined( level.var_c468d38a30d12b7f ) )
    {
        killstreak_shared::function_28d986de72ce85f8( level.var_c468d38a30d12b7f );
    }
}

// Namespace reaper_drone
// Params 1
// Checksum 0xd8c37ec5, Offset: 0x1ffb
// Size: 0x134
function function_e2d8901aa82cb5f1( streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( !isdefined( streakinfo ) )
    {
        streakinfo = killstreak_utility::createstreakinfo( "reaper_drone", self );
    }
    
    self notify( #"using_remote" );
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return 0;
        }
    }
    
    deployresult = killstreakdeploy::streakdeploy_doweapontabletdeploy( streakinfo, &function_6d4fcc49ae6e409a );
    
    if ( !deployresult )
    {
        return 0;
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
            return 0;
        }
    }
    
    if ( level.gameended )
    {
        streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
        return 0;
    }
    
    result = reaperdrone_startuse( self, streakinfo );
    
    if ( !result )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( "KILLSTREAKS/AIR_SPACE_TOO_CROWDED" );
        }
        
        streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
        return 0;
    }
    
    return result;
}

// Namespace reaper_drone
// Params 2
// Checksum 0x22817ae4, Offset: 0x2138
// Size: 0xa0
function function_7e1765e14bbff97( owner, streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    owner endon( #"disconnect" );
    
    if ( utility::issharedfuncdefined( #"killstreak", #"allowridekillstreakplayerexit" ) )
    {
        self thread [[ utility::getsharedfunc( #"killstreak", #"allowridekillstreakplayerexit" ) ]]();
    }
    
    self waittill( #"killstreakexit" );
    thread reaperdrone_leave( owner, streakinfo );
}

// Namespace reaper_drone
// Params 2
// Checksum 0xf2ef540f, Offset: 0x21e0
// Size: 0x4fb, Type: bool
function reaperdrone_startuse( player, streakinfo )
{
    level endon( #"game_ended" );
    
    if ( utility::issharedfuncdefined( #"game", #"disable_backpack_inventory" ) )
    {
        player [[ utility::getsharedfunc( #"game", #"disable_backpack_inventory" ) ]]( 1 );
    }
    
    launchorigin = level.var_360674e8272fbd31;
    
    if ( game_utility::islargemap() )
    {
        if ( level.gametype == "arm" || level.gametype == "conflict" || level.gametype == "gwtdm" )
        {
            if ( isdefined( level.hqmidpoint ) )
            {
                launchorigin = level.hqmidpoint;
            }
            else if ( isdefined( level.reaper_drone_origin_override ) )
            {
                launchorigin = level.reaper_drone_origin_override;
            }
        }
        else
        {
            launchorigin = player.origin;
        }
    }
    
    var_4bf214646074fa67 = function_47417f19a1d899b6( player, launchorigin );
    
    if ( !isdefined( var_4bf214646074fa67 ) )
    {
        return false;
    }
    
    introangle = randomint( 360 );
    radiusoffset = 9000;
    zoffset = 8000;
    
    /#
        var_32233f9276ee8b8c = getdvarint( @"hash_70773afbc2169291", 0 );
        zoffset += var_32233f9276ee8b8c;
        radiusoffsetoverride = getdvarint( @"hash_f1ea2d078a9bea84", 0 );
        
        if ( radiusoffsetoverride != 0 )
        {
            radiusoffset = radiusoffsetoverride;
        }
        
        zoffsetoverride = getdvarint( @"hash_94486296ed0311dc", 0 );
        
        if ( zoffsetoverride != 0 )
        {
            zoffset = 8000 + zoffsetoverride;
        }
    #/
    
    xoffset = cos( introangle ) * radiusoffset;
    yoffset = sin( introangle ) * radiusoffset;
    introanglevector = vectornormalize( ( xoffset, yoffset, zoffset ) );
    introanglevector *= zoffset;
    level.var_75d944a462ee0f79 = 1;
    reaperdroneintro = reaperdrone_playintro( player, streakinfo, introangle, introanglevector, var_4bf214646074fa67 );
    
    if ( !isdefined( reaperdroneintro ) )
    {
        level.var_75d944a462ee0f79 = 0;
        return false;
    }
    
    reaperdrone = reaperdrone_spawn( player, streakinfo, introangle, introanglevector, reaperdroneintro, var_4bf214646074fa67 );
    
    if ( utility::issharedfuncdefined( #"emp", #"setemp_applied_callback" ) )
    {
        reaperdrone [[ utility::getsharedfunc( #"emp", #"setemp_applied_callback" ) ]]( &reaperdrone_empapplied );
    }
    
    if ( !isdefined( reaperdrone ) )
    {
        level.var_75d944a462ee0f79 = 0;
        return false;
    }
    
    if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
    {
        thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( "used_reaper_drone", player );
    }
    
    if ( getdvarint( @"camera_thirdperson" ) )
    {
        if ( utility::issharedfuncdefined( #"player", #"hash_c2eed707cc193392" ) )
        {
            player [[ utility::getsharedfunc( #"player", #"hash_c2eed707cc193392" ) ]]( 0 );
        }
    }
    
    if ( utility::issharedfuncdefined( #"killstreak", #"addtoactivekillstreaklist" ) )
    {
        reaperdrone [[ utility::getsharedfunc( #"killstreak", #"addtoactivekillstreaklist" ) ]]( reaperdrone.streakinfo.streakname, "Killstreak_Air", player );
    }
    
    weapon_utility::setlockedoncallback( reaperdrone, &function_61fabd5e92cca8da );
    weapon_utility::setlockedonremovedcallback( reaperdrone, &function_b29d42a8e07a91c0 );
    reaperdrone thread function_fd7aed9595dfa38c( player );
    reaperdrone thread function_ec772b1002aaaf76( player );
    reaperdrone thread function_8b5bbe1efb94b27b( player );
    reaperdrone thread function_872d0b5a12f66f14( player );
    reaperdrone thread function_c820f16393579e18( player );
    reaperdrone thread function_b45cd18f684e0f30( player, streakinfo );
    reaperdrone thread function_55a82a18403875ec( player, streakinfo );
    reaperdrone thread function_3a72eda142448092( player );
    reaperdrone thread function_32339595b51def( player );
    reaperdrone thread function_4c0f1c5b105f1c8e( player, "disconnect", streakinfo );
    reaperdrone thread function_4c0f1c5b105f1c8e( player, "joined_team", streakinfo );
    reaperdrone thread function_4c0f1c5b105f1c8e( player, "joined_spectators", streakinfo );
    reaperdrone thread function_4c0f1c5b105f1c8e( player, "team_kill_punish", streakinfo );
    reaperdrone thread function_4c0f1c5b105f1c8e( player, "player_fatal_death", streakinfo );
    reaperdrone thread function_30a3f53e6a4624e0( player );
    reaperdrone thread function_584d72f18f440169();
    reaperdrone thread function_7e1765e14bbff97( player, streakinfo );
    reaperdrone thread function_c5d541ceb45b29ca( player );
    reaperdrone thread function_d3055b11687af379( player );
    reaperdrone thread function_9642d4679b1de90b( player );
    
    /#
        thirdpersoncam = getdvarint( @"hash_413d547c976e2cbb", 0 );
        
        if ( thirdpersoncam )
        {
            reaperdrone thread function_eacdbedaac377668();
            reaperdrone thread function_6e121821bba5bdca( var_4bf214646074fa67 );
        }
    #/
    
    if ( utility::issharedfuncdefined( #"flares", #"hash_c8c23ade5da7f4bb" ) )
    {
        reaperdrone thread [[ utility::getsharedfunc( #"flares", #"hash_c8c23ade5da7f4bb" ) ]]( &reaperdrone_handlemissiledetection );
    }
    
    reaperdrone playloopsound( "iw8_ks_ac130_lp" );
    
    if ( player.ksempd )
    {
        reaperdrone thread reaperdrone_crash( player );
    }
    
    return true;
}

// Namespace reaper_drone
// Params 2
// Checksum 0xd2d319d1, Offset: 0x26e4
// Size: 0xd1
function function_47417f19a1d899b6( owner, launchorigin )
{
    var_571fc2326ce92329 = undefined;
    
    if ( !game_utility::islargemap() )
    {
        if ( level.var_83fb6ee584b8beee.size > 0 )
        {
            var_571fc2326ce92329 = level.var_83fb6ee584b8beee[ 0 ];
        }
    }
    else if ( level.var_83fb6ee584b8beee.size >= 1 )
    {
        return;
    }
    
    if ( !isdefined( var_571fc2326ce92329 ) )
    {
        var_571fc2326ce92329 = spawn( "script_model", launchorigin );
        var_571fc2326ce92329 setmodel( "tag_origin" );
        var_571fc2326ce92329.angles = ( 0, 115, 0 );
        var_571fc2326ce92329 hide();
        level.var_83fb6ee584b8beee[ level.var_83fb6ee584b8beee.size ] = var_571fc2326ce92329;
        var_571fc2326ce92329 thread function_407ccc3389b247d1();
        
        if ( !game_utility::islargemap() )
        {
            var_571fc2326ce92329 thread function_1e63bf5796b367f4();
        }
    }
    
    return var_571fc2326ce92329;
}

// Namespace reaper_drone
// Params 0
// Checksum 0x9b358406, Offset: 0x27be
// Size: 0x33
function function_61fabd5e92cca8da()
{
    killstreak_utility::playkillstreakoperatordialog( "reaper_drone", "reaper_drone" + "_lockedon" );
    vehicle_omnvar::show_warning( "missileLocking", self.owner, "killstreak" );
}

// Namespace reaper_drone
// Params 0
// Checksum 0xbc06c828, Offset: 0x27f9
// Size: 0x1c
function function_b29d42a8e07a91c0()
{
    vehicle_omnvar::hide_warning( "missileLocking", self.owner, "killstreak" );
}

// Namespace reaper_drone
// Params 5
// Checksum 0x1a71fd7c, Offset: 0x281d
// Size: 0x121
function reaperdrone_playintro( player, streakinfo, angle, anglevector, var_4bf214646074fa67 )
{
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    thirdpersoncam = 0;
    
    /#
        thirdpersoncam = getdvarint( @"hash_413d547c976e2cbb", 0 );
        
        if ( thirdpersoncam )
        {
            streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
        }
    #/
    
    streakinfo endon( #"killstreak_finished_with_deploy_weapon" );
    player disablephysicaldepthoffieldscripting();
    player function_ee53d77e062d3e3c( 0 );
    
    if ( !thirdpersoncam )
    {
        player shellshock_utility_cpmp::_stopshellshock();
        player val::group_set( "reaperDroneIntro", 0 );
    }
    
    reaperdroneintro = undefined;
    
    /#
        level.reaperdrone_animtype = getdvarint( @"hash_da3918131a0e213c", 0 );
    #/
    
    reaperdroneintro = spawnstruct();
    reaperdroneintro.owner = player;
    reaperdroneintro notify( #"hash_a762ac17b1c50ca4" );
    
    if ( !thirdpersoncam )
    {
        player disablephysicaldepthoffieldscripting();
        shellshock_utility_cpmp::_stopshellshock();
        player val::group_reset( "reaperDroneIntro" );
    }
    
    return reaperdroneintro;
}

// Namespace reaper_drone
// Params 2
// Checksum 0xaff1ce9b, Offset: 0x2947
// Size: 0x73
function function_76d168893fcc938d( action, streakinfo )
{
    self endon( #"death" );
    self endon( #"hash_a762ac17b1c50ca4" );
    level endon( #"game_ended" );
    var_2793d94192ef23d4 = self.owner;
    var_2793d94192ef23d4 waittill( action );
    
    if ( action == "disconnect" )
    {
        level.var_75d944a462ee0f79 = 0;
    }
    
    function_deaae4eb5f5e4c7e( var_2793d94192ef23d4, streakinfo );
}

// Namespace reaper_drone
// Params 2
// Checksum 0x21bfe185, Offset: 0x29c2
// Size: 0xe1
function function_deaae4eb5f5e4c7e( owner, streakinfo )
{
    thirdpersoncam = 0;
    
    /#
        thirdpersoncam = getdvarint( @"hash_413d547c976e2cbb", 0 );
    #/
    
    if ( isdefined( owner ) && !thirdpersoncam )
    {
        owner cameraunlink();
        owner shellshock_utility_cpmp::_stopshellshock();
        owner disablephysicaldepthoffieldscripting();
        owner val::group_reset( "reaperDroneIntro" );
        owner killstreak_utility::function_d546aaa588f088c3( streakinfo.streakname, "off" );
        owner setclientomnvar( "ui_gunship_hud", 0 );
        owner painvisionon();
        owner killstreak_shared::killstreak_restorenvgstate();
        owner killstreak_utility::killstreak_setmainvision( "" );
        owner killstreak_utility::function_f1c03b279632ba1e();
        owner notify( #"detach_reaper_drone_intro" );
        level thread game_utility::fadetoblackforplayer( owner, 0 );
    }
    
    streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
    function_6dc632748095e131( self );
}

// Namespace reaper_drone
// Params 1
// Checksum 0xd6c1d8cf, Offset: 0x2aab
// Size: 0x4e
function function_8afe89eb0b251cc9( owner )
{
    self endon( #"death" );
    owner endon( #"disconnect" );
    
    while ( true )
    {
        level waittill( #"connected", player );
        self hidefromplayer( player );
    }
}

// Namespace reaper_drone
// Params 3
// Checksum 0x7d487aa0, Offset: 0x2b01
// Size: 0x155
function function_f8a1371952f88c5d( animlength, owner, introsequence )
{
    self endon( #"death" );
    owner endon( #"disconnect" );
    owner endon( #"detach_reaper_drone_intro" );
    owner enablephysicaldepthoffieldscripting();
    
    if ( isdefined( introsequence ) )
    {
        if ( introsequence == "intro_reaper_drone_exterior" )
        {
            owner setphysicaldepthoffield( 1.4, 87, 10, 10 );
            phase1dof = animlength * 0.25;
            phase2dof = animlength * 0.65;
            thread function_31376d3c74f31429( owner, phase1dof, 2.2, 87, 50, 50 );
            thread function_31376d3c74f31429( owner, phase2dof, 4, 350, 1, 1 );
            return;
        }
        
        if ( introsequence == "intro" )
        {
            owner setphysicaldepthoffield( 1.4, 21, 1000, 1000 );
            phase1dof = animlength * 0.8;
            thread function_31376d3c74f31429( owner, phase1dof, 1.4, 43, 50, 50 );
            return;
        }
        
        owner setphysicaldepthoffield( 1.4, 43, 1000, 1000 );
        phase1dof = animlength * 0.5;
        phase2dof = animlength * 0.7;
        thread function_31376d3c74f31429( owner, phase1dof, 1.4, 20, 50, 50 );
        thread function_31376d3c74f31429( owner, phase2dof, 3, 100, 50, 50 );
    }
}

// Namespace reaper_drone
// Params 6
// Checksum 0x5286137f, Offset: 0x2c5e
// Size: 0x6e
function function_31376d3c74f31429( owner, delaytime, fstop, focusdistance, focusspeed, var_6bde45c712e6685b )
{
    self endon( #"death" );
    owner endon( #"disconnect" );
    owner endon( #"detach_reaper_drone_intro" );
    wait delaytime;
    owner setphysicaldepthoffield( fstop, focusdistance, focusspeed, var_6bde45c712e6685b );
}

// Namespace reaper_drone
// Params 3
// Checksum 0x48819cd7, Offset: 0x2cd4
// Size: 0x103
function function_5c68569ffbd5e66e( animlength, owner, introsequence )
{
    self endon( #"death" );
    owner endon( #"disconnect" );
    owner endon( #"detach_reaper_drone_intro" );
    animtime = animlength;
    eqscale = 0.45;
    shaketime = 0.05;
    
    if ( isdefined( introsequence ) )
    {
        if ( introsequence == "intro_reaper_drone_exterior" )
        {
            eqscale = 0.01;
            shaketime = 0.25;
        }
    }
    
    while ( animtime > 0 )
    {
        owner earthquakeforplayer( eqscale, shaketime, self.origin, 5000 );
        
        if ( isdefined( introsequence ) )
        {
            if ( introsequence == "intro_reaper_drone_exterior" )
            {
                eqscale += 0.01;
                
                if ( eqscale >= 0.1 )
                {
                    eqscale = 0.1;
                }
            }
        }
        else
        {
            eqscale -= 0.01;
            
            if ( eqscale <= 0.12 )
            {
                eqscale = 0.12;
            }
        }
        
        animtime -= shaketime;
        wait shaketime;
    }
}

// Namespace reaper_drone
// Params 2
// Checksum 0x29fb551c, Offset: 0x2ddf
// Size: 0x75
function function_fe5ae8620642fb59( animlength, owner )
{
    self endon( #"death" );
    owner endon( #"disconnect" );
    owner endon( #"detach_reaper_drone_intro" );
    hostmigration::waitlongdurationwithpause( animlength - 0.2 );
    owner killstreak_utility::killstreak_setmainvision( "killstreak_slamzoom" );
    hostmigration::waitlongdurationwithpause( 0.1 );
    level thread game_utility::fadetoblackforplayer( owner, 1, 0.1 );
}

// Namespace reaper_drone
// Params 2
// Checksum 0xa333c0f9, Offset: 0x2e5c
// Size: 0x6b
function function_ca9acec5e4056a2( animlength, owner )
{
    owner endon( #"disconnect" );
    level endon( #"game_ended" );
    owner endon( #"detach_reaper_drone_intro" );
    wait animlength - 0.3;
    level thread game_utility::fadetoblackforplayer( owner, 1, 0.3 );
    wait 0.7;
    level thread game_utility::fadetoblackforplayer( owner, 0, 0.3 );
}

// Namespace reaper_drone
// Params 2
// Checksum 0x441d44cc, Offset: 0x2ecf
// Size: 0x333
function function_ccc29582a27bc09d( player, crashing )
{
    level callback::callback( #"killstreak_finish_use", { #streakinfo:self.streakinfo } );
    
    if ( isdefined( player ) )
    {
        player endon( #"disconnect" );
        thirdpersoncam = 0;
        
        /#
            thirdpersoncam = getdvarint( @"hash_413d547c976e2cbb", 0 );
        #/
        
        if ( !thirdpersoncam )
        {
            player shellshock_utility_cpmp::_stopshellshock();
        }
        
        player setclientomnvar( "ui_killstreak_thermal_mode", 0 );
        player player_utility::setthermalvision( 0 );
        player killstreak_utility::function_d546aaa588f088c3( self.streakinfo.streakname, "off" );
        player setclientomnvar( "ui_gunship_hud", 0 );
        player stoploopsound();
        player killstreak_utility::killstreak_setmainvision( "" );
        player clearclienttriggeraudiozone( 0.5 );
        player painvisionon();
        player shellshock_utility_cpmp::_stopshellshock();
        player clearcinematicmotionoverride();
        
        if ( utility::issharedfuncdefined( #"game", #"disable_backpack_inventory" ) )
        {
            player [[ utility::getsharedfunc( #"game", #"disable_backpack_inventory" ) ]]( 0 );
        }
        
        player val::reset( "reaper_drone_weap_swap_safety", "weapon_switch" );
        player notify( #"returning_killstreak_player" );
        player.var_ca2c5f357feee551 = undefined;
        
        if ( getdvarint( @"camera_thirdperson" ) )
        {
            if ( utility::issharedfuncdefined( #"player", #"hash_c2eed707cc193392" ) )
            {
                player [[ utility::getsharedfunc( #"player", #"hash_c2eed707cc193392" ) ]]( 1 );
            }
        }
        
        if ( isdefined( player.var_a9d44fc4dedbfbf6 ) )
        {
            player.var_a9d44fc4dedbfbf6 delete();
        }
        
        if ( !thirdpersoncam )
        {
            if ( player player::isreallyalive() )
            {
                player inventory_utility::_giveweapon( level.var_c510eb825f2464fe );
                player inventory_utility::_switchtoweaponimmediate( level.var_c510eb825f2464fe );
            }
            
            player unlink();
            
            if ( crashing && level.reaperdrone_animtype == 0 )
            {
                player waittill( #"finished_gunship_anim_outro" );
                player killstreak_utility::killstreak_setmainvision( "killstreak_static" );
                wait 1;
                player cameraunlink();
                player killstreak_utility::killstreak_setmainvision( "" );
            }
            
            player val::group_reset( "reaperDroneUse" );
            player function_ee53d77e062d3e3c( 1 );
            player killstreak_utility::function_f1c03b279632ba1e();
            player killstreak_shared::killstreak_restorenvgstate();
            player thread function_a073c0dbe01c086d( self.streakinfo );
        }
        else
        {
            /#
                self.streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
            #/
        }
    }
    
    function_6dc632748095e131( self.reaperdroneintro );
    function_b29d42a8e07a91c0();
    
    if ( isdefined( self.enemytargetmarkergroup ) )
    {
        targetmarkergroups::targetmarkergroup_off( self.enemytargetmarkergroup );
    }
    
    if ( isdefined( self.friendlytargetmarkergroup ) )
    {
        targetmarkergroups::targetmarkergroup_off( self.friendlytargetmarkergroup );
    }
    
    if ( utility::issharedfuncdefined( #"gunship", #"hash_2918c33ec5cc3bb6" ) )
    {
        [[ utility::getsharedfunc( #"gunship", #"hash_2918c33ec5cc3bb6" ) ]]( player );
    }
    
    level.var_75d944a462ee0f79 = 0;
}

// Namespace reaper_drone
// Params 1
// Checksum 0xbaff0b37, Offset: 0x320a
// Size: 0x10b
function function_a073c0dbe01c086d( streakinfo )
{
    self endon( #"disconnect" );
    streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
    dropanimtime = getanimlength( %vm_ks_tablet_drop );
    bundle = level.streakglobals.streakbundles[ "reaper_drone" ];
    
    if ( player::isreallyalive() )
    {
        val::set( "reaperDroneExit", "fire", 0 );
        val::set( "reaperDroneExit", "allow_movement", 0 );
        val::set( "reaperDroneExit", "offhand_weapons", 0 );
        val::set( "reaperDroneExit", "mantle", 0 );
        val::set( "reaperDroneExit", "melee", 0 );
        wait 0.05;
        inventory_utility::_switchtoweapon( self.lastdroppableweaponobj );
        wait dropanimtime;
        inventory_utility::_takeweapon( bundle.var_547f5a486c2b88c2 );
        inventory_utility::_takeweapon( level.var_c510eb825f2464fe );
        val::reset_all( "reaperDroneExit" );
    }
}

// Namespace reaper_drone
// Params 1
// Checksum 0x3d5ecada, Offset: 0x331d
// Size: 0x50d
function function_c820f16393579e18( gunner )
{
    self endon( #"death" );
    self endon( #"crashing" );
    level endon( #"game_ended" );
    self.damagetaken = 0;
    self.attractor = missile_createattractorent( self, 1000, 4096 );
    bundle = level.streakglobals.streakbundles[ "reaper_drone" ];
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, smeansofdeath, modelname, tagname, partname, idflags, objweapon );
        thirdpersoncam = undefined;
        debugdamage = undefined;
        
        /#
            thirdpersoncam = getdvarint( @"hash_413d547c976e2cbb", 0 );
            debugdamage = istrue( self.debugdamage );
        #/
        
        if ( isdefined( level.teambased ) && isplayer( attacker ) && attacker.team == self.team && !thirdpersoncam && !debugdamage )
        {
            continue;
        }
        
        if ( smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_EXPLOSIVE_BULLET" )
        {
            continue;
        }
        
        if ( isdefined( gunner ) && gunner function_44abe13b81b00355() )
        {
            var_44320290cb66d730 = "light";
            
            if ( isexplosivedamagemod( smeansofdeath ) )
            {
                if ( ceil( damage / self.maxhealth ) >= bundle.var_e93489e58e852d44 )
                {
                    gunner earthquakeforplayer( 0.25, 0.2, self.camera.origin, 150 );
                    gunner playrumbleonentity( "damage_heavy" );
                    var_44320290cb66d730 = "heavy";
                }
                else
                {
                    gunner earthquakeforplayer( 0.15, 0.15, self.camera.origin, 150 );
                    gunner playrumbleonentity( "damage_light" );
                }
            }
            
            gunner killstreak_shared::function_9fd22f7d1a941d8a( self.currentvisionset, var_44320290cb66d730 );
        }
        
        self.wasdamaged = 1;
        modifieddamage = undefined;
        
        if ( isdefined( debugdamage ) )
        {
            modifieddamage = damage;
        }
        else if ( utility::issharedfuncdefined( #"killstreak", #"getmodifiedantikillstreakdamage" ) )
        {
            modifieddamage = self [[ utility::getsharedfunc( #"killstreak", #"getmodifiedantikillstreakdamage" ) ]]( attacker, objweapon, smeansofdeath, damage, self.maxhealth, 4, 5, 25, 0, 350 );
        }
        
        if ( isplayer( attacker ) )
        {
            if ( utility::issharedfuncdefined( #"damage", #"updatedamagefeedback" ) )
            {
                attacker [[ utility::getsharedfunc( #"damage", #"updatedamagefeedback" ) ]]( "hitequip" );
            }
        }
        
        if ( utility::issharedfuncdefined( #"killstreak", #"killstreakhit" ) )
        {
            [[ utility::getsharedfunc( #"killstreak", #"killstreakhit" ) ]]( attacker, objweapon, self, smeansofdeath, modifieddamage );
        }
        
        if ( isplayer( attacker.owner ) )
        {
            if ( utility::issharedfuncdefined( #"damage", #"updatedamagefeedback" ) )
            {
                attacker.owner [[ utility::getsharedfunc( #"damage", #"updatedamagefeedback" ) ]]( "hitequip" );
            }
        }
        
        self.damagetaken += modifieddamage;
        self.currenthealth -= modifieddamage;
        killstreak_utility::killstreak_updatedamagestate( self.currenthealth );
        
        if ( self.damagetaken >= self.maxhealth )
        {
            streakname = self.streakinfo.streakname;
            damagetype = undefined;
            scorepopupname = "destroyed_" + streakname;
            leaderdialog = undefined;
            cardsplash = "callout_destroyed_" + streakname;
            skipdeathnotify = 1;
            
            if ( isplayer( attacker ) )
            {
                if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
                {
                    thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( cardsplash, attacker );
                }
            }
            
            if ( utility::issharedfuncdefined( #"damage", #"onkillstreakkilled" ) && isdefined( attacker ) && ( isplayer( attacker ) || isdefined( attacker.owner ) ) )
            {
                notifyattacker = self [[ utility::getsharedfunc( #"damage", #"onkillstreakkilled" ) ]]( streakname, attacker, objweapon, damagetype, damage, scorepopupname, leaderdialog, cardsplash, skipdeathnotify );
            }
            
            thread reaperdrone_crash( gunner );
        }
    }
}

// Namespace reaper_drone
// Params 0
// Checksum 0x909b056e, Offset: 0x3832
// Size: 0x6a
function function_673dee3cc301f470()
{
    self setscriptablepartstate( "body_damage_light", "on" );
    gunner = self.owner;
    
    if ( isdefined( gunner ) && gunner function_44abe13b81b00355() )
    {
        self.flashlight setscriptablepartstate( "camera_damage_light", "on" );
        gunner killstreak_utility::playkillstreakoperatordialog( "reaper_drone", "reaper_drone" + "_light_damage" );
    }
}

// Namespace reaper_drone
// Params 0
// Checksum 0x4840e8e4, Offset: 0x38a4
// Size: 0x94
function function_8cfd9ba017c3fd55()
{
    self setscriptablepartstate( "body_damage_light", "off" );
    self setscriptablepartstate( "body_damage_medium", "on" );
    gunner = self.owner;
    
    if ( isdefined( gunner ) && gunner function_44abe13b81b00355() )
    {
        self.flashlight setscriptablepartstate( "camera_damage_medium", "on" );
        gunner killstreak_utility::playkillstreakoperatordialog( "reaper_drone", "reaper_drone" + "_med_damage" );
        gunner playlocalsound( "ks_ac130_damage_warning" );
        gunner setclienttriggeraudiozone( "gunship_killstreak_damaged", 2 );
    }
}

// Namespace reaper_drone
// Params 0
// Checksum 0x4868fccd, Offset: 0x3940
// Size: 0x81
function function_16eb0ee17537f9d5()
{
    self setscriptablepartstate( "body_damage_medium", "off" );
    self setscriptablepartstate( "contrails", "off" );
    thread function_7c255a0e0b28b43a();
    gunner = self.owner;
    
    if ( isdefined( gunner ) && gunner function_44abe13b81b00355() )
    {
        self.flashlight setscriptablepartstate( "camera_damage_heavy", "on" );
        gunner killstreak_utility::playkillstreakoperatordialog( "reaper_drone", "reaper_drone" + "_heavy_damage" );
    }
}

// Namespace reaper_drone
// Params 0
// Checksum 0x7c540b87, Offset: 0x39c9
// Size: 0x8e
function function_7c255a0e0b28b43a()
{
    level endon( #"game_ended" );
    self.leftwingfxent setscriptablepartstate( "engine_blowout", "on" );
    self.leftwingfxent setscriptablepartstate( "body_damage_heavy", "on" );
    randomwait = randomfloatrange( 0.5, 1 );
    hostmigration::waitlongdurationwithpause( randomwait );
    self.rightwingfxent setscriptablepartstate( "engine_blowout", "on" );
    self.rightwingfxent setscriptablepartstate( "body_damage_heavy", "on" );
}

// Namespace reaper_drone
// Params 2
// Checksum 0x87e08479, Offset: 0x3a5f
// Size: 0x59
function function_b45cd18f684e0f30( gunner, streakinfo )
{
    self endon( #"death", #"leaving", #"crashing" );
    level endon( #"game_ended" );
    hostmigration::waitlongdurationwithpause( self.timeout );
    thread reaperdrone_leave( gunner, streakinfo );
}

// Namespace reaper_drone
// Params 2
// Checksum 0x2e287d80, Offset: 0x3ac0
// Size: 0x90
function function_55a82a18403875ec( gunner, streakinfo )
{
    self endon( #"death", #"leaving", #"crashing" );
    level utility::waittill_any( "start_game_ended", "game_ended" );
    
    if ( gunner && streakinfo )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"hash_bf17c172d25e8b3d" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            gunner [[ var_32dbca3143d9c4a5 ]]( streakinfo );
        }
    }
    
    thread reaperdrone_leave( gunner, streakinfo );
}

// Namespace reaper_drone
// Params 2
// Checksum 0xe594eb2f, Offset: 0x3b58
// Size: 0xfb
function reaperdrone_leave( gunner, streakinfo )
{
    self endon( #"death" );
    self endon( #"crashing" );
    level endon( #"game_ended" );
    self notify( #"leaving" );
    self unlink();
    self rotateroll( 30, 3 );
    currentangles = self.angles;
    currentdir = anglestoforward( currentangles );
    
    if ( isdefined( self.owner ) )
    {
        self.owner killstreak_utility::playkillstreakoperatordialog( "reaper_drone", "reaper_drone" + "_leave" );
    }
    
    thread function_ccc29582a27bc09d( gunner );
    self moveto( self.origin + currentdir * 50000, 10, 5 );
    self.owner killstreak_utility::recordkillstreakendstats( streakinfo );
    function_441e1340d66b973c( self.origin + currentdir * 50000 );
    function_bdf75dfa11c9debc( 0 );
}

// Namespace reaper_drone
// Params 1
// Checksum 0xfbe9a9cc, Offset: 0x3c5b
// Size: 0x25
function function_441e1340d66b973c( destination )
{
    while ( isdefined( self ) && self.origin != destination )
    {
        waitframe();
    }
}

// Namespace reaper_drone
// Params 3
// Checksum 0xcdc52379, Offset: 0x3c88
// Size: 0x75
function function_4c0f1c5b105f1c8e( gunner, exitaction, streakinfo )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"leaving" );
    level endon( #"game_ended" );
    gunner waittill( exitaction );
    
    if ( exitaction == "player_fatal_death" )
    {
        thread reaperdrone_leave( gunner, streakinfo );
        return;
    }
    
    thread reaperdrone_crash( gunner );
}

// Namespace reaper_drone
// Params 1
// Checksum 0x375b1290, Offset: 0x3d05
// Size: 0x78
function function_30a3f53e6a4624e0( gunner )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"leaving" );
    gunner endon( #"disconnect" );
    level waittill( #"game_ended" );
    gunner killstreak_utility::function_d546aaa588f088c3( self.streakinfo.streakname, "off" );
    gunner setclientomnvar( "ui_gunship_hud", 0 );
}

// Namespace reaper_drone
// Params 1
// Checksum 0x1711ffc2, Offset: 0x3d85
// Size: 0x9c
function function_c5d541ceb45b29ca( gunner )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"leaving" );
    level endon( #"game_ended" );
    self.velocity = ( 0, 0, 0 );
    
    while ( true )
    {
        self.lastorigin = self.origin;
        wait level.framedurationseconds;
        self.velocity = ( self.origin - self.lastorigin ) / level.framedurationseconds;
    }
}

// Namespace reaper_drone
// Params 6
// Checksum 0x125e9766, Offset: 0x3e29
// Size: 0x375
function reaperdrone_spawn( owner, streakinfo, angle, anglevector, reaperdroneintro, var_4bf214646074fa67 )
{
    bundle = level.streakglobals.streakbundles[ "reaper_drone" ];
    reaperdrone = spawn( "script_model", var_4bf214646074fa67.origin );
    reaperdrone setmodel( bundle.var_7b2b8ded82466fb1 );
    reaperdrone setcandamage( 1 );
    reaperdrone.currenthealth = bundle.maxhealth;
    reaperdrone.maxhealth = reaperdrone.currenthealth;
    reaperdrone.health = 99999;
    reaperdrone.owner = owner;
    reaperdrone.team = owner.team;
    reaperdrone.reaperdroneintro = reaperdroneintro;
    reaperdrone.var_4bf214646074fa67 = var_4bf214646074fa67;
    reaperdrone.ispiloted = 1;
    reaperdrone.timeout = bundle.reaperdrone_lifetime;
    
    if ( utility::issharedfuncdefined( #"gunship", #"attachxrays" ) )
    {
        reaperdrone = [[ utility::getsharedfunc( #"gunship", #"attachxrays" ) ]]( reaperdrone );
    }
    
    reaperdrone.hellfireloaded = 1;
    hellfiretarget = spawn( "script_model", reaperdrone.origin );
    hellfiretarget setmodel( "tag_origin" );
    reaperdrone.hellfiretarget = hellfiretarget;
    
    if ( game_utility::islargemap() )
    {
        var_4bf214646074fa67 thread function_59442d7d61b3e688( reaperdrone );
    }
    
    reaperdrone sentientpoolmanager::registersentient( "Killstreak_Air", owner, undefined, undefined, 1, 0 );
    reaperdrone killstreak_utility::function_b555369eba6b0252( 1, bundle.var_dbaa0516ebad1035, &function_673dee3cc301f470 );
    reaperdrone killstreak_utility::function_b555369eba6b0252( 2, bundle.var_5409e32b5384cf5a, &function_8cfd9ba017c3fd55 );
    reaperdrone killstreak_utility::function_b555369eba6b0252( 3, bundle.var_930fd1485c15f533, &function_16eb0ee17537f9d5 );
    
    /#
        timeoutoverride = getdvarint( @"scr_reaper_drone_timeout", bundle.reaperdrone_lifetime );
        var_ae24eaad32921ae2 = getdvarint( @"hash_2c01d701bac5d9d3", 0 );
        
        if ( var_ae24eaad32921ae2 )
        {
            timeoutoverride = 9999;
        }
        
        reaperdrone.timeout = timeoutoverride;
    #/
    
    if ( isdefined( level.var_67c2d8556b7bb778 ) )
    {
        reaperdrone.timeout = level.var_67c2d8556b7bb778;
    }
    
    reaperdrone.flaresreservecount = bundle.var_5808394df46cce4e;
    reaperdrone.streakinfo = streakinfo;
    reaperdrone scriptmoveroutline();
    reaperdrone scriptmoverthermal();
    reaperdrone setotherent( owner );
    minimapid = undefined;
    
    if ( utility::issharedfuncdefined( #"game", #"createobjective" ) )
    {
        minimapid = reaperdrone [[ utility::getsharedfunc( #"game", #"createobjective" ) ]]( "hud_icon_minimap_killstreak_gunship", reaperdrone.team, 0, 1, 1 );
    }
    
    reaperdrone.minimapid = minimapid;
    reaperdrone linkto( var_4bf214646074fa67, "tag_origin", anglevector, ( 0, angle + 90, -30 ) );
    level notify( #"hash_a5a8563d907d6bf0", reaperdrone );
    return reaperdrone;
}

// Namespace reaper_drone
// Params 1
// Checksum 0xa11d2561, Offset: 0x41a7
// Size: 0x6c
function function_66f9bc02772d503f( plane )
{
    plane endon( #"death" );
    plane endon( #"crashing" );
    plane endon( #"leaving" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    wait 0.05;
    thread function_c1e8260c7b361f2a( plane );
    thread function_aeb77cf3b8263bab( plane );
    thread function_47201e48046a73e2( plane );
}

// Namespace reaper_drone
// Params 1
// Checksum 0x4996c8d4, Offset: 0x421b
// Size: 0xaf
function function_c1e8260c7b361f2a( plane )
{
    plane endon( #"death" );
    plane endon( #"crashing" );
    plane endon( #"leaving" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self setclientomnvar( "ui_gunship_coord1_posx", int( plane.origin[ 0 ] ) );
        self setclientomnvar( "ui_gunship_coord1_posy", int( plane.origin[ 1 ] ) );
        self setclientomnvar( "ui_gunship_coord1_posz", int( plane.origin[ 2 ] ) );
        wait 0.5;
    }
}

// Namespace reaper_drone
// Params 1
// Checksum 0x8d785c49, Offset: 0x42d2
// Size: 0x9c
function function_aeb77cf3b8263bab( plane )
{
    plane endon( #"death" );
    plane endon( #"crashing" );
    plane endon( #"leaving" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    waitframe();
    self setclientomnvar( "ui_gunship_coord2_posx", int( self.origin[ 0 ] ) );
    self setclientomnvar( "ui_gunship_coord2_posy", int( self.origin[ 1 ] ) );
    self setclientomnvar( "ui_gunship_coord2_posz", int( self.origin[ 2 ] ) );
}

// Namespace reaper_drone
// Params 1
// Checksum 0x9f9fb11e, Offset: 0x4376
// Size: 0xcd
function function_47201e48046a73e2( plane )
{
    plane endon( #"death" );
    plane endon( #"crashing" );
    plane endon( #"leaving" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        starttrace = self getvieworigin();
        endtrace = starttrace + anglestoforward( self getplayerangles() ) * 15000;
        endpos = physicstrace( starttrace, endtrace );
        self setclientomnvar( "ui_gunship_coord3_posx", int( endpos[ 0 ] ) );
        self setclientomnvar( "ui_gunship_coord3_posy", int( endpos[ 1 ] ) );
        self setclientomnvar( "ui_gunship_coord3_posz", int( endpos[ 2 ] ) );
        wait 0.1;
    }
}

// Namespace reaper_drone
// Params 0
// Checksum 0xdcd22b9, Offset: 0x444b
// Size: 0xc3
function function_407ccc3389b247d1()
{
    self endon( #"death" );
    var_ee4c6e2afcb5b82c = 10;
    rotatetime = level.reaperdrone_speed[ "rotate" ] / 360 * var_ee4c6e2afcb5b82c;
    self rotateyaw( self.angles[ 2 ] + var_ee4c6e2afcb5b82c, rotatetime, rotatetime, 0 );
    degreespersecond = 360 / level.reaperdrone_speed[ "rotate" ];
    var_47a3f478a98f61d5 = degreespersecond * 0.0174533;
    level.reaperdrone_magnitude = var_47a3f478a98f61d5 * 9000;
    
    while ( true )
    {
        self rotateyaw( 360, level.reaperdrone_speed[ "rotate" ] );
        wait level.reaperdrone_speed[ "rotate" ];
    }
}

// Namespace reaper_drone
// Params 1
// Checksum 0xce274474, Offset: 0x4516
// Size: 0x3f4
function function_fd7aed9595dfa38c( gunner )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"leaving" );
    gunner killstreak_utility::killstreak_setmainvision( "" );
    level thread game_utility::fadetoblackforplayer( gunner, 0, 0.1 );
    
    /#
        thirdpersoncam = getdvarint( @"hash_413d547c976e2cbb", 0 );
        
        if ( thirdpersoncam )
        {
            if ( level.reaperdrone_animtype == 1 )
            {
                function_6dc632748095e131( self.reaperdroneintro );
            }
            else
            {
                gunner function_e52d5be9a3c11e35( self.reaperdroneintro );
            }
            
            self.streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
            return;
        }
    #/
    
    bundle = level.streakglobals.streakbundles[ "reaper_drone" ];
    gunner inventory_utility::_giveweapon( bundle.var_547f5a486c2b88c2 );
    gunner inventory_utility::_switchtoweaponimmediate( bundle.var_547f5a486c2b88c2 );
    gunner val::set( "reaper_drone_weap_swap_safety", "weapon_switch", 0 );
    waitframe();
    gunner cameraunlink();
    
    if ( level.reaperdrone_animtype == 1 )
    {
        function_6dc632748095e131( self.reaperdroneintro );
    }
    else
    {
        gunner function_e52d5be9a3c11e35( self.reaperdroneintro );
    }
    
    self.camera = spawn( "script_model", self.origin - ( 0, 0, 20 ) );
    self.camera setmodel( "tag_player" );
    self.camera.angles = vectortoangles( self.var_4bf214646074fa67.origin - self.camera.origin );
    self.camera linkto( self );
    
    if ( isbot( gunner ) )
    {
        gunner cameralinkto( self.camera, "tag_player" );
        return;
    }
    
    arcclamps = function_e379384278b5d0b2( bundle );
    gunner killstreak_utility::playkillstreakoperatordialog( "reaper_drone", "reaper_drone" + "_engage" );
    gunner.var_ca2c5f357feee551 = 1;
    gunner playerlinkweaponviewtodelta( self.camera, "tag_player", 1, arcclamps[ 0 ], arcclamps[ 1 ], arcclamps[ 2 ], arcclamps[ 3 ], 0, 1, 1 );
    gunner playerlinkedsetviewznear( 0 );
    gunner setclienttriggeraudiozone( "gunship_killstreak", 2 );
    gunner setplayerangles( self.camera.angles );
    gunner val::set( "reaperDroneUse", "ads", 1 );
    gunner setcinematicmotionoverride( "player_gunship_ride_mp" );
    gunner thread killstreak_utility::function_785239235d790099( "65_instant_noscale" );
    gunner killstreak_utility::function_d546aaa588f088c3( self.streakinfo.streakname, "on" );
    gunner setclientomnvar( "ui_gunship_hud", 1 );
    gunner setclientomnvar( "ui_killstreak_weapon_1_ammo", gunner getweaponammoclip( bundle.var_547f5a486c2b88c2 ) );
    gunner setclientomnvar( "ui_killstreak_countdown", gettime() + int( self.timeout * 1000 ) );
    gunner setclientomnvar( "ui_killstreak_health", self.maxhealth );
    gunner setclientomnvar( "ui_killstreak_flares", self.flaresreservecount );
    gunner setclientomnvar( "ui_killstreak_damage_state", 0 );
    gunner shellshock_utility_cpmp::_shellshock( "killstreak_veh_camera_mp", "top", self.timeout, 0 );
    gunner shellshock_utility_cpmp::_stopshellshock();
    gunner val::group_set( "reaperDroneUse", 0 );
    
    if ( utility::issharedfuncdefined( #"gunship", #"assigntargetmarkers" ) )
    {
        self thread [[ utility::getsharedfunc( #"gunship", #"assigntargetmarkers" ) ]]( gunner );
    }
    
    gunner thread function_66f9bc02772d503f( self );
    thread function_cd9d4d60ab41c1cd( bundle.var_547f5a486c2b88c2 );
}

// Namespace reaper_drone
// Params 1
// Checksum 0x361e2413, Offset: 0x4912
// Size: 0xee
function function_e379384278b5d0b2( bundle )
{
    rightarcclamp = 100;
    leftarcclamp = 100;
    toparcclamp = 17;
    bottomarcclamp = 90;
    
    /#
        if ( getdvarint( @"hash_14cecfeb51104958", -1 ) >= 0 )
        {
            rightarcclamp = getdvarint( @"hash_14cecfeb51104958", -1 );
        }
        
        if ( getdvarint( @"hash_7e966ab65cc4864d", -1 ) >= 0 )
        {
            leftarcclamp = getdvarint( @"hash_7e966ab65cc4864d", -1 );
        }
        
        if ( getdvarint( @"hash_c2a52fc921138071", -1 ) >= 0 )
        {
            toparcclamp = getdvarint( @"hash_c2a52fc921138071", -1 );
        }
        
        if ( getdvarint( @"hash_550544859e48862b", -1 ) >= 0 )
        {
            bottomarcclamp = getdvarint( @"hash_550544859e48862b", -1 );
        }
    #/
    
    return [ rightarcclamp, leftarcclamp, toparcclamp, bottomarcclamp ];
}

// Namespace reaper_drone
// Params 1
// Checksum 0x91c712e0, Offset: 0x4a09
// Size: 0x7a
function function_ec772b1002aaaf76( gunner )
{
    gunner endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"leaving" );
    level endon( #"game_ended" );
    
    /#
        thirdpersoncam = getdvarint( @"hash_413d547c976e2cbb", 0 );
        
        if ( thirdpersoncam )
        {
            return;
        }
    #/
    
    gunner setclientomnvar( "ui_killstreak_weapon", 3 );
}

// Namespace reaper_drone
// Params 1
// Checksum 0xfbfc3e, Offset: 0x4a8b
// Size: 0x165
function function_8b5bbe1efb94b27b( gunner )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"leaving" );
    level endon( #"game_ended" );
    
    /#
        thirdpersoncam = getdvarint( @"hash_413d547c976e2cbb", 0 );
        
        if ( thirdpersoncam )
        {
            return;
        }
    #/
    
    streakinfo = self.streakinfo;
    bundle = level.streakglobals.streakbundles[ "reaper_drone" ];
    
    while ( true )
    {
        gunner waittill( #"missile_fire", projectile );
        projectile.streakinfo = streakinfo;
        streakinfo.shots_fired++;
        weapon = gunner getcurrentweapon();
        currentammo = gunner getweaponammoclip( weapon );
        
        if ( weapon.basename == bundle.var_547f5a486c2b88c2 )
        {
            earthquake( 0.2, 1, self.origin, 1000 );
            gunner setclientomnvar( "ui_killstreak_weapon_1_ammo", currentammo );
            projectile thread function_91a903e21126ca0c( self, gunner );
        }
        
        projectile thread function_81585929fd605305( self, gunner, weapon.basename );
        
        if ( currentammo == 0 )
        {
            gunner thread function_fd0c560251196833( weapon, self );
        }
    }
}

// Namespace reaper_drone
// Params 2
// Checksum 0x761e1aac, Offset: 0x4bf8
// Size: 0xc3
function function_91a903e21126ca0c( reaperdrone, gunner )
{
    reaperdrone endon( #"death" );
    reaperdrone endon( #"leaving" );
    reaperdrone endon( #"crashing" );
    gunner endon( #"disconnect" );
    self endon( #"death" );
    targetent = reaperdrone.hellfiretarget;
    
    if ( isdefined( gunner.missilelaunchertarget ) && gunner.missilelauncherstage == 2 )
    {
        targetent = gunner.missilelaunchertarget;
        reaperdrone notify( #"hash_b49c51c70b70e9da" );
    }
    
    self missile_settargetent( targetent );
    gunner waittill( #"hash_6c0c4bd6c13f24a4" );
    self missile_cleartarget();
}

// Namespace reaper_drone
// Params 1
// Checksum 0x2403b385, Offset: 0x4cc3
// Size: 0x42
function function_872d0b5a12f66f14( gunner )
{
    if ( !isai( gunner ) )
    {
        gunner thread player_utility::watchthermalinputchange();
    }
    
    function_d9c375bd685cdcfd( gunner );
    
    if ( isdefined( gunner ) && !isai( gunner ) )
    {
        gunner player_utility::stopwatchingthermalinputchange();
    }
}

// Namespace reaper_drone
// Params 1
// Checksum 0xfcf4952d, Offset: 0x4d0d
// Size: 0x271
function function_d9c375bd685cdcfd( gunner )
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    gunner endon( #"disconnect" );
    level endon( #"game_ended" );
    self.flashlight = spawn( "script_model", self.origin );
    self.flashlight setmodel( "ks_gunship_mp" );
    self.flashlight dontinterpolate();
    self.flashlight thread function_decdb8d33f8477bc( self, gunner );
    
    if ( utility::isnightmap() )
    {
        self.flashlight thread function_20c0770690bfc15();
    }
    
    togglethermal = 0;
    var_92fdfd77367b8a9d = 1;
    
    /#
        thirdpersoncam = getdvarint( @"hash_413d547c976e2cbb", 0 );
        
        if ( thirdpersoncam )
        {
            var_92fdfd77367b8a9d = 0;
        }
    #/
    
    thermalfstop = 12;
    var_4a403cf63d50a47c = 1000;
    thermalvisionset = killstreak_utility::function_2c6a2b2cb28d923a();
    
    if ( utility::isnightmap() && var_92fdfd77367b8a9d )
    {
        gunner player_utility::setthermalvision( 1, thermalfstop, var_4a403cf63d50a47c );
        self.currentvisionset = thermalvisionset;
        self.flashlight notify( #"flashlight_on" );
        togglethermal = 1;
        gunner shellshock_utility_cpmp::_shellshock( "killstreak_veh_camera_flir_mp", "top", self.timeout, 0 );
        gunner setclientomnvar( "ui_killstreak_thermal_mode", 1 );
        gunner killstreak_utility::killstreak_setmainvision( thermalvisionset );
    }
    
    while ( true )
    {
        gunner waittill( #"switch_thermal_mode" );
        var_900ceff0d41e5ff6 = gunner getcurrentweapon();
        dofinfo = function_f4ea2dc9963b54a( var_900ceff0d41e5ff6.basename );
        
        if ( !togglethermal )
        {
            gunner player_utility::setthermalvision( 1, dofinfo.fstop, dofinfo.focusdistance );
            self.currentvisionset = thermalvisionset;
            togglethermal = 1;
            gunner shellshock_utility_cpmp::_shellshock( "killstreak_veh_camera_flir_mp", "top", self.timeout, 0 );
            gunner setclientomnvar( "ui_killstreak_thermal_mode", 1 );
            gunner killstreak_utility::killstreak_setmainvision( thermalvisionset );
            continue;
        }
        
        togglethermal = 0;
        gunner shellshock_utility_cpmp::_shellshock( "killstreak_veh_camera_mp", "top", self.timeout, 0 );
        gunner setclientomnvar( "ui_killstreak_thermal_mode", 0 );
        gunner player_utility::setthermalvision( 0 );
    }
}

// Namespace reaper_drone
// Params 1
// Checksum 0xd3f6712b, Offset: 0x4f86
// Size: 0x6f
function function_f4ea2dc9963b54a( weaponbasename )
{
    dofinfo = spawnstruct();
    bundle = level.streakglobals.streakbundles[ "reaper_drone" ];
    
    if ( weaponbasename == bundle.var_547f5a486c2b88c2 )
    {
        dofinfo.fstop = 8;
        dofinfo.focusdistance = 600;
    }
    
    return dofinfo;
}

// Namespace reaper_drone
// Params 2
// Checksum 0x6751a1ca, Offset: 0x4ffe
// Size: 0xa6
function function_decdb8d33f8477bc( reaperdrone, gunner )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    useplayerangles = 1;
    
    /#
        thirdpersoncam = getdvarint( @"hash_413d547c976e2cbb", 0 );
        
        if ( thirdpersoncam )
        {
            useplayerangles = 0;
        }
    #/
    
    while ( isdefined( reaperdrone ) && isdefined( gunner ) )
    {
        self.origin = reaperdrone.origin;
        
        if ( useplayerangles )
        {
            self.angles = gunner getplayerangles();
        }
        
        wait 0.05;
    }
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace reaper_drone
// Params 0
// Checksum 0x94b80d72, Offset: 0x50ac
// Size: 0x7d
function function_20c0770690bfc15()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    playfxontag( utility::getfx( "camera_spotlight" ), self, "tag_origin" );
    
    while ( true )
    {
        level waittill( #"hash_d94a0708ab9a7c55" );
        stopfxontag( utility::getfx( "camera_spotlight" ), self, "tag_origin" );
        hostmigration::waitlongdurationwithpause( 0.1 );
        playfxontag( utility::getfx( "camera_spotlight" ), self, "tag_origin" );
    }
}

// Namespace reaper_drone
// Params 2
// Checksum 0x8b1cac11, Offset: 0x5131
// Size: 0x1e4
function function_fd0c560251196833( weapon, reaperdrone )
{
    reaperdrone endon( #"death" );
    reaperdrone endon( #"crashing" );
    reaperdrone endon( #"leaving" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    bundle = level.streakglobals.streakbundles[ "reaper_drone" ];
    weaponrootname = function_c4da8c4da1fb36f2( weapon );
    reloadsound = weaponrootname + "_mp_reload";
    var_e2a20f1ceef2d751 = strtok( weaponrootname, "_" );
    
    if ( var_e2a20f1ceef2d751[ 0 ] == "gunship" )
    {
        reloadsound = "ac130";
        
        for ( i = 1; i < var_e2a20f1ceef2d751.size ; i++ )
        {
            appendstring = var_e2a20f1ceef2d751[ i ];
            
            if ( appendstring == "hellfire" )
            {
                appendstring = "105mm";
            }
            
            reloadsound = reloadsound + "_" + appendstring;
        }
        
        reloadsound += "_mp_reload";
    }
    
    self playlocalsound( reloadsound );
    
    if ( weapon.basename == bundle.var_547f5a486c2b88c2 )
    {
        reaperdrone.hellfireloaded = 0;
    }
    
    function_87a6110bf6c46362( weapon, weaponrootname );
    reloaddialog = weaponrootname + "_reload";
    killstreak_utility::playkillstreakoperatordialog( "reaper_drone", reloaddialog );
    maxammo = weaponmaxammo( weapon );
    self setweaponammoclip( weapon, maxammo );
    
    if ( weapon.basename == bundle.var_547f5a486c2b88c2 )
    {
        reaperdrone.hellfireloaded = 1;
    }
    
    var_e735af55bb6b24df = undefined;
    
    switch ( weaponrootname )
    {
        case #"hash_a595cc01d9fdb1c3":
            var_e735af55bb6b24df = "ui_killstreak_weapon_1_ammo";
            break;
    }
    
    self setclientomnvar( var_e735af55bb6b24df, maxammo );
}

// Namespace reaper_drone
// Params 2
// Checksum 0xfbc0cf3f, Offset: 0x531d
// Size: 0x9a
function function_87a6110bf6c46362( weapon, weaponrootname )
{
    reloadtime = level.weaponreloadtime[ weapon.basename ];
    var_4e129dddbbe48fe4 = undefined;
    
    switch ( weaponrootname )
    {
        case #"hash_a595cc01d9fdb1c3":
            var_4e129dddbbe48fe4 = "ui_killstreak_weapon_1_reloadtime";
            break;
    }
    
    self setclientomnvar( var_4e129dddbbe48fe4, gettime() + int( reloadtime * 1000 ) );
    
    while ( true )
    {
        wait 0.05;
        reloadtime -= 0.05;
        
        if ( reloadtime <= 0 )
        {
            break;
        }
    }
}

// Namespace reaper_drone
// Params 1
// Checksum 0xa7934a86, Offset: 0x53bf
// Size: 0x55
function function_c4da8c4da1fb36f2( weapon )
{
    index = 0;
    weaponname = weapon.basename;
    tokens = strtok( weaponname, "_" );
    return tokens[ index ] + "_" + tokens[ index + 1 ];
}

// Namespace reaper_drone
// Params 1
// Checksum 0xf730d008, Offset: 0x541d
// Size: 0x27
function deleteaftertime( delay )
{
    self endon( #"death" );
    hostmigration::waitlongdurationwithpause( delay );
    self delete();
}

// Namespace reaper_drone
// Params 1
// Checksum 0x2bbc0f46, Offset: 0x544c
// Size: 0x33
function reaperdrone_crash( gunner )
{
    self notify( #"crashing" );
    self.crashed = 1;
    thread function_e30a178ddd99fbda( gunner );
    thread function_65dd58ebc57c4275();
}

// Namespace reaper_drone
// Params 1
// Checksum 0x63c1bbdb, Offset: 0x5487
// Size: 0x108
function function_e30a178ddd99fbda( gunner )
{
    if ( !isdefined( gunner ) )
    {
        return;
    }
    
    if ( isdefined( self ) )
    {
        self endon( #"death" );
        gunner endon( #"disconnect" );
        thread function_ccc29582a27bc09d( gunner, 1 );
        
        if ( isdefined( self.reaperdroneintro ) && level.reaperdrone_animtype == 0 )
        {
            self.reaperdroneintro function_21d29f116e74c737( gunner, "light_interior_outro", "on", "ks_gunship_interior_outro", 0.5 );
            self playsoundtoplayer( "iw9_gunship_plr_outro", gunner );
            gunner killstreak_utility::playkillstreakoperatordialog( "reaper_drone", "reaper_drone" + "_crash" );
            var_fecddb9be8864dcc = animation::get_scr_animlength( "reaper_drone", "outro_gunner" );
            gunner thread function_b873276d28548fe5( var_fecddb9be8864dcc );
            gunner function_6aa8bf135d385cf5( self.reaperdroneintro, "outro" );
            self.reaperdroneintro function_21d29f116e74c737( gunner, "light_interior_outro", "off", "ks_gunship_interior_outro", 0 );
        }
    }
}

// Namespace reaper_drone
// Params 0
// Checksum 0x3cfdd7a0, Offset: 0x5597
// Size: 0x306
function function_65dd58ebc57c4275()
{
    level endon( #"game_ended" );
    self.leftwingfxent setscriptablepartstate( "engine_blowout", "off" );
    self.rightwingfxent setscriptablepartstate( "engine_blowout", "off" );
    hostmigration::waitlongdurationwithpause( 3 );
    self.leftwingfxent setscriptablepartstate( "engine_blowout", "on" );
    self.rightwingfxent setscriptablepartstate( "engine_blowout", "on" );
    self unlink();
    self.var_d511ee197fc9d1c9 = spawn( "script_model", self.origin );
    self.var_d511ee197fc9d1c9 setmodel( "tag_origin" );
    self.var_d511ee197fc9d1c9.angles = vectortoangles( anglestoforward( self.angles ) );
    self.leftwingfxent setscriptablepartstate( "engine_blowout", "off" );
    self.rightwingfxent setscriptablepartstate( "engine_blowout", "off" );
    self.leftwingfxent setscriptablepartstate( "body_damage_heavy", "off" );
    self.rightwingfxent setscriptablepartstate( "body_damage_heavy", "off" );
    bundle = level.streakglobals.streakbundles[ "reaper_drone" ];
    crashmodel = spawn( "script_model", self.origin );
    crashmodel setmodel( bundle.var_ae04903748dbf3ee );
    crashmodel.angles = self.angles;
    crashmodel.animname = self.streakinfo.streakname;
    crashmodel animation::setanimtree();
    explosionfxent = spawn( "script_model", self.origin );
    explosionfxent setmodel( "ks_gunship_mp" );
    explosionfxent.angles = self.angles;
    explosionfxent linkto( crashmodel, "tag_body", ( 0, 0, -10 ), ( 0, 0, 0 ) );
    
    /#
    #/
    
    crashpart = "crash_air";
    explosionfxent setscriptablepartstate( crashpart, "on", 0 );
    
    if ( utility::issharedfuncdefined( #"entity", #"hash_cb0d9e569e0f2002" ) )
    {
        explosionfxent thread [[ utility::getsharedfunc( #"entity", #"hash_cb0d9e569e0f2002" ) ]]( 10 );
        crashmodel thread [[ utility::getsharedfunc( #"entity", #"hash_cb0d9e569e0f2002" ) ]]( 10 );
    }
    
    crashmodel thread function_eb0168556f6d1b3c();
    var_fc597558cd692273 = "outro_gunship_death";
    var_7526baf774a635ed = animation::get_scr_animlength( "reaper_drone", var_fc597558cd692273 );
    thread function_b240013463c3ed19();
    thread function_f1db03e57c0e64c6( var_7526baf774a635ed );
    self.var_d511ee197fc9d1c9 animation::anim_single_solo( crashmodel, var_fc597558cd692273 );
    self.var_d511ee197fc9d1c9 delete();
    function_bdf75dfa11c9debc( 1 );
}

// Namespace reaper_drone
// Params 0
// Checksum 0xf1c3000a, Offset: 0x58a5
// Size: 0x1a
function function_b240013463c3ed19()
{
    level endon( #"game_ended" );
    wait 0.05;
    self hide();
}

// Namespace reaper_drone
// Params 1
// Checksum 0x43e07d79, Offset: 0x58c7
// Size: 0xc5
function function_f1db03e57c0e64c6( delaytime )
{
    level endon( #"game_ended" );
    var_156b609ddcf72f46 = delaytime - 2;
    hostmigration::waitlongdurationwithpause( var_156b609ddcf72f46 );
    
    foreach ( player in level.players )
    {
        if ( player player::isreallyalive() )
        {
            player earthquakeforplayer( 0.25, 2, self.origin, 30000 );
        }
    }
}

// Namespace reaper_drone
// Params 1
// Checksum 0x63f8776c, Offset: 0x5994
// Size: 0x32
function function_b873276d28548fe5( delaytime )
{
    level endon( #"game_ended" );
    hostmigration::waitlongdurationwithpause( delaytime );
    killstreak_utility::function_daa9374e3f6779a5( "reaper_drone", "pilot" );
}

// Namespace reaper_drone
// Params 0
// Checksum 0x7c769434, Offset: 0x59ce
// Size: 0x4f
function function_eb0168556f6d1b3c()
{
    waitframe();
    playsoundatpos( self.origin, "iw8_ks_ac130_explo_main" );
    playsoundatpos( self.origin, "iw8_ks_ac130_explo_low_02" );
    playsoundatpos( self.origin, "iw8_ks_ac130_shake_explo" );
    playsoundatpos( self.origin, "iw8_ks_ac130_whine" );
}

// Namespace reaper_drone
// Params 1
// Checksum 0x7a555992, Offset: 0x5a25
// Size: 0x147
function function_bdf75dfa11c9debc( wasdestroyed )
{
    if ( isdefined( self.flashlight ) )
    {
        self.flashlight delete();
    }
    
    if ( isdefined( self.camera ) )
    {
        self.camera delete();
    }
    
    if ( isdefined( self.leftwingfxent ) )
    {
        self.leftwingfxent delete();
    }
    
    if ( isdefined( self.rightwingfxent ) )
    {
        self.rightwingfxent delete();
    }
    
    if ( isdefined( self.lightfxent ) )
    {
        self.lightfxent delete();
    }
    
    if ( isdefined( self.hellfiretarget ) )
    {
        self.hellfiretarget delete();
    }
    
    if ( isdefined( self.minimapid ) )
    {
        if ( utility::issharedfuncdefined( #"game", #"returnobjectiveid" ) )
        {
            [[ utility::getsharedfunc( #"game", #"returnobjectiveid" ) ]]( self.minimapid );
        }
        
        self.minimapid = undefined;
    }
    
    self.streakinfo.expiredbydeath = istrue( wasdestroyed );
    
    if ( isdefined( self.owner ) )
    {
        self.owner killstreak_utility::recordkillstreakendstats( self.streakinfo );
    }
    
    self delete();
}

// Namespace reaper_drone
// Params 1
// Checksum 0x2e8841be, Offset: 0x5b74
// Size: 0xd2
function function_6dc632748095e131( intro )
{
    if ( isdefined( intro ) )
    {
        if ( isdefined( intro.var_d511ee197fc9d1c9 ) )
        {
            intro.var_d511ee197fc9d1c9 delete();
        }
        
        if ( isent( intro ) )
        {
            intro delete();
            return;
        }
        
        if ( isdefined( intro.var_8355961ae50efe3f ) )
        {
            foreach ( animent in intro.var_8355961ae50efe3f )
            {
                if ( isdefined( animent ) )
                {
                    animent delete();
                }
            }
        }
    }
}

// Namespace reaper_drone
// Params 1
// Checksum 0xc7621635, Offset: 0x5c4e
// Size: 0xab
function function_e52d5be9a3c11e35( intro )
{
    if ( isdefined( intro ) )
    {
        if ( isdefined( intro.var_8355961ae50efe3f ) )
        {
            foreach ( animent in intro.var_8355961ae50efe3f )
            {
                if ( isdefined( animent ) )
                {
                    animent hidefromplayer( intro.var_e6005f2ca4f815d7 );
                }
            }
        }
    }
}

// Namespace reaper_drone
// Params 2
// Checksum 0x216a1b69, Offset: 0x5d01
// Size: 0x2b1
function function_6aa8bf135d385cf5( intro, sequence )
{
    self endon( #"disconnect" );
    thirdpersoncam = 0;
    
    /#
        thirdpersoncam = getdvarint( @"hash_413d547c976e2cbb", 0 );
    #/
    
    if ( !isdefined( intro.var_e6005f2ca4f815d7 ) )
    {
        intro.var_e6005f2ca4f815d7 = self;
    }
    
    if ( isdefined( intro ) && isdefined( sequence ) )
    {
        thread killstreak_utility::function_785239235d790099( "80_instant_noscale", 1 );
        
        if ( sequence == "intro_reaper_drone_exterior" )
        {
            var_8de1030bdd9fcc20 = intro.var_8355961ae50efe3f[ "reaper_drone_exterior" ];
            var_c45330cfca1821ec = animation::get_scr_animlength( "reaper_drone", sequence );
            var_8de1030bdd9fcc20 showtoplayer( intro.var_e6005f2ca4f815d7 );
            intro.var_d511ee197fc9d1c9 thread animation::anim_single_solo( var_8de1030bdd9fcc20, sequence );
            
            if ( !thirdpersoncam )
            {
                intro.var_e6005f2ca4f815d7 cameralinkto( var_8de1030bdd9fcc20, "tag_player", 1, 1 );
            }
            
            var_8de1030bdd9fcc20 thread function_5c68569ffbd5e66e( var_c45330cfca1821ec, self, sequence );
            var_8de1030bdd9fcc20 thread function_f8a1371952f88c5d( var_c45330cfca1821ec, self, sequence );
            var_8de1030bdd9fcc20 thread function_ca9acec5e4056a2( var_c45330cfca1821ec, self );
            wait var_c45330cfca1821ec;
            
            if ( !thirdpersoncam )
            {
                intro.var_e6005f2ca4f815d7 cameraunlink();
            }
        }
        else
        {
            if ( sequence == "intro" )
            {
                var_8de1030bdd9fcc20 = intro.var_8355961ae50efe3f[ "reaper_drone_exterior" ];
            }
            
            if ( isdefined( intro.var_8355961ae50efe3f ) )
            {
                foreach ( modelindex, animent in intro.var_8355961ae50efe3f )
                {
                    if ( isdefined( animent ) )
                    {
                        if ( modelindex == "reaper_drone_exterior" )
                        {
                            continue;
                        }
                        
                        animent showtoplayer( intro.var_e6005f2ca4f815d7 );
                        
                        if ( modelindex == "reaper_drone_interior" )
                        {
                            continue;
                        }
                        
                        var_ad84d7156e99d8aa = sequence + "_" + modelindex;
                        intro.var_d511ee197fc9d1c9 thread animation::anim_single_solo( animent, var_ad84d7156e99d8aa );
                        
                        if ( !thirdpersoncam && modelindex == "gunner" )
                        {
                            intro.var_e6005f2ca4f815d7 cameralinkto( animent, "tag_camera", 1, 1 );
                            gunneranimlength = animation::get_scr_animlength( "reaper_drone", sequence + "_gunner" );
                            animent thread function_f8a1371952f88c5d( gunneranimlength, self, sequence );
                        }
                    }
                }
                
                var_c45330cfca1821ec = animation::get_scr_animlength( "reaper_drone", sequence + "_gunner" );
                wait var_c45330cfca1821ec;
            }
        }
        
        self notify( "finished_gunship_anim_" + sequence );
    }
}

// Namespace reaper_drone
// Params 2
// Checksum 0xe026ed7d, Offset: 0x5fba
// Size: 0x29c
function init_lighting_info_struct( probe_name, brush_name )
{
    lighting_info = spawnstruct();
    probe = getent( probe_name, "script_noteworthy" );
    
    if ( !isdefined( probe ) )
    {
        /#
            assert( 0, "<dev string:x24>" );
            self iprintln( "<dev string:x24>" );
        #/
        
        return;
    }
    
    shadow_brushes = getentarray( brush_name, "targetname" );
    
    if ( !isdefined( shadow_brushes ) )
    {
        /#
            assert( 0, "<dev string:x24>" );
            self iprintln( "<dev string:x24>" );
        #/
        
        return;
    }
    
    lighting_info.probe = probe;
    lighting_info.shadow_brushes = shadow_brushes;
    var_fb2126a779c39960 = [];
    var_3465effba18485b6 = [];
    var_fb2126a779c39960[ "pos" ] = probe.origin;
    var_fb2126a779c39960[ "rot" ] = probe.angles;
    lighting_info.var_1bce669644d2d203 = var_fb2126a779c39960;
    
    foreach ( index, brush in shadow_brushes )
    {
        brush_t = [];
        brush_t[ "pos" ] = brush.origin;
        brush_t[ "rot" ] = brush.angles;
        var_3465effba18485b6[ index ] = brush_t;
    }
    
    lighting_info.var_c13fe41474e457bd = var_3465effba18485b6;
    
    foreach ( var_2a304e9d2d9189a1 in level.players )
    {
        probe hidefromplayer( var_2a304e9d2d9189a1 );
        probe thread function_8afe89eb0b251cc9( self );
        
        foreach ( brush in shadow_brushes )
        {
            brush hidefromplayer( var_2a304e9d2d9189a1 );
            brush thread function_8afe89eb0b251cc9( self );
        }
    }
    
    return lighting_info;
}

// Namespace reaper_drone
// Params 3
// Checksum 0xee57a230, Offset: 0x625f
// Size: 0x134
function function_ef2b2fc9e9911794( owner, lighting_info, showlighting )
{
    if ( showlighting )
    {
        lighting_info.probe showtoplayer( owner );
        
        foreach ( brush in lighting_info.shadow_brushes )
        {
            brush showtoplayer( owner );
        }
        
        return;
    }
    
    lighting_info.probe hidefromplayer( owner );
    
    foreach ( brush in lighting_info.shadow_brushes )
    {
        brush hidefromplayer( owner );
    }
}

// Namespace reaper_drone
// Params 1
// Checksum 0x2ecc1b88, Offset: 0x639b
// Size: 0x44
function function_47c7c79b8e8f7b0d( lighting_info )
{
    if ( !isdefined( lighting_info ) )
    {
        return;
    }
    
    lighting_info.probe linkto( self, "tag_origin", ( 100, 0, 115 ), ( 0, 0, 0 ) );
}

// Namespace reaper_drone
// Params 1
// Checksum 0x5b53a9b7, Offset: 0x63e7
// Size: 0xad
function function_ef063ff4cbb1ac98( lighting_info )
{
    if ( !isdefined( lighting_info ) )
    {
        return;
    }
    
    foreach ( brush in lighting_info.shadow_brushes )
    {
        brush linkto( self, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    }
}

// Namespace reaper_drone
// Params 1
// Checksum 0xf333ff3d, Offset: 0x649c
// Size: 0x72
function unlink_probe( lighting_info )
{
    if ( !isdefined( lighting_info ) )
    {
        return;
    }
    
    lighting_info.probe unlink();
    lighting_info.probe.origin = lighting_info.var_1bce669644d2d203[ "pos" ];
    lighting_info.probe.angles = lighting_info.var_1bce669644d2d203[ "rot" ];
}

// Namespace reaper_drone
// Params 0
// Checksum 0xd2cffb39, Offset: 0x6516
// Size: 0x9c
function function_cbe5fd2f297d38b6()
{
    if ( getdvarint( @"hash_e6afce2cf5cf7515" ) == 0 )
    {
        capture_model = getentarray( "ks_gunship_light_only", "script_noteworthy" );
        
        foreach ( m in capture_model )
        {
            m hide();
        }
    }
}

// Namespace reaper_drone
// Params 1
// Checksum 0x605264d1, Offset: 0x65ba
// Size: 0xcd
function unlink_brushes( lighting_info )
{
    if ( !isdefined( lighting_info ) )
    {
        return;
    }
    
    foreach ( index, brush in lighting_info.shadow_brushes )
    {
        brush unlink();
        brush.origin = lighting_info.var_c13fe41474e457bd[ index ][ "pos" ];
        brush.angles = lighting_info.var_c13fe41474e457bd[ index ][ "rot" ];
    }
}

// Namespace reaper_drone
// Params 5
// Checksum 0x590ba6e4, Offset: 0x668f
// Size: 0x143
function function_21d29f116e74c737( player, scriptablepart, state, visionset_name, time )
{
    thirdpersoncam = undefined;
    
    /#
        thirdpersoncam = getdvarint( @"hash_413d547c976e2cbb", 0 );
        
        if ( thirdpersoncam )
        {
            return;
        }
    #/
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( state == "on" )
    {
        self.var_45bfcea98dc4e31d function_ef2b2fc9e9911794( player, self.var_d19f67b41e8be751, 1 );
        self.var_45bfcea98dc4e31d function_47c7c79b8e8f7b0d( self.var_d19f67b41e8be751 );
        self.var_45bfcea98dc4e31d function_ef063ff4cbb1ac98( self.var_d19f67b41e8be751 );
        self.var_45bfcea98dc4e31d setscriptablepartstate( scriptablepart, "on" );
        player visionsetnakedforplayer( visionset_name, time );
        return;
    }
    
    if ( state == "off" )
    {
        self.var_45bfcea98dc4e31d function_ef2b2fc9e9911794( player, self.var_d19f67b41e8be751, 0 );
        unlink_probe( self.var_d19f67b41e8be751 );
        unlink_brushes( self.var_d19f67b41e8be751 );
        self.var_45bfcea98dc4e31d setscriptablepartstate( scriptablepart, "off" );
        player visionsetnakedforplayer( "", time );
    }
}

/#

    // Namespace reaper_drone
    // Params 3
    // Checksum 0x64cc3ed3, Offset: 0x67da
    // Size: 0x68, Type: dev
    function function_b043eec4355295fe( intro, animent, var_ad84d7156e99d8aa )
    {
        animent endon( #"death" );
        self notifyonplayercommand( "<dev string:x91>", "<dev string:xa1>" );
        
        while ( true )
        {
            self waittill( #"hash_de716badcf5fe540" );
            intro.var_d511ee197fc9d1c9 thread animation::anim_single_solo( animent, var_ad84d7156e99d8aa );
        }
    }

#/

// Namespace reaper_drone
// Params 4
// Checksum 0xf93dff7f, Offset: 0x684a
// Size: 0x1ff
function reaperdrone_handlemissiledetection( player, missileteam, missiletarget, fxtagoverride )
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( !isdefined( missiletarget ) )
        {
            break;
        }
        
        center = missiletarget getpointinbounds( 0, 0, 0 );
        curdist = distance( self.origin, center );
        
        if ( curdist < 4000 && missiletarget.flaresreservecount > 0 )
        {
            if ( utility::issharedfuncdefined( #"flares", #"reducereserves" ) )
            {
                [[ utility::getsharedfunc( #"flares", #"reducereserves" ) ]]( missiletarget );
            }
            
            missiletarget thread function_951aecf306a376c3( fxtagoverride );
            missiletarget killstreak_utility::playkillstreakoperatordialog( "reaper_drone", "reaper_drone" + "_flares" );
            newtarget = undefined;
            
            if ( utility::issharedfuncdefined( #"flares", #"deploy" ) )
            {
                newtarget = missiletarget [[ utility::getsharedfunc( #"flares", #"deploy" ) ]]();
            }
            
            if ( utility::issharedfuncdefined( #"killstreak", #"hash_b5eddc2dc7204c48" ) )
            {
                missiletarget [[ utility::getsharedfunc( #"killstreak", #"hash_b5eddc2dc7204c48" ) ]]( player );
            }
            
            self missile_settargetent( newtarget );
            self notify( #"missile_pairedwithflare" );
            return;
        }
        else if ( curdist < 300 && missiletarget.flaresreservecount <= 0 )
        {
            missiletarget thread function_2fc1a601a7d46224();
            missiledamage = weapongetdamagemax( self.weapon_name, 0 );
            
            if ( isdefined( self.owner ) )
            {
                missiletarget dodamage( missiledamage, self.owner.origin, self.owner, self, "MOD_EXPLOSIVE", self.weapon_name );
            }
            
            self delete();
        }
        
        waitframe();
    }
}

// Namespace reaper_drone
// Params 0
// Checksum 0x6928290a, Offset: 0x6a51
// Size: 0x7f
function function_2fc1a601a7d46224()
{
    if ( !isdefined( self.missileexplcounter ) )
    {
        self.missileexplcounter = 0;
    }
    
    self.missileexplcounter++;
    
    if ( self.missileexplcounter > 4 )
    {
        self.missileexplcounter = 0;
    }
    
    self setscriptablepartstate( "fake_missile_expl_" + self.missileexplcounter, "on", 0 );
    self playsoundonmovingent( "iw8_ks_ac130_dist_rkt_explo" );
    wait 2;
    self setscriptablepartstate( "fake_missile_expl_" + self.missileexplcounter, "off", 0 );
}

// Namespace reaper_drone
// Params 1
// Checksum 0x1d2f9adb, Offset: 0x6ad8
// Size: 0x75
function function_951aecf306a376c3( fxtagoverride )
{
    flarestag = "tag_origin";
    
    if ( isdefined( fxtagoverride ) )
    {
        flarestag = fxtagoverride;
    }
    
    playsoundatpos( self gettagorigin( flarestag ), "ks_ac130_flares" );
    playfxontag( utility::getfx( "gunship_flares" ), self, flarestag );
    flaresgroup = self.flaresreservecount + 1;
    self setscriptablepartstate( "fake_flares_" + flaresgroup, "on", 0 );
}

// Namespace reaper_drone
// Params 0
// Checksum 0x70945063, Offset: 0x6b55
// Size: 0xc, Type: bool
function function_44abe13b81b00355()
{
    return isdefined( self.var_ca2c5f357feee551 );
}

// Namespace reaper_drone
// Params 0
// Checksum 0x1619e63c, Offset: 0x6b6a
// Size: 0x16c
function function_584d72f18f440169()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    wait 0.05;
    var_3fcbef5d8a13140e = self gettagorigin( "tag_light_l_wing" );
    self.leftwingfxent = spawn( "script_model", var_3fcbef5d8a13140e );
    self.leftwingfxent setmodel( "ks_gunship_mp" );
    self.leftwingfxent.angles = self.angles;
    self.leftwingfxent setotherent( self.owner );
    self.leftwingfxent linkto( self, "tag_light_l_wing", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_75ace1b29e67463 = self gettagorigin( "tag_light_r_wing" );
    self.rightwingfxent = spawn( "script_model", var_75ace1b29e67463 );
    self.rightwingfxent setmodel( "ks_gunship_mp" );
    self.rightwingfxent.angles = self.angles;
    self.rightwingfxent setotherent( self.owner );
    self.rightwingfxent linkto( self, "tag_light_r_wing", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    self setscriptablepartstate( "contrails", "on" );
}

/#

    // Namespace reaper_drone
    // Params 1
    // Checksum 0xd210cdcf, Offset: 0x6cde
    // Size: 0x57, Type: dev
    function function_6a0f11496b442f9a( wingfxent )
    {
        self endon( #"death" );
        level endon( #"game_ended" );
        
        while ( true )
        {
            sphere( wingfxent.origin, 100, ( 1, 0, 0 ), 0, 1 );
            wait 0.05;
        }
    }

#/

// Namespace reaper_drone
// Params 1
// Checksum 0x5e7362fe, Offset: 0x6d3d
// Size: 0x1eb
function function_d3055b11687af379( gunner )
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    level endon( #"game_ended" );
    gunner endon( #"disconnect" );
    hostmigration::waitlongdurationwithpause( 5 );
    
    while ( true )
    {
        visibletargets = [];
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) || !player player::isreallyalive() )
            {
                continue;
            }
            
            if ( self.owner worldpointinreticle_circle( player.origin, 80, 100 ) )
            {
                if ( level.teambased && player.team == self.team )
                {
                    continue;
                }
                
                if ( player == self.owner )
                {
                    continue;
                }
                
                if ( !killstreak_utility::streakcanseetarget( self.origin, player gettagorigin( "j_spineupper" ), self ) )
                {
                    continue;
                }
                
                if ( isdefined( player.perks[ "specialty_noscopeoutline" ] ) )
                {
                    continue;
                }
                
                visibletargets = function_cb3c9043c54f7c05( player );
                break;
            }
            
            wait 0.05;
        }
        
        if ( visibletargets.size > 0 && visibletargets.size < 2 )
        {
            gunner killstreak_utility::playkillstreakoperatordialog( "reaper_drone", "reaper_drone" + "_spotted_single_target" );
        }
        else if ( visibletargets.size >= 2 )
        {
            gunner killstreak_utility::playkillstreakoperatordialog( "reaper_drone", "reaper_drone" + "_spotted_single_multi" );
        }
        
        wait randomintrange( 5, 15 );
    }
}

// Namespace reaper_drone
// Params 1
// Checksum 0x1c9c1285, Offset: 0x6f30
// Size: 0xf1
function function_cb3c9043c54f7c05( maintarget )
{
    var_917c95ee81d4af40 = utility::playersinsphere( maintarget.origin, 300 );
    nearbytargets = [];
    
    foreach ( player in var_917c95ee81d4af40 )
    {
        if ( level.teambased && player.team != maintarget.team )
        {
            continue;
        }
        
        if ( !level.teambased && player == self.owner )
        {
            continue;
        }
        
        nearbytargets[ nearbytargets.size ] = player;
    }
    
    return nearbytargets;
}

// Namespace reaper_drone
// Params 1
// Checksum 0x93c690c0, Offset: 0x702a
// Size: 0xc8
function function_9642d4679b1de90b( gunner )
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    level endon( #"game_ended" );
    gunner endon( #"disconnect" );
    self.var_def1d41fdfcdaa7 = 0;
    childthread function_9ddecfcbfb48e56();
    childthread function_4ac9083ac2e1d773();
    
    while ( true )
    {
        if ( self.var_def1d41fdfcdaa7 != 0 )
        {
            wait 2;
            
            if ( self.var_def1d41fdfcdaa7 >= 1 )
            {
                killstreak_utility::playkillstreakoperatordialog( "reaper_drone", "reaper_drone" + "_hit_target" );
            }
            else
            {
                killstreak_utility::playkillstreakoperatordialog( "reaper_drone", "reaper_drone" + "_miss_target" );
            }
            
            self.var_def1d41fdfcdaa7 = 0;
            wait 1;
        }
        
        waitframe();
    }
}

// Namespace reaper_drone
// Params 0
// Checksum 0x4c377aa7, Offset: 0x70fa
// Size: 0x45
function function_9ddecfcbfb48e56()
{
    while ( true )
    {
        self.owner waittill( #"update_rapid_kill_buffered", recentkills, var_95795539e2a8343 );
        
        if ( isdefined( recentkills ) )
        {
            self.var_def1d41fdfcdaa7++;
        }
    }
}

// Namespace reaper_drone
// Params 0
// Checksum 0x1f485b99, Offset: 0x7147
// Size: 0x45
function function_4ac9083ac2e1d773()
{
    while ( true )
    {
        self.owner waittill( #"update_rapid_agent_kill_buffered", recentkills, var_bda53394c108f2e );
        
        if ( isdefined( recentkills ) )
        {
            self.var_def1d41fdfcdaa7++;
        }
    }
}

// Namespace reaper_drone
// Params 1
// Checksum 0xce755be2, Offset: 0x7194
// Size: 0x48
function reaperdrone_iskillstreakweapon( weaponname )
{
    bundle = level.streakglobals.streakbundles[ "reaper_drone" ];
    return weaponname == bundle.var_547f5a486c2b88c2 ? 1 : 0;
}

// Namespace reaper_drone
// Params 0
// Checksum 0xd984b05a, Offset: 0x71e5
// Size: 0x3a
function function_c118bc2f35c9879()
{
    largemap = game_utility::islargemap();
    
    /#
        crashtype = getdvarint( @"scr_reaper_drone_crash_type", 0 );
        
        if ( crashtype )
        {
            largemap = 1;
        }
    #/
    
    return largemap;
}

// Namespace reaper_drone
// Params 1
// Checksum 0x5e541d6c, Offset: 0x7228
// Size: 0xe9
function function_ee53d77e062d3e3c( boolean )
{
    if ( !boolean )
    {
        self.var_fe76501c7dfacddb = [];
        currentstance = self getstance();
        
        switch ( currentstance )
        {
            case #"hash_c6775c88e38f7803":
                self.var_fe76501c7dfacddb = [ "crouch", "prone" ];
                break;
            case #"hash_3fed0cbd303639eb":
                self.var_fe76501c7dfacddb = [ "stand", "prone" ];
                break;
            case #"hash_d91940431ed7c605":
                self.var_fe76501c7dfacddb = [ "stand", "crouch" ];
                break;
        }
        
        val::group_register( "reaperDroneStance", self.var_fe76501c7dfacddb );
        val::group_set( "reaperDroneStance", 0 );
        return;
    }
    
    val::group_reset( "reaperDroneStance" );
}

// Namespace reaper_drone
// Params 0
// Checksum 0xea56185a, Offset: 0x7319
// Size: 0x38
function function_1e63bf5796b367f4()
{
    self endon( #"death" );
    level waittill( #"game_ended" );
    level.var_83fb6ee584b8beee = arrayremove( level.var_83fb6ee584b8beee, self );
    self delete();
}

// Namespace reaper_drone
// Params 1
// Checksum 0xfb25b747, Offset: 0x7359
// Size: 0x48
function function_59442d7d61b3e688( ent )
{
    self endon( #"death" );
    ent utility::waittill_any( "leaving", "death" );
    level.var_83fb6ee584b8beee = arrayremove( level.var_83fb6ee584b8beee, self );
    self delete();
}

// Namespace reaper_drone
// Params 1
// Checksum 0x3a8a5b1d, Offset: 0x73a9
// Size: 0x82
function function_3a72eda142448092( owner )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"leaving" );
    owner endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        targetpos = function_3518f1459d1ea823( owner );
        
        if ( isdefined( targetpos ) )
        {
            self.hellfiretarget.origin = targetpos;
        }
        
        waitframe();
    }
}

// Namespace reaper_drone
// Params 1
// Checksum 0x39239312, Offset: 0x7433
// Size: 0x160
function function_32339595b51def( owner )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"leaving" );
    owner endon( #"disconnect" );
    level endon( #"game_ended" );
    var_9d4cd3ebc014321b = 65;
    lerptime = 0.2;
    currentfov = var_9d4cd3ebc014321b;
    var_410a4bdf33c3b252 = undefined;
    timeheld = 0;
    playedvision = 0;
    owner setclientomnvar( "ui_killstreak_zoom_fov", currentfov );
    
    while ( true )
    {
        if ( !isdefined( self.var_23b42a4928a6efbb ) )
        {
            waitframe();
            continue;
        }
        
        if ( owner adsbuttonpressed() )
        {
            timeheld += 0.05;
            
            if ( timeheld >= lerptime )
            {
                timeheld = lerptime;
            }
            
            if ( !playedvision )
            {
                owner killstreak_shared::function_8bd91ec764c0390b( "killstreak_ads_shutter" );
                playedvision = 1;
            }
        }
        else if ( timeheld > 0 )
        {
            timeheld -= 0.05;
            
            if ( timeheld <= 0 )
            {
                timeheld = 0;
            }
            
            if ( playedvision )
            {
                playedvision = 0;
            }
        }
        
        if ( timeheld >= 0 )
        {
            var_410a4bdf33c3b252 = self.var_23b42a4928a6efbb;
            timeperc = timeheld / lerptime * 100;
            currentfov = int( timeperc * ( var_410a4bdf33c3b252 - var_9d4cd3ebc014321b ) / 100 + var_9d4cd3ebc014321b );
        }
        
        owner setclientomnvar( "ui_killstreak_zoom_fov", currentfov );
        wait 0.05;
    }
}

// Namespace reaper_drone
// Params 1
// Checksum 0x654b0d5a, Offset: 0x759b
// Size: 0xaa
function function_3518f1459d1ea823( owner )
{
    content = [ "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicleclip" ];
    contentoverride = physics_createcontents( content );
    starttrace = owner getvieworigin();
    endtrace = starttrace + anglestoforward( owner getplayerangles() ) * 50000;
    ignoreents = owner killstreak_utility::playerkillstreakgetownerlookatignoreents();
    trace = trace::ray_trace( starttrace, endtrace, ignoreents, contentoverride );
    endpos = trace[ "position" ];
    return endpos;
}

// Namespace reaper_drone
// Params 1
// Checksum 0x5c697210, Offset: 0x764e
// Size: 0x83
function function_cd9d4d60ab41c1cd( targetweapon )
{
    self endon( #"death" );
    self notify( #"hash_f5dd06efce9b6011" );
    self endon( #"hash_f5dd06efce9b6011" );
    
    while ( true )
    {
        currentplayerweapon = self.owner getcurrentweapon();
        
        if ( isdefined( currentplayerweapon ) && currentplayerweapon.basename == targetweapon )
        {
            break;
        }
        
        waitframe();
    }
    
    self.var_23b42a4928a6efbb = self.owner playergetzoomfov();
}

// Namespace reaper_drone
// Params 3
// Checksum 0xf3844e60, Offset: 0x76d9
// Size: 0xb2
function function_81585929fd605305( reaperdrone, gunner, weaponbasename )
{
    reaperdrone endon( #"death" );
    reaperdrone endon( #"leaving" );
    reaperdrone endon( #"crashing" );
    gunner endon( #"disconnect" );
    self waittill( #"death" );
    bundle = level.streakglobals.streakbundles[ "reaper_drone" ];
    
    if ( weaponbasename == bundle.var_547f5a486c2b88c2 )
    {
        earthquake( 0.125, 0.5, reaperdrone.origin, 1000 );
    }
}

// Namespace reaper_drone
// Params 1
// Checksum 0x7b43c3b8, Offset: 0x7793
// Size: 0x21
function reaperdrone_empapplied( data )
{
    if ( isdefined( self ) )
    {
        reaperdrone_crash( self.owner );
    }
}

// Namespace reaper_drone
// Params 1
// Checksum 0xaf0993b7, Offset: 0x77bc
// Size: 0x2b7
function function_1b2d9ed48e57ceed( data )
{
    self endon( #"death" );
    self notify( #"hash_ec1f5ba1f79d360c" );
    self endon( #"hash_ec1f5ba1f79d360c" );
    self.owner endon( #"detach_reaper_drone_intro" );
    self.owner endon( #"returning_killstreak_player" );
    thread function_e3f892be073838d9();
    
    if ( !isdefined( self.var_fd125a9888e9226e ) && self.flaresreservecount > 0 )
    {
        self.var_fd125a9888e9226e = gettime();
        
        if ( utility::issharedfuncdefined( #"flares", #"reducereserves" ) )
        {
            [[ utility::getsharedfunc( #"flares", #"reducereserves" ) ]]( self );
        }
        
        thread function_951aecf306a376c3();
        
        if ( utility::issharedfuncdefined( #"flares", #"deploy" ) )
        {
            self [[ utility::getsharedfunc( #"flares", #"deploy" ) ]]();
        }
        
        if ( utility::issharedfuncdefined( #"killstreak", #"hash_b5eddc2dc7204c48" ) )
        {
            self [[ utility::getsharedfunc( #"killstreak", #"hash_b5eddc2dc7204c48" ) ]]( data.attacker );
        }
        
        if ( utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
        {
            data.attacker thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( "emped_killstreak" );
        }
        
        return;
    }
    
    if ( self.flaresreservecount > 0 && self.var_fd125a9888e9226e <= gettime() - 10000 )
    {
        self.var_fd125a9888e9226e = gettime();
        
        if ( utility::issharedfuncdefined( #"flares", #"reducereserves" ) )
        {
            [[ utility::getsharedfunc( #"flares", #"reducereserves" ) ]]( self );
        }
        
        thread function_951aecf306a376c3();
        
        if ( utility::issharedfuncdefined( #"flares", #"deploy" ) )
        {
            self [[ utility::getsharedfunc( #"flares", #"deploy" ) ]]();
        }
        
        if ( utility::issharedfuncdefined( #"killstreak", #"hash_b5eddc2dc7204c48" ) )
        {
            self [[ utility::getsharedfunc( #"killstreak", #"hash_b5eddc2dc7204c48" ) ]]( data.attacker );
        }
        
        if ( utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
        {
            data.attacker thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( "emped_killstreak" );
        }
    }
}

// Namespace reaper_drone
// Params 0
// Checksum 0x48a0166e, Offset: 0x7a7b
// Size: 0x153
function function_e3f892be073838d9()
{
    self.owner killstreak_utility::function_d546aaa588f088c3( self.streakname, "off" );
    result = utility::waittill_any_ents_or_timeout_return( 0.1, self.owner, "detach_reaper_drone_intro", self.owner, "returning_killstreak_player", self, "death" );
    
    if ( result != "timeout" || !isalive( self ) )
    {
        return;
    }
    
    self.owner killstreak_utility::function_d546aaa588f088c3( self.streakname, "on" );
    result = utility::waittill_any_ents_or_timeout_return( 0.05, self.owner, "detach_reaper_drone_intro", self.owner, "returning_killstreak_player", self, "death" );
    
    if ( result != "timeout" || !isalive( self ) )
    {
        return;
    }
    
    self.owner killstreak_utility::function_d546aaa588f088c3( self.streakname, "off" );
    result = utility::waittill_any_ents_or_timeout_return( 0.25, self.owner, "detach_reaper_drone_intro", self.owner, "returning_killstreak_player", self, "death" );
    
    if ( result != "timeout" || !isalive( self ) )
    {
        return;
    }
    
    self.owner killstreak_utility::function_d546aaa588f088c3( self.streakname, "on" );
}

/#

    // Namespace reaper_drone
    // Params 1
    // Checksum 0xf1f32d03, Offset: 0x7bd6
    // Size: 0xf0, Type: dev
    function function_6e121821bba5bdca( var_4bf214646074fa67 )
    {
        self endon( #"death" );
        self.owner endon( #"hash_aba435ef301219e1" );
        self.owner endon( #"hash_6c5280b5b2a221ab" );
        
        while ( true )
        {
            trace = trace::ray_trace( self.origin, self.origin - ( 0, 0, 40000 ), self );
            line( self.origin, trace[ "<dev string:xaa>" ], ( 1, 1, 1 ), 1, 0, 1 );
            sphere( var_4bf214646074fa67.origin, 50, ( 1, 1, 0 ), 0, 1 );
            self.owner iprintlnbold( "<dev string:xb3>" + distance( self.origin, trace[ "<dev string:xaa>" ] ) );
            waitframe();
        }
    }

    // Namespace reaper_drone
    // Params 2
    // Checksum 0x49db6314, Offset: 0x7cce
    // Size: 0x11c, Type: dev
    function function_ec72695e596cbde7( tagname, showaxis )
    {
        self endon( #"death" );
        
        while ( true )
        {
            debuglocation = self.origin;
            
            if ( isdefined( tagname ) )
            {
                debuglocation = self gettagorigin( tagname );
            }
            
            sphere( debuglocation, 100, ( 1, 1, 1 ), 0, 1 );
            
            if ( showaxis )
            {
                testforward = anglestoforward( self.angles );
                testright = anglestoright( self.angles );
                testup = anglestoup( self.angles );
                line( debuglocation, debuglocation + testforward * 1000, ( 1, 0, 0 ), 1, 0, 1 );
                line( debuglocation, debuglocation + testright * 1000, ( 0, 1, 0 ), 1, 0, 1 );
                line( debuglocation, debuglocation + testup * 1000, ( 0, 0, 1 ), 1, 0, 1 );
            }
            
            wait 0.05;
        }
    }

    // Namespace reaper_drone
    // Params 0
    // Checksum 0x1a01c318, Offset: 0x7df2
    // Size: 0x16d, Type: dev
    function function_eacdbedaac377668()
    {
        self endon( #"death" );
        self endon( #"leaving" );
        self endon( #"crashing" );
        self.owner notifyonplayercommand( "<dev string:xbe>", "<dev string:xdf>" );
        self.owner notifyonplayercommand( "<dev string:xe9>", "<dev string:x10b>" );
        self.owner notifyonplayercommand( "<dev string:xe9>", "<dev string:x115>" );
        self.flashlight notify( #"flashlight_on" );
        bundle = level.streakglobals.streakbundles[ "<dev string:x120>" ];
        weaponstocycle = [ bundle.var_547f5a486c2b88c2 ];
        currentdebugweaponindex = 0;
        currentdebugweapon = weaponstocycle[ 0 ];
        
        while ( true )
        {
            result = self.owner utility::waittill_any_return( "<dev string:xbe>", "<dev string:xe9>" );
            
            if ( !isdefined( result ) )
            {
                waitframe();
                continue;
            }
            
            if ( result == "<dev string:xbe>" )
            {
                currentdebugweaponindex++;
                
                if ( currentdebugweaponindex > 2 )
                {
                    currentdebugweaponindex = 0;
                }
                
                currentdebugweapon = weaponstocycle[ currentdebugweaponindex ];
                self.owner iprintlnbold( "<dev string:x12d>" + currentdebugweapon );
                continue;
            }
            
            shotgoal = function_12651f0dc948c8fd( self.owner );
            thread function_d3856d36f69b014e( shotgoal, currentdebugweapon );
        }
    }

    // Namespace reaper_drone
    // Params 1
    // Checksum 0xa7180536, Offset: 0x7f67
    // Size: 0x16, Type: dev
    function function_89192bb023df9b17( weapon )
    {
        return weaponfiretime( weapon );
    }

    // Namespace reaper_drone
    // Params 1
    // Checksum 0xd3d4a239, Offset: 0x7f85
    // Size: 0xa4, Type: dev
    function function_12651f0dc948c8fd( owner )
    {
        content = [ "<dev string:x148>", "<dev string:x161>", "<dev string:x17d>" ];
        contentoverride = physics_createcontents( content );
        starttrace = owner getvieworigin();
        endtrace = starttrace + anglestoforward( owner getplayerangles() ) * 50000;
        trace = trace::ray_trace( starttrace, endtrace, level.characters, contentoverride );
        endpos = trace[ "<dev string:xaa>" ];
        return endpos;
    }

    // Namespace reaper_drone
    // Params 2
    // Checksum 0x3f8590b5, Offset: 0x8031
    // Size: 0x198, Type: dev
    function function_d3856d36f69b014e( shotgoal, currentdebugweapon )
    {
        self endon( #"death" );
        self endon( #"leaving" );
        self endon( #"crashing" );
        self.owner endon( #"hash_aba435ef301219e1" );
        self.owner endon( #"hash_6c5280b5b2a221ab" );
        
        while ( true )
        {
            sphere( shotgoal, 10, ( 1, 1, 0 ), 0, 60 );
            self.owner iprintlnbold( "<dev string:x195>" + currentdebugweapon + "<dev string:x19d>" + shotgoal + "<dev string:x1a2>" + getweaponexplosionradius( currentdebugweapon ) );
            ammoleft = weaponmaxammo( currentdebugweapon );
            thread function_2d679c24b45f73c8( shotgoal );
            
            while ( ammoleft > 0 )
            {
                var_5a969db3aa4eb797 = undefined;
                
                if ( utility::issharedfuncdefined( #"gunship", #"getbombingpoint" ) )
                {
                    var_5a969db3aa4eb797 = [[ utility::getsharedfunc( #"gunship", #"getbombingpoint" ) ]]( shotgoal, 100 );
                }
                
                projectile = weapon_utility::_magicbullet( makeweapon( currentdebugweapon ), self.origin, var_5a969db3aa4eb797, self.owner );
                ammoleft--;
                
                if ( ammoleft == 0 )
                {
                    wait 1;
                    reloadtimer = level.weaponreloadtime[ currentdebugweapon ];
                    
                    while ( reloadtimer > 0 )
                    {
                        self.owner iprintlnbold( "<dev string:x1b4>" + currentdebugweapon );
                        reloadtimer--;
                        wait 1;
                    }
                }
                
                wait function_89192bb023df9b17( currentdebugweapon );
            }
        }
    }

    // Namespace reaper_drone
    // Params 1
    // Checksum 0x16bc2914, Offset: 0x81d1
    // Size: 0xaa, Type: dev
    function function_2d679c24b45f73c8( shotgoal )
    {
        self endon( #"death" );
        self endon( #"leaving" );
        self endon( #"crashing" );
        self.owner endon( #"hash_aba435ef301219e1" );
        self.owner endon( #"hash_6c5280b5b2a221ab" );
        
        while ( true )
        {
            self.flashlight.angles = vectortoangles( shotgoal - self.origin );
            line( self.origin, shotgoal, ( 1, 1, 1 ), 1, 0, 1 );
            waitframe();
        }
    }

    // Namespace reaper_drone
    // Params 0
    // Checksum 0x61aac008, Offset: 0x8283
    // Size: 0x5c, Type: dev
    function function_8e58fdff66733ac9()
    {
        self endon( #"death" );
        wait 10;
        data = damage_utility::packdamagedata( self.owner, self, 1, self.currentprimaryweapon, "<dev string:x1bf>", self );
        function_1b2d9ed48e57ceed( data );
        wait 10;
        function_1b2d9ed48e57ceed( data );
    }

#/
