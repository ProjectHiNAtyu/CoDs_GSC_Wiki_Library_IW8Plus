// scripts\asm\track.gsc  (hash_401f827f9ca276d7.gscc) (size: 12606 Bytes / 0x313e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x66f69dc2 (1727438274)
// size ...... 12606 (0x313e)
// includes .. 3   (offset: 0x3026)
// strings ... 15  (offset: 0x303e)
// dev strs .. 1   (offset: 0x3132)
// exports ... 27  (offset: 0x230a)
// cseg ...... 0x113 + 0x21f7 (0x230a)
// imports ... 71  (offset: 0x2742)
// animtree1 . 0   (offset: 0x313e)
// animtree2 . 0   (offset: 0x313e)
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\common\gameskill;

#namespace track;

// Namespace track
// Params 1
// Checksum 0x22a33bee, Offset: 0x131
// Size: 0x38
function track( asmname )
{
    assert( !isdefined( self.asmtrackasm ), "<dev string:x24>" );
    self.asmtrackasm = asmname;
    thread trackloop( asmname );
}

// Namespace track
// Params 4
// Checksum 0xf4a5d5bf, Offset: 0x171
// Size: 0x134
function trackinit( aim_2, aim_4, aim_6, aim_8 )
{
    self.a.aimweight = 1;
    self.a.aimweight_start = 1;
    self.a.aimweight_end = 1;
    self.a.aimweight_transframes = 0;
    self.a.aimweight_t = 0;
    self.asm.track = spawnstruct();
    self.asm.track.aim_2_default = aim_2;
    self.asm.track.aim_4_default = aim_4;
    self.asm.track.aim_6_default = aim_6;
    self.asm.track.aim_8_default = aim_8;
}

/#

    // Namespace track
    // Params 0
    // Checksum 0x997ffc55, Offset: 0x2ad
    // Size: 0xbc, Type: dev
    function laserthread()
    {
        self endon( #"death" );
        self notify( #"laseroff" );
        self endon( #"laseroff" );
        
        while ( true )
        {
            if ( isdefined( self.convergence ) && isdefined( self.convergence.aim_pos ) )
            {
                startpos = getlaserstartpoint();
                dir = vectornormalize( self.convergence.aim_pos - startpos );
                endpos = startpos + dir * 2048;
                line( startpos, endpos, ( 255, 0, 0 ), 1, 1 );
            }
            
            wait 0.05;
        }
    }

#/

// Namespace track
// Params 0
// Checksum 0xc034df0d, Offset: 0x371
// Size: 0x36
function sniperdeathcleanup()
{
    self endon( #"stop_sniper" );
    self waittill( #"death" );
    
    if ( isdefined( self.sniper_laser ) )
    {
        self.sniper_laser delete();
    }
}

// Namespace track
// Params 0
// Checksum 0x1b0c9f9f, Offset: 0x3af
// Size: 0x7e
function sniperlaserhackstop()
{
    if ( isdefined( self.sniper_laser ) )
    {
        self notify( #"stop_sniper" );
        
        if ( isdefined( self.fnlaseroff ) )
        {
            self.sniper_laser [[ self.fnlaseroff ]]();
        }
        
        self.sniper_laser delete();
        self.sniper_laser = undefined;
        self.bhaslasertag = undefined;
        
        if ( isdefined( self.fnsetlaserflag ) )
        {
            self [[ self.fnsetlaserflag ]]( "none" );
        }
    }
}

// Namespace track
// Params 0
// Checksum 0x4faff87a, Offset: 0x435
// Size: 0x63, Type: bool
function shoulduselasertag()
{
    if ( !( isdefined( self.weapon ) && isdefined( self.weapon.basenamehash ) ) )
    {
        return false;
    }
    
    switch ( self.weapon.basenamehash )
    {
        case %"iw7_m8":
            return true;
        default:
            break;
    }
    
    return false;
}

// Namespace track
// Params 0
// Checksum 0x7bed89c4, Offset: 0x4a1
// Size: 0x8e
function getlaserstartpoint()
{
    if ( !isdefined( self.bhaslasertag ) )
    {
        if ( shoulduselasertag() )
        {
            tag_laser_origin = self gettagorigin( "tag_laser", 1 );
            
            if ( isdefined( tag_laser_origin ) )
            {
                self.bhaslasertag = 1;
                return tag_laser_origin;
            }
        }
        
        self.bhaslasertag = 0;
    }
    else if ( self.bhaslasertag )
    {
        if ( !shoulduselasertag() )
        {
            self.bhaslasertag = 0;
        }
    }
    
    if ( self.bhaslasertag )
    {
        return self gettagorigin( "tag_laser" );
    }
    
    return self getmuzzlepos();
}

// Namespace track
// Params 0
// Checksum 0xe7aa8cad, Offset: 0x538
// Size: 0x7
function getlaserdirection()
{
    return self getmuzzledir();
}

// Namespace track
// Params 0
// Checksum 0x69c6aac9, Offset: 0x548
// Size: 0x7
function getlaserangles()
{
    return self getmuzzleangle();
}

// Namespace track
// Params 0
// Checksum 0x9c277d72, Offset: 0x558
// Size: 0x22e
function sniperlaserhackstart()
{
    if ( isdefined( self.sniper_laser ) )
    {
        return;
    }
    
    thread sniperdeathcleanup();
    muzzlepos = getlaserstartpoint();
    self.sniper_laser = spawn( "script_model", muzzlepos );
    self.sniper_laser setmodel( "tag_laser" );
    self.sniper_laser setmoverlaserweapon( self.weapon );
    self.sniper_laser setotherent( self );
    self.sniper_laser.origin = muzzlepos;
    
    if ( !isdefined( self.var_216497b1ab46d9d4 ) )
    {
        self.var_216497b1ab46d9d4 = 0.996;
    }
    
    if ( isdefined( self.fnsetlaserflag ) )
    {
        self [[ self.fnsetlaserflag ]]( "interpolate" );
    }
    
    if ( isdefined( self.fnlaseron ) )
    {
        self.sniper_laser [[ self.fnlaseron ]]();
    }
    
    assert( isdefined( self.convergence ) );
    
    while ( isalive( self ) && isdefined( self.sniper_laser ) )
    {
        if ( isdefined( self.convergence ) && isdefined( self.convergence.aim_pos ) )
        {
            muzzlepos = getlaserstartpoint();
            self.sniper_laser.origin = muzzlepos;
            desiredaimpos = self.convergence.aim_pos;
            desireddir = vectornormalize( desiredaimpos - muzzlepos );
            muzzledir = getlaserdirection();
            desireddir = vectornormalize( ( desireddir[ 0 ], desireddir[ 1 ], 0 ) );
            muzzledir = vectornormalize( ( muzzledir[ 0 ], muzzledir[ 1 ], 0 ) );
            dot = vectordot( desireddir, muzzledir );
            
            if ( dot < self.var_216497b1ab46d9d4 )
            {
                self.sniper_laser.angles = getlaserangles();
            }
            else
            {
                self.sniper_laser.angles = vectortoangles( self.convergence.aim_pos - self.sniper_laser.origin );
            }
        }
        
        waitframe();
    }
}

// Namespace track
// Params 0
// Checksum 0xb689a4d0, Offset: 0x78e
// Size: 0x22
function trackturnofflaser()
{
    if ( self.var_a3c852607ea89f1c )
    {
        return;
    }
    
    sniperlaserhackstop();
    self notify( #"sniper_laser_off" );
}

// Namespace track
// Params 0
// Checksum 0x5f0b01c2, Offset: 0x7b8
// Size: 0x30
function trackturnonlaser()
{
    if ( self.var_a3c852607ea89f1c )
    {
        return;
    }
    
    if ( !isdefined( self.sniper_laser ) )
    {
        thread sniperlaserhackstart();
        self notify( #"sniper_laser_on" );
    }
}

// Namespace track
// Params 0
// Checksum 0x94de6fcf, Offset: 0x7f0
// Size: 0x16
function clearconvergence()
{
    self.convergence = undefined;
    self.convergencevalid = 0;
}

// Namespace track
// Params 3
// Checksum 0xfd020c2, Offset: 0x80e
// Size: 0x4fe
function resetconvergence( bnewtarget, var_71c8361e3f0ada65, bretarget )
{
    if ( !isdefined( self.convergence ) )
    {
        self.convergence = spawnstruct();
        self.convergencevalid = 1;
    }
    
    self.var_fb0143e83e5e5130 = 0;
    self.convergence.target = self._blackboard.shootparams_ent;
    self.convergence.converge_missouterradius = 96;
    
    if ( isdefined( self.var_f02832c5a47a9c46 ) )
    {
        self.convergence.converge_time = self [[ self.var_f02832c5a47a9c46 ]]( bnewtarget, bretarget );
    }
    else if ( bnewtarget )
    {
        self.convergence.converge_time = 1500;
    }
    else if ( bretarget )
    {
        self.convergence.converge_time = 1500;
    }
    else
    {
        self.convergence.converge_time = 2000;
    }
    
    if ( isdefined( self.fnsetlaserflag ) )
    {
        self [[ self.fnsetlaserflag ]]( "interpolate" );
    }
    
    currentskill = gameskill::get_skill_from_index( level.gameskill );
    convergencemultiplier = level.difficultysettings[ "sniper_converge_scale" ][ currentskill ];
    
    if ( isdefined( convergencemultiplier ) )
    {
        self.convergence.converge_time = int( self.convergence.converge_time * convergencemultiplier );
    }
    
    if ( isdefined( level.sniper_convergence_time_multiplier ) )
    {
        self.convergence.converge_time *= level.sniper_convergence_time_multiplier;
    }
    
    self.convergence.converge_missinnerradius = 0;
    self.convergencelockdurationbeforefiring = 750;
    self.convergencelockedontime = -1;
    
    /#
        if ( getdvarint( @"hash_75e9120fb2fd5fc3", 0 ) )
        {
            self._blackboard.shootparams_converge_time = 500;
        }
    #/
    
    if ( !isdefined( self.sniper_laser ) )
    {
        self.convergencecurtime = -1500;
    }
    else
    {
        self.convergencecurtime = 0;
    }
    
    self.convergenceshoottime = int( self.convergence.converge_time + 1000 );
    self.convergence.converge_laserofftime = self.convergenceshoottime + 500;
    
    if ( isdefined( self._blackboard.shootparams_pos ) )
    {
        convergestartpos = undefined;
        targetvel = undefined;
        
        if ( isdefined( self.var_3286b038969f2eed ) )
        {
            convergestartpos = self [[ self.var_3286b038969f2eed ]]( self._blackboard.shootparams_ent, bretarget );
        }
        else if ( isdefined( var_71c8361e3f0ada65 ) )
        {
            convergestartpos = var_71c8361e3f0ada65;
        }
        else
        {
            if ( isdefined( self._blackboard.shootparams_ent ) )
            {
                targetpos = self._blackboard.shootparams_ent.origin;
                
                if ( isplayer( self._blackboard.shootparams_ent ) )
                {
                    targetvel = self._blackboard.shootparams_ent getvelocity();
                    
                    if ( targetvel == ( 0, 0, 0 ) )
                    {
                        targetvel = undefined;
                    }
                }
            }
            else
            {
                targetpos = self._blackboard.shootparams_pos - ( 0, 0, 70 );
            }
            
            targetdelta = targetpos - self.origin;
            targetdelta = ( targetdelta[ 0 ], targetdelta[ 1 ], 0 );
            targetdir = vectornormalize( targetdelta );
            
            if ( bretarget )
            {
                convergestartpos = targetpos;
                convergestartpos += ( 0, 0, randomfloatrange( 12, 36 ) );
            }
            else
            {
                convergestartpos = targetpos - targetdir * randomfloatrange( 120, 180 );
            }
            
            targetleft = vectorcross( targetdir, ( 0, 0, 1 ) );
            var_98b74c00fc379f22 = randomfloatrange( 6, 36 );
            
            if ( bretarget )
            {
                var_98b74c00fc379f22 = randomfloatrange( 12, 24 );
            }
            
            if ( isdefined( targetvel ) )
            {
                dot = vectordot( targetvel, targetleft );
                
                if ( dot < 0 )
                {
                    convergestartpos += targetleft * var_98b74c00fc379f22;
                }
                else
                {
                    convergestartpos -= targetleft * var_98b74c00fc379f22;
                }
            }
            else if ( randomintrange( 0, 2 ) )
            {
                convergestartpos += targetleft * var_98b74c00fc379f22;
            }
            else
            {
                convergestartpos -= targetleft * var_98b74c00fc379f22;
            }
        }
        
        self.convergence.converge_offsetdir = vectornormalize( convergestartpos - self._blackboard.shootparams_pos );
        self.convergence.converge_missouterradius = distance( convergestartpos, self._blackboard.shootparams_pos );
    }
}

// Namespace track
// Params 0
// Checksum 0x7e1cc78d, Offset: 0xd14
// Size: 0x390
function calcconvergencetarget()
{
    assert( isdefined( self._blackboard.shootparams_pos ) );
    
    if ( self.convergencelockedontime >= 0 && gettime() - self.convergencelockedontime >= 100 )
    {
        if ( isplayer( self._blackboard.shootparams_ent ) )
        {
            if ( isdefined( self.fnsetlaserflag ) )
            {
                self [[ self.fnsetlaserflag ]]( "lock" );
            }
        }
        else if ( isdefined( self.fnsetlaserflag ) )
        {
            self [[ self.fnsetlaserflag ]]( "interpolate" );
        }
        
        if ( isdefined( self.var_2ceec36fb1f617b9 ) )
        {
            return self [[ self.var_2ceec36fb1f617b9 ]]( self._blackboard.shootparams_pos - ( 0, 0, 1.3 ), self.convergence.aim_pos );
        }
        
        return ( self._blackboard.shootparams_pos - ( 0, 0, 1.3 ) );
    }
    
    metotarget = vectornormalize( self._blackboard.shootparams_pos - self.origin );
    anglesmetotarget = vectortoangles( metotarget );
    
    if ( self.convergencecurtime < 0 )
    {
        if ( isdefined( self.fnsetlaserflag ) )
        {
            self [[ self.fnsetlaserflag ]]( "interpolate" );
        }
        
        shootpos = self._blackboard.shootparams_pos + self.convergence.converge_offsetdir * self.convergence.converge_missouterradius;
        return shootpos;
    }
    
    targetvel = ( 0, 0, 0 );
    
    if ( isplayer( self._blackboard.shootparams_ent ) )
    {
        targetvel = self._blackboard.shootparams_ent getvelocity();
    }
    
    var_3476dcabc472f190 = 0.75;
    predpos = self._blackboard.shootparams_pos + targetvel * var_3476dcabc472f190;
    f = ( self.convergence.converge_time - self.convergencecurtime ) / self.convergence.converge_time;
    
    if ( self.convergencecurtime >= self.convergence.converge_time )
    {
        f = 0;
    }
    
    foffset = f * ( self.convergence.converge_missouterradius - self.convergence.converge_missinnerradius ) + self.convergence.converge_missinnerradius;
    var_dad5bebba8e38e6e = self._blackboard.shootparams_pos + self.convergence.converge_offsetdir * foffset;
    shootpos = var_dad5bebba8e38e6e + ( predpos - var_dad5bebba8e38e6e ) * 0.2;
    
    if ( isdefined( self.var_2ceec36fb1f617b9 ) )
    {
        shootpos = self [[ self.var_2ceec36fb1f617b9 ]]( shootpos, self.convergence.aim_pos );
    }
    
    if ( isplayer( self._blackboard.shootparams_ent ) )
    {
        if ( isdefined( self.fnsetlaserflag ) )
        {
            self [[ self.fnsetlaserflag ]]( "interpolate" );
        }
    }
    
    return shootpos;
}

// Namespace track
// Params 1
// Checksum 0xe074cb90, Offset: 0x10ad
// Size: 0x4a
function turnlaserbackon( waittime )
{
    self endon( #"death" );
    wait waittime;
    
    if ( isdefined( self.sniper_laser ) )
    {
        if ( isdefined( self.fnlaseron ) )
        {
            self.sniper_laser [[ self.fnlaseron ]]();
        }
    }
}

// Namespace track
// Params 0
// Checksum 0xf5a80e96, Offset: 0x10ff
// Size: 0x404
function convergencetargettick()
{
    bcansee = 1;
    bnewtarget = 0;
    
    if ( isdefined( self._blackboard.shootparams_ent ) )
    {
        bcansee = self cansee( self._blackboard.shootparams_ent );
        
        if ( isdefined( self.convergence ) && isdefined( self.convergence.target ) && self.convergence.target != self._blackboard.shootparams_ent )
        {
            bnewtarget = 1;
        }
        
        if ( bcansee )
        {
            asm_bb::bb_updateshootparams_pos( self._blackboard.shootparams_ent getshootatpos() );
        }
    }
    
    if ( !isdefined( self.convergence ) || bnewtarget )
    {
        resetconvergence( bnewtarget );
    }
    else if ( bcansee && !self.convergence.bhaslos )
    {
        if ( isdefined( self.convergence.aim_pos ) && distancesquared( self.convergence.aim_pos, self._blackboard.shootparams_pos ) < 3600 )
        {
            resetconvergence( bnewtarget, undefined, 1 );
        }
        else
        {
            resetconvergence( bnewtarget );
        }
    }
    else if ( self.var_fb0143e83e5e5130 )
    {
        if ( isdefined( self.fnsetlaserflag ) )
        {
            self [[ self.fnsetlaserflag ]]( "interpolate" );
        }
        
        self.var_fb0143e83e5e5130 = 0;
        
        if ( isplayer( self._blackboard.shootparams_ent ) && self cansee( self._blackboard.shootparams_ent ) )
        {
            resetconvergence( bnewtarget, undefined, 1 );
        }
    }
    
    self.convergence.bhaslos = bcansee;
    var_96f4b7357f4020bc = 1;
    muzzlepos = getlaserstartpoint();
    desiredaimpos = calcconvergencetarget();
    desireddir = vectornormalize( desiredaimpos - muzzlepos );
    muzzledir = self getmuzzledir();
    var_a13efb4c4fd01f82 = 0.984;
    var_69571d2ff020de55 = 0.996;
    
    if ( isdefined( self.var_3378578f4e0d4419 ) )
    {
        var_a13efb4c4fd01f82 = self.var_3378578f4e0d4419;
    }
    
    if ( isdefined( self.var_94802625f4a528b0 ) )
    {
        var_69571d2ff020de55 = self.var_94802625f4a528b0;
    }
    
    if ( self.convergencecurtime < 0 )
    {
        if ( !isaiming() )
        {
            return 0;
        }
        
        self.convergencecurtime += 50;
        fulldot = vectordot( desireddir, muzzledir );
        
        if ( fulldot < var_a13efb4c4fd01f82 )
        {
            return 0;
        }
        
        desireddir = vectornormalize( ( desireddir[ 0 ], desireddir[ 1 ], 0 ) );
        muzzledir = vectornormalize( ( muzzledir[ 0 ], muzzledir[ 1 ], 0 ) );
        dot = vectordot( desireddir, muzzledir );
        
        if ( dot < var_69571d2ff020de55 )
        {
            return 0;
        }
        
        self.convergencecurtime = 0;
    }
    else
    {
        self.convergencecurtime += 50;
        fulldot = vectordot( desireddir, muzzledir );
        
        if ( fulldot < var_a13efb4c4fd01f82 )
        {
            var_96f4b7357f4020bc = 0;
        }
        
        desireddir = vectornormalize( ( desireddir[ 0 ], desireddir[ 1 ], 0 ) );
        muzzledir = vectornormalize( ( muzzledir[ 0 ], muzzledir[ 1 ], 0 ) );
        dot = vectordot( desireddir, muzzledir );
        
        if ( dot < var_69571d2ff020de55 )
        {
            var_96f4b7357f4020bc = 0;
        }
    }
    
    if ( self.convergencecurtime >= self.convergence.converge_time )
    {
        if ( isdefined( self._blackboard.shootparams_ent ) )
        {
            if ( self.convergencelockedontime < 0 )
            {
                if ( bcansee )
                {
                    self.convergencelockedontime = gettime();
                }
            }
            else if ( gettime() >= self.convergencelockedontime + 200 )
            {
                if ( !self.convergence.bhaslos )
                {
                    self.convergencelockedontime = -1;
                }
            }
        }
    }
    
    return var_96f4b7357f4020bc;
}

// Namespace track
// Params 0
// Checksum 0xe6b8498d, Offset: 0x150c
// Size: 0x14, Type: bool
function issniperconverging()
{
    if ( !isdefined( self.convergence ) )
    {
        return false;
    }
    
    return true;
}

// Namespace track
// Params 0
// Checksum 0x7c608a7f, Offset: 0x1529
// Size: 0x13, Type: bool
function issniperlaseron()
{
    if ( isdefined( self.sniper_laser ) )
    {
        return true;
    }
    
    return false;
}

// Namespace track
// Params 0
// Checksum 0x6f094892, Offset: 0x1545
// Size: 0x62, Type: bool
function isaiming()
{
    if ( !isdefined( self.asm.aimstarttime ) )
    {
        return false;
    }
    
    aimblendtimems = 100;
    aimblendtimems *= 2;
    time = gettime();
    
    if ( self.asm.aimstarttime + aimblendtimems < time )
    {
        return true;
    }
    
    return false;
}

// Namespace track
// Params 1
// Checksum 0xf89415fb, Offset: 0x15b0
// Size: 0x6df
function trackloop( asmname )
{
    self endon( #"asm_terminated" );
    self endon( #"death" );
    self.asm.prevyawdelta = 0;
    self.asm.prevpitchdelta = 0;
    firstframe = 1;
    var_ea41910ad5f18460 = 0;
    var_12b8597189f6fb0 = 0;
    var_b3bc44085ecea30c = 10;
    
    while ( true )
    {
        self waittill( #"hash_53f946c14d3cdd9f" );
        
        if ( !isdefined( self.asm.track ) )
        {
            knobaim2 = asm::asm_lookupanimfromaliasifexists( "knobs", "aim_2" );
            
            if ( !isdefined( knobaim2 ) )
            {
                continue;
            }
            
            aim2 = asm::asm_getxanim( "knobs", asm::asm_lookupanimfromalias( "knobs", "aim_2" ) );
            aim4 = asm::asm_getxanim( "knobs", asm::asm_lookupanimfromalias( "knobs", "aim_4" ) );
            aim6 = asm::asm_getxanim( "knobs", asm::asm_lookupanimfromalias( "knobs", "aim_6" ) );
            aim8 = asm::asm_getxanim( "knobs", asm::asm_lookupanimfromalias( "knobs", "aim_8" ) );
            trackinit( aim2, aim4, aim6, aim8 );
        }
        
        self.var_4dbb0a761e386d79 = 1;
        
        for ( ;; )
        {
            if ( !isdefined( self.asmtrackasm ) || self asmcurrentstatehasaimset( self.asmtrackasm ) && !self aiissniper() )
            {
                self.var_4dbb0a761e386d79 = 0;
                break;
            }
            
            if ( self.var_6dbaed80d7963095 )
            {
                self.var_6dbaed80d7963095 = undefined;
                self.var_4dbb0a761e386d79 = 0;
                break;
            }
            
            incranimaimweight();
            shouldaim = asm::asm_currentstatehasflag( self.asmtrackasm, "aim" );
            
            if ( shouldaim && self function_a62d6fc00d9d45ff() )
            {
                shouldaim = 0;
            }
            
            if ( !shouldaim && asm::asm_currentstatehasflag( self.asmtrackasm, "notetrackAim" ) )
            {
                shouldaim = asm::asm_eventfired( self.asmtrackasm, "start_aim" );
            }
            
            if ( !shouldaim || !self._blackboard.shootparams_valid )
            {
                if ( !shouldaim && isdefined( self.convergence ) )
                {
                    clearconvergence();
                }
                
                trackturnofflaser();
                self.asm.aimstarttime = undefined;
            }
            else if ( !isdefined( self.asm.aimstarttime ) )
            {
                self.asm.aimstarttime = gettime();
            }
            
            /#
                if ( isdefined( level.aimtestangles ) )
                {
                    shouldaim = 1;
                }
            #/
            
            var_7fe14438feac8b4c = 0;
            angledeltas = ( 0, 0, 0 );
            shootposresult = undefined;
            shootfrompos = undefined;
            
            if ( shouldaim )
            {
                if ( self bb_shootparamsvalid() && isdefined( self._blackboard.shootparams_pos ) )
                {
                    if ( isdefined( self.var_6a51558812dfe183 ) && self._blackboard.shootparams_bconvergeontarget )
                    {
                        self [[ self.var_6a51558812dfe183 ]]();
                    }
                    else if ( self._blackboard.shootparams_bconvergeontarget && !self.var_8d6f2c13572743d6 )
                    {
                        var_96f4b7357f4020bc = convergencetargettick();
                        shootpos = calcconvergencetarget();
                        assert( isdefined( self.convergence ) );
                        self.convergence.aim_pos = shootpos;
                        
                        if ( var_96f4b7357f4020bc && !self.var_55cfe9b6599e7834 )
                        {
                            trackturnonlaser();
                        }
                        else
                        {
                            trackturnofflaser();
                        }
                    }
                    else
                    {
                        trackturnofflaser();
                    }
                }
                else
                {
                    trackturnofflaser();
                }
            }
            else if ( abs( self.asm.prevyawdelta ) < 5 && abs( self.asm.prevpitchdelta ) < 5 )
            {
                self setaimangles( ( 0, 0, 0 ) );
                self setaimstate( 3 );
                self.baimedataimtarget = 0;
                waitframe();
                continue;
            }
            
            /#
                if ( isdefined( level.aimtestangles ) )
                {
                    angledeltas = level.aimtestangles;
                    self.asm.prevyawdelta = angledeltas[ 1 ];
                    self.asm.prevpitchdelta = angledeltas[ 0 ];
                }
            #/
            
            if ( self asmcurrentstatehasaimset( self.asmtrackasm ) )
            {
                waitframe();
                continue;
            }
            
            if ( self.runngun )
            {
                waitframe();
                continue;
            }
            
            angledeltas = self getaimangle();
            pitchdelta = angledeltas[ 0 ];
            yawdelta = angledeltas[ 1 ];
            angledeltas = undefined;
            
            if ( var_12b8597189f6fb0 > 0 )
            {
                var_12b8597189f6fb0 -= 1;
                var_b3bc44085ecea30c = max( 10, var_b3bc44085ecea30c - 5 );
            }
            else if ( self.relativedir && self.relativedir != var_ea41910ad5f18460 )
            {
                var_12b8597189f6fb0 = 2;
                var_b3bc44085ecea30c = 30;
            }
            else if ( self aiissniper() )
            {
                var_b3bc44085ecea30c = 2;
            }
            else if ( var_7fe14438feac8b4c )
            {
                var_b3bc44085ecea30c = 5;
            }
            else
            {
                var_b3bc44085ecea30c = 10;
            }
            
            var_e8881dfea68d1478 = 4;
            var_ea41910ad5f18460 = self.relativedir;
            var_88bdb34137425730 = self.movemode != "stop" || !firstframe;
            
            if ( var_88bdb34137425730 )
            {
                yawdeltachange = yawdelta - self.asm.prevyawdelta;
                
                if ( squared( yawdeltachange ) > var_e8881dfea68d1478 )
                {
                    var_d501d62ea0b1eefc = yawdeltachange * 0.4;
                    yawdelta = self.asm.prevyawdelta + clamp( var_d501d62ea0b1eefc, -1 * var_b3bc44085ecea30c, var_b3bc44085ecea30c );
                    yawdelta = clamp( yawdelta, self.rightaimlimit, self.leftaimlimit );
                }
                
                pitchdeltachange = pitchdelta - self.asm.prevpitchdelta;
                
                if ( squared( pitchdeltachange ) > var_e8881dfea68d1478 )
                {
                    var_f955d52b1adeb393 = pitchdeltachange * 0.4;
                    pitchdelta = self.asm.prevpitchdelta + clamp( var_f955d52b1adeb393, -1 * var_b3bc44085ecea30c, var_b3bc44085ecea30c );
                    pitchdelta = clamp( pitchdelta, self.upaimlimit, self.downaimlimit );
                }
            }
            
            firstframe = 0;
            self.asm.prevyawdelta = yawdelta;
            self.asm.prevpitchdelta = pitchdelta;
            trackloop_setanimweights( pitchdelta, yawdelta );
            wait 0.05;
        }
    }
}

// Namespace track
// Params 0
// Checksum 0x27670737, Offset: 0x1c97
// Size: 0x8d
function trackloop_restoreaim()
{
    if ( !isdefined( self.asm.prevyawdelta ) )
    {
        return;
    }
    
    yawdelta = clamp( self.asm.prevyawdelta, self.rightaimlimit, self.leftaimlimit );
    pitchdelta = clamp( self.asm.prevpitchdelta, self.upaimlimit, self.downaimlimit );
    trackloop_setanimweights( pitchdelta, yawdelta );
}

// Namespace track
// Params 0
// Checksum 0xe8ad6e54, Offset: 0x1d2c
// Size: 0x5d
function getcurrentpoi()
{
    if ( self.assigncurrentpoi )
    {
        if ( isdefined( self.cqb_point_of_interest ) )
        {
            self.cqb_point_of_interest.lastusedtime = self.poi_starttime;
        }
        
        self.currentpoi = self.cqb_point_of_interest;
        self.assigncurrentpoi = 0;
    }
    
    return self.currentpoi;
}

// Namespace track
// Params 2
// Checksum 0x7b8c9e8c, Offset: 0x1d92
// Size: 0x393
function trackloop_setanimweights( pitchdelta, yawdelta )
{
    aim_5 = undefined;
    
    if ( isdefined( self.asm.track.aim_2 ) )
    {
        aim_2 = self.asm.track.aim_2;
        aim_4 = self.asm.track.aim_4;
        aim_6 = self.asm.track.aim_6;
        aim_8 = self.asm.track.aim_8;
    }
    else
    {
        aim_2 = self.asm.track.aim_2_default;
        aim_4 = self.asm.track.aim_4_default;
        aim_6 = self.asm.track.aim_6_default;
        aim_8 = self.asm.track.aim_8_default;
    }
    
    if ( isdefined( self.asm.track.aim_5 ) )
    {
        aim_5 = self.asm.track.aim_5;
    }
    
    weight2 = 0;
    weight4 = 0;
    weight5 = 0;
    weight6 = 0;
    weight8 = 0;
    yawdelta = clamp( yawdelta, self.rightaimlimit, self.leftaimlimit );
    pitchdelta = clamp( pitchdelta, self.upaimlimit, self.downaimlimit );
    
    if ( yawdelta < 0 )
    {
        weight6 = yawdelta / self.rightaimlimit * self.a.aimweight;
        weight5 = 1;
    }
    else if ( yawdelta > 0 )
    {
        weight4 = yawdelta / self.leftaimlimit * self.a.aimweight;
        weight5 = 1;
    }
    
    if ( pitchdelta < 0 )
    {
        weight8 = pitchdelta / self.upaimlimit * self.a.aimweight;
        weight5 = 1;
    }
    else if ( pitchdelta > 0 )
    {
        weight2 = pitchdelta / self.downaimlimit * self.a.aimweight;
        weight5 = 1;
    }
    
    self aisetanimlimited( aim_2, weight2, 0.1, 1, 1 );
    self aisetanimlimited( aim_4, weight4, 0.1, 1, 1 );
    self aisetanimlimited( aim_6, weight6, 0.1, 1, 1 );
    self aisetanimlimited( aim_8, weight8, 0.1, 1, 1 );
    
    if ( isdefined( aim_5 ) )
    {
        self aisetanimlimited( aim_5, weight5, 0.1, 1, 1 );
    }
    
    /#
        if ( isdefined( level.aimtestangles ) )
        {
            self aisetanimlimited( aim_2, weight2, 0, 1, 1 );
            self aisetanimlimited( aim_4, weight4, 0, 1, 1 );
            self aisetanimlimited( aim_6, weight6, 0, 1, 1 );
            self aisetanimlimited( aim_8, weight8, 0, 1, 1 );
            
            if ( isdefined( aim_5 ) )
            {
                self aisetanimlimited( aim_5, weight5, 0, 1, 1 );
            }
        }
    #/
}

// Namespace track
// Params 2
// Checksum 0x8b7ba2d1, Offset: 0x212d
// Size: 0x118
function setanimaimweight( goalweight, goaltime )
{
    if ( !isdefined( goaltime ) || goaltime <= 0 )
    {
        self.a.aimweight = goalweight;
        self.a.aimweight_start = goalweight;
        self.a.aimweight_end = goalweight;
        self.a.aimweight_transframes = 0;
    }
    else
    {
        if ( !isdefined( self.a.aimweight ) )
        {
            self.a.aimweight = 0;
        }
        
        self.a.aimweight_start = self.a.aimweight;
        self.a.aimweight_end = goalweight;
        self.a.aimweight_transframes = int( goaltime * 20 );
    }
    
    self.a.aimweight_t = 0;
}

// Namespace track
// Params 0
// Checksum 0x2d53ef18, Offset: 0x224d
// Size: 0xbd
function incranimaimweight()
{
    if ( self.a.aimweight_t < self.a.aimweight_transframes )
    {
        self.a.aimweight_t++;
        t = 1 * self.a.aimweight_t / self.a.aimweight_transframes;
        self.a.aimweight = self.a.aimweight_start * ( 1 - t ) + self.a.aimweight_end * t;
    }
}

