// scripts\mp\common\utility\entity.gsc  (hash_3528d80049ffbcc0.gscc) (size: 9134 Bytes / 0x23ae / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8a774d2c (2323074348)
// size ...... 9134 (0x23ae)
// includes .. 4   (offset: 0x222e)
// strings ... 27  (offset: 0x224e)
// dev strs .. 1   (offset: 0x23a2)
// exports ... 40  (offset: 0x172a)
// cseg ...... 0x274 + 0x14b6 (0x172a)
// imports ... 40  (offset: 0x1d6a)
// animtree1 . 0   (offset: 0x23ae)
// animtree2 . 0   (offset: 0x23ae)
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;

#namespace entity;

// Namespace entity
// Params 1
// Checksum 0xf2837f63, Offset: 0x292
// Size: 0xee
function getaverageorigin( ent_array )
{
    avg_origin = ( 0, 0, 0 );
    
    if ( !ent_array.size )
    {
        return;
    }
    
    foreach ( ent in ent_array )
    {
        avg_origin += ent.origin;
    }
    
    avg_x = int( avg_origin[ 0 ] / ent_array.size );
    avg_y = int( avg_origin[ 1 ] / ent_array.size );
    avg_z = int( avg_origin[ 2 ] / ent_array.size );
    avg_origin = ( avg_x, avg_y, avg_z );
    return avg_origin;
}

// Namespace entity
// Params 0
// Checksum 0x3b1bf103, Offset: 0x389
// Size: 0x11d, Type: bool
function touchingbadtrigger()
{
    killtriggers = getentarray( "trigger_hurt", #classname );
    
    foreach ( trigger in killtriggers )
    {
        if ( self istouching( trigger ) )
        {
            return true;
        }
    }
    
    radtriggers = getentarray( "radiation", #targetname );
    
    foreach ( trigger in radtriggers )
    {
        if ( self istouching( trigger ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace entity
// Params 0
// Checksum 0x4ec61ecc, Offset: 0x4af
// Size: 0x9e, Type: bool
function touchingoobtrigger()
{
    if ( self.allowedintrigger )
    {
        return false;
    }
    
    if ( !isdefined( level.outofboundstriggers ) )
    {
        return false;
    }
    
    foreach ( trigger in level.outofboundstriggers )
    {
        if ( self istouching( trigger ) )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace entity
// Params 0
// Checksum 0x6f920cee, Offset: 0x556
// Size: 0xa5, Type: bool
function touchingballallowedtrigger()
{
    if ( !level.ballallowedtriggers.size )
    {
        return false;
    }
    
    self.allowedintrigger = 0;
    
    foreach ( trigger in level.ballallowedtriggers )
    {
        if ( self istouching( trigger ) )
        {
            self.allowedintrigger = 1;
            return true;
        }
    }
    
    return false;
}

// Namespace entity
// Params 0
// Checksum 0x4a7a792d, Offset: 0x604
// Size: 0xa5, Type: bool
function touchingplayerallowedtrigger()
{
    if ( !level.playerallowedtriggers.size )
    {
        return false;
    }
    
    self.allowedintrigger = 0;
    
    foreach ( trigger in level.playerallowedtriggers )
    {
        if ( self istouching( trigger ) )
        {
            self.allowedintrigger = 1;
            return true;
        }
    }
    
    return false;
}

// Namespace entity
// Params 3
// Checksum 0xda7c2f11, Offset: 0x6b2
// Size: 0xbe
function findisfacing( ent1, ent2, tolerance )
{
    facingcosine = cos( tolerance );
    ent1forwardvector = anglestoforward( ent1.angles );
    var_a3a8446082e5c642 = ent2.origin - ent1.origin;
    ent1forwardvector *= ( 1, 1, 0 );
    var_a3a8446082e5c642 *= ( 1, 1, 0 );
    var_a3a8446082e5c642 = vectornormalize( var_a3a8446082e5c642 );
    ent1forwardvector = vectornormalize( ent1forwardvector );
    targetcosine = vectordot( var_a3a8446082e5c642, ent1forwardvector );
    
    if ( targetcosine >= facingcosine )
    {
        return 1;
    }
    
    return 0;
}

// Namespace entity
// Params 3
// Checksum 0x63457843, Offset: 0x778
// Size: 0x2c, Type: bool
function isvalidteamtarget( attacker, victimteam, target )
{
    return target.team == victimteam;
}

// Namespace entity
// Params 3
// Checksum 0x28abeef2, Offset: 0x7ad
// Size: 0x20, Type: bool
function isvalidffatarget( attacker, victimteam, target )
{
    return true;
}

// Namespace entity
// Params 0
// Checksum 0x3e177a3d, Offset: 0x7d6
// Size: 0x7b
function getlinknamenodes()
{
    array = [];
    
    if ( isdefined( self.script_linkto ) )
    {
        linknames = strtok( self.script_linkto, " " );
        
        for ( i = 0; i < linknames.size ; i++ )
        {
            ent = getnode( linknames[ i ], #script_linkname );
            
            if ( isdefined( ent ) )
            {
                array[ array.size ] = ent;
            }
        }
    }
    
    return array;
}

// Namespace entity
// Params 4
// Checksum 0x4db25bc7, Offset: 0x85a
// Size: 0x39
function function_cd55d7a649cb9c44( origin, radius, desiredteam, excludeent )
{
    return getentitiesinradius( origin, radius, desiredteam, excludeent, trace::create_character_contents() );
}

// Namespace entity
// Params 5
// Checksum 0x828fa27a, Offset: 0x89c
// Size: 0x265
function getentitiesinradius( origin, radius, desiredteam, excludeent, physicscontents )
{
    if ( radius <= 0 )
    {
        return [];
    }
    
    excludearray = undefined;
    
    if ( isdefined( excludeent ) )
    {
        if ( isarray( excludeent ) )
        {
            excludearray = excludeent;
        }
        else
        {
            excludearray = [ excludeent ];
        }
    }
    
    results = physics_querypoint( origin, radius, physicscontents, excludearray, "physicsquery_all" );
    filteredresults = [];
    
    if ( !isdefined( desiredteam ) )
    {
        foreach ( result in results )
        {
            e = result[ "entity" ];
            
            if ( isdefined( e ) )
            {
                filteredresults[ filteredresults.size ] = e;
            }
        }
    }
    else
    {
        foreach ( result in results )
        {
            e = result[ "entity" ];
            
            if ( isdefined( e ) && e.team == desiredteam )
            {
                filteredresults[ filteredresults.size ] = e;
            }
        }
    }
    
    /#
        if ( getdvarint( @"hash_9bb67ce9f0ab24e0", 0 ) > 0 )
        {
            debugduration = 60;
            sphere( origin, radius, ( 1, 1, 1 ), 0, debugduration );
            
            foreach ( entity in filteredresults )
            {
                sphere( entity.origin, 10, ( 1, 0, 0 ), 1, debugduration );
            }
        }
    #/
    
    return filteredresults;
}

// Namespace entity
// Params 5
// Checksum 0xef50fbe9, Offset: 0xb0a
// Size: 0x1b4
function watchentitiesinradius( radiusrange, triggernotify, var_f206928b5d1ec403, checkvisibility, playersonly )
{
    self endon( #"disconnect" );
    self endon( #"hash_4d5acba90ede7a8d" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( !isdefined( self ) )
        {
            return;
        }
        
        entitiesfound = undefined;
        
        if ( playersonly )
        {
            entitiesfound = player_utility::script_getplayersinradius( self.origin, radiusrange );
        }
        else
        {
            entitiesfound = getentitiesinradius( self.origin, radiusrange );
        }
        
        if ( entitiesfound.size > 0 )
        {
            if ( !checkvisibility )
            {
                self notify( triggernotify, entitiesfound );
            }
            else
            {
                entities = [];
                
                foreach ( entityfound in entitiesfound )
                {
                    sourceposition = self getorigin();
                    targetposition = playersonly ? entityfound geteye() : entityfound.origin;
                    raycastcontents = physics_createcontents( [ "physicscontents_vehicleclip", "physicscontents_item", "physicscontents_ainoshoot" ] );
                    raycastresults = physics_raycast( sourceposition, targetposition, raycastcontents, undefined, 0, "physicsquery_closest" );
                    
                    if ( raycastresults.size <= 0 )
                    {
                        entities[ entities.size ] = entityfound;
                    }
                }
                
                self notify( triggernotify, entities );
            }
        }
        
        wait var_f206928b5d1ec403;
    }
}

// Namespace entity
// Params 0
// Checksum 0xe15269fd, Offset: 0xcc6
// Size: 0xe
function cancelentitiesinradius()
{
    self notify( #"hash_4d5acba90ede7a8d" );
}

// Namespace entity
// Params 4
// Checksum 0xe69b9b8b, Offset: 0xcdc
// Size: 0x130
function placeequipmentfailed( weapon, showfx, position, angles )
{
    assert( isdefined( showfx ) && isdefined( position ) || !isdefined( showfx ) && !isdefined( position ) );
    self playlocalsound( "scavenger_pack_pickup" );
    
    if ( showfx )
    {
        fxent = undefined;
        
        if ( isdefined( angles ) )
        {
            fxent = spawnfxforclient( utility::getfx( "placeEquipmentFailed" ), position, self, anglestoforward( angles ), anglestoup( angles ) );
        }
        else
        {
            fxent = spawnfxforclient( utility::getfx( "placeEquipmentFailed" ), position, self );
        }
        
        triggerfx( fxent );
        thread placeequipmentfailedcleanup( fxent );
    }
    
    weaponobj = utility::function_64003742d8f5c781( weapon );
    
    switch ( weaponobj.basenamehash )
    {
        case %"trip_mine_mp":
        case %"cryo_mine_mp":
        case %"trophy_mp":
        case %"deployable_cover_mp":
        case %"micro_turret_mp":
            if ( isplayer( self ) && player::isreallyalive() )
            {
                self iprintlnbold( "Placement Failed" );
            }
            
            break;
    }
}

// Namespace entity
// Params 0
// Checksum 0x6b171647, Offset: 0xe14
// Size: 0x1b
function placeequipmentfailedinit()
{
    level._effect[ "placeEquipmentFailed" ] = loadfxasset( "vfx_iw7_requests_mp_generic_equip_explo" );
}

// Namespace entity
// Params 1
// Checksum 0x641574e7, Offset: 0xe37
// Size: 0x16
function placeequipmentfailedcleanup( fxent )
{
    wait 2;
    fxent delete();
}

// Namespace entity
// Params 1
// Checksum 0xb4658ae2, Offset: 0xe55
// Size: 0x18, Type: bool
function isspidergrenade( ent )
{
    return istrue( ent.isspidergrenade );
}

// Namespace entity
// Params 1
// Checksum 0x92345eef, Offset: 0xe76
// Size: 0x7e, Type: bool
function issupertrophy( ent )
{
    entnum = ent getentitynumber();
    
    if ( !isdefined( level.supertrophy ) )
    {
        return false;
    }
    
    if ( !isdefined( level.supertrophy.trophies ) )
    {
        return false;
    }
    
    if ( !isdefined( level.supertrophy.trophies[ entnum ] ) )
    {
        return false;
    }
    
    return level.supertrophy.trophies[ entnum ] == ent;
}

// Namespace entity
// Params 1
// Checksum 0xf629617b, Offset: 0xefd
// Size: 0x50, Type: bool
function ismicroturret( ent )
{
    entnum = ent getentitynumber();
    
    if ( !isdefined( level.microturrets ) )
    {
        return false;
    }
    
    if ( !isdefined( level.microturrets[ entnum ] ) )
    {
        return false;
    }
    
    return level.microturrets[ entnum ] == ent;
}

// Namespace entity
// Params 1
// Checksum 0x1b39e69e, Offset: 0xf56
// Size: 0x63
function ischoppergunner( ent )
{
    if ( !isdefined( ent.streakinfo ) )
    {
        return 0;
    }
    
    if ( !isdefined( ent.streakinfo.streakname ) )
    {
        return 0;
    }
    
    ischopper = ent.streakinfo.streakname == "chopper_gunner";
    return ischopper;
}

// Namespace entity
// Params 1
// Checksum 0x90ddb80a, Offset: 0xfc2
// Size: 0x63
function issupporthelo( ent )
{
    if ( !isdefined( ent.streakinfo ) )
    {
        return 0;
    }
    
    if ( !isdefined( ent.streakinfo.streakname ) )
    {
        return 0;
    }
    
    ischopper = ent.streakinfo.streakname == "chopper_support";
    return ischopper;
}

// Namespace entity
// Params 1
// Checksum 0x899b0e05, Offset: 0x102e
// Size: 0x63
function isclusterstrike( ent )
{
    if ( !isdefined( ent.streakinfo ) )
    {
        return 0;
    }
    
    if ( !isdefined( ent.streakinfo.streakname ) )
    {
        return 0;
    }
    
    var_3b65f7f11c3d7cca = ent.streakinfo.streakname == "toma_strike";
    return var_3b65f7f11c3d7cca;
}

// Namespace entity
// Params 1
// Checksum 0xcb3698ec, Offset: 0x109a
// Size: 0x9a, Type: bool
function isuav( ent )
{
    if ( !isdefined( ent.streakinfo ) )
    {
        return false;
    }
    
    if ( !isdefined( ent.streakinfo.streakname ) )
    {
        return false;
    }
    
    if ( ent.streakinfo.streakname == "uav" || ent.streakinfo.streakname == "counter_uav" || ent.streakinfo.streakname == "directional_uav" )
    {
        return true;
    }
    
    return false;
}

// Namespace entity
// Params 1
// Checksum 0xda6ee2c, Offset: 0x113d
// Size: 0x63
function isgunship( ent )
{
    if ( !isdefined( ent.streakinfo ) )
    {
        return 0;
    }
    
    if ( !isdefined( ent.streakinfo.streakname ) )
    {
        return 0;
    }
    
    var_1adc2b3dcb572828 = ent.streakinfo.streakname == "gunship";
    return var_1adc2b3dcb572828;
}

// Namespace entity
// Params 1
// Checksum 0x505feb19, Offset: 0x11a9
// Size: 0xa1
function isradardrone( ent )
{
    if ( !isdefined( ent.streakinfo ) )
    {
        return 0;
    }
    
    if ( !isdefined( ent.streakinfo.streakname ) )
    {
        return 0;
    }
    
    isradar = ent.streakinfo.streakname == "radar_drone_escort" || ent.streakinfo.streakname == "radar_drone_recon" || ent.streakinfo.streakname == "recon_drone_dmz_mission";
    return isradar;
}

// Namespace entity
// Params 1
// Checksum 0x1bf18f9e, Offset: 0x1253
// Size: 0x82
function isscramblerdrone( ent )
{
    if ( !isdefined( ent.streakinfo ) )
    {
        return 0;
    }
    
    if ( !isdefined( ent.streakinfo.streakname ) )
    {
        return 0;
    }
    
    isscrambler = ent.streakinfo.streakname == "scrambler_drone_guard" || ent.streakinfo.streakname == "counter_uav";
    return isscrambler;
}

// Namespace entity
// Params 1
// Checksum 0xba455c3c, Offset: 0x12de
// Size: 0x63
function isradarhelicopter( ent )
{
    if ( !isdefined( ent.streakinfo ) )
    {
        return 0;
    }
    
    if ( !isdefined( ent.streakinfo.streakname ) )
    {
        return 0;
    }
    
    isradar = ent.streakinfo.streakname == "radar_drone_overwatch";
    return isradar;
}

// Namespace entity
// Params 1
// Checksum 0xf274296f, Offset: 0x134a
// Size: 0x63
function isassaultdrone( ent )
{
    if ( !isdefined( ent.streakinfo ) )
    {
        return 0;
    }
    
    if ( !isdefined( ent.streakinfo.streakname ) )
    {
        return 0;
    }
    
    isradar = ent.streakinfo.streakname == "assault_drone";
    return isradar;
}

// Namespace entity
// Params 1
// Checksum 0x422fc8b5, Offset: 0x13b6
// Size: 0x1d, Type: bool
function isturret( ent )
{
    return ent.classname == "misc_turret";
}

// Namespace entity
// Params 1
// Checksum 0x25d4eb03, Offset: 0x13dc
// Size: 0x18, Type: bool
function isdronepackage( ent )
{
    return isdefined( ent.cratetype );
}

// Namespace entity
// Params 0
// Checksum 0x3cf63dad, Offset: 0x13fd
// Size: 0x38
function _enableequipdeployvfx()
{
    if ( !isdefined( self.enabledequipdeployvfx ) )
    {
        self.enabledequipdeployvfx = 0;
    }
    
    if ( self.enabledequipdeployvfx == 0 )
    {
        self enableequipdeployvfx( 1 );
    }
    
    self.enabledequipdeployvfx++;
}

// Namespace entity
// Params 0
// Checksum 0xa0a019d8, Offset: 0x143d
// Size: 0x3a
function _disableequipdeployvfx()
{
    assert( self.enabledequipdeployvfx > 0, "<dev string:x24>" );
    
    if ( self.enabledequipdeployvfx == 1 )
    {
        self enableequipdeployvfx( 0 );
    }
    
    self.enabledequipdeployvfx--;
}

// Namespace entity
// Params 0
// Checksum 0x4241a537, Offset: 0x147f
// Size: 0x99
function register_physics_collisions()
{
    self endon( #"death" );
    self endon( #"hash_38a469a335f93bbf" );
    
    while ( true )
    {
        self waittill( #"collision", body0, body1, flag0, flag1, position, normal, impulse, ent );
        level notify( #"physsnd", self, body0, body1, flag0, flag1, position, normal, impulse, ent );
    }
}

// Namespace entity
// Params 0
// Checksum 0xe3a802bc, Offset: 0x1520
// Size: 0xbb
function global_physics_sound_monitor()
{
    level notify( #"physics_monitor" );
    level endon( #"physics_monitor" );
    
    while ( true )
    {
        level waittill( #"physsnd", var_38d10cea9da84c59, body0, body1, flag0, flag1, position, normal, impulse, collided_ent );
        
        if ( isdefined( var_38d10cea9da84c59 ) && isdefined( var_38d10cea9da84c59.phys_sound_func ) )
        {
            level thread [[ var_38d10cea9da84c59.phys_sound_func ]]( var_38d10cea9da84c59, body0, body1, flag0, flag1, position, normal, impulse, collided_ent );
        }
    }
}

// Namespace entity
// Params 2
// Checksum 0x4beb1579, Offset: 0x15e3
// Size: 0x23
function register_physics_collision_func( entity, function_name )
{
    entity.phys_sound_func = function_name;
}

// Namespace entity
// Params 1
// Checksum 0x896583c7, Offset: 0x160e
// Size: 0x18, Type: bool
function istouchingboundstrigger( ent )
{
    return istrue( ent.alreadytouchingtrigger );
}

// Namespace entity
// Params 1
// Checksum 0x5bc1ae87, Offset: 0x162f
// Size: 0xa9
function istouchingboundsnullify( ent )
{
    var_8508d041a1ef8314 = 0;
    
    if ( level.outofboundstriggerpatches.size > 0 )
    {
        foreach ( patch in level.outofboundstriggerpatches )
        {
            if ( ent istouching( patch ) )
            {
                var_8508d041a1ef8314 = 1;
                break;
            }
        }
    }
    
    return var_8508d041a1ef8314;
}

// Namespace entity
// Params 1
// Checksum 0xa24ef0a5, Offset: 0x16e1
// Size: 0x2c
function deleteonplayerdeathdisconnect( player )
{
    self endon( #"death" );
    player waittill( #"death_or_disconnect" );
    self delete();
}

// Namespace entity
// Params 0
// Checksum 0xa9d421d1, Offset: 0x1715
// Size: 0x15
function deleteatframeend()
{
    self endon( #"death" );
    waittillframeend();
    self delete();
}

