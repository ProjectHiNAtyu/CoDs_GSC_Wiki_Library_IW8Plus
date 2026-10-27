// scripts\mp\common\equipment\tac_insert.gsc  (hash_2d9114caf581498f.gscc) (size: 26856 Bytes / 0x68e8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x77827ab2 (2005039794)
// size ...... 26856 (0x68e8)
// includes .. 41  (offset: 0x62b0)
// strings ... 69  (offset: 0x63f8)
// dev strs .. 6   (offset: 0x68a0)
// exports ... 63  (offset: 0x3db0)
// cseg ...... 0x5b8 + 0x37f8 (0x3db0)
// imports ... 226 (offset: 0x4788)
// animtree1 . 0   (offset: 0x68e8)
// animtree2 . 0   (offset: 0x68e8)
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\elevators;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\mp\analyticslog;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\challenges;
#using scripts\mp\class;
#using scripts\mp\common\equipment\haywire;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\entity;
#using scripts\mp\common\utility\equipment_utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\join_team_aggregator;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\damage;
#using scripts\mp\damagefeedback;
#using scripts\mp\emp_debuff;
#using scripts\mp\ent_manager;
#using scripts\mp\entityheadicons;
#using scripts\mp\equipment;
#using scripts\mp\equipment_interact;
#using scripts\mp\gamelogic;
#using scripts\mp\hud_message;
#using scripts\mp\outofbounds;
#using scripts\mp\playerlogic;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\spectating;
#using scripts\mp\supers;
#using scripts\mp\telemetry_mp;
#using scripts\mp\weapons;

#namespace tac_insert;

// Namespace tac_insert
// Params 0, eflags: 0x1
// Checksum 0xb838a742, Offset: 0x5d6
// Size: 0x1aa
function autoexec tacinsert_init()
{
    utility::flag_wait( "supers_initialized" );
    supers_mp::function_48aaa60b2ce7b8a1( "super_tac_insert", &tacinsert_set, &tacinsert_unset, undefined, undefined, undefined, undefined, undefined, undefined, undefined );
    level.tacinserts = [];
    join_team_aggregator::registeronplayerjointeamcallback( &tacinsert_onjoinedteam );
    callback::add( #"hash_244314ef9125e636", &onplayerdeath );
    
    if ( isbrgamemode() )
    {
        level thread tacinsert_deleteontoofar();
    }
    
    weapons::registerusedcallback( "flare", &tacinsert_used );
    weapons::registerusedcallback( "tac_insert", &tacinsert_used );
    utility::registersharedfunc( #"hash_ddfd165eca1acbee", #"hash_34e67067fbad9026", &function_c9582650e463d8d9 );
    equipment_mp::registercallback( "equip_tac_insert", "onGive", &tacinsert_set );
    equipment_mp::registercallback( "equip_tac_insert", "onTake", &tacinsert_unset );
    utility::registersharedfunc( #"tac_insert", #"respawn", &tacinsert_respawn );
    utility::registersharedfunc( #"tac_insert", #"hash_2dbdd4400cffa8b8", &function_bfb1133e7eb35725 );
    utility::registersharedfunc( #"tac_insert", #"waitgiveloadout", &function_f536d7ab98e3f294 );
    utility::registersharedfunc( #"tac_insert", #"destroy", &tacinsert_destroy );
    utility::registersharedfunc( #"tac_insert", #"hack", &hack );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"train" ][ #"hash_2edafff898b3de81" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        level [[ var_32dbca3143d9c4a5 ]]( #"tac_insert", &deletetacinsert );
    }
}

// Namespace tac_insert
// Params 2, eflags: 0x4
// Checksum 0xebd54b17, Offset: 0x788
// Size: 0x1ad
function private hack( hackeffect, attacker )
{
    if ( !hackeffect.var_30e7de3d76d5a085 )
    {
        return;
    }
    
    self.owner thread equipment_utility::function_364a1a0e0c018518( self.equipmentref, #"stolen_hacked" );
    
    if ( self.owner )
    {
        self.owner.setspawnpoint = undefined;
        self.owner weapons::removeequip( self );
        self.owner setclientomnvar( "ui_super_tac_insert_active", 0 );
    }
    
    equipment_mp::hackequipment( attacker, hackeffect.var_fe6111ff085b2063 );
    attacker playerlogic::spawnpoint_clearspawnpoint( 0, 0, 1 );
    attacker thread function_d74aac91ae233771( self );
    attacker setclientomnvar( "ui_super_tac_insert_active", 1 );
    self.team = attacker.team;
    self.owner = attacker;
    self setotherent( attacker );
    thread tacinsert_damagelistener( attacker );
    thread tacinsert_destroyuselistener( attacker );
    self setscriptablepartstate( #"visibility", #"show", 0 );
    self setscriptablepartstate( #"smoke", #"active", 0 );
    sentientpoolmanager::registersentient( "Tactical_Static", attacker );
    thread weapons::monitordisownedequipment( attacker, self, 0 );
    attacker playerlogic::spawnpoint_setspawnpoint( self.playerspawnpos, self.playerspawnangles, self, 1, self.var_18b7235092c7464 );
    attacker thread function_27e9cc440c3c8c4a( self );
    
    if ( isdefined( level.tacinsert_gamemode_callback ) )
    {
        attacker [[ level.tacinsert_gamemode_callback ]]();
    }
    
    self setscriptablepartstate( #"hacked", #"stolen", 0 );
}

// Namespace tac_insert
// Params 0
// Checksum 0xc883252c, Offset: 0x93d
// Size: 0x24
function function_c9582650e463d8d9()
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_tac_insert" );
    return bundle.var_2fab490ac336845e;
}

// Namespace tac_insert
// Params 1
// Checksum 0xd0332f, Offset: 0x96a
// Size: 0x90
function tacinsert_onjoinedteam( player )
{
    foreach ( tacinsert in level.tacinserts )
    {
        tacinsert tacinsert_updatepickupusability( player );
        tacinsert tacinsert_updatedestroyusability( player );
    }
}

// Namespace tac_insert
// Params 0
// Checksum 0x26efae8a, Offset: 0xa02
// Size: 0x1a1
function tacinsert_deleteontoofar()
{
    level endon( #"game_ended" );
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_tac_insert" );
    
    while ( true )
    {
        tacinserts = level.tacinserts;
        checks = 0;
        
        foreach ( tacinsert in tacinserts )
        {
            if ( !isdefined( tacinsert ) )
            {
                continue;
            }
            
            if ( tacinsert.isdestroyed )
            {
                continue;
            }
            
            if ( !isdefined( tacinsert.owner ) )
            {
                continue;
            }
            
            distsq = distance2dsquared( tacinsert.origin, tacinsert.owner.origin );
            var_cae3f3ebd5c488ed = bundle.var_55cf8d45a54b83c3 * bundle.var_55cf8d45a54b83c3;
            
            if ( distsq >= var_cae3f3ebd5c488ed )
            {
                tacinsertsplash = "tac_insert_fail_br_too_far";
                
                if ( isdefined( tacinsert.bundle ) )
                {
                    tacinsertsplash = tacinsert.bundle.var_c674f33c2ea89f14 ?? "tac_insert_fail_br_too_far";
                }
                
                tacinsert.owner thread hud_message::showsplash( tacinsertsplash );
                tacinsert tacinsert_destroy( 0 );
            }
            
            checks++;
            
            if ( checks >= 5 )
            {
                checks = 0;
                waitframe();
            }
        }
        
        waitframe();
    }
}

// Namespace tac_insert
// Params 4
// Checksum 0x85892c7e, Offset: 0xbab
// Size: 0x2e
function tacinsert_set( ref, slot, variantid, attachments )
{
    thread tacinsert_monitorupdatespawnposition();
}

// Namespace tac_insert
// Params 2
// Checksum 0xc50bf13, Offset: 0xbe1
// Size: 0x21
function tacinsert_unset( ref, slot )
{
    self notify( #"hash_2aa5b15b4c2e037b" );
}

// Namespace tac_insert
// Params 0
// Checksum 0x80c2c4f7, Offset: 0xc0a
// Size: 0xed
function tacinsert_monitorupdatespawnposition()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( #"hash_2aa5b15b4c2e037b" );
    self.tispawnposition = [];
    weaponname = supers_mp::function_5ffd3dfa9cc1e8de( "super_tac_insert" ).tacinsert_weaponname;
    
    if ( !isdefined( weaponname ) )
    {
        weaponname = level.equipment.table[ "equip_tac_insert" ].bundle.tacinsert_weaponname ?? "flare_mp";
    }
    
    while ( true )
    {
        tacinsert_updatespawnposition();
        currentweapon = self getheldoffhand();
        var_aff188de6a93384f = currentweapon.basename == weaponname;
        var_866524226d65fb94 = var_aff188de6a93384f ? 0.05 : 1;
        utility::waittill_any_timeout( var_866524226d65fb94, "offhand_pullback" );
    }
}

// Namespace tac_insert
// Params 1
// Checksum 0x929127c5, Offset: 0xcff
// Size: 0x59
function function_c45b733c1af19c8c( player )
{
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    player endon( #"hash_2aa5b15b4c2e037b" );
    player endon( #"hash_28a7bf6591914550" );
    
    while ( true )
    {
        wait 1;
        player playerlogic::function_8d15c151f143de4e( self, 1 );
    }
}

// Namespace tac_insert
// Params 0
// Checksum 0x83818f7b, Offset: 0xd60
// Size: 0x37
function tacinsert_updatespawnposition()
{
    spawnpos = self.origin;
    result = tacinsert_isvalidspawnposition( spawnpos );
    
    if ( result )
    {
        tacinsert_cachespawnposition( spawnpos );
    }
}

// Namespace tac_insert
// Params 1
// Checksum 0xa8c33aae, Offset: 0xd9f
// Size: 0x36, Type: bool
function function_bfb1133e7eb35725( spawnpos )
{
    spawnposoffset = spawnpos + ( 0, 0, 3 );
    
    if ( !canspawn( spawnposoffset ) )
    {
        return false;
    }
    
    return true;
}

// Namespace tac_insert
// Params 2
// Checksum 0x17d5df40, Offset: 0xdde
// Size: 0x74, Type: bool
function tacinsert_isvalidspawnposition( spawnpos, isonspawn )
{
    if ( !function_bfb1133e7eb35725( spawnpos ) )
    {
        return false;
    }
    
    if ( !isalive( self ) )
    {
        return true;
    }
    
    if ( outofbounds::istouchingoobtrigger() )
    {
        return false;
    }
    
    if ( !self isonground() && !self isswimming() )
    {
        return false;
    }
    
    if ( !isonspawn )
    {
        waitframe();
    }
    
    if ( !self )
    {
        return false;
    }
    
    if ( !self isonground() && !self isswimming() )
    {
        return false;
    }
    
    return true;
}

// Namespace tac_insert
// Params 1
// Checksum 0xd4d0dbef, Offset: 0xe5b
// Size: 0x44
function tacinsert_cachespawnposition( newposition )
{
    if ( self.tispawnposition[ 0 ] == newposition )
    {
        return;
    }
    
    self.tispawnposition[ 1 ] = self.tispawnposition[ 0 ];
    self.tispawnposition[ 0 ] = newposition;
}

// Namespace tac_insert
// Params 0
// Checksum 0x60eb5220, Offset: 0xea7
// Size: 0x4a
function tacinsert_getspawnposition()
{
    if ( isdefined( self.tispawnposition ) )
    {
        if ( isdefined( self.tispawnposition[ 1 ] ) )
        {
            return self.tispawnposition[ 1 ];
        }
        
        if ( isdefined( self.tispawnposition[ 0 ] ) )
        {
            return self.tispawnposition[ 0 ];
        }
    }
}

// Namespace tac_insert
// Params 0
// Checksum 0xc9740dd7, Offset: 0xefa
// Size: 0x9
function deletetacinsert()
{
    tacinsert_destroy();
}

// Namespace tac_insert
// Params 1
// Checksum 0xffb84da3, Offset: 0xf0b
// Size: 0x51
function tacinsert_used( grenade )
{
    if ( self.var_463ba322f1f34d4 )
    {
        self.var_463ba322f1f34d4 = 0;
        grenade delete();
        return;
    }
    
    result = tacinsert_deploy( grenade );
    
    if ( !result )
    {
        if ( isdefined( grenade ) )
        {
            grenade delete();
        }
    }
}

// Namespace tac_insert
// Params 1
// Checksum 0xc85eae4d, Offset: 0xf64
// Size: 0x511, Type: bool
function tacinsert_deploy( grenade )
{
    grenade.superref = "super_tac_insert";
    grenade setscriptablepartstate( #"visibility", #"hide", 0 );
    tacinsert_updatespawnposition();
    
    if ( !isdefined( grenade ) )
    {
        return false;
    }
    
    if ( !self )
    {
        return false;
    }
    
    spawnposition = tacinsert_getspawnposition();
    
    if ( !isdefined( spawnposition ) )
    {
        hud_message::showerrormessage( %"mp/tac_insert_cannot_place" );
        thread tacinsert_refund();
        return false;
    }
    
    distfromplayersq = distancesquared( self.origin, spawnposition );
    
    if ( distfromplayersq >= 65536 )
    {
        hud_message::showerrormessage( %"mp/tac_insert_cannot_place" );
        thread tacinsert_refund();
        return false;
    }
    
    if ( entity::touchingbadtrigger() )
    {
        hud_message::showerrormessage( %"mp/tac_insert_cannot_place" );
        thread tacinsert_refund();
        return false;
    }
    
    startpos = spawnposition + ( 0, 0, 16 );
    endpos = spawnposition + ( 0, 0, -16 );
    
    if ( !function_9f6372bc2a81e44d( grenade, startpos, endpos ) )
    {
        hud_message::showerrormessage( %"mp/tac_insert_cannot_place" );
        thread tacinsert_refund();
        return false;
    }
    
    if ( isdefined( level.var_59abd25eeb5b2fed ) )
    {
        canplant = grenade [[ level.var_59abd25eeb5b2fed ]]();
        
        if ( !canplant )
        {
            hud_message::showerrormessage( %"mp/tac_insert_cannot_place" );
            thread tacinsert_refund();
            return false;
        }
    }
    
    if ( isdefined( level.var_55e3eacb4bfeaea6 ) )
    {
        if ( !self [[ level.var_55e3eacb4bfeaea6 ]]( spawnposition ) )
        {
            hud_message::showerrormessage( %"mp/tac_insert_cannot_place" );
            thread tacinsert_refund();
            return false;
        }
    }
    
    playerlogic::spawnpoint_clearspawnpoint( 0, 0, 1 );
    isplayerunderwater = self isswimunderwater();
    isplayerswimming = self isswimming();
    var_237c99f29e250143 = function_95ba343c270ca525( grenade );
    tacinsert = undefined;
    
    if ( isplayerunderwater || var_237c99f29e250143 )
    {
        tacinsert = function_366e97a990c450a2( grenade, startpos, endpos );
    }
    else
    {
        tacinsert = function_aa97fe86878e9716( grenade, startpos, endpos, isplayerswimming );
    }
    
    if ( !isdefined( tacinsert ) )
    {
        hud_message::showerrormessage( %"mp/tac_insert_cannot_place" );
        thread tacinsert_refund();
        return false;
    }
    
    thread function_d74aac91ae233771( tacinsert );
    self setclientomnvar( "ui_super_tac_insert_active", 1 );
    tacinsert setscriptablepartstate( #"visibility", #"show", 0 );
    function_446c0362b37d507f( tacinsert );
    tacinsert sentientpoolmanager::registersentient( "Tactical_Static", self );
    
    if ( isdefined( tacinsert.bundle.var_dac8670e23cdcd48 ) )
    {
        var_431a00625150bda2 = tacinsert.bundle.var_dac8670e23cdcd48;
        
        if ( !isxhash( var_431a00625150bda2 ) )
        {
            var_431a00625150bda2 = getxhash( var_431a00625150bda2 );
        }
        
        level thread battlechatter_mp::trysaylocalsound( self, var_431a00625150bda2 );
    }
    
    weapons::onequipmentplanted( tacinsert, "equip_tac_insert", &tacinsert_destroy );
    var_6637462580611fe3 = game_utility::getgametype() == "siege";
    thread weapons::monitordisownedequipment( self, tacinsert, var_6637462580611fe3 );
    tacinsert emp_debuff::set_apply_emp_callback( &tacinsert_empapplied );
    
    if ( level.killstreak_emp_initialized )
    {
        tacinsert.ksempapplycallback = &tacinsert_empapplied;
    }
    
    tacinsert haywire::function_7f69a1eb3d590f76( &tacinsert_empapplied );
    tacinsert function_a4ebfb83ec0621b9( &tacinsert_destroy );
    
    if ( isdefined( level.elevators ) )
    {
        foreach ( elevators in level.elevators )
        {
            elevators thread elevators::isentitytouchingdoortrigger( tacinsert );
        }
    }
    
    utility::function_969f9f5596dba07a( tacinsert, &tacinsert_destroy );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"push_zone" ][ #"hash_4f146fe3a20624d1" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        tacinsert [[ var_32dbca3143d9c4a5 ]]( &tacinsert_destroy );
    }
    
    tacinsert thread weapons::function_4e52e334301e8205( &function_5b2baa5af4db93b5, "tacInsert_stuckOnGround" );
    tacinsert thread function_bdc25553dede1f71();
    var_d9edd592b9be77e9 = self isswimming();
    playerlogic::spawnpoint_setspawnpoint( spawnposition, self.angles, tacinsert, 1, var_d9edd592b9be77e9 );
    thread function_27e9cc440c3c8c4a( grenade );
    entnum = tacinsert getentitynumber();
    level.tacinserts[ entnum ] = tacinsert;
    
    if ( isdefined( level.tacinsert_gamemode_callback ) )
    {
        self [[ level.tacinsert_gamemode_callback ]]();
    }
    
    challenges::function_4fd386d590e901d8( grenade, #"hash_c50cf868c6994df3", #"use" );
    challengeparams = { #fieldupgraderef:"super_tac_insert", #fieldupgradeent:grenade, #fieldupgradeowner:grenade.owner };
    callback::callback( #"hash_2af4adf11224c49a", challengeparams );
    return true;
}

// Namespace tac_insert
// Params 0
// Checksum 0x1ac0950, Offset: 0x147e
// Size: 0x60
function function_bdc25553dede1f71()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        result = utility::waittill_any_return_params( "missile_stuck" );
        
        if ( result[ 2 ] == "water" )
        {
            continue;
        }
        
        if ( isdefined( result[ 0 ] ) )
        {
            continue;
        }
        
        self notify( #"tacInsert_stuckOnGround" );
        return;
    }
}

// Namespace tac_insert
// Params 0
// Checksum 0xbe898e5, Offset: 0x14e6
// Size: 0xd
function function_5b2baa5af4db93b5()
{
    tacinsert_destroy( 0, 0, 1 );
}

// Namespace tac_insert
// Params 1
// Checksum 0xdddc6387, Offset: 0x14fb
// Size: 0x3d
function function_d74aac91ae233771( tacinsert )
{
    tacinsert endon( #"tacinsert_destroyed" );
    utility::waittill_any( "disconnect", "joined_team", "joined_spectators" );
    tacinsert tacinsert_destroy( 0, 1, 1 );
}

// Namespace tac_insert
// Params 3
// Checksum 0xbf2af6, Offset: 0x1540
// Size: 0x1fe
function function_366e97a990c450a2( grenade, startpos, endpos )
{
    ignoreents = [ self, grenade ];
    watercontents = trace::create_contents( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 );
    waterstarttrace = self.origin + ( 0, 0, 3000 );
    waterendtrace = self.origin;
    var_1eae59483969e6d3 = trace::ray_trace( waterstarttrace, waterendtrace, ignoreents, watercontents, 0 );
    assert( var_1eae59483969e6d3[ "<dev string:x24>" ] != "<dev string:x2c>", "<dev string:x39>" );
    var_c172df3536224b46 = var_1eae59483969e6d3[ "position" ];
    geostarttrace = self.origin;
    geocontents = physics_createcontents( [ "physicscontents_itemclip", "physicscontents_item" ] );
    var_aa07718f9f1cb969 = trace::ray_trace( geostarttrace, var_c172df3536224b46, ignoreents, geocontents, 1 );
    
    if ( var_aa07718f9f1cb969[ "hittype" ] != "hittype_none" )
    {
        return;
    }
    
    if ( !canspawn( var_c172df3536224b46, self ) )
    {
        return;
    }
    
    tacinsertpos = self.origin;
    tacinsertangles = self.angles;
    grenade.angles = tacinsertangles;
    weaponname = supers_mp::function_5ffd3dfa9cc1e8de( "super_tac_insert" ).tacinsert_weaponname;
    
    if ( !isdefined( weaponname ) )
    {
        weaponname = grenade.bundle.tacinsert_weaponname ?? "flare_mp";
    }
    
    tacinsert = weapon::_launchgrenade( weaponname, tacinsertpos, ( 0, 0, 0 ), undefined, 1, grenade );
    tacinsert.angles = tacinsertangles;
    tacinsert.createdunderwater = 1;
    tacinsert thread function_c45b733c1af19c8c( self );
    thread function_b07958a39bc4a4e3( tacinsert );
    return tacinsert;
}

// Namespace tac_insert
// Params 1
// Checksum 0xc113762, Offset: 0x1747
// Size: 0x10e, Type: bool
function function_95ba343c270ca525( grenade )
{
    ignoreents = [ self, grenade ];
    watercontents = trace::create_contents( 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 );
    waterstarttrace = self.origin + ( 0, 0, 3000 );
    waterendtrace = self.origin;
    var_1eae59483969e6d3 = trace::ray_trace( waterstarttrace, waterendtrace, ignoreents, watercontents, 0 );
    
    if ( var_1eae59483969e6d3[ "hittype" ] == "hittype_none" )
    {
        return false;
    }
    
    var_c172df3536224b46 = var_1eae59483969e6d3[ "position" ];
    geostarttrace = self.origin;
    geocontents = physics_createcontents( [ "physicscontents_itemclip", "physicscontents_item" ] );
    var_aa07718f9f1cb969 = trace::ray_trace( geostarttrace, var_c172df3536224b46, ignoreents, geocontents, 1 );
    
    if ( var_aa07718f9f1cb969[ "hittype" ] != "hittype_none" )
    {
        return false;
    }
    
    return true;
}

// Namespace tac_insert
// Params 1
// Checksum 0xbc2cf500, Offset: 0x185e
// Size: 0x115
function function_446c0362b37d507f( tacinsert )
{
    tacinsert.team = self.team;
    tacinsert.owner = self;
    tacinsert ent_manager::registerspawn( 3, &deletetacinsert );
    
    if ( tacinsert.createdunderwater )
    {
        tacinsert setscriptablepartstate( #"smoke", #"active_water", 0 );
    }
    else
    {
        tacinsert setscriptablepartstate( #"smoke", #"active", 0 );
    }
    
    tacinsert.issuper = isdefined( self.super ) && self.super.staticdata.ref == "super_tac_insert";
    tacinsert.superid = level.superglobals.staticsuperdata[ "super_tac_insert" ].id;
    tacinsert thread tacinsert_setupandwaitfordeath( self );
    tacinsert thread tacinsert_destroyongameended();
    tacinsert setotherent( self );
    self.current_tac_insert = tacinsert;
}

// Namespace tac_insert
// Params 4
// Checksum 0xe50c1be4, Offset: 0x197b
// Size: 0x1ec
function function_aa97fe86878e9716( grenade, startpos, endpos, var_ff6f80818ac90f50 )
{
    ignoreents = [ self, grenade ];
    contentoverride = trace::create_contents( 0, 1, 1, 1, 0, 1, 0 );
    traceresult = trace::ray_trace_detail( startpos, endpos, ignoreents, contentoverride, 0 );
    
    if ( traceresult[ "hittype" ] == "hittype_none" )
    {
        waitframe();
        radius = 14;
        traceresult = trace::sphere_trace( startpos, endpos, radius, ignoreents, contentoverride, 0 );
    }
    
    if ( traceresult[ "hittype" ] == "hittype_none" )
    {
        return;
    }
    
    normal = traceresult[ "normal" ];
    tacinsertpos = traceresult[ "position" ] + normal * ( 0, 0, 0.5 );
    spawnposition = tacinsert_getspawnposition();
    distancesq = distancesquared( spawnposition, tacinsertpos );
    
    if ( distancesq > 196 )
    {
        return;
    }
    
    weaponname = supers_mp::function_5ffd3dfa9cc1e8de( "super_tac_insert" ).tacinsert_weaponname;
    
    if ( !isdefined( weaponname ) )
    {
        weaponname = grenade.bundle.tacinsert_weaponname ?? "flare_mp";
    }
    
    tacinsert = weapon::_launchgrenade( weaponname, tacinsertpos, ( 0, 0, 0 ), undefined, 1, grenade );
    tacinsert.angles = self.angles;
    
    if ( var_ff6f80818ac90f50 )
    {
        thread function_b07958a39bc4a4e3( grenade );
    }
    
    traceresultent = traceresult[ "entity" ];
    
    if ( isdefined( traceresultent ) && killstreak_utility::function_947e7b15331fd6e3( traceresultent ) )
    {
        tacinsert linkto( traceresultent );
        var_ff0e1289702098c3 = getdvarint( @"hash_956f65ae92f862e", 1 );
        
        if ( var_ff0e1289702098c3 )
        {
            tacinsert thread function_c45b733c1af19c8c( self );
        }
    }
    
    return tacinsert;
}

// Namespace tac_insert
// Params 1
// Checksum 0x64dee45e, Offset: 0x1b70
// Size: 0x14f
function function_27e9cc440c3c8c4a( tacinsertent )
{
    tacinsertent endon( #"missile_water_impact" );
    level endon( #"game_ended" );
    timer = 0;
    destroyti = 0;
    
    while ( true )
    {
        msg = tacinsertent utility::waittill_notify_or_timeout_return( "missile_stuck", 0.25 );
        
        if ( msg == "missile_stuck" )
        {
            break;
        }
        
        if ( timer >= 2 )
        {
            break;
        }
        
        spawnpoint = self.setspawnpoint;
        
        if ( !isdefined( spawnpoint ) )
        {
            destroyti = 1;
        }
        else
        {
            level thread utility::draw_angles( tacinsertent.angles, tacinsertent.origin, ( 1, 0, 0 ), 1000, 100 );
            distancesq = distancesquared( tacinsertent.origin, spawnpoint.playerspawnpos );
            
            if ( distancesq > 196 && !tacinsertent.createdunderwater )
            {
                destroyti = 1;
            }
        }
        
        if ( destroyti )
        {
            break;
        }
        
        timer += 0.25;
    }
    
    if ( destroyti )
    {
        hud_message::showerrormessage( %"mp/tac_insert_cannot_place" );
        tacinsertent tacinsert_destroy( 0, 0, 1 );
        tacinsert_refund();
    }
}

// Namespace tac_insert
// Params 1
// Checksum 0x2d3f317f, Offset: 0x1cc7
// Size: 0x59
function function_b07958a39bc4a4e3( grenade )
{
    self endon( #"disconnect" );
    grenade endon( #"death" );
    level endon( #"game_ended" );
    grenade waittill( #"missile_stuck" );
    grenade setscriptablepartstate( #"splash", #"splash", 0 );
}

// Namespace tac_insert
// Params 1
// Checksum 0xe70feb06, Offset: 0x1d28
// Size: 0x46
function tacinsert_setupandwaitfordeath( owner )
{
    profilestart();
    self.headiconid = entityheadicons::setheadicon_equipment( self );
    profilestop();
    thread tacinsert_damagelistener( owner );
    thread tacinsert_destroyuselistener( owner );
    
    if ( !self.issuper )
    {
        thread tacinsert_pickuplistener( owner );
    }
}

// Namespace tac_insert
// Params 1
// Checksum 0xe15a4263, Offset: 0x1d76
// Size: 0x52
function tacinsert_damagelistener( owner )
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_tac_insert" ) ?? self.bundle;
    damage::monitordamage( bundle.maxhealth, "hitequip", &tacinsert_handledeathdamage, &tacinsert_modifydamage, 1 );
}

// Namespace tac_insert
// Params 1
// Checksum 0x67a286dd, Offset: 0x1dd0
// Size: 0x4c
function tacinsert_modifydamage( data )
{
    objweapon = data.objweapon;
    type = data.meansofdeath;
    return utility::handlemeleedamage( objweapon, type, data.damage );
}

// Namespace tac_insert
// Params 1
// Checksum 0x8043d1ba, Offset: 0x1e25
// Size: 0x168
function tacinsert_handledeathdamage( data )
{
    attacker = data.attacker;
    
    if ( self.owner player_utility::isenemy( attacker ) )
    {
        self.owner thread equipment_utility::function_72a91d0610eb601c( self.superref, #"destroyed", #"destroyed_multiple" );
    }
    
    self notify( #"enemy_destroyed_equipment", attacker );
    utility::callsharedfunc( #"supers", #"hash_28aeb93023a8a138", attacker, data.objweapon );
    
    if ( !isdefined( self.owner ) || player_utility::playersareenemies( self.owner, attacker ) )
    {
        attacker thread points::doscoreevent( #"destroyed_equipment" );
        tacinsert_givepointsfordeath( attacker, 0 );
    }
    
    if ( damagefeedback::isusingstackablehitmarker() )
    {
        var_7731d58f6f82f082 = { #mod:data.meansofdeath, #direction_vec:data.direction_vec, #point:data.point, #objweapon:data.objweapon, #victim:self };
        attacker damagefeedback::updatedamagefeedback( "", 1, undefined, undefined, undefined, undefined, undefined, undefined, undefined, var_7731d58f6f82f082, undefined, 3 );
    }
    
    thread tacinsert_destroy( 1 );
}

// Namespace tac_insert
// Params 1
// Checksum 0x3baaf26, Offset: 0x1f95
// Size: 0x1b3
function tacinsert_pickuplistener( owner )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    owner endon( #"disconnect" );
    self.pickuptrigger = spawn( "script_origin", self.origin );
    self.pickuptrigger.targetname = "tacInsert_pickupListener";
    self.pickuptrigger makeusable();
    self.pickuptrigger setcursorhint( "HINT_NOICON" );
    self.pickuptrigger sethintstring( &"mp_patch/pickup_ti" );
    self.pickuptrigger linkto( self );
    pickupsound = "iw9_tactical_insert_flare_pu";
    
    if ( isdefined( self.bundle ) )
    {
        pickupsound = self.bundle.tacinsert_pickupsound ?? "iw9_tactical_insert_flare_pu";
    }
    
    foreach ( player in level.players )
    {
        tacinsert_updatepickupusability( player );
    }
    
    while ( self.pickuptrigger )
    {
        self.pickuptrigger waittill( #"trigger", player );
        
        if ( player )
        {
            player playsound( pickupsound );
            player equipment_mp::giveequipment( "equip_tac_insert", "secondary" );
        }
        
        if ( self )
        {
            thread tacinsert_destroy( 0, 0, 1 );
        }
    }
}

// Namespace tac_insert
// Params 1
// Checksum 0x94858a03, Offset: 0x2150
// Size: 0x75
function tacinsert_updatepickupusability( player )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( !( isdefined( self ) && isdefined( self.pickuptrigger ) ) )
    {
        return;
    }
    
    if ( self.isdestroyed )
    {
        return;
    }
    
    isowner = player == self.owner;
    
    if ( isowner )
    {
        self.pickuptrigger enableplayeruse( player );
        return;
    }
    
    self.pickuptrigger disableplayeruse( player );
}

// Namespace tac_insert
// Params 3
// Checksum 0x901a6bd3, Offset: 0x21cd
// Size: 0x342
function tacinsert_destroy( wasdestroyed, var_5644e579357ab063, hidefeedback )
{
    if ( !isdefined( self ) || self.isdestroyed )
    {
        return;
    }
    
    self.isdestroyed = 1;
    self.ti_timer = undefined;
    self.var_ae9100af7ee2e95b = undefined;
    
    if ( isdefined( self.owner ) )
    {
        if ( var_5644e579357ab063 )
        {
            thread tacinsert_brrespawnsplash();
            
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self.owner ) ) )
            {
                if ( isdefined( self.owner.leaderboarddata[ "tacticalInsertionSpawns" ] ) )
                {
                    self.owner.leaderboarddata[ "tacticalInsertionSpawns" ] = self.owner.leaderboarddata[ "tacticalInsertionSpawns" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "tacticalInsertionSpawns" ] ) )
                {
                    [[ level.leaderboardfunc[ "tacticalInsertionSpawns" ] ]]( self.owner, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:x78>" );
                
                if ( isdefined( self.owner.pers[ "tacticalInsertionSpawns" ] ) )
                {
                    self.owner.pers[ "tacticalInsertionSpawns" ] = self.owner.pers[ "tacticalInsertionSpawns" ] + 1;
                }
            }
            
            self.owner supers_mp::combatrecordsupermisc( "super_tac_insert" );
            self.owner challenges::function_a0936b0e5b4550f3( "super_tac_insert", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"hit" ) );
            analyticslog::logevent_fieldupgradeexpired( self.owner, self.superid, 1, istrue( wasdestroyed ) );
        }
        else
        {
            analyticslog::logevent_fieldupgradeexpired( self.owner, self.superid, 0, istrue( wasdestroyed ) );
        }
        
        if ( !var_5644e579357ab063 && !hidefeedback )
        {
            self.owner thread tacinsert_tacinsertdestroyedfeedback();
        }
        
        self.owner.setspawnpoint = undefined;
    }
    
    self makeunusable();
    
    if ( isdefined( self.pickuptrigger ) )
    {
        self.pickuptrigger delete();
    }
    
    self notify( #"death" );
    
    if ( isdefined( self.owner ) )
    {
        self.owner notify( #"tacinsert_destroyed" );
    }
    
    if ( !self.skipscriptable )
    {
        self setscriptablepartstate( #"smoke", #"neutral", 0 );
    }
    
    if ( self.createdunderwater )
    {
        self setscriptablepartstate( #"destroy", #"active_water", 1 );
    }
    else
    {
        self setscriptablepartstate( #"destroy", #"active", 1 );
    }
    
    self setscriptablepartstate( #"visibility", #"hide", 1 );
    
    if ( isdefined( self.owner ) )
    {
        self.owner weapons::removeequip( self );
        self.owner setclientomnvar( "ui_super_tac_insert_active", 0 );
    }
    
    thread tacinsert_delayeddelete();
}

// Namespace tac_insert
// Params 0
// Checksum 0xc3211cba, Offset: 0x2517
// Size: 0x8a
function tacinsert_tacinsertdestroyedfeedback()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    extrawait = 0;
    
    while ( !player::isreallyalive( self ) || player::isinkillcam() )
    {
        extrawait = 1;
        waitframe();
    }
    
    if ( extrawait )
    {
        wait 0.3;
    }
    
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_tac_insert" );
    feedbackicon = bundle.var_377e910ef3e480f0 ?? "tacinsert_destroyed";
    damagefeedback::hudicontype( feedbackicon );
}

// Namespace tac_insert
// Params 0
// Checksum 0x6a9442fc, Offset: 0x25a9
// Size: 0x82
function tacinsert_brrespawnsplash()
{
    if ( !isbrgamemode() )
    {
        return;
    }
    
    owner = self.owner;
    level endon( #"game_ended" );
    owner endon( #"death_or_disconnect" );
    wait 1.5;
    tacinsertsplash = "tac_insert_success_br";
    
    if ( isdefined( self.bundle ) )
    {
        tacinsertsplash = self.bundle.var_1886b4c02842d344 ?? "tac_insert_success_br";
    }
    
    owner thread hud_message::showsplash( tacinsertsplash );
}

// Namespace tac_insert
// Params 0
// Checksum 0x8dbbd602, Offset: 0x2633
// Size: 0x26
function tacinsert_destroyongameended()
{
    self endon( #"death" );
    level waittill( #"game_ended" );
    thread tacinsert_destroy( 0, 0, 1 );
}

// Namespace tac_insert
// Params 0
// Checksum 0x2a0098c8, Offset: 0x2661
// Size: 0x12
function tacinsert_delayeddelete()
{
    wait 1;
    ent_manager::deregisterspawn();
    self delete();
}

// Namespace tac_insert
// Params 1
// Checksum 0x8af2b866, Offset: 0x267b
// Size: 0xb4
function tacinsert_destroyuselistener( owner )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    owner endon( #"disconnect" );
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_tac_insert" );
    var_aacb78da5016573c = bundle.var_9d83d7a2c4169a01 ?? 0.3;
    destroyrange = bundle.var_d698fcfe464f1b17 ?? 128;
    hintstring = bundle.var_dfc5df4b445d78b1 ?? &"super_mp/destroy_super";
    thread equipment_interact::function_226793772d245e96( var_aacb78da5016573c, destroyrange, hintstring, self.team );
}

// Namespace tac_insert
// Params 1
// Checksum 0xe6903a78, Offset: 0x2737
// Size: 0x245
function tacinsert_respawn( overridetispawndelay )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( self.setspawnpoint ) )
    {
        return 0;
    }
    
    if ( game_utility_mp::isteamreviveenabled() )
    {
        return 0;
    }
    
    if ( game_utility::isinfectedgametype() && getdvarint( @"hash_b8bb29ae58a355f1", 1 ) )
    {
        return 0;
    }
    
    timeout = function_fc8d03d1d82b2393();
    
    if ( isdefined( overridetispawndelay ) )
    {
        timeout = overridetispawndelay;
    }
    
    thread function_d488a4b369a36cf8();
    
    if ( self.setspawnpoint.createdunderwater )
    {
        self.setspawnpoint setscriptablepartstate( #"hash_92ae7d8d9a7d7719", #"active_water", 0 );
    }
    else
    {
        self.setspawnpoint setscriptablepartstate( #"hash_92ae7d8d9a7d7719", #"active", 0 );
    }
    
    if ( timeout == 0 )
    {
        return 0;
    }
    
    cameraent = undefined;
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_tac_insert" );
    
    if ( isdefined( bundle ) && bundle.var_7fd393576874ab33 )
    {
        cameraent = tacinsert_createspawncamera();
    }
    
    thread tacinsert_activatespawncamera( cameraent, timeout );
    childthread function_882181014a63af0d( timeout );
    childthread tacinsert_monitorexit();
    childthread function_41dff9a6b9b0bb9d( timeout );
    msg = utility::waittill_any_return_no_endon_death( "use_ti_spawn", "tacInsert_destroyed", "force_spawn", "use_normal_spawn", "joined_team", "joined_spectators" );
    self setclientomnvar( "ui_super_tac_insert_respawn", 0 );
    self setclientomnvar( "ui_tom_ti_respawnTimer", 0 );
    
    if ( msg == "force_spawn" || msg == "use_normal_spawn" || msg == "tacInsert_destroyed" || msg == "joined_team" || msg == "joined_spectators" )
    {
        notdestroyed = msg != "tacInsert_destroyed";
        function_62ba0ca21148229c( cameraent );
        playerlogic::spawnpoint_clearspawnpoint( 1, 0, notdestroyed );
        self.var_3ce5ee980d4c5036 = undefined;
    }
    else if ( msg == "use_ti_spawn" )
    {
        thread tacinsert_onspawncameraslamzoom( cameraent );
        self.var_3ce5ee980d4c5036 = 1;
        function_b4190a35039fd46e( self.current_tac_insert, self );
    }
    
    if ( isdefined( self.ti_timer ) )
    {
        return self.ti_timer;
    }
    
    return 0;
}

// Namespace tac_insert
// Params 0
// Checksum 0x4b23eedf, Offset: 0x2984
// Size: 0x80
function function_fc8d03d1d82b2393()
{
    equip_bundle = equipment_mp::function_c90a9aa89b223dd7( "equip_tac_insert" );
    super_bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_tac_insert" );
    
    if ( equip_bundle && isdefined( equip_bundle.tacinsert_respawndelay ) )
    {
        return equip_bundle.tacinsert_respawndelay;
    }
    
    if ( super_bundle && isdefined( super_bundle.tacinsert_respawndelay ) )
    {
        return super_bundle.tacinsert_respawndelay;
    }
    
    return level.tispawndelay;
}

// Namespace tac_insert
// Params 1
// Checksum 0x3b597e1a, Offset: 0x2a0c
// Size: 0x71
function function_41dff9a6b9b0bb9d( timeout )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    timeelapsed = 0;
    
    while ( !self.var_fd88460f03feb34a )
    {
        timeelapsed += level.framedurationseconds;
        waitframe();
    }
    
    lower_message::setlowermessageomnvar( level.var_791076e7de107dc2, int( gettime() + ( timeout - timeelapsed ) * 1000 ) );
}

// Namespace tac_insert
// Params 2
// Checksum 0x66556f00, Offset: 0x2a85
// Size: 0x1bb
function tacinsert_activatespawncamera( cameraent, timeout )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"joined_team" );
    self endon( #"joined_spectators" );
    player::printspawnmessage( "tac Insert Spawn::tacInsert_activateSpawnCamera() START" );
    
    if ( isai( self ) )
    {
        return;
    }
    
    if ( level.gameended )
    {
        return;
    }
    
    if ( !isdefined( cameraent ) )
    {
        self.var_97174dbd51b73ea5 = 0;
        self notify( #"use_normal_spawn" );
        return;
    }
    
    self.var_97174dbd51b73ea5 = 1;
    waitframe();
    
    if ( !isdefined( cameraent ) )
    {
        self.var_97174dbd51b73ea5 = 0;
        self notify( #"use_normal_spawn" );
        return;
    }
    
    spectating::setdisabled();
    childthread function_3ef6b8b454abe424( 0, 0 );
    
    while ( !self.var_fd88460f03feb34a )
    {
        waitframe();
    }
    
    waitframe();
    respawntimeout = int( gettime() + timeout * 1000 );
    self setclientomnvar( "ui_tom_ti_respawnTimer", respawntimeout );
    self setclientomnvar( "ui_super_tac_insert_respawn", 1 );
    playerlogic::respawn_asspectator( self.origin, self.angles );
    player::setdof_default();
    player::updatesessionstate( "spectator" );
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_tac_insert" );
    
    if ( bundle.var_dfc3eb4a930a7d27 && bundle.var_8c1656fded41a2ee )
    {
        pbgpostfxbundlestart( self, bundle.var_8c1656fded41a2ee );
    }
    else if ( utility::isnightmap() )
    {
        self visionsetkillstreakforplayer( "iw9_mp_nvg_base_color" );
    }
    else
    {
        self visionsetkillstreakforplayer( "recon_drone_color_mp" );
    }
    
    self cameralinkto( cameraent, "tag_origin", 0, 1 );
    childthread function_285b7a25ce7f30db( cameraent );
}

// Namespace tac_insert
// Params 1
// Checksum 0x4964c57e, Offset: 0x2c48
// Size: 0x290
function tacinsert_onspawncameraslamzoom( cameraent )
{
    if ( !isdefined( cameraent ) )
    {
        return;
    }
    
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"joined_spectators" );
    self waittill( #"ti_spawncamera_start" );
    self cameralinkto( cameraent, "tag_origin", 1, 1 );
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_tac_insert" );
    
    if ( bundle.var_dfc3eb4a930a7d27 && bundle.var_8c1656fded41a2ee )
    {
        pbgpostfxbundlestart( self, bundle.var_8c1656fded41a2ee );
    }
    else if ( utility::isnightmap() )
    {
        self visionsetkillstreakforplayer( "iw9_mp_nvg_base_color" );
    }
    else
    {
        self visionsetkillstreakforplayer( "recon_drone_color_mp" );
    }
    
    player::_freezecontrols( 1, undefined, "slamZoom" );
    player_utility::function_dbe5a52a6654a982();
    player_utility::function_9d378d725bb4831e( "tac_insert::tacInsert_onSpawnCameraSlamZoom()" );
    self useinvisibleplayerduringspawnselection( 1 );
    self.plotarmor = 1;
    val::set( "slamZoom", "vehicle_use", 0 );
    assert( isdefined( self.spawndata ), "<dev string:x9e>" );
    assert( isdefined( cameraent ), "<dev string:xde>" );
    targetpos = self.spawndata.spawnorigin + ( 0, 0, 64 );
    targetangles = self.spawndata.spawnangles;
    slamzoomtime = getdvarfloat( @"hash_2552d1d61db3c4aa", 0.75 );
    childthread function_37f920823aa42048( cameraent, targetpos, targetangles, slamzoomtime );
    function_52300097879b2479( cameraent, targetpos, targetangles, slamzoomtime );
    function_62ba0ca21148229c( cameraent );
    player::updatesessionstate( "playing" );
    player::_freezecontrols( 0, undefined, "slamZoom" );
    player_utility::function_b54a1e23734ef07();
    player_utility::function_4688d689820ff1ed( "tac_insert::tacInsert_onSpawnCameraSlamZoom()" );
    self useinvisibleplayerduringspawnselection( 0 );
    self.plotarmor = 0;
    val::reset_all( "slamZoom" );
    self notify( #"spawned_player" );
    challenges::function_a0936b0e5b4550f3( "super_tac_insert", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"activate" ) );
    level notify( #"player_spawned", self, self.wasrevivespawn );
    thread playerlogic::setspawnnotifyomnvar();
    callback::callback( #"player_spawned", { #player:self, #revivespawn:1 } );
    self.wasrevivespawn = undefined;
    self.delayedspawnedplayernotify = undefined;
    self.spawndata = undefined;
}

// Namespace tac_insert
// Params 0
// Checksum 0x9e919631, Offset: 0x2ee0
// Size: 0x32
function function_d488a4b369a36cf8()
{
    self.tacinsertbuff = gettime();
    result = utility::waittill_notify_or_timeout_return( "death_or_disconnect", 10 );
    self.tacinsertbuff = undefined;
}

// Namespace tac_insert
// Params 1, eflags: 0x4
// Checksum 0xcd2a7995, Offset: 0x2f1a
// Size: 0xcc
function private onplayerdeath( deathdata )
{
    attacker = deathdata.attacker;
    victim = deathdata.victim;
    victim.var_3ce5ee980d4c5036 = undefined;
    
    if ( !player_utility::playersareenemies( attacker, victim ) )
    {
        return;
    }
    
    if ( !isdefined( attacker.tacinsertbuff ) )
    {
        return;
    }
    
    objweapon = level.equipment.table[ "equip_tac_insert" ].objweapon;
    attacker thread gamelogic_mp::threadedsetweaponstatbyname( objweapon, 1, "buff_kills" );
    attacker telemetry_mp::function_89a5d8fb8ed3a4fe( deathdata, attacker, attacker.tacinsertbuff, objweapon );
    victim thread gamelogic_mp::threadedsetweaponstatbyname( objweapon, 1, "killed_by", undefined, attacker );
}

// Namespace tac_insert
// Params 1
// Checksum 0xb0578ce6, Offset: 0x2fee
// Size: 0x69
function function_f536d7ab98e3f294( revivespawn )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    delay = getdvarfloat( @"hash_128ea8c781fb5fb8", 0.65 );
    wait delay;
    class::giveloadout( self.team, self.class, undefined, undefined, revivespawn );
}

// Namespace tac_insert
// Params 1
// Checksum 0x61c221cc, Offset: 0x305f
// Size: 0x35
function function_62ba0ca21148229c( cameraent )
{
    if ( !isdefined( cameraent ) )
    {
        return;
    }
    
    self cameraunlink();
    self.var_97174dbd51b73ea5 = undefined;
    self.var_fd88460f03feb34a = undefined;
    cameraent delete();
}

// Namespace tac_insert
// Params 4
// Checksum 0x3f11470d, Offset: 0x309c
// Size: 0xd3
function function_52300097879b2479( cameraent, targetpos, targetangles, slamzoomtime )
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_tac_insert" );
    wait 0.05;
    cameraent moveto( targetpos, slamzoomtime, 0.1, 0.1 );
    rotateblendtime = getdvarfloat( @"hash_5474294e363a8320", 0.25 );
    wait slamzoomtime - rotateblendtime;
    cameraent rotateto( targetangles, rotateblendtime, 0.075, 0.075 );
    wait 0.25;
    
    if ( bundle.var_dfc3eb4a930a7d27 && bundle.var_8c1656fded41a2ee )
    {
        pbgpostfxbundleend( self, bundle.var_8c1656fded41a2ee );
    }
    else
    {
        self visionsetkillstreakforplayer( "" );
    }
    
    wait 0.05;
}

// Namespace tac_insert
// Params 4
// Checksum 0x929679c, Offset: 0x3177
// Size: 0x137
function function_37f920823aa42048( cameraent, targetpos, targetangles, slamzoomtime )
{
    content = [ "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle", "physicscontents_characterproxy", "physicscontents_glass", "physicscontents_itemclip" ];
    contentoverride = physics_createcontents( content );
    airtrace = trace::ray_trace( cameraent.origin, targetpos, undefined, contentoverride );
    groundtrace = trace::ray_trace( targetpos, cameraent.origin, undefined, contentoverride );
    airfrac = airtrace[ "fraction" ];
    groundfrac = groundtrace[ "fraction" ];
    var_1e1b800543e6488e = 0.11;
    
    if ( airfrac < 1 )
    {
        if ( airfrac - 0.22 > 0 )
        {
            wait airfrac - 0.22;
        }
        
        holdtime = slamzoomtime - airfrac - groundfrac + var_1e1b800543e6488e;
        thread function_3ef6b8b454abe424( 0.1, holdtime, 0.25 );
    }
}

// Namespace tac_insert
// Params 1
// Checksum 0xafd8605b, Offset: 0x32b6
// Size: 0x150
function function_285b7a25ce7f30db( cameraent )
{
    self endon( #"use_ti_spawn" );
    self endon( #"tacinsert_destroyed" );
    self endon( #"force_spawn" );
    self endon( #"use_normal_spawn" );
    self endon( #"joined_team" );
    self endon( #"joined_spectators" );
    counter = 0;
    oscillatedistance = getdvarint( @"hash_96cda220c7b9c3b8", 50 );
    oscillatetime = getdvarfloat( @"hash_a7b33246bb4a88ce", 5 );
    oscillatehalfdistance = oscillatedistance / 2;
    offset = 0;
    
    while ( true )
    {
        if ( counter == 0 )
        {
            offset = oscillatehalfdistance;
        }
        else
        {
            offset = oscillatedistance;
            
            if ( counter % 2 == 1 )
            {
                offset *= -1;
            }
        }
        
        if ( !isdefined( cameraent ) )
        {
            return;
        }
        
        destination = cameraent.origin + anglestoright( cameraent.angles ) * offset;
        cameraent moveto( destination, counter == 0 ? oscillatetime / 2 : oscillatetime, 0.25, 0.25 );
        
        while ( distancesquared( cameraent.origin, destination ) > 0.5 )
        {
            waitframe();
        }
        
        counter++;
    }
}

// Namespace tac_insert
// Params 3
// Checksum 0xdf182da3, Offset: 0x340e
// Size: 0x118
function function_3ef6b8b454abe424( var_18c45282e4d29bc6, holdtime, fadeuptime )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( var_18c45282e4d29bc6 ) )
    {
        var_18c45282e4d29bc6 = 0;
    }
    
    if ( !isdefined( holdtime ) )
    {
        holdtime = 0;
    }
    
    if ( !isdefined( fadeuptime ) )
    {
        fadeuptime = 0.5;
    }
    
    fadeval = 0;
    totalframes = int( floor( var_18c45282e4d29bc6 / level.framedurationseconds ) );
    currentframe = 0;
    
    while ( currentframe <= totalframes )
    {
        if ( totalframes == 0 )
        {
            break;
        }
        
        fadeval = currentframe / totalframes;
        self setclientomnvar( "ui_world_fade", fadeval );
        currentframe++;
        waitframe();
    }
    
    self.var_fd88460f03feb34a = 1;
    
    if ( holdtime > 0 )
    {
        wait holdtime;
    }
    
    totalframes = int( ceil( fadeuptime / level.framedurationseconds ) );
    currentframe = 0;
    fadeval = 1;
    
    while ( currentframe <= totalframes )
    {
        fadeval = ( totalframes - currentframe ) / totalframes;
        self setclientomnvar( "ui_world_fade", fadeval );
        currentframe++;
        waitframe();
    }
}

// Namespace tac_insert
// Params 0
// Checksum 0x2869c287, Offset: 0x352e
// Size: 0xe0
function tacinsert_createspawncamera()
{
    spawndirection = anglestoup( self.setspawnpoint.angles );
    var_f5c1f3f946c98f8a = getdvarint( @"hash_2ace60ec27da45be", 50 );
    upoffset = getdvarint( @"hash_27a03e1f75a3fdda", 2000 );
    spawncameraorigin = self.setspawnpoint.origin + spawndirection * var_f5c1f3f946c98f8a + ( 0, 0, 1 ) * upoffset;
    spawncameraangles = vectortoangles( self.setspawnpoint.origin - spawncameraorigin );
    cameraent = spawn( "script_model", spawncameraorigin );
    cameraent setmodel( "tag_origin" );
    cameraent.angles = spawncameraangles;
    return cameraent;
}

// Namespace tac_insert
// Params 1
// Checksum 0x23782dd3, Offset: 0x3617
// Size: 0x4a
function function_882181014a63af0d( timeout )
{
    self endon( #"tacinsert_destroyed" );
    self endon( #"force_spawn" );
    self endon( #"use_normal_spawn" );
    wait timeout;
    self.ti_timer = timeout;
    self notify( #"use_ti_spawn" );
}

// Namespace tac_insert
// Params 0
// Checksum 0x904ecf33, Offset: 0x3669
// Size: 0xe2
function tacinsert_monitorexit()
{
    self endon( #"tacinsert_destroyed" );
    self endon( #"force_spawn" );
    self endon( #"use_ti_spawn" );
    timeheld = 0;
    timeelapsed = 0;
    
    while ( self usebuttonpressed() )
    {
        waitframe();
    }
    
    while ( isdefined( self ) )
    {
        timeelapsed += level.framedurationseconds;
        
        if ( self usebuttonpressed() )
        {
            timeheld += level.framedurationseconds;
            self setclientomnvar( "ui_exit_progress", timeheld / 0.45 );
            
            if ( timeheld > 0.45 )
            {
                self notify( #"use_normal_spawn" );
                self.ti_timer = timeelapsed;
                return;
            }
        }
        else if ( timeheld > 0 )
        {
            timeheld -= level.framedurationseconds;
            self setclientomnvar( "ui_exit_progress", timeheld / 0.45 );
            
            if ( timeheld <= 0 )
            {
                timeheld = 0;
            }
        }
        
        waitframe();
    }
}

// Namespace tac_insert
// Params 2
// Checksum 0x689cb670, Offset: 0x3753
// Size: 0x1e1
function function_263b4dec4386010b( origin, angles )
{
    baseangles = angles;
    angstep = 30;
    maxsteps = 360 / angstep;
    stepcount = 0;
    var_e6a0bdc68d45c2f4 = 1;
    cameradistance = getdvarint( @"hash_984d01a22fdb9767", 50 );
    testvec = undefined;
    camerapos = origin;
    cameraangles = angles;
    radius = 2;
    
    while ( stepcount < maxsteps )
    {
        if ( stepcount == 0 )
        {
            testvec = anglestoforward( baseangles );
            stepcount++;
        }
        else
        {
            testvec = anglestoforward( baseangles + ( 0, ( var_e6a0bdc68d45c2f4 ? angstep : angstep * -1 ) * stepcount, 0 ) );
            var_e6a0bdc68d45c2f4 = !var_e6a0bdc68d45c2f4;
            
            if ( var_e6a0bdc68d45c2f4 )
            {
                stepcount++;
            }
        }
        
        tracestart = origin + ( 0, 0, 2 );
        var_9442577a31dd6173 = getdvarfloat( @"hash_9e4c984d178a39ed", 0.75 );
        var_fb47758d5e67cd2e = getdvarfloat( @"hash_6a4a8ac28728f9ec", 0.5 );
        traceend = origin + testvec * cameradistance * var_9442577a31dd6173 + ( 0, 0, cameradistance * var_fb47758d5e67cd2e );
        trace = trace::sphere_trace( tracestart, traceend, radius, [ self.setspawnpoint ], undefined, 1 );
        hitpos = trace[ "position" ];
        
        if ( trace[ "fraction" ] > 0.99 )
        {
            camerapos = hitpos;
            cameraangles = vectortoangles( vectornormalize( origin - camerapos ) );
            break;
        }
    }
    
    cameraent = spawn( "script_model", camerapos );
    cameraent setmodel( "tag_player" );
    cameraent.angles = cameraangles;
    return cameraent;
}

// Namespace tac_insert
// Params 1
// Checksum 0x30df07bd, Offset: 0x393d
// Size: 0x5d
function tacinsert_updatedestroyusability( player )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( self.isdestroyed )
    {
        return;
    }
    
    isenemy = player_utility::playersareenemies( self.owner, player );
    
    if ( isenemy )
    {
        self enableplayeruse( player );
        return;
    }
    
    self disableplayeruse( player );
}

// Namespace tac_insert
// Params 1
// Checksum 0xe114d8fd, Offset: 0x39a2
// Size: 0x45
function tacinsert_empapplied( data )
{
    attacker = data.attacker;
    self notify( #"enemy_destroyed_equipment", attacker );
    tacinsert_givepointsfordeath( attacker, 1 );
    thread tacinsert_destroy( 1 );
}

// Namespace tac_insert
// Params 2
// Checksum 0xc74c69c4, Offset: 0x39ef
// Size: 0x53
function tacinsert_givepointsfordeath( attacker, fromemp )
{
    if ( player_utility::playersareenemies( self.owner, attacker ) )
    {
        attacker thread killstreaks::givescorefordestroyedtacinsert( fromemp );
        self.owner thread dialog::leaderdialogonplayer( "ti_destroyed", undefined, undefined, self.origin );
    }
}

// Namespace tac_insert
// Params 3
// Checksum 0xdcdb7c07, Offset: 0x3a4a
// Size: 0x1d3, Type: bool
function function_9f6372bc2a81e44d( grenade, starttracepos, endtracepos )
{
    validsurface = 1;
    radius = 14;
    ignoreent = [ self, grenade ];
    contentoverride = trace::create_contents( 0, 1, 1, 1, 1, 1, 1, 1, 1 );
    traceresult = trace::sphere_trace( starttracepos, endtracepos, radius, ignoreent, contentoverride, 1 );
    
    if ( isdefined( traceresult ) )
    {
        if ( isdefined( traceresult[ "hittype" ] ) && traceresult[ "hittype" ] != "hittype_none" )
        {
            surfacetype = traceresult[ "surfacetype" ];
            
            if ( isdefined( surfacetype ) && surfacetype != "surftype_none" )
            {
                surfacetype = traceresult[ "surfacetype" ];
                
                if ( surfacetype == "surftype_glass_pane" )
                {
                    validsurface = 0;
                }
            }
            
            ent = traceresult[ "entity" ];
            
            if ( isdefined( ent ) )
            {
                istrain = utility::is_moving_platform_ent( ent );
                
                if ( ent vehicle::is_vehicle() && !istrain )
                {
                    validsurface = 0;
                }
                
                var_ff0e1289702098c3 = getdvarint( @"hash_956f65ae92f862e", 1 );
                
                if ( !var_ff0e1289702098c3 && istrain )
                {
                    validsurface = 0;
                }
                
                if ( getdvarint( @"hash_9b8b6a0216965e80", 1 ) == 1 && self.isinsideelevator )
                {
                    validsurface = 0;
                }
                
                if ( isdefined( ent.classname ) )
                {
                    switch ( ent.classname )
                    {
                        case #"hash_81903cb95a447b8c":
                        case #"hash_e224d0b635d0dadd":
                            validsurface = 0;
                            break;
                        case #"hash_3872eb7d97592cac":
                            if ( isdefined( ent.crate ) )
                            {
                                validsurface = 0;
                            }
                            
                            break;
                    }
                }
            }
        }
    }
    
    return istrue( validsurface );
}

// Namespace tac_insert
// Params 0
// Checksum 0xd40d861a, Offset: 0x3c26
// Size: 0x84
function tacinsert_refund()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    refundtacinsert = getdvarint( @"scr_tac_insert_refund", 1 );
    
    if ( refundtacinsert == 0 )
    {
        return;
    }
    
    if ( level.isgroundwarinfected || game_utility::isinfectedgametype() )
    {
        if ( level.infectedtactical == "equip_tac_insert" )
        {
            equipment_mp::giveequipment( level.infectedtactical, "secondary" );
        }
        
        return;
    }
    
    thread supers_mp::refundsuper();
}

// Namespace tac_insert
// Params 1
// Checksum 0xc32bae9c, Offset: 0x3cb2
// Size: 0x17
function function_a4ebfb83ec0621b9( callbackfunction )
{
    self.elevatordoorsclosecallback = callbackfunction;
}

// Namespace tac_insert
// Params 2, eflags: 0x4
// Checksum 0x7968611d, Offset: 0x3cd1
// Size: 0xdf
function private function_b4190a35039fd46e( tac_insert, player_respawning )
{
    if ( !isdefined( tac_insert.challengedata ) )
    {
        tac_insert.challengedata = {};
    }
    
    if ( !isdefined( tac_insert.challengedata.bitmodifiers ) )
    {
        tac_insert.challengedata.bitmodifiers = [];
    }
    
    tac_insert.challengedata.bitmodifiers = arraycombineunique( tac_insert.challengedata.bitmodifiers, [ #"hash_44e0797641b53240" ] );
    challengeparams = { #fieldupgraderef:"super_tac_insert", #fieldupgradeent:tac_insert, #player_respawning:player_respawning };
    callback::callback( #"field_upgrade_respawn", challengeparams );
}

