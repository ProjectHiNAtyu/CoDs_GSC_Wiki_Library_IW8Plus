// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_weather_sakura.gsc  (hash_63035c972ced674c.gscc) (size: 13340 Bytes / 0x341c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x55bdf7f7 (1438513143)
// size ...... 13340 (0x341c)
// includes .. 13  (offset: 0x30c0)
// strings ... 31  (offset: 0x3128)
// dev strs .. 22  (offset: 0x3314)
// exports ... 41  (offset: 0x1c8c)
// cseg ...... 0x266 + 0x1a26 (0x1c8c)
// imports ... 117 (offset: 0x22f4)
// animtree1 . 0   (offset: 0x341c)
// animtree2 . 0   (offset: 0x341c)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\health_overcharge;
#using scripts\mp\playerhealth;
#using scripts\mp\weapons;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_weather_create_script;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_logic;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\zm_player;

#namespace zm_sat_hornet_weather_sakura;

// Namespace zm_sat_hornet_weather_sakura
// Params 0, eflags: 0x5
// Checksum 0xfc967167, Offset: 0x284
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"weather_sakura", undefined, &function_7cf8dacb278a2665, &postmain_init );
}

// Namespace zm_sat_hornet_weather_sakura
// Params 0, eflags: 0x4
// Checksum 0xe0bc7a06, Offset: 0x2a9
// Size: 0x3b
function private function_7cf8dacb278a2665()
{
    if ( getdvarint( @"disable_sakura", 0 ) || getdvarint( @"hash_169846c664077bf", 0 ) || getdvarint( @"zombie_cheat", 0 ) == 2 )
    {
        return;
    }
}

// Namespace zm_sat_hornet_weather_sakura
// Params 0, eflags: 0x4
// Checksum 0x3511cca6, Offset: 0x2ec
// Size: 0x9a
function private postmain_init()
{
    if ( getdvarint( @"disable_sakura", 0 ) || getdvarint( @"hash_169846c664077bf", 0 ) || getdvarint( @"zombie_cheat", 0 ) == 2 )
    {
        return;
    }
    
    zm_sat_hornet_weather_create_script::main();
    level.sakura_root = spawnstruct();
    level.sakura_root.all_trees = [];
    level.sakura_root.var_c7cc42d5608bad9d = [];
    level thread sort_sakura_trees();
    level thread function_2a0bbd44df901014();
    setup_direct_activations();
    
    /#
        function_a33c695b439b726c();
    #/
}

// Namespace zm_sat_hornet_weather_sakura
// Params 0, eflags: 0x4
// Checksum 0x18f0f255, Offset: 0x38e
// Size: 0x129
function private sort_sakura_trees()
{
    level endon( #"game_ended" );
    level utility::flag_wait( "scriptables_ready" );
    sakura_trees = getentitylessscriptablearray( "sakura_trees", #target );
    
    foreach ( tree in sakura_trees )
    {
        level.sakura_root.all_trees[ tree.targetname ] = tree;
        level.sakura_root.var_c7cc42d5608bad9d[ level.sakura_root.var_c7cc42d5608bad9d.size ] = tree.targetname;
        tree.trigger = spawn( "noent_volume_trigger_rotatable_radius", tree.origin, 0, 256, 128 );
    }
    
    level utility::flag_set( "skr_init" );
}

// Namespace zm_sat_hornet_weather_sakura
// Params 0, eflags: 0x4
// Checksum 0x7bbc3b68, Offset: 0x4bf
// Size: 0xda
function private function_2a0bbd44df901014()
{
    level endon( #"game_ended" );
    var_e4e07a30d1bad16 = randomintrange( 3, 5 );
    var_33741d157cfa28d8 = zm_round_logic::get_rb_round_number() + var_e4e07a30d1bad16;
    level utility::flag_wait( "map_features_can_be_reloaded" );
    saved_target_round = level zm_quest::function_73720cdf21c3cfd7( #"hash_5d06d71de9a9208e", #"hash_4fb1985cd0a61874" );
    
    if ( saved_target_round )
    {
        var_33741d157cfa28d8 = saved_target_round;
    }
    
    while ( true )
    {
        level waittill( #"on_round_start" );
        function_d25683bd062edbc();
        current_round = zm_round_logic::get_rb_round_number();
        
        if ( current_round >= var_33741d157cfa28d8 )
        {
            level thread function_cfe633a86ce5b3c9();
            var_e4e07a30d1bad16 = randomintrange( 3, 5 );
            var_33741d157cfa28d8 = zm_round_logic::get_rb_round_number() + var_e4e07a30d1bad16;
            level zm_quest::function_4eefe6de31f5ddab( #"hash_5d06d71de9a9208e", #"hash_4fb1985cd0a61874", var_33741d157cfa28d8 );
        }
    }
}

// Namespace zm_sat_hornet_weather_sakura
// Params 0, eflags: 0x4
// Checksum 0xe7c6a7cc, Offset: 0x5a1
// Size: 0xe
function private setup_direct_activations()
{
    scriptable::scriptable_adddamagedcallback( &function_e7ea3521221b06ca );
}

// Namespace zm_sat_hornet_weather_sakura
// Params 0, eflags: 0x4
// Checksum 0xb18ec201, Offset: 0x5b7
// Size: 0x1e
function private function_d25683bd062edbc()
{
    if ( level utility::flag( "pause_ambient_sakura" ) )
    {
        level utility::flag_waitopen( "pause_ambient_sakura" );
    }
}

// Namespace zm_sat_hornet_weather_sakura
// Params 0, eflags: 0x4
// Checksum 0x9dfe7b6f, Offset: 0x5dd
// Size: 0x89
function private function_cfe633a86ce5b3c9()
{
    level endon( #"game_ended" );
    tree = select_tree();
    
    if ( !isdefined( tree ) )
    {
        return;
    }
    
    tree utility::function_32b24db3127bff40( "fx", "glow" );
    level waittill( #"on_round_start" );
    level.var_ce1470413371c515 = tree;
    function_22eca0725ac2fdf7( tree );
    tree endon( #"skr_ended" );
    level waittill( #"on_round_end" );
    level.var_ce1470413371c515 = undefined;
    function_a50dd195493a814a( tree );
}

// Namespace zm_sat_hornet_weather_sakura
// Params 0
// Checksum 0xd3ea8076, Offset: 0x66e
// Size: 0xd8
function select_tree()
{
    if ( level.sakura_root.var_c7cc42d5608bad9d.size > 0 )
    {
        var_d8a65f11e2fac1f3 = arrayrandomize( level.sakura_root.var_c7cc42d5608bad9d );
        
        foreach ( tree_name in var_d8a65f11e2fac1f3 )
        {
            tree = level.sakura_root.all_trees[ tree_name ];
            
            if ( !tree.var_df00f5fbf4a6d195 )
            {
                return tree;
            }
        }
        
        return;
    }
}

// Namespace zm_sat_hornet_weather_sakura
// Params 11, eflags: 0x4
// Checksum 0xb2454b58, Offset: 0x74f
// Size: 0x1a9
function private function_e7ea3521221b06ca( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( isdefined( instance.type ) && getxhashasset( instance.type ) != %"hash_794d3eeb87f96e31" )
    {
        return;
    }
    
    if ( instance.var_df00f5fbf4a6d195 )
    {
        return;
    }
    
    if ( instance.var_c50f749e8cfd5137 && !level.active_relic_challenge.overheal_kills )
    {
        return;
    }
    
    tree = instance;
    
    if ( tree && tree.var_93d1cc32428929a7 )
    {
        return;
    }
    
    if ( zm_player::function_f37cfdf04b932a03( eattacker ) )
    {
        b_is_valid_damage = utility::ismeleedamage( smeansofdeath );
        
        if ( !b_is_valid_damage )
        {
            return;
        }
        
        var_147968fad16d05fd = eattacker utility::ent_flag( "perk_m_mod_active" );
        var_c32b6fdf4100a72c = function_ad23e99dcf768f2c( instance, var_147968fad16d05fd );
        eattacker playrumbleonentity( "damage_heavy" );
        eattacker earthquakeforplayer( 0.25, 0.5, eattacker.origin, 64 );
        
        if ( var_c32b6fdf4100a72c )
        {
            if ( !eattacker.var_4cf61c6a6c695c85 )
            {
                eattacker thread function_f722971dddd26320();
            }
            else if ( randomfloat( 1 ) <= 0.2 )
            {
                eattacker thread function_f722971dddd26320();
            }
            
            level thread function_fe9257e1e6a56bd5( tree );
        }
    }
}

// Namespace zm_sat_hornet_weather_sakura
// Params 0, eflags: 0x4
// Checksum 0xace84a3b, Offset: 0x900
// Size: 0x2d
function private function_f722971dddd26320()
{
    self endon( #"death_or_disconnect" );
    self.var_4cf61c6a6c695c85 = gettime();
    wait 0.5;
    namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( "hornet_cherry_blossom_activate" );
}

// Namespace zm_sat_hornet_weather_sakura
// Params 2, eflags: 0x4
// Checksum 0x66cb2d1d, Offset: 0x935
// Size: 0x1af, Type: bool
function private function_ad23e99dcf768f2c( tree, var_147968fad16d05fd )
{
    if ( !isdefined( tree ) )
    {
        return false;
    }
    
    if ( tree && !isdefined( tree.var_18d464dba2437dcd ) )
    {
        if ( !isdefined( tree.var_18d464dba2437dcd ) )
        {
            tree.var_18d464dba2437dcd = function_d1eecaa9709f3341( 5 );
        }
        
        tree.n_hit_index = 0;
        
        if ( !isdefined( tree.var_d57e453bdd3f3904 ) )
        {
            tree.var_d57e453bdd3f3904 = function_d1eecaa9709f3341( 3 );
        }
        
        tree.var_b8ce98b3d9b70468 = 0;
    }
    
    if ( !isdefined( tree.last_ts ) )
    {
        tree.last_ts = 0;
    }
    
    if ( utility::time_has_passed( tree.last_ts, 0.1 ) )
    {
        tree.last_ts = gettime();
        index = tree.n_hit_index % tree.var_18d464dba2437dcd.size;
        tree.var_18d464dba2437dcd[ index ] = tree.last_ts;
        tree.n_hit_index++;
        
        if ( var_147968fad16d05fd )
        {
            index_mm = tree.var_b8ce98b3d9b70468 % tree.var_d57e453bdd3f3904.size;
            tree.var_d57e453bdd3f3904[ index_mm ] = tree.last_ts;
            tree.var_b8ce98b3d9b70468++;
        }
    }
    
    var_64edfb45265db366 = utility::time_has_passed_array( tree.var_18d464dba2437dcd, 6 );
    var_453d2dfc5134b297 = utility::time_has_passed_array( tree.var_d57e453bdd3f3904, 6 );
    return var_64edfb45265db366 || var_453d2dfc5134b297;
}

// Namespace zm_sat_hornet_weather_sakura
// Params 2, eflags: 0x4
// Checksum 0x68d7b616, Offset: 0xaed
// Size: 0x4b
function private function_d1eecaa9709f3341( len, default_value = 0 )
{
    array = [];
    
    for ( i = 0; i < len ; i++ )
    {
        array[ array.size ] = default_value;
    }
    
    return array;
}

// Namespace zm_sat_hornet_weather_sakura
// Params 1, eflags: 0x4
// Checksum 0xd495cda1, Offset: 0xb41
// Size: 0xce
function private function_fe9257e1e6a56bd5( tree )
{
    level endon( #"game_ended" );
    tree.var_c50f749e8cfd5137 = 1;
    tree.var_68afa6162a7e92b = 1;
    level.sakura_root.var_c7cc42d5608bad9d = arrayremove( level.sakura_root.var_c7cc42d5608bad9d, tree.targetname );
    function_22eca0725ac2fdf7( tree );
    
    if ( !level.active_relic_challenge.overheal_kills )
    {
        level thread function_a60101f09b862d3e( tree );
    }
    else
    {
        level thread function_9c0339de159ec0e4( tree );
    }
    
    if ( !level.active_relic_challenge.overheal_kills )
    {
        level waittill( #"on_round_end" );
    }
    
    function_a50dd195493a814a( tree );
}

// Namespace zm_sat_hornet_weather_sakura
// Params 1, eflags: 0x4
// Checksum 0x52a5aed0, Offset: 0xc17
// Size: 0x92
function private function_a60101f09b862d3e( tree )
{
    level endon( #"game_ended" );
    
    for ( i = 0; i < 8 ; i++ )
    {
        level waittill( #"on_round_end" );
    }
    
    tree.var_c50f749e8cfd5137 = undefined;
    level.sakura_root.var_c7cc42d5608bad9d[ level.sakura_root.var_c7cc42d5608bad9d.size ] = tree.targetname;
    tree utility::function_32b24db3127bff40( "model", "flowers" );
}

// Namespace zm_sat_hornet_weather_sakura
// Params 1, eflags: 0x4
// Checksum 0x8e14354f, Offset: 0xcb1
// Size: 0x7a
function private function_9c0339de159ec0e4( tree )
{
    level endon( #"game_ended" );
    wait 300;
    level notify( #"hash_fafdd6abbb4d5ce2" );
    tree.var_c50f749e8cfd5137 = undefined;
    level.sakura_root.var_c7cc42d5608bad9d[ level.sakura_root.var_c7cc42d5608bad9d.size ] = tree.targetname;
    tree utility::function_32b24db3127bff40( "model", "flowers" );
}

// Namespace zm_sat_hornet_weather_sakura
// Params 1
// Checksum 0x7652a26, Offset: 0xd33
// Size: 0xba
function function_22eca0725ac2fdf7( tree )
{
    tree utility::function_32b24db3127bff40( "fx", "flower" );
    tree.trigger.a_players_inside = [];
    tree.var_f9c4bc2852ff92b6 = 0;
    tree.var_93d1cc32428929a7 = 1;
    playrumbleonposition( "ground_pound_land", tree.origin );
    earthquake( 0.4, 2.5, tree.origin, 256 );
    params = spawnstruct();
    params.tree = tree;
    level callback::callback( "tree_storm_started", params );
    level thread function_7eefb61bd74c3851( tree );
}

// Namespace zm_sat_hornet_weather_sakura
// Params 1
// Checksum 0xbb9c43a7, Offset: 0xdf5
// Size: 0xca
function function_a50dd195493a814a( tree )
{
    if ( level.active_relic_challenge.overheal_kills )
    {
        level waittill( #"hash_fafdd6abbb4d5ce2" );
    }
    
    tree utility::function_32b24db3127bff40( "fx", "none" );
    
    if ( tree.var_68afa6162a7e92b )
    {
        tree utility::function_32b24db3127bff40( "model", "bare" );
    }
    
    tree.var_68afa6162a7e92b = undefined;
    tree.var_93d1cc32428929a7 = undefined;
    tree.trigger.a_players_inside = [];
    params = spawnstruct();
    params.tree = tree;
    level callback::callback( "tree_storm_ended", params );
    tree notify( #"skr_ended" );
}

// Namespace zm_sat_hornet_weather_sakura
// Params 1, eflags: 0x4
// Checksum 0x49e44b01, Offset: 0xec7
// Size: 0xd7
function private function_7eefb61bd74c3851( tree )
{
    tree endon( #"skr_ended" );
    
    while ( true )
    {
        tree.trigger waittill( #"trigger", ent );
        
        if ( zm_player::function_f37cfdf04b932a03( ent ) && !arraycontains( tree.trigger.a_players_inside, ent ) )
        {
            if ( !isdefined( tree.trigger.a_players_inside ) )
            {
                tree.trigger.a_players_inside = [];
            }
            
            tree.trigger.a_players_inside[ tree.trigger.a_players_inside.size ] = ent;
            ent thread function_c18dde29edd4224d( tree );
        }
    }
}

// Namespace zm_sat_hornet_weather_sakura
// Params 1, eflags: 0x4
// Checksum 0x491cea4e, Offset: 0xfa6
// Size: 0x156
function private function_c18dde29edd4224d( tree )
{
    tree endon( #"skr_ended" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        wait 3;
        
        if ( !self istouching( tree.trigger ) )
        {
            tree.trigger.a_players_inside = arrayremove( tree.trigger.a_players_inside, self );
            return;
        }
        
        if ( !zm_player::function_f37cfdf04b932a03( self ) )
        {
            continue;
        }
        
        b_health_healed = function_d5e802825e7bdb13( self );
        
        if ( b_health_healed )
        {
            if ( !self.var_c044ac0e3ea91b47 && ( !self.var_4cf61c6a6c695c85 || utility::time_has_passed( self.var_4cf61c6a6c695c85, 120 ) ) )
            {
                self.var_c044ac0e3ea91b47 = 1;
                wait 0.5;
                thread namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( "hornet_cherry_blossoms_heal_first_time", #"bc_flavor_player_positive" );
            }
            
            if ( !utility::ent_flag( "skr_buff" ) && health_overcharge::function_1c546d630583f860() )
            {
                function_58ae9dc00c98567b();
            }
            
            tree.var_f9c4bc2852ff92b6 += 10;
            heal_cap = function_8653ceb00debc007();
            
            if ( tree.var_f9c4bc2852ff92b6 >= heal_cap )
            {
                level thread function_a50dd195493a814a( tree );
            }
        }
    }
}

// Namespace zm_sat_hornet_weather_sakura
// Params 0, eflags: 0x4
// Checksum 0x6421d10a, Offset: 0x1104
// Size: 0x5e
function private function_8653ceb00debc007()
{
    switch ( level.players.size )
    {
        case 1:
            return 180;
        case 2:
            return 240;
        case 3:
            return 300;
        case 4:
        default:
            return 360;
    }
}

// Namespace zm_sat_hornet_weather_sakura
// Params 1, eflags: 0x4
// Checksum 0x6d1c1904, Offset: 0x116a
// Size: 0x1d, Type: bool
function private function_d5e802825e7bdb13( player )
{
    return health_overcharge::function_f6da758a8ee4c988( player, "near_skr", 10, 100 );
}

// Namespace zm_sat_hornet_weather_sakura
// Params 1
// Checksum 0xaefca05c, Offset: 0x1190
// Size: 0x51
function function_9af3e00cc4771e5( player )
{
    if ( !zm_player::function_f37cfdf04b932a03( player ) )
    {
        return;
    }
    
    health_overcharge::function_f6da758a8ee4c988( player, "near_skr", 100, 100 );
    
    if ( !player utility::ent_flag( "skr_buff" ) && player health_overcharge::function_1c546d630583f860() )
    {
        player function_58ae9dc00c98567b();
    }
}

// Namespace zm_sat_hornet_weather_sakura
// Params 0, eflags: 0x4
// Checksum 0x51cf9dc6, Offset: 0x11e9
// Size: 0x51
function private function_58ae9dc00c98567b()
{
    utility::function_7c10ea82c1e305b8( "hornet_cb_vfx", "on" );
    utility::ent_flag_set( "skr_buff" );
    pbgpostfxbundlestart( self, %"hash_25668659f5362a0b" );
    thread function_1da79671af72e05c();
    thread function_ea401eb2f773f300();
    thread function_bd2838d8e2df21d1();
    thread function_acf459b0d117a3a5();
    thread function_98911add19a37923();
}

// Namespace zm_sat_hornet_weather_sakura
// Params 0, eflags: 0x4
// Checksum 0x87214fc4, Offset: 0x1242
// Size: 0x5b
function private function_8075ba3d732a1cc2()
{
    if ( isdefined( self ) && zm_player::function_f37cfdf04b932a03( self ) )
    {
        utility::function_7c10ea82c1e305b8( "hornet_cb_vfx", "off" );
        utility::ent_flag_clear( "skr_buff" );
        pbgpostfxbundleend( self, %"hash_25668659f5362a0b" );
    }
    
    if ( isdefined( self.sakura_storm ) )
    {
        function_e2ba9dcecfff38fb( self.sakura_storm );
    }
}

// Namespace zm_sat_hornet_weather_sakura
// Params 0, eflags: 0x4
// Checksum 0x306d6e11, Offset: 0x12a5
// Size: 0x22
function private function_1da79671af72e05c()
{
    self endon( #"death_or_disconnect" );
    self waittill( #"overcharge_depleted" );
    function_8075ba3d732a1cc2();
}

// Namespace zm_sat_hornet_weather_sakura
// Params 0, eflags: 0x4
// Checksum 0x696a5380, Offset: 0x12cf
// Size: 0x59
function private function_bd2838d8e2df21d1()
{
    self endon( #"overcharge_depleted" );
    self waittill( #"death_or_disconnect" );
    
    if ( isdefined( self ) )
    {
        self setscriptablepartstate( "hornet_cb_vfx", "off" );
        utility::ent_flag_clear( "skr_buff" );
    }
    
    if ( isdefined( self.sakura_storm ) )
    {
        function_e2ba9dcecfff38fb( self.sakura_storm );
    }
}

// Namespace zm_sat_hornet_weather_sakura
// Params 0, eflags: 0x4
// Checksum 0x60c6a9ac, Offset: 0x1330
// Size: 0x186
function private function_ea401eb2f773f300()
{
    self endon( #"death_or_disconnect" );
    self endon( #"overcharge_depleted" );
    var_5f4dc79fcc67d4a1 = 0.25;
    storm_triggered_cooldown = 30;
    tolerance = 35;
    min_radius = 50;
    max_radius = 125;
    capacity = 10;
    self.locs_queue = utility::queue_create( capacity );
    
    while ( true )
    {
        if ( self.ismutantinjection || self.isjuggernaut || self getvelocity() == 0 )
        {
            utility::queue_clear( self.locs_queue );
            wait var_5f4dc79fcc67d4a1;
            continue;
        }
        
        if ( utility::queue_isfull( self.locs_queue ) )
        {
            self.locs_queue = utility::queue_dequeue( self.locs_queue );
        }
        
        self.locs_queue = utility::queue_enqueue( self.locs_queue, self.origin );
        
        if ( utility::queue_size( self.locs_queue ) == capacity )
        {
            var_41b3267691119295 = utility::function_30510fa2d89a52aa( self.locs_queue.array, tolerance, min_radius, max_radius );
            
            if ( var_41b3267691119295 )
            {
                var_bca6ae732cfcc961 = averagepoint( self.locs_queue.array );
                function_820061505bc97530( var_bca6ae732cfcc961 );
                wait storm_triggered_cooldown;
                utility::queue_clear( self.locs_queue );
            }
        }
        
        wait var_5f4dc79fcc67d4a1;
    }
}

// Namespace zm_sat_hornet_weather_sakura
// Params 0, eflags: 0x4
// Checksum 0xc2af7b6a, Offset: 0x14be
// Size: 0x59
function private function_98911add19a37923()
{
    self endon( #"death_or_disconnect" );
    self endon( #"overcharge_depleted" );
    
    while ( true )
    {
        self waittill( #"weapon_inspect" );
        
        while ( self function_985124b0e1e74f2e() )
        {
            waitframe();
        }
        
        if ( utility::ent_flag( "skr_buff" ) )
        {
            self setscriptablepartstate( "hornet_cb_vfx", "on" );
        }
    }
}

// Namespace zm_sat_hornet_weather_sakura
// Params 0, eflags: 0x4
// Checksum 0x22cca1, Offset: 0x151f
// Size: 0x4d
function private function_acf459b0d117a3a5()
{
    self endon( #"death_or_disconnect" );
    self endon( #"overcharge_depleted" );
    
    while ( true )
    {
        self waittill( #"returned_to_human" );
        
        if ( utility::ent_flag( "skr_buff" ) )
        {
            self setscriptablepartstate( "hornet_cb_vfx", "on" );
        }
    }
}

// Namespace zm_sat_hornet_weather_sakura
// Params 1
// Checksum 0xc4735c78, Offset: 0x1574
// Size: 0x124
function function_820061505bc97530( position )
{
    if ( isdefined( self.sakura_storm ) )
    {
        function_e2ba9dcecfff38fb( self.sakura_storm );
    }
    
    self.sakura_storm = spawnscriptable( %"hash_3fdb6f38ae2bf788", position );
    self.sakura_storm setscriptablepartstate( "fx", "tornado" );
    self.sakura_storm.spawn_time = gettime();
    self.sakura_storm.trigger = spawn( "noent_volume_trigger_rotatable_radius", position, 0, 32, 128 );
    playrumbleonposition( "ground_pound_land", position );
    earthquake( 0.3, 1.5, position, 128 );
    params = spawnstruct();
    params.player = self;
    params.position = position;
    level thread callback::callback( "cb_storm_spawned", params );
    thread function_220984d26ac7a979( self.sakura_storm );
    params = { #player:self, #position:position };
    level notify( #"hash_d418716213427ca5", params );
}

// Namespace zm_sat_hornet_weather_sakura
// Params 1
// Checksum 0xe41a954b, Offset: 0x16a0
// Size: 0x9c
function function_e2ba9dcecfff38fb( storm )
{
    level endon( #"game_ended" );
    
    if ( isdefined( storm.spawn_time ) && !utility::time_has_passed( storm.spawn_time, 1 ) )
    {
        wait 0.5;
    }
    
    if ( storm.trigger )
    {
        storm.trigger delete();
    }
    
    if ( storm )
    {
        storm setscriptablepartstate( "fx", "out" );
    }
    
    wait 0.5;
    
    if ( storm )
    {
        storm freescriptable();
    }
    
    if ( self )
    {
        self.sakura_storm = undefined;
    }
}

// Namespace zm_sat_hornet_weather_sakura
// Params 1, eflags: 0x4
// Checksum 0xb633280e, Offset: 0x1744
// Size: 0x79
function private function_220984d26ac7a979( storm )
{
    self endon( #"death_or_disconnect" );
    self endon( #"overcharge_depleted" );
    
    while ( true )
    {
        storm.trigger waittill( #"trigger", ent );
        
        if ( zm_player::function_f37cfdf04b932a03( ent ) )
        {
            playerhealth::forcehealthregen( ent, 0, 1.5 );
            thread function_e071d361ee00cf80();
            function_e2ba9dcecfff38fb( storm );
        }
    }
}

// Namespace zm_sat_hornet_weather_sakura
// Params 0, eflags: 0x4
// Checksum 0xef360412, Offset: 0x17c5
// Size: 0xba
function private function_e071d361ee00cf80()
{
    self endon( #"death_or_disconnect" );
    self playrumblelooponentity( "low_highfreq" );
    self setscriptablepartstate( "hornet_cb_boost_vfx", "on" );
    weapons::addextramovespeed( "skr_boost", 0.5 );
    weapons::updatemovespeedscale();
    var_dc58879cfee40e71 = 5;
    
    if ( self.var_578f66e52894da77 )
    {
        var_dc58879cfee40e71 *= level.ee_roll.var_fada4ab6d64960f1;
    }
    
    wait var_dc58879cfee40e71;
    self stoprumble( "low_highfreq" );
    self setscriptablepartstate( "hornet_cb_boost_vfx", "off" );
    
    if ( isdefined( self.var_2d0e74f429afe5a0[ "skr_boost" ] ) )
    {
        weapons::removeextramovespeed( "skr_boost" );
        weapons::updatemovespeedscale();
    }
}

/#

    // Namespace zm_sat_hornet_weather_sakura
    // Params 0, eflags: 0x4
    // Checksum 0x9da5523d, Offset: 0x1887
    // Size: 0x90, Type: dev
    function private function_a33c695b439b726c()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x3e>", "<dev string:x52>", &function_cfd991e32f7ed73, 1 );
        devgui::add_devgui_func( "<dev string:x61>", "<dev string:x6d>", &function_bbf8382339efbf33, 1 );
        devgui::add_devgui_func( "<dev string:x76>", "<dev string:x83>", &function_52c5ba786a67ec77, 1 );
        devgui::add_devgui_func( "<dev string:x8d>", "<dev string:x9c>", &function_3eebfd48bce31d9a, 1 );
        devgui::add_devgui_func( "<dev string:xa7>", "<dev string:xb5>", &function_a29913e89b805c0e, 1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace zm_sat_hornet_weather_sakura
    // Params 0, eflags: 0x4
    // Checksum 0xfc861f98, Offset: 0x191f
    // Size: 0x45, Type: dev
    function private function_cfd991e32f7ed73()
    {
        player = level.players[ 0 ];
        
        if ( player utility::ent_flag( "<dev string:xbf>" ) )
        {
            player notify( #"overcharge_depleted" );
            return;
        }
        
        player function_58ae9dc00c98567b();
    }

    // Namespace zm_sat_hornet_weather_sakura
    // Params 0, eflags: 0x4
    // Checksum 0xece3cbfd, Offset: 0x196c
    // Size: 0x88, Type: dev
    function private function_bbf8382339efbf33()
    {
        foreach ( tree in level.sakura_root.all_trees )
        {
            function_22eca0725ac2fdf7( tree );
        }
    }

    // Namespace zm_sat_hornet_weather_sakura
    // Params 0, eflags: 0x4
    // Checksum 0xb9f618fa, Offset: 0x19fc
    // Size: 0x88, Type: dev
    function private function_52c5ba786a67ec77()
    {
        foreach ( tree in level.sakura_root.all_trees )
        {
            function_a50dd195493a814a( tree );
        }
    }

    // Namespace zm_sat_hornet_weather_sakura
    // Params 0, eflags: 0x4
    // Checksum 0x3519dea4, Offset: 0x1a8c
    // Size: 0xfc, Type: dev
    function private function_3eebfd48bce31d9a()
    {
        state = "<dev string:xc8>";
        
        if ( !level.sakura_root.b_toggle_glow )
        {
            level.ar_root.b_toggle_glow = 1;
            iprintlnbold( "<dev string:xcd>" );
        }
        else
        {
            level.ar_root.b_toggle_glow = undefined;
            state = "<dev string:xda>";
            iprintlnbold( "<dev string:xdf>" );
        }
        
        foreach ( tree in level.sakura_root.all_trees )
        {
            tree utility::function_32b24db3127bff40( "<dev string:xed>", state );
        }
    }

    // Namespace zm_sat_hornet_weather_sakura
    // Params 0, eflags: 0x4
    // Checksum 0x29c3541a, Offset: 0x1b90
    // Size: 0xfc, Type: dev
    function private function_a29913e89b805c0e()
    {
        state = "<dev string:xf0>";
        
        if ( !level.sakura_root.var_5c56f0dcaa5102a5 )
        {
            level.sakura_root.var_5c56f0dcaa5102a5 = 1;
            iprintlnbold( "<dev string:xf5>" );
        }
        else
        {
            level.sakura_root.var_5c56f0dcaa5102a5 = undefined;
            state = "<dev string:x100>";
            iprintlnbold( "<dev string:x108>" );
        }
        
        foreach ( tree in level.sakura_root.all_trees )
        {
            tree utility::function_32b24db3127bff40( "<dev string:x112>", state );
        }
    }

#/
