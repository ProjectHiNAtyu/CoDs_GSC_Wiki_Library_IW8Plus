// scripts\mp\common\equipment\tactical_cover.gsc  (hash_4221e47f12606ece.gscc) (size: 28384 Bytes / 0x6ee0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x60831f9e (1619206046)
// size ...... 28384 (0x6ee0)
// includes .. 29  (offset: 0x684c)
// strings ... 72  (offset: 0x6934)
// dev strs .. 15  (offset: 0x6e14)
// exports ... 60  (offset: 0x4630)
// cseg ...... 0x5f9 + 0x4037 (0x4630)
// imports ... 204 (offset: 0x4f90)
// animtree1 . 0   (offset: 0x6ed0)
// animtree2 . 1   (offset: 0x6ed0)
#using script_13865ca76df87ea;
#using script_74b851b7aa1ef32d;
#using scripts\common\ae_utility;
#using scripts\common\elevator;
#using scripts\common\elevators;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\analyticslog;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\challenges;
#using scripts\mp\common\perks\perk_equipmentping;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\scriptable_door_utility;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\damage;
#using scripts\mp\ent_manager;
#using scripts\mp\entityheadicons;
#using scripts\mp\equipment;
#using scripts\mp\loot\common_item;
#using scripts\mp\movers;
#using scripts\mp\supers;
#using scripts\mp\weapons;

#namespace tactical_cover;

// Namespace tactical_cover
// Params 0, eflags: 0x1
// Checksum 0x6ac06f22, Offset: 0x617
// Size: 0x9
function autoexec main()
{
    tac_cover_init();
}

// Namespace tactical_cover
// Params 0
// Checksum 0xcaa527af, Offset: 0x628
// Size: 0x2b5
function tac_cover_init()
{
    utility::flag_wait( "supers_initialized" );
    supers_mp::function_48aaa60b2ce7b8a1( "super_tac_cover", undefined, &tac_cover_on_take_super, &tac_cover_on_fired_super, undefined, undefined, undefined, undefined, &tac_cover_reclaim, &supers_mp::function_484ca0a545e40e20 );
    
    if ( !isdefined( level.taccovercollision ) )
    {
        collisionarr = getentarray( "tactical_cover_col", #targetname );
        
        if ( isdefined( collisionarr ) )
        {
            level.taccovercollision = collisionarr[ 0 ];
        }
    }
    
    if ( false )
    {
        level.taccovertriggerblockers = getentarray( "dcover_blocker", #targetname );
    }
    
    if ( true )
    {
        if ( !isdefined( level.var_d29d934032eafa1f ) )
        {
            level.var_d29d934032eafa1f = utility::getstructarray( "dcover_blocker_struct", "targetname" );
            
            foreach ( taccoverstruct in level.var_d29d934032eafa1f )
            {
                level function_44b75c6a85a44271( taccoverstruct );
            }
        }
        else
        {
            foreach ( taccoverstruct in level.var_d29d934032eafa1f )
            {
                level function_44b75c6a85a44271( taccoverstruct );
            }
            
            level.var_d29d934032eafa1f = arraycombine( level.var_d29d934032eafa1f, getentarray( "dcover_blocker_struct", #targetname ) );
        }
    }
    
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_tac_cover" );
    level.taccover_timeout = getdvarfloat( @"hash_fdeb104ec6908df8", 150 );
    level.var_d0db8920ef2e9762 = getdvarint( @"hash_b2324a0894ed035f", 1 );
    level.var_67024f288fe6e88 = getdvarint( hashcat( @"hash_2798c84281925605", game_utility::getgametype(), "_damagedScoreLimit" ), 0 ) == 1;
    level.taccover_destroy = &tac_cover_destroy;
    
    /#
        setdevdvarifuninitialized( @"hash_a5a0ca488a1da730", 0 );
    #/
    
    weapons::registerusedcallback( "tac_cover", &tac_cover_used );
    function_8d8713d52d006b82( "super_tac_cover", 58, 48, 5, "projectile_deployable_cover_opened_v0", &tac_cover_destroy, &tac_cover_fire_failed, &tac_cover_spawn_internal );
    utility::registersharedfunc( #"tactical_cover", #"destroy", &tac_cover_destroy );
}

// Namespace tactical_cover
// Params 8
// Checksum 0x9e8c812e, Offset: 0x8e5
// Size: 0x12c
function function_8d8713d52d006b82( type, coverwidth, coverheight, coverdepth, modelname, destroyfunc, failfunc, onspawnfunc )
{
    if ( !isdefined( level.var_4faa553d1def66f6 ) )
    {
        level.var_4faa553d1def66f6 = [];
    }
    
    coverdata = spawnstruct();
    coverdata.coverwidth = coverwidth;
    coverdata.coverheight = coverheight;
    coverdata.coverdepth = coverdepth;
    coverdata.spherecastdist = coverwidth;
    coverdata.spherecastrad = coverdepth / 2;
    coverdata.destroyfunc = destroyfunc;
    coverdata.failfunc = failfunc;
    coverdata.superid = level.superglobals.staticsuperdata[ type ].id;
    coverdata.modelname = modelname;
    coverdata.onspawnfunc = onspawnfunc;
    level.var_4faa553d1def66f6[ type ] = coverdata;
}

// Namespace tactical_cover
// Params 1
// Checksum 0x16b22563, Offset: 0xa19
// Size: 0x52
function function_311c5721c8f0b0c9( type )
{
    assert( isdefined( level.var_4faa553d1def66f6 ), "<dev string:x24>" );
    assert( isdefined( level.var_4faa553d1def66f6[ type ] ), "<dev string:x72>" + type + "<dev string:x9a>" );
    return level.var_4faa553d1def66f6[ type ];
}

// Namespace tactical_cover
// Params 3
// Checksum 0xd30e1e74, Offset: 0xa74
// Size: 0x46
function tac_cover_on_give( ref, slot, variantid )
{
    self notify( #"tac_cover_given" );
    
    /#
        if ( !isdefined( level.taccovercollision ) )
        {
            self iprintlnbold( "<dev string:x9c>" );
        }
    #/
}

// Namespace tactical_cover
// Params 3
// Checksum 0xbaf0f29b, Offset: 0xac2
// Size: 0x1e
function tac_cover_on_take( ref, slot, issuper )
{
    
}

// Namespace tactical_cover
// Params 1
// Checksum 0xd0237739, Offset: 0xae8
// Size: 0x27
function tac_cover_used( grenade )
{
    if ( isdefined( grenade ) )
    {
        grenade hide();
    }
    
    waitframe();
    
    if ( isdefined( grenade ) )
    {
        grenade delete();
    }
}

// Namespace tactical_cover
// Params 2
// Checksum 0x45708257, Offset: 0xb17
// Size: 0xb8d
function function_833ed4e3d5304b27( issuper = 1, covertype = "super_tac_cover" )
{
    coverdata = function_311c5721c8f0b0c9( covertype );
    failfunc = coverdata.failfunc;
    var_8a7dc6563bbd97fb = coverdata.spherecastrad;
    var_5f32cb638b508e88 = coverdata.spherecastdist;
    
    if ( self isswimming() || !self isonground() || self.var_c9a013e7f1aa33fa )
    {
        self [[ failfunc ]]( 0 );
        return 0;
    }
    
    if ( isdefined( level.var_7bac13b446aa7fc9 ) )
    {
        foreach ( callback in level.var_7bac13b446aa7fc9 )
        {
            if ( ![[ callback ]]( self ) )
            {
                self [[ failfunc ]]( 0 );
                return 0;
            }
        }
    }
    
    contents = physics_createcontents( [ "physicscontents_characterproxy", "physicscontents_playerclip", "physicscontents_vehicle" ] );
    ignorelist = tac_cover_ignore_list( self );
    
    if ( ignorelist.size > 128 )
    {
        logstring( "count,entNum,birthtime,origin,classname,code_classname,model,targetname,script_noteworthy,ownerNum" );
        
        foreach ( i, ent in ignorelist )
        {
            str = string( i );
            
            if ( isent( ent ) )
            {
                fields = [ ent getentitynumber(), ent.birthtime, ent.origin, ent.classname, ent.code_classname, ent.model, ent.targetname, ent.script_noteworthy ];
                
                if ( isdefined( ent.owner ) )
                {
                    fields[ fields.size ] = ent.owner getentitynumber();
                }
                else
                {
                    fields[ fields.size ] = -1;
                }
                
                foreach ( value in fields )
                {
                    if ( !isdefined( value ) )
                    {
                        value = "<undefined>";
                    }
                    
                    str += "," + value;
                }
            }
            else
            {
                str += ",not an ent";
            }
            
            logstring( str );
        }
    }
    
    playerforward = anglestoforward( self.angles );
    targetpos = self.origin + playerforward * 32;
    nearbydoors = scriptable_door_utility::scriptable_door_get_in_radius( targetpos, 140, 20 );
    closestdoor = undefined;
    closestdistsqrd = 0;
    
    if ( tac_cover_blocked_by_turret( targetpos ) )
    {
        self [[ failfunc ]]( 0 );
        return 0;
    }
    
    if ( function_e83e0149fc5e45ea( targetpos ) || function_c5748aa5603956d6( targetpos ) || function_3ccdda4fe319f948( targetpos ) )
    {
        self [[ failfunc ]]( 0 );
        return 0;
    }
    
    traceresults = undefined;
    contents = undefined;
    radius = getdvarfloat( @"hash_9fa5c4d28ec05069", 40 );
    
    if ( level.var_d0db8920ef2e9762 )
    {
        contents = physics_createcontents( [ "physicscontents_playerclip", "physicscontents_glass" ] );
        traceresults = trace::sphere_trace_get_all_results( targetpos, targetpos + ( 0, 0, 10 ), radius, undefined, contents, 1 );
    }
    else
    {
        contents = trace::function_d436792385c352aa();
        traceresults = trace::sphere_trace_get_all_results( targetpos, targetpos + ( 0, 0, 10 ), radius, level.players, contents, 1 );
    }
    
    var_a767cdd8703b2482 = getdvarint( @"hash_ba3865db9b93a55a", 0 );
    
    foreach ( trace in traceresults )
    {
        if ( isdefined( trace[ "surfaceflags" ] ) )
        {
            surftypeshift = 19;
            invalidsurface = 0;
            invalidsurface |= trace[ "surfaceflags" ] == 8;
            invalidsurface |= trace[ "surfaceflags" ] == 2048;
            invalidsurface |= trace[ "surfaceflags" ] == 9 << surftypeshift;
            
            if ( var_a767cdd8703b2482 )
            {
                invalidsurface |= trace[ "surfaceflags" ] == 39 << surftypeshift;
            }
            
            if ( invalidsurface )
            {
                self [[ failfunc ]]( 0 );
                return 0;
            }
        }
    }
    
    foreach ( door in nearbydoors )
    {
        distsqrd = distancesquared( door.origin, targetpos );
        
        if ( isdefined( closestdoor ) && closestdistsqrd <= distsqrd )
        {
            continue;
        }
        
        closestdoor = door;
        closestdistsqrd = distsqrd;
    }
    
    if ( isdefined( closestdoor ) )
    {
        doordegrees = closestdoor scriptabledoorangle();
        isdooropen = abs( doordegrees ) > 65;
        doubledoor = undefined;
        
        foreach ( otherdoor in nearbydoors )
        {
            if ( closestdoor scriptable_door_utility::scriptable_door_is_double_door_pair( otherdoor ) )
            {
                doubledoor = otherdoor;
                break;
            }
        }
        
        var_7750be92dfb3f4f = 1;
        
        if ( isdefined( doubledoor ) )
        {
            var_185fb9332864e3a4 = doubledoor scriptabledoorangle();
            var_7750be92dfb3f4f = abs( var_185fb9332864e3a4 ) > 65;
        }
        
        if ( closestdistsqrd < 1600 && isdooropen && var_7750be92dfb3f4f )
        {
            startpos = self gettagorigin( "j_spinelower" );
            endpos = closestdoor function_50ddcb729a6c2820() + ( 0, 0, 24 );
            castresult = physics_raycast( startpos, endpos, contents, ignorelist, 0, "physicsquery_any", 1 );
            
            if ( castresult > 0 )
            {
                errormessage = 1;
                
                if ( isdefined( closestdoor.origin ) )
                {
                    data = function_a680e3b82b80ea2a( closestdoor.origin );
                    errormessage = data[ 1 ];
                }
                
                self [[ failfunc ]]( errormessage );
                return 0;
            }
            
            closestdoor.isblocked = 1;
            thread tac_cover_spawn_with_door( closestdoor, doubledoor, issuper, contents, covertype );
            
            if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
            {
                if ( isdefined( self.leaderboarddata[ "deployableCoverUsed" ] ) )
                {
                    self.leaderboarddata[ "deployableCoverUsed" ] = self.leaderboarddata[ "deployableCoverUsed" ] + 1;
                }
                
                if ( isdefined( level.leaderboardfunc[ "deployableCoverUsed" ] ) )
                {
                    [[ level.leaderboardfunc[ "deployableCoverUsed" ] ]]( self, 1 );
                }
                
                assert( isint( 1 ) || isfloat( 1 ), "<dev string:xbb>" );
                
                if ( isdefined( self.pers[ "deployableCoverUsed" ] ) )
                {
                    self.pers[ "deployableCoverUsed" ] = self.pers[ "deployableCoverUsed" ] + 1;
                }
            }
            
            return 1;
        }
        else if ( closestdistsqrd < 6400 )
        {
            self [[ failfunc ]]( !isdooropen );
            return 0;
        }
    }
    
    var_77a42ed4e9857394 = self getplayerangles() * ( 0, 1, 0 );
    caststart = self.origin + ( 0, 0, 24 );
    castdir = anglestoforward( var_77a42ed4e9857394 );
    castdist = 32 - var_8a7dc6563bbd97fb;
    frontcastend = caststart + castdir * castdist;
    castresult = physics_raycast( caststart, frontcastend, contents, ignorelist, 0, "physicsquery_closest", 1 );
    
    if ( castresult.size > 0 )
    {
        tac_cover_fire_failed();
        return 0;
    }
    
    rightfraction = undefined;
    leftfraction = undefined;
    caststart = frontcastend;
    castdir = anglestoright( var_77a42ed4e9857394 );
    castdist = var_5f32cb638b508e88 - var_8a7dc6563bbd97fb;
    castend = caststart + castdir * castdist;
    castresult = physics_spherecast( caststart, castend, var_8a7dc6563bbd97fb, contents, ignorelist, "physicsquery_closest" );
    
    if ( castresult.size > 0 )
    {
        foreach ( trace in castresult )
        {
            if ( isdefined( trace[ "surfaceflags" ] ) )
            {
                invalidsurface = 0;
                invalidsurface |= trace[ "surfaceflags" ] == 8;
                
                if ( invalidsurface )
                {
                    tac_cover_fire_failed( 0 );
                    return 0;
                }
            }
        }
        
        rightfraction = castresult[ 0 ][ "fraction" ];
    }
    else
    {
        rightfraction = 1;
    }
    
    caststart = frontcastend;
    castdir = -1 * anglestoright( var_77a42ed4e9857394 );
    castdist = coverdata.spherecastdist - coverdata.spherecastrad;
    castend = caststart + castdir * castdist;
    castresult = physics_spherecast( caststart, castend, coverdata.spherecastrad, contents, ignorelist, "physicsquery_closest" );
    
    if ( castresult.size > 0 )
    {
        foreach ( trace in castresult )
        {
            if ( isdefined( trace[ "surfaceflags" ] ) )
            {
                invalidsurface = 0;
                invalidsurface |= ( trace[ "surfaceflags" ] & 8 ) > 0;
                
                if ( invalidsurface )
                {
                    tac_cover_fire_failed( 0 );
                    return 0;
                }
            }
        }
        
        leftfraction = castresult[ 0 ][ "fraction" ];
    }
    else
    {
        leftfraction = 1;
    }
    
    if ( leftfraction + rightfraction < 1 )
    {
        self [[ coverdata.failfunc ]]( 0 );
        return 0;
    }
    else if ( rightfraction < 0.5 )
    {
        frontcastend += castdir * castdist * ( 0.5 - rightfraction );
    }
    else if ( leftfraction < 0.5 )
    {
        frontcastend += castdir * castdist * ( 0.5 - leftfraction ) * -1;
    }
    
    castangles = var_77a42ed4e9857394;
    return function_7389707b3775a997( frontcastend, castangles, issuper, covertype );
}

// Namespace tactical_cover
// Params 5
// Checksum 0xeb5c0819, Offset: 0x16ad
// Size: 0x2a9
function function_81ce766528080691( issuper = 1, covertype = "super_tac_cover", closestdoor, doubledoor, dooropen )
{
    if ( !isdefined( closestdoor ) )
    {
        return;
    }
    
    coverdata = function_311c5721c8f0b0c9( covertype );
    failfunc = coverdata.failfunc;
    ignorelist = tac_cover_ignore_list( self );
    contents = undefined;
    var_77a42ed4e9857394 = self getplayerangles() * ( 0, 1, 0 );
    
    if ( level.var_d0db8920ef2e9762 )
    {
        contents = physics_createcontents( [ "physicscontents_playerclip", "physicscontents_glass" ] );
    }
    else
    {
        contents = trace::function_d436792385c352aa();
    }
    
    if ( dooropen )
    {
        startpos = self gettagorigin( "j_spinelower" );
        endpos = closestdoor function_50ddcb729a6c2820() + ( 0, 0, 24 );
        castresult = physics_raycast( startpos, endpos, contents, ignorelist, 0, "physicsquery_any", 1 );
        
        if ( castresult > 0 )
        {
            errormessage = 1;
            
            if ( isdefined( closestdoor.origin ) )
            {
                data = function_a680e3b82b80ea2a( closestdoor.origin );
                errormessage = data[ 1 ];
            }
            
            self [[ failfunc ]]( errormessage );
            return 0;
        }
        
        closestdoor.isblocked = 1;
        thread tac_cover_spawn_with_door( closestdoor, doubledoor, issuper, contents, covertype );
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
        {
            if ( isdefined( self.leaderboarddata[ "deployableCoverUsed" ] ) )
            {
                self.leaderboarddata[ "deployableCoverUsed" ] = self.leaderboarddata[ "deployableCoverUsed" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "deployableCoverUsed" ] ) )
            {
                [[ level.leaderboardfunc[ "deployableCoverUsed" ] ]]( self, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:xbb>" );
            
            if ( isdefined( self.pers[ "deployableCoverUsed" ] ) )
            {
                self.pers[ "deployableCoverUsed" ] = self.pers[ "deployableCoverUsed" ] + 1;
            }
        }
        
        return 1;
    }
    
    errormessage = 1;
    
    if ( isdefined( closestdoor.origin ) )
    {
        data = function_a680e3b82b80ea2a( closestdoor.origin );
        errormessage = data[ 1 ];
    }
    
    self [[ failfunc ]]( errormessage );
    return 0;
}

// Namespace tactical_cover
// Params 4
// Checksum 0xce115091, Offset: 0x195e
// Size: 0x502
function function_7389707b3775a997( frontcastend, castangles, issuper = 1, covertype = "super_tac_cover" )
{
    coverdata = function_311c5721c8f0b0c9( covertype );
    failfunc = coverdata.failfunc;
    ignorelist = tac_cover_ignore_list( self );
    contents = undefined;
    var_77a42ed4e9857394 = self getplayerangles() * ( 0, 1, 0 );
    
    if ( level.var_d0db8920ef2e9762 )
    {
        contents = physics_createcontents( [ "physicscontents_playerclip", "physicscontents_glass" ] );
    }
    else
    {
        contents = trace::function_d436792385c352aa();
    }
    
    caststart = frontcastend;
    castdir = ( 0, 0, -1 );
    castdist = 60;
    castend = caststart + castdir * castdist;
    capsulecastangles = combineangles( castangles, ( 0, 0, 90 ) );
    castresult = physics_capsulecast( caststart, castend, 2.5, 16.8, capsulecastangles, contents, ignorelist, "physicsquery_closest" );
    
    if ( !isdefined( castresult ) || castresult.size <= 0 )
    {
        self [[ coverdata.failfunc ]]( 0 );
        return 0;
    }
    
    hitent = castresult[ 0 ][ "entity" ];
    var_6ea92893eb613ee8 = castresult[ 0 ][ "shape_position" ];
    hitpos = castresult[ 0 ][ "position" ];
    
    if ( isdefined( hitent ) && !tac_cover_can_place_on( hitent ) )
    {
        self [[ coverdata.failfunc ]]( 0 );
        return 0;
    }
    
    var_59f28bc546c68ddc = tac_cover_get_stuck_to_ent( hitent, coverdata );
    var_6cca41f14b6ef0e = 25.025;
    var_eae8053dbf85439f = pow( var_6cca41f14b6ef0e * 0.14, 2 );
    caststartcenter = var_6ea92893eb613ee8;
    var_3f28010b4920d3f8 = distance2dsquared( caststartcenter, hitpos );
    caststartright = var_6ea92893eb613ee8 + anglestoright( var_77a42ed4e9857394 ) * 14.3 * 1.75;
    var_c1cde688a5fa013b = distance2dsquared( caststartright, hitpos );
    caststartleft = var_6ea92893eb613ee8 + anglestoright( var_77a42ed4e9857394 ) * 14.3 * 1.75 * -1;
    var_2c4e0e732e70c634 = distance2dsquared( caststartleft, hitpos );
    
    if ( self function_41bfe14190ca96e7( caststartleft, 32 ) || self function_41bfe14190ca96e7( caststartright, 32 ) )
    {
        self [[ coverdata.failfunc ]]( 0 );
        return 0;
    }
    
    caststarts = [];
    var_142ab7af8c65fb74 = 0;
    
    if ( var_c1cde688a5fa013b <= var_eae8053dbf85439f && var_c1cde688a5fa013b < var_3f28010b4920d3f8 && var_c1cde688a5fa013b < var_2c4e0e732e70c634 )
    {
        var_142ab7af8c65fb74++;
        caststarts = [ caststartcenter, caststartleft ];
    }
    else if ( var_2c4e0e732e70c634 <= var_eae8053dbf85439f && var_2c4e0e732e70c634 < var_3f28010b4920d3f8 && var_2c4e0e732e70c634 < var_c1cde688a5fa013b )
    {
        var_142ab7af8c65fb74++;
        caststarts = [ caststartcenter, caststartright ];
    }
    else if ( var_3f28010b4920d3f8 <= var_eae8053dbf85439f )
    {
        var_142ab7af8c65fb74++;
        caststarts = [ caststartleft, caststartright ];
    }
    else
    {
        caststarts = [ caststartcenter, caststartleft, caststartright ];
    }
    
    castdir = ( 0, 0, -1 );
    castdist = 8.5;
    
    foreach ( caststart in caststarts )
    {
        castend = caststart + castdir * castdist;
        castresult = physics_raycast( caststart, castend, contents, ignorelist, 0, "physicsquery_all", 1 );
        
        if ( !isdefined( castresult ) || castresult.size <= 0 )
        {
            /#
                if ( false )
                {
                    thread debug::drawline( caststart, castend, 10, ( 1, 0, 0 ) );
                }
            #/
            
            continue;
        }
        
        hitent = castresult[ 0 ][ "entity" ];
        
        if ( isdefined( hitent ) && !tac_cover_can_place_on( hitent ) )
        {
            self [[ coverdata.failfunc ]]();
            return 0;
        }
        
        var_142ab7af8c65fb74++;
        
        if ( var_142ab7af8c65fb74 >= 2 )
        {
            break;
        }
    }
    
    if ( var_142ab7af8c65fb74 < 2 )
    {
        self [[ coverdata.failfunc ]]();
        return 0;
    }
    
    spawnpos = var_6ea92893eb613ee8 - ( 0, 0, 2.5 );
    
    if ( getdvarint( @"hash_5d62431d49087f8a", 0 ) )
    {
        caststart = spawnpos + ( 0, 0, 45 );
        castdist = 20;
        castdir = ( 0, 0, 1 );
        castend = caststart + castdir * castdist;
        castresult = physics_raycast( caststart, castend, contents, ignorelist, 0, "physicsquery_all", 1 );
        
        if ( castresult.size > 0 )
        {
            self [[ coverdata.failfunc ]]();
            return 0;
        }
    }
    
    return tac_cover_spawn( spawnpos, castangles, var_59f28bc546c68ddc, issuper, contents, undefined, undefined, covertype );
}

// Namespace tactical_cover
// Params 0
// Checksum 0x92909b79, Offset: 0x1e69
// Size: 0x2
function function_e9f6df5958b2ad7b()
{
    
}

// Namespace tactical_cover
// Params 2
// Checksum 0x3de1a694, Offset: 0x1e73
// Size: 0x46
function tac_cover_get_stuck_to_ent( hitent, coverdata )
{
    if ( isdefined( hitent ) )
    {
        if ( killstreak_utility::function_947e7b15331fd6e3( hitent ) )
        {
            return hitent;
        }
        
        if ( coverdata.var_b1e197b670cbb18e && elevator::is_moving_platform_elevator( hitent ) )
        {
            return hitent;
        }
    }
}

// Namespace tactical_cover
// Params 1
// Checksum 0xd3e15f87, Offset: 0x1ec2
// Size: 0x291
function function_a680e3b82b80ea2a( spawnpos )
{
    newspawnpos = spawnpos;
    var_98962e3f953a5e03 = 1;
    var_8c8afcebfa104adc = 6;
    var_9a71042f003d60a = 0;
    
    foreach ( blockerstruct in level.var_d29d934032eafa1f )
    {
        /#
            if ( true )
            {
                duration = level.framedurationseconds * 60 * 10;
                colorred = ( 1, 0, 0 );
                colorblue = ( 0, 0, 1 );
                colorgreen = ( 0, 1, 0 );
                
                if ( blockerstruct.var_648d0c8837ac2c4d )
                {
                    level thread debug_utility::drawcylinder( blockerstruct.origin - var_8c8afcebfa104adc, blockerstruct.radius, blockerstruct.height + var_8c8afcebfa104adc, duration, colorred );
                }
                else
                {
                    level thread debug_utility::drawcylinder( blockerstruct.origin - var_8c8afcebfa104adc, blockerstruct.radius, blockerstruct.height + var_8c8afcebfa104adc, duration, colorblue );
                }
                
                level thread debug_utility::drawsphere( newspawnpos, 5, duration, colorgreen );
            }
        #/
        
        if ( var_9a71042f003d60a )
        {
            continue;
        }
        
        var_48607cfdb87ffbae = distance2dsquared( blockerstruct.origin, newspawnpos );
        rad_sq = squared( blockerstruct.radius );
        z_min = blockerstruct.origin[ 2 ] - var_8c8afcebfa104adc;
        z_max = z_min + var_8c8afcebfa104adc + ( blockerstruct.height ?? 96 );
        var_5c2c7f82d6fa9220 = newspawnpos[ 2 ] >= z_min && newspawnpos[ 2 ] <= z_max;
        
        if ( var_48607cfdb87ffbae < rad_sq && var_5c2c7f82d6fa9220 )
        {
            if ( isvector( blockerstruct.offset ) )
            {
                newspawnpos += blockerstruct.offset;
                var_9a71042f003d60a = 1;
            }
            else
            {
                newspawnpos += ( 0, 0, -6 );
                var_9a71042f003d60a = 1;
            }
            
            if ( blockerstruct.var_648d0c8837ac2c4d )
            {
                var_98962e3f953a5e03 = 0;
            }
        }
    }
    
    return [ newspawnpos, var_98962e3f953a5e03 ];
}

// Namespace tactical_cover
// Params 4
// Checksum 0x235c9e16, Offset: 0x215c
// Size: 0x1a1
function tac_cover_adjust_for_player_space( spawnpos, spawnangles, contents, var_98962e3f953a5e03 )
{
    newspawnpos = spawnpos;
    var_98962e3f953a5e03 = 1;
    var_9a71042f003d60a = 0;
    
    if ( false )
    {
        foreach ( trigger in level.taccovertriggerblockers )
        {
            if ( var_9a71042f003d60a )
            {
                continue;
            }
            
            if ( ispointinvolume( newspawnpos + ( 0, 0, 20 ), trigger ) )
            {
                newspawnpos += ( 0, 0, -6 );
                var_9a71042f003d60a = 1;
                break;
            }
        }
    }
    
    if ( true )
    {
        var_baf31c7c81d83860 = function_a680e3b82b80ea2a( newspawnpos );
        newspawnpos = var_baf31c7c81d83860[ 0 ];
        var_98962e3f953a5e03 = var_baf31c7c81d83860[ 1 ];
    }
    
    frontspace = tac_cover_get_free_space( 1, newspawnpos, spawnangles, contents, 30 );
    
    if ( !isdefined( frontspace ) )
    {
        return [ newspawnpos, var_98962e3f953a5e03 ];
    }
    
    backspace = tac_cover_get_free_space( 0, newspawnpos, spawnangles, contents, 30 );
    
    if ( !isdefined( backspace ) )
    {
        return [ newspawnpos, var_98962e3f953a5e03 ];
    }
    
    var_695f569f2fbb289f = min( frontspace, 15 );
    forwarddir = anglestoforward( spawnangles );
    newspawnpos += forwarddir * var_695f569f2fbb289f;
    return [ newspawnpos, var_98962e3f953a5e03 ];
}

// Namespace tactical_cover
// Params 5
// Checksum 0x8d206e5, Offset: 0x2306
// Size: 0x24b
function tac_cover_get_free_space( isfrontcheck, spawnpos, spawnangles, contents, maxcheckdist )
{
    forwarddir = anglestoforward( spawnangles );
    backwarddir = -1 * forwarddir;
    endoffset = undefined;
    
    if ( isfrontcheck )
    {
        endoffset = forwarddir * maxcheckdist;
    }
    else
    {
        endoffset = backwarddir * maxcheckdist;
    }
    
    topcenterpos = spawnpos + ( 0, 0, 48 );
    start = topcenterpos;
    end = topcenterpos + endoffset;
    radius = 2.5;
    halfheight = 29 + maxcheckdist;
    angles = combineangles( spawnangles, ( 0, 0, 90 ) );
    contents = contents;
    ignorelist = [ self ];
    collectiontype = "physicsquery_closest";
    results = physics_capsulecast( start, end, radius, halfheight, angles, contents, ignorelist, collectiontype );
    isclear = results.size == 0;
    
    /#
        if ( getdvarint( @"hash_a5a0ca488a1da730", 0 ) )
        {
            hasanyspace = isclear || results[ 0 ][ "<dev string:xe1>" ] > 0;
            colorstart = hasanyspace ? ( 0, 1, 0 ) : ( 1, 0, 0 );
            colorend = isclear ? ( 0, 1, 0 ) : ( 1, 0, 0 );
            leftdir = anglestoleft( spawnangles );
            topleftpos = topcenterpos + leftdir * ( 29 + maxcheckdist );
            drawstart = topleftpos;
            drawend = topleftpos + endoffset;
            utility::draw_capsule( drawstart, radius, halfheight * 2, angles, colorstart, 0, 500 );
            utility::draw_capsule( drawend, radius, halfheight * 2, angles, colorend, 0, 500 );
        }
    #/
    
    if ( isclear )
    {
        return;
    }
    
    shapepos = results[ 0 ][ "shape_position" ];
    dist = distance( shapepos, topcenterpos );
    return dist;
}

// Namespace tactical_cover
// Params 1
// Checksum 0x8cf9fd8b, Offset: 0x255a
// Size: 0xbb, Type: bool
function tac_cover_blocked_by_turret( targetpos )
{
    if ( isdefined( level.turrets ) )
    {
        foreach ( turret in level.turrets )
        {
            if ( !isdefined( turret ) )
            {
                continue;
            }
            
            distsqrd = distancesquared( turret.origin, targetpos );
            
            if ( 6400 >= distsqrd )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace tactical_cover
// Params 1
// Checksum 0x9fafa98a, Offset: 0x261e
// Size: 0x82
function tac_cover_fire_failed( isdoorblocked )
{
    errormessage = isdoorblocked ? %"mp/tac_cover_place_in_doorway" : %"mp/tac_cover_cannot_place";
    
    if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
    {
        self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( errormessage );
    }
    
    self playsoundtoplayer( #"iw9_deployable_cover_plant_fail", self );
    function_759d7270fe5c66ab();
}

// Namespace tactical_cover
// Params 0
// Checksum 0x4edb65ba, Offset: 0x26a8
// Size: 0x25
function function_759d7270fe5c66ab()
{
    if ( equipment_mp::hasequipment( "equip_tac_cover" ) )
    {
        equipment_mp::incrementequipmentammo( "equip_tac_cover", 1 );
        thread function_8ee7755a63976bfb();
    }
}

// Namespace tactical_cover
// Params 0
// Checksum 0xe456584b, Offset: 0x26d5
// Size: 0x5b
function function_8ee7755a63976bfb()
{
    self endon( #"death_or_disconnect" );
    self notify( #"hash_a08191e2ccb63429" );
    self endon( #"hash_a08191e2ccb63429" );
    level endon( #"game_ended" );
    self waittill( #"hash_2be773c1e7788cde" );
    
    if ( equipment_mp::hasequipment( "equip_tac_cover" ) )
    {
        equipment_mp::decrementequipmentammo( "equip_tac_cover", 1 );
    }
}

// Namespace tactical_cover
// Params 0
// Checksum 0x8dd690d7, Offset: 0x2738
// Size: 0xa
function tac_cover_entmanagerdelete()
{
    thread tac_cover_delete( 0 );
}

// Namespace tactical_cover
// Params 5
// Checksum 0x5be22595, Offset: 0x274a
// Size: 0x183
function tac_cover_spawn_with_door( door, doubledoor, issuper, contents, covertype )
{
    self endon( #"death_or_disconnect" );
    self endon( #"tac_cover_taken" );
    level endon( #"game_ended" );
    assert( isdefined( door ), "<dev string:xea>" );
    playerforward = anglestoforward( self.angles );
    var_cf158cacf2543eff = door function_9ae4daa2a11c58bd() + ( 0, 90, 0 );
    doorforward = anglestoforward( var_cf158cacf2543eff );
    var_fd82ffbda0b82b2a = vectordot( playerforward, doorforward );
    issamedirection = var_fd82ffbda0b82b2a > 0;
    door val::set( "tac_cover_door", "door_frozen", 1 );
    
    if ( isdefined( doubledoor ) )
    {
        doubledoor val::set( "tac_cover_door", "door_frozen", 1 );
    }
    
    offsetangles = issamedirection ? ( 0, 90, 0 ) : ( 0, -90, 0 );
    offsetpos = ( 0, 0, -1 );
    doorpos = door function_50ddcb729a6c2820() + offsetpos;
    doorangles = combineangles( door function_9ae4daa2a11c58bd(), offsetangles );
    var_f980f5247ca5f3ab = undefined;
    tac_cover_spawn( doorpos, doorangles, var_f980f5247ca5f3ab, issuper, contents, door, doubledoor, covertype );
}

// Namespace tactical_cover
// Params 1
// Checksum 0x5114d955, Offset: 0x28d5
// Size: 0x17
function function_a4ebfb83ec0621b9( callbackfunction )
{
    self.elevatordoorsclosecallback = callbackfunction;
}

// Namespace tactical_cover
// Params 8
// Checksum 0xcad68edc, Offset: 0x28f4
// Size: 0x66e, Type: bool
function tac_cover_spawn( position, angles, stuckto, issuper, contents, door, doubledoor, covertype )
{
    self endon( #"death_or_disconnect" );
    self endon( #"tac_cover_taken" );
    level endon( #"game_ended" );
    coverdata = function_311c5721c8f0b0c9( covertype );
    adjustreturn = tac_cover_adjust_for_player_space( position, angles, contents );
    issuper = istrue( issuper );
    
    if ( !adjustreturn[ 1 ] )
    {
        self [[ coverdata.failfunc ]]( 0 );
        
        if ( issuper )
        {
            supers_mp::refundsuper();
        }
        
        return false;
    }
    
    position = adjustreturn[ 0 ];
    self notify( #"tac_cover_spawned" );
    cover = spawn( "script_model", position );
    cover.angles = angles;
    cover.owner = self;
    cover.team = self.team;
    cover.slot = equipment_mp::findequipmentslot( "equip_tac_cover" );
    cover.exploding = 1;
    cover.issuper = issuper ? 1 : undefined;
    cover.superid = coverdata.superid;
    
    if ( isdefined( level.var_59abd25eeb5b2fed ) )
    {
        canplant = cover [[ level.var_59abd25eeb5b2fed ]]();
        
        if ( !canplant )
        {
            self [[ coverdata.failfunc ]]( 0 );
            cover delete();
            
            if ( issuper )
            {
                if ( covertype == "super_tac_cover" )
                {
                    supers_mp::refundsuper();
                }
            }
            
            return false;
        }
    }
    
    cover ent_manager::registerspawn( 2, &tac_cover_entmanagerdelete );
    superinfo = supers_mp::getcurrentsuper();
    superbundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_tac_cover" );
    cover setentityowner( self );
    cover setotherent( self );
    hasblueprint = 0;
    
    if ( isdefined( superbundle ) && isdefined( superinfo ) && level.allowsupers && superinfo.staticdata.ref == "super_tac_cover" )
    {
        genericblueprintname = namespace_de7b719e85d98dcc::function_9800c005d17e1d42( superbundle, superinfo.blueprintindex );
        
        if ( isdefined( genericblueprintname ) )
        {
            cover setgenericblueprintmodel( genericblueprintname, #"worldmodel" );
            hasblueprint = 1;
        }
    }
    
    if ( !hasblueprint )
    {
        cover setmodel( coverdata.modelname );
    }
    
    if ( cover getscriptablehaspart( "allowPing" ) )
    {
        cover setscriptablepartstate( "allowPing", "on", 0 );
    }
    
    if ( isdefined( stuckto ) )
    {
        cover.moving_platform = stuckto;
        
        if ( !isdefined( stuckto.var_348fd0d69ef0920a ) )
        {
            stuckto.var_348fd0d69ef0920a = [];
        }
        
        stuckto.var_348fd0d69ef0920a = arraycombineunique( stuckto.var_348fd0d69ef0920a, [ cover ] );
        data = spawnstruct();
        data.linkparent = cover.moving_platform;
        data.deathoverridecallback = &tac_cover_on_destroyed_by_mover;
        data.validateaccuratetouching = 1;
        cover thread movers::handle_moving_platforms( data );
        cover thread tac_cover_destroy_on_unstuck( coverdata );
    }
    else
    {
        data = spawnstruct();
        data.deathoverridecallback = &tac_cover_on_destroyed_by_mover;
        data.validateaccuratetouching = 1;
        cover thread movers::handle_moving_platforms( data );
    }
    
    if ( isdefined( door ) )
    {
        if ( isdefined( door.blockingcover ) )
        {
            door.blockingcover [[ coverdata.destroyfunc ]]();
        }
        
        cover.blockeddoor = door;
        door.blockingcover = cover;
    }
    
    if ( isdefined( doubledoor ) )
    {
        cover.blockeddoubledoor = doubledoor;
        doubledoor.blockingcover = cover;
    }
    
    thread weapons::monitordisownedequipment( self, cover );
    
    if ( issuper )
    {
        cover thread tac_cover_destroy_on_disowned( self, coverdata );
        cover thread tac_cover_destroy_on_timeout( coverdata );
        cover thread function_242f6f62b81b6158( self, coverdata );
    }
    
    cover function_a4ebfb83ec0621b9( &tac_cover_destroy );
    
    if ( isdefined( level.elevators ) )
    {
        foreach ( elevators in level.elevators )
        {
            elevators thread elevators::deployablecover_isentitytouchingdoortrigger( cover );
        }
    }
    
    cover thread tac_cover_destroy_on_game_end( coverdata );
    
    if ( isdefined( coverdata.onspawnfunc ) )
    {
        self thread [[ coverdata.onspawnfunc ]]( cover );
    }
    
    cover.superref = "super_tac_cover";
    cover.headiconid = entityheadicons::setheadicon_fieldupgrade( cover );
    thread weapons::outlineequipmentforowner( cover );
    cover thread perk_equipmentping::runequipmentping();
    challenges::function_a0936b0e5b4550f3( "super_tac_cover", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"use" ) );
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
    {
        if ( isdefined( self.leaderboarddata[ "deployableCoverUsed" ] ) )
        {
            self.leaderboarddata[ "deployableCoverUsed" ] = self.leaderboarddata[ "deployableCoverUsed" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "deployableCoverUsed" ] ) )
        {
            [[ level.leaderboardfunc[ "deployableCoverUsed" ] ]]( self, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:xbb>" );
        
        if ( isdefined( self.pers[ "deployableCoverUsed" ] ) )
        {
            self.pers[ "deployableCoverUsed" ] = self.pers[ "deployableCoverUsed" ] + 1;
        }
    }
    
    if ( superbundle.var_67296742aaa265f9 )
    {
        cover thread supers_mp::function_24bd67c384c2e606( level.taccover_timeout );
        cover thread supers_mp::function_3a21005bdaf91ac2( superbundle );
        cover thread supers_mp::function_e7c245e9675fdabb( level.taccover_timeout, &tac_cover_destroy );
    }
    
    self notify( #"hash_2be773c1e7788cde" );
    return true;
}

// Namespace tactical_cover
// Params 1
// Checksum 0xb77f8f11, Offset: 0x2f6b
// Size: 0xd7, Type: bool
function tac_cover_reclaim( super )
{
    superowner = super.owner;
    refname = super.superref ?? super.equipmentref;
    superowner supers_mp::function_8cb3b4861e05f17( refname, super.damagetaken, super.timeremaining );
    superowner br_pickups::forcegivesuper( "super_tac_cover", 1, 0, 0, 0 );
    super supers_mp::function_e2c263f3ee5d2d92( super.damagetaken, level.taccover_timeout );
    level thread common_item::function_e8dfe5e68a7a03b4( superowner, supers_mp::function_5ffd3dfa9cc1e8de( "super_tac_cover" ) );
    superowner thread supers_mp::function_5c28588f733c7388( super.timeremaining, level.taccover_timeout );
    super tac_cover_destroy( 1, 0, 0 );
    return true;
}

// Namespace tactical_cover
// Params 1
// Checksum 0x9897c0ea, Offset: 0x304b
// Size: 0x12a
function tac_cover_spawn_internal( cover )
{
    cover endon( #"death" );
    collision = tac_cover_spawn_collision( cover );
    cover validatecollision( collision, level.taccovercollision );
    cover.collision = collision;
    collision.cover = cover;
    collision.moverdoesnotkill = 1;
    var_f82f6cda7a84783a = 1;
    weapons::onequipmentplanted( cover, "equip_tac_cover", &tac_cover_destroy, undefined, var_f82f6cda7a84783a );
    utility::function_969f9f5596dba07a( collision, &function_2894eaa7000e4283 );
    
    if ( false )
    {
        cover tac_cover_set_can_damage( 1 );
    }
    
    if ( isdefined( cover.blockeddoor ) )
    {
        cover setscriptablepartstate( "effects", "plantStartDoor", 0 );
    }
    else
    {
        cover setscriptablepartstate( "effects", "plantStart", 0 );
    }
    
    wait tac_cover_get_deploy_anim_dur();
    
    if ( true )
    {
        cover tac_cover_set_can_damage( 1 );
    }
    
    if ( isdefined( cover.blockeddoor ) )
    {
        cover setscriptablepartstate( "effects", "plantEndDoor", 0 );
        return;
    }
    
    cover setscriptablepartstate( "effects", "plantEnd", 0 );
}

// Namespace tactical_cover
// Params 1
// Checksum 0xf1fd2e8c, Offset: 0x317d
// Size: 0xfb
function tac_cover_spawn_collision( cover )
{
    if ( !isdefined( level.taccovercollision ) )
    {
        return;
    }
    
    collision = spawn( "script_model", cover.origin );
    collision dontinterpolate();
    collision.angles = cover.angles;
    collision clonebrushmodeltoscriptmodel( level.taccovercollision );
    collision linkto( cover );
    collision setentityowner( cover );
    collision disconnectpaths();
    coverdir = anglestoforward( cover.angles );
    var_72425a4a8d49ae02 = cover.origin + coverdir * 25;
    var_7242594a8d49abcf = cover.origin + coverdir * -25;
    createnavlink( "tacCover1", var_72425a4a8d49ae02, var_7242594a8d49abcf, "traverse_warp_across", 1920 );
    createnavlink( "tacCover2", var_7242594a8d49abcf, var_72425a4a8d49ae02, "traverse_warp_across", 1920 );
    return collision;
}

// Namespace tactical_cover
// Params 3
// Checksum 0xdafd4dd3, Offset: 0x3281
// Size: 0x17a
function tac_cover_destroy( immediate, wasdestroyed, killedbyexplosive = 0 )
{
    deletiondelay = 0;
    
    if ( !immediate )
    {
        deletiondelay = 0.2 + tac_cover_get_destroy_anim_dur();
    }
    
    dmg = self.maxhealth;
    
    if ( self.damagetaken < self.maxhealth )
    {
        dmg = self.damagetaken;
    }
    
    if ( !isdefined( dmg ) )
    {
        dmg = 1250;
    }
    
    self.owner challenges::function_a0936b0e5b4550f3( "super_tac_cover", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"end" ), int( dmg ) );
    analyticslog::logevent_fieldupgradeexpired( self.owner, self.superid, int( dmg ), istrue( wasdestroyed ) );
    
    if ( isdefined( self.moving_platform ) )
    {
        index = function_f02c63b99c9614c9( self.moving_platform.var_348fd0d69ef0920a, self );
        
        if ( isdefined( index ) )
        {
            self.moving_platform.var_348fd0d69ef0920a = arrayremove( self.moving_platform.var_348fd0d69ef0920a, self );
            
            if ( self.moving_platform.var_348fd0d69ef0920a.size == 0 )
            {
                self.moving_platform.var_348fd0d69ef0920a = undefined;
            }
        }
    }
    
    thread tac_cover_destroy_internal( deletiondelay, killedbyexplosive );
    thread tac_cover_delete( deletiondelay );
}

// Namespace tactical_cover
// Params 2
// Checksum 0x91500abd, Offset: 0x3403
// Size: 0x14f
function tac_cover_destroy_internal( deletiondelay, killedbyexplosive )
{
    if ( isdefined( self.headiconid ) )
    {
        entityheadicons::setheadicon_deleteicon( self.headiconid );
        self.headiconid = undefined;
    }
    
    if ( !isdefined( killedbyexplosive ) )
    {
        killedbyexplosive = 0;
    }
    
    if ( isdefined( self.blockeddoor ) )
    {
        self.blockeddoor val::reset_all( "tac_cover_door" );
        self.blockeddoor.blockingcover = undefined;
    }
    
    if ( isdefined( self.blockeddoubledoor ) )
    {
        self.blockeddoubledoor val::reset_all( "tac_cover_door" );
        self.blockeddoubledoor.blockingcover = undefined;
    }
    
    if ( deletiondelay > 0 )
    {
        if ( killedbyexplosive >= 1 )
        {
            if ( killedbyexplosive == 1 )
            {
                self setscriptablepartstate( "effects", "destroyStartExplosive" );
            }
            else
            {
                self setscriptablepartstate( "effects", "destroyStartExplosiveBehind" );
            }
        }
        else
        {
            self setscriptablepartstate( "effects", "destroyStart" );
        }
        
        wait tac_cover_get_destroy_anim_dur();
        self setscriptablepartstate( "effects", "destroyEnd" );
    }
    
    if ( isdefined( self.collision ) )
    {
        self.collision connectpaths();
        self.collision delete();
    }
    
    destroynavlink( "tacCover1" );
    destroynavlink( "tacCover2" );
}

// Namespace tactical_cover
// Params 1
// Checksum 0xeb4e2ca9, Offset: 0x355a
// Size: 0xa0
function tac_cover_delete( deletiondelay )
{
    if ( self.isdestroyed )
    {
        return;
    }
    
    self.isdestroyed = 1;
    self notify( #"death" );
    weapon::deregistermine();
    owner = self.owner;
    
    if ( isdefined( owner ) )
    {
        owner weapons::removeequip( self );
    }
    
    if ( true )
    {
        damage::monitordamageend();
        self thermaldrawdisable();
    }
    
    if ( isdefined( self.collision ) )
    {
        self.collision connectpaths();
        self.collision delete();
    }
    
    wait deletiondelay;
    self delete();
}

// Namespace tactical_cover
// Params 0
// Checksum 0xdbfbe07d, Offset: 0x3602
// Size: 0x15
function function_2894eaa7000e4283()
{
    self.cover tac_cover_destroy( 0, 0, 0 );
}

// Namespace tactical_cover
// Params 1
// Checksum 0x8ff8e41d, Offset: 0x361f
// Size: 0x34
function tac_cover_destroy_on_timeout( coverdata )
{
    self endon( #"death" );
    wait level.taccover_timeout;
    self thread [[ coverdata.destroyfunc ]]( undefined, 0, 0 );
}

// Namespace tactical_cover
// Params 1
// Checksum 0x16e5e93d, Offset: 0x365b
// Size: 0x37
function tac_cover_destroy_on_game_end( coverdata )
{
    self endon( #"death" );
    level waittill( #"game_ended" );
    self [[ coverdata.destroyfunc ]]( undefined, 0, 0 );
}

// Namespace tactical_cover
// Params 1
// Checksum 0xa7b877a7, Offset: 0x369a
// Size: 0x37
function tac_cover_destroy_on_unstuck( coverdata )
{
    self endon( #"death" );
    
    while ( isdefined( self getlinkedparent() ) )
    {
        waitframe();
    }
    
    self [[ coverdata.destroyfunc ]]( undefined, 0, 0 );
}

// Namespace tactical_cover
// Params 1
// Checksum 0xa8c36976, Offset: 0x36d9
// Size: 0xa2
function tac_cover_set_can_damage( bool )
{
    if ( true )
    {
        if ( bool )
        {
            hasrugged = isdefined( self.perks[ "specialty_rugged_eqp" ] );
            maxhealth = hasrugged ? 1250 : 1000;
            maxhealth = isdefined( self.perks[ "specialty_mod_health_max" ] ) ? 1250 : 1000;
            damagefeedback = "hitequip";
            thread damage::monitordamage( maxhealth, damagefeedback, &tac_cover_handle_fatal_damage, &tac_cover_handle_damage, 0 );
            self thermaldrawenable();
            return;
        }
        
        damage::monitordamageend();
        self thermaldrawdisable();
    }
}

// Namespace tactical_cover
// Params 1
// Checksum 0x5de3d5b9, Offset: 0x3783
// Size: 0x110
function tac_cover_handle_damage( data )
{
    damage = tac_cover_adjust_damage( data );
    
    if ( isdefined( self.owner ) )
    {
        remaininghealth = max( self.maxhealth - self.damagetaken, 0 );
        reporteddamage = int( min( remaininghealth, damage ) );
        self.owner supers_mp::combatrecordsupermisc( "super_tac_cover", reporteddamage );
        blockscoreevent = level.var_67024f288fe6e88 && self.var_aec62f8d7bb2e199;
        
        if ( data.attacker != self.owner && data.attacker.team != self.owner.team && !blockscoreevent )
        {
            self.var_aec62f8d7bb2e199 = 1;
            self.owner namespace_5f4bb62dbf67ff87::doonactionscoreevent( 1, "tacCoverShot", 3 );
        }
    }
    
    return damage;
}

// Namespace tactical_cover
// Params 1
// Checksum 0x5ff5abc7, Offset: 0x389c
// Size: 0x1fd
function tac_cover_adjust_damage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    meansofdeath = data.meansofdeath;
    damage = data.damage;
    
    if ( objweapon.basename == "thermite_av_mp" )
    {
        return 200;
    }
    
    if ( damage::issmallsplashdamage( data.objweapon ) )
    {
        return 0;
    }
    
    if ( objweapon.basename == "thermite_bolt_mp" )
    {
        return 83.3333;
    }
    
    if ( objweapon.basename == "thermite_xmike109_mp" )
    {
        return 62.5;
    }
    
    if ( weapon::isthrowingknife( objweapon ) || weapon::isthrowingstar( objweapon.basename ) )
    {
        return 0;
    }
    
    if ( meansofdeath == "MOD_MELEE" || meansofdeath == "MOD_IMPACT" )
    {
        if ( meansofdeath == "MOD_IMPACT" && objweapon.classname == "grenade" )
        {
            return damage;
        }
        
        return 333.333;
    }
    
    if ( objweapon.basename == "iw9_dm_crossbow_mp" && meansofdeath != "MOD_MELEE" )
    {
        return 0;
    }
    
    if ( meansofdeath == "MOD_CRUSH" && isdefined( data.inflictor ) && data.inflictor.classname == "script_vehicle" )
    {
        if ( isdefined( attacker ) && !weapons::friendlyfirecheck( self.owner, attacker ) )
        {
            return damage;
        }
    }
    
    if ( isexplosivedamagemod( data.meansofdeath ) )
    {
        if ( objweapon.basename == "semtex_xmike109_mp" )
        {
            return 333.333;
        }
        
        if ( damage >= 9999 )
        {
            return damage;
        }
        
        return 700;
    }
    
    damage = damage::handleapdamage( objweapon, meansofdeath, damage, attacker );
    damage = damage::handleshotgundamage( objweapon, meansofdeath, damage );
    return damage;
}

// Namespace tactical_cover
// Params 1
// Checksum 0x4f68cc03, Offset: 0x3aa2
// Size: 0xe6
function tac_cover_handle_fatal_damage( data )
{
    attacker = data.attacker;
    killedbyexplosive = 0;
    
    if ( data.meansofdeath == "MOD_EXPLOSIVE" )
    {
        killedbyexplosive = 1;
        var_5516b7dbe4fa4804 = anglestoforward( self.angles );
        var_5516b7dbe4fa4804 = vectornormalize( var_5516b7dbe4fa4804 );
        var_7a69be9e5585ab0d = vectortoangles( self.origin - data.point );
        var_7a69be9e5585ab0d = anglestoforward( var_7a69be9e5585ab0d );
        var_7a69be9e5585ab0d = vectornormalize( var_7a69be9e5585ab0d );
        var_767886f991ac2024 = vectordot( var_5516b7dbe4fa4804, var_7a69be9e5585ab0d );
        
        if ( var_767886f991ac2024 >= 0 )
        {
            killedbyexplosive = 2;
        }
    }
    
    if ( player_utility::playersareenemies( self.owner, attacker ) )
    {
        attacker thread points::doscoreevent( #"destroyed_equipment" );
    }
    
    thread tac_cover_destroy( undefined, 1, killedbyexplosive );
}

// Namespace tactical_cover
// Params 0
// Checksum 0x98e714e8, Offset: 0x3b90
// Size: 0x88
function tac_cover_deploy_freeze_controls()
{
    if ( !isdefined( self.taccoverfrozecontrols ) )
    {
        slot = equipment_mp::findequipmentslot( "equip_tac_cover" );
        
        if ( slot == "primary" )
        {
            val::set( "tac_cover_deploy", "equipment_primary", 0 );
        }
        else
        {
            val::set( "tac_cover_deploy", "equipment_secondary", 0 );
        }
        
        val::set( "tac_cover_deploy", "usability", 0 );
        val::set( "tac_cover_deploy", "gesture", 0 );
        self.taccoverfrozecontrols = slot;
    }
}

// Namespace tactical_cover
// Params 0
// Checksum 0x7a41da77, Offset: 0x3c20
// Size: 0x3a
function tac_cover_deploy_unfreeze_controls()
{
    if ( isdefined( self.taccoverfrozecontrols ) )
    {
        slot = self.taccoverfrozecontrols;
        val::reset_all( "tac_cover_deploy" );
        self.taccoverfrozecontrols = undefined;
    }
}

// Namespace tactical_cover
// Params 1
// Checksum 0x90735035, Offset: 0x3c62
// Size: 0x182
function tac_cover_ignore_list( player )
{
    ignorelist = [ player ];
    game_utility::createProjectilePartition();
    
    foreach ( array in level.projectilepartition utility::function_92fef8fe5211a388( player.origin ) )
    {
        foreach ( projectile in array )
        {
            if ( !isdefined( projectile ) )
            {
                continue;
            }
            
            isowner = projectile.owner == player;
            istaccover = projectile.equipmentref == "equip_tac_cover";
            isweapondrop = projectile.equipmentref == "equip_ammo_box";
            
            if ( !isowner && ( istaccover || isweapondrop ) )
            {
                continue;
            }
            
            ignorelist[ ignorelist.size ] = projectile;
        }
    }
    
    return ignorelist;
}

// Namespace tactical_cover
// Params 1
// Checksum 0x579b6563, Offset: 0x3ded
// Size: 0x90, Type: bool
function tac_cover_can_place_on( ent )
{
    if ( isplayer( ent ) )
    {
        return false;
    }
    
    if ( ent getnonstick() )
    {
        return false;
    }
    
    if ( ent.mountmantlemodel )
    {
        return false;
    }
    
    if ( isdefined( ent.cover ) && ent.cover.equipmentref == "equip_tac_cover" )
    {
        return false;
    }
    
    if ( ent.classname == "misc_turret" )
    {
        return false;
    }
    
    if ( ent.classname == "script_vehicle" )
    {
        return false;
    }
    
    return true;
}

#using_animtree( "scriptables" );

// Namespace tactical_cover
// Params 0
// Checksum 0x555b3be0, Offset: 0x3e86
// Size: 0xf
function tac_cover_get_deploy_anim_dur()
{
    return getanimlength( %wm_spawn_2h_deployable_cover_fire );
}

// Namespace tactical_cover
// Params 0
// Checksum 0x9c5f9c4d, Offset: 0x3e9e
// Size: 0x3, Type: bool
function tac_cover_get_destroy_anim_dur()
{
    return false;
}

// Namespace tactical_cover
// Params 0
// Checksum 0xe7a94fc8, Offset: 0x3eaa
// Size: 0xf
function tac_cover_on_fired_super()
{
    return function_833ed4e3d5304b27( 1, "super_tac_cover" );
}

// Namespace tactical_cover
// Params 0
// Checksum 0x8b813f65, Offset: 0x3ec2
// Size: 0xd
function tac_cover_on_take_super()
{
    tac_cover_on_take( undefined, undefined, 1 );
}

// Namespace tactical_cover
// Params 2
// Checksum 0xba5e93b, Offset: 0x3ed7
// Size: 0x53
function tac_cover_destroy_on_disowned( owner, coverdata )
{
    self endon( #"death" );
    owner endon( #"tac_cover_taken" );
    owner utility::waittill_any( "joined_team", "disconnect" );
    self [[ coverdata.destroyfunc ]]( undefined, 0, 0 );
}

// Namespace tactical_cover
// Params 2
// Checksum 0x79501c52, Offset: 0x3f32
// Size: 0x68
function function_242f6f62b81b6158( owner, coverdata )
{
    self endon( #"death" );
    owner endon( #"tac_cover_taken" );
    owner endon( #"joined_team" );
    owner endon( #"disconnect" );
    owner waittill( #"tac_cover_spawned" );
    self thread [[ coverdata.destroyfunc ]]( undefined, 0, 0 );
}

// Namespace tactical_cover
// Params 1
// Checksum 0x387ecbe8, Offset: 0x3fa2
// Size: 0x16
function tac_cover_on_destroyed_by_mover( data )
{
    tac_cover_destroy( undefined, 0, 0 );
}

// Namespace tactical_cover
// Params 5, eflags: 0x4
// Checksum 0xf566dc70, Offset: 0x3fc0
// Size: 0xc9
function private function_31b04984cfb67897( blockerorigin, blockerrad, blockerheight, blockeroffset, var_648d0c8837ac2c4d )
{
    if ( !isdefined( level.var_d29d934032eafa1f ) )
    {
        level.var_d29d934032eafa1f = [];
    }
    
    outblocker = spawnstruct();
    outblocker.targetname = "dcover_blocker_struct";
    outblocker.origin = blockerorigin;
    outblocker.radius = blockerrad;
    outblocker.height = blockerheight;
    outblocker.offset = ( 0, 0, blockeroffset );
    outblocker.var_648d0c8837ac2c4d = var_648d0c8837ac2c4d;
    level.var_d29d934032eafa1f[ level.var_d29d934032eafa1f.size ] = outblocker;
    return outblocker;
}

// Namespace tactical_cover
// Params 1, eflags: 0x4
// Checksum 0x1b622d82, Offset: 0x4092
// Size: 0x29
function private function_253ea80d7aa89506( blockerorigin )
{
    outblocker = function_31b04984cfb67897( blockerorigin, 80, 96, -6, undefined );
    return outblocker;
}

// Namespace tactical_cover
// Params 1, eflags: 0x4
// Checksum 0x374ceea6, Offset: 0x40c4
// Size: 0x29
function private function_36894ebef78e1312( blockerorigin )
{
    outblocker = function_31b04984cfb67897( blockerorigin, 140, 96, -6, undefined );
    return outblocker;
}

// Namespace tactical_cover
// Params 1, eflags: 0x4
// Checksum 0x17029b22, Offset: 0x40f6
// Size: 0x9a
function private function_44b75c6a85a44271( var_b9b6c809a621407f )
{
    assert( var_b9b6c809a621407f.targetname == "<dev string:x105>", "<dev string:x11b>" );
    assert( isvector( var_b9b6c809a621407f.origin ), "<dev string:x15d>" );
    assert( isnumber( var_b9b6c809a621407f.radius ), "<dev string:x1b1>" );
    assert( isnumber( var_b9b6c809a621407f.height ), "<dev string:x205>" );
    
    if ( !isdefined( var_b9b6c809a621407f.offset ) )
    {
        var_b9b6c809a621407f.offset = -6;
    }
}

// Namespace tactical_cover
// Params 2
// Checksum 0x3d099875, Offset: 0x4198
// Size: 0x6b
function function_b62286be6e7bd5ea( fixuporigin, var_1d2504499b240272 )
{
    switch ( var_1d2504499b240272 )
    {
        case 0:
            function_253ea80d7aa89506( fixuporigin );
            break;
        case 1:
            function_36894ebef78e1312( fixuporigin );
            break;
        default:
            assertmsg( "<dev string:x259>" );
            break;
    }
}

// Namespace tactical_cover
// Params 1
// Checksum 0x3505854a, Offset: 0x420b
// Size: 0x5a
function function_392c0c103478e629( var_1d2504499b240272 )
{
    outrad = undefined;
    
    switch ( var_1d2504499b240272 )
    {
        case 0:
            outrad = 80;
            break;
        case 1:
            outrad = 140;
            break;
        default:
            break;
    }
    
    return outrad;
}

// Namespace tactical_cover
// Params 5
// Checksum 0xde7b98c5, Offset: 0x426e
// Size: 0x70
function function_889276bc68f5c2b1( blockerorigin, blockerrad, blockerheight, blockeroffset, var_648d0c8837ac2c4d )
{
    assert( isdefined( blockerorigin ), "<dev string:x2a2>" );
    assert( isdefined( blockerrad ), "<dev string:x2ec>" );
    
    if ( !isdefined( blockerheight ) )
    {
        blockerheight = 96;
    }
    
    if ( !isdefined( blockeroffset ) )
    {
        blockeroffset = -6;
    }
    
    function_31b04984cfb67897( blockerorigin, blockerrad, blockerheight, blockeroffset, var_648d0c8837ac2c4d );
}

// Namespace tactical_cover
// Params 1
// Checksum 0xc7ed58f5, Offset: 0x42e6
// Size: 0xad, Type: bool
function function_3ccdda4fe319f948( targetpos )
{
    if ( 0 || !isdefined( level.var_9dbe78d9b5f80d49 ) )
    {
        return false;
    }
    
    foreach ( invalidtrigger in level.var_9dbe78d9b5f80d49 )
    {
        if ( ispointinvolume( targetpos + ( 0, 0, 8 ), invalidtrigger ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace tactical_cover
// Params 1
// Checksum 0x45708869, Offset: 0x439c
// Size: 0xad, Type: bool
function function_c5748aa5603956d6( targetpos )
{
    if ( 0 || !isdefined( level.var_afb53c07201a0e37 ) )
    {
        return false;
    }
    
    foreach ( invalidvolume in level.var_afb53c07201a0e37 )
    {
        if ( ispointinvolume( targetpos + ( 0, 0, 8 ), invalidvolume ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace tactical_cover
// Params 1
// Checksum 0x2b1fa153, Offset: 0x4452
// Size: 0x136, Type: bool
function function_e83e0149fc5e45ea( targetpos )
{
    if ( 0 || !isdefined( level.var_207b1809714309a ) )
    {
        return false;
    }
    
    foreach ( invalidstruct in level.var_207b1809714309a )
    {
        var_3bf1b5fdc73588b2 = squared( 32 );
        
        if ( isdefined( invalidstruct.radius ) )
        {
            var_3bf1b5fdc73588b2 = squared( invalidstruct.radius );
        }
        
        zmin = invalidstruct.origin[ 2 ] - 8;
        zmax = zmin + ( invalidstruct.height ?? 96 );
        var_5c2c7f82d6fa9220 = targetpos[ 2 ] >= zmin && targetpos[ 2 ] <= zmax;
        
        if ( distance2dsquared( invalidstruct.origin, targetpos ) < var_3bf1b5fdc73588b2 && var_5c2c7f82d6fa9220 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace tactical_cover
// Params 3
// Checksum 0x5a9f99a9, Offset: 0x4591
// Size: 0x9e
function function_fe56b777eaef1846( org, rad, height )
{
    if ( false )
    {
        return 0;
    }
    
    if ( !isdefined( level.var_207b1809714309a ) )
    {
        level.var_207b1809714309a = [];
    }
    
    invalidstruct = spawnstruct();
    invalidstruct.targetname = "dcover_invalid_struct";
    invalidstruct.origin = org;
    invalidstruct.radius = rad;
    invalidstruct.height = height;
    level.var_207b1809714309a[ level.var_207b1809714309a.size ] = invalidstruct;
    return invalidstruct;
}

