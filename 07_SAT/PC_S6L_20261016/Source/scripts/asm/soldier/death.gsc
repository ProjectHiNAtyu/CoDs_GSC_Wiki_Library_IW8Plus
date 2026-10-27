// scripts\asm\soldier\death.gsc  (hash_498a94b2b971c46b.gscc) (size: 31948 Bytes / 0x7ccc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x19e8752e (434664750)
// size ...... 31948 (0x7ccc)
// includes .. 14  (offset: 0x7124)
// strings ... 165 (offset: 0x7194)
// dev strs .. 19  (offset: 0x7be4)
// exports ... 75  (offset: 0x4a8c)
// cseg ...... 0xa2e + 0x405e (0x4a8c)
// imports ... 208 (offset: 0x5644)
// animtree1 . 0   (offset: 0x7ccc)
// animtree2 . 0   (offset: 0x7ccc)
#using script_16ea1b94f0f381b3;
#using scripts\anim\face;
#using scripts\anim\notetracks;
#using scripts\anim\shared;
#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\asm\shared\death;
#using scripts\asm\shared\utility;
#using scripts\asm\soldier\pain;
#using scripts\asm\soldier\patrol;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\common\trace;
#using scripts\common\utility;

#namespace death;

// Namespace death
// Params 0
// Checksum 0x438d862c, Offset: 0xa4c
// Size: 0x69
function deathlmgcleanup()
{
    if ( !isdefined( self._blackboard.leftweaponent ) )
    {
        return;
    }
    
    weaponent = self._blackboard.leftweaponent;
    weaponent delete();
    self._blackboard.leftweaponent = undefined;
    shared::forceuseweapon( self.primaryweapon, "primary" );
}

// Namespace death
// Params 3
// Checksum 0x5fa016da, Offset: 0xabd
// Size: 0x90e
function playdeathanim( asmname, statename, params )
{
    callback::callback( #"asm_death_anim", { #params:params, #statename:statename, #asmname:asmname } );
    stop_sounds();
    self stoplookat();
    
    if ( isdefined( self.fnlaseroff ) )
    {
        self [[ self.fnlaseroff ]]();
    }
    
    if ( isdefined( self.fnasm_clearfingerposes ) )
    {
        self [[ self.fnasm_clearfingerposes ]]();
    }
    
    if ( isdefined( self.fnachievements ) )
    {
        self thread [[ self.fnachievements ]]();
    }
    
    removeselffrom_squadlastseenenemypos( self.origin );
    
    if ( isdefined( self.scriptedarrivalent ) )
    {
        self.scriptedarrivalent delete();
    }
    
    setnumdeathsuntilcrawlingpain( getnumdeathsuntilcrawlingpain() - 1 );
    setnumdeathsuntilcornergrenadedeath( getnumdeathsuntilcornergrenadedeath() - 1 );
    deathlmgcleanup();
    
    if ( self.a.nodeath )
    {
        deathcleanup();
        return;
    }
    
    bexplosivedamage = utility::wasdamagedbyexplosive();
    
    if ( shouldhelmetpopondeath( bexplosivedamage ) )
    {
        helmetpop();
    }
    
    if ( shouldheadpop( bexplosivedamage ) )
    {
        headpop();
    }
    
    playdeathsound( bexplosivedamage );
    
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
            if ( self.bhasriotshieldattached )
            {
                detachriotshield();
            }
            
            shared::dropallaiweapons();
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
        
        if ( !function_7e89090f6063051b( statename ) )
        {
            doimmediateragdolldeath();
        }
        
        if ( !isdefined( self ) )
        {
            return;
        }
    }
    
    self endon( #"entitydeleted" );
    
    if ( shouldgib() && !self isragdoll() )
    {
        if ( self.bhasriotshieldattached )
        {
            detachriotshield();
        }
        
        shared::dropallaiweapons();
        dogib();
        
        if ( isagent( self ) )
        {
            self.nocorpse = 1;
        }
        else
        {
            self hide();
            
            if ( !isagent( self ) )
            {
                wait 0.1;
            }
        }
        
        if ( isdefined( self ) )
        {
            deathcleanup();
            
            if ( !isagent( self ) )
            {
                self delete();
            }
        }
        
        return;
    }
    
    if ( isdefined( self.deathbysuffocation ) && !isdefined( self.deathanim ) )
    {
        ai::set_deathanim( getsuffocationdeathanim() );
    }
    
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
        
        if ( !animhasnotetrack( deathxanim, "dropgun" ) && !animhasnotetrack( deathxanim, "fire_spray" ) )
        {
            shared::dropallaiweapons();
        }
        
        if ( animhasnotetrack( deathxanim, "dropgun" ) )
        {
            self._blackboard.awaitingdropgunnotetrack = 1;
        }
        
        if ( self.bhasriotshieldattached )
        {
            detachriotshield();
        }
        
        if ( isdefined( self.asmflashlight ) && self.asmflashlight )
        {
            patrol::detachflashlight();
        }
        
        handleburningtodeath( deathxanim );
        self.deathanimduration = int( getanimlength( deathxanim ) * 1000 );
        directional_orient = params == "directional_orient";
        
        if ( self.disabledeathdirectionalorient )
        {
            directional_orient = 0;
        }
        
        orientmeleevictim( directional_orient );
        
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
            
            if ( self.bhasriotshieldattached )
            {
                detachriotshield();
            }
            
            shared::dropallaiweapons();
            
            if ( self.nogravityragdoll )
            {
                self animmode( "nogravity" );
            }
            
            if ( function_7e89090f6063051b( statename ) )
            {
                asm::asm_donotetracks( asmname, statename, &deathnotetrackhandler );
            }
            else
            {
                self startragdoll();
            }
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
            println( "<dev string:xc6>" + self getentitynumber() + "<dev string:xe3>" + statename + "<dev string:xf9>" + self.animsetname + "<dev string:x106>" );
            var_c181e4252f9542a5 = 1;
            
            if ( !isagent( self ) && !self.noragdoll )
            {
                if ( function_7e89090f6063051b( statename ) )
                {
                    if ( isdefined( self ) && isdefined( self.weapon ) )
                    {
                        shared::dropallaiweapons();
                    }
                    
                    if ( isdefined( self.fnpreragdoll ) )
                    {
                        self [[ self.fnpreragdoll ]]();
                    }
                    
                    var_c181e4252f9542a5 = 0;
                }
            }
            
            if ( var_c181e4252f9542a5 )
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
    }
    
    /#
        if ( getdvar( @"hash_27494f1d75fc0809" ) == "<dev string:x138>" )
        {
            if ( animhasnotetrack( deathxanim, "<dev string:x13b>" ) )
            {
                return;
            }
            
            if ( animhasnotetrack( deathxanim, "<dev string:x14a>" ) )
            {
                return;
            }
            
            println( "<dev string:x159>", deathxanim, "<dev string:x16a>" );
            iprintlnbold( "<dev string:x18e>" );
        }
    #/
    
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
            
            asm::asm_donotetracks( asmname, notestatename, &deathnotetrackhandler );
        }
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( self.bhasriotshieldattached )
    {
        detachriotshield();
    }
    
    shared::dropallaiweapons();
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
// Checksum 0xe97b215a, Offset: 0x13d3
// Size: 0x72, Type: bool
function function_7e89090f6063051b( statename )
{
    ragdollxanim = undefined;
    
    if ( !isagent( self ) )
    {
        var_cc0a1b41c139ef21 = archetypegetrandomalias( self.animsetname, "knobs", "ragdoll_notetrack_add" );
        
        if ( var_cc0a1b41c139ef21 )
        {
            ragdollxanim = asm::asm_getxanim( "knobs", var_cc0a1b41c139ef21 );
        }
    }
    
    if ( ragdollxanim )
    {
        self setflaggedanim( statename, ragdollxanim, 1, 0.2, 1 );
        return true;
    }
    
    return false;
}

// Namespace death
// Params 1
// Checksum 0xc48f42c4, Offset: 0x144e
// Size: 0x53
function deathnotetrackhandler( note )
{
    if ( self.burningtodeath )
    {
        switch ( note )
        {
            case #"hash_9af1375f4b1b97b8":
                handleburndeathmodelswap();
                return;
            case #"hash_251b15537436bbcd":
                thread handleburndeathvfx();
                return;
        }
    }
    
    notetracks::notetrack_prefix_handler( note );
}

// Namespace death
// Params 1
// Checksum 0x3b732a0, Offset: 0x14a9
// Size: 0x1ae
function handleburningtodeath( deathxanim )
{
    if ( isscriptedagent( self ) && !isnullweapon( self.damageweapon ) && self.unittype != "juggernaut" && utility::shouldburnfromdamage( self.damageweapon ) )
    {
        self.burningtodeath = 1;
        thread handleburndeathvfx();
        return;
    }
    
    if ( isscriptedagent( self ) && self.unittype == "juggernaut" )
    {
        return;
    }
    
    if ( !self.burningtodeath )
    {
        return;
    }
    
    if ( isscriptedagent( self ) )
    {
        /#
            weaponname = "<dev string:x1e3>";
            
            if ( !isnullweapon( self.damageweapon ) )
            {
                weaponname = self.damageweapon.basename;
            }
            
            assertmsg( "<dev string:x1ed>" + weaponname );
        #/
        
        return;
    }
    
    if ( self.unittype != "dog" && ( !isdefined( deathxanim ) || !animhasnotetrack( deathxanim, "model_swap" ) ) )
    {
        if ( isdefined( self.headmodel ) )
        {
            self detach( self.headmodel );
            self.headmodel = undefined;
        }
        
        if ( isdefined( self.hatmodel ) )
        {
            self detach( self.hatmodel );
            self.hatmodel = undefined;
        }
        
        gamemodebundle = getgamemodescriptbundle();
        
        if ( isdefined( gamemodebundle ) )
        {
            assert( isdefined( gamemodebundle.var_91c5075cb347f628 ), "<dev string:x24e>" );
            self setmodel( gamemodebundle.var_91c5075cb347f628 );
        }
        
        if ( !isdefined( deathxanim ) || !animhasnotetrack( deathxanim, "burn_vfx_death_start" ) )
        {
            thread handleburndeathvfx();
        }
    }
}

// Namespace death
// Params 0
// Checksum 0xca47c291, Offset: 0x165f
// Size: 0x8e
function handleburndeathmodelswap()
{
    if ( isdefined( self.headmodel ) )
    {
        self detach( self.headmodel );
        self.headmodel = undefined;
    }
    
    if ( isdefined( self.hatmodel ) )
    {
        self detach( self.hatmodel );
        self.hatmodel = undefined;
    }
    
    gamemodebundle = getgamemodescriptbundle();
    
    if ( isdefined( gamemodebundle ) )
    {
        assert( isdefined( gamemodebundle.var_91c5075cb347f628 ), "<dev string:x24e>" );
        self setmodel( gamemodebundle.var_91c5075cb347f628 );
    }
}

// Namespace death
// Params 0
// Checksum 0x8f17e08e, Offset: 0x16f5
// Size: 0x13c
function handleburndeathvfx()
{
    self endon( #"hash_3abee2d5772e4794" );
    self endon( #"entitydeleted" );
    useontag = 1;
    
    if ( self isscriptable() )
    {
        currentstate = self getscriptablepartstate( "burn_to_death_by_molotov", 1 );
        
        if ( isdefined( currentstate ) )
        {
            self setscriptablepartstate( "burn_to_death_by_molotov", "active" );
            useontag = 0;
        }
    }
    
    if ( useontag )
    {
        burnvfxtagpackets = getburnvfxtagpackets();
        
        foreach ( burnvfxpacket in burnvfxtagpackets )
        {
            if ( !isdefined( self ) )
            {
                return;
            }
            
            if ( !isdefined( burnvfxpacket.burnvfx ) || !isdefined( level.g_effect[ burnvfxpacket.burnvfx ] ) )
            {
                continue;
            }
            
            playfxontag( level.g_effect[ burnvfxpacket.burnvfx ], self, burnvfxpacket.tag );
            wait 0.05;
        }
    }
}

// Namespace death
// Params 0
// Checksum 0x74f8140c, Offset: 0x1839
// Size: 0xed
function getburnvfxtagpackets()
{
    burnvfxpacket = [];
    burnvfxpacket[ burnvfxpacket.size ] = createburnvfxpacket( "j_knee_ri", "vfx_burn_sml_high" );
    burnvfxpacket[ burnvfxpacket.size ] = createburnvfxpacket( "j_knee_le", "vfx_burn_sml_high" );
    burnvfxpacket[ burnvfxpacket.size ] = createburnvfxpacket( "j_proc_hip_ri", "vfx_burn_med_high" );
    burnvfxpacket[ burnvfxpacket.size ] = createburnvfxpacket( "j_proc_hip_le", "vfx_burn_med_high" );
    burnvfxpacket[ burnvfxpacket.size ] = createburnvfxpacket( "j_spinelower", "vfx_burn_med_high" );
    burnvfxpacket[ burnvfxpacket.size ] = createburnvfxpacket( "j_spine4", "vfx_burn_lrg_high" );
    burnvfxpacket[ burnvfxpacket.size ] = createburnvfxpacket( "j_elbow_ri", "vfx_burn_sml_high" );
    burnvfxpacket[ burnvfxpacket.size ] = createburnvfxpacket( "j_elbow_le", "vfx_burn_sml_high" );
    burnvfxpacket[ burnvfxpacket.size ] = createburnvfxpacket( "j_shoulder_ri", "vfx_burn_med_high" );
    burnvfxpacket[ burnvfxpacket.size ] = createburnvfxpacket( "j_shoulder_le", "vfx_burn_med_high" );
    return burnvfxpacket;
}

// Namespace death
// Params 3
// Checksum 0x13469ce0, Offset: 0x192f
// Size: 0x4c
function createburnvfxpacket( tag, burnvfx, smoldervfx )
{
    packet = spawnstruct();
    packet.tag = tag;
    packet.burnvfx = burnvfx;
    return packet;
}

// Namespace death
// Params 1
// Checksum 0x1b1651a9, Offset: 0x1984
// Size: 0x70
function detachriotshield( inexecution )
{
    assert( self.bhasriotshieldattached );
    
    if ( shoulddropriotshield() )
    {
        dropriotshield();
    }
    
    if ( !utility::issp() )
    {
        self aisetriotshieldweapon( nullweapon() );
    }
    
    if ( !self.bdroppingshield )
    {
        self detach( self.riotshieldmodel, self.riotshieldmodeltag );
    }
    
    self.bhasriotshieldattached = undefined;
}

// Namespace death
// Params 0
// Checksum 0x852c55c0, Offset: 0x19fc
// Size: 0x12, Type: bool
function shoulddropriotshield()
{
    if ( self.shoulddropriotshield )
    {
        return true;
    }
    
    return false;
}

// Namespace death
// Params 0
// Checksum 0x7fb98bd9, Offset: 0x1a17
// Size: 0x8a
function dropriotshield()
{
    shieldorigin = self gettagorigin( self.riotshieldmodeltag );
    shieldangles = self gettagangles( self.riotshieldmodeltag );
    shield = spawn( "script_model", shieldorigin );
    shield.angles = shieldangles;
    shield setmodel( self.riotshieldmodel );
    shield physicslaunchserver( shieldorigin, anglestoforward( self.angles ) * 200 );
    shield thread deleteriotshield( 10 );
}

// Namespace death
// Params 0
// Checksum 0xb281402d, Offset: 0x1aa9
// Size: 0x69
function dropriotshieldweapon()
{
    shieldorigin = self gettagorigin( self.riotshieldmodeltag );
    shieldangles = self gettagangles( self.riotshieldmodeltag );
    strweap = "iw9_me_riotshield_mp";
    shield = spawn( "weapon_" + strweap, shieldorigin );
    shield.angles = shieldangles;
}

// Namespace death
// Params 1
// Checksum 0x5da402cb, Offset: 0x1b1a
// Size: 0x21
function deleteriotshield( time )
{
    self endon( #"death" );
    wait time;
    self delete();
}

// Namespace death
// Params 2
// Checksum 0x237c2a6a, Offset: 0x1b43
// Size: 0x132
function c8deathsound( c8, notetrack )
{
    prefix = getsubstr( notetrack, 0, 3 );
    
    if ( prefix == "vo_" )
    {
        alias = getsubstr( notetrack, 3 );
        c8 [[ anim.callbacks[ "PlaySoundAtViewHeight" ] ]]( alias );
        return;
    }
    
    if ( prefix != "ps_" )
    {
        return;
    }
    
    alias = getsubstr( notetrack, 3 );
    
    if ( !isdefined( c8.deathsoundent ) )
    {
        c8.deathsoundent = spawn( "script_origin", c8.origin );
        c8.deathsoundent.targetname = "C8DeathSound";
        c8.deathsoundent linkto( c8, "" );
    }
    
    ent = c8.deathsoundent;
    ent notify( #"hash_abe0325c3a2e8d34" );
    ent endon( #"hash_abe0325c3a2e8d34" );
    ent playsound( alias );
    time = lookupsoundlength( alias );
    wait time * 0.001 + 0.1;
    ent delete();
}

// Namespace death
// Params 3
// Checksum 0x821f7c6f, Offset: 0x1c7d
// Size: 0x136
function playexplosivedeathanim( asmname, statename, params )
{
    if ( ( utility::isdamageweapon( makeweapon( "iw7_knife_upgrade1" ) ) || utility::wasdamagedbyoffhandshield() || utility::isdamageweapon( makeweapon( "iw7_sonic" ) ) ) && isdefined( self.attacker ) )
    {
        var_788d4b9b7e841278 = vectortoyaw( self.attacker.origin - self.origin );
        
        if ( self.damageyaw > 135 || self.damageyaw <= -135 )
        {
            self orientmode( "face angle", var_788d4b9b7e841278 );
        }
        else if ( self.damageyaw > 45 && self.damageyaw <= 135 )
        {
            self orientmode( "face angle", var_788d4b9b7e841278 + 90 );
        }
        else if ( self.damageyaw > -45 && self.damageyaw <= 45 )
        {
            self orientmode( "face angle", var_788d4b9b7e841278 - 180 );
        }
        else
        {
            self orientmode( "face angle", var_788d4b9b7e841278 - 90 );
        }
    }
    
    playdeathanim( asmname, statename, params );
}

// Namespace death
// Params 3
// Checksum 0xce249ec0, Offset: 0x1dbb
// Size: 0x68
function playbalconydeathanim( asmname, statename, params )
{
    setnextbalconydeathtime( gettime() + randomintrange( 5000, 8000 ) );
    self orientmode( "face angle", self._blackboard.balconydeathnode.angles[ 1 ] );
    playdeathanim( asmname, statename, params );
}

// Namespace death
// Params 3
// Checksum 0x2c256ef3, Offset: 0x1e2b
// Size: 0xd4
function playdeathanim_melee_ragdolldelayed( asmname, statename, params )
{
    var_39474a4f2b767d61 = isagent( self );
    
    if ( !var_39474a4f2b767d61 )
    {
        if ( isdefined( self.meleestatename ) )
        {
            time = params;
            
            if ( !isdefined( time ) )
            {
                time = 10;
            }
            
            asm::asm_donotetrackswithtimeout( asmname, self.meleestatename, time );
        }
    }
    
    shared::dropallaiweapons();
    
    if ( self.bhasriotshieldattached )
    {
        detachriotshield();
    }
    
    if ( isdefined( self.fnpreragdoll ) )
    {
        self [[ self.fnpreragdoll ]]();
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    doragdoll = !( var_39474a4f2b767d61 || self isinexecutionvictim() );
    
    if ( doragdoll )
    {
        self startragdoll();
        wait 0.1;
    }
    
    deathcleanup();
}

// Namespace death
// Params 4
// Checksum 0xc9c304c8, Offset: 0x1f07
// Size: 0x34
function chooseshockdeathanim( asmname, statename, tostatename, params )
{
    return asm::asm_lookupanimfromalias( statename, "standing" );
}

// Namespace death
// Params 4
// Checksum 0x18b50a20, Offset: 0x1f44
// Size: 0x3b, Type: bool
function shouldplayshockdeath( asmname, statename, tostatename, params )
{
    return utility::isshocked() || isdefined( self.shockdeath );
}

// Namespace death
// Params 4
// Checksum 0xbf7ddc95, Offset: 0x1f88
// Size: 0x61, Type: bool
function shouldplayexplosivedeath( asmname, statename, tostatename, params )
{
    if ( self.unittype == "juggernaut" )
    {
        return false;
    }
    
    if ( self.forceexplosivedeath )
    {
        self.forceexplosivedeath = 0;
        return true;
    }
    
    if ( utility::wasdamagedbyexplosive() )
    {
        return true;
    }
    
    return false;
}

// Namespace death
// Params 4
// Checksum 0x535bb8, Offset: 0x1ff2
// Size: 0x7a, Type: bool
function function_6a145345438cf903( asmname, statename, tostatename, params )
{
    if ( self.var_144930d0d800055d )
    {
        self.var_144930d0d800055d = 0;
        return true;
    }
    
    if ( self.damagemod == "MOD_IMPACT" )
    {
        if ( isdefined( self.attacker ) && self.attacker.istrainvehicle )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace death
// Params 3
// Checksum 0x54633e7d, Offset: 0x2075
// Size: 0x7e
function function_624578be1fa2c87a( asmname, statename, params )
{
    deathalias = "train";
    
    if ( self.currentpose == "stand" )
    {
        deathalias += "_stand";
    }
    else if ( self.currentpose == "crouch" )
    {
        deathalias += "_crouch";
    }
    
    deathalias += pain::getpaindirectiontoactor();
    return asm::asm_lookupanimfromalias( statename, deathalias );
}

// Namespace death
// Params 3
// Checksum 0xec769b97, Offset: 0x20fc
// Size: 0x58
function function_2dc2d016b9127ac5( asmname, statename, params )
{
    self.nodrop = 1;
    self.nocorpse = 1;
    self.noragdoll = 1;
    self.deathanimmode = "noclip";
    playdeathanim( asmname, statename, params );
}

// Namespace death
// Params 4
// Checksum 0x970950fa, Offset: 0x215c
// Size: 0x76, Type: bool
function shouldplayplayermeleedeath( asmname, statename, tostatename, params )
{
    if ( isdefined( self.damagemod ) && isalive( self.attacker ) )
    {
        if ( !isplayer( self.attacker ) )
        {
            return false;
        }
        
        if ( utility::getdamagetype( self.damagemod ) != "melee" )
        {
            return false;
        }
        
        return true;
    }
    
    return false;
}

// Namespace death
// Params 4
// Checksum 0x41216b80, Offset: 0x21db
// Size: 0x168, Type: bool
function shouldplaybalconydeath( asmname, statename, tostatename, params )
{
    if ( self.currentpose == "prone" )
    {
        return false;
    }
    
    if ( !self.burningtodeath && utility::wasdamagedbyexplosive() )
    {
        return false;
    }
    
    if ( gettime() < getnextbalconydeathtime() && !self.forcebalconydeath )
    {
        return false;
    }
    
    node = undefined;
    
    if ( isdefined( self.forcebalconydeathnode ) )
    {
        node = self.forcebalconydeathnode;
    }
    else if ( isdefined( self.covernode ) )
    {
        node = self.covernode;
    }
    else if ( isdefined( self._blackboard.lastusednode ) )
    {
        node = self._blackboard.lastusednode;
    }
    
    if ( !( isdefined( node ) && isdefined( node.script_balcony ) ) )
    {
        return false;
    }
    
    if ( abs( angleclamp180( node.angles[ 1 ] - self.angles[ 1 ] ) ) > 30 )
    {
        return false;
    }
    
    if ( isdefined( self.script_chance ) )
    {
        if ( randomfloat( 1 ) > self.script_chance )
        {
            return false;
        }
    }
    
    if ( self nearnode( node ) )
    {
        self._blackboard.balconydeathnode = node;
        return true;
    }
    
    return false;
}

// Namespace death
// Params 4
// Checksum 0x1cfc67, Offset: 0x234c
// Size: 0x47, Type: bool
function shouldplaybalconyraildeath( asmname, statename, tostatename, params )
{
    return self._blackboard.balconydeathnode.script_balcony == 1;
}

// Namespace death
// Params 4
// Checksum 0x6a2f1ff5, Offset: 0x239c
// Size: 0x38
function choosebalconydeathanim( asmname, statename, tostatename, params )
{
    return asm::asm_lookupanimfromalias( statename, self.currentpose );
}

// Namespace death
// Params 4
// Checksum 0x115d2045, Offset: 0x23dd
// Size: 0x14d, Type: bool
function shouldplaystrongdamagedeath( asmname, statename, tostatename, params )
{
    objweapon = self.damageweapon;
    
    if ( !isdefined( objweapon ) || isnullweapon( objweapon ) )
    {
        return false;
    }
    
    if ( utility::doinglongdeath() )
    {
        return false;
    }
    
    if ( self.currentpose == "prone" || isdefined( self.a.onback ) )
    {
        return false;
    }
    
    if ( self.damagemod == "MOD_MELEE" )
    {
        return false;
    }
    
    if ( abs( self.damageyaw ) < 45 )
    {
        return false;
    }
    
    if ( self.damagetaken > 500 )
    {
        return true;
    }
    
    if ( self.a.movement == "run" && !isattackerwithindist( self.attacker, 275 ) )
    {
        if ( randomint( 100 ) < 65 )
        {
            return false;
        }
    }
    
    if ( utility_common::issniperrifle( objweapon ) && self.maxhealth < self.damagetaken )
    {
        return true;
    }
    
    if ( utility_common::isshotgun( objweapon ) && isattackerwithindist( self.attacker, 512 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace death
// Params 0
// Checksum 0x4fe40398, Offset: 0x2533
// Size: 0x143
function c6_scriptablecleanup()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self.bt.disabledismemberbehaviors = 1;
    
    if ( isdefined( self.asm.bpreragdolled ) )
    {
        return;
    }
    
    self.asm.bpreragdolled = 1;
    self.scriptablecleanup = 1;
    
    if ( !isdefined( self._blackboard.scriptableparts ) )
    {
        return;
    }
    
    foreach ( partname, part in self._blackboard.scriptableparts )
    {
        state = part.state;
        
        if ( state == "normal" )
        {
            continue;
        }
        
        if ( issubstr( state, "_both" ) )
        {
            state = "dmg_both";
        }
        
        self setscriptablepartstate( partname, state + "_stopfx" );
    }
    
    self setscriptablepartstate( "torso_overload_fx", "normal" );
}

// Namespace death
// Params 0
// Checksum 0xab256fd8, Offset: 0x267e
// Size: 0x10f
function c8_scriptablecleanup()
{
    self.bt.disabledismemberbehaviors = 1;
    
    if ( isdefined( self.asm.bpreragdolled ) )
    {
        return;
    }
    
    self.asm.bpreragdolled = 1;
    self.scriptablecleanup = 1;
    
    if ( !isdefined( self._blackboard.scriptableparts ) )
    {
        return;
    }
    
    foreach ( partname, part in self._blackboard.scriptableparts )
    {
        if ( issubstr( partname, "dmg_fx" ) )
        {
            self setscriptablepartstate( partname, "stopfx" );
        }
    }
    
    self setscriptablepartstate( "torso_overload_fx", "normal" );
}

// Namespace death
// Params 3
// Checksum 0xbaaacdd7, Offset: 0x2795
// Size: 0x5c
function choosemovingdeathanim( asmname, statename, params )
{
    curspeed = length( self.velocity );
    speedstring = getnearestspeedthresholdname( self, curspeed );
    movingdeathanims = [];
    return asm::asm_lookupanimfromalias( statename, speedstring );
}

// Namespace death
// Params 3
// Checksum 0x8113e8c0, Offset: 0x281a
// Size: 0x7c
function choosecrouchingdeathanim( asmname, statename, params )
{
    if ( utility::damagelocationisany( "head", "neck" ) )
    {
        return asm::asm_lookupanimfromalias( statename, "head" );
    }
    
    if ( utility::damagelocationisany( "torso_upper", "torso_lower", "left_arm_upper", "right_arm_upper", "neck" ) )
    {
        return asm::asm_lookupanimfromalias( statename, "torso" );
    }
    
    return asm::asm_lookupanimfromalias( statename, "default" );
}

// Namespace death
// Params 3
// Checksum 0xe5af2b99, Offset: 0x289f
// Size: 0x1b9
function choosecoverdeathanim( asmname, statename, params )
{
    assert( isdefined( params ), "<dev string:x287>" + statename );
    
    switch ( params )
    {
        case #"hash_f1676baca0ae608b":
            return asm::asm_lookupanimfromalias( statename, "stand" );
        case #"hash_a315be2e1164ff6b":
            return asm::asm_lookupanimfromalias( statename, "exposed" );
        case #"hash_9d76c99eddd14433":
            if ( utility::damagelocationisany( "head", "neck" ) && ( self.damageyaw > 135 || self.damageyaw <= -45 ) )
            {
                return asm::asm_lookupanimfromalias( statename, "crouch_head" );
            }
            
            if ( self.damageyaw > -45 && self.damageyaw <= 45 )
            {
                return asm::asm_lookupanimfromalias( statename, "crouch_back" );
            }
            
            return asm::asm_lookupanimfromalias( statename, "crouch_default" );
        case #"hash_175771022bc5e75d":
            if ( self.currentpose == "stand" )
            {
                return asm::asm_lookupanimfromalias( statename, "right_stand" );
            }
            else
            {
                if ( utility::damagelocationisany( "head", "neck" ) )
                {
                    return asm::asm_lookupanimfromalias( statename, "right_crouch_head" );
                }
                
                return asm::asm_lookupanimfromalias( statename, "right_crouch_default" );
            }
        case #"hash_4ddb655e251e06c8":
            if ( self.currentpose == "stand" )
            {
                return asm::asm_lookupanimfromalias( statename, "left_stand" );
            }
            else
            {
                return asm::asm_lookupanimfromalias( statename, "left_crouch" );
            }
        case #"hash_307cdefbc9ff53fa":
            return asm::asm_lookupanimfromalias( statename, "3d" );
    }
    
    assertmsg( "<dev string:x2b0>" );
}

// Namespace death
// Params 3
// Checksum 0x4543aaf9, Offset: 0x2a60
// Size: 0x249
function choosestandingdeathanim( asmname, statename, params )
{
    if ( utility_common::isusingsidearm() )
    {
        return choosestandingpistoldeathanim( asmname, statename, params );
    }
    
    if ( isdefined( self.attacker ) && self shouldplaymeleedeathanim( self.attacker ) )
    {
        return choosestandingmeleedeathanim( asmname, statename, params );
    }
    
    deathanims = [];
    
    if ( utility::damagelocationisany( "torso_lower", "left_leg_upper", "left_leg_lower", "right_leg_lower", "right_leg_lower" ) )
    {
        deathanims[ deathanims.size ] = asm::asm_lookupanimfromalias( statename, "lower_body" );
    }
    else if ( utility::damagelocationisany( "head", "helmet" ) )
    {
        deathanims[ deathanims.size ] = asm::asm_lookupanimfromalias( statename, "head" );
    }
    else if ( utility::damagelocationisany( "neck" ) )
    {
        deathanims[ deathanims.size ] = asm::asm_lookupanimfromalias( statename, "neck" );
    }
    else if ( utility::damagelocationisany( "torso_upper", "left_arm_upper" ) )
    {
        deathanims[ deathanims.size ] = asm::asm_lookupanimfromalias( statename, "left_shoulder" );
    }
    
    if ( utility::damagelocationisany( "torso_upper" ) )
    {
        deathanims[ deathanims.size ] = asm::asm_lookupanimfromalias( statename, "torso_upper" );
    }
    
    if ( self.damageyaw > 135 || self.damageyaw <= -135 )
    {
        if ( utility::damagelocationisany( "neck", "head", "helmet" ) )
        {
            deathanims[ deathanims.size ] = asm::asm_lookupanimfromalias( statename, "torso_2" );
        }
        
        if ( utility::damagelocationisany( "torso_upper" ) )
        {
            deathanims[ deathanims.size ] = asm::asm_lookupanimfromalias( statename, "torso_2" );
        }
    }
    else if ( self.damageyaw > -45 && self.damageyaw <= 45 )
    {
        deathanims[ deathanims.size ] = asm::asm_lookupanimfromalias( statename, "back" );
    }
    
    var_3e4cdc6088d828b1 = deathanims.size > 0;
    
    if ( !var_3e4cdc6088d828b1 || randomint( 100 ) < 15 )
    {
        deathanims[ deathanims.size ] = asm::asm_lookupanimfromalias( statename, "default" );
    }
    
    if ( randomint( 100 ) < 10 && firingdeathallowed() )
    {
        deathanims[ deathanims.size ] = asm::asm_lookupanimfromalias( statename, "default_firing" );
    }
    
    assert( deathanims.size > 0 );
    return deathanims[ randomint( deathanims.size ) ];
}

// Namespace death
// Params 3
// Checksum 0xf127e769, Offset: 0x2cb2
// Size: 0x21e
function chooseexplosivedeathanim( asmname, statename, params )
{
    ismolotov = 0;
    objweapon = self.damageweapon;
    
    if ( !isnullweapon( objweapon ) && self.unittype != "juggernaut" && utility::shouldburnfromdamage( objweapon ) )
    {
        if ( asm::asm_hasalias( statename, "molotov_f" ) )
        {
            ismolotov = 1;
        }
    }
    
    deathalias = undefined;
    
    if ( ismolotov && self.currentpose == "prone" )
    {
        deathalias = "molotov_prone";
    }
    else
    {
        deathalias = "explosive";
        
        if ( ismolotov )
        {
            deathalias = "molotov";
        }
        
        if ( self.currentpose == "crouch" )
        {
            deathalias += "_crouch";
        }
        else if ( self.currentpose == "prone" )
        {
            deathalias += "_prone";
        }
        
        deathalias += pain::getpaindirectiontoactor();
    }
    
    deathanim = asm::asm_lookupanimfromalias( statename, deathalias );
    
    if ( ismolotov )
    {
        deathanim = preventrecentanimindex( self, statename, deathalias, deathanim );
    }
    
    deathxanim = asm::asm_getxanim( statename, deathanim );
    
    if ( getdvar( @"hash_f53ba58df3983a20", "on" ) == "on" )
    {
        t = 1;
        ragdollnotetracks = getnotetracktimes( deathxanim, "start_ragdoll" );
        
        if ( ragdollnotetracks.size > 0 )
        {
            t = ragdollnotetracks[ 0 ];
        }
        
        localdeltavector = getmovedelta( deathxanim, 0, t );
        endpoint = self localtoworldcoords( localdeltavector );
        can_move = 0;
        
        if ( utility::actor_is3d() )
        {
            can_move = navtrace3d( self.origin, endpoint, 0 );
        }
        else
        {
            can_move = self maymovefrompointtopoint( self.origin, endpoint, 0, 1 );
        }
        
        if ( !can_move )
        {
            if ( ismolotov )
            {
                deathanim = asm::asm_lookupanimfromalias( statename, "default_molotov" );
            }
            else
            {
                deathanim = asm::asm_lookupanimfromalias( statename, "default" );
            }
        }
    }
    
    self.deathanimmode = "nogravity";
    return deathanim;
}

// Namespace death
// Params 3
// Checksum 0xf4a217e3, Offset: 0x2ed9
// Size: 0x15b
function choosestandingpistoldeathanim( asmname, statename, params )
{
    if ( abs( self.damageyaw ) < 50 )
    {
        return asm::asm_lookupanimfromalias( statename, "pistol_2" );
    }
    
    deathanims = [];
    
    if ( abs( self.damageyaw ) < 110 )
    {
        deathanims[ deathanims.size ] = asm::asm_lookupanimfromalias( statename, "pistol_2" );
    }
    
    if ( utility::damagelocationisany( "torso_upper", "torso_lower", "left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower" ) )
    {
        deathanims[ deathanims.size ] = asm::asm_lookupanimfromalias( statename, "pistol_torso_upper" );
    }
    
    if ( !utility::damagelocationisany( "head", "neck", "helmet", "left_foot", "right_foot", "left_hand", "right_hand", "gun" ) && randomint( 2 ) == 0 )
    {
        deathanims[ deathanims.size ] = asm::asm_lookupanimfromalias( statename, "pistol_upper_body" );
    }
    
    if ( deathanims.size == 0 || utility::damagelocationisany( "torso_lower", "torso_upper", "neck", "head", "helmet", "right_arm_upper", "left_arm_upper" ) )
    {
        deathanims[ deathanims.size ] = asm::asm_lookupanimfromalias( statename, "pistol_default" );
    }
    
    assert( deathanims.size > 0 );
    return deathanims[ randomint( deathanims.size ) ];
}

// Namespace death
// Params 3
// Checksum 0x355dd243, Offset: 0x303d
// Size: 0x2b
function choosestandingmeleedeathanim( asmname, statename, params )
{
    return asm::asm_lookupanimfromalias( statename, "default" );
}

// Namespace death
// Params 0
// Checksum 0xe002fc77, Offset: 0x3071
// Size: 0x3, Type: bool
function firingdeathallowed()
{
    return false;
}

// Namespace death
// Params 2
// Checksum 0x6e2583cb, Offset: 0x307d
// Size: 0x11f
function play_blood_pool( note, flagname )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( isdefined( self.skipbloodpool ) )
    {
        assert( self.skipbloodpool, "<dev string:x2e1>" );
        return;
    }
    
    tagpos = self gettagorigin( "j_SpineUpper" );
    tagangles = self gettagangles( "j_SpineUpper" );
    forward = anglestoforward( tagangles );
    up = anglestoup( tagangles );
    right = anglestoright( tagangles );
    tagpos = tagpos + forward * -8.5 + up * 5 + right * 0;
    trace = trace::_bullet_trace( tagpos + ( 0, 0, 30 ), tagpos - ( 0, 0, 100 ), 0, undefined );
    
    if ( trace[ "normal" ][ 2 ] > 0.9 )
    {
        playfx( level._effect[ "deathfx_bloodpool_generic" ], trace[ "position" ] + ( 0, 0, 1 ) );
    }
}

// Namespace death
// Params 1
// Checksum 0xbf66b33c, Offset: 0x31a4
// Size: 0xc3, Type: bool
function shouldhelmetpoponpain( bexplosivedamage )
{
    if ( !self.shouldhelmetpop )
    {
        return false;
    }
    
    if ( isdefined( self.lastattacker ) && self.lastattacker.team == self.team )
    {
        return false;
    }
    
    if ( isdefined( self.helmetsubpart ) && !bexplosivedamage )
    {
        return false;
    }
    
    if ( isdefined( self.onlyhelmetpopondeath ) && self.onlyhelmetpopondeath )
    {
        return false;
    }
    
    if ( isdefined( self.magic_bullet_shield ) && self.magic_bullet_shield )
    {
        return false;
    }
    
    if ( self.damagelocation == "helmet" )
    {
        return true;
    }
    
    if ( bexplosivedamage && randomint( 2 ) == 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace death
// Params 1
// Checksum 0x397f4ca3, Offset: 0x3270
// Size: 0xae, Type: bool
function shouldhelmetpopondeath( bexplosivedamage )
{
    if ( !self.shouldhelmetpop )
    {
        return false;
    }
    
    if ( self.unittype != "soldier" && self.unittype != "juggernaut" )
    {
        return false;
    }
    
    if ( self.damagemod == "MOD_MELEE" && randomint( 3 ) < 2 )
    {
        return false;
    }
    
    if ( isdefined( self.damagelocation ) && ( self.damagelocation == "helmet" || self.damagelocation == "head" ) )
    {
        return true;
    }
    
    if ( bexplosivedamage && randomint( 3 ) == 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace death
// Params 0
// Checksum 0x4d344bc4, Offset: 0x3327
// Size: 0x243
function helmetpop()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.hatmodel ) )
    {
        return;
    }
    
    if ( isdefined( self.dontbreakhelmet ) && self.dontbreakhelmet )
    {
        return;
    }
    
    pos = self gettagorigin( "j_head" );
    
    if ( isdefined( self.helmetshatterfx ) )
    {
        forward = anglestoforward( self gettagangles( "j_head" ) );
        playfx( self.helmetshatterfx, pos, forward );
    }
    
    playsoundatpos( pos, "prj_bullet_small_flesh_helmet_npc" );
    
    if ( isdefined( self.helmetsubpart ) )
    {
        self.helmetsubpart = undefined;
        damage = self getdamageparthealth( "helmet", "helmet" );
        
        if ( damage > 0 )
        {
            self damagedamagepart( damage, "helmet", "helmet" );
        }
    }
    
    partname = getpartname( self.hatmodel, 0 );
    model = spawn( "script_model", self.origin + ( 0, 0, 64 ) );
    model setmodel( self.hatmodel );
    model.origin = self gettagorigin( partname );
    model.angles = self gettagangles( partname );
    waitframe();
    
    if ( isdefined( self.damagedir ) && self.damagedir != ( 0, 0, 0 ) )
    {
        model thread helmetlaunch( self.damagedir );
    }
    else
    {
        model thread helmetlaunch( ( randomfloatrange( -0.25, 0.25 ), randomfloatrange( -0.25, 0.25 ), randomfloatrange( -1, 1 ) ) );
    }
    
    self detach( self.hatmodel, "" );
    self.hatmodel = undefined;
    self hidepartandchildren_allinstances( "j_helmet" );
    
    if ( isalive( self ) && shouldplaysuffocatedeath() )
    {
        playfxontag( level.g_effect[ "helmet_break_suffocate" ], self, "j_head" );
        
        if ( self.asmname != "zero_gravity_space" && self.asmname != "zero_gravity" )
        {
            self.deathbysuffocation = 1;
        }
        
        self kill();
    }
}

// Namespace death
// Params 1
// Checksum 0x391c1974, Offset: 0x3572
// Size: 0xdc
function helmetlaunch( damagedir )
{
    launchforce = damagedir;
    launchforce *= randomfloatrange( 2000, 4000 );
    forcex = launchforce[ 0 ];
    forcey = launchforce[ 1 ];
    forcez = randomfloatrange( 1500, 3000 );
    contactpoint = self.origin + ( randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ), randomfloatrange( -1, 1 ) ) * 5;
    self physicslaunchclient( contactpoint, ( forcex, forcey, forcez ) );
    wait 60;
    
    while ( true )
    {
        if ( !isdefined( self ) )
        {
            return;
        }
        
        if ( distancesquared( self.origin, level.player.origin ) > 262144 )
        {
            break;
        }
        
        wait 30;
    }
    
    self delete();
}

// Namespace death
// Params 0
// Checksum 0xd4d39418, Offset: 0x3656
// Size: 0x20
function getsuffocationdeathanim()
{
    animation = undefined;
    
    if ( randomint( 11 ) >= 1 )
    {
        return animation;
    }
    
    return animation;
}

// Namespace death
// Params 0
// Checksum 0x80ac3e7, Offset: 0x367f
// Size: 0x3, Type: bool
function shouldplaysuffocatedeath()
{
    return false;
}

// Namespace death
// Params 1
// Checksum 0xe0bcc10c, Offset: 0x368b
// Size: 0xc2, Type: bool
function shouldheadpop( bexplosivedamage )
{
    if ( self.unittype != "soldier" && self.unittype != "juggernaut" )
    {
        return false;
    }
    
    if ( isdefined( self.forceheadpop ) )
    {
        return true;
    }
    
    if ( self.damagemod == "MOD_MELEE" )
    {
        return false;
    }
    
    if ( self.damagemod == "MOD_FIRE" )
    {
        return false;
    }
    
    objweapon = self.damageweapon;
    
    if ( isnullweapon( objweapon ) )
    {
        return false;
    }
    
    if ( self.damagemod == "MOD_PROJECTILE" && objweapon.classname == "turret" && level.disableheadpopbyturret )
    {
        return false;
    }
    
    return false;
}

// Namespace death
// Params 0
// Checksum 0x31c180e4, Offset: 0x3756
// Size: 0x63
function headpop()
{
    if ( !isdefined( self.headmodel ) )
    {
        return;
    }
    
    playfxontag( level.g_effect[ "human_gib_head" ], self, "j_head" );
    playfxontag( level.g_effect[ "human_gib_head_cap" ], self, "j_spine4" );
    self detach( self.headmodel, "" );
    self.headmodel = undefined;
}

// Namespace death
// Params 2
// Checksum 0x575ab29e, Offset: 0x37c1
// Size: 0x26
function cross2d( a, b )
{
    return a[ 0 ] * b[ 1 ] - b[ 0 ] * a[ 1 ];
}

// Namespace death
// Params 2
// Checksum 0xed9df66e, Offset: 0x37f0
// Size: 0x71
function meleegetattackercardinaldirection( vector2dtargetforward, var_16a399db157f1235 )
{
    dot = vectordot( var_16a399db157f1235, vector2dtargetforward );
    var_d47fb2df3a989683 = cos( 60 );
    
    if ( squared( dot ) < squared( var_d47fb2df3a989683 ) )
    {
        if ( cross2d( vector2dtargetforward, var_16a399db157f1235 ) > 0 )
        {
            return 1;
        }
        else
        {
            return 3;
        }
        
        return;
    }
    
    if ( dot < 0 )
    {
        return 0;
    }
    
    return 2;
}

// Namespace death
// Params 1
// Checksum 0xf8bcf8de, Offset: 0x3869
// Size: 0x1af
function orientmeleevictim( directional_orient )
{
    if ( getdvarint( @"hash_7082b8028e0e3576", 0 ) == 1 )
    {
        knifeweapon = makeweapon( "iw7_knife_upgrade1" );
        sonicweapon = makeweapon( "iw7_sonic" );
        
        if ( utility::isdamageweapon( sonicweapon ) || utility::isdamageweapon( knifeweapon ) )
        {
            return;
        }
    }
    
    if ( directional_orient || self.damagemod == "MOD_MELEE" && isdefined( self.attacker ) && !utility::wasdamagedbyoffhandshield() )
    {
        if ( utility::actor_is3d() )
        {
            var_39c5c2c40c02b3b3 = self.attacker.origin - self.origin;
            var_ae0504532fb8cb54 = generateaxisanglesfromforwardvector( var_39c5c2c40c02b3b3, self.angles );
            self orientmode( "face angle 3d", var_ae0504532fb8cb54 );
            return;
        }
        
        var_7685720aefa4c0c7 = self.damagedir;
        victimforward3d = anglestoforward( self.angles );
        var_7681440aefa065c6 = vectornormalize( ( var_7685720aefa4c0c7[ 0 ], var_7685720aefa4c0c7[ 1 ], 0 ) );
        victimforward2d = vectornormalize( ( victimforward3d[ 0 ], victimforward3d[ 1 ], 0 ) );
        cardinaldirection = meleegetattackercardinaldirection( victimforward2d, var_7681440aefa065c6 );
        rotateyawamount = cardinaldirection * 90;
        var_39c1e4c40bff08a2 = ( -1 * var_7681440aefa065c6[ 0 ], -1 * var_7681440aefa065c6[ 1 ], 0 );
        resultvector = rotatevector( var_39c1e4c40bff08a2, ( 0, rotateyawamount, 0 ) );
        targetyaw = vectortoyaw( resultvector );
        self orientmode( "face angle", targetyaw );
    }
}

// Namespace death
// Params 0
// Checksum 0xf02d37a9, Offset: 0x3a20
// Size: 0x55, Type: bool
function function_aeabeb8eeef5193f()
{
    if ( getdvarint( @"hash_89297eebf107ff23", 1 ) == 0 )
    {
        return true;
    }
    
    if ( !isdefined( self.attacker.lastkillalertsoundtime ) || gettime() > self.attacker.lastkillalertsoundtime + 700 )
    {
        return false;
    }
    
    return true;
}

// Namespace death
// Params 0
// Checksum 0x5a553d26, Offset: 0x3a7e
// Size: 0xe8
function function_8bf9a5ed5baebbbd()
{
    isbullet = isdefined( self.damageweapon ) && weapontype( self.damageweapon ) == "bullet";
    
    if ( isplayer( self.attacker ) && isbullet && !function_aeabeb8eeef5193f() )
    {
        headshot_alias = soundexists( "sp_kill_alert_head" ) ? "sp_kill_alert_head" : "bullet_impact_headshot";
        var_42ad7a7d60de5075 = soundexists( "sp_kill_alert" ) ? "sp_kill_alert" : "mp_kill_alert";
        
        if ( utility::damagelocationisany( "head", "helmet" ) )
        {
            namespace_9d8e359c3b1041e5::playsoundtoplayersharedfunc( headshot_alias, level.player );
        }
        else
        {
            namespace_9d8e359c3b1041e5::playsoundtoplayersharedfunc( var_42ad7a7d60de5075, level.player );
        }
        
        self.attacker.lastkillalertsoundtime = gettime();
    }
}

// Namespace death
// Params 1
// Checksum 0x8b549a95, Offset: 0x3b6e
// Size: 0x1a9
function playdeathsound( bexplosivedamage )
{
    if ( utility::issp() )
    {
        function_8bf9a5ed5baebbbd();
    }
    
    if ( self.var_70fbc1727d54c322 )
    {
        return;
    }
    
    if ( isdefined( self.diequietly ) && self.diequietly )
    {
        if ( isplayer( self.attacker ) || isplayer( self.lastattacker ) )
        {
            dialoguetype = "death_quiet";
        }
        else
        {
            return;
        }
    }
    
    if ( shouldskipdeathsound() )
    {
        return;
    }
    
    if ( isdefined( self.diequietly ) && self.diequietly )
    {
        dialoguetype = "death_quiet";
    }
    else
    {
        dialoguetype = "death";
    }
    
    dmgammo = undefined;
    rootname = undefined;
    
    if ( self.damagemod == "MOD_MELEE" )
    {
        if ( isdefined( self.diequietly ) && self.diequietly )
        {
            dialoguetype = "death_quiet";
        }
        else
        {
            dialoguetype = "death";
        }
    }
    else
    {
        if ( isdefined( self.damageweapon ) && !isnullweapon( self.damageweapon ) )
        {
            dmgammo = getweaponammopoolname( self.damageweapon );
            rootname = getweaponrootstring( self.damageweapon );
        }
        
        if ( bexplosivedamage )
        {
            if ( isdefined( rootname ) && rootname == "molotov" )
            {
                dialoguetype = "flamedeath";
            }
            else
            {
                dialoguetype = "explodeath";
            }
        }
        else
        {
            if ( isdefined( self._blackboard.balconydeathnode ) )
            {
                dialoguetype = "falldeath";
            }
            
            if ( dmgammo == %"incendiary" )
            {
                dialoguetype = "incendeath";
            }
        }
    }
    
    face::saygenericdialogue( dialoguetype );
}

// Namespace death
// Params 0
// Checksum 0x70c32323, Offset: 0x3d1f
// Size: 0x81, Type: bool
function shouldskipdeathsound()
{
    if ( !getdvarint( @"hash_f133094f3b5288b6", 0 ) && utility::damagelocationisany( "head", "helmet" ) )
    {
        if ( isdefined( self.damageweapon ) && !isnullweapon( self.damageweapon ) )
        {
            if ( self.damageweapon.classname == "spread" )
            {
                return false;
            }
            
            if ( getweaponrootstring( self.damageweapon ) == "molotov" )
            {
                return false;
            }
        }
        
        return true;
    }
    
    return false;
}

// Namespace death
// Params 1
// Checksum 0x1142a440, Offset: 0x3da9
// Size: 0x43
function removeselffrom_squadlastseenenemypos( org )
{
    for ( i = 0; i < anim.squadindex.size ; i++ )
    {
        anim.squadindex[ i ] clearsightposnear( org );
    }
}

// Namespace death
// Params 1
// Checksum 0x66babd8a, Offset: 0x3df4
// Size: 0x47
function clearsightposnear( org )
{
    if ( !isdefined( self.sightpos ) )
    {
        return;
    }
    
    if ( distance( org, self.sightpos ) < 80 )
    {
        self.sightpos = undefined;
        self.sighttime = gettime();
    }
}

// Namespace death
// Params 4
// Checksum 0x939a2fa4, Offset: 0x3e43
// Size: 0x4b, Type: bool
function function_c3de7d75aca70be7( asmname, statename, params, dist )
{
    if ( isplayerwithindist( asmname, statename, params, dist ) )
    {
        return true;
    }
    
    if ( self actorgetgroundslope() < 0.96 )
    {
        return true;
    }
    
    return false;
}

// Namespace death
// Params 4
// Checksum 0x3e7a52de, Offset: 0x3e97
// Size: 0x4e, Type: bool
function isplayerwithindist( asmname, statename, params, dist )
{
    player = function_47c86977a18df38b( level.players, self.origin, dist );
    return isdefined( player );
}

// Namespace death
// Params 2
// Checksum 0xee70d8f4, Offset: 0x3eee
// Size: 0x40, Type: bool
function isattackerwithindist( attacker, maxdist )
{
    if ( !isdefined( attacker ) )
    {
        return false;
    }
    
    if ( distance( self.origin, attacker.origin ) > maxdist )
    {
        return false;
    }
    
    return true;
}

// Namespace death
// Params 4
// Checksum 0xd8d8ff5f, Offset: 0x3f37
// Size: 0x44, Type: bool
function function_97493cf6304063b( asmname, statename, tostatename, params )
{
    speed = self aigettargetspeed();
    
    if ( speed >= 160 )
    {
        return true;
    }
    
    return false;
}

// Namespace death
// Params 4
// Checksum 0x93e337da, Offset: 0x3f84
// Size: 0x34, Type: bool
function isspecialdeath( asmname, statename, tostatename, params )
{
    if ( utility::isshocked() )
    {
        return true;
    }
    
    return false;
}

// Namespace death
// Params 3
// Checksum 0x97f9737e, Offset: 0x3fc1
// Size: 0x49
function choosespecialdeath( asmname, statename, params )
{
    if ( utility::isshocked() )
    {
        return asm::asm_lookupanimfromalias( statename, "shock_death" );
    }
    
    return asm::asm_lookupanimfromalias( "death_generic", "default" );
}

// Namespace death
// Params 0
// Checksum 0xdcfcc417, Offset: 0x4012
// Size: 0xf1, Type: bool
function shouldgib()
{
    if ( !isdismembermentenabled() )
    {
        return false;
    }
    
    if ( isdefined( self.nogib ) )
    {
        return false;
    }
    
    if ( self.unittype != "soldier" && self.unittype != "juggernaut" && self.unittype != "civilian" )
    {
        return false;
    }
    
    if ( self.damagemod == "MOD_MELEE" )
    {
        return false;
    }
    
    if ( isexplosivedamagemod( self.damagemod ) )
    {
        if ( isdefined( self.lastattacker ) && ( self.lastattacker.asmname == "suicidebomber" || self.lastattacker.asmname == "suicidebomber_cp" ) )
        {
            return true;
        }
        
        if ( isdefined( self.damageweapon ) && self.damageweapon.basename == "suicide_vest" )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace death
// Params 1
// Checksum 0xabd61cdd, Offset: 0x410c
// Size: 0x100
function dogibdefault( victim )
{
    origin = victim gettagorigin( "j_spine4" );
    
    if ( isdefined( victim.damagedir ) && victim.damagedir != ( 0, 0, 0 ) )
    {
        playfx( level.g_effect[ "human_gib_fullbody" ], origin, victim.damagedir );
    }
    else
    {
        playfx( level.g_effect[ "human_gib_fullbody" ], origin, ( 1, 0, 0 ) );
    }
    
    if ( isagent( victim ) )
    {
        victim playsound( "gib_fullbody" );
        return;
    }
    
    ent = spawn( "script_origin", origin );
    ent.targetname = "doGibDefault";
    ent playsound( "gib_fullbody", "sounddone" );
    ent waittill( #"sounddone" );
    wait 0.1;
    ent delete();
}

// Namespace death
// Params 0
// Checksum 0xf77bd294, Offset: 0x4214
// Size: 0x29
function dogib()
{
    if ( isdefined( self.gib_override_func ) )
    {
        level thread [[ self.gib_override_func ]]( self );
        return;
    }
    
    level thread dogibdefault( self );
}

// Namespace death
// Params 4
// Checksum 0x14c93f10, Offset: 0x4245
// Size: 0xd5, Type: bool
function shouldplayshieldbashdeath( asmname, statename, tostatename, params )
{
    objweapon = self.damageweapon;
    
    if ( isdefined( objweapon ) )
    {
        if ( objweapon.type == "shield" )
        {
            return true;
        }
        
        weaponname = objweapon.basename;
        
        if ( weaponname == "iw7_mauler_c8hack" || weaponname == "iw7_c6hack_melee" || weaponname == "iw7_c6worker_fists" )
        {
            return true;
        }
    }
    
    if ( isdefined( self.lastattacker ) && self.lastattacker.unittype == "c8" && self.damagemod == "MOD_MELEE" )
    {
        return true;
    }
    
    return false;
}

// Namespace death
// Params 4
// Checksum 0x857f7e67, Offset: 0x4323
// Size: 0x1b2
function doshieldbashdeath( asmname, statename, tostatename, params )
{
    stop_sounds();
    shared::dropallaiweapons();
    impactdir = vectornormalize( self.origin - level.player.origin + ( 0, 0, 30 ) );
    objweapon = self.damageweapon;
    weaponname = objweapon.basename;
    
    if ( weaponname == "iw7_c6hack_melee" || weaponname == "iw7_c6worker_fists" )
    {
        impactdir = vectornormalize( self.origin - level.player.origin + ( 0, 0, 30 ) + anglestoright( level.player.angles ) * 50 );
    }
    
    self setanimrate( asm::asm_getroot(), 0 );
    
    if ( isdefined( self.fnpreragdoll ) )
    {
        self [[ self.fnpreragdoll ]]();
    }
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self startragdollfromimpact( "torso_upper", impactdir * 2400 );
    
    if ( self.unittype == "c6" )
    {
        self playsound( "shield_death_c6_1" );
    }
    
    level.player playrumblelooponentity( "damage_heavy" );
    earthquake( 0.5, 1, level.player.origin, 100 );
    level.player utility::delaycall( 0.25, &stoprumble, "damage_heavy" );
    wait 1;
    deathcleanup();
}

// Namespace death
// Params 0
// Checksum 0xe5dd498f, Offset: 0x44dd
// Size: 0xcf
function getpainbodypartdeath()
{
    if ( utility::damagelocationisany( "head", "helmet", "neck" ) )
    {
        part = "head";
        return part;
    }
    
    if ( utility::damagelocationisany( "right_arm_upper", "right_arm_lower", "right_hand" ) )
    {
        part = "midbody";
        return part;
    }
    
    if ( utility::damagelocationisany( "left_arm_upper", "left_arm_lower", "left_hand" ) )
    {
        part = "midbody";
        return part;
    }
    
    if ( utility::damagelocationisany( "left_leg_upper", "left_leg_lower", "left_foot" ) )
    {
        part = "lowerbody_l";
        return part;
    }
    
    if ( utility::damagelocationisany( "right_leg_upper", "right_leg_lower", "right_foot" ) )
    {
        part = "lowerbody_r";
        return part;
    }
    
    part = "midbody";
    return part;
}

// Namespace death
// Params 0
// Checksum 0x4f91ef63, Offset: 0x45b4
// Size: 0x3b
function getpainbodypartcrouchdeath()
{
    if ( utility::damagelocationisany( "head", "helmet", "neck" ) )
    {
        part = "head";
        return part;
    }
    
    part = "midbody";
    return part;
}

// Namespace death
// Params 3
// Checksum 0xc7352345, Offset: 0x45f7
// Size: 0x17f
function choosedirectionaldeathanim( asmname, statename, params )
{
    size = pain::getpainweaponsize();
    
    if ( isdefined( self.currentpose ) && self.var_45ac78ae9c0236a9 == "lowerbody" && self.var_ea7e0be75a240d38 == "_lg" && self.currentpose == "prone" )
    {
        part = "lowerbody";
        size = "_lg";
    }
    else
    {
        part = getpainbodypartdeath();
        size = pain::getpainweaponsize();
    }
    
    victimforward3d = anglestoforward( self.angles );
    var_7681440aefa065c6 = vectornormalize( ( self.damagedir[ 0 ], self.damagedir[ 1 ], 0 ) );
    victimforward2d = vectornormalize( ( victimforward3d[ 0 ], victimforward3d[ 1 ], 0 ) );
    cardinaldirection = meleegetattackercardinaldirection( victimforward2d, var_7681440aefa065c6 );
    deathdir = undefined;
    
    if ( cardinaldirection == 2 )
    {
        deathdir = "_8";
    }
    else if ( cardinaldirection == 3 )
    {
        deathdir = "_6";
    }
    else if ( cardinaldirection == 1 )
    {
        deathdir = "_4";
    }
    else
    {
        deathdir = "_2";
    }
    
    if ( shouldfireintoairdeath( statename, part ) )
    {
        aliasdeath = "fire_into_air";
    }
    else
    {
        aliasdeath = part + size + deathdir;
    }
    
    return asm::asm_lookupanimfromalias( statename, aliasdeath );
}

// Namespace death
// Params 3
// Checksum 0xce3b8104, Offset: 0x477f
// Size: 0x120
function choosedirectionalcrouchdeathanim( asmname, statename, params )
{
    part = getpainbodypartcrouchdeath();
    size = pain::getpainweaponsize();
    victimforward3d = anglestoforward( self.angles );
    var_7681440aefa065c6 = vectornormalize( ( self.damagedir[ 0 ], self.damagedir[ 1 ], 0 ) );
    victimforward2d = vectornormalize( ( victimforward3d[ 0 ], victimforward3d[ 1 ], 0 ) );
    cardinaldirection = meleegetattackercardinaldirection( victimforward2d, var_7681440aefa065c6 );
    deathdir = undefined;
    
    if ( cardinaldirection == 2 )
    {
        deathdir = "_8";
    }
    else if ( cardinaldirection == 3 )
    {
        deathdir = "_6";
    }
    else if ( cardinaldirection == 1 )
    {
        deathdir = "_4";
    }
    else
    {
        deathdir = "_2";
    }
    
    if ( shouldfireintoairdeath( statename, part ) )
    {
        aliasdeath = "fire_into_air";
    }
    else
    {
        aliasdeath = part + size + deathdir;
    }
    
    return asm::asm_lookupanimfromalias( statename, aliasdeath );
}

// Namespace death
// Params 2
// Checksum 0xc098926d, Offset: 0x48a8
// Size: 0xd2, Type: bool
function shouldfireintoairdeath( statename, part )
{
    weapclass = weaponclass( self.weapon );
    diequietly = self.diequietly || weapclass == "rocketlauncher" || weapclass == "spread" || weapclass == "pistol";
    
    if ( !asm::asm_hasalias( statename, "fire_into_air" ) )
    {
        return false;
    }
    
    if ( !self._blackboard.bfire )
    {
        return false;
    }
    
    if ( diequietly )
    {
        return false;
    }
    
    if ( part == "lowerbody" )
    {
        return false;
    }
    
    if ( part == "head" )
    {
        chance = 0.3;
    }
    else
    {
        chance = 0.15;
    }
    
    return randomfloat( 1 ) < chance;
}

// Namespace death
// Params 3
// Checksum 0x7e2d04b5, Offset: 0x4983
// Size: 0x108
function choosedirectionallargepaindeathanim( asmname, statename, params )
{
    part = "lowerbody";
    size = "_lg";
    victimforward3d = anglestoforward( self.angles );
    var_7681440aefa065c6 = vectornormalize( ( self.damagedir[ 0 ], self.damagedir[ 1 ], 0 ) );
    victimforward2d = vectornormalize( ( victimforward3d[ 0 ], victimforward3d[ 1 ], 0 ) );
    cardinaldirection = meleegetattackercardinaldirection( victimforward2d, var_7681440aefa065c6 );
    deathdir = undefined;
    
    if ( cardinaldirection == 2 )
    {
        deathdir = "_8";
    }
    else if ( cardinaldirection == 3 )
    {
        deathdir = "_6";
    }
    else if ( cardinaldirection == 1 )
    {
        deathdir = "_4";
    }
    else
    {
        deathdir = "_2";
    }
    
    aliasdeath = part + size + deathdir;
    return asm::asm_lookupanimfromalias( statename, aliasdeath );
}

