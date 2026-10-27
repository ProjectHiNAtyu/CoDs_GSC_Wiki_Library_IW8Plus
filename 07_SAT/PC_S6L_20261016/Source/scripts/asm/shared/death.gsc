// scripts\asm\shared\death.gsc  (hash_159f253f9bd2314e.gscc) (size: 5115 Bytes / 0x13fb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7f298770 (2133428080)
// size ...... 5115 (0x13fb)
// includes .. 7   (offset: 0x12cb)
// strings ... 17  (offset: 0x1303)
// dev strs .. 3   (offset: 0x13d3)
// exports ... 9   (offset: 0xc6b)
// cseg ...... 0x146 + 0xb25 (0xc6b)
// imports ... 41  (offset: 0xdd3)
// animtree1 . 0   (offset: 0x13fb)
// animtree2 . 0   (offset: 0x13fb)
#using scripts\anim\notetracks;
#using scripts\anim\shared;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace death;

// Namespace death
// Params 3
// Checksum 0x99d1f547, Offset: 0x164
// Size: 0x610
function playdeathanimcommon( asmname, statename, params )
{
    callback::callback( #"asm_death_anim", { #params:params, #statename:statename, #asmname:asmname } );
    stop_sounds();
    self stoplookat();
    
    if ( isdefined( self.fnasm_clearfingerposes ) )
    {
        self [[ self.fnasm_clearfingerposes ]]();
    }
    
    if ( isdefined( self.fnachievements ) )
    {
        self thread [[ self.fnachievements ]]();
    }
    
    self.disabledeathorient = !( isdefined( self.a ) && self.a.nodeath ) || self.noragdoll;
    
    if ( isdefined( self.a ) && self.a.nodeath )
    {
        deathcleanup();
        return;
    }
    
    if ( self.damagemod == "MOD_CRUSH" )
    {
        playsoundatpos( self.origin, "vehicle_body_hit" );
    }
    
    if ( isdefined( self.asm.deathfunc ) )
    {
        self [[ self.asm.deathfunc ]]();
        
        if ( !isdefined( self.deathfunction ) )
        {
            deathcleanup();
            return;
        }
    }
    
    if ( isdefined( self.deathfunction ) )
    {
        result = self [[ self.deathfunction ]]();
        
        if ( !isdefined( result ) )
        {
            result = 1;
        }
        
        if ( result )
        {
            deathcleanup();
            return;
        }
    }
    
    if ( isdefined( self.ragdoll_immediate ) || self.forceragdollimmediate )
    {
        if ( isagent( self ) )
        {
            return;
        }
        
        if ( isdefined( self.doantigravgrenaderagdoll ) && self.doantigravgrenaderagdoll )
        {
            self animmode( "noclip" );
        }
        else if ( self.nogravityragdoll )
        {
            self animmode( "nogravity" );
        }
        else
        {
            self animmode( "gravity" );
        }
        
        doimmediateragdolldeath();
        
        if ( !isdefined( self ) )
        {
            return;
        }
    }
    
    self endon( #"entitydeleted" );
    deathanimdata = undefined;
    deathanim = undefined;
    deathxanim = undefined;
    assert( isdefined( self.deathalias ) && isdefined( self.deathstate ) || !isdefined( self.deathalias ) && !isdefined( self.deathstate ), "<dev string:x24>" );
    var_d3a64e06f02a5698 = isdefined( self.deathalias ) && isdefined( self.deathstate );
    
    if ( !isdefined( self.skipdeathanim ) || self.diedintransition )
    {
        deathanimdata = getdeathanimdata( asmname, statename, params );
        assert( isdefined( deathanimdata ) && deathanimdata.size == 2 );
        deathanim = deathanimdata[ 0 ];
        deathxanim = deathanimdata[ 1 ];
        self.deathanimduration = int( getanimlength( deathxanim ) * 1000 );
        directional_orient = params == "directional_orient";
        
        if ( self.disabledeathdirectionalorient )
        {
            directional_orient = 0;
        }
        
        if ( isnumber( deathanim ) )
        {
            if ( var_d3a64e06f02a5698 )
            {
                self aisetanim( self.deathstate, deathanim );
            }
            else
            {
                self aisetanim( statename, deathanim );
            }
        }
        else
        {
            assert( utility::issp(), "<dev string:x69>" );
            bodyknob = asm::asm_getinnerrootknob();
            self clearanim( bodyknob, 0.05 );
            self setflaggedanimknoballrestart( statename, deathanim, bodyknob, 1, 0.05 );
        }
        
        if ( var_d3a64e06f02a5698 )
        {
            asm::asm_playfacialanim( asmname, self.deathstate, deathxanim );
        }
        else
        {
            asm::asm_playfacialanim( asmname, statename, deathxanim );
        }
    }
    
    if ( isdefined( self.deathanimmode ) )
    {
        self animmode( self.deathanimmode );
    }
    
    if ( isdefined( self.skipdeathanim ) )
    {
        assert( self.skipdeathanim, "<dev string:x91>" );
        
        if ( !isdefined( self.noragdoll ) )
        {
            if ( isdefined( self.fnpreragdoll ) )
            {
                self [[ self.fnpreragdoll ]]();
            }
            
            if ( !isdefined( self ) )
            {
                return;
            }
            
            self notify( #"ragdoll_started" );
            self startragdoll();
        }
        
        if ( !isagent( self ) )
        {
            wait 0.05;
            
            if ( !isdefined( self ) )
            {
                return;
            }
            
            self animmode( "gravity" );
        }
    }
    else if ( isdefined( self.ragdolltime ) )
    {
        thread waitforragdoll( self.ragdolltime );
    }
    else if ( getdvarint( @"hash_8c30a87f78a7d97e" ) == 1 )
    {
        thread startragdollwithoutwait();
    }
    else
    {
        if ( !isdefined( deathanimdata ) )
        {
            deathanimdata = getdeathanimdata( asmname, statename, params );
        }
        
        assert( isdefined( deathanimdata ) && deathanimdata.size == 2 );
        deathanim = deathanimdata[ 0 ];
        deathxanim = deathanimdata[ 1 ];
        ragdollnotetracks = getnotetracktimes( deathxanim, "start_ragdoll" );
        var_b316835018fa6055 = !var_d3a64e06f02a5698 && !isdefined( self.deathanim ) && ( ragdollnotetracks.size == 0 || ragdollnotetracks[ 0 ] > 0.5 );
        
        if ( var_b316835018fa6055 )
        {
            if ( self.damagemod == "MOD_MELEE" )
            {
                ragdollscaler = 0.7;
            }
            else
            {
                ragdollscaler = 0.35;
            }
            
            thread waitforragdoll( getanimlength( deathxanim ) * ragdollscaler );
        }
    }
    
    self endon( #"terminate_death_thread" );
    
    if ( !isagent( self ) )
    {
        if ( isdefined( self.skipdeathanim ) && !self.diedintransition )
        {
            wait 0.05;
        }
        else
        {
            notestatename = statename;
            
            if ( var_d3a64e06f02a5698 )
            {
                notestatename = self.deathstate;
            }
            
            asm::asm_donotetracks( asmname, notestatename, &deathnotetracks );
        }
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self notify( #"endplaydeathanim" );
    
    if ( !isagent( self ) )
    {
        if ( isdefined( self.ragdoll_immediate ) || self.forceragdollimmediate )
        {
            wait 0.5;
            
            if ( !isdefined( self ) )
            {
                return;
            }
            
            self aisetanimrate( asm::asm_getroot(), 0 );
        }
    }
    
    deathcleanup();
}

// Namespace death
// Params 1
// Checksum 0xdb9422df, Offset: 0x77c
// Size: 0x15
function deathnotetracks( note )
{
    notetracks::notetrack_prefix_handler( note );
}

// Namespace death
// Params 3
// Checksum 0xf794f78, Offset: 0x799
// Size: 0x112
function getdeathanimdata( asmname, statename, params )
{
    assert( isdefined( self.deathalias ) && isdefined( self.deathstate ) || !isdefined( self.deathalias ) && !isdefined( self.deathstate ), "<dev string:x24>" );
    var_d3a64e06f02a5698 = isdefined( self.deathalias ) && isdefined( self.deathstate );
    
    if ( isdefined( self.deathanim ) )
    {
        deathanim = self.deathanim;
        deathxanim = asm::asm_getxanim( statename, deathanim );
    }
    else if ( var_d3a64e06f02a5698 )
    {
        deathanim = asm::asm_lookupanimfromalias( self.deathstate, self.deathalias );
        deathxanim = asm::asm_getxanim( self.deathstate, deathanim );
    }
    else
    {
        deathanim = asm::asm_getanim( asmname, statename, params );
        deathxanim = asm::asm_getxanim( statename, deathanim );
    }
    
    return [ deathanim, deathxanim ];
}

// Namespace death
// Params 0
// Checksum 0x1b7596eb, Offset: 0x8b4
// Size: 0x26
function stop_sounds()
{
    self stopsoundchannel( "voice_bchatter_1_3d" );
    self stopsoundchannel( "voice_air_3d" );
    utility::disabledefaultfacialanims( 0 );
    self stoploopsound();
}

// Namespace death
// Params 0
// Checksum 0xe09be27, Offset: 0x8e2
// Size: 0x71
function deathcleanup()
{
    if ( self.skipdeathcleanup )
    {
        return;
    }
    
    asm_bb::bb_clearmeleetarget();
    self notify( #"terminate_ai_threads" );
    
    if ( isagent( self ) )
    {
        return;
    }
    
    numattempts = 3;
    
    while ( isdefined( self ) && self.script != "death" && numattempts > 0 )
    {
        numattempts--;
        wait 0.05;
    }
    
    self notify( #"killanimscript" );
}

// Namespace death
// Params 0
// Checksum 0x5f744774, Offset: 0x95b
// Size: 0x225
function doimmediateragdolldeath()
{
    if ( isdefined( self.weapon ) )
    {
        shared::dropallaiweapons();
    }
    
    self.skipdeathanim = 1;
    
    if ( isdefined( self.fnpreragdoll ) )
    {
        self [[ self.fnpreragdoll ]]();
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( self.vehicle_idling )
    {
        return;
    }
    
    initialimpulse = 10;
    damagetype = utility::getdamagetype( self.damagemod );
    
    if ( self.attacker == level.player && damagetype == "melee" )
    {
        initialimpulse = 5;
    }
    
    damagetaken = self.damagetaken;
    
    if ( damagetype == "bullet" || self.damagemod == "MOD_FIRE" )
    {
        damagetaken = min( damagetaken, 300 );
    }
    else
    {
        damagetaken = min( damagetaken, 5000 );
    }
    
    damagescale = initialimpulse * damagetaken;
    
    if ( isdefined( self.ragdoll_immediate_vector ) )
    {
        vector = self.ragdoll_immediate_vector;
    }
    else
    {
        directionup = min( 0.3, self.damagedir[ 2 ] );
        vector = ( self.damagedir[ 0 ], self.damagedir[ 1 ], directionup );
    }
    
    if ( isdefined( self.ragdoll_immediate_scale ) )
    {
        vector *= self.ragdoll_immediate_scale;
    }
    else if ( isdefined( self.damageweapon ) && self.damageweapon.classname == "throwingknife" )
    {
        vector *= damagescale * 0.25;
    }
    else
    {
        vector *= damagescale;
    }
    
    if ( self.forceragdollimmediate )
    {
        vector += self.prevanimdelta * 20 * 10;
    }
    
    if ( isdefined( self.var_b172398d9b9b8423 ) )
    {
        damagelocation = self.var_b172398d9b9b8423;
    }
    else
    {
        damagelocation = self.damagelocation;
    }
    
    if ( damagelocation == "none" )
    {
        damagelocation = "torso_upper";
    }
    
    self notify( #"ragdoll_started" );
    self startragdollfromimpact( damagelocation, vector );
    waitframe();
}

// Namespace death
// Params 1
// Checksum 0xe7b0d105, Offset: 0xb88
// Size: 0x77
function waitforragdoll( time )
{
    wait time;
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isagent( self ) )
    {
        return;
    }
    
    if ( isdefined( self ) && isdefined( self.weapon ) )
    {
        shared::dropallaiweapons();
    }
    
    if ( isdefined( self.fnpreragdoll ) )
    {
        self [[ self.fnpreragdoll ]]();
    }
    
    if ( isdefined( self ) && !self.noragdoll )
    {
        self notify( #"ragdoll_started" );
        self startragdoll();
    }
}

// Namespace death
// Params 0
// Checksum 0x9a84a0d2, Offset: 0xc07
// Size: 0x64
function startragdollwithoutwait()
{
    if ( isagent( self ) )
    {
        return;
    }
    
    if ( isdefined( self ) && isdefined( self.weapon ) )
    {
        shared::dropallaiweapons();
    }
    
    if ( isdefined( self.fnpreragdoll ) )
    {
        self [[ self.fnpreragdoll ]]();
    }
    
    if ( isdefined( self ) && !isdefined( self.noragdoll ) )
    {
        self notify( #"ragdoll_started" );
        self startragdoll();
    }
}

