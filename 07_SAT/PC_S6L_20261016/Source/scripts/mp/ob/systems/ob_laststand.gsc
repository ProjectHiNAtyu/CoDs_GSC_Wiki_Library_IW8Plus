// scripts\mp\ob\systems\ob_laststand.gsc  (hash_51348e81b2177b8b.gscc) (size: 27461 Bytes / 0x6b45 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb3bb77d8 (3015407576)
// size ...... 27461 (0x6b45)
// includes .. 42  (offset: 0x672d)
// strings ... 41  (offset: 0x687d)
// dev strs .. 4   (offset: 0x6b15)
// exports ... 54  (offset: 0x423d)
// cseg ...... 0x32a + 0x3f13 (0x423d)
// imports ... 232 (offset: 0x4aad)
// animtree1 . 0   (offset: 0x6b45)
// animtree2 . 0   (offset: 0x6b45)
#using script_3edd59d0d3fc3262;
#using script_636bd827a012af12;
#using script_be7da0439d09064;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\omnvar_utility;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\weapon;
#using scripts\mp\ai\ai_category;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_utility;
#using scripts\mp\class;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\gametypes\ob;
#using scripts\mp\hud_message;
#using scripts\mp\laststand;
#using scripts\mp\loot\common_kiosk;
#using scripts\mp\ob\ob_infils_portal;
#using scripts\mp\ob\points;
#using scripts\mp\ob\systems\ob_laststand;
#using scripts\mp\ob\systems\ob_spectate;
#using scripts\mp\ob\systems\region_difficulty_manager;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;
#using scripts\mp\parachute;
#using scripts\mp\playerlogic;
#using scripts\mp\rank;
#using scripts\mp\squads;
#using scripts\mp\supers;

#namespace ob_laststand;

// Namespace ob_laststand
// Params 0
// Checksum 0x728e6af2, Offset: 0x348
// Size: 0x29e
function init_ob_laststand()
{
    callback::add( #"player_death", &on_player_death );
    callback::add( #"hash_5e4c0033a7bbd7f", &function_35510bf17e85df72 );
    callback::add( #"player_spawned", &on_player_spawn );
    callback::add( #"player_laststand", &on_player_laststand );
    callback::add( #"player_laststand_revived", &function_b0f8cce4da821455 );
    callback::add( #"player_connect", &on_player_connect );
    callback::add( #"player_disconnect", &on_player_disconnect );
    callback::add( #"hash_34d8a133c38aed30", &on_player_bleedout_tick );
    callback::add( #"player_laststand_bleedout", &function_5f7514b664ba0082 );
    callback::add( #"player_damaged", &ob_on_player_last_stand_damage );
    callback::add( #"player_laststand_weapon_given", &on_player_laststand_weapon_given );
    callback::add( #"on_ai_killed", &function_8c5e06ee1e60aeb7 );
    callback::add( "lootcache_looted", &on_cache_opened );
    callback::add( "register_activities", &function_74957fa2c36123b6 );
    level.laststand_bleedout_think = &ob_bleedout_think;
    level.var_9a60c4c20cb97af8 = getdvarint( @"hash_d6c686e2745925e3", 0 );
    level.var_fbf8452b59163047 = !level.var_9a60c4c20cb97af8;
    level.var_449c32a0f392eed7 = &function_c575289d9269e8e2;
    level.laststand_squad_wiped = &ob_laststand_squad_wiped;
    level.modeonlaststandfunc = &ob_on_enter_laststand;
    level.modeonexitlaststandfunc = &function_564f86a40e69f8d;
    level.var_9a7facf0cbad27fd = &function_c1ff5f7338491b7;
    level.modelaststandallowed = &ob_last_stand_allowed;
    level.modeplayerkilledspawn = &ob_spawn_on_player_killed;
    level.var_db5fcc527a2c7a07 = &function_ad5c273b6c6c5163;
    level.var_da5320efd1fd6732 = 1;
    level.var_9a96921d9d23cc4f = &function_bda96b5d86433b85;
    level.var_dfb67545daf1d5b = 1;
    level.laststand_always_disable_damage = getdvarint( @"hash_d9aac3c340a73886", 1 );
    level.var_85e1bb3816730b4 = getdvarint( @"hash_eabfa08be1d07d87", 1 );
    level.var_b60df5645662c1a7 = 1;
    level.var_894cf9c132c87505 = 1;
    level.var_b0c9362b57570972 = &function_eabda615f06d7507;
    level.var_7fe4ad01224b8c00 = getdvarint( @"hash_e05251a329fd0d9d", 0 );
    level.var_9a67c2c3b00a701 = 1;
    level.var_eb2add0a0ffb773e = 1;
    level.var_62b49c3b2ec4111a = 1;
    level.var_57e7ae44ad961329 = 0;
    level.var_b4a0865dad65fa19 = &ob_kiosk_br_team_revive;
    level.var_e00bbb7e3b09cb1e = &function_55afd03f5c7cdb2c;
}

// Namespace ob_laststand
// Params 9
// Checksum 0x9ce53695, Offset: 0x5ee
// Size: 0x17b, Type: bool
function ob_last_stand_allowed( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration )
{
    if ( isdefined( attacker ) && attacker vehicle::ishelicopter() && smeansofdeath == "MOD_CRUSH" )
    {
        return true;
    }
    
    if ( utility::callsharedfunc( #"ob_pvp", #"is_enabled" ) )
    {
        var_bb7d1e92f3a4300e = 0;
        a_squad_members = squad_utility::getsquadmembers();
        
        foreach ( player in a_squad_members )
        {
            var_8d374192aaaef9dc = self != player && !player::isinlaststand( player );
            
            if ( player.sessionstate == "playing" && ( var_8d374192aaaef9dc || player laststand::function_7072b516e6cffb7c() > 0 || isalive( player.var_b93d6394e79d80e9 ) ) )
            {
                var_bb7d1e92f3a4300e = 1;
                break;
            }
        }
        
        if ( !var_bb7d1e92f3a4300e )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace ob_laststand
// Params 1
// Checksum 0xd3cc3518, Offset: 0x772
// Size: 0x13
function on_player_connect( params )
{
    thread self_revive_player_setup();
}

// Namespace ob_laststand
// Params 1
// Checksum 0xffc9760c, Offset: 0x78d
// Size: 0x38
function on_player_disconnect( params )
{
    if ( isdefined( self.var_9219230342b14e47 ) )
    {
        self.var_9219230342b14e47 delete();
    }
    
    thread function_c9abd6c2db378137( params );
    thread function_718d6480e23758b9( 0 );
}

// Namespace ob_laststand
// Params 0
// Checksum 0x12879be6, Offset: 0x7cd
// Size: 0x13
function function_bda96b5d86433b85()
{
    usetime = 3000;
    return usetime;
}

// Namespace ob_laststand
// Params 0, eflags: 0x4
// Checksum 0xec5ee842, Offset: 0x7e9
// Size: 0x77
function private function_dc5288bd53b8ee3e()
{
    itembundle = getscriptbundlefieldvalues( %"hash_35298bd2d2aff71f", [ #"ref" ] );
    
    if ( self.self_revive_item || !isdefined( itembundle.ref ) )
    {
        return;
    }
    
    self.self_revive_item = { #name:%"hash_35298bd2d2aff71f", #ref:itembundle.ref };
}

// Namespace ob_laststand
// Params 0
// Checksum 0xd8617de3, Offset: 0x868
// Size: 0x162
function self_revive_player_setup()
{
    self endon( #"disconnect" );
    laststand::function_39844c1e879cc048( 0 );
    self.var_aecc486f34e4dd66 = 0;
    self.var_4877be4da79014b0 = level.coop_reload == 1 ? 0 : level.gametypebundle.var_4292e4b6ecbd86b5;
    self.var_63cd4b355dddbeba = level.coop_reload == 1 ? 0 : level.gametypebundle.var_c5ebe645f8758bc3;
    self waittill( #"spawned_player" );
    utility::ent_flag_wait( "squad_play_begin" );
    
    if ( level.var_bb86f77304f193c4.var_3d6368d667a0a3df && !self.var_4a59d674db96c66a )
    {
        self waittill( #"infil_igc_finished" );
    }
    
    thread function_c9abd6c2db378137();
    a_squad_members = squad_utility::getsquadmembers();
    
    if ( a_squad_members.size == 1 )
    {
        self.var_4877be4da79014b0 = min( self.var_4877be4da79014b0, laststand::function_a40d280a3420d81() );
        laststand::function_39844c1e879cc048( self.var_4877be4da79014b0 );
        function_dc5288bd53b8ee3e();
        
        if ( laststand::function_7072b516e6cffb7c() > 0 )
        {
            self.b_solo_self_revive = 1;
        }
        
        return;
    }
    
    self.var_63cd4b355dddbeba = min( self.var_63cd4b355dddbeba, laststand::function_a40d280a3420d81() );
    laststand::function_39844c1e879cc048( self.var_63cd4b355dddbeba );
}

// Namespace ob_laststand
// Params 1
// Checksum 0x521bc0b2, Offset: 0x9d2
// Size: 0x290
function function_c9abd6c2db378137( params )
{
    level notify( #"notify_check_self_revive_for_hotjoin" );
    level endon( #"notify_check_self_revive_for_hotjoin" );
    a_squad_members = squad_utility::getsquadmembers();
    b_solo_mode = 0;
    var_31f016079b15de0e = 0;
    waitframe();
    a_squad_members = function_5713d46873b29625( a_squad_members );
    
    if ( a_squad_members.size == 1 )
    {
        b_solo_mode = 1;
        
        foreach ( player in a_squad_members )
        {
            if ( !player utility::ent_flag( "solo_game" ) )
            {
                var_31f016079b15de0e = 1;
                player utility::ent_flag_set( "solo_game" );
            }
        }
    }
    else
    {
        foreach ( player in a_squad_members )
        {
            if ( player utility::ent_flag( "solo_game" ) )
            {
                var_31f016079b15de0e = 1;
                player utility::ent_flag_clear( "solo_game" );
            }
        }
    }
    
    if ( var_31f016079b15de0e )
    {
        foreach ( player in a_squad_members )
        {
            if ( player.b_solo_self_revive )
            {
                if ( b_solo_mode )
                {
                    if ( player laststand::function_7072b516e6cffb7c() <= 0 )
                    {
                        player laststand::function_39844c1e879cc048( int( max( 0, player.var_4877be4da79014b0 - player.var_aecc486f34e4dd66 ) ) );
                        player function_dc5288bd53b8ee3e();
                    }
                    
                    continue;
                }
                
                var_c32e5e08ab4aaf7c = int( max( 0, player.var_63cd4b355dddbeba - player.var_aecc486f34e4dd66 ) );
                
                if ( player laststand::function_7072b516e6cffb7c() < var_c32e5e08ab4aaf7c || level.var_bb86f77304f193c4.var_f6dec41819b96914 )
                {
                    player laststand::function_39844c1e879cc048( var_c32e5e08ab4aaf7c );
                }
                
                player utility::ent_flag_clear( "solo_game" );
            }
        }
    }
}

// Namespace ob_laststand
// Params 0
// Checksum 0xed34e08, Offset: 0xc6a
// Size: 0xa4
function ob_bleedout_think()
{
    thread laststand::bleedoutthink();
    thread laststand::suicidesetup();
    
    if ( getdvarint( @"scr_ob_laststand_allow_damage", 0 ) )
    {
        val::set( "ob_laststand", "damage", 0 );
    }
    
    val::set( "ob_laststand", "ignoreme", 1 );
    self.ob_laststanddamage = 0;
    utility::waittill_any_ents( self, "death_or_disconnect", self, "last_stand_exit", level, "game_ended" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.var_5c81ab2cabcc273f = 1;
    lower_message::setlowermessageomnvar( "clear_lower_msg" );
    self forceusehintoff();
    wait 1.5;
    
    if ( isdefined( self ) )
    {
        val::reset_all( "ob_laststand" );
    }
}

// Namespace ob_laststand
// Params 3, eflags: 0x4
// Checksum 0x44d64a7d, Offset: 0xd16
// Size: 0x5a
function private function_a4955d9c00844785( player, var_5e345b7563120cc5, locationoverride )
{
    var_5e345b7563120cc5.locationresult = player [[ level.var_9a7facf0cbad27fd ]]( player getspectatingplayer(), locationoverride );
    var_5e345b7563120cc5.done = 1;
    var_5e345b7563120cc5 notify( #"done" );
}

// Namespace ob_laststand
// Params 2
// Checksum 0x96ef2730, Offset: 0xd78
// Size: 0x1db
function function_15ff9d8452ce550( locationoverride, anglesoverride )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    utility::ent_flag_set( "team_reviving" );
    var_5e345b7563120cc5 = spawnstruct();
    thread function_a4955d9c00844785( self, var_5e345b7563120cc5, locationoverride );
    game_utility::fadetoblackforplayerkeepui( self, 1, 0.8 );
    
    if ( !var_5e345b7563120cc5.done )
    {
        var_5e345b7563120cc5 waittill( #"done" );
    }
    
    if ( ( level.var_bb86f77304f193c4.var_6708d7a570f5945b ?? "" ) == "MissionFail" && self.squadwiped )
    {
        utility::ent_flag_clear( "team_reviving", 1 );
        return;
    }
    
    spectatedplayer = self getspectatingplayer();
    
    if ( isdefined( anglesoverride ) )
    {
        self.var_5acd906128ef37bd = anglesoverride;
    }
    else if ( isdefined( var_5e345b7563120cc5.locationresult.angles ) )
    {
        self.var_5acd906128ef37bd = var_5e345b7563120cc5.locationresult.angles;
    }
    else if ( isdefined( spectatedplayer ) )
    {
        self.var_5acd906128ef37bd = spectatedplayer getplayerangles( 1 );
    }
    
    self.var_30ee31fc6dba492a = var_5e345b7563120cc5.locationresult.origin;
    self.forcespawnorigin = self.var_30ee31fc6dba492a;
    
    if ( utility::issharedfuncdefined( #"pvp_contract", #"hash_9f00c7b90e8946a8" ) )
    {
        utility::callsharedfunc( #"pvp_contract", #"hash_9f00c7b90e8946a8", self );
    }
    
    function_eabda615f06d7507();
    thread game_utility::fadetoblackforplayerkeepui( self, 0, 0.3 );
    utility::callsharedfunc( #"ob_infil", #"hash_516c884e13c5892d", self, self getorigin() );
    utility::ent_flag_clear( "team_reviving", 1 );
}

// Namespace ob_laststand
// Params 2
// Checksum 0xdc64e447, Offset: 0xf5b
// Size: 0x12f
function function_c1ff5f7338491b7( spectatedplayer, locationoverride )
{
    assert( isplayer( self ) );
    var_cc505c2415ad82ba = isvector( locationoverride ) ? locationoverride : locationoverride.origin;
    var_6d2049ffa77d21b8 = isstruct( locationoverride ) ? locationoverride.angles : undefined;
    respawnlocation = { #origin:var_cc505c2415ad82ba ?? self getorigin() };
    
    if ( isvector( var_cc505c2415ad82ba ) )
    {
        spectatedplayer = undefined;
        playerspresent = getplayersinradius( var_cc505c2415ad82ba, 20, 60, 1 );
        
        if ( isdefined( playerspresent ) && playerspresent.size > 0 )
        {
            spectatedplayer = playerspresent[ 0 ];
        }
    }
    
    if ( level.var_bb86f77304f193c4.var_9b5ba3d7a98a30c0 )
    {
        if ( isdefined( spectatedplayer ) )
        {
            nearpos = spectatedplayer getorigin();
        }
        else
        {
            nearpos = respawnlocation.origin;
        }
        
        respawnlocation = function_d49cb106e94455fb( self, nearpos, spectatedplayer );
    }
    else if ( isdefined( spectatedplayer ) )
    {
        respawnlocation = function_92c887ce7a7f2c71( self, spectatedplayer );
    }
    
    if ( isdefined( var_6d2049ffa77d21b8 ) )
    {
        respawnlocation.angles = var_6d2049ffa77d21b8;
    }
    
    return respawnlocation;
}

// Namespace ob_laststand
// Params 3
// Checksum 0xa683e461, Offset: 0x1093
// Size: 0x50e
function function_d49cb106e94455fb( respawningplayer, nearpos, spectatedplayer )
{
    sortednodes = function_7801d05a86b06144( nearpos, 2362, 0, 250, 128 );
    
    if ( sortednodes.size > 0 )
    {
        room = sortednodes[ 0 ].roomindex;
    }
    
    if ( isplayer( spectatedplayer ) )
    {
        var_487914b143c0dd7e = spectatedplayer getorigin();
        var_b3d027a7c26f4d9 = anglestoforward( spectatedplayer getplayerangles( 1 ) );
    }
    
    hazards = [];
    hazarddistance = 3543;
    nearbyvehicles = vehicle_getarrayinradius( nearpos, hazarddistance, 6000 );
    
    foreach ( vehicle in nearbyvehicles )
    {
        if ( vehicle.isheli && isplayer( vehicle.owner ) )
        {
            hazards[ hazards.size ] = vehicle.origin;
        }
    }
    
    foreach ( door in level.exfildoors.activedoors )
    {
        if ( door.var_336008feba6b5556 && isalive( door.var_336008feba6b5556 ) )
        {
            bossorigin = door.var_336008feba6b5556 getorigin();
            
            if ( distance2dsquared( bossorigin, nearpos ) < hazarddistance )
            {
                hazards[ hazards.size ] = bossorigin;
            }
        }
    }
    
    collisioncontents = trace::create_contents( 1, 1, 1, 1, 1, 1, 1, 0, 1 );
    capsule = respawningplayer getcollision( "stand" );
    playerradius = capsule.capsule_radius;
    playerheight = capsule.capsule_halfheight + capsule.capsule_midpoint_height + capsule.capsule_radius - 12;
    var_165aaf0f15703848 = undefined;
    tracebudget = 8;
    
    foreach ( node in sortednodes )
    {
        roommatches = node.roomindex == room;
        
        if ( !roommatches && isdefined( var_165aaf0f15703848 ) )
        {
            continue;
        }
        
        if ( distance2dsquared( node.groundpos, nearpos ) < 1296 )
        {
            continue;
        }
        
        if ( isdefined( var_487914b143c0dd7e ) && isdefined( var_b3d027a7c26f4d9 ) )
        {
            var_97642d9e5513a9e9 = node.groundpos - var_487914b143c0dd7e;
            dot = vectordot2( var_97642d9e5513a9e9, var_b3d027a7c26f4d9 );
            
            if ( dot > 0.525 )
            {
                if ( distance2dsquared( var_487914b143c0dd7e, node.groundpos ) < 10000 )
                {
                    continue;
                }
            }
        }
        
        hazardfree = 1;
        
        foreach ( var_4d080f710fb8349e in hazards )
        {
            if ( distance2dsquared( node.groundpos, var_4d080f710fb8349e ) < 1394761 )
            {
                hazardfree = 0;
                break;
            }
        }
        
        if ( !hazardfree )
        {
            continue;
        }
        
        capsuletrace = trace::capsule_get_closest_point( node.groundpos + ( 0, 0, 12 ), playerradius, playerheight, undefined, 0, respawningplayer, collisioncontents );
        tracebudget--;
        capsuletracepassed = capsuletrace[ "hittype" ] == "hittype_none";
        
        if ( capsuletracepassed )
        {
            if ( roommatches )
            {
                return { #success:1, #origin:node.groundpos };
            }
            else
            {
                var_165aaf0f15703848 = node.groundpos;
            }
        }
        
        if ( tracebudget == 0 )
        {
            tracebudget = 8;
            waitframe();
        }
    }
    
    if ( isdefined( var_165aaf0f15703848 ) )
    {
        return { #success:1, #origin:var_165aaf0f15703848 };
    }
    
    return { #success:0, #origin:nearpos };
}

// Namespace ob_laststand
// Params 3
// Checksum 0xe0b9f318, Offset: 0x15a9
// Size: 0x3af
function function_92c887ce7a7f2c71( respawningplayer, nearplayer, defaultorigin )
{
    var_88e18c906700fd14 = nearplayer getorigin();
    var_667851a18c63f996 = nearplayer getplayerangles();
    
    if ( isfunction( nearplayer.var_333c3fe63fb6f429 ) )
    {
        var_381e4f461f49d90 = nearplayer [[ nearplayer.var_333c3fe63fb6f429 ]]();
        var_88e18c906700fd14 = var_381e4f461f49d90.origin;
        var_667851a18c63f996 = var_381e4f461f49d90.angles;
    }
    
    spawnlocation = defaultorigin ?? var_88e18c906700fd14;
    success = 0;
    playerangles = var_667851a18c63f996;
    behindangle = playerangles[ 1 ] + 180;
    collisioncontents = trace::create_contents( 1, 1, 1, 1, 1, 1, 1, 0, 1 );
    spawndistance = 60;
    spawnchecks = 10;
    angleinc = 360 / spawnchecks;
    zoffset = ( 0, 0, 24 );
    maxheightdifference = 60;
    tracestart = spawnlocation + zoffset;
    sign = 1;
    checkangle = behindangle;
    
    for ( i = 0; i < spawnchecks ; i++ )
    {
        checkangle += sign * angleinc * i;
        sign *= -1;
        checkvector = ( cos( checkangle ) * spawndistance, sin( checkangle ) * spawndistance, 0 );
        traceend = spawnlocation + checkvector + zoffset;
        var_38ff0b46d72a541c = trace::ray_trace_passed( tracestart, traceend, nearplayer, collisioncontents );
        
        if ( !var_38ff0b46d72a541c )
        {
            continue;
        }
        
        groundtrace = trace::ray_trace( traceend, traceend - ( 0, 0, 500 ), nearplayer, collisioncontents );
        groundtrace = trace::convert_surface_flag( groundtrace );
        var_c4dc867605521234 = isdefined( groundtrace[ "position" ] ) && groundtrace[ "hittype" ] != "hittype_none" && abs( groundtrace[ "position" ][ 2 ] - spawnlocation[ 2 ] ) < maxheightdifference;
        
        if ( !var_c4dc867605521234 )
        {
            continue;
        }
        
        pointoob = outofbounds::ispointinoutofbounds( groundtrace[ "position" ], respawningplayer.team );
        
        if ( pointoob )
        {
            continue;
        }
        
        if ( utility::issharedfuncdefined( #"ob_story", #"hash_fd82c3a7d29b9af2" ) )
        {
            pointoob = utility::callsharedfunc( #"ob_story", #"hash_fd82c3a7d29b9af2", groundtrace[ "position" ], respawningplayer );
            
            if ( pointoob )
            {
                continue;
            }
        }
        
        if ( isdefined( respawningplayer.assigned_difficulty ) )
        {
            regiondifficulty = region_difficulty_manager::get_region_difficulty( groundtrace[ "position" ] );
            
            if ( regiondifficulty != respawningplayer.assigned_difficulty )
            {
                continue;
            }
        }
        
        capsule = respawningplayer getcollision( "stand" );
        playerradius = capsule.capsule_radius;
        playerheight = capsule.capsule_halfheight + capsule.capsule_midpoint_height + capsule.capsule_radius - 12;
        capsuletrace = trace::capsule_get_closest_point( groundtrace[ "position" ] + ( 0, 0, 12 ), playerradius, playerheight, undefined, 0, nearplayer, collisioncontents );
        
        if ( capsuletrace[ "hittype" ] == "hittype_none" )
        {
            spawnlocation = groundtrace[ "position" ];
            success = 1;
            break;
        }
    }
    
    return { #success:success, #angles:playerangles, #origin:spawnlocation };
}

// Namespace ob_laststand
// Params 0, eflags: 0x4
// Checksum 0x10a685b6, Offset: 0x1961
// Size: 0x28d
function private function_bd69d51ea0ecf02e()
{
    self endon( #"disconnect" );
    timerseconds = level.var_bb86f77304f193c4.var_8f5e003b1af65bd1 ?? 30;
    
    if ( utility::issharedfuncdefined( #"pvp_contract", #"hash_afc40a0d2915db27" ) )
    {
        timerseconds = utility::callsharedfunc( #"pvp_contract", #"hash_afc40a0d2915db27", self, timerseconds );
    }
    
    initrespawntimer( timerseconds, timerseconds, 1 );
    self.respawndelay = timerseconds;
    self.respawndelta = 0;
    self.var_7418be40eeb57cfe = undefined;
    isreallyalive = 0;
    
    while ( self.respawndelay > 0 )
    {
        isreallyalive = isalive( self ) && self.sessionstate == "playing";
        
        if ( self.squadwiped || self.var_b7437a2d0279e0ac )
        {
            break;
        }
        
        if ( isreallyalive )
        {
            self.respawndelay = 0;
        }
        else
        {
            function_fe2e4ec30cae8a7c( self.respawndelay );
            
            if ( self.respawndelay == 1 )
            {
                self playsoundtoplayer( "match_start_tick_in1", self );
            }
            else if ( self.respawndelay <= 5 )
            {
                self playsoundtoplayer( "match_start_tick", self );
            }
            
            self.var_beaa7a0f2d159264 = undefined;
            
            if ( self.respawndelta > 0 )
            {
                function_3ddd9035faca69e0( self.respawndelta, self.var_7418be40eeb57cfe );
                self.var_7418be40eeb57cfe = undefined;
            }
            else
            {
                function_638d8fe07235b7d5();
            }
        }
        
        self.respawndelta = 0;
        wait 1;
        self.respawndelay--;
    }
    
    initrespawntimer( 0, 0, 0 );
    function_638d8fe07235b7d5();
    isreallyalive = isalive( self ) && self.sessionstate == "playing";
    
    if ( !self.squadwiped && !self.var_b7437a2d0279e0ac && !isreallyalive )
    {
        locationoverride = undefined;
        anglesoverride = undefined;
        
        if ( utility::issharedfuncdefined( #"ob_activity_locked_in", #"hash_cb2779e19a817757" ) )
        {
            location_and_angles = utility::callsharedfunc( #"ob_activity_locked_in", #"hash_cb2779e19a817757", self );
            
            if ( location_and_angles )
            {
                locationoverride = location_and_angles.location;
                anglesoverride = location_and_angles.angles;
            }
        }
        
        thread function_15ff9d8452ce550( locationoverride, anglesoverride );
        self playsoundtoteam( "evt_ob_player_respawn_3d", self.team, self, self );
        self playsoundtoplayer( "evt_ob_player_respawn_2d", self );
    }
}

// Namespace ob_laststand
// Params 0
// Checksum 0xc74ed440, Offset: 0x1bf6
// Size: 0x258
function function_eabda615f06d7507()
{
    if ( !isdefined( self ) || !( isplayer( self ) || isagent( self ) ) )
    {
        return;
    }
    
    self notify( #"hash_2eae51baadac8fa7" );
    assert( isvector( self.var_30ee31fc6dba492a ), "<dev string:x24>" );
    self sethidenameplate( 0 );
    self.healthregendisabled = 0;
    self.liveragdoll = 0;
    stopspectateplayer( self getentitynumber(), 1, 0 );
    player::updatesessionstate( "playing" );
    self setsolid( 1 );
    thread function_27c95a30ced35550();
    player::_freezecontrols( 0, undefined, "liveRagdoll" );
    player::_freezelookcontrols( 0, undefined );
    class::setthirdpersonview();
    self.var_14955bc056bab547 = 1;
    self.setspawnpoint = undefined;
    self.forcespawnorigin = self.var_30ee31fc6dba492a;
    playerlogic::spawnclient( 1 );
    self dontinterpolate();
    v_spawn = self.var_30ee31fc6dba492a;
    
    if ( isvector( v_spawn ) )
    {
        v_spawn = getgroundposition( self.var_30ee31fc6dba492a, 16 );
        v_spawn = isvector( v_spawn ) ? v_spawn : self.var_30ee31fc6dba492a;
    }
    else
    {
        v_spawn = self.origin;
    }
    
    framecount = 0;
    
    while ( self.sessionstate != "playing" && framecount <= 2 )
    {
        framecount++;
        waitframe();
    }
    
    if ( self.sessionstate == "playing" )
    {
        self setorigin( v_spawn + ( 0, 0, 4 ) );
        
        if ( isdefined( self.var_5acd906128ef37bd ) )
        {
            self setplayerangles( self.var_5acd906128ef37bd );
        }
    }
    
    self dontinterpolate();
    self.var_30ee31fc6dba492a = undefined;
    self.var_5acd906128ef37bd = undefined;
    curstance = self getstance();
    
    if ( curstance != "stand" )
    {
        contentoverride = trace::create_contents( 0, 1, 1, 1, 0, 0, 1, 1, 0 );
        canstand = trace::ray_trace_passed( self.origin, utility::function_f02ebab438642e16( "stand" ), self, contentoverride );
        
        if ( canstand )
        {
            self setstance( "stand", 0, 1, 1 );
        }
    }
    
    if ( getdvarint( @"hash_96b4daf3d61bbc69", 0 ) )
    {
        points::function_3d419d8542442d64();
    }
    
    class::loadout_updateplayeractionslots();
    self.wasrevived = 1;
}

// Namespace ob_laststand
// Params 0, eflags: 0xc
// Checksum 0x163e7876, Offset: 0x1e56
// Size: 0xd3
function private function_27c95a30ced35550()
{
    self notify( #"hash_d25119d47b82c6db" );
    self endon( #"hash_d25119d47b82c6db" );
    self endon( #"death_or_disconnect" );
    
    while ( function_ba821a96d0af754d( self ) || !player::isreallyalive( self ) )
    {
        waitframe();
    }
    
    if ( self.var_b7437a2d0279e0ac )
    {
        return;
    }
    
    if ( !function_ba821a96d0af754d( self ) )
    {
        self function_53d446e6e6a7f1ac( 0 );
        self function_715e8b27564eeece( 0 );
    }
    
    self stopliveragdoll();
    var_6bd631daa20a035 = 0;
    
    while ( !var_6bd631daa20a035 )
    {
        weapons = self getweaponslistprimaries();
        weapon = self getcurrentweapon();
        
        if ( isnullweapon( weapon ) && weapons.size > 0 && !self isswitchingweapon() )
        {
            self switchtoweaponimmediate( weapons[ 0 ] );
        }
        else if ( !isnullweapon( weapon ) )
        {
            var_6bd631daa20a035 = 1;
        }
        
        waitframe();
    }
}

// Namespace ob_laststand
// Params 1
// Checksum 0x71795c40, Offset: 0x1f31
// Size: 0xef
function function_5f7514b664ba0082( params )
{
    if ( !isdefined( self ) || !( isplayer( self ) || isagent( self ) ) )
    {
        return;
    }
    
    squad = teams::function_72b89edf6b47c40a( self );
    
    if ( squad.var_2c44544a01cc415e || squad.reviving )
    {
        self.var_b2b283c015cf3bd4 = 1;
        return;
    }
    
    player::_freezecontrols( 1, undefined, "liveRagdoll" );
    player::_freezelookcontrols( 1, undefined );
    self sethidenameplate( 1 );
    self.healthregendisabled = 1;
    self setsolid( 0 );
    
    if ( player::isreallyalive( self ) )
    {
        if ( !function_ba821a96d0af754d( self ) )
        {
            self function_53d446e6e6a7f1ac( 1 );
            self function_715e8b27564eeece( 1 );
        }
        
        self startliveragdoll();
        self.var_8aee7d81428d098e = gettime();
    }
    
    self.liveragdoll = 1;
    class::setthirdpersonview();
    self.var_30ee31fc6dba492a = self.origin;
}

// Namespace ob_laststand
// Params 1
// Checksum 0x7c5a2cb4, Offset: 0x2028
// Size: 0x45
function function_35510bf17e85df72( params )
{
    squad = teams::function_72b89edf6b47c40a( self );
    
    if ( squad.var_2c44544a01cc415e )
    {
        return;
    }
    
    if ( !player::isinlaststand( self ) )
    {
        thread ob_story_mission_utils::player_loadout_save( "ob_sm_checkpoint_loadout" );
    }
}

// Namespace ob_laststand
// Params 1
// Checksum 0xc415755d, Offset: 0x2075
// Size: 0xbe
function on_player_death( params )
{
    squad = teams::function_72b89edf6b47c40a( self );
    
    if ( squad.var_2c44544a01cc415e )
    {
        return;
    }
    
    self.br_iseliminated = 1;
    br_public::function_7813786b92d850ff( 1 );
    br_public::setplayerdownedextrainfo( 0 );
    br_utility::updateplayereliminatedomnvar();
    val::set( "ob_death", "ignoreme", 1 );
    
    if ( getdvarint( @"hash_96b4daf3d61bbc69", 0 ) )
    {
        points::function_66253092b6523c6d();
    }
    
    if ( isdefined( params.inflictor ) && isdefined( params.attacker ) )
    {
        self lookatkiller( params.inflictor, params.attacker );
    }
    
    thread function_718d6480e23758b9( 0 );
}

// Namespace ob_laststand
// Params 2
// Checksum 0xc2d9ad98, Offset: 0x213b
// Size: 0x42
function function_ad5c273b6c6c5163( corpse, animduration )
{
    self endon( #"disconnect" );
    corpse endon( #"death" );
    self waittill( #"spawned_player" );
    corpse delete();
}

// Namespace ob_laststand
// Params 2
// Checksum 0xea7d7dbe, Offset: 0x2185
// Size: 0xb9, Type: bool
function ob_spawn_on_player_killed( deathdata, finaldeath )
{
    deathdata.victim val::set( "ob_death", "ignoreme", 1 );
    
    if ( !level.gameended && !deathdata.victim.liveragdoll )
    {
        utility::delaythread( 0.1, &ob_spectate::spawn_spectator, deathdata.victim, deathdata );
        deathdata.victim lower_message::setlowermessageomnvar( "br_standby_for_respawn" );
    }
    
    if ( level.var_bb86f77304f193c4.var_bd54e57709992bf7 )
    {
        deathdata.victim thread function_bd69d51ea0ecf02e();
    }
    
    return true;
}

// Namespace ob_laststand
// Params 0
// Checksum 0x462a6bda, Offset: 0x2247
// Size: 0x26
function function_aa09ca0d3d2bbf7c()
{
    self endon( #"disconnect" );
    wait 0.15;
    inventory_utility::_switchtoweaponimmediate( self.primaryweapons[ 0 ] );
}

// Namespace ob_laststand
// Params 1
// Checksum 0x88f5deec, Offset: 0x2275
// Size: 0x1b4
function on_player_spawn( params )
{
    self endon( #"disconnect" );
    
    if ( !level.gameended )
    {
        val::reset( "ob_death", "ignoreme" );
    }
    
    if ( self.br_iseliminated )
    {
        self.var_a4393726eb566b8f = undefined;
        
        if ( !game_utility_mp::isteamreviveenabled() )
        {
            waitframe();
            
            foreach ( weapon in self.primaryweapons )
            {
                self givemaxammo( weapon );
                self setweaponammoclip( weapon, weaponclipsize( weapon ) );
            }
        }
    }
    
    if ( isdefined( self.var_9219230342b14e47 ) )
    {
        self.var_9219230342b14e47 delete();
    }
    
    self.br_iseliminated = undefined;
    br_public::function_7813786b92d850ff( 0 );
    self.healthregendisabled = undefined;
    self.liveragdoll = 0;
    self.squadwiped = undefined;
    br_utility::updateplayereliminatedomnvar();
    br_public::setplayerdownedextrainfo( 0 );
    laststand::setplayerbeingrevivedextrainfo( 0 );
    laststand::updatesquadmemberlaststandreviveprogress( self, self, 0, 1 );
    
    /#
        if ( !self.var_70cb41192d5c7a1f )
        {
            if ( isbot( self ) )
            {
                self endon( #"death_or_disconnect" );
                wait 4;
            }
            
            self.var_70cb41192d5c7a1f = 1;
            devgui::function_9082edeb5db93280( "<dev string:x50>" );
            devgui::function_cd4e263c1f3018ae( self.name, "<dev string:x6f>" + self.name, &function_f1810183eba7481b );
            devgui::function_77df7fe7dd273e10();
        }
    #/
}

// Namespace ob_laststand
// Params 1, eflags: 0x4
// Checksum 0x2edab1a4, Offset: 0x2431
// Size: 0x61, Type: bool
function private function_fdbf7295ed761218( weapon )
{
    if ( !weapon )
    {
        return false;
    }
    
    if ( !weapon::iscacprimaryorsecondary( weapon ) && !weapon::isfistsonly( weapon ) )
    {
        return false;
    }
    
    if ( weapon::iskillstreakweapon( weapon ) || weapon::issuperuseweapon( weapon ) || weapon::function_707f7162a89aa0e0( weapon ) || self function_8eb1b5d840aac85d( weapon ) )
    {
        return false;
    }
    
    return true;
}

// Namespace ob_laststand
// Params 0, eflags: 0x4
// Checksum 0xf2bbddc6, Offset: 0x249b
// Size: 0x3f
function private function_c5b8cac7b87fc592()
{
    self.var_e4646dd860ad6049 = self.primaryweapons;
    self.var_fde03100c88f699e = self getcurrentweapon();
    
    if ( !function_fdbf7295ed761218( self.var_fde03100c88f699e ) )
    {
        self.var_fde03100c88f699e = undefined;
    }
}

// Namespace ob_laststand
// Params 1
// Checksum 0x956e4b50, Offset: 0x24e2
// Size: 0x3d
function function_55afd03f5c7cdb2c( player )
{
    if ( !level.var_bb86f77304f193c4.customloadouts && !isdefined( player.var_e4646dd860ad6049 ) )
    {
        player function_c5b8cac7b87fc592();
    }
}

// Namespace ob_laststand
// Params 1
// Checksum 0x9da7ab1f, Offset: 0x2527
// Size: 0xc1
function on_player_laststand( params )
{
    thread br_public::setplayerdownedextrainfo( 1 );
    function_c5b8cac7b87fc592();
    a_squad_members = squad_utility::getsquadmembers();
    
    foreach ( var_8a958389218cbbb3 in a_squad_members )
    {
        if ( !isdefined( var_8a958389218cbbb3 ) || var_8a958389218cbbb3 == self )
        {
            continue;
        }
        
        var_8a958389218cbbb3 thread hud_message::showsplash( "br_teammate_down", undefined, self );
        var_8a958389218cbbb3 thread br_ftue_popups::function_e05ce093ad06ba05( self );
    }
}

// Namespace ob_laststand
// Params 1
// Checksum 0x8163b678, Offset: 0x25f0
// Size: 0xea
function function_b0f8cce4da821455( params )
{
    br_public::setplayerdownedextrainfo( 0 );
    timesec = function_8486bcf58a05b227( #"reviver" );
    
    if ( timesec > 0 && isplayer( params.reviver ) )
    {
        var_6c22a8fefb4c3789 = function_1bf928cd0a0d998d( params.reviver );
        reducerespawntimer( var_6c22a8fefb4c3789, 3, params.reviver, #"reviver" );
    }
    
    self endon( #"death_or_disconnect" );
    wait 0.25;
    self.maxhealth = int( max( self.laststandrevivehealth ?? level.laststandrevivehealth, self.maxhealth ) );
    self.health = self.maxhealth;
    self.var_e4646dd860ad6049 = undefined;
    self.var_fde03100c88f699e = undefined;
}

// Namespace ob_laststand
// Params 1
// Checksum 0xe51e7cef, Offset: 0x26e2
// Size: 0xb1
function function_f1810183eba7481b( params )
{
    str_player_name = params[ 0 ];
    
    foreach ( player in level.players )
    {
        if ( player.name == str_player_name )
        {
            player thread ob_skydive_redeploy( player.origin );
            break;
        }
    }
}

// Namespace ob_laststand
// Params 0
// Checksum 0xca5c1916, Offset: 0x279b
// Size: 0x32e
function function_c575289d9269e8e2()
{
    a_s_pistols = [];
    weaponlist = self.primaryweapons;
    self.var_348359045a2cf8e1 = 1;
    
    foreach ( weaponobject in weaponlist )
    {
        weaponname = weaponobject.basename;
        
        if ( weaponclass( weaponobject ) == "pistol" || weapon::getweapongroup( weaponobject ) == "weapon_pistol" )
        {
            var_f94f2806d9ba625f = spawnstruct();
            var_f94f2806d9ba625f.weaponname = weaponname;
            var_f94f2806d9ba625f.weaponobject = weaponobject;
            a_s_pistols = arraycombineunique( a_s_pistols, [ var_f94f2806d9ba625f ] );
        }
    }
    
    if ( a_s_pistols.size == 1 )
    {
        return a_s_pistols[ 0 ].weaponobject;
    }
    else if ( !a_s_pistols.size )
    {
        var_3f7f963c1d0a720c = level.laststandweapon;
        var_3f7f963c1d0a720c = weapon_utility::function_d2c8356dc369d9ce( var_3f7f963c1d0a720c );
        var_3f7f963c1d0a720c = var_3f7f963c1d0a720c withattachment( "backup_pistol" );
        self.var_348359045a2cf8e1 = 0;
        return var_3f7f963c1d0a720c;
    }
    
    var_26d38f99dfa3b59f = a_s_pistols[ 0 ].weaponname;
    var_c1e8ec291728a76a = 0;
    
    if ( isarray( level.weaponmetadata ) )
    {
        foreach ( var_fe68cd50dcda7fdc in level.weaponmetadata )
        {
            if ( var_fe68cd50dcda7fdc.laststandpriority > var_c1e8ec291728a76a && isdefined( var_fe68cd50dcda7fdc.weapon ) )
            {
                foreach ( var_f94f2806d9ba625f in a_s_pistols )
                {
                    if ( var_f94f2806d9ba625f.weaponname == var_fe68cd50dcda7fdc.weapon )
                    {
                        var_c1e8ec291728a76a = var_fe68cd50dcda7fdc.laststandpriority;
                        var_26d38f99dfa3b59f = var_fe68cd50dcda7fdc.weapon;
                        break;
                    }
                }
            }
        }
    }
    
    foreach ( var_f94f2806d9ba625f in a_s_pistols )
    {
        if ( var_f94f2806d9ba625f.weaponname == var_26d38f99dfa3b59f )
        {
            return var_f94f2806d9ba625f.weaponobject;
        }
    }
}

// Namespace ob_laststand
// Params 1, eflags: 0x4
// Checksum 0x29bf8ffe, Offset: 0x2ad1
// Size: 0xb6
function private on_player_laststand_weapon_given( params )
{
    var_3f7f963c1d0a720c = params.weapon;
    ammo_stock = 0;
    active_story_mission = story_contract_util::function_35a4b91d1599df3e( self );
    
    if ( !isdefined( active_story_mission ) || ob::nightmare() )
    {
        ammo_stock = var_3f7f963c1d0a720c.clipsize * 2;
    }
    
    if ( !var_3f7f963c1d0a720c hasattachment( "backup_pistol" ) )
    {
        self.laststandweaponobj = var_3f7f963c1d0a720c;
        self.var_59df6d01d46ff816 = self getweaponammoclip( var_3f7f963c1d0a720c );
        self.var_b505fde2232657ae = self getweaponammostock( var_3f7f963c1d0a720c );
    }
    
    self setweaponammoclip( var_3f7f963c1d0a720c, var_3f7f963c1d0a720c.clipsize );
    self setweaponammostock( var_3f7f963c1d0a720c, ammo_stock );
}

// Namespace ob_laststand
// Params 0
// Checksum 0xb962b0ab, Offset: 0x2b8f
// Size: 0x16
function ob_on_enter_laststand()
{
    thread function_718d6480e23758b9( 0 );
    thread ob_story_mission_utils::player_loadout_save( "ob_sm_checkpoint_loadout" );
}

// Namespace ob_laststand
// Params 1
// Checksum 0x74544f61, Offset: 0x2bad
// Size: 0xd1
function on_player_bleedout_tick( params )
{
    if ( isdefined( params.progress ) && level.var_9a67c2c3b00a701 )
    {
        if ( !self function_f955946904715208() )
        {
            damage = self.ob_laststanddamage ?? 0;
            self.health = int( self.maxhealth * params.progress - damage );
            
            if ( self.health < 0 )
            {
                self.var_bf82e408b7a0e3c3 = 1;
            }
            
            if ( isdefined( self.laststandreviveent ) && isdefined( self.laststandreviveent.objidnum ) )
            {
                objidpoolmanager::objective_set_progress( self.laststandreviveent.objidnum, params.progress );
            }
        }
    }
}

// Namespace ob_laststand
// Params 1
// Checksum 0xe00aeb71, Offset: 0x2c86
// Size: 0x72
function ob_on_player_last_stand_damage( params )
{
    victim = params.victim;
    
    if ( !isplayer( victim ) )
    {
        return;
    }
    
    if ( !victim.inlaststand || !isdefined( victim.ob_laststanddamage ) )
    {
        return;
    }
    
    victim.ob_laststanddamage += params.idamage;
}

// Namespace ob_laststand
// Params 1
// Checksum 0x4c915c00, Offset: 0x2d00
// Size: 0xc0
function function_564f86a40e69f8d( revived )
{
    squad = teams::function_72b89edf6b47c40a( self );
    
    if ( squad.var_2c44544a01cc415e )
    {
        return;
    }
    
    if ( self.laststandweaponobj )
    {
        if ( self.var_59df6d01d46ff816 )
        {
            self setweaponammoclip( self.laststandweaponobj, self.var_59df6d01d46ff816 );
        }
        
        if ( self.var_b505fde2232657ae )
        {
            self setweaponammostock( self.laststandweaponobj, self.var_b505fde2232657ae );
        }
        
        self.laststandweaponobj = undefined;
        self.var_59df6d01d46ff816 = undefined;
        self.var_b505fde2232657ae = undefined;
    }
    
    if ( isdefined( self.ob_laststanddamage ) )
    {
        self.ob_laststanddamage = undefined;
    }
    
    thread function_718d6480e23758b9( revived );
}

// Namespace ob_laststand
// Params 0, eflags: 0x4
// Checksum 0x21ea90b6, Offset: 0x2dc8
// Size: 0x13f
function private ob_laststand_squad_wiped()
{
    assert( isplayer( self ) );
    var_850001ba16258e16 = 1;
    a_squad_players = squad_utility::getsquadmembers();
    a_squad_players = function_5713d46873b29625( a_squad_players );
    
    foreach ( player in a_squad_players )
    {
        if ( ob_infils_portal::function_cf564904f7af50b3( player ) )
        {
            continue;
        }
        
        if ( function_5461d55290ca1ab6( player ) )
        {
            var_850001ba16258e16 = 0;
            break;
        }
        
        if ( utility::issharedfuncdefined( #"ob_activity_locked_in", #"hash_3ca2423be7fff6d1" ) )
        {
            if ( utility::callsharedfunc( #"ob_activity_locked_in", #"hash_3ca2423be7fff6d1", player ) )
            {
                var_850001ba16258e16 = 0;
                break;
            }
            
            continue;
        }
        
        if ( utility::issharedfuncdefined( #"pvp_contract", #"hash_24ed85b21a923519" ) )
        {
            if ( utility::callsharedfunc( #"pvp_contract", #"hash_24ed85b21a923519", player ) )
            {
                var_850001ba16258e16 = 0;
                break;
            }
        }
    }
    
    return var_850001ba16258e16;
}

// Namespace ob_laststand
// Params 1, eflags: 0x4
// Checksum 0xf0345324, Offset: 0x2f10
// Size: 0x43c
function private function_718d6480e23758b9( revived )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    self notify( #"endon_ob_laststand_alive_check" );
    self endon( #"endon_ob_laststand_alive_check" );
    self endon( #"disconnect" );
    a_squad_players = squad_utility::getsquadmembers();
    
    if ( revived )
    {
        return;
    }
    
    self.var_8cdc5cf2e8ede158 = gettime();
    waitframe();
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    b_squad_wiped = self [[ level.laststand_squad_wiped ]]();
    wipebehavior = level.var_bb86f77304f193c4.var_6708d7a570f5945b ?? "MissionFail";
    
    if ( b_squad_wiped && wipebehavior == "MissionFail" )
    {
        var_7688e0b1d6c8be55 = [];
        wipedplayers = [];
        
        foreach ( player in a_squad_players )
        {
            if ( ob_infils_portal::function_cf564904f7af50b3( player ) )
            {
                var_7688e0b1d6c8be55[ var_7688e0b1d6c8be55.size ] = player;
                continue;
            }
            
            wipedplayers[ wipedplayers.size ] = player;
        }
        
        if ( var_7688e0b1d6c8be55.size > 0 )
        {
            a_squad_players = wipedplayers;
            var_bf5d6dd3cd7a83bf = undefined;
            var_75ed518240f11e29 = undefined;
            
            foreach ( player in a_squad_players )
            {
                team = player.team;
                player squads::leavesquad( team, player.sessionsquadid );
                
                if ( !isdefined( var_bf5d6dd3cd7a83bf ) )
                {
                    player squads::requestnewsquad( team, undefined, 0 );
                    var_bf5d6dd3cd7a83bf = team;
                    var_75ed518240f11e29 = player.sessionsquadid;
                    continue;
                }
                
                player squads::joinsquad( var_bf5d6dd3cd7a83bf, var_75ed518240f11e29 );
            }
        }
    }
    
    a_squad_players = function_5713d46873b29625( a_squad_players );
    
    if ( b_squad_wiped )
    {
        foreach ( player in a_squad_players )
        {
            player.squadwiped = 1;
            player setclientomnvar( "ui_play_again_disabled", 1 );
        }
    }
    
    var_958151dbd0f282ec = 0;
    
    foreach ( player in level.players )
    {
        if ( function_5461d55290ca1ab6( player ) )
        {
            var_958151dbd0f282ec = 1;
            break;
        }
    }
    
    if ( isdefined( self.team ) && isdefined( self.sessionsquadid ) )
    {
        squad_leader = squad_utility::getsquadleader( self.team, self.sessionsquadid );
    }
    
    var_750304047466e7cc = squad_leader;
    
    if ( b_squad_wiped )
    {
        var_6f4459c3295038dd = -1;
        
        foreach ( player in a_squad_players )
        {
            if ( player.var_8cdc5cf2e8ede158 > var_6f4459c3295038dd )
            {
                var_750304047466e7cc = player;
                var_6f4459c3295038dd = player.var_8cdc5cf2e8ede158;
            }
        }
    }
    
    if ( b_squad_wiped && !level.gameended && self == var_750304047466e7cc )
    {
        self thread [[ level.onsquadeliminated ]]( a_squad_players, var_958151dbd0f282ec );
    }
}

// Namespace ob_laststand
// Params 1
// Checksum 0x63d7160c, Offset: 0x3354
// Size: 0xcf, Type: bool
function function_5461d55290ca1ab6( player )
{
    if ( !isalive( player ) )
    {
        return false;
    }
    
    inlaststand = player::isinlaststand( player );
    
    if ( !inlaststand && player.sessionstate == "playing" )
    {
        return true;
    }
    
    if ( inlaststand && level.var_bb86f77304f193c4.var_814ae297f7beff7a )
    {
        return true;
    }
    
    if ( player laststand::function_7072b516e6cffb7c() > 0 )
    {
        return true;
    }
    
    if ( isalive( player.var_b93d6394e79d80e9 ) )
    {
        return true;
    }
    
    if ( player.is_solo_quest )
    {
        return true;
    }
    
    superref = supers_mp::getcurrentsuperref();
    
    if ( superref == "super_survival_life_drain" && player val::get( "supers" ) )
    {
        return true;
    }
    
    return false;
}

// Namespace ob_laststand
// Params 1
// Checksum 0x8584a501, Offset: 0x342c
// Size: 0x149
function ob_kiosk_br_team_revive( purchaseindex )
{
    itemindex = purchaseindex;
    itemdata = common_kiosk::function_74433c19fcc10b90( itemindex );
    assert( isdefined( itemdata ) );
    cost = common_kiosk::_getactualcost( self, itemdata );
    cost *= 100;
    var_9523b72d963ae8bc = undefined;
    squad = squad_utility::getsquadmembers();
    
    foreach ( squadmate in squad )
    {
        if ( !isdefined( squadmate ) || squadmate == self )
        {
            continue;
        }
        
        if ( !isalive( squadmate ) && !squadmate.var_34a141f0e31b78e )
        {
            var_9523b72d963ae8bc = squadmate;
            break;
        }
    }
    
    if ( isdefined( var_9523b72d963ae8bc ) )
    {
        var_9523b72d963ae8bc.var_a4393726eb566b8f = 1;
        v_ground_start = self.origin + anglestoforward( self.angles ) * 300;
        var_9523b72d963ae8bc thread ob_skydive_redeploy( v_ground_start );
    }
}

// Namespace ob_laststand
// Params 1
// Checksum 0x2169b628, Offset: 0x357d
// Size: 0x23e
function ob_skydive_redeploy( v_start )
{
    level thread br_contract_manager::utilflare_shootflare( v_start, "revive" );
    spawnheight = getdvarfloat( @"hash_50f18343f33b6153", 8000 );
    spawnorigin = v_start;
    spawnorigin += ( 0, 0, spawnheight );
    self.var_34a141f0e31b78e = 1;
    fadedownduration = 0;
    fadeupduration = 0.5;
    thread playerlogic::managerespawnfade( fadedownduration, fadeupduration );
    
    if ( fadedownduration > 0 )
    {
        self waittill( #"fadedown_complete" );
    }
    
    facingorigin = ( level.mapcorners[ 0 ].origin + level.mapcorners[ 1 ].origin ) * 0.5;
    toselection = facingorigin - spawnorigin;
    spawnangles = vectortoangles( vectornormalize( toselection ) );
    self.var_34a141f0e31b78e = undefined;
    
    if ( !isalive( self ) || self.sessionstate == "spectator" )
    {
        self notify( #"force_spawn" );
        waitframe();
        
        if ( !isalive( self ) || self.sessionstate == "spectator" )
        {
            self.var_14955bc056bab547 = 1;
            playerlogic::spawnclient();
        }
    }
    
    self setorigin( spawnorigin );
    self setplayerangles( spawnangles );
    
    if ( level.parachutecancutautodeploy )
    {
        self skydive_cutautodeployon();
    }
    else
    {
        self skydive_cutautodeployoff();
    }
    
    if ( level.parachutecancutparachute )
    {
        self skydive_cutparachuteon();
    }
    else
    {
        self skydive_cutparachuteoff();
    }
    
    thread parachute::startfreefall( level.parachutedeploydelay, 0, undefined, undefined, 1 );
    
    if ( isdefined( self.primaryweapons ) )
    {
        foreach ( weapon in self.primaryweapons )
        {
            self givemaxammo( weapon );
            self setweaponammoclip( weapon, weaponclipsize( weapon ) );
        }
    }
}

// Namespace ob_laststand
// Params 0
// Checksum 0x6ba85889, Offset: 0x37c3
// Size: 0xc, Type: bool
function is_eliminated()
{
    return istrue( self.br_iseliminated );
}

// Namespace ob_laststand
// Params 1, eflags: 0x4
// Checksum 0x4a45639f, Offset: 0x37d8
// Size: 0x11b
function private function_8486bcf58a05b227( event )
{
    if ( !event )
    {
        return 0;
    }
    
    if ( !isdefined( level.var_67fb19a6c8627a49 ) )
    {
        level.var_67fb19a6c8627a49 = [];
    }
    
    if ( !isdefined( level.var_67fb19a6c8627a49[ event ] ) )
    {
        timesec = 0;
        
        if ( level.var_bb86f77304f193c4.var_3801e18ab64ea667.size > 0 )
        {
            foreach ( action in level.var_bb86f77304f193c4.var_3801e18ab64ea667 )
            {
                if ( action.event == event )
                {
                    timesec = action.reductionsec ?? 0;
                    break;
                }
            }
        }
        
        level.var_67fb19a6c8627a49[ event ] = timesec;
        return timesec;
    }
    
    return level.var_67fb19a6c8627a49[ event ];
}

// Namespace ob_laststand
// Params 4, eflags: 0x4
// Checksum 0xc3959cfc, Offset: 0x38fc
// Size: 0x1a1
function private reducerespawntimer( players, deltasec, player, event )
{
    if ( !isarray( players ) )
    {
        players = [ players ];
    }
    
    eventhastext = isdefined( event ) && rank::scoreeventhastext( event );
    
    foreach ( player in players )
    {
        if ( player.respawndelay > 0 )
        {
            player.respawndelay = maxint( 0, player.respawndelay - deltasec );
            player.respawndelta += deltasec;
            
            if ( eventhastext && ( !isdefined( player.var_7418be40eeb57cfe ) || player.var_7418be40eeb57cfe.timesec < deltasec ) )
            {
                if ( !isdefined( player.var_7418be40eeb57cfe ) )
                {
                    player.var_7418be40eeb57cfe = spawnstruct();
                }
                
                player.var_7418be40eeb57cfe.timesec = deltasec;
                player.var_7418be40eeb57cfe.playerid = player.sessionuimemberindex + 1;
                player.var_7418be40eeb57cfe.event = event;
            }
        }
    }
}

// Namespace ob_laststand
// Params 1, eflags: 0x4
// Checksum 0x1f210e7d, Offset: 0x3aa5
// Size: 0xa5
function private function_1bf928cd0a0d998d( player )
{
    var_6c22a8fefb4c3789 = [];
    squadmembers = player squad_utility::getsquadmembers();
    
    foreach ( squadmember in squadmembers )
    {
        if ( !isalive( squadmember ) )
        {
            var_6c22a8fefb4c3789[ var_6c22a8fefb4c3789.size ] = squadmember;
        }
    }
    
    return var_6c22a8fefb4c3789;
}

// Namespace ob_laststand
// Params 1, eflags: 0x4
// Checksum 0x5792375d, Offset: 0x3b53
// Size: 0x1d2
function private function_8c5e06ee1e60aeb7( deathparams )
{
    if ( self.death_source == "despawn" )
    {
        return;
    }
    
    if ( !isdefined( deathparams.eattacker ) )
    {
        return;
    }
    
    if ( isplayer( deathparams.eattacker.owner ) )
    {
        deathparams.eattacker = deathparams.eattacker.owner;
    }
    else if ( isdefined( deathparams.eattacker.vehicletype ) )
    {
        deathparams.eattacker = deathparams.eattacker getvehicleowner();
    }
    
    if ( !isplayer( deathparams.eattacker ) )
    {
        return;
    }
    
    var_6c22a8fefb4c3789 = function_1bf928cd0a0d998d( deathparams.eattacker );
    
    if ( var_6c22a8fefb4c3789.size == 0 )
    {
        return;
    }
    
    victimcategory = ai_category::function_e6e323e14b12152e( deathparams.victim );
    event = undefined;
    
    switch ( victimcategory )
    {
        case #"normal":
            event = #"elimination_kill_normal";
            break;
        case #"advanced":
            event = #"elimination_kill_advanced";
            break;
        case #"special":
            event = #"elimination_kill_special";
            break;
        case #"elite":
            event = #"elimination_kill_elite";
            break;
        case #"boss":
            event = #"elimination_kill_boss";
            break;
        default:
            reductionsec = 0;
            break;
    }
    
    reductionsec = function_8486bcf58a05b227( event );
    
    if ( reductionsec > 0 )
    {
        reducerespawntimer( var_6c22a8fefb4c3789, reductionsec, deathparams.eattacker, event );
    }
}

// Namespace ob_laststand
// Params 1, eflags: 0x4
// Checksum 0xa078e3a3, Offset: 0x3d2d
// Size: 0x7c
function private on_cache_opened( params )
{
    if ( !isplayer( params.player ) )
    {
        return;
    }
    
    timesec = function_8486bcf58a05b227( #"container_looted" );
    
    if ( timesec <= 0 )
    {
        return;
    }
    
    var_6c22a8fefb4c3789 = function_1bf928cd0a0d998d( params.player );
    reducerespawntimer( var_6c22a8fefb4c3789, timesec, params.player, #"container_looted" );
}

// Namespace ob_laststand
// Params 1, eflags: 0x4
// Checksum 0xba7df99f, Offset: 0x3db1
// Size: 0x1d
function private function_74957fa2c36123b6( params )
{
    activity_common::function_2dd4f07fa5c3e911( "ActivitySuccess", &on_activity_complete );
}

// Namespace ob_laststand
// Params 1, eflags: 0x4
// Checksum 0x4b94d3c3, Offset: 0x3dd6
// Size: 0x210
function private on_activity_complete( relevantinfostruct )
{
    timesec = function_8486bcf58a05b227( #"ob_minor_activity_complete_green" );
    
    if ( timesec <= 0 )
    {
        return;
    }
    
    if ( isarray( relevantinfostruct.playerlist ) )
    {
        var_cd502f7a90c6a4c0 = [];
        
        foreach ( player in relevantinfostruct.playerlist )
        {
            if ( isplayer( player ) )
            {
                if ( !isdefined( var_cd502f7a90c6a4c0[ player.team ] ) )
                {
                    var_cd502f7a90c6a4c0[ player.team ] = [];
                }
                
                if ( !isdefined( var_cd502f7a90c6a4c0[ player.team ][ player.sessionsquadid ] ) )
                {
                    var_cd502f7a90c6a4c0[ player.team ][ player.sessionsquadid ] = player;
                }
            }
        }
        
        foreach ( team in var_cd502f7a90c6a4c0 )
        {
            foreach ( squadrep in team )
            {
                var_6c22a8fefb4c3789 = function_1bf928cd0a0d998d( squadrep );
                reducerespawntimer( var_6c22a8fefb4c3789, timesec, squadrep, #"ob_minor_activity_complete_green" );
            }
        }
    }
}

// Namespace ob_laststand
// Params 2, eflags: 0x4
// Checksum 0x39cc92b9, Offset: 0x3fee
// Size: 0x72
function private function_fe2e4ec30cae8a7c( var_c4b64c0f1a5c0a3c, shouldforceupdate )
{
    packeddata = self getclientomnvar( "ui_resurgenceRespawnTimer" );
    packeddata = omnvar_utility::repackomnvar( 1, 7, packeddata, var_c4b64c0f1a5c0a3c );
    
    if ( shouldforceupdate )
    {
        forceupdate = !omnvar_utility::unpackvalue( 15, 1, packeddata );
        packeddata = omnvar_utility::repackomnvar( 15, 1, packeddata, forceupdate );
    }
    
    self setclientomnvar( "ui_resurgenceRespawnTimer", packeddata );
}

// Namespace ob_laststand
// Params 3, eflags: 0x4
// Checksum 0xba67f1c7, Offset: 0x4068
// Size: 0x75
function private initrespawntimer( var_c4b64c0f1a5c0a3c, totaltimesec, isshow )
{
    assert( var_c4b64c0f1a5c0a3c <= totaltimesec, "<dev string:x81>" );
    packeddata = 0;
    packeddata = omnvar_utility::repackomnvar( 0, 1, packeddata, isshow );
    packeddata = omnvar_utility::repackomnvar( 1, 7, packeddata, var_c4b64c0f1a5c0a3c );
    packeddata = omnvar_utility::repackomnvar( 8, 7, packeddata, totaltimesec );
    self setclientomnvar( "ui_resurgenceRespawnTimer", packeddata );
}

// Namespace ob_laststand
// Params 0, eflags: 0x4
// Checksum 0x6c957d6f, Offset: 0x40e5
// Size: 0xe
function private function_638d8fe07235b7d5()
{
    self setclientomnvar( "ui_resurgence_action_feedback", 0 );
}

// Namespace ob_laststand
// Params 2, eflags: 0x4
// Checksum 0x1848459f, Offset: 0x40fb
// Size: 0x142
function private function_3ddd9035faca69e0( respawndelta, respawnaction )
{
    currentvalue = self getclientomnvar( "ui_resurgence_action_feedback" );
    eventid = 0;
    isscriptbundlesplash = 0;
    
    if ( isdefined( respawnaction.event ) )
    {
        eventid = rank::function_f465d08c4d101328( respawnaction.event );
        
        if ( !isdefined( eventid ) || eventid < 0 )
        {
            eventid = rank::getscoreinfocategory( respawnaction.event, #"splashtablerow" );
        }
        else
        {
            isscriptbundlesplash = 1;
        }
    }
    
    haspenalty = 0;
    forceupdate = !omnvar_utility::unpackvalue( 24, 1, currentvalue );
    packeddata = currentvalue;
    
    if ( isdefined( respawnaction.playerid ) )
    {
        packeddata = omnvar_utility::repackomnvar( 0, 3, packeddata, respawnaction.playerid );
    }
    
    packeddata = omnvar_utility::repackomnvar( 3, 1, packeddata, isscriptbundlesplash );
    packeddata = omnvar_utility::repackomnvar( 4, 12, packeddata, eventid );
    packeddata = omnvar_utility::repackomnvar( 16, 7, packeddata, respawndelta );
    packeddata = omnvar_utility::repackomnvar( 23, 1, packeddata, haspenalty );
    packeddata = omnvar_utility::repackomnvar( 24, 1, packeddata, forceupdate );
    self setclientomnvar( "ui_resurgence_action_feedback", packeddata );
}

