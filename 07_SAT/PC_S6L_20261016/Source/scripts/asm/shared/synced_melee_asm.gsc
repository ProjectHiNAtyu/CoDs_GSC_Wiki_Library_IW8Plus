// scripts\asm\shared\synced_melee_asm.gsc  (hash_4449008f177af837.gscc) (size: 12800 Bytes / 0x3200 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1a7e4c5e (444484702)
// size ...... 12800 (0x3200)
// includes .. 6   (offset: 0x2e50)
// strings ... 57  (offset: 0x2e80)
// dev strs .. 0   (offset: 0x3200)
// exports ... 21  (offset: 0x20f0)
// cseg ...... 0x51c + 0x1bd4 (0x20f0)
// imports ... 80  (offset: 0x2438)
// animtree1 . 0   (offset: 0x3200)
// animtree2 . 0   (offset: 0x3200)
#using scripts\anim\shared;
#using scripts\anim\utility;
#using scripts\asm\asm;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\common\values;

#namespace synced_melee_asm;

// Namespace synced_melee_asm
// Params 2
// Checksum 0x1530c875, Offset: 0x53a
// Size: 0x1d3, Type: bool
function evaluatesyncedmeleebyxanim( meleexanim, var_fa3a0e29600f7df )
{
    target = self.meleetarget;
    targetangles = target.angles;
    metotarget = target.origin - self.origin;
    metotargetyaw = vectortoyaw( metotarget );
    var_c2043ac25767480d = 30;
    yawdelta = angleclamp180( metotargetyaw - self.angles[ 1 ] );
    
    if ( abs( yawdelta ) > var_c2043ac25767480d )
    {
        return false;
    }
    
    if ( var_fa3a0e29600f7df )
    {
        targetangles = target.angles - ( 0, yawdelta * 0.5, 0 );
        startpos = getstartorigin( target.origin, targetangles, meleexanim );
    }
    else
    {
        targetangles = target.angles - ( 0, yawdelta, 0 );
        startpos = getstartorigin( target.origin, targetangles, meleexanim );
    }
    
    startpostome = self.origin - startpos;
    var_821c5bab499b9dd = vectornormalize( target.origin - startpos );
    dot = vectordot( var_821c5bab499b9dd, startpostome );
    
    if ( dot > 12 || dot < -12 )
    {
        return false;
    }
    
    if ( var_fa3a0e29600f7df )
    {
        self.var_5365a812940e65d5 = self.angles[ 1 ] + yawdelta * 0.5;
        target.var_5365a812940e65d5 = targetangles[ 1 ];
    }
    else
    {
        self.var_5365a812940e65d5 = getstartangles( target.origin, targetangles, meleexanim )[ 1 ];
        target.var_5365a812940e65d5 = targetangles[ 1 ];
    }
    
    target.var_51649f156d8372af = 1;
    return true;
}

// Namespace synced_melee_asm
// Params 2
// Checksum 0xbc0aa4d3, Offset: 0x716
// Size: 0x1ae, Type: bool
function function_2f00de478112917c( meleexanim, zombiemeleexanim )
{
    soldieranimlength = getanimlength( meleexanim );
    zombieanimlength = getanimlength( zombiemeleexanim );
    zombiesynctime = getnotetracktimes( zombiemeleexanim, "sync" );
    fracsynctime = zombiesynctime[ 0 ] * zombieanimlength / soldieranimlength;
    soldiermovedelta = getmovedelta( meleexanim );
    soldieranimendpos = self localtoworldcoords( soldiermovedelta );
    zombieanimstartposang = animation::function_bcb776397b6f4ce( meleexanim, "tag_sync", 0, self.origin, self.angles );
    var_29c8cf126db12608 = animation::function_bcb776397b6f4ce( meleexanim, "tag_sync", fracsynctime, self.origin, self.angles );
    zombiemovedelta = getmovedelta( zombiemeleexanim );
    endpos = coordtransform( soldiermovedelta, zombieanimstartposang[ "origin" ], zombieanimstartposang[ "angles" ] );
    target = self.meleetarget;
    dist = distance( target.origin, var_29c8cf126db12608[ "origin" ] );
    
    if ( dist > 40 )
    {
        return false;
    }
    
    if ( !ispointonnavmesh( soldieranimendpos ) || !ispointonnavmesh( var_29c8cf126db12608[ "origin" ] ) )
    {
        return false;
    }
    
    navtraceresult = navtrace( zombieanimstartposang[ "origin" ], self.origin, target, 0 );
    
    if ( navtraceresult )
    {
        return false;
    }
    
    navtraceresult = navtrace( self.origin, soldieranimendpos, self, 0 );
    
    if ( navtraceresult )
    {
        return false;
    }
    
    target.var_51649f156d8372af = 1;
    return true;
}

// Namespace synced_melee_asm
// Params 4
// Checksum 0xd6072b85, Offset: 0x8cd
// Size: 0x368
function evaluatesyncedmelee( asmname, statename, tostatename, params )
{
    if ( isdefined( level.synced_melee_function ) )
    {
        return [[ level.synced_melee_function ]]( self, asmname, statename, tostatename, params );
    }
    
    assert( self.in_melee );
    assert( isdefined( self.meleetarget ) );
    target = self.meleetarget;
    
    if ( isplayer( target ) || !isai( target ) )
    {
        return 0;
    }
    
    if ( self.dontsyncmelee || target.dontsyncmelee )
    {
        return 0;
    }
    
    if ( !isdefined( target.weapon ) )
    {
        return 0;
    }
    
    if ( !target asmhasstate( target.asmname, tostatename + "_victim" ) )
    {
        return 0;
    }
    
    if ( target.type != "zombie" )
    {
        if ( weaponclass( self.weapon ) == "pistol" || weaponclass( target.weapon ) == "pistol" )
        {
            return 0;
        }
    }
    
    if ( getdvarint( @"hash_4fa81bfc988a90e6", 0 ) == 1 )
    {
        if ( target.type == "zombie" )
        {
            target.meleealwayswin = 1;
        }
    }
    
    if ( !( isdefined( self.var_fa9ce76386e8f52b ) && isdefined( target.var_fa9ce76386e8f52b ) ) )
    {
        melee_decide_winner();
    }
    
    bwinner = params[ 0 ];
    
    if ( self.var_fa9ce76386e8f52b != bwinner )
    {
        return 0;
    }
    
    var_fa3a0e29600f7df = params[ 1 ];
    syncdir = melee_calcsyncdirection();
    variations = [ "a" ];
    
    if ( target.type == "zombie" || syncdir == "8" )
    {
        variations = [ "a", "b", "c" ];
        numvars = 3;
        var_78bacee1f4b0877 = randomint( numvars );
        var_78badee1f4b0aaa = randomint( numvars );
        temp = variations[ var_78bacee1f4b0877 ];
        variations[ var_78bacee1f4b0877 ] = variations[ var_78badee1f4b0aaa ];
        variations[ var_78badee1f4b0aaa ] = temp;
    }
    
    numvars = variations.size;
    
    for ( ivar = 0; ivar < numvars ; ivar++ )
    {
        aliasname = syncdir + variations[ ivar ];
        meleeanim = asm::asm_lookupanimfromalias( tostatename, aliasname );
        meleexanim = asm::asm_getxanim( tostatename, meleeanim );
        
        if ( target.type == "zombie" )
        {
            zombietostatename = tostatename + "_victim";
            zombiemeleeanim = target asm::asm_lookupanimfromalias( zombietostatename, aliasname );
            zombiemeleexanim = target asm::asm_getxanim( zombietostatename, zombiemeleeanim );
            
            if ( function_2f00de478112917c( meleexanim, zombiemeleexanim ) )
            {
                self.meleeanimalias = aliasname;
                target.meleeanimalias = aliasname;
                target.syncedmeleepartner = self;
                return 1;
            }
            
            continue;
        }
        
        if ( evaluatesyncedmeleebyxanim( meleexanim, var_fa3a0e29600f7df ) )
        {
            self.meleeanimalias = aliasname;
            target.meleeanimalias = aliasname;
            target.syncedmeleepartner = self;
            return 1;
        }
    }
    
    return 0;
}

// Namespace synced_melee_asm
// Params 2
// Checksum 0x42e04878, Offset: 0xc3e
// Size: 0x15
function melee_setmeleetimer( unittype, factor )
{
    InvalidOpCode( 0x97 );
    // Unknown operator ( 0x97, t11, Black Ops 7 )
}

// Namespace synced_melee_asm
// Params 0
// Checksum 0xa8ba8888, Offset: 0xd22
// Size: 0xc8
function melee_calcsyncdirection()
{
    assert( self.in_melee );
    target = self.meleetarget;
    assert( isdefined( target ) );
    targettome = self.origin - target.origin;
    var_9c5a0a3cf6ab246b = vectortoyaw( targettome );
    anglediff = angleclamp180( var_9c5a0a3cf6ab246b - target.angles[ 1 ] );
    
    if ( -45 < anglediff && anglediff < 45 )
    {
        return "8";
    }
    else if ( anglediff > 135 || anglediff < -135 )
    {
        return "2";
    }
    else if ( anglediff > 45 )
    {
        return "4";
    }
    
    return "6";
}

// Namespace synced_melee_asm
// Params 1
// Checksum 0xb867edc8, Offset: 0xdf3
// Size: 0x52
function melee_waitfordroppedweapon( statename )
{
    self endon( statename + "_finished" );
    self waittill( #"weapon_dropped", droppedweapon );
    
    if ( isdefined( droppedweapon ) )
    {
        assert( self.in_melee );
        self.var_7c39d1310ec3c31d = droppedweapon;
    }
}

// Namespace synced_melee_asm
// Params 2
// Checksum 0x74eb5d0e, Offset: 0xe4d
// Size: 0xba
function melee_synced_setup( statename, battacker )
{
    self.meleestatename = statename;
    self.bmeleeinprogress = 1;
    self.meleeweapon = self.weapon;
    self.meleeweaponslot = utility::getcurrentweaponslotname();
    self.var_b22fbc63c5cfb841 = 1;
    
    if ( battacker )
    {
        melee_setmeleetimer( self.unittype );
        self.syncedmeleetarget = self.meleetarget;
    }
    else
    {
        self.syncedmeleetarget = self.meleepartner;
    }
    
    if ( self.unittype == "c6" )
    {
        self.hackable = 0;
        self.ignoreme = 1;
    }
}

// Namespace synced_melee_asm
// Params 0
// Checksum 0xcf5d9e7e, Offset: 0xf0f
// Size: 0x76
function melee_unlink()
{
    self unlink();
    
    if ( isalive( self.meleepartner ) )
    {
        self.meleepartner animmode( "zonly_physics" );
        self.meleepartner orientmode( "face angle", self.meleepartner.angles[ 1 ] );
    }
    
    self animmode( "zonly_physics" );
    self orientmode( "face angle", self.angles[ 1 ] );
}

// Namespace synced_melee_asm
// Params 3
// Checksum 0xb50c5bd7, Offset: 0xf8d
// Size: 0x5b
function chooseanim_syncmelee( asmname, statename, params )
{
    assert( isdefined( self.meleeanimalias ) );
    
    if ( !isdefined( self.meleeanimalias ) )
    {
        self.meleeanimalias = "2a";
    }
    
    return asm::asm_lookupanimfromalias( statename, self.meleeanimalias );
}

// Namespace synced_melee_asm
// Params 0
// Checksum 0x4591a147, Offset: 0xff1
// Size: 0x150
function melee_decide_winner()
{
    assert( self.in_melee );
    assert( isdefined( self.meleetarget ) );
    target = self.meleetarget;
    assert( target.in_melee );
    
    if ( self.meleealwayswin )
    {
        assert( !isdefined( target.magic_bullet_shield ) );
        self.var_fa9ce76386e8f52b = 1;
        target.var_fa9ce76386e8f52b = 0;
        return;
    }
    else if ( target.meleealwayswin )
    {
        assert( !isdefined( self.magic_bullet_shield ) );
        self.var_fa9ce76386e8f52b = 0;
        target.var_fa9ce76386e8f52b = 1;
        return;
    }
    
    if ( isdefined( self.magic_bullet_shield ) )
    {
        assert( !isdefined( target.magic_bullet_shield ) );
        self.var_fa9ce76386e8f52b = 1;
        target.var_fa9ce76386e8f52b = 0;
        return;
    }
    
    if ( isdefined( target.magic_bullet_shield ) )
    {
        self.var_fa9ce76386e8f52b = 0;
        target.var_fa9ce76386e8f52b = 1;
        return;
    }
    
    self.var_fa9ce76386e8f52b = utility::cointoss();
    target.var_fa9ce76386e8f52b = !self.var_fa9ce76386e8f52b;
}

// Namespace synced_melee_asm
// Params 3
// Checksum 0x10b5d9b1, Offset: 0x1149
// Size: 0x3b
function melee_instantkill( asmname, statename, params )
{
    self kill( self.origin + anglestoforward( self.angles ) );
}

// Namespace synced_melee_asm
// Params 3
// Checksum 0xed32703f, Offset: 0x118c
// Size: 0x418
function playmeleeanim_synced( asmname, statename, params )
{
    self endon( statename + "_finished" );
    assert( self.in_melee );
    assert( isdefined( self.meleetarget ) );
    self.bmeleestarted = 1;
    target = self.meleetarget;
    meleeanim = asm::asm_getanim( asmname, statename );
    meleexanim = asm::asm_getxanim( statename, meleeanim );
    asm::asm_fireephemeralevent( "melee_attack", "begin" );
    melee_synced_setup( statename, 1 );
    stoptimes = getnotetracktimes( meleexanim, "melee_stop" );
    
    if ( stoptimes.size > 0 )
    {
        self.var_983be2122a272bca = 1;
    }
    
    interacttimes = getnotetracktimes( meleexanim, "melee_interact" );
    
    if ( interacttimes.size > 0 )
    {
        self.var_82aa490ca55c32d8 = 1;
    }
    
    if ( self.type != "zombie" )
    {
        thread melee_waitfordroppedweapon( statename );
    }
    
    if ( isdefined( target getinteractionid() ) )
    {
        target leaveinteraction();
    }
    
    target asm::asm_setstate( statename + "_victim" );
    
    if ( target.type == "zombie" )
    {
        self.var_6bb5153de490f098 = 1;
    }
    
    self animmode( "zonly_physics" );
    
    if ( isdefined( self.var_5365a812940e65d5 ) )
    {
        self orientmode( "face angle", self.var_5365a812940e65d5 );
    }
    
    if ( !self.var_fa9ce76386e8f52b && !self.var_82ffc7f8cb67f7b6 )
    {
        val::set( "synced_melee", "ignoreme", 1 );
        val::set( "synced_melee", "execution_victim", 0 );
    }
    
    self aisetanim( statename, meleeanim );
    asm::asm_playfacialanim( asmname, statename, meleexanim );
    thread playmeleeanim_synced_waitforpartnerexit( asmname, statename );
    self endon( statename + "_finished" );
    lastnotetrack = asm::asm_donotetracks( asmname, statename, &melee_handlenotetracks );
    
    if ( ( lastnotetrack == "melee_death" || !self.var_fa9ce76386e8f52b ) && !self.var_82ffc7f8cb67f7b6 )
    {
        self.a.nodeath = 0;
        
        if ( isdefined( self.meleetarget ) && self.meleetarget.in_melee )
        {
            self.meleetarget.var_a6aa8551fbd7eddd = 1;
        }
        
        if ( isdefined( self.magic_bullet_shield ) )
        {
            if ( !isdefined( lastnotetrack ) )
            {
                lastnotetrack = "undefined";
            }
            
            if ( isdefined( target ) )
            {
                msg1 = "Attempting to kill AI " + self getentitynumber() + " (" + self.classname + ") with magic_bullet_shield. ";
                msg2 = "lastNotetrack = " + lastnotetrack + " target (melee winner) = " + target getentitynumber() + " (" + target.classname + ") ";
                msg3 = "self.bMeleeWinner = " + self.var_fa9ce76386e8f52b + " self.bMeleeSurvive = " + self.var_82ffc7f8cb67f7b6 + " ";
                msg4 = "target.bMeleeWinner = " + target.var_fa9ce76386e8f52b + " target.bMeleeSurvive = " + target.var_82ffc7f8cb67f7b6 + " ";
                assertmsg( msg1 + msg2 + msg3 + msg4 );
            }
            else
            {
                msg1 = "Attempting to kill AI " + self getentitynumber() + " (" + self.classname + ") with magic_bullet_shield. ";
                msg2 = "lastNotetrack = " + lastnotetrack + " and target is UNDEFINED! ";
                msg3 = "self.bMeleeWinner = " + self.var_fa9ce76386e8f52b + " self.bMeleeSurvive = " + self.var_82ffc7f8cb67f7b6 + " ";
                assertmsg( msg1 + msg2 + msg3 );
            }
        }
        
        if ( target.type == "zombie" )
        {
            self kill( self.origin + anglestoforward( self.angles ) );
            return;
        }
        
        self kill();
    }
}

// Namespace synced_melee_asm
// Params 3
// Checksum 0xcbbacc46, Offset: 0x15ac
// Size: 0x85
function playmeleeanim_synced_survive( asmname, statename, params )
{
    assert( !self.in_melee );
    surviveanim = asm::asm_getanim( asmname, statename );
    survivexanim = asm::asm_getxanim( statename, surviveanim );
    self aisetanim( statename, surviveanim );
    asm::asm_playfacialanim( asmname, statename, survivexanim );
    self.meleeanimalias = undefined;
    asm::asm_donotetracks( asmname, statename, &melee_handlenotetracks );
}

// Namespace synced_melee_asm
// Params 3
// Checksum 0x277e7076, Offset: 0x1639
// Size: 0xfa
function playmeleeanim_synced_cleanup( asmname, statename, params )
{
    if ( self.in_melee )
    {
        if ( isdefined( self.syncedmeleepartner ) )
        {
            self.syncedmeleepartner notify( #"melee_exit" );
            self.syncedmeleepartner = undefined;
        }
        else if ( isdefined( self.meleepartner ) )
        {
            self.meleepartner notify( #"melee_exit" );
        }
    }
    
    self.var_6bb5153de490f098 = 0;
    
    if ( isalive( self ) && self.in_melee && self.type != "zombie" )
    {
        melee_droppedweaponrestore();
    }
    
    if ( isalive( self ) )
    {
        val::reset_all( "synced_melee" );
    }
    
    self unlink();
    
    if ( self.unittype == "c6" )
    {
        self.hackable = 1;
        self.ignoreme = 0;
    }
    
    self function_a227728f297b8669( 0 );
}

// Namespace synced_melee_asm
// Params 3
// Checksum 0xf22b6bc3, Offset: 0x173b
// Size: 0x244
function playmeleeanim_synced_victim( asmname, statename, params )
{
    self endon( statename + "_finished" );
    assert( self.in_melee );
    self.bmeleestarted = 1;
    self animmode( "nogravity" );
    
    if ( isdefined( self.var_5365a812940e65d5 ) )
    {
        self orientmode( "face angle", self.var_5365a812940e65d5 );
    }
    else
    {
        self orientmode( "face current" );
    }
    
    if ( !self.var_fa9ce76386e8f52b && !self.var_82ffc7f8cb67f7b6 )
    {
        val::set( "synced_melee", "ignoreme", 1 );
        val::set( "synced_melee", "execution_victim", 0 );
    }
    
    melee_synced_setup( statename, 0 );
    
    if ( self.type != "zombie" )
    {
        thread melee_waitfordroppedweapon( statename );
    }
    
    victimanim = asm::asm_getanim( asmname, statename );
    victimxanim = asm::asm_getxanim( statename, victimanim );
    self aisetanim( statename, victimanim );
    asm::asm_playfacialanim( asmname, statename, victimxanim );
    stoptimes = getnotetracktimes( victimxanim, "melee_stop" );
    
    if ( stoptimes.size > 0 )
    {
        self.var_983be2122a272bca = 1;
    }
    
    interacttimes = getnotetracktimes( victimxanim, "melee_interact" );
    
    if ( interacttimes.size > 0 )
    {
        self.var_82aa490ca55c32d8 = 1;
    }
    
    interactendtimes = getnotetracktimes( victimxanim, "drop" );
    
    if ( interactendtimes.size > 0 )
    {
        self.var_73d05a869dd2833f = 1;
    }
    
    thread playmeleeanim_synced_waitforpartnerexit( asmname, statename );
    lastnotetrack = asm::asm_donotetracks( asmname, statename, &melee_handlenotetracks );
    
    if ( ( lastnotetrack == "melee_death" || isdefined( self.var_fa9ce76386e8f52b ) && !self.var_fa9ce76386e8f52b ) && !self.var_82ffc7f8cb67f7b6 )
    {
        self.a.nodeath = 0;
        
        if ( isdefined( self.meleepartner ) && self.meleepartner.in_melee )
        {
            self.meleepartner.var_a6aa8551fbd7eddd = 1;
        }
        
        self kill();
    }
}

// Namespace synced_melee_asm
// Params 2
// Checksum 0xb51e0948, Offset: 0x1987
// Size: 0x37
function waitforpartnerdelete( statename, partner )
{
    if ( !isdefined( partner ) )
    {
        return;
    }
    
    partner waittill( #"entitydeleted" );
    self notify( #"melee_exit" );
}

// Namespace synced_melee_asm
// Params 2
// Checksum 0x2036a6e4, Offset: 0x19c6
// Size: 0x1e2
function playmeleeanim_synced_waitforpartnerexit( asmname, statename )
{
    self endon( #"death" );
    self endon( statename + "_finished" );
    
    if ( isdefined( self.syncedmeleepartner ) )
    {
        childthread waitforpartnerdelete( statename, self.syncedmeleepartner );
    }
    else
    {
        childthread waitforpartnerdelete( statename, self.meleepartner );
    }
    
    self waittill( #"melee_exit" );
    self unlink();
    var_6de087415d3fd6e2 = asm::asm_eventfired( asmname, "melee_interact" );
    
    if ( self.var_82aa490ca55c32d8 && !var_6de087415d3fd6e2 )
    {
        self.var_82ffc7f8cb67f7b6 = 1;
    }
    else if ( var_6de087415d3fd6e2 && !asm::asm_eventfired( asmname, "melee_death" ) )
    {
        if ( self.var_73d05a869dd2833f )
        {
            self.var_82ffc7f8cb67f7b6 = !asm::asm_eventfired( asmname, "drop" );
        }
        else
        {
            self.var_82ffc7f8cb67f7b6 = 0;
        }
    }
    
    if ( isdefined( self.var_fa9ce76386e8f52b ) && !self.var_fa9ce76386e8f52b )
    {
        if ( self.var_82ffc7f8cb67f7b6 )
        {
            if ( asm::asm_eventfired( asmname, "death_ragdoll_delayed" ) )
            {
                melee_instantkill();
            }
            else
            {
                self.var_56a5b757af5bed42 = 1;
                self.var_50adce1c7d83b497 = 0;
            }
        }
        else if ( asm::asm_eventfired( asmname, "melee_no_recovery" ) )
        {
            self.var_1acd684935b83642 = 1;
        }
        else if ( asm::asm_eventfired( asmname, "melee_stop" ) )
        {
            self kill();
        }
        else if ( self.var_983be2122a272bca )
        {
            self.var_56a5b757af5bed42 = 1;
        }
        else
        {
            self.var_1acd684935b83642 = 1;
        }
        
        return;
    }
    
    if ( asm::asm_eventfired( asmname, "fire" ) )
    {
        self.var_1acd684935b83642 = 1;
        return;
    }
    
    if ( !self.var_a6aa8551fbd7eddd )
    {
        self.var_56a5b757af5bed42 = 1;
    }
}

// Namespace synced_melee_asm
// Params 2
// Checksum 0x4e282261, Offset: 0x1bb0
// Size: 0x1df
function function_898cc56da74c9a07( final_alias, append_code )
{
    append = "";
    
    switch ( append_code )
    {
        case #"hash_a13dd2b8b51545eb":
            append = "_cloth";
            
            if ( self.armored )
            {
                append = "_gear";
            }
            
            break;
        case #"hash_4f7f2f56f62275dc":
            append = "_dirt";
            my_surface = self.lastgroundtype;
            
            if ( isdefined( my_surface ) )
            {
                switch ( my_surface )
                {
                    case #"hash_cacc49f5cefe9c2":
                    case #"hash_fb5a4fd62140d3d":
                    case #"hash_1b9205edae40e596":
                    case #"hash_1d3c8b96a9c71b54":
                    case #"hash_3931479c445fb9b9":
                    case #"hash_4d63389017f81514":
                    case #"hash_4f863c6e34468e29":
                    case #"hash_51929a2eb8e4f743":
                    case #"hash_519950fd846289c6":
                    case #"hash_57b9e7028fd773ba":
                    case #"hash_590687995d01030e":
                    case #"hash_5dab8ddea3468324":
                    case #"hash_67e845c97d1f9eda":
                    case #"hash_7fe735e403d9fe08":
                    case #"hash_84a41da455643bc9":
                    case #"hash_886109ae17c9aa73":
                    case #"hash_8c9d4c67dcde81f2":
                    case #"hash_8dede5336d28890d":
                    case #"hash_8f53c9965f23a6cd":
                    case #"hash_91afe7576024a903":
                    case #"hash_d70d4c17673f4162":
                    case #"hash_df0e712b7aee0b97":
                    case #"hash_f4d3c7f04f8ef31d":
                    case #"hash_f5afef0d74babaca":
                    case #"hash_f9100fc94321f813":
                        append = "_wood";
                        break;
                }
            }
            
            break;
    }
    
    final_alias += append;
    
    if ( soundexists( final_alias ) )
    {
        self playsound( final_alias );
    }
}

// Namespace synced_melee_asm
// Params 1
// Checksum 0x3b077a55, Offset: 0x1d97
// Size: 0x2c1
function melee_handlenotetracks( note )
{
    prefix = getsubstr( note, 0, 3 );
    used_prefix = 0;
    
    switch ( prefix )
    {
        case #"hash_8966586c51e34031":
            used_prefix = 1;
            alias = getsubstr( note, 3 );
            self playsound( alias );
            break;
        case #"hash_6d20b46c4370528e":
            used_prefix = 1;
            truncatednotetrack = getsubstr( note, 3 );
            params = strtok( truncatednotetrack, "," );
            
            if ( params.size >= 2 )
            {
                function_898cc56da74c9a07( params[ 0 ], params[ 1 ] );
            }
            
            break;
    }
    
    if ( used_prefix )
    {
        return;
    }
    
    switch ( note )
    {
        case #"hash_49d2de8a43d395fa":
            if ( !self.var_56a5b757af5bed42 )
            {
                if ( isdefined( self.meleetarget ) )
                {
                    if ( isalive( self.meleetarget ) )
                    {
                        self linktoblendtotag( self.meleetarget, "tag_sync", 1, 1 );
                    }
                }
                else if ( self.var_51649f156d8372af && isdefined( self.syncedmeleepartner ) )
                {
                    if ( isalive( self.syncedmeleepartner ) )
                    {
                        self linktoblendtotag( self.syncedmeleepartner, "tag_sync", 1, 1 );
                    }
                }
            }
            
            break;
        case #"hash_a74d3b6faa5ac811":
            if ( self.var_b22fbc63c5cfb841 )
            {
                melee_unlink();
            }
            else
            {
                self unlink();
            }
            
            break;
        case #"hash_9b60ee8bd4984ddf":
            shared::dropallaiweapons();
            
            if ( !self.alreadydroppedweapon && isdefined( level.var_b6c3ca068782a9cb ) && isdefined( level.var_3836af4596707c8c ) )
            {
                self.alreadydroppedweapon = 1;
                weapon = self [[ level.var_b6c3ca068782a9cb ]]();
                [[ level.var_3836af4596707c8c ]]( weapon, self.origin );
            }
            
            break;
        case #"hash_36a959dce6e4f5bc":
            self.var_fd5c989cd241b6c4 = 1;
            break;
        case #"hash_b11f0ef79e138572":
            self.var_fd5c989cd241b6c4 = 1;
            break;
        case #"hash_9a4dd9ac49e5d8ae":
            return note;
        case #"hash_fd45bbe21f535106":
            self attach( "weapon_vm_me_soscar_knife", "TAG_INHAND", 1 );
            break;
        case #"hash_78af604e22ccf1d4":
            self detach( "weapon_vm_me_soscar_knife", "TAG_INHAND" );
            break;
        case #"hash_23b3ca8a2f927c01":
            self playsound( "melee_knife_hit_body" );
            playfxontag( level._effect[ "melee_knife_ai" ], self, "TAG_KNIFE_FX" );
            break;
        case #"hash_9ccf1d54a8f2ba84":
            break;
    }
}

// Namespace synced_melee_asm
// Params 0
// Checksum 0xa49095b5, Offset: 0x2060
// Size: 0x90
function melee_droppedweaponrestore()
{
    assert( isdefined( self ) );
    assert( self.in_melee );
    
    if ( !isnullweapon( self.weapon ) && !isnullweapon( self.lastweapon ) )
    {
        return;
    }
    
    if ( isundefinedweapon( self.meleeweapon ) )
    {
        return;
    }
    
    shared::forceuseweapon( self.meleeweapon, self.meleeweaponslot );
    
    if ( isdefined( self.var_7c39d1310ec3c31d ) )
    {
        self.var_7c39d1310ec3c31d delete();
        self.var_7c39d1310ec3c31d = undefined;
    }
}

