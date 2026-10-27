// script_7e874027fd36f44f  (hash_7e874027fd36f44f.gscc) (size: 20771 Bytes / 0x5123 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7eb7d976 (2125977974)
// size ...... 20771 (0x5123)
// includes .. 9   (offset: 0x4ddf)
// strings ... 18  (offset: 0x4e27)
// dev strs .. 39  (offset: 0x4eff)
// exports ... 41  (offset: 0x3993)
// cseg ...... 0x20c + 0x3787 (0x3993)
// imports ... 107 (offset: 0x3ffb)
// animtree1 . 0   (offset: 0x5123)
// animtree2 . 0   (offset: 0x5123)
#using script_3b5f1fa53313feda;
#using script_44280f644740bac;
#using scripts\common\callbacks;
#using scripts\common\gameplay_sound_fx;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\gametypes\frune_checkpoints;

#namespace namespace_94a725a4853ac529;

// Namespace namespace_94a725a4853ac529
// Params 0
// Checksum 0x9fef63ba, Offset: 0x22a
// Size: 0x57b
function init()
{
    level endon( #"game_ended" );
    utility::flag_wait( "scriptables_ready" );
    modeinfo = game[ #"frune_tuning" ];
    
    if ( !isdefined( modeinfo.frune_bundle ) )
    {
        modeinfo.frune_bundle = game_utility_mp::function_4b7180ed8c2e9742( "gametypebundle_frune" );
    }
    
    modeinfo.var_89fa9d9a603525c3 = getdvarint( @"hash_bee375610491fc22", modeinfo.frune_bundle.var_f354d36721431933 ?? 1500 );
    modeinfo.var_b319a11128eb6df5 = getdvarint( @"hash_4cc4c540b9fa2b68", modeinfo.frune_bundle.var_9cadfe1f8ead1629 ?? 500 );
    modeinfo.var_148c7871815c14c6 = getdvarfloat( @"hash_5ca3529d20be11cb", modeinfo.frune_bundle.var_69b4735ceff927b0 ?? 800 );
    modeinfo.var_948ea464f4432830 = getdvarfloat( @"hash_ec0876ecb45bf4ec", modeinfo.frune_bundle.var_9df5feff364cfbed ?? 0.75 );
    modeinfo.var_a8c1467292c87baa = getdvarfloat( @"hash_9e39809c2f14751a", modeinfo.frune_bundle.var_3e6df2b8b78b363 ?? 2.5 );
    modeinfo.var_8b0a98d50d7e105a = utility::function_6f5d2e1f1ff70482( getdvarfloat( @"hash_cfac5636c1558be8", modeinfo.frune_bundle.var_8b0d4680a5ca769f ?? 1800 ) );
    modeinfo.var_864033a1afbdbf6f = getdvarint( @"hash_e983671accde142", modeinfo.frune_bundle.var_686dd4be3be80469 ?? 1 );
    modeinfo.var_b2b8c5bbe9a23daa = getdvarfloat( @"hash_98de46224e5992a7", modeinfo.frune_bundle.var_6c615b98c09ca842 ?? 1900000 );
    modeinfo.var_98dd7ea6eeda83e7 = getdvarint( @"hash_b4a9dc09de6a2566", modeinfo.frune_bundle.var_9e8ac1ea3f234cc3 ?? 3 );
    modeinfo.var_6eaba596ad2c5518 = utility::function_6f5d2e1f1ff70482( getdvarint( @"hash_ad74111e24dcf3e2", modeinfo.frune_bundle.var_cb4ce8df990476d5 ?? 200 ) );
    modeinfo.var_766d535374c2081c = getdvarfloat( @"hash_21c01efe940d3b7b", modeinfo.frune_bundle.var_c869d8b69e73955a ?? 4000000 );
    modeinfo.var_34b33022d2478c4d = getdvarfloat( @"hash_4fdd62d74033accf", modeinfo.frune_bundle.var_4dc165b8f8a054c6 ?? 1e+06 );
    modeinfo.var_da7ab9f670f6660d = getdvarint( @"hash_cf94a49db0b528db", modeinfo.frune_bundle.var_d51527b28870228c ?? 1 );
    modeinfo.var_59ca663ac24b2a3 = getdvarint( @"hash_918332b842f61a02", modeinfo.frune_bundle.var_5ead49c0f91e4ce5 ?? 1 );
    assert( modeinfo.var_b2b8c5bbe9a23daa < modeinfo.var_766d535374c2081c, "<dev string:x24>" );
    assert( modeinfo.var_34b33022d2478c4d < modeinfo.var_b2b8c5bbe9a23daa, "<dev string:x6a>" );
    modeinfo.var_84d1dbcaf7d2e286 = squared( getdvarint( @"hash_22f0a6b88199acae", modeinfo.frune_bundle.var_effa240cb0e9b1a9 ?? 1300 ) );
    modeinfo.var_d3bcc8034e8ebb40 = getdvarint( @"hash_c1ce439c76f300c0", modeinfo.frune_bundle.var_c10df503cf36ac53 ?? 1500 );
    modeinfo.var_ba748a5edfda3787 = getdvarfloat( @"hash_e8c5bbd3eb2e0056", modeinfo.frune_bundle.var_a6f6ea792b4f790b ?? 1.005 );
    modeinfo.var_4952d4695940b10d = getdvarint( @"hash_13be64426a09160a", modeinfo.frune_bundle.var_17f932dac2c5a1c7 ?? 1 );
    modeinfo.var_1db3bb91f6cefaba = [];
    function_59dab1aadb23a079();
    function_8686191e164138e9();
    level callback::add( #"hash_6cd8138b7ddba849", &function_828146a9df07fb7e );
    
    /#
        helptext = "<dev string:xc5>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fre" ][ #"registercommand" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( "<dev string:xfd>", "<dev string:x115>", &function_a7af488dc6d64f59, helptext, "<dev string:x119>", undefined );
        }
        
        helptext = "<dev string:x129>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fre" ][ #"registercommand" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( "<dev string:x153>", "<dev string:x115>", &function_1eec1c7b0f47ae17, helptext, "<dev string:x119>", undefined );
        }
        
        helptext = "<dev string:x166>";
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fre" ][ #"registercommand" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            level [[ var_32dbca3143d9c4a5 ]]( "<dev string:x192>", "<dev string:x115>", &function_d253f69fcb490e45, helptext, "<dev string:x119>", undefined );
        }
    #/
}

// Namespace namespace_94a725a4853ac529
// Params 0, eflags: 0x4
// Checksum 0x667b99c8, Offset: 0x7ad
// Size: 0x858
function private function_59dab1aadb23a079()
{
    modeinfo = game[ #"frune_tuning" ];
    firsttriggers = getentarray( "first_wingsuit_ring", #script_parameters );
    
    foreach ( trigger in firsttriggers )
    {
        ringinfo = { #trigger:trigger };
        trigger.var_a66b1fa9a85ebac8 = ringinfo;
        ringlist = [ ringinfo ];
        wingsuitcourse = { #ringlist:ringlist };
        ringinfo.var_68dee5345341afdc = ringlist;
        ringinfo.var_ac8ee80b02649fcd = wingsuitcourse;
        modeinfo.var_1db3bb91f6cefaba[ modeinfo.var_1db3bb91f6cefaba.size ] = wingsuitcourse;
        trigger::makeenterexittrigger( trigger, &function_b962c55828861263, undefined, undefined, undefined, undefined, ringinfo );
    }
    
    foreach ( icourse in modeinfo.var_1db3bb91f6cefaba )
    {
        ringlist = icourse.ringlist;
        trigger = ringlist[ 0 ].trigger;
        
        while ( true )
        {
            trigger = getent( trigger.target, #targetname );
            ringinfo = { #trigger:trigger };
            trigger.var_a66b1fa9a85ebac8 = ringinfo;
            ringinfo.var_68dee5345341afdc = ringlist;
            ringinfo.var_ac8ee80b02649fcd = icourse;
            icourse.ringlist[ icourse.ringlist.size ] = ringinfo;
            trigger::makeenterexittrigger( trigger, &function_b962c55828861263, undefined, undefined, undefined, undefined, ringinfo );
            
            if ( !trigger.target )
            {
                break;
            }
        }
    }
    
    starttriggers = getentarray( "wingsuit_start_trigger", #script_noteworthy );
    
    foreach ( starttrigger in starttriggers )
    {
        trigger = getent( starttrigger.target, #targetname );
        trigger.var_a66b1fa9a85ebac8.starttrigger = starttrigger;
    }
    
    ringcenters = getentarray( "wingsuit_ring_centre", #script_noteworthy );
    
    foreach ( ringcenter in ringcenters )
    {
        trigger = getent( ringcenter.target, #targetname );
        trigger.var_a66b1fa9a85ebac8.center = ringcenter;
    }
    
    killtriggers = getentarray( "wingsuit_kill_trigger", #script_noteworthy );
    
    foreach ( killtrigger in killtriggers )
    {
        trigger = getent( killtrigger.target, #targetname );
        trigger.var_a66b1fa9a85ebac8.killtrigger = killtrigger;
        trigger::makeenterexittrigger( killtrigger, &function_2b79899bfc464e2a );
    }
    
    var_a118ed316acb55b2 = getentitylessscriptablearray( "wingsuit_ring_unlit", #script_noteworthy );
    
    foreach ( visual in var_a118ed316acb55b2 )
    {
        trigger = getent( visual.target, #targetname );
        trigger.var_a66b1fa9a85ebac8.var_6a41077566f415f5 = visual;
    }
    
    var_118a16741ba3dd67 = getentitylessscriptablearray( "wingsuit_ring_lit", #script_noteworthy );
    
    foreach ( visual in var_118a16741ba3dd67 )
    {
        trigger = getent( visual.target, #targetname );
        trigger.var_a66b1fa9a85ebac8.var_c4d97a5e33190d06 = visual;
        visual setscriptablepartstate( #"light", #"on" );
    }
    
    var_2216b8bd5fdd7cf5 = getentarray( "wingsuit_ring_attachment", #script_noteworthy );
    
    foreach ( collider in var_2216b8bd5fdd7cf5 )
    {
        trigger = getent( collider.target, #targetname );
        trigger.var_a66b1fa9a85ebac8.collider = collider;
        collider enablelinkto();
        collider linkto( trigger.var_a66b1fa9a85ebac8.center );
    }
    
    var_e076467c00e4ea4 = utility::getstructarray( "wingsuit_target_path_start", "script_noteworthy" );
    
    foreach ( startnode in var_e076467c00e4ea4 )
    {
        trigger = getent( startnode.script_parameters, #targetname );
        trigger.var_a66b1fa9a85ebac8.splinestartnode = startnode;
    }
    
    wingsuitcheckpoints = getentarray( "wingsuit_checkpoint", #script_noteworthy );
    
    foreach ( checkpointtrigger in wingsuitcheckpoints )
    {
        trigger = getent( checkpointtrigger.script_label, #targetname );
        trigger.var_a66b1fa9a85ebac8.checkpointtrigger = checkpointtrigger;
        checkpointtrigger.var_a66b1fa9a85ebac8 = trigger.var_a66b1fa9a85ebac8;
    }
}

// Namespace namespace_94a725a4853ac529
// Params 2, eflags: 0x4
// Checksum 0xa26ed7be, Offset: 0x100d
// Size: 0x43
function private function_ce774d22e539f043( player, trigger )
{
    if ( !isplayer( player ) || !isalive( player ) )
    {
        return;
    }
    
    player.freeruninfo.var_7e467608b5bb093a = trigger;
}

// Namespace namespace_94a725a4853ac529
// Params 2, eflags: 0x4
// Checksum 0xd88b71f6, Offset: 0x1058
// Size: 0x42
function private function_23d8bfb5b9bf1895( player, trigger )
{
    if ( player.freeruninfo.var_7e467608b5bb093a )
    {
        player.freeruninfo.var_7e467608b5bb093a = undefined;
    }
}

// Namespace namespace_94a725a4853ac529
// Params 2
// Checksum 0xe839a2bc, Offset: 0x10a2
// Size: 0x2d
function function_105c09e54abd16c2( player, wingsuitcourse )
{
    player.freeruninfo.var_fde64571361c08d0 = wingsuitcourse;
}

// Namespace namespace_94a725a4853ac529
// Params 1, eflags: 0x4
// Checksum 0x29f34a95, Offset: 0x10d7
// Size: 0x21
function private function_5cbdc0f45836e6c0( player )
{
    return player.freeruninfo.var_fde64571361c08d0;
}

// Namespace namespace_94a725a4853ac529
// Params 1, eflags: 0x4
// Checksum 0x12ec4f93, Offset: 0x1101
// Size: 0x21
function private function_5b4908b550f41333( player )
{
    player.freeruninfo.var_fde64571361c08d0 = undefined;
}

// Namespace namespace_94a725a4853ac529
// Params 0
// Checksum 0xe107d353, Offset: 0x112a
// Size: 0xfe
function function_ca7da31bda8e254c()
{
    self notify( #"hash_6d2e4e5bbe072608" );
    self endon( #"hash_6d2e4e5bbe072608" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    modeinfo = game[ #"frune_tuning" ];
    
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
                val::set( "frune_player_val", "skydive_force_script_collide", 1 );
                self skydive_beginfreefall();
                self skydive_deployparachute();
                wait 0.25;
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_94a725a4853ac529
// Params 0
// Checksum 0xe5bbcd4a, Offset: 0x1230
// Size: 0xdf
function function_fa8cd9286636aa86()
{
    self notify( #"hash_ca50e550c2a015f8" );
    self endon( #"hash_ca50e550c2a015f8" );
    self endon( #"death_or_disconnect" );
    
    while ( self )
    {
        if ( !isplayer( self ) || !isalive( self ) )
        {
            waitframe();
            continue;
        }
        
        if ( !self.freeruninfo.var_7e467608b5bb093a )
        {
            waitframe();
            continue;
        }
        
        var_7e467608b5bb093a = self.freeruninfo.var_7e467608b5bb093a;
        var_5012b59668143ee0 = function_4687359b506e4ad4( self, var_7e467608b5bb093a.var_ac8ee80b02649fcd.splineinfo );
        
        if ( !isplayer( self ) || !isalive( self ) )
        {
            waitframe();
            continue;
        }
        
        if ( var_5012b59668143ee0 )
        {
            function_105c09e54abd16c2( self, var_7e467608b5bb093a.var_ac8ee80b02649fcd );
        }
        else
        {
            frune_checkpoints::function_aae76b5997fc6288( self );
        }
        
        waitframe();
    }
}

// Namespace namespace_94a725a4853ac529
// Params 0
// Checksum 0xce64c964, Offset: 0x1317
// Size: 0x6f
function function_a7538c20aa2dd747()
{
    self notify( #"hash_c0b06ea5f66ef419" );
    self endon( #"hash_c0b06ea5f66ef419" );
    self endon( #"death_or_disconnect" );
    
    while ( self )
    {
        if ( !isplayer( self ) || !isalive( self ) )
        {
            break;
        }
        
        queuedcourse = function_5cbdc0f45836e6c0( self );
        
        if ( queuedcourse )
        {
            thread function_3f24337d01ea0a9( self, self.origin, queuedcourse );
        }
        
        waitframe();
    }
}

// Namespace namespace_94a725a4853ac529
// Params 0
// Checksum 0x15d32d40, Offset: 0x138e
// Size: 0x10f
function function_183ded8ab72ea1da()
{
    self notify( #"hash_a5100bd965338a4b" );
    self endon( #"hash_a5100bd965338a4b" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    waitframe();
    
    while ( self )
    {
        if ( self.freeruninfo.wingsuitequipped && self.freeruninfo.var_b29f5c9ab160dda7 )
        {
            var_66322ee3bc7a5708 = self isonground() || self isonladder() || self isonzipline() || self isonascender();
            iswingsuitdeployed = self iswingsuitdeployed();
            velocitysq = lengthsquared( self getvelocity() );
            isstuck = !isdefined( velocitysq ) || velocitysq < 100;
            
            if ( var_66322ee3bc7a5708 || !iswingsuitdeployed || isstuck || self.freeruninfo.wingsuitoutofbounds )
            {
                function_f6c7f9bb7bb8881d( self );
                frune_checkpoints::function_aae76b5997fc6288( self );
                wait 0.2;
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_94a725a4853ac529
// Params 0, eflags: 0x4
// Checksum 0xf3258f56, Offset: 0x14a5
// Size: 0x1c3
function private function_8686191e164138e9()
{
    foreach ( wingsuitcourse in game[ #"frune_tuning" ].var_1db3bb91f6cefaba )
    {
        structlist = [];
        pointlist = [];
        wingsuitcourse.pathstructs = structlist;
        wingsuitcourse.pathpoints = pointlist;
        
        for ( curnode = wingsuitcourse.ringlist[ 0 ].splinestartnode; curnode ; curnode = utility::getstruct( curnode.target, "targetname" ) )
        {
            structlist[ structlist.size ] = curnode;
            pointlist[ pointlist.size ] = curnode.origin;
            
            if ( !curnode.target )
            {
                break;
            }
        }
        
        starttrigger = wingsuitcourse.ringlist[ 0 ].starttrigger ?? spawn( "trigger_radius", pointlist[ 0 ], 0, 400, 400 );
        starttrigger.var_92dccc4bfa6c1bee = !isdefined( wingsuitcourse.ringlist[ 0 ].starttrigger );
        starttrigger.var_ac8ee80b02649fcd = wingsuitcourse;
        trigger::makeenterexittrigger( starttrigger, &function_ce774d22e539f043, &function_23d8bfb5b9bf1895 );
        wingsuitcourse.starttrigger = starttrigger;
        wingsuitcourse.splineinfo = function_70f5e2084fafa10d( wingsuitcourse.pathpoints );
    }
}

// Namespace namespace_94a725a4853ac529
// Params 1, eflags: 0x4
// Checksum 0xf81a4edf, Offset: 0x1670
// Size: 0x19e
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
    modeinfo = game[ #"frune_tuning" ];
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

// Namespace namespace_94a725a4853ac529
// Params 3, eflags: 0xc
// Checksum 0x73e7eaea, Offset: 0x1817
// Size: 0x179
function private function_3f24337d01ea0a9( player, var_39a49dc4dece1623, var_ebb1b5e1824cbabd )
{
    self notify( #"hash_f29bb6c1a4fc97b" );
    self endon( #"hash_f29bb6c1a4fc97b" );
    player endon( #"death_or_disconnect" );
    function_5b4908b550f41333( player );
    function_f6c7f9bb7bb8881d( player );
    pathpoints = var_ebb1b5e1824cbabd.pathpoints;
    var_7c170ceae0649b57 = [ #"teamselect", player getentitynumber() ];
    chasetarget = spawnscriptable( "mp_sat_freerun_wingsuit_chase_target", pathpoints[ 0 ], undefined, undefined, var_7c170ceae0649b57 );
    player.freeruninfo.var_b29f5c9ab160dda7 = chasetarget;
    player.freeruninfo.wingsuitoutofbounds = undefined;
    chasetarget setscriptablepartstate( #"base", #"active" );
    starttimeseconds = function_ca602e5df1f2d896( var_ebb1b5e1824cbabd.splineinfo.var_4fa4ecdd814e538d, var_39a49dc4dece1623 );
    
    if ( game[ #"frune_tuning" ].var_864033a1afbdbf6f )
    {
        player thread function_fd17360462312fbf( player, starttimeseconds, var_ebb1b5e1824cbabd.splineinfo );
    }
    
    chasetarget function_f9d371f2122d686b( pathpoints, player, starttimeseconds, var_ebb1b5e1824cbabd.splineinfo );
    
    if ( chasetarget )
    {
        chasetarget setscriptablepartstate( #"base", #"caught" );
    }
}

// Namespace namespace_94a725a4853ac529
// Params 1
// Checksum 0x91b5616c, Offset: 0x1998
// Size: 0x7d
function function_f6c7f9bb7bb8881d( player )
{
    if ( player.freeruninfo.var_b29f5c9ab160dda7 )
    {
        player.freeruninfo.var_b29f5c9ab160dda7 freescriptable();
        player.freeruninfo.var_b29f5c9ab160dda7 = undefined;
        player.freeruninfo.var_4beaa026e8952df = undefined;
        player.freeruninfo.wingsuitoutofbounds = undefined;
    }
}

// Namespace namespace_94a725a4853ac529
// Params 3, eflags: 0xc
// Checksum 0x32377334, Offset: 0x1a1d
// Size: 0x82
function private function_fd17360462312fbf( player, var_c6cbea51379083ef, splineinfo )
{
    self notify( #"hash_6dd7a5850e5abf97" );
    self endon( #"hash_6dd7a5850e5abf97" );
    player endon( #"death_or_disconnect" );
    player endon( #"wingsuit_course_started" );
    var_5012b59668143ee0 = function_a12cdefcd090c2f9( player, var_c6cbea51379083ef, splineinfo );
    
    if ( !var_5012b59668143ee0 )
    {
        self.freeruninfo.wingsuitoutofbounds = 1;
    }
}

// Namespace namespace_94a725a4853ac529
// Params 0, eflags: 0x4
// Checksum 0xa1d356f5, Offset: 0x1aa7
// Size: 0x2d
function private function_3fb56cf82f55bf52()
{
    return game[ #"frune_tuning" ].var_b2b8c5bbe9a23daa - game[ #"frune_tuning" ].var_34b33022d2478c4d;
}

// Namespace namespace_94a725a4853ac529
// Params 2, eflags: 0x4
// Checksum 0xb0551586, Offset: 0x1add
// Size: 0x1c1, Type: bool
function private function_4687359b506e4ad4( player, splineinfo )
{
    modeinfo = game[ #"frune_tuning" ];
    var_310eb32985bd2183 = modeinfo.var_766d535374c2081c;
    startpoint = splineinfo.var_4fa4ecdd814e538d[ 0 ];
    startdistsq = distancesquared( player.origin, startpoint );
    
    if ( startdistsq > var_310eb32985bd2183 )
    {
        /#
            warning = "<dev string:x1a6>";
            warning += "<dev string:x1df>";
            warning += "<dev string:x237>" + player.origin;
            warning += "<dev string:x244>" + ( player.freeruninfo.activespawnpoint.origin ?? "<dev string:x250>" );
            warning += "<dev string:x255>" + ( player.freeruninfo.zoneindex ?? 0 ) + "<dev string:x26b>" + ( player.freeruninfo.checkpointindex ?? 0 );
            assertmsg( warning );
        #/
        
        wait 0.25;
    }
    
    /#
        player.freeruninfo.var_b21b9e929d2232a9 = startpoint;
    #/
    
    var_87686b3f3ffddda8 = modeinfo.var_6eaba596ad2c5518;
    curdistsq = startdistsq;
    var_513e68c28c7f7ba8 = function_3fb56cf82f55bf52();
    
    while ( true )
    {
        curdistsq = distancesquared( player.origin, startpoint );
        
        if ( curdistsq > var_310eb32985bd2183 )
        {
            return false;
        }
        
        if ( player && player iswingsuitdeployed() && curdistsq < var_513e68c28c7f7ba8 )
        {
            break;
        }
        
        wait var_87686b3f3ffddda8;
    }
    
    return true;
}

// Namespace namespace_94a725a4853ac529
// Params 3, eflags: 0x4
// Checksum 0xfdabdf82, Offset: 0x1ca7
// Size: 0x28f, Type: bool
function private function_a12cdefcd090c2f9( player, var_c6cbea51379083ef, splineinfo )
{
    modeinfo = game[ #"frune_tuning" ];
    var_5d95b3efc97d4832 = var_c6cbea51379083ef;
    lookaheadseconds = modeinfo.var_98dd7ea6eeda83e7;
    var_310eb32985bd2183 = modeinfo.var_b2b8c5bbe9a23daa;
    startpoint = splineinfo.var_4fa4ecdd814e538d[ var_5d95b3efc97d4832 ];
    startdistsq = distancesquared( player.origin, startpoint );
    
    if ( startdistsq > var_310eb32985bd2183 )
    {
        /#
            warning = "<dev string:x26d>";
            warning += "<dev string:x29e>";
            warning += "<dev string:x237>" + player.origin;
            warning += "<dev string:x244>" + ( player.freeruninfo.activespawnpoint.origin ?? "<dev string:x250>" );
            warning += "<dev string:x255>" + ( player.freeruninfo.zoneindex ?? 0 ) + "<dev string:x26b>" + ( player.freeruninfo.checkpointindex ?? 0 );
            assertmsg( warning );
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
            return false;
        }
        
        wait var_87686b3f3ffddda8;
    }
    
    return true;
}

// Namespace namespace_94a725a4853ac529
// Params 2, eflags: 0x4
// Checksum 0x833305d6, Offset: 0x1f3f
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

// Namespace namespace_94a725a4853ac529
// Params 4, eflags: 0xc
// Checksum 0xc6276d21, Offset: 0x200a
// Size: 0x1ce
function private function_f9d371f2122d686b( pathpoints, player, starttimeseconds, splineinfo )
{
    self notify( #"hash_ba66c3cb5c4415c9" );
    self endon( #"hash_ba66c3cb5c4415c9" );
    self endon( #"death" );
    self endon( #"stop_curve" );
    var_9c10d6932006d854 = level.framedurationseconds;
    modeinfo = game[ #"frune_tuning" ];
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

// Namespace namespace_94a725a4853ac529
// Params 6, eflags: 0x4
// Checksum 0x41608c61, Offset: 0x21e0
// Size: 0xcd
function private function_6fccf8548f429182( player, splinepoint, var_76227f9e199c8e21, var_68a1ef5dd3ab1323, maxdistance, mindistance )
{
    if ( !isplayer( player ) || !isalive( player ) )
    {
        assertmsg( "<dev string:x2d9>" );
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

// Namespace namespace_94a725a4853ac529
// Params 1, eflags: 0x4
// Checksum 0x26c8f34b, Offset: 0x22b6
// Size: 0xeb
function private function_828146a9df07fb7e( params )
{
    player = self;
    
    if ( !isplayer( player ) || !isalive( player ) )
    {
        return;
    }
    
    player function_1ca79e09e9f633d2();
    
    foreach ( wingsuitcourse in game[ #"frune_tuning" ].var_1db3bb91f6cefaba )
    {
        firstring = wingsuitcourse.ringlist[ 0 ];
        player function_a144ec87d3acc2ad( firstring );
    }
    
    player.freeruninfo.ringsenabled = 1;
}

// Namespace namespace_94a725a4853ac529
// Params 1, eflags: 0x4
// Checksum 0xf0257c9c, Offset: 0x23a9
// Size: 0xa6
function private function_4c2326b4ed730a71( ringinfo )
{
    ringlist = ringinfo.var_68dee5345341afdc;
    
    foreach ( i, iringinfo in ringlist )
    {
        if ( ringinfo == iringinfo && ringlist.size > i + 1 )
        {
            return ringlist[ i + 1 ];
        }
    }
}

// Namespace namespace_94a725a4853ac529
// Params 3, eflags: 0x4
// Checksum 0x3d5d932e, Offset: 0x2458
// Size: 0xff
function private function_b962c55828861263( player, trigger, ringinfo )
{
    if ( !isplayer( player ) || !isalive( player ) )
    {
        return;
    }
    
    if ( !self.freeruninfo.wingsuitequipped || !self.freeruninfo.var_b29f5c9ab160dda7 )
    {
        return;
    }
    
    player.freeruninfo.var_4beaa026e8952df = ringinfo.killtrigger;
    player.freeruninfo.wingsuittrigger = ringinfo.checkpointtrigger;
    player thread function_6fc8e1e2b62e5e69( player );
    player function_71f44724c5564e7e( ringinfo );
    var_dfbe331c7b1f42f9 = function_4c2326b4ed730a71( ringinfo );
    
    if ( var_dfbe331c7b1f42f9 )
    {
        player function_a144ec87d3acc2ad( var_dfbe331c7b1f42f9 );
    }
    
    player gameplay_sound_fx::playlocalsoundfx( #"winguit_ring" );
    pbgpostfxbundlestart( player, %"sat_mp_freerun_ws_ring" );
}

// Namespace namespace_94a725a4853ac529
// Params 2, eflags: 0x4
// Checksum 0xbca2d186, Offset: 0x255f
// Size: 0x11f
function private function_2b79899bfc464e2a( player, trigger )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    player endon( #"wingsuit_course_started" );
    
    if ( !self.freeruninfo.wingsuitequipped || !self.freeruninfo.var_b29f5c9ab160dda7 )
    {
        return;
    }
    
    modeinfo = game[ #"frune_tuning" ];
    
    if ( !modeinfo.var_da7ab9f670f6660d )
    {
        return;
    }
    
    wait 0.2;
    
    if ( trigger == player.freeruninfo.var_4beaa026e8952df )
    {
        if ( player.freeruninfo.wingsuittrigger.script_parameters == "wingsuit_course_end" )
        {
            if ( modeinfo.var_59ca663ac24b2a3 )
            {
                namespace_c41f357b2d127aee::function_b90bc384cbf8537a( player, modeinfo.emptyloadout );
            }
            
            function_f6c7f9bb7bb8881d( player );
        }
        
        return;
    }
    
    player.freeruninfo.wingsuitoutofbounds = 1;
}

// Namespace namespace_94a725a4853ac529
// Params 1, eflags: 0xc
// Checksum 0x45e7dbd8, Offset: 0x2686
// Size: 0xca
function private function_6fc8e1e2b62e5e69( player )
{
    self notify( #"hash_3b36a4df0c46b9de" );
    self endon( #"hash_3b36a4df0c46b9de" );
    modeinfo = game[ #"frune_tuning" ];
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

// Namespace namespace_94a725a4853ac529
// Params 2
// Checksum 0x46504dad, Offset: 0x2758
// Size: 0x42
function function_2e7b310429c9cfe5( player, checkpoint )
{
    if ( !checkpoint.var_a66b1fa9a85ebac8 )
    {
        return;
    }
    
    player function_1ca79e09e9f633d2();
    player function_a144ec87d3acc2ad( checkpoint.var_a66b1fa9a85ebac8 );
}

// Namespace namespace_94a725a4853ac529
// Params 1, eflags: 0x4
// Checksum 0x9ebec82, Offset: 0x27a2
// Size: 0x6e
function private function_a144ec87d3acc2ad( ringinfo )
{
    if ( !ringinfo.var_6a41077566f415f5 )
    {
        assertmsg( "<dev string:x2e6>" + ringinfo );
        return;
    }
    
    if ( !ringinfo.var_c4d97a5e33190d06 )
    {
        assertmsg( "<dev string:x30d>" + ringinfo );
        return;
    }
    
    ringinfo.var_c4d97a5e33190d06 function_6113853a877d5460( self );
    ringinfo.var_6a41077566f415f5 function_d6a7b7ef13a57f38( self );
}

// Namespace namespace_94a725a4853ac529
// Params 1, eflags: 0x4
// Checksum 0x9d1832ad, Offset: 0x2818
// Size: 0x6e
function private function_71f44724c5564e7e( ringinfo )
{
    if ( !ringinfo.var_6a41077566f415f5 )
    {
        assertmsg( "<dev string:x2e6>" + ringinfo );
        return;
    }
    
    if ( !ringinfo.var_c4d97a5e33190d06 )
    {
        assertmsg( "<dev string:x30d>" + ringinfo );
        return;
    }
    
    ringinfo.var_6a41077566f415f5 function_6113853a877d5460( self );
    ringinfo.var_c4d97a5e33190d06 function_d6a7b7ef13a57f38( self );
}

// Namespace namespace_94a725a4853ac529
// Params 0, eflags: 0x4
// Checksum 0x8307a506, Offset: 0x288e
// Size: 0x154
function private function_1ca79e09e9f633d2()
{
    foreach ( wingsuitcourse in game[ #"frune_tuning" ].var_1db3bb91f6cefaba )
    {
        foreach ( ringinfo in wingsuitcourse.ringlist )
        {
            if ( !ringinfo.var_6a41077566f415f5 )
            {
                assertmsg( "<dev string:x2e6>" + ringinfo );
                continue;
            }
            
            if ( !ringinfo.var_c4d97a5e33190d06 )
            {
                assertmsg( "<dev string:x30d>" + ringinfo );
                continue;
            }
            
            ringinfo.var_6a41077566f415f5 function_6113853a877d5460( self );
            ringinfo.var_c4d97a5e33190d06 function_d6a7b7ef13a57f38( self );
        }
    }
}

/#

    // Namespace namespace_94a725a4853ac529
    // Params 2, eflags: 0x4
    // Checksum 0x479e51c2, Offset: 0x29ea
    // Size: 0x5a, Type: dev
    function private function_a7af488dc6d64f59( host, args )
    {
        var_e192ef1147f518ac = namespace_ec33f26de741e14e::function_7fb3afaa98ee9eeb( "<dev string:x115>" );
        var_e192ef1147f518ac.var_ded7be848ee3759a = !var_e192ef1147f518ac.var_ded7be848ee3759a;
        level thread function_f35ed16b4482eb79( var_e192ef1147f518ac.var_ded7be848ee3759a );
    }

    // Namespace namespace_94a725a4853ac529
    // Params 1, eflags: 0xc
    // Checksum 0x560c8646, Offset: 0x2a4c
    // Size: 0x1ae, Type: dev
    function private function_f35ed16b4482eb79( enabled )
    {
        self notify( #"hash_28f180b64bb308b4" );
        self endon( #"hash_28f180b64bb308b4" );
        
        if ( !enabled )
        {
            return;
        }
        
        modeinfo = game[ #"frune_tuning" ];
        
        while ( true )
        {
            player = level.players[ 0 ];
            
            if ( !player )
            {
                waitframe();
                continue;
            }
            
            foreach ( var_ebb1b5e1824cbabd in modeinfo.var_1db3bb91f6cefaba )
            {
                foreach ( index, ringinfo in var_ebb1b5e1824cbabd.ringlist )
                {
                    var_dfbe331c7b1f42f9 = var_ebb1b5e1824cbabd.ringlist[ index + 1 ];
                    distancesq = distancesquared( player.origin, ringinfo.center.origin );
                    
                    if ( distancesq < 20000000 )
                    {
                        function_b3827d85be74a984( player, index, ringinfo, var_dfbe331c7b1f42f9 );
                    }
                }
            }
            
            waitframe();
        }
    }

    // Namespace namespace_94a725a4853ac529
    // Params 4, eflags: 0x4
    // Checksum 0x34fb3af7, Offset: 0x2c02
    // Size: 0x23f, Type: dev
    function private function_b3827d85be74a984( host, index, var_35611af0300ee14a, var_466eedc44d8ceabb )
    {
        origin = var_35611af0300ee14a.center.origin;
        
        if ( !var_35611af0300ee14a.var_6a41077566f415f5 )
        {
            assertmsg( "<dev string:x338>" );
        }
        
        var_e73c15952d4b75e6 = var_35611af0300ee14a.var_6a41077566f415f5 function_50b79f4d4032e234( host );
        var_bad8466f000a6e55 = var_35611af0300ee14a.var_c4d97a5e33190d06 function_50b79f4d4032e234( host );
        
        if ( var_bad8466f000a6e55 && var_e73c15952d4b75e6 )
        {
            var_5c5034c52bf01dcb = "<dev string:x345>";
            triggercolor = ( 1, 0, 0 );
        }
        else if ( var_bad8466f000a6e55 )
        {
            var_5c5034c52bf01dcb = "<dev string:x34f>";
            triggercolor = ( 0, 1, 0 );
        }
        else if ( var_e73c15952d4b75e6 )
        {
            var_5c5034c52bf01dcb = "<dev string:x358>";
            triggercolor = ( 0, 0, 1 );
        }
        else
        {
            var_5c5034c52bf01dcb = "<dev string:x363>";
            triggercolor = ( 0.75, 0.75, 0.75 );
        }
        
        if ( var_466eedc44d8ceabb )
        {
            line( origin, var_466eedc44d8ceabb.center.origin, ( 1, 0.75, 0.75 ), 1, 0 );
        }
        
        var_35611af0300ee14a.labelinfo = "<dev string:x36d>" + index + "<dev string:x37c>" + var_5c5034c52bf01dcb;
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

    // Namespace namespace_94a725a4853ac529
    // Params 2, eflags: 0x4
    // Checksum 0xe6c566df, Offset: 0x2e49
    // Size: 0x3a, Type: dev
    function private function_1eec1c7b0f47ae17( host, args )
    {
        assertmsg( "<dev string:x388>" );
        host function_3f24337d01ea0a9( host, host.origin );
    }

    // Namespace namespace_94a725a4853ac529
    // Params 2, eflags: 0x4
    // Checksum 0x40cbad40, Offset: 0x2e8b
    // Size: 0x5c, Type: dev
    function private function_d253f69fcb490e45( host, args )
    {
        var_e192ef1147f518ac = namespace_ec33f26de741e14e::function_7fb3afaa98ee9eeb( "<dev string:x115>" );
        var_e192ef1147f518ac.var_37d5ae223e5dfc26 = !var_e192ef1147f518ac.var_37d5ae223e5dfc26;
        level thread function_364f53de3a7c54e5( var_e192ef1147f518ac.var_37d5ae223e5dfc26, host );
    }

    // Namespace namespace_94a725a4853ac529
    // Params 2, eflags: 0xc
    // Checksum 0x28fe8786, Offset: 0x2eef
    // Size: 0x50, Type: dev
    function private function_364f53de3a7c54e5( enabled, player )
    {
        self notify( #"hash_a2c78412ed35e4a9" );
        self endon( #"hash_a2c78412ed35e4a9" );
        
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

    // Namespace namespace_94a725a4853ac529
    // Params 1, eflags: 0x4
    // Checksum 0x1a2664eb, Offset: 0x2f47
    // Size: 0x712, Type: dev
    function private function_6664ee99684fe22d( player )
    {
        modeinfo = game[ #"frune_tuning" ];
        
        foreach ( wingsuitcourse in modeinfo.var_1db3bb91f6cefaba )
        {
            foreach ( pathpoint in wingsuitcourse.splineinfo.pathpoints )
            {
                sphere( pathpoint, 10, ( 0.5, 0, 1 ), 1 );
            }
        }
        
        foreach ( wingsuitcourse in modeinfo.var_1db3bb91f6cefaba )
        {
            foreach ( pathpoint in wingsuitcourse.splineinfo.var_4fa4ecdd814e538d )
            {
                sphere( pathpoint, 10, ( 1, 1, 0 ), 1 );
            }
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
            
            foreach ( wingsuitcourse in modeinfo.var_1db3bb91f6cefaba )
            {
                player childthread utility::function_9f777c9a7fffb9fc( wingsuitcourse.splineinfo.splineid, 999, "<dev string:x3b2>" );
            }
        }
        
        foreach ( wingsuitcourse in modeinfo.var_1db3bb91f6cefaba )
        {
            function_35c7f8f99e5398f4( wingsuitcourse, player );
            
            foreach ( ringinfo in wingsuitcourse.ringlist )
            {
                function_b5da8da33f4d34aa( ringinfo );
            }
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
            chaseheader = "<dev string:x3bd>" + "<dev string:x3ca>" + modeinfo.var_948ea464f4432830 + "<dev string:x3d5>" + activemult + "<dev string:x3d5>" + modeinfo.var_a8c1467292c87baa;
        }
        
        printtoscreen2d( 20, 100, chaseheader, ( 1, 1, 1 ), 2 );
    }

    // Namespace namespace_94a725a4853ac529
    // Params 2, eflags: 0x4
    // Checksum 0x1f5304c, Offset: 0x3661
    // Size: 0x28e, Type: dev
    function private function_35c7f8f99e5398f4( wingsuitcourse, player )
    {
        starttrigger = wingsuitcourse.starttrigger;
        
        if ( !starttrigger )
        {
            return;
        }
        
        modeinfo = game[ #"frune_tuning" ];
        var_e5c872c04bc2f32e = wingsuitcourse.splineinfo.var_4fa4ecdd814e538d[ 0 ];
        var_758c630782daee01 = 4 * modeinfo.var_766d535374c2081c;
        
        if ( distancesquared( player.origin, var_e5c872c04bc2f32e ) > var_758c630782daee01 )
        {
            return;
        }
        
        drawtrigger( starttrigger, ( 0, 1, 1 ), 1 );
        sphere( var_e5c872c04bc2f32e, sqrt( modeinfo.var_766d535374c2081c ), ( 1, 0, 0 ), 0 );
        sphere( var_e5c872c04bc2f32e, sqrt( function_3fb56cf82f55bf52() ), ( 1, 0.5, 0 ), 0 );
        sphere( var_e5c872c04bc2f32e, sqrt( modeinfo.var_b2b8c5bbe9a23daa ), ( 0, 1, 0 ), 0 );
        
        if ( !isdefined( wingsuitcourse.var_ba3f3b9b82101707 ) )
        {
            wingsuitcourse.var_ba3f3b9b82101707 = "<dev string:x3d9>" + ( starttrigger.target ?? "<dev string:x250>" );
        }
        
        if ( !isdefined( wingsuitcourse.var_2d957041047e9f07 ) )
        {
            wingsuitcourse.var_2d957041047e9f07 = "<dev string:x3eb>" + ( starttrigger.var_92dccc4bfa6c1bee ? "<dev string:x402>" : "<dev string:x407>" );
        }
        
        wingsuitcourse.var_f9c9028a9b3bec10 = "<dev string:x40d>" + ( isdefined( player.freeruninfo.var_7e467608b5bb093a ) ? "<dev string:x402>" : "<dev string:x407>" );
        print3d( starttrigger.origin + ( 0, 0, 60 ), wingsuitcourse.var_ba3f3b9b82101707, ( 1, 1, 1 ), 1, 1, 1, 1 );
        print3d( starttrigger.origin + ( 0, 0, 40 ), wingsuitcourse.var_2d957041047e9f07, ( 1, 1, 1 ), 1, 1, 1, 1 );
        print3d( starttrigger.origin + ( 0, 0, 20 ), wingsuitcourse.var_f9c9028a9b3bec10, ( 1, 1, 1 ), 1, 1, 1, 1 );
    }

    // Namespace namespace_94a725a4853ac529
    // Params 1, eflags: 0x4
    // Checksum 0xaccfb728, Offset: 0x38f7
    // Size: 0x9c, Type: dev
    function private function_b5da8da33f4d34aa( ringinfo )
    {
        center = ringinfo.center;
        
        if ( !center )
        {
            return;
        }
        
        if ( !isdefined( ringinfo.var_376a22a244b1df73 ) )
        {
            ringinfo.var_376a22a244b1df73 = "<dev string:x3d9>" + center.target;
        }
        
        print3d( center.origin + ( 0, 0, 20 ), ringinfo.var_376a22a244b1df73, ( 1, 1, 1 ), 1, 1, 1, 1 );
    }

#/
