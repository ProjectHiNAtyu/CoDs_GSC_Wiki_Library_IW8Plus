// scripts\mp\br\gametypes\br_ending_cq.gsc  (hash_10f898ce46e157d2.gscc) (size: 11786 Bytes / 0x2e0a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6eb22ad (116073133)
// size ...... 11786 (0x2e0a)
// includes .. 14  (offset: 0x2af6)
// strings ... 46  (offset: 0x2b66)
// dev strs .. 3   (offset: 0x2de2)
// exports ... 27  (offset: 0x1abe)
// cseg ...... 0x4be + 0x1600 (0x1abe)
// imports ... 99  (offset: 0x1ef6)
// animtree1 . 0   (offset: 0x2e0a)
// animtree2 . 0   (offset: 0x2e0a)
#using scripts\common\scene;
#using scripts\common\script;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_elite_broken_arrow;
#using scripts\mp\br\gametypes\br_ending_util;
#using scripts\mp\br\gametypes\br_infils_util;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\music_br;

#namespace br_ending_cq;

// Namespace br_ending_cq
// Params 1
// Checksum 0x1aee0354, Offset: 0x4dc
// Size: 0x6cd
function function_a4ce9912bc284173( var_410ded744dab958f )
{
    level.exfilanimstruct = self;
    level.var_f5b5ed4122c1c674 = getdvarint( @"hash_d21fb4c6ab6e94f1", 1 );
    sceneent = getent( "infil_exfil_hq_origin", #targetname );
    
    if ( !isdefined( sceneent ) )
    {
        sceneent = spawnstruct();
        sceneent.origin = ( 0, 0, 0 );
        sceneent.angles = ( 0, 0, 0 );
    }
    
    if ( level.var_f5b5ed4122c1c674 )
    {
        preloadcinematicforall( "jup_wz_cq_detonation_bink", 1 );
    }
    
    var_81f7dc38505f909d = spawnstruct();
    var_81f7dc38505f909d.origin = self.origin;
    var_81f7dc38505f909d.angles = self.angles;
    var_81f7dc38505f909d scene::set_scriptbundle( "jup_wz_exfil_cq_detonation_scene" );
    var_eaa79ea583666d07 = var_81f7dc38505f909d scene::get_shot_names();
    self.var_81f7dc38505f909d = var_81f7dc38505f909d;
    var_a6a36bd01db18394 = spawnstruct();
    var_a6a36bd01db18394.origin = sceneent.origin;
    var_a6a36bd01db18394.angles = sceneent.angles;
    var_a6a36bd01db18394 scene::set_scriptbundle( "jup_wz_exfil_b_scene_cq" );
    var_5e01b4ae7282e6e4 = var_a6a36bd01db18394 scene::get_shot_names();
    var_a6a36bd01db18394.randomizedshots = function_30be7aba44863930();
    self.var_a6a36bd01db18394 = var_a6a36bd01db18394;
    var_86d0608a1966e31b = spawnstruct();
    var_86d0608a1966e31b.origin = sceneent.origin;
    var_86d0608a1966e31b.angles = sceneent.angles;
    var_86d0608a1966e31b scene::set_scriptbundle( "jup_wz_acc_cq_detonation_scene" );
    var_68ad079c1bbb3505 = var_86d0608a1966e31b scene::get_shot_names();
    scene::add_scene_func( var_86d0608a1966e31b, &function_e329c937f3f7a159, var_68ad079c1bbb3505[ 0 ] );
    scene::add_scene_func( var_86d0608a1966e31b, &function_9b609b28a6a56dff, var_68ad079c1bbb3505[ var_68ad079c1bbb3505.size - 1 ] );
    self.var_86d0608a1966e31b = var_86d0608a1966e31b;
    var_fd9386d3ef23f3a2 = spawnstruct();
    var_fd9386d3ef23f3a2.origin = sceneent.origin;
    var_fd9386d3ef23f3a2.angles = sceneent.angles;
    var_fd9386d3ef23f3a2 scene::set_scriptbundle( "jup_wz_aar_ar_scene" );
    self.var_fd9386d3ef23f3a2 = var_fd9386d3ef23f3a2;
    self.winner = self.winners[ 0 ].team;
    
    if ( !isdefined( var_410ded744dab958f ) )
    {
        var_410ded744dab958f = ( 0, 0, 0 );
    }
    
    level.var_1b8c0b90b91e0b3 = "";
    setomnvarforallclients( "ui_br_infil_exfil_player_focus", -1 );
    
    if ( !getdvarint( @"scr_br_ending_placement" ) )
    {
        self.transientname = function_aa8e694e37bf149f();
        assert( !level.arrow.dvars.var_473b1e06b0a45c80 || level.arrow.transientloaded );
        
        if ( level.arrow.dvars.var_473b1e06b0a45c80 && !level.arrow.transientloaded )
        {
            script::demoforcesre( "Transients not loaded early." );
        }
        
        br_elite_broken_arrow::function_e00a96b2675830f3();
        
        while ( !level.arrow.transientloaded )
        {
            waitframe();
        }
    }
    
    br_circle::hidedangercircle();
    self.winners = function_5713d46873b29625( self.winners );
    
    if ( getdvarint( @"hash_31c2a7e681ae24ed", 1 ) )
    {
        foreach ( player in level.players )
        {
            player player_utility::function_dbe5a52a6654a982();
        }
    }
    
    foreach ( player in self.winners )
    {
        animname = "player" + player getentitynumber();
        player.animname = animname;
        player.brexfilanimname = animname;
    }
    
    /#
        if ( getdvarint( @"hash_70809e88d9881104", 0 ) )
        {
            self.winners = [];
        }
    #/
    
    if ( self.winners.size == 0 )
    {
        br_ending_util::create_disconnectplayer( self );
    }
    
    numplayers = self.winners.size;
    
    /#
        numplayers = getdvarint( @"hash_6c00832d85ed5093", numplayers );
    #/
    
    self.var_86d0608a1966e31b.numinscene = numplayers;
    self.var_81f7dc38505f909d scene::function_e214b532712cd63a( numplayers );
    self.var_a6a36bd01db18394 scene::function_e214b532712cd63a( numplayers );
    self.var_86d0608a1966e31b scene::function_e214b532712cd63a( numplayers );
    self.var_fd9386d3ef23f3a2 scene::function_e214b532712cd63a( numplayers );
    var_6d87168a0c29eeaa = getdvarint( @"hash_cf55e0f95935f5af", 1 );
    
    if ( getdvarint( @"scr_br_ending_placement" ) || getdvarint( @"hash_2d200a3da7fb2518" ) )
    {
        var_6d87168a0c29eeaa = 0;
    }
    
    var_f754ef14b29cf391 = undefined;
    var_324866c301b322ef = getdvar( @"hash_ad33abd04b38d2fa", "" );
    var_324867c301b32522 = getdvar( @"hash_ad33aad04b38d0c7", "" );
    var_324868c301b32755 = getdvar( @"hash_ad33a9d04b38ce94", "" );
    var_324861c301b317f0 = getdvar( @"hash_ad33a8d04b38cc61", "" );
    var_324862c301b31a23 = getdvar( @"hash_ad33a7d04b38ca2e", "" );
    var_324863c301b31c56 = getdvar( @"hash_ad33a6d04b38c7fb", "" );
    
    if ( var_324866c301b322ef != "" || var_324867c301b32522 != "" || var_324868c301b32755 != "" || var_324861c301b317f0 != "" || var_324862c301b31a23 != "" || var_324863c301b31c56 != "" )
    {
        var_f754ef14b29cf391 = [];
        var_f754ef14b29cf391[ 0 ] = var_324866c301b322ef;
        var_f754ef14b29cf391[ 1 ] = var_324867c301b32522;
        var_f754ef14b29cf391[ 2 ] = var_324868c301b32755;
        var_f754ef14b29cf391[ 3 ] = var_324861c301b317f0;
        var_f754ef14b29cf391[ 4 ] = var_324862c301b31a23;
        var_f754ef14b29cf391[ 5 ] = var_324863c301b31c56;
    }
}

// Namespace br_ending_cq
// Params 0
// Checksum 0x38ac12f2, Offset: 0xbb1
// Size: 0xbb
function function_e9479a12331670c4()
{
    setdvar( @"cg_drawcrosshair", 0 );
    
    /#
        if ( self.istemp )
        {
            function_54a978403e4c65bb();
            return;
        }
    #/
    
    function_54a978403e4c65bb();
    function_5079faed8b30fc1c();
    function_180383f5b810a7e7();
    playaar();
    
    foreach ( player in level.players )
    {
        player clearpredictedstreampos();
    }
}

// Namespace br_ending_cq
// Params 0, eflags: 0x4
// Checksum 0x168e7aa4, Offset: 0xc74
// Size: 0x16a
function private function_54a978403e4c65bb()
{
    self.var_81f7dc38505f909d scene::pre_stream( self.winners );
    
    foreach ( player in level.players )
    {
        player function_a565dafac620d68e( %"hash_34c59bed7392d266" );
    }
    
    if ( isdefined( level.arrow.props ) && isdefined( level.arrow.props.bombsite ) )
    {
        level.arrow.props.bombsite freescriptable();
    }
    
    wait 0.75;
    level notify( #"nuke_fadeend" );
    
    /#
        if ( self.istemp )
        {
            thread function_d368dec9b0d20dc8();
        }
    #/
    
    var_5e01b4ae7282e6e4 = self.var_81f7dc38505f909d scene::get_shot_names();
    duration = self.var_81f7dc38505f909d scene::function_b3c7b792a7a154fa( var_5e01b4ae7282e6e4[ 0 ] );
    thread function_73b221e08f38d170();
    const_hold_time = 2;
    wait duration - const_hold_time;
}

// Namespace br_ending_cq
// Params 0, eflags: 0x4
// Checksum 0x5d4de0b, Offset: 0xde6
// Size: 0x111
function private function_73b221e08f38d170()
{
    music_br::function_202a2c9c7f440549();
    utility::delaythread( 0, &audio_utility::function_63bf1584c79c055, level.players, "evt_br_cq_detonation_flyby" );
    utility::delaythread( 3.5, &audio_utility::function_63bf1584c79c055, level.players, "evt_br_cq_detonation_flyby_slam_zoom" );
    utility::delaythread( 3.8, &audio_utility::function_63bf1584c79c055, level.players, "evt_br_cq_detonation_flyby_nuke_beep" );
    self.var_81f7dc38505f909d scene::play( self.winners );
    
    /#
        if ( self.istemp )
        {
            self notify( #"hash_94b93d1bf2fbbb59" );
            
            foreach ( player in level.players )
            {
                player clearpredictedstreampos();
            }
        }
    #/
}

// Namespace br_ending_cq
// Params 0, eflags: 0x4
// Checksum 0x2e35e48b, Offset: 0xeff
// Size: 0x50
function private function_da7fed614207b8ec()
{
    level thread br::handleendgamesplash( self.winner, 1, self.winners );
    level thread br::handleendgamespectatingsplash( self.winner, 1 );
    
    if ( level.shownonspectatingwinnersplash )
    {
        level thread br::handleendgamenonwinnersplash( self.winner, 1 );
    }
}

// Namespace br_ending_cq
// Params 0, eflags: 0x4
// Checksum 0xd874c173, Offset: 0xf57
// Size: 0xdb
function private function_30be7aba44863930()
{
    shotslist = [ "shot_010", "shot_020", "shot_030", "shot_040", "shot_050" ];
    var_32f530bbc03e5294 = [ " A", " B" ];
    variation = var_32f530bbc03e5294[ randomint( 2 ) ];
    
    /#
        shot = getdvar( @"hash_6e6b30dcd38ed28f", "<dev string:x24>" );
        
        if ( shot != "<dev string:x24>" )
        {
            variation = "<dev string:x25>" + shot;
        }
    #/
    
    shotslist[ 0 ] += variation;
    shotslist[ 1 ] += variation;
    shotslist[ 2 ] += variation;
    shotslist[ 3 ] += variation;
    shotslist[ 4 ] += variation;
    return shotslist;
}

// Namespace br_ending_cq
// Params 0, eflags: 0x4
// Checksum 0xf180918c, Offset: 0x103b
// Size: 0x1d1
function private function_5079faed8b30fc1c()
{
    function_7d0ebf2c0b149ffa( self.winners );
    audio_utility::function_63bf1584c79c055( level.players, "evt_br_cq_nuke_explo" );
    br_elite_broken_arrow::arrow_nukevision();
    wait 1;
    player::_visionsetnaked( "mp_jup_bigmap_wz2_cq_exfil", 0 );
    setomnvarforallclients( "post_game_state", 13 );
    setomnvarforallclients( "ui_br_bink_overlay_state", 13 );
    
    if ( level.var_f5b5ed4122c1c674 )
    {
        function_52030d33a7d4e6b0( 0, 1 );
    }
    else
    {
        playcinematicforall( "jup_wz_cq_detonation_bink", 1 );
    }
    
    var_863fb8f450629f77 = 4;
    var_adae9b19dc4cd0e1 = 9.5;
    var_2795df4484b0bab5 = var_863fb8f450629f77 + var_adae9b19dc4cd0e1;
    self.var_a6a36bd01db18394 thread scene::pre_stream( self.winners, undefined, var_2795df4484b0bab5 );
    wait var_863fb8f450629f77;
    function_da7fed614207b8ec();
    wait var_adae9b19dc4cd0e1;
    stopcinematicforall( 1, 1 );
    setomnvarforallclients( "ui_br_bink_overlay_state", 0 );
    setomnvarforallclients( "post_game_state", 0 );
    level thread br_ending_util::function_e89c7c78b10aa4a( 0, 3.33, 1 );
    level thread function_bdf52130b5aacc6b();
    audio_utility::function_5b885ff87a1180d4( level.players, "mp_killstreak_nuke", 3 );
    audio_utility::function_5b885ff87a1180d4( level.players, "br_elite_contract_ending", 3 );
    music_br::function_eed73b628c03adc1();
    audio_utility::function_63bf1584c79c055( level.players, "uin_jup_cq_victory_exfil_chyrons" );
    br_infils_util::function_94c95c81b53e5532( "cq_exfil_light" );
    thread function_5bb8cabecd5ae691();
    
    if ( isdefined( self.var_a6a36bd01db18394.randomizedshots ) )
    {
        self.var_a6a36bd01db18394 scene::play( self.winners, self.var_a6a36bd01db18394.randomizedshots );
        return;
    }
    
    self.var_a6a36bd01db18394 scene::play( self.winners );
}

// Namespace br_ending_cq
// Params 0
// Checksum 0x2bae598d, Offset: 0x1214
// Size: 0x9
function function_e329c937f3f7a159()
{
    function_e99ce9bc0e774a4e();
}

// Namespace br_ending_cq
// Params 0, eflags: 0x4
// Checksum 0x3afdd1cb, Offset: 0x1225
// Size: 0xdc
function private function_e99ce9bc0e774a4e()
{
    sceneroot = self;
    medalssolos = sceneroot scene::get_entity( "Medals Singles" );
    medalsduos = sceneroot scene::get_entity( "Medals Duos" );
    medalstrios = sceneroot scene::get_entity( "Medals Trios" );
    medalsquads = sceneroot scene::get_entity( "Medals Quads" );
    
    if ( sceneroot.numinscene != 4 )
    {
        medalsquads hide();
    }
    
    if ( sceneroot.numinscene != 3 )
    {
        medalstrios hide();
    }
    
    if ( sceneroot.numinscene != 2 )
    {
        medalsduos hide();
    }
    
    if ( sceneroot.numinscene != 1 && sceneroot.numinscene != 0 )
    {
        medalssolos hide();
    }
}

// Namespace br_ending_cq
// Params 0
// Checksum 0x9a2f0ee6, Offset: 0x1309
// Size: 0x83
function function_9b609b28a6a56dff()
{
    fade_in_time = 0.15;
    fade_out_time = 0.25;
    fade_time = 0.5;
    shots = scene::get_shot_names();
    shotlength = scene::function_b3c7b792a7a154fa( shots[ shots.size - 1 ] );
    waittime = max( 0, shotlength - fade_in_time - fade_time * 3 / 4 );
    wait waittime;
    br_ending_util::function_e89c7c78b10aa4a( fade_in_time, fade_time, fade_out_time );
}

// Namespace br_ending_cq
// Params 0, eflags: 0x4
// Checksum 0xab1500cc, Offset: 0x1394
// Size: 0x2c
function private function_5bb8cabecd5ae691()
{
    setomnvarforallclients( "ui_br_elite_arrow_aar_state", 1 );
    wait 22;
    setomnvarforallclients( "ui_br_elite_arrow_aar_state", 2 );
    wait 5;
    setomnvarforallclients( "ui_br_elite_arrow_aar_state", 3 );
}

// Namespace br_ending_cq
// Params 0, eflags: 0x4
// Checksum 0x755afadd, Offset: 0x13c8
// Size: 0x40
function private function_180383f5b810a7e7()
{
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_cq_exfil_nuke_dist_blast" );
    function_4d57a4a4954d94ac( self.var_86d0608a1966e31b );
    self.var_86d0608a1966e31b scene::play( self.winners );
}

// Namespace br_ending_cq
// Params 0, eflags: 0x4
// Checksum 0x529beed8, Offset: 0x1410
// Size: 0x5f
function private playaar()
{
    outrofunc();
    function_7d0ebf2c0b149ffa( self.winners );
    thread function_3d7ab7c430cefe00();
    utility::delaythread( 1, &audio_utility::function_63bf1584c79c055, level.players, "uin_jup_br_aar_placement_badge_slam" );
    self.var_fd9386d3ef23f3a2 scene::play( self.winners );
    outroendfunc();
}

/#

    // Namespace br_ending_cq
    // Params 0, eflags: 0x4
    // Checksum 0x10048970, Offset: 0x1477
    // Size: 0x3a, Type: dev
    function private function_d368dec9b0d20dc8()
    {
        self waittill( #"hash_94b93d1bf2fbbb59" );
        
        if ( self.var_81f7dc38505f909d scene::get_state() == "<dev string:x27>" )
        {
            self.var_81f7dc38505f909d scene::stop();
        }
    }

#/

// Namespace br_ending_cq
// Params 0, eflags: 0x4
// Checksum 0x408d22d5, Offset: 0x14b9
// Size: 0x37
function private function_3d7ab7c430cefe00()
{
    level waittill( #"br_ending_skip_scene" );
    
    if ( self.var_fd9386d3ef23f3a2 scene::get_state() == "Playing" )
    {
        self.var_fd9386d3ef23f3a2 scene::stop();
    }
}

// Namespace br_ending_cq
// Params 2, eflags: 0x4
// Checksum 0xa497a6b5, Offset: 0x14f8
// Size: 0xba
function private refreshplayersvisibility( winners, var_39994c8bdba42404 )
{
    foreach ( player in winners )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( player == var_39994c8bdba42404 )
        {
            continue;
        }
        
        player player_utility::function_dbe5a52a6654a982();
        player player_utility::function_9d378d725bb4831e( "br_ending_chopper_to_hq::refreshPlayersVisibility()" );
    }
    
    if ( isdefined( var_39994c8bdba42404 ) )
    {
        var_39994c8bdba42404 player_utility::function_b54a1e23734ef07( 1 );
    }
}

// Namespace br_ending_cq
// Params 1, eflags: 0x4
// Checksum 0xf2e61e6a, Offset: 0x15ba
// Size: 0x86
function private function_7d0ebf2c0b149ffa( winners )
{
    foreach ( player in winners )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player playershow();
    }
}

// Namespace br_ending_cq
// Params 0
// Checksum 0xd4acbf98, Offset: 0x1648
// Size: 0x6b
function function_bdf52130b5aacc6b()
{
    audio_utility::function_f8fa1bfbdb18edb5( level.players, "jup_br_exfil_b_igc", 3 );
    audio_utility::function_7b72e563ad80e020( level.players, "mp_jup_br_exfil_cq", 1 );
    wait 3;
    audio_utility::function_5b885ff87a1180d4( level.players, "mute_ambience_elements_emitters", 3 );
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_exfil_b_sh010_walla" );
}

// Namespace br_ending_cq
// Params 1
// Checksum 0x7d2efdb9, Offset: 0x16bb
// Size: 0xbc
function function_4d57a4a4954d94ac( var_f461cf914f7496a4 )
{
    var_bb541eaaf90cb99 = 0;
    
    if ( isdefined( var_f461cf914f7496a4 ) )
    {
        shots = var_f461cf914f7496a4 scene::get_shot_names();
        
        foreach ( shotname in shots )
        {
            var_bb541eaaf90cb99 += var_f461cf914f7496a4 scene::function_b3c7b792a7a154fa( shotname );
        }
    }
    
    var_bb541eaaf90cb99 -= var_bb541eaaf90cb99 % 0.05;
    level thread function_8a8b2f8750054e86( var_bb541eaaf90cb99 );
}

// Namespace br_ending_cq
// Params 1
// Checksum 0x5a80dd30, Offset: 0x177f
// Size: 0xb7
function function_8a8b2f8750054e86( accoladetime = 0 )
{
    if ( accoladetime > 1.5 )
    {
        waittime = accoladetime - 1.5;
        wait waittime;
    }
    
    audio_utility::function_63bf1584c79c055( level.players, "uin_jup_br_aar_transition_slam_lr" );
    audio_utility::function_f8fa1bfbdb18edb5( level.players, "mute_ambience_elements_emitters", 1, 0.683772 );
    audio_utility::function_f8fa1bfbdb18edb5( level.players, "mute_ambience", 1, 1 );
    utility::delaythread( 5, &audio_utility::function_5f0fd96a39f569a1, level.players, 15 );
    wait 0.05;
    clearmusicstate();
}

// Namespace br_ending_cq
// Params 0
// Checksum 0xe33dd708, Offset: 0x183e
// Size: 0xb8
function function_b77f149ea834670d()
{
    level waittill( #"br_credits_complete" );
    delaytime = getdvarfloat( @"hash_c88b807ea15b731f", 0 );
    fadedowntime = getdvarfloat( @"hash_a1ceffe4417264d1", 1 );
    fadeholdtime = getdvarfloat( @"hash_c9f5c9db0c714fae", 2.5 );
    fadeuptime = getdvarfloat( @"hash_4633bce56a15979a", 1 );
    
    if ( delaytime > 0 )
    {
        wait delaytime;
    }
    
    level.var_c9629f760ada35ea = 1;
    level thread br_ending_util::function_e89c7c78b10aa4a( fadedowntime, fadeholdtime, fadeuptime );
    
    if ( fadedowntime > 0 )
    {
        wait fadedowntime;
    }
    
    level notify( #"br_ending_skip_scene" );
}

// Namespace br_ending_cq
// Params 1
// Checksum 0xf766703a, Offset: 0x18fe
// Size: 0x18
function function_7648d828712a9f90( val )
{
    level notify( #"br_credits_complete" );
}

// Namespace br_ending_cq
// Params 0
// Checksum 0x2dab4476, Offset: 0x191e
// Size: 0x3e
function outrofunc()
{
    if ( !br_public::isanytutorialorbotpracticematch() )
    {
        setomnvarforallclients( "post_game_state", 14 );
        setomnvarforallclients( "ui_br_end_game_splash_type", 17 );
    }
    
    level ui::lui_registercallback( "br_credits_complete", &function_7648d828712a9f90 );
    level thread function_b77f149ea834670d();
}

// Namespace br_ending_cq
// Params 0
// Checksum 0xf60667cd, Offset: 0x1964
// Size: 0xce
function outroendfunc()
{
    if ( getdvarint( @"hash_b44ba42bba42b79e", 1 ) )
    {
        foreach ( player in level.players )
        {
            player clearpredictedstreampos();
        }
    }
    
    player::_visionsetnaked( "", 0 );
    
    if ( !level.var_c9629f760ada35ea )
    {
        level thread br_ending_util::function_e89c7c78b10aa4a( undefined, 2, 1 );
    }
    
    level.var_c9629f760ada35ea = undefined;
    level thread function_7f7b1eab3d58d251();
}

// Namespace br_ending_cq
// Params 0
// Checksum 0xfc83eefb, Offset: 0x1a3a
// Size: 0x59
function function_7f7b1eab3d58d251()
{
    wait 60;
    soundbank = "mp_gamemode_br_exfils";
    
    if ( utility::issharedfuncdefined( #"hash_40e46f363d3d7393", #"getexfilsoundbank" ) )
    {
        soundbank = [[ utility::getsharedfunc( #"hash_40e46f363d3d7393", #"getexfilsoundbank" ) ]]();
    }
    
    audio_utility::snd_transient_unload( soundbank );
}

// Namespace br_ending_cq
// Params 0
// Checksum 0x8ccfb83d, Offset: 0x1a9b
// Size: 0x22, Type: bool
function function_aa8e694e37bf149f()
{
    return utility::callsharedfunc( #"hash_40e46f363d3d7393", #"get_exfil_transient" ) ?? "";
}

