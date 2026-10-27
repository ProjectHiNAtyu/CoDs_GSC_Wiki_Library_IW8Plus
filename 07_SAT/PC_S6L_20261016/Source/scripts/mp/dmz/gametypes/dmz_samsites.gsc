// scripts\mp\dmz\gametypes\dmz_samsites.gsc  (hash_32cba61b15fa420b.gscc) (size: 31571 Bytes / 0x7b53 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7b9369d5 (2073258453)
// size ...... 31571 (0x7b53)
// includes .. 22  (offset: 0x752b)
// strings ... 82  (offset: 0x75db)
// dev strs .. 12  (offset: 0x7a9f)
// exports ... 56  (offset: 0x51eb)
// cseg ...... 0x704 + 0x4ae7 (0x51eb)
// imports ... 212 (offset: 0x5aab)
// animtree1 . 1   (offset: 0x7b33)
// animtree2 . 1   (offset: 0x7b43)
#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\scriptable;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\ai_reinforcements;
#using scripts\mp\br\gametypes\br_gametype_dmz;
#using scripts\mp\br\gametypes\br_supply_drops_common;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\damagefeedback;
#using scripts\mp\dmz\gametypes\dmz_audio;
#using scripts\mp\flags;
#using scripts\mp\gameobjects;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\parachute;
#using scripts\mp\poi;

#namespace dmz_samsites;

// Namespace dmz_samsites
// Params 0
// Checksum 0x279ae1de, Offset: 0x722
// Size: 0x8d6
function dmz_samsitesinitialize()
{
    if ( !getdvarint( @"scr_dmz_samsites", 1 ) )
    {
        return;
    }
    
    level.samsiteprops = spawnstruct();
    level.samsiteprops.minsamsites = getdvarint( @"scr_dmz_samsite_min", 3 );
    level.samsiteprops.maxsamsites = getdvarint( @"scr_dmz_samsite_max", 7 );
    level.samsiteprops.captureradius = getdvarint( @"scr_dmz_samsite_capture_radius", 512 );
    level.samsiteprops.capturemaxheight = getdvarint( @"hash_65a4247a6a99d511", 500 );
    level.samsiteprops.captureminheight = getdvarint( @"hash_a9b2ffcf64bcddf3", -50 );
    level.samsiteprops.capturetime = getdvarint( @"scr_dmz_samsite_capture_time", 60 );
    level.samsiteprops.blockingrange = getdvarint( @"hash_cc862f7d0a6c378f", 5000 );
    level.samsiteprops.blockingtime = getdvarint( @"hash_ab0966facf3e7683", 300 );
    level.samsiteprops.var_f3ca450ec5e034ec = getdvarint( @"hash_7a4c18bda90eae0c", 16000 );
    level.samsiteprops.var_85c78a0d4f8d1466 = getdvarint( @"scr_dmz_samsite_plane_range", 50000 );
    level.samsiteprops.reinforcementrange = getdvarint( @"hash_7ff620132228b8a9", 2500 );
    level.samsiteprops.trackhelis = getdvarint( @"hash_53eff3abae42511b", 1 );
    level.samsiteprops.trackplanes = getdvarint( @"hash_1b80b788c9c3da45", 1 );
    level.samsiteprops.var_2f62604f3869b48f = getdvarint( @"hash_a5b87d62ee975707", 1 );
    level.samsiteprops.var_62c77f8b6662de2b = getdvarint( @"hash_175730bcca744c75", 1 );
    level.samsiteprops.var_9c3ddeda5e3e041c = getdvarint( @"hash_e2c51295ca08d914", 3 );
    level.samsiteprops.var_40dee1f639a0389e = getdvarint( @"hash_fcaf02f59d6aa9ce", 5 );
    level.samsiteprops.var_85cc0db7a1e0dc02 = getdvarint( @"hash_3bb5a9c980d546d9", 8 );
    level.samsiteprops.enableplanes = getdvarint( @"hash_b6aaddbf47fc8db6", 1 );
    level.samsiteprops.var_5c104dec12a54b36 = getdvarint( @"hash_9134bb0c8c176121", 40 );
    level.samsiteprops.var_6f9c148041da644 = getdvarint( @"hash_b2bacdb9fac9e30f", 80 );
    level.samsiteprops.var_6803fbe8be4919f9 = getdvarint( @"hash_834c9ad109576fe1", 30 );
    level.samsiteprops.var_5c73eaaa929117f5 = getdvarint( @"hash_85b709709c5294ae", 1 );
    level.samsiteprops.showmissiles = getdvarint( @"hash_5a734e432dd09671", 1 );
    level.samsiteprops.forcefar = getdvarint( @"hash_bf8e2691659d83df", 1000000 );
    level.samsiteprops.forceclose = getdvarint( @"hash_ba806c360e59ef1e", 500000 );
    level.samsiteprops.travelspeed = getdvarint( @"hash_2d20c5ed21b56e40", 2000 );
    var_641f8db361c360 = getdvarint( @"hash_437436f2598f5eda", 200 );
    level.samsiteprops.var_4645acc525abda4 = var_641f8db361c360 * var_641f8db361c360;
    level.samsiteprops.var_a7edf6ab8504943c = getdvarint( @"hash_20928e0d72d6482a", 1 );
    level.samsiteprops.var_a7cb2b38826967e2 = getdvarfloat( @"hash_55f010da0dc36ab2", 0.5 );
    dmz_initanims();
    level._effect[ "samsite_bomb_explosion" ] = loadfxasset( "vfx_iw8_mp_gamemode_search_bombsite_destroy" );
    level.var_901f8acc520c0eb = &function_73bba066dd4c20d7;
    level.var_7b6fcaa8e75ec93e = &function_d6602625650d0c93;
    level.var_a24e0e8268fb96df = &function_8394ebc41f787bfe;
    scriptable::scriptable_addusedcallbackbypart( "dmz_samsite_base", &function_bf99b0386e2cdd48 );
    collisionarr = getentarray( "dmz_samsite_brushmodel", #script_noteworthy );
    
    if ( isdefined( collisionarr ) )
    {
        level.samsitecollision = collisionarr[ 0 ];
    }
    
    level.samsites = [];
    
    if ( level.samsiteprops.var_a7edf6ab8504943c )
    {
        level.var_a9310c674f1e9dcb = [];
        
        foreach ( team in level.teamnamelist )
        {
            start = level.teamdata[ team ][ "startPoint" ];
            
            if ( !isdefined( start ) )
            {
                continue;
            }
            
            subarea = utility::callsharedfunc( #"poi", #"hash_8dbb0d45f903ae1c", start.origin );
            
            if ( !isdefined( level.var_a9310c674f1e9dcb[ subarea.subareaname ] ) )
            {
                level.var_a9310c674f1e9dcb[ subarea.subareaname ] = [];
            }
            
            level.var_a9310c674f1e9dcb[ subarea.subareaname ][ level.var_a9310c674f1e9dcb[ subarea.subareaname ].size ] = start;
        }
        
        locations = utility::getstructarray( "dmz_samsite", "targetname" );
        ispoiactivedefined = poi::function_fbe74cc793e2b81b();
        level.var_281317f3f6246fc4 = [];
        var_8eb3aa68b058d333 = [];
        
        foreach ( location in locations )
        {
            areaname = utility::callsharedfunc( #"poi", #"area_findoriginisin", location.origin, 0 );
            
            if ( !isdefined( areaname ) )
            {
                continue;
            }
            
            location.score = function_c60d9773258f5495( location );
            
            if ( isdefined( var_8eb3aa68b058d333[ areaname ] ) && var_8eb3aa68b058d333.size > 0 )
            {
                if ( var_8eb3aa68b058d333[ areaname ].score < location.score )
                {
                    var_8eb3aa68b058d333[ areaname ] = location;
                }
                
                continue;
            }
            
            var_8eb3aa68b058d333[ areaname ] = location;
        }
        
        foreach ( node in var_8eb3aa68b058d333 )
        {
            level.var_281317f3f6246fc4[ level.var_281317f3f6246fc4.size ] = node;
        }
        
        numtospawn = randomintrange( level.samsiteprops.minsamsites, level.samsiteprops.maxsamsites + 1 );
        level.var_281317f3f6246fc4 = arrayrandomize( level.var_281317f3f6246fc4 );
        
        for ( spawnindex = 0; spawnindex < numtospawn && spawnindex < level.var_281317f3f6246fc4.size ; spawnindex++ )
        {
            node = level.var_281317f3f6246fc4[ spawnindex ];
            samsite = function_6cbc7895819671cc( node );
            samsite function_4e6725b99e06420f( node );
            numagents = randomintrange( level.samsiteprops.var_9c3ddeda5e3e041c, level.samsiteprops.var_40dee1f639a0389e + 1 );
            samsite thread function_346d365f6d1991dd( numagents );
        }
    }
    
    thread function_4961475e07efc36e();
    thread dmz_enableusability();
    
    /#
        thread debug_samsites();
    #/
}

// Namespace dmz_samsites
// Params 1
// Checksum 0x420b9aac, Offset: 0x1000
// Size: 0x183
function function_6cbc7895819671cc( node )
{
    samsite = function_74d42cec504f2bab( node );
    samsite function_b0d7d19d37fe74af();
    samsite.targetentity = spawn( "script_model", samsite.origin + ( 0, 0, 9000 ) + anglestoforward( samsite.angles ) * 10000 );
    samsite settargetentity( samsite.targetentity );
    samsite.curorigin = samsite.origin;
    samsite.offset3d = ( 0, 0, 100 );
    samsite.trackedents = [];
    samsite gameobjects::requestid( 1, 1, undefined, 1 );
    
    if ( level.samsiteprops.var_a7edf6ab8504943c )
    {
        objidpoolmanager::update_objective_icon( samsite.objidnum, "ui_map_icon_obj_sam_site" );
        objidpoolmanager::update_objective_setbackground( samsite.objidnum, 4 );
    }
    
    objective_setbackground( samsite.objidnum, 1 );
    objective_setpinned( samsite.objidnum, 1 );
    objective_position( samsite.objidnum, samsite.origin + ( 0, 0, 50 ) );
    objective_addalltomask( samsite.objidnum );
    objective_hidefromplayersinmask( samsite.objidnum );
    samsite thread function_de6507d2494ba5f5();
    return samsite;
}

// Namespace dmz_samsites
// Params 0
// Checksum 0xafeff31a, Offset: 0x118c
// Size: 0x100
function dmz_enableusability()
{
    level endon( #"game_ended" );
    flags::gameflagwait( "prematch_done" );
    
    foreach ( samsite in level.samsites )
    {
        foreach ( player in level.players )
        {
            samsite enablescriptableplayeruse( player );
        }
    }
}

#using_animtree( "script_model" );

// Namespace dmz_samsites
// Params 0
// Checksum 0x53109dc1, Offset: 0x1294
// Size: 0x78
function dmz_initanims()
{
    level.scr_animtree[ "samsite" ] = #animtree;
    level.scr_anim[ "samsite" ][ "fire" ] = level.br_anim[ "iw9_mp_prop_samsite_launch" ];
    animindex = "outro_gunship_death";
    level.scr_animtree[ "gunship" ] = #animtree;
    level.scr_anim[ "gunship" ][ animindex ] = %mp_acharlie130_death;
}

// Namespace dmz_samsites
// Params 1
// Checksum 0x41993715, Offset: 0x1314
// Size: 0xcd
function function_c60d9773258f5495( location )
{
    score = 0;
    
    if ( isdefined( level.var_a4d3926c7acf7918[ location.script_poi ] ) )
    {
        foreach ( start in level.var_a4d3926c7acf7918[ location.script_poi ] )
        {
            score += distancesquared( location.origin, start.origin );
        }
    }
    
    return score;
}

// Namespace dmz_samsites
// Params 1
// Checksum 0xa9e536d3, Offset: 0x13ea
// Size: 0x3bd
function function_74d42cec504f2bab( location )
{
    samsite = spawnturret( "misc_turret", location.origin, "dmz_sam_site_tur" );
    
    if ( !isdefined( location.angles ) )
    {
        location.angles = ( 0, 0, 0 );
    }
    
    samsite.angles = location.angles;
    samsite setmodel( "veh_rex_lnd_sam_site" );
    samsite settoparc( 90 );
    samsite setbottomarc( 0 );
    samsite setleftarc( 360 );
    samsite setrightarc( 360 );
    samsite setscriptablepartstate( "rex_dmz_samsite_base", "usable" );
    samsite.icon = spawnscriptable( "dmz_samsite_icon", samsite.origin, samsite.angles );
    samsite.icon setscriptablepartstate( "icon", "healthy" );
    
    if ( level.samsiteprops.var_a7edf6ab8504943c )
    {
        samsite.icon = spawnscriptable( "dmz_samsite_icon", samsite.origin, samsite.angles );
        samsite.icon setscriptablepartstate( "icon", "healthy" );
    }
    
    boundsorigin = samsite.origin + 35 * anglestoforward( samsite.angles );
    samsite.navobstacleid = createnavobstaclebybounds( boundsorigin, ( 150, 120, 200 ), samsite.angles );
    
    if ( isdefined( level.samsitecollision ) )
    {
        collision = spawn( "script_model", samsite.origin );
        collision dontinterpolate();
        collision.angles = samsite.angles;
        collision clonebrushmodeltoscriptmodel( level.samsitecollision );
        thread function_be118412c42e6e8( samsite, collision );
        collision setentityowner( samsite );
        collision disconnectpaths();
        collision.moverdoesnotkill = 1;
        collision.samsite = samsite;
        samsite.collision = collision;
        samsite validatecollision( collision, level.samsitecollision );
    }
    
    samsite maketurretinoperable();
    samsite.missilesfired = 0;
    samsite.script_poi = location.script_poi;
    samsite.shownplayers = [];
    
    if ( isdefined( location.script_poi ) )
    {
        samsite.script_poi = location.script_poi;
    }
    else
    {
        samsite.script_poi = poi::poi_findpoioriginisin( location.origin );
    }
    
    level.samsites[ level.samsites.size ] = samsite;
    tempnodes = utility::getstructarray( location.target, "targetname" );
    samsite.spawnernodes = [];
    
    foreach ( tempnode in tempnodes )
    {
        if ( isdefined( tempnode.script_noteworthy ) && issubstr( tempnode.script_noteworthy, "guard" ) )
        {
            samsite.spawnernodes[ samsite.spawnernodes.size ] = tempnode;
        }
    }
    
    return samsite;
}

// Namespace dmz_samsites
// Params 2
// Checksum 0xad25c3d, Offset: 0x17b0
// Size: 0xd1
function function_be118412c42e6e8( samsite, brushmodel )
{
    level endon( #"game_ended" );
    tag = "tag_aim_animated";
    offset = ( -14, 0, -88 );
    angleoffset = ( 30.5, 0, 0 );
    
    while ( isdefined( samsite ) && isdefined( brushmodel ) )
    {
        tagorigin = samsite gettagorigin( tag );
        tagangles = samsite gettagangles( tag );
        transformorigin = coordtransform( offset, tagorigin, tagangles );
        transformangles = combineangles( tagangles, angleoffset );
        brushmodel.origin = transformorigin;
        brushmodel.angles = transformangles;
        waitframe();
    }
}

// Namespace dmz_samsites
// Params 1
// Checksum 0xe9af26f3, Offset: 0x1889
// Size: 0x17
function function_f6e91d780c9a5ee2( index )
{
    return "mg0" + index + 1;
}

// Namespace dmz_samsites
// Params 1
// Checksum 0x79d8e80a, Offset: 0x18a9
// Size: 0x5f
function function_c33512c02a631fe6( num )
{
    if ( level.samsiteprops.showmissiles )
    {
        tag = function_f6e91d780c9a5ee2( num );
        self showpart( tag );
        self.missiles[ num ] = 1;
        return;
    }
    
    self.missiles[ num ] = 1;
}

// Namespace dmz_samsites
// Params 0
// Checksum 0x7d0de41d, Offset: 0x1910
// Size: 0x3c
function function_b0d7d19d37fe74af()
{
    if ( !isdefined( self.missiles ) )
    {
        self.missiles = [];
    }
    
    for ( i = 0; i < 4 ; i++ )
    {
        function_c33512c02a631fe6( i );
    }
}

// Namespace dmz_samsites
// Params 2
// Checksum 0x7852dfb5, Offset: 0x1954
// Size: 0x1ce
function function_5b17168668333ef2( missileindex, target )
{
    self endon( #"death" );
    tag = function_f6e91d780c9a5ee2( missileindex );
    
    if ( level.samsiteprops.showmissiles )
    {
        if ( !isdefined( self.missiles[ missileindex ] ) )
        {
            return;
        }
        
        self.missiles[ missileindex ] = undefined;
        self hidepart( tag );
    }
    else
    {
        if ( !isdefined( self.missiles[ missileindex ] ) )
        {
            return;
        }
        
        self.missiles[ missileindex ] = undefined;
    }
    
    self setscriptablepartstate( "launch", "on" );
    origin = self gettagorigin( tag );
    angles = self gettagangles( tag );
    forward = anglestoforward( angles );
    fakefireweapon = makeweapon( "samsite_missile_weapon" );
    owner = undefined;
    
    if ( isdefined( self.owningteam ) && isdefined( teams::getteamdata( self.owningteam, "players" ) ) )
    {
        players = teams::getteamdata( self.owningteam, "players" );
        
        if ( players.size > 0 )
        {
            owner = players[ 0 ];
        }
    }
    
    proj = weapon_utility::_magicbullet( fakefireweapon, origin, origin + forward * 1000, owner );
    self.proj = proj;
    proj.samsite = self;
    proj setmodel( "military_dmz_sam_site_missile" );
    proj setentityowner( self );
    proj.owningteam = self.owningteam;
    self.missilesfired++;
    proj setscriptablepartstate( "rex_military_samsite_missile", "on" );
    proj thread dmz_lockontarget( target );
    proj thread function_de72ee61b0e1fe89( target );
}

// Namespace dmz_samsites
// Params 1
// Checksum 0xcbdb15d, Offset: 0x1b2a
// Size: 0x137
function dmz_lockontarget( target )
{
    if ( isdefined( target ) && isdefined( target.ent ) && isdefined( self ) )
    {
        if ( target.type == 0 )
        {
            self missile_settargetent( target.ent, ( 0, 0, -100 ) );
        }
        else if ( target.type == 1 )
        {
            self missile_settargetent( target.ent, ( level.samsiteprops.travelspeed, 0, 0 ) );
        }
        else if ( target.type == 2 )
        {
            self missile_settargetent( target.ent, ( 0, 0, -100 ) );
        }
        else if ( target.type == 3 )
        {
            self missile_settargetent( target.ent, ( 0, 0, -100 ) );
        }
        
        self missile_setflightmodedirect();
        self.lockontarget = target.ent;
        thread weapon_utility::watchtargetlockedontobyprojectile( target.ent, self );
        wait 4;
        
        if ( isdefined( self ) )
        {
            self notify( #"cleartargetlockedontobyprojectile" );
        }
    }
}

// Namespace dmz_samsites
// Params 1
// Checksum 0x3cf14d32, Offset: 0x1c69
// Size: 0xd9
function function_de72ee61b0e1fe89( target )
{
    level endon( #"game_ended" );
    
    if ( isdefined( target ) && target.type == 1 )
    {
        while ( true )
        {
            if ( !( isdefined( self ) && isdefined( target ) && isdefined( target.ent ) ) )
            {
                return;
            }
            
            dist = distance( target.ent.origin, self.origin );
            
            if ( dist < 600 )
            {
                thread function_c86f262fe0a3998f( target.ent, self.owningteam );
                utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"samsite_plane_hit", self.owningteam );
                self delete();
                return;
            }
            
            waitframe();
        }
    }
}

// Namespace dmz_samsites
// Params 2
// Checksum 0x14d606cc, Offset: 0x1d4a
// Size: 0x71
function function_c86f262fe0a3998f( plane, team )
{
    level.samsiteprops.hitplane = 1;
    
    if ( !plane.hit )
    {
        plane notify( #"plane_hit", team );
        plane setcandamage( 0 );
        plane.hit = 1;
        plane function_6533d0afe610d5c7();
        plane dmz_removeplane();
    }
}

// Namespace dmz_samsites
// Params 1
// Checksum 0x891723ef, Offset: 0x1dc3
// Size: 0x8e
function function_4d8786a6d818067d( target )
{
    if ( !isdefined( self.nextmissile ) )
    {
        self.nextmissile = 0;
    }
    
    thread function_5b17168668333ef2( self.nextmissile, target );
    self.nextmissile = ( self.nextmissile + 1 ) % 4;
    wait 1;
    
    if ( self.nextmissile == 0 && self.missilesfired < level.samsiteprops.var_85cc0db7a1e0dc02 )
    {
        wait 5;
        function_b0d7d19d37fe74af();
    }
}

// Namespace dmz_samsites
// Params 0
// Checksum 0xaf8ed605, Offset: 0x1e59
// Size: 0x3d
function function_963100cb36425e87()
{
    while ( true )
    {
        thread function_5b17168668333ef2( 0 );
        wait 5;
        thread function_5b17168668333ef2( 1 );
        wait 5;
        thread function_5b17168668333ef2( 2 );
        function_b0d7d19d37fe74af();
        wait 5;
    }
}

// Namespace dmz_samsites
// Params 1
// Checksum 0xb70527a7, Offset: 0x1e9e
// Size: 0x141
function function_e2dfb2a4ace0d825( target )
{
    velocity = undefined;
    origin = undefined;
    
    if ( target.type == 0 )
    {
        heli = target.ent;
        velocity = heli vehicle_getvelocity();
        origin = heli.occupants[ "driver" ].origin;
    }
    else if ( target.type == 1 )
    {
        c130 = target.ent;
        velocity = c130.velocity;
        origin = c130.origin;
    }
    else if ( target.type == 2 || target.type == 3 )
    {
        heli = target.ent;
        velocity = heli vehicle_getvelocity();
        origin = heli.origin;
    }
    
    if ( !( isdefined( velocity ) && isdefined( origin ) ) )
    {
        return;
    }
    
    dist = distance( self.origin, origin );
    missilespeed = 6000;
    var_82716364a2d08b10 = dist / missilespeed;
    return origin + velocity * var_82716364a2d08b10;
}

// Namespace dmz_samsites
// Params 1
// Checksum 0xfb147479, Offset: 0x1fe8
// Size: 0x22a, Type: bool
function function_7dae5d87ede6046b( target )
{
    var_ef07b06bb962cc6c = 50;
    var_ce9e03eb22a63ff2 = 50;
    duration = 5;
    timer = 0;
    var_97e3fa7cbf9fd75c = 0;
    
    while ( timer < duration && isdefined( self.owningteam ) )
    {
        if ( !( isdefined( target ) && isdefined( target.ent ) ) || !function_3b9c8758c4ab4825( target ) )
        {
            return false;
        }
        
        origin = target.ent.origin;
        ignored = [ self ];
        aimorigin = self gettagorigin( "tag_aim_animated" );
        trace = trace::ray_trace( aimorigin, origin, ignored, undefined, 0, 1 );
        tracedist = distance( self.origin, origin ) * ( 1 - trace[ "fraction" ] );
        
        if ( tracedist > 200 )
        {
            return false;
        }
        
        if ( isdefined( self.entlockedonto ) && self.entlockedonto != target.ent )
        {
            weapon_utility::removelockedon( target.ent, self );
        }
        
        if ( !isdefined( self.entlockedonto ) )
        {
            weapon_utility::addlockedon( target.ent, self );
        }
        
        origin = function_e2dfb2a4ace0d825( target );
        
        if ( !isdefined( origin ) )
        {
            return false;
        }
        
        targetdir = vectornormalize( origin - aimorigin ) * 1000;
        self.targetentity.origin = aimorigin + targetdir;
        tagdir = anglestoforward( self gettagangles( "tag_aim_animated" ) ) * 1000;
        angle = math::anglebetweenvectors( origin - aimorigin, tagdir );
        
        if ( abs( angle ) > 15 && !var_97e3fa7cbf9fd75c )
        {
            self setscriptablepartstate( "lock_start_audio", "on" );
            var_97e3fa7cbf9fd75c = 1;
        }
        
        if ( abs( angle ) < 5 )
        {
            return true;
        }
        
        timer += level.framedurationseconds;
        waitframe();
    }
    
    return false;
}

// Namespace dmz_samsites
// Params 1
// Checksum 0x2082db7c, Offset: 0x221b
// Size: 0x141
function function_2164f1395bc0b7fe( target )
{
    if ( self.missilesfired < level.samsiteprops.var_85cc0db7a1e0dc02 )
    {
        if ( target.type == 1 )
        {
            utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"samsite_nearby_plane", self.owningteam );
        }
        else if ( target.type == 0 )
        {
            utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"samsite_enemy_heli", self.owningteam );
        }
        
        self setscriptablepartstate( "audio", "rotate_start" );
        shouldfire = function_7dae5d87ede6046b( target );
        self setscriptablepartstate( "audio", "rotate_stop" );
        
        if ( isdefined( target.ent ) && target.ent.attackerslockedon[ self getentitynumber() ] == self )
        {
            weapon_utility::removelockedon( target.ent, self );
        }
        
        if ( shouldfire )
        {
            self setscriptablepartstate( "lock_fire_audio", "on" );
            wait 0.3;
            function_4d8786a6d818067d( target );
        }
    }
}

// Namespace dmz_samsites
// Params 1
// Checksum 0xc689c52a, Offset: 0x2364
// Size: 0x1e0
function function_3b9c8758c4ab4825( target )
{
    switch ( target.type )
    {
        case 0:
            heli = target.ent;
            return ( heli.occupants.size && isdefined( self.owningteam ) && isdefined( heli.occupants[ "driver" ] ) && heli.occupants[ "driver" ].team != self.owningteam && distance( heli.origin, self.origin ) < level.samsiteprops.var_f3ca450ec5e034ec );
        case 1:
            c130 = target.ent;
            return ( isdefined( self.owningteam ) && distance2d( c130.origin, self.origin ) < level.samsiteprops.var_85c78a0d4f8d1466 && !istrue( c130.hit ) );
        case 2:
            heli = target.ent;
            return ( isdefined( self.owningteam ) && distance( heli.origin, self.origin ) < level.samsiteprops.var_f3ca450ec5e034ec );
        case 3:
            heli = target.ent;
            return ( isdefined( self.owningteam ) && distance( heli.origin, self.origin ) < level.samsiteprops.var_f3ca450ec5e034ec );
    }
}

// Namespace dmz_samsites
// Params 1
// Checksum 0x8326d518, Offset: 0x254c
// Size: 0x5c
function dmz_targetpriority( target )
{
    switch ( target.type )
    {
        case 0:
            return 100;
        case 1:
            return 200;
        case 2:
            return 300;
        case 3:
            return 50;
    }
}

// Namespace dmz_samsites
// Params 0
// Checksum 0x384f3c58, Offset: 0x25b0
// Size: 0x156
function function_de6507d2494ba5f5()
{
    level endon( #"game_ended" );
    
    if ( getdvarint( @"hash_e7366d21f0d5d8a0", 1 ) == 0 )
    {
        return;
    }
    
    while ( true )
    {
        isowned = isdefined( self.owningteam );
        
        if ( isowned && isdefined( self.trackedents ) && self.trackedents.size > 0 )
        {
            besttarget = undefined;
            var_8d0ce1a25c2a79c0 = [];
            priority = 0;
            
            foreach ( target in self.trackedents )
            {
                if ( isdefined( target.ent ) && function_3b9c8758c4ab4825( target ) )
                {
                    var_8d0ce1a25c2a79c0[ var_8d0ce1a25c2a79c0.size ] = target;
                    targetpriority = dmz_targetpriority( target );
                    
                    if ( priority <= targetpriority )
                    {
                        besttarget = target;
                        priority = targetpriority;
                    }
                }
            }
            
            self.trackedents = var_8d0ce1a25c2a79c0;
            
            if ( isdefined( besttarget ) )
            {
                function_2164f1395bc0b7fe( besttarget );
            }
        }
        
        wait 2;
    }
}

// Namespace dmz_samsites
// Params 1
// Checksum 0xa69271e5, Offset: 0x270e
// Size: 0xe7
function function_4e6725b99e06420f( location )
{
    self.snipernodes = [];
    
    if ( isdefined( location.target ) )
    {
        nodes = utility::getstructarray( location.target, "targetname" );
        
        foreach ( node in nodes )
        {
            switch ( node.script_noteworthy )
            {
                case #"hash_67ba230fb131ff98":
                    self.snipernodes[ self.snipernodes.size ] = node;
                    break;
            }
        }
    }
}

// Namespace dmz_samsites
// Params 1
// Checksum 0x54ed5b3b, Offset: 0x27fd
// Size: 0x129
function function_346d365f6d1991dd( numagents )
{
    while ( !( isdefined( level.struct_class_names ) && isdefined( level.aibudgets ) ) || function_7c7f41d3fd5028a5( "everybody" ) <= 0 )
    {
        waitframe();
    }
    
    self.numagents = 0;
    self.agents = [];
    
    if ( self.spawnernodes.size >= 3 )
    {
        foreach ( node in self.spawnernodes )
        {
            agent = ai_mp_controller::spawnguard( node, undefined, "medium", "mission", "samInitialGuards", self.subarea );
            
            if ( isdefined( agent ) )
            {
                self.agents[ self.agents.size ] = agent;
            }
        }
    }
    
    self.numagents = self.agents.size;
}

// Namespace dmz_samsites
// Params 6
// Checksum 0xf41003da, Offset: 0x292e
// Size: 0x29c
function function_bf99b0386e2cdd48( instance, part, state, useplayer, bautouse, usestring )
{
    if ( !dmz_samsitecanuse( useplayer ) )
    {
        useplayer hud_message::showerrormessage( level.br_pickups.var_9d247aba85e39454 );
        return;
    }
    
    samsite = instance.entity;
    
    if ( isdefined( samsite.capturingteam ) )
    {
        var_437b7aa5a596fbc2 = teams::getteamdata( samsite.capturingteam, "players" );
        
        foreach ( player in var_437b7aa5a596fbc2 )
        {
            if ( isdefined( player ) )
            {
                objective_hideprogressforclient( samsite.objidnum, player );
                objective_setshowpinnedprogressbar( 0, player );
            }
        }
    }
    
    playersonteam = teams::getteamdata( useplayer.team, "players" );
    
    foreach ( player in level.players )
    {
        instance enablescriptableplayeruse( player );
    }
    
    foreach ( player in playersonteam )
    {
        instance disablescriptableplayeruse( player );
    }
    
    samsite.capturingplayer = useplayer;
    samsite.capturingteam = useplayer.team;
    samsite notify( #"start_capture" );
    dmz_audio::function_32ff837bc21a4833( useplayer.team, "dmz_activity_action", 1, "dmz_activity_action_classic" );
    samsite thread function_de160f7b9e5f029();
    samsite thread function_e17e300ac07b99c( samsite );
    samsite function_b3d8ab264a25f534();
    samsite thread function_e3d317b11fd0846d();
}

// Namespace dmz_samsites
// Params 0
// Checksum 0x78174766, Offset: 0x2bd2
// Size: 0x8a
function function_b3d8ab264a25f534()
{
    foreach ( player in self.shownplayers )
    {
        if ( isdefined( player ) )
        {
            objidpoolmanager::function_6ac40386d1cd0d9a( self.objidnum, player );
        }
    }
}

// Namespace dmz_samsites
// Params 0
// Checksum 0xe21d5c06, Offset: 0x2c64
// Size: 0x6f0
function function_e3d317b11fd0846d()
{
    self endon( #"start_capture" );
    level endon( #"game_ended" );
    playersonteam = teams::getteamdata( self.capturingteam, "players" );
    utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"samsite_begin_capture", self.capturingteam );
    objective_removeallfrommask( self.objidnum );
    
    foreach ( player in playersonteam )
    {
    }
    
    objective_showtoplayersinmask( self.objidnum );
    waitframe();
    objective_setplayintro( self.objidnum, 0 );
    self.stolenagents = ai_reinforcements::function_d0a9530035c6dc35( self.origin, level.samsiteprops.reinforcementrange );
    
    if ( self.stolenagents.size < 5 )
    {
        thread dmz_callreinforcements();
    }
    
    starttime = gettime();
    timesincestart = 0;
    duration = level.samsiteprops.capturetime * 1000;
    
    if ( !level.samsiteprops.var_a7edf6ab8504943c && isdefined( self.owningteam ) )
    {
        duration *= level.samsiteprops.var_a7cb2b38826967e2;
    }
    
    self.shownplayers = [];
    
    while ( timesincestart < duration )
    {
        incircle = 0;
        playersonteam = teams::getteamdata( self.capturingteam, "players" );
        
        if ( !isdefined( playersonteam ) || playersonteam.size == 0 )
        {
            objective_addalltomask( self.objidnum );
            objective_hidefromplayersinmask( self.objidnum );
            self.capturingteam = undefined;
            return;
        }
        
        foreach ( player in playersonteam )
        {
            if ( player::isreallyalive( player ) && isdefined( player.origin ) )
            {
                dist = distance2dsquared( player.origin, self.origin );
                heightdiff = player.origin[ 2 ] - self.origin[ 2 ];
                heightcheck = level.samsiteprops.captureminheight <= heightdiff && heightdiff <= level.samsiteprops.capturemaxheight;
                
                if ( dist < level.samsiteprops.captureradius * level.samsiteprops.captureradius && heightcheck )
                {
                    incircle = 1;
                    
                    if ( !arraycontains( self.shownplayers, player ) )
                    {
                        objidpoolmanager::objective_playermask_addshowplayer( self.objidnum, player );
                        objidpoolmanager::function_72efeaceb614613a( self.objidnum, player, 1, 2, &"dmz/samsite_capture_progress" );
                        self.shownplayers[ self.shownplayers.size ] = player;
                    }
                    
                    objective_addclienttomask( self.objidnum, player );
                    continue;
                }
                
                if ( arraycontains( self.shownplayers, player ) )
                {
                    objidpoolmanager::objective_playermask_hidefrom( self.objidnum, player );
                    objidpoolmanager::function_6ac40386d1cd0d9a( self.objidnum, player );
                    self.shownplayers = arrayremove( self.shownplayers, player );
                }
            }
        }
        
        if ( incircle )
        {
            timesincestart += level.frameduration;
            progress = min( timesincestart / duration, 1 );
            objective_setprogress( self.objidnum, progress );
            objective_showtoplayersinmask( self.objidnum );
        }
        
        waitframe();
    }
    
    self notify( #"captured" );
    function_b3d8ab264a25f534();
    objective_addalltomask( self.objidnum );
    objective_hidefromplayersinmask( self.objidnum );
    var_bd0c73bc205cd4ee = level.poi[ self.script_poi ][ "players" ];
    playersonteam = teams::getteamdata( self.capturingteam, "players" );
    var_bd0c73bc205cd4ee = arrayremove( var_bd0c73bc205cd4ee, playersonteam );
    br_gametype_dmz::showdmzsplash( "dmz_samsite_captured", playersonteam, self.script_poi );
    br_gametype_dmz::showdmzsplash( "dmz_samsite_captured_others", var_bd0c73bc205cd4ee, self.script_poi );
    
    if ( isdefined( self.owningteam ) )
    {
        var_a443461ced2d8438 = teams::getteamdata( self.owningteam, "players" );
        var_bd0c73bc205cd4ee = arrayremove( var_bd0c73bc205cd4ee, var_a443461ced2d8438 );
        utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"samsite_counter_capture", self.owningteam );
        self.icon setscriptablepartstate( "icon", "healthy" );
        waitframe();
    }
    
    utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"samsite_others_captured", var_bd0c73bc205cd4ee, 2 );
    utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"samsite_captured", self.capturingteam, 2 );
    dmz_audio::function_1219191cbcd38758( var_bd0c73bc205cd4ee, "dmz_activity_tension", 0, "dmz_activity_tension_classic" );
    dmz_audio::function_32ff837bc21a4833( self.capturingteam, "dmz_activity_win", 1.5, "dmz_activity_win_classic" );
    self.owningteam = self.capturingteam;
    self.capturingteam = undefined;
    callback::callback( "team_engaged_activity", { #poi:self.script_poi, #iscompletion:1, #activityref:"samsite", #team:self.owningteam } );
    
    if ( level.samsiteprops.var_a7edf6ab8504943c )
    {
        self.icon setscriptablepartstate( "icon", "attacked" );
        self.icon function_474bcbb86b733bef( "icon", self.owningteam );
    }
    else if ( utility::issharedfuncdefined( #"samsite", #"oncapturedchange" ) )
    {
        [[ utility::getsharedfunc( #"samsite", #"oncapturedchange" ) ]]( self );
    }
    
    thread function_674ee506153d7fab();
}

// Namespace dmz_samsites
// Params 1
// Checksum 0xd4d7b234, Offset: 0x335c
// Size: 0xe3
function function_6603bd4e910774d6( pos )
{
    scale = randomfloatrange( 20, 60 );
    locvec = scale * level.samsiteprops.travelspeed * vectornormalize2( math::random_vector_2d() );
    minpos = ( pos[ 0 ] - locvec[ 0 ], pos[ 1 ] - locvec[ 1 ], parachute::getc130height() );
    maxpos = ( pos[ 0 ] + locvec[ 0 ], pos[ 1 ] + locvec[ 1 ], parachute::getc130height() );
    pathdir = vectornormalize( maxpos - minpos );
    pathstruct = spawnstruct();
    pathstruct.startpt = minpos;
    pathstruct.endpt = maxpos;
    pathstruct.angle = vectortoangles( pathdir );
    return pathstruct;
}

// Namespace dmz_samsites
// Params 0
// Checksum 0xb3766483, Offset: 0x3448
// Size: 0x1be
function function_674ee506153d7fab()
{
    level endon( #"game_ended" );
    self endon( #"captured" );
    
    if ( level.samsiteprops.blockingtime < 0 )
    {
        return;
    }
    
    blockingtime = level.samsiteprops.blockingtime;
    
    if ( isdefined( self.capturingplayer ) )
    {
        upgradecount = utility::callsharedfunc( #"instanceInventory", #"getupgradecount", self.capturingplayer, 26 ) ?? 0;
        blockingtime += upgradecount * getdvarfloat( @"hash_fe5eb9987b622e18", 30 );
    }
    
    wait blockingtime;
    playersonteam = teams::getteamdata( self.owningteam, "players" );
    br_gametype_dmz::showdmzsplash( "dmz_samsite_lost", playersonteam, self.script_poi );
    utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"samsite_capture_over", self.owningteam, 2 );
    dmz_audio::function_32ff837bc21a4833( self.owningteam, "dmz_activity_lose", 0, "dmz_activity_lose_classic" );
    
    foreach ( player in playersonteam )
    {
        self enablescriptableplayeruse( player );
    }
    
    self.icon setscriptablepartstate( "icon", "healthy" );
    self.owningteam = undefined;
}

// Namespace dmz_samsites
// Params 0, eflags: 0x4
// Checksum 0xe3611e69, Offset: 0x360e
// Size: 0x61
function private dmz_callreinforcements()
{
    level endon( #"game_ended" );
    agents = undefined;
    
    while ( !isdefined( agents ) )
    {
        agents = ai_reinforcements::reinforce_requestreinforcements( 5, self.origin, "medium", "mission", "samReinforcements", undefined, undefined, 1, self.script_poi );
        
        if ( !isdefined( agents ) )
        {
            wait 1;
        }
    }
}

// Namespace dmz_samsites
// Params 2
// Checksum 0xd08e8a57, Offset: 0x3677
// Size: 0x43
function function_a9cc8b1d8a1ff89d( ent, type )
{
    trackedobj = spawnstruct();
    trackedobj.ent = ent;
    trackedobj.type = type;
    return trackedobj;
}

// Namespace dmz_samsites
// Params 2
// Checksum 0x47a33c35, Offset: 0x36c3
// Size: 0x9c, Type: bool
function function_61f09ff2f7bd0f7c( samsite, ent )
{
    foreach ( tracked in samsite.trackedents )
    {
        if ( tracked.ent == ent )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace dmz_samsites
// Params 5
// Checksum 0x402b1e08, Offset: 0x3768
// Size: 0x39
function function_73bba066dd4c20d7( vehicle, seatid, oldseatid, player, data )
{
    vehicle thread function_ddfabc619ee65c11();
}

// Namespace dmz_samsites
// Params 1
// Checksum 0x27bbfc86, Offset: 0x37a9
// Size: 0x1e
function function_d6602625650d0c93( chopperinstance )
{
    chopperinstance.chopper thread function_196139004bb925a5();
}

// Namespace dmz_samsites
// Params 1
// Checksum 0x543a2ffd, Offset: 0x37cf
// Size: 0x15
function function_8394ebc41f787bfe( heli )
{
    heli thread function_ba338a496a75408e();
}

// Namespace dmz_samsites
// Params 0
// Checksum 0x4aaf8af9, Offset: 0x37ec
// Size: 0x172
function function_ddfabc619ee65c11()
{
    level endon( #"game_ended" );
    
    if ( !level.samsiteprops.trackhelis )
    {
        return;
    }
    
    while ( isdefined( self ) && self.occupants.size > 0 )
    {
        foreach ( samsite in level.samsites )
        {
            if ( isdefined( samsite.owningteam ) && isdefined( self.occupants[ "driver" ] ) && samsite.owningteam != self.occupants[ "driver" ].team && distancesquared( samsite.origin, self.origin ) < level.samsiteprops.var_f3ca450ec5e034ec * level.samsiteprops.var_f3ca450ec5e034ec && !function_61f09ff2f7bd0f7c( samsite, self ) )
            {
                samsite.trackedents[ samsite.trackedents.size ] = function_a9cc8b1d8a1ff89d( self, 0 );
            }
        }
        
        wait 5;
    }
}

// Namespace dmz_samsites
// Params 0
// Checksum 0x5e11ec41, Offset: 0x3966
// Size: 0x135
function function_ba338a496a75408e()
{
    level endon( #"game_ended" );
    
    if ( !level.samsiteprops.var_62c77f8b6662de2b )
    {
        return;
    }
    
    while ( isdefined( self ) && !self.unloaded )
    {
        foreach ( samsite in level.samsites )
        {
            if ( isdefined( samsite.owningteam ) && distancesquared( samsite.origin, self.origin ) < level.samsiteprops.var_f3ca450ec5e034ec * level.samsiteprops.var_f3ca450ec5e034ec && !function_61f09ff2f7bd0f7c( samsite, self ) )
            {
                samsite.trackedents[ samsite.trackedents.size ] = function_a9cc8b1d8a1ff89d( self, 3 );
            }
        }
        
        wait 5;
    }
}

// Namespace dmz_samsites
// Params 0
// Checksum 0xee6b6c8e, Offset: 0x3aa3
// Size: 0x134
function function_196139004bb925a5()
{
    level endon( #"game_ended" );
    
    if ( !level.samsiteprops.var_2f62604f3869b48f )
    {
        return;
    }
    
    self waittill( #"sam_track" );
    
    while ( isdefined( self ) )
    {
        foreach ( samsite in level.samsites )
        {
            if ( isdefined( samsite.owningteam ) && distancesquared( samsite.origin, self.origin ) < level.samsiteprops.var_f3ca450ec5e034ec * level.samsiteprops.var_f3ca450ec5e034ec && !function_61f09ff2f7bd0f7c( samsite, self ) )
            {
                samsite.trackedents[ samsite.trackedents.size ] = function_a9cc8b1d8a1ff89d( self, 2 );
            }
        }
        
        wait 5;
    }
}

// Namespace dmz_samsites
// Params 0
// Checksum 0xe3c3094b, Offset: 0x3bdf
// Size: 0x11f
function function_5f55c587fefd18c1()
{
    level endon( #"game_ended" );
    
    if ( !level.samsiteprops.trackplanes )
    {
        return;
    }
    
    while ( isdefined( self ) )
    {
        foreach ( samsite in level.samsites )
        {
            dist = distance2d( samsite.origin, self.origin );
            
            if ( isdefined( samsite.owningteam ) && dist < level.samsiteprops.var_85c78a0d4f8d1466 && !function_61f09ff2f7bd0f7c( samsite, self ) )
            {
                samsite.trackedents[ samsite.trackedents.size ] = function_a9cc8b1d8a1ff89d( self, 1 );
            }
        }
        
        wait 5;
    }
}

// Namespace dmz_samsites
// Params 0
// Checksum 0x31b2ded2, Offset: 0x3d06
// Size: 0x1e1
function function_c7b1c26303da1b77()
{
    level endon( #"game_ended" );
    self endon( #"deleted" );
    
    while ( true )
    {
        self waittill( #"damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor );
        self.health += damage;
        
        if ( isdefined( idflags ) && idflags & 8 )
        {
            self.wasdamagedfrombulletpenetration = 1;
        }
        
        if ( isdefined( idflags ) && idflags & 256 )
        {
            self.wasdamagedfrombulletricochet = 1;
        }
        
        modifieddamage = int( damage );
        
        if ( isdefined( objweapon ) )
        {
            class = weaponclass( objweapon );
            
            if ( class == "rocketlauncher" )
            {
                modifieddamage += int( self.maxhealth / 2 );
            }
        }
        
        self.wasdamaged = 1;
        self.damagetaken += modifieddamage;
        self.health -= modifieddamage;
        isdeath = self.health <= 0;
        
        if ( isplayer( attacker ) )
        {
            attacker damagefeedback::updatehitmarker( "standard", isdeath, 0, 1 );
        }
        
        if ( isdeath )
        {
            team = undefined;
            
            if ( isdefined( attacker ) )
            {
                team = attacker.team;
            }
            
            thread function_c86f262fe0a3998f( self, team );
            return;
        }
    }
}

// Namespace dmz_samsites
// Params 2
// Checksum 0x5b114180, Offset: 0x3eef
// Size: 0xae
function function_2b05b1e3a12c5039( plane, time )
{
    level endon( #"game_ended" );
    plane endon( #"plane_hit" );
    plane endon( #"death" );
    time = time >= 1 ? time : 1;
    wait time - 1;
    
    if ( level.samsiteprops.var_5c73eaaa929117f5 )
    {
        plane setscriptablepartstate( "audio_exit", "on", 0 );
    }
    
    wait 1;
    
    if ( level.samsiteprops.var_5c73eaaa929117f5 )
    {
        plane setscriptablepartstate( "audio_loop", "off", 0 );
    }
    
    plane thread dmz_removeplane();
}

// Namespace dmz_samsites
// Params 0
// Checksum 0xa3fb5e45, Offset: 0x3fa5
// Size: 0xe4
function function_8724355defbeec36()
{
    if ( !isdefined( level.mapname ) )
    {
        return ( randomfloatrange( -30000, 30000 ), randomfloatrange( -30000, 30000 ), 0 );
    }
    
    switch ( level.mapname )
    {
        case #"hash_57eba45b7ddbdcd6":
        case #"hash_63326ac3e12f8da0":
            return ( randomfloatrange( -30000, 30000 ), randomfloatrange( -30000, 30000 ), 0 );
        case #"hash_4617d802bdced46":
        case #"hash_a82a4d91a314a926":
            return ( randomfloatrange( -3000, 2000 ), randomfloatrange( -10000, 0 ), 0 );
        case #"hash_3eff14ec1d9395c1":
        case #"hash_e817308cc606e9e1":
            return ( randomfloatrange( -15000, 15000 ), randomfloatrange( -10000, 0 ), 0 );
        default:
            return ( randomfloatrange( -30000, 30000 ), randomfloatrange( -30000, 30000 ), 0 );
    }
}

// Namespace dmz_samsites
// Params 0
// Checksum 0xa2039f88, Offset: 0x4091
// Size: 0x102
function function_4961475e07efc36e()
{
    level endon( #"game_ended" );
    flags::gameflagwait( "prematch_done" );
    
    if ( !level.samsiteprops.enableplanes )
    {
        return;
    }
    
    if ( !( isdefined( level.br_level ) && isdefined( level.br_level.br_mapboundsfull ) ) )
    {
        return;
    }
    
    level.currentplane = undefined;
    spawntime = 0;
    
    while ( true )
    {
        if ( !isdefined( level.currentplane ) )
        {
            if ( level.samsiteprops.hitplane )
            {
                level.samsiteprops.hitplane = undefined;
                wait level.samsiteprops.var_6803fbe8be4919f9;
            }
            
            wait randomfloatrange( level.samsiteprops.var_5c104dec12a54b36, level.samsiteprops.var_6f9c148041da644 );
            level.currentplane = dmz_spawnplane();
        }
        
        wait 5;
    }
}

// Namespace dmz_samsites
// Params 0
// Checksum 0xa54b69a2, Offset: 0x419b
// Size: 0x170
function dmz_spawnplane()
{
    var_85eb25c41f83d6f2 = function_8724355defbeec36();
    pathstruct = function_6603bd4e910774d6( var_85eb25c41f83d6f2 );
    dist = distance( pathstruct.startpt, pathstruct.endpt );
    travelspeed = level.samsiteprops.travelspeed;
    time = dist / travelspeed;
    c130 = br_supply_drops_common::function_bcee8502a3021b84( pathstruct, dist, travelspeed, time, "veh9_mil_air_cargo_plane_wm_dmz" );
    println( "<dev string:x24>" );
    
    if ( level.samsiteprops.var_5c73eaaa929117f5 )
    {
        c130 setscriptablepartstate( "audio_loop", "on", 0 );
    }
    
    c130 moveto( c130.endpt, c130.lifetime );
    c130.velocity = ( pathstruct.endpt - pathstruct.startpt ) / time;
    c130 setcandamage( 1 );
    c130.maxhealth = getdvarint( @"scr_plane_health", 5000 );
    c130.health = c130.maxhealth;
    c130.damagetaken = 0;
    c130 thread function_5f55c587fefd18c1();
    c130 thread function_c7b1c26303da1b77();
    level thread function_2b05b1e3a12c5039( c130, time );
    return c130;
}

// Namespace dmz_samsites
// Params 0
// Checksum 0x1821de6c, Offset: 0x4314
// Size: 0x2ef
function function_6533d0afe610d5c7()
{
    level endon( #"game_ended" );
    var_3fcbef5d8a13140e = self gettagorigin( "engine_propeller_l_01_jnt" );
    self.leftwingfxent = spawn( "script_model", var_3fcbef5d8a13140e );
    self.leftwingfxent setmodel( "dmz_samsite_plane" );
    self.leftwingfxent.angles = self.angles;
    self.leftwingfxent setotherent( self.owner );
    self.leftwingfxent linkto( self, "engine_propeller_l_01_jnt", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    var_75ace1b29e67463 = self gettagorigin( "engine_propeller_r_01_jnt" );
    self.rightwingfxent = spawn( "script_model", var_75ace1b29e67463 );
    self.rightwingfxent setmodel( "dmz_samsite_plane" );
    self.rightwingfxent.angles = self.angles;
    self.rightwingfxent setotherent( self.owner );
    self.rightwingfxent linkto( self, "engine_propeller_r_01_jnt", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    waitframe();
    self.leftwingfxent setscriptablepartstate( "engine_blowout", "on" );
    self.rightwingfxent setscriptablepartstate( "engine_blowout", "on" );
    self.var_d511ee197fc9d1c9 = spawn( "script_model", self.origin );
    self.var_d511ee197fc9d1c9 setmodel( "tag_origin" );
    self.var_d511ee197fc9d1c9.angles = vectortoangles( anglestoforward( self.angles ) );
    crashmodel = spawn( "script_model", self.origin );
    crashmodel setmodel( "dmz_samsite_plane_mesh" );
    crashmodel.angles = self.angles;
    crashmodel.animname = "gunship";
    crashmodel animation::setanimtree();
    crashpart = "crash_air";
    self.leftwingfxent setscriptablepartstate( crashpart, "on", 0 );
    
    if ( utility::issharedfuncdefined( #"entity", #"hash_cb0d9e569e0f2002" ) )
    {
        crashmodel thread [[ utility::getsharedfunc( #"entity", #"hash_cb0d9e569e0f2002" ) ]]( 10 );
    }
    
    self setscriptablepartstate( "dmz_audio_explosion", "on" );
    var_43b5cb40a1c04c38 = "outro_gunship_death";
    var_235ca49abaff28d0 = animation::get_scr_animlength( "gunship", var_43b5cb40a1c04c38 );
    thread function_eda8bf7b80ad551d();
    thread function_38b5a95f8706970a( var_235ca49abaff28d0, self.origin );
    thread function_afd78027aab99883( var_235ca49abaff28d0 );
    self.var_d511ee197fc9d1c9 animation::anim_single_solo( crashmodel, var_43b5cb40a1c04c38 );
}

// Namespace dmz_samsites
// Params 1
// Checksum 0xc7f5a37d, Offset: 0x460b
// Size: 0x19d
function function_afd78027aab99883( time )
{
    wait time * 0.5;
    crate = br_supply_drops_common::function_85cc64e2a6e80987( self.origin - ( 0, 0, level.var_4280cdebdfea8385 ), level.supplydroptypes[ "dmz_samsite_drop" ] );
    
    if ( isdefined( crate ) )
    {
        crate unlink();
        force = ( 0, 0, 0 );
        
        if ( distance2d( crate.origin, ( 0, 0, 0 ) ) > level.samsiteprops.var_4645acc525abda4 )
        {
            dir = ( 0, 0, 0 ) - crate.origin;
            force = vectornormalize2( dir ) * level.samsiteprops.forcefar;
            force = ( force[ 0 ], force[ 1 ], randomfloatrange( -500000, 500000 ) );
        }
        else
        {
            force = utility::randomvector( level.samsiteprops.forceclose );
        }
        
        crate physicslaunchserver( crate.origin, ( 0, 0, 0 ) );
        bodyid = crate physics_getbodyid( 0 );
        physics_setbodycenterofmassnormal( bodyid, ( 0, 0, 0 ) );
        crate.physicsactivated = 1;
        crate physics_applyimpulse( crate.origin, force );
        crate.usetime = 10;
        crate setscriptablepartstate( "dmz_supply_drop", "usable" );
    }
}

// Namespace dmz_samsites
// Params 0
// Checksum 0x75bf2ec8, Offset: 0x47b0
// Size: 0x1a
function function_eda8bf7b80ad551d()
{
    level endon( #"game_ended" );
    wait 0.05;
    self hide();
}

// Namespace dmz_samsites
// Params 2
// Checksum 0x196c0406, Offset: 0x47d2
// Size: 0x11d
function function_38b5a95f8706970a( delaytime, origin )
{
    level endon( #"game_ended" );
    var_156b609ddcf72f46 = delaytime - 2;
    hostmigration::waitlongdurationwithpause( var_156b609ddcf72f46 );
    radius = 30000;
    
    if ( level.var_f8f564d5b2b09e05 ?? utility::function_645a77750f1850b5() )
    {
        players = getentitiesinradiusfrompartitiongrid( origin, radius, createentitytypemask( [ "etype_player" ] ) );
        
        foreach ( player in players )
        {
            frac = distance( player.origin, origin ) / radius;
            
            if ( player player::isreallyalive() )
            {
                player earthquakeforplayer( 0.25, 2, origin, radius );
            }
        }
    }
}

// Namespace dmz_samsites
// Params 0
// Checksum 0x59e420ab, Offset: 0x48f7
// Size: 0x92
function dmz_removeplane()
{
    if ( isdefined( self.leftwingfxent ) )
    {
        self.leftwingfxent delete();
    }
    
    if ( isdefined( self.rightwingfxent ) )
    {
        self.rightwingfxent delete();
    }
    
    if ( isdefined( self.chassis ) )
    {
        self.chassis delete();
    }
    
    if ( isdefined( self.var_d511ee197fc9d1c9 ) )
    {
        self.var_d511ee197fc9d1c9 delete();
    }
    
    if ( isdefined( self ) )
    {
        self notify( #"deleted" );
        self delete();
    }
    
    println( "<dev string:x58>" );
}

// Namespace dmz_samsites
// Params 1
// Checksum 0x333955cb, Offset: 0x4991
// Size: 0x92
function function_5e6f4420051d8a86( streakitem )
{
    samsite = function_47c86977a18df38b( level.samsites, self.origin, level.samsiteprops.blockingrange );
    blockkillstreak = isdefined( samsite ) && isdefined( samsite.owningteam ) && self.team != samsite.owningteam;
    
    if ( blockkillstreak )
    {
        streakitem.errormessage = %"dmz/samsite_block_killstreak_err_msg";
    }
    
    return blockkillstreak;
}

// Namespace dmz_samsites
// Params 0
// Checksum 0xdd2d071d, Offset: 0x4a2c
// Size: 0xf, Type: bool
function function_6285deb81a978f94()
{
    return level.samsites ?? [];
}

// Namespace dmz_samsites
// Params 0
// Checksum 0xea53efa8, Offset: 0x4a44
// Size: 0x6c
function function_de160f7b9e5f029()
{
    level endon( #"game_ended" );
    
    if ( !isdefined( self.warningsoundplaying ) || self.warningsoundplaying == 0 )
    {
        self.warningsoundplaying = 1;
    }
    else if ( self.warningsoundplaying == 1 )
    {
        return;
    }
    
    wait 1;
    self setscriptablepartstate( "warning_alarm_audio", "alarm_start" );
    wait 20.5;
    self.warningsoundplaying = 0;
}

// Namespace dmz_samsites
// Params 1
// Checksum 0xe0b146ff, Offset: 0x4ab8
// Size: 0x74
function function_e17e300ac07b99c( samsite )
{
    level endon( #"game_ended" );
    self setscriptablepartstate( "interaction_audio", "interaction_audio_start" );
    msg = samsite utility::waittill_any_return( "start_capture", "captured" );
    
    if ( msg == "captured" )
    {
        self setscriptablepartstate( "interaction_audio", "interaction_audio_success" );
        return;
    }
    
    self setscriptablepartstate( "interaction_audio", "interaction_audio_off" );
}

/#

    // Namespace dmz_samsites
    // Params 0
    // Checksum 0xce6e1898, Offset: 0x4b34
    // Size: 0x689, Type: dev
    function debug_samsites()
    {
        while ( true )
        {
            if ( getdvarint( @"scr_samsite_follow_player", 0 ) )
            {
                foreach ( samsite in level.samsites )
                {
                    samsite.targetentity.origin = level.players[ 0 ].origin;
                }
            }
            
            if ( getdvarint( @"hash_e2efbec1dbe653f9", 0 ) )
            {
                origin = getdvarvector( @"scr_samsite_offset", ( 0, 0, 0 ) );
                angles = getdvarvector( @"scr_samsite_angles", ( 0, 0, 0 ) );
                
                foreach ( samsite in level.samsites )
                {
                    samsite.collision unlink();
                    samsite.collision linkto( samsite, "<dev string:x8d>", origin, angles );
                }
            }
            
            if ( getdvarint( @"hash_899a5d114b54c419", 0 ) )
            {
                setdvar( @"hash_899a5d114b54c419", 0 );
                player = level.players[ 0 ];
                forward = anglestoforward( player getplayerangles() );
                fireorigin = level.players[ 0 ].origin + forward * 100;
                fireend = fireorigin + forward * 1000;
                fakefireweapon = makeweapon( "<dev string:x9e>" );
                proj = magicbullet( fakefireweapon, fireorigin, fireend );
                proj setmodel( "<dev string:xb5>" );
                proj setscriptablepartstate( "<dev string:xd3>", "<dev string:xf0>" );
            }
            
            if ( getdvarint( @"scr_samsite_fire_missile", 0 ) )
            {
                setdvar( @"scr_samsite_fire_missile", 0 );
                
                foreach ( samsite in level.samsites )
                {
                    samsite function_4d8786a6d818067d();
                }
            }
            
            if ( getdvarint( @"hash_227f7408cd5466d4", 0 ) )
            {
                setdvar( @"hash_227f7408cd5466d4", 0 );
                
                foreach ( samsite in level.samsites )
                {
                    foreach ( player in level.players )
                    {
                        samsite disablescriptableplayeruse( player );
                        samsite enablescriptableplayeruse( player );
                    }
                }
            }
            
            if ( getdvarint( @"scr_explode_plane", 0 ) )
            {
                setdvar( @"scr_explode_plane", 0 );
                
                if ( isdefined( level.currentplane ) )
                {
                    function_c86f262fe0a3998f( level.currentplane );
                }
            }
            
            samsiteindexes = getdvar( @"hash_2fd705c3c5dabfdd", "<dev string:xf3>" );
            
            if ( isdefined( level.players[ 0 ] ) && samsiteindexes != "<dev string:xf3>" )
            {
                indexes = strtok( samsiteindexes, "<dev string:xf4>" );
                
                foreach ( index in indexes )
                {
                    index = int( index );
                    
                    if ( !isdefined( level.samsites[ index - 1 ] ) )
                    {
                        continue;
                    }
                    
                    samsite = level.samsites[ index - 1 ];
                    dist = distance( level.players[ 0 ].origin, samsite.origin );
                    scale = dist / 750;
                    
                    /#
                        print3d( samsite.origin + ( 0, 0, dist / log( dist ) ), "<dev string:xf6>", ( 0, 1, 0 ), undefined, scale );
                    #/
                    
                    thread utility::draw_circle( samsite.origin, level.samsiteprops.reinforcementrange, ( 0, 1, 0 ) );
                    
                    /#
                        print3d( samsite.origin + ( 0, 0, dist * 2 / log( dist ) ), "<dev string:x106>", ( 0, 0, 1 ), undefined, scale );
                    #/
                    
                    thread utility::draw_circle( samsite.origin, level.samsiteprops.var_f3ca450ec5e034ec, ( 0, 0, 1 ) );
                    
                    /#
                        print3d( samsite.origin + ( 0, 0, dist * 3 / log( dist ) ), "<dev string:x111>", ( 1, 0, 0 ), undefined, scale );
                    #/
                    
                    thread utility::draw_circle( samsite.origin, level.samsiteprops.var_85c78a0d4f8d1466, ( 1, 0, 0 ) );
                }
            }
            
            waitframe();
        }
    }

#/

// Namespace dmz_samsites
// Params 1
// Checksum 0x22ddee9b, Offset: 0x51c5
// Size: 0x25, Type: bool
function dmz_samsitecanuse( player )
{
    if ( isdefined( player ) && player.carryinghostage )
    {
        return false;
    }
    
    return true;
}

