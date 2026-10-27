// script_3e1e8a412acb0d30  (hash_3e1e8a412acb0d30.gscc) (size: 5062 Bytes / 0x13c6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5888651d (1485333789)
// size ...... 5062 (0x13c6)
// includes .. 10  (offset: 0x12b2)
// strings ... 14  (offset: 0x1302)
// dev strs .. 1   (offset: 0x13ba)
// exports ... 11  (offset: 0xc62)
// cseg ...... 0x19f + 0xac3 (0xc62)
// imports ... 41  (offset: 0xe1a)
// animtree1 . 0   (offset: 0x13c6)
// animtree2 . 0   (offset: 0x13c6)
#using script_3455b106458253e7;
#using script_34b50456e3922412;
#using script_3ec57c71b0b61f00;
#using script_636bd827a012af12;
#using script_6e05fdc2c6f5fa06;
#using scripts\common\utility;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\damagefeedback;
#using scripts\mp\ob\activities\ob_activity_gunship_heli;
#using scripts\mp\ob\systems\weapons\ob_damage;

#namespace ob_nm_vtol;

// Namespace ob_nm_vtol
// Params 3
// Checksum 0x67d99aee, Offset: 0x1bd
// Size: 0x1b7
function vtol_boss_event( var_dc6a4b4b351da087, encounter_name, var_fcb964ac6f23a112 )
{
    ob_nm_mode::start_of_round_fanfare( "nm_overlord_boss_start", "nm_boss_start" );
    self.var_9be376218db54aba = "sat_ob_objectivemarker_boss";
    
    if ( isdefined( var_fcb964ac6f23a112 ) )
    {
        var_fcb964ac6f23a112 = utility::getstruct( var_fcb964ac6f23a112, "targetname" );
    }
    
    level utility::flag_clear( "nightmare_encouter_done" );
    ob_story_mission_utils::objective_text_show( %"hash_1d6c1f3ae5d084d5" );
    time_modifier = ob_nm_mode::function_3fc7f1f10018b737( 300 );
    ob_story_mission_utils::objective_timer_update( time_modifier );
    level thread ob_nm_mode::wave_fail_timer( time_modifier );
    level.var_a51e7c76bc4bf6e3 = spawn_vtol_boss( var_dc6a4b4b351da087 );
    level.var_a51e7c76bc4bf6e3 thread function_b103014f8ff76a0b();
    thread ob_nm_mode::minion_encounter( encounter_name, "flag_vtol_boss_dead", 1, 3, 1 );
    level.var_a51e7c76bc4bf6e3 waittill( #"death" );
    level utility::flag_set( "flag_vtol_boss_dead" );
    
    foreach ( player in level.players )
    {
        player ob_story_mission_utils::player_boss_healthbar_hide();
    }
    
    level thread ob_nm_mode::function_70467d6be224da52( "nm_overlord_boss_dead" );
    level notify( #"cleanup_minions" );
    level utility::flag_clear( "nightmare_encouter_active" );
    level utility::flag_set( "nightmare_encouter_done" );
    level notify( #"hash_aefc5c470125baf8" );
    level notify( #"stop_circle" );
    ob_nm_mode::end_of_round_fanfare();
}

// Namespace ob_nm_vtol
// Params 1
// Checksum 0x666c9f5e, Offset: 0x37c
// Size: 0x322
function spawn_vtol_boss( var_dc6a4b4b351da087 )
{
    namespace_f2445a4de17ee25::function_316cb76449f3acf7( "vtol", &function_d158eacdf2995e22 );
    ob_activity_gunship_heli::chopper_init();
    function_b4e57201bf2904e3();
    gunship_start = utility::getstruct( var_dc6a4b4b351da087, "targetname" );
    gunship_path_start = gunship_start namespace_be3150865da9d2f1::get_linked_struct();
    gunship_instance = spawnstruct();
    gunship_instance.var_b2596b0f06a9e7a1 = [];
    gunship_instance.bossname = "chopper";
    gunship_instance.var_cb5c81589a3b29d2 = "veh_sat_mil_vtol_ob_gunship_capricorn";
    gunship_instance.spawned = 0;
    gunship_instance.activity = self;
    gunship_instance.var_8c78435105a9f582 = 1;
    gunship_instance.spawnloc = gunship_start.origin;
    gunship_instance.patrolpath = gunship_path_start;
    gunship_instance ob_activity_gunship_heli::chopper_spawn();
    waitframe();
    gunship_instance.boss healthbar_setup();
    gunship_instance.chopper setturningability( 1 );
    gunship_instance.chopper setyawspeed( 250, 100, 50, 0.1 );
    gunship_instance.chopper.spawndata = gunship_instance;
    vehicle_occupancy::register_instance( gunship_instance.chopper );
    gunship_instance.chopper.damagecallback = &function_cf93665547ce031d;
    gunship_instance.chopper.flaresreservecount = 0;
    gunship_instance.chopper function_dd1f33638eed1c98( 0 );
    gunship_instance.chopper.var_9bd743060e96497e = 1;
    gunship_instance.boss.var_39ecac29b0a5f2b = 1;
    gunship_instance.boss.var_eb1bfd65428b7b41 = 1;
    gunship_instance.boss.var_359ce29c63efe084 = [ 0.7, 0.05, 0.02 ];
    gunship_instance.boss.minheight = gunship_start.origin[ 2 ];
    gunship_instance.boss.var_19a36b17776e8e85 = 1;
    gunship_instance.boss.attackcounter = 0;
    gunship_instance.boss.originalspeed = 100;
    gunship_instance.boss.originalaccel = 50;
    gunship_instance.boss vehicle_setspeed( gunship_instance.boss.originalspeed, gunship_instance.boss.originalaccel );
    gunship_instance.chopper.missileweapon = makeweapon( "sat_la_ztron_fireball_virgo" );
    gunship_instance.boss utility::callsharedfunc( #"gametype", #"hash_cbc683d4d23144e5", "veh_sat_mil_vtol_ob_gunship_capricorn" );
    return gunship_instance.boss;
}

// Namespace ob_nm_vtol
// Params 11, eflags: 0x4
// Checksum 0x2f0b010c, Offset: 0x6a7
// Size: 0x68
function private function_d158eacdf2995e22( einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, var_cdd29ad5d1362c2 )
{
    return idamage;
}

// Namespace ob_nm_vtol
// Params 0, eflags: 0x4
// Checksum 0xf2446069, Offset: 0x718
// Size: 0x166
function private function_b4e57201bf2904e3()
{
    minplayersize = level.players.size > 0 ? level.players.size : 1;
    level.var_adaaa86b7b5a18b6 = 100000 * minplayersize;
    level.var_db391e86c6c1bbc2 = 250;
    level.var_c582f0f1f598788e = 2;
    level.var_da9d0112ff45d16b = 6;
    level.var_1c413c0f520b77a1 = 1000;
    level.var_ef819189ba3c6250 = 15000;
    level.var_1b807c86f79fc8d6 = 32;
    level.var_c15d0d0ad1e767fb = 18;
    level.var_3375c4f7793b4ccb = 8;
    level.var_be17f6f2696e1d1a = 2500;
    level.var_1be27c807e9e9d09 = 5.75;
    level.var_679b2cb4aec6cf81 = 0.7;
    level.var_9275920438b54a87 = 4;
    level.var_9298800438db6aa9 = 4;
    level.var_99790c03689d056 = 1.75;
    level.var_146d94309e2e75bb = 2;
    level.var_c915f7191eab3985 = 155;
    level.var_c915f4191eab32ec = 75;
    level.var_c915f5191eab351f = 10;
    level.var_e05429687d6711be = 1;
    level.var_9b32f3255542d1f7 = 12000;
    level.var_89ef72f6589587f0 = 0;
    level.var_99cc0ae0a9c90f54 = 1;
    level.var_a9f499aba9fe4113 = 0;
    level.var_59e1d7f72751378 = 1;
    level.var_6f9c69487979a715 = 1;
    level.var_ac384fdf4664f6cc = 1;
}

// Namespace ob_nm_vtol
// Params 0
// Checksum 0x775ad41d, Offset: 0x886
// Size: 0x8c
function healthbar_setup()
{
    foreach ( player in level.players )
    {
        player ob_story_mission_utils::function_16e0adef86e5d052( "ob_boss_advanced_guild_vtol", self );
        player ob_story_mission_utils::function_e231206f1628d4c6( 1 );
    }
}

// Namespace ob_nm_vtol
// Params 14, eflags: 0x4
// Checksum 0x6a05fb68, Offset: 0x91a
// Size: 0xdf
function private function_cf93665547ce031d( inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid )
{
    if ( namespace_7161222aac9ca916::function_bcc82514dd1dd6ff() )
    {
        if ( level.var_9fe4187b1b7cd52e )
        {
            attacker damagefeedback::updatedamagefeedback( "hitimmune", 0, 0 );
        }
        
        return;
    }
    
    if ( attacker == self )
    {
        return;
    }
    
    damage *= 20;
    [[ level.vehicles.damagecallback ]]( inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid );
}

// Namespace ob_nm_vtol
// Params 1
// Checksum 0x2a3c079f, Offset: 0xa01
// Size: 0x9f
function function_dd1f33638eed1c98( value )
{
    namespace_cf9a4f547edbca10::function_495220db898177a0( value );
    
    foreach ( player in level.players )
    {
        if ( value )
        {
            player ob_story_mission_utils::player_boss_healthbar_immune();
            continue;
        }
        
        player ob_story_mission_utils::player_boss_healthbar_show();
    }
}

// Namespace ob_nm_vtol
// Params 3
// Checksum 0xbc505818, Offset: 0xaa8
// Size: 0xc3
function function_b103014f8ff76a0b( var_22ef1bb6bef5ba13, var_22ef1cb6bef5bc46, rocket_hint_health )
{
    level endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"damage", amount, attacker, direction_vec, point, type, modelname, attachtagname, partname, dflags, objweapon );
        healthbar_update( amount, self.max_health );
    }
}

// Namespace ob_nm_vtol
// Params 2
// Checksum 0x515a9556, Offset: 0xb73
// Size: 0xce
function healthbar_update( damage, max_health )
{
    health_frac = self.health / self.maxhealth;
    
    foreach ( player in level.players )
    {
        if ( self.health > 0 )
        {
            player ob_story_mission_utils::function_e231206f1628d4c6( 1, health_frac * 100, 100 );
            continue;
        }
        
        player ob_story_mission_utils::player_boss_healthbar_hide();
    }
}

/#

    // Namespace ob_nm_vtol
    // Params 1
    // Checksum 0xdc2daaef, Offset: 0xc49
    // Size: 0x19, Type: dev
    function nm_missile_attack( target )
    {
        iprintln( "<dev string:x24>" );
    }

#/
