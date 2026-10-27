// scripts\mp\common\equipment\deployed_decoy.gsc  (hash_1cf2a92073e2d06a.gscc) (size: 41008 Bytes / 0xa030 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbe6ddd78 (3194871160)
// size ...... 41008 (0xa030)
// includes .. 31  (offset: 0x9664)
// strings ... 101 (offset: 0x975c)
// dev strs .. 11  (offset: 0x9e54)
// exports ... 99  (offset: 0x63c0)
// cseg ...... 0x88b + 0x5b35 (0x63c0)
// imports ... 281 (offset: 0x7338)
// animtree1 . 0   (offset: 0x9eec)
// animtree2 . 20  (offset: 0x9eec)
#using scripts\common\ai\stealth\manager;
#using scripts\common\callbacks;
#using scripts\common\elevators;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_mines;
#using scripts\common\weapon;
#using scripts\mp\challenges;
#using scripts\mp\common\equipment\haywire;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\print;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\damage;
#using scripts\mp\damagefeedback;
#using scripts\mp\emp_debuff;
#using scripts\mp\ent_manager;
#using scripts\mp\entityheadicons;
#using scripts\mp\equipment;
#using scripts\mp\hud_message;
#using scripts\mp\movers;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\spawnlogic;
#using scripts\mp\supers;
#using scripts\mp\weapons;

#namespace deployed_decoy;

// Namespace deployed_decoy
// Params 0, eflags: 0x1
// Checksum 0x93b15eea, Offset: 0x8a9
// Size: 0x17f
function autoexec deployeddecoy_init()
{
    utility::flag_wait( "supers_initialized" );
    
    if ( game[ "isLaunchChunk" ] )
    {
        return;
    }
    
    supers_mp::function_48aaa60b2ce7b8a1( "super_deployed_decoy", undefined, &deployeddecoy_unset, undefined, undefined, undefined, undefined, &function_f35109b3a0bcad2, undefined, undefined );
    level.deployeddecoys = [];
    minetriggerdata = vehicle_mines::get_mine_data( "equip_deployed_decoy", 1 );
    minetriggerdata.triggercallback = &deployeddecoy_trigger;
    
    if ( isdefined( level.superglobals.staticsuperdata[ "super_deployed_decoy" ] ) )
    {
        level.superglobals.staticsuperdata[ "super_deployed_decoy" ].var_1836be75d110dd2f = &function_13a1c1687c6e3e4d;
    }
    
    weapons::registerusedcallback( "deployed_decoy", &deployeddecoy_use );
    equipment_mp::registercallback( "equip_deployed_decoy", "onDestroyedByTrophy", &function_e18b1ccf5a93a97c );
    utility::registersharedfunc( #"deployed_decoy", #"hash_e3efe28a08433358", &function_4076e3ec808a995d );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"train" ][ #"hash_2edafff898b3de81" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        level [[ var_32dbca3143d9c4a5 ]]( #"deployed_decoy", &function_53115de24fa0db2b );
    }
    
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_deployed_decoy" );
    
    if ( isdefined( bundle ) && isdefined( bundle.var_75e3906de82ba0ce ) )
    {
        level._effect[ "inflatable_decoy_gunfire_vfx" ] = loadfxasset( bundle.var_75e3906de82ba0ce );
    }
}

// Namespace deployed_decoy
// Params 0
// Checksum 0xcce9beb, Offset: 0xa30
// Size: 0x44
function deployeddecoy_unset()
{
    self notify( #"deployeddecoy_unset" );
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_deployed_decoy" );
    
    if ( bundle.var_d8bcc6aaa9b5a2e7 )
    {
        cleanupdecoys();
        return;
    }
    
    thread function_33c1597d9305b7de();
}

// Namespace deployed_decoy
// Params 0
// Checksum 0x3e897180, Offset: 0xa7c
// Size: 0x3a
function function_33c1597d9305b7de()
{
    self notify( #"hash_576bb81fcc93d932" );
    self endon( #"hash_576bb81fcc93d932" );
    level endon( #"game_ended" );
    self waittill( #"death_or_disconnect" );
    cleanupdecoys();
}

// Namespace deployed_decoy
// Params 0
// Checksum 0x9b7ef2b, Offset: 0xabe
// Size: 0x8f
function cleanupdecoys()
{
    if ( isdefined( self.var_70e47e4d766ba906 ) )
    {
        foreach ( decoymine in self.var_70e47e4d766ba906 )
        {
            decoymine thread function_53115de24fa0db2b();
        }
    }
    
    function_b4d249e6ad766adf();
}

// Namespace deployed_decoy
// Params 1
// Checksum 0x93fba751, Offset: 0xb55
// Size: 0x53
function function_10bd38a2edd1f141( ison )
{
    if ( ison )
    {
        var_e7770fb59a77ff16 = level.superglobals.var_da0d0ae8681f98ba[ "super_deployed_decoy" ];
        supers_mp::function_2ea603a86a682ab0( var_e7770fb59a77ff16 );
        thread function_9e234213e916488d();
        return;
    }
    
    supers_mp::function_2ea603a86a682ab0( 0, 1 );
}

// Namespace deployed_decoy
// Params 0
// Checksum 0xb0bb4808, Offset: 0xbb0
// Size: 0x61
function function_9e234213e916488d()
{
    if ( !isdefined( level.gametypebundle ) || !level.gametypebundle.var_a817308d8d92ff8c )
    {
        return;
    }
    
    self notify( #"decoy_monitor_death" );
    level endon( #"game_ended" );
    self endon( #"decoy_monitor_death" );
    self waittill( #"death" );
    function_b4d249e6ad766adf();
}

// Namespace deployed_decoy
// Params 0
// Checksum 0x398cfc15, Offset: 0xc19
// Size: 0x2c
function function_d7b2834cdaeb2d49()
{
    self notify( #"hash_95802223e8577e" );
    
    if ( isplayer( self ) )
    {
        self setclientomnvar( "ui_deployed_decoy_use", 1 );
        function_10bd38a2edd1f141( 1 );
    }
}

// Namespace deployed_decoy
// Params 0
// Checksum 0x945711c6, Offset: 0xc4d
// Size: 0x41
function function_65dac109d812ae48()
{
    self endon( #"disconnect" );
    self endon( #"hash_95802223e8577e" );
    level endon( #"game_ended" );
    self setclientomnvar( "ui_deployed_decoy_use", 2 );
    wait 2;
    function_10bd38a2edd1f141( 0 );
}

// Namespace deployed_decoy
// Params 0
// Checksum 0x4dca13b6, Offset: 0xc96
// Size: 0x16
function function_b4d249e6ad766adf()
{
    self setclientomnvar( "ui_deployed_decoy_use", 0 );
    function_10bd38a2edd1f141( 0 );
}

// Namespace deployed_decoy
// Params 0
// Checksum 0x401ebf9e, Offset: 0xcb4
// Size: 0x1e
function function_f33bbedf99322db9()
{
    thread damage::monitordamage( 225, "hitequip", &deployeddecoy_handlefataldamage, &deployeddecoy_handledamage, undefined, undefined, undefined, 0 );
}

// Namespace deployed_decoy
// Params 1
// Checksum 0x571bf1a7, Offset: 0xcda
// Size: 0x61
function deployeddecoy_handlefataldamage( data )
{
    attacker = data.attacker;
    
    if ( !isdefined( self.owner ) || player_utility::playersareenemies( self.owner, attacker ) )
    {
        attacker thread points::doscoreevent( #"destroyed_equipment" );
    }
    
    function_bd50396f5fbbb90b( 1 );
}

// Namespace deployed_decoy
// Params 1
// Checksum 0x97028cfa, Offset: 0xd43
// Size: 0x169
function deployeddecoy_handledamage( data )
{
    outdamage = 0;
    
    if ( isdefined( data.objweapon.basename ) )
    {
        if ( data.objweapon.basename == "deployed_decoy_mp" )
        {
            return outdamage;
        }
    }
    
    if ( !isdefined( self ) )
    {
        return outdamage;
    }
    
    selforigin = self.origin;
    selfteam = self.team;
    selfowner = self.owner;
    selfmaxhealth = self.maxhealth;
    hits = function_f5f0d6fef0030bf7( data );
    
    if ( isdefined( hits ) )
    {
        if ( isdefined( selforigin ) && isdefined( selfteam ) && isdefined( selfowner ) )
        {
            pinglocationenemyteams( selforigin, selfteam, selfowner );
        }
        
        thread function_c1491d658bb5eed9( data );
        outdamage = int( ceil( min( 1, hits / 10 ) * selfmaxhealth ) );
    }
    
    if ( isdefined( data.attacker ) && !function_f36cd04374a236ab( data ) )
    {
        data.attacker damagefeedback::updatedamagefeedback( "hitequip", 0, 0, "hitequip", 0, 1 );
    }
    
    thread deployeddecoy_animatehitreact( data );
    
    if ( !self.var_e9d14961f76c271f )
    {
        self.shouldfireweapon = 1;
    }
    
    /#
        if ( false )
        {
            outdamage = 0;
        }
        
        return outdamage;
    #/
    
    return outdamage;
}

// Namespace deployed_decoy
// Params 1, eflags: 0x4
// Checksum 0xfdef7ad4, Offset: 0xeb5
// Size: 0xfd
function private deployeddecoy_animatehitreact( data )
{
    self endon( #"death" );
    self notify( #"deployeddecoy_animatehitreact" );
    self endon( #"deployeddecoy_animatehitreact" );
    self endon( #"hash_e97608ed49f91ac9" );
    
    if ( self.var_db9d0a769662b075 )
    {
        return 0;
    }
    
    switchstring = function_f45e9e8232f9c882( data );
    
    if ( isdefined( switchstring ) )
    {
        self setscriptablepartstate( "hitreact", "neutral", 0 );
        waitframe();
        
        switch ( switchstring )
        {
            case #"hash_d64fcbeaa252845e":
                thread function_7cedd10f6329cec();
                break;
            case #"hash_68a4a9ece8b99b1e":
                thread function_6caa429edd3aee14();
                break;
            case #"hash_c3e0c50d649e2385":
                thread function_5d6abee090dd199f();
                break;
            case #"hash_db4f1eafb9d628c1":
                thread function_88e2976f73238333();
                break;
            default:
                break;
        }
    }
    else
    {
        /#
            function_b9d70e3ac08301df( data );
        #/
    }
    
    thread function_a236ad9f27b8ec0a();
}

// Namespace deployed_decoy
// Params 1, eflags: 0x4
// Checksum 0x998f9601, Offset: 0xfba
// Size: 0xb7
function private function_f45e9e8232f9c882( data )
{
    forward = anglestoforward( self.angles );
    right = anglestoright( self.angles );
    direction = data.direction_vec;
    var_e5927bb78d23545b = vectordot( forward, direction );
    var_7deb2b861fc85a2 = vectordot( right, direction );
    
    if ( var_e5927bb78d23545b <= -0.705 )
    {
        return "frontToBack";
    }
    
    if ( var_e5927bb78d23545b >= 0.705 )
    {
        return "backToFront";
    }
    
    if ( var_7deb2b861fc85a2 >= 0.705 )
    {
        return "leftToRight";
    }
    
    if ( var_7deb2b861fc85a2 <= -0.705 )
    {
        return "rightToLeft";
    }
}

#using_animtree( "scriptables" );

// Namespace deployed_decoy
// Params 0, eflags: 0x4
// Checksum 0x5ea381d9, Offset: 0x1079
// Size: 0xe4
function private function_7cedd10f6329cec()
{
    self endon( #"deployeddecoy_animatehitreact" );
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    level endon( #"game_ended" );
    
    switch ( self.var_e4af09100d6247e0 )
    {
        case #"hash_e2fb276aea336c4c":
            self setscriptablepartstate( "hitreact", "iw9_mp_decoymine_hitreac_front", 0 );
            wait getanimlength( %iw9_mp_decoymine_hitreac_front );
            break;
        case #"hash_cb01a8c73dfd3d8e":
            self setscriptablepartstate( "hitreact", "iw9_mp_decoymine_crouch_hitreac_front", 0 );
            wait getanimlength( %iw9_mp_decoymine_crouch_hitreac_front );
            break;
        case #"hash_db29f8f85388749":
            self setscriptablepartstate( "hitreact", "iw9_mp_decoymine_swim_hitreac_front", 0 );
            wait getanimlength( %iw9_mp_decoymine_swim_hitreac_front );
            break;
        default:
            break;
    }
}

// Namespace deployed_decoy
// Params 0, eflags: 0x4
// Checksum 0x4b7a3ce, Offset: 0x1165
// Size: 0xe4
function private function_6caa429edd3aee14()
{
    self endon( #"deployeddecoy_animatehitreact" );
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    level endon( #"game_ended" );
    
    switch ( self.var_e4af09100d6247e0 )
    {
        case #"hash_e2fb276aea336c4c":
            self setscriptablepartstate( "hitreact", "iw9_mp_decoymine_hitreac_back", 0 );
            wait getanimlength( %iw9_mp_decoymine_hitreac_back );
            break;
        case #"hash_cb01a8c73dfd3d8e":
            self setscriptablepartstate( "hitreact", "iw9_mp_decoymine_crouch_hitreac_back", 0 );
            wait getanimlength( %iw9_mp_decoymine_crouch_hitreac_back );
            break;
        case #"hash_db29f8f85388749":
            self setscriptablepartstate( "hitreact", "iw9_mp_decoymine_swim_hitreac_back", 0 );
            wait getanimlength( %iw9_mp_decoymine_swim_hitreac_back );
            break;
        default:
            break;
    }
}

// Namespace deployed_decoy
// Params 0, eflags: 0x4
// Checksum 0xe51ec4ee, Offset: 0x1251
// Size: 0xe4
function private function_5d6abee090dd199f()
{
    self endon( #"deployeddecoy_animatehitreact" );
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    level endon( #"game_ended" );
    
    switch ( self.var_e4af09100d6247e0 )
    {
        case #"hash_e2fb276aea336c4c":
            self setscriptablepartstate( "hitreact", "iw9_mp_decoymine_hitreac_right", 0 );
            wait getanimlength( %iw9_mp_decoymine_hitreac_right );
            break;
        case #"hash_cb01a8c73dfd3d8e":
            self setscriptablepartstate( "hitreact", "iw9_mp_decoymine_crouch_hitreac_right", 0 );
            wait getanimlength( %iw9_mp_decoymine_crouch_hitreac_right );
            break;
        case #"hash_db29f8f85388749":
            self setscriptablepartstate( "hitreact", "iw9_mp_decoymine_swim_hitreac_right", 0 );
            wait getanimlength( %iw9_mp_decoymine_crouch_hitreac_right );
            break;
        default:
            break;
    }
}

// Namespace deployed_decoy
// Params 0, eflags: 0x4
// Checksum 0xb9e8c3ca, Offset: 0x133d
// Size: 0xe4
function private function_88e2976f73238333()
{
    self endon( #"deployeddecoy_animatehitreact" );
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    level endon( #"game_ended" );
    
    switch ( self.var_e4af09100d6247e0 )
    {
        case #"hash_e2fb276aea336c4c":
            self setscriptablepartstate( "hitreact", "iw9_mp_decoymine_hitreac_left", 0 );
            wait getanimlength( %iw9_mp_decoymine_hitreac_left );
            break;
        case #"hash_cb01a8c73dfd3d8e":
            self setscriptablepartstate( "hitreact", "iw9_mp_decoymine_crouch_hitreac_left", 0 );
            wait getanimlength( %iw9_mp_decoymine_crouch_hitreac_left );
            break;
        case #"hash_db29f8f85388749":
            self setscriptablepartstate( "hitreact", "iw9_mp_decoymine_swim_hitreac_left", 0 );
            wait getanimlength( %iw9_mp_decoymine_swim_hitreac_left );
            break;
        default:
            break;
    }
}

// Namespace deployed_decoy
// Params 0, eflags: 0x4
// Checksum 0x198f13b6, Offset: 0x1429
// Size: 0xf1
function private function_a236ad9f27b8ec0a()
{
    self endon( #"deployeddecoy_animatehitreact" );
    self endon( #"hash_456a339ed55706ea" );
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    level endon( #"game_ended" );
    wait 2;
    
    if ( !isdefined( self ) )
    {
        return 0;
    }
    
    if ( self.var_db9d0a769662b075 )
    {
        return 0;
    }
    
    self setscriptablepartstate( "idle", "neutral", 0 );
    waitframe();
    
    switch ( self.var_e4af09100d6247e0 )
    {
        case #"hash_e2fb276aea336c4c":
            self setscriptablepartstate( "idle", "iw9_mp_decoymine_idle", 0 );
            break;
        case #"hash_cb01a8c73dfd3d8e":
            self setscriptablepartstate( "idle", "iw9_mp_decoymine_crouch_idle", 0 );
            break;
        case #"hash_db29f8f85388749":
            self setscriptablepartstate( "idle", "iw9_mp_decoymine_swim_idle", 0 );
            break;
        default:
            break;
    }
}

// Namespace deployed_decoy
// Params 1
// Checksum 0x52ad9599, Offset: 0x1522
// Size: 0x5a, Type: bool
function function_f36cd04374a236ab( data )
{
    /#
        if ( false )
        {
            return false;
        }
    #/
    
    if ( !isdefined( self.owner ) )
    {
        return false;
    }
    
    if ( self.owner == data.attacker )
    {
        return false;
    }
    
    return !player_utility::playersareenemies( self.owner, data.attacker );
}

// Namespace deployed_decoy
// Params 1
// Checksum 0x5a04031b, Offset: 0x1585
// Size: 0xe5
function function_f5f0d6fef0030bf7( data )
{
    instantkillmods = [ "MOD_GRENADE_SPLASH", "MOD_GRENADE", "MOD_EXPLOSIVE" ];
    
    if ( isdefined( data.inflictor ) && data.inflictor.classname == "script_vehicle" )
    {
        return 10;
    }
    
    if ( function_f36cd04374a236ab( data ) )
    {
        return 0;
    }
    
    if ( arraycontains( instantkillmods, data.meansofdeath ) )
    {
        return 10;
    }
    
    if ( data.meansofdeath == "MOD_IMPACT" )
    {
        return 2;
    }
    
    hits = 0;
    
    if ( data.damage >= 100 )
    {
        return ( hits + 9 );
    }
    
    if ( data.damage >= 40 )
    {
        return ( hits + 4 );
    }
    
    return hits + 2;
}

// Namespace deployed_decoy
// Params 1
// Checksum 0x5a6cd762, Offset: 0x1672
// Size: 0x27c
function deployeddecoy_use( grenade )
{
    grenade endon( #"death" );
    grenade.usedtimestamp = gettime();
    self.var_70e47e4d766ba906[ grenade.usedtimestamp ] = grenade;
    
    if ( self.var_70e47e4d766ba906.size > 2 )
    {
        var_eb011ec33f10f756 = utility::array_get_first_item( self.var_70e47e4d766ba906 );
        
        if ( isdefined( var_eb011ec33f10f756 ) )
        {
            var_eb011ec33f10f756 thread function_53115de24fa0db2b();
        }
    }
    
    if ( isdefined( self.var_9c3fb91381350906 ) )
    {
        if ( self.var_9c3fb91381350906.size > 1 )
        {
            var_127e43f6d8fb64ed = utility::array_get_first_item( self.var_9c3fb91381350906 );
            var_127e43f6d8fb64ed thread function_bd50396f5fbbb90b();
        }
    }
    
    grenade.cachedangles = grenade.owner.angles;
    grenade.triggering = 0;
    grenade.issuper = 1;
    thread weapons::monitordisownedgrenade( self, grenade );
    grenade.ownerwasunderwater = grenade.owner isswimunderwater();
    grenade thread function_2e433491b56dd3d();
    grenade waittill( #"missile_stuck", stuckto );
    
    if ( isdefined( level.var_59abd25eeb5b2fed ) )
    {
        canplant = grenade [[ level.var_59abd25eeb5b2fed ]]();
        
        if ( !canplant )
        {
            supers_mp::refundsuper();
            hud_message::showerrormessage( %"equipment/plant_failed" );
            grenade delete();
            return;
        }
    }
    
    if ( isdefined( stuckto ) )
    {
        grenade.var_dd23c93356a9224d = stuckto;
    }
    
    grenade.angles = grenade.cachedangles;
    grenade.cachedangles = undefined;
    
    if ( isdefined( grenade.var_dd23c93356a9224d ) && !killstreak_utility::function_947e7b15331fd6e3( grenade.var_dd23c93356a9224d ) )
    {
        grenade function_db0e187be003ad72();
    }
    
    if ( isplayer( self ) )
    {
        self setclientomnvar( "ui_block_fu_not_ready_error", 1 );
    }
    
    grenade thread deployeddecoy_arm();
    challenges::function_4fd386d590e901d8( grenade, #"hash_c50cf868c6994df3", #"use" );
    challengeparams = { #fieldupgraderef:"super_deployed_decoy", #fieldupgradeent:grenade, #fieldupgradeowner:grenade.owner };
    callback::callback( #"hash_2af4adf11224c49a", challengeparams );
    
    /#
        if ( false )
        {
            grenade thread deployeddecoy_debugdraw();
        }
    #/
}

// Namespace deployed_decoy
// Params 0
// Checksum 0x5cf4bce9, Offset: 0x18f6
// Size: 0x450
function function_db0e187be003ad72()
{
    self endon( #"death" );
    forward = anglestoforward( self.angles );
    up = anglestoup( self.angles );
    self.var_9e1b0a618108e5be = [ self.origin ];
    ignorelist = [];
    ignorelist[ 0 ] = self;
    contents = trace::create_default_contents( 1 );
    var_c46ebe1b440cfc19 = killstreak_utility::function_947e7b15331fd6e3( self.var_dd23c93356a9224d );
    var_ef73805f798a5f7d = !var_c46ebe1b440cfc19 ? 8 : 4;
    var_afa369b90bd9ec2e = !var_c46ebe1b440cfc19 ? 45 : 90;
    
    for ( i = 0; i <= var_ef73805f798a5f7d ; i++ )
    {
        degrees = 0 + var_afa369b90bd9ec2e * i;
        rot = rotatepointaroundvector( up, forward, degrees );
        rot = vectornormalize( rot ) * 28;
        rot = self.origin + rot;
        castresults = trace::ray_trace( self.origin, rot, ignorelist, contents, 0, 1, 0 );
        hadhit = castresults.size > 0 && castresults[ "hittype" ] != "hittype_none";
        
        if ( hadhit )
        {
            var_d1158c7ddf14eb21 = castresults[ "position" ] - rot;
            var_d1158c7ddf14eb21 *= 2;
            var_d1158c7ddf14eb21 = self.origin + var_d1158c7ddf14eb21;
            self.var_9e1b0a618108e5be[ self.var_9e1b0a618108e5be.size ] = var_d1158c7ddf14eb21;
        }
        
        /#
            if ( true )
            {
                colorred = ( 1, 0, 0 );
                colorgreen = ( 0, 1, 0 );
                spherecolor = colorgreen;
                drawduration = level.framedurationseconds * 60 * 10;
                
                if ( hadhit )
                {
                    spherecolor = colorred;
                    drawpoint = castresults[ "<dev string:x24>" ];
                    
                    if ( isdefined( drawpoint ) )
                    {
                        thread debug_utility::drawsphere( drawpoint, 0.5, drawduration, spherecolor );
                    }
                }
                
                thread debug_utility::drawsphere( rot, 1, drawduration, spherecolor );
                thread debug_utility::drawline( self.origin, rot, drawduration, spherecolor );
            }
        #/
        
        if ( !var_c46ebe1b440cfc19 )
        {
            waitframe();
        }
    }
    
    self.var_7d439300e86c9236 = undefined;
    
    while ( self.var_9e1b0a618108e5be.size > 0 )
    {
        avgpoint = undefined;
        
        if ( self.var_9e1b0a618108e5be.size > 1 )
        {
            avgpoint = averagepoint( self.var_9e1b0a618108e5be );
        }
        else
        {
            avgpoint = self.var_9e1b0a618108e5be[ 0 ];
        }
        
        tracedown = trace::ray_trace( avgpoint, avgpoint + ( 0, 0, -24 ), ignorelist, contents );
        hadhit = tracedown.size > 0 && tracedown[ "hittype" ] != "hittype_none";
        
        if ( hadhit )
        {
            self.var_7d439300e86c9236 = tracedown[ "position" ];
            
            if ( true )
            {
                coloryellow = ( 1, 1, 0 );
                drawduration = level.framedurationseconds * 60 * 10;
                thread debug_utility::drawsphere( tracedown[ "position" ], 1, drawduration, coloryellow );
            }
            
            candeploy = function_8c49d93a055c67a2();
            
            if ( candeploy != 0 )
            {
                break;
            }
        }
        
        closest = self.var_9e1b0a618108e5be[ 0 ];
        
        foreach ( point in self.var_9e1b0a618108e5be )
        {
            if ( distancesquared( closest, avgpoint ) > distancesquared( point, avgpoint ) )
            {
                closest = point;
            }
        }
        
        self.var_9e1b0a618108e5be = arrayremove( self.var_9e1b0a618108e5be, closest );
    }
    
    /#
        if ( true )
        {
            colorpurple = ( 1, 0, 1 );
            drawduration = level.framedurationseconds * 60 * 10;
            
            if ( isdefined( self.var_7d439300e86c9236 ) )
            {
                thread debug_utility::drawsphere( self.var_7d439300e86c9236, 1, drawduration, colorpurple );
            }
        }
    #/
}

// Namespace deployed_decoy
// Params 0
// Checksum 0xbaf5bb63, Offset: 0x1d4e
// Size: 0x58
function function_2e433491b56dd3d()
{
    self endon( #"explode" );
    self endon( #"death" );
    self waittill( #"missile_water_impact", var_a923b78f4b77f26b, var_68710ac0de0ae982, var_be7ff3c11cc26733 );
    
    if ( isdefined( var_68710ac0de0ae982 ) )
    {
        self.waterimpactpos = var_68710ac0de0ae982;
    }
}

// Namespace deployed_decoy
// Params 0
// Checksum 0x556f5887, Offset: 0x1dae
// Size: 0x216
function deployeddecoy_arm()
{
    self.owner endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"mine_destroyed" );
    ent_manager::registerspawn( 1, &function_e18b1ccf5a93a97c );
    self.owner weapons::onequipmentplanted( self, "equip_deployed_decoy", &function_e18b1ccf5a93a97c );
    thread weapons::monitordisownedequipment( self.owner, self );
    function_344f2975b52394ab();
    self setentityowner( self.owner );
    self setotherent( self.owner );
    self setnodeploy( 1 );
    self missilethermal();
    self missileoutline();
    self.headiconid = entityheadicons::setheadicon_equipment( self );
    thread weapons::minedamagemonitor();
    thread deployeddecoy_explodeonnotify();
    
    if ( isplayer( self.owner ) )
    {
        self.owner thread function_d6e3384a0af3a825( self );
    }
    
    if ( level.gamemodebundle.var_738c716858d0a544 )
    {
        utility::callsharedfunc( #"hash_e47b78903231fa83", #"hash_34f9d09235c7b7df", &function_1512c2d35d075d96 );
    }
    
    emp_debuff::set_apply_emp_callback( &deployeddecoy_empapplied );
    haywire::function_7f69a1eb3d590f76( &function_624740cabbe8eeb9 );
    self.owner function_d7b2834cdaeb2d49();
    function_a4ebfb83ec0621b9( &function_53115de24fa0db2b );
    
    if ( isdefined( level.elevators ) )
    {
        foreach ( elevators in level.elevators )
        {
            elevators thread elevators::isentitytouchingdoortrigger( self );
        }
    }
    
    function_cf7216ea6139732();
    self setscriptablepartstate( "plant", "active", 0 );
    function_42f6d5b4c3df68f1();
    self.armed = 1;
    self.owner thread deployeddecoy_watchfordetonate();
    wait 0.5;
    thread function_36afeb205ce5641d();
}

// Namespace deployed_decoy
// Params 0
// Checksum 0x9e796041, Offset: 0x1fcc
// Size: 0x1e3
function function_344f2975b52394ab()
{
    if ( isdefined( self.waterimpactpos ) || self.ownerwasunderwater )
    {
        uptracestart = self.origin + ( 0, 0, 2000 );
        ignorelist = function_56aff31afa68a2f();
        contents = trace::function_bbd81e56529ef225();
        castresults = trace::ray_trace( self.origin, uptracestart, ignorelist, contents, 0, 1, 0 );
        
        if ( isdefined( castresults ) )
        {
            self.stuckwaterdepth = distance( self.origin, castresults[ "position" ] );
            
            /#
                if ( false )
                {
                    drawduration = 10;
                    printduration = int( drawduration / level.framedurationseconds );
                    printscale = 0.15;
                    thread debug_utility::drawsphere( uptracestart, 15, level.framedurationseconds * 60 * 5, ( 255, 0, 0 ) );
                    thread debug_utility::drawsphere( castresults[ "<dev string:x24>" ], 15, level.framedurationseconds * 60 * 5, ( 0, 0, 255 ) );
                    print3d( self.origin + ( 0, 0, 24 ), "<dev string:x2d>" + self.stuckwaterdepth, ( 0, 255, 0 ), 1, printscale, printduration, 1 );
                    thread debug_utility::drawline( uptracestart, self.origin, level.framedurationseconds * 60 * 5, ( 0, 0, 255 ) );
                    thread debug_utility::drawsphere( self.origin, 15, level.framedurationseconds * 60 * 5, ( 0, 255, 0 ) );
                }
            #/
        }
        else
        {
            self.stuckwaterdepth = undefined;
        }
    }
    
    return self.stuckwaterdepth;
}

// Namespace deployed_decoy
// Params 0
// Checksum 0x8ac2331b, Offset: 0x21b8
// Size: 0x129
function function_36afeb205ce5641d()
{
    self endon( #"mine_triggered" );
    self endon( #"mine_destroyed" );
    self endon( #"death" );
    var_b8b139e6388f2114 = 0;
    
    while ( !var_b8b139e6388f2114 )
    {
        self waittill( #"trigger_grenade", entarr );
        assert( isdefined( entarr ) );
        
        if ( self.stunned || self.owner.ksempd )
        {
            continue;
        }
        
        foreach ( ent in entarr )
        {
            if ( !function_b304ce598ab7f5e5( ent ) )
            {
                continue;
            }
            
            function_ce28dc119a6e765d( ent );
            
            if ( self.triggerdata.btriggers )
            {
                thread deployeddecoy_trigger( ent );
                var_b8b139e6388f2114 = 1;
                break;
            }
        }
    }
}

// Namespace deployed_decoy
// Params 1
// Checksum 0xf2477607, Offset: 0x22e9
// Size: 0x8a, Type: bool
function function_b304ce598ab7f5e5( ent )
{
    /#
        if ( false )
        {
            return false;
        }
    #/
    
    if ( ent == self.owner )
    {
        return false;
    }
    
    if ( !isdefined( ent.team ) || ent.team == self.team )
    {
        return false;
    }
    
    if ( !isdefined( ent.classname ) )
    {
        return false;
    }
    
    if ( !isplayer( ent ) && !isagent( ent ) )
    {
        return false;
    }
    
    if ( !player::isreallyalive( ent ) )
    {
        return false;
    }
    
    return true;
}

// Namespace deployed_decoy
// Params 0, eflags: 0x4
// Checksum 0xf2baf6a, Offset: 0x237c
// Size: 0xa8
function private deployeddecoy_watchfordetonate()
{
    self notify( #"deployeddecoy_watchfordetonate" );
    self endon( #"deployeddecoy_watchfordetonate" );
    self endon( #"mine_destroyed" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"detonate" );
        
        if ( !self.ksempd )
        {
            if ( self getheldoffhand().basename == "deployed_decoy_mp" || self getheldoffhand().basename == "none" && self.isusingcamera )
            {
                function_3dd098b3c9458319();
                break;
            }
        }
    }
}

// Namespace deployed_decoy
// Params 0, eflags: 0x4
// Checksum 0x8c67f7e9, Offset: 0x242c
// Size: 0x92
function private function_3dd098b3c9458319()
{
    self.var_7c99c656f84a5f2a = undefined;
    
    if ( isdefined( self.var_70e47e4d766ba906 ) )
    {
        foreach ( decoymine in self.var_70e47e4d766ba906 )
        {
            decoymine deployeddecoy_explode();
        }
    }
}

// Namespace deployed_decoy
// Params 1, eflags: 0x4
// Checksum 0x70a7077d, Offset: 0x24c6
// Size: 0x61
function private function_34c0a155a8f9d677( ent )
{
    eorigins = [];
    
    if ( isdefined( ent ) )
    {
        var_c61cd1b15eeee03c = ent gettagorigin( "j_mainroot" );
        eorigins = [ var_c61cd1b15eeee03c ];
        eorigins[ eorigins.size ] = ent gettagorigin( "j_spineupper" );
        eorigins[ eorigins.size ] = ent.origin;
    }
    
    return eorigins;
}

// Namespace deployed_decoy
// Params 1, eflags: 0x4
// Checksum 0xda63eff6, Offset: 0x2530
// Size: 0x269
function private function_ce28dc119a6e765d( ent )
{
    self.triggerdata = undefined;
    triggerdata = spawnstruct();
    triggerdata.iscomplete = 0;
    eorigins = function_34c0a155a8f9d677( ent );
    
    foreach ( eorigin in eorigins )
    {
        triggerdata = spawnstruct();
        triggerdata.targetpos = eorigin;
        triggerdata.iscomplete = 1;
        triggerdata.var_a3857e7d74d79727 = 0;
        triggerdata.var_a6c944ed4a96d055 = 0;
        triggerdata.var_61f85eb92765277f = 0;
        triggerdata.var_a012e201dafbc9d9 = 0;
        triggerdata.var_6a35243601c37cd2 = 0;
        triggerdata.btriggers = 0;
        triggerdata.var_a3857e7d74d79727 = function_1b1dce2ebed2a895( eorigin );
        triggerdata.var_a6c944ed4a96d055 = function_7a490b7a802139f9( eorigin );
        triggerdata.var_61f85eb92765277f = function_805edabf039f1c7d( eorigin, 58 );
        triggerdata.var_a012e201dafbc9d9 = function_805edabf039f1c7d( eorigin, 40 );
        
        if ( self.stuckwaterdepth >= 72 )
        {
            triggerdata.var_6a35243601c37cd2 = function_805edabf039f1c7d( eorigin, self.stuckwaterdepth );
        }
        
        if ( isdefined( self.waterimpactpos ) )
        {
            triggerdata.btriggers = triggerdata.var_a6c944ed4a96d055 && ( triggerdata.var_6a35243601c37cd2 || triggerdata.var_61f85eb92765277f );
        }
        else
        {
            triggerdata.btriggers = triggerdata.var_a3857e7d74d79727 && triggerdata.var_a6c944ed4a96d055 && ( triggerdata.var_61f85eb92765277f || triggerdata.var_a012e201dafbc9d9 );
        }
        
        if ( triggerdata.btriggers )
        {
            break;
        }
    }
    
    triggerdata.headroom = 0;
    triggerdata.headroom = function_8c49d93a055c67a2();
    self.triggerdata = triggerdata;
    return self.triggerdata;
}

// Namespace deployed_decoy
// Params 0, eflags: 0x4
// Checksum 0xc119d7db, Offset: 0x27a2
// Size: 0x149
function private function_8c49d93a055c67a2()
{
    ignorelist = function_56aff31afa68a2f();
    contents = function_219d7b6ea6a7ef0d();
    caststart = self.var_7d439300e86c9236 ?? self.origin;
    caststart += ( 0, 0, 17 );
    castend = caststart + ( 0, 0, 66 );
    castresults = trace::ray_trace( caststart, castend, ignorelist, contents, 0, 0 );
    var_917cb0110429be1f = 0;
    var_386ad76eb6823de4 = undefined;
    
    if ( isdefined( castresults[ "hittype" ] ) )
    {
        if ( castresults[ "hittype" ] == "hittype_world" && isdefined( castresults[ "position" ] ) )
        {
            var_386ad76eb6823de4 = distance( caststart, castresults[ "position" ] );
            thread debug_utility::drawsphere( castresults[ "position" ], 1, 100, ( 1, 0, 0 ) );
        }
    }
    
    if ( isdefined( var_386ad76eb6823de4 ) )
    {
        if ( var_386ad76eb6823de4 >= 53 )
        {
            var_917cb0110429be1f = 1;
        }
        
        if ( var_386ad76eb6823de4 >= 66 )
        {
            var_917cb0110429be1f = 2;
        }
    }
    else
    {
        var_917cb0110429be1f = 2;
    }
    
    /#
        if ( true )
        {
            thread debug_utility::drawline( caststart, caststart + ( 0, 0, 66 ), 5, ( 127, 0, 0 ) );
        }
    #/
    
    return var_917cb0110429be1f;
}

// Namespace deployed_decoy
// Params 2, eflags: 0x4
// Checksum 0xcbdb13f6, Offset: 0x28f4
// Size: 0xeb
function private function_805edabf039f1c7d( eorigin, var_3357c168a671b9b1 )
{
    ignorelist = function_56aff31afa68a2f();
    contents = function_4ba2053915283914();
    castresults = trace::ray_trace( self.origin + ( 0, 0, var_3357c168a671b9b1 ), eorigin, ignorelist, contents, 0, 1, 0 );
    hadhit = castresults.size > 0 && castresults[ "hittype" ] == "hittype_entity";
    
    /#
        if ( false )
        {
            if ( hadhit )
            {
                thread debug_utility::drawline( self.origin + ( 0, 0, var_3357c168a671b9b1 ), eorigin, level.framedurationseconds, ( 0, 127, 0 ) );
            }
            else
            {
                thread debug_utility::drawline( self.origin + ( 0, 0, var_3357c168a671b9b1 ), eorigin, level.framedurationseconds, ( 127, 0, 0 ) );
            }
        }
    #/
    
    return hadhit;
}

// Namespace deployed_decoy
// Params 1, eflags: 0x4
// Checksum 0xbcf467cb, Offset: 0x29e8
// Size: 0x6d, Type: bool
function private function_e013a8987b0f37c7( entorigin )
{
    if ( !isdefined( entorigin ) )
    {
        return false;
    }
    
    forward = anglestoforward( self.angles );
    var_9f2753c2dacc5852 = vectornormalize( entorigin - self.origin );
    var_c0cc81f452e7989c = vectordot( forward, var_9f2753c2dacc5852 );
    return var_c0cc81f452e7989c > 0.866 && var_c0cc81f452e7989c > -0.866;
}

// Namespace deployed_decoy
// Params 1, eflags: 0x4
// Checksum 0x374a3110, Offset: 0x2a5e
// Size: 0x33, Type: bool
function private function_7a490b7a802139f9( eorigin )
{
    var_13d07a952b9ef74c = abs( self.origin[ 2 ] - eorigin[ 2 ] );
    return 384 >= var_13d07a952b9ef74c;
}

// Namespace deployed_decoy
// Params 1, eflags: 0x4
// Checksum 0xd492193d, Offset: 0x2a9a
// Size: 0x1f, Type: bool
function private function_1b1dce2ebed2a895( eorigin )
{
    return 350 >= distance2d( eorigin, self.origin );
}

// Namespace deployed_decoy
// Params 1
// Checksum 0x83b3e86a, Offset: 0x2ac2
// Size: 0xa6
function deployeddecoy_trigger( attacker )
{
    if ( isdefined( attacker ) )
    {
        attacker endon( #"death_or_disconnect" );
    }
    else
    {
        attacker = self.owner;
    }
    
    /#
        print::printgameaction( "<dev string:x35>", self.owner );
    #/
    
    if ( attacker != self.owner )
    {
        function_bc47c4a9c0f2d85b( self, attacker );
    }
    
    weapons::makeexplosiveunusuabletag();
    self setscriptablepartstate( "trigger", "active", 0 );
    
    if ( self.ontriggerfunc )
    {
        self thread [[ self.ontriggerfunc ]]( attacker );
    }
    
    thread deployeddecoy_explode( attacker );
    self notify( #"mine_triggered" );
}

// Namespace deployed_decoy
// Params 0, eflags: 0x4
// Checksum 0x54ea5db, Offset: 0x2b70
// Size: 0x90
function private deployeddecoy_explodeonnotify()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    owner = self.owner;
    self waittill( #"detonateexplosive", attacker );
    self.detonatingplayer = attacker;
    
    if ( self.owner.ksempd )
    {
        owner notify( #"deployeddecoy_unset" );
        thread function_53115de24fa0db2b();
        owner function_b4d249e6ad766adf();
        return;
    }
    
    thread deployeddecoy_explode( attacker );
}

// Namespace deployed_decoy
// Params 1
// Checksum 0x86f72e2a, Offset: 0x2c08
// Size: 0x6a, Type: bool
function function_f35109b3a0bcad2( var_7634e6877c7e7f5f )
{
    if ( !isdefined( self.var_70e47e4d766ba906 ) || self.var_70e47e4d766ba906.size == 0 )
    {
        return false;
    }
    
    inventory_utility::_takeweapon( var_7634e6877c7e7f5f );
    self clearoffhandspecial();
    self.var_7c99c656f84a5f2a = 1;
    self notify( #"activatedecoy", "success" );
    inventory_utility::_giveweapon( var_7634e6877c7e7f5f );
    self assignweaponoffhandspecial( var_7634e6877c7e7f5f );
    return true;
}

// Namespace deployed_decoy
// Params 0, eflags: 0x4
// Checksum 0xe0953f2d, Offset: 0x2c7b
// Size: 0x68, Type: bool
function private function_b2625e01c70d274c()
{
    if ( self.isjuggernaut )
    {
        return false;
    }
    
    if ( self isinfreefall() )
    {
        return false;
    }
    
    if ( supers_mp::issuperready() && !self.var_7c99c656f84a5f2a )
    {
        return false;
    }
    
    if ( self ishanging() )
    {
        return false;
    }
    
    if ( self isthrowinggrenade() )
    {
        return false;
    }
    
    if ( !val::get( "supers" ) )
    {
        return false;
    }
    
    if ( self.ksempd )
    {
        return false;
    }
    
    return true;
}

// Namespace deployed_decoy
// Params 1, eflags: 0x4
// Checksum 0x3751aacb, Offset: 0x2cec
// Size: 0x144
function private function_d6e3384a0af3a825( mine )
{
    level endon( #"game_ended" );
    self endon( #"deployeddecoy_unset" );
    self notify( #"hash_78b562e0e4765a25" );
    self endon( #"hash_78b562e0e4765a25" );
    self endon( #"disconnect" );
    
    if ( isdefined( level.gametypebundle ) && level.gametypebundle.var_a817308d8d92ff8c )
    {
        self endon( #"death" );
    }
    
    weaponobj = makeweapon( "rex_detonator_mp" );
    
    while ( true )
    {
        success = function_881255cbdb352e1a();
        
        if ( !success )
        {
            continue;
        }
        
        if ( !function_b2625e01c70d274c() )
        {
            continue;
        }
        
        superinfo = supers_mp::getcurrentsuper();
        
        if ( !isdefined( superinfo ) )
        {
            continue;
        }
        
        if ( superinfo.staticdata.ref == "super_select" )
        {
            val::reset_all( "ppmenu" );
            waitframe();
        }
        
        clackersuccess = weapon_utility::giveandfireoffhandreliable( weaponobj );
        
        /#
            if ( !clackersuccess )
            {
                print( "<dev string:x45>" );
            }
        #/
        
        thread function_3dd098b3c9458319();
        function_a46fec150353cb0f( mine );
        return;
    }
}

// Namespace deployed_decoy
// Params 0, eflags: 0x4
// Checksum 0x67287269, Offset: 0x2e38
// Size: 0x71, Type: bool
function private function_881255cbdb352e1a()
{
    if ( isplayer( self ) )
    {
        childthread function_7b698a7dfaee7dda();
        childthread function_a8a84b98e3352062();
    }
    
    self waittill( #"activatedecoy", msg );
    
    if ( isplayer( self ) )
    {
        self notifyonplayercommandremove( "tacButtonPress", "+smoke" );
        self notifyonplayercommandremove( "fragButtonPress", "+frag" );
        self notifyonplayercommandremove( "cameraActive", "+special" );
    }
    
    return msg == "success";
}

// Namespace deployed_decoy
// Params 0, eflags: 0x4
// Checksum 0x62fa93f9, Offset: 0x2eb2
// Size: 0x3c
function private function_7b698a7dfaee7dda()
{
    self endon( #"activatedecoy" );
    self notifyonplayercommand( "decoyExplodeKBM", "+special" );
    self waittill( #"decoyExplodeKBM" );
    self notify( #"activatedecoy", "success" );
}

// Namespace deployed_decoy
// Params 0, eflags: 0x4
// Checksum 0x7a7917b7, Offset: 0x2ef6
// Size: 0x81
function private function_a8a84b98e3352062()
{
    self endon( #"activatedecoy" );
    self notifyonplayercommand( "tacButtonPress", "+smoke" );
    self notifyonplayercommand( "fragButtonPress", "+frag" );
    var_ae907018b4147d20 = [ "tacButtonPress", "fragButtonPress" ];
    thread supers_mp::function_59e580eaf8854be2( var_ae907018b4147d20, [], 0.75 );
    self waittill( #"hash_c3884f38d7f57aaf", msg );
    self notify( #"activatedecoy", msg );
}

// Namespace deployed_decoy
// Params 0, eflags: 0x4
// Checksum 0x818f53ca, Offset: 0x2f7f
// Size: 0x27
function private function_4ba2053915283914()
{
    contents = trace::create_contents( 1, 1, 0, 1, 1, 1, 1, 1, 1 );
    return contents;
}

// Namespace deployed_decoy
// Params 0, eflags: 0x4
// Checksum 0x94dcec3a, Offset: 0x2faf
// Size: 0x29
function private function_219d7b6ea6a7ef0d()
{
    contents = trace::create_contents( 1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 0 );
    return contents;
}

// Namespace deployed_decoy
// Params 0, eflags: 0x4
// Checksum 0x92c48b4a, Offset: 0x2fe1
// Size: 0x16
function private function_56aff31afa68a2f()
{
    ignorelist = function_8f4a0193758d6705();
    return ignorelist;
}

// Namespace deployed_decoy
// Params 0, eflags: 0x4
// Checksum 0x92b1bc56, Offset: 0x3000
// Size: 0x173
function private function_8f4a0193758d6705()
{
    var_98918f9adeaa10bb = 1;
    
    /#
        var_98918f9adeaa10bb = 1;
    #/
    
    ignorelist = [];
    
    if ( var_98918f9adeaa10bb )
    {
        ignorelist[ ignorelist.size ] = self.owner;
        linkedents = self getlinkedchildren( 1 );
        
        if ( !isdefined( linkedents ) )
        {
            linkedents = [];
        }
        
        linkedents[ linkedents.size ] = self getlinkedparent();
        
        foreach ( linkedent in linkedents )
        {
            if ( isdefined( linkedent ) && linkedent.classname == "grenade" )
            {
                ignorelist[ ignorelist.size ] = linkedent;
            }
        }
    }
    
    if ( isdefined( level.dynamicladders ) )
    {
        foreach ( struct in level.dynamicladders )
        {
            ignorelist[ ignorelist.size ] = struct.ents[ 0 ];
        }
    }
    
    return ignorelist;
}

// Namespace deployed_decoy
// Params 1, eflags: 0x4
// Checksum 0xcbfc44d0, Offset: 0x317c
// Size: 0x6a
function private deployeddecoy_empapplied( data )
{
    attacker = data.attacker;
    
    if ( player_utility::playersareenemies( self.owner, attacker ) )
    {
        attacker equipment_mp::function_ada7da3083a6c593( self );
    }
    
    if ( isplayer( attacker ) )
    {
        attacker damagefeedback::updatedamagefeedback( "" );
    }
    
    deployeddecoy_explode( data.attacker );
}

// Namespace deployed_decoy
// Params 1, eflags: 0x4
// Checksum 0xb47c3f22, Offset: 0x31ee
// Size: 0x15
function private function_624740cabbe8eeb9( data )
{
    deployeddecoy_empapplied( data );
}

// Namespace deployed_decoy
// Params 0, eflags: 0x4
// Checksum 0x9ff9e836, Offset: 0x320b
// Size: 0x13, Type: bool
function private function_e963799759d4de38()
{
    if ( !self.armed )
    {
        return false;
    }
    
    return true;
}

// Namespace deployed_decoy
// Params 1, eflags: 0x4
// Checksum 0x25ddd5ab, Offset: 0x3227
// Size: 0x97
function private function_8403acf6cc3cba89( dummy )
{
    if ( isdefined( dummy.nearbydoors ) )
    {
        foreach ( door in dummy.nearbydoors )
        {
            door thread function_97aa8e7ba9f7ec20( dummy );
        }
    }
}

// Namespace deployed_decoy
// Params 1, eflags: 0x4
// Checksum 0xd7a8d8ca, Offset: 0x32c6
// Size: 0x58
function private function_97aa8e7ba9f7ec20( dummy )
{
    doorstate = self getscriptablepartstate( "door", 1 );
    
    if ( isdefined( doorstate ) && doorstate != "frozen" && doorstate != "locked" )
    {
        self scriptabledoorbashopen( "away", dummy.origin );
    }
}

// Namespace deployed_decoy
// Params 1, eflags: 0x4
// Checksum 0xa2abea0b, Offset: 0x3326
// Size: 0x3b
function private function_1220da644c3110e3( stuckto )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    stuckto waittill( #"death" );
    function_bd50396f5fbbb90b( 1 );
}

// Namespace deployed_decoy
// Params 1, eflags: 0x4
// Checksum 0x8bea94c3, Offset: 0x3369
// Size: 0x8d3
function private deployeddecoy_explode( attacker )
{
    self endon( #"death" );
    self endon( #"mine_destroyed" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    cachedorigin = self.origin;
    cachedteam = self.team;
    cachedowner = self.owner;
    
    if ( isdefined( self.var_dd23c93356a9224d ) )
    {
        var_c46ebe1b440cfc19 = killstreak_utility::function_947e7b15331fd6e3( self.var_dd23c93356a9224d );
    }
    
    if ( !function_e963799759d4de38() )
    {
        return;
    }
    
    weapon::deregistermine();
    ent_manager::deregisterspawn();
    weapons::makeexplosiveunusuabletag();
    
    if ( isdefined( self.useobj ) )
    {
        self.useobj delete();
    }
    
    self.exploding = 1;
    entityheadicons::setheadicon_deleteicon( self.headiconid );
    var_318a0ccfad54ac61 = self.angles;
    
    if ( isdefined( attacker ) )
    {
        if ( !isdefined( self.triggerdata ) || !self.triggerdata.iscomplete )
        {
            function_ce28dc119a6e765d( attacker );
        }
        
        if ( attacker == self.owner )
        {
            var_318a0ccfad54ac61 = self.angles;
        }
        else
        {
            var_318a0ccfad54ac61 = vectortoangles( attacker.origin - self.origin );
            var_318a0ccfad54ac61 = ( 0, var_318a0ccfad54ac61[ 1 ], 0 );
        }
    }
    else
    {
        function_ce28dc119a6e765d( undefined );
    }
    
    /#
        if ( false )
        {
            if ( isdefined( attacker ) )
            {
                thread debug_utility::drawsphere( attacker.origin, 15, level.framedurationseconds, ( 255, 0, 0 ) );
            }
            
            thread debug_utility::drawangles( self.origin, var_318a0ccfad54ac61, 10, 1 );
        }
    #/
    
    if ( var_c46ebe1b440cfc19 )
    {
        function_db0e187be003ad72();
    }
    
    self.dummy = function_88b59400d5685873();
    self.dummy.owner = self.owner;
    self.dummy.team = self.owner.team;
    self.owner.var_9c3fb91381350906[ self.usedtimestamp ] = self.dummy;
    self.dummy.var_e4af09100d6247e0 = self.var_e4af09100d6247e0;
    self.dummy.angles = var_318a0ccfad54ac61;
    self.dummy.usedtimestamp = self.usedtimestamp;
    self.dummy.nearbydoors = self.nearbydoors;
    self.dummy setentityowner( self.owner );
    self.dummy setotherent( self.owner );
    self.dummy.superref = "super_deployed_decoy";
    level.deployeddecoys[ level.deployeddecoys.size ] = self.dummy;
    
    if ( isdefined( self.var_dd23c93356a9224d ) && var_c46ebe1b440cfc19 )
    {
        self.dummy linkto( self.var_dd23c93356a9224d );
    }
    else if ( isdefined( self.var_dd23c93356a9224d ) )
    {
        self.dummy thread function_1220da644c3110e3( self.var_dd23c93356a9224d );
    }
    
    self setscriptablepartstate( "plant", "neutral", 0 );
    self setscriptablepartstate( "trigger", "neutral", 0 );
    self setscriptablepartstate( "explode", "active", 0 );
    thread function_ea6cd9edcc1821d0();
    glassradiusdamage( self.origin, 85, 75, 25 );
    function_8403acf6cc3cba89( self.dummy );
    
    if ( isdefined( self.dummy ) )
    {
        self.dummy thread function_5ae4e2c885ec20d3( self.var_e4af09100d6247e0 );
        self.dummy thread function_5d0b89a2edc8a1f2( 1 );
        self.dummy function_a4ebfb83ec0621b9( &function_bd50396f5fbbb90b );
        self.dummy enableplayermarks( #"equipment" );
        
        if ( level.teambased )
        {
            self.dummy filteroutplayermarks( self.dummy.owner.team );
        }
        else
        {
            self.dummy filteroutplayermarks( self.dummy.owner );
        }
        
        if ( isdefined( self.var_dd23c93356a9224d ) )
        {
            self.dummy.moving_platform = self.var_dd23c93356a9224d;
            data = spawnstruct();
            data.linkparent = self.dummy.moving_platform;
            data.deathoverridecallback = &function_c89ab520fe9a5e1e;
            data.validateaccuratetouching = 1;
            self.dummy thread movers::handle_moving_platforms( data );
            self.dummy thread function_243636e7293d0098();
        }
        else if ( isdefined( level.wztrain_info ) )
        {
            data = spawnstruct();
            data.deathoverridecallback = &function_c89ab520fe9a5e1e;
            self.dummy thread movers::handle_moving_platforms( data );
        }
        
        if ( isdefined( level.var_3a19d822d2fb52ec ) )
        {
            foreach ( func in level.var_3a19d822d2fb52ec )
            {
                level thread [[ func ]]( self.dummy );
            }
        }
    }
    
    if ( isdefined( cachedorigin ) && isdefined( cachedteam ) && isdefined( cachedowner ) )
    {
        pinglocationenemyteams( cachedorigin, cachedteam, cachedowner );
    }
    
    if ( isdefined( level ) && isdefined( level.elevators ) )
    {
        foreach ( elevators in level.elevators )
        {
            if ( !isdefined( elevators ) )
            {
                continue;
            }
            
            if ( !isdefined( self ) )
            {
                continue;
            }
            
            if ( !isdefined( self.dummy ) )
            {
                continue;
            }
            
            elevators thread elevators::function_b3983cdb994ef3a( self.dummy );
        }
    }
    
    if ( isplayer( self.owner ) )
    {
        self.owner thread function_65dac109d812ae48();
    }
    
    if ( isdefined( self.dummy ) && isdefined( self.triggerdata ) && self.triggerdata.headroom == 0 )
    {
        self.dummy thread function_bd50396f5fbbb90b( 1 );
    }
    else if ( isdefined( self.dummy ) )
    {
        bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_deployed_decoy" );
        
        foreach ( player in level.players )
        {
            if ( player.team != self.owner.team )
            {
                self.dummy thread function_c6589b5c07beb955( player );
            }
        }
        
        if ( isdefined( bundle ) && bundle.simulategunfire )
        {
            self.dummy thread function_41d16a9af02f8f33( self.var_e4af09100d6247e0 );
        }
        
        if ( isdefined( bundle ) && bundle.simulatesniperglint )
        {
            self.dummy thread function_3d91ed5ade63a490( self.var_e4af09100d6247e0 );
        }
        
        if ( isdefined( bundle ) && bundle.var_22bc8d9bbf2ff8a0 )
        {
            image = "hud_icon_fieldupgrade_inflatable_decoy";
            self.dummy.headiconid = entityheadicons::setheadicon_fieldupgrade( self.dummy, image, self.dummy.origin + ( 0, 0, 48 ) );
        }
    }
    
    if ( isplayer( self.owner ) )
    {
        self.owner thread function_86892a8c4f29371c();
    }
    
    function_53115de24fa0db2b();
}

// Namespace deployed_decoy
// Params 1
// Checksum 0x5a7ae27c, Offset: 0x3c44
// Size: 0x137
function function_e9eab32742ab0b28( var_e4af09100d6247e0 )
{
    gunfireorigin = self.origin + anglestoforward( self.angles ) * 32 + anglestoup( self.angles ) * 52 + anglestoright( self.angles ) * 7;
    
    if ( var_e4af09100d6247e0 == "dummy_standing" )
    {
        gunfireorigin = self.origin + anglestoforward( self.angles ) * 32 + anglestoup( self.angles ) * 52 + anglestoright( self.angles ) * 7;
    }
    else if ( var_e4af09100d6247e0 == "dummy_crouching" )
    {
        gunfireorigin = self.origin + anglestoforward( self.angles ) * 37 + anglestoup( self.angles ) * 37 + anglestoright( self.angles ) * 4;
    }
    else if ( var_e4af09100d6247e0 == "dummy_swimming" )
    {
        gunfireorigin = self.origin + anglestoforward( self.angles ) * 32 - anglestoup( self.angles ) * 10 + anglestoright( self.angles ) * 4;
    }
    
    return gunfireorigin;
}

// Namespace deployed_decoy
// Params 0
// Checksum 0x9134af0, Offset: 0x3d84
// Size: 0x2c
function function_86892a8c4f29371c()
{
    level endon( #"game_ended" );
    self endon( #"deployeddecoy_unset" );
    wait 1.5;
    self setclientomnvar( "ui_block_fu_not_ready_error", 0 );
}

// Namespace deployed_decoy
// Params 1
// Checksum 0x514b3bda, Offset: 0x3db8
// Size: 0x185
function function_41d16a9af02f8f33( var_e4af09100d6247e0 )
{
    self endon( #"death" );
    self endon( #"deflate" );
    level endon( #"game_ended" );
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_deployed_decoy" );
    
    if ( !isdefined( bundle ) || !bundle.simulategunfire || !isdefined( bundle.var_b845057b1b7135c6 ) )
    {
        return;
    }
    
    wait 1.5;
    gunfireorigin = function_e9eab32742ab0b28( var_e4af09100d6247e0 );
    weapon = makeweapon( bundle.var_b845057b1b7135c6 );
    gunfiretarget = gunfireorigin + anglestoforward( self.angles ) * 1000;
    forwardvec = anglestoforward( self.angles );
    upvec = anglestoup( self.angles );
    self.var_e9d14961f76c271f = 0;
    thread function_d49cf78d77d3a464( gunfireorigin );
    
    while ( true )
    {
        if ( self.shouldfireweapon )
        {
            self.shouldfireweapon = 0;
            self.var_e9d14961f76c271f = 1;
            numbullets = randomintrange( 3, 31 );
            
            for ( i = 0; i < numbullets ; i++ )
            {
                magicbullet( weapon, gunfireorigin, gunfiretarget );
                playfx( level._effect[ "inflatable_decoy_gunfire_vfx" ], gunfireorigin, forwardvec, upvec );
                wait 0.1;
            }
            
            self.var_e9d14961f76c271f = 0;
        }
        
        waitframe();
    }
}

// Namespace deployed_decoy
// Params 1
// Checksum 0xbedd58c4, Offset: 0x3f45
// Size: 0x10e
function function_3d91ed5ade63a490( var_e4af09100d6247e0 )
{
    self endon( #"death" );
    self endon( #"deflate" );
    level endon( #"game_ended" );
    wait 1.5;
    gunfireorigin = function_e9eab32742ab0b28( var_e4af09100d6247e0 );
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_deployed_decoy" );
    
    if ( !isdefined( bundle ) || !isdefined( bundle.var_579114738b2f9d3b ) )
    {
        return;
    }
    
    self.var_5b54eae9a17a17c0 = spawn( "script_model", gunfireorigin );
    self.var_5b54eae9a17a17c0.team = self.team;
    self.var_5b54eae9a17a17c0.angles = self.angles;
    self.var_5b54eae9a17a17c0 setotherent( self.owner );
    self.var_5b54eae9a17a17c0 setmodel( bundle.var_579114738b2f9d3b );
    self.var_5b54eae9a17a17c0 setscriptablepartstate( "sniper_glint", "on" );
}

// Namespace deployed_decoy
// Params 1
// Checksum 0xd34edc62, Offset: 0x405b
// Size: 0x151
function function_d49cf78d77d3a464( gunfireorigin )
{
    self endon( #"death" );
    self endon( #"deflate" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( !self.var_e9d14961f76c271f )
        {
            foreach ( player in level.players )
            {
                if ( player.team != self.owner.team )
                {
                    var_8d07dcbf9dd1782d = vectornormalize( player.origin - gunfireorigin );
                    forwardvector = anglestoforward( self.angles );
                    dotproduct = vectordot( var_8d07dcbf9dd1782d, forwardvector );
                    
                    if ( dotproduct > 0.9 )
                    {
                        isvisible = player sightconetrace( gunfireorigin, self );
                        
                        if ( isvisible )
                        {
                            self.shouldfireweapon = 1;
                            break;
                        }
                    }
                }
            }
        }
        
        wait 0.1;
    }
}

// Namespace deployed_decoy
// Params 1
// Checksum 0x7afb161e, Offset: 0x41b4
// Size: 0x39
function function_6425edeecfae9fa4( funcpointer )
{
    if ( !isdefined( level.var_3a19d822d2fb52ec ) )
    {
        level.var_3a19d822d2fb52ec = [];
    }
    
    level.var_3a19d822d2fb52ec[ level.var_3a19d822d2fb52ec.size ] = funcpointer;
}

// Namespace deployed_decoy
// Params 1
// Checksum 0x7b6eb2bc, Offset: 0x41f5
// Size: 0x9e
function function_1512c2d35d075d96( params )
{
    mine = params.instance.entity;
    owner = mine.owner;
    
    if ( params.player != owner )
    {
        return;
    }
    
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_deployed_decoy" );
    owner thread equipment_mp::function_f6c5b0762bf2879e( bundle );
    owner playsoundtoplayer( "eqp_razor_wire_pickup", owner );
    owner supers_mp::refundsuper();
    mine function_e18b1ccf5a93a97c();
    owner function_b4d249e6ad766adf();
    return 1;
}

// Namespace deployed_decoy
// Params 0, eflags: 0x4
// Checksum 0x3ec9acf2, Offset: 0x429c
// Size: 0xe5
function private function_ea6cd9edcc1821d0()
{
    level endon( #"game_ended" );
    
    foreach ( player in level.players )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( player.team == self.team )
        {
            continue;
        }
        
        if ( 16 >= distance2dsquared( self.origin, player.origin ) )
        {
            player dodamage( 125, self.origin, self.owner, self, undefined, "deployed_decoy_mp", undefined, undefined );
        }
    }
}

// Namespace deployed_decoy
// Params 0
// Checksum 0xa2630e8c, Offset: 0x4389
// Size: 0x24
function function_243636e7293d0098()
{
    self endon( #"death" );
    
    while ( isdefined( self getlinkedparent() ) )
    {
        waitframe();
    }
    
    function_bd50396f5fbbb90b( 1 );
}

// Namespace deployed_decoy
// Params 0, eflags: 0x4
// Checksum 0xadb4fa75, Offset: 0x43b5
// Size: 0x60
function private function_cf7216ea6139732()
{
    if ( level.dangerzoneskipequipment )
    {
        return;
    }
    
    if ( isdefined( self.dangerzone ) )
    {
        spawnlogic::removespawninfluencer( self.dangerzone );
    }
    
    self.dangerzone = spawnlogic::addspawninfluencer( #"equipment_mine", self.origin, self.owner.team );
}

// Namespace deployed_decoy
// Params 2, eflags: 0x4
// Checksum 0x26864937, Offset: 0x441d
// Size: 0xe5
function private function_1fa2bf8379e92058( scriptmodelname, var_ffdad0503a521ea8 )
{
    if ( !isdefined( var_ffdad0503a521ea8 ) )
    {
        spawnpos = self.var_7d439300e86c9236 ?? self.origin;
    }
    else
    {
        spawnpos = ( self.var_7d439300e86c9236 ?? self.origin ) + var_ffdad0503a521ea8;
    }
    
    model = spawn( "script_model", spawnpos );
    model setmodel( scriptmodelname );
    model.weapon_name = supers_mp::function_5ffd3dfa9cc1e8de( "super_deployed_decoy" ).offhandweapon;
    model.team = self.owner.team;
    model.owner = self.owner;
    model sentientpoolmanager::registersentient( "Killstreak_Ground", self.owner );
    return model;
}

// Namespace deployed_decoy
// Params 0, eflags: 0x4
// Checksum 0xf563f64c, Offset: 0x450b
// Size: 0x19b
function private function_8fd611771d51f71c()
{
    caststart = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + 2000 );
    castend = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] - 5 );
    ignorelist = [];
    ignorelist = function_56aff31afa68a2f();
    contents = trace::function_bbd81e56529ef225();
    castresults = trace::ray_trace( caststart, castend, ignorelist, contents, 0, 1, 0 );
    
    if ( isdefined( castresults ) && castresults[ "hittype" ] != "hittype_none" )
    {
        /#
            if ( false )
            {
                thread debug_utility::drawsphere( caststart, 3, 30, ( 0, 255, 0 ) );
                thread debug_utility::drawsphere( castresults[ "<dev string:x24>" ], 3, 30, ( 0, 255, 0 ) );
                thread debug_utility::drawline( caststart, castresults[ "<dev string:x24>" ], 30, ( 0, 255, 0 ) );
            }
        #/
        
        return castresults[ "position" ];
    }
    
    /#
        if ( false )
        {
            thread debug_utility::drawsphere( caststart, 3, 30, ( 255, 0, 0 ) );
            thread debug_utility::drawsphere( castend, 3, 30, ( 255, 0, 0 ) );
            thread debug_utility::drawline( caststart, castend, 30, ( 255, 0, 0 ) );
        }
    #/
    
    return;
}

// Namespace deployed_decoy
// Params 0, eflags: 0x4
// Checksum 0xab8010c2, Offset: 0x46ae
// Size: 0x376
function private function_88b59400d5685873()
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_deployed_decoy" );
    dummy = undefined;
    var_c4b64056c1e5b10a = function_8fd611771d51f71c();
    
    if ( isdefined( var_c4b64056c1e5b10a ) )
    {
        caststart = ( self.origin[ 0 ], self.origin[ 1 ], var_c4b64056c1e5b10a[ 2 ] + 5 );
        castend = ( self.origin[ 0 ], self.origin[ 1 ], var_c4b64056c1e5b10a[ 2 ] - 40 );
        ignorelist = [];
        ignorelist = self;
        contents = trace::create_contents( 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 );
        castresults = trace::ray_trace( caststart, castend, ignorelist, contents, 0, 1, 0 );
        
        if ( isdefined( castresults ) && castresults[ "hittype" ] != "hittype_none" )
        {
            /#
                if ( false )
                {
                    thread debug_utility::drawsphere( caststart, 5, 35, ( 0, 255, 0 ) );
                    thread debug_utility::drawsphere( castresults[ "<dev string:x24>" ], 5, 35, ( 0, 255, 0 ) );
                    thread debug_utility::drawline( caststart, castresults[ "<dev string:x24>" ], 35, ( 0, 255, 0 ) );
                }
            #/
            
            var_46cfcd687c2f9dee = var_c4b64056c1e5b10a[ 2 ] - castresults[ "position" ][ 2 ];
            dummy = function_5a2afbd3f0657f1c( ( 0, 0, var_46cfcd687c2f9dee * -1 ) );
        }
        else
        {
            /#
                if ( false )
                {
                    thread debug_utility::drawsphere( caststart, 5, 35, ( 255, 0, 0 ) );
                    thread debug_utility::drawsphere( castend, 5, 35, ( 255, 0, 0 ) );
                    thread debug_utility::drawline( caststart, castend, 35, ( 255, 0, 0 ) );
                }
            #/
            
            var_af9931736c1345af = var_c4b64056c1e5b10a[ 2 ] - self.origin[ 2 ];
            submergedepth = bundle.var_f2d62e3070f0983d ?? 8;
            offset = ( 0, 0, var_af9931736c1345af ) - ( 0, 0, submergedepth );
            dummy = function_9eb1fc197efcc5d3( offset );
        }
    }
    else if ( isdefined( self.triggerdata ) && self.triggerdata.iscomplete && self.triggerdata.var_61f85eb92765277f && !self.triggerdata.var_a012e201dafbc9d9 && self.triggerdata.headroom >= 2 )
    {
        dummy = function_5a2afbd3f0657f1c();
    }
    else if ( isdefined( self.triggerdata ) && self.triggerdata.iscomplete && !self.triggerdata.var_61f85eb92765277f && self.triggerdata.var_a012e201dafbc9d9 && self.triggerdata.headroom >= 1 )
    {
        dummy = function_c72cdeb986452cd2();
    }
    else
    {
        randint = randomint( 2 );
        
        if ( randint > 0 )
        {
            dummy = function_5a2afbd3f0657f1c();
        }
        else
        {
            dummy = function_c72cdeb986452cd2();
        }
    }
    
    dummy function_f33bbedf99322db9();
    dummy ent_manager::registerspawn( 1, &function_182983621c2f9b1a );
    return dummy;
}

// Namespace deployed_decoy
// Params 1, eflags: 0x4
// Checksum 0xbb130b33, Offset: 0x4a2d
// Size: 0x77
function private function_5a2afbd3f0657f1c( var_ffdad0503a521ea8 )
{
    dummymodel = "offhand_2h_wm_decoy_mine_dummy01_v0_mp";
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_deployed_decoy" );
    
    if ( isdefined( bundle ) && isdefined( bundle.var_d207e5177a306d23 ) )
    {
        dummymodel = bundle.var_d207e5177a306d23;
    }
    
    outmodel = function_1fa2bf8379e92058( dummymodel, var_ffdad0503a521ea8 );
    self.var_e4af09100d6247e0 = "dummy_standing";
    return outmodel;
}

// Namespace deployed_decoy
// Params 1, eflags: 0x4
// Checksum 0xce124373, Offset: 0x4aad
// Size: 0x77
function private function_c72cdeb986452cd2( var_ffdad0503a521ea8 )
{
    dummymodel = "offhand_2h_wm_decoy_mine_dummy02_v0_mp";
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_deployed_decoy" );
    
    if ( isdefined( bundle ) && isdefined( bundle.var_e5fc3c2253098b5 ) )
    {
        dummymodel = bundle.var_e5fc3c2253098b5;
    }
    
    outmodel = function_1fa2bf8379e92058( dummymodel, var_ffdad0503a521ea8 );
    self.var_e4af09100d6247e0 = "dummy_crouching";
    return outmodel;
}

// Namespace deployed_decoy
// Params 1, eflags: 0x4
// Checksum 0x4156895d, Offset: 0x4b2d
// Size: 0x77
function private function_9eb1fc197efcc5d3( var_ffdad0503a521ea8 )
{
    dummymodel = "offhand_2h_wm_decoy_mine_dummy03_v0_mp";
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_deployed_decoy" );
    
    if ( isdefined( bundle ) && isdefined( bundle.var_b127d9b0a6672b36 ) )
    {
        dummymodel = bundle.var_b127d9b0a6672b36;
    }
    
    outmodel = function_1fa2bf8379e92058( dummymodel, var_ffdad0503a521ea8 );
    self.var_e4af09100d6247e0 = "dummy_swimming";
    return outmodel;
}

// Namespace deployed_decoy
// Params 1, eflags: 0x4
// Checksum 0xab2de5eb, Offset: 0x4bad
// Size: 0x14c
function private function_5ae4e2c885ec20d3( instring )
{
    self.owner endon( #"disconnect" );
    self endon( #"death" );
    level endon( #"endgame" );
    
    if ( !isdefined( instring ) )
    {
        return 0;
    }
    
    switch ( instring )
    {
        case #"hash_e2fb276aea336c4c":
            self setscriptablepartstate( "inflate", "iw9_mp_decoymine_inflate", 0 );
            wait getanimlength( %iw9_mp_decoymine_inflate );
            self setscriptablepartstate( "idle", "iw9_mp_decoymine_idle", 0 );
            self setscriptablepartstate( "inflate", "neutral", 0 );
            break;
        case #"hash_cb01a8c73dfd3d8e":
            self setscriptablepartstate( "inflate", "iw9_mp_decoymine_crouch_inflate", 0 );
            wait getanimlength( %iw9_mp_decoymine_crouch_inflate );
            self setscriptablepartstate( "idle", "iw9_mp_decoymine_crouch_idle", 0 );
            self setscriptablepartstate( "inflate", "neutral", 0 );
            break;
        case #"hash_db29f8f85388749":
            self setscriptablepartstate( "inflate", "iw9_mp_decoymine_swim_inflate", 0 );
            wait getanimlength( %iw9_mp_decoymine_swim_inflate );
            self setscriptablepartstate( "idle", "iw9_mp_decoymine_swim_idle", 1 );
            self setscriptablepartstate( "inflate", "neutral", 1 );
            break;
        default:
            break;
    }
}

// Namespace deployed_decoy
// Params 2, eflags: 0x4
// Checksum 0x94b4e64f, Offset: 0x4d01
// Size: 0x2d9
function private function_6be414094a735d0f( instring, bfromdamage )
{
    self endon( #"death" );
    self notify( #"deflate" );
    thread function_6ffda460ab0159d();
    
    switch ( instring )
    {
        case #"hash_e2fb276aea336c4c":
            if ( bfromdamage )
            {
                self setscriptablepartstate( "deflate", "iw9_mp_decoymine_pop", 0 );
                wait getanimlength( %iw9_mp_decoymine_pop );
                self setscriptablepartstate( "dummy_vis", "dummy_vis_hide", 0 );
                wait 0.4;
                glassradiusdamage( self.origin, 72, 75, 25 );
                self setscriptablepartstate( "deflate", "neutral", 0 );
            }
            else
            {
                self setscriptablepartstate( "hitreact", "neutral", 0 );
                self setscriptablepartstate( "idle", "neutral", 0 );
                self setscriptablepartstate( "deflate", "iw9_mp_decoymine_deflate", 0 );
                wait getanimlength( %iw9_mp_decoymine_deflate );
                self setscriptablepartstate( "dummy_vis", "dummy_vis_hide", 0 );
                self setscriptablepartstate( "deflate", "neutral", 0 );
            }
            
            break;
        case #"hash_cb01a8c73dfd3d8e":
            if ( bfromdamage )
            {
                self setscriptablepartstate( "deflate", "iw9_mp_decoymine_crouch_pop", 0 );
                wait getanimlength( %iw9_mp_decoymine_crouch_pop );
                self setscriptablepartstate( "dummy_vis", "dummy_vis_hide", 0 );
                wait 0.4;
                glassradiusdamage( self.origin, 72, 75, 25 );
                self setscriptablepartstate( "deflate", "neutral", 0 );
            }
            else
            {
                self setscriptablepartstate( "hitreact", "neutral", 0 );
                self setscriptablepartstate( "idle", "neutral", 0 );
                self setscriptablepartstate( "deflate", "iw9_mp_decoymine_crouch_deflate", 0 );
                wait getanimlength( %iw9_mp_decoymine_crouch_deflate );
                self setscriptablepartstate( "dummy_vis", "dummy_vis_hide", 0 );
                self setscriptablepartstate( "deflate", "neutral", 0 );
            }
            
            break;
        case #"hash_db29f8f85388749":
            if ( bfromdamage )
            {
                self setscriptablepartstate( "deflate", "iw9_mp_decoymine_swim_pop", 0 );
                wait getanimlength( %iw9_mp_decoymine_swim_pop );
                self setscriptablepartstate( "dummy_vis", "dummy_vis_hide", 0 );
                wait 0.4;
                glassradiusdamage( self.origin, 72, 75, 25 );
                self setscriptablepartstate( "dummy_vis", "dummy_vis_hide", 0 );
                self setscriptablepartstate( "deflate", "neutral", 0 );
            }
            else
            {
                self setscriptablepartstate( "hitreact", "neutral", 0 );
                self setscriptablepartstate( "idle", "neutral", 0 );
                self setscriptablepartstate( "deflate", "iw9_mp_decoymine_swim_deflate", 0 );
                wait getanimlength( %iw9_mp_decoymine_swim_deflate );
                self setscriptablepartstate( "deflate", "neutral", 0 );
            }
            
            break;
        default:
            assertmsg( "<dev string:x84>" );
            break;
    }
}

// Namespace deployed_decoy
// Params 0, eflags: 0x4
// Checksum 0x9a718004, Offset: 0x4fe2
// Size: 0x24
function private function_6ffda460ab0159d()
{
    effectent = self.var_5b54eae9a17a17c0;
    
    if ( isdefined( effectent ) )
    {
        effectent delete();
    }
}

// Namespace deployed_decoy
// Params 1, eflags: 0x4
// Checksum 0x1714f998, Offset: 0x500e
// Size: 0xd7
function private function_5d0b89a2edc8a1f2( delay )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"destroy" );
    
    if ( isdefined( delay ) )
    {
        wait delay;
    }
    
    switch ( self.var_e4af09100d6247e0 )
    {
        case #"hash_e2fb276aea336c4c":
            self.headiconid = entityheadicons::setheadicon_factionimage( 0, 65, undefined, undefined, undefined, 0, 1, 0, undefined, 0 );
            break;
        case #"hash_cb01a8c73dfd3d8e":
            self.headiconid = entityheadicons::setheadicon_factionimage( 0, 52, undefined, undefined, undefined, 0, 1, 0, undefined, 0 );
            break;
        case #"hash_db29f8f85388749":
            self.headiconid = entityheadicons::setheadicon_factionimage( 0, 29, undefined, undefined, undefined, 0, 1, 0, undefined, 0 );
            break;
        default:
            break;
    }
}

// Namespace deployed_decoy
// Params 0, eflags: 0x4
// Checksum 0x9dffb108, Offset: 0x50ed
// Size: 0xba
function private function_42f6d5b4c3df68f1()
{
    scriptablesinrange = getentitylessscriptablearray( undefined, undefined, self.origin, 75 );
    self.nearbydoors = [];
    
    foreach ( foundentity in scriptablesinrange )
    {
        if ( foundentity scriptableisdoor() || foundentity scriptabledoorisdouble() )
        {
            self.nearbydoors[ self.nearbydoors.size ] = foundentity;
        }
    }
}

// Namespace deployed_decoy
// Params 0
// Checksum 0x7af1c146, Offset: 0x51af
// Size: 0x6f
function function_53115de24fa0db2b()
{
    level endon( #"endgame" );
    
    if ( isdefined( self ) )
    {
        hasdummy = isdefined( self.dummy );
        
        if ( !hasdummy && self getscriptableparthasstate( "destroy", "activeNoDummy" ) )
        {
            self setscriptablepartstate( "destroy", "activeNoDummy", 1 );
        }
        else
        {
            self setscriptablepartstate( "destroy", "active", 0 );
        }
        
        childthread function_e18b1ccf5a93a97c();
    }
}

// Namespace deployed_decoy
// Params 0
// Checksum 0x6f0228f2, Offset: 0x5226
// Size: 0x142
function function_e18b1ccf5a93a97c()
{
    self endon( #"death" );
    level endon( #"endgame" );
    
    if ( isdefined( self ) )
    {
        self setscriptablepartstate( "hack_usable", "off" );
        
        if ( isdefined( self.owner ) && isdefined( self.owner.var_70e47e4d766ba906 ) )
        {
            self.owner.var_70e47e4d766ba906 = arrayremove( self.owner.var_70e47e4d766ba906, self );
        }
        
        damage::monitordamageend();
        weapon::deregistermine();
        self setcandamage( 0 );
        weapons::makeexplosiveunusuabletag();
        entityheadicons::setheadicon_deleteicon( self.headiconid );
        self.headiconid = undefined;
        self.exploding = 1;
        
        if ( isdefined( self.dangerzone ) )
        {
            spawnlogic::removespawninfluencer( self.dangerzone );
            self.dangerzone = undefined;
        }
        
        if ( isdefined( self.dummy ) )
        {
            self.dummy thread function_f3f17639b789b706( 30 );
            self.dummy thread function_456fec755450609d();
        }
        
        ent_manager::deregisterspawn();
        
        if ( isdefined( self.owner ) )
        {
            self.owner weapons::removeequip( self );
        }
        
        waitframe();
        self delete();
    }
}

// Namespace deployed_decoy
// Params 0, eflags: 0x4
// Checksum 0x4be241db, Offset: 0x5370
// Size: 0xd9
function private function_182983621c2f9b1a()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    level.deployeddecoys = arrayremove( level.deployeddecoys, self.dummy );
    damage::monitordamageend();
    ent_manager::deregisterspawn();
    entityheadicons::setheadicon_deleteicon( self.headiconid );
    self.headiconid = undefined;
    
    if ( isdefined( self.owner ) && isdefined( self.owner.var_9c3fb91381350906 ) )
    {
        self.owner.var_9c3fb91381350906 = arrayremove( self.owner.var_9c3fb91381350906, self );
    }
    
    waittillframeend();
    self delete();
    
    if ( isdefined( self.owner ) )
    {
        self.owner notify( #"hash_b24387a25049a6eb" );
    }
}

// Namespace deployed_decoy
// Params 1
// Checksum 0xdcb77b42, Offset: 0x5451
// Size: 0x15
function function_c89ab520fe9a5e1e( data )
{
    function_bd50396f5fbbb90b( 1 );
}

// Namespace deployed_decoy
// Params 1, eflags: 0x4
// Checksum 0xae5f3259, Offset: 0x546e
// Size: 0x13e
function private function_bd50396f5fbbb90b( bfromdamage )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self endon( #"death" );
    self.var_db9d0a769662b075 = 1;
    
    if ( bfromdamage )
    {
        playersnearby = getplayersinradius( self.origin, 64 );
        
        foreach ( player in playersnearby )
        {
            if ( player.team != self.owner.team )
            {
                player function_d7d6915942fa25cf( player.origin - self.origin );
            }
        }
    }
    
    self notify( #"hash_456a339ed55706ea" );
    self notify( #"hash_e97608ed49f91ac9" );
    self setscriptablepartstate( "hitreact", "neutral", 0 );
    self notify( #"destroy" );
    function_6be414094a735d0f( self.var_e4af09100d6247e0, bfromdamage );
    waittillframeend();
    function_182983621c2f9b1a();
}

// Namespace deployed_decoy
// Params 1, eflags: 0x4
// Checksum 0xa26d1d65, Offset: 0x55b4
// Size: 0x2a
function private function_f3f17639b789b706( deletiondelay )
{
    self endon( #"hash_e97608ed49f91ac9" );
    
    if ( !isdefined( deletiondelay ) )
    {
        deletiondelay = 0;
    }
    
    wait deletiondelay;
    thread function_bd50396f5fbbb90b();
}

// Namespace deployed_decoy
// Params 0, eflags: 0x4
// Checksum 0x14d69ba7, Offset: 0x55e6
// Size: 0x51
function private function_456fec755450609d()
{
    if ( !isdefined( level.gametypebundle ) || !level.gametypebundle.var_a817308d8d92ff8c )
    {
        return;
    }
    
    self endon( #"hash_e97608ed49f91ac9" );
    self.owner waittill( #"death_or_disconnect" );
    thread function_bd50396f5fbbb90b();
}

// Namespace deployed_decoy
// Params 2
// Checksum 0x9b6d067c, Offset: 0x563f
// Size: 0x4b, Type: bool
function function_995516a7f93b44b8( objweapon, var_9f6125e91b21437 )
{
    if ( var_9f6125e91b21437 )
    {
        return ( isdefined( objweapon ) && objweapon.basename == "deployed_decoy_mp" );
    }
    
    return isdefined( objweapon ) && objweapon.basename == "deployed_decoy_mp";
}

// Namespace deployed_decoy
// Params 1, eflags: 0x4
// Checksum 0xdda3b3dc, Offset: 0x5693
// Size: 0xa3
function private function_fb3fac90b215d8fc( var_163d4e42201f98f9 )
{
    if ( !( isdefined( var_163d4e42201f98f9 ) && isdefined( var_163d4e42201f98f9.owner ) ) )
    {
        return 0;
    }
    
    self notify( #"hash_6d99c9ea67990b9a" );
    self endon( #"hash_6d99c9ea67990b9a" );
    var_163d4e42201f98f9.owner endon( #"disconnect" );
    level endon( #"game_ended" );
    self.var_79ce7f618676c314 = var_163d4e42201f98f9 getentitynumber();
    self.var_f3e069f1e861d002 = var_163d4e42201f98f9.owner;
    utility::waittill_any_timeout( 10, "decoyDummyEndScoring" );
    self.var_79ce7f618676c314 = undefined;
    self.var_f3e069f1e861d002 = undefined;
}

// Namespace deployed_decoy
// Params 1, eflags: 0x4
// Checksum 0xc6fd2ed4, Offset: 0x573e
// Size: 0x73
function private function_c1491d658bb5eed9( data )
{
    if ( data.attacker != self.owner )
    {
        if ( !data.attacker function_2b2c1fea7ffb53fc( self ) )
        {
            if ( isdefined( self.owner ) )
            {
                self.owner thread points::doscoreevent( #"hash_218b72ef391e7f09" );
            }
        }
        
        data.attacker thread function_fb3fac90b215d8fc( self );
    }
}

// Namespace deployed_decoy
// Params 0
// Checksum 0x16249f5b, Offset: 0x57b9
// Size: 0x44
function function_4076e3ec808a995d()
{
    if ( function_2b2c1fea7ffb53fc() )
    {
        self.var_f3e069f1e861d002 thread points::doscoreevent( #"hash_63ddb3737fcc850d" );
        self notify( #"decoyDummyEndScoring" );
    }
    
    self.var_79ce7f618676c314 = undefined;
    self.var_f3e069f1e861d002 = undefined;
}

// Namespace deployed_decoy
// Params 1, eflags: 0x4
// Checksum 0xfa6e5dca, Offset: 0x5805
// Size: 0x54, Type: bool
function private function_2b2c1fea7ffb53fc( indummy )
{
    if ( !isdefined( indummy ) && isdefined( self.var_79ce7f618676c314 ) )
    {
        indummy = getentbynum( self.var_79ce7f618676c314 );
    }
    
    return isdefined( self.var_f3e069f1e861d002 ) && isdefined( indummy ) && indummy getentitynumber() == self.var_79ce7f618676c314;
}

// Namespace deployed_decoy
// Params 0
// Checksum 0x40668e35, Offset: 0x5862
// Size: 0xe, Type: bool
function function_13a1c1687c6e3e4d()
{
    return self.var_70e47e4d766ba906.size > 0;
}

// Namespace deployed_decoy
// Params 1
// Checksum 0xa540b709, Offset: 0x5879
// Size: 0x17
function function_a4ebfb83ec0621b9( callbackfunction )
{
    self.elevatordoorsclosecallback = callbackfunction;
}

// Namespace deployed_decoy
// Params 1
// Checksum 0x45c95fb0, Offset: 0x5898
// Size: 0x22d
function function_c6589b5c07beb955( player )
{
    self endon( #"death" );
    self endon( #"start_game_ended" );
    self endon( #"game_ended" );
    seteventdefaultdistance( "bulletwhizby", 0 );
    array[ "spotted" ][ "bulletwhizby" ] = 0;
    array[ "hidden" ][ "bulletwhizby" ] = 0;
    stealth_manager::set_event_distances( array );
    var_d9a41cc1b1f99dd1 = squared( 30 );
    
    while ( true )
    {
        player waittill( #"weapon_fired", weapon, bulletorigin, bulletangles );
        weaponfiredangles = bulletangles;
        weaponfiredorigin = bulletorigin;
        player waittill( #"bullet_first_impact", impacts );
        waitframe();
        var_e993b328ebb8ad99 = distance( weaponfiredorigin, impacts[ 0 ].hitpos );
        
        if ( impacts[ 0 ].hitent == self )
        {
            continue;
        }
        
        bulletforward = anglestoforward( weaponfiredangles );
        var_da7769bc63cc7155 = impacts[ 0 ].hitpos - weaponfiredorigin;
        var_64fa5cb10e61c8b = length( math::vector_project_onto_plane( var_da7769bc63cc7155, bulletforward ) );
        muzzlespeed = var_e993b328ebb8ad99 / sqrt( -2 * var_64fa5cb10e61c8b / -386 );
        decoyhead = self.origin + ( 0, 0, 50 );
        var_d0c6ab59153ab492 = distance( decoyhead, weaponfiredorigin );
        var_74fcd1a9076b7cac = function_9de669fc50843fbc( var_d0c6ab59153ab492, -386, muzzlespeed );
        var_c0a6e0179257dd63 = weaponfiredorigin + bulletforward * var_d0c6ab59153ab492;
        var_c0a6e0179257dd63 -= ( 0, 0, var_74fcd1a9076b7cac );
        
        if ( distancesquared( decoyhead, var_c0a6e0179257dd63 ) > var_d9a41cc1b1f99dd1 )
        {
            continue;
        }
        
        /#
        #/
        
        if ( !isdefined( self.var_a3a8c7622ac0f782 ) || self.var_a3a8c7622ac0f782 <= gettime() - 1000 )
        {
            self.owner thread points::doscoreevent( #"hash_218b72ef391e7f09" );
            self.var_a3a8c7622ac0f782 = gettime();
        }
    }
}

// Namespace deployed_decoy
// Params 3
// Checksum 0xc6358465, Offset: 0x5acd
// Size: 0x2f
function function_9de669fc50843fbc( distance, gravity, muzzlespeed )
{
    return -0.5 * gravity * squared( distance / muzzlespeed );
}

/#

    // Namespace deployed_decoy
    // Params 0, eflags: 0x4
    // Checksum 0xcf66ef58, Offset: 0x5b05
    // Size: 0x1cd, Type: dev
    function private deployeddecoy_debugdraw()
    {
        self endon( #"mine_triggered" );
        self endon( #"mine_destroyed" );
        self endon( #"death" );
        
        while ( true )
        {
            if ( !isdefined( self ) )
            {
                return;
            }
            
            if ( !isdefined( self.origin ) )
            {
                return;
            }
            
            thread debug_utility::drawcylinder( self.origin, 720, 384, level.framedurationseconds, ( 0, 0, 255 ) );
            thread debug_utility::drawcylinder( self.origin, 350, 384, level.framedurationseconds, ( 0, 0, 255 ) );
            thread debug_utility::drawcylinder( self.origin, 15, 40, level.framedurationseconds, ( 0, 0, 127 ) );
            thread debug_utility::drawcylinder( self.origin, 15, 58, level.framedurationseconds, ( 0, 0, 127 ) );
            thread debug_utility::drawangles( self.origin, self.angles, level.framedurationseconds, 1 );
            
            if ( isdefined( self.dummy ) )
            {
                thread debug_utility::drawsphere( self.dummy.origin, 1, level.framedurationseconds, ( 0, 0, 127 ) );
                thread debug_utility::drawangles( self.dummy.origin, self.dummy.angles, level.framedurationseconds, 1 );
            }
            
            if ( isdefined( self.waterimpactpos ) )
            {
                thread debug_utility::drawcylinder( self.waterimpactpos, 350, 5, level.framedurationseconds, ( 255, 0, 255 ) );
            }
            
            waitframe();
        }
    }

    // Namespace deployed_decoy
    // Params 1, eflags: 0x4
    // Checksum 0x19946f1c, Offset: 0x5cda
    // Size: 0x375, Type: dev
    function private function_b9d70e3ac08301df( data )
    {
        if ( false )
        {
            drawduration = 10;
            printduration = int( drawduration / level.framedurationseconds );
            printscale = 0.15;
            colorred = ( 1, 0, 0 );
            colorgreen = ( 0, 1, 0 );
            colorblue = ( 0, 0, 1 );
            var_9ffe0c57d6c3c070 = ( 1, 0, 1 );
            up = anglestoup( self.angles );
            forward = anglestoforward( self.angles );
            var_d3db5ced3ab1218b = self.origin + forward * 72;
            thread debug_utility::drawline( self.origin, var_d3db5ced3ab1218b, drawduration, var_9ffe0c57d6c3c070 );
            right = anglestoright( self.angles );
            direction = data.direction_vec;
            var_47259a436f00394f = self.origin + vectornormalize( direction ) * 72;
            angledelta = anglesdelta( vectortoangles( direction ), vectortoangles( forward ) );
            var_e5927bb78d23545b = vectordot( forward, direction );
            var_7deb2b861fc85a2 = vectordot( right, direction );
            hitstring = function_f45e9e8232f9c882( data ) ?? "<dev string:xd4>";
            thread debug_utility::drawcylinder( self.origin, 72, 10, drawduration, colorgreen );
            
            for ( i = 0; i <= 3 ; i++ )
            {
                degrees = 45 + 90 * i;
                rot = rotatepointaroundvector( up, forward, degrees );
                rot = vectornormalize( rot ) * 72;
                thread debug_utility::drawsphere( self.origin + rot, 1, drawduration, colorgreen );
                thread debug_utility::drawline( self.origin, self.origin + rot, drawduration, colorgreen );
            }
            
            if ( isdefined( data ) )
            {
                if ( isdefined( data.point ) )
                {
                    thread debug_utility::drawsphere( data.point, 1, drawduration, colorred );
                    
                    if ( isdefined( data.attacker ) )
                    {
                        thread debug_utility::drawline( data.point, data.attacker.origin, drawduration, colorred );
                    }
                }
                
                if ( isdefined( data.direction_vec ) )
                {
                    thread debug_utility::drawline( self.origin, var_47259a436f00394f, drawduration, colorblue );
                }
                
                var_460bace1775642c9 = data.attacker.origin;
                print3d( var_460bace1775642c9 + ( 0, 0, 24 ), "<dev string:xd9>" + angledelta, colorgreen, 1, printscale, printduration, 1 );
                print3d( var_460bace1775642c9 + ( 0, 0, 18 ), "<dev string:xe1>" + var_e5927bb78d23545b, colorgreen, 1, printscale, printduration, 1 );
                print3d( var_460bace1775642c9 + ( 0, 0, 12 ), "<dev string:xec>" + var_7deb2b861fc85a2, colorgreen, 1, printscale, printduration, 1 );
                print3d( var_460bace1775642c9 + ( 0, 0, 6 ), "<dev string:xf7>" + hitstring, colorgreen, 1, printscale, printduration, 1 );
            }
        }
    }

#/

// Namespace deployed_decoy
// Params 2, eflags: 0x4
// Checksum 0x4ecf5811, Offset: 0x6057
// Size: 0x170
function private function_bc47c4a9c0f2d85b( mine, victim )
{
    if ( !mine || !mine.owner challenges::challengesenabledforplayer() || !isplayer( mine.owner ) )
    {
        return;
    }
    
    if ( !isdefined( mine.challengedata ) )
    {
        mine.challengedata = {};
    }
    
    if ( !isdefined( mine.challengedata.bitmodifiers ) )
    {
        mine.challengedata.bitmodifiers = [];
    }
    
    if ( !isdefined( mine.challengedata.tripped_mine_victims ) )
    {
        mine.challengedata.tripped_mine_victims = [];
    }
    
    challenges::function_4fd386d590e901d8( mine, #"hash_c50cf868c6994df3", #"tripped_mine" );
    mine.challengedata.tripped_mine_victims = arraycombineunique( mine.challengedata.tripped_mine_victims, [ victim ] );
    function_ec39f308388f619e( mine );
    challengeparams = { #fieldupgraderef:"super_deployed_decoy", #fieldupgradeent:mine, #victim:victim, #attacker:mine.owner };
    callback::callback( #"field_upgrade_hit", challengeparams );
}

// Namespace deployed_decoy
// Params 1, eflags: 0x4
// Checksum 0x31f76cd8, Offset: 0x61cf
// Size: 0xf7
function private function_a46fec150353cb0f( mine )
{
    if ( !mine || !mine.owner challenges::challengesenabledforplayer() || !isplayer( mine.owner ) )
    {
        return;
    }
    
    if ( !isdefined( mine.challengedata ) )
    {
        mine.challengedata = {};
    }
    
    if ( !isdefined( mine.challengedata.bitmodifiers ) )
    {
        mine.challengedata.bitmodifiers = [];
    }
    
    challenges::function_4fd386d590e901d8( mine, #"hash_c50cf868c6994df3", #"hash_5260c5ab8a708ba9" );
    function_ec39f308388f619e( mine );
    challengeparams = { #fieldupgraderef:"super_deployed_decoy", #fieldupgradeent:mine, #fieldupgradeowner:mine.owner };
    callback::callback( #"hash_2af4adf11224c49a", challengeparams );
}

// Namespace deployed_decoy
// Params 1, eflags: 0x4
// Checksum 0x4f128024, Offset: 0x62ce
// Size: 0xf2
function private function_ec39f308388f619e( mine )
{
    if ( !mine )
    {
        return;
    }
    
    if ( !isdefined( mine.challengedata ) )
    {
        mine.challengedata = {};
    }
    
    if ( !isdefined( mine.challengedata.bitmodifiers ) )
    {
        mine.challengedata.bitmodifiers = [];
    }
    
    if ( !mine.var_e4af09100d6247e0 )
    {
        return;
    }
    
    switch ( mine.var_e4af09100d6247e0 )
    {
        case #"hash_e2fb276aea336c4c":
            break;
        case #"hash_cb01a8c73dfd3d8e":
            challenges::function_4fd386d590e901d8( mine, #"hash_c50cf868c6994df3", #"hash_9b81afe8bd818ffe" );
            break;
        case #"hash_db29f8f85388749":
            challenges::function_4fd386d590e901d8( mine, #"hash_c50cf868c6994df3", #"deployed_in_water" );
            break;
        default:
            break;
    }
}

