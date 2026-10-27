// scripts\mp\mp_gameskill.gsc  (hash_53da3333b83b3527.gscc) (size: 10553 Bytes / 0x2939 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x948d2c48 (2492279880)
// size ...... 10553 (0x2939)
// includes .. 2   (offset: 0x22b1)
// strings ... 44  (offset: 0x22c1)
// dev strs .. 0   (offset: 0x2939)
// exports ... 16  (offset: 0x1c15)
// cseg ...... 0x434 + 0x17e1 (0x1c15)
// imports ... 31  (offset: 0x1e95)
// animtree1 . 0   (offset: 0x2939)
// animtree2 . 0   (offset: 0x2939)
#using scripts\common\gameskill;
#using scripts\common\utility;

#namespace mp_gameskill;

// Namespace mp_gameskill
// Params 0
// Checksum 0x65584aa9, Offset: 0x452
// Size: 0x9
function init_gameskill()
{
    setskill();
}

// Namespace mp_gameskill
// Params 0
// Checksum 0x6d4845, Offset: 0x463
// Size: 0x1a
function set_gameskill()
{
    level.gameskill = getdvarint( @"scr_mp_difficulty", 1 );
}

// Namespace mp_gameskill
// Params 0
// Checksum 0x1040040c, Offset: 0x485
// Size: 0xb
function get_gameskill()
{
    return level.gameskill;
}

// Namespace mp_gameskill
// Params 1
// Checksum 0x78ea0146, Offset: 0x499
// Size: 0xc9f
function setskill( reset )
{
    if ( !reset )
    {
        if ( isdefined( level.gameskill ) )
        {
            return;
        }
        
        level.difficultytype[ 0 ] = "easy";
        level.difficultytype[ 1 ] = "normal";
        level.difficultytype[ 2 ] = "hardened";
        level.difficultytype[ 3 ] = "veteran";
        level.difficultystring[ "easy" ] = &"gameskill_easy";
        level.difficultystring[ "normal" ] = &"gameskill_normal";
        level.difficultystring[ "hardened" ] = &"gameskill_hardened";
        level.difficultystring[ "veteran" ] = &"gameskill_veteran";
    }
    
    anim.run_accuracy = 0.5;
    anim.walk_accuracy = 0.8;
    level.mg42badplace_mintime = 8;
    level.mg42badplace_maxtime = 16;
    level.difficultysettings[ "playerGrenadeBaseTime" ][ "easy" ] = 40000;
    level.difficultysettings[ "playerGrenadeBaseTime" ][ "normal" ] = 35000;
    level.difficultysettings[ "playerGrenadeBaseTime" ][ "hardened" ] = 25000;
    level.difficultysettings[ "playerGrenadeBaseTime" ][ "veteran" ] = 25000;
    level.difficultysettings[ "playerGrenadeRangeTime" ][ "easy" ] = 20000;
    level.difficultysettings[ "playerGrenadeRangeTime" ][ "normal" ] = 15000;
    level.difficultysettings[ "playerGrenadeRangeTime" ][ "hardened" ] = 10000;
    level.difficultysettings[ "playerGrenadeRangeTime" ][ "veteran" ] = 10000;
    level.difficultysettings[ "playerDoubleGrenadeTime" ][ "easy" ] = 3600000;
    level.difficultysettings[ "playerDoubleGrenadeTime" ][ "normal" ] = 150000;
    level.difficultysettings[ "playerDoubleGrenadeTime" ][ "hardened" ] = 90000;
    level.difficultysettings[ "playerDoubleGrenadeTime" ][ "veteran" ] = 45000;
    level.difficultysettings[ "double_grenades_allowed" ][ "easy" ] = 0;
    level.difficultysettings[ "double_grenades_allowed" ][ "normal" ] = 1;
    level.difficultysettings[ "double_grenades_allowed" ][ "hardened" ] = 1;
    level.difficultysettings[ "double_grenades_allowed" ][ "veteran" ] = 1;
    level.difficultysettings[ "threatbias" ][ "easy" ] = 100;
    level.difficultysettings[ "threatbias" ][ "normal" ] = 150;
    level.difficultysettings[ "threatbias" ][ "hardened" ] = 200;
    level.difficultysettings[ "threatbias" ][ "veteran" ] = 400;
    level.difficultysettings[ "base_enemy_accuracy" ][ "easy" ] = 0.9;
    level.difficultysettings[ "base_enemy_accuracy" ][ "normal" ] = 1;
    level.difficultysettings[ "base_enemy_accuracy" ][ "hardened" ] = 1.15;
    level.difficultysettings[ "base_enemy_accuracy" ][ "veteran" ] = 1.5;
    level.difficultysettings[ "accuracyDistScale" ][ "easy" ] = 1;
    level.difficultysettings[ "accuracyDistScale" ][ "normal" ] = 1;
    level.difficultysettings[ "accuracyDistScale" ][ "hardened" ] = 0.8;
    level.difficultysettings[ "accuracyDistScale" ][ "veteran" ] = 0.5;
    level.difficultysettings[ "min_sniper_burst_delay_time" ][ "easy" ] = 3;
    level.difficultysettings[ "min_sniper_burst_delay_time" ][ "normal" ] = 2;
    level.difficultysettings[ "min_sniper_burst_delay_time" ][ "hardened" ] = 1.5;
    level.difficultysettings[ "min_sniper_burst_delay_time" ][ "veteran" ] = 0.75;
    level.difficultysettings[ "sniper_converge_scale" ][ "easy" ] = 1.3;
    level.difficultysettings[ "sniper_converge_scale" ][ "normal" ] = 1.1;
    level.difficultysettings[ "sniper_converge_scale" ][ "hardened" ] = 0.9;
    level.difficultysettings[ "sniper_converge_scale" ][ "veteran" ] = 0.45;
    level.difficultysettings[ "sniperAccuDiffScale" ][ "easy" ] = 1;
    level.difficultysettings[ "sniperAccuDiffScale" ][ "normal" ] = 1.6;
    level.difficultysettings[ "sniperAccuDiffScale" ][ "hardened" ] = 1.6;
    level.difficultysettings[ "sniperAccuDiffScale" ][ "veteran" ] = 2.5;
    level.difficultysettings[ "max_sniper_burst_delay_time" ][ "easy" ] = 4;
    level.difficultysettings[ "max_sniper_burst_delay_time" ][ "normal" ] = 3;
    level.difficultysettings[ "max_sniper_burst_delay_time" ][ "hardened" ] = 2;
    level.difficultysettings[ "max_sniper_burst_delay_time" ][ "veteran" ] = 1.1;
    level.difficultysettings[ "pain_test" ][ "easy" ] = &gameskill::always_pain;
    level.difficultysettings[ "pain_test" ][ "normal" ] = &gameskill::always_pain;
    level.difficultysettings[ "pain_test" ][ "hardened" ] = &gameskill::pain_protection;
    level.difficultysettings[ "pain_test" ][ "veteran" ] = &gameskill::pain_protection;
    level.difficultysettings[ "missTimeConstant" ][ "easy" ] = 1;
    level.difficultysettings[ "missTimeConstant" ][ "normal" ] = 0.05;
    level.difficultysettings[ "missTimeConstant" ][ "hardened" ] = 0.03;
    level.difficultysettings[ "missTimeConstant" ][ "veteran" ] = 0.02;
    level.difficultysettings[ "missTimeDistanceFactor" ][ "easy" ] = 0.0008;
    level.difficultysettings[ "missTimeDistanceFactor" ][ "normal" ] = 0.0001;
    level.difficultysettings[ "missTimeDistanceFactor" ][ "hardened" ] = 5e-05;
    level.difficultysettings[ "missTimeDistanceFactor" ][ "veteran" ] = 3e-05;
    level.difficultysettings[ "player_maxFlashBangTime" ][ "easy" ] = 6;
    level.difficultysettings[ "player_maxFlashBangTime" ][ "normal" ] = 8;
    level.difficultysettings[ "player_maxFlashBangTime" ][ "hardened" ] = 9;
    level.difficultysettings[ "player_maxFlashBangTime" ][ "veteran" ] = 10;
    level.difficultysettings[ "invulTime_onDamageMin" ][ "easy" ] = 0.35;
    level.difficultysettings[ "invulTime_onDamageMin" ][ "normal" ] = 0.3;
    level.difficultysettings[ "invulTime_onDamageMin" ][ "hardened" ] = 0.2;
    level.difficultysettings[ "invulTime_onDamageMin" ][ "veteran" ] = 0.2;
    level.difficultysettings[ "invulTime_onDamageMax" ][ "easy" ] = 0.35;
    level.difficultysettings[ "invulTime_onDamageMax" ][ "normal" ] = 0.3;
    level.difficultysettings[ "invulTime_onDamageMax" ][ "hardened" ] = 0.2;
    level.difficultysettings[ "invulTime_onDamageMax" ][ "veteran" ] = 0.2;
    level.difficultysettings[ "invulTime_onDamage" ][ "easy" ] = 0.35;
    level.difficultysettings[ "invulTime_onDamage" ][ "normal" ] = 0.3;
    level.difficultysettings[ "invulTime_onDamage" ][ "hardened" ] = 0.2;
    level.difficultysettings[ "invulTime_onDamage" ][ "veteran" ] = 0.2;
    level.difficultysettings[ "invulTime_deathShieldDuration" ][ "easy" ] = 2;
    level.difficultysettings[ "invulTime_deathShieldDuration" ][ "normal" ] = 1;
    level.difficultysettings[ "invulTime_deathShieldDuration" ][ "hardened" ] = 0.5;
    level.difficultysettings[ "invulTime_deathShieldDuration" ][ "veteran" ] = 0.25;
    level.difficultysettings[ "player_deathsDoorDuration" ][ "easy" ] = 4;
    level.difficultysettings[ "player_deathsDoorDuration" ][ "normal" ] = 4;
    level.difficultysettings[ "player_deathsDoorDuration" ][ "hardened" ] = 4;
    level.difficultysettings[ "player_deathsDoorDuration" ][ "veteran" ] = 4;
    level.difficultysettings[ "player_healthRegenDelayMin" ][ "easy" ] = 2.1;
    level.difficultysettings[ "player_healthRegenDelayMin" ][ "normal" ] = 1.85;
    level.difficultysettings[ "player_healthRegenDelayMin" ][ "hardened" ] = 2.7;
    level.difficultysettings[ "player_healthRegenDelayMin" ][ "veteran" ] = 3.25;
    level.difficultysettings[ "player_healthRegenDelayMax" ][ "easy" ] = 4.35;
    level.difficultysettings[ "player_healthRegenDelayMax" ][ "normal" ] = 5;
    level.difficultysettings[ "player_healthRegenDelayMax" ][ "hardened" ] = 6;
    level.difficultysettings[ "player_healthRegenDelayMax" ][ "veteran" ] = 7.05;
    level.difficultysettings[ "player_healthRegenDelay" ][ "easy" ] = 2.5;
    level.difficultysettings[ "player_healthRegenDelay" ][ "normal" ] = 3;
    level.difficultysettings[ "player_healthRegenDelay" ][ "hardened" ] = 4;
    level.difficultysettings[ "player_healthRegenDelay" ][ "veteran" ] = 5.05;
    level.difficultysettings[ "player_healthRegenRateMin" ][ "easy" ] = 1.25;
    level.difficultysettings[ "player_healthRegenRateMin" ][ "normal" ] = 0.65;
    level.difficultysettings[ "player_healthRegenRateMin" ][ "hardened" ] = 0.25;
    level.difficultysettings[ "player_healthRegenRateMin" ][ "veteran" ] = 0.05;
    level.difficultysettings[ "player_healthRegenRateMax" ][ "easy" ] = 18.85;
    level.difficultysettings[ "player_healthRegenRateMax" ][ "normal" ] = 14.65;
    level.difficultysettings[ "player_healthRegenRateMax" ][ "hardened" ] = 10.55;
    level.difficultysettings[ "player_healthRegenRateMax" ][ "veteran" ] = 9.2;
    level.difficultysettings[ "player_healthRegenRate" ][ "easy" ] = 40;
    level.difficultysettings[ "player_healthRegenRate" ][ "normal" ] = 40;
    level.difficultysettings[ "player_healthRegenRate" ][ "hardened" ] = 40;
    level.difficultysettings[ "player_healthRegenRate" ][ "veteran" ] = 40;
    level.difficultysettings[ "player_health" ][ "easy" ] = 355;
    level.difficultysettings[ "player_health" ][ "normal" ] = 180;
    level.difficultysettings[ "player_health" ][ "hardened" ] = 140;
    level.difficultysettings[ "player_health" ][ "veteran" ] = 80;
    level.difficultysettings[ "player_diedRecentlyCooldown" ][ "easy" ] = 70;
    level.difficultysettings[ "player_diedRecentlyCooldown" ][ "normal" ] = 30;
    level.difficultysettings[ "player_diedRecentlyCooldown" ][ "hardened" ] = 0;
    level.difficultysettings[ "player_diedRecentlyCooldown" ][ "veteran" ] = 0;
    level.lastplayersighted = 0;
    level.playermeleedamagemultiplier_dvar = 0.8;
    init_mgturretsettings();
    updategameskill();
    updatealldifficulty();
}

// Namespace mp_gameskill
// Params 0
// Checksum 0xdc66cfec, Offset: 0x1140
// Size: 0x9
function updatealldifficulty()
{
    setglobaldifficulty();
}

// Namespace mp_gameskill
// Params 0
// Checksum 0x723844f3, Offset: 0x1151
// Size: 0x296
function init_mgturretsettings()
{
    level.mgturretsettings[ "easy" ][ "convergenceTime" ] = 2.5;
    level.mgturretsettings[ "easy" ][ "suppressionTime" ] = 3;
    level.mgturretsettings[ "easy" ][ "accuracy" ] = 0.38;
    level.mgturretsettings[ "easy" ][ "aiSpread" ] = 2;
    level.mgturretsettings[ "easy" ][ "playerSpread" ] = 0.5;
    level.mgturretsettings[ "medium" ][ "convergenceTime" ] = 1.5;
    level.mgturretsettings[ "medium" ][ "suppressionTime" ] = 3;
    level.mgturretsettings[ "medium" ][ "accuracy" ] = 0.38;
    level.mgturretsettings[ "medium" ][ "aiSpread" ] = 2;
    level.mgturretsettings[ "medium" ][ "playerSpread" ] = 0.5;
    level.mgturretsettings[ "hard" ][ "convergenceTime" ] = 0.8;
    level.mgturretsettings[ "hard" ][ "suppressionTime" ] = 3;
    level.mgturretsettings[ "hard" ][ "accuracy" ] = 0.38;
    level.mgturretsettings[ "hard" ][ "aiSpread" ] = 2;
    level.mgturretsettings[ "hard" ][ "playerSpread" ] = 0.5;
    level.mgturretsettings[ "veteran" ][ "convergenceTime" ] = 0.8;
    level.mgturretsettings[ "veteran" ][ "suppressionTime" ] = 3;
    level.mgturretsettings[ "veteran" ][ "accuracy" ] = 0.38;
    level.mgturretsettings[ "veteran" ][ "aiSpread" ] = 2;
    level.mgturretsettings[ "veteran" ][ "playerSpread" ] = 0.5;
    level.mgturretsettings[ "fu" ][ "convergenceTime" ] = 0.4;
    level.mgturretsettings[ "fu" ][ "suppressionTime" ] = 3;
    level.mgturretsettings[ "fu" ][ "accuracy" ] = 0.38;
    level.mgturretsettings[ "fu" ][ "aiSpread" ] = 2;
    level.mgturretsettings[ "fu" ][ "playerSpread" ] = 0.5;
}

// Namespace mp_gameskill
// Params 0
// Checksum 0x38c1c2d9, Offset: 0x13ef
// Size: 0x28
function setdifficulty()
{
    assert( isplayer( self ) );
    assert( isdefined( self.gameskill ) );
    set_difficulty_from_locked_settings();
}

// Namespace mp_gameskill
// Params 0
// Checksum 0x4693fe50, Offset: 0x141f
// Size: 0x6a
function setglobaldifficulty()
{
    current_skill = gameskill::get_skill_from_index( level.gameskill );
    anim.pain_test = gameskill::get_difficultysetting_global( "pain_test" );
    function_c69c568e54ac55bb( gameskill::get_difficultysetting_global( "min_sniper_burst_delay_time" ) );
    function_f7af0b7931559a0d( gameskill::get_difficultysetting_global( "max_sniper_burst_delay_time" ) );
    setsaveddvar( @"ai_accuracydistscale", gameskill::get_difficultysetting_global( "accuracyDistScale" ) );
}

// Namespace mp_gameskill
// Params 0
// Checksum 0x1e789b95, Offset: 0x1491
// Size: 0x3b
function updategameskill()
{
    if ( isdefined( level.forcedgameskill ) )
    {
        level.gameskill = level.forcedgameskill;
    }
    else
    {
        set_gameskill();
    }
    
    setglobaldifficulty();
    return level.gameskill;
}

// Namespace mp_gameskill
// Params 1
// Checksum 0x200b072c, Offset: 0x14d5
// Size: 0x416
function apply_difficulty_settings( current_frac )
{
    self.gs = spawnstruct();
    function_476d961d179c81cf( gameskill::get_difficultysetting_frac( "player_diedRecentlyCooldown", current_frac ) );
    self.gs.maxflashbangtime = gameskill::get_difficultysetting_frac( "player_maxFlashBangTime", current_frac );
    self.gs.invultime_ondamagemin = gameskill::get_difficultysetting_frac( "invulTime_onDamageMin", current_frac );
    self.gs.invultime_ondamagemax = gameskill::get_difficultysetting_frac( "invulTime_onDamageMax", current_frac );
    self.gs.invultime_deathshieldduration = gameskill::get_difficultysetting_frac( "invulTime_deathShieldDuration", current_frac );
    self.gs.invultime_ondamage = gameskill::get_difficultysetting_frac( "invulTime_onDamage", current_frac );
    self.gs.deathsdoorduration = gameskill::get_difficultysetting_frac( "player_deathsDoorDuration", current_frac );
    self.gs.scripteddamagemultiplier = 1;
    self.gs.scripteddeathshielddurationscale = 2;
    self.gs.healthregendelaymin = gameskill::get_difficultysetting_frac( "player_healthRegenDelayMin", current_frac );
    self.gs.healthregendelaymax = gameskill::get_difficultysetting_frac( "player_healthRegenDelayMax", current_frac );
    self.gs.healthregendelay = gameskill::get_difficultysetting_frac( "player_healthRegenDelay", current_frac );
    self.gs.healthregenratemin = gameskill::get_difficultysetting_frac( "player_healthRegenRateMin", current_frac );
    self.gs.healthregenratemax = gameskill::get_difficultysetting_frac( "player_healthRegenRateMax", current_frac );
    self.gs.healthregendelay = gameskill::get_difficultysetting_frac( "player_healthRegenDelay", current_frac );
    self.gs.healthregenrate = gameskill::get_difficultysetting_frac( "player_healthRegenRate", current_frac );
    self.gs.player_attacker_accuracy = gameskill::get_difficultysetting_frac( "base_enemy_accuracy", current_frac );
    update_player_attacker_accuracy();
    self.gs.playergrenadebasetime = int( gameskill::get_difficultysetting_frac( "playerGrenadeBaseTime", current_frac ) );
    self.gs.playergrenaderangetime = int( gameskill::get_difficultysetting_frac( "playerGrenadeRangeTime", current_frac ) );
    self.gs.playerdoublegrenadetime = int( gameskill::get_difficultysetting_frac( "playerDoubleGrenadeTime", current_frac ) );
    function_d9677314b2b32d34( gameskill::get_difficultysetting_frac( "min_sniper_burst_delay_time", current_frac ) );
    function_8d78cae9473cb6a6( gameskill::get_difficultysetting_frac( "max_sniper_burst_delay_time", current_frac ) );
    var_95b479184aa06dd0 = 1;
    
    if ( level.gameskill == 0 )
    {
        var_95b479184aa06dd0 = 2;
    }
    
    function_67b5bf41b5022de7( gameskill::get_difficultysetting_frac( "sniperAccuDiffScale", current_frac ), var_95b479184aa06dd0, 1 );
    self.gs.damagemultiplierhealth = self.maxhealth / gameskill::get_difficultysetting_frac( "player_health", current_frac );
    
    if ( utility::playerarmorenabled() )
    {
        self.gs.armorratiohealthregenthreshold = gameskill::get_difficultysetting_frac( "player_armorRatioHealthRegenThreshold", current_frac );
        self.gs.armordamagetohealthratiomin = gameskill::get_difficultysetting_frac( "player_armorDamageToHealthRatioMin", current_frac );
        self.gs.armordamagetohealthratiomax = gameskill::get_difficultysetting_frac( "player_armorDamageToHealthRatioMax", current_frac );
        self.gs.damagemultiplierarmor = self.armor.maxamount / gameskill::get_difficultysetting_frac( "player_armor", current_frac );
        self.damagemultiplier = self.gs.damagemultiplierarmor;
    }
    else
    {
        self.damagemultiplier = self.gs.damagemultiplierhealth;
    }
    
    self.threatbias = int( gameskill::get_difficultysetting_frac( "threatbias", current_frac ) );
}

// Namespace mp_gameskill
// Params 0
// Checksum 0xdaac7c2, Offset: 0x18f3
// Size: 0x14
function set_difficulty_from_locked_settings()
{
    apply_difficulty_settings( 1 );
    gameskill::apply_difficulty_settings_shared( 1 );
}

// Namespace mp_gameskill
// Params 0
// Checksum 0xea98ac34, Offset: 0x190f
// Size: 0xc
function resetskill()
{
    waittillframeend();
    setskill( 1 );
}

// Namespace mp_gameskill
// Params 1
// Checksum 0x12270679, Offset: 0x1923
// Size: 0x26f
function wave_difficulty_update( difficulty )
{
    if ( getdvarint( @"hash_94ebdb2e64164d03", -1 ) != -1 )
    {
        difficulty = getdvarint( @"hash_94ebdb2e64164d03", -1 );
    }
    
    setting = level.difficultytype[ difficulty ];
    
    foreach ( player in level.players )
    {
        player.gs.player_attacker_accuracy = level.difficultysettings[ "base_enemy_accuracy" ][ setting ];
        player.attackeraccuracy = player.gs.player_attacker_accuracy;
        player.gs.playergrenadebasetime = int( level.difficultysettings[ "playerGrenadeBaseTime" ][ setting ] );
        player.gs.playergrenaderangetime = int( level.difficultysettings[ "playerGrenadeRangeTime" ][ setting ] );
        player.gs.playerdoublegrenadetime = int( level.difficultysettings[ "playerDoubleGrenadeTime" ][ setting ] );
        player.gameskillmisstimeconstant = level.difficultysettings[ "missTimeConstant" ][ setting ];
        player.gameskillmisstimedistancefactor = level.difficultysettings[ "missTimeDistanceFactor" ][ setting ];
    }
    
    function_32b1d2ad61212ad6( level.difficultysettings[ "double_grenades_allowed" ][ setting ] );
    anim.pain_test = level.difficultysettings[ "pain_test" ][ setting ];
    function_c69c568e54ac55bb( level.difficultysettings[ "min_sniper_burst_delay_time" ][ setting ] );
    function_f7af0b7931559a0d( level.difficultysettings[ "max_sniper_burst_delay_time" ][ setting ] );
    function_d9677314b2b32d34( level.difficultysettings[ "min_sniper_burst_delay_time" ][ setting ] );
    function_8d78cae9473cb6a6( level.difficultysettings[ "max_sniper_burst_delay_time" ][ setting ] );
    setsaveddvar( @"ai_accuracydistscale", level.difficultysettings[ "accuracyDistScale" ][ setting ] );
}

// Namespace mp_gameskill
// Params 0
// Checksum 0x2e13c253, Offset: 0x1b9a
// Size: 0x67
function update_player_attacker_accuracy()
{
    if ( !isdefined( self.baseignorerandombulletdamage ) )
    {
        self.baseignorerandombulletdamage = 0;
    }
    
    if ( !isdefined( self.scriptedattackeraccuracy ) )
    {
        self.scriptedattackeraccuracy = 1;
    }
    
    self.ignorerandombulletdamage = self.baseignorerandombulletdamage;
    self.attackeraccuracy = self.gs.player_attacker_accuracy * self.scriptedattackeraccuracy;
}

// Namespace mp_gameskill
// Params 0
// Checksum 0xaad94571, Offset: 0x1c09
// Size: 0xb
function get_player_gameskill()
{
    return level.gameskill;
}

