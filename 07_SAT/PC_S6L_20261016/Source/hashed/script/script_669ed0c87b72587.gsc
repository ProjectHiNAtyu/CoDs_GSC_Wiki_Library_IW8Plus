// script_669ed0c87b72587  (hash_0669ed0c87b72587.gscc) (size: 9831 Bytes / 0x2667 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xacabdf96 (2896945046)
// size ...... 9831 (0x2667)
// includes .. 22  (offset: 0x237f)
// strings ... 35  (offset: 0x242f)
// dev strs .. 1   (offset: 0x265b)
// exports ... 15  (offset: 0x160b)
// cseg ...... 0x2c5 + 0x1346 (0x160b)
// imports ... 94  (offset: 0x1863)
// animtree1 . 0   (offset: 0x2667)
// animtree2 . 0   (offset: 0x2667)
#using script_2528fc84e11f3e4b;
#using scripts\anim\utility;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\activity_nexus\activity_player_broadcasting;
#using scripts\common\activity_nexus\activity_scriptables;
#using scripts\common\callbacks;
#using scripts\common\scriptable;
#using scripts\common\spatial_zone_container;
#using scripts\common\system;
#using scripts\mp\airdrop_scriptbundle;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_currency;
#using scripts\mp\objidpoolmanager;

#namespace activity_blight_upload;

// Namespace activity_blight_upload
// Params 0, eflags: 0x5
// Checksum 0xee4eae1f, Offset: 0x2e3
// Size: 0x33
function private autoexec __init__system__()
{
    system::register( #"activity_blight_upload", [ #"activity_common", #"hash_7bed02019e6c9db3" ], &function_2e8a5c986bf29933, undefined );
}

// Namespace activity_blight_upload
// Params 0, eflags: 0x4
// Checksum 0xeda72fa3, Offset: 0x31e
// Size: 0x13
function private function_2e8a5c986bf29933()
{
    activity_common::registeractivitytype( "BLIGHT_UPLOAD", &activity_type_init );
}

// Namespace activity_blight_upload
// Params 0
// Checksum 0x9a8d04, Offset: 0x339
// Size: 0xa8
function activity_type_init()
{
    if ( getdvarint( @"hash_ef8050e290993338", 0 ) )
    {
        return;
    }
    
    activity_common::function_944074f3079c1d4e( "BLIGHT_UPLOAD", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "BLIGHT_UPLOAD", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "BLIGHT_UPLOAD", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "BLIGHT_UPLOAD", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "BLIGHT_UPLOAD" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &player_left_activity, "BLIGHT_UPLOAD" );
    scriptable::scriptable_addusedcallbackbypart( "saw_blight_upload_interact", &function_881d1393eeed1daf );
    airdrop_scriptbundle::registerairdrop( "saw_airdrop_blight_vehicle" );
}

// Namespace activity_blight_upload
// Params 0
// Checksum 0x63bfb045, Offset: 0x3e9
// Size: 0x113
function activity_setup()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    namespace_80082437c22b4d6e::setup_participation_conditions( self );
    self.interact_struct = activity_instance_common::function_c78d8509d1f980d4( self, 0, "upload_interact" )[ 0 ];
    self.defend_struct = activity_instance_common::function_c78d8509d1f980d4( self, 0, "upload_defend_location" )[ 0 ];
    self.reward_struct = activity_instance_common::function_c78d8509d1f980d4( self, 0, "reward_location" )[ 0 ];
    self.upload_duration = getdvarint( @"hash_595bc74b24b251b7", 30 );
    self.abandon_time = getdvarint( @"hash_521cbfa80dbe36e4", 60 );
    self.var_d9fc2fc236987ab7 = getdvarint( @"hash_3b4dfbd96b2bbb86", 1 ) != 0;
    self.var_e3c28a4b3bfc5016 = getdvarint( @"hash_d8b4ea7abf30fe31", 100 );
    self.var_2e97f5b0db9f2142 = "upload_join";
    
    if ( !level callback::exists( #"player_death", &on_player_killed ) )
    {
        level callback::add( #"player_death", &on_player_killed );
    }
    
    namespace_9085ae059032a84f::function_16b3cfd89a1669f7( 2, self );
}

// Namespace activity_blight_upload
// Params 0
// Checksum 0xaa03fdfd, Offset: 0x504
// Size: 0x84d
function function_477932e3884ea1fd()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    namespace_9085ae059032a84f::function_16b3cfd89a1669f7( 1, self );
    laptop = spawnscriptable( "saw_blight_upload_interact", self.interact_struct.origin, self.interact_struct.angles );
    laptop.activity_instance = self;
    self.laptop = laptop;
    activity_scriptables::function_114d59757e8d7bd9( self, laptop, "ActivityEnd" );
    self.defend_fx = spawnscriptable( "saw_blight_upload_fx", self.defend_struct.origin, self.defend_struct.angles );
    activity_scriptables::function_114d59757e8d7bd9( self, self.defend_fx, "ActivityEnd" );
    upload_marker_id = create_objective_icon( self.defend_struct.origin + ( 0, 0, 98 ) );
    self.upload_marker_id = upload_marker_id;
    find_marker_id = create_objective_icon( laptop.origin + ( 0, 0, 25 ) );
    self.find_marker_id = find_marker_id;
    spatial_zone_container::function_847140d2863dfbf8( self, "upload_range", self.defend_struct.origin, 256 );
    self.var_fc34ba2af1bf33a4 = [];
    spatial_zone_container::function_3b687b8681411c9f( self, "upload_range", &function_5b642b75d27ebb2a, 0.5 );
    centered_position = activity_instance_common::function_776ee11e7acc64a5( self );
    namespace_80082437c22b4d6e::function_b9c4b4277cfc19bf( self, "sat_ui_icon_zm_haunting_uplink_phone_ping", centered_position, &"hash_44d0353e1d4a8efd" );
    namespace_80082437c22b4d6e::function_dab60f070f92291e( self );
    self.var_98273f946a00c9b5 = {};
    self.var_98273f946a00c9b5 game_utility::questcircle_create( "BlightUpload_Br", self.defend_struct.origin, 256 );
    
    while ( true )
    {
        laptop.uploading = 0;
        laptop setscriptablepartstate( "saw_blight_upload_interact", "usable" );
        laptop setscriptablepartstate( "fx", "idle" );
        function_829aad917b9ff5f0( self );
        self.defend_fx setscriptablepartstate( "vfx", "disabled" );
        self.defend_fx setscriptablepartstate( "sfx", "disabled" );
        
        foreach ( player in self.playerparticipants )
        {
            objective_addclienttomask( self.find_marker_id, player );
        }
        
        objective_showtoplayersinmask( self.find_marker_id );
        self.widget_step = 0;
        widget_params = { #var_cf684f09b6c37c3a:0, #current_progress:0, #step_index:self.widget_step };
        namespace_80082437c22b4d6e::function_5cdac4ed52d48636( self, widget_params );
        namespace_80082437c22b4d6e::function_57e8668265b07078( self, 0 );
        
        if ( self.var_98273f946a00c9b5 )
        {
            self.var_98273f946a00c9b5 game_utility::questcircle_hidefromall();
        }
        
        self waittill( #"laptop_activated" );
        self.var_f7e049347883d1ee = activity_ai_encounters::function_eb8506829193f5eb( "ai_encounter:saw_blight_ai_encounter_upload", self.defend_struct.origin, 1000, 1, 0, 1, 1 );
        activity_ai_encounters::function_52d1342183200a8f( self.var_f7e049347883d1ee, &namespace_80082437c22b4d6e::function_77688a5e67bd527f, { #activity_instance:self } );
        activity_player_broadcasting::function_cb4750c84882dd07( "upload_activate" );
        objective_removeallfrommask( self.find_marker_id );
        laptop function_7653c765b6c7b815();
        laptop setscriptablepartstate( "saw_blight_upload_interact", "unusable" );
        laptop setscriptablepartstate( "fx", "in_progress" );
        
        foreach ( player in self.playerparticipants )
        {
            objective_addclienttomask( self.upload_marker_id, player );
        }
        
        objective_showtoplayersinmask( self.upload_marker_id );
        
        if ( self.var_98273f946a00c9b5 )
        {
            foreach ( player in self.playerparticipants )
            {
                self.var_98273f946a00c9b5 game_utility::questcircle_showtoplayer( player );
            }
        }
        
        self.defend_fx setscriptablepartstate( "vfx", "enabled" );
        elapsed_upload = 0;
        elapsed_paused = 0;
        
        while ( elapsed_upload < self.upload_duration )
        {
            wait 0.5;
            human_in_range = 0;
            
            foreach ( player in self.var_fc34ba2af1bf33a4 )
            {
                if ( player.team == "allies" && isalive( player ) )
                {
                    human_in_range = 1;
                    
                    if ( self.defend_fx getscriptablepartstate( "sfx" ) != "progress" )
                    {
                        self.defend_fx setscriptablepartstate( "sfx", "progress" );
                    }
                    
                    break;
                }
            }
            
            if ( human_in_range )
            {
                elapsed_upload += 0.5;
                elapsed_paused = 0;
            }
            else
            {
                elapsed_paused += 0.5;
                
                if ( self.playerparticipants.size == 0 )
                {
                    if ( elapsed_paused >= self.abandon_time / 2 )
                    {
                        break;
                    }
                }
                else if ( elapsed_paused >= self.abandon_time )
                {
                    break;
                }
                
                if ( self.defend_fx getscriptablepartstate( "sfx" ) != "stalled" )
                {
                    self.defend_fx setscriptablepartstate( "sfx", "stalled" );
                }
            }
            
            widget_params = { #var_cf684f09b6c37c3a:100, #current_progress:max( 1, int( elapsed_upload / self.upload_duration * 100 ) ), #step_index:self.widget_step };
            namespace_80082437c22b4d6e::function_5cdac4ed52d48636( self, widget_params );
        }
        
        objective_removeallfrommask( self.upload_marker_id );
        
        if ( elapsed_upload >= self.upload_duration )
        {
            activity_player_broadcasting::function_cb4750c84882dd07( "upload_complete" );
            reward = airdrop_scriptbundle::startairdrop( "saw_airdrop_blight_vehicle", undefined, "allies", { #droporigin:self.reward_struct.origin } );
            
            foreach ( player in self.playerparticipants )
            {
                player calloutmarkerping::function_81aa43aad6e47820( reward[ 0 ] getentitynumber() );
            }
            
            if ( self.var_d9fc2fc236987ab7 )
            {
                spawn_options = common_item::items_initspawnoptions_spawnfromposition( self.defend_struct.origin );
                item_name = item_currency::function_a3eadb2d3c329589( "dna_sample", self.var_e3c28a4b3bfc5016 );
                common_item::function_57b88e025e5fb03e( item_name, self.var_e3c28a4b3bfc5016, spawn_options );
            }
            
            activity_instance_common::endactivity( self, 1 );
        }
        
        activity_ai_encounters::function_46dadc3aca2ffac0( self.var_f7e049347883d1ee );
        
        /#
            iprintlnbold( "<dev string:x24>" );
        #/
    }
}

// Namespace activity_blight_upload
// Params 1
// Checksum 0x58aff028, Offset: 0xd59
// Size: 0x146
function activity_ended( activity_succeeded )
{
    if ( spatial_zone_container::function_3819f09eefb741e2( self, "upload_range" ) )
    {
        spatial_zone_container::function_4f9fccd04a537897( self, "upload_range" );
    }
    
    if ( activity_instance_common::function_6bb0be4a3940d6e3( self ) )
    {
        foreach ( player in self.playerparticipants )
        {
            player thread points::doscoreevent( #"hash_f73986bb3b605666" );
            challenges::function_37e945722d6497f3( player, "gametype_blight_activity_complete", 1 );
        }
    }
    
    if ( isdefined( self.find_marker_id ) && self.find_marker_id != -1 )
    {
        objidpoolmanager::objective_playermask_hidefromall( self.find_marker_id );
        objidpoolmanager::returnobjectiveid( self.find_marker_id );
    }
    
    if ( isdefined( self.upload_marker_id ) && self.upload_marker_id != -1 )
    {
        objidpoolmanager::objective_playermask_hidefromall( self.upload_marker_id );
        objidpoolmanager::returnobjectiveid( self.upload_marker_id );
    }
    
    namespace_80082437c22b4d6e::function_36af27abcca0df47( self );
}

// Namespace activity_blight_upload
// Params 0
// Checksum 0x554c66fc, Offset: 0xea7
// Size: 0x43
function function_d4acef179eb9f9b2()
{
    if ( spatial_zone_container::function_3819f09eefb741e2( self, "upload_range" ) )
    {
        spatial_zone_container::function_4f9fccd04a537897( self, "upload_range" );
    }
    
    if ( isdefined( self.var_98273f946a00c9b5 ) )
    {
        self.var_98273f946a00c9b5 game_utility::questcircle_delete();
    }
    
    namespace_80082437c22b4d6e::function_b25797193ea9d9db( self );
}

// Namespace activity_blight_upload
// Params 1, eflags: 0x4
// Checksum 0x69b8fcc3, Offset: 0xef2
// Size: 0xa5
function private function_5b642b75d27ebb2a( callbackargs )
{
    player = callbackargs.player;
    
    if ( callbackargs.enteredzone )
    {
        self.var_fc34ba2af1bf33a4[ self.var_fc34ba2af1bf33a4.size ] = player;
        
        if ( player.team == "allies" && !activity_participation::function_e7fc1202ac164928( self, player ) )
        {
            activity_participation::function_bc67362dace4370c( self, player );
        }
        
        return;
    }
    
    self.var_fc34ba2af1bf33a4 = arrayremove( self.var_fc34ba2af1bf33a4, player );
    self.var_fc34ba2af1bf33a4 = function_5713d46873b29625( self.var_fc34ba2af1bf33a4 );
}

// Namespace activity_blight_upload
// Params 1, eflags: 0x4
// Checksum 0x72666ca, Offset: 0xf9f
// Size: 0xbe
function private function_829aad917b9ff5f0( activity_instance )
{
    laptop = activity_instance.laptop;
    
    if ( !isdefined( laptop ) || laptop.uploading )
    {
        return;
    }
    
    laptop function_7653c765b6c7b815();
    
    foreach ( player in teams::getteamdata( "allies", "players" ) )
    {
        laptop enablescriptableplayeruse( player );
    }
}

// Namespace activity_blight_upload
// Params 1
// Checksum 0x4b048eb, Offset: 0x1065
// Size: 0x198
function player_joined_activity( relevant_info_struct )
{
    if ( !isdefined( self.laptop ) )
    {
        return;
    }
    
    foreach ( player in relevant_info_struct.playerlist )
    {
        if ( !self.laptop.uploading && player.team == "allies" && self.laptop getscriptablepartstate( "saw_blight_upload_interact" ) == "usable" )
        {
            self.laptop enablescriptableplayeruse( player );
            
            if ( self.find_marker_id )
            {
                objidpoolmanager::objective_playermask_addshowplayer( self.find_marker_id, player );
            }
        }
        
        namespace_80082437c22b4d6e::function_10f2ad982e66d1b( self, player );
        
        if ( self.laptop.uploading )
        {
            if ( self.upload_marker_id )
            {
                objidpoolmanager::objective_playermask_addshowplayer( self.upload_marker_id, player );
            }
            
            namespace_80082437c22b4d6e::function_57e8668265b07078( self );
            
            if ( self.var_98273f946a00c9b5 )
            {
                self.var_98273f946a00c9b5 game_utility::questcircle_showtoplayer( player );
            }
        }
        
        widget_params = { #step_index:self.widget_step };
        namespace_80082437c22b4d6e::function_dab60f070f92291e( self, widget_params );
        namespace_80082437c22b4d6e::function_52cc7a7f665dd279( self, player );
    }
}

// Namespace activity_blight_upload
// Params 1
// Checksum 0xe8e720e3, Offset: 0x1205
// Size: 0x114
function player_left_activity( relevant_info_struct )
{
    if ( !isdefined( self.laptop ) )
    {
        return;
    }
    
    foreach ( player in relevant_info_struct.playerlist )
    {
        if ( self.find_marker_id )
        {
            objidpoolmanager::objective_playermask_hidefrom( self.find_marker_id, player );
        }
        
        if ( self.upload_marker_id )
        {
            objidpoolmanager::objective_playermask_hidefrom( self.upload_marker_id, player );
        }
        
        if ( self.var_98273f946a00c9b5 )
        {
            self.var_98273f946a00c9b5 game_utility::questcircle_hidefromplayer( player );
        }
        
        namespace_80082437c22b4d6e::function_8abdb71fd43f7130( self, player );
        level thread namespace_80082437c22b4d6e::function_f71e05d0dbeaa264( self, player );
    }
    
    if ( self.playerparticipants.size == 0 )
    {
        namespace_80082437c22b4d6e::function_57e8668265b07078( self, 0 );
    }
}

// Namespace activity_blight_upload
// Params 6
// Checksum 0xecc6366b, Offset: 0x1321
// Size: 0x14f
function function_881d1393eeed1daf( instance, part, state, player, bautouse, usestring )
{
    if ( !isdefined( instance.activity_instance ) )
    {
        return;
    }
    
    if ( instance.uploading )
    {
        return;
    }
    
    if ( !instance.activity_instance.var_1ffc13be888badbd )
    {
        namespace_80082437c22b4d6e::function_57e8668265b07078( instance.activity_instance );
    }
    
    player thread utility::function_72b6372d2d8c997( "iw8_ges_plyr_loot_pickup", 1 );
    
    if ( !activity_participation::function_e7fc1202ac164928( instance.activity_instance, player ) )
    {
        activity_participation::function_bc67362dace4370c( instance.activity_instance, player );
    }
    
    instance.uploading = 1;
    instance.activity_instance notify( #"laptop_activated" );
    instance.activity_instance.widget_step = 1;
    widget_params = { #var_cf684f09b6c37c3a:100, #current_progress:0, #step_index:instance.activity_instance.widget_step };
    namespace_80082437c22b4d6e::function_5cdac4ed52d48636( instance.activity_instance, widget_params );
}

// Namespace activity_blight_upload
// Params 1, eflags: 0x4
// Checksum 0x3580b9e5, Offset: 0x1478
// Size: 0x78
function private create_objective_icon( origin )
{
    obj_id = objidpoolmanager::requestobjectiveid( 99 );
    
    if ( obj_id != -1 )
    {
        objidpoolmanager::objective_add_objective( obj_id, "current", origin, "sat_ui_icon_zm_haunting_uplink_phone_ping" );
        objidpoolmanager::update_objective_setbackground( obj_id, 1 );
        objidpoolmanager::function_586b631e7bbb592a( obj_id, 1 );
        objidpoolmanager::objective_set_play_intro( obj_id, 0 );
        objidpoolmanager::update_objective_description( obj_id, &"hash_44d0353e1d4a8efd" );
        function_38b84cb3d4357dd7( obj_id );
    }
    
    return obj_id;
}

// Namespace activity_blight_upload
// Params 1, eflags: 0x4
// Checksum 0xfd2be467, Offset: 0x14f9
// Size: 0x112
function private on_player_killed( params )
{
    if ( !params.victim || params.victim.team != "allies" )
    {
        return;
    }
    
    foreach ( activity_instance in level.blight_data.var_7659fcceeec3dda1[ "BLIGHT_UPLOAD" ] )
    {
        if ( activity_instance.state != "Active" )
        {
            continue;
        }
        
        laptop = activity_instance.laptop;
        
        if ( !isdefined( laptop ) || laptop.uploading )
        {
            continue;
        }
        
        laptop disablescriptableplayeruse( params.victim );
    }
}

