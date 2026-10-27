// scripts\mp\br\gametypes\br_convoy.gsc  (hash_7298137ad169db82.gscc) (size: 9880 Bytes / 0x2698 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa6904aa2 (2794474146)
// size ...... 9880 (0x2698)
// includes .. 6   (offset: 0x2420)
// strings ... 32  (offset: 0x2450)
// dev strs .. 10  (offset: 0x25f4)
// exports ... 21  (offset: 0x185c)
// cseg ...... 0x28f + 0x15cd (0x185c)
// imports ... 72  (offset: 0x1ba4)
// animtree1 . 0   (offset: 0x2698)
// animtree2 . 0   (offset: 0x2698)
#using scripts\mp\br\gametypes\br_c130;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\parachute;

#namespace br_convoy;

// Namespace br_convoy
// Params 1
// Checksum 0x15ed8228, Offset: 0x2ad
// Size: 0x16
function unimogtest( c130pathstruct )
{
    level thread spawntestconvoy( c130pathstruct );
}

// Namespace br_convoy
// Params 1
// Checksum 0x5c76cd1e, Offset: 0x2cb
// Size: 0x16
function unimogsnatch( c130pathstruct )
{
    level thread spawnspreadconvoy( c130pathstruct );
}

// Namespace br_convoy
// Params 1
// Checksum 0x549f7108, Offset: 0x2e9
// Size: 0x2ec
function spawntestconvoy( c130pathstruct )
{
    level.br_convoytrucks = [];
    paths = getvehiclenodearray( "br_convoy", #targetname );
    var_40ced5b9197b06b9 = [];
    
    for ( i = 0; i < paths.size ; i++ )
    {
        var_40ced5b9197b06b9[ i ] = paths[ i ];
    }
    
    mapcenter = ( level.br_level.br_mapbounds[ 0 ] + level.br_level.br_mapbounds[ 1 ] ) * 0.5;
    var_62b80fac03733ac9 = c130pathstruct.startpt - mapcenter;
    var_ffbb62be24d39d94 = vectortoangles( var_62b80fac03733ac9 )[ 1 ];
    var_5fc50ee230fbc57d = [];
    
    for ( i = 0; i < paths.size ; i++ )
    {
        tostartnode = var_40ced5b9197b06b9[ i ].origin - mapcenter;
        var_5fc50ee230fbc57d[ i ] = vectortoangles( tostartnode )[ 1 ];
    }
    
    var_5aafe80737d71a45 = -1;
    var_542ac948a81d801e = -1;
    
    for ( i = 0; i < paths.size ; i++ )
    {
        if ( var_ffbb62be24d39d94 < var_5fc50ee230fbc57d[ i ] )
        {
            var_542ac948a81d801e = i;
            continue;
        }
        
        if ( var_542ac948a81d801e != -1 )
        {
            break;
        }
    }
    
    for ( i = 0; i < paths.size ; i++ )
    {
        if ( var_ffbb62be24d39d94 > var_5fc50ee230fbc57d[ i ] )
        {
            var_5aafe80737d71a45 = i;
            continue;
        }
        
        if ( var_5aafe80737d71a45 != -1 )
        {
            break;
        }
    }
    
    if ( var_5aafe80737d71a45 == -1 )
    {
        var_5aafe80737d71a45 = paths.size - 1;
    }
    
    if ( var_542ac948a81d801e == -1 )
    {
        var_542ac948a81d801e = 0;
    }
    
    /#
        println( "<dev string:x24>" + var_5aafe80737d71a45 + "<dev string:x59>" + var_542ac948a81d801e );
        println( "<dev string:x60>" + var_5fc50ee230fbc57d[ var_5aafe80737d71a45 ] + "<dev string:x6c>" + var_5fc50ee230fbc57d[ var_542ac948a81d801e ] );
        
        for ( i = 0; i < var_5fc50ee230fbc57d.size ; i++ )
        {
            println( "<dev string:x72>" + i + "<dev string:x7a>" + var_5fc50ee230fbc57d[ i ] );
        }
    #/
    
    var_ef42ac4f1e6905eb = 1;
    pathindices = [ var_5aafe80737d71a45, var_542ac948a81d801e ];
    
    for ( i = 0; i < var_ef42ac4f1e6905eb ; i++ )
    {
        if ( var_5aafe80737d71a45 - 1 - i <= 0 )
        {
            pathindices[ pathindices.size ] = paths.size - 1 - i;
        }
        else
        {
            pathindices[ pathindices.size ] = var_5aafe80737d71a45 - 1 - i;
        }
        
        if ( var_542ac948a81d801e + 1 + i >= paths.size )
        {
            pathindices[ pathindices.size ] = 0;
        }
        else
        {
            pathindices[ pathindices.size ] = var_542ac948a81d801e + 1 + i;
        }
        
        println( "<dev string:x7c>" + pathindices[ pathindices.size - 1 ] + "<dev string:x91>" + var_5fc50ee230fbc57d[ pathindices[ pathindices.size - 1 ] ] );
    }
    
    /#
        for ( i = 0; i < pathindices.size ; i++ )
        {
            println( "<dev string:x99>" + i + "<dev string:x7a>" + pathindices[ i ] );
        }
    #/
    
    for ( i = 0; i < pathindices.size ; i++ )
    {
        thread spawnconvoyatpath( paths[ pathindices[ i ] ] );
    }
}

// Namespace br_convoy
// Params 1
// Checksum 0x93834ec4, Offset: 0x5dd
// Size: 0x391
function spawnspreadconvoy( c130pathstruct )
{
    level.br_convoytrucks = [];
    paths = getvehiclenodearray( "br_convoy", #targetname );
    removelist = [];
    
    foreach ( convoynode in paths )
    {
        if ( distancesquared( convoynode.origin, ( 19328, 2944, 512 ) ) < 40000 )
        {
            removelist[ removelist.size ] = convoynode;
        }
    }
    
    paths = arrayremove( paths, removelist );
    var_40ced5b9197b06b9 = [];
    
    for ( i = 0; i < paths.size ; i++ )
    {
        var_40ced5b9197b06b9[ i ] = paths[ i ];
    }
    
    mapcenter = ( level.br_level.br_mapbounds[ 0 ] + level.br_level.br_mapbounds[ 1 ] ) * 0.5;
    var_62b80fac03733ac9 = c130pathstruct.startpt - mapcenter;
    var_ffbb62be24d39d94 = vectortoangles( var_62b80fac03733ac9 )[ 1 ];
    var_5fc50ee230fbc57d = [];
    
    for ( i = 0; i < paths.size ; i++ )
    {
        tostartnode = var_40ced5b9197b06b9[ i ].origin - mapcenter;
        var_5fc50ee230fbc57d[ i ] = vectortoangles( tostartnode )[ 1 ];
    }
    
    var_5aafe80737d71a45 = -1;
    var_542ac948a81d801e = -1;
    
    for ( i = 0; i < paths.size ; i++ )
    {
        if ( var_ffbb62be24d39d94 < var_5fc50ee230fbc57d[ i ] )
        {
            var_542ac948a81d801e = i;
            continue;
        }
        
        if ( var_542ac948a81d801e != -1 )
        {
            break;
        }
    }
    
    for ( i = 0; i < paths.size ; i++ )
    {
        if ( var_ffbb62be24d39d94 > var_5fc50ee230fbc57d[ i ] )
        {
            var_5aafe80737d71a45 = i;
            continue;
        }
        
        if ( var_5aafe80737d71a45 != -1 )
        {
            break;
        }
    }
    
    if ( var_5aafe80737d71a45 == -1 )
    {
        var_5aafe80737d71a45 = paths.size - 1;
    }
    
    if ( var_542ac948a81d801e == -1 )
    {
        var_542ac948a81d801e = 0;
    }
    
    /#
        println( "<dev string:x24>" + var_5aafe80737d71a45 + "<dev string:x59>" + var_542ac948a81d801e );
        println( "<dev string:x60>" + var_5fc50ee230fbc57d[ var_5aafe80737d71a45 ] + "<dev string:x6c>" + var_5fc50ee230fbc57d[ var_542ac948a81d801e ] );
        
        for ( i = 0; i < var_5fc50ee230fbc57d.size ; i++ )
        {
            println( "<dev string:x72>" + i + "<dev string:x7a>" + var_5fc50ee230fbc57d[ i ] );
        }
    #/
    
    var_ef42ac4f1e6905eb = 4;
    pathindices = [ var_5aafe80737d71a45, var_542ac948a81d801e ];
    
    for ( i = 0; i < var_ef42ac4f1e6905eb ; i++ )
    {
        if ( var_5aafe80737d71a45 - 1 - i <= 0 )
        {
            pathindices[ pathindices.size ] = paths.size - 1 - i;
        }
        else
        {
            pathindices[ pathindices.size ] = var_5aafe80737d71a45 - 1 - i;
        }
        
        if ( var_542ac948a81d801e + 1 + i >= paths.size )
        {
            pathindices[ pathindices.size ] = 0;
        }
        else
        {
            pathindices[ pathindices.size ] = var_542ac948a81d801e + 1 + i;
        }
        
        println( "<dev string:x7c>" + pathindices[ pathindices.size - 1 ] + "<dev string:x91>" + var_5fc50ee230fbc57d[ pathindices[ pathindices.size - 1 ] ] );
    }
    
    /#
        for ( i = 0; i < pathindices.size ; i++ )
        {
            println( "<dev string:x99>" + i + "<dev string:x7a>" + pathindices[ i ] );
        }
    #/
    
    for ( i = 0; i < pathindices.size ; i++ )
    {
        thread spawnhalfconvoyatpath( paths[ pathindices[ i ] ] );
    }
}

// Namespace br_convoy
// Params 1
// Checksum 0x56b5d73e, Offset: 0x976
// Size: 0x138
function spawnhalfconvoyatpath( path )
{
    level endon( #"game_ended" );
    goleft = 0;
    
    if ( isdefined( path.script_noteworthy ) )
    {
        if ( path.script_noteworthy == "left" )
        {
            goleft = 1;
        }
    }
    
    trucks = [];
    
    for ( j = 0; j < 2 ; j++ )
    {
        truck = spawntruck( path, path.angles, goleft );
        trucks[ trucks.size ] = truck;
        wait 1.333;
    }
    
    if ( level.mapname == "mp_torez" )
    {
        var_a2af0ac61e3134ee = 3;
        truckspeed = 17;
    }
    else
    {
        var_a2af0ac61e3134ee = 15;
        truckspeed = 25;
    }
    
    for ( j = 0; j < trucks.size ; j++ )
    {
        trucks[ j ] vehicle_setspeedimmediate( var_a2af0ac61e3134ee, 30, 30 );
    }
    
    wait 10;
    
    for ( j = 0; j < trucks.size ; j++ )
    {
        trucks[ j ] vehicle_setspeedimmediate( var_a2af0ac61e3134ee * 2, 30, 30 );
    }
    
    wait 4;
    
    for ( j = 0; j < trucks.size ; j++ )
    {
        trucks[ j ] vehicle_setspeedimmediate( truckspeed, 30, 30 );
    }
}

// Namespace br_convoy
// Params 1
// Checksum 0x6bc58140, Offset: 0xab6
// Size: 0xd4
function spawnconvoyatpath( path )
{
    level endon( #"game_ended" );
    goleft = 0;
    
    if ( isdefined( path.script_noteworthy ) )
    {
        if ( path.script_noteworthy == "left" )
        {
            goleft = 1;
        }
    }
    
    trucks = [];
    
    for ( j = 0; j < 4 ; j++ )
    {
        trucks[ trucks.size ] = spawntruck( path, path.angles, goleft );
        wait 1.333;
    }
    
    for ( j = 0; j < trucks.size ; j++ )
    {
        trucks[ j ] vehicle_setspeedimmediate( 15, 30, 30 );
    }
    
    wait 12;
    
    for ( j = 0; j < trucks.size ; j++ )
    {
        trucks[ j ] vehicle_setspeedimmediate( 25, 30, 30 );
    }
}

// Namespace br_convoy
// Params 3
// Checksum 0x8d749e16, Offset: 0xb92
// Size: 0xc8
function spawntruck( path, spawnori, left )
{
    vehicle = spawnvehicle( "veh8_mil_lnd_umike", "umike", "umike", path.origin, spawnori );
    vehicle.animname = "umikeVeh";
    vehicle vehicle_setspeedimmediate( 25, 30, 30 );
    vehicle thread vehiclefollowpath( path );
    vehicle setscriptablepartstate( "dustFX", "normal" );
    vehicle setscriptablepartstate( "exhaustFX", "active" );
    level.br_convoytrucks[ level.br_convoytrucks.size ] = vehicle;
    vehicle.playerslots = [];
    vehicle.br_leftspawn = left;
    return vehicle;
}

// Namespace br_convoy
// Params 1
// Checksum 0x4fba19b, Offset: 0xc63
// Size: 0x150
function vehiclefollowpath( path_node )
{
    self endon( #"death" );
    self endon( #"stop_follow_path" );
    self startpath( path_node );
    self playloopsound( "iw8_mp_snatch_convoy_lp" );
    
    for ( next_node = getvehiclenode( path_node.target, #targetname ); isdefined( next_node ) ; next_node = getvehiclenode( next_node.target, #targetname ) )
    {
        next_node waittill( #"trigger" );
        
        if ( !isdefined( next_node.target ) )
        {
            break;
        }
    }
    
    self vehicle_setspeed( 0, 30, 30 );
    
    for ( vel = self vehicle_getspeed(); vel > 1 ; vel = self vehicle_getspeed() )
    {
        wait 0.1;
    }
    
    self stoploopsound( "iw8_mp_snatch_convoy_lp" );
    self stoploopsound( "veh_technical_temp_surface" );
    level notify( #"infil_locked" );
    thread kickanyremainingplayers();
    wait 3;
    staticmodel = spawn( "script_model", self.origin );
    staticmodel setmodel( "veh8_mil_lnd_umike_static_allied" );
    staticmodel.angles = self.angles;
    objidpoolmanager::returnobjectiveid( self.objid );
    self delete();
}

// Namespace br_convoy
// Params 0
// Checksum 0xbfa9a302, Offset: 0xdbb
// Size: 0x19b
function spawnplayertoconvoy()
{
    if ( isalive( self ) )
    {
        if ( !isdefined( self.didnotselectclassintime ) )
        {
            if ( !br_public::isplayerbrsquadleader() )
            {
                return;
            }
        }
        
        if ( level.teambased )
        {
            playerteam = teams::getteamdata( self.team, "players" );
        }
        else
        {
            playerteam = [ self ];
        }
        
        foreach ( player in playerteam )
        {
            player notify( #"cancel_c130" );
            player notify( #"cancel_heli" );
            player unlink();
            
            if ( !isdefined( player.br_truck ) )
            {
                player.br_truck = getnexttruckwithroom( player.team );
                player.br_truck.playerslots[ player.br_truck.playerslots.size ] = player;
            }
            
            truck = player.br_truck;
            player.angles = truck.angles;
            
            if ( !isdefined( truck.showonminimap ) )
            {
                truck showicon();
                truck.showonminimap = 1;
            }
            
            player thread jumplistener( truck );
        }
    }
}

// Namespace br_convoy
// Params 1
// Checksum 0x13a5fa39, Offset: 0xf5e
// Size: 0x65
function jumplistener( truck )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"cancel_convoy" );
    self endon( #"br_jump" );
    self.br_infil_type = "convoy";
    thread orbitcam( truck );
    thread listenjump( truck );
    thread listenkick( truck );
}

// Namespace br_convoy
// Params 0
// Checksum 0x6e0d9e3c, Offset: 0xfcb
// Size: 0xb2
function kickanyremainingplayers()
{
    foreach ( p in self.playerslots )
    {
        if ( isdefined( p ) && p.br_infil_type == "convoy" )
        {
            p cameradefault();
            p unlink();
            p thread jumpout( self );
            p notify( #"br_jump" );
        }
    }
}

// Namespace br_convoy
// Params 1
// Checksum 0xc493485c, Offset: 0x1085
// Size: 0x5e
function listenkick( truck )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"cancel_c130" );
    self endon( #"cancel_heli" );
    self endon( #"br_jump" );
    self waittill( #"halo_kick_c130" );
    truck thread kickanyremainingplayers();
}

// Namespace br_convoy
// Params 1
// Checksum 0xc9b2b1b6, Offset: 0x10eb
// Size: 0x147
function listenjump( truck )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"cancel_convoy" );
    self endon( #"br_jump" );
    
    while ( true )
    {
        self waittill( #"halo_jump_c130" );
        
        if ( !br_public::isplayerbrsquadleader() )
        {
            continue;
        }
        
        if ( br_c130::ispointinbounds( truck.origin ) )
        {
            if ( br_public::isplayerbrsquadleader() )
            {
                teammates = teams::getteamdata( self.team, "players" );
                
                foreach ( p in teammates )
                {
                    if ( p != self )
                    {
                        p notify( #"halo_kick_c130" );
                    }
                }
                
                break;
            }
        }
        else
        {
            self iprintlnbold( &"mp_br_ingame/not_playable" );
        }
        
        waitframe();
    }
    
    self cameradefault();
    thread jumpout( truck );
    self notify( #"br_jump" );
}

// Namespace br_convoy
// Params 1
// Checksum 0xc86537d7, Offset: 0x123a
// Size: 0x26f
function jumpout( truck )
{
    self setclientomnvar( "ui_br_infiled", 1 );
    println( "<dev string:xa1>" );
    self.br_infil_type = undefined;
    lookangles = self getplayerangles();
    self unlink();
    
    if ( truck.br_leftspawn )
    {
        offset = anglestoleft( truck.angles ) * 180;
    }
    else
    {
        offset = anglestoright( truck.angles ) * 180;
    }
    
    fwd = anglestoforward( truck.angles );
    
    if ( !isdefined( truck.offloaded ) )
    {
        truck.offloaded = 0;
    }
    else
    {
        truck.offloaded++;
    }
    
    if ( truck.offloaded == 0 )
    {
        offset += fwd * 36;
    }
    else if ( truck.offloaded == 1 )
    {
        offset -= fwd * 36;
    }
    else if ( truck.offloaded == 2 )
    {
        offset += fwd * 72;
    }
    else
    {
        offset -= fwd * 72;
    }
    
    var_75a668e52554375 = truck.origin + offset + ( 0, 0, 18000 );
    contents = physics_createcontents( [ "physicscontents_glass", "physicscontents_water", "physicscontents_playerclip", "physicscontents_vehicleclip" ] );
    castresults = physics_raycast( var_75a668e52554375, var_75a668e52554375 + ( 0, 0, -1 ) * 20000, contents, undefined, 0, "physicsquery_closest", 1 );
    
    if ( isdefined( castresults ) && castresults.size > 0 )
    {
        castend = castresults[ 0 ][ "position" ];
        self setorigin( castend, 1, 1 );
    }
    else
    {
        self setorigin( truck.origin + offset, 1, 1 );
    }
    
    waitframe();
    var_51836eb91ec1676b = game[ "music" ][ "snatch_spawn" ].size;
    level.cur_infil_track = randomint( var_51836eb91ec1676b );
    self setplayermusicstate( game[ "music" ][ "snatch_spawn" ][ level.cur_infil_track ] );
    player_utility::function_b54a1e23734ef07();
    player_utility::function_4688d689820ff1ed( "br_convoy::jumpOut()" );
    self setplayerangles( lookangles );
    self notify( #"falldone" );
    parachute::parachutecompletedefault();
}

// Namespace br_convoy
// Params 1
// Checksum 0x4d7f6b0b, Offset: 0x14b1
// Size: 0x60
function orbitcam( truck )
{
    self.angles = truck.angles;
    self playerlinkto( truck, "tag_origin" );
    player_utility::function_dbe5a52a6654a982();
    player_utility::function_9d378d725bb4831e( "br_convoy::orbitCam()" );
    
    if ( !isai( self ) )
    {
        self visionsetnakedforplayer( "", 0 );
    }
    
    self cameraset( "camera_custom_orbit_1" );
}

// Namespace br_convoy
// Params 0
// Checksum 0xfbdb6cdb, Offset: 0x1519
// Size: 0x8c, Type: bool
function aretrucksvalid()
{
    foreach ( truck in level.br_convoytrucks )
    {
        if ( !( isdefined( truck ) && isdefined( truck.playerslots ) ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace br_convoy
// Params 1
// Checksum 0x4bdde774, Offset: 0x15ae
// Size: 0x1be
function getnexttruckwithroom( team )
{
    if ( level.teambased )
    {
        foreach ( truck in level.br_convoytrucks )
        {
            if ( truck.spawnteam == team && !istruckfull( truck ) )
            {
                return truck;
            }
        }
        
        foreach ( truck in level.br_convoytrucks )
        {
            if ( !isdefined( truck.spawnteam ) )
            {
                truck.spawnteam = team;
                return truck;
            }
        }
        
        return;
    }
    
    sortedtrucks = arraysort( level.br_convoytrucks, undefined, &sorttrucksize );
    
    foreach ( truck in sortedtrucks )
    {
        if ( !istruckfull( truck ) )
        {
            return truck;
        }
    }
}

// Namespace br_convoy
// Params 1
// Checksum 0x1fb34334, Offset: 0x1775
// Size: 0x1b, Type: bool
function istruckfull( truck )
{
    return truck.playerslots.size == 8;
}

// Namespace br_convoy
// Params 2
// Checksum 0x6947ea85, Offset: 0x1799
// Size: 0x2e, Type: bool
function sorttrucksize( a, b )
{
    return a.playerslots.size < b.playerslots.size;
}

// Namespace br_convoy
// Params 0
// Checksum 0x47973c23, Offset: 0x17d0
// Size: 0x8c
function showicon()
{
    curobjid = objidpoolmanager::requestobjectiveid( 10 );
    
    if ( curobjid == -1 )
    {
        return -1;
    }
    
    objidpoolmanager::objective_add_objective( curobjid, "invisible", ( 0, 0, 0 ) );
    objidpoolmanager::update_objective_onentitywithrotation( curobjid, self );
    objidpoolmanager::update_objective_state( curobjid, "active" );
    iconshader = "icon_minimap_bradley";
    objidpoolmanager::update_objective_icon( curobjid, iconshader );
    objidpoolmanager::update_objective_setbackground( curobjid, 1 );
    objidpoolmanager::objective_playermask_showtoall( curobjid );
    self.objid = curobjid;
}

