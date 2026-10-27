// scripts\mp\common\equipment\hb_sensor.gsc  (hash_07bb4ef26531a632.gscc) (size: 7295 Bytes / 0x1c7f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7380de3 (121114083)
// size ...... 7295 (0x1c7f)
// includes .. 6   (offset: 0x1af7)
// strings ... 19  (offset: 0x1b27)
// dev strs .. 0   (offset: 0x1c7f)
// exports ... 22  (offset: 0x1093)
// cseg ...... 0x1c6 + 0xecd (0x1093)
// imports ... 58  (offset: 0x1403)
// animtree1 . 0   (offset: 0x1c7f)
// animtree2 . 0   (offset: 0x1c7f)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\common\utility\teams;
#using scripts\mp\equipment;
#using scripts\mp\weapons;

#namespace hb_sensor_equipment;

// Namespace hb_sensor_equipment
// Params 0, eflags: 0x1
// Checksum 0x5862eebb, Offset: 0x1e4
// Size: 0x101
function autoexec hb_sensor_init()
{
    utility::flag_wait( "equipment_initialized" );
    weapons::registerusedcallback( "hb_sensor", &hb_sensor_used );
    equipment_mp::registercallback( "equip_hb_sensor", "onGive", &function_5ccccb24113d47ee );
    equipment_mp::registercallback( "super_hb_sensor", "onGive", &function_5ccccb24113d47ee );
    equipment_mp::registercallback( "equip_hb_sensor", "onTake", &hb_sensor_ontake );
    equipment_mp::registercallback( "super_hb_sensor", "onIncrement", &function_e05b05fda22816d2 );
    equipment_mp::registercallback( "equip_hb_sensor", "equipmentDurabilitySet", &function_567ca388ed18e28c );
    equipment_mp::registercallback( "equip_hb_sensor", "equipmentDurabilityGet", &function_4bae610387dbbea0 );
    equipment_mp::registercallback( "equip_hb_sensor", "onIncrement", &function_b595588daa6c9de6 );
    callback::add( #"player_spawned", &onspawnplayer );
    thread utility::callsharedfunc( #"analytics", #"hash_eb9d0dae8f38111f", { #var_e7d8089975495767:1, #equipref:"equip_hb_sensor" } );
}

// Namespace hb_sensor_equipment
// Params 1
// Checksum 0x3347099e, Offset: 0x2ed
// Size: 0x106
function hb_sensor_used( grenade )
{
    if ( isdefined( self.equipment[ "secondary" ] ) && self.equipment[ "secondary" ] != "equip_hb_sensor" )
    {
        return;
    }
    
    utility::flag_init( "equipment_interact" );
    self.var_a75a6799ad426422 = undefined;
    
    if ( isdefined( self.var_1dafc1ca636850a ) )
    {
        self.var_1dafc1ca636850a -= 0.1;
        
        if ( self.var_1dafc1ca636850a <= 0 )
        {
            self.var_1dafc1ca636850a = 0;
        }
        
        batteryduration = function_284b2531bd722ce0();
        percentageremaining = int( ceil( ( batteryduration - self.var_1dafc1ca636850a ) * 100 / batteryduration ) );
        function_19599dd83bca3a9( percentageremaining );
    }
    
    waitframe();
    self function_2c796b5cbe343df3( 0 );
    
    if ( isdefined( grenade ) )
    {
        grenade delete();
    }
    
    if ( isdefined( self.perks[ "specialty_recharge_equipment" ] ) )
    {
        thread function_5c6a4381a4fec9a4();
    }
    
    self notify( #"hb_sensor_put_away" );
}

// Namespace hb_sensor_equipment
// Params 0
// Checksum 0xa8d93fb7, Offset: 0x3fb
// Size: 0x62
function function_f54fdd1814b93b77()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        self waittill( #"grenade_pullback", objweapon );
        self function_d35b7b585d7fc266( 0 );
        
        while ( self getheldoffhand() == objweapon && !self function_a6d700f2335edc93() )
        {
            waitframe();
        }
        
        self function_2c796b5cbe343df3( 0 );
    }
}

// Namespace hb_sensor_equipment
// Params 4
// Checksum 0xe9547251, Offset: 0x465
// Size: 0x1bb
function function_5ccccb24113d47ee( equipmentref, slot, variantid, attachments )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hb_sensor_take" );
    self notify( #"hash_be5cbec9c1783654" );
    
    if ( isdefined( self.equipment[ "secondary" ] ) && self.equipment[ "secondary" ] != "equip_hb_sensor" )
    {
        return;
    }
    
    thread hb_sensor_monitordeath();
    
    if ( !isbrgamemode() )
    {
        self.var_1dafc1ca636850a = 0;
        self.var_1ed4fc9841bf1257 = function_4bae610387dbbea0();
    }
    
    if ( getcodegate( #"hash_854daa427ff31edd" ) )
    {
        thread function_f54fdd1814b93b77();
    }
    
    while ( true )
    {
        self waittill( #"grenade_pullback", objweapon );
        utility::flag_set( "equipment_interact" );
        
        if ( !issubstr( objweapon.basename, "hb_sensor" ) )
        {
            continue;
        }
        
        if ( !getdvarvalue( @"hash_90cb12311244a0ff", 0 ) )
        {
            self function_d35b7b585d7fc266( 0 );
        }
        
        percentageremaining = 100;
        
        if ( isdefined( self.var_1dafc1ca636850a ) )
        {
            batteryduration = function_284b2531bd722ce0();
            percentageremaining = int( ceil( ( batteryduration - self.var_1dafc1ca636850a ) * 100 / batteryduration ) );
        }
        
        function_19599dd83bca3a9( percentageremaining );
        self.var_a75a6799ad426422 = 1;
        wait 0.533;
        function_3e15abad72c4b571();
        
        if ( getdvarvalue( @"hash_90cb12311244a0ff", 0 ) )
        {
            while ( self getheldoffhand() == objweapon && !self function_a6d700f2335edc93() )
            {
                waitframe();
            }
            
            self function_2c796b5cbe343df3( 0 );
        }
    }
}

// Namespace hb_sensor_equipment
// Params 2
// Checksum 0xff012819, Offset: 0x628
// Size: 0x28
function hb_sensor_ontake( equipmentref, slot )
{
    self notify( #"hb_sensor_take" );
    function_445b5c956f3d4c19();
}

// Namespace hb_sensor_equipment
// Params 0
// Checksum 0xe12fcbb6, Offset: 0x658
// Size: 0x2e
function hb_sensor_monitordeath()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self waittill( #"death" );
    function_445b5c956f3d4c19();
}

// Namespace hb_sensor_equipment
// Params 0
// Checksum 0x58ef7ad1, Offset: 0x68e
// Size: 0x41
function function_4bae610387dbbea0()
{
    batteryduration = function_284b2531bd722ce0();
    secondsused = self.var_1dafc1ca636850a;
    
    if ( !isdefined( secondsused ) )
    {
        secondsused = 0;
    }
    
    return int( ceil( ( batteryduration - secondsused ) * 100 / batteryduration ) );
}

// Namespace hb_sensor_equipment
// Params 1
// Checksum 0x8d02a3fc, Offset: 0x6d8
// Size: 0x42, Type: bool
function function_567ca388ed18e28c( quantity )
{
    self.var_1ed4fc9841bf1257 = quantity;
    batteryduration = function_284b2531bd722ce0();
    self.var_1dafc1ca636850a = quantity * -1 * batteryduration / 100 + batteryduration;
    return true;
}

// Namespace hb_sensor_equipment
// Params 2
// Checksum 0xc8e90652, Offset: 0x723
// Size: 0x1c
function function_b595588daa6c9de6( equipmentref, currammo )
{
    function_46167b682270b34e();
}

// Namespace hb_sensor_equipment
// Params 0
// Checksum 0x3a4fc608, Offset: 0x747
// Size: 0x3c
function function_445b5c956f3d4c19()
{
    self.var_a75a6799ad426422 = undefined;
    self.var_1dafc1ca636850a = undefined;
    self.var_1ed4fc9841bf1257 = undefined;
    utility::flag_clear( "equipment_interact" );
    function_19599dd83bca3a9( 100 );
    self function_2c796b5cbe343df3( 0 );
}

// Namespace hb_sensor_equipment
// Params 0
// Checksum 0x92e7eaee, Offset: 0x78b
// Size: 0x31e
function function_53aeae39d10c0cf5()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    bundle = level.equipment.table[ "equip_hb_sensor" ].bundle;
    initialdelay = ( bundle.hb_sensor_initial_delay ?? 1000 ) / 1000;
    var_a16c503a95b6021a = bundle.var_7b4b2a9cebe9df1a ?? 1000;
    sweepduration = bundle.var_ca51ae9d094216d9 ?? 1000;
    interval = ( var_a16c503a95b6021a + sweepduration ) / 1000;
    maxrange = bundle.hb_sensor_max_range ?? 600;
    maxrangesq = maxrange * maxrange;
    maxangle = bundle.hb_sensor_max_angle ?? 90;
    wait initialdelay;
    
    while ( self.var_a75a6799ad426422 )
    {
        if ( self.var_c955570c17a0fd70 )
        {
            waitframe();
            continue;
        }
        
        enemies = teams::getenemyplayers( self.team, 1 );
        
        foreach ( enemy in enemies )
        {
            if ( isdefined( enemy.perks[ "specialty_heartbreaker" ] ) )
            {
                if ( enemy.var_3895bbf4213f181 )
                {
                    enemy.var_3895bbf4213f181 = 0;
                }
                
                continue;
            }
            
            distancesq = distance2dsquared( self.origin, enemy.origin );
            
            if ( distancesq > maxrangesq )
            {
                if ( enemy.var_3895bbf4213f181 )
                {
                    enemy.var_3895bbf4213f181 = 0;
                }
                
                continue;
            }
            
            var_4a9ad3c61741e832 = enemy.origin - self.origin;
            var_69c355f2b45ce5a5 = vectortoyaw( var_4a9ad3c61741e832 );
            angledelta = angleclamp180( self.angles[ 1 ] - var_69c355f2b45ce5a5 );
            
            if ( abs( angledelta ) >= maxangle )
            {
                if ( enemy.var_3895bbf4213f181 )
                {
                    enemy.var_3895bbf4213f181 = 0;
                }
                
                continue;
            }
            
            challengeparams = { #effectref:"pulsed", #sweepduration:sweepduration, #equipmentref:"equip_hb_sensor", #equipmentent:self getheldoffhand(), #victim:enemy, #attacker:self };
            callback::callback( #"hash_10e686549630fd9f", challengeparams );
            enemy.var_25ed22d5b74cd234[ self getentitynumber() ] = gettime();
            enemy.var_3895bbf4213f181 = 1;
            enemy thread function_4e182dbc7c2e3e79();
        }
        
        wait interval;
    }
}

// Namespace hb_sensor_equipment
// Params 0
// Checksum 0x49b8eb88, Offset: 0xab1
// Size: 0xf4
function function_3e15abad72c4b571()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    thread function_53aeae39d10c0cf5();
    
    if ( !isdefined( self.var_1dafc1ca636850a ) )
    {
        self.var_1dafc1ca636850a = 0;
    }
    
    counter = 0;
    batteryduration = function_284b2531bd722ce0();
    var_2890b6843ecdbe9c = batteryduration / 100;
    
    while ( self.var_a75a6799ad426422 )
    {
        self.var_1ed4fc9841bf1257 = function_4bae610387dbbea0();
        
        if ( self.var_1ed4fc9841bf1257 < 0 )
        {
            self.var_1ed4fc9841bf1257 = 0;
        }
        
        function_19599dd83bca3a9( self.var_1ed4fc9841bf1257 );
        
        if ( counter >= var_2890b6843ecdbe9c )
        {
            self.var_1dafc1ca636850a += counter;
            counter = 0;
        }
        
        if ( self.var_1ed4fc9841bf1257 <= 0 )
        {
            thread function_4c6941536519b01e();
            break;
        }
        
        counter += 0.05;
        wait 0.05;
    }
}

// Namespace hb_sensor_equipment
// Params 0
// Checksum 0x94a55838, Offset: 0xbad
// Size: 0xeb
function function_4c6941536519b01e()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    utility::flag_clear( "equipment_interact" );
    bundle = level.equipment.table[ "equip_hb_sensor" ].bundle;
    var_67125e934bcc57e = weapon::getgrenadeinpullback();
    
    if ( isdefined( var_67125e934bcc57e ) )
    {
        result = utility::waittill_notify_or_timeout_return( "hb_sensor_put_away", 1 );
        
        if ( result == "timeout" )
        {
            self releaseoffhand();
        }
        
        if ( !isdefined( self.perks[ "specialty_recharge_equipment" ] ) )
        {
            ammo = equipment_mp::getequipmentammo( "equip_hb_sensor" );
            equipment_mp::setequipmentammo( "equip_hb_sensor", ammo - 1 );
        }
    }
    
    if ( !isdefined( self.perks[ "specialty_recharge_equipment" ] ) )
    {
        function_445b5c956f3d4c19();
    }
}

// Namespace hb_sensor_equipment
// Params 0
// Checksum 0x33daee4b, Offset: 0xca0
// Size: 0x161
function function_5c6a4381a4fec9a4()
{
    bundle = level.equipment.table[ "equip_hb_sensor" ].bundle;
    
    if ( !isdefined( level.var_6be22fc94dc3b131 ) )
    {
        return;
    }
    
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_be5cbec9c1783654" );
    
    while ( !self.var_a75a6799ad426422 && isdefined( self.var_1dafc1ca636850a ) )
    {
        if ( isdefined( self.perks[ "specialty_recharge_equipment" ] ) && bundle.var_1f68c63d726f04ca )
        {
            self.var_1dafc1ca636850a -= bundle.var_b2a0c3f6fe0e873 * level.framedurationseconds;
        }
        else
        {
            self.var_1dafc1ca636850a -= level.var_6be22fc94dc3b131 * level.framedurationseconds;
        }
        
        batteryduration = function_284b2531bd722ce0();
        percentageremaining = int( clamp( ceil( ( batteryduration - self.var_1dafc1ca636850a ) * 100 / batteryduration ), 0, 100 ) );
        function_19599dd83bca3a9( percentageremaining );
        
        if ( self.var_1dafc1ca636850a <= 0 )
        {
            self.var_1dafc1ca636850a = 0;
            self notify( #"hash_be5cbec9c1783654" );
            break;
        }
        
        waitframe();
    }
}

// Namespace hb_sensor_equipment
// Params 0
// Checksum 0x8e9bbf20, Offset: 0xe09
// Size: 0x42, Type: bool
function function_46167b682270b34e()
{
    if ( !isdefined( self.var_1dafc1ca636850a ) || self.var_1dafc1ca636850a <= 0 )
    {
        return false;
    }
    
    function_19599dd83bca3a9( 100 );
    self.var_1dafc1ca636850a = 0;
    self notify( #"hash_be5cbec9c1783654" );
    return true;
}

// Namespace hb_sensor_equipment
// Params 0
// Checksum 0xa902f8b3, Offset: 0xe54
// Size: 0x22
function function_37359c6114085c3e()
{
    if ( !self.var_a75a6799ad426422 )
    {
        self notify( #"hash_be5cbec9c1783654" );
        thread function_5c6a4381a4fec9a4();
    }
}

// Namespace hb_sensor_equipment
// Params 2
// Checksum 0x2385faaa, Offset: 0xe7e
// Size: 0x1e
function function_e05b05fda22816d2( ref, currammo )
{
    function_567ca388ed18e28c( 100 );
}

// Namespace hb_sensor_equipment
// Params 0
// Checksum 0xa76c3d40, Offset: 0xea4
// Size: 0x83
function function_284b2531bd722ce0()
{
    bundle = level.equipment.table[ "equip_hb_sensor" ].bundle;
    
    if ( isdefined( self.perks[ "specialty_extra_tactical" ] ) )
    {
        return ( bundle.var_84b2516772944c67 ?? getdvarint( @"hash_952c250389735fd7", 60 ) );
    }
    
    return bundle.var_8eb6aa1aab340796 ?? getdvarint( @"hash_3d0928eec520c586", 60 );
}

// Namespace hb_sensor_equipment
// Params 1
// Checksum 0x97f0ea76, Offset: 0xf2f
// Size: 0xde
function function_19599dd83bca3a9( percentageremaining )
{
    bundle = level.equipment.table[ "equip_hb_sensor" ].bundle;
    self setclientomnvar( "ui_hb_sensor_battery_percentage", percentageremaining );
    
    if ( isdefined( bundle ) && isdefined( bundle.var_879d1822f05140c5 ) && bundle.var_75ce16c859d7fbc4 && bundle.var_879d1822f05140c5 != "" )
    {
        recharge_progress = percentageremaining / 100;
        self setclientomnvar( level.var_da3017a94abb375a[ bundle.var_879d1822f05140c5 ], recharge_progress );
        self setpowerprogress( bundle.var_879d1822f05140c5, recharge_progress );
    }
    
    if ( self.var_3702583f19e5f23b.size > 0 )
    {
        self setclientomnvar( "ui_hb_sensor_battery_percentage", 0 );
    }
}

// Namespace hb_sensor_equipment
// Params 1
// Checksum 0xf9e8d7da, Offset: 0x1015
// Size: 0x22
function onspawnplayer( spawndata )
{
    if ( self.var_3895bbf4213f181 )
    {
        self.var_3895bbf4213f181 = 0;
    }
}

// Namespace hb_sensor_equipment
// Params 0
// Checksum 0xb5018010, Offset: 0x103f
// Size: 0x54
function function_4e182dbc7c2e3e79()
{
    self notify( #"hash_b1b850603285154" );
    self endon( #"hash_b1b850603285154" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        wait 5;
        
        if ( self.var_3895bbf4213f181 )
        {
            self.var_3895bbf4213f181 = 0;
        }
        
        return;
    }
}

