// scripts\common\functionals_utility.gsc  (hash_608c50392df8c7d1.gscc) (size: 7016 Bytes / 0x1b68 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x53e26ee6 (1407348454)
// size ...... 7016 (0x1b68)
// includes .. 2   (offset: 0x1adc)
// strings ... 6   (offset: 0x1aec)
// dev strs .. 4   (offset: 0x1b38)
// exports ... 17  (offset: 0x12e8)
// cseg ...... 0xad + 0x123b (0x12e8)
// imports ... 41  (offset: 0x1590)
// animtree1 . 0   (offset: 0x1b68)
// animtree2 . 0   (offset: 0x1b68)
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace functionals_utility;

// Namespace functionals_utility
// Params 4
// Checksum 0x89c98135, Offset: 0xcb
// Size: 0x53
function function_581632a552d7d7d6( streakname, scorepopup, vodestroyed, destroyedsplash )
{
    self.streakname = streakname;
    self.scorepopup = scorepopup;
    self.vodestroyed = vodestroyed;
    self.destroyedsplash = destroyedsplash;
}

// Namespace functionals_utility
// Params 1
// Checksum 0x224a70dc, Offset: 0x126
// Size: 0x1c6
function functionals_handlefataldamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    meansofdeath = data.meansofdeath;
    damage = data.damage;
    owner = self.owner;
    notifyattacker = 0;
    
    if ( utility::issharedfuncdefined( #"damage", #"onkillstreakkilled" ) && isdefined( self.streakname ) )
    {
        notifyattacker = self [[ utility::getsharedfunc( #"damage", #"onkillstreakkilled" ) ]]( self.streakname, attacker, objweapon, meansofdeath, damage, self.scorepopup, self.vodestroyed, self.destroyedsplash );
    }
    else if ( utility::issharedfuncdefined( #"equipment", #"givescoreforequipment" ) && isdefined( self.equipmentref ) && isdefined( self.owner.team ) && isdefined( attacker.team ) && isenemyteam( self.owner.team, attacker.team ) )
    {
        attacker utility::callsharedfunc( #"equipment", #"givescoreforequipment", self, objweapon );
        notifyattacker = 1;
    }
    
    params = spawnstruct();
    params.meansofdeath = meansofdeath;
    params.owner = owner;
    callback::callback( #"on_functional_death", params );
}

// Namespace functionals_utility
// Params 1
// Checksum 0x300cc8f5, Offset: 0x2f4
// Size: 0xee
function functionals_handledamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    modifieddamage = damage;
    
    if ( !isdefined( self.weapon_object ) || !utility::callsharedfunc( #"killstreak", #"iskillstreakweapon", self.weapon_object ) )
    {
        modifieddamage = utility::handlemeleedamage( objweapon, type, modifieddamage );
    }
    
    if ( utility::issharedfuncdefined( #"damage", #"handleapdamage" ) )
    {
        modifieddamage = self [[ utility::getsharedfunc( #"damage", #"handleapdamage" ) ]]( objweapon, type, modifieddamage, attacker );
    }
    
    return modifieddamage;
}

// Namespace functionals_utility
// Params 4
// Checksum 0x7c0f1752, Offset: 0x3eb
// Size: 0x1d7
function function_b18fe3149bddace4( data, hitstokillenemyteam, hitstokillownerteam, meleehitcount )
{
    attacker = data.attacker;
    type = data.meansofdeath;
    damage = data.damage;
    
    if ( type == "MOD_IMPACT" )
    {
        return 0;
    }
    
    if ( !self.bundle.var_96ae49566ab6f362 )
    {
        return damage;
    }
    
    isenemydamage = 1;
    
    if ( isdefined( self.owner ) && utility::issharedfuncdefined( #"player", #"isenemy" ) )
    {
        isenemydamage = self.owner [[ utility::getsharedfunc( #"player", #"isenemy" ) ]]( attacker );
    }
    
    if ( isenemydamage )
    {
        hitstokill = hitstokillenemyteam;
    }
    else
    {
        hitstokill = hitstokillownerteam;
    }
    
    hits = undefined;
    
    if ( isexplosivedamagemod( type ) && self.bundle.explosivedamagetohits )
    {
        hits = functionals_explosivedamagetohits( data, isenemydamage );
    }
    else if ( utility::isbulletdamage( type ) && self.bundle.bulletdamagetohits )
    {
        hits = functionals_bulletdamagetohits( data, isenemydamage );
    }
    else if ( type == "MOD_MELEE" )
    {
        if ( meleehitcount < 0 )
        {
            return damage;
        }
        else if ( meleehitcount > 0 )
        {
            hits = meleehitcount;
        }
        else
        {
            hits = hitstokill;
        }
    }
    
    if ( isdefined( hits ) )
    {
        damage = int( ceil( min( 1, hits / hitstokill ) * self.maxhealth ) );
    }
    
    if ( isdefined( self.damagecallback ) )
    {
        [[ self.damagecallback ]]( damage );
    }
    
    return damage;
}

// Namespace functionals_utility
// Params 1
// Checksum 0x877a6cda, Offset: 0x5cb
// Size: 0x64
function function_cdfa6ea614436cc( data )
{
    assert( isdefined( self.bundle ), "<dev string:x24>" );
    return function_b18fe3149bddace4( data, self.bundle.hitstokillenemy, self.bundle.hitstokillowner, self.bundle.meleehitcount );
}

// Namespace functionals_utility
// Params 2, eflags: 0x4
// Checksum 0x74a4ddde, Offset: 0x638
// Size: 0xdb
function private functionals_bulletdamagetohits( data, isenemydamage )
{
    isfmjdamage = 0;
    
    if ( utility::issharedfuncdefined( #"damage", #"isfmjdamage" ) )
    {
        isfmjdamage = [[ utility::getsharedfunc( #"damage", #"isfmjdamage" ) ]]( data.objweapon, data.meansofdeath );
    }
    
    basehits = isfmjdamage && isenemydamage ? 2 : 0;
    
    if ( data.damage > 150 )
    {
        return ( basehits + 10 );
    }
    
    if ( data.damage >= 80 )
    {
        return ( basehits + 5 );
    }
    
    if ( data.damage >= 30 )
    {
        return ( basehits + 2 );
    }
    
    return basehits + 1;
}

// Namespace functionals_utility
// Params 2, eflags: 0x4
// Checksum 0x60710d1e, Offset: 0x71b
// Size: 0x5a
function private functionals_explosivedamagetohits( data, isenemydamage )
{
    if ( data.damage > 200 )
    {
        return 20;
    }
    
    if ( data.damage > 70 )
    {
        return 10;
    }
    
    if ( data.damage > 30 )
    {
        return 7;
    }
    
    return 2;
}

// Namespace functionals_utility
// Params 2
// Checksum 0x87374269, Offset: 0x77d
// Size: 0x1cc
function function_d858d002df0a2feb( maxrolldegrees, maxyawdiff )
{
    self notify( #"hash_c16b96ca7afc9282" );
    self endon( #"death" );
    level endon( #"game_ended" );
    self endon( #"hash_c16b96ca7afc9282" );
    var_b3b5221672606c23 = ( 1, 0, 0 );
    unityvector = ( 0, 1, 0 );
    var_8e7f7373961acda1 = ( 0, 0, -1 );
    waitframe();
    self.previousorigin = self.origin;
    self.targetangles = self.angles;
    
    while ( true )
    {
        stepvector = self.origin - self.previousorigin;
        stepunit = vectornormalize( stepvector );
        pitch = asin( vectordot( stepunit, var_8e7f7373961acda1 ) );
        stepunit = ( stepunit[ 0 ], stepunit[ 1 ], 0 );
        stepunit = vectornormalize( stepunit );
        yaw = acos( vectordot( stepunit, var_b3b5221672606c23 ) );
        
        if ( vectordot( stepunit, unityvector ) < 0 )
        {
            yaw = 360 - yaw;
        }
        
        yawdiff = yaw - self.targetangles[ 1 ];
        
        if ( abs( yawdiff ) > 300 )
        {
            yawdiff -= 360;
        }
        
        yawdiffclamped = clamp( yawdiff, maxyawdiff * -1, maxyawdiff );
        turnproportion = yawdiffclamped / maxyawdiff;
        roll = maxrolldegrees * turnproportion * -1;
        self.previousorigin = self.origin;
        newangles = ( pitch, yaw, roll );
        self.targetangles = newangles;
        wait 0.05;
    }
}

// Namespace functionals_utility
// Params 4
// Checksum 0xec6ef373, Offset: 0x951
// Size: 0x2d0
function function_3d1c0cb00ce4d44e( var_145553ccdeeee4fe, var_b2408d5d438efa81, var_22c1b97edc05d826, deathnotifyoverride = "death" )
{
    self notify( #"hash_666c3f1b28747bd4" );
    self endon( deathnotifyoverride );
    level endon( #"game_ended" );
    self endon( #"hash_666c3f1b28747bd4" );
    self.previousangles = self.angles;
    
    while ( true )
    {
        if ( isdefined( self.targetangles ) )
        {
            fixedtargetpitch = angleclamp( self.targetangles[ 0 ] );
            fixedcurrentpitch = angleclamp( self.angles[ 0 ] );
            fixedtargetyaw = angleclamp( self.targetangles[ 1 ] );
            fixedcurrentyaw = angleclamp( self.angles[ 1 ] );
            var_30ddd3838d59b50e = angleclamp( self.targetangles[ 2 ] );
            var_b979e0b993e4ba7a = angleclamp( self.angles[ 2 ] );
            pitcherror = fixedtargetpitch - fixedcurrentpitch;
            yawerror = fixedtargetyaw - fixedcurrentyaw;
            rollerror = var_30ddd3838d59b50e - var_b979e0b993e4ba7a;
            var_cbd944e4ba546d33 = fixedtargetpitch - fixedcurrentpitch + 360;
            var_a53258bb87f4a2d3 = fixedtargetpitch - fixedcurrentpitch - 360;
            
            if ( abs( var_cbd944e4ba546d33 ) < abs( pitcherror ) )
            {
                pitcherror = var_cbd944e4ba546d33;
            }
            else if ( abs( var_a53258bb87f4a2d3 ) < abs( pitcherror ) )
            {
                pitcherror = var_a53258bb87f4a2d3;
            }
            
            var_e552259be5fcf270 = fixedtargetyaw - fixedcurrentyaw + 360;
            var_266c985c48b44710 = fixedtargetyaw - fixedcurrentyaw - 360;
            
            if ( abs( var_e552259be5fcf270 ) < abs( yawerror ) )
            {
                yawerror = var_e552259be5fcf270;
            }
            else if ( abs( var_266c985c48b44710 ) < abs( yawerror ) )
            {
                yawerror = var_266c985c48b44710;
            }
            
            var_460b780b174cde4e = var_30ddd3838d59b50e - var_b979e0b993e4ba7a + 360;
            var_2f3bd518735af06e = var_30ddd3838d59b50e - var_b979e0b993e4ba7a - 360;
            
            if ( abs( var_460b780b174cde4e ) < abs( rollerror ) )
            {
                rollerror = var_460b780b174cde4e;
            }
            else if ( abs( var_2f3bd518735af06e ) < abs( rollerror ) )
            {
                rollerror = var_2f3bd518735af06e;
            }
            
            pitchstep = self.angles[ 0 ] + clamp( pitcherror, var_b2408d5d438efa81 * -1, var_b2408d5d438efa81 );
            yawstep = self.angles[ 1 ] + clamp( yawerror, var_145553ccdeeee4fe * -1, var_145553ccdeeee4fe );
            rollstep = self.angles[ 2 ] + clamp( rollerror, var_22c1b97edc05d826 * -1, var_22c1b97edc05d826 );
            newangles = ( pitchstep, yawstep, rollstep );
            self.angles = newangles;
            lastsign = utility::sign( yawerror );
        }
        
        wait 0.05;
    }
}

// Namespace functionals_utility
// Params 3
// Checksum 0x3cbc4b0, Offset: 0xc29
// Size: 0x6f
function function_f9c3bc385df6f245( streakinfo, var_ad0f40629b254731, destroyfunc )
{
    params = spawnstruct();
    params.streakinfo = streakinfo;
    params.var_ad0f40629b254731 = var_ad0f40629b254731;
    params.destroyfunc = destroyfunc;
    callback::add( #"on_functional_death", &onfunctionaldeath, params );
}

// Namespace functionals_utility
// Params 2
// Checksum 0xf687e2f3, Offset: 0xca0
// Size: 0xd3
function onfunctionaldeath( callbackparams, initparams )
{
    streakinfo = initparams.streakinfo;
    var_ad0f40629b254731 = initparams.var_ad0f40629b254731;
    destroyfunc = initparams.destroyfunc;
    self endon( #"iscarried" );
    
    if ( soundexists( "mp_equip_destroyed" ) )
    {
        self playsound( "mp_equip_destroyed" );
    }
    
    if ( isdefined( streakinfo ) )
    {
        level callback::callback( #"killstreak_finish_use", { #streakinfo:streakinfo } );
    }
    
    if ( isdefined( var_ad0f40629b254731 ) )
    {
        self [[ var_ad0f40629b254731 ]]( callbackparams );
    }
    
    clearminimapid();
    wait 0.2;
    
    if ( isdefined( destroyfunc ) )
    {
        self [[ destroyfunc ]]( callbackparams );
        return;
    }
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace functionals_utility
// Params 0
// Checksum 0x83397c70, Offset: 0xd7b
// Size: 0x58
function clearminimapid()
{
    if ( isdefined( self.minimapid ) )
    {
        if ( utility::issharedfuncdefined( #"game", #"returnobjectiveid" ) )
        {
            [[ utility::getsharedfunc( #"game", #"returnobjectiveid" ) ]]( self.minimapid );
        }
        
        self.minimapid = undefined;
    }
}

// Namespace functionals_utility
// Params 4
// Checksum 0x6e4f74a4, Offset: 0xddb
// Size: 0x160
function functionals_timeout( maxlifetime, debugactivedvar, var_2793f960eabef222, var_cb5ce51605099b97 )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    self endon( #"iscarried" );
    
    if ( !isdefined( self.lifetime ) )
    {
        self.lifetime = maxlifetime * 1000;
    }
    
    previoustime = gettime();
    
    while ( self.lifetime > 0 )
    {
        currenttime = gettime();
        timeelapsed = currenttime - previoustime;
        self.lifetime -= timeelapsed;
        previoustime = currenttime;
        
        /#
            debugactive = getdvarint( debugactivedvar );
            
            if ( debugactive > 0 )
            {
                var_61859b3d965d558b = self.weapon_name ?? "<dev string:x5d>";
                print3d( self.origin, var_61859b3d965d558b + "<dev string:x5e>" + self.lifetime + "<dev string:x6a>", ( 0, 0, 1 ), 1, 0.5, 1 );
            }
        #/
        
        waitframe();
    }
    
    if ( isdefined( var_2793f960eabef222 ) )
    {
        self [[ var_2793f960eabef222 ]]( var_cb5ce51605099b97 );
    }
    
    callback::callback( #"on_functional_death" );
}

// Namespace functionals_utility
// Params 2
// Checksum 0x9dcab9f7, Offset: 0xf43
// Size: 0xa6
function function_ea25547f2b63eaae( direction, velocity )
{
    self endon( #"death" );
    self endon( #"timeout" );
    level endon( #"game_ended" );
    self.owner endon( #"disconnect" );
    newposition = self.origin;
    previoustime = gettime();
    
    while ( true )
    {
        deltatime = gettime() - previoustime;
        previoustime = gettime();
        newposition += direction * velocity * deltatime;
        self.origin = newposition;
        waitframe();
    }
}

// Namespace functionals_utility
// Params 4
// Checksum 0xb3a9594f, Offset: 0xff1
// Size: 0x186
function function_763e09170b227f3( newowner, challengeeventid, outlineasset, onhackedcallback )
{
    self.ishacked = 1;
    oldowner = self.owner;
    self.owner = newowner;
    self.team = newowner.team;
    self setentityowner( newowner );
    self setotherent( newowner );
    
    if ( level.teambased )
    {
        self filteroutplayermarks( newowner.team );
    }
    else
    {
        self filteroutplayermarks( newowner );
    }
    
    if ( utility::issharedfuncdefined( #"challenges", #"onhack" ) )
    {
        newowner [[ utility::getsharedfunc( #"challenges", #"onhack" ) ]]( challengeeventid );
    }
    
    if ( utility::issharedfuncdefined( #"killstreak", #"givescoreforhack" ) )
    {
        newowner [[ utility::getsharedfunc( #"killstreak", #"givescoreforhack" ) ]]();
    }
    
    if ( isdefined( outlineasset ) && utility::issharedfuncdefined( #"outline", #"outlineenableforplayer" ) )
    {
        if ( isdefined( self.streakname ) )
        {
            priority = "killstreak";
        }
        else
        {
            priority = "equipment";
        }
        
        [[ utility::getsharedfunc( #"outline", #"outlineenableforplayer" ) ]]( self, newowner, outlineasset, priority );
    }
    
    if ( isdefined( onhackedcallback ) )
    {
        self [[ onhackedcallback ]]( newowner, oldowner );
    }
}

/#

    // Namespace functionals_utility
    // Params 3
    // Checksum 0xeda64aee, Offset: 0x117f
    // Size: 0x169, Type: dev
    function function_3fd21b027afc9a0e( aabbmin, aabbmax, duration )
    {
        self notify( #"hash_9e5b01133d526474" );
        level endon( #"game_ended" );
        self endon( #"death" );
        self endon( #"hash_9e5b01133d526474" );
        drawcolor = ( 0, 255, 0 );
        var_a5ccc18b2dcf3501 = ( aabbmax[ 0 ] - aabbmin[ 0 ], 0, 0 );
        var_dfbdac49197a14fa = ( 0, aabbmax[ 1 ] - aabbmin[ 1 ], 0 );
        var_1a919c03f8b2c732 = ( 0, 0, aabbmax[ 2 ] - aabbmin[ 2 ] );
        line( aabbmin, aabbmin + ( aabbmax - aabbmin ) / 2, drawcolor, 1, 0, duration );
        line( aabbmin, aabbmin + var_a5ccc18b2dcf3501, drawcolor, 1, 0, duration );
        line( aabbmin, aabbmin + var_dfbdac49197a14fa, drawcolor, 1, 0, duration );
        line( aabbmin, aabbmin + var_1a919c03f8b2c732, drawcolor, 1, 0, duration );
        sphere( aabbmin, 5, drawcolor, 0, duration );
        drawcolor = ( 255, 0, 0 );
        line( aabbmax, aabbmax + ( aabbmin - aabbmax ) / 2, drawcolor, 1, 0, duration );
        line( aabbmax, aabbmax - var_a5ccc18b2dcf3501, drawcolor, 1, 0, duration );
        line( aabbmax, aabbmax - var_dfbdac49197a14fa, drawcolor, 1, 0, duration );
        line( aabbmax, aabbmax - var_1a919c03f8b2c732, drawcolor, 1, 0, duration );
        sphere( aabbmax, 5, drawcolor, 0, duration );
    }

#/
