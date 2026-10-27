// scripts\mp\gametypes\skirmish_respawn.gsc  (hash_70f06e0b75ac5dbd.gscc) (size: 17818 Bytes / 0x459a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x78bcb15a (2025632090)
// size ...... 17818 (0x459a)
// includes .. 23  (offset: 0x41f6)
// strings ... 44  (offset: 0x42ae)
// dev strs .. 7   (offset: 0x4542)
// exports ... 48  (offset: 0x280e)
// cseg ...... 0x444 + 0x23ca (0x280e)
// imports ... 152 (offset: 0x2f8e)
// animtree1 . 0   (offset: 0x459a)
// animtree2 . 0   (offset: 0x459a)
#using script_2f94849b5aff8f5a;
#using scripts\common\omnvar_utility;
#using scripts\common\scripted_widgets;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\supers\active_camo;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\flags;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\skirmish_bounty;
#using scripts\mp\gametypes\skirmish_util;
#using scripts\mp\gametypes\skydive_protection;
#using scripts\mp\hud_message;
#using scripts\mp\outofbounds;
#using scripts\mp\playerlogic;
#using scripts\mp\spawnlogic;
#using scripts\mp\spawnscoring;
#using scripts\mp\spectating;

#namespace skirmish_respawn;

// Namespace skirmish_respawn
// Params 0
// Checksum 0xed6b7243, Offset: 0x462
// Size: 0x1d2
function init()
{
    level.getspawnpoint = &function_8a7cc5aba1e10a7d;
    level.modeonspawnplayer = &onspawnplayer;
    level.var_7472a836e89dda97 = &startspectatorview;
    level.var_1f8d75014734e1f3 = getdvarint( @"hash_e45eeed7441d515f", level.gametypebundle.var_d5f0733587908282 );
    level.var_1fb08b01475b5a0d = getdvarint( @"hash_e43bfcd743f72871", level.gametypebundle.var_d5cd5d35876a0a68 );
    level.var_486aa3a34354e8f = getdvarint( @"hash_3181682a5c765d57", level.gametypebundle.var_80daabb560d49aa4 );
    level.var_9fe94c55c08cdd78 = getdvarint( @"hash_3e527b981189ab06", level.gametypebundle.var_5bb8ff61290601 );
    level.var_a00c6255c0b35592 = getdvarint( @"hash_3e758d9811b01a54", level.gametypebundle.var_7eaaff614f2eef );
    level.var_81edc4abbc0a52e0 = getdvarint( @"hash_709150b411acaf5e", level.gametypebundle.var_838ec4845e22e48 );
    level.var_894129499015bc36 = getdvarint( @"hash_c00d46f66c25fa34", level.gametypebundle.var_dffc7143d62924ce );
    level.var_89641b49903be524 = getdvarint( @"hash_c03034f66c4c1a56", level.gametypebundle.var_dfd86343d6008b4c );
    level.var_f3f28a19db93fdde = getdvarint( @"hash_c6b1cfc599aafa14", level.gametypebundle.autodeployparachute ) == 1;
    level.var_439b0dbbc27bb39d = getdvarint( @"hash_28c97587d04a7c14", 0 );
    level.respawndata = [];
    level.var_f4fb60d64c3a5cbd = [];
    function_ef4216df46823efc();
}

// Namespace skirmish_respawn
// Params 0, eflags: 0x4
// Checksum 0x39587926, Offset: 0x63c
// Size: 0x220
function private function_ef4216df46823efc()
{
    foreach ( team in level.teamnamelist )
    {
        var_b8af9b8244d1d724 = "skirmish_" + team + "_origin";
        respawnstruct = utility::getstruct( var_b8af9b8244d1d724 );
        
        if ( respawnstruct )
        {
            level.respawndata[ team ] = { #angles:respawnstruct.angles, #origin:respawnstruct.origin };
        }
        else
        {
            level.respawndata[ team ] = { #angles:( 0, 0, 0 ), #origin:level.mapcenter ?? ( 0, 0, 0 ) };
            
            /#
                iprintln( "<dev string:x24>" + level.script + "<dev string:x2a>" + var_b8af9b8244d1d724 + "<dev string:x48>" );
            #/
        }
        
        var_970558156f0e9d1b = "skirmish_" + team + "_air_spawn_origin";
        airspawnstruct = utility::getstruct( var_970558156f0e9d1b );
        
        if ( airspawnstruct )
        {
            level.var_f4fb60d64c3a5cbd[ team ] = { #angles:airspawnstruct.angles, #origin:airspawnstruct.origin };
            continue;
        }
        
        level.var_f4fb60d64c3a5cbd[ team ] = { #angles:level.respawndata[ team ].angles, #origin:level.respawndata[ team ].origin };
        
        /#
            iprintln( "<dev string:x24>" + level.script + "<dev string:x68>" + var_970558156f0e9d1b + "<dev string:x88>" );
        #/
    }
}

// Namespace skirmish_respawn
// Params 0, eflags: 0x4
// Checksum 0x8836cbc0, Offset: 0x864
// Size: 0xab
function private function_7c558fe264306b77()
{
    var_c3aea722d7eca1aa = spawnstruct();
    var_c3aea722d7eca1aa.ent = self;
    var_c3aea722d7eca1aa.anchor_type = "scripted_widget_anchor_overhead_respawn";
    var_22f416031269ba87 = scripted_widgets::function_652736891a41e948( "scripted_widget_generic_icon_skirmish" );
    scripted_widgets::create( "respawn_target", var_22f416031269ba87, var_c3aea722d7eca1aa );
    scripted_widgets::set_param( "respawn_target", "respawn_icon" );
    scripted_widgets::set_state( "respawn_target", "Hide" );
    var_937391f2561e1bbb = scripted_widgets::function_652736891a41e948( "scripted_widget_skirmish_respawn_container" );
    scripted_widgets::create( "skirmish_respawn_container", var_937391f2561e1bbb );
    scripted_widgets::set_position( "skirmish_respawn_container", 0, 0, 3, 3 );
}

// Namespace skirmish_respawn
// Params 1
// Checksum 0x2f8eb40c, Offset: 0x917
// Size: 0x99
function startspectatorview( timeuntilspawn )
{
    self endon( #"spawned" );
    self endon( #"spawned_player" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( game_utility_mp::isteamreviveenabled() || isbot( self ) )
    {
        return;
    }
    
    waitframe();
    function_82cc609cba929b91();
    self playsoundtoplayer( "uin_t10_skirmish_redeploy_cam", self );
    namespace_a0bf8ee672af8086::function_b6c6158306afa9d8();
    function_d81963d5cca42b90( timeuntilspawn );
    var_bd8dc718e0231b1e = 3;
    
    if ( timeuntilspawn > var_bd8dc718e0231b1e )
    {
        wait timeuntilspawn - var_bd8dc718e0231b1e;
        self playsoundtoplayer( "uin_t10_skirmish_redeploy_timer", self );
    }
}

// Namespace skirmish_respawn
// Params 0, eflags: 0x4
// Checksum 0xf164fcdc, Offset: 0x9b8
// Size: 0x2c
function private function_82cc609cba929b91()
{
    player::updatesessionstate( "spectator" );
    spectating::setdisabled();
    self lerpfovscalefactor( 0, 0 );
    player::setdof_default();
}

// Namespace skirmish_respawn
// Params 1, eflags: 0x4
// Checksum 0x1e035e44, Offset: 0x9ec
// Size: 0xf0
function private function_d81963d5cca42b90( timeuntilspawn )
{
    respawndata = level.respawndata[ self.team ];
    camorigin = self.lastdeathpos ?? self.origin;
    cameraent = spawn( "script_model", camorigin );
    cameraent setmodel( "tag_origin" );
    cameraent.angles = respawndata.angles + ( 20, 0, 0 );
    self.isusingtacopsmapcamera = 1;
    
    if ( self isvehicleactive() )
    {
        waitframe();
    }
    
    self cameralinkto( cameraent, "tag_origin", 1 );
    self.spectatorcament = cameraent;
    thread function_bedf3195448179f7( 0.375 );
    thread function_9a0a3257c03f9a();
    cameraent function_2b356b460e1ad03c( respawndata.origin, respawndata.angles );
}

// Namespace skirmish_respawn
// Params 0, eflags: 0x4
// Checksum 0x45b0eacf, Offset: 0xae4
// Size: 0x188
function private function_2713b098d31ebfe2()
{
    if ( !utility::issharedfuncdefined( #"game", #"getsquadmates" ) )
    {
        return;
    }
    
    teammates = [[ utility::getsharedfunc( #"game", #"getsquadmates" ) ]]( self.team, self.sessionsquadid, 0 );
    
    foreach ( teammate in teammates )
    {
        outlinetype = "outlinefill_skirmish_squadmate";
        var_6ee766312a661d6c = self getpartyid();
        var_2ffaef728c23f302 = teammate getpartyid();
        
        if ( var_6ee766312a661d6c != "0" && var_6ee766312a661d6c == var_2ffaef728c23f302 )
        {
            outlinetype = "outlinefill_skirmish_party";
        }
        
        outlineid = outline::outlineenableforplayer( teammate, self, outlinetype, "level_script", 1, 1 );
        
        if ( !isdefined( self.playeroutlineids ) )
        {
            self.playeroutlineids = [];
        }
        
        self.playeroutlineids[ self.playeroutlineids.size ] = outlineid;
        
        if ( !isdefined( teammate.squadoutlineids ) )
        {
            teammate.squadoutlineids = [];
        }
        
        teammate.squadoutlineids[ teammate.squadoutlineids.size ] = outlineid;
    }
}

// Namespace skirmish_respawn
// Params 0, eflags: 0x4
// Checksum 0xa8d10d7b, Offset: 0xc74
// Size: 0x190
function private function_f469f16453db68ca()
{
    if ( !utility::issharedfuncdefined( #"game", #"getsquadmates" ) )
    {
        return;
    }
    
    squadmates = [[ utility::getsharedfunc( #"game", #"getsquadmates" ) ]]( self.team, self.sessionsquadid, 0 );
    
    foreach ( outlineid in self.playeroutlineids )
    {
        foreach ( squadmate in squadmates )
        {
            if ( isdefined( squadmate.squadoutlineids ) && arraycontains( squadmate.squadoutlineids, outlineid ) )
            {
                outline::outlinedisable( outlineid, squadmate );
                squadmate.squadoutlineids = arrayremove( squadmate.squadoutlineids, outlineid );
                self.playeroutlineids = arrayremove( self.playeroutlineids, outlineid );
            }
        }
    }
}

// Namespace skirmish_respawn
// Params 0, eflags: 0x4
// Checksum 0xb8bfb5d0, Offset: 0xe0c
// Size: 0x7f
function private function_9a0a3257c03f9a()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self.var_ed93f1fad8f6974f = 1;
    self setclientomnvar( "ui_skr_inskirmishcam", self.var_ed93f1fad8f6974f );
    
    if ( level.var_439b0dbbc27bb39d )
    {
        thread function_c8df5883dda38e86();
        function_7c558fe264306b77();
    }
    
    thread function_833fd8b520b9171c();
    wait 1.5;
    
    if ( getdvarint( @"hash_2ef96d1a474883b3", 0 ) )
    {
        thread function_3f703c176c1b8312();
    }
    
    function_2713b098d31ebfe2();
}

// Namespace skirmish_respawn
// Params 0, eflags: 0x4
// Checksum 0x9337e713, Offset: 0xe93
// Size: 0x3d
function private function_c8df5883dda38e86()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( self.var_ed93f1fad8f6974f )
    {
        function_2a1af72c62c04b7d();
        function_399565abc6675284();
        wait 0.2;
    }
}

// Namespace skirmish_respawn
// Params 0, eflags: 0x4
// Checksum 0x112ccf88, Offset: 0xed8
// Size: 0x6f
function private function_2a1af72c62c04b7d()
{
    maxindex = getdvarvalue( @"skirmish_ground_spawn", 0 ) ? 2 : 1;
    
    for ( index = 0; index < maxindex ; index++ )
    {
        respawnplayerdata = "ui_skr_respawn_player_data_" + index + 1;
        omnvar_utility::function_85d5f88af471ac4b( respawnplayerdata, 0, 6, 0 );
        omnvar_utility::function_85d5f88af471ac4b( respawnplayerdata, 6, 2, 1 );
    }
}

// Namespace skirmish_respawn
// Params 0, eflags: 0x4
// Checksum 0x2fa148e6, Offset: 0xf4f
// Size: 0x150
function private function_399565abc6675284()
{
    if ( !utility::issharedfuncdefined( #"game", #"getsquadmates" ) )
    {
        return;
    }
    
    squadmates = [[ utility::getsharedfunc( #"game", #"getsquadmates" ) ]]( self.team, self.sessionsquadid, 0 );
    squadsize = squadmates.size > level.squadsize ? level.squadsize : squadmates.size;
    omnvarindex = getdvarvalue( @"skirmish_ground_spawn", 0 ) ? 3 : 2;
    
    for ( index = 0; index < squadsize ; index++ )
    {
        squadmate = squadmates[ index ];
        
        if ( squadmate == self )
        {
            continue;
        }
        
        respawnplayerdata = "ui_skr_respawn_player_data_" + omnvarindex;
        
        if ( !self function_5c766d1d0140b86( respawnplayerdata ) )
        {
            /#
                iprintln( "<dev string:xaa>" + respawnplayerdata + "<dev string:xb4>" );
            #/
            
            break;
        }
        
        if ( squadmate )
        {
            clientnum = squadmate getentitynumber();
            status = function_8e79a8b2a0b97a0e( squadmate );
            omnvar_utility::function_85d5f88af471ac4b( respawnplayerdata, 0, 6, clientnum );
            omnvar_utility::function_85d5f88af471ac4b( respawnplayerdata, 6, 2, status );
        }
        
        omnvarindex++;
    }
}

// Namespace skirmish_respawn
// Params 1, eflags: 0x4
// Checksum 0x3adc7177, Offset: 0x10a7
// Size: 0x39
function private function_8e79a8b2a0b97a0e( squadmate )
{
    if ( !player::isreallyalive( squadmate ) )
    {
        return 2;
    }
    
    if ( squadmate player::isincombat() )
    {
        return 3;
    }
    
    if ( !function_523a0607084a0a04( squadmate ) )
    {
        return 0;
    }
    
    return 1;
}

// Namespace skirmish_respawn
// Params 1, eflags: 0x4
// Checksum 0xf2602f09, Offset: 0x10e9
// Size: 0x54
function private function_bedf3195448179f7( var_b13996c235d40368 )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    fadetime = 0.1;
    game_utility::fadetoblackforplayer( self, 1, fadetime );
    
    if ( var_b13996c235d40368 )
    {
        wait var_b13996c235d40368;
    }
    
    game_utility::fadetoblackforplayer( self, 0, fadetime );
}

// Namespace skirmish_respawn
// Params 2, eflags: 0x4
// Checksum 0xf0fec758, Offset: 0x1145
// Size: 0x182
function private function_2b356b460e1ad03c( targetpos, targetangles )
{
    arc_height_max = 3200;
    var_7c60add025e0a2de = 0.5;
    var_225b1d27a5b9dc41 = 0.3;
    startpos = self.origin;
    startangles = self.angles;
    dist = distance( startpos, targetpos );
    heightoffset = min( arc_height_max, dist * var_7c60add025e0a2de );
    var_96e81673dd3580eb = startpos + ( targetpos - startpos ) * var_225b1d27a5b9dc41;
    var_96e81673dd3580eb = ( var_96e81673dd3580eb[ 0 ], var_96e81673dd3580eb[ 1 ], var_96e81673dd3580eb[ 2 ] + heightoffset );
    elapsedtime = 0;
    
    while ( elapsedtime < 1.5 )
    {
        elapsedtime += level.framedurationseconds;
        progress = min( 1, elapsedtime / 1.5 );
        progress = easepower( progress, 3, 0, 1 );
        invprogress = 1 - progress;
        self.origin = invprogress * invprogress * startpos + 2 * invprogress * progress * var_96e81673dd3580eb + progress * progress * targetpos;
        self.angles = ( invprogress * startangles[ 0 ] + progress * targetangles[ 0 ], invprogress * startangles[ 1 ] + progress * targetangles[ 1 ], invprogress * startangles[ 2 ] + progress * targetangles[ 2 ] );
        waitframe();
    }
    
    self.origin = targetpos;
    self.angles = targetangles;
}

// Namespace skirmish_respawn
// Params 1, eflags: 0x4
// Checksum 0x7b014081, Offset: 0x12cf
// Size: 0x179
function private function_a6067541e939858f( point )
{
    randomangle = randomfloat( 360 );
    var_f24c83578b812f12 = randomintrange( level.var_1f8d75014734e1f3, level.var_1fb08b01475b5a0d );
    offsetx = cos( randomangle ) * var_f24c83578b812f12;
    offsety = sin( randomangle ) * var_f24c83578b812f12;
    offsetz = randomintrange( level.var_9fe94c55c08cdd78, level.var_a00c6255c0b35592 );
    safeposition = ( point[ 0 ] + offsetx, point[ 1 ] + offsety, point[ 2 ] + offsetz );
    
    if ( outofbounds::ispointinoutofbounds( safeposition ) )
    {
        mapcenterdirection = vectortoangles( level.mapcenter - point );
        baseangle = mapcenterdirection[ 1 ];
        spawnpointattempts = 5;
        
        for ( attempt = 0; attempt < spawnpointattempts ; attempt++ )
        {
            anglevariation = randomfloatrange( -45, 45 );
            finalangle = baseangle + anglevariation;
            var_6519a74bcdc4bc53 = randomintrange( level.var_1f8d75014734e1f3, level.var_1fb08b01475b5a0d );
            offsetx = cos( finalangle ) * var_6519a74bcdc4bc53;
            offsety = sin( finalangle ) * var_6519a74bcdc4bc53;
            safeposition = ( point[ 0 ] + offsetx, point[ 1 ] + offsety, point[ 2 ] + offsetz );
            
            if ( !outofbounds::ispointinoutofbounds( safeposition ) )
            {
                break;
            }
        }
    }
    
    return safeposition;
}

// Namespace skirmish_respawn
// Params 0
// Checksum 0x62ed0c7f, Offset: 0x1451
// Size: 0x52
function function_8a7cc5aba1e10a7d()
{
    spawnpoint = function_fd8adb6b7cf14ddc();
    
    if ( spawnpoint )
    {
        return spawnpoint;
    }
    
    spawnpoint = function_3577b1c2ba6a7273();
    
    if ( spawnpoint )
    {
        return spawnpoint;
    }
    
    spawnpoint = function_4633340d7782e1a6();
    
    if ( spawnpoint )
    {
        return spawnpoint;
    }
    
    spawnpoint = function_1f004d1d79c117e7();
    
    if ( spawnpoint )
    {
        return spawnpoint;
    }
    
    return function_19712ffde88479d3();
}

// Namespace skirmish_respawn
// Params 0, eflags: 0x4
// Checksum 0xb56d367b, Offset: 0x14ac
// Size: 0x3b
function private function_fd8adb6b7cf14ddc()
{
    if ( self.setspawnpoint )
    {
        return makespawnpoint( self.setspawnpoint.playerspawnpos, self.setspawnpoint.playerspawnangles );
    }
}

// Namespace skirmish_respawn
// Params 0, eflags: 0x4
// Checksum 0x58703d6, Offset: 0x14f0
// Size: 0x20
function private function_3577b1c2ba6a7273()
{
    if ( self.initialspawn )
    {
        self.initialspawn = 0;
        return spawnlogic::function_3f9d5fcfb93d4190( self );
    }
}

// Namespace skirmish_respawn
// Params 0, eflags: 0x4
// Checksum 0x6b67a5d7, Offset: 0x1519
// Size: 0x25
function private function_4633340d7782e1a6()
{
    if ( function_c5489f6daffcbb8c( self.var_2d05996b947d2534 ) )
    {
        return spawnlogic::function_ae052a703385152c( self, #"start" );
    }
}

// Namespace skirmish_respawn
// Params 0, eflags: 0x4
// Checksum 0xc3322970, Offset: 0x1547
// Size: 0xf3
function private function_1f004d1d79c117e7()
{
    teammate = self.var_2d05996b947d2534;
    
    if ( !teammate || !function_523a0607084a0a04( teammate ) )
    {
        return;
    }
    
    delta_z = 40;
    respawndata = level.respawndata[ self.team ];
    
    if ( teammate player::isincombat() || skirmish_util::function_3b79123608a6ac3e( teammate ) )
    {
        spawnpoint = function_32628250c5f30eba();
        
        if ( spawnpoint )
        {
            targetpoint = ( spawnpoint[ 0 ], spawnpoint[ 1 ], spawnpoint[ 2 ] + delta_z );
        }
    }
    else
    {
        spawnpoint = spawnscoring::findteammatebuddyspawn( teammate );
        
        if ( spawnpoint )
        {
            targetpoint = ( spawnpoint.origin[ 0 ], spawnpoint.origin[ 1 ], spawnpoint.origin[ 2 ] + delta_z );
        }
    }
    
    if ( targetpoint )
    {
        return makespawnpoint( targetpoint, respawndata.angles );
    }
}

// Namespace skirmish_respawn
// Params 0, eflags: 0x4
// Checksum 0xd92ab67f, Offset: 0x1643
// Size: 0x96
function private function_19712ffde88479d3()
{
    if ( getdvarint( @"hash_2ef96d1a474883b3", 0 ) )
    {
        spawnorigin = self.spectatorcament.origin;
        spawnangles = self.spectatorcament.angles;
    }
    else
    {
        teamspawnorigin = level.var_f4fb60d64c3a5cbd[ self.team ].origin;
        spawnorigin = function_a6067541e939858f( teamspawnorigin );
        spawnangles = vectortoangles( teamspawnorigin - spawnorigin );
    }
    
    return makespawnpoint( spawnorigin, spawnangles );
}

// Namespace skirmish_respawn
// Params 0, eflags: 0x4
// Checksum 0x717a444, Offset: 0x16e2
// Size: 0x86
function private function_32628250c5f30eba()
{
    teammate = self.var_2d05996b947d2534;
    
    if ( !teammate || !teammate.origin )
    {
        return;
    }
    
    var_7bcfda4c68821fe3 = [ teammate.origin ];
    tacpoint = findclosestlospointwithinradius( teammate.origin, 500, teammate.origin, teammate.origin, var_7bcfda4c68821fe3, 200 );
    
    if ( tacpoint )
    {
        return tacpoint;
    }
}

// Namespace skirmish_respawn
// Params 1, eflags: 0x4
// Checksum 0x60c6faf5, Offset: 0x1771
// Size: 0x6f, Type: bool
function private function_523a0607084a0a04( player )
{
    if ( player.sessionstate != "playing" )
    {
        return false;
    }
    
    if ( !player::isreallyalive( player ) )
    {
        return false;
    }
    
    if ( outofbounds::ispointinoutofbounds( player.origin ) )
    {
        return false;
    }
    
    if ( !player isonground() && !player.vehicle )
    {
        return false;
    }
    
    if ( player isonladder() )
    {
        return false;
    }
    
    return true;
}

// Namespace skirmish_respawn
// Params 2, eflags: 0x4
// Checksum 0x480af14b, Offset: 0x17e9
// Size: 0x51
function private makespawnpoint( origin, angles )
{
    spawnpoint = spawnstruct();
    spawnpoint.origin = origin;
    spawnpoint.angles = angles;
    spawnpoint.index = 1;
    return spawnpoint;
}

// Namespace skirmish_respawn
// Params 1, eflags: 0x4
// Checksum 0xfde60b59, Offset: 0x1843
// Size: 0x1e, Type: bool
function private function_c5489f6daffcbb8c( var_2d05996b947d2534 )
{
    return isstring( var_2d05996b947d2534 ) && var_2d05996b947d2534 == "ground";
}

// Namespace skirmish_respawn
// Params 1
// Checksum 0x50569474, Offset: 0x186a
// Size: 0xc6
function onspawnplayer( revivespawn )
{
    self setclientomnvar( "ui_skr_respawn_timer_complete", 0 );
    self skydive_cutparachuteon();
    self skydive_cutautodeployon();
    
    if ( !flags::gameflag( "prematch_done" ) )
    {
        function_a8b75cda93efce78();
        return;
    }
    
    if ( self.var_ed93f1fad8f6974f )
    {
        function_3a916a267830bcf8();
    }
    
    if ( !self.initialspawn )
    {
        if ( self.ti_spawn )
        {
            return;
        }
        
        if ( function_c5489f6daffcbb8c( self.var_2d05996b947d2534 ) || self.var_2d05996b947d2534 && function_523a0607084a0a04( self.var_2d05996b947d2534 ) )
        {
            startrespawn();
        }
        else
        {
            function_7e397fc4c460e9f0();
        }
    }
    else
    {
        self.initialspawn = 0;
    }
    
    function_b8b9d3f053b523af();
    function_f469f16453db68ca();
}

// Namespace skirmish_respawn
// Params 0, eflags: 0x4
// Checksum 0xbc138c35, Offset: 0x1938
// Size: 0x5e
function private function_b8b9d3f053b523af()
{
    if ( !level.var_c8b1130f599f081c || !level.var_bd070f6dcd0b310e )
    {
        return;
    }
    
    if ( self.team != level.var_c8b1130f599f081c )
    {
        return;
    }
    
    if ( self.sessionsquadid == level.var_249b4c00fa268387[ level.var_c8b1130f599f081c ] )
    {
        skirmish_bounty::function_acf6364ca566e061( 1 );
    }
}

// Namespace skirmish_respawn
// Params 0, eflags: 0x4
// Checksum 0xbb1730bc, Offset: 0x199e
// Size: 0x4c
function private function_a8b75cda93efce78()
{
    if ( !isdefined( self.initialheight ) )
    {
        self.initialheight = self.origin[ 2 ];
        self.initialangles = self.angles;
        self setorigin( utility::drop_to_ground( self.origin ) );
    }
}

// Namespace skirmish_respawn
// Params 0, eflags: 0x4
// Checksum 0x59e4aaf2, Offset: 0x19f2
// Size: 0x44
function private function_3a916a267830bcf8()
{
    self.var_ed93f1fad8f6974f = 0;
    self setclientomnvar( "ui_skr_inskirmishcam", self.var_ed93f1fad8f6974f );
    
    if ( level.var_439b0dbbc27bb39d )
    {
        scripted_widgets::destroy( "respawn_target" );
        scripted_widgets::destroy( "skirmish_respawn_container" );
    }
}

// Namespace skirmish_respawn
// Params 0, eflags: 0x4
// Checksum 0xb220f5fe, Offset: 0x1a3e
// Size: 0x44
function private function_5243e15c6b103f89()
{
    level endon( #"game_ended" );
    level endon( #"disconnect" );
    outofbounds::enableoobimmunity( self );
    waitframe();
    
    while ( !self isonground() )
    {
        waitframe();
    }
    
    if ( self.oobimmunity )
    {
        outofbounds::disableoobimmunity( self );
    }
}

// Namespace skirmish_respawn
// Params 0, eflags: 0x4
// Checksum 0x6f225e8, Offset: 0x1a8a
// Size: 0x39
function private function_d7fe8b7a92831d6a()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    wait 1;
    self function_f54a784112fcf506( 0 );
    self waittill( #"death" );
    self function_f54a784112fcf506( 1 );
}

// Namespace skirmish_respawn
// Params 0, eflags: 0x4
// Checksum 0x15b0799e, Offset: 0x1acb
// Size: 0x1d0
function private function_7e397fc4c460e9f0()
{
    var_7438b5194165f269 = getdvarint( @"hash_2ef96d1a474883b3", 0 );
    
    if ( var_7438b5194165f269 )
    {
        thread function_5243e15c6b103f89();
    }
    
    hud_message::function_ef4318a0090caa0f( #"kill" );
    self lerpfovscalefactor( 1, 0 );
    player::updatesessionstate( "playing" );
    thread function_d7fe8b7a92831d6a();
    deployangles = function_a38e2286172c5f81( var_7438b5194165f269 );
    
    if ( self.spectatorcament )
    {
        self cameraunlink();
        self.spectatorcament delete();
        self.spectatorcament = undefined;
    }
    
    self setvelocity( anglestoforward( deployangles ) * randomintrange( level.var_894129499015bc36, level.var_89641b49903be524 ) );
    self dlog_recordplayerevent( "dlog_event_mp_skr_player_spawn", [ "skr_spawn_player_uno_id", self getplayerunoid(), "skr_spawn_location_x", self.origin[ 0 ], "skr_spawn_location_y", self.origin[ 1 ], "skr_spawn_location_z", self.origin[ 2 ], "skr_spawn_type", #"air_default", "skr_spawn_time", getsystemtime() ] );
    
    if ( level.var_f3f28a19db93fdde )
    {
        self notify( #"skydive_deployparachute" );
    }
    
    self skydive_deployparachute();
    self skydive_cutparachuteon();
    self skydive_cutautodeployon();
    
    if ( level.skydive_spawnprotectionactive )
    {
        skydive_protection::initprotection( 2, 10 );
    }
    
    if ( level.spawnprotectiontimer > 0 )
    {
        thread common::removespawnprotectiononnotify();
        thread common::removespawnprotectiononads();
    }
    
    thread function_29a7ea1893e7ffe5();
    self setplayerangles( level.var_f4fb60d64c3a5cbd[ self.team ].angles );
}

// Namespace skirmish_respawn
// Params 1, eflags: 0x4
// Checksum 0xd016535e, Offset: 0x1ca3
// Size: 0xcd
function private function_a38e2286172c5f81( var_7438b5194165f269 )
{
    deployangles = ( 0, 0, 0 );
    deploypitch = 0;
    
    if ( var_7438b5194165f269 && !isbot( self ) )
    {
        deployangles = self.spectatorcament.angles;
        deploypitch = self.spectatorcament.angles[ 0 ];
    }
    else
    {
        deployangles = level.var_f3f28a19db93fdde ? self.angles : level.var_f4fb60d64c3a5cbd[ self.team ].angles;
        deploypitch = level.var_f3f28a19db93fdde ? deployangles[ 0 ] : level.var_81edc4abbc0a52e0;
    }
    
    return ( deploypitch, deployangles[ 1 ], deployangles[ 2 ] );
}

// Namespace skirmish_respawn
// Params 0, eflags: 0x4
// Checksum 0x13641884, Offset: 0x1d79
// Size: 0x85
function private startrespawn()
{
    self cameralinkto( self.spectatorcament, "tag_origin", 1 );
    player::updatesessionstate( "spectator" );
    spectating::setdisabled();
    targetpoint = self.spawndata.spawnpoint;
    self.spectatorcament function_2b356b460e1ad03c( targetpoint.origin, targetpoint.angles );
    self playsoundtoplayer( "uin_t10_skirmish_redeploy_cam", self );
    thread finishrespawn( targetpoint );
}

// Namespace skirmish_respawn
// Params 1, eflags: 0x4
// Checksum 0x1d71f6bd, Offset: 0x1e06
// Size: 0xcd
function private finishrespawn( targetpoint )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    wait 0.1;
    function_54d5700b54cb89df( 0 );
    wait 0.75;
    thread function_bedf3195448179f7( 0.75 );
    wait 0.75;
    
    if ( self.spectatorcament )
    {
        self cameraunlink();
        self.spectatorcament delete();
        self.spectatorcament = undefined;
    }
    
    player::updatesessionstate( "playing" );
    function_54d5700b54cb89df( 1 );
    waitframe();
    function_3ace8e46b770bf89();
    function_ddfd121b7fa88669( targetpoint );
    function_8a471543bde24bb2( targetpoint );
    self lerpfovscalefactor( 1, 0 );
    hud_message::function_ef4318a0090caa0f( #"kill" );
    self.var_2d05996b947d2534 = undefined;
}

// Namespace skirmish_respawn
// Params 0, eflags: 0x4
// Checksum 0x6b69615, Offset: 0x1edb
// Size: 0x4b
function private function_3ace8e46b770bf89()
{
    if ( !function_c5489f6daffcbb8c( self.var_2d05996b947d2534 ) && self.var_2d05996b947d2534 )
    {
        points::doscoreevent( #"hash_bf3755b40a3c5038" );
        self.var_2d05996b947d2534 points::doscoreevent( #"hash_bf3755b40a3c5038" );
    }
}

// Namespace skirmish_respawn
// Params 1, eflags: 0x4
// Checksum 0x54ddbef3, Offset: 0x1f2e
// Size: 0x8b
function private function_ddfd121b7fa88669( targetpoint )
{
    teammate = self.var_2d05996b947d2534;
    
    if ( teammate && !player::isreallyalive( teammate ) && !function_c5489f6daffcbb8c( teammate ) )
    {
        targetpoint.origin = function_32628250c5f30eba();
    }
    
    if ( !targetpoint || !targetpoint.origin )
    {
        targetpoint = spawnlogic::function_ae052a703385152c( self, #"start" );
    }
    
    self setorigin( targetpoint.origin );
}

// Namespace skirmish_respawn
// Params 1, eflags: 0x4
// Checksum 0xbf6697c5, Offset: 0x1fc1
// Size: 0xe3
function private function_8a471543bde24bb2( targetpoint )
{
    teammate = self.var_2d05996b947d2534;
    
    if ( function_c5489f6daffcbb8c( teammate ) )
    {
        return;
    }
    
    if ( teammate && player::isreallyalive( teammate ) )
    {
        teammateangles = teammate getplayerangles();
        self setplayerangles( ( 0, teammateangles[ 1 ], teammateangles[ 2 ] ) );
        return;
    }
    
    if ( teammate && !player::isreallyalive( teammate ) && teammate.origin )
    {
        direction = teammate.origin - self.origin;
        direction = ( direction[ 0 ], direction[ 1 ], 0 );
        
        if ( length( direction ) > 0 )
        {
            self setplayerangles( vectortoangles( direction ) );
            return;
        }
    }
    
    direction = level.mapcenter - self.origin;
    self setplayerangles( vectortoangles( direction ) );
}

// Namespace skirmish_respawn
// Params 1, eflags: 0x4
// Checksum 0xd80ca555, Offset: 0x20ac
// Size: 0x51
function private function_54d5700b54cb89df( enable )
{
    if ( self.vehicle )
    {
        val::set( "spawn_on_vehicle", "vehicle_seat_switch", enable );
        val::set( "spawn_on_vehicle", "vehicle_exit", enable );
        val::set( "spawn_on_vehicle", "vehicle_lean_out", enable );
    }
}

// Namespace skirmish_respawn
// Params 0, eflags: 0x4
// Checksum 0xd054024, Offset: 0x2105
// Size: 0xdc
function private function_833fd8b520b9171c()
{
    self endon( #"spawned_player" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( level.var_439b0dbbc27bb39d )
    {
        var_73184eee50794a53 = gettime() - self.respawntimerstarttime;
        respawntime = clampint( 10000 - var_73184eee50794a53, 0, 10000 );
        var_3dc9506c8fe69ea4 = respawntime / 1000;
        lower_message::setlowermessageomnvar( "skirmish_spawn_available_in", int( gettime() + respawntime ), var_3dc9506c8fe69ea4 );
        wait var_3dc9506c8fe69ea4;
        self setclientomnvar( "ui_skr_respawn_timer_complete", 1 );
        wait 5;
        var_350719bd2a314161 = playerlogic::timeuntilspawn( 1 );
        lower_message::setlowermessageomnvar( "skirmish_auto_spawn", int( gettime() + var_350719bd2a314161 * 1000 ) );
        return;
    }
    
    lower_message::setlowermessageomnvar( "skirmish_auto_spawn" );
}

// Namespace skirmish_respawn
// Params 0, eflags: 0x4
// Checksum 0x1c055410, Offset: 0x21e9
// Size: 0x1c3
function private function_3f703c176c1b8312()
{
    self endon( #"spawned_player" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( !self.spectatorcament )
    {
        return;
    }
    
    position = self.spectatorcament.origin;
    var_a4343bab2c0f747c = ( level.mapcenter[ 0 ], level.mapcenter[ 1 ], position[ 2 ] / 2 );
    var_4d62bac7f1c09d75 = getdvarint( @"hash_63d4b23f202731f5", 30 );
    rotationspeed = getdvarfloat( @"hash_5b146e07736260e2", 0.7 );
    var_f4c8eaacc02917f8 = position - var_a4343bab2c0f747c;
    var_cd660f858a227ba9 = 0;
    
    while ( true )
    {
        waitframe();
        var_25552083df417cd8 = self getnormalizedmovement()[ 1 ];
        increment = rotationspeed * var_25552083df417cd8;
        currentyaw = vectortoyaw( var_f4c8eaacc02917f8 );
        nextyaw = currentyaw + increment;
        var_cd660f858a227ba9 += increment;
        
        if ( abs( var_cd660f858a227ba9 ) > var_4d62bac7f1c09d75 )
        {
            if ( var_cd660f858a227ba9 > 0 )
            {
                nextyaw -= var_cd660f858a227ba9 - var_4d62bac7f1c09d75;
            }
            else if ( var_cd660f858a227ba9 < 0 )
            {
                nextyaw += abs( var_cd660f858a227ba9 ) - var_4d62bac7f1c09d75;
            }
        }
        
        var_cd660f858a227ba9 = clamp( var_cd660f858a227ba9, var_4d62bac7f1c09d75 * -1, var_4d62bac7f1c09d75 );
        deltayaw = nextyaw - currentyaw;
        var_f4c8eaacc02917f8 = rotatevector( var_f4c8eaacc02917f8, ( 0, angleclamp( deltayaw ), 0 ) );
        nextposition = var_a4343bab2c0f747c + var_f4c8eaacc02917f8;
        var_2b7eea1b68036bff = vectortoangles( var_a4343bab2c0f747c - nextposition );
        self.spectatorcament.origin = nextposition;
        self.spectatorcament.angles = var_2b7eea1b68036bff;
    }
}

// Namespace skirmish_respawn
// Params 0, eflags: 0x4
// Checksum 0x78cc8450, Offset: 0x23b4
// Size: 0x126
function private function_29a7ea1893e7ffe5()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( getdvarint( @"hash_2a47b49f6d3f0a", 0 ) == 0 )
    {
        return;
    }
    
    active_camo::function_32ebebc1e0f4707f();
    active_camo_applied = 1;
    active_camo_life_time = gettime() + 10000;
    
    while ( !self isonground() && active_camo_life_time > gettime() )
    {
        lastshotfiredtime = self.lastshotfiredtime ?? 0;
        isshooting = lastshotfiredtime + 25 > gettime();
        
        if ( isshooting || self ismeleeing() || self isthrowinggrenade() )
        {
            break;
        }
        
        ground_origin = utility::drop_to_ground( self.origin );
        ground_distance = distancesquared( self.origin, ground_origin );
        
        if ( ground_distance <= 250000 && active_camo_applied )
        {
            active_camo::active_camo_off();
            active_camo_applied = 0;
        }
        else if ( ground_distance > 250000 && !active_camo_applied )
        {
            active_camo::function_32ebebc1e0f4707f();
            active_camo_applied = 1;
        }
        
        waitframe();
    }
    
    active_camo::active_camo_off();
}

// Namespace skirmish_respawn
// Params 3, eflags: 0x4
// Checksum 0x53c94d28, Offset: 0x24e2
// Size: 0xa7
function private function_51a517ae2c8d84f3( player, var_2d05996b947d2534, spawntype )
{
    player endon( #"hash_7168fe2c0a868110" );
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    var_cd9d9b4c389ce1d = var_2d05996b947d2534 && !function_523a0607084a0a04( var_2d05996b947d2534 );
    
    while ( var_cd9d9b4c389ce1d )
    {
        if ( player::isreallyalive( player ) )
        {
            return;
        }
        
        var_cd9d9b4c389ce1d = var_2d05996b947d2534 && !function_523a0607084a0a04( var_2d05996b947d2534 );
        
        if ( !var_cd9d9b4c389ce1d )
        {
            function_7f96bd0166bbdd7( player, var_2d05996b947d2534, spawntype );
            return;
        }
        
        wait 0.2;
    }
    
    function_7f96bd0166bbdd7( player, var_2d05996b947d2534, spawntype );
}

// Namespace skirmish_respawn
// Params 3, eflags: 0x4
// Checksum 0xe930fe56, Offset: 0x2591
// Size: 0xf5
function private function_7f96bd0166bbdd7( player, var_2d05996b947d2534, spawntype )
{
    if ( player::isreallyalive( player ) )
    {
        return;
    }
    
    player scripted_widgets::set_state( "respawn_target", "Hide" );
    player.var_2d05996b947d2534 = var_2d05996b947d2534;
    player playerlogic::spawnplayer( undefined, 1 );
    player lower_message::setlowermessageomnvar( "clear_lower_msg" );
    player dlog_recordplayerevent( "dlog_event_mp_skr_player_spawn", [ "skr_spawn_player_uno_id", player getplayerunoid(), "skr_spawn_location_x", player.spawnpos[ 0 ], "skr_spawn_location_y", player.spawnpos[ 1 ], "skr_spawn_location_z", player.spawnpos[ 2 ], "skr_spawn_type", spawntype, "skr_spawn_time", getsystemtime() ] );
}

// Namespace skirmish_respawn
// Params 1
// Checksum 0xc4e64ac9, Offset: 0x268e
// Size: 0xc7
function function_56e3a5a3276eb487( player )
{
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        player waittill( #"luinotifyserver", result, value );
        player notify( #"hash_7168fe2c0a868110" );
        
        if ( result == "skirmish_player_spawn" )
        {
            thread function_51a517ae2c8d84f3( player, getentbynum( value ), #"hash_fe830a5f0d7a7dec" );
            continue;
        }
        
        if ( result == "skirmish_air_spawn" )
        {
            function_7f96bd0166bbdd7( player, undefined, #"air" );
            continue;
        }
        
        if ( result == "skirmish_ground_spawn" )
        {
            function_7f96bd0166bbdd7( player, "ground", #"ground" );
        }
    }
}

// Namespace skirmish_respawn
// Params 1
// Checksum 0x5af34b51, Offset: 0x275d
// Size: 0xb1
function function_7ae5f13d4bc8624d( player )
{
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        player waittill( #"luinotifyserver", result, value );
        
        if ( result == "skirmish_update_spawn_arrow" )
        {
            if ( value == 0 )
            {
                player scripted_widgets::set_state( "respawn_target", "Hide" );
                continue;
            }
            
            entitynum = getentbynum( value );
            player scripted_widgets::anchor_to_ent( "respawn_target", entitynum, "scripted_widget_anchor_overhead_respawn" );
            player scripted_widgets::set_state( "respawn_target", "Default" );
        }
    }
}

