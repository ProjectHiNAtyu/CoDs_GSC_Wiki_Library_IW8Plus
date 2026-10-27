// scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_ee_kodomo.gsc  (hash_54962d59583c087a.gscc) (size: 5428 Bytes / 0x1534 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9bc3ae76 (2613292662)
// size ...... 5428 (0x1534)
// includes .. 11  (offset: 0x13d4)
// strings ... 19  (offset: 0x142c)
// dev strs .. 0   (offset: 0x1534)
// exports ... 15  (offset: 0xb2c)
// cseg ...... 0x178 + 0x9b4 (0xb2c)
// imports ... 55  (offset: 0xd84)
// animtree1 . 0   (offset: 0x1534)
// animtree2 . 0   (offset: 0x1534)
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\musicbank_utility;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_assault_rounds;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_ee_kodomo_cs;
#using scripts\mp\zm\maps\zm_sat_hornet\zm_sat_hornet_weather_ash;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\zm_player;

#namespace zm_sat_hornet_ee_kodomo;

// Namespace zm_sat_hornet_ee_kodomo
// Params 0, eflags: 0x5
// Checksum 0x88a1f481, Offset: 0x196
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"zm_sat_hornet_ee_kodomo", undefined, &function_7cf8dacb278a2665, &postmain_init );
}

// Namespace zm_sat_hornet_ee_kodomo
// Params 0, eflags: 0x4
// Checksum 0xcdaadedb, Offset: 0x1bb
// Size: 0x2
function private function_7cf8dacb278a2665()
{
    
}

// Namespace zm_sat_hornet_ee_kodomo
// Params 0, eflags: 0x4
// Checksum 0x490000d9, Offset: 0x1c5
// Size: 0xa5
function private postmain_init()
{
    if ( !getdvarint( @"enable_hornet_sq", 0 ) || !getdvarint( @"hash_fbb239063c7dae31", 1 ) )
    {
        return;
    }
    
    zm_sat_hornet_ee_kodomo_cs::main();
    level utility::flag_wait( "zm_quest_initialized" );
    level.ee_kodomo = zm_quest::get_quest( #"hornet_ee_kodomo" );
    utility::flag_init( "kodomo_triggered" );
    zm_quest::register_quest_step( #"hornet_ee_kodomo", #"hash_1b6c06502f264ada", &setup_serene_step, &cleanup_serene_step );
    level zm_save::function_1f44a48caae2acbf();
    level.ee_kodomo thread zm_quest::start_quest( #"hornet_ee_kodomo" );
}

// Namespace zm_sat_hornet_ee_kodomo
// Params 2, eflags: 0x4
// Checksum 0xcb347ccd, Offset: 0x272
// Size: 0x4f
function private setup_serene_step( b_skipped, b_save_restored )
{
    if ( !b_save_restored )
    {
        level.ee_kodomo.var_212d2fa4cbff80d = utility::getstruct( "tk_toy_ken" );
        level thread function_b27eb0849899a482();
        level utility::flag_wait( "kodomo_triggered" );
    }
}

// Namespace zm_sat_hornet_ee_kodomo
// Params 2, eflags: 0x4
// Checksum 0xe43c7415, Offset: 0x2c9
// Size: 0x22
function private cleanup_serene_step( b_skipped, b_save_restored )
{
    level utility::flag_set( "kodomo_triggered" );
}

// Namespace zm_sat_hornet_ee_kodomo
// Params 0, eflags: 0x4
// Checksum 0x8d5f3b4a, Offset: 0x2f3
// Size: 0xd9
function private function_b27eb0849899a482()
{
    level endon( #"game_ended" );
    level endon( #"hash_2ed4f8403a39da7c" );
    trig = getnoentvolumearray( "tk_trig_area_ken", #targetname )[ 0 ];
    level.ee_kodomo.start_trig = trig;
    
    while ( true )
    {
        trig waittill( #"trigger", player );
        
        if ( !zm_player::function_f37cfdf04b932a03( player ) || player.var_e81005ef731582b2 || !utility::function_af749a6c1f8241f0( player, level.ee_kodomo.var_212d2fa4cbff80d.origin, 20 ) )
        {
            continue;
        }
        
        if ( !player.var_e81005ef731582b2 )
        {
            player thread function_102900b9f9e1ecc8( trig );
        }
        
        wait 0.1;
    }
}

// Namespace zm_sat_hornet_ee_kodomo
// Params 1, eflags: 0x4
// Checksum 0x6670b86f, Offset: 0x3d4
// Size: 0x114
function private function_102900b9f9e1ecc8( trig )
{
    self endon( #"death_or_disconnect" );
    level endon( #"hash_2ed4f8403a39da7c" );
    var_228f5b38a069a713 = gettime();
    self.var_e81005ef731582b2 = 1;
    
    while ( true )
    {
        wait 1;
        
        while ( level utility::flag( "ar_active" ) || level utility::flag( "exfil_active" ) )
        {
            wait 5;
            var_228f5b38a069a713 = gettime();
        }
        
        var_7ad5ff667cf81866 = self getstance();
        
        if ( var_7ad5ff667cf81866 != "crouch" && var_7ad5ff667cf81866 != "prone" )
        {
            self.var_e81005ef731582b2 = undefined;
            return;
        }
        
        if ( !self istouching( trig ) )
        {
            self.var_e81005ef731582b2 = undefined;
            return;
        }
        
        if ( !utility::function_af749a6c1f8241f0( self, level.ee_kodomo.var_212d2fa4cbff80d.origin, 20 ) )
        {
            self.var_e81005ef731582b2 = undefined;
            return;
        }
        
        n_elapsed_ms = gettime() - var_228f5b38a069a713;
        
        if ( n_elapsed_ms >= 15000 )
        {
            level thread function_b1e24fed225da4ea();
            return;
        }
    }
}

// Namespace zm_sat_hornet_ee_kodomo
// Params 0, eflags: 0x4
// Checksum 0xe23d5054, Offset: 0x4f0
// Size: 0x221
function private function_b1e24fed225da4ea()
{
    level endon( #"game_ended" );
    level notify( #"hash_2ed4f8403a39da7c" );
    level utility::flag_set( "kodomo_triggered" );
    var_56b9bb528c1e9c38 = zm_sat_hornet_assault_rounds::function_bb933b778292b564( "zone_main_bailey" );
    musicbank_utility::function_5aca66c390aa347d( level.players, #"hash_ed80e464c09fd4c9" );
    level zm_sat_hornet_weather_ash::function_a0ca938f7360747e( "zone_main_bailey" );
    trig = getnoentvolumearray( "tk_trig_area", #targetname )[ 0 ];
    level.ee_kodomo.var_e1ee27d82fc76057 = [];
    level.ee_kodomo.var_63832eaf01cc334f = [];
    level.ee_kodomo.serene_trig = trig;
    level.ee_kodomo.serene_obstacle = createnavbadplacebybounds( level.ee_kodomo.start_trig.origin, ( 50, 50, 150 ), ( 0, 0, 0 ) );
    level thread function_1021cb9352ab4ed( level.ee_kodomo.start_trig.origin );
    level thread function_ce6c8c8f2169ef06( trig );
    wait 110;
    level notify( #"hash_be65714cd677b77d" );
    
    if ( level.ee_kodomo.serene_obstacle )
    {
        destroynavobstacle( level.ee_kodomo.serene_obstacle );
    }
    
    a_remaining = arraycopy( level.ee_kodomo.var_e1ee27d82fc76057 );
    
    foreach ( player in a_remaining )
    {
        if ( isdefined( player ) )
        {
            function_2c86bc1b6970ba00( player );
        }
    }
    
    level zm_sat_hornet_weather_ash::function_35ed61636451860f( "zone_main_bailey" );
}

// Namespace zm_sat_hornet_ee_kodomo
// Params 1
// Checksum 0x65045f6e, Offset: 0x719
// Size: 0xd8
function function_1021cb9352ab4ed( origin )
{
    level endon( #"game_ended" );
    a_zombies = getaiarrayinradius( origin, 150, "team_two_hundred" );
    
    foreach ( zombie in a_zombies )
    {
        if ( ( !isdefined( zombie.aicategory ) || zombie.aicategory == "normal" ) && !zombie zombie_knockdown::function_19d6107cb6bdff5c() )
        {
            zombie thread zombie_knockdown::function_6fc167d4a3590991( origin, 300 );
            waitframe();
        }
    }
}

// Namespace zm_sat_hornet_ee_kodomo
// Params 1, eflags: 0x4
// Checksum 0xca3a8dd2, Offset: 0x7f9
// Size: 0x9c
function private function_ce6c8c8f2169ef06( trig )
{
    level endon( #"game_ended" );
    level endon( #"hash_be65714cd677b77d" );
    
    while ( true )
    {
        trig waittill( #"trigger", player );
        
        if ( !zm_player::function_f37cfdf04b932a03( player ) )
        {
            continue;
        }
        
        if ( arraycontains( level.ee_kodomo.var_e1ee27d82fc76057, player ) )
        {
            continue;
        }
        
        if ( arraycontains( level.ee_kodomo.var_63832eaf01cc334f, player ) )
        {
            continue;
        }
        
        player thread function_ec19feefa0b64846();
    }
}

// Namespace zm_sat_hornet_ee_kodomo
// Params 0, eflags: 0x4
// Checksum 0xf65e9519, Offset: 0x89d
// Size: 0xbf
function private function_ec19feefa0b64846()
{
    level.ee_kodomo.var_e1ee27d82fc76057[ level.ee_kodomo.var_e1ee27d82fc76057.size ] = self;
    self playlocalsound( #"hash_ae5baf18149ce3b" );
    
    if ( getdvarint( @"hash_4b514f08cf43681", 1 ) )
    {
        self playlocalsound( #"hash_de5a4718bea8c1a" );
    }
    
    self setsoundsubmix( "zm_sat_hornet_ee_tkee", -1, 1 );
    val::set( "kodomo_serene", "ignoreme", 1 );
    pbgpostfxbundlestart( self, %"hash_25668659f5362a0b" );
    
    if ( !self getcamerathirdperson() )
    {
        self setscriptablepartstate( "hornet_cb_vfx", "on" );
    }
    
    self.var_20a9fad42d8ccc79 = 1;
    thread function_a895610891033663();
    thread function_d3c0062a30a3789a();
}

// Namespace zm_sat_hornet_ee_kodomo
// Params 0, eflags: 0x4
// Checksum 0xa66297bf, Offset: 0x964
// Size: 0x3b
function private function_a895610891033663()
{
    self endon( #"death_or_disconnect" );
    level endon( #"hash_be65714cd677b77d" );
    self endon( #"serene_removed" );
    self waittill( #"weapon_fired" );
    function_2c86bc1b6970ba00( self );
}

// Namespace zm_sat_hornet_ee_kodomo
// Params 0, eflags: 0x4
// Checksum 0xbc7cadd1, Offset: 0x9a7
// Size: 0x5d
function private function_d3c0062a30a3789a()
{
    self endon( #"death_or_disconnect" );
    level endon( #"hash_be65714cd677b77d" );
    self endon( #"serene_removed" );
    trig = level.ee_kodomo.serene_trig;
    
    while ( self istouching( trig ) )
    {
        wait 1;
    }
    
    function_2c86bc1b6970ba00( self );
}

// Namespace zm_sat_hornet_ee_kodomo
// Params 1, eflags: 0x4
// Checksum 0xa5885541, Offset: 0xa0c
// Size: 0x120
function private function_2c86bc1b6970ba00( player )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player.var_e81005ef731582b2 = undefined;
    level.ee_kodomo.var_63832eaf01cc334f[ level.ee_kodomo.var_63832eaf01cc334f.size ] = self;
    player val::reset( "kodomo_serene", "ignoreme" );
    player clearsoundsubmix( "zm_sat_hornet_ee_tkee" );
    player stoplocalsound( #"hash_ae5baf18149ce3b" );
    
    if ( getdvarint( @"hash_4b514f08cf43681", 1 ) )
    {
        player stoplocalsound( #"hash_de5a4718bea8c1a" );
    }
    
    if ( player.var_20a9fad42d8ccc79 && !player utility::ent_flag( "skr_buff" ) )
    {
        pbgpostfxbundleend( player, %"hash_25668659f5362a0b" );
        player setscriptablepartstate( "hornet_cb_vfx", "off" );
    }
    
    player.var_20a9fad42d8ccc79 = undefined;
    level.ee_kodomo.var_e1ee27d82fc76057 = arrayremove( level.ee_kodomo.var_e1ee27d82fc76057, player );
    player notify( #"serene_removed" );
}

