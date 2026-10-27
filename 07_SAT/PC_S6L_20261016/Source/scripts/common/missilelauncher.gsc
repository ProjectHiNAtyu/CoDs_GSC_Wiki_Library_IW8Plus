// scripts\common\missilelauncher.gsc  (hash_2333f3e1ba686df8.gscc) (size: 11078 Bytes / 0x2b46 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9526152a (2502300970)
// size ...... 11078 (0x2b46)
// includes .. 4   (offset: 0x29ea)
// strings ... 22  (offset: 0x2a0a)
// dev strs .. 1   (offset: 0x2b3a)
// exports ... 26  (offset: 0x1c2e)
// cseg ...... 0x1f5 + 0x1a39 (0x1c2e)
// imports ... 78  (offset: 0x203e)
// animtree1 . 0   (offset: 0x2b46)
// animtree2 . 0   (offset: 0x2b46)
#using script_16ea1b94f0f381b3;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;

#namespace missilelauncher;

// Namespace missilelauncher
// Params 0
// Checksum 0x2e6164b8, Offset: 0x213
// Size: 0x9
function initmissilelauncherusage()
{
    resetmissilelaunchertargets();
}

// Namespace missilelauncher
// Params 0
// Checksum 0xcdc0d51f, Offset: 0x224
// Size: 0x2a
function resetmissilelaunchertargets()
{
    self.missilelauncherstage = undefined;
    self.missilelaunchertarget = undefined;
    self.missilelauncherlockstarttime = undefined;
    self.missilelauncherlostsightlinetime = undefined;
}

// Namespace missilelauncher
// Params 0
// Checksum 0x94ae556, Offset: 0x256
// Size: 0x80
function resetmissilelauncherlocking()
{
    if ( !isdefined( self.missilelauncheruseentered ) )
    {
        return;
    }
    
    self.missilelauncheruseentered = undefined;
    self notify( #"hash_c728629f94d5f61f" );
    self notify( #"hash_bca008c6e4827f1a" );
    self notify( #"hash_43049ecfa18e32e2" );
    self weaponlockfree();
    self stoplocalsound( "maaws_reticle_tracking" );
    self stoplocalsound( "maaws_reticle_locked" );
    
    if ( isdefined( self.missilelaunchertarget ) )
    {
        namespace_9d8e359c3b1041e5::removelockedonsharedfunc( self.missilelaunchertarget, self );
    }
    
    resetmissilelaunchertargets();
}

// Namespace missilelauncher
// Params 0
// Checksum 0x97770cd8, Offset: 0x2de
// Size: 0x49
function resetmissilelauncherlockingondeath()
{
    self endon( #"disconnect" );
    self notify( #"resetmissilelauncherlockingondeath" );
    self endon( #"resetmissilelauncherlockingondeath" );
    self endon( #"end_launcher" );
    
    for ( ;; )
    {
        self waittill( #"death" );
        resetmissilelauncherlocking();
    }
}

// Namespace missilelauncher
// Params 0
// Checksum 0xec6e0961, Offset: 0x32f
// Size: 0xaf
function loopmissilelauncherlockingfeedback()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_c728629f94d5f61f" );
    
    for ( ;; )
    {
        if ( level.gunshipplayer )
        {
            if ( self.missilelaunchertarget == level.chopper.gunner )
            {
                level.gunshipplayer playlocalsound( "maaws_incoming_lp" );
            }
            
            if ( self.missilelaunchertarget == level.gunship.planemodel )
            {
                level.gunshipplayer playlocalsound( "maaws_incoming_lp" );
            }
        }
        
        if ( self )
        {
            self playlocalsound( "maaws_reticle_tracking" );
            self playrumbleonentity( "ac130_25mm_fire" );
        }
        
        wait 0.6;
    }
}

// Namespace missilelauncher
// Params 0
// Checksum 0xcc6b826, Offset: 0x3e6
// Size: 0xaf
function loopmissilelauncherlockedfeedback()
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_bca008c6e4827f1a" );
    self playlocalsound( "maaws_reticle_locked" );
    
    for ( ;; )
    {
        if ( level.gunshipplayer )
        {
            if ( self.missilelaunchertarget == level.chopper.gunner )
            {
                level.gunshipplayer playlocalsound( "maaws_incoming_lp" );
            }
            
            if ( self.missilelaunchertarget == level.gunship.planemodel )
            {
                level.gunshipplayer playlocalsound( "maaws_incoming_lp" );
            }
        }
        
        if ( self )
        {
            self playrumbleonentity( "ac130_25mm_fire" );
        }
        
        wait 0.25;
    }
}

// Namespace missilelauncher
// Params 1
// Checksum 0xcd86bb62, Offset: 0x49d
// Size: 0x78, Type: bool
function softsighttest( stingtargstruct )
{
    lost_sight_limit = 500;
    
    if ( stingtargstruct stingtargstruct_isinlos() )
    {
        self.missilelauncherlostsightlinetime = 0;
        return true;
    }
    
    if ( self.missilelauncherlostsightlinetime == 0 )
    {
        self.missilelauncherlostsightlinetime = gettime();
    }
    
    timepassed = gettime() - self.missilelauncherlostsightlinetime;
    
    if ( timepassed >= lost_sight_limit )
    {
        resetmissilelauncherlocking();
        return false;
    }
    
    return true;
}

// Namespace missilelauncher
// Params 0
// Checksum 0x8a7f8bd7, Offset: 0x51e
// Size: 0x559
function missilelauncherusage()
{
    var_76b4cecf4005da46 = getdvarint( @"hash_eb7d16d9fa10a208", 625000000 );
    var_215f461ee332af42 = 0;
    
    /#
        var_215f461ee332af42 = getdvarint( @"hash_10368af4dee3ba2c", 0 );
    #/
    
    if ( !namespace_9d8e359c3b1041e5::ismissilelauncherlockonallowedsharedfunc() )
    {
        return;
    }
    
    if ( self playerads() < 0.95 )
    {
        resetmissilelauncherlocking();
        return;
    }
    
    self.missilelauncheruseentered = 1;
    
    if ( !isdefined( self.missilelauncherstage ) )
    {
        self.missilelauncherstage = 0;
    }
    
    /#
        missilelauncherdebugdraw( self.missilelaunchertarget );
    #/
    
    if ( self.missilelauncherstage == 0 )
    {
        targets = namespace_9d8e359c3b1041e5::lockonlaunchergettargetarraysharedfunc( 0 );
        
        if ( targets.size == 0 )
        {
            return;
        }
        
        targets = sortbydistance( targets, self.origin );
        stingtargstruct = undefined;
        var_f61de127e3e153d4 = 0;
        var_abf2138e4069a09e = level.sharedfuncs[ #"flare_system" ][ #"hash_bb66c31dec02b91a" ];
        
        foreach ( target in targets )
        {
            if ( !isdefined( target ) )
            {
                continue;
            }
            
            if ( target.var_4efa4e2adc37ef3.size )
            {
                continue;
            }
            
            if ( isdefined( var_abf2138e4069a09e ) )
            {
                flaresystemresult = self [[ var_abf2138e4069a09e ]]( target );
                
                if ( flaresystemresult != #"lockon_success" )
                {
                    continue;
                }
            }
            
            stingtargstruct = stingtargstruct_create( self, target );
            stingtargstruct stingtargstruct_getoffsets();
            stingtargstruct stingtargstruct_getorigins();
            stingtargstruct stingtargstruct_getinreticle();
            
            if ( stingtargstruct stingtargstruct_isinreticle() )
            {
                if ( distancesquared( target.origin, self.origin ) > var_76b4cecf4005da46 )
                {
                    break;
                }
                
                var_f61de127e3e153d4 = 1;
                break;
            }
        }
        
        if ( !var_f61de127e3e153d4 )
        {
            return;
        }
        
        stingtargstruct stingtargstruct_getinlos();
        
        if ( !stingtargstruct stingtargstruct_isinlos() )
        {
            return;
        }
        
        self.missilelaunchertarget = stingtargstruct.target;
        self.missilelauncherlockstarttime = gettime();
        self.missilelauncherstage = 1;
        self.missilelauncherlostsightlinetime = 0;
        
        if ( isent( self.missilelaunchertarget ) )
        {
            self weaponlockstart( self.missilelaunchertarget );
            thread function_88069b6ff0b574b7( self.missilelaunchertarget );
        }
        else
        {
            self weaponlockstart( self.missilelaunchertarget.origin );
            thread function_97a7f497a684b12( self.missilelaunchertarget );
        }
        
        if ( isdefined( self.missilelaunchertarget ) )
        {
            namespace_9d8e359c3b1041e5::addlockedonsharedfunc( self.missilelaunchertarget, self );
        }
        
        thread loopmissilelauncherlockingfeedback();
    }
    
    if ( self.missilelauncherstage == 1 )
    {
        if ( !isdefined( self.missilelaunchertarget ) )
        {
            resetmissilelauncherlocking();
            return;
        }
        
        if ( self.missilelaunchertarget.var_4efa4e2adc37ef3.size )
        {
            resetmissilelauncherlocking();
            return;
        }
        
        if ( !var_215f461ee332af42 && self.missilelaunchertarget vehicle::is_vehicle() && vehicle::is_friendly_to_player( self.missilelaunchertarget, self ) )
        {
            resetmissilelauncherlocking();
            return;
        }
        
        stingtargstruct = stingtargstruct_create( self, self.missilelaunchertarget );
        stingtargstruct stingtargstruct_getoffsets();
        stingtargstruct stingtargstruct_getorigins();
        stingtargstruct stingtargstruct_getinreticle();
        
        if ( !stingtargstruct stingtargstruct_isinreticle() )
        {
            resetmissilelauncherlocking();
            return;
        }
        
        stingtargstruct stingtargstruct_getinlos();
        
        if ( !softsighttest( stingtargstruct ) )
        {
            return;
        }
        
        utility::callsharedfunc( #"flare_system", #"hash_c402efcb2b8bce33", stingtargstruct.target );
        timepassed = gettime() - self.missilelauncherlockstarttime;
        locklength = level.missilelauncherlocklength ?? 500;
        
        if ( isdefined( self.perks[ "specialty_fasterlockon" ] ) )
        {
            if ( timepassed < locklength * 0.5 )
            {
                return;
            }
        }
        else if ( timepassed < locklength )
        {
            return;
        }
        
        self notify( #"hash_c728629f94d5f61f" );
        thread loopmissilelauncherlockedfeedback();
        missilelauncher_finalizelock( stingtargstruct );
        self.missilelauncherstage = 2;
    }
    
    if ( self.missilelauncherstage == 2 )
    {
        if ( !isdefined( self.missilelaunchertarget ) )
        {
            resetmissilelauncherlocking();
            return;
        }
        
        if ( self.missilelaunchertarget.var_4efa4e2adc37ef3.size )
        {
            resetmissilelauncherlocking();
            return;
        }
        
        if ( !var_215f461ee332af42 && self.missilelaunchertarget vehicle::is_vehicle() && vehicle::is_friendly_to_player( self.missilelaunchertarget, self ) )
        {
            resetmissilelauncherlocking();
            return;
        }
        
        stingtargstruct = stingtargstruct_create( self, self.missilelaunchertarget );
        stingtargstruct stingtargstruct_getoffsets();
        stingtargstruct stingtargstruct_getorigins();
        stingtargstruct stingtargstruct_getinreticle();
        stingtargstruct stingtargstruct_getinlos();
        
        if ( !softsighttest( stingtargstruct ) )
        {
            return;
        }
        else
        {
            missilelauncher_finalizelock( stingtargstruct );
        }
        
        if ( !stingtargstruct stingtargstruct_isinreticle() )
        {
            resetmissilelauncherlocking();
            return;
        }
        
        utility::callsharedfunc( #"flare_system", #"hash_c402efcb2b8bce33", stingtargstruct.target );
    }
}

// Namespace missilelauncher
// Params 0
// Checksum 0x45de405b, Offset: 0xa7f
// Size: 0x49
function missilelauncherusageloop()
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    self endon( #"death_or_disconnect" );
    self endon( #"faux_spawn" );
    self endon( #"end_launcher" );
    thread resetmissilelauncherlockingondeath();
    
    for ( ;; )
    {
        wait 0.05;
        profilestart();
        missilelauncherusage();
        profilestop();
    }
}

// Namespace missilelauncher
// Params 1
// Checksum 0xc97854e, Offset: 0xad0
// Size: 0x10d
function missilelauncher_finalizelock( stingtargstruct )
{
    offset = undefined;
    
    if ( isdefined( stingtargstruct.target ) && stingtargstruct.target.vehiclename == "light_tank" )
    {
        offset = ( 0, 0, 75 );
    }
    else if ( isdefined( stingtargstruct.inlosid ) )
    {
        offset = stingtargstruct.offsets[ stingtargstruct.inlosid ];
        offset = ( offset[ 1 ], -1 * offset[ 0 ], offset[ 2 ] );
    }
    else
    {
        offset = ( 0, 0, 0 );
    }
    
    if ( !isent( self.missilelaunchertarget ) )
    {
        self weaponlockfinalize( self.missilelaunchertarget.origin, offset );
        return;
    }
    
    self weaponlockfinalize( self.missilelaunchertarget, offset );
    thread watch_missile_fire( stingtargstruct );
    utility::callsharedfunc( #"missile_launcher", #"hash_440cb26a52fa144e", self.missilelaunchertarget );
}

// Namespace missilelauncher
// Params 1, eflags: 0xc
// Checksum 0x76e7f429, Offset: 0xbe5
// Size: 0x7c
function private function_88069b6ff0b574b7( target )
{
    self notify( #"hash_5a6eecca67377fb" );
    self endon( #"hash_5a6eecca67377fb" );
    self endon( #"death_or_disconnect", #"hash_43049ecfa18e32e2", #"missile_fire", #"end_launcher" );
    target endon( #"death" );
    target waittill( #"disable_lockon" );
    
    if ( self.missilelaunchertarget == target )
    {
        thread resetmissilelauncherlocking();
    }
}

// Namespace missilelauncher
// Params 1
// Checksum 0x9c1c8ab8, Offset: 0xc69
// Size: 0x90
function watch_missile_fire( stingtargstruct )
{
    self notify( #"hash_d53a3db5b1cf7699" );
    self endon( #"hash_d53a3db5b1cf7699" );
    self waittill( #"missile_fire", missile );
    
    if ( isdefined( self ) && isdefined( missile ) )
    {
        utility::callsharedfunc( #"flare_system", #"attacker_fire_missile", missile, stingtargstruct.target );
        utility::callsharedfunc( #"missile_launcher", #"lockedon_missile_fired", self.missilelaunchertarget );
    }
}

// Namespace missilelauncher
// Params 1, eflags: 0xc
// Checksum 0x4596ea9f, Offset: 0xd01
// Size: 0x75
function private function_97a7f497a684b12( target )
{
    self notify( #"hash_858d17d0b91125c" );
    self endon( #"hash_858d17d0b91125c" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_43049ecfa18e32e2" );
    self endon( #"end_launcher" );
    self waittill( #"missile_fire", missile, weapon );
    thread function_11eea0b50c7ddf92( missile, target );
}

// Namespace missilelauncher
// Params 2, eflags: 0x4
// Checksum 0x1259c528, Offset: 0xd7e
// Size: 0x58
function private function_11eea0b50c7ddf92( missile, target )
{
    self endon( #"death_or_disconnect" );
    target endon( #"death", #"disable_lockon" );
    
    while ( isdefined( missile ) )
    {
        missile missile_settargetpos( target.origin );
        wait 0.05;
    }
}

// Namespace missilelauncher
// Params 2
// Checksum 0x3b1e239b, Offset: 0xdde
// Size: 0xb9
function stingtargstruct_create( player, target )
{
    struct = spawnstruct();
    struct.player = player;
    struct.target = target;
    struct.offsets = [];
    struct.origins = [];
    struct.inreticledistssqr = [];
    struct.inreticlesortedids = [];
    struct.inlosid = undefined;
    
    if ( isdefined( target.useoldlosverification ) )
    {
        struct.useoldlosverification = target.useoldlosverification;
    }
    else
    {
        struct.useoldlosverification = 1;
    }
    
    return struct;
}

// Namespace missilelauncher
// Params 0
// Checksum 0xd33cfa00, Offset: 0xea0
// Size: 0x481
function stingtargstruct_getoffsets()
{
    self.offsets = [];
    
    if ( utility::issharedfuncdefined( #"missile_launcher", #"stingOffsetsGameModeSpecific" ) && [[ utility::getsharedfunc( #"missile_launcher", #"stingOffsetsGameModeSpecific" ) ]]() )
    {
        return;
    }
    
    if ( self.target.vehiclename == "light_tank" )
    {
        self.offsets[ self.offsets.size ] = ( 0, 0, 72 );
        self.useoldlosverification = 0;
        return;
    }
    
    if ( self.target.vehiclename == "apc_russian" )
    {
        self.offsets[ self.offsets.size ] = ( 0, 0, 60 );
        self.useoldlosverification = 0;
        return;
    }
    
    if ( self.target.vehiclename == "cargo_truck" || self.target.vehiclename == "cargo_truck_mg" )
    {
        self.offsets[ self.offsets.size ] = ( 0, 0, 60 );
        self.useoldlosverification = 0;
        return;
    }
    
    if ( self.target.vehiclename == "large_transport" )
    {
        self.offsets[ self.offsets.size ] = ( 0, 0, 65 );
        self.useoldlosverification = 0;
        return;
    }
    
    if ( self.target.vehiclename == "medium_transport" )
    {
        self.offsets[ self.offsets.size ] = ( 0, 0, 60 );
        self.useoldlosverification = 0;
        return;
    }
    
    if ( self.target.vehiclename == "pickup_truck" || self.target.vehiclename == "technical" )
    {
        self.offsets[ self.offsets.size ] = ( 0, 0, 55 );
        self.useoldlosverification = 0;
        return;
    }
    
    if ( self.target.vehiclename == "jeep" || self.target.vehiclename == "tac_rover" )
    {
        self.offsets[ self.offsets.size ] = ( 0, 0, 50 );
        self.useoldlosverification = 0;
        return;
    }
    
    if ( self.target vehicle::get_ref() == %"vehiclebundle:veh9_rhib_mp" )
    {
        self.offsets[ self.offsets.size ] = ( 0, 0, 20 );
        self.useoldlosverification = 0;
        return;
    }
    
    if ( self.target.vehiclename == "loot_chopper" )
    {
        self.offsets[ self.offsets.size ] = ( 0, 0, -100 );
        self.useoldlosverification = 0;
        return;
    }
    
    if ( self.target.var_d1b3f29a9c852576 )
    {
        self.offsets[ self.offsets.size ] = self.target.var_d1b3f29a9c852576;
        return;
    }
    
    if ( self.target.var_7fa58df0ef92afbf )
    {
        self.offsets = self.target.var_7fa58df0ef92afbf;
        return;
    }
    
    if ( self.target vehicle::is_vehicle() )
    {
        centerofmass = function_48ce6831f7539eb( self.target );
        
        if ( isdefined( centerofmass ) )
        {
            self.offsets[ self.offsets.size ] = coordtransformtranspose( centerofmass, self.target.origin, self.target.angles );
            self.useoldlosverification = 0;
        }
        else
        {
            self.offsets[ self.offsets.size ] = ( 0, 0, 0 );
        }
        
        return;
    }
    
    self.offsets[ self.offsets.size ] = ( 0, 0, 0 );
}

// Namespace missilelauncher
// Params 1
// Checksum 0xcaa5cb55, Offset: 0x1329
// Size: 0x2d
function function_48ce6831f7539eb( vehicle )
{
    var_463896d29cfe4e45 = vehicle physics_getentitycenterofmass();
    
    if ( !isdefined( var_463896d29cfe4e45 ) )
    {
        return;
    }
    
    return var_463896d29cfe4e45[ "unscaled" ];
}

// Namespace missilelauncher
// Params 0
// Checksum 0x2b193f7e, Offset: 0x135f
// Size: 0xca
function stingtargstruct_getorigins()
{
    origin = self.target.origin;
    angles = self.target.angles;
    forward = anglestoforward( angles );
    right = anglestoright( angles );
    up = anglestoup( angles );
    
    for ( i = 0; i < self.offsets.size ; i++ )
    {
        offset = self.offsets[ i ];
        self.origins[ i ] = origin + right * offset[ 0 ] + forward * offset[ 1 ] + up * offset[ 2 ];
    }
}

// Namespace missilelauncher
// Params 0
// Checksum 0xaa9c8593, Offset: 0x1431
// Size: 0x1dd
function stingtargstruct_getinreticle()
{
    foreach ( origin in self.origins )
    {
        for ( i = 0; i < self.origins.size ; i++ )
        {
            screenpos = self.player worldpointtoscreenpos( self.origins[ i ], 65 );
            
            if ( isdefined( screenpos ) )
            {
                distsqr = length2dsquared( screenpos );
                
                if ( distsqr <= ( level.var_59584ca20ff01a28 ?? 576 ) )
                {
                    self.inreticlesortedids[ self.inreticlesortedids.size ] = i;
                    self.inreticledistssqr[ i ] = distsqr;
                }
            }
        }
    }
    
    if ( self.inreticlesortedids.size > 1 )
    {
        for ( i = 0; i < self.inreticlesortedids.size ; i++ )
        {
            for ( j = i + 1; j < self.inreticlesortedids.size ; j++ )
            {
                i_id = self.inreticlesortedids[ i ];
                j_id = self.inreticlesortedids[ j ];
                var_cc5e58aee9ad037c = self.inreticledistssqr[ i_id ];
                var_44eac8ee3320e439 = self.inreticledistssqr[ j_id ];
                
                if ( var_44eac8ee3320e439 < var_cc5e58aee9ad037c )
                {
                    tempid = i_id;
                    self.inreticlesortedids[ i ] = j_id;
                    self.inreticlesortedids[ j ] = tempid;
                }
            }
        }
    }
}

// Namespace missilelauncher
// Params 0
// Checksum 0xf53c890d, Offset: 0x1616
// Size: 0x402
function stingtargstruct_getinlos()
{
    caststart = self.player geteye();
    contents = physics_createcontents( [ "physicscontents_water", "physicscontents_item", "physicscontents_playernosight" ] );
    
    if ( !isent( self.target ) )
    {
        ignorearr = [ self.player ];
        
        for ( i = 0; i < self.inreticlesortedids.size ; i++ )
        {
            id = self.inreticlesortedids[ i ];
            castend = self.origins[ id ];
            castresults = physics_raycast( caststart, castend, contents, ignorearr, 0, "physicsquery_closest", 1 );
            
            if ( !isdefined( castresults ) || castresults.size == 0 )
            {
                self.inlosid = id;
                return;
            }
        }
        
        return;
    }
    
    ignorearr = [ self.player, self.target ];
    var_2129b5ebd3571d29 = self.target getlinkedchildren();
    
    if ( var_2129b5ebd3571d29.size > 0 )
    {
        ignorearr = arraycombine( ignorearr, var_2129b5ebd3571d29 );
    }
    
    if ( !self.useoldlosverification )
    {
        for ( i = 0; i < self.inreticlesortedids.size ; i++ )
        {
            id = self.inreticlesortedids[ i ];
            castend = self.origins[ id ];
            castresults = physics_raycast( caststart, castend, contents, ignorearr, 0, "physicsquery_closest", 1 );
            
            if ( !isdefined( castresults ) || castresults.size == 0 )
            {
                self.inlosid = id;
                return;
            }
        }
        
        return;
    }
    
    top = self.target getpointinbounds( 0, 0, 1 );
    trace = trace::ray_trace( caststart, top, ignorearr, contents, 0 );
    
    /#
        if ( getdvarint( @"missiledebugdraw" ) == 2 )
        {
            playerangles = self.player getplayerangles();
            left = anglestoleft( playerangles );
            hitpos = trace[ "<dev string:x24>" ];
            sphere( hitpos, 10, ( 1, 0, 0 ), 0, 1 );
            sphere( hitpos, 10, ( 0, 1, 0 ), 1, 1 );
            disttohit = distance( caststart, hitpos );
            print3d( hitpos + left * -20, string( disttohit ), ( 1, 1, 1 ), 1, 1, 1 );
            wingbasepos = self.player.origin;
            var_3fcbef5d8a13140e = wingbasepos + left * 50;
            line( var_3fcbef5d8a13140e, hitpos, ( 0, 1, 0 ), 1, 1, 1 );
            var_75ace1b29e67463 = wingbasepos + left * -50;
            line( var_75ace1b29e67463, hitpos, ( 0, 1, 0 ), 1, 1, 1 );
            var_3fcbef5d8a13140e += ( 0, 0, 100 );
            line( var_3fcbef5d8a13140e, hitpos, ( 0, 1, 0 ), 1, 1, 1 );
            var_75ace1b29e67463 += ( 0, 0, 100 );
            line( var_75ace1b29e67463, hitpos, ( 0, 1, 0 ), 1, 1, 1 );
        }
    #/
    
    if ( trace[ "fraction" ] == 1 )
    {
        self.inlosid = 0;
        return;
    }
    
    front = self.target getpointinbounds( 1, 0, 0 );
    trace = trace::ray_trace( caststart, front, ignorearr, contents, 0 );
    
    if ( trace[ "fraction" ] == 1 )
    {
        self.inlosid = 0;
        return;
    }
    
    back = self.target getpointinbounds( -1, 0, 0 );
    trace = trace::ray_trace( caststart, back, ignorearr, contents, 0 );
    
    if ( trace[ "fraction" ] == 1 )
    {
        self.inlosid = 0;
        return;
    }
}

// Namespace missilelauncher
// Params 0
// Checksum 0x37912ae0, Offset: 0x1a20
// Size: 0xe, Type: bool
function stingtargstruct_isinreticle()
{
    return self.inreticlesortedids.size > 0;
}

// Namespace missilelauncher
// Params 0
// Checksum 0xa34f77a7, Offset: 0x1a37
// Size: 0xc, Type: bool
function stingtargstruct_isinlos()
{
    return isdefined( self.inlosid );
}

/#

    // Namespace missilelauncher
    // Params 0
    // Checksum 0x95a527ae, Offset: 0x1a4c
    // Size: 0xd6, Type: dev
    function debug_init()
    {
        setdevdvarifuninitialized( @"hash_ad918199a0825d3a", 125 );
        setdevdvarifuninitialized( @"jackal_f", 250 );
        setdevdvarifuninitialized( @"jackal_f_up", 125 );
        setdevdvarifuninitialized( @"jackal_b", 425 );
        setdevdvarifuninitialized( @"jackal_b_up", 125 );
        setdevdvarifuninitialized( @"jackal_lr", 250 );
        setdevdvarifuninitialized( @"jackal_lr_up", 140 );
        setdevdvarifuninitialized( @"jackal_lr_back", 215 );
        setdevdvarifuninitialized( @"hash_9b2345c5373f7e68", 30 );
        setdevdvarifuninitialized( @"hash_a6d283ccfd72e0d2", 5 );
        setdevdvarifuninitialized( @"hash_c3840a33843aa1f2", 15 );
        setdevdvarifuninitialized( @"hash_5a2bc3bd648b860c", 42 );
        setdevdvarifuninitialized( @"hash_9bb2d0feba0e1fde", 5 );
    }

    // Namespace missilelauncher
    // Params 1
    // Checksum 0x81e676e8, Offset: 0x1b2a
    // Size: 0x7e, Type: dev
    function missilelauncherdebugdraw( target )
    {
        if ( getdvarint( @"missiledebugdraw" ) != 1 )
        {
            return;
        }
        
        if ( !isdefined( target ) )
        {
            return;
        }
        
        org = target.origin;
        drawstar( org );
        
        if ( isent( target ) )
        {
            org = target getpointinbounds( 1, 0, 0 );
            drawstar( org );
            org = target getpointinbounds( -1, 0, 0 );
            drawstar( org );
        }
    }

    // Namespace missilelauncher
    // Params 1
    // Checksum 0x6a3a009e, Offset: 0x1bb0
    // Size: 0x7e, Type: dev
    function drawstar( point )
    {
        line( point + ( 10, 0, 0 ), point - ( 10, 0, 0 ) );
        line( point + ( 0, 10, 0 ), point - ( 0, 10, 0 ) );
        line( point + ( 0, 0, 10 ), point - ( 0, 0, 10 ) );
    }

#/
