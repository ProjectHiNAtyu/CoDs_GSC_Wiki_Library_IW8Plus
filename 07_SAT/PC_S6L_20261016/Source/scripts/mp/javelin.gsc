// scripts\mp\javelin.gsc  (hash_61785096cd84035f.gscc) (size: 17996 Bytes / 0x464c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x73548982 (1934920066)
// size ...... 17996 (0x464c)
// includes .. 12  (offset: 0x42a8)
// strings ... 34  (offset: 0x4308)
// dev strs .. 13  (offset: 0x45a0)
// exports ... 48  (offset: 0x2ad0)
// cseg ...... 0x27f + 0x2851 (0x2ad0)
// imports ... 132 (offset: 0x3250)
// animtree1 . 0   (offset: 0x464c)
// animtree2 . 0   (offset: 0x464c)
#using script_16ea1b94f0f381b3;
#using scripts\common\targetmarkergroups;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\entity;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\emp_debuff;
#using scripts\mp\ent_manager;
#using scripts\mp\weapons;

#namespace javelin;

// Namespace javelin
// Params 0
// Checksum 0x73681beb, Offset: 0x29d
// Size: 0xe0
function javelinusageloop()
{
    self endon( #"death_or_disconnect" );
    self endon( #"faux_spawn" );
    self endon( #"end_launcher" );
    javelin_init();
    thread function_b3a9719fa45e5750();
    
    while ( true )
    {
        weapon = self getcurrentweapon();
        
        if ( issubstr( weapon.basename, "la_juliet_mp" ) || issubstr( weapon.basename, "la_maryland_mp" ) || issubstr( weapon.basename, "la_louisiana_mp" ) && javelin_shouldjavelinthink() )
        {
            self.javelin.stopthinking = 0;
            thread javelin_think();
        }
        else
        {
            self.javelin.stopthinking = 1;
        }
        
        self waittill( #"weapon_change" );
    }
}

// Namespace javelin
// Params 0
// Checksum 0xd36697bb, Offset: 0x385
// Size: 0x2e
function function_b3a9719fa45e5750()
{
    self endon( #"death_or_disconnect" );
    self endon( #"faux_spawn" );
    self waittill( #"end_launcher" );
    javelin_forceclear();
}

// Namespace javelin
// Params 0
// Checksum 0x5be6819f, Offset: 0x3bb
// Size: 0x2a7
function javelin_init()
{
    self.javelin = spawnstruct();
    
    if ( !isdefined( level.javelin ) )
    {
        level.javelin = spawnstruct();
        level.javelin.states = [];
        level.javelin.states[ "off" ] = [];
        level.javelin.states[ "off" ][ "enter" ] = &javelin_offstateenter;
        level.javelin.states[ "off" ][ "update" ] = &javelin_offstateupdate;
        level.javelin.states[ "off" ][ "exit" ] = &javelin_offstateexit;
        level.javelin.states[ "scanning" ] = [];
        level.javelin.states[ "scanning" ][ "enter" ] = &javelin_scanningstateenter;
        level.javelin.states[ "scanning" ][ "update" ] = &javelin_scanningstateupdate;
        level.javelin.states[ "hold" ] = [];
        level.javelin.states[ "hold" ][ "enter" ] = &javelin_holdstateenter;
        level.javelin.states[ "hold" ][ "update" ] = &javelin_holdstateupdate;
        level.javelin.states[ "hold" ][ "exit" ] = &javelin_holdstateexit;
        level.javelin.states[ "fire" ] = [];
        level.javelin.states[ "fire" ][ "enter" ] = &javelin_firestateenter;
        level.javelin.states[ "fire" ][ "update" ] = &javelin_firestateupdate;
        level.javelin.states[ "fire" ][ "exit" ] = &javelin_firestateexit;
        level.javelin.states[ "too_close" ] = [];
        level.javelin.states[ "too_close" ][ "enter" ] = &javelin_tooclosestateenter;
        level.javelin.states[ "too_close" ][ "update" ] = &javelin_tooclosestateupdate;
    }
}

// Namespace javelin
// Params 0
// Checksum 0x1d358599, Offset: 0x66a
// Size: 0x11a
function javelin_reset()
{
    if ( !isdefined( self.javelin ) )
    {
        return;
    }
    
    self.javelin.adsraisedelaytimer = undefined;
    self.javelin.target = undefined;
    self.javelin.lockstarttime = undefined;
    self.javelin.vehiclelostsightlinetime = undefined;
    self.javelin.groundlockmisses = 0;
    self.javelin.targetnormal = undefined;
    
    if ( isdefined( self.javelin.groundlockonent ) )
    {
        self.javelin.groundlockonent ent_manager::deregisterspawn();
        self.javelin.groundlockonent delete();
    }
    
    self.javelin.groundlockonent = undefined;
    self.javelin.groundpoints = undefined;
    self.javelin.state = undefined;
    self.javelin.queuedstate = undefined;
}

// Namespace javelin
// Params 1
// Checksum 0x62e02bb7, Offset: 0x78c
// Size: 0xbd
function javelin_offstateenter( fromstate )
{
    if ( isdefined( self.javelin.target ) )
    {
        weapon_utility::removelockedon( self.javelin.target, self );
        self.javelin.target = undefined;
    }
    
    if ( isdefined( self.javelin.groundlockonent ) )
    {
        self.javelin.groundlockonent ent_manager::deregisterspawn();
        self.javelin.groundlockonent delete();
    }
    
    self.javelin.groundlockonent = undefined;
    javelin_hidenormalhud( 0 );
    javelin_setuistate( 0 );
}

// Namespace javelin
// Params 0
// Checksum 0xd5150495, Offset: 0x851
// Size: 0x1c
function javelin_offstateupdate()
{
    if ( self playerads() >= 0.9 )
    {
        javelin_queuestate( "scanning" );
    }
}

// Namespace javelin
// Params 0
// Checksum 0xa96b4377, Offset: 0x875
// Size: 0xb
function javelin_offstateexit()
{
    javelin_hidenormalhud( 1 );
}

// Namespace javelin
// Params 0
// Checksum 0x202575af, Offset: 0x888
// Size: 0x34
function function_bfd375d331f0b81c()
{
    self endon( #"disconnect" );
    utility::waittill_any( "death", "end_launcher", "faux_spawn" );
    javelin_hidenormalhud( 0 );
    javelin_setuistate( 0 );
}

// Namespace javelin
// Params 0
// Checksum 0x7ae656b2, Offset: 0x8c4
// Size: 0xd4
function function_a3233a51e0fd6405()
{
    self endon( #"weapon_change" );
    self waittill( #"death_or_disconnect" );
    
    if ( isdefined( self.javelin ) )
    {
        if ( isdefined( self.javelin.target ) )
        {
            weapon_utility::removelockedon( self.javelin.target, self );
            
            if ( isdefined( self ) )
            {
                self weaponlockfree();
            }
            
            self.javelin.target = undefined;
        }
        
        if ( isdefined( self.javelin.groundlockonent ) )
        {
            self.javelin.groundlockonent ent_manager::deregisterspawn();
            self.javelin.groundlockonent delete();
            self.javelin.groundlockonent = undefined;
        }
    }
}

// Namespace javelin
// Params 1
// Checksum 0x4ebb485d, Offset: 0x9a0
// Size: 0x30
function javelin_scanningstateenter( fromstate )
{
    javelin_setuistate( 1 );
    self.javelin.adsraisedelaytimer = gettime() + 100;
}

// Namespace javelin
// Params 0
// Checksum 0x435df8a3, Offset: 0x9d8
// Size: 0x503
function javelin_scanningstateupdate()
{
    if ( gettime() < self.javelin.adsraisedelaytimer )
    {
        return;
    }
    
    vehicletarget = javelin_scanforvehicletarget();
    
    if ( isdefined( vehicletarget ) )
    {
        if ( javelin_targetpointtooclose( vehicletarget.origin ) )
        {
            javelin_queuestate( "too_close" );
            return;
        }
        
        /#
            javelin_debugtext( "<dev string:x24>" );
        #/
        
        self.javelin.target = vehicletarget;
        
        if ( isdefined( self.javelin.target ) )
        {
            weapon_utility::addlockedon( self.javelin.target, self );
        }
        
        if ( !isdefined( self.javelinlocationtargeted ) )
        {
            marklocation( self.javelin.target );
        }
        
        javelin_queuestate( "hold" );
        return;
    }
    
    if ( self attackbuttonpressed() )
    {
        if ( self.javelin.groundlockmisses >= 1 )
        {
            self.javelin.groundlockmisses = 0;
            self.javelin.groundpoints = undefined;
            return;
        }
        
        /#
            if ( getdvar( @"missiledebugdraw" ) == "<dev string:x4f>" && isdefined( self.javelin.groundpoints ) )
            {
                foreach ( var_f5d679bfe5b028f7 in self.javelin.groundpoints )
                {
                    function_c42e09ce8592aa74( var_f5d679bfe5b028f7, ( 0.8, 1, 0.8 ) );
                }
                
                function_c42e09ce8592aa74( self.javelin.groundpoints[ self.javelin.groundpoints.size - 1 ], ( 1, 1, 0.2 ) );
                function_c42e09ce8592aa74( averagepoint( self.javelin.groundpoints ), ( 0.2, 0.2, 1 ) );
            }
        #/
        
        traceresults = javelin_eyetraceforward();
        
        if ( !isdefined( traceresults ) )
        {
            self.javelin.groundlockmisses++;
            return;
        }
        
        if ( javelin_targetpointtooclose( traceresults[ 0 ] ) )
        {
            javelin_queuestate( "too_close" );
            return;
        }
        
        if ( isdefined( self.javelin.groundpoints ) )
        {
            var_b3a0cc161ca878c1 = averagepoint( self.javelin.groundpoints );
            dist = distance( var_b3a0cc161ca878c1, traceresults[ 0 ] );
            
            if ( dist > 400 )
            {
                self.javelin.groundlockmisses++;
                return;
            }
        }
        else
        {
            self.javelin.groundpoints = [];
            self.javelin.groundnormals = [];
        }
        
        self.javelin.groundpoints[ self.javelin.groundpoints.size ] = traceresults[ 0 ];
        self.javelin.groundnormals[ self.javelin.groundnormals.size ] = traceresults[ 1 ];
        self.javelin.groundlockmisses = 0;
        
        if ( self.javelin.groundpoints.size < 2 )
        {
            return;
        }
        
        targetpoint = averagepoint( self.javelin.groundpoints );
        self.javelin.groundlockonent = utility::spawn_tag_origin( targetpoint );
        self.javelin.groundlockonent ent_manager::registerspawncount( 1 );
        self.javelin.target = self.javelin.groundlockonent;
        self.javelin.target.firsthitent = utility::spawn_tag_origin( traceresults[ 2 ] );
        self.javelin.target.firsthitent ent_manager::registerspawncount( 1 );
        self.javelin.groundlockmisses = 0;
        self.javelin.groundpoints = undefined;
        self.javelin.groundnormals = undefined;
        
        if ( !isdefined( self.javelinlocationtargeted ) )
        {
            marklocation( self.javelin.target.firsthitent );
        }
        
        javelin_queuestate( "hold" );
    }
}

// Namespace javelin
// Params 1
// Checksum 0xb0abe2b8, Offset: 0xee3
// Size: 0xc5
function javelin_holdstateenter( fromstate )
{
    if ( !isdefined( self.javelin.target ) )
    {
        return;
    }
    
    javelin_setuistate( 2 );
    self.javelin.lockstarttime = gettime();
    self.javelin.lostsightlinetime = 0;
    
    if ( isent( self.javelin.target ) )
    {
        self weaponlockstart( self.javelin.target );
    }
    else
    {
        self weaponlockstart( self.javelin.target.origin );
    }
    
    thread javelin_looplocalseeksound( "javelin_clu_acquiring_lock", 0.5 );
}

// Namespace javelin
// Params 0
// Checksum 0x10ab13a9, Offset: 0xfb0
// Size: 0x24f
function javelin_holdstateupdate()
{
    var_215f461ee332af42 = 0;
    
    /#
        var_215f461ee332af42 = getdvarint( @"hash_10368af4dee3ba2c", 0 );
    #/
    
    /#
        if ( getdvar( @"missiledebugdraw" ) == "<dev string:x4f>" )
        {
            function_c42e09ce8592aa74( self.javelin.target.origin, ( 0.5, 1, 0.6 ) );
        }
    #/
    
    if ( !isdefined( self.javelin.target ) )
    {
        javelin_queuestate( "scanning" );
        return;
    }
    
    losthold = 0;
    
    if ( !var_215f461ee332af42 && self.javelin.target vehicle::is_vehicle() && vehicle::is_friendly_to_player( self.javelin.target, self ) )
    {
        if ( !isdefined( self.javelin.target.sentientpool ) )
        {
            javelin_queuestate( "scanning" );
            losthold = 1;
        }
    }
    
    if ( !javelin_checktargetstillheld( self.javelin.target ) )
    {
        javelin_queuestate( "scanning" );
        losthold = 1;
    }
    
    if ( javelin_targetpointtooclose( self.javelin.target.origin ) )
    {
        javelin_queuestate( "too_close" );
        losthold = 1;
    }
    
    if ( losthold )
    {
        if ( isdefined( self.javelin.target ) )
        {
            weapon_utility::removelockedon( self.javelin.target, self );
        }
        
        self weaponlockfree();
        self.javelin.target = undefined;
        
        if ( isdefined( self.javelin.groundlockonent ) )
        {
            self.javelin.groundlockonent delete();
        }
    }
    
    timepassed = gettime() - self.javelin.lockstarttime;
    lockonlength = isdefined( self.perks[ "specialty_fasterlockon" ] ) ? 575 : 1150;
    
    if ( timepassed < lockonlength )
    {
        return;
    }
    
    javelin_queuestate( "fire" );
}

// Namespace javelin
// Params 0
// Checksum 0xcdfe5c26, Offset: 0x1207
// Size: 0x19
function javelin_holdstateexit()
{
    self notify( #"stop_lockon_sound" );
    self stoplocalsound( "javelin_clu_acquiring_lock" );
}

// Namespace javelin
// Params 1
// Checksum 0x75f96283, Offset: 0x1228
// Size: 0x1ef
function javelin_firestateenter( fromstate )
{
    javelin_setuistate( 3 );
    
    if ( !isdefined( self.javelin.target ) )
    {
        return;
    }
    
    isentity = isent( self.javelin.target );
    
    if ( isentity && isplayer( self.javelin.target ) )
    {
        self weaponlockfinalize( self.javelin.target, ( 0, 0, 64 ), 0 );
    }
    else if ( isdefined( self.javelin.groundlockonent ) )
    {
        self weaponlockfinalize( self.javelin.target, ( 0, 0, 0 ), 1 );
    }
    else if ( !isentity )
    {
        self weaponlockfinalize( self.javelin.target.origin, ( 0, 0, 0 ), 1 );
        thread function_334271d632d69f25( self.javelin.target );
    }
    else
    {
        vehicleoffset = javelin_getvehicleoffset( self.javelin.target );
        self weaponlockfinalize( self.javelin.target, vehicleoffset, 0 );
    }
    
    weapon = self getcurrentweapon();
    
    if ( getdvarint( @"javelin_split", weapon.basenamehash == %"zul_la_louisiana_mp" ) )
    {
        ent = spawn( "script_model", self.javelin.target.origin );
        thread prototype_split( ent );
    }
    
    thread javelin_looplocalseeksound( "javelin_clu_lock", 1.6 );
}

// Namespace javelin
// Params 0
// Checksum 0x440fb4c8, Offset: 0x141f
// Size: 0x111
function javelin_firestateupdate()
{
    var_215f461ee332af42 = 0;
    
    /#
        var_215f461ee332af42 = getdvarint( @"hash_10368af4dee3ba2c", 0 );
    #/
    
    if ( !isdefined( self.javelin.target ) )
    {
        javelin_queuestate( "scanning" );
        return;
    }
    
    if ( !var_215f461ee332af42 && self.javelin.target vehicle::is_vehicle() && vehicle::is_friendly_to_player( self.javelin.target, self ) )
    {
        if ( !isdefined( self.javelin.target.sentientpool ) )
        {
            javelin_queuestate( "scanning" );
        }
    }
    
    if ( !javelin_checktargetstillheld( self.javelin.target ) )
    {
        javelin_queuestate( "scanning" );
    }
    
    if ( javelin_targetpointtooclose( self.javelin.target.origin ) )
    {
        javelin_queuestate( "too_close" );
    }
}

// Namespace javelin
// Params 0
// Checksum 0xf09f30a2, Offset: 0x1538
// Size: 0x9f
function javelin_firestateexit()
{
    if ( isdefined( self.javelin.target ) )
    {
        weapon_utility::removelockedon( self.javelin.target, self );
    }
    
    self weaponlockfree();
    self.javelin.target = undefined;
    
    if ( isdefined( self.javelin.groundlockonent ) )
    {
        self.javelin.groundlockonent delete();
    }
    
    self notify( #"stop_lockon_sound" );
    
    if ( soundexists( "javelin_clu_lock" ) )
    {
        self stoplocalsound( "javelin_clu_lock" );
    }
}

// Namespace javelin
// Params 1, eflags: 0x4
// Checksum 0x331bd5ea, Offset: 0x15df
// Size: 0x62
function private function_334271d632d69f25( target )
{
    self endon( #"death_or_disconnect" );
    self waittill( #"missile_fire", missile, weapon );
    
    while ( isdefined( missile ) && isdefined( target ) )
    {
        missile missile_settargetpos( target.origin );
        wait 0.05;
    }
}

// Namespace javelin
// Params 1
// Checksum 0x15087100, Offset: 0x1649
// Size: 0x15
function javelin_tooclosestateenter( fromstate )
{
    javelin_setuistate( 4 );
}

// Namespace javelin
// Params 0
// Checksum 0x83083c57, Offset: 0x1666
// Size: 0x79
function javelin_tooclosestateupdate()
{
    vehicletarget = javelin_scanforvehicletarget();
    
    if ( isdefined( vehicletarget ) )
    {
        if ( !javelin_targetpointtooclose( vehicletarget.origin ) )
        {
            javelin_queuestate( "scanning" );
            return;
        }
        
        return;
    }
    
    traceresults = javelin_eyetraceforward();
    
    if ( !isdefined( traceresults ) || isdefined( traceresults ) && javelin_targetpointtooclose( traceresults[ 0 ] ) == 0 )
    {
        javelin_queuestate( "scanning" );
        return;
    }
}

// Namespace javelin
// Params 0
// Checksum 0x44c5ce6e, Offset: 0x16e7
// Size: 0x50
function javelin_preupdate()
{
    if ( isdefined( self.javelin.state ) && self.javelin.state != "off" )
    {
        if ( self playerads() < 0.9 )
        {
            javelin_queuestate( "off" );
        }
    }
}

// Namespace javelin
// Params 1
// Checksum 0xdeaba299, Offset: 0x173f
// Size: 0xb2, Type: bool
function javelin_checktargetstillheld( targetent )
{
    if ( !isdefined( targetent ) )
    {
        return false;
    }
    
    var_421c8c0fd6dc541f = targetent;
    
    if ( isdefined( targetent.firsthitent ) )
    {
        var_421c8c0fd6dc541f = targetent.firsthitent;
    }
    
    insidereticle = self worldpointinreticle_rect( var_421c8c0fd6dc541f.origin, 35, 120, 80 );
    
    if ( !insidereticle )
    {
        return false;
    }
    
    if ( !isdefined( self.javelin.groundlockonent ) && !javelin_softsighttest( targetent ) )
    {
        return false;
    }
    
    if ( isdefined( self.javelin.groundlockonent ) )
    {
        if ( !self attackbuttonpressed() )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace javelin
// Params 0
// Checksum 0x60e2ca00, Offset: 0x17fa
// Size: 0x153
function javelin_eyetraceforward()
{
    origin = self geteye();
    gunangles = self getgunangles();
    gunforward = anglestoforward( gunangles );
    endpoint = origin + gunforward * 15000;
    firsthit = trace::ray_trace( origin, endpoint, undefined, undefined, 1 );
    
    if ( !isdefined( firsthit ) || firsthit[ "surfacetype" ] == "surftype_none" && firsthit[ "hittype" ] == "hittype_none" || firsthit[ "surfacetype" ] == "default" )
    {
        return;
    }
    
    var_1e20f4f281aeff9d = firsthit;
    var_829d892004a2f986 = function_70fd8d2d8bcb50b7( firsthit, gunforward );
    
    if ( isdefined( var_829d892004a2f986 ) )
    {
        var_1e20f4f281aeff9d = var_829d892004a2f986;
    }
    
    /#
        if ( getdvar( @"missiledebugdraw" ) == "<dev string:x4f>" )
        {
            thread trace::draw_trace( firsthit, ( 1, 1, 0 ), 0, 1000 );
            thread debug::drawsphere( var_1e20f4f281aeff9d[ "<dev string:x51>" ], 5, 20, ( 1, 0, 1 ) );
            iprintlnbold( distance( origin, var_1e20f4f281aeff9d[ "<dev string:x51>" ] ) );
        }
    #/
    
    results = [];
    results[ 0 ] = var_1e20f4f281aeff9d[ "position" ];
    results[ 1 ] = var_1e20f4f281aeff9d[ "normal" ];
    results[ 2 ] = firsthit[ "position" ];
    return results;
}

// Namespace javelin
// Params 2
// Checksum 0xd91895c, Offset: 0x1956
// Size: 0x15a
function function_70fd8d2d8bcb50b7( firsthit, gunforward )
{
    var_16e6f91834f3da84 = 5000;
    var_bbe7e864340549c = getdvarint( @"hash_a0cf49119410b52", 100 );
    var_e6966279cb36b2ed = getdvarint( @"hash_f14add14ff4c308b", 100 );
    
    if ( abs( firsthit[ "normal" ][ 2 ] ) > 0.1 )
    {
        return;
    }
    
    firsthitpos = firsthit[ "position" ];
    testpoint = firsthitpos + gunforward * var_e6966279cb36b2ed;
    var_a7966d62200bd021 = trace::ray_trace_get_all_results( testpoint + ( 0, 0, 100000 ), testpoint - ( 0, 0, var_16e6f91834f3da84 ), undefined, undefined, 1 );
    var_3c7baa1404d4fa69 = undefined;
    
    for ( i = 0; i < var_a7966d62200bd021.size - 1 ; i++ )
    {
        hit = var_a7966d62200bd021[ i ];
        
        if ( hit[ "surfacetype" ] == "surftype_none" )
        {
            continue;
        }
        
        var_3c7baa1404d4fa69 = hit;
        break;
    }
    
    if ( !isdefined( var_3c7baa1404d4fa69 ) )
    {
        return;
    }
    
    var_fe2332a9b1d583fd = var_3c7baa1404d4fa69[ "position" ];
    var_a241b4075547d19b = var_fe2332a9b1d583fd[ 2 ] - firsthitpos[ 2 ];
    
    if ( isdefined( var_3c7baa1404d4fa69 ) && var_a241b4075547d19b < var_bbe7e864340549c && pointinbounds( var_3c7baa1404d4fa69[ "position" ] ) )
    {
        return var_3c7baa1404d4fa69;
    }
}

// Namespace javelin
// Params 1
// Checksum 0xff38176, Offset: 0x1ab8
// Size: 0xa9, Type: bool
function pointinbounds( point )
{
    if ( !isdefined( level.outofboundstriggers ) )
    {
        return true;
    }
    
    foreach ( trigger in level.outofboundstriggers )
    {
        if ( ispointinvolume( point + ( 0, 0, 20 ), trigger ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace javelin
// Params 1
// Checksum 0x82d045db, Offset: 0x1b6a
// Size: 0x34, Type: bool
function javelin_targetpointtooclose( targetpoint )
{
    dist = distance( self.origin, targetpoint );
    
    if ( dist < 850 )
    {
        return true;
    }
    
    return false;
}

// Namespace javelin
// Params 2
// Checksum 0x74e65eb9, Offset: 0x1ba7
// Size: 0x3b
function javelin_looplocalseeksound( alias, interval )
{
    self endon( #"death_or_disconnect" );
    self endon( #"stop_lockon_sound" );
    
    for ( ;; )
    {
        self playlocalsound( alias );
        wait interval;
    }
}

// Namespace javelin
// Params 1
// Checksum 0x4702b73f, Offset: 0x1bea
// Size: 0x22
function javelin_queuestate( statename )
{
    self.javelin.queuedstate = statename;
}

// Namespace javelin
// Params 0
// Checksum 0x7ddf1314, Offset: 0x1c14
// Size: 0x15
function javelin_getqueuedstate()
{
    return self.javelin.queuedstate;
}

// Namespace javelin
// Params 1
// Checksum 0x931d284c, Offset: 0x1c32
// Size: 0x121
function javelin_enterstate( statename )
{
    assert( isdefined( level.javelin.states[ statename ] ), "<dev string:x5a>" + statename + "<dev string:x8d>" );
    
    /#
        javelin_debugtext( "<dev string:x91>" + statename + "<dev string:xaa>" );
    #/
    
    fromstate = self.javelin.state;
    
    if ( isdefined( fromstate ) && isdefined( level.javelin.states[ fromstate ][ "exit" ] ) )
    {
        self [[ level.javelin.states[ fromstate ][ "exit" ] ]]();
    }
    
    self.javelin.state = statename;
    
    if ( isdefined( level.javelin.states[ statename ][ "enter" ] ) )
    {
        self [[ level.javelin.states[ statename ][ "enter" ] ]]( fromstate );
    }
    
    self.javelin.queuedstate = undefined;
}

// Namespace javelin
// Params 0
// Checksum 0xb6ee3d40, Offset: 0x1d5b
// Size: 0x9, Type: bool
function javelin_shouldjavelinthink()
{
    return !emp_debuff::is_empd();
}

// Namespace javelin
// Params 0
// Checksum 0x60e7896b, Offset: 0x1d6d
// Size: 0x126
function javelin_think()
{
    self endon( #"death_or_disconnect" );
    self endon( #"faux_spawn" );
    self endon( #"weapon_change" );
    self notify( #"hash_5d3f4897243f627f" );
    self endon( #"hash_5d3f4897243f627f" );
    javelin_reset();
    javelin_enterstate( "off" );
    thread function_bfd375d331f0b81c();
    thread function_a3233a51e0fd6405();
    var_47f4d9ebd1e5cd8e = 0;
    
    while ( true )
    {
        if ( self.javelin.stopthinking )
        {
            javelin_enterstate( "off" );
            return;
        }
        
        blockthink = !javelin_shouldjavelinthink();
        
        if ( blockthink )
        {
            if ( !var_47f4d9ebd1e5cd8e )
            {
                var_47f4d9ebd1e5cd8e = 1;
                javelin_enterstate( "off" );
            }
        }
        else
        {
            var_47f4d9ebd1e5cd8e = 0;
            javelin_preupdate();
            queuedstate = javelin_getqueuedstate();
            
            if ( isdefined( queuedstate ) )
            {
                javelin_enterstate( queuedstate );
            }
            
            self [[ level.javelin.states[ self.javelin.state ][ "update" ] ]]();
        }
        
        wait 0.05;
    }
}

// Namespace javelin
// Params 0
// Checksum 0x5d5b37a7, Offset: 0x1e9b
// Size: 0x18d
function javelin_scanforvehicletarget()
{
    targets = weapons::lockonlaunchers_gettargetarray();
    var_88d32cd3e0617979 = getdvarint( @"hash_eb7d16d9fa10a208", 625000000 );
    
    if ( targets.size != 0 )
    {
        var_e1c18214523cd849 = [];
        
        foreach ( target in targets )
        {
            if ( !isdefined( target ) )
            {
                continue;
            }
            
            insidereticle = self worldpointinreticle_rect( target.origin, 35, 120, 80 );
            
            if ( insidereticle && distancesquared( target.origin, self.origin ) <= var_88d32cd3e0617979 )
            {
                var_e1c18214523cd849[ var_e1c18214523cd849.size ] = target;
            }
        }
        
        if ( var_e1c18214523cd849.size != 0 )
        {
            sortedtargets = sortbydistance( var_e1c18214523cd849, self.origin );
            
            foreach ( target in sortedtargets )
            {
                if ( javelin_vehiclelocksighttest( target ) )
                {
                    return target;
                }
            }
        }
    }
}

// Namespace javelin
// Params 1
// Checksum 0x42f53d9c, Offset: 0x2031
// Size: 0x150, Type: bool
function javelin_vehiclelocksighttest( target )
{
    eyepos = self geteye();
    
    if ( !isent( target ) )
    {
        contents = physics_createcontents( [ "physicscontents_glass", "physicscontents_water", "physicscontents_item", "physicscontents_playernosight" ] );
        ignorearr = [ self ];
        castresults = physics_raycast( eyepos, target.origin, contents, ignorearr, 0, "physicsquery_closest", 1 );
        
        if ( !isdefined( castresults ) || castresults.size == 0 )
        {
            return true;
        }
        
        return false;
    }
    
    center = target getpointinbounds( 0, 0, 1 );
    passed = sighttracepassed( eyepos, center, 0, target );
    
    /#
        function_dd9c145af9b4dbd4( eyepos, center, passed );
    #/
    
    if ( passed )
    {
        return true;
    }
    
    front = target getpointinbounds( 1, 0, 0 );
    passed = sighttracepassed( eyepos, front, 0, target );
    
    /#
        function_dd9c145af9b4dbd4( eyepos, front, passed );
    #/
    
    if ( passed )
    {
        return true;
    }
    
    back = target getpointinbounds( -1, 0, 0 );
    passed = sighttracepassed( eyepos, back, 0, target );
    
    /#
        function_dd9c145af9b4dbd4( eyepos, back, passed );
    #/
    
    if ( passed )
    {
        return true;
    }
    
    return false;
}

// Namespace javelin
// Params 1
// Checksum 0x4d479b5c, Offset: 0x218a
// Size: 0x146
function javelin_getvehicleoffset( vehicletarget )
{
    offset = ( 0, 0, 0 );
    
    if ( !isdefined( vehicletarget ) )
    {
        return offset;
    }
    
    if ( entity::ischoppergunner( vehicletarget ) )
    {
        offset = ( 0, 0, -50 );
    }
    else if ( entity::issupporthelo( vehicletarget ) )
    {
        offset = ( 0, 0, -100 );
    }
    else if ( entity::isgunship( vehicletarget ) )
    {
        offset = ( 0, 0, 50 );
    }
    else if ( entity::isclusterstrike( vehicletarget ) )
    {
        offset = ( 0, 0, 40 );
    }
    else if ( entity::isradardrone( vehicletarget ) )
    {
        offset = ( 0, 0, 10 );
    }
    else if ( entity::isassaultdrone( vehicletarget ) )
    {
        offset = ( 0, 0, 10 );
    }
    else if ( entity::isscramblerdrone( vehicletarget ) )
    {
        offset = ( 0, 0, 10 );
    }
    else if ( entity::isradarhelicopter( vehicletarget ) )
    {
        offset = ( 0, 0, -30 );
    }
    else if ( isdefined( vehicletarget vehicle::get_ref() ) && vehicletarget vehicle::get_ref() == "loot_chopper" )
    {
        offset = ( 0, 0, -100 );
    }
    
    return offset;
}

// Namespace javelin
// Params 1
// Checksum 0xf440ab04, Offset: 0x22d9
// Size: 0x90, Type: bool
function javelin_softsighttest( targetent )
{
    if ( javelin_vehiclelocksighttest( targetent ) )
    {
        self.javelin.lostsightlinetime = 0;
        return true;
    }
    
    if ( self.javelin.lostsightlinetime == 0 )
    {
        self.javelin.lostsightlinetime = gettime();
    }
    
    timepassed = gettime() - self.javelin.lostsightlinetime;
    
    if ( timepassed >= 500 )
    {
        return false;
    }
    
    return true;
}

// Namespace javelin
// Params 1
// Checksum 0xcc4645d3, Offset: 0x2372
// Size: 0x56
function javelin_hidenormalhud( enable )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( enable )
    {
        self setclientomnvar( "ui_javelin_view", 1 );
        
        /#
            if ( getdvarint( @"missiledebugtext" ) == 1 )
            {
                self setclientomnvar( "<dev string:xad>", 0 );
            }
        #/
        
        return;
    }
    
    self setclientomnvar( "ui_javelin_view", 0 );
}

// Namespace javelin
// Params 1
// Checksum 0xc6674d3e, Offset: 0x23d0
// Size: 0x94
function javelin_setuistate( state )
{
    self setclientomnvar( "ui_javelin_state", state );
    
    /#
        if ( getdvarint( @"missiledebugtext" ) == 1 )
        {
            if ( state == 0 )
            {
                iprintlnbold( "<dev string:xbd>" );
                return;
            }
            
            if ( state == 1 )
            {
                iprintlnbold( "<dev string:xcc>" );
                return;
            }
            
            if ( state == 2 )
            {
                iprintlnbold( "<dev string:xe0>" );
                return;
            }
            
            if ( state == 3 )
            {
                iprintlnbold( "<dev string:xf0>" );
                return;
            }
            
            if ( state == 4 )
            {
                iprintlnbold( "<dev string:x100>" );
            }
        }
    #/
}

// Namespace javelin
// Params 1
// Checksum 0x66731027, Offset: 0x246c
// Size: 0x78
function marklocation( markpos )
{
    if ( !isdefined( markpos.owner ) )
    {
        markpos.owner = self;
    }
    
    if ( markpos.model == "tag_origin" )
    {
        markpos show();
    }
    
    javelintargetmarkergroup = targetmarkergroups::targetmarkergroup_on( %"javelincrosshair", self, markpos, self );
    self.javelinlocationtargeted = 1;
    thread watchtargetmarkerentstatus( markpos, javelintargetmarkergroup, 1 );
}

// Namespace javelin
// Params 3
// Checksum 0x3331945, Offset: 0x24ec
// Size: 0x7b
function watchtargetmarkerentstatus( var_74edcdf8b319dfa4, targetmarkergroup, istag )
{
    level endon( #"game_ended" );
    
    while ( isdefined( self.javelin.target ) && self.javelin.state != "off" )
    {
        waitframe();
    }
    
    if ( isdefined( targetmarkergroup ) )
    {
        targetmarkergroups::targetmarkergroup_off( targetmarkergroup );
    }
    
    self.javelinlocationtargeted = undefined;
}

/#

    // Namespace javelin
    // Params 1
    // Checksum 0xe2812c4a, Offset: 0x256f
    // Size: 0x29, Type: dev
    function javelin_debugtext( text )
    {
        if ( getdvarint( @"missiledebugtext" ) == 1 )
        {
            iprintln( text );
        }
    }

    // Namespace javelin
    // Params 2
    // Checksum 0xf20bd56, Offset: 0x25a0
    // Size: 0x8a, Type: dev
    function function_c42e09ce8592aa74( point, color )
    {
        line( point + ( 10, 0, 0 ), point - ( 10, 0, 0 ), color );
        line( point + ( 0, 10, 0 ), point - ( 0, 10, 0 ), color );
        line( point + ( 0, 0, 10 ), point - ( 0, 0, 10 ), color );
    }

    // Namespace javelin
    // Params 3
    // Checksum 0xa4ed1f54, Offset: 0x2632
    // Size: 0x8b, Type: dev
    function function_dd9c145af9b4dbd4( start, end, passed )
    {
        if ( getdvar( @"missiledebugdraw" ) != "<dev string:x4f>" )
        {
            return;
        }
        
        if ( passed )
        {
            color = ( 0.3, 1, 0.3 );
        }
        else
        {
            color = ( 1, 0.2, 0.2 );
        }
        
        my_offset = ( 0, 0, 5 );
        line( start + my_offset, end, color );
    }

#/

// Namespace javelin
// Params 0
// Checksum 0xffa358c1, Offset: 0x26c5
// Size: 0xe9
function javelin_forceclear()
{
    javelin_hidenormalhud( 0 );
    javelin_setuistate( 0 );
    
    if ( isdefined( self.javelin ) )
    {
        if ( isdefined( self.javelin.target ) )
        {
            weapon_utility::removelockedon( self.javelin.target, self );
            self weaponlockfree();
            self.javelin.target = undefined;
        }
        
        if ( isdefined( self.javelin.groundlockonent ) )
        {
            self.javelin.groundlockonent ent_manager::deregisterspawn();
            self.javelin.groundlockonent delete();
            self.javelin.groundlockonent = undefined;
        }
    }
    
    self notify( #"stop_lockon_sound" );
    
    if ( soundexists( "javelin_clu_lock" ) )
    {
        self stoplocalsound( "javelin_clu_lock" );
    }
}

// Namespace javelin
// Params 1, eflags: 0x4
// Checksum 0x6cfb72a0, Offset: 0x27b6
// Size: 0x181
function private prototype_split( target )
{
    self endon( #"death_or_disconnect" );
    self waittill( #"missile_fire", missile, weapon );
    wait 1.4;
    var_5b7481443927b56d = function_819467f103f41e74( missile );
    submissiles = [];
    var_7470cc6f77e43d3f = makeweapon( %"hash_17c500d3d25887ed" );
    
    if ( !missile )
    {
        return;
    }
    
    spawnorigin = missile.origin;
    missile notify( #"explode" );
    missile delete();
    spawnorigin += var_5b7481443927b56d * 0.5;
    
    for ( i = 0; i < 3 ; i++ )
    {
        spawnloc = spawnorigin + utility::randomonunitsphere() * 50;
        submissiles[ i ] = namespace_9d8e359c3b1041e5::magicbulletsharedfunc( var_7470cc6f77e43d3f, spawnloc, function_6ce6a8d71fd1202c( spawnloc, vectornormalize( var_5b7481443927b56d ), 45 ) );
    }
    
    foreach ( child in submissiles )
    {
        wait randomfloat( 0.2 );
        child missile_settargetent( target );
    }
    
    wait 10;
    target delete();
}

// Namespace javelin
// Params 1, eflags: 0x4
// Checksum 0x4f85dc49, Offset: 0x293f
// Size: 0x48
function private function_819467f103f41e74( missile )
{
    from = missile.origin;
    wait 0.1;
    to = missile.origin;
    return ( to - from ) / 0.1;
}

// Namespace javelin
// Params 3, eflags: 0x4
// Checksum 0x4e6e668, Offset: 0x2990
// Size: 0x13f
function private function_6ce6a8d71fd1202c( spawnloc, dir, angle )
{
    a = abs( dir[ 2 ] ) < 1 ? ( 0, 0, 1 ) : ( 0, 1, 0 );
    u = vectornormalize( vectorcross( a, dir ) );
    v = vectorcross( dir, u );
    cosalpha = cos( angle );
    z = lerp( cosalpha, 1, randomfloat( 1 ) );
    phi = 360 * randomfloat( 1 );
    r = sqrt( max( 0, 1 - z * z ) );
    x = r * cos( phi );
    y = r * sin( phi );
    newdir = x * u + y * v + z * dir;
    
    /#
        level thread debug_utility::drawline( spawnloc, spawnloc + newdir * 1000, 10, ( 1, 1, 0 ) );
    #/
    
    return spawnloc + newdir * 1000;
}

