// scripts\asm\soldier\melee.gsc  (hash_473fb7b284cf9edd.gscc) (size: 8399 Bytes / 0x20cf / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa3a2c26d (2745352813)
// size ...... 8399 (0x20cf)
// includes .. 7   (offset: 0x1fc3)
// strings ... 15  (offset: 0x1ffb)
// dev strs .. 1   (offset: 0x20c3)
// exports ... 30  (offset: 0x131b)
// cseg ...... 0x14e + 0x11cd (0x131b)
// imports ... 69  (offset: 0x17cb)
// animtree1 . 0   (offset: 0x20cf)
// animtree2 . 0   (offset: 0x20cf)
#using scripts\anim\face;
#using scripts\anim\notetracks;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\soldier\death;
#using scripts\common\utility;
#using scripts\common\values;

#namespace melee;

// Namespace melee
// Params 4
// Checksum 0xfed2114b, Offset: 0x16c
// Size: 0x3d, Type: bool
function ischargetoreadycomplete( asmname, statename, tostatename, params )
{
    return self.in_melee && self.var_bd31427a8e773e7;
}

// Namespace melee
// Params 1
// Checksum 0xa2f5cd05, Offset: 0x1b2
// Size: 0xa5
function playmeleeanim_chargetoready_distcheck( statename )
{
    self endon( statename + "_finished" );
    
    if ( self.isdog )
    {
        var_95979b010c60d2ef = 40000;
    }
    else
    {
        var_95979b010c60d2ef = 4900;
    }
    
    target = asm_bb::bb_getmeleetarget();
    
    while ( true )
    {
        if ( !isdefined( target ) )
        {
            break;
        }
        
        distsq = distancesquared( self.origin, target.origin );
        
        if ( distsq <= var_95979b010c60d2ef )
        {
            if ( self.in_melee )
            {
                self.var_bd31427a8e773e7 = 1;
            }
            
            break;
        }
        
        wait 0.05;
    }
}

// Namespace melee
// Params 3
// Checksum 0x78901ee5, Offset: 0x25f
// Size: 0xdb
function donotetracks_vsplayer( asmname, statename, optionalhandler )
{
    while ( true )
    {
        self waittill( statename, notes );
        
        if ( !isarray( notes ) )
        {
            notes = [ notes ];
        }
        
        foreach ( note in notes )
        {
            breturn = handlenotetrack_vsplayer( asmname, statename, note );
            
            if ( breturn )
            {
                return;
            }
            
            if ( isdefined( optionalhandler ) )
            {
                self [[ optionalhandler ]]( note, statename );
            }
        }
    }
}

// Namespace melee
// Params 3
// Checksum 0x6cf5197a, Offset: 0x342
// Size: 0x140
function handlenotetrack_vsplayer( asmname, statename, note )
{
    switch ( note )
    {
        case #"hash_da2c994ab2c9478c":
            target = asm_bb::bb_getmeleetarget();
            
            if ( isdefined( target ) )
            {
                self function_caf59404500cec3( target );
            }
            
            break;
        case #"hash_ed49946bfff8e78a":
            return 1;
        case #"hash_23d3b48a2fabf145":
            target = asm_bb::bb_getmeleetarget();
            
            if ( !isdefined( target ) )
            {
                return 1;
            }
            
            if ( !isalive( target ) )
            {
                return 1;
            }
            
            if ( !isdefined( self.enemy ) || self.enemy != target )
            {
                return 1;
            }
            
            disttotargetsq = distancesquared( target.origin, self.origin );
            stopattackdistsq = 4096;
            
            if ( isdefined( self.meleestopattackdistsq ) )
            {
                stopattackdistsq = self.meleestopattackdistsq;
            }
            
            if ( disttotargetsq > stopattackdistsq )
            {
                return 1;
            }
            
            break;
        case #"hash_ceb098150f024a39":
            target = asm_bb::bb_getmeleetarget();
            function_868803d6a9a2f26d( target, 1, undefined, 0 );
            break;
        default:
            return notetracks::handlenotetrack( note, statename );
    }
}

// Namespace melee
// Params 4
// Checksum 0x4876492d, Offset: 0x48a
// Size: 0x441
function function_868803d6a9a2f26d( target, var_8e1614f2e8188bad, meleedirection, ismeleeswipe )
{
    if ( !isdefined( target ) )
    {
        return 1;
    }
    
    if ( isalive( target ) )
    {
        if ( isplayer( target ) )
        {
            if ( self.meleeignorefinalzdiff )
            {
                distsq = distance2dsquared( target.origin, self.origin );
            }
            else
            {
                distsq = distancesquared( target.origin, self.origin );
            }
            
            maxdistsq = 4096;
            
            if ( isdefined( self.meleebashmaxdistsq ) )
            {
                maxdistsq = self.meleebashmaxdistsq;
            }
            
            if ( ismeleeswipe || distsq <= maxdistsq )
            {
                damageoverride = self.meleedamageoverride;
                width = undefined;
                height = undefined;
                meleepower = 30;
                earthquakepower = 0.45;
                earthquakeduration = 0.35;
                shieldactive = isdefined( target.offhandshield ) && target.offhandshield.active;
                
                if ( isnullweapon( self.weapon ) )
                {
                    damageoverride = self.unarmedmeleedamageoverride;
                }
                
                if ( shieldactive )
                {
                    meleepower = 10;
                    earthquakepower = 0.7;
                    earthquakeduration = 0.5;
                    setsaveddvar( @"player_meleedamagemultiplier", 0.05 );
                }
                
                if ( isdefined( self.meleepoweroverride ) )
                {
                    meleepower = self.meleepoweroverride;
                }
                
                overrideenemy = undefined;
                dist = sqrt( maxdistsq );
                
                if ( ismeleeswipe )
                {
                    overrideenemy = target;
                    dist = self.var_d9508f3fef648a65;
                }
                
                hitent = self melee( meleedirection, damageoverride, dist, width, height, istrue( ismeleeswipe ), overrideenemy );
                
                if ( isdefined( hitent ) )
                {
                    if ( shieldactive && ( self.unittype == "soldier" || self.unittype == "juggernaut" ) )
                    {
                        self playsound( "ai_melee_vs_shield" );
                    }
                    
                    if ( target val::get( "shellshock" ) )
                    {
                        if ( !self.var_cee263b2e4682fd5 )
                        {
                            target player_impulse_from_origin( self.origin, meleepower );
                        }
                        
                        if ( !target.var_35bb592368a44ff6 )
                        {
                            target earthquakeforplayer( 0.45, 0.35, target.origin, 1000 );
                        }
                        
                        target playrumbleonentity( "damage_heavy" );
                        
                        if ( !shieldactive )
                        {
                            isonscreen = 0;
                            pointstocheck = [ self.origin, self getapproxeyepos(), ( self.origin + self getapproxeyepos() ) / 2 ];
                            
                            foreach ( point in pointstocheck )
                            {
                                if ( isdefined( target worldpointtoscreenpos( point, 55 ) ) )
                                {
                                    isonscreen = 1;
                                    break;
                                }
                            }
                            
                            kickpower = 127;
                            blurpower = 0.5;
                            blurduration = 0.25;
                            
                            if ( isonscreen && isdefined( self.var_f38802177d63ee0f ) )
                            {
                                kickpower = 30;
                                target shellshock( self.var_f38802177d63ee0f, 1.25 );
                            }
                            
                            target thread meleeblur( blurpower, blurduration );
                            target viewkick( kickpower, self.origin );
                        }
                    }
                }
                else if ( var_8e1614f2e8188bad )
                {
                    self.nextmeleechecktime = gettime() + randomintrange( 1500, 2500 );
                    self.lastfailedmeleechargetarget = target;
                }
                
                if ( shieldactive )
                {
                    setsaveddvar( @"player_meleedamagemultiplier", level.playermeleedamagemultiplier_dvar );
                }
            }
            else if ( var_8e1614f2e8188bad )
            {
                self.nextmeleechecktime = gettime() + randomintrange( 1500, 2500 );
                self.lastfailedmeleechargetarget = target;
            }
            
            return;
        }
        
        self melee();
    }
}

// Namespace melee
// Params 2
// Checksum 0x25431090, Offset: 0x8d3
// Size: 0x4e
function meleeblur( blurpower, blurduration )
{
    self endon( #"death_or_disconnect" );
    self notify( #"stop_melee_blur" );
    self endon( #"stop_melee_blur" );
    self setblurforplayer( blurpower, blurduration );
    wait blurduration;
    self setblurforplayer( 0, blurduration );
}

// Namespace melee
// Params 2
// Checksum 0x9bbef086, Offset: 0x929
// Size: 0x6b
function player_impulse_from_origin( origin, magnitude )
{
    if ( !self isonground() )
    {
        magnitude *= 0.1;
    }
    
    dir = vectornormalize( self.origin + ( 0, 0, 45 ) - origin );
    vel = dir * magnitude * 10;
    self setvelocity( vel );
}

// Namespace melee
// Params 4
// Checksum 0xca77cf1d, Offset: 0x99c
// Size: 0x85, Type: bool
function melee_shouldabortcharge( asmname, statename, tostatename, params )
{
    if ( !self.in_melee )
    {
        return true;
    }
    
    if ( self.var_56a5b757af5bed42 )
    {
        return true;
    }
    
    if ( !isdefined( self.meleetarget ) )
    {
        return true;
    }
    
    if ( !isalive( self.meleetarget ) )
    {
        return true;
    }
    
    if ( self.meleetarget.dontmelee )
    {
        return true;
    }
    
    return false;
}

// Namespace melee
// Params 4
// Checksum 0xfb5e7f33, Offset: 0xa2a
// Size: 0xc5
function melee_shouldabort( asmname, statename, tostatename, params )
{
    if ( !self.in_melee )
    {
        return 1;
    }
    
    if ( self.var_56a5b757af5bed42 )
    {
        if ( isdefined( self.var_50adce1c7d83b497 ) )
        {
            if ( self.var_50adce1c7d83b497 )
            {
                bstop = asm::asm_eventfired( asmname, "melee_stop" );
                
                if ( bstop )
                {
                    self.var_b6b6da80049a5eb7 = 1;
                }
                
                return bstop;
            }
        }
        else if ( self.var_983be2122a272bca )
        {
            beventfired = asm::asm_eventfired( asmname, "melee_stop" );
            
            if ( !beventfired )
            {
                self.var_50adce1c7d83b497 = 1;
                return 0;
            }
        }
        
        return 1;
    }
    
    return 0;
}

// Namespace melee
// Params 4
// Checksum 0xdd854df9, Offset: 0xaf8
// Size: 0x27
function candocovermelee_anim( asmname, statename, tostatename, params )
{
    
}

// Namespace melee
// Params 4
// Checksum 0x3de491af, Offset: 0xb27
// Size: 0x27
function candomeleeflip_angles( asmname, statename, tostatename, params )
{
    
}

// Namespace melee
// Params 4
// Checksum 0xe6f395f5, Offset: 0xb56
// Size: 0x27
function candomeleeflip_anim( asmname, statename, tostatename, params )
{
    
}

// Namespace melee
// Params 4
// Checksum 0xfaa1f01d, Offset: 0xb85
// Size: 0x27
function candomeleewrestle_angles( asmname, statename, tostatename, params )
{
    
}

// Namespace melee
// Params 4
// Checksum 0xfd7b7539, Offset: 0xbb4
// Size: 0x27
function candomeleewrestle_anim( asmname, statename, tostatename, params )
{
    
}

// Namespace melee
// Params 4
// Checksum 0x4c6b8c56, Offset: 0xbe3
// Size: 0x27
function candomeleebehind_angles( asmname, statename, tostatename, params )
{
    
}

// Namespace melee
// Params 4
// Checksum 0x10f40a12, Offset: 0xc12
// Size: 0x27
function candomeleebehind_anim( asmname, statename, tostatename, params )
{
    
}

// Namespace melee
// Params 1
// Checksum 0x55fa649a, Offset: 0xc41
// Size: 0x94, Type: bool
function candomeleeanim_internal( meleeanim )
{
    target = self.meleetarget;
    targetpos = target.origin;
    targettome = self.origin - targetpos;
    targetangles = vectortoangles( targettome );
    startpos = getstartorigin( targetpos, targetangles, meleeanim );
    self.var_5365a812940e65d5 = getstartangles( targetpos, targetangles, meleeanim )[ 1 ];
    target.var_5365a812940e65d5 = targetangles[ 1 ];
    return true;
}

// Namespace melee
// Params 1
// Checksum 0x2dd484a6, Offset: 0xcde
// Size: 0xc
function candomeleeanim( tostatename )
{
    
}

// Namespace melee
// Params 3
// Checksum 0x90f7ae29, Offset: 0xcf2
// Size: 0x1e
function melee_validatepoints( startpos, targetpos, nodeangles )
{
    
}

// Namespace melee
// Params 4
// Checksum 0xa448b142, Offset: 0xd18
// Size: 0x30
function melee_shouldlosersurvive( asmname, statename, tostatename, params )
{
    return self.var_82ffc7f8cb67f7b6;
}

// Namespace melee
// Params 4
// Checksum 0xe3e5fc95, Offset: 0xd51
// Size: 0x30
function melee_shouldstop( asmname, statename, tostatename, params )
{
    return self.var_b6b6da80049a5eb7;
}

// Namespace melee
// Params 3
// Checksum 0x92c7fda, Offset: 0xd8a
// Size: 0x78
function playmeleeanim_chargetoready( asmname, statename, params )
{
    self endon( statename + "_finished" );
    readyanim = asm::asm_getanim( asmname, statename );
    readyxanim = asm::asm_getxanim( statename, readyanim );
    self aisetanim( statename, readyanim );
    asm::asm_playfacialanim( asmname, statename, readyxanim );
    thread playmeleeanim_chargetoready_distcheck( statename );
    asm::asm_donotetracks( asmname, statename );
}

// Namespace melee
// Params 3
// Checksum 0x1fb96785, Offset: 0xe0a
// Size: 0x141
function playmeleeanim_vsplayer( asmname, statename, params )
{
    playmeleeattacksound();
    target = asm_bb::bb_getmeleetarget();
    
    if ( !isdefined( target ) )
    {
        self orientmode( "face current" );
    }
    else if ( target == self.enemy )
    {
        self orientmode( "face enemy" );
    }
    else
    {
        self orientmode( "face point", target.origin );
    }
    
    if ( self.var_9e3d4d9526fb68dc )
    {
        self orientmode( "face current" );
    }
    
    meleeanim = asm::asm_getanim( asmname, statename );
    asm::asm_fireephemeralevent( "melee_attack", "begin" );
    
    if ( isdefined( params ) )
    {
        self playsound( params );
    }
    
    rate = 1;
    
    if ( isdefined( self.var_923fe633c846a279 ) )
    {
        rate = self.var_923fe633c846a279;
    }
    else if ( self.unittype == "juggernaut" )
    {
        rate = 1.5;
    }
    
    self aisetanim( statename, meleeanim, rate );
    self endon( statename + "_finished" );
    donotetracks_vsplayer( asmname, statename, asm::asm_getnotehandler( asmname, statename ) );
    asm::asm_fireevent( asmname, "end" );
}

// Namespace melee
// Params 0
// Checksum 0xf7648bec, Offset: 0xf53
// Size: 0x8c
function playmeleeattacksound()
{
    if ( !isdefined( self.a.nextmeleeattacksound ) )
    {
        self.a.nextmeleeattacksound = 0;
    }
    
    if ( isplayer( self.enemy ) || randomint( 3 ) == 0 )
    {
        if ( gettime() > self.a.nextmeleeattacksound )
        {
            face::saygenericdialogue( "meleeattack" );
            self.a.nextmeleeattacksound = gettime() + 8000;
        }
    }
}

// Namespace melee
// Params 0
// Checksum 0xe5cf02e3, Offset: 0xfe7
// Size: 0x8c
function playmeleechargesound()
{
    if ( !isdefined( self.a.nextmeleechargesound ) )
    {
        self.a.nextmeleechargesound = 0;
    }
    
    if ( isplayer( self.enemy ) || randomint( 3 ) == 0 )
    {
        if ( gettime() > self.a.nextmeleechargesound )
        {
            face::saygenericdialogue( "meleecharge" );
            self.a.nextmeleechargesound = gettime() + 8000;
        }
    }
}

// Namespace melee
// Params 3
// Checksum 0x4cdd7d24, Offset: 0x107b
// Size: 0x4e
function playmeleechargeanim( asmname, statename, params )
{
    playmeleechargesound();
    self.var_4ff0a015a19a428e = 1;
    self.var_2d4dd3f57eb8b4ed = 1;
    asm::function_b7619cbe4e9abaf4( asmname, statename, self.moveplaybackrate );
}

// Namespace melee
// Params 3
// Checksum 0x78e88b8c, Offset: 0x10d1
// Size: 0xad
function on_execution_begin( asmname, statename, params )
{
    if ( self.bhasriotshieldattached )
    {
        death::detachriotshield( 1 );
    }
    
    distfromcenter = 40;
    halfheight = 40;
    self function_1e7b05aee4b81c2c( 0 );
    otherguy = self getexecutionpartner();
    
    if ( isdefined( otherguy ) )
    {
        assert( isplayer( otherguy ), "<dev string:x24>" );
        pos = ( self.origin + otherguy.origin ) * 0.5;
        level thread execution_obstacle( pos, distfromcenter, halfheight );
    }
}

// Namespace melee
// Params 3
// Checksum 0x18b27fd8, Offset: 0x1186
// Size: 0x57
function execution_obstacle( pos, distfromcenter, halfheight )
{
    zeroangles = ( 0, 0, 0 );
    obstacleid = createnavbadplacebyshape( pos, zeroangles, 6, distfromcenter, halfheight );
    wait 3;
    destroynavobstacle( obstacleid );
}

// Namespace melee
// Params 2
// Checksum 0xa3824c56, Offset: 0x11e5
// Size: 0x136
function function_67f0be66e0a19b06( note, flagname )
{
    if ( !isdefined( self.var_d9508f3fef648a65 ) )
    {
        self.var_d9508f3fef648a65 = 64;
    }
    
    if ( !isdefined( self.var_65e6ddbb9daa53a3 ) )
    {
        self.var_65e6ddbb9daa53a3 = 45;
    }
    
    players = utility::function_f754506ecfae9afb( self.origin, self.var_d9508f3fef648a65, undefined, 100 );
    fwd = anglestoforward( self.angles );
    
    foreach ( player in players )
    {
        toplayer = player.origin - self.origin;
        
        if ( abs( vectordot2( toplayer, fwd ) ) > cos( self.var_65e6ddbb9daa53a3 ) )
        {
            function_868803d6a9a2f26d( player, 0, undefined, 1 );
        }
    }
}

