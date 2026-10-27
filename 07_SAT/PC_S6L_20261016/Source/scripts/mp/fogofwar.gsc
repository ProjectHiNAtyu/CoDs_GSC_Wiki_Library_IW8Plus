// scripts\mp\fogofwar.gsc  (hash_41ad3c6f74f4b8ef.gscc) (size: 6068 Bytes / 0x17b4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xb89c2534 (3097240884)
// size ...... 6068 (0x17b4)
// includes .. 3   (offset: 0x1738)
// strings ... 7   (offset: 0x1750)
// dev strs .. 0   (offset: 0x17b4)
// exports ... 15  (offset: 0xf94)
// cseg ...... 0xd7 + 0xebd (0xf94)
// imports ... 42  (offset: 0x11ec)
// animtree1 . 0   (offset: 0x17b4)
// animtree2 . 0   (offset: 0x17b4)
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\common\utility\player;

#namespace fogofwar;

// Namespace fogofwar
// Params 0
// Checksum 0x7a9b1e49, Offset: 0xf5
// Size: 0x77
function init()
{
    fogofwarenabled = getdvarint( @"bg_fogofwar_enabled", 0 );
    
    if ( !fogofwarenabled )
    {
        return;
    }
    
    function_38911936d5717acc();
    isenabled = fogofwar_isenabled();
    
    if ( isenabled )
    {
        assert( !isdefined( level.br_fogofwar ) );
        level.br_fogofwar = spawnstruct();
        setupdvars();
        function_b4620d87693a7dc2();
        function_4a979ab7928f9e0c();
        thread setupthreads();
    }
}

// Namespace fogofwar
// Params 0, eflags: 0x4
// Checksum 0x425ad2db, Offset: 0x174
// Size: 0x1c5
function private setupdvars()
{
    assert( isdefined( level.br_fogofwar ) );
    fogofwardata = level.br_fogofwar;
    fogofwardata.var_3cca9ef2eacfeb2f = getdvarint( @"hash_ba99b30c43797bf2", 1 );
    fogofwardata.var_766c738ec011ddb7 = getdvarint( @"hash_4cb4ea83e8060b82", 1 );
    fogofwardata.var_8e93e8910ca150b9 = getdvarint( @"hash_d79899fb31780dea", 1 );
    fogofwardata.var_c659d200aee5fed = getdvarint( @"hash_5ea4ad60f090ee37", 1 );
    fogofwardata.var_264f76d844f58845 = getdvarint( @"hash_ba74fc72d7d594e6", 1 );
    fogofwardata.cuavresetradius = getdvarint( @"hash_98c4a3109144121b", 2500 );
    fogofwardata.uavsetenabled = getdvarint( @"hash_4079e628d612e7fc", 1 );
    fogofwardata.var_6710a17632338474 = getdvarint( @"hash_528d3a63b8e9ad35", 7500 );
    fogofwardata.uavtowersetenabled = getdvarint( @"hash_23238b7a801bc4e", 1 );
    fogofwardata.var_110777bc17513a57 = getdvarint( @"hash_3242683c6dc0c163", 7500 );
    fogofwardata.var_ea440a95fb79844a = getdvarint( @"hash_d84a5db8eef27031", 1 );
    fogofwardata.var_13b9074ddc026ff = getdvarint( @"hash_128e08907c53a30a", 7500 );
    fogofwardata.var_d5bd5c5d307c2aee = getdvarint( @"hash_2bd61a5869101c82", 5000 );
    
    /#
        fogofwardata.debugenabled = getdvarint( @"scr_fogofwar_debug_enabled", 0 );
        fogofwardata.debugupdateinterval = getdvarint( @"hash_818b3acd4899a919", 10 );
    #/
}

// Namespace fogofwar
// Params 0, eflags: 0x4
// Checksum 0x85d1908, Offset: 0x341
// Size: 0x67
function private function_b4620d87693a7dc2()
{
    assert( isdefined( level.br_fogofwar ) );
    fogofwardata = level.br_fogofwar;
    fogofwardata.versions = spawnstruct();
    fogofwardata.versions.regions = [];
    fogofwardata.versions.pois = [];
}

// Namespace fogofwar
// Params 0, eflags: 0x4
// Checksum 0x88db179a, Offset: 0x3b0
// Size: 0x22b
function private setupforplayer()
{
    player = self;
    fogofwardata = level.br_fogofwar;
    clientnum = player getentitynumber();
    function_de95983f0bef12fb( clientnum );
    mapname = level.mapname;
    var_714184189c36f5d9 = 0;
    
    if ( isdefined( fogofwardata.versions.regions[ mapname ] ) )
    {
        var_714184189c36f5d9 = fogofwardata.versions.regions[ mapname ].size;
        assert( var_714184189c36f5d9 == fogofwardata.versions.pois[ mapname ].size );
    }
    
    playerdataversion = function_c3643c38edd4bf23( clientnum );
    assert( playerdataversion >= 1 );
    
    if ( var_714184189c36f5d9 >= playerdataversion )
    {
        for ( versionidx = playerdataversion - 1; versionidx < fogofwardata.versions.regions[ mapname ].size ; versionidx++ )
        {
            foreach ( region in fogofwardata.versions.regions[ mapname ][ versionidx ] )
            {
                fogofwar_reset( clientnum, region, -1, 2 );
            }
            
            foreach ( poi in fogofwardata.versions.pois[ mapname ][ versionidx ] )
            {
                fogofwar_reset( clientnum, -1, poi, 2 );
            }
        }
        
        function_50d6867e35b615ef( clientnum, var_714184189c36f5d9 + 1 );
    }
}

// Namespace fogofwar
// Params 0, eflags: 0x4
// Checksum 0x34195773, Offset: 0x5e3
// Size: 0x7b
function private function_4a979ab7928f9e0c()
{
    foreach ( player in level.players )
    {
        player setupforplayer();
    }
}

// Namespace fogofwar
// Params 0, eflags: 0x4
// Checksum 0xdb95058b, Offset: 0x666
// Size: 0xf0
function private setupthreads()
{
    fogofwardata = level.br_fogofwar;
    
    /#
        thread debug_think();
    #/
    
    if ( fogofwardata.var_3cca9ef2eacfeb2f )
    {
        thread think();
        level utility::waittill_any( "prematch_done", "prematch_over" );
    }
    else
    {
        level utility::waittill_any( "prematch_done", "prematch_over" );
        thread think();
    }
    
    thread uav_think();
    thread uav_tower_think();
    thread helper_drone_think();
    
    foreach ( player in level.players )
    {
        player thread poi_first_visit_think();
    }
}

// Namespace fogofwar
// Params 0, eflags: 0x4
// Checksum 0xff42c1d9, Offset: 0x75e
// Size: 0x27e
function private think()
{
    level endon( #"game_ended" );
    fogofwardata = level.br_fogofwar;
    var_506dfabc6577dd01 = gettime();
    
    while ( true )
    {
        foreach ( player in level.players )
        {
            clientnum = player getentitynumber();
            
            if ( !fogofwar_isinitialized( clientnum ) )
            {
                player setupforplayer();
            }
            
            iscomplete = fogofwar_iscomplete( clientnum );
            
            if ( iscomplete )
            {
                continue;
            }
            
            if ( getdvarint( @"hash_63a6ae1db0e57d7", 0 ) )
            {
                if ( utility::issharedfuncdefined( #"hash_a0522d1ad778a788", #"should_play_intro" ) )
                {
                    if ( [[ utility::getsharedfunc( #"hash_a0522d1ad778a788", #"should_play_intro" ) ]]() )
                    {
                        utility::flag_wait( "flag_dungeon_intro_complete" );
                    }
                }
            }
            
            onground = !fogofwardata.var_766c738ec011ddb7 || player isonground();
            playerisswimming = player isswimming();
            invalidvehicle = player vehicle::is_in_vehicle() && ( !fogofwardata.var_766c738ec011ddb7 || !player.vehicle vehicle::ishelicopter() );
            var_6c142e3869608a7a = !fogofwardata.var_8e93e8910ca150b9 || !level.ignorescoring;
            isalive = player::isreallyalive( player );
            
            if ( utility::issharedfuncdefined( #"hash_a0522d1ad778a788", #"isplayeringulag" ) )
            {
                ingulag = player [[ utility::getsharedfunc( #"hash_a0522d1ad778a788", #"isplayeringulag" ) ]]();
            }
            else
            {
                ingulag = 0;
            }
            
            if ( var_6c142e3869608a7a && ( onground || invalidvehicle || playerisswimming ) && isalive && !ingulag )
            {
                regionscompleted = function_fb04826a47a2e4dc( clientnum );
                
                if ( gettime() > var_506dfabc6577dd01 )
                {
                    function_ffb8e128700c7f67( clientnum );
                    var_506dfabc6577dd01 = gettime() + fogofwardata.var_d5bd5c5d307c2aee;
                }
                
                player function_eeb1434835625ddb( regionscompleted );
            }
        }
        
        waitframe();
    }
}

// Namespace fogofwar
// Params 0, eflags: 0x4
// Checksum 0xa4103a5d, Offset: 0x9e4
// Size: 0x124
function private uav_think()
{
    level endon( #"game_ended" );
    fogofwardata = level.br_fogofwar;
    
    while ( true )
    {
        level waittill( #"uav_started", uavowner, uavtype );
        
        if ( fogofwardata.uavsetenabled && ( uavtype == "uav" || uavtype == "directional_uav" ) )
        {
            team = level.teamdata[ uavowner.team ];
            
            if ( isdefined( team ) )
            {
                foreach ( player in team[ "players" ] )
                {
                    player tryresetradius( uavowner.origin, fogofwardata.var_6710a17632338474, 1 );
                }
            }
        }
    }
}

// Namespace fogofwar
// Params 0, eflags: 0x4
// Checksum 0x787e552, Offset: 0xb10
// Size: 0x102
function private uav_tower_think()
{
    level endon( #"game_ended" );
    fogofwardata = level.br_fogofwar;
    
    while ( true )
    {
        level waittill( #"uav_tower_activated", tower );
        
        if ( fogofwardata.uavtowersetenabled )
        {
            team = level.teamdata[ tower.activeteam ];
            
            if ( isdefined( team ) )
            {
                foreach ( player in team[ "players" ] )
                {
                    player tryresetradius( tower.origin, fogofwardata.var_110777bc17513a57, 1 );
                }
            }
        }
    }
}

// Namespace fogofwar
// Params 0, eflags: 0x4
// Checksum 0x3b98a404, Offset: 0xc1a
// Size: 0x172
function private helper_drone_think()
{
    level endon( #"game_ended" );
    fogofwardata = level.br_fogofwar;
    
    while ( true )
    {
        level waittill( #"helper_drone_started", helperdroneowner, helperdronetype );
        
        if ( fogofwardata.var_264f76d844f58845 && helperdronetype == "scrambler_drone_guard" )
        {
            foreach ( teamname, teamdata in level.teamdata )
            {
                if ( teamname != helperdroneowner.team )
                {
                    foreach ( player in teamdata[ "players" ] )
                    {
                        player tryresetradius( helperdroneowner.origin, fogofwardata.cuavresetradius, 2 );
                    }
                }
            }
        }
    }
}

// Namespace fogofwar
// Params 0, eflags: 0x4
// Checksum 0xc595570f, Offset: 0xd94
// Size: 0x80
function private poi_first_visit_think()
{
    player = self;
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    fogofwardata = level.br_fogofwar;
    
    while ( true )
    {
        player waittill( #"hash_1fc38fa4e3ef577a" );
        
        if ( fogofwardata.var_ea440a95fb79844a )
        {
            player tryresetradius( player.origin, fogofwardata.var_13b9074ddc026ff, 1 );
        }
    }
}

// Namespace fogofwar
// Params 3, eflags: 0x4
// Checksum 0x45948009, Offset: 0xe1c
// Size: 0x64
function private tryresetradius( origin, radius, tilestate )
{
    player = self;
    clientnum = player getentitynumber();
    
    if ( !fogofwar_isinitialized( clientnum ) )
    {
        return;
    }
    
    regionscompleted = function_e3d819094290e125( clientnum, origin, radius, tilestate );
    player function_eeb1434835625ddb( regionscompleted );
}

// Namespace fogofwar
// Params 1, eflags: 0x4
// Checksum 0x70038ef6, Offset: 0xe88
// Size: 0x99
function private function_eeb1434835625ddb( regionscompleted )
{
    player = self;
    fogofwardata = level.br_fogofwar;
    
    if ( regionscompleted && fogofwardata.var_c659d200aee5fed )
    {
        for ( regioncomplete = 0; regioncomplete < regionscompleted ; regioncomplete++ )
        {
            if ( utility::issharedfuncdefined( #"hash_a0522d1ad778a788", #"hash_cb519eda4cd9c06b" ) )
            {
                player [[ utility::getsharedfunc( #"hash_a0522d1ad778a788", #"hash_cb519eda4cd9c06b" ) ]]( #"br_fogofwar_region_completed" );
            }
        }
    }
}

/#

    // Namespace fogofwar
    // Params 0, eflags: 0x4
    // Checksum 0x16e30337, Offset: 0xf29
    // Size: 0x6b, Type: dev
    function private debug_think()
    {
        level endon( #"game_ended" );
        fogofwardata = level.br_fogofwar;
        
        while ( true )
        {
            setupdvars();
            
            if ( fogofwardata.debugenabled )
            {
                function_4a34509c3973c9c0();
            }
            
            for ( deferredframe = 0; deferredframe < fogofwardata.debugupdateinterval ; deferredframe++ )
            {
                waitframe();
            }
        }
    }

#/
