// script_4f2307e3f198b4e3  (hash_4f2307e3f198b4e3.gscc) (size: 2764 Bytes / 0xacc / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe0ab801 (235583489)
// size ...... 2764 (0xacc)
// includes .. 2   (offset: 0xa68)
// strings ... 6   (offset: 0xa78)
// dev strs .. 0   (offset: 0xacc)
// exports ... 5   (offset: 0x64c)
// cseg ...... 0xa8 + 0x5a4 (0x64c)
// imports ... 29  (offset: 0x714)
// animtree1 . 0   (offset: 0xacc)
// animtree2 . 0   (offset: 0xacc)
#using scripts\asm\asm;
#using scripts\common\utility;

#namespace namespace_19d9258f50dfa590;

// Namespace namespace_19d9258f50dfa590
// Params 3
// Checksum 0x6bc8283f, Offset: 0xc6
// Size: 0x5a
function chooseanim_evolve( asmname, statename, params )
{
    evolve_alias = self getaiblackboarddynamic( "evolve_low" ) ? "evolve_low" : "evolve";
    evolve_anim = asm::asm_chooseanim( asmname, statename, evolve_alias );
    return evolve_anim;
}

// Namespace namespace_19d9258f50dfa590
// Params 3, eflags: 0x4
// Checksum 0x9af5a9de, Offset: 0x129
// Size: 0x3e7
function private link_to_host_procedural( host, var_4a12e33cf5ced339, duration )
{
    self endon( #"death" );
    self endon( #"evolution_end" );
    host endon( #"death" );
    assert( !isdefined( self.var_2d00ed01947563cf.anchor ) );
    self.var_2d00ed01947563cf.anchor = utility::spawn_script_origin();
    
    if ( !isdefined( self.var_2d00ed01947563cf.anchor ) )
    {
        return;
    }
    
    self linkto( self.var_2d00ed01947563cf.anchor );
    host_tag = host gettagorigin( var_4a12e33cf5ced339, 1 ) ?? host.origin;
    host_to_self = self.origin - host_tag;
    host_forward = anglestoforward( host.angles );
    circle_clockwise = undefined;
    
    if ( vectordot2( host_forward, host_to_self ) > 0 )
    {
        self_forward = anglestoforward( self.angles );
        circle_clockwise = vectorcross( host_to_self, self_forward )[ 2 ] < 0;
    }
    else
    {
        circle_clockwise = vectorcross( host_forward, host_to_self )[ 2 ] < 0;
    }
    
    /#
        debug_evolution = getdvarint( @"hash_1c281b5f88bdb9cc", 0 );
    #/
    
    time_left = duration;
    frac_step = 0.1 / duration;
    
    while ( time_left > 0.1 )
    {
        current_frac = 1 - time_left / duration;
        var_93c2be7978332a90 = current_frac + frac_step;
        angular_interp = 0.1 / time_left;
        radial_interp = ( 1 - var_93c2be7978332a90 * var_93c2be7978332a90 ) / ( 1 - current_frac * current_frac );
        delta_yaw = function_63a2ef74ebcc6413( host.angles[ 1 ] - 180 - vectortoyaw( host_to_self ) ) - circle_clockwise * 360;
        next_origin = host_tag + rotatevector( host_to_self * radial_interp, ( 0, delta_yaw * angular_interp, 0 ) );
        next_angles = ( 0, vectortoyaw( next_origin - self.origin ), 0 );
        self.var_2d00ed01947563cf.anchor moveto( next_origin, 0.1 );
        self.var_2d00ed01947563cf.anchor rotateto( next_angles, 0.1 );
        self orientmode( "face point", next_origin );
        
        /#
            if ( debug_evolution )
            {
                utility::draw_arrow( self.origin, next_origin, ( 1 - current_frac, current_frac, 0 ), 1, 1, int( ( time_left + 5 ) / level.framedurationseconds ) );
            }
        #/
        
        wait 0.1;
        time_left -= 0.1;
        host_tag = host gettagorigin( var_4a12e33cf5ced339, 1 ) ?? host.origin;
        host_to_self = self.origin - host_tag;
    }
    
    self.var_2d00ed01947563cf.anchor moveto( host_tag, time_left );
    self.var_2d00ed01947563cf.anchor rotateto( host.angles, time_left );
    self orientmode( "face point", host_tag );
    
    /#
        if ( debug_evolution )
        {
            utility::draw_arrow( self.origin, host_tag, ( 0, 1, 0 ), 1, 1, int( ( time_left + 5 ) / level.framedurationseconds ) );
        }
    #/
    
    if ( time_left > 0 )
    {
        wait time_left;
    }
    
    self.var_2d00ed01947563cf.anchor linkto( host, var_4a12e33cf5ced339, ( 0, 0, 0 ), ( 0, 0, 0 ) );
    self orientmode( "face angle", host.angles[ 1 ] );
}

// Namespace namespace_19d9258f50dfa590
// Params 2
// Checksum 0x6fdf8fd3, Offset: 0x518
// Size: 0xb9
function function_eb1a135b5950dda8( asmname, params )
{
    if ( isdefined( self.var_2d00ed01947563cf.host ) )
    {
        current_state = self asmgetcurrentstate( asmname );
        evolve_anim = asm::asm_getxanim( current_state, self asmgetanim( asmname, current_state ) );
        link_time = 1;
        
        if ( animhasnotetrack( evolve_anim, "link_to_host" ) )
        {
            anim_length = getanimlength( evolve_anim );
            link_time = getnotetracktimes( evolve_anim, "link_to_host" )[ 0 ] * anim_length;
        }
        
        thread link_to_host_procedural( self.var_2d00ed01947563cf.host, "tag_sync", link_time );
    }
}

// Namespace namespace_19d9258f50dfa590
// Params 2
// Checksum 0x89c1b92f, Offset: 0x5d9
// Size: 0x73
function function_e652bb918e62b642( asmname, params )
{
    if ( isdefined( self.var_2d00ed01947563cf.anchor ) )
    {
        if ( self islinked() )
        {
            self unlink( 1 );
        }
        
        self.var_2d00ed01947563cf.anchor delete();
        self.var_2d00ed01947563cf.anchor = undefined;
    }
    
    self notify( #"evolution_end" );
}

