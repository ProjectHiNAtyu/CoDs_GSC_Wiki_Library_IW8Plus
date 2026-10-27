// scripts\mp\juggernaut.gsc  (hash_1b31527b4e9781d2.gscc) (size: 29074 Bytes / 0x7192 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x636e436f (1668170607)
// size ...... 29074 (0x7192)
// includes .. 33  (offset: 0x687a)
// strings ... 92  (offset: 0x6982)
// dev strs .. 47  (offset: 0x6ef6)
// exports ... 60  (offset: 0x4526)
// cseg ...... 0x60e + 0x3f18 (0x4526)
// imports ... 220 (offset: 0x4e86)
// animtree1 . 0   (offset: 0x7192)
// animtree2 . 0   (offset: 0x7192)
#using script_74b851b7aa1ef32d;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\mp\armor;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\class;
#using scripts\mp\common\equipment\gas_grenade;
#using scripts\mp\common\killstreaks\white_phosphorus;
#using scripts\mp\common\perks\perkpackage;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\equipment;
#using scripts\mp\execution;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\common;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_item;
#using scripts\mp\operator;
#using scripts\mp\supers;
#using scripts\mp\talking_gun;
#using scripts\mp\teams;
#using scripts\mp\weapons;

#namespace juggernaut;

// Namespace juggernaut
// Params 0
// Checksum 0x3ea6ace9, Offset: 0x62c
// Size: 0x10a
function init()
{
    level.activejuggernauts = [];
    level.var_c136dbcee5b9ac85 = [ "pristine", "damaged" ];
    level.var_f3f8f12f590587b7 = [ "helmet", "neckguard", "backpack", "shoulderpad_l", "shoulderpad_r", "forearmpad_l", "forearmpad_r", "qamis", "thighpad_l", "thighpad_r" ];
    callback::add( #"hash_657f964d63330123", &function_abaabd328c4f0b84 );
    callback::add( #"hash_4239cc94bed9cb5c", &function_b9e4bac6cd459601 );
    callback::add( #"item_can_drop", &function_e52712e27f816b6a );
    
    /#
        setdevdvarifuninitialized( @"hash_caba4093ed4a5d5d", 0 );
        setdevdvarifuninitialized( @"hash_63bf655a03b825eb", 0 );
        setdevdvarifuninitialized( @"hash_ae2c4f86ffaf24db", 0 );
        setdevdvarifuninitialized( @"scr_juggernaut_execution", 0 );
    #/
}

// Namespace juggernaut
// Params 1
// Checksum 0x18fd7f4b, Offset: 0x73e
// Size: 0x19, Type: bool
function function_abaabd328c4f0b84( params )
{
    if ( killstreak::isjuggernaut() )
    {
        return true;
    }
    
    return false;
}

// Namespace juggernaut
// Params 3
// Checksum 0xb10fe97e, Offset: 0x760
// Size: 0xb39, Type: bool
function jugg_makejuggernaut( juggconfig, streakinfo, bundle )
{
    assert( player::isreallyalive( self ) );
    validstance = function_185c3871d7f3946c( juggconfig );
    
    if ( !isdefined( validstance ) )
    {
        hud_message::showerrormessage( %"killstreaks/jugg_cannot_become" );
        return false;
    }
    
    var_1a51232331718d97 = validstance != self getstance();
    self.isjuggernaut = 1;
    battlechatter_mp::disablebattlechatter( self );
    gas_grenade::gas_updateplayereffects();
    juggcontext = spawnstruct();
    juggcontext.juggconfig = juggconfig;
    customization = operator::getoperatorcustomization();
    juggcontext.prevhealth = self.health;
    juggcontext.prevmaxhealth = self.maxhealth;
    juggcontext.prevoperator = self.operatorcustomization.operatorref;
    juggcontext.prevskin = self.operatorcustomization.skinref;
    juggcontext.prevspeedscale = self.playerstreakspeedscale;
    juggcontext.prevsuit = self.suit;
    juggcontext.prevclothtype = self.clothtype;
    juggcontext.var_975438351ed2702c = self.operatorcustomization.geartype;
    juggcontext.maskomnvar = "ui_gas_mask_juggernaut";
    juggcontext.var_753a26cb97003ff5 = juggconfig.var_753a26cb97003ff5;
    
    if ( isdefined( self.operatorcustomization ) && isdefined( self.operatorcustomization.execution ) )
    {
        juggcontext.prevexecution = self.operatorcustomization.execution;
    }
    
    if ( isdefined( self.super ) )
    {
        juggcontext.var_4f9d8504a2ea75e9 = supers_mp::getcurrentsuperpoints();
    }
    
    if ( !isdefined( juggconfig.usearmorparts ) )
    {
        juggconfig.usearmorparts = 1;
    }
    
    if ( juggconfig.usearmorparts )
    {
        juggcontext.partshealth = [];
        juggcontext.partshealth[ "head_health" ] = juggconfig.head_health ?? 100;
        juggcontext.partshealth[ "torso_upper_health" ] = juggconfig.torso_upper_health ?? 100;
        juggcontext.partshealth[ "torso_lower_health" ] = juggconfig.torso_lower_health ?? 100;
        juggcontext.partshealth[ "right_upper_arm_health" ] = juggconfig.right_upper_arm_health ?? 100;
        juggcontext.partshealth[ "right_lower_arm_health" ] = juggconfig.right_lower_arm_health ?? 100;
        juggcontext.partshealth[ "left_upper_arm_health" ] = juggconfig.left_upper_arm_health ?? 100;
        juggcontext.partshealth[ "left_lower_arm_health" ] = juggconfig.left_lower_arm_health ?? 100;
        juggcontext.partshealth[ "right_leg_health" ] = juggconfig.right_leg_health ?? 100;
        juggcontext.partshealth[ "left_leg_health" ] = juggconfig.left_leg_health ?? 100;
        self.var_c6ec5306170d4f28 = &function_28d6476ed9716980;
    }
    
    juggcontext.executionlist = juggconfig.executionlist;
    self.maxhealth = juggconfig.maxhealth;
    self.health = juggconfig.startinghealth;
    self.var_9a17b6833b49f11 = 0;
    weapons::savetogglescopestates();
    weapons::savealtstates();
    weapons::function_7cc000a4d4bc9a60();
    
    if ( level.clearbrinventory && !self.gulag )
    {
        self [[ level.clearbrinventory ]]();
    }
    
    if ( juggconfig.clearperks )
    {
        class::loadout_clearperks();
        utility::callsharedfunc( #"perk", #"hash_f15a1c0958b41b8b" );
        utility::callsharedfunc( #"perk", #"hash_ff6f8c52b04ef8c2" );
    }
    
    if ( juggconfig.var_8fe0df29471119b7 )
    {
        armor::setarmorhealth( 0, 1 );
    }
    
    if ( isdefined( juggconfig.classstruct ) && !game_utility_mp::isjuggermoshgamemode() )
    {
        respawnitems = class::respawnitems_saveplayeritemstostruct();
        
        if ( isdefined( level.var_684bfa13b9bdb3b2 ) )
        {
            [[ level.var_684bfa13b9bdb3b2 ]]( respawnitems );
        }
        
        juggcontext.respawnitems = respawnitems;
        juggcontext.prevclass = self.lastclass;
        juggcontext.prevclassstruct = self.classstruct;
        var_9edcca6343f41f5b = juggconfig.var_9edcca6343f41f5b || juggconfig.var_8fe0df29471119b7;
        class::loadout_updateclass( juggconfig.classstruct, "juggernaut" );
        class::preloadandqueueclassstruct( juggconfig.classstruct, 1, 1 );
        class::giveloadout( self.team, "juggernaut", 0, 1, 0, 0, 1, var_9edcca6343f41f5b );
        
        if ( isdefined( juggconfig.classstruct.loadoutequipmentprimary ) && juggconfig.var_4fabfc606c18a589 > 1 )
        {
            equipment_mp::incrementequipmentammo( juggconfig.classstruct.loadoutequipmentprimary, juggconfig.var_4fabfc606c18a589 - 1 );
        }
        
        if ( isdefined( juggconfig.classstruct.loadoutequipmentsecondary ) && juggconfig.var_9a10c0470657316c > 1 )
        {
            equipment_mp::incrementequipmentammo( juggconfig.classstruct.loadoutequipmentsecondary, juggconfig.var_9a10c0470657316c - 1 );
        }
        
        var_e7798886efafd6a8 = isdefined( juggconfig.classstruct.loadoutequipmentprimary ) && juggconfig.var_4fabfc606c18a589 > 0;
        var_3f963a90dcfaf378 = isdefined( juggconfig.classstruct.loadoutequipmentsecondary ) && juggconfig.var_9a10c0470657316c > 0;
        var_9fe8687b85aa1c4 = 0;
        
        if ( var_e7798886efafd6a8 && var_3f963a90dcfaf378 )
        {
            var_9fe8687b85aa1c4 = 3;
        }
        else if ( var_e7798886efafd6a8 )
        {
            var_9fe8687b85aa1c4 = 1;
        }
        else if ( var_3f963a90dcfaf378 )
        {
            var_9fe8687b85aa1c4 = 2;
        }
        
        self setclientomnvar( "ui_gas_mask_juggernaut_equipment", var_9fe8687b85aa1c4 );
    }
    
    self.lastdroppableweaponobj = undefined;
    
    foreach ( perk, unused in juggconfig.perks )
    {
        perk::giveperk( perk );
    }
    
    if ( self.pickedupcoreminigun )
    {
        val::group_reset( "fakeJugg" );
        self.pickedupcoreminigun = undefined;
    }
    
    function_27df84092e4f76b9( juggconfig.restrictions, 1 );
    white_phosphorus::enableloopingcoughaudiosupression();
    self function_16332a7775f10aa9();
    jugg_setmodel( juggconfig );
    self.playerstreakspeedscale = juggconfig.movespeedscalar;
    
    if ( isdefined( self.playerstreakspeedscale ) && !common::function_8ff835bf23198a0( "playerStreakSpeedScale" ) )
    {
        common::function_ac4bf3256b2545e3( "playerStreakSpeedScale", self.playerstreakspeedscale );
        common::function_a6a0ecdb12c8e351( 2 );
    }
    
    weapons::updatemovespeedscale();
    juggcontext.var_cada3a2b875f08a2 = arraycombine( juggconfig.var_cada3a2b875f08a2, [ level.var_f04aa33339fc802a, level.var_236a38f198a8e72a ] );
    self.juggcontext = juggcontext;
    player::_setsuit( juggconfig.suit );
    self setclothtype( getxhash( juggconfig.clothtype ) );
    self setgeartype( juggconfig.geartype ?? #"milhvygr" );
    jugg_enableoverlay( juggcontext );
    killstreak_utility::function_bea4bda17e40ffb0( self );
    
    if ( getdvarint( @"scr_juggernaut_execution", 0 ) )
    {
        jugg_giveexecution( juggcontext.juggconfig.execution );
    }
    
    if ( juggconfig.infiniteammo )
    {
        thread weapon::infiniteammothread( juggconfig.infiniteammoupdaterate, undefined, 1 );
    }
    else
    {
        weaponslist = self getweaponslistall();
        
        foreach ( weapon in weaponslist )
        {
            if ( !jugg_isprimaryweapon( juggconfig, weapon.basename ) )
            {
                continue;
            }
            
            self setweaponammoclip( weapon, weaponclipsize( weapon ) );
            
            if ( jugg_canreload() )
            {
                self givemaxammo( weapon );
                thread jugg_managestockammo( weapon );
            }
        }
    }
    
    self.streakinfo = streakinfo;
    self notify( #"hash_82aae102a5349d66" );
    thread gameobjects::onjuggernaut();
    thread jugg_watchmusictoggle( streakinfo.config.var_c8529f1600572acc, streakinfo.streakname );
    thread jugg_watchfordeath();
    thread jugg_watchforgameend();
    thread jugg_watchfordisconnect();
    thread jugg_watchforfire();
    
    if ( !juggconfig.var_bb1e3e93f17620c )
    {
        thread jugg_watchherodrop();
    }
    
    thread function_3c8f01d47ed64b39( juggconfig.usearmorparts );
    thread jugg_watchoverlaydamagestates( self.juggcontext );
    thread jugg_watchforoverlayexecutiontoggle();
    thread function_b5b462df5995d6dc();
    thread jugg_watchswimming();
    thread jugg_watchtimeout( juggconfig );
    
    if ( !juggconfig.disableparachute && jugg_canparachute() )
    {
        self skydive_setbasejumpingstatus( 1 );
        self skydive_setdeploymentstatus( 1 );
        self skydive_cutparachuteon();
    }
    else
    {
        self skydive_setbasejumpingstatus( 0 );
        self skydive_setdeploymentstatus( 0 );
        self skydive_cutparachuteoff();
    }
    
    if ( isdefined( level.addjuggfunctionality ) )
    {
        self [[ level.addjuggfunctionality ]]();
    }
    
    self.var_ae4a9afb559a5d7 = istrue( juggconfig.forcetostand );
    
    if ( self.var_ae4a9afb559a5d7 )
    {
        self setstance( "stand" );
    }
    else if ( var_1a51232331718d97 )
    {
        self setstance( validstance );
    }
    
    damage_effects::onexitdeathsdoor( 1 );
    self.var_e4dae87a649544c3 = istrue( juggconfig.removeondeath );
    self.var_abdb15f3972c9de3 = istrue( juggconfig.ignorearmor );
    jugg_addtoactivejugglist();
    namespace_5f4bb62dbf67ff87::doonactionscoreevent( 2, "juggernautEquipped" );
    talking_gun::talkinggun_event( self, #"become_juggernaut" );
    killstreak_utility::function_56141a75b0286674( #"hash_39046aa32b2153cf", self, self.team );
    
    if ( juggconfig.hidefromcompass )
    {
        function_1883025fa745694e( 1 );
    }
    
    return true;
}

// Namespace juggernaut
// Params 1
// Checksum 0x1ca234e8, Offset: 0x12a2
// Size: 0x435
function jugg_removejuggernaut( damagedata )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( self.var_56e1683c857afcf5 )
    {
        return;
    }
    
    self.var_56e1683c857afcf5 = 1;
    
    if ( damagedata.meansofdeath == "MOD_TRIGGER_HURT" )
    {
        damagedata.instantdeath = 1;
    }
    
    assert( self.isjuggernaut );
    assert( isdefined( self.juggcontext ) );
    self notify( #"juggernaut_end" );
    juggcontext = self.juggcontext;
    juggconfig = juggcontext.juggconfig;
    self setscriptablepartstate( "remove_juggernaut", "remove", 0 );
    function_2d452e35800a1a3a();
    self.var_1b413788c732898 = undefined;
    self.var_1817b7dc2c665ed7 = undefined;
    self.musicplaying = undefined;
    self.var_c6ec5306170d4f28 = undefined;
    self.var_9a17b6833b49f11 = undefined;
    jugg_disableoverlay( juggcontext );
    function_27df84092e4f76b9( juggconfig.restrictions, 0 );
    
    if ( juggconfig.removefunc )
    {
        self [[ juggconfig.removefunc ]]( damagedata );
    }
    
    killstreak_utility::function_c463ddccb4054cc2( self );
    
    if ( player::isreallyalive( self ) )
    {
        self.maxhealth = juggcontext.prevmaxhealth;
        self.health = juggcontext.prevhealth;
        white_phosphorus::disableloopingcoughaudiosupression();
        
        if ( isdefined( juggconfig.classstruct ) && !self.var_f59b131f877a229e )
        {
            var_9edcca6343f41f5b = juggconfig.var_9edcca6343f41f5b || juggconfig.var_8fe0df29471119b7;
            class::respawnitems_assignrespawnitems( juggcontext.respawnitems );
            class::giveloadout( self.team, juggcontext.prevclass, 0, 1, 1, 0, 0, var_9edcca6343f41f5b );
        }
        
        if ( isdefined( juggcontext.var_4f9d8504a2ea75e9 ) )
        {
            supers_mp::setsuperbasepoints( juggcontext.var_4f9d8504a2ea75e9 );
        }
        
        foreach ( perk, unused in juggconfig.perks )
        {
            perk::removeperk( perk );
        }
    }
    
    if ( juggconfig.infiniteammo )
    {
        weapon::stopinfiniteammothread();
    }
    
    jugg_restoremodel( juggcontext );
    
    if ( common::function_8ff835bf23198a0( "playerStreakSpeedScale" ) )
    {
        common::function_d85a92c557ea5a52( "playerStreakSpeedScale" );
        common::function_65276d8c156b2ec9( 2 );
    }
    
    self.playerstreakspeedscale = juggcontext.prevspeedscale;
    
    if ( isdefined( self.playerstreakspeedscale ) )
    {
        common::function_ac4bf3256b2545e3( "playerStreakSpeedScale", self.playerstreakspeedscale );
        common::function_a6a0ecdb12c8e351( 2 );
    }
    
    weapons::updatemovespeedscale();
    player::_setsuit( juggcontext.prevsuit );
    self setclothtype( getxhash( juggcontext.prevclothtype ) );
    self setgeartype( juggcontext.var_975438351ed2702c );
    self setscriptablepartstate( "juggernaut", "neutral", 0 );
    
    if ( isdefined( juggcontext.prevexecution ) )
    {
        execution::_giveexecution( juggcontext.prevexecution );
    }
    
    if ( jugg_canparachute() )
    {
        self skydive_setbasejumpingstatus( 1 );
        self skydive_setdeploymentstatus( 1 );
        self skydive_cutparachuteon();
    }
    else
    {
        self skydive_setbasejumpingstatus( 0 );
        self skydive_setdeploymentstatus( 0 );
        self skydive_cutparachuteoff();
    }
    
    if ( self.var_ae4a9afb559a5d7 )
    {
        self setstance( "stand" );
    }
    
    if ( juggconfig.hidefromcompass )
    {
        function_1883025fa745694e( 0 );
    }
    
    self.isjuggernaut = 0;
    self.juggcontext = undefined;
    self.streakinfo = undefined;
    self.var_ae4a9afb559a5d7 = undefined;
    self.var_e4dae87a649544c3 = 0;
    self.var_abdb15f3972c9de3 = undefined;
    self.streakname = undefined;
    battlechatter_mp::enablebattlechatter( self );
    self notify( #"juggernaut_removed" );
    self.var_56e1683c857afcf5 = undefined;
}

// Namespace juggernaut
// Params 1
// Checksum 0x71b06c7a, Offset: 0x16df
// Size: 0x856
function jugg_createconfig( var_d6a4bf021efe75a4 )
{
    assert( var_d6a4bf021efe75a4 != "<dev string:x24>", "<dev string:x25>" );
    var_52603d9eb229bc67 = getscriptbundle( var_d6a4bf021efe75a4 );
    
    if ( !var_52603d9eb229bc67 )
    {
        assertmsg( "<dev string:x95>" + var_d6a4bf021efe75a4 + "<dev string:xda>" );
        return;
    }
    
    maxhealth = var_52603d9eb229bc67.maxhealth;
    var_40dd8fbc78f5d9dd = var_52603d9eb229bc67.var_5b1467bd0698bffe;
    var_638427060cd39e12 = var_52603d9eb229bc67.var_31e404cf410787cf;
    var_7aab273febb85f8b = var_52603d9eb229bc67.var_efdb7e8dcb14ca84;
    classstruct = class::loadout_getclassstruct();
    classstruct.loadoutarchetype = "archetype_assault";
    classstruct.loadoutprimary = var_52603d9eb229bc67.primaryweapon;
    classstruct.loadoutsecondary = var_52603d9eb229bc67.secondaryweapon;
    
    if ( var_52603d9eb229bc67.fragequipment != "" )
    {
        classstruct.loadoutequipmentprimary = var_52603d9eb229bc67.fragequipment;
    }
    
    if ( var_52603d9eb229bc67.tacticalequipment != "" )
    {
        classstruct.loadoutequipmentsecondary = var_52603d9eb229bc67.tacticalequipment;
    }
    
    restrictions = [ "vehicle_use":var_52603d9eb229bc67.var_43291dd6bfb5afb9, "reload":var_52603d9eb229bc67.restrictreload, "weapon_switch":var_52603d9eb229bc67.restrictweaponswitch, "usability":var_52603d9eb229bc67.restrictusability, "crouch":var_52603d9eb229bc67.restrictcrouch, "sprint":var_52603d9eb229bc67.restrictsprint, "offhand_throwback":var_52603d9eb229bc67.var_51c3e55a45868a05, "cough_gesture":var_52603d9eb229bc67.var_e80b42f41e890c97, "execution_victim":var_52603d9eb229bc67.var_39498a9d7fe1ecf0, "weapon_pickup":var_52603d9eb229bc67.var_71ece0bc9427f026, "slide":var_52603d9eb229bc67.restrictslide, "killstreaks":var_52603d9eb229bc67.restrictkillstreaks, "supers":var_52603d9eb229bc67.restrictsupers, "equipment_secondary":var_52603d9eb229bc67.var_6fed2c8eba36111c, "equipment_primary":var_52603d9eb229bc67.var_ff329951b901c384, "prone":var_52603d9eb229bc67.restrictprone, "stunned":var_52603d9eb229bc67.restrictstunned, "flashed":var_52603d9eb229bc67.restrictflashed, "one_hit_melee_victim":var_52603d9eb229bc67.var_228e93289066551d, "health_regen":var_52603d9eb229bc67.var_41dab4032e3e8871, "stick_kill":var_52603d9eb229bc67.var_73fc200131e52e ];
    perks = [];
    
    foreach ( perkentry in var_52603d9eb229bc67.perks )
    {
        if ( perkentry.name )
        {
            perks[ perkentry.name ] = 1;
        }
    }
    
    executionlist = [];
    
    foreach ( entry in var_52603d9eb229bc67.executionlist )
    {
        if ( entry.name )
        {
            executionlist[ executionlist.size ] = entry.name;
        }
    }
    
    torsohealth = maxhealth * var_638427060cd39e12;
    limbhealth = maxhealth * var_7aab273febb85f8b;
    var_cada3a2b875f08a2 = [];
    
    foreach ( entry in var_52603d9eb229bc67.var_cada3a2b875f08a2 )
    {
        if ( entry.cratetype )
        {
            var_cada3a2b875f08a2[ var_cada3a2b875f08a2.size ] = entry.cratetype;
        }
    }
    
    return { #var_cada3a2b875f08a2:var_cada3a2b875f08a2, #var_ba6105707f7b0cf3:var_52603d9eb229bc67.var_ba6105707f7b0cf3, #restrictweapondrop:var_52603d9eb229bc67.restrictweapondrop, #getminigunweaponfunc:&jugg_getminigunweapon, #var_3f061c9040e10c3:var_52603d9eb229bc67.var_3f061c9040e10c3, #var_e95f37a68ea62dea:var_52603d9eb229bc67.var_e95f37a68ea62dea, #hidefromcompass:var_52603d9eb229bc67.hidefromcompass, #useweaponpickups:var_52603d9eb229bc67.useweaponpickups, #usereload:var_52603d9eb229bc67.usereload, #executionlist:executionlist, #perks:perks, #clearperks:var_52603d9eb229bc67.clearperks, #restrictions:restrictions, #classstruct:classstruct, #left_leg_health:limbhealth, #right_leg_health:limbhealth, #left_lower_arm_health:limbhealth, #left_upper_arm_health:limbhealth, #right_lower_arm_health:limbhealth, #right_upper_arm_health:limbhealth, #torso_lower_health:torsohealth, #torso_upper_health:torsohealth, #head_health:maxhealth * var_40dd8fbc78f5d9dd, #var_9a10c0470657316c:var_52603d9eb229bc67.var_9a10c0470657316c, #var_4fabfc606c18a589:var_52603d9eb229bc67.var_4fabfc606c18a589, #var_c8529f1600572acc:var_52603d9eb229bc67.var_c8529f1600572acc, #deployweapon:var_52603d9eb229bc67.deployweapon, #execution:var_52603d9eb229bc67.execution, #airdropasset:var_52603d9eb229bc67.airdropasset, #viewmodel:var_52603d9eb229bc67.viewmodel, #headmodel:var_52603d9eb229bc67.headmodel, #bodymodel:var_52603d9eb229bc67.bodymodel, #var_753a26cb97003ff5:var_52603d9eb229bc67.var_753a26cb97003ff5, #var_8fe0df29471119b7:var_52603d9eb229bc67.var_8fe0df29471119b7, #var_9edcca6343f41f5b:var_52603d9eb229bc67.var_9edcca6343f41f5b, #usearmorparts:var_52603d9eb229bc67.usearmorparts, #infiniteammoupdaterate:var_52603d9eb229bc67.infiniteammoupdaterate, #infiniteammo:var_52603d9eb229bc67.infiniteammo, #geartype:var_52603d9eb229bc67.geartype, #clothtype:var_52603d9eb229bc67.clothtype, #suit:var_52603d9eb229bc67.suit, #ignorearmor:var_52603d9eb229bc67.ignorearmor, #disableparachute:var_52603d9eb229bc67.disableparachute, #removeondeath:var_52603d9eb229bc67.removeondeath, #duration:var_52603d9eb229bc67.duration, #var_fff143d4ef0c953a:var_52603d9eb229bc67.var_fff143d4ef0c953a, #var_427f85121d30680:var_52603d9eb229bc67.var_427f85121d30680, #var_b1c1dbddf650e1a1:var_52603d9eb229bc67.var_b1c1dbddf650e1a1, #var_bb1e3e93f17620c:var_52603d9eb229bc67.var_bb1e3e93f17620c, #forcetostand:var_52603d9eb229bc67.forcetostand, #var_5e3298d5f5ff231f:var_52603d9eb229bc67.var_5e3298d5f5ff231f, #maxvehicledamagedivisor:isbrgamemode() ? 3 : 5, #movespeedscalar:var_52603d9eb229bc67.movespeedscalar, #startinghealth:maxhealth, #maxhealth:maxhealth };
}

// Namespace juggernaut
// Params 2
// Checksum 0xd54187a9, Offset: 0x1f3e
// Size: 0xdf
function function_27df84092e4f76b9( restrictions, activate )
{
    if ( activate )
    {
        foreach ( allow_name, active in restrictions )
        {
            if ( active )
            {
                allow_name = tolower( allow_name );
                val::set( "juggernaut", allow_name, 0 );
            }
        }
        
        if ( !level.disablemount )
        {
            val::set( "juggernaut", "mount_top", 0 );
            val::set( "juggernaut", "mount_side", 0 );
        }
        
        return;
    }
    
    val::reset_all( "juggernaut" );
}

// Namespace juggernaut
// Params 2
// Checksum 0x7ccc98c0, Offset: 0x2025
// Size: 0x226
function jugg_watchmusictoggle( var_c8529f1600572acc, streakname )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"juggernaut_end" );
    
    if ( !isbot( self ) && !isagent( self ) )
    {
        self notifyonplayercommand( "toggle_music", "+actionslot 3" );
        self notifyonplayercommand( "toggle_music", "killstreak_wheel" );
    }
    
    var_8391da3cc33af9d9 = makeweapon( var_c8529f1600572acc );
    
    if ( !isdefined( self.musicplaying ) )
    {
        var_c2b45fbc9555cc45 = self getjuggdefaultmusicenabled();
        self.musicplaying = var_c2b45fbc9555cc45;
    }
    
    if ( !self.musicplaying )
    {
        self setscriptablepartstate( "juggernaut", "neutral", 0 );
    }
    else if ( streakname == "juggernaut_recon" )
    {
        self setscriptablepartstate( "juggernaut", "music_recon", 0 );
    }
    else if ( level.music_style == "mexico" )
    {
        self setscriptablepartstate( "juggernaut", "music_mx", 0 );
    }
    else
    {
        self setscriptablepartstate( "juggernaut", "music", 0 );
    }
    
    if ( game_utility_mp::isjuggermoshgamemode() )
    {
        self setscriptablepartstate( "juggernaut", "neutral", 0 );
    }
    
    while ( true )
    {
        self waittill( #"toggle_music" );
        
        if ( game_utility_mp::isjuggermoshgamemode() )
        {
            continue;
        }
        
        if ( self isonladder() || self ismantling() )
        {
            continue;
        }
        
        self giveandfireoffhand( var_8391da3cc33af9d9 );
        self playsoundonmovingent( "mp_jugg_mus_toggle_foley" );
        self playlocalsound( "mp_jugg_mus_toggle_button" );
        var_4a3b9ad64bedcb50 = 0.2;
        
        if ( self.musicplaying )
        {
            var_4a3b9ad64bedcb50 = 0.65;
        }
        
        hostmigration::waitlongdurationwithpause( var_4a3b9ad64bedcb50 );
        
        if ( self.musicplaying )
        {
            self.musicplaying = 0;
            self setscriptablepartstate( "juggernaut", "neutral", 0 );
        }
        else
        {
            self.musicplaying = 1;
            
            if ( streakname == "juggernaut_recon" )
            {
                self setscriptablepartstate( "juggernaut", "music_recon", 0 );
            }
            else
            {
                self setscriptablepartstate( "juggernaut", "music", 0 );
            }
        }
        
        hostmigration::waitlongdurationwithpause( 1.5 );
    }
}

// Namespace juggernaut
// Params 0
// Checksum 0x4abc4d5e, Offset: 0x2253
// Size: 0x9f
function jugg_watchfordeath()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self waittill( #"death" );
    
    if ( isdefined( self.juggcontext ) )
    {
        var_ba6105707f7b0cf3 = self.juggcontext.juggconfig.var_ba6105707f7b0cf3;
        
        if ( var_ba6105707f7b0cf3.size > 0 && common_item::items_isenabled() )
        {
            spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
            spawnoptions.isdeathevent = 1;
            thread function_99994079f0a3c411( var_ba6105707f7b0cf3, spawnoptions );
        }
        
        childthread jugg_removejuggernaut();
    }
}

// Namespace juggernaut
// Params 2
// Checksum 0xf7068ca5, Offset: 0x22fa
// Size: 0xc8
function function_99994079f0a3c411( var_ba6105707f7b0cf3, spawnoptions )
{
    foreach ( entry in var_ba6105707f7b0cf3 )
    {
        if ( entry.bundlename )
        {
            count = entry.var_a285dc739e43a85d ? undefined : entry.count;
            common_item::function_61c2c0251e742ffd( entry.bundlename, count, spawnoptions );
        }
    }
}

// Namespace juggernaut
// Params 0
// Checksum 0x39f2af0b, Offset: 0x23ca
// Size: 0x7e
function jugg_watchforgameend()
{
    self endon( #"disconnect" );
    self endon( #"juggernaut_end" );
    juggcontext = self.juggcontext;
    level waittill( #"game_ended" );
    self.maxhealth = juggcontext.prevmaxhealth;
    self.health = juggcontext.prevhealth;
    jugg_disableoverlay( juggcontext );
    self setscriptablepartstate( "juggernaut", "neutral", 0 );
}

// Namespace juggernaut
// Params 0
// Checksum 0xd5df6548, Offset: 0x2450
// Size: 0x5d
function jugg_watchfordisconnect()
{
    self endon( #"juggernaut_end" );
    juggcontext = self.juggcontext;
    self waittill( #"disconnect" );
    
    if ( isdefined( self ) )
    {
        self.maxhealth = juggcontext.prevmaxhealth;
        self.health = juggcontext.prevhealth;
    }
}

// Namespace juggernaut
// Params 0
// Checksum 0xdfe971e8, Offset: 0x24b5
// Size: 0x5b
function jugg_watchforfire()
{
    self endon( #"juggernaut_end" );
    
    while ( true )
    {
        self waittill( #"weapon_fired" );
        
        if ( isdefined( self.streakinfo ) && isdefined( self.streakinfo.shots_fired ) )
        {
            self.streakinfo.shots_fired++;
        }
    }
}

// Namespace juggernaut
// Params 1
// Checksum 0xccb5849f, Offset: 0x2518
// Size: 0x9f
function jugg_getjuggmodels( juggconfig )
{
    models = [];
    assert( isdefined( juggconfig.bodymodel ), "<dev string:xfb>" );
    models[ "body" ] = juggconfig.bodymodel;
    assert( isdefined( juggconfig.headmodel ), "<dev string:x11f>" );
    models[ "head" ] = juggconfig.headmodel;
    assert( isdefined( juggconfig.viewmodel ), "<dev string:x143>" );
    models[ "view" ] = juggconfig.viewmodel;
    return models;
}

// Namespace juggernaut
// Params 1
// Checksum 0x1428e8c0, Offset: 0x25c0
// Size: 0x9e
function jugg_setmodel( juggconfig )
{
    models = jugg_getjuggmodels( juggconfig );
    
    if ( isdefined( self.headmodel ) )
    {
        self detach( self.headmodel );
        self.headmodel = undefined;
    }
    
    bodymodelname = models[ "body" ];
    headmodelname = models[ "head" ];
    viewmodelname = models[ "view" ];
    self setmodel( bodymodelname );
    self setviewmodel( viewmodelname );
    self.var_1b413788c732898 = headmodelname;
    self.var_1817b7dc2c665ed7 = 0;
}

// Namespace juggernaut
// Params 1
// Checksum 0x2b562252, Offset: 0x2666
// Size: 0x60
function jugg_restoremodel( juggcontext )
{
    if ( player::isreallyalive() )
    {
        models = operator::function_fb2ad6ca3c6b708d( juggcontext.prevskin );
        self setoperatorcustomization( juggcontext.prevoperator, juggcontext.prevskin );
        teams::setcharactermodels( models[ 0 ], models[ 1 ], models[ 2 ] );
    }
}

// Namespace juggernaut
// Params 1
// Checksum 0x3741292, Offset: 0x26ce
// Size: 0x19e
function function_185c3871d7f3946c( juggconfig )
{
    validstance = undefined;
    curstance = self getstance();
    
    if ( curstance != "stand" )
    {
        var_657e7ffe33b8d4f1 = !juggconfig.forcetostand && !juggconfig.restrictions[ "crouch" ];
        var_b64b12f21408f6b3 = !juggconfig.forcetostand && !juggconfig.restrictions[ "prone" ];
        contentoverride = trace::create_contents( 0, 1, 1, 1, 0, 0, 1, 1, 0 );
        
        if ( !var_657e7ffe33b8d4f1 && !var_b64b12f21408f6b3 )
        {
            validstance = "stand";
        }
        else if ( curstance == "crouch" )
        {
            if ( !var_657e7ffe33b8d4f1 )
            {
                canstand = trace::ray_trace_passed( self.origin, utility::function_f02ebab438642e16( "stand" ), self, contentoverride );
                
                if ( canstand )
                {
                    validstance = "stand";
                }
            }
            else
            {
                validstance = "crouch";
            }
        }
        else if ( curstance == "prone" )
        {
            if ( !var_b64b12f21408f6b3 )
            {
                if ( var_657e7ffe33b8d4f1 )
                {
                    cancrouch = trace::ray_trace_passed( self.origin, utility::function_f02ebab438642e16( "crouch" ), self, contentoverride );
                    
                    if ( cancrouch )
                    {
                        validstance = "crouch";
                    }
                }
                else
                {
                    canstand = trace::ray_trace_passed( self.origin, utility::function_f02ebab438642e16( "stand" ), self, contentoverride );
                    
                    if ( canstand )
                    {
                        validstance = "stand";
                    }
                }
            }
            else
            {
                validstance = "prone";
            }
        }
    }
    else
    {
        validstance = "stand";
    }
    
    return validstance;
}

// Namespace juggernaut
// Params 0
// Checksum 0xec96c55f, Offset: 0x2875
// Size: 0x71
function function_b5b462df5995d6dc()
{
    self endon( #"juggernaut_end" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    juggcontext = self.juggcontext;
    
    while ( true )
    {
        self waittill( #"remote_enter" );
        jugg_disableoverlay( juggcontext, 1 );
        self waittill( #"remote_exit" );
        jugg_enableoverlay( juggcontext );
    }
}

// Namespace juggernaut
// Params 1
// Checksum 0xea301196, Offset: 0x28ee
// Size: 0x1af
function jugg_watchoverlaydamagestates( juggcontext )
{
    self endon( #"juggernaut_end" );
    self endon( #"hash_a35808f532d8b26c" );
    level endon( #"game_ended" );
    
    if ( game_utility_mp::isjuggermoshgamemode() )
    {
        return;
    }
    
    if ( juggcontext.var_753a26cb97003ff5 )
    {
        return;
    }
    
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
            self setclientomnvar( juggcontext.maskomnvar, overlaystate );
            var_ccc1d6bc36da0c72 = overlaystate;
            self.juggoverlaystatelabel = overlaystatelabel;
            self.juggoverlaystate = overlaystate;
        }
    }
}

// Namespace juggernaut
// Params 0
// Checksum 0x5c6d1559, Offset: 0x2aa5
// Size: 0x9f
function jugg_watchforoverlayexecutiontoggle()
{
    self endon( #"juggernaut_end" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    juggcontext = self.juggcontext;
    var_246218d79105cf24 = 0;
    
    while ( true )
    {
        if ( !self isinexecutionattack() )
        {
            if ( var_246218d79105cf24 )
            {
                jugg_enableoverlay( juggcontext );
                var_246218d79105cf24 = 0;
                
                if ( getdvarint( @"scr_juggernaut_execution", 0 ) )
                {
                    jugg_giveexecution( "random" );
                }
            }
            
            waitframe();
            continue;
        }
        
        if ( !var_246218d79105cf24 )
        {
            jugg_disableoverlay( juggcontext, 1 );
            var_246218d79105cf24 = 1;
        }
        
        waitframe();
    }
}

// Namespace juggernaut
// Params 0, eflags: 0x4
// Checksum 0x51ad58aa, Offset: 0x2b4c
// Size: 0xd4
function private function_4b2056bdef79c513()
{
    juggcontext = self.juggcontext;
    currentexecution = self.juggexecution;
    validexecutions = [];
    
    foreach ( execution in juggcontext.executionlist )
    {
        if ( execution == currentexecution )
        {
            continue;
        }
        
        validexecutions[ validexecutions.size ] = execution;
    }
    
    newexecution = validexecutions[ randomint( validexecutions.size ) ];
    
    if ( !isdefined( newexecution ) )
    {
        newexecution = currentexecution;
    }
    
    return newexecution;
}

// Namespace juggernaut
// Params 1, eflags: 0x4
// Checksum 0xc9409d48, Offset: 0x2c29
// Size: 0x49
function private jugg_giveexecution( executionref )
{
    var_1bd2029bc97634b8 = executionref;
    
    if ( !isdefined( var_1bd2029bc97634b8 ) || executionref == "random" )
    {
        var_1bd2029bc97634b8 = function_4b2056bdef79c513();
    }
    
    execution::_giveexecution( var_1bd2029bc97634b8 );
    self.juggexecution = var_1bd2029bc97634b8;
}

// Namespace juggernaut
// Params 0, eflags: 0x4
// Checksum 0xe3f325d8, Offset: 0x2c7a
// Size: 0xfd
function private jugg_watchswimming()
{
    self endon( #"disconnect" );
    self endon( #"juggernaut_end" );
    config = self.juggcontext.juggconfig;
    swimweapon = config.classstruct.loadoutsecondaryobject;
    inwater = 0;
    
    while ( true )
    {
        if ( self isswimming() )
        {
            if ( !inwater )
            {
                inventory_utility::_giveweapon( swimweapon, undefined, undefined, 1 );
                self switchtoweaponimmediate( swimweapon );
                inwater = 1;
            }
        }
        else if ( inwater )
        {
            if ( utility::issharedfuncdefined( #"hash_e33dbd87afe96e1", #"hash_73b26d8ccf95727c" ) )
            {
                self [[ utility::getsharedfunc( #"hash_e33dbd87afe96e1", #"hash_73b26d8ccf95727c" ) ]]( swimweapon );
                inwater = 0;
                wait 0.05;
                continue;
            }
            
            inventory_utility::_takeweapon( swimweapon );
            self switchtoweaponimmediate( jugg_getminigunweapon() );
            inwater = 0;
        }
        
        wait 0.05;
    }
}

// Namespace juggernaut
// Params 1, eflags: 0x4
// Checksum 0xac9bbb0b, Offset: 0x2d7f
// Size: 0xc5
function private jugg_watchtimeout( juggconfig )
{
    self endon( #"disconnect" );
    self endon( #"juggernaut_end" );
    
    if ( !juggconfig.duration || juggconfig.duration <= 0 )
    {
        return;
    }
    
    self.loadoutfieldupgrade1 = "super_juggernaut";
    thread perkpackage::perkpackage_initperkpackages();
    var_9c3df25ab6a60953 = 0;
    pointsneeded = supers_mp::getsuperpointsneeded();
    
    if ( pointsneeded <= 0 )
    {
        return;
    }
    
    while ( var_9c3df25ab6a60953 < juggconfig.duration )
    {
        var_9c3df25ab6a60953 += 0.1;
        supers_mp::setsuperbasepoints( ( 1 - var_9c3df25ab6a60953 / juggconfig.duration ) * pointsneeded );
        wait 0.1;
    }
    
    thread jugg_removejuggernaut();
}

// Namespace juggernaut
// Params 2, eflags: 0x4
// Checksum 0xd21d2682, Offset: 0x2e4c
// Size: 0xb1
function private jugg_enableoverlay( juggcontext, forcereset )
{
    if ( game_utility_mp::isjuggermoshgamemode() )
    {
        return;
    }
    
    if ( juggcontext.var_753a26cb97003ff5 )
    {
        return;
    }
    
    self notify( #"jugg_mask_on" );
    
    if ( !isdefined( self.juggoverlaystatelabel ) && !isdefined( self.juggoverlaystate ) || forcereset )
    {
        self.juggoverlaystatelabel = "mask_on";
        self.juggoverlaystate = 1;
    }
    
    self setclientomnvar( "ui_assault_suit_on", 0 );
    killstreak_utility::function_d546aaa588f088c3( "juggernaut", self.juggoverlaystatelabel );
    self setclientomnvar( juggcontext.maskomnvar, self.juggoverlaystate );
}

// Namespace juggernaut
// Params 2, eflags: 0x4
// Checksum 0xd46b8706, Offset: 0x2f05
// Size: 0x5e
function private jugg_disableoverlay( juggcontext, retainstate )
{
    self notify( #"jugg_mask_off" );
    
    if ( !retainstate )
    {
        self.juggoverlaystatelabel = undefined;
        self.juggoverlaystate = undefined;
    }
    
    killstreak_utility::function_d546aaa588f088c3( "juggernaut", "off" );
    self setclientomnvar( juggcontext.maskomnvar, 0 );
}

// Namespace juggernaut
// Params 0
// Checksum 0x2433dfd, Offset: 0x2f6b
// Size: 0x7
function jugg_getmovespeedscalar()
{
    return -0.2;
}

// Namespace juggernaut
// Params 0
// Checksum 0xa7f95595, Offset: 0x2f7b
// Size: 0x4a
function jugg_getminigunweapon()
{
    assert( killstreak::isjuggernaut(), "<dev string:x167>" );
    minigunweaponobj = self.juggcontext.juggconfig.classstruct.loadoutprimaryobject;
    return minigunweaponobj;
}

// Namespace juggernaut
// Params 0
// Checksum 0xfcd87194, Offset: 0x2fce
// Size: 0x33, Type: bool
function jugg_canreload()
{
    assert( killstreak::isjuggernaut(), "<dev string:x1c1>" );
    return istrue( self.juggcontext.juggconfig.usereload );
}

// Namespace juggernaut
// Params 0
// Checksum 0xa7a37267, Offset: 0x300a
// Size: 0x33, Type: bool
function jugg_canuseweaponpickups()
{
    assert( killstreak::isjuggernaut(), "<dev string:x210>" );
    return istrue( self.juggcontext.juggconfig.useweaponpickups );
}

// Namespace juggernaut
// Params 1
// Checksum 0xb04e6174, Offset: 0x3046
// Size: 0x95, Type: bool
function function_b9e4bac6cd459601( params )
{
    player = params.player;
    
    if ( player killstreak::isjuggernaut() && !player function_81352964921bb957( params.itemtype ) )
    {
        if ( !params.autouse )
        {
            player utility::callsharedfunc( #"hud", #"showerrormessage", player.juggcontext.var_fa60812bd871fca1 ?? %"killstreaks/jugg_cannot_be_used" );
        }
        
        return false;
    }
    
    return true;
}

// Namespace juggernaut
// Params 1
// Checksum 0x2e283865, Offset: 0x30e4
// Size: 0x6a, Type: bool
function function_e52712e27f816b6a( params )
{
    player = params.player;
    
    if ( player killstreak::isjuggernaut() && player.juggcontext.juggconfig.restrictweapondrop && params.itemtype == "weapon" )
    {
        return false;
    }
    
    return true;
}

// Namespace juggernaut
// Params 1
// Checksum 0x14ecbd54, Offset: 0x3157
// Size: 0x7d
function function_81352964921bb957( itemtype )
{
    assert( killstreak::isjuggernaut(), "<dev string:x275>" );
    
    if ( !self.juggcontext.juggconfig.var_e95f37a68ea62dea )
    {
        return 1;
    }
    
    allowedtypes = self.juggcontext.juggconfig.var_3f061c9040e10c3;
    return function_389a4f515c2668d4( allowedtypes, #itemtype, itemtype );
}

// Namespace juggernaut
// Params 1
// Checksum 0x8dfc6a1d, Offset: 0x31dd
// Size: 0x69
function jugg_managestockammo( weapon )
{
    self endon( #"juggernaut_end" );
    level endon( #"game_ended" );
    stockammo = self getweaponammostock( weapon );
    thread jugg_watchmanualreload( weapon, stockammo );
    thread jugg_watchammo( weapon, stockammo );
    
    while ( true )
    {
        self waittill( #"minigun_restock" );
        self setweaponammostock( weapon, stockammo );
    }
}

// Namespace juggernaut
// Params 2
// Checksum 0xd90df9d5, Offset: 0x324e
// Size: 0x70
function jugg_watchmanualreload( weapon, startingstockammo )
{
    self endon( #"death_or_disconnect" );
    self endon( #"juggernaut_end" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( self reloadbuttonpressed() )
        {
            currentstockammo = self getweaponammostock( weapon );
            
            if ( currentstockammo < startingstockammo )
            {
                self notify( #"minigun_restock" );
            }
        }
        
        waitframe();
    }
}

// Namespace juggernaut
// Params 2
// Checksum 0x200e1fd4, Offset: 0x32c6
// Size: 0x80
function jugg_watchammo( weapon, startingstockammo )
{
    self endon( #"death_or_disconnect" );
    self endon( #"juggernaut_end" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        currentclipammo = self getweaponammoclip( weapon );
        
        if ( currentclipammo == 0 )
        {
            currentstockammo = self getweaponammostock( weapon );
            
            if ( currentstockammo < startingstockammo )
            {
                self notify( #"minigun_restock" );
            }
        }
        
        waitframe();
    }
}

// Namespace juggernaut
// Params 0
// Checksum 0x8ea65ce0, Offset: 0x334e
// Size: 0x35
function jugg_addtoactivejugglist()
{
    if ( !isdefined( level.activejuggernauts ) )
    {
        level.activejuggernauts = [];
    }
    
    level.activejuggernauts[ level.activejuggernauts.size ] = self;
    thread jugg_watchforremovejugg();
}

// Namespace juggernaut
// Params 0
// Checksum 0x76aa9407, Offset: 0x338b
// Size: 0x2f
function jugg_watchforremovejugg()
{
    level endon( #"game_ended" );
    utility::waittill_any_in_array_return_no_endon_death( [ "juggernaut_end", "disconnect" ] );
    jugg_removefromactivejugglist();
}

// Namespace juggernaut
// Params 0
// Checksum 0x71cf7a1f, Offset: 0x33c2
// Size: 0x38
function jugg_removefromactivejugglist()
{
    if ( !isdefined( self ) )
    {
        level.activejuggernauts = function_5713d46873b29625( level.activejuggernauts );
        return;
    }
    
    level.activejuggernauts = arrayremove( level.activejuggernauts, self );
}

// Namespace juggernaut
// Params 0
// Checksum 0x3eb2043, Offset: 0x3402
// Size: 0x101
function jugg_watchherodrop()
{
    self endon( #"death_or_disconnect" );
    self endon( #"juggernaut_end" );
    level endon( #"game_ended" );
    juggconfig = self.juggcontext.juggconfig;
    juggconfig.herodrop = 0;
    
    while ( true )
    {
        thread function_8a5173515fabac1f( juggconfig );
        self waittill( #"hash_76158f9795c6f611" );
        
        if ( !juggconfig.herodrop )
        {
            juggconfig.herodrop = 1;
            self radiusdamage( self.origin, juggconfig.var_b1c1dbddf650e1a1, juggconfig.var_fff143d4ef0c953a, juggconfig.var_427f85121d30680, self, "MOD_CRUSH" );
            thread jugg_setherodropscriptable( juggconfig );
            
            /#
                var_f300e7d108e6c80 = getdvarint( @"hash_13389bb05ec70351", 0 );
                
                if ( var_f300e7d108e6c80 != 0 )
                {
                    function_3659163a6bbb803c( self.origin, juggconfig, var_f300e7d108e6c80 );
                }
            #/
        }
    }
}

/#

    // Namespace juggernaut
    // Params 3
    // Checksum 0xfa861734, Offset: 0x350b
    // Size: 0x292, Type: dev
    function function_3659163a6bbb803c( origin, juggconfig, mode )
    {
        var_50160d6a715578d3 = int( 10 / level.framedurationseconds );
        var_1bb96b93e605ded = 10;
        textzoffset = 10;
        sphere( origin, var_1bb96b93e605ded, ( 1, 0, 0 ), 0, var_50160d6a715578d3 );
        print3d( origin + ( 0, 0, var_1bb96b93e605ded + textzoffset ), "<dev string:x2a8>" + juggconfig.var_fff143d4ef0c953a, ( 1, 0, 0 ), undefined, 1, var_50160d6a715578d3 );
        sphere( origin, juggconfig.var_b1c1dbddf650e1a1, ( 0, 1, 0 ), 0, var_50160d6a715578d3 );
        print3d( origin + ( 0, 0, juggconfig.var_b1c1dbddf650e1a1 + textzoffset ), "<dev string:x2b5>" + juggconfig.var_427f85121d30680, ( 0, 1, 0 ), undefined, 1, var_50160d6a715578d3 );
        
        if ( mode < 2 )
        {
            return;
        }
        
        playermaxhealth = level.playermaxhealth;
        
        if ( juggconfig.var_fff143d4ef0c953a > playermaxhealth && juggconfig.var_427f85121d30680 < playermaxhealth )
        {
            lethalradius = juggconfig.var_b1c1dbddf650e1a1 * ( juggconfig.var_fff143d4ef0c953a - playermaxhealth ) / ( juggconfig.var_fff143d4ef0c953a - juggconfig.var_427f85121d30680 );
            sphere( origin, lethalradius, ( 1, 1, 0 ), 0, var_50160d6a715578d3 );
            print3d( origin + ( 0, 0, lethalradius + textzoffset ), "<dev string:x2c2>" + playermaxhealth + "<dev string:x2e6>", ( 1, 1, 0 ), undefined, 1, var_50160d6a715578d3 );
            
            if ( level.allowarmor )
            {
                maxarmorhealth = getdvarint( @"scr_player_armor_max_health", 150 );
                var_702a5510ce5cd6d5 = playermaxhealth + maxarmorhealth;
                
                if ( juggconfig.var_fff143d4ef0c953a > var_702a5510ce5cd6d5 )
                {
                    var_fd93dc60d48509ec = juggconfig.var_b1c1dbddf650e1a1 * ( juggconfig.var_fff143d4ef0c953a - var_702a5510ce5cd6d5 ) / ( juggconfig.var_fff143d4ef0c953a - juggconfig.var_427f85121d30680 );
                    sphere( origin, var_fd93dc60d48509ec, ( 1, 0.5, 0 ), 0, var_50160d6a715578d3 );
                    print3d( origin + ( 0, 0, var_fd93dc60d48509ec + textzoffset ), "<dev string:x2c2>" + playermaxhealth + "<dev string:x2f9>" + maxarmorhealth + "<dev string:x310>", ( 1, 0.5, 0 ), undefined, 1, var_50160d6a715578d3 );
                }
            }
        }
    }

#/

// Namespace juggernaut
// Params 1
// Checksum 0x781af19a, Offset: 0x37a5
// Size: 0x127
function function_8a5173515fabac1f( juggconfig )
{
    self endon( #"death_or_disconnect" );
    self endon( #"juggernaut_end" );
    self endon( #"hash_76158f9795c6f611" );
    level endon( #"game_ended" );
    droploop = 0;
    var_6db36452433e1d8 = 0.5;
    delaycounter = var_6db36452433e1d8;
    var_41652c8314b5014d = getdvarfloat( @"bg_falldamageminheight" );
    
    if ( !isdefined( var_41652c8314b5014d ) )
    {
        var_41652c8314b5014d = 225;
    }
    
    while ( true )
    {
        if ( function_9ec28edb5ed47500() )
        {
            delaycounter -= level.framedurationseconds;
            
            if ( delaycounter <= 0 )
            {
                delaycounter = 0;
                
                if ( !droploop )
                {
                    var_5af4a1560001bee = trace::ray_trace_passed( self.origin, self.origin - ( 0, 0, var_41652c8314b5014d ), self );
                    
                    if ( var_5af4a1560001bee )
                    {
                        droploop = 1;
                        self setscriptablepartstate( "heroDiveVfx", "falling", 0 );
                    }
                }
            }
        }
        else if ( droploop && !juggconfig.herodrop )
        {
            droploop = 0;
            delaycounter = var_6db36452433e1d8;
            self setscriptablepartstate( "heroDiveVfx", "off", 0 );
        }
        
        waitframe();
    }
}

// Namespace juggernaut
// Params 0
// Checksum 0xab281a74, Offset: 0x38d4
// Size: 0x44, Type: bool
function function_9ec28edb5ed47500()
{
    if ( self ismantling() )
    {
        return false;
    }
    
    if ( self isonladder() )
    {
        return false;
    }
    
    if ( vehicle::is_in_vehicle( 1 ) )
    {
        return false;
    }
    
    if ( !self isonground() )
    {
        if ( self isparachuting() )
        {
            return false;
        }
        
        if ( self isswimming() )
        {
            return false;
        }
        
        return true;
    }
    
    return false;
}

// Namespace juggernaut
// Params 1
// Checksum 0x2c2ea3e7, Offset: 0x3921
// Size: 0x62
function jugg_setherodropscriptable( juggconfig )
{
    self endon( #"death_or_disconnect" );
    self endon( #"juggernaut_end" );
    level endon( #"game_ended" );
    self setscriptablepartstate( "heroDiveVfx", "impact", 0 );
    wait 1;
    self setscriptablepartstate( "heroDiveVfx", "off", 0 );
    juggconfig.herodrop = 0;
}

// Namespace juggernaut
// Params 2
// Checksum 0xa30c4f83, Offset: 0x398b
// Size: 0xc0
function jugg_modifyvehicletoplayerdamage( originaldamage, meansofdeath )
{
    maxhealth = self.maxhealth;
    config = self.juggcontext.juggconfig;
    damagescale = 0.5;
    var_8f524e4148c52a04 = 10;
    
    if ( isexplosivedamagemod( meansofdeath ) )
    {
        damagescale = config.var_5e3298d5f5ff231f;
        var_8f524e4148c52a04 = config.maxvehicledamagedivisor;
    }
    
    vehicledamage = originaldamage * damagescale;
    maxvehicledamage = maxhealth / var_8f524e4148c52a04;
    modifieddamage = int( ceil( min( maxvehicledamage, vehicledamage ) ) );
    return int( modifieddamage );
}

// Namespace juggernaut
// Params 1
// Checksum 0xbe792c23, Offset: 0x3a54
// Size: 0x15
function jugg_modifyherodroptoplayerdamage( originaldamage )
{
    return int( originaldamage / 2 );
}

// Namespace juggernaut
// Params 1
// Checksum 0xaa4337dd, Offset: 0x3a72
// Size: 0x3e
function function_9d3c45be0af60321( originaldamage )
{
    gasdamagescale = getdvarfloat( @"hash_8fe3d1bd14559be", 7 );
    modifieddamage = originaldamage * gasdamagescale;
    return int( modifieddamage );
}

// Namespace juggernaut
// Params 0
// Checksum 0xcf9bfee2, Offset: 0x3ab9
// Size: 0x69
function jugg_canparachute()
{
    canparachute = 0;
    parachuteeverywhere = 0;
    
    /#
        parachuteeverywhere = getdvarint( @"hash_174506584f9d388e", 0 ) == 1;
    #/
    
    if ( isusingmatchrulesdata() && getmatchrulesdata( "commonOption", "allowParachute" ) || parachuteeverywhere || game_utility_mp::gametypesupportsbasejumping() && game_utility_mp::mapsupportsbasejumping() )
    {
        canparachute = 1;
    }
    
    return canparachute;
}

// Namespace juggernaut
// Params 2
// Checksum 0x43d63457, Offset: 0x3b2b
// Size: 0xed
function function_a1a46c7474f6db81( parts, state )
{
    if ( !isdefined( state ) )
    {
        assertmsg( "<dev string:x318>" );
        return;
    }
    
    partstoset = [];
    
    if ( isarray( parts ) )
    {
        partstoset = arraycombine( partstoset, parts );
    }
    else
    {
        partstoset[ partstoset.size ] = parts;
    }
    
    foreach ( part in partstoset )
    {
        self setscriptablepartstate( part, state, 0 );
        
        /#
            iprintln( "<dev string:x33d>" + part + "<dev string:x346>" + state + "<dev string:x352>" );
        #/
    }
    
    function_2d452e35800a1a3a();
}

// Namespace juggernaut
// Params 0
// Checksum 0xc76d2113, Offset: 0x3c20
// Size: 0x7d
function function_2d452e35800a1a3a()
{
    if ( isdefined( self.var_1b413788c732898 ) && !self.var_1817b7dc2c665ed7 )
    {
        helmetstate = self getscriptablepartstate( #"helmet", 1, 1 );
        
        if ( helmetstate == #"off" )
        {
            self attach( self.var_1b413788c732898, "", 1 );
            self.headmodel = self.var_1b413788c732898;
            self.var_1817b7dc2c665ed7 = 1;
        }
    }
}

// Namespace juggernaut
// Params 4
// Checksum 0xebace121, Offset: 0x3ca5
// Size: 0x71
function function_28d6476ed9716980( damage, shitloc, smeansofdeath, attacker )
{
    var_e628984c7b8aa67f = function_8c0aff960ae4974b( shitloc, smeansofdeath, attacker );
    
    if ( !isdefined( var_e628984c7b8aa67f ) )
    {
        if ( isdefined( shitloc ) && isplayer( attacker ) )
        {
            /#
                attacker iprintln( "<dev string:x354>" + shitloc );
            #/
        }
        
        return;
    }
    
    function_cf5590a521e82ab8( var_e628984c7b8aa67f, damage );
}

// Namespace juggernaut
// Params 3
// Checksum 0xd169e671, Offset: 0x3d1e
// Size: 0x12c
function function_8c0aff960ae4974b( shitloc, smeansofdeath, attacker )
{
    var_e628984c7b8aa67f = undefined;
    
    if ( damage_utility::isheadshot( shitloc, smeansofdeath, attacker ) )
    {
        var_e628984c7b8aa67f = "head_health";
    }
    else if ( damage_utility::istorsouppershot( shitloc, smeansofdeath, attacker ) )
    {
        var_e628984c7b8aa67f = "torso_upper_health";
    }
    else if ( damage_utility::function_fa01c95c6c80017a( shitloc, smeansofdeath, attacker ) )
    {
        var_e628984c7b8aa67f = "torso_lower_health";
    }
    else if ( damage_utility::function_b44f28c3d528a4a( shitloc, smeansofdeath, attacker ) )
    {
        var_e628984c7b8aa67f = "right_upper_arm_health";
    }
    else if ( damage_utility::function_462b5d72062e80c1( shitloc, smeansofdeath, attacker ) )
    {
        var_e628984c7b8aa67f = "right_lower_arm_health";
    }
    else if ( damage_utility::function_389f8e73c452ef7d( shitloc, smeansofdeath, attacker ) )
    {
        var_e628984c7b8aa67f = "left_upper_arm_health";
    }
    else if ( damage_utility::function_b00a5e646e1b246a( shitloc, smeansofdeath, attacker ) )
    {
        var_e628984c7b8aa67f = "left_lower_arm_health";
    }
    else if ( damage_utility::isrightlegshot( shitloc, smeansofdeath, attacker ) )
    {
        var_e628984c7b8aa67f = "right_leg_health";
    }
    else if ( damage_utility::isleftlegshot( shitloc, smeansofdeath, attacker ) )
    {
        var_e628984c7b8aa67f = "left_leg_health";
    }
    
    /#
        if ( 0 && isdefined( shitloc ) && shitloc != "<dev string:x39a>" && isplayer( attacker ) )
        {
            attacker iprintlnbold( "<dev string:x39f>" + shitloc );
        }
    #/
    
    return var_e628984c7b8aa67f;
}

// Namespace juggernaut
// Params 2, eflags: 0x4
// Checksum 0xffe0bfa7, Offset: 0x3e53
// Size: 0x149
function private function_cf5590a521e82ab8( part, damage )
{
    if ( isdefined( self.juggcontext.var_5bd2193fb4972677 ) )
    {
        self [[ self.juggcontext.var_5bd2193fb4972677 ]]( part, damage );
    }
    
    if ( isdefined( self.juggcontext.partshealth[ part ] ) )
    {
        self.juggcontext.partshealth[ part ] -= damage;
        
        if ( part == "head_health" )
        {
            if ( self.juggcontext.partshealth[ part ] <= 0 )
            {
                self.juggcontext.partshealth[ part ] = undefined;
                function_a1a46c7474f6db81( part, "destroyed" );
            }
            else if ( self.juggcontext.partshealth[ part ] <= 50 )
            {
                function_a1a46c7474f6db81( part, "damaged" );
            }
            
            return;
        }
        
        if ( self.juggcontext.partshealth[ part ] <= 0 )
        {
            self.juggcontext.partshealth[ part ] = undefined;
            function_a1a46c7474f6db81( part, "damaged" );
        }
    }
}

// Namespace juggernaut
// Params 1, eflags: 0x4
// Checksum 0x73f7a03a, Offset: 0x3fa4
// Size: 0x76
function private function_3c8f01d47ed64b39( usearmorparts )
{
    self endon( #"death_or_disconnect" );
    self endon( #"juggernaut_end" );
    level endon( #"game_ended" );
    state = usearmorparts ? "pristine" : "off";
    function_a1a46c7474f6db81( level.var_f3f8f12f590587b7, state );
    
    /#
        if ( usearmorparts )
        {
            childthread function_7e6469643a1b0a8a();
            childthread function_3fda38c7b14a7a12();
        }
    #/
}

// Namespace juggernaut
// Params 2, eflags: 0x4
// Checksum 0x43fa9ecd, Offset: 0x4022
// Size: 0x67, Type: bool
function private jugg_isprimaryweapon( config, weaponref )
{
    if ( !isdefined( weaponref ) || weaponref == "none" )
    {
        return false;
    }
    
    if ( weaponref == config.classstruct.loadoutprimary )
    {
        return true;
    }
    
    if ( weaponref == config.classstruct.loadoutsecondary )
    {
        return true;
    }
    
    return false;
}

// Namespace juggernaut
// Params 1, eflags: 0x4
// Checksum 0x63369659, Offset: 0x4092
// Size: 0x2c
function private function_1883025fa745694e( shouldhide )
{
    self setplayerghost( shouldhide );
    self function_e8653d9a87fea503( shouldhide );
    self function_e6b6b477a9f04b4c( shouldhide );
    self function_66dc8b6ae969f66d( shouldhide );
}

/#

    // Namespace juggernaut
    // Params 0, eflags: 0x4
    // Checksum 0x869f8fdf, Offset: 0x40c6
    // Size: 0x373, Type: dev
    function private function_7e6469643a1b0a8a()
    {
        juggcontext = self.juggcontext;
        juggconfig = juggcontext.juggconfig;
        
        while ( true )
        {
            armorstateindex = getdvarint( @"hash_63bf655a03b825eb", 0 );
            
            if ( !armorstateindex )
            {
                waitframe();
                continue;
            }
            
            armorstate = function_b50d287479c3163a( armorstateindex - 1 );
            var_7fc8dc350f8c45b6 = "<dev string:x3b6>";
            var_2a9e5e314711487c = armorstate;
            
            if ( armorstate == "<dev string:x3c2>" )
            {
                var_2a9e5e314711487c = "<dev string:x3ca>";
            }
            
            function_a1a46c7474f6db81( var_7fc8dc350f8c45b6, var_2a9e5e314711487c );
            helmetpart = "<dev string:x3d4>";
            var_1e43e0ce271670d3 = armorstate;
            
            if ( armorstate == "<dev string:x3c2>" )
            {
                var_1e43e0ce271670d3 = "<dev string:x3db>";
            }
            
            function_a1a46c7474f6db81( helmetpart, var_1e43e0ce271670d3 );
            partstoset = [ "<dev string:x3df>", "<dev string:x3f2>", "<dev string:x405>", "<dev string:x41c>", "<dev string:x433>", "<dev string:x449>", "<dev string:x45f>", "<dev string:x470>", "<dev string:x480>", "<dev string:x48a>", "<dev string:x493>", "<dev string:x4a1>", "<dev string:x4af>", "<dev string:x4bc>", "<dev string:x4c9>", "<dev string:x4cf>", "<dev string:x4da>" ];
            function_a1a46c7474f6db81( partstoset, armorstate );
            
            if ( armorstate == "<dev string:x4e5>" )
            {
                juggcontext.partshealth[ "<dev string:x3b6>" ] = juggconfig.head_health ?? 100;
                juggcontext.partshealth[ "<dev string:x3df>" ] = juggconfig.torso_upper_health ?? 100;
                juggcontext.partshealth[ "<dev string:x3f2>" ] = juggconfig.torso_lower_health ?? 100;
                juggcontext.partshealth[ "<dev string:x405>" ] = juggconfig.right_upper_arm_health ?? 100;
                juggcontext.partshealth[ "<dev string:x41c>" ] = juggconfig.right_lower_arm_health ?? 100;
                juggcontext.partshealth[ "<dev string:x433>" ] = juggconfig.left_upper_arm_health ?? 100;
                juggcontext.partshealth[ "<dev string:x449>" ] = juggconfig.left_lower_arm_health ?? 100;
                juggcontext.partshealth[ "<dev string:x45f>" ] = juggconfig.right_leg_health ?? 100;
                juggcontext.partshealth[ "<dev string:x470>" ] = juggconfig.left_leg_health ?? 100;
            }
            else
            {
                juggcontext.partshealth[ "<dev string:x3b6>" ] = undefined;
                juggcontext.partshealth[ "<dev string:x3df>" ] = undefined;
                juggcontext.partshealth[ "<dev string:x3f2>" ] = undefined;
                juggcontext.partshealth[ "<dev string:x405>" ] = undefined;
                juggcontext.partshealth[ "<dev string:x41c>" ] = undefined;
                juggcontext.partshealth[ "<dev string:x433>" ] = undefined;
                juggcontext.partshealth[ "<dev string:x449>" ] = undefined;
                juggcontext.partshealth[ "<dev string:x45f>" ] = undefined;
                juggcontext.partshealth[ "<dev string:x470>" ] = undefined;
            }
            
            setdvar( @"hash_63bf655a03b825eb", 0 );
            waitframe();
        }
    }

    // Namespace juggernaut
    // Params 0, eflags: 0x4
    // Checksum 0x41b40a66, Offset: 0x4441
    // Size: 0x9d, Type: dev
    function private function_3fda38c7b14a7a12()
    {
        armorstate = "<dev string:x4e5>";
        
        while ( true )
        {
            var_72005004a23319a4 = getdvarint( @"hash_ae2c4f86ffaf24db", 0 );
            
            if ( !var_72005004a23319a4 )
            {
                waitframe();
                continue;
            }
            
            armorpart = function_2a6ba2177986290( var_72005004a23319a4 - 1 );
            
            if ( armorstate == "<dev string:x4e5>" )
            {
                armorstate = "<dev string:x3c2>";
                
                if ( armorpart == "<dev string:x3d4>" )
                {
                    armorstate = "<dev string:x3db>";
                }
            }
            else
            {
                armorstate = "<dev string:x4e5>";
            }
            
            function_a1a46c7474f6db81( armorpart, armorstate );
            setdvar( @"hash_ae2c4f86ffaf24db", 0 );
            waitframe();
        }
    }

    // Namespace juggernaut
    // Params 1, eflags: 0x4
    // Checksum 0x9a06c39d, Offset: 0x44e6
    // Size: 0x1c, Type: dev
    function private function_b50d287479c3163a( index )
    {
        return level.var_c136dbcee5b9ac85[ index ];
    }

    // Namespace juggernaut
    // Params 1, eflags: 0x4
    // Checksum 0x3fa602e4, Offset: 0x450a
    // Size: 0x1c, Type: dev
    function private function_2a6ba2177986290( index )
    {
        return level.var_f3f8f12f590587b7[ index ];
    }

#/
