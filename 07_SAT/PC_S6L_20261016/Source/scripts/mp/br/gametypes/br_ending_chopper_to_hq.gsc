// scripts\mp\br\gametypes\br_ending_chopper_to_hq.gsc  (hash_49785c96eb4dfb29.gscc) (size: 24188 Bytes / 0x5e7c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x109eec42 (278850626)
// size ...... 24188 (0x5e7c)
// includes .. 12  (offset: 0x5788)
// strings ... 122 (offset: 0x57e8)
// dev strs .. 6   (offset: 0x5e20)
// exports ... 74  (offset: 0x37e4)
// cseg ...... 0xc17 + 0x2bcd (0x37e4)
// imports ... 154 (offset: 0x4374)
// animtree1 . 0   (offset: 0x5e7c)
// animtree2 . 0   (offset: 0x5e7c)
#using scripts\common\scene;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_accolades;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_ending;
#using scripts\mp\br\gametypes\br_ending_util;
#using scripts\mp\br\gametypes\br_infils_util;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;

#namespace br_ending_chopper_to_hq;

// Namespace br_ending_chopper_to_hq
// Params 0
// Checksum 0xd353e01b, Offset: 0xc35
// Size: 0x30
function chopperhqexfil_init()
{
    /#
        setdevdvarifuninitialized( @"hash_70809e88d9881104", 0 );
    #/
    
    accolades_init();
    level.var_e0308e22e5b02b6c = &function_f1559265f3d6525c;
    chopperhqexfil_fx_init();
}

// Namespace br_ending_chopper_to_hq
// Params 0
// Checksum 0x7b0375f8, Offset: 0xc6d
// Size: 0x54
function chopperhqexfil_fx_init()
{
    level._effect[ "player_disconnect" ] = loadfxasset( "vfx_iw8_br_gameplay_disconnect_player" );
    game[ "dialog" ][ "exfil_a_inbound_now" ] = "xfil_grav_bsua";
    game[ "dialog" ][ "exfil_a_shadow1_inbound" ] = "xfil_grav_bsub";
    game[ "dialog" ][ "exfil_a_extraction_inbound" ] = "xfil_grav_bsuc";
}

// Namespace br_ending_chopper_to_hq
// Params 2
// Checksum 0x9f87d9b1, Offset: 0xcc9
// Size: 0x39
function function_29cb821b1e2c5924( accolade, startfunc )
{
    if ( !isdefined( level.var_4c88625645a5a79b ) )
    {
        level.var_4c88625645a5a79b = [];
    }
    
    level.var_4c88625645a5a79b[ accolade ] = startfunc;
}

// Namespace br_ending_chopper_to_hq
// Params 2
// Checksum 0x691e0350, Offset: 0xd0a
// Size: 0x1f
function function_f1559265f3d6525c( winnerplayers, var_c71a8bc30a7b241b )
{
    thread function_d329a0bbc6d7e0dd( winnerplayers, var_c71a8bc30a7b241b );
}

// Namespace br_ending_chopper_to_hq
// Params 3, eflags: 0x4
// Checksum 0xc8179873, Offset: 0xd31
// Size: 0x43
function private function_d329a0bbc6d7e0dd( winners, var_410ded744dab958f, movetime )
{
    clearmusicstate();
    wait 1;
    audio_utility::function_f8fa1bfbdb18edb5( level.players, "mute_ambience_elements_emitters", 12 );
}

// Namespace br_ending_chopper_to_hq
// Params 1
// Checksum 0x893595b5, Offset: 0xd7c
// Size: 0x6a3
function chopperhqexfil_pack( var_410ded744dab958f )
{
    level.exfilanimstruct = self;
    sceneent = getent( "infil_exfil_hq_origin", #targetname );
    
    if ( !isdefined( sceneent ) )
    {
        sceneent = spawnstruct();
        sceneent.origin = ( 0, 0, 0 );
        sceneent.angles = ( 0, 0, 0 );
    }
    
    winningteam = self.winners[ 0 ].team;
    var_81f7dc38505f909d = spawnstruct();
    var_81f7dc38505f909d.origin = self.origin;
    var_81f7dc38505f909d.angles = self.angles;
    var_81f7dc38505f909d scene::set_scriptbundle( "jup_wz_exfil_a_scene" );
    var_eaa79ea583666d07 = var_81f7dc38505f909d scene::get_shot_names();
    scene::add_scene_func( var_81f7dc38505f909d, &function_6ff876daad4634e3, var_eaa79ea583666d07[ 0 ] );
    scene::add_scene_func( var_81f7dc38505f909d, &function_18a10604140250d, var_eaa79ea583666d07[ var_eaa79ea583666d07.size - 1 ] );
    self.var_81f7dc38505f909d = var_81f7dc38505f909d;
    var_662310822a6532c0 = isdefined( level.arrow ) && level.arrow.defused;
    
    /#
        var_662310822a6532c0 = var_662310822a6532c0 || getdvarint( @"hash_8e018b077a7ff49c", 0 );
    #/
    
    var_a6a36bd01db18394 = spawnstruct();
    var_a6a36bd01db18394.origin = sceneent.origin;
    var_a6a36bd01db18394.angles = sceneent.angles;
    
    if ( !var_662310822a6532c0 || !getdvarint( @"hash_a7e71848f1ce587b", 1 ) )
    {
        var_a6a36bd01db18394 scene::set_scriptbundle( "jup_wz_exfil_b_scene" );
        var_a6a36bd01db18394.randomizedshots = function_96c037165244c78();
    }
    else
    {
        var_a6a36bd01db18394 scene::set_scriptbundle( "jup_wz_exfil_b_scene_cq" );
        var_a6a36bd01db18394.randomizedshots = function_30be7aba44863930();
    }
    
    scene::add_scene_func( var_a6a36bd01db18394, &function_6777935959cb1b97, var_a6a36bd01db18394.randomizedshots[ 0 ] );
    scene::add_scene_func( var_a6a36bd01db18394, &function_f35a9b2385bcdf1a, var_a6a36bd01db18394.randomizedshots[ var_a6a36bd01db18394.randomizedshots.size - 1 ] );
    self.var_a6a36bd01db18394 = var_a6a36bd01db18394;
    var_fd9386d3ef23f3a2 = spawnstruct();
    var_fd9386d3ef23f3a2.origin = sceneent.origin;
    var_fd9386d3ef23f3a2.angles = sceneent.angles;
    var_fd9386d3ef23f3a2 scene::set_scriptbundle( "jup_wz_aar_ar_scene" );
    self.var_fd9386d3ef23f3a2 = var_fd9386d3ef23f3a2;
    
    if ( !isdefined( var_410ded744dab958f ) )
    {
        var_410ded744dab958f = ( 0, 0, 0 );
    }
    
    setomnvarforallclients( "ui_br_infil_exfil_player_focus", -1 );
    
    if ( !getdvarint( @"scr_br_ending_placement" ) )
    {
        self.transientname = get_chopperhqexfil_transient();
        loadinfiltransient( self.transientname );
        level thread br_ending_util::function_ee3a6a615e19250a( 2, 1.2, "exfil_fadeEnd" );
        
        for ( var_9c9751620202d0b9 = 0; !var_9c9751620202d0b9 ; var_9c9751620202d0b9 = function_cb3f113c9a5d56f7( self.transientname ) )
        {
            waitframe();
        }
    }
    
    br_circle::hidedangercircle();
    self.winners = function_5713d46873b29625( self.winners );
    
    if ( var_662310822a6532c0 && getdvarint( @"hash_d869103c6c12e13a", 1 ) )
    {
        foreach ( player in level.players )
        {
            if ( player.team != winningteam )
            {
                player player_utility::function_dbe5a52a6654a982();
            }
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
    
    self.var_81f7dc38505f909d scene::function_e214b532712cd63a( max( 1, level.var_fa1be1f101b545a3 ) );
    self.var_a6a36bd01db18394 scene::function_e214b532712cd63a( max( 1, level.var_fa1be1f101b545a3 ) );
    self.var_fd9386d3ef23f3a2 scene::function_e214b532712cd63a( max( 1, level.var_fa1be1f101b545a3 ) );
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
    
    br_accolades::function_8ffb08c901d9d792( self.winners );
    br_ending::function_c64a9bbb6771df41( self.winners );
    br_accolades::function_53910fe003f40d9( self.winners, var_6d87168a0c29eeaa, var_f754ef14b29cf391 );
}

// Namespace br_ending_chopper_to_hq
// Params 0
// Checksum 0xf6ee1583, Offset: 0x1427
// Size: 0x9
function function_6ff876daad4634e3()
{
    function_e99ce9bc0e774a4e();
}

// Namespace br_ending_chopper_to_hq
// Params 0, eflags: 0x4
// Checksum 0x8e98f489, Offset: 0x1438
// Size: 0x157
function private function_e99ce9bc0e774a4e()
{
    sceneroot = self;
    harnesses = function_ce90500deb5e23ea( sceneroot );
    
    foreach ( harness in harnesses )
    {
        harness hide();
    }
    
    ropes = function_2bb3b675b1829c11( sceneroot );
    
    foreach ( rope in ropes )
    {
        rope hide();
    }
    
    for ( playeridx = 0; playeridx < max( 1, level.var_fa1be1f101b545a3 ) ; playeridx++ )
    {
        if ( isdefined( harnesses[ playeridx ] ) )
        {
            harnesses[ playeridx ] show();
        }
        
        if ( isdefined( ropes[ playeridx ] ) )
        {
            ropes[ playeridx ] show();
        }
    }
}

// Namespace br_ending_chopper_to_hq
// Params 1, eflags: 0x4
// Checksum 0xf36270b3, Offset: 0x1597
// Size: 0x56
function private function_ce90500deb5e23ea( sceneroot )
{
    harnesses = [];
    
    for ( i = 1; i <= 6 ; i++ )
    {
        var_122709f4315fc945 = "Harness 0" + i;
        harnesses[ harnesses.size ] = sceneroot scene::get_entity( var_122709f4315fc945 );
    }
    
    return harnesses;
}

// Namespace br_ending_chopper_to_hq
// Params 1, eflags: 0x4
// Checksum 0x1d5c03cf, Offset: 0x15f6
// Size: 0x56
function private function_2bb3b675b1829c11( sceneroot )
{
    ropes = [];
    
    for ( i = 1; i <= 6 ; i++ )
    {
        ropename = "Rope 0" + i;
        ropes[ ropes.size ] = sceneroot scene::get_entity( ropename );
    }
    
    return ropes;
}

// Namespace br_ending_chopper_to_hq
// Params 0, eflags: 0x4
// Checksum 0xe3e5d0b8, Offset: 0x1655
// Size: 0x103
function private function_96c037165244c78()
{
    shotslist = [ "shot_010", "shot_020", "shot_030", "shot_040", "shot_050" ];
    var_32f530bbc03e5294 = [ " A", " B", " C" ];
    introvariation = var_32f530bbc03e5294[ randomint( 3 ) ];
    outrovariation = var_32f530bbc03e5294[ randomint( 3 ) ];
    
    /#
        shotorder = getdvar( @"hash_198a3621e730d4b5", "<dev string:x24>" );
        
        if ( shotorder != "<dev string:x24>" )
        {
            introvariation = "<dev string:x25>" + shotorder[ 0 ];
            outrovariation = "<dev string:x25>" + shotorder[ 1 ];
        }
    #/
    
    shotslist[ 0 ] += introvariation;
    shotslist[ 1 ] += introvariation;
    shotslist[ 2 ] += introvariation;
    shotslist[ 3 ] += outrovariation;
    shotslist[ 4 ] += outrovariation;
    return shotslist;
}

// Namespace br_ending_chopper_to_hq
// Params 1, eflags: 0x4
// Checksum 0x8bf8926f, Offset: 0x1761
// Size: 0xe5
function private function_30be7aba44863930( var_58773fca4def1089 )
{
    shotslist = [ "shot_010", "shot_020", "shot_030", "shot_040", "shot_050" ];
    var_32f530bbc03e5294 = [ " C", " D" ];
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

// Namespace br_ending_chopper_to_hq
// Params 0
// Checksum 0x2991d159, Offset: 0x184f
// Size: 0xb8
function function_18a10604140250d()
{
    var_a6a36bd01db18394 = level.exfilanimstruct.var_a6a36bd01db18394;
    var_a6a36bd01db18394 scene::pre_stream( level.exfilanimstruct.winners );
    var_8dcfc5d861d62726 = 0;
    fade_in_time = 0;
    fade_out_time = 0.25;
    shots = scene::get_shot_names();
    shotlength = scene::function_b3c7b792a7a154fa( shots[ shots.size - 1 ] );
    waittime = max( 0, shotlength - var_8dcfc5d861d62726 );
    wait waittime;
    br_ending_util::function_e89c7c78b10aa4a( fade_in_time, 3.33, fade_out_time );
}

// Namespace br_ending_chopper_to_hq
// Params 0
// Checksum 0x871559f1, Offset: 0x190f
// Size: 0x76
function function_f35a9b2385bcdf1a()
{
    fade_in_time = 0.15;
    fade_out_time = 0.25;
    shots = scene::get_shot_names();
    shotlength = scene::function_b3c7b792a7a154fa( shots[ shots.size - 1 ] );
    waittime = max( 0, shotlength - fade_in_time - 0.6375 );
    wait waittime;
    br_ending_util::function_e89c7c78b10aa4a( fade_in_time, 0.85, fade_out_time );
}

// Namespace br_ending_chopper_to_hq
// Params 0
// Checksum 0x67e6cdeb, Offset: 0x198d
// Size: 0x8a
function function_6777935959cb1b97()
{
    sceneentities = scene::get_entities();
    
    foreach ( entity in sceneentities )
    {
        if ( isdefined( entity ) )
        {
            entity forcenetfieldhighlod( 1 );
        }
    }
}

// Namespace br_ending_chopper_to_hq
// Params 0
// Checksum 0xc7ed1f4e, Offset: 0x1a1f
// Size: 0x74
function function_54c899a5b5f2c2ea()
{
    fade_in_time = 0.15;
    fade_out_time = 0.15;
    shots = scene::get_shot_names();
    shotlength = scene::function_b3c7b792a7a154fa( shots[ shots.size - 1 ] );
    waittime = max( 0, shotlength - 0.3 );
    wait waittime;
    br_ending_util::function_e89c7c78b10aa4a( fade_in_time, 0.3, fade_out_time );
}

// Namespace br_ending_chopper_to_hq
// Params 0
// Checksum 0x760d5e8e, Offset: 0x1a9b
// Size: 0x74
function function_15f204f930729ab2()
{
    fade_in_time = 0.15;
    fade_out_time = 0.75;
    shots = scene::get_shot_names();
    shotlength = scene::function_b3c7b792a7a154fa( shots[ shots.size - 1 ] );
    waittime = max( 0, shotlength - 0.3 );
    wait waittime;
    br_ending_util::function_e89c7c78b10aa4a( fade_in_time, 0.3, fade_out_time );
}

// Namespace br_ending_chopper_to_hq
// Params 0
// Checksum 0x5716fee5, Offset: 0x1b17
// Size: 0xac
function chopperhqexfil_play()
{
    /#
        if ( self.istemp )
        {
            function_89057e6b3e35ce5a();
            return;
        }
    #/
    
    function_89057e6b3e35ce5a();
    function_19b90ef72997bf95();
    function_180383f5b810a7e7();
    playaar();
    
    foreach ( player in level.players )
    {
        player clearpredictedstreampos();
    }
}

// Namespace br_ending_chopper_to_hq
// Params 0, eflags: 0x4
// Checksum 0xbc8a96df, Offset: 0x1bcb
// Size: 0x1a3
function private function_89057e6b3e35ce5a()
{
    audio_utility::function_f8fa1bfbdb18edb5( level.players, "jup_br_exfil_a_igc", 0.75 );
    self.var_81f7dc38505f909d scene::pre_stream( self.winners );
    wait 0.75;
    level notify( #"exfil_fadeEnd" );
    
    /#
        if ( self.istemp )
        {
            thread function_d368dec9b0d20dc8();
        }
    #/
    
    setomnvarforallclients( "ui_br_infil_exfil_player_focus", -2 );
    
    foreach ( player in level.players )
    {
        player function_a565dafac620d68e( %"hash_6672d428dc04ad44" );
    }
    
    level thread function_f42b5fa70f8734b9( self.winners );
    level thread function_661e5c5a7a90165d();
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

// Namespace br_ending_chopper_to_hq
// Params 0, eflags: 0x4
// Checksum 0x68495380, Offset: 0x1d76
// Size: 0x112
function private function_19b90ef72997bf95()
{
    br_infils_util::function_94c95c81b53e5532( "exfil_light" );
    
    foreach ( player in level.players )
    {
        player function_a565dafac620d68e( %"hash_34c59bed7392d266" );
    }
    
    visionset = "mp_jup_bigmap_wz2_exfil";
    player::_visionsetnaked( visionset, 0 );
    level thread function_8c5465fbc85e0fac();
    
    if ( isdefined( self.var_a6a36bd01db18394.randomizedshots ) )
    {
        self.var_a6a36bd01db18394 scene::play( self.winners, self.var_a6a36bd01db18394.randomizedshots );
        return;
    }
    
    self.var_a6a36bd01db18394 scene::play( self.winners );
}

// Namespace br_ending_chopper_to_hq
// Params 0, eflags: 0x4
// Checksum 0xc2a371e3, Offset: 0x1e90
// Size: 0x2cf
function private function_180383f5b810a7e7()
{
    br_infils_util::function_94c95c81b53e5532( "accolade_light" );
    var_cb882282d6506af2 = undefined;
    var_feda16f593dff5ab = 0;
    accoladesequence = [];
    
    foreach ( accoladestruct in level.var_2dd8c7a5ed41f9d9 )
    {
        if ( isdefined( accoladestruct.player ) )
        {
            accoladesequence[ accoladesequence.size ] = accoladestruct;
        }
    }
    
    level.var_2dd8c7a5ed41f9d9 = accoladesequence;
    
    foreach ( accoladestruct in level.var_2dd8c7a5ed41f9d9 )
    {
        accoladeref = accoladestruct.ref;
        player = accoladestruct.player;
        
        if ( var_cb882282d6506af2 == accoladeref )
        {
            self.var_a6a36bd01db18394 scene::cleanup();
        }
        
        accoladedata = level.var_c99fd4f0f41403f8[ accoladeref ];
        assert( isdefined( accoladedata ), "<dev string:x27>" + accoladeref + "<dev string:x35>" );
        self.var_a6a36bd01db18394 scene::set_scriptbundle( accoladedata.scenename );
        
        if ( var_feda16f593dff5ab == level.var_2dd8c7a5ed41f9d9.size - 1 )
        {
            shotnames = self.var_a6a36bd01db18394 scene::get_shot_names();
            scene::add_scene_func( self.var_a6a36bd01db18394, &function_6777935959cb1b97, shotnames[ 0 ] );
            scene::add_scene_func( self.var_a6a36bd01db18394, &function_15f204f930729ab2, shotnames[ shotnames.size - 1 ] );
            function_4d57a4a4954d94ac( self.var_a6a36bd01db18394 );
        }
        else
        {
            shotnames = self.var_a6a36bd01db18394 scene::get_shot_names();
            scene::add_scene_func( self.var_a6a36bd01db18394, &function_6777935959cb1b97, shotnames[ 0 ] );
            scene::add_scene_func( self.var_a6a36bd01db18394, &function_54c899a5b5f2c2ea, shotnames[ shotnames.size - 1 ] );
        }
        
        if ( isdefined( level.var_4c88625645a5a79b[ accoladestruct.ref ] ) )
        {
            level thread [[ level.var_4c88625645a5a79b[ accoladestruct.ref ] ]]( accoladestruct );
        }
        
        refreshplayersvisibility( self.winners, player );
        self.var_a6a36bd01db18394 scene::play( [ player ] );
        var_feda16f593dff5ab++;
        var_cb882282d6506af2 = accoladeref;
    }
}

// Namespace br_ending_chopper_to_hq
// Params 0, eflags: 0x4
// Checksum 0x9594ffe2, Offset: 0x2167
// Size: 0xf5
function private playaar()
{
    foreach ( player in self.winners )
    {
        if ( !isdefined( player ) || isbot( player ) )
        {
            continue;
        }
        
        player br_ending::player_equipment_use_stop();
        player thread br_ending::player_set_weapon();
    }
    
    outrofunc();
    function_7d0ebf2c0b149ffa( self.winners );
    thread function_3d7ab7c430cefe00();
    utility::delaythread( 1, &audio_utility::function_63bf1584c79c055, level.players, "uin_jup_br_aar_placement_badge_slam" );
    self.var_fd9386d3ef23f3a2 scene::play( self.winners );
    outroendfunc();
}

/#

    // Namespace br_ending_chopper_to_hq
    // Params 0, eflags: 0x4
    // Checksum 0xae964e97, Offset: 0x2264
    // Size: 0x3a, Type: dev
    function private function_d368dec9b0d20dc8()
    {
        self waittill( #"hash_94b93d1bf2fbbb59" );
        
        if ( self.var_81f7dc38505f909d scene::get_state() == "<dev string:x49>" )
        {
            self.var_81f7dc38505f909d scene::stop();
        }
    }

#/

// Namespace br_ending_chopper_to_hq
// Params 0, eflags: 0x4
// Checksum 0xfe1fe532, Offset: 0x22a6
// Size: 0x37
function private function_3d7ab7c430cefe00()
{
    level waittill( #"br_ending_skip_scene" );
    
    if ( self.var_fd9386d3ef23f3a2 scene::get_state() == "Playing" )
    {
        self.var_fd9386d3ef23f3a2 scene::stop();
    }
}

// Namespace br_ending_chopper_to_hq
// Params 2, eflags: 0x4
// Checksum 0x1a056152, Offset: 0x22e5
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

// Namespace br_ending_chopper_to_hq
// Params 1, eflags: 0x4
// Checksum 0xcec896c9, Offset: 0x23a7
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

// Namespace br_ending_chopper_to_hq
// Params 0, eflags: 0x4
// Checksum 0xbd4f7826, Offset: 0x2435
// Size: 0x82
function private function_5f18afbac39b4468()
{
    randomoptions = [ "exfil_a_inbound_now", "exfil_a_shadow1_inbound", "exfil_a_extraction_inbound" ];
    waittimes = [ 1.4, 1.033, 1.433 ];
    choice = randomint( randomoptions.size );
    br_public::brleaderdialog( randomoptions[ choice ], 0, level.players, 1, waittimes[ choice ], undefined, "dx_br_jpbm_" );
}

// Namespace br_ending_chopper_to_hq
// Params 1
// Checksum 0x6908da1, Offset: 0x24bf
// Size: 0x108
function function_f42b5fa70f8734b9( winners )
{
    max_exfil_players = 7;
    
    if ( !isdefined( winners ) )
    {
        winners = [];
    }
    
    winnerssize = min( winners.size, max_exfil_players );
    assert( winners.size >= 0 && winners.size <= 7, "<dev string:x51>" );
    musicstate = audio_utility::function_d4d265f3dcd0a13c( "br_exfil_intro1" );
    musicstate_classic = audio_utility::function_d4d265f3dcd0a13c( "br_exfil_intro1_classic" );
    
    if ( winnerssize > 0 )
    {
        musicset = "br_exfil_intro" + winnerssize;
        musicstate = audio_utility::function_d4d265f3dcd0a13c( musicset );
        musicstate_classic = audio_utility::function_d4d265f3dcd0a13c( musicset + "_classic" );
    }
    
    audio_utility::function_6a0ed3b9fb942369( level.players, musicstate, undefined, undefined, musicstate_classic );
    wait 3;
    audio_utility::function_f8fa1bfbdb18edb5( level.players, "mute_music", 2, 0.369043 );
    wait 10;
    audio_utility::function_5b885ff87a1180d4( level.players, "mute_music", 7 );
}

// Namespace br_ending_chopper_to_hq
// Params 0
// Checksum 0x49d002f5, Offset: 0x25cf
// Size: 0xbe
function function_661e5c5a7a90165d()
{
    thread function_5f18afbac39b4468();
    audio_utility::function_5b885ff87a1180d4( level.players, "mute_ambience_elements_emitters", 2.4 );
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_exfil_a_skyhook_plane_approach_lr" );
    wait 6.5;
    audio_utility::function_f8fa1bfbdb18edb5( level.players, "mute_ambience_elements_emitters", 0.1 );
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_exfil_a_skyhook_plane_flyby_lr" );
    wait 2.6;
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_exfil_a_skyhook_rope_snag" );
    wait 0.9;
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_exfil_a_skyhook_plane_jetwash_lr" );
    wait 1;
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_exfil_a_transition_stinger_lr" );
}

// Namespace br_ending_chopper_to_hq
// Params 0
// Checksum 0x6fd2cb2c, Offset: 0x2695
// Size: 0x85
function function_8c5465fbc85e0fac()
{
    audio_utility::function_5b885ff87a1180d4( level.players, "jup_br_exfil_a_igc", 3 );
    audio_utility::function_f8fa1bfbdb18edb5( level.players, "jup_br_exfil_b_igc", 3 );
    audio_utility::function_7b72e563ad80e020( level.players, "mp_jup_br_exfil_b", 1 );
    wait 3;
    audio_utility::function_5b885ff87a1180d4( level.players, "mute_ambience_elements_emitters", 3 );
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_exfil_b_sh010_walla" );
}

// Namespace br_ending_chopper_to_hq
// Params 1
// Checksum 0x19815aae, Offset: 0x2722
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

// Namespace br_ending_chopper_to_hq
// Params 1
// Checksum 0xb62f1f12, Offset: 0x27e6
// Size: 0xc1
function function_8a8b2f8750054e86( accoladetime = 0 )
{
    if ( accoladetime > 1.5 )
    {
        waittime = accoladetime - 1.5;
        wait waittime;
    }
    
    audio_utility::function_63bf1584c79c055( level.players, "uin_jup_br_aar_transition_slam_lr" );
    audio_utility::function_f8fa1bfbdb18edb5( level.players, "mute_ambience_elements_emitters", 4, 0.683772 );
    utility::delaythread( 4, &audio_utility::function_f8fa1bfbdb18edb5, level.players, "mute_ambience", 6, 1 );
    utility::delaythread( 12.05, &audio_utility::function_5f0fd96a39f569a1, level.players, 3 );
    wait 0.05;
    clearmusicstate();
}

// Namespace br_ending_chopper_to_hq
// Params 0
// Checksum 0x5daf10ef, Offset: 0x28af
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

// Namespace br_ending_chopper_to_hq
// Params 1
// Checksum 0x49f4b7dd, Offset: 0x296f
// Size: 0x18
function function_7648d828712a9f90( val )
{
    level notify( #"br_credits_complete" );
}

// Namespace br_ending_chopper_to_hq
// Params 0
// Checksum 0x93398391, Offset: 0x298f
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

// Namespace br_ending_chopper_to_hq
// Params 0
// Checksum 0x1395c70a, Offset: 0x29d5
// Size: 0x154
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
    
    foreach ( player in level.players )
    {
        player function_72cf2eee8e035013( %"hash_34c59bed7392d266" );
        player function_72cf2eee8e035013( %"hash_6672d428dc04ad44" );
    }
    
    if ( !level.var_c9629f760ada35ea )
    {
        level thread br_ending_util::function_e89c7c78b10aa4a( undefined, 2, 1 );
    }
    
    level.var_c9629f760ada35ea = undefined;
    level thread function_7f7b1eab3d58d251();
}

// Namespace br_ending_chopper_to_hq
// Params 0
// Checksum 0xdbf4b0b7, Offset: 0x2b31
// Size: 0x49
function function_7f7b1eab3d58d251()
{
    wait 60;
    
    if ( utility::issharedfuncdefined( #"hash_40e46f363d3d7393", #"getexfilsoundbank" ) )
    {
        soundbank = [[ utility::getsharedfunc( #"hash_40e46f363d3d7393", #"getexfilsoundbank" ) ]]();
    }
}

// Namespace br_ending_chopper_to_hq
// Params 0
// Checksum 0x15355b47, Offset: 0x2b82
// Size: 0x233
function accolades_init()
{
    function_29cb821b1e2c5924( "assassin", &assassin_startfunc );
    function_29cb821b1e2c5924( "assists", &assists_startfunc );
    function_29cb821b1e2c5924( "bigguns", &bigguns_startfunc );
    function_29cb821b1e2c5924( "breacher", &breacher_startfunc );
    function_29cb821b1e2c5924( "commando", &commando_startfunc );
    function_29cb821b1e2c5924( "deadweight", &deadweight_startfunc );
    function_29cb821b1e2c5924( "ghost", &ghost_startfunc );
    function_29cb821b1e2c5924( "highachiever_cool", &highachiever_cool_startfunc );
    function_29cb821b1e2c5924( "highachiever_cooler", &highachiever_cooler_startfunc );
    function_29cb821b1e2c5924( "highachiever_coolest", &highachiever_coolest_startfunc );
    function_29cb821b1e2c5924( "immortal", &immortal_startfunc );
    function_29cb821b1e2c5924( "interrogator", &interrogator_startfunc );
    function_29cb821b1e2c5924( "killer", &killer_startfunc );
    function_29cb821b1e2c5924( "machinist", &machinist_startfunc );
    function_29cb821b1e2c5924( "marksman", &marksman_startfunc );
    function_29cb821b1e2c5924( "medalist_cool", &medalist_cool_startfunc );
    function_29cb821b1e2c5924( "medalist_cooler", &medalist_cooler_startfunc );
    function_29cb821b1e2c5924( "medalist_coolest", &medalist_coolest_startfunc );
    function_29cb821b1e2c5924( "medic", &medic_startfunc );
    function_29cb821b1e2c5924( "moneybags", &moneybags_startfunc );
    function_29cb821b1e2c5924( "pacifist", &pacifist_startfunc );
    function_29cb821b1e2c5924( "pyro", &pyro_startfunc );
    function_29cb821b1e2c5924( "scavenger", &scavenger_startfunc );
    function_29cb821b1e2c5924( "scout", &scout_startfunc );
    function_29cb821b1e2c5924( "sniper", &sniper_startfunc );
    function_29cb821b1e2c5924( "supplier", &supplier_startfunc );
    function_29cb821b1e2c5924( "survivor", &survivor_startfunc );
    function_29cb821b1e2c5924( "teamobjectives", &teamobjectives_startfunc );
    function_29cb821b1e2c5924( "trapper", &trapper_startfunc );
    function_29cb821b1e2c5924( "tryhard_cool", &tryhard_cool_startfunc );
    function_29cb821b1e2c5924( "tryhard_cooler", &tryhard_cooler_startfunc );
    function_29cb821b1e2c5924( "tryhard_coolest", &tryhard_coolest_startfunc );
    function_29cb821b1e2c5924( "weakestlink", &weakestlink_startfunc );
}

// Namespace br_ending_chopper_to_hq
// Params 0
// Checksum 0xea45bea1, Offset: 0x2dbd
// Size: 0x22, Type: bool
function get_chopperhqexfil_transient()
{
    return utility::callsharedfunc( #"hash_40e46f363d3d7393", #"get_exfil_transient" ) ?? "";
}

// Namespace br_ending_chopper_to_hq
// Params 1
// Checksum 0x4c2b780f, Offset: 0x2de8
// Size: 0x3e
function assassin_startfunc( accoladestruct )
{
    function_8007a474b1bddea1( accoladestruct.ref, accoladestruct.player );
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_exfl_accolade_assassin" );
}

// Namespace br_ending_chopper_to_hq
// Params 1
// Checksum 0x69827a20, Offset: 0x2e2e
// Size: 0x3e
function assists_startfunc( accoladestruct )
{
    function_8007a474b1bddea1( accoladestruct.ref, accoladestruct.player );
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_exfl_accolade_assists" );
}

// Namespace br_ending_chopper_to_hq
// Params 1
// Checksum 0x39792b82, Offset: 0x2e74
// Size: 0x3e
function bigguns_startfunc( accoladestruct )
{
    function_8007a474b1bddea1( accoladestruct.ref, accoladestruct.player );
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_exfl_accolade_bigguns" );
}

// Namespace br_ending_chopper_to_hq
// Params 1
// Checksum 0x58ee250, Offset: 0x2eba
// Size: 0x3e
function breacher_startfunc( accoladestruct )
{
    function_8007a474b1bddea1( accoladestruct.ref, accoladestruct.player );
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_exfl_accolade_breacher" );
}

// Namespace br_ending_chopper_to_hq
// Params 1
// Checksum 0x5100fdfb, Offset: 0x2f00
// Size: 0x3e
function commando_startfunc( accoladestruct )
{
    function_8007a474b1bddea1( accoladestruct.ref, accoladestruct.player );
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_exfl_accolade_commando" );
}

// Namespace br_ending_chopper_to_hq
// Params 1
// Checksum 0x5ba13205, Offset: 0x2f46
// Size: 0x3e
function deadweight_startfunc( accoladestruct )
{
    function_8007a474b1bddea1( accoladestruct.ref, accoladestruct.player );
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_exfl_accolade_deadweight" );
}

// Namespace br_ending_chopper_to_hq
// Params 1
// Checksum 0x683fafc1, Offset: 0x2f8c
// Size: 0x3e
function ghost_startfunc( accoladestruct )
{
    function_8007a474b1bddea1( accoladestruct.ref, accoladestruct.player );
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_exfl_accolade_ghost" );
}

// Namespace br_ending_chopper_to_hq
// Params 1
// Checksum 0xb72c79d1, Offset: 0x2fd2
// Size: 0x3e
function highachiever_cool_startfunc( accoladestruct )
{
    function_8007a474b1bddea1( accoladestruct.ref, accoladestruct.player );
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_exfl_accolade_highachiever_cool" );
}

// Namespace br_ending_chopper_to_hq
// Params 1
// Checksum 0x788ec5e6, Offset: 0x3018
// Size: 0x3e
function highachiever_cooler_startfunc( accoladestruct )
{
    function_8007a474b1bddea1( accoladestruct.ref, accoladestruct.player );
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_exfl_accolade_highachiever_cooler" );
}

// Namespace br_ending_chopper_to_hq
// Params 1
// Checksum 0xdc7f63f3, Offset: 0x305e
// Size: 0x3e
function highachiever_coolest_startfunc( accoladestruct )
{
    function_8007a474b1bddea1( accoladestruct.ref, accoladestruct.player );
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_exfl_accolade_highachiever_coolest" );
}

// Namespace br_ending_chopper_to_hq
// Params 1
// Checksum 0x6109f4d1, Offset: 0x30a4
// Size: 0x3e
function immortal_startfunc( accoladestruct )
{
    function_8007a474b1bddea1( accoladestruct.ref, accoladestruct.player );
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_exfl_accolade_immortal" );
}

// Namespace br_ending_chopper_to_hq
// Params 1
// Checksum 0xd8c0da37, Offset: 0x30ea
// Size: 0x3e
function interrogator_startfunc( accoladestruct )
{
    function_8007a474b1bddea1( accoladestruct.ref, accoladestruct.player );
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_exfl_accolade_interrogator" );
}

// Namespace br_ending_chopper_to_hq
// Params 1
// Checksum 0x80cb0b55, Offset: 0x3130
// Size: 0x3e
function killer_startfunc( accoladestruct )
{
    function_8007a474b1bddea1( accoladestruct.ref, accoladestruct.player );
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_exfl_accolade_killer" );
}

// Namespace br_ending_chopper_to_hq
// Params 1
// Checksum 0x91177a6, Offset: 0x3176
// Size: 0x3e
function machinist_startfunc( accoladestruct )
{
    function_8007a474b1bddea1( accoladestruct.ref, accoladestruct.player );
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_exfl_accolade_machinist" );
}

// Namespace br_ending_chopper_to_hq
// Params 1
// Checksum 0xea566f72, Offset: 0x31bc
// Size: 0x3e
function marksman_startfunc( accoladestruct )
{
    function_8007a474b1bddea1( accoladestruct.ref, accoladestruct.player );
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_exfl_accolade_marksman" );
}

// Namespace br_ending_chopper_to_hq
// Params 1
// Checksum 0xde19fb6b, Offset: 0x3202
// Size: 0x3e
function medalist_cool_startfunc( accoladestruct )
{
    function_8007a474b1bddea1( accoladestruct.ref, accoladestruct.player );
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_exfl_accolade_medalist_cool" );
}

// Namespace br_ending_chopper_to_hq
// Params 1
// Checksum 0x651208ed, Offset: 0x3248
// Size: 0x3e
function medalist_cooler_startfunc( accoladestruct )
{
    function_8007a474b1bddea1( accoladestruct.ref, accoladestruct.player );
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_exfl_accolade_medalist_cooler" );
}

// Namespace br_ending_chopper_to_hq
// Params 1
// Checksum 0x4bb026b6, Offset: 0x328e
// Size: 0x3e
function medalist_coolest_startfunc( accoladestruct )
{
    function_8007a474b1bddea1( accoladestruct.ref, accoladestruct.player );
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_exfl_accolade_medalist_coolest" );
}

// Namespace br_ending_chopper_to_hq
// Params 1
// Checksum 0xb990997b, Offset: 0x32d4
// Size: 0x3e
function medic_startfunc( accoladestruct )
{
    function_8007a474b1bddea1( accoladestruct.ref, accoladestruct.player );
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_exfl_accolade_medic" );
}

// Namespace br_ending_chopper_to_hq
// Params 1
// Checksum 0x4555c133, Offset: 0x331a
// Size: 0x3e
function moneybags_startfunc( accoladestruct )
{
    function_8007a474b1bddea1( accoladestruct.ref, accoladestruct.player );
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_exfl_accolade_moneybags" );
}

// Namespace br_ending_chopper_to_hq
// Params 1
// Checksum 0xe9e915d8, Offset: 0x3360
// Size: 0x3e
function pacifist_startfunc( accoladestruct )
{
    function_8007a474b1bddea1( accoladestruct.ref, accoladestruct.player );
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_exfl_accolade_pacifist" );
}

// Namespace br_ending_chopper_to_hq
// Params 1
// Checksum 0xe287ea93, Offset: 0x33a6
// Size: 0x3e
function pyro_startfunc( accoladestruct )
{
    function_8007a474b1bddea1( accoladestruct.ref, accoladestruct.player );
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_exfl_accolade_pyro" );
}

// Namespace br_ending_chopper_to_hq
// Params 1
// Checksum 0x9f1172f5, Offset: 0x33ec
// Size: 0x3e
function scavenger_startfunc( accoladestruct )
{
    function_8007a474b1bddea1( accoladestruct.ref, accoladestruct.player );
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_exfl_accolade_scavenger" );
}

// Namespace br_ending_chopper_to_hq
// Params 1
// Checksum 0x121fda25, Offset: 0x3432
// Size: 0x3e
function scout_startfunc( accoladestruct )
{
    function_8007a474b1bddea1( accoladestruct.ref, accoladestruct.player );
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_exfl_accolade_scout" );
}

// Namespace br_ending_chopper_to_hq
// Params 1
// Checksum 0x5ba72212, Offset: 0x3478
// Size: 0x3e
function sniper_startfunc( accoladestruct )
{
    function_8007a474b1bddea1( accoladestruct.ref, accoladestruct.player );
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_exfl_accolade_sniper" );
}

// Namespace br_ending_chopper_to_hq
// Params 1
// Checksum 0x2c84e6fe, Offset: 0x34be
// Size: 0x3e
function supplier_startfunc( accoladestruct )
{
    function_8007a474b1bddea1( accoladestruct.ref, accoladestruct.player );
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_exfl_accolade_supplier" );
}

// Namespace br_ending_chopper_to_hq
// Params 1
// Checksum 0x6cfe4ad2, Offset: 0x3504
// Size: 0x3e
function survivor_startfunc( accoladestruct )
{
    function_8007a474b1bddea1( accoladestruct.ref, accoladestruct.player );
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_exfl_accolade_survivor" );
}

// Namespace br_ending_chopper_to_hq
// Params 1
// Checksum 0xe1431926, Offset: 0x354a
// Size: 0x3e
function teamobjectives_startfunc( accoladestruct )
{
    function_8007a474b1bddea1( accoladestruct.ref, accoladestruct.player );
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_exfl_accolade_team_objectives" );
}

// Namespace br_ending_chopper_to_hq
// Params 1
// Checksum 0x4ff70cb, Offset: 0x3590
// Size: 0x3e
function trapper_startfunc( accoladestruct )
{
    function_8007a474b1bddea1( accoladestruct.ref, accoladestruct.player );
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_exfl_accolade_trapper" );
}

// Namespace br_ending_chopper_to_hq
// Params 1
// Checksum 0xd6a56741, Offset: 0x35d6
// Size: 0x3e
function tryhard_cool_startfunc( accoladestruct )
{
    function_8007a474b1bddea1( accoladestruct.ref, accoladestruct.player );
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_exfl_accolade_tryhard_cool" );
}

// Namespace br_ending_chopper_to_hq
// Params 1
// Checksum 0xf3c01316, Offset: 0x361c
// Size: 0x3e
function tryhard_cooler_startfunc( accoladestruct )
{
    function_8007a474b1bddea1( accoladestruct.ref, accoladestruct.player );
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_exfl_accolade_tryhard_cooler" );
}

// Namespace br_ending_chopper_to_hq
// Params 1
// Checksum 0x6149df39, Offset: 0x3662
// Size: 0x3e
function tryhard_coolest_startfunc( accoladestruct )
{
    function_8007a474b1bddea1( accoladestruct.ref, accoladestruct.player );
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_exfl_accolade_tryhard_coolest" );
}

// Namespace br_ending_chopper_to_hq
// Params 1
// Checksum 0x53543f00, Offset: 0x36a8
// Size: 0x3e
function weakestlink_startfunc( accoladestruct )
{
    function_8007a474b1bddea1( accoladestruct.ref, accoladestruct.player );
    audio_utility::function_63bf1584c79c055( level.players, "scn_jup_br_exfl_accolade_weakestlink" );
}

// Namespace br_ending_chopper_to_hq
// Params 2, eflags: 0x4
// Checksum 0x58bc175, Offset: 0x36ee
// Size: 0xf6
function private function_8007a474b1bddea1( accoladeref, var_8a8cec2053930b6c )
{
    accoladeindex = level.var_3abb05bb58a5e16e[ accoladeref ];
    var_794529507543c518 = 0;
    
    if ( isdefined( var_8a8cec2053930b6c ) && isdefined( var_8a8cec2053930b6c.var_327968da5c5c251f ) )
    {
        accoladeindex = level.var_3abb05bb58a5e16e[ var_8a8cec2053930b6c.var_327968da5c5c251f ];
        var_794529507543c518 = int( var_8a8cec2053930b6c.var_eaf258efcfee7bdd );
    }
    
    assert( isdefined( accoladeindex ) );
    assert( accoladeindex >= 0 && accoladeindex < 256 );
    var_8cdadf7b291501d7 = 0;
    
    if ( isdefined( var_8a8cec2053930b6c ) )
    {
        var_8cdadf7b291501d7 = var_8a8cec2053930b6c getentitynumber();
    }
    
    assert( var_8cdadf7b291501d7 >= 0 && var_8cdadf7b291501d7 < 256 );
    omnvarvalue = var_8cdadf7b291501d7;
    omnvarvalue |= accoladeindex << 8;
    
    if ( var_794529507543c518 != 0 )
    {
        omnvarvalue |= var_794529507543c518 << 16;
    }
    
    setomnvarforallclients( "ui_br_infil_exfil_player_focus", omnvarvalue );
}

