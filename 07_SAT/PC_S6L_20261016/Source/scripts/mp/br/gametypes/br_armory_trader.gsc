// scripts\mp\br\gametypes\br_armory_trader.gsc  (hash_2d557428f3cab055.gscc) (size: 36430 Bytes / 0x8e4e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6496b2a4 (1687597732)
// size ...... 36430 (0x8e4e)
// includes .. 32  (offset: 0x887a)
// strings ... 75  (offset: 0x897a)
// dev strs .. 14  (offset: 0x8da6)
// exports ... 111 (offset: 0x54da)
// cseg ...... 0x5e5 + 0x4ef5 (0x54da)
// imports ... 288 (offset: 0x6632)
// animtree1 . 0   (offset: 0x8e4e)
// animtree2 . 0   (offset: 0x8e4e)
#using scripts\common\callbacks;
#using scripts\common\omnvar_utility;
#using scripts\common\scriptable;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\weapon;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_dev;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_publicevents;
#using scripts\mp\challenges;
#using scripts\mp\class;
#using scripts\mp\common\killstreaks\emp;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\gameobjects;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\structspawnconfig;
#using scripts\mp\weapons;

#namespace br_armory_trader;

// Namespace br_armory_trader
// Params 0, eflags: 0x1
// Checksum 0x89efff1a, Offset: 0x603
// Size: 0x50
function autoexec main()
{
    level.br_armory_trader_enabled = getdvarint( @"scr_br_armory_trader", 1 ) != 0;
    
    if ( !function_52cecdce1c2bbadb() )
    {
        level.br_armory_trader_enabled = 0;
    }
    
    if ( !level.br_armory_trader_enabled )
    {
        return;
    }
    
    level callback::add( "br_functional_poi_init", &init );
}

// Namespace br_armory_trader
// Params 1
// Checksum 0x5ac5e7e5, Offset: 0x65b
// Size: 0x2bc
function init( params )
{
    if ( br_gametypes::isfeaturedisabled( #"trader" ) )
    {
        level.br_armory_trader_enabled = 0;
        return;
    }
    
    level.br_armory_trader = spawnstruct();
    level.br_armory_trader.scriptables = [];
    
    if ( !loadscriptbundle() )
    {
        level.br_armory_trader_enabled = 0;
        return;
    }
    
    utility::flag_wait( "ssc_initialized" );
    structspawnconfig::function_7418a260adaec05( "armory_trader", &function_139d58d75da4222 );
    structspawnconfig::function_8c0a09968efe9138( "armory_trader", &function_c7aec6cfb8b72735 );
    structspawnconfig::function_36050499b5f48983( "armory_trader", &function_32352b571f4a5da5 );
    scriptable::scriptable_addusedcallbackbypart( "br_armory_trader", &function_cb177db746b3cd89 );
    val::group_register( "TraderUse", [ "offhand_weapons", "fire", "melee", "weapon_switch", "killstreaks", "supers" ] );
    level.br_armory_trader.loadoutsdata = spawnstruct();
    level.br_armory_trader.loadoutsdata.var_182313cb700457a0 = getdvarint( @"hash_292c8fcc9a35b611", 32 );
    level.br_armory_trader.loadoutsdata.var_fee3e4ef3a29680a = 0;
    level.br_armory_trader.loadoutsdata.var_4115b6831cf42a8a = getdvarfloat( @"hash_3f2463516c3c4dde", 0.1 );
    level.br_armory_trader.var_d5ce984c3e990698 = getdvarint( @"hash_2daf2c6312e91b06", 0 );
    level.br_armory_trader.var_7249d71eaa3b2001 = getdvarint( @"hash_aea858d7e28d6927", 138 );
    level.br_armory_trader.var_87380520c5182b1a = getdvarint( @"hash_ca9c6ca232a34f7e", 0 ) > 0;
    level.br_armory_trader.pickupgrid = spawnstruct();
    level.br_armory_trader.pickupgrid.diameter = getdvarfloat( @"hash_dc652c49d7d25622", 60 );
    level.br_armory_trader.var_5729bedd26aec764 = 31;
    
    if ( level.skipprematch )
    {
        level thread skipprematch();
    }
    else
    {
        level callback::add( "br_functional_poi_on_prematch_done", &onprematchdone );
    }
    
    thread watchgameended();
    br_circle::registercirclecallbacks( 5, &dangercircletick, &dangermulticircletick, &function_3f0c4320f3b3b802, &function_9c93da3e6321de8 );
    callback::add( #"hash_dd36ab548337dd9a", &function_cd232e662410e35f );
    
    /#
        br_dev::registerhandlecommand( &function_14b882f27766cd37 );
    #/
}

// Namespace br_armory_trader
// Params 0, eflags: 0x4
// Checksum 0x57e08be2, Offset: 0x91f
// Size: 0x16
function private skipprematch()
{
    level waittill( #"ssc_config_spawned" );
    onprematchdone();
}

// Namespace br_armory_trader
// Params 0, eflags: 0x4
// Checksum 0x64284d23, Offset: 0x93d
// Size: 0x1f
function private function_39bfcb83a89d1d8()
{
    return level.br_armory_trader.scriptbundle.var_39bfcb83a89d1d8;
}

// Namespace br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x28980ce9, Offset: 0x965
// Size: 0x7c
function private function_6149084e4945afbf( var_343d0f04912e5e5b )
{
    str = "";
    
    for ( i = 0; i < var_343d0f04912e5e5b.size ; i++ )
    {
        hashedname = var_343d0f04912e5e5b[ i ];
        strname = getxhashhexname( hashedname );
        
        /#
            strname = getxhashsourcename( hashedname );
        #/
        
        str += strname;
        
        if ( i < var_343d0f04912e5e5b.size - 1 )
        {
            str += ", ";
        }
    }
    
    return str;
}

// Namespace br_armory_trader
// Params 0, eflags: 0x4
// Checksum 0x51082ca8, Offset: 0x9ea
// Size: 0x112, Type: bool
function private loadscriptbundle()
{
    var_3a9c482200f36514 = getscriptbundlenames( "armorytrader" );
    
    if ( var_3a9c482200f36514.size == 0 )
    {
        logdebug( "No asset of type '" + "armorytrader" + "' found. Disabling weapon trader feature..." );
        return false;
    }
    
    isdevbuild = 0;
    
    /#
        isdevbuild = 1;
    #/
    
    var_a6c2340b95a617a7 = var_3a9c482200f36514[ 0 ];
    
    if ( var_3a9c482200f36514.size > 1 )
    {
        bundlenames = function_6149084e4945afbf( var_3a9c482200f36514 );
        logdebug( "More than one '" + "armorytrader" + "' asset loaded : " + bundlenames + "." );
        
        if ( isdevbuild )
        {
            /#
                var_a8b5c5b59e8ce3e6 = getdvarint( @"scr_br_armory_trader_bundle_index", 0 );
                var_a6c2340b95a617a7 = var_3a9c482200f36514[ var_a8b5c5b59e8ce3e6 ];
                logdebug( "<dev string:x24>" + var_a6c2340b95a617a7 + "<dev string:x36>" + var_a8b5c5b59e8ce3e6 + "<dev string:x43>" );
            #/
        }
        else
        {
            assertmsg( "<dev string:x4e>" + "<dev string:x79>" + "<dev string:x86>" );
            return false;
        }
    }
    
    level.br_armory_trader.scriptbundle = getscriptbundle( var_a6c2340b95a617a7 );
    return true;
}

// Namespace br_armory_trader
// Params 0, eflags: 0x4
// Checksum 0xe73758b0, Offset: 0xb05
// Size: 0x3e
function private function_69091e5c7eb90bba()
{
    /#
        debugrandom = getdvarint( @"hash_7e0bd596e5457588", -1 );
        
        if ( debugrandom >= 0 )
        {
            return debugrandom;
        }
    #/
    
    return randomint( getdvarint( @"scr_br_armory_trader_randomizer", 32767 ) );
}

// Namespace br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x8314a6e8, Offset: 0xb4c
// Size: 0xd0
function private function_80d63ccf6865839f( position )
{
    mindistancesquared = undefined;
    closestinstance = undefined;
    
    foreach ( armorytrader in level.br_armory_trader.scriptables )
    {
        distancesquared = distance2dsquared( armorytrader.origin, position );
        
        if ( !isdefined( mindistancesquared ) || distancesquared < mindistancesquared )
        {
            mindistancesquared = distancesquared;
            closestinstance = armorytrader;
        }
    }
    
    return closestinstance;
}

// Namespace br_armory_trader
// Params 1
// Checksum 0x5dc2f623, Offset: 0xc25
// Size: 0x95
function onprematchdone( params )
{
    foreach ( armorytrader in level.br_armory_trader.scriptables )
    {
        if ( isdefined( armorytrader ) )
        {
            function_3f0c4320f3b3b802( armorytrader );
        }
    }
}

// Namespace br_armory_trader
// Params 0, eflags: 0x4
// Checksum 0x7b27deea, Offset: 0xcc2
// Size: 0xa1
function private watchgameended()
{
    level waittill( #"game_ended" );
    
    foreach ( armorytrader in level.br_armory_trader.scriptables )
    {
        if ( isdefined( armorytrader.visible ) )
        {
            function_2601f8507bdc2910( armorytrader );
        }
    }
}

// Namespace br_armory_trader
// Params 0, eflags: 0x4
// Checksum 0xca3b079, Offset: 0xd6b
// Size: 0x53
function private function_6ae9b1f80e64d73c()
{
    trigger = spawn( "noent_volume_trigger_radius", self.origin, 0, 500, 500 );
    trigger.playersintrigger = [];
    trigger thread watchtriggerenter( self );
    trigger thread watchtriggerexit( self );
    self.proximitytrigger = trigger;
}

// Namespace br_armory_trader
// Params 0, eflags: 0x4
// Checksum 0x9f268eed, Offset: 0xdc6
// Size: 0x1f
function private function_31468f366c5ec6af()
{
    if ( isdefined( self.proximitytrigger ) )
    {
        self.proximitytrigger destroytrigger();
    }
}

// Namespace br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0xcddead6, Offset: 0xded
// Size: 0x9e
function private watchtriggerenter( weapontrader )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( !player player::isreallyalive() )
        {
            continue;
        }
        
        playerentitynumber = player getentitynumber();
        
        if ( isdefined( self.playersintrigger[ playerentitynumber ] ) )
        {
            continue;
        }
        
        self.playersintrigger[ playerentitynumber ] = player;
        player thread onentertrigger( self, weapontrader );
    }
}

// Namespace br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x21cbcef8, Offset: 0xe93
// Size: 0xd3
function private watchtriggerexit( weapontrader )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        foreach ( playerentitynumber, player in self.playersintrigger )
        {
            if ( isdefined( player ) && player player::isreallyalive() && player istouching( self ) )
            {
                continue;
            }
            
            self.playersintrigger[ playerentitynumber ] = undefined;
            onexittrigger( player, weapontrader );
        }
        
        waitframe();
    }
}

// Namespace br_armory_trader
// Params 0, eflags: 0x4
// Checksum 0xd82454fe, Offset: 0xf6e
// Size: 0x8
function private destroytrigger()
{
    self delete();
}

// Namespace br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0xa838e8eb, Offset: 0xf7e
// Size: 0x6c
function private onentertrigger( trigger, weapontrader )
{
    thread monitorweaponchange( weapontrader );
    thread function_1695a3fc0abac00f( weapontrader );
    
    if ( function_39bfcb83a89d1d8() )
    {
        var_c8565f9fe327ff15 = weapontrader.var_8d18c12b898fde7c[ self getentitynumber() ].var_c8565f9fe327ff15 ?? 0;
        self setclientomnvar( "ui_br_weapon_trader_cooldown_end_time", int( var_c8565f9fe327ff15 ) );
    }
}

// Namespace br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0xf0f76e55, Offset: 0xff2
// Size: 0x48
function private onexittrigger( player, weapontrader )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player notify( "weapon_trader_trigger_exited_" + weapontrader.index );
    
    if ( function_39bfcb83a89d1d8() )
    {
        player setclientomnvar( "ui_br_weapon_trader_cooldown_end_time", 0 );
    }
}

// Namespace br_armory_trader
// Params 0
// Checksum 0xb3156ee6, Offset: 0x1042
// Size: 0xc1
function function_56ea40c52e695dd9()
{
    var_7634e6877c7e7f5f = self function_ca1904a5dd87fd53();
    var_4fa7081b2a33993e = 0;
    
    if ( isdefined( var_7634e6877c7e7f5f ) && weapons::isdroppableweapon( self, var_7634e6877c7e7f5f ) )
    {
        foreach ( weap in self.primaryweapons )
        {
            if ( issameweapon( weap, var_7634e6877c7e7f5f ) )
            {
                var_4fa7081b2a33993e = 1;
                break;
            }
        }
    }
    
    if ( var_4fa7081b2a33993e )
    {
        return var_7634e6877c7e7f5f;
    }
    
    return self.lastdroppableweaponobj;
}

// Namespace br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x398b7b83, Offset: 0x110c
// Size: 0x73
function private monitorweaponchange( weapontrader )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( "weapon_trader_trigger_exited_" + weapontrader.index );
    newweapon = function_56ea40c52e695dd9();
    
    while ( true )
    {
        if ( newweapon )
        {
            weapontrader function_c5ce5f386bd733e( self, newweapon );
        }
        
        self waittill( #"weapon_change", newweapon );
        waitframe();
    }
}

// Namespace br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x621cd218, Offset: 0x1187
// Size: 0x75
function private function_1695a3fc0abac00f( weapontrader )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( "weapon_trader_trigger_exited_" + weapontrader.index );
    
    while ( true )
    {
        if ( killstreak::isjuggernaut() )
        {
            function_84c5d0c2af97f284();
        }
        
        utility::waittill_any( "juggernaut_start", "juggernaut_end" );
        
        if ( !killstreak::isjuggernaut() )
        {
            weapontrader function_20bf6d128588a70b( self );
        }
    }
}

// Namespace br_armory_trader
// Params 0, eflags: 0x4
// Checksum 0x86e0b90e, Offset: 0x1204
// Size: 0x54
function private function_684d5852e6c56ef3()
{
    self endon( #"disabled" );
    self.var_2c6d224a61e1fe56 = [];
    
    while ( true )
    {
        level utility::waittill_any( "public_event_firesale_start", "public_event_firesale_end" );
        self.var_2c6d224a61e1fe56 = [];
        function_ec9b55a73ebc969f();
        
        if ( function_39bfcb83a89d1d8() )
        {
            function_4c2680925b8d9359( self );
        }
    }
}

// Namespace br_armory_trader
// Params 1
// Checksum 0x2b4f5e4e, Offset: 0x1260
// Size: 0xd1
function function_cd232e662410e35f( params )
{
    objectivestate = params.objectivestate;
    
    if ( isdefined( level.br_armory_trader.scriptables ) )
    {
        foreach ( trader in level.br_armory_trader.scriptables )
        {
            if ( trader.disabled )
            {
                continue;
            }
            
            trader setscriptablepartstate( "objective", objectivestate );
        }
    }
}

// Namespace br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0xfe20691a, Offset: 0x1339
// Size: 0x95
function private function_4c2680925b8d9359( trader )
{
    foreach ( playerentitynumber, tradedata in trader.var_8d18c12b898fde7c )
    {
        tradedata.var_c8565f9fe327ff15 = 0;
        function_9d100061fddd2b97( trader, playerentitynumber );
    }
}

// Namespace br_armory_trader
// Params 0, eflags: 0x4
// Checksum 0xb357a07b, Offset: 0x13d6
// Size: 0x94
function private function_ec9b55a73ebc969f()
{
    foreach ( armorytrader in level.br_armory_trader.scriptables )
    {
        if ( isdefined( armorytrader.visible ) )
        {
            armorytrader function_c80bd2a6aebbe44f();
        }
    }
}

// Namespace br_armory_trader
// Params 0
// Checksum 0x65b031cf, Offset: 0x1472
// Size: 0xab
function function_c80bd2a6aebbe44f()
{
    if ( !( isdefined( self.proximitytrigger ) && isdefined( self.proximitytrigger.playersintrigger ) ) )
    {
        return;
    }
    
    foreach ( player in self.proximitytrigger.playersintrigger )
    {
        function_20bf6d128588a70b( player );
    }
}

// Namespace br_armory_trader
// Params 1
// Checksum 0xb52964c8, Offset: 0x1525
// Size: 0x32
function function_20bf6d128588a70b( player )
{
    currentweapon = player.lastdroppableweaponobj;
    
    if ( currentweapon )
    {
        function_c5ce5f386bd733e( player, currentweapon );
    }
}

// Namespace br_armory_trader
// Params 3
// Checksum 0xbe579a58, Offset: 0x155f
// Size: 0x127
function dangercircletick( dangercircleorigin, dangercircleradius, thresholdradius )
{
    if ( !level.br_armory_trader_enabled || getdvarint( @"hash_c43c6d7961e72d40", 0 ) == 1 )
    {
        return;
    }
    
    assert( !br_gametypes::isfeaturedisabled( #"trader" ) );
    maxdistance = dangercircleradius + level.var_ea96217a33eb6457;
    maxdistancesquared = maxdistance * maxdistance;
    
    foreach ( armorytrader in level.br_armory_trader.scriptables )
    {
        if ( isdefined( armorytrader.visible ) && distance2dsquared( armorytrader.origin, dangercircleorigin ) > maxdistancesquared )
        {
            function_2601f8507bdc2910( armorytrader );
        }
    }
}

// Namespace br_armory_trader
// Params 0
// Checksum 0x5b43887c, Offset: 0x168e
// Size: 0x102
function dangermulticircletick()
{
    if ( !level.br_armory_trader_enabled || getdvarint( @"hash_c43c6d7961e72d40", 0 ) == 1 )
    {
        return;
    }
    
    assert( !br_gametypes::isfeaturedisabled( #"trader" ) );
    var_e56a3bb1d83690b3 = [];
    
    foreach ( armorytrader in level.br_armory_trader.scriptables )
    {
        if ( isdefined( armorytrader.visible ) && !br_circle_util::ispointinmulticircledanger( armorytrader.origin, level.var_ea96217a33eb6457 ) )
        {
            var_e56a3bb1d83690b3[ var_e56a3bb1d83690b3.size ] = armorytrader;
            function_2601f8507bdc2910( armorytrader );
        }
    }
    
    return var_e56a3bb1d83690b3;
}

// Namespace br_armory_trader
// Params 0
// Checksum 0xc4cec4dc, Offset: 0x1799
// Size: 0xa7
function function_9c93da3e6321de8()
{
    if ( br_gametypes::isfeaturedisabled( #"trader" ) )
    {
        return;
    }
    
    foreach ( armorytrader in level.br_armory_trader.scriptables )
    {
        if ( isdefined( armorytrader.visible ) )
        {
            function_2601f8507bdc2910( armorytrader );
        }
    }
}

// Namespace br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x5f8fd3c, Offset: 0x1848
// Size: 0x78
function private function_b81f6930642d83ae( armorytrader )
{
    armorytrader.var_db59b634083097b8 = 1;
    armorytrader.tradeseed = function_69091e5c7eb90bba();
    armorytrader.var_8d18c12b898fde7c = [];
    armorytrader function_9c8a9e076ea384a9();
    
    /#
        armorytrader thread function_bf44a755fac7a602();
    #/
    
    if ( isdefined( level.br_armory_trader.var_d5ce984c3e990698 ) )
    {
        emp::function_ddd803a218a9926c( armorytrader, &traderemp, &function_3f0c4320f3b3b802 );
    }
}

// Namespace br_armory_trader
// Params 1
// Checksum 0x4bdd208a, Offset: 0x18c8
// Size: 0x48
function function_3f0c4320f3b3b802( armorytrader )
{
    armorytrader setscriptablepartstate( "br_armory_trader", "visible" );
    armorytrader.visible = 1;
    armorytrader.disabled = undefined;
    armorytrader function_6ae9b1f80e64d73c();
    armorytrader thread function_684d5852e6c56ef3();
}

// Namespace br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x35cba773, Offset: 0x1918
// Size: 0x4c
function private function_2601f8507bdc2910( armorytrader )
{
    armorytrader setscriptablepartstate( "br_armory_trader", "disabled" );
    armorytrader.visible = undefined;
    armorytrader.disabled = 1;
    armorytrader function_31468f366c5ec6af();
    armorytrader notify( #"disabled" );
}

// Namespace br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x9de04841, Offset: 0x196c
// Size: 0x31, Type: bool
function private function_c0e56059b398e6be( player )
{
    if ( !br_publicevents::ispubliceventoftypeactive( %"firesale" ) )
    {
        return false;
    }
    
    return !arraycontains( self.var_2c6d224a61e1fe56, player );
}

// Namespace br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x2dd42086, Offset: 0x19a6
// Size: 0x4b
function private isfiresalecategory( tradecategory )
{
    if ( function_39bfcb83a89d1d8() )
    {
        return tradecategory.isfiresale;
    }
    
    return tradecategory.rarity == "Firesale" || tradecategory.rarity == "UltraFiresale";
}

// Namespace br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x2f2750a0, Offset: 0x19f9
// Size: 0x53
function private function_fc747ae1ce4fcdf8( item )
{
    if ( isdefined( item ) && isdefined( level.br_lootiteminfo[ item ] ) && isdefined( level.br_lootiteminfo[ item ].fullweaponname ) )
    {
        return level.br_lootiteminfo[ item ].fullweaponname;
    }
}

// Namespace br_armory_trader
// Params 3, eflags: 0x4
// Checksum 0x7eb40189, Offset: 0x1a55
// Size: 0x119, Type: bool
function private function_92fed7b8109e3902( instance, player, var_1e4805dfc2ca4d77 )
{
    if ( !isdefined( var_1e4805dfc2ca4d77 ) )
    {
        return false;
    }
    
    if ( level.gameended )
    {
        return false;
    }
    
    if ( !player player::isreallyalive() || player.inlaststand )
    {
        return false;
    }
    
    if ( player utility::isusingremote() )
    {
        return false;
    }
    
    if ( player killstreak::isjuggernaut() )
    {
        return false;
    }
    
    if ( player vehicle::is_in_vehicle() )
    {
        return false;
    }
    
    if ( player utility::callsharedfunc( #"gametype", #"playerskipkioskuse", instance ) )
    {
        return false;
    }
    
    if ( player.iscarrying && !isdefined( player.carriable ) )
    {
        player hud_message::showerrormessage( %"MP/CANNOT_USE_GENERIC" );
        return false;
    }
    
    if ( !player function_e9394f84ff66fcbe( var_1e4805dfc2ca4d77 ) )
    {
        return false;
    }
    
    if ( player isthrowinggrenade() )
    {
        return false;
    }
    
    if ( function_39bfcb83a89d1d8() && instance.var_8d18c12b898fde7c[ player getentitynumber() ].var_c8565f9fe327ff15 > gettime() )
    {
        return false;
    }
    
    return true;
}

// Namespace br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x484cd8ac, Offset: 0x1b77
// Size: 0x90, Type: bool
function private function_e9394f84ff66fcbe( var_1e4805dfc2ca4d77 )
{
    if ( !isdefined( var_1e4805dfc2ca4d77.inventorytype ) || var_1e4805dfc2ca4d77 != self getcurrentweapon() && var_1e4805dfc2ca4d77 != self getcurrentprimaryweapon() )
    {
        return false;
    }
    
    if ( var_1e4805dfc2ca4d77.inventorytype != "primary" && var_1e4805dfc2ca4d77.inventorytype != "altmode" )
    {
        return false;
    }
    
    if ( !isvalidcustomweapon( var_1e4805dfc2ca4d77 ) )
    {
        return false;
    }
    
    if ( utility::callsharedfunc( #"royalty", #"hash_39fddefef2334f9b", var_1e4805dfc2ca4d77 ) )
    {
        return false;
    }
    
    return true;
}

// Namespace br_armory_trader
// Params 0, eflags: 0x4
// Checksum 0xe7b2363b, Offset: 0x1c10
// Size: 0x27, Type: bool
function private function_22b1dc23dd6e502()
{
    return level.br_armory_trader.scriptbundle.var_55917d7b36bb02b2 ?? "ks_use_crate_mp";
}

// Namespace br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x359a7779, Offset: 0x1c40
// Size: 0x3d
function private function_f4d4a8c1ab81bc4c( var_1e4805dfc2ca4d77 )
{
    var_51769ec924e670df = [ function_22b1dc23dd6e502(), "none" ];
    return arraycontains( var_51769ec924e670df, var_1e4805dfc2ca4d77.basename );
}

// Namespace br_armory_trader
// Params 1
// Checksum 0x28e8f425, Offset: 0x1c86
// Size: 0x53, Type: bool
function isvalidcustomweapon( weaponobj )
{
    if ( !isdefined( weaponobj ) )
    {
        return false;
    }
    
    if ( !isweapon( weaponobj ) )
    {
        return false;
    }
    
    if ( isnullweapon( weaponobj ) )
    {
        return false;
    }
    
    if ( weapon::isfistweapon( weaponobj ) || weapon::isgunlessweapon( weaponobj ) || class::ismeleeweapon( weaponobj ) )
    {
        return false;
    }
    
    return true;
}

// Namespace br_armory_trader
// Params 6, eflags: 0x4
// Checksum 0xa7042aaa, Offset: 0x1ce2
// Size: 0x66
function private function_cb177db746b3cd89( instance, part, state, player, bautouse, usestring )
{
    var_bd3fe4cccc143820 = isdefined( player.armory_trader_use );
    
    if ( !var_bd3fe4cccc143820 )
    {
        thread function_42c7c65e5643556c( instance, part, state, player, bautouse, usestring );
    }
}

// Namespace br_armory_trader
// Params 6, eflags: 0x4
// Checksum 0x3f117cc4, Offset: 0x1d50
// Size: 0x213
function private function_42c7c65e5643556c( instance, part, state, player, bautouse, usestring )
{
    assert( part == "<dev string:xc0>" );
    var_1e4805dfc2ca4d77 = player function_56ea40c52e695dd9();
    
    if ( !function_92fed7b8109e3902( instance, player, var_1e4805dfc2ca4d77 ) )
    {
        return;
    }
    
    tradecategory = function_8c2ebd731af9da90( instance, player, var_1e4805dfc2ca4d77 );
    tradeoption = function_ca9c76f1ce2839b1( tradecategory );
    
    if ( !isdefined( tradeoption ) )
    {
        return;
    }
    
    player.armory_trader_use = spawnstruct();
    player.armory_trader_use.curprogress = 0;
    player.armory_trader_use.usetime = tradeoption.usetime ?? 0;
    
    if ( function_39bfcb83a89d1d8() && isfiresalecategory( tradecategory ) )
    {
        player.armory_trader_use.usetime = tradeoption.var_90fa9413db1d1193 ?? player.armory_trader_use.usetime;
    }
    
    player.armory_trader_use.usesound = tradeoption.usesound ?? "";
    player.armory_trader_use.var_1e4805dfc2ca4d77 = var_1e4805dfc2ca4d77;
    instance notify( #"hash_827121c08c0ff776" );
    instance thread function_3e97ca5ed7a1e8b7();
    
    if ( state == "visible" )
    {
        instance setscriptablepartstate( "br_armory_trader", "opening" );
    }
    
    if ( player.insertingarmorplate )
    {
        player notify( #"br_try_armor_cancel" );
    }
    
    function_3695836816a5c4ec( player, instance, var_1e4805dfc2ca4d77 );
    result = function_839d046c48b916cf( player, instance );
    
    if ( isdefined( player ) )
    {
        thread function_34fbaa605a1e81d4( player, instance, result );
    }
    
    if ( result )
    {
        player thread function_9ff975d0df86328c( instance, var_1e4805dfc2ca4d77, tradecategory, tradeoption );
    }
    
    player.armory_trader_use = undefined;
}

// Namespace br_armory_trader
// Params 0, eflags: 0x4
// Checksum 0xed031d20, Offset: 0x1f6b
// Size: 0xfe
function private function_3e97ca5ed7a1e8b7()
{
    self endon( #"hash_827121c08c0ff776" );
    self endon( #"disabled" );
    
    for ( totalwait = 0; totalwait < 30 ; totalwait = 0 )
    {
        wait 1.5;
        totalwait += 1.5;
        
        if ( hasplayersnearby( self ) )
        {
        }
    }
    
    self setscriptablepartstate( "br_armory_trader", "closing" );
    self.tradeseed = function_69091e5c7eb90bba();
    
    foreach ( entitynumber, tradedata in self.var_8d18c12b898fde7c )
    {
        tradedata.playerseed = undefined;
        function_1346b9a4f8c24d86( entitynumber );
    }
    
    function_c80bd2a6aebbe44f();
    thread function_e7e383005f8554fe();
}

// Namespace br_armory_trader
// Params 0, eflags: 0x4
// Checksum 0x7cedd693, Offset: 0x2071
// Size: 0x32
function private function_e7e383005f8554fe()
{
    self endon( #"hash_827121c08c0ff776" );
    self endon( #"disabled" );
    
    while ( hasplayersnearby( self ) )
    {
        wait 2;
    }
    
    function_d4920c1870ddd01f( self );
}

// Namespace br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0xe56b8910, Offset: 0x20ab
// Size: 0x31, Type: bool
function private hasplayersnearby( trader )
{
    playersnearby = player_utility::script_getplayersinradius( trader.origin, 1000 );
    return playersnearby.size > 0;
}

// Namespace br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x47de3211, Offset: 0x20e5
// Size: 0xde
function private function_5d2be748a7bdb892( trader )
{
    var_55e1218d57d5246f = trader.origin;
    var_24dbf9af403de793 = getdvarfloat( @"hash_ecd52993b5dab130", 128 ) + 16;
    lootarray = getlootscriptablearrayinradius( undefined, undefined, var_55e1218d57d5246f, var_24dbf9af403de793 );
    var_ed64fb90378a8ad9 = [];
    
    foreach ( loot in lootarray )
    {
        if ( loot.var_db59b634083097b8 )
        {
            continue;
        }
        
        var_ed64fb90378a8ad9[ var_ed64fb90378a8ad9.size ] = loot;
    }
    
    return var_ed64fb90378a8ad9;
}

// Namespace br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0xdd4caff8, Offset: 0x21cc
// Size: 0xa1
function private function_d4920c1870ddd01f( trader )
{
    lootarray = function_5d2be748a7bdb892( trader );
    
    if ( !isdefined( lootarray ) || lootarray.size == 0 )
    {
        return;
    }
    
    foreach ( loot in lootarray )
    {
        common_item::function_869d7676e359a627( loot );
    }
}

// Namespace br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0xdcaab4d2, Offset: 0x2275
// Size: 0x176, Type: bool
function private function_839d046c48b916cf( player, instance )
{
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    instance.id = "weapon_trade";
    instance.userate = player.objectivescaler ?? 1;
    
    while ( isdefined( player ) && player player::isreallyalive() && function_eb71e92cb378da41( player, instance ) && player usebuttonpressed() )
    {
        player.armory_trader_use.curprogress += level.framedurationseconds * instance.userate;
        
        if ( player.armory_trader_use.curprogress >= player.armory_trader_use.usetime )
        {
            player.armory_trader_use.curprogress = 0;
            return true;
        }
        
        player gameobjects::updateuiprogress( instance, 1, player.armory_trader_use );
        waitframe();
    }
    
    if ( isdefined( player ) && isdefined( player.armory_trader_use ) && isdefined( player.armory_trader_use.curprogress ) )
    {
        player.armory_trader_use.curprogress = 0;
    }
    
    return false;
}

// Namespace br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0xcf27410d, Offset: 0x23f4
// Size: 0x1aa, Type: bool
function private function_eb71e92cb378da41( player, instance )
{
    if ( !isdefined( instance ) || !instance.visible )
    {
        return false;
    }
    
    var_81018904b28bca94 = player val::get( "crate_use" );
    
    if ( !var_81018904b28bca94 )
    {
        return false;
    }
    
    if ( !player val::get( "weapon_pickup" ) )
    {
        return false;
    }
    
    if ( !player val::get( "usability" ) )
    {
        return false;
    }
    
    if ( !player player::isreallyalive() )
    {
        return false;
    }
    
    if ( player meleebuttonpressed() )
    {
        return false;
    }
    
    if ( player superbuttonpressed() )
    {
        player hud_message::showerrormessage( "SUPER_MP/SUPER_CANNOT_USE" );
        return false;
    }
    
    if ( player isinexecutionvictim() )
    {
        return false;
    }
    
    if ( player.inlaststand )
    {
        return false;
    }
    
    if ( !isdefined( player.armory_trader_use ) || !player hasweapon( player.armory_trader_use.var_1e4805dfc2ca4d77 ) )
    {
        return false;
    }
    
    var_f3d2a010055df586 = level.br_armory_trader.loadoutsdata.var_fee3e4ef3a29680a >= level.br_armory_trader.loadoutsdata.var_182313cb700457a0;
    
    if ( var_f3d2a010055df586 && player function_76214d3ce13e7912() > 0 )
    {
        player hud_message::showerrormessage( "MP_BR_INGAME/ARMORY_TRADER_EXPIRED" );
        return false;
    }
    
    var_505b5eb1997bccd8 = getdvarfloat( @"hash_9494b56a31216d4c", 128 ) + 16;
    maxdistsquared = var_505b5eb1997bccd8 * var_505b5eb1997bccd8;
    
    if ( distancesquared( player.origin, instance.origin ) > maxdistsquared )
    {
        return false;
    }
    
    return true;
}

// Namespace br_armory_trader
// Params 3, eflags: 0x4
// Checksum 0xe765f0ea, Offset: 0x25a7
// Size: 0x8a
function private function_3695836816a5c4ec( player, instance, var_1e4805dfc2ca4d77 )
{
    player thread function_a6dbac848944a182( var_1e4805dfc2ca4d77 );
    player val::group_set( "TraderUse", 0 );
    instance.id = "weapon_trade";
    player gameobjects::updateuiprogress( instance, 0, player.armory_trader_use );
    playusesound( player, player.armory_trader_use.usesound );
    player.var_a8dc86e019dc2f6c = 1;
}

// Namespace br_armory_trader
// Params 3, eflags: 0x4
// Checksum 0x36e1c9d2, Offset: 0x2639
// Size: 0xac
function private function_34fbaa605a1e81d4( player, instance, result )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    player val::group_reset( "TraderUse" );
    assert( isdefined( player.armory_trader_use ) );
    
    if ( isdefined( instance ) )
    {
        player gameobjects::updateuiprogress( instance, 0, player.armory_trader_use );
        stopusesound( player, player.armory_trader_use.usesound );
    }
    
    player notify( #"hash_3cdd72d228367cf3", result );
    player.var_a8dc86e019dc2f6c = undefined;
}

// Namespace br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0x3ad782e5, Offset: 0x26ed
// Size: 0x28
function private playusesound( player, usesound )
{
    if ( usesound != "" )
    {
        player playlocalsound( usesound );
    }
}

// Namespace br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0xeb0f4e84, Offset: 0x271d
// Size: 0x28
function private stopusesound( player, usesound )
{
    if ( usesound != "" )
    {
        player stoplocalsound( usesound );
    }
}

// Namespace br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0xac690b10, Offset: 0x274d
// Size: 0x5c
function private function_a6dbac848944a182( var_1e4805dfc2ca4d77 )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    weapon_utility::saveweaponstates();
    crateweaponobj = makeweapon( function_22b1dc23dd6e502() );
    inventory_utility::_giveweapon( crateweaponobj );
    thread function_b0307700bd723042( crateweaponobj, var_1e4805dfc2ca4d77 );
    self switchtoweapon( crateweaponobj );
}

// Namespace br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0x3f689331, Offset: 0x27b1
// Size: 0x98
function private function_b0307700bd723042( crateweaponobj, var_1e4805dfc2ca4d77 )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self waittill( #"hash_3cdd72d228367cf3", result );
    
    if ( inventory_utility::isswitchingtoweaponwithmonitoring( crateweaponobj ) )
    {
        inventory_utility::abortmonitoredweaponswitch( crateweaponobj );
        return;
    }
    
    inventory_utility::_takeweapon( crateweaponobj );
    
    if ( !result && isdefined( var_1e4805dfc2ca4d77 ) )
    {
        lastweaponobj = weapon_utility::restoreweaponstates( var_1e4805dfc2ca4d77, 1 );
        self switchtoweapon( lastweaponobj );
        thread inventory_utility::forcevalidweapon( lastweaponobj );
    }
}

// Namespace br_armory_trader
// Params 4, eflags: 0x4
// Checksum 0x77e0fc79, Offset: 0x2851
// Size: 0x192
function private function_9ff975d0df86328c( trader, var_1e4805dfc2ca4d77, tradecategory, tradeoption )
{
    assert( isdefined( tradecategory ) );
    assert( isdefined( tradeoption ) );
    
    if ( isfiresalecategory( tradecategory ) )
    {
        trader.var_2c6d224a61e1fe56[ trader.var_2c6d224a61e1fe56.size ] = self;
    }
    
    tradeitems = trader function_40f89b3f34ba067c( tradecategory, tradeoption, self );
    weaponitem = function_ecdaf2ef1b15efa8( trader, tradeitems );
    var_395baa19e730bd7f = level.br_armory_trader.var_87380520c5182b1a;
    
    if ( var_395baa19e730bd7f )
    {
        removeweapon( var_1e4805dfc2ca4d77 );
    }
    else
    {
        var_395baa19e730bd7f = tradeweapons( var_1e4805dfc2ca4d77, weaponitem );
    }
    
    var_f400b0012bebbf06 = trader function_118993ebca0941ff( self, tradeitems.lootitems, weaponitem, var_395baa19e730bd7f, tradeoption.addextraammo );
    function_57377ac8b3c73bdc( tradeoption );
    function_cc35700dad02b351( tradecategory, var_f400b0012bebbf06, weaponitem );
    challenges::function_6abd79d1a0bdeec9( var_1e4805dfc2ca4d77 );
    
    if ( isdefined( tradeitems.var_5c59d17c3e29aed2 ) || tradecategory.rarity != "Common" || function_39bfcb83a89d1d8() )
    {
        playerentitynumber = self getentitynumber();
        
        if ( isdefined( trader.var_8d18c12b898fde7c[ playerentitynumber ] ) )
        {
            trader.var_8d18c12b898fde7c[ playerentitynumber ].playerseed = undefined;
            trader function_1346b9a4f8c24d86( playerentitynumber );
        }
    }
    
    if ( function_39bfcb83a89d1d8() )
    {
        thread function_c8e2f45f8e8ceba2( trader, tradecategory );
    }
}

// Namespace br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0xae097d75, Offset: 0x29eb
// Size: 0x7a
function private removeweapon( weapon, var_909bdf8623971535 = 1 )
{
    currentweaponindex = item_weapon::function_1464d1c9177c4934( weapon );
    assert( isdefined( currentweaponindex ) );
    
    if ( var_909bdf8623971535 )
    {
        common_item::function_bbba261e6fdc7e52( "weapon", { #dontdrop:1, #weapon:weapon } );
        return;
    }
    
    item_weapon::function_c209a7870d8ab55( currentweaponindex );
    inventory_utility::_takeweapon( weapon );
}

// Namespace br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0xe4275a7, Offset: 0x2a6d
// Size: 0x1b7
function private function_ecdaf2ef1b15efa8( trader, tradeitems )
{
    item = spawnstruct();
    itembundle = undefined;
    
    if ( tradeitems.weaponreward )
    {
        itembundlename = tradeitems.weaponreward;
        itembundle = getscriptbundle( itembundlename );
        item.weaponobj = function_1fb839e25a7e4f84( itembundle.scriptable );
        item.weapondata = item_weapon::function_fdc74b9be99fda2f( item.weaponobj );
        item.weaponname = itembundlename;
    }
    else if ( tradeitems.var_5c59d17c3e29aed2 && tradeitems.var_14c5d5f66eda41ea )
    {
        function_1286dbc85709fb34();
        loadoutweapon = tradeitems.var_5c59d17c3e29aed2;
        itembundle = getscriptbundle( tradeitems.var_14c5d5f66eda41ea );
        item.weaponobj = class::function_fd9078bc5ebdea3e( loadoutweapon.classindex, loadoutweapon.isprimary );
        item.weapondata = item_weapon::function_fdc74b9be99fda2f( item.weaponobj );
        item.weapondata.var_2cb6d045c209a9ff = item.weaponobj;
        item.weaponname = loadoutweapon.weaponbasename;
    }
    
    item.weapondata.count = common_item::function_ea3b3088d82fd357( itembundle, { #weapon:item.weaponobj } );
    item.ammotypebundlename = itembundle.var_eadbff5307e91709;
    return item;
}

// Namespace br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0x9ae00198, Offset: 0x2c2d
// Size: 0x167
function private tradeweapons( var_1e4805dfc2ca4d77, weaponitem )
{
    var_395baa19e730bd7f = 0;
    var_d4d18ee6da9e1720 = weaponitem.weaponobj;
    
    if ( !self hasweapon( var_d4d18ee6da9e1720 ) )
    {
        removeweapon( var_1e4805dfc2ca4d77, 0 );
        
        if ( weaponitem.weapondata.var_2cb6d045c209a9ff )
        {
            item_weapon::function_96add18b226ff731( var_d4d18ee6da9e1720, 1 );
        }
        else
        {
            item_weapon::function_96add18b226ff731( var_d4d18ee6da9e1720, 0, weaponitem.weapondata );
        }
    }
    else
    {
        var_2892566afe02a977 = issameweapon( var_1e4805dfc2ca4d77, var_d4d18ee6da9e1720, 1 );
        
        if ( var_2892566afe02a977 )
        {
            inventory_utility::_switchtoweapon( var_d4d18ee6da9e1720 );
            logtrader( "Received Weapon is the same than primary weapon.", self );
        }
        else
        {
            removeweapon( var_1e4805dfc2ca4d77 );
            inventory_utility::_switchtoweapon( var_d4d18ee6da9e1720 );
            var_395baa19e730bd7f = 1;
            logtrader( "Received Weapon is the same than secondary weapon.", self );
        }
    }
    
    var_e3b2bc06ae7c8f1b = var_1e4805dfc2ca4d77.basename + " (" + var_1e4805dfc2ca4d77.baseweaponlootid + ") ";
    var_7df2fdf3dfb6b0c8 = weaponitem.weaponobj.basename + " (" + weaponitem.weaponobj.baseweaponlootid + ") ";
    logtrader( "Trade Completed - Weapon Traded: " + var_e3b2bc06ae7c8f1b + "--> Weapon Received: " + var_7df2fdf3dfb6b0c8, self );
    return var_395baa19e730bd7f;
}

// Namespace br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x2dc4b163, Offset: 0x2d9d
// Size: 0x4d
function private function_57377ac8b3c73bdc( tradeoption )
{
    if ( br_public::isanytutorialorbotpracticematch() )
    {
        return;
    }
    
    if ( tradeoption.hasscoreevent )
    {
        assert( isxhash( tradeoption.scoreeventref ) );
        thread points::giveunifiedpoints( tradeoption.scoreeventref );
    }
}

// Namespace br_armory_trader
// Params 3, eflags: 0x4
// Checksum 0xaa1ffeaa, Offset: 0x2df2
// Size: 0x129
function private function_cc35700dad02b351( tradecategory, var_f400b0012bebbf06 = [], weaponitem )
{
    var_f400b0012bebbf06[ var_f400b0012bebbf06.size ] = weaponitem.weaponname;
    circleindex = 0;
    
    if ( isdefined( level.br_circle ) && isdefined( level.br_circle.circleindex ) )
    {
        circleindex = level.br_circle.circleindex;
    }
    
    raritystring = function_95ffce3b499fd7f9( weaponitem.weapondata.rarity );
    isfiresale = tradecategory.isfiresale || tradecategory.rarity == "Firesale" || tradecategory.rarity == "UltraFiresale";
    self dlog_recordplayerevent( "dlog_event_armory_trader", [ "receiving_weapon_category", raritystring, "is_firesale", isfiresale, "circle_index", circleindex, "received_items", var_f400b0012bebbf06 ] );
}

// Namespace br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x273e54db, Offset: 0x2f23
// Size: 0xc6
function private function_95ffce3b499fd7f9( traderarity )
{
    switch ( traderarity )
    {
        case 0:
            return "Common";
        case 1:
            return "Uncommon";
        case 2:
            return "Rare";
        case 3:
            return "Epic";
        case 4:
            return "Legendary";
        case 5:
            return "Ultra";
        case 6:
            return "Custom Loadout Trade";
        case 7:
            return "Legendary";
        default:
            assert( 0, "<dev string:xd1>" );
            return "";
    }
}

// Namespace br_armory_trader
// Params 3, eflags: 0x4
// Checksum 0xf230907e, Offset: 0x2ff1
// Size: 0x107
function private function_8c2ebd731af9da90( trader, player, currentweapon = player function_56ea40c52e695dd9() )
{
    assert( player function_e9394f84ff66fcbe( currentweapon ) );
    traderarity = function_8b3df286105e04e3( player, currentweapon );
    
    if ( function_1d263162f04803ec( traderarity ) )
    {
        attachmentcount = function_2d04c21246a0442a( currentweapon );
        attachmentcount = attachmentcount >= 0 ? attachmentcount : 0;
        traderarity = function_fece2e54f76c2761( attachmentcount );
    }
    
    tradecategory = {};
    tradecategory.isfiresale = 0;
    
    if ( trader function_c0e56059b398e6be( player ) )
    {
        if ( function_39bfcb83a89d1d8() )
        {
            tradecategory.isfiresale = 1;
        }
        else
        {
            if ( traderarity == 5 )
            {
                tradecategory.rarity = "UltraFiresale";
            }
            else
            {
                tradecategory.rarity = "Firesale";
            }
            
            return tradecategory;
        }
    }
    
    tradecategory.rarity = function_95ffce3b499fd7f9( traderarity );
    return tradecategory;
}

// Namespace br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x783a835b, Offset: 0x3101
// Size: 0x1b1
function private function_ca9c76f1ce2839b1( tradecategory )
{
    assert( isdefined( level.br_armory_trader.scriptbundle ) );
    assert( isdefined( level.br_armory_trader.scriptbundle.tradeoptions ) );
    tradeoptions = level.br_armory_trader.scriptbundle.tradeoptions;
    
    foreach ( option in tradeoptions )
    {
        foreach ( category in option.tradecategories )
        {
            assert( isdefined( category.rarity ) );
            assert( isstring( category.rarity ) );
            
            if ( category.rarity == tradecategory.rarity && category.isfiresale == tradecategory.isfiresale )
            {
                return option;
            }
        }
    }
}

// Namespace br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0xaf47841b, Offset: 0x32bb
// Size: 0x3b, Type: bool
function private function_8b3df286105e04e3( player, currentweapon = player function_56ea40c52e695dd9() )
{
    return currentweapon.var_e4de3f79b4ac164f ?? player item_weapon::function_fb81bd2fe070faa6( currentweapon );
}

// Namespace br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0x9ff393ce, Offset: 0x32ff
// Size: 0x43
function private sampleseed( seed, sampler )
{
    if ( sampler <= 0 )
    {
        return seed;
    }
    
    return seed > level.br_armory_trader.var_5729bedd26aec764 ? seed >> sampler : seed << sampler;
}

// Namespace br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0xd1cd31e8, Offset: 0x334b
// Size: 0x27
function private function_4de12d162a7f032b( maximum, seed )
{
    randval = seed % maximum;
    return randval;
}

// Namespace br_armory_trader
// Params 3, eflags: 0x4
// Checksum 0xea689bc6, Offset: 0x337b
// Size: 0xba
function private function_8b78cdd0124d2af5( maximum, trader, player )
{
    if ( !isdefined( trader.var_8d18c12b898fde7c[ player getentitynumber() ] ) )
    {
        trader.var_8d18c12b898fde7c[ player getentitynumber() ] = {};
    }
    
    if ( !isdefined( trader.var_8d18c12b898fde7c[ player getentitynumber() ].playerseed ) )
    {
        trader.var_8d18c12b898fde7c[ player getentitynumber() ].playerseed = function_69091e5c7eb90bba();
    }
    
    playerseed = trader.var_8d18c12b898fde7c[ player getentitynumber() ].playerseed;
    return function_4de12d162a7f032b( maximum, playerseed );
}

// Namespace br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0xfb5682ee, Offset: 0x343e
// Size: 0x138
function private function_ca6a53be8b57e404( entrylist, seed )
{
    totalweight = 0;
    
    foreach ( entry in entrylist )
    {
        totalweight += entry.weight;
    }
    
    if ( totalweight <= 0 )
    {
        return;
    }
    
    targetweight = function_4de12d162a7f032b( totalweight, seed );
    currentweight = 0;
    
    foreach ( entry in entrylist )
    {
        currentweight += entry.weight;
        
        if ( currentweight > targetweight )
        {
            return entry;
        }
    }
}

// Namespace br_armory_trader
// Params 3, eflags: 0x4
// Checksum 0x32b003b7, Offset: 0x357f
// Size: 0x125
function private function_40f89b3f34ba067c( tradecategory, tradeoption, player )
{
    assert( isdefined( tradecategory ) );
    assert( isdefined( tradeoption ) );
    traderarity = function_8b3df286105e04e3( player );
    var_4e849c143dda99bd = sampleseed( self.tradeseed, traderarity );
    spawnlistentry = function_ca6a53be8b57e404( tradeoption.spawnlistentries, var_4e849c143dda99bd );
    tradeitems = function_4a8f03af509b1028( spawnlistentry, var_4e849c143dda99bd );
    
    if ( function_466f4191fdbd8fc9( self, player, tradecategory ) )
    {
        loadoutweapon = function_c93fd9a6aa086611( player, traderarity );
        
        if ( loadoutweapon )
        {
            var_14c5d5f66eda41ea = item_weapon::function_3da93a43aae4473d( loadoutweapon.defaultweaponname );
            
            if ( var_14c5d5f66eda41ea )
            {
                tradeitems.var_5c59d17c3e29aed2 = loadoutweapon;
                tradeitems.var_14c5d5f66eda41ea = var_14c5d5f66eda41ea;
                tradeitems.weaponreward = undefined;
            }
        }
    }
    
    assert( isdefined( tradeitems.weaponreward ) || isdefined( tradeitems.var_5c59d17c3e29aed2 ) );
    return tradeitems;
}

// Namespace br_armory_trader
// Params 3, eflags: 0x4
// Checksum 0x64082b4c, Offset: 0x36ad
// Size: 0xb4, Type: bool
function private function_466f4191fdbd8fc9( trader, player, tradecategory )
{
    if ( level.br_armory_trader.loadoutsdata.var_fee3e4ef3a29680a >= level.br_armory_trader.loadoutsdata.var_182313cb700457a0 )
    {
        return false;
    }
    
    if ( isfiresalecategory( tradecategory ) )
    {
        return false;
    }
    
    var_9d2ad70a6bc5869b = int( level.br_armory_trader.loadoutsdata.var_4115b6831cf42a8a * 100 );
    roll = function_8b78cdd0124d2af5( 100, self, player );
    return roll < var_9d2ad70a6bc5869b;
}

// Namespace br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0x958f29a6, Offset: 0x376a
// Size: 0x5c
function private function_c93fd9a6aa086611( player, rarity )
{
    loadoutstable = function_9a9221471c098c48( player );
    
    if ( !loadoutstable[ rarity ] )
    {
        return;
    }
    
    randomloadoutindex = function_8b78cdd0124d2af5( loadoutstable[ rarity ].size, self, player );
    randomloadout = loadoutstable[ rarity ][ randomloadoutindex ];
    return randomloadout;
}

// Namespace br_armory_trader
// Params 5, eflags: 0x4
// Checksum 0x2770cf33, Offset: 0x37cf
// Size: 0x78
function private function_118993ebca0941ff( player, lootitems, weaponitem, var_395baa19e730bd7f, addextraammo )
{
    if ( addextraammo )
    {
        lootitems[ lootitems.size ] = weaponitem.ammotypebundlename;
        lootitems[ lootitems.size ] = weaponitem.ammotypebundlename;
    }
    
    if ( var_395baa19e730bd7f )
    {
        function_3c8cee519dacb397( self, player, lootitems, weaponitem );
    }
    else
    {
        function_3c8cee519dacb397( self, player, lootitems );
    }
    
    return lootitems;
}

// Namespace br_armory_trader
// Params 4, eflags: 0x4
// Checksum 0xf712c29e, Offset: 0x3850
// Size: 0x1b5
function private function_3c8cee519dacb397( trader, player, lootitems, weaponitem )
{
    startorigin = trader.origin + ( 0, 0, 30 );
    endorigin = function_7e1a4a969212afa1( trader, player );
    spawnoptions = common_item::function_f5dfaa3bbdf99a33( endorigin, startorigin );
    spawnoptions.var_9161cf0784b6951d = 0;
    spawnoptions.var_b8402e625c429a31 = 1;
    spawnoptions.var_12d76a8b35ac875d = isdefined( weaponitem ) ? lootitems.size + 1 : lootitems.size;
    spawnoptions.var_aec43e9d95b191f9 = 1;
    spawnoptions.var_2321e933cbdf46d8 = 25;
    spawnoptions.var_34444f0dda11f0d5 = 30;
    spawnoptions.var_8934e0ace9b7d996 = -1;
    spawnoptions.var_8958d2ace9e03584 = 1;
    spawnoptions.var_d72f168a0f299753 = -1;
    spawnoptions.var_d7522c8a0f500f6d = 1;
    
    if ( isdefined( weaponitem ) )
    {
        item_weapon::function_53da2af5697709f8( weaponitem.weaponobj, weaponitem.weapondata, spawnoptions );
    }
    
    foreach ( item in lootitems )
    {
        itembundle = getscriptbundle( item );
        common_item::function_61c2c0251e742ffd( itembundle, undefined, spawnoptions );
    }
}

// Namespace br_armory_trader
// Params 0, eflags: 0x4
// Checksum 0x6d693dda, Offset: 0x3a0d
// Size: 0x85
function private function_1286dbc85709fb34()
{
    level.br_armory_trader.loadoutsdata.var_fee3e4ef3a29680a += 1;
    
    if ( level.br_armory_trader.loadoutsdata.var_fee3e4ef3a29680a >= level.br_armory_trader.loadoutsdata.var_182313cb700457a0 )
    {
        thread function_ec9b55a73ebc969f();
    }
}

// Namespace br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0xacf2a315, Offset: 0x3a9a
// Size: 0x191
function private function_7e1a4a969212afa1( trader, tradingplayer )
{
    gridradius = level.br_armory_trader.pickupgrid.diameter * 0.5;
    targetpos = vectornormalize( trader.origin - tradingplayer.origin );
    targetpos *= gridradius;
    targetpos += tradingplayer.origin;
    dropgrid = sortbydistance( trader.dropgrid, targetpos );
    droppos = undefined;
    
    foreach ( point in dropgrid )
    {
        point_origin = point.curorigin;
        lootarray = getlootscriptablearrayinradius( undefined, undefined, point_origin, gridradius );
        
        if ( !isdefined( lootarray ) || lootarray.size > 0 )
        {
            continue;
        }
        
        playersinradius = getplayersinradius( point_origin, gridradius );
        
        if ( playersinradius.size == 0 || playersinradius.size == 1 && playersinradius[ 0 ] == tradingplayer )
        {
            droppos = point_origin;
            break;
        }
    }
    
    if ( !isdefined( droppos ) )
    {
        droppos = dropgrid[ 0 ].curorigin;
    }
    
    return droppos;
}

// Namespace br_armory_trader
// Params 0, eflags: 0x4
// Checksum 0x366f133a, Offset: 0x3c34
// Size: 0x16f
function private function_9c8a9e076ea384a9()
{
    var_127c9b0e60167fbd = level.br_armory_trader.pickupgrid.diameter;
    gridradius = var_127c9b0e60167fbd * 0.5;
    dropgrid = [];
    forward = anglestoforward( self.angles );
    right = anglestoright( self.angles );
    
    for ( i = -3; i < 3 ; i++ )
    {
        for ( y = 0; y < 3 ; y++ )
        {
            forwarddist = y * var_127c9b0e60167fbd + gridradius + 30;
            rightdist = i * var_127c9b0e60167fbd + gridradius;
            cellcenter = self.origin + forwarddist * forward + rightdist * right;
            
            if ( trace::ray_trace_passed( self.origin + ( 0, 0, 20 ), cellcenter + ( 0, 0, 20 ) ) )
            {
                dropgrid[ dropgrid.size ] = { #curorigin:cellcenter };
                
                /#
                    childthread function_e4646098ad7df713( cellcenter, gridradius, ( 0, 1, 0 ) );
                #/
                
                continue;
            }
            
            /#
                childthread function_e4646098ad7df713( cellcenter, gridradius, ( 1, 0, 0 ) );
            #/
        }
    }
    
    self.dropgrid = dropgrid;
}

// Namespace br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0xb266ef02, Offset: 0x3dab
// Size: 0x42
function private getrarity( itemname )
{
    rarity = undefined;
    splitname = strtok( itemname, "_" );
    
    if ( splitname.size == 2 )
    {
        rarity = int( splitname[ 0 ] );
    }
    
    return rarity;
}

// Namespace br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0x90931246, Offset: 0x3df6
// Size: 0x1ac
function private function_4a8f03af509b1028( spawnlistentry, seed )
{
    listbundle = spawnlistentry.itemspawnlist;
    itemcount = spawnlistentry.itemcount;
    excludeplunder = getdvarint( @"hash_432b2e0461e83498", 1 ) == 0;
    maxreward = 5;
    assert( itemcount <= maxreward, "<dev string:xf0>" + maxreward + "<dev string:x116>" );
    items = common_item::items_selectfromlist( listbundle, itemcount, seed, 1 );
    tradeitems = spawnstruct();
    tradeitems.lootitems = [];
    
    foreach ( item in items )
    {
        typeref = common_item::function_3cba34a99d02cd9( item );
        
        if ( typeref == "weapon" )
        {
            assert( !isdefined( tradeitems.weaponreward ), "<dev string:x149>" );
            tradeitems.weaponreward = item;
            continue;
        }
        
        if ( typeref == "currency" && excludeplunder )
        {
            continue;
        }
        
        tradeitems.lootitems[ tradeitems.lootitems.size ] = item;
    }
    
    assert( isdefined( tradeitems.weaponreward ), "<dev string:x17c>" );
    return tradeitems;
}

// Namespace br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0xb9a6852, Offset: 0x3fab
// Size: 0xbe
function private function_9a9221471c098c48( player )
{
    if ( !isdefined( level.br_armory_trader.loadoutsdata.loadoutstables ) )
    {
        level.br_armory_trader.loadoutsdata.loadoutstables = [];
    }
    
    var_a2e04e5e36250e4b = level.br_armory_trader.loadoutsdata.loadoutstables[ player.guid ];
    
    if ( !var_a2e04e5e36250e4b )
    {
        var_a2e04e5e36250e4b = function_f4cd549286d1f24e( player );
        level.br_armory_trader.loadoutsdata.loadoutstables[ player.guid ] = var_a2e04e5e36250e4b;
    }
    
    return var_a2e04e5e36250e4b;
}

// Namespace br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x33e0634d, Offset: 0x4072
// Size: 0x9c
function private function_f4cd549286d1f24e( player )
{
    loadoutstable = [];
    maxloadouts = player function_74da129dc851b671( level.loadoutdata, "loadouts" );
    
    for ( classindex = 0; classindex < maxloadouts ; classindex++ )
    {
        primaryweaponstruct = player function_5681c7e09a9d3e3e( classindex, 0 );
        secondaryweaponstruct = player function_5681c7e09a9d3e3e( classindex, 1 );
        
        if ( isdefined( primaryweaponstruct ) )
        {
            loadoutstable = function_e5862a9bb88d5259( loadoutstable, primaryweaponstruct );
        }
        
        if ( isdefined( secondaryweaponstruct ) )
        {
            loadoutstable = function_e5862a9bb88d5259( loadoutstable, secondaryweaponstruct );
        }
    }
    
    return loadoutstable;
}

// Namespace br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0x5374b879, Offset: 0x4117
// Size: 0x47
function private function_e5862a9bb88d5259( loadoutstable, loadoutstruct )
{
    rarity = loadoutstruct.rarity;
    
    if ( !isdefined( loadoutstable[ rarity ] ) )
    {
        loadoutstable[ rarity ] = [];
    }
    
    loadoutstable[ rarity ][ loadoutstable[ rarity ].size ] = loadoutstruct;
    return loadoutstable;
}

// Namespace br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0x9bd2f727, Offset: 0x4167
// Size: 0x15e
function private function_5681c7e09a9d3e3e( classindex, weaponindex )
{
    weaponbasename = class::cac_getweapon( classindex, weaponindex );
    
    if ( weaponbasename == "none" )
    {
        return;
    }
    
    loadoutstruct = spawnstruct();
    loadoutstruct.loadoutattachments = [];
    wildcard = class::function_be7cee2ec3dda47a( classindex );
    maxprimaryattachments = weapon::getmaxprimaryattachments( wildcard );
    
    for ( attachmentindex = 0; attachmentindex < maxprimaryattachments ; attachmentindex++ )
    {
        attachmentname = class::cac_getweaponattachment( classindex, weaponindex, attachmentindex );
        
        if ( attachmentname != "none" )
        {
            loadoutstruct.loadoutattachments[ attachmentindex ] = attachmentname;
        }
    }
    
    defaultweaponname = weapon::getdefaultweaponbasename( weaponbasename );
    var_bddacd57effef7aa = weapon::weaponattachremoveextraattachments( loadoutstruct.loadoutattachments );
    attachmentcount = var_bddacd57effef7aa.size;
    rarity = function_fece2e54f76c2761( attachmentcount );
    loadoutstruct.defaultweaponname = defaultweaponname;
    loadoutstruct.attachmentcount = attachmentcount;
    loadoutstruct.weaponbasename = weaponbasename;
    loadoutstruct.isprimary = weaponindex == 0;
    loadoutstruct.classindex = classindex;
    loadoutstruct.rarity = rarity;
    return loadoutstruct;
}

// Namespace br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0x5e513023, Offset: 0x42ce
// Size: 0x270
function private function_c5ce5f386bd733e( player, currentweapon )
{
    if ( function_f4d4a8c1ab81bc4c( currentweapon ) )
    {
        return;
    }
    
    var_e9394f84ff66fcbe = player function_e9394f84ff66fcbe( currentweapon );
    
    if ( !var_e9394f84ff66fcbe )
    {
        player function_84c5d0c2af97f284();
        return;
    }
    
    tradecategory = function_8c2ebd731af9da90( self, player, currentweapon );
    tradeoption = function_ca9c76f1ce2839b1( tradecategory );
    
    if ( !isdefined( tradeoption ) )
    {
        player function_84c5d0c2af97f284();
        return;
    }
    
    traderarity = function_8b3df286105e04e3( player, currentweapon );
    player function_7c9d02c10029c22f( traderarity );
    player function_f07d897b4655f7f9( isfiresalecategory( tradecategory ) );
    tradeitems = function_40f89b3f34ba067c( tradecategory, tradeoption, player );
    chosenitems = tradeitems.lootitems ?? [];
    
    if ( isdefined( tradeitems.weaponreward ) )
    {
        itembundle = getscriptbundlefieldvalues( tradeitems.weaponreward, [ #"ref", #"rarity", #"numattachments" ] );
        weaponlootid = common_item::items_getlootidfromref( itembundle.ref ) ?? 0;
        player function_30ddd8cad5d7cfe1( weaponlootid );
        player function_e61e81746e607886( -1 );
        rarity = itembundle.rarity ?? 0;
        numattachments = itembundle.numattachments ?? 0;
        player function_e1d7898954b29eaa( numattachments );
        player function_368ecb3215028dde( rarity );
    }
    else if ( isdefined( tradeitems.var_5c59d17c3e29aed2 ) )
    {
        loadoutweapon = tradeitems.var_5c59d17c3e29aed2;
        player function_30ddd8cad5d7cfe1( 0 );
        player function_e61e81746e607886( loadoutweapon.classindex );
        player function_882ea2bef7c2919c( loadoutweapon.isprimary );
        player function_368ecb3215028dde( 6 );
        player function_e1d7898954b29eaa( loadoutweapon.attachmentcount );
    }
    
    for ( i = 0; i < 4 ; i++ )
    {
        scriptableid = 0;
        
        if ( chosenitems.size > i )
        {
            item = chosenitems[ i ];
            scriptableid = common_item::function_b01955b20c77371d( item ) ?? 0;
        }
        
        player function_91ddc4ee0b76ff73( scriptableid, i );
    }
    
    return 1;
}

// Namespace br_armory_trader
// Params 0, eflags: 0x4
// Checksum 0x17f10acf, Offset: 0x4547
// Size: 0x58
function private function_84c5d0c2af97f284()
{
    function_30ddd8cad5d7cfe1( 0 );
    function_7c9d02c10029c22f( 0 );
    function_e61e81746e607886( -1 );
    function_e1d7898954b29eaa( 0 );
    function_368ecb3215028dde( 0 );
    function_f07d897b4655f7f9( 0 );
    
    for ( i = 0; i < 4 ; i++ )
    {
        function_91ddc4ee0b76ff73( 0, i );
    }
}

// Namespace br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x5bc2f56e, Offset: 0x45a7
// Size: 0x19
function private function_30ddd8cad5d7cfe1( itemid )
{
    self setclientomnvar( "ui_br_weapon_trader_weapon_loot_id", itemid );
}

// Namespace br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0x3647ef0c, Offset: 0x45c8
// Size: 0x4e
function private function_91ddc4ee0b76ff73( itemid, i )
{
    assert( i < 4 );
    luaindex = i + 1;
    lootomnvar = "ui_br_weapon_trader_loot_id_" + luaindex;
    self setclientomnvar( lootomnvar, itemid );
}

// Namespace br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0xb9e29400, Offset: 0x461e
// Size: 0x1d
function private function_7c9d02c10029c22f( traderarity )
{
    omnvar_utility::function_85d5f88af471ac4b( "ui_br_weapon_trader_data", 0, 4, traderarity );
}

// Namespace br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0xaf79ec1b, Offset: 0x4643
// Size: 0x1e
function private function_e1d7898954b29eaa( attachmentcount )
{
    omnvar_utility::function_85d5f88af471ac4b( "ui_br_weapon_trader_data", 4, 3, attachmentcount );
}

// Namespace br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0xce51def8, Offset: 0x4669
// Size: 0x2f
function private function_e61e81746e607886( classindex )
{
    var_819468ab0e2c8afa = classindex + 1;
    omnvar_utility::function_85d5f88af471ac4b( "ui_br_weapon_trader_data", 7, 4, var_819468ab0e2c8afa );
}

// Namespace br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x5da82801, Offset: 0x46a0
// Size: 0x35
function private function_882ea2bef7c2919c( isprimaryweapon )
{
    value = isprimaryweapon ? 1 : 0;
    omnvar_utility::function_85d5f88af471ac4b( "ui_br_weapon_trader_data", 11, 1, value );
}

// Namespace br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0xca5edc5d, Offset: 0x46dd
// Size: 0x1e
function private function_368ecb3215028dde( weaponrarity )
{
    omnvar_utility::function_85d5f88af471ac4b( "ui_br_weapon_trader_data", 12, 4, weaponrarity );
}

// Namespace br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0xba0c643e, Offset: 0x4703
// Size: 0x35
function private function_f07d897b4655f7f9( isfiresaletrade )
{
    value = isfiresaletrade ? 1 : 0;
    omnvar_utility::function_85d5f88af471ac4b( "ui_br_weapon_trader_data", 16, 1, value );
}

// Namespace br_armory_trader
// Params 0, eflags: 0x4
// Checksum 0xbbc1ca6b, Offset: 0x4740
// Size: 0x1f
function private function_76214d3ce13e7912()
{
    loadoutindex = omnvar_utility::function_feb50abd0ba8a2e7( "ui_br_weapon_trader_data", 7, 4 );
    return loadoutindex;
}

// Namespace br_armory_trader
// Params 0
// Checksum 0xf23b5bf5, Offset: 0x4768
// Size: 0x24, Type: bool
function function_52cecdce1c2bbadb()
{
    return getdvarint( @"scr_ssc_use_armory_trader", 1 ) && getdvarint( @"scr_ssc_enabled", 1 );
}

// Namespace br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0xbd1e099f, Offset: 0x4795
// Size: 0x55
function private function_139d58d75da4222( structname )
{
    var_a206c839beb9c5b8 = utility::getstructarray( structname, "targetname" );
    
    if ( !isdefined( var_a206c839beb9c5b8 ) || var_a206c839beb9c5b8.size < 1 )
    {
        var_a206c839beb9c5b8 = [];
    }
    
    if ( isdefined( level.var_a9394eec627d6fb0 ) )
    {
        var_a206c839beb9c5b8 = [[ level.var_a9394eec627d6fb0 ]]();
    }
    
    return var_a206c839beb9c5b8;
}

// Namespace br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0x10690caa, Offset: 0x47f3
// Size: 0x44
function private function_c7aec6cfb8b72735( structname, var_b9ecd7e28b12d9ad )
{
    if ( !isdefined( level.var_5a0b635dc14e8f3b ) )
    {
        level.var_5a0b635dc14e8f3b = [];
    }
    
    level.var_5a0b635dc14e8f3b[ level.var_5a0b635dc14e8f3b.size ] = var_b9ecd7e28b12d9ad;
    return var_b9ecd7e28b12d9ad;
}

// Namespace br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0xd8d845de, Offset: 0x4840
// Size: 0x159
function private function_32352b571f4a5da5( structname )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( level.var_5a0b635dc14e8f3b ) || level.var_5a0b635dc14e8f3b.size == 0 )
    {
        level.br_armory_trader_enabled = 0;
        return;
    }
    
    level.br_armory_trader.scriptables = [];
    scriptablename = level.br_armory_trader.scriptbundle.var_e6ec0d8042fc6cef ?? "br_armory_trader";
    
    foreach ( loc in level.var_5a0b635dc14e8f3b )
    {
        armorytrader = spawnscriptable( scriptablename, loc.origin, loc.angles );
        function_b81f6930642d83ae( armorytrader );
        level.br_armory_trader.scriptables[ level.br_armory_trader.scriptables.size ] = armorytrader;
    }
    
    level.var_5a0b635dc14e8f3b = undefined;
}

// Namespace br_armory_trader
// Params 1
// Checksum 0xc5bfc206, Offset: 0x49a1
// Size: 0x1d
function traderemp( data )
{
    function_2601f8507bdc2910( self );
    thread function_70894f08764c1558( data );
}

// Namespace br_armory_trader
// Params 1
// Checksum 0xca5ae850, Offset: 0x49c6
// Size: 0x1e3
function function_70894f08764c1558( data )
{
    self notify( #"hash_43030d589d020661" );
    self endon( #"hash_43030d589d020661" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self.isemped = 1;
    
    if ( !isdefined( self.temptrigger ) )
    {
        self.temptrigger = spawn( "trigger_radius", self.origin, 0, level.br_armory_trader.var_7249d71eaa3b2001, 62 );
        trigger::makeenterexittrigger( self.temptrigger, &function_60ff7e371a4c5d7f, &function_14430da24659931b );
        self.temptrigger.endtime = int( gettime() + utility::function_4b74c15943231980( data.time ) );
    }
    else if ( isdefined( self.temptrigger.triggerenterents ) )
    {
        self.temptrigger.endtime = int( gettime() + utility::function_4b74c15943231980( data.time ) );
        
        foreach ( player in self.temptrigger.triggerenterents )
        {
            player lower_message::setlowermessageomnvar( "weapon_trade_station_offline", self.temptrigger.endtime );
        }
    }
    
    wait data.time;
    self [[ self.reactivatefunc ]]( self );
    self.isemped = 0;
    self.temptrigger delete();
}

// Namespace br_armory_trader
// Params 2
// Checksum 0x19b9f638, Offset: 0x4bb1
// Size: 0x91
function function_60ff7e371a4c5d7f( player, trigger )
{
    self endon( #"hash_43030d589d020661" );
    lower_message::setlowermessageomnvar( "weapon_trade_station_offline", trigger.endtime );
    
    for ( timeleft = utility::function_6f5d2e1f1ff70482( trigger.endtime - gettime() ); isdefined( trigger ) && timeleft > 0 ; timeleft = utility::function_6f5d2e1f1ff70482( trigger.endtime - gettime() ) )
    {
        wait timeleft;
    }
    
    waitframe();
    thread function_14430da24659931b( player, trigger );
}

// Namespace br_armory_trader
// Params 2
// Checksum 0x155b4a22, Offset: 0x4c4a
// Size: 0x2d
function function_14430da24659931b( player, trigger )
{
    lower_message::setlowermessageomnvar( "clear_lower_msg" );
    self notify( #"hash_43030d589d020661" );
}

// Namespace br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x6e9c4ac6, Offset: 0x4c7f
// Size: 0x51
function private function_1346b9a4f8c24d86( playerentitynumber )
{
    datastruct = self.var_8d18c12b898fde7c[ playerentitynumber ];
    
    if ( !isdefined( datastruct.playerseed ) && !isdefined( datastruct.var_c8565f9fe327ff15 ) )
    {
        self.var_8d18c12b898fde7c[ playerentitynumber ] = undefined;
    }
}

// Namespace br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0xc3386e57, Offset: 0x4cd8
// Size: 0x118
function private function_c8e2f45f8e8ceba2( trader, tradecategory )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    playerentitynumber = self getentitynumber();
    
    if ( !isdefined( trader.var_8d18c12b898fde7c[ playerentitynumber ] ) )
    {
        trader.var_8d18c12b898fde7c[ playerentitynumber ] = {};
    }
    
    var_eb5d3bf7dda49e97 = trader.var_8d18c12b898fde7c[ playerentitynumber ];
    tradeoption = function_ca9c76f1ce2839b1( tradecategory );
    isfiresale = isfiresalecategory( tradecategory );
    cooldowntime = isfiresale ? tradeoption.var_a253bb0a1b9be019 : tradeoption.cooldowntime;
    
    /#
        cooldowntime = getdvarfloat( @"scr_br_armory_trader_cooldown_time", cooldowntime );
    #/
    
    var_c8565f9fe327ff15 = gettime() + cooldowntime * 1000;
    var_eb5d3bf7dda49e97.var_c8565f9fe327ff15 = var_c8565f9fe327ff15;
    self setclientomnvar( "ui_br_weapon_trader_cooldown_end_time", int( var_c8565f9fe327ff15 ) );
    wait cooldowntime;
    function_9d100061fddd2b97( trader, playerentitynumber );
}

// Namespace br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0xfeb5f7f8, Offset: 0x4df8
// Size: 0xae
function private function_9d100061fddd2b97( trader, playerentitynumber )
{
    var_eb5d3bf7dda49e97 = trader.var_8d18c12b898fde7c[ playerentitynumber ];
    var_c8565f9fe327ff15 = var_eb5d3bf7dda49e97.var_c8565f9fe327ff15;
    
    if ( var_c8565f9fe327ff15 <= gettime() )
    {
        var_eb5d3bf7dda49e97.var_c8565f9fe327ff15 = undefined;
        trader function_1346b9a4f8c24d86( playerentitynumber );
        
        if ( isdefined( trader.proximitytrigger.playersintrigger[ playerentitynumber ] ) )
        {
            player = trader.proximitytrigger.playersintrigger[ playerentitynumber ];
            player setclientomnvar( "ui_br_weapon_trader_cooldown_end_time", 0 );
        }
    }
}

// Namespace br_armory_trader
// Params 1, eflags: 0x4
// Checksum 0x721a385f, Offset: 0x4eae
// Size: 0x1c
function private logdebug( message )
{
    println( "<dev string:x1a1>" + message );
}

// Namespace br_armory_trader
// Params 2, eflags: 0x4
// Checksum 0xf569ff65, Offset: 0x4ed2
// Size: 0x5c
function private logtrader( message, player = undefined )
{
    var_4c2b02d3b1130043 = "";
    
    if ( player )
    {
        var_4c2b02d3b1130043 = "(" + player.name + ") ";
    }
    
    logstring( "[WTS] " + var_4c2b02d3b1130043 + message );
}

/#

    // Namespace br_armory_trader
    // Params 0, eflags: 0x4
    // Checksum 0xaa8b5a1d, Offset: 0x4f36
    // Size: 0x8b, Type: dev
    function private function_bf44a755fac7a602()
    {
        level endon( #"game_ended" );
        self endon( #"death" );
        self endon( #"disabled" );
        
        if ( !getdvarint( @"hash_bc995f12b4b8569c", 0 ) )
        {
            return;
        }
        
        wait 30;
        
        while ( true )
        {
            level.br_armory_trader.pickupgrid.diameter = getdvarfloat( @"hash_dc652c49d7d25622", 60 );
            self notify( #"hash_6074a92623b8d6e4" );
            waitframe();
            function_9c8a9e076ea384a9();
            wait 5;
        }
    }

    // Namespace br_armory_trader
    // Params 3, eflags: 0x4
    // Checksum 0xb7f6caa, Offset: 0x4fc9
    // Size: 0x69, Type: dev
    function private function_e4646098ad7df713( origin, radius, color )
    {
        level endon( #"game_ended" );
        self endon( #"hash_6074a92623b8d6e4" );
        
        if ( !getdvarint( @"hash_bc995f12b4b8569c", 0 ) )
        {
            return;
        }
        
        while ( true )
        {
            level thread utility::draw_circle( origin, radius, color, 1, 0, 10 );
            waitframe();
        }
    }

    // Namespace br_armory_trader
    // Params 2, eflags: 0x4
    // Checksum 0x39083ab2, Offset: 0x503a
    // Size: 0x4a0, Type: dev
    function private function_14b882f27766cd37( command, args )
    {
        if ( args.size == 0 )
        {
            return;
        }
        
        if ( command != "<dev string:x1a8>" )
        {
            return;
        }
        
        command = args[ 0 ];
        
        if ( !isdefined( level.player ) )
        {
            return;
        }
        
        switch ( command )
        {
            case #"hash_a77b6fb5f22c9db8":
                closesttrader = function_80d63ccf6865839f( level.player.origin );
                
                if ( isdefined( closesttrader ) && closesttrader.visible )
                {
                    function_2601f8507bdc2910( closesttrader );
                }
                
                break;
            case #"hash_b37256f1c926a2e3":
                closesttrader = function_80d63ccf6865839f( level.player.origin );
                
                if ( isdefined( closesttrader ) && closesttrader.disabled )
                {
                    function_3f0c4320f3b3b802( closesttrader );
                }
                
                break;
            case #"hash_6c4c3516ab5ce943":
                rarity = 0;
                
                if ( isdefined( args[ 1 ] ) )
                {
                    rarity = int( args[ 1 ] );
                }
                
                loadoutstable = function_f4cd549286d1f24e( level.player );
                
                if ( !loadoutstable[ rarity ] )
                {
                    return;
                }
                
                randomloadoutindex = randomint( loadoutstable[ rarity ].size );
                loadoutweapon = loadoutstable[ rarity ][ randomloadoutindex ];
                
                if ( !loadoutweapon )
                {
                    return;
                }
                
                weaponobj = level.player class::function_fd9078bc5ebdea3e( loadoutweapon.classindex, loadoutweapon.isprimary );
                
                if ( !weaponobj )
                {
                    return;
                }
                
                var_395baa19e730bd7f = getdvarint( @"hash_ca9c6ca232a34f7e", 0 ) > 0;
                
                if ( var_395baa19e730bd7f )
                {
                    spawnoptions = common_item::items_initspawnoptions_spawnfromentity( level.player );
                    weapondata = item_weapon::function_fdc74b9be99fda2f( weaponobj );
                    weapondata.var_2cb6d045c209a9ff = weaponobj;
                    item_weapon::function_53da2af5697709f8( weaponobj, weapondata, spawnoptions );
                }
                else
                {
                    level.player item_weapon::function_96add18b226ff731( weaponobj, 1 );
                }
                
                break;
            case #"hash_82dd7c3e206217c2":
                iteration = 50000;
                rollchance = 2;
                min = 0;
                max = 3;
                range = max - min;
                minvalue = undefined;
                maxvalue = undefined;
                successcount = 0;
                
                for ( i = 0; i < iteration ; i++ )
                {
                    seed = i;
                    randval = min + seed % range;
                    
                    if ( !isdefined( minvalue ) || randval < minvalue )
                    {
                        minvalue = randval;
                    }
                    
                    if ( !isdefined( maxvalue ) || randval > maxvalue )
                    {
                        maxvalue = randval;
                    }
                    
                    if ( randval < rollchance )
                    {
                        successcount += 1;
                    }
                }
                
                var_bea82467c66f9e61 = successcount / iteration;
                break;
            case #"hash_6176b08b00c3850b":
                foreach ( armorytrader in level.br_armory_trader.scriptables )
                {
                    armorytrader.tradeseed = function_69091e5c7eb90bba();
                    
                    foreach ( entitynumber, tradedata in armorytrader.var_8d18c12b898fde7c )
                    {
                        tradedata.playerseed = undefined;
                        armorytrader function_1346b9a4f8c24d86( entitynumber );
                    }
                    
                    armorytrader function_c80bd2a6aebbe44f();
                }
                
                break;
            case #"hash_667d3aa56a7d5e2c":
                foreach ( armorytrader in level.br_armory_trader.scriptables )
                {
                    function_d4920c1870ddd01f( armorytrader );
                }
                
                break;
        }
    }

#/
