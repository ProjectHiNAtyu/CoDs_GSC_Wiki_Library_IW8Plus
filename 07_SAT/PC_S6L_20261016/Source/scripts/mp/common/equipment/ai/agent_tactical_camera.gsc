// scripts\mp\common\equipment\ai\agent_tactical_camera.gsc  (hash_0ddf3698c9b9d94d.gscc) (size: 6624 Bytes / 0x19e0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6d2070b5 (1830842549)
// size ...... 6624 (0x19e0)
// includes .. 13  (offset: 0x1858)
// strings ... 22  (offset: 0x18c0)
// dev strs .. 0   (offset: 0x19e0)
// exports ... 15  (offset: 0xe00)
// cseg ...... 0x1cb + 0xc35 (0xe00)
// imports ... 71  (offset: 0x1058)
// animtree1 . 0   (offset: 0x19e0)
// animtree2 . 0   (offset: 0x19e0)
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\common\equipment\tactical_camera;
#using scripts\mp\common\utility\damage;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\deployable_camera_common;
#using scripts\mp\emp_debuff;
#using scripts\mp\outline;
#using scripts\mp\poi;

#namespace agent_tactical_camera;

// Namespace agent_tactical_camera
// Params 0
// Checksum 0x7b4d4d04, Offset: 0x1e9
// Size: 0x24
function function_5315380a90b7d14()
{
    level.var_cb28f5431edb1e50[ "agentTacCam" ] = spawnstruct();
    function_f0de55e9f54d248a();
    function_afb9f50277c3bb52();
}

// Namespace agent_tactical_camera
// Params 0
// Checksum 0x2e616ea2, Offset: 0x215
// Size: 0xa8
function function_afb9f50277c3bb52()
{
    taccamnodes = level.struct_class_names[ "script_noteworthy" ][ "trapper_taccam" ];
    
    if ( !isdefined( taccamnodes ) )
    {
        return;
    }
    
    foreach ( node in taccamnodes )
    {
        function_b1d4a9a5fc8d8095( node, node.origin, 1 );
    }
}

// Namespace agent_tactical_camera
// Params 0
// Checksum 0x7c0e705b, Offset: 0x2c5
// Size: 0x15d
function function_f0de55e9f54d248a()
{
    leveldata = deployable_camera_common::function_ddb6749d6d40be33( "agentTacCam" );
    leveldata.supername = "super_tac_camera";
    leveldata.lifetime = getdvarint( @"hash_13717e6e87cb530f", 120 );
    leveldata.destroyfunc = &function_9c9c23179af8bd90;
    leveldata.var_57bb115d2ac5b412 = &tactical_camera::function_983692460b27270e;
    leveldata.var_1d66ed73336b96f5 = &tactical_camera::function_54371d0c91ab5bd8;
    leveldata.var_e0a8f87cf8290970 = &tactical_camera::tacticalcamera_addmarkpoints;
    leveldata.var_2f24daeab8deae63 = &tactical_camera::function_983692460b27270e;
    leveldata.var_2eb55a80f88c3746 = &tactical_camera::function_9f68eb6e83cc936d;
    leveldata.var_26875662281a0bd1 = 250000;
    leveldata.var_9b15b961a6e22c68 = 250000;
    leveldata.sensorduration = 3;
    leveldata.markingsfx = "equip_tactical_cam_marking";
    leveldata.maxhealth = 100;
    leveldata.var_472a74ff4f3384db = &function_7b28c563e063f1f;
    leveldata.damagehandler = &function_711fe3bc8a5e6499;
    leveldata.orientationcontents = trace::create_contents( 1, 0, 0, 1, 0, 1, 0, 1, 1 );
    leveldata.var_c3053b6cc88402ae = getentarray( "tacCameraInvalid", #targetname );
}

// Namespace agent_tactical_camera
// Params 0
// Checksum 0x9e58626c, Offset: 0x42a
// Size: 0x13e
function function_2ed7c522aa27fe46()
{
    cameracenter = self getvieworigin();
    cameraorientation = self getplayerangles();
    cameraforward = anglestoforward( cameraorientation );
    cameratraceend = cameracenter + cameraforward * 256;
    ignorearray = self;
    contentarray = deployable_camera_common::function_ddb6749d6d40be33( "agentTacCam" ).orientationcontents;
    deploytrace = trace::ray_trace( cameracenter, cameratraceend, ignorearray, contentarray, 0, 0, 1 );
    
    if ( deploytrace[ "hittype" ] == "hittype_none" )
    {
        return;
    }
    
    deploypos = deploytrace[ "position" ];
    deployfwd = math::vector_project_onto_plane( vectornormalize( self.origin - deploytrace[ "position" ] ), deploytrace[ "normal" ] );
    deployup = deploytrace[ "normal" ];
    deployright = vectorcross( deployfwd, deployup );
    deployorientation = axistoangles( deployfwd, deployright, deployup );
    deploystruct = spawnstruct();
    deploystruct.origin = deploypos;
    deploystruct.angles = deployorientation;
    function_b1d4a9a5fc8d8095( deploystruct, deploypos );
}

// Namespace agent_tactical_camera
// Params 3
// Checksum 0x7f4a9e3, Offset: 0x570
// Size: 0xaa
function function_b1d4a9a5fc8d8095( deploystruct, deploypos, nolifetime )
{
    camera = deployable_camera_common::function_d9939fdafd600147( deploystruct, undefined, deploypos, utility::get_scripted_weapon_name( #"tactical_camera_turret" ), "turret_tactical_camera_v0", "agentTacCam", 1 );
    camera setmode( "manual" );
    camera.var_1942ed602fa25adc = 1;
    camera.script_poi = poi::poi_findpoioriginisin( camera.origin );
    
    if ( !nolifetime )
    {
        camera thread deployable_camera_common::function_d1e999863ff0886a( 1 );
    }
    
    camera thread function_242cec0ed7f238b1();
    camera thread deployable_camera_common::function_1eeb9de1633236bf();
}

// Namespace agent_tactical_camera
// Params 0
// Checksum 0x835ec473, Offset: 0x622
// Size: 0x3e
function function_9c9c23179af8bd90()
{
    self notify( #"death" );
    self.isdestroyed = 1;
    self setscriptablepartstate( "destroyed", "on", 0 );
    outline::outlinedisableinternalall( self );
    wait 0.1;
    self delete();
}

// Namespace agent_tactical_camera
// Params 1
// Checksum 0x230c7d52, Offset: 0x668
// Size: 0x105
function function_711fe3bc8a5e6499( data )
{
    if ( !isdefined( self ) || self.isdestroyed )
    {
        return 0;
    }
    
    if ( data.meansofdeath == "MOD_IMPACT" )
    {
        return 0;
    }
    
    damage2ret = data.damage;
    hits = undefined;
    
    if ( isexplosivedamagemod( data.meansofdeath ) )
    {
        hits = function_e26e2a81f0caa7bf( data );
    }
    else if ( utility::isbulletdamage( data.meansofdeath ) )
    {
        hits = function_8fcc6654609d4438( data );
    }
    
    if ( isdefined( hits ) )
    {
        damage2ret = int( ceil( min( 1, hits / 5 ) * self.maxhealth ) );
    }
    
    if ( self.damagetaken + damage2ret / self.maxhealth > 0.5 )
    {
        if ( !self.isdamaged )
        {
            self.isdamaged = 1;
            self setscriptablepartstate( "damaged", "on", 0 );
        }
    }
    
    return damage2ret;
}

// Namespace agent_tactical_camera
// Params 1
// Checksum 0xfedae487, Offset: 0x776
// Size: 0x6a
function function_7b28c563e063f1f( data )
{
    attacker = data.attacker;
    
    if ( !isdefined( data.attacker ) )
    {
        return;
    }
    
    if ( teams::function_f2b980a5ef176703( attacker.team ) )
    {
    }
    
    if ( isplayer( attacker ) )
    {
        attacker thread points::doscoreevent( #"dmz_trap_destroyed" );
    }
    
    function_9c9c23179af8bd90();
}

// Namespace agent_tactical_camera
// Params 2, eflags: 0x4
// Checksum 0x7bdaddeb, Offset: 0x7e8
// Size: 0x5a
function private function_e26e2a81f0caa7bf( data, isenemydamage )
{
    if ( data.damage > 200 )
    {
        return 20;
    }
    
    if ( data.damage > 70 )
    {
        return 10;
    }
    
    if ( data.damage > 30 )
    {
        return 7;
    }
    
    return 2;
}

// Namespace agent_tactical_camera
// Params 2, eflags: 0x4
// Checksum 0x3d669bcb, Offset: 0x84a
// Size: 0xb7
function private function_8fcc6654609d4438( data, isenemydamage )
{
    basehits = damage::isfmjdamage( data.objweapon, data.meansofdeath ) && isenemydamage ? 2 : 0;
    
    if ( data.damage > 150 )
    {
        return ( basehits + 10 );
    }
    
    if ( data.damage >= 50 )
    {
        return ( basehits + 5 );
    }
    
    if ( data.damage >= 30 )
    {
        return ( basehits + 3 );
    }
    
    if ( data.damage >= 20 )
    {
        return ( basehits + 2 );
    }
    
    return basehits + 1;
}

// Namespace agent_tactical_camera
// Params 0
// Checksum 0x39888495, Offset: 0x909
// Size: 0x15e
function function_242cec0ed7f238b1()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    entmask = createentitytypemask( [ "etype_player", "etype_ai" ] );
    
    while ( true )
    {
        targetarray = getentitiesinradiusfrompartitiongrid( self.origin, 1575, entmask );
        
        foreach ( ent in targetarray )
        {
            if ( !isdefined( ent ) )
            {
                continue;
            }
            
            if ( isplayer( ent ) || isbot( ent ) )
            {
                if ( !player::isreallyalive( ent ) )
                {
                    continue;
                }
            }
            
            if ( isagent( ent ) )
            {
                continue;
            }
            
            if ( emp_debuff::is_empd() )
            {
                continue;
            }
            
            targetinfo = deployable_camera_common::function_ee93ef87c2144487( ent );
            
            if ( !targetinfo.isvisible || !targetinfo.isindetectrange )
            {
                continue;
            }
            
            if ( self.markingtarget )
            {
                continue;
            }
            
            function_5c2261552ca56978( ent );
        }
        
        wait 0.25;
    }
}

// Namespace agent_tactical_camera
// Params 1
// Checksum 0xb7526c6d, Offset: 0xa6f
// Size: 0x128
function function_5c2261552ca56978( victimplayer )
{
    self settargetentity( victimplayer );
    timetracked = 0;
    trackedduration = getdvarfloat( @"hash_6cb0cf97f8ae3387", 3 );
    
    while ( timetracked < trackedduration )
    {
        targetinfo = deployable_camera_common::function_ee93ef87c2144487( victimplayer );
        
        if ( !targetinfo.isvisible || !targetinfo.isindetectrange )
        {
            self cleartargetentity();
            return;
        }
        
        timetracked += level.framedurationseconds;
        waitframe();
    }
    
    /#
        level thread utility::draw_line_for_time( victimplayer utility::function_f02ebab438642e16(), self.origin, 1, 0, 0, 100 );
        level thread utility::draw_line_for_time( victimplayer utility::function_68061c3d21a6d57a(), self.origin, 1, 0, 0, 100 );
        level thread utility::draw_line_for_time( victimplayer.origin, self.origin, 1, 0, 0, 100 );
    #/
    
    function_68af5a2591a846f5( victimplayer );
    
    if ( isdefined( level.var_e03d013e650ad286 ) )
    {
        self [[ level.var_e03d013e650ad286 ]]( victimplayer );
    }
    
    function_dff1753ca1262844( victimplayer );
}

// Namespace agent_tactical_camera
// Params 1
// Checksum 0xfd810ee3, Offset: 0xb9f
// Size: 0x91
function function_68af5a2591a846f5( victimplayer )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.var_df4b5e6930ce80af ) )
    {
        self.var_df4b5e6930ce80af = [];
    }
    
    if ( isdefined( self.var_df4b5e6930ce80af[ victimplayer.team ] ) )
    {
        return;
    }
    
    self.var_df4b5e6930ce80af[ victimplayer.team ] = [ victimplayer.team ];
    id = outline::outlineenableforteam( self, victimplayer.team, "spotter_notarget_equipment", "perk_superior" );
}

// Namespace agent_tactical_camera
// Params 1
// Checksum 0xfb607b15, Offset: 0xc38
// Size: 0x1c8
function function_dff1753ca1262844( victimplayer )
{
    timer = 0;
    
    while ( true )
    {
        victimplayer thread deployable_camera_common::function_d87e93294143124c();
        victimplayer deployable_camera_common::function_8cdabce49de74f20();
        victimplayer playlocalsound( "recon_drone_spotted_plr" );
        var_b4ff74050f80e1e7 = undefined;
        
        if ( isdefined( self.script_poi ) && getdvarint( @"hash_e242c057ecb7ee6b", 1 ) == 1 )
        {
            var_b4ff74050f80e1e7 = function_a664b3eb3bcb4e15( self.script_poi, "everybody" );
        }
        else
        {
            var_b4ff74050f80e1e7 = utility::function_1b1340a94b43b874( victimplayer.origin, 800, 0 );
        }
        
        foreach ( agent in var_b4ff74050f80e1e7 )
        {
            if ( !isdefined( agent ) || isint( agent ) )
            {
                continue;
            }
            
            if ( !isagent( agent ) )
            {
                continue;
            }
            
            if ( !isdefined( agent.team ) )
            {
                continue;
            }
            
            agent getenemyinfo( victimplayer );
        }
        
        refreshtime = getdvarfloat( @"hash_476ba3b2fd5d8fea", 5 );
        
        while ( timer < refreshtime )
        {
            targetinfo = deployable_camera_common::function_ee93ef87c2144487( victimplayer );
            
            if ( !targetinfo.isvisible || !targetinfo.isindetectrange || !targetinfo.var_f32175be69573064 )
            {
                self cleartargetentity();
                return;
            }
            
            wait 0.25;
            timer += 0.25;
        }
        
        timer = 0;
        waitframe();
    }
}

