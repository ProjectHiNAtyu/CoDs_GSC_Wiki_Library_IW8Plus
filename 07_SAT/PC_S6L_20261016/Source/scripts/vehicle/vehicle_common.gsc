// scripts\vehicle\vehicle_common.gsc  (hash_1e0a39fecfb8cd77.gscc) (size: 9599 Bytes / 0x257f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x15bf6d26 (364866854)
// size ...... 9599 (0x257f)
// includes .. 6   (offset: 0x240f)
// strings ... 5   (offset: 0x243f)
// dev strs .. 21  (offset: 0x247f)
// exports ... 21  (offset: 0x1a0f)
// cseg ...... 0xa8 + 0x1967 (0x1a0f)
// imports ... 54  (offset: 0x1d57)
// animtree1 . 0   (offset: 0x257f)
// animtree2 . 0   (offset: 0x257f)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_aianim;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_collision;

#namespace vehicle_common;

// Namespace vehicle_common
// Params 4
// Checksum 0xa69f1ab9, Offset: 0xc6
// Size: 0x29d
function requestentervehicle( vehicle, spawninvehicle, chosenvehicleposition, chosenvehicleanimpos )
{
    self._blackboard.var_cc2bc3c7a5a9a60c = vehicle;
    self._blackboard.var_75ac653affbae238 = spawninvehicle;
    self._blackboard.chosenvehiclelocation = chosenvehicleposition.origin;
    self._blackboard.chosenvehicleangles = chosenvehicleposition.angles;
    self._blackboard.var_25799974c1f2939b = chosenvehicleposition.vehicle_position;
    self._blackboard.var_fef1650fd4ff6f6 = istrue( chosenvehicleposition.canshootinvehicle );
    self._blackboard.currentvehicleanimalias = vehicle.vehicleanimalias;
    self._blackboard.chosenvehicleanimpos_sittag = chosenvehicleanimpos.sittag;
    
    if ( chosenvehicleanimpos.seataliasoverride )
    {
        self._blackboard.chosenvehicleanimpos_seatalias = chosenvehicleanimpos.seataliasoverride;
    }
    else
    {
        self._blackboard.chosenvehicleanimpos_seatalias = string( self._blackboard.var_25799974c1f2939b );
    }
    
    self._blackboard.chosenvehicleanimpos_linktoblend = istrue( chosenvehicleanimpos.linktoblend );
    
    if ( isdefined( chosenvehicleanimpos.fastroperig ) )
    {
        self._blackboard.chosenvehicleanimpos_fastroperig = chosenvehicleanimpos.fastroperig;
    }
    
    self._blackboard.canchangeseats = istrue( chosenvehicleanimpos.var_9398f3113dced1d0 );
    
    if ( isdefined( chosenvehicleanimpos.vehicle_getoutanim ) )
    {
        self._blackboard.chosenvehicleanimpos_getoutanim = getanimname( chosenvehicleanimpos.vehicle_getoutanim );
    }
    else
    {
        self._blackboard.chosenvehicleanimpos_getoutanim = undefined;
    }
    
    self._blackboard.chosenvehicleanimpos_deathragdoll = istrue( chosenvehicleanimpos.deathragdoll );
    self._blackboard.chosenvehicleanimpos_deathimpulse = istrue( chosenvehicleanimpos.deathimpulse );
    self._blackboard.vehiclerequested = 1;
    seatinfo = vehicle_aianim::anim_pos( vehicle, chosenvehicleposition.vehicle_position );
    function_3cf475131c534031( seatinfo );
}

// Namespace vehicle_common
// Params 1
// Checksum 0x85bb2903, Offset: 0x36b
// Size: 0x48
function function_f6cae8cbbd08eb08( seatinfo )
{
    if ( seatinfo.do_not_unload )
    {
        self._blackboard.var_f6cae8cbbd08eb08 = 0;
        return;
    }
    
    self._blackboard.var_f6cae8cbbd08eb08 = 1;
}

// Namespace vehicle_common
// Params 1
// Checksum 0x81ffa6c, Offset: 0x3bb
// Size: 0x32
function function_3cf475131c534031( seatinfo )
{
    if ( seatinfo.var_14f441f730dc229d )
    {
        self.var_d2ea0f73eb94d74c = 1;
        return;
    }
    
    self.var_d2ea0f73eb94d74c = 0;
}

// Namespace vehicle_common
// Params 0
// Checksum 0x693b026a, Offset: 0x3f5
// Size: 0x2d6
function function_134a8f5d5a23d3cb()
{
    if ( isdefined( self._blackboard.currentvehicle ) )
    {
        self._blackboard.currentvehicle.usedpositions[ self._blackboard.var_25799974c1f2939b ] = 0;
        self._blackboard.var_25799974c1f2939b = self._blackboard.var_84de977d30197688;
        self._blackboard.currentvehicle.usedpositions[ self._blackboard.var_84de977d30197688 ] = 1;
        self._blackboard.var_3b97675e43c4276d = 0;
        self._blackboard.currentvehicle.var_2c1b14ee4b7cd97c[ self._blackboard.var_84de977d30197688 ] = 0;
        self.exitposition = self._blackboard.var_84de977d30197688;
        vehicleanimpos = vehicle_aianim::anim_pos( self._blackboard.currentvehicle, self._blackboard.var_25799974c1f2939b );
        self._blackboard.chosenvehicleanimpos_sittag = vehicleanimpos.sittag;
        
        if ( vehicleanimpos.seataliasoverride )
        {
            self._blackboard.chosenvehicleanimpos_seatalias = vehicleanimpos.seataliasoverride;
        }
        else
        {
            self._blackboard.chosenvehicleanimpos_seatalias = string( self._blackboard.var_25799974c1f2939b );
        }
        
        self._blackboard.chosenvehicleanimpos_linktoblend = istrue( vehicleanimpos.linktoblend );
        self._blackboard.chosenvehicleanimpos_fastroperig = vehicleanimpos.fastroperig;
        self._blackboard.var_fef1650fd4ff6f6 = istrue( vehicleanimpos.canshootinvehicle );
        self._blackboard.canchangeseats = istrue( vehicleanimpos.var_9398f3113dced1d0 );
        
        if ( isdefined( vehicleanimpos.vehicle_getoutanim ) )
        {
            self._blackboard.chosenvehicleanimpos_getoutanim = getanimname( vehicleanimpos.vehicle_getoutanim );
        }
        else
        {
            self._blackboard.chosenvehicleanimpos_getoutanim = undefined;
        }
        
        self._blackboard.chosenvehicleanimpos_deathragdoll = istrue( vehicleanimpos.deathragdoll );
        self._blackboard.chosenvehicleanimpos_deathimpulse = istrue( vehicleanimpos.deathimpulse );
        function_3cf475131c534031( vehicleanimpos );
        function_f6cae8cbbd08eb08( vehicleanimpos );
    }
}

// Namespace vehicle_common
// Params 2, eflags: 0x4
// Checksum 0xa3e0de22, Offset: 0x6d3
// Size: 0x7d
function private get_velocity( vehicle, lastcollision )
{
    if ( !isent( vehicle ) || !vehicle vehicle::is_vehicle() || vehicle vehicle::is_static() )
    {
        return ( 0, 0, 0 );
    }
    
    if ( isdefined( vehicle.velocity ) )
    {
        return vehicle.velocity;
    }
    
    if ( lastcollision )
    {
        return vehicle function_19e2beab469c788e();
    }
    
    return vehicle vehicle_getvelocity();
}

// Namespace vehicle_common
// Params 0
// Checksum 0xacb0b924, Offset: 0x758
// Size: 0x23e
function vehiclecollisionwatcher()
{
    self endon( #"hash_1283eaff134ba222" );
    self endon( #"death" );
    self endon( #"long_death" );
    
    while ( true )
    {
        if ( !isdefined( self._blackboard.currentvehicle ) )
        {
            return;
        }
        
        self._blackboard.currentvehicle waittill( #"collision", body0, body1, flag0, flag1, position, normal, impulse, ent );
        var_4528dc04bda9ec95 = get_velocity( self, 1 );
        var_4cdc7c696999f528 = get_velocity( ent, 1 );
        waitframe();
        var_366bdf70365083e6 = get_velocity( self );
        var_244de96e6b3df4ed = get_velocity( ent );
        impulse = length( var_366bdf70365083e6 - var_4528dc04bda9ec95 ) + length( var_4cdc7c696999f528 - var_244de96e6b3df4ed );
        
        if ( self asmeventfired( self.asmname, "allow_reimpulse" ) )
        {
            self.canreimpulse = 1;
        }
        else
        {
            self.canreimpulse = 0;
        }
        
        self.collision_data = spawnstruct();
        self.collision_data.position = position;
        self.collision_data.normal = normal;
        self.collision_data.impulse = impulse;
        
        /#
            setdvarifuninitialized( @"hash_e4eece17e1ee5b59", 0 );
            displayinfo = getdvarint( @"hash_e4eece17e1ee5b59" );
            
            if ( displayinfo )
            {
                forward = anglestoforward( self.angles );
                line( position, position + normal * impulse * 1000, ( 0, 1, 0 ), 1, 0, 100 );
                line( position, position + forward * 100, ( 1, 0, 0 ), 1, 0, 100 );
                sphere( position, 20, ( 0, 1, 0 ), 0, 100 );
            }
        #/
        
        waitframe();
    }
}

// Namespace vehicle_common
// Params 0
// Checksum 0x45343ed1, Offset: 0x99e
// Size: 0x19f, Type: bool
function waitforentervehicle()
{
    msg = utility::waittill_any_return( "entervehicle", "death", "long_death", "failedentervehicle" );
    
    if ( msg != "entervehicle" )
    {
        return false;
    }
    
    self allowvehiclepredictiveragdoll( 0 );
    self._blackboard.vehiclerequested = 0;
    self._blackboard.currentvehicle.usedpositions[ self._blackboard.var_25799974c1f2939b ] = 1;
    self._blackboard.var_924a3ba4287e2e2 = 1;
    vehicledata = vehicle::get_data( self._blackboard.currentvehicle vehicle::get_ref() );
    
    if ( vehicledata.ai.sightconfigtemplate )
    {
        self.var_3a27d82916f53b40 = self getsightconfigtemplateoverride();
        self setsightconfigtemplateoverride( vehicledata.ai.sightconfigtemplate );
    }
    
    self._blackboard.currentvehicle thread function_4637bce4207a6a03( self );
    thread vehiclecollisionwatcher();
    
    /#
        thread function_fab5752ad344ba76();
    #/
    
    vehicleanimpos = vehicle_aianim::anim_pos( self._blackboard.currentvehicle, self._blackboard.var_25799974c1f2939b );
    function_f6cae8cbbd08eb08( vehicleanimpos );
    callback::callback( #"ai_vehicle_load", { #vehicle:self._blackboard.currentvehicle } );
    return true;
}

// Namespace vehicle_common
// Params 0
// Checksum 0x9658aa, Offset: 0xb46
// Size: 0xb6
function waitforarrivedatvehicle()
{
    self endon( #"death" );
    self endon( #"long_death" );
    
    if ( self.bhasriotshieldattached )
    {
        self._blackboard.var_86e1adabb762ade4 = 1;
    }
    
    while ( self._blackboard.vehiclerequested || isdefined( self._blackboard.currentvehicle ) && !self._blackboard.startedenteringvehicle && !self._blackboard.enteredvehicle && !self._blackboard.invehicle )
    {
        waitframe();
    }
}

// Namespace vehicle_common
// Params 4
// Checksum 0xdd9dcdae, Offset: 0xc04
// Size: 0x3a, Type: bool
function entervehicle( vehicle, spawninvehicle, chosenvehicleposition, chosenvehicleanimpos )
{
    requestentervehicle( vehicle, spawninvehicle, chosenvehicleposition, chosenvehicleanimpos );
    return waitforentervehicle();
}

// Namespace vehicle_common
// Params 0
// Checksum 0x850e97f5, Offset: 0xc47
// Size: 0x2d
function requestexitvehicle()
{
    self._blackboard.exitvehiclerequested = 1;
    self._blackboard.vehiclerequested = 0;
}

// Namespace vehicle_common
// Params 0
// Checksum 0x6673192e, Offset: 0xc7c
// Size: 0x1d6
function waitforexitvehicle()
{
    self endon( #"death" );
    self endon( #"long_death" );
    vehicle = self._blackboard.currentvehicle;
    vehicledata = vehicle::get_data( vehicle vehicle::get_ref() );
    
    while ( !self._blackboard.hasexitedvehicle )
    {
        waitframe();
    }
    
    self notify( #"unloaded" );
    self notify( #"hash_1283eaff134ba222" );
    self allowvehiclepredictiveragdoll( 1 );
    self._blackboard.hasexitedvehicle = 0;
    
    if ( vehicledata.ai.sightconfigtemplate )
    {
        if ( self.var_3a27d82916f53b40 )
        {
            self setsightconfigtemplateoverride( self.var_3a27d82916f53b40 );
            self.var_3a27d82916f53b40 = undefined;
        }
        else if ( level.stealth.sightconfigtemplate )
        {
            self setsightconfigtemplateoverride( level.stealth.sightconfigtemplate );
        }
        else
        {
            self setsightconfigtemplateoverride( undefined );
        }
    }
    
    if ( vehicle && vehicle vehicle::is_vehicle() )
    {
        vehicle.usedpositions[ self._blackboard.var_25799974c1f2939b ] = 0;
        thread vehicle_collision::function_e3bc60c772acd609( vehicle, self );
    }
    
    if ( !ispointonnavmesh( self.origin, self, 1, undefined, undefined, 1 ) )
    {
        navpos = getclosestpointonnavmesh( self.origin, self );
        groundpos = getgroundposition( navpos, 16 );
        self forceteleport( groundpos, self.angles );
    }
    
    callback::callback( #"ai_vehicle_unload", { #vehicle:self._blackboard.currentvehicle } );
}

// Namespace vehicle_common
// Params 0
// Checksum 0x6bddce65, Offset: 0xe5a
// Size: 0x10
function exitvehicle()
{
    requestexitvehicle();
    waitforexitvehicle();
}

// Namespace vehicle_common
// Params 0
// Checksum 0xa0db4b73, Offset: 0xe72
// Size: 0x3a, Type: bool
function hasvehicle()
{
    return self._blackboard.vehiclerequested || isdefined( self._blackboard ) && isdefined( self._blackboard.currentvehicle );
}

// Namespace vehicle_common
// Params 0
// Checksum 0xb1418ab3, Offset: 0xeb5
// Size: 0x18
function setuprope()
{
    self._blackboard.vehiclesetuprope = 1;
}

// Namespace vehicle_common
// Params 0
// Checksum 0x990825b3, Offset: 0xed5
// Size: 0x23
function cancelentervehicle()
{
    self notify( #"stop_loading" );
    self._blackboard.isrunningtovehicle = 0;
}

// Namespace vehicle_common
// Params 1
// Checksum 0x409f2bfd, Offset: 0xf00
// Size: 0x8d
function getmaxriders( vehicledata )
{
    if ( !isdefined( vehicledata.ai ) || !vehicledata.ai.supportsai )
    {
        return 0;
    }
    
    var_e8e10d49bc04a5b8 = 0;
    
    for ( i = 0; i < vehicledata.aiseats.size ; i++ )
    {
        if ( vehicledata.aiseats[ i ].var_60b6d3b20648a38f ?? 1 )
        {
            var_e8e10d49bc04a5b8++;
        }
    }
    
    return var_e8e10d49bc04a5b8;
}

// Namespace vehicle_common
// Params 2
// Checksum 0x3228eb6c, Offset: 0xf96
// Size: 0x13c, Type: bool
function function_953694d5d41fce58( var_77759608d2ca8592, var_2674264c094cd023 )
{
    vehicle = self._blackboard.currentvehicle;
    
    if ( !isdefined( vehicle ) )
    {
        return false;
    }
    
    if ( self._blackboard.var_25799974c1f2939b == var_77759608d2ca8592 )
    {
        return true;
    }
    
    if ( var_77759608d2ca8592 >= vehicle.usedpositions.size )
    {
        return false;
    }
    
    if ( vehicle.usedpositions[ var_77759608d2ca8592 ] || vehicle.var_2c1b14ee4b7cd97c[ var_77759608d2ca8592 ] )
    {
        return false;
    }
    
    if ( !isdefined( var_2674264c094cd023 ) )
    {
        var_2674264c094cd023 = -1;
    }
    
    seatinfo = vehicle_aianim::anim_pos( vehicle, var_77759608d2ca8592 );
    self._blackboard.var_84de977d30197688 = var_77759608d2ca8592;
    self._blackboard.var_d26a80bcdfbf2fc1 = var_2674264c094cd023;
    
    if ( seatinfo.seataliasoverride )
    {
        self._blackboard.var_357610f2b1b38df6 = seatinfo.seataliasoverride;
    }
    else
    {
        self._blackboard.var_357610f2b1b38df6 = string( var_77759608d2ca8592 );
    }
    
    self._blackboard.var_3b97675e43c4276d = 1;
    return true;
}

// Namespace vehicle_common
// Params 1, eflags: 0x4
// Checksum 0xa3ea6877, Offset: 0x10db
// Size: 0x85
function private function_4637bce4207a6a03( rider )
{
    self endon( #"death" );
    rider endon( #"unloaded" );
    exitposition = rider._blackboard.var_25799974c1f2939b;
    
    while ( isdefined( self ) && isalive( rider ) )
    {
        exitposition = rider._blackboard.var_25799974c1f2939b;
        waitframe();
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.usedpositions[ exitposition ] = 0;
}

/#

    // Namespace vehicle_common
    // Params 1
    // Checksum 0x87d7fa3c, Offset: 0x1168
    // Size: 0x52, Type: dev
    function function_1b2539f38f15adae( value )
    {
        if ( getdvarint( @"ai_debugentindex" ) == -1 || getdvarint( @"ai_debugentindex" ) == self getentitynumber() )
        {
            if ( getdvarint( @"ai_debugvehicleinfo", 0 ) == value )
            {
                return 1;
            }
        }
        
        return 0;
    }

    // Namespace vehicle_common
    // Params 0
    // Checksum 0x4b9b20f9, Offset: 0x11c2
    // Size: 0x84d, Type: dev
    function function_fab5752ad344ba76()
    {
        self endon( #"death" );
        debugtextsize = 0.3;
        
        while ( isdefined( self._blackboard.currentvehicle ) )
        {
            vehicle = self._blackboard.currentvehicle;
            
            if ( function_1b2539f38f15adae( 1 ) )
            {
                debugvehicleinfo = "<dev string:x24>" + string( vehicle vehicle_code::get_vehicle_classname() );
                var_336d1d20474a22fd = "<dev string:x2e>";
                
                if ( isdefined( self._blackboard.var_25799974c1f2939b ) )
                {
                    var_336d1d20474a22fd += string( self._blackboard.var_25799974c1f2939b );
                }
                
                var_336d1d20474a22fd += "<dev string:x37>";
                
                if ( isdefined( self._blackboard.chosenvehicleanimpos_seatalias ) )
                {
                    var_336d1d20474a22fd += self._blackboard.chosenvehicleanimpos_seatalias;
                }
                
                var_8678d89bf4d49fd3 = "<dev string:x40>";
                
                if ( isdefined( self._blackboard.currentvehicleanimalias ) )
                {
                    var_8678d89bf4d49fd3 += string( self._blackboard.currentvehicleanimalias );
                }
                
                debugtaginfo = "<dev string:x46>";
                
                if ( isdefined( self._blackboard.chosenvehicleanimpos_sittag ) )
                {
                    debugtaginfo += string( self._blackboard.chosenvehicleanimpos_sittag );
                }
                
                print3d( self.origin + ( 0, 0, 69 ), debugvehicleinfo, ( 1, 1, 1 ), 1, debugtextsize );
                print3d( self.origin + ( 0, 0, 66 ), var_336d1d20474a22fd, ( 1, 1, 1 ), 1, debugtextsize );
                print3d( self.origin + ( 0, 0, 63 ), var_8678d89bf4d49fd3, ( 1, 1, 1 ), 1, debugtextsize );
                print3d( self.origin + ( 0, 0, 60 ), debugtaginfo, ( 1, 1, 1 ), 1, debugtextsize );
                selffwd = anglestoforward( self.angles );
                utility::draw_arrow( self.origin, self.origin + selffwd * 20, ( 1, 1, 1 ) );
                seattagorigin = vehicle gettagorigin( self._blackboard.chosenvehicleanimpos_sittag );
                seattagangles = vehicle gettagangles( self._blackboard.chosenvehicleanimpos_sittag );
                seattagfwd = anglestoforward( seattagangles );
                var_c5134ff1389727cf = ( 0, 0, 1 );
                utility::draw_arrow( seattagorigin + var_c5134ff1389727cf, seattagorigin + seattagfwd * 15 + var_c5134ff1389727cf, ( 0.6, 0, 0.6 ) );
                vehiclebundleinfo = vehicle_aianim::anim_pos( vehicle, self._blackboard.var_25799974c1f2939b );
                linkangle = ( 0, 0, 0 );
                linkoffset = ( 0, 0, 0 );
                
                if ( isdefined( vehiclebundleinfo.linkangle ) )
                {
                    linkangle = vehiclebundleinfo.linkangle;
                }
                
                if ( isdefined( vehiclebundleinfo.linkoffset ) )
                {
                    linkoffset = rotatevector( vehiclebundleinfo.linkoffset, vehicle.angles );
                }
                
                if ( linkangle != ( 0, 0, 0 ) || linkoffset != ( 0, 0, 0 ) )
                {
                    fwdlinkoffset = rotatevector( seattagfwd, linkangle );
                    utility::draw_arrow( seattagorigin + linkoffset + var_c5134ff1389727cf, seattagorigin + linkoffset + var_c5134ff1389727cf + fwdlinkoffset * 15, ( 1, 0.2, 0.2 ) );
                }
            }
            else if ( function_1b2539f38f15adae( 2 ) )
            {
                vehiclebundleinfo = vehicle_aianim::anim_pos( vehicle, self._blackboard.var_25799974c1f2939b );
                var_8cbe2e91dc58fc58 = "<dev string:x51>";
                
                if ( vehiclebundleinfo.canshootinvehicle )
                {
                    var_8cbe2e91dc58fc58 = "<dev string:x6a>";
                }
                
                var_70611c8c7070b1eb = "<dev string:x82>";
                
                if ( vehiclebundleinfo.canmeleeinvehicle )
                {
                    var_70611c8c7070b1eb = "<dev string:x9b>";
                }
                
                var_5c10d68fc649c4fe = "<dev string:xb3>";
                
                if ( vehiclebundleinfo.deathragdoll )
                {
                    var_5c10d68fc649c4fe = "<dev string:xc7>";
                }
                
                var_a84e8f37a18faaff = "<dev string:xda>";
                
                if ( vehiclebundleinfo.bhasgunwhileriding )
                {
                    var_a84e8f37a18faaff = "<dev string:xf3>";
                }
                
                var_6b2e9979e128dd5d = "<dev string:x10b>";
                
                if ( vehiclebundleinfo.var_9398f3113dced1d0 )
                {
                    var_6b2e9979e128dd5d = "<dev string:x121>";
                }
                
                print3d( self.origin + ( 0, 0, 69 ), var_8cbe2e91dc58fc58, ( 1, 1, 1 ), 1, debugtextsize );
                print3d( self.origin + ( 0, 0, 66 ), var_70611c8c7070b1eb, ( 1, 1, 1 ), 1, debugtextsize );
                print3d( self.origin + ( 0, 0, 63 ), var_5c10d68fc649c4fe, ( 1, 1, 1 ), 1, debugtextsize );
                print3d( self.origin + ( 0, 0, 60 ), var_a84e8f37a18faaff, ( 1, 1, 1 ), 1, debugtextsize );
                print3d( self.origin + ( 0, 0, 57 ), var_6b2e9979e128dd5d, ( 1, 1, 1 ), 1, debugtextsize );
            }
            else if ( function_1b2539f38f15adae( 3 ) )
            {
                var_262ca37d18da7525 = isdefined( self.var_61ac0cadde089972 ) && isdefined( self.var_9f2be75059f33907 ) && gettime() >= self.var_9f2be75059f33907 && gettime() < self.var_61ac0cadde089972;
                debugtransitioninfo = "<dev string:x136>";
                
                if ( var_262ca37d18da7525 )
                {
                    debugtransitioninfo += "<dev string:x137>";
                }
                
                print3d( self.origin + ( 0, 0, 69 ), debugtransitioninfo, ( 1, 1, 1 ), 1, debugtextsize );
            }
            else if ( function_1b2539f38f15adae( 4 ) )
            {
                vehiclebundleinfo = vehicle_aianim::anim_pos( vehicle, self._blackboard.var_25799974c1f2939b );
                
                if ( self._blackboard.var_3b97675e43c4276d )
                {
                    var_58d71081bcb4e134 = "<dev string:x136>";
                    
                    if ( self._blackboard.var_d8b9e2ebdf7d6e95 )
                    {
                        var_58d71081bcb4e134 = "<dev string:x149>";
                    }
                    else
                    {
                        var_58d71081bcb4e134 = "<dev string:x15c>";
                    }
                    
                    toseatinfo = "<dev string:x176>" + string( self._blackboard.var_84de977d30197688 );
                    
                    if ( self._blackboard.var_d26a80bcdfbf2fc1 != -1 )
                    {
                        toseatinfo += "<dev string:x17d>" + string( self._blackboard.var_d26a80bcdfbf2fc1 );
                    }
                    
                    var_58d71081bcb4e134 += toseatinfo;
                    print3d( self.origin + ( 0, 0, 69 ), var_58d71081bcb4e134, ( 1, 1, 1 ), 1, debugtextsize );
                    toseatinfo = vehicle_aianim::anim_pos( vehicle, self._blackboard.var_84de977d30197688 );
                    var_799fa0288efb418c = vehicle gettagorigin( toseatinfo.sittag );
                    
                    if ( isdefined( toseatinfo.linkoffset ) )
                    {
                        var_799fa0288efb418c += rotatevector( toseatinfo.linkoffset, vehicle.angles );
                    }
                    
                    sphere( self.origin, 2, ( 0, 0.2, 1 ), 0, 1 );
                    sphere( var_799fa0288efb418c, 2, ( 0, 0.2, 1 ), 0, 1 );
                    utility::draw_arrow( self.origin, var_799fa0288efb418c, ( 0, 0.2, 1 ) );
                }
            }
            
            waitframe();
        }
    }

#/
