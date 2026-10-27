// scripts\mp\common\killstreaks\ims.gsc  (hash_0128d88ded6da393.gscc) (size: 11997 Bytes / 0x2edd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8734c255 (2268381781)
// size ...... 11997 (0x2edd)
// includes .. 16  (offset: 0x2c0d)
// strings ... 39  (offset: 0x2c8d)
// dev strs .. 2   (offset: 0x2ec5)
// exports ... 32  (offset: 0x1add)
// cseg ...... 0x2e9 + 0x17f4 (0x1add)
// imports ... 103 (offset: 0x1fdd)
// animtree1 . 0   (offset: 0x2edd)
// animtree2 . 0   (offset: 0x2edd)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\functionals_utility;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_mines;
#using scripts\common\weapon;
#using scripts\mp\common\equipment\haywire;
#using scripts\mp\common\killstreaks\killstreakdeploy;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\emp_debuff;

#namespace ims;

// Namespace ims
// Params 0, eflags: 0x1
// Checksum 0x36384804, Offset: 0x307
// Size: 0x17
function autoexec main()
{
    killstreak_shared::registerkillstreakinitfunction( getxhash( "ims" ), &init );
}

// Namespace ims
// Params 0, eflags: 0x4
// Checksum 0x9421ee99, Offset: 0x326
// Size: 0x138
function private init()
{
    if ( utility::issharedfuncdefined( #"killstreak", #"registerkillstreak" ) )
    {
        [[ utility::getsharedfunc( #"killstreak", #"registerkillstreak" ) ]]( "ims", &tryuseims );
    }
    
    utility::registersharedfunc( #"ims", #"tryusekillstreak", &tryuseims );
    utility::registersharedfunc( #"ims", #"ims_onhacked", &ims_onhacked );
    bundle = level.streakglobals.streakbundles[ "ims" ];
    
    if ( isdefined( bundle ) && isdefined( bundle.var_cabe3683de629f75 ) )
    {
        namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "ims", bundle.deployweapon, #"donotregister" );
        namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "ims", bundle.spawnweapon, #"donotregister" );
        namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "ims", bundle.var_cabe3683de629f75, #"donotregister" );
        namespace_9d8e359c3b1041e5::registerkillstreakdamagedealingweaponsharedfunc( "ims", bundle.var_c3ab71132da0bbac, #"large" );
    }
}

// Namespace ims
// Params 1
// Checksum 0xd4bd8d5d, Offset: 0x466
// Size: 0x153, Type: bool
function tryuseims( streakinfo = killstreak_utility::createstreakinfo( "ims", self ) )
{
    bundle = level.streakglobals.streakbundles[ "ims" ];
    
    if ( isdefined( level.killstreaktriggeredfunc ) )
    {
        if ( !level [[ level.killstreaktriggeredfunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    imsgrenade = ims_deploy( streakinfo, bundle );
    
    if ( !isdefined( imsgrenade ) )
    {
        return false;
    }
    
    if ( isdefined( level.killstreakbeginusefunc ) )
    {
        if ( !level [[ level.killstreakbeginusefunc ]]( streakinfo ) )
        {
            return false;
        }
    }
    
    imsgrenade weapon::registermine();
    imsgrenade function_d4a2fbc629e96c5( streakinfo );
    imsgrenade thread killstreak_utility::killstreak_watchpickup( streakinfo, &ims_onpickup );
    imsgrenade thread ims_watchtrigger( streakinfo );
    imsgrenade haywire::function_7f69a1eb3d590f76( &ims_haywireapplied );
    imsgrenade haywire::function_d7496c23fe4085d4( &function_16fe04641947376b );
    imsgrenade emp_debuff::set_apply_emp_callback( &ims_empapplied );
    
    if ( level.killstreak_emp_initialized )
    {
        imsgrenade.ksempapplycallback = &ims_empapplied;
    }
    
    imsgrenade emp_debuff::set_clear_emp_callback( &ims_empcleared );
    
    if ( level.killstreak_emp_initialized )
    {
        imsgrenade.ksempclearcallback = &ims_empcleared;
    }
    
    self notify( #"munitions_used", "ims" );
    return true;
}

// Namespace ims
// Params 2
// Checksum 0x591ad09f, Offset: 0x5c2
// Size: 0x91
function ims_deploy( streakinfo, bundle )
{
    self endon( #"death" );
    self endon( #"disconnect" );
    deployweapon = makeweapon( bundle.deployweapon );
    deployresult = killstreakdeploy::streakdeploy_doweaponswitchdeploy( streakinfo, deployweapon, 1, undefined, undefined, &killstreak_utility::function_3b33dde6cf9d04b7 );
    
    if ( !deployresult )
    {
        return;
    }
    
    function_1735b5b0da582f57( 1 );
    placedgrenade = ims_place( streakinfo, bundle );
    function_1735b5b0da582f57( 0 );
    return placedgrenade;
}

// Namespace ims
// Params 1
// Checksum 0x441dea39, Offset: 0x65c
// Size: 0x6d
function function_1735b5b0da582f57( disableactions )
{
    if ( player::isreallyalive() )
    {
        if ( disableactions )
        {
            val::set_array( "lrad_placement", [ "sprint", "weapon_switch", "offhand_weapons", "melee", "execution_attack", "ladder_placement" ], 0 );
            return;
        }
        
        val::reset_all( "lrad_placement" );
    }
}

// Namespace ims
// Params 2
// Checksum 0x80b72467, Offset: 0x6d1
// Size: 0xb0
function ims_place( streakinfo, bundle )
{
    marker = killstreak_utility::function_8ac1515799ff58a5( streakinfo, bundle.deployweapon, 0, 1, 0.25, 0.8, &function_39ece940bc4966a2 );
    placedgrenade = undefined;
    
    if ( isdefined( marker ) )
    {
        placedgrenade = ims_placegrenade( marker, bundle );
        
        if ( utility::issharedfuncdefined( #"sound", #"playkillstreakdeploydialog" ) )
        {
            placedgrenade.owner [[ utility::getsharedfunc( #"sound", #"playkillstreakdeploydialog" ) ]]( streakinfo.streakname );
        }
    }
    
    return placedgrenade;
}

// Namespace ims
// Params 1
// Checksum 0x9ceeb1dd, Offset: 0x78a
// Size: 0x1a7
function function_39ece940bc4966a2( markerinfo )
{
    bundle = level.streakglobals.streakbundles[ "ims" ];
    verticaloffset = getdvarfloat( @"hash_f4da9af39e4b013e", 30 );
    markerpos = markerinfo.location + ( 0, 0, verticaloffset );
    maxheight = getdvarfloat( @"hash_c4ea2188934a7074", bundle.var_fbbe99ffc8710338 ) - verticaloffset;
    minheight = getdvarfloat( @"hash_4f29060321502b96", bundle.var_54cf47868645c2b6 ) - verticaloffset;
    radius = getdvarfloat( @"hash_26d52d1f90cea54c", 15 );
    ishit = 0;
    
    for ( i = 0; i < 3 ; i++ )
    {
        lerpval = ( 2 - i ) / 2;
        height = math::lerp( minheight, maxheight, lerpval );
        ishit = physics_spherecast( markerpos, markerpos + ( 0, 0, height ), radius, function_e58c56b734c5bda8(), [ self ], "physicsquery_any" );
        
        if ( !ishit )
        {
            markerinfo.imsheight = markerpos[ 2 ] + height - getdvarfloat( @"hash_46238b5b95d2b806", 10 );
            break;
        }
    }
    
    if ( ishit && utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
    {
        self [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( %"killstreaks/cannot_be_placed_vertical" );
    }
    
    return ishit;
}

// Namespace ims
// Params 3
// Checksum 0x4e643fbf, Offset: 0x93a
// Size: 0x207
function ims_placegrenade( marker, bundle, placedgrenade )
{
    if ( !isdefined( placedgrenade ) )
    {
        placedgrenade = self launchgrenade( bundle.spawnweapon, marker.location + ( 0, 0, 5 ), ( 0, 0, 0 ) );
    }
    else
    {
        placedgrenade.origin = marker.location + ( 0, 0, 5 );
    }
    
    placedgrenade.angles = self.angles;
    placedgrenade.team = self.team;
    placedgrenade.owner = self;
    placedgrenade.bundle = bundle;
    placedgrenade.imsheight = marker.imsheight;
    placedgrenade setentityhudoutlinedata( 3, placedgrenade.team );
    placedgrenade setscriptablepartstate( "main", "active" );
    
    if ( utility::issharedfuncdefined( #"killstreak", #"addtoactivekillstreaklist" ) )
    {
        placedgrenade [[ utility::getsharedfunc( #"killstreak", #"addtoactivekillstreaklist" ) ]]( "ims", "Killstreak_Ground", self, 0, 1, 20, "picked_up" );
    }
    
    placedgrenade killstreak_utility::function_7aef34478569525d( self, "tag_fx", &"killstreaks_hints/ims_use" );
    
    if ( utility::issharedfuncdefined( #"game", #"createobjective" ) )
    {
        placedgrenade.minimapid = placedgrenade [[ utility::getsharedfunc( #"game", #"createobjective" ) ]]( "hud_icon_minimap_killstreak_sentry", placedgrenade.team, 1, 1, 1 );
    }
    
    placedgrenade killstreak_utility::function_e6fc48237c0a5166( #"hash_eafb9a6b88def4ca", placedgrenade.origin, placedgrenade.team, placedgrenade.owner );
    placedgrenade.var_630d803dd7b94a73 = 1;
    return placedgrenade;
}

// Namespace ims
// Params 2
// Checksum 0xbea1a14, Offset: 0xb4a
// Size: 0x115
function ims_onpickup( imsgrenade, streakinfo )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    imsgrenade functionals_utility::clearminimapid();
    imsgrenade setscriptablepartstate( "main", "picked_up" );
    imsgrenade.var_630d803dd7b94a73 = 0;
    imsgrenade notify( #"picked_up" );
    imsgrenade killstreak_utility::function_43ef8750f44fafce();
    weapon_utility::saveweaponstates();
    inventory_utility::_giveweapon( imsgrenade.bundle.deployweapon );
    inventory_utility::_switchtoweapon( imsgrenade.bundle.deployweapon );
    function_1735b5b0da582f57( 1 );
    marker = killstreak_utility::function_8ac1515799ff58a5( streakinfo, imsgrenade.bundle.deployweapon, 1, 1, 0.25, 0.8, &function_39ece940bc4966a2 );
    function_1735b5b0da582f57( 0 );
    
    if ( !isdefined( marker ) )
    {
        return 0;
    }
    
    ims_placegrenade( marker, imsgrenade.bundle, imsgrenade );
}

// Namespace ims
// Params 1
// Checksum 0x5cdc369d, Offset: 0xc67
// Size: 0xca
function function_d4a2fbc629e96c5( streakinfo )
{
    if ( utility::issharedfuncdefined( #"damage", #"onkillstreakkilled" ) )
    {
        functionals_utility::function_581632a552d7d7d6( "ims", "destroyed_ims", "destroyed_ims", "callout_destroyed_ims" );
    }
    
    if ( utility::issharedfuncdefined( #"damage", #"monitordamage" ) )
    {
        maxhealth = getdvarfloat( @"hash_b222a9d8ac2c3cca", self.bundle.maxhealth );
        self thread [[ utility::getsharedfunc( #"damage", #"monitordamage" ) ]]( maxhealth, "hitequip", &functionals_utility::functionals_handlefataldamage, &ims_handledamage, 0 );
    }
    
    functionals_utility::function_f9c3bc385df6f245( streakinfo, &function_66ca0252390f03e3, &ims_destroy );
}

// Namespace ims
// Params 1
// Checksum 0x54b1bfd2, Offset: 0xd39
// Size: 0xbb
function ims_handledamage( data )
{
    if ( isdefined( data.objweapon ) && data.objweapon.basename == self.bundle.var_c3ab71132da0bbac )
    {
        return 0;
    }
    
    modifieddamage = functionals_utility::functionals_handledamage( data );
    newhealth = self.health - modifieddamage;
    percentage = newhealth / self.maxhealth;
    
    if ( percentage <= 0.5 && self getscriptablepartstate( "damaged" ) == "not_damaged" )
    {
        self setscriptablepartstate( "damaged", "damaged" );
    }
    
    return modifieddamage;
}

// Namespace ims
// Params 1
// Checksum 0x117816a4, Offset: 0xdfd
// Size: 0x76
function function_66ca0252390f03e3( callbackparams )
{
    meansofdeath = callbackparams.meansofdeath;
    
    if ( isdefined( self.useownerobj ) )
    {
        self.useownerobj setusableenabled( 0 );
    }
    
    if ( self.chargesleft == 0 )
    {
        self setscriptablepartstate( "explode", "regular" );
    }
    else
    {
        self setscriptablepartstate( "explode", "violent" );
    }
    
    wait 0.2;
}

// Namespace ims
// Params 1
// Checksum 0x50e1f03, Offset: 0xe7b
// Size: 0x42
function ims_destroy( delaytime )
{
    if ( isdefined( delaytime ) )
    {
        wait delaytime;
    }
    
    weapon::deregistermine();
    
    if ( isdefined( self.useownerobj ) )
    {
        self.useownerobj delete();
    }
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace ims
// Params 1, eflags: 0x4
// Checksum 0x2e9a0d72, Offset: 0xec5
// Size: 0x4a
function private function_e58c56b734c5bda8( var_4ee95128482b19fd )
{
    resultarray = [ "physicscontents_missileclip", "physicscontents_clipshot", "physicscontents_glass" ];
    
    if ( var_4ee95128482b19fd )
    {
        resultarray[ resultarray.size ] = "physicscontents_characterproxy";
    }
    
    return physics_createcontents( resultarray );
}

// Namespace ims
// Params 1
// Checksum 0x483f7541, Offset: 0xf18
// Size: 0x304
function ims_watchtrigger( streakinfo )
{
    self endon( #"death" );
    level endon( #"game_ended" );
    var_b1b9d5f130378e22 = [ "j_disc_01", "j_disc_02", "j_disc_03", "j_disc_04" ];
    self.chargesleft = 4;
    self.var_215d108ff35d2792 = [];
    var_2943efbe5ce33a02 = 0;
    
    /#
        var_2943efbe5ce33a02 = getdvarint( @"hash_9fbc814198194d10", 0 ) == 1;
    #/
    
    var_23a82edf24269a34 = isdefined( level.gametypebundle ) && level.gametypebundle.var_23a82edf24269a34;
    
    while ( self.chargesleft > 0 || var_2943efbe5ce33a02 )
    {
        self waittill( #"trigger_grenade", entarr );
        
        if ( !self.var_630d803dd7b94a73 )
        {
            continue;
        }
        
        assert( isdefined( entarr ) );
        
        foreach ( ent in entarr )
        {
            entitynumber = ent getentitynumber();
            
            if ( ent.classname == "script_vehicle" )
            {
                if ( ent function_3326343345cb8f28( self ) )
                {
                    continue;
                }
            }
            
            if ( ( isagent( ent ) || isplayer( ent ) ) && !arraycontains( self.var_215d108ff35d2792, entitynumber ) )
            {
                if ( ent function_2c88e83c4f114c95() )
                {
                    continue;
                }
                
                if ( var_23a82edf24269a34 && ent.spawnprotection )
                {
                    continue;
                }
                
                chargeindex = ( 4 - self.chargesleft ) % 4;
                up = ( 0, 0, 1 );
                chargestartpos = self gettagorigin( var_b1b9d5f130378e22[ chargeindex ] ) + up * 10;
                targetpos = ent.origin + ( 0, 0, getdvarfloat( @"hash_e08464464d929411", self.bundle.var_72e9f2058be2a9bd ) );
                var_20be66b1f2399abd = ( chargestartpos[ 0 ], chargestartpos[ 1 ], self.imsheight );
                castresults = physics_raycast( var_20be66b1f2399abd, targetpos, function_e58c56b734c5bda8(), [], 0, "physicsquery_closest", 1 );
                
                if ( isdefined( castresults ) && castresults.size > 0 )
                {
                    continue;
                }
                
                self.var_215d108ff35d2792[ self.var_215d108ff35d2792.size ] = entitynumber;
                self.chargesleft--;
                thread function_8ba97e6d23a765dd( streakinfo, ent, 1, chargeindex, chargestartpos, var_20be66b1f2399abd );
                
                if ( self.chargesleft == 0 && !var_2943efbe5ce33a02 )
                {
                    function_104ce6a2849f8c56();
                }
                
                break;
            }
        }
    }
}

// Namespace ims
// Params 0
// Checksum 0xa9c5af17, Offset: 0x1224
// Size: 0x3c
function function_104ce6a2849f8c56()
{
    self.selfdestructing = 1;
    
    if ( isdefined( self.useownerobj ) )
    {
        self.useownerobj setusableenabled( 0 );
    }
    
    wait 3;
    callback::callback( #"on_functional_death" );
}

// Namespace ims
// Params 1
// Checksum 0x6bb8c70e, Offset: 0x1268
// Size: 0x2b, Type: bool
function function_3326343345cb8f28( grenade )
{
    if ( vehicle_mines::function_56d954c642e8acea( grenade ) )
    {
        return true;
    }
    
    if ( !vehicle_mines::function_60d53a1a3bd504cd( self, grenade ) )
    {
        return true;
    }
    
    return false;
}

// Namespace ims
// Params 0
// Checksum 0x8b73963e, Offset: 0x129c
// Size: 0x4d, Type: bool
function function_2c88e83c4f114c95()
{
    if ( !isplayer( self ) && !isagent( self ) )
    {
        return true;
    }
    
    if ( isdefined( self.vehicle ) )
    {
        return true;
    }
    
    if ( !player::isreallyalive( self ) )
    {
        return true;
    }
    
    if ( isdefined( self.perks[ "specialty_blindeye" ] ) )
    {
        return true;
    }
    
    return false;
}

// Namespace ims
// Params 6
// Checksum 0x67fc6dd8, Offset: 0x12f2
// Size: 0x206
function function_8ba97e6d23a765dd( streakinfo, target, targetisplayer, chargeindex, chargestartpos, var_20be66b1f2399abd )
{
    level endon( #"game_ended" );
    bundle = self.bundle;
    owner = self.owner;
    targetstruct = target function_2f41dcdf33f10e4a( bundle );
    
    if ( isdefined( target ) && targetisplayer && isdefined( target.perks[ "specialty_delaymine" ] ) )
    {
        wait level.delayminetime;
    }
    
    self setscriptablepartstate( "charge_" + chargeindex, "used" );
    assert( isdefined( bundle.var_cabe3683de629f75 ) );
    var_c3b7c48f614f6ed8 = getdvarfloat( @"hash_d2d758f71d991a51", bundle.var_c281b19b3429316b );
    gravity = ( 0, 0, getdvarfloat( @"hash_a55083bd04392924", bundle.var_a80387d534252fab ) );
    charge = owner launchgrenade( bundle.var_cabe3683de629f75, chargestartpos, ( 0, 0, 0 ), var_c3b7c48f614f6ed8 );
    charge.streakinfo = streakinfo;
    charge thread function_7172fa0fa7616441( owner, chargestartpos, var_20be66b1f2399abd, var_c3b7c48f614f6ed8, gravity );
    charge waittill( #"explode", explodepos );
    timetotarget = getdvarfloat( @"hash_db9763666846c7b2", bundle.var_84724c65d88fc6f8 );
    gravity = ( 0, 0, getdvarfloat( @"bg_gravity" ) * -1 );
    velocity = trajectorycalculateinitialvelocity( explodepos, targetstruct function_a88e45ccb3579780(), gravity, timetotarget );
    explosive = owner launchgrenade( bundle.var_c3ab71132da0bbac, explodepos, velocity, timetotarget );
    explosive thread function_1b599c61d5e6b9df( bundle, owner, targetstruct );
    explosive thread ims_watchexplode( self, targetstruct, chargeindex );
}

// Namespace ims
// Params 5
// Checksum 0x326b3760, Offset: 0x1500
// Size: 0x151
function function_7172fa0fa7616441( owner, startpos, endpos, timetotarget, gravity )
{
    level endon( #"game_ended" );
    self endon( #"explode" );
    velocity = trajectorycalculateinitialvelocity( startpos, endpos, gravity, timetotarget );
    newposition = startpos;
    previoustime = gettime();
    collisioncontents = function_e58c56b734c5bda8( 1 );
    
    while ( true )
    {
        owner waittill( #"grenade_thrown", throwngrenade );
        
        if ( throwngrenade == self )
        {
            break;
        }
    }
    
    while ( true )
    {
        deltatime = ( gettime() - previoustime ) / 1000;
        previoustime = gettime();
        velocity += gravity * deltatime;
        newposition += velocity * deltatime;
        self.origin = newposition;
        var_c47600544f4dac3c = getdvarfloat( @"hash_bbe98d05a761d42", 20 );
        raycastend = newposition + var_c47600544f4dac3c * ( 0, 0, 1 );
        ishit = physics_raycast( newposition, raycastend, collisioncontents, [], 0, "physicsquery_any" );
        
        if ( ishit )
        {
            self detonate();
            break;
        }
        
        waitframe();
    }
}

// Namespace ims
// Params 1
// Checksum 0x39f197d8, Offset: 0x1659
// Size: 0x81
function function_2f41dcdf33f10e4a( bundle )
{
    targetstruct = spawnstruct();
    targetstruct.entity = self;
    targetstruct.originalpos = self.origin;
    targetstruct.entitynumber = self getentitynumber();
    targetstruct.targetverticaloffset = ( 0, 0, getdvarfloat( @"hash_e08464464d929411", bundle.var_72e9f2058be2a9bd ) );
    targetstruct childthread ims_watchtargetdeath();
    return targetstruct;
}

// Namespace ims
// Params 0
// Checksum 0xe4d66199, Offset: 0x16e3
// Size: 0x61
function ims_watchtargetdeath()
{
    self endon( #"stop_watching" );
    
    if ( self.entity.classname == "script_vehicle" )
    {
        self.entity waittill( #"death" );
    }
    else
    {
        self.entity waittill( #"death_or_disconnect" );
    }
    
    self.entity = undefined;
}

// Namespace ims
// Params 0
// Checksum 0x4bab06b5, Offset: 0x174c
// Size: 0x48
function function_a88e45ccb3579780()
{
    if ( isdefined( self.entity ) )
    {
        targetorigin = self.entity.origin;
    }
    else
    {
        targetorigin = self.originalpos;
    }
    
    return targetorigin + self.targetverticaloffset;
}

// Namespace ims
// Params 3
// Checksum 0x8eeb1e06, Offset: 0x179d
// Size: 0xce
function function_1b599c61d5e6b9df( bundle, owner, targetstruct )
{
    level endon( #"game_ended" );
    self endon( #"explode" );
    
    while ( true )
    {
        owner waittill( #"grenade_thrown", throwngrenade );
        
        if ( throwngrenade == self )
        {
            break;
        }
    }
    
    maxdistancesquared = squared( getdvarfloat( @"hash_ce278dab5476cc61", bundle.var_8d74c32bb73ae5e0 ) );
    
    while ( true )
    {
        targetposition = targetstruct function_a88e45ccb3579780();
        distancesquared = distancesquared( self.origin, targetposition );
        
        if ( distancesquared <= maxdistancesquared )
        {
            break;
        }
        
        waitframe();
    }
    
    self detonate( owner );
}

// Namespace ims
// Params 3
// Checksum 0x86612c8, Offset: 0x1873
// Size: 0xa7
function ims_watchexplode( imsgrenade, targetstruct, chargeindex )
{
    level endon( #"game_ended" );
    self waittill( #"explode", org );
    
    if ( isdefined( imsgrenade ) )
    {
        imsgrenade.var_215d108ff35d2792 = arrayremove( imsgrenade.var_215d108ff35d2792, targetstruct.entitynumber );
        targetstruct notify( #"stop_watching" );
        
        /#
            if ( getdvarint( @"hash_9fbc814198194d10", 0 ) == 1 )
            {
                imsgrenade setscriptablepartstate( "<dev string:x24>" + chargeindex, "<dev string:x2c>" );
            }
        #/
    }
}

// Namespace ims
// Params 2
// Checksum 0xded45a0e, Offset: 0x1922
// Size: 0xa3
function ims_setactive( isactive, var_d6fa7af779ba27cd )
{
    if ( self.var_630d803dd7b94a73 == isactive )
    {
        return;
    }
    
    self.var_630d803dd7b94a73 = isactive;
    
    if ( isactive )
    {
        scriptablestate = "active";
    }
    else
    {
        scriptablestate = "inactive";
        
        if ( isdefined( var_d6fa7af779ba27cd ) && utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
        {
            var_d6fa7af779ba27cd thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( "disabled_ims" );
        }
    }
    
    self setscriptablepartstate( "main", scriptablestate, 1 );
}

// Namespace ims
// Params 1
// Checksum 0x296b8c46, Offset: 0x19cd
// Size: 0x1f
function ims_haywireapplied( data )
{
    ims_setactive( 0, data.attacker );
}

// Namespace ims
// Params 1
// Checksum 0xb33f49de, Offset: 0x19f4
// Size: 0x15
function function_16fe04641947376b( data )
{
    ims_setactive( 1 );
}

// Namespace ims
// Params 1
// Checksum 0x4124b236, Offset: 0x1a11
// Size: 0x1f
function ims_empapplied( data )
{
    ims_setactive( 0, data.attacker );
}

// Namespace ims
// Params 1
// Checksum 0xdb7077ae, Offset: 0x1a38
// Size: 0x15
function ims_empcleared( data )
{
    ims_setactive( 1 );
}

// Namespace ims
// Params 2
// Checksum 0xfcd3a333, Offset: 0x1a55
// Size: 0x88
function ims_onhacked( newowner, oldowner )
{
    killstreak_utility::function_7aef34478569525d( newowner, "tag_fx", &"killstreaks_hints/ims_use" );
    functionals_utility::clearminimapid();
    
    if ( utility::issharedfuncdefined( #"game", #"createobjective" ) )
    {
        self.minimapid = self [[ utility::getsharedfunc( #"game", #"createobjective" ) ]]( "hud_icon_minimap_killstreak_sentry", newowner.team, 1, 1, 1 );
    }
}

