// scripts\mp\common\equipment\battlerage.gsc  (hash_05ae77e5c120fd54.gscc) (size: 13153 Bytes / 0x3361 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xda73626f (3664994927)
// size ...... 13153 (0x3361)
// includes .. 18  (offset: 0x311d)
// strings ... 27  (offset: 0x31ad)
// dev strs .. 1   (offset: 0x3355)
// exports ... 51  (offset: 0x1b79)
// cseg ...... 0x238 + 0x1941 (0x1b79)
// imports ... 110 (offset: 0x2371)
// animtree1 . 0   (offset: 0x3361)
// animtree2 . 0   (offset: 0x3361)
#using script_74b851b7aa1ef32d;
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\equipment;
#using scripts\mp\gamelogic;
#using scripts\mp\playerhealth;
#using scripts\mp\supers;
#using scripts\mp\talking_gun;

#namespace battlerage;

// Namespace battlerage
// Params 0, eflags: 0x1
// Checksum 0xb33b3bf2, Offset: 0x256
// Size: 0x120
function autoexec battlerage_init()
{
    utility::flag_wait( "supers_initialized" );
    supers_mp::function_48aaa60b2ce7b8a1( "super_battlerage", undefined, undefined, &battlerage_beginuse, &function_eeeeed58090ed956, undefined, undefined, undefined, undefined, undefined );
    utility::registersharedfunc( #"battlerage", #"suspendvisionsets", &function_5b4e4bcbeb7dfa07 );
    utility::registersharedfunc( #"battlerage", #"resumevisionsets", &function_9d0194c336e5da3c );
    utility::registersharedfunc( #"battlerage", #"hash_7dff8b8d09af9e50", &battlerage_onkill );
    utility::registersharedfunc( #"battlerage", #"beginuse", &battlerage_beginuse );
    utility::registersharedfunc( #"battlerage", #"hash_180f842b74797065", &function_2e2c7c8247e191f4 );
    equipment_mp::registercallback( "equip_battlerage", "onFired", &function_122c968e6c2f1404 );
    equipment_mp::registercallback( "equip_battlerage", "onTake", &function_949d230d9d5d97aa );
    callback::add( #"battlerage_on_player_damaged", &function_bd161ebde68dbeeb );
    utility::registersharedfunc( #"battlerage", #"hash_87e0ce2b2de1b457", &function_19efaee6fff21bf0 );
}

// Namespace battlerage
// Params 2
// Checksum 0xc8b8b97, Offset: 0x37e
// Size: 0xa0, Type: bool
function battlerage_beginuse( battleragetype, var_fa82fbddc7f00c6b )
{
    self endon( #"disconnect" );
    
    if ( !isdefined( battleragetype ) )
    {
        battleragetype = 0;
    }
    
    if ( self.battlerageactive )
    {
        battlerage_interrupt();
    }
    
    function_c800fd63679f9b33();
    thread battlerage_beginsuper( battleragetype, var_fa82fbddc7f00c6b );
    function_68e6ef5d62d1932a( 1 );
    
    if ( battleragetype == 2 )
    {
        thread function_2e1765f76a79f684();
        thread battlerage_watchdeath( battleragetype, var_fa82fbddc7f00c6b );
    }
    else if ( battleragetype == 4 )
    {
        thread battlerage_watchdeath( battleragetype, var_fa82fbddc7f00c6b );
        thread function_4efed612dfe4a011( var_fa82fbddc7f00c6b );
    }
    
    talking_gun::talkinggun_event( self, #"self_apply" );
    return true;
}

// Namespace battlerage
// Params 3
// Checksum 0x7ef957a0, Offset: 0x427
// Size: 0xd5, Type: bool
function function_122c968e6c2f1404( equipmentref, slot, objweapon )
{
    var_e10352703d59ed28 = self.battlerageactive && self.battleragetype == 1;
    var_9fb91ade156f5b01 = self.battlerageactive && self.battleragetype != 1;
    
    if ( var_9fb91ade156f5b01 )
    {
        battlerage_interrupt();
    }
    
    function_c800fd63679f9b33();
    thread function_8f27078a3e911b0e();
    
    if ( var_e10352703d59ed28 )
    {
        defaultduration = getdvarfloat( @"scr_battlerage_default_duration", 6 ) * 1000;
        self.battlerage_endtime = gettime() + defaultduration;
    }
    else
    {
        thread function_65a7656a63fc0baa();
        thread function_e0d35e2a70f7d7fb();
        thread function_73a77b9efa618c8f();
    }
    
    function_68e6ef5d62d1932a( 1 );
    return true;
}

// Namespace battlerage
// Params 1, eflags: 0x4
// Checksum 0x90553c63, Offset: 0x505
// Size: 0x5c
function private function_68e6ef5d62d1932a( binit )
{
    if ( binit )
    {
        self.var_1df4cb162da5b972 = &function_a505cdfba75c83c6;
        self.var_feac7068b038689e = &function_f8a0fd73622e2ee2;
        playerhealth::function_bdfdee3e2bcb10d8( &function_3913721fc81d6e67 );
        return;
    }
    
    self.var_1df4cb162da5b972 = undefined;
    self.var_feac7068b038689e = undefined;
    playerhealth::function_bb4ad93e7c8b503( &function_3913721fc81d6e67 );
}

// Namespace battlerage
// Params 0, eflags: 0x4
// Checksum 0xabc94297, Offset: 0x569
// Size: 0x34
function private function_c800fd63679f9b33()
{
    self.var_634f9f77f9f0a718 = undefined;
    self.battlerageactive = undefined;
    self.var_afb32715efda7852 = undefined;
    self.battleragetype = undefined;
    self.var_7253af70d06e06a = undefined;
}

// Namespace battlerage
// Params 2
// Checksum 0xca3976fe, Offset: 0x5a5
// Size: 0x16b
function battlerage_beginsuper( battleragetype, var_fa82fbddc7f00c6b )
{
    self endon( #"disconnect" );
    
    if ( battleragetype != 2 && battleragetype != 4 )
    {
        superinfo = supers_mp::getcurrentsuper();
        superinfo.usepercent = 0;
    }
    
    self notify( #"battleRageStart" );
    self.battlerageactive = 1;
    self.battleragetype = battleragetype;
    self.var_7253af70d06e06a = var_fa82fbddc7f00c6b;
    self.superkills = 0;
    namespace_5f4bb62dbf67ff87::doonactionscoreevent( 1, "battleRageUsed" );
    
    if ( getdvarint( @"hash_5ecbc2e485434bb5", 0 ) )
    {
        playerhealth::forcehealthregen( self );
    }
    
    gamelogic_mp::sethasdonecombat( self, 1 );
    thread battlerage_watchgameend( battleragetype, var_fa82fbddc7f00c6b );
    
    if ( getdvarint( @"hash_8edd6dd73c1d8ae4", 1 ) )
    {
        thread function_e7fe18c98eb91c9c();
    }
    
    var_6c7bdcee9e091717 = battleragetype == 3 || battleragetype == 4 ? 0.05 : 0.2;
    childthread battlerage_visionsetspainsurge( 0.5, var_6c7bdcee9e091717 );
    regendelay = getdvarfloat( @"hash_f7ec6896361f0e48", 0 );
    playerhealth::function_fd91e6d94cab77e7( #"battlerage_beginsuper", regendelay );
    challenges::function_a0936b0e5b4550f3( "super_battlerage", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"use" ) );
    battlerage_giveperks();
}

// Namespace battlerage
// Params 0, eflags: 0x4
// Checksum 0x9bce2237, Offset: 0x718
// Size: 0xf2
function private function_8f27078a3e911b0e()
{
    self notify( #"battleRageStart" );
    self.battlerageactive = 1;
    self.battleragetype = 1;
    self.var_7253af70d06e06a = undefined;
    self.var_32817ca41f80f8aa = 0;
    namespace_5f4bb62dbf67ff87::doonactionscoreevent( 0, "battleRageUsed" );
    
    if ( getdvarint( @"hash_5ecbc2e485434bb5", 0 ) )
    {
        playerhealth::forcehealthregen( self );
    }
    
    gamelogic_mp::sethasdonecombat( self, 1 );
    thread function_d360a74205ba3a5e();
    
    if ( getdvarint( @"hash_8edd6dd73c1d8ae4", 1 ) )
    {
        thread function_e7fe18c98eb91c9c();
    }
    
    thread battlerage_visionsetspainsurge( 0.5, 0.2 );
    regendelay = getdvarfloat( @"hash_f7ec6896361f0e48", 0 );
    playerhealth::function_fd91e6d94cab77e7( #"battlerage_beginsuper", regendelay );
    challenges::function_3d7a169dbae062fb( "equip_battlerage", self, undefined, ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"use" ) );
    battlerage_giveperks();
}

// Namespace battlerage
// Params 1
// Checksum 0xdb4ebceb, Offset: 0x812
// Size: 0x4c
function function_f73ea867311dfe58( var_63d10af87acc2b1a )
{
    self notify( #"battlerage_visionsetspainsurge" );
    
    if ( !var_63d10af87acc2b1a )
    {
        self setscriptablepartstate( "battleRageVfx", "off", 0 );
    }
    
    if ( !self.var_1f363107fbac2ca )
    {
        self visionsetnakedforplayer( "", 0.5 );
    }
}

// Namespace battlerage
// Params 0
// Checksum 0x78e824bc, Offset: 0x866
// Size: 0x1e
function function_2e2c7c8247e191f4()
{
    var_8155a4f10dac622f = getdvarint( @"hash_25f7326c9fb11c5b", 0 );
    return var_8155a4f10dac622f;
}

// Namespace battlerage
// Params 2
// Checksum 0xfbd8ffdc, Offset: 0x88d
// Size: 0x95
function battlerage_onkill( attacker, victim )
{
    var_da7932e22db79808 = isdefined( victim ) && isplayer( attacker ) && attacker != victim;
    
    if ( isdefined( attacker ) && isdefined( victim ) && !var_da7932e22db79808 )
    {
        return;
    }
    
    function_d6bf8a75f4114824();
    self.superkills++;
    
    if ( getdvarint( @"hash_fa795fa5ac66dd8c", 1 ) )
    {
        self notify( #"force_regeneration" );
    }
    
    if ( self.battlerageactive )
    {
        thread points::doscoreevent( #"super_battlerage_extend" );
    }
}

// Namespace battlerage
// Params 0, eflags: 0x4
// Checksum 0x1ed5e33d, Offset: 0x92a
// Size: 0x114
function private function_d6bf8a75f4114824()
{
    if ( !isdefined( self.var_634f9f77f9f0a718 ) )
    {
        self.var_634f9f77f9f0a718 = 0;
    }
    
    var_d943b991cdc2bf21 = getdvarfloat( @"hash_7e8c0274f6a1d8ac", 0.01 );
    var_97538ebee05f1cef = getdvarfloat( @"hash_b9c50a6287359eb0", 10 );
    
    if ( var_d943b991cdc2bf21 <= 0 )
    {
        return;
    }
    
    var_5994842eea64448e = self.var_634f9f77f9f0a718 + var_d943b991cdc2bf21;
    var_9224097075ad172d = var_97538ebee05f1cef <= 0;
    var_8e3bed3b73edb8fc = var_5994842eea64448e < var_97538ebee05f1cef;
    
    if ( var_9224097075ad172d || var_8e3bed3b73edb8fc )
    {
        self.var_634f9f77f9f0a718 += var_d943b991cdc2bf21;
        supers_mp::function_55f1ba3202014e0b( var_d943b991cdc2bf21 );
    }
    else
    {
        var_255baa54152e9223 = var_97538ebee05f1cef - self.var_634f9f77f9f0a718;
        var_255baa54152e9223 = max( var_255baa54152e9223, 0 );
        
        if ( var_255baa54152e9223 <= 0 )
        {
            return;
        }
        
        self.var_634f9f77f9f0a718 += var_255baa54152e9223;
        supers_mp::function_55f1ba3202014e0b( var_255baa54152e9223 );
    }
    
    assert( self.var_634f9f77f9f0a718 <= var_97538ebee05f1cef || var_9224097075ad172d );
}

// Namespace battlerage
// Params 0, eflags: 0x4
// Checksum 0x703a9731, Offset: 0xa46
// Size: 0x68
function private function_b2a07619756b1568()
{
    overhealperc = getdvarint( @"hash_e2b1912f2da8b4b5", 0.2 );
    var_b9569622dddfa871 = overhealperc > 0;
    var_5ff433ba24c3edd7 = getdvarint( @"hash_a5dd59d7c6441104", 0 );
    
    if ( var_5ff433ba24c3edd7 <= 0 )
    {
        return;
    }
    
    if ( var_b9569622dddfa871 )
    {
        function_5cfeaff55bb4378c( var_5ff433ba24c3edd7 );
        return;
    }
    
    function_2cba5a0839837895( var_5ff433ba24c3edd7 );
}

// Namespace battlerage
// Params 1, eflags: 0x4
// Checksum 0x7b24f84b, Offset: 0xab6
// Size: 0x88
function private function_5cfeaff55bb4378c( incomingheal )
{
    basemaxhealth = getmatchrulesdata( "commonOption", "maxHealth" );
    var_2c2f676d156e87d4 = getdvarfloat( @"hash_e2b1912f2da8b4b5", 0.2 );
    var_842ed535b26bf6bd = basemaxhealth + basemaxhealth * var_2c2f676d156e87d4;
    
    if ( self.health + incomingheal > basemaxhealth )
    {
        self.maxhealth = var_842ed535b26bf6bd;
    }
    
    function_2cba5a0839837895( incomingheal );
    
    if ( function_2d78351667fd8a3d() )
    {
        thread battlerage_monitoroverheal();
    }
}

// Namespace battlerage
// Params 1, eflags: 0x4
// Checksum 0x572445b9, Offset: 0xb46
// Size: 0x43
function private function_2cba5a0839837895( incomingheal )
{
    self.health = int( min( self.maxhealth, self.health + incomingheal ) );
    function_18baf8431118039c( 0.5, 0.5 );
}

// Namespace battlerage
// Params 0, eflags: 0x4
// Checksum 0x5522b703, Offset: 0xb91
// Size: 0x28, Type: bool
function private function_2d78351667fd8a3d()
{
    basemaxhealth = getmatchrulesdata( "commonOption", "maxHealth" );
    return self.maxhealth > basemaxhealth;
}

// Namespace battlerage
// Params 0, eflags: 0x4
// Checksum 0x47321084, Offset: 0xbc2
// Size: 0x52
function private battlerage_monitoroverheal()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"battlerageend" );
    self notify( #"battlerage_monitoroverheal" );
    self endon( #"battlerage_monitoroverheal" );
    
    while ( function_2d78351667fd8a3d() )
    {
        waitframe();
    }
    
    function_d738b5c7c1b66ba();
}

// Namespace battlerage
// Params 3
// Checksum 0xefe26486, Offset: 0xc1c
// Size: 0x1a8
function function_eeeeed58090ed956( battleragetype, var_fa82fbddc7f00c6b, var_abaa6c7e7ab2cc0f )
{
    if ( !self.battlerageactive )
    {
        return;
    }
    
    if ( getdvarint( @"vortex_playlist", 0 ) )
    {
        if ( weapon::isminigunweapon( self getcurrentweapon() ) && !killstreak::isjuggernaut() )
        {
            if ( isdefined( self getcurrentweapon() ) && self getcurrentweapon() hasattachment( "ammo_762n_vortex" ) )
            {
                return;
            }
        }
    }
    
    if ( !isdefined( battleragetype ) )
    {
        battleragetype = 0;
    }
    
    if ( battleragetype != self.battleragetype )
    {
        return;
    }
    
    if ( battleragetype == 4 && var_fa82fbddc7f00c6b != self.var_7253af70d06e06a )
    {
        return;
    }
    
    self notify( #"battlerageend" );
    function_f73ea867311dfe58();
    self.battlerageactive = undefined;
    self.battleragetype = undefined;
    self.var_7253af70d06e06a = undefined;
    self.superkills = undefined;
    function_d738b5c7c1b66ba();
    var_6852219d9be3d044 = getdvarint( @"hash_55316648a7be13d", 0 );
    var_60ea1fb2c3911d86 = getdvarint( @"hash_cf91c5d3c93671ad", 0 );
    
    if ( isdefined( self.var_634f9f77f9f0a718 ) )
    {
        challenges::function_a0936b0e5b4550f3( "super_battlerage", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"end" ), int( round( self.var_634f9f77f9f0a718 ) ) );
    }
    
    if ( !var_abaa6c7e7ab2cc0f && !level.gameended && player::isaliveandnotinlaststand( self ) )
    {
        function_db617173332bb681( var_6852219d9be3d044, var_60ea1fb2c3911d86 );
    }
    
    function_c800fd63679f9b33();
    function_b327ba547660533b();
    function_68e6ef5d62d1932a( 0 );
    playerhealth::function_b1fb4d148779580e( #"battlerage_beginsuper" );
}

// Namespace battlerage
// Params 1
// Checksum 0xee799246, Offset: 0xdcc
// Size: 0x1ca
function function_fdcb123f95f99584( var_abaa6c7e7ab2cc0f )
{
    if ( getdvarint( @"vortex_playlist", 0 ) )
    {
        if ( weapon::isminigunweapon( self getcurrentweapon() ) && !killstreak::isjuggernaut() )
        {
            if ( isdefined( self getcurrentweapon() ) && self getcurrentweapon() hasattachment( "ammo_762n_vortex" ) )
            {
                return;
            }
        }
    }
    
    self notify( #"battlerageend" );
    
    if ( !self.battlerageactive || self.battleragetype != 1 )
    {
        return;
    }
    
    function_f73ea867311dfe58();
    
    if ( isdefined( self.var_634f9f77f9f0a718 ) || isdefined( self.var_32817ca41f80f8aa ) )
    {
        challenges::function_3d7a169dbae062fb( "equip_battlerage", self, undefined, ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"end" ), self.var_32817ca41f80f8aa );
    }
    
    self.battlerageactive = undefined;
    self.battleragetype = undefined;
    self.var_7253af70d06e06a = undefined;
    self.superkills = undefined;
    self.var_32817ca41f80f8aa = undefined;
    overhealperc = getdvarint( @"hash_e2b1912f2da8b4b5", 0.2 );
    var_b9569622dddfa871 = overhealperc > 0;
    
    if ( var_b9569622dddfa871 )
    {
        function_d738b5c7c1b66ba();
    }
    
    var_6852219d9be3d044 = getdvarint( @"hash_55316648a7be13d", 0 );
    var_60ea1fb2c3911d86 = getdvarint( @"hash_cf91c5d3c93671ad", 0 );
    self.battlerage_endtime = undefined;
    self.var_634f9f77f9f0a718 = undefined;
    
    if ( !var_abaa6c7e7ab2cc0f && !level.gameended && player::isaliveandnotinlaststand( self ) )
    {
        function_db617173332bb681( var_6852219d9be3d044, var_60ea1fb2c3911d86 );
    }
    
    function_c800fd63679f9b33();
    function_b327ba547660533b();
    function_68e6ef5d62d1932a( 0 );
    playerhealth::function_b1fb4d148779580e( #"battlerage_beginsuper" );
}

// Namespace battlerage
// Params 2
// Checksum 0x88d64222, Offset: 0xf9e
// Size: 0x21
function function_949d230d9d5d97aa( equipmentref, slot )
{
    self notify( #"battlerage_taken" );
}

// Namespace battlerage
// Params 0, eflags: 0x4
// Checksum 0x2667bfde, Offset: 0xfc7
// Size: 0x5c
function private battlerage_interrupt()
{
    assert( self.battlerageactive, "<dev string:x24>" );
    var_abaa6c7e7ab2cc0f = 1;
    
    if ( self.battleragetype == 1 )
    {
        function_fdcb123f95f99584( var_abaa6c7e7ab2cc0f );
        return;
    }
    
    function_eeeeed58090ed956( self.battleragetype, self.var_7253af70d06e06a, var_abaa6c7e7ab2cc0f );
}

// Namespace battlerage
// Params 2, eflags: 0x4
// Checksum 0xb02d4fb9, Offset: 0x102b
// Size: 0x8f
function private function_db617173332bb681( var_29dd6332be410fab, blocksprint )
{
    if ( var_29dd6332be410fab )
    {
        endhealth = self.maxhealth * 0.2;
        
        if ( self.health > endhealth )
        {
            var_32c4474b7e5e174d = self.health - endhealth;
            self dodamage( var_32c4474b7e5e174d, self.origin, self, self, "MOD_TRIGGER_HURT", undefined, "torso_upper" );
        }
    }
    
    if ( player::isreallyalive( self ) && blocksprint )
    {
        thread function_1748a812731d5ed();
    }
}

// Namespace battlerage
// Params 0, eflags: 0x4
// Checksum 0xec23783e, Offset: 0x10c2
// Size: 0x58
function private function_1748a812731d5ed()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    val::set( "battleRage", "sprint", 0 );
    val::set( "battleRage", "supersprint", 0 );
    utility::waittill_any_timeout( 5, "battleRageStart" );
    val::reset_all( "battleRage" );
}

// Namespace battlerage
// Params 2, eflags: 0x4
// Checksum 0xc86efffc, Offset: 0x1122
// Size: 0x49
function private battlerage_watchgameend( battleragetype, var_7253af70d06e06a )
{
    self endon( #"death_or_disconnect" );
    self endon( #"battlerageend" );
    level utility::waittill_any( "game_ended", "prematch_cleanup" );
    thread function_eeeeed58090ed956( battleragetype, var_7253af70d06e06a );
}

// Namespace battlerage
// Params 0, eflags: 0x4
// Checksum 0x1ac3634b, Offset: 0x1173
// Size: 0x33
function private function_d360a74205ba3a5e()
{
    self endon( #"death_or_disconnect" );
    self endon( #"battlerageend" );
    level utility::waittill_any( "game_ended", "prematch_cleanup" );
    thread function_fdcb123f95f99584();
}

// Namespace battlerage
// Params 2, eflags: 0x4
// Checksum 0x5c314abc, Offset: 0x11ae
// Size: 0x50
function private battlerage_watchdeath( battleragetype, var_fa82fbddc7f00c6b )
{
    self endon( #"disconnect" );
    self endon( #"battlerageend" );
    level endon( #"game_ended" );
    self waittill( #"death" );
    thread function_eeeeed58090ed956( battleragetype, var_fa82fbddc7f00c6b );
}

// Namespace battlerage
// Params 0, eflags: 0x4
// Checksum 0x8ca2520c, Offset: 0x1206
// Size: 0x3a
function private function_73a77b9efa618c8f()
{
    self endon( #"disconnect" );
    self endon( #"battlerageend" );
    level endon( #"game_ended" );
    self waittill( #"death" );
    thread function_fdcb123f95f99584();
}

// Namespace battlerage
// Params 0, eflags: 0x4
// Checksum 0xc7e6995e, Offset: 0x1248
// Size: 0x91
function private function_4637a3c2f0acdf7b()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"undyingend" );
    hipfireforced = 0;
    
    while ( true )
    {
        healthpercent = clamp( self.health / self.maxhealth, 0.22, 1 );
        self setmovespeedscale( healthpercent );
        
        if ( healthpercent <= 0.3 && !hipfireforced )
        {
            self notify( #"battlerage_lowhealth" );
            hipfireforced = 1;
        }
        
        waitframe();
    }
}

// Namespace battlerage
// Params 1, eflags: 0x4
// Checksum 0x673bed69, Offset: 0x12e1
// Size: 0x3c
function private battlerage_takedeployweapon( deployweaponname )
{
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( deployweaponname ) )
    {
        return 0;
    }
    
    objweapon = makeweapon( deployweaponname );
    inventory_utility::_takeweapon( objweapon );
}

// Namespace battlerage
// Params 1, eflags: 0x4
// Checksum 0x70132a75, Offset: 0x1325
// Size: 0x3e
function private battlerage_givedeployweapon( deployweaponname )
{
    self endon( #"death_or_disconnect" );
    objweapon = makeweapon( deployweaponname );
    result = weapon_utility::giveandfireoffhandreliable( objweapon );
    return result;
}

// Namespace battlerage
// Params 0, eflags: 0x4
// Checksum 0xca4f02aa, Offset: 0x136c
// Size: 0x4f, Type: bool
function private function_d738b5c7c1b66ba()
{
    var_89d257c0eb008a82 = getmatchrulesdata( "commonOption", "maxHealth" );
    
    if ( self.maxhealth != var_89d257c0eb008a82 && !self.isjuggernaut )
    {
        self.maxhealth = var_89d257c0eb008a82;
        function_29c23debfb43e6ef();
        return true;
    }
    
    return false;
}

// Namespace battlerage
// Params 0, eflags: 0x4
// Checksum 0xc4d4dc34, Offset: 0x13c4
// Size: 0x26
function private function_29c23debfb43e6ef()
{
    self.health = int( clamp( self.health, 0, self.maxhealth ) );
}

// Namespace battlerage
// Params 0, eflags: 0x4
// Checksum 0xcd23c648, Offset: 0x13f2
// Size: 0x3f
function private battlerage_giveperks()
{
    perk::giveperk( "specialty_blastshield" );
    perk::giveperk( "specialty_tac_resist" );
    
    if ( getdvarint( @"hash_18cd69f9e0e0c0f9", 0 ) || isbrgamemode() )
    {
        perk::giveperk( "specialty_battlerage_reduce_damage" );
    }
}

// Namespace battlerage
// Params 0, eflags: 0x4
// Checksum 0xd8eddcc4, Offset: 0x1439
// Size: 0x5f
function private function_b327ba547660533b()
{
    if ( isdefined( self.perks[ "specialty_blastshield" ] ) )
    {
        perk::removeperk( "specialty_blastshield" );
    }
    
    if ( isdefined( self.perks[ "specialty_tac_resist" ] ) )
    {
        perk::removeperk( "specialty_tac_resist" );
    }
    
    if ( isdefined( self.perks[ "specialty_battlerage_reduce_damage" ] ) )
    {
        perk::removeperk( "specialty_battlerage_reduce_damage" );
    }
}

// Namespace battlerage
// Params 0, eflags: 0x4
// Checksum 0x3e89fe70, Offset: 0x14a0
// Size: 0x3f
function private function_e7fe18c98eb91c9c()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"battlerageend" );
    
    while ( true )
    {
        wait 0.1;
        
        if ( isdefined( self ) )
        {
            self refreshsprinttime();
        }
    }
}

// Namespace battlerage
// Params 2, eflags: 0x4
// Checksum 0xa5060f85, Offset: 0x14e7
// Size: 0x5d
function private function_83cc42bf8e9b5a11( bsuspended, var_81dd2aad8a11f979 )
{
    if ( !isdefined( bsuspended ) )
    {
        return 0;
    }
    
    if ( self.battlerageactive && var_81dd2aad8a11f979 )
    {
        if ( bsuspended )
        {
            function_f73ea867311dfe58( 1 );
        }
        else
        {
            function_18baf8431118039c( 0.5, 0.5 );
        }
    }
    
    self.var_1f363107fbac2ca = bsuspended;
}

// Namespace battlerage
// Params 0
// Checksum 0xc93dab06, Offset: 0x154c
// Size: 0xd
function function_5b4e4bcbeb7dfa07()
{
    function_83cc42bf8e9b5a11( 1, 1 );
}

// Namespace battlerage
// Params 0
// Checksum 0xfc3bfb47, Offset: 0x1561
// Size: 0xc
function function_9d0194c336e5da3c()
{
    function_83cc42bf8e9b5a11( 0, 1 );
}

// Namespace battlerage
// Params 2, eflags: 0x4
// Checksum 0xecfde8e9, Offset: 0x1575
// Size: 0xb2
function private battlerage_visionsetspainsurge( fblendtime, surgeduration )
{
    self notify( #"battlerage_visionsetspainsurge" );
    self endon( #"battlerage_visionsetspainsurge" );
    self endon( #"death_or_disconnect" );
    self endon( #"battlerageend" );
    self earthquakeforplayer( 0.3, fblendtime, self.origin, 50 );
    
    if ( !self.var_1f363107fbac2ca )
    {
        self visionsetnakedforplayer( "battlerage-low-health", fblendtime );
    }
    
    if ( !player::isinlaststand( self ) )
    {
        self playlocalsound( "plr_breath_pain_init" );
    }
    
    wait surgeduration;
    self setscriptablepartstate( "battleRageVfx", "vfx_start", 0 );
    function_18baf8431118039c( 0.5, 0.5 );
}

// Namespace battlerage
// Params 2, eflags: 0x4
// Checksum 0x10c9646f, Offset: 0x162f
// Size: 0x81
function private function_18baf8431118039c( var_99a25f438b1a4613, var_2519709721c06e48 )
{
    if ( self.var_1f363107fbac2ca )
    {
        return 0;
    }
    
    if ( self.health <= 0 )
    {
        return;
    }
    
    var_1255cfda9dbcb4ef = self.health / self.maxhealth;
    
    if ( var_1255cfda9dbcb4ef < 0.9 )
    {
        self visionsetnakedforplayer( "battlerage-low-health", var_99a25f438b1a4613 );
    }
    
    if ( var_1255cfda9dbcb4ef >= 0.9 )
    {
        self visionsetnakedforplayer( "battlerage-full-health", var_2519709721c06e48 );
    }
}

// Namespace battlerage
// Params 0
// Checksum 0xd348e8f, Offset: 0x16b8
// Size: 0x13
function function_a505cdfba75c83c6()
{
    function_18baf8431118039c( 0.5, 0.5 );
}

// Namespace battlerage
// Params 1
// Checksum 0x35712cb7, Offset: 0x16d3
// Size: 0x1d
function function_3913721fc81d6e67( amounthealed )
{
    function_18baf8431118039c( 0.5, 0.5 );
}

// Namespace battlerage
// Params 0
// Checksum 0x583a0a94, Offset: 0x16f8
// Size: 0x13
function function_f8a0fd73622e2ee2()
{
    function_18baf8431118039c( 0.5, 0.5 );
}

// Namespace battlerage
// Params 0
// Checksum 0x566b50f8, Offset: 0x1713
// Size: 0x13
function function_bd161ebde68dbeeb()
{
    function_18baf8431118039c( 0.5, 0.5 );
}

// Namespace battlerage
// Params 0
// Checksum 0xf64a5145, Offset: 0x172e
// Size: 0x7a
function function_65a7656a63fc0baa()
{
    self endon( #"death_or_disconnect" );
    self endon( #"battlerageend" );
    level endon( #"game_ended" );
    defaultduration = getdvarfloat( @"scr_battlerage_default_duration", 6 ) * 1000;
    self.battlerage_endtime = int( gettime() + defaultduration );
    
    while ( gettime() < self.battlerage_endtime )
    {
        wait 0.25;
    }
    
    thread function_fdcb123f95f99584();
}

// Namespace battlerage
// Params 0
// Checksum 0xbc571cd3, Offset: 0x17b0
// Size: 0x68
function function_e0d35e2a70f7d7fb()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"battlerageend" );
    
    while ( true )
    {
        self waittill( #"killed_enemy" );
        function_dd0df5b8eeb7a712();
        self.var_32817ca41f80f8aa++;
        
        if ( self.battlerageactive )
        {
            thread points::doscoreevent( #"equip_battlerage_extend" );
        }
    }
}

// Namespace battlerage
// Params 1
// Checksum 0x4ad357a5, Offset: 0x1820
// Size: 0x22
function function_19efaee6fff21bf0( istactical )
{
    if ( istactical )
    {
        function_dd0df5b8eeb7a712();
        return;
    }
    
    function_d6bf8a75f4114824();
}

// Namespace battlerage
// Params 0
// Checksum 0xe01da066, Offset: 0x184a
// Size: 0x151
function function_dd0df5b8eeb7a712()
{
    if ( !isdefined( self.var_634f9f77f9f0a718 ) )
    {
        self.var_634f9f77f9f0a718 = 0;
    }
    
    var_d943b991cdc2bf21 = getdvarfloat( @"hash_7e8c0274f6a1d8ac", 0.01 );
    var_97538ebee05f1cef = getdvarfloat( @"hash_b9c50a6287359eb0", 10 );
    
    if ( var_d943b991cdc2bf21 <= 0 )
    {
        return;
    }
    
    var_5994842eea64448e = self.var_634f9f77f9f0a718 + var_d943b991cdc2bf21;
    var_9224097075ad172d = var_97538ebee05f1cef <= 0;
    var_8e3bed3b73edb8fc = var_5994842eea64448e < var_97538ebee05f1cef;
    
    if ( var_9224097075ad172d || var_8e3bed3b73edb8fc )
    {
        self.var_634f9f77f9f0a718 += var_d943b991cdc2bf21;
        self.battlerage_endtime += var_d943b991cdc2bf21 * 1000;
    }
    else
    {
        var_255baa54152e9223 = var_97538ebee05f1cef - self.var_634f9f77f9f0a718;
        var_255baa54152e9223 = max( var_255baa54152e9223, 0 );
        
        if ( var_255baa54152e9223 > 0 )
        {
            self.var_634f9f77f9f0a718 += var_255baa54152e9223;
            self.battlerage_endtime += var_255baa54152e9223 * 1000;
        }
    }
    
    if ( getdvarint( @"hash_fa795fa5ac66dd8c", 1 ) )
    {
        self notify( #"force_regeneration" );
    }
    
    assert( self.var_634f9f77f9f0a718 <= var_97538ebee05f1cef || var_9224097075ad172d );
}

// Namespace battlerage
// Params 0
// Checksum 0xd366da20, Offset: 0x19a3
// Size: 0xdd
function function_2e1765f76a79f684()
{
    self endon( #"death_or_disconnect" );
    self endon( #"killed_player" );
    self endon( #"stopped_self_revive" );
    self endon( #"battlerageend" );
    level endon( #"game_ended" );
    battleragedata = level.superglobals.staticsuperdata[ "super_battlerage" ];
    battleragetime = battleragedata.usetime;
    secondselapsed = 0;
    self waittill( #"last_stand_revived" );
    self playlocalsound( "plr_breath_pain_init" );
    
    while ( secondselapsed < battleragetime )
    {
        if ( secondselapsed >= battleragetime )
        {
            break;
        }
        
        if ( !player::isaliveandnotinlaststand( self ) && secondselapsed > 0 )
        {
            break;
        }
        
        waitframe();
        secondselapsed += level.framedurationseconds;
    }
    
    thread function_eeeeed58090ed956( 2 );
}

// Namespace battlerage
// Params 0
// Checksum 0xf669434a, Offset: 0x1a88
// Size: 0x13
function function_76e76e836599e978()
{
    thread battlerage_visionsetspainsurge( 0.5, 0.2 );
}

// Namespace battlerage
// Params 1
// Checksum 0x1ae09a36, Offset: 0x1aa3
// Size: 0xd6
function function_4efed612dfe4a011( var_fa82fbddc7f00c6b )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"battlerageend" );
    giverplayer = getentbynum( var_fa82fbddc7f00c6b );
    
    if ( !isdefined( giverplayer ) || giverplayer.team != self.team )
    {
        return;
    }
    
    while ( true )
    {
        self waittill( #"killed_enemy" );
        
        if ( getdvarint( @"hash_fa795fa5ac66dd8c", 1 ) )
        {
            self notify( #"force_regeneration" );
        }
        
        thread points::doscoreevent( #"super_battlerage_extend" );
        
        if ( isdefined( giverplayer ) && giverplayer.battlerageactive && giverplayer.battleragetype == 3 )
        {
            giverplayer function_d6bf8a75f4114824();
        }
    }
}

