// scripts\mp\common\supers\combat_link.gsc  (hash_012f27689484d598.gscc) (size: 19573 Bytes / 0x4c75 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2fa712a (49967402)
// size ...... 19573 (0x4c75)
// includes .. 27  (offset: 0x4a41)
// strings ... 14  (offset: 0x4b19)
// dev strs .. 3   (offset: 0x4c51)
// exports ... 50  (offset: 0x3009)
// cseg ...... 0x1a5 + 0x2e64 (0x3009)
// imports ... 151 (offset: 0x37d9)
// animtree1 . 0   (offset: 0x4c75)
// animtree2 . 0   (offset: 0x4c75)
#using script_16ea1b94f0f381b3;
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\equipment_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\damage;
#using scripts\mp\emp_debuff;
#using scripts\mp\entityheadicons;
#using scripts\mp\equipment;
#using scripts\mp\equipment_interact;
#using scripts\mp\hostmigration;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;
#using scripts\mp\rank;
#using scripts\mp\supers;
#using scripts\mp\telemetry_mp;
#using scripts\mp\weapons;

#namespace combat_link;

// Namespace combat_link
// Params 0, eflags: 0x5
// Checksum 0xce5f97ba, Offset: 0x1c3
// Size: 0x14
function private autoexec preinit_combat_link()
{
    level callback::add( "init_grenade", &init );
}

// Namespace combat_link
// Params 1
// Checksum 0xed47602a, Offset: 0x1df
// Size: 0xce
function init( params )
{
    weapons::registerusedcallback( "super_combat_link", &used );
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_combat_link" );
    var_150e76ca567f8c26 = bundle.var_4c58474cb52c5ee8 ?? 100;
    effect_radius_off = max( bundle.var_88ec14ff3115a94d ?? 100, var_150e76ca567f8c26 );
    level.var_64f11627e2d5dc7d = var_150e76ca567f8c26;
    level.var_b5ce9dd7bbb6b612 = effect_radius_off;
    utility::registersharedfunc( #"combat_link", #"hack", &hack );
    level callback::add( #"hash_244314ef9125e636", &playerkilled );
    level callback::add( #"on_ai_killed", &playerkilled );
}

// Namespace combat_link
// Params 1
// Checksum 0x7b3097df, Offset: 0x2b5
// Size: 0x3a0
function used( grenade )
{
    grenade endon( #"death" );
    self endon( #"disconnect" );
    grenade.superref = "super_combat_link";
    grenade.bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_combat_link" );
    grenade setscriptablepartstate( #"visibility", #"show", 0 );
    grenade setotherent( self );
    grenade setnodeploy( 1 );
    grenade.issuper = isdefined( self.super ) && self.super.staticdata.ref == "super_combat_link";
    grenade.superid = level.superglobals.staticsuperdata[ "super_combat_link" ].id;
    activation_delay = grenade.bundle.var_607bf1c2901db31d ?? 0.1;
    health = grenade.bundle.maxhealth ?? 50;
    grenade.var_5fc9f9bcb532c207 = [];
    
    foreach ( index, var_5fc9f9bcb532c207 in grenade.bundle.var_ed9dff87ad932997 )
    {
        grenade.var_5fc9f9bcb532c207[ index ] = var_5fc9f9bcb532c207.assetref;
    }
    
    grenade.affectedtargets = [];
    grenade.ignoredtargets = [];
    grenade emp_debuff::set_apply_emp_callback( &empapplycallback );
    emp_debuff::add_emp_ent( grenade );
    
    if ( level.killstreak_emp_initialized )
    {
        grenade.ksempapplycallback = &empapplycallback;
    }
    
    utility::callsharedfunc( #"jamming_system", #"hash_ca0042e3cac99672", grenade, &function_f2fdd019aa1d97a6, &function_655bd8caffa5d850 );
    namespace_9d8e359c3b1041e5::onequipmentplantedsharedfunc( grenade, "super_combat_link", &function_2591addd453cc91d, 1 );
    thread namespace_9d8e359c3b1041e5::monitordisownedequipmentsharedfunc( self, grenade );
    grenade.headiconid = entityheadicons::setheadicon_fieldupgrade( grenade );
    
    if ( !function_74b6e2ef5d892fe5() )
    {
        grenade.empremovecallback = &empremovecallback;
        
        if ( level.killstreak_emp_initialized )
        {
            grenade.ksempclearcallback = &empremovecallback;
        }
    }
    
    if ( grenade.bundle.var_bead9b1c34058722 )
    {
        var_aacb78da5016573c = grenade.bundle.var_9d83d7a2c4169a01 ?? 0.3;
        destroyrange = grenade.bundle.var_d698fcfe464f1b17 ?? 128;
        hintstring = grenade.bundle.var_dfc5df4b445d78b1 ?? &"super_mp/destroy_super";
        grenade thread equipment_interact::function_226793772d245e96( var_aacb78da5016573c, destroyrange, hintstring, grenade.team );
    }
    
    damagefeedback = "hitequip";
    grenade thread weapons::watchkillbordercallback( &cleanup_and_delete );
    grenade thread damage::monitordamage( health, damagefeedback, &function_2591addd453cc91d, &handle_damage );
    grenade thread function_642a368393dd5e7d( activation_delay );
    grenade thread equipment_mp::watchwaterdepth( &function_3d71cf188e9de252 );
}

// Namespace combat_link
// Params 0
// Checksum 0x7aa43a1a, Offset: 0x65d
// Size: 0x9
function function_3d71cf188e9de252()
{
    thread cleanup_and_delete();
}

// Namespace combat_link
// Params 1
// Checksum 0x306aa93e, Offset: 0x66e
// Size: 0x16d
function function_642a368393dd5e7d( activation_delay )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"emp_disable" );
    self waittill( #"missile_stuck", stuckto );
    
    if ( outofbounds::istouchingoobtrigger() )
    {
        thread cleanup_and_delete();
    }
    
    if ( isent( stuckto ) && stuckto ismovingplatform() )
    {
        self linkto( stuckto );
    }
    
    wait activation_delay;
    
    if ( !self.var_7568cab78e4268cc )
    {
        self setscriptablepartstate( #"active", #"active", 0 );
    }
    
    if ( !isdefined( level.var_80c6e313f9c36e80 ) )
    {
        level.var_80c6e313f9c36e80 = [];
    }
    
    level.var_80c6e313f9c36e80[ level.var_80c6e313f9c36e80.size ] = self;
    
    if ( !isdefined( self.owner.combat_links ) )
    {
        self.owner.combat_links = [];
    }
    
    self.owner.combat_links[ self.owner.combat_links.size ] = self;
    thread watchtimeoutorgameended();
    function_ad3e0e075559103();
    function_b98aaf47929af30f();
    utility::function_969f9f5596dba07a( self, &cleanup_and_delete );
    self.owner challenges::function_a0936b0e5b4550f3( "super_combat_link", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"use" ) );
}

// Namespace combat_link
// Params 0
// Checksum 0x7b574b27, Offset: 0x7e3
// Size: 0x6e
function watchtimeoutorgameended()
{
    self notify( #"hash_e97288c53d84d109" );
    self endon( #"hash_e97288c53d84d109" );
    self endon( #"death" );
    level endon( #"game_ended" );
    timeout = self.bundle.maxlifetime ?? 300;
    hostmigration::waitlongdurationwithhostmigrationpause( timeout );
    thread cleanup_and_delete( 0.1, 1 );
}

// Namespace combat_link
// Params 0
// Checksum 0x7015c9e1, Offset: 0x859
// Size: 0x139
function function_b98aaf47929af30f()
{
    if ( !isdefined( self.ownedcircle ) )
    {
        self.ownedcircle = {};
    }
    
    if ( !isdefined( self.friendlycircle ) )
    {
        self.friendlycircle = {};
    }
    
    self.ownedcircle game_utility::questcircle_create( "CombatLinkOwned", self.origin, self.var_5f0f8910ed996728 );
    self.friendlycircle game_utility::questcircle_create( "CombatLinkFriendly", self.origin, self.var_5f0f8910ed996728 );
    ownerteamplayers = teams::getteamdata( self.team, "players" );
    
    foreach ( player in ownerteamplayers )
    {
        if ( player == self.owner )
        {
            self.ownedcircle game_utility::questcircle_showtoplayer( player );
            continue;
        }
        
        self.friendlycircle game_utility::questcircle_showtoplayer( player );
    }
}

// Namespace combat_link
// Params 0
// Checksum 0x50fbad0a, Offset: 0x99a
// Size: 0x4e
function function_828173dab997990a()
{
    if ( self.ownedcircle )
    {
        self.ownedcircle game_utility::questcircle_delete();
        self.ownedcircle = undefined;
    }
    
    if ( self.friendlycircle )
    {
        self.friendlycircle game_utility::questcircle_delete();
        self.friendlycircle = undefined;
    }
}

// Namespace combat_link
// Params 0
// Checksum 0x33a1ac71, Offset: 0x9f0
// Size: 0x10c
function function_58516515c05c3ff0()
{
    if ( self.ownedcircle && ( self.ownedcircle.mapcircle.origin[ 0 ] != self.origin[ 0 ] || self.ownedcircle.mapcircle.origin[ 1 ] != self.origin[ 1 ] ) )
    {
        self.ownedcircle game_utility::questcircle_move( self.origin );
    }
    
    if ( self.friendlycircle && ( self.friendlycircle.mapcircle.origin[ 0 ] != self.origin[ 0 ] || self.friendlycircle.mapcircle.origin[ 1 ] != self.origin[ 1 ] ) )
    {
        self.friendlycircle game_utility::questcircle_move( self.origin );
    }
}

// Namespace combat_link
// Params 1
// Checksum 0x6477a197, Offset: 0xb04
// Size: 0xad
function function_e8b4f7f663929b46( var_56d7233e3f7fb0b )
{
    if ( var_56d7233e3f7fb0b.objid )
    {
        return;
    }
    
    if ( !self.team )
    {
        return;
    }
    
    minimapicon = var_56d7233e3f7fb0b.bundle.minimapicon;
    
    if ( minimapicon )
    {
        objid = var_56d7233e3f7fb0b objidpoolmanager::createobjective( minimapicon, self.team, 1, 0, "icon_small" );
        objidpoolmanager::function_586b631e7bbb592a( objid, 1 );
        objidpoolmanager::update_objective_onentity( objid, var_56d7233e3f7fb0b );
        var_56d7233e3f7fb0b.objid = objid;
    }
    
    var_56d7233e3f7fb0b waittill( #"death" );
    function_4970ffac4423e5ea( var_56d7233e3f7fb0b );
}

// Namespace combat_link
// Params 1
// Checksum 0x8d72215d, Offset: 0xbb9
// Size: 0x38
function function_4970ffac4423e5ea( var_56d7233e3f7fb0b )
{
    if ( isdefined( var_56d7233e3f7fb0b.objid ) )
    {
        objidpoolmanager::returnobjectiveid( var_56d7233e3f7fb0b.objid );
        var_56d7233e3f7fb0b.objid = undefined;
    }
}

// Namespace combat_link
// Params 0
// Checksum 0xdbe042dd, Offset: 0xbf9
// Size: 0x1d
function function_ad3e0e075559103()
{
    if ( level.gameended )
    {
        return;
    }
    
    thread monitor_loop();
    thread function_cd191feec79c0df1();
}

// Namespace combat_link
// Params 0
// Checksum 0x52bcb2bf, Offset: 0xc1e
// Size: 0x1cf
function monitor_loop()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self.var_74204d23249ffac5 = [];
    self.var_9d41a5332c5a2f4b = [];
    var_150e76ca567f8c26 = level.var_64f11627e2d5dc7d;
    effect_radius_off = level.var_b5ce9dd7bbb6b612;
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_combat_link" );
    self.var_3b396ddf6e314681 = 1;
    self.var_352099d9d2836866 = 1;
    
    if ( self.owner )
    {
        if ( bundle.var_c7709714d768097c && self.owner supers_mp::function_d45945781d29204a( "super_combat_link", bundle.var_c7709714d768097c ) )
        {
            radiusscalar = bundle.var_70638c3547faafa9 ?? 1.5;
            var_150e76ca567f8c26 *= radiusscalar;
            effect_radius_off *= radiusscalar;
        }
        
        if ( bundle.var_e36b84555e7df1d3 && self.owner supers_mp::function_d45945781d29204a( "super_combat_link", bundle.var_e36b84555e7df1d3 ) )
        {
            self.var_3b396ddf6e314681 = bundle.var_f3c44af5cb202d9d ?? 2.5;
            self.var_352099d9d2836866 = bundle.var_d1938d96f45cca1a ?? 2;
        }
    }
    
    self.var_8f87d86bdd5b3a19 = var_150e76ca567f8c26 * var_150e76ca567f8c26;
    self.var_6fa9894e26609396 = effect_radius_off * effect_radius_off;
    self.var_5f0f8910ed996728 = var_150e76ca567f8c26;
    self.var_689e33d695453755 = effect_radius_off;
    
    if ( !isdefined( level.combatlinks ) )
    {
        level.combatlinks = [];
    }
    
    level.combatlinks[ level.combatlinks.size ] = self;
    
    while ( self )
    {
        monitor_targets();
        monitor_players();
        function_aacd62dc3f24fccb();
        waitframe();
    }
}

// Namespace combat_link
// Params 1, eflags: 0x4
// Checksum 0x5e726f6a, Offset: 0xdf5
// Size: 0xe8
function private playerkilled( params )
{
    if ( self.death_source == "despawn" )
    {
        return;
    }
    
    if ( !level.combatlinks.size || !params.victim || !params.attacker || player_utility::function_51a0c300008ab56b( params.victim, params.attacker ) )
    {
        return;
    }
    
    foreach ( combatlink in level.combatlinks )
    {
        combatlink function_f2d69f9488796da4( params );
    }
}

// Namespace combat_link
// Params 1, eflags: 0x4
// Checksum 0xe79db9a4, Offset: 0xee5
// Size: 0x249
function private function_f2d69f9488796da4( params )
{
    attacker = params.attacker;
    victim = params.victim;
    
    if ( !self.owner || self.var_7568cab78e4268cc || !self.var_74204d23249ffac5 )
    {
        return;
    }
    
    if ( !arraycontains( self.var_74204d23249ffac5, attacker ) )
    {
        return;
    }
    
    if ( player_utility::function_51a0c300008ab56b( victim, self.owner ) )
    {
        return;
    }
    
    objweapon = params.objweapon;
    
    if ( !weapon_utility::isbulletweapon( objweapon ) && !weapon::function_1344ad15d2d7bd21( objweapon ) )
    {
        if ( weapon::iskillstreakweapon( objweapon ) )
        {
            return;
        }
        
        if ( weapon_utility::function_c1972d0d01397a22( objweapon ) || weapon_utility::function_186e07887b6bbeb1( objweapon ) )
        {
            return;
        }
        
        isthrowingknife = weapon::function_e1a6c47f66c6de20( objweapon );
        
        if ( ( weapon_utility::isgrenadeweapon( objweapon ) || weapon_utility::isoffhandweapon( objweapon ) ) && !isthrowingknife )
        {
            return;
        }
        
        switch ( params.meansofdeath )
        {
            case #"hash_19fbc34dda39832e":
            case #"hash_1b5395c651f95456":
            case #"hash_61e42661ac27b9f2":
            case #"hash_a5123f4d02745600":
                break;
            default:
                if ( !isthrowingknife )
                {
                    return;
                }
                
                break;
        }
    }
    
    if ( attacker == self.owner )
    {
        function_46b22598204646ca();
        self.owner thread function_8b74c2138864714( victim.guid, self );
        return;
    }
    
    if ( level.teambased && attacker.team == self.team )
    {
        function_46b22598204646ca();
        self.owner thread function_12bd28589dc2b787( victim.guid, self );
        scoremultiplier = min( self.var_74204d23249ffac5.size ?? 1, 6 );
        basepoints = rank::getscoreinfovalue( #"hash_b6594ca78dc69f65" ) ?? 0;
        attacker thread function_59ac21ba57b50934( victim.guid, basepoints * scoremultiplier, self.weapon_object );
    }
}

// Namespace combat_link
// Params 3, eflags: 0x4
// Checksum 0xe1de98fe, Offset: 0x1136
// Size: 0x7d
function private function_59ac21ba57b50934( victimguid, points, objweapon )
{
    if ( self.var_7da539d257c68138[ victimguid ] )
    {
        return;
    }
    
    thread points::doscoreevent( #"hash_b6594ca78dc69f65", objweapon, points );
    
    if ( !isdefined( self.var_7da539d257c68138 ) )
    {
        self.var_7da539d257c68138 = [];
    }
    
    self.var_7da539d257c68138[ victimguid ] = 1;
    waittillframeend();
    
    if ( self.var_7da539d257c68138 )
    {
        self.var_7da539d257c68138 = undefined;
    }
}

// Namespace combat_link
// Params 2, eflags: 0x4
// Checksum 0x238e3672, Offset: 0x11bb
// Size: 0xa9
function private function_8b74c2138864714( victimguid, combatlink )
{
    if ( self.var_ee6799720a3a8f9c[ victimguid ] )
    {
        return;
    }
    
    basepoints = rank::getscoreinfovalue( #"hash_1795ee9c9a372642" ) ?? 0;
    thread points::doscoreevent( #"hash_1795ee9c9a372642", combatlink.weapon_object, basepoints * combatlink.var_352099d9d2836866 );
    
    if ( !isdefined( self.var_ee6799720a3a8f9c ) )
    {
        self.var_ee6799720a3a8f9c = [];
    }
    
    self.var_ee6799720a3a8f9c[ victimguid ] = 1;
    waittillframeend();
    
    if ( self.var_ee6799720a3a8f9c )
    {
        self.var_ee6799720a3a8f9c = undefined;
    }
}

// Namespace combat_link
// Params 2, eflags: 0x4
// Checksum 0x5a9866c9, Offset: 0x126c
// Size: 0xa9
function private function_12bd28589dc2b787( victimguid, combatlink )
{
    if ( self.var_43e842120378ce83[ victimguid ] )
    {
        return;
    }
    
    basepoints = rank::getscoreinfovalue( #"hash_71a7d6c7ef1ee5a1" ) ?? 0;
    thread points::doscoreevent( #"hash_71a7d6c7ef1ee5a1", combatlink.weapon_object, basepoints * combatlink.var_352099d9d2836866 );
    
    if ( !isdefined( self.var_43e842120378ce83 ) )
    {
        self.var_43e842120378ce83 = [];
    }
    
    self.var_43e842120378ce83[ victimguid ] = 1;
    waittillframeend();
    
    if ( self.var_43e842120378ce83 )
    {
        self.var_43e842120378ce83 = undefined;
    }
}

// Namespace combat_link
// Params 1, eflags: 0x4
// Checksum 0xd56676e2, Offset: 0x131d
// Size: 0x81
function private function_46b22598204646ca( objweapon )
{
    if ( !isdefined( self.var_6c1003c19eeb94c0 ) )
    {
        self.var_6c1003c19eeb94c0 = 0;
    }
    
    self.var_6c1003c19eeb94c0++;
    
    if ( self.var_6c1003c19eeb94c0 == 5 )
    {
        basepoints = rank::getscoreinfovalue( #"combat_link_high_score" ) ?? 0;
        self.owner thread points::doscoreevent( #"combat_link_high_score", objweapon, basepoints * self.var_352099d9d2836866 );
    }
}

// Namespace combat_link
// Params 0
// Checksum 0x54a68d9, Offset: 0x13a6
// Size: 0xac
function function_cd191feec79c0df1()
{
    level endon( #"game_ended" );
    self endon( #"death", #"emp_disable", #"hacked" );
    
    while ( true )
    {
        while ( self.affectedtargets.size == 0 )
        {
            waitframe();
        }
        
        self setscriptablepartstate( #"deactivate", #"neutral", 0 );
        self setscriptablepartstate( #"inactive", #"neutral", 0 );
        self setscriptablepartstate( #"active", #"active", 0 );
        
        while ( self.affectedtargets.size > 0 )
        {
            waitframe();
        }
        
        function_1cf7ce607bf56f2c();
    }
}

// Namespace combat_link
// Params 0
// Checksum 0xc11d586f, Offset: 0x145a
// Size: 0x4d
function function_1cf7ce607bf56f2c()
{
    self setscriptablepartstate( #"objective", #"neutral", 0 );
    self setscriptablepartstate( #"deactivate", #"neutral", 0 );
    self setscriptablepartstate( #"active", #"active", 0 );
}

// Namespace combat_link
// Params 1
// Checksum 0x407c4dc9, Offset: 0x14af
// Size: 0x160
function add_player_buff( player )
{
    if ( player.ishvt )
    {
        return;
    }
    
    if ( !isarray( player.var_30656af96b2ac2a4 ) )
    {
        player.var_30656af96b2ac2a4 = [];
    }
    
    player.var_30656af96b2ac2a4[ player.var_30656af96b2ac2a4.size ] = self;
    var_3364358a270b367 = self getentitynumber();
    telemetry_mp::function_80a95f340a7c8f67( self.owner, player, self.weapon_object, var_3364358a270b367 );
    
    if ( player.var_30656af96b2ac2a4.size > 0 )
    {
        player.headiconid = player entityheadicons::setheadicon_singleimage( self.var_74204d23249ffac5, level.gamemodebundle.var_e97695a9b0081fa0, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "icon_small", 1 );
        
        foreach ( linkedplayer in self.var_74204d23249ffac5 )
        {
            if ( linkedplayer == player )
            {
                continue;
            }
            
            entityheadicons::setheadicon_addclienttomask( linkedplayer.headiconid, player );
        }
    }
}

// Namespace combat_link
// Params 1
// Checksum 0x7b12897c, Offset: 0x1617
// Size: 0x132
function remove_player_buff( player )
{
    if ( isarray( player.var_30656af96b2ac2a4 ) )
    {
        if ( arraycontains( player.var_30656af96b2ac2a4, self ) )
        {
            player.var_30656af96b2ac2a4 = arrayremove( player.var_30656af96b2ac2a4, self );
            var_3364358a270b367 = self getentitynumber();
            telemetry_mp::function_c4080f7bf60d4131( player, self.weapon_object, var_3364358a270b367 );
            
            if ( player.var_30656af96b2ac2a4.size <= 0 && isdefined( player.headiconid ) )
            {
                foreach ( linkedplayer in self.var_74204d23249ffac5 )
                {
                    entityheadicons::setheadicon_removeclientfrommask( linkedplayer.headiconid, player );
                }
                
                entityheadicons::setheadicon_deleteicon( player.headiconid );
                player.headiconid = undefined;
            }
        }
    }
}

// Namespace combat_link
// Params 0
// Checksum 0x17c0ce21, Offset: 0x1751
// Size: 0x70
function function_3a9ef3d5a4d0d600()
{
    ownerval = self.owner ?? undefined;
    var_3bf06f77964fd65c = player_utility::script_getplayersinradius( self.origin, self.var_689e33d695453755, self.team );
    var_726d33884138285d = arrayremove( self.var_74204d23249ffac5, var_3bf06f77964fd65c );
    
    if ( var_726d33884138285d.size > 0 )
    {
        function_675672e0e2ec3668( var_726d33884138285d );
    }
}

// Namespace combat_link
// Params 1, eflags: 0x4
// Checksum 0x802e0261, Offset: 0x17c9
// Size: 0x1da
function private function_675672e0e2ec3668( var_726d33884138285d )
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_combat_link" );
    
    foreach ( player in var_726d33884138285d )
    {
        self.var_74204d23249ffac5 = arrayremove( self.var_74204d23249ffac5, player );
        player perk::removeperk( "specialty_forwardintel" );
        remove_player_buff( player );
        
        if ( player == self.owner )
        {
            continue;
        }
        
        var_4059ccd1b010c299 = bundle.var_e36b84555e7df1d3 && self.owner supers_mp::function_d45945781d29204a( "super_combat_link", bundle.var_e36b84555e7df1d3 );
        
        if ( !var_4059ccd1b010c299 )
        {
            continue;
        }
        
        if ( player.var_6a2d9548aeda69ae[ "super_combat_link" ] )
        {
            player.var_6a2d9548aeda69ae[ "super_combat_link" ] = function_46f9072493651dc9( player.var_6a2d9548aeda69ae[ "super_combat_link" ] );
            player.var_6a2d9548aeda69ae[ "super_combat_link" ] = arrayremove( player.var_6a2d9548aeda69ae[ "super_combat_link" ], self );
        }
        
        if ( player.var_6a2d9548aeda69ae[ "super_combat_link" ].size == 0 )
        {
            player val::reset( "super_combat_link", "field_upgrade_recharge_mult" );
            player perk::removeperk( "specialty_faster_field_upgrade" );
            player.var_6a2d9548aeda69ae[ "super_combat_link" ] = undefined;
        }
    }
    
    if ( self.var_74204d23249ffac5 )
    {
        self.var_74204d23249ffac5 = function_46f9072493651dc9( self.var_74204d23249ffac5 );
    }
}

// Namespace combat_link
// Params 0
// Checksum 0x6ae4915c, Offset: 0x19ab
// Size: 0x446
function function_34dd512bd473fbe3()
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_combat_link" );
    ownerval = self.owner ?? undefined;
    var_1ca3f0673ab14217 = player_utility::script_getplayersinradius( self.origin, self.var_5f0f8910ed996728, self.team );
    var_5025545ee3b09b34 = arrayremove( var_1ca3f0673ab14217, self.var_74204d23249ffac5 );
    
    if ( var_5025545ee3b09b34.size > 0 )
    {
        self.var_74204d23249ffac5 = arraycombineunique( self.var_74204d23249ffac5, var_5025545ee3b09b34 );
        var_4059ccd1b010c299 = bundle.var_e36b84555e7df1d3 && self.owner supers_mp::function_d45945781d29204a( "super_combat_link", bundle.var_e36b84555e7df1d3 );
        
        if ( var_4059ccd1b010c299 )
        {
            foreach ( player in var_5025545ee3b09b34 )
            {
                if ( player == self.owner )
                {
                    continue;
                }
                
                if ( !isdefined( player.var_6a2d9548aeda69ae ) )
                {
                    player.var_6a2d9548aeda69ae = [];
                }
                
                if ( !isdefined( player.var_6a2d9548aeda69ae[ "super_combat_link" ] ) )
                {
                    player.var_6a2d9548aeda69ae[ "super_combat_link" ] = [];
                }
                
                if ( player.var_6a2d9548aeda69ae[ "super_combat_link" ].size == 0 )
                {
                    player perk::giveperk( "specialty_faster_field_upgrade" );
                    player val::set( "super_combat_link", "field_upgrade_recharge_mult", self.var_3b396ddf6e314681 );
                }
                
                player.var_6a2d9548aeda69ae[ "super_combat_link" ] = arraycombineunique( player.var_6a2d9548aeda69ae[ "super_combat_link" ], [ self ] );
            }
        }
        
        foreach ( player in var_5025545ee3b09b34 )
        {
            if ( !isdefined( player.perks[ "specialty_forwardintel" ] ) )
            {
                player perk::giveperk( "specialty_forwardintel" );
                add_player_buff( player );
            }
            
            if ( !isdefined( currtime ) )
            {
                currtime = gettime();
            }
            
            if ( !isdefined( player.var_57fa68dfcf92a6b6 ) || currtime - player.var_57fa68dfcf92a6b6 > 1000 )
            {
                player playsoundtoplayer( #"hash_7bc6765cdaf6adca", player );
                player.var_57fa68dfcf92a6b6 = currtime;
            }
            
            if ( ownerval )
            {
                if ( !isdefined( ownerval.var_57fa68dfcf92a6b6 ) || currtime - ownerval.var_57fa68dfcf92a6b6 > 1000 )
                {
                    ownerval playsoundtoplayer( #"hash_7bc6765cdaf6adca", ownerval );
                    ownerval.var_57fa68dfcf92a6b6 = currtime;
                }
            }
        }
    }
    
    var_e89bda6949485d40 = arrayremove( var_1ca3f0673ab14217, self.var_9d41a5332c5a2f4b );
    
    if ( var_e89bda6949485d40.size > 0 )
    {
        foreach ( player in var_e89bda6949485d40 )
        {
            if ( self.owner )
            {
                if ( player == self.owner )
                {
                    continue;
                }
                
                basepoints = rank::getscoreinfovalue( #"hash_be9fe6dffa22482b" ) ?? 0;
                self.owner thread points::doscoreevent( #"hash_be9fe6dffa22482b", self.weapon_object, basepoints * self.var_352099d9d2836866 );
            }
            
            player thread points::doscoreevent( #"hash_7fb0d9ee3d1021a", self.weapon_object );
        }
        
        self.var_9d41a5332c5a2f4b = arraycombineunique( self.var_74204d23249ffac5, var_e89bda6949485d40 );
    }
}

// Namespace combat_link
// Params 0
// Checksum 0xe1625474, Offset: 0x1df9
// Size: 0x163
function function_4914ba6d779a11d8()
{
    var_a818ad1d199153c5 = [];
    
    foreach ( affectedtarget in self.affectedtargets )
    {
        if ( !isdefined( affectedtarget ) )
        {
            var_a818ad1d199153c5[ var_a818ad1d199153c5.size ] = affectedtarget;
            continue;
        }
        
        if ( distancesquared( affectedtarget.origin, self.origin ) > self.var_6fa9894e26609396 )
        {
            var_a818ad1d199153c5[ var_a818ad1d199153c5.size ] = affectedtarget;
        }
    }
    
    if ( var_a818ad1d199153c5.size > 0 )
    {
        function_6b4e74acda72ed51( var_a818ad1d199153c5 );
        
        foreach ( var_93abb590294fa59e in var_a818ad1d199153c5 )
        {
            self.affectedtargets = arrayremove( self.affectedtargets, var_93abb590294fa59e );
        }
    }
    
    self.affectedtargets = function_46f9072493651dc9( self.affectedtargets );
}

// Namespace combat_link
// Params 0
// Checksum 0x4ef25a51, Offset: 0x1f64
// Size: 0x326
function function_c5c7c0937295263f()
{
    partition = function_d61c2d865b3d0d9();
    
    foreach ( targetarray in partition utility::function_92fef8fe5211a388( self.origin ) )
    {
        targetarray = function_46f9072493651dc9( targetarray );
        
        foreach ( var_56d7233e3f7fb0b in targetarray )
        {
            if ( !isdefined( var_56d7233e3f7fb0b ) )
            {
                continue;
            }
            
            if ( !isdefined( var_56d7233e3f7fb0b.superref ) && !isdefined( var_56d7233e3f7fb0b.equipmentref ) && !isdefined( var_56d7233e3f7fb0b.streakinfo ) )
            {
                continue;
            }
            
            if ( arraycontains( self.affectedtargets, var_56d7233e3f7fb0b ) )
            {
                continue;
            }
            
            if ( arraycontains( self.ignoredtargets, var_56d7233e3f7fb0b ) )
            {
                continue;
            }
            
            if ( var_56d7233e3f7fb0b.exploding )
            {
                continue;
            }
            
            if ( var_56d7233e3f7fb0b == self )
            {
                self.ignoredtargets[ self.ignoredtargets.size ] = var_56d7233e3f7fb0b;
                continue;
            }
            
            var_dd3923e15cacf70e = var_56d7233e3f7fb0b.owner;
            
            if ( !isdefined( var_dd3923e15cacf70e ) )
            {
                if ( isdefined( var_56d7233e3f7fb0b.vehicle ) )
                {
                    var_dd3923e15cacf70e = var_56d7233e3f7fb0b.vehicle.owner;
                }
                else if ( isdefined( var_56d7233e3f7fb0b.weapon_name ) && weaponclass( var_56d7233e3f7fb0b.weapon_name ) == "grenade" )
                {
                    var_dd3923e15cacf70e = getmissileowner( var_56d7233e3f7fb0b );
                }
            }
            
            if ( isdefined( var_dd3923e15cacf70e ) && player_utility::playersareenemies( self.owner, var_dd3923e15cacf70e ) )
            {
                self.ignoredtargets[ self.ignoredtargets.size ] = var_56d7233e3f7fb0b;
                continue;
            }
            
            if ( function_5d70c0143984dde0( var_56d7233e3f7fb0b ) )
            {
                if ( distancesquared( var_56d7233e3f7fb0b.origin, self.origin ) <= self.var_8f87d86bdd5b3a19 )
                {
                    self.affectedtargets[ self.affectedtargets.size ] = var_56d7233e3f7fb0b;
                    params = spawnstruct();
                    params.combatlink = self;
                    params.bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_combat_link" );
                    var_56d7233e3f7fb0b [[ var_56d7233e3f7fb0b.add_buff ]]( params );
                    var_56d7233e3f7fb0b playsound( "fup_combat_link_linking" );
                    thread function_e8b4f7f663929b46( var_56d7233e3f7fb0b );
                }
                
                continue;
            }
            
            if ( isdefined( var_56d7233e3f7fb0b.superref ) || isdefined( var_56d7233e3f7fb0b.equipmentref ) || isdefined( var_56d7233e3f7fb0b.streakinfo ) )
            {
                self.ignoredtargets[ self.ignoredtargets.size ] = var_56d7233e3f7fb0b;
            }
        }
    }
}

// Namespace combat_link
// Params 0
// Checksum 0xa172345e, Offset: 0x2292
// Size: 0x1d
function monitor_players()
{
    function_3a9ef3d5a4d0d600();
    
    if ( !self.var_7568cab78e4268cc )
    {
        function_34dd512bd473fbe3();
    }
}

// Namespace combat_link
// Params 0
// Checksum 0x287f69eb, Offset: 0x22b7
// Size: 0x1d
function monitor_targets()
{
    function_4914ba6d779a11d8();
    
    if ( !self.var_7568cab78e4268cc )
    {
        function_c5c7c0937295263f();
    }
}

// Namespace combat_link
// Params 1, eflags: 0x4
// Checksum 0xc59cca2a, Offset: 0x22dc
// Size: 0xa9, Type: bool
function private function_a5ba33b356add5e1( target )
{
    if ( target.superref && arraycontains( self.var_5fc9f9bcb532c207, target.superref ) )
    {
        return true;
    }
    else if ( target.equipmentref && arraycontains( self.var_5fc9f9bcb532c207, target.equipmentref ) )
    {
        return true;
    }
    else if ( target.streakinfo && target.streakname && arraycontains( self.var_5fc9f9bcb532c207, target.streakname ) )
    {
        return true;
    }
    
    return false;
}

// Namespace combat_link
// Params 1, eflags: 0x4
// Checksum 0xf7914c14, Offset: 0x238e
// Size: 0x6d, Type: bool
function private function_5d70c0143984dde0( target )
{
    if ( !function_a5ba33b356add5e1( target ) )
    {
        return false;
    }
    
    /#
        InvalidOpCode( 0x5e, isdefined( target.remove_buff ), isdefined( target.add_buff ), "<dev string:x24>" );
        // Unknown operator ( 0x5e, t11, Black Ops 7 )
    #/
    
    if ( !isfunction( target.remove_buff ) )
    {
        return false;
    }
    
    if ( !isfunction( target.add_buff ) )
    {
        return false;
    }
    
    return true;
}

// Namespace combat_link
// Params 1
// Checksum 0x95e15fb1, Offset: 0x2404
// Size: 0xd0
function function_6b4e74acda72ed51( var_a818ad1d199153c5 )
{
    foreach ( var_93abb590294fa59e in var_a818ad1d199153c5 )
    {
        if ( !isdefined( var_93abb590294fa59e ) )
        {
            continue;
        }
        
        if ( function_5d70c0143984dde0( var_93abb590294fa59e ) )
        {
            params = { #bundle:supers_mp::function_5ffd3dfa9cc1e8de( "super_combat_link" ), #combatlink:self };
            var_93abb590294fa59e [[ var_93abb590294fa59e.remove_buff ]]( params );
            function_4970ffac4423e5ea( var_93abb590294fa59e );
        }
    }
}

// Namespace combat_link
// Params 0
// Checksum 0x75b9038e, Offset: 0x24dc
// Size: 0x6e
function function_e416df64d2765695()
{
    function_675672e0e2ec3668( self.var_74204d23249ffac5 );
    function_6b4e74acda72ed51( self.affectedtargets );
    self.affectedtargets = [];
    
    if ( self.owner.combat_links )
    {
        self.owner.combat_links = arrayremove( self.owner.combat_links, self );
    }
}

// Namespace combat_link
// Params 1
// Checksum 0x25a89cba, Offset: 0x2552
// Size: 0xb8
function function_2591addd453cc91d( data )
{
    attacker = isplayer( data ) ? data : data.attacker;
    objweapon = isplayer( data ) ? undefined : data.objweapon;
    self notify( #"enemy_destroyed_equipment", attacker );
    
    if ( player_utility::playersareenemies( self.owner, attacker ) )
    {
        self.owner thread equipment_utility::function_72a91d0610eb601c( self.superref, #"destroyed", #"destroyed_multiple" );
        thread supers_mp::function_579d273895a60bdb( attacker, objweapon );
    }
    
    thread cleanup_and_delete( 0.1, 1 );
}

// Namespace combat_link
// Params 1
// Checksum 0x10454b4b, Offset: 0x2612
// Size: 0x17
function handle_damage( data )
{
    return data.damage;
}

// Namespace combat_link
// Params 0
// Checksum 0x90b340a1, Offset: 0x2632
// Size: 0x35
function function_74b6e2ef5d892fe5()
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_combat_link" );
    var_a1ef7b68f56cabb4 = bundle.var_fd54cbce204253b8 ?? 1;
    return var_a1ef7b68f56cabb4;
}

// Namespace combat_link
// Params 2, eflags: 0x4
// Checksum 0xe92ab216, Offset: 0x2670
// Size: 0x264
function private hack( hackeffect, attacker )
{
    if ( !hackeffect.var_30e7de3d76d5a085 )
    {
        return;
    }
    
    self.owner thread equipment_utility::function_364a1a0e0c018518( self.equipmentref, #"stolen_hacked" );
    self notify( #"hacked" );
    
    if ( self.owner )
    {
        if ( utility::issharedfuncdefined( #"weapons", #"removeequip" ) )
        {
            self.owner [[ utility::getsharedfunc( #"weapons", #"removeequip" ) ]]( self );
        }
    }
    
    if ( utility::issharedfuncdefined( #"dlog", #"fieldupgradeexpired" ) )
    {
        [[ utility::getsharedfunc( #"dlog", #"fieldupgradeexpired" ) ]]( self.owner, self.superid, self.usedcount, 0 );
    }
    
    function_e416df64d2765695();
    equipment_interact::function_2e1b95de8d0440b9();
    function_828173dab997990a();
    self.owner = attacker;
    self.team = attacker.team;
    self.pers[ "team" ] = attacker.team;
    self setentityowner( attacker );
    self setotherent( attacker );
    self setscriptablepartstate( #"hacked", #"stolen", 0 );
    
    if ( self.bundle.var_bead9b1c34058722 )
    {
        var_aacb78da5016573c = self.bundle.var_9d83d7a2c4169a01 ?? 0.3;
        destroyrange = self.bundle.var_d698fcfe464f1b17 ?? 128;
        hintstring = self.bundle.var_dfc5df4b445d78b1 ?? &"super_mp/destroy_super";
        thread equipment_interact::function_226793772d245e96( var_aacb78da5016573c, destroyrange, hintstring, self.team );
    }
    
    thread watchtimeoutorgameended();
    utility::callsharedfunc( #"jamming_system", #"hash_bdfef7c0d312ab04", self );
    
    if ( level.teambased )
    {
        self filteroutplayermarks( self.owner.team );
    }
    else
    {
        self filteroutplayermarks( self.owner );
    }
    
    function_b98aaf47929af30f();
}

// Namespace combat_link
// Params 1, eflags: 0x4
// Checksum 0xeed5b193, Offset: 0x28dc
// Size: 0x70
function private updatedisable( var_4bd50080cf091b94 )
{
    if ( var_4bd50080cf091b94.var_7568cab78e4268cc )
    {
        var_4bd50080cf091b94 notify( #"emp_disable" );
        var_4bd50080cf091b94 function_e416df64d2765695();
        var_4bd50080cf091b94 function_1cf7ce607bf56f2c();
        return;
    }
    
    var_4bd50080cf091b94 setscriptablepartstate( #"jammed", #"off", 0 );
    var_4bd50080cf091b94 setscriptablepartstate( #"emped", #"off", 0 );
}

// Namespace combat_link
// Params 1, eflags: 0x4
// Checksum 0x7b801f88, Offset: 0x2954
// Size: 0x56
function private function_f2fdd019aa1d97a6( var_4bd50080cf091b94 )
{
    if ( !isdefined( var_4bd50080cf091b94.var_7568cab78e4268cc ) )
    {
        var_4bd50080cf091b94.var_7568cab78e4268cc = 0;
    }
    
    var_4bd50080cf091b94.var_7568cab78e4268cc++;
    var_4bd50080cf091b94 setscriptablepartstate( #"jammed", #"on", 0 );
    updatedisable( var_4bd50080cf091b94 );
}

// Namespace combat_link
// Params 1, eflags: 0x4
// Checksum 0xaaab0e52, Offset: 0x29b2
// Size: 0x21
function private function_655bd8caffa5d850( var_4bd50080cf091b94 )
{
    var_4bd50080cf091b94.var_7568cab78e4268cc--;
    updatedisable( var_4bd50080cf091b94 );
}

// Namespace combat_link
// Params 1
// Checksum 0xbaf0913b, Offset: 0x29db
// Size: 0x51
function empapplycallback( data )
{
    var_a1ef7b68f56cabb4 = function_74b6e2ef5d892fe5();
    
    if ( var_a1ef7b68f56cabb4 )
    {
        function_206cacbbecbac4f2( data );
        return;
    }
    
    self setscriptablepartstate( #"emped", #"on", 0 );
    function_93f7153ed2625594( data );
}

// Namespace combat_link
// Params 1
// Checksum 0xda007db7, Offset: 0x2a34
// Size: 0x6b
function function_206cacbbecbac4f2( data )
{
    self notify( #"enemy_destroyed_equipment", data.attacker );
    
    if ( player_utility::playersareenemies( self.owner, data.attacker ) )
    {
        thread supers_mp::function_579d273895a60bdb( data.attacker, data.objweapon );
    }
    
    thread cleanup_and_delete( 0.1, 1 );
}

// Namespace combat_link
// Params 1
// Checksum 0x36361a49, Offset: 0x2aa7
// Size: 0x34
function function_93f7153ed2625594( data )
{
    if ( !isdefined( self.var_7568cab78e4268cc ) )
    {
        self.var_7568cab78e4268cc = 0;
    }
    
    self.var_7568cab78e4268cc++;
    updatedisable( self );
}

// Namespace combat_link
// Params 1
// Checksum 0x60c1d67, Offset: 0x2ae3
// Size: 0x32
function empremovecallback( data )
{
    assert( !function_74b6e2ef5d892fe5(), "<dev string:x69>" );
    self.var_7568cab78e4268cc--;
    updatedisable( self );
}

// Namespace combat_link
// Params 2
// Checksum 0xb5b4018e, Offset: 0x2b1d
// Size: 0x1c7
function cleanup_and_delete( deletiondelay, wasdestroyed )
{
    self notify( #"death" );
    
    if ( self.isdestroyed )
    {
        return;
    }
    
    self setscriptablepartstate( #"destroy", #"active", 0 );
    self.isdestroyed = 1;
    
    if ( level.combatlinks )
    {
        level.combatlinks = arrayremove( level.combatlinks, self );
    }
    
    if ( !level.combatlinks.size )
    {
        level.combatlinks = undefined;
    }
    
    wait deletiondelay ?? 0.1;
    utility::callsharedfunc( #"jamming_system", #"hash_c33ceb91d0ca7a9d", self );
    
    if ( isdefined( self.owner ) )
    {
        if ( utility::issharedfuncdefined( #"weapons", #"removeequip" ) )
        {
            self.owner [[ utility::getsharedfunc( #"weapons", #"removeequip" ) ]]( self );
        }
    }
    
    if ( utility::issharedfuncdefined( #"dlog", #"fieldupgradeexpired" ) )
    {
        [[ utility::getsharedfunc( #"dlog", #"fieldupgradeexpired" ) ]]( self.owner, self.superid, self.usedcount, istrue( wasdestroyed ) );
    }
    
    function_e416df64d2765695();
    
    if ( isdefined( self.owner ) && self.bundle.var_1de70947c71270ec )
    {
        self.owner setclientomnvar( self.bundle.var_1de70947c71270ec, 0 );
    }
    
    self.owner.var_5fa518a6c5ba513a = undefined;
    function_aacd62dc3f24fccb();
    function_828173dab997990a();
    self delete();
}

// Namespace combat_link
// Params 0
// Checksum 0x29f1ee40, Offset: 0x2cec
// Size: 0x23
function function_d61c2d865b3d0d9()
{
    if ( level.var_8ea021a8f6ed266e == gettime() )
    {
        return level.combat_link_partition;
    }
    
    return function_8884314bc0f6447f();
}

// Namespace combat_link
// Params 0, eflags: 0x4
// Checksum 0x7a2d2271, Offset: 0x2d18
// Size: 0x68
function private function_8884314bc0f6447f()
{
    var_e7ada01e5a5e08e8 = function_be0dd53539a68b65( level.grenades, level.missiles, weapon::function_3aafcaf7ff6dea9e(), level.projectilekillstreaks, level.activekillstreaks );
    level.combat_link_partition = utility::create_partition( var_e7ada01e5a5e08e8, 500, 1 );
    level.var_8ea021a8f6ed266e = gettime();
    return level.combat_link_partition;
}

// Namespace combat_link
// Params 0
// Checksum 0x794bfdc3, Offset: 0x2d89
// Size: 0x280
function function_aacd62dc3f24fccb()
{
    level endon( #"game_ended" );
    self.owner endon( #"disconnect" );
    
    if ( !self.owner || self.owner.var_5fa518a6c5ba513a )
    {
        return;
    }
    
    self.owner.var_5fa518a6c5ba513a = 1;
    
    if ( self.bundle.var_c96ce6e38e64ccf9 )
    {
        assert( isdefined( self.bundle.var_22b9b7a586dfc524 ), "<dev string:xb5>" );
        self.owner setclientomnvar( self.bundle.var_c96ce6e38e64ccf9, self.bundle.var_22b9b7a586dfc524 );
    }
    
    if ( self.bundle.var_1de70947c71270ec )
    {
        if ( self.owner.combat_links && self.owner.combat_links.size > 0 )
        {
            var_7f131fc6779fd630 = [];
            
            foreach ( combat_link in self.owner.combat_links )
            {
                if ( combat_link.affectedtargets && combat_link.affectedtargets.size > 0 )
                {
                    var_7f131fc6779fd630 = arraycombineunique( var_7f131fc6779fd630, combat_link.affectedtargets );
                }
                
                if ( combat_link.var_74204d23249ffac5 && combat_link.var_74204d23249ffac5.size > 0 )
                {
                    var_7f131fc6779fd630 = arraycombineunique( var_7f131fc6779fd630, combat_link.var_74204d23249ffac5 );
                }
            }
            
            self.owner setclientomnvar( self.bundle.var_1de70947c71270ec, 1 + ( var_7f131fc6779fd630.size ? int( min( var_7f131fc6779fd630.size, 11 ) ) : 0 ) );
        }
        else
        {
            self.owner setclientomnvar( self.bundle.var_1de70947c71270ec, 0 );
        }
    }
    
    function_58516515c05c3ff0();
    waitframe();
    
    if ( self.owner )
    {
        self.owner.var_5fa518a6c5ba513a = undefined;
    }
}

