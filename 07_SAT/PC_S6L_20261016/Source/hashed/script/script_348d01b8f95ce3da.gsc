// script_348d01b8f95ce3da  (hash_348d01b8f95ce3da.gscc) (size: 13916 Bytes / 0x365c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x90c4a911 (2428807441)
// size ...... 13916 (0x365c)
// includes .. 20  (offset: 0x33a8)
// strings ... 33  (offset: 0x3448)
// dev strs .. 0   (offset: 0x365c)
// exports ... 21  (offset: 0x228c)
// cseg ...... 0x30c + 0x1f80 (0x228c)
// imports ... 116 (offset: 0x25d4)
// animtree1 . 0   (offset: 0x365c)
// animtree2 . 0   (offset: 0x365c)
#using script_2528fc84e11f3e4b;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\activity_nexus\activity_scriptables;
#using scripts\common\scriptable;
#using scripts\common\spatial_zone_container;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\damagefeedback;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_currency;
#using scripts\mp\objidpoolmanager;

#namespace activity_blight_infestation;

// Namespace activity_blight_infestation
// Params 0, eflags: 0x5
// Checksum 0xa325a941, Offset: 0x32a
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"activity_blight_infestation", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace activity_blight_infestation
// Params 0, eflags: 0x4
// Checksum 0x419c41f6, Offset: 0x353
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "BLIGHT_INFESTATION", &activity_type_init );
}

// Namespace activity_blight_infestation
// Params 0
// Checksum 0x5a05a386, Offset: 0x36e
// Size: 0xa5
function activity_type_init()
{
    if ( getdvarint( @"hash_2a6349f46e1ed171", 0 ) )
    {
        return;
    }
    
    activity_common::function_944074f3079c1d4e( "BLIGHT_INFESTATION", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "BLIGHT_INFESTATION", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "BLIGHT_INFESTATION", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "BLIGHT_INFESTATION", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_9fd46b47e0d8481d( 14, &function_dd06fe07f8c57b0 );
    scriptable::scriptable_adddamagedcallback( &handle_target_damage );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "BLIGHT_INFESTATION" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &player_left_activity, "BLIGHT_INFESTATION" );
}

// Namespace activity_blight_infestation
// Params 0
// Checksum 0xd0d55d8c, Offset: 0x41b
// Size: 0x2a7
function activity_setup()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self.shared_data = activity_common::function_9b15260622ed4dbe( "BLIGHT_INFESTATION" );
    self.target_spawn_structs = activity_instance_common::function_c78d8509d1f980d4( self, 0, "infestation_target_spawn" );
    self.var_d8019976495b193e = activity_instance_common::function_c78d8509d1f980d4( self, 0, "infestation_target_spawn_large" );
    
    foreach ( large_struct in self.var_d8019976495b193e )
    {
        large_struct.linked_targets = activity_instance_common::function_c78d8509d1f980d4( self, 0, large_struct.target );
    }
    
    self.prop_structs = activity_instance_common::function_c78d8509d1f980d4( self, 0, "infestation_prop" );
    self.gas_structs = activity_instance_common::function_c78d8509d1f980d4( self, 0, "infestation_gas" );
    self.gas_volumes = activity_instance_common::function_c78d8509d1f980d4( self, 0, "infestation_gas_volume" );
    namespace_80082437c22b4d6e::setup_participation_conditions( self );
    activitynexussettings = level.activities.activitynexussettings;
    self.abandon_countdown = activitynexussettings.var_a95bf48696b37fd0;
    self.var_2e97f5b0db9f2142 = "infestation_join";
    self.var_d5644cf0fec99bed = getdvarfloat( @"hash_3ac12adc47869f0f", 0.3 );
    self.var_fb46800b173d6fb = getdvarfloat( @"hash_a2f986481bff3f19", 0.7 );
    self.var_ee021ebad750b712 = getdvarfloat( @"hash_124133e966e12378", 0.75 );
    self.var_dd01e9b59f648c3b = getdvarint( @"hash_6ced6db3b0c32b51", 1 );
    self.var_3e8d985e9e32f3d7 = getdvarint( @"hash_d2b82345e50d7129", 3 );
    self.var_aae118fb4775e8c7 = getdvarint( @"hash_2a707bb48e463c79", 6 );
    self.small_target_health = getdvarfloat( @"hash_e5b67a2339303d34", 400 );
    self.large_target_health = getdvarfloat( @"hash_aeb326b31565576c", 1000 );
    self.var_e32da972a13d4421 = getdvarint( @"hash_fcb8f150ada8bb7f", 1 );
    self.var_c747aefa532bd39b = getdvarint( @"hash_a8de3647fb058421", 2 );
    self.var_2a6463a3bc90a27c = getdvarint( @"hash_db9ead4f82a630a2", 10 );
    self.var_4c275d2cb4cef908 = getdvarint( @"hash_7a2728e20babe4c6", 6 );
    activity_definition_utils::function_16b3cfd89a1669f7( 2, self );
}

// Namespace activity_blight_infestation
// Params 0
// Checksum 0xb21c6039, Offset: 0x6ca
// Size: 0xa11
function function_477932e3884ea1fd()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    activity_definition_utils::function_16b3cfd89a1669f7( 1, self );
    self.targets_destroyed = 0;
    self.active_targets = [];
    self.prop_scriptables = [];
    self.gas_scriptables = [];
    num_to_spawn = max( int( self.target_spawn_structs.size * self.var_ee021ebad750b712 ), 1 );
    selected_spawns = utility::array_slice( arrayrandomize( self.target_spawn_structs ), 0, num_to_spawn );
    
    foreach ( spawn_struct in selected_spawns )
    {
        target = spawnscriptable( "saw_blight_infestation_target", spawn_struct.origin, spawn_struct.angles );
        target.activity_instance = self;
        target.health = self.small_target_health;
        self.active_targets[ self.active_targets.size ] = target;
    }
    
    if ( self.var_d8019976495b193e )
    {
        num_to_spawn = max( int( self.var_d8019976495b193e.size * self.var_d5644cf0fec99bed ), 1 );
        selected_clusters = utility::array_slice( arrayrandomize( self.var_d8019976495b193e ), 0, num_to_spawn );
        
        foreach ( cluster_struct in selected_clusters )
        {
            target = spawnscriptable( "saw_blight_infestation_target_large", cluster_struct.origin, cluster_struct.angles );
            target.activity_instance = self;
            target.health = self.large_target_health;
            self.active_targets[ self.active_targets.size ] = target;
            var_847da81acd8a83d6 = max( int( cluster_struct.linked_targets.size * self.var_fb46800b173d6fb ), 1 );
            selected_small = utility::array_slice( arrayrandomize( cluster_struct.linked_targets ), 0, var_847da81acd8a83d6 );
            
            foreach ( var_735f3516507ba321 in selected_small )
            {
                target = spawnscriptable( "saw_blight_infestation_target", var_735f3516507ba321.origin, var_735f3516507ba321.angles );
                target.activity_instance = self;
                target.health = self.small_target_health;
                self.active_targets[ self.active_targets.size ] = target;
            }
        }
    }
    
    activity_scriptables::function_f71912f49638e206( self, self.active_targets );
    
    if ( !self.var_829607649f7880a )
    {
        foreach ( var_10ceb6b70c29c3b9 in self.prop_structs )
        {
            if ( var_10ceb6b70c29c3b9.targetname != "infestation_prop" )
            {
                continue;
            }
            
            prop = spawnscriptable( var_10ceb6b70c29c3b9.script_noteworthy, var_10ceb6b70c29c3b9.origin, var_10ceb6b70c29c3b9.angles );
            prop setscriptablepartstate( "state", "Visible" );
            self.prop_scriptables[ self.prop_scriptables.size ] = prop;
        }
        
        activity_scriptables::function_f71912f49638e206( self, self.prop_scriptables );
    }
    
    foreach ( gas_struct in self.gas_structs )
    {
        if ( gas_struct.targetname != "infestation_gas" )
        {
            continue;
        }
        
        Gas = spawnscriptable( gas_struct.script_noteworthy, gas_struct.origin, gas_struct.angles );
        Gas setscriptablepartstate( "state", "Visible" );
        self.gas_scriptables[ self.gas_scriptables.size ] = Gas;
    }
    
    activity_scriptables::function_f71912f49638e206( self, self.gas_scriptables, "ActivityEnd" );
    
    foreach ( volume in self.gas_volumes )
    {
        volume triggerenable();
        trigger::makeenterexittrigger( volume, &function_f37279985cbe66ec, &function_d58e2b15b9da3064 );
        volume.activity_instance = self;
    }
    
    circle_center = activity_instance_common::function_776ee11e7acc64a5( self );
    max_dist_sq = 0;
    
    foreach ( spawn_struct in selected_spawns )
    {
        dist_sq = distance2dsquared( circle_center, spawn_struct.origin );
        
        if ( dist_sq > max_dist_sq )
        {
            max_dist_sq = dist_sq;
        }
    }
    
    self.QUEST_CIRCLE = {};
    self.QUEST_CIRCLE game_utility::questcircle_create( "Infestation_Br", circle_center, sqrt( max_dist_sq ) + 200 );
    
    foreach ( player in self.playerparticipants )
    {
        self.QUEST_CIRCLE game_utility::questcircle_showtoplayer( player );
    }
    
    self.fx_scriptable = spawnscriptable( "saw_blight_infestation_fx", circle_center );
    activity_scriptables::function_114d59757e8d7bd9( self, self.fx_scriptable, "ActivityEnd" );
    self.selected_spawns = self.active_targets;
    widget_params = { #var_cf684f09b6c37c3a:self.selected_spawns.size, #current_progress:0 };
    namespace_80082437c22b4d6e::function_dab60f070f92291e( self, widget_params );
    namespace_80082437c22b4d6e::function_b9c4b4277cfc19bf( self, "sat_ui_icon_zm_haunting_spore_hunter", circle_center, &"hash_44112927f1d78a1f" );
    abandon_zone = self.var_8339fb4f2d23dabf.zones[ "Proximity_Abandon_Zone" ].spheres[ 0 ];
    spatial_zone_container::function_847140d2863dfbf8( self, "infestation_abandon", abandon_zone.origin, abandon_zone.radius );
    spatial_zone_container::function_3b687b8681411c9f( self, "infestation_abandon", &function_78b1ffe4da76401e, 0.5 );
    
    while ( self.targets_destroyed < self.selected_spawns.size )
    {
        self waittill( #"target_destroyed", target );
        
        if ( self.targets_destroyed == 1 )
        {
            self.var_f7e049347883d1ee = activity_ai_encounters::function_eb8506829193f5eb( "ai_encounter:saw_blight_ai_encounter_infestation", circle_center, 500, 1, 0, 1, 2 );
            activity_ai_encounters::function_52d1342183200a8f( self.var_f7e049347883d1ee, &namespace_80082437c22b4d6e::function_77688a5e67bd527f, { #activity_instance:self } );
            activity_ai_encounters::function_dcf6bdb6ee9d1ca0( self.var_f7e049347883d1ee, &should_reinforce, { #activity:self } );
            self.wave_requests = utility::queue_create( self.active_targets.size );
        }
        else
        {
            size = target.type == "saw_blight_infestation_target_large" ? #"hash_8238455279f54346" : #"hash_7932e2d31a36014a";
            utility::queue_enqueue( self.wave_requests, size );
        }
        
        if ( self.var_e32da972a13d4421 && self.active_targets.size <= self.var_c747aefa532bd39b )
        {
            self.target_obj_ids = [];
            
            foreach ( active_target in self.active_targets )
            {
                if ( isdefined( active_target.obj_id ) && active_target.obj_id != -1 )
                {
                    continue;
                }
                
                childthread mark_remaining_target( active_target );
            }
        }
    }
    
    activity_instance_common::endactivity( self, 1 );
}

// Namespace activity_blight_infestation
// Params 1
// Checksum 0x9db3b9d2, Offset: 0x10e3
// Size: 0x79
function function_dd06fe07f8c57b0( params )
{
    player = params[ 1 ];
    var_1e1f7b5dc57cf2d0 = params[ 2 ];
    
    if ( var_1e1f7b5dc57cf2d0 )
    {
        activity_participation::function_bc67362dace4370c( self, player );
        player notify( "abort_abandon_activity_" + self.id );
        
        if ( player.abandoning_activity[ self.id ] )
        {
            player.abandoning_activity[ self.id ] = undefined;
        }
    }
}

// Namespace activity_blight_infestation
// Params 3
// Checksum 0xa963ffb, Offset: 0x1164
// Size: 0x8e, Type: bool
function should_reinforce( id, data, var_62a6b384c0358219 )
{
    if ( !utility::queue_isempty( data.activity.wave_requests ) )
    {
        var_f76781fe5bd64b59 = utility::queue_peek( data.activity.wave_requests );
        utility::queue_dequeue( data.activity.wave_requests );
        function_1a9d724a960fa19d( id, var_f76781fe5bd64b59, 1 );
        return true;
    }
    
    return false;
}

// Namespace activity_blight_infestation
// Params 1
// Checksum 0xe628bd7f, Offset: 0x11fb
// Size: 0x1c4
function activity_ended( activity_succeeded )
{
    if ( activity_instance_common::function_6bb0be4a3940d6e3( self ) )
    {
        foreach ( player in self.playerparticipants )
        {
            player thread points::doscoreevent( #"hash_cf5661b1490f0a05" );
            challenges::function_37e945722d6497f3( player, "gametype_blight_activity_complete", 1 );
        }
    }
    
    foreach ( target in self.active_targets )
    {
        target.destroyed = 1;
        target setscriptablepartstate( "model", "destroyed" );
        target utility::delaycall( 3, &freescriptable );
    }
    
    foreach ( player in self.playerparticipants )
    {
        player utility::function_32b24db3127bff40( "spore_fx", "off" );
    }
    
    namespace_80082437c22b4d6e::function_36af27abcca0df47( self );
}

// Namespace activity_blight_infestation
// Params 0
// Checksum 0x510f5136, Offset: 0x13c7
// Size: 0x1b7
function function_d4acef179eb9f9b2()
{
    if ( isdefined( self.QUEST_CIRCLE ) )
    {
        self.QUEST_CIRCLE game_utility::questcircle_delete();
    }
    
    foreach ( volume in self.gas_volumes )
    {
        volume triggerdisable();
    }
    
    foreach ( scriptable in self.gas_scriptables )
    {
        scriptable freescriptable();
    }
    
    foreach ( obj_id in self.target_obj_ids )
    {
        if ( !isdefined( obj_id ) || obj_id == -1 )
        {
            continue;
        }
        
        function_a97ff46ea5217eac( obj_id );
    }
    
    namespace_80082437c22b4d6e::function_b25797193ea9d9db( self );
    
    if ( self.var_f7e049347883d1ee )
    {
        function_b43716082f77e5e5( self.var_f7e049347883d1ee );
    }
}

// Namespace activity_blight_infestation
// Params 1
// Checksum 0x5f101507, Offset: 0x1586
// Size: 0x23b
function player_joined_activity( relevant_info_struct )
{
    if ( !isdefined( self.QUEST_CIRCLE ) )
    {
        return;
    }
    
    foreach ( player in relevant_info_struct.playerlist )
    {
        player notify( "abort_abandon_activity_" + self.id );
        
        if ( player.abandoning_activity[ self.id ] )
        {
            player.abandoning_activity[ self.id ] = undefined;
        }
        
        self.QUEST_CIRCLE game_utility::questcircle_showtoplayer( player );
        namespace_80082437c22b4d6e::function_10f2ad982e66d1b( self, player );
        widget_params = { #var_cf684f09b6c37c3a:self.selected_spawns.size, #current_progress:self.targets_destroyed, #step_index:0 };
        namespace_80082437c22b4d6e::function_dab60f070f92291e( self, widget_params );
        namespace_80082437c22b4d6e::function_52cc7a7f665dd279( self, player );
    }
    
    if ( self.var_e32da972a13d4421 )
    {
        foreach ( target_scriptable in self.active_targets )
        {
            if ( target_scriptable.obj_id )
            {
                foreach ( player in relevant_info_struct.playerlist )
                {
                    objidpoolmanager::objective_playermask_addshowplayer( target_scriptable.obj_id, player );
                }
            }
        }
    }
}

// Namespace activity_blight_infestation
// Params 1
// Checksum 0x2db6d3ac, Offset: 0x17c9
// Size: 0x1f0
function player_left_activity( relevant_info_struct )
{
    if ( !isdefined( self.QUEST_CIRCLE ) )
    {
        return;
    }
    
    foreach ( player in relevant_info_struct.playerlist )
    {
        self.QUEST_CIRCLE game_utility::questcircle_hidefromplayer( player );
        namespace_80082437c22b4d6e::function_8abdb71fd43f7130( self, player );
        player utility::function_32b24db3127bff40( "spore_fx", "off" );
        player.infestation_triggers = 0;
        level thread namespace_80082437c22b4d6e::function_f71e05d0dbeaa264( self, player );
    }
    
    if ( self.var_e32da972a13d4421 )
    {
        foreach ( target_scriptable in self.active_targets )
        {
            if ( target_scriptable.obj_id )
            {
                foreach ( player in relevant_info_struct.playerlist )
                {
                    objidpoolmanager::objective_playermask_hidefrom( target_scriptable.obj_id, player );
                }
            }
        }
    }
    
    if ( self.playerparticipants.size == 0 )
    {
        namespace_80082437c22b4d6e::function_57e8668265b07078( self, 0 );
    }
}

// Namespace activity_blight_infestation
// Params 1
// Checksum 0xbdabc991, Offset: 0x19c1
// Size: 0x56
function function_78b1ffe4da76401e( callbackargs )
{
    player = callbackargs.player;
    
    if ( !callbackargs.enteredzone && !player.abandoning_activity[ self.id ] )
    {
        player thread function_e1a312d24579c4ea( self );
    }
}

// Namespace activity_blight_infestation
// Params 1
// Checksum 0x35df4e3a, Offset: 0x1a1f
// Size: 0xbd
function function_e1a312d24579c4ea( activity_instance )
{
    self notify( #"hash_8ce8a429281123e9" );
    self endon( #"hash_8ce8a429281123e9" );
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    self endon( "abort_abandon_activity_" + activity_instance.id );
    
    if ( !isdefined( self.abandoning_activity ) )
    {
        self.abandoning_activity = [];
    }
    
    self.abandoning_activity[ activity_instance.id ] = 1;
    wait activity_instance.abandon_countdown;
    is_in_join_zone = spatial_zone_container::function_c6b163965cbc2caa( self, activity_instance, "Proximity_Join_Zone" );
    
    if ( !is_in_join_zone )
    {
        activity_participation::function_dd782fbeb3b07e39( activity_instance, [ self ], 1 );
    }
}

// Namespace activity_blight_infestation
// Params 1
// Checksum 0x26d7641c, Offset: 0x1ae4
// Size: 0x8f
function function_3f5a3efcc9005172( activity_instance )
{
    self notify( #"hash_ee5908402f6ec05c" );
    self endon( #"hash_ee5908402f6ec05c" );
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    self endon( "joined_activity_" + activity_instance.id );
    self notify( "abort_abandon_activity_" + activity_instance.id );
    is_in_join_zone = spatial_zone_container::function_c6b163965cbc2caa( self, activity_instance, "Proximity_Join_Zone" );
    
    if ( !is_in_join_zone )
    {
        thread function_e1a312d24579c4ea( activity_instance );
    }
}

// Namespace activity_blight_infestation
// Params 11
// Checksum 0x88c924ef, Offset: 0x1b7b
// Size: 0x3f5
function handle_target_damage( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance.type != "saw_blight_infestation_target" && instance.type != "saw_blight_infestation_target_large" || instance.destroyed )
    {
        return;
    }
    
    if ( !isdefined( instance.activity_instance ) )
    {
        return;
    }
    
    if ( eattacker.team == "axis" || !isplayer( eattacker ) )
    {
        return;
    }
    
    if ( !activity_participation::function_e7fc1202ac164928( instance.activity_instance, eattacker ) )
    {
        activity_participation::function_bc67362dace4370c( instance.activity_instance, eattacker );
    }
    
    activity_instance = instance.activity_instance;
    
    if ( !activity_instance.var_1ffc13be888badbd )
    {
        namespace_80082437c22b4d6e::function_57e8668265b07078( activity_instance );
    }
    
    instance.health -= idamage;
    eattacker damagefeedback::updatedamagefeedback( "standard", instance.health <= 0 );
    eattacker thread function_3f5a3efcc9005172( activity_instance );
    
    if ( instance.health > 0 )
    {
        return;
    }
    
    instance setscriptablepartstate( "model", "destroyed" );
    instance.destroyed = 1;
    is_last_target = activity_instance.targets_destroyed + 1 >= activity_instance.selected_spawns.size;
    num_dna = instance.type == "saw_blight_infestation_target_large" ? activity_instance.var_3e8d985e9e32f3d7 : activity_instance.var_dd01e9b59f648c3b;
    num_dna = is_last_target ? activity_instance.var_aae118fb4775e8c7 : num_dna;
    spawn_options = common_item::items_initspawnoptions_spawnfromposition( instance.origin + anglestoup( instance.angles ) * 20 );
    item_name = item_currency::function_a3eadb2d3c329589( "dna_sample", 25 );
    
    for ( i = 0; i < num_dna ; i++ )
    {
        common_item::function_57b88e025e5fb03e( item_name, 25, spawn_options );
    }
    
    if ( is_last_target )
    {
        items = common_item::items_selectfromlist( %"hash_72a40d2cb9744e98", activity_instance.var_4c275d2cb4cef908 );
        
        foreach ( item in items )
        {
            common_item::function_61c2c0251e742ffd( item, undefined, spawn_options );
        }
    }
    
    instance utility::delaycall( 3, &freescriptable );
    activity_instance.active_targets = arrayremove( activity_instance.active_targets, instance );
    activity_instance.targets_destroyed++;
    activity_instance notify( #"target_destroyed", instance );
    namespace_80082437c22b4d6e::function_5cdac4ed52d48636( activity_instance, { #var_cf684f09b6c37c3a:activity_instance.selected_spawns.size, #current_progress:activity_instance.targets_destroyed } );
    score_event = instance.type == "saw_blight_infestation_target_large" ? #"hash_ac3ef47a89ef9dfb" : #"hash_128c98f283b6677";
    eattacker thread points::doscoreevent( score_event );
    
    if ( instance.obj_id )
    {
        activity_instance function_a97ff46ea5217eac( instance.obj_id );
        instance.obj_id = undefined;
    }
}

// Namespace activity_blight_infestation
// Params 2, eflags: 0x4
// Checksum 0x18da3d00, Offset: 0x1f78
// Size: 0x84
function private function_f37279985cbe66ec( ent, trigger )
{
    if ( !isplayer( ent ) || !ent player::isreallyalive() )
    {
        return;
    }
    
    if ( !ent istouching( trigger ) )
    {
        return;
    }
    
    if ( !isdefined( ent.infestation_triggers ) )
    {
        ent.infestation_triggers = 0;
    }
    
    ent.infestation_triggers++;
    
    if ( ent.infestation_triggers == 1 )
    {
        ent utility::function_32b24db3127bff40( "spore_fx", "on" );
    }
}

// Namespace activity_blight_infestation
// Params 2, eflags: 0x4
// Checksum 0x13039e40, Offset: 0x2004
// Size: 0x6b
function private function_d58e2b15b9da3064( ent, trigger )
{
    if ( !isplayer( ent ) )
    {
        return;
    }
    
    ent.infestation_triggers--;
    ent.infestation_triggers = maxint( 0, ent.infestation_triggers );
    
    if ( ent.infestation_triggers == 0 )
    {
        ent utility::function_32b24db3127bff40( "spore_fx", "off" );
    }
}

// Namespace activity_blight_infestation
// Params 1, eflags: 0x4
// Checksum 0xb3950b94, Offset: 0x2077
// Size: 0xa1
function private mark_remaining_target( target_scriptable )
{
    self endon( #"target_destroyed" );
    target_scriptable endon( #"death" );
    wait self.var_2a6463a3bc90a27c;
    
    if ( !target_scriptable || target_scriptable getscriptablepartstate( "model" ) == "destroyed" )
    {
        return;
    }
    
    if ( isdefined( target_scriptable.obj_id ) && target_scriptable.obj_id != -1 )
    {
        return;
    }
    
    target_scriptable.obj_id = function_25aa65e07701af21( target_scriptable );
    self.target_obj_ids[ self.target_obj_ids.size ] = target_scriptable.obj_id;
}

// Namespace activity_blight_infestation
// Params 1
// Checksum 0x10c84d3f, Offset: 0x2120
// Size: 0x136
function function_25aa65e07701af21( target_scr )
{
    offset = target_scr.type == "saw_blight_infestation_target" ? 30 : 45;
    obj_id = objidpoolmanager::requestobjectiveid( 99 );
    
    if ( obj_id != -1 )
    {
        objidpoolmanager::objective_add_objective( obj_id, "current", target_scr.origin + anglestoup( target_scr.angles ) * offset, "sat_ui_icon_zm_haunting_spore_hunter" );
        objidpoolmanager::update_objective_setbackground( obj_id, 1 );
        objidpoolmanager::function_586b631e7bbb592a( obj_id, 1 );
        objidpoolmanager::objective_set_play_intro( obj_id, 0 );
        objidpoolmanager::update_objective_description( obj_id, &"hash_5e6ec3acebea0fa" );
        function_38b84cb3d4357dd7( obj_id );
        
        foreach ( player in self.playerparticipants )
        {
            objective_addclienttomask( obj_id, player );
        }
        
        objective_showtoplayersinmask( obj_id );
    }
    
    return obj_id;
}

// Namespace activity_blight_infestation
// Params 1
// Checksum 0x2d4ed50e, Offset: 0x225f
// Size: 0x2d
function function_a97ff46ea5217eac( obj_id )
{
    if ( isdefined( obj_id ) && obj_id != -1 )
    {
        objidpoolmanager::objective_playermask_hidefromall( obj_id );
        objidpoolmanager::returnobjectiveid( obj_id );
    }
}

