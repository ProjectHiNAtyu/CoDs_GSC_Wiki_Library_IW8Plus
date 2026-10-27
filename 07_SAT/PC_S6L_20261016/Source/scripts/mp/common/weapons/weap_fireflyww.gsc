// scripts\mp\common\weapons\weap_fireflyww.gsc  (hash_6dd1bde0b6501c65.gscc) (size: 46208 Bytes / 0xb480 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb9f0b954 (3119561044)
// size ...... 46208 (0xb480)
// includes .. 25  (offset: 0xaac0)
// strings ... 127 (offset: 0xab88)
// dev strs .. 24  (offset: 0xb354)
// exports ... 101 (offset: 0x7488)
// cseg ...... 0x937 + 0x6b51 (0x7488)
// imports ... 302 (offset: 0x8450)
// animtree1 . 0   (offset: 0xb480)
// animtree2 . 0   (offset: 0xb480)
#using script_aa3bac81ad4fc8e;
#using scripts\common\ai\aitypes\shared\zombie\zombie_damage;
#using scripts\common\ai\aitypes\shared\zombie\zombie_dismemberment;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\metabone;
#using scripts\common\powerups;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\weapons\ww_shared;
#using scripts\mp\health_overcharge;
#using scripts\mp\loot\common_item;
#using scripts\mp\overlord;
#using scripts\mp\player_banter;
#using scripts\mp\weapons;

#namespace weap_fireflyww;

// Namespace weap_fireflyww
// Params 0, eflags: 0x5
// Checksum 0xa31e1486, Offset: 0x955
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( #"weap_fireflyww", undefined, &pre_main, &post_main );
}

// Namespace weap_fireflyww
// Params 0, eflags: 0x4
// Checksum 0x6fa25ca6, Offset: 0x97a
// Size: 0x9
function private pre_main()
{
    init();
}

// Namespace weap_fireflyww
// Params 0, eflags: 0x4
// Checksum 0x356b4163, Offset: 0x98b
// Size: 0x19d
function private init()
{
    weapon_name = utility::get_scripted_weapon_name( #"necrofluid_gauntlet" );
    level.fireflyww_basename = weapon_name;
    level callback::add( #"player_weapon_change", &on_player_weapon_change, weapon_name );
    level callback::add( #"player_connect", &on_player_connect, weapon_name );
    level callback::add( #"player_disconnect", &on_player_disconnect );
    level callback::add( "on_add_pap_attachments", &on_add_pap_attachments, weapon_name );
    level callback::add( #"on_ai_killed", &function_8c5e06ee1e60aeb7 );
    level zombie_utils::function_dfae6a5bd222c586( &function_17fdfda41f9aa95a );
    level scriptable::scriptable_adddamagedcallback( &on_scriptable_damaged );
    utility::registersharedfunc( #"hash_e7a7d049d5f06935", #"hash_9cc974404dd11cf3", &function_34b4f27d58fcf9d4 );
    utility::registersharedfunc( #"fireflyww", #"hash_dd255803bfe21f65", &function_4b396e997a3479da );
    init_custom_settings( weapon_name );
    level.var_f7d8c385fccc43b4[ weapon_name ] = &function_9562384d11c0a0fd;
    assert( isdefined( level.fireflyww_settings.liquid_grenade_weapon ), "<dev string:x24>" );
    level.var_f7d8c385fccc43b4[ level.fireflyww_settings.liquid_grenade_weapon ] = &function_a5855cb20d635c85;
    level thread function_b5b50fd05d69ab45( weapon_name );
    level.var_76c45cae2094c966 = [];
    level.fireflyww_retrievable_throttle = throttle::throttle_initialize( "fireflyww_retrievable_throttle" );
    utility::registersharedfunc( #"weap_fireflyww", #"register_vo_event", &register_vo_event );
    
    /#
        init_fireflyww_devgui();
    #/
}

// Namespace weap_fireflyww
// Params 0, eflags: 0x4
// Checksum 0x83a7a8b5, Offset: 0xb30
// Size: 0x5c
function private post_main()
{
    if ( utility::issharedfuncdefined( #"deadliest_weapon_ai", #"add_deadliest_weapon" ) )
    {
        basenamehash = getxhashasset( level.fireflyww_basename );
        [[ utility::getsharedfunc( #"deadliest_weapon_ai", #"add_deadliest_weapon" ) ]]( basenamehash, 1 );
    }
    
    thread function_d81f48f88df7d05d();
}

// Namespace weap_fireflyww
// Params 0, eflags: 0x4
// Checksum 0x15438c48, Offset: 0xb94
// Size: 0x26
function private function_d81f48f88df7d05d()
{
    level endon( #"game_ended" );
    utility::flag_wait( "common_items_init" );
    common_item::function_9c9e4c71569f3ae8( &function_b190a58d96c55ce6 );
}

// Namespace weap_fireflyww
// Params 1, eflags: 0x4
// Checksum 0xe8f808d4, Offset: 0xbc2
// Size: 0x654
function private init_custom_settings( weapon_name )
{
    weap_fireflyww = makeweapon( weapon_name );
    assert( isdefined( weap_fireflyww.weaponcustomsettings ), "<dev string:x5d>" );
    level.fireflyww_settings = {};
    level.fireflyww_settings.liquid_grenade_weapon = weap_fireflyww.weaponcustomsettings.liquidgrenadeweapon;
    level.fireflyww_settings.liquid_scriptable = weap_fireflyww.weaponcustomsettings.liquidscriptable;
    level.fireflyww_settings.var_6e45d8cfdf28c3c = weap_fireflyww.weaponcustomsettings.var_416ed6757738bcad;
    level.fireflyww_settings.var_f84704015fb997f = weap_fireflyww.weaponcustomsettings.var_7ac42486f2a1e1b5;
    level.fireflyww_settings.var_40f0980a5fdc6c4d = weap_fireflyww.weaponcustomsettings.var_40f872a4c5a36615;
    level.fireflyww_settings.var_cd421d1f5bcd59e4 = weap_fireflyww.weaponcustomsettings.var_d53d14e827a2ec44;
    level.fireflyww_settings.var_6b71bd2951eccdb8 = weap_fireflyww.weaponcustomsettings.var_27c32f1af76bab5a;
    level.fireflyww_settings.var_e58354164df1c698 = weap_fireflyww.weaponcustomsettings.var_32276ce537cb8174;
    level.fireflyww_settings.var_46832807e43a7308 = weap_fireflyww.weaponcustomsettings.var_fbedf95cb1c86100;
    level.fireflyww_settings.var_8e1cb193ae553ee0 = weap_fireflyww.weaponcustomsettings.var_5425982dd7101eb8;
    level.fireflyww_settings.var_1213342b0ba595bb = weap_fireflyww.weaponcustomsettings.var_59229260ee2bb810;
    level.fireflyww_settings.var_85e2a24d113862c4 = weap_fireflyww.weaponcustomsettings.var_27a827eec4a27957;
    level.fireflyww_settings.var_8e887a35930d051d = weap_fireflyww.weaponcustomsettings.var_d9d8fc08b68ddab6;
    level.fireflyww_settings.var_86ecc59db88c9f10 = weap_fireflyww.weaponcustomsettings.var_5525d9e45491e6e6;
    level.fireflyww_settings.var_57caf24e25bac3a7 = weap_fireflyww.weaponcustomsettings.var_32ac9239677efe84;
    level.fireflyww_settings.var_f2c4e1253303bede = weap_fireflyww.weaponcustomsettings.var_919ea2275a7af25;
    level.fireflyww_settings.var_8617ebba787217fa = weap_fireflyww.weaponcustomsettings.var_92164fae79457692;
    level.fireflyww_settings.overload_charge_time = weap_fireflyww.weaponcustomsettings.var_7820d02b934377d5;
    level.fireflyww_settings.explosion_interval = weap_fireflyww.weaponcustomsettings.explosioninterval;
    level.fireflyww_settings.var_ae25c5d56adefe79 = weap_fireflyww.weaponcustomsettings.var_3698056d9b6d25d2;
    level.fireflyww_settings.var_97164a5f0dfd86dc = weap_fireflyww.weaponcustomsettings.var_57057633f6a1e91b;
    level.fireflyww_settings.var_204feab99962ffef = weap_fireflyww.weaponcustomsettings.var_902f408f772473e8;
    level.fireflyww_settings.var_734e94209fa548aa = weap_fireflyww.weaponcustomsettings.var_8652d82dffaaefc1;
    level.fireflyww_settings.var_dc517ba7808f662e = weap_fireflyww.weaponcustomsettings.var_a9547f220eabdf14;
    level.fireflyww_settings.var_e710e0e2633294bf = weap_fireflyww.weaponcustomsettings.var_cd4e65f4e40ff1e1;
    level.fireflyww_settings.var_445d40b18abcffec = weap_fireflyww.weaponcustomsettings.var_9bfdab8b2f7011ce;
    level.fireflyww_settings.var_c2e16e0c0d2a3c95 = weap_fireflyww.weaponcustomsettings.var_9636e7f63724283b;
    register_vo_event( "fireflyww_pap", #"ww_pap", 100, -1, 0.75 );
    register_vo_event( "fireflyww_melee", #"ww_melee", 15, 60, 0 );
    register_vo_event( "fireflyww_spike_shot", #"ww_shot", 15, 60, 0 );
    register_vo_event( "fireflyww_overload", #"ww_overload", 15, 60, 0 );
    register_vo_event( "fireflyww_spike_recall", #"ww_recall", 15, 60, 0 );
    register_vo_event( "fireflyww_life_steal", #"hash_def936593025e0a9", 15, 60, 0 );
    
    if ( weap_fireflyww.weaponcustomsettings.var_bb951ad2d3ad9319.x && weap_fireflyww.weaponcustomsettings.var_bb951ad2d3ad9319.y && weap_fireflyww.weaponcustomsettings.var_bb951ad2d3ad9319.z )
    {
        level.fireflyww_settings.var_174f007fc88bf308 = ( weap_fireflyww.weaponcustomsettings.var_bb951ad2d3ad9319.x, weap_fireflyww.weaponcustomsettings.var_bb951ad2d3ad9319.y, weap_fireflyww.weaponcustomsettings.var_bb951ad2d3ad9319.z );
    }
    
    level.fireflyww_settings.drop_to_ground_contents = physics_createcontents( [ "physicscontents_aiclip", "physicscontents_glass", "physicscontents_vehicle", "physicscontents_itemclip", "physicscontents_item" ] );
}

// Namespace weap_fireflyww
// Params 5
// Checksum 0x30c393cc, Offset: 0x121e
// Size: 0xcb
function register_vo_event( event_name, banter_name, play_percentage, cool_down, delay )
{
    level.fireflyww_settings.event_banter[ event_name ][ "banterName" ] = banter_name;
    level.fireflyww_settings.event_banter[ event_name ][ "banterPlayPercentage" ] = play_percentage;
    level.fireflyww_settings.event_banter[ event_name ][ "banterPlayCooldownTime" ] = cool_down;
    level.fireflyww_settings.event_banter[ event_name ][ "delay" ] = delay;
    level.fireflyww_settings.event_banter[ event_name ][ "enabled" ] = 1;
}

// Namespace weap_fireflyww
// Params 1
// Checksum 0xc8893aba, Offset: 0x12f1
// Size: 0x51
function function_256ed8446abc7b49( event_name )
{
    if ( getdvarint( @"hash_6784d7888dccf093", 0 ) )
    {
        return isdefined( level.fireflyww_settings.event_banter[ event_name ] );
    }
    
    return level.fireflyww_settings.event_banter[ event_name ][ "enabled" ];
}

// Namespace weap_fireflyww
// Params 1
// Checksum 0x3acf2579, Offset: 0x134b
// Size: 0xf9
function play_vo_event( event_name )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    event_data = level.fireflyww_settings.event_banter[ event_name ];
    
    if ( !event_data || !function_256ed8446abc7b49( event_name ) )
    {
        return;
    }
    
    always_play = getdvarint( @"hash_6784d7888dccf093", 0 );
    
    if ( !always_play && !utility::percent_chance( event_data[ "banterPlayPercentage" ] ?? 100 ) )
    {
        return;
    }
    
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( event_data[ "delay" ] > 0 )
    {
        wait event_data[ "delay" ];
    }
    
    played = level.fireflyww_settings play_vo_banter( event_name, event_data[ "banterPlayCooldownTime" ], self );
    
    if ( played )
    {
        data = get_fireflyww_player_data();
        data.var_17ca702828b98fc1[ event_name ] = gettime();
    }
}

// Namespace weap_fireflyww
// Params 2, eflags: 0x4
// Checksum 0x46229cc7, Offset: 0x144c
// Size: 0x161
function private on_player_weapon_change( params, weapon_name )
{
    if ( params.weapon.basename == weapon_name )
    {
        data = get_fireflyww_player_data();
        data.is_pap = utility::callsharedfunc( #"zombie", #"get_pap_level", params.weapon ) > 0;
        
        if ( function_256ed8446abc7b49( "fireflyww_first_obtain" ) )
        {
            thread play_vo_event( "fireflyww_first_obtain" );
        }
        else if ( data.is_pap )
        {
            thread play_vo_event( "fireflyww_pap" );
        }
        
        thread function_f352e84e52df9704( weapon_name, data.is_pap );
        thread ww_shared::function_3472b693f638483a( weapon_name, "fireflyww_ambient", function_167413dc0cd8b032() ? function_b6759d5040e13258( "on_no_vfx" ) : function_b6759d5040e13258( "on" ), "off" );
        thread function_4045b358af908c75( params, weapon_name );
        val::set( weapon_name, "autoreload", 0 );
        return;
    }
    
    self notify( "stop_monitor_" + weapon_name + "_state" );
    thread ww_shared::function_50a43e11790d1a15( weapon_name, "fireflyww_ambient", "off" );
    val::set( weapon_name, "allow_reload_without_reserve_ammo", 0 );
    val::set( weapon_name, "allow_reload_when_clip_full", 0 );
    val::set( weapon_name, "autoreload", 1 );
}

// Namespace weap_fireflyww
// Params 2, eflags: 0x4
// Checksum 0xea674ce9, Offset: 0x15b5
// Size: 0x7d
function private function_4045b358af908c75( params, weapon_name )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( "stop_monitor_" + weapon_name + "_state" );
    childthread function_d4ba237422e15ba4( weapon_name );
    childthread function_980c80fce5c43540( weapon_name );
    childthread function_80fac4b4e2140d45( weapon_name );
    childthread function_b711d8e6dc0f228c( weapon_name );
    childthread function_28dd81801939eaf5( weapon_name );
    childthread function_a9f2d40d4d39a73e( weapon_name );
    childthread function_6b97d913c0a08aa9( weapon_name );
}

// Namespace weap_fireflyww
// Params 1, eflags: 0x4
// Checksum 0xe28dca07, Offset: 0x163a
// Size: 0x23e
function private function_9562384d11c0a0fd( dmg_struct )
{
    if ( dmg_struct.biscritical && dmg_struct.smeansofdeath == "MOD_MELEE" )
    {
        dmg_struct.idamage = dmg_struct.idamage / 1.5 * 2;
    }
    
    if ( dmg_struct.smeansofdeath == "MOD_IMPACT" )
    {
        loc = function_406f1f61c1e23012( dmg_struct.partname );
        
        if ( loc )
        {
            dmg_struct.shitloc = loc;
            dmg_struct.metabonename = metabone::get_metabone_name( dmg_struct.shitloc, dmg_struct.partname, dmg_struct.vpoint, dmg_struct.vdir );
            dmg_struct.idamage = zombie_damage::function_f618f57aa5bae72a( dmg_struct );
            
            if ( dmg_struct.biscritical )
            {
                dmg_struct.idamage *= 1.5;
            }
        }
    }
    
    idamage = dmg_struct.idamage;
    
    if ( isplayer( dmg_struct.eattacker ) && dmg_struct.smeansofdeath == "MOD_MELEE" )
    {
        var_951c89546ec50477 = dmg_struct.eattacker utility::callsharedfunc( #"zombie", #"get_pap_level", dmg_struct.objweapon );
        
        switch ( var_951c89546ec50477 )
        {
            default:
                break;
            case 1:
                idamage *= level.fireflyww_settings.var_dc517ba7808f662e;
                break;
            case 2:
                idamage *= level.fireflyww_settings.var_e710e0e2633294bf;
                break;
            case 3:
                idamage *= level.fireflyww_settings.var_445d40b18abcffec;
                break;
            case 4:
                idamage *= level.fireflyww_settings.var_c2e16e0c0d2a3c95;
                break;
        }
    }
    
    return idamage;
}

// Namespace weap_fireflyww
// Params 1, eflags: 0x4
// Checksum 0x3953e4d1, Offset: 0x1881
// Size: 0x1e6
function private function_406f1f61c1e23012( partname )
{
    if ( !level.var_83b0813426ce1bdb )
    {
        map = [];
        map[ #"j_head" ] = "head";
        map[ #"j_neck" ] = "neck";
        map[ #"j_neck2" ] = "neck";
        map[ #"hash_d7380f9cbc886f22" ] = "neck";
        map[ #"j_spinelower" ] = "torso_lower";
        map[ #"j_spinelower_2" ] = "torso_lower";
        map[ #"j_spine4" ] = "torso_lower";
        map[ #"j_spineupper" ] = "torso_upper";
        map[ #"j_spineupper_2" ] = "torso_upper";
        map[ #"j_clavicle_le" ] = "left_arm_upper";
        map[ #"j_shoulder_le" ] = "left_arm_upper";
        map[ #"j_elbow_le" ] = "left_arm_lower";
        map[ #"j_wrist_le" ] = "left_hand";
        map[ #"j_clavicle_ri" ] = "right_arm_upper";
        map[ #"j_shoulder_ri" ] = "right_arm_upper";
        map[ #"j_elbow_ri" ] = "right_arm_lower";
        map[ #"j_wrist_ri" ] = "right_hand";
        map[ #"j_hip_le" ] = "left_leg_upper";
        map[ #"j_knee_le" ] = "left_leg_lower";
        map[ #"j_ankle_le" ] = "left_foot";
        map[ #"j_ball_le" ] = "left_foot";
        map[ #"j_hip_ri" ] = "right_leg_upper";
        map[ #"j_knee_ri" ] = "right_leg_lower";
        map[ #"j_ankle_ri" ] = "right_foot";
        map[ #"j_ball_ri" ] = "right_foot";
        level.var_83b0813426ce1bdb = map;
    }
    
    return level.var_83b0813426ce1bdb[ partname ];
}

// Namespace weap_fireflyww
// Params 4
// Checksum 0xc67234e9, Offset: 0x1a70
// Size: 0x15f
function play_vo_banter( var_5e1c75975eb34ec4, banterPlayCooldownTime = 0, player, var_1c360473c4174a43 )
{
    if ( overlord::function_dce0a14273dfa0a8() || level utility::flag( "overlord_paused" ) )
    {
        return;
    }
    
    if ( !function_256ed8446abc7b49( var_5e1c75975eb34ec4 ) )
    {
        return;
    }
    
    var_3943eb781cc3c6a4 = getdvarint( @"hash_a17c9eea5c534809", 0 );
    
    if ( level utility::flag( "player_banter_playing" ) || !var_3943eb781cc3c6a4 && self.event_banter[ var_5e1c75975eb34ec4 ][ "isBanterCoolingDown" ] )
    {
        return;
    }
    
    var_8984c1f1eeea88ec = self.event_banter[ var_5e1c75975eb34ec4 ][ "banterName" ];
    
    if ( !var_8984c1f1eeea88ec )
    {
        return;
    }
    
    level overlord::function_724ca7b94bf1fb66( 1 );
    
    if ( banterPlayCooldownTime == -1 )
    {
        self.event_banter[ var_5e1c75975eb34ec4 ][ "enabled" ] = 0;
    }
    
    players = isalive( player ) ? [ player ] : level.players;
    var_db75d3de862ce072 = level player_banter::play_banter_vo( var_8984c1f1eeea88ec, players );
    
    if ( !var_db75d3de862ce072 && isalive( player ) && var_1c360473c4174a43 )
    {
        var_db75d3de862ce072 = level battlechatter_mp::trysaylocalsound( player, var_1c360473c4174a43 );
    }
    
    level utility::delaythread( 1, &overlord::function_724ca7b94bf1fb66, 0 );
    thread function_f78882adf70c9b24( var_5e1c75975eb34ec4, var_db75d3de862ce072, banterPlayCooldownTime );
    return var_db75d3de862ce072;
}

// Namespace weap_fireflyww
// Params 3
// Checksum 0x9b836f03, Offset: 0x1bd8
// Size: 0x6a
function function_f78882adf70c9b24( var_5e1c75975eb34ec4, var_db75d3de862ce072, banterPlayCooldownTime )
{
    if ( !getdvarint( @"hash_a17c9eea5c534809", 0 ) && var_db75d3de862ce072 && banterPlayCooldownTime > 0 )
    {
        self.event_banter[ var_5e1c75975eb34ec4 ][ "isBanterCoolingDown" ] = 1;
        wait banterPlayCooldownTime;
        self.event_banter[ var_5e1c75975eb34ec4 ][ "isBanterCoolingDown" ] = 0;
    }
}

// Namespace weap_fireflyww
// Params 1, eflags: 0x4
// Checksum 0x902c76be, Offset: 0x1c4a
// Size: 0x151
function private function_d4ba237422e15ba4( weapon_name )
{
    data = get_fireflyww_player_data();
    data.var_18114bbb17ed3fbc = -1;
    data.var_c59e56a170572af9 = data.var_c59e56a170572af9 ?? 0;
    
    while ( true )
    {
        self waittill( #"missile_fire", projectile, weapon );
        
        if ( projectile.birthtime == data.var_18114bbb17ed3fbc )
        {
            continue;
        }
        
        data.var_18114bbb17ed3fbc = projectile.birthtime;
        
        if ( isdefined( projectile ) && isdefined( weapon ) && ( weapon.basename ?? "" ) == weapon_name )
        {
            params = {};
            params.objweapon = weapon;
            params.projectile = projectile;
            params.player = self;
            callback::callback( "ww_missle_fired", params );
            projectile thread function_b56b9dc4beab6efc( self, projectile.birthtime );
            projectile thread function_ed94b371ea03ceff( self, weapon );
            projectile thread function_60a61bf3fa6336fb( self, weapon );
            projectile thread function_d9a5f9a89a091d20( self, weapon );
            projectile thread function_10700076c9984d5a( self, weapon );
        }
    }
}

// Namespace weap_fireflyww
// Params 2, eflags: 0x4
// Checksum 0x35c70c, Offset: 0x1da3
// Size: 0xf6
function private function_b56b9dc4beab6efc( attacker, birth_time )
{
    level endon( #"game_ended" );
    attacker endon( #"death_or_disconnect" );
    self waittill( #"death" );
    data = attacker get_fireflyww_player_data();
    
    if ( isarray( data.handled_projectiles ) && arraycontains( data.handled_projectiles, birth_time ) )
    {
        data.handled_projectiles = arrayremove( data.handled_projectiles, birth_time );
    }
    
    if ( isarray( data.pin_infos ) && isdefined( data.pin_infos[ birth_time ] ) )
    {
        data.pin_infos[ birth_time ].var_164183d729ab3306 = undefined;
        data.pin_infos[ birth_time ].var_546b525470d474ab = undefined;
        data.pin_infos[ birth_time ] = undefined;
    }
}

// Namespace weap_fireflyww
// Params 2, eflags: 0x4
// Checksum 0x70a7b721, Offset: 0x1ea1
// Size: 0x110
function private function_ed94b371ea03ceff( attacker, weapon )
{
    self endon( #"death" );
    attacker endon( #"death_or_disconnect" );
    frame_duration = level.framedurationseconds ?? 0.05;
    var_3c7648720e2ce6ea = squared( level.fireflyww_settings.var_6e45d8cfdf28c3c + 100 );
    
    while ( true )
    {
        if ( isdefined( self.origin ) && distancesquared( self.origin, attacker.origin ) > var_3c7648720e2ce6ea )
        {
            script_model = spawn( "script_model", self.origin );
            script_model.angles = self.angles;
            script_model setmodel( "wpn_sat_wm_ww_firefly_spike" );
            script_model.owner = self.owner;
            script_model thread function_a37a744a04a7b209( 0.02, 1 );
            destroy_projectile();
            break;
        }
        
        waitframe();
    }
}

// Namespace weap_fireflyww
// Params 2, eflags: 0x4
// Checksum 0x2fa5f3a0, Offset: 0x1fb9
// Size: 0x141
function private function_60a61bf3fa6336fb( attacker, weapon )
{
    self endon( #"delay_death" );
    childthread delay_endon( "death" );
    attacker endon( #"death_or_disconnect" );
    
    if ( !isdefined( attacker.team ) )
    {
        return;
    }
    
    while ( true )
    {
        self waittill( #"projectile_impact_ai", ai );
        
        if ( ai.team == attacker.team )
        {
            continue;
        }
        
        pin_info = attacker function_bd73336417b102ab( self.birthtime );
        
        foreach ( info in pin_info.var_164183d729ab3306 )
        {
            if ( ai == info.victim )
            {
                var_474320c0f46048f0 = info;
                break;
            }
        }
        
        thread function_cda638b005341205( ai, attacker, weapon, var_474320c0f46048f0 );
    }
}

// Namespace weap_fireflyww
// Params 4, eflags: 0x4
// Checksum 0xeb9aacf8, Offset: 0x2102
// Size: 0x1f5
function private function_cda638b005341205( ai, attacker, weapon, var_474320c0f46048f0 )
{
    self endon( #"death" );
    self.penetration_count = ( self.penetration_count ?? 0 ) + 1;
    
    if ( self.penetration_count == level.fireflyww_settings.var_40f0980a5fdc6c4d )
    {
        if ( isalive( ai ) )
        {
            ai zombie_stun::stun_ai( level.fireflyww_settings.var_6b71bd2951eccdb8 ?? 1 );
            function_e433ce330de5ef4( attacker, self.origin, self.angles, ai, var_474320c0f46048f0.partname ?? "j_spineupper" );
            destroy_projectile();
        }
    }
    else if ( ai.aicategory == "boss" || self.penetration_count > level.fireflyww_settings.var_40f0980a5fdc6c4d )
    {
        [ bound_radius ] = ai getboundshalfsize();
        function_e433ce330de5ef4( attacker, self.origin + anglestoforward( self.angles ) * bound_radius * -1, self.angles, undefined );
        destroy_projectile();
    }
    
    if ( self.penetration_count <= level.fireflyww_settings.var_40f0980a5fdc6c4d && !isalive( ai ) )
    {
        if ( ai.subclass == "zombie_base" || ai.subclass == "zombie_base_armored_light" || ai.subclass == "zombie_base_armored_heavy" )
        {
            is_pinned = function_3a0144540bf0f272( ai, attacker, weapon );
            
            if ( !is_pinned )
            {
                thread function_9291f5d4eff972b8( ai, attacker );
            }
            
            return;
        }
        
        thread function_9291f5d4eff972b8( ai, attacker );
    }
}

// Namespace weap_fireflyww
// Params 2, eflags: 0x4
// Checksum 0xe863117b, Offset: 0x22ff
// Size: 0x77
function private function_d9a5f9a89a091d20( attacker, weapon )
{
    self endon( #"delay_death" );
    childthread delay_endon( "death" );
    attacker endon( #"death_or_disconnect" );
    self waittill( #"projectile_impact_vehicle", vehicle );
    function_e433ce330de5ef4( attacker, self.origin, self.angles, vehicle );
    destroy_projectile();
}

// Namespace weap_fireflyww
// Params 2, eflags: 0x4
// Checksum 0xa8431a09, Offset: 0x237e
// Size: 0x448
function private function_10700076c9984d5a( attacker, weapon )
{
    self endon( #"delay_death" );
    childthread delay_endon( "death" );
    attacker endon( #"death_or_disconnect" );
    self waittill( #"missile_stuck", stuckto, stuckpart, surfacetype, velocity, position, normal );
    
    if ( !stuckto && !surfacetype )
    {
        var_dbee783948bfc8df = 1000;
        var_b5189f2dbb1c7b56 = getaiarrayinradius( position, var_dbee783948bfc8df );
        
        foreach ( ai in var_b5189f2dbb1c7b56 )
        {
            if ( ai.aicategory == "boss" )
            {
                clip = { #origin:position };
                function_6c4980ae7e17439c( clip, attacker, velocity, position, normal );
                return;
            }
        }
    }
    
    if ( stuckto.owner.origin && stuckto.owner.aicategory && stuckto.owner.aicategory == "boss" )
    {
        function_6c4980ae7e17439c( stuckto, attacker, velocity, position, normal );
        return;
    }
    
    stuck_position = position - normal;
    spawn_position = position;
    link_target = undefined;
    nearby_scriptables = getentitylessscriptablearray( undefined, undefined, position, 16 );
    
    foreach ( scriptable in nearby_scriptables )
    {
        if ( scriptable.var_110cede20771938 )
        {
            link_target = scriptable.var_110cede20771938;
            spawn_position = function_858f56f250980678( position, link_target );
            break;
        }
        
        if ( scriptable.owner && scriptable.owner.var_110cede20771938 )
        {
            link_target = scriptable.owner.var_110cede20771938;
            spawn_position = function_858f56f250980678( position, link_target );
            break;
        }
    }
    
    if ( !link_target )
    {
        link_target = utility::spawn_script_origin( position, normal );
    }
    
    grenade = function_e433ce330de5ef4( attacker, spawn_position, vectortoangles( velocity ), link_target );
    
    if ( !grenade )
    {
        if ( link_target && link_target.classname == "script_origin" )
        {
            link_target delete();
        }
        
        destroy_projectile();
        return;
    }
    
    grenade.normal = normal;
    impact_fx = spawnscriptable( "scriptable_ww_firefly_impact", position, vectortoangles( normal ) );
    impact_fx utility::function_7c10ea82c1e305b8( "impact", attacker function_b6759d5040e13258( "impact_decal" ) );
    grenade.script_model.impact_fx = impact_fx;
    
    if ( is_wall_surface( normal ) )
    {
        data = attacker get_fireflyww_player_data();
        pin_info = attacker function_bd73336417b102ab( self.birthtime );
        
        if ( isdefined( pin_info.var_546b525470d474ab ) )
        {
            pin_info.var_546b525470d474ab.var_9093d7db187499fc = stuck_position + normal * 8;
            pin_info.var_546b525470d474ab.var_e4bb4059ae1c7935 = grenade.script_model;
        }
    }
    else if ( is_floor_surface( normal ) && grenade.script_model isscriptable() )
    {
        impact_fx utility::function_7c10ea82c1e305b8( "impact_floor", attacker function_b6759d5040e13258( "on" ) );
    }
    
    destroy_projectile( 0.1 );
}

// Namespace weap_fireflyww
// Params 1, eflags: 0x4
// Checksum 0x58867cf8, Offset: 0x27ce
// Size: 0x26
function private destroy_projectile( destruction_delay )
{
    if ( isnumber( destruction_delay ) )
    {
        wait destruction_delay;
    }
    else
    {
        waittillframeend();
    }
    
    if ( self )
    {
        self delete();
    }
}

// Namespace weap_fireflyww
// Params 5, eflags: 0x4
// Checksum 0x4235fce8, Offset: 0x27fc
// Size: 0x2f0
function private function_e433ce330de5ef4( attacker, spawn_position, angles, link_target, var_4a12e33cf5ced339 )
{
    assert( isdefined( level.fireflyww_settings.liquid_grenade_weapon ), "<dev string:x24>" );
    
    if ( !isdefined( attacker ) )
    {
        return;
    }
    
    liquid_grenade_name = level.fireflyww_settings.liquid_grenade_weapon;
    liquid_grenade = attacker weapon::_launchgrenade( liquid_grenade_name, spawn_position, ( 0, 0, 0 ) );
    
    if ( !liquid_grenade )
    {
        assertmsg( "<dev string:x96>" );
        logstring( "Failed to spawn liquid grenade for Necrofluid Gauntlet" );
        return;
    }
    
    liquid_grenade hide();
    liquid_grenade.var_9eb0e951b21fa1ff = 1;
    attacker weapons::grenadeinitialize( liquid_grenade, makeweapon( liquid_grenade_name ), undefined, attacker );
    liquid_grenade.angles = angles;
    script_model = spawn( "script_model", liquid_grenade.origin );
    script_model.angles = angles;
    script_model linkto( liquid_grenade );
    script_model setmodel( liquid_grenade.owner function_b6759d5040e13258( "wpn_sat_wm_ww_firefly_spike" ) );
    script_model.hit_count = int( min( self.penetration_count ?? 0, level.fireflyww_settings.var_40f0980a5fdc6c4d ?? 3 ) );
    liquid_grenade.script_model = script_model;
    
    if ( link_target )
    {
        if ( var_4a12e33cf5ced339 && link_target tagexists( var_4a12e33cf5ced339 ) )
        {
            forward_offset = function_e453f431549cfa0f( link_target.subclass );
            liquid_grenade.origin += anglestoforward( liquid_grenade.angles ) * forward_offset;
            liquid_grenade linkto( link_target, var_4a12e33cf5ced339 );
        }
        else
        {
            liquid_grenade linkto( link_target );
        }
        
        liquid_grenade.linked_entity = link_target;
        liquid_grenade thread function_cd056ad0018e5936( link_target );
    }
    
    if ( script_model isscriptable() )
    {
        script_model utility::function_7c10ea82c1e305b8( "vfx", liquid_grenade.owner function_b6759d5040e13258( "active" ) );
        script_model hudoutlineenableforclient( liquid_grenade.owner, liquid_grenade.owner function_b6759d5040e13258( "outline_ww_firefly_spike" ) );
    }
    
    data = liquid_grenade.owner get_fireflyww_player_data();
    
    if ( !isdefined( data.handled_projectiles ) )
    {
        data.handled_projectiles = [];
    }
    
    data.handled_projectiles[ data.handled_projectiles.size ] = self.birthtime;
    
    if ( !isdefined( data.var_cbe730c624b3fc11 ) )
    {
        data.var_cbe730c624b3fc11 = [];
    }
    
    data.var_cbe730c624b3fc11[ data.var_cbe730c624b3fc11.size ] = liquid_grenade;
    return liquid_grenade;
}

// Namespace weap_fireflyww
// Params 1, eflags: 0x4
// Checksum 0x92147ca1, Offset: 0x2af5
// Size: 0x99
function private function_e453f431549cfa0f( subclass )
{
    if ( issubstr( subclass, "zombie_base" ) )
    {
        offset = 3;
    }
    else if ( issubstr( subclass, "zombie_callisto" ) )
    {
        offset = 10;
    }
    else if ( issubstr( subclass, "zombie_shade" ) )
    {
        offset = 3;
    }
    else if ( issubstr( subclass, "zombie_viper" ) )
    {
        offset = 6;
    }
    else if ( issubstr( subclass, "zombie_ghoul" ) )
    {
        offset = 3;
    }
    else if ( issubstr( subclass, "zombie_mimic" ) )
    {
        offset = 4;
    }
    else
    {
        offset = 0;
    }
    
    return offset;
}

// Namespace weap_fireflyww
// Params 1, eflags: 0x4
// Checksum 0xcbd663ce, Offset: 0x2b97
// Size: 0x56
function private function_cd056ad0018e5936( linked_entity )
{
    level endon( #"game_ended" );
    self endon( #"explode" );
    self endon( #"death" );
    linked_entity utility::waittill_any( "death", "shadow_vortex_lethal_teleport_start", "on_dismembered" );
    
    if ( self islinked() )
    {
        self unlink();
    }
}

// Namespace weap_fireflyww
// Params 1, eflags: 0x4
// Checksum 0x4969e880, Offset: 0x2bf5
// Size: 0x26f
function private function_17fdfda41f9aa95a( dmg_struct )
{
    if ( dmg_struct.sweapon.basename == level.fireflyww_basename )
    {
        if ( dmg_struct.biscritical && dmg_struct.smeansofdeath != "MOD_MELEE" )
        {
            dmg_struct.eattacker thread play_vo_event( "fireflyww_spike_shot" );
        }
        
        if ( dmg_struct.smeansofdeath == "MOD_MELEE" )
        {
            dmg_struct.eattacker thread play_vo_event( "fireflyww_melee" );
            
            if ( zombie_dismemberment::is_dismemberment_allowed() )
            {
                if ( utility::percent_chance( 50 ) )
                {
                    thread zombie_dismemberment::function_14463e39cc414bab( self.health <= dmg_struct.idamage );
                }
            }
            
            if ( dmg_struct.eattacker )
            {
                var_f288afb4572c3cdc = health_overcharge::function_f6da758a8ee4c988( dmg_struct.eattacker, level.fireflyww_basename, 10 );
                
                if ( var_f288afb4572c3cdc )
                {
                    dmg_struct.eattacker thread function_1ddca3b97638423a();
                }
            }
            
            return dmg_struct.idamage;
        }
        
        if ( ( dmg_struct.einflictor.penetration_count ?? -1 ) >= ( level.fireflyww_settings.var_40f0980a5fdc6c4d ?? 3 ) )
        {
            dmg_struct.var_d20799805edf0194 = 1;
            return 0;
        }
        else if ( isnumber( dmg_struct.einflictor.birthtime ) && dmg_struct.eattacker )
        {
            info = { #victim:self, #partname:dmg_struct.partname, #shitloc:dmg_struct.shitloc };
            pin_info = dmg_struct.eattacker function_bd73336417b102ab( dmg_struct.einflictor.birthtime );
            
            if ( !isdefined( pin_info.var_164183d729ab3306 ) )
            {
                pin_info.var_164183d729ab3306 = [];
            }
            
            pin_info.var_164183d729ab3306[ pin_info.var_164183d729ab3306.size ] = info;
            function_8998cfa9b1d75620( dmg_struct );
            return dmg_struct.idamage;
        }
        else
        {
            function_8998cfa9b1d75620( dmg_struct );
            return dmg_struct.idamage;
        }
        
        return;
    }
    
    return dmg_struct.idamage;
}

// Namespace weap_fireflyww
// Params 1, eflags: 0x4
// Checksum 0xc60741bd, Offset: 0x2e6c
// Size: 0xba
function private function_8c5e06ee1e60aeb7( params )
{
    if ( params.sweapon.basename != level.fireflyww_basename )
    {
        return;
    }
    
    if ( isplayer( params.eattacker ) && params.smeansofdeath == "MOD_MELEE" )
    {
        data = params.eattacker get_fireflyww_player_data();
        var_93b725d43e85a099 = data.var_6dcd4bd1d51a6063[ "fireflyww_melee_kill" ];
        
        if ( !var_93b725d43e85a099 || var_93b725d43e85a099 - gettime() > 5000 )
        {
            params.eattacker thread play_vo_event( "fireflyww_melee_kill" );
        }
    }
}

// Namespace weap_fireflyww
// Params 5, eflags: 0x4
// Checksum 0x6b63731, Offset: 0x2f2e
// Size: 0x83
function private function_6c4980ae7e17439c( clip, attacker, velocity, position, normal )
{
    stuck_position = position - normal;
    var_53680063ab708c7d = ( clip.origin + stuck_position ) * 0.5;
    function_e433ce330de5ef4( attacker, var_53680063ab708c7d, vectortoangles( normal * -1 ), clip.owner );
    destroy_projectile();
}

// Namespace weap_fireflyww
// Params 2, eflags: 0x4
// Checksum 0x640e564c, Offset: 0x2fb9
// Size: 0x47
function private function_858f56f250980678( impact_position, link_target )
{
    if ( !isent( link_target ) )
    {
        return impact_position;
    }
    
    var_da20088ae67ad678 = vectornormalize( link_target.origin - impact_position );
    return impact_position + var_da20088ae67ad678 * 8;
}

// Namespace weap_fireflyww
// Params 1, eflags: 0x4
// Checksum 0x5e7a0a0, Offset: 0x3009
// Size: 0x1b8
function private function_a5855cb20d635c85( dmg_struct )
{
    idamage = dmg_struct.idamage;
    
    if ( isplayer( dmg_struct.eattacker ) )
    {
        foreach ( var_ab85e333d7ea3be0 in dmg_struct.eattacker getweaponslistprimaries() )
        {
            if ( var_ab85e333d7ea3be0.basename == level.fireflyww_basename )
            {
                ww = var_ab85e333d7ea3be0;
                break;
            }
        }
        
        if ( ww )
        {
            var_951c89546ec50477 = dmg_struct.eattacker utility::callsharedfunc( #"zombie", #"get_pap_level", ww );
            
            switch ( var_951c89546ec50477 )
            {
                default:
                    break;
                case 1:
                    idamage *= level.fireflyww_settings.var_ae25c5d56adefe79;
                    break;
                case 2:
                    idamage *= level.fireflyww_settings.var_97164a5f0dfd86dc;
                    break;
                case 3:
                    idamage *= level.fireflyww_settings.var_204feab99962ffef;
                    break;
                case 4:
                    idamage *= level.fireflyww_settings.var_734e94209fa548aa;
                    break;
            }
        }
    }
    
    return idamage;
}

// Namespace weap_fireflyww
// Params 11, eflags: 0x4
// Checksum 0x4a2a8111, Offset: 0x31ca
// Size: 0xc6
function private on_scriptable_damaged( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( objweapon.basename == level.fireflyww_basename && instance.origin && isnumber( instance.health ) && instance.health <= idamage )
    {
        eattacker thread function_6d2c8966a92cb950( instance.origin );
    }
}

// Namespace weap_fireflyww
// Params 1, eflags: 0x4
// Checksum 0xd7313ed6, Offset: 0x3298
// Size: 0xf5
function private function_6d2c8966a92cb950( impact_location )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    wait 0.1;
    
    if ( self )
    {
        data = get_fireflyww_player_data();
        
        foreach ( var_6340de0fa276cd8 in data.var_cbe730c624b3fc11 )
        {
            if ( !var_6340de0fa276cd8.var_c29d8da28257782b && var_6340de0fa276cd8.linked_entity && distancesquared( impact_location, var_6340de0fa276cd8.origin ) <= 4096 )
            {
                var_6340de0fa276cd8.var_c29d8da28257782b = 1;
            }
        }
    }
}

// Namespace weap_fireflyww
// Params 1, eflags: 0x4
// Checksum 0x5ccd6b98, Offset: 0x3395
// Size: 0x146
function private function_8998cfa9b1d75620( dmg_struct )
{
    if ( dmg_struct.idamage > 0 && dmg_struct.smeansofdeath == "MOD_IMPACT" )
    {
        if ( isvector( dmg_struct.vpoint ) && isvector( dmg_struct.vdir ) && dmg_struct.eattacker )
        {
            var_2e11e0d472add032 = spawnscriptable( "scriptable_ww_firefly_impact", dmg_struct.vpoint, vectortoangles( dmg_struct.vdir * -1 ) );
            var_2e11e0d472add032 utility::function_7c10ea82c1e305b8( "impact", dmg_struct.eattacker function_b6759d5040e13258( "impact_ai" ) );
            var_2e11e0d472add032 utility::delaycall( 2, &freescriptable );
            return;
        }
        
        if ( dmg_struct.partname && self tagexists( "j_spine4" ) && dmg_struct.eattacker )
        {
            var_2e11e0d472add032 = spawnscriptable( "scriptable_ww_firefly_impact", self gettagorigin( "j_spine4" ), self gettagangles( "j_spine4" ) );
            var_2e11e0d472add032 utility::function_7c10ea82c1e305b8( "impact", dmg_struct.eattacker function_b6759d5040e13258( "impact_ai" ) );
            var_2e11e0d472add032 utility::delaycall( 2, &freescriptable );
        }
    }
}

// Namespace weap_fireflyww
// Params 3, eflags: 0x4
// Checksum 0x37bde67c, Offset: 0x34e3
// Size: 0x400, Type: bool
function private function_3a0144540bf0f272( ai, attacker, weapon )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    attacker endon( #"death_or_disconnect" );
    data = attacker get_fireflyww_player_data();
    pin_info = attacker function_bd73336417b102ab( self.birthtime );
    damage_infos = pin_info.var_164183d729ab3306;
    
    if ( !isdefined( pin_info.target_wall_info ) )
    {
        all_result = trace::ray_trace_get_all_results( self.origin, self.origin + ( level.fireflyww_settings.var_6e45d8cfdf28c3c ?? 1200 ) * anglestoforward( self.angles ), [ ai, attacker ] );
        
        foreach ( result in all_result )
        {
            if ( result[ "hittype" ] == "hittype_world" )
            {
                pin_info.target_wall_info = result;
                break;
            }
        }
        
        if ( isdefined( pin_info.target_wall_info ) )
        {
            pin_info.is_hit_wall = is_wall_surface( pin_info.target_wall_info[ "normal" ] );
        }
        else
        {
            pin_info.is_hit_wall = 0;
        }
    }
    
    if ( isarray( damage_infos ) )
    {
        for ( i = 0; i < damage_infos.size ; i++ )
        {
            if ( i == ( self.penetration_count ?? -1 ) - 1 )
            {
                info = damage_infos[ i ];
                break;
            }
        }
    }
    
    if ( !isdefined( info ) )
    {
        return false;
    }
    
    if ( !pin_info.is_hit_wall )
    {
        return false;
    }
    
    if ( distancesquared( self.origin, pin_info.target_wall_info[ "position" ] ) > squared( level.fireflyww_settings.var_cd421d1f5bcd59e4 ) )
    {
        return false;
    }
    
    corpse = ai getcorpseentity();
    
    if ( !isdefined( corpse ) )
    {
        return false;
    }
    
    hitloc = get_projectile_impact_location( attacker );
    
    if ( !isdefined( info.partname ) || !corpse tagexists( info.partname ) )
    {
        if ( corpse tagexists( "j_spineupper" ) )
        {
            info.partname = "j_spineupper";
        }
        else
        {
            return false;
        }
    }
    
    bone = info.partname;
    corpse endon( #"death" );
    corpse function_dd258a3da9a2b4a1( 86400 );
    corpse startragdoll();
    waittillframeend();
    
    if ( !isdefined( pin_info.var_546b525470d474ab ) )
    {
        pin_info.var_546b525470d474ab = utility::spawn_tag_origin( corpse.origin + ( 0, 0, 60 ), corpse.angles );
    }
    
    mover = pin_info.var_546b525470d474ab;
    mover function_dda92e5e52815f46( 0 );
    constraint = spawnragdollconstraint( corpse, hitloc, bone, ( 0, 0, 0 ), 0 );
    constraint.origin = mover.origin;
    constraint.angles = mover.angles;
    constraint linkto( mover );
    mover.corpse = corpse;
    mover.constraint = constraint;
    
    if ( !isdefined( mover.projectile ) )
    {
        mover.projectile = self;
        mover thread function_2df79f707720badd( attacker );
    }
    
    return true;
}

// Namespace weap_fireflyww
// Params 2, eflags: 0x4
// Checksum 0x565746e3, Offset: 0x38ec
// Size: 0xfd
function private function_9291f5d4eff972b8( ai, attacker )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    attacker endon( #"death_or_disconnect" );
    corpse = ai getcorpseentity();
    centroid = ai getcentroid();
    
    if ( !isdefined( corpse ) || !isvector( centroid ) )
    {
        return;
    }
    
    v_dir = vectornormalize( centroid - self.origin );
    launchx = clamp( v_dir[ 0 ] * 5000, -8000, 8000 );
    launchy = clamp( v_dir[ 1 ] * 5000, -8000, 8000 );
    launchz = clamp( ( v_dir[ 2 ] + 150 ) * 1500, 0, 4000 );
    v_launch = ( launchx, launchy, launchz );
    corpse startragdollfromimpact( get_projectile_impact_location( attacker ), v_launch );
}

// Namespace weap_fireflyww
// Params 1, eflags: 0x4
// Checksum 0xe3d06b36, Offset: 0x39f1
// Size: 0xec
function private get_projectile_impact_location( attacker )
{
    pin_info = attacker function_bd73336417b102ab( self.birthtime );
    damage_infos = pin_info.var_164183d729ab3306;
    
    if ( isarray( damage_infos ) )
    {
        for ( i = 0; i < damage_infos.size ; i++ )
        {
            if ( i == ( self.penetration_count ?? -1 ) - 1 )
            {
                info = damage_infos[ i ];
                break;
            }
        }
    }
    
    if ( isdefined( info ) )
    {
        return info.shitloc;
    }
    
    hitlocs = [ "head", "left_arm_upper", "right_arm_upper", "left_leg_upper", "right_leg_upper" ];
    index = randomintrange( 0, hitlocs.size );
    return hitlocs[ index ];
}

// Namespace weap_fireflyww
// Params 1, eflags: 0x4
// Checksum 0xc3a50ffa, Offset: 0x3ae5
// Size: 0x17f
function private function_2df79f707720badd( attacker )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    frame_duration = level.framedurationseconds ?? 0.05;
    var_3c7648720e2ce6ea = squared( level.fireflyww_settings.var_6e45d8cfdf28c3c );
    
    while ( true )
    {
        if ( isdefined( self.var_9093d7db187499fc ) )
        {
            break;
        }
        
        if ( isdefined( self.projectile.origin ) && distancesquared( self.projectile.origin, attacker.origin ) <= var_3c7648720e2ce6ea )
        {
            self moveto( self.projectile.origin, frame_duration );
        }
        else
        {
            function_dda92e5e52815f46( 0 );
            break;
        }
        
        wait frame_duration;
    }
    
    if ( isdefined( self.var_9093d7db187499fc ) )
    {
        self moveto( self.var_9093d7db187499fc, frame_duration );
        self waittill( #"movedone" );
        
        if ( isdefined( self.var_e4bb4059ae1c7935 ) && isdefined( self.corpse ) && isdefined( self.constraint ) )
        {
            self.var_e4bb4059ae1c7935 function_f34645d74874bc1e( self.corpse, self.constraint );
            attacker function_ee1bc18c858fbf68( self.var_e4bb4059ae1c7935, 1 );
        }
        else
        {
            function_dda92e5e52815f46( 0 );
        }
    }
    
    self delete();
}

// Namespace weap_fireflyww
// Params 2, eflags: 0x4
// Checksum 0xec6e62fe, Offset: 0x3c6c
// Size: 0x43
function private function_f34645d74874bc1e( corpse, constraint )
{
    self.corpse = corpse;
    
    if ( constraint islinked() )
    {
        constraint unlink();
    }
    
    constraint linkto( self );
    self.constraint = constraint;
}

// Namespace weap_fireflyww
// Params 1, eflags: 0x4
// Checksum 0x5498e2a2, Offset: 0x3cb7
// Size: 0x7d
function private function_dda92e5e52815f46( keep_corpse )
{
    if ( !keep_corpse && isdefined( self.corpse ) )
    {
        self.corpse function_dd258a3da9a2b4a1( 20 );
        self.corpse = undefined;
    }
    
    if ( isdefined( self.constraint ) )
    {
        if ( self.constraint islinked() )
        {
            self.constraint unlink();
        }
        
        self.constraint delete();
        self.constraint = undefined;
    }
}

// Namespace weap_fireflyww
// Params 2, eflags: 0x4
// Checksum 0xe98e7c3c, Offset: 0x3d3c
// Size: 0x12c
function private function_ee1bc18c858fbf68( pinned_tag, is_add = 1 )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    data = get_fireflyww_player_data();
    
    if ( is_add )
    {
        if ( !isdefined( data.pinned_enemies ) )
        {
            data.pinned_enemies = [];
        }
        
        data.pinned_enemies[ data.pinned_enemies.size ] = pinned_tag;
    }
    else
    {
        pinned_tag function_dda92e5e52815f46( 0 );
        
        if ( isarray( data.pinned_enemies ) && arraycontains( data.pinned_enemies, pinned_tag ) )
        {
            data.pinned_enemies = arrayremove( data.pinned_enemies, pinned_tag );
        }
    }
    
    while ( data.pinned_enemies.size > ( level.fireflyww_settings.var_e58354164df1c698 ?? 2 ) )
    {
        var_957239c53a8147b = data.pinned_enemies[ 0 ];
        var_957239c53a8147b function_dda92e5e52815f46( 0 );
        data.pinned_enemies = arrayremove( data.pinned_enemies, var_957239c53a8147b );
    }
}

// Namespace weap_fireflyww
// Params 1, eflags: 0x4
// Checksum 0xf104489, Offset: 0x3e70
// Size: 0xec
function private function_980c80fce5c43540( weapon_name )
{
    data = get_fireflyww_player_data();
    data.var_9e67629c55e126b9 = -1;
    
    while ( true )
    {
        self waittill( #"weapon_fired", weapon, muzzle_trace, bullet_angles, server_time );
        
        if ( ( weapon.basename ?? "" ) == weapon_name && weapon.isalternate && weapon.type == "bullet" )
        {
            if ( server_time == data.var_9e67629c55e126b9 )
            {
                continue;
            }
            
            data.var_9e67629c55e126b9 = server_time;
            
            if ( data.is_pap )
            {
                function_93591513280bed6d( weapon );
                thread play_vo_event( "fireflyww_overload" );
            }
        }
        
        waitframe();
    }
}

// Namespace weap_fireflyww
// Params 1, eflags: 0x4
// Checksum 0xcb6860dd, Offset: 0x3f64
// Size: 0x7f
function private function_80fac4b4e2140d45( weapon_name )
{
    data = get_fireflyww_player_data();
    data.var_3c31e8277948f206 = 0;
    
    while ( true )
    {
        if ( self isreloading() )
        {
            if ( !data.var_3c31e8277948f206 )
            {
                data.var_3c31e8277948f206 = 1;
                thread function_6675c4cfd0ef61e0( weapon_name );
            }
            
            waitframe();
            continue;
        }
        
        data.var_3c31e8277948f206 = 0;
        self waittill( #"reload_start" );
    }
}

// Namespace weap_fireflyww
// Params 0, eflags: 0x4
// Checksum 0xecf1bbb, Offset: 0x3feb
// Size: 0xa0
function private function_9118bc662bf7289d()
{
    var_ff8660614263732d = level.fireflyww_settings.var_f2c4e1253303bede ?? 1;
    
    if ( utility::callsharedfunc( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb", "specialty_speedcola" ) )
    {
        if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"speedcola_classic_formula" ) )
        {
            var_ff8660614263732d *= getdvarfloat( @"hash_855fb39cd1353312", 0.5 );
        }
        else
        {
            var_ff8660614263732d *= getdvarfloat( @"perk_weapreloadmultiplierzombies", 0.7 );
        }
    }
    
    return var_ff8660614263732d;
}

// Namespace weap_fireflyww
// Params 1, eflags: 0x4
// Checksum 0x3648d37a, Offset: 0x4094
// Size: 0x170
function private function_6675c4cfd0ef61e0( weapon_name )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( "stop_monitor_" + weapon_name + "_state" );
    self endon( #"weapon_fired" );
    self endon( #"melee_fired" );
    wait function_9118bc662bf7289d();
    data = get_fireflyww_player_data();
    
    if ( self.currentweapon.basename != weapon_name )
    {
        return;
    }
    
    var_d9885159568a1399 = 0;
    
    foreach ( var_6340de0fa276cd8 in data.var_cbe730c624b3fc11 )
    {
        if ( isdefined( var_6340de0fa276cd8 ) && !var_6340de0fa276cd8.var_2ad511590a4f71c1 )
        {
            var_d9885159568a1399 = 1;
            break;
        }
    }
    
    childthread function_4b396e997a3479da();
    
    if ( data.var_c59e56a170572af9 > 0 )
    {
        var_c59e56a170572af9 = data.var_c59e56a170572af9;
        data.var_c59e56a170572af9 = 0;
        var_d9885159568a1399 = 1;
    }
    
    if ( isnumber( var_c59e56a170572af9 ) )
    {
        thread function_5bf9e25adcf5cd49( var_c59e56a170572af9, self.currentweapon );
    }
}

// Namespace weap_fireflyww
// Params 1, eflags: 0x4
// Checksum 0x718b940f, Offset: 0x420c
// Size: 0x152
function private function_4b396e997a3479da( b_skip_vo )
{
    data = get_fireflyww_player_data();
    data.life_stolen = undefined;
    
    while ( data.var_cbe730c624b3fc11.size > 0 )
    {
        foreach ( var_6340de0fa276cd8 in data.var_cbe730c624b3fc11 )
        {
            if ( isdefined( var_6340de0fa276cd8 ) && !var_6340de0fa276cd8.var_2ad511590a4f71c1 )
            {
                var_6340de0fa276cd8.var_2ad511590a4f71c1 = 1;
                var_6340de0fa276cd8 thread function_3b6d546f3899c8cd( 0, self.currentweapon );
                data.var_cbe730c624b3fc11 = arrayremove( data.var_cbe730c624b3fc11, var_6340de0fa276cd8 );
                break;
            }
        }
        
        wait_time = level.fireflyww_settings.var_8e1cb193ae553ee0 ?? 0.2;
        wait wait_time;
    }
    
    if ( !b_skip_vo && !data.life_stolen )
    {
        thread play_vo_event( "fireflyww_spike_recall" );
    }
}

// Namespace weap_fireflyww
// Params 3, eflags: 0x4
// Checksum 0xecf95032, Offset: 0x4366
// Size: 0x16a
function private function_3b6d546f3899c8cd( wait_time, weapon_object, is_script_model = 0 )
{
    level endon( #"game_ended" );
    self endon( #"explode" );
    self endon( #"delay_death" );
    childthread delay_endon( "death" );
    wait wait_time;
    
    if ( isdefined( self ) )
    {
        if ( is_script_model )
        {
            script_model = self;
        }
        else
        {
            script_model = function_312858579fed8dea( self );
        }
        
        player = self.owner;
        
        if ( player )
        {
            if ( script_model isscriptable() )
            {
                script_model utility::function_7c10ea82c1e305b8( "vfx", player function_b6759d5040e13258( "trail" ) );
                script_model utility::function_7c10ea82c1e305b8( "fx_aux", player function_b6759d5040e13258( "back_trace" ) );
                
                if ( script_model.impact_fx && script_model.impact_fx isscriptableinstance() )
                {
                    script_model.impact_fx utility::function_7c10ea82c1e305b8( "impact", player function_b6759d5040e13258( "impact_decal_death" ) );
                    script_model.impact_fx utility::function_32b24db3127bff40( "impact_floor", "off" );
                    script_model.impact_fx utility::delaycall( 10, &freescriptable );
                }
            }
            
            player function_ee1bc18c858fbf68( script_model, 0 );
            script_model thread function_b46ae87d622ca49b( player, weapon_object, self.linked_entity );
        }
    }
}

// Namespace weap_fireflyww
// Params 3, eflags: 0x4
// Checksum 0xfcab39c, Offset: 0x44d8
// Size: 0x10a
function private function_b46ae87d622ca49b( owner, weapon_object, linked_entity )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    travel_time = level.fireflyww_settings.var_1213342b0ba595bb ?? 0.5;
    destination = function_ce437aa15730b74f( owner );
    
    if ( isdefined( destination ) )
    {
        thread function_1764371df02fc41c( travel_time, owner );
        thread function_3122e668cbf566aa( owner );
        level thread function_f41321946425d113( self, self.origin, destination, travel_time * 0.5, owner, linked_entity, weapon_object );
        thread function_768c2519f0fda4d1( destination, travel_time, gettime() );
        self waittill( #"movedone" );
        
        if ( owner && isalive( owner ) )
        {
            owner adjust_ammo( weapon_object, level.fireflyww_settings.var_86ecc59db88c9f10 ?? 1 );
        }
        
        waitframe();
        
        if ( isdefined( self ) )
        {
            self delete();
        }
        
        return;
    }
    
    thread function_a37a744a04a7b209();
}

// Namespace weap_fireflyww
// Params 2, eflags: 0x4
// Checksum 0x4fd76776, Offset: 0x45ea
// Size: 0x8b
function private function_1764371df02fc41c( fly_time_left, owner )
{
    self endon( #"death" );
    self endon( #"movedone" );
    frame_duration = level.framedurationseconds ?? 0.05;
    
    while ( fly_time_left > 0 )
    {
        end_point = function_ce437aa15730b74f( owner );
        
        if ( !isdefined( end_point ) )
        {
            thread function_a37a744a04a7b209( frame_duration );
            break;
        }
        
        self moveto( end_point, fly_time_left );
        wait frame_duration;
        fly_time_left -= frame_duration;
    }
}

// Namespace weap_fireflyww
// Params 1, eflags: 0x4
// Checksum 0xfbcb59ad, Offset: 0x467d
// Size: 0xc9
function private function_3122e668cbf566aa( owner )
{
    self endon( #"death" );
    owner endon( #"death_or_disconnect" );
    var_b6db665dffb89c19 = 0.1;
    
    while ( true )
    {
        end_point = function_ce437aa15730b74f( owner );
        
        if ( !isvector( end_point ) )
        {
            break;
        }
        
        direction_vector = vectornormalize( self.origin - end_point );
        target_angles = vectortoangles( direction_vector );
        
        if ( !isdefined( self.current_target_angles ) || anglesdelta( self.current_target_angles, target_angles ) > 1 )
        {
            self rotateto( target_angles, var_b6db665dffb89c19 * 0.9 );
            self.current_target_angles = target_angles;
        }
        
        wait var_b6db665dffb89c19;
    }
}

// Namespace weap_fireflyww
// Params 1, eflags: 0x4
// Checksum 0x20887497, Offset: 0x474e
// Size: 0x9d
function private function_ce437aa15730b74f( owner )
{
    if ( !isalive( owner ) )
    {
        return;
    }
    
    if ( owner getcamerathirdperson() )
    {
        var_82f0fb6dc1c89261 = owner gettagorigin( "tag_flash", 1 );
    }
    else
    {
        cam_offset = level.fireflyww_settings.var_174f007fc88bf308 ?? ( 18, -2, -4 );
        target_position = rotatevector( cam_offset, owner getplayerangles() );
        var_82f0fb6dc1c89261 = owner getvieworigin() + target_position;
    }
    
    if ( !isdefined( var_82f0fb6dc1c89261 ) )
    {
        var_82f0fb6dc1c89261 = owner getcentroid();
    }
    
    return var_82f0fb6dc1c89261;
}

// Namespace weap_fireflyww
// Params 7, eflags: 0x4
// Checksum 0x1ca81d3e, Offset: 0x47f3
// Size: 0x2f8
function private function_f41321946425d113( script_model, start, end, wait_time, owner, embedded_ai, weapon_object )
{
    level endon( #"game_ended" );
    owner endon( #"death_or_disconnect" );
    wait wait_time;
    destination = function_ce437aa15730b74f( owner );
    
    if ( isdefined( destination ) )
    {
        end = destination;
    }
    
    hit_count = script_model.hit_count ?? 0;
    var_7560c98f0977e6f4 = [ owner ];
    recall_damage = level.fireflyww_settings.var_46832807e43a7308 ?? 1;
    
    if ( isagent( embedded_ai ) && isalive( embedded_ai ) )
    {
        stun_duration = level.fireflyww_settings.var_6b71bd2951eccdb8 ?? 1;
        
        if ( embedded_ai.aicategory == "normal" && !embedded_ai zombie_knockdown::function_19d6107cb6bdff5c() )
        {
            embedded_ai zombie_knockdown::function_6fc167d4a3590991( embedded_ai.origin );
        }
        else if ( embedded_ai.aicategory == "special" && !embedded_ai zombie_knockdown::function_19d6107cb6bdff5c() )
        {
            if ( embedded_ai zombie_stun::is_stunned() )
            {
                embedded_ai zombie_knockdown::function_6fc167d4a3590991( embedded_ai.origin );
            }
            else
            {
                embedded_ai zombie_stun::stun_ai( stun_duration );
            }
        }
        else if ( ( embedded_ai.aicategory == "elite" || embedded_ai.aicategory == "hvt" ) && !embedded_ai zombie_knockdown::function_19d6107cb6bdff5c() )
        {
            if ( embedded_ai zombie_stun::is_stunned() )
            {
                if ( isnumber( embedded_ai._blackboard.var_adea0ee486214124 ) )
                {
                    remaining_stun_time = utility::function_6f5d2e1f1ff70482( embedded_ai._blackboard.var_adea0ee486214124 - gettime() );
                }
                else
                {
                    remaining_stun_time = 0;
                }
                
                if ( remaining_stun_time > 1 )
                {
                    embedded_ai zombie_knockdown::function_6fc167d4a3590991( embedded_ai.origin );
                }
                else
                {
                    embedded_ai zombie_stun::stun_ai( stun_duration + remaining_stun_time );
                }
            }
            else
            {
                embedded_ai zombie_stun::stun_ai( stun_duration );
            }
        }
        
        embedded_ai dodamage( recall_damage, start, owner, undefined, undefined, weapon_object );
        var_7560c98f0977e6f4[ var_7560c98f0977e6f4.size ] = embedded_ai;
        hit_count++;
    }
    
    trace = trace::sphere_trace_get_all_results( start, end, 16, var_7560c98f0977e6f4, undefined, undefined, 1 );
    hit_count = handle_zombie_damage( trace, hit_count, recall_damage, start, owner, weapon_object );
    
    if ( hit_count > 0 )
    {
        var_f288afb4572c3cdc = health_overcharge::function_f6da758a8ee4c988( owner, level.fireflyww_basename, hit_count * 5 );
        
        if ( var_f288afb4572c3cdc )
        {
            data = owner get_fireflyww_player_data();
            data.life_stolen = 1;
            owner thread play_vo_event( "fireflyww_life_steal" );
            owner thread function_1ddca3b97638423a();
        }
    }
}

// Namespace weap_fireflyww
// Params 6, eflags: 0x4
// Checksum 0xf4047c19, Offset: 0x4af3
// Size: 0x188
function private handle_zombie_damage( trace, hit_count, recall_damage, start, owner, weapon_object )
{
    zombies = [];
    
    foreach ( trace_result in trace )
    {
        if ( isai( trace_result[ "entity" ] ) && isalive( trace_result[ "entity" ] ) && !isdefined( trace_result[ "entity" ].var_bd22ba6c600a23a3 ) && isdefined( trace_result[ "entity" ].aicategory ) )
        {
            if ( trace_result[ "entity" ] val::get( "damage" ) )
            {
                zombies[ zombies.size ] = trace_result[ "entity" ];
            }
        }
    }
    
    while ( true )
    {
        if ( zombies.size < 1 || hit_count >= ( level.fireflyww_settings.var_40f0980a5fdc6c4d ?? 3 ) )
        {
            break;
        }
        
        zombie = owner utility::function_4113d68e8e0a401f( zombies );
        
        if ( isdefined( zombie ) )
        {
            hit_count++;
            zombie dodamage( recall_damage, start, owner, undefined, undefined, weapon_object );
            zombies = arrayremove( zombies, zombie );
            continue;
        }
        
        break;
    }
    
    return hit_count;
}

// Namespace weap_fireflyww
// Params 0, eflags: 0xc
// Checksum 0x6802bc96, Offset: 0x4c84
// Size: 0x57
function private function_1ddca3b97638423a()
{
    self notify( #"hash_277c12f4255fc80a" );
    self endon( #"hash_277c12f4255fc80a" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    utility::function_32b24db3127bff40( "lightray_fx", "on" );
    wait 2;
    utility::function_32b24db3127bff40( "lightray_fx", "off" );
}

// Namespace weap_fireflyww
// Params 3, eflags: 0x4
// Checksum 0xadbc9e2a, Offset: 0x4ce3
// Size: 0x328
function private function_768c2519f0fda4d1( destination, total_time_seconds, start_time_milliseconds )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    retrievable_count = 0;
    retrievable_entities = arraycombine( level.var_76c45cae2094c966, powerups::get_powerups_root().active_powerups );
    retrievable_entities = function_5713d46873b29625( retrievable_entities );
    nearby_scriptables = getentitylessscriptablearray( undefined, undefined, self.origin, 40 );
    
    if ( function_7c6ce62e500be23e( nearby_scriptables ) )
    {
        retrievable_count++;
        
        if ( retrievable_count >= ( level.fireflyww_settings.var_57caf24e25bac3a7 ?? 1 ) )
        {
            return;
        }
    }
    
    while ( true )
    {
        foreach ( retrievable_entity in retrievable_entities )
        {
            if ( !isdefined( retrievable_entity ) || retrievable_entity.var_3542eed684e39d18 || distancesquared( self.origin, retrievable_entity.origin ) > squared( 40 ) )
            {
                continue;
            }
            
            if ( retrievable_entity.disable_dragged )
            {
                continue;
            }
            
            if ( !retrievable_entity val::get( "allow_secondary_attack_damage" ) )
            {
                continue;
            }
            
            move_time = total_time_seconds - utility::function_6f5d2e1f1ff70482( gettime() - start_time_milliseconds );
            move_time = clamp( move_time, 0.05, 10 );
            
            if ( isent( retrievable_entity ) )
            {
                if ( retrievable_entity islinked() )
                {
                    retrievable_entity unlink();
                }
                
                retrievable_entity thread function_bd9bc87dd83c6ae5( move_time, self.owner );
                retrievable_entity utility::ent_flag_clear( "fireflyww_is_retrieved" );
                retrievable_entity.var_3542eed684e39d18 = 1;
                retrievable_count++;
            }
            else if ( retrievable_entity isscriptableinstance() )
            {
                if ( isdefined( retrievable_entity.linkedparent ) )
                {
                    retrievable_entity utility::scriptable_clearparententity();
                }
                
                tag_origin = utility::spawn_model( "tag_origin" );
                tag_origin.origin = self.origin;
                tag_origin.angles = self.angles;
                retrievable_entity.tag_origin = tag_origin;
                retrievable_entity utility::scriptable_setparententity( tag_origin );
                tag_origin thread function_bd9bc87dd83c6ae5( move_time, self.owner );
                retrievable_entity utility::ent_flag_clear( "fireflyww_is_retrieved" );
                retrievable_entity.var_3542eed684e39d18 = 1;
                retrievable_count++;
            }
            
            if ( retrievable_entity.var_3542eed684e39d18 )
            {
                if ( isdefined( retrievable_entity.mesh_mdl ) )
                {
                    retrievable_entity.mesh_mdl thread function_bd9bc87dd83c6ae5( move_time, self.owner );
                }
                
                retrievable_entity thread function_24705499d4836eef( move_time, self.owner );
            }
            
            if ( retrievable_count >= ( level.fireflyww_settings.var_57caf24e25bac3a7 ?? 1 ) )
            {
                return;
            }
        }
        
        throttle::throttle_wait_in_queue( level.fireflyww_retrievable_throttle, self );
    }
}

// Namespace weap_fireflyww
// Params 1, eflags: 0x4
// Checksum 0xac0d679d, Offset: 0x5013
// Size: 0xc0, Type: bool
function private function_7c6ce62e500be23e( nearby_scriptables )
{
    if ( !isplayer( self.owner ) )
    {
        return false;
    }
    
    foreach ( scriptable in nearby_scriptables )
    {
        if ( !isdefined( scriptable ) )
        {
            continue;
        }
        
        if ( scriptable.var_66f56a71f5cd80d7 && self.owner [[ scriptable.var_66f56a71f5cd80d7 ]]( scriptable ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace weap_fireflyww
// Params 2, eflags: 0x4
// Checksum 0x1e030f8a, Offset: 0x50dc
// Size: 0x8e
function private function_bd9bc87dd83c6ae5( var_d524330523e6df2d, owner )
{
    self endon( #"death" );
    self endon( #"movedone" );
    frame_duration = level.framedurationseconds ?? 0.05;
    fly_time_left = var_d524330523e6df2d;
    
    while ( fly_time_left > 0 )
    {
        end_point = function_ce437aa15730b74f( owner );
        
        if ( !isdefined( end_point ) )
        {
            break;
        }
        
        self moveto( end_point, fly_time_left );
        fly_time_left -= frame_duration;
        wait frame_duration;
    }
}

// Namespace weap_fireflyww
// Params 2, eflags: 0x4
// Checksum 0xb1b2000, Offset: 0x5172
// Size: 0x1db
function private function_24705499d4836eef( move_time, player )
{
    self endon( #"death" );
    wait move_time + 0.1;
    params = {};
    params.object = self;
    params.player = player;
    callback::callback( "mq_time_grabbed", params );
    ground_pos = utility::drop_to_ground( self.origin, 10, undefined, undefined, level.fireflyww_settings.drop_to_ground_contents ?? undefined );
    time = distance( ground_pos, self.origin ) / 100;
    time = clamp( time, 0.05, 10 );
    
    if ( isdefined( self.item ) )
    {
        self.item common_item::function_725abd79805e767e();
    }
    
    if ( isent( self ) )
    {
        if ( self islinked() )
        {
            self unlink();
        }
        
        self moveto( ground_pos, time );
    }
    else if ( self isscriptableinstance() )
    {
        if ( self.linkedparent.owner )
        {
            utility::scriptable_clearparententity();
        }
        
        if ( self.tag_origin )
        {
            tag_origin = self.tag_origin;
        }
        else
        {
            tag_origin = utility::spawn_model( "tag_origin" );
            tag_origin.origin = self.origin;
            tag_origin.angles = self.angles;
            utility::scriptable_setparententity( tag_origin );
        }
        
        tag_origin moveto( ground_pos, time );
        utility::delaythread( time, &function_205f3a140d97afb5, tag_origin );
    }
    
    if ( isdefined( self.mesh_mdl ) )
    {
        self.mesh_mdl moveto( ground_pos, time );
    }
    
    wait time + 0.1;
    utility::ent_flag_set( "fireflyww_is_retrieved" );
    self.var_3542eed684e39d18 = 0;
}

// Namespace weap_fireflyww
// Params 1, eflags: 0x4
// Checksum 0xd8735505, Offset: 0x5355
// Size: 0x41
function private function_205f3a140d97afb5( tag_origin )
{
    if ( isdefined( self ) )
    {
        utility::scriptable_clearparententity();
    }
    
    if ( isdefined( tag_origin ) )
    {
        if ( tag_origin islinked() )
        {
            if ( isdefined( self ) )
            {
                common_item::function_725abd79805e767e();
            }
            
            tag_origin unlink();
        }
        
        tag_origin delete();
    }
}

// Namespace weap_fireflyww
// Params 1, eflags: 0x4
// Checksum 0x1d4e484b, Offset: 0x539e
// Size: 0x9f
function private function_b190a58d96c55ce6( params )
{
    if ( isdefined( params.item ) )
    {
        if ( isdefined( params.spawnoptions.var_f35b5b18b029c493 ) && !params.spawnoptions.var_f35b5b18b029c493 )
        {
            return;
        }
        
        item = params.item;
        item endon( #"death" );
        
        while ( true )
        {
            waitframe();
            
            if ( !isdefined( item ) )
            {
                return;
            }
            
            if ( item function_ef43fd0a946e1594() )
            {
                break;
            }
        }
        
        wait 0.5;
        function_6bad73e13df6963b( item );
    }
}

// Namespace weap_fireflyww
// Params 1, eflags: 0x4
// Checksum 0x1b2c200b, Offset: 0x5445
// Size: 0x3f
function private function_6bad73e13df6963b( entity )
{
    level.var_76c45cae2094c966 = function_5713d46873b29625( level.var_76c45cae2094c966 );
    level.var_76c45cae2094c966 = arraycombineunique( level.var_76c45cae2094c966, [ entity ] );
}

// Namespace weap_fireflyww
// Params 1, eflags: 0x4
// Checksum 0x3455781, Offset: 0x548c
// Size: 0x56c
function private function_b5b50fd05d69ab45( weapon_name )
{
    level endon( #"game_ended" );
    assert( isdefined( level.fireflyww_settings.var_6e45d8cfdf28c3c ), "<dev string:xcd>" );
    assert( isdefined( level.fireflyww_settings.var_f84704015fb997f ), "<dev string:xfb>" );
    var_3c7648720e2ce6ea = squared( level.fireflyww_settings.var_6e45d8cfdf28c3c );
    var_9bd2856ecabeb3e1 = squared( level.fireflyww_settings.var_6e45d8cfdf28c3c - level.fireflyww_settings.var_f84704015fb997f );
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            data = player get_fireflyww_player_data();
            var_588548377381f051 = 0;
            var_9cbf2752e43f39d2 = 0;
            var_7d582793e6d013c2 = 0;
            
            if ( isarray( data.var_cbe730c624b3fc11 ) )
            {
                foreach ( var_6340de0fa276cd8 in data.var_cbe730c624b3fc11 )
                {
                    if ( isdefined( var_6340de0fa276cd8 ) && !var_6340de0fa276cd8.var_2ad511590a4f71c1 )
                    {
                        if ( var_6340de0fa276cd8.var_c29d8da28257782b && var_6340de0fa276cd8.linked_entity )
                        {
                            if ( var_6340de0fa276cd8.linked_entity.classname == "script_origin" )
                            {
                                var_6340de0fa276cd8.linked_entity delete();
                            }
                            
                            if ( var_6340de0fa276cd8 islinked() )
                            {
                                var_6340de0fa276cd8 unlink();
                            }
                            
                            var_6340de0fa276cd8.linked_entity = undefined;
                        }
                        
                        distance_squared_to_player = distancesquared( player.origin, var_6340de0fa276cd8.origin );
                        
                        if ( distance_squared_to_player > var_9bd2856ecabeb3e1 && distance_squared_to_player <= var_3c7648720e2ce6ea )
                        {
                            var_7d582793e6d013c2 = 1;
                            var_6340de0fa276cd8.script_model utility::function_32b24db3127bff40( "sound", "disappear_warning_loop" );
                            continue;
                        }
                        
                        if ( distance_squared_to_player > var_3c7648720e2ce6ea )
                        {
                            var_6340de0fa276cd8 thread function_51f7588d370b248d();
                            continue;
                        }
                        
                        var_6340de0fa276cd8.script_model utility::function_32b24db3127bff40( "sound", "off" );
                    }
                }
                
                data.var_cbe730c624b3fc11 = function_5713d46873b29625( data.var_cbe730c624b3fc11 );
                var_1397c0cd1c2d400 = 0;
                
                foreach ( var_6340de0fa276cd8 in data.var_cbe730c624b3fc11 )
                {
                    if ( !var_6340de0fa276cd8.var_2ad511590a4f71c1 && !var_6340de0fa276cd8.losing )
                    {
                        var_1397c0cd1c2d400++;
                    }
                }
                
                if ( var_1397c0cd1c2d400 > 0 )
                {
                    var_588548377381f051 = 1;
                    
                    if ( player bgb::is_enabled( "stock_option" ) || player bgb::is_enabled( "free_fire" ) )
                    {
                        var_9cbf2752e43f39d2 = 1;
                    }
                }
                
                if ( var_1397c0cd1c2d400 > 9 )
                {
                    var_c37d23922413876 = var_1397c0cd1c2d400 - 9;
                    
                    foreach ( var_ab85e333d7ea3be0 in player getweaponslistprimaries() )
                    {
                        if ( var_ab85e333d7ea3be0.basename == level.fireflyww_basename )
                        {
                            ww = var_ab85e333d7ea3be0;
                            break;
                        }
                    }
                    
                    if ( ww )
                    {
                        foreach ( var_6340de0fa276cd8 in data.var_cbe730c624b3fc11 )
                        {
                            if ( !var_6340de0fa276cd8.var_2ad511590a4f71c1 && !var_6340de0fa276cd8.losing )
                            {
                                var_6340de0fa276cd8 thread function_51f7588d370b248d();
                                var_c37d23922413876--;
                                
                                if ( var_c37d23922413876 <= 0 )
                                {
                                    break;
                                }
                            }
                        }
                    }
                }
            }
            
            if ( var_7d582793e6d013c2 )
            {
                player utility::ent_flag_set( "fireflyww_oob_warning_key" );
            }
            else
            {
                player utility::ent_flag_clear( "fireflyww_oob_warning_key" );
            }
            
            if ( player getcurrentweapon().basename == weapon_name )
            {
                player val::set( weapon_name, "allow_reload_without_reserve_ammo", var_588548377381f051 );
                player val::set( weapon_name, "allow_reload_when_clip_full", var_9cbf2752e43f39d2 );
            }
            
            waitframe();
        }
        
        wait 0.5;
    }
}

// Namespace weap_fireflyww
// Params 0, eflags: 0x4
// Checksum 0xaf7e4080, Offset: 0x5a00
// Size: 0xe0
function private function_2001d28351c368ee()
{
    data = get_fireflyww_player_data();
    
    if ( isarray( data.var_cbe730c624b3fc11 ) )
    {
        foreach ( var_6340de0fa276cd8 in data.var_cbe730c624b3fc11 )
        {
            if ( var_6340de0fa276cd8 && !var_6340de0fa276cd8.losing && !var_6340de0fa276cd8.var_2ad511590a4f71c1 )
            {
                var_6340de0fa276cd8 thread function_51f7588d370b248d();
            }
            
            waitframe();
        }
        
        data.var_cbe730c624b3fc11 = function_5713d46873b29625( data.var_cbe730c624b3fc11 );
    }
}

// Namespace weap_fireflyww
// Params 0, eflags: 0x4
// Checksum 0xf9c518ae, Offset: 0x5ae8
// Size: 0xb0
function private function_51f7588d370b248d()
{
    level endon( #"game_ended" );
    self endon( #"explode" );
    self endon( #"delay_death" );
    childthread delay_endon( "death" );
    self.losing = 1;
    script_model = function_312858579fed8dea( self );
    
    if ( isdefined( self.owner ) )
    {
        self.owner function_ee1bc18c858fbf68( script_model, 0 );
    }
    
    if ( isdefined( script_model ) )
    {
        script_model thread function_a37a744a04a7b209();
        
        if ( script_model.impact_fx && script_model.impact_fx isscriptableinstance() )
        {
            script_model.impact_fx freescriptable();
        }
    }
}

// Namespace weap_fireflyww
// Params 1, eflags: 0x4
// Checksum 0xd15fc7c4, Offset: 0x5ba0
// Size: 0xb0
function private function_312858579fed8dea( grenade )
{
    model = grenade.script_model;
    model.owner = grenade.owner;
    
    if ( grenade.script_model )
    {
        grenade.script_model unlink();
    }
    
    if ( grenade.linked_entity.classname == "script_origin" )
    {
        grenade.linked_entity delete();
        grenade.linked_entity = undefined;
    }
    
    if ( grenade islinked() )
    {
        grenade unlink();
    }
    
    if ( isdefined( grenade ) )
    {
        grenade delete();
    }
    
    return model;
}

// Namespace weap_fireflyww
// Params 2, eflags: 0x4
// Checksum 0xc9075dbb, Offset: 0x5c59
// Size: 0xc1
function private function_a37a744a04a7b209( var_dd778033ae1cf585 = 0.8, var_bc6f751b2a6c4554 = 0 )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( self isscriptable() )
    {
        if ( var_bc6f751b2a6c4554 )
        {
            utility::function_7c10ea82c1e305b8( "sound", "lost_warning" );
        }
        else
        {
            utility::function_7c10ea82c1e305b8( "sound", "disappear_warning" );
        }
        
        state = "oob";
        
        if ( isplayer( self.owner ) )
        {
            state = self.owner function_b6759d5040e13258( "oob" );
        }
        
        utility::function_7c10ea82c1e305b8( "vfx", state );
    }
    
    wait var_dd778033ae1cf585;
    self delete();
}

// Namespace weap_fireflyww
// Params 2, eflags: 0x4
// Checksum 0x75bbbece, Offset: 0x5d22
// Size: 0x1f6
function private on_add_pap_attachments( params, weapon_name )
{
    if ( !isweapon( params.weapon ) || params.weapon.basename != weapon_name )
    {
        return;
    }
    
    if ( params.weapon canuseattachment( "sat_rec_ww_firefly_pap" ) )
    {
        index = attachment_exists( params.attachments, "sat_rec_ww_firefly" );
        
        if ( isdefined( index ) )
        {
            var_fd98dfe6f63a2c95 = params.var_f1614eef81f0bdd2[ "sat_rec_ww_firefly" ];
            params.attachments[ index ] = undefined;
            params.attachments = function_5713d46873b29625( params.attachments );
            params.attachments[ params.attachments.size ] = "sat_rec_ww_firefly_pap";
            params.var_f1614eef81f0bdd2[ "sat_rec_ww_firefly_pap" ] = var_fd98dfe6f63a2c95;
            params.var_f1614eef81f0bdd2[ "sat_rec_ww_firefly" ] = undefined;
        }
    }
    
    assert( level.fireflyww_settings.var_8617ebba787217fa, "<dev string:x11f>" );
    var_6c5a26999a4c3442 = level.fireflyww_settings.var_8617ebba787217fa ?? "none";
    
    if ( params.weapon canuseattachment( var_6c5a26999a4c3442 ) )
    {
        index = attachment_exists( params.attachments, var_6c5a26999a4c3442 );
        
        if ( !isdefined( index ) )
        {
            params.attachments[ params.attachments.size ] = var_6c5a26999a4c3442;
            params.var_f1614eef81f0bdd2[ var_6c5a26999a4c3442 ] = 0;
        }
        
        if ( isplayer( self ) )
        {
            key = "fireflyww_pap_tutorial_message_has_displayed";
            
            if ( !utility::ent_flag( key ) )
            {
                utility::ent_flag_set( key );
                thread ww_shared::show_hud_tutorial_message( &"zm_sat_firefly/zm_ww_firefly_tutorial_message_pack" );
            }
        }
    }
    
    if ( isplayer( self ) )
    {
        function_2001d28351c368ee();
    }
}

// Namespace weap_fireflyww
// Params 2, eflags: 0x4
// Checksum 0xe7af4b37, Offset: 0x5f20
// Size: 0x88
function private attachment_exists( attachments, target )
{
    foreach ( index, name in attachments )
    {
        if ( name == target )
        {
            return index;
        }
    }
}

// Namespace weap_fireflyww
// Params 2, eflags: 0xc
// Checksum 0xd2e3713, Offset: 0x5fb1
// Size: 0xef
function private function_f352e84e52df9704( weapon_name, is_pap )
{
    self notify( #"hash_a8c0d3453b72e980" );
    self endon( #"hash_a8c0d3453b72e980" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    wait 1;
    
    if ( !is_pap )
    {
        if ( !level.var_f301f415610b1eef )
        {
            weapon_obj = weapon::buildweapon( weapon_name, [ "sat_rec_ww_firefly_pap" ] );
            weapon_streaming = function_2535619d314c1099( weapon_obj, ( self.origin ?? ( 0, 0, 0 ) ) + ( 0, 0, -100000 ), ( 0, 0, 0 ) );
            level.var_f301f415610b1eef = weapon_streaming;
        }
        
        return;
    }
    
    if ( level.var_f301f415610b1eef )
    {
        level.var_f301f415610b1eef delete();
        level.var_f301f415610b1eef = undefined;
    }
}

// Namespace weap_fireflyww
// Params 1, eflags: 0x4
// Checksum 0x1b4609ab, Offset: 0x60a8
// Size: 0x80
function private function_b711d8e6dc0f228c( weapon_name )
{
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        self waittill( #"hash_69562b0de38a064f", param );
        
        switch ( param )
        {
            case 1:
                function_3f3f920227bb39a2( weapon_name );
                break;
            case 2:
                function_cb8d848c67a23493();
                break;
            default:
                break;
        }
    }
}

// Namespace weap_fireflyww
// Params 1, eflags: 0x4
// Checksum 0xd43f23cb, Offset: 0x6130
// Size: 0x26
function private function_3f3f920227bb39a2( weapon_name )
{
    thread function_3984ea3bccac9b33( weapon_name );
    utility::function_32b24db3127bff40( "fireflyww_charge", "start" );
}

// Namespace weap_fireflyww
// Params 0, eflags: 0x4
// Checksum 0x23055b69, Offset: 0x615e
// Size: 0x127
function private function_cb8d848c67a23493()
{
    self notify( #"hash_f3fbb9bbcddeed13" );
    
    if ( utility::function_9f2c41c1dcc8c94( "fireflyww_charge", "start" ) )
    {
        utility::function_32b24db3127bff40( "fireflyww_charge", "end" );
    }
    
    data = get_fireflyww_player_data();
    
    if ( isarray( data.var_cbe730c624b3fc11 ) )
    {
        foreach ( var_6340de0fa276cd8 in data.var_cbe730c624b3fc11 )
        {
            if ( var_6340de0fa276cd8.script_model && var_6340de0fa276cd8.script_model isscriptable() )
            {
                if ( var_6340de0fa276cd8.script_model utility::function_9f2c41c1dcc8c94( "fx_aux", function_b6759d5040e13258( "overheat_glow" ) ) )
                {
                    var_6340de0fa276cd8.script_model utility::function_7c10ea82c1e305b8( "fx_aux", "off" );
                }
            }
        }
    }
}

// Namespace weap_fireflyww
// Params 1, eflags: 0xc
// Checksum 0xca041a72, Offset: 0x628d
// Size: 0x168
function private function_3984ea3bccac9b33( weapon_name )
{
    self notify( #"hash_c943d196ad7a0325" );
    self endon( #"hash_c943d196ad7a0325" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( "stop_monitor_" + weapon_name + "_state" );
    self endon( #"hash_f3fbb9bbcddeed13" );
    wait 0.2;
    data = get_fireflyww_player_data();
    
    if ( isarray( data.var_cbe730c624b3fc11 ) )
    {
        foreach ( var_6340de0fa276cd8 in data.var_cbe730c624b3fc11 )
        {
            if ( var_6340de0fa276cd8 && !var_6340de0fa276cd8.var_2ad511590a4f71c1 && var_6340de0fa276cd8.script_model && var_6340de0fa276cd8.script_model isscriptable() )
            {
                var_6340de0fa276cd8.script_model utility::function_7c10ea82c1e305b8( "fx_aux", function_b6759d5040e13258( "overheat_glow" ) );
                wait level.fireflyww_settings.explosion_interval ?? 0.2;
            }
        }
    }
}

// Namespace weap_fireflyww
// Params 1, eflags: 0x4
// Checksum 0xa0c203d9, Offset: 0x63fd
// Size: 0x17a
function private function_93591513280bed6d( weapon_object )
{
    data = get_fireflyww_player_data();
    var_2cbc1bcdaf650f3 = [];
    var_a3fe9e4c0dc1f2e0 = [];
    
    foreach ( var_6340de0fa276cd8 in data.var_cbe730c624b3fc11 )
    {
        if ( isdefined( var_6340de0fa276cd8 ) )
        {
            if ( var_6340de0fa276cd8.var_2ad511590a4f71c1 )
            {
                var_2cbc1bcdaf650f3[ var_2cbc1bcdaf650f3.size ] = var_6340de0fa276cd8;
                continue;
            }
            
            var_a3fe9e4c0dc1f2e0[ var_a3fe9e4c0dc1f2e0.size ] = var_6340de0fa276cd8;
        }
    }
    
    data.var_cbe730c624b3fc11 = var_2cbc1bcdaf650f3;
    wait_time = 0;
    
    foreach ( overload_grenade in var_a3fe9e4c0dc1f2e0 )
    {
        overload_grenade thread function_f5bb115ffa28f1ac( self, weapon_object, wait_time );
        wait_time += level.fireflyww_settings.explosion_interval ?? 0.2;
    }
}

// Namespace weap_fireflyww
// Params 3, eflags: 0x4
// Checksum 0xaef3c61a, Offset: 0x657f
// Size: 0x11c
function private function_f5bb115ffa28f1ac( owner, weapon_object, wait_time )
{
    level endon( #"game_ended" );
    self endon( #"explode" );
    self endon( #"death" );
    wait wait_time;
    
    if ( self.script_model )
    {
        owner function_ee1bc18c858fbf68( self.script_model, 0 );
        self.script_model.owner = owner;
        script_model = self.script_model;
    }
    
    if ( self.linked_entity.classname == "script_origin" )
    {
        self.linked_entity delete();
        self.linked_entity = undefined;
    }
    
    if ( self islinked() )
    {
        self unlink();
    }
    
    if ( self.normal )
    {
        self.origin += self.normal * 5;
    }
    
    waitframe();
    
    if ( script_model )
    {
        script_model thread function_3b6d546f3899c8cd( 0, weapon_object, 1 );
    }
    
    self detonate( owner );
}

// Namespace weap_fireflyww
// Params 3, eflags: 0x4
// Checksum 0xbc0d4ebb, Offset: 0x66a3
// Size: 0xc2
function private adjust_ammo( weapon, var_86f495575b9f5bec, prioritize_clip = 1 )
{
    current_clip_ammo = self getweaponammoclip( weapon );
    current_stock_ammo = self getweaponammostock( weapon );
    clip_size = weaponclipsize( weapon );
    
    if ( prioritize_clip )
    {
        new_clip_ammo = current_clip_ammo + var_86f495575b9f5bec;
        
        if ( new_clip_ammo > clip_size )
        {
            new_stock_ammo = current_stock_ammo + new_clip_ammo - clip_size;
            new_clip_ammo = clip_size;
        }
        else
        {
            new_stock_ammo = current_stock_ammo;
        }
    }
    else
    {
        new_stock_ammo = current_stock_ammo + var_86f495575b9f5bec;
        
        if ( new_stock_ammo < 0 )
        {
            new_clip_ammo = current_clip_ammo + new_stock_ammo;
            new_stock_ammo = 0;
        }
        else
        {
            new_clip_ammo = current_clip_ammo;
        }
    }
    
    self setweaponammoclip( weapon, new_clip_ammo );
    self setweaponammostock( weapon, new_stock_ammo );
}

// Namespace weap_fireflyww
// Params 2, eflags: 0x4
// Checksum 0x27bc6055, Offset: 0x676d
// Size: 0x50
function private function_5bf9e25adcf5cd49( var_abd239ccb2b4db77, weapon )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    wait level.fireflyww_settings.var_85e2a24d113862c4 ?? 3;
    adjust_ammo( weapon, var_abd239ccb2b4db77 );
}

// Namespace weap_fireflyww
// Params 2, eflags: 0x4
// Checksum 0xea2f4da0, Offset: 0x67c5
// Size: 0x8d
function private function_176013519395df42( params, weapon_name )
{
    key = "fireflyww_tutorial_message_has_displayed";
    
    if ( isweapon( params.item.weaponobj ) && params.item.weaponobj.basename == weapon_name )
    {
        if ( !utility::ent_flag( key ) )
        {
            utility::ent_flag_set( key );
            thread ww_shared::show_hud_tutorial_message( &"zm_sat_firefly/zm_ww_firefly_tutorial_message" );
        }
    }
}

// Namespace weap_fireflyww
// Params 2, eflags: 0x4
// Checksum 0x58ab0b6a, Offset: 0x685a
// Size: 0x51
function private function_ed4ce628fa86f6ff( params, weapon_name )
{
    if ( isdefined( params ) && isweapon( params.weaponobj ) && params.weaponobj.basename == weapon_name )
    {
        function_2001d28351c368ee();
    }
}

// Namespace weap_fireflyww
// Params 1, eflags: 0x4
// Checksum 0xdac9ce2, Offset: 0x68b3
// Size: 0x9b
function private function_28dd81801939eaf5( weapon_name )
{
    while ( true )
    {
        ww_data = ww_shared::get_ww_player_data( weapon_name );
        
        if ( !isdefined( ww_data.ambient_fx_part_name ) || !isdefined( ww_data.var_bc3ad5120bbdf8ea ) )
        {
            waitframe();
            continue;
        }
        
        if ( utility::function_9f2c41c1dcc8c94( ww_data.ambient_fx_part_name, ww_data.var_bc3ad5120bbdf8ea ) )
        {
            function_e778826deef19fdd( weapon_name );
        }
        else
        {
            utility::function_32b24db3127bff40( "fireflyww_ball", "off" );
            utility::function_32b24db3127bff40( "fireflyww_ammo_counter", "0" );
        }
        
        waitframe();
    }
}

// Namespace weap_fireflyww
// Params 1, eflags: 0x4
// Checksum 0xbb9601c1, Offset: 0x6956
// Size: 0x12e
function private function_e778826deef19fdd( weapon_name )
{
    weapon = self getcurrentweapon();
    ball_fx_state = "off";
    
    if ( weapon.basename == weapon_name )
    {
        current_clip_ammo = self getweaponammoclip( weapon );
        clip_size = weaponclipsize( weapon );
        data = get_fireflyww_player_data();
        assert( clip_size <= 8, "<dev string:x15e>" );
        
        if ( self isshooting() && !self ismeleeing() )
        {
            ball_fx_state = "muzzle";
        }
        else if ( data.var_57ec789ffc9c902a )
        {
            ball_fx_state = "off";
        }
        else if ( current_clip_ammo == clip_size )
        {
            ball_fx_state = "full";
        }
        else if ( current_clip_ammo > ( data.is_pap ? 2 : 1 ) )
        {
            ball_fx_state = "medium";
        }
        else
        {
            ball_fx_state = "low";
        }
        
        ball_fx_state = function_b6759d5040e13258( ball_fx_state );
        data.var_57ec789ffc9c902a = self function_985124b0e1e74f2e();
    }
    
    utility::function_32b24db3127bff40( "fireflyww_ball", ball_fx_state );
    utility::function_32b24db3127bff40( "fireflyww_ammo_counter", current_clip_ammo + "" );
}

// Namespace weap_fireflyww
// Params 1, eflags: 0x4
// Checksum 0xc110e166, Offset: 0x6a8c
// Size: 0x71
function private function_a9f2d40d4d39a73e( weapon_name )
{
    ww_data = ww_shared::get_ww_player_data( weapon_name );
    
    while ( true )
    {
        if ( ww_data.ambient_fx_part_name )
        {
            if ( function_167413dc0cd8b032() )
            {
                ww_data.var_bc3ad5120bbdf8ea = function_b6759d5040e13258( "on_no_vfx" );
            }
            else
            {
                ww_data.var_bc3ad5120bbdf8ea = function_b6759d5040e13258( "on" );
            }
        }
        
        waitframe();
    }
}

// Namespace weap_fireflyww
// Params 0, eflags: 0x4
// Checksum 0xa4fc20ea, Offset: 0x6b05
// Size: 0x3f, Type: bool
function private function_167413dc0cd8b032()
{
    return self.aether_shroud_active || self.var_57e070f1c0cc4a5f || self.var_57e071f1c0cc4c92 || self.var_57e072f1c0cc4ec5 || self.time_carrier;
}

// Namespace weap_fireflyww
// Params 0, eflags: 0xc
// Checksum 0xd0313a31, Offset: 0x6b4d
// Size: 0x6e
function private function_e6402db87b49f2cb()
{
    self notify( #"hash_40f87796dde20b02" );
    self endon( #"hash_40f87796dde20b02" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        utility::ent_flag_wait( "fireflyww_oob_warning_key" );
        self playrumblelooponentity( "low_highfreq" );
        
        while ( utility::ent_flag( "fireflyww_oob_warning_key" ) )
        {
            waitframe();
        }
        
        self stoprumble( "low_highfreq" );
    }
}

// Namespace weap_fireflyww
// Params 1, eflags: 0x4
// Checksum 0x379ad0e1, Offset: 0x6bc3
// Size: 0x10d
function private function_6b97d913c0a08aa9( weapon_name )
{
    data = get_fireflyww_player_data();
    
    while ( true )
    {
        while ( !self attackbuttonpressed() )
        {
            waitframe();
        }
        
        weapon = self getcurrentweapon();
        
        if ( weapon.basename == weapon_name )
        {
            current_clip_ammo = self getweaponammoclip( weapon );
            clip_size = weaponclipsize( weapon );
            time_ok = 1;
            
            if ( isnumber( data.var_18114bbb17ed3fbc ) )
            {
                time_ok = data.var_18114bbb17ed3fbc + 1000 < gettime();
            }
            
            if ( current_clip_ammo == 0 && clip_size > 0 && time_ok && !self adsbuttonpressed( 1 ) && !self function_a942012f2fc410bf() && !self isreloading() && !self ismeleeing() && !self isswitchingweapon() && !self function_7d9f109338409783() )
            {
                self forcereloading();
            }
        }
        
        while ( self attackbuttonpressed() )
        {
            waitframe();
        }
    }
}

// Namespace weap_fireflyww
// Params 0, eflags: 0x4
// Checksum 0x35e96f85, Offset: 0x6cd8
// Size: 0x3f
function private get_fireflyww_player_data()
{
    assert( isplayer( self ), "<dev string:x1c3>" );
    
    if ( !isdefined( self.fireflyww_player_data ) )
    {
        self.fireflyww_player_data = spawnstruct();
        thread function_e6402db87b49f2cb();
    }
    
    return self.fireflyww_player_data;
}

// Namespace weap_fireflyww
// Params 1, eflags: 0x4
// Checksum 0x9bc0df79, Offset: 0x6d20
// Size: 0x8e
function private function_bd73336417b102ab( projectile_birthtime )
{
    assert( isplayer( self ), "<dev string:x1c3>" );
    data = get_fireflyww_player_data();
    
    if ( !isarray( data.pin_infos ) )
    {
        data.pin_infos = [];
    }
    
    pin_info = data.pin_infos[ projectile_birthtime ];
    
    if ( !isdefined( pin_info ) )
    {
        pin_info = { #var_164183d729ab3306:[] };
        data.pin_infos[ projectile_birthtime ] = pin_info;
    }
    
    return pin_info;
}

// Namespace weap_fireflyww
// Params 1, eflags: 0x4
// Checksum 0x9d1265bd, Offset: 0x6db7
// Size: 0x2c
function private function_b6759d5040e13258( str )
{
    return get_fireflyww_player_data().is_pap ? str + "_pap" : str;
}

// Namespace weap_fireflyww
// Params 1, eflags: 0x4
// Checksum 0xbd034c30, Offset: 0x6dec
// Size: 0x1e
function private delay_endon( string )
{
    self waittill( string );
    waitframe();
    self notify( "delay_" + string );
}

// Namespace weap_fireflyww
// Params 1, eflags: 0x4
// Checksum 0xa92f1ebd, Offset: 0x6e12
// Size: 0x49, Type: bool
function private is_wall_surface( surface_normal )
{
    dot = vectordot( surface_normal, ( 0, 0, 1 ) );
    return !( dot >= 0.96593 || dot <= -0.96593 && dot > -1 );
}

// Namespace weap_fireflyww
// Params 1, eflags: 0x4
// Checksum 0xd22cc1b6, Offset: 0x6e64
// Size: 0x33, Type: bool
function private is_floor_surface( surface_normal )
{
    dot = vectordot( surface_normal, ( 0, 0, 1 ) );
    return dot >= 0.96593;
}

// Namespace weap_fireflyww
// Params 2, eflags: 0x4
// Checksum 0x8771caa7, Offset: 0x6ea0
// Size: 0x4f
function private on_player_connect( params, weapon_name )
{
    level endon( #"game_ended" );
    callback::add( #"player_used_item", &function_176013519395df42, weapon_name );
    callback::add( #"player_item_drop", &function_ed4ce628fa86f6ff, weapon_name );
}

// Namespace weap_fireflyww
// Params 1, eflags: 0x4
// Checksum 0xd4c592e5, Offset: 0x6ef7
// Size: 0xbf
function private on_player_disconnect( params )
{
    level endon( #"game_ended" );
    data = self.fireflyww_player_data;
    
    if ( isarray( data.var_cbe730c624b3fc11 ) )
    {
        foreach ( var_6340de0fa276cd8 in data.var_cbe730c624b3fc11 )
        {
            if ( isdefined( var_6340de0fa276cd8 ) )
            {
                var_6340de0fa276cd8 thread function_51f7588d370b248d();
            }
            
            waitframe();
        }
    }
}

// Namespace weap_fireflyww
// Params 1, eflags: 0x4
// Checksum 0x88200249, Offset: 0x6fbe
// Size: 0x21, Type: bool
function private function_34b4f27d58fcf9d4( weapon_obj )
{
    return weapon_obj.basename == level.fireflyww_basename;
}

/#

    // Namespace weap_fireflyww
    // Params 0, eflags: 0x4
    // Checksum 0xec1c360, Offset: 0x6fe8
    // Size: 0x78, Type: dev
    function private init_fireflyww_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x1f7>" );
        devgui::add_devgui_func( "<dev string:x210>", "<dev string:x223>", &function_7440046d54e60878, 1 );
        devgui::add_devgui_func( "<dev string:x236>", "<dev string:x24d>", &function_55d229363b326774, 1 );
        devgui::add_devgui_func( "<dev string:x25d>", "<dev string:x279>", &function_fb92595d90a0cb5e, 1 );
        devgui::add_devgui_func( "<dev string:x28e>", "<dev string:x2a8>", &function_1b45dd2e3785f597, 1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace weap_fireflyww
    // Params 0, eflags: 0x4
    // Checksum 0x40294b81, Offset: 0x7068
    // Size: 0xd0, Type: dev
    function private function_7440046d54e60878()
    {
        weapon_name = utility::get_scripted_weapon_name( #"necrofluid_gauntlet" );
        weap_fireflyww = makeweapon( weapon_name );
        assert( isdefined( weap_fireflyww.weaponcustomsettings ), "<dev string:x5d>" );
        
        if ( !level.var_711bfea0c027544d )
        {
            level.var_711bfea0c027544d = 1;
            level.fireflyww_settings.var_40f0980a5fdc6c4d = 1;
        }
        else
        {
            level.var_711bfea0c027544d = 0;
            level.fireflyww_settings.var_40f0980a5fdc6c4d = weap_fireflyww.weaponcustomsettings.var_40f872a4c5a36615;
        }
        
        if ( level.var_711bfea0c027544d )
        {
            iprintlnbold( "<dev string:x2bb>" );
            return;
        }
        
        iprintlnbold( "<dev string:x2da>" );
    }

    // Namespace weap_fireflyww
    // Params 0, eflags: 0x4
    // Checksum 0xa81ece2e, Offset: 0x7140
    // Size: 0x126, Type: dev
    function private function_55d229363b326774()
    {
        if ( !level.var_2a9e3ab1023b750d )
        {
            level.var_2a9e3ab1023b750d = 1;
            weapon_name = utility::get_scripted_weapon_name( #"necrofluid_gauntlet" );
            
            foreach ( player in level.players )
            {
                if ( player isweaponsenabled() && isweapon( player.currentweapon ) && player.currentweapon.basename == weapon_name )
                {
                    player thread function_575029c9ccd7e3f7();
                    break;
                }
            }
        }
        else
        {
            level.var_2a9e3ab1023b750d = 0;
            level notify( #"hash_cf82c3aae02337a0" );
        }
        
        if ( level.var_2a9e3ab1023b750d )
        {
            iprintlnbold( "<dev string:x2f8>" );
            return;
        }
        
        iprintlnbold( "<dev string:x318>" );
    }

    // Namespace weap_fireflyww
    // Params 0, eflags: 0xc
    // Checksum 0xb967f334, Offset: 0x726e
    // Size: 0x1d6, Type: dev
    function private function_575029c9ccd7e3f7()
    {
        self notify( #"hash_c3d375ff37665b9e" );
        self endon( #"hash_c3d375ff37665b9e" );
        level endon( #"game_ended" );
        self endon( #"death_or_disconnect" );
        level endon( #"hash_cf82c3aae02337a0" );
        var_4a7e7733c0309baf = squared( 2000 );
        distance_between_zombies = -50;
        base_position = self.origin + anglestoforward( self.angles ) * 80;
        base_position = ( base_position[ 0 ], base_position[ 1 ], self.origin[ 2 ] );
        array = [];
        
        for ( i = 0; i < 8 ; i++ )
        {
            new_position = base_position - anglestoforward( self.angles ) * i * distance_between_zombies;
            array[ i ] = new_position;
        }
        
        var_772501ce9a0c24da = 5;
        
        while ( true )
        {
            zombies = getaiarray( "<dev string:x337>" );
            count = 0;
            
            foreach ( zombie in zombies )
            {
                if ( count >= 8 )
                {
                    break;
                }
                
                if ( !isalive( zombie ) )
                {
                    continue;
                }
                
                if ( distancesquared( self.origin, zombie.origin ) >= var_4a7e7733c0309baf )
                {
                    continue;
                }
                
                zombie setorigin( array[ count ] );
                zombie zombie_stun::stun_ai( var_772501ce9a0c24da );
                count++;
            }
            
            wait var_772501ce9a0c24da + 0.01;
        }
    }

    // Namespace weap_fireflyww
    // Params 0, eflags: 0x4
    // Checksum 0xc7e483bb, Offset: 0x744c
    // Size: 0x1a, Type: dev
    function private function_fb92595d90a0cb5e()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x348>", @"hash_6784d7888dccf093" );
    }

    // Namespace weap_fireflyww
    // Params 0, eflags: 0x4
    // Checksum 0x994cf6e7, Offset: 0x746e
    // Size: 0x1a, Type: dev
    function private function_1b45dd2e3785f597()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:x365>", @"hash_a17c9eea5c534809" );
    }

#/
