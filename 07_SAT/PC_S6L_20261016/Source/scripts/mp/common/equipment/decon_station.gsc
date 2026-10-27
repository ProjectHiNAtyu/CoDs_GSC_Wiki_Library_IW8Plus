// scripts\mp\common\equipment\decon_station.gsc  (hash_28ef0c13e4e6b6c5.gscc) (size: 23301 Bytes / 0x5b05 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb59d0197 (3046965655)
// size ...... 23301 (0x5b05)
// includes .. 37  (offset: 0x5601)
// strings ... 60  (offset: 0x5729)
// dev strs .. 8   (offset: 0x5a8d)
// exports ... 64  (offset: 0x32b1)
// cseg ...... 0x4d0 + 0x2de1 (0x32b1)
// imports ... 215 (offset: 0x3cb1)
// animtree1 . 0   (offset: 0x5af5)
// animtree2 . 1   (offset: 0x5af5)
#using script_16ea1b94f0f381b3;
#using scripts\common\ae_utility;
#using scripts\common\gasmask;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\common\weapon;
#using scripts\mp\analyticslog;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_default_inventory;
#using scripts\mp\br\gametypes\br_deployable_kiosk;
#using scripts\mp\br\gametypes\br_dev;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\challenges;
#using scripts\mp\common\killstreaks\white_phosphorus;
#using scripts\mp\common\perks\perk_equipmentping;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\print;
#using scripts\mp\common\utility\teams;
#using scripts\mp\damage;
#using scripts\mp\emp_debuff;
#using scripts\mp\ent_manager;
#using scripts\mp\entityheadicons;
#using scripts\mp\equipment_interact;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_super;
#using scripts\mp\loot\common_kiosk;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\supers;
#using scripts\mp\weapons;

#namespace decon_station;

// Namespace decon_station
// Params 0, eflags: 0x1
// Checksum 0xac71233a, Offset: 0x4ee
// Size: 0xa
function autoexec main()
{
    level thread init_deconstation();
}

// Namespace decon_station
// Params 0
// Checksum 0xa6089b01, Offset: 0x500
// Size: 0xba
function init_deconstation()
{
    level endon( #"game_ended" );
    level waittill( #"init_supers" );
    utility::registersharedfunc( #"decon_station", #"grenadeused", &deconstation_deploy );
    supers_mp::function_48aaa60b2ce7b8a1( "super_decon_station", undefined, undefined, undefined, undefined, undefined, undefined, undefined, &deconstation_reclaim, &supers_mp::function_484ca0a545e40e20 );
    utility::registersharedfunc( "super_decon_station", #"getammo", &function_2adb938ed8bf5b64 );
    utility::registersharedfunc( "super_decon_station", #"setammo", &function_c56aed4d0e3c8fa8 );
    function_f989d206d822a8f9();
    level thread function_be38710c6b384ad9();
    level thread function_bcd905863699e059();
    level._effect[ "vfx_br_decontamination_station_circle_aura" ] = loadfxasset( "vfx_iw8_br_island_equip_decon_br3_aura" );
}

// Namespace decon_station
// Params 1
// Checksum 0x4050b146, Offset: 0x5c2
// Size: 0xa8, Type: bool
function deconstation_reclaim( super )
{
    superowner = super.owner;
    superowner supers_mp::function_8cb3b4861e05f17( super.superref, super.ammo, undefined );
    superowner br_pickups::forcegivesuper( "super_decon_station", 1, 0, 0, 0 );
    super supers_mp::function_e2c263f3ee5d2d92( super.damagetaken, level.decon_station.idle_lifetime, super.ammo );
    level thread common_item::function_e8dfe5e68a7a03b4( superowner, supers_mp::function_5ffd3dfa9cc1e8de( "super_decon_station" ) );
    super thread function_f622ffd10c52f6e7();
    return true;
}

// Namespace decon_station
// Params 0
// Checksum 0xa482e981, Offset: 0x673
// Size: 0x216
function function_f989d206d822a8f9()
{
    if ( !isdefined( level.decon_station ) )
    {
        level.decon_station = spawnstruct();
        level.decon_station.instances = [];
        level.decon_station.tracked_loot = [];
    }
    
    level.decon_station.idle_lifetime = getdvarfloat( @"scr_decon_station_idle_lifetime", 180 );
    level.decon_station.max_active_lifetime = getdvarfloat( @"scr_decon_station_lifetime", 15 );
    level.decon_station.min_active_lifetime = getdvarfloat( @"hash_1a5d6dc2676025fa", 7.5 );
    level.decon_station.active_lifetime = level.decon_station.max_active_lifetime;
    level.decon_station.pct = 100;
    level.decon_station.var_e6550c205b3c5c5f = getdvarfloat( @"hash_2dfdd17871783bdd", 2 );
    level.decon_station.var_648b25b27aba60f8 = getdvarfloat( @"hash_e9c9b712bb876886", 1 );
    level.decon_station.visibility_delay = getdvarfloat( @"scr_decon_station_visibility_delay", 0.1 );
    level.decon_station.infinite_ammo = getdvarint( @"scr_decon_station_infinite_ammo", 0 );
    level.decon_station.aura_enabled = getdvarint( @"scr_decon_station_aura_enabled", 1 );
    level.decon_station.height = getdvarint( @"scr_decon_station_height", 500 );
    level.decon_station.radius = getdvarint( @"scr_decon_station_radius", 250 );
    level.decon_station.radius_sq = squared( level.decon_station.radius );
}

// Namespace decon_station
// Params 0
// Checksum 0x7291c96e, Offset: 0x891
// Size: 0x4d
function function_bcd905863699e059()
{
    level endon( #"game_ended" );
    level waittill( #"hash_e80a8aa24006069e" );
    level.decon_station.loot_id = loot::function_d3e3bcaea591a6a2( "brloot_offhand_deconstation" );
    br_pickups::registerpickupcreatedcallback( "brloot_offhand_deconstation", &deconstation_onpickupcreated, 1 );
}

/#

    // Namespace decon_station
    // Params 0
    // Checksum 0x678a97ac, Offset: 0x8e6
    // Size: 0x26, Type: dev
    function update_dvars()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            function_f989d206d822a8f9();
            wait 1;
        }
    }

#/

// Namespace decon_station
// Params 0
// Checksum 0xb9cef150, Offset: 0x914
// Size: 0x39a
function function_be38710c6b384ad9()
{
    level endon( #"game_ended" );
    utility::flag_wait( "onStartGameTypeFinished" );
    
    if ( level.br_circle_disabled || !isdefined( level.br_level.br_circleclosetimes ) )
    {
        return;
    }
    
    num_circles = level.br_level.br_circleclosetimes.size;
    level.decon_station.var_6cd8f24e33adaba0 = num_circles - level.decon_station.var_e6550c205b3c5c5f;
    level.decon_station.var_8727f52dc6bded31 = num_circles - level.decon_station.var_648b25b27aba60f8;
    diff = level.decon_station.var_8727f52dc6bded31 - level.decon_station.var_6cd8f24e33adaba0;
    
    for ( ;; )
    {
        level waittill( #"br_circle_set" );
        
        if ( level.br_circle.circleindex < level.decon_station.var_6cd8f24e33adaba0 )
        {
            continue;
        }
        
        current_circle = level.br_circle.circleindex + 1;
        t = clamp( ( current_circle - level.decon_station.var_6cd8f24e33adaba0 ) / diff, 0, 1 );
        level.decon_station.active_lifetime = math::lerp( level.decon_station.max_active_lifetime, level.decon_station.min_active_lifetime, t );
        level.decon_station.pct = int( level.decon_station.active_lifetime / level.decon_station.max_active_lifetime * 100 );
        
        foreach ( player in level.players )
        {
            player function_daf5c59f10789dcb( level.decon_station.pct );
            super = player supers_mp::getcurrentsuper();
            
            if ( isdefined( super ) && super.staticdata.ref == "super_decon_station" )
            {
                player supers_mp::function_b8c330b10d1729bb( level.decon_station.pct, "all" );
                player item_super::function_4c6bf43db9f13d3d();
            }
        }
        
        level.decon_station.tracked_loot = function_5713d46873b29625( level.decon_station.tracked_loot );
        
        foreach ( loot in level.decon_station.tracked_loot )
        {
            common_item::items_setitemcount( loot, level.decon_station.pct );
        }
    }
}

// Namespace decon_station
// Params 1
// Checksum 0x42974268, Offset: 0xcb6
// Size: 0xbc
function function_daf5c59f10789dcb( newhealth )
{
    var_e768d4a656ca04a0 = [];
    var_e768d4a656ca04a0 = br_default_inventory::function_8ca9685ec86d37c1( [ level.decon_station.loot_id ] );
    
    foreach ( index in var_e768d4a656ca04a0 )
    {
        br_default_inventory::function_d625d28b11a26654( self, index, int( min( br_default_inventory::getquantityatbackpackindex( index ), newhealth ) ) );
    }
}

// Namespace decon_station
// Params 0
// Checksum 0xb55f7499, Offset: 0xd7a
// Size: 0x47
function deconstation_onpickupcreated()
{
    level.decon_station.tracked_loot[ level.decon_station.tracked_loot.size ] = self;
    common_item::items_setitemcount( self, level.decon_station.pct );
}

// Namespace decon_station
// Params 1
// Checksum 0x21995942, Offset: 0xdc9
// Size: 0x17
function function_c56aed4d0e3c8fa8( pct )
{
    self.decon_station_ammo = pct;
}

// Namespace decon_station
// Params 0
// Checksum 0xb208e18a, Offset: 0xde8
// Size: 0xb
function function_2adb938ed8bf5b64()
{
    return self.decon_station_ammo;
}

// Namespace decon_station
// Params 0
// Checksum 0xcb130ddb, Offset: 0xdfc
// Size: 0xb
function deconstation_entmanagerdelete()
{
    deconstation_destroyequipment( undefined, 0 );
}

// Namespace decon_station
// Params 0
// Checksum 0x61d34f14, Offset: 0xe0f
// Size: 0xb
function function_e3b3028a1ea5a8d7()
{
    deconstation_destroyequipment( undefined, 0 );
}

// Namespace decon_station
// Params 1
// Checksum 0xc5654552, Offset: 0xe22
// Size: 0x356
function deconstation_deploy( instance )
{
    level endon( #"game_ended" );
    instance endon( #"death" );
    self endon( #"disconnect" );
    instance.owner = self;
    instance setotherent( instance.owner );
    instance setnodeploy( 1 );
    instance.issuper = isdefined( instance.owner.super ) && instance.owner.super.staticdata.weapon == "decon_station_mp" || utility::callsharedfunc( #"game", #"isCommonItemEnabled" );
    instance.superid = level.superglobals.staticsuperdata[ "super_decon_station" ].id;
    instance.usedcount = 0;
    instance.deploytime = gettime();
    instance.playersaffected = [];
    instance.kiosksaffected = [];
    instance ent_manager::registerspawn( 2, &deconstation_entmanagerdelete );
    instance thread function_fa3e854b8fe45471();
    instance thread function_e59338d1d6b102c8();
    thread function_9a543f24de548357();
    instance thread function_a0f730f0f33af72c( instance.owner );
    instance waittill( #"missile_stuck", stuckto );
    
    if ( level.gameended )
    {
        instance thread deconstation_destroyequipment( undefined, 0, 0 );
        return;
    }
    
    instance.owner thread weapons::monitordisownedgrenade( instance.owner, instance );
    
    /#
        print::printgameaction( "<dev string:x24>", self );
    #/
    
    instance.owner weapons::onequipmentplanted( instance, "equip_decon_station", &function_e3b3028a1ea5a8d7 );
    instance thread weapons::monitordisownedequipment( instance.owner, instance );
    instance sentientpoolmanager::registersentient( "Tactical_Static", instance.owner );
    instance.explosion = deconstation_createexplosion();
    hasrugged = isdefined( instance.owner.perks[ "specialty_rugged_eqp" ] );
    
    if ( hasrugged )
    {
        instance.hasruggedeqp = 1;
    }
    
    maxhealth = hasrugged ? 200 : 100;
    instance.var_736c0b69e68cc5a0 = isdefined( self.perks[ "specialty_mod_rugged_equipment" ] );
    
    if ( isdefined( self.perks[ "specialty_mod_health_max" ] ) )
    {
        maxhealth = instance.var_736c0b69e68cc5a0 ? 200 : 100;
    }
    
    damagefeedback = "hitequip";
    instance thread damage::monitordamage( maxhealth, damagefeedback, &function_2ee373f8020db37c, &function_37b6e7bf20741821, 0 );
    instance emp_debuff::set_apply_emp_callback( &function_d13bd2c5ef8d6f3a );
    instance setscriptablepartstate( "visibility", "show", 0 );
    instance thread deconstation_idle();
    utility::function_969f9f5596dba07a( instance, &deconstation_destroyequipment );
    circle_index = level.br_circle.circleindex ?? -1;
    function_75d47e4aba0e82ad( self, instance.origin, circle_index );
}

// Namespace decon_station
// Params 0
// Checksum 0x40c6b865, Offset: 0x1180
// Size: 0x53
function function_9a543f24de548357()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    while ( self isthrowinggrenade() )
    {
        waitframe();
    }
    
    self.decon_station_ammo = 0;
    
    if ( isbrgamemode() )
    {
        self [[ utility::getsharedfunc( #"player", #"resetsuper" ) ]]();
    }
}

// Namespace decon_station
// Params 0
// Checksum 0x1160484f, Offset: 0x11db
// Size: 0xff
function deconstation_idle()
{
    self endon( #"death" );
    self setscriptablepartstate( "effects", "activeLand" );
    thread deconstation_deployanimation();
    self.owner challenges::function_a0936b0e5b4550f3( "super_decon_station", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"use" ) );
    self.headiconid = entityheadicons::setheadicon_factionimage( 0, 20, undefined, undefined, undefined, undefined, 1 );
    thread weapons::outlineequipmentforowner( self );
    thread function_753950fdb5d1b2f5();
    wait 0.2;
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_decon_station" );
    
    if ( bundle.var_67296742aaa265f9 && !getdvarint( @"hash_325ab39aa939a8c5", 0 ) )
    {
        thread supers_mp::function_24bd67c384c2e606( level.decon_station.idle_lifetime );
        thread supers_mp::function_3a21005bdaf91ac2( bundle );
    }
    
    if ( !function_c554f3ee0083497a() )
    {
        thread function_b15efc409047b0ae();
        self waittill( #"hash_780f63ece8e778ba" );
    }
    
    deconstation_activate();
}

// Namespace decon_station
// Params 0
// Checksum 0xf3e8e27b, Offset: 0x12e2
// Size: 0x4e
function function_b15efc409047b0ae()
{
    self endon( #"death" );
    self endon( #"hash_780f63ece8e778ba" );
    var_2366c8bd76bf8c37 = 0.5;
    
    while ( true )
    {
        wait var_2366c8bd76bf8c37;
        
        if ( function_c554f3ee0083497a() )
        {
            self notify( #"hash_780f63ece8e778ba" );
            break;
        }
    }
}

// Namespace decon_station
// Params 0
// Checksum 0xd0e4ae41, Offset: 0x1338
// Size: 0x173, Type: bool
function function_c554f3ee0083497a()
{
    if ( getdvarint( @"hash_325ab39aa939a8c5", 0 ) )
    {
        return true;
    }
    
    if ( !br_circle_util::function_9c40d80155aa568e( self.origin ) )
    {
        return true;
    }
    else if ( isarray( level.var_9f723c1b2e8c3484 ) && level.var_9f723c1b2e8c3484.size > 0 )
    {
        foreach ( trigger in level.var_9f723c1b2e8c3484 )
        {
            var_6d5baab9981064b5 = trigger.radius ?? 0;
            var_8d8aa787c0f4799b = level.decon_station.radius + var_6d5baab9981064b5;
            distancesq = distancesquared( self.origin, trigger.origin );
            var_d52a8ef7af87eb21 = var_8d8aa787c0f4799b * var_8d8aa787c0f4799b;
            
            if ( distancesq <= var_d52a8ef7af87eb21 )
            {
                return true;
            }
        }
    }
    else if ( !utility::callsharedfunc( #"game", #"isfeaturedisabled", #"hash_5aaafc2b620d773c" ) && br_circle_util::function_4c6afbf2b757376a( self.origin, 1 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace decon_station
// Params 0
// Checksum 0x246e028c, Offset: 0x14b4
// Size: 0x37
function function_753950fdb5d1b2f5()
{
    self endon( #"death" );
    self endon( #"hash_780f63ece8e778ba" );
    wait level.decon_station.idle_lifetime;
    deconstation_destroyequipment( undefined, 0 );
}

// Namespace decon_station
// Params 0
// Checksum 0x72e629bd, Offset: 0x14f3
// Size: 0x277
function deconstation_activate()
{
    self endon( #"death" );
    supers_mp::function_867458c6f9c3d1f5();
    function_6b42bebf16b08b8e();
    wait 0.6;
    self setscriptablepartstate( "effects", "activeSpinStart" );
    self.timestamp_start = gettime();
    self.timestamp_end = gettime() + level.decon_station.active_lifetime * 1000;
    level.decon_station.instances[ level.decon_station.instances.size ] = self;
    trigger = spawn( "trigger_radius", self.origin - ( 0, 0, level.decon_station.height / 2 ), 19, level.decon_station.radius, level.decon_station.height );
    trigger.instance = self;
    trigger enablelinkto();
    trigger linkto( self );
    self.registeredplayers = [];
    trigger thread function_410b237b6a7af9ab( self );
    self.trigger = trigger;
    game_utility::questcircle_create( "DeconStation_Br", self.origin, level.decon_station.radius );
    
    if ( game_utility::questcircle_exists() )
    {
        game_utility::questcircle_hidefromall();
        self.mapcircle linkto( self );
        thread function_3acaca3cacd01b00( level.decon_station.active_lifetime, 5 );
        game_utility::function_5b1f02a1690aa24c( self.team );
    }
    
    self.enemycircle = spawnstruct();
    self.enemycircle game_utility::questcircle_create( "DeconStation_Br_Enemy", self.origin, level.decon_station.radius );
    
    if ( self.enemycircle game_utility::questcircle_exists() )
    {
        self.enemycircle game_utility::questcircle_showtoall();
        self.enemycircle.mapcircle linkto( self );
        self.enemycircle game_utility::function_1f7fc1f084e4ee44( self.team );
    }
    
    thread function_512a005f910667();
    thread function_5843c37208e553fb();
    wait level.decon_station.active_lifetime;
    deconstation_destroyequipment( undefined, 0 );
    function_cd927b844c7008f5();
    thread equipment_interact::remoteinteractsetup( &deconstation_destroyequipment, 1, 1 );
    thread perk_equipmentping::runequipmentping();
}

// Namespace decon_station
// Params 1
// Checksum 0x35b91641, Offset: 0x1772
// Size: 0xc4
function function_d2f80b52d6f42f1( instance )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self notify( #"hash_14abc1dca95dc68d" );
    self endon( #"hash_14abc1dca95dc68d" );
    endon_key = "exit_decon_station_aura" + instance getentitynumber();
    self endon( endon_key );
    function_686dd58fcc3ffb2();
    function_7760346213047ad4();
    
    if ( arraycontains( teams::getteamdata( instance.owner.team, "players" ), self ) && self != instance.owner )
    {
        childthread function_c777811e1050a814( instance );
    }
    
    self waittill( #"death" );
    function_d648e8bf423cd056();
    function_a7ca59455a70eb52();
}

// Namespace decon_station
// Params 1
// Checksum 0x170bae3, Offset: 0x183e
// Size: 0xd1
function function_c777811e1050a814( instance )
{
    if ( !isdefined( instance.var_bb6c7f63d24cf4a0 ) )
    {
        instance.var_bb6c7f63d24cf4a0 = [];
    }
    
    index = self getentitynumber();
    
    if ( !isdefined( instance.var_bb6c7f63d24cf4a0[ index ] ) )
    {
        instance.var_bb6c7f63d24cf4a0[ index ] = 0;
    }
    
    while ( isalive( self ) )
    {
        wait 1;
        instance.var_bb6c7f63d24cf4a0[ index ] += 1;
        
        if ( instance.var_bb6c7f63d24cf4a0[ index ] >= 7.5 && instance.var_bb6c7f63d24cf4a0[ index ] < 8.5 )
        {
            instance.owner thread points::doscoreevent( #"br_pds_assist" );
        }
    }
}

// Namespace decon_station
// Params 1
// Checksum 0x364b03ac, Offset: 0x1917
// Size: 0x37
function function_7a1213d134b7f521( instance )
{
    notify_key = "exit_decon_station_aura" + instance getentitynumber();
    self notify( notify_key );
    function_d648e8bf423cd056();
    function_a7ca59455a70eb52();
}

// Namespace decon_station
// Params 1
// Checksum 0xfc848302, Offset: 0x1956
// Size: 0x243
function function_410b237b6a7af9ab( deconstation )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    deconstation endon( #"death" );
    instance = self.instance;
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        ent_id = ent getentitynumber();
        
        if ( isdefined( instance.registeredplayers[ ent_id ] ) && ent getinairpocket() )
        {
            continue;
        }
        
        if ( !isplayer( ent ) && !ent vehicle::is_vehicle() )
        {
            continue;
        }
        
        if ( ent vehicle::is_vehicle() )
        {
            occupants = vehicle_occupancy::function_b6077e40739ebc4b( ent );
            
            foreach ( occupant in occupants )
            {
                if ( isplayer( occupant ) )
                {
                    occupant_id = occupant getentitynumber();
                    
                    if ( isdefined( instance.registeredplayers[ occupant_id ] ) && occupant getinairpocket() )
                    {
                        continue;
                    }
                    
                    if ( !instance util_isinrange( occupant geteye() ) )
                    {
                        continue;
                    }
                    
                    instance.registeredplayers[ occupant_id ] = occupant;
                    occupant function_686dd58fcc3ffb2();
                    occupant thread function_d2f80b52d6f42f1( instance );
                    
                    if ( !ent.var_c7bf4af6240a235 && gasmask::hasgasmask( ent ) )
                    {
                        occupant br_pickups::gasmaskoff( "br_circle" );
                    }
                    
                    occupant thread function_7e250af21d592efa( instance );
                }
            }
            
            continue;
        }
        
        if ( !instance util_isinrange( ent geteye() ) )
        {
            continue;
        }
        
        instance.registeredplayers[ ent_id ] = ent;
        ent function_686dd58fcc3ffb2();
        ent thread function_d2f80b52d6f42f1( instance );
        
        if ( !ent.var_c7bf4af6240a235 && gasmask::hasgasmask( ent ) )
        {
            ent br_pickups::gasmaskoff( "br_circle" );
        }
        
        ent thread function_7e250af21d592efa( instance );
    }
}

// Namespace decon_station
// Params 1
// Checksum 0x5b5f7109, Offset: 0x1ba1
// Size: 0x5c
function function_7e250af21d592efa( instance )
{
    level endon( #"game_ended" );
    instance endon( #"death" );
    self endon( #"disconnect" );
    
    while ( player::isreallyalive( self ) )
    {
        if ( !instance util_isinrange( self geteye() ) )
        {
            break;
        }
        
        waitframe();
    }
    
    function_63c77d0c0cd7c47f( instance );
}

// Namespace decon_station
// Params 1
// Checksum 0x937f670e, Offset: 0x1c05
// Size: 0x30
function function_63c77d0c0cd7c47f( instance )
{
    instance.registeredplayers[ self getentitynumber() ] = undefined;
    
    if ( function_bbf4c140b64ab805( self ) )
    {
        function_7a1213d134b7f521( instance );
    }
}

// Namespace decon_station
// Params 1
// Checksum 0xe47c4757, Offset: 0x1c3d
// Size: 0x26, Type: bool
function function_bbf4c140b64ab805( ent )
{
    return isplayer( ent ) || isagent( ent ) || isbot( ent );
}

// Namespace decon_station
// Params 0
// Checksum 0x8be30087, Offset: 0x1c6c
// Size: 0x7f
function function_6b42bebf16b08b8e()
{
    if ( level.decon_station.aura_enabled )
    {
        playfxontag( utility::getfx( "vfx_br_decontamination_station_circle_aura" ), self, "tag_origin" );
    }
    
    for ( i = 1; i <= 6 ; i++ )
    {
        partname = "canister" + string( i );
        self setscriptablepartstate( partname, "active" );
    }
    
    self.canistersleft = 6;
    thread function_a048f70747523ec2();
}

// Namespace decon_station
// Params 0
// Checksum 0x4182a5a3, Offset: 0x1cf3
// Size: 0x96
function function_a048f70747523ec2()
{
    self endon( #"death" );
    self endon( #"stop_canisters" );
    level endon( #"game_ended" );
    timeinterval = level.decon_station.active_lifetime / float( 6 );
    
    for ( var_bfac748e0463c35a = 1; var_bfac748e0463c35a <= 6 ; var_bfac748e0463c35a++ )
    {
        partname = "canister" + string( var_bfac748e0463c35a );
        wait timeinterval;
        self setscriptablepartstate( partname, "hidden" );
        self.canistersleft--;
    }
}

// Namespace decon_station
// Params 0
// Checksum 0xab049645, Offset: 0x1d91
// Size: 0xbe
function function_7a038f671127b2c6()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    self notify( #"stop_canisters" );
    
    if ( self.canistersleft > 0 )
    {
        timeinterval = 0.1 / float( 6 );
        
        for ( var_bfac748e0463c35a = 6 - self.canistersleft + 1; var_bfac748e0463c35a <= 6 ; var_bfac748e0463c35a++ )
        {
            partname = "canister" + string( var_bfac748e0463c35a );
            self setscriptablepartstate( partname, "hidden" );
            self.canistersleft--;
            
            if ( self.canistersleft > 0 )
            {
                wait timeinterval;
            }
        }
    }
    
    waitframe();
    self notify( #"canisters_popped" );
}

// Namespace decon_station
// Params 0
// Checksum 0xd372f5e, Offset: 0x1e57
// Size: 0x2e
function function_4328b61b83c31cd6()
{
    if ( level.decon_station.aura_enabled )
    {
        killfxontag( utility::getfx( "vfx_br_decontamination_station_circle_aura" ), self, "tag_origin" );
    }
}

// Namespace decon_station
// Params 0
// Checksum 0xd5a9c701, Offset: 0x1e8d
// Size: 0x35
function deconstation_deployanimation()
{
    self endon( #"death" );
    self setscriptablepartstate( "effects", "activeDeployStart" );
    wait deconstation_getdeployanimtime();
    self setscriptablepartstate( "effects", "activeDeployEnd" );
}

#using_animtree( "scriptables" );

// Namespace decon_station
// Params 0
// Checksum 0x87132bfb, Offset: 0x1eca
// Size: 0xf
function deconstation_getdeployanimtime()
{
    return getanimlength( %wm_decon_station_deploy_landing );
}

// Namespace decon_station
// Params 1
// Checksum 0x357a9aa2, Offset: 0x1ee2
// Size: 0x56
function function_d13bd2c5ef8d6f3a( data )
{
    instance = data.victim;
    instance deconstation_givepointsfordeath( data.attacker );
    instance function_cd927b844c7008f5();
    instance thread deconstation_destroyequipment( data.attacker, 1 );
}

// Namespace decon_station
// Params 0
// Checksum 0xafcbbcc1, Offset: 0x1f40
// Size: 0x27
function function_7760346213047ad4()
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    self.var_cbbc5fc11be1891d = 1;
    self setscriptablepartstate( "decon_station_fx", "on" );
}

// Namespace decon_station
// Params 0
// Checksum 0xdf7bae3c, Offset: 0x1f6f
// Size: 0x2a
function function_a7ca59455a70eb52()
{
    if ( !self.var_cbbc5fc11be1891d )
    {
        return;
    }
    
    self.var_cbbc5fc11be1891d = 0;
    self setscriptablepartstate( "decon_station_fx", "off" );
}

// Namespace decon_station
// Params 1
// Checksum 0x12431506, Offset: 0x1fa1
// Size: 0x90
function function_37b6e7bf20741821( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    modifieddamage = damage;
    modifieddamage = damage::handleapdamage( objweapon, type, modifieddamage );
    weapons::equipmenthit( self.owner, attacker, objweapon, type );
    return modifieddamage;
}

// Namespace decon_station
// Params 0
// Checksum 0x320724fc, Offset: 0x203a
// Size: 0x212
function function_cd927b844c7008f5()
{
    if ( isdefined( self.registeredplayers ) )
    {
        foreach ( player in self.registeredplayers )
        {
            if ( isdefined( player ) )
            {
                player function_7a1213d134b7f521( self );
            }
        }
    }
    
    function_4328b61b83c31cd6();
    level.decon_station.instances = arrayremove( level.decon_station.instances, self );
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger delete();
    }
    
    game_utility::questcircle_delete();
    self.enemycircle game_utility::questcircle_delete();
    self notify( #"hash_a432b1e864d5babe" );
    
    if ( isdefined( self.armorykiosks ) )
    {
        foreach ( kiosk in self.armorykiosks )
        {
            kiosk function_513a3a389ea65abc();
        }
    }
    
    if ( isdefined( self.gasmasks ) )
    {
        foreach ( mask in self.gasmasks )
        {
            if ( isdefined( mask ) )
            {
                mask.inairpocket = 0;
            }
        }
    }
}

// Namespace decon_station
// Params 1
// Checksum 0x5ae31419, Offset: 0x2254
// Size: 0x37
function function_2ee373f8020db37c( data )
{
    attacker = data.attacker;
    deconstation_givepointsfordeath( attacker );
    thread deconstation_destroyequipment( attacker, 1 );
}

// Namespace decon_station
// Params 3
// Checksum 0x75054847, Offset: 0x2293
// Size: 0x10a
function deconstation_destroyequipment( attacker, wasdestroyed, delay )
{
    level endon( #"game_ended" );
    thread function_7a038f671127b2c6();
    self waittill( #"canisters_popped" );
    thread function_f326aa7b00f960cb( 0.1, wasdestroyed );
    self setscriptablepartstate( "effects", "activeDestroyStart", 0 );
    
    if ( !isdefined( delay ) )
    {
        delay = 0.1;
    }
    
    if ( delay >= level.framedurationseconds )
    {
        wait delay;
    }
    
    if ( isdefined( self.explosion ) )
    {
        self.explosion delete();
    }
    
    if ( isdefined( self ) )
    {
        self setscriptablepartstate( "effects", "activeDestroyEnd", 0 );
    }
    
    analytics_params = { #kiosks_affected:self.kiosksaffected.size, #players_affected:self.playersaffected.size, #was_destroyed:wasdestroyed, #total_lifetime:gettime() - self.deploytime };
    function_fd40bdc7f1556e57( analytics_params );
}

// Namespace decon_station
// Params 2
// Checksum 0x8a6e542a, Offset: 0x23a5
// Size: 0x21c
function function_f326aa7b00f960cb( deletiondelay, wasdestroyed )
{
    level endon( #"game_ended" );
    self notify( #"hash_a432b1e864d5babe" );
    self notify( #"death" );
    self setscriptablepartstate( "hack_usable", "off" );
    
    if ( utility::issharedfuncdefined( #"challenges", #"onfieldupgradeend" ) )
    {
        challengeparams = { #value:self.usedcount, #fieldupgraderef:"super_decon_station", #fieldupgradeent:self, #field_upgrade_owner:self.owner };
        self.owner [[ utility::getsharedfunc( #"challenges", #"onfieldupgradeend" ) ]]( challengeparams );
    }
    
    if ( isdefined( self.maxhealth ) )
    {
        dmg = int( self.damagetaken ?? self.maxhealth );
        self.owner challenges::function_a0936b0e5b4550f3( "super_decon_station", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"end" ), dmg );
        analyticslog::logevent_fieldupgradeexpired( self.owner, self.superid, self.usedcount, istrue( wasdestroyed ) );
    }
    
    weapon::deregistermine();
    self setcandamage( 0 );
    
    if ( !self.issuper )
    {
        self makeunusable();
        weapons::makeexplosiveunusuabletag();
    }
    
    entityheadicons::setheadicon_deleteicon( self.headiconid );
    self.headiconid = undefined;
    self.exploding = 1;
    
    if ( isdefined( self.owner ) )
    {
        self.owner notify( #"trophy_update", 0 );
        self.owner weapons::removeequip( self );
    }
    
    function_cd927b844c7008f5();
    self setscriptablepartstate( "anims", "neutral", 0 );
    self setscriptablepartstate( "effects", "activeDestroyEnd", 0 );
    
    if ( isdefined( deletiondelay ) )
    {
        wait deletiondelay;
    }
    
    ent_manager::deregisterspawn();
    thread utility::delete_after_delay( 2.5 );
}

// Namespace decon_station
// Params 0
// Checksum 0x55d2e3f8, Offset: 0x25c9
// Size: 0x1be
function function_f622ffd10c52f6e7()
{
    level endon( #"game_ended" );
    self setscriptablepartstate( "hack_usable", "off" );
    
    if ( utility::issharedfuncdefined( #"challenges", #"onfieldupgradeend" ) )
    {
        challengeparams = { #value:self.usedcount, #fieldupgraderef:"super_decon_station", #fieldupgradeent:self, #field_upgrade_owner:self.owner };
        self.owner [[ utility::getsharedfunc( #"challenges", #"onfieldupgradeend" ) ]]( challengeparams );
    }
    
    if ( isdefined( self.maxhealth ) )
    {
        dmg = int( self.damagetaken ?? self.maxhealth );
        self.owner challenges::function_a0936b0e5b4550f3( "super_decon_station", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"end" ), dmg );
        analyticslog::logevent_fieldupgradeexpired( self.owner, self.superid, self.usedcount, 0 );
    }
    
    weapon::deregistermine();
    self setcandamage( 0 );
    
    if ( !self.issuper )
    {
        self makeunusable();
        weapons::makeexplosiveunusuabletag();
    }
    
    entityheadicons::setheadicon_deleteicon( self.headiconid );
    self.headiconid = undefined;
    self.exploding = 1;
    
    if ( isdefined( self.owner ) )
    {
        self.owner notify( #"trophy_update", 0 );
        self.owner weapons::removeequip( self );
    }
    
    function_cd927b844c7008f5();
    ent_manager::deregisterspawn();
    self delete();
}

// Namespace decon_station
// Params 1
// Checksum 0xbc57799e, Offset: 0x278f
// Size: 0x3c
function deconstation_givepointsfordeath( attacker )
{
    if ( player_utility::playersareenemies( self.owner, attacker ) )
    {
        attacker thread points::giveunifiedpoints( #"destroyed_equipment" );
        attacker thread battlechatter_mp::equipmentdestroyed( self );
    }
}

// Namespace decon_station
// Params 0
// Checksum 0x416f218e, Offset: 0x27d3
// Size: 0xc1
function deconstation_createexplosion()
{
    explosion = spawn( "script_model", self.origin );
    explosion.killcament = self;
    explosion.owner = self.owner;
    explosion.team = self.team;
    explosion.equipmentref = self.equipmentref;
    explosion.weapon_name = self.weapon_name;
    explosion setotherent( explosion.owner );
    explosion setentityowner( explosion.owner );
    explosion setmodel( "trophy_system_mp_explode" );
    explosion.explode1available = 1;
    return explosion;
}

// Namespace decon_station
// Params 0
// Checksum 0xf88e40f6, Offset: 0x289d
// Size: 0x59
function function_fa3e854b8fe45471()
{
    self endon( #"death" );
    self endon( #"missile_stuck" );
    hideduration = getdvarfloat( @"scr_trophy_proj_hide_duration", 0 );
    self setscriptablepartstate( "visibility", "hide", 0 );
    wait hideduration;
    self setscriptablepartstate( "visibility", "show", 0 );
}

// Namespace decon_station
// Params 0
// Checksum 0xb2da684e, Offset: 0x28fe
// Size: 0x2a
function function_e59338d1d6b102c8()
{
    self endon( #"death" );
    level utility::waittill_any( "game_ended", "br_ending_start" );
    thread deconstation_destroyequipment( undefined, 0, 0 );
}

// Namespace decon_station
// Params 1
// Checksum 0xfaca2aec, Offset: 0x2930
// Size: 0x13b
function function_a0f730f0f33af72c( player )
{
    self endon( #"death" );
    self endon( #"missile_stuck" );
    player endon( #"disconnect" );
    msg = utility::waittill_any_timeout( 2, "touching_platform" );
    
    if ( msg == "timeout" )
    {
        return;
    }
    
    groundentity = undefined;
    ignoreents = vehicle_getarrayinradius( self.origin, 500, 500 );
    ignoreents[ ignoreents.size ] = self;
    tracecontents = trace::create_contents( 0, 1, 1, 1, 0, 1, 1, 0, 1 );
    tracestart = self.origin;
    var_fbaf852c9cb6dff8 = -2000;
    traceend = self.origin + ( 0, 0, var_fbaf852c9cb6dff8 );
    traceresults = trace::ray_trace( tracestart, traceend, ignoreents, tracecontents );
    
    if ( traceresults[ "fraction" ] < 1 )
    {
        groundentity = traceresults[ "entity" ];
        
        if ( isdefined( groundentity ) )
        {
            if ( utility::is_moving_platform_ent( groundentity ) )
            {
                self.origin = player.origin;
            }
        }
    }
}

// Namespace decon_station
// Params 0
// Checksum 0xed1068fd, Offset: 0x2a73
// Size: 0x39
function function_512a005f910667()
{
    self endon( #"death" );
    self endon( #"hash_a432b1e864d5babe" );
    self.armorykiosks = [];
    
    while ( true )
    {
        function_83da3dece39ae370();
        wait 0.5;
    }
}

// Namespace decon_station
// Params 2
// Checksum 0x157595f4, Offset: 0x2ab4
// Size: 0x3e
function function_3acaca3cacd01b00( time, offset )
{
    self endon( #"death" );
    self endon( #"hash_a432b1e864d5babe" );
    wait time - offset;
    game_utility::function_27df4a8c168476e9( "ExpiringDeconStation_Br" );
}

// Namespace decon_station
// Params 0
// Checksum 0x20652f7, Offset: 0x2afa
// Size: 0x269
function function_83da3dece39ae370()
{
    foreach ( kiosk in self.armorykiosks )
    {
        if ( !util_isinrange( kiosk ) )
        {
            kiosk function_513a3a389ea65abc();
            arrayremove( self.armorykiosks, kiosk );
        }
    }
    
    self.armorykiosks = function_5713d46873b29625( self.armorykiosks );
    armorykiosks = common_kiosk::function_5c2447fa1580c330();
    
    if ( isdefined( armorykiosks ) )
    {
        foreach ( kiosk in armorykiosks )
        {
            if ( !isdefined( kiosk ) || arraycontains( self.armorykiosks, kiosk ) )
            {
                continue;
            }
            
            if ( util_isinrange( kiosk ) )
            {
                if ( kiosk.disabled )
                {
                    self.kiosksaffected[ kiosk.index ] = 1;
                }
                
                kiosk function_5ea0621fc332a030();
                self.armorykiosks[ self.armorykiosks.size ] = kiosk;
            }
        }
    }
    
    if ( isdefined( level.deployablekiosks.buystations ) )
    {
        foreach ( deployablekiosk in level.deployablekiosks.buystations )
        {
            if ( !isdefined( deployablekiosk ) || arraycontains( self.armorykiosks, deployablekiosk ) )
            {
                continue;
            }
            
            if ( util_isinrange( deployablekiosk ) )
            {
                deployablekiosk function_5ea0621fc332a030( 1 );
                self.armorykiosks[ self.armorykiosks.size ] = deployablekiosk;
            }
        }
    }
}

// Namespace decon_station
// Params 1
// Checksum 0xf3ebfe0b, Offset: 0x2d6b
// Size: 0x52
function function_5ea0621fc332a030( isdeployablekiosk )
{
    self notify( #"hash_e2ff56ca88498c14" );
    
    if ( !isdefined( self.deconeffectcount ) )
    {
        self.deconeffectcount = 0;
        
        if ( isdeployablekiosk )
        {
            br_deployable_kiosk::enabledeployablekiosk( self );
        }
        else
        {
            common_kiosk::function_50a87808f478947f( self );
        }
    }
    
    self.deconeffectcount++;
}

// Namespace decon_station
// Params 0
// Checksum 0x9b25dc6a, Offset: 0x2dc5
// Size: 0x21
function function_513a3a389ea65abc()
{
    self.deconeffectcount--;
    
    if ( self.deconeffectcount == 0 )
    {
        thread function_497d56960adf52b9();
    }
}

// Namespace decon_station
// Params 0
// Checksum 0xfdbf0313, Offset: 0x2dee
// Size: 0x1e
function function_497d56960adf52b9()
{
    self endon( #"hash_e2ff56ca88498c14" );
    wait 2;
    self.deconeffectcount = undefined;
}

// Namespace decon_station
// Params 0
// Checksum 0xe944717, Offset: 0x2e14
// Size: 0x1a
function function_686dd58fcc3ffb2()
{
    if ( !self getinairpocket() )
    {
        self setinairpocket( 1 );
        white_phosphorus::enableloopingcoughaudiosupression();
    }
}

// Namespace decon_station
// Params 0
// Checksum 0x62f551ee, Offset: 0x2e36
// Size: 0x18
function function_d648e8bf423cd056()
{
    if ( self getinairpocket() )
    {
        self setinairpocket( 0 );
        white_phosphorus::disableloopingcoughaudiosupression();
    }
}

// Namespace decon_station
// Params 1
// Checksum 0x88e76367, Offset: 0x2e56
// Size: 0x65, Type: bool
function util_isinrange( target )
{
    if ( isvector( target ) )
    {
        return ( distancesquared( target, self.origin ) < level.decon_station.radius_sq );
    }
    
    return distancesquared( target.origin, self.origin ) < level.decon_station.radius_sq;
}

// Namespace decon_station
// Params 3
// Checksum 0xefaa647c, Offset: 0x2ec4
// Size: 0x7a
function function_75d47e4aba0e82ad( player, position, circle_index )
{
    event_data = [ "pos_x", position[ 0 ], "pos_y", position[ 1 ], "pos_z", position[ 2 ], "circle_index", circle_index ];
    player dlog_recordplayerevent( "dlog_event_br_decon_station_deployed", event_data );
}

// Namespace decon_station
// Params 1
// Checksum 0x4884e589, Offset: 0x2f46
// Size: 0x85
function function_fd40bdc7f1556e57( params )
{
    event_data = [ "total_lifetime", params.total_lifetime, "was_destroyed", params.was_destroyed, "players_affected", params.players_affected, "kiosks_affected", params.kiosks_affected ];
    dlog_recordevent( "dlog_event_br_decon_station_end", event_data );
}

// Namespace decon_station
// Params 0
// Checksum 0x4fb7f33e, Offset: 0x2fd3
// Size: 0x36
function function_5843c37208e553fb()
{
    level endon( #"game_ended" );
    self endon( #"hash_a432b1e864d5babe" );
    self endon( #"death" );
    
    while ( true )
    {
        function_f9cbdedd5d0e33ac();
        waitframe();
    }
}

// Namespace decon_station
// Params 0
// Checksum 0x4b3f1311, Offset: 0x3011
// Size: 0xe7
function function_f9cbdedd5d0e33ac()
{
    self.gasmasks = [];
    
    foreach ( gasmask in level.droppedgasmasks )
    {
        if ( isdefined( gasmask ) )
        {
            if ( util_isinrange( gasmask ) )
            {
                if ( gasmask getscriptablepartstate( "damage_fx" ) == "active" )
                {
                    gasmask setscriptablepartstate( "damage_fx", "inactive" );
                }
                
                gasmask.inairpocket = 1;
                self.gasmasks[ self.gasmasks.size ] = gasmask;
                continue;
            }
            
            gasmask.inairpocket = 0;
        }
    }
}

/#

    // Namespace decon_station
    // Params 0
    // Checksum 0xf38500b0, Offset: 0x3100
    // Size: 0x19, Type: dev
    function init_debug()
    {
        br_dev::registerhandlecommand( &function_11d7b4eba66512a6 );
        level thread setup_devgui();
    }

    // Namespace decon_station
    // Params 0
    // Checksum 0x6bafde41, Offset: 0x3121
    // Size: 0x37, Type: dev
    function setup_devgui()
    {
        level endon( #"game_ended" );
        
        while ( !isdefined( level.player ) )
        {
            waitframe();
        }
        
        adddebugcommand( "<dev string:x3a>" );
        adddebugcommand( "<dev string:xb9>" );
    }

    // Namespace decon_station
    // Params 2
    // Checksum 0xfc10ba06, Offset: 0x3160
    // Size: 0x151, Type: dev
    function function_11d7b4eba66512a6( command, args )
    {
        command_result = "<dev string:x13a>";
        
        switch ( command )
        {
            case #"hash_d935a215264f7d83":
                level.allowsupers = 1;
                target_spawn_location = level.player.origin + anglestoforward( level.player.angles ) * 300 + ( 0, 0, 25 );
                spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( target_spawn_location, level.player.angles );
                namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( "<dev string:x15f>", undefined, spawnoptions );
                break;
            case #"hash_110b6dd8c0a49189":
                level.allowsupers = 1;
                level.player supers_mp::clearsuper( 1 );
                level.player br_pickups::forcegivesuper( "<dev string:x1a0>" );
                level.player supers_mp::givesuperpoints( level.player supers_mp::getsuperpointsneeded() );
                break;
        }
        
        iprintln( "<dev string:x1b4>" + command + ( command_result != "<dev string:x13a>" ? "<dev string:x1c5>" : "<dev string:x13a>" ) + command_result );
    }

#/
