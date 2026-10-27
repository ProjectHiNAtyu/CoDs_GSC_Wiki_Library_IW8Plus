// scripts\mp\snd\snd_ob.gsc  (hash_7e49e414c2648d6f.gscc) (size: 20470 Bytes / 0x4ff6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x96edba57 (2532162135)
// size ...... 20470 (0x4ff6)
// includes .. 7   (offset: 0x48ba)
// strings ... 105 (offset: 0x48f2)
// dev strs .. 18  (offset: 0x4f1e)
// exports ... 43  (offset: 0x370a)
// cseg ...... 0xa28 + 0x2ce2 (0x370a)
// imports ... 82  (offset: 0x3dc2)
// animtree1 . 0   (offset: 0x4ff6)
// animtree2 . 0   (offset: 0x4ff6)
#using scripts\common\callbacks;
#using scripts\common\snd\snd;
#using scripts\common\snd\snd_draw;
#using scripts\common\snd\snd_utility;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\teams;

#namespace snd_ob;

// Namespace snd_ob
// Params 0, eflags: 0x1
// Checksum 0x1b998f7e, Offset: 0xa46
// Size: 0x92
function autoexec ob_init()
{
    gametype = game_utility::getgametype();
    mapname = game_utility::getmapname();
    
    if ( gametype != "ob" )
    {
        return;
    }
    
    snd::wait_init();
    function_42d29227e433ee05();
    level thread _ob_start();
    level callback::add( #"player_connect", &onplayerconnect );
    level callback::add( "rusher_agent_setup", &function_5e674991ecf1e515 );
    
    if ( issubstr( mapname, "avalon" ) )
    {
        level callback::add( #"hash_3c10b892d5a6a8cd", &function_3950578229fb5ca2 );
    }
}

/#

    // Namespace snd_ob
    // Params 1, eflags: 0x4
    // Checksum 0xcbcf10c, Offset: 0xae0
    // Size: 0xf, Type: dev
    function private function_9b6cdc1c2ed69efd( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace snd_ob
// Params 0, eflags: 0x4
// Checksum 0xc9c622e9, Offset: 0xaf7
// Size: 0x10f3
function private function_42d29227e433ee05()
{
    level.snd.var_53ca6d9f294d54ec = [];
    level.snd.var_53ca6d9f294d54ec[ "sat_leo_load" ] = { #fadeout:0.5, #duration:31.5, #fadein:0, #name:"solo_cin_igc" };
    level.snd.var_53ca6d9f294d54ec[ "sat_cin_leo_guild_facility_intro" ] = { #fadeout:1, #duration:94, #fadein:0.1, #name:"solo_cin_igc" };
    level.snd.var_53ca6d9f294d54ec[ "scene_sat_cin_leo_quantum_core" ] = { #fadeout:5, #duration:9, #fadein:5, #name:"solo_cin_igc_music_voiceover" };
    level.snd.var_53ca6d9f294d54ec[ "sat_leo_trapped" ] = { #fadeout:0.5, #duration:102.5, #fadein:0.1, #name:"solo_cin_igc_music" };
    level.snd.var_53ca6d9f294d54ec[ "sat_leo_igc_trans_nic" ] = { #fadeout:2, #duration:73, #fadein:0.1, #name:"solo_cin_igc_music" };
    level.snd.var_53ca6d9f294d54ec[ "scene_nic_face_to_face" ] = { #fadeout:3, #duration:46, #fadein:0.1, #name:"solo_cin_igc_music_voiceover" };
    level.snd.var_53ca6d9f294d54ec[ "scene_sat_cin_leo_menendez_boss_outro" ] = { #fadeout:2, #duration:43, #fadein:0.1, #name:"solo_cin_igc_music_voiceover" };
    level.snd.var_53ca6d9f294d54ec[ "sat_leo_outro" ] = { #fadeout:1, #duration:75.5, #fadein:3, #name:"solo_cin_igc" };
    level.snd.var_53ca6d9f294d54ec[ "sat_pisces_load" ] = { #fadeout:1, #duration:41, #fadein:0, #name:"solo_cin_igc" };
    level.snd.var_53ca6d9f294d54ec[ "sat_pisces_intro" ] = { #fadeout:4, #duration:16, #fadein:0.1, #name:"solo_cin_igc" };
    level.snd.var_53ca6d9f294d54ec[ "sat_pisces_shipyard" ] = { #fadeout:1.5, #duration:36.5, #fadein:0.1, #name:"solo_cin_igc" };
    level.snd.var_53ca6d9f294d54ec[ "aries_level_intro" ] = { #fadeout:2, #duration:76, #fadein:0, #name:"solo_cin_igc" };
    level.snd.var_53ca6d9f294d54ec[ "aries_nightmare" ] = { #fadeout:3, #duration:92, #fadein:0.1, #name:"solo_cin_igc_music" };
    level.snd.var_53ca6d9f294d54ec[ "sat_aries_boss_intro" ] = { #fadeout:1, #duration:65, #fadein:0.1, #name:"solo_cin_igc_music" };
    level.snd.var_53ca6d9f294d54ec[ "sat_aries_outro" ] = { #fadeout:1, #duration:79.5, #fadein:2, #name:"solo_cin_igc_music" };
    level.snd.var_53ca6d9f294d54ec[ "sat_sag_territory_load" ] = { #fadeout:2, #duration:43, #fadein:0.1, #name:"solo_cin_igc" };
    level.snd.var_53ca6d9f294d54ec[ "sat_sag_intro_flyby" ] = { #fadeout:1, #duration:23, #fadein:0.1, #name:"solo_cin_igc" };
    level.snd.var_53ca6d9f294d54ec[ "sat_priya_intro" ] = { #fadeout:3, #duration:20.8, #fadein:3, #name:"solo_cin_igc" };
    level.snd.var_53ca6d9f294d54ec[ "sat_stronghold_outro" ] = { #fadeout:1, #duration:40.5, #fadein:2, #name:"solo_cin_igc" };
    level.snd.var_53ca6d9f294d54ec[ "sat_capricorn_load" ] = { #fadeout:1, #duration:36, #fadein:0, #name:"solo_cin_igc" };
    level.snd.var_53ca6d9f294d54ec[ "sat_capricorn_tokyo_bay" ] = { #fadeout:2, #duration:78, #fadein:0.1, #name:"solo_cin_igc_music" };
    level.snd.var_53ca6d9f294d54ec[ "sat_scene_cin_hijacked_vip" ] = { #fadeout:2, #duration:31, #fadein:0.1, #name:"solo_cin_igc_music_voiceover" };
    level.snd.var_53ca6d9f294d54ec[ "sat_capricorn_boat_ram" ] = { #fadeout:0.5, #duration:43.5, #fadein:0.1, #name:"solo_cin_igc_music" };
    level.snd.var_53ca6d9f294d54ec[ "sat_capricorn_outro" ] = { #fadeout:1, #duration:82, #fadein:1.5, #name:"solo_cin_igc_music" };
    level.snd.var_53ca6d9f294d54ec[ "sat_aqua_load" ] = { #fadeout:0.5, #duration:40.5, #fadein:0.1, #name:"solo_cin_igc" };
    level.snd.var_53ca6d9f294d54ec[ "sat_cin_aqua_intro_flythrough" ] = { #fadeout:1, #duration:20, #fadein:0.1, #name:"solo_cin_igc" };
    level.snd.var_53ca6d9f294d54ec[ "sat_virgo_load" ] = { #fadeout:3, #duration:96, #fadein:0, #name:"solo_cin_igc" };
    level.snd.var_53ca6d9f294d54ec[ "sat_cin_virgo_enter_japan_void_1" ] = { #fadeout:4, #duration:103, #fadein:0.1, #name:"solo_cin_igc_music" };
    level.snd.var_53ca6d9f294d54ec[ "sat_cin_virgo_betrayal_memory_void_2" ] = { #fadeout:1, #duration:129, #fadein:0.1, #name:"solo_cin_igc_music" };
    level.snd.var_53ca6d9f294d54ec[ "scene_sat_cin_virgo_carrier_boss_outro" ] = { #fadeout:3, #duration:80, #fadein:2, #name:"solo_cin_igc_music_voiceover" };
    level.snd.var_53ca6d9f294d54ec[ "sat_virgo_outro" ] = { #fadeout:1, #duration:97.5, #fadein:4, #name:"solo_cin_igc_music" };
    level.snd.var_53ca6d9f294d54ec[ "sat_cancer_load" ] = { #fadeout:1, #duration:30, #fadein:0.1, #name:"solo_cin_igc" };
    level.snd.var_53ca6d9f294d54ec[ "sat_cancer_flyover" ] = { #fadeout:2, #duration:17, #fadein:0.1, #name:"solo_cin_igc" };
    level.snd.var_53ca6d9f294d54ec[ "sat_cancer_prelude" ] = { #fadeout:1.5, #duration:23.5, #fadein:1.5, #name:"solo_cin_igc" };
    level.snd.var_53ca6d9f294d54ec[ "sat_cancer_closer" ] = { #fadeout:1.5, #duration:74, #fadein:1.5, #name:"solo_cin_igc_music" };
    level.snd.var_53ca6d9f294d54ec[ "sat_gemini_intro_antechamber" ] = { #fadeout:1, #duration:52, #fadein:2, #name:"solo_cin_igc_music" };
    level.snd.var_53ca6d9f294d54ec[ "sat_gemini_control_room" ] = { #fadeout:1, #duration:47, #fadein:0.1, #name:"solo_cin_igc_music" };
    level.snd.var_53ca6d9f294d54ec[ "sat_gemini_cabin_exit" ] = { #fadeout:3, #duration:70, #fadein:0.1, #name:"solo_cin_igc_music" };
    level.snd.var_53ca6d9f294d54ec[ "sat_gemini_exfil" ] = { #fadeout:0.5, #duration:7.5, #fadein:0.1, #name:"solo_cin_igc_music" };
    level.snd.var_53ca6d9f294d54ec[ "sat_gemini_outro" ] = { #fadeout:1, #duration:86.5, #fadein:0, #name:"solo_cin_igc" };
    level.snd.var_53ca6d9f294d54ec[ "sat_taurus_load" ] = { #fadeout:1.5, #duration:39, #fadein:0, #name:"solo_cin_igc" };
    level.snd.var_53ca6d9f294d54ec[ "sat_cin_taurus_intro_flythrough" ] = { #fadeout:1, #duration:10.5, #fadein:0, #name:"solo_cin_igc" };
    level.snd.var_53ca6d9f294d54ec[ "sat_cin_taurus_razor_intro" ] = { #fadeout:0.5, #duration:39.5, #fadein:1, #name:"solo_cin_igc_music" };
    level.snd.var_53ca6d9f294d54ec[ "sat_cin_taurus_exfil" ] = { #fadeout:1.5, #duration:49, #fadein:2, #name:"solo_cin_igc_music" };
    level.snd.var_53ca6d9f294d54ec[ "sat_libra_load" ] = { #fadeout:0.5, #duration:29.5, #fadein:0.1, #name:"solo_cin_igc" };
    level.snd.var_53ca6d9f294d54ec[ "sat_libra_offshore_approach" ] = { #fadeout:2, #duration:100, #fadein:0.1, #name:"solo_cin_igc" };
    level.snd.var_53ca6d9f294d54ec[ "scene_sat_cin_libra_answers" ] = { #fadeout:2, #duration:38, #fadein:0.1, #name:"solo_cin_igc_music_voiceover" };
    level.snd.var_53ca6d9f294d54ec[ "sat_libra_igc_processing_center" ] = { #fadeout:1, #duration:44, #fadein:1, #name:"solo_cin_igc_music_voiceover" };
    level.snd.var_53ca6d9f294d54ec[ "sat_libra_boss_intro" ] = { #fadeout:1, #duration:82, #fadein:0.1, #name:"solo_cin_igc_music" };
    level.snd.var_53ca6d9f294d54ec[ "scene_sat_cin_libra_boss_phase_trans_01" ] = { #fadeout:0.5, #duration:12, #fadein:0.1, #name:"mp_sat_cin_libra_boss_igc_finisher" };
    level.snd.var_53ca6d9f294d54ec[ "sat_libra_boss_outro" ] = { #fadeout:3, #duration:175, #fadein:0.1, #name:"solo_cin_igc_music" };
    level.snd.var_53ca6d9f294d54ec[ "sat_libra_outro" ] = { #fadeout:0.5, #duration:104.5, #fadein:0, #name:"solo_cin_igc" };
}

// Namespace snd_ob
// Params 3, eflags: 0x4
// Checksum 0xe8eeb0a8, Offset: 0x1bf2
// Size: 0xf3
function private function_6e5a7a1eba18a484( duration, submix, fadeout = 0 )
{
    assert( isnumber( duration ) );
    assert( isstring( submix ) );
    self notify( "cinematic_submix_end_" + submix );
    self endon( "cinematic_submix_end_" + submix, #"disconnect" );
    
    if ( !isdefined( self.var_5d09e46f66c89e2f ) )
    {
        self.var_5d09e46f66c89e2f = [];
    }
    
    self.var_5d09e46f66c89e2f[ submix ] = 0;
    
    if ( duration > 0 )
    {
        wait duration;
    }
    
    self.var_5d09e46f66c89e2f[ submix ] = 1;
    self clearsoundsubmix( submix, fadeout );
    
    if ( duration > 0 && fadeout > 0 )
    {
        wait fadeout;
    }
    
    self.var_5d09e46f66c89e2f[ submix ] = undefined;
    
    if ( isarray( self.var_5d09e46f66c89e2f ) && self.var_5d09e46f66c89e2f.size == 0 )
    {
        self.var_5d09e46f66c89e2f = undefined;
    }
}

// Namespace snd_ob
// Params 0, eflags: 0x4
// Checksum 0x7dd3d164, Offset: 0x1ced
// Size: 0x1c4
function private function_764c25ad01479353()
{
    self notify( #"hash_1386a5a7a344a1f3" );
    self endon( #"hash_1386a5a7a344a1f3", #"disconnect" );
    assert( isarray( level.snd.var_53ca6d9f294d54ec ) );
    
    while ( isplayer( self ) )
    {
        utility::ent_flag_wait( "cinematic_playing" );
        waittillframeend();
        
        if ( isstring( self.waitingmovie ) )
        {
            submix = level.snd.var_53ca6d9f294d54ec[ self.waitingmovie ];
            
            if ( isstruct( submix ) && isstring( submix.name ) )
            {
                self setsoundsubmix( submix.name, submix.fadein, 1 );
                thread function_6e5a7a1eba18a484( submix.duration, submix.name, submix.fadeout );
                
                /#
                    if ( snd::function_542b9fda0c23d8f4() > 1 )
                    {
                        snd::timecode();
                        self notify( #"hash_9954a3ae99479d25" );
                    }
                #/
                
                utility::ent_flag_waitopen_any( "cinematic_playing" );
                
                if ( self.var_5d09e46f66c89e2f[ submix.name ] == 0 )
                {
                    function_6e5a7a1eba18a484( 0, submix.name, 0.5 );
                }
                
                /#
                    if ( snd::function_542b9fda0c23d8f4() > 1 )
                    {
                        snd::timecode_mark( "<dev string:x24>" );
                        utility::delaythreadendon( 10, "<dev string:x32>", &snd::timecode_stop );
                    }
                #/
                
                continue;
            }
            
            /#
                if ( snd::function_542b9fda0c23d8f4() > 0 )
                {
                    logstring( "<dev string:x47>" + self.waitingmovie + "<dev string:x79>" );
                }
            #/
            
            utility::ent_flag_waitopen_any( "cinematic_playing" );
        }
    }
}

// Namespace snd_ob
// Params 2
// Checksum 0x4cb1a622, Offset: 0x1eb9
// Size: 0xbb
function function_70013396bb42f6cc( players, cinematic_name )
{
    if ( isarray( players ) && isstring( cinematic_name ) )
    {
        foreach ( player in players )
        {
            player.allowmusic = 1;
            player.waitingmovie = cinematic_name;
            player utility::ent_flag_set( "cinematic_playing" );
        }
    }
}

// Namespace snd_ob
// Params 1, eflags: 0x4
// Checksum 0x13cc126e, Offset: 0x1f7c
// Size: 0x94
function private function_ed984f51d26c07f1( players )
{
    if ( isarray( players ) )
    {
        foreach ( player in players )
        {
            player.allowmusic = undefined;
            player.waitingmovie = undefined;
        }
    }
}

// Namespace snd_ob
// Params 2
// Checksum 0x48c6263e, Offset: 0x2018
// Size: 0xb4
function function_52bc8194809997e8( players, cinematic_name )
{
    if ( isarray( players ) && isstring( cinematic_name ) )
    {
        foreach ( player in players )
        {
            player utility::ent_flag_clear( "cinematic_playing", 1 );
        }
        
        utility::delaythread( 0.05, &function_ed984f51d26c07f1, players );
    }
}

/#

    // Namespace snd_ob
    // Params 1, eflags: 0x4
    // Checksum 0xd4a1ab5e, Offset: 0x20d4
    // Size: 0xf, Type: dev
    function private function_9e9e5f8c18774b83( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace snd_ob
// Params 1, eflags: 0x4
// Checksum 0x36d03d3, Offset: 0x20eb
// Size: 0x4a
function private onplayerconnect( params )
{
    self endon( #"disconnect" );
    thread function_764c25ad01479353();
    utility::waittill_any( "becameSpectator", "joined_spectators", "joined_team", "spawned" );
    
    if ( isplayer( self ) )
    {
        thread _squad_music_for_player( self );
    }
}

// Namespace snd_ob
// Params 1, eflags: 0x4
// Checksum 0x30a4efe7, Offset: 0x213d
// Size: 0x111
function private function_3950578229fb5ca2( params )
{
    if ( isstruct( params ) && snd::issquad( params.squad ) && isstring( params.squad.snd.music ) && params.squad.snd.music != "" && isarray( params.a_squad_players ) )
    {
        foreach ( player in params.a_squad_players )
        {
            music_cut( player, -20, 120, 2, 0, 10 );
        }
    }
}

// Namespace snd_ob
// Params 0
// Checksum 0xe1db645e, Offset: 0x2256
// Size: 0xe6
function get_active_current_activity()
{
    while ( !isdefined( level.current_activity ) )
    {
        waitframe();
    }
    
    while ( true )
    {
        is_valid_state = level.current_activity.state == "Idle" || level.current_activity.state == "Active";
        
        if ( is_valid_state && level.current_activity.playerparticipants.size > 0 )
        {
            break;
        }
        
        waitframe();
    }
    
    assert( level.current_activity.state == "<dev string:x86>" || level.current_activity.state == "<dev string:x8b>" );
    assert( level.current_activity.playerparticipants.size > 0 );
    return level.current_activity;
}

/#

    // Namespace snd_ob
    // Params 1, eflags: 0x4
    // Checksum 0x79aa53ee, Offset: 0x2345
    // Size: 0xf, Type: dev
    function private function_340beb9fa758bc0a( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace snd_ob
// Params 0
// Checksum 0xf9b64766, Offset: 0x235c
// Size: 0x109
function get_start_activity_name()
{
    start_activity = getdvar( @"start", "default" );
    lower_start_activity = tolower( start_activity );
    
    if ( lower_start_activity == "spawn" || lower_start_activity == "default" || lower_start_activity == "no_game" )
    {
        start_activity = level.activity_array[ 0 ][ "activity_name" ] ?? start_activity;
    }
    
    if ( isstruct( level.current_activity ) && isarray( level.current_activity.dataobjects ) && isstruct( level.current_activity.dataobjects[ "ActivityTypeName" ] ) && isstring( level.current_activity.dataobjects[ "ActivityTypeName" ].value ) )
    {
        start_activity = level.current_activity.dataobjects[ "ActivityTypeName" ].value;
    }
    
    return start_activity;
}

// Namespace snd_ob
// Params 0, eflags: 0x4
// Checksum 0xf457783d, Offset: 0x246e
// Size: 0x4d
function private function_1e0d53b954b1603a()
{
    while ( !isdefined( level.current_activity ) )
    {
        waitframe();
    }
    
    waittillframeend();
    activity_name = get_start_activity_name();
    level.start_point = activity_name;
    utility::flag_set( "start_is_set" );
    waittillframeend();
    level notify( #"start_logic", activity_name );
}

// Namespace snd_ob
// Params 0, eflags: 0x4
// Checksum 0x32850c9f, Offset: 0x24c3
// Size: 0x9f
function private _ob_start()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "onStartGameTypeFinished" );
    
    if ( !isarray( level.activity_name_array ) )
    {
        return;
    }
    
    level utility::flag_wait( "flag_story_mission_startpoint_called" );
    function_1e0d53b954b1603a();
    utility::flag_waitopen( "flag_story_mission_startpoint_called" );
    
    while ( true )
    {
        current_activity = level.current_activity;
        
        if ( isstruct( current_activity ) )
        {
            current_activity waittill( #"hash_7d4cf90a73514395" );
            
            while ( current_activity == level.current_activity )
            {
                waitframe();
            }
            
            function_1e0d53b954b1603a();
            continue;
        }
        
        waitframe();
    }
}

/#

    // Namespace snd_ob
    // Params 1, eflags: 0x4
    // Checksum 0x5634631c, Offset: 0x256a
    // Size: 0xf, Type: dev
    function private function_75cb5c93371700c2( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace snd_ob
// Params 4, eflags: 0x4
// Checksum 0x4a9cc383, Offset: 0x2581
// Size: 0x378
function private _squad_combat_state_main( squad, callback_func, var_64b6c0c5e765d9fd = 1.5, var_f04cf6fe365b9326 = 3 )
{
    level endon( #"game_ended" );
    squad notify( #"end_squad_combat_state" );
    squad endon( #"end_squad_combat_state" );
    assert( snd::issquad( squad ), "<dev string:x92>" + "<dev string:xb3>" );
    assert( isfunction( callback_func ), "<dev string:xcc>" );
    snd::init_obj( squad );
    
    while ( true )
    {
        ai_function = isfunction( squad.snd.ai_callback ) ? squad.snd.ai_callback : &snd::function_426f0eac71ed60a2;
        is_attacked = [[ ai_function ]]( squad );
        will_combat = is_attacked && ( squad.snd.ai_state == "warmup" || squad.snd.ai_state == "cooldown" );
        will_warmup = is_attacked && squad.snd.ai_state != "warmup" && squad.snd.ai_state != "combat" && squad.snd.ai_state != "cooldown";
        will_cooldown = !is_attacked && squad.snd.ai_state == "combat";
        will_idle = !is_attacked && !will_cooldown && squad.snd.ai_state != "idle";
        
        if ( will_combat )
        {
            squad.snd.ai_state = "combat";
            level thread [[ callback_func ]]( squad.snd.ai_state, squad );
        }
        else if ( will_warmup )
        {
            squad.snd.ai_state = "warmup";
            level thread [[ callback_func ]]( squad.snd.ai_state, squad );
            wait var_64b6c0c5e765d9fd;
            continue;
        }
        else if ( will_cooldown )
        {
            squad.snd.ai_state = "cooldown";
            level thread [[ callback_func ]]( squad.snd.ai_state, squad );
            now = gettime();
            cooldown_time = now;
            cooldown_msec = int( var_f04cf6fe365b9326 * 1000 );
            
            while ( true )
            {
                waitframe();
                is_attacked = [[ ai_function ]]( squad );
                now = gettime();
                cooldown_delta = now - cooldown_time;
                
                if ( is_attacked )
                {
                    break;
                }
                
                if ( cooldown_delta >= cooldown_msec )
                {
                    break;
                }
            }
            
            continue;
        }
        else if ( will_idle )
        {
            squad.snd.ai_state = "idle";
            level thread [[ callback_func ]]( squad.snd.ai_state, squad );
        }
        
        waitframe();
    }
}

// Namespace snd_ob
// Params 4
// Checksum 0xf325a1a5, Offset: 0x2901
// Size: 0x81
function squad_combat_state( squad, callback_func, var_64b6c0c5e765d9fd = 1.5, var_f04cf6fe365b9326 = 3 )
{
    if ( snd::condition_alert( !snd::issquad( squad ), "snd_ob::squad_combat_state" + ": invalid squad argument" ) )
    {
        return;
    }
    
    if ( snd::condition_alert( !isfunction( callback_func ), "snd::squad_combat_state callback_func is not a script function" ) )
    {
        return;
    }
    
    squad thread _squad_combat_state_main( squad, callback_func, var_64b6c0c5e765d9fd, var_f04cf6fe365b9326 );
}

// Namespace snd_ob
// Params 1
// Checksum 0xf919d868, Offset: 0x298a
// Size: 0x5e
function squad_combat_state_stop( squad )
{
    if ( snd::condition_alert( !snd::issquad( squad ), "snd_ob::squad_combat_state_stop" + ": invalid squad argument" ) )
    {
        return;
    }
    
    squad notify( #"end_squad_combat_state" );
    
    if ( isstruct( squad.snd ) )
    {
        squad.snd.ai_state = undefined;
    }
}

/#

    // Namespace snd_ob
    // Params 1, eflags: 0x4
    // Checksum 0x2e8a55c4, Offset: 0x29f0
    // Size: 0xf, Type: dev
    function private function_459e97383f5b019a( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace snd_ob
// Params 4, eflags: 0x4
// Checksum 0xa2333bda, Offset: 0x2a07
// Size: 0xaf
function private _player_submix_envelope_clear( submix, attack_sec, hold_sec, release_sec )
{
    assert( isplayer( self ) );
    assert( isstring( submix ) );
    assert( isnumber( attack_sec ) );
    assert( isnumber( hold_sec ) );
    assert( isnumber( release_sec ) );
    self notify( "_player_submix_envelope_clear_" + submix );
    self endon( #"disconnect", "_player_submix_envelope_clear_" + submix );
    var_68d856e9730bd509 = attack_sec + hold_sec;
    wait var_68d856e9730bd509;
    
    if ( isplayer( self ) )
    {
        self clearsoundsubmix( submix, release_sec );
    }
}

// Namespace snd_ob
// Params 6, eflags: 0x4
// Checksum 0xa0222f1, Offset: 0x2abe
// Size: 0x60
function private function_9bc413433b78e42a( player, submix, attack_sec, hold_sec, release_sec, scale )
{
    assert( isplayer( player ) );
    player setsoundsubmix( submix, attack_sec, scale );
    player thread _player_submix_envelope_clear( submix, attack_sec, hold_sec, release_sec );
}

// Namespace snd_ob
// Params 7, eflags: 0x4
// Checksum 0x8c3997d0, Offset: 0x2b26
// Size: 0x117
function private function_c1c2c2429b871d6e( player, submix, bpm = 120, attack_beats = 0, hold_beats = 16, release_beats = 16, scale )
{
    assert( isplayer( player ) );
    assert( isstring( submix ) );
    assert( isnumber( bpm ) );
    assert( isnumber( attack_beats ) );
    assert( isnumber( hold_beats ) );
    assert( isnumber( release_beats ) );
    assert( isnumber( scale ) );
    attack_sec = 60 / bpm * attack_beats;
    hold_sec = 60 / bpm * hold_beats;
    release_sec = 60 / bpm * release_beats;
    function_9bc413433b78e42a( player, submix, attack_sec, hold_sec, release_sec, scale );
}

// Namespace snd_ob
// Params 6
// Checksum 0xe16b8c7e, Offset: 0x2c45
// Size: 0x104
function music_boost( player, db, bpm, attack_beats, hold_beats, release_beats )
{
    if ( snd::condition_alert( !isplayer( player ), "snd_ob::music_boost" + ": invalid player argument" ) )
    {
        return;
    }
    
    if ( !isdefined( db ) )
    {
        db = 6;
    }
    
    assert( isnumber( db ) );
    
    /#
        if ( db < 0 )
        {
            snd::function_7a77574e2157fbce( "<dev string:x10a>" );
        }
        else if ( db > 10 )
        {
            snd::function_7a77574e2157fbce( "<dev string:x127>" );
        }
    #/
    
    var_5364760d3cec9d51 = clamp( snd::function_4aa8d29567677b4e( db ), 1, 3.16228 );
    scale = ( var_5364760d3cec9d51 - 1 ) / 2.16228;
    assert( scale >= 0 && scale <= 1 );
    function_c1c2c2429b871d6e( player, "boost_music", bpm, attack_beats, hold_beats, release_beats, scale );
}

// Namespace snd_ob
// Params 6
// Checksum 0x50c7eb82, Offset: 0x2d51
// Size: 0xcd
function music_boost_for_players( players, db, bpm, attack_beats, hold_beats, release_beats )
{
    if ( snd::condition_alert( !isarray( players ), "snd_ob::music_boost_for_players" + ": invalid players argument" ) )
    {
        return;
    }
    
    foreach ( player in players )
    {
        music_boost( player, db, bpm, attack_beats, hold_beats, release_beats );
    }
}

// Namespace snd_ob
// Params 6
// Checksum 0xe3570f62, Offset: 0x2e26
// Size: 0x70
function squad_music_boost( squad, db, bpm, attack_beats, hold_beats, release_beats )
{
    if ( snd::condition_alert( !snd::issquad( squad ), "snd_ob::squad_music_boost" + ": invalid squad argument" ) )
    {
        return;
    }
    
    music_boost_for_players( squad.players, db, bpm, attack_beats, hold_beats, release_beats );
}

// Namespace snd_ob
// Params 6
// Checksum 0xd16f77e5, Offset: 0x2e9e
// Size: 0x10a
function music_cut( player, db, bpm, attack_beats, hold_beats, release_beats )
{
    if ( snd::condition_alert( !isplayer( player ), "snd_ob::music_cut" + ": invalid player argument" ) )
    {
        return;
    }
    
    if ( !isdefined( db ) )
    {
        db = -6;
    }
    
    assert( isnumber( db ) );
    
    /#
        if ( db > 0 )
        {
            snd::function_7a77574e2157fbce( "<dev string:x145>" );
        }
        else if ( db < -60 )
        {
            snd::function_7a77574e2157fbce( "<dev string:x160>" );
        }
    #/
    
    var_5364760d3cec9d51 = clamp( snd::function_4aa8d29567677b4e( db ), 0.001, 1 );
    scale = 1 - ( var_5364760d3cec9d51 - 0.001 ) / 0.999;
    assert( scale >= 0 && scale <= 1 );
    function_c1c2c2429b871d6e( player, "cut_music", bpm, attack_beats, hold_beats, release_beats, scale );
}

// Namespace snd_ob
// Params 6
// Checksum 0x2820a721, Offset: 0x2fb0
// Size: 0xcd
function music_cut_for_players( players, db, bpm, attack_beats, hold_beats, release_beats )
{
    if ( snd::condition_alert( !isarray( players ), "snd_ob::music_cut_for_players" + ": invalid players argument" ) )
    {
        return;
    }
    
    foreach ( player in players )
    {
        music_cut( player, db, bpm, attack_beats, hold_beats, release_beats );
    }
}

// Namespace snd_ob
// Params 6
// Checksum 0x53a09c5, Offset: 0x3085
// Size: 0x70
function squad_music_cut( squad, db, bpm, attack_beats, hold_beats, release_beats )
{
    if ( snd::condition_alert( !snd::issquad( squad ), "snd_ob::squad_music_cut" + ": invalid squad argument" ) )
    {
        return;
    }
    
    music_cut_for_players( squad.players, db, bpm, attack_beats, hold_beats, release_beats );
}

/#

    // Namespace snd_ob
    // Params 1, eflags: 0x4
    // Checksum 0xfa94f54f, Offset: 0x30fd
    // Size: 0xf, Type: dev
    function private function_ddd51fdaa02a2fac( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace snd_ob
// Params 1, eflags: 0x4
// Checksum 0x36233d06, Offset: 0x3114
// Size: 0x135
function private _squad_music_for_player( player )
{
    self notify( #"squad_music_for_player" );
    self endon( #"squad_music_for_player" );
    self endon( #"disconnect" );
    assert( isplayer( player ), "<dev string:x17d>" + "<dev string:x19d>" );
    
    if ( isstring( player.waitingmovie ) && !isdefined( player.allowmusic ) )
    {
        player utility::ent_flag_waitopen_any( "cinematic_playing" );
    }
    
    snd::init_obj( player );
    squad = teams::function_72b89edf6b47c40a( player );
    
    if ( snd::issquad( squad ) && isstring( squad.snd.music ) && squad.snd.music != player.snd.music )
    {
        player.snd.music = squad.snd.music;
        player setplayermusicstate( squad.snd.music );
    }
}

// Namespace snd_ob
// Params 2
// Checksum 0xa2c60753, Offset: 0x3251
// Size: 0x138
function squad_music( squad, music_state_name )
{
    assert( snd::did_init(), "<dev string:x1b7>" + "<dev string:x1cb>" );
    
    if ( snd::condition_alert( !snd::issquad( squad ), "snd_ob::squad_music" + ": invalid squad argument" ) )
    {
        return;
    }
    
    if ( !isdefined( music_state_name ) )
    {
        music_state_name = "";
    }
    
    var_5ea3ef358975b624 = 0;
    
    if ( music_state_name == "" )
    {
        var_5ea3ef358975b624 = 1;
    }
    else
    {
        var_5ea3ef358975b624 = snd::musicexists( music_state_name );
    }
    
    if ( var_5ea3ef358975b624 )
    {
        snd::init_obj( squad );
        squad.snd.music = music_state_name;
        
        foreach ( player in squad.players )
        {
            player thread _squad_music_for_player( player );
        }
    }
    else
    {
        /#
            snd::function_7a77574e2157fbce( "<dev string:x1e5>" + music_state_name );
        #/
    }
    
    return var_5ea3ef358975b624;
}

// Namespace snd_ob
// Params 1
// Checksum 0x7ce1f791, Offset: 0x3392
// Size: 0x38
function squad_music_stop( squad )
{
    if ( snd::condition_alert( !snd::issquad( squad ), "snd_ob::squad_music_stop" + ": invalid squad argument" ) )
    {
        return;
    }
    
    squad_music( squad, "" );
}

// Namespace snd_ob
// Params 7
// Checksum 0xa9a6cf13, Offset: 0x33d2
// Size: 0x7b
function squad_music_with_boost( squad, music_state_name, db, bpm, attack_beats, hold_beats, release_beats )
{
    if ( snd::condition_alert( !snd::issquad( squad ), "snd_ob::squad_music_with_boost" + ": invalid squad argument" ) )
    {
        return;
    }
    
    if ( squad_music( squad, music_state_name ) )
    {
        squad_music_boost( squad, db, bpm, attack_beats, hold_beats, release_beats );
    }
}

// Namespace snd_ob
// Params 7
// Checksum 0xaf5052a4, Offset: 0x3455
// Size: 0x7b
function squad_music_with_cut( squad, music_state_name, db, bpm, attack_beats, hold_beats, release_beats )
{
    if ( snd::condition_alert( !snd::issquad( squad ), "snd_ob::squad_music_with_cut" + ": invalid squad argument" ) )
    {
        return;
    }
    
    if ( squad_music( squad, music_state_name ) )
    {
        squad_music_cut( squad, db, bpm, attack_beats, hold_beats, release_beats );
    }
}

// Namespace snd_ob
// Params 0
// Checksum 0x66408245, Offset: 0x34d8
// Size: 0x3b
function _squad_igc_music_cancel()
{
    level endon( #"game_ended" );
    self notify( #"hash_5741553bfb9429a4" );
    self endon( #"hash_5741553bfb9429a4" );
    level waittill( #"scene_skip_fade_start" );
    squad_music_stop( self );
}

// Namespace snd_ob
// Params 7
// Checksum 0x780ad9f5, Offset: 0x351b
// Size: 0xa7
function squad_igc_music( squad, music_state_name, db, bpm, attack_beats, hold_beats, release_beats )
{
    if ( snd::condition_alert( !snd::issquad( squad ), "snd_ob::squad_igc_music" + ": invalid squad argument" ) )
    {
        return;
    }
    
    if ( squad_music( squad, music_state_name ) )
    {
        if ( isnumber( db ) && isnumber( bpm ) )
        {
            squad_music_boost( squad, db, bpm, attack_beats, hold_beats, release_beats );
        }
        
        assert( snd::issquad( squad ) );
        squad thread _squad_igc_music_cancel();
    }
}

/#

    // Namespace snd_ob
    // Params 1, eflags: 0x4
    // Checksum 0xa7bd5bbd, Offset: 0x35ca
    // Size: 0xf, Type: dev
    function private function_c91a1a43bf79d1ab( var_dafe4dc0a58bbd2c )
    {
        
    }

#/

// Namespace snd_ob
// Params 1, eflags: 0x4
// Checksum 0x33ea36b5, Offset: 0x35e1
// Size: 0x13
function private function_5e674991ecf1e515( params )
{
    thread function_609820826f4c969e();
}

// Namespace snd_ob
// Params 0, eflags: 0x4
// Checksum 0xf42648ed, Offset: 0x35fc
// Size: 0x83
function private function_2ab245c1a4813efe()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"hash_2f7baf0260982955" );
        
        if ( issubstr( self.agent_type, "cradle" ) )
        {
            if ( soundexists( "dxx_ai_commando_rush_cradled" ) )
            {
                self playsoundatviewheight( #"dxx_ai_commando_rush_cradled" );
            }
        }
        else if ( soundexists( "dxx_ai_commando_rush" ) )
        {
            self playsoundatviewheight( #"dxx_ai_commando_rush" );
        }
        
        wait 0.05;
    }
}

// Namespace snd_ob
// Params 0, eflags: 0x4
// Checksum 0xdc2ea6d, Offset: 0x3687
// Size: 0x83
function private function_609820826f4c969e()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"hash_e4069ea5092b5c3f" );
        
        if ( issubstr( self.agent_type, "cradle" ) )
        {
            if ( soundexists( "dxx_ai_commando_melee_cradled" ) )
            {
                self playsoundatviewheight( #"dxx_ai_commando_melee_cradled" );
            }
        }
        else if ( soundexists( "dxx_ai_commando_melee" ) )
        {
            self playsoundatviewheight( #"dxx_ai_commando_melee" );
        }
        
        wait 0.05;
    }
}

