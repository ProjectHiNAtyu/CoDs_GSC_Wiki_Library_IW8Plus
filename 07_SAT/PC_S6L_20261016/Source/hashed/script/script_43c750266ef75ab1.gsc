// script_43c750266ef75ab1  (hash_43c750266ef75ab1.gscc) (size: 15462 Bytes / 0x3c66 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2d5722a1 (760685217)
// size ...... 15462 (0x3c66)
// includes .. 27  (offset: 0x390a)
// strings ... 49  (offset: 0x39e2)
// dev strs .. 0   (offset: 0x3c66)
// exports ... 44  (offset: 0x22ce)
// cseg ...... 0x3c4 + 0x1f0a (0x22ce)
// imports ... 132 (offset: 0x29ae)
// animtree1 . 0   (offset: 0x3c66)
// animtree2 . 0   (offset: 0x3c66)
#using scripts\common\callbacks;
#using scripts\common\swim_common;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\mp\armor;
#using scripts\mp\br\gametypes\br_armor;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_heatmap_radar;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\supers\super_deadsilence;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\execution;
#using scripts\mp\flags;
#using scripts\mp\gametypes\common;
#using scripts\mp\operator;
#using scripts\mp\weapons;

#namespace br_player_zombie;

// Namespace br_player_zombie
// Params 0, eflags: 0x5
// Checksum 0xda28c6fa, Offset: 0x3e2
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"br_player_zombie", undefined, &pre_main, &post_main );
}

// Namespace br_player_zombie
// Params 0, eflags: 0x5
// Checksum 0x1316f129, Offset: 0x407
// Size: 0x26
function private autoexec ignore()
{
    if ( !isdefined( game_utility_mp::function_4b7180ed8c2e9742( #"brplayerzombie" ) ) )
    {
        system::ignore( #"br_player_zombie" );
    }
}

// Namespace br_player_zombie
// Params 0, eflags: 0x4
// Checksum 0xb9caf440, Offset: 0x435
// Size: 0x5d8
function private pre_main()
{
    bundle = game_utility_mp::function_4b7180ed8c2e9742( #"brplayerzombie" );
    level.br_player_zombie = { #var_dfdea9bf3cb71480:bundle.var_dfdea9bf3cb71480, #var_3c1ec6d82153450:bundle.var_3c1ec6d82153450, #var_dd4742015b27dbda:bundle.var_dd4742015b27dbda, #var_c97b623c78ce2a3d:bundle.var_c97b623c78ce2a3d, #var_4bdc7b0f556d4e30:bundle.var_4bdc7b0f556d4e30, #var_d888d88788679fe0:bundle.var_d888d88788679fe0, #var_9a517c92beac7434:bundle.var_9a517c92beac7434, #var_2dd16de3fd25ae6a:bundle.var_2dd16de3fd25ae6a, #var_42cf15ea4c3e5a8e:bundle.var_42cf15ea4c3e5a8e, #var_a09ffd98da27bfe0:bundle.var_a09ffd98da27bfe0, #var_5fcfd020a46f1d2d:bundle.var_5fcfd020a46f1d2d, #var_d2d6df5af76b34d6:bundle.var_d2d6df5af76b34d6, #var_70fc66090cf9bf2b:bundle.var_70fc66090cf9bf2b, #var_cac48e9c08776439:bundle.var_cac48e9c08776439, #var_a79f9e658e0229c1:bundle.var_a79f9e658e0229c1, #var_68d3a61b60e16d3e:bundle.var_68d3a61b60e16d3e, #var_7d0ab573580d5d17:bundle.var_7d0ab573580d5d17, #var_8a523f27ebe94d5:bundle.var_8a523f27ebe94d5, #var_dc75786f3a587914:bundle.var_dc75786f3a587914, #var_b30627696e3463d8:bundle.var_b30627696e3463d8, #var_60ae949bf56bcbbb:bundle.var_60ae949bf56bcbbb, #var_c1e0f16ed0b8fdcf:bundle.var_c1e0f16ed0b8fdcf, #var_b2d649e9d8f9838a:bundle.var_b2d649e9d8f9838a, #var_d1ad09fbb1aaadc8:bundle.var_d1ad09fbb1aaadc8, #var_31933eb063b8f2a2:bundle.var_31933eb063b8f2a2, #var_e7c30a02ec11b962:bundle.var_e7c30a02ec11b962, #var_d12dd0001bd51e1a:bundle.var_d12dd0001bd51e1a, #var_5ea05b2d49dc923f:bundle.var_5ea05b2d49dc923f, #var_da4268b7c7dbfdc4:bundle.var_da4268b7c7dbfdc4, #var_e05610c49bdc7d24:bundle.var_e05610c49bdc7d24, #var_98d92b46605d1365:bundle.var_98d92b46605d1365, #var_a31cf342ac5e4668:bundle.var_a31cf342ac5e4668, #var_6829a0d08cd3cc71:bundle.var_6829a0d08cd3cc71, #var_29900d5066b8dd5d:bundle.var_29900d5066b8dd5d, #buybackhuman:bundle.buybackhuman, #var_af15665be7f5a02a:bundle.var_af15665be7f5a02a, #var_e9f65c464af95f10:bundle.var_e9f65c464af95f10, #zombievehiclelaststand:bundle.zombievehiclelaststand, #zombiespawnabovedeath:bundle.zombiespawnabovedeath, #zombiespawninair:bundle.zombiespawninair, #humanspawninair:bundle.humanspawninair, #var_1b16d86c9739bf4c:bundle.var_1b16d86c9739bf4c, #var_4e3f30061511a219:bundle.var_4e3f30061511a219, #var_1ddb6916a2c7f7b2:bundle.var_1ddb6916a2c7f7b2, #var_c1b3fc80e93983e7:bundle.var_c1b3fc80e93983e7, #zombienumhitstruck:bundle.zombienumhitstruck, #zombienumhitscar:bundle.zombienumhitscar, #zombienumhitsatv:bundle.zombienumhitsatv, #zombienumhitsheli:bundle.zombienumhitsheli, #zombienumhitshuman:bundle.zombienumhitshuman, #zombieregendelayscaleoutgas:bundle.zombieregendelayscaleoutgas, #zombieregendelayscaleingas:bundle.zombieregendelayscaleingas, #zombieregenratescaleoutgas:bundle.zombieregenratescaleoutgas, #zombieregenratescaleingas:bundle.zombieregenratescaleingas, #var_cc8abdbc87e6a778:bundle.var_cc8abdbc87e6a778, #var_78fb0e066fb254a1:bundle.var_78fb0e066fb254a1, #var_5cf21b915e62eed7:bundle.var_5cf21b915e62eed7, #var_41569cfd609eeca8:bundle.var_41569cfd609eeca8, #var_8b6494482c49707d:bundle.var_8b6494482c49707d, #var_c9a66d128bbd5327:bundle.var_c9a66d128bbd5327, #zombiesignorevehicleexplosions:bundle.zombiesignorevehicleexplosions, #var_c0c9d513c11ece4e:bundle.var_c0c9d513c11ece4e, #zombiesdamagezombies:bundle.zombiesdamagezombies, #var_840cd85046f1f281:bundle.var_840cd85046f1f281, #zombiespeed:bundle.zombiespeed, #var_4a23f0b7d164a398:bundle.var_4a23f0b7d164a398, #zombiehealth:bundle.zombiehealth, #var_863c681ea7e8b7ec:1 };
    level._effect[ level.br_player_zombie.var_a79f9e658e0229c1 ] = loadfxasset( level.br_player_zombie.var_a79f9e658e0229c1 );
    level._effect[ level.br_player_zombie.var_cac48e9c08776439 ] = loadfxasset( level.br_player_zombie.var_cac48e9c08776439 );
}

// Namespace br_player_zombie
// Params 0, eflags: 0x4
// Checksum 0x48ddabbe, Offset: 0xa15
// Size: 0x4a
function private post_main()
{
    level callback::add( #"player_death", &on_player_killed );
    damage_utility::register_vehicle_damage_callback( &modify_vehicle_damage );
    
    if ( level.br_player_zombie.var_c97b623c78ce2a3d )
    {
        level thread init_pickup_restrictions();
    }
    
    level thread on_start_end_game();
}

// Namespace br_player_zombie
// Params 0, eflags: 0x4
// Checksum 0x4981fd72, Offset: 0xa67
// Size: 0x24
function private on_start_end_game()
{
    level waittill( #"post_end_game_splash" );
    utility::array_thread( level.players, &reset_visuals );
}

// Namespace br_player_zombie
// Params 1
// Checksum 0x9fe73f79, Offset: 0xa93
// Size: 0x2a
function setup( var_af1feabe896eff01 )
{
    set_pre_spawn( var_af1feabe896eff01 );
    set_post_spawn( var_af1feabe896eff01 );
    
    if ( var_af1feabe896eff01 )
    {
        thread activate_systems();
    }
}

// Namespace br_player_zombie
// Params 1, eflags: 0x4
// Checksum 0xd88e0440, Offset: 0xac5
// Size: 0x1e
function private on_player_killed( params )
{
    if ( !br_public::playeriszombie() )
    {
        return;
    }
    
    reset_visuals();
}

// Namespace br_player_zombie
// Params 1, eflags: 0x4
// Checksum 0xd114b1ed, Offset: 0xaeb
// Size: 0x25c
function private modify_vehicle_damage( data )
{
    attacker = data.attacker ?? data.inflictor;
    var_80ca2aa1dbb2172 = data.meansofdeath == "MOD_MELEE";
    var_d8a02c5fae87db13 = data.meansofdeath == "MOD_GRENADE" && data.objweapon.var_1616e6fbba9a722d == %"sat_guts";
    var_1ea82e12c30bae9e = isplayer( attacker ) && attacker br_public::playeriszombie() && ( var_80ca2aa1dbb2172 || var_d8a02c5fae87db13 );
    
    if ( !var_1ea82e12c30bae9e )
    {
        return -1;
    }
    
    switch ( vehicle::get_ref() )
    {
        case %"hash_d37d79c77996a18":
        case %"vehiclebundle:veh_sat_atv_wz":
            numhits = var_80ca2aa1dbb2172 ? level.br_player_zombie.zombienumhitsatv : level.br_player_zombie.var_1ddb6916a2c7f7b2;
            break;
        case %"vehiclebundle:veh_sat_utv_wz":
            numhits = var_80ca2aa1dbb2172 ? level.br_player_zombie.zombienumhitscar : level.br_player_zombie.var_4e3f30061511a219;
            break;
        case %"hash_3e02b17ce7e578b2":
        case %"hash_40342e43bfc33421":
        case %"hash_52db5eb12cf54f8d":
        case %"hash_5615135cc8b0bfe5":
            numhits = var_80ca2aa1dbb2172 ? level.br_player_zombie.zombienumhitstruck : level.br_player_zombie.var_1b16d86c9739bf4c;
            break;
        case %"hash_336856991f0344eb":
        case %"hash_6ecc4b72654c75a5":
            numhits = var_80ca2aa1dbb2172 ? level.br_player_zombie.zombienumhitsheli : level.br_player_zombie.var_c1b3fc80e93983e7;
            break;
        default:
            numhits = var_80ca2aa1dbb2172 ? level.br_player_zombie.zombienumhitstruck : level.br_player_zombie.var_1b16d86c9739bf4c;
            break;
    }
    
    return int( ceil( self.maxhealth / numhits ) );
}

// Namespace br_player_zombie
// Params 0, eflags: 0x4
// Checksum 0xfbf39213, Offset: 0xd50
// Size: 0x24
function private init_pickup_restrictions()
{
    flags::function_2f3408423ccc9b2e( "prematch_fade_done" );
    level callback::add( #"hash_4239cc94bed9cb5c", &function_69e2c1c4b32d01bf );
}

// Namespace br_player_zombie
// Params 1, eflags: 0x4
// Checksum 0x277c9fc9, Offset: 0xd7c
// Size: 0x8d, Type: bool
function private function_69e2c1c4b32d01bf( params )
{
    player = params.player;
    itemtype = params.itemtype;
    itembundle = params.itembundle;
    
    if ( !player br_public::playeriszombie() )
    {
        return true;
    }
    
    if ( itemtype == "currency" && itembundle.subtype == "cash" )
    {
        return false;
    }
    
    if ( itemtype != "currency" )
    {
        return false;
    }
    
    return true;
}

// Namespace br_player_zombie
// Params 1, eflags: 0x4
// Checksum 0xfd283207, Offset: 0xe12
// Size: 0x15f
function private set_pre_spawn( iszombie )
{
    if ( !iszombie )
    {
        reset_visuals();
    }
    
    set_operator( iszombie );
    self.iszombie = iszombie;
    self function_957a727ade8e2011( iszombie );
    
    if ( iszombie )
    {
        self.game_extrainfo |= 131072;
    }
    else
    {
        self.game_extrainfo &= ~131072;
    }
    
    if ( iszombie )
    {
        self notify( #"zombie_set" );
        level notify( #"zombie_set", self );
        
        if ( threatbiasgroupexists( "player_zombie" ) )
        {
            self setthreatbiasgroup( "player_zombie" );
        }
    }
    else
    {
        self notify( #"zombie_unset" );
        level notify( #"zombie_unset", self );
        self setthreatbiasgroup();
    }
    
    level notify( #"players_remaining_changed" );
    
    foreach ( teammember in teams::getteamdata( self.team, "players" ) )
    {
        if ( isdefined( teammember ) )
        {
            teammember notify( #"refresh_revives" );
        }
    }
}

// Namespace br_player_zombie
// Params 1, eflags: 0x4
// Checksum 0xae73d4ab, Offset: 0xf79
// Size: 0x19a
function private set_post_spawn( iszombie )
{
    if ( !level.br_player_zombie.var_cc8abdbc87e6a778 )
    {
        br_public::function_bb22d91d6d217fe1( iszombie );
    }
    
    if ( iszombie )
    {
        val::set( #"br_player_zombie", "weapon_pickup", 0 );
        val::set( #"br_player_zombie", "weapon_switch", 0 );
        val::set( #"br_player_zombie", "vehicle_use", 0 );
        val::set( #"br_player_zombie", "allow_revive_teammate", 0 );
        val::set( #"br_player_zombie", "backpack_inventory", 0 );
        val::set( #"br_player_zombie", "allow_battlechatter_vo", 0 );
        val::set( #"br_player_zombie", "disallow_cache_use", 1 );
        
        if ( !level.br_player_zombie.var_4bdc7b0f556d4e30 )
        {
            val::set( #"br_player_zombie", "ascender_use", 0 );
        }
        
        if ( !level.br_player_zombie.var_c1e0f16ed0b8fdcf )
        {
            val::set( #"br_player_zombie", "execution_attack", 0 );
        }
        
        val::set( #"br_player_zombie", "crate_use", 0 );
        
        if ( level.br_player_zombie.var_d888d88788679fe0 )
        {
            set_movespeed( level.br_player_zombie.zombiespeed );
        }
    }
    else
    {
        val::reset_all( #"br_player_zombie" );
        unset_movespeed();
    }
    
    swim_common::function_858b92a50d1c824b( iszombie );
    self.ammo_cache_disabled = iszombie;
}

// Namespace br_player_zombie
// Params 0
// Checksum 0xf9485710, Offset: 0x111b
// Size: 0x3f
function reset_visuals()
{
    if ( !br_public::playeriszombie() )
    {
        return;
    }
    
    self setscriptablepartstate( #"zombie", #"off", 0 );
    utility::function_32b24db3127bff40( #"infected_vfx", #"super_fx_off" );
}

// Namespace br_player_zombie
// Params 0, eflags: 0x4
// Checksum 0xbc8d10ac, Offset: 0x1162
// Size: 0x91
function private activate_systems()
{
    thread set_hide_in_gas();
    thread set_super_sprint();
    thread set_vision();
    
    if ( level.br_player_zombie.var_31933eb063b8f2a2 )
    {
        thread function_56a48e528289d06f();
    }
    
    thread set_ambience_override();
    thread function_1d35850892b38eb7();
    
    if ( level.br_player_zombie.var_c9a66d128bbd5327 )
    {
        thread set_radar();
    }
    
    if ( level.br_player_zombie.var_8b6494482c49707d )
    {
        thread set_heatmap_radar();
    }
    
    thread set_perks();
    thread function_4f43f8f2311b77c7();
    thread function_cacb9b7259fca65a();
}

// Namespace br_player_zombie
// Params 1, eflags: 0x4
// Checksum 0xb81e5ff2, Offset: 0x11fb
// Size: 0x156
function private set_operator( iszombie )
{
    if ( !level.br_player_zombie.var_60ae949bf56bcbbb )
    {
        return;
    }
    
    if ( iszombie )
    {
        operatorref = operator::isfemale() ? level.br_player_zombie.var_b30627696e3463d8 : level.br_player_zombie.var_8a523f27ebe94d5;
        skinindex = operator::isfemale() ? level.br_player_zombie.var_dc75786f3a587914 : level.br_player_zombie.var_7d0ab573580d5d17;
        operatorbundle = getoperatorscriptbundle( operatorref );
        var_16b1d09e3f9d5e94 = isdefined( skinindex ) && isdefined( operatorbundle.skins[ skinindex ].skin );
        var_2106ff72782c3841 = var_16b1d09e3f9d5e94 ? operatorbundle.skins[ skinindex ].skin : operatorbundle.defaultskin;
        operator::createoperatorcustomization( operatorref, var_2106ff72782c3841 );
        
        if ( level.br_player_zombie.var_c1e0f16ed0b8fdcf )
        {
            execution::_giveexecution( level.br_player_zombie.var_68d3a61b60e16d3e );
        }
        
        return;
    }
    
    operator::createoperatorcustomization();
}

// Namespace br_player_zombie
// Params 1
// Checksum 0x8649238f, Offset: 0x1359
// Size: 0x28
function set_movespeed( movespeed )
{
    common::function_a0f5c85d465c5f0a( #"br_player_zombie", movespeed - 1 );
    weapons::updatemovespeedscale();
}

// Namespace br_player_zombie
// Params 0, eflags: 0x4
// Checksum 0x6d855087, Offset: 0x1389
// Size: 0x2b
function private unset_movespeed()
{
    if ( common::function_8ff835bf23198a0( #"br_player_zombie" ) )
    {
        common::function_d85a92c557ea5a52( #"br_player_zombie" );
    }
    
    weapons::updatemovespeedscale();
}

// Namespace br_player_zombie
// Params 0, eflags: 0x4
// Checksum 0xe010786d, Offset: 0x13bc
// Size: 0x27
function private set_freefall()
{
    self skydive_interrupt();
    self.ffsm_state = 5;
    self skydive_setbasejumpingstatus( 0 );
    self skydive_setdeploymentstatus( 0 );
    self skydive_beginfreefall();
}

// Namespace br_player_zombie
// Params 0, eflags: 0x4
// Checksum 0xf872bee4, Offset: 0x13eb
// Size: 0x11f
function private function_4f43f8f2311b77c7()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"zombie_unset" );
    set_freefall();
    wait 1;
    val::set( #"br_player_zombie", "show_legs_and_shadow", 0 );
    
    while ( !self isonground() && !self isswimming() )
    {
        waitframe();
    }
    
    self notify( #"bpz_landed" );
    self setclientomnvar( "ui_br_altimeter_state", 0 );
    self skydive_interrupt();
    playfx( level._effect[ level.br_player_zombie.var_cac48e9c08776439 ], self.origin );
    
    switch ( level.br_player_zombie.var_dd4742015b27dbda )
    {
        case 0:
            function_7505b391fea996cc();
            break;
        case 1:
            function_5173ea9045db2105();
            break;
    }
    
    self skydive_setbasejumpingstatus( 0 );
    self skydive_setdeploymentstatus( 0 );
    val::reset( #"br_player_zombie", "show_legs_and_shadow" );
    self notify( #"bpz_activated" );
}

// Namespace br_player_zombie
// Params 0, eflags: 0x4
// Checksum 0xe0898230, Offset: 0x1512
// Size: 0xaa
function private function_7505b391fea996cc()
{
    self playlocalsound( "zxp_splat_plr" );
    self playsound( "zxp_spawn_splat_npc", self, self );
    self freezecontrols( 1 );
    function_bbd236ef75fd9cf9();
    
    if ( self getcurrentprimaryweapon().classname != "none" )
    {
        self forceplaygestureviewmodel( level.br_player_zombie.var_70fc66090cf9bf2b );
    }
    
    wait 1;
    self playlocalsound( "zxp_spawn_getup" );
    self skydive_setbasejumpingstatus( 0 );
    self skydive_setdeploymentstatus( 0 );
    wait 1;
    self freezecontrols( 0 );
    self freezelookcontrols( 1 );
    self allowsprint( 0 );
    wait 1;
    self freezelookcontrols( 0 );
    self allowsprint( 1 );
}

// Namespace br_player_zombie
// Params 0, eflags: 0x4
// Checksum 0xc186b1dc, Offset: 0x15c4
// Size: 0x109
function private function_bbd236ef75fd9cf9()
{
    ground_normal = utility::get_average_ground_normal( self.origin, 32, 64, -64, trace::create_default_contents(), self );
    var_623d176734a81a1b = anglestoforward( self.angles );
    new_angles = vectortoangles( ground_normal );
    pitch = angleclamp180( new_angles[ 0 ] + 90 );
    new_angles = ( 0, new_angles[ 1 ], 0 );
    var_82aad61d9dc8fa10 = anglestoforward( new_angles );
    dot = vectordot( var_82aad61d9dc8fa10, var_623d176734a81a1b );
    var_915a422f3224a895 = dot * pitch;
    var_99145ae0a1f34e90 = level.br_player_zombie.var_d2d6df5af76b34d6;
    var_f9f9a709917b0985 = level.br_player_zombie.var_5fcfd020a46f1d2d;
    
    if ( var_915a422f3224a895 > 0 )
    {
        var_915a422f3224a895 = min( var_99145ae0a1f34e90, var_915a422f3224a895 );
    }
    else
    {
        var_915a422f3224a895 = max( var_f9f9a709917b0985, var_915a422f3224a895 );
    }
    
    self setplayerangles( ( var_915a422f3224a895, self.angles[ 1 ], 0 ) );
}

// Namespace br_player_zombie
// Params 0, eflags: 0x4
// Checksum 0x7df58d80, Offset: 0x16d5
// Size: 0x96
function private function_5173ea9045db2105()
{
    if ( level.br_player_zombie.var_dfdea9bf3cb71480 >= 1 )
    {
        childthread function_a19e5215d0eb9ca4( level.br_player_zombie.var_dfdea9bf3cb71480 / 2 );
    }
    
    thread function_c42b6f3e0551289a();
    shellshock_utility_cpmp::_shellshock( level.br_player_zombie.var_3c1ec6d82153450, #"stun", level.br_player_zombie.var_dfdea9bf3cb71480 );
    utility::setplayerstunned();
    weapon_utility::cleanupconcussionstun( level.br_player_zombie.var_dfdea9bf3cb71480 );
}

// Namespace br_player_zombie
// Params 1, eflags: 0x4
// Checksum 0x69b811a4, Offset: 0x1773
// Size: 0x3a
function private function_a19e5215d0eb9ca4( duration )
{
    val::set( #"br_player_zombie", "melee", 0 );
    wait duration;
    val::reset( #"br_player_zombie", "melee" );
}

// Namespace br_player_zombie
// Params 0, eflags: 0x4
// Checksum 0xecd462a1, Offset: 0x17b5
// Size: 0x52
function private function_c42b6f3e0551289a()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    utility::function_32b24db3127bff40( #"super_mega_jump", #"impact_alt" );
    wait 1;
    utility::function_32b24db3127bff40( #"super_mega_jump", #"off" );
}

// Namespace br_player_zombie
// Params 0, eflags: 0x4
// Checksum 0xa8802819, Offset: 0x180f
// Size: 0x6f
function private function_1d35850892b38eb7()
{
    self endon( #"death_or_disconnect" );
    self endon( #"zombie_unset" );
    waitframe();
    
    if ( level.br_player_zombie.var_a09ffd98da27bfe0 )
    {
        utility::function_32b24db3127bff40( "zombie", "on_loop" );
    }
    else
    {
        utility::function_32b24db3127bff40( "zombie", "on" );
    }
    
    utility::function_32b24db3127bff40( #"infected_vfx", #"super_fx_on" );
}

// Namespace br_player_zombie
// Params 0, eflags: 0x4
// Checksum 0xb0c19c3b, Offset: 0x1886
// Size: 0xe5
function private set_vision()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( !level.br_player_zombie.var_6829a0d08cd3cc71 )
    {
        return;
    }
    
    if ( level.br_player_zombie.var_a31cf342ac5e4668 )
    {
        self lerpfovbypreset( "zombiedefault" );
    }
    
    if ( level.br_player_zombie.var_da4268b7c7dbfdc4 )
    {
        self setclientomnvar( "ui_deadsilence_overlay", 0 );
    }
    
    if ( level.br_player_zombie.var_5ea05b2d49dc923f )
    {
        utility::function_32b24db3127bff40( "headVFX", "zombieVision" );
    }
    
    if ( level.br_player_zombie.var_98d92b46605d1365 )
    {
        pbgpostfxbundlekill( self, level.br_player_zombie.var_e05610c49bdc7d24 );
        waitframe();
        pbgpostfxbundlestart( self, level.br_player_zombie.var_e05610c49bdc7d24 );
    }
}

// Namespace br_player_zombie
// Params 0, eflags: 0x4
// Checksum 0x9d84dc71, Offset: 0x1973
// Size: 0xae
function private remove_vision()
{
    if ( !level.br_player_zombie.var_6829a0d08cd3cc71 )
    {
        return;
    }
    
    if ( level.br_player_zombie.var_a31cf342ac5e4668 )
    {
        self lerpfovbypreset( "default_2seconds" );
    }
    
    if ( level.br_player_zombie.var_98d92b46605d1365 )
    {
        pbgpostfxbundlekill( self, level.br_player_zombie.var_e05610c49bdc7d24 );
    }
    
    if ( level.br_player_zombie.var_da4268b7c7dbfdc4 )
    {
        thread super_deadsilence::superdeadsilence_endhudsequence();
    }
    
    if ( level.br_player_zombie.var_5ea05b2d49dc923f )
    {
        utility::function_32b24db3127bff40( "headVFX", "neutral" );
    }
}

// Namespace br_player_zombie
// Params 0, eflags: 0xc
// Checksum 0x86b83aec, Offset: 0x1a29
// Size: 0x70
function private set_ambience_override()
{
    self notify( #"hash_4985c89d6effaeff" );
    self endon( #"hash_4985c89d6effaeff" );
    self endon( #"disconnect" );
    self endon( #"swim_breathing_disabled_begin" );
    self endon( #"swim_begin" );
    
    if ( br_public::playeriszombie() )
    {
        self setclienttriggeraudiozonepartial( "player_is_zombie", "ambient" );
        utility::waittill_any( "zombie_unset", "death" );
        self clearclienttriggeraudiozone( 1 );
    }
}

// Namespace br_player_zombie
// Params 0
// Checksum 0x9de7e761, Offset: 0x1aa1
// Size: 0x17d
function function_56a48e528289d06f()
{
    self notify( #"hash_eb45a2e3acda94b5" );
    self endon( #"hash_eb45a2e3acda94b5" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"zombie_unset" );
    thread remove_outline();
    outline::_hudoutlineviewmodelenable( level.br_player_zombie.var_d12dd0001bd51e1a, 0 );
    self.zombieoutlineids = [];
    
    foreach ( player in level.players )
    {
        if ( player === self )
        {
            continue;
        }
        
        function_ad3dff0393ead8bf( player );
    }
    
    childthread function_a856fdde3458eec5( "zombie_set", "zombie_unset" );
    
    for ( ;; )
    {
        self waittill( #"hash_26d342a69862e6ee", changedplayer );
        
        if ( !isdefined( changedplayer ) || changedplayer === self )
        {
            continue;
        }
        
        entitynum = changedplayer getentitynumber();
        
        if ( isdefined( self.zombieoutlineids[ entitynum ] ) )
        {
            outline::outlinedisable( self.zombieoutlineids[ entitynum ].outlineid, changedplayer );
            self.zombieoutlineids[ entitynum ] = undefined;
        }
        
        function_ad3dff0393ead8bf( changedplayer );
    }
}

// Namespace br_player_zombie
// Params 2, eflags: 0x44 variadic
// Checksum 0x9e9a5b68, Offset: 0x1c26
// Size: 0x3e
function private function_a856fdde3458eec5( ... )
{
    for ( ;; )
    {
        params = level utility::waittill_any_return_params( flat_args( vararg, varargcount ) );
        self notify( #"hash_26d342a69862e6ee", params[ 0 ] );
    }
}

// Namespace br_player_zombie
// Params 1, eflags: 0x4
// Checksum 0xde8a0fab, Offset: 0x1c6c
// Size: 0xac
function private function_ad3dff0393ead8bf( player )
{
    outlineasset = player_utility::isfriendly( player.team, self ) ? level.br_player_zombie.var_d12dd0001bd51e1a : level.br_player_zombie.var_e7c30a02ec11b962;
    outlineid = outline::outlineenableforplayer( player, self, outlineasset, "level_script", 1 );
    entry = {};
    entry.player = player;
    entry.outlineid = outlineid;
    self.zombieoutlineids[ player getentitynumber() ] = entry;
}

// Namespace br_player_zombie
// Params 0, eflags: 0x4
// Checksum 0x9ccd7178, Offset: 0x1d20
// Size: 0xc2
function private remove_outline()
{
    self endon( #"disconnect" );
    utility::waittill_any( "zombie_unset", "death" );
    outline::_hudoutlineviewmodeldisable();
    
    foreach ( entry in self.zombieoutlineids )
    {
        if ( isdefined( entry.player ) )
        {
            outline::outlinedisable( entry.outlineid, entry.player );
        }
    }
}

// Namespace br_player_zombie
// Params 0, eflags: 0xc
// Checksum 0x735c37b, Offset: 0x1dea
// Size: 0xa8
function private set_hide_in_gas()
{
    self notify( #"hash_81a0ebeefc907e67" );
    self endon( #"hash_81a0ebeefc907e67" );
    level endon( #"game_ended" );
    self endon( #"zombie_unset" );
    self endon( #"disconnect" );
    self.var_afaafeeb9b80ba40 = undefined;
    
    while ( true )
    {
        if ( function_c07606f33e84535a() )
        {
            if ( !self.var_afaafeeb9b80ba40 )
            {
                self.var_afaafeeb9b80ba40 = 1;
                enter_gas();
            }
        }
        else if ( !isdefined( self.var_afaafeeb9b80ba40 ) || self.var_afaafeeb9b80ba40 )
        {
            self.var_afaafeeb9b80ba40 = 0;
            exit_gas();
        }
        
        waitframe();
    }
}

// Namespace br_player_zombie
// Params 0, eflags: 0x4
// Checksum 0xf558695b, Offset: 0x1e9a
// Size: 0x1a
function private enter_gas()
{
    self notify( #"zombie_enter_gas" );
    perk::removeperk( "specialty_radarblip" );
}

// Namespace br_player_zombie
// Params 0, eflags: 0x4
// Checksum 0x986e1ce2, Offset: 0x1ebc
// Size: 0x6c
function private exit_gas()
{
    self notify( #"zombie_exit_gas" );
    
    if ( !level.br_player_zombie.var_41569cfd609eeca8 )
    {
        return;
    }
    
    if ( level.br_player_zombie.var_5cf21b915e62eed7 == 0 )
    {
        perk::giveperk( "specialty_radarblip" );
        return;
    }
    
    if ( level.br_player_zombie.var_5cf21b915e62eed7 > 0 )
    {
        thread function_d4704cad760c1005();
    }
}

// Namespace br_player_zombie
// Params 0, eflags: 0x4
// Checksum 0xbdd454e7, Offset: 0x1f30
// Size: 0x7a
function private function_d4704cad760c1005()
{
    self endon( #"zombie_unset" );
    self endon( #"zombie_enter_gas" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        perk::giveperk( "specialty_radarblip" );
        wait level.br_player_zombie.var_78fb0e066fb254a1;
        perk::removeperk( "specialty_radarblip" );
        wait level.br_player_zombie.var_5cf21b915e62eed7;
    }
}

// Namespace br_player_zombie
// Params 0, eflags: 0x4
// Checksum 0x7ae85a8f, Offset: 0x1fb2
// Size: 0x5f, Type: bool
function private function_c07606f33e84535a()
{
    if ( !( isdefined( level.br_circle ) && isdefined( level.br_circle.dangercircleent ) ) )
    {
        return false;
    }
    
    danger_circle_origin = br_circle::getdangercircleorigin();
    danger_circle_radius = br_circle::getdangercircleradius();
    return distance2dsquared( danger_circle_origin, self.origin ) > danger_circle_radius * danger_circle_radius;
}

// Namespace br_player_zombie
// Params 1
// Checksum 0x8adcfd0e, Offset: 0x201a
// Size: 0x72
function set_radar( radartype = "normal_radar" )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self.skipuavupdate = 1;
    self.radarmode = radartype;
    self.hasradar = 1;
    self waittill( #"zombie_unset" );
    self.skipuavupdate = undefined;
    self.hasradar = 0;
}

// Namespace br_player_zombie
// Params 0
// Checksum 0xe0247acb, Offset: 0x2094
// Size: 0xb9
function set_heatmap_radar()
{
    if ( !br_heatmap_radar::function_99a884c31446d940() )
    {
        return;
    }
    
    if ( !level.br_heatmap_radar.var_4e94b83a2d065b10 )
    {
        foreach ( player in level.players )
        {
            if ( !player::isreallyalive( player ) )
            {
                continue;
            }
            
            player function_f338d3d650732316();
        }
        
        level thread br_heatmap_radar::function_af96b137d5b71cfa();
    }
    
    thread function_844c726fec0f9f52();
}

// Namespace br_player_zombie
// Params 0, eflags: 0x4
// Checksum 0xcf52ca4e, Offset: 0x2155
// Size: 0x37
function private function_844c726fec0f9f52()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self function_35031d9b290ddfc1();
    utility::waittill_any( "death", "zombie_unset" );
    self function_1316a52efc290b9e();
}

// Namespace br_player_zombie
// Params 0, eflags: 0x4
// Checksum 0x150533f7, Offset: 0x2194
// Size: 0x55
function private set_super_sprint()
{
    if ( !level.br_player_zombie.var_42cf15ea4c3e5a8e )
    {
        return;
    }
    
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"zombie_unset" );
    
    while ( true )
    {
        if ( self issupersprinting() )
        {
            self refreshsprinttime();
        }
        
        waitframe();
    }
}

// Namespace br_player_zombie
// Params 0, eflags: 0x4
// Checksum 0x3c2fbaca, Offset: 0x21f1
// Size: 0x7a
function private set_perks()
{
    perk::giveperk( "specialty_falldamage" );
    perk::giveperk( "specialty_missileprediction" );
    
    if ( !level.br_player_zombie.var_2dd16de3fd25ae6a )
    {
        return;
    }
    
    perk::giveperk( "specialty_coldblooded" );
    perk::giveperk( "specialty_noscopeoutline" );
    perk::giveperk( "specialty_tracker_pro" );
    perk::giveperk( "specialty_sprintmelee" );
    perk::giveperk( "specialty_sprintads" );
    perk::giveperk( "specialty_gas_immunity" );
}

// Namespace br_player_zombie
// Params 0, eflags: 0xc
// Checksum 0x1215b62, Offset: 0x2273
// Size: 0x5b
function private function_cacb9b7259fca65a()
{
    self notify( #"hash_7e1490afb409f2b6" );
    self endon( #"hash_7e1490afb409f2b6" );
    
    if ( level.br_player_zombie.var_9a517c92beac7434 )
    {
        return;
    }
    
    self endon( #"death_or_disconnect" );
    self endon( #"zombie_unset" );
    waitframe();
    armor::givestartingarmor( 0, 0 );
    br_armor::givearmorvalue( 0 );
}

