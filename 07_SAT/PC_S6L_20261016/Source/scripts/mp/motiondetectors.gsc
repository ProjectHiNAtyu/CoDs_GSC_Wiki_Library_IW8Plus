// scripts\mp\motiondetectors.gsc  (hash_3931ecb959834bbd.gscc) (size: 13662 Bytes / 0x355e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc62d6046 (3324862534)
// size ...... 13662 (0x355e)
// includes .. 6   (offset: 0x30b6)
// strings ... 68  (offset: 0x30e6)
// dev strs .. 0   (offset: 0x3506)
// exports ... 24  (offset: 0x2342)
// cseg ...... 0x876 + 0x1acc (0x2342)
// imports ... 77  (offset: 0x2702)
// animtree1 . 1   (offset: 0x3506)
// animtree2 . 4   (offset: 0x351e)
#using scripts\common\anim;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;

#namespace motiondetectors;

// Namespace motiondetectors
// Params 0
// Checksum 0x6236aeee, Offset: 0x894
// Size: 0x16e
function init()
{
    precachemodel( "uk_electrical_box_medium_02_animated" );
    precachemodel( "uk_storage_wall_light_01" );
    precachemodel( "uk_storage_wall_light_01_on" );
    precachemodel( "uk_industrial_light_01" );
    precachemodel( "uk_industrial_light_01_on" );
    precachemodel( "p7_lights_cagelight02" );
    precachemodel( "p7_lights_cagelight02_on" );
    precachemodel( "uk_lighting_interior_office_ceiling_tile_01" );
    precachemodel( "uk_lighting_interior_office_ceiling_tile_01_on" );
    precachemodel( "uk_industrial_light_01_runner_pm" );
    precachemodel( "uk_industrial_light_01_runner_pm_on" );
    precachemodel( "ind_flood_light_standing_tall" );
    precachemodel( "ind_flood_light_standing_tall_on" );
    precachemodel( "rogue_dormitory_lobby_ceiling_light_01" );
    precachemodel( "rogue_dormitory_lobby_ceiling_light_01_on" );
    precachemodel( "light_ceiling_bulb_02_spear_pm" );
    precachemodel( "light_ceiling_bulb_02_spear_pm_on" );
    precachemodel( "me_light_ceiling_fluorescent_tube_strong_runner_pm" );
    precachemodel( "me_light_ceiling_fluorescent_tube_strong_runner_pm_on" );
    precachemodel( "me_light_ceiling_fluorescent_tube_spear_pm" );
    precachemodel( "me_light_ceiling_fluorescent_tube_spear_pm_on" );
    precachemodel( "lighting_fixtures_security_lamp_withcage_01_spear_pm" );
    precachemodel( "lighting_fixtures_security_lamp_withcage_01_spear_pm_on" );
    precachemodel( "ee_light_mounted_exterior_industrial_caged_02_spear_pm" );
    precachemodel( "ee_light_mounted_exterior_industrial_caged_02_spear_pm_on" );
    precachemodel( "ee_light_mounted_exterior_industrial_caged_02_on_green_rnr_pm" );
    precachemodel( "building_cable_post_light_pole_off_spear_pm" );
    precachemodel( "building_cable_post_light_pole_on_spear_pm" );
    precachemodel( "ee_electronics_television_wall_mounted_large_runner_pm" );
    precachemodel( "ee_electronics_television_wall_mounted_large_runner_pm_on" );
    level._effect[ "vfx_nvg_flare" ] = loadfxasset( "vfx_iw8_mp_level_hackyard_nvg_flare" );
    level._effect[ "vfx_nvg_flare_light_250" ] = loadfxasset( "vfx_iw8_mp_level_hackyard_nvg_flare_light_250" );
    thread motiondetectors();
    script_model_anims();
}

#using_animtree( "script_model" );

// Namespace motiondetectors
// Params 0
// Checksum 0xf14b40d6, Offset: 0xa0a
// Size: 0x102
function script_model_anims()
{
    level.scr_animtree[ "lightswitch" ] = #animtree;
    level.scr_anim[ "lightswitch" ][ "interact" ] = %wm_eq_fusebox_plr;
    level.scr_eventanim[ "lightswitch" ][ "interact" ] = %"eq_fusebox_plr";
    level.scr_anim[ "lightswitch" ][ "interact_on" ] = %wm_eq_fusebox_turn_on_plr;
    level.scr_eventanim[ "lightswitch" ][ "interact_on" ] = %"eq_fusebox_turn_on_plr";
    level.scr_animtree[ "switch" ] = #animtree;
    level.scr_anim[ "switch" ][ "interact" ] = %wm_eq_fusebox_prop;
    level.scr_anim[ "switch" ][ "interact_on" ] = %wm_eq_fusebox_turn_on_prop;
    level.interactionanimlength = getanimlength( level.scr_anim[ "lightswitch" ][ "interact" ] );
}

// Namespace motiondetectors
// Params 0
// Checksum 0x4879628f, Offset: 0xb14
// Size: 0xa6
function motiondetectors()
{
    wait 5;
    volumes = getentarray( "md_volume", #script_noteworthy );
    
    foreach ( volume in volumes )
    {
        linkedcomponents = volume utility::get_target_array();
        volume thread motiondetectionproc( linkedcomponents );
    }
}

// Namespace motiondetectors
// Params 2
// Checksum 0xb59d7590, Offset: 0xbc2
// Size: 0xf2
function lightonroutine( delaystart, nvglights )
{
    wait delaystart;
    
    if ( self.code_classname == "light" )
    {
        if ( !isdefined( self.savedintensity ) )
        {
            finalintensity = 50;
        }
        else
        {
            finalintensity = self.savedintensity;
        }
        
        self setlightintensity( finalintensity * 0.7 );
        thread utility::play_sound_in_space( "mp_lights_int_on", self.origin );
        wait 0.1;
        thread utility::play_loop_sound_on_entity( "mp_lights_int_on_loop" );
        self setlightintensity( finalintensity * 0.1 );
        wait 0.05;
        self setlightintensity( finalintensity * 0.4 );
        wait 0.1;
        self setlightintensity( finalintensity * 0.2 );
        wait 0.15;
        self setlightintensity( finalintensity );
        return;
    }
    
    if ( self.code_classname == "scriptable" )
    {
        self setscriptablepartstate( "light", "light_on" );
    }
}

// Namespace motiondetectors
// Params 2
// Checksum 0xde934c08, Offset: 0xcbc
// Size: 0xea
function lightoffroutine( lights, nvglights )
{
    foreach ( light in lights )
    {
        if ( light.code_classname == "light" )
        {
            light setlightintensity( 0 );
            light thread utility::play_sound_in_space( "mp_lights_int_off", light.origin );
            light notify( "stop sound" + "mp_lights_int_on_loop" );
            continue;
        }
        
        if ( light.code_classname == "scriptable" )
        {
            light setscriptablepartstate( "light", "power_off" );
        }
    }
}

// Namespace motiondetectors
// Params 1
// Checksum 0x5a284e73, Offset: 0xdae
// Size: 0x6f2
function motiondetectionproc( components )
{
    level endon( #"game_ended" );
    struct = spawnstruct();
    struct.active = undefined;
    struct.masterswitches = [];
    struct.lights = [];
    struct.models = [];
    struct.nvglights = [];
    struct.switchstatus = "motion";
    struct.lightson = 0;
    struct.detection = 0;
    struct.triggerblind = undefined;
    
    foreach ( component in components )
    {
        if ( component.code_classname == "light" )
        {
            struct.lights[ struct.lights.size ] = component;
            continue;
        }
        
        if ( component.script_noteworthy == "masterSwitch" )
        {
            struct.masterswitches[ struct.masterswitches.size ] = component;
            continue;
        }
        
        if ( component.code_classname == "script_model" && !isdefined( component.script_parameters ) )
        {
            struct.models[ struct.models.size ] = component;
            continue;
        }
        
        if ( component.code_classname == "script_origin" )
        {
            struct.nvglights[ struct.nvglights.size ] = component;
            continue;
        }
        
        if ( component.script_label == "blinding_volume" )
        {
            struct.triggerblind = component;
        }
    }
    
    scriptablelights = getscriptablearray( self.target, #targetname );
    struct.lights = arraycombine( struct.lights, scriptablelights );
    
    foreach ( light in struct.lights )
    {
        if ( light.code_classname == "light" )
        {
            light.savedintensity = light getlightintensity();
            light setlightintensity( 0 );
            continue;
        }
        
        if ( light.code_classname == "scriptable" )
        {
            light setscriptablepartstate( "light", "power_off" );
        }
    }
    
    foreach ( lightswitch in struct.masterswitches )
    {
        lightswitch thread runlightswitch( self, struct );
    }
    
    foreach ( model in struct.models )
    {
        model.modelname = model.model;
    }
    
    if ( game_utility::getgametype() == "cyber" )
    {
        if ( !isdefined( level.emplights ) )
        {
            level.emplights = [];
        }
        
        level.emplights[ level.emplights.size ] = struct;
        
        if ( isdefined( level.emplightsoff ) )
        {
            level thread [[ level.emplightsoff ]]();
        }
    }
    
    thread onoffmodelswap( struct.models, "off" );
    thread motiondetectionstatus( struct );
    
    while ( true )
    {
        if ( struct.switchstatus == "on" )
        {
            self notify( #"masterswitch_on" );
            
            if ( !struct.lightson )
            {
                thread blindplayers( struct );
                
                foreach ( light in struct.lights )
                {
                    light thread lightonroutine( randomfloat( 0.2 ), struct.nvglights );
                }
                
                thread onoffmodelswap( struct.models, "on" );
                struct.lightson = 1;
            }
        }
        else if ( struct.switchstatus == "motion" )
        {
            if ( struct.detection && !struct.lightson )
            {
                thread blindplayers( struct );
                
                foreach ( light in struct.lights )
                {
                    light thread lightonroutine( randomfloat( 0.2 ), struct.nvglights );
                    struct.lightson = 1;
                }
                
                thread onoffmodelswap( struct.models, "on" );
                thread motiondetectioncooldown( struct );
            }
        }
        else if ( struct.switchstatus == "off" )
        {
            if ( struct.lightson )
            {
                level lightoffroutine( struct.lights, struct.nvglights );
                thread onoffmodelswap( struct.models, "off" );
                struct.lightson = 0;
            }
            
            if ( self.script_parameters == "motion" )
            {
                struct.switchstatus = "motion";
            }
            
            self notify( #"lights_off" );
        }
        
        wait 0.05;
    }
}

// Namespace motiondetectors
// Params 1
// Checksum 0x40406772, Offset: 0x14a8
// Size: 0x1d6
function blindplayers( struct )
{
    if ( isdefined( struct.triggerblind ) )
    {
        wait 0.4;
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) || !player::isreallyalive( player ) )
            {
                continue;
            }
            
            if ( player istouching( struct.triggerblind ) )
            {
                player activatenightvisionblind();
                continue;
            }
            
            foreach ( light in struct.lights )
            {
                if ( distancesquared( light.origin, player.origin ) > 230400 )
                {
                    continue;
                }
                
                if ( !utility::within_fov( player geteye(), player getplayerangles(), light.origin, 0.707106 ) )
                {
                    continue;
                }
                
                trace = trace::ray_trace( player geteye(), light.origin, undefined, trace::create_default_contents( 1 ) );
                
                if ( distancesquared( trace[ "position" ], light.origin ) <= 324 )
                {
                    player activatenightvisionblind();
                    break;
                }
            }
        }
    }
}

// Namespace motiondetectors
// Params 1
// Checksum 0xaa9c8b4f, Offset: 0x1686
// Size: 0xbc
function nameplatemanagement( struct )
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( struct.lightson == 0 )
        {
            foreach ( player in level.players )
            {
                if ( player istouching( self ) )
                {
                    player thread manageplayerindarkvolume( self, struct );
                }
            }
        }
        
        wait 0.1;
    }
}

// Namespace motiondetectors
// Params 2
// Checksum 0x22975bac, Offset: 0x174a
// Size: 0x8c
function manageplayerindarkvolume( volume, struct )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( isdefined( self.indarkvolume ) )
    {
        return;
    }
    
    perk::giveperk( "specialty_spygame" );
    self.indarkvolume = 1;
    
    while ( self istouching( volume ) && struct.lightson == 0 )
    {
        wait 0.1;
    }
    
    perk::removeperk( "specialty_spygame" );
    self.indarkvolume = undefined;
}

// Namespace motiondetectors
// Params 1
// Checksum 0x6aff3d25, Offset: 0x17de
// Size: 0x105
function motiondetectionstatus( struct )
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        struct.detection = 0;
        
        foreach ( player in level.players )
        {
            if ( player istouching( self ) )
            {
                if ( player getstance() == "stand" && length2d( player getvelocity() ) > 40 )
                {
                    struct.detection = 1;
                    struct.cooldown = 4;
                }
                
                if ( struct.lightson )
                {
                    player.inmotionlight = 1;
                }
            }
        }
        
        wait 0.05;
    }
}

// Namespace motiondetectors
// Params 1
// Checksum 0xc972abe2, Offset: 0x18eb
// Size: 0x89
function motiondetectioncooldown( struct )
{
    level endon( #"game_ended" );
    self endon( #"lights_off" );
    self endon( #"masterswitch_on" );
    
    if ( self.script_parameters == "motion" )
    {
        while ( struct.cooldown > 0 )
        {
            wait 0.1;
            struct.cooldown -= 0.1;
        }
    }
    
    struct.switchstatus = "off";
}

// Namespace motiondetectors
// Params 2
// Checksum 0x468c0d3b, Offset: 0x197c
// Size: 0x46
function runlightswitch( volume, struct )
{
    level endon( #"game_ended" );
    lightswitch = createlightswitchtrigger( volume, struct );
    
    if ( isdefined( lightswitch ) )
    {
        lightswitch thread watchlightswitchuse( struct );
    }
}

// Namespace motiondetectors
// Params 2
// Checksum 0xb28d7fc7, Offset: 0x19ca
// Size: 0x323
function createlightswitchtrigger( volume, struct )
{
    switchtrigger = spawn( "script_model", self.origin, 40, 0, 60 );
    switchtrigger setmodel( "uk_electrical_box_medium_02_animated" );
    switchtrigger.angles = self.angles;
    
    if ( self.script_parameters == "motion" )
    {
        return;
    }
    
    childparts = utility::get_target_array();
    
    foreach ( part in childparts )
    {
        if ( part.code_classname == "script_origin" )
        {
            if ( part.script_noteworthy == "sceneNode" )
            {
                switchtrigger.scenenode = part;
            }
            else
            {
                switchtrigger.hintlightmodel = spawn( "script_model", part.origin );
                switchtrigger.hintlightmodel.angles = part.angles;
                switchtrigger.hintlightmodel setmodel( part.script_noteworthy );
                switchtrigger.hintlightmodel.modelname = part.script_noteworthy;
            }
            
            continue;
        }
        
        if ( part.code_classname == "light" )
        {
            switchtrigger.hintlight = part;
        }
    }
    
    if ( utility::isnightmap() )
    {
        switchtrigger makeusable();
        switchtrigger setusepriority( 0 );
        switchtrigger setuserange( 80 );
        switchtrigger sethintdisplayrange( 200 );
        switchtrigger setusefov( 120 );
        switchtrigger sethintdisplayfov( 120 );
        switchtrigger setcursorhint( "HINT_BUTTON" );
        
        if ( !game_utility::function_d3f8957534dc62af() )
        {
            switchtrigger sethintstring( &"mp/light_switch" );
            switchtrigger sethinticon( "icon_electrical_box" );
        }
    }
    
    if ( volume.script_parameters == "motion" )
    {
        struct.switchstatus = "motion";
    }
    else
    {
        struct.switchstatus = "off";
    }
    
    foreach ( player in level.players )
    {
        switchtrigger enableplayeruse( player );
    }
    
    if ( isdefined( switchtrigger.hintlightmodel ) && isdefined( switchtrigger.hintlight ) )
    {
        switchtrigger.hintlightcolor = switchtrigger.hintlight getlightintensity();
        switchtrigger thread manageswitchhintlight( struct );
    }
    
    return switchtrigger;
}

// Namespace motiondetectors
// Params 1
// Checksum 0x5e4e3ed, Offset: 0x1cf6
// Size: 0xe0
function watchlightswitchuse( struct )
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( isdefined( struct.switchstatus ) && struct.switchstatus == "on" )
        {
            playsoundatpos( self.origin, "mp_fusebox_lever_off_npc" );
        }
        else
        {
            playsoundatpos( self.origin, "mp_fusebox_lever_on_npc" );
        }
        
        thread swapswitchstatus( getanimlength( level.scr_anim[ "lightswitch" ][ "interact" ] ) - 0.15, struct );
        success = lightswitchinteraction( player, struct );
        
        if ( !success )
        {
            self notify( #"interactioncancelled" );
        }
    }
}

// Namespace motiondetectors
// Params 2
// Checksum 0x783b7896, Offset: 0x1dde
// Size: 0x7e
function swapswitchstatus( waittime, struct )
{
    self endon( #"interactioncancelled" );
    wait waittime;
    
    if ( struct.switchstatus == "motion" || struct.switchstatus == "off" )
    {
        struct.switchstatus = "on";
        self notify( #"masterswitch_on" );
        return;
    }
    
    struct.switchstatus = "off";
}

// Namespace motiondetectors
// Params 1
// Checksum 0x479541ba, Offset: 0x1e64
// Size: 0xa6
function manageswitchhintlight( struct )
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( struct.switchstatus == "on" )
        {
            self.hintlight setlightintensity( 0 );
            self.hintlightmodel setmodel( self.hintlightmodel.modelname );
        }
        else
        {
            self.hintlight setlightintensity( self.hintlightcolor );
            self.hintlightmodel setmodel( self.hintlightmodel.modelname + "_on" );
        }
        
        waitframe();
    }
}

// Namespace motiondetectors
// Params 1
// Checksum 0x889e35a8, Offset: 0x1f12
// Size: 0x94
function getlightswitchstatus( switches )
{
    foreach ( lightswitch in switches )
    {
        if ( lightswitch.switchstatus == "on" )
        {
            return "on";
        }
    }
    
    return "motion";
}

// Namespace motiondetectors
// Params 2
// Checksum 0x6faa2111, Offset: 0x1faf
// Size: 0xd5
function onoffmodelswap( models, state )
{
    foreach ( model in models )
    {
        if ( state == "on" )
        {
            model setmodel( model.modelname + "_on" );
            continue;
        }
        
        model setmodel( model.modelname );
        
        if ( isdefined( model.flare ) )
        {
            model.flare delete();
        }
    }
}

// Namespace motiondetectors
// Params 2
// Checksum 0x3e971d7, Offset: 0x208c
// Size: 0xab, Type: bool
function lightswitchinteraction( player, struct )
{
    animname = struct.switchstatus == "on" ? "interact" : "interact_on";
    self.animname = "switch";
    self useanimtree( #animtree );
    self.scenenode thread animation::anim_single_solo( self, animname );
    animlength = getanimlength( level.scr_anim[ "lightswitch" ][ animname ] );
    wait animlength;
    setdvar( @"depthsortviewmodel", 0 );
    self notify( #"interaction_complete" );
    return true;
}

// Namespace motiondetectors
// Params 1
// Checksum 0x17d405da, Offset: 0x2140
// Size: 0x4d
function watchplayerdeath( player )
{
    self endon( #"interaction_complete" );
    self.cancelinteraction = 0;
    
    while ( true )
    {
        if ( !isdefined( player ) || !player::isreallyalive( player ) )
        {
            self.cancelinteraction = 1;
            break;
        }
        
        waitframe();
    }
}

// Namespace motiondetectors
// Params 3
// Checksum 0x8705d5a8, Offset: 0x2195
// Size: 0xed
function create_player_rig( player, animname, rig_model )
{
    if ( !isdefined( player ) || isdefined( player.player_rig ) )
    {
        return;
    }
    
    player.animname = animname;
    
    if ( !isdefined( rig_model ) )
    {
        rig_model = "viewhands_base_iw8";
    }
    
    player.player_rig = spawn( "script_model", player.origin );
    player.player_rig setmodel( rig_model );
    player.player_rig hide();
    player.player_rig.animname = animname;
    player.player_rig useanimtree( #animtree );
    player playerlinktodelta( player.player_rig, "tag_player", 1, 0, 0, 0, 0, 0, 0 );
    player watch_remove_rig();
    remove_player_rig( player );
}

// Namespace motiondetectors
// Params 1
// Checksum 0x61580d59, Offset: 0x228a
// Size: 0x93
function remove_player_rig( player )
{
    if ( !( isdefined( player ) && isdefined( player.player_rig ) ) )
    {
        return;
    }
    
    player unlink();
    droppos = player getdroptofloorposition( player.origin );
    
    if ( isdefined( droppos ) )
    {
        player setorigin( droppos );
    }
    else
    {
        player setorigin( player.origin + ( 0, 0, 100 ) );
    }
    
    player.player_rig delete();
    player.player_rig = undefined;
}

// Namespace motiondetectors
// Params 1
// Checksum 0x70be7da5, Offset: 0x2325
// Size: 0x1d
function watch_remove_rig( struct )
{
    utility::waittill_any( "remove_rig", "death_or_disconnect" );
}

