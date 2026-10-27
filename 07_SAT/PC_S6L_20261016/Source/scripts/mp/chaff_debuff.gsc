// scripts\mp\chaff_debuff.gsc  (hash_176a23bf33ecb7df.gscc) (size: 9881 Bytes / 0x2699 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6fe0065a (1876952666)
// size ...... 9881 (0x2699)
// includes .. 5   (offset: 0x2545)
// strings ... 14  (offset: 0x256d)
// dev strs .. 10  (offset: 0x2621)
// exports ... 42  (offset: 0x1839)
// cseg ...... 0x15a + 0x16df (0x1839)
// imports ... 51  (offset: 0x1ec9)
// animtree1 . 0   (offset: 0x2699)
// animtree2 . 0   (offset: 0x2699)
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\weapon;
#using scripts\mp\common\utility\player;
#using scripts\mp\vehicles\vehicle_hack;

#namespace chaff_debuff;

// Namespace chaff_debuff
// Params 0
// Checksum 0x11d1bf0c, Offset: 0x178
// Size: 0x38
function chaff_debuff_init()
{
    if ( utility::issharedfuncdefined( #"chaff", #"init" ) )
    {
        [[ utility::getsharedfunc( #"chaff", #"init" ) ]]();
    }
}

// Namespace chaff_debuff
// Params 2
// Checksum 0x9cce30d5, Offset: 0x1b8
// Size: 0x6c
function function_97b81cce56e58a2b( data, time )
{
    if ( level.gameended )
    {
        return;
    }
    
    if ( !isdefined( time ) || time <= 0 )
    {
        time = 8;
    }
    
    function_9c5a197251fae8e9( data );
    function_3cfc15c8035560c6( data, time );
    
    if ( isdefined( data.victim ) )
    {
        data.victim remove_chaff();
    }
}

// Namespace chaff_debuff
// Params 1
// Checksum 0x7cc0161c, Offset: 0x22c
// Size: 0x71
function function_caf3a923c2bb98d5( data )
{
    chaffcount = data.victim function_4ae66efe2d06fde4();
    
    if ( chaffcount <= 1 || data.victim.isdestroyed )
    {
        data.victim clear_chaff();
        return;
    }
    
    data.victim remove_chaff();
}

// Namespace chaff_debuff
// Params 0
// Checksum 0x36c06046, Offset: 0x2a5
// Size: 0x19
function function_18822524b5dbcf8()
{
    level utility::waittill_any( "game_ended", "round_end_finished", "start_game_ended" );
}

// Namespace chaff_debuff
// Params 2
// Checksum 0x609a33ec, Offset: 0x2c6
// Size: 0x5a
function function_3cfc15c8035560c6( data, time )
{
    data.victim endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    data.victim utility::waittill_any_timeout( time, "chaff_cleared", "death", "player_killed_no_faux_death" );
}

// Namespace chaff_debuff
// Params 1
// Checksum 0xd02cd0e9, Offset: 0x328
// Size: 0x2f2
function function_9c5a197251fae8e9( data )
{
    assert( isdefined( data ), "<dev string:x24>" );
    assert( isdefined( data.attacker ), "<dev string:x47>" );
    assert( isdefined( data.victim ), "<dev string:x75>" );
    
    if ( isdefined( self.perks[ "specialty_chaff_immunity" ] ) )
    {
        return;
    }
    
    assert( isdefined( data.objweapon ), "<dev string:xa1>" );
    assert( isweapon( data.objweapon ), "<dev string:xd0>" );
    
    if ( !isdefined( data.damage ) )
    {
        data.damage = 1;
    }
    
    if ( !isdefined( data.meansofdeath ) )
    {
        data.meansofdeath = "MOD_EXPLOSIVE";
    }
    
    if ( !isdefined( data.point ) )
    {
        data.point = ( 0, 0, 0 );
    }
    
    if ( !isdefined( data.direction_vec ) )
    {
        data.direction_vec = ( 0, 0, 0 );
    }
    
    if ( !isdefined( data.modelname ) )
    {
        data.modelname = 0;
    }
    
    if ( !isdefined( data.partname ) )
    {
        data.partname = "";
    }
    
    if ( !isdefined( data.tagname ) )
    {
        data.tagname = 0;
    }
    
    if ( !isdefined( data.damageflags ) )
    {
        data.damageflags = 0;
    }
    
    if ( !isdefined( data.hitloc ) )
    {
        data.hitloc = "none";
    }
    
    if ( !isdefined( data.timeoffset ) )
    {
        data.timeoffset = 0;
    }
    
    if ( !isdefined( data.victim.chaffcount ) )
    {
        data.victim.chaffcount = 0;
    }
    
    data.victim.chaffcount++;
    
    if ( data.victim.chaffcount == 1 )
    {
        if ( isplayer( data.victim ) )
        {
            data.victim thread function_622251f36e4c8a3( data );
        }
        
        chaffstartcallback = function_a23ffb8cbea19ede( data.victim );
        
        if ( chaffstartcallback )
        {
            data.victim thread [[ chaffstartcallback ]]( data );
        }
        
        data.victim notify( #"chaff_started", data );
    }
    
    if ( isdefined( data.victim.var_65a9d2532604aa9f ) )
    {
        data.victim thread [[ data.victim.var_65a9d2532604aa9f ]]( data );
    }
    
    data.victim notify( #"chaff_applied", data );
}

// Namespace chaff_debuff
// Params 0
// Checksum 0x8010321d, Offset: 0x622
// Size: 0x57
function remove_chaff()
{
    if ( !isdefined( self.chaffcount ) )
    {
        return;
    }
    
    self.chaffcount--;
    
    if ( isdefined( self.var_be9a70e97adc8313 ) )
    {
        self thread [[ self.var_be9a70e97adc8313 ]]();
    }
    
    self notify( #"chaff_removed" );
    
    if ( self.chaffcount == 0 )
    {
        clear_chaff( 0 );
    }
}

// Namespace chaff_debuff
// Params 1
// Checksum 0xfa1cd0d0, Offset: 0x681
// Size: 0x65
function clear_chaff( fromdeath )
{
    if ( isdefined( self.chaffcount ) )
    {
        self.chaffcount = undefined;
        chaffclearcallback = function_27df2dbd89b86d69( self );
        
        if ( isplayer( self ) )
        {
            thread function_acaf3520ed93d35d( istrue( fromdeath ) );
        }
        else if ( chaffclearcallback )
        {
            self thread [[ chaffclearcallback ]]( istrue( fromdeath ) );
        }
        
        self notify( #"chaff_cleared" );
    }
}

// Namespace chaff_debuff
// Params 1
// Checksum 0xbbb59ccf, Offset: 0x6ee
// Size: 0x6a
function allow_chaff( status )
{
    if ( isplayer( self ) )
    {
        function_800a0e4879a23d5b( status );
        return;
    }
    
    if ( !isdefined( self.var_5a5cdf232c6a1cd7 ) )
    {
        self.var_5a5cdf232c6a1cd7 = 0;
    }
    
    if ( status )
    {
        assert( self.var_5a5cdf232c6a1cd7 > 0, "<dev string:x105>" );
        self.var_5a5cdf232c6a1cd7--;
        return;
    }
    
    self.var_5a5cdf232c6a1cd7++;
}

// Namespace chaff_debuff
// Params 0
// Checksum 0xb84f6167, Offset: 0x760
// Size: 0x35
function function_d67429e07ae8dc90()
{
    if ( isplayer( self ) )
    {
        return function_dce5c6eabfa6745e();
    }
    else if ( self.exploding )
    {
        return 0;
    }
    else if ( self.var_5a5cdf232c6a1cd7 )
    {
        return 0;
    }
    
    return 1;
}

// Namespace chaff_debuff
// Params 0
// Checksum 0x65ae64ea, Offset: 0x79e
// Size: 0xd, Type: bool
function function_50aa2466c12eaf62()
{
    return self.chaffcount > 0;
}

// Namespace chaff_debuff
// Params 0
// Checksum 0x5d79560a, Offset: 0x7b4
// Size: 0x1e
function function_dfeb1073938ef1()
{
    if ( isdefined( self.chaffcount ) )
    {
        return self.chaffcount;
    }
    
    return 0;
}

// Namespace chaff_debuff
// Params 1
// Checksum 0x3ed5a5ba, Offset: 0x7da
// Size: 0x17
function function_3860212a5ec36b56( applycallback )
{
    self.var_65a9d2532604aa9f = applycallback;
}

// Namespace chaff_debuff
// Params 1
// Checksum 0x1376d953, Offset: 0x7f9
// Size: 0x17
function function_4118b0299dc40ea( startcallback )
{
    self.chaffstartcallback = startcallback;
}

// Namespace chaff_debuff
// Params 1
// Checksum 0xcddbb917, Offset: 0x818
// Size: 0x50
function function_a23ffb8cbea19ede( entity )
{
    var_7237854e3be197ca = entity.chaffstartcallback;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    if ( entity && entity vehicle::is_vehicle() && !entity vehicle::is_husk() )
    {
        return &vehicle_hack::chaff_start_callback;
    }
}

// Namespace chaff_debuff
// Params 1
// Checksum 0x44e825d9, Offset: 0x870
// Size: 0x17
function function_324dd42a2703bc25( clearcallback )
{
    self.chaffclearcallback = clearcallback;
}

// Namespace chaff_debuff
// Params 1
// Checksum 0x2bffe5b4, Offset: 0x88f
// Size: 0x50
function function_27df2dbd89b86d69( entity )
{
    var_7237854e3be197ca = entity.chaffclearcallback;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    if ( entity && entity vehicle::is_vehicle() && !entity vehicle::is_husk() )
    {
        return &vehicle_hack::function_c0b7001382e8c258;
    }
}

// Namespace chaff_debuff
// Params 1
// Checksum 0x95a99e31, Offset: 0x8e7
// Size: 0x40
function function_b170924043785a46( ent )
{
    data = _chaff_get_level_data();
    id = ent getentitynumber();
    data.ents[ id ] = ent;
    return id;
}

// Namespace chaff_debuff
// Params 2
// Checksum 0x863164d9, Offset: 0x930
// Size: 0x2f
function play_scramble( scramblelevel, isjammer )
{
    if ( isjammer )
    {
        function_23339a8a84d1fbd5( scramblelevel );
        return;
    }
    
    function_f966e23bd8f1adb5( scramblelevel );
}

// Namespace chaff_debuff
// Params 2
// Checksum 0x54a6ec3d, Offset: 0x967
// Size: 0x2f
function stop_scramble( scramblelevel, isjammer )
{
    if ( isjammer )
    {
        function_5fe901df82a4dc8b( scramblelevel );
        return;
    }
    
    function_c1fa63136ba5a433( scramblelevel );
}

// Namespace chaff_debuff
// Params 2
// Checksum 0x5e20e7c5, Offset: 0x99e
// Size: 0x53
function function_67d03d9afb12016d( scramblelevel, var_fddfd3341b09e1e9 )
{
    if ( var_fddfd3341b09e1e9 )
    {
        return ( isdefined( self.var_91b62dd5b67835ca ) && isdefined( self.var_91b62dd5b67835ca[ scramblelevel ] ) );
    }
    
    return isdefined( self.var_18888c92cdefaa14 ) && isdefined( self.var_18888c92cdefaa14[ scramblelevel ] );
}

// Namespace chaff_debuff
// Params 1
// Checksum 0xc1f53aa0, Offset: 0x9f9
// Size: 0x63
function function_f966e23bd8f1adb5( scramblelevel )
{
    if ( scramblelevel == 0 )
    {
        return;
    }
    
    if ( !isdefined( self.var_18888c92cdefaa14 ) )
    {
        self.var_18888c92cdefaa14 = [];
    }
    
    var_cdf1652d61c7ff64 = self.var_18888c92cdefaa14[ scramblelevel ];
    
    if ( !isdefined( var_cdf1652d61c7ff64 ) )
    {
        var_cdf1652d61c7ff64 = 0;
    }
    
    self.var_18888c92cdefaa14[ scramblelevel ] = var_cdf1652d61c7ff64 + 1;
    function_f6e3d402f84650af();
}

// Namespace chaff_debuff
// Params 1
// Checksum 0xba9f2218, Offset: 0xa64
// Size: 0x85
function function_c1fa63136ba5a433( scramblelevel )
{
    if ( scramblelevel == 0 )
    {
        return;
    }
    
    assert( isdefined( self.var_18888c92cdefaa14 ), "<dev string:x13e>" );
    assert( isdefined( self.var_18888c92cdefaa14[ scramblelevel ] ), "<dev string:x169>" );
    self.var_18888c92cdefaa14[ scramblelevel ] -= 1;
    
    if ( self.var_18888c92cdefaa14[ scramblelevel ] == 0 )
    {
        self.var_18888c92cdefaa14[ scramblelevel ] = undefined;
    }
    
    function_f6e3d402f84650af();
}

// Namespace chaff_debuff
// Params 0
// Checksum 0x1d0a87df, Offset: 0xaf1
// Size: 0x1f
function function_53ec3c1f49e7c8d0()
{
    self.var_18888c92cdefaa14 = [];
    function_f6e3d402f84650af();
    self notify( #"chaff_scramble_off" );
}

// Namespace chaff_debuff
// Params 0, eflags: 0x4
// Checksum 0x119e8fc4, Offset: 0xb18
// Size: 0x95
function private function_f6e3d402f84650af()
{
    highestlevel = 0;
    
    foreach ( scramblelevel, _ in self.var_18888c92cdefaa14 )
    {
        if ( scramblelevel > highestlevel )
        {
            highestlevel = scramblelevel;
        }
    }
    
    self setclientomnvar( "ui_scrambler_strength", highestlevel );
}

// Namespace chaff_debuff
// Params 0, eflags: 0x4
// Checksum 0x4e4eb750, Offset: 0xbb5
// Size: 0x95
function private function_30ddcad19b4f39d7()
{
    highestlevel = 0;
    
    foreach ( scramblelevel, _ in self.var_91b62dd5b67835ca )
    {
        if ( scramblelevel > highestlevel )
        {
            highestlevel = scramblelevel;
        }
    }
    
    self setclientomnvar( "ui_jammer_strength", highestlevel );
}

// Namespace chaff_debuff
// Params 1
// Checksum 0xf44278a5, Offset: 0xc52
// Size: 0x63
function function_23339a8a84d1fbd5( scramblelevel )
{
    if ( scramblelevel == 0 )
    {
        return;
    }
    
    if ( !isdefined( self.var_91b62dd5b67835ca ) )
    {
        self.var_91b62dd5b67835ca = [];
    }
    
    var_718caaba1a64a76b = self.var_91b62dd5b67835ca[ scramblelevel ];
    
    if ( !isdefined( var_718caaba1a64a76b ) )
    {
        var_718caaba1a64a76b = 0;
    }
    
    self.var_91b62dd5b67835ca[ scramblelevel ] = var_718caaba1a64a76b + 1;
    function_30ddcad19b4f39d7();
}

// Namespace chaff_debuff
// Params 1
// Checksum 0x2b5f0224, Offset: 0xcbd
// Size: 0x85
function function_5fe901df82a4dc8b( scramblelevel )
{
    if ( scramblelevel == 0 )
    {
        return;
    }
    
    assert( isdefined( self.var_91b62dd5b67835ca ), "<dev string:x19f>" );
    assert( isdefined( self.var_91b62dd5b67835ca[ scramblelevel ] ), "<dev string:x1d1>" );
    self.var_91b62dd5b67835ca[ scramblelevel ] -= 1;
    
    if ( self.var_91b62dd5b67835ca[ scramblelevel ] == 0 )
    {
        self.var_91b62dd5b67835ca[ scramblelevel ] = undefined;
    }
    
    function_30ddcad19b4f39d7();
}

// Namespace chaff_debuff
// Params 2
// Checksum 0xdfce62d4, Offset: 0xd4a
// Size: 0x40
function play_scramble_for_player_until_cleared( player, scramblelevel )
{
    player function_f966e23bd8f1adb5( scramblelevel );
    utility::waittill_any( "chaff_cleared", "death" );
    
    if ( isdefined( player ) )
    {
        player function_c1fa63136ba5a433( scramblelevel );
    }
}

// Namespace chaff_debuff
// Params 2
// Checksum 0x157a2be8, Offset: 0xd92
// Size: 0x40
function function_2eb2a0b9290e24a7( player, scramblelevel )
{
    player function_f966e23bd8f1adb5( scramblelevel );
    utility::waittill_any( "dronegun_chaff_cleared", "death" );
    
    if ( isdefined( player ) )
    {
        player function_c1fa63136ba5a433( scramblelevel );
    }
}

// Namespace chaff_debuff
// Params 1, eflags: 0x4
// Checksum 0xb91f7fff, Offset: 0xdda
// Size: 0x45
function private function_800a0e4879a23d5b( status )
{
    if ( utility::issharedfuncdefined( #"chaff", #"hash_7bf11ba4cff7a09" ) )
    {
        self [[ utility::getsharedfunc( #"chaff", #"hash_7bf11ba4cff7a09" ) ]]( status );
    }
}

// Namespace chaff_debuff
// Params 0, eflags: 0x4
// Checksum 0xcb38b3c, Offset: 0xe27
// Size: 0x1f
function private function_4ae66efe2d06fde4()
{
    if ( !isdefined( self.chaffcount ) )
    {
        return 0;
    }
    
    return self.chaffcount;
}

// Namespace chaff_debuff
// Params 0, eflags: 0x4
// Checksum 0xd88058f7, Offset: 0xe4e
// Size: 0x47, Type: bool
function private function_dce5c6eabfa6745e()
{
    if ( !player::isreallyalive() )
    {
        return false;
    }
    
    if ( utility::issharedfuncdefined( #"chaff", #"hash_4dc715b76d91c97d" ) )
    {
        return ![[ utility::getsharedfunc( #"chaff", #"hash_4dc715b76d91c97d" ) ]]();
    }
    
    return true;
}

// Namespace chaff_debuff
// Params 3, eflags: 0x4
// Checksum 0x70e4d84f, Offset: 0xe9e
// Size: 0x60
function private function_622251f36e4c8a3( data, disablehud, disablemechanics )
{
    if ( utility::issharedfuncdefined( #"chaff", #"hash_5bde5614f7ca9fec" ) )
    {
        self [[ utility::getsharedfunc( #"chaff", #"hash_5bde5614f7ca9fec" ) ]]( data );
    }
    
    function_f966e23bd8f1adb5( 5 );
}

// Namespace chaff_debuff
// Params 1, eflags: 0x4
// Checksum 0x6c91ea3a, Offset: 0xf06
// Size: 0x15
function private function_acaf3520ed93d35d( fromdeath )
{
    function_c1fa63136ba5a433( 5 );
}

// Namespace chaff_debuff
// Params 0, eflags: 0x4
// Checksum 0xc9bbd35e, Offset: 0xf23
// Size: 0x32
function private _chaff_init()
{
    data = spawnstruct();
    level.chaff = data;
    level.chaff.ents = [];
}

// Namespace chaff_debuff
// Params 0, eflags: 0x4
// Checksum 0xceccf0af, Offset: 0xf5d
// Size: 0x20
function private _chaff_get_level_data()
{
    if ( !isdefined( level.chaff ) )
    {
        _chaff_init();
    }
    
    return level.chaff;
}

// Namespace chaff_debuff
// Params 4
// Checksum 0x97e34539, Offset: 0xf86
// Size: 0x86
function chaff_debuff_register( entity, applycallback, startcallback, clearcallback )
{
    if ( isdefined( applycallback ) )
    {
        entity function_3860212a5ec36b56( applycallback );
    }
    
    if ( isdefined( startcallback ) )
    {
        entity function_4118b0299dc40ea( startcallback );
    }
    
    if ( isdefined( clearcallback ) )
    {
        entity function_324dd42a2703bc25( clearcallback );
    }
    
    if ( !isdefined( level.var_96c895c9edc11143 ) )
    {
        level.var_96c895c9edc11143 = [];
    }
    
    if ( isdefined( entity ) )
    {
        level.var_96c895c9edc11143[ entity getentitynumber() ] = entity;
    }
}

// Namespace chaff_debuff
// Params 1
// Checksum 0xdc78941f, Offset: 0x1014
// Size: 0x53
function chaff_debuff_deregister( entity )
{
    if ( !isdefined( level.var_96c895c9edc11143 ) )
    {
        return;
    }
    
    if ( !isdefined( entity ) )
    {
        return;
    }
    
    entitynumber = entity getentitynumber();
    
    if ( !isdefined( level.var_96c895c9edc11143[ entitynumber ] ) )
    {
        return;
    }
    
    level.var_96c895c9edc11143[ entitynumber ] = undefined;
}

// Namespace chaff_debuff
// Params 3, eflags: 0x4
// Checksum 0x224810ba, Offset: 0x106f
// Size: 0x49, Type: bool
function private function_191009a5ce4d4f80( ents, optionalorigin, var_1f592e6215a3dc4d )
{
    if ( isdefined( optionalorigin ) )
    {
        if ( distancesquared( self.origin, optionalorigin ) > var_1f592e6215a3dc4d )
        {
            return false;
        }
    }
    
    if ( arraycontains( ents, self ) )
    {
        return false;
    }
    
    return true;
}

// Namespace chaff_debuff
// Params 2
// Checksum 0x217029a5, Offset: 0x10c1
// Size: 0x777
function function_ef6ab3f5d7d1c843( optionalorigin, optionalradius )
{
    data = _chaff_get_level_data();
    radiussquared = undefined;
    
    if ( isdefined( optionalradius ) )
    {
        radiussquared = optionalradius * optionalradius;
    }
    
    ents = [];
    
    foreach ( ent in data.ents )
    {
        if ( isdefined( ent ) && ent function_d67429e07ae8dc90() && ent function_191009a5ce4d4f80( ents, optionalorigin, radiussquared ) )
        {
            ents[ ents.size ] = ent;
        }
    }
    
    allmines = weapon::function_3aafcaf7ff6dea9e();
    
    foreach ( mine in allmines )
    {
        if ( isdefined( mine ) && mine function_d67429e07ae8dc90() && mine function_191009a5ce4d4f80( ents, optionalorigin, radiussquared ) )
        {
            ents[ ents.size ] = mine;
        }
    }
    
    turrets = getentarray( "misc_turret", #classname );
    
    foreach ( turret in turrets )
    {
        if ( isdefined( turret ) && turret function_d67429e07ae8dc90() && turret function_191009a5ce4d4f80( ents, optionalorigin, radiussquared ) )
        {
            ents[ ents.size ] = turret;
        }
    }
    
    if ( isdefined( level.activekillstreaks ) )
    {
        foreach ( streak in level.activekillstreaks )
        {
            if ( isdefined( streak ) && streak function_d67429e07ae8dc90() && streak function_191009a5ce4d4f80( ents, optionalorigin, radiussquared ) )
            {
                ents[ ents.size ] = streak;
            }
        }
    }
    
    if ( isdefined( level.vehicle ) )
    {
        foreach ( vehicles in level.vehicle.instances )
        {
            foreach ( vehicle in vehicles )
            {
                if ( isdefined( vehicle ) && vehicle function_d67429e07ae8dc90() && vehicle function_191009a5ce4d4f80( ents, optionalorigin, radiussquared ) )
                {
                    ents[ ents.size ] = vehicle;
                }
            }
        }
    }
    
    if ( isdefined( level.var_96c895c9edc11143 ) )
    {
        foreach ( equipment in level.var_96c895c9edc11143 )
        {
            if ( isdefined( equipment ) && equipment function_d67429e07ae8dc90() && equipment function_191009a5ce4d4f80( ents, optionalorigin, radiussquared ) )
            {
                ents[ ents.size ] = equipment;
            }
        }
    }
    
    if ( isdefined( level.smokeairdropdrones ) )
    {
        foreach ( drone in level.smokeairdropdrones )
        {
            if ( isdefined( drone ) && !drone.isdestroyed && drone function_191009a5ce4d4f80( ents, optionalorigin, radiussquared ) )
            {
                ents[ ents.size ] = drone;
            }
        }
    }
    
    if ( isdefined( level.holdprop ) && level.holdprop.canchaff )
    {
        foreach ( stronghold in level.fortressstruct.chosenfortresses )
        {
            if ( isdefined( stronghold.task ) && isdefined( stronghold.task.holdpoint ) && stronghold.task.holdpoint.trigger function_191009a5ce4d4f80( ents, optionalorigin, radiussquared ) )
            {
                ents[ ents.size ] = stronghold.task.holdpoint.trigger;
            }
        }
    }
    
    foreach ( player in level.players )
    {
        if ( !isplayer( player ) && player function_d67429e07ae8dc90() && player function_191009a5ce4d4f80( ents, optionalorigin, radiussquared ) )
        {
            ents[ ents.size ] = player;
        }
    }
    
    if ( isdefined( level.var_8c8182fac41f5110 ) )
    {
        foreach ( extraent in level.var_8c8182fac41f5110 )
        {
            if ( extraent function_191009a5ce4d4f80( ents, optionalorigin, radiussquared ) )
            {
                ents[ ents.size ] = extraent;
            }
        }
    }
    
    return ents;
}

