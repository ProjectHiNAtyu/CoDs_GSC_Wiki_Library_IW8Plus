// scripts\mp\common\utility\equipment.gsc  (hash_0f11689e279a5173.gscc) (size: 6165 Bytes / 0x1815 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x50c39179 (1354994041)
// size ...... 6165 (0x1815)
// includes .. 1   (offset: 0x170d)
// strings ... 11  (offset: 0x1715)
// dev strs .. 7   (offset: 0x17c1)
// exports ... 12  (offset: 0x1175)
// cseg ...... 0x141 + 0x1034 (0x1175)
// imports ... 30  (offset: 0x1355)
// animtree1 . 0   (offset: 0x1815)
// animtree2 . 0   (offset: 0x1815)
#using scripts\common\script;

#namespace equipment;

// Namespace equipment
// Params 0
// Checksum 0x6f9f7510, Offset: 0x15f
// Size: 0x151
function get_mine_ignore_list()
{
    ignorelist = [ self ];
    
    if ( isdefined( level.dynamicladders ) )
    {
        foreach ( struct in level.dynamicladders )
        {
            ignorelist[ ignorelist.size ] = struct.ents[ 0 ];
        }
    }
    
    linkedents = self getlinkedchildren( 1 );
    
    if ( !isdefined( linkedents ) )
    {
        linkedents = [];
    }
    
    linkedents[ linkedents.size ] = self getlinkedparent();
    
    foreach ( linkedent in linkedents )
    {
        if ( isdefined( linkedent ) && linkedent.classname == "grenade" )
        {
            ignorelist[ ignorelist.size ] = linkedent;
        }
    }
    
    return ignorelist;
}

// Namespace equipment
// Params 6
// Checksum 0x5a9427d6, Offset: 0x2b9
// Size: 0x427
function get_sticky_grenade_destination( grenade, gunangles, speedforward, speedup, fusetime, data )
{
    assert( speedforward != 0 && speedup != 0, "<dev string:x24>" );
    grenade endon( #"death" );
    
    if ( !isdefined( data ) )
    {
        data = spawnstruct();
    }
    
    if ( !isdefined( data.contents ) )
    {
        data.contents = get_grenade_cast_contents();
    }
    
    if ( !isdefined( data.divisions ) )
    {
        data.divisions = 5;
    }
    
    if ( !isdefined( data.amortize ) )
    {
        data.amortize = 1;
    }
    
    if ( !isdefined( data.ignorelist ) )
    {
        data.ignorelist = [ grenade, grenade.owner ];
    }
    
    if ( !isdefined( data.ignorclutter ) )
    {
        data.ignoreclutter = 1;
    }
    
    if ( !isdefined( fusetime ) )
    {
        fusetime = 10;
    }
    
    if ( !isdefined( data.maxtime ) )
    {
        data.maxtime = fusetime - fusetime * grenade.tickpercent;
    }
    
    assert( data.maxtime > 0, "<dev string:x73>" );
    assert( data.divisions > 0, "<dev string:xb8>" );
    steptime = data.maxtime / data.divisions;
    times[ 0 ] = 0;
    positions[ 0 ] = grenade.origin;
    var_d5060a3ff8bdc9f8 = data.divisions;
    dirforward = anglestoforward( gunangles );
    dirup = ( 0, 0, 1 );
    vel = dirforward * speedforward + dirup * speedup;
    velvert = dirup * vectordot( dirup, vel );
    var_63bebedb5d49e51d = vel - velvert;
    
    for ( i = 1; i < data.divisions ; i++ )
    {
        prevtime = times[ i - 1 ];
        prevposition = positions[ i - 1 ];
        nexttime = i * steptime;
        var_661e7942f0e78a51 = var_63bebedb5d49e51d * nexttime;
        offsetvert = velvert * nexttime + 0.5 * ( 0, 0, -800 ) * nexttime * nexttime;
        nextposition = positions[ 0 ] + var_661e7942f0e78a51 + offsetvert;
        times[ i ] = nexttime;
        positions[ i ] = nextposition;
        results = physics_raycast( prevposition, nextposition, data.contents, data.ignorelist, 1, "physicsquery_closest", data.ignoreclutter );
        
        if ( results.size > 0 )
        {
            /#
                var_d5060a3ff8bdc9f8 = i;
            #/
            
            data.destination = results[ 0 ][ "position" ];
            data.destinationnormal = results[ 0 ][ "normal" ];
            data.destinationentity = results[ 0 ][ "entity" ];
            data.destinationhit = 1;
            var_82974e3d5d2bcee3 = nextposition - prevposition;
            var_22234cd9248b8a53 = length( var_82974e3d5d2bcee3 );
            var_162850cfbb6774e2 = var_82974e3d5d2bcee3 / var_22234cd9248b8a53;
            prevtodest = prevposition - data.destination;
            var_39568d2f03a1de5a = vectordot( var_162850cfbb6774e2, prevtodest );
            var_ca9567244e185370 = clamp( var_39568d2f03a1de5a / var_22234cd9248b8a53, 0, 1 );
            data.destinationtime = prevtime + steptime * var_ca9567244e185370;
            break;
        }
        else if ( i == data.divisions - 1 )
        {
            data.destination = nextposition;
            break;
        }
        
        if ( data.amortize )
        {
            waitframe();
        }
    }
    
    /#
    #/
    
    return data;
}

// Namespace equipment
// Params 1
// Checksum 0x9c768dc0, Offset: 0x6e9
// Size: 0x94
function get_grenade_cast_contents( includeplayers )
{
    contents = undefined;
    
    if ( includeplayers )
    {
        contents = physics_createcontents( [ "physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_glass", "physicscontents_water", "physicscontents_characterproxy" ] );
    }
    else
    {
        contents = physics_createcontents( [ "physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_glass", "physicscontents_water" ] );
    }
    
    return contents;
}

// Namespace equipment
// Params 2
// Checksum 0x53b38f21, Offset: 0x786
// Size: 0x679
function plant( grenade, data )
{
    self endon( #"death_or_disconnect" );
    grenade endon( #"death" );
    outparams = { #result:0 };
    assert( isdefined( grenade ), "<dev string:xff>" );
    assert( isdefined( data ), "<dev string:x126>" );
    assert( isdefined( data.throwspeedforward ), "<dev string:x14a>" );
    assert( isdefined( data.throwspeedup ), "<dev string:x180>" );
    grenade.releasegrenadeorigin = grenade.origin;
    grenade.releaseownerorigin = self.origin;
    grenade.releaseownereye = self geteye();
    grenade.releaseownerangles = self getgunangles();
    
    if ( !isdefined( data.plantmaxtime ) )
    {
        data.plantmaxtime = 0.5;
    }
    
    if ( !isdefined( data.plantmaxroll ) )
    {
        data.plantmaxroll = 0;
    }
    
    if ( !isdefined( data.plantmindistbeloweye ) )
    {
        data.plantmindistbeloweye = 12;
    }
    
    if ( !isdefined( data.plantmaxdistbelowownerfeet ) )
    {
        data.plantmaxdistbelowownerfeet = 20;
    }
    
    if ( !isdefined( data.plantmindisteyetofeet ) )
    {
        data.plantmindisteyetofeet = 45;
    }
    
    if ( !isdefined( data.plantnormalcos ) )
    {
        data.plantnormalcos = 0.342;
    }
    
    if ( !isdefined( data.plantoffsetz ) )
    {
        data.plantoffsetz = 1;
    }
    
    plant_watch_stuck( grenade, data );
    
    if ( data.waterimpact )
    {
        outparams.waterimpact = 1;
        return outparams;
    }
    
    var_c77a95ad85feed2e = 0;
    position = data.notifyorigin;
    normal = data.notifynormal;
    linkedparent = data.notifyentity;
    stuck = data.notifyhit;
    angles = undefined;
    
    if ( !stuck )
    {
        position = data.calcorigin;
        normal = data.calcnormal;
        linkedparent = data.calcentity;
        stuck = data.calchit;
        
        if ( stuck && isdefined( linkedparent ) && linkedparent getnonstick() )
        {
            stuck = undefined;
        }
        
        contents = get_grenade_cast_contents( 0 );
        ignorelist = [ grenade ];
        caststart = self geteye() - ( 0, 0, 30 );
        castend = caststart + anglestoforward( self getplayerangles( 1 ) ) * 20;
        results = physics_raycast( caststart, castend, contents, ignorelist, 0, "physicsquery_closest", 1 );
        
        if ( results.size > 0 )
        {
            stuck = 0;
        }
    }
    else
    {
        angles = plant_clamp_angles( grenade.angles, data );
    }
    
    if ( stuck )
    {
        if ( isdefined( normal ) && vectordot( normal, ( 0, 0, 1 ) ) < data.plantnormalcos )
        {
            var_c77a95ad85feed2e = 1;
        }
        else
        {
            var_54952b94c2beedeb = vectordot( grenade.releaseownerorigin - position, ( 0, 0, 1 ) );
            
            if ( var_54952b94c2beedeb > 0 && !data.var_7d250c296decddc9 )
            {
                if ( var_54952b94c2beedeb > data.plantmaxdistbelowownerfeet )
                {
                    var_c77a95ad85feed2e = 1;
                }
            }
            else
            {
                var_b0e467da08476220 = vectordot( grenade.releaseownereye - grenade.releaseownerorigin, ( 0, 0, 1 ) );
                
                if ( var_b0e467da08476220 > data.plantmindisteyetofeet )
                {
                    distbeloweye = vectordot( grenade.releaseownereye - position, ( 0, 0, 1 ) );
                    
                    if ( distbeloweye >= 0 )
                    {
                        if ( distbeloweye < data.plantmindistbeloweye )
                        {
                            var_c77a95ad85feed2e = 1;
                        }
                    }
                    else
                    {
                        var_c77a95ad85feed2e = 1;
                    }
                }
            }
        }
    }
    else
    {
        var_c77a95ad85feed2e = 1;
    }
    
    if ( var_c77a95ad85feed2e )
    {
        contents = data.castcontents;
        
        if ( !isdefined( contents ) )
        {
            contents = get_grenade_cast_contents();
        }
        
        ignorelist = [ grenade ];
        caststart = grenade.releaseownerorigin + ( 0, 0, 1 );
        castend = caststart + ( 0, 0, -1 * data.plantmaxdistbelowownerfeet );
        results = physics_raycast( caststart, castend, contents, ignorelist, 1, "physicsquery_closest", 1 );
        
        if ( results.size > 0 )
        {
            position = results[ 0 ][ "position" ];
            normal = results[ 0 ][ "normal" ];
            
            if ( isdefined( normal ) && vectordot( normal, ( 0, 0, 1 ) ) < data.plantnormalcos )
            {
                return outparams;
            }
            
            var_e797693b73323dc0 = grenade.releaseownerangles * ( 0, 1, 0 );
            
            if ( isdefined( normal ) )
            {
                angles = script::vectortoanglessafe( anglestoforward( var_e797693b73323dc0 ), normal );
                angles = plant_clamp_angles( angles, data );
            }
            else
            {
                angles = var_e797693b73323dc0;
            }
            
            position += anglestoup( angles ) * data.plantoffsetz;
            linkedparent = results[ 0 ][ "entity" ];
            grenade dontinterpolate();
            grenade.origin = position;
            grenade.angles = angles;
            
            /#
            #/
        }
        else
        {
            return outparams;
        }
    }
    else
    {
        if ( !isdefined( angles ) )
        {
            var_e797693b73323dc0 = grenade.releaseownerangles * ( 0, 1, 0 );
            
            if ( isdefined( normal ) )
            {
                angles = script::vectortoanglessafe( anglestoforward( var_e797693b73323dc0 ), normal );
                angles = plant_clamp_angles( angles, data );
            }
            else
            {
                angles = var_e797693b73323dc0;
            }
        }
        
        position += anglestoup( angles ) * data.plantoffsetz;
        grenade dontinterpolate();
        grenade.origin = position;
        grenade.angles = angles;
        
        /#
        #/
    }
    
    outparams.result = 1;
    
    if ( isdefined( linkedparent ) )
    {
        if ( !data.var_8fa73627c255b85d && isweapon( linkedparent.weapon_object ) )
        {
            outparams.result = undefined;
        }
        else
        {
            grenade linkto( linkedparent );
        }
    }
    
    return outparams;
}

// Namespace equipment
// Params 2
// Checksum 0x291b2cdf, Offset: 0xe08
// Size: 0x69
function plant_watch_stuck( grenade, data )
{
    childthread plant_watch_stuck_notify( grenade, data );
    
    if ( data.detectwater )
    {
        childthread function_beb96854d8421bf0( grenade, data );
    }
    
    childthread plant_watch_stuck_calculate( grenade, data );
    childthread plant_watch_stuck_timeout( grenade, data );
    data waittill( #"start_race" );
    waittillframeend();
    data notify( #"end_race" );
    return data;
}

// Namespace equipment
// Params 2
// Checksum 0x267bf00, Offset: 0xe7a
// Size: 0x93
function plant_watch_stuck_notify( grenade, data )
{
    data endon( #"end_race" );
    grenade waittill( #"missile_stuck", stuckto );
    data.notifyorigin = grenade.origin;
    data.notifyangles = grenade.angles;
    data.notifyentity = stuckto;
    data.notifyhit = 1;
    data notify( #"start_race" );
}

// Namespace equipment
// Params 2
// Checksum 0xc1902fb5, Offset: 0xf15
// Size: 0x4b
function function_beb96854d8421bf0( grenade, data )
{
    data endon( #"end_race" );
    grenade waittill( #"missile_water_impact" );
    data.waterimpact = 1;
    data notify( #"start_race" );
}

// Namespace equipment
// Params 2
// Checksum 0x85d58222, Offset: 0xf68
// Size: 0xb6
function plant_watch_stuck_calculate( grenade, data )
{
    data endon( #"end_race" );
    data = get_sticky_grenade_destination( grenade, grenade.releaseownerangles, data.throwspeedforward, data.throwspeedup, data.castmaxtime, data );
    data.calcorigin = data.destination;
    data.calcnormal = data.destinationnormal;
    data.calcentity = data.destinationentity;
    data.calchit = data.destinationhit;
}

// Namespace equipment
// Params 2
// Checksum 0x66c9c597, Offset: 0x1026
// Size: 0x3b
function plant_watch_stuck_timeout( grenade, data )
{
    data endon( #"end_race" );
    wait data.plantmaxtime;
    data notify( #"start_race" );
}

// Namespace equipment
// Params 2
// Checksum 0xa2761aac, Offset: 0x1069
// Size: 0x97
function plant_clamp_angles( angles, data )
{
    pitch = 0;
    yaw = angles[ 1 ];
    roll = data.plantmaxroll != 0 ? angles[ 2 ] : 0;
    
    if ( roll != 0 )
    {
        if ( roll > 0 )
        {
            roll = clamp( angles[ 2 ], 0, data.plantmaxroll );
        }
        else
        {
            roll = clamp( angles[ 2 ], -1 * data.plantmaxroll, 0 );
        }
    }
    
    return ( pitch, yaw, roll );
}

// Namespace equipment
// Params 0
// Checksum 0x76ee9dbf, Offset: 0x1109
// Size: 0x6c
function watch_flight_collision()
{
    original_pos = self.origin;
    
    while ( true )
    {
        self waittill( #"touching_platform", platform );
        
        if ( isdefined( platform ) && self istouching( platform ) && self.origin[ 2 ] - original_pos[ 2 ] > 12 )
        {
            self notify( #"hash_85770249d18c9ac2" );
            return;
        }
    }
}

