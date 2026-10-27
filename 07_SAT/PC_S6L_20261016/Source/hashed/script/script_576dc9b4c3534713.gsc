// script_576dc9b4c3534713  (hash_576dc9b4c3534713.gscc) (size: 3793 Bytes / 0xed1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x25090392 (621347730)
// size ...... 3793 (0xed1)
// includes .. 2   (offset: 0xe65)
// strings ... 7   (offset: 0xe75)
// dev strs .. 0   (offset: 0xed1)
// exports ... 12  (offset: 0x871)
// cseg ...... 0xb2 + 0x7bf (0x871)
// imports ... 36  (offset: 0xa51)
// animtree1 . 0   (offset: 0xed1)
// animtree2 . 0   (offset: 0xed1)
#using scripts\asm\asm;
#using scripts\common\callbacks;

#namespace juggerbot_asm;

// Namespace juggerbot_asm
// Params 0, eflags: 0x4
// Checksum 0x3307bee9, Offset: 0xd0
// Size: 0x2
function private function_cfbb84b3d7bc65b8()
{
    
}

// Namespace juggerbot_asm
// Params 3
// Checksum 0x37e506e3, Offset: 0xda
// Size: 0x60
function juggerbotinit( asmname, statename, params )
{
    if ( self.var_1657e34f712bae48 )
    {
        return;
    }
    
    self.var_1657e34f712bae48 = 1;
    self.animname = self.animsetname;
    asm::function_d82cb83c9c260d49( 1 );
    asm::asm_setmoveplaybackrate( 1 );
}

// Namespace juggerbot_asm
// Params 1, eflags: 0x4
// Checksum 0xfd7bf060, Offset: 0x142
// Size: 0x1d
function private on_ai_init( params )
{
    callback::remove( "on_ai_init", &on_ai_init );
}

// Namespace juggerbot_asm
// Params 1
// Checksum 0x768f857c, Offset: 0x167
// Size: 0x1a
function on_move_speed_changed( params )
{
    self.var_cdf48282bb6d1237 = self aigetdesiredspeed();
}

// Namespace juggerbot_asm
// Params 3
// Checksum 0xa9328f9d, Offset: 0x189
// Size: 0x1e
function function_3a928a0628d1b1d6( asmname, statename, params )
{
    
}

// Namespace juggerbot_asm
// Params 3
// Checksum 0xbe963200, Offset: 0x1af
// Size: 0xb3
function juggerbot_playturnanim( asmname, statename, params )
{
    turnanim = self asmgetanim( asmname, statename );
    assert( isdefined( turnanim ) );
    turnxanim = asm::asm_getxanim( statename, turnanim );
    
    if ( !self.juggerbotdata )
    {
        self.juggerbotdata = spawnstruct();
    }
    
    self.juggerbotdata.turnanimindex = turnanim;
    self.juggerbotdata.var_703b2e2a7c407d75 = statename;
    self aisetanim( statename, turnanim, 1 );
    asm::asm_donotetrackswithinterceptor( asmname, statename, &function_989769823feb54cc, undefined, params );
}

// Namespace juggerbot_asm
// Params 2
// Checksum 0x27cf7c2, Offset: 0x26a
// Size: 0x38
function function_dd6a4ec02ebd1ef6( note, statename )
{
    note = getsubstr( note, 10 );
    
    if ( isstartstr( note, "face_goal" ) )
    {
        function_989769823feb54cc( statename, note, undefined );
    }
}

// Namespace juggerbot_asm
// Params 4
// Checksum 0x44f7d569, Offset: 0x2aa
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

// Namespace juggerbot_asm
// Params 3
// Checksum 0xd350732a, Offset: 0x340
// Size: 0x20c, Type: bool
function function_989769823feb54cc( statename, note, params )
{
    if ( note == "face_goal" && self.asmname )
    {
        if ( !self.juggerbotdata || !self.juggerbotdata.turnanimindex )
        {
            return false;
        }
        
        turnxanim = asm::asm_getxanim( statename, self.juggerbotdata.turnanimindex );
        
        if ( !self.enemy )
        {
            return false;
        }
        
        self.juggerbotdata.targetpos = self.enemy.origin;
        
        if ( !turnxanim )
        {
            return false;
        }
        
        finishtime = getnotetracktimes( turnxanim, "finish" );
        
        if ( finishtime.size == 0 )
        {
            finishtime[ 0 ] = 1;
        }
        
        endtime = getnotetracktimes( turnxanim, "face_goal_end" );
        
        if ( endtime.size == 0 )
        {
            endtime[ 0 ] = finishtime[ 0 ];
        }
        
        [ animtime ] = getnotetracktimes( turnxanim, "face_goal" );
        animrate = self getanimrate( turnxanim );
        assert( animrate != 0 );
        
        if ( animrate == 0 )
        {
            animrate = 1;
        }
        
        anim_length = getanimlength( turnxanim ) / animrate;
        turntime = endtime[ 0 ] - animtime;
        turntime *= anim_length;
        beyondyaw = 0;
        
        if ( endtime[ 0 ] < finishtime[ 0 ] )
        {
            beyondyaw = getangledelta( turnxanim, endtime[ 0 ], finishtime[ 0 ] );
        }
        
        metopos = self.juggerbotdata.targetpos - self.origin;
        reactworldyaw = vectortoyaw( metopos );
        turnyaw = function_b44dc7a862e03d53( turnxanim, reactworldyaw, beyondyaw, endtime[ 0 ] );
        thread facegoalthread( statename, turnyaw, beyondyaw, self.var_dd6868ae78a8de98, reactworldyaw, turntime, turnxanim, endtime[ 0 ] );
        return true;
    }
    
    return false;
}

// Namespace juggerbot_asm
// Params 8
// Checksum 0x424a63c6, Offset: 0x555
// Size: 0x2ec
function facegoalthread( statename, turnyaw, beyondyaw, reactpos, reactworldyaw, turntime, turnanim, endtime )
{
    self notify( #"facegoalthread" );
    self endon( #"facegoalthread" );
    self endon( #"death" );
    self endon( statename + "_finished" );
    frames = ceil( turntime * 1000 / level.frameduration );
    var_330512304e2a26a9 = turnyaw / frames;
    var_86f175f3ca84692 = undefined;
    stopyaw = 0;
    
    while ( frames > 0 )
    {
        if ( !self.enemy )
        {
            break;
        }
        
        overrideent = self.enemy;
        
        if ( !self.juggerbotdata || !self.juggerbotdata.targetpos )
        {
            self.juggerbotdata.targetpos = overrideent.origin;
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
                if ( distancesquared( self.juggerbotdata.targetpos, overrideent.origin ) >= 225 )
                {
                    self.juggerbotdata.targetpos = overrideent.origin;
                    var_f1b07fc0947fb3f4 = 1;
                }
            }
            else if ( !bcansee )
            {
                if ( isdefined( lkp ) && lktime > 0 )
                {
                    self.juggerbotdata.targetpos = lkp;
                    var_f1b07fc0947fb3f4 = 1;
                }
            }
            
            if ( var_f1b07fc0947fb3f4 )
            {
                metopos = self.juggerbotdata.targetpos - self.origin;
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

// Namespace juggerbot_asm
// Params 3
// Checksum 0xaddf7505, Offset: 0x849
// Size: 0x28
function function_d5341994819428dd( asmname, statename, params )
{
    self.juggerbotdata = undefined;
}

