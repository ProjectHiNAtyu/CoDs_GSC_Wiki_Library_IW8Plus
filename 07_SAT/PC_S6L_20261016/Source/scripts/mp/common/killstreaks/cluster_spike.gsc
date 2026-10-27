// scripts\mp\common\killstreaks\cluster_spike.gsc  (hash_4312f2cd6172b2a7.gscc) (size: 16014 Bytes / 0x3e8e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc3e279d9 (3286399449)
// size ...... 16014 (0x3e8e)
// includes .. 15  (offset: 0x3ace)
// strings ... 47  (offset: 0x3b46)
// dev strs .. 2   (offset: 0x3e76)
// exports ... 45  (offset: 0x272a)
// cseg ...... 0x2fd + 0x242d (0x272a)
// imports ... 103 (offset: 0x2e32)
// animtree1 . 0   (offset: 0x3e8e)
// animtree2 . 0   (offset: 0x3e8e)
#using script_13865ca76df87ea;
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\elevators;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_mines;
#using scripts\mp\chaff_debuff;
#using scripts\mp\common\equipment\haywire;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\emp_debuff;
#using scripts\mp\entityheadicons;
#using scripts\mp\equipment;

#namespace cluster_spike;

// Namespace cluster_spike
// Params 0
// Checksum 0x912e40c8, Offset: 0x31b
// Size: 0x15d
function init()
{
    if ( utility::issharedfuncdefined( "cluster_spike", #"init" ) )
    {
        [[ utility::getsharedfunc( "cluster_spike", #"init" ) ]]();
    }
    
    /#
        setdevdvarifuninitialized( @"scr_cluster_spike_debug", 0 );
    #/
    
    bundle = level.streakglobals.streakbundles[ "cluster_spike" ];
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    level function_358f2ce31c06783f( bundle );
    level function_32ffcc48794898cd();
    level init_clusterspike_anims();
    level init_clusterspike_vo();
    level init_clusterspike_fx();
    namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "cluster_spike", bundle.deployweapon, #"medium" );
    namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "cluster_spike", bundle.spawnweapon, #"medium" );
    namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "cluster_spike", "cluster_spike_mp_v2063", #"medium" );
    utility::flag_wait( "equipment_initialized" );
    equipment_mp::registercallback( "cluster_spike", "onDestroyedByTrophy", &function_17773136307f4a4d );
    equipment_mp::registercallback( "cluster_spike_proj", "onDestroyedByTrophy", &function_17773136307f4a4d );
    level.var_d3ff65cbeaa3ff69[ #"cluster_spike" ] = &clusterspike_modified_damage;
    level.var_d3ff65cbeaa3ff69[ #"cluster_spike_proj" ] = &clusterspike_modified_damage;
}

// Namespace cluster_spike
// Params 1
// Checksum 0x80aa339e, Offset: 0x480
// Size: 0xdd
function function_358f2ce31c06783f( bundle )
{
    level.clusterspikes = [];
    level.clusterspikenum = 0;
    
    foreach ( teamname in level.teamnamelist )
    {
        level.clusterspikes[ teamname ] = [];
    }
    
    var_bfe1633523542785 = vehicle_mines::get_mine_data( "cluster_spike", 1 );
    var_bfe1633523542785.radius = bundle.var_7a62459e2e930d90;
    var_bfe1633523542785.triggercallback = &function_49522e9705b1b32c;
}

// Namespace cluster_spike
// Params 0
// Checksum 0x7c934305, Offset: 0x565
// Size: 0x60
function function_32ffcc48794898cd()
{
    level.var_c60a8c7918303f1e = "clusterSpike_placement";
    val::group_register( level.var_c60a8c7918303f1e, [ "sprint", "supersprint", "offhand_weapons", "melee", "execution_attack", "weapon_pickup", "supers" ] );
}

// Namespace cluster_spike
// Params 0
// Checksum 0x443de0dd, Offset: 0x5cd
// Size: 0x2
function init_clusterspike_anims()
{
    
}

// Namespace cluster_spike
// Params 0
// Checksum 0x8e27ab4a, Offset: 0x5d7
// Size: 0x2
function init_clusterspike_vo()
{
    
}

// Namespace cluster_spike
// Params 0
// Checksum 0x47363cdc, Offset: 0x5e1
// Size: 0x2
function init_clusterspike_fx()
{
    
}

// Namespace cluster_spike
// Params 2
// Checksum 0x77c00dc8, Offset: 0x5eb
// Size: 0x23
function function_c760f25a170126b9( streakinfo, switchresult )
{
    if ( switchresult )
    {
        thread function_d980717417e0f663( streakinfo );
    }
}

// Namespace cluster_spike
// Params 1
// Checksum 0x344a26b0, Offset: 0x616
// Size: 0x89
function function_d980717417e0f663( streakinfo )
{
    self endon( #"disconnect" );
    self notifyonplayercommand( "cancel_deploy", "+actionslot 3" );
    self notifyonplayercommand( "cancel_deploy", "+actionslot 4" );
    self notifyonplayercommand( "cancel_deploy", "+actionslot 5" );
    self notifyonplayercommand( "cancel_deploy", "+actionslot 6" );
    result = utility::waittill_any_return( "cancel_deploy", "weapon_switch_started" );
    
    if ( !isdefined( result ) )
    {
        return;
    }
    
    streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
}

// Namespace cluster_spike
// Params 1
// Checksum 0xd1527d0c, Offset: 0x6a7
// Size: 0x37
function function_e6af033bcfc32122( streakinfo )
{
    if ( streakinfo.clusterspike_fired )
    {
        level callback::callback( #"killstreak_finish_use", { #streakinfo:streakinfo } );
    }
}

// Namespace cluster_spike
// Params 3
// Checksum 0xc2bbe13b, Offset: 0x6e6
// Size: 0x96
function function_93570b07f65b1349( streakinfo, weaponobj, projectile )
{
    projectile thread clusterspike_startuse( self, streakinfo, weaponobj );
    
    if ( utility::issharedfuncdefined( #"killstreak", #"logkillstreakevent" ) )
    {
        self [[ utility::getsharedfunc( #"killstreak", #"logkillstreakevent" ) ]]( streakinfo.airdroptype, self.origin );
    }
    
    streakinfo.clusterspike_fired = 1;
    streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
    return "success";
}

// Namespace cluster_spike
// Params 0
// Checksum 0xff9f61fd, Offset: 0x785
// Size: 0x22
function tryuseclusterspike()
{
    streakinfo = killstreak_utility::createstreakinfo( "cluster_spike", self );
    return function_86ac47cc74fcc4cf( streakinfo );
}

// Namespace cluster_spike
// Params 1
// Checksum 0xec179aed, Offset: 0x7b0
// Size: 0x200, Type: bool
function function_86ac47cc74fcc4cf( streakinfo )
{
    bundle = level.streakglobals.streakbundles[ "cluster_spike" ];
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    if ( isdefined( level.var_c60a8c7918303f1e ) )
    {
        streakinfo.var_21f1b0b4d8d3ea8f = level.var_c60a8c7918303f1e;
    }
    
    genericblueprintname = namespace_de7b719e85d98dcc::function_9800c005d17e1d42( bundle, streakinfo.mpstreaksysteminfo.blueprintindex );
    deployweapon = namespace_de7b719e85d98dcc::genericblueprint_makeweapon( genericblueprintname, #"deployweapon" );
    deployweapon = makeweapon( bundle.deployweapon );
    
    if ( isdefined( genericblueprintname ) )
    {
        deployweapon = namespace_de7b719e85d98dcc::genericblueprint_makeweapon( genericblueprintname, "deployWeapon" );
    }
    
    deployresult = killstreakdeploy::streakdeploy_doweaponfireddeploy( streakinfo, deployweapon, "grenade_fire", undefined, &function_c760f25a170126b9, &function_93570b07f65b1349, undefined, &function_e6af033bcfc32122 );
    
    if ( !deployresult )
    {
        return false;
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
            return false;
        }
    }
    
    if ( level.gameended )
    {
        streakinfo notify( #"killstreak_finished_with_deploy_weapon" );
        return false;
    }
    
    utility::trycall( level.matchdata_logkillstreakevent, "cluster_spike", self.origin );
    
    if ( utility::issharedfuncdefined( #"hud", #"teamplayercardsplash" ) )
    {
        self thread [[ utility::getsharedfunc( #"hud", #"teamplayercardsplash" ) ]]( "used_" + "cluster_spike", self );
    }
    
    if ( utility::issharedfuncdefined( "cluster_spike", #"munitionused" ) )
    {
        self [[ utility::getsharedfunc( "cluster_spike", #"munitionused" ) ]]();
    }
    
    return true;
}

// Namespace cluster_spike
// Params 3
// Checksum 0x40b72bbf, Offset: 0x9b9
// Size: 0x2f4
function clusterspike_startuse( player, streakinfo, weaponobj )
{
    level endon( #"game_ended" );
    ownedmines = function_bf3986675719aab2( player );
    
    if ( isdefined( ownedmines ) )
    {
        foreach ( mine in ownedmines )
        {
            if ( !isdefined( mine ) )
            {
                /#
                    iprintln( "<dev string:x24>" );
                #/
                
                level.clusterspikes[ self.team ][ "ownerID_" + self getxuid() ] = function_5713d46873b29625( level.clusterspikes[ self.team ][ "ownerID_" + self getxuid() ] );
            }
            
            mine thread clusterspike_explode( "destroy" );
        }
    }
    
    lifetimeOverride = undefined;
    
    if ( utility::issharedfuncdefined( "cluster_spike", #"hash_cf0448c37abfea2e" ) )
    {
        lifetimeOverride = [[ utility::getsharedfunc( "cluster_spike", #"hash_cf0448c37abfea2e" ) ]]();
    }
    
    bundle = level.streakglobals.streakbundles[ "cluster_spike" ];
    function_858284af26469282( self, weaponobj, streakinfo, bundle, player, lifetimeOverride, 1 );
    level endon( "removed_" + self.clusterid );
    self waittill( #"missile_stuck" );
    killstreak_utility::killstreak_dangernotifyplayersinrange( self.owner, self.team, 1200, "cluster_spike", self.origin );
    killstreak_utility::function_e6fc48237c0a5166( #"killstreak_cluster_spike", self.origin, self.team, self.owner );
    
    if ( isdefined( level.var_59abd25eeb5b2fed ) )
    {
        canplant = self [[ level.var_59abd25eeb5b2fed ]]();
        
        if ( !canplant )
        {
            if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
            {
                player [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"killstreaks/blocked_refund_killstreak" );
            }
            
            if ( utility::issharedfuncdefined( #"killstreak", #"awardkillstreakfromstruct" ) )
            {
                player [[ utility::getsharedfunc( #"killstreak", #"awardkillstreakfromstruct" ) ]]( streakinfo.mpstreaksysteminfo, "other" );
            }
            
            thread clusterspike_cleanup( 0 );
            return;
        }
    }
    
    immediaterelease = 1;
    
    /#
        triggertype = self.bundle.var_991a46a658e7ee8d;
        
        if ( triggertype == 0 )
        {
            immediaterelease = 0;
        }
    #/
    
    thread clusterspike_watchgameend();
    thread function_dee10a513e6d571e( immediaterelease, streakinfo );
}

// Namespace cluster_spike
// Params 7
// Checksum 0x3ee8bf48, Offset: 0xcb5
// Size: 0x3d5
function function_858284af26469282( clusterspike, weaponobj, streakinfo, bundle, owner, lifetimeOverride, maindevice )
{
    level.clusterspikenum++;
    clusterspike.bundle = bundle;
    clusterspike.owner = owner;
    clusterspike.team = owner.team;
    clusterspike.ownerid = "ownerID_" + owner getxuid();
    clusterspike.clusterid = clusterspike.ownerid + "_" + level.clusterspikenum;
    clusterspike.maindevice = istrue( maindevice );
    clusterspike.weapon_name = weaponobj.basename;
    clusterspike.killstreakref = "cluster_spike";
    clusterspike.weapon_object = weaponobj;
    clusterspike.health = 99999;
    clusterspike.maxhealth = bundle.maxhealth;
    clusterspike.lifetime = bundle.clusterspikelifetime ?? 120;
    clusterspike.killoneshot = bundle.var_532aabdc8a0d29dc;
    
    if ( utility::issharedfuncdefined( #"cluster_spike", #"attachxrays" ) )
    {
        clusterspike = [[ utility::getsharedfunc( #"cluster_spike", #"attachxrays" ) ]]( clusterspike );
    }
    
    if ( isdefined( lifetimeOverride ) )
    {
        clusterspike.lifetime = lifetimeOverride;
    }
    
    clusterspike.streakinfo = streakinfo;
    clusterspike.damagetaken = 0;
    clusterspike setentityowner( owner );
    clusterspike setotherent( owner );
    clusterspike setcandamage( 1 );
    
    if ( utility::issharedfuncdefined( #"killstreak", #"addtoactivekillstreaklist" ) )
    {
        clusterspike [[ utility::getsharedfunc( #"killstreak", #"addtoactivekillstreaklist" ) ]]( streakinfo.streakname, "Killstreak_Ground", owner );
    }
    
    clusterspike haywire::function_7f69a1eb3d590f76( &clusterspike_haywire );
    clusterspike emp_debuff::set_start_emp_callback( &clusterspike_empstarted );
    
    if ( level.killstreak_emp_initialized )
    {
        clusterspike.ksempapplycallback = &clusterspike_empstarted;
    }
    
    clusterspike emp_debuff::set_clear_emp_callback( &clusterspike_empcleared );
    
    if ( level.killstreak_emp_initialized )
    {
        clusterspike.ksempclearcallback = &clusterspike_empcleared;
    }
    
    clusterspike chaff_debuff::function_4118b0299dc40ea( &function_94ffacdb5cf42c28 );
    clusterspike chaff_debuff::function_324dd42a2703bc25( &function_a2ed0a28fad8e01d );
    clusterspike function_a4ebfb83ec0621b9( &function_ca11609d91b8c0bd );
    
    if ( isdefined( level.elevators ) )
    {
        foreach ( elevators in level.elevators )
        {
            elevators thread elevators::isentitytouchingdoortrigger( clusterspike );
        }
    }
    
    if ( !isdefined( level.clusterspikes[ clusterspike.team ][ clusterspike.ownerid ] ) )
    {
        level.clusterspikes[ clusterspike.team ][ clusterspike.ownerid ] = [];
    }
    
    level.clusterspikes[ clusterspike.team ][ clusterspike.ownerid ][ level.clusterspikes[ clusterspike.team ][ clusterspike.ownerid ].size ] = clusterspike;
    clusterspike thread function_71a28566110410af();
}

// Namespace cluster_spike
// Params 1
// Checksum 0x95809785, Offset: 0x1092
// Size: 0x4d
function clusterspike_empstarted( data )
{
    if ( isdefined( self ) && !self.isexploding || getdvarint( @"hash_58254c61de76bffe", 0 ) )
    {
        self.isdisabled = 1;
        self setscriptablepartstate( "empd", "active", 0 );
    }
}

// Namespace cluster_spike
// Params 1
// Checksum 0x7ad536b7, Offset: 0x10e7
// Size: 0x4c
function clusterspike_empapplied( data )
{
    if ( isdefined( self ) && !self.isexploding || getdvarint( @"hash_58254c61de76bffe", 0 ) )
    {
        data.attacker thread namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"disabled_cluster_spike" );
    }
}

// Namespace cluster_spike
// Params 1
// Checksum 0xc4702bb1, Offset: 0x113b
// Size: 0x3a
function clusterspike_empcleared( data )
{
    if ( isdefined( self ) || !self.isexploding )
    {
        self.isdisabled = undefined;
        self setscriptablepartstate( "empd", "neutral", 0 );
    }
}

// Namespace cluster_spike
// Params 1
// Checksum 0xb51590e6, Offset: 0x117d
// Size: 0x3b
function function_94ffacdb5cf42c28( data )
{
    if ( isdefined( self ) && !self.isexploding )
    {
        self.chaffstunned = 1;
        self setscriptablepartstate( "empd", "active", 0 );
    }
}

// Namespace cluster_spike
// Params 1
// Checksum 0x61d5b71b, Offset: 0x11c0
// Size: 0x3a
function function_a2ed0a28fad8e01d( data )
{
    if ( isdefined( self ) || !self.isexploding )
    {
        self.chaffstunned = undefined;
        self setscriptablepartstate( "empd", "neutral", 0 );
    }
}

// Namespace cluster_spike
// Params 1
// Checksum 0x40e1a492, Offset: 0x1202
// Size: 0x46
function clusterspike_haywire( data )
{
    if ( self.isexploding )
    {
        return 0;
    }
    
    if ( isdefined( data.attacker ) )
    {
        self setentityowner( data.attacker );
    }
    
    thread clusterspike_explode( "explode" );
}

// Namespace cluster_spike
// Params 0
// Checksum 0x919be6c5, Offset: 0x1250
// Size: 0xe
function function_17773136307f4a4d()
{
    thread clusterspike_explode( "destroy" );
}

// Namespace cluster_spike
// Params 1
// Checksum 0xe3477003, Offset: 0x1266
// Size: 0xe2
function clusterspike_explode( explodestate )
{
    if ( self.isexploding )
    {
        return;
    }
    
    if ( isdefined( level.var_d8f10f1cfdbaac7e ) )
    {
        thread [[ level.var_d8f10f1cfdbaac7e ]]( self.streakinfo );
    }
    
    if ( isdefined( level.var_845fe19bc9ff4b8e ) )
    {
        thread [[ level.var_845fe19bc9ff4b8e ]]( self.streakinfo, self.origin, 0 );
    }
    
    self notify( #"explode_cluster_spike" );
    self.isexploding = 1;
    
    if ( isdefined( self.owner ) )
    {
        self setentityowner( self.owner );
    }
    
    self clearscriptabledamageowner();
    self setscriptablepartstate( explodestate, "on", 0 );
    
    if ( isdefined( level.var_fa0d180f4b71bc0e ) )
    {
        thread [[ level.var_fa0d180f4b71bc0e ]]( self.streakinfo );
    }
    
    thread clusterspike_cleanup( 1, self.streakinfo );
}

// Namespace cluster_spike
// Params 2
// Checksum 0x14fb601, Offset: 0x1350
// Size: 0x108
function clusterspike_cleanup( wasdestroyed, streakinfo )
{
    level endon( #"game_ended" );
    self.streakinfo.expiredbydeath = istrue( wasdestroyed );
    
    if ( self.owner )
    {
        if ( !streakinfo.var_c0a2080fc59d32d4 )
        {
            minelist = function_bf3986675719aab2( self.owner );
            
            if ( minelist.size == 1 )
            {
                thread function_20f8d632b9d6f076( 0.3 );
            }
        }
    }
    
    if ( isdefined( self.headiconid ) )
    {
        entityheadicons::setheadicon_deleteicon( self.headiconid );
    }
    
    clusterteam = self.team;
    var_2893818b835e3772 = self.ownerid;
    level.clusterspikes[ clusterteam ][ var_2893818b835e3772 ] = arrayremove( level.clusterspikes[ clusterteam ][ var_2893818b835e3772 ], self );
    level notify( "removed_" + self.clusterid );
    wait 1;
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace cluster_spike
// Params 1
// Checksum 0xd5917ed6, Offset: 0x1460
// Size: 0x48
function function_20f8d632b9d6f076( delay )
{
    level endon( #"game_ended" );
    self.owner endon( #"disconnect" );
    wait delay;
    self.owner killstreak_utility::recordkillstreakendstats( self.streakinfo );
}

// Namespace cluster_spike
// Params 5
// Checksum 0x2a7de0cf, Offset: 0x14b0
// Size: 0x158
function clusterspike_modified_damage( victim, inflictor, objweapon, meansofdeath, damage )
{
    bundle = level.streakglobals.streakbundles[ "cluster_spike" ];
    
    if ( isdefined( inflictor ) && isdefined( inflictor.damageoverwrite ) )
    {
        return inflictor.damageoverwrite;
    }
    
    if ( !isdefined( bundle ) )
    {
        return damage;
    }
    
    if ( bundle.var_61f34c4a25345dcc )
    {
        return damage;
    }
    
    if ( !isdefined( inflictor ) )
    {
        return damage;
    }
    
    if ( meansofdeath != "MOD_EXPLOSIVE" )
    {
        return damage;
    }
    
    if ( !isdefined( objweapon ) )
    {
        return damage;
    }
    
    if ( isnullweapon( objweapon ) )
    {
        return damage;
    }
    
    if ( objweapon.basename != bundle.deployweapon && objweapon.basename != bundle.spawnweapon )
    {
        return damage;
    }
    
    if ( isplayer( victim ) )
    {
        damagethreshold = victim.maxhealth * 0.5;
        currenthealth = victim.health;
        
        if ( currenthealth >= damagethreshold && damage >= damagethreshold )
        {
            if ( damage >= currenthealth )
            {
                damage = victim.maxhealth - 1;
            }
        }
    }
    
    return damage;
}

// Namespace cluster_spike
// Params 1
// Checksum 0x5d634351, Offset: 0x1611
// Size: 0x5e
function function_bf3986675719aab2( owner )
{
    if ( isagent( owner ) )
    {
        return level.clusterspikes[ owner.team ][ "ownerID_" + owner getentitynumber() ];
    }
    
    return level.clusterspikes[ owner.team ][ "ownerID_" + owner getxuid() ];
}

// Namespace cluster_spike
// Params 0
// Checksum 0xd54e95d1, Offset: 0x1677
// Size: 0x8c
function clusterspike_watchgameend()
{
    self endon( #"explode_cluster_spike" );
    level endon( "removed_" + self.clusterid );
    level waittill( #"game_ended" );
    
    if ( self.owner && self.streakinfo )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"killstreak" ][ #"hash_bf17c172d25e8b3d" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self.owner [[ var_32dbca3143d9c4a5 ]]( self.streakinfo );
        }
    }
}

// Namespace cluster_spike
// Params 0
// Checksum 0x21ca1f29, Offset: 0x170b
// Size: 0x65
function clusterspike_watchowner()
{
    self endon( #"explode_cluster_spike" );
    level endon( #"game_ended" );
    level endon( "removed_" + self.clusterid );
    droneowner = self.owner;
    droneowner utility::waittill_any( "disconnect", "joined_team", "joined_spectators" );
    thread clusterspike_explode( "destroy" );
}

// Namespace cluster_spike
// Params 0
// Checksum 0x1e7a1fd4, Offset: 0x1778
// Size: 0x42
function clusterspike_watchlifetime()
{
    self endon( #"explode_cluster_spike" );
    level endon( #"game_ended" );
    level endon( "removed_" + self.clusterid );
    wait self.lifetime;
    thread clusterspike_explode( "explode" );
}

// Namespace cluster_spike
// Params 0
// Checksum 0xa08271ee, Offset: 0x17c2
// Size: 0xd5
function function_71a28566110410af()
{
    self endon( #"explode_cluster_spike" );
    level endon( #"game_ended" );
    clusterteam = self.team;
    var_2893818b835e3772 = self.ownerid;
    clusterid = self.clusterid;
    thread function_d9c98a9d566517c6( clusterid );
    failsafefusetime = self.lifetime + 5;
    result = level utility::waittill_any_timeout( failsafefusetime, "removed_" + clusterid );
    
    if ( !isdefined( self ) )
    {
        level.clusterspikes[ clusterteam ][ var_2893818b835e3772 ] = function_5713d46873b29625( level.clusterspikes[ clusterteam ][ var_2893818b835e3772 ] );
    }
    else
    {
        clusterspike_cleanup( 0, self.streakinfo );
    }
    
    level notify( "removed_" + clusterid );
}

// Namespace cluster_spike
// Params 1
// Checksum 0xeaa92d6c, Offset: 0x189f
// Size: 0x4c
function function_d9c98a9d566517c6( clusterid )
{
    self endon( #"explode_cluster_spike" );
    level endon( #"game_ended" );
    level endon( "removed_" + clusterid );
    
    while ( true )
    {
        if ( !isdefined( self ) )
        {
            break;
        }
        
        waitframe();
    }
    
    level notify( "removed_" + clusterid );
}

// Namespace cluster_spike
// Params 0
// Checksum 0xb26b30f8, Offset: 0x18f3
// Size: 0x41a
function clusterspike_watchdamage()
{
    self endon( #"explode_cluster_spike" );
    level endon( #"game_ended" );
    level endon( "removed_" + self.clusterid );
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, smeansofdeath, modelname, tagname, partname, idflags, objweapon );
        
        if ( isdefined( level.teambased ) && isplayer( attacker ) && attacker.team == self.team && attacker != self.owner )
        {
            continue;
        }
        
        self.wasdamaged = 1;
        modifieddamage = damage;
        
        if ( utility::issharedfuncdefined( #"killstreak", #"getmodifiedantikillstreakdamage" ) )
        {
            modifieddamage = self [[ utility::getsharedfunc( #"killstreak", #"getmodifiedantikillstreakdamage" ) ]]( attacker, objweapon, smeansofdeath, damage, self.maxhealth, 1, 1, 1, 1, 1 );
        }
        
        if ( isplayer( attacker ) )
        {
            if ( utility::issharedfuncdefined( #"damage", #"updatedamagefeedback" ) )
            {
                attacker [[ utility::getsharedfunc( #"damage", #"updatedamagefeedback" ) ]]( "hitequip" );
            }
        }
        
        data = { #objweapon:objweapon, #idflags:idflags, #partname:partname, #tagname:tagname, #modelname:modelname, #meansofdeath:smeansofdeath, #point:point, #direction_vec:direction_vec, #attacker:attacker, #damage:damage, #victim:self };
        
        if ( utility::issharedfuncdefined( #"killstreak", #"killstreakhit" ) )
        {
            [[ utility::getsharedfunc( #"killstreak", #"killstreakhit" ) ]]( attacker, objweapon, self, smeansofdeath, modifieddamage, data );
        }
        
        if ( isplayer( attacker.owner ) )
        {
            if ( utility::issharedfuncdefined( #"damage", #"updatedamagefeedback" ) )
            {
                attacker.owner [[ utility::getsharedfunc( #"damage", #"updatedamagefeedback" ) ]]( "hitequip" );
            }
        }
        
        self.damagetaken += modifieddamage;
        self.currenthealth = self.maxhealth - self.damagetaken;
        
        if ( self.currenthealth <= 0 )
        {
            if ( isdefined( objweapon ) && ( objweapon.basename == self.bundle.deployweapon || objweapon.basename == self.bundle.spawnweapon ) )
            {
                minelist = function_bf3986675719aab2( self.owner );
                var_9d56eae153da0d27 = 0.25;
                
                foreach ( mine in minelist )
                {
                    if ( !isdefined( mine ) )
                    {
                        continue;
                    }
                    
                    if ( mine == self )
                    {
                        continue;
                    }
                    
                    if ( mine.var_210b176be847de29 )
                    {
                        var_9d56eae153da0d27 += randomfloatrange( 0.25, 0.35 );
                    }
                }
                
                self.var_210b176be847de29 = 1;
                wait var_9d56eae153da0d27;
            }
            
            thread clusterspike_explode( "explode" );
        }
    }
}

// Namespace cluster_spike
// Params 1
// Checksum 0xe2185dea, Offset: 0x1d15
// Size: 0x26a
function clusterspike_watchtrigger( var_9aea7808a40caae0 )
{
    self endon( #"explode_cluster_spike" );
    level endon( #"game_ended" );
    level endon( "removed_" + self.clusterid );
    armstate = "on";
    
    if ( self.maindevice )
    {
        armstate = "on_main";
    }
    
    self setscriptablepartstate( "arm", armstate, 0 );
    self.headiconid = entityheadicons::setheadicon_killstreak( self );
    
    /#
        thread function_a503ace695326bd3();
    #/
    
    thread clusterspike_watchowner();
    thread clusterspike_watchlifetime();
    thread clusterspike_watchdamage();
    var_23a82edf24269a34 = isdefined( level.gametypebundle ) && level.gametypebundle.var_23a82edf24269a34;
    
    while ( true )
    {
        self waittill( #"trigger_grenade", entarr );
        
        if ( self.isdisabled || self.chaffstunned )
        {
            continue;
        }
        
        self setscriptablepartstate( "trigger", "on", 0 );
        
        if ( !var_9aea7808a40caae0 )
        {
            wait 0.35;
        }
        
        foreach ( ent in entarr )
        {
            if ( !( isdefined( ent ) && isdefined( ent.classname ) ) )
            {
                continue;
            }
            
            if ( ent.classname == "script_vehicle" )
            {
                if ( ent vehicle_mines::function_56d954c642e8acea( self ) )
                {
                    continue;
                }
                
                if ( !vehicle_mines::function_60d53a1a3bd504cd( ent, self ) )
                {
                    continue;
                }
                
                vehicle_mines::trigger_mine( ent, self );
                break;
            }
            
            if ( isagent( ent ) || isplayer( ent ) )
            {
                if ( isdefined( ent.vehicle ) )
                {
                    continue;
                }
                
                if ( !ent player::isreallyalive() )
                {
                    continue;
                }
                
                if ( ent.var_358a13b001e2d054 && isdefined( ent.minedelayseconds ) && ent.minedelayseconds > 0 )
                {
                    wait ent.minedelayseconds;
                }
                
                if ( var_23a82edf24269a34 && ent.spawnprotection )
                {
                    continue;
                }
                
                function_429825a094ccbcbe();
                break;
            }
        }
    }
}

// Namespace cluster_spike
// Params 2
// Checksum 0xaab17526, Offset: 0x1f87
// Size: 0x187
function function_bcc874e4adbb2827( immediaterelease, streakinfo )
{
    clusterowner = self.owner;
    clusterowner endon( #"disconnect" );
    self endon( #"hash_426eb21e20192bf4" );
    level endon( #"game_ended" );
    bundle = level.streakglobals.streakbundles[ "cluster_spike" ];
    
    while ( true )
    {
        clusterowner waittill( #"grenade_fire", grenade, objweapon, tickpercent, originalowner );
        
        if ( !isdefined( objweapon ) || objweapon.basename != self.bundle.spawnweapon )
        {
            continue;
        }
        
        lifetimeOverride = undefined;
        
        if ( !immediaterelease )
        {
            lifetimeOverride = self.bundle.var_6cd6c26f1101988;
        }
        
        genericblueprintname = namespace_de7b719e85d98dcc::function_9800c005d17e1d42( bundle, streakinfo.mpstreaksysteminfo.blueprintindex );
        spawnweapon = makeweapon( bundle.spawnweapon );
        
        if ( isdefined( genericblueprintname ) )
        {
            spawnweapon = namespace_de7b719e85d98dcc::genericblueprint_makeweapon( genericblueprintname, #"spawnweapon" );
        }
        
        function_858284af26469282( grenade, spawnweapon, self.streakinfo, bundle, self.owner, lifetimeOverride );
        grenade thread function_111d837fa49c2b55( immediaterelease, bundle );
    }
}

// Namespace cluster_spike
// Params 2
// Checksum 0x429893a7, Offset: 0x2116
// Size: 0x83
function function_111d837fa49c2b55( var_ee2705cf42aea51d, bundle )
{
    self endon( #"explode_cluster_spike" );
    level endon( #"game_ended" );
    level endon( "removed_" + self.clusterid );
    
    if ( var_ee2705cf42aea51d )
    {
        self waittill( #"missile_stuck" );
    }
    
    killstreak_utility::function_e6fc48237c0a5166( #"killstreak_cluster_spike", self.origin, self.team, self.owner );
    thread clusterspike_watchtrigger();
}

// Namespace cluster_spike
// Params 2
// Checksum 0x54d1384, Offset: 0x21a1
// Size: 0x76
function function_dee10a513e6d571e( immediaterelease, streakinfo )
{
    self endon( #"explode_cluster_spike" );
    level endon( #"game_ended" );
    level endon( "removed_" + self.clusterid );
    thread function_7bb2006002494a4e( immediaterelease, streakinfo );
    var_9aea7808a40caae0 = 0;
    
    if ( !immediaterelease )
    {
        var_9aea7808a40caae0 = 1;
    }
    
    self waittill( #"hash_426eb21e20192bf4" );
    thread clusterspike_watchtrigger( var_9aea7808a40caae0 );
}

// Namespace cluster_spike
// Params 2
// Checksum 0x95e93b14, Offset: 0x221f
// Size: 0x212
function function_7bb2006002494a4e( immediaterelease, streakinfo )
{
    self endon( #"explode_cluster_spike" );
    level endon( #"game_ended" );
    level endon( "removed_" + self.clusterid );
    fusetime = self.lifetime + 30;
    
    if ( !immediaterelease )
    {
        self waittill( #"hash_61d15e1e5982fbc1" );
    }
    else
    {
        wait 0.75;
    }
    
    self setscriptablepartstate( "release", "on", 0 );
    thread function_bcc874e4adbb2827( immediaterelease, streakinfo );
    
    for ( i = 0; i < self.bundle.var_4f7c15ead84244a6 ; i++ )
    {
        discnum = "0" + i + 1;
        mineorigin = self gettagorigin( "j_disc_" + discnum );
        launchdir = vectornormalize( mineorigin - self.origin );
        launchstart = mineorigin + launchdir * 2;
        launchgoal = mineorigin + anglestoup( self.angles ) * 200 + launchdir * 300;
        launchvelocity = launchgoal - mineorigin;
        
        if ( isdefined( self ) && isdefined( self.owner ) )
        {
            genericblueprintname = namespace_de7b719e85d98dcc::function_9800c005d17e1d42( self.bundle, streakinfo.mpstreaksysteminfo.blueprintindex );
            spawnweapon = makeweapon( self.bundle.spawnweapon );
            
            if ( isdefined( genericblueprintname ) )
            {
                spawnweapon = namespace_de7b719e85d98dcc::genericblueprint_makeweapon( genericblueprintname, #"spawnweapon" );
            }
            
            if ( utility::issharedfuncdefined( #"weapons", #"_launchgrenade" ) )
            {
                self.owner [[ utility::getsharedfunc( #"weapons", #"_launchgrenade" ) ]]( spawnweapon, launchstart, launchvelocity, fusetime );
            }
        }
        
        wait 0.05;
    }
    
    self notify( #"hash_426eb21e20192bf4" );
}

// Namespace cluster_spike
// Params 0
// Checksum 0xe0ef2328, Offset: 0x2439
// Size: 0xe
function function_429825a094ccbcbe()
{
    thread clusterspike_explode( "explode" );
}

// Namespace cluster_spike
// Params 2
// Checksum 0x900326af, Offset: 0x244f
// Size: 0x93
function function_49522e9705b1b32c( vehicle, mine )
{
    mine endon( #"mine_destroyed" );
    mine endon( #"death" );
    mine.owner endon( #"disconnect" );
    mine notify( #"explode_cluster_spike" );
    self.isexploding = 1;
    self setentityowner( self.owner );
    self clearscriptabledamageowner();
    self setscriptablepartstate( "explode", "on", 0 );
    wait 0.2;
    mine thread function_994222805788f27e( vehicle );
}

// Namespace cluster_spike
// Params 1
// Checksum 0xe63bf053, Offset: 0x24ea
// Size: 0x122
function function_994222805788f27e( vehicle )
{
    self setentityowner( self.owner );
    self clearscriptabledamageowner();
    self setscriptablepartstate( "explode", "off", 0 );
    thread clusterspike_cleanup( 1 );
    
    if ( !isdefined( vehicle ) )
    {
        return;
    }
    
    vehicle dodamage( self.bundle.clusterspikevehicledamage, self.origin, self.owner, self, "MOD_EXPLOSIVE", self.weapon_object );
    ignoredamageid = undefined;
    
    if ( utility::issharedfuncdefined( #"game", #"non_player_add_ignore_damage_signature" ) )
    {
        ignoredamageid = vehicle [[ utility::getsharedfunc( #"game", #"non_player_add_ignore_damage_signature" ) ]]( self.owner, self.weapon_object, self, "MOD_EXPLOSIVE" );
    }
    
    waitframe();
    
    if ( utility::issharedfuncdefined( #"game", #"non_player_remove_ignore_damage_signature" ) )
    {
        if ( isdefined( vehicle ) && isdefined( ignoredamageid ) )
        {
            vehicle [[ utility::getsharedfunc( #"game", #"non_player_remove_ignore_damage_signature" ) ]]( ignoredamageid );
        }
    }
}

// Namespace cluster_spike
// Params 1
// Checksum 0xc50f811f, Offset: 0x2614
// Size: 0x51, Type: bool
function function_3d02e6de6e66d2a3( weaponref )
{
    bundle = level.streakglobals.streakbundles[ "cluster_spike" ];
    return weaponref == bundle.deployweapon || weaponref == bundle.spawnweapon;
}

// Namespace cluster_spike
// Params 0
// Checksum 0xb31e3aa4, Offset: 0x266e
// Size: 0xe
function function_ca11609d91b8c0bd()
{
    thread clusterspike_explode( "destroy" );
}

// Namespace cluster_spike
// Params 1
// Checksum 0xe60a06af, Offset: 0x2684
// Size: 0x17
function function_a4ebfb83ec0621b9( callbackfunction )
{
    self.elevatordoorsclosecallback = callbackfunction;
}

/#

    // Namespace cluster_spike
    // Params 0
    // Checksum 0x41ed546b, Offset: 0x26a3
    // Size: 0x87, Type: dev
    function function_a503ace695326bd3()
    {
        self endon( #"explode_cluster_spike" );
        level endon( #"game_ended" );
        level endon( "<dev string:x99>" + self.clusterid );
        
        while ( true )
        {
            triggerdebug = getdvarint( @"scr_cluster_spike_debug", 0 );
            
            if ( !triggerdebug )
            {
                waitframe();
                continue;
            }
            
            break;
        }
        
        setdvar( @"scr_cluster_spike_debug", 0 );
        self notify( #"trigger_grenade", [ self.owner ] );
    }

#/
