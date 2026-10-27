// scripts\common\ai_lookat.gsc  (hash_7d535542e36d66f9.gscc) (size: 8973 Bytes / 0x230d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x30e9d68a (820631178)
// size ...... 8973 (0x230d)
// includes .. 1   (offset: 0x2211)
// strings ... 2   (offset: 0x2219)
// dev strs .. 17  (offset: 0x2231)
// exports ... 22  (offset: 0x1801)
// cseg ...... 0x6e + 0x1793 (0x1801)
// imports ... 47  (offset: 0x1b71)
// animtree1 . 0   (offset: 0x230d)
// animtree2 . 0   (offset: 0x230d)
#using scripts\common\utility;

#namespace ai_lookat;

// Namespace ai_lookat
// Params 2
// Checksum 0x65ba8b6b, Offset: 0x8c
// Size: 0x2f
function enablelookatplayer( enabletime, percent )
{
    enablelookatentity( level.player, utility::function_3cf801aa1d168fc8( enabletime ), percent );
}

// Namespace ai_lookat
// Params 0
// Checksum 0xee6aeecf, Offset: 0xc3
// Size: 0x12
function disablelookatplayer()
{
    disablelookatentity( level.player );
}

// Namespace ai_lookat
// Params 4
// Checksum 0x9d9eef25, Offset: 0xdd
// Size: 0x8c
function enablelookatentity( target, speed, percent, offset )
{
    if ( !isdefined( self.lookatentities ) )
    {
        self.lookatentities = [];
    }
    
    self.lookatentities[ self.lookatentities.size ] = { #offset:offset, #percent:percent, #speed:speed, #target:target };
    function_f265a07183640c56( target, speed, percent, offset );
}

// Namespace ai_lookat
// Params 1
// Checksum 0xe685837a, Offset: 0x171
// Size: 0x81
function disablelookatentity( target )
{
    if ( !isdefined( self.lookatentities ) )
    {
        self.lookatentities = [];
    }
    
    function_582fb63c5cef0c5c( target );
    look = self.lookatentities[ self.lookatentities.size - 1 ];
    function_f265a07183640c56( look.target, look.speed, look.percent, look.offset );
}

// Namespace ai_lookat
// Params 1, eflags: 0x4
// Checksum 0x4682e291, Offset: 0x1fa
// Size: 0x127
function private function_582fb63c5cef0c5c( target )
{
    remove = [];
    
    foreach ( look in self.lookatentities )
    {
        if ( !isdefined( look.target ) || look.target == target )
        {
            remove[ remove.size ] = look;
        }
    }
    
    foreach ( look in remove )
    {
        self.lookatentities = arrayremove( self.lookatentities, look );
    }
}

// Namespace ai_lookat
// Params 4, eflags: 0x4
// Checksum 0xddf424f, Offset: 0x329
// Size: 0xf8
function private function_f265a07183640c56( target, speed, percent, offset )
{
    if ( isdefined( target ) )
    {
        self setlookatenabled( 1 );
        self setlookatstate( "request" );
        focustarget = spawnstruct();
        
        if ( isdefined( speed ) )
        {
            focustarget.speed = speed;
        }
        
        if ( isdefined( percent ) )
        {
            focustarget.percent = percent;
        }
        
        if ( isent( target ) )
        {
            focustarget.entity = target;
        }
        else
        {
            assert( isstruct( target ) && isdefined( target.origin ) );
            focustarget.position = target.origin;
        }
        
        if ( isdefined( offset ) )
        {
            focustarget.offset = offset;
        }
        
        self lookat( focustarget );
        return;
    }
    
    self setlookatstate( "neutral" );
    self setlookatenabled( 0 );
}

// Namespace ai_lookat
// Params 0
// Checksum 0x7e9e0bfe, Offset: 0x429
// Size: 0x11
function islookingatplayer()
{
    return islookingatentity( level.player );
}

// Namespace ai_lookat
// Params 1
// Checksum 0x40a1b707, Offset: 0x443
// Size: 0x15, Type: bool
function islookingatentity( ent )
{
    return ent == getlookatentity();
}

// Namespace ai_lookat
// Params 0
// Checksum 0x6cba6f8b, Offset: 0x461
// Size: 0x2f
function getlookatentity()
{
    if ( !isdefined( self.lookatentities ) || !self.lookatentities.size )
    {
        return;
    }
    
    return utility::function_f1933af772476229( self.lookatentities );
}

// Namespace ai_lookat
// Params 12
// Checksum 0xedc82a02, Offset: 0x499
// Size: 0x91b
function function_25744b55fe6af33f( ontimeclose, ontimefar, offtimeclose, offtimefar, innerradius, outerradius, enabletimeclose, enabletimefar, percentclose, percentfar, fovcos, var_d0dcaf0cc224660f )
{
    self endon( #"death" );
    self endon( #"stop_idle_lookat" );
    var_23dc00d3874c0941 = 1;
    var_d8cc70e768157696 = 2;
    var_2bd6b20aeec3cf0b = 2000;
    cstart = 0;
    ccantsee = 1;
    var_7af99705ff8bf6f9 = 2;
    var_9d322c59f4aa6c28 = 3;
    var_490b9698511e3343 = 4;
    var_3cfcd43cd655f4b6 = 5;
    var_ff9113cb96e62f35 = 6;
    var_6d6c16c61659c578 = 7;
    var_9c9b256a73adba0 = 8;
    var_a1c24d03078948f1 = 9;
    state = cstart;
    nextstate = cstart;
    cooldown = 0;
    ontimeclose = int( ontimeclose ) * 1000;
    ontimefar = int( ontimefar ) * 1000;
    offtimeclose = int( offtimeclose ) * 1000;
    offtimefar = int( offtimefar ) * 1000;
    
    /#
        setdvarifuninitialized( @"hash_f3db11612f967c4a", 0 );
    #/
    
    while ( true )
    {
        disttoplayer = distance( level.player.origin, self.origin );
        diststate = var_d8cc70e768157696;
        
        if ( disttoplayer > innerradius )
        {
            diststate = var_23dc00d3874c0941;
        }
        
        selfforward = anglestoforward( self.angles );
        playerforward = anglestoforward( level.player.angles );
        toplayer = vectornormalize( level.player.origin - self.origin );
        canseeplayer = vectordot( selfforward, toplayer ) > fovcos && disttoplayer < outerradius;
        playercansee = vectordot( playerforward, -1 * toplayer ) > var_d0dcaf0cc224660f;
        
        /#
            if ( getdvarint( @"hash_f3db11612f967c4a", 0 ) )
            {
                statestr = "<dev string:x24>";
                
                switch ( state )
                {
                    case 0:
                        statestr = "<dev string:x25>";
                        break;
                    case 1:
                        statestr = "<dev string:x2b>";
                        break;
                    case 2:
                        statestr = "<dev string:x34>";
                        break;
                    case 3:
                        statestr = "<dev string:x42>";
                        break;
                    case 4:
                        statestr = "<dev string:x4d>";
                        break;
                    case 5:
                        statestr = "<dev string:x66>";
                        break;
                    case 6:
                        statestr = "<dev string:x7e>";
                        break;
                    case 7:
                        statestr = "<dev string:x8a>";
                        break;
                    case 8:
                        statestr = "<dev string:x9f>";
                        break;
                    case 9:
                        statestr = "<dev string:xaa>";
                        break;
                    default:
                        statestr = "<dev string:xbe>";
                        break;
                }
                
                debugpos = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + 80 );
                print3d( debugpos, statestr, ( 0, 0, 1 ), 1, 0.25, 1, 1 );
            }
        #/
        
        if ( state == cstart )
        {
            if ( !canseeplayer )
            {
                nextstate = ccantsee;
            }
            else if ( canseeplayer )
            {
                nextstate = var_7af99705ff8bf6f9;
            }
        }
        else if ( state == ccantsee )
        {
            if ( canseeplayer )
            {
                nextstate = var_7af99705ff8bf6f9;
            }
        }
        else if ( state == var_7af99705ff8bf6f9 && cooldown < gettime() )
        {
            if ( !canseeplayer )
            {
                nextstate = ccantsee;
            }
            else if ( diststate == var_d8cc70e768157696 && playercansee )
            {
                nextstate = var_9d322c59f4aa6c28;
            }
            else if ( diststate == var_d8cc70e768157696 && !playercansee )
            {
                nextstate = var_ff9113cb96e62f35;
            }
            else if ( diststate == var_23dc00d3874c0941 )
            {
                nextstate = var_9c9b256a73adba0;
            }
        }
        else if ( state == var_9d322c59f4aa6c28 )
        {
            if ( diststate != var_d8cc70e768157696 || !canseeplayer || !playercansee )
            {
                nextstate = var_490b9698511e3343;
            }
        }
        else if ( state == var_490b9698511e3343 && cooldown < gettime() )
        {
            if ( !canseeplayer )
            {
                nextstate = ccantsee;
            }
            else if ( diststate == var_d8cc70e768157696 && playercansee )
            {
                nextstate = var_9d322c59f4aa6c28;
            }
            else if ( diststate == var_d8cc70e768157696 && !playercansee )
            {
                nextstate = var_6d6c16c61659c578;
            }
            else if ( diststate == var_23dc00d3874c0941 )
            {
                nextstate = var_a1c24d03078948f1;
            }
        }
        else if ( state == var_3cfcd43cd655f4b6 && cooldown < gettime() )
        {
            if ( !canseeplayer )
            {
                nextstate = ccantsee;
            }
            else if ( diststate == var_d8cc70e768157696 && playercansee )
            {
                nextstate = var_9d322c59f4aa6c28;
            }
            else if ( diststate == var_d8cc70e768157696 && !playercansee )
            {
                nextstate = var_6d6c16c61659c578;
            }
            else if ( diststate == var_23dc00d3874c0941 )
            {
                nextstate = var_a1c24d03078948f1;
            }
        }
        else if ( state == var_ff9113cb96e62f35 && cooldown < gettime() )
        {
            if ( !canseeplayer )
            {
                nextstate = ccantsee;
            }
            else if ( diststate == var_d8cc70e768157696 && !playercansee )
            {
                nextstate = var_6d6c16c61659c578;
            }
            else if ( diststate == var_d8cc70e768157696 && playercansee )
            {
                nextstate = var_9d322c59f4aa6c28;
            }
            else if ( diststate == var_23dc00d3874c0941 )
            {
                nextstate = var_a1c24d03078948f1;
            }
        }
        else if ( state == var_6d6c16c61659c578 && cooldown < gettime() )
        {
            if ( !canseeplayer )
            {
                nextstate = ccantsee;
            }
            else if ( diststate == var_d8cc70e768157696 && playercansee )
            {
                nextstate = var_3cfcd43cd655f4b6;
            }
            else if ( diststate == var_d8cc70e768157696 && !playercansee )
            {
                nextstate = var_ff9113cb96e62f35;
            }
            else if ( diststate == var_23dc00d3874c0941 )
            {
                nextstate = var_a1c24d03078948f1;
            }
        }
        else if ( state == var_9c9b256a73adba0 && cooldown < gettime() )
        {
            if ( !canseeplayer )
            {
                nextstate = ccantsee;
            }
            else if ( diststate == var_23dc00d3874c0941 )
            {
                nextstate = var_a1c24d03078948f1;
            }
            else if ( diststate == var_d8cc70e768157696 && playercansee )
            {
                nextstate = var_9d322c59f4aa6c28;
            }
            else if ( diststate == var_d8cc70e768157696 && !playercansee )
            {
                nextstate = var_6d6c16c61659c578;
            }
        }
        else if ( state == var_a1c24d03078948f1 && cooldown < gettime() )
        {
            if ( !canseeplayer )
            {
                nextstate = ccantsee;
            }
            else if ( diststate == var_23dc00d3874c0941 )
            {
                nextstate = var_9c9b256a73adba0;
            }
            else if ( diststate == var_d8cc70e768157696 && !playercansee )
            {
                nextstate = var_6d6c16c61659c578;
            }
            else if ( diststate == var_d8cc70e768157696 && playercansee )
            {
                nextstate = var_3cfcd43cd655f4b6;
            }
        }
        
        if ( state != nextstate )
        {
            if ( state == cstart )
            {
                if ( nextstate == ccantsee )
                {
                    disablelookatplayer();
                }
                else if ( nextstate == var_7af99705ff8bf6f9 )
                {
                    cooldown = gettime() + var_2bd6b20aeec3cf0b;
                }
            }
            else if ( state == ccantsee )
            {
                if ( nextstate == var_7af99705ff8bf6f9 )
                {
                    cooldown = gettime() + var_2bd6b20aeec3cf0b;
                }
            }
            else if ( state == var_7af99705ff8bf6f9 )
            {
                if ( nextstate == ccantsee )
                {
                    disablelookatplayer();
                }
                else if ( nextstate == var_9d322c59f4aa6c28 )
                {
                    enablelookatplayer( enabletimeclose, percentclose );
                }
                else if ( nextstate == var_ff9113cb96e62f35 )
                {
                    enablelookatplayer( enabletimeclose, percentclose );
                    cooldown = gettime() + ontimeclose;
                }
                else if ( nextstate == var_9c9b256a73adba0 )
                {
                    enablelookatplayer( enabletimefar, percentfar );
                    cooldown = gettime() + ontimefar;
                }
            }
            else if ( state == var_9d322c59f4aa6c28 )
            {
                if ( nextstate == var_490b9698511e3343 )
                {
                    cooldown = gettime() + var_2bd6b20aeec3cf0b;
                }
            }
            else if ( state == var_490b9698511e3343 )
            {
                if ( nextstate == ccantsee )
                {
                    disablelookatplayer();
                }
                else if ( nextstate == var_6d6c16c61659c578 )
                {
                    disablelookatplayer();
                    cooldown = gettime() + ontimeclose;
                }
                else if ( nextstate == var_a1c24d03078948f1 )
                {
                    disablelookatplayer();
                    cooldown = gettime() + ontimeclose;
                }
            }
            else if ( state == var_3cfcd43cd655f4b6 )
            {
                if ( nextstate == var_9d322c59f4aa6c28 )
                {
                    enablelookatplayer( enabletimeclose, percentclose );
                }
                else if ( nextstate == var_6d6c16c61659c578 )
                {
                    cooldown = gettime() + offtimeclose;
                }
                else if ( nextstate == var_a1c24d03078948f1 )
                {
                    cooldown = gettime() + offtimefar;
                }
            }
            else if ( state == var_ff9113cb96e62f35 )
            {
                if ( nextstate == ccantsee )
                {
                    disablelookatplayer();
                }
                else if ( nextstate == var_6d6c16c61659c578 )
                {
                    disablelookatplayer();
                    cooldown = gettime() + offtimeclose;
                }
                else if ( nextstate == var_a1c24d03078948f1 )
                {
                    disablelookatplayer();
                    cooldown = gettime() + offtimefar;
                }
            }
            else if ( state == var_6d6c16c61659c578 )
            {
                if ( nextstate == var_3cfcd43cd655f4b6 )
                {
                    cooldown = gettime() + var_2bd6b20aeec3cf0b;
                }
                else if ( nextstate == var_ff9113cb96e62f35 )
                {
                    enablelookatplayer( enabletimeclose, percentclose );
                    cooldown = gettime() + ontimeclose;
                }
                else if ( nextstate == var_a1c24d03078948f1 )
                {
                    cooldown = gettime() + offtimefar;
                }
            }
            else if ( state == var_9c9b256a73adba0 )
            {
                if ( nextstate == ccantsee )
                {
                    disablelookatplayer();
                }
                else if ( nextstate == var_a1c24d03078948f1 )
                {
                    disablelookatplayer();
                    cooldown = gettime() + offtimefar;
                }
                else if ( nextstate == var_9d322c59f4aa6c28 )
                {
                }
                else if ( nextstate == var_6d6c16c61659c578 )
                {
                    disablelookatplayer();
                    cooldown = gettime() + offtimeclose;
                }
            }
            else if ( state == var_a1c24d03078948f1 )
            {
                if ( nextstate == var_9c9b256a73adba0 )
                {
                    enablelookatplayer( enabletimefar, percentfar );
                    cooldown = gettime() + ontimefar;
                }
                else if ( nextstate == var_6d6c16c61659c578 )
                {
                    cooldown = gettime() + offtimeclose;
                }
                else if ( nextstate == var_3cfcd43cd655f4b6 )
                {
                    cooldown = gettime() + var_2bd6b20aeec3cf0b;
                }
            }
            
            state = nextstate;
        }
        
        waitframe();
    }
}

// Namespace ai_lookat
// Params 7
// Checksum 0xc89d5615, Offset: 0xdbc
// Size: 0x3c3
function function_493390da3d8a2ea5( ontime, offtime, radius, enabletime, percent, fovcos, var_d0dcaf0cc224660f )
{
    self endon( #"death" );
    self endon( #"stop_idle_lookat" );
    ccantsee = 0;
    var_7af99705ff8bf6f9 = 1;
    cglance = 2;
    var_5f650e525f4cc0fa = 3;
    var_e634c82eb55206cf = 2000;
    state = ccantsee;
    nextstate = ccantsee;
    cooldown = 0;
    ontime = int( ontime ) * 1000;
    offtime = int( offtime ) * 1000;
    
    /#
        setdvarifuninitialized( @"hash_f3db11612f967c4a", 0 );
    #/
    
    while ( true )
    {
        disttoplayer = distance( level.player.origin, self.origin );
        selfforward = anglestoforward( self.angles );
        playerforward = anglestoforward( level.player.angles );
        toplayer = vectornormalize( level.player.origin - self.origin );
        canseeplayer = vectordot( selfforward, toplayer ) > fovcos && disttoplayer < radius;
        playercansee = vectordot( playerforward, -1 * toplayer ) > var_d0dcaf0cc224660f;
        canseeplayer = canseeplayer && playercansee;
        
        /#
            if ( getdvarint( @"hash_f3db11612f967c4a", 0 ) )
            {
                statestr = "<dev string:x24>";
                
                switch ( state )
                {
                    case 0:
                        statestr = "<dev string:x2b>";
                        break;
                    case 1:
                        statestr = "<dev string:x34>";
                        break;
                    case 2:
                        statestr = "<dev string:xc6>";
                        break;
                    case 3:
                        statestr = "<dev string:xcd>";
                        break;
                    default:
                        statestr = "<dev string:xbe>";
                        break;
                }
                
                debugpos = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + 80 );
                print3d( debugpos, statestr, ( 0, 0, 1 ), 1, 0.25, 1, 1 );
            }
        #/
        
        if ( state == ccantsee )
        {
            if ( canseeplayer )
            {
                nextstate = var_7af99705ff8bf6f9;
            }
        }
        else if ( state == var_7af99705ff8bf6f9 && cooldown < gettime() )
        {
            if ( canseeplayer )
            {
                nextstate = cglance;
            }
            else
            {
                nextstate = ccantsee;
            }
        }
        else if ( state == cglance && cooldown < gettime() )
        {
            if ( canseeplayer )
            {
                nextstate = var_5f650e525f4cc0fa;
            }
            else
            {
                nextstate = ccantsee;
            }
        }
        else if ( state == var_5f650e525f4cc0fa && cooldown < gettime() )
        {
            if ( canseeplayer )
            {
                nextstate = cglance;
            }
            else
            {
                nextstate = ccantsee;
            }
        }
        
        if ( state != nextstate )
        {
            if ( state == ccantsee )
            {
                if ( nextstate == var_7af99705ff8bf6f9 )
                {
                    cooldown = gettime() + var_e634c82eb55206cf;
                }
            }
            else if ( state == var_7af99705ff8bf6f9 )
            {
                if ( nextstate == cglance )
                {
                    enablelookatplayer( enabletime, percent );
                    cooldown = gettime() + ontime;
                }
            }
            else if ( state == cglance )
            {
                if ( nextstate == var_5f650e525f4cc0fa )
                {
                    disablelookatplayer();
                    cooldown = gettime() + offtime;
                }
                else if ( nextstate == ccantsee )
                {
                    disablelookatplayer();
                }
            }
            else if ( state == var_5f650e525f4cc0fa )
            {
                if ( nextstate == cglance )
                {
                    enablelookatplayer( enabletime, percent );
                    cooldown = gettime() + ontime;
                }
            }
            
            state = nextstate;
        }
        
        waitframe();
    }
}

// Namespace ai_lookat
// Params 3
// Checksum 0x717d8bd9, Offset: 0x1187
// Size: 0x48
function function_3e43df790b0ba2cc( enable, playerradius, airadius )
{
    level.var_a7516ac806d06b4f = enable;
    
    if ( enable )
    {
        level thread function_de1d10d827815b89( playerradius, airadius );
        return;
    }
    
    level notify( #"end_levellookatteam" );
}

// Namespace ai_lookat
// Params 2
// Checksum 0x44ffd6b2, Offset: 0x11d7
// Size: 0x103
function function_de1d10d827815b89( playerradius, airadius )
{
    level endon( #"end_levellookatteam" );
    
    if ( !isdefined( playerradius ) )
    {
        playerradius = 1024;
    }
    
    if ( !isdefined( airadius ) )
    {
        airadius = 512;
    }
    
    while ( level.var_a7516ac806d06b4f )
    {
        wait 5;
        ai = getaiarrayinradius( level.player.origin, playerradius );
        
        foreach ( guy in ai )
        {
            if ( isdefined( guy isinscriptedstate() ) && guy isinscriptedstate() )
            {
                continue;
            }
            
            /#
                guy thread function_c423198902a117be();
            #/
            
            guy thread ailookatteamlist( ai, airadius, 5 );
        }
    }
}

// Namespace ai_lookat
// Params 3
// Checksum 0x3ebee705, Offset: 0x12e2
// Size: 0x5d
function ailookatteamlist( ai, maxdist, maxtargets )
{
    self endon( #"death" );
    self endon( #"kill_lookatteam" );
    enablelookatteam( 1 );
    function_e5b520d1a0e36c4a( ai, maxdist );
    function_61987c11611c2d28( ai, maxdist, 5 );
    enablelookatteam( 0 );
}

// Namespace ai_lookat
// Params 3
// Checksum 0x5b668a43, Offset: 0x1347
// Size: 0x9b
function lookatteamthread( guys, maxdist, maxtargets )
{
    if ( !isent( self ) )
    {
        return;
    }
    
    self endon( #"death" );
    self endon( #"kill_lookatteam" );
    
    if ( !isdefined( self ) || self == level.player )
    {
        return;
    }
    
    enablelookatteam( 1 );
    guys[ guys.size ] = level.player;
    
    /#
        thread function_c423198902a117be();
    #/
    
    while ( true )
    {
        function_79674e2daec9ad25();
        function_e5b520d1a0e36c4a( guys );
        function_61987c11611c2d28( guys, maxdist, maxtargets );
    }
}

// Namespace ai_lookat
// Params 1
// Checksum 0xc0540999, Offset: 0x13ea
// Size: 0x31
function enablelookatteam( enable )
{
    self setlookatenabled( enable );
    self.var_5ec73b3b0ea2c6b5 = enable;
    
    if ( !enable )
    {
        self notify( #"kill_lookatteam" );
    }
}

// Namespace ai_lookat
// Params 2
// Checksum 0x1f3d238b, Offset: 0x1423
// Size: 0xfc
function function_e5b520d1a0e36c4a( guys, maxdist )
{
    if ( !self.var_5ec73b3b0ea2c6b5 )
    {
        return;
    }
    
    guys = function_46f9072493651dc9( guys );
    guy = utility::array_random( guys );
    
    if ( guys.size < 2 )
    {
        return;
    }
    
    if ( !isdefined( guy ) || vectordot( self.origin, guy.origin ) < 0 )
    {
        return;
    }
    
    if ( guy == self )
    {
        function_79674e2daec9ad25();
        return;
    }
    
    if ( self.lastlookattarget == guy )
    {
        self.lastlookattarget = undefined;
        return;
    }
    
    if ( distancesquared( self.origin, guy.origin ) > maxdist * maxdist )
    {
        return;
    }
    
    if ( vectordot( self.origin, guy.origin ) <= 0 )
    {
        return;
    }
    
    self.lastlookattarget = guy;
    
    /#
        self.lookatstate = "<dev string:xdd>";
    #/
    
    stare( guy );
}

// Namespace ai_lookat
// Params 3
// Checksum 0xa44de9c4, Offset: 0x1527
// Size: 0x141
function function_61987c11611c2d28( guys, maxdist, maxtargets )
{
    assert( self != level.player );
    guys = function_46f9072493651dc9( guys );
    guys = sortbydistance( guys, self.origin );
    
    if ( guys.size < 2 )
    {
        return;
    }
    
    /#
        self.lookatstate = "<dev string:xe4>";
    #/
    
    for ( lookattargetindex = 0; lookattargetindex < guys.size ; lookattargetindex++ )
    {
        guy = guys[ lookattargetindex ];
        
        if ( !self.var_5ec73b3b0ea2c6b5 )
        {
            continue;
        }
        
        if ( !isdefined( guy ) )
        {
            continue;
        }
        
        if ( self == guy )
        {
            continue;
        }
        
        if ( !isalive( guy ) )
        {
            continue;
        }
        
        if ( self.lastlookattarget == guy )
        {
            self.lastlookattarget = undefined;
            continue;
        }
        
        if ( lookattargetindex >= maxtargets )
        {
            return;
        }
        
        if ( distancesquared( self.origin, guy.origin ) > maxdist * maxdist )
        {
            continue;
        }
        
        if ( vectordot( self.origin, guy.origin ) <= 0 )
        {
            continue;
        }
        
        self.lastlookattarget = guy;
        stare( guy );
    }
    
    function_79674e2daec9ad25();
}

// Namespace ai_lookat
// Params 0
// Checksum 0x320bf7c, Offset: 0x1670
// Size: 0x4e
function function_79674e2daec9ad25()
{
    if ( !isent( self ) )
    {
        return;
    }
    
    minidletime = 2;
    maxidletime = 4;
    
    /#
        self.lookatstate = "<dev string:xec>";
    #/
    
    self setlookatenabled( 0 );
    wait randomfloatrange( minidletime, maxidletime );
    self setlookatenabled( 1 );
}

// Namespace ai_lookat
// Params 1
// Checksum 0x52c59e10, Offset: 0x16c6
// Size: 0x99
function stare( other )
{
    percent = 0.8;
    speed = 1;
    enablelookatentity( other, utility::function_3cf801aa1d168fc8( speed ), percent );
    var_d78a68d84e0411e0 = 0.5;
    var_34750964448a44b2 = 1;
    
    if ( isdefined( other ) )
    {
        if ( self.team == other.team )
        {
            var_d78a68d84e0411e0 = 1.5;
            var_34750964448a44b2 = 2.5;
        }
        else
        {
            var_d78a68d84e0411e0 = 1;
            var_34750964448a44b2 = 1.5;
        }
    }
    
    wait randomfloatrange( var_d78a68d84e0411e0, var_34750964448a44b2 );
}

/#

    // Namespace ai_lookat
    // Params 0
    // Checksum 0x54d96517, Offset: 0x1767
    // Size: 0x9a, Type: dev
    function function_c423198902a117be()
    {
        self endon( #"death" );
        self endon( #"kill_lookatteam" );
        setdvarifuninitialized( @"hash_4e640bf30799c32f", 0 );
        
        while ( true )
        {
            waitframe();
            
            if ( getdvarint( @"hash_4e640bf30799c32f", 0 ) )
            {
                debugpos = self.origin + ( 0, 0, 88 );
                
                if ( isdefined( self.lookatstate ) )
                {
                    print3d( debugpos, self.lookatstate, ( 1, 1, 1 ), 1, 0.25 );
                }
            }
        }
    }

#/
