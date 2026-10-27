// script_77eccf1055ba6c0  (hash_077eccf1055ba6c0.gscc) (size: 16416 Bytes / 0x4020 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x646f6ef7 (1685024503)
// size ...... 16416 (0x4020)
// includes .. 8   (offset: 0x3dc0)
// strings ... 16  (offset: 0x3e00)
// dev strs .. 27  (offset: 0x3ec0)
// exports ... 34  (offset: 0x2b98)
// cseg ...... 0x1cf + 0x29c9 (0x2b98)
// imports ... 100 (offset: 0x30e8)
// animtree1 . 0   (offset: 0x4020)
// animtree2 . 0   (offset: 0x4020)
#using script_44280f644740bac;
#using scripts\common\callbacks;
#using scripts\common\gameplay_sound_fx;
#using scripts\common\utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\gametypes\frun_checkpoints;
#using scripts\mp\gametypes\frun_free_run;

#namespace namespace_29443a521c37a7fc;

// Namespace namespace_29443a521c37a7fc
// Params 0
// Checksum 0x4f12bf10, Offset: 0x1ed
// Size: 0x51f
function init()
{
    level endon( #"game_ended" );
    utility::flag_wait( "scriptables_ready" );
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    
    if ( !isdefined( modeinfo.frun_bundle ) )
    {
        modeinfo.frun_bundle = game_utility_mp::function_4b7180ed8c2e9742( "gametypebundle_frun" );
    }
    
    modeinfo.var_89fa9d9a603525c3 = getdvarint( @"hash_f41e72190c1dbd7", modeinfo.frun_bundle.var_cb5c09071e3d5874 ?? 1500 );
    modeinfo.var_b319a11128eb6df5 = getdvarint( @"hash_b6a7785eb6b31135", modeinfo.frun_bundle.var_a3bc2d33fb2bd5a6 ?? 500 );
    modeinfo.var_148c7871815c14c6 = getdvarfloat( @"hash_311e337a147d5c3c", modeinfo.frun_bundle.var_a9ed26cc65dcc82d ?? 800 );
    modeinfo.var_948ea464f4432830 = getdvarfloat( @"hash_74084af53743c7f9", modeinfo.frun_bundle.var_8f5ebd71bd28dfce ?? 0.75 );
    modeinfo.var_a8c1467292c87baa = getdvarfloat( @"hash_bd94bfb6267b8127", modeinfo.frun_bundle.var_242330bc815da858 ?? 2.5 );
    modeinfo.var_8b0a98d50d7e105a = utility::function_6f5d2e1f1ff70482( getdvarfloat( @"hash_4d83973be58e436b", modeinfo.frun_bundle.var_a256222978620c32 ?? 1800 ) );
    modeinfo.var_864033a1afbdbf6f = getdvarint( @"hash_42e76a8a9dd07195", modeinfo.frun_bundle.var_66795a28df0e34b0 ?? 1 );
    modeinfo.var_b2b8c5bbe9a23daa = getdvarfloat( @"hash_aa8708da7505ba06", modeinfo.frun_bundle.var_c28aa6e989e0e8d5 ?? 1900000 );
    modeinfo.var_98dd7ea6eeda83e7 = getdvarint( @"hash_491f7df82d705757", modeinfo.frun_bundle.var_4de39151d3aa7908 ?? 3 );
    modeinfo.var_6eaba596ad2c5518 = utility::function_6f5d2e1f1ff70482( getdvarint( @"hash_9b2d853355855219", modeinfo.frun_bundle.var_2f1642eeb0db94b4 ?? 200 ) );
    modeinfo.var_da7ab9f670f6660d = getdvarint( @"hash_12b4681f54e9e6b0", modeinfo.frun_bundle.var_bd8ceed11eafda9 ?? 1 );
    modeinfo.var_32d91b71e61f8b15 = getdvarint( @"hash_1d6259d0de77b36c", modeinfo.frun_bundle.var_dac3b07a5c27413d ?? 0 );
    modeinfo.var_84d1dbcaf7d2e286 = squared( getdvarint( @"hash_aa3d9170f2ddbc5", modeinfo.frun_bundle.var_295e96de6c0360ec ?? 1300 ) );
    modeinfo.var_d3bcc8034e8ebb40 = getdvarint( @"hash_b2e6f4a9f8a6e1d7", modeinfo.frun_bundle.var_4cfe2d55894bafae ?? 1500 );
    modeinfo.var_ba748a5edfda3787 = getdvarfloat( @"hash_4edbe8a7272f090f", modeinfo.frun_bundle.var_d1d1ea0a8bacc790 ?? 1.005 );
    modeinfo.var_4952d4695940b10d = getdvarint( @"hash_c2ae5a60be80cfeb", modeinfo.frun_bundle.var_fb4517c059a05950 ?? 1 );
    modeinfo.var_8fc8cd0e7d06518f = getdvarint( @"hash_fbedd25e866110b6", modeinfo.frun_bundle.var_ac1dcbdd33aad62f ?? 1 );
    modeinfo.var_ebb1b5e1824cbabd = {};
    function_59dab1aadb23a079();
    function_8686191e164138e9();
    level callback::add( #"hash_6cd8138b7ddba849", &function_8eeac8ded02d77aa );
    var_b07e98b27b7474c6 = getent( "wingsuit_zone_start_trigger", #script_noteworthy );
    level trigger::makeenterexittrigger( var_b07e98b27b7474c6, &function_828146a9df07fb7e );
    
    /#
        helptext = "<dev string:x24>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fre" ][ #"registercommand" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( "<dev string:x5c>", "<dev string:x74>", &function_a7af488dc6d64f59, helptext, "<dev string:x78>", undefined );
        }
        
        helptext = "<dev string:x88>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fre" ][ #"registercommand" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( "<dev string:xb2>", "<dev string:x74>", &function_1eec1c7b0f47ae17, helptext, "<dev string:x78>", undefined );
        }
        
        helptext = "<dev string:xc5>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fre" ][ #"registercommand" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( "<dev string:xf1>", "<dev string:x74>", &function_d253f69fcb490e45, helptext, "<dev string:x78>", undefined );
        }
    #/
}

// Namespace namespace_29443a521c37a7fc
// Params 0
// Checksum 0xa24bc0bf, Offset: 0x714
// Size: 0x618
function function_59dab1aadb23a079()
{
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    modeinfo.var_ebb1b5e1824cbabd.ringlist = [];
    ringlist = modeinfo.var_ebb1b5e1824cbabd.ringlist;
    var_d5f397c92518a55 = [];
    trigger = getent( "first_wingsuit_ring", #script_noteworthy );
    var_d5f397c92518a55[ trigger getentitynumber() ] = ringlist.size;
    trigger::makeenterexittrigger( trigger, &function_b962c55828861263, undefined, undefined, undefined, undefined, ringlist.size );
    ringlist[ ringlist.size ] = { #trigger:trigger };
    
    while ( true )
    {
        trigger = getent( trigger.target, #script_noteworthy );
        var_d5f397c92518a55[ trigger getentitynumber() ] = ringlist.size;
        trigger::makeenterexittrigger( trigger, &function_b962c55828861263, undefined, undefined, undefined, undefined, ringlist.size );
        ringlist[ ringlist.size ] = { #trigger:trigger };
        
        if ( trigger.script_noteworthy == "wingsuit_end" )
        {
            break;
        }
    }
    
    ringcenters = getentarray( "wingsuit_ring_centre", #script_noteworthy );
    
    foreach ( ringcenter in ringcenters )
    {
        trigger = getent( ringcenter.target, #targetname );
        ringlist[ var_d5f397c92518a55[ trigger getentitynumber() ] ].center = ringcenter;
    }
    
    killtriggers = getentarray( "wingsuit_kill_trigger", #script_noteworthy );
    
    foreach ( killtrigger in killtriggers )
    {
        trigger = getent( killtrigger.target, #targetname );
        ringinfo = ringlist[ var_d5f397c92518a55[ trigger getentitynumber() ] ];
        ringinfo.killtrigger = killtrigger;
        trigger::makeenterexittrigger( killtrigger, &function_2b79899bfc464e2a );
    }
    
    var_a118ed316acb55b2 = getentitylessscriptablearray( "wingsuit_ring", #script_noteworthy );
    
    foreach ( visual in var_a118ed316acb55b2 )
    {
        trigger = getent( visual.target, #targetname );
        ringlist[ var_d5f397c92518a55[ trigger getentitynumber() ] ].var_6a41077566f415f5 = visual;
    }
    
    var_118a16741ba3dd67 = getentitylessscriptablearray( "wingsuit_ring_lit", #script_noteworthy );
    
    foreach ( visual in var_118a16741ba3dd67 )
    {
        trigger = getent( visual.target, #targetname );
        ringlist[ var_d5f397c92518a55[ trigger getentitynumber() ] ].var_c4d97a5e33190d06 = visual;
        visual setscriptablepartstate( #"light", #"on" );
    }
    
    var_2216b8bd5fdd7cf5 = getentarray( "wingsuit_ring_attachment", #script_noteworthy );
    
    foreach ( collider in var_2216b8bd5fdd7cf5 )
    {
        trigger = getent( collider.target, #targetname );
        ringnumber = trigger getentitynumber();
        ringlist[ var_d5f397c92518a55[ ringnumber ] ].collider = collider;
        collider enablelinkto();
        collider linkto( ringlist[ var_d5f397c92518a55[ ringnumber ] ].center );
    }
    
    wingsuitcheckpoints = getentarray( "wingsuit_checkpoint", #script_noteworthy );
    
    foreach ( checkpoint in wingsuitcheckpoints )
    {
        if ( !checkpoint.script_label )
        {
            continue;
        }
        
        foreach ( ringidx, ring in ringlist )
        {
            if ( ring.trigger.script_noteworthy == checkpoint.script_label )
            {
                checkpoint.var_635026ea67b026d1 = ringidx;
                break;
            }
        }
    }
}

// Namespace namespace_29443a521c37a7fc
// Params 2, eflags: 0x4
// Checksum 0xc0c8ba94, Offset: 0xd34
// Size: 0x34
function private function_ce774d22e539f043( player, trigger )
{
    if ( !isplayer( player ) || !isalive( player ) )
    {
        return;
    }
    
    function_105c09e54abd16c2( player );
}

// Namespace namespace_29443a521c37a7fc
// Params 1
// Checksum 0xd7f7df72, Offset: 0xd70
// Size: 0x24
function function_105c09e54abd16c2( player )
{
    player.freeruninfo.var_af7d4416daf710ee = 1;
}

// Namespace namespace_29443a521c37a7fc
// Params 1, eflags: 0x4
// Checksum 0x800b6062, Offset: 0xd9c
// Size: 0x21
function private function_888afab044bbd33c( player )
{
    return player.freeruninfo.var_af7d4416daf710ee;
}

// Namespace namespace_29443a521c37a7fc
// Params 1, eflags: 0x4
// Checksum 0x2d223228, Offset: 0xdc6
// Size: 0x23
function private function_5b4908b550f41333( player )
{
    player.freeruninfo.var_af7d4416daf710ee = 0;
}

// Namespace namespace_29443a521c37a7fc
// Params 0
// Checksum 0x8dbaf070, Offset: 0xdf1
// Size: 0xe6
function function_ca7da31bda8e254c()
{
    self notify( #"hash_5c700e5bc0a4cd3d" );
    self endon( #"hash_5c700e5bc0a4cd3d" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    
    if ( !modeinfo.var_4952d4695940b10d )
    {
        return;
    }
    
    waitframe();
    
    while ( self )
    {
        if ( self.freeruninfo.wingsuitequipped && !self iswingsuitdeployed() )
        {
            var_66322ee3bc7a5708 = self isonground() || self isonladder() || self isonzipline() || self isonascender();
            canwingsuit = !var_66322ee3bc7a5708 && ( self isbasejumpavailable() || self isinfreefall() || self isskydiving() );
            
            if ( canwingsuit )
            {
                self skydive_beginfreefall();
                self skydive_deployparachute();
                wait 0.25;
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_29443a521c37a7fc
// Params 0
// Checksum 0x95bdee00, Offset: 0xedf
// Size: 0x5f
function function_a7538c20aa2dd747()
{
    self notify( #"hash_44d23ef9eb57816f" );
    self endon( #"hash_44d23ef9eb57816f" );
    self endon( #"death_or_disconnect" );
    
    while ( self )
    {
        if ( !isplayer( self ) || !isalive( self ) )
        {
            break;
        }
        
        if ( function_888afab044bbd33c( self ) )
        {
            thread function_3f24337d01ea0a9( self, self.origin );
        }
        
        waitframe();
    }
}

// Namespace namespace_29443a521c37a7fc
// Params 0
// Checksum 0x42751328, Offset: 0xf46
// Size: 0xc9
function function_183ded8ab72ea1da()
{
    self notify( #"hash_1f56c14ce0d6ea5e" );
    self endon( #"hash_1f56c14ce0d6ea5e" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    
    if ( !modeinfo.var_8fc8cd0e7d06518f )
    {
        return;
    }
    
    waitframe();
    
    while ( self )
    {
        if ( self.freeruninfo.wingsuitequipped && self.freeruninfo.var_b29f5c9ab160dda7 )
        {
            var_66322ee3bc7a5708 = self isonground() || self isonladder() || self isonzipline() || self isonascender();
            
            if ( var_66322ee3bc7a5708 )
            {
                function_f6c7f9bb7bb8881d( self );
                frun_checkpoints::function_aae76b5997fc6288( self );
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_29443a521c37a7fc
// Params 0, eflags: 0x4
// Checksum 0xd05acd17, Offset: 0x1017
// Size: 0x140
function private function_8686191e164138e9()
{
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    modeinfo.var_ebb1b5e1824cbabd.pathstructs = [];
    modeinfo.var_ebb1b5e1824cbabd.pathpoints = [];
    structlist = modeinfo.var_ebb1b5e1824cbabd.pathstructs;
    pointlist = modeinfo.var_ebb1b5e1824cbabd.pathpoints;
    
    for ( curnode = utility::getstruct( "wingsuit_target_path_start", "script_noteworthy" ); curnode ; curnode = utility::getstruct( curnode.target, "targetname" ) )
    {
        structlist[ structlist.size ] = curnode;
        pointlist[ pointlist.size ] = curnode.origin;
        
        if ( !curnode.target )
        {
            break;
        }
    }
    
    starttrigger = spawn( "trigger_radius", pointlist[ 0 ], 0, 800, 800 );
    trigger::makeenterexittrigger( starttrigger, &function_ce774d22e539f043 );
    modeinfo.var_ebb1b5e1824cbabd.splineinfo = function_70f5e2084fafa10d( modeinfo.var_ebb1b5e1824cbabd.pathpoints );
}

// Namespace namespace_29443a521c37a7fc
// Params 1, eflags: 0x4
// Checksum 0x1c75202, Offset: 0x115f
// Size: 0xd8
function private function_2e6aa984c0aeaf0( player )
{
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    
    foreach ( ring in modeinfo.var_ebb1b5e1824cbabd.ringlist )
    {
        if ( ring.var_6a41077566f415f5 )
        {
            ring.var_6a41077566f415f5 function_d6a7b7ef13a57f38( player );
        }
        
        if ( ring.var_c4d97a5e33190d06 )
        {
            ring.var_c4d97a5e33190d06 function_d6a7b7ef13a57f38( player );
        }
    }
}

// Namespace namespace_29443a521c37a7fc
// Params 1, eflags: 0x4
// Checksum 0x277502ff, Offset: 0x123f
// Size: 0x14
function private function_8eeac8ded02d77aa( params )
{
    function_2e6aa984c0aeaf0( self );
}

// Namespace namespace_29443a521c37a7fc
// Params 1, eflags: 0x4
// Checksum 0x3a0ed8c9, Offset: 0x125b
// Size: 0x199
function private function_70f5e2084fafa10d( pathpoints )
{
    var_9c10d6932006d854 = level.framedurationseconds;
    totaldistance = 0;
    point = 1;
    
    while ( point < pathpoints.size )
    {
        totaldistance += distance( pathpoints[ point - 1 ], pathpoints[ point ] );
        point += 1;
    }
    
    pathtimes = [];
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    var_f22e87dfeee0c22 = 0;
    point = 1;
    
    while ( point < pathpoints.size )
    {
        dist = distance( pathpoints[ point - 1 ], pathpoints[ point ] );
        var_7f4596978bd4442e = dist / modeinfo.var_148c7871815c14c6;
        var_f22e87dfeee0c22 += var_7f4596978bd4442e;
        pathtimes[ pathtimes.size ] = var_7f4596978bd4442e;
        point += 1;
    }
    
    pathtimes[ pathtimes.size ] = var_9c10d6932006d854;
    tension = clamp( 0.5, 0.01, 1 );
    alpha = clamp( 0.75, 0, 1 );
    splineid = function_53253e8ea222ed60( pathpoints, pathtimes, 0, tension, alpha, 1 );
    totaldistance = function_176ae9ba12543764( splineid );
    var_4fa4ecdd814e538d = [];
    
    for ( s = 0; s < var_f22e87dfeee0c22 ; s++ )
    {
        point = function_2bf2352736fc6ac8( splineid, s );
        var_4fa4ecdd814e538d[ var_4fa4ecdd814e538d.size ] = point;
    }
    
    return { #var_f22e87dfeee0c22:var_f22e87dfeee0c22, #var_4fa4ecdd814e538d:var_4fa4ecdd814e538d, #pathtimes:pathtimes, #pathpoints:pathpoints, #splineid:splineid };
}

// Namespace namespace_29443a521c37a7fc
// Params 2, eflags: 0xc
// Checksum 0x37fb427, Offset: 0x13fd
// Size: 0x15f
function private function_3f24337d01ea0a9( player, var_39a49dc4dece1623 )
{
    self notify( #"hash_8a161607fb745d92" );
    self endon( #"hash_8a161607fb745d92" );
    player endon( #"death_or_disconnect" );
    function_5b4908b550f41333( player );
    function_f6c7f9bb7bb8881d( player );
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    pathpoints = modeinfo.var_ebb1b5e1824cbabd.pathpoints;
    var_7c170ceae0649b57 = [ #"teamselect", player getentitynumber() ];
    chasetarget = spawnscriptable( "mp_sat_freerun_wingsuit_chase_target", pathpoints[ 0 ], undefined, undefined, var_7c170ceae0649b57 );
    player.freeruninfo.var_b29f5c9ab160dda7 = chasetarget;
    chasetarget setscriptablepartstate( #"base", #"active" );
    starttimeseconds = function_ca602e5df1f2d896( modeinfo.var_ebb1b5e1824cbabd.splineinfo.var_4fa4ecdd814e538d, var_39a49dc4dece1623 );
    
    if ( modeinfo.var_864033a1afbdbf6f )
    {
        player thread function_fd17360462312fbf( player, starttimeseconds );
    }
    
    chasetarget function_f9d371f2122d686b( pathpoints, player, starttimeseconds );
    
    if ( chasetarget )
    {
        chasetarget setscriptablepartstate( #"base", #"caught" );
    }
}

// Namespace namespace_29443a521c37a7fc
// Params 1, eflags: 0x4
// Checksum 0x4bb6ff00, Offset: 0x1564
// Size: 0x68
function private function_f6c7f9bb7bb8881d( player )
{
    if ( player.freeruninfo.var_b29f5c9ab160dda7 )
    {
        player.freeruninfo.var_b29f5c9ab160dda7 freescriptable();
        player.freeruninfo.var_b29f5c9ab160dda7 = undefined;
        player.freeruninfo.var_4beaa026e8952df = undefined;
    }
}

// Namespace namespace_29443a521c37a7fc
// Params 2, eflags: 0xc
// Checksum 0xf86e39df, Offset: 0x15d4
// Size: 0x2d4
function private function_fd17360462312fbf( player, var_c6cbea51379083ef )
{
    self notify( #"hash_fdd862fb8457975c" );
    self endon( #"hash_fdd862fb8457975c" );
    player endon( #"death_or_disconnect" );
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    splineinfo = modeinfo.var_ebb1b5e1824cbabd.splineinfo;
    var_5d95b3efc97d4832 = var_c6cbea51379083ef;
    lookaheadseconds = modeinfo.var_98dd7ea6eeda83e7;
    var_310eb32985bd2183 = modeinfo.var_b2b8c5bbe9a23daa;
    startpoint = splineinfo.var_4fa4ecdd814e538d[ var_5d95b3efc97d4832 ];
    startdistsq = distancesquared( player.origin, startpoint );
    
    if ( startdistsq > var_310eb32985bd2183 )
    {
        /#
            var_8870046bf7da3d72 = "<dev string:x105>";
            var_8870046bf7da3d72 += "<dev string:x136>";
            var_8870046bf7da3d72 += "<dev string:x171>" + player.origin;
            var_8870046bf7da3d72 += "<dev string:x17e>" + ( player.freeruninfo.activespawnpoint.origin ?? "<dev string:x18a>" );
            var_8870046bf7da3d72 += "<dev string:x18f>" + ( player.freeruninfo.zoneindex ?? 0 ) + "<dev string:x1a5>" + ( player.freeruninfo.checkpointindex ?? 0 );
            assertmsg( var_8870046bf7da3d72 );
        #/
        
        wait 0.25;
    }
    
    var_87686b3f3ffddda8 = modeinfo.var_6eaba596ad2c5518;
    watcherendtime = int( splineinfo.var_f22e87dfeee0c22 - 1 );
    
    while ( player.freeruninfo.var_b29f5c9ab160dda7 && var_5d95b3efc97d4832 < watcherendtime )
    {
        curpoint = splineinfo.var_4fa4ecdd814e538d[ var_5d95b3efc97d4832 ];
        curdistsq = distancesquared( player.origin, curpoint );
        
        for ( i = 1; i < lookaheadseconds ; i++ )
        {
            var_696aed4c4121188b = var_5d95b3efc97d4832 + i;
            
            if ( var_696aed4c4121188b >= splineinfo.var_4fa4ecdd814e538d.size )
            {
                continue;
            }
            
            nextpoint = splineinfo.var_4fa4ecdd814e538d[ var_696aed4c4121188b ];
            nextdistsq = distancesquared( player.origin, nextpoint );
            
            if ( nextdistsq < curdistsq )
            {
                curdistsq = nextdistsq;
                curpoint = nextpoint;
                var_5d95b3efc97d4832 = var_696aed4c4121188b;
            }
        }
        
        /#
            player.freeruninfo.var_b21b9e929d2232a9 = curpoint;
        #/
        
        if ( curdistsq > var_310eb32985bd2183 )
        {
            function_f6c7f9bb7bb8881d( player );
            frun_checkpoints::function_aae76b5997fc6288( player );
            return;
        }
        
        wait var_87686b3f3ffddda8;
    }
}

// Namespace namespace_29443a521c37a7fc
// Params 2, eflags: 0x4
// Checksum 0x9235a7d5, Offset: 0x18b0
// Size: 0xc2, Type: bool
function private function_ca602e5df1f2d896( pointlist, targetpos )
{
    nearestsq = undefined;
    nearestindex = undefined;
    
    foreach ( index, point in pointlist )
    {
        distancesq = distancesquared( targetpos, point );
        
        if ( !isdefined( nearestsq ) || distancesq < nearestsq )
        {
            nearestsq = distancesq;
            nearestindex = index;
        }
    }
    
    return nearestindex ?? 0;
}

// Namespace namespace_29443a521c37a7fc
// Params 3, eflags: 0xc
// Checksum 0x865653a0, Offset: 0x197b
// Size: 0x1df
function private function_f9d371f2122d686b( pathpoints, player, starttimeseconds )
{
    self notify( #"hash_fa69c06e6823fd61" );
    self endon( #"hash_fa69c06e6823fd61" );
    self endon( #"death" );
    self endon( #"stop_curve" );
    var_9c10d6932006d854 = level.framedurationseconds;
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    splineinfo = modeinfo.var_ebb1b5e1824cbabd.splineinfo;
    var_5d95b3efc97d4832 = starttimeseconds;
    var_4e9a068160e71dfa = level.framedurationseconds;
    var_db3f21e6adad591f = var_5d95b3efc97d4832;
    
    while ( self && var_5d95b3efc97d4832 < splineinfo.var_f22e87dfeee0c22 )
    {
        self.origin = function_2bf2352736fc6ac8( splineinfo.splineid, var_5d95b3efc97d4832 );
        self.lookaheadorigin = function_2bf2352736fc6ac8( splineinfo.splineid, var_5d95b3efc97d4832 + 3 );
        self.angles = function_7062a9ae37ef4c8b( splineinfo.splineid, var_5d95b3efc97d4832 );
        
        if ( var_5d95b3efc97d4832 >= var_db3f21e6adad591f )
        {
            self.var_fe951488e0bc375b = function_6fccf8548f429182( player, self.origin, modeinfo.var_a8c1467292c87baa, modeinfo.var_948ea464f4432830, modeinfo.var_89fa9d9a603525c3, modeinfo.var_b319a11128eb6df5 );
            self.var_d0f4c2e381d1f875 = function_6fccf8548f429182( player, self.lookaheadorigin, modeinfo.var_a8c1467292c87baa, modeinfo.var_948ea464f4432830, modeinfo.var_89fa9d9a603525c3, modeinfo.var_b319a11128eb6df5 );
            var_db3f21e6adad591f = var_5d95b3efc97d4832 + modeinfo.var_8b0a98d50d7e105a;
        }
        
        var_4e9a068160e71dfa = var_9c10d6932006d854 * self.var_fe951488e0bc375b;
        var_5d95b3efc97d4832 += var_4e9a068160e71dfa;
        waitframe();
    }
}

// Namespace namespace_29443a521c37a7fc
// Params 6, eflags: 0x4
// Checksum 0xd86deeb4, Offset: 0x1b62
// Size: 0xcd
function private function_6fccf8548f429182( player, splinepoint, var_76227f9e199c8e21, var_68a1ef5dd3ab1323, maxdistance, mindistance )
{
    if ( !isplayer( player ) || !isalive( player ) )
    {
        assertmsg( "<dev string:x1a7>" );
        return 1;
    }
    
    distance = distance( player.origin, splinepoint );
    distancenorm = max( 0, distance - mindistance );
    distanceratio = distancenorm / maxdistance;
    invratio = var_76227f9e199c8e21 - distanceratio;
    var_ec5fdadfe68fe050 = clamp( invratio, var_68a1ef5dd3ab1323, var_76227f9e199c8e21 );
    multiplier = var_ec5fdadfe68fe050;
    return multiplier;
}

// Namespace namespace_29443a521c37a7fc
// Params 2, eflags: 0xc
// Checksum 0xca478cf7, Offset: 0x1c38
// Size: 0x87
function private function_828146a9df07fb7e( player, trigger )
{
    self notify( #"hash_ba0c7cceb2c15b8f" );
    self endon( #"hash_ba0c7cceb2c15b8f" );
    
    if ( player.freeruninfo.ringsenabled || !isplayer( player ) || !isalive( player ) )
    {
        return;
    }
    
    player function_1ca79e09e9f633d2();
    player function_a144ec87d3acc2ad( 0 );
    player.freeruninfo.ringsenabled = 1;
}

// Namespace namespace_29443a521c37a7fc
// Params 3, eflags: 0x4
// Checksum 0x1efa809, Offset: 0x1cc7
// Size: 0xf2
function private function_b962c55828861263( player, trigger, triggerindex )
{
    if ( !isplayer( player ) || !isalive( player ) )
    {
        return;
    }
    
    if ( !self.freeruninfo.wingsuitequipped || !self.freeruninfo.var_b29f5c9ab160dda7 )
    {
        return;
    }
    
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    player.freeruninfo.var_4beaa026e8952df = modeinfo.var_ebb1b5e1824cbabd.ringlist[ triggerindex ].killtrigger;
    player thread function_6fc8e1e2b62e5e69( player );
    player function_71f44724c5564e7e( triggerindex );
    player function_a144ec87d3acc2ad( triggerindex + 1 );
    player gameplay_sound_fx::playlocalsoundfx( #"winguit_ring" );
    pbgpostfxbundlestart( player, %"sat_mp_freerun_ws_ring" );
}

// Namespace namespace_29443a521c37a7fc
// Params 2, eflags: 0x4
// Checksum 0xe2941616, Offset: 0x1dc1
// Size: 0xb8
function private function_2b79899bfc464e2a( player, trigger )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    player endon( #"wingsuit_course_started" );
    
    if ( !self.freeruninfo.wingsuitequipped || !self.freeruninfo.var_b29f5c9ab160dda7 )
    {
        return;
    }
    
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    
    if ( !modeinfo.var_da7ab9f670f6660d )
    {
        return;
    }
    
    wait 0.2;
    
    if ( trigger == player.freeruninfo.var_4beaa026e8952df )
    {
        return;
    }
    
    frun_checkpoints::function_aae76b5997fc6288( player );
}

// Namespace namespace_29443a521c37a7fc
// Params 1, eflags: 0xc
// Checksum 0x371a4b08, Offset: 0x1e81
// Size: 0x109
function private function_6fc8e1e2b62e5e69( player )
{
    self notify( #"hash_675d4f3242695cf9" );
    self endon( #"hash_675d4f3242695cf9" );
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    
    if ( modeinfo.var_32d91b71e61f8b15 )
    {
        v_currentvelocity = player getvelocity();
        v_playerforward = anglestoforward( player getplayerangles() );
        player setvelocity( v_currentvelocity + v_playerforward * 500 );
        return;
    }
    
    endtimems = gettime() + modeinfo.var_d3bcc8034e8ebb40;
    
    while ( isplayer( player ) && isalive( player ) )
    {
        if ( gettime() >= endtimems )
        {
            break;
        }
        
        var_81ea891e6bc9cb1e = player getvelocity();
        velocitysq = lengthsquared( var_81ea891e6bc9cb1e );
        
        if ( velocitysq < modeinfo.var_84d1dbcaf7d2e286 )
        {
            var_79415083d951c6f6 = var_81ea891e6bc9cb1e * modeinfo.var_ba748a5edfda3787;
            player setvelocity( var_79415083d951c6f6 );
        }
        
        waitframe();
    }
}

// Namespace namespace_29443a521c37a7fc
// Params 1
// Checksum 0xbeeaa20b, Offset: 0x1f92
// Size: 0x99
function function_a144ec87d3acc2ad( ringindex )
{
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    ringlist = modeinfo.var_ebb1b5e1824cbabd.ringlist;
    
    if ( ringindex < 0 || ringindex >= ringlist.size )
    {
        return;
    }
    
    if ( ringlist[ ringindex ].var_6a41077566f415f5 && ringlist[ ringindex ].var_c4d97a5e33190d06 )
    {
        ringlist[ ringindex ].var_c4d97a5e33190d06 function_6113853a877d5460( self );
        ringlist[ ringindex ].var_6a41077566f415f5 function_d6a7b7ef13a57f38( self );
    }
}

// Namespace namespace_29443a521c37a7fc
// Params 1
// Checksum 0x2a197c24, Offset: 0x2033
// Size: 0x99
function function_71f44724c5564e7e( ringindex )
{
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    ringlist = modeinfo.var_ebb1b5e1824cbabd.ringlist;
    
    if ( ringindex < 0 || ringindex >= ringlist.size )
    {
        return;
    }
    
    if ( ringlist[ ringindex ].var_6a41077566f415f5 && ringlist[ ringindex ].var_c4d97a5e33190d06 )
    {
        ringlist[ ringindex ].var_6a41077566f415f5 function_6113853a877d5460( self );
        ringlist[ ringindex ].var_c4d97a5e33190d06 function_d6a7b7ef13a57f38( self );
    }
}

// Namespace namespace_29443a521c37a7fc
// Params 0
// Checksum 0x4ea5ecd2, Offset: 0x20d4
// Size: 0xcd
function function_1ca79e09e9f633d2()
{
    modeinfo = frun_free_run::function_97dc8f6dff0a9255();
    
    foreach ( ring in modeinfo.var_ebb1b5e1824cbabd.ringlist )
    {
        if ( ring.var_6a41077566f415f5 && ring.var_c4d97a5e33190d06 )
        {
            ring.var_6a41077566f415f5 function_6113853a877d5460( self );
            ring.var_c4d97a5e33190d06 function_d6a7b7ef13a57f38( self );
        }
    }
}

/#

    // Namespace namespace_29443a521c37a7fc
    // Params 2, eflags: 0x4
    // Checksum 0x87bdf0a5, Offset: 0x21a9
    // Size: 0x5a, Type: dev
    function private function_a7af488dc6d64f59( host, args )
    {
        var_e192ef1147f518ac = namespace_ec33f26de741e14e::function_7fb3afaa98ee9eeb( "<dev string:x74>" );
        var_e192ef1147f518ac.var_ded7be848ee3759a = !var_e192ef1147f518ac.var_ded7be848ee3759a;
        level thread function_f35ed16b4482eb79( var_e192ef1147f518ac.var_ded7be848ee3759a );
    }

    // Namespace namespace_29443a521c37a7fc
    // Params 1, eflags: 0xc
    // Checksum 0xdae01a70, Offset: 0x220b
    // Size: 0x14d, Type: dev
    function private function_f35ed16b4482eb79( enabled )
    {
        self notify( #"hash_237b02e50aab68af" );
        self endon( #"hash_237b02e50aab68af" );
        
        if ( !enabled )
        {
            return;
        }
        
        modeinfo = frun_free_run::function_97dc8f6dff0a9255();
        
        while ( true )
        {
            player = level.players[ 0 ];
            
            if ( !player )
            {
                waitframe();
                continue;
            }
            
            foreach ( index, ringinfo in modeinfo.var_ebb1b5e1824cbabd.ringlist )
            {
                var_dfbe331c7b1f42f9 = modeinfo.var_ebb1b5e1824cbabd.ringlist[ index + 1 ];
                distancesq = distancesquared( player.origin, ringinfo.center.origin );
                
                if ( distancesq < 20000000 )
                {
                    function_b3827d85be74a984( player, index, ringinfo, var_dfbe331c7b1f42f9 );
                }
            }
            
            waitframe();
        }
    }

    // Namespace namespace_29443a521c37a7fc
    // Params 4, eflags: 0x4
    // Checksum 0xf4d89b90, Offset: 0x2360
    // Size: 0x23f, Type: dev
    function private function_b3827d85be74a984( host, index, var_35611af0300ee14a, var_466eedc44d8ceabb )
    {
        origin = var_35611af0300ee14a.center.origin;
        
        if ( !var_35611af0300ee14a.var_6a41077566f415f5 )
        {
            assertmsg( "<dev string:x1b4>" );
        }
        
        var_e73c15952d4b75e6 = var_35611af0300ee14a.var_6a41077566f415f5 function_50b79f4d4032e234( host );
        var_bad8466f000a6e55 = var_35611af0300ee14a.var_c4d97a5e33190d06 function_50b79f4d4032e234( host );
        
        if ( var_bad8466f000a6e55 && var_e73c15952d4b75e6 )
        {
            var_5c5034c52bf01dcb = "<dev string:x1c1>";
            triggercolor = ( 1, 0, 0 );
        }
        else if ( var_bad8466f000a6e55 )
        {
            var_5c5034c52bf01dcb = "<dev string:x1cb>";
            triggercolor = ( 0, 1, 0 );
        }
        else if ( var_e73c15952d4b75e6 )
        {
            var_5c5034c52bf01dcb = "<dev string:x1d4>";
            triggercolor = ( 0, 0, 1 );
        }
        else
        {
            var_5c5034c52bf01dcb = "<dev string:x1df>";
            triggercolor = ( 0.75, 0.75, 0.75 );
        }
        
        if ( var_466eedc44d8ceabb )
        {
            line( origin, var_466eedc44d8ceabb.center.origin, ( 1, 0.75, 0.75 ), 1, 0 );
        }
        
        var_35611af0300ee14a.labelinfo = "<dev string:x1e9>" + index + "<dev string:x1f8>" + var_5c5034c52bf01dcb;
        print3d( origin + ( 0, 0, 200 ), var_35611af0300ee14a.labelinfo, ( 1, 1, 1 ), 1, 1, 1, 1 );
        box( origin, 0, ( 1, 0.75, 0.75 ), 0, 1 );
        
        if ( var_35611af0300ee14a.var_6a41077566f415f5 )
        {
            sphere( var_35611af0300ee14a.var_6a41077566f415f5.origin, 30, ( 0.5, 0, 1 ), 1 );
        }
        
        if ( var_35611af0300ee14a.killtrigger )
        {
            drawtrigger( var_35611af0300ee14a.killtrigger, ( 1, 0, 0 ), 0 );
        }
        
        drawtrigger( var_35611af0300ee14a.trigger, triggercolor, 0 );
    }

    // Namespace namespace_29443a521c37a7fc
    // Params 2, eflags: 0x4
    // Checksum 0xbee1923e, Offset: 0x25a7
    // Size: 0x2d, Type: dev
    function private function_1eec1c7b0f47ae17( host, args )
    {
        host function_3f24337d01ea0a9( host, host.origin );
    }

    // Namespace namespace_29443a521c37a7fc
    // Params 2, eflags: 0x4
    // Checksum 0x80e80c27, Offset: 0x25dc
    // Size: 0x5c, Type: dev
    function private function_d253f69fcb490e45( host, args )
    {
        var_e192ef1147f518ac = namespace_ec33f26de741e14e::function_7fb3afaa98ee9eeb( "<dev string:x74>" );
        var_e192ef1147f518ac.var_37d5ae223e5dfc26 = !var_e192ef1147f518ac.var_37d5ae223e5dfc26;
        level thread function_364f53de3a7c54e5( var_e192ef1147f518ac.var_37d5ae223e5dfc26, host );
    }

    // Namespace namespace_29443a521c37a7fc
    // Params 2, eflags: 0xc
    // Checksum 0xe8dd26e1, Offset: 0x2640
    // Size: 0x50, Type: dev
    function private function_364f53de3a7c54e5( enabled, player )
    {
        self notify( #"hash_187dab6dcd03d1b9" );
        self endon( #"hash_187dab6dcd03d1b9" );
        
        if ( !enabled || !player )
        {
            return;
        }
        
        while ( true )
        {
            function_6664ee99684fe22d( player );
            waitframe();
        }
    }

    // Namespace namespace_29443a521c37a7fc
    // Params 1, eflags: 0x4
    // Checksum 0xe97314ae, Offset: 0x2698
    // Size: 0x500, Type: dev
    function private function_6664ee99684fe22d( player )
    {
        modeinfo = frun_free_run::function_97dc8f6dff0a9255();
        
        foreach ( pathpoint in modeinfo.var_ebb1b5e1824cbabd.splineinfo.pathpoints )
        {
            sphere( pathpoint, 10, ( 0.5, 0, 1 ), 1 );
        }
        
        foreach ( pathpoint in modeinfo.var_ebb1b5e1824cbabd.splineinfo.var_4fa4ecdd814e538d )
        {
            sphere( pathpoint, 10, ( 1, 1, 0 ), 1 );
        }
        
        if ( player.freeruninfo.var_b21b9e929d2232a9 )
        {
            var_331e38461c38c0a3 = player.freeruninfo.var_b21b9e929d2232a9;
            var_5feafc607be8eb9c = distancesquared( player.origin, var_331e38461c38c0a3 );
            var_ca87f43e853ecfce = clamp( var_5feafc607be8eb9c / modeinfo.var_b2b8c5bbe9a23daa, 0, 1 );
            var_22d047ebdb4e873a = ( var_ca87f43e853ecfce * 1, 1 - var_ca87f43e853ecfce, 0 );
            line( player.origin, var_331e38461c38c0a3, var_22d047ebdb4e873a, 1, 1 );
            sphere( var_331e38461c38c0a3, 15, var_22d047ebdb4e873a, 1 );
            sphere( player.origin, 10, var_22d047ebdb4e873a, 1 );
        }
        
        if ( !player.freeruninfo.var_124652e8b6b5e993 )
        {
            player.freeruninfo.var_124652e8b6b5e993 = 1;
            player childthread utility::function_9f777c9a7fffb9fc( modeinfo.var_ebb1b5e1824cbabd.splineinfo.splineid, 999, "<dev string:x204>" );
        }
        
        chasetarget = player.freeruninfo.var_b29f5c9ab160dda7;
        
        if ( !chasetarget )
        {
            return;
        }
        
        currentmult = chasetarget.var_fe951488e0bc375b;
        lookaheadmult = chasetarget.var_d0f4c2e381d1f875;
        
        if ( !isdefined( currentmult ) )
        {
            return;
        }
        
        var_727499df48bb4055 = currentmult < lookaheadmult;
        
        if ( var_727499df48bb4055 )
        {
            activemult = lookaheadmult;
            line( player.origin, chasetarget.lookaheadorigin, ( 1, 0.5, 0 ), 1, 1 );
        }
        else
        {
            activemult = currentmult;
            line( player.origin, chasetarget.origin, ( 0, 1, 0 ), 1, 1 );
        }
        
        maxdistance = modeinfo.var_89fa9d9a603525c3 / 3;
        mindistance = modeinfo.var_b319a11128eb6df5 / 3;
        sphere( chasetarget.origin, maxdistance, ( 0.75, 0.75, 0.75 ), 0 );
        sphere( chasetarget.origin, mindistance, ( 0.75, 0.75, 0.75 ), 0 );
        sphere( chasetarget.lookaheadorigin, 150, ( 0.5, 0, 1 ), 0 );
        multnorm = max( 0, activemult - modeinfo.var_948ea464f4432830 );
        maxnorm = modeinfo.var_a8c1467292c87baa - modeinfo.var_948ea464f4432830;
        ratio = multnorm / maxnorm;
        invratio = 1 - ratio;
        curcolor = ( 1 * ratio, 0, 1 * invratio );
        var_a83ee2bc43a8b284 = maxdistance - mindistance;
        size = mindistance + var_a83ee2bc43a8b284 * ratio;
        sphere( chasetarget.origin, size, curcolor, 0 );
        
        if ( !isdefined( chaseheader ) )
        {
            chaseheader = "<dev string:x20f>" + "<dev string:x21c>" + modeinfo.var_948ea464f4432830 + "<dev string:x227>" + activemult + "<dev string:x227>" + modeinfo.var_a8c1467292c87baa;
        }
        
        printtoscreen2d( 20, 100, chaseheader, ( 1, 1, 1 ), 2 );
    }

#/
