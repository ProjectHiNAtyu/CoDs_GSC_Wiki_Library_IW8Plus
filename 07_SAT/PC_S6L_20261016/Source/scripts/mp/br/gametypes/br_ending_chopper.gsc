// scripts\mp\br\gametypes\br_ending_chopper.gsc  (hash_2b9bf887b4525eff.gscc) (size: 17460 Bytes / 0x4434 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9683622c (2525192748)
// size ...... 17460 (0x4434)
// includes .. 5   (offset: 0x3d64)
// strings ... 124 (offset: 0x3d8c)
// dev strs .. 0   (offset: 0x4434)
// exports ... 28  (offset: 0x2ee8)
// cseg ...... 0xc93 + 0x2255 (0x2ee8)
// imports ... 72  (offset: 0x3348)
// animtree1 . 0   (offset: 0x4434)
// animtree2 . 0   (offset: 0x4434)
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_ending_util;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\player;

#namespace br_ending_chopper;

// Namespace br_ending_chopper
// Params 0
// Checksum 0x79bfb263, Offset: 0xcb1
// Size: 0x9
function chopperexfil_init()
{
    chopperexfil_fx_init();
}

// Namespace br_ending_chopper
// Params 1
// Checksum 0x618f33d9, Offset: 0xcc2
// Size: 0xc67
function chopperexfil_pack( var_410ded744dab958f = ( 0, 0, 0 ) )
{
    thread chopperexfil_introsound( 5, var_410ded744dab958f );
    
    if ( !getdvarint( @"scr_br_ending_placement" ) )
    {
        self.transientname = get_chopperexfil_transient();
        loadinfiltransient( self.transientname );
        setomnvarforallclients( "ui_br_end_game_splash_type", 18 );
        
        for ( var_9c9751620202d0b9 = 0; !var_9c9751620202d0b9 ; var_9c9751620202d0b9 = function_cb3f113c9a5d56f7( self.transientname ) )
        {
            waitframe();
        }
    }
    
    chopper = br_ending_util::spawn_script_model( "veh8_mil_air_blima_scriptmodel" );
    chopper hidepart( "tag_main_rotor_blade_01" );
    chopper hidepart( "tag_main_rotor_blade_02" );
    chopper hidepart( "tag_main_rotor_blade_03" );
    chopper hidepart( "tag_main_rotor_blade_04" );
    chopper hidepart( "tag_tail_rotor_blade_01" );
    chopper hidepart( "tag_tail_rotor_blade_02" );
    chopper hidepart( "tag_tail_rotor_blade_03" );
    chopper hidepart( "tag_tail_rotor_blade_04" );
    self.exfilchopper = chopper;
    br_ending_util::chopperexfil_set_brcircle();
    head = [ "head_mp_helicopter_crew", "j_spine4" ];
    extramodels = [ head ];
    body = "body_pilot_helicopter_british";
    ropeguy = br_ending_util::spawn_script_model( body, undefined, extramodels );
    self.ropeguy = ropeguy;
    self.winners = function_5713d46873b29625( self.winners );
    
    if ( self.winners.size == 0 )
    {
        br_ending_util::create_disconnectplayer( self );
    }
    
    rope = br_ending_util::spawn_script_model( "equipment_fast_rope_wm_01_infil_heli_l" );
    self.rope = rope;
    self.cam = br_ending_util::create_cam();
    ascenders = [];
    ascenders[ 0 ] = br_ending_util::spawn_script_model( "misc_wm_ascender", "misc_wm_ascender0" );
    
    if ( self.winners.size > 1 )
    {
        ascenders[ 1 ] = br_ending_util::spawn_script_model( "misc_wm_ascender", "misc_wm_ascender1" );
    }
    
    if ( self.winners.size > 2 )
    {
        ascenders[ 2 ] = br_ending_util::spawn_script_model( "misc_wm_ascender", "misc_wm_ascender2" );
    }
    
    if ( self.winners.size > 3 )
    {
        ascenders[ 3 ] = br_ending_util::spawn_script_model( "misc_wm_ascender", "misc_wm_ascender3" );
    }
    
    self.ascenders = ascenders;
    self.packs = [];
    n = 0;
    self.packs[ n ] = br_ending_util::create_animpack( "scene1" );
    self.packs[ n ] br_ending_util::add_pack_startfunc( [], &chopperexfil_sh010_start );
    self.packs[ n ] br_ending_util::add_pack_modelanim( chopper, level.br_anim[ "br_exfil_blima_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( ropeguy, level.br_anim[ "br_exfil_co_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( rope, level.br_anim[ "br_exfil_rope_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "br_exfil_cam_sh010" ] );
    self.packs[ n ] br_ending_util::add_pack_fx( "chopperExfil_gas", self.origin, self.angles );
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "scene2" );
    self.packs[ n ] br_ending_util::add_pack_startfunc( self.winners, &chopperexfil_sh020_start );
    self.packs[ n ] br_ending_util::add_pack_modelanim( chopper, level.br_anim[ "br_exfil_blima_sh020" ] );
    
    if ( !isdefined( level.scr_notetrack[ "veh8_mil_air_blima_scriptmodel" ][ "any" ][ "guy0_aboard" ] ) )
    {
        animation::addnotetrack_customfunction( "veh8_mil_air_blima_scriptmodel", "guy0_aboard", &chopperexfil_skip_ascend0 );
        animation::addnotetrack_customfunction( "veh8_mil_air_blima_scriptmodel", "guy1_aboard", &chopperexfil_skip_ascend1 );
        animation::addnotetrack_customfunction( "veh8_mil_air_blima_scriptmodel", "guy2_aboard", &chopperexfil_skip_ascend2 );
        animation::addnotetrack_customfunction( "veh8_mil_air_blima_scriptmodel", "slamtoblack", &chopperexfil_slamtoblack );
    }
    
    self.packs[ n ] br_ending_util::add_pack_modelanim( ropeguy, level.br_anim[ "br_exfil_pilot_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( rope, level.br_anim[ "br_exfil_rope_sh020" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( ascenders[ 0 ], level.br_anim[ "br_exfil_ascender0_sh020" ] );
    
    if ( self.winners.size > 1 )
    {
        self.packs[ n ] br_ending_util::add_pack_modelanim( ascenders[ 1 ], level.br_anim[ "br_exfil_ascender1_sh020" ] );
    }
    
    if ( self.winners.size > 2 )
    {
        self.packs[ n ] br_ending_util::add_pack_modelanim( ascenders[ 2 ], level.br_anim[ "br_exfil_ascender2_sh020" ] );
    }
    
    if ( self.winners.size > 3 )
    {
        self.packs[ n ] br_ending_util::add_pack_modelanim( ascenders[ 3 ], level.br_anim[ "br_exfil_ascender3_sh020" ] );
    }
    
    self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 0 ], level.br_anim[ "br_exfil_guy0_sh020" ], level.br_anim[ "br_exfil_guy0_sh020_fem" ] );
    self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 1 ], level.br_anim[ "br_exfil_guy1_sh020" ], level.br_anim[ "br_exfil_guy1_sh020_fem" ] );
    self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 2 ], level.br_anim[ "br_exfil_guy2_sh020" ], level.br_anim[ "br_exfil_guy2_sh020_fem" ] );
    self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 3 ], level.br_anim[ "br_exfil_guy3_sh020" ], level.br_anim[ "br_exfil_guy3_sh020_fem" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "br_exfil_cam_sh020" ] );
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "scene2.5" );
    self.packs[ n ] br_ending_util::add_pack_startfunc( self.winners, &chopperexfil_sh025_start );
    self.packs[ n ] br_ending_util::add_pack_modelanim( chopper, level.br_anim[ "br_exfil_blima_sh025" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( ropeguy, level.br_anim[ "br_exfil_pilot_sh025" ] );
    self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 0 ], level.br_anim[ "br_exfil_guy0_sh025" ] );
    self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 1 ], level.br_anim[ "br_exfil_guy1_sh025" ] );
    self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 2 ], level.br_anim[ "br_exfil_guy2_sh025" ] );
    self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 3 ], level.br_anim[ "br_exfil_guy3_sh025" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "br_exfil_cam_sh025" ] );
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "scene3" );
    self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
    self.packs[ n ] br_ending_util::add_pack_startfunc( self.winners, &chopperexfil_sh030_start );
    self.packs[ n ] br_ending_util::add_pack_modelanim( chopper, level.br_anim[ "br_exfil_blima_sh030" ] );
    self.packs[ n ] br_ending_util::add_pack_modelanim( ropeguy, level.br_anim[ "br_exfil_pilot_sh030" ] );
    self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 0 ], level.br_anim[ "br_exfil_guy0_sh030" ], level.br_anim[ "br_exfil_guy0_sh030_fem" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "br_exfil_cam_sh030" ] );
    
    if ( self.winners.size >= 2 )
    {
        n++;
        self.packs[ n ] = br_ending_util::create_animpack( "scene4" );
        self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
        self.packs[ n ] br_ending_util::add_pack_startfunc( [ ropeguy ], &chopperexfil_sh040_start );
        self.packs[ n ] br_ending_util::add_pack_modelanim( chopper, level.br_anim[ "br_exfil_blima_sh040" ] );
        self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 1 ], level.br_anim[ "br_exfil_guy1_sh040" ], level.br_anim[ "br_exfil_guy1_sh040_fem" ] );
        self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "br_exfil_cam_sh040" ] );
    }
    
    if ( self.winners.size >= 3 )
    {
        n++;
        self.packs[ n ] = br_ending_util::create_animpack( "scene5" );
        self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
        self.packs[ n ] br_ending_util::add_pack_startfunc( [], &chopperexfil_sh050_start );
        self.packs[ n ] br_ending_util::add_pack_modelanim( chopper, level.br_anim[ "br_exfil_blima_sh050" ] );
        self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 2 ], level.br_anim[ "br_exfil_guy2_sh050" ], level.br_anim[ "br_exfil_guy2_sh050_fem" ] );
        self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "br_exfil_cam_sh050" ] );
    }
    
    if ( self.winners.size == 4 )
    {
        n++;
        self.packs[ n ] = br_ending_util::create_animpack( "scene6" );
        self.packs[ n ] br_ending_util::function_fa41a73cf4c5bb7b();
        self.packs[ n ] br_ending_util::add_pack_startfunc( [], &chopperexfil_sh060_start );
        self.packs[ n ] br_ending_util::add_pack_modelanim( chopper, level.br_anim[ "br_exfil_blima_sh060" ] );
        self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 3 ], level.br_anim[ "br_exfil_guy3_sh060" ], level.br_anim[ "br_exfil_guy3_sh060_fem" ] );
        self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "br_exfil_cam_sh060" ] );
    }
    
    n++;
    self.packs[ n ] = br_ending_util::create_animpack( "scene7" );
    self.packs[ n ] br_ending_util::add_pack_startfunc( [], &chopperexfil_sh070_start );
    self.packs[ n ] br_ending_util::add_pack_modelanim( chopper, level.br_anim[ "br_exfil_blima_sh070" ] );
    self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 0 ], level.br_anim[ "br_exfil_guy0_sh070" ] );
    self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 1 ], level.br_anim[ "br_exfil_guy1_sh070" ] );
    self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 2 ], level.br_anim[ "br_exfil_guy2_sh070" ] );
    self.packs[ n ] br_ending_util::add_pack_playeranim( self.winners[ 3 ], level.br_anim[ "br_exfil_guy3_sh070" ] );
    self.packs[ n ] br_ending_util::add_pack_camanim( level.br_anim[ "br_exfil_cam_sh070" ] );
}

// Namespace br_ending_chopper
// Params 0
// Checksum 0x67694799, Offset: 0x1931
// Size: 0x2f8
function function_10355abd5fe8eef9()
{
    argsarray = [];
    guyradius = 30;
    guyheight = 68;
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, level.br_anim[ "br_exfil_guy0_sh020" ], 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, level.br_anim[ "br_exfil_guy1_sh020" ], 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, level.br_anim[ "br_exfil_guy2_sh020" ], 0, undefined, guyradius, guyheight );
    argsarray = br_ending_util::function_37badcf00027517a( argsarray, level.br_anim[ "br_exfil_guy3_sh020" ], 0, undefined, guyradius, guyheight );
    choppermodel = "veh8_mil_air_blima_scriptmodel";
    chopperoriginoffset = ( 0, 0, -70 );
    chopperradius = 350;
    choppersegments = 10;
    argsarray = br_ending_util::function_382dfe458ab0a2b1( argsarray, choppermodel, level.br_anim[ "br_exfil_blima_sh020" ], 0, chopperoriginoffset, chopperradius );
    argsarray = br_ending_util::function_382dfe458ab0a2b1( argsarray, choppermodel, level.br_anim[ "br_exfil_blima_sh025" ], 0, chopperoriginoffset, chopperradius );
    argsarray = br_ending_util::function_382dfe458ab0a2b1( argsarray, choppermodel, level.br_anim[ "br_exfil_blima_sh030" ], 0, chopperoriginoffset, chopperradius );
    argsarray = br_ending_util::function_382dfe458ab0a2b1( argsarray, choppermodel, level.br_anim[ "br_exfil_blima_sh040" ], 0, chopperoriginoffset, chopperradius );
    argsarray = br_ending_util::function_382dfe458ab0a2b1( argsarray, choppermodel, level.br_anim[ "br_exfil_blima_sh050" ], 0, chopperoriginoffset, chopperradius );
    argsarray = br_ending_util::function_382dfe458ab0a2b1( argsarray, choppermodel, level.br_anim[ "br_exfil_blima_sh060" ], 0, chopperoriginoffset, chopperradius );
    argsarray = br_ending_util::function_382dfe458ab0a2b1( argsarray, choppermodel, level.br_anim[ "br_exfil_blima_sh070" ], 0, chopperoriginoffset, chopperradius );
    argsarray = br_ending_util::function_382dfe458ab0a2b1( argsarray, choppermodel, level.br_anim[ "br_exfil_blima_sh070" ], 0.99, chopperoriginoffset, chopperradius );
    argsarray = br_ending_util::function_687c5cf6d49f11eb( argsarray, choppermodel, level.br_anim[ "br_exfil_blima_sh010" ], chopperoriginoffset, chopperradius, choppersegments );
    argsarray = br_ending_util::function_687c5cf6d49f11eb( argsarray, choppermodel, level.br_anim[ "br_exfil_blima_sh020" ], chopperoriginoffset, chopperradius, choppersegments );
    argsarray = br_ending_util::function_687c5cf6d49f11eb( argsarray, choppermodel, level.br_anim[ "br_exfil_blima_sh025" ], chopperoriginoffset, chopperradius, choppersegments );
    argsarray = br_ending_util::function_687c5cf6d49f11eb( argsarray, choppermodel, level.br_anim[ "br_exfil_blima_sh030" ], chopperoriginoffset, chopperradius, choppersegments );
    argsarray = br_ending_util::function_687c5cf6d49f11eb( argsarray, choppermodel, level.br_anim[ "br_exfil_blima_sh040" ], chopperoriginoffset, chopperradius, choppersegments );
    argsarray = br_ending_util::function_687c5cf6d49f11eb( argsarray, choppermodel, level.br_anim[ "br_exfil_blima_sh050" ], chopperoriginoffset, chopperradius, choppersegments );
    argsarray = br_ending_util::function_687c5cf6d49f11eb( argsarray, choppermodel, level.br_anim[ "br_exfil_blima_sh060" ], chopperoriginoffset, chopperradius, choppersegments );
    argsarray = br_ending_util::function_687c5cf6d49f11eb( argsarray, choppermodel, level.br_anim[ "br_exfil_blima_sh070" ], chopperoriginoffset, chopperradius, choppersegments );
    return argsarray;
}

// Namespace br_ending_chopper
// Params 0
// Checksum 0x70a374cd, Offset: 0x1c32
// Size: 0x4d
function chopperexfil_fx_init()
{
    level._effect[ "chopperExfil_rotorwash" ] = loadfxasset( "vfx_iw8_br_gameplay_blima_rotor_infil" );
    level._effect[ "chopperExfil_gas" ] = loadfxasset( "vfx_iw8_br_gameplay_circle_gas_exfil_01" );
    level._effect[ "player_disconnect" ] = loadfxasset( "vfx_iw8_br_gameplay_disconnect_player" );
}

// Namespace br_ending_chopper
// Params 2, eflags: 0x4
// Checksum 0xc5330d83, Offset: 0x1c87
// Size: 0x90
function private chopperexfil_introsound( time, var_410ded744dab958f )
{
    endorigin = self.origin + ( 0, 0, 1000 );
    forward = vectornormalize( endorigin - var_410ded744dab958f );
    startorigin = endorigin + forward * 3000;
    temp = spawn( "script_model", startorigin );
    temp playsound( "br_exfil_incoming_heli_lr" );
    temp moveto( endorigin, time );
    wait time;
    temp delete();
}

// Namespace br_ending_chopper
// Params 0
// Checksum 0xcb3d8461, Offset: 0x1d1f
// Size: 0x126
function get_chopperexfil_transient()
{
    if ( utility::issharedfuncdefined( #"hash_1e35b723996d8889", #"get_exfil_transient" ) )
    {
        return [[ utility::getsharedfunc( #"hash_1e35b723996d8889", #"get_exfil_transient" ) ]]();
    }
    
    switch ( level.script )
    {
        case #"hash_d7b993f67c508b1d":
            return "mp_infil_br_donetsk_ending_chopper_tr";
        case #"hash_e9af1c05b2cb1afd":
            return "mp_infil_br_donetsk2_ending_chopper_tr";
        case #"hash_c9458e4403b73c27":
            return "mp_infil_br_don3_ending_chopper_tr";
        case #"hash_5bdc66d44b83f826":
            return "mp_infil_br_quarry_ending_chopper_tr";
        case #"hash_2ad5096943807dfb":
        case #"hash_4aa5d6e97851bdbd":
            return "mp_infil_br_mechanics_ending_chopper_tr";
        case #"hash_2de697274b41ff79":
            return "mp_infil_br_kstenod_ending_chopper_tr";
        case #"hash_4486e35de937847c":
            return "mp_infil_br_escape2_ending_chopper_tr";
        case #"hash_4486e45de937860f":
            return "mp_infil_br_escape2_ending_chopper_tr";
        case #"hash_57eba45b7ddbdcd6":
        case #"hash_63326ac3e12f8da0":
            return "mp_infil_br_saba_ending_chopper_tr";
        case #"hash_3eff14ec1d9395c1":
        case #"hash_e817308cc606e9e1":
            return "mp_infil_br_saba_ending_chopper_tr";
    }
    
    return "";
}

// Namespace br_ending_chopper
// Params 0
// Checksum 0xe0e3a1c6, Offset: 0x1e4e
// Size: 0x1eb
function chopperexfil_music_start()
{
    if ( level.br_ending.winners.size == 0 )
    {
        return;
    }
    
    musicalias = "mus_br_exfil_intro_3player_intro";
    var_7a12303c46bad125 = "br_exfil_part1_3person_lr";
    
    switch ( level.br_ending.winners.size )
    {
        case 1:
            musicalias = "mus_br_exfil_intro_1player_intro";
            var_7a12303c46bad125 = "br_exfil_part1_1person_lr";
            break;
        case 2:
            musicalias = "mus_br_exfil_intro_2player_intro";
            var_7a12303c46bad125 = "br_exfil_part1_2person_lr";
            break;
        case 3:
            musicalias = "mus_br_exfil_intro_3player_intro";
            var_7a12303c46bad125 = "br_exfil_part1_3person_lr";
            break;
        case 4:
            musicalias = "mus_br_exfil_intro_4player_intro";
            var_7a12303c46bad125 = "br_exfil_part1_4person_lr";
            break;
    }
    
    foreach ( player in level.players )
    {
        if ( player.var_ee74e8eed7f0fe09 )
        {
            continue;
        }
        
        player playlocalsound( var_7a12303c46bad125 );
        player playlocalsound( musicalias );
    }
    
    waitframe();
    setmusicstate( "" );
    
    foreach ( player in level.players )
    {
        if ( player.var_ee74e8eed7f0fe09 )
        {
            continue;
        }
        
        player setsoundsubmix( "mp_br_exfil_fade", 4 );
    }
}

// Namespace br_ending_chopper
// Params 0
// Checksum 0x5dba02f6, Offset: 0x2041
// Size: 0xdc
function chopperexfil_music_stop()
{
    if ( !isdefined( level.br_ending ) )
    {
        return;
    }
    
    musicalias = "mus_br_exfil_intro_3player_intro";
    var_7a12303c46bad125 = "br_exfil_part1_3person_lr";
    
    switch ( level.br_ending.winners.size )
    {
        case 1:
            musicalias = "mus_br_exfil_intro_1player_intro";
            var_7a12303c46bad125 = "br_exfil_part1_1person_lr";
            break;
        case 2:
            musicalias = "mus_br_exfil_intro_2player_intro";
            var_7a12303c46bad125 = "br_exfil_part1_2person_lr";
            break;
        case 3:
            musicalias = "mus_br_exfil_intro_3player_intro";
            var_7a12303c46bad125 = "br_exfil_part1_3person_lr";
            break;
        case 4:
            musicalias = "mus_br_exfil_intro_4player_intro";
            var_7a12303c46bad125 = "br_exfil_part1_4person_lr";
            break;
    }
    
    self stoplocalsound( var_7a12303c46bad125 );
    self stoplocalsound( musicalias );
    self stoplocalsound( "br_exfil_end_part_lr" );
}

// Namespace br_ending_chopper
// Params 0, eflags: 0x4
// Checksum 0x42b9dc5b, Offset: 0x2125
// Size: 0xa8
function private chopperexfil_music_sh025()
{
    if ( level.br_ending.winners.size == 0 )
    {
        return;
    }
    
    musicstate = "br_exfil_main_3player";
    
    switch ( level.br_ending.winners.size )
    {
        case 1:
            musicstate = "br_exfil_main_1player";
            break;
        case 2:
            musicstate = "br_exfil_main_2player";
            break;
        case 3:
            musicstate = "br_exfil_main_3player";
            break;
        case 4:
            musicstate = "br_exfil_main_4player";
            break;
    }
    
    setmusicstate( musicstate );
}

// Namespace br_ending_chopper
// Params 1, eflags: 0x4
// Checksum 0xb54968c4, Offset: 0x21d5
// Size: 0xa2
function private chopperexfil_sfx_before_sh070( waittime )
{
    if ( isdefined( waittime ) )
    {
        wait waittime;
    }
    
    foreach ( player in level.players )
    {
        if ( player.var_ee74e8eed7f0fe09 )
        {
            continue;
        }
        
        player playlocalsound( "br_exfil_end_part_lr" );
    }
}

// Namespace br_ending_chopper
// Params 1, eflags: 0x4
// Checksum 0x68f31d7e, Offset: 0x227f
// Size: 0xf6
function private chopperexfil_sh010_start( array )
{
    level.br_ending.exfilchopper thread chopper_playfx();
    thread chopperexfil_music_start();
    
    if ( !br_public::isanytutorialorbotpracticematch() )
    {
        setomnvarforallclients( "ui_br_end_game_splash_type", 17 );
    }
    
    if ( isdefined( level.br_ending_debugmode ) )
    {
        level.br_ending.ropeguy show();
        
        foreach ( player in level.players )
        {
            player.player_rig unlink();
        }
    }
    
    br_ending_util::allplayers_setphysicaldof( 2.8, 200 );
}

// Namespace br_ending_chopper
// Params 1, eflags: 0x4
// Checksum 0x3b838c66, Offset: 0x237d
// Size: 0x13f
function private chopperexfil_sh020_start( players )
{
    br_ending_util::allplayers_setphysicaldof( 2.8, 250 );
    level.br_ending.exfilchopper thread chopper_playfx();
    
    if ( isdefined( level.br_ending_debugmode ) )
    {
        foreach ( ascender in level.br_ending.ascenders )
        {
            ascender show();
        }
    }
    
    foreach ( player in players )
    {
        if ( isdefined( player ) )
        {
            player player::setwind( "60", 1 );
        }
    }
}

// Namespace br_ending_chopper
// Params 1, eflags: 0x4
// Checksum 0x8f746fd3, Offset: 0x24c4
// Size: 0x3ee
function private chopperexfil_sh025_start( players )
{
    br_ending_util::allplayers_setphysicaldof( 2.8, 250 );
    thread chopperexfil_music_sh025();
    
    if ( !isdefined( level.br_ending_debugmode ) )
    {
        if ( level.br_ending.winners.size < 4 )
        {
            if ( isdefined( level.br_ending.rope ) )
            {
                level.br_ending.rope delete();
            }
        }
    }
    
    level.br_ending.exfilchopper thread chopper_playfx();
    
    if ( isdefined( level.br_ending_debugmode ) )
    {
        foreach ( ascender in level.br_ending.ascenders )
        {
            ascender hide();
        }
    }
    else
    {
        foreach ( ascender in level.br_ending.ascenders )
        {
            ascender delete();
        }
    }
    
    tags = [ "tag_guy0", "tag_guy2", "tag_guy4", "tag_guy5" ];
    
    foreach ( player in players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( !isdefined( player.winindex ) )
        {
            continue;
        }
        
        player.player_rig linkto( level.br_ending.exfilchopper, tags[ player.winindex ], ( 0, 0, 0 ), ( 0, 0, 0 ) );
        player.linkedtoent = level.br_ending.exfilchopper;
        player.linkedtotag = tags[ player.winindex ];
    }
    
    foreach ( rig in level.br_ending.player_rigs )
    {
        if ( isdefined( rig.player ) )
        {
            continue;
        }
        
        if ( !isdefined( rig.winindex ) )
        {
            continue;
        }
        
        rig linkto( level.br_ending.exfilchopper, tags[ rig.winindex ], ( 0, 0, 0 ), ( 0, 0, 0 ) );
        rig.linkedtoent = level.br_ending.exfilchopper;
        rig.linkedtotag = tags[ rig.winindex ];
    }
    
    chopperexfil_sitting_wind( players );
}

// Namespace br_ending_chopper
// Params 1, eflags: 0x4
// Checksum 0x6bc0de5f, Offset: 0x28ba
// Size: 0xfe
function private chopperexfil_sh030_start( array )
{
    foreach ( player in level.players )
    {
        if ( player.var_ee74e8eed7f0fe09 )
        {
            continue;
        }
        
        player setclienttriggeraudiozone( "br_exfil_heli_int", 0.05 );
    }
    
    setomnvarforallclients( "ui_br_end_game_splash_type", 13 );
    br_ending_util::allplayers_setfov( 45 );
    br_ending_util::allplayers_setphysicaldof( 10, 18 );
    level.br_ending.exfilchopper thread chopper_playfx();
    
    if ( level.br_ending.winners.size == 1 )
    {
        thread chopperexfil_sfx_before_sh070( 1.266 );
    }
}

// Namespace br_ending_chopper
// Params 1, eflags: 0x4
// Checksum 0x272b3f8a, Offset: 0x29c0
// Size: 0xf5
function private chopperexfil_sh040_start( entarray )
{
    setomnvarforallclients( "ui_br_end_game_splash_type", 14 );
    br_ending_util::allplayers_setfov( 50 );
    br_ending_util::allplayers_setphysicaldof( 11, 30 );
    level.br_ending.exfilchopper thread chopper_playfx();
    
    if ( isdefined( level.br_ending_debugmode ) )
    {
        foreach ( ent in entarray )
        {
            ent hide();
        }
    }
    else
    {
        delete_entarray( entarray );
    }
    
    if ( level.br_ending.winners.size == 2 )
    {
        thread chopperexfil_sfx_before_sh070( 2.033 );
    }
}

// Namespace br_ending_chopper
// Params 1, eflags: 0x4
// Checksum 0x29862ddd, Offset: 0x2abd
// Size: 0x6f
function private chopperexfil_sh050_start( array )
{
    setomnvarforallclients( "ui_br_end_game_splash_type", 15 );
    br_ending_util::allplayers_setfov( 50 );
    br_ending_util::allplayers_setphysicaldof( 8, 14.5 );
    level.br_ending.exfilchopper thread chopper_playfx();
    
    if ( level.br_ending.winners.size == 3 )
    {
        thread chopperexfil_sfx_before_sh070( 2 );
    }
}

// Namespace br_ending_chopper
// Params 1, eflags: 0x4
// Checksum 0xe6412a39, Offset: 0x2b34
// Size: 0x6c
function private chopperexfil_sh060_start( array )
{
    setomnvarforallclients( "ui_br_end_game_splash_type", 16 );
    br_ending_util::allplayers_setfov( 55 );
    br_ending_util::allplayers_setphysicaldof( 3, 29 );
    level.br_ending.exfilchopper thread chopper_playfx();
    
    if ( level.br_ending.winners.size == 4 )
    {
        thread chopperexfil_sfx_before_sh070( 2.5 );
    }
}

// Namespace br_ending_chopper
// Params 1, eflags: 0x4
// Checksum 0xcb99778f, Offset: 0x2ba8
// Size: 0xba
function private chopperexfil_sh070_start( array )
{
    foreach ( player in level.players )
    {
        player clearclienttriggeraudiozone( 0.1 );
    }
    
    br_ending_util::allplayers_setfov( 65 );
    br_ending_util::allplayers_setphysicaldof( 2.8, 500 );
    level.br_ending.exfilchopper thread chopper_playfx();
}

// Namespace br_ending_chopper
// Params 1
// Checksum 0xa13a26b5, Offset: 0x2c6a
// Size: 0x8b
function chopperexfil_sitting_wind( players )
{
    foreach ( player in players )
    {
        if ( isdefined( player ) )
        {
            player player::setwind( "30", 1 );
        }
    }
}

// Namespace br_ending_chopper
// Params 1, eflags: 0x4
// Checksum 0xf66de2a0, Offset: 0x2cfd
// Size: 0x2d
function private chopperexfil_skip_ascend0( ent )
{
    if ( level.br_ending.winners.size == 1 )
    {
        stop_all_ascend_anims();
    }
}

// Namespace br_ending_chopper
// Params 1, eflags: 0x4
// Checksum 0x816ad235, Offset: 0x2d32
// Size: 0x2d
function private chopperexfil_skip_ascend1( ent )
{
    if ( level.br_ending.winners.size == 2 )
    {
        stop_all_ascend_anims();
    }
}

// Namespace br_ending_chopper
// Params 1, eflags: 0x4
// Checksum 0x1863838e, Offset: 0x2d67
// Size: 0x2d
function private chopperexfil_skip_ascend2( ent )
{
    if ( level.br_ending.winners.size == 3 )
    {
        stop_all_ascend_anims();
    }
}

// Namespace br_ending_chopper
// Params 1, eflags: 0x4
// Checksum 0xc4d2f9ef, Offset: 0x2d9c
// Size: 0x26
function private chopperexfil_slamtoblack( ent )
{
    if ( !isdefined( level.br_ending_debugmode ) )
    {
        setomnvarforallclients( "ui_world_fade", 1 );
    }
}

// Namespace br_ending_chopper
// Params 0
// Checksum 0x602a5090, Offset: 0x2dca
// Size: 0x2a
function chopper_playfx()
{
    self endon( #"death" );
    wait 0.1;
    playfxontag( utility::getfx( "chopperExfil_rotorwash" ), self, "tag_origin" );
}

// Namespace br_ending_chopper
// Params 1, eflags: 0x4
// Checksum 0x8cd5b405, Offset: 0x2dfc
// Size: 0x9d
function private delete_entarray( array )
{
    foreach ( ent in array )
    {
        if ( isdefined( ent.linkedents ) )
        {
            utility::array_delete( ent.linkedents );
        }
        
        ent delete();
    }
}

// Namespace br_ending_chopper
// Params 0, eflags: 0x4
// Checksum 0x6c2ccf61, Offset: 0x2ea1
// Size: 0x25
function private stop_all_ascend_anims()
{
    level.br_ending.cam notify( #"single anim", "end" );
}

// Namespace br_ending_chopper
// Params 0
// Checksum 0x1834043c, Offset: 0x2ece
// Size: 0x1a
function function_ccf6710f3e1c6cfd()
{
    level.var_572d9d46430e6e25 = { #var_cb34d2b743970ba5:"chopper" };
}

