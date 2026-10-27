// scripts\mp\ob\activities\ob_activity_quarantine_island.gsc  (hash_626bbccd4337bfac.gscc) (size: 27348 Bytes / 0x6ad4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf5499ad1 (4115241681)
// size ...... 27348 (0x6ad4)
// includes .. 39  (offset: 0x64a8)
// strings ... 80  (offset: 0x65e0)
// dev strs .. 12  (offset: 0x6a44)
// exports ... 62  (offset: 0x418c)
// cseg ...... 0x75c + 0x3a30 (0x418c)
// imports ... 212 (offset: 0x4b3c)
// animtree1 . 0   (offset: 0x6ad4)
// animtree2 . 0   (offset: 0x6ad4)
#using script_60cd1c57e94be8d7;
#using script_636bd827a012af12;
#using scripts\common\activity_nexus\activity_ai_encounters;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\activity_nexus\activity_player_broadcasting;
#using scripts\common\ai;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\aitypes\shared\zombie\zombie_boss_healthbar;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\scene;
#using scripts\common\scriptable;
#using scripts\common\spatial_zone_container;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\coop;
#using scripts\mp\damagefeedback;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_instance_inventory;
#using scripts\mp\loot\common_item;
#using scripts\mp\mp_agent_damage;
#using scripts\mp\ob\activities\ob_activity_definition_utils;
#using scripts\mp\ob\activities\ob_activity_utility;
#using scripts\mp\ob\activities\ob_activity_vo_utility;
#using scripts\mp\ob\activities\ob_objective_rewards;
#using scripts\mp\ob\ob_soldier_util;
#using scripts\mp\ob\points;
#using scripts\mp\ob\systems\ob_exfil;
#using scripts\mp\ob\systems\region_difficulty_manager;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\overlord;

#namespace ob_activity_quarantine_island;

// Namespace ob_activity_quarantine_island
// Params 0, eflags: 0x5
// Checksum 0xbe7299ad, Offset: 0x77a
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"ob_activity_quarantine_island", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace ob_activity_quarantine_island
// Params 0, eflags: 0x4
// Checksum 0xacf4b1b6, Offset: 0x7a3
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "REV_OB_QUARANTINE_ISLAND", &function_bc65776d7c87cc0b );
}

// Namespace ob_activity_quarantine_island
// Params 0
// Checksum 0x94f53555, Offset: 0x7be
// Size: 0xb1
function function_bc65776d7c87cc0b()
{
    activity_common::function_944074f3079c1d4e( "REV_OB_QUARANTINE_ISLAND", 0, &quarantine_island_activity_setup );
    activity_common::function_944074f3079c1d4e( "REV_OB_QUARANTINE_ISLAND", 1, &quarantine_island_activity_begin );
    activity_common::function_944074f3079c1d4e( "REV_OB_QUARANTINE_ISLAND", 2, &quarantine_island_activity_ended );
    activity_common::function_944074f3079c1d4e( "REV_OB_QUARANTINE_ISLAND", 3, &function_f264825de0a633 );
    activity_common::function_944074f3079c1d4e( "REV_OB_QUARANTINE_ISLAND", 5, &function_fec785b14862caa0 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &function_b37b142675bcd25e, "REV_OB_QUARANTINE_ISLAND" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &function_6e24c25d25963496, "REV_OB_QUARANTINE_ISLAND" );
    
    if ( !isdefined( level.var_5414e7d7de569c92 ) )
    {
        scriptable::scriptable_adddamagedcallback( &function_771b56e9e2b0af77 );
        level.var_5414e7d7de569c92 = 1;
    }
}

// Namespace ob_activity_quarantine_island
// Params 0
// Checksum 0x93fe7d96, Offset: 0x877
// Size: 0x1ae
function quarantine_island_activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activityvariantdefinition = activity_definition_utils::function_9129cd8075c85c09( self );
    self.var_91c91f4a631c481d = activityvariantdefinition;
    self.s_center = utility::getstruct( self.varianttag + "_main", "targetname" );
    
    if ( !isdefined( self.s_center ) )
    {
        activity_instance_common::function_9aeeabe50fc9cc3e( self );
    }
    
    self.difficulty_region = "difficulty5";
    self.var_e3ea4b4047a82291 = 15;
    self.var_80b3ef000405f99e = 0;
    self.var_a4eb7594f9bf23a3 = 15;
    self.var_264c033b7f94e6c5 = 30;
    self.var_9f1e3d1d5eca5857 = 45;
    self.floodfill_bucket = "floodfill_1";
    self.var_3ddf278a43256d8d = 0;
    self.floodfill_paused = 0;
    self.var_414531652cd3271 = 200;
    self.var_2541d1c0b34aefc3 = 100;
    self.var_58f16cb9744ac1d5 = 0;
    
    /#
        if ( getdvarint( @"hash_2b80d2d1cd1f3c27", 0 ) )
        {
            self.var_2541d1c0b34aefc3 = 20;
        }
    #/
    
    self.var_2ecaecd2562f45e = self.var_2541d1c0b34aefc3 * 100;
    self.var_c2127c21995e9409 = self.var_2ecaecd2562f45e;
    self.var_5efb395e6b88cee8 = self.var_2ecaecd2562f45e * 0.666667;
    self.var_400228510f338a3a = self.var_2ecaecd2562f45e * 0.333333;
    self.started = 0;
    setup_structs();
    thread function_146e5ca91230b880();
    setup_cysts();
    spatial_zone_container::function_11cd1f1428a0af78( 0, &function_4a81af1f88d93532 );
    activity_instance_common::function_46135a69bddfec2c( self );
}

// Namespace ob_activity_quarantine_island
// Params 0
// Checksum 0x902d8ade, Offset: 0xa2d
// Size: 0x147
function setup_structs()
{
    all_structs = utility::getstructarray( self.s_center.targetname, "target" );
    self.a_s_cysts = [];
    
    foreach ( struct in all_structs )
    {
        if ( struct.targetname == "s_cyst_spawn" )
        {
            self.a_s_cysts[ self.a_s_cysts.size ] = struct;
        }
    }
    
    if ( isdefined( self.s_center.var_5bf3f724a0920d67 ) )
    {
        var_b88cff45f0beffdb = utility::getstructarray( self.s_center.var_5bf3f724a0920d67, "targetname" );
        self.var_c0c940b175bdf3ca = function_47c86977a18df38b( var_b88cff45f0beffdb, self.s_center.origin, 1000 );
    }
    
    self.a_s_cysts = getentitylessscriptablearray( "s_cyst_spawn", #targetname );
}

// Namespace ob_activity_quarantine_island
// Params 0
// Checksum 0x2ae99c85, Offset: 0xb7c
// Size: 0x11c
function function_146e5ca91230b880()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    utility::flag_wait( "ammorestock_initialized" );
    var_2d4aa5f55d3c1c84 = spatial_zone_container::function_f7fc3e6c249a8256( activity_instance, "Awareness_Zone" );
    radius = spatial_zone_container::function_231d9e91d8ef7b5f( var_2d4aa5f55d3c1c84[ 0 ] );
    scriptables = getentitylessscriptablearray( undefined, undefined, activity_instance.s_center.origin, radius ?? 4000, #"military_ammo_restock" );
    
    foreach ( scriptable in scriptables )
    {
        function_9bebf79aee6c7add( scriptable );
        scriptable setscriptablepartstate( #"military_ammo_restock", #"useable_on" );
    }
}

// Namespace ob_activity_quarantine_island
// Params 0
// Checksum 0xa58d2885, Offset: 0xca0
// Size: 0x114
function setup_cysts()
{
    self.var_f13640703a255fe4 = function_99d7cbd66a1e53e4( self.a_s_cysts, self.var_414531652cd3271 );
    self.cysts = [];
    self.destroyed_cysts = [];
    self.cleanup_cysts = [];
    self.scriptable = spawnscriptable( %"sat_ob_quarantine_zone_activity_scriptable", self.s_center.origin );
    
    foreach ( cyst in self.var_f13640703a255fe4 )
    {
        cyst.cyst_health = 100;
        cyst setscriptablepartstate( "body", "pristine" );
        cyst.health = 100;
        cyst.activity_instance = self;
    }
}

// Namespace ob_activity_quarantine_island
// Params 2
// Checksum 0x2b2e5e2e, Offset: 0xdbc
// Size: 0x28d
function function_99d7cbd66a1e53e4( all_spawn_structs, var_8412f95215fbbd9b )
{
    buckets = [];
    bucket_keys = [];
    
    foreach ( struct in all_spawn_structs )
    {
        if ( isdefined( struct.script_noteworthy ) )
        {
            if ( !isdefined( buckets[ struct.script_noteworthy ] ) )
            {
                buckets[ struct.script_noteworthy ] = [];
                bucket_keys[ bucket_keys.size ] = struct.script_noteworthy;
            }
            
            buckets[ struct.script_noteworthy ][ buckets[ struct.script_noteworthy ].size ] = struct;
        }
    }
    
    if ( bucket_keys.size > 0 )
    {
        bucket_keys = arrayrandomize( bucket_keys );
        selected_spawn_structs = [];
        unselected_spawn_structs = [];
        i = 0;
        target_num_spawns = min( var_8412f95215fbbd9b, all_spawn_structs.size );
        
        while ( selected_spawn_structs.size < target_num_spawns )
        {
            var_2a88723414227592 = i % bucket_keys.size;
            
            if ( buckets[ bucket_keys[ var_2a88723414227592 ] ].size > 0 )
            {
                var_a4f4dea85619f7a8 = utility::array_random( buckets[ bucket_keys[ var_2a88723414227592 ] ] );
                buckets[ bucket_keys[ var_2a88723414227592 ] ] = arrayremove( buckets[ bucket_keys[ var_2a88723414227592 ] ], var_a4f4dea85619f7a8 );
                selected_spawn_structs[ selected_spawn_structs.size ] = var_a4f4dea85619f7a8;
            }
            
            i += 1;
        }
        
        foreach ( bucket_key in bucket_keys )
        {
            foreach ( remaining_struct in buckets[ bucket_key ] )
            {
                unselected_spawn_structs[ unselected_spawn_structs.size ] = remaining_struct;
            }
        }
        
        self.var_83f9ef790511dfc3 = unselected_spawn_structs;
        return selected_spawn_structs;
    }
    
    return utility::array_slice( arrayrandomize( all_spawn_structs ), 0, var_8412f95215fbbd9b );
}

// Namespace ob_activity_quarantine_island
// Params 11
// Checksum 0x30a46632, Offset: 0x1051
// Size: 0x27e
function function_771b56e9e2b0af77( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance.type != "sat_ob_quarantine_island_flower_scriptable" || instance.destroyed )
    {
        return;
    }
    
    flower = instance;
    
    if ( isdefined( flower.spawner ) )
    {
        flower.spawner notify( #"start_spawn" );
    }
    
    if ( weapon::iswonderweapon( objweapon ) )
    {
        idamage = function_dadb12e90fff3806( idamage );
    }
    
    if ( isdefined( flower.health ) )
    {
        flower.health -= idamage;
        
        if ( isplayer( eattacker ) )
        {
            flower.a_player_assist = arraycombineunique( flower.a_player_assist, [ eattacker ] );
            
            if ( mp_agent_damage::function_e7d118eb7b017fa4() )
            {
                mp_agent_damage::function_eb8ba16055d6da7c( eattacker, flower.var_6ae174d782d4ae, "none", smeansofdeath, objweapon, int( idamage ), undefined, 0, undefined, 0, 0 );
            }
            
            eattacker damagefeedback::updatehitmarker( "standard", flower.health <= 0, 0, 0, undefined );
            
            if ( !arraycontains( flower.activity_instance.playerparticipants, eattacker ) )
            {
                activity_participation::function_bc67362dace4370c( flower.activity_instance, eattacker );
            }
        }
        
        flower.activity_instance.var_1d0b08fe550caf30 = eattacker;
        
        if ( !flower.activity_instance.started )
        {
            flower.activity_instance notify( #"quarantine_zone_start" );
        }
        
        flower.activity_instance function_6aa09da8e2df2dd7( idamage );
        
        if ( flower.health <= 0 )
        {
            eattacker points::ob_do_score_event( #"ob_aethernest_cyst_destroyed" );
            flower thread flower_death( eattacker );
            params = spawnstruct();
            params.player = eattacker;
            params.cyst = flower;
            eattacker callback::callback( "aethernest_cyst_destroyed", params );
            return;
        }
        
        flower utility::function_32b24db3127bff40( "body", "damaged" );
    }
}

// Namespace ob_activity_quarantine_island
// Params 1, eflags: 0x4
// Checksum 0x9476e638, Offset: 0x12d7
// Size: 0x19
function private function_dadb12e90fff3806( idamage )
{
    return int( max( idamage, 500 ) );
}

// Namespace ob_activity_quarantine_island
// Params 1, eflags: 0x4
// Checksum 0x94b76c6, Offset: 0x12f9
// Size: 0x11d
function private flower_death( attacker )
{
    self endon( #"death" );
    flower = self;
    activity_instance = flower.activity_instance;
    flower.destroyed = 1;
    flower setscriptablepartstate( "health", "ignore_damage" );
    flower setscriptablepartstate( "body", "bursted" );
    activity_instance.cysts = arrayremove( activity_instance.cysts, flower );
    activity_instance.destroyed_cysts[ activity_instance.destroyed_cysts.size ] = flower;
    activity_instance.var_a2ed9abc2487b403 = flower.origin;
    activity_instance.var_58f16cb9744ac1d5++;
    activity_definition_utils::updateprogress( int( min( 100, activity_instance.var_58f16cb9744ac1d5 ) ), activity_instance );
    
    if ( isplayer( attacker ) )
    {
        activity_instance thread function_58a9b552bf6adb6c( attacker );
    }
    
    if ( activity_instance.var_58f16cb9744ac1d5 >= activity_instance.var_2541d1c0b34aefc3 )
    {
        activity_instance notify( #"nest_cleared" );
    }
}

// Namespace ob_activity_quarantine_island
// Params 1
// Checksum 0x5f4d04f, Offset: 0x141e
// Size: 0x8f
function function_58a9b552bf6adb6c( attacker )
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( !activity_instance.var_832a01b4068ce719 )
    {
        if ( activity_instance.var_58f16cb9744ac1d5 < activity_instance.var_414531652cd3271 )
        {
            activity_instance ob_activity_utility::function_894ac80e038636c5( "wcaquashflowerelim", [ attacker ] );
            activity_instance.var_832a01b4068ce719 = 1;
            wait 2;
            activity_instance.var_832a01b4068ce719 = 0;
        }
    }
}

// Namespace ob_activity_quarantine_island
// Params 1
// Checksum 0xde21c35b, Offset: 0x14b5
// Size: 0x486
function function_4a81af1f88d93532( var_54c779cf281bb58d )
{
    if ( activity_instance_common::getactivitytype( self ) != "REV_OB_QUARANTINE_ISLAND" )
    {
        return;
    }
    
    player = var_54c779cf281bb58d.player;
    
    if ( !isdefined( self.players_nearby ) )
    {
        self.players_nearby = [];
    }
    
    if ( !isdefined( self.var_70e9ace0eb08368b ) )
    {
        self.var_70e9ace0eb08368b = [];
    }
    
    prev_players_nearby = self.players_nearby;
    self.players_nearby = [[ var_54c779cf281bb58d.var_de8af980c94ffa6b ]]( var_54c779cf281bb58d );
    
    if ( self.players_nearby.size > prev_players_nearby.size && prev_players_nearby.size == 0 )
    {
        if ( !arraycontains( self.var_70e9ace0eb08368b, player ) )
        {
            haskey = 1;
            
            if ( haskey )
            {
                squad = player squad_utility::getsquadmembers();
                
                if ( squad.size == 0 )
                {
                    squad = [ player ];
                }
                
                if ( randomint( 100 ) > 50 )
                {
                    var_e2ef761bbafd0ecc = "vo_intro_swimtoisland";
                }
                else
                {
                    var_e2ef761bbafd0ecc = "vo_intro_swimtoisland_alt";
                }
                
                thread overlord::playconversation( var_e2ef761bbafd0ecc, [ player ] );
                self.var_70e9ace0eb08368b[ self.var_70e9ace0eb08368b.size ] = player;
                
                foreach ( squadmate in squad )
                {
                    squadmate callback::callback( "on_approach_zm_stronghold" );
                }
            }
        }
        
        foreach ( s_cyst in self.var_f13640703a255fe4 )
        {
            cyst = s_cyst;
            
            if ( cyst.health > 0 )
            {
                cyst.var_6ae174d782d4ae = cyst;
                cyst.var_6ae174d782d4ae.var_d62ad5bfd64ba592 = "tag_origin";
                cyst.activity_instance = self;
                cyst setscriptablepartstate( #"health", #"damage_detect" );
                cyst setscriptablepartstate( #"body", #"pristine" );
                self.cysts[ self.cysts.size ] = cyst;
            }
            else
            {
                cyst setscriptablepartstate( #"health", #"ignore_damage" );
                cyst setscriptablepartstate( #"body", #"bursted" );
            }
            
            if ( !isdefined( level.ob.cysts ) )
            {
                level.ob.cysts = [];
            }
            
            level.ob.cysts[ level.ob.cysts.size ] = cyst;
            self.cleanup_cysts[ self.cleanup_cysts.size ] = cyst;
            
            /#
                if ( getbuildversion() != "<dev string:x24>" )
                {
                    cyst thread debug_cyst();
                }
            #/
        }
        
        return;
    }
    
    if ( self.players_nearby.size == 0 )
    {
        foreach ( cyst in self.cleanup_cysts )
        {
            if ( isdefined( cyst ) && isdefined( cyst.health ) )
            {
                if ( isdefined( level.ob.cysts ) && arraycontains( level.ob.cysts, cyst ) )
                {
                    level.ob.cysts = arrayremove( level.ob.cysts, cyst );
                }
                
                cyst utility::function_32b24db3127bff40( "body", "hidden" );
            }
        }
        
        self.cleanup_cysts = [];
        self.cysts = [];
    }
}

// Namespace ob_activity_quarantine_island
// Params 0
// Checksum 0x2b049b2e, Offset: 0x1943
// Size: 0x233
function quarantine_island_activity_begin()
{
    self notify( #"hash_50b51b1e0b5c5104" );
    self endon( #"hash_50b51b1e0b5c5104" );
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    function_784cb3aefe6c224e();
    
    foreach ( cyst in self.var_f13640703a255fe4 )
    {
        if ( cyst getscriptablepartstate( "body" ) == "pristine" )
        {
            cyst setscriptablepartstate( "body", "reset" );
        }
    }
    
    /#
        thread debug_boss_spawn();
        thread function_7516304bb8d6a60d();
        thread debug_nest_cleared();
    #/
    
    self.scriptable setscriptablepartstate( #"audio_notifications", #"nest_started" );
    self.started = 1;
    thread spawn_encounter_bosses();
    self waittill( #"nest_cleared" );
    self.scriptable setscriptablepartstate( #"audio_notifications", #"nest_cleared" );
    earthquake( 0.6, 1.7, self.s_center.origin, 500 );
    playrumbleonposition( "grenade_rumble", self.s_center.origin );
    thread activity_player_broadcasting::function_cb4750c84882dd07( "nest_cleared", self.playerparticipants );
    wait 1;
    function_98bf2a2296f3bbd8();
    thread spawn_disciple_boss();
    self waittill( #"falkner_killed" );
    thread stop_all_spawns( 1 );
    level thread overlord::playconversation( "convo_falkner_death_final", self.playerparticipants );
    level musicbank_utility::function_4f253fd35ec68cbc( self.playerparticipants, #"hash_dc8288d3dfd2bf3d" );
    ob_objective_rewards::function_36f1eac78c060f20( 0, 0, 1, self.playerparticipants, self.difficulty_region, self.category, 1 );
    self.quarantine_island_activity_success = 1;
}

// Namespace ob_activity_quarantine_island
// Params 0
// Checksum 0xb7425ffb, Offset: 0x1b7e
// Size: 0xa2
function function_784cb3aefe6c224e()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    var_fec1e5de5dbef42b = 0;
    
    while ( true )
    {
        nearby_players = sortbydistancecullbyradius( level.players, self.s_center.origin, 4000 );
        
        if ( nearby_players.size > 0 )
        {
            self.nearby_players = nearby_players;
            
            if ( !var_fec1e5de5dbef42b )
            {
                var_fec1e5de5dbef42b = 1;
                thread spawn_zombies_floodfill( %"hash_4c2dd4212c7b5957" );
                thread function_4c5a6f50cb7192db( %"hash_7684d931356e6c15" );
                break;
            }
        }
        
        wait 0.5;
    }
}

// Namespace ob_activity_quarantine_island
// Params 1, eflags: 0x4
// Checksum 0xa2c4c551, Offset: 0x1c28
// Size: 0x56
function private stop_all_spawns( b_despawn = 0 )
{
    activity_ai_encounters::function_46dadc3aca2ffac0( self.encounterid_floodfill, b_despawn );
    activity_ai_encounters::function_46dadc3aca2ffac0( self.flower_encounterid, b_despawn );
    
    if ( self.boss_encounter_id )
    {
        activity_ai_encounters::function_46dadc3aca2ffac0( self.boss_encounter_id, b_despawn );
    }
}

// Namespace ob_activity_quarantine_island
// Params 1
// Checksum 0x91ed973a, Offset: 0x1c86
// Size: 0x85
function function_6aa09da8e2df2dd7( damage )
{
    var_ab8007f32d8a3abe = get_current_health();
    var_b44147cf877e9402 = var_ab8007f32d8a3abe + damage;
    
    if ( var_b44147cf877e9402 >= self.var_5efb395e6b88cee8 && var_ab8007f32d8a3abe <= self.var_5efb395e6b88cee8 )
    {
        self notify( #"first_threshold_reached" );
        return;
    }
    
    if ( var_b44147cf877e9402 >= self.var_400228510f338a3a && var_ab8007f32d8a3abe <= self.var_400228510f338a3a )
    {
        self notify( #"second_threshold_reached" );
    }
}

// Namespace ob_activity_quarantine_island
// Params 0
// Checksum 0x47bdfb7e, Offset: 0x1d13
// Size: 0x31
function get_current_health()
{
    var_ab8007f32d8a3abe = ( self.var_2541d1c0b34aefc3 - self.var_58f16cb9744ac1d5 ) * 100;
    self.var_c2127c21995e9409 = var_ab8007f32d8a3abe;
    return var_ab8007f32d8a3abe;
}

// Namespace ob_activity_quarantine_island
// Params 5
// Checksum 0x62eba26b, Offset: 0x1d4d
// Size: 0xe1
function function_4c5a6f50cb7192db( bundle, optional_size_tag, var_bbb3c3d3da789bf4, is_flood_fill, var_8f088104449168cc )
{
    var_b7e6d2d89bfacd6 = 500;
    var_cef0dcb3971b4e64 = 50;
    centerpoint = self.s_center.origin;
    
    if ( !isdefined( centerpoint ) )
    {
        return;
    }
    
    self.flower_encounterid = activity_ai_encounters::function_eb8506829193f5eb( %"hash_7684d931356e6c15", centerpoint, var_b7e6d2d89bfacd6, 1, 1, 1, 0 );
    
    if ( isdefined( self.flower_encounterid ) )
    {
        activity_ai_encounters::function_52d1342183200a8f( self.flower_encounterid, &function_64015a02e5cd3b4a, self );
        ai_spawn_director::function_53289c032f506bb1( self.flower_encounterid, &function_1e5a62f7153fc8c9, self );
        ai_spawn_director::function_c99d360d62c49a9c( self.flower_encounterid, &function_451ad7c95d7c78ae, self );
    }
}

// Namespace ob_activity_quarantine_island
// Params 1
// Checksum 0x467ed413, Offset: 0x1e36
// Size: 0x106
function spawn_zombies_floodfill( bundle )
{
    var_b7e6d2d89bfacd6 = 500;
    
    if ( self.playerparticipants.size )
    {
        centerpoint = self.playerparticipants[ 0 ].origin;
    }
    else
    {
        centerpoint = self.s_center.origin;
    }
    
    thread function_3e832efec56fcf4();
    self.encounterid_floodfill = activity_ai_encounters::function_eb8506829193f5eb( bundle, centerpoint, var_b7e6d2d89bfacd6, 1, 1, 1, 0 );
    function_1a9d724a960fa19d( self.encounterid_floodfill, self.floodfill_bucket, 1 );
    
    if ( isdefined( self.encounterid_floodfill ) )
    {
        activity_ai_encounters::function_52d1342183200a8f( self.encounterid_floodfill, &function_8508a93f90edb25, self );
        ai_spawn_director::function_53289c032f506bb1( self.encounterid_floodfill, &function_3318bd915c3c29be, self );
        ai_spawn_director::function_c99d360d62c49a9c( self.encounterid_floodfill, &function_1a5260b1c22a36e7, self );
        function_bbd192652d1a9e18( self.encounterid_floodfill, self.var_e3ea4b4047a82291 );
        thread function_2bc04886d2f642a();
    }
}

// Namespace ob_activity_quarantine_island
// Params 0, eflags: 0x4
// Checksum 0xcdd05100, Offset: 0x1f44
// Size: 0xcc
function private function_3e832efec56fcf4()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"hash_1cca761071eadcf1" );
    self.floodfill_bucket = "floodfill_1";
    self waittill( #"first_threshold_reached" );
    function_1a9d724a960fa19d( self.encounterid_floodfill, self.floodfill_bucket, 0 );
    self.floodfill_bucket = "floodfill_2";
    function_1a9d724a960fa19d( self.encounterid_floodfill, self.floodfill_bucket, 1 );
    self waittill( #"second_threshold_reached" );
    function_1a9d724a960fa19d( self.encounterid_floodfill, self.floodfill_bucket, 0 );
    self.floodfill_bucket = "floodfill_3";
    function_1a9d724a960fa19d( self.encounterid_floodfill, self.floodfill_bucket, 1 );
}

// Namespace ob_activity_quarantine_island
// Params 2, eflags: 0x4
// Checksum 0xade3c0b2, Offset: 0x2018
// Size: 0x16d, Type: bool
function private function_1a5260b1c22a36e7( encounterid, userdata )
{
    if ( encounterid == userdata.encounterid_floodfill )
    {
        if ( !isdefined( userdata.started ) )
        {
            return false;
        }
        
        var_9e3b54a70ee22a87 = function_da26e38f24f90f2f( encounterid );
        
        if ( userdata.final_boss )
        {
            function_1ac3703e7bc56a8( userdata.encounterid_floodfill, userdata.final_boss.origin, 256 );
        }
        
        if ( var_9e3b54a70ee22a87 < userdata.var_e3ea4b4047a82291 )
        {
            var_ab8007f32d8a3abe = userdata get_current_health();
            
            if ( !isdefined( var_ab8007f32d8a3abe ) )
            {
                return false;
            }
            
            if ( var_ab8007f32d8a3abe <= userdata.var_400228510f338a3a )
            {
                n_enemies_total = userdata.var_9f1e3d1d5eca5857 + userdata.var_264c033b7f94e6c5 + userdata.var_a4eb7594f9bf23a3;
            }
            else if ( var_ab8007f32d8a3abe <= userdata.var_5efb395e6b88cee8 )
            {
                n_enemies_total = userdata.var_264c033b7f94e6c5 + userdata.var_a4eb7594f9bf23a3;
            }
            else
            {
                n_enemies_total = userdata.var_a4eb7594f9bf23a3;
            }
            
            if ( n_enemies_total > var_9e3b54a70ee22a87 + userdata.var_80b3ef000405f99e )
            {
                userdata.floodfill_paused = 0;
                return true;
            }
            
            if ( userdata.var_80b3ef000405f99e >= n_enemies_total )
            {
                userdata.floodfill_paused = 1;
            }
            
            return false;
        }
    }
    
    return true;
}

// Namespace ob_activity_quarantine_island
// Params 2, eflags: 0x4
// Checksum 0x228b8d07, Offset: 0x218e
// Size: 0x16, Type: bool
function private function_3318bd915c3c29be( params, userdata )
{
    return false;
}

// Namespace ob_activity_quarantine_island
// Params 0, eflags: 0x4
// Checksum 0x92b92aa8, Offset: 0x21ad
// Size: 0x67
function private function_2bc04886d2f642a()
{
    self endon( #"activity_ended" );
    self endon( #"instance_destroyed" );
    self endon( #"nest_cleared" );
    
    while ( true )
    {
        wait 5;
        
        if ( self.floodfill_paused )
        {
            if ( self.var_3ddf278a43256d8d < gettime() - 5000 )
            {
                self.var_80b3ef000405f99e -= 1;
            }
        }
    }
}

// Namespace ob_activity_quarantine_island
// Params 2
// Checksum 0x655c1728, Offset: 0x221c
// Size: 0xe4, Type: bool
function function_451ad7c95d7c78ae( encounterid, userdata )
{
    if ( encounterid == userdata.flower_encounterid )
    {
        if ( !isdefined( userdata.started ) )
        {
            return false;
        }
        
        if ( !userdata.var_8f65d759d8c5dc75 )
        {
            userdata.var_8f65d759d8c5dc75 = 0;
        }
        
        var_9e3b54a70ee22a87 = function_da26e38f24f90f2f( encounterid );
        
        if ( var_9e3b54a70ee22a87 < 15 && userdata.var_58f16cb9744ac1d5 > userdata.var_8f65d759d8c5dc75 )
        {
            userdata.var_8f65d759d8c5dc75 = userdata.var_58f16cb9744ac1d5;
            function_1ac3703e7bc56a8( userdata.flower_encounterid, userdata.var_a2ed9abc2487b403, 64 );
            wait 0.25;
            return true;
        }
        else
        {
            userdata.var_8f65d759d8c5dc75 = userdata.var_58f16cb9744ac1d5;
            return false;
        }
    }
    
    return true;
}

// Namespace ob_activity_quarantine_island
// Params 2
// Checksum 0x192cfc64, Offset: 0x2309
// Size: 0x16, Type: bool
function function_1e5a62f7153fc8c9( params, userdata )
{
    return false;
}

// Namespace ob_activity_quarantine_island
// Params 0, eflags: 0x4
// Checksum 0xee7ad684, Offset: 0x2328
// Size: 0x11e
function private function_ebef81106cdde6c7()
{
    if ( self.playerparticipants.size )
    {
        centerpoint = self.playerparticipants[ 0 ].origin;
    }
    else
    {
        centerpoint = self.s_center.origin;
    }
    
    if ( !self.var_1fea009a8b8e3d5b )
    {
        vo_options = [ "convo_falkner_intro_david", "convo_falkner_intro_5050", "convo_falkner_intro_harper", "convo_falkner_intro_samuels", "convo_falkner_intro_nohero" ];
        overlord::playconversation( utility::array_random( vo_options ), self.playerparticipants );
        self.var_1fea009a8b8e3d5b = 1;
    }
    else
    {
        overlord::playevent( "vo_falkner_return", self.playerparticipants );
    }
    
    self.boss_encounter_id = activity_ai_encounters::function_eb8506829193f5eb( %"hash_60b4c79cd2654f9d", centerpoint, 500, 1, 1, 1, 0 );
    function_64ac8c4e752f4dca( self.boss_encounter_id, 0 );
    
    if ( isdefined( self.boss_encounter_id ) )
    {
        activity_ai_encounters::function_52d1342183200a8f( self.boss_encounter_id, &function_cf76c5654595b986, self );
    }
}

// Namespace ob_activity_quarantine_island
// Params 0
// Checksum 0xd0aef35a, Offset: 0x244e
// Size: 0xaf
function spawn_encounter_bosses()
{
    self notify( #"hash_350d81c360c63696" );
    self endon( #"hash_350d81c360c63696" );
    self endon( #"hash_1cca761071eadcf1" );
    health_threshold = self.var_2ecaecd2562f45e * 0.1;
    var_ce2731053e0369a6 = self.var_2ecaecd2562f45e;
    
    while ( true )
    {
        wait 0.5;
        self.var_ab8007f32d8a3abe = get_current_health();
        
        if ( var_ce2731053e0369a6 - self.var_ab8007f32d8a3abe >= health_threshold )
        {
            var_ce2731053e0369a6 -= health_threshold;
            function_ebef81106cdde6c7();
        }
        
        if ( self.var_ab8007f32d8a3abe <= self.var_2ecaecd2562f45e * 0.1 )
        {
            break;
        }
    }
}

// Namespace ob_activity_quarantine_island
// Params 0, eflags: 0x4
// Checksum 0x5483a0fa, Offset: 0x2505
// Size: 0x51
function private spawn_disciple_boss()
{
    activityinstance = self;
    var_65b8a77d2eaddba7 = activityinstance activity_ai_encounters::function_92b671064b0b1ce2( "quarantine_island_disciple_boss_encounter", 0, 1, 1, 0 );
    activityinstance activity_ai_encounters::function_52d1342183200a8f( var_65b8a77d2eaddba7, &function_bc913628609156b0, activityinstance );
    function_ef57f478f96b050c( var_65b8a77d2eaddba7, 1 );
    self.boss_encounter_id = var_65b8a77d2eaddba7;
}

// Namespace ob_activity_quarantine_island
// Params 4, eflags: 0x4
// Checksum 0x6143c8c3, Offset: 0x255e
// Size: 0x1b2
function private function_bc913628609156b0( requestid, activityinstance, agent, data )
{
    agent.activityinstance = activityinstance;
    agent.var_789b7a49ee864fec = activityinstance namespace_d7fa4530141146a5::function_de87bf7072515cd3( "sat_ob_quarantine_island_disciple_boss_marker", 0, 1 );
    objidpoolmanager::update_objective_onentity( agent.var_789b7a49ee864fec, agent );
    agent callback::add( #"on_ai_killed", &function_d95900ae8256eaf9 );
    agent callback::add( #"on_ai_killed", &function_c236ac0f808adf07 );
    agent.var_a13bed1ac47e1b2c = 1;
    agent.tether_heal_disable = 1;
    agent function_fa32376aaa88a7a2( agent.origin, 4000 );
    agent.ob_boss_healthbar_priority = 1;
    activityinstance.final_boss_spawned = 1;
    activityinstance.final_boss = agent;
    
    foreach ( player in activityinstance.playerparticipants )
    {
        agent getenemyinfo( player );
    }
    
    agent update_boss_healthbar();
    agent callback::add( "on_zombie_ai_damaged", &function_f49d8de897904a01 );
    agent zombie_utils::function_dfae6a5bd222c586( &function_a0da7c1ccc848222 );
    
    /#
        if ( getdvarint( @"hash_2b80d2d1cd1f3c27", 0 ) )
        {
            agent ai::set_ai_max_health( 10000 );
        }
    #/
}

// Namespace ob_activity_quarantine_island
// Params 1
// Checksum 0xbff9fdd8, Offset: 0x2718
// Size: 0xdf
function function_c236ac0f808adf07( params )
{
    if ( self.activityinstance.a_bosses.size > 0 )
    {
        foreach ( boss in self.activityinstance.a_bosses )
        {
            boss dodamage( boss.health, boss.origin );
        }
    }
    
    if ( self.death_source != "despawn" )
    {
        self.activityinstance function_a9ddd35121f9c2bf( self );
    }
}

// Namespace ob_activity_quarantine_island
// Params 1, eflags: 0x4
// Checksum 0x1aa6e3bc, Offset: 0x27ff
// Size: 0x1ba
function private function_a9ddd35121f9c2bf( agent )
{
    activityinstance = self;
    activityinstance endon( #"activity_ended" );
    activityinstance endon( #"instance_destroyed" );
    activityinstance notify( #"falkner_killed" );
    
    foreach ( player in activityinstance.playerparticipants )
    {
        if ( player.var_71c37977095602df == "ob_boss_falkner" )
        {
            player ob_story_mission_utils::function_5a707116af438c92();
        }
    }
    
    thread function_8ca6d59d3cdd1b4a( agent.origin, agent.angles );
    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( agent.origin, agent.angles );
    exotic_weapon = common_item::function_61c2c0251e742ffd( %"hash_6746660b468e32bb", undefined, spawnoptions );
    exotic_weapon.scriptable_index = exotic_weapon getscriptableindex();
    
    foreach ( player in activityinstance.playerparticipants )
    {
        player calloutmarkerping::function_920a63c06abdefe8( exotic_weapon.scriptable_index );
    }
}

// Namespace ob_activity_quarantine_island
// Params 2, eflags: 0x4
// Checksum 0xcd6150cc, Offset: 0x29c1
// Size: 0x1c3
function private function_8ca6d59d3cdd1b4a( agent_origin, angles )
{
    origin = getgroundposition( agent_origin, 15 );
    scriptable = spawnscriptable( "sat_ob_quarantine_island_fake_boss_vfx", origin, angles );
    scriptable setscriptablepartstate( "body", "cradle_spawn_start" );
    wait 1;
    activityinstance = self;
    animnode = { #angles:angles, #origin:origin };
    animnode scene::set_scriptbundle( "scene_sat_endgame_quarantine_island_falkner_dead" );
    animnode thread scene::play();
    activityinstance.falkner_animnode = animnode;
    interact_scriptable = spawnscriptable( "sat_ob_quarantine_island_hvt_interact", origin, angles );
    interact_scriptable setscriptablepartstate( "interact", "usable" );
    activityinstance.interact_scriptable = interact_scriptable;
    interact = interaction::register_scriptable_interact( interact_scriptable, &function_bf829b0db1d1d7d4 );
    interact.activity_instance = activityinstance;
    interact_scriptable function_7653c765b6c7b815();
    
    foreach ( player in activityinstance.playerparticipants )
    {
        interact_scriptable enablescriptableplayeruse( player );
    }
    
    activityinstance.var_8af354fddb48614f = activityinstance namespace_d7fa4530141146a5::function_de87bf7072515cd3( "sat_ob_quarantine_island_falkner_marker", 0, 1 );
    objidpoolmanager::update_objective_position( activityinstance.var_8af354fddb48614f, origin );
    wait randomfloatrange( 2.5, 4 );
    scriptable freescriptable();
}

// Namespace ob_activity_quarantine_island
// Params 1, eflags: 0x4
// Checksum 0xf0dcfb61, Offset: 0x2b8c
// Size: 0x8d
function private function_bf829b0db1d1d7d4( player )
{
    interact = self;
    
    if ( player.var_19fcd75db86e0a15 )
    {
        return;
    }
    
    interact disablescriptableplayeruse( player );
    objidpoolmanager::objective_playermask_hidefrom( interact.activity_instance.var_8af354fddb48614f, player );
    player.var_19fcd75db86e0a15 = 1;
    level overlord::playconversation( "convo_endgame_success_part1", [ player ] );
    level thread overlord::playevent( "vo_falkner_endgame_success_part2", [ player ] );
    function_e2e0304dba81bd86( player );
}

// Namespace ob_activity_quarantine_island
// Params 4, eflags: 0x4
// Checksum 0x2580c374, Offset: 0x2c21
// Size: 0x7e
function private function_64015a02e5cd3b4a( requestid, userdata, agent, data )
{
    agent endon( #"death" );
    
    if ( isalive( agent ) )
    {
        agent function_fa32376aaa88a7a2( agent.origin, 4000 );
        agent.activityinstance = userdata;
        agent region_difficulty_manager::function_410b4f83b0a5b98( agent.activityinstance.difficulty_region );
    }
}

// Namespace ob_activity_quarantine_island
// Params 4, eflags: 0x4
// Checksum 0x96fa677c, Offset: 0x2ca7
// Size: 0xb4
function private function_8508a93f90edb25( requestid, userdata, agent, data )
{
    agent endon( #"death" );
    activityinstance = userdata;
    
    if ( isalive( agent ) )
    {
        target = utility::array_random( activityinstance.nearby_players );
        agent region_difficulty_manager::function_410b4f83b0a5b98( activityinstance.difficulty_region );
        agent function_fa32376aaa88a7a2( agent.origin, 4000 );
        agent callback::add( #"on_ai_killed", &function_f923300894bf44bc );
        agent.activityinstance = activityinstance;
    }
}

// Namespace ob_activity_quarantine_island
// Params 1, eflags: 0x4
// Checksum 0x3a638ec5, Offset: 0x2d63
// Size: 0x44
function private function_f923300894bf44bc( params )
{
    if ( self.activityinstance )
    {
        self.activityinstance.var_80b3ef000405f99e++;
        self.activityinstance.var_3ddf278a43256d8d = gettime();
    }
}

// Namespace ob_activity_quarantine_island
// Params 4, eflags: 0x4
// Checksum 0xe7f622c9, Offset: 0x2daf
// Size: 0x148
function private function_cf76c5654595b986( requestid, userdata, agent, data )
{
    activityinstance = userdata;
    
    if ( isalive( agent ) && isdefined( activityinstance ) && activityinstance.state == "Active" )
    {
        agent.activityinstance = activityinstance;
        agent.var_789b7a49ee864fec = activityinstance namespace_d7fa4530141146a5::function_de87bf7072515cd3( "sat_ob_quarantine_island_boss_marker", 0, 1 );
        objidpoolmanager::update_objective_onentity( agent.var_789b7a49ee864fec, agent );
        agent utility::ent_flag_set( "ghoul_evolve_disabled" );
        agent callback::add( #"on_ai_killed", &function_d95900ae8256eaf9 );
        agent callback::add( "on_zombie_ai_damaged", &function_6f82158381305ca7 );
        agent region_difficulty_manager::function_410b4f83b0a5b98( activityinstance.difficulty_region );
        agent.var_a13bed1ac47e1b2c = 1;
        
        if ( !isdefined( activityinstance.a_bosses ) )
        {
            activityinstance.a_bosses = [];
        }
        
        activityinstance.a_bosses[ activityinstance.a_bosses.size ] = agent;
        return;
    }
    
    assertmsg( "<dev string:x29>" );
    activityinstance notify( #"boss_killed" );
}

// Namespace ob_activity_quarantine_island
// Params 1
// Checksum 0xecfb30b7, Offset: 0x2eff
// Size: 0xdb
function function_d95900ae8256eaf9( params )
{
    if ( isdefined( self.activityinstance ) && self.activityinstance.state == "Active" )
    {
        self.activityinstance namespace_d7fa4530141146a5::function_501e44ea1cb9219d( self.var_789b7a49ee864fec );
        self.activityinstance.a_bosses = arrayremove( self.activityinstance.a_bosses, self );
        
        if ( self.death_source == "despawn" )
        {
            return;
        }
        
        if ( !self.activityinstance.var_cfecca66474f9f5d )
        {
            self.activityinstance.var_cfecca66474f9f5d = 1;
            level thread overlord::playevent( "vo_falkner_first_kill", self.activityinstance.playerparticipants );
        }
    }
}

// Namespace ob_activity_quarantine_island
// Params 0
// Checksum 0x1804b93d, Offset: 0x2fe2
// Size: 0xdd
function function_98bf2a2296f3bbd8()
{
    self.a_bosses = utility::array_removedead_or_dying( self.a_bosses );
    
    if ( !isdefined( self.a_bosses ) || self.a_bosses.size == 0 )
    {
        return;
    }
    
    foreach ( boss in self.a_bosses )
    {
        boss.activityinstance namespace_d7fa4530141146a5::function_501e44ea1cb9219d( boss.var_789b7a49ee864fec );
        boss callback::remove( #"on_ai_killed", &function_d95900ae8256eaf9 );
    }
}

// Namespace ob_activity_quarantine_island
// Params 1
// Checksum 0xb3fc33ad, Offset: 0x30c7
// Size: 0xb1
function function_6f82158381305ca7( dmg_struct )
{
    if ( dmg_struct.idamage > self.health )
    {
        if ( !isexplosivedamagemod( dmg_struct.smeansofdeath ) && !utility::isimpactdamage( dmg_struct.smeansofdeath ) )
        {
            self.death_fx_wait_time = 2.9 + level.framedurationseconds;
        }
    }
    
    if ( self.health < self.maxhealth * 0.7 )
    {
        thread function_67700e9452561ae3( self.origin, self.angles );
        self.nocorpse = 1;
        wait 0.2;
        self kill();
    }
}

// Namespace ob_activity_quarantine_island
// Params 2, eflags: 0x4
// Checksum 0xf4528bb4, Offset: 0x3180
// Size: 0x6e
function private function_67700e9452561ae3( origin, angles )
{
    var_3ab079f07862c8b7 = origin + ( 0, 0, 24 );
    scriptable = spawnscriptable( "sat_ob_quarantine_island_fake_boss_vfx", var_3ab079f07862c8b7, angles );
    scriptable setscriptablepartstate( "body", "cradle_spawn_start" );
    wait randomfloatrange( 3.5, 5 );
    scriptable freescriptable();
}

// Namespace ob_activity_quarantine_island
// Params 1
// Checksum 0x44e25a25, Offset: 0x31f6
// Size: 0x6c
function function_f49d8de897904a01( dmg_struct )
{
    if ( dmg_struct.idamage > self.health )
    {
        if ( !isexplosivedamagemod( dmg_struct.smeansofdeath ) && !utility::isimpactdamage( dmg_struct.smeansofdeath ) )
        {
            self.death_fx_wait_time = 2.9 + level.framedurationseconds;
        }
    }
    
    update_boss_healthbar();
}

// Namespace ob_activity_quarantine_island
// Params 1, eflags: 0x4
// Checksum 0x35e1ad1b, Offset: 0x326a
// Size: 0x5e
function private function_a0da7c1ccc848222( dmg_struct )
{
    damage = dmg_struct.idamage;
    
    if ( dmg_struct.objweapon.basenamehash == %"death_machine_sat_ob" )
    {
        damage *= getdvarfloat( @"hash_1c5b06ca10d4c781", 0.5 );
    }
    
    return damage;
}

// Namespace ob_activity_quarantine_island
// Params 1, eflags: 0x4
// Checksum 0xd6ea099f, Offset: 0x32d1
// Size: 0xd0
function private function_8878a4153f4ddcbd( player )
{
    player endon( #"disconnect" );
    
    if ( !player zombie_boss_healthbar::function_44d523f97fcaa324() )
    {
        if ( !player.var_71c37977095602df )
        {
            player ob_story_mission_utils::function_16e0adef86e5d052( "ob_boss_falkner", self );
        }
        else if ( player.var_71c37977095602df == "ob_boss_falkner" )
        {
            player ob_story_mission_utils::player_boss_healthbar_show();
        }
        else if ( player ob_story_mission_utils::function_6ec505041dcea08e( self ) )
        {
            player ob_story_mission_utils::function_5a707116af438c92();
            player ob_story_mission_utils::function_16e0adef86e5d052( "ob_boss_falkner", self );
        }
    }
    else if ( player ob_story_mission_utils::function_6ec505041dcea08e( self ) )
    {
        player ob_story_mission_utils::function_5a707116af438c92();
        player ob_story_mission_utils::function_16e0adef86e5d052( "ob_boss_falkner", self );
    }
    
    if ( player.var_71c37977095602df == "ob_boss_falkner" )
    {
        player ob_story_mission_utils::function_e231206f1628d4c6( 1 );
    }
}

// Namespace ob_activity_quarantine_island
// Params 0, eflags: 0x4
// Checksum 0xd18bc554, Offset: 0x33a9
// Size: 0x85
function private update_boss_healthbar()
{
    foreach ( player in self.activityinstance.playerparticipants )
    {
        thread function_8878a4153f4ddcbd( player );
    }
}

// Namespace ob_activity_quarantine_island
// Params 1
// Checksum 0x45a1a353, Offset: 0x3436
// Size: 0x19
function function_44ec91ea48500936( obj )
{
    if ( isdefined( obj ) )
    {
        obj delete();
    }
}

// Namespace ob_activity_quarantine_island
// Params 1
// Checksum 0x5dfb4f06, Offset: 0x3457
// Size: 0x5a
function function_fec785b14862caa0( relevantinfostruct )
{
    var_983974fc347bb3cb = spawnstruct();
    var_983974fc347bb3cb.origin = self.s_center.origin;
    var_983974fc347bb3cb.angles = self.s_center.angles;
}

// Namespace ob_activity_quarantine_island
// Params 1
// Checksum 0x5ce0ea92, Offset: 0x34b9
// Size: 0x71
function function_b37b142675bcd25e( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    var_99e714060e093089 = relevant_info_struct.playerjoinreason;
    self notify( #"hash_3aefff10778f0131" );
    ob_activity_definition_utils::function_f23bdcfc447427ae( undefined, self.var_58f16cb9744ac1d5, self.var_2541d1c0b34aefc3 );
    level musicbank_utility::function_5aca66c390aa347d( player_list, #"hash_dc8288d3dfd2bf3d" );
}

// Namespace ob_activity_quarantine_island
// Params 1
// Checksum 0x3cfca4c2, Offset: 0x3532
// Size: 0x134
function function_6e24c25d25963496( relevant_info_struct )
{
    player_list = relevant_info_struct.playerlist;
    level musicbank_utility::function_4f253fd35ec68cbc( player_list, #"hash_dc8288d3dfd2bf3d" );
    
    foreach ( player in player_list )
    {
        if ( isplayer( player ) )
        {
            if ( isdefined( self ) && self.state != "Ended" )
            {
                if ( !self.quarantine_island_activity_success )
                {
                    overlord::playevent( "vo_quarantine_zone_player_left", [ player ] );
                }
                
                if ( isplayer( player ) && player zombie_boss_healthbar::function_44d523f97fcaa324() && player.var_71c37977095602df == "ob_boss_falkner" )
                {
                    player ob_story_mission_utils::function_5a707116af438c92();
                }
            }
            
            player notify( #"left_quarantine_zone" );
        }
    }
    
    if ( self.playerparticipants.size == 0 )
    {
        thread function_7f216ad0f1f6694b();
    }
}

// Namespace ob_activity_quarantine_island
// Params 0
// Checksum 0x2fc70238, Offset: 0x366e
// Size: 0x1c9
function function_7f216ad0f1f6694b()
{
    self notify( #"hash_c1caedc9dbf37d67" );
    self endon( #"hash_c1caedc9dbf37d67" );
    self endon( #"instance_destroyed" );
    self endon( #"activity_ended" );
    self endon( #"hash_3aefff10778f0131" );
    qi_reset_time = getdvarint( @"hash_bb00ccb78d660f70", 240 );
    wait qi_reset_time;
    self notify( #"hash_1cca761071eadcf1" );
    
    if ( self.quarantine_island_activity_success )
    {
        self.interact_scriptable freescriptable();
        self.falkner_animnode scene::stop();
        activity_instance_common::function_9aeeabe50fc9cc3e( self );
        return;
    }
    
    foreach ( cyst in self.destroyed_cysts )
    {
        cyst.cyst_health = 100;
        cyst setscriptablepartstate( "body", "pristine" );
        cyst setscriptablepartstate( "health", "damage_detect" );
        cyst.health = 100;
        cyst.a_player_assist = [];
        cyst.destroyed = 0;
        cyst.activity_instance = self;
    }
    
    self.destroyed_cysts = [];
    self.var_58f16cb9744ac1d5 = 0;
    activity_definition_utils::updateprogress( 0, self );
    self.var_c2127c21995e9409 = self.var_2ecaecd2562f45e;
    
    if ( self.boss_encounter_id )
    {
        function_64ac8c4e752f4dca( self.boss_encounter_id, 1 );
    }
    
    stop_all_spawns( 1 );
    thread quarantine_island_activity_begin();
}

// Namespace ob_activity_quarantine_island
// Params 1
// Checksum 0x1d310697, Offset: 0x383f
// Size: 0x29f
function quarantine_island_activity_ended( activity_succeeded )
{
    self endon( #"instance_destroyed" );
    thread activity_ai_encounters::function_ef590f5a067bcaf5();
    level musicbank_utility::function_4f253fd35ec68cbc( self.playerparticipants, #"hash_dc8288d3dfd2bf3d" );
    
    foreach ( player in self.playerparticipants )
    {
        squadmembers = player squad_utility::getsquadmembers();
        squad_on_mission = ob_activity_vo_utility::function_9d4e8b8c2a6ccc45( 17086, "quest_s0_a3t4_springcln_success", squadmembers );
        
        if ( !squad_on_mission )
        {
            if ( utility::percent_chance( 50 ) )
            {
                var_ca461ac67741e21e = [ "zm_stronghold_clear_ravenov_miller", "zm_stronghold_clear_ravenov_greene", "zm_stronghold_clear_ravenov_barrera" ];
                thread activity_player_broadcasting::function_cb4750c84882dd07( var_ca461ac67741e21e[ randomint( 3 ) ], [ player ] );
                continue;
            }
            
            thread activity_player_broadcasting::function_cb4750c84882dd07( "zm_stronghold_clear_ravenov_noresp", [ player ] );
        }
    }
    
    if ( isdefined( self.scriptable ) )
    {
        self.scriptable freescriptable();
    }
    
    if ( isdefined( self.var_a2bed8e497f66fe5 ) )
    {
        foreach ( Gas in self.var_a2bed8e497f66fe5 )
        {
            Gas setscriptablepartstate( #"state", #"hidden" );
        }
    }
    
    if ( isdefined( self.var_1b94794135ef7044 ) )
    {
        foreach ( vfx in self.var_1b94794135ef7044 )
        {
            function_44ec91ea48500936( vfx );
        }
    }
    
    if ( isdefined( self.var_592890cbcd7cfad1 ) && self.var_592890cbcd7cfad1.size > 0 )
    {
        ob_soldier_util::function_3604220db3a0a0cf( self.var_592890cbcd7cfad1 );
    }
    
    ob_activity_utility::ob_disable_cover_nodes();
}

// Namespace ob_activity_quarantine_island
// Params 0
// Checksum 0x81891c5, Offset: 0x3ae6
// Size: 0xb6
function function_f264825de0a633()
{
    self endon( #"instance_destroyed" );
    thread activity_ai_encounters::function_ef590f5a067bcaf5();
    
    if ( isdefined( self.var_1b94794135ef7044 ) )
    {
        foreach ( vfx in self.var_1b94794135ef7044 )
        {
            function_44ec91ea48500936( vfx );
        }
    }
    
    if ( isdefined( self.scriptable ) )
    {
        self.scriptable freescriptable();
    }
}

/#

    // Namespace ob_activity_quarantine_island
    // Params 0
    // Checksum 0x9b02940e, Offset: 0x3ba4
    // Size: 0x5, Type: dev
    function function_f6d5e7607c0c23ea()
    {
        
    }

#/

// Namespace ob_activity_quarantine_island
// Params 1, eflags: 0x4
// Checksum 0x7cd43e53, Offset: 0x3bb1
// Size: 0x1c1
function private function_e2e0304dba81bd86( player )
{
    player endon( #"death_or_disconnect" );
    player.exfildoorused = 1;
    player.b_completed_exfil = 1;
    player.var_22bd8935826c4bc5 = 1;
    player.var_bdeeca1e699ddbdb = 1;
    player common_instance_inventory::function_b1b5b47fe399f1e7( 1 );
    
    if ( !player.inventoryfinalized )
    {
        player common_instance_inventory::function_8fd84f733b81e456();
    }
    
    var_fdc2f46ee7c362b6 = player getplayerdata( level.var_6f9b00680ed002d8, "hasCompletedEndGameBoss" );
    player setplayerdata( level.var_6f9b00680ed002d8, "hasCompletedEndGameBoss", 1 );
    player setplayerdata( level.var_6f9b00680ed002d8, "firstTimeEndGameCredits", var_fdc2f46ee7c362b6 == 0 );
    
    if ( !isdefined( player.s_exfil ) )
    {
        player.s_exfil = {};
    }
    
    player.s_exfil.origin = player.origin;
    player val::set( "exfil", "ignoreme", 1 );
    player val::set( "exfil", "freezecontrols", 1 );
    player val::set( "exfil", "damage", 0 );
    player val::set( "exfil", "weapon", 0 );
    player val::set( "exfil", "breath_system", 0 );
    player val::set( "exfil", "cg_drawcrosshair", 0 );
    player val::set( "exfil", "show_weapon_hud", 0 );
    player cleardamageindicators();
    wait 0.35;
    player playerhide();
    player function_653663dfacfb73da( var_fdc2f46ee7c362b6 != 0 );
    thread ob_exfil::function_7945ba0143ab037d( player, #"hash_8387230f6a9afb9c" );
}

// Namespace ob_activity_quarantine_island
// Params 1
// Checksum 0x2bcbcd9c, Offset: 0x3d7a
// Size: 0xc7
function function_653663dfacfb73da( skippable )
{
    self endon( #"death_or_disconnect" );
    overlay_state_off = 0;
    var_a0559c761d5a74bb = 5;
    var_33f5b5f4851b6009 = 60;
    isencrypted = 0;
    self setclientomnvar( "ui_coop_bink_overlay_state", var_a0559c761d5a74bb );
    self setclientomnvar( "ui_is_bink_skippable", skippable );
    var_3a2e6ef0dea2917f = "sat_endgame_outro";
    flag = "bink_complete" + "_" + var_3a2e6ef0dea2917f;
    self.waitingmovie = var_3a2e6ef0dea2917f;
    utility::ent_flag_clear( flag, 1 );
    self playcinematicforplayer( var_3a2e6ef0dea2917f, 1, isencrypted );
    utility::ent_flag_wait( flag );
    self stopcinematicforplayer();
    self setclientomnvar( "ui_coop_bink_overlay_state", overlay_state_off );
}

/#

    // Namespace ob_activity_quarantine_island
    // Params 0
    // Checksum 0x7db44c74, Offset: 0x3e49
    // Size: 0xda, Type: dev
    function debug_cyst()
    {
        level endon( #"game_ended" );
        self endon( #"death" );
        
        while ( true )
        {
            if ( !isdefined( self ) )
            {
                return;
            }
            
            if ( getdvarint( @"hash_3114c84b5ad2054a", 0 ) )
            {
                if ( self getscriptablepartstate( "<dev string:x74>" ) != "<dev string:x79>" )
                {
                    /#
                        sphere( self.origin, 32, ( 1, 1, 0 ), 0, int( 1 / ( level.framedurationseconds ?? 0.48 ) ) );
                    #/
                    
                    self setscriptablepartstate( #"debug", #"on" );
                }
                else
                {
                    self setscriptablepartstate( #"debug", #"off" );
                }
            }
            else
            {
                self setscriptablepartstate( #"debug", #"off" );
            }
            
            wait 1;
        }
    }

    // Namespace ob_activity_quarantine_island
    // Params 0
    // Checksum 0x35f36b5f, Offset: 0x3f2b
    // Size: 0x82, Type: dev
    function debug_boss_spawn()
    {
        level endon( #"game_ended" );
        self endon( #"activity_ended" );
        self endon( #"instance_destroyed" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_c08965ff0cb719e5", 0 ) )
            {
                setdvar( @"hash_c08965ff0cb719e5", 0 );
                function_ebef81106cdde6c7();
            }
            
            if ( getdvarint( @"spawn_disciple_boss", 0 ) )
            {
                setdvar( @"spawn_disciple_boss", 0 );
                spawn_disciple_boss();
            }
            
            wait 1;
        }
    }

    // Namespace ob_activity_quarantine_island
    // Params 0
    // Checksum 0xa3f601e0, Offset: 0x3fb5
    // Size: 0x107, Type: dev
    function debug_difficulty_region()
    {
        while ( true )
        {
            dvar_val = getdvarint( @"island_difficulty", 0 );
            
            if ( dvar_val )
            {
                switch ( dvar_val )
                {
                    case 1:
                        self.difficulty_region = "<dev string:x83>";
                        break;
                    case 2:
                        self.difficulty_region = "<dev string:x93>";
                        break;
                    case 3:
                        self.difficulty_region = "<dev string:xa5>";
                        break;
                    case 4:
                        self.difficulty_region = "<dev string:xb5>";
                        break;
                    case 5:
                        self.difficulty_region = "<dev string:xcb>";
                        break;
                    case 6:
                        self.difficulty_region = "<dev string:xd7>";
                        break;
                }
                
                setdvar( @"island_difficulty", 0 );
                iprintlnbold( "<dev string:xe3>" + string( dvar_val ) );
            }
            
            wait 1;
        }
    }

    // Namespace ob_activity_quarantine_island
    // Params 0
    // Checksum 0xfe590483, Offset: 0x40c4
    // Size: 0x60, Type: dev
    function function_7516304bb8d6a60d()
    {
        level endon( #"game_ended" );
        self endon( #"activity_ended" );
        self endon( #"instance_destroyed" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_75ed64bd458e6e50", 0 ) )
            {
                setdvar( @"hash_75ed64bd458e6e50", 0 );
                coop::play_cinematic( "<dev string:x104>" );
            }
            
            wait 1;
        }
    }

    // Namespace ob_activity_quarantine_island
    // Params 0
    // Checksum 0x3eb22b6a, Offset: 0x412c
    // Size: 0x60, Type: dev
    function debug_nest_cleared()
    {
        level endon( #"game_ended" );
        self endon( #"activity_ended" );
        self endon( #"instance_destroyed" );
        
        while ( true )
        {
            if ( getdvarint( @"scr_ob_nest_cleared", 0 ) )
            {
                setdvar( @"scr_ob_nest_cleared", 0 );
                self notify( #"nest_cleared" );
            }
            
            wait 1;
        }
    }

#/
