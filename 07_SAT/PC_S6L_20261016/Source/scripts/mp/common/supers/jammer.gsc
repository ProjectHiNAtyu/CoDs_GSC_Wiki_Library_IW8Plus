// scripts\mp\common\supers\jammer.gsc  (hash_5f79c84fc810da15.gscc) (size: 11752 Bytes / 0x2de8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7c55db6d (2086001517)
// size ...... 11752 (0x2de8)
// includes .. 21  (offset: 0x2bb8)
// strings ... 19  (offset: 0x2c60)
// dev strs .. 6   (offset: 0x2da0)
// exports ... 26  (offset: 0x1d18)
// cseg ...... 0x1da + 0x1b3e (0x1d18)
// imports ... 87  (offset: 0x2128)
// animtree1 . 0   (offset: 0x2de8)
// animtree2 . 0   (offset: 0x2de8)
#using script_16ea1b94f0f381b3;
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\challenges;
#using scripts\mp\common\perks\perkpackage;
#using scripts\mp\common\utility\equipment;
#using scripts\mp\common\utility\equipment_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\damage;
#using scripts\mp\entityheadicons;
#using scripts\mp\equipment;
#using scripts\mp\equipment_interact;
#using scripts\mp\gamelogic;
#using scripts\mp\hud_message;
#using scripts\mp\rank;
#using scripts\mp\supers;
#using scripts\mp\telemetry_mp;
#using scripts\mp\weapons;

#namespace jammer;

// Namespace jammer
// Params 0, eflags: 0x1
// Checksum 0xf6ef217d, Offset: 0x1f8
// Size: 0x17
function autoexec main()
{
    supers_mp::function_adf2820d5daa2e81( #"super_jammer", &jammer_init );
}

// Namespace jammer
// Params 0
// Checksum 0x6faf4a4e, Offset: 0x217
// Size: 0xe5
function jammer_init()
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_jammer" );
    assert( isdefined( bundle ), "<dev string:x24>" );
    assert( isdefined( bundle.jammer_radius ), "<dev string:x3d>" );
    assert( isdefined( bundle.var_e85a3649a92c99c3 ), "<dev string:x56>" );
    assert( isdefined( bundle.jammer_health ), "<dev string:x71>" );
    weapons::registerusedcallback( "jammer", &jammer_used );
    level callback::add( #"player_laststand", &onplayerlaststand );
    level callback::add( #"player_death", &onplayerdeath );
    level callback::add( #"player_disconnect", &onplayerdisconnect );
    utility::registersharedfunc( #"jammer", #"hack", &hack );
}

// Namespace jammer
// Params 2, eflags: 0x4
// Checksum 0x67df0496, Offset: 0x304
// Size: 0x127
function private hack( hackeffect, attacker )
{
    if ( !hackeffect.var_30e7de3d76d5a085 )
    {
        return;
    }
    
    self.owner thread equipment_utility::function_364a1a0e0c018518( self.equipmentref, #"stolen_hacked" );
    equipment_interact::function_2e1b95de8d0440b9();
    equipment_mp::hackequipment( attacker, hackeffect.var_fe6111ff085b2063 );
    self setscriptablepartstate( #"hacked", #"stolen", 0 );
    
    if ( self.bundle.var_bead9b1c34058722 )
    {
        var_aacb78da5016573c = self.bundle.var_9d83d7a2c4169a01 ?? 0.3;
        destroyrange = self.bundle.var_d698fcfe464f1b17 ?? 128;
        hintstring = self.bundle.var_dfc5df4b445d78b1 ?? &"super_mp/destroy_super";
        thread equipment_interact::function_226793772d245e96( var_aacb78da5016573c, destroyrange, hintstring, self.team );
    }
    
    thread jammer_watchtimeout( self.bundle );
}

// Namespace jammer
// Params 1
// Checksum 0xb5f6003c, Offset: 0x433
// Size: 0x4e7
function jammer_used( jammer )
{
    self endon( #"death_or_disconnect" );
    self endon( #"death" );
    jammer.superref = "super_jammer";
    jammer.var_30656af96b2ac2a4 = [];
    jammer.add_buff = &add_buff;
    jammer.remove_buff = &remove_buff;
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_jammer" );
    jammer.bundle = bundle;
    
    if ( jammer.bundle.var_e36b84555e7df1d3 && supers_mp::function_d45945781d29204a( "super_jammer", jammer.bundle.var_e36b84555e7df1d3 ) )
    {
        jammer.var_3695df5e0f59b718 = &function_f2dd62d2e40cc8b6;
    }
    
    plantdata = {};
    plantdata.throwspeedforward = 100;
    plantdata.throwspeedup = -50;
    plantdata.castdivisions = 3;
    plantdata.castmaxtime = 0.5;
    plantdata.castdetail = 1;
    plantdata.plantmaxtime = 0.5;
    plantdata.plantmaxroll = 15;
    plantdata.plantmindistbeloweye = 12;
    plantdata.plantmaxdistbelowownerfeet = 20;
    plantdata.plantmindisteyetofeet = 45;
    plantdata.plantnormalcos = 0.342;
    plantdata.plantoffsetz = 3;
    plantdata.detectwater = 1;
    plantdata.var_8fa73627c255b85d = 0;
    plantdata.contents = physics_createcontents( [ "physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_glass" ] );
    jammer thread equipment_interact::remoteinteractsetup( &jammer_destroy, 0, 1 );
    plantresult = equipment::plant( jammer, plantdata );
    
    if ( plantresult.result )
    {
        jammer.issuper = 1;
        jammer.ownerteam = self.team;
        imageoverride = jammer.var_30656af96b2ac2a4.size > 0 ? jammer.bundle.buffedheadicon : undefined;
        jammer.headiconid = entityheadicons::setheadicon_equipment( jammer, imageoverride );
        jammer.radius = bundle.jammer_radius;
        var_b67f9c5cac29d71f = 1;
        
        if ( bundle.var_c7709714d768097c && supers_mp::function_d45945781d29204a( "super_jammer", bundle.var_c7709714d768097c ) )
        {
            assert( bundle.var_fe2f47c6c898bc96, "<dev string:x8a>" );
            var_b67f9c5cac29d71f = bundle.var_fe2f47c6c898bc96 ?? 1.6;
        }
        
        jammer.radius *= var_b67f9c5cac29d71f;
        jammer utility::callsharedfunc( #"jamming_system", #"hash_a9ecee5e61a86c7b", bundle.var_dca4040644758c48 );
        jammer thread damage::monitordamage( bundle.jammer_health, "hitequip", &function_c992a8e9f57bee8 );
        jammer function_d8dc84bf008cda16();
        jammer namespace_9d8e359c3b1041e5::emp_debuff_register_sharedfunc( jammer, &jammer_emp_applied, undefined, &jammer_emp_cleared );
        weapons::onequipmentplanted( jammer, "equip_jammer", &jammer_destroy );
        thread weapons::monitordisownedequipment( self, jammer );
        jammer thread function_dbc4726aac60da72();
        jammer thread jammer_watchtimeout( bundle );
        
        if ( bundle.var_bead9b1c34058722 )
        {
            var_aacb78da5016573c = bundle.var_9d83d7a2c4169a01 ?? 0.3;
            destroyrange = bundle.var_d698fcfe464f1b17 ?? 128;
            hintstring = bundle.var_dfc5df4b445d78b1 ?? &"super_mp/destroy_super";
            jammer thread equipment_interact::function_226793772d245e96( var_aacb78da5016573c, destroyrange, hintstring, jammer.ownerteam );
        }
        
        jammer setscriptablepartstate( #"visibility", #"show" );
        utility::function_969f9f5596dba07a( jammer, &jammer_destroy );
        challenges::function_a0936b0e5b4550f3( "super_jammer", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"use" ) );
        return;
    }
    
    if ( plantresult.waterimpact )
    {
        jammer jammer_destroy();
        return;
    }
    
    hud_message::showerrormessage( %"equipment/plant_failed" );
    
    if ( isbrgamemode() )
    {
        perkpackage::perkpackage_giveimmediate( "super_jammer" );
        self setclientomnvar( "ui_perk_package_state", 3 );
        self setclientomnvar( "ui_perk_package_super1", supers_mp::getsuperid( "super_jammer" ) );
    }
    else
    {
        supers_mp::function_235acb90dc5ccdbe();
    }
    
    if ( isdefined( jammer ) )
    {
        jammer delete();
    }
}

// Namespace jammer
// Params 1
// Checksum 0xf50e7c7, Offset: 0x922
// Size: 0x222
function add_buff( params )
{
    if ( isarray( self.var_30656af96b2ac2a4 ) )
    {
        self.var_30656af96b2ac2a4[ self.var_30656af96b2ac2a4.size ] = params.combatlink;
        
        if ( !self.var_2695e71ddf32816c[ params.combatlink.owner getentitynumber() ] )
        {
            basepoints = rank::getscoreinfovalue( #"hash_9b8ab744d40aa882" ) ?? 0;
            params.combatlink.owner thread points::doscoreevent( #"hash_9b8ab744d40aa882", params.combatlink.weapon_object, basepoints * params.combatlink.var_352099d9d2836866 );
            
            if ( !isdefined( self.var_2695e71ddf32816c ) )
            {
                self.var_2695e71ddf32816c = [];
            }
            
            self.var_2695e71ddf32816c[ params.combatlink.owner getentitynumber() ] = 1;
        }
        
        if ( params.combatlink.owner != self.owner && !self.var_2b2f786d6b12c032 )
        {
            self.owner thread points::doscoreevent( #"hash_5ffd6a7c85f19d10", params.combatlink.weapon_object );
            self.var_2b2f786d6b12c032 = 1;
        }
        
        if ( self.var_30656af96b2ac2a4.size == 1 )
        {
            var_f19c394e83c2c484 = params.bundle.var_4028f75cefdb6ff8 ?? 1;
            self.var_7b9f89adb3cab2ec = var_f19c394e83c2c484;
            
            if ( isdefined( self.radius ) )
            {
                update_circle_radius( self.radius * var_f19c394e83c2c484 );
            }
            
            if ( isdefined( self.headiconid ) && isdefined( self.bundle.buffedheadicon ) )
            {
                setheadiconimage( self.headiconid, self.bundle.buffedheadicon, 1 );
            }
        }
    }
}

// Namespace jammer
// Params 1
// Checksum 0xacf883a4, Offset: 0xb4c
// Size: 0xc8
function remove_buff( params )
{
    if ( isarray( self.var_30656af96b2ac2a4 ) )
    {
        if ( arraycontains( self.var_30656af96b2ac2a4, params.combatlink ) )
        {
            self.var_30656af96b2ac2a4 = arrayremove( self.var_30656af96b2ac2a4, params.combatlink );
            
            if ( self.var_30656af96b2ac2a4.size <= 0 )
            {
                self.var_7b9f89adb3cab2ec = undefined;
                update_circle_radius( self.radius );
                
                if ( isdefined( self.headiconid ) && isdefined( level.gamemodebundle.var_a43747faa623d1b0 ) )
                {
                    setheadiconimage( self.headiconid, level.gamemodebundle.var_a43747faa623d1b0, 1 );
                }
            }
        }
    }
}

// Namespace jammer
// Params 1, eflags: 0x4
// Checksum 0xecbca818, Offset: 0xc1c
// Size: 0x72
function private update_circle_radius( newradius )
{
    if ( !isdefined( newradius ) )
    {
        assertmsg( "<dev string:xdf>" );
        return;
    }
    
    if ( self.friendlycircle.mapcircle && self.enemycircle.mapcircle )
    {
        self.friendlycircle game_utility::function_d46d8731ed9d281( newradius );
        self.enemycircle game_utility::function_d46d8731ed9d281( newradius );
    }
}

// Namespace jammer
// Params 1, eflags: 0x4
// Checksum 0xf7d7ae0, Offset: 0xc96
// Size: 0x15
function private function_11515a66f83bfe0( attacker )
{
    jammer_destroy( attacker );
}

// Namespace jammer
// Params 0, eflags: 0x4
// Checksum 0x6e39e011, Offset: 0xcb3
// Size: 0xa1
function private function_dbc4726aac60da72()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"enemy_destroyed_equipment" );
    self endon( #"mine_destroyed" );
    var_eff8acc2dbc402e4 = level.sharedfuncs[ #"jamming_system" ][ #"hash_775c9b54e8085ae5" ];
    
    while ( true )
    {
        previousowner = self.owner;
        self waittill( #"hack_successful", hacker );
        thread weapons::monitordisownedequipment( hacker, self );
        self [[ var_eff8acc2dbc402e4 ]]( self, previousowner, hacker );
    }
}

// Namespace jammer
// Params 0, eflags: 0x4
// Checksum 0x49299635, Offset: 0xd5c
// Size: 0xd6
function private function_d8dc84bf008cda16()
{
    jammer = self;
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_jammer" );
    var_6c4309a64877bed4 = jammer.radius;
    
    if ( isdefined( jammer.var_7b9f89adb3cab2ec ) )
    {
        var_6c4309a64877bed4 *= jammer.var_7b9f89adb3cab2ec;
    }
    
    jammer function_7a31599bd17c86f4( jammer, var_6c4309a64877bed4 );
    jammer thread function_3ac6b01b09e3893a();
    jammer.owner [[ level.sharedfuncs[ #"jamming_system" ][ #"registerjammer" ] ]]( jammer, jammer.radius );
    jammer setscriptablepartstate( #"warning_audio", #"on" );
    jammer setscriptablepartstate( #"emp", #"neutral" );
}

// Namespace jammer
// Params 0, eflags: 0x4
// Checksum 0x766d43a2, Offset: 0xe3a
// Size: 0x6e
function private function_b79571a940ab347()
{
    jammer = self;
    jammer.owner [[ level.sharedfuncs[ #"jamming_system" ][ #"deregisterjammer" ] ]]( jammer );
    jammer setscriptablepartstate( #"warning_audio", #"off" );
    jammer setscriptablepartstate( #"emp", #"active" );
}

// Namespace jammer
// Params 0, eflags: 0x4
// Checksum 0x2b83d7d6, Offset: 0xeb0
// Size: 0x29, Type: bool
function private function_6bc7449225a12765()
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_jammer" );
    return bundle.var_797329c2598c40de ?? 1;
}

// Namespace jammer
// Params 1, eflags: 0x4
// Checksum 0x37d14035, Offset: 0xee2
// Size: 0x48
function private jammer_emp_applied( data )
{
    if ( function_6bc7449225a12765() )
    {
        self notify( #"enemy_destroyed_equipment", data.attacker );
        jammer_destroy( data.attacker );
        return;
    }
    
    function_b79571a940ab347();
}

// Namespace jammer
// Params 1, eflags: 0x4
// Checksum 0x1b539c95, Offset: 0xf32
// Size: 0x13
function private jammer_emp_cleared( var_d36c41ff2a669928 )
{
    function_d8dc84bf008cda16();
}

// Namespace jammer
// Params 2, eflags: 0x4
// Checksum 0xca6f6b63, Offset: 0xf4d
// Size: 0x93
function private function_7a31599bd17c86f4( jammer, radius )
{
    if ( !isdefined( jammer.enemycircle ) )
    {
        jammer.enemycircle = {};
    }
    
    if ( !isdefined( jammer.friendlycircle ) )
    {
        jammer.friendlycircle = {};
    }
    
    jammer.friendlycircle game_utility::questcircle_create( "JammerCircleFriendly", jammer.origin, radius );
    jammer.enemycircle game_utility::questcircle_create( "JammerCircleEnemy", jammer.origin, radius );
}

// Namespace jammer
// Params 0, eflags: 0xc
// Checksum 0x7aea32fd, Offset: 0xfe8
// Size: 0x19d
function private function_3ac6b01b09e3893a()
{
    self notify( #"hash_37c0f1f9034e7656" );
    self endon( #"hash_37c0f1f9034e7656" );
    self endon( #"death", #"destroyed" );
    level endon( #"game_ended" );
    wait 0.1;
    
    while ( true )
    {
        self.var_55e93950292bdfbd = 0;
        
        if ( self.enemycircle.mapcircle && ( self.enemycircle.mapcircle.origin[ 0 ] != self.origin[ 0 ] || self.enemycircle.mapcircle.origin[ 1 ] != self.origin[ 1 ] ) )
        {
            self.enemycircle game_utility::questcircle_move( self.origin );
            self.var_55e93950292bdfbd = 1;
        }
        
        if ( self.friendlycircle.mapcircle && ( self.friendlycircle.mapcircle.origin[ 0 ] != self.origin[ 0 ] || self.friendlycircle.mapcircle.origin[ 1 ] != self.origin[ 1 ] ) )
        {
            self.friendlycircle game_utility::questcircle_move( self.origin );
            self.var_55e93950292bdfbd = 1;
        }
        
        if ( self.var_55e93950292bdfbd )
        {
            waitframe();
            continue;
        }
        
        wait 0.25;
    }
}

// Namespace jammer
// Params 1, eflags: 0x4
// Checksum 0xf39d4cda, Offset: 0x118d
// Size: 0x2c
function private function_c992a8e9f57bee8( data )
{
    self notify( #"enemy_destroyed_equipment", data.attacker );
    jammer_destroy( data );
}

// Namespace jammer
// Params 1
// Checksum 0x8a83e6f9, Offset: 0x11c1
// Size: 0xf6
function jammer_destroy( data )
{
    if ( self.isdestroyed )
    {
        return;
    }
    
    self.isdestroyed = 1;
    attacker = isplayer( data ) ? data : data.attacker;
    objweapon = isplayer( data ) ? undefined : data.objweapon;
    
    if ( player_utility::playersareenemies( self.owner, attacker ) )
    {
        utility::callsharedfunc( #"supers", #"hash_28aeb93023a8a138", attacker, objweapon );
    }
    
    equipment_interact::function_2e1b95de8d0440b9();
    self setscriptablepartstate( #"effects", #"destroy" );
    self setscriptablepartstate( #"warning_audio", #"off" );
    self setscriptablepartstate( #"hack_usable", #"off" );
    thread jammer_delete( 0.1 );
}

// Namespace jammer
// Params 1, eflags: 0x4
// Checksum 0xa2223955, Offset: 0x12bf
// Size: 0x125
function private jammer_delete( deletiondelay )
{
    if ( !isdefined( self.owner ) )
    {
        return;
    }
    
    self.owner [[ level.sharedfuncs[ #"jamming_system" ][ #"deregisterjammer" ] ]]( self );
    namespace_9d8e359c3b1041e5::emp_debuff_deregister_sharedfunc( self );
    entityheadicons::setheadicon_deleteicon( self.headiconid );
    self.headiconid = undefined;
    
    if ( self.friendlycircle )
    {
        self.friendlycircle game_utility::questcircle_delete();
    }
    
    if ( self.enemycircle )
    {
        self.enemycircle game_utility::questcircle_delete();
    }
    
    if ( isdefined( self.owner ) )
    {
        self.owner weapons::removeequip( self );
    }
    
    if ( isdefined( deletiondelay ) )
    {
        wait deletiondelay;
    }
    
    if ( isdefined( self ) )
    {
        if ( isdefined( self.var_28dc346d5a435f02 ) && isplayer( self.owner ) )
        {
            self.owner thread challenges::function_a0936b0e5b4550f3( "super_jammer", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"end" ), self.var_28dc346d5a435f02 );
        }
        
        self delete();
    }
}

// Namespace jammer
// Params 1
// Checksum 0x486ea42e, Offset: 0x13ec
// Size: 0x76
function jammer_watchtimeout( bundle )
{
    self notify( #"hash_b022d357942eb5cf" );
    self endon( #"hash_b022d357942eb5cf" );
    self endon( #"death" );
    self endon( #"destroyed" );
    level endon( #"game_ended" );
    waittime = bundle.jammer_timeout ?? -1;
    
    if ( waittime < 0 )
    {
        return;
    }
    
    wait waittime;
    jammer_destroy();
}

// Namespace jammer
// Params 1, eflags: 0x4
// Checksum 0x9d401fa9, Offset: 0x146a
// Size: 0x296
function private onplayerlaststand( deathdata )
{
    attacker = deathdata.attacker;
    victim = deathdata.victim;
    var_3e95a78db39524cc = [];
    processedset = [];
    
    if ( isdefined( victim.var_3702583f19e5f23b ) )
    {
        foreach ( jammer in victim.var_3702583f19e5f23b )
        {
            owner = jammer.owner;
            
            if ( !isdefined( jammerweapon ) )
            {
                jammerweapon = jammer.weapon_object;
            }
            
            var_4040958bf9528f74 = owner getentitynumber();
            
            if ( isdefined( processedset[ var_4040958bf9528f74 ] ) )
            {
                break;
            }
            
            processedset[ var_4040958bf9528f74 ] = owner;
            
            if ( !player_utility::playersareenemies( owner, victim ) )
            {
                continue;
            }
            
            jammerstruct = {};
            var_3e95a78db39524cc[ var_4040958bf9528f74 ] = jammerstruct;
            jammerstruct.owner = owner;
            
            if ( !isdefined( jammerstruct.jammerweapon ) )
            {
                jammerstruct.jammerweapon = jammer.weapon_object;
            }
            
            if ( attacker == owner )
            {
                jammerstruct.var_d7fa98f1391c1b52 = 1;
                attacker thread gamelogic_mp::threadedsetweaponstatbyname( jammer.weapon_object, 1, "debuff_kills" );
                attacker thread telemetry_mp::function_89a5d8fb8ed3a4fe( deathdata, attacker, jammer getentitynumber(), jammer.weapon_object );
                
                if ( !isdefined( jammer.var_fb60eef7346f479a ) )
                {
                    jammer.var_fb60eef7346f479a = 0;
                }
                
                jammer.var_fb60eef7346f479a += 1;
                
                if ( jammer.var_fb60eef7346f479a == 2 )
                {
                    jammerstruct.var_989d8ed3870147f4 = 1;
                }
                
                continue;
            }
            
            owner thread gamelogic_mp::threadedsetweaponstatbyname( jammer.weapon_object, 1, "debuff_assists" );
            jammerstruct.var_d7fa98f1391c1b52 = 0;
        }
    }
    
    if ( !isdefined( deathdata.callbackeventdata ) )
    {
        deathdata.callbackeventdata = [];
    }
    
    if ( !isdefined( deathdata.callbackeventdata[ "super_jammer" ] ) )
    {
        deathdata.callbackeventdata[ "super_jammer" ] = var_3e95a78db39524cc;
    }
    
    if ( isdefined( jammerweapon ) )
    {
        victim thread gamelogic_mp::threadedsetweaponstatbyname( jammerweapon, 1, "killed_while_debuffed_by" );
    }
}

// Namespace jammer
// Params 1, eflags: 0x4
// Checksum 0xd2f381c2, Offset: 0x1708
// Size: 0x364
function private onplayerdeath( params )
{
    attacker = params.attacker;
    victim = params.victim;
    
    if ( victim.inlaststand )
    {
        laststandattacker = victim.laststanddowneddata.attacker;
        var_3e95a78db39524cc = victim.laststanddowneddata.callbackeventdata[ "super_jammer" ];
        
        if ( isdefined( var_3e95a78db39524cc ) )
        {
            foreach ( jammerstruct in var_3e95a78db39524cc )
            {
                if ( jammerstruct.var_d7fa98f1391c1b52 )
                {
                    laststandattacker thread points::doscoreevent( #"super_jammer_kill", jammerstruct.jammerweapon );
                    
                    if ( jammerstruct.var_989d8ed3870147f4 )
                    {
                        laststandattacker thread points::doscoreevent( #"jammer_double", jammerstruct.jammerweapon );
                    }
                    
                    continue;
                }
                
                jammerstruct.owner thread points::doscoreevent( #"super_jammer_assist", jammerstruct.jammerweapon );
            }
        }
        
        return;
    }
    
    var_843e5456a386a036 = [];
    
    foreach ( jammer in victim.var_3702583f19e5f23b )
    {
        owner = jammer.owner;
        
        if ( !isdefined( jammerweapon ) )
        {
            jammerweapon = jammer.weapon_object;
        }
        
        var_4040958bf9528f74 = owner getentitynumber();
        
        if ( isdefined( var_843e5456a386a036[ var_4040958bf9528f74 ] ) )
        {
            break;
        }
        
        var_843e5456a386a036[ var_4040958bf9528f74 ] = owner;
        
        if ( !player_utility::playersareenemies( owner, victim ) )
        {
            continue;
        }
        
        if ( attacker == owner )
        {
            attacker thread gamelogic_mp::threadedsetweaponstatbyname( jammer.weapon_object, 1, "debuff_kills" );
            attacker thread telemetry_mp::function_89a5d8fb8ed3a4fe( params, attacker, jammer getentitynumber(), jammer.weapon_object );
            attacker thread points::doscoreevent( #"super_jammer_kill", jammer.weapon_object );
            
            if ( !isdefined( jammer.var_fb60eef7346f479a ) )
            {
                jammer.var_fb60eef7346f479a = 0;
            }
            
            jammer.var_fb60eef7346f479a += 1;
            
            if ( jammer.var_fb60eef7346f479a == 2 )
            {
                attacker thread points::doscoreevent( #"jammer_double", jammer.weapon_object );
            }
            
            continue;
        }
        
        owner thread gamelogic_mp::threadedsetweaponstatbyname( jammer.weapon_object, 1, "debuff_assists" );
        owner thread points::doscoreevent( #"super_jammer_assist", jammer.weapon_object );
    }
    
    if ( isdefined( jammerweapon ) )
    {
        victim thread gamelogic_mp::threadedsetweaponstatbyname( jammerweapon, 1, "killed_while_debuffed_by" );
    }
}

// Namespace jammer
// Params 1, eflags: 0x4
// Checksum 0x150ba102, Offset: 0x1a74
// Size: 0x92
function private onplayerdisconnect( params )
{
    if ( isdefined( self.jammers ) )
    {
        foreach ( jammer in self.jammers )
        {
            jammer jammer_destroy();
        }
    }
}

// Namespace jammer
// Params 2
// Checksum 0xe3fb2068, Offset: 0x1b0e
// Size: 0x153
function function_f2dd62d2e40cc8b6( enemy, jammer )
{
    if ( !jammer.owner || !enemy )
    {
        return;
    }
    
    if ( isdefined( enemy.perks[ "specialty_ghost" ] ) )
    {
        return;
    }
    
    jammerid = jammer getentitynumber();
    
    if ( !isdefined( enemy.var_9a1bd8d2c3cf48ef ) )
    {
        enemy.var_9a1bd8d2c3cf48ef = [];
    }
    
    currtime = gettime();
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_jammer" );
    cooldownms = ( bundle.var_c83c528463b4de9b ?? 4 ) * 1000;
    fadetime = bundle.var_81c72572b7de1c65 ?? 1;
    enemy thread function_f672b5ed2ec41cb2( fadetime );
    
    if ( enemy.var_9a1bd8d2c3cf48ef[ jammerid ] && currtime - enemy.var_9a1bd8d2c3cf48ef[ jammerid ] < cooldownms )
    {
        return;
    }
    
    enemy.var_9a1bd8d2c3cf48ef[ jammerid ] = currtime;
    radius = 20;
    var_bfad811bac7c2ef3 = 100;
    triggerportableradarping( enemy.origin, jammer.owner, radius, var_bfad811bac7c2ef3, "", fadetime, 1, 0 );
}

// Namespace jammer
// Params 1
// Checksum 0x661cdf3d, Offset: 0x1c69
// Size: 0xaf
function function_f672b5ed2ec41cb2( duration )
{
    self notify( #"hash_49f3ce991e4caf80" );
    self endon( #"hash_49f3ce991e4caf80" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( self getclientomnvar( "ui_perceptive" ) && self getclientomnvar( "ui_perceptive_indicator" ) != 3 )
    {
        return;
    }
    
    self setclientomnvar( "ui_perceptive", 1 );
    self setclientomnvar( "ui_perceptive_indicator", 3 );
    wait duration;
    
    if ( !self getclientomnvar( "ui_perceptive" ) )
    {
        return;
    }
    
    if ( self getclientomnvar( "ui_perceptive_indicator" ) == 3 )
    {
        self setclientomnvar( "ui_perceptive", 0 );
        self setclientomnvar( "ui_perceptive_indicator", 0 );
    }
}

