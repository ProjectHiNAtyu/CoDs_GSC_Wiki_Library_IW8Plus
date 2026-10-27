// scripts\quaked\script_struct_mp_littlebird.gsc  (hash_69a61780e1cc21a9.gscc) (size: 8464 Bytes / 0x2110 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe615d123 (3860189475)
// size ...... 8464 (0x2110)
// includes .. 6   (offset: 0x1fcc)
// strings ... 9   (offset: 0x1ffc)
// dev strs .. 11  (offset: 0x2088)
// exports ... 19  (offset: 0x14b0)
// cseg ...... 0x10c + 0x13a4 (0x14b0)
// imports ... 68  (offset: 0x17a8)
// animtree1 . 0   (offset: 0x2110)
// animtree2 . 0   (offset: 0x2110)
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_omnvar_utility;

#namespace namespace_d041019241996409;

// Namespace namespace_d041019241996409
// Params 0, eflags: 0x5
// Checksum 0x395f8428, Offset: 0x12a
// Size: 0x45
function private autoexec main()
{
    vehicle::register_vehicle_init( level.projectbundle.var_53c4124af039142e ? vehicle::function_ce37932c0f5e0c24( #"scripts/quaked/script_struct_mp_littlebird.gsc" ) : vehicle::function_c9d59ae50eee9bb1( #"scripts/quaked/script_struct_mp_littlebird.gsc" ), &little_bird_init );
}

// Namespace namespace_d041019241996409
// Params 0, eflags: 0x4
// Checksum 0xaaefab37, Offset: 0x177
// Size: 0x24c
function private little_bird_init()
{
    level.lb_dmg_factor_driverless_collision = getdvarfloat( @"hash_e85cda72d3c3c14b", 4 );
    level.var_7701196561e84e2c = getdvarfloat( @"hash_270ecb2b6990667f", 0.25 );
    level.var_256dee426f01084f = getdvarfloat( @"hash_b452f0068f4e43da", 0.75 );
    level.lb_impulse_dmg_threshold_top = getdvarfloat( @"hash_3d4b0c0e7008d889", 0.9 );
    level.lb_impulse_dmg_threshold_mid = getdvarfloat( @"hash_eeaced8fd62d7d31", 0.5 );
    level.lb_impulse_dmg_threshold_low = getdvarfloat( @"hash_fada138fde409535", 0.2 );
    level.lb_impulse_dmg_factor_low = getdvarfloat( @"hash_12c7a9c89bf6ed57", 0.1 );
    level.lb_impulse_dmg_factor_mid_low = getdvarfloat( @"hash_dc50e2e689514b56", 0.2 );
    level.lb_impulse_dmg_factor_mid_high = getdvarfloat( @"hash_555a8558a6d3b598", 0.75 );
    level.lb_pitch_roll_dmg_threshold = getdvarfloat( @"hash_f1d6ba97f092c311", 55 );
    level.lb_pitch_roll_dmg_factor = getdvarfloat( @"hash_c606efb22605e501", 10 );
    level.lb_wood_surf_dmg_scalar = getdvarfloat( @"hash_4d381994cf7e3faa", 0.6 );
    callbacks[ #"spawn" ] = &little_bird_create;
    callbacks[ #"enterStart" ] = &little_bird_enterstart;
    callbacks[ #"enterEnd" ] = &little_bird_enterend;
    callbacks[ #"exitEnd" ] = &little_bird_exitend;
    
    foreach ( bundle in level.projectbundle.var_53c4124af039142e ? vehicle::function_c6ddf8290297c267( #"scripts/quaked/script_struct_mp_littlebird.gsc" ) : vehicle::function_df320a3328c73fb5( #"scripts/quaked/script_struct_mp_littlebird.gsc" ) )
    {
        vehicle::generic_init( bundle, callbacks );
        little_bird_initdamage( bundle );
        little_bird_initomnvars( bundle );
    }
}

// Namespace namespace_d041019241996409
// Params 1, eflags: 0x4
// Checksum 0x1f76ab09, Offset: 0x3cb
// Size: 0x34
function private little_bird_initomnvars( bundle )
{
    leveldataforvehicle = vehicle_omnvar::get_data( bundle );
    leveldataforvehicle.ammoids[ "flares" ] = 1;
}

// Namespace namespace_d041019241996409
// Params 1, eflags: 0x4
// Checksum 0xb7c3db07, Offset: 0x407
// Size: 0x49
function private little_bird_initdamage( bundle )
{
    leveldatafordamagestate = vehicle_damage::function_9a9c7f377e631a4d( bundle, "heavy", 1 );
    leveldatafordamagestate.onentercallback = &little_bird_onenterheavydamagestate;
    leveldatafordamagestate.onexitcallback = &little_bird_onexitheavydamagestate;
}

// Namespace namespace_d041019241996409
// Params 2, eflags: 0x4
// Checksum 0x4bf46e4b, Offset: 0x458
// Size: 0x111
function private little_bird_create( spawndata, faildata )
{
    if ( !isdefined( spawndata.script_vehiclebundle ) )
    {
        spawndata.script_vehiclebundle = level.projectbundle.var_53c4124af039142e ? vehicle::function_ce37932c0f5e0c24( #"scripts/quaked/script_struct_mp_littlebird.gsc" ) : vehicle::function_c9d59ae50eee9bb1( #"scripts/quaked/script_struct_mp_littlebird.gsc" );
    }
    
    bundle = spawndata.script_vehiclebundle;
    vehicle = vehicle::default_spawn( bundle, spawndata, faildata );
    
    if ( !isdefined( vehicle ) )
    {
        return;
    }
    
    vehicle.borntime = gettime();
    vehicle.flareslive = [];
    vehicle.flareready = 1;
    
    if ( isbrgamemode() )
    {
        vehicle.flarecooldown = 35;
    }
    else
    {
        vehicle.flarecooldown = 10;
    }
    
    vehicle thread vehicle_handleflarerecharge( bundle );
    vehicle thread collision_damage_watcher();
    vehicledata = vehicle::get_data( bundle );
    return vehicle;
}

// Namespace namespace_d041019241996409
// Params 2, eflags: 0x4
// Checksum 0x4802d255, Offset: 0x572
// Size: 0xa1
function private function_6195363d6c788814( damageinfo, damagefactor )
{
    if ( !isdefined( damageinfo.damagefactor ) )
    {
        damageinfo.damagefactor = damagefactor;
        
        /#
            damageinfo.debugstring = "<dev string:x24>";
        #/
    }
    else
    {
        damageinfo.damagefactor *= damagefactor;
        
        /#
            damageinfo.debugstring += "<dev string:x25>";
        #/
    }
    
    /#
        damageinfo.debugstring += damagefactor;
    #/
}

// Namespace namespace_d041019241996409
// Params 0, eflags: 0x4
// Checksum 0xdc0308f8, Offset: 0x61b
// Size: 0x3f7
function private collision_damage_watcher()
{
    self endon( #"death" );
    self vehphys_enablecollisioncallback( 1 );
    
    while ( true )
    {
        self waittill( #"collision", body0, body1, flag0, flag1, position, normal, normalspeed, ent, partenum );
        
        if ( gettime() - self.borntime < 5000 )
        {
            /#
                collision_debug( position, normal, normalspeed, 0, "<dev string:x27>" );
            #/
            
            continue;
        }
        
        if ( isdefined( ent ) && ent.iscrossbowbolt )
        {
            /#
                collision_debug( position, normal, normalspeed, 0, "<dev string:x30>" );
            #/
            
            continue;
        }
        
        if ( isdefined( ent ) && ent.helperdronetype == "radar_drone_recon" )
        {
            /#
                collision_debug( position, normal, normalspeed, 0, "<dev string:x3f>" );
            #/
            
            continue;
        }
        
        if ( self.var_4401c1e14c1111fe )
        {
            /#
                collision_debug( position, normal, normalspeed, 0, "<dev string:x51>" );
            #/
            
            continue;
        }
        
        damageinfo = spawnstruct();
        function_6195363d6c788814( damageinfo, normalspeed );
        
        if ( isdefined( self.var_52dfac12181e4ef9 ) )
        {
            function_6195363d6c788814( damageinfo, self vehicle_gettopspeedforward() / self.var_52dfac12181e4ef9 );
        }
        
        driver = vehicle_occupancy::get_driver( self );
        
        if ( !isdefined( driver ) )
        {
            function_6195363d6c788814( damageinfo, level.lb_dmg_factor_driverless_collision );
        }
        
        pitch = self.angles[ 0 ];
        
        if ( pitch > 180 )
        {
            pitch -= 360;
        }
        
        if ( abs( pitch ) > level.lb_pitch_roll_dmg_threshold )
        {
            function_6195363d6c788814( damageinfo, level.lb_pitch_roll_dmg_factor );
        }
        
        roll = self.angles[ 2 ];
        
        if ( roll > 180 )
        {
            roll -= 360;
        }
        
        if ( abs( roll ) > level.lb_pitch_roll_dmg_threshold )
        {
            function_6195363d6c788814( damageinfo, level.lb_pitch_roll_dmg_factor );
        }
        
        down = anglestoup( self.angles ) * -1;
        toposition = vectornormalize( position - self.origin );
        
        if ( vectordot( toposition, down ) > level.var_256dee426f01084f )
        {
            function_6195363d6c788814( damageinfo, level.var_7701196561e84e2c );
        }
        
        dmgval = 0;
        damagefactor = damageinfo.damagefactor;
        
        if ( damagefactor > level.lb_impulse_dmg_threshold_top )
        {
            dmgval = self.maxhealth;
        }
        else if ( damagefactor > level.lb_impulse_dmg_threshold_mid )
        {
            range = level.lb_impulse_dmg_threshold_top - level.lb_impulse_dmg_threshold_mid;
            factorscale = ( damagefactor - level.lb_impulse_dmg_threshold_mid ) / range;
            mindmg = self.maxhealth * level.lb_impulse_dmg_factor_mid_low;
            maxdmg = self.maxhealth * level.lb_impulse_dmg_factor_mid_high;
            dmgval = math::lerp( mindmg, maxdmg, factorscale );
        }
        else if ( damagefactor > level.lb_impulse_dmg_threshold_low )
        {
            dmgval = self.maxhealth * level.lb_impulse_dmg_factor_low;
        }
        
        if ( dmgval > 0 )
        {
            if ( isdefined( driver ) && flag1 == 11534336 )
            {
                dmgval *= level.lb_wood_surf_dmg_scalar;
            }
            
            vehicle_damage::function_658976b407a5b2e1( 1 );
            self dodamage( dmgval, position, undefined, undefined, "MOD_CRUSH" );
            vehicle_damage::function_658976b407a5b2e1( 0 );
        }
        
        /#
            collision_debug( position, normal, normalspeed, dmgval, "<dev string:x65>" + damagefactor + "<dev string:x67>" + damageinfo.debugstring + "<dev string:x69>" );
        #/
        
        wait 0.5;
    }
}

// Namespace namespace_d041019241996409
// Params 2, eflags: 0x4
// Checksum 0xa3165cb9, Offset: 0xa1a
// Size: 0x1f
function private little_bird_onenterheavydamagestate( oldstateref, data )
{
    vehicle_damage::function_f4c9964d3c4ddd44( oldstateref, data );
}

// Namespace namespace_d041019241996409
// Params 2, eflags: 0x4
// Checksum 0x78adf9d, Offset: 0xa41
// Size: 0x1f
function private little_bird_onexitheavydamagestate( oldstateref, data )
{
    vehicle_damage::function_7e728a3ed58dd4e6( oldstateref, data );
}

// Namespace namespace_d041019241996409
// Params 5, eflags: 0x4
// Checksum 0x8fc9e7f6, Offset: 0xa68
// Size: 0x1d7
function private little_bird_enterstart( vehicle, seatid, oldseatid, player, data )
{
    if ( vehicle.israllypointvehicle )
    {
        foreach ( plr in level.players )
        {
            if ( vehicle.revealed || plr.team == vehicle.team )
            {
                utility::callsharedfunc( #"objective", #"showtoplayer", vehicle.marker.objidnum, plr );
            }
        }
        
        foreach ( occupant in vehicle.occupants )
        {
            utility::callsharedfunc( #"objective", #"hidefromplayer", vehicle.marker.objidnum, occupant );
        }
        
        utility::callsharedfunc( #"objective", #"hidefromplayer", vehicle.marker.objidnum, player );
    }
}

// Namespace namespace_d041019241996409
// Params 5, eflags: 0x4
// Checksum 0x2dd74b0, Offset: 0xc47
// Size: 0x4c
function private little_bird_enterend( vehicle, seatid, oldseatid, player, data )
{
    if ( data.success )
    {
        little_bird_enterendinternal( vehicle, seatid, oldseatid, player, data );
    }
}

// Namespace namespace_d041019241996409
// Params 5, eflags: 0x4
// Checksum 0x7924d47b, Offset: 0xc9b
// Size: 0x72
function private little_bird_enterendinternal( vehicle, seatid, oldseatid, player, data )
{
    if ( seatid == "driver" )
    {
        vehicle thread vehicle_handleflarefire( player );
    }
    
    vehicle_omnvar::function_e0aa0be8e3297e0d( vehicle, oldseatid, seatid, player );
    
    if ( isdefined( level.var_901f8acc520c0eb ) )
    {
        [[ level.var_901f8acc520c0eb ]]( vehicle, seatid, oldseatid, player, data );
    }
}

// Namespace namespace_d041019241996409
// Params 5, eflags: 0x4
// Checksum 0x496a4e6b, Offset: 0xd15
// Size: 0x4c
function private little_bird_exitend( vehicle, seatid, newseatid, player, data )
{
    if ( data.success )
    {
        little_bird_exitendinternal( vehicle, seatid, newseatid, player, data );
    }
}

// Namespace namespace_d041019241996409
// Params 5, eflags: 0x4
// Checksum 0xaee9b60f, Offset: 0xd69
// Size: 0x11a
function private little_bird_exitendinternal( vehicle, seatid, newseatid, player, data )
{
    if ( seatid == "driver" )
    {
        vehicle notify( #"little_bird_driver_exit" );
    }
    
    if ( !data.playerdisconnect )
    {
        success = vehicle_occupancy::move_player_to_exit( vehicle, seatid, newseatid, player, data );
        
        if ( !success )
        {
            if ( utility::issharedfuncdefined( #"vehicle_occupancy", #"handleSuicideFromVehicles" ) )
            {
                [[ utility::getsharedfunc( #"vehicle_occupancy", #"handleSuicideFromVehicles" ) ]]( player );
            }
            else
            {
                player utility::callsharedfunc( #"player", #"suicide" );
            }
        }
        else if ( vehicle.israllypointvehicle )
        {
            utility::callsharedfunc( #"objective", #"showtoplayer", vehicle.marker.objidnum, player );
        }
    }
    
    vehicle_omnvar::function_1f2d7e52383cc345( vehicle, seatid, newseatid, player );
}

// Namespace namespace_d041019241996409
// Params 1, eflags: 0x4
// Checksum 0xf26863d8, Offset: 0xe8b
// Size: 0x124
function private vehicle_handleflarerecharge( bundle )
{
    rechargepercent = 1.05;
    self endon( #"death" );
    
    while ( true )
    {
        driver = vehicle_occupancy::get_driver( self );
        
        if ( self.flareready )
        {
            if ( isdefined( driver ) )
            {
                if ( driver isconnected() && driver function_5c766d1d0140b86( "ui_veh_flares_charge_perc" ) && driver getclientomnvar( "ui_veh_flares_charge_perc" ) < 1.05 )
                {
                    driver setclientomnvar( "ui_veh_flares_charge_perc", 1.05 );
                    vehicle_omnvar::set_ammo( bundle, "flares", 1, driver );
                }
            }
        }
        else
        {
            var_710639f51fd10596 = 0;
            
            while ( var_710639f51fd10596 < self.flarecooldown )
            {
                wait 0.05;
                var_710639f51fd10596 += 0.05;
                rechargepercent = var_710639f51fd10596 / self.flarecooldown;
                driver = vehicle_occupancy::get_driver( self );
                
                if ( isdefined( driver ) && driver isconnected() && driver function_5c766d1d0140b86( "ui_veh_flares_charge_perc" ) )
                {
                    driver setclientomnvar( "ui_veh_flares_charge_perc", rechargepercent );
                }
            }
            
            self.flareready = 1;
        }
        
        waitframe();
    }
}

// Namespace namespace_d041019241996409
// Params 1, eflags: 0x4
// Checksum 0xf0e8b22a, Offset: 0xfb7
// Size: 0x2d3
function private vehicle_handleflarefire( player )
{
    self endon( #"death" );
    self endon( #"little_bird_driver_exit" );
    player endon( #"death_or_disconnect" );
    player endon( #"vehicle_exit" );
    bundle = vehicle::get_ref();
    player notifyonplayercommand( "shoot_flare", "+attack" );
    vehicle_omnvar::set_ammo( bundle, "flares", self.flareready ? 1 : 0, player );
    var_bb3f0d721c8b638c = level.gametypebundle.var_bb3f0d721c8b638c ?? 4000;
    
    while ( true )
    {
        player waittill( #"shoot_flare" );
        
        if ( self.disable_flare )
        {
            continue;
        }
        
        if ( !self.flareready )
        {
            utility::callsharedfunc( #"sound", #"playsoundtoplayer", #"lbravo_noflares_warning", player );
            continue;
        }
        
        if ( utility::issharedfuncdefined( #"flares", #"hash_457d0eb03b7af2e5" ) )
        {
            self thread [[ utility::getsharedfunc( #"flares", #"hash_457d0eb03b7af2e5" ) ]]();
        }
        
        newtarget = undefined;
        
        if ( utility::issharedfuncdefined( #"flares", #"deploy" ) )
        {
            newtarget = self [[ utility::getsharedfunc( #"flares", #"deploy" ) ]]();
        }
        
        if ( isdefined( level.missiles ) )
        {
            foreach ( missile in level.missiles )
            {
                if ( !( isdefined( missile.origin ) && isdefined( missile.lockontarget ) ) || missile.lockontarget != self )
                {
                    continue;
                }
                
                curdist = distance( self.origin, missile.origin );
                
                if ( curdist < var_bb3f0d721c8b638c )
                {
                    if ( utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
                    {
                        player thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( "manual_flare_missile_redirect" );
                    }
                    
                    missile missile_settargetent( newtarget );
                    missile notify( #"cleartargetlockedontobyprojectile" );
                    missile notify( #"missile_pairedwithflare" );
                }
            }
        }
        
        self.flareready = 0;
        vehicle_omnvar::set_ammo( bundle, "flares", 0, player );
        vehicle_occupancy::fade_out_controls( player );
    }
}

/#

    // Namespace namespace_d041019241996409
    // Params 5
    // Checksum 0x5625e1f1, Offset: 0x1292
    // Size: 0x6a, Type: dev
    function collision_debug( position, normal, normalspeed, damage, debugstring )
    {
        if ( !getdvarint( @"hash_e1b0993f344fdd75", 0 ) )
        {
            return;
        }
        
        if ( !isdefined( level._collision_debug_hit ) )
        {
            level._collision_debug_hit = 0;
        }
        
        thread function_9ede0cab568f9716( position, normal, normalspeed, damage, debugstring );
    }

    // Namespace namespace_d041019241996409
    // Params 5
    // Checksum 0xda622c4d, Offset: 0x1304
    // Size: 0x1ac, Type: dev
    function function_9ede0cab568f9716( position, normal, normalspeed, damage, debugstring )
    {
        self endon( #"death" );
        self notify( "<dev string:x6b>" + level._collision_debug_hit );
        self endon( "<dev string:x6b>" + level._collision_debug_hit + 10 );
        level._collision_debug_hit++;
        minradius = 3;
        maxradius = 30;
        size = minradius + normalspeed * maxradius;
        org = self.origin;
        up = anglestoup( self.angles );
        org = self.origin;
        ang = self.angles;
        
        while ( true )
        {
            if ( damage > 0 )
            {
                color = ( 1, 0, 0 );
            }
            else
            {
                color = ( 1, 1, 1 );
            }
            
            result = transformmove( self.origin, self.angles, org, ang, position, ( 0, 0, 0 ) );
            newpos = result[ "<dev string:x7b>" ];
            sphere( newpos, size, color, 1, 1 );
            print3d( newpos, string( damage ), color, 1, 0.5, 1, 1 );
            
            if ( isdefined( debugstring ) )
            {
                print3d( newpos - ( 0, 0, 10 ), debugstring, color, 1, 0.25, 1, 1 );
            }
            
            waitframe();
        }
    }

#/
