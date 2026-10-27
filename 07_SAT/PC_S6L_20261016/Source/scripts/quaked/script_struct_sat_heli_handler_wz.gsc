// scripts\quaked\script_struct_sat_heli_handler_wz.gsc  (hash_7c71cd1ad07bef86.gscc) (size: 7557 Bytes / 0x1d85 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3106ae3d (822521405)
// size ...... 7557 (0x1d85)
// includes .. 8   (offset: 0x1c25)
// strings ... 16  (offset: 0x1c65)
// dev strs .. 4   (offset: 0x1d51)
// exports ... 18  (offset: 0x11e5)
// cseg ...... 0x133 + 0x10b2 (0x11e5)
// imports ... 63  (offset: 0x14b5)
// animtree1 . 0   (offset: 0x1d85)
// animtree2 . 0   (offset: 0x1d85)
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_omnvar_utility;
#using scripts\mp\common\utility\weapon_utility;

#namespace namespace_5bf1a3ad2a39f182;

// Namespace namespace_5bf1a3ad2a39f182
// Params 0, eflags: 0x5
// Checksum 0xb559cf11, Offset: 0x151
// Size: 0x2c
function private autoexec main()
{
    vehicle::register_vehicle_init( %"hash_4becdb85107b4693", &function_f1b9ff7dbff7531 );
    vehicle::register_vehicle_init( %"hash_6ecc4b72654c75a5", &heli_light_init );
}

// Namespace namespace_5bf1a3ad2a39f182
// Params 0, eflags: 0x4
// Checksum 0x47a50d, Offset: 0x185
// Size: 0x44
function private function_f1b9ff7dbff7531()
{
    if ( !vehicle::should_init( %"hash_4becdb85107b4693" ) )
    {
        return;
    }
    
    heli_common_init( %"hash_4becdb85107b4693" );
    utility::registersharedfunc( %"hash_4becdb85107b4693", #"spawn", &function_ae497706c8a49842 );
}

// Namespace namespace_5bf1a3ad2a39f182
// Params 0, eflags: 0x4
// Checksum 0xbc532f96, Offset: 0x1d1
// Size: 0x44
function private heli_light_init()
{
    if ( !vehicle::should_init( %"hash_6ecc4b72654c75a5" ) )
    {
        return;
    }
    
    heli_common_init( %"hash_6ecc4b72654c75a5" );
    utility::registersharedfunc( %"hash_6ecc4b72654c75a5", #"spawn", &heli_light_spawn );
}

// Namespace namespace_5bf1a3ad2a39f182
// Params 1, eflags: 0x4
// Checksum 0x990e4e0, Offset: 0x21d
// Size: 0x59
function private heli_common_init( var_f2247e4ad4a341e5 )
{
    callbacks[ #"enterEnd" ] = &enter_heli_callback;
    vehicle::generic_init( var_f2247e4ad4a341e5, callbacks );
    leveldataforvehicle = vehicle_omnvar::get_data( var_f2247e4ad4a341e5, 1 );
    leveldataforvehicle.ammoids[ "flares" ] = 1;
}

// Namespace namespace_5bf1a3ad2a39f182
// Params 2, eflags: 0x4
// Checksum 0x535a922e, Offset: 0x27e
// Size: 0xda
function private function_ae497706c8a49842( spawndata, faildata )
{
    if ( self.classname == "script_vehicle" )
    {
        vehicle = vehicle::function_66838ba16389a6cd( %"hash_4becdb85107b4693", spawndata, self );
    }
    else
    {
        vehicle = vehicle::default_spawn( %"hash_4becdb85107b4693", spawndata, faildata );
    }
    
    if ( !isdefined( vehicle ) )
    {
        return;
    }
    
    vehicle.flareref = %"hash_4becdb85107b4693";
    vehicle init_flare_system();
    bundle = getscriptbundle( getxhashasset( %"hash_4becdb85107b4693" ) );
    vehicle.borntime = gettime();
    vehicle.var_bceeb379e0985296 = 1;
    vehicle thread landing_gear_watcher();
    vehicle thread collision_damage_watcher( bundle );
    vehicle thread function_b051560c705fc65e( bundle );
    return vehicle;
}

// Namespace namespace_5bf1a3ad2a39f182
// Params 2, eflags: 0x4
// Checksum 0x4455e53a, Offset: 0x361
// Size: 0xc3
function private heli_light_spawn( spawndata, faildata )
{
    if ( self.classname == "script_vehicle" )
    {
        vehicle = vehicle::function_66838ba16389a6cd( %"hash_6ecc4b72654c75a5", spawndata, self );
    }
    else
    {
        vehicle = vehicle::default_spawn( %"hash_6ecc4b72654c75a5", spawndata, faildata );
    }
    
    if ( !isdefined( vehicle ) )
    {
        return;
    }
    
    vehicle.flareref = %"hash_6ecc4b72654c75a5";
    vehicle init_flare_system();
    bundle = getscriptbundle( getxhashasset( %"hash_6ecc4b72654c75a5" ) );
    vehicle.borntime = gettime();
    vehicle thread collision_damage_watcher( bundle );
    vehicle thread function_b051560c705fc65e( bundle );
    return vehicle;
}

// Namespace namespace_5bf1a3ad2a39f182
// Params 0, eflags: 0x4
// Checksum 0x37387954, Offset: 0x42d
// Size: 0x29
function private init_flare_system()
{
    self.flareslive = [];
    self.flareready = 1;
    self.flarecooldown = 10;
    thread handleflarerecharge();
}

// Namespace namespace_5bf1a3ad2a39f182
// Params 5, eflags: 0x4
// Checksum 0xdd0af0b, Offset: 0x45e
// Size: 0x60
function private enter_heli_callback( vehicle, seatid, oldseatid, player, data )
{
    if ( data.success )
    {
        if ( seatid == "driver" )
        {
            vehicle thread handleflarefire( player );
        }
        
        vehicle_omnvar::function_e0aa0be8e3297e0d( vehicle, oldseatid, seatid, player );
    }
}

// Namespace namespace_5bf1a3ad2a39f182
// Params 0, eflags: 0x4
// Checksum 0xc6d2df79, Offset: 0x4c6
// Size: 0xe8
function private handleflarerecharge()
{
    self endon( #"death" );
    
    while ( true )
    {
        driver = vehicle_occupancy::get_driver( self );
        
        if ( self.flareready )
        {
            if ( isdefined( driver ) )
            {
                if ( driver getclientomnvar( "ui_veh_flares_charge_perc" ) < 1.05 )
                {
                    driver setclientomnvar( "ui_veh_flares_charge_perc", 1.05 );
                    vehicle_omnvar::set_ammo( self.flareref, "flares", 1, driver );
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
                
                if ( isdefined( driver ) )
                {
                    driver setclientomnvar( "ui_veh_flares_charge_perc", rechargepercent );
                }
            }
            
            self.flareready = 1;
        }
        
        waitframe();
    }
}

// Namespace namespace_5bf1a3ad2a39f182
// Params 1, eflags: 0x4
// Checksum 0x3c87a666, Offset: 0x5b6
// Size: 0x2ea
function private handleflarefire( player )
{
    self endon( #"death" );
    player endon( #"death_or_disconnect" );
    player endon( #"vehicle_exit" );
    player endon( #"vehicle_change_seat" );
    player notifyonplayercommand( "shoot_flare", "+attack" );
    vehicle_omnvar::set_ammo( self.flareref, "flares", self.flareready ? 1 : 0, player );
    var_bb3f0d721c8b638c = level.gametypebundle.var_bb3f0d721c8b638c ?? 4000;
    
    while ( true )
    {
        player waittill( #"shoot_flare" );
        
        if ( !self.flareready )
        {
            self playsoundtoplayer( #"lbravo_noflares_warning", player );
            continue;
        }
        
        if ( utility::issharedfuncdefined( #"flares", #"hash_457d0eb03b7af2e5" ) )
        {
            self thread [[ utility::getsharedfunc( #"flares", #"hash_457d0eb03b7af2e5" ) ]]( undefined, "tag_deathfx", #"hash_bfccbf5f580db7f2" );
        }
        
        newtarget = undefined;
        
        if ( utility::issharedfuncdefined( #"flares", #"deploy" ) )
        {
            newtarget = self [[ utility::getsharedfunc( #"flares", #"deploy" ) ]]();
        }
        
        self.flareready = 0;
        vehicle_omnvar::set_ammo( self.flareref, "flares", 0, player );
        vehicle_occupancy::fade_out_controls( player );
        var_8e9a311cb1af0ef3 = 1;
        
        while ( var_8e9a311cb1af0ef3 > 0 )
        {
            if ( isdefined( level.missiles ) )
            {
                foreach ( missile in level.missiles )
                {
                    if ( !isdefined( missile.origin ) || !isdefined( missile.lockontarget ) || missile.lockontarget != self )
                    {
                        continue;
                    }
                    
                    curdist = distance( self.origin, missile.origin );
                    
                    if ( curdist < var_bb3f0d721c8b638c )
                    {
                        if ( utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
                        {
                            player thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( #"manual_flare_missile_redirect" );
                        }
                        
                        weapon_utility::clearprojectilelockedon( missile );
                        missile missile_settargetent( newtarget );
                        missile notify( #"missile_pairedwithflare" );
                    }
                }
            }
            
            var_8e9a311cb1af0ef3 -= 0.1;
            wait 0.1;
        }
    }
}

// Namespace namespace_5bf1a3ad2a39f182
// Params 0, eflags: 0x4
// Checksum 0xeaf6f559, Offset: 0x8a8
// Size: 0x60
function private landing_gear_watcher()
{
    self endon( #"death" );
    vehicle = self;
    
    while ( true )
    {
        if ( vehicle function_85524e337a7f4241( 300 ) )
        {
            vehicle utility::function_7c10ea82c1e305b8( "landingGear", "down" );
        }
        else
        {
            vehicle utility::function_7c10ea82c1e305b8( "landingGear", "up" );
        }
        
        wait 1;
    }
}

// Namespace namespace_5bf1a3ad2a39f182
// Params 1, eflags: 0x4
// Checksum 0x7469a8d8, Offset: 0x910
// Size: 0x9a, Type: bool
function private function_85524e337a7f4241( var_2ae43e18fd148bdc )
{
    vertical_offset = ( 0, 0, var_2ae43e18fd148bdc * 1.5 );
    solid_ai_contents = trace::create_solid_ai_contents( 1 );
    ray_trace = trace::ray_trace( self.origin, self.origin - vertical_offset, undefined, solid_ai_contents );
    ground_pos = ray_trace[ "hittype" ] != "hittype_none" ? ray_trace[ "position" ] : self.origin;
    
    /#
    #/
    
    return ray_trace[ "hittype" ] != "hittype_none";
}

// Namespace namespace_5bf1a3ad2a39f182
// Params 2, eflags: 0x4
// Checksum 0x6b3b8cbe, Offset: 0x9b3
// Size: 0xa1
function private function_bc5682fdfbd1a53b( damageinfo, damagefactor )
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

// Namespace namespace_5bf1a3ad2a39f182
// Params 2, eflags: 0x4
// Checksum 0xedd16e9d, Offset: 0xa5c
// Size: 0xa1
function private function_7b705bd866007c68( damageinfo, damagefactor )
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
        damageinfo.damagefactor += damagefactor;
        
        /#
            damageinfo.debugstring += "<dev string:x27>";
        #/
    }
    
    /#
        damageinfo.debugstring += damagefactor;
    #/
}

// Namespace namespace_5bf1a3ad2a39f182
// Params 1, eflags: 0x4
// Checksum 0xdc2fa1b6, Offset: 0xb05
// Size: 0x514
function private collision_damage_watcher( bundle )
{
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    self endon( #"death" );
    self vehphys_enablecollisioncallback( 1 );
    self vehicle_allowplayerstandon( 0 );
    
    while ( true )
    {
        self waittill( #"collision", body0, body1, flag0, flag1, position, normal, normalspeed, ent, partenum );
        
        if ( gettime() - self.borntime < 5000 )
        {
            continue;
        }
        
        if ( isdefined( ent ) && ent.iscrossbowbolt )
        {
            continue;
        }
        
        if ( isdefined( ent ) && ent.helperdronetype == "radar_drone_recon" )
        {
            continue;
        }
        
        if ( self.var_4401c1e14c1111fe )
        {
            continue;
        }
        
        var_801d8340ee3be777 = vectordot( normal * -1, self vehicle_getvelocity() ) * 0.0568182 / self vehicle_gettopspeedforward();
        damageinfo = spawnstruct();
        function_bc5682fdfbd1a53b( damageinfo, var_801d8340ee3be777 );
        driver = vehicle_occupancy::get_driver( self );
        
        if ( !isdefined( driver ) )
        {
            function_bc5682fdfbd1a53b( damageinfo, bundle.damage.var_6a25913f7904e611 );
        }
        
        pitch = self.angles[ 0 ];
        
        if ( pitch > 180 )
        {
            pitch -= 360;
        }
        
        if ( abs( pitch ) > bundle.damage.var_af36bc914d8bf94e )
        {
            function_bc5682fdfbd1a53b( damageinfo, bundle.damage.var_945abf22c89f5ff5 );
        }
        
        roll = self.angles[ 2 ];
        
        if ( roll > 180 )
        {
            roll -= 360;
        }
        
        if ( abs( roll ) > bundle.damage.var_77d9a7d02100c5fb )
        {
            function_bc5682fdfbd1a53b( damageinfo, bundle.damage.var_ad602bc6bbdfe1da );
        }
        
        down = anglestoup( self.angles ) * -1;
        toposition = vectornormalize( position - self.origin );
        
        if ( vectordot( toposition, down ) > bundle.damage.var_89b49f9b3f108f02 && var_801d8340ee3be777 <= bundle.damage.var_d56ea4bb15e41b9a )
        {
            function_bc5682fdfbd1a53b( damageinfo, bundle.damage.var_42b2ee361864a2b0 );
        }
        
        positionls = coordtransformtranspose( position, self.origin, self.angles );
        
        if ( positionls[ 2 ] > bundle.damage.var_ce5bc1e61b41099b )
        {
            function_7b705bd866007c68( damageinfo, bundle.damage.var_5254b9916c90d7b1 );
        }
        
        dmgval = 0;
        damagefactor = damageinfo.damagefactor;
        
        if ( damagefactor > bundle.damage.var_25ebd0140787bffc || self function_b5117472398445f6() )
        {
            dmgval = self.maxhealth;
        }
        else if ( damagefactor > bundle.damage.var_1b02007c36f7701e )
        {
            range = bundle.damage.var_25ebd0140787bffc - bundle.damage.var_1b02007c36f7701e;
            factorscale = ( damagefactor - bundle.damage.var_1b02007c36f7701e ) / range;
            mindmg = self.maxhealth * bundle.damage.var_f6c04b91087b481a;
            maxdmg = self.maxhealth * bundle.damage.var_11d8ddc514740b08;
            dmgval = math::lerp( mindmg, maxdmg, factorscale );
        }
        else if ( damagefactor > bundle.damage.var_fdc8e808c3b0a55e )
        {
            dmgval = self.maxhealth * bundle.damage.var_68716a6eeae524a0;
        }
        
        if ( positionls[ 2 ] > bundle.damage.var_ce5bc1e61b41099b )
        {
            dmgval *= bundle.damage.var_af8ae3f7d8956fe;
        }
        
        if ( dmgval > 0 )
        {
            if ( isdefined( driver ) && flag1 == 11534336 )
            {
                dmgval *= 0.6;
            }
            
            vehicle_damage::function_658976b407a5b2e1( 1 );
            self dodamage( dmgval, position, undefined, undefined, "MOD_CRUSH" );
            vehicle_damage::function_658976b407a5b2e1( 0 );
            println( "<dev string:x29>" + dmgval );
            wait 1.5;
        }
    }
}

// Namespace namespace_5bf1a3ad2a39f182
// Params 1, eflags: 0x4
// Checksum 0x6656f9ef, Offset: 0x1021
// Size: 0xf3
function private function_b051560c705fc65e( bundle )
{
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    self endon( #"death" );
    self vehphys_enablecollisioncallback( 1 );
    
    while ( true )
    {
        self waittill( #"collision", body0, body1, flag0, flag1, position, normal, normalspeed, ent, partenum );
        
        if ( ent && ent getentitynumber() && ent vehicle::is_vehicle() )
        {
            isabove = normal[ 2 ] > 0.9;
            var_71ff37b47bc9eed6 = self function_9cbba1ae667c3483() > ent function_9cbba1ae667c3483();
            
            if ( isabove && var_71ff37b47bc9eed6 )
            {
                thread function_cd1dbdba0181ed25( ent, position );
            }
        }
    }
}

// Namespace namespace_5bf1a3ad2a39f182
// Params 2, eflags: 0x4
// Checksum 0x9fc29d37, Offset: 0x111c
// Size: 0xc9
function private function_cd1dbdba0181ed25( other, position )
{
    bundle = self.veh_scriptbundlesettings;
    
    if ( !isdefined( bundle ) )
    {
        return;
    }
    
    self notify( "crush" + other getentitynumber() );
    self endon( #"death" );
    self endon( "crush" + other getentitynumber() );
    other endon( #"death" );
    
    while ( true )
    {
        wait bundle.damage.var_958f909d4b6330ea;
        
        if ( !self istouching( other ) )
        {
            break;
        }
        
        other dodamage( bundle.damage.var_355567a737d64f72, position, vehicle_occupancy::get_driver( self ), self, "MOD_CRUSH", self.objweapon );
    }
}

