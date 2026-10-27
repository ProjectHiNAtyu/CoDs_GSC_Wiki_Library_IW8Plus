// script_47b67c6c86f923dc  (hash_47b67c6c86f923dc.gscc) (size: 4875 Bytes / 0x130b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1e9e07e (32104574)
// size ...... 4875 (0x130b)
// includes .. 2   (offset: 0x1257)
// strings ... 5   (offset: 0x1267)
// dev strs .. 6   (offset: 0x12bf)
// exports ... 22  (offset: 0xa8b)
// cseg ...... 0x96 + 0x9f5 (0xa8b)
// imports ... 37  (offset: 0xdfb)
// animtree1 . 0   (offset: 0x130b)
// animtree2 . 0   (offset: 0x130b)
#using scripts\common\utility;
#using scripts\mp\common\killstreaks\killstreaks;

#namespace namespace_2ac038cd00d2651e;

// Namespace namespace_2ac038cd00d2651e
// Params 1, eflags: 0x4
// Checksum 0x29de80b8, Offset: 0xb4
// Size: 0x15
function private ReturnSuccess( taskid )
{
    return anim.success;
}

// Namespace namespace_2ac038cd00d2651e
// Params 1, eflags: 0x4
// Checksum 0x8e2026bb, Offset: 0xd2
// Size: 0xe3
function private function_a7c10bc219394e5( taskid )
{
    targetid = self._blackboard.var_274aa2462ec53058;
    targetplayer = undefined;
    
    if ( targetid >= 0 )
    {
        foreach ( player in level.players )
        {
            if ( targetid == player getentitynumber() )
            {
                targetplayer = player;
                break;
            }
        }
    }
    
    if ( !isdefined( targetplayer ) )
    {
        return anim.failure;
    }
    
    profilestart();
    thread function_3c3906656c0a2b6b( targetplayer );
    profilestop();
    return anim.success;
}

// Namespace namespace_2ac038cd00d2651e
// Params 1, eflags: 0x4
// Checksum 0x7dd65d52, Offset: 0x1be
// Size: 0x60
function private killstreakairstrike( taskid )
{
    btresult = undefined;
    var_78ee275fe6709bbd = function_9429ae53be0ec5d5();
    
    if ( function_42c378e9609b41c5() )
    {
        btresult = anim.failure;
    }
    else if ( var_78ee275fe6709bbd )
    {
        btresult = anim.running;
    }
    else
    {
        btresult = anim.success;
    }
    
    return btresult;
}

// Namespace namespace_2ac038cd00d2651e
// Params 1, eflags: 0x4
// Checksum 0x88e2f0d5, Offset: 0x227
// Size: 0x72
function private function_156e06b35680a87e( taskid )
{
    self.var_cdff81c62a064440 = undefined;
    self._blackboard.var_274aa2462ec53058 = -1;
    
    if ( isdefined( self.var_ab5e5de088614676 ) )
    {
        self botsetflag( "ignore_script_weapon", self.var_ab5e5de088614676 );
        self.var_ab5e5de088614676 = undefined;
    }
    
    self botlookatpoint( undefined );
    self botpressbutton( "ADS" );
    return anim.success;
}

// Namespace namespace_2ac038cd00d2651e
// Params 0, eflags: 0x4
// Checksum 0x6552f6f2, Offset: 0x2a2
// Size: 0x26, Type: bool
function private function_42c378e9609b41c5()
{
    starttime = self.var_cdff81c62a064440 ?? 0;
    return gettime() > starttime + 5000;
}

// Namespace namespace_2ac038cd00d2651e
// Params 0, eflags: 0x4
// Checksum 0x51392061, Offset: 0x2d1
// Size: 0xc, Type: bool
function private function_9429ae53be0ec5d5()
{
    return isdefined( self.triggeringstreak );
}

// Namespace namespace_2ac038cd00d2651e
// Params 1, eflags: 0x4
// Checksum 0xdcb12c23, Offset: 0x2e6
// Size: 0x9c
function private function_d26ee658db8e05a9( target )
{
    waittime = 2 * randomfloatrange( 0.7, 1 );
    starttime = gettime();
    self botpressbutton( "ADS", 5 );
    
    while ( true )
    {
        wait randomfloatrange( 0.6, 1 );
        
        if ( function_42c378e9609b41c5() )
        {
            return;
        }
        
        function_f9669a165ee686c6( target );
        
        if ( gettime() < starttime + waittime * 1000 )
        {
            continue;
        }
        
        if ( !function_9429ae53be0ec5d5() )
        {
            return;
        }
        
        if ( isalive( self ) )
        {
            self botpressbutton( "attack" );
        }
    }
}

// Namespace namespace_2ac038cd00d2651e
// Params 1, eflags: 0x4
// Checksum 0x2fe200f, Offset: 0x38a
// Size: 0xe8
function private function_f9669a165ee686c6( target )
{
    rangemin = level.var_d4909c0acc55763c.var_1b106e05a589facc;
    rangemax = level.var_d4909c0acc55763c.var_1aed7c05a563d1de;
    offsetvalue = randomintrange( rangemin, rangemax );
    
    if ( isdefined( target ) )
    {
        var_905c0b75b13e4854 = ( offsetvalue * utility::array_random( [ -1, 1 ] ), offsetvalue * utility::array_random( [ -1, 1 ] ), 0 );
        kstargetlocation = target.origin + var_905c0b75b13e4854;
    }
    else
    {
        forwardvec = anglestoforward( self.angles );
        kstargetlocation = self.origin + forwardvec * offsetvalue;
    }
    
    self botlookatpoint( kstargetlocation, 2, "script_forced" );
}

// Namespace namespace_2ac038cd00d2651e
// Params 1, eflags: 0x4
// Checksum 0xc2ceacde, Offset: 0x47a
// Size: 0x6d
function private function_3c3906656c0a2b6b( target )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    waitframe();
    function_f9669a165ee686c6( target );
    self.var_ab5e5de088614676 = self function_aaad5ae04c1e5224( "ignore_script_weapon" );
    self botsetflag( "ignore_script_weapon", 0 );
    self.var_cdff81c62a064440 = gettime();
    killstreaks::dokillstreakaction( undefined, 1 );
    function_d26ee658db8e05a9( target );
}

// Namespace namespace_2ac038cd00d2651e
// Params 1, eflags: 0x4
// Checksum 0x434e55ce, Offset: 0x4ef
// Size: 0x39
function private function_45ac90d140d05897( taskid )
{
    thread function_8982c588d0412d01();
    
    /#
        logstring( "<dev string:x24>" + self.name + "<dev string:x31>" );
    #/
    
    return anim.success;
}

// Namespace namespace_2ac038cd00d2651e
// Params 1, eflags: 0x4
// Checksum 0xfb0007b8, Offset: 0x531
// Size: 0x5b
function private killstreakuav( taskid )
{
    btresult = undefined;
    var_78ee275fe6709bbd = isdefined( self.triggeringstreak ) || !isnullweapon( self getheldoffhand() );
    
    if ( var_78ee275fe6709bbd )
    {
        btresult = anim.running;
    }
    else
    {
        btresult = anim.success;
    }
    
    return btresult;
}

// Namespace namespace_2ac038cd00d2651e
// Params 0, eflags: 0x4
// Checksum 0x5b35cd23, Offset: 0x595
// Size: 0x25
function private function_8982c588d0412d01()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    waitframe();
    killstreaks::dokillstreakaction( undefined, 1 );
}

// Namespace namespace_2ac038cd00d2651e
// Params 0, eflags: 0x4
// Checksum 0x7d66eaa3, Offset: 0x5c2
// Size: 0x68
function private function_6565b60958cd5fb2()
{
    wait 2;
    forwardloc = self.origin + anglestoforward( self.angles ) * 100;
    self notify( #"place_sentry" );
    self notify( #"place_ims" );
    self notify( #"placePlaceable" );
    self notify( #"equip_deploy_succeeded", undefined, undefined, forwardloc, self.angles );
}

// Namespace namespace_2ac038cd00d2651e
// Params 0, eflags: 0x4
// Checksum 0xb5efeff0, Offset: 0x632
// Size: 0x4b
function private function_f65797b249173297()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    waitframe();
    self.var_ab5e5de088614676 = self function_aaad5ae04c1e5224( "ignore_script_weapon" );
    self botsetflag( "ignore_script_weapon", 0 );
    killstreaks::dokillstreakaction( undefined, 1 );
    function_6565b60958cd5fb2();
}

// Namespace namespace_2ac038cd00d2651e
// Params 1, eflags: 0x4
// Checksum 0x73e98cd1, Offset: 0x685
// Size: 0x26
function private killstreakweapon_init( taskid )
{
    self.var_9c0a813c52d50675 = 0;
    thread function_f65797b249173297();
    return anim.success;
}

// Namespace namespace_2ac038cd00d2651e
// Params 1, eflags: 0x4
// Checksum 0x825f4b3d, Offset: 0x6b4
// Size: 0x5b
function private killstreakweapon( taskid )
{
    btresult = undefined;
    var_78ee275fe6709bbd = isdefined( self.triggeringstreak ) || !isnullweapon( self getheldoffhand() );
    
    if ( var_78ee275fe6709bbd )
    {
        btresult = anim.running;
    }
    else
    {
        btresult = anim.success;
    }
    
    return btresult;
}

// Namespace namespace_2ac038cd00d2651e
// Params 1, eflags: 0x4
// Checksum 0xecba4228, Offset: 0x718
// Size: 0x40
function private killstreakweapon_terminate( taskid )
{
    if ( isdefined( self.var_ab5e5de088614676 ) )
    {
        self botsetflag( "ignore_script_weapon", self.var_ab5e5de088614676 );
        self.var_ab5e5de088614676 = undefined;
    }
    
    return anim.success;
}

// Namespace namespace_2ac038cd00d2651e
// Params 1, eflags: 0x4
// Checksum 0xaad119, Offset: 0x761
// Size: 0x165
function private getkillstreakfunction( killstreakname )
{
    functionref = undefined;
    
    switch ( killstreakname )
    {
        case #"directional_uav":
        case #"uav":
        case #"scrambler_drone_guard":
            functionref = [ &function_45ac90d140d05897, &killstreakuav, &ReturnSuccess ];
            break;
        case #"drill_charge_bomb":
        case #"sticky_artillery":
        case #"napalm_strike":
        case #"airdrop":
        case #"toma_strike":
        case #"bunker_buster":
        case #"precision_airstrike":
        case #"ground_drone_unit":
        case #"bombing_run":
        case #"turret_drone":
        case #"minijugg":
            functionref = [ &function_a7c10bc219394e5, &killstreakairstrike, &function_156e06b35680a87e ];
            break;
        case #"railgun":
        case #"sentry_gun":
            functionref = [ &killstreakweapon_init, &killstreakweapon, &killstreakweapon_terminate ];
            break;
        default:
            assert( 0, "<dev string:x3b>" + killstreakname );
            break;
    }
    
    return functionref;
}

// Namespace namespace_2ac038cd00d2651e
// Params 1
// Checksum 0x9088503e, Offset: 0x8cf
// Size: 0xc8
function killstreak_init( taskid )
{
    ref = self._blackboard.var_f04e4feb1665635c;
    callbacks = getkillstreakfunction( ref );
    
    if ( !isdefined( callbacks ) )
    {
        assert( 0, "<dev string:x55>" + ref + "<dev string:x8a>" );
        return anim.failure;
    }
    
    self.var_a1c518619af22864 = callbacks[ 0 ];
    self.var_828ab45a40fd8ea7 = callbacks[ 1 ];
    self.var_ca5cc16244f94517 = callbacks[ 2 ];
    
    if ( !isdefined( self.var_a1c518619af22864 ) )
    {
        assert( 0, "<dev string:x8c>" + ref + "<dev string:x8a>" );
        return anim.failure;
    }
    
    return self [[ self.var_a1c518619af22864 ]]( taskid );
}

// Namespace namespace_2ac038cd00d2651e
// Params 1
// Checksum 0x3743ec8c, Offset: 0x9a0
// Size: 0x32
function killstreak( taskid )
{
    if ( !isdefined( self.var_828ab45a40fd8ea7 ) )
    {
        return anim.failure;
    }
    
    return self [[ self.var_828ab45a40fd8ea7 ]]( taskid );
}

// Namespace namespace_2ac038cd00d2651e
// Params 1
// Checksum 0x39dd7e66, Offset: 0x9db
// Size: 0xaf
function killstreak_terminate( taskid )
{
    if ( !isdefined( self.var_ca5cc16244f94517 ) )
    {
        return anim.failure;
    }
    
    result = self [[ self.var_ca5cc16244f94517 ]]( taskid );
    self.var_9c0a813c52d50675 = undefined;
    self._blackboard.var_df360557262445bf = 0;
    self._blackboard.var_f04e4feb1665635c = "";
    self._blackboard.var_7771b1827f422917 = "";
    self.var_a1c518619af22864 = undefined;
    self.var_828ab45a40fd8ea7 = undefined;
    self.var_ca5cc16244f94517 = undefined;
    return result;
}

