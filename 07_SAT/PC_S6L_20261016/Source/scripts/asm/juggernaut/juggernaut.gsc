// scripts\asm\juggernaut\juggernaut.gsc  (hash_260be52cab2e0891.gscc) (size: 7345 Bytes / 0x1cb1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x500a21a2 (1342841250)
// size ...... 7345 (0x1cb1)
// includes .. 2   (offset: 0x1b89)
// strings ... 22  (offset: 0x1b99)
// dev strs .. 0   (offset: 0x1cb1)
// exports ... 10  (offset: 0x1265)
// cseg ...... 0x174 + 0x10f1 (0x1265)
// imports ... 58  (offset: 0x13f5)
// animtree1 . 0   (offset: 0x1cb1)
// animtree2 . 0   (offset: 0x1cb1)
#using scripts\asm\asm;
#using scripts\common\utility;

#namespace juggernaut;

// Namespace juggernaut
// Params 1
// Checksum 0x40e5502d, Offset: 0x192
// Size: 0x24
function juggernaut( asmname )
{
    self endon( #"asm_terminated" );
    self endon( #"death" );
}

// Namespace juggernaut
// Params 0
// Checksum 0xcf60a2ec, Offset: 0x1be
// Size: 0x1d7
function enable_casual_killer()
{
    if ( isdefined( self.combatmode ) )
    {
        self.ck_combatmode = self.combatmode;
    }
    
    self setcanusecover( 0 );
    self allowedstances( "stand" );
    self.cautiousnavigation = 1;
    self.dontmeleeme = 1;
    self.dontmelee = 1;
    self.ck_grenadeammo = self.grenadeammo;
    self.grenadeammo = 0;
    self.ck_aggressivemode = istrue( self.aggressivemode );
    self.aggressivemode = 1;
    self.ignoresuppression = 1;
    utility::set_movement_speed( 50 );
    self.turnrate = 0.1;
    self.allowstrafe = 0;
    self.disablepistol = 1;
    self.dontsyncmelee = 1;
    self.disablebulletwhizbyreaction = 1;
    self.neversprintforvariation = 1;
    self.disablerunngun = 1;
    self.casualkiller = 1;
    self.dontgiveuponsuppression = 1;
    self.forcesuppressai = 1;
    self.pathenemyfightdist = 0;
    self.allowlongdeath = 0;
    weapclass = weaponclass( self.weapon );
    self setbasearchetype( "juggernaut" );
    archetypeoverride = "casual_killer";
    
    if ( weapclass == "mg" )
    {
        archetypeoverride = "casual_killer_lmg";
    }
    
    self setoverridearchetype( "demeanor", archetypeoverride, 1 );
    thread casual_killer_targeting();
    
    if ( weapclass == "mg" || weapclass == "rifle" || weapclass == "smg" )
    {
        thread casual_killer_sweep();
    }
    
    if ( weapclass == "rifle" || weapclass == "smg" )
    {
        self.shootstyleoverride = "full";
    }
    
    thread casual_killer_enemy_reaction();
}

// Namespace juggernaut
// Params 0
// Checksum 0x21124e62, Offset: 0x39d
// Size: 0x16
function disable_casual_killer()
{
    if ( !self.leavecasualkiller )
    {
        thread disable_casual_killer_internal();
    }
}

// Namespace juggernaut
// Params 0
// Checksum 0x2d9486, Offset: 0x3bb
// Size: 0x256
function disable_casual_killer_internal()
{
    if ( !isdefined( level.casualkillernewenemyreaction ) || gettime() > level.casualkillernewenemyreaction )
    {
        self.newenemyreactiontime = gettime() + 3000;
        self.newenemyreaction = 1;
        self.forcenewenemyreaction = 1;
    }
    
    self.leavecasualkiller = 1;
    self clearentitytarget();
    self.favoriteenemy = undefined;
    self.gunposeoverride = undefined;
    
    if ( isdefined( self.pathgoalpos ) )
    {
        self setbtgoalpos( 4, self getposonpath( 64 ) );
    }
    
    /#
        if ( getdvarint( @"hash_d7f290f0d986c37", 0 ) == 1 )
        {
            thread function_1263bc50a3a4710d();
        }
    #/
    
    utility::waittill_any( "leaveCasualKiller", "death" );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    self.cautiousnavigation = 0;
    self.dontmeleeme = 0;
    self.grenadeammo = self.ck_grenadeammo;
    
    if ( self.ck_aggressivemode )
    {
        self.aggressivemode = 1;
    }
    
    utility::lookatentity( undefined );
    utility::lookatpos( undefined );
    self.ignoresuppression = 0;
    self.dontmelee = 0;
    self.turnrate = 0.3;
    utility::clear_movement_speed();
    self.disablepistol = 0;
    self.allowstrafe = 1;
    self.dontsyncmelee = undefined;
    self.disablebulletwhizbyreaction = 0;
    self.neversprintforvariation = undefined;
    self.disablerunngun = 0;
    self.casualkiller = 0;
    self.casualkillershootpos = undefined;
    self.pathenemyfightdist = 192;
    self.dontevershoot = 0;
    self.shootstyleoverride = undefined;
    self.dontgiveuponsuppression = undefined;
    self.forcesuppressai = 0;
    self.gunposeoverride = undefined;
    self.aimyawspeed = 0;
    self clearbtgoal( 4 );
    
    if ( isdefined( self.ck_target ) )
    {
        self.ck_target delete();
    }
    
    self.allowlongdeath = 1;
    self allowedstances( "stand", "crouch", "prone" );
    self setcanusecover( 1 );
    
    if ( isdefined( self.ck_combatmode ) )
    {
        self.combatmode = self.ck_combatmode;
        self.ck_combatmode = undefined;
        return;
    }
    
    self.combatmode = "cover";
}

/#

    // Namespace juggernaut
    // Params 0
    // Checksum 0x1eff76fa, Offset: 0x619
    // Size: 0x54, Type: dev
    function function_1263bc50a3a4710d()
    {
        self endon( #"leavecasualkiller" );
        self endon( #"death" );
        
        while ( true )
        {
            sphere( self.origin + ( 0, 0, 60 ), 4, ( 0, 1, 0 ), 0, 1 );
            waitframe();
        }
    }

#/

// Namespace juggernaut
// Params 10
// Checksum 0xf135ea20, Offset: 0x675
// Size: 0x78
function casual_killer_damage_func( damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon )
{
    if ( attacker == level.player )
    {
        self notify( #"hash_c1211aa9d1bb94de" );
    }
}

// Namespace juggernaut
// Params 0
// Checksum 0x98f40f9b, Offset: 0x6f5
// Size: 0x72
function casual_killer_enemy_reaction()
{
    self endon( #"leavecasualkiller" );
    self endon( #"death" );
    
    if ( !isdefined( self.damage_functions ) )
    {
        self.damage_functions = [];
    }
    
    self.damage_functions[ self.damage_functions.size ] = &casual_killer_damage_func;
    self waittill( #"hash_c1211aa9d1bb94de" );
    self.favoriteenemy = undefined;
    self clearentitytarget();
    self setthreatbiasgroup( "axis" );
}

// Namespace juggernaut
// Params 0
// Checksum 0xa732b3e0, Offset: 0x76f
// Size: 0x469
function casual_killer_targeting()
{
    self endon( #"leavecasualkiller" );
    self endon( #"death" );
    wait 1;
    self.ck_target = spawn( "script_origin", self.origin );
    self.ck_target.targetname = "casual_killer_targeting";
    thread utility::delete_on_death( self.ck_target );
    currentenemy = undefined;
    hascurrentenemy = 0;
    enemydeathtime = undefined;
    targetchangetime = undefined;
    
    while ( true )
    {
        waitframe();
        
        if ( !isalive( self ) || self.leavecasualkiller )
        {
            return;
        }
        
        self.gunposeoverride = "disable";
        forward = anglestoforward( self.angles );
        shootfrompos = self getshootfrompos();
        
        if ( hascurrentenemy )
        {
            if ( !isalive( currentenemy ) )
            {
                enemydeathtime = gettime();
                self setentitytarget( self.ck_target );
                self forcethreatupdate();
                hascurrentenemy = 0;
                targetchangetime = undefined;
            }
            else
            {
                self.ck_target.origin = currentenemy.origin;
            }
        }
        
        framecount = int( gettime() / 50 );
        
        if ( self getentitynumber() % 4 != framecount % 4 )
        {
            if ( enemydeathtime + 3000 > gettime() )
            {
                totarget = self.ck_target.origin - self.origin;
                
                if ( length( totarget ) > 100 )
                {
                    totarget = vectornormalize( totarget );
                    angletotarget = abs( angleclamp180( acos( clamp( vectordot( forward, totarget ), -1, 1 ) ) ) );
                    
                    if ( angletotarget > 30 && gettime() < enemydeathtime + 1500 )
                    {
                        continue;
                    }
                    
                    if ( angletotarget < 90 )
                    {
                        continue;
                    }
                }
            }
            
            enemydeathtime = undefined;
            
            if ( !isdefined( targetchangetime ) || gettime() > targetchangetime + 3000 )
            {
                self clearentitytarget();
                self forcethreatupdate();
                
                if ( isalive( self.enemy ) )
                {
                    if ( hascurrentenemy && self.enemy == currentenemy )
                    {
                        potentialtarget = self.enemy;
                        toenemy = self.enemy.origin - self.origin;
                        toenemy = vectornormalize( toenemy );
                        dot = clamp( vectordot( forward, toenemy ), -1, 1 );
                        angletoenemy = abs( angleclamp180( acos( dot ) ) );
                        
                        if ( angletoenemy > 70 )
                        {
                            secondarytargets = self getsecondarytargets();
                            
                            if ( isdefined( secondarytargets ) )
                            {
                                foreach ( secondarytarget in secondarytargets )
                                {
                                    totarget = secondarytarget.origin - self.origin;
                                    totarget = vectornormalize( totarget );
                                    angletotarget = abs( angleclamp180( acos( clamp( vectordot( forward, totarget ), -1, 1 ) ) ) );
                                    
                                    if ( angletotarget < angletoenemy )
                                    {
                                        angletoenemy = angletotarget;
                                        potentialtarget = secondarytarget;
                                    }
                                }
                                
                                if ( potentialtarget != self.enemy )
                                {
                                    if ( issentient( potentialtarget ) )
                                    {
                                        self.favoriteenemy = potentialtarget;
                                        self forcethreatupdate();
                                        self.favoriteenemy = undefined;
                                        targetchangetime = gettime();
                                    }
                                }
                            }
                        }
                    }
                    
                    hascurrentenemy = isalive( self.enemy );
                    
                    if ( hascurrentenemy )
                    {
                        currentenemy = self.enemy;
                    }
                    else
                    {
                        currentenemy = undefined;
                    }
                    
                    continue;
                }
                
                self setentitytarget( self.ck_target );
                self forcethreatupdate();
                
                if ( enemydeathtime + 7000 > gettime() )
                {
                    if ( vectordot( forward, self.ck_target.origin - shootfrompos ) > 0 )
                    {
                        continue;
                    }
                }
                
                self.ck_target.origin = self.origin + ( 0, 0, 40 ) + forward * 400;
            }
        }
    }
}

// Namespace juggernaut
// Params 0
// Checksum 0xbeacef67, Offset: 0xbe0
// Size: 0x685
function casual_killer_sweep()
{
    self endon( #"leavecasualkiller" );
    self endon( #"death" );
    sweepmindistance = 100;
    sweepmaxdistance = 1000;
    sweepangle = 20;
    sweepdirection = -1;
    sweepspeeds = [ 40, 50, 60 ];
    sweepmaxangles = [ 20, 25, 30 ];
    var_9be9dd0506f1d24f = 0;
    var_22fda9bb7f886a8a = 0;
    sweepspeed = utility::array_random( sweepspeeds );
    sweepmaxangle = utility::array_random( sweepmaxangles );
    sweepstoptime = 0;
    shootatpos = undefined;
    lastaim = undefined;
    
    foreach ( maxangle in sweepmaxangles )
    {
        if ( maxangle > var_9be9dd0506f1d24f )
        {
            var_9be9dd0506f1d24f = maxangle;
        }
    }
    
    while ( isalive( self ) )
    {
        waitframe();
        self.leftaimlimit = 90;
        self.rightaimlimit = -90;
        self.aimyawspeed = 180;
        forward = anglestoforward( self.angles );
        shootfrompos = self getshootfrompos();
        
        if ( isdefined( self.enemy ) )
        {
            if ( !isdefined( self.pathgoalpos ) || self.lookaheaddist > self aigetdesiredspeed() )
            {
                shootatpos = self.enemy getshootatpos();
            }
        }
        
        shouldaim = asm::asm_currentstatehasflag( self.asmtrackasm, "aim" ) || asm::asm_currentstatehasflag( self.asmtrackasm, "notetrackAim" );
        
        if ( shouldaim )
        {
            shouldaim = isdefined( shootatpos );
        }
        
        currentstate = asm::asm_getcurrentstate( self.asmname );
        
        if ( currentstate == "exposed_arrival" || currentstate == "exposed_reload" )
        {
            shouldaim = 0;
        }
        
        if ( shouldaim )
        {
            downpathpos = self getposonpath( self aigetdesiredspeed() );
            toshootatpos = shootatpos - downpathpos;
            toshootatpos = ( toshootatpos[ 0 ], toshootatpos[ 1 ], 0 );
            var_fc26a014ea6f1816 = vectornormalize( toshootatpos );
            aimlimit = self.leftaimlimit;
            
            if ( !lastaim )
            {
                aimlimit = max( 0, self.leftaimlimit - 20 );
            }
            
            angletoshootpos = abs( angleclamp180( acos( clamp( vectordot( var_fc26a014ea6f1816, forward ), -1, 1 ) ) ) );
            
            if ( angletoshootpos >= aimlimit )
            {
                shootatpos = undefined;
                sweepstoptime = 0;
                shouldaim = 0;
            }
        }
        
        if ( !shouldaim )
        {
            utility::lookatentity( undefined );
            utility::lookatpos( shootfrompos + forward * 200 );
            self.casualkillershootpos = shootfrompos + forward * 200;
            sweepangle = 20 * sweepdirection;
            sweepdirection *= -1;
            sweepstoptime = 0;
            self.dontevershoot = 1;
            lastaim = 0;
            continue;
        }
        
        lastaim = 1;
        self.dontevershoot = 0;
        
        if ( isdefined( shootatpos ) )
        {
            utility::lookatpos( shootatpos );
            
            /#
                if ( getdvarint( @"hash_d7f290f0d986c37", 0 ) == 1 )
                {
                    line( shootfrompos, shootatpos, ( 1, 0, 0 ), 1, 0, 1 );
                    sphere( shootatpos, 4, ( 1, 0, 0 ), 0, 1 );
                }
            #/
        }
        else
        {
            utility::lookatentity( undefined );
            utility::lookatpos( undefined );
        }
        
        toshootatpos = shootatpos - shootfrompos;
        var_2901b60c4e9c3af4 = length( toshootatpos );
        var_fc26a014ea6f1816 = vectornormalize( toshootatpos );
        angletoshootpos = abs( angleclamp180( acos( clamp( vectordot( forward, var_fc26a014ea6f1816 ), -1, 1 ) ) ) );
        var_41bc1eb5f261e8b4 = axistoangles( var_fc26a014ea6f1816, anglestoright( self.angles ), anglestoup( self.angles ) );
        sweeptargetangle = var_41bc1eb5f261e8b4[ 1 ];
        
        if ( self.leavecasualkiller )
        {
            if ( sweepangle > 0 )
            {
                sweepangle -= min( sweepangle, sweepspeed * level.framedurationseconds );
                sweepdirection = -1;
            }
            else if ( sweepangle < 0 )
            {
                sweepangle += min( sweepangle * -1, sweepspeed * level.framedurationseconds );
                sweepdirection = 1;
            }
        }
        else if ( angletoshootpos + var_9be9dd0506f1d24f < abs( self.leftaimlimit ) && angletoshootpos + var_9be9dd0506f1d24f < abs( self.rightaimlimit ) && var_2901b60c4e9c3af4 > sweepmindistance && ( var_2901b60c4e9c3af4 < sweepmaxdistance || self.enemy == level.player ) )
        {
            if ( gettime() > var_22fda9bb7f886a8a )
            {
                sweepamount = level.framedurationseconds * sweepspeed * sweepdirection;
                sweepangle += sweepamount;
                
                if ( utility::sign( sweepangle ) == utility::sign( sweepdirection ) && abs( sweepangle ) > sweepmaxangle )
                {
                    sweepdirection *= -1;
                    sweepspeed = utility::array_random( sweepspeeds );
                    sweepmaxangle = utility::array_random( sweepmaxangles );
                    var_22fda9bb7f886a8a = gettime() + 350;
                }
            }
            
            sweeptargetangle += sweepangle;
        }
        
        shootangles = axistoangles( var_fc26a014ea6f1816, anglestoright( self.angles ), anglestoup( self.angles ) );
        shootangles = ( shootangles[ 0 ], sweeptargetangle, shootangles[ 2 ] );
        var_fc26a014ea6f1816 = anglestoforward( shootangles );
        self.casualkillershootpos = var_fc26a014ea6f1816 * var_2901b60c4e9c3af4 + shootfrompos;
        
        /#
            if ( getdvarint( @"hash_d7f290f0d986c37", 0 ) == 1 )
            {
                if ( isdefined( self.casualkillershootpos ) )
                {
                    shootfrompos = self getshootfrompos();
                    line( shootfrompos, self.casualkillershootpos, ( 0, 1, 0 ), 1, 0, 1 );
                    sphere( self.casualkillershootpos, 5, ( 0, 1, 0 ), 0, 1 );
                }
            }
            
            if ( getdvarint( @"hash_960706093ece3d0c", 0 ) == 1 )
            {
                sphere( self.origin, sweepmindistance, ( 1, 1, 1 ), 0, 1 );
                sphere( self.origin, sweepmaxdistance, ( 0, 0, 0 ), 0, 1 );
            }
        #/
        
        if ( self.leavecasualkiller && sweepangle == 0 )
        {
            return;
        }
    }
}

