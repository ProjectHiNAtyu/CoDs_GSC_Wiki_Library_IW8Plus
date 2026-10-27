// scripts\mp\common\equipment\temp_v_melee_superpower.gsc  (hash_4eae04a3a7711836.gscc) (size: 5943 Bytes / 0x1737 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf5470ed3 (4115074771)
// size ...... 5943 (0x1737)
// includes .. 12  (offset: 0x1537)
// strings ... 30  (offset: 0x1597)
// dev strs .. 1   (offset: 0x172b)
// exports ... 15  (offset: 0xd63)
// cseg ...... 0x273 + 0xaf0 (0xd63)
// imports ... 48  (offset: 0xfbb)
// animtree1 . 0   (offset: 0x1737)
// animtree2 . 0   (offset: 0x1737)
#using scripts\common\damage_effects;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\class;
#using scripts\mp\common\equipment\gas_grenade;
#using scripts\mp\common\killstreaks\white_phosphorus;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\gametypes\common;
#using scripts\mp\supers;
#using scripts\mp\weapons;

#namespace temp_v_melee_superpower;

// Namespace temp_v_melee_superpower
// Params 0, eflags: 0x1
// Checksum 0xdd1310ca, Offset: 0x291
// Size: 0x9
function autoexec main()
{
    function_752f0d0ab9b1a9c3();
}

// Namespace temp_v_melee_superpower
// Params 0
// Checksum 0x31653b0b, Offset: 0x2a2
// Size: 0x71
function function_752f0d0ab9b1a9c3()
{
    utility::flag_wait( "temp_v_initialized" );
    supers_mp::function_48aaa60b2ce7b8a1( "super_melee_jugg", undefined, undefined, &function_40df97bd4f30eb02, &function_a006212091889235, undefined, undefined, undefined );
    
    if ( !isdefined( level.tempvdata ) )
    {
        return;
    }
    
    if ( !isdefined( level.tempvdata.powers ) )
    {
        return;
    }
    
    level.tempvdata.powers[ "melee" ] = function_16ed0ae74360ebff();
}

// Namespace temp_v_melee_superpower
// Params 0
// Checksum 0x31f0268b, Offset: 0x31b
// Size: 0xba
function function_16ed0ae74360ebff()
{
    config = spawnstruct();
    config.maxhealth = 1000;
    config.startinghealth = config.maxhealth;
    config.movespeedscalar = getdvarfloat( @"hash_8e4a9b19254b5834", 0.5 );
    config.maxvehicledamagedivisor = 3;
    config.classstruct = function_b912194eddbbf50c();
    config.allowscallback = &function_a7d0ff25bef55543;
    config.perks = [ "specialty_huntmaster", "specialty_tac_resist", "specialty_hustle", "specialty_eod" ];
    return config;
}

// Namespace temp_v_melee_superpower
// Params 0
// Checksum 0x4a6df7c1, Offset: 0x3de
// Size: 0x3d
function function_25c0460b9832efe5()
{
    assert( isdefined( level.tempvdata.powers[ "<dev string:x24>" ] ) );
    return level.tempvdata.powers[ "melee" ];
}

// Namespace temp_v_melee_superpower
// Params 1
// Checksum 0xd50787fd, Offset: 0x424
// Size: 0x69
function function_a7d0ff25bef55543( isactivated )
{
    if ( isactivated )
    {
        blockedvalues = [ "ads", "weapon_switch", "weapon_pickup", "weapon_switch_clip", "reload" ];
        val::set_array( "melee_superpower", blockedvalues, 0 );
        return;
    }
    
    val::reset_all( "melee_superpower" );
}

// Namespace temp_v_melee_superpower
// Params 0
// Checksum 0x850da66e, Offset: 0x495
// Size: 0x2b6
function function_40df97bd4f30eb02()
{
    assert( player::isreallyalive( self ) );
    self.var_9d06c5b5a931f6e = 1;
    gas_grenade::gas_updateplayereffects();
    powerconfig = function_25c0460b9832efe5();
    var_48ad84fa35e3ae21 = spawnstruct();
    var_48ad84fa35e3ae21.config = powerconfig;
    var_48ad84fa35e3ae21.prevhealth = self.health;
    var_48ad84fa35e3ae21.maxhealth = self.maxhealth;
    var_48ad84fa35e3ae21.prevspeedscale = self.playerstreakspeedscale ?? 0;
    var_48ad84fa35e3ae21.maskomnvar = "ui_gas_mask_juggernaut";
    self.maxhealth = powerconfig.maxhealth;
    self.health = powerconfig.startinghealth;
    weapons::function_7cc000a4d4bc9a60();
    weapons::savetogglescopestates();
    weapons::savealtstates();
    
    if ( isdefined( level.clearbrinventory ) )
    {
        self [[ level.clearbrinventory ]]();
    }
    
    self.lastdroppableweaponobj = undefined;
    
    if ( isdefined( powerconfig.classstruct ) )
    {
        var_48ad84fa35e3ae21.prevclass = self.lastclass;
        var_48ad84fa35e3ae21.prevclassstruct = self.classstruct;
        class::loadout_updateclass( powerconfig.classstruct, "superpower" );
        class::preloadandqueueclassstruct( powerconfig.classstruct, 1, 1 );
        class::giveloadout( self.team, "superpower", 0, 1 );
    }
    
    foreach ( perk in powerconfig.perks )
    {
        perk::giveperk( perk );
    }
    
    self [[ powerconfig.allowscallback ]]( 1 );
    white_phosphorus::enableloopingcoughaudiosupression();
    self.playerstreakspeedscale = powerconfig.movespeedscalar;
    
    if ( !common::function_8ff835bf23198a0( "playerStreakSpeedScale" ) )
    {
        common::function_ac4bf3256b2545e3( "playerStreakSpeedScale", self.playerstreakspeedscale );
        common::function_a6a0ecdb12c8e351( 2 );
    }
    
    weapons::updatemovespeedscale();
    self.tempvcontext = var_48ad84fa35e3ae21;
    function_288fada94065b666();
    killstreak_utility::function_bea4bda17e40ffb0( self );
    self notify( #"tempv_start", "melee" );
    thread function_c4fd8d4d021a4eab();
    thread function_9897f67479247e52();
    thread function_8577e7dc8756ac0d();
    thread function_fb59c2b75825aa3b( self.tempvcontext );
    damage_effects::onexitdeathsdoor( 1 );
}

// Namespace temp_v_melee_superpower
// Params 0
// Checksum 0x56f5489d, Offset: 0x753
// Size: 0x5a
function function_b912194eddbbf50c()
{
    classstruct = class::loadout_getclassstruct();
    classstruct.loadoutarchetype = "archetype_assault";
    classstruct.loadoutprimary = "iw9_me_superfists_mp";
    classstruct.loadoutsecondary = "none";
    classstruct.loadoutequipmentprimary = "equip_throwing_knife";
    return classstruct;
}

// Namespace temp_v_melee_superpower
// Params 0
// Checksum 0x10a05df0, Offset: 0x7b6
// Size: 0x2e
function function_c4fd8d4d021a4eab()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self waittill( #"death" );
    function_a006212091889235();
}

// Namespace temp_v_melee_superpower
// Params 0
// Checksum 0x88be78fe, Offset: 0x7ec
// Size: 0x66
function function_9897f67479247e52()
{
    self endon( #"disconnect" );
    self endon( #"hash_5e5810522b7507e5" );
    level waittill( #"game_ended" );
    self.maxhealth = self.tempvcontext.prevmaxhealth;
    self.health = self.tempvcontext.prevhealth;
    function_a006212091889235();
}

// Namespace temp_v_melee_superpower
// Params 0
// Checksum 0x9ce80a83, Offset: 0x85a
// Size: 0x69
function function_8577e7dc8756ac0d()
{
    level endon( #"game_ended" );
    self endon( #"hash_5e5810522b7507e5" );
    tempvcontext = self.tempvcontext;
    self waittill( #"disconnect" );
    
    if ( isdefined( self ) )
    {
        self.maxhealth = tempvcontext.prevmaxhealth;
        self.health = tempvcontext.prevhealth;
    }
}

// Namespace temp_v_melee_superpower
// Params 0
// Checksum 0x8c5395e9, Offset: 0x8cb
// Size: 0x94
function function_288fada94065b666()
{
    self notify( #"hash_800924e652cea843" );
    tempvcontext = self.tempvcontext;
    
    if ( !isdefined( self.var_56d4bd2096333b03 ) && !isdefined( self.var_ec6771e3aa5eb9cb ) )
    {
        self.var_56d4bd2096333b03 = "mask_on";
        self.var_ec6771e3aa5eb9cb = 1;
    }
    
    self setclientomnvar( "ui_assault_suit_on", 0 );
    killstreak_utility::function_d546aaa588f088c3( "juggernaut", self.var_56d4bd2096333b03 );
    self setclientomnvar( tempvcontext.maskomnvar, self.var_ec6771e3aa5eb9cb );
}

// Namespace temp_v_melee_superpower
// Params 2
// Checksum 0x6854ed1a, Offset: 0x967
// Size: 0x5e
function function_c5076d9e81480e51( tempvcontext, retainstate )
{
    self notify( #"hash_5e4d085eb53ed027" );
    
    if ( !retainstate )
    {
        self.var_56d4bd2096333b03 = undefined;
        self.var_ec6771e3aa5eb9cb = undefined;
    }
    
    killstreak_utility::function_d546aaa588f088c3( "juggernaut", "off" );
    self setclientomnvar( tempvcontext.maskomnvar, 0 );
}

// Namespace temp_v_melee_superpower
// Params 0
// Checksum 0x83fe5321, Offset: 0x9cd
// Size: 0x1f8
function function_a006212091889235()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    assert( self.var_9d06c5b5a931f6e );
    assert( isdefined( self.tempvcontext ) );
    self notify( #"hash_8a2205bd7329ffc9" );
    tempvcontext = self.tempvcontext;
    powerconfig = tempvcontext.config;
    self.musicplaying = undefined;
    self.var_c6ec5306170d4f28 = undefined;
    self.var_9a17b6833b49f11 = undefined;
    function_c5076d9e81480e51( self.tempvcontext );
    self [[ powerconfig.allowscallback ]]( 1 );
    killstreak_utility::function_c463ddccb4054cc2( self );
    
    if ( player::isreallyalive( self ) )
    {
        self.maxhealth = tempvcontext.prevmaxhealth;
        self.health = tempvcontext.prevhealth;
        white_phosphorus::disableloopingcoughaudiosupression();
        
        if ( isdefined( powerconfig.classstruct ) )
        {
            class::respawnitems_assignrespawnitems( tempvcontext.respawnitems );
            class::giveloadout( self.team, tempvcontext.prevclass, 0, 1, 1 );
        }
        
        foreach ( perk, unused in powerconfig.perks )
        {
            perk::removeperk( perk );
        }
    }
    
    self.playerstreakspeedscale = tempvcontext.prevspeedscale;
    
    if ( !common::function_8ff835bf23198a0( "playerStreakSpeedScale" ) )
    {
        common::function_ac4bf3256b2545e3( "playerStreakSpeedScale", self.playerstreakspeedscale );
        common::function_a6a0ecdb12c8e351( 2 );
    }
    
    weapons::updatemovespeedscale();
    self.tempvcontext = undefined;
    self.var_9d06c5b5a931f6e = undefined;
}

// Namespace temp_v_melee_superpower
// Params 1
// Checksum 0xefe90ee7, Offset: 0xbcd
// Size: 0x196
function function_fb59c2b75825aa3b( tempvcontext )
{
    self endon( #"juggernaut_end" );
    self endon( #"hash_a35808f532d8b26c" );
    level endon( #"game_ended" );
    startinghealth = self.health;
    stage1damage = startinghealth - startinghealth * 0.1;
    stage2damage = startinghealth - startinghealth * 0.35;
    stage3damage = startinghealth - startinghealth * 0.6;
    stage4damage = startinghealth - startinghealth * 0.85;
    overlaystate = 1;
    var_ccc1d6bc36da0c72 = overlaystate;
    overlaystatelabel = "mask_on";
    
    while ( true )
    {
        utility::waittill_any( "damage", "jugg_health_regen" );
        
        if ( self.health <= stage4damage )
        {
            overlaystatelabel = "mask_damage_critical";
            overlaystate = 5;
        }
        else if ( self.health <= stage3damage )
        {
            overlaystatelabel = "mask_damage_high";
            overlaystate = 4;
        }
        else if ( self.health <= stage2damage )
        {
            overlaystatelabel = "mask_damage_med";
            overlaystate = 3;
        }
        else if ( self.health <= stage1damage )
        {
            overlaystatelabel = "mask_damage_low";
            overlaystate = 2;
        }
        else
        {
            overlaystatelabel = "mask_on";
            overlaystate = 1;
        }
        
        if ( var_ccc1d6bc36da0c72 != overlaystate )
        {
            killstreak_utility::function_d546aaa588f088c3( "juggernaut", overlaystatelabel );
            self setclientomnvar( tempvcontext.maskomnvar, overlaystate );
            var_ccc1d6bc36da0c72 = overlaystate;
            self.var_56d4bd2096333b03 = overlaystatelabel;
            self.var_ec6771e3aa5eb9cb = overlaystate;
        }
    }
}

