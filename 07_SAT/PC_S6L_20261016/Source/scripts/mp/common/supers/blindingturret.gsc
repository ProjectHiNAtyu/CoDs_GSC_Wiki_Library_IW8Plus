// scripts\mp\common\supers\blindingturret.gsc  (hash_5029338d69990fa2.gscc) (size: 6660 Bytes / 0x1a04 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x40061f29 (1074143017)
// size ...... 6660 (0x1a04)
// includes .. 10  (offset: 0x190c)
// strings ... 11  (offset: 0x195c)
// dev strs .. 0   (offset: 0x1a04)
// exports ... 19  (offset: 0xe64)
// cseg ...... 0x10e + 0xd56 (0xe64)
// imports ... 65  (offset: 0x115c)
// animtree1 . 0   (offset: 0x1a04)
// animtree2 . 0   (offset: 0x1a04)
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\damage;
#using scripts\mp\hostmigration;
#using scripts\mp\sentientpoolmanager;

#namespace blindingturret;

// Namespace blindingturret
// Params 0
// Checksum 0x845212bc, Offset: 0x12c
// Size: 0xe
function blindingturret_unset()
{
    self notify( #"hash_633869cfc9b1d60c" );
}

// Namespace blindingturret
// Params 1
// Checksum 0x60f7bbc0, Offset: 0x142
// Size: 0x13
function blindingturret_handlefataldamage( data )
{
    blindingturret_delete();
}

// Namespace blindingturret
// Params 1
// Checksum 0xef87afcc, Offset: 0x15d
// Size: 0x83
function blindingturret_used( grenade )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    grenade waittill( #"missile_stuck" );
    turret = function_7c743b8c0ac6f2e9( grenade );
    
    if ( !isdefined( turret ) )
    {
        return;
    }
    
    maxhealth = 100;
    turret thread damage::monitordamage( maxhealth, "hitequip", &blindingturret_handlefataldamage, undefined, 0, 0 );
    turret thread function_1b9fcfbf59318d98();
    turret thread function_99d49d47d47873a9();
}

// Namespace blindingturret
// Params 0
// Checksum 0x913580b6, Offset: 0x1e8
// Size: 0x110
function function_99d49d47d47873a9()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( true )
    {
        if ( !self.stunned && !self.isactive )
        {
            blindingturret_setactive();
        }
        
        if ( !self.stunned && !self.isidling )
        {
            thread function_aaf05a88e95f292a();
        }
        
        if ( !self.stunned && !isdefined( self.flashtarget ) && !self.oncooldown )
        {
            function_4c404223a0559edc();
        }
        
        if ( !self.stunned && isdefined( self.flashtarget ) )
        {
            function_a2e422f9ae28f867();
        }
        
        if ( !self.stunned && self.flashtargetacquired && isdefined( self.flashtarget ) )
        {
            function_32d646306ca0d6fc();
        }
        
        if ( self.stunned )
        {
            function_5f800cc9a0f44119();
        }
        
        if ( isdefined( self.flashtarget ) )
        {
            function_d28554df9445175c();
        }
        
        waitframe();
    }
}

// Namespace blindingturret
// Params 0
// Checksum 0xdfaf977d, Offset: 0x300
// Size: 0x52
function function_32d646306ca0d6fc()
{
    cansee = blindingturret_canseetarget( self.flashtarget );
    
    if ( cansee )
    {
        self.flashtarget shellshock_utility_cpmp::_shellshock( %"flash_grenade_mp", #"flash", 4, 1 );
    }
    
    thread function_915d76797f979c2b();
}

// Namespace blindingturret
// Params 1, eflags: 0x4
// Checksum 0x9042ea60, Offset: 0x35a
// Size: 0x30
function private function_915d76797f979c2b( time = 1 )
{
    self.oncooldown = 1;
    wait time;
    self.oncooldown = undefined;
}

// Namespace blindingturret
// Params 1
// Checksum 0xd1c4a221, Offset: 0x392
// Size: 0x17f
function blindingturret_canseetarget( target )
{
    if ( !isdefined( target ) )
    {
        return 0;
    }
    
    icansee = 0;
    tracecontents = trace::create_contents( 0, 1, 0, 1, 1, 1, 0, 1 );
    defaultorigin = self.origin;
    headpos = target utility::function_f02ebab438642e16();
    centerpos = target utility::function_68061c3d21a6d57a();
    tracepoints = [ headpos, centerpos, defaultorigin ];
    ignorelist = [ self, target ];
    vehicle = target vehicle::get_vehicle();
    
    if ( isdefined( vehicle ) )
    {
        ignorelist[ ignorelist.size ] = vehicle;
        vehiclechildren = vehicle getlinkedchildren( 1 );
        
        foreach ( child in vehiclechildren )
        {
            ignorelist[ ignorelist.size ] = vehicle;
        }
    }
    
    for ( i = 0; i < tracepoints.size ; i++ )
    {
        if ( !trace::ray_trace_passed( defaultorigin, tracepoints[ i ], ignorelist, tracecontents ) )
        {
            continue;
        }
        
        icansee = 1;
        break;
    }
    
    return icansee;
}

// Namespace blindingturret
// Params 0
// Checksum 0x1874c71e, Offset: 0x51a
// Size: 0x2
function function_5f800cc9a0f44119()
{
    
}

// Namespace blindingturret
// Params 0
// Checksum 0xbcb38179, Offset: 0x524
// Size: 0x5a
function function_d28554df9445175c()
{
    if ( !isdefined( self.var_2cd5ab21f002fa0 ) )
    {
        self.var_2cd5ab21f002fa0 = [];
    }
    
    self.var_2cd5ab21f002fa0[ self.var_2cd5ab21f002fa0.size ] = self.flashtarget;
    self.flashtarget = undefined;
    self cleartargetentity();
    self.isidling = 0;
    self.flashtargetacquired = 0;
}

// Namespace blindingturret
// Params 0
// Checksum 0x77a518f0, Offset: 0x586
// Size: 0x15e
function function_a2e422f9ae28f867()
{
    if ( !isdefined( self.flashtarget ) )
    {
        return;
    }
    
    self endon( #"death" );
    self endon( #"stunned" );
    self.flashtarget endon( #"death_or_disconnect" );
    self notify( #"hash_7de6b1947d64585" );
    self.flashtargetacquired = 0;
    self cleartargetentity();
    waitframe();
    self setconvergencetime( 0.75, "pitch" );
    self setconvergencetime( 0.75, "yaw" );
    self.aimtarget linkto( self.flashtarget, "tag_shield_back", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    self settargetentity( self.aimtarget );
    waitframe();
    vectorbetween = utility::flatten_vector( self.aimtarget.origin - self.origin );
    turretfwd = utility::flatten_vector( anglestoforward( self gettagangles( "tag_flash" ) ) );
    angbetween = math::anglebetweenvectors( turretfwd, vectorbetween );
    
    while ( angbetween > 8 )
    {
        angbetween = math::anglebetweenvectors( turretfwd, vectorbetween );
        turretfwd = utility::flatten_vector( anglestoforward( self gettagangles( "tag_flash" ) ) );
        waitframe();
    }
    
    self.flashtargetacquired = 1;
}

// Namespace blindingturret
// Params 2
// Checksum 0xb77d4051, Offset: 0x6ec
// Size: 0xd9, Type: bool
function function_e0b4bac463f76129( player, betweenvec )
{
    if ( !isdefined( player ) )
    {
        return false;
    }
    
    if ( player.team == self.owner.team )
    {
        return false;
    }
    
    if ( !player::isreallyalive( player ) )
    {
        return false;
    }
    
    if ( !player_utility::playersareenemies( player, self.owner ) )
    {
        return false;
    }
    
    if ( distancesquared( player.origin, self.origin ) > 562500 )
    {
        return false;
    }
    
    if ( isdefined( self.var_2cd5ab21f002fa0 ) && arraycontains( self.var_2cd5ab21f002fa0, player ) )
    {
        return false;
    }
    
    anglebet = math::anglebetweenvectors( anglestoforward( self.angles ), betweenvec );
    
    if ( anglebet >= 90 )
    {
        return false;
    }
    
    return true;
}

// Namespace blindingturret
// Params 0
// Checksum 0xe12057df, Offset: 0x7ce
// Size: 0x1d8
function function_aaf05a88e95f292a()
{
    self endon( #"death" );
    self endon( #"hash_93d4bb62ff370095" );
    self.isidling = 1;
    self.aimtarget unlink();
    direction = 1;
    startangles = self.angles;
    upmult = getdvarfloat( @"hash_8bf7c4a92a43762", 15 );
    fwdmult = getdvarfloat( @"hash_476655d41cf371fa", 30 );
    sidemult = getdvarfloat( @"hash_59d07e54a840556c", 100 );
    startloc = self gettagorigin( "tag_aim_pivot" ) + anglestoforward( startangles ) * fwdmult + anglestoup( startangles ) * upmult;
    self.aimtarget.origin = startloc;
    self setconvergencetime( 2.5, "pitch" );
    self setconvergencetime( 2.5, "yaw" );
    
    while ( true )
    {
        self cleartargetentity();
        waitframe();
        self settargetentity( self.aimtarget );
        direction *= -1;
        self.aimtarget.origin = startloc + anglestoright( startangles ) * sidemult * direction;
        vecbetween = utility::flatten_vector( self.aimtarget.origin - self.origin );
        turretangles = self gettagangles( "tag_flash" );
        anglebetween = math::anglebetweenvectors( anglestoforward( turretangles ), vecbetween );
        
        while ( anglebetween > 8 )
        {
            turretangles = self gettagangles( "tag_flash" );
            anglebetween = math::anglebetweenvectors( utility::flatten_vector( anglestoforward( turretangles ) ), vecbetween );
            waitframe();
        }
    }
}

// Namespace blindingturret
// Params 0
// Checksum 0xf447266c, Offset: 0x9ae
// Size: 0x20e
function function_4c404223a0559edc()
{
    possibletargets = [];
    var_56fce8b9847d2b39 = [];
    
    foreach ( player in level.characters )
    {
        betweenvec = player.origin - self.origin;
        
        if ( !function_e0b4bac463f76129( player, betweenvec ) )
        {
            continue;
        }
        
        distratio = 1 - distancesquared( player.origin, self.origin ) / 562500;
        distratio = clamp( distratio, 0, 1 );
        angratio = 1 - math::anglebetweenvectors( anglestoforward( self.angles ), betweenvec ) / 90;
        angratio = clamp( angratio, 0, 1 );
        weight = distratio * 0.75 + angratio * 0.25;
        possibletargets[ possibletargets.size ] = player;
        var_56fce8b9847d2b39[ var_56fce8b9847d2b39.size ] = weight;
    }
    
    if ( possibletargets.size == 0 )
    {
        return;
    }
    
    for ( i = 0; i < var_56fce8b9847d2b39.size - 1 ; i++ )
    {
        swapped = 0;
        
        for ( j = 0; j < var_56fce8b9847d2b39.size - 1 ; j++ )
        {
            if ( var_56fce8b9847d2b39[ j ] < var_56fce8b9847d2b39[ j + 1 ] )
            {
                tempplayer = possibletargets[ j ];
                tempweight = var_56fce8b9847d2b39[ j ];
                possibletargets[ j ] = possibletargets[ j + 1 ];
                var_56fce8b9847d2b39[ j ] = var_56fce8b9847d2b39[ j + 1 ];
                possibletargets[ j + 1 ] = tempplayer;
                var_56fce8b9847d2b39[ j + 1 ] = tempweight;
                swapped = 1;
            }
        }
        
        if ( !swapped )
        {
            break;
        }
    }
    
    self.flashtarget = possibletargets[ 0 ];
}

// Namespace blindingturret
// Params 0
// Checksum 0x4c2364d4, Offset: 0xbc4
// Size: 0x41
function blindingturret_setactive()
{
    self.isactive = 1;
    self setdefaultdroppitch( -89 );
    self setmode( "manual_target" );
    
    if ( !issentient( self ) )
    {
        sentientpoolmanager::registersentient( "Killstreak_Ground", self.owner );
    }
}

// Namespace blindingturret
// Params 0
// Checksum 0xa5954adb, Offset: 0xc0d
// Size: 0x14
function blindingturret_delete()
{
    self notify( #"death" );
    self delete();
}

// Namespace blindingturret
// Params 0
// Checksum 0x89bab733, Offset: 0xc29
// Size: 0x1c
function function_1b9fcfbf59318d98()
{
    self endon( #"death" );
    function_9f036e6a4a72d339();
    thread blindingturret_delete();
}

// Namespace blindingturret
// Params 0
// Checksum 0x4a24f19c, Offset: 0xc4d
// Size: 0x67
function function_9f036e6a4a72d339()
{
    level endon( #"game_ended" );
    self.owner endon( #"disconnect" );
    self.owner endon( #"joined_team" );
    self.owner endon( #"joined_spectators" );
    self.owner endon( #"hash_633869cfc9b1d60c" );
    hostmigration::waitlongdurationwithhostmigrationpause( 30 );
}

// Namespace blindingturret
// Params 1
// Checksum 0x848e8bae, Offset: 0xcbc
// Size: 0x1a7
function function_7c743b8c0ac6f2e9( grenade )
{
    turretfwd = grenade.origin - self.origin;
    turretorientation = vectortoangles( utility::flatten_vector( turretfwd ) );
    turret = spawnturret( "misc_turret", grenade.origin, "blinding_turret_mp", 0 );
    turret setmodel( "weapon_wm_mg_sentry_turret" );
    turret makeunusable();
    turret setnodeploy( 1 );
    turret setdefaultdroppitch( 0 );
    turret maketurretinoperable();
    turret setleftarc( 90 );
    turret setrightarc( 90 );
    turret setbottomarc( 50 );
    turret settoparc( 60 );
    turret setconvergencetime( 2.5, "pitch" );
    turret setconvergencetime( 2.5, "yaw" );
    turret setconvergenceheightpercent( 0.65 );
    turret setdefaultdroppitch( -89 );
    turret setturretmodechangewait( 1 );
    turret setmode( "manual_target" );
    turret.angles = turretorientation;
    turret.owner = self;
    turret setturretowner( self );
    turret setturretteam( self.team );
    turret.aimtarget = utility::spawn_tag_origin( turret.origin, turret.angles );
    turret.aimtarget linkto( turret, "tag_flash", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    turret.isidling = 0;
    grenade delete();
    return turret;
}

