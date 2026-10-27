// scripts\mp\gametypes\shock_buff.gsc  (hash_7ca5b222c6505db8.gscc) (size: 9219 Bytes / 0x2403 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x67f501ee (1744110062)
// size ...... 9219 (0x2403)
// includes .. 5   (offset: 0x2283)
// strings ... 23  (offset: 0x22ab)
// dev strs .. 0   (offset: 0x2403)
// exports ... 40  (offset: 0x13f7)
// cseg ...... 0x202 + 0x11f5 (0x13f7)
// imports ... 69  (offset: 0x1a37)
// animtree1 . 0   (offset: 0x2403)
// animtree2 . 0   (offset: 0x2403)
#using scripts\common\utility;
#using scripts\mp\common\killstreaks\uav;
#using scripts\mp\gametypes\common;
#using scripts\mp\hud_message;
#using scripts\mp\weapons;

#namespace shock_buff;

// Namespace shock_buff
// Params 0
// Checksum 0x14a83dc3, Offset: 0x220
// Size: 0x1c5
function function_642998694251794e()
{
    level.shockbuff = spawnstruct();
    level.shockbuff.var_3860bfbe8b9430f5 = [];
    var_418bcd517a5e56dc = registerbuffs();
    var_238c9b01ccf07945 = undefined;
    var_1878f8c32656bf67 = getdvar( @"hash_7a6be53fa72e024d", "" );
    
    if ( var_1878f8c32656bf67 != "" )
    {
        var_238c9b01ccf07945 = strtok( var_1878f8c32656bf67, "," );
    }
    
    numrows = tablelookupgetnumrows( "mp/shock_buffs.csv" );
    
    if ( isdefined( numrows ) )
    {
        for ( index = 0; index < numrows ; index++ )
        {
            buffid = int( tablelookupbyrow( "mp/shock_buffs.csv", index, 0 ) );
            key = tablelookupbyrow( "mp/shock_buffs.csv", index, 1 );
            splash = tablelookupbyrow( "mp/shock_buffs.csv", index, 3 );
            duration = float( tablelookupbyrow( "mp/shock_buffs.csv", index, 5 ) );
            droprate = int( tablelookupbyrow( "mp/shock_buffs.csv", index, 6 ) );
            stack = int( tablelookupbyrow( "mp/shock_buffs.csv", index, 7 ) );
            value1 = int( tablelookupbyrow( "mp/shock_buffs.csv", index, 8 ) );
            value2 = int( tablelookupbyrow( "mp/shock_buffs.csv", index, 9 ) );
            value3 = int( tablelookupbyrow( "mp/shock_buffs.csv", index, 10 ) );
            
            if ( isdefined( var_238c9b01ccf07945 ) && !isdefined( function_f02c63b99c9614c9( var_238c9b01ccf07945, key ) ) )
            {
                continue;
            }
            
            if ( isdefined( var_418bcd517a5e56dc[ key ] ) )
            {
                function_fec309b9e0bd54c5( buffid, key, var_418bcd517a5e56dc[ key ], splash, duration, droprate, stack, value1, value2, value3 );
            }
        }
    }
}

// Namespace shock_buff
// Params 10, eflags: 0x4
// Checksum 0x3ce44003, Offset: 0x3ed
// Size: 0x12c
function private function_fec309b9e0bd54c5( buffid, key, registerfuncs, splash, duration, droprate, stack, value1, value2, value3 )
{
    buffdata = spawnstruct();
    buffdata.id = buffid;
    buffdata.key = key;
    buffdata.initfunc = registerfuncs.initfunc;
    buffdata.splash = splash;
    buffdata.duration = duration;
    buffdata.droprate = droprate;
    buffdata.stack = stack;
    buffdata.values = [ value1, value2, value3 ];
    level.shockbuff.var_3860bfbe8b9430f5[ key ] = buffdata;
    
    if ( isdefined( registerfuncs.preloadfunc ) )
    {
        thread [[ registerfuncs.preloadfunc ]]();
    }
}

// Namespace shock_buff
// Params 2
// Checksum 0x8d3b5cb6, Offset: 0x521
// Size: 0x43
function function_c0b6e5460acaa5c2( preloadfunc, initfunc )
{
    bufffuncs = spawnstruct();
    bufffuncs.preloadfunc = preloadfunc;
    bufffuncs.initfunc = initfunc;
    return bufffuncs;
}

// Namespace shock_buff
// Params 1
// Checksum 0xf46264b9, Offset: 0x56d
// Size: 0x22
function function_c744a102cac71a09( buffkey )
{
    return level.shockbuff.var_3860bfbe8b9430f5[ buffkey ];
}

// Namespace shock_buff
// Params 0
// Checksum 0xa1629d1b, Offset: 0x598
// Size: 0x15
function function_bac1dfda54ed1fc()
{
    return level.shockbuff.var_3860bfbe8b9430f5;
}

// Namespace shock_buff
// Params 0
// Checksum 0x899fb1ba, Offset: 0x5b6
// Size: 0xc
function function_9d4bf23a66b6bbef()
{
    self.shockbuffs = [];
}

// Namespace shock_buff
// Params 1
// Checksum 0x7480627f, Offset: 0x5ca
// Size: 0x55, Type: bool
function function_bb948d60922e522( buffkey )
{
    data = function_c744a102cac71a09( buffkey );
    
    if ( !isdefined( data ) )
    {
        return false;
    }
    
    if ( data.stack > 0 && function_62e47099778ec3fd( buffkey ) >= data.stack )
    {
        return false;
    }
    
    return true;
}

// Namespace shock_buff
// Params 0
// Checksum 0x95ca43a5, Offset: 0x628
// Size: 0xb
function function_190baf3bc469fb5e()
{
    return self.shockbuffs;
}

// Namespace shock_buff
// Params 1
// Checksum 0xb0484d5f, Offset: 0x63c
// Size: 0xad
function function_62e47099778ec3fd( buffkey )
{
    if ( !isdefined( self.shockbuffs ) )
    {
        return 0;
    }
    
    count = 0;
    
    foreach ( buff in self.shockbuffs )
    {
        if ( buff.key == buffkey )
        {
            count++;
        }
    }
    
    return count;
}

// Namespace shock_buff
// Params 1
// Checksum 0xaea82156, Offset: 0x6f2
// Size: 0xa1, Type: bool
function function_c1adf60b0d7bb249( buffkey )
{
    if ( !isdefined( self.shockbuffs ) )
    {
        return false;
    }
    
    foreach ( buff in self.shockbuffs )
    {
        if ( buff.key == buffkey )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace shock_buff
// Params 2
// Checksum 0xd21b7701, Offset: 0x79c
// Size: 0x111
function function_41848c552f45f2e4( buffdata, removecb )
{
    buff = spawnstruct();
    buff.key = buffdata.key;
    buff.owner = self;
    buff.data = buffdata;
    buff.packedid = function_2b14473a50204100( buffdata.id );
    buff [[ buffdata.initfunc ]]();
    slotindex = self.shockbuffs.size;
    self.shockbuffs[ slotindex ] = buff;
    
    if ( isdefined( buff.data.splash ) )
    {
        hud_message::showsplash( buff.data.splash );
    }
    
    if ( isdefined( removecb ) )
    {
        buff.onremoved = removecb;
    }
    
    self setclientomnvar( "ui_shock_buff_" + slotindex, buff.packedid );
    buff thread buffthread();
}

// Namespace shock_buff
// Params 1
// Checksum 0xd4aa6262, Offset: 0x8b5
// Size: 0x43
function function_2b14473a50204100( buffid )
{
    var_d826ad34ac81a8cc = 26;
    tempid = buffid << var_d826ad34ac81a8cc;
    starttime = ( 1 << var_d826ad34ac81a8cc ) - 1 & gettime();
    return tempid | starttime;
}

// Namespace shock_buff
// Params 1
// Checksum 0x92ce4b47, Offset: 0x901
// Size: 0x6a
function function_a50225fd9d423cc5( buff )
{
    if ( isdefined( buff.var_42f5b51c5ec09d1f ) )
    {
        buff [[ buff.var_42f5b51c5ec09d1f ]]();
    }
    
    self.shockbuffs = arrayremove( self.shockbuffs, buff );
    updateomnvars();
    
    if ( isdefined( buff.onremoved ) )
    {
        self [[ buff.onremoved ]]( buff );
    }
}

// Namespace shock_buff
// Params 0
// Checksum 0x78ec4069, Offset: 0x973
// Size: 0xc2
function function_a4aac4f8ccebe67b()
{
    foreach ( buff in self.shockbuffs )
    {
        if ( isdefined( buff.var_42f5b51c5ec09d1f ) )
        {
            buff [[ buff.var_42f5b51c5ec09d1f ]]();
        }
        
        if ( isdefined( buff.onremoved ) )
        {
            self [[ buff.onremoved ]]( buff );
        }
    }
    
    self.shockbuffs = [];
    updateomnvars();
}

// Namespace shock_buff
// Params 0
// Checksum 0xe9bb8d79, Offset: 0xa3d
// Size: 0x6f
function updateomnvars()
{
    var_b27c593c9ed6221c = function_322bb369bc3160d4();
    
    for ( i = 0; i < var_b27c593c9ed6221c ; i++ )
    {
        packedid = 0;
        
        if ( i < self.shockbuffs.size )
        {
            packedid = self.shockbuffs[ i ].packedid;
        }
        
        self setclientomnvar( "ui_shock_buff_" + i, packedid );
    }
}

// Namespace shock_buff
// Params 0
// Checksum 0x4c2ef8c2, Offset: 0xab4
// Size: 0x17
function function_322bb369bc3160d4()
{
    return min( getdvarint( @"hash_7818c82e6897919e", 5 ), 5 );
}

// Namespace shock_buff
// Params 0, eflags: 0x4
// Checksum 0xc136586a, Offset: 0xad4
// Size: 0x83
function private buffthread()
{
    level endon( #"game_ended" );
    buff = self;
    buff.owner endon( #"death_or_disconnect" );
    
    if ( isdefined( buff.var_7adcde1e21282e23 ) )
    {
        buff [[ buff.var_7adcde1e21282e23 ]]();
    }
    
    if ( isdefined( buff.var_731eb949777976c9 ) )
    {
        buff [[ buff.var_731eb949777976c9 ]]();
    }
    
    buff.owner function_a50225fd9d423cc5( buff );
}

// Namespace shock_buff
// Params 3
// Checksum 0xdda8bc3b, Offset: 0xb5f
// Size: 0x56
function function_2b3c33445e63e7d( onbegin, onupdate, onend )
{
    self.var_7adcde1e21282e23 = onbegin;
    self.var_42f5b51c5ec09d1f = onend;
    
    if ( isdefined( onupdate ) )
    {
        self.var_731eb949777976c9 = onupdate;
        return;
    }
    
    self.var_731eb949777976c9 = &function_74a9bd540a6c3182;
}

// Namespace shock_buff
// Params 0
// Checksum 0xae001f44, Offset: 0xbbd
// Size: 0x2e
function function_74a9bd540a6c3182()
{
    if ( self.data.duration > 0 )
    {
        wait self.data.duration;
    }
}

// Namespace shock_buff
// Params 0, eflags: 0x4
// Checksum 0x74debc4b, Offset: 0xbf3
// Size: 0x1d, Type: bool
function private function_b017c65b8729963c()
{
    return self.owner function_62e47099778ec3fd( self.key ) == 1;
}

// Namespace shock_buff
// Params 0, eflags: 0x4
// Checksum 0xa04382, Offset: 0xc19
// Size: 0x1b
function private function_d87153c17f25a5bf()
{
    level._effect[ "vfx_speed_boost_trail_fx" ] = loadfxasset( "vfx_iw8_br_gameplay_rumble_rum_speed_boost_trail" );
}

// Namespace shock_buff
// Params 0, eflags: 0x4
// Checksum 0x5cff19cc, Offset: 0xc3c
// Size: 0x1b
function private function_ce94314d17708f34()
{
    function_2b3c33445e63e7d( &function_782a220eae0c7bd8, undefined, &function_a9941df129ecfdd4 );
    thread function_1b477eee849aa6e8();
}

// Namespace shock_buff
// Params 0, eflags: 0x4
// Checksum 0xf454b9e4, Offset: 0xc5f
// Size: 0xd4
function private function_1b477eee849aa6e8()
{
    player = self.owner;
    player notify( #"hash_a78d5a6846a547d" );
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    player endon( #"hash_a78d5a6846a547d" );
    value = getdvarint( @"hash_cd78976fdbfb9fc2", self.data.values[ 0 ] );
    movespeedscaler = 1 + value * 0.01;
    
    while ( true )
    {
        player waittill( #"haywire_cleared" );
        player.movespeedscaler = movespeedscaler;
        player common::function_a0f5c85d465c5f0a( "moveSpeedScaler", player.movespeedscaler - 1 );
        player weapons::updatemovespeedscale();
    }
}

// Namespace shock_buff
// Params 0, eflags: 0x4
// Checksum 0xb7d231d7, Offset: 0xd3b
// Size: 0x37
function private function_782a220eae0c7bd8()
{
    player = self.owner;
    
    if ( function_b017c65b8729963c() )
    {
        playfxontag( utility::getfx( "vfx_speed_boost_trail_fx" ), player, "j_spine4" );
    }
}

// Namespace shock_buff
// Params 0, eflags: 0x4
// Checksum 0x2b458d05, Offset: 0xd7a
// Size: 0x79
function private function_a9941df129ecfdd4()
{
    player = self.owner;
    
    if ( function_b017c65b8729963c() )
    {
        player.movespeedscaler = 1;
        
        if ( player common::function_8ff835bf23198a0( "moveSpeedScaler" ) )
        {
            player common::function_d85a92c557ea5a52( "moveSpeedScaler" );
        }
        
        player weapons::updatemovespeedscale();
        stopfxontag( utility::getfx( "vfx_speed_boost_trail_fx" ), player, "j_spine4" );
        player notify( #"hash_a78d5a6846a547d" );
    }
}

// Namespace shock_buff
// Params 0, eflags: 0x4
// Checksum 0x640d52b5, Offset: 0xdfb
// Size: 0x14
function private function_a84b78e15a9f751()
{
    function_2b3c33445e63e7d( &function_ca303e11cf577407, undefined, &function_9b7cf4722b1a0def );
}

// Namespace shock_buff
// Params 0, eflags: 0x4
// Checksum 0xb4b9c809, Offset: 0xe17
// Size: 0x65
function private function_ca303e11cf577407()
{
    if ( function_b017c65b8729963c() )
    {
        player = self.owner;
        value = getdvarint( @"hash_4efcc9fafe2395c7", self.data.values[ 0 ] );
        player setjumpheightscale( 1 + value * 0.01 );
        player skydive_autodeployoff();
    }
}

// Namespace shock_buff
// Params 0, eflags: 0x4
// Checksum 0xad69c28c, Offset: 0xe84
// Size: 0x30
function private function_9b7cf4722b1a0def()
{
    if ( function_b017c65b8729963c() )
    {
        player = self.owner;
        player setjumpheightscale( 1 );
        player function_197ef48187159d23();
    }
}

// Namespace shock_buff
// Params 0, eflags: 0x4
// Checksum 0x98e2d0fd, Offset: 0xebc
// Size: 0x14
function private function_f343b6f3b9ea9b45()
{
    function_2b3c33445e63e7d( &function_fe5e8ab2d324168b, undefined, &function_56ee28a3915f0a53 );
}

// Namespace shock_buff
// Params 0, eflags: 0x4
// Checksum 0xb1358581, Offset: 0xed8
// Size: 0x38
function private function_fe5e8ab2d324168b()
{
    function_720847e80c74af41( self.owner, getuavstrengthlevelshowenemydirectional() );
    
    if ( function_b017c65b8729963c() )
    {
        self.owner thread function_b4cd667e7d20a303( self.key );
    }
}

// Namespace shock_buff
// Params 0, eflags: 0x4
// Checksum 0xe64e762e, Offset: 0xf18
// Size: 0x47
function private function_56ee28a3915f0a53()
{
    if ( function_b017c65b8729963c() )
    {
        player = self.owner;
        function_720847e80c74af41( player, uav::function_c6b46bde3b7bc0a1( player.team ) );
        player notify( #"eyes_on_end" );
    }
}

// Namespace shock_buff
// Params 1, eflags: 0x4
// Checksum 0xda6c934e, Offset: 0xf67
// Size: 0x84
function private function_b4cd667e7d20a303( buffkey )
{
    self endon( #"death_or_disconnect" );
    self endon( #"eyes_on_end" );
    level endon( #"game_ended" );
    var_d1aa45f933d6bd4 = getuavstrengthlevelshowenemydirectional();
    
    while ( function_62e47099778ec3fd( buffkey ) > 0 )
    {
        level waittill( #"uav_updated" );
        
        if ( !self.hasradar || self.radarstrength != var_d1aa45f933d6bd4 )
        {
            function_720847e80c74af41( self, var_d1aa45f933d6bd4 );
        }
    }
}

// Namespace shock_buff
// Params 2, eflags: 0x4
// Checksum 0x962deac6, Offset: 0xff3
// Size: 0x226
function private function_720847e80c74af41( player, override )
{
    player.radarstrength = int( max( min( override, level.uavbestid ), level.uavworstid ) );
    player.isradarblocked = player.radarstrength == level.uavworstid;
    player.hasradar = !player.isradarblocked;
    player.radarshowenemydirection = player.radarstrength >= level.uavdirectionalid;
    var_a3e3acd7517ccc35 = level.var_d3e0b46ab1c070f8[ player.team ];
    showconstant = player.radarstrength >= level.uavbestid || player.radarshowenemydirection || player.radarstrength == 1;
    
    if ( player.radarstrength == level.uavnoneid )
    {
        radarmode = "normal_radar";
        player.hasradar = 0;
    }
    else if ( showconstant )
    {
        radarmode = "constant_radar";
    }
    else if ( player.radarstrength == level.uavfastsweepid || var_a3e3acd7517ccc35 && getdvarint( @"hash_61964e46cab20802", 1 ) == 1 )
    {
        radarmode = "fast_radar";
    }
    else
    {
        radarmode = "normal_radar";
    }
    
    player.radarmode = radarmode;
    player setclientomnvar( "ui_radar_blocked", !player.hasradar );
    
    if ( var_a3e3acd7517ccc35 || isdefined( player.perks[ "specialty_pc_comms" ] ) || isdefined( player.perks[ "specialty_overwatch" ] ) )
    {
        player.radarshowenemydirection = 1;
    }
    
    var_ec86cf09b79859c3 = level.sharedfuncs[ #"jamming_system" ][ #"hash_6ce58048ce76814e" ];
    
    if ( isdefined( var_ec86cf09b79859c3 ) )
    {
        level [[ var_ec86cf09b79859c3 ]]( [ player ] );
    }
}

// Namespace shock_buff
// Params 0, eflags: 0x4
// Checksum 0xd1a7bdfd, Offset: 0x1221
// Size: 0x14
function private function_16532e2a43522a09()
{
    function_2b3c33445e63e7d( &function_806323fe993f9d7f, undefined, &function_889b877a900aadf7 );
}

// Namespace shock_buff
// Params 0, eflags: 0x4
// Checksum 0x9ef78a6f, Offset: 0x123d
// Size: 0x1b
function private function_806323fe993f9d7f()
{
    if ( function_b017c65b8729963c() )
    {
        self.owner thread function_bd8947c7c7759ec9();
    }
}

// Namespace shock_buff
// Params 0, eflags: 0x4
// Checksum 0xcb664fb3, Offset: 0x1260
// Size: 0x36
function private function_889b877a900aadf7()
{
    if ( function_b017c65b8729963c() )
    {
        player = self.owner;
        player allowreload( 1 );
        player notify( #"fire_boost_end" );
    }
}

// Namespace shock_buff
// Params 0, eflags: 0x4
// Checksum 0xb6c2ce4, Offset: 0x129e
// Size: 0x4d
function private function_bd8947c7c7759ec9()
{
    self endon( #"death_or_disconnect" );
    self endon( #"fire_boost_end" );
    level endon( #"game_ended" );
    function_30caa4c37f2539a5();
    
    while ( true )
    {
        utility::waittill_any( "weapon_fired", "weapon_change" );
        function_30caa4c37f2539a5();
    }
}

// Namespace shock_buff
// Params 0
// Checksum 0x39451d98, Offset: 0x12f3
// Size: 0x96
function function_30caa4c37f2539a5()
{
    objweapon = self getcurrentweapon();
    clipamount = weaponclipsize( objweapon );
    var_6844291706bf734c = clipamount == 1;
    needreload = var_6844291706bf734c || objweapon.basename == "jup_jp26_la_mike32_mp";
    self allowreload( needreload );
    stocksize = weaponmaxammo( objweapon );
    self setweaponammostock( objweapon, stocksize );
    
    if ( !needreload )
    {
        self setweaponammoclip( objweapon, clipamount, "left" );
        self setweaponammoclip( objweapon, clipamount, "right" );
    }
}

// Namespace shock_buff
// Params 0, eflags: 0x4
// Checksum 0xe76efb0c, Offset: 0x1391
// Size: 0x65
function private registerbuffs()
{
    var_418bcd517a5e56dc = [];
    var_418bcd517a5e56dc[ "shock_speed_boost" ] = function_c0b6e5460acaa5c2( &function_d87153c17f25a5bf, &function_ce94314d17708f34 );
    var_418bcd517a5e56dc[ "shock_super_jump" ] = function_c0b6e5460acaa5c2( undefined, &function_a84b78e15a9f751 );
    var_418bcd517a5e56dc[ "shock_eyes_on" ] = function_c0b6e5460acaa5c2( undefined, &function_f343b6f3b9ea9b45 );
    var_418bcd517a5e56dc[ "shock_fire_boost" ] = function_c0b6e5460acaa5c2( undefined, &function_16532e2a43522a09 );
    return var_418bcd517a5e56dc;
}

