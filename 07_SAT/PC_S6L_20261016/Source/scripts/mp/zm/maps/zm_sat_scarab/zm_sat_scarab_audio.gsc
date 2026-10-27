// scripts\mp\zm\maps\zm_sat_scarab\zm_sat_scarab_audio.gsc  (hash_37bdb8bc8a7e4230.gscc) (size: 17619 Bytes / 0x44d3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x80010b5a (2147552090)
// size ...... 17619 (0x44d3)
// includes .. 14  (offset: 0x3def)
// strings ... 91  (offset: 0x3e5f)
// dev strs .. 0   (offset: 0x44d3)
// exports ... 21  (offset: 0x2db7)
// cseg ...... 0x7ef + 0x25c8 (0x2db7)
// imports ... 90  (offset: 0x30ff)
// animtree1 . 0   (offset: 0x44d3)
// animtree2 . 0   (offset: 0x44d3)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\magicbox;
#using scripts\mp\overlord;
#using scripts\mp\player_banter;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_utility;

#namespace zm_sat_scarab_audio;

// Namespace zm_sat_scarab_audio
// Params 0
// Checksum 0xabd2b326, Offset: 0x80d
// Size: 0x371
function main()
{
    namespace_c0b4f2882c9d100f::function_55319be40b828f47( #"game_over", #"hash_8700fcdb0c997172" );
    namespace_c0b4f2882c9d100f::function_55319be40b828f47( #"full_ammo", #"hash_9fe36edb1a61e771" );
    namespace_c0b4f2882c9d100f::function_55319be40b828f47( #"double_points", #"hash_9ff477db1a7069ef" );
    namespace_c0b4f2882c9d100f::function_55319be40b828f47( #"insta_kill", #"hash_9ffe90db1a78e8ef" );
    namespace_c0b4f2882c9d100f::function_55319be40b828f47( #"fire_sale", #"hash_9fed88db1a6a6824" );
    namespace_c0b4f2882c9d100f::function_55319be40b828f47( #"full_armor", #"hash_9fe377db1a61f6bc" );
    namespace_c0b4f2882c9d100f::function_55319be40b828f47( #"nuke", #"hash_a00890db1a813d74" );
    namespace_c0b4f2882c9d100f::function_55319be40b828f47( #"bonus_points_team", #"hash_9fdf73db1a5e0719" );
    namespace_c0b4f2882c9d100f::function_55319be40b828f47( #"full_power", #"hash_9fed8bdb1a6a6d3d" );
    namespace_c0b4f2882c9d100f::function_55319be40b828f47( #"free_perk", #"hash_a01673db1a8d4989" );
    namespace_c0b4f2882c9d100f::function_55319be40b828f47( #"eternal_perk", #"hash_a3c81b0b06d33e2b" );
    magicbox::function_193ed9e2a7303c24( #"bunny_sound_6" );
    namespace_c0b4f2882c9d100f::function_8464c50734af5965();
    level thread function_481e8ebb93c62225();
    level.s_zm_vo.var_a082742f518d9ed1 = 100;
    level.s_zm_vo.var_e05a82d77bd87fe0 = 8;
    level callback::add( #"hash_abdf98ae1ea92589", &function_b1998e8f0399b9f0 );
    level callback::add( #"hash_bff79b6f9fd68943", &function_531c9606d7ea81e );
    level callback::add( #"hash_da77bbca464577cd", &function_63159e8f8627b23e );
    level callback::add( #"on_ai_killed", &on_ai_killed );
    level callback::add( #"player_connect", &on_player_connect );
    
    if ( !level.gametypebundle.var_3a3d08ee9ea8932a )
    {
        level.var_cff73928ee710352[ "forge" ] = [ "zone_nexus_exterior_ring" ];
        level.var_cff73928ee710352[ "veytharion_temple" ] = [ "zone_nw_temple_exterior", "zone_nw_temple_exterior_steps", "zone_nw_temple_entrance", "zone_nw_temple_mainhall", "zone_nw_temple_westwing" ];
        level.var_cff73928ee710352[ "dravakar_temple" ] = [ "zone_ne_temple_exterior", "zone_ne_temple_exterior_steps", "zone_ne_temple_courtyard" ];
        level.var_cff73928ee710352[ "caltheris_temple" ] = [ "zone_se_temple_exterior_bridge", "zone_se_temple_exterior_steps", "zone_se_temple_entrance" ];
        level.var_cff73928ee710352[ "nyxara_temple" ] = [ "zone_sw_temple_exterior", "zone_sw_temple_exterior_steps", "zone_sw_temple_entrance", "zone_sw_temple_mainhall", "zone_sw_temple_sideroom_landing", "zone_sw_temple_finalroom" ];
        level callback::add( "zone_changed", &function_2b55d8a6555e76c8 );
        level thread function_c56020b6bf08d23();
    }
    
    level.var_f47ecf60e4790ad6 = &function_78073dd15738fe39;
    level.var_8f451dc60be8e7a2 = &function_acf41d919395c190;
    level thread play_end_of_round_vo();
    level thread function_8928e80dea0a3c4f();
    level.var_ba529dd24d268adf = spawn( "trigger_box", ( -135.5, -3641, 1788.5 ), 0, ( 57, 39, 32 ), ( 51.5, 46.5, 70 ) );
    trigger::makeenterexittrigger( level.var_ba529dd24d268adf, &function_8ab6741cc3f62007 );
}

// Namespace zm_sat_scarab_audio
// Params 0
// Checksum 0xd57f4949, Offset: 0xb86
// Size: 0x2c
function function_481e8ebb93c62225()
{
    level endon( #"game_ended" );
    utility::flag_wait( "scarab_boss_fight_complete" );
    level.var_453e7b180cb422e0 = 1;
    namespace_c0b4f2882c9d100f::function_c0b0828d1107c141();
}

// Namespace zm_sat_scarab_audio
// Params 1
// Checksum 0x6827c403, Offset: 0xbba
// Size: 0x39
function on_player_connect( params )
{
    self endon( #"death_or_disconnect" );
    
    if ( !level utility::flag( "safehouse_exterior_door_bought" ) )
    {
        waitframe();
        musicbank_utility::function_386364349468bbb3( #"zm_sat_scarab_safehouse" );
    }
}

// Namespace zm_sat_scarab_audio
// Params 0
// Checksum 0x253f3f5e, Offset: 0xbfb
// Size: 0x9c
function function_8928e80dea0a3c4f()
{
    level endon( #"game_ended" );
    utility::flag_wait( "safehouse_exterior_door_bought" );
    
    foreach ( player in level.players )
    {
        player musicbank_utility::function_386364349468bbb3( #"zm_sat_scarab" );
    }
}

// Namespace zm_sat_scarab_audio
// Params 1
// Checksum 0xc635f5d8, Offset: 0xc9f
// Size: 0xd7
function function_2b55d8a6555e76c8( params )
{
    player = self;
    player endon( #"disconnect" );
    str_zone_vo_index = undefined;
    
    foreach ( index, var_a77bb00f025e9731 in level.var_cff73928ee710352 )
    {
        if ( arraycontains( var_a77bb00f025e9731, params.zone_struct.zone_name ) )
        {
            str_zone_vo_index = index;
            break;
        }
    }
    
    var_db75d3de862ce072 = function_5578c6aaf46b6c51( player, str_zone_vo_index );
}

// Namespace zm_sat_scarab_audio
// Params 0
// Checksum 0x2bc66e0a, Offset: 0xd7e
// Size: 0x238
function function_c56020b6bf08d23()
{
    level endon( #"game_ended" );
    utility::flag_wait( "begin_round_logic" );
    var_8ef4e2795656eb1 = utility::getstructarray( "stone_titan_trap", "targetname" );
    
    while ( true )
    {
        var_41b19dcd24935e68 = undefined;
        var_67971548cb8d491 = undefined;
        
        foreach ( player in level.players )
        {
            foreach ( var_117ff536dac651b4 in var_8ef4e2795656eb1 )
            {
                if ( isalive( player ) && distancesquared( player.origin, var_117ff536dac651b4.origin ) < 562500 && withinfov( player.origin, player.angles, var_117ff536dac651b4.origin, cos( 45 ) ) )
                {
                    if ( player namespace_c0b4f2882c9d100f::is_richtofen() || player namespace_c0b4f2882c9d100f::is_maya() || player namespace_c0b4f2882c9d100f::is_carver() )
                    {
                        var_41b19dcd24935e68 = player;
                        var_67971548cb8d491 = zone_manager::function_90e5c3e2272b0130( var_117ff536dac651b4.origin ).zone_name;
                        break;
                    }
                }
            }
            
            if ( isdefined( var_41b19dcd24935e68 ) )
            {
                break;
            }
        }
        
        if ( isdefined( var_41b19dcd24935e68 ) && ( var_41b19dcd24935e68 namespace_c0b4f2882c9d100f::is_carver() || var_41b19dcd24935e68 namespace_c0b4f2882c9d100f::is_richtofen() || var_41b19dcd24935e68 namespace_c0b4f2882c9d100f::is_maya() && ( var_67971548cb8d491 == "zone_nw_temple_exterior_steps" || level.var_61217dc92a742658 ) ) )
        {
            var_db75d3de862ce072 = function_5578c6aaf46b6c51( var_41b19dcd24935e68, "titan_trap" );
            
            if ( var_db75d3de862ce072 )
            {
                return;
            }
        }
        
        wait 1;
    }
}

// Namespace zm_sat_scarab_audio
// Params 2
// Checksum 0x15d18971, Offset: 0xfbe
// Size: 0x24e
function function_5578c6aaf46b6c51( player, str_zone_vo_index )
{
    if ( !isalive( player ) || !isdefined( str_zone_vo_index ) || level.var_c0265c3b226f19f8[ str_zone_vo_index ] )
    {
        return;
    }
    
    switch ( str_zone_vo_index )
    {
        case #"hash_89ac6ff59c26cce2":
            var_8f87bcdcead07df7 = "sst_made_nice1";
            break;
        case #"hash_71563501b7584b8e":
            var_8f87bcdcead07df7 = "sst_made_nice2";
            break;
        case #"hash_68da0aafc28b3185":
            var_8f87bcdcead07df7 = "sst_made_nice3";
            break;
        case #"hash_eb12285534f82014":
            var_8f87bcdcead07df7 = "sst_made_nice4";
            break;
    }
    
    if ( isdefined( var_8f87bcdcead07df7 ) && utility::flag( var_8f87bcdcead07df7 ) )
    {
        return;
    }
    
    level.var_c0265c3b226f19f8[ str_zone_vo_index ] = 1;
    wait 2;
    
    if ( function_7606443c19ef441e() )
    {
        level.var_c0265c3b226f19f8[ str_zone_vo_index ] = 0;
        return;
    }
    
    utility::flag_set( "poi_arrival_vo_playing" );
    var_db26853536a3dec = player namespace_c0b4f2882c9d100f::function_470ff6ad4f437db1();
    level.var_c0265c3b226f19f8[ str_zone_vo_index ] = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( hashcat( #"hash_a3524296dd386fd2", str_zone_vo_index ) );
    
    if ( level.var_c0265c3b226f19f8[ str_zone_vo_index ] )
    {
        a_nearby_players = getplayersinradius( player.origin, 1000, undefined, 1, [ player ] );
        var_9dce04581f2701f = [];
        
        foreach ( nearby_player in a_nearby_players )
        {
            if ( namespace_c0b4f2882c9d100f::function_5cf61b74062b7a8b( player, nearby_player ) )
            {
                continue;
            }
            
            var_9dce04581f2701f[ var_9dce04581f2701f.size ] = nearby_player;
        }
        
        var_13373272690692d0 = player_banter::play_banter_vo( hashcat( #"hash_a3524296dd386fd2", str_zone_vo_index, "_", var_db26853536a3dec, "_response" ), var_9dce04581f2701f, undefined, 1 );
    }
    
    if ( str_zone_vo_index == "caltheris_temple" && level.var_c0265c3b226f19f8[ str_zone_vo_index ] )
    {
        level.var_61217dc92a742658 = 1;
    }
    
    utility::flag_clear( "poi_arrival_vo_playing" );
    return level.var_c0265c3b226f19f8[ str_zone_vo_index ];
}

// Namespace zm_sat_scarab_audio
// Params 2
// Checksum 0x806ae948, Offset: 0x1215
// Size: 0x48
function function_8ab6741cc3f62007( player, trigger )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    if ( !self.var_8e679412e5091c82 )
    {
        self.var_8e679412e5091c82 = 1;
        musicbank_utility::function_5aca66c390aa347d( self, #"hash_75757f32e5b401ed" );
    }
}

// Namespace zm_sat_scarab_audio
// Params 1, eflags: 0x4
// Checksum 0x1b868538, Offset: 0x1265
// Size: 0x57, Type: bool
function private function_acf41d919395c190( params )
{
    if ( utility::issharedfuncdefined( #"scarab_ee_masks", #"hash_f9027848f45b0e57" ) )
    {
        var_66071b7285da1614 = utility::callsharedfunc( #"scarab_ee_masks", #"hash_f9027848f45b0e57", params );
        
        if ( !var_66071b7285da1614 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace zm_sat_scarab_audio
// Params 1, eflags: 0x4
// Checksum 0xcb6d469c, Offset: 0x12c5
// Size: 0xaa
function private function_b1998e8f0399b9f0( params )
{
    if ( isplayer( self ) && !self.var_aca4ad4088c10c64 && !level namespace_c0b4f2882c9d100f::is_vo_on_cooldown( #"hash_3e2bc609f43c9088" ) )
    {
        player = self;
        player endon( #"disconnect" );
        player.var_aca4ad4088c10c64 = 1;
        wait 1;
        player.var_aca4ad4088c10c64 = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_3e2bc609f43c9088", #"bc_flavor_player_negative" );
        
        if ( player.var_aca4ad4088c10c64 )
        {
            level namespace_c0b4f2882c9d100f::set_vo_on_cooldown( #"hash_3e2bc609f43c9088", 30000 );
        }
    }
}

// Namespace zm_sat_scarab_audio
// Params 1, eflags: 0x4
// Checksum 0x21c7e9f5, Offset: 0x1377
// Size: 0xd6
function private function_531c9606d7ea81e( params )
{
    if ( isplayer( params.target ) && !params.target.var_bbbeef434c13653d && !level namespace_c0b4f2882c9d100f::is_vo_on_cooldown( #"hash_d3dd5e962d7e3fef" ) )
    {
        player = params.target;
        player endon( #"disconnect" );
        player.var_bbbeef434c13653d = 1;
        wait 2;
        
        if ( !isalive( self ) )
        {
            player.var_bbbeef434c13653d = undefined;
            return;
        }
        
        player.var_bbbeef434c13653d = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_d3dd5e962d7e3fef" );
        
        if ( player.var_bbbeef434c13653d )
        {
            level namespace_c0b4f2882c9d100f::set_vo_on_cooldown( #"hash_d3dd5e962d7e3fef", 30000 );
        }
    }
}

// Namespace zm_sat_scarab_audio
// Params 1, eflags: 0x4
// Checksum 0x67816ef8, Offset: 0x1455
// Size: 0xa3
function private function_63159e8f8627b23e( params )
{
    player = self;
    
    if ( isplayer( player ) && !player.var_db07dc03042eda8f && !namespace_c0b4f2882c9d100f::is_vo_on_cooldown( #"hash_d8f5b340de4b28f5" ) )
    {
        player endon( #"disconnect" );
        player.var_db07dc03042eda8f = 1;
        wait 1;
        player.var_db07dc03042eda8f = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"hash_d8f5b340de4b28f5" );
        
        if ( player.var_db07dc03042eda8f )
        {
            level namespace_c0b4f2882c9d100f::set_vo_on_cooldown( #"hash_d8f5b340de4b28f5", 30000 );
        }
    }
}

// Namespace zm_sat_scarab_audio
// Params 2, eflags: 0x4
// Checksum 0x2c77f0be, Offset: 0x1500
// Size: 0x4a, Type: bool
function private function_78073dd15738fe39( attacker, battlechatter )
{
    if ( ( self.subclass == "zombie_loom" || self.subclass == "zombie_loom_minion" ) && attacker namespace_c0b4f2882c9d100f::is_hero_operator() )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_scarab_audio
// Params 1, eflags: 0x4
// Checksum 0x87c6f73d, Offset: 0x1553
// Size: 0x224
function private on_ai_killed( params )
{
    player = params.eattacker;
    
    if ( !isplayer( player ) || !player namespace_c0b4f2882c9d100f::is_hero_operator() )
    {
        return;
    }
    
    player endon( #"disconnect" );
    
    if ( self.subclass == "zombie_loom" && !player.var_56aabcece65c1394[ "zombie_loom" ] )
    {
        str_subclass = "zombie_loom";
        str_vo_kill = #"hash_6e604e871e34ccee";
        var_68749b0b487970a0 = #"hash_5e88a8ab586834d0";
    }
    else if ( self.subclass == "zombie_loom_minion" && !player.var_56aabcece65c1394[ "zombie_loom_minion" ] )
    {
        str_subclass = "zombie_loom_minion";
        str_vo_kill = #"hash_9d79f6d48e3a3ecf";
        var_68749b0b487970a0 = #"hash_fe69b5d5b517e5af";
    }
    
    if ( isdefined( str_subclass ) && isdefined( str_vo_kill ) && isdefined( var_68749b0b487970a0 ) )
    {
        player.var_56aabcece65c1394[ str_subclass ] = 1;
        player val::set( "scarab_first_kill", "allow_battlechatter_vo", 0 );
        wait 1;
        var_db75d3de862ce072 = player_banter::play_banter_vo( str_vo_kill, [ player ] );
        
        if ( var_db75d3de862ce072 )
        {
            a_players_nearby = getplayersinradius( player.origin, 1000, undefined, 1, [ player ] );
            var_39586a35ed6464ee = [];
            
            foreach ( other_player in a_players_nearby )
            {
                if ( namespace_c0b4f2882c9d100f::function_5cf61b74062b7a8b( player, other_player ) )
                {
                    continue;
                }
                
                var_39586a35ed6464ee[ var_39586a35ed6464ee.size ] = other_player;
            }
            
            wait 1;
            player_banter::play_banter_vo( var_68749b0b487970a0, var_39586a35ed6464ee );
        }
        else
        {
            player.var_56aabcece65c1394[ str_subclass ] = undefined;
        }
        
        player val::reset( "scarab_first_kill", "allow_battlechatter_vo" );
    }
}

// Namespace zm_sat_scarab_audio
// Params 0
// Checksum 0x25e4e295, Offset: 0x177f
// Size: 0x75, Type: bool
function function_7606443c19ef441e()
{
    return utility::flag( "end_of_round_vo_playing" ) || utility::flag( "special_round_vo_active" ) || level.var_a009ab14ee0d3223.isspecialround || utility::flag( "scarab_mq_vo_playing" ) || utility::flag( "poi_arrival_vo_playing" ) || level.scarab_phone.var_44a91d6a5c9357f8 || level.var_255753bd26bf0bdd;
}

// Namespace zm_sat_scarab_audio
// Params 0, eflags: 0x4
// Checksum 0xb6db5bff, Offset: 0x17fd
// Size: 0x411
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
    overlord::function_b606cb1cebb2a4f5( "zm_sat_scarab_dialogue_overlord" );
    wait 7;
    level thread function_e46b0c4bd4db88d9();
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
        while ( function_7606443c19ef441e() )
        {
            wait 0.5;
        }
        
        utility::flag_set( "end_of_round_vo_playing" );
        zm_quest::function_d5ef98341fd6a057( [ #"match_start" ] );
        player_banter::play_banter_vo( #"match_start" );
        utility::flag_clear( "end_of_round_vo_playing" );
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
        while ( function_7606443c19ef441e() )
        {
            wait 0.5;
        }
        
        level utility::flag_set( "end_of_round_vo_playing" );
        zm_quest::function_d5ef98341fd6a057( [ #"hash_8686c59aa5a7d204", #"hash_8686c89aa5a7d71d", #"hash_8686c79aa5a7d56a", #"hash_8686c29aa5a7cceb" ] );
        player_banter::play_banter_vo( #"end_of_round_1" );
        level utility::flag_clear( "end_of_round_vo_playing" );
    }
    
    utility::flag_set( "round_1_vo_done" );
    
    if ( n_current_round_vo_index < var_1ac278717413299b )
    {
        level utility::function_3be250f0ba0da4f6( "on_round_end", var_65e988690474ed1 );
    }
    
    var_8d885b4aed0bef01 = zm_utility::get_round_number();
    n_current_round_vo_index = var_8d885b4aed0bef01;
    
    if ( n_current_round_vo_index == var_1ac278717413299b )
    {
        while ( function_7606443c19ef441e() )
        {
            wait 0.5;
        }
        
        level utility::flag_set( "end_of_round_vo_playing" );
        zm_quest::function_d5ef98341fd6a057( [ #"hash_71771a749b594023", #"hash_71771b749b5941d6", #"hash_71771c749b594389", #"hash_71771d749b59453c" ] );
        player_banter::play_banter_vo( #"end_of_round_2" );
        level utility::flag_clear( "end_of_round_vo_playing" );
    }
    
    utility::flag_set( "round_2_vo_done" );
    var_5fae938f7eb75033 = 6;
    var_9b1200395baea90e = n_current_round_vo_index;
    
    while ( true )
    {
        level utility::function_3be250f0ba0da4f6( "on_round_end", var_65e988690474ed1 );
        waitframe();
        
        if ( function_7606443c19ef441e() )
        {
            continue;
        }
        
        if ( namespace_c0b4f2882c9d100f::function_5600317993be908b() == 1 )
        {
            if ( var_9b1200395baea90e > var_5fae938f7eb75033 )
            {
                level utility::flag_set( "solo_scarab_round_vo_done" );
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

// Namespace zm_sat_scarab_audio
// Params 1, eflags: 0x4
// Checksum 0x77313a07, Offset: 0x1c16
// Size: 0xab1
function private function_9e4dcbd2ff52b5ce( var_55f7b3d19fbd8c26 )
{
    if ( !isdefined( var_55f7b3d19fbd8c26 ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_78baa154e8ba6c04[ "weaver_and_grey" ] ) )
    {
        level.var_78baa154e8ba6c04[ "weaver_and_grey" ] = 1;
    }
    
    if ( !isdefined( level.var_78baa154e8ba6c04[ "weaver_and_carver" ] ) )
    {
        level.var_78baa154e8ba6c04[ "weaver_and_carver" ] = 1;
    }
    
    if ( !isdefined( level.var_78baa154e8ba6c04[ "weaver_and_maya" ] ) )
    {
        level.var_78baa154e8ba6c04[ "weaver_and_maya" ] = 1;
    }
    
    if ( !isdefined( level.var_78baa154e8ba6c04[ "grey_and_carver" ] ) )
    {
        level.var_78baa154e8ba6c04[ "grey_and_carver" ] = 1;
    }
    
    if ( !isdefined( level.var_78baa154e8ba6c04[ "grey_and_maya" ] ) )
    {
        level.var_78baa154e8ba6c04[ "grey_and_maya" ] = 1;
    }
    
    if ( !isdefined( level.var_78baa154e8ba6c04[ "carver_and_maya" ] ) )
    {
        level.var_78baa154e8ba6c04[ "carver_and_maya" ] = 1;
    }
    
    if ( !isdefined( level.var_78baa154e8ba6c04[ "richtofen_and_dempsey" ] ) )
    {
        level.var_78baa154e8ba6c04[ "richtofen_and_dempsey" ] = 1;
    }
    
    if ( !isdefined( level.var_78baa154e8ba6c04[ "richtofen_and_takeo" ] ) )
    {
        level.var_78baa154e8ba6c04[ "richtofen_and_takeo" ] = 1;
    }
    
    if ( !isdefined( level.var_78baa154e8ba6c04[ "richtofen_and_nikolai" ] ) )
    {
        level.var_78baa154e8ba6c04[ "richtofen_and_nikolai" ] = 1;
    }
    
    if ( !isdefined( level.var_78baa154e8ba6c04[ "dempsey_and_takeo" ] ) )
    {
        level.var_78baa154e8ba6c04[ "dempsey_and_takeo" ] = 1;
    }
    
    if ( !isdefined( level.var_78baa154e8ba6c04[ "dempsey_and_nikolai" ] ) )
    {
        level.var_78baa154e8ba6c04[ "dempsey_and_nikolai" ] = 1;
    }
    
    if ( !isdefined( level.var_78baa154e8ba6c04[ "takeo_and_nikolai" ] ) )
    {
        level.var_78baa154e8ba6c04[ "takeo_and_nikolai" ] = 1;
    }
    
    if ( !isdefined( level.var_78baa154e8ba6c04[ "weaver_and_richtofen" ] ) )
    {
        level.var_78baa154e8ba6c04[ "weaver_and_richtofen" ] = 1;
    }
    
    if ( !isdefined( level.var_78baa154e8ba6c04[ "weaver_and_dempsey" ] ) )
    {
        level.var_78baa154e8ba6c04[ "weaver_and_dempsey" ] = 1;
    }
    
    if ( !isdefined( level.var_78baa154e8ba6c04[ "weaver_and_takeo" ] ) )
    {
        level.var_78baa154e8ba6c04[ "weaver_and_takeo" ] = 1;
    }
    
    if ( !isdefined( level.var_78baa154e8ba6c04[ "weaver_and_nikolai" ] ) )
    {
        level.var_78baa154e8ba6c04[ "weaver_and_nikolai" ] = 1;
    }
    
    if ( !isdefined( level.var_78baa154e8ba6c04[ "grey_and_richtofen" ] ) )
    {
        level.var_78baa154e8ba6c04[ "grey_and_richtofen" ] = 1;
    }
    
    if ( !isdefined( level.var_78baa154e8ba6c04[ "grey_and_dempsey" ] ) )
    {
        level.var_78baa154e8ba6c04[ "grey_and_dempsey" ] = 1;
    }
    
    if ( !isdefined( level.var_78baa154e8ba6c04[ "grey_and_takeo" ] ) )
    {
        level.var_78baa154e8ba6c04[ "grey_and_takeo" ] = 1;
    }
    
    if ( !isdefined( level.var_78baa154e8ba6c04[ "grey_and_nikolai" ] ) )
    {
        level.var_78baa154e8ba6c04[ "grey_and_nikolai" ] = 1;
    }
    
    if ( !isdefined( level.var_78baa154e8ba6c04[ "carver_and_richtofen" ] ) )
    {
        level.var_78baa154e8ba6c04[ "carver_and_richtofen" ] = 1;
    }
    
    if ( !isdefined( level.var_78baa154e8ba6c04[ "carver_and_dempsey" ] ) )
    {
        level.var_78baa154e8ba6c04[ "carver_and_dempsey" ] = 1;
    }
    
    if ( !isdefined( level.var_78baa154e8ba6c04[ "carver_and_takeo" ] ) )
    {
        level.var_78baa154e8ba6c04[ "carver_and_takeo" ] = 1;
    }
    
    if ( !isdefined( level.var_78baa154e8ba6c04[ "carver_and_nikolai" ] ) )
    {
        level.var_78baa154e8ba6c04[ "carver_and_nikolai" ] = 1;
    }
    
    if ( !isdefined( level.var_78baa154e8ba6c04[ "maya_and_richtofen" ] ) )
    {
        level.var_78baa154e8ba6c04[ "maya_and_richtofen" ] = 1;
    }
    
    if ( !isdefined( level.var_78baa154e8ba6c04[ "maya_and_dempsey" ] ) )
    {
        level.var_78baa154e8ba6c04[ "maya_and_dempsey" ] = 1;
    }
    
    if ( !isdefined( level.var_78baa154e8ba6c04[ "maya_and_takeo" ] ) )
    {
        level.var_78baa154e8ba6c04[ "maya_and_takeo" ] = 1;
    }
    
    if ( !isdefined( level.var_78baa154e8ba6c04[ "maya_and_nikolai" ] ) )
    {
        level.var_78baa154e8ba6c04[ "maya_and_nikolai" ] = 1;
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
        var_fd1b7ff5802cd4e = hashcat( #"hash_878ce778d8cfb22e", str_current_vo_index, "_", level.var_78baa154e8ba6c04[ str_current_vo_index ] );
        
        if ( player_banter::function_59ab3c2fe1424d34( var_fd1b7ff5802cd4e ) )
        {
            b_success = player_banter::play_banter_vo( var_fd1b7ff5802cd4e, var_55f7b3d19fbd8c26.a_players );
            
            if ( b_success )
            {
                level.var_78baa154e8ba6c04[ str_current_vo_index ]++;
            }
        }
    }
}

// Namespace zm_sat_scarab_audio
// Params 1, eflags: 0x4
// Checksum 0x1d31a69f, Offset: 0x26cf
// Size: 0xab
function private function_ef88afc852229531( var_f1fbc291f2430b1e )
{
    foreach ( player in level.players )
    {
        if ( var_f1fbc291f2430b1e )
        {
            player val::reset( "scarab_round_vo", "allow_battlechatter_vo" );
            continue;
        }
        
        player val::set( "scarab_round_vo", "allow_battlechatter_vo", 0 );
    }
}

// Namespace zm_sat_scarab_audio
// Params 0, eflags: 0x4
// Checksum 0x1c10a7e8, Offset: 0x2782
// Size: 0xa0, Type: bool
function private function_509cccd57cd28382()
{
    if ( !isdefined( level.var_78baa154e8ba6c04 ) )
    {
        return false;
    }
    
    foreach ( var_6e6952227869c445 in level.var_78baa154e8ba6c04 )
    {
        if ( var_6e6952227869c445 <= 4 )
        {
            return false;
        }
    }
    
    if ( !level utility::flag( "solo_scarab_round_vo_done" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace zm_sat_scarab_audio
// Params 0, eflags: 0x4
// Checksum 0x71ffd37b, Offset: 0x282b
// Size: 0x58c
function private function_e46b0c4bd4db88d9()
{
    level endon( #"scarab_boss_fight_complete" );
    var_31b31b24d4fa19ff = 1;
    var_63fe7dd9cff50165 = 1;
    var_351d76c23eaf8f93 = 1;
    var_449848e8d7a835cf = 1;
    var_46cedaf8b1ad8dd7 = 1;
    var_a9b4c3e24723a338 = 1;
    var_85cb976f0e490656 = 1;
    var_fe7605497cedad23 = 1;
    n_vo_start_round = 16;
    
    if ( zm_save::function_1dda3554974a999e() )
    {
        n_round_number_check = zm_utility::get_round_number() + 2;
        var_31b31b24d4fa19ff = max( 1, n_round_number_check - n_vo_start_round );
        var_63fe7dd9cff50165 = max( 1, n_round_number_check - n_vo_start_round );
        var_351d76c23eaf8f93 = max( 1, n_round_number_check - n_vo_start_round );
        var_449848e8d7a835cf = max( 1, n_round_number_check - n_vo_start_round );
        var_46cedaf8b1ad8dd7 = max( 1, n_round_number_check - n_vo_start_round );
        var_a9b4c3e24723a338 = max( 1, n_round_number_check - n_vo_start_round );
        var_85cb976f0e490656 = max( 1, n_round_number_check - n_vo_start_round );
        var_fe7605497cedad23 = max( 1, n_round_number_check - n_vo_start_round );
    }
    
    var_824135a6ee782fd = 4;
    var_5bad01955a3cf7b8 = 4;
    var_fcb1e2f9972c3ad3 = 4;
    var_130731ed38b133ef = 4;
    
    while ( true )
    {
        if ( var_31b31b24d4fa19ff > var_824135a6ee782fd && var_63fe7dd9cff50165 > var_824135a6ee782fd && var_351d76c23eaf8f93 > var_5bad01955a3cf7b8 && var_449848e8d7a835cf > var_5bad01955a3cf7b8 && var_46cedaf8b1ad8dd7 > var_fcb1e2f9972c3ad3 && var_a9b4c3e24723a338 > var_fcb1e2f9972c3ad3 && var_85cb976f0e490656 > var_130731ed38b133ef && var_fe7605497cedad23 > var_130731ed38b133ef )
        {
            return;
        }
        
        level utility::function_3be250f0ba0da4f6( "on_round_end", 5 );
        var_8d885b4aed0bef01 = zm_utility::get_round_number();
        
        if ( var_8d885b4aed0bef01 < n_vo_start_round )
        {
            continue;
        }
        
        if ( utility::flag( "scarab_boss_fight_complete" ) )
        {
            return;
        }
        
        var_f43eb6e734c44585 = [];
        
        foreach ( player in level.players )
        {
            if ( isalive( player ) && !player::isinlaststand( player ) && ( player namespace_c0b4f2882c9d100f::is_nikolai() || player namespace_c0b4f2882c9d100f::is_grey() || player namespace_c0b4f2882c9d100f::is_richtofen() || player namespace_c0b4f2882c9d100f::is_weaver() || player namespace_c0b4f2882c9d100f::is_dempsey() || player namespace_c0b4f2882c9d100f::is_maya() || player namespace_c0b4f2882c9d100f::is_takeo() || player namespace_c0b4f2882c9d100f::is_carver() ) )
            {
                if ( player namespace_c0b4f2882c9d100f::is_nikolai() && var_31b31b24d4fa19ff <= var_824135a6ee782fd )
                {
                    var_f43eb6e734c44585[ var_f43eb6e734c44585.size ] = player;
                }
                
                if ( player namespace_c0b4f2882c9d100f::is_grey() && var_63fe7dd9cff50165 <= var_824135a6ee782fd )
                {
                    var_f43eb6e734c44585[ var_f43eb6e734c44585.size ] = player;
                }
                
                if ( player namespace_c0b4f2882c9d100f::is_richtofen() && var_351d76c23eaf8f93 <= var_5bad01955a3cf7b8 )
                {
                    var_f43eb6e734c44585[ var_f43eb6e734c44585.size ] = player;
                }
                
                if ( player namespace_c0b4f2882c9d100f::is_weaver() && var_449848e8d7a835cf <= var_5bad01955a3cf7b8 )
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
                
                if ( player namespace_c0b4f2882c9d100f::is_takeo() && var_85cb976f0e490656 <= var_130731ed38b133ef )
                {
                    var_f43eb6e734c44585[ var_f43eb6e734c44585.size ] = player;
                }
                
                if ( player namespace_c0b4f2882c9d100f::is_carver() && var_fe7605497cedad23 <= var_130731ed38b133ef )
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
        utility::flag_set( "scarab_skip_round_vo" );
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
        else if ( player namespace_c0b4f2882c9d100f::is_richtofen() )
        {
            var_8984c1f1eeea88ec = hashcat( #"hash_514b6a1f51706555", var_351d76c23eaf8f93 );
            
            if ( player_banter::function_59ab3c2fe1424d34( var_8984c1f1eeea88ec ) )
            {
                var_db75d3de862ce072 = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( var_8984c1f1eeea88ec );
                
                if ( var_db75d3de862ce072 )
                {
                    var_351d76c23eaf8f93++;
                }
            }
        }
        else if ( player namespace_c0b4f2882c9d100f::is_weaver() )
        {
            var_8984c1f1eeea88ec = hashcat( #"hash_514b6a1f51706555", var_449848e8d7a835cf );
            
            if ( player_banter::function_59ab3c2fe1424d34( var_8984c1f1eeea88ec ) )
            {
                var_db75d3de862ce072 = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( var_8984c1f1eeea88ec );
                
                if ( var_db75d3de862ce072 )
                {
                    var_449848e8d7a835cf++;
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
        else if ( player namespace_c0b4f2882c9d100f::is_takeo() )
        {
            var_8984c1f1eeea88ec = hashcat( #"hash_af65da792bb63ca6", var_85cb976f0e490656 );
            
            if ( player_banter::function_59ab3c2fe1424d34( var_8984c1f1eeea88ec ) )
            {
                var_db75d3de862ce072 = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( var_8984c1f1eeea88ec );
                
                if ( var_db75d3de862ce072 )
                {
                    var_85cb976f0e490656++;
                }
            }
        }
        else if ( player namespace_c0b4f2882c9d100f::is_carver() )
        {
            var_8984c1f1eeea88ec = hashcat( #"hash_af65da792bb63ca6", var_fe7605497cedad23 );
            
            if ( player_banter::function_59ab3c2fe1424d34( var_8984c1f1eeea88ec ) )
            {
                var_db75d3de862ce072 = player namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( var_8984c1f1eeea88ec );
                
                if ( var_db75d3de862ce072 )
                {
                    var_fe7605497cedad23++;
                }
            }
        }
        
        utility::flag_clear( "scarab_skip_round_vo" );
    }
}

