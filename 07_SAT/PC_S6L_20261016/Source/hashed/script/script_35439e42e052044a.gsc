// script_35439e42e052044a  (hash_35439e42e052044a.gscc) (size: 4102 Bytes / 0x1006 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x71506221 (1901093409)
// size ...... 4102 (0x1006)
// includes .. 2   (offset: 0xdda)
// strings ... 23  (offset: 0xdea)
// dev strs .. 0   (offset: 0xf96)
// exports ... 8   (offset: 0x97e)
// cseg ...... 0x2c0 + 0x6be (0x97e)
// imports ... 25  (offset: 0xabe)
// animtree1 . 1   (offset: 0xf96)
// animtree2 . 6   (offset: 0xfa6)
#using scripts\common\scriptable;
#using scripts\mp\anim_scene;

#namespace namespace_f3c239118aea59ac;

// Namespace namespace_f3c239118aea59ac
// Params 0
// Checksum 0x6db8211b, Offset: 0x2de
// Size: 0x3c
function main()
{
    function_aca3937c689bb737();
    scriptable::scriptable_addusedcallbackbypart( "usable_left", &function_b4bae45cc0e61ecb );
    scriptable::scriptable_addusedcallbackbypart( "usable_right", &function_b4bae45cc0e61ecb );
    scriptable::scriptable_addusedcallbackbypart( "usable_front", &function_b4bae45cc0e61ecb );
}

// Namespace namespace_f3c239118aea59ac
// Params 3
// Checksum 0xbe0431fa, Offset: 0x322
// Size: 0x301
function function_f3c239118aea59ac( samsite, player, dir )
{
    level endon( #"game_ended" );
    samsite setscriptablepartstate( "usable_left", "unusable" );
    samsite setscriptablepartstate( "usable_front", "unusable" );
    samsite setscriptablepartstate( "usable_right", "unusable" );
    samsite.scenenode = spawnstruct();
    samsite.scenenode.origin = samsite.origin;
    samsite.scenenode.angles = samsite.angles;
    
    if ( isdefined( level.var_658bf7997c9582ee ) )
    {
        if ( isdefined( player ) )
        {
            player thread [[ level.var_658bf7997c9582ee ]]();
        }
    }
    
    actorplayer = anim_scene::anim_scene_create_actor( player, "player_rig_sm", 1 );
    c4 = spawn( "script_model", actorplayer.entity gettagorigin( "tag_accessory_right" ) );
    c4 hide();
    c4.angles = actorplayer.entity gettagangles( "tag_accessory_right" );
    c4 dontinterpolate();
    c4 linkto( actorplayer.entity, "tag_accessory_right" );
    
    if ( isdefined( level.var_7af19f06db8f07ab ) )
    {
        c4 setmodel( level.var_7af19f06db8f07ab );
    }
    else
    {
        c4 setmodel( "offhand_2h_c4_prop_cp" );
    }
    
    thread showc4( c4 );
    c4 thread function_e162c795b774fd62();
    
    if ( level.var_9a5624a6b320a884 )
    {
        player.var_656c75764302edc1 = 1;
    }
    
    if ( dir == "right" )
    {
        anim_scene_finished = samsite.scenenode anim_scene::anim_scene( [ actorplayer ], "samsite_plant_l" );
    }
    else if ( dir == "left" )
    {
        anim_scene_finished = samsite.scenenode anim_scene::anim_scene( [ actorplayer ], "samsite_plant_r" );
    }
    else
    {
        anim_scene_finished = samsite.scenenode anim_scene::anim_scene( [ actorplayer ], "samsite_plant_f" );
    }
    
    if ( level.var_9a5624a6b320a884 )
    {
        player.var_656c75764302edc1 = 0;
        c4.var_70cd500a8c9cc0b5 = anim_scene_finished;
    }
    
    c4 unlink();
    actorplayer = undefined;
    
    if ( isdefined( level.var_befa6e0ff93e696f ) )
    {
        if ( isdefined( player ) )
        {
            player thread [[ level.var_befa6e0ff93e696f ]]();
        }
    }
    
    if ( isdefined( level.var_dc5319508ce3eabe ) )
    {
        detonate_success = [[ level.var_dc5319508ce3eabe ]]( c4, samsite, player );
        
        if ( !detonate_success )
        {
            c4 hide();
            return;
        }
    }
    else
    {
        function_a28c172366fab605( c4 );
    }
    
    c4 setscriptablepartstate( "effects", "explode" );
    
    if ( isdefined( level.var_f77217549447c32 ) )
    {
        if ( isdefined( player ) )
        {
            player thread [[ level.var_f77217549447c32 ]]();
        }
    }
    
    wait 0.5;
    c4 delete();
}

// Namespace namespace_f3c239118aea59ac
// Params 0
// Checksum 0x89eef884, Offset: 0x62b
// Size: 0x1c
function function_e162c795b774fd62()
{
    wait 1;
    
    if ( soundexists( "weap_samsite_plant_c4" ) )
    {
        self playsound( "weap_samsite_plant_c4" );
    }
}

// Namespace namespace_f3c239118aea59ac
// Params 1
// Checksum 0x3f0b5b6a, Offset: 0x64f
// Size: 0x23
function showc4( c4 )
{
    c4 endon( #"death" );
    wait 1;
    c4 show();
}

// Namespace namespace_f3c239118aea59ac
// Params 6
// Checksum 0x817a1e9e, Offset: 0x67a
// Size: 0x7c
function function_b4bae45cc0e61ecb( instance, part, state, player, bautouse, usestring )
{
    dir = "left";
    
    if ( part == "usable_right" )
    {
        dir = "right";
    }
    else if ( part == "usable_front" )
    {
        dir = "front";
    }
    
    function_f3c239118aea59ac( instance, player, dir );
}

// Namespace namespace_f3c239118aea59ac
// Params 1
// Checksum 0xa5c66616, Offset: 0x6fe
// Size: 0x13b
function function_a28c172366fab605( c4 )
{
    currenttime = gettime();
    bombendtime = int( currenttime + 5000 );
    var_f4f3f0356fef8102 = bombendtime - currenttime;
    
    while ( var_f4f3f0356fef8102 > 0 )
    {
        currenttime = gettime();
        var_f4f3f0356fef8102 = bombendtime - currenttime;
        
        if ( var_f4f3f0356fef8102 < 1500 )
        {
            if ( var_f4f3f0356fef8102 <= 250 )
            {
                if ( soundexists( "breach_warning_beep_05" ) )
                {
                    c4 playsound( "breach_warning_beep_05" );
                }
            }
            else if ( var_f4f3f0356fef8102 < 500 )
            {
                if ( soundexists( "breach_warning_beep_04" ) )
                {
                    c4 playsound( "breach_warning_beep_04" );
                }
            }
            else if ( var_f4f3f0356fef8102 < 1500 )
            {
                if ( soundexists( "breach_warning_beep_03" ) )
                {
                    c4 playsound( "breach_warning_beep_03" );
                }
            }
            else if ( soundexists( "breach_warning_beep_02" ) )
            {
                c4 playsound( "breach_warning_beep_02" );
            }
            
            wait 0.25;
        }
        else if ( var_f4f3f0356fef8102 < 3500 )
        {
            if ( soundexists( "breach_warning_beep_02" ) )
            {
                c4 playsound( "breach_warning_beep_02" );
            }
            
            wait 0.5;
        }
        else
        {
            if ( soundexists( "breach_warning_beep_01" ) )
            {
                c4 playsound( "breach_warning_beep_01" );
            }
            
            wait 1;
        }
        
        if ( var_f4f3f0356fef8102 < 0 )
        {
            break;
        }
    }
}

#using_animtree( "script_model" );

// Namespace namespace_f3c239118aea59ac
// Params 0
// Checksum 0xde85e8d3, Offset: 0x841
// Size: 0x13d
function function_aca3937c689bb737()
{
    level.scr_animtree[ "player_rig_sm" ] = #animtree;
    level.scr_anim[ "player_rig_sm" ][ "samsite_plant_l" ] = %iw9_sam_breach_charge_left;
    level.scr_eventanim[ "player_rig_sm" ][ "samsite_plant_l" ] = %"iw9_sam_breach_charge_left";
    level.scr_anim[ "player_rig_sm" ][ "samsite_plant_r" ] = %iw9_sam_breach_charge_right;
    level.scr_eventanim[ "player_rig_sm" ][ "samsite_plant_r" ] = %"iw9_sam_breach_charge_right";
    level.scr_anim[ "player_rig_sm" ][ "samsite_plant_f" ] = %iw9_cp_sam_breach_charge_front;
    level.scr_eventanim[ "player_rig_sm" ][ "samsite_plant_f" ] = %"hash_7e94c3dd66a3eca0";
    level.scr_animtree[ "c4_prop" ] = #animtree;
    level.scr_anim[ "c4_prop" ][ "samsite_plant_l" ] = %iw9_cp_sam_breach_charge_left_c4;
    level.scr_anim[ "c4_prop" ][ "samsite_plant_r" ] = %iw9_cp_sam_breach_charge_right_c4;
    level.scr_anim[ "c4_prop" ][ "samsite_plant_f" ] = %iw9_cp_sam_breach_charge_front_c4;
}

