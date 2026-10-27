// scripts\asm\soldier\patrol.gsc  (hash_0d61cbbd5cf60e27.gscc) (size: 8397 Bytes / 0x20cd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8be81ea9 (2347245225)
// size ...... 8397 (0x20cd)
// includes .. 1   (offset: 0x1f49)
// strings ... 28  (offset: 0x1f51)
// dev strs .. 0   (offset: 0x20cd)
// exports ... 30  (offset: 0x12d1)
// cseg ...... 0x1ac + 0x1125 (0x12d1)
// imports ... 65  (offset: 0x1781)
// animtree1 . 0   (offset: 0x20cd)
// animtree2 . 0   (offset: 0x20cd)
#using scripts\asm\asm;

#namespace patrol;

// Namespace patrol
// Params 0
// Checksum 0x21e12b68, Offset: 0x1ca
// Size: 0x1e
function function_dc67338f3644087e()
{
    self.var_dbed7de5e9371f9e = &attachflashlight;
    self.fnstealthflashlightdetach = &detachflashlight;
}

// Namespace patrol
// Params 3
// Checksum 0xd8156cb4, Offset: 0x1f0
// Size: 0x188
function playanim_patrolreact_internal( asmname, statename, arcstatename )
{
    assert( isdefined( self.stealth ) );
    self.var_8bb2da6a6aef303 = self.var_6002aa8166897fd7;
    
    if ( shouldpatrolreactaim() )
    {
        if ( isdefined( self.var_dd6868ae78a8de98 ) && distance2dsquared( self.origin, self.var_dd6868ae78a8de98 ) > 1024 )
        {
            self setlookat( self.var_dd6868ae78a8de98 );
        }
    }
    
    reactanim = self asmgetanim( asmname, statename );
    assert( isdefined( reactanim ) );
    reactxanim = asm::asm_getxanim( arcstatename, reactanim );
    animrate = 1;
    
    if ( isdefined( self.stealthreactendtime ) )
    {
        endtime = 1;
        codemovetimes = getnotetracktimes( reactxanim, "code_move" );
        
        if ( codemovetimes.size > 0 )
        {
            endtime = codemovetimes[ 0 ];
        }
        
        animlength = getanimlength( reactxanim ) * endtime;
        desiredlength = 0.05 + ( self.stealthreactendtime - gettime() ) / 1000;
        
        if ( desiredlength < 0.2 )
        {
            desiredlength = 0.2;
        }
        
        animrate = clamp( animlength / desiredlength, 0.8, 1.3 );
        self.stealthreactendtime = undefined;
    }
    
    self aisetanim( arcstatename, reactanim, animrate );
    self function_a03c28c47bbe8db6( reactanim, arcstatename );
    asm::asm_donotetrackswithinterceptor( asmname, statename, &flashlightreactionnotehandler, undefined, arcstatename );
}

// Namespace patrol
// Params 4
// Checksum 0xb259cde0, Offset: 0x380
// Size: 0x48, Type: bool
function shouldpatrolreactaim( asmname, statename, tostatename, params )
{
    assert( isdefined( self.var_6002aa8166897fd7 ) );
    return self.var_6002aa8166897fd7 == "med";
}

// Namespace patrol
// Params 3
// Checksum 0x9b62be85, Offset: 0x3d1
// Size: 0x61
function chooseanim_patrolreactlookaround( asmname, statename, params )
{
    alias = "curious";
    
    if ( self function_53599e4efc90b08b( "med" ) || self [[ self.fnisinstealthcombat ]]() )
    {
        alias = "threat";
    }
    
    return asm::asm_lookupanimfromalias( statename, string( alias ) );
}

// Namespace patrol
// Params 3
// Checksum 0x9dc4a595, Offset: 0x43b
// Size: 0x65
function chooseanim_patrolreactlookaround_checkflashlight( asmname, statename, params )
{
    alias = string( getpatrolreactdirindex() );
    
    if ( self function_53599e4efc90b08b( "med" ) || self [[ self.fnisinstealthcombat ]]() )
    {
        alias = "threat_" + alias;
    }
    
    return chooseanim_patrol_checkflashlight( asmname, statename, alias );
}

// Namespace patrol
// Params 0
// Checksum 0x38df99ac, Offset: 0x4a9
// Size: 0x74
function getpatrolreactdirindex()
{
    reactyaw = 0;
    
    if ( isdefined( self.var_dd6868ae78a8de98 ) )
    {
        delta = self.var_dd6868ae78a8de98 - self.origin;
        
        if ( length2dsquared( delta ) < 36 )
        {
            reactyaw = 0;
        }
        else
        {
            deltayaw = vectortoyaw( delta );
            reactyaw = self.angles[ 1 ] - deltayaw;
        }
    }
    
    return getreactangleindex( reactyaw );
}

// Namespace patrol
// Params 0
// Checksum 0xbb6dd865, Offset: 0x526
// Size: 0xbf
function function_9c7d080daecb05ab()
{
    reactyaw = 0;
    
    if ( isdefined( self.var_dd6868ae78a8de98 ) )
    {
        delta = self.var_dd6868ae78a8de98 - self.origin;
        deltayaw = vectortoyaw( delta );
        reactyaw = self.angles[ 1 ] - deltayaw;
    }
    
    reactyaw = angleclamp180( reactyaw );
    directionindex = function_71a9f15871d4c043( reactyaw );
    suffix = string( directionindex );
    
    if ( reactyaw < -120 && reactyaw >= -180 )
    {
        suffix += "l";
    }
    else if ( reactyaw > 120 && reactyaw <= 180 )
    {
        suffix += "r";
    }
    
    return suffix;
}

// Namespace patrol
// Params 0
// Checksum 0xd6f8ea43, Offset: 0x5ee
// Size: 0x67
function getpatrolreactalias()
{
    assert( isdefined( self.var_6002aa8166897fd7 ) );
    suffix = function_9c7d080daecb05ab();
    
    if ( self.var_807317a89e75207b )
    {
        alias = self.var_6002aa8166897fd7 + "_close_" + suffix;
    }
    else
    {
        alias = self.var_6002aa8166897fd7 + "_" + suffix;
    }
    
    return alias;
}

// Namespace patrol
// Params 3
// Checksum 0xfe57a0bf, Offset: 0x65e
// Size: 0x7b
function chooseanim_patrolreact( asmname, statename, params )
{
    alias = getpatrolreactalias();
    animindex = asm::asm_lookupanimfromalias( statename, alias );
    
    if ( !isdefined( animindex ) )
    {
        if ( asm::asm_hasalias( statename, "med_8" ) )
        {
            return asm::asm_lookupanimfromalias( statename, "med_8" );
        }
        else
        {
            return asm::asm_lookupanimfromalias( statename, "small_8" );
        }
    }
    
    return animindex;
}

// Namespace patrol
// Params 3
// Checksum 0x4390a19f, Offset: 0x6e2
// Size: 0x3a
function chooseanim_patrolreact_checkflashlight( asmname, statename, params )
{
    alias = getpatrolreactalias();
    return chooseanim_patrol_checkflashlight( asmname, statename, alias );
}

// Namespace patrol
// Params 1
// Checksum 0x6b69c6b1, Offset: 0x725
// Size: 0x5a
function getreactangleindex( angle )
{
    angle = angleclamp180( angle );
    
    if ( angle > 135 || angle < -135 )
    {
        index = 2;
    }
    else if ( angle < -45 )
    {
        index = 4;
    }
    else if ( angle > 45 )
    {
        index = 6;
    }
    else
    {
        index = 8;
    }
    
    return index;
}

// Namespace patrol
// Params 1
// Checksum 0xb3f24c2c, Offset: 0x788
// Size: 0x5a
function function_71a9f15871d4c043( angle )
{
    angle = angleclamp180( angle );
    
    if ( angle > 120 || angle < -120 )
    {
        index = 2;
    }
    else if ( angle < -30 )
    {
        index = 4;
    }
    else if ( angle > 30 )
    {
        index = 6;
    }
    else
    {
        index = 8;
    }
    
    return index;
}

// Namespace patrol
// Params 4
// Checksum 0xceed0596, Offset: 0x7eb
// Size: 0x8d
function function_b44dc7a862e03d53( turnanim, desiredyaw, beyondyaw, endtime )
{
    currentanimtime = self aigetanimtime( turnanim );
    assert( currentanimtime < endtime );
    animyaw = getangledelta( turnanim, currentanimtime, endtime ) + beyondyaw;
    totalyaw = self.angles[ 1 ] + animyaw;
    turnyaw = angleclamp180( desiredyaw - angleclamp( totalyaw ) );
    return turnyaw;
}

// Namespace patrol
// Params 3
// Checksum 0xc1725c36, Offset: 0x881
// Size: 0x1ff, Type: bool
function handlefacegoalnotetrack( statename, note, params )
{
    if ( note == "face_goal" && isdefined( self.var_dd6868ae78a8de98 ) )
    {
        xanim = asm::asm_getxanim( self.var_9e39c400b0bfce6a, self.var_d67b0766153c9f9c );
        
        if ( !isdefined( xanim ) )
        {
            return false;
        }
        
        finishtime = getnotetracktimes( xanim, "finish" );
        
        if ( finishtime.size == 0 )
        {
            finishtime[ 0 ] = 1;
        }
        
        var_858cc73104b46ce2 = getnotetracktimes( xanim, "combat_early_out" );
        var_51be04f31218d7fe = 1;
        
        if ( var_858cc73104b46ce2.size == 0 || !self [[ self.fnisinstealthcombat ]]() )
        {
            var_51be04f31218d7fe = 0;
            var_858cc73104b46ce2[ 0 ] = 1;
        }
        
        endtime = getnotetracktimes( xanim, "face_goal_end" );
        
        if ( endtime.size == 0 )
        {
            endtime[ 0 ] = finishtime[ 0 ];
        }
        
        if ( var_858cc73104b46ce2[ 0 ] < endtime[ 0 ] )
        {
            endtime[ 0 ] = var_858cc73104b46ce2[ 0 ];
        }
        
        [ animtime ] = getnotetracktimes( xanim, "face_goal" );
        animrate = self getanimrate( xanim );
        assert( animrate != 0 );
        
        if ( animrate == 0 )
        {
            animrate = 1;
        }
        
        anim_length = getanimlength( xanim ) / animrate;
        turntime = endtime[ 0 ] - animtime;
        turntime *= anim_length;
        beyondyaw = 0;
        
        if ( !var_51be04f31218d7fe && endtime[ 0 ] < finishtime[ 0 ] )
        {
            beyondyaw = getangledelta( xanim, endtime[ 0 ], finishtime[ 0 ] );
        }
        
        metopos = self.var_dd6868ae78a8de98 - self.origin;
        reactworldyaw = vectortoyaw( metopos );
        turnyaw = function_b44dc7a862e03d53( xanim, reactworldyaw, beyondyaw, endtime[ 0 ] );
        thread facegoalthread( statename, turnyaw, beyondyaw, self.var_dd6868ae78a8de98, reactworldyaw, turntime, xanim, endtime[ 0 ] );
        return true;
    }
    
    return false;
}

// Namespace patrol
// Params 8
// Checksum 0x290596e6, Offset: 0xa89
// Size: 0x27a
function facegoalthread( statename, turnyaw, beyondyaw, reactpos, reactworldyaw, turntime, turnanim, endtime )
{
    self notify( #"facegoalthread" );
    self endon( #"facegoalthread" );
    self endon( #"death" );
    self endon( statename + "_finished" );
    frames = ceil( turntime * 1000 / level.frameduration );
    var_330512304e2a26a9 = turnyaw / frames;
    
    while ( frames > 0 )
    {
        overrideent = self.enemy;
        
        if ( !isdefined( overrideent ) )
        {
            if ( isplayer( self.stealth_investigate_entity ) )
            {
                overrideent = self.stealth_investigate_entity;
            }
        }
        
        bcansee = 0;
        
        if ( issentient( overrideent ) )
        {
            lkp = self lastknownpos( overrideent );
            lktime = self lastknowntime( overrideent );
            
            if ( !bcansee )
            {
                bcansee = self cansee( overrideent );
            }
            
            var_f1b07fc0947fb3f4 = 0;
            
            if ( bcansee )
            {
                if ( distancesquared( self.var_dd6868ae78a8de98, overrideent.origin ) >= 225 )
                {
                    self.var_dd6868ae78a8de98 = overrideent.origin;
                    var_f1b07fc0947fb3f4 = 1;
                }
            }
            else if ( !bcansee )
            {
                if ( isdefined( lkp ) && lktime > 0 )
                {
                    self.var_dd6868ae78a8de98 = lkp;
                    var_f1b07fc0947fb3f4 = 1;
                }
            }
            
            if ( var_f1b07fc0947fb3f4 )
            {
                metopos = self.var_dd6868ae78a8de98 - self.origin;
                newreactworldyaw = vectortoyaw( metopos );
                turnyaw = angleclamp180( newreactworldyaw - reactworldyaw - beyondyaw );
                reactworldyaw = newreactworldyaw;
                var_330512304e2a26a9 += turnyaw / frames;
            }
        }
        
        self orientmode( "face angle", angleclamp( self.angles[ 1 ] + var_330512304e2a26a9 ) );
        frames -= 1;
        
        if ( frames < 1 )
        {
            if ( isdefined( overrideent ) )
            {
                if ( absangleclamp180( self.angles[ 1 ] - reactworldyaw ) <= 10 )
                {
                    if ( !self [[ self.fnisinstealthcombat ]]() && isplayer( overrideent ) && bcansee )
                    {
                        self aieventlistenerevent( "sight", overrideent, overrideent.origin );
                    }
                }
                else
                {
                    self glanceatpos( self.var_dd6868ae78a8de98 );
                }
            }
        }
        
        waitframe();
    }
}

// Namespace patrol
// Params 3
// Checksum 0x44e3463d, Offset: 0xd0b
// Size: 0x5b
function patrol_playanim_idlecurious( asmname, statename, params )
{
    thread patrol_playanim_idlecurious_facelastknownhelper( statename, self.stealthidlecurioustarget );
    
    if ( isdefined( level.battlechatter ) )
    {
        addbattlechatternotify( self, self.var_41029b06299a2523, "curious" );
    }
    
    asm::asm_playanimstate( asmname, statename );
}

// Namespace patrol
// Params 2
// Checksum 0x94b8ca10, Offset: 0xd6e
// Size: 0x73
function patrol_playanim_idlecurious_facelastknownhelper( statename, target )
{
    self endon( statename + "_finished" );
    self endon( #"death" );
    
    while ( isalive( target ) )
    {
        lastknown = self lastknownpos( target );
        var_9e997b10adafbbac = lastknown - self.origin;
        self orientmode( "face angle", vectortoyaw( var_9e997b10adafbbac ) );
        waitframe();
    }
}

// Namespace patrol
// Params 3
// Checksum 0x9fce688e, Offset: 0xde9
// Size: 0x62
function patrol_magicflashlightdetach( asmname, statename, params )
{
    if ( self.asmflashlight )
    {
        detachflashlight();
    }
    
    if ( self._blackboard.bflashlight && !self.asmflashlight )
    {
        self [[ self.fnstealthflashlighton ]]();
    }
}

// Namespace patrol
// Params 3
// Checksum 0x97b0f21f, Offset: 0xe53
// Size: 0x41
function patrol_magicflashlighton( asmname, statename, params )
{
    if ( self._blackboard.bflashlight )
    {
        self [[ self.fnstealthflashlighton ]]();
    }
}

// Namespace patrol
// Params 3
// Checksum 0xd3545d31, Offset: 0xe9c
// Size: 0x56
function chooseanim_patrol_checkflashlight( asmname, statename, params )
{
    assert( isdefined( params ) );
    alias = params;
    
    if ( self.asmflashlight )
    {
        alias = "fl_" + alias;
    }
    
    return asm::asm_lookupanimfromalias( statename, alias );
}

// Namespace patrol
// Params 1
// Checksum 0xde4fdb51, Offset: 0xefb
// Size: 0xda
function flashlightnotehandler( note )
{
    if ( note == "attach" )
    {
        var_4a8f7480e817020c = self function_9179da2a3a57fec0();
        attachflashlight( var_4a8f7480e817020c );
        return;
    }
    
    if ( note == "detach" )
    {
        assert( isdefined( self.fnstealthflashlighton ) );
        detachflashlight();
        
        if ( asm::asm_getdemeanor() != "patrol" && isdefined( self._blackboard.bflashlight ) && self._blackboard.bflashlight )
        {
            self [[ self.fnstealthflashlighton ]]();
        }
        
        return;
    }
    
    if ( note == "flashlight_on" )
    {
        self [[ self.fnstealthflashlighton ]]();
        return;
    }
    
    if ( note == "flashlight_off" )
    {
        self [[ self.fnstealthflashlightoff ]]( 0 );
    }
}

// Namespace patrol
// Params 1
// Checksum 0xb85baabf, Offset: 0xfdd
// Size: 0x44
function setflashlightmodel( flashlightmodel )
{
    if ( isai( self ) )
    {
        detachflashlight();
    }
    
    self.flashlightmodeloverride = flashlightmodel;
    
    if ( isai( self ) && self.asmflashlight )
    {
        attachflashlight( 1 );
    }
}

// Namespace patrol
// Params 0
// Checksum 0x13114541, Offset: 0x1029
// Size: 0x48
function getflashlightmodel()
{
    modelname = "attachment_wm_tac_light_held";
    
    if ( isdefined( self.flashlightmodeloverride ) )
    {
        modelname = self.flashlightmodeloverride;
    }
    else if ( isdefined( level.flashlightmodeloverride ) )
    {
        modelname = level.flashlightmodeloverride;
    }
    
    return modelname;
}

// Namespace patrol
// Params 1
// Checksum 0xedc4f77b, Offset: 0x107a
// Size: 0xb2
function attachflashlight( var_840e027f457208a6 )
{
    assert( isdefined( self.fnstealthflashlightoff ) && isdefined( self.fnstealthflashlighton ) );
    assert( !isdefined( self.asmflashlight ) || self.asmflashlight == 0 );
    self [[ self.fnstealthflashlightoff ]]( 0 );
    modelname = getflashlightmodel();
    self attach( modelname, "tag_accessory_left", 1 );
    self.flashlightmodel = modelname;
    self.asmflashlight = 1;
    self.flashlightfxoverridetag = "tag_light";
    
    if ( var_840e027f457208a6 )
    {
        self [[ self.fnstealthflashlighton ]]();
    }
}

// Namespace patrol
// Params 0
// Checksum 0x1a5c3d7e, Offset: 0x1134
// Size: 0x6f
function detachflashlight()
{
    assert( isdefined( self.fnstealthflashlightoff ) );
    
    if ( !self.asmflashlight )
    {
        return;
    }
    
    self [[ self.fnstealthflashlightoff ]]( 0 );
    
    if ( isdefined( self.flashlightmodel ) )
    {
        self detach( self.flashlightmodel, "tag_accessory_left" );
        self.flashlightmodel = undefined;
    }
    
    self.asmflashlight = 0;
    self.flashlightfxoverridetag = undefined;
}

// Namespace patrol
// Params 3
// Checksum 0x414058df, Offset: 0x11ab
// Size: 0x31, Type: bool
function flashlightreactionnotehandler( statename, note, params )
{
    flashlightnotehandler( note );
    return handlefacegoalnotetrack( statename, note, params );
}

// Namespace patrol
// Params 3
// Checksum 0xa0780628, Offset: 0x11e5
// Size: 0x28, Type: bool
function function_551bb83c03b259ba( asmname, statename, params )
{
    return istrue( level.var_73c30592aeb74b6f );
}

// Namespace patrol
// Params 3
// Checksum 0xbd395e55, Offset: 0x1216
// Size: 0x61
function function_cfe81b209e59889e( asmname, statename, params )
{
    alias = "curious";
    
    if ( self function_53599e4efc90b08b( "med" ) || self [[ self.fnisinstealthcombat ]]() )
    {
        alias = "threat";
    }
    
    return asm::asm_lookupanimfromalias( statename, string( alias ) );
}

// Namespace patrol
// Params 2
// Checksum 0x872a674, Offset: 0x1280
// Size: 0x51
function bc_notehandler( note, params )
{
    if ( isdefined( level.battlechatter ) && isstartstr( note, "bc_" ) )
    {
        event = getsubstr( note, 3 );
        
        /#
        #/
        
        addbattlechatternotify( self, undefined, event );
    }
}

