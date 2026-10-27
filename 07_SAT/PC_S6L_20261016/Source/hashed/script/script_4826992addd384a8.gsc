// script_4826992addd384a8  (hash_4826992addd384a8.gscc) (size: 22077 Bytes / 0x563d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x77a96167 (2007589223)
// size ...... 22077 (0x563d)
// includes .. 10  (offset: 0x5031)
// strings ... 82  (offset: 0x5081)
// dev strs .. 17  (offset: 0x5571)
// exports ... 53  (offset: 0x3465)
// cseg ...... 0x538 + 0x2f2d (0x3465)
// imports ... 154 (offset: 0x3cad)
// animtree1 . 0   (offset: 0x563d)
// animtree2 . 0   (offset: 0x563d)
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\common\vehicle_omnvar_utility;
#using scripts\common\weapon;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\vehicles\damage;

#namespace namespace_2f878bc13d734510;

// Namespace namespace_2f878bc13d734510
// Params 0, eflags: 0x5
// Checksum 0xc5236dd7, Offset: 0x556
// Size: 0x17
function private autoexec main()
{
    vehicle::register_vehicle_init( %"hash_244559a74b556cda", &blood_burner_init );
}

// Namespace namespace_2f878bc13d734510
// Params 0, eflags: 0x4
// Checksum 0x24626115, Offset: 0x575
// Size: 0x99
function private blood_burner_init()
{
    if ( game_utility::getgametype() == "ob" )
    {
        callbacks[ #"spawn" ] = &function_4ac5602dab47d3c3;
        callbacks[ #"enterEnd" ] = &function_967a158246060f6a;
        callbacks[ #"exitEnd" ] = &function_eec3baf0e76380dc;
        callbacks[ #"exitStart" ] = &function_563d8bcb3ca84c9b;
        vehicle::generic_init( %"hash_244559a74b556cda", callbacks );
    }
    else
    {
        vehicle::generic_init( %"hash_244559a74b556cda" );
    }
    
    damage::set_pre_mod_damage_callback( %"hash_244559a74b556cda", &function_c5938c2074425b35 );
}

// Namespace namespace_2f878bc13d734510
// Params 2, eflags: 0x4
// Checksum 0x71579e85, Offset: 0x616
// Size: 0xda
function private function_4ac5602dab47d3c3( spawndata, faildata )
{
    vehicle = vehicle::default_spawn( %"hash_244559a74b556cda", spawndata, faildata );
    
    if ( !isdefined( vehicle ) )
    {
        return;
    }
    
    vehicle utility::function_7c10ea82c1e305b8( "visiblity", "hide" );
    vehicle utility::function_7c10ea82c1e305b8( "stability", "stable" );
    vehicle utility::function_7c10ea82c1e305b8( "spawn", "spawn" );
    
    if ( game_utility::getgametype() == "ob" )
    {
        function_efa0f33ca80ae4a9( vehicle );
    }
    
    if ( vehicle::has_data( %"hash_244559a74b556cda" ) )
    {
        var_1dae25b886055444 = vehicle::get_data( %"hash_244559a74b556cda" ).spawn;
        
        if ( isdefined( var_1dae25b886055444 ) )
        {
            var_1dae25b886055444.respawndelay = 99999999;
        }
    }
    
    return vehicle;
}

// Namespace namespace_2f878bc13d734510
// Params 1, eflags: 0x4
// Checksum 0xa0f9c90, Offset: 0x6f9
// Size: 0x23a
function private function_efa0f33ca80ae4a9( vehicle )
{
    vehicle.var_952cf197d2d0f4f3 = &function_6894f8daf57889ba;
    vehicle.var_702974f270f69da2 = &function_43c0fb3542b0c07a;
    vehicle.enemieskilled = 0;
    vehicle.speedstate = 0;
    vehicle.killstate = 0;
    vehicle.healthstate = 0;
    vehicle.audiorequest = "";
    vehicle.vfxrequest = "ready";
    vehicle.lastvfx = "waiting";
    vehicle.abilityready = 0;
    vehicle.var_1b25215a3b2f6244 = 0;
    vehicle.var_a7de804b81f86aae = -1;
    vehicle.killcharge = 0;
    vehicle.abilityinprogress = 0;
    vehicle.respawninprogress = 0;
    vehicle.safepos = vehicle.origin;
    vehicle.var_2f93269fa97c970d = 1;
    vehicle.unlimitedtime = 0;
    vehicle.inittime = gettime();
    vehicle.lifespan = vehicle.owner.var_3ad218a44938a44e.vehicleduration ?? getdvarint( @"hash_26a7d8ba0e054bce", 60 );
    
    if ( vehicle::has_data( %"hash_244559a74b556cda" ) )
    {
        vehiclebundle = vehicle::get_data( %"hash_244559a74b556cda" );
        weaponname = vehiclebundle.wondervehicle.var_a18c86aafa95b043;
        vehicle.weaponobj = makeweapon( weaponname );
    }
    
    vehicle.var_9b6d5e24d8eed7c4 = 1;
    vehicle.var_1f9a4101434e0129 = 1;
    vehicle thread function_25f4aef83a68bef();
    vehicle thread function_c9a80eff0e224cb5();
    vehicle thread function_4d3a180b24371ce0();
    vehicle thread function_50a9c4a325caf8b6();
    vehicle thread function_23715f23fcb8fd75();
    vehicle thread function_65213083280902f8();
    vehicle thread function_f38af12057d618e8();
    vehicle thread function_d3ca5b283086abfc();
    vehicle thread function_e357f1816770b082();
    
    /#
        vehicle thread function_c0219cc1fe33ba7b();
    #/
}

// Namespace namespace_2f878bc13d734510
// Params 5, eflags: 0x4
// Checksum 0x55479fad, Offset: 0x93b
// Size: 0x89
function private function_967a158246060f6a( vehicle, seatid, oldseatid, player, data )
{
    function_87542b8c8075c02b( vehicle, "enterVeh" );
    player.var_ec47121ababf44a2 = player getcamerathirdperson();
    vehicle_omnvar::function_e0aa0be8e3297e0d( vehicle, oldseatid, seatid, player );
    vehicle.abilityinprogress = 0;
    vehicle thread function_4c6abc1b670cc68d();
    function_db87908cfd85153b( vehicle, -1 );
    function_a88fd6623ac592c2( vehicle, -1 );
}

// Namespace namespace_2f878bc13d734510
// Params 5, eflags: 0x4
// Checksum 0x1aa811b3, Offset: 0x9cc
// Size: 0xb1
function private function_eec3baf0e76380dc( vehicle, seatid, oldseatid, player, data )
{
    function_87542b8c8075c02b( vehicle, "exitVeh" );
    vehicle_occupancy::function_3a81035d298258ac( vehicle, seatid, oldseatid, player, data );
    function_4c0de7cfcf40d8c1( vehicle, "all_idle" );
    set_ability_status( vehicle, 0 );
    function_db87908cfd85153b( vehicle, 0 );
    
    if ( vehicle.abilityinprogress )
    {
        vehicle.owner function_4d33120a47141f60( 4 );
        vehicle.owner function_4d33120a47141f60( 1 );
    }
    
    vehicle notify( #"hash_e67e0494c7e2208d" );
}

// Namespace namespace_2f878bc13d734510
// Params 6, eflags: 0x4
// Checksum 0xda69af5e, Offset: 0xa85
// Size: 0x69
function private function_563d8bcb3ca84c9b( vehicle, seatid, newseatid, player, data, specialexit )
{
    if ( isdefined( getwaterheightatlocation( vehicle.origin ) ) )
    {
        data.allowairexit = 1;
    }
    
    vehicle_occupancy::exit_start_callback( vehicle, seatid, newseatid, player, data, specialexit );
}

// Namespace namespace_2f878bc13d734510
// Params 0, eflags: 0x4
// Checksum 0x4b12a2f, Offset: 0xaf6
// Size: 0x198
function private function_25f4aef83a68bef()
{
    vehicle = self;
    vehicle endon( #"death" );
    
    if ( !isnavmeshloaded() )
    {
        wait 5;
    }
    
    if ( isnavmeshloaded() )
    {
        mapcenter = ( 0, 0, 0 );
        mapcorners = utility::getstructarray( "minimap_corner", "targetname" );
        
        if ( mapcorners.size )
        {
            foreach ( corner in mapcorners )
            {
                mapcenter += corner.origin;
            }
            
            mapcenter /= mapcorners.size;
        }
        
        retries = 0;
        
        for ( waterz = getwaterheightatlocation( vehicle.safepos ) ?? 0; waterz + 10 >= vehicle.safepos[ 2 ] ; waterz = getwaterheightatlocation( vehicle.safepos ) ?? 0 )
        {
            retries += 1;
            
            if ( retries > 5 )
            {
                break;
            }
            
            vehicle.safepos += 1000 * vectornormalize( mapcenter - vehicle.safepos );
            vehicle.safepos = getclosestpointonnavmesh( vehicle.safepos );
        }
    }
}

// Namespace namespace_2f878bc13d734510
// Params 0, eflags: 0x4
// Checksum 0x4ac6aa2f, Offset: 0xc96
// Size: 0x1a3
function private function_c9a80eff0e224cb5()
{
    vehicle = self;
    vehicle endon( #"death" );
    vehicle.var_e8e1026ea2e971ce = 1;
    var_726571b7c18f84cf = 0;
    
    if ( !vehicle hascomponent( "p2p" ) )
    {
        targetposition = vehicle.origin + anglestoforward( vehicle.angles ) * 100;
        
        if ( trace::ray_trace_passed( vehicle.origin + ( 0, 0, 2.5 ), targetposition, vehicle ) )
        {
            vehicle addcomponent( "p2p" );
            vehicle setconfigvalue( "p2p", "brakeAtGoal", 1 );
            vehicle setconfigvalue( "p2p", "checkStuck", 0 );
            vehicle setconfigvalue( "p2p", "goalPoint", targetposition );
            vehicle setconfigvalue( "p2p", "manualSpeed", utility::mph_to_ips( vehicle vehicle_gettopspeedforward() / 4 ) );
            vehicle setconfigvalue( "p2p", "goalThreshold", 10 );
        }
        else
        {
            var_726571b7c18f84cf = 1;
        }
    }
    
    while ( vehicle.var_e8e1026ea2e971ce )
    {
        waitframe();
        
        if ( var_726571b7c18f84cf )
        {
            vehicle.var_e8e1026ea2e971ce = 0;
            vehicle utility::function_7c10ea82c1e305b8( "spawn", "clearSpawn" );
            function_4c0de7cfcf40d8c1( vehicle, "all_idle" );
            continue;
        }
        
        vehicle_owner = vehicle getvehicleowner();
        
        if ( distance2dsquared( vehicle.origin, targetposition ) <= 40 || isdefined( vehicle_owner ) )
        {
            vehicle removecomponent( "p2p" );
            var_726571b7c18f84cf = 1;
            function_87542b8c8075c02b( vehicle, "spawn" );
        }
    }
}

// Namespace namespace_2f878bc13d734510
// Params 0, eflags: 0x4
// Checksum 0x410b647, Offset: 0xe41
// Size: 0x6f
function private function_e357f1816770b082()
{
    self endon( #"death" );
    thread function_2516663cd1ea8a2();
    
    while ( !self.playerentered )
    {
        waitframe();
    }
    
    while ( true )
    {
        if ( self.playerentered && !isdefined( self.occupants[ "driver" ] ) || function_137d4973277160b2() )
        {
            vehicle_occupancy::eject_all_occupants( self );
            wait 0.1;
            vehicle::explode();
        }
        
        waitframe();
    }
}

// Namespace namespace_2f878bc13d734510
// Params 0, eflags: 0x4
// Checksum 0x5614dbe7, Offset: 0xeb8
// Size: 0x3a, Type: bool
function private function_137d4973277160b2()
{
    if ( self.unlimitedtime )
    {
        return false;
    }
    
    currenttime = gettime() / 1000;
    return currenttime - self.var_2f93269fa97c970d >= self.lifespan;
}

// Namespace namespace_2f878bc13d734510
// Params 3, eflags: 0x4
// Checksum 0x772a352b, Offset: 0xefb
// Size: 0x91
function private function_6894f8daf57889ba( vehicle, victim, var_d7b159020980ed24 )
{
    if ( vehicle.abilityinprogress )
    {
        function_87542b8c8075c02b( vehicle, "pulseKill" );
    }
    else
    {
        function_87542b8c8075c02b( vehicle, "kill" );
    }
    
    meansofdeath = var_d7b159020980ed24.smeansofdeath;
    crushed = vehicle.speedstate > 1 && meansofdeath == "MOD_CRUSH";
    vehicle thread function_bb16171e4c19ae7( victim, crushed );
}

// Namespace namespace_2f878bc13d734510
// Params 2, eflags: 0x4
// Checksum 0x66984df0, Offset: 0xf94
// Size: 0x15
function private function_43c0fb3542b0c07a( vehicle, victim )
{
    
}

// Namespace namespace_2f878bc13d734510
// Params 1, eflags: 0x4
// Checksum 0xe241d9b8, Offset: 0xfb1
// Size: 0x97, Type: bool
function private function_c5938c2074425b35( data )
{
    inflictor = data.inflictor;
    
    if ( isent( inflictor ) )
    {
        if ( inflictor getentitynumber() == worldentnumber() )
        {
            return false;
        }
        
        if ( inflictor vehicle::is_vehicle() )
        {
            return false;
        }
        
        if ( isplayer( inflictor ) )
        {
            return false;
        }
    }
    
    mod = data.meansofdeath;
    
    if ( !isdefined( mod ) )
    {
        return false;
    }
    
    if ( mod == "MOD_CRUSH" || mod == "MOD_IMPACT" )
    {
        return false;
    }
    
    if ( isexplosivedamagemod( mod ) )
    {
        return false;
    }
    
    return false;
}

// Namespace namespace_2f878bc13d734510
// Params 0, eflags: 0x4
// Checksum 0xca4f9c75, Offset: 0x1051
// Size: 0x117
function private function_e401d69ac363b1ca()
{
    vehicle = self;
    
    if ( getdvarint( @"hash_5346a98ebcabab0", 0 ) == 1 )
    {
        cooldown = 100;
        currenttimestamp = gettime();
        vehiclebundle = vehicle::get_data( %"hash_244559a74b556cda" );
        
        if ( vehicle.var_a7de804b81f86aae + cooldown < currenttimestamp )
        {
            vehicle.killcharge += vehicle.var_1b25215a3b2f6244;
        }
        else
        {
            vehicle.killcharge = 0;
        }
        
        vehicle.health = int( vehicle.health + vehicle function_2e92cf6d14142fe4() / vehiclebundle.wondervehicle.var_299f33a490ffb40e );
        clamp( vehicle.health, 0, vehicle function_2e92cf6d14142fe4() );
        vehicle.var_a7de804b81f86aae = gettime();
    }
    
    if ( !vehicle.abilityinprogress )
    {
        vehicle.enemieskilled++;
    }
}

// Namespace namespace_2f878bc13d734510
// Params 0, eflags: 0x4
// Checksum 0x1781840c, Offset: 0x1170
// Size: 0x1ad
function private function_4c6abc1b670cc68d()
{
    vehicle = self;
    vehicle endon( #"death" );
    vehicle endon( #"hash_e67e0494c7e2208d" );
    vehiclebundle = vehicle::get_data( %"hash_244559a74b556cda" );
    
    while ( true )
    {
        if ( isdefined( vehicle.owner ) )
        {
            progress = function_94afc1f4cbfa6229( vehiclebundle );
            
            if ( !vehicle.abilityinprogress )
            {
                vehicle.owner function_5540c7664be17810( clamp( progress, 0, 1 ) );
            }
            
            completeprogress = progress >= 1;
            
            if ( completeprogress && !vehicle.abilityready && !vehicle.abilityinprogress )
            {
                set_ability_status( vehicle, 1 );
                
                if ( vehicle.owner getclientomnvar( "ui_vehicle_ability_notification" ) )
                {
                    function_72dc653da3cbef0( "ui_vehicle_ability_notification", 1 );
                }
                
                occupants = vehicle_occupancy::get_all_occupants( vehicle );
                
                foreach ( occupant in occupants )
                {
                    if ( isdefined( occupant ) )
                    {
                        vehicle playsoundtoplayer( "veh_jup_motorcycle_aether_charged", occupant, vehicle );
                    }
                }
                
                vehicle thread function_20d7bd2951119cf6();
            }
        }
        
        if ( vehicle.killcharge > 0 )
        {
            vehicle.killcharge--;
        }
        
        waitframe();
    }
}

// Namespace namespace_2f878bc13d734510
// Params 1, eflags: 0x4
// Checksum 0x46b63293, Offset: 0x1325
// Size: 0xe9
function private function_94afc1f4cbfa6229( vehiclebundle )
{
    var_4ace69b55ccae502 = self.owner utility::callsharedfunc( "super_vehicle_summoner", #"hash_f10eb0c08ca64317" );
    
    if ( var_4ace69b55ccae502.pointsneeded )
    {
        var_a644d90d578ad915 = ( gettime() - self.inittime ) * 0.001 * var_4ace69b55ccae502.var_4ad99a00ad8a0f91;
        var_2df8e9cbd0ddbfaa = 0;
        
        if ( var_4ace69b55ccae502.var_b6bb45a65271cc98 )
        {
            var_2df8e9cbd0ddbfaa = self.enemieskilled * var_4ace69b55ccae502.var_b6bb45a65271cc98;
        }
        
        var_9a36202726bf2200 = var_a644d90d578ad915 + var_2df8e9cbd0ddbfaa;
        progress = var_9a36202726bf2200 / var_4ace69b55ccae502.pointsneeded;
    }
    else
    {
        progress = self.enemieskilled / vehiclebundle.wondervehicle.var_7981ed21cc0fab1d;
    }
    
    return progress;
}

// Namespace namespace_2f878bc13d734510
// Params 0, eflags: 0x4
// Checksum 0xb9f0f1a5, Offset: 0x1417
// Size: 0x100
function private function_2ba086e1cc3d0269()
{
    self endon( #"wonder_weapon_used" );
    self endon( #"hash_e67e0494c7e2208d" );
    vehicle = self;
    
    while ( self.abilityready )
    {
        vehplayers = vehicle_occupancy::get_all_occupants( vehicle );
        
        foreach ( occupant in vehplayers )
        {
            if ( !vehicle_occupancy::function_3080323254ba6900( occupant ) )
            {
                continue;
            }
            
            occupant notifyonplayercommand( "repeatUseActivate", "+attack" );
            occupant waittill( #"repeatuseactivate" );
            self notify( #"wonder_weapon_used" );
            occupant notifyonplayercommandremove( "repeatUseActivate", "+attack" );
        }
        
        wait 0.1;
    }
}

// Namespace namespace_2f878bc13d734510
// Params 0, eflags: 0x4
// Checksum 0x5ccb699e, Offset: 0x151f
// Size: 0x1d5
function private function_20d7bd2951119cf6()
{
    vehicle = self;
    vehicle endon( #"death" );
    vehicle endon( #"hash_e67e0494c7e2208d" );
    vehiclebundle = vehicle::get_data( %"hash_244559a74b556cda" );
    vehicle thread function_2ba086e1cc3d0269();
    vehicle waittill( #"wonder_weapon_used" );
    set_ability_status( vehicle, 0 );
    vehicle.enemieskilled = 0;
    vehicle.abilityinprogress = 1;
    vehicle.inittime = gettime();
    waveinterval = vehiclebundle.wondervehicle.var_ecb511b924261008 / max( vehiclebundle.wondervehicle.var_f75127a2d2103938 - 1, 1 );
    vehicle.owner function_4d33120a47141f60( 3 );
    vehicle.owner function_72dc653da3cbef0( "ui_vehicle_ability_notification", 0 );
    vehicle thread function_7552605d4c1d22c1( vehiclebundle.wondervehicle.var_ecb511b924261008 ?? 1.5 );
    function_87542b8c8075c02b( vehicle, "powerUp" );
    
    for ( i = 0; i < vehiclebundle.wondervehicle.var_f75127a2d2103938 ; i++ )
    {
        function_2f1305178ffa3bbb( vehicle );
        wait waveinterval;
    }
    
    if ( vehiclebundle.wondervehicle.var_f75127a2d2103938 > 1 )
    {
        function_2f1305178ffa3bbb( vehicle );
    }
    
    vehicle.abilityinprogress = 0;
    function_db87908cfd85153b( vehicle, 0 );
    vehicle.owner function_4d33120a47141f60( 4 );
    vehicle.owner function_4d33120a47141f60( 1 );
    function_87542b8c8075c02b( vehicle, "pulseOver" );
}

// Namespace namespace_2f878bc13d734510
// Params 1, eflags: 0x4
// Checksum 0x9f63adde, Offset: 0x16fc
// Size: 0x82
function private function_2f1305178ffa3bbb( vehicle )
{
    vehiclebundle = vehicle::get_data( %"hash_244559a74b556cda" );
    function_4c0de7cfcf40d8c1( vehicle, "pulse_on" );
    var_9f044507bb66caa6 = getaiarrayinradius( vehicle.origin, vehiclebundle.wondervehicle.blood_burner_damageradius );
    function_ff0142079d2a2b9( vehicle, vehiclebundle, var_9f044507bb66caa6 );
    wait 0.1;
    function_4c0de7cfcf40d8c1( vehicle, "pulse_off" );
}

// Namespace namespace_2f878bc13d734510
// Params 3, eflags: 0x4
// Checksum 0x7babe027, Offset: 0x1786
// Size: 0x2a9
function private function_ff0142079d2a2b9( vehicle, vehiclebundle, targets )
{
    var_c0943d6f602a1ad = 0;
    var_3b180a32603f6930 = 0;
    fxmade = 0;
    var_2a7659cd6e2d044 = undefined;
    
    foreach ( target in targets )
    {
        thread function_b7f3b7e673c12ccb( vehicle, target, 3.5, 1 );
    }
    
    foreach ( target in targets )
    {
        var_c0943d6f602a1ad++;
        
        if ( isalive( target ) )
        {
            println( "<dev string:x24>" + var_c0943d6f602a1ad );
            nearbytargets = getaiarrayinradius( target.origin, vehiclebundle.wondervehicle.blood_burner_damageradius / 4 );
            
            foreach ( nearbytarget in nearbytargets )
            {
                if ( target == nearbytarget || !isalive( nearbytarget ) )
                {
                    println( "<dev string:x35>" + var_3b180a32603f6930 );
                    continue;
                }
                
                var_3b180a32603f6930++;
                println( "<dev string:x49>" + var_3b180a32603f6930 );
                var_bc2cef7bcffd62f9 = vehicle function_f7efcaf092a225e9( nearbytarget, vehiclebundle );
                radiusdamage( nearbytarget.origin, 0.5, var_bc2cef7bcffd62f9, var_bc2cef7bcffd62f9, vehicle.owner, undefined, vehicle.weaponobj );
                wait 0.1;
            }
            
            println( "<dev string:x5d>" );
            finalimpulse = vehicle function_f7efcaf092a225e9( target, vehiclebundle );
            radiusdamage( target.origin, 0.25, finalimpulse, finalimpulse, vehicle.owner, undefined, vehicle.weaponobj );
        }
        
        waitframe();
    }
}

// Namespace namespace_2f878bc13d734510
// Params 4, eflags: 0x4
// Checksum 0x3e7788ca, Offset: 0x1a37
// Size: 0xd0
function private function_b7f3b7e673c12ccb( vehicle, victim, shock_duration, damage )
{
    if ( isdefined( victim ) )
    {
        if ( utility::issharedfuncdefined( #"zombie", #"stunZombie" ) )
        {
            victim thread utility::callsharedfunc( #"zombie", #"stunZombie", 5, "stunned_on" );
        }
        
        victim setscriptablepartstate( "shockStickVfx", "vfx_start", 0 );
        victim dodamage( damage, victim.origin, vehicle.owner, vehicle, "MOD_UNKNOWN", vehicle.weaponobj, "none", undefined );
        wait shock_duration;
        
        if ( isalive( victim ) )
        {
            victim setscriptablepartstate( "shockStickVfx", "off", 0 );
        }
    }
}

// Namespace namespace_2f878bc13d734510
// Params 2, eflags: 0x4
// Checksum 0x83c24c7b, Offset: 0x1b0f
// Size: 0x82
function private set_ability_status( vehicle, state )
{
    if ( state != vehicle.abilityready )
    {
        vehicle.abilityready = state;
        
        if ( isdefined( vehicle.owner ) )
        {
            if ( !vehicle.abilityinprogress )
            {
                if ( state )
                {
                    vehicle.owner function_4d33120a47141f60( 2 );
                    return;
                }
                
                vehicle.owner function_4d33120a47141f60( 1 );
            }
        }
    }
}

// Namespace namespace_2f878bc13d734510
// Params 2, eflags: 0x4
// Checksum 0x78c8b208, Offset: 0x1b99
// Size: 0x38, Type: bool
function private function_db87908cfd85153b( vehicle, state )
{
    if ( vehicle.killstate != state )
    {
        vehicle.killstate = state;
        return true;
    }
    
    return false;
}

// Namespace namespace_2f878bc13d734510
// Params 1, eflags: 0x4
// Checksum 0x4b8e1cd, Offset: 0x1bda
// Size: 0x13b
function private function_19cfed75819a3626( vehicle )
{
    data = vehicle::get_data( %"hash_244559a74b556cda" );
    var_cf1893ad14645d64 = data.wondervehicle.var_7981ed21cc0fab1d ?? 20;
    killratio = var_cf1893ad14645d64 == 0 ? 0 : vehicle.enemieskilled / var_cf1893ad14645d64;
    
    if ( killratio >= 1 || vehicle.abilityready )
    {
        if ( function_db87908cfd85153b( vehicle, 4 ) )
        {
            function_4c0de7cfcf40d8c1( vehicle, "charge_full" );
        }
        
        return;
    }
    
    if ( killratio >= 0.75 )
    {
        if ( function_db87908cfd85153b( vehicle, 3 ) )
        {
            function_4c0de7cfcf40d8c1( vehicle, "charge_high" );
        }
        
        return;
    }
    
    if ( killratio >= 0.5 )
    {
        if ( function_db87908cfd85153b( vehicle, 2 ) )
        {
            function_4c0de7cfcf40d8c1( vehicle, "charge_med" );
        }
        
        return;
    }
    
    if ( killratio >= 0.25 )
    {
        if ( function_db87908cfd85153b( vehicle, 1 ) )
        {
            function_4c0de7cfcf40d8c1( vehicle, "charge_low" );
        }
        
        return;
    }
    
    if ( function_db87908cfd85153b( vehicle, 0 ) )
    {
        function_4c0de7cfcf40d8c1( vehicle, "charge_idle" );
    }
}

// Namespace namespace_2f878bc13d734510
// Params 0, eflags: 0x4
// Checksum 0x2d4d9777, Offset: 0x1d1d
// Size: 0x4e
function private function_23715f23fcb8fd75()
{
    vehicle = self;
    vehicle endon( #"death" );
    vehicle.var_a77896cad2f2f335 = vehicle vehicle_gettopspeedforward();
    
    while ( true )
    {
        vehicle.var_c4cf4c9885f10ae6 = vehicle vehicle_getspeed();
        wait 0.1;
    }
}

// Namespace namespace_2f878bc13d734510
// Params 1, eflags: 0x4
// Checksum 0x53c912d4, Offset: 0x1d73
// Size: 0x13d
function private function_9954945aa8dca508( vehicle )
{
    if ( !isdefined( vehicle.var_a77896cad2f2f335 ) && !isdefined( vehicle.var_c4cf4c9885f10ae6 ) )
    {
        return;
    }
    
    if ( vehicle.var_c4cf4c9885f10ae6 <= vehicle.var_a77896cad2f2f335 * 0.2 )
    {
        if ( vehicle.speedstate != 0 )
        {
            function_4c0de7cfcf40d8c1( vehicle, "speed_idle" );
            function_a88fd6623ac592c2( vehicle, 0 );
        }
        
        return;
    }
    
    if ( vehicle.var_c4cf4c9885f10ae6 <= vehicle.var_a77896cad2f2f335 * 0.5 )
    {
        if ( vehicle.speedstate != 1 )
        {
            function_4c0de7cfcf40d8c1( vehicle, "speed_low" );
            function_a88fd6623ac592c2( vehicle, 1 );
        }
        
        return;
    }
    
    if ( vehicle.var_c4cf4c9885f10ae6 <= vehicle.var_a77896cad2f2f335 * 0.75 )
    {
        if ( vehicle.speedstate != 2 )
        {
            function_4c0de7cfcf40d8c1( vehicle, "speed_med" );
            function_a88fd6623ac592c2( vehicle, 2 );
        }
        
        return;
    }
    
    if ( vehicle.speedstate != 3 )
    {
        function_4c0de7cfcf40d8c1( vehicle, "speed_high" );
        function_a88fd6623ac592c2( vehicle, 3 );
    }
}

// Namespace namespace_2f878bc13d734510
// Params 2, eflags: 0x4
// Checksum 0xb78ad48b, Offset: 0x1eb8
// Size: 0x23
function private function_a88fd6623ac592c2( vehicle, state )
{
    vehicle.speedstate = state;
}

// Namespace namespace_2f878bc13d734510
// Params 0, eflags: 0x4
// Checksum 0x88e38798, Offset: 0x1ee3
// Size: 0xc8
function private function_65213083280902f8()
{
    vehicle = self;
    vehicle endon( #"death" );
    level endon( #"game_ended" );
    ejectangle = getdvarint( @"hash_49a7fd44e7215bef", 100 );
    duration = 0;
    
    while ( true )
    {
        angle = math::anglebetweenvectorsunit( ( 0, 0, 1 ), anglestoup( vehicle.angles ) );
        upsidedown = angle >= ejectangle;
        
        if ( upsidedown )
        {
            duration += 0.1;
            
            if ( duration > getdvarfloat( @"hash_78bc3e9c5cd1c1d5", 0.6 ) )
            {
                vehicle_occupancy::eject_all_occupants( vehicle );
                wait 1;
            }
        }
        else
        {
            duration = 0;
        }
        
        waitframe();
    }
}

// Namespace namespace_2f878bc13d734510
// Params 0, eflags: 0x4
// Checksum 0x3088f2f1, Offset: 0x1fb3
// Size: 0xdc
function private function_f38af12057d618e8()
{
    vehicle = self;
    vehicle endon( #"death" );
    level endon( #"game_ended" );
    
    if ( !vehicle getscriptablehaspart( "stability" ) )
    {
        return;
    }
    
    while ( true )
    {
        vehicle waittill( #"collision", body0, body1, flag0, flag1, position, normal, impulse, ent );
        
        if ( vehicle hascomponent( "p2p" ) )
        {
            continue;
        }
        
        occupants = vehicle_occupancy::get_all_occupants( vehicle );
        
        if ( occupants.size == 0 )
        {
            vehicle utility::function_7c10ea82c1e305b8( "stability", "unstable" );
        }
    }
}

// Namespace namespace_2f878bc13d734510
// Params 0, eflags: 0x4
// Checksum 0x280cd3bf, Offset: 0x2097
// Size: 0x7c
function private function_c89324d472ee3db3()
{
    vehicle = self;
    
    while ( true )
    {
        if ( isdefined( vehicle.owner ) )
        {
            if ( vehicle.safepos != vehicle.origin && !isdefined( getwaterheightatlocation( vehicle.origin ) ) && vehicle vehicle_isonground() )
            {
                vehicle.safepos = vehicle.origin;
            }
        }
        
        wait 0.75;
    }
}

// Namespace namespace_2f878bc13d734510
// Params 0, eflags: 0x4
// Checksum 0x7e681919, Offset: 0x211b
// Size: 0x88
function private function_d3ca5b283086abfc()
{
    vehicle = self;
    vehicle endon( #"death" );
    vehicle childthread function_c89324d472ee3db3();
    vehicle childthread handle_underwater();
    
    while ( true )
    {
        waitframe();
        occupants = vehicle_occupancy::get_all_occupants( vehicle, 0 );
        
        if ( !isdefined( occupants ) || occupants.size == 0 )
        {
            function_4f2b808a2d09e507();
            
            if ( !vehicle.var_e8e1026ea2e971ce )
            {
                vehicle vehicle_setvelocity( anglestoforward( vehicle.angles ) * 0 );
            }
        }
    }
}

// Namespace namespace_2f878bc13d734510
// Params 0, eflags: 0x4
// Checksum 0x4ecc58c, Offset: 0x21ab
// Size: 0xac
function private handle_underwater()
{
    vehicle = self;
    duration = 0;
    
    while ( true )
    {
        var_f24faa2a30005d2f = vehicle gettagorigin( "tag_body" );
        var_fb32d8b7bd206b6f = utility::ispointinwater( var_f24faa2a30005d2f );
        var_44498f596d7ec24b = getwaterheightatlocation( vehicle.origin );
        
        if ( var_fb32d8b7bd206b6f && var_44498f596d7ec24b + 10 >= vehicle.origin[ 2 ] )
        {
            duration++;
            
            if ( duration > getdvarint( @"hash_bce32058b651db6c", 2 ) )
            {
                vehicle_occupancy::eject_all_occupants( vehicle );
            }
        }
        else
        {
            duration = 0;
        }
        
        wait 0.25;
    }
}

// Namespace namespace_2f878bc13d734510
// Params 0, eflags: 0x4
// Checksum 0x18b91c96, Offset: 0x225f
// Size: 0x234
function private function_4f2b808a2d09e507()
{
    vehicle = self;
    waterz = getwaterheightatlocation( vehicle.origin ) ?? 0;
    
    if ( waterz + 10 >= vehicle.origin[ 2 ] )
    {
        wait 0.75;
        vehicle.respawninprogress = 1;
        function_4c0de7cfcf40d8c1( vehicle, "water_despawn" );
        vehicle utility::function_7c10ea82c1e305b8( "single", "vehicle_unusable" );
        vehicle vehphys_parkingbrake( 1 );
        wait 0.5;
        
        if ( isnavmeshloaded() )
        {
            midpoint = ( vehicle.origin + vehicle.safepos ) * 0.5;
            respawnpoints = getrandomnavpoints( getclosestpointonnavmesh( midpoint, undefined, undefined, undefined, 1, 1 ), 400, 64 );
            var_fccac1ee2e9537f7 = undefined;
            
            foreach ( loc in respawnpoints )
            {
                if ( abs( loc[ 2 ] - vehicle.origin[ 2 ] ) > 300 )
                {
                    continue;
                }
                
                if ( distance2dsquared( vehicle.origin, loc ) <= 75 )
                {
                    continue;
                }
                
                if ( isdefined( getwaterheightatlocation( loc ) ) )
                {
                    continue;
                }
                
                var_fccac1ee2e9537f7 = utility::drop_to_ground( loc, 300 );
                break;
            }
            
            if ( isdefined( var_fccac1ee2e9537f7 ) )
            {
                vehicle.origin = var_fccac1ee2e9537f7;
            }
            else if ( isdefined( vehicle.safepos ) )
            {
                vehicle.origin = vehicle.safepos;
            }
        }
        else
        {
            vehicle.origin = vehicle.safepos;
        }
        
        wait 0.5;
        vehicle vehphys_parkingbrake( 0 );
        vehicle utility::function_7c10ea82c1e305b8( "single", "vehicle_use" );
        vehicle.respawninprogress = 0;
        function_4c0de7cfcf40d8c1( vehicle, "water_respawn" );
    }
}

// Namespace namespace_2f878bc13d734510
// Params 2, eflags: 0x4
// Checksum 0xe12290e5, Offset: 0x249b
// Size: 0x23
function private function_87542b8c8075c02b( vehicle, audio )
{
    vehicle.audiorequest = audio;
}

// Namespace namespace_2f878bc13d734510
// Params 0, eflags: 0x4
// Checksum 0x2e5e6c4e, Offset: 0x24c6
// Size: 0x2
function private function_50a9c4a325caf8b6()
{
    
}

// Namespace namespace_2f878bc13d734510
// Params 2, eflags: 0x4
// Checksum 0x5d15989e, Offset: 0x24d0
// Size: 0x23
function private function_4c0de7cfcf40d8c1( vehicle, state )
{
    vehicle.vfxrequest = state;
}

// Namespace namespace_2f878bc13d734510
// Params 1, eflags: 0x4
// Checksum 0x4d340499, Offset: 0x24fb
// Size: 0x22, Type: bool
function private function_29ad60f6e2d8623d( request )
{
    return request == "ready" && !self.respawninprogress;
}

// Namespace namespace_2f878bc13d734510
// Params 0, eflags: 0x4
// Checksum 0xa27bb2f2, Offset: 0x2526
// Size: 0x3de
function private function_4d3a180b24371ce0()
{
    vehicle = self;
    vehicle endon( #"death" );
    
    while ( true )
    {
        waitframe();
        
        if ( function_29ad60f6e2d8623d( vehicle.vfxrequest ) )
        {
            function_9954945aa8dca508( vehicle );
        }
        
        if ( function_29ad60f6e2d8623d( vehicle.vfxrequest ) )
        {
            function_19cfed75819a3626( vehicle );
        }
        
        if ( !function_29ad60f6e2d8623d( vehicle.vfxrequest ) )
        {
            vehicle.lastvfx = vehicle.vfxrequest;
        }
        
        switch ( vehicle.vfxrequest )
        {
            case #"hash_bec0ece15df7da12":
                vehicle utility::function_7c10ea82c1e305b8( "speedAetherFlames", "off" );
                break;
            case #"hash_aa68272961722807":
                vehicle utility::function_7c10ea82c1e305b8( "chargeAetherFlames", "off" );
                break;
            case #"hash_8341412f148011b0":
                vehicle utility::function_7c10ea82c1e305b8( "aetherPulse", "off" );
                break;
            case #"hash_eb21a680c2fb1c06":
                vehicle utility::function_7c10ea82c1e305b8( "speedAetherFlames", "off" );
                vehicle utility::function_7c10ea82c1e305b8( "chargeAetherFlames", "off" );
                break;
            case #"hash_8e6dd98e1f812357":
                vehicle utility::function_7c10ea82c1e305b8( "speedAetherFlames", "idleFlames" );
                vehicle utility::function_7c10ea82c1e305b8( "chargeAetherFlames", "idleFlames" );
                break;
            case #"hash_188b27d629a1729b":
                vehicle utility::function_7c10ea82c1e305b8( "speedAetherFlames", "idleFlames" );
                break;
            case #"hash_b84994e15ad39ab9":
                vehicle utility::function_7c10ea82c1e305b8( "speedAetherFlames", "lowFlames" );
                break;
            case #"hash_b0ce4ee156e3dbc1":
                vehicle utility::function_7c10ea82c1e305b8( "speedAetherFlames", "medFlames" );
                break;
            case #"hash_8d78b1dc39bee7f5":
                vehicle utility::function_7c10ea82c1e305b8( "speedAetherFlames", "highFlames" );
                break;
            case #"hash_a6435219404def7c":
                vehicle utility::function_7c10ea82c1e305b8( "chargeAetherFlames", "idleFlames" );
                break;
            case #"hash_b4696f29675ed610":
                vehicle utility::function_7c10ea82c1e305b8( "chargeAetherFlames", "lowFlames" );
                break;
            case #"hash_badcc5296a7f40ac":
                vehicle utility::function_7c10ea82c1e305b8( "chargeAetherFlames", "medFlames" );
                break;
            case #"hash_2e2fb8132db5f7f2":
                vehicle utility::function_7c10ea82c1e305b8( "chargeAetherFlames", "highFlames" );
                break;
            case #"hash_fbdd2529a8b3563":
                vehicle utility::function_7c10ea82c1e305b8( "chargeAetherFlames", "fullFlames" );
                break;
            case #"hash_faeec005d57d828e":
                if ( vehicle utility::function_9f2c41c1dcc8c94( "aetherPulse", "on" ) )
                {
                    vehicle utility::function_7c10ea82c1e305b8( "aetherPulse", "off" );
                    waitframe();
                }
                
                vehicle utility::function_7c10ea82c1e305b8( "aetherPulse", "on" );
                break;
            case #"hash_819aac6f5ae2fb78":
                vehicle utility::function_7c10ea82c1e305b8( "spawn", "spawn" );
                break;
            case #"hash_5393f9d1201e0aa9":
                vehicle utility::function_7c10ea82c1e305b8( "spawn", "despawn" );
                break;
            case #"hash_d1fcfd04cc8d6fe1":
                vehicle utility::function_7c10ea82c1e305b8( "speedAetherFlames", "off" );
                vehicle utility::function_7c10ea82c1e305b8( "chargeAetherFlames", "off" );
                vehicle utility::function_7c10ea82c1e305b8( "spawn", "despawn" );
                vehicle utility::function_7c10ea82c1e305b8( "stability", "stable" );
                break;
            case #"hash_770a027782f85117":
                vehicle utility::function_7c10ea82c1e305b8( "spawn", "respawn" );
                break;
            default:
                break;
        }
        
        if ( !function_29ad60f6e2d8623d( vehicle.vfxrequest ) )
        {
            function_4c0de7cfcf40d8c1( vehicle, "ready" );
        }
    }
}

// Namespace namespace_2f878bc13d734510
// Params 2, eflags: 0x4
// Checksum 0xc6d71739, Offset: 0x290c
// Size: 0x43b
function private function_bb16171e4c19ae7( victim, crushed )
{
    vehicle = self;
    
    if ( victim tagexists( "j_mainroot" ) )
    {
        fxent = spawn( "script_model", victim gettagorigin( "j_mainroot" ) );
    }
    else
    {
        fxent = spawn( "script_model", victim gettagorigin( victim function_cb497b712374573a( 0 ) ) );
    }
    
    fxent.angles = victim.angles;
    fxent setmodel( "iw9_player_death_fx" );
    
    if ( crushed )
    {
        if ( fxent.model != "" )
        {
            fxent setscriptablepartstate( "corpseMist", "effects", 0 );
        }
        
        occupants = vehicle_occupancy::get_all_occupants( vehicle );
        
        foreach ( occupant in occupants )
        {
            if ( isdefined( occupant ) )
            {
                vehicle playsoundtoplayer( "veh_jup_motorcycle_zmb_hit", occupant, vehicle );
            }
        }
    }
    
    var_51a27eb312d170c7 = getdvarint( @"hash_28b89acc80b6ee14", 0 ) != 0;
    
    if ( !var_51a27eb312d170c7 )
    {
        function_e401d69ac363b1ca();
        wait 3;
        fxent delete();
        return;
    }
    
    waitframe();
    
    if ( !isdefined( fxent ) )
    {
        return;
    }
    
    if ( isdefined( level._effect[ "absorb_blood" ] ) )
    {
        playfxontag( level._effect[ "absorb_blood" ], fxent, "tag_origin" );
    }
    
    target_pos = vehicle gettagorigin( "tag_headlight" );
    
    if ( !isdefined( target_pos ) )
    {
        return;
    }
    
    target_dir = vectornormalize( target_pos - fxent.origin );
    plane_vec = function_6a27e09c0596be65( target_dir );
    rotation = randomint( 360 );
    start_speed_scale = 0.8;
    acc_vert = 1.8;
    max_speed = 18;
    
    /#
        start_speed_scale = getdvarfloat( @"hash_732e60be84ebafe9", 0.8 );
        acc_vert = getdvarfloat( @"hash_6a65baecb2af5ee1", 1.8 );
        max_speed = getdvarfloat( @"hash_3155078381c8b922", 18 );
    #/
    
    distance_2d = distance2d( target_pos, fxent.origin );
    start_speed = randomfloat( start_speed_scale ) * distance_2d / 20;
    start_dir = rotatepointaroundvector( plane_vec, target_dir, rotation );
    v_vert = 0;
    v_hori = start_speed;
    a_vert = acc_vert;
    a_hori = v_hori > 0.0001 ? 2 * v_hori / sqrt( 2 * distance_2d / a_vert ) : 0;
    var_c894d015102c0926 = 8;
    success = 0;
    
    while ( !success )
    {
        move_vec = target_dir * v_vert + start_dir * v_hori;
        
        if ( length( move_vec ) < distance_2d )
        {
            fxent moveto( fxent.origin + move_vec, 0.05 );
        }
        else
        {
            success = 1;
            break;
        }
        
        waitframe();
        
        if ( !isdefined( vehicle ) )
        {
            break;
        }
        
        target_pos = vehicle gettagorigin( "tag_headlight" );
        
        if ( !isdefined( target_pos ) )
        {
            break;
        }
        
        distance_2d = distance2d( target_pos, fxent.origin );
        var_c894d015102c0926 = math::lerp( 8, 16, vehicle.var_c4cf4c9885f10ae6 / vehicle.var_a77896cad2f2f335 );
        
        if ( distance_2d <= var_c894d015102c0926 )
        {
            success = 1;
            break;
        }
        
        target_dir = vectornormalize( target_pos - fxent.origin );
        var_b13944fe88575390 = max_speed + vehicle.var_c4cf4c9885f10ae6;
        v_hori = v_hori > 0 ? v_hori - a_hori : 0;
        v_vert = v_vert < var_b13944fe88575390 ? v_vert + a_vert : var_b13944fe88575390;
    }
    
    if ( success )
    {
        fxent.origin = target_pos;
        function_e401d69ac363b1ca();
        waitframe();
    }
    
    fxent delete();
}

// Namespace namespace_2f878bc13d734510
// Params 1, eflags: 0x4
// Checksum 0xaab1abdf, Offset: 0x2d4f
// Size: 0xbc
function private function_6a27e09c0596be65( src )
{
    srcsq = src * src;
    pos = 0;
    
    if ( srcsq[ 1 ] < srcsq[ 0 ] )
    {
        pos = 1;
    }
    
    if ( srcsq[ 2 ] < srcsq[ pos ] )
    {
        pos = 2;
    }
    
    d = src[ pos ] * -1;
    dst = src * d;
    
    if ( pos == 0 )
    {
        dst += ( 1, 0, 0 );
    }
    
    if ( pos == 1 )
    {
        dst += ( 0, 1, 0 );
    }
    
    if ( pos == 2 )
    {
        dst += ( 0, 0, 1 );
    }
    
    dst = vectornormalize( dst );
    return dst;
}

// Namespace namespace_2f878bc13d734510
// Params 1
// Checksum 0xc2b16399, Offset: 0x2e14
// Size: 0x25, Type: bool
function function_be20dd74edf1033a( vehicle )
{
    occupants = vehicle_occupancy::get_all_occupants( vehicle, 0 );
    return isdefined( occupants[ 0 ] );
}

// Namespace namespace_2f878bc13d734510
// Params 1
// Checksum 0xef5da315, Offset: 0x2e42
// Size: 0x25, Type: bool
function function_d0650a3fc1e2a5( vehicle )
{
    occupants = vehicle_occupancy::get_all_occupants( vehicle );
    return occupants.size > 0;
}

// Namespace namespace_2f878bc13d734510
// Params 1, eflags: 0x4
// Checksum 0x91d9c52e, Offset: 0x2e70
// Size: 0x19
function private function_4d33120a47141f60( state )
{
    self setclientomnvar( "ui_vehicle_ability_state", state );
}

// Namespace namespace_2f878bc13d734510
// Params 1, eflags: 0x4
// Checksum 0x662a1716, Offset: 0x2e91
// Size: 0x19
function private function_5540c7664be17810( progress )
{
    self setclientomnvar( "ui_vehicle_ability_progress", progress );
}

// Namespace namespace_2f878bc13d734510
// Params 1, eflags: 0x4
// Checksum 0x92eb19f4, Offset: 0x2eb2
// Size: 0x19
function private function_cffc2c2fed2a433( fuel )
{
    self setclientomnvar( "ui_vehicle_ability_fuel", fuel );
}

// Namespace namespace_2f878bc13d734510
// Params 2, eflags: 0x4
// Checksum 0x4fc0eced, Offset: 0x2ed3
// Size: 0x1e
function private function_72dc653da3cbef0( var_ad560b8d2b169494, value )
{
    self setclientomnvar( var_ad560b8d2b169494, value );
}

// Namespace namespace_2f878bc13d734510
// Params 1, eflags: 0x4
// Checksum 0x1516d131, Offset: 0x2ef9
// Size: 0xb9
function private function_7552605d4c1d22c1( duration )
{
    self endon( #"hash_e67e0494c7e2208d" );
    var_f2b58f3c2a06b31e = 1;
    updatetimeinterval = 0.1;
    var_758b7f76e16c267f = duration;
    var_3768bbfbaf5d5ac2 = gettime() / 1000;
    
    while ( var_f2b58f3c2a06b31e >= 0 && self.abilityinprogress )
    {
        currenttime = gettime() / 1000;
        var_405dc620628e39de = 1 - ( currenttime - var_3768bbfbaf5d5ac2 ) / var_758b7f76e16c267f;
        var_f2b58f3c2a06b31e = clamp( var_405dc620628e39de, 0, 1 );
        self.owner function_5540c7664be17810( var_f2b58f3c2a06b31e );
        wait updatetimeinterval;
    }
}

// Namespace namespace_2f878bc13d734510
// Params 0, eflags: 0x4
// Checksum 0x292bd064, Offset: 0x2fba
// Size: 0xb4
function private function_2516663cd1ea8a2()
{
    self endon( #"hash_e67e0494c7e2208d" );
    var_f2b58f3c2a06b31e = 1;
    updatetimeinterval = 0.1;
    var_3768bbfbaf5d5ac2 = gettime() / 1000;
    
    while ( !isdefined( self.owner ) )
    {
        wait 0.1;
    }
    
    while ( var_f2b58f3c2a06b31e >= 0 )
    {
        currenttime = gettime() / 1000;
        var_405dc620628e39de = 1 - ( currenttime - var_3768bbfbaf5d5ac2 ) / self.lifespan;
        var_f2b58f3c2a06b31e = clamp( var_405dc620628e39de, 0, 1 );
        self.owner function_cffc2c2fed2a433( var_f2b58f3c2a06b31e );
        wait updatetimeinterval;
    }
}

// Namespace namespace_2f878bc13d734510
// Params 1, eflags: 0x4
// Checksum 0x841a64ee, Offset: 0x3076
// Size: 0x127
function private function_ec6e92dd347b4131( point )
{
    if ( !isdefined( level.region_difficulty_manager.regions ) )
    {
        return "difficulty_easy";
    }
    
    var_93cd412d79e5e458 = undefined;
    var_fe6dae3e95f1ae7a = undefined;
    
    foreach ( region in level.region_difficulty_manager.regions )
    {
        if ( ispointinvolume( point, region.volume ) )
        {
            if ( isdefined( var_fe6dae3e95f1ae7a ) )
            {
                volume_size = length( region.volume getboundshalfsize() );
                
                if ( volume_size < var_fe6dae3e95f1ae7a )
                {
                    var_93cd412d79e5e458 = region;
                    var_fe6dae3e95f1ae7a = volume_size;
                }
                
                continue;
            }
            
            var_93cd412d79e5e458 = region;
            var_fe6dae3e95f1ae7a = length( region.volume getboundshalfsize() );
        }
    }
    
    return var_93cd412d79e5e458.difficultyint;
}

// Namespace namespace_2f878bc13d734510
// Params 2, eflags: 0x4
// Checksum 0x8a76c33e, Offset: 0x31a6
// Size: 0x11e
function private function_f7efcaf092a225e9( target, vehiclebundle )
{
    vehicle = self;
    
    if ( utility::issharedfuncdefined( #"zombie_damage", #"hash_8a5422fcea1951e4" ) )
    {
        profilestart();
        adjusteddamage = target utility::callsharedfunc( #"zombie_damage", #"hash_8a5422fcea1951e4", vehiclebundle.wondervehicle.blood_burner_damage, weapon::buildweapon( vehiclebundle.weapon ), vehicle.owner );
        profilestop();
    }
    
    var_4ad0525bf291bf21 = adjusteddamage ?? vehiclebundle.wondervehicle.blood_burner_damage;
    difficulty_region = function_ec6e92dd347b4131( vehicle.origin ) ?? 0;
    
    if ( difficulty_region <= 1 && target.aicategory == "normal" )
    {
        target.full_gib = 1;
        target.forceannihilate = 1;
        return target.health;
    }
    
    return var_4ad0525bf291bf21;
}

/#

    // Namespace namespace_2f878bc13d734510
    // Params 0, eflags: 0x4
    // Checksum 0x8f0dbf83, Offset: 0x32cd
    // Size: 0x198, Type: dev
    function private function_c0219cc1fe33ba7b()
    {
        vehicle = self;
        vehicle endon( #"death" );
        devgui::function_9082edeb5db93280( "<dev string:x79>" );
        devgui::add_devgui_command( "<dev string:x98>", "<dev string:xbb>" );
        devgui::add_devgui_command( "<dev string:xed>", "<dev string:x10d>" );
        devgui::add_devgui_command( "<dev string:x133>", "<dev string:x151>" );
        devgui::add_devgui_command( "<dev string:x175>", "<dev string:x194>" );
        devgui::add_devgui_command( "<dev string:x1b8>", "<dev string:x1e2>" );
        devgui::function_77df7fe7dd273e10();
        
        while ( true )
        {
            waitframe();
            
            if ( isdefined( vehicle.owner ) )
            {
                if ( getdvarint( @"hash_4e48fed1a83a010f", 0 ) == 1 )
                {
                    if ( !vehicle.abilityready )
                    {
                        set_ability_status( vehicle, 1 );
                        vehicle thread function_20d7bd2951119cf6();
                    }
                }
                
                if ( getdvarint( @"hash_1601592e811a91ed", 0 ) == 1 )
                {
                    data = vehicle::get_data( %"hash_244559a74b556cda" );
                    
                    if ( vehicle.enemieskilled < data.wondervehicle.var_7981ed21cc0fab1d )
                    {
                        function_e401d69ac363b1ca();
                        wait 0.25;
                    }
                }
                
                if ( getdvarint( @"hash_762710f95982f0ae", 0 ) == 1 )
                {
                    iprintln( "<dev string:x208>" + vehicle.killstate + "<dev string:x210>" + vehicle.enemieskilled );
                    wait 0.1;
                }
                
                if ( getdvarint( @"hash_764aae2bfad0aaf", 0 ) == 1 )
                {
                    vehicle.unlimitedtime = 1;
                }
            }
        }
    }

#/
