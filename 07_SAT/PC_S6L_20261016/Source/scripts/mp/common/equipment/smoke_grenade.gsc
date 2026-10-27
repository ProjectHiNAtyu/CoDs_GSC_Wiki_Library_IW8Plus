// scripts\mp\common\equipment\smoke_grenade.gsc  (hash_57d36367f2709557.gscc) (size: 14623 Bytes / 0x391f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7be4872a (2078574378)
// size ...... 14623 (0x391f)
// includes .. 29  (offset: 0x3683)
// strings ... 25  (offset: 0x376b)
// dev strs .. 7   (offset: 0x38cb)
// exports ... 28  (offset: 0x24cb)
// cseg ...... 0x26f + 0x225c (0x24cb)
// imports ... 111 (offset: 0x292b)
// animtree1 . 0   (offset: 0x391f)
// animtree2 . 0   (offset: 0x391f)
#using script_16ea1b94f0f381b3;
#using script_74b851b7aa1ef32d;
#using scripts\common\ae_utility;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\equipment_common;
#using scripts\common\script;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\challenges;
#using scripts\mp\common\equipment\molotov;
#using scripts\mp\common\perks\perkfunctions;
#using scripts\mp\common\utility\damage;
#using scripts\mp\common\utility\entity;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\print;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\weapons\underbarrel;
#using scripts\mp\ent_manager;
#using scripts\mp\equipment;
#using scripts\mp\gamelogic;
#using scripts\mp\telemetry_mp;
#using scripts\mp\weapons;

#namespace smoke_grenade;

// Namespace smoke_grenade
// Params 0, eflags: 0x1
// Checksum 0xcb1274aa, Offset: 0x28d
// Size: 0x8d
function autoexec smokegrenade_init()
{
    utility::flag_wait( "equipment_initialized" );
    perkfunctions::function_deeb2f40153920c7( "smoke_grenade", &function_19249817199475c );
    weapons::registerusedcallback( "smoke_grenade", &smokegrenadeused );
    
    if ( game_utility::function_c446c60d2979dbfe() )
    {
        weapons::registeragentusedcallback( "smoke_grenade", &smokegrenadeused );
    }
    
    if ( !utility::callsharedfunc( #"smokemanager", #"hash_93bde91ae637affe" ) )
    {
        level callback::add( #"hash_851f50ff5797e453", &function_52037f1beb2ed379 );
    }
    
    underbarrel::function_ad8d55243cf37b5b( "specialty_ub_smoke", &smokegrenadeused );
}

// Namespace smoke_grenade
// Params 0
// Checksum 0xe611db58, Offset: 0x322
// Size: 0x3a
function function_19249817199475c()
{
    tableinfo = weapon::getequipmenttableinfo( "equip_smoke" );
    self.bundle = tableinfo.bundle;
    thread function_2d71fed989bc3e22();
    self detonate();
}

// Namespace smoke_grenade
// Params 3
// Checksum 0x72c1fb06, Offset: 0x364
// Size: 0x2f5
function smokegrenadeused( grenade, isgl, objweapon )
{
    grenade thread script::notifyafterframeend( "death", "end_explode" );
    grenade endon( #"end_explode" );
    
    if ( isgl )
    {
        tableinfo = weapon::getequipmenttableinfo( "equip_smoke_gl" );
        assert( isdefined( tableinfo ), "<dev string:x24>" );
        grenade.bundle = tableinfo.bundle;
        grenade.isgl = 1;
    }
    else
    {
        bundle = equipment::function_3637cad9a44ab42( "equip_smoke" );
        assert( isdefined( bundle ), "<dev string:x82>" );
        grenade.bundle = bundle;
        grenade.isgl = 0;
    }
    
    grenade thread function_f20c1cb519af4d7c( grenade.bundle );
    
    if ( isgl )
    {
        grenade waittill( #"missile_stuck", stuckto, hitent, surfacetype, velocity, position, normal );
        
        if ( !isdefined( self ) )
        {
            grenade delete();
            return;
        }
        
        grenade = grenade.owner function_edace11ebd352748( grenade );
    }
    else if ( grenade.bundle.var_e36b84555e7df1d3 && grenade.weapon_object hasattachmenthash( grenade.bundle.var_e36b84555e7df1d3 ) )
    {
        grenade waittill( #"missile_stuck", stuckto, hitent, surfacetype, velocity, position, normal );
        grenade detonate();
    }
    else
    {
        grenade waittill( #"explode", position );
    }
    
    bundle = equipment::function_3637cad9a44ab42( grenade.equipmentref );
    
    if ( level.equipment.protable[ grenade.equipmentref ] )
    {
        if ( !isdefined( level.equipment.protable[ grenade.equipmentref ].effect_duration ) )
        {
            level.equipment.protable[ grenade.equipmentref ].effect_duration = bundle.smokeduration;
        }
    }
    else if ( !isdefined( level.equipment.table[ grenade.equipmentref ].effect_duration ) )
    {
        level.equipment.table[ grenade.equipmentref ].effect_duration = bundle.smokeduration;
    }
    
    grenade thread function_2d71fed989bc3e22( position );
    
    if ( self )
    {
        self.var_30ecd6092c6ceb96 = grenade.bundle.useweapon;
    }
}

// Namespace smoke_grenade
// Params 1
// Checksum 0x27a90c86, Offset: 0x661
// Size: 0xc6
function function_2d71fed989bc3e22( position = self.origin )
{
    bundle = self.bundle;
    assert( isdefined( bundle ), "<dev string:xea>" );
    self.owner notify( #"smokegrenadedetonated", position, bundle );
    thread smokegrenadeexplode( position, self.owner, bundle );
    thread sfx_smoke_grenade_smoke( position, bundle );
    
    if ( isdefined( self.owner ) )
    {
        self.owner thread monitorsmokeactive( bundle );
    }
    
    challenges::function_3d7a169dbae062fb( "equip_smoke", self.owner, undefined, ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"use" ) );
}

// Namespace smoke_grenade
// Params 2
// Checksum 0x70bfc9cc, Offset: 0x72f
// Size: 0xc9
function sfx_smoke_grenade_smoke( position, bundle )
{
    wait 0.2;
    soundorg = spawn( "script_origin", position );
    soundorg.targetname = "sfx_smoke_grenade_smoke";
    soundorg playloopsound( bundle.var_cb7e332a23700744 ?? "smoke_grenade_smoke_lp" );
    soundorg ent_manager::registerspawncount( 1 );
    waittime = bundle.smokeduration - 4;
    
    if ( waittime > 0 )
    {
        wait waittime;
    }
    
    thread utility::play_sound_in_space( bundle.var_7c0ba4a1b6413274 ?? "smoke_grenade_smoke_tail", position );
    wait 0.3;
    
    if ( isdefined( soundorg ) )
    {
        soundorg stoploopsound();
    }
    
    soundorg ent_manager::deregisterspawn();
    soundorg delete();
}

// Namespace smoke_grenade
// Params 1, eflags: 0x4
// Checksum 0xf10452f7, Offset: 0x800
// Size: 0x52
function private function_f20c1cb519af4d7c( bundle )
{
    self endon( #"explode" );
    self endon( #"death" );
    self waittill( #"missile_water_impact", impactdata );
    self notify( #"end_explode" );
    thread function_4d140625619072c2( bundle );
}

// Namespace smoke_grenade
// Params 1, eflags: 0x4
// Checksum 0x85439e81, Offset: 0x85a
// Size: 0xd7
function private function_4d140625619072c2( bundle )
{
    self endon( #"explode" );
    self endon( #"death" );
    
    if ( self.isgl )
    {
        if ( !isdefined( self.owner ) )
        {
            self delete();
            return;
        }
        
        grenade = self.owner function_edace11ebd352748( self );
    }
    else
    {
        self waittill( #"missile_stuck", stuckdata );
        grenade = self;
    }
    
    position = grenade.origin;
    grenade thread smokegrenadeexplode( position, undefined, bundle );
    grenade thread sfx_smoke_grenade_smoke( position, bundle );
    
    if ( isdefined( grenade.owner ) )
    {
        grenade.owner thread monitorsmokeactive( grenade.bundle );
    }
}

// Namespace smoke_grenade
// Params 3
// Checksum 0x65e6c8fa, Offset: 0x939
// Size: 0x1d6
function smokegrenadeexplode( position, owner, bundle )
{
    level endon( #"game_ended" );
    
    if ( isdefined( self.owner ) )
    {
        broadcaststealthevent( self.owner, "explosion_small", 0, self.origin );
    }
    
    thread smoke_grenade_createtrigger( position, self.owner, self.team, bundle );
    smokedelay = isdefined( bundle ) && isdefined( bundle.smokedelay ) ? self.bundle.smokedelay : 1;
    smokeduration = isdefined( bundle ) && isdefined( bundle.smokeduration ) ? bundle.smokeduration : 9.25;
    wait smokedelay;
    thread smokegrenadegiveblindeye( position, owner, bundle );
    
    if ( bundle.smokeduration > 0 )
    {
        smokeduration = bundle.smokedelay ? bundle.smokeduration - bundle.smokedelay : bundle.smokeduration;
        params = { #endtime:gettime() + smokeduration * 1000, #smokeradius:bundle.smokeradius, #position:position };
        level callback::callback( "smoke_grenade_explode", params );
    }
    
    ai::function_5b4f66c4d86eea91( position, bundle.smokeduration, bundle.smokeradius, bundle.var_c350f7193dc273ef, owner );
    id = outline::addoutlineoccluder( position, bundle.smokeradius );
    wait smokeduration - smokedelay;
    outline::removeoutlineoccluder( id );
}

// Namespace smoke_grenade
// Params 1
// Checksum 0x751827d7, Offset: 0xb17
// Size: 0x8f
function function_edace11ebd352748( glgrenade )
{
    useweapon = glgrenade.bundle.useweapon;
    smokegrenade = weapon::_launchgrenade( useweapon, glgrenade.origin, ( 0, 0, 0 ) );
    weapons::grenadeinitialize( smokegrenade, makeweapon( useweapon ) );
    glgrenade hide();
    smokegrenade.bundle = glgrenade.bundle;
    glgrenade thread entity::deleteatframeend();
    return smokegrenade;
}

// Namespace smoke_grenade
// Params 1
// Checksum 0xe91e8b8f, Offset: 0xbaf
// Size: 0x4e0
function onplayerdeath( deathdata )
{
    victim = deathdata.victim;
    
    if ( !victim || player::isreallyalive( victim ) || !level.teambased )
    {
        return;
    }
    
    if ( victim.var_f7d4c6d621ac90af.size > 0 )
    {
        foreach ( trigger in victim.var_f7d4c6d621ac90af )
        {
            if ( trigger.owner )
            {
                if ( victim.attackers )
                {
                    foreach ( attacker in victim.attackers )
                    {
                        victim function_c5c70e16046f5b4d( deathdata, attacker, trigger, trigger.owner, trigger.smokegrenadebundle.useweapon );
                    }
                    
                    continue;
                }
                
                if ( victim.attacker )
                {
                    victim function_c5c70e16046f5b4d( deathdata, victim.attacker, trigger, trigger.owner, trigger.smokegrenadebundle.useweapon );
                }
            }
        }
    }
    else if ( victim.attackers )
    {
        foreach ( attacker in victim.attackers )
        {
            if ( !( attacker.var_f7d4c6d621ac90af.size > 0 ) )
            {
                continue;
            }
            
            foreach ( trigger in attacker.var_f7d4c6d621ac90af )
            {
                if ( trigger.owner )
                {
                    victim function_c5c70e16046f5b4d( deathdata, attacker, trigger, trigger.owner, trigger.smokegrenadebundle.useweapon );
                }
            }
        }
    }
    else if ( victim.attacker.var_f7d4c6d621ac90af.size > 0 )
    {
        foreach ( trigger in victim.attacker.var_f7d4c6d621ac90af )
        {
            if ( trigger.owner )
            {
                victim function_c5c70e16046f5b4d( deathdata, attacker, trigger, trigger.owner, trigger.smokegrenadebundle.useweapon );
            }
        }
    }
    
    if ( issentient( deathdata.attacker ) && issentient( victim ) )
    {
        smokeowner = sighttracepassed( deathdata.attacker geteye(), victim geteye(), 0, deathdata.attacker, victim, 1, "all", 1 );
    }
    
    if ( smokeowner )
    {
        if ( victim.attackers )
        {
            foreach ( attacker in victim.attackers )
            {
                victim function_c5c70e16046f5b4d( deathdata, attacker, undefined, smokeowner, smokeowner.var_30ecd6092c6ceb96 );
            }
            
            return;
        }
        
        if ( victim.attacker )
        {
            victim function_c5c70e16046f5b4d( deathdata, victim.attacker, undefined, smokeowner, smokeowner.var_30ecd6092c6ceb96 );
        }
    }
}

// Namespace smoke_grenade
// Params 3
// Checksum 0xe51de737, Offset: 0x1097
// Size: 0x10f
function smokegrenadegiveblindeye( position, owner, bundle )
{
    level endon( #"game_ended" );
    struct = spawnstruct();
    struct.blindeyerecipients = [];
    smokegrenademonitorblindeyerecipients( struct, position, owner, bundle );
    
    foreach ( recipient in struct.blindeyerecipients )
    {
        if ( player::isreallyalive( recipient ) && isdefined( recipient.perks[ "specialty_blindeye" ] ) )
        {
            recipient perk::removeperk( "specialty_blindeye" );
            recipient perk::removeperk( "specialty_snapshot_counter_smoke" );
            recipient callback::callback( "smokeGrenade_playerRemoveBlindeye" );
        }
    }
}

// Namespace smoke_grenade
// Params 4
// Checksum 0xe6ed53b5, Offset: 0x11ae
// Size: 0x3d5
function smokegrenademonitorblindeyerecipients( struct, position, owner, bundle )
{
    level endon( #"game_ended" );
    blindeyeduration = bundle.smokeduration;
    blindeyeradius = bundle.smokeradius;
    
    if ( bundle.var_7671bb90b98282dd )
    {
        blindeyeduration = bundle.var_3d6f62310757442f ?? 0;
        blindeyeradius = bundle.var_f9611360705b6fc9 ?? 0;
    }
    
    smokedelay = 0;
    
    if ( isdefined( bundle.smokedelay ) )
    {
        smokedelay = bundle.smokedelay;
    }
    
    endtime = gettime() + ( blindeyeduration - smokedelay ) * 1000;
    
    if ( isdefined( bundle ) && isdefined( bundle.var_94c4793021065f16 ) )
    {
        endtime += bundle.var_94c4793021065f16 * 1000;
    }
    
    if ( !isdefined( endtime ) )
    {
        /#
            iprintlnbold( "<dev string:x110>" );
        #/
        
        return;
    }
    
    scoregiven = 0;
    players = [];
    
    while ( gettime() < endtime )
    {
        players = getplayersinradius( position, blindeyeradius );
        
        if ( !scoregiven )
        {
            if ( players.size > 0 )
            {
                if ( isdefined( owner ) && !arraycontains( players, owner ) )
                {
                    scoregiven = 1;
                    smokegrenadeequipment = equipment_mp::function_fdc4a655fbde0dec( bundle.useweapon );
                    var_66a278f74bdc1621 = weapon::getequipmenttableinfo( smokegrenadeequipment );
                    owner namespace_5f4bb62dbf67ff87::doonactionscoreevent( 0, "smokeGrenadeBlinded", 0, { #objweapon:var_66a278f74bdc1621.objweapon } );
                }
            }
        }
        
        foreach ( var_4264d66b92995614, recipient in struct.blindeyerecipients )
        {
            if ( !isdefined( recipient ) )
            {
                struct.blindeyerecipients[ var_4264d66b92995614 ] = undefined;
                continue;
            }
            
            playersid = function_f02c63b99c9614c9( players, recipient );
            
            if ( ( !isdefined( playersid ) || !player::isreallyalive( recipient ) ) && isdefined( recipient.perks[ "specialty_blindeye" ] ) )
            {
                recipient perk::removeperk( "specialty_blindeye" );
                recipient perk::removeperk( "specialty_snapshot_counter_smoke" );
                recipient callback::callback( "smokeGrenade_playerRemoveBlindeye" );
                struct.blindeyerecipients[ var_4264d66b92995614 ] = undefined;
            }
            
            if ( isdefined( playersid ) )
            {
                players[ playersid ] = undefined;
            }
        }
        
        time_left = ( endtime - gettime() ) * 0.001;
        
        foreach ( player in players )
        {
            if ( !isplayer( player ) )
            {
                continue;
            }
            
            player.lastinsmoketime = gettime();
            playerentitynum = player getentitynumber();
            
            if ( isdefined( struct.blindeyerecipients[ playerentitynum ] ) )
            {
                continue;
            }
            
            if ( !player::isreallyalive( player ) )
            {
                continue;
            }
            
            player perk::giveperk( "specialty_blindeye" );
            player perk::giveperk( "specialty_snapshot_counter_smoke" );
            params = { #time_left:time_left };
            player callback::callback( "smokeGrenade_playerGiveBlindeye", params );
            struct.blindeyerecipients[ playerentitynum ] = player;
        }
        
        waitframe();
    }
}

// Namespace smoke_grenade
// Params 1
// Checksum 0x391c232e, Offset: 0x158b
// Size: 0x93
function monitorsmokeactive( bundle )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self notify( #"hash_ffd2c3d4a750b83f" );
    self endon( #"hash_ffd2c3d4a750b83f" );
    
    /#
        print::printgameaction( "<dev string:x134>", self );
    #/
    
    self.hasactivesmokegrenade = 1;
    result = utility::waittill_any_timeout( bundle.smokeduration, "death" );
    self.hasactivesmokegrenade = 0;
    
    /#
        print::printgameaction( "<dev string:x14c>", self );
    #/
}

// Namespace smoke_grenade
// Params 4
// Checksum 0xa0f53571, Offset: 0x1626
// Size: 0x354
function smoke_grenade_createtrigger( position, owner, team, bundle )
{
    if ( !isdefined( level.smokegrenadesettings ) )
    {
        level.smokegrenadesettings = { #var_930cdb7d4b9312d2:0 };
    }
    
    triggermaxsize = bundle.smokeradius;
    trigger = spawn( "trigger_radius", position, 0, triggermaxsize, triggermaxsize );
    trigger ent_manager::registerspawn( 1, &sweepsmoke );
    trigger endon( #"death" );
    trigger.owner = owner;
    trigger.team = team;
    trigger.smokegrenadebundle = bundle;
    trigger.grenade = self;
    
    if ( bundle.var_c7709714d768097c && self.weapon_object hasattachmenthash( bundle.var_c7709714d768097c ) )
    {
        trigger.var_341c7de33aaf015d = 1;
    }
    
    trigger.playersintrigger = [];
    
    if ( utility::issharedfuncdefined( #"game", #"makeenterexittrigger" ) )
    {
        [[ utility::getsharedfunc( #"game", #"makeenterexittrigger" ) ]]( trigger, &function_56ca448dca08569d, &function_449ca741441193f5 );
    }
    
    if ( level.smokegrenadesettings.var_930cdb7d4b9312d2 == 0 )
    {
        level callback::add( #"hash_244314ef9125e636", &onplayerdeath );
    }
    
    if ( bundle.var_b671ca41265c3b96 )
    {
        if ( utility::callsharedfunc( #"smokemanager", #"hash_93bde91ae637affe" ) )
        {
            utility::callsharedfunc( #"smokemanager", #"register", trigger, trigger.origin, triggermaxsize, triggermaxsize, bundle.smokeduration * 1000 );
        }
        else
        {
            function_ddf1350eb373cb5b( position, triggermaxsize );
            var_184e4da13be19a8c = bundle.var_184e4da13be19a8c ?? 0.5;
            owner thread watch_molotov_used( position, triggermaxsize, var_184e4da13be19a8c, trigger );
        }
    }
    
    if ( isdefined( level.combatholos ) )
    {
        foreach ( combatholo in level.combatholos )
        {
            if ( isdefined( combatholo.decoy ) && !combatholo.decoy.var_918f5731d316cbc )
            {
                if ( combatholo.decoy istouching( trigger ) )
                {
                    combatholo.decoy notify( #"hash_fcabc713fb442a93", owner );
                }
            }
        }
    }
    
    level.smokegrenadesettings.var_930cdb7d4b9312d2++;
    wait bundle.smokeduration;
    level.smokegrenadesettings.var_930cdb7d4b9312d2--;
    
    if ( level.smokegrenadesettings.var_930cdb7d4b9312d2 == 0 )
    {
        level callback::remove( #"hash_244314ef9125e636", &onplayerdeath );
    }
    
    trigger thread smoke_grenade_destroytrigger();
}

// Namespace smoke_grenade
// Params 1
// Checksum 0xa4b04ab9, Offset: 0x1982
// Size: 0x4d
function function_52037f1beb2ed379( params )
{
    params.grenade endon( #"death" );
    params.grenade waittill( #"smoke_grenade_nearby" );
    params.grenade molotov::molotov_burn_destroy( 1 );
}

// Namespace smoke_grenade
// Params 4
// Checksum 0xb8f1245d, Offset: 0x19d7
// Size: 0x63
function watch_molotov_used( position, triggermaxsize, var_184e4da13be19a8c, trigger )
{
    trigger endon( #"hash_c432d749097dcda4" );
    
    while ( true )
    {
        self waittill( #"hash_559ad6ce148c89f3", grenade );
        wait var_184e4da13be19a8c;
        function_5de00c431b0983d8( position, triggermaxsize, grenade );
    }
}

// Namespace smoke_grenade
// Params 2
// Checksum 0xa2218348, Offset: 0x1a42
// Size: 0x90
function function_ddf1350eb373cb5b( position, triggermaxsize )
{
    foreach ( grenade in level.grenades )
    {
        function_5de00c431b0983d8( position, triggermaxsize, grenade );
    }
}

// Namespace smoke_grenade
// Params 3
// Checksum 0x92c1b2f2, Offset: 0x1ada
// Size: 0x6d
function function_5de00c431b0983d8( position, triggermaxsize, grenade )
{
    if ( isdefined( grenade.origin ) && distancesquared( grenade.origin, position ) < triggermaxsize * triggermaxsize && trace::ray_trace_passed( grenade.origin, position ) )
    {
        grenade notify( #"smoke_grenade_nearby", grenade );
    }
}

// Namespace smoke_grenade
// Params 0
// Checksum 0x1e5b288e, Offset: 0x1b4f
// Size: 0x9
function sweepsmoke()
{
    thread smoke_grenade_destroytrigger();
}

// Namespace smoke_grenade
// Params 0
// Checksum 0x1367229a, Offset: 0x1b60
// Size: 0xbb
function smoke_grenade_destroytrigger()
{
    self notify( #"hash_c432d749097dcda4" );
    
    foreach ( player in self.playersintrigger )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        player thread smoke_grenade_onexittrigger( self, 1 );
    }
    
    ent_manager::deregisterspawn();
    utility::callsharedfunc( #"smokemanager", #"hash_8f0ee43079ae77e3", self );
    self delete();
}

// Namespace smoke_grenade
// Params 2
// Checksum 0xeeb612e1, Offset: 0x1c23
// Size: 0x1bd
function smoke_grenade_onentertrigger( player, trigger )
{
    if ( !isdefined( player.var_f7d4c6d621ac90af ) )
    {
        player.var_f7d4c6d621ac90af = [];
    }
    
    if ( player.var_f7d4c6d621ac90af.size == 0 && isdefined( trigger.smokegrenadebundle.smokepostfxbundle ) )
    {
        pbgpostfxbundlestart( player, trigger.smokegrenadebundle.smokepostfxbundle );
    }
    
    entnum = trigger getentitynumber();
    player.var_f7d4c6d621ac90af[ entnum ] = trigger;
    player.var_ac6830fc9a3124c2 = 1;
    
    if ( !isdefined( player.challengedata ) )
    {
        player.challengedata = {};
    }
    
    if ( !isdefined( player.challengedata.bitmodifiers ) )
    {
        player.challengedata.bitmodifiers = [];
    }
    
    player.challengedata.var_2b356a409291ef2f = gettime();
    
    if ( utility::callsharedfunc( #"smokemanager", #"hash_93bde91ae637affe" ) )
    {
        callback::callback( #"hash_68c2b2b3fda7e07f", { #bundle:trigger.smokegrenadebundle, #trigger:trigger, #player:player } );
    }
    else if ( trigger.smokegrenadebundle.var_9e40ef6aa8652378 )
    {
        player utility::callsharedfunc( #"molotov", #"clearplayerburning", 1 );
        player utility::callsharedfunc( #"napalm_strike", #"hash_50a3e263ce95377", 0.1, 1 );
    }
    
    return entnum;
}

// Namespace smoke_grenade
// Params 2
// Checksum 0x3c1a49ed, Offset: 0x1de9
// Size: 0x23a
function smoke_grenade_onexittrigger( trigger, dissipating )
{
    assert( isdefined( trigger ), "<dev string:x166>" );
    
    if ( isagent( self ) )
    {
        self.in_smoke_grenade = 0;
    }
    else if ( isplayer( self ) && self.var_ac6830fc9a3124c2 )
    {
        if ( !isdefined( trigger ) )
        {
            return;
        }
        
        self.var_ac6830fc9a3124c2 = 0;
        
        if ( !dissipating )
        {
            self.exitedsmoke = 1;
            
            if ( !isdefined( self.challengedata ) )
            {
                self.challengedata = {};
            }
            
            if ( !isdefined( self.challengedata.bitmodifiers ) )
            {
                self.challengedata.bitmodifiers = [];
            }
        }
        
        self.challengedata.var_ae20800a5a45c347 = gettime();
        self.challengedata.var_4e9796d05376ef4b = self.challengedata.var_2b356a409291ef2f - self.challengedata.var_ae20800a5a45c347;
        challengeparams = { #effectref:"smoked", #duration:self.challengedata.var_4e9796d05376ef4b, #equipmentref:"equip_smoke", #equipmentent:trigger.grenade, #victim:self, #attacker:trigger.owner };
        callback::callback( #"hash_10e686549630fd9f", challengeparams );
    }
    
    if ( isdefined( self.var_f7d4c6d621ac90af ) )
    {
        self.var_f7d4c6d621ac90af[ trigger getentitynumber() ] = undefined;
    }
    
    var_9a67c11db2c29649 = !isdefined( self.var_f7d4c6d621ac90af ) || self.var_f7d4c6d621ac90af.size == 0;
    
    if ( isplayer( self ) && var_9a67c11db2c29649 && isdefined( trigger.smokegrenadebundle.smokepostfxbundle ) )
    {
        pbgpostfxbundleend( self, trigger.smokegrenadebundle.smokepostfxbundle );
    }
    
    callback::callback( #"playerexitsmoke", { #trigger:trigger, #player:self } );
}

// Namespace smoke_grenade
// Params 2
// Checksum 0x96bfa8, Offset: 0x202b
// Size: 0x87
function function_56ca448dca08569d( player, trigger )
{
    if ( isagent( player ) )
    {
        player.in_smoke_grenade = 1;
    }
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( player killstreak::isjuggernaut() )
    {
        return;
    }
    
    if ( !player player::isreallyalive() )
    {
        return;
    }
    
    if ( isdefined( trigger.playersintrigger[ player getentitynumber() ] ) )
    {
        return;
    }
    
    trigger.playersintrigger[ player getentitynumber() ] = player;
    player thread smoke_grenade_onentertrigger( player, trigger );
}

// Namespace smoke_grenade
// Params 2
// Checksum 0x203651e3, Offset: 0x20ba
// Size: 0x31
function function_449ca741441193f5( player, trigger )
{
    trigger.playersintrigger[ player getentitynumber() ] = undefined;
    player thread smoke_grenade_onexittrigger( trigger );
}

// Namespace smoke_grenade
// Params 0
// Checksum 0x86c05842, Offset: 0x20f3
// Size: 0xa4
function smoke_grenade_clear()
{
    if ( isdefined( self.var_f7d4c6d621ac90af ) )
    {
        foreach ( smoke_trigger in self.var_f7d4c6d621ac90af )
        {
            if ( !isdefined( smoke_trigger ) )
            {
                continue;
            }
            
            smoke_trigger.playersintrigger[ self getentitynumber() ] = undefined;
        }
    }
    
    self.var_f7d4c6d621ac90af = undefined;
}

// Namespace smoke_grenade
// Params 5
// Checksum 0xb98483af, Offset: 0x219f
// Size: 0x1fe
function function_c5c70e16046f5b4d( deathdata, attacker, trigger, owner, useweapon )
{
    victim = self;
    attackerinsmoke = attacker.var_f7d4c6d621ac90af.size > 0;
    
    if ( !useweapon )
    {
        return;
    }
    
    if ( !damage::_validateattacker( attacker ) )
    {
        return;
    }
    
    if ( !player_utility::playersareenemies( owner, victim ) || !player_utility::playersareenemies( attacker, victim ) )
    {
        return;
    }
    
    smokegrenadeequipment = equipment_mp::function_fdc4a655fbde0dec( useweapon );
    var_66a278f74bdc1621 = weapon::getequipmenttableinfo( smokegrenadeequipment );
    var_7ad07e4ea1e907a7 = var_66a278f74bdc1621.objweapon;
    
    if ( !isdefined( deathdata.var_9ddf871be4cec067 ) )
    {
        deathdata.var_9ddf871be4cec067 = [];
        victim thread gamelogic_mp::threadedsetweaponstatbyname( var_7ad07e4ea1e907a7, 1, "killed_while_debuffed_by", undefined, attacker );
    }
    
    entnum = owner getentitynumber();
    
    if ( isdefined( deathdata.var_9ddf871be4cec067[ entnum ] ) )
    {
        return;
    }
    
    if ( attacker == owner )
    {
        if ( attackerinsmoke )
        {
            attacker.var_99732766273aec20 = 1;
        }
        
        triggerid = isent( trigger ) ? trigger getentitynumber() : undefined;
        attacker thread gamelogic_mp::threadedsetweaponstatbyname( var_7ad07e4ea1e907a7, 1, "debuff_kills" );
        attacker telemetry_mp::function_89a5d8fb8ed3a4fe( deathdata, attacker, triggerid, var_7ad07e4ea1e907a7 );
        attacker thread namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"smoke_finished", var_7ad07e4ea1e907a7 );
    }
    else
    {
        var_1e117d916013e4b7 = undefined;
        
        if ( trigger.var_341c7de33aaf015d && trigger.smokegrenadebundle.var_c1d023c87ec6f3cf )
        {
            var_1e117d916013e4b7 = trigger.smokegrenadebundle.var_c1d023c87ec6f3cf;
        }
        
        owner thread namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"hash_eb91b774466711b0", var_7ad07e4ea1e907a7, var_1e117d916013e4b7 );
        owner thread gamelogic_mp::threadedsetweaponstatbyname( var_7ad07e4ea1e907a7, 1, "debuff_assists" );
    }
    
    deathdata.var_9ddf871be4cec067[ entnum ] = owner;
}

// Namespace smoke_grenade
// Params 0
// Checksum 0x400aa9b3, Offset: 0x23a5
// Size: 0x126
function function_99543ad5d551cdb5()
{
    if ( !isdefined( self.var_f7d4c6d621ac90af ) )
    {
        return;
    }
    
    foreach ( smoke_trigger in self.var_f7d4c6d621ac90af )
    {
        if ( !isdefined( smoke_trigger.owner ) )
        {
            continue;
        }
        
        if ( self == smoke_trigger.owner )
        {
            smokegrenadeequipment = equipment_mp::function_fdc4a655fbde0dec( smoke_trigger.smokegrenadebundle.useweapon );
            var_66a278f74bdc1621 = weapon::getequipmenttableinfo( smokegrenadeequipment );
            smoke_trigger.owner thread namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"eqpmt_smoke_capture", var_66a278f74bdc1621.objweapon );
            smoke_trigger.owner thread gamelogic_mp::threadedsetweaponstatbyname( var_66a278f74bdc1621.objweapon, 1, "objective_captures" );
            return;
        }
    }
}

