// scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_audio.gsc  (hash_5795a79d6b8769d4.gscc) (size: 15803 Bytes / 0x3dbb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x538137fe (1400977406)
// size ...... 15803 (0x3dbb)
// includes .. 14  (offset: 0x369b)
// strings ... 69  (offset: 0x370b)
// dev strs .. 28  (offset: 0x3c6b)
// exports ... 18  (offset: 0x278b)
// cseg ...... 0x5b1 + 0x21da (0x278b)
// imports ... 87  (offset: 0x2a5b)
// animtree1 . 0   (offset: 0x3dbb)
// animtree2 . 0   (offset: 0x3dbb)
#using scripts\anim\dialogue;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\player;
#using scripts\mp\magicbox;
#using scripts\mp\overlord;
#using scripts\mp\player_banter;
#using scripts\mp\zm\maps\zm_sat_locust\zm_sat_locust_util;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_locust_audio;

// Namespace zm_sat_locust_audio
// Params 0
// Checksum 0xee618285, Offset: 0x5cf
// Size: 0x178
function main()
{
    level.var_f47ecf60e4790ad6 = &function_78073dd15738fe39;
    level thread play_end_of_round_vo();
    level callback::add( #"on_ai_killed", &on_ai_killed );
    level callback::add( #"player_damaged", &on_player_damaged );
    namespace_c0b4f2882c9d100f::function_55319be40b828f47( #"game_over", #"hash_ff1d9ee6bd314e8f" );
    namespace_c0b4f2882c9d100f::function_55319be40b828f47( #"full_ammo", #"hash_5d2e8b3394a36de8" );
    namespace_c0b4f2882c9d100f::function_55319be40b828f47( #"double_points", #"hash_5d1d7a339494ddd2" );
    namespace_c0b4f2882c9d100f::function_55319be40b828f47( #"insta_kill", #"hash_5d49713394ba0972" );
    namespace_c0b4f2882c9d100f::function_55319be40b828f47( #"fire_sale", #"hash_5d167133948eafd9" );
    namespace_c0b4f2882c9d100f::function_55319be40b828f47( #"full_armor", #"hash_5d2e7a3394a35105" );
    namespace_c0b4f2882c9d100f::function_55319be40b828f47( #"nuke", #"hash_5d31693394a569f9" );
    namespace_c0b4f2882c9d100f::function_55319be40b828f47( #"bonus_points_team", #"hash_5d23863394995de4" );
    namespace_c0b4f2882c9d100f::function_55319be40b828f47( #"full_power", #"hash_5d166e33948eaac0" );
    namespace_c0b4f2882c9d100f::function_55319be40b828f47( #"free_perk", #"hash_5ced8633946bce74" );
    namespace_c0b4f2882c9d100f::function_55319be40b828f47( #"eternal_perk", #"hash_45fae7a6aa9bed68" );
    magicbox::function_193ed9e2a7303c24( #"bunny_sound_locust" );
    init_poi_arrival();
    
    /#
        debug_init();
    #/
}

// Namespace zm_sat_locust_audio
// Params 0, eflags: 0x4
// Checksum 0x6685a596, Offset: 0x74f
// Size: 0x131
function private init_poi_arrival()
{
    level.poi_arrival = {};
    s_additional_params = { #var_7648c664bcdd7aaf:0 };
    level callback::add( "zone_changed", &function_2b55d8a6555e76c8, s_additional_params );
    function_2aa3f04a5e8e4577( #"dry_dock", #"hash_52fb98f8a800e347" );
    function_2aa3f04a5e8e4577( #"downtown", #"hash_5e41c852912eec96" );
    function_2aa3f04a5e8e4577( #"meadhall", #"hash_30d87a2534966b9e" );
    function_2aa3f04a5e8e4577( #"church", #"hash_6b2ba4665dc2b9cd" );
    function_2aa3f04a5e8e4577( #"fishery", #"hash_717ad67066ea421a" );
    function_2aa3f04a5e8e4577( #"robot", #"hash_52918b3ac3e7f536" );
    function_2aa3f04a5e8e4577( #"foundry", #"hash_b5f7071d90df036b" );
    function_2aa3f04a5e8e4577( #"lighthouse", #"hash_407c6e0aa8c069b6" );
    function_2aa3f04a5e8e4577( #"shop", #"hash_f4e7a1e37ede2f5a" );
    function_2aa3f04a5e8e4577( #"crypt", #"hash_aa73ba2c4b7699ba" );
}

// Namespace zm_sat_locust_audio
// Params 3, eflags: 0x4
// Checksum 0xe183ddd3, Offset: 0x888
// Size: 0xcc
function private function_2aa3f04a5e8e4577( key, arrival_banter, fallback_delay = 2 )
{
    data = { #played:0, #fallback_delay:fallback_delay, #arrival_banter:arrival_banter, #key:key };
    
    if ( !isdefined( level.poi_arrival.banters ) )
    {
        level.poi_arrival.banters = [];
    }
    
    assert( !level.poi_arrival.var_1b34103d9deb179c[ key ], "<dev string:x24>" + key );
    level.poi_arrival.banters[ key ] = data;
}

// Namespace zm_sat_locust_audio
// Params 2, eflags: 0x4
// Checksum 0x6683b289, Offset: 0x95c
// Size: 0x182
function private function_680879645d4d425c( key, player )
{
    level endon( #"zm_game_over" );
    player endon( #"death_or_disconnect" );
    
    if ( !isxhash( key ) )
    {
        key = getxhash( key );
    }
    
    data = level.poi_arrival.banters[ key ];
    assert( data, "<dev string:x41>" + key );
    
    if ( data.played )
    {
        return;
    }
    
    data.played = 1;
    
    if ( !is_vo_available( player ) )
    {
        return;
    }
    
    player_name = player namespace_c0b4f2882c9d100f::function_470ff6ad4f437db1();
    response_banter = hashcat( data.arrival_banter, "_" + player_name + "_", "response" );
    response_data = level.s_player_banter.var_2b7610a66e79ac05[ response_banter ];
    assert( response_data, "<dev string:x5f>" + response_banter );
    played = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( data.arrival_banter, undefined, data.fallback_delay );
    
    if ( !player || !isalive( player ) )
    {
        return;
    }
    
    players = utility::get_alive_players( 0 );
    var_dc4fa75655c6106d = sortbydistancecullbyradius( players, player.origin, 1000 );
    player_banter::play_banter_vo( response_banter, var_dc4fa75655c6106d );
}

// Namespace zm_sat_locust_audio
// Params 2, eflags: 0x4
// Checksum 0x2bada8a0, Offset: 0xae6
// Size: 0x35f
function private function_2b55d8a6555e76c8( params, ex_params )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    new_zone_name = params.zone_struct.script_zone_name;
    
    if ( new_zone_name == "zone_shipyard_shore" || new_zone_name == "zone_shipyard_warehouse" )
    {
        if ( namespace_c0b4f2882c9d100f::is_maya() || namespace_c0b4f2882c9d100f::is_grey() || namespace_c0b4f2882c9d100f::is_nikolai() )
        {
            level thread function_680879645d4d425c( #"dry_dock", self );
        }
        
        return;
    }
    
    if ( new_zone_name == "zone_downtown" )
    {
        if ( namespace_c0b4f2882c9d100f::is_weaver() || namespace_c0b4f2882c9d100f::is_maya() || namespace_c0b4f2882c9d100f::is_dempsey() )
        {
            level thread function_680879645d4d425c( #"downtown", self );
        }
        
        return;
    }
    
    if ( new_zone_name == "zone_downtown_meadhall" )
    {
        if ( namespace_c0b4f2882c9d100f::is_takeo() || namespace_c0b4f2882c9d100f::is_weaver() || namespace_c0b4f2882c9d100f::is_carver() )
        {
            level thread function_680879645d4d425c( #"meadhall", self );
        }
        
        return;
    }
    
    if ( new_zone_name == "zone_village_church" )
    {
        if ( namespace_c0b4f2882c9d100f::is_carver() || namespace_c0b4f2882c9d100f::is_takeo() || namespace_c0b4f2882c9d100f::is_grey() )
        {
            level thread function_680879645d4d425c( #"church", self );
        }
        
        return;
    }
    
    if ( new_zone_name == "zone_fishery" )
    {
        if ( namespace_c0b4f2882c9d100f::is_richtofen() || namespace_c0b4f2882c9d100f::is_takeo() || namespace_c0b4f2882c9d100f::is_grey() )
        {
            level thread function_680879645d4d425c( #"fishery", self );
        }
        
        return;
    }
    
    if ( new_zone_name == "zone_robot_foot" || new_zone_name == "zone_robot_shoulder" )
    {
        if ( namespace_c0b4f2882c9d100f::is_richtofen() || namespace_c0b4f2882c9d100f::is_carver() || namespace_c0b4f2882c9d100f::is_maya() )
        {
            level thread function_680879645d4d425c( #"robot", self );
        }
        
        return;
    }
    
    if ( new_zone_name == "zone_foundry" || new_zone_name == "zone_foundry_south" )
    {
        if ( namespace_c0b4f2882c9d100f::is_richtofen() || namespace_c0b4f2882c9d100f::is_dempsey() || namespace_c0b4f2882c9d100f::is_nikolai() )
        {
            level thread function_680879645d4d425c( #"foundry", self );
        }
        
        return;
    }
    
    if ( new_zone_name == "zone_lighthouse" )
    {
        if ( namespace_c0b4f2882c9d100f::is_carver() || namespace_c0b4f2882c9d100f::is_dempsey() || namespace_c0b4f2882c9d100f::is_nikolai() )
        {
            level thread function_680879645d4d425c( #"lighthouse", self );
        }
        
        return;
    }
    
    if ( new_zone_name == "zone_downtown_shop" )
    {
        if ( namespace_c0b4f2882c9d100f::is_maya() || namespace_c0b4f2882c9d100f::is_richtofen() || namespace_c0b4f2882c9d100f::is_nikolai() )
        {
            if ( !ex_params.var_7648c664bcdd7aaf )
            {
                if ( namespace_c0b4f2882c9d100f::is_richtofen() && !level.poi_arrival.banters[ #"shop" ].played && is_vo_available( self ) )
                {
                    ex_params.var_7648c664bcdd7aaf = 1;
                    players = utility::get_alive_players( 0 );
                    var_dc4fa75655c6106d = sortbydistancecullbyradius( players, self.origin, 1000 );
                    dialogue::say_dialogue( #"hash_d1077e9dc7ef56e2", var_dc4fa75655c6106d );
                }
                
                level thread function_680879645d4d425c( #"shop", self );
            }
        }
        
        return;
    }
    
    if ( new_zone_name == "zone_village_crypt" )
    {
        if ( namespace_c0b4f2882c9d100f::is_richtofen() || namespace_c0b4f2882c9d100f::is_takeo() || namespace_c0b4f2882c9d100f::is_dempsey() )
        {
            level thread function_680879645d4d425c( #"crypt", self );
        }
    }
}

// Namespace zm_sat_locust_audio
// Params 2, eflags: 0x4
// Checksum 0x7e68bbb, Offset: 0xe4d
// Size: 0x70, Type: bool
function private function_78073dd15738fe39( attacker, battlechatter )
{
    if ( ( self.subclass == "zombie_karkinos" || self.subclass == "zombie_karkinos_hvt" || self.subclass == "zombie_base_luna" || self.subclass == "zombie_callisto_hvt" ) && attacker namespace_c0b4f2882c9d100f::is_hero_operator() )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_locust_audio
// Params 1, eflags: 0x4
// Checksum 0xcd443563, Offset: 0xec6
// Size: 0x86
function private on_player_damaged( params )
{
    if ( ( params.eattacker.subclass == "zombie_karkinos" || params.eattacker.subclass == "zombie_karkinos_hvt" ) && !self.var_ad8055826fa308e1 )
    {
        self endon( #"disconnect" );
        self.var_ad8055826fa308e1 = 1;
        self.var_ad8055826fa308e1 = namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_94557d095f1b1f74" );
    }
}

// Namespace zm_sat_locust_audio
// Params 1, eflags: 0x4
// Checksum 0xae1ec8b9, Offset: 0xf54
// Size: 0x1d0
function private on_ai_killed( params )
{
    player = params.eattacker;
    
    if ( !isplayer( player ) || !player namespace_c0b4f2882c9d100f::is_hero_operator() )
    {
        return;
    }
    
    player endon( #"disconnect" );
    
    if ( ( self.subclass == "zombie_karkinos" || self.subclass == "zombie_karkinos_hvt" ) && !player.var_56aabcece65c1394[ "zombie_karkinos" ] )
    {
        str_subclass = "zombie_karkinos";
        str_vo_kill = #"hash_677b4b742e50a27d";
        var_68749b0b487970a0 = #"hash_f9f92988a678a829";
    }
    else if ( self.subclass == "zombie_base_luna" && !player.var_56aabcece65c1394[ "zombie_base_luna" ] )
    {
        str_subclass = "zombie_base_luna";
        str_vo_kill = #"hash_91a4121e28018f48";
        var_68749b0b487970a0 = #"hash_65dc226747180cee";
    }
    else if ( self.subclass == "zombie_callisto_hvt" && !player.var_56aabcece65c1394[ "zombie_callisto_hvt" ] )
    {
        str_subclass = "zombie_callisto_hvt";
        str_vo_kill = #"hash_8643780d624b9c84";
        var_68749b0b487970a0 = #"hash_5bb40f83924a49aa";
    }
    
    if ( isdefined( str_subclass ) && isdefined( str_vo_kill ) && isdefined( var_68749b0b487970a0 ) )
    {
        player.var_56aabcece65c1394[ str_subclass ] = 1;
        wait 1;
        var_db75d3de862ce072 = player_banter::play_banter_vo( str_vo_kill, [ player ] );
        
        if ( var_db75d3de862ce072 )
        {
            a_players_nearby = getplayersinradius( player.origin, 1000, undefined, 1, [ player ] );
            wait 1;
            player_banter::play_banter_vo( var_68749b0b487970a0, a_players_nearby );
            return;
        }
        
        player.var_56aabcece65c1394[ str_subclass ] = undefined;
    }
}

// Namespace zm_sat_locust_audio
// Params 0, eflags: 0x4
// Checksum 0x22439e2, Offset: 0x112c
// Size: 0x40c
function private play_end_of_round_vo()
{
    if ( level.gametypebundle.var_3a3d08ee9ea8932a )
    {
        return;
    }
    
    /#
        if ( isofflinetoolrun( 31 ) )
        {
            return;
        }
    #/
    
    level.var_bbe2ae9963c25f75[ level.var_bbe2ae9963c25f75.size ] = "end_of_round_vo_playing";
    level.var_bbe2ae9963c25f75[ level.var_bbe2ae9963c25f75.size ] = "special_round_vo_active";
    level endon( #"game_ended" );
    
    if ( level.alt_mode_start_vo )
    {
        utility::flag_wait( "alt_mode_start_vo_done" );
    }
    
    level utility::flag_wait( "begin_round_logic" );
    overlord::function_b606cb1cebb2a4f5( "zm_sat_locust_dialogue_overlord" );
    wait 7;
    level thread function_14059fcc5cc36409();
    var_8d885b4aed0bef01 = zm_utility::get_round_number();
    n_current_round_vo_index = var_8d885b4aed0bef01;
    
    if ( zm_save::function_1dda3554974a999e() )
    {
        n_current_round_vo_index = var_8d885b4aed0bef01 - 1;
        n_current_round_vo_index = int( clamp( n_current_round_vo_index, 1, var_8d885b4aed0bef01 ) );
    }
    
    var_5771ab8d3e43fce2 = 1;
    var_1f21a9995de8764e = 2;
    var_1ac278717413299b = 3;
    var_65e988690474ed1 = 6;
    
    if ( n_current_round_vo_index == var_5771ab8d3e43fce2 && !level zm_save::function_1dda3554974a999e() )
    {
        zm_quest::function_d5ef98341fd6a057( [ #"hash_a16f193a78262070", #"hash_a16f1c3a78262589", #"hash_a16f1b3a782623d6", #"hash_a16f1e3a782628ef" ] );
        player_banter::play_banter_vo( #"match_start" );
    }
    
    utility::flag_set( "match_start_vo_done" );
    
    if ( n_current_round_vo_index < var_1f21a9995de8764e )
    {
        level utility::function_3be250f0ba0da4f6( "on_round_end", var_65e988690474ed1 );
    }
    
    var_8d885b4aed0bef01 = zm_utility::get_round_number();
    n_current_round_vo_index = var_8d885b4aed0bef01;
    
    if ( n_current_round_vo_index == var_1f21a9995de8764e )
    {
        level utility::flag_set( "end_of_round_vo_playing" );
        zm_quest::function_d5ef98341fd6a057( [ #"hash_8686c59aa5a7d204", #"hash_8686c89aa5a7d71d", #"hash_8686c79aa5a7d56a", #"hash_8686c29aa5a7cceb" ] );
        player_banter::play_banter_vo( #"end_of_round_1" );
        level utility::flag_clear( "end_of_round_vo_playing" );
    }
    
    if ( n_current_round_vo_index < var_1ac278717413299b )
    {
        level utility::function_3be250f0ba0da4f6( "on_round_end", var_65e988690474ed1 );
    }
    
    var_8d885b4aed0bef01 = zm_utility::get_round_number();
    n_current_round_vo_index = var_8d885b4aed0bef01;
    
    if ( n_current_round_vo_index == var_1ac278717413299b )
    {
        level utility::flag_set( "end_of_round_vo_playing" );
        zm_quest::function_d5ef98341fd6a057( [ #"hash_71771a749b594023", #"hash_71771b749b5941d6", #"hash_71771c749b594389", #"hash_71771d749b59453c" ] );
        player_banter::play_banter_vo( #"end_of_round_2" );
        level utility::flag_clear( "end_of_round_vo_playing" );
    }
    
    var_27649968ee62b8a3 = 6;
    var_9b1200395baea90e = n_current_round_vo_index;
    
    while ( true )
    {
        level utility::function_3be250f0ba0da4f6( "on_round_end", var_65e988690474ed1 );
        waitframe();
        
        if ( utility::flag( "locust_skip_round_vo" ) || utility::flag( "special_round_vo_active" ) || level.var_a009ab14ee0d3223.isspecialround || utility::flag( "twins_dialogue_playing" ) )
        {
            continue;
        }
        
        if ( namespace_c0b4f2882c9d100f::function_5600317993be908b() == 1 )
        {
            if ( var_9b1200395baea90e > var_27649968ee62b8a3 )
            {
                level utility::flag_set( "solo_locust_round_vo_done" );
                continue;
            }
            
            function_ef88afc852229531( 0 );
            zm_quest::function_8934bb2a9028bdc5();
            var_8984c1f1eeea88ec = hashcat( #"hash_878ce778d8cfb22e", var_9b1200395baea90e, "_solo" );
            level utility::flag_set( "end_of_round_vo_playing" );
            var_db75d3de862ce072 = player_banter::function_59ab3c2fe1424d34( var_8984c1f1eeea88ec ) && player_banter::play_banter_vo( var_8984c1f1eeea88ec );
            level utility::flag_clear( "end_of_round_vo_playing" );
            
            if ( var_db75d3de862ce072 )
            {
                var_9b1200395baea90e++;
            }
            
            function_ef88afc852229531( 1 );
        }
        else if ( namespace_c0b4f2882c9d100f::function_5600317993be908b() >= 2 )
        {
            level utility::flag_set( "end_of_round_vo_playing" );
            function_ef88afc852229531( 0 );
            zm_quest::function_8934bb2a9028bdc5();
            var_55f7b3d19fbd8c26 = namespace_c0b4f2882c9d100f::function_45cca440418fb22b();
            function_9e4dcbd2ff52b5ce( var_55f7b3d19fbd8c26 );
            function_ef88afc852229531( 1 );
            level utility::flag_clear( "end_of_round_vo_playing" );
        }
        
        if ( function_509cccd57cd28382() )
        {
            return;
        }
    }
}

// Namespace zm_sat_locust_audio
// Params 0, eflags: 0x4
// Checksum 0x78efa296, Offset: 0x1540
// Size: 0x34d
function private function_14059fcc5cc36409()
{
    var_31b31b24d4fa19ff = 1;
    var_63fe7dd9cff50165 = 1;
    var_46cedaf8b1ad8dd7 = 1;
    var_a9b4c3e24723a338 = 1;
    n_vo_start_round = 16;
    
    if ( zm_save::function_1dda3554974a999e() )
    {
        n_round_number_check = zm_utility::get_round_number() + 2;
        var_31b31b24d4fa19ff = max( 1, n_round_number_check - n_vo_start_round );
        var_63fe7dd9cff50165 = max( 1, n_round_number_check - n_vo_start_round );
        var_46cedaf8b1ad8dd7 = max( 1, n_round_number_check - n_vo_start_round );
        var_a9b4c3e24723a338 = max( 1, n_round_number_check - n_vo_start_round );
    }
    
    var_824135a6ee782fd = 4;
    var_fcb1e2f9972c3ad3 = 4;
    
    while ( true )
    {
        if ( var_31b31b24d4fa19ff > var_824135a6ee782fd && var_63fe7dd9cff50165 > var_824135a6ee782fd && var_46cedaf8b1ad8dd7 > var_fcb1e2f9972c3ad3 && var_a9b4c3e24723a338 > var_fcb1e2f9972c3ad3 )
        {
            return;
        }
        
        level utility::function_3be250f0ba0da4f6( "on_round_end", 5 );
        var_8d885b4aed0bef01 = zm_utility::get_round_number();
        
        if ( var_8d885b4aed0bef01 < n_vo_start_round )
        {
            continue;
        }
        
        var_f43eb6e734c44585 = [];
        
        foreach ( player in level.players )
        {
            if ( isalive( player ) && !player::isinlaststand( player ) && ( player namespace_c0b4f2882c9d100f::is_nikolai() || player namespace_c0b4f2882c9d100f::is_grey() || player namespace_c0b4f2882c9d100f::is_dempsey() || player namespace_c0b4f2882c9d100f::is_maya() ) )
            {
                if ( player namespace_c0b4f2882c9d100f::is_nikolai() && var_31b31b24d4fa19ff <= var_824135a6ee782fd )
                {
                    var_f43eb6e734c44585[ var_f43eb6e734c44585.size ] = player;
                }
                
                if ( player namespace_c0b4f2882c9d100f::is_grey() && var_63fe7dd9cff50165 <= var_824135a6ee782fd )
                {
                    var_f43eb6e734c44585[ var_f43eb6e734c44585.size ] = player;
                }
                
                if ( player namespace_c0b4f2882c9d100f::is_dempsey() && var_46cedaf8b1ad8dd7 <= var_fcb1e2f9972c3ad3 )
                {
                    var_f43eb6e734c44585[ var_f43eb6e734c44585.size ] = player;
                }
                
                if ( player namespace_c0b4f2882c9d100f::is_maya() && var_a9b4c3e24723a338 <= var_fcb1e2f9972c3ad3 )
                {
                    var_f43eb6e734c44585[ var_f43eb6e734c44585.size ] = player;
                }
            }
        }
        
        if ( var_f43eb6e734c44585.size == 0 )
        {
            continue;
        }
        
        player = utility::array_random( var_f43eb6e734c44585 );
        utility::flag_set( "locust_skip_round_vo" );
        var_db75d3de862ce072 = 0;
        
        if ( player namespace_c0b4f2882c9d100f::is_nikolai() )
        {
            var_8984c1f1eeea88ec = hashcat( #"hash_2981a139e677870a", var_31b31b24d4fa19ff );
            
            if ( player_banter::function_59ab3c2fe1424d34( var_8984c1f1eeea88ec ) )
            {
                var_db75d3de862ce072 = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( var_8984c1f1eeea88ec );
                
                if ( var_db75d3de862ce072 )
                {
                    var_31b31b24d4fa19ff++;
                }
            }
        }
        else if ( player namespace_c0b4f2882c9d100f::is_grey() )
        {
            var_8984c1f1eeea88ec = hashcat( #"hash_2981a139e677870a", var_63fe7dd9cff50165 );
            
            if ( player_banter::function_59ab3c2fe1424d34( var_8984c1f1eeea88ec ) )
            {
                var_db75d3de862ce072 = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( var_8984c1f1eeea88ec );
                
                if ( var_db75d3de862ce072 )
                {
                    var_63fe7dd9cff50165++;
                }
            }
        }
        else if ( player namespace_c0b4f2882c9d100f::is_dempsey() )
        {
            var_8984c1f1eeea88ec = hashcat( #"hash_58f5caf4f85a6c96", var_46cedaf8b1ad8dd7 );
            
            if ( player_banter::function_59ab3c2fe1424d34( var_8984c1f1eeea88ec ) )
            {
                var_db75d3de862ce072 = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( var_8984c1f1eeea88ec );
                
                if ( var_db75d3de862ce072 )
                {
                    var_46cedaf8b1ad8dd7++;
                }
            }
        }
        else if ( player namespace_c0b4f2882c9d100f::is_maya() )
        {
            var_8984c1f1eeea88ec = hashcat( #"hash_58f5caf4f85a6c96", var_a9b4c3e24723a338 );
            
            if ( player_banter::function_59ab3c2fe1424d34( var_8984c1f1eeea88ec ) )
            {
                var_db75d3de862ce072 = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( var_8984c1f1eeea88ec );
                
                if ( var_db75d3de862ce072 )
                {
                    var_a9b4c3e24723a338++;
                }
            }
        }
        
        utility::flag_clear( "locust_skip_round_vo" );
    }
}

// Namespace zm_sat_locust_audio
// Params 1, eflags: 0x4
// Checksum 0x37294d6b, Offset: 0x1895
// Size: 0xab1
function private function_9e4dcbd2ff52b5ce( var_55f7b3d19fbd8c26 )
{
    if ( !isdefined( var_55f7b3d19fbd8c26 ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_d8b89f987d691954[ "weaver_and_grey" ] ) )
    {
        level.var_d8b89f987d691954[ "weaver_and_grey" ] = 1;
    }
    
    if ( !isdefined( level.var_d8b89f987d691954[ "weaver_and_carver" ] ) )
    {
        level.var_d8b89f987d691954[ "weaver_and_carver" ] = 1;
    }
    
    if ( !isdefined( level.var_d8b89f987d691954[ "weaver_and_maya" ] ) )
    {
        level.var_d8b89f987d691954[ "weaver_and_maya" ] = 1;
    }
    
    if ( !isdefined( level.var_d8b89f987d691954[ "grey_and_carver" ] ) )
    {
        level.var_d8b89f987d691954[ "grey_and_carver" ] = 1;
    }
    
    if ( !isdefined( level.var_d8b89f987d691954[ "grey_and_maya" ] ) )
    {
        level.var_d8b89f987d691954[ "grey_and_maya" ] = 1;
    }
    
    if ( !isdefined( level.var_d8b89f987d691954[ "carver_and_maya" ] ) )
    {
        level.var_d8b89f987d691954[ "carver_and_maya" ] = 1;
    }
    
    if ( !isdefined( level.var_d8b89f987d691954[ "richtofen_and_dempsey" ] ) )
    {
        level.var_d8b89f987d691954[ "richtofen_and_dempsey" ] = 1;
    }
    
    if ( !isdefined( level.var_d8b89f987d691954[ "richtofen_and_takeo" ] ) )
    {
        level.var_d8b89f987d691954[ "richtofen_and_takeo" ] = 1;
    }
    
    if ( !isdefined( level.var_d8b89f987d691954[ "richtofen_and_nikolai" ] ) )
    {
        level.var_d8b89f987d691954[ "richtofen_and_nikolai" ] = 1;
    }
    
    if ( !isdefined( level.var_d8b89f987d691954[ "dempsey_and_takeo" ] ) )
    {
        level.var_d8b89f987d691954[ "dempsey_and_takeo" ] = 1;
    }
    
    if ( !isdefined( level.var_d8b89f987d691954[ "dempsey_and_nikolai" ] ) )
    {
        level.var_d8b89f987d691954[ "dempsey_and_nikolai" ] = 1;
    }
    
    if ( !isdefined( level.var_d8b89f987d691954[ "takeo_and_nikolai" ] ) )
    {
        level.var_d8b89f987d691954[ "takeo_and_nikolai" ] = 1;
    }
    
    if ( !isdefined( level.var_d8b89f987d691954[ "weaver_and_richtofen" ] ) )
    {
        level.var_d8b89f987d691954[ "weaver_and_richtofen" ] = 1;
    }
    
    if ( !isdefined( level.var_d8b89f987d691954[ "weaver_and_dempsey" ] ) )
    {
        level.var_d8b89f987d691954[ "weaver_and_dempsey" ] = 1;
    }
    
    if ( !isdefined( level.var_d8b89f987d691954[ "weaver_and_takeo" ] ) )
    {
        level.var_d8b89f987d691954[ "weaver_and_takeo" ] = 1;
    }
    
    if ( !isdefined( level.var_d8b89f987d691954[ "weaver_and_nikolai" ] ) )
    {
        level.var_d8b89f987d691954[ "weaver_and_nikolai" ] = 1;
    }
    
    if ( !isdefined( level.var_d8b89f987d691954[ "grey_and_richtofen" ] ) )
    {
        level.var_d8b89f987d691954[ "grey_and_richtofen" ] = 1;
    }
    
    if ( !isdefined( level.var_d8b89f987d691954[ "grey_and_dempsey" ] ) )
    {
        level.var_d8b89f987d691954[ "grey_and_dempsey" ] = 1;
    }
    
    if ( !isdefined( level.var_d8b89f987d691954[ "grey_and_takeo" ] ) )
    {
        level.var_d8b89f987d691954[ "grey_and_takeo" ] = 1;
    }
    
    if ( !isdefined( level.var_d8b89f987d691954[ "grey_and_nikolai" ] ) )
    {
        level.var_d8b89f987d691954[ "grey_and_nikolai" ] = 1;
    }
    
    if ( !isdefined( level.var_d8b89f987d691954[ "carver_and_richtofen" ] ) )
    {
        level.var_d8b89f987d691954[ "carver_and_richtofen" ] = 1;
    }
    
    if ( !isdefined( level.var_d8b89f987d691954[ "carver_and_dempsey" ] ) )
    {
        level.var_d8b89f987d691954[ "carver_and_dempsey" ] = 1;
    }
    
    if ( !isdefined( level.var_d8b89f987d691954[ "carver_and_takeo" ] ) )
    {
        level.var_d8b89f987d691954[ "carver_and_takeo" ] = 1;
    }
    
    if ( !isdefined( level.var_d8b89f987d691954[ "carver_and_nikolai" ] ) )
    {
        level.var_d8b89f987d691954[ "carver_and_nikolai" ] = 1;
    }
    
    if ( !isdefined( level.var_d8b89f987d691954[ "maya_and_richtofen" ] ) )
    {
        level.var_d8b89f987d691954[ "maya_and_richtofen" ] = 1;
    }
    
    if ( !isdefined( level.var_d8b89f987d691954[ "maya_and_dempsey" ] ) )
    {
        level.var_d8b89f987d691954[ "maya_and_dempsey" ] = 1;
    }
    
    if ( !isdefined( level.var_d8b89f987d691954[ "maya_and_takeo" ] ) )
    {
        level.var_d8b89f987d691954[ "maya_and_takeo" ] = 1;
    }
    
    if ( !isdefined( level.var_d8b89f987d691954[ "maya_and_nikolai" ] ) )
    {
        level.var_d8b89f987d691954[ "maya_and_nikolai" ] = 1;
    }
    
    if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "weaver" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "grey" ) )
    {
        str_current_vo_index = "weaver_and_grey";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "weaver" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "carver" ) )
    {
        str_current_vo_index = "weaver_and_carver";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "weaver" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "maya" ) )
    {
        str_current_vo_index = "weaver_and_maya";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "grey" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "carver" ) )
    {
        str_current_vo_index = "grey_and_carver";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "grey" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "maya" ) )
    {
        str_current_vo_index = "grey_and_maya";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "carver" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "maya" ) )
    {
        str_current_vo_index = "carver_and_maya";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "richtofen" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "dempsey" ) )
    {
        str_current_vo_index = "richtofen_and_dempsey";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "richtofen" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "takeo" ) )
    {
        str_current_vo_index = "richtofen_and_takeo";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "richtofen" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "nikolai" ) )
    {
        str_current_vo_index = "richtofen_and_nikolai";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "dempsey" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "takeo" ) )
    {
        str_current_vo_index = "dempsey_and_takeo";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "dempsey" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "nikolai" ) )
    {
        str_current_vo_index = "dempsey_and_nikolai";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "takeo" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "nikolai" ) )
    {
        str_current_vo_index = "takeo_and_nikolai";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "weaver" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "richtofen" ) )
    {
        str_current_vo_index = "weaver_and_richtofen";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "weaver" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "dempsey" ) )
    {
        str_current_vo_index = "weaver_and_dempsey";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "weaver" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "takeo" ) )
    {
        str_current_vo_index = "weaver_and_takeo";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "weaver" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "nikolai" ) )
    {
        str_current_vo_index = "weaver_and_nikolai";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "grey" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "richtofen" ) )
    {
        str_current_vo_index = "grey_and_richtofen";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "grey" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "dempsey" ) )
    {
        str_current_vo_index = "grey_and_dempsey";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "grey" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "takeo" ) )
    {
        str_current_vo_index = "grey_and_takeo";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "grey" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "nikolai" ) )
    {
        str_current_vo_index = "grey_and_nikolai";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "carver" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "richtofen" ) )
    {
        str_current_vo_index = "carver_and_richtofen";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "carver" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "dempsey" ) )
    {
        str_current_vo_index = "carver_and_dempsey";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "carver" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "takeo" ) )
    {
        str_current_vo_index = "carver_and_takeo";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "carver" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "nikolai" ) )
    {
        str_current_vo_index = "carver_and_nikolai";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "maya" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "richtofen" ) )
    {
        str_current_vo_index = "maya_and_richtofen";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "maya" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "dempsey" ) )
    {
        str_current_vo_index = "maya_and_dempsey";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "maya" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "takeo" ) )
    {
        str_current_vo_index = "maya_and_takeo";
    }
    else if ( arraycontains( var_55f7b3d19fbd8c26.a_player_names, "maya" ) && arraycontains( var_55f7b3d19fbd8c26.a_player_names, "nikolai" ) )
    {
        str_current_vo_index = "maya_and_nikolai";
    }
    
    if ( isdefined( str_current_vo_index ) )
    {
        var_fd1b7ff5802cd4e = hashcat( #"hash_878ce778d8cfb22e", str_current_vo_index, "_", level.var_d8b89f987d691954[ str_current_vo_index ] );
        
        if ( player_banter::function_59ab3c2fe1424d34( var_fd1b7ff5802cd4e ) )
        {
            b_success = player_banter::play_banter_vo( var_fd1b7ff5802cd4e, var_55f7b3d19fbd8c26.a_players );
            
            if ( b_success )
            {
                level.var_d8b89f987d691954[ str_current_vo_index ]++;
            }
        }
    }
}

// Namespace zm_sat_locust_audio
// Params 1, eflags: 0x4
// Checksum 0x4209a503, Offset: 0x234e
// Size: 0xab
function private function_ef88afc852229531( var_f1fbc291f2430b1e )
{
    foreach ( player in level.players )
    {
        if ( var_f1fbc291f2430b1e )
        {
            player val::reset( "locust_round_vo", "allow_battlechatter_vo" );
            continue;
        }
        
        player val::set( "locust_round_vo", "allow_battlechatter_vo", 0 );
    }
}

// Namespace zm_sat_locust_audio
// Params 0, eflags: 0x4
// Checksum 0x96d796a2, Offset: 0x2401
// Size: 0xa0, Type: bool
function private function_509cccd57cd28382()
{
    if ( !isdefined( level.var_d8b89f987d691954 ) )
    {
        return false;
    }
    
    foreach ( var_9e593b99df05ebf5 in level.var_d8b89f987d691954 )
    {
        if ( var_9e593b99df05ebf5 <= 4 )
        {
            return false;
        }
    }
    
    if ( !level utility::flag( "solo_locust_round_vo_done" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_locust_audio
// Params 1
// Checksum 0xe9dd80bb, Offset: 0x24aa
// Size: 0xcb, Type: bool
function is_vo_available( player )
{
    if ( zm_quest::is_vo_active() )
    {
        return false;
    }
    
    if ( utility::flag( "locust_skip_round_vo" ) )
    {
        return false;
    }
    
    foreach ( flag in level.var_bbe2ae9963c25f75 )
    {
        if ( utility::flag( flag ) )
        {
            return false;
        }
    }
    
    if ( player && ( !player val::get( "allow_battlechatter_vo" ) || player player_banter::function_4e1aff6241ebea8() ) )
    {
        return false;
    }
    
    return true;
}

/#

    // Namespace zm_sat_locust_audio
    // Params 0, eflags: 0x4
    // Checksum 0xec034d9e, Offset: 0x257e
    // Size: 0xc, Type: dev
    function private debug_init()
    {
        devgui_init();
    }

    // Namespace zm_sat_locust_audio
    // Params 0, eflags: 0x4
    // Checksum 0x342d63a3, Offset: 0x2592
    // Size: 0x1d8, Type: dev
    function private devgui_init()
    {
        dialogues = [];
        dialogues[ "<dev string:x7e>" ] = [ "<dev string:x81>", "<dev string:x9e>" ];
        dialogues[ "<dev string:xbd>" ] = [ "<dev string:xc5>", "<dev string:xe4>", "<dev string:x103>", "<dev string:x124>", "<dev string:x143>", "<dev string:x164>", "<dev string:x185>" ];
        dialogues[ "<dev string:x1a8>" ] = [ "<dev string:x1ac>", "<dev string:x1cc>", "<dev string:x1ec>", "<dev string:x20c>", "<dev string:x22e>", "<dev string:x24e>" ];
        dialogues[ "<dev string:x26e>" ] = [ "<dev string:x274>", "<dev string:x294>", "<dev string:x2b4>" ];
        devgui::function_9082edeb5db93280( "<dev string:x2d6>" );
        
        foreach ( key, lines in dialogues )
        {
            foreach ( line in lines )
            {
                devgui::function_cd4e263c1f3018ae( key + "<dev string:x2fb>" + line, "<dev string:x2fd>" + line, &function_f79c19f259858807 );
            }
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_locust_audio
    // Params 1, eflags: 0x4
    // Checksum 0x3284d4e7, Offset: 0x2772
    // Size: 0x19, Type: dev
    function private function_f79c19f259858807( params )
    {
        zm_sat_locust_util::function_a8b578b47e763d0f( params[ 0 ] );
    }

#/
