// scripts\asm\civilian\script_funcs.gsc  (hash_5bee3ec20d14b069.gscc) (size: 17165 Bytes / 0x430d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd1eb7d9c (3521871260)
// size ...... 17165 (0x430d)
// includes .. 8   (offset: 0x3f61)
// strings ... 57  (offset: 0x3fa1)
// dev strs .. 5   (offset: 0x42c9)
// exports ... 52  (offset: 0x28c9)
// cseg ...... 0x31d + 0x25ac (0x28c9)
// imports ... 115 (offset: 0x30e9)
// animtree1 . 0   (offset: 0x430d)
// animtree2 . 0   (offset: 0x430d)
#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\death;
#using scripts\asm\shared\utility;
#using scripts\asm\soldier\pain;
#using scripts\common\cap;
#using scripts\common\utility;

#namespace namespace_7dda0941123219af;

// Namespace namespace_7dda0941123219af
// Params 3
// Checksum 0x5f5baa38, Offset: 0x33b
// Size: 0x1e6
function civilian_init( asmname, statename, params )
{
    if ( asmname == "civilian" )
    {
        msgpt1 = "Using an aitype with the old 'civilian.asm'. ";
        msgpt2 = "All civilians should be using 'civilian_react' now. ";
        msgpt3 = "AIType: '" + self.classname + "' Location: " + self.origin;
        assertmsg( msgpt1 + msgpt2 + msgpt3 );
    }
    
    if ( !isdefined( self.asm.customdata ) )
    {
        self.asm.customdata = spawnstruct();
    }
    
    self.asm.footsteps = spawnstruct();
    self.asm.footsteps.foot = "invalid";
    self.asm.footsteps.time = 0;
    self.anglelerprate = 100;
    self.dontsyncmelee = 1;
    self setstrafeblocked( 1, "entity" );
    self.maystumble = 1;
    self.shouldstumble = 0;
    self.stumbledelay = 1500;
    self.stumblechance = 0.5;
    self.var_db28572b91e9b38f = 0.2;
    self.var_4edb2f0de5cc5efd = 6000;
    self.var_98bcb6c53b18b8a6 = 15000;
    thread function_2e8bdeea51969e97();
    
    if ( self.animsetname == "hadir_yth" )
    {
        self.pathsmoothmultiplier = 2;
    }
    
    initmaxspeedforpathlengthtable();
    
    if ( self isscriptable() )
    {
        thread initscriptable();
    }
    
    cap::init_cap();
    civilianfocusstartthread();
    self.fnplaydeathanim = &death::playdeathanimcommon;
    self.fnplaypainanim = &pain::playpainanim;
}

// Namespace namespace_7dda0941123219af
// Params 0
// Checksum 0xec6bd4, Offset: 0x529
// Size: 0x2b
function initscriptable()
{
    self endon( #"death" );
    utility::flag_wait( "scriptables_ready" );
    self setscriptablepartstate( "notetrack_handler", "active", 0 );
}

// Namespace namespace_7dda0941123219af
// Params 3
// Checksum 0xf993781f, Offset: 0x55c
// Size: 0xa9
function chooseciviliantransitiontoidleanim( asmname, statename, params )
{
    if ( isdefined( self.asm.transtoidlealias ) )
    {
        randomalias = self.asm.transtoidlealias;
        
        if ( statename == "trans_out_stand_idle" )
        {
            self.asm.transtoidlealias = undefined;
        }
        
        return asm::asm_lookupanimfromalias( statename, randomalias );
    }
    
    randomalias = asm::asm_getrandomalias( statename );
    self.asm.transtoidlealias = randomalias;
    return asm::asm_lookupanimfromalias( statename, randomalias );
}

// Namespace namespace_7dda0941123219af
// Params 3
// Checksum 0x13cb01e4, Offset: 0x60d
// Size: 0x11b
function choosecivilianreactidleanim( asmname, statename, params )
{
    if ( isdefined( self.asm.civilianreactionalias ) )
    {
        reactalias = self.asm.civilianreactionalias;
        
        if ( statename == "trans_out_combat_react" )
        {
            self.asm.civilianreactionalias = undefined;
        }
        
        return asm::asm_lookupanimfromalias( statename, reactalias );
    }
    
    assert( isdefined( self.asm.transtoidlealias ), "<dev string:x24>" );
    currentalias = self.asm.transtoidlealias;
    
    if ( utility::cointoss() )
    {
        alias = currentalias + "_a";
    }
    else
    {
        alias = currentalias + "_b";
    }
    
    assert( asm::asm_hasalias( statename, alias ), "<dev string:x24>" );
    self.asm.civilianreactionalias = alias;
    return asm::asm_lookupanimfromalias( statename, alias );
}

// Namespace namespace_7dda0941123219af
// Params 3
// Checksum 0x43cde059, Offset: 0x730
// Size: 0x70
function civilian_playexposedloop( asmname, statename, params )
{
    self function_ff32ea59b2119107();
    var_6b88954951db22ef = self asmgetstatetransitioningfrom( asmname );
    
    if ( isdefined( self.node ) )
    {
        self._blackboard.lastusednode = self.node;
    }
    
    asm::function_b7619cbe4e9abaf4( asmname, statename, 1 );
}

// Namespace namespace_7dda0941123219af
// Params 3
// Checksum 0x3e7f6908, Offset: 0x7a8
// Size: 0x3e
function civilian_exit_cleanup( asmname, statename, params )
{
    self._blackboard.var_5ee32e89826cf63f = 0;
    civilian_move_cleanup( asmname, statename, params );
}

// Namespace namespace_7dda0941123219af
// Params 3
// Checksum 0x6a1863a1, Offset: 0x7ee
// Size: 0x32
function civilian_playmoveloop( asmname, statename, params )
{
    thread civilian_watchspeed( statename );
    utility::playmoveloop( asmname, statename, params );
}

// Namespace namespace_7dda0941123219af
// Params 0
// Checksum 0x4ce85489, Offset: 0x828
// Size: 0xe1
function function_2e8bdeea51969e97()
{
    self endon( #"death" );
    stumbletimer = gettime() + randomint( 1000 );
    
    while ( true )
    {
        waitframe();
        
        if ( !self.maystumble && !self.shouldstumble )
        {
            continue;
        }
        
        if ( !isdefined( self.pathgoalpos ) )
        {
            continue;
        }
        
        if ( gettime() < stumbletimer )
        {
            continue;
        }
        
        recentwhizby = asm_bb::bb_iswhizbyrequested();
        stumblechance = recentwhizby ? self.var_db28572b91e9b38f : self.stumblechance;
        
        if ( randomfloat( 1 ) > stumblechance )
        {
            stumbletimer = gettime() + self.var_4edb2f0de5cc5efd;
            continue;
        }
        
        stumbletimer = gettime() + randomint( 1000 ) + self.var_98bcb6c53b18b8a6;
        self.shouldstumble = 1;
    }
}

// Namespace namespace_7dda0941123219af
// Params 3
// Checksum 0xe263b049, Offset: 0x911
// Size: 0x7d
function civilian_stumblechooseanim( asmname, statename, params )
{
    archetype = self getbasearchetype();
    speed = length( self.velocity );
    alias = "stumble_jog";
    
    if ( speed > 153 )
    {
        alias = "stumble_sprint";
    }
    
    if ( speed > 220 )
    {
        alias = "stumble_run";
    }
    
    return asm::asm_chooseanim( asmname, statename, alias );
}

// Namespace namespace_7dda0941123219af
// Params 3
// Checksum 0x9085a98f, Offset: 0x997
// Size: 0xec
function civilian_playmoveloopblendspace( asmname, statename, param )
{
    self endon( statename + "_finished" );
    thread civilian_watchspeed( statename );
    self.requestarrivalnotify = 1;
    self.var_4ff0a015a19a428e = 1;
    self.var_2d4dd3f57eb8b4ed = 0;
    blankindex = asm::asm_lookupanimfromalias( statename, "blank" );
    self aisetanim( statename, blankindex );
    
    if ( param )
    {
        if ( isdefined( self._blackboard.var_8141bfd7b74a80f6 ) )
        {
            self._blackboard.civilianfocustargetentity = self._blackboard.var_8141bfd7b74a80f6;
            var_2632a8fbf6a816b7 = civilianfocuscomputeyawtotarget();
            var_2632a8fbf6a816b7 /= 180;
            civilianfocusupdateanimparameter( var_2632a8fbf6a816b7 );
        }
    }
    
    while ( true )
    {
        asm::asm_donotetracks( asmname, statename );
    }
}

// Namespace namespace_7dda0941123219af
// Params 1
// Checksum 0x53ae1b99, Offset: 0xa8b
// Size: 0xc3
function civilian_watchspeed( statename )
{
    self endon( statename + "_finished" );
    
    if ( isdefined( self.stayahead ) && self.stayahead.active )
    {
        return;
    }
    
    if ( isdefined( self._blackboard.requestedspeed ) )
    {
        self aisetdesiredspeed( self._blackboard.requestedspeed );
    }
    
    while ( !isdefined( self.stayahead ) || !self.stayahead.active )
    {
        if ( self aigetdesiredspeed() > 153 && self pathdisttogoal() < 200 && !self.disablearrivals )
        {
            self aisetdesiredspeed( 153 );
        }
        
        waitframe();
    }
}

// Namespace namespace_7dda0941123219af
// Params 3
// Checksum 0xa86e2a36, Offset: 0xb56
// Size: 0x125
function civilian_playsharpturnanim( asmname, statename, params )
{
    self endon( statename + "_finished" );
    turnanim = asm::asm_getanim( asmname, statename );
    assert( isdefined( turnanim ) );
    turnxanim = asm::asm_getxanim( statename, turnanim );
    self animmode( "zonly_physics" );
    self orientmode( "face angle", self.angles[ 1 ] );
    turnrate = self.moveplaybackrate;
    asm::asm_playfacialanim( asmname, statename, turnxanim );
    self aisetanim( statename, turnanim, turnrate );
    childthread function_8408cd97210979f2( turnxanim, turnrate );
    note = asm::asm_donotetracks( asmname, statename, &function_b6b98e6ce234eed1, turnxanim, undefined, 0 );
    self motionwarpcancel();
    self orientmode( "face enemy or motion" );
    self animmode( "normal" );
    
    if ( note == "code_move" )
    {
        self.requestarrivalnotify = 1;
        finishtimes = getnotetracktimes( turnxanim, "finish" );
        
        if ( finishtimes.size > 0 )
        {
            asm::asm_donotetracks( asmname, statename );
        }
    }
}

// Namespace namespace_7dda0941123219af
// Params 2
// Checksum 0x145b28d, Offset: 0xc83
// Size: 0xc4
function function_8408cd97210979f2( turnxanim, turnrate )
{
    waitframe();
    cornernotes = getnotetracktimes( turnxanim, "corner" );
    
    if ( cornernotes.size > 0 )
    {
        cornertime = cornernotes[ 0 ];
        animlength = getanimlength( turnxanim );
        curtime = level.frameduration / 1000 / animlength;
        animtrans = getmovedelta( turnxanim, curtime, cornertime );
        animrot = ( 0, getangledelta( turnxanim, curtime, cornertime ), 0 );
        animduration = animlength * cornertime / turnrate;
        
        if ( animduration > 0.05 )
        {
            self.useanimgoalweight = 1;
            self function_6f13f0407b69d7dd( animtrans, animrot, animduration );
        }
    }
}

// Namespace namespace_7dda0941123219af
// Params 2
// Checksum 0x6e91f764, Offset: 0xd4f
// Size: 0x1a8
function function_b6b98e6ce234eed1( note, params )
{
    if ( note == "corner" )
    {
        self motionwarpcancel();
        
        if ( !isdefined( self.pathgoalpos ) )
        {
            return;
        }
        
        if ( self.lookaheaddist > 4 )
        {
            lookaheadangle = vectortoyaw( self.lookaheaddir );
        }
        else
        {
            return;
        }
        
        turnxanim = params;
        cornertimes = getnotetracktimes( turnxanim, "corner" );
        codemovetimes = getnotetracktimes( turnxanim, "code_move" );
        assert( cornertimes.size > 0 );
        endtime = 1;
        
        if ( codemovetimes.size > 0 )
        {
            endtime = codemovetimes[ 0 ];
        }
        
        duration = ( endtime - cornertimes[ 0 ] ) * getanimlength( turnxanim ) * 1000;
        
        if ( duration < level.frameduration )
        {
            return;
        }
        
        animdelta = getmovedelta( turnxanim, cornertimes[ 0 ], endtime );
        animrot = getangledelta( turnxanim, cornertimes[ 0 ], endtime );
        anglediff = angleclamp180( lookaheadangle - self.angles[ 1 ] - animrot );
        
        if ( abs( anglediff ) > 60 )
        {
            return;
        }
        
        idealstartangles = ( 0, lookaheadangle - animrot, 0 );
        targetpos = self.origin + rotatevector( animdelta, self.angles );
        targetpos = getclosestpointonnavmesh( targetpos, self, 0, 1 );
        idealstartpos = targetpos - rotatevector( animdelta, idealstartangles );
        self motionwarpwithanim( idealstartpos, idealstartangles, targetpos, ( 0, lookaheadangle, 0 ), int( duration ) );
    }
}

// Namespace namespace_7dda0941123219af
// Params 3
// Checksum 0xffdebf45, Offset: 0xeff
// Size: 0x24
function civilian_move_cleanup( asmname, statename, params )
{
    self motionwarpcancel();
}

// Namespace namespace_7dda0941123219af
// Params 4
// Checksum 0x20863eae, Offset: 0xf2b
// Size: 0x2d, Type: bool
function iswhizbydetected( asmname, statename, tostatename, params )
{
    return asm_bb::bb_iswhizbyrequested();
}

// Namespace namespace_7dda0941123219af
// Params 4
// Checksum 0xc1238317, Offset: 0xf61
// Size: 0x30
function function_6881fcc1f76cfb0f( asmname, statename, tostatename, params )
{
    return self.shouldstumble;
}

// Namespace namespace_7dda0941123219af
// Params 4
// Checksum 0xa3b55760, Offset: 0xf9a
// Size: 0x31, Type: bool
function function_43798c156030ef65( asmname, statename, tostatename, params )
{
    return istrue( self.disableexits );
}

// Namespace namespace_7dda0941123219af
// Params 4
// Checksum 0xb02f8780, Offset: 0xfd4
// Size: 0x92, Type: bool
function shoulddirectlytransition( asmname, statename, tostatename, params )
{
    if ( iswhizbydetected() || asm_bb::bb_getcivilianstate() == "combat" )
    {
        alias = self.asm.transtoidlealias;
        
        if ( alias == "civ02" || alias == "civ04" || alias == "civ06" || alias == "civ07" )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_7dda0941123219af
// Params 4
// Checksum 0x4c4651ee, Offset: 0x106f
// Size: 0x88, Type: bool
function shouldcustomtransition( asmname, statename, tostatename, params )
{
    if ( asm_bb::bb_getcivilianstate() == "noncombat" )
    {
        alias = self.asm.transtoidlealias;
        
        if ( alias == "civ02" || alias == "civ04" || alias == "civ06" || alias == "civ07" )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_7dda0941123219af
// Params 3
// Checksum 0xb9d69077, Offset: 0x1100
// Size: 0x31
function cleanupcivilianreactionalias( asmname, statename, params )
{
    self.asm.civilianreactionalias = undefined;
}

// Namespace namespace_7dda0941123219af
// Params 4
// Checksum 0xd8b0439, Offset: 0x1139
// Size: 0x94
function shouldsnaptocover( asmname, statename, tostatename, params )
{
    if ( asm_bb::bb_moverequested() )
    {
        return 0;
    }
    
    if ( !utility::isatcovernode() )
    {
        return 0;
    }
    
    if ( !isdefined( self.node ) )
    {
        return 0;
    }
    
    if ( isdefined( self.primaryweapon ) && utility_common::isusingsidearm() && weaponclass( self.primaryweapon ) != "mg" )
    {
        return 0;
    }
    
    if ( !isdefined( params ) )
    {
        return 1;
    }
    
    return utility::isarrivaltype( asmname, statename, tostatename, params );
}

// Namespace namespace_7dda0941123219af
// Params 2
// Checksum 0x8c365a25, Offset: 0x11d6
// Size: 0x95
function enableciviliantargetfocus( ent, direction )
{
    if ( !isdefined( ent ) )
    {
        return;
    }
    
    self._blackboard.civilianfocustargetentity = ent;
    self._blackboard.civilianfocusstate = 1;
    
    if ( !isdefined( direction ) )
    {
        self._blackboard.civilianfocusdirection = "";
    }
    else
    {
        self._blackboard.civilianfocusdirection = direction;
    }
    
    self notify( #"hash_5cd78e192cd9ea22" );
    civilianfocusstartthread();
}

// Namespace namespace_7dda0941123219af
// Params 0
// Checksum 0x387ca078, Offset: 0x1273
// Size: 0x2b
function disableciviliantargetfocus()
{
    self._blackboard.civilianfocustargetentity = undefined;
    self._blackboard.civilianfocusstate = 2;
}

// Namespace namespace_7dda0941123219af
// Params 0
// Checksum 0x7214dab1, Offset: 0x12a6
// Size: 0x65
function civilianfocusstartthread()
{
    if ( isdefined( self._blackboard.civilianfocusthreadrunning ) )
    {
        return;
    }
    
    self._blackboard.civilianfocusthreadrunning = 1;
    self._blackboard.civilianfocusstate = 0;
    self._blackboard.civilianfocuscurvalue = 0;
    thread civilianfocusupdatethread();
}

// Namespace namespace_7dda0941123219af
// Params 0
// Checksum 0xff746fc7, Offset: 0x1313
// Size: 0x69
function civilianfocuscomputeyawtotarget()
{
    var_ea0fbab23e180024 = self._blackboard.civilianfocustargetentity.origin - self.origin;
    var_ea0fbab23e180024 = ( var_ea0fbab23e180024[ 0 ], var_ea0fbab23e180024[ 1 ], 0 );
    var_8de3f6bbf1a765e6 = vectortoangles( var_ea0fbab23e180024 );
    return angleclamp180( var_8de3f6bbf1a765e6[ 1 ] - self.angles[ 1 ] );
}

// Namespace namespace_7dda0941123219af
// Params 1
// Checksum 0xa1608308, Offset: 0x1385
// Size: 0x12f, Type: bool
function civilianfocusupdatecurrentfocus( targetvalue )
{
    var_db41755510705b3a = 0.5;
    var_776129208fcc40fc = 1 / var_db41755510705b3a;
    curtime = gettime();
    timedelt = curtime - self._blackboard.civilianfocuslasttime;
    self._blackboard.civilianfocuslasttime = curtime;
    currentvalue = self._blackboard.civilianfocuscurvalue;
    diff = targetvalue - currentvalue;
    
    if ( abs( diff ) > 0.01 )
    {
        signtotarget = utility::sign( targetvalue - currentvalue );
        newvalue = self._blackboard.civilianfocuscurvalue + timedelt / 1000 * var_776129208fcc40fc * signtotarget;
        newvalue = clamp( newvalue, -1, 1 );
        self._blackboard.civilianfocuscurvalue = newvalue;
        return false;
    }
    
    self._blackboard.civilianfocuscurvalue = targetvalue;
    return true;
}

// Namespace namespace_7dda0941123219af
// Params 0
// Checksum 0x87da3006, Offset: 0x14bd
// Size: 0x4e, Type: bool
function civilianfocusapproachingarrival()
{
    target_speed = self aigettargetspeed();
    
    if ( !self codemoverequested() || self pathdisttogoal() < target_speed * 1.3 )
    {
        return true;
    }
    else if ( self._blackboard.var_5ee32e89826cf63f )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_7dda0941123219af
// Params 1
// Checksum 0xa1d14bc9, Offset: 0x1514
// Size: 0x14
function civilianfocusupdateanimparameter( paramvalue )
{
    self setcivilianfocus( paramvalue );
}

// Namespace namespace_7dda0941123219af
// Params 0
// Checksum 0xcf28dc51, Offset: 0x1530
// Size: 0x4ce
function civilianfocusupdatethread()
{
    self endon( #"death" );
    assert( isdefined( self._blackboard.civilianfocusstate ) );
    var_d7ef9ebcc7b2f30f = -1;
    var_1309912b2fce1d36 = 1;
    var_565432c46df86806 = 170;
    var_9ff20695a8f83272 = -170;
    self._blackboard.civilianfocuslasttime = 0;
    
    while ( true )
    {
        state = self._blackboard.civilianfocusstate;
        direction = self._blackboard.civilianfocusdirection;
        
        if ( state == 0 )
        {
            self waittill( #"hash_5cd78e192cd9ea22" );
            self._blackboard.civilianfocuslasttime = gettime();
        }
        else if ( state == 1 )
        {
            var_2632a8fbf6a816b7 = civilianfocuscomputeyawtotarget();
            var_4ffdaa3b6893f915 = abs( var_2632a8fbf6a816b7 );
            
            if ( civilianfocusapproachingarrival() || var_4ffdaa3b6893f915 > 90 )
            {
                self._blackboard.civilianfocusstate = 5;
            }
            else if ( direction == "left" )
            {
                self._blackboard.civilianfocusstate = 3;
            }
            else if ( direction == "right" )
            {
                self._blackboard.civilianfocusstate = 4;
            }
            else if ( var_2632a8fbf6a816b7 != 0 )
            {
                self._blackboard.civilianfocusstate = 6;
            }
        }
        else if ( state == 2 )
        {
            self._blackboard.civilianfocusstate = 7;
        }
        else if ( state == 5 )
        {
            civilianfocusupdatecurrentfocus( 0 );
            
            if ( !civilianfocusapproachingarrival() && isalive( self._blackboard.civilianfocustargetentity ) )
            {
                var_2632a8fbf6a816b7 = civilianfocuscomputeyawtotarget();
                
                if ( abs( var_2632a8fbf6a816b7 ) < 90 )
                {
                    if ( direction == "left" )
                    {
                        self._blackboard.civilianfocusstate = 3;
                    }
                    else if ( direction == "right" )
                    {
                        self._blackboard.civilianfocusstate = 4;
                    }
                    else if ( var_2632a8fbf6a816b7 != 0 )
                    {
                        self._blackboard.civilianfocusstate = 6;
                    }
                }
            }
            
            civilianfocusupdateanimparameter( self._blackboard.civilianfocuscurvalue );
        }
        else if ( state == 6 )
        {
            var_2632a8fbf6a816b7 = civilianfocuscomputeyawtotarget();
            curtarget = clamp( var_2632a8fbf6a816b7, -45, 45 ) / 45;
            assert( curtarget >= -1 && curtarget <= 1 );
            civilianfocusupdatecurrentfocus( curtarget );
            civilianfocusupdateanimparameter( self._blackboard.civilianfocuscurvalue );
            
            if ( civilianfocusapproachingarrival() )
            {
                self._blackboard.civilianfocusstate = 5;
            }
        }
        else if ( state == 3 )
        {
            civilianfocusupdatecurrentfocus( var_d7ef9ebcc7b2f30f );
            civilianfocusupdateanimparameter( self._blackboard.civilianfocuscurvalue );
            
            if ( civilianfocusapproachingarrival() )
            {
                self._blackboard.civilianfocusstate = 5;
            }
            else
            {
                var_2632a8fbf6a816b7 = civilianfocuscomputeyawtotarget();
                
                if ( abs( var_2632a8fbf6a816b7 ) < 90 )
                {
                    self._blackboard.civilianfocusstate = 5;
                }
                else if ( direction == "right" || var_2632a8fbf6a816b7 > var_9ff20695a8f83272 && var_2632a8fbf6a816b7 < -90 )
                {
                    self._blackboard.civilianfocusstate = 4;
                }
            }
        }
        else if ( state == 4 )
        {
            civilianfocusupdatecurrentfocus( var_1309912b2fce1d36 );
            civilianfocusupdateanimparameter( self._blackboard.civilianfocuscurvalue );
            
            if ( civilianfocusapproachingarrival() )
            {
                self._blackboard.civilianfocusstate = 5;
            }
            else
            {
                var_2632a8fbf6a816b7 = civilianfocuscomputeyawtotarget();
                
                if ( abs( var_2632a8fbf6a816b7 ) < 90 )
                {
                    self._blackboard.civilianfocusstate = 5;
                }
                else if ( direction == "left" || var_2632a8fbf6a816b7 > 90 && var_2632a8fbf6a816b7 < var_565432c46df86806 )
                {
                    self._blackboard.civilianfocusstate = 3;
                }
            }
        }
        else if ( state == 7 )
        {
            done = civilianfocusupdatecurrentfocus( 0 );
            civilianfocusupdateanimparameter( self._blackboard.civilianfocuscurvalue );
            
            if ( done )
            {
                self._blackboard.civilianfocusstate = 0;
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_7dda0941123219af
// Params 4
// Checksum 0x5e0e952c, Offset: 0x1a06
// Size: 0x45, Type: bool
function civmoverequested( asmname, statename, tostatename, params )
{
    return asm_bb::bb_moverequested() && !self._blackboard.partialgestureplaying;
}

// Namespace namespace_7dda0941123219af
// Params 3
// Checksum 0x940f409e, Offset: 0x1a54
// Size: 0x48
function civilian_chooseanim_demeanor( asmname, statename, params )
{
    if ( isdefined( params ) )
    {
        return asm::asm_lookupanimfromalias( statename, asm_bb::bb_getcivilianstate() + params );
    }
    
    return asm::asm_lookupanimfromalias( statename, asm_bb::bb_getcivilianstate() );
}

// Namespace namespace_7dda0941123219af
// Params 3
// Checksum 0x5bd6695e, Offset: 0x1aa4
// Size: 0xb2
function civilian_chooseanim_playerpushed( asmname, statename, params )
{
    movedir = asm::asm_getephemeraleventdata( "player_pushed", "player_pushed" );
    movedirnormalized = vectornormalize( movedir );
    targetangles = vectortoangles( movedirnormalized );
    targetyaw = angleclamp180( targetangles[ 1 ] - self.angles[ 1 ] );
    angleindex = asm::yawdiffto2468( targetyaw );
    aliasname = "pushed_" + angleindex;
    turnanim = asm::asm_lookupanimfromalias( statename, aliasname );
    return turnanim;
}

// Namespace namespace_7dda0941123219af
// Params 4
// Checksum 0xd57cf572, Offset: 0x1b5f
// Size: 0x43, Type: bool
function function_4ff19be2b49cc323( asmname, statename, tostatename, params )
{
    if ( !isdefined( self.var_4694cde7de13ca09 ) )
    {
        return false;
    }
    
    return asm_bb::bb_getcivilianstate() == "casual";
}

// Namespace namespace_7dda0941123219af
// Params 4
// Checksum 0xf2afbea5, Offset: 0x1bab
// Size: 0xf1, Type: bool
function function_c67ef903c9b1f213( asmname, statename, tostatename, params )
{
    toplayer = level.player.origin - self.origin;
    setdvarifuninitialized( @"hash_e423c827ca27e5c4", 120 );
    dist = getdvarfloat( @"hash_e423c827ca27e5c4", 120 );
    dist *= dist;
    
    if ( lengthsquared( toplayer ) > dist )
    {
        return false;
    }
    
    selfforward = anglestoforward( self.angles );
    
    if ( vectordot( toplayer, selfforward ) < 0 )
    {
        return false;
    }
    
    playerforward = anglestoforward( level.player.angles );
    
    if ( vectordot( playerforward, selfforward ) > 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_7dda0941123219af
// Params 4
// Checksum 0x24e88c93, Offset: 0x1ca5
// Size: 0x18c, Type: bool
function function_94a43c91229dcd99( asmname, statename, tostatename, params )
{
    var_2a1a295856e8d53b = 100;
    closeai = getaiarrayinradius( self.origin, var_2a1a295856e8d53b );
    
    if ( !isdefined( closeai ) )
    {
        return false;
    }
    
    topath = self getposonpath( 100 );
    selfforward = vectornormalize( topath - self.origin );
    bestai = undefined;
    distsq = var_2a1a295856e8d53b * var_2a1a295856e8d53b;
    
    for ( i = 0; i < closeai.size ; i++ )
    {
        if ( self == closeai[ i ] )
        {
            continue;
        }
        
        toai = closeai[ i ].origin - self.origin;
        dot = vectordot( toai, selfforward );
        
        if ( dot < 0 )
        {
            continue;
        }
        
        aiforward = anglestoforward( closeai[ i ].angles );
        
        if ( vectordot( selfforward, aiforward ) > 0 )
        {
            continue;
        }
        
        toforward = toai - selfforward * dot;
        
        if ( length2dsquared( toforward ) > 625 )
        {
            continue;
        }
        
        var_15b6d7d1503cf56c = lengthsquared( toai );
        
        if ( var_15b6d7d1503cf56c < distsq )
        {
            distsq = var_15b6d7d1503cf56c;
            bestai = closeai[ i ];
        }
    }
    
    if ( !isdefined( bestai ) )
    {
        return false;
    }
    
    self.var_efcbfca9f1f39354 = bestai;
    return true;
}

// Namespace namespace_7dda0941123219af
// Params 4
// Checksum 0x26f5fb9d, Offset: 0x1e3a
// Size: 0xd6
function function_693fad78657b2f71( asmname, statename, tostatename, params )
{
    assert( isdefined( self.var_efcbfca9f1f39354 ) );
    assert( isai( self.var_efcbfca9f1f39354 ) );
    assert( isalive( self.var_efcbfca9f1f39354 ) );
    closeai = self.var_efcbfca9f1f39354;
    toai = closeai.origin - self.origin;
    forward = anglestoforward( self.angles );
    
    if ( length( toai ) > 200 )
    {
        return 1;
    }
    
    beyondthreshold = vectordot( toai, forward ) < -20;
    return beyondthreshold;
}

// Namespace namespace_7dda0941123219af
// Params 3
// Checksum 0x217015dc, Offset: 0x1f19
// Size: 0x69
function function_d7e130f256efec87( asmname, statename, params )
{
    if ( isdefined( self.var_7dd7ed60e37e0f50 ) )
    {
        idx = self.var_7dd7ed60e37e0f50;
    }
    else
    {
        idx = randomint( 7 ) + 1;
    }
    
    self.var_e918bbf54bd33d2d = idx;
    return asm::asm_lookupanimfromalias( statename, "walk_" + idx );
}

// Namespace namespace_7dda0941123219af
// Params 3
// Checksum 0x6d90f2f1, Offset: 0x1f8b
// Size: 0xd7
function function_d94d3c8b5c969747( asmname, statename, params )
{
    toplayer = level.player.origin - self.origin;
    forward = anglestoforward( self.angles );
    cross = vectorcross( forward, toplayer );
    idx = 1;
    
    if ( isdefined( self.var_e918bbf54bd33d2d ) )
    {
        idx = self.var_e918bbf54bd33d2d;
    }
    
    alias = undefined;
    
    if ( cross[ 2 ] < 0 )
    {
        alias = "avoid_" + idx + "_l";
    }
    else
    {
        alias = "avoid_" + idx + "_r";
    }
    
    return asm::asm_lookupanimfromalias( statename, alias );
}

// Namespace namespace_7dda0941123219af
// Params 3
// Checksum 0x1a453c24, Offset: 0x206b
// Size: 0x11e
function function_acfa31121310e001( asmname, statename, params )
{
    assert( isdefined( self.var_efcbfca9f1f39354 ) );
    assert( isai( self.var_efcbfca9f1f39354 ) );
    assert( isalive( self.var_efcbfca9f1f39354 ) );
    closeai = self.var_efcbfca9f1f39354;
    toai = closeai.origin - self.origin;
    forward = anglestoforward( self.angles );
    cross = vectorcross( forward, toai );
    idx = 1;
    
    if ( isdefined( self.var_e918bbf54bd33d2d ) )
    {
        idx = self.var_e918bbf54bd33d2d;
    }
    
    alias = undefined;
    
    if ( cross[ 2 ] < 0 )
    {
        alias = "avoid_" + idx + "_l";
    }
    else
    {
        alias = "avoid_" + idx + "_r";
    }
    
    return asm::asm_lookupanimfromalias( statename, alias );
}

// Namespace namespace_7dda0941123219af
// Params 3
// Checksum 0xb99a312d, Offset: 0x2192
// Size: 0x28
function function_8fe5c8f8b39fa6c4( asmname, statename, params )
{
    self.var_efcbfca9f1f39354 = undefined;
}

// Namespace namespace_7dda0941123219af
// Params 4
// Checksum 0x1be479ef, Offset: 0x21c2
// Size: 0x31, Type: bool
function function_8e8d8944328f716c( asmname, statename, tostatename, params )
{
    return isdefined( self.customarrivalstate );
}

// Namespace namespace_7dda0941123219af
// Params 4
// Checksum 0xa814eafc, Offset: 0x21fc
// Size: 0x151
function civplayturnanim( asmname, statename, tostatename, params )
{
    self endon( statename + "_finished" );
    turnanim = asm::asm_getanim( asmname, statename );
    turnxanim = asm::asm_getxanim( statename, turnanim );
    self.useanimgoalweight = 1;
    assert( !isdefined( params ) || isarray( params ) && params.size == 3 );
    rate = 1;
    
    if ( !isdefined( params ) || params[ 2 ] )
    {
        rate_adjust = randomfloatrange( -0.2, 0.2 );
        rate += rate_adjust;
    }
    
    if ( isai( self ) )
    {
        self aisetanim( statename, turnanim, rate );
    }
    else
    {
        bodyanimid = asm::asm_lookupanimfromalias( "knobs", "body" );
        bodyxanim = asm::asm_getxanim( "knobs", bodyanimid );
        self setflaggedanimknoballrestart( statename, turnxanim, bodyxanim, 1, 0.2, 1 );
    }
    
    if ( !isdefined( params ) || params[ 1 ] )
    {
        thread function_ce52841b44db99ce( turnxanim, statename );
    }
    
    notehandler = asm::asm_getnotehandler( asmname, statename );
    asm::asm_donotetracks( asmname, statename, notehandler );
}

// Namespace namespace_7dda0941123219af
// Params 2
// Checksum 0x82358da9, Offset: 0x2355
// Size: 0x208
function function_ce52841b44db99ce( turnxanim, statename )
{
    self endon( #"death" );
    self endon( statename + "_finished" );
    player = undefined;
    animlength = getanimlength( turnxanim );
    
    if ( animhasnotetrack( turnxanim, "start_aim" ) )
    {
        finish_time = getnotetracktimes( turnxanim, "start_aim" );
        animlength *= finish_time[ 0 ];
    }
    else if ( animhasnotetrack( turnxanim, "finish" ) )
    {
        finish_time = getnotetracktimes( turnxanim, "finish" );
        animlength *= finish_time[ 0 ];
    }
    
    numframes = int( animlength * 20 );
    remainingframes = numframes;
    lookpoint = utility::function_bead19f1fd2135a1( 1024 );
    
    if ( isai( self ) )
    {
        while ( remainingframes > 0 )
        {
            lerpfraction = 1 / remainingframes;
            yawtoenemy = angleclamp180( vectortoyaw( lookpoint - self.origin ) - self.angles[ 1 ] );
            currentanimtime = self aigetanimtime( turnxanim );
            animyawdelta = getangledelta( turnxanim, currentanimtime, 1 );
            remainingyaw = angleclamp180( yawtoenemy - animyawdelta );
            self orientmode( "face angle", angleclamp( self.angles[ 1 ] + remainingyaw * lerpfraction ) );
            remainingframes--;
            wait 0.05;
        }
        
        return;
    }
    
    while ( remainingframes > 0 )
    {
        lerpfraction = 1 / remainingframes;
        yawtoenemy = angleclamp180( vectortoyaw( lookpoint - self.origin ) - self.angles[ 1 ] );
        currentanimtime = self getanimtime( turnxanim );
        animyawdelta = getangledelta( turnxanim, currentanimtime, 1 );
        remainingyaw = angleclamp180( yawtoenemy - animyawdelta );
        yaw = angleclamp( self.angles[ 1 ] + remainingyaw * lerpfraction );
        self.angles = ( 0, yaw, 0 );
        remainingframes--;
        wait 0.05;
    }
}

// Namespace namespace_7dda0941123219af
// Params 3
// Checksum 0xa8387875, Offset: 0x2565
// Size: 0x204
function civchooseturnanim( asmname, statename, params )
{
    target = utility::function_bead19f1fd2135a1( 1024 );
    
    if ( isdefined( params ) & isstring( params ) && params == "return" && isdefined( self.interaction_origin ) )
    {
        target = self.interaction_origin + ( 0, 0, 55 ) + anglestoforward( self.interaction_angles ) * 10;
    }
    
    yawtotarget = vectortoyaw( target - self.origin );
    anglediff = angleclamp180( yawtotarget - self.angles[ 1 ] );
    turnanim = undefined;
    
    if ( params == "cardinal" )
    {
        absanglediff = abs( anglediff );
        animindex = "2";
        
        if ( absanglediff > 135 )
        {
            animindex = "8";
        }
        else if ( anglediff > 45 && anglediff <= 135 )
        {
            animindex = "6";
        }
        else if ( anglediff >= -135 && anglediff < -45 )
        {
            animindex = "4";
        }
        
        turnanim = asm::asm_lookupanimfromalias( statename, animindex );
        assert( isdefined( turnanim ), "<dev string:x3f>" + animindex + "<dev string:x59>" + self.animsetname );
    }
    else
    {
        animmap = [ "2", "3", "6", "9", "8", "7", "4", "1", "2" ];
        animindex = getangleindex( anglediff, 22.5 );
        turnanim = asm::asm_lookupanimfromalias( statename, animmap[ animindex ] );
        assert( isdefined( turnanim ), "<dev string:x70>" + animmap[ animindex ] + "<dev string:x59>" + self.animsetname );
    }
    
    return turnanim;
}

// Namespace namespace_7dda0941123219af
// Params 4
// Checksum 0x88f0d99f, Offset: 0x2772
// Size: 0x52, Type: bool
function function_f4398aa195e93ddb( asmname, statename, tostatename, params )
{
    assert( isdefined( params ), "<dev string:x81>" );
    return distancesquared( self.goalpos, self.origin ) < params * params;
}

// Namespace namespace_7dda0941123219af
// Params 3
// Checksum 0xe54fe0e2, Offset: 0x27cd
// Size: 0x27
function function_127adaef3e42cd88( asmname, statename, params )
{
    utility::set_movement_speed( 52 );
}

// Namespace namespace_7dda0941123219af
// Params 3
// Checksum 0x3de2eaf2, Offset: 0x27fc
// Size: 0x27
function function_b93f6f57f00dcfcd( asmname, statename, params )
{
    utility::set_movement_speed( 127 );
}

// Namespace namespace_7dda0941123219af
// Params 3
// Checksum 0x65ee8726, Offset: 0x282b
// Size: 0x27
function function_44053b3f0eb1eeeb( asmname, statename, params )
{
    utility::set_movement_speed( 153 );
}

// Namespace namespace_7dda0941123219af
// Params 3
// Checksum 0x2e113fb5, Offset: 0x285a
// Size: 0x27
function function_30d80d83275f60d4( asmname, statename, params )
{
    utility::set_movement_speed( 220 );
}

// Namespace namespace_7dda0941123219af
// Params 3
// Checksum 0xe4df05e, Offset: 0x2889
// Size: 0x40
function function_4fef725b1d8cf87b( asmname, statename, param )
{
    if ( self._blackboard.requestedspeed < 70 )
    {
        utility::set_movement_speed( 70 );
    }
}

