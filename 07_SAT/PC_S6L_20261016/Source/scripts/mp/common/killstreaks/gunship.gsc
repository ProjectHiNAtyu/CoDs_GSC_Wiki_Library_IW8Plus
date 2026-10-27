// scripts\mp\common\killstreaks\gunship.gsc  (hash_70d399b96f8edd30.gscc) (size: 94128 Bytes / 0x16fb0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcb0c90c5 (3406598341)
// size ...... 94128 (0x16fb0)
// includes .. 26  (offset: 0x155c4)
// strings ... 294 (offset: 0x15694)
// dev strs .. 23  (offset: 0x16c5c)
// exports ... 172 (offset: 0xfcd8)
// cseg ...... 0x1ae3 + 0xe1f5 (0xfcd8)
// imports ... 455 (offset: 0x117b8)
// animtree1 . 1   (offset: 0x16d94)
// animtree2 . 32  (offset: 0x16dac)
#using script_16ea1b94f0f381b3;
#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\killstreaks\killstreak_common;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\scene;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_omnvar_utility;
#using scripts\mp\common\killstreaks\gunship_mp;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\hostmigration;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\sentientpoolmanager;

#namespace gunship;

// Namespace gunship
// Params 0
// Checksum 0x5a6d495c, Offset: 0x1b01
// Size: 0x1be
function init()
{
    bundle = level.streakglobals.streakbundles[ "gunship" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    gunship_mp::init();
    level thread function_e58f6b5192e25a38();
    level function_f256ea7bb93ee165();
    level callback::add( #"player_death", &onplayerdeath );
    
    /#
        setdevdvarifuninitialized( @"scr_gunship_timeout", level.gunshipsettings.gunship_lifetime );
        setdevdvarifuninitialized( @"hash_f49f4fd233809e37", 0 );
        setdevdvarifuninitialized( @"hash_a59a7da9fa17c00", 0 );
        setdevdvarifuninitialized( @"hash_cc9d9505b48bc357", 0 );
        setdevdvarifuninitialized( @"scr_gunship_crash_type", 0 );
        setdevdvarifuninitialized( @"hash_9a9f1499825922aa", 0 );
        setdevdvarifuninitialized( @"scr_debug_gunship", 0 );
        setdevdvarifuninitialized( @"hash_55b253d027368418", 1 );
        setdevdvarifuninitialized( @"hash_9852a22e959385f5", 0 );
        setdevdvarifuninitialized( @"hash_1fa8dffa69ff4ed8", 0 );
        setdevdvarifuninitialized( @"hash_ed9c0ec25e8ecdc8", 0 );
        setdevdvarifuninitialized( @"hash_89d68c6d998d0ebb", 0 );
        setdevdvarifuninitialized( @"scr_debug_gunship_damage_state", 0 );
        setdevdvarifuninitialized( @"hash_e7993fd91f348e3b", 0 );
        setdevdvarifuninitialized( @"hash_923725d8ac07cbfd", 0 );
        setdevdvarifuninitialized( @"hash_ecd4b3e4e39d1b72", 0 );
        setdevdvarifuninitialized( @"hash_44b03914771df268", 0 );
    #/
    
    level initactionsets();
    level initanims();
    level initvo();
    level initfx();
    level function_8f73f88b26913bc1();
    thread function_3253e5cb864786e8();
    utility::registersharedfunc( #"gunship", #"dronegun_emp", &dronegunempapplied );
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0x9ed5dc37, Offset: 0x1cc7
// Size: 0xe, Type: bool
function private weapongivengunship( streakinfo )
{
    return true;
}

// Namespace gunship
// Params 0, eflags: 0x4
// Checksum 0xd5f1f786, Offset: 0x1cde
// Size: 0x52
function private function_e58f6b5192e25a38()
{
    level endon( #"game_ended" );
    utility::flag_wait( "onStartGameTypeFinished" );
    
    if ( isdefined( level.mapcenter ) )
    {
        level.var_98dbb41900a1c266 = level.mapcenter;
        return;
    }
    
    level.var_98dbb41900a1c266 = ( 0, 0, 0 );
}

// Namespace gunship
// Params 0, eflags: 0x4
// Checksum 0xbe7a3fcf, Offset: 0x1d38
// Size: 0xd2d
function private function_f256ea7bb93ee165()
{
    level.gunshipsettings = {};
    level.gunshipsettings.bundle = level.streakglobals.streakbundles[ "gunship" ];
    level.gunshipsettings.streakname = "gunship";
    bundle = level.gunshipsettings.bundle;
    level.gunship_speed[ "move" ] = bundle.gunship_movespeed ?? 250;
    level.gunship_speed[ "rotate" ] = bundle.var_5a39d5c65a452803 ?? 120;
    level.gunshipsettings.gunshipweaponname = bundle.deployweaponname ?? "ks_remote_gunship_mp";
    level.gunshipsettings.starting_weapon_index = bundle.var_fb20540c7689647f ?? 3;
    level.gunshipsettings.var_5e9719bd45e14a53 = bundle.var_5e9719bd45e14a53;
    level.gunshipsettings.var_830820d791a6783a = bundle.var_830820d791a6783a;
    level.gunshipsettings.var_afaeffc7324f7236 = bundle.var_afaeffc7324f7236;
    level.gunshipsettings.var_3edfb285d2efa861 = bundle.var_3edfb285d2efa861 ?? "gunship_25mm_mp";
    level.gunshipsettings.var_8969fe590c36e582 = bundle.var_8969fe590c36e582 ?? "gunship_40mm_mp";
    level.gunshipsettings.gunship_missile_weapon = bundle.gunship_missile_weapon ?? "gunship_hellfire_mp";
    level.gunshipsettings.gunshipintromodel = bundle.gunship_intromodel ?? "veh9_mil_air_gunship";
    level.gunshipsettings.var_8625e7a185efd6a9 = bundle.var_2a731994aaaece1e ?? "veh9_mil_air_gunship_small";
    level.gunshipsettings.var_1b10f71d7a437fb6 = bundle.var_91b7bccce883a863 ?? "ks_gunship_mp_mesh";
    level.gunshipsettings.var_c47e9ebf69d1024c = bundle.var_2439d410fc37c529 ?? "ks_gunship_mp";
    level.gunshipsettings.gunshiphealth = bundle.maxhealth ?? 1000;
    level.gunshipsettings.gunship_lifetime = bundle.gunship_lifetime ?? 45;
    level.gunshipsettings.gunship_flarescount = bundle.gunship_flarescount ?? 2;
    level.gunshipsettings.var_da5345e316d69de5 = bundle.var_da5345e316d69de5 ?? 15;
    level.gunshipsettings.var_7dae8eac0f4e2c4d = bundle.var_7dae8eac0f4e2c4d ?? 3;
    level.gunshipsettings.var_af7b727c426a923e = bundle.var_af7b727c426a923e ?? 750;
    level.gunshipsettings.var_7063645f39c4e8a9 = bundle.var_7063645f39c4e8a9 ?? 500;
    level.gunshipsettings.var_268c9e4d27c54be8 = bundle.var_268c9e4d27c54be8 ?? 250;
    level.gunshipsettings.var_2a3a48b766451677 = bundle.var_2a3a48b766451677 ?? 0.33;
    level.gunshipsettings.var_86e7453202e9136e = bundle.var_9b389ea300afc528 ?? "maaws_reticle_tracking";
    level.gunshipsettings.var_32cf511b535edae2 = bundle.var_f7066422a0a10d20 ?? "ac130_25mm_fire";
    level.gunshipsettings.var_9e3f4922db98b423 = bundle.var_92335b86cfbf1a9 ?? "maaws_reticle_locked";
    level.gunshipsettings.var_581289a0c3b74aa9 = bundle.var_c43106544e0858a3 ?? "ac130_25mm_fire";
    level.gunshipsettings.var_3f42768381334bfa = istrue( bundle.var_3f42768381334bfa );
    level.gunshipsettings.var_1f29af48422f9483 = bundle.var_3d9c853ae933bdc7 && isdefined( level.gunshipsettings.var_afaeffc7324f7236 ) && isdefined( level.gunshipsettings.var_830820d791a6783a ) && isdefined( level.gunshipsettings.var_5e9719bd45e14a53 );
    level.gunshipsettings.var_37213baa31c85bcc = istrue( bundle.var_530aae406c1a6a84 );
    level.gunshipsettings.var_d3375d11c0ccfdde = istrue( bundle.var_d9cde7c4561c22d );
    level.gunshipsettings.var_f6dc45b7d0c693ea = isdefined( bundle.var_24bdaa7fb61065e8 );
    level.gunshipsettings.var_98db2718a76c31fb = bundle.var_24bdaa7fb61065e8;
    level.gunshipsettings.var_b625d3773a2c5a1b = istrue( bundle.var_126c707249182207 );
    level.gunshipsettings.var_190c63df5f5371f0 = bundle.var_e1e9444027b8aa61 ?? 0.15;
    level.gunshipsettings.var_6f3e461922ca6886 = bundle.var_de82d1631f99b23d ?? 0.15;
    level.gunshipsettings.var_5f7f3fa06b25e3e1 = bundle.var_98a79fb63b1323bc ?? 0.25;
    level.gunshipsettings.var_1d543c4b5a8c5abd = bundle.var_93de0d62a7d954f2 ?? 0.2;
    level.gunshipsettings.var_dfed95600552872 = bundle.var_48a027ed68400bd ?? 0.2;
    level.gunshipsettings.var_72a49deb1d4ec8f0 = bundle.var_e9111b7c6d57cac9 ?? 1;
    level.gunshipsettings.var_281a6e7f3d0c6719 = bundle.var_8de716ed336c51e ?? 0.125;
    level.gunshipsettings.var_50c6d899745b6485 = bundle.var_ee4d3eb962d8488c ?? 0.5;
    level.gunshipsettings.var_92ca6bfce725bc61 = bundle.var_92ca6bfce725bc61 ?? 0.1;
    level.gunshipsettings.var_4803b04008a3b83d = bundle.var_4803b04008a3b83d ?? 0.5;
    level.gunshipsettings.var_573e81858665c43e = bundle.var_3e8c3cc808a26a23 ?? 0.25;
    level.gunshipsettings.var_6934dc1897daba2c = bundle.var_32122fba6797426f ?? 2;
    level.gunshipsettings.var_59bd70f71e98149 = bundle.var_e9cd76f125370a8a ?? -2;
    level.gunshipsettings.var_15b893825838499f = bundle.var_3e3a1c4b2bbcfcb7 ?? 1;
    level.gunshipsettings.var_2cc09ae2dee32ec4 = bundle.var_9f898ebe6e8aba1c ?? 1;
    level.gunshipsettings.var_e657fae18cf76e0 = bundle.var_924a01a18c7945a4 ?? 1;
    level.gunshipsettings.applyoutlines = bundle.var_34f5bb83deaf41e9 ?? 0;
    level.gunshipsettings.var_986adc36e6ac981b = !level.gunshipsettings.applyoutlines;
    level.gunshipsettings.var_7d98054b482fa45c = bundle.var_2e5bfcf74c419f88 ?? 0;
    level.gunshipsettings.var_e41d5294c7366ac8 = istrue( bundle.var_e41d5294c7366ac8 );
    level.var_6b27ab061f7b8da9 = makeweapon( level.gunshipsettings.gunshipweaponname );
    level.physicssphereradius[ level.gunshipsettings.var_3edfb285d2efa861 ] = bundle.var_1fbe2905dedd25eb ?? 60;
    level.physicssphereradius[ level.gunshipsettings.var_8969fe590c36e582 ] = bundle.var_f6227ee61bc62732 ?? 600;
    level.physicssphereradius[ level.gunshipsettings.gunship_missile_weapon ] = bundle.var_97375da621d3e786 ?? 1000;
    level.physicssphereforce[ level.gunshipsettings.var_3edfb285d2efa861 ] = bundle.var_2f06cc2092dba80c ?? 0;
    level.physicssphereforce[ level.gunshipsettings.var_8969fe590c36e582 ] = bundle.var_e83a04b986f077f ?? 3;
    level.physicssphereforce[ level.gunshipsettings.gunship_missile_weapon ] = bundle.var_76875f7dbaa43f33 ?? 6;
    level.weaponreloadtime[ level.gunshipsettings.var_3edfb285d2efa861 ] = bundle.var_1890e39fd6f7cb8c ?? 2;
    level.weaponreloadtime[ level.gunshipsettings.var_8969fe590c36e582 ] = bundle.var_88e5faf537fee7a7 ?? 4;
    level.weaponreloadtime[ level.gunshipsettings.gunship_missile_weapon ] = bundle.var_f44e93f0ab3ecf06 ?? 6;
    level.gunshipsettings.flarefx = bundle.var_c220a3a2930b697f ?? "vfx_iw8_mp_strk_ac130_flares";
    level.gunshipsettings.var_d3b98880b1fa4c8e = bundle.var_ba939d791d11f30b ?? "tag_left_outer_prop";
    level.gunshipsettings.var_d0e262d42566e01 = bundle.var_49d685ae084790d2 ?? "tag_right_outer_prop";
    level.gunshiprigs = [];
    level.gunship_lockon = getdvarint( @"hash_55b253d027368418", 1 );
    
    if ( level.gunshipsettings.var_e41d5294c7366ac8 )
    {
        level.gunshipsettings.bombhealth = bundle.var_1c4975504f1350e0 ?? 500;
        level.gunshipsettings.bombmaxdamage = bundle.var_196e48f7e47e1bd ?? 500;
        level.gunshipsettings.bombmindamage = bundle.var_29da3ceab124854b ?? 10;
        level.gunshipsettings.var_b28f35adb63a9d70 = bundle.var_8d5b68fb30e65adc ?? 700;
        level.gunshipsettings.var_4568e4427c094610 = bundle.var_68851c36cd8fd136 ?? 700;
        level.gunshipsettings.var_10d024f3e1978f85 = bundle.var_3cde052e10af265f ?? 150;
        level.gunshipsettings.var_1b5b99ac89b38d47 = bundle.var_10e628492fbfb045 ?? 200;
        level.gunshipsettings.var_db3a7294c8e2dd4c = bundle.var_1f900f36d6dcbf6d ?? 0.75;
        level.gunshipsettings.var_5040220f808d8fe2 = bundle.var_ab6b014a203989d9 ?? 1.6;
        level.gunshipsettings.var_8873162f0a9643fc = bundle.var_82a07f22614ec667 ?? 2000;
        level.gunshipsettings.bombweapon = bundle.projectileweapon;
    }
    
    killstreak_utility::registervisibilityomnvarforkillstreak( "gunship", "on", 9 );
    namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "gunship", level.gunshipsettings.var_3edfb285d2efa861, #"oneshot" );
    namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "gunship", level.gunshipsettings.var_8969fe590c36e582, #"oneshot" );
    namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "gunship", level.gunshipsettings.gunship_missile_weapon, #"oneshot" );
    
    if ( level.gunshipsettings.var_e41d5294c7366ac8 )
    {
        namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "gunship", level.gunshipsettings.bombweapon, #"large" );
    }
}

// Namespace gunship
// Params 0, eflags: 0x4
// Checksum 0x424c7e0e, Offset: 0x2a6d
// Size: 0x76
function private initactionsets()
{
    val::group_register( "gunshipCutScene", [ "fire", "offhand_weapons" ] );
    val::group_register( "gunshipInUse", [ "killstreaks", "allow_movement", "weapon_switch", "melee", "usability", "supers", "gesture", "shellshock" ] );
}

#using_animtree( "script_model" );

// Namespace gunship
// Params 0, eflags: 0x4
// Checksum 0x1d33f6fb, Offset: 0x2aeb
// Size: 0x69f
function private initanims()
{
    bundle = level.streakglobals.streakbundles[ "gunship" ];
    level.scr_animtree[ "gunship" ] = #animtree;
    animindex = "intro_gunship";
    level.scr_anim[ "gunship" ][ animindex ] = %mp_acharlie130_intro;
    animindex = "intro_gunship_exterior";
    level.scr_anim[ "gunship" ][ animindex ] = %iw9_mp_acharlie130_intro;
    animindex = "intro_gunner";
    level.scr_anim[ "gunship" ][ animindex ] = %vm_ks_gunship_player_intro;
    animindex = "intro_co_gunner";
    level.scr_anim[ "gunship" ][ animindex ] = %wm_ks_gunship_pilot2_intro;
    animindex = "intro_desk";
    level.scr_anim[ "gunship" ][ animindex ] = %vm_ks_gunship_desk_intro;
    animindex = "intro_clipboard_1";
    level.scr_anim[ "gunship" ][ animindex ] = %vm_ks_gunship_clipboard1_intro;
    animindex = "intro_clipboard_2";
    level.scr_anim[ "gunship" ][ animindex ] = %vm_ks_gunship_clipboard2_intro;
    animindex = "intro_paper";
    level.scr_anim[ "gunship" ][ animindex ] = %vm_ks_gunship_paper1_intro;
    animindex = "intro_pen_1";
    level.scr_anim[ "gunship" ][ animindex ] = %vm_ks_gunship_pen1_intro;
    animindex = "intro_pen_2";
    level.scr_anim[ "gunship" ][ animindex ] = %vm_ks_gunship_pen2_intro;
    animindex = "intro_smartphone";
    level.scr_anim[ "gunship" ][ animindex ] = %vm_ks_gunship_smartphone1_intro;
    animindex = "intro_tablet";
    level.scr_anim[ "gunship" ][ animindex ] = %vm_ks_gunship_tablet1_intro;
    animindex = "intro_binder";
    level.scr_anim[ "gunship" ][ animindex ] = %vm_ks_gunship_binder_intro;
    animindex = "intro_joystick";
    level.scr_anim[ "gunship" ][ animindex ] = %vm_ks_gunship_joystick_intro;
    animindex = "outro_gunner";
    level.scr_anim[ "gunship" ][ animindex ] = %vm_ks_gunship_player_outro;
    animindex = "outro_co_gunner";
    level.scr_anim[ "gunship" ][ animindex ] = %wm_ks_gunship_pilot2_outro;
    animindex = "outro_desk";
    level.scr_anim[ "gunship" ][ animindex ] = %vm_ks_gunship_desk_outro;
    animindex = "outro_clipboard_1";
    level.scr_anim[ "gunship" ][ animindex ] = %vm_ks_gunship_clipboard1_outro;
    animindex = "outro_clipboard_2";
    level.scr_anim[ "gunship" ][ animindex ] = %vm_ks_gunship_clipboard2_outro;
    animindex = "outro_paper";
    level.scr_anim[ "gunship" ][ animindex ] = %vm_ks_gunship_paper1_outro;
    animindex = "outro_pen_1";
    level.scr_anim[ "gunship" ][ animindex ] = %vm_ks_gunship_pen1_outro;
    animindex = "outro_pen_2";
    level.scr_anim[ "gunship" ][ animindex ] = %vm_ks_gunship_pen2_outro;
    animindex = "outro_smartphone";
    level.scr_anim[ "gunship" ][ animindex ] = %vm_ks_gunship_smartphone1_outro;
    animindex = "outro_tablet";
    level.scr_anim[ "gunship" ][ animindex ] = %vm_ks_gunship_tablet1_outro;
    animindex = "outro_binder";
    level.scr_anim[ "gunship" ][ animindex ] = %vm_ks_gunship_binder_outro;
    animindex = "outro_joystick";
    level.scr_anim[ "gunship" ][ animindex ] = %vm_ks_gunship_joystick_outro;
    animindex = "outro_gunship_death";
    level.scr_anim[ "gunship" ][ animindex ] = bundle.var_70f5835defc4b6bc.animname.id ?? %mp_acharlie130_death;
    function_ea30d1da5c77df12( "gunship" );
    
    if ( level.gunshipsettings.var_e41d5294c7366ac8 )
    {
        level.scr_animtree[ "gunship_bomb" ] = #animtree;
        animindex = "bomb_drop";
        level.scr_anim[ "gunship_bomb" ][ animindex ] = bundle.var_3f1e8f123843c0f6.animname.id ?? %mp_carepackage_ckpg_flyin_10500;
        level.scr_animtree[ "gunship_chute" ] = #animtree;
        animindex = "bomb_drop_chute";
        level.scr_anim[ "gunship_chute" ][ animindex ] = bundle.var_7f6c2c1a3b110f6b.animname.id ?? %mp_carepackage_parachute_flyin_10500;
        level.scr_animtree[ "gunship_bomb_sled" ] = #animtree;
        animindex = "bomb_drop_sled";
        level.scr_anim[ "gunship_bomb_sled" ][ animindex ] = bundle.var_7839801103aecc94.animname.id ?? %t10_killstreak_gunboat_sled_flyin_3000;
        function_ea30d1da5c77df12( "gunship_bomb" );
        function_ea30d1da5c77df12( "gunship_chute" );
        function_ea30d1da5c77df12( "gunship_bomb_sled" );
    }
    
    level.var_a9e2be5d10e14c84 = [];
    level.var_a9e2be5d10e14c84[ "gunship_exterior" ] = level.gunshipsettings.gunshipintromodel;
    level.var_a9e2be5d10e14c84[ "gunner" ] = "body_sp_ally_sensor_operator_vm_1_1_noface";
    level.var_a9e2be5d10e14c84[ "co_gunner" ] = "fullbody_sp_ally_sensor_operator_wm_1_1";
    level.var_a9e2be5d10e14c84[ "desk" ] = "misc_gunship_interior_desk";
    level.var_a9e2be5d10e14c84[ "clipboard_1" ] = "misc_un_office_clipboard_01";
    level.var_a9e2be5d10e14c84[ "clipboard_2" ] = "misc_un_office_clipboard_01";
    level.var_a9e2be5d10e14c84[ "paper" ] = "misc_un_office_paper_01";
    level.var_a9e2be5d10e14c84[ "pen_1" ] = "misc_un_office_pen_01";
    level.var_a9e2be5d10e14c84[ "pen_2" ] = "misc_un_office_pen_01";
    level.var_a9e2be5d10e14c84[ "smartphone" ] = "offhand1h_smartphone_static_v0";
    level.var_a9e2be5d10e14c84[ "tablet" ] = "offhand2h_tablet_static_v0";
    level.var_a9e2be5d10e14c84[ "binder" ] = "misc_un_office_binder_open";
    level.var_a9e2be5d10e14c84[ "joystick" ] = "misc_gunship_interior_joystick";
    level.gunship_animtype = getdvarint( @"hash_a59a7da9fa17c00", 0 );
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0x7f95adc7, Offset: 0x3192
// Size: 0x97
function private function_ea30d1da5c77df12( animgroupname )
{
    foreach ( animindex, scr_anim in level.scr_anim[ animgroupname ] )
    {
        level.scr_animlength[ animgroupname ][ animindex ] = animation::get_scr_animlength( animgroupname, animindex );
    }
}

// Namespace gunship
// Params 0, eflags: 0x4
// Checksum 0xdcd03b36, Offset: 0x3231
// Size: 0x211
function private initvo()
{
    game[ "dialog" ][ "gunship" + "_use" ] = "killstreak_remote_operator" + "_request_response";
    game[ "dialog" ][ "gunship" + "_leave" ] = "killstreak_remote_operator" + "_leave";
    game[ "dialog" ][ "gunship" + "_engage" ] = "killstreak_remote_operator" + "_engage";
    game[ "dialog" ][ "gunship" + "_random_radio" ] = "killstreak_remote_operator" + "_radio_chatter";
    game[ "dialog" ][ "gunship" + "_flares" ] = "killstreak_remote_operator" + "_flare_release";
    game[ "dialog" ][ "gunship" + "_light_damage" ] = "killstreak_remote_operator" + "_light_damage";
    game[ "dialog" ][ "gunship" + "_med_damage" ] = "killstreak_remote_operator" + "_med_damage";
    game[ "dialog" ][ "gunship" + "_heavy_damage" ] = "killstreak_remote_operator" + "_heavy_damage";
    game[ "dialog" ][ "gunship" + "_lockedon" ] = "killstreak_remote_operator" + "_missile_lock_warning";
    game[ "dialog" ][ "gunship" + "_crash" ] = "killstreak_remote_operator" + "_crash";
    game[ "dialog" ][ "gunship" + "_hit_target" ] = "killstreak_remote_operator" + "_hit_target";
    game[ "dialog" ][ "gunship" + "_miss_target" ] = "killstreak_remote_operator" + "_miss_target";
    game[ "dialog" ][ "gunship" + "_spotted_single_target" ] = "killstreak_remote_operator" + "_target_spotted_single";
    game[ "dialog" ][ "gunship" + "_spotted_multi_target" ] = "killstreak_remote_operator" + "_miss_target";
    game[ "dialog" ][ "gunship" + "_hellfire_reload" ] = "killstreak_remote_operator" + "_hellfire_reload";
    game[ "dialog" ][ "gunship" + "_40mm_reload" ] = "killstreak_remote_operator" + "_40mm_reload";
    game[ "dialog" ][ "gunship" + "_25mm_reload" ] = "killstreak_remote_operator" + "_25mm_reload";
}

// Namespace gunship
// Params 0, eflags: 0x4
// Checksum 0x438c888a, Offset: 0x344a
// Size: 0x88
function private initfx()
{
    if ( !level.gunshipsettings.var_b625d3773a2c5a1b )
    {
        level._effect[ "clouds" ] = loadfxasset( "vfx_iw8_mp_strk_ac130_view_clouds" );
    }
    
    level._effect[ "gunship_flares" ] = loadfxasset( level.gunshipsettings.flarefx );
    
    if ( level.gunshipsettings.var_2cc09ae2dee32ec4 )
    {
        level._effect[ "camera_spotlight" ] = loadfxasset( "vfx_iw8_mp_strk_ac130_ir_spotlight" );
    }
}

// Namespace gunship
// Params 0, eflags: 0x4
// Checksum 0x9ff596b0, Offset: 0x34da
// Size: 0x116
function private function_8f73f88b26913bc1()
{
    if ( isdefined( level.gunshipvisionset ) )
    {
        killstreak_shared::function_28d986de72ce85f8( level.gunshipvisionset );
    }
    
    bundle = level.streakglobals.streakbundles[ "gunship" ];
    
    if ( isdefined( bundle.var_267384a0c5d77a8a ) )
    {
        killstreak_shared::function_28d986de72ce85f8( bundle.var_267384a0c5d77a8a );
    }
    
    if ( isdefined( bundle.var_f50cdf51c024eae2 ) )
    {
        killstreak_shared::function_28d986de72ce85f8( bundle.var_f50cdf51c024eae2 );
    }
    
    if ( isdefined( bundle.var_9436c6e87cde5928 ) )
    {
        killstreak_shared::function_28d986de72ce85f8( bundle.var_9436c6e87cde5928, 0.1, 0.2, 0.5 );
    }
    
    if ( isdefined( bundle.var_5d769cc8c879f535 ) )
    {
        killstreak_shared::function_28d986de72ce85f8( bundle.var_5d769cc8c879f535, 0.1, 0.1, 0.3 );
    }
    
    if ( isdefined( bundle.var_d8f5d2fd737152a0 ) )
    {
        killstreak_shared::function_28d986de72ce85f8( bundle.var_d8f5d2fd737152a0, 0.1, 0.1, 0.2 );
    }
}

// Namespace gunship
// Params 0
// Checksum 0xb3863d, Offset: 0x35f8
// Size: 0x22
function tryusegunship()
{
    streakinfo = killstreak_utility::createstreakinfo( "gunship", self );
    return tryusegunshipfromstruct( streakinfo );
}

// Namespace gunship
// Params 1
// Checksum 0x49938c1, Offset: 0x3623
// Size: 0x23d
function tryusegunshipfromstruct( streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self notify( #"using_remote" );
    streakinfo.var_5c576910469d4fde = &function_5c576910469d4fde;
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return 0;
        }
    }
    
    self setclientomnvar( "ui_gunship_active", 1 );
    deployresult = namespace_9d8e359c3b1041e5::streakdeploy_doweapontabletdeploysharedfunc( streakinfo, &function_d31b358aaf49c03b, streakinfo.weaponswitchendedcallback, undefined, &function_95433b622dc0cd59, level.gunshipsettings.gunshipweaponname );
    
    if ( !deployresult )
    {
        return 0;
    }
    
    streakinfo.streakduration = level.gunshipsettings.gunship_lifetime;
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
            return 0;
        }
    }
    
    if ( level.gameended )
    {
        streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
        return 0;
    }
    
    result = startuse( self, streakinfo );
    
    if ( !result )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"KILLSTREAKS/AIR_SPACE_TOO_CROWDED" );
        }
        
        streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
        return 0;
    }
    
    killstreak_utility::function_e4f54128963e182( level.gunshipsettings.gunship_missile_weapon );
    killstreak_utility::function_3fcc14f5507d62f4( level.gunshipsettings.gunship_missile_weapon, level.gunshipsettings.var_8969fe590c36e582 );
    killstreak_utility::function_3fcc14f5507d62f4( level.gunshipsettings.gunship_missile_weapon, level.gunshipsettings.var_3edfb285d2efa861 );
    
    if ( level.gunshipsettings.var_e41d5294c7366ac8 )
    {
        killstreak_utility::function_3fcc14f5507d62f4( level.gunshipsettings.gunship_missile_weapon, level.gunshipsettings.bombweapon );
    }
    
    return result;
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0xacd578c3, Offset: 0x3869
// Size: 0xe, Type: bool
function private function_d31b358aaf49c03b( streakinfo )
{
    return true;
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0x5e18e882, Offset: 0x3880
// Size: 0x18
function private function_95433b622dc0cd59( streakinfo )
{
    self notify( #"finished_deploy_weapon" );
}

// Namespace gunship
// Params 2, eflags: 0x4
// Checksum 0x24c69dda, Offset: 0x38a0
// Size: 0xe0
function private function_db20416dd6bce29b( owner, streakinfo )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    owner endon( #"disconnect" );
    
    if ( utility::issharedfuncdefined( #"killstreak", #"allowridekillstreakplayerexit" ) )
    {
        self thread [[ utility::getsharedfunc( #"killstreak", #"allowridekillstreakplayerexit" ) ]]();
    }
    
    self waittill( #"killstreakexit" );
    
    if ( level.gunshipsettings.var_b625d3773a2c5a1b )
    {
        level game_utility::fadetoblackforplayer( owner, 1, 0.3 );
        level thread game_utility::fadetoblackforplayer( owner, 0, 0 );
        thread leave( owner, streakinfo );
        return;
    }
    
    thread leave( owner, streakinfo );
}

// Namespace gunship
// Params 2, eflags: 0x4
// Checksum 0x21ecb24a, Offset: 0x3988
// Size: 0x79e, Type: bool
function private startuse( player, streakinfo )
{
    level endon( #"game_ended" );
    
    if ( utility::issharedfuncdefined( #"game", #"disable_backpack_inventory" ) )
    {
        player [[ utility::getsharedfunc( #"game", #"disable_backpack_inventory" ) ]]( 1 );
    }
    
    player function_134cd2c60d3a7edf( 0 );
    player val::group_set( "gunshipInUse", 0 );
    launchorigin = level.var_98dbb41900a1c266;
    
    if ( game_utility::islargemap() )
    {
        if ( level.gametype == "arm" || level.gametype == "conflict" || level.gametype == "gwtdm" )
        {
            if ( isdefined( level.hqmidpoint ) )
            {
                launchorigin = level.hqmidpoint;
            }
            else if ( isdefined( level.gunship_origin_override ) )
            {
                launchorigin = level.gunship_origin_override;
            }
        }
        else
        {
            launchorigin = player.origin;
        }
    }
    else if ( level.gametype == "dd" )
    {
        launchorigin = player.origin;
    }
    
    var_f0574b4cc0f1975a = function_cfa7457e008e0496( player, launchorigin );
    
    if ( !isdefined( var_f0574b4cc0f1975a ) )
    {
        return false;
    }
    
    bundle = level.streakglobals.streakbundles[ "gunship" ];
    introangle = randomint( 360 );
    radiusoffset = 9000;
    zoffset = 8000;
    
    foreach ( map in bundle.var_5eff0b1b3fceefe8 )
    {
        if ( issubstr( level.mapname, map.name ) )
        {
            if ( isdefined( map.gunship_radiusoffset ) )
            {
                radiusoffset = map.gunship_radiusoffset;
            }
            
            if ( isdefined( map.gunship_zoffset ) )
            {
                zoffset += map.gunship_zoffset;
            }
            
            break;
        }
    }
    
    /#
        var_e7b0b9270f1a2621 = getdvarint( @"hash_9852a22e959385f5", 0 );
        zoffset += var_e7b0b9270f1a2621;
        radiusoffsetoverride = getdvarint( @"scr_gunship_radiusoffset_override", 0 );
        
        if ( radiusoffsetoverride != 0 )
        {
            radiusoffset = radiusoffsetoverride;
        }
        
        zoffsetoverride = getdvarint( @"scr_gunship_zoffset_override", 0 );
        
        if ( zoffsetoverride != 0 )
        {
            zoffset = 8000 + zoffsetoverride;
        }
    #/
    
    xoffset = cos( introangle ) * radiusoffset;
    yoffset = sin( introangle ) * radiusoffset;
    introanglevector = vectornormalize( ( xoffset, yoffset, zoffset ) );
    introanglevector *= zoffset;
    level.gunshipinuse = 1;
    gunshipintro = playintro( player, streakinfo, introangle, introanglevector, var_f0574b4cc0f1975a );
    
    if ( !isdefined( gunshipintro ) )
    {
        level.gunshipinuse = 0;
        level callback::callback( #"killstreak_finish_use", { #streakinfo:streakinfo } );
        return false;
    }
    
    gunship = spawngunship( player, streakinfo, introangle, introanglevector, gunshipintro, var_f0574b4cc0f1975a );
    gunship.var_f0574b4cc0f1975a = var_f0574b4cc0f1975a;
    
    if ( isent( gunshipintro ) )
    {
        gunshipintro delete();
    }
    
    /#
        gunship thread _watch_dvars( gunship, player );
    #/
    
    if ( level.killstreak_emp_initialized )
    {
        gunship.ksempapplycallback = &empapplied;
    }
    
    if ( !isdefined( gunship ) )
    {
        level.gunshipinuse = 0;
        return false;
    }
    
    if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
    {
        thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( "used_gunship", player );
    }
    
    if ( level.forcethirdperson )
    {
        if ( utility::issharedfuncdefined( #"player", #"hash_c2eed707cc193392" ) )
        {
            player [[ utility::getsharedfunc( #"player", #"hash_c2eed707cc193392" ) ]]( 0 );
        }
    }
    
    if ( utility::issharedfuncdefined( #"killstreak", #"addtoactivekillstreaklist" ) )
    {
        gunship [[ utility::getsharedfunc( #"killstreak", #"addtoactivekillstreaklist" ) ]]( gunship.streakinfo.streakname, "Killstreak_Air", player );
    }
    
    if ( utility::issharedfuncdefined( #"flare_system", #"defender_init" ) )
    {
        gunship [[ utility::getsharedfunc( #"flare_system", #"defender_init" ) ]]( gunship.flaresreservecount, level.gunshipsettings.var_da5345e316d69de5, level.gunshipsettings.var_7dae8eac0f4e2c4d );
    }
    
    weapon_utility::setlockedoncallback( gunship, &lockedoncallback );
    weapon_utility::setlockedonremovedcallback( gunship, &lockedonremovedcallback );
    player function_eb00542899b022bf( 1 );
    
    if ( gunship getscriptablehaspart( "audio_engine_sounds" ) )
    {
        gunship setscriptablepartstate( "audio_engine_sounds", "on" );
    }
    
    gunship attachgunner( player );
    gunship thread function_b8735eee6e218a26( player );
    gunship thread watchweaponfired( player );
    
    if ( level.gunshipsettings.var_2cc09ae2dee32ec4 )
    {
        gunship thread function_2cc09ae2dee32ec4( player );
    }
    
    gunship thread watchdamage( player );
    
    if ( level.gunshipsettings.applyoutlines )
    {
        gunship thread applyoutlines();
        player function_a03d91ac6446bf35();
    }
    
    gunship thread function_c3b770691f1a9620( player, streakinfo );
    gunship thread watchgameend( player, streakinfo );
    gunship thread watchownerlookat( player );
    
    if ( level.gunshipsettings.var_15b893825838499f )
    {
        gunship thread function_15b893825838499f( player );
    }
    
    gunship thread watchownerexitaction( player, "disconnect", streakinfo );
    gunship thread watchownerexitaction( player, "joined_team", streakinfo );
    gunship thread watchownerexitaction( player, "joined_spectators", streakinfo );
    gunship thread watchownerexitaction( player, "team_kill_punish", streakinfo );
    
    if ( level.gunshipsettings.var_e657fae18cf76e0 )
    {
        gunship thread watchownerexitaction( player, "player_fatal_death" );
    }
    
    gunship thread function_a780979c2ed97570( player );
    
    if ( level.gunshipsettings.var_3f42768381334bfa )
    {
        gunship thread watchflares( gunship, player );
    }
    
    gunship thread function_69e38913f7064023( player );
    
    if ( !level.gunshipsettings.var_b625d3773a2c5a1b )
    {
        gunship thread function_368a8a0dab1a6640( player );
    }
    
    gunship thread function_9f2d57938d3c3109();
    gunship thread function_93a4ea4df3da9d39();
    gunship thread function_db20416dd6bce29b( player, streakinfo );
    gunship thread function_8cbfb7e011013aaa( player );
    gunship thread watchtargets( player );
    gunship thread function_e0793e6ee5c08cbb( player );
    
    /#
        thirdpersoncam = getdvarint( @"hash_f49f4fd233809e37", 0 );
        
        if ( thirdpersoncam )
        {
            gunship thread function_8b30c5afebb93084();
            gunship thread watchplanedistance( var_f0574b4cc0f1975a );
        }
    #/
    
    if ( !level.gunshipsettings.var_3f42768381334bfa )
    {
        if ( utility::issharedfuncdefined( #"flares", #"hash_c8c23ade5da7f4bb" ) )
        {
            gunship thread [[ utility::getsharedfunc( #"flares", #"hash_c8c23ade5da7f4bb" ) ]]( &handlemissiledetection );
        }
    }
    
    if ( player.ksempd )
    {
        gunship thread crash( player );
    }
    
    return true;
}

// Namespace gunship
// Params 0, eflags: 0x4
// Checksum 0x51f3f288, Offset: 0x412f
// Size: 0x9b
function private function_a03d91ac6446bf35()
{
    bundle = level.streakglobals.streakbundles[ "gunship" ];
    
    if ( isdefined( bundle.var_715ee0e8aa8d7659 ) && isdefined( bundle.var_715ee0e8aa8d7659 ) )
    {
        fullscreenfxparams = { #visionset:bundle.var_425a3dfcedfca72e, #postfxbundlename:bundle.var_715ee0e8aa8d7659 };
        self [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_d6d2b1e7868b8f30" ] ]]( fullscreenfxparams );
    }
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0x3411c854, Offset: 0x41d2
// Size: 0x39
function private clearfullscreenfx( var_effab7a63f64cd3d )
{
    self [[ level.sharedfuncs[ #"fullscreenfx" ][ #"hash_fd9af8d6ec7cc6fb" ] ]]( { #postfxbundlename:var_effab7a63f64cd3d } );
}

// Namespace gunship
// Params 2, eflags: 0x4
// Checksum 0x99cf18b1, Offset: 0x4213
// Size: 0xdf
function private function_cfa7457e008e0496( owner, launchorigin )
{
    gunshiprig = undefined;
    
    if ( !game_utility::islargemap() )
    {
        if ( level.gunshiprigs.size > 0 )
        {
            gunshiprig = level.gunshiprigs[ 0 ];
        }
    }
    else if ( isdefined( level.gunshiprigs ) && level.gunshiprigs.size >= 1 )
    {
        return;
    }
    
    if ( !isdefined( gunshiprig ) )
    {
        gunshiprig = spawn( "script_model", launchorigin );
        gunshiprig setmodel( "tag_origin" );
        gunshiprig.angles = ( 0, 115, 0 );
        gunshiprig hide();
        level.gunshiprigs[ level.gunshiprigs.size ] = gunshiprig;
        gunshiprig thread function_6b3f5c495f61451d();
        
        if ( !game_utility::islargemap() )
        {
            gunshiprig thread function_c9d578fd190af200();
        }
    }
    
    return gunshiprig;
}

// Namespace gunship
// Params 1
// Checksum 0x951995a5, Offset: 0x42fb
// Size: 0x159
function onplayerdeath( params )
{
    if ( isdefined( self.var_6ad7cfadfe8874f ) )
    {
        self.var_6ad7cfadfe8874f = undefined;
    }
    
    if ( params.inflictor.streakinfo.streakname != "gunship" )
    {
        return;
    }
    
    inflictorweaponname = params.inflictor.weapon_name;
    
    if ( !isdefined( inflictorweaponname ) )
    {
        return;
    }
    
    if ( inflictorweaponname == level.gunshipsettings.var_3edfb285d2efa861 )
    {
        params.inflictor.owner thread function_73d9e3763f49caaa( params.inflictor.streakinfo );
        return;
    }
    
    if ( inflictorweaponname == level.gunshipsettings.var_8969fe590c36e582 )
    {
        params.inflictor.owner thread function_e2353fad8274ac75( params.inflictor.streakinfo );
        return;
    }
    
    if ( inflictorweaponname == level.gunshipsettings.gunship_missile_weapon )
    {
        params.inflictor.owner thread function_7ec3f8629354ba7f( params.inflictor.streakinfo );
    }
}

// Namespace gunship
// Params 1
// Checksum 0x8bff2a29, Offset: 0x445c
// Size: 0xcf
function function_73d9e3763f49caaa( streakinfo )
{
    self notify( #"hash_a6fa815d5d5cb033" );
    self endon( #"hash_a6fa815d5d5cb033" );
    
    if ( !isdefined( self.var_927556e8907f11d0 ) )
    {
        self.var_927556e8907f11d0 = 0;
    }
    
    self.var_927556e8907f11d0 += 1;
    wait 2;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    weaponstr = "20mm";
    dialogueref = self.var_927556e8907f11d0 > 3 ? hashcat( #"kill_", weaponstr, "_mult" ) : hashcat( #"kill_", weaponstr, "_", self.var_927556e8907f11d0 );
    thread killstreak_utility::playkillstreaktacomdialog( streakinfo, undefined, dialogueref, 1 );
    self.var_927556e8907f11d0 = undefined;
}

// Namespace gunship
// Params 1
// Checksum 0x308b67a7, Offset: 0x4533
// Size: 0xcf
function function_e2353fad8274ac75( streakinfo )
{
    self notify( #"hash_5a4b6d8248041472" );
    self endon( #"hash_5a4b6d8248041472" );
    
    if ( !isdefined( self.var_cd34a84a9aab3467 ) )
    {
        self.var_cd34a84a9aab3467 = 0;
    }
    
    self.var_cd34a84a9aab3467 += 1;
    wait 2;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    weaponstr = "40mm";
    dialogueref = self.var_cd34a84a9aab3467 > 3 ? hashcat( #"kill_", weaponstr, "_mult" ) : hashcat( #"kill_", weaponstr, "_", self.var_cd34a84a9aab3467 );
    thread killstreak_utility::playkillstreaktacomdialog( streakinfo, undefined, dialogueref, 1 );
    self.var_cd34a84a9aab3467 = undefined;
}

// Namespace gunship
// Params 1
// Checksum 0xbea81834, Offset: 0x460a
// Size: 0xcf
function function_7ec3f8629354ba7f( streakinfo )
{
    self notify( #"hash_7321ff5ec6acf259" );
    self endon( #"hash_7321ff5ec6acf259" );
    
    if ( !isdefined( self.var_ca2fcfbf42c44fe9 ) )
    {
        self.var_ca2fcfbf42c44fe9 = 0;
    }
    
    self.var_ca2fcfbf42c44fe9 += 1;
    wait 2;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    weaponstr = "105mm";
    dialogueref = self.var_ca2fcfbf42c44fe9 > 3 ? hashcat( #"kill_", weaponstr, "_mult" ) : hashcat( #"kill_", weaponstr, "_", self.var_ca2fcfbf42c44fe9 );
    thread killstreak_utility::playkillstreaktacomdialog( streakinfo, undefined, dialogueref, 1 );
    self.var_ca2fcfbf42c44fe9 = undefined;
}

// Namespace gunship
// Params 0, eflags: 0x4
// Checksum 0x870c8b35, Offset: 0x46e1
// Size: 0x48
function private lockedoncallback()
{
    killstreak_utility::playkillstreaktacomdialog( self.streakinfo, "gunship" + "_lockedon", #"locked_on", 1, undefined, "pilot" );
    vehicle_omnvar::show_warning( "missileLocking", self.owner, "killstreak" );
}

// Namespace gunship
// Params 0, eflags: 0x4
// Checksum 0x665433eb, Offset: 0x4731
// Size: 0x1c
function private lockedonremovedcallback()
{
    vehicle_omnvar::hide_warning( "missileLocking", self.owner, "killstreak" );
}

// Namespace gunship
// Params 5, eflags: 0x4
// Checksum 0x7358a9f2, Offset: 0x4755
// Size: 0xc11
function private playintro( player, streakinfo, angle, anglevector, var_f0574b4cc0f1975a )
{
    level endon( #"game_ended" );
    thirdpersoncam = 0;
    
    /#
        thirdpersoncam = getdvarint( @"hash_f49f4fd233809e37", 0 );
        
        if ( thirdpersoncam )
        {
            streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
        }
    #/
    
    streakinfo endon( #"killstreak_finished_with_deploy_weapon" );
    player disablephysicaldepthoffieldscripting();
    player allowstances( 0 );
    
    if ( !thirdpersoncam )
    {
        player shellshock_utility_cpmp::_stopshellshock();
        player val::group_set( "gunshipCutScene", 0 );
        player.restoreangles = player getplayerangles();
    }
    
    gunshipintro = undefined;
    bundle = level.streakglobals.streakbundles[ "gunship" ];
    
    /#
        level.gunship_animtype = getdvarint( @"hash_a59a7da9fa17c00", 0 );
    #/
    
    if ( level.gunshipsettings.var_b625d3773a2c5a1b )
    {
        gunshipintro = spawn( "script_model", var_f0574b4cc0f1975a.origin );
        gunshipintro.angles = var_f0574b4cc0f1975a.angles;
        gunshipintro setotherent( player );
        gunshipintro.owner = player;
        heightoffset = 2000;
        gunshipintro linkto( var_f0574b4cc0f1975a, "tag_origin", anglevector - ( 0, 0, heightoffset ), ( 0, angle + 90, 0 ) );
        gunshipintro thread watchintrodisown( "disconnect", streakinfo );
        gunshipintro thread watchintrodisown( "joined_team", streakinfo );
        gunshipintro thread watchintrodisown( "joined_spectators", streakinfo );
        
        if ( level.gunshipsettings.var_e657fae18cf76e0 )
        {
            gunshipintro thread watchintrodisown( "player_fatal_death", streakinfo );
        }
        
        player thread killstreak_utility::playkillstreaktacomdialog( streakinfo, "gunship" + "_use", #"use", 1, 1, "pilot" );
        player painvisionoff();
        player killstreak_shared::killstreak_savenvgstate();
        var_53f1604c636098d3 = utility::getstruct( "cer_gunship_intro", "targetname" );
        var_ea3fd271e96a10c0 = 0;
        
        /#
            var_ea3fd271e96a10c0 = getdvarint( @"hash_923725d8ac07cbfd", 0 );
        #/
        
        scene_struct = {};
        
        if ( isdefined( var_53f1604c636098d3 ) )
        {
            sceneroot = structcopy( var_53f1604c636098d3, 1 );
            scene_struct.origin = sceneroot.origin;
            scene_struct.angles = sceneroot.angles;
        }
        else
        {
            scene_struct.origin = var_f0574b4cc0f1975a.origin + anglevector;
            scene_struct.angles = vectortoangles( anglestoforward( var_f0574b4cc0f1975a.angles + ( 0, angle + 90, 0 ) ) );
        }
        
        player.animname = "Player 1";
        
        if ( !var_ea3fd271e96a10c0 )
        {
            player setclienttriggeraudiozone( "gunship_killstreak", 0.5 );
            scene_struct scene::init( [ player ], "shot_010", bundle.var_2dba7743900f3b38 ?? "t10_killstreak_gunship_intro" );
            player.var_a114672548e6ddbd = 1;
            scene_struct scene::play( [ player ], "shot_010" );
        }
        
        gunshipintro notify( #"hash_4fc5683fce967488" );
    }
    else
    {
        if ( level.gunship_animtype == 1 )
        {
            introanimindex = "intro_gunship";
            gunshipanimlength = animation::get_scr_animlength( "gunship", introanimindex );
            gunshipintro = spawn( "script_model", var_f0574b4cc0f1975a.origin );
            gunshipintro setmodel( level.gunshipsettings.gunshipintromodel );
            gunshipintro.angles = var_f0574b4cc0f1975a.angles;
            gunshipintro setotherent( player );
            gunshipintro.animname = streakinfo.streakname;
            gunshipintro.owner = player;
            
            if ( !thirdpersoncam )
            {
                foreach ( var_2a304e9d2d9189a1 in level.players )
                {
                    if ( var_2a304e9d2d9189a1 != player )
                    {
                        gunshipintro hidefromplayer( var_2a304e9d2d9189a1 );
                    }
                }
                
                gunshipintro thread function_419352e33cfb1af9( player );
            }
            
            heightoffset = 2000;
            
            switch ( level.mapname )
            {
                case #"hash_66ce5cdcd3b547f3":
                case #"hash_ff009e5fab42b778":
                    heightoffset = 500;
                    break;
            }
            
            gunshipintro linkto( var_f0574b4cc0f1975a, "tag_origin", anglevector - ( 0, 0, heightoffset ), ( 0, angle + 90, 0 ) );
            gunshipintro thread watchintrodisown( "disconnect", streakinfo );
            gunshipintro thread watchintrodisown( "joined_team", streakinfo );
            gunshipintro thread watchintrodisown( "joined_spectators", streakinfo );
            
            if ( level.gunshipsettings.var_e657fae18cf76e0 )
            {
                gunshipintro thread watchintrodisown( "player_fatal_death", streakinfo );
            }
            
            waitframe();
            
            if ( !isdefined( gunshipintro ) )
            {
                return;
            }
            
            gunshipintro animation::setanimtree();
            gunshipintro.var_d511ee197fc9d1c9 = spawn( "script_model", gunshipintro.origin );
            gunshipintro.var_d511ee197fc9d1c9.angles = gunshipintro.angles;
            gunshipintro.var_d511ee197fc9d1c9 setmodel( "tag_origin" );
            
            if ( !thirdpersoncam )
            {
                player cameralinkto( gunshipintro, "tag_player", 0, 1 );
                player painvisionoff();
                player killstreak_shared::killstreak_savenvgstate();
                gunshipintro setscriptablepartstate( "clouds_intro", "old", 0 );
                gunshipintro setscriptablepartstate( "bodyFX_intro", "on", 0 );
                gunshipintro thread function_19dc4aaa241db58e( gunshipanimlength, player );
                gunshipintro thread function_d23c81790ecdcc25( gunshipanimlength, player );
                gunshipintro thread function_5304a6718142815d( gunshipanimlength, player );
            }
            
            player killstreak_utility::playkillstreaktacomdialog( self.streakinfo, "gunship" + "_use", #"use", 1, undefined, "pilot" );
            gunshipintro.var_d511ee197fc9d1c9 animation::anim_single_solo( gunshipintro, introanimindex );
        }
        else
        {
            bundle = level.streakglobals.streakbundles[ "gunship" ];
            introz = 20000;
            
            foreach ( map in bundle.var_5eff0b1b3fceefe8 )
            {
                if ( issubstr( level.mapname, map.name ) && isdefined( map.introz ) )
                {
                    introz = map.introz;
                }
            }
            
            animpos = player.origin + anglestoforward( player.angles ) * 100 + ( 0, 0, introz );
            
            /#
                var_7c0dd07e6bdb241f = getdvarint( @"hash_1fa8dffa69ff4ed8", 0 );
                animpos += ( 0, 0, var_7c0dd07e6bdb241f );
            #/
            
            var_63add336c55fd3e9 = spawn( "script_model", animpos );
            var_63add336c55fd3e9 setmodel( "veh9_mil_air_gunship_interior_vm" );
            var_8355961ae50efe3f = [];
            var_8355961ae50efe3f[ "gunship_interior" ] = var_63add336c55fd3e9;
            var_d511ee197fc9d1c9 = spawn( "script_model", var_63add336c55fd3e9 gettagorigin( "tag_control_desk" ) );
            var_d511ee197fc9d1c9 setmodel( "tag_origin" );
            var_d511ee197fc9d1c9.angles = var_63add336c55fd3e9 gettagangles( "tag_control_desk" );
            gunshipintro = spawnstruct();
            gunshipintro.owner = player;
            gunshipintro.gunshipinterior = var_63add336c55fd3e9;
            gunshipintro.var_422165848f230436 = player function_fd5b0b86a0b047b1( "gunship_interior_probe", "gunship_shadow_brush" );
            gunshipintro thread watchintrodisown( "disconnect", streakinfo );
            gunshipintro thread watchintrodisown( "joined_team", streakinfo );
            gunshipintro thread watchintrodisown( "joined_spectators", streakinfo );
            
            if ( level.gunshipsettings.var_e657fae18cf76e0 )
            {
                gunshipintro thread watchintrodisown( "player_fatal_death", streakinfo );
            }
            
            var_22788dafe6e1729c = undefined;
            
            foreach ( modelindex, animmodel in level.var_a9e2be5d10e14c84 )
            {
                var_a229ec1649ef1533 = var_d511ee197fc9d1c9.origin;
                
                if ( modelindex == "gunship_exterior" )
                {
                    var_22788dafe6e1729c = var_a229ec1649ef1533 + ( 0, 0, 200 );
                }
                
                var_cde9a797c7223996 = spawn( "script_model", var_d511ee197fc9d1c9.origin );
                var_cde9a797c7223996 setmodel( animmodel );
                var_cde9a797c7223996 setotherent( player );
                var_cde9a797c7223996.angles = var_d511ee197fc9d1c9.angles;
                var_cde9a797c7223996.animname = "gunship";
                var_cde9a797c7223996 animation::setanimtree();
                
                if ( modelindex == "desk" )
                {
                    var_22788dafe6e1729c = var_cde9a797c7223996;
                }
                
                if ( modelindex == "joystick" )
                {
                    var_cde9a797c7223996 dontinterpolate();
                    var_cde9a797c7223996.origin = var_22788dafe6e1729c gettagorigin( "tag_joystick_1" );
                    var_cde9a797c7223996 linkto( var_22788dafe6e1729c );
                }
                
                var_8355961ae50efe3f[ modelindex ] = var_cde9a797c7223996;
            }
            
            foreach ( animent in var_8355961ae50efe3f )
            {
                if ( !thirdpersoncam )
                {
                    foreach ( var_2a304e9d2d9189a1 in level.players )
                    {
                        animent hidefromplayer( var_2a304e9d2d9189a1 );
                    }
                    
                    animent thread function_419352e33cfb1af9( player );
                }
            }
            
            gunshipintro.var_d511ee197fc9d1c9 = var_d511ee197fc9d1c9;
            gunshipintro.var_8355961ae50efe3f = var_8355961ae50efe3f;
            var_b285779018d51e17 = "gunship_exterior";
            var_a3f7f8f15c86bd51 = "intro_" + var_b285779018d51e17;
            subanimtype = getdvarint( @"hash_cc9d9505b48bc357", 0 );
            
            if ( subanimtype )
            {
                level.scr_anim[ "gunship" ][ var_a3f7f8f15c86bd51 ] = %iw9_mp_acharlie130_intro_v2;
            }
            else
            {
                level.scr_anim[ "gunship" ][ var_a3f7f8f15c86bd51 ] = %iw9_mp_acharlie130_intro;
            }
            
            player killstreak_utility::playkillstreaktacomdialog( streakinfo, "gunship" + "_use", #"use", 1, undefined, "pilot" );
            player painvisionoff();
            player killstreak_shared::killstreak_savenvgstate();
            player function_59a8405783effe95( gunshipintro, var_a3f7f8f15c86bd51 );
            gunshipintro function_5d16cd690851e4dc( player, "light_interior_intro", "on", "ks_gunship_interior_intro", 0 );
            player function_59a8405783effe95( gunshipintro, "intro" );
            gunshipintro function_5d16cd690851e4dc( player, "light_interior_intro", "off", "ks_gunship_interior_intro", 0.5 );
        }
        
        gunshipintro notify( #"hash_4fc5683fce967488" );
    }
    
    if ( !thirdpersoncam )
    {
        player disablephysicaldepthoffieldscripting();
        shellshock_utility_cpmp::_stopshellshock();
        player val::group_reset( "gunshipCutScene" );
    }
    
    return gunshipintro;
}

// Namespace gunship
// Params 2
// Checksum 0x5984031e, Offset: 0x536f
// Size: 0x90
function watchintrodisown( action, streakinfo )
{
    self endon( #"death" );
    self endon( #"hash_4fc5683fce967488" );
    level endon( #"game_ended" );
    gunshipowner = self.owner;
    gunshipowner waittill( action );
    
    if ( action == "disconnect" )
    {
        level.gunshipinuse = 0;
        level callback::callback( #"killstreak_finish_use", { #streakinfo:streakinfo } );
    }
    
    detachplayerfromintro( gunshipowner, streakinfo );
}

// Namespace gunship
// Params 2, eflags: 0x4
// Checksum 0x7ee28fa3, Offset: 0x5407
// Size: 0xe1
function private detachplayerfromintro( gunshipowner, streakinfo )
{
    thirdpersoncam = 0;
    
    /#
        thirdpersoncam = getdvarint( @"hash_f49f4fd233809e37", 0 );
    #/
    
    if ( isdefined( gunshipowner ) && !thirdpersoncam )
    {
        gunshipowner cameraunlink();
        gunshipowner shellshock_utility_cpmp::_stopshellshock();
        gunshipowner disablephysicaldepthoffieldscripting();
        gunshipowner val::group_reset( "gunshipCutScene" );
        gunshipowner killstreak_utility::function_d546aaa588f088c3( streakinfo.streakname, "off" );
        gunshipowner setclientomnvar( "ui_gunship_hud", 0 );
        gunshipowner painvisionon();
        gunshipowner killstreak_shared::killstreak_restorenvgstate();
        gunshipowner setmainvision( "" );
        gunshipowner killstreak_utility::function_f1c03b279632ba1e();
        gunshipowner notify( #"detach_gunship_intro" );
        level thread game_utility::fadetoblackforplayer( gunshipowner, 0 );
    }
    
    streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
    function_7be0e9ca69392745( self );
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0x70622451, Offset: 0x54f0
// Size: 0x2b
function private setmainvision( visionsetname )
{
    if ( level.gunshipsettings.var_986adc36e6ac981b )
    {
        killstreak_utility::killstreak_setmainvision( visionsetname );
    }
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0x764423db, Offset: 0x5523
// Size: 0x4e
function private function_419352e33cfb1af9( owner )
{
    self endon( #"death" );
    owner endon( #"disconnect" );
    
    while ( true )
    {
        level waittill( #"connected", player );
        self hidefromplayer( player );
    }
}

// Namespace gunship
// Params 3, eflags: 0x4
// Checksum 0xd97e89bc, Offset: 0x5579
// Size: 0x157
function private function_5304a6718142815d( animlength, owner, introsequence )
{
    self endon( #"death" );
    owner endon( #"disconnect" );
    owner endon( #"detach_gunship_intro" );
    owner enablephysicaldepthoffieldscripting();
    
    if ( !isdefined( introsequence ) )
    {
        return;
    }
    
    if ( introsequence == "intro_gunship_exterior" )
    {
        owner setphysicaldepthoffield( 1.4, 87, 10, 10 );
        phase1dof = animlength * 0.25;
        phase2dof = animlength * 0.65;
        thread function_901ce03d3ce90b09( owner, phase1dof, 2.2, 87, 50, 50 );
        thread function_901ce03d3ce90b09( owner, phase2dof, 4, 350, 1, 1 );
        return;
    }
    
    if ( introsequence == "intro" )
    {
        owner setphysicaldepthoffield( 1.4, 21, 1000, 1000 );
        phase1dof = animlength * 0.8;
        thread function_901ce03d3ce90b09( owner, phase1dof, 1.4, 43, 50, 50 );
        return;
    }
    
    owner setphysicaldepthoffield( 1.4, 43, 1000, 1000 );
    phase1dof = animlength * 0.5;
    phase2dof = animlength * 0.7;
    thread function_901ce03d3ce90b09( owner, phase1dof, 1.4, 20, 50, 50 );
    thread function_901ce03d3ce90b09( owner, phase2dof, 3, 100, 50, 50 );
}

// Namespace gunship
// Params 6, eflags: 0x4
// Checksum 0x2fe09acd, Offset: 0x56d8
// Size: 0x6e
function private function_901ce03d3ce90b09( owner, delaytime, fstop, focusdistance, focusspeed, var_6bde45c712e6685b )
{
    self endon( #"death" );
    owner endon( #"disconnect" );
    owner endon( #"detach_gunship_intro" );
    wait delaytime;
    owner setphysicaldepthoffield( fstop, focusdistance, focusspeed, var_6bde45c712e6685b );
}

// Namespace gunship
// Params 3, eflags: 0x4
// Checksum 0x8923dfb8, Offset: 0x574e
// Size: 0x103
function private function_19dc4aaa241db58e( animlength, owner, introsequence )
{
    self endon( #"death" );
    owner endon( #"disconnect" );
    owner endon( #"detach_gunship_intro" );
    animtime = animlength;
    eqscale = 0.45;
    shaketime = 0.05;
    
    if ( isdefined( introsequence ) )
    {
        if ( introsequence == "intro_gunship_exterior" )
        {
            eqscale = 0.01;
            shaketime = 0.25;
        }
    }
    
    while ( animtime > 0 )
    {
        owner earthquakeforplayer( eqscale, shaketime, self.origin, 5000 );
        
        if ( isdefined( introsequence ) )
        {
            if ( introsequence == "intro_gunship_exterior" )
            {
                eqscale += 0.01;
                
                if ( eqscale >= 0.1 )
                {
                    eqscale = 0.1;
                }
            }
        }
        else
        {
            eqscale -= 0.01;
            
            if ( eqscale <= 0.12 )
            {
                eqscale = 0.12;
            }
        }
        
        animtime -= shaketime;
        wait shaketime;
    }
}

// Namespace gunship
// Params 2, eflags: 0x4
// Checksum 0xa28e9d04, Offset: 0x5859
// Size: 0x75
function private function_d23c81790ecdcc25( animlength, owner )
{
    self endon( #"death" );
    owner endon( #"disconnect" );
    owner endon( #"detach_gunship_intro" );
    hostmigration::waitlongdurationwithpause( animlength - 0.2 );
    owner setmainvision( "killstreak_slamzoom" );
    hostmigration::waitlongdurationwithpause( 0.1 );
    level thread game_utility::fadetoblackforplayer( owner, 1, 0.1 );
}

// Namespace gunship
// Params 2, eflags: 0x4
// Checksum 0x7d593386, Offset: 0x58d6
// Size: 0x6b
function private function_1f4c8bda2ae625a2( animlength, owner )
{
    owner endon( #"disconnect" );
    level endon( #"game_ended" );
    owner endon( #"detach_gunship_intro" );
    wait animlength - 0.3;
    level thread game_utility::fadetoblackforplayer( owner, 1, 0.3 );
    wait 0.7;
    level thread game_utility::fadetoblackforplayer( owner, 0, 0.3 );
}

// Namespace gunship
// Params 2, eflags: 0x4
// Checksum 0xc107ab85, Offset: 0x5949
// Size: 0xfe
function private function_b4d0f6bb37e2191( player, crashing )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player endon( #"disconnect" );
    thirdpersoncam = 0;
    
    /#
        thirdpersoncam = getdvarint( @"hash_f49f4fd233809e37", 0 );
    #/
    
    if ( !thirdpersoncam )
    {
        player shellshock_utility_cpmp::_stopshellshock();
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"flare_system" ][ #"hash_93285145eafb4db4" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( 0 );
    }
    
    player setclientomnvar( "ui_killstreak_thermal_mode", 0 );
    player player_utility::setthermalvision( 0 );
    player killstreak_utility::function_d546aaa588f088c3( self.streakinfo.streakname, "off" );
    player setclientomnvar( "ui_gunship_hud", 0 );
    player stoploopsound();
    player setmainvision( "" );
    player painvisionon();
    player shellshock_utility_cpmp::_stopshellshock();
    player clearcinematicmotionoverride();
}

// Namespace gunship
// Params 2, eflags: 0x4
// Checksum 0xff940795, Offset: 0x5a4f
// Size: 0x3a7
function private returnplayer( player, crashing )
{
    if ( self.currentdamagestate > 0 )
    {
        if ( isdefined( self.owner ) && self.ispiloted )
        {
            self.owner setclientomnvar( "ui_killstreak_damage_state", 0 );
        }
        
        self.currentdamagestate = 0;
    }
    
    lockedonremovedcallback();
    
    if ( level.gunshipsettings.applyoutlines )
    {
        function_6cf65f0b258d941d();
    }
    
    if ( isdefined( player ) )
    {
        player endon( #"disconnect" );
        
        if ( utility::issharedfuncdefined( #"game", #"disable_backpack_inventory" ) )
        {
            player [[ utility::getsharedfunc( #"game", #"disable_backpack_inventory" ) ]]( 0 );
        }
        
        player function_134cd2c60d3a7edf( 1 );
        player val::reset( "gunship_weap_swap_safety", "weapon_switch" );
        player notify( #"returning_killstreak_player" );
        player.usinggunship = undefined;
        player.var_f92369164340ad6e = undefined;
        
        if ( level.forcethirdperson )
        {
            if ( utility::issharedfuncdefined( #"player", #"hash_c2eed707cc193392" ) )
            {
                player [[ utility::getsharedfunc( #"player", #"hash_c2eed707cc193392" ) ]]( 1 );
            }
        }
        
        if ( isdefined( player.gunship_cloudsfx ) )
        {
            player.gunship_cloudsfx delete();
        }
        
        bundle = level.streakglobals.streakbundles[ "gunship" ];
        thirdpersoncam = 0;
        
        /#
            thirdpersoncam = getdvarint( @"hash_f49f4fd233809e37", 0 );
        #/
        
        if ( !thirdpersoncam )
        {
            player unlink();
            
            if ( crashing && level.gunshipsettings.var_b625d3773a2c5a1b )
            {
                if ( !level.gunshipsettings.applyoutlines )
                {
                    thread function_35bc8018e8437b38( player );
                }
                
                player cameraunlink();
                player thread killstreak_utility::playkillstreaktacomdialog( self.streakinfo, undefined, #"destroyed", 1 );
            }
            else if ( crashing && level.gunship_animtype == 0 )
            {
                player waittill( #"finished_gunship_anim_outro" );
                player setmainvision( "killstreak_static" );
                wait 1;
                player cameraunlink();
                player setmainvision( "" );
                player thread killstreak_utility::playkillstreaktacomdialog( self.streakinfo, undefined, #"destroyed", 1 );
            }
            
            if ( level.gunshipsettings.var_b625d3773a2c5a1b )
            {
                player val::group_reset( "gunshipCutScene" );
            }
            
            player allowstances( 1 );
            player killstreak_utility::function_f1c03b279632ba1e();
            player killstreak_shared::killstreak_restorenvgstate();
            player function_91db6c896cc45ff1( self.streakinfo );
            player val::group_reset( "gunshipInUse" );
        }
        else
        {
            /#
                self.streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
            #/
        }
    }
    
    if ( !level.gunshipsettings.var_b625d3773a2c5a1b )
    {
        function_7be0e9ca69392745( self.gunshipintro );
    }
    
    player killstreak_shared::function_b3302c4317df36c6();
    
    if ( utility::issharedfuncdefined( #"gunship", #"hash_2918c33ec5cc3bb6" ) )
    {
        [[ utility::getsharedfunc( #"gunship", #"hash_2918c33ec5cc3bb6" ) ]]( player );
    }
    
    level.gunshipinuse = 0;
    player setclientomnvar( "ui_gunship_active", 0 );
    level callback::callback( #"killstreak_finish_use", { #streakinfo:self.streakinfo } );
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0x5b6396c8, Offset: 0x5dfe
// Size: 0x2e
function private function_35bc8018e8437b38( player )
{
    player setmainvision( "killstreak_static" );
    wait 1.8;
    player setmainvision( "" );
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0x698e66ff, Offset: 0x5e34
// Size: 0x149
function private function_91db6c896cc45ff1( streakinfo )
{
    self endon( #"disconnect" );
    
    if ( level.gunshipsettings.var_b625d3773a2c5a1b )
    {
        thread function_6e4d28e7db86fb1c();
    }
    
    streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
    dropanimtime = getanimlength( %vm_ks_tablet_drop );
    bundle = level.streakglobals.streakbundles[ "gunship" ];
    
    if ( level.gunshipsettings.var_e657fae18cf76e0 && !player::isreallyalive() )
    {
        return;
    }
    
    wait 0.05;
    function_6ec39bdad539663();
    namespace_9d8e359c3b1041e5::killstreak_switchbacklastweaponsharedfunc( level.gunshipsettings.gunshipweaponname, 1, streakinfo.var_5fa75a5415c9168 ?? 1 );
    
    if ( namespace_9d8e359c3b1041e5::isalivesharedfunc() )
    {
        level thread namespace_9d8e359c3b1041e5::restorekillstreakplayeranglessharedfunc( self );
    }
    
    inventory_utility::_takeweapon( level.gunshipsettings.gunship_missile_weapon );
    inventory_utility::_takeweapon( level.gunshipsettings.var_8969fe590c36e582 );
    inventory_utility::_takeweapon( level.gunshipsettings.var_3edfb285d2efa861 );
    inventory_utility::_takeweapon( level.var_6b27ab061f7b8da9 );
}

// Namespace gunship
// Params 0, eflags: 0x4
// Checksum 0xc361f0f, Offset: 0x5f85
// Size: 0x42
function private function_6e4d28e7db86fb1c()
{
    level endon( #"game_ended" );
    thread function_388793f0227b9323();
    level game_utility::fadetoblackforplayer( self, 1, 0 );
    wait 1.8;
    level game_utility::fadetoblackforplayer( self, 0, 0.3 );
    self notify( #"hash_b4636820ad00bc8" );
}

// Namespace gunship
// Params 0, eflags: 0x4
// Checksum 0x76e3ab4, Offset: 0x5fcf
// Size: 0x28
function private function_388793f0227b9323()
{
    self endon( #"hash_b4636820ad00bc8" );
    level waittill( #"game_ended" );
    level game_utility::fadetoblackforplayer( self, 0, 0, 1 );
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0x6cdb620f, Offset: 0x5fff
// Size: 0x75a
function private watchdamage( gunner )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"hash_aa74550203874047" );
    level endon( #"game_ended" );
    self.damagetaken = 0;
    self.attractor = missile_createattractorent( self, 1000, 4096 );
    bundle = level.streakglobals.streakbundles[ "gunship" ];
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, smeansofdeath, modelname, tagname, partname, idflags, objweapon, null, null, null, inflictor );
        thirdpersoncam = undefined;
        debugdamage = undefined;
        
        /#
            thirdpersoncam = getdvarint( @"hash_f49f4fd233809e37", 0 );
            debugdamage = istrue( self.debugdamage );
        #/
        
        if ( isdefined( level.teambased ) && isplayer( attacker ) && attacker.team == self.team && !thirdpersoncam && !debugdamage )
        {
            continue;
        }
        
        if ( !level.gunshipsettings.var_37213baa31c85bcc )
        {
            if ( smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_EXPLOSIVE_BULLET" )
            {
                continue;
            }
        }
        
        if ( isdefined( gunner ) && gunner isusinggunship() )
        {
            var_44320290cb66d730 = "light";
            
            if ( isexplosivedamagemod( smeansofdeath ) )
            {
                if ( level.gunshipsettings.var_3f42768381334bfa )
                {
                    thread function_fbd55c37c1407924();
                }
                
                if ( ceil( damage / self.maxhealth ) >= level.gunshipsettings.var_2a3a48b766451677 )
                {
                    gunner earthquakeforplayer( level.gunshipsettings.var_5f7f3fa06b25e3e1, level.gunshipsettings.var_1d543c4b5a8c5abd, self.camera.origin, 150 );
                    gunner playrumbleonentity( "damage_heavy" );
                    var_44320290cb66d730 = "heavy";
                }
                else
                {
                    gunner earthquakeforplayer( level.gunshipsettings.var_190c63df5f5371f0, level.gunshipsettings.var_6f3e461922ca6886, self.camera.origin, 150 );
                    gunner playrumbleonentity( "damage_light" );
                }
            }
            
            if ( level.gunshipsettings.var_986adc36e6ac981b && isdefined( self.currentvisionset ) && self.currentvisionset != "" )
            {
                gunner killstreak_shared::function_9fd22f7d1a941d8a( self.currentvisionset, var_44320290cb66d730 );
            }
        }
        
        self.wasdamaged = 1;
        modifieddamage = damage;
        
        if ( !debugdamage )
        {
            if ( level.var_deb9d2b3de25799b && utility::issharedfuncdefined( #"killstreak", #"getmodifieddamageusingdamagetuning" ) )
            {
                bundle = level.streakglobals.streakbundles[ "gunship" ];
                modifieddamage = self [[ utility::getsharedfunc( #"killstreak", #"getmodifieddamageusingdamagetuning" ) ]]( attacker, objweapon, smeansofdeath, modifieddamage, self.maxhealth, bundle.var_20cb8f4e47f3353e, { #iskillstreak:1, #inflictor:inflictor } );
            }
            else if ( utility::issharedfuncdefined( #"killstreak", #"getmodifiedantikillstreakdamage" ) )
            {
                modifieddamage = self [[ utility::getsharedfunc( #"killstreak", #"getmodifiedantikillstreakdamage" ) ]]( attacker, objweapon, smeansofdeath, damage, self.maxhealth, 4, 5, 25, 0, 350 );
            }
        }
        
        data = { #objweapon:objweapon, #idflags:idflags, #partname:partname, #tagname:tagname, #modelname:modelname, #meansofdeath:smeansofdeath, #point:point, #direction_vec:direction_vec, #inflictor:inflictor, #attacker:attacker, #damage:damage, #victim:self };
        
        if ( utility::issharedfuncdefined( #"killstreak", #"killstreakhit" ) )
        {
            [[ utility::getsharedfunc( #"killstreak", #"killstreakhit" ) ]]( attacker, objweapon, self, smeansofdeath, modifieddamage, data );
        }
        
        self.damagetaken += modifieddamage;
        self.currenthealth -= modifieddamage;
        killstreak_utility::killstreak_updatedamagestate( self.currenthealth );
        
        if ( isplayer( attacker ) )
        {
            if ( utility::issharedfuncdefined( #"damage", #"updatedamagefeedback" ) )
            {
                var_7731d58f6f82f082 = { #mod:smeansofdeath, #direction_vec:direction_vec, #point:point, #objweapon:objweapon, #victim:self };
                attacker [[ utility::getsharedfunc( #"damage", #"updatedamagefeedback" ) ]]( "", self.damagetaken >= self.maxhealth, 0, undefined, undefined, undefined, undefined, undefined, undefined, var_7731d58f6f82f082, undefined, 3 );
            }
        }
        
        if ( isplayer( attacker.owner ) )
        {
            if ( utility::issharedfuncdefined( #"damage", #"updatedamagefeedback" ) )
            {
                attacker.owner [[ utility::getsharedfunc( #"damage", #"updatedamagefeedback" ) ]]( "hitequip" );
            }
        }
        
        if ( self.damagetaken >= self.maxhealth )
        {
            streakname = self.streakinfo.streakname;
            damagetype = smeansofdeath;
            scorepopupname = "destroyed_" + streakname;
            leaderdialog = undefined;
            cardsplash = "callout_destroyed_" + streakname;
            skipdeathnotify = 1;
            
            if ( isplayer( attacker ) )
            {
                if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
                {
                    thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( cardsplash, attacker );
                }
            }
            
            if ( utility::issharedfuncdefined( #"damage", #"onkillstreakkilled" ) && isdefined( attacker ) && ( isplayer( attacker ) || isdefined( attacker.owner ) ) )
            {
                notifyattacker = self [[ utility::getsharedfunc( #"damage", #"onkillstreakkilled" ) ]]( streakname, attacker, objweapon, damagetype, damage, scorepopupname, leaderdialog, cardsplash, skipdeathnotify );
            }
            
            thread crash( gunner );
        }
    }
}

// Namespace gunship
// Params 2, eflags: 0x4
// Checksum 0xa091769c, Offset: 0x6761
// Size: 0xb6
function private cleanupsled( sledparent, sled )
{
    if ( isdefined( sledparent ) && isdefined( sled ) )
    {
        centerpos = level.mapcenter ?? ( 0, 0, 0 );
        directionvec = vectornormalize( sled.origin - centerpos );
        directionvec = ( directionvec[ 0 ], directionvec[ 1 ], 0 );
        sledparent moveto( sled.origin + directionvec * 5000, sled.animlength, sled.animlength );
        wait sled.animlength;
        sled delete();
        sledparent delete();
    }
}

// Namespace gunship
// Params 2, eflags: 0x4
// Checksum 0x706912e0, Offset: 0x681f
// Size: 0x29d
function private function_ef385e615a1a0ce4( gunship, chute )
{
    self endon( #"death" );
    self endon( #"crashing" );
    level endon( #"game_ended" );
    gunship endon( #"bombdestroyed" );
    self.damagetaken = 0;
    self.attractor = missile_createattractorent( self, 1000, 4096 );
    bundle = level.streakglobals.streakbundles[ "gunship" ];
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, smeansofdeath, modelname, tagname, partname, idflags, objweapon );
        
        if ( isdefined( level.teambased ) && isplayer( attacker ) && attacker != self.owner && attacker.team == self.owner.team )
        {
            continue;
        }
        
        if ( self.exploding )
        {
            continue;
        }
        
        self.damagetaken += damage;
        self.currenthealth -= damage;
        
        if ( utility::issharedfuncdefined( #"damage", #"updatedamagefeedback" ) && objweapon )
        {
            var_7731d58f6f82f082 = { #mod:smeansofdeath, #direction_vec:direction_vec, #point:point, #objweapon:objweapon, #victim:self };
            attacker [[ utility::getsharedfunc( #"damage", #"updatedamagefeedback" ) ]]( "", self.damagetaken >= self.maxhealth, 0, undefined, undefined, undefined, undefined, undefined, undefined, var_7731d58f6f82f082, undefined, 3 );
        }
        
        if ( self.damagetaken >= self.maxhealth )
        {
            if ( bundle.var_39c08509e3fb7d26 && utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
            {
                attacker thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( bundle.var_39c08509e3fb7d26 );
            }
            
            function_11c3f21f110300b4( gunship, chute );
        }
    }
}

// Namespace gunship
// Params 0
// Checksum 0x3eb8ced8, Offset: 0x6ac4
// Size: 0xd1
function function_efe9c99b0cf41141()
{
    self setscriptablepartstate( "body_damage_light", "off" );
    self setscriptablepartstate( "body_damage_medium", "off" );
    
    if ( isdefined( self.flashlight ) )
    {
        self.flashlight setscriptablepartstate( "camera_damage_heavy", "off" );
    }
    
    self setscriptablepartstate( "contrails", "on" );
    
    if ( isdefined( self.leftwingfxent ) )
    {
        self.leftwingfxent setscriptablepartstate( "engine_blowout", "off" );
        self.leftwingfxent setscriptablepartstate( "body_damage_heavy", "off" );
    }
    
    if ( isdefined( self.rightwingfxent ) )
    {
        self.rightwingfxent setscriptablepartstate( "engine_blowout", "off" );
        self.rightwingfxent setscriptablepartstate( "body_damage_heavy", "off" );
    }
}

// Namespace gunship
// Params 0, eflags: 0x4
// Checksum 0xa8ce7b25, Offset: 0x6b9d
// Size: 0x8c
function private function_2b92632daaa6b4c0()
{
    self setscriptablepartstate( "body_damage_light", "on" );
    gunner = self.owner;
    
    if ( isdefined( gunner ) && gunner isusinggunship() )
    {
        if ( isdefined( self.flashlight ) )
        {
            self.flashlight setscriptablepartstate( "camera_damage_light", "on" );
        }
        
        gunner killstreak_utility::playkillstreaktacomdialog( self.streakinfo, "gunship" + "_light_damage", #"damage_light", 1, undefined, "pilot" );
    }
}

// Namespace gunship
// Params 0, eflags: 0x4
// Checksum 0x71bd6713, Offset: 0x6c31
// Size: 0xb9
function private function_12540d67807e8391()
{
    self setscriptablepartstate( "body_damage_light", "off" );
    self setscriptablepartstate( "body_damage_medium", "on" );
    gunner = self.owner;
    
    if ( isdefined( gunner ) && gunner isusinggunship() )
    {
        if ( isdefined( self.flashlight ) )
        {
            self.flashlight setscriptablepartstate( "camera_damage_medium", "on" );
        }
        
        gunner killstreak_utility::playkillstreaktacomdialog( self.streakinfo, "gunship" + "_med_damage", #"damage_medium", 1, undefined, "pilot" );
        gunner playlocalsound( "veh_rex_air_gunship_dmg_alarm_plr" );
        gunner setclienttriggeraudiozone( "gunship_killstreak_damaged", 0.5 );
    }
}

// Namespace gunship
// Params 0, eflags: 0x4
// Checksum 0xed83c6f7, Offset: 0x6cf2
// Size: 0xa3
function private heavydamagestate()
{
    self setscriptablepartstate( "body_damage_medium", "off" );
    self setscriptablepartstate( "contrails", "off" );
    thread function_eff4fc84e85bc7da();
    gunner = self.owner;
    
    if ( isdefined( gunner ) && gunner isusinggunship() )
    {
        if ( isdefined( self.flashlight ) )
        {
            self.flashlight setscriptablepartstate( "camera_damage_heavy", "on" );
        }
        
        gunner killstreak_utility::playkillstreaktacomdialog( self.streakinfo, "gunship" + "_heavy_damage", #"damage_heavy", 1, undefined, "pilot" );
    }
}

// Namespace gunship
// Params 0, eflags: 0x4
// Checksum 0x792164d1, Offset: 0x6d9d
// Size: 0xa8
function private function_eff4fc84e85bc7da()
{
    level endon( #"game_ended" );
    
    if ( isdefined( self.leftwingfxent ) )
    {
        self.leftwingfxent setscriptablepartstate( "engine_blowout", "on" );
        self.leftwingfxent setscriptablepartstate( "body_damage_heavy", "on" );
    }
    
    randomwait = randomfloatrange( 0.5, 1 );
    hostmigration::waitlongdurationwithpause( randomwait );
    
    if ( isdefined( self.rightwingfxent ) )
    {
        self.rightwingfxent setscriptablepartstate( "engine_blowout", "on" );
        self.rightwingfxent setscriptablepartstate( "body_damage_heavy", "on" );
    }
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0x7acc4a21, Offset: 0x6e4d
// Size: 0x11b
function private function_69e38913f7064023( owner )
{
    self endon( #"death" );
    self endon( #"exit_gunship" );
    level endon( #"game_ended" );
    self.lifetimeendtime = int( level.gunshipsettings.gunship_lifetime * 1000 + gettime() );
    timepassed = 0;
    currenttime = gettime();
    owner setclientomnvar( "ui_gunship_arming_time_remaining", -1 );
    
    while ( timepassed < level.gunshipsettings.gunship_lifetime && isdefined( owner ) )
    {
        timepassed += level.framedurationseconds;
        owner setclientomnvar( "ui_killstreak_lifetime", 1 - timepassed / level.gunshipsettings.gunship_lifetime );
        
        if ( level.gunshipsettings.gunship_lifetime - timepassed <= 10 )
        {
            owner setclientomnvar( "ui_gunship_arming_time_remaining", int( level.gunshipsettings.gunship_lifetime - timepassed ) );
        }
        
        waitframe();
    }
}

// Namespace gunship
// Params 2, eflags: 0x4
// Checksum 0x1e3f623, Offset: 0x6f70
// Size: 0xfd
function private function_c3b770691f1a9620( gunner, streakinfo )
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    level endon( #"game_ended" );
    halfwaytimeout = self.timeout * 0.5;
    wait halfwaytimeout;
    
    if ( self.owner )
    {
        self.owner killstreak_utility::playkillstreaktacomdialog( self.streakinfo, undefined, #"halfway", 1 );
    }
    
    if ( level.gunshipsettings.var_b625d3773a2c5a1b )
    {
        fadeouttime = 0.3;
        hostmigration::waitlongdurationwithpause( halfwaytimeout - fadeouttime );
        level thread game_utility::fadetoblackforplayer( gunner, 1, fadeouttime );
        hostmigration::waitlongdurationwithpause( fadeouttime );
        level thread game_utility::fadetoblackforplayer( gunner, 0, 0 );
    }
    else
    {
        hostmigration::waitlongdurationwithpause( halfwaytimeout );
    }
    
    thread leave( gunner, streakinfo );
}

// Namespace gunship
// Params 2, eflags: 0x4
// Checksum 0xbfc9d033, Offset: 0x7075
// Size: 0x55
function private watchgameend( gunner, streakinfo )
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    level utility::waittill_any( "start_game_ended", "game_ended" );
    thread leave( gunner, streakinfo );
}

// Namespace gunship
// Params 2, eflags: 0x4
// Checksum 0x2bc5ebd2, Offset: 0x70d2
// Size: 0x299
function private leave( gunner, streakinfo )
{
    self endon( #"death" );
    self endon( #"crashing" );
    level endon( #"game_ended" );
    
    if ( gunner )
    {
        gunner function_eb00542899b022bf( 0 );
    }
    
    /#
        var_b671a8d020efcaf4 = getdvarint( @"hash_ed9c0ec25e8ecdc8", 0 );
        
        if ( var_b671a8d020efcaf4 )
        {
            thread crash( gunner );
            return;
        }
    #/
    
    self notify( #"leaving" );
    self.var_b8aae568e66b4bc7 = 1;
    bundle = level.streakglobals.streakbundles[ "gunship" ];
    
    if ( level.gunshipsettings.applyoutlines && gunner )
    {
        gunner clearfullscreenfx();
    }
    
    thread function_b4d0f6bb37e2191( gunner );
    
    if ( level.gunshipsettings.var_b625d3773a2c5a1b )
    {
        if ( gunner )
        {
            gunner val::group_set( "gunshipCutScene", 0 );
        }
        
        self notify( #"hash_aa74550203874047" );
        var_53f1604c636098d3 = utility::getstruct( "cer_gunship_intro", "targetname" );
        scene_struct = {};
        
        if ( isdefined( var_53f1604c636098d3 ) )
        {
            sceneroot = structcopy( var_53f1604c636098d3, 1 );
            scene_struct.origin = sceneroot.origin;
            scene_struct.angles = sceneroot.angles;
        }
        else
        {
            scene_struct.origin = self.origin;
            scene_struct.angles = vectortoangles( anglestoforward( self.angles ) );
        }
        
        var_ea3fd271e96a10c0 = 0;
        
        /#
            var_ea3fd271e96a10c0 = getdvarint( @"hash_923725d8ac07cbfd", 0 );
        #/
        
        if ( gunner )
        {
            gunner painvisionoff();
        }
        
        if ( !var_ea3fd271e96a10c0 )
        {
            self.owner.animname = "Player 1";
            scene_struct.gunship = self;
            scene_struct scene::set_scriptbundle( bundle.var_80a291bed13e2b23 ?? "t10_killstreak_gunship_outro" );
            scene::add_scene_func( scene_struct.script_scenescriptbundle, &function_1b23effa8130e6ed, "callback_done" );
            scene_struct thread scene::play( [ self.owner ], "shot_010", bundle.var_80a291bed13e2b23 ?? "t10_killstreak_gunship_outro" );
        }
    }
    
    if ( level.gunshipsettings.var_e41d5294c7366ac8 )
    {
        thread function_201a7cd42d74f48b( streakinfo );
        return;
    }
    
    thread endleave( gunner, streakinfo );
}

// Namespace gunship
// Params 0, eflags: 0x4
// Checksum 0x476111ad, Offset: 0x7373
// Size: 0x66
function private function_1b23effa8130e6ed()
{
    self.gunship notify( #"hash_d9caaa990d06a5b" );
    
    if ( self.gunship.owner )
    {
        self.gunship.owner clearclienttriggeraudiozone( 0.5 );
        self.gunship.owner.var_a114672548e6ddbd = undefined;
    }
}

// Namespace gunship
// Params 0, eflags: 0x4
// Checksum 0xb28e58b5, Offset: 0x73e1
// Size: 0x35
function private function_42737e4347fea43c()
{
    if ( self.gunship.owner )
    {
        self.gunship.owner.var_a114672548e6ddbd = undefined;
    }
}

// Namespace gunship
// Params 2, eflags: 0x4
// Checksum 0x147ad697, Offset: 0x741e
// Size: 0x162
function private endleave( gunner, streakinfo )
{
    var_ea3fd271e96a10c0 = 0;
    
    /#
        var_ea3fd271e96a10c0 = getdvarint( @"hash_923725d8ac07cbfd", 0 );
    #/
    
    if ( level.gunshipsettings.var_b625d3773a2c5a1b && !var_ea3fd271e96a10c0 )
    {
        self waittill( #"hash_d9caaa990d06a5b" );
    }
    
    self notify( #"exit_gunship" );
    bundle = level.streakglobals.streakbundles[ "gunship" ];
    self unlink();
    self rotateroll( 30, 3 );
    currentangles = self.angles;
    currentdir = anglestoforward( currentangles );
    
    if ( self.owner )
    {
        self.owner killstreak_utility::playkillstreaktacomdialog( self.streakinfo, "gunship" + "_leave", #"leave", 1, undefined, "pilot" );
    }
    
    thread returnplayer( gunner );
    self moveto( self.origin + currentdir * 50000, 10, 10, 0 );
    waittilldestination( self.origin + currentdir * 50000 );
    
    if ( self getscriptablehaspart( "audio_engine_sounds" ) )
    {
        self setscriptablepartstate( "audio_engine_sounds", "off" );
    }
    
    removeplane( 0 );
}

// Namespace gunship
// Params 2, eflags: 0x4
// Checksum 0xb27785c5, Offset: 0x7588
// Size: 0x297
function private function_8571bbd28a99ad55( enemyteam, playersinrange )
{
    var_bd3ada4f508f3620 = 0;
    var_d1d8378a64256171 = undefined;
    var_4a4f435567cb3978 = [];
    var_159b2d857206dbff = [];
    contents = trace::create_contents( 0, 1, 0, 1, 1, 0 );
    players = playersinrange ?? level.players;
    
    foreach ( player in players )
    {
        if ( !level.teambased && player != self.owner || player.team === enemyteam )
        {
            targetpos = player.origin;
            
            if ( trace::ray_trace_passed( targetpos, targetpos + ( 0, 0, 1000 ), player, contents ) )
            {
                var_4a4f435567cb3978[ var_4a4f435567cb3978.size ] = player;
                player.var_7a6fc5fb880e3493 = 1;
                continue;
            }
            
            var_159b2d857206dbff[ var_159b2d857206dbff.size ] = player;
            player.var_fcf52b46de87ed30 = 1;
        }
    }
    
    foreach ( player in var_4a4f435567cb3978 )
    {
        if ( player.var_7a6fc5fb880e3493 )
        {
            potentialtargets = player_utility::script_getplayersinradius( player.origin, level.gunshipsettings.var_b28f35adb63a9d70, enemyteam, var_159b2d857206dbff );
            
            if ( potentialtargets.size > var_bd3ada4f508f3620 )
            {
                var_bd3ada4f508f3620 = potentialtargets.size;
                var_d1d8378a64256171 = player;
            }
        }
    }
    
    foreach ( player in level.players )
    {
        player.var_7a6fc5fb880e3493 = undefined;
        player.var_fcf52b46de87ed30 = undefined;
    }
    
    return var_d1d8378a64256171;
}

// Namespace gunship
// Params 6, eflags: 0x4
// Checksum 0x335c0311, Offset: 0x7828
// Size: 0x177
function private gettargetposition( bomb, enemyteam, lasttargetposition, starttimems, endtimems, currenttimems )
{
    var_d1d8378a64256171 = undefined;
    
    if ( !isdefined( lasttargetposition ) )
    {
        var_d1d8378a64256171 = function_8571bbd28a99ad55( enemyteam );
    }
    else
    {
        var_ba6f378a7942ebab = distance2d( lasttargetposition, bomb.origin );
        searchrange = max( var_ba6f378a7942ebab, 200 );
        playersinrange = player_utility::script_getplayersinradius( lasttargetposition, searchrange, enemyteam );
        var_d1d8378a64256171 = function_8571bbd28a99ad55( enemyteam, playersinrange );
        
        /#
            if ( getdvarint( @"hash_44b03914771df268", 0 ) != 0 )
            {
                if ( var_d1d8378a64256171.origin )
                {
                    thread debug_utility::drawsphere( var_d1d8378a64256171.origin, searchrange, 0.1, ( 0, 1, 0 ) );
                }
            }
        #/
    }
    
    retval = ( 0, 0, 0 );
    
    if ( isdefined( var_d1d8378a64256171 ) )
    {
        retval = var_d1d8378a64256171.origin;
    }
    else if ( isdefined( lasttargetposition ) )
    {
        retval = lasttargetposition;
    }
    else if ( isdefined( level.mapcenter ) )
    {
        retval = level.mapcenter;
    }
    
    /#
        if ( getdvarint( @"hash_44b03914771df268", 0 ) != 0 )
        {
            thread debug_utility::drawsphere( retval, 200, 0.1, ( 1, 0, 0 ) );
        }
    #/
    
    return retval;
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0x3ec2402, Offset: 0x79a8
// Size: 0x613
function private function_201a7cd42d74f48b( streakinfo )
{
    self endon( #"bombdestroyed" );
    self.owner unlink();
    self.var_ce6835d644d27b88 = 1;
    wait 10.5;
    bundle = level.streakglobals.streakbundles[ "gunship" ];
    var_d8181378272cd2 = 0;
    var_2bc962a6da90ea81 = -2000;
    gunshipposition = self.origin;
    gunshipangles = self.angles;
    gunshipforward = anglestoforward( gunshipangles );
    startposition = ( gunshipposition[ 0 ], gunshipposition[ 1 ], gunshipposition[ 2 ] + var_d8181378272cd2 ) + gunshipforward * var_2bc962a6da90ea81;
    var_82366194bc1e1a0b = vectortoangles( gunshipforward * -1 );
    
    /#
        if ( getdvarint( @"hash_44b03914771df268", 0 ) != 0 )
        {
            thread debug_utility::drawsphere( gunshipposition, 500, 30, ( 1, 0, 0 ) );
            thread debug_utility::drawsphere( startposition, 500, 30, ( 0, 0, 1 ) );
        }
    #/
    
    parent = spawn( "script_model", startposition );
    parent setmodel( "tag_origin" );
    parent.angles = var_82366194bc1e1a0b;
    chute = spawn( "script_model", parent.origin );
    chute.angles = var_82366194bc1e1a0b;
    
    if ( self.owner )
    {
        chute setentityowner( self.owner );
    }
    
    chute setmodel( bundle.var_c84ddb73799cac4d ?? "veh9_mil_lnd_parachute_carepackage_mp" );
    chute.animname = "gunship_chute";
    chute animation::setanimtree();
    chute linkto( parent, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_6d416c47fdb13979 = "bomb_drop_chute";
    chute.animlength = animation::get_scr_animlength( chute.animname, var_6d416c47fdb13979 );
    sledparent = spawn( "script_model", startposition );
    sledparent.angles = var_82366194bc1e1a0b;
    sledparent setmodel( "tag_origin" );
    sledparent.angles = var_82366194bc1e1a0b;
    sled = spawn( "script_model", sledparent.origin );
    sled.angles = var_82366194bc1e1a0b;
    
    if ( self.owner )
    {
        sled setentityowner( self.owner );
    }
    
    sled setmodel( bundle.var_4bdad3f41f3a85be ?? "veh_t10_mil_air_gunboat_bomb_sled" );
    sled.animname = "gunship_bomb_sled";
    sled animation::setanimtree();
    sled linkto( sledparent, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_d067e9053d9734ac = "bomb_drop_sled";
    sled.animlength = animation::get_scr_animlength( sled.animname, var_d067e9053d9734ac );
    bomb = spawn( "script_model", parent.origin );
    bomb.angles = var_82366194bc1e1a0b;
    
    if ( self.owner )
    {
        bomb setentityowner( self.owner );
    }
    
    bomb setcandamage( 1 );
    bomb.currenthealth = level.gunshipsettings.bombhealth;
    bomb.maxhealth = bomb.currenthealth;
    bomb.health = 99999;
    bomb.owner = self.owner;
    bomb.team = self.owner.team;
    bomb setmodel( bundle.var_28c219e1a94416e0 ?? "veh_t10_mil_air_bomb_deltacharlie" );
    bomb.animname = "gunship_bomb";
    bomb.weapon_name = bundle.projectileweapon ?? "veh_t10_mil_air_bomb_deltacharlie";
    bomb animation::setanimtree();
    bomb linkto( parent, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_41c507e9543cee = "bomb_drop";
    bomb.animlength = animation::get_scr_animlength( bomb.animname, var_41c507e9543cee );
    bomb.streakinfo = streakinfo;
    
    /#
        if ( getdvarint( @"hash_44b03914771df268", 0 ) != 0 )
        {
            level thread debug_utility::drawline( parent.origin, parent.origin + anglestoforward( parent.angles ) * 1000, 30, ( 1, 0, 0 ) );
            level thread debug_utility::drawline( bomb.origin, bomb.origin + anglestoforward( bomb.angles ) * 1000, 30, ( 0, 1, 0 ) );
            level thread debug_utility::drawline( chute.origin, chute.origin + anglestoforward( chute.angles ) * 1000, 30, ( 0, 0, 1 ) );
        }
    #/
    
    bomb thread function_ef385e615a1a0ce4( self, chute );
    thread endleave( self.owner, streakinfo );
    thread cleanupsled( sledparent, sled );
    
    /#
    #/
    
    bomb thread animation::anim_single_solo( bomb, var_41c507e9543cee );
    chute thread animation::anim_single_solo( chute, var_6d416c47fdb13979 );
    sled thread animation::anim_single_solo( sled, var_d067e9053d9734ac );
    bomb thread function_5ac7b12489f7a57e( self );
    function_5fdfda2b36a06947( parent, startposition, bomb.animlength, self.enemyteam );
    
    if ( isdefined( bomb ) )
    {
        bomb function_7c7528f18f28de22();
    }
}

// Namespace gunship
// Params 2, eflags: 0x4
// Checksum 0xb3425b9b, Offset: 0x7fc3
// Size: 0x1f0
function private function_7c7528f18f28de22( contactpoint, force )
{
    self notify( #"hash_bedef8920634c0a6" );
    self endon( #"hash_2d12967047b9fe48" );
    self unlink();
    var_6c756bdd1c66de0 = 500;
    var_54f5cce3f0e25b20 = anglestoright( self.angles );
    var_6fc4450d22b6d93f = anglestoup( self.angles );
    var_9e922f60b00adbff = anglestoforward( self.angles );
    self physicslaunchserver( self.origin, ( 0, 0, -1 * var_6c756bdd1c66de0 * 400 ) );
    killcament = spawn( "script_model", self.origin + ( -500, 0, 0 ) );
    killcament setscriptmoverkillcam( "airstrike" );
    killcament linkto( self );
    killcament.starttime = gettime();
    self.killcament = killcament;
    
    if ( isdefined( self.killcament ) && !self.killcament.linked )
    {
        self.killcament linkto( self, "tag_origin", ( -500, 0, 0 ), ( 0, 0, 0 ) );
    }
    
    self.physicsactivated = 1;
    thread monitorimpact();
    waitframe();
    self physics_applyimpulse( self.origin, ( 0, 0, -1 * var_6c756bdd1c66de0 * 400 ) );
    wait 0.05;
    self physics_applyimpulse( self.origin + 100 * var_6fc4450d22b6d93f, var_6c756bdd1c66de0 * 50 * var_54f5cce3f0e25b20 );
    wait 0.05;
    self physics_applyimpulse( self.origin + -100 * var_6fc4450d22b6d93f, var_6c756bdd1c66de0 * 20 * var_9e922f60b00adbff );
    wait 0.05;
    
    while ( isdefined( self ) )
    {
        self physics_applyimpulse( self.origin, ( 0, 0, -1 * var_6c756bdd1c66de0 * 33 ) );
        wait 0.05;
    }
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0x4892392c, Offset: 0x81bb
// Size: 0x6a
function private monitorimpact( delay )
{
    monitorimpactend();
    self endon( #"hash_2d12967047b9fe48" );
    self.monitoringimpact = 1;
    bundle = level.streakglobals.streakbundles[ "gunship" ];
    self physics_registerforcollisioncallback();
    monitorimpactinternal( delay );
    
    if ( isdefined( self ) )
    {
        thread monitorimpactend();
    }
}

// Namespace gunship
// Params 0, eflags: 0x4
// Checksum 0x9f0483b2, Offset: 0x822d
// Size: 0x51
function private monitorimpactend()
{
    if ( !self.monitoringimpact )
    {
        return;
    }
    
    self notify( #"hash_2d12967047b9fe48" );
    self.monitoringimpact = undefined;
    bundle = level.streakglobals.streakbundles[ "gunship" ];
    self physics_unregisterforcollisioncallback();
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0xd805f7d5, Offset: 0x8286
// Size: 0x177
function private monitorimpactinternal( delay )
{
    self endon( #"death" );
    self endon( #"exploded" );
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    var_a0dc21757f0d4d96 = 0;
    firstimpact = 0;
    
    while ( true )
    {
        self waittill( #"collision", body0, body1, flag0, flag1, position, normal, impulse, ent );
        
        if ( self.exploding )
        {
            continue;
        }
        
        if ( !firstimpact )
        {
            if ( isdefined( self.killcament ) )
            {
                self.killcament unlink();
                self.killcament.linked = 0;
            }
            
            firstimpact = 1;
            explodeinfo = {};
            explodeinfo.param1 = body0;
            explodeinfo.param2 = body1;
            explodeinfo.param3 = flag0;
            explodeinfo.param4 = flag1;
            explodeinfo.param5 = position;
            explodeinfo.param6 = normal;
            explodeinfo.param7 = impulse;
            explodeinfo.param8 = ent;
            function_6c2c70a343a49fd0( explodeinfo );
        }
    }
}

// Namespace gunship
// Params 2, eflags: 0x4
// Checksum 0xe5471c5d, Offset: 0x8405
// Size: 0x18c
function private function_11c3f21f110300b4( gunship, chute )
{
    self.exploding = 1;
    
    if ( isdefined( self.owner ) )
    {
        self radiusdamage( self.origin, level.gunshipsettings.var_b28f35adb63a9d70, level.gunshipsettings.bombmaxdamage, level.gunshipsettings.bombmindamage, self.owner, "MOD_EXPLOSIVE", self.weapon_name );
    }
    
    physicsexplosionsphere( self.origin, level.gunshipsettings.var_4568e4427c094610, level.gunshipsettings.var_10d024f3e1978f85, level.gunshipsettings.var_1b5b99ac89b38d47 );
    earthquake( level.gunshipsettings.var_db3a7294c8e2dd4c, level.gunshipsettings.var_5040220f808d8fe2, self.origin, level.gunshipsettings.var_8873162f0a9643fc );
    self setscriptablepartstate( "air_explosion", "on", 0 );
    self setscriptablepartstate( "visibility", "hide", 0 );
    
    if ( isdefined( chute ) )
    {
        chute delete();
    }
    
    gunship notify( #"bombdestroyed" );
    self notify( #"exploded" );
    function_4bef7662b6c2c08a( self.owner, self.streakinfo );
    wait 0.5;
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0xa6c89578, Offset: 0x8599
// Size: 0x133
function private function_6c2c70a343a49fd0( explodeinfo )
{
    self.exploding = 1;
    
    if ( isdefined( self.owner ) )
    {
        self radiusdamage( self.origin, level.gunshipsettings.var_b28f35adb63a9d70, level.gunshipsettings.bombmaxdamage, level.gunshipsettings.bombmindamage, self.owner, "MOD_EXPLOSIVE", self.weapon_name );
    }
    
    physicsexplosionsphere( self.origin, level.gunshipsettings.var_4568e4427c094610, level.gunshipsettings.var_10d024f3e1978f85, level.gunshipsettings.var_1b5b99ac89b38d47 );
    earthquake( level.gunshipsettings.var_db3a7294c8e2dd4c, level.gunshipsettings.var_5040220f808d8fe2, self.origin, level.gunshipsettings.var_8873162f0a9643fc );
    thread function_cabd8c60dde2905b( explodeinfo );
    function_4bef7662b6c2c08a( self.owner, self.streakinfo );
}

// Namespace gunship
// Params 2, eflags: 0x4
// Checksum 0x27858c68, Offset: 0x86d4
// Size: 0x2b
function private function_4bef7662b6c2c08a( player, streakinfo )
{
    if ( isdefined( player ) && isdefined( streakinfo ) )
    {
        player killstreak_utility::recordkillstreakendstats( streakinfo );
    }
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0xe281c398, Offset: 0x8707
// Size: 0xe6
function private function_cabd8c60dde2905b( explodeinfo )
{
    fxent = self;
    
    if ( isdefined( explodeinfo ) && explodeinfo.msg == "explode_collision" )
    {
        worldup = ( 0, 0, 1 );
        surfacenormal = explodeinfo.param6;
        self.angles = vectortoangles( surfacenormal );
        angledirection = vectordot( surfacenormal, worldup );
        
        if ( angledirection >= 0.7 )
        {
            self setscriptablepartstate( "ground_explosion", "on", 0 );
        }
        else
        {
            self setscriptablepartstate( "air_explosion", "on", 0 );
        }
    }
    else
    {
        self setscriptablepartstate( "ground_explosion", "on", 0 );
    }
    
    self setscriptablepartstate( "visibility", "hide", 0 );
    wait 0.5;
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace gunship
// Params 4, eflags: 0x4
// Checksum 0x7670ad09, Offset: 0x87f5
// Size: 0x177
function private function_5fdfda2b36a06947( parent, startposition, totaltimesec, enemyteam )
{
    wait 1;
    totaltimesec -= 1;
    totaltimems = int( totaltimesec * 1000 );
    endtimems = gettime() + totaltimems;
    starttimems = gettime();
    currenttimems = starttimems;
    var_5132ecf2816a8696 = totaltimems / 4;
    var_bf668a6eb28a4509 = var_5132ecf2816a8696;
    owner = self.owner;
    targetposition = undefined;
    
    while ( currenttimems < endtimems )
    {
        elapsedtimems = currenttimems - starttimems;
        timeleftms = totaltimems - elapsedtimems;
        timeleftsec = timeleftms / 1000;
        var_7ddc0257e00b9514 = ( var_5132ecf2816a8696 - elapsedtimems < 0 ? 0 : var_5132ecf2816a8696 - elapsedtimems ) / 1000;
        var_bd9f07e722674e7d = ( timeleftms < var_bf668a6eb28a4509 ? timeleftms : var_bf668a6eb28a4509 ) / 1000;
        lasttargetposition = targetposition;
        targetposition = gettargetposition( parent, enemyteam, lasttargetposition, starttimems, endtimems, currenttimems );
        parent moveto( ( targetposition[ 0 ], targetposition[ 1 ], startposition[ 2 ] ), timeleftsec, var_7ddc0257e00b9514, var_bd9f07e722674e7d );
        waittime = timeleftsec < 0.1 ? timeleftsec : 0.1;
        wait waittime;
        currenttimems = gettime();
    }
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0x29367262, Offset: 0x8974
// Size: 0xb8
function private function_5ac7b12489f7a57e( gunship )
{
    self endon( #"hash_bedef8920634c0a6" );
    gunship endon( #"bombdestroyed" );
    gunship endon( #"death" );
    gunship endon( #"crashing" );
    gunship endon( #"leaving" );
    level endon( #"game_ended" );
    self.velocity = ( 0, 0, 0 );
    
    while ( true )
    {
        self.lastorigin = self.origin;
        wait level.framedurationseconds;
        self.velocity = ( self.origin - self.lastorigin ) / level.framedurationseconds;
    }
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0x6979c2ba, Offset: 0x8a34
// Size: 0x25
function private waittilldestination( destination )
{
    while ( isdefined( self ) && self.origin != destination )
    {
        waitframe();
    }
}

// Namespace gunship
// Params 3, eflags: 0x4
// Checksum 0xa1d4b218, Offset: 0x8a61
// Size: 0x75
function private watchownerexitaction( gunner, exitaction, streakinfo )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"leaving" );
    level endon( #"game_ended" );
    gunner waittill( exitaction );
    
    if ( exitaction == "player_fatal_death" )
    {
        thread leave( gunner, streakinfo );
        return;
    }
    
    thread crash( gunner );
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0xe0bc794d, Offset: 0x8ade
// Size: 0xd1
function private function_a780979c2ed97570( gunner )
{
    self endon( #"death", #"crashing", #"leaving" );
    gunner endon( #"disconnect" );
    level waittill( #"game_ended" );
    gunner killstreak_utility::function_d546aaa588f088c3( self.streakinfo.streakname, "off" );
    gunner setclientomnvar( "ui_gunship_hud", 0 );
    
    if ( self.owner && self.streakinfo )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"hash_bf17c172d25e8b3d" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self.owner [[ var_32dbca3143d9c4a5 ]]( self.streakinfo );
        }
    }
}

// Namespace gunship
// Params 2, eflags: 0x4
// Checksum 0xfdb6ef1c, Offset: 0x8bb7
// Size: 0x1ff
function private watchflares( veh, owner )
{
    veh endon( #"death" );
    veh endon( #"leaving" );
    veh endon( #"crashing" );
    level endon( #"game_ended" );
    owner endon( #"disconnect" );
    
    if ( owner.disable_gunship_flares )
    {
        return;
    }
    
    owner notifyonplayercommand( "inputReceivedFlares", "+smoke" );
    
    while ( true )
    {
        cmd = owner utility::waittill_any_return( "inputReceivedFlares", "deployDebugFlare" );
        
        if ( !isdefined( veh ) )
        {
            break;
        }
        
        if ( !isdefined( cmd ) )
        {
            continue;
        }
        
        /#
            if ( cmd == "<dev string:x24>" )
            {
                veh thread function_7924d9967f3a63c3();
                veh killstreak_utility::playkillstreaktacomdialog( self.streakinfo, "<dev string:x35>" + "<dev string:x3d>", #"flares", 1, undefined, "<dev string:x45>" );
                continue;
            }
        #/
        
        if ( cmd == "inputReceivedFlares" )
        {
            if ( utility::issharedfuncdefined( #"flare_system", #"hash_1101719e6ff74ce" ) )
            {
                if ( veh [[ utility::getsharedfunc( #"flare_system", #"hash_1101719e6ff74ce" ) ]]() )
                {
                    if ( utility::issharedfuncdefined( #"flares", #"reducereserves" ) )
                    {
                        [[ utility::getsharedfunc( #"flares", #"reducereserves" ) ]]( veh );
                    }
                    
                    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"flare_system" ][ #"hash_93285145eafb4db4" ];
                    
                    if ( isdefined( var_32dbca3143d9c4a5 ) )
                    {
                        self [[ var_32dbca3143d9c4a5 ]]( 0 );
                    }
                    
                    veh thread function_7924d9967f3a63c3();
                    veh thread function_76f7b62145f8c09c( veh, owner );
                    veh thread function_e66799a10331deb9( veh, owner );
                    veh killstreak_utility::playkillstreaktacomdialog( self.streakinfo, "gunship" + "_flares", #"flares", 1, undefined, "pilot" );
                }
            }
            
            function_83c7bdbb14db33c4( veh, owner );
        }
    }
}

// Namespace gunship
// Params 2, eflags: 0x4
// Checksum 0xad7a8d3f, Offset: 0x8dbe
// Size: 0xc5
function private function_e66799a10331deb9( veh, owner )
{
    if ( owner.disable_gunship_flares )
    {
        return;
    }
    
    if ( self.flaresystem.lockontimegraceperiod )
    {
        var_3e6b7a81a9e11033 = self.flaresystem.lockontimegraceperiod * 0.001;
        wait var_3e6b7a81a9e11033;
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"flare_system" ][ #"hash_93285145eafb4db4" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self [[ var_32dbca3143d9c4a5 ]]( 1 );
        }
        
        return;
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"flare_system" ][ #"hash_93285145eafb4db4" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( 1 );
    }
}

// Namespace gunship
// Params 2, eflags: 0x4
// Checksum 0xe586cdf4, Offset: 0x8e8b
// Size: 0xa3
function private function_76f7b62145f8c09c( veh, owner )
{
    if ( owner.disable_gunship_flares )
    {
        return;
    }
    
    for ( i = 0; i < level.gunshipsettings.var_da5345e316d69de5 ; i++ )
    {
        owner setclientomnvar( "ui_killstreak_flares_cooldown", i + 1 );
        wait 1;
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"flare_system" ][ #"hash_93285145eafb4db4" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        self [[ var_32dbca3143d9c4a5 ]]( 1 );
    }
    
    function_83c7bdbb14db33c4( veh, owner );
}

// Namespace gunship
// Params 2, eflags: 0x4
// Checksum 0x4c346640, Offset: 0x8f36
// Size: 0x7c
function private function_83c7bdbb14db33c4( veh, owner )
{
    if ( owner.disable_gunship_flares )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( #"flare_system", #"hash_aa84d9f6a2574574" ) )
    {
        if ( veh [[ utility::getsharedfunc( #"flare_system", #"hash_aa84d9f6a2574574" ) ]]() )
        {
            owner setclientomnvar( "ui_killstreak_flares_available", 1 );
            return;
        }
        
        owner setclientomnvar( "ui_killstreak_flares_available", 0 );
    }
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0x53e93d34, Offset: 0x8fba
// Size: 0x9c
function private function_8cbfb7e011013aaa( gunner )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"leaving" );
    level endon( #"game_ended" );
    self.velocity = ( 0, 0, 0 );
    
    while ( true )
    {
        self.lastorigin = self.origin;
        wait level.framedurationseconds;
        self.velocity = ( self.origin - self.lastorigin ) / level.framedurationseconds;
    }
}

// Namespace gunship
// Params 6
// Checksum 0xc16cda41, Offset: 0x905e
// Size: 0x486
function spawngunship( owner, streakinfo, angle, anglevector, gunshipintro, var_f0574b4cc0f1975a )
{
    gunship = spawn( "script_model", var_f0574b4cc0f1975a.origin );
    gunship setmodel( level.gunshipsettings.var_8625e7a185efd6a9 );
    gunship setcandamage( 1 );
    gunship.currenthealth = level.gunshipsettings.gunshiphealth;
    gunship.maxhealth = gunship.currenthealth;
    gunship.health = 99999;
    gunship.owner = owner;
    gunship.team = owner.team;
    gunship.enemyteam = team_utility::getotherteam( owner.team );
    gunship.gunshipintro = gunshipintro;
    gunship.var_f0574b4cc0f1975a = var_f0574b4cc0f1975a;
    gunship.ispiloted = 1;
    gunship.timeout = level.gunshipsettings.gunship_lifetime;
    
    if ( utility::issharedfuncdefined( #"gunship", #"attachxrays" ) )
    {
        gunship = [[ utility::getsharedfunc( #"gunship", #"attachxrays" ) ]]( gunship );
    }
    
    gunship.missileloaded = 1;
    hellfiretarget = spawn( "script_model", gunship.origin );
    hellfiretarget setmodel( "tag_origin" );
    gunship.hellfiretarget = hellfiretarget;
    
    if ( game_utility::islargemap() )
    {
        var_f0574b4cc0f1975a thread function_4186d441fa667f7c( gunship );
    }
    
    gunship sentientpoolmanager::registersentient( "Killstreak_Air", owner, undefined, undefined, 1, 0 );
    gunship killstreak_utility::function_b555369eba6b0252( 1, level.gunshipsettings.var_af7b727c426a923e, &function_2b92632daaa6b4c0 );
    gunship killstreak_utility::function_b555369eba6b0252( 2, level.gunshipsettings.var_7063645f39c4e8a9, &function_12540d67807e8391 );
    gunship killstreak_utility::function_b555369eba6b0252( 3, level.gunshipsettings.var_268c9e4d27c54be8, &heavydamagestate );
    
    /#
        timeoutoverride = getdvarint( @"scr_gunship_timeout", level.gunshipsettings.gunship_lifetime );
        var_ae24eaad32921ae2 = getdvarint( @"hash_2c01d701bac5d9d3", 0 );
        var_7fe73e19f465f7fa = getdvarint( @"hash_89d68c6d998d0ebb", 0 );
        
        if ( var_ae24eaad32921ae2 || var_7fe73e19f465f7fa )
        {
            timeoutoverride = 9999;
        }
        
        var_665e2fab7c9a2e9a = getdvarint( @"hash_e7993fd91f348e3b", 0 );
        
        if ( var_665e2fab7c9a2e9a )
        {
            timeoutoverride = 1;
        }
        
        gunship.timeout = timeoutoverride;
    #/
    
    if ( isdefined( level.var_ac31aff8b6606951 ) )
    {
        gunship.timeout = level.var_ac31aff8b6606951;
    }
    
    gunship.flaresreservecount = level.gunshipsettings.gunship_flarescount;
    gunship.streakinfo = streakinfo;
    gunship.streakinfo.var_bbd40c52f0758e34 = 1;
    gunship scriptmoveroutline();
    gunship scriptmoverthermal();
    gunship setotherent( owner );
    bundle = level.streakglobals.streakbundles[ "gunship" ];
    var_854ac459327c7548 = bundle.minimapicon ?? "hud_icon_minimap_killstreak_gunship";
    gunship.minimapid = gunship objidpoolmanager::createobjective( var_854ac459327c7548, gunship.team, 1, 1, 1 );
    objidpoolmanager::function_e4d6a71507372662( gunship.minimapid, 0 );
    function_38c992e07c477802( gunship.minimapid, 1 );
    
    if ( isdefined( level.var_6f47ece75eebb413 ) )
    {
        profilestart();
        gunship.var_16f8fcd927d3c930 = gunship namespace_9d8e359c3b1041e5::killstreak_registerminimapinfosharedfunc( bundle, #"gunship" );
        profilestop();
        function_38c992e07c477802( gunship.var_16f8fcd927d3c930, 1 );
    }
    
    namespace_9d8e359c3b1041e5::function_f6af4ffa6dbb4645( "gunship", "on" );
    killstreak_shared::function_9fc2f7ee10890d99( "gunship" );
    gunship linkto( var_f0574b4cc0f1975a, "tag_origin", anglevector, ( 0, angle + 90, -30 ) );
    level notify( #"matchrecording_plane", gunship );
    return gunship;
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0xd76b83fa, Offset: 0x94ed
// Size: 0x6c
function private function_b33d2bec95a94e73( plane )
{
    plane endon( #"death" );
    plane endon( #"crashing" );
    plane endon( #"leaving" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    wait 0.05;
    thread function_4f7e689b6532ee06( plane );
    thread function_6d8f1aa29c2ffa67( plane );
    thread function_2530661b7c14cb96( plane );
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0xfe413c9d, Offset: 0x9561
// Size: 0xaf
function private function_4f7e689b6532ee06( plane )
{
    plane endon( #"death" );
    plane endon( #"crashing" );
    plane endon( #"leaving" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self setclientomnvar( "ui_gunship_coord1_posx", int( plane.origin[ 0 ] ) );
        self setclientomnvar( "ui_gunship_coord1_posy", int( plane.origin[ 1 ] ) );
        self setclientomnvar( "ui_gunship_coord1_posz", int( plane.origin[ 2 ] ) );
        wait 0.5;
    }
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0xfd11bd35, Offset: 0x9618
// Size: 0x9c
function private function_6d8f1aa29c2ffa67( plane )
{
    plane endon( #"death" );
    plane endon( #"crashing" );
    plane endon( #"leaving" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    waitframe();
    self setclientomnvar( "ui_gunship_coord2_posx", int( self.origin[ 0 ] ) );
    self setclientomnvar( "ui_gunship_coord2_posy", int( self.origin[ 1 ] ) );
    self setclientomnvar( "ui_gunship_coord2_posz", int( self.origin[ 2 ] ) );
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0x58eebbf0, Offset: 0x96bc
// Size: 0xcd
function private function_2530661b7c14cb96( plane )
{
    plane endon( #"death" );
    plane endon( #"crashing" );
    plane endon( #"leaving" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        starttrace = self getvieworigin();
        endtrace = starttrace + anglestoforward( self getplayerangles() ) * 15000;
        endpos = physicstrace( starttrace, endtrace );
        self setclientomnvar( "ui_gunship_coord3_posx", int( endpos[ 0 ] ) );
        self setclientomnvar( "ui_gunship_coord3_posy", int( endpos[ 1 ] ) );
        self setclientomnvar( "ui_gunship_coord3_posz", int( endpos[ 2 ] ) );
        wait 0.1;
    }
}

// Namespace gunship
// Params 0, eflags: 0x4
// Checksum 0x3be945c4, Offset: 0x9791
// Size: 0xc3
function private function_6b3f5c495f61451d()
{
    self endon( #"death" );
    var_ee4c6e2afcb5b82c = 10;
    rotatetime = level.gunship_speed[ "rotate" ] / 360 * var_ee4c6e2afcb5b82c;
    self rotateyaw( self.angles[ 2 ] + var_ee4c6e2afcb5b82c, rotatetime, rotatetime, 0 );
    degreespersecond = 360 / level.gunship_speed[ "rotate" ];
    var_47a3f478a98f61d5 = degreespersecond * 0.0174533;
    level.gunship_magnitude = var_47a3f478a98f61d5 * 9000;
    
    while ( true )
    {
        self rotateyaw( 360, level.gunship_speed[ "rotate" ] );
        wait level.gunship_speed[ "rotate" ];
    }
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0x4d8474d0, Offset: 0x985c
// Size: 0x2b
function private function_7667d244fcb9de09( gunner )
{
    level thread game_utility::fadetoblackforplayer( gunner, 1 );
    wait 1;
    level thread game_utility::fadetoblackforplayer( gunner, 0, 0.3 );
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0xa016faec, Offset: 0x988f
// Size: 0x5ec
function private attachgunner( gunner )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"leaving" );
    gunner setmainvision( "" );
    
    if ( level.gunshipsettings.var_b625d3773a2c5a1b )
    {
        function_7667d244fcb9de09( gunner );
    }
    
    /#
        thirdpersoncam = getdvarint( @"hash_f49f4fd233809e37", 0 );
        
        if ( thirdpersoncam )
        {
            if ( !level.gunshipsettings.var_b625d3773a2c5a1b )
            {
                if ( level.gunship_animtype == 1 )
                {
                    function_7be0e9ca69392745( self.gunshipintro );
                }
                else
                {
                    gunner function_567600cd70aa0f85( self.gunshipintro );
                }
            }
            
            self.streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
            return;
        }
    #/
    
    bundle = level.streakglobals.streakbundles[ "gunship" ];
    gunner function_6a8dc30f1a6c4838();
    gunner inventory_utility::_giveweapon( level.gunshipsettings.gunship_missile_weapon, undefined, undefined, 1 );
    gunner inventory_utility::_giveweapon( level.gunshipsettings.var_8969fe590c36e582, undefined, undefined, 1 );
    gunner inventory_utility::_giveweapon( level.gunshipsettings.var_3edfb285d2efa861, undefined, undefined, 1 );
    gunner inventory_utility::_switchtoweaponimmediate( level.gunshipsettings.gunship_missile_weapon );
    gunner val::set( "gunship_weap_swap_safety", "weapon_switch", 0 );
    
    if ( isdefined( level.gunshipvisionset ) )
    {
        self.currentvisionset = level.gunshipvisionset;
    }
    else
    {
        self.currentvisionset = bundle.var_267384a0c5d77a8a;
        
        if ( isdefined( level.mapname ) && ( issubstr( level.mapname, "_shipment" ) || issubstr( level.mapname, "mp_skerries" ) ) )
        {
            self.currentvisionset = bundle.var_f50cdf51c024eae2;
        }
    }
    
    waitframe();
    gunner cameraunlink();
    
    if ( !level.gunshipsettings.var_b625d3773a2c5a1b )
    {
        if ( level.gunship_animtype == 1 )
        {
            function_7be0e9ca69392745( self.gunshipintro );
        }
        else
        {
            gunner function_567600cd70aa0f85( self.gunshipintro );
        }
    }
    
    self.camera = spawn( "script_model", self.origin - ( 0, 0, 20 ) );
    self.camera setmodel( "tag_player" );
    self.camera.angles = vectortoangles( self.var_f0574b4cc0f1975a.origin - self.camera.origin );
    self.camera linkto( self );
    
    if ( isbot( gunner ) )
    {
        gunner cameralinkto( self.camera, "tag_player" );
        return;
    }
    
    arcclamps = function_a4a53c100050ed22( bundle );
    gunner killstreak_utility::playkillstreaktacomdialog( self.streakinfo, "gunship" + "_engage", #"engage", 1, undefined, "pilot" );
    gunner.usinggunship = 1;
    gunner.var_f92369164340ad6e = 1;
    gunner playerlinkweaponviewtodelta( self.camera, "tag_player", 1, arcclamps[ 0 ], arcclamps[ 1 ], arcclamps[ 2 ], arcclamps[ 3 ], 0, 1, 1 );
    gunner playerlinkedsetviewznear( 0 );
    
    if ( isdefined( self.currentvisionset ) )
    {
        gunner setmainvision( self.currentvisionset );
    }
    
    gunner setplayerangles( self.camera.angles );
    
    if ( level.gunshipsettings.var_15b893825838499f )
    {
        gunner val::set( "gunshipInUse", "ads", 1 );
    }
    
    gunner setcinematicmotionoverride( "player_gunship_ride_mp" );
    gunner thread killstreak_utility::function_785239235d790099( "65_instant_noscale" );
    gunner killstreak_utility::function_d546aaa588f088c3( self.streakinfo.streakname, "on" );
    gunner setclientomnvar( "ui_gunship_hud", 1 );
    gunner setclientomnvar( "ui_killstreak_weapon_1_ammo", gunner getweaponammoclip( level.gunshipsettings.gunship_missile_weapon ) );
    gunner setclientomnvar( "ui_killstreak_weapon_2_ammo", gunner getweaponammoclip( level.gunshipsettings.var_8969fe590c36e582 ) );
    gunner setclientomnvar( "ui_killstreak_weapon_3_ammo", gunner getweaponammoclip( level.gunshipsettings.var_3edfb285d2efa861 ) );
    gunner setclientomnvar( "ui_killstreak_countdown", gettime() + int( self.timeout * 1000 ) );
    gunner setclientomnvar( "ui_killstreak_health", self.currenthealth / self.maxhealth );
    gunner setclientomnvar( "ui_killstreak_flares", self.flaresreservecount );
    gunner setclientomnvar( "ui_killstreak_damage_state", 0 );
    gunner shellshock_utility_cpmp::_shellshock( %"killstreak_veh_camera_mp", #"top", self.timeout, 0 );
    gunner shellshock_utility_cpmp::_stopshellshock();
    params = { #var_4c96a742e6e746c9:1, #var_4ef38b0aefb507c6:bundle.var_f057b69340b14a5c, #var_d33b439c3dce3f3d:bundle.var_598d79add3230927, #hideoverlaytargetmarkerfriendly:bundle.hideoverlaytargetmarkerfriendly };
    gunner killstreak_shared::killstreak_assigntargetmarkers( params );
    self.owner thread function_fc87adc3374cc9b3( self );
    gunner thread function_b33d2bec95a94e73( self );
    thread function_18746fa344d836f1( level.gunshipsettings.gunship_missile_weapon );
}

// Namespace gunship
// Params 0, eflags: 0x4
// Checksum 0xcddb2919, Offset: 0x9e83
// Size: 0x187
function private function_6a8dc30f1a6c4838()
{
    weaplist = self getweaponslistprimaries();
    weaponstaken = [];
    meleeoverrideweapon = self getweaponmeleeslot();
    
    foreach ( weap in weaplist )
    {
        ismeleeoverrideweapon = !isnullweapon( meleeoverrideweapon ) && weap == meleeoverrideweapon;
        
        if ( !weap.isalternate )
        {
            clipammo = self getweaponammoclip( weap );
            stockammo = self getweaponammostock( weap );
            ismeleeoverrideweapon = ismeleeoverrideweapon;
            altweapon = weap getaltweapon();
            altclipammo = self getweaponammoclip( altweapon );
            altstockammo = self getweaponammostock( altweapon );
            weaponentry = { #altstockammo:altstockammo, #altclipammo:altclipammo, #altweapon:altweapon, #ismeleeoverrideweapon:ismeleeoverrideweapon, #stockammo:stockammo, #clipammo:clipammo, #weap:weap };
            weaponstaken[ weaponstaken.size ] = weaponentry;
            inventory_utility::_takeweapon( weap );
        }
    }
    
    self.var_6ad7cfadfe8874f = weaponstaken;
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0x164c09bc, Offset: 0xa012
// Size: 0x16f
function private function_6ec39bdad539663( player )
{
    if ( isdefined( self.var_6ad7cfadfe8874f ) )
    {
        foreach ( weaponentry in self.var_6ad7cfadfe8874f )
        {
            if ( !self hasweapon( weaponentry.weap ) )
            {
                inventory_utility::_giveweapon( weaponentry.weap, undefined, undefined, 1 );
                self setweaponammostock( weaponentry.weap, weaponentry.stockammo );
                self setweaponammoclip( weaponentry.weap, weaponentry.clipammo );
                item_weapon::function_d6a514964e1e7f2c( weaponentry.weap );
                altweapon = weaponentry.weap getaltweapon();
                
                if ( !isnullweapon( altweapon ) )
                {
                    self setweaponammoclip( altweapon, weaponentry.altclipammo );
                    self setweaponammostock( altweapon, weaponentry.altstockammo );
                }
                
                if ( weaponentry.ismeleeoverrideweapon )
                {
                    self assignweaponmeleeslot( weaponentry.weap );
                }
            }
        }
        
        self.var_6ad7cfadfe8874f = undefined;
    }
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0xb43e58e1, Offset: 0xa189
// Size: 0xf7
function private function_fc87adc3374cc9b3( gunship )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    gunship endon( #"death" );
    gunship endon( #"crashing" );
    gunship endon( #"leaving" );
    var_4565558cb4444c1e = [];
    bundle = killstreak::function_85b2d8e857ab4898( "gunship" );
    
    foreach ( data in bundle.var_e0715b47471288fb )
    {
        var_4565558cb4444c1e[ var_4565558cb4444c1e.size ] = data.killstreakname;
    }
    
    killstreak_shared::function_505d16f50dee75d2( var_4565558cb4444c1e );
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0x70f0aaf8, Offset: 0xa288
// Size: 0x1ec
function private function_a4a53c100050ed22( bundle )
{
    rightarcclamp = 100;
    leftarcclamp = 100;
    toparcclamp = 17;
    bottomarcclamp = 90;
    
    foreach ( map in bundle.var_5eff0b1b3fceefe8 )
    {
        if ( issubstr( level.mapname, map.name ) )
        {
            if ( isdefined( map.rightarcclamp ) )
            {
                rightarcclamp = map.var_458d45cf385909d0;
            }
            
            if ( isdefined( map.leftarcclamp ) )
            {
                leftarcclamp = map.var_9ea04823d5df50ad;
            }
            
            if ( isdefined( map.toparcclamp ) )
            {
                toparcclamp = map.var_6bc4800d0cd0d83d;
            }
            
            if ( isdefined( map.bottomarcclamp ) )
            {
                bottomarcclamp = map.var_6281572a9316eea3;
            }
            
            break;
        }
    }
    
    /#
        if ( getdvarint( @"hash_a9dd72f919820c3c", -1 ) >= 0 )
        {
            rightarcclamp = getdvarint( @"hash_a9dd72f919820c3c", -1 );
        }
        
        if ( getdvarint( @"hash_f6f54c4504a08e99", -1 ) >= 0 )
        {
            leftarcclamp = getdvarint( @"hash_f6f54c4504a08e99", -1 );
        }
        
        if ( getdvarint( @"hash_be524367b2923ffd", -1 ) >= 0 )
        {
            toparcclamp = getdvarint( @"hash_be524367b2923ffd", -1 );
        }
        
        if ( getdvarint( @"hash_276a14d37ceed71f", -1 ) >= 0 )
        {
            bottomarcclamp = getdvarint( @"hash_276a14d37ceed71f", -1 );
        }
    #/
    
    return [ rightarcclamp, leftarcclamp, toparcclamp, bottomarcclamp ];
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0xf794d41d, Offset: 0xa47d
// Size: 0xc8
function private function_4c84ff3a304c29a8( gunner )
{
    gunner endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"leaving" );
    level endon( #"game_ended" );
    
    if ( !utility::ismp() )
    {
        return;
    }
    
    if ( !level.gunship_lockon )
    {
        return;
    }
    
    thread function_e656bbfbca2f200a( gunner );
    
    while ( true )
    {
        if ( gunner adsbuttonpressed() )
        {
            currentweapon = gunner getcurrentweapon();
            
            if ( currentweapon.basename == level.gunshipsettings.gunship_missile_weapon )
            {
                function_888a33d29f7ae304( gunner, 1 );
                self notify( #"gunship_reset_hellfire_lockon" );
            }
        }
        
        waitframe();
    }
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0x654774d5, Offset: 0xa54d
// Size: 0xb1
function private function_e656bbfbca2f200a( gunner )
{
    gunner endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        result = utility::waittill_any_return( "death", "leaving", "crashing", "gunship_reset_hellfire_lockon" );
        
        if ( utility::issharedfuncdefined( #"gunship", #"hash_27a099ef3d3f4d09" ) )
        {
            gunner [[ utility::getsharedfunc( #"gunship", #"hash_27a099ef3d3f4d09" ) ]]();
        }
        
        gunner.finalizedlockon = undefined;
        gunner setclientomnvar( "ui_gunship_hellfire_lockon", 0 );
        
        if ( result != "gunship_reset_hellfire_lockon" )
        {
            break;
        }
    }
}

// Namespace gunship
// Params 2, eflags: 0x4
// Checksum 0x1da2cec3, Offset: 0xa606
// Size: 0x344
function private function_888a33d29f7ae304( gunner, var_9c25cb51814c9a55 )
{
    gunner endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( gunner adsbuttonpressed() )
    {
        if ( ( gunner playerads() >= 0.95 || var_9c25cb51814c9a55 ) && self.missileloaded )
        {
            gunner.missilelauncheruseentered = 1;
            targets = [];
            
            if ( utility::issharedfuncdefined( #"gunship", #"hash_aad609da4b585443" ) )
            {
                targets = [[ utility::getsharedfunc( #"gunship", #"hash_aad609da4b585443" ) ]]( 0 );
            }
            
            if ( targets.size == 0 )
            {
                self notify( #"gunship_reset_hellfire_lockon" );
                waitframe();
                continue;
            }
            
            targets = sortbydistance( targets, gunner.origin );
            
            if ( !isdefined( gunner.missilelauncherstage ) )
            {
                gunner.missilelauncherstage = 0;
            }
            
            if ( gunner.missilelauncherstage == 0 )
            {
                stingtargstruct = undefined;
                var_f61de127e3e153d4 = 0;
                
                foreach ( target in targets )
                {
                    if ( !isdefined( target ) )
                    {
                        continue;
                    }
                    
                    stingtargstruct = function_cedefdba23f6afbf( gunner, target );
                    
                    if ( isdefined( stingtargstruct ) )
                    {
                        break;
                    }
                }
                
                if ( !isdefined( stingtargstruct ) )
                {
                    self notify( #"gunship_reset_hellfire_lockon" );
                    waitframe();
                    continue;
                }
                
                gunner.missilelaunchertarget = stingtargstruct.target;
                gunner.missilelauncherlockstarttime = gettime();
                gunner.missilelauncherlostsightlinetime = 0;
                
                if ( isdefined( gunner.missilelaunchertarget ) )
                {
                    weapon_utility::addlockedon( gunner.missilelaunchertarget, gunner );
                }
                
                thread function_a1faa2ee4488ae67( gunner );
                gunner.missilelauncherstage = 1;
            }
            
            if ( gunner.missilelauncherstage == 1 )
            {
                var_5ed7b2e80af86e68 = function_cedefdba23f6afbf( gunner );
                
                if ( !isdefined( var_5ed7b2e80af86e68 ) )
                {
                    self notify( #"gunship_reset_hellfire_lockon" );
                    waitframe();
                    continue;
                }
                
                timepassed = gettime() - gunner.missilelauncherlockstarttime;
                
                if ( timepassed < 500 )
                {
                    waitframe();
                    continue;
                }
                
                self notify( #"hash_c4d84e330ea3aed6" );
                thread function_2e4fa5dec9af748b( gunner );
                gunner.missilelauncherstage = 2;
            }
            
            if ( gunner.missilelauncherstage == 2 )
            {
                var_5ed7b2e80af86e68 = function_cedefdba23f6afbf( gunner );
                
                if ( !isdefined( var_5ed7b2e80af86e68 ) )
                {
                    self notify( #"gunship_reset_hellfire_lockon" );
                    waitframe();
                    continue;
                }
                
                if ( !gunner.finalizedlockon )
                {
                    gunner setclientomnvar( "ui_gunship_hellfire_lockon", 1 );
                    gunner.finalizedlockon = 1;
                    
                    if ( utility::issharedfuncdefined( #"gunship", #"hash_b0da44ffae9de781" ) )
                    {
                        gunner [[ utility::getsharedfunc( #"gunship", #"hash_b0da44ffae9de781" ) ]]( var_5ed7b2e80af86e68 );
                    }
                    
                    waitframe();
                    continue;
                }
            }
        }
        
        waitframe();
    }
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0xbe17a0c7, Offset: 0xa952
// Size: 0xc8
function private function_a1faa2ee4488ae67( gunner )
{
    gunner endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"explode" );
    self endon( #"gunship_reset_hellfire_lockon" );
    self endon( #"hash_c4d84e330ea3aed6" );
    level endon( #"game_ended" );
    bundle = level.streakglobals.streakbundles[ "gunship" ];
    
    while ( true )
    {
        gunner playlocalsound( level.gunshipsettings.var_86e7453202e9136e );
        gunner playrumbleonentity( level.gunshipsettings.var_32cf511b535edae2 );
        wait 0.6;
    }
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0xa387bd92, Offset: 0xaa22
// Size: 0x97
function private function_2e4fa5dec9af748b( gunner )
{
    gunner endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"explode" );
    self endon( #"gunship_reset_hellfire_lockon" );
    level endon( #"game_ended" );
    gunner playlocalsound( level.gunshipsettings.var_9e3f4922db98b423 );
    
    while ( true )
    {
        gunner playrumbleonentity( level.gunshipsettings.var_581289a0c3b74aa9 );
        wait 0.25;
    }
}

// Namespace gunship
// Params 2, eflags: 0x4
// Checksum 0x7af14f69, Offset: 0xaac1
// Size: 0x239
function private function_cedefdba23f6afbf( gunner, targetoverride )
{
    var_215f461ee332af42 = 0;
    
    /#
        var_215f461ee332af42 = getdvarint( @"hash_10368af4dee3ba2c", 0 );
    #/
    
    lockontarget = undefined;
    
    if ( isdefined( gunner.missilelaunchertarget ) )
    {
        lockontarget = gunner.missilelaunchertarget;
    }
    else if ( isdefined( targetoverride ) )
    {
        lockontarget = targetoverride;
    }
    
    if ( !isdefined( lockontarget ) )
    {
        return;
    }
    
    if ( !var_215f461ee332af42 && lockontarget vehicle::is_vehicle() && vehicle::is_friendly_to_player( lockontarget, gunner ) )
    {
        return;
    }
    
    stingtargstruct = undefined;
    
    if ( utility::issharedfuncdefined( #"gunship", #"hash_6e7c6d31324a2e48" ) )
    {
        stingtargstruct = [[ utility::getsharedfunc( #"gunship", #"hash_6e7c6d31324a2e48" ) ]]( gunner, lockontarget );
    }
    
    if ( !isdefined( stingtargstruct ) )
    {
        return;
    }
    
    if ( utility::issharedfuncdefined( #"gunship", #"hash_6faac5d24e5da258" ) )
    {
        stingtargstruct [[ utility::getsharedfunc( #"gunship", #"hash_6faac5d24e5da258" ) ]]();
    }
    
    if ( utility::issharedfuncdefined( #"gunship", #"hash_51ca9a790ed5093b" ) )
    {
        stingtargstruct [[ utility::getsharedfunc( #"gunship", #"hash_51ca9a790ed5093b" ) ]]();
    }
    
    if ( utility::issharedfuncdefined( #"gunship", #"hash_87abf7a064255a7d" ) )
    {
        stingtargstruct [[ utility::getsharedfunc( #"gunship", #"hash_87abf7a064255a7d" ) ]]();
    }
    
    if ( utility::issharedfuncdefined( #"gunship", #"hash_b5b0702830fbc1d9" ) )
    {
        if ( !stingtargstruct [[ utility::getsharedfunc( #"gunship", #"hash_b5b0702830fbc1d9" ) ]]() )
        {
            return;
        }
    }
    
    if ( utility::issharedfuncdefined( #"gunship", #"hash_8e84281c4043bbcb" ) )
    {
        stingtargstruct [[ utility::getsharedfunc( #"gunship", #"hash_8e84281c4043bbcb" ) ]]();
    }
    
    if ( utility::issharedfuncdefined( #"gunship", #"hash_3eadade5567ff796" ) )
    {
        if ( !gunner [[ utility::getsharedfunc( #"gunship", #"hash_3eadade5567ff796" ) ]]( stingtargstruct ) )
        {
            return;
        }
    }
    
    return stingtargstruct;
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0x5b10b0a, Offset: 0xad03
// Size: 0x452
function private function_b8735eee6e218a26( gunner )
{
    gunner endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"leaving" );
    level endon( #"game_ended" );
    
    /#
        thirdpersoncam = getdvarint( @"hash_f49f4fd233809e37", 0 );
        
        if ( thirdpersoncam )
        {
            return;
        }
    #/
    
    bundle = level.streakglobals.streakbundles[ "gunship" ];
    weaponlistorder = [ level.gunshipsettings.gunship_missile_weapon, level.gunshipsettings.var_8969fe590c36e582, level.gunshipsettings.var_3edfb285d2efa861 ];
    var_be71f5eb968eab60 = [ 3, 2, 1 ];
    weapontags = [ level.gunshipsettings.var_5e9719bd45e14a53, level.gunshipsettings.var_830820d791a6783a, level.gunshipsettings.var_afaeffc7324f7236 ];
    
    if ( !isai( gunner ) )
    {
        gunner notifyonplayercommand( "gunship_switch_weapon_next", "+weapnext" );
        gunner notifyonplayercommand( "gunship_switch_weapon_next", "selectweapon2" );
        gunner notifyonplayercommand( "gunship_switch_weapon_prev", "+weapprev" );
        gunner notifyonplayercommand( "gunship_switch_weapon_prev", "selectweapon1" );
    }
    
    gunner val::set( "gunship_weap_swap_safety", "weapon_switch", 1 );
    newweapon = level.gunshipsettings.gunship_missile_weapon;
    
    if ( isdefined( newweapon ) )
    {
        gunner inventory_utility::_switchtoweaponimmediate( newweapon );
        gunner setclientomnvar( "ui_killstreak_weapon", 3 );
        waitframe();
        
        if ( level.gunshipsettings.var_1f29af48422f9483 )
        {
            function_2954c03154b718cd( gunner, weapontags, 2, bundle );
        }
        
        thread function_18746fa344d836f1( newweapon );
    }
    
    while ( true )
    {
        cmd = gunner utility::waittill_any_return( "gunship_switch_weapon_prev", "gunship_switch_weapon_next" );
        
        if ( !isdefined( cmd ) )
        {
            continue;
        }
        
        gunner playlocalsound( "veh_rex_air_gunship_weapon_switch_plr" );
        currentweapon = gunner getcurrentweapon();
        newweapon = undefined;
        newweaponindex = undefined;
        
        foreach ( index, weapon in weaponlistorder )
        {
            if ( currentweapon.basename == weapon )
            {
                if ( cmd == "gunship_switch_weapon_prev" )
                {
                    newweaponindex = index - 1;
                    
                    if ( newweaponindex < 0 )
                    {
                        newweaponindex = weaponlistorder.size - 1;
                    }
                }
                else if ( cmd == "gunship_switch_weapon_next" )
                {
                    newweaponindex = index + 1;
                    
                    if ( newweaponindex > weaponlistorder.size - 1 )
                    {
                        newweaponindex = 0;
                    }
                }
                
                newweapon = weaponlistorder[ newweaponindex ];
                var_d9b444e3b46d68f6 = var_be71f5eb968eab60[ newweaponindex ];
                break;
            }
        }
        
        if ( newweapon )
        {
            if ( self.currentvisionset == killstreak_utility::function_2c6a2b2cb28d923a() )
            {
                dofinfo = function_cb0fe4c9bb14b37a( newweapon );
                gunner setphysicaldepthoffield( dofinfo.fstop, dofinfo.focusdistance, 20, 20 );
            }
            
            if ( newweapon != level.gunshipsettings.gunship_missile_weapon && level.gunshipsettings.var_d3375d11c0ccfdde )
            {
                gunner notify( #"hash_6c0c4bd6c13f24a4" );
            }
            
            gunner inventory_utility::_switchtoweaponimmediate( newweapon );
            gunner setclientomnvar( "ui_killstreak_weapon", var_d9b444e3b46d68f6 );
            gunner killstreak_shared::function_8bd91ec764c0390b( "killstreak_weapon_change_shutter" );
            
            if ( level.gunshipsettings.var_1f29af48422f9483 )
            {
                function_2954c03154b718cd( gunner, weapontags, newweaponindex, bundle );
            }
            
            thread function_18746fa344d836f1( newweapon );
            gunner val::set( "gunship_weap_swap_safety", "weapon_switch", 0 );
            hostmigration::waitlongdurationwithpause( 0.4 );
            gunner val::set( "gunship_weap_swap_safety", "weapon_switch", 1 );
        }
    }
}

// Namespace gunship
// Params 4, eflags: 0x4
// Checksum 0x591a63f, Offset: 0xb15d
// Size: 0x15e
function private function_2954c03154b718cd( gunner, weapontags, currentweaponindex, bundle )
{
    var_873a348d136399d8 = bundle.var_b0abfcf50473c451 ?? 0;
    weapontag = weapontags[ currentweaponindex ];
    
    if ( isdefined( weapontag ) )
    {
        tagpos = self gettagorigin( weapontag );
        tagpos = ( tagpos[ 0 ], tagpos[ 1 ], tagpos[ 2 ] + var_873a348d136399d8 );
        gunner cameraunlink();
        self.camera.origin = tagpos;
        self.camera.angles = vectortoangles( self.var_f0574b4cc0f1975a.origin - self.camera.origin );
        self.camera setmodel( "tag_player" );
        self.camera linkto( self );
        
        if ( isbot( gunner ) )
        {
            gunner cameralinkto( self.camera, "tag_player" );
            return;
        }
        
        arcclamps = function_a4a53c100050ed22( bundle );
        gunner playerlinkweaponviewtodelta( self.camera, "tag_player", 1, arcclamps[ 0 ], arcclamps[ 1 ], arcclamps[ 2 ], arcclamps[ 3 ], 0, 1, 0 );
        gunner playerlinkedsetviewznear( 0 );
    }
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0xacff9121, Offset: 0xb2c3
// Size: 0x28e
function private watchweaponfired( gunner )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"leaving" );
    level endon( #"game_ended" );
    
    /#
        thirdpersoncam = getdvarint( @"hash_f49f4fd233809e37", 0 );
        
        if ( thirdpersoncam )
        {
            return;
        }
    #/
    
    streakinfo = self.streakinfo;
    bundle = level.streakglobals.streakbundles[ "gunship" ];
    
    while ( true )
    {
        gunner waittill( #"missile_fire", projectile );
        projectile.streakinfo = streakinfo;
        streakinfo.shots_fired++;
        weapon = gunner getcurrentweapon();
        currentammo = gunner getweaponammoclip( weapon );
        weaponbasename = weapon.basename;
        
        if ( weaponbasename == level.gunshipsettings.gunship_missile_weapon )
        {
            earthquake( level.gunshipsettings.var_dfed95600552872, level.gunshipsettings.var_72a49deb1d4ec8f0, self.origin, 1000 );
            gunner setclientomnvar( "ui_killstreak_weapon_1_ammo", currentammo );
            
            if ( level.gunshipsettings.var_d3375d11c0ccfdde )
            {
                projectile thread function_b81cb2fa3dba641( self, gunner );
            }
            else if ( level.gunshipsettings.var_f6dc45b7d0c693ea )
            {
                projectile thread function_41cf3e54c7edde14( self, gunner, level.gunshipsettings.var_98db2718a76c31fb );
            }
            else
            {
                projectile function_ca80eb24d2ac6f73( self, gunner );
            }
        }
        else if ( weaponbasename == level.gunshipsettings.var_8969fe590c36e582 )
        {
            earthquake( level.gunshipsettings.var_92ca6bfce725bc61, level.gunshipsettings.var_4803b04008a3b83d, self.origin, 1000 );
            gunner setclientomnvar( "ui_killstreak_weapon_2_ammo", currentammo );
            projectile function_ca80eb24d2ac6f73( self, gunner );
        }
        else if ( weaponbasename == level.gunshipsettings.var_3edfb285d2efa861 )
        {
            gunner setclientomnvar( "ui_killstreak_weapon_3_ammo", currentammo );
            projectile function_ca80eb24d2ac6f73( self, gunner );
        }
        
        projectile thread function_6bd125d9c1119895( self, gunner, weaponbasename );
        
        if ( currentammo == 0 )
        {
            gunner thread function_3da1894ec0a4d323( weapon, self );
        }
    }
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0x9b04f1ba, Offset: 0xb559
// Size: 0x85
function private getmissileexplscale( weaponbasename )
{
    scale = 1;
    
    if ( weaponbasename == level.gunshipsettings.gunship_missile_weapon )
    {
        scale = 0.75;
    }
    else if ( weaponbasename == level.gunshipsettings.var_8969fe590c36e582 )
    {
        scale = 0.5;
    }
    else if ( weaponbasename == level.gunshipsettings.var_3edfb285d2efa861 )
    {
        scale = 0.15;
    }
    
    return scale;
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0xf3178957, Offset: 0xb5e7
// Size: 0x7f
function private getmissileexplradius( weaponbasename )
{
    radius = 1;
    
    if ( weaponbasename == level.gunshipsettings.gunship_missile_weapon )
    {
        radius = 2000;
    }
    else if ( weaponbasename == level.gunshipsettings.var_8969fe590c36e582 )
    {
        radius = 1300;
    }
    else if ( weaponbasename == level.gunshipsettings.var_3edfb285d2efa861 )
    {
        radius = 700;
    }
    
    return radius;
}

// Namespace gunship
// Params 3, eflags: 0x4
// Checksum 0xa4977265, Offset: 0xb66f
// Size: 0x99
function private function_41cf3e54c7edde14( gunship, gunner, var_98db2718a76c31fb )
{
    gunship endon( #"death" );
    gunship endon( #"leaving" );
    gunship endon( #"crashing" );
    gunner endon( #"disconnect" );
    self endon( #"death" );
    targetent = gunship.hellfiretarget;
    self missile_settargetpos( gunship.hellfiretarget.origin );
    wait var_98db2718a76c31fb;
    self missile_cleartarget();
}

// Namespace gunship
// Params 2, eflags: 0x4
// Checksum 0x5e6f31f0, Offset: 0xb710
// Size: 0xc3
function private function_b81cb2fa3dba641( gunship, gunner )
{
    gunship endon( #"death" );
    gunship endon( #"leaving" );
    gunship endon( #"crashing" );
    gunner endon( #"disconnect" );
    self endon( #"death" );
    targetent = gunship.hellfiretarget;
    
    if ( isdefined( gunner.missilelaunchertarget ) && gunner.missilelauncherstage == 2 )
    {
        targetent = gunner.missilelaunchertarget;
        gunship notify( #"gunship_reset_hellfire_lockon" );
    }
    
    self missile_settargetent( targetent );
    gunner waittill( #"hash_6c0c4bd6c13f24a4" );
    self missile_cleartarget();
}

// Namespace gunship
// Params 2, eflags: 0x4
// Checksum 0x1c3fa363, Offset: 0xb7db
// Size: 0x87
function private function_ca80eb24d2ac6f73( gunship, gunner )
{
    gunship endon( #"death" );
    gunship endon( #"leaving" );
    gunship endon( #"crashing" );
    gunner endon( #"disconnect" );
    self endon( #"death" );
    targetent = gunship.hellfiretarget;
    self missile_settargetpos( gunship.hellfiretarget.origin );
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0xbf5bd7fb, Offset: 0xb86a
// Size: 0x42
function private function_2cc09ae2dee32ec4( gunner )
{
    if ( !isai( gunner ) )
    {
        gunner thread player_utility::watchthermalinputchange();
    }
    
    function_a87a5db85f940fad( gunner );
    
    if ( isdefined( gunner ) && !isai( gunner ) )
    {
        gunner player_utility::stopwatchingthermalinputchange();
    }
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0x5a6b385d, Offset: 0xb8b4
// Size: 0x37c
function private function_a87a5db85f940fad( gunner )
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    gunner endon( #"disconnect" );
    level endon( #"game_ended" );
    self.flashlight = spawn( "script_model", self.origin );
    self.flashlight setmodel( "ks_gunship_mp" );
    self.flashlight dontinterpolate();
    self.flashlight thread function_324577211022706c( self, gunner );
    
    if ( utility::isnightmap() )
    {
        if ( isdefined( self.flashlight ) )
        {
            self.flashlight thread showflashlight();
        }
    }
    
    togglethermal = 0;
    var_92fdfd77367b8a9d = 1;
    bundle = level.streakglobals.streakbundles[ "gunship" ];
    
    /#
        thirdpersoncam = getdvarint( @"hash_f49f4fd233809e37", 0 );
        
        if ( thirdpersoncam )
        {
            var_92fdfd77367b8a9d = 0;
        }
    #/
    
    thermalfstop = 12;
    var_4a403cf63d50a47c = 1000;
    thermalvisionset = killstreak_utility::function_2c6a2b2cb28d923a();
    
    if ( utility::isnightmap() && var_92fdfd77367b8a9d )
    {
        gunner player_utility::setthermalvision( 1, thermalfstop, var_4a403cf63d50a47c );
        self.currentvisionset = thermalvisionset;
        
        if ( isdefined( self.flashlight ) )
        {
            self.flashlight notify( #"flashlight_on" );
        }
        
        togglethermal = 1;
        gunner shellshock_utility_cpmp::_shellshock( %"killstreak_veh_camera_flir_mp", #"top", self.timeout, 0 );
        gunner setclientomnvar( "ui_killstreak_thermal_mode", 1 );
        gunner setmainvision( thermalvisionset );
    }
    
    while ( true )
    {
        gunner waittill( #"switch_thermal_mode" );
        currentgunshipweapon = gunner getcurrentweapon();
        dofinfo = function_cb0fe4c9bb14b37a( currentgunshipweapon.basename );
        
        if ( !togglethermal )
        {
            gunner player_utility::setthermalvision( 1, dofinfo.fstop, dofinfo.focusdistance );
            self.currentvisionset = thermalvisionset;
            togglethermal = 1;
            gunner shellshock_utility_cpmp::_shellshock( %"killstreak_veh_camera_flir_mp", #"top", self.timeout, 0 );
            gunner setclientomnvar( "ui_killstreak_thermal_mode", 1 );
            gunner setmainvision( thermalvisionset );
            continue;
        }
        
        defaultvisionset = bundle.var_267384a0c5d77a8a;
        
        if ( isdefined( level.mapname ) && ( issubstr( level.mapname, "_shipment" ) || issubstr( level.mapname, "mp_skerries" ) || getdvarint( @"hash_ef7e2418dc2fe517", 0 ) ) )
        {
            defaultvisionset = bundle.var_f50cdf51c024eae2;
        }
        
        if ( isdefined( level.gunshipvisionset ) )
        {
            gunner setmainvision( level.gunshipvisionset );
            self.currentvisionset = level.gunshipvisionset;
        }
        else
        {
            gunner setmainvision( defaultvisionset );
            self.currentvisionset = defaultvisionset;
        }
        
        togglethermal = 0;
        gunner shellshock_utility_cpmp::_shellshock( %"killstreak_veh_camera_mp", #"top", self.timeout, 0 );
        gunner setclientomnvar( "ui_killstreak_thermal_mode", 0 );
        gunner player_utility::setthermalvision( 0 );
    }
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0x6e1e337b, Offset: 0xbc38
// Size: 0xc3
function private function_cb0fe4c9bb14b37a( weaponbasename )
{
    dofinfo = {};
    
    if ( weaponbasename == level.gunshipsettings.gunship_missile_weapon )
    {
        dofinfo.fstop = 8;
        dofinfo.focusdistance = 600;
    }
    else if ( weaponbasename == level.gunshipsettings.var_8969fe590c36e582 )
    {
        dofinfo.fstop = 8;
        dofinfo.focusdistance = 600;
    }
    else if ( weaponbasename == level.gunshipsettings.var_3edfb285d2efa861 )
    {
        dofinfo.fstop = 8;
        dofinfo.focusdistance = 3500;
    }
    
    return dofinfo;
}

// Namespace gunship
// Params 2, eflags: 0x4
// Checksum 0x4451ec06, Offset: 0xbd04
// Size: 0xa6
function private function_324577211022706c( gunship, gunner )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    useplayerangles = 1;
    
    /#
        thirdpersoncam = getdvarint( @"hash_f49f4fd233809e37", 0 );
        
        if ( thirdpersoncam )
        {
            useplayerangles = 0;
        }
    #/
    
    while ( isdefined( gunship ) && isdefined( gunner ) )
    {
        self.origin = gunship.origin;
        
        if ( useplayerangles )
        {
            self.angles = gunner getplayerangles();
        }
        
        wait 0.05;
    }
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace gunship
// Params 0, eflags: 0x4
// Checksum 0xa0fc78a, Offset: 0xbdb2
// Size: 0x7d
function private showflashlight()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    playfxontag( utility::getfx( "camera_spotlight" ), self, "tag_origin" );
    
    while ( true )
    {
        level waittill( #"hash_d94a0708ab9a7c55" );
        stopfxontag( utility::getfx( "camera_spotlight" ), self, "tag_origin" );
        hostmigration::waitlongdurationwithpause( 0.1 );
        playfxontag( utility::getfx( "camera_spotlight" ), self, "tag_origin" );
    }
}

// Namespace gunship
// Params 2, eflags: 0x4
// Checksum 0x9eea012b, Offset: 0xbe37
// Size: 0x24e
function private function_3da1894ec0a4d323( weapon, gunship )
{
    gunship endon( #"death" );
    gunship endon( #"crashing" );
    gunship endon( #"leaving" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    bundle = level.streakglobals.streakbundles[ "gunship" ];
    weaponrootname = getgunshipweaponrootname( weapon );
    reloadsound = weaponrootname + "_mp_reload";
    var_e2a20f1ceef2d751 = strtok( weaponrootname, "_" );
    
    if ( var_e2a20f1ceef2d751[ 0 ] == "gunship" )
    {
        reloadsound = "ac130";
        
        for ( i = 1; i < var_e2a20f1ceef2d751.size ; i++ )
        {
            appendstring = var_e2a20f1ceef2d751[ i ];
            
            if ( appendstring == "hellfire" || appendstring == "missile" )
            {
                appendstring = "105mm";
            }
            
            reloadsound = reloadsound + "_" + appendstring;
        }
        
        reloadsound += "_mp_reload";
    }
    
    self playlocalsound( reloadsound );
    
    if ( weapon.basename == level.gunshipsettings.gunship_missile_weapon )
    {
        gunship.missileloaded = 0;
    }
    
    function_1e4cf09936d823b2( weapon, weaponrootname );
    reloaddialog = weaponrootname + "_reload";
    killstreak_utility::playkillstreaktacomdialog( gunship.streakinfo, reloaddialog, #"reload", undefined, undefined, "pilot" );
    maxammo = weaponmaxammo( weapon );
    self setweaponammoclip( weapon, maxammo );
    
    if ( weapon.basename == level.gunshipsettings.gunship_missile_weapon )
    {
        gunship.missileloaded = 1;
    }
    
    var_e735af55bb6b24df = undefined;
    
    switch ( weaponrootname )
    {
        case #"hash_a595cc01d9fdb1c3":
        case #"hash_cf44fa68e20a0838":
            var_e735af55bb6b24df = "ui_killstreak_weapon_1_ammo";
            break;
        case #"hash_f7dc9df20da28f2":
            var_e735af55bb6b24df = "ui_killstreak_weapon_2_ammo";
            break;
        case #"hash_9e7bbed3c5c35ca3":
            var_e735af55bb6b24df = "ui_killstreak_weapon_3_ammo";
            break;
    }
    
    self setclientomnvar( var_e735af55bb6b24df, maxammo );
}

// Namespace gunship
// Params 2, eflags: 0x4
// Checksum 0x4b0a9958, Offset: 0xc08d
// Size: 0xd2
function private function_1e4cf09936d823b2( weapon, weaponrootname )
{
    reloadtime = level.weaponreloadtime[ weapon.basename ];
    var_4e129dddbbe48fe4 = undefined;
    
    switch ( weaponrootname )
    {
        case #"hash_a595cc01d9fdb1c3":
        case #"hash_cf44fa68e20a0838":
            var_4e129dddbbe48fe4 = "ui_killstreak_weapon_1_reloadtime";
            break;
        case #"hash_f7dc9df20da28f2":
            var_4e129dddbbe48fe4 = "ui_killstreak_weapon_2_reloadtime";
            break;
        case #"hash_9e7bbed3c5c35ca3":
            var_4e129dddbbe48fe4 = "ui_killstreak_weapon_3_reloadtime";
            break;
    }
    
    self setclientomnvar( var_4e129dddbbe48fe4, gettime() + int( reloadtime * 1000 ) );
    
    while ( true )
    {
        wait 0.05;
        reloadtime -= 0.05;
        
        if ( reloadtime <= 0 )
        {
            break;
        }
    }
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0x66a39ca9, Offset: 0xc167
// Size: 0x7f
function private getgunshipweaponrootname( weapon )
{
    index = 0;
    weaponname = weapon.basename;
    tokens = strtok( weaponname, "_" );
    
    if ( tokens[ 0 ] == "sat" || tokens[ 0 ] == "cer" || tokens[ 0 ] == "zul" )
    {
        index = 1;
    }
    
    return tokens[ index ] + "_" + tokens[ index + 1 ];
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0xf4deb594, Offset: 0xc1ef
// Size: 0xc9
function private function_368a8a0dab1a6640( pilot )
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    level endon( #"game_ended" );
    
    /#
        thirdpersoncam = getdvarint( @"hash_f49f4fd233809e37", 0 );
        
        if ( thirdpersoncam )
        {
            return;
        }
    #/
    
    pilot.gunship_cloudsfx = spawn( "script_model", pilot geteye() );
    pilot.gunship_cloudsfx setmodel( "tag_origin" );
    pilot.gunship_cloudsfx linkto( pilot, "tag_eye" );
    waitframe();
    playfxontagforclients( utility::getfx( "clouds" ), pilot.gunship_cloudsfx, "tag_origin", pilot );
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0xe1c28236, Offset: 0xc2c0
// Size: 0x27
function private deleteaftertime( delay )
{
    self endon( #"death" );
    hostmigration::waitlongdurationwithpause( delay );
    self delete();
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0x8e426b8c, Offset: 0xc2ef
// Size: 0x6f
function private crash( gunner )
{
    self notify( #"crashing" );
    self.crashed = 1;
    level.gunshipinuse = 0;
    streakinfo = self.streakinfo;
    level callback::callback( #"killstreak_finish_use", { #streakinfo:streakinfo } );
    thread function_63db5f70227c25ea( gunner );
    thread function_867fa37b8327bb21();
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0x1a4b0778, Offset: 0xc366
// Size: 0x312
function private function_63db5f70227c25ea( gunner )
{
    bundle = level.streakglobals.streakbundles[ "gunship" ];
    
    if ( self getscriptablehaspart( "audio_engine_sounds" ) )
    {
        self setscriptablepartstate( "audio_engine_sounds", "off" );
    }
    
    if ( !isdefined( gunner ) )
    {
        return;
    }
    
    gunner function_eb00542899b022bf( 0 );
    
    if ( level.gunshipsettings.applyoutlines )
    {
        gunner clearfullscreenfx();
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self endon( #"death" );
    gunner endon( #"disconnect" );
    thread function_b4d0f6bb37e2191( self.owner, 1 );
    
    if ( level.gunshipsettings.var_b625d3773a2c5a1b )
    {
        gunner val::group_set( "gunshipCutScene", 0 );
        var_53f1604c636098d3 = utility::getstruct( "cer_gunship_intro", "targetname" );
        scene_struct = {};
        
        if ( isdefined( var_53f1604c636098d3 ) )
        {
            sceneroot = structcopy( var_53f1604c636098d3, 1 );
            scene_struct.origin = sceneroot.origin;
            scene_struct.angles = sceneroot.angles;
        }
        else
        {
            scene_struct.origin = self.origin;
            scene_struct.angles = vectortoangles( anglestoforward( self.angles ) );
        }
        
        self.owner.animname = "Player 1";
        var_ea3fd271e96a10c0 = 0;
        
        /#
            var_ea3fd271e96a10c0 = getdvarint( @"hash_923725d8ac07cbfd", 0 );
        #/
        
        if ( !var_ea3fd271e96a10c0 )
        {
            if ( isdefined( self.owner ) )
            {
                self.owner unlink();
            }
            
            gunner painvisionoff();
            scene_struct.gunship = self;
            scene_struct scene::init( [ self.owner ], "shot_010", bundle.var_ead3326be466f544 ?? "t10_killstreak_gunship_crash_sequence" );
            scene::add_scene_func( scene_struct.script_scenescriptbundle, &function_42737e4347fea43c, "callback_done" );
            scene_struct scene::play( [ self.owner ], "shot_010" );
            gunner painvisionon();
            self.owner clearclienttriggeraudiozone( 0.5 );
        }
    }
    else if ( isdefined( self.gunshipintro ) && level.gunship_animtype == 0 )
    {
        self.gunshipintro function_5d16cd690851e4dc( gunner, "light_interior_outro", "on", "ks_gunship_interior_outro", 0.5 );
        var_d91fc3746fa25ca9 = animation::get_scr_animlength( "gunship", "outro_gunner" );
        gunner thread function_7a281854f4e856c5( var_d91fc3746fa25ca9 );
        gunner function_59a8405783effe95( self.gunshipintro, "outro" );
        self.gunshipintro function_5d16cd690851e4dc( gunner, "light_interior_outro", "off", "ks_gunship_interior_outro", 0 );
    }
    
    returnplayer( gunner, 1 );
}

// Namespace gunship
// Params 0, eflags: 0x4
// Checksum 0x442edc8e, Offset: 0xc680
// Size: 0x33d
function private function_867fa37b8327bb21()
{
    level endon( #"game_ended" );
    
    if ( isdefined( self.leftwingfxent ) && isdefined( self.rightwingfxent ) )
    {
        self.leftwingfxent setscriptablepartstate( "engine_blowout", "off" );
        self.rightwingfxent setscriptablepartstate( "engine_blowout", "off" );
    }
    
    if ( isdefined( self.leftwingfxent ) && isdefined( self.rightwingfxent ) )
    {
        hostmigration::waitlongdurationwithpause( 3 );
        self.leftwingfxent setscriptablepartstate( "engine_blowout", "on" );
        self.rightwingfxent setscriptablepartstate( "engine_blowout", "on" );
    }
    
    self unlink();
    self.var_d511ee197fc9d1c9 = spawn( "script_model", self.origin );
    self.var_d511ee197fc9d1c9 setmodel( "tag_origin" );
    self.var_d511ee197fc9d1c9.angles = vectortoangles( anglestoforward( self.angles ) );
    
    if ( isdefined( self.leftwingfxent ) && isdefined( self.rightwingfxent ) )
    {
        self.leftwingfxent setscriptablepartstate( "engine_blowout", "off" );
        self.rightwingfxent setscriptablepartstate( "engine_blowout", "off" );
        self.leftwingfxent setscriptablepartstate( "body_damage_heavy", "off" );
        self.rightwingfxent setscriptablepartstate( "body_damage_heavy", "off" );
    }
    
    self setscriptablepartstate( "lights", "off" );
    crashmodel = spawn( "script_model", self.origin );
    crashmodel setmodel( level.gunshipsettings.var_1b10f71d7a437fb6 );
    crashmodel.angles = self.angles;
    crashmodel.animname = self.streakinfo.streakname;
    crashmodel animation::setanimtree();
    explosionfxent = spawn( "script_model", self.origin );
    explosionfxent setmodel( level.gunshipsettings.var_c47e9ebf69d1024c );
    explosionfxent.angles = self.angles;
    explosionfxent linkto( crashmodel, "tag_body" );
    
    /#
    #/
    
    crashpart = "crash_air";
    explosionfxent setscriptablepartstate( crashpart, "on", 0 );
    
    if ( utility::issharedfuncdefined( #"entity", #"hash_cb0d9e569e0f2002" ) )
    {
        explosionfxent thread [[ utility::getsharedfunc( #"entity", #"hash_cb0d9e569e0f2002" ) ]]( 10 );
        crashmodel thread [[ utility::getsharedfunc( #"entity", #"hash_cb0d9e569e0f2002" ) ]]( 10 );
    }
    
    crashmodel thread crashaudio();
    var_43b5cb40a1c04c38 = "outro_gunship_death";
    var_235ca49abaff28d0 = animation::get_scr_animlength( "gunship", var_43b5cb40a1c04c38 );
    thread delayhide();
    thread function_eb10b5fb353fd7a6( var_235ca49abaff28d0 );
    self.var_d511ee197fc9d1c9 animation::anim_single_solo( crashmodel, var_43b5cb40a1c04c38 );
    self.var_d511ee197fc9d1c9 delete();
    removeplane( 1 );
}

// Namespace gunship
// Params 0, eflags: 0x4
// Checksum 0xe8ca454b, Offset: 0xc9c5
// Size: 0x1a
function private delayhide()
{
    level endon( #"game_ended" );
    wait 0.05;
    self hide();
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0xe86e5577, Offset: 0xc9e7
// Size: 0x106
function private function_eb10b5fb353fd7a6( delaytime )
{
    level endon( #"game_ended" );
    earthquakeposition = self.origin;
    var_156b609ddcf72f46 = max( 0, delaytime + level.gunshipsettings.var_59bd70f71e98149 );
    hostmigration::waitlongdurationwithpause( var_156b609ddcf72f46 );
    
    foreach ( player in level.players )
    {
        if ( player player::isreallyalive() )
        {
            player earthquakeforplayer( level.gunshipsettings.var_573e81858665c43e, level.gunshipsettings.var_6934dc1897daba2c, earthquakeposition, 30000 );
        }
    }
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0xfab1d35b, Offset: 0xcaf5
// Size: 0x32
function private function_7a281854f4e856c5( delaytime )
{
    level endon( #"game_ended" );
    hostmigration::waitlongdurationwithpause( delaytime );
    killstreak_utility::function_daa9374e3f6779a5( "gunship", "pilot" );
}

// Namespace gunship
// Params 0, eflags: 0x4
// Checksum 0xb77d9df1, Offset: 0xcb2f
// Size: 0x3
function private crashaudio()
{
    waitframe();
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0x1e019cb3, Offset: 0xcb3a
// Size: 0x147
function private removeplane( wasdestroyed )
{
    if ( isdefined( self.flashlight ) )
    {
        self.flashlight delete();
    }
    
    if ( isdefined( self.camera ) )
    {
        self.camera delete();
    }
    
    if ( isdefined( self.leftwingfxent ) )
    {
        self.leftwingfxent delete();
    }
    
    if ( isdefined( self.rightwingfxent ) )
    {
        self.rightwingfxent delete();
    }
    
    if ( isdefined( self.lightfxent ) )
    {
        self.lightfxent delete();
    }
    
    if ( isdefined( self.hellfiretarget ) )
    {
        self.hellfiretarget delete();
    }
    
    if ( isdefined( self.minimapid ) )
    {
        if ( utility::issharedfuncdefined( #"game", #"returnobjectiveid" ) )
        {
            [[ utility::getsharedfunc( #"game", #"returnobjectiveid" ) ]]( self.minimapid );
        }
        
        self.minimapid = undefined;
    }
    
    self.streakinfo.expiredbydeath = istrue( wasdestroyed );
    
    if ( !self.var_ce6835d644d27b88 )
    {
        function_4bef7662b6c2c08a( self.owner, self.streakinfo );
    }
    
    self delete();
}

// Namespace gunship
// Params 1
// Checksum 0xbec8a2b4, Offset: 0xcc89
// Size: 0x10f
function function_7be0e9ca69392745( gunshipintro )
{
    if ( !isdefined( gunshipintro ) )
    {
        return;
    }
    
    if ( isdefined( gunshipintro.var_d511ee197fc9d1c9 ) )
    {
        gunshipintro.var_d511ee197fc9d1c9 delete();
    }
    
    if ( isent( gunshipintro ) )
    {
        if ( !level.gunshipsettings.var_b625d3773a2c5a1b )
        {
            gunshipintro setscriptablepartstate( "clouds_intro", "off", 0 );
            gunshipintro setscriptablepartstate( "bodyFX_intro", "off", 0 );
        }
        
        gunshipintro delete();
        return;
    }
    
    if ( !isdefined( gunshipintro.var_8355961ae50efe3f ) )
    {
        return;
    }
    
    foreach ( animent in gunshipintro.var_8355961ae50efe3f )
    {
        if ( isdefined( animent ) )
        {
            animent delete();
        }
    }
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0x78f4bddb, Offset: 0xcda0
// Size: 0xa7
function private function_567600cd70aa0f85( gunshipintro )
{
    if ( !isdefined( gunshipintro.var_8355961ae50efe3f ) )
    {
        return;
    }
    
    foreach ( animent in gunshipintro.var_8355961ae50efe3f )
    {
        if ( isdefined( animent ) )
        {
            animent hidefromplayer( gunshipintro.var_e6005f2ca4f815d7 );
        }
    }
}

// Namespace gunship
// Params 2, eflags: 0x4
// Checksum 0x686cc7aa, Offset: 0xce4f
// Size: 0x2fb
function private function_59a8405783effe95( gunshipintro, sequence )
{
    self endon( #"disconnect" );
    thirdpersoncam = 0;
    
    /#
        thirdpersoncam = getdvarint( @"hash_f49f4fd233809e37", 0 );
    #/
    
    if ( !isdefined( gunshipintro.var_e6005f2ca4f815d7 ) )
    {
        gunshipintro.var_e6005f2ca4f815d7 = self;
    }
    
    if ( !( isdefined( gunshipintro ) && isdefined( sequence ) ) )
    {
        return;
    }
    
    thread killstreak_utility::function_785239235d790099( "80_instant_noscale", 1 );
    
    if ( sequence == "intro_gunship_exterior" )
    {
        var_9eb9c570e9ba3b51 = gunshipintro.var_8355961ae50efe3f[ "gunship_exterior" ];
        gunshipanimlength = animation::get_scr_animlength( "gunship", sequence );
        var_9eb9c570e9ba3b51 showtoplayer( gunshipintro.var_e6005f2ca4f815d7 );
        var_9eb9c570e9ba3b51 setscriptablepartstate( "clouds_intro", "old", 0 );
        var_9eb9c570e9ba3b51 setscriptablepartstate( "bodyFX_intro", "on", 0 );
        gunshipintro.var_d511ee197fc9d1c9 thread animation::anim_single_solo( var_9eb9c570e9ba3b51, sequence );
        
        if ( !thirdpersoncam )
        {
            gunshipintro.var_e6005f2ca4f815d7 cameralinkto( var_9eb9c570e9ba3b51, "tag_player", 1, 1 );
        }
        
        var_9eb9c570e9ba3b51 thread function_19dc4aaa241db58e( gunshipanimlength, self, sequence );
        var_9eb9c570e9ba3b51 thread function_5304a6718142815d( gunshipanimlength, self, sequence );
        var_9eb9c570e9ba3b51 thread function_1f4c8bda2ae625a2( gunshipanimlength, self );
        wait gunshipanimlength;
        
        if ( !thirdpersoncam )
        {
            gunshipintro.var_e6005f2ca4f815d7 cameraunlink();
        }
    }
    else
    {
        if ( sequence == "intro" )
        {
            var_9eb9c570e9ba3b51 = gunshipintro.var_8355961ae50efe3f[ "gunship_exterior" ];
            var_9eb9c570e9ba3b51 setscriptablepartstate( "clouds_intro", "off", 0 );
            var_9eb9c570e9ba3b51 setscriptablepartstate( "bodyFX_intro", "off", 0 );
        }
        
        if ( isdefined( gunshipintro.var_8355961ae50efe3f ) )
        {
            foreach ( modelindex, animent in gunshipintro.var_8355961ae50efe3f )
            {
                if ( isdefined( animent ) )
                {
                    if ( modelindex == "gunship_exterior" )
                    {
                        continue;
                    }
                    
                    animent showtoplayer( gunshipintro.var_e6005f2ca4f815d7 );
                    
                    if ( modelindex == "gunship_interior" )
                    {
                        continue;
                    }
                    
                    var_ad84d7156e99d8aa = sequence + "_" + modelindex;
                    gunshipintro.var_d511ee197fc9d1c9 thread animation::anim_single_solo( animent, var_ad84d7156e99d8aa );
                    
                    if ( !thirdpersoncam && modelindex == "gunner" )
                    {
                        gunshipintro.var_e6005f2ca4f815d7 cameralinkto( animent, "tag_camera", 1, 1 );
                        gunneranimlength = animation::get_scr_animlength( "gunship", sequence + "_gunner" );
                        animent thread function_5304a6718142815d( gunneranimlength, self, sequence );
                    }
                }
            }
            
            gunshipanimlength = animation::get_scr_animlength( "gunship", sequence + "_gunner" );
            wait gunshipanimlength;
        }
    }
    
    self notify( "finished_gunship_anim_" + sequence );
}

// Namespace gunship
// Params 2, eflags: 0x4
// Checksum 0x7a67f748, Offset: 0xd152
// Size: 0x2ad
function private function_fd5b0b86a0b047b1( probe_name, brush_name )
{
    init_succeed = 1;
    lighting_info = {};
    probe = getent( probe_name, #script_noteworthy );
    
    if ( !isdefined( probe ) )
    {
        /#
            assert( 0, "<dev string:x4b>" );
            self iprintln( "<dev string:x4b>" );
        #/
        
        return;
    }
    
    shadow_brushes = getentarray( brush_name, #targetname );
    
    if ( !isdefined( shadow_brushes ) )
    {
        /#
            assert( 0, "<dev string:x4b>" );
            self iprintln( "<dev string:x4b>" );
        #/
        
        return;
    }
    
    lighting_info.probe = probe;
    lighting_info.shadow_brushes = shadow_brushes;
    var_fb2126a779c39960 = [];
    var_3465effba18485b6 = [];
    var_fb2126a779c39960[ "pos" ] = probe.origin;
    var_fb2126a779c39960[ "rot" ] = probe.angles;
    lighting_info.var_1bce669644d2d203 = var_fb2126a779c39960;
    
    foreach ( index, brush in shadow_brushes )
    {
        brush_t = [];
        brush_t[ "pos" ] = brush.origin;
        brush_t[ "rot" ] = brush.angles;
        var_3465effba18485b6[ index ] = brush_t;
    }
    
    lighting_info.var_c13fe41474e457bd = var_3465effba18485b6;
    
    foreach ( var_2a304e9d2d9189a1 in level.players )
    {
        probe hidefromplayer( var_2a304e9d2d9189a1 );
        probe thread function_419352e33cfb1af9( self );
        
        foreach ( brush in shadow_brushes )
        {
            brush hidefromplayer( var_2a304e9d2d9189a1 );
            brush thread function_419352e33cfb1af9( self );
        }
    }
    
    return lighting_info;
}

// Namespace gunship
// Params 3, eflags: 0x4
// Checksum 0x6c1cf10b, Offset: 0xd408
// Size: 0x134
function private function_848764b697fbcb67( owner, lighting_info, showlighting )
{
    if ( showlighting )
    {
        lighting_info.probe showtoplayer( owner );
        
        foreach ( brush in lighting_info.shadow_brushes )
        {
            brush showtoplayer( owner );
        }
        
        return;
    }
    
    lighting_info.probe hidefromplayer( owner );
    
    foreach ( brush in lighting_info.shadow_brushes )
    {
        brush hidefromplayer( owner );
    }
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0xb7578496, Offset: 0xd544
// Size: 0x44
function private function_846007d5837987b( lighting_info )
{
    if ( !isdefined( lighting_info ) )
    {
        return;
    }
    
    lighting_info.probe linkto( self, "tag_origin", ( 100, 0, 115 ), ( 0, 0, 0 ) );
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0x2b3b9dc0, Offset: 0xd590
// Size: 0xad
function private function_a893f8320e8abec5( lighting_info )
{
    if ( !isdefined( lighting_info ) )
    {
        return;
    }
    
    foreach ( brush in lighting_info.shadow_brushes )
    {
        brush linkto( self, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    }
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0x8c18b698, Offset: 0xd645
// Size: 0x72
function private unlinkprobe( lighting_info )
{
    if ( !isdefined( lighting_info ) )
    {
        return;
    }
    
    lighting_info.probe unlink();
    lighting_info.probe.origin = lighting_info.var_1bce669644d2d203[ "pos" ];
    lighting_info.probe.angles = lighting_info.var_1bce669644d2d203[ "rot" ];
}

// Namespace gunship
// Params 0, eflags: 0x4
// Checksum 0xf4fe267c, Offset: 0xd6bf
// Size: 0xa0
function private function_3253e5cb864786e8()
{
    if ( getdvarint( @"hash_e6afce2cf5cf7515" ) == 0 )
    {
        capture_model = getentarray( "ks_gunship_light_only", #script_noteworthy );
        
        foreach ( m in capture_model )
        {
            m hide();
        }
    }
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0xdea891d3, Offset: 0xd767
// Size: 0xcd
function private unlinkbrushes( lighting_info )
{
    if ( !isdefined( lighting_info ) )
    {
        return;
    }
    
    foreach ( index, brush in lighting_info.shadow_brushes )
    {
        brush unlink();
        brush.origin = lighting_info.var_c13fe41474e457bd[ index ][ "pos" ];
        brush.angles = lighting_info.var_c13fe41474e457bd[ index ][ "rot" ];
    }
}

// Namespace gunship
// Params 5, eflags: 0x4
// Checksum 0xc3b9cf08, Offset: 0xd83c
// Size: 0x143
function private function_5d16cd690851e4dc( player, scriptablepart, state, visionset_name, time )
{
    thirdpersoncam = undefined;
    
    /#
        thirdpersoncam = getdvarint( @"hash_f49f4fd233809e37", 0 );
        
        if ( thirdpersoncam )
        {
            return;
        }
    #/
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( state == "on" )
    {
        self.gunshipinterior function_848764b697fbcb67( player, self.var_422165848f230436, 1 );
        self.gunshipinterior function_846007d5837987b( self.var_422165848f230436 );
        self.gunshipinterior function_a893f8320e8abec5( self.var_422165848f230436 );
        self.gunshipinterior setscriptablepartstate( scriptablepart, "on" );
        player visionsetnakedforplayer( visionset_name, time );
        return;
    }
    
    if ( state == "off" )
    {
        self.gunshipinterior function_848764b697fbcb67( player, self.var_422165848f230436, 0 );
        unlinkprobe( self.var_422165848f230436 );
        unlinkbrushes( self.var_422165848f230436 );
        self.gunshipinterior setscriptablepartstate( scriptablepart, "off" );
        player visionsetnakedforplayer( "", time );
    }
}

/#

    // Namespace gunship
    // Params 3
    // Checksum 0x3ffc4c31, Offset: 0xd987
    // Size: 0x68, Type: dev
    function function_c9045a46693dccfe( gunshipintro, animent, var_ad84d7156e99d8aa )
    {
        animent endon( #"death" );
        self notifyonplayercommand( "<dev string:xb3>", "<dev string:xc3>" );
        
        while ( true )
        {
            self waittill( #"hash_de716badcf5fe540" );
            gunshipintro.var_d511ee197fc9d1c9 thread animation::anim_single_solo( animent, var_ad84d7156e99d8aa );
        }
    }

#/

// Namespace gunship
// Params 4, eflags: 0x4
// Checksum 0xd686c8a0, Offset: 0xd9f7
// Size: 0x214
function private handlemissiledetection( player, missileteam, missiletarget, fxtagoverride )
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( !isdefined( missiletarget ) )
        {
            break;
        }
        
        center = missiletarget getpointinbounds( 0, 0, 0 );
        curdist = distance( self.origin, center );
        
        if ( curdist < 4000 && missiletarget.flaresreservecount > 0 )
        {
            if ( utility::issharedfuncdefined( #"flares", #"reducereserves" ) )
            {
                [[ utility::getsharedfunc( #"flares", #"reducereserves" ) ]]( missiletarget );
            }
            
            missiletarget thread function_7924d9967f3a63c3( fxtagoverride );
            missiletarget killstreak_utility::playkillstreaktacomdialog( self.streakinfo, "gunship" + "_flares", #"flares", 1, undefined, "pilot" );
            newtarget = undefined;
            
            if ( utility::issharedfuncdefined( #"flares", #"deploy" ) )
            {
                newtarget = missiletarget [[ utility::getsharedfunc( #"flares", #"deploy" ) ]]();
            }
            
            if ( utility::issharedfuncdefined( #"killstreak", #"hash_b5eddc2dc7204c48" ) )
            {
                missiletarget [[ utility::getsharedfunc( #"killstreak", #"hash_b5eddc2dc7204c48" ) ]]( player );
            }
            
            self missile_settargetent( newtarget );
            self notify( #"missile_pairedwithflare" );
            return;
        }
        else if ( curdist < 300 && missiletarget.flaresreservecount <= 0 )
        {
            missiletarget thread function_fbd55c37c1407924();
            missiledamage = weapongetdamagemax( self.weapon_name, 0 );
            
            if ( isdefined( self.owner ) )
            {
                missiletarget dodamage( missiledamage, self.owner.origin, self.owner, self, "MOD_EXPLOSIVE", self.weapon_name );
            }
            
            self delete();
        }
        
        waitframe();
    }
}

// Namespace gunship
// Params 0, eflags: 0x4
// Checksum 0x31b89fb3, Offset: 0xdc13
// Size: 0x74
function private function_fbd55c37c1407924()
{
    if ( !isdefined( self.missileexplcounter ) )
    {
        self.missileexplcounter = 0;
    }
    
    self.missileexplcounter++;
    
    if ( self.missileexplcounter > 4 )
    {
        self.missileexplcounter = 0;
    }
    
    self setscriptablepartstate( "fake_missile_expl_" + self.missileexplcounter, "on", 0 );
    wait 2;
    self setscriptablepartstate( "fake_missile_expl_" + self.missileexplcounter, "off", 0 );
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0x9e19267c, Offset: 0xdc8f
// Size: 0x64
function private function_7924d9967f3a63c3( fxtagoverride )
{
    flarestag = "tag_origin";
    
    if ( isdefined( fxtagoverride ) )
    {
        flarestag = fxtagoverride;
    }
    
    playfxontag( utility::getfx( "gunship_flares" ), self, flarestag );
    flaresgroup = self.flaresreservecount + 1;
    self setscriptablepartstate( "fake_flares_" + flaresgroup, "on", 0 );
}

// Namespace gunship
// Params 0, eflags: 0x4
// Checksum 0xd2dd955e, Offset: 0xdcfb
// Size: 0xc, Type: bool
function private isusinggunship()
{
    return isdefined( self.usinggunship );
}

// Namespace gunship
// Params 0, eflags: 0x4
// Checksum 0x8a62d42e, Offset: 0xdd10
// Size: 0x49
function private function_9f2d57938d3c3109()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    wait 0.05;
    gunshipforward = anglestoforward( self.angles );
    self setscriptablepartstate( "lights", "on" );
}

// Namespace gunship
// Params 0, eflags: 0x4
// Checksum 0x8a823f87, Offset: 0xdd61
// Size: 0x1f3
function private function_93a4ea4df3da9d39()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    wait 0.05;
    bundle = level.streakglobals.streakbundles[ "gunship" ];
    var_3fcbef5d8a13140e = self gettagorigin( level.gunshipsettings.var_d3b98880b1fa4c8e, 1 );
    
    if ( isdefined( var_3fcbef5d8a13140e ) )
    {
        self.leftwingfxent = spawn( "script_model", var_3fcbef5d8a13140e );
        self.leftwingfxent setmodel( level.gunshipsettings.var_1b10f71d7a437fb6 );
        self.leftwingfxent.angles = self.angles;
        self.leftwingfxent setotherent( self.owner );
        self.leftwingfxent linkto( self, level.gunshipsettings.var_d3b98880b1fa4c8e, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    }
    
    var_75ace1b29e67463 = self gettagorigin( level.gunshipsettings.var_d0e262d42566e01, 1 );
    
    if ( isdefined( var_75ace1b29e67463 ) )
    {
        self.rightwingfxent = spawn( "script_model", var_75ace1b29e67463 );
        self.rightwingfxent setmodel( level.gunshipsettings.var_1b10f71d7a437fb6 );
        self.rightwingfxent.angles = self.angles;
        self.rightwingfxent setotherent( self.owner );
        self.rightwingfxent linkto( self, level.gunshipsettings.var_d0e262d42566e01, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    }
    
    self setscriptablepartstate( "contrails", "on" );
}

/#

    // Namespace gunship
    // Params 1, eflags: 0x4
    // Checksum 0x84232ccd, Offset: 0xdf5c
    // Size: 0x57, Type: dev
    function private function_cb07cfb6e271eda5( wingfxent )
    {
        self endon( #"death" );
        level endon( #"game_ended" );
        
        while ( true )
        {
            sphere( wingfxent.origin, 100, ( 1, 0, 0 ), 0, 1 );
            wait 0.05;
        }
    }

#/

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0x14a5f1ee, Offset: 0xdfbb
// Size: 0x213
function private watchtargets( gunner )
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    level endon( #"game_ended" );
    gunner endon( #"disconnect" );
    hostmigration::waitlongdurationwithpause( 5 );
    
    while ( true )
    {
        visibletargets = [];
        
        foreach ( player in level.players )
        {
            if ( !isdefined( player ) || !player player::isreallyalive() )
            {
                continue;
            }
            
            if ( self.owner worldpointinreticle_circle( player.origin, 80, 100 ) )
            {
                if ( level.teambased && player.team == self.team )
                {
                    continue;
                }
                
                if ( player == self.owner )
                {
                    continue;
                }
                
                if ( !killstreak_utility::streakcanseetarget( self.origin, player gettagorigin( "j_spineupper" ), self ) )
                {
                    continue;
                }
                
                if ( isdefined( player.perks[ "specialty_noscopeoutline" ] ) )
                {
                    continue;
                }
                
                visibletargets = getnearbytargets( player );
                break;
            }
            
            wait 0.05;
        }
        
        if ( visibletargets.size > 0 && visibletargets.size < 2 )
        {
            gunner killstreak_utility::playkillstreaktacomdialog( self.streakinfo, "gunship" + "_spotted_single_target", #"spotted_single", undefined, undefined, "pilot" );
        }
        else if ( visibletargets.size >= 2 )
        {
            gunner killstreak_utility::playkillstreaktacomdialog( self.streakinfo, "gunship" + "_spotted_single_multi", #"spotted_multi", undefined, undefined, "pilot" );
        }
        
        wait randomintrange( 5, 15 );
    }
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0xdf5f0fb5, Offset: 0xe1d6
// Size: 0xf1
function private getnearbytargets( maintarget )
{
    var_917c95ee81d4af40 = utility::playersinsphere( maintarget.origin, 300 );
    nearbytargets = [];
    
    foreach ( player in var_917c95ee81d4af40 )
    {
        if ( level.teambased && player.team != maintarget.team )
        {
            continue;
        }
        
        if ( !level.teambased && player == self.owner )
        {
            continue;
        }
        
        nearbytargets[ nearbytargets.size ] = player;
    }
    
    return nearbytargets;
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0x370363a8, Offset: 0xe2d0
// Size: 0x140
function private function_e0793e6ee5c08cbb( gunner )
{
    self endon( #"death" );
    self endon( #"leaving" );
    self endon( #"crashing" );
    level endon( #"game_ended" );
    gunner endon( #"disconnect" );
    self.var_def1d41fdfcdaa7 = 0;
    childthread watchkills();
    childthread function_bb9eb9e6f01758e3();
    
    while ( true )
    {
        if ( self.var_def1d41fdfcdaa7 != 0 )
        {
            wait 2;
            
            if ( self.var_def1d41fdfcdaa7 >= 3 )
            {
                if ( utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
                {
                    gunner thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( #"gunship_triple_kill" );
                }
            }
            
            if ( self.var_def1d41fdfcdaa7 >= 1 )
            {
                killstreak_utility::playkillstreaktacomdialog( self.streakinfo, "gunship" + "_hit_target", #"hit", undefined, undefined, "pilot" );
            }
            else
            {
                killstreak_utility::playkillstreaktacomdialog( self.streakinfo, "gunship" + "_miss_target", #"miss", undefined, undefined, "pilot" );
            }
            
            self.var_def1d41fdfcdaa7 = 0;
            wait 1;
        }
        
        waitframe();
    }
}

// Namespace gunship
// Params 0, eflags: 0x4
// Checksum 0x85b80f33, Offset: 0xe418
// Size: 0x45
function private watchkills()
{
    while ( true )
    {
        self.owner waittill( #"update_rapid_kill_buffered", recentkills, var_95795539e2a8343 );
        
        if ( isdefined( recentkills ) )
        {
            self.var_def1d41fdfcdaa7++;
        }
    }
}

// Namespace gunship
// Params 0, eflags: 0x4
// Checksum 0xa96fa31e, Offset: 0xe465
// Size: 0x45
function private function_bb9eb9e6f01758e3()
{
    while ( true )
    {
        self.owner waittill( #"update_rapid_agent_kill_buffered", recentkills, weaponname );
        
        if ( isdefined( recentkills ) )
        {
            self.var_def1d41fdfcdaa7++;
        }
    }
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0xcfdc1e4b, Offset: 0xe4b2
// Size: 0x61
function private iskillstreakweapon( weaponname )
{
    return ( isdefined( weaponname ) && ( weaponname == level.gunshipsettings.gunship_missile_weapon || weaponname == level.gunshipsettings.var_8969fe590c36e582 || weaponname == level.gunshipsettings.var_3edfb285d2efa861 ), 1, 0 );
}

// Namespace gunship
// Params 0, eflags: 0x4
// Checksum 0x5610df3a, Offset: 0xe51c
// Size: 0x3a
function private islargemap()
{
    largemap = game_utility::islargemap();
    
    /#
        crashtype = getdvarint( @"scr_gunship_crash_type", 0 );
        
        if ( crashtype )
        {
            largemap = 1;
        }
    #/
    
    return largemap;
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0xc65389d1, Offset: 0xe55f
// Size: 0xe9
function private allowstances( boolean )
{
    if ( !boolean )
    {
        self.gunship_disabledstances = [];
        currentstance = self getstance();
        
        switch ( currentstance )
        {
            case #"hash_c6775c88e38f7803":
                self.gunship_disabledstances = [ "crouch", "prone" ];
                break;
            case #"hash_3fed0cbd303639eb":
                self.gunship_disabledstances = [ "stand", "prone" ];
                break;
            case #"hash_d91940431ed7c605":
                self.gunship_disabledstances = [ "stand", "crouch" ];
                break;
        }
        
        val::group_register( "gunshipStance", self.gunship_disabledstances );
        val::group_set( "gunshipStance", 0 );
        return;
    }
    
    val::group_reset( "gunshipStance" );
}

// Namespace gunship
// Params 0, eflags: 0x4
// Checksum 0x2d2712b4, Offset: 0xe650
// Size: 0x38
function private function_c9d578fd190af200()
{
    self endon( #"death" );
    level waittill( #"game_ended" );
    level.gunshiprigs = arrayremove( level.gunshiprigs, self );
    self delete();
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0x69b5dc31, Offset: 0xe690
// Size: 0x48
function private function_4186d441fa667f7c( ent )
{
    self endon( #"death" );
    ent utility::waittill_any( "leaving", "death" );
    level.gunshiprigs = arrayremove( level.gunshiprigs, self );
    self delete();
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0x67e5b937, Offset: 0xe6e0
// Size: 0x82
function private watchownerlookat( owner )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"leaving" );
    owner endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        targetpos = getownerlookatpos( owner );
        
        if ( isdefined( targetpos ) )
        {
            self.hellfiretarget.origin = targetpos;
        }
        
        waitframe();
    }
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0xfe5299fc, Offset: 0xe76a
// Size: 0x160
function private function_15b893825838499f( owner )
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"leaving" );
    owner endon( #"disconnect" );
    level endon( #"game_ended" );
    gunshipbasefov = 65;
    lerptime = 0.2;
    currentfov = gunshipbasefov;
    var_410a4bdf33c3b252 = undefined;
    timeheld = 0;
    playedvision = 0;
    owner setclientomnvar( "ui_killstreak_zoom_fov", currentfov );
    
    while ( true )
    {
        if ( !isdefined( self.var_23b42a4928a6efbb ) )
        {
            waitframe();
            continue;
        }
        
        if ( owner adsbuttonpressed() )
        {
            timeheld += 0.05;
            
            if ( timeheld >= lerptime )
            {
                timeheld = lerptime;
            }
            
            if ( !playedvision )
            {
                owner killstreak_shared::function_8bd91ec764c0390b( "killstreak_ads_shutter" );
                playedvision = 1;
            }
        }
        else if ( timeheld > 0 )
        {
            timeheld -= 0.05;
            
            if ( timeheld <= 0 )
            {
                timeheld = 0;
            }
            
            if ( playedvision )
            {
                playedvision = 0;
            }
        }
        
        if ( timeheld >= 0 )
        {
            var_410a4bdf33c3b252 = self.var_23b42a4928a6efbb;
            timeperc = timeheld / lerptime * 100;
            currentfov = int( timeperc * ( var_410a4bdf33c3b252 - gunshipbasefov ) / 100 + gunshipbasefov );
        }
        
        owner setclientomnvar( "ui_killstreak_zoom_fov", currentfov );
        wait 0.05;
    }
}

// Namespace gunship
// Params 1
// Checksum 0xb533dfb6, Offset: 0xe8d2
// Size: 0xc9
function getownerlookatpos( owner )
{
    content = [ "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicleclip" ];
    contentoverride = physics_createcontents( content );
    starttrace = owner getvieworigin();
    endtrace = starttrace + anglestoforward( owner getplayerangles() ) * 50000;
    ignoreents = owner killstreak_utility::playerkillstreakgetownerlookatignoreents();
    trace = trace::ray_trace( starttrace, endtrace, ignoreents, contentoverride );
    endpos = undefined;
    
    if ( isdefined( trace[ "hittype" ] ) && trace[ "hittype" ] != "hittype_none" )
    {
        endpos = trace[ "position" ];
    }
    
    return endpos;
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0xf7662d52, Offset: 0xe9a4
// Size: 0xb6
function private function_18746fa344d836f1( targetweapon )
{
    self endon( #"death" );
    self notify( #"hash_802e0b419e61c683" );
    self endon( #"hash_4ad689cb9df85616" );
    
    while ( true )
    {
        currentplayerweapon = self.owner getcurrentweapon();
        
        if ( isdefined( currentplayerweapon ) && currentplayerweapon.basename == targetweapon )
        {
            break;
        }
        
        waitframe();
    }
    
    self.var_23b42a4928a6efbb = self.owner playergetzoomfov();
    
    if ( !level.gunshipsettings.var_15b893825838499f )
    {
        self.owner setclientomnvar( "ui_killstreak_zoom_fov", self.var_23b42a4928a6efbb );
    }
}

// Namespace gunship
// Params 0, eflags: 0x4
// Checksum 0x7eba5882, Offset: 0xea62
// Size: 0x260
function private applyoutlines()
{
    self endon( #"death" );
    self endon( #"crashing" );
    self endon( #"leaving" );
    self.owner endon( #"disconnect" );
    level endon( #"game_ended" );
    outlineasset = undefined;
    
    if ( !isdefined( self.owner.outlineents ) )
    {
        self.owner.outlineents = [];
    }
    
    while ( true )
    {
        allentities = getentarray();
        
        foreach ( ent in allentities )
        {
            if ( ent == self )
            {
                continue;
            }
            
            entnum = ent getentitynumber();
            
            if ( !isdefined( ent.streakname ) && !isdefined( ent vehicle::get_ref() ) && !isplayer( ent ) )
            {
                continue;
            }
            
            if ( ent.streakname && ent.streakname == "vtol_warship" )
            {
                continue;
            }
            
            if ( isdefined( self.owner.outlineents[ entnum ] ) )
            {
                if ( ent.outlines.size > 0 )
                {
                    continue;
                }
            }
            
            if ( level.teambased && ent.team == self.team )
            {
                if ( level.gunshipsettings.var_7d98054b482fa45c )
                {
                    outlineasset = "cer_gunship_killstreak_friendly";
                }
                else
                {
                    continue;
                }
            }
            else
            {
                outlineasset = "cer_gunship_killstreak_enemy";
            }
            
            if ( utility::issharedfuncdefined( #"outline", #"outlineenableforplayer" ) )
            {
                self.owner.outlineents[ entnum ] = { #outlineent:ent, #outlineid:[[ utility::getsharedfunc( #"outline", #"outlineenableforplayer" ) ]]( ent, self.owner, outlineasset, "killstreak_personal" ) };
            }
        }
        
        wait 0.1;
    }
}

// Namespace gunship
// Params 0, eflags: 0x4
// Checksum 0xca29bf6b, Offset: 0xecca
// Size: 0x113
function private function_6cf65f0b258d941d()
{
    gunshipowner = self.owner;
    
    if ( !isdefined( gunshipowner.outlineents ) )
    {
        return;
    }
    
    foreach ( outlineinfo in gunshipowner.outlineents )
    {
        if ( !isdefined( outlineinfo.outlineent ) || outlineinfo.outlineent == self )
        {
            continue;
        }
        
        if ( utility::issharedfuncdefined( #"outline", #"outlinedisable" ) )
        {
            [[ utility::getsharedfunc( #"outline", #"outlinedisable" ) ]]( outlineinfo.outlineid, outlineinfo.outlineent );
        }
    }
    
    gunshipowner.outlineents = undefined;
}

// Namespace gunship
// Params 3, eflags: 0x4
// Checksum 0x4af0782e, Offset: 0xede5
// Size: 0x122
function private function_6bd125d9c1119895( gunship, gunner, weaponbasename )
{
    gunship endon( #"death" );
    gunship endon( #"leaving" );
    gunship endon( #"crashing" );
    gunner endon( #"disconnect" );
    self waittill( #"death" );
    bundle = level.streakglobals.streakbundles[ "gunship" ];
    
    if ( weaponbasename == level.gunshipsettings.var_3edfb285d2efa861 )
    {
        return;
    }
    
    var_a17ecb78937dcead = bundle.var_d8f5d2fd737152a0;
    
    if ( weaponbasename == level.gunshipsettings.gunship_missile_weapon )
    {
        var_a17ecb78937dcead = bundle.var_5d769cc8c879f535;
        earthquake( level.gunshipsettings.var_281a6e7f3d0c6719, level.gunshipsettings.var_50c6d899745b6485, gunship.origin, 1000 );
    }
    
    if ( isdefined( var_a17ecb78937dcead ) )
    {
        gunner killstreak_shared::function_8bd91ec764c0390b( var_a17ecb78937dcead );
    }
}

// Namespace gunship
// Params 1
// Checksum 0xeb02c056, Offset: 0xef0f
// Size: 0x21
function empapplied( data )
{
    if ( isdefined( self ) )
    {
        crash( self.owner );
    }
}

// Namespace gunship
// Params 1
// Checksum 0xe4248bad, Offset: 0xef38
// Size: 0x2b7
function dronegunempapplied( data )
{
    self endon( #"death" );
    self notify( #"hash_e2ffa6b148ef5f18" );
    self endon( #"hash_e2ffa6b148ef5f18" );
    self.owner endon( #"detach_gunship_intro" );
    self.owner endon( #"returning_killstreak_player" );
    thread function_c40c841409083979();
    
    if ( !isdefined( self.var_fd125a9888e9226e ) && self.flaresreservecount > 0 )
    {
        self.var_fd125a9888e9226e = gettime();
        
        if ( utility::issharedfuncdefined( #"flares", #"reducereserves" ) )
        {
            [[ utility::getsharedfunc( #"flares", #"reducereserves" ) ]]( self );
        }
        
        thread function_7924d9967f3a63c3();
        
        if ( utility::issharedfuncdefined( #"flares", #"deploy" ) )
        {
            self [[ utility::getsharedfunc( #"flares", #"deploy" ) ]]();
        }
        
        if ( utility::issharedfuncdefined( #"killstreak", #"hash_b5eddc2dc7204c48" ) )
        {
            self [[ utility::getsharedfunc( #"killstreak", #"hash_b5eddc2dc7204c48" ) ]]( data.attacker );
        }
        
        if ( utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
        {
            data.attacker thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( "emped_killstreak" );
        }
        
        return;
    }
    
    if ( self.flaresreservecount > 0 && self.var_fd125a9888e9226e <= gettime() - 10000 )
    {
        self.var_fd125a9888e9226e = gettime();
        
        if ( utility::issharedfuncdefined( #"flares", #"reducereserves" ) )
        {
            [[ utility::getsharedfunc( #"flares", #"reducereserves" ) ]]( self );
        }
        
        thread function_7924d9967f3a63c3();
        
        if ( utility::issharedfuncdefined( #"flares", #"deploy" ) )
        {
            self [[ utility::getsharedfunc( #"flares", #"deploy" ) ]]();
        }
        
        if ( utility::issharedfuncdefined( #"killstreak", #"hash_b5eddc2dc7204c48" ) )
        {
            self [[ utility::getsharedfunc( #"killstreak", #"hash_b5eddc2dc7204c48" ) ]]( data.attacker );
        }
        
        if ( utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
        {
            data.attacker thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( "emped_killstreak" );
        }
    }
}

// Namespace gunship
// Params 0, eflags: 0x4
// Checksum 0x1b5dcf74, Offset: 0xf1f7
// Size: 0x153
function private function_c40c841409083979()
{
    self.owner killstreak_utility::function_d546aaa588f088c3( self.streakname, "off" );
    result = utility::waittill_any_ents_or_timeout_return( 0.1, self.owner, "detach_gunship_intro", self.owner, "returning_killstreak_player", self, "death" );
    
    if ( result != "timeout" || !isalive( self ) )
    {
        return;
    }
    
    self.owner killstreak_utility::function_d546aaa588f088c3( self.streakname, "on" );
    result = utility::waittill_any_ents_or_timeout_return( 0.05, self.owner, "detach_gunship_intro", self.owner, "returning_killstreak_player", self, "death" );
    
    if ( result != "timeout" || !isalive( self ) )
    {
        return;
    }
    
    self.owner killstreak_utility::function_d546aaa588f088c3( self.streakname, "off" );
    result = utility::waittill_any_ents_or_timeout_return( 0.25, self.owner, "detach_gunship_intro", self.owner, "returning_killstreak_player", self, "death" );
    
    if ( result != "timeout" || !isalive( self ) )
    {
        return;
    }
    
    self.owner killstreak_utility::function_d546aaa588f088c3( self.streakname, "on" );
}

// Namespace gunship
// Params 1, eflags: 0x4
// Checksum 0x4f4875b7, Offset: 0xf352
// Size: 0x5f
function private function_5c576910469d4fde( params )
{
    if ( params.objweapon.var_5e3a1c87edc1edd5 == #"gunship_bomb" )
    {
        bundle = level.streakglobals.streakbundles[ "gunship" ];
        return bundle.var_39c08509e3fb7d26;
    }
}

/#

    // Namespace gunship
    // Params 2
    // Checksum 0xeef5efd4, Offset: 0xf3ba
    // Size: 0xc0, Type: dev
    function watchbomb( bombparent, bomb )
    {
        self endon( #"death" );
        self.owner endon( #"hash_ce2b7155ad7bb99d" );
        self.owner endon( #"hash_748e61fd3945540f" );
        
        while ( isdefined( bombparent ) && isdefined( bomb ) )
        {
            sphere( self.origin, 250, ( 1, 0, 0 ), 0, 1 );
            sphere( bombparent.origin, 250, ( 1, 0, 0 ), 0, 1 );
            sphere( bomb.origin, 250, ( 1, 0, 0 ), 0, 1 );
            waitframe();
        }
    }

    // Namespace gunship
    // Params 1
    // Checksum 0x5df59d0e, Offset: 0xf482
    // Size: 0xfa, Type: dev
    function watchplanedistance( var_f0574b4cc0f1975a )
    {
        self endon( #"death" );
        self.owner endon( #"hash_ce2b7155ad7bb99d" );
        self.owner endon( #"hash_748e61fd3945540f" );
        
        while ( isdefined( var_f0574b4cc0f1975a.origin ) )
        {
            trace = trace::ray_trace( self.origin, self.origin - ( 0, 0, 40000 ), self );
            line( self.origin, trace[ "<dev string:xcc>" ], ( 1, 1, 1 ), 1, 0, 1 );
            sphere( var_f0574b4cc0f1975a.origin, 50, ( 1, 1, 0 ), 0, 1 );
            self.owner iprintlnbold( "<dev string:xd5>" + distance( self.origin, trace[ "<dev string:xcc>" ] ) );
            waitframe();
        }
    }

    // Namespace gunship
    // Params 2
    // Checksum 0x40e18152, Offset: 0xf584
    // Size: 0x11c, Type: dev
    function function_ec72695e596cbde7( tagname, showaxis )
    {
        self endon( #"death" );
        
        while ( true )
        {
            debuglocation = self.origin;
            
            if ( isdefined( tagname ) )
            {
                debuglocation = self gettagorigin( tagname );
            }
            
            sphere( debuglocation, 100, ( 1, 1, 1 ), 0, 1 );
            
            if ( showaxis )
            {
                testforward = anglestoforward( self.angles );
                testright = anglestoright( self.angles );
                testup = anglestoup( self.angles );
                line( debuglocation, debuglocation + testforward * 1000, ( 1, 0, 0 ), 1, 0, 1 );
                line( debuglocation, debuglocation + testright * 1000, ( 0, 1, 0 ), 1, 0, 1 );
                line( debuglocation, debuglocation + testup * 1000, ( 0, 0, 1 ), 1, 0, 1 );
            }
            
            wait 0.05;
        }
    }

    // Namespace gunship
    // Params 0
    // Checksum 0x319df034, Offset: 0xf6a8
    // Size: 0x18d, Type: dev
    function function_8b30c5afebb93084()
    {
        self endon( #"death" );
        self endon( #"leaving" );
        self endon( #"crashing" );
        self.owner notifyonplayercommand( "<dev string:xe0>", "<dev string:xfc>" );
        self.owner notifyonplayercommand( "<dev string:x106>", "<dev string:x123>" );
        self.owner notifyonplayercommand( "<dev string:x106>", "<dev string:x12d>" );
        
        if ( isdefined( self.flashlight ) )
        {
            self.flashlight notify( #"flashlight_on" );
        }
        
        weaponstocycle = [ level.gunshipsettings.gunship_missile_weapon, level.gunshipsettings.var_8969fe590c36e582, level.gunshipsettings.var_3edfb285d2efa861 ];
        currentdebugweaponindex = 0;
        currentdebugweapon = weaponstocycle[ 0 ];
        
        while ( true )
        {
            result = self.owner utility::waittill_any_return( "<dev string:xe0>", "<dev string:x106>" );
            
            if ( !isdefined( result ) )
            {
                waitframe();
                continue;
            }
            
            if ( result == "<dev string:xe0>" )
            {
                currentdebugweaponindex++;
                
                if ( currentdebugweaponindex > 2 )
                {
                    currentdebugweaponindex = 0;
                }
                
                currentdebugweapon = weaponstocycle[ currentdebugweaponindex ];
                self.owner iprintlnbold( "<dev string:x138>" + currentdebugweapon );
                continue;
            }
            
            shotgoal = function_5a6017fda6e81e6d( self.owner );
            thread function_c6d240b541484f8a( shotgoal, currentdebugweapon );
        }
    }

    // Namespace gunship
    // Params 1
    // Checksum 0x9a9eb809, Offset: 0xf83d
    // Size: 0x16, Type: dev
    function getfiretime( weapon )
    {
        return weaponfiretime( weapon );
    }

    // Namespace gunship
    // Params 1
    // Checksum 0xf19aaf16, Offset: 0xf85b
    // Size: 0xa4, Type: dev
    function function_5a6017fda6e81e6d( owner )
    {
        content = [ "<dev string:x153>", "<dev string:x16c>", "<dev string:x188>" ];
        contentoverride = physics_createcontents( content );
        starttrace = owner getvieworigin();
        endtrace = starttrace + anglestoforward( owner getplayerangles() ) * 50000;
        trace = trace::ray_trace( starttrace, endtrace, level.characters, contentoverride );
        endpos = trace[ "<dev string:xcc>" ];
        return endpos;
    }

    // Namespace gunship
    // Params 2
    // Checksum 0xd867911, Offset: 0xf907
    // Size: 0x198, Type: dev
    function function_c6d240b541484f8a( shotgoal, currentdebugweapon )
    {
        self endon( #"death" );
        self endon( #"leaving" );
        self endon( #"crashing" );
        self.owner endon( #"hash_ce2b7155ad7bb99d" );
        self.owner endon( #"hash_748e61fd3945540f" );
        
        while ( true )
        {
            sphere( shotgoal, 10, ( 1, 1, 0 ), 0, 60 );
            self.owner iprintlnbold( "<dev string:x1a0>" + currentdebugweapon + "<dev string:x1a8>" + shotgoal + "<dev string:x1ad>" + getweaponexplosionradius( currentdebugweapon ) );
            ammoleft = weaponmaxammo( currentdebugweapon );
            thread function_3bf288e5e1795d8c( shotgoal );
            
            while ( ammoleft > 0 )
            {
                var_5a969db3aa4eb797 = undefined;
                
                if ( utility::issharedfuncdefined( #"gunship", #"getbombingpoint" ) )
                {
                    var_5a969db3aa4eb797 = [[ utility::getsharedfunc( #"gunship", #"getbombingpoint" ) ]]( shotgoal, 100 );
                }
                
                projectile = weapon_utility::_magicbullet( makeweapon( currentdebugweapon ), self.origin, var_5a969db3aa4eb797, self.owner );
                ammoleft--;
                
                if ( ammoleft == 0 )
                {
                    wait 1;
                    reloadtimer = level.weaponreloadtime[ currentdebugweapon ];
                    
                    while ( reloadtimer > 0 )
                    {
                        self.owner iprintlnbold( "<dev string:x1bf>" + currentdebugweapon );
                        reloadtimer--;
                        wait 1;
                    }
                }
                
                wait getfiretime( currentdebugweapon );
            }
        }
    }

    // Namespace gunship
    // Params 1
    // Checksum 0xe2744b2a, Offset: 0xfaa7
    // Size: 0xb7, Type: dev
    function function_3bf288e5e1795d8c( shotgoal )
    {
        self endon( #"death" );
        self endon( #"leaving" );
        self endon( #"crashing" );
        self.owner endon( #"hash_ce2b7155ad7bb99d" );
        self.owner endon( #"hash_748e61fd3945540f" );
        
        while ( true )
        {
            if ( isdefined( self.flashlight ) )
            {
                self.flashlight.angles = vectortoangles( shotgoal - self.origin );
            }
            
            line( self.origin, shotgoal, ( 1, 1, 1 ), 1, 0, 1 );
            waitframe();
        }
    }

    // Namespace gunship
    // Params 0
    // Checksum 0x43e4cd27, Offset: 0xfb66
    // Size: 0x5c, Type: dev
    function function_e92fa65ab38c2da9()
    {
        self endon( #"death" );
        wait 10;
        data = damage_utility::packdamagedata( self.owner, self, 1, self.currentprimaryweapon, "<dev string:x1ca>", self );
        dronegunempapplied( data );
        wait 10;
        dronegunempapplied( data );
    }

    // Namespace gunship
    // Params 2, eflags: 0x4
    // Checksum 0x182e9cfe, Offset: 0xfbca
    // Size: 0x10e, Type: dev
    function private _watch_dvars( gunship, owner )
    {
        setdvar( @"scr_debug_gunship_damage_state", 0 );
        currdamagestate = 0;
        
        while ( true )
        {
            if ( !isdefined( gunship ) )
            {
                break;
            }
            
            newdamagestate = getdvarint( @"scr_debug_gunship_damage_state", 0 );
            
            if ( newdamagestate != currdamagestate )
            {
                if ( newdamagestate == 0 )
                {
                    gunship function_efe9c99b0cf41141();
                }
                else if ( newdamagestate == 1 )
                {
                    gunship function_2b92632daaa6b4c0();
                }
                else if ( newdamagestate == 2 )
                {
                    gunship function_12540d67807e8391();
                }
                else if ( newdamagestate == 3 )
                {
                    gunship heavydamagestate();
                }
                else if ( newdamagestate == 4 )
                {
                    gunship function_eff4fc84e85bc7da();
                }
                
                currdamagestate = newdamagestate;
            }
            
            var_4deacce2f2df929f = getdvarint( @"hash_ecd4b3e4e39d1b72", 0 );
            
            if ( var_4deacce2f2df929f )
            {
                owner notify( #"deployDebugFlare" );
                wait 0.1;
                setdvar( @"hash_ecd4b3e4e39d1b72", 0 );
            }
            
            wait 0.1;
        }
    }

#/
