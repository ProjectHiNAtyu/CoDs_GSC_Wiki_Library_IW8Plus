// scripts\mp\common\equipment\binoculars.gsc  (hash_621bdb6c178a59ad.gscc) (size: 20964 Bytes / 0x51e4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x331fb9f9 (857717241)
// size ...... 20964 (0x51e4)
// includes .. 16  (offset: 0x4f88)
// strings ... 29  (offset: 0x5008)
// dev strs .. 1   (offset: 0x51d8)
// exports ... 77  (offset: 0x306c)
// cseg ...... 0x2f0 + 0x2d7c (0x306c)
// imports ... 151 (offset: 0x3c74)
// animtree1 . 0   (offset: 0x51e4)
// animtree2 . 0   (offset: 0x51e4)
#using scripts\common\ae_utility;
#using scripts\common\math;
#using scripts\common\targetmarkergroups;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\entityheadicons;
#using scripts\mp\equipment;
#using scripts\mp\playerlogic;
#using scripts\mp\weapons;

#namespace binoculars;

// Namespace binoculars
// Params 0, eflags: 0x1
// Checksum 0xb0b3c390, Offset: 0x30e
// Size: 0xae
function autoexec binoculars_init()
{
    utility::flag_wait( "equipment_initialized" );
    
    if ( isdefined( level.binocularsinited ) )
    {
        return;
    }
    
    level.var_90bda78bb1519a49 = 65538;
    level.binocularsinited = 1;
    weapons::registerusedcallback( "offhand_spotter_scope", &binoculars_used );
    equipment_mp::registercallback( "equip_binoculars", "onGive", &binoculars_ongive );
    equipment_mp::registercallback( "equip_binoculars", "onTake", &binoculars_ontake );
    utility::registersharedfunc( #"binoculars", #"hash_6d5fabf2416b62ba", &function_680ead3de34a942 );
    utility::registersharedfunc( #"binoculars", #"hash_87e0ce2b2de1b457", &binoculars_giveassistpoints );
}

// Namespace binoculars
// Params 3
// Checksum 0x6ece891c, Offset: 0x3c4
// Size: 0x6a
function binoculars_onstateupdatefunc( stateindex, targetent, cansee )
{
    switch ( stateindex )
    {
        case 0:
            return binoculars_onstateinvalidupdate( targetent, cansee );
        case 2:
            return binoculars_onstateunmarkedupdate( targetent, cansee );
        case 4:
            return binoculars_onstatemarkpendingupdate( targetent, cansee );
    }
}

// Namespace binoculars
// Params 2
// Checksum 0xbd7327e2, Offset: 0x436
// Size: 0x77
function binoculars_onstateenterfunc( stateindex, targetent )
{
    switch ( stateindex )
    {
        case 0:
            binoculars_onstateinvalidenter( targetent );
            return;
        case 2:
            binoculars_onstateunmarkedenter( targetent );
            return;
        case 4:
            binoculars_onstatemarkpendingenter( targetent );
            return;
        case 5:
            binoculars_onstatemarkedenter( targetent );
            return;
    }
}

// Namespace binoculars
// Params 2
// Checksum 0x90f51ad, Offset: 0x4b5
// Size: 0x4b
function binoculars_onstateexitfunc( stateindex, targetent )
{
    switch ( stateindex )
    {
        case 4:
            binoculars_onstatemarkpendingexit( targetent );
            return;
        case 5:
            binoculars_onstatemarkedexit( targetent );
            return;
    }
}

// Namespace binoculars
// Params 4
// Checksum 0x20fe6dcc, Offset: 0x508
// Size: 0x57
function binoculars_ongive( equipmentref, equipmentslot, variantid, attachments )
{
    if ( equipmentref != "equip_binoculars" || getdvarint( @"hash_8bcd5b94785fa58b", 1 ) != 1 )
    {
        return;
    }
    
    binoculars_init();
    thread binoculars_watchforads();
}

// Namespace binoculars
// Params 2
// Checksum 0x1bc6c764, Offset: 0x567
// Size: 0x2d
function binoculars_ontake( equipmentref, equipmentslot )
{
    if ( equipmentref != "equip_binoculars" )
    {
        return;
    }
    
    self notify( #"binoculars_take" );
}

// Namespace binoculars
// Params 1
// Checksum 0x1c8729af, Offset: 0x59c
// Size: 0x1a
function binoculars_used( grenade )
{
    waitframe();
    
    if ( isdefined( grenade ) )
    {
        grenade delete();
    }
}

// Namespace binoculars
// Params 0
// Checksum 0xabc31a52, Offset: 0x5be
// Size: 0x1c2
function binoculars_watchforads()
{
    self endon( #"disconnect" );
    self notify( #"hash_c6703b2eaf288df0" );
    self endon( #"hash_c6703b2eaf288df0" );
    isads = 0;
    
    while ( true )
    {
        raceresult = spawnstruct();
        childthread binoculars_watchracedeath( raceresult );
        childthread binoculars_watchracelaststand( raceresult );
        childthread function_1c3674bd1ea014f8( raceresult );
        childthread binoculars_watchracetake( raceresult );
        childthread binoculars_watchraceadson( raceresult );
        childthread binoculars_watchraceadsoff( raceresult );
        childthread function_6fc6242a252cdbb3( raceresult );
        childthread function_380f971e358aaf6d( raceresult );
        childthread function_8fafede559c06e20( raceresult );
        childthread function_9b055008d996de9b( raceresult );
        self waittill( #"hash_65150474072cdc4e" );
        waittillframeend();
        death = istrue( raceresult.death );
        take = istrue( raceresult.take );
        adsoff = raceresult.adsoff || raceresult.laststand || raceresult.enteredvehicle || raceresult.ishaywire || raceresult.iscoughing || raceresult.detonateequipment || raceresult.invalidweapon;
        adson = !adsoff && raceresult.adson;
        
        if ( death || take )
        {
            self notify( #"hash_58316adf65ea293b" );
            binoculars_endadslogic();
            return;
        }
        
        if ( adson && !isads )
        {
            isads = 1;
            thread binoculars_runadslogic();
        }
        else if ( adsoff && isads )
        {
            isads = 0;
            binoculars_endadslogic();
        }
        
        self notify( #"hash_58316adf65ea293b" );
    }
}

// Namespace binoculars
// Params 1
// Checksum 0xd5624e8a, Offset: 0x788
// Size: 0x3f
function binoculars_watchracedeath( raceresult )
{
    self endon( #"hash_58316adf65ea293b" );
    self waittill( #"death" );
    raceresult.death = 1;
    self notify( #"hash_65150474072cdc4e" );
}

// Namespace binoculars
// Params 1
// Checksum 0xa6e1e726, Offset: 0x7cf
// Size: 0x3f
function binoculars_watchracelaststand( raceresult )
{
    self endon( #"hash_58316adf65ea293b" );
    self waittill( #"last_stand_enter" );
    raceresult.laststand = 1;
    self notify( #"hash_65150474072cdc4e" );
}

// Namespace binoculars
// Params 1
// Checksum 0x28c5fd95, Offset: 0x816
// Size: 0x43
function function_1c3674bd1ea014f8( raceresult )
{
    self endon( #"hash_58316adf65ea293b" );
    utility::waittill_any( "vehicle_enter", "vehicle_change_seat" );
    raceresult.enteredvehicle = 1;
    self notify( #"hash_65150474072cdc4e" );
}

// Namespace binoculars
// Params 1
// Checksum 0xc7e9d80a, Offset: 0x861
// Size: 0x3f
function binoculars_watchracetake( raceresult )
{
    self endon( #"hash_58316adf65ea293b" );
    self waittill( #"binoculars_take" );
    raceresult.take = 1;
    self notify( #"hash_65150474072cdc4e" );
}

// Namespace binoculars
// Params 1
// Checksum 0x31d773cc, Offset: 0x8a8
// Size: 0x74
function binoculars_watchraceadson( raceresult )
{
    self endon( #"hash_58316adf65ea293b" );
    
    while ( true )
    {
        self waittill( #"offhand_ads_on", weapon );
        
        if ( !self.disguisetransition )
        {
            if ( equipment_mp::getequipmentreffromweapon( weapon ) == "equip_binoculars" )
            {
                break;
            }
        }
    }
    
    raceresult.adson = 1;
    self notify( #"hash_65150474072cdc4e" );
}

// Namespace binoculars
// Params 1
// Checksum 0x54fd5e5e, Offset: 0x924
// Size: 0x67
function binoculars_watchraceadsoff( raceresult )
{
    self endon( #"hash_58316adf65ea293b" );
    
    while ( true )
    {
        self waittill( #"offhand_ads_off", weapon );
        
        if ( equipment_mp::getequipmentreffromweapon( weapon ) == "equip_binoculars" )
        {
            break;
        }
    }
    
    raceresult.adsoff = 1;
    self notify( #"hash_65150474072cdc4e" );
}

// Namespace binoculars
// Params 1
// Checksum 0x2c3fa1a5, Offset: 0x993
// Size: 0x4a
function function_6fc6242a252cdbb3( raceresult )
{
    self endon( #"hash_58316adf65ea293b" );
    
    while ( true )
    {
        self waittill( #"player_ishaywire" );
        break;
    }
    
    raceresult.ishaywire = 1;
    self notify( #"hash_65150474072cdc4e" );
}

// Namespace binoculars
// Params 1
// Checksum 0xcd33dd1f, Offset: 0x9e5
// Size: 0x4a
function function_380f971e358aaf6d( raceresult )
{
    self endon( #"hash_58316adf65ea293b" );
    
    while ( true )
    {
        self waittill( #"gas_begin_coughing" );
        break;
    }
    
    raceresult.iscoughing = 1;
    self notify( #"hash_65150474072cdc4e" );
}

// Namespace binoculars
// Params 1
// Checksum 0x8761c8ca, Offset: 0xa37
// Size: 0x3f
function function_8fafede559c06e20( raceresult )
{
    self endon( #"hash_58316adf65ea293b" );
    self waittill( #"detonate" );
    raceresult.detonateequipment = 1;
    self notify( #"hash_65150474072cdc4e" );
}

// Namespace binoculars
// Params 1
// Checksum 0x7719d709, Offset: 0xa7e
// Size: 0x3f
function function_9b055008d996de9b( raceresult )
{
    self endon( #"hash_58316adf65ea293b" );
    self waittill( #"hash_a9bebaec20123098" );
    raceresult.invalidweapon = 1;
    self notify( #"hash_65150474072cdc4e" );
}

// Namespace binoculars
// Params 0
// Checksum 0x2a51bafa, Offset: 0xac5
// Size: 0x140
function binoculars_endadslogic()
{
    self notify( #"binoculars_ads_off" );
    val::reset_all( "binoculars_ads" );
    
    if ( isdefined( self.binocularsstruct ) )
    {
        self.binocularsstruct.adson = undefined;
        self.binocularsstruct.var_49b6c0b460f83b73 = undefined;
        
        if ( isdefined( self.binocularsstruct.targetmarkergroup ) )
        {
            targetmarkergroups::targetmarkergroup_off( self.binocularsstruct.targetmarkergroup );
            self.binocularsstruct.targetmarkergroup = undefined;
        }
        
        binoculars_clearuidata();
        
        foreach ( targetdata in self.binocularsstruct.targetdata )
        {
            if ( !isdefined( targetdata ) )
            {
                continue;
            }
            
            targetdata.hastargetmarker = undefined;
            
            if ( isdefined( targetdata.headicon ) )
            {
                binoculars_updateheadiconvisibilityforplayer( targetdata, self );
            }
        }
    }
}

// Namespace binoculars
// Params 0
// Checksum 0x839b6aa2, Offset: 0xc0d
// Size: 0xca
function binoculars_runadslogic()
{
    self endon( #"disconnect" );
    self endon( #"binoculars_ads_off" );
    self notify( #"binoculars_ads_on" );
    val::set( "binoculars_ads", "usability", 0 );
    thread function_9d61ef62cb50fd00();
    
    if ( !isdefined( self.binocularsstruct ) )
    {
        self.binocularsstruct = spawnstruct();
        self.binocularsstruct.targetdata = [];
        self.binocularsstruct.var_49b6c0b460f83b73 = 0;
    }
    
    self.binocularsstruct.adson = 1;
    self.binocularsstruct.targetmarkergroup = targetmarkergroups::targetmarkergroup_on( %"overlaytargetmarkerenemy", self, undefined, self, 0, 0, 0 );
    thread binoculars_processtargetdata();
}

// Namespace binoculars
// Params 0
// Checksum 0xc0314efe, Offset: 0xcdf
// Size: 0x6b
function function_9d61ef62cb50fd00()
{
    self endon( #"disconnect" );
    self endon( #"binoculars_ads_off" );
    
    while ( true )
    {
        currentoffhand = self getheldoffhand();
        
        if ( isnullweapon( currentoffhand ) || isdefined( currentoffhand ) && equipment_mp::getequipmentreffromweapon( currentoffhand ) != "equip_binoculars" )
        {
            break;
        }
        
        waitframe();
    }
    
    wait 0.05;
    self notify( #"hash_a9bebaec20123098" );
}

// Namespace binoculars
// Params 0
// Checksum 0xb177035f, Offset: 0xd52
// Size: 0x23, Type: bool
function binoculars_isads()
{
    return isdefined( self.binocularsstruct ) && self.binocularsstruct.adson;
}

// Namespace binoculars
// Params 0
// Checksum 0x73649f2d, Offset: 0xd7e
// Size: 0x47e
function binoculars_processtargetdata()
{
    if ( self.binocularsstruct.var_e14d7274b5d9eb20 )
    {
        return;
    }
    
    self.binocularsstruct.var_e14d7274b5d9eb20 = 1;
    self endon( #"disconnect" );
    
    while ( true )
    {
        currenttarget = undefined;
        seentargets = [];
        
        while ( true )
        {
            function_ca922bc0c1b0f503();
            
            if ( binoculars_isads() )
            {
                targetarray = sortbydistance( self function_906f4c75be23ff6c( self.binocularsstruct.maxrange, binoculars_getfov(), level.var_90bda78bb1519a49, 0 ), self.origin );
                var_108b183666187782 = [];
                
                foreach ( targetent in targetarray )
                {
                    targetnum = targetent getentitynumber();
                    curstate = binoculars_getcurrentstate( targetnum );
                    targetdata = self.binocularsstruct.targetdata[ targetnum ];
                    
                    if ( isdefined( targetdata ) )
                    {
                        function_2185c8239cf16d12( targetent );
                    }
                    
                    if ( isdefined( currenttarget ) )
                    {
                        continue;
                    }
                    
                    if ( curstate == 5 )
                    {
                        continue;
                    }
                    
                    newstate = binoculars_onstateupdatefunc( curstate, targetent, 1 );
                    var_108b183666187782[ targetnum ] = 1;
                    seentargets[ targetnum ] = targetent;
                    
                    if ( newstate != curstate )
                    {
                        binoculars_onstateexitfunc( curstate, targetent );
                        binoculars_onstateenterfunc( newstate, targetent );
                        
                        if ( newstate == 4 )
                        {
                            currenttarget = targetent;
                        }
                    }
                }
                
                foreach ( targetent in seentargets )
                {
                    if ( !isdefined( targetent ) )
                    {
                        continue;
                    }
                    
                    targetnum = targetent getentitynumber();
                    
                    if ( !isdefined( var_108b183666187782[ targetnum ] ) )
                    {
                        seentargets[ targetnum ] = undefined;
                        curstate = binoculars_getcurrentstate( targetnum );
                        newstate = binoculars_onstateupdatefunc( curstate, targetent, 0 );
                        
                        if ( newstate != curstate )
                        {
                            binoculars_onstateexitfunc( curstate, targetent );
                            binoculars_onstateenterfunc( newstate, targetent );
                        }
                    }
                }
                
                if ( isdefined( currenttarget ) )
                {
                    break;
                }
                
                binoculars_updateuidata();
            }
            else if ( !isdefined( self.markedents ) )
            {
                self.binocularsstruct = undefined;
                return;
            }
            
            waitframe();
        }
        
        waitframe();
        
        if ( binoculars_isads() )
        {
            foreach ( targetent in seentargets )
            {
                if ( !isdefined( targetent ) )
                {
                    continue;
                }
                
                if ( targetent == currenttarget )
                {
                    continue;
                }
                
                curstate = binoculars_getcurrentstate( targetent getentitynumber() );
                newstate = binoculars_onstateupdatefunc( curstate, targetent, 0 );
                
                if ( newstate != curstate )
                {
                    binoculars_onstateexitfunc( curstate, targetent );
                    binoculars_onstateenterfunc( newstate, targetent );
                }
            }
        }
        
        if ( !isdefined( currenttarget ) )
        {
            waitframe();
            continue;
        }
        
        lastseentime = gettime();
        cansee = 1;
        currenttargetnumber = currenttarget getentitynumber();
        
        while ( true )
        {
            function_ca922bc0c1b0f503();
            
            if ( binoculars_isads() )
            {
                if ( !isdefined( currenttarget ) )
                {
                    waitframe();
                    break;
                }
                
                curstate = binoculars_getcurrentstate( currenttargetnumber );
                
                if ( gettime() - lastseentime > 100 )
                {
                    lastseentime = gettime();
                    cansee = function_edce4a6e5038b484( currenttarget );
                }
                
                newstate = binoculars_onstateupdatefunc( curstate, currenttarget, cansee );
                
                if ( newstate != curstate )
                {
                    binoculars_onstateexitfunc( curstate, currenttarget );
                    binoculars_onstateenterfunc( newstate, currenttarget );
                    
                    if ( newstate == 0 || newstate == 2 )
                    {
                        waitframe();
                        break;
                    }
                    else if ( newstate == 5 )
                    {
                        if ( !isdefined( self.markedents ) )
                        {
                            self.markedents = [];
                        }
                        
                        self.markedents[ currenttarget getentitynumber() ] = currenttarget;
                        thread binoculars_updatemarkedents();
                        waitframe();
                        break;
                    }
                }
                
                binoculars_updateuidata();
            }
            else if ( !isdefined( self.markedents ) )
            {
                self.binocularsstruct = undefined;
                return;
            }
            
            waitframe();
        }
    }
}

// Namespace binoculars
// Params 1
// Checksum 0x7bf6028a, Offset: 0x1204
// Size: 0x41
function binoculars_getcurrentstate( targetnum )
{
    targetdata = self.binocularsstruct.targetdata[ targetnum ];
    
    if ( isdefined( targetdata ) )
    {
        return targetdata.state;
    }
    
    return 0;
}

// Namespace binoculars
// Params 0
// Checksum 0xbb0a1f4f, Offset: 0x124e
// Size: 0xea
function function_ca922bc0c1b0f503()
{
    projectiondistance = getdvarfloat( @"hash_90d4dd93f932de3f", 72 );
    self.binocularsstruct.maxrange = binoculars_getmaxrange();
    self.binocularsstruct.maxrangesq = self.binocularsstruct.maxrange * self.binocularsstruct.maxrange;
    self.binocularsstruct.cosfov = cos( binoculars_getfov() );
    self.binocularsstruct.projdistsq = projectiondistance * projectiondistance;
    self.binocularsstruct.markingtarget = 0;
    self.binocularsstruct.markingcoldblooded = 0;
    self.binocularsstruct.markingendtime = 0;
}

// Namespace binoculars
// Params 0
// Checksum 0xecfcdfef, Offset: 0x1340
// Size: 0x140
function binoculars_updatemarkedents()
{
    self endon( #"disconnect" );
    self notify( #"binoculars_updatemarkedents" );
    self endon( #"binoculars_updatemarkedents" );
    
    while ( self.markedents.size > 0 )
    {
        waitframe();
        
        foreach ( entnum, targetent in self.markedents )
        {
            if ( !isdefined( targetent ) )
            {
                self.markedents[ entnum ] = undefined;
                continue;
            }
            
            curstate = 0;
            targetdata = self.binocularsstruct.targetdata[ entnum ];
            
            if ( isdefined( targetdata ) )
            {
                curstate = targetdata.state;
            }
            
            newstate = binoculars_onstatemarkedupdate( targetent );
            
            if ( newstate != curstate )
            {
                binoculars_onstateexitfunc( curstate, targetent );
                binoculars_onstateenterfunc( newstate, targetent );
                self.markedents[ entnum ] = undefined;
            }
        }
    }
    
    self.markedents = undefined;
}

// Namespace binoculars
// Params 1
// Checksum 0xa0dcaf45, Offset: 0x1488
// Size: 0x1f2, Type: bool
function function_edce4a6e5038b484( targetent )
{
    contents = trace::create_contents( 0, 1, 0, 1, 1, 1, 0, 1 );
    tracepoints = [ targetent.origin ];
    
    if ( isplayer( targetent ) )
    {
        headpos = targetent utility::function_f02ebab438642e16();
        centerpos = targetent utility::function_68061c3d21a6d57a();
        tracepoints = [ headpos, centerpos, targetent.origin ];
    }
    else if ( isagent( targetent ) )
    {
        tracepoints = [ targetent.origin + ( 0, 0, 48 ) ];
    }
    
    ignorelist = [ self, targetent ];
    vehicle = targetent vehicle::get_vehicle();
    
    if ( isdefined( vehicle ) )
    {
        ignorelist[ ignorelist.size ] = vehicle;
        vehiclechildren = vehicle getlinkedchildren( 1 );
        
        foreach ( child in vehiclechildren )
        {
            ignorelist[ ignorelist.size ] = child;
        }
    }
    
    foreach ( point in tracepoints )
    {
        if ( !trace::ray_trace_passed( self getvieworigin(), point, ignorelist, contents ) )
        {
            continue;
        }
        
        return true;
    }
    
    return false;
}

// Namespace binoculars
// Params 1
// Checksum 0x4dc93bf7, Offset: 0x1683
// Size: 0x5b
function function_2185c8239cf16d12( targetent )
{
    targetdata = self.binocularsstruct.targetdata[ targetent getentitynumber() ];
    assert( isdefined( targetdata ) );
    targetdata.loschecktime = gettime();
    targetdata.loscheckpassed = 1;
}

// Namespace binoculars
// Params 1
// Checksum 0x8bfa5310, Offset: 0x16e6
// Size: 0x73, Type: bool
function binoculars_cansee( targetent )
{
    targetdata = self.binocularsstruct.targetdata[ targetent getentitynumber() ];
    assert( isdefined( targetdata ) );
    
    if ( !isdefined( targetdata.loschecktime ) || gettime() - targetdata.loschecktime > 1000 )
    {
        return false;
    }
    
    return istrue( targetdata.loscheckpassed );
}

// Namespace binoculars
// Params 2
// Checksum 0x8d10546f, Offset: 0x1762
// Size: 0x7b
function binoculars_setcurrentstate( targetent, newstate )
{
    targetdata = self.binocularsstruct.targetdata[ targetent getentitynumber() ];
    
    if ( !isdefined( targetdata ) )
    {
        if ( newstate == 0 )
        {
            return;
        }
        
        targetdata = spawnstruct();
        self.binocularsstruct.targetdata[ targetent getentitynumber() ] = targetdata;
    }
    
    targetdata.state = newstate;
}

// Namespace binoculars
// Params 1
// Checksum 0xde43e7e0, Offset: 0x17e5
// Size: 0x28, Type: bool
function binoculars_hascoldblooded( targetent )
{
    return isplayer( targetent ) && isdefined( targetent.perks[ "specialty_noscopeoutline" ] );
}

// Namespace binoculars
// Params 2
// Checksum 0x8db041a1, Offset: 0x1816
// Size: 0xc8
function binoculars_showtargetmarker( targetent, ismarked )
{
    targetdata = self.binocularsstruct.targetdata[ targetent getentitynumber() ];
    
    if ( isdefined( targetdata ) )
    {
        targetdata.hastargetmarker = 1;
    }
    
    if ( !isdefined( self.binocularsstruct.targetmarkergroup ) )
    {
        return;
    }
    
    targetmarkergroups::targetmarkergroup_markentity( targetent, self.binocularsstruct.targetmarkergroup, 0 );
    hascoldblooded = binoculars_hascoldblooded( targetent );
    
    if ( hascoldblooded )
    {
        binoculars_settargetmarkerstate( targetent, 3 );
        return;
    }
    
    if ( ismarked )
    {
        binoculars_settargetmarkerstate( targetent, 2 );
        return;
    }
    
    binoculars_settargetmarkerstate( targetent, 1 );
}

// Namespace binoculars
// Params 2
// Checksum 0xced14bb7, Offset: 0x18e6
// Size: 0x73
function binoculars_updatetargetmarker( targetent, ismarked )
{
    if ( !isdefined( self.binocularsstruct.targetmarkergroup ) )
    {
        return;
    }
    
    hascoldblooded = binoculars_hascoldblooded( targetent );
    
    if ( hascoldblooded )
    {
        binoculars_settargetmarkerstate( targetent, 3 );
        return;
    }
    
    if ( ismarked )
    {
        binoculars_settargetmarkerstate( targetent, 2 );
        return;
    }
    
    binoculars_settargetmarkerstate( targetent, 1 );
}

// Namespace binoculars
// Params 1
// Checksum 0x4165caa5, Offset: 0x1961
// Size: 0x78
function binoculars_hidetargetmarker( targetent )
{
    targetdata = self.binocularsstruct.targetdata[ targetent getentitynumber() ];
    
    if ( isdefined( targetdata ) )
    {
        targetdata.hastargetmarker = undefined;
    }
    
    if ( !isdefined( self.binocularsstruct.targetmarkergroup ) )
    {
        return;
    }
    
    targetmarkergroups::targetmarkergroup_unmarkentity( targetent, self.binocularsstruct.targetmarkergroup );
}

// Namespace binoculars
// Params 2
// Checksum 0x7d1a899d, Offset: 0x19e1
// Size: 0x8f
function binoculars_settargetmarkerstate( targetent, state )
{
    if ( !isdefined( self.binocularsstruct.targetmarkergroup ) )
    {
        return;
    }
    
    firstbit = ( state >> 0 ) % 2 == 1;
    secondbit = ( state >> 1 ) % 2 == 1;
    targetmarkergroupsetentitystate( self.binocularsstruct.targetmarkergroup, targetent, firstbit );
    targetmarkergroupsetextrastate( self.binocularsstruct.targetmarkergroup, targetent, secondbit );
}

// Namespace binoculars
// Params 1
// Checksum 0xcbb409f8, Offset: 0x1a78
// Size: 0xb6
function binoculars_addheadicon( targetent )
{
    markicon = "hud_icon_new_marked";
    
    if ( entityheadicons::function_aeb3fc6af7792562() )
    {
        markicon = "hud_icon_head_marked";
    }
    
    var_f973a055a629002d = 8;
    drawthroughgeo = 1;
    maxdrawdist = 0;
    naturaldist = 500;
    targetdata = self.binocularsstruct.targetdata[ targetent getentitynumber() ];
    assert( isdefined( targetdata ) );
    targetdata.headicon = targetent entityheadicons::setheadicon_singleimage( [], markicon, var_f973a055a629002d, drawthroughgeo, maxdrawdist, naturaldist, undefined, 1, 1 );
    thread binoculars_cleanupheadiconondisconnect( targetent );
}

// Namespace binoculars
// Params 1
// Checksum 0xefabc417, Offset: 0x1b36
// Size: 0xd8
function binoculars_updateheadiconvisibility( targetent )
{
    targetdata = self.binocularsstruct.targetdata[ targetent getentitynumber() ];
    
    if ( !( isdefined( targetdata ) && isdefined( targetdata.headicon ) ) )
    {
        return;
    }
    
    players = teams::getteamdata( self.team, "players" );
    
    foreach ( player in players )
    {
        binoculars_updateheadiconvisibilityforplayer( targetdata, player );
    }
}

// Namespace binoculars
// Params 2
// Checksum 0xc6926e84, Offset: 0x1c16
// Size: 0x95
function binoculars_updateheadiconvisibilityforplayer( targetdata, player )
{
    assert( isdefined( targetdata ) );
    assert( isdefined( targetdata.headicon ) );
    shouldshow = 1;
    
    if ( player == self && binoculars_isads() && targetdata.hastargetmarker )
    {
        shouldshow = 0;
    }
    
    if ( shouldshow )
    {
        entityheadicons::setheadicon_addclienttomask( targetdata.headicon, player );
        return;
    }
    
    entityheadicons::setheadicon_removeclientfrommask( targetdata.headicon, player );
}

// Namespace binoculars
// Params 1
// Checksum 0xf2109752, Offset: 0x1cb3
// Size: 0xae
function binoculars_cleanupheadiconondisconnect( targetent )
{
    entnum = targetent getentitynumber();
    self endon( #"disconnect" );
    self endon( "removeHeadIcon_" + entnum );
    targetent waittill( #"disconnect" );
    
    if ( isdefined( self.binocularsstruct ) && isdefined( self.binocularsstruct.targetdata ) )
    {
        targetdata = self.binocularsstruct.targetdata[ entnum ];
        
        if ( isdefined( targetdata ) && isdefined( targetdata.headicon ) )
        {
            entityheadicons::setheadicon_deleteicon( targetdata.headicon );
        }
    }
}

// Namespace binoculars
// Params 1
// Checksum 0x849704a5, Offset: 0x1d69
// Size: 0x5e
function binoculars_removeheadicon( targetent )
{
    targetdata = self.binocularsstruct.targetdata[ targetent getentitynumber() ];
    assert( isdefined( targetdata ) );
    entityheadicons::setheadicon_deleteicon( targetdata.headicon );
    self notify( "removeHeadIcon_" + targetent getentitynumber() );
}

// Namespace binoculars
// Params 1
// Checksum 0xe44973bb, Offset: 0x1dcf
// Size: 0x1f
function binoculars_onstateinvalidenter( targetent )
{
    binoculars_hidetargetmarker( targetent );
    binoculars_setcurrentstate( targetent, 0 );
}

// Namespace binoculars
// Params 2
// Checksum 0xe172ee19, Offset: 0x1df6
// Size: 0x38
function binoculars_onstateinvalidupdate( targetent, cansee )
{
    istargetvalid = binoculars_targetisvalid( targetent );
    
    if ( istargetvalid && cansee )
    {
        return 2;
    }
    
    return 0;
}

// Namespace binoculars
// Params 1
// Checksum 0xce80a686, Offset: 0x1e37
// Size: 0x21
function binoculars_onstateunmarkedenter( targetent )
{
    binoculars_showtargetmarker( targetent, 0 );
    binoculars_setcurrentstate( targetent, 2 );
}

// Namespace binoculars
// Params 2
// Checksum 0xd83198c4, Offset: 0x1e60
// Size: 0x80
function binoculars_onstateunmarkedupdate( targetent, cansee )
{
    istargetvalid = binoculars_targetisvalid( targetent );
    
    if ( !istargetvalid )
    {
        return 0;
    }
    
    binoculars_updateprojectiondistance( targetent );
    
    if ( !cansee )
    {
        return 0;
    }
    
    binoculars_updatetargetmarker( targetent, 0 );
    
    if ( binoculars_iswithinprojectiondistance( targetent ) )
    {
        if ( binoculars_hascoldblooded( targetent ) )
        {
            self.binocularsstruct.markingcoldblooded = 1;
            return 2;
        }
        
        return 4;
    }
    
    return 2;
}

// Namespace binoculars
// Params 1
// Checksum 0x3ae3b61c, Offset: 0x1ee9
// Size: 0x2b
function binoculars_onstatemarkpendingenter( targetent )
{
    binoculars_setpendingtimer( targetent );
    binoculars_setcurrentstate( targetent, 4 );
    self playlocalsound( "eqp_spotter_scope_marking" );
}

// Namespace binoculars
// Params 1
// Checksum 0x1f7810d, Offset: 0x1f1c
// Size: 0x20
function binoculars_onstatemarkpendingexit( targetent )
{
    binoculars_clearpendingtimer( targetent );
    self stoplocalsound( "eqp_spotter_scope_marking" );
}

// Namespace binoculars
// Params 2
// Checksum 0x6f70948, Offset: 0x1f44
// Size: 0xe5
function binoculars_onstatemarkpendingupdate( targetent, cansee )
{
    istargetvalid = binoculars_targetisvalid( targetent );
    
    if ( !istargetvalid )
    {
        return 0;
    }
    
    binoculars_updateprojectiondistance( targetent );
    
    if ( !cansee )
    {
        return 0;
    }
    
    if ( !binoculars_iswithinprojectiondistance( targetent ) )
    {
        return 2;
    }
    
    if ( binoculars_checkpendingtimer( targetent ) )
    {
        return 5;
    }
    
    self.binocularsstruct.markingtarget = 1;
    
    if ( self.binocularsstruct.markingendtime == 0 )
    {
        self.binocularsstruct.markingendtime = binoculars_getpendingendtime( targetent );
    }
    else
    {
        self.binocularsstruct.markingendtime = int( min( self.binocularsstruct.markingendtime, binoculars_getpendingendtime( targetent ) ) );
    }
    
    return 4;
}

// Namespace binoculars
// Params 1
// Checksum 0x5bb37a60, Offset: 0x2032
// Size: 0x16f
function binoculars_onstatemarkedenter( targetent )
{
    binoculars_addheadicon( targetent );
    binoculars_updateheadiconvisibility( targetent );
    binoculars_showtargetmarker( targetent, 1 );
    binoculars_setexpirationtimer( targetent );
    binoculars_addmarkpoints( targetent );
    binoculars_setcurrentstate( targetent, 5 );
    self playlocalsound( "eqp_spotter_scope_marked_beep" );
    self stoplocalsound( "eqp_spotter_scope_marking" );
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
    {
        if ( isdefined( self.leaderboarddata[ "binocularMarks" ] ) )
        {
            self.leaderboarddata[ "binocularMarks" ] = self.leaderboarddata[ "binocularMarks" ] + 1;
        }
        
        if ( isdefined( level.leaderboardfunc[ "binocularMarks" ] ) )
        {
            [[ level.leaderboardfunc[ "binocularMarks" ] ]]( self, 1 );
        }
        
        assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
        
        if ( isdefined( self.pers[ "binocularMarks" ] ) )
        {
            self.pers[ "binocularMarks" ] = self.pers[ "binocularMarks" ] + 1;
        }
    }
    
    challenges::function_3d7a169dbae062fb( "equip_binoculars", self, int( distance( self.origin, targetent.origin ) ), ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"hit" ) );
}

// Namespace binoculars
// Params 1
// Checksum 0x4fa3c052, Offset: 0x21a9
// Size: 0x29
function binoculars_onstatemarkedexit( targetent )
{
    binoculars_removeheadicon( targetent );
    binoculars_clearexpirationtimer( targetent );
    self stoplocalsound( "eqp_spotter_scope_marking" );
}

// Namespace binoculars
// Params 1
// Checksum 0x960a0e57, Offset: 0x21da
// Size: 0x73
function binoculars_onstatemarkedupdate( targetent )
{
    if ( !binoculars_targetisvalidmark( targetent ) )
    {
        return 0;
    }
    
    binoculars_updateprojectiondistance( targetent );
    
    if ( binoculars_isads() && binoculars_cansee( targetent ) && binoculars_iswithinprojectiondistance( targetent ) )
    {
        binoculars_setexpirationtimer( targetent );
    }
    else if ( binoculars_checkexpirationtimer( targetent ) )
    {
        return 0;
    }
    
    binoculars_updateheadiconvisibility( targetent );
    binoculars_updatetargetmarker( targetent, 1 );
    return 5;
}

// Namespace binoculars
// Params 1
// Checksum 0x357269ca, Offset: 0x2256
// Size: 0x9e, Type: bool
function binoculars_targetisvalid( targetent )
{
    return isdefined( targetent ) && binoculars_isads() && !( isplayer( targetent ) && !player::isreallyalive( targetent ) ) && !( isagent( targetent ) && !isalive( targetent ) ) && !( level.teambased && isdefined( targetent.team ) && targetent.team == self.team ) && targetent != self && binoculars_istargetinrange( targetent ) && binoculars_istargetinbroadfov( targetent );
}

// Namespace binoculars
// Params 1
// Checksum 0x989bc883, Offset: 0x22fd
// Size: 0x77, Type: bool
function binoculars_targetisvalidmark( targetent )
{
    if ( !isdefined( targetent ) )
    {
        return false;
    }
    
    if ( isplayer( targetent ) && !player::isreallyalive( targetent ) )
    {
        return false;
    }
    
    if ( isagent( targetent ) && !isalive( targetent ) )
    {
        return false;
    }
    
    if ( level.teambased )
    {
        if ( targetent.team == self.team )
        {
            return false;
        }
    }
    else if ( targetent == self )
    {
        return false;
    }
    
    return true;
}

// Namespace binoculars
// Params 0
// Checksum 0xc3930b6e, Offset: 0x237d
// Size: 0x3f
function binoculars_getmaxrange()
{
    zoomlevelindex = self playergetzoomlevelindex();
    
    if ( zoomlevelindex > 0 )
    {
        return getdvarint( @"hash_60c09b13568650e9", 30000 );
    }
    
    return getdvarint( @"hash_c11b9fbc2f45b442", 15000 );
}

// Namespace binoculars
// Params 0
// Checksum 0x7da1c9f9, Offset: 0x23c4
// Size: 0x15
function binoculars_getfov()
{
    zoomfov = self playergetzoomfov();
    return zoomfov;
}

// Namespace binoculars
// Params 1
// Checksum 0xdb0b4fd9, Offset: 0x23e2
// Size: 0x38, Type: bool
function binoculars_istargetinrange( targetent )
{
    return distancesquared( self.origin, targetent.origin ) < self.binocularsstruct.maxrangesq;
}

// Namespace binoculars
// Params 1
// Checksum 0x4c4ec3b7, Offset: 0x2423
// Size: 0x3e
function binoculars_istargetinbroadfov( targetent )
{
    return utility::within_fov( self.origin, self getplayerangles(), targetent.origin, self.binocularsstruct.cosfov );
}

// Namespace binoculars
// Params 1
// Checksum 0xac7a0bba, Offset: 0x246a
// Size: 0x172, Type: bool
function binoculars_iswithinprojectiondistance_compute( targetent )
{
    pointa = self getvieworigin();
    pointb = pointa + anglestoforward( self getplayerangles() ) * self.binocularsstruct.maxrange;
    pointstocheck = [ targetent.origin ];
    
    if ( isplayer( targetent ) )
    {
        headpos = targetent utility::function_f02ebab438642e16();
        centerpos = targetent utility::function_68061c3d21a6d57a();
        pointstocheck = [ headpos, centerpos, targetent.origin ];
    }
    else if ( isagent( targetent ) )
    {
        pointstocheck = [ targetent.origin + ( 0, 0, 48 ) ];
    }
    
    foreach ( point in pointstocheck )
    {
        distsq = lengthsquared( vectorfromlinetopoint( pointa, pointb, point ) );
        
        if ( distsq < self.binocularsstruct.projdistsq )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace binoculars
// Params 1
// Checksum 0x46aef546, Offset: 0x25e5
// Size: 0x70
function binoculars_updateprojectiondistance( targetent )
{
    passed = binoculars_iswithinprojectiondistance_compute( targetent );
    targetdata = self.binocularsstruct.targetdata[ targetent getentitynumber() ];
    assert( isdefined( targetdata ) );
    
    if ( passed )
    {
        targetdata.withinprojectiondistance = 1;
        return;
    }
    
    targetdata.withinprojectiondistance = undefined;
}

// Namespace binoculars
// Params 1
// Checksum 0xe2301705, Offset: 0x265d
// Size: 0x49, Type: bool
function binoculars_iswithinprojectiondistance( targetent )
{
    targetdata = self.binocularsstruct.targetdata[ targetent getentitynumber() ];
    assert( isdefined( targetdata ) );
    return istrue( targetdata.withinprojectiondistance );
}

// Namespace binoculars
// Params 1
// Checksum 0x4dbd5bc9, Offset: 0x26af
// Size: 0x56
function binoculars_setpendingtimer( targetent )
{
    targetdata = self.binocularsstruct.targetdata[ targetent getentitynumber() ];
    assert( isdefined( targetdata ) );
    targetdata.pendingtimer = gettime() + binoculars_getpendingtime( targetent );
}

// Namespace binoculars
// Params 1
// Checksum 0x835326c6, Offset: 0x270d
// Size: 0x48
function binoculars_clearpendingtimer( targetent )
{
    targetdata = self.binocularsstruct.targetdata[ targetent getentitynumber() ];
    assert( isdefined( targetdata ) );
    targetdata.pendingtimer = undefined;
}

// Namespace binoculars
// Params 1
// Checksum 0xf3049114, Offset: 0x275d
// Size: 0x5f, Type: bool
function binoculars_checkpendingtimer( targetent )
{
    targetdata = self.binocularsstruct.targetdata[ targetent getentitynumber() ];
    assert( isdefined( targetdata ) );
    
    if ( !isdefined( targetdata.pendingtimer ) )
    {
        return false;
    }
    
    return gettime() > targetdata.pendingtimer;
}

// Namespace binoculars
// Params 1
// Checksum 0x1499f497, Offset: 0x27c5
// Size: 0x10a
function binoculars_getpendingtime( targetent )
{
    mindistance = getdvarfloat( @"hash_f59503ac1ff0e454", 2500 );
    maxdistance = getdvarfloat( @"hash_c7d3a5fbd69e4e06", 5000 );
    
    if ( mindistance >= maxdistance )
    {
        return getdvarfloat( @"hash_882715f356441b92", 500 );
    }
    
    disttotarget = distance( self.origin, targetent.origin );
    
    if ( disttotarget <= mindistance )
    {
        return getdvarfloat( @"hash_882715f356441b92", 500 );
    }
    
    if ( disttotarget >= 5000 )
    {
        return getdvarfloat( @"hash_81f96de1624a2fc0", 500 );
    }
    
    mintime = getdvarfloat( @"hash_882715f356441b92", 500 );
    maxtime = getdvarfloat( @"hash_81f96de1624a2fc0", 500 );
    distfrac = ( disttotarget - mindistance ) / ( maxdistance - mindistance );
    return int( math::lerp( mintime, maxtime, distfrac ) );
}

// Namespace binoculars
// Params 1
// Checksum 0x8a7fdb90, Offset: 0x28d7
// Size: 0x66
function binoculars_getpendingendtime( targetent )
{
    targetdata = self.binocularsstruct.targetdata[ targetent getentitynumber() ];
    assert( isdefined( targetdata ) );
    
    if ( !isdefined( targetdata.pendingtimer ) )
    {
        return ( gettime() + binoculars_getpendingtime( targetent ) );
    }
    
    return targetdata.pendingtimer;
}

// Namespace binoculars
// Params 1
// Checksum 0x9da8633, Offset: 0x2946
// Size: 0x6a
function binoculars_setexpirationtimer( targetent )
{
    targetdata = self.binocularsstruct.targetdata[ targetent getentitynumber() ];
    assert( isdefined( targetdata ) );
    expiretime = getdvarint( @"scr_binoculars_expire_time", 5000 );
    targetdata.expirationtimer = gettime() + expiretime;
}

// Namespace binoculars
// Params 1
// Checksum 0xc5bc655b, Offset: 0x29b8
// Size: 0x48
function binoculars_clearexpirationtimer( targetent )
{
    targetdata = self.binocularsstruct.targetdata[ targetent getentitynumber() ];
    assert( isdefined( targetdata ) );
    targetdata.expirationtimer = undefined;
}

// Namespace binoculars
// Params 1
// Checksum 0xc19cf144, Offset: 0x2a08
// Size: 0x60, Type: bool
function binoculars_checkexpirationtimer( targetent )
{
    targetdata = self.binocularsstruct.targetdata[ targetent getentitynumber() ];
    assert( isdefined( targetdata ) );
    
    if ( !isdefined( targetdata.expirationtimer ) )
    {
        return true;
    }
    
    return gettime() >= targetdata.expirationtimer;
}

// Namespace binoculars
// Params 1
// Checksum 0x3a991479, Offset: 0x2a71
// Size: 0x94
function binoculars_addmarkpoints( targetent )
{
    if ( !isdefined( self.markedentitieslifeindices ) )
    {
        self.markedentitieslifeindices = [];
    }
    
    entitynum = targetent getentitynumber();
    lifeindex = self.matchdatalifeindex ?? 0;
    
    if ( !isdefined( self.markedentitieslifeindices[ entitynum ] ) || self.markedentitieslifeindices[ entitynum ] > lifeindex )
    {
        self.markedentitieslifeindices[ entitynum ] = lifeindex;
        thread points::doscoreevent( #"binoculars_marked" );
        playerlogic::playerhasmoved();
    }
}

// Namespace binoculars
// Params 1
// Checksum 0x23e14c7f, Offset: 0x2b0d
// Size: 0x70, Type: bool
function binoculars_targetismarked( targetent )
{
    if ( !( isdefined( self.binocularsstruct ) && isdefined( self.binocularsstruct.targetdata ) ) )
    {
        return false;
    }
    
    targetdata = self.binocularsstruct.targetdata[ targetent getentitynumber() ];
    
    if ( !isdefined( targetdata ) )
    {
        return false;
    }
    
    return targetdata.state == 5;
}

// Namespace binoculars
// Params 2
// Checksum 0x3a009d93, Offset: 0x2b86
// Size: 0x10d
function binoculars_giveassistpoints( attacker, victim )
{
    if ( !isdefined( level.binocularsinited ) )
    {
        return;
    }
    
    if ( !( isdefined( attacker ) && isdefined( victim ) && isdefined( attacker.team ) ) )
    {
        return;
    }
    
    if ( !teams::function_b00ab7e503f33379( attacker.team, "players" ) )
    {
        return;
    }
    
    teammates = teams::getteamdata( attacker.team, "players" );
    
    foreach ( teammate in teammates )
    {
        if ( teammate == attacker )
        {
            continue;
        }
        
        if ( teammate binoculars_targetismarked( victim ) )
        {
            teammate thread points::doscoreevent( #"binoculars_assist" );
        }
    }
}

// Namespace binoculars
// Params 2
// Checksum 0xeea484d5, Offset: 0x2c9b
// Size: 0x115
function function_680ead3de34a942( attacker, victim )
{
    markers = [];
    
    if ( !isdefined( level.binocularsinited ) )
    {
        return markers;
    }
    
    if ( !( isdefined( attacker ) && isdefined( victim ) && isdefined( attacker.team ) ) )
    {
        return markers;
    }
    
    if ( !teams::function_b00ab7e503f33379( attacker.team, "players" ) )
    {
        return markers;
    }
    
    teammates = teams::getteamdata( attacker.team, "players" );
    
    foreach ( teammate in teammates )
    {
        if ( teammate == attacker )
        {
            continue;
        }
        
        if ( teammate binoculars_targetismarked( victim ) )
        {
            markers[ markers.size ] = teammate;
        }
    }
    
    return markers;
}

// Namespace binoculars
// Params 0
// Checksum 0x535f3fab, Offset: 0x2db9
// Size: 0x25
function binoculars_clearuidata()
{
    self setclientomnvar( "ui_binoculars_timer", 0 );
    self setclientomnvar( "ui_binoculars_state", 0 );
    self stoplocalsound( "eqp_spotter_scope_marking" );
}

// Namespace binoculars
// Params 2
// Checksum 0xbdf67ca6, Offset: 0x2de6
// Size: 0x51
function binoculars_setuidata( state, timer )
{
    if ( self getclientomnvar( "ui_binoculars_state" ) == state && self getclientomnvar( "ui_binoculars_timer" ) == timer )
    {
        return;
    }
    
    self setclientomnvar( "ui_binoculars_state", state );
    self setclientomnvar( "ui_binoculars_timer", timer );
}

// Namespace binoculars
// Params 0
// Checksum 0x6b691431, Offset: 0x2e3f
// Size: 0xaf
function binoculars_updateuidata()
{
    var_8278bbf17e346fdc = istrue( self.binocularsstruct.markingtarget );
    
    if ( var_8278bbf17e346fdc )
    {
        binoculars_setuidata( 1, self.binocularsstruct.markingendtime );
        return;
    }
    
    var_9948f49e4015a2fc = istrue( self.binocularsstruct.markingcoldblooded );
    
    if ( var_9948f49e4015a2fc )
    {
        binoculars_setuidata( 2, 0 );
        return;
    }
    
    binoculars_setuidata( 0, 0 );
    
    if ( !self.binocularsstruct.var_49b6c0b460f83b73 )
    {
        self.binocularsstruct.var_49b6c0b460f83b73 = 1;
        thread function_4297c30b30d2c199();
    }
}

// Namespace binoculars
// Params 0
// Checksum 0x5c6df572, Offset: 0x2ef6
// Size: 0xc3
function function_4297c30b30d2c199()
{
    self endon( #"binoculars_ads_off" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        newlookatpos = binoculars_getownerlookatpos();
        
        if ( isdefined( newlookatpos ) )
        {
            targetdistance = distance( self getvieworigin(), newlookatpos );
            targetdegree = asin( ( newlookatpos[ 2 ] - self getvieworigin()[ 2 ] ) / targetdistance );
            targetdistance *= 0.0254;
            self setclientomnvar( "ui_binoculars_target_distance", int( round( targetdistance ) ) );
            self setclientomnvar( "ui_binoculars_target_degree", int( round( targetdegree ) ) );
        }
        else
        {
            self setclientomnvar( "ui_binoculars_target_distance", -1 );
        }
        
        wait 0.15;
    }
}

// Namespace binoculars
// Params 0
// Checksum 0x150f96ab, Offset: 0x2fc1
// Size: 0xaa
function binoculars_getownerlookatpos()
{
    content = [ "physicscontents_characterproxy", "physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicleclip" ];
    contentoverride = physics_createcontents( content );
    starttrace = self getvieworigin();
    endtrace = starttrace + anglestoforward( self getplayerangles() ) * 50000;
    ignoreents = killstreak_utility::playerkillstreakgetownerlookatignoreents();
    trace = trace::ray_trace( starttrace, endtrace, ignoreents, contentoverride );
    
    if ( trace[ "hittype" ] == "hittype_none" )
    {
        return;
    }
    
    return trace[ "position" ];
}

