// scripts\mp\ob\systems\ob_zombie_intel.gsc  (hash_4e6fbfce8b467256.gscc) (size: 4853 Bytes / 0x12f5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe0844d3e (3766766910)
// size ...... 4853 (0x12f5)
// includes .. 8   (offset: 0x10b5)
// strings ... 40  (offset: 0x10f5)
// dev strs .. 2   (offset: 0x12d5)
// exports ... 10  (offset: 0xba1)
// cseg ...... 0x605 + 0x59c (0xba1)
// imports ... 31  (offset: 0xd31)
// animtree1 . 0   (offset: 0x12f5)
// animtree2 . 0   (offset: 0x12f5)
#using scripts\common\callbacks;
#using scripts\common\intel;
#using scripts\common\script;
#using scripts\common\utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\gametypes\ob;
#using scripts\mp\matchdata;

#namespace ob_zombie_intel;

// Namespace ob_zombie_intel
// Params 0, eflags: 0x1
// Checksum 0x40abbcd, Offset: 0x623
// Size: 0x53
function autoexec function_1dbd50ae42c4822d()
{
    utility::registersharedfunc( #"intel", #"hash_f21e61b24dd07f00", &function_93965a8ef0c8818a );
    utility::registersharedfunc( #"intel", #"post_player_on_connect", &function_b46f9bce4afba5e8 );
    callback::add( #"hash_476fcd5501956e2c", &function_25ece215cb0c0aba );
}

// Namespace ob_zombie_intel
// Params 0, eflags: 0x4
// Checksum 0xb6483d3e, Offset: 0x67e
// Size: 0xb7
function private function_247eb9205c1e064d()
{
    return [ "zmintel_sat_avalon_q1_document_1", "zmintel_sat_avalon_q1_document_2", "zmintel_sat_avalon_q1_document_3", "zmintel_sat_avalon_q1_document_4", "zmintel_sat_avalon_q2_document_1", "zmintel_sat_avalon_q2_document_2", "zmintel_sat_avalon_q2_document_3", "zmintel_sat_avalon_q2_document_4", "zmintel_sat_avalon_q3_document_1", "zmintel_sat_avalon_q3_document_2", "zmintel_sat_avalon_q3_document_3", "zmintel_sat_avalon_q3_document_4", "zmintel_sat_avalon_q4_document_1", "zmintel_sat_avalon_q4_document_2", "zmintel_sat_avalon_q4_document_3", "zmintel_sat_avalon_q4_document_4", "zmintel_sat_avalon_city_document_1", "zmintel_sat_avalon_city_document_2", "zmintel_sat_avalon_city_document_3", "zmintel_sat_avalon_city_document_4" ];
}

// Namespace ob_zombie_intel
// Params 0, eflags: 0x4
// Checksum 0x34246a2f, Offset: 0x73e
// Size: 0x66
function private function_838375ce27679513()
{
    return [ "zmintel_sat_leo_artifact_1", "zmintel_sat_pisces_artifact_1", "zmintel_sat_aries_artifact_1", "zmintel_sat_sag_artifact_1", "zmintel_sat_capricorn_artifact_1", "zmintel_sat_aqua_artifact_1", "zmintel_sat_virgo_artifact_1", "zmintel_sat_cancer_artifact_1", "zmintel_sat_gemini_artifact_1", "zmintel_sat_taurus_artifact_1", "zmintel_sat_libra_artifact_1" ];
}

// Namespace ob_zombie_intel
// Params 1, eflags: 0x4
// Checksum 0xae4a6025, Offset: 0x7ad
// Size: 0x18
function private function_b43d049c6470493e( intelname )
{
    return arraycontains( function_838375ce27679513(), intelname );
}

// Namespace ob_zombie_intel
// Params 1, eflags: 0x4
// Checksum 0xb96fda01, Offset: 0x7ce
// Size: 0x18
function private function_6f377d2d0ce9b7b0( intelname )
{
    return arraycontains( function_247eb9205c1e064d(), intelname );
}

// Namespace ob_zombie_intel
// Params 1, eflags: 0x4
// Checksum 0xfd5c569e, Offset: 0x7ef
// Size: 0x112
function private function_4833b6303102ad96( player )
{
    var_ffc5536b7d66d3b3 = 0;
    var_70e26fdc3805deaa = function_838375ce27679513();
    var_4ae85837a33f2f9c = function_247eb9205c1e064d();
    var_6bed411ca6acb188 = arraycombine( var_70e26fdc3805deaa, var_4ae85837a33f2f9c );
    
    foreach ( intelname in var_6bed411ca6acb188 )
    {
        if ( player intel::player_has_intel( intelname ) )
        {
            var_ffc5536b7d66d3b3 += 1;
        }
    }
    
    if ( var_ffc5536b7d66d3b3 == 0 )
    {
        return;
    }
    
    achievementparams = { #var_ffc5536b7d66d3b3:var_ffc5536b7d66d3b3, #player:player, #event:#"hash_99edec2fa59480a2" };
    level callback::callback( #"hash_6c71d319dc089c27", achievementparams );
}

// Namespace ob_zombie_intel
// Params 1, eflags: 0x4
// Checksum 0x3f944db, Offset: 0x909
// Size: 0x14
function private function_b46f9bce4afba5e8( params )
{
    function_4833b6303102ad96( self );
}

// Namespace ob_zombie_intel
// Params 1, eflags: 0x4
// Checksum 0x1a53f23b, Offset: 0x925
// Size: 0x15d
function private function_93965a8ef0c8818a( intel )
{
    var_bb86f77304f193c4 = ob::get_ob_settings();
    
    if ( !isdefined( var_bb86f77304f193c4 ) )
    {
        return 0;
    }
    
    isavalon = level.mapname == "mp_sat_lm_avalon_ob" || level.mapname == "mp_sat_avalon_quad_01_ob" || level.mapname == "mp_sat_avalon_quad_02_ob" || level.mapname == "mp_sat_avalon_quad_03_ob" || level.mapname == "mp_sat_avalon_quad_04_ob" || level.mapname == "mp_sat_avalon_city_ob";
    
    if ( !isavalon )
    {
        return 0;
    }
    
    var_3e2d4cdd10c8c034 = istrue( var_bb86f77304f193c4.var_49178f6e5c220274 );
    
    if ( var_3e2d4cdd10c8c034 )
    {
        if ( function_b43d049c6470493e( intel.ref ) )
        {
            return 0;
        }
        else
        {
            assert( function_6f377d2d0ce9b7b0( intel.ref ), "<dev string:x24>" + intel.ref + "<dev string:x34>" );
            return 1;
        }
        
        return;
    }
    
    if ( function_6f377d2d0ce9b7b0( intel.ref ) )
    {
        return 0;
    }
    
    assert( function_b43d049c6470493e( intel.ref ), "<dev string:x24>" + intel.ref + "<dev string:x34>" );
    return 1;
}

// Namespace ob_zombie_intel
// Params 1, eflags: 0x4
// Checksum 0x9c4b7d91, Offset: 0xa8a
// Size: 0x117
function private function_25ece215cb0c0aba( params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    var_4c952907fca5f153 = utility::getsharedfunc( #"intel", #"hash_ae79a668b3bc0aeb" );
    
    if ( var_4c952907fca5f153 )
    {
        game_type = game_utility::getgametype();
        map_name = game_utility::getmapname();
        playlist_id = 0;
        playlist_name = "";
        
        if ( game_utility_mp::matchmakinggame() )
        {
            playlist_id = getplaylistid();
            playlist_name = getplaylistname();
        }
        
        matchtime_ms = matchdata::gettimefrommatchstart( gettime() );
        matchtime_ms = int( clamp( matchtime_ms, 0, 2147483647 ) );
        [[ var_4c952907fca5f153 ]]( self, params, map_name, game_type, playlist_id, playlist_name, matchtime_ms );
    }
    else
    {
        script::demoforcesre( "No shared function defined for sending 'collected Zombie Intel' dlog, this event will be dropped!" );
    }
    
    var_421961f0ecaecd92 = utility::getsharedfunc( #"intel", #"hash_e95998f599062eec" );
    
    if ( var_421961f0ecaecd92 )
    {
        [[ var_421961f0ecaecd92 ]]( self, params );
    }
    else
    {
        script::demoforcesre( "No shared function defined for sending 'collected Zombie Intel' AE Event, this event will be dropped!" );
    }
    
    function_4833b6303102ad96( self );
}

