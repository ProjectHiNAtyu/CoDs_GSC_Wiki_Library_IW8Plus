// script_33781ab60ef13663  (hash_33781ab60ef13663.gscc) (size: 1483 Bytes / 0x5cb / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf8b9e48b (4172932235)
// size ...... 1483 (0x5cb)
// includes .. 3   (offset: 0x577)
// strings ... 5   (offset: 0x58f)
// dev strs .. 0   (offset: 0x5cb)
// exports ... 5   (offset: 0x323)
// cseg ...... 0xb2 + 0x271 (0x323)
// imports ... 14  (offset: 0x3eb)
// animtree1 . 0   (offset: 0x5cb)
// animtree2 . 0   (offset: 0x5cb)
#using scripts\asm\asm;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace namespace_7e2991bc3f84c62a;

// Namespace namespace_7e2991bc3f84c62a
// Params 1
// Checksum 0x1e1eb2f7, Offset: 0xd0
// Size: 0x36
function function_b53ccf032ed6922f( var_f38314a2d8982633 = 0 )
{
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_damaged", &function_1b82cad273030f2d, var_f38314a2d8982633 );
}

// Namespace namespace_7e2991bc3f84c62a
// Params 2
// Checksum 0x25e91d4a, Offset: 0x10e
// Size: 0x158
function function_1b82cad273030f2d( params, var_f38314a2d8982633 )
{
    if ( params.smeansofdeath == "MOD_CRUSH" && isdefined( params.einflictor ) && params.einflictor.classname == "script_vehicle" )
    {
        forward_vec = anglestoforward( self.angles );
        
        if ( vectordot( params.vpoint - self.origin, forward_vec ) < 0 )
        {
            return;
        }
        
        if ( isdefined( self.var_3ce955181c31f80e ) && !utility::time_has_passed( self.var_3ce955181c31f80e, 5 ) )
        {
            return;
        }
        
        if ( params.einflictor vehicle_getspeed() < 15 )
        {
            return;
        }
        
        if ( !self.var_9127bb5b7fee1e31 )
        {
            if ( !var_f38314a2d8982633 )
            {
                self forceteleport( self.origin, vectortoangles( params.einflictor.origin - self.origin ) );
            }
            
            self._blackboard.var_cab12c69b6d910e3 = params.einflictor.origin;
            self.var_9127bb5b7fee1e31 = 1;
            asm::function_7256f5ba459c840b( "vehicle_impact_pass_in" );
        }
        
        thread function_5829f7efaf8f810e();
    }
}

// Namespace namespace_7e2991bc3f84c62a
// Params 0
// Checksum 0x37530618, Offset: 0x26e
// Size: 0x7b
function function_5829f7efaf8f810e()
{
    self notify( #"handle_vehicle_impact_anim_singleton" );
    self endon( #"handle_vehicle_impact_anim_singleton" );
    
    while ( isalive( self ) )
    {
        utility::waittill_any_timeout( 0.1, "death" );
        
        if ( !isdefined( self.var_18f3fd4230326451 ) || utility::time_has_passed( self.var_18f3fd4230326451, 0.1 ) )
        {
            break;
        }
    }
    
    self.var_3ce955181c31f80e = gettime();
    
    if ( isdefined( self ) )
    {
        self.var_9127bb5b7fee1e31 = undefined;
    }
}

// Namespace namespace_7e2991bc3f84c62a
// Params 4
// Checksum 0xcd0a6b7a, Offset: 0x2f1
// Size: 0x31, Type: bool
function function_403e5386d57e417f( asmname, statename, tostatename, params )
{
    return istrue( self.var_9127bb5b7fee1e31 );
}

