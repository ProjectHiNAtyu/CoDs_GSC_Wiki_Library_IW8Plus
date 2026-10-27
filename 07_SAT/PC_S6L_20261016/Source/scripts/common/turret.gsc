// scripts\common\turret.gsc  (hash_2c127aac33157cb4.gscc) (size: 12352 Bytes / 0x3040 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x422dcee3 (1110298339)
// size ...... 12352 (0x3040)
// includes .. 4   (offset: 0x2fa8)
// strings ... 5   (offset: 0x2fc8)
// dev strs .. 5   (offset: 0x3004)
// exports ... 39  (offset: 0x1bb0)
// cseg ...... 0x9c + 0x1b14 (0x1bb0)
// imports ... 116 (offset: 0x21c8)
// animtree1 . 0   (offset: 0x3040)
// animtree2 . 0   (offset: 0x3040)
#using scripts\common\math;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\vehicle;

#namespace turret;

// Namespace turret
// Params 0
// Checksum 0x5f8015c2, Offset: 0xba
// Size: 0xb4
function turret_vm_playeranims_think()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"turretownerchange" );
        player = self getturretowner();
        weap = undefined;
        
        if ( isplayer( player ) && !isbot( player ) )
        {
            player giveweapon( self.weaponinfo );
            weap = player getcurrentweapon();
            player switchtoweaponimmediate( self.weaponinfo );
        }
        
        self waittill( #"turretownerchange" );
        
        if ( isplayer( player ) && !isbot( player ) )
        {
            player switchtoweaponimmediate( weap );
            player takeweapon( self.weaponinfo );
        }
    }
}

// Namespace turret
// Params 1
// Checksum 0xb6c2ec8, Offset: 0x176
// Size: 0x2f
function function_9b1f535339c80a4( turretindex = 0 )
{
    thread turret_update_targeting( turretindex );
    thread function_1210e1b3a51df4a( turretindex );
    thread function_912c602e8d3066fe( turretindex );
}

// Namespace turret
// Params 1
// Checksum 0x4fc4c936, Offset: 0x1ad
// Size: 0x4c
function function_9a0fa09f3acbc0cd( turretindex = 0 )
{
    self notify( #"turret_disable" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.turret_target = undefined;
    self clearturrettarget( turretindex );
    self function_dc687ac632f02272( 0, turretindex );
    self.shootstate = 0;
}

// Namespace turret
// Params 2
// Checksum 0x301bf656, Offset: 0x201
// Size: 0x51
function function_40a195262f7f99ab( turretindex, targetteams )
{
    if ( !isarray( self.turret_target_teams ) )
    {
        self.turret_target_teams = [];
    }
    
    if ( !isarray( targetteams ) )
    {
        targetteams = [ targetteams ];
    }
    
    self.turret_target_teams[ turretindex ] = targetteams;
}

// Namespace turret
// Params 1
// Checksum 0xd047740, Offset: 0x25a
// Size: 0x13f
function turret_update_targeting( turretindex )
{
    self endon( #"death" );
    self endon( #"turret_disable" );
    
    if ( !isdefined( level.turret_update_targeting_throttle ) )
    {
        level.turret_update_targeting_throttle = throttle::throttle_initialize( "turret_update_targeting", 1 );
    }
    
    while ( true )
    {
        throttle::throttle_wait_in_queue( level.turret_update_targeting_throttle, self );
        
        if ( !self.turret_target )
        {
            if ( !getdvarint( @"hash_caf688a941666600", 0 ) || self.shootstate == 0 )
            {
                self.turret_target = turret_find_target( turretindex );
            }
            
            if ( self.turret_target )
            {
                thread function_120a01902f184185( turretindex );
            }
            else if ( self getturrettargetent( turretindex ) )
            {
                self clearturrettarget( turretindex );
            }
        }
        
        /#
            if ( self.turret_target && getdvarint( @"hash_cb665e9de213e524" ) )
            {
                origin = self.turret_target getcentroid();
                radius = 40;
                color = ( 0, 0.8, 0 );
                duration = 1;
                sphere( origin, radius, color, duration );
            }
        #/
        
        waitframe();
    }
}

// Namespace turret
// Params 1, eflags: 0x4
// Checksum 0x32c30e89, Offset: 0x3a1
// Size: 0x129
function private function_120a01902f184185( turretindex )
{
    self endon( #"death" );
    self endon( #"turret_disable" );
    starttime = gettime();
    lockondelay = self function_880261ce60d8a415( turretindex );
    
    while ( self.turret_target && turret_is_target_valid( self.turret_target, turretindex ) && gettime() - starttime < lockondelay )
    {
        waitframe();
    }
    
    if ( !turret_is_target_valid( self.turret_target, turretindex ) )
    {
        self.turret_target = undefined;
        return;
    }
    
    targetoffset = get_target_origin( self.turret_target ) - self.turret_target.origin;
    self setturrettargetent( self.turret_target, targetoffset, turretindex );
    starttime = gettime();
    lockonduration = self function_684ad5c041f6c5de( turretindex );
    
    while ( self getturrettargetent( turretindex ) && turret_is_target_valid( self.turret_target, turretindex ) && gettime() - starttime < lockonduration )
    {
        waitframe();
    }
    
    self.turret_target = undefined;
}

// Namespace turret
// Params 1
// Checksum 0xff14495c, Offset: 0x4d2
// Size: 0x123
function turret_find_target( turretindex = 0 )
{
    targetlist = function_59f86fe04b48ff46( turretindex );
    output = undefined;
    
    foreach ( target in targetlist )
    {
        if ( !turret_is_target_valid( target, turretindex ) )
        {
            continue;
        }
        
        var_eb12f4e776f82ef9 = self.turret_target_teams[ turretindex ];
        
        if ( isarray( var_eb12f4e776f82ef9 ) && !arraycontains( var_eb12f4e776f82ef9, target.team ) )
        {
            continue;
        }
        
        if ( !output || distancesquared( self.origin, target.origin ) < distancesquared( self.origin, output.origin ) )
        {
            output = target;
        }
    }
    
    return output;
}

// Namespace turret
// Params 1
// Checksum 0xf21baeeb, Offset: 0x5fe
// Size: 0x19e
function function_59f86fe04b48ff46( turretindex )
{
    if ( self.force_target )
    {
        return [ self.force_target ];
    }
    
    maxrange = self function_e7e25c06b8cfce7b( turretindex );
    targetlist = utility::charactersnear( self.origin, maxrange );
    
    if ( self.turret_target_list )
    {
        self.turret_target_list = function_5713d46873b29625( self.turret_target_list );
        targetlist = arraycombine( targetlist, self.turret_target_list );
    }
    
    if ( level.var_d143ed72b6b8509c )
    {
        level.var_d143ed72b6b8509c = function_5713d46873b29625( level.var_d143ed72b6b8509c );
        targetlist = arraycombine( targetlist, level.var_d143ed72b6b8509c );
    }
    
    if ( self.var_88e272c580223f56 )
    {
        vehicles = vehicle_getarrayinradius( self.origin, maxrange );
        
        if ( !isdefined( enemyvehicles ) )
        {
            enemyvehicles = [];
        }
        
        foreach ( vehicle in vehicles )
        {
            if ( vehicle.team && arraycontains( self.turret_target_teams[ turretindex ], vehicle.team ) )
            {
                enemyvehicles[ enemyvehicles.size ] = vehicle;
            }
        }
        
        if ( enemyvehicles.size > 0 )
        {
            targetlist = arraycombine( targetlist, enemyvehicles );
        }
    }
    
    return targetlist;
}

// Namespace turret
// Params 1
// Checksum 0x3e4d4bf5, Offset: 0x7a5
// Size: 0x39, Type: bool
function function_b5596fc90f262f21( target )
{
    return self.var_88e272c580223f56 && target && ( target.vehiclename || target.vehicletype );
}

// Namespace turret
// Params 3, eflags: 0x4
// Checksum 0x383adc21, Offset: 0x7e7
// Size: 0x88, Type: bool
function private function_d00befe8adb73b06( point, target, turretindex )
{
    if ( self.var_6446335ac46dd806 )
    {
        blocked = function_8fcd9c4dc13ebc85( self function_6382f336b5e5cdca( turretindex ), point, self.var_6446335ac46dd806 );
        
        if ( blocked )
        {
            return false;
        }
    }
    
    if ( self vehicle_canturrettargetpoint( point, 1, self, turretindex ) || isplayer( target ) && target vehicle::is_in_vehicle() || function_b5596fc90f262f21( target ) )
    {
        return true;
    }
    
    return false;
}

// Namespace turret
// Params 2
// Checksum 0xd23af375, Offset: 0x878
// Size: 0x304
function turret_is_target_valid( target, turretindex )
{
    if ( !self )
    {
        return 0;
    }
    
    if ( !target || !isent( target ) )
    {
        return 0;
    }
    
    if ( target == self )
    {
        return 0;
    }
    
    if ( isai( target ) && !isalive( target ) )
    {
        target = undefined;
        return 0;
    }
    
    if ( target.var_f9c94f16f6e7c13c )
    {
        return 0;
    }
    
    if ( self.riders )
    {
        foreach ( rider in self.riders )
        {
            if ( rider.vehicle_turret_index == turretindex && rider.team == target.team )
            {
                return 0;
            }
        }
    }
    
    if ( self.var_d327ab4c0ad1af1 )
    {
        valid = self [[ self.var_d327ab4c0ad1af1 ]]( target, turretindex );
        
        if ( valid == 0 || self.var_1c7945832f1b0fec )
        {
            return valid;
        }
    }
    
    if ( !self isturrettargetvalid( target, turretindex ) )
    {
        return 0;
    }
    
    if ( self function_6c8b5f034cb28a1( turretindex ) )
    {
        players = getentarray( "player", #classname );
        
        foreach ( player in players )
        {
            if ( function_ac9a46e7219dab04( target, player, turretindex ) )
            {
                return 0;
            }
        }
    }
    
    if ( !self.force_target )
    {
        foreach ( tag in level.var_149c6f9e292662bf )
        {
            if ( tag && target tagexists( tag ) )
            {
                point = target gettagorigin( tag );
                
                if ( function_d00befe8adb73b06( point, target, turretindex ) )
                {
                    return 1;
                }
            }
        }
    }
    
    var_629c9240efe855c = isai( target ) || isplayer( target );
    point = var_629c9240efe855c ? target geteye() : target.origin;
    
    if ( self.force_target && target.var_e4951b26b66770ee )
    {
        point = target.var_e4951b26b66770ee;
    }
    
    return function_d00befe8adb73b06( point, target, turretindex );
}

// Namespace turret
// Params 1, eflags: 0x4
// Checksum 0x4ae566e6, Offset: 0xb85
// Size: 0xf0
function private get_target_origin( target )
{
    if ( self.force_target && target.var_e4951b26b66770ee )
    {
        return target.var_e4951b26b66770ee;
    }
    
    foreach ( tag in level.var_149c6f9e292662bf )
    {
        if ( tag && target tagexists( tag ) )
        {
            return ( target gettagorigin( tag, 1 ) ?? target.origin );
        }
    }
    
    if ( isai( target ) || isplayer( target ) )
    {
        return target geteye();
    }
    
    return target.origin;
}

// Namespace turret
// Params 3, eflags: 0x4
// Checksum 0xb10adf8f, Offset: 0xc7e
// Size: 0x11e, Type: bool
function private function_ac9a46e7219dab04( target, friendly_player, turretindex )
{
    turretowner = self.owner;
    
    if ( !isdefined( friendly_player.team ) || !isdefined( turretowner.team ) )
    {
        return false;
    }
    
    if ( friendly_player.team != turretowner.team )
    {
        return false;
    }
    
    sourceorigin = self function_6382f336b5e5cdca( turretindex );
    playercenter = friendly_player getcentroid();
    targetcenter = target getcentroid();
    playerdelta = playercenter - sourceorigin;
    playerdist = length( playerdelta );
    
    if ( playerdist < 0.001 )
    {
        return true;
    }
    
    targetdelta = targetcenter - sourceorigin;
    anglebetween = math::anglebetweenvectors( playerdelta, targetdelta );
    avoiddistance = self function_c1d45ed8527ca93e( turretindex );
    safeangle = atan( avoiddistance / playerdist );
    
    if ( anglebetween <= safeangle )
    {
        return true;
    }
    
    return false;
}

// Namespace turret
// Params 2
// Checksum 0x66581582, Offset: 0xda5
// Size: 0x2b
function function_2e0a246d12d5e047( func, overridecheck )
{
    self.var_d327ab4c0ad1af1 = func;
    self.var_1c7945832f1b0fec = overridecheck;
}

// Namespace turret
// Params 3
// Checksum 0x52077164, Offset: 0xdd8
// Size: 0x7b
function function_3ca888c6dfade34b( init_callback, start_callback, update_callback )
{
    assert( isdefined( self.scanmode ), "<dev string:x24>" );
    assert( self.scanmode == 4, "<dev string:x83>" );
    self.var_9ca58e7e70dee60f = init_callback;
    self.turret_scan_start_callback = start_callback;
    self.var_fc63db88d80b1a32 = update_callback;
    self notify( #"hash_c8537b1fdaba0f31" );
}

// Namespace turret
// Params 1
// Checksum 0x3b9c4c02, Offset: 0xe5b
// Size: 0x20
function function_99ed6a1bb065a301( pause = 1 )
{
    self.var_3e5eef8c1f6d60ff = pause;
}

// Namespace turret
// Params 1
// Checksum 0x6eb14b9a, Offset: 0xe83
// Size: 0x249
function function_1210e1b3a51df4a( turretindex )
{
    self endon( #"death" );
    self endon( #"turret_disable" );
    self.scanmode = self getturretscanningmode( turretindex );
    
    switch ( self.scanmode )
    {
        case 0:
            return;
        case 1:
            self.turret_scan_start_callback = &function_965db87094ca8c55;
            break;
        case 2:
            self.var_9ca58e7e70dee60f = &function_3ce881663be017aa;
            self.turret_scan_start_callback = &function_8d530d727f476a04;
            self.var_fc63db88d80b1a32 = &function_d5e5609d2823a59;
            break;
        case 3:
            self.var_fc63db88d80b1a32 = &function_29d8d1f12d502d4d;
            break;
        case 4:
            self waittill( #"hash_c8537b1fdaba0f31" );
            break;
    }
    
    if ( isdefined( self.var_9ca58e7e70dee60f ) )
    {
        self [[ self.var_9ca58e7e70dee60f ]]( turretindex );
    }
    
    var_65171929a435f0b7 = self function_ea39c0ebe91167dc( turretindex ) * 1000;
    pausedtime = var_65171929a435f0b7 * -1;
    self.scanstate = 1;
    
    while ( true )
    {
        if ( self getturrettargetent( turretindex ) || self.var_3e5eef8c1f6d60ff || self.shootstate && self.shootstate != 0 )
        {
            if ( self.scanstate == 1 || self.scanstate == 2 )
            {
                self function_dc687ac632f02272( 0, turretindex );
            }
            
            self.scanstate = 0;
            waitframe();
            continue;
        }
        
        switch ( self.scanstate )
        {
            case 0:
                self.scanstate = 1;
                pausedtime = gettime();
                break;
            case 1:
                if ( gettime() - pausedtime >= var_65171929a435f0b7 )
                {
                    self.scanstate = 2;
                    self function_dc687ac632f02272( 1, turretindex );
                    
                    if ( isdefined( self.turret_scan_start_callback ) )
                    {
                        self [[ self.turret_scan_start_callback ]]( turretindex );
                    }
                }
                
                break;
            case 2:
                if ( isdefined( self.var_fc63db88d80b1a32 ) )
                {
                    self [[ self.var_fc63db88d80b1a32 ]]( turretindex );
                }
                
                break;
        }
        
        waitframe();
    }
}

// Namespace turret
// Params 1
// Checksum 0x6dbf57c4, Offset: 0x10d4
// Size: 0x26
function function_3ce881663be017aa( turretindex )
{
    self.var_4f459d9242bc26c7 = self function_dacab85c937113ec( turretindex );
    self.var_89ee8a2a5206fad6 = 0;
}

// Namespace turret
// Params 1
// Checksum 0x1dcdeb2f, Offset: 0x1102
// Size: 0x2e
function function_8d530d727f476a04( turretindex )
{
    self.targetangle = function_23d8726f2f7090bd( turretindex );
    self setturrettargetlocalangles( self.targetangle, turretindex );
}

// Namespace turret
// Params 1
// Checksum 0x1e6ea37a, Offset: 0x1138
// Size: 0xa6
function function_d5e5609d2823a59( turretindex )
{
    if ( !self isturretrotating( turretindex ) )
    {
        if ( !self.var_89ee8a2a5206fad6 )
        {
            self.var_89ee8a2a5206fad6 = 1;
            self.pausedtime = gettime();
            return;
        }
        
        if ( gettime() - self.pausedtime >= self.var_4f459d9242bc26c7 )
        {
            self.var_89ee8a2a5206fad6 = 0;
            self.targetangle = self.targetangle == function_23d8726f2f7090bd( turretindex ) ? function_769c06c642b7459( turretindex ) : function_23d8726f2f7090bd( turretindex );
            self setturrettargetlocalangles( self.targetangle, turretindex );
        }
    }
}

// Namespace turret
// Params 1
// Checksum 0x4be24d34, Offset: 0x11e6
// Size: 0x1c
function function_965db87094ca8c55( turretindex )
{
    self setturrettargetlocalangles( get_center_angle( turretindex ), turretindex );
}

// Namespace turret
// Params 1
// Checksum 0x1b7ac0d0, Offset: 0x120a
// Size: 0x65
function function_4913664506477ce0( turretindex )
{
    var_5d9554d97272ef8a = combineanglesinverted( self.angles, self getturretworldangles( turretindex ) );
    targetpitch = function_23d8726f2f7090bd( turretindex )[ 0 ];
    self.targetangle = ( targetpitch, var_5d9554d97272ef8a[ 1 ], var_5d9554d97272ef8a[ 2 ] );
    self setturrettargetlocalangles( self.targetangle, turretindex );
}

// Namespace turret
// Params 1
// Checksum 0x6aee4bba, Offset: 0x1277
// Size: 0xca
function function_29d8d1f12d502d4d( turretindex )
{
    assert( self getturretleftarc() + self getturretrightarc() >= 360 || self getturrettoparc() + self getturretbottomarc() >= 360, "<dev string:xdf>" );
    
    if ( self.targetangle )
    {
        if ( self isturretrotating( turretindex ) )
        {
            return;
        }
        else
        {
            self.targetangle = undefined;
        }
    }
    
    yawoffset = 120;
    var_5d9554d97272ef8a = combineanglesinverted( self.angles, self getturretworldangles( turretindex ) );
    var_9f14cb68372709ed = ( function_23d8726f2f7090bd( turretindex )[ 1 ] > 0 ? 1 : -1 ) * yawoffset;
    targetlocalangles = var_5d9554d97272ef8a + ( 0, var_9f14cb68372709ed, 0 );
    self setturrettargetlocalangles( targetlocalangles, turretindex );
}

// Namespace turret
// Params 1
// Checksum 0x88b852fa, Offset: 0x1349
// Size: 0x34
function function_23d8726f2f7090bd( turretindex )
{
    if ( !isdefined( self.var_18ebdbfa122a4a18 ) )
    {
        self.var_18ebdbfa122a4a18 = ( 0, self getturretleftarc( turretindex ), 0 );
    }
    
    return self.var_18ebdbfa122a4a18;
}

// Namespace turret
// Params 1
// Checksum 0xfbd2da11, Offset: 0x1386
// Size: 0x37
function function_769c06c642b7459( turretindex )
{
    if ( !isdefined( self.var_3fc8b804838c5f6a ) )
    {
        self.var_3fc8b804838c5f6a = ( 0, self getturretrightarc( turretindex ) * -1, 0 );
    }
    
    return self.var_3fc8b804838c5f6a;
}

// Namespace turret
// Params 1
// Checksum 0x5b2c72c6, Offset: 0x13c6
// Size: 0x20
function get_center_angle( turretindex )
{
    return ( function_23d8726f2f7090bd( turretindex ) + function_769c06c642b7459( turretindex ) ) / 2;
}

// Namespace turret
// Params 1
// Checksum 0x79260374, Offset: 0x13ef
// Size: 0x17
function function_e2d699d813d8eac1( scanangle )
{
    self.var_18ebdbfa122a4a18 = scanangle;
}

// Namespace turret
// Params 1
// Checksum 0xcd31961c, Offset: 0x140e
// Size: 0x17
function function_42ec7ba446a3e025( scanangle )
{
    self.var_3fc8b804838c5f6a = scanangle;
}

// Namespace turret
// Params 1
// Checksum 0x4a31bf49, Offset: 0x142d
// Size: 0x24
function function_fa954b6b6aadaec0( smoketype )
{
    if ( !smoketype )
    {
        smoketype = "all";
    }
    
    self.var_6446335ac46dd806 = smoketype;
}

// Namespace turret
// Params 1
// Checksum 0xe2bfd9a2, Offset: 0x1459
// Size: 0x4d
function function_42cbdea0305c3246( target )
{
    if ( !self.turret_target_list )
    {
        self.turret_target_list = [];
    }
    
    if ( !arraycontains( self.turret_target_list, target ) )
    {
        self.turret_target_list[ self.turret_target_list.size ] = target;
    }
}

// Namespace turret
// Params 1
// Checksum 0xbec733d4, Offset: 0x14ae
// Size: 0x4d
function function_6697525b8034338a( target )
{
    if ( !level.var_d143ed72b6b8509c )
    {
        level.var_d143ed72b6b8509c = [];
    }
    
    if ( !arraycontains( level.var_d143ed72b6b8509c, target ) )
    {
        level.var_d143ed72b6b8509c[ level.var_d143ed72b6b8509c.size ] = target;
    }
}

// Namespace turret
// Params 1
// Checksum 0x187d92c1, Offset: 0x1503
// Size: 0x4e
function function_c5399067c9aded68( target )
{
    if ( !level.var_d143ed72b6b8509c )
    {
        level.var_d143ed72b6b8509c = [];
    }
    
    if ( !arraycontains( level.var_d143ed72b6b8509c, target ) )
    {
        level.var_d143ed72b6b8509c = arrayremove( level.var_d143ed72b6b8509c, target );
    }
}

// Namespace turret
// Params 2
// Checksum 0x89c922e0, Offset: 0x1559
// Size: 0x49
function function_ed71b42f05d4d7d7( bonetag, cleararray )
{
    if ( cleararray || !level.var_149c6f9e292662bf )
    {
        level.var_149c6f9e292662bf = [];
    }
    
    level.var_149c6f9e292662bf[ level.var_149c6f9e292662bf.size ] = bonetag;
}

// Namespace turret
// Params 2
// Checksum 0x83cc6050, Offset: 0x15aa
// Size: 0x4a
function function_b1f9869724ef3655( var_8bed03034cd26489, cleararray )
{
    if ( cleararray || !level.var_149c6f9e292662bf )
    {
        level.var_149c6f9e292662bf = [];
    }
    
    level.var_149c6f9e292662bf = arraycombine( level.var_149c6f9e292662bf, var_8bed03034cd26489 );
}

// Namespace turret
// Params 1
// Checksum 0x6a2ff3d9, Offset: 0x15fc
// Size: 0x45a
function function_912c602e8d3066fe( turretindex )
{
    self endon( #"death" );
    self endon( #"kill_turret" );
    self endon( #"turret_disable" );
    weapon = self getturretweapon( turretindex );
    
    if ( !isdefined( weapon ) || isnullweapon( weapon ) )
    {
        if ( !isdefined( turretindex ) )
        {
            turretindex = 0;
        }
        
        assertmsg( "<dev string:x128>" + turretindex );
        return;
    }
    
    assert( self function_4a982264b67c1076( turretindex ) == -1, "<dev string:x15f>" );
    self.shootstate = 0;
    targetorigin = undefined;
    nextfiretime = 0;
    var_d32eab37e3674f4c = 0;
    totalshotsfired = 0;
    var_4b5db818db78e154 = 0;
    self.var_db9866782a912974 = self.turretoverrides[ turretindex ].var_f1c93ce3fcc75a1c ?? self function_1b900f8f8b28d016( turretindex );
    self.var_dbbb54782ab74996 = self.turretoverrides[ turretindex ].var_f1a62ae3fca0eace ?? self function_1bb4018f8b512c04( turretindex );
    self.var_2f7bafbafd2e9525 = self.turretoverrides[ turretindex ].var_2362505b36930b0e ?? self function_6ba877f4ddccdd97( turretindex );
    self.var_2f9eb9bafd54f2db = self.turretoverrides[ turretindex ].var_233f425b366ca48c ?? self function_6bcb85f4ddf34419( turretindex );
    self.var_5ddb53a32812c124 = self.turretoverrides[ turretindex ].var_4f189248a397f8c3 ?? self getturretsuppressiontime( turretindex );
    
    while ( true )
    {
        turrettarget = self getturrettargetent( turretindex );
        
        if ( !turrettarget )
        {
            if ( self.shootstate == 1 )
            {
                var_4b5db818db78e154 = gettime();
                self.shootstate = 3;
                
                if ( targetorigin )
                {
                    self setturrettargetvec( targetorigin );
                }
            }
            
            var_a6bcbebb3767f5df = gettime() - var_4b5db818db78e154;
            
            if ( self.shootstate == 3 && var_a6bcbebb3767f5df >= self.var_5ddb53a32812c124 )
            {
                self clearturrettarget( turretindex );
                self function_2a84c3ee0ee33baf( turretindex );
                self.shootstate = 0;
            }
            
            if ( self.shootstate == 0 )
            {
                waitframe();
                continue;
            }
        }
        else
        {
            if ( self function_9529088545f3371a( turretindex ) )
            {
                dist = distance( turrettarget.origin, self.origin );
                self.var_db9866782a912974 = self function_8e488d5f14718068( turretindex, dist );
                self.var_dbbb54782ab74996 = self function_19bb8d2438b3852e( turretindex, dist );
                self.var_2f7bafbafd2e9525 = self function_6c65d0b9769c29bd( turretindex, dist );
                self.var_2f9eb9bafd54f2db = self function_6e9d24c2d7fa119b( turretindex, dist );
            }
            
            if ( self.shootstate == 3 )
            {
                self function_2a84c3ee0ee33baf( turretindex );
                self.shootstate = 0;
            }
        }
        
        if ( self.shootstate == 0 )
        {
            var_d32eab37e3674f4c = randomintrange( self.var_db9866782a912974, self.var_dbbb54782ab74996 + 1 );
            self.shootstate = 1;
        }
        
        if ( self.shootstate == 1 && var_d32eab37e3674f4c <= 0 )
        {
            if ( self.var_2f7bafbafd2e9525 < self.var_2f9eb9bafd54f2db )
            {
                nextfiretime = gettime() + randomfloatrange( self.var_2f7bafbafd2e9525, self.var_2f9eb9bafd54f2db );
            }
            else
            {
                nextfiretime = gettime() + self.var_2f7bafbafd2e9525;
            }
            
            self function_2a84c3ee0ee33baf( turretindex );
            self.shootstate = 2;
        }
        
        if ( gettime() < nextfiretime )
        {
            waitframe();
            continue;
        }
        
        if ( self.shootstate == 2 )
        {
            var_d32eab37e3674f4c = randomintrange( self.var_db9866782a912974, self.var_dbbb54782ab74996 + 1 );
            self.shootstate = 1;
        }
        
        if ( self.shootstate == 1 )
        {
            canshoottarget = function_d2a9430b5ab39ab1( turretindex );
        }
        
        if ( self.shootstate == 3 || canshoottarget )
        {
            currentshotsfired = self function_bdbb3ebff33d06( turretindex );
            var_d32eab37e3674f4c -= currentshotsfired - totalshotsfired;
            totalshotsfired = currentshotsfired;
            
            if ( var_d32eab37e3674f4c > 0 )
            {
                if ( weapontype( weapon ) == "bullet" )
                {
                    self requestfireweapon( turretindex, var_d32eab37e3674f4c );
                }
                else if ( weapontype( weapon ) == "projectile" )
                {
                    thread function_a8a80d80a9bad3c6();
                    self fireweapon( turretindex );
                }
                
                nextfiretime = gettime() + weaponfiretime( weapon ) * 1000;
            }
        }
        
        waitframe();
    }
}

// Namespace turret
// Params 0, eflags: 0x4
// Checksum 0xcf898a4c, Offset: 0x1a5e
// Size: 0x44
function private function_a8a80d80a9bad3c6()
{
    self waittill( #"vehicle_turret_fire", index, firebarrel, projectile );
    projectile.streakinfo = self.streakinfo;
}

// Namespace turret
// Params 1
// Checksum 0x88910b9a, Offset: 0x1aaa
// Size: 0xcb, Type: bool
function function_d2a9430b5ab39ab1( turretindex )
{
    targetorigin = undefined;
    turrettargetent = self getturrettargetent( turretindex );
    
    if ( turrettargetent )
    {
        if ( isai( turrettargetent ) && !isalive( turrettargetent ) )
        {
            return false;
        }
        
        targetorigin = get_target_origin( turrettargetent );
    }
    else if ( self getturrettargetvec( turretindex ) )
    {
        targetorigin = self getturrettargetvec( turretindex );
    }
    else
    {
        return false;
    }
    
    turretorigin = self function_6382f336b5e5cdca( turretindex );
    turretangles = self getturretworldangles( turretindex );
    turretdir = anglestoforward( turretangles );
    targetdir = vectornormalize( targetorigin - turretorigin );
    deltaangle = math::anglebetweenvectorsunit( turretdir, targetdir );
    return deltaangle <= self function_18782539d1486456( turretindex );
}

// Namespace turret
// Params 1
// Checksum 0xd9ec26cf, Offset: 0x1b7e
// Size: 0x31, Type: bool
function is_turret_firing( turretindex )
{
    if ( !turretindex )
    {
        turretindex = 0;
    }
    
    return self.shootstate == 1 || self.shootstate == 3;
}

