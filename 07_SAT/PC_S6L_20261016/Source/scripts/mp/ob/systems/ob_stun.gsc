// scripts\mp\ob\systems\ob_stun.gsc  (hash_5fdf68c7957b0d13.gscc) (size: 5005 Bytes / 0x138d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf719299e (4145621406)
// size ...... 5005 (0x138d)
// includes .. 10  (offset: 0x12b9)
// strings ... 7   (offset: 0x1309)
// dev strs .. 3   (offset: 0x1369)
// exports ... 13  (offset: 0xc29)
// cseg ...... 0xb5 + 0xb74 (0xc29)
// imports ... 39  (offset: 0xe31)
// animtree1 . 0   (offset: 0x138d)
// animtree2 . 0   (offset: 0x138d)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\ai_utility;
#using scripts\common\callbacks;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\common\killstreaks\dawg_mp;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\shellshock_utility;

#namespace ob_stun;

// Namespace ob_stun
// Params 0, eflags: 0x1
// Checksum 0xa8664a8e, Offset: 0xd3
// Size: 0x3e
function autoexec main()
{
    utility::registersharedfunc( #"stun", #"hash_6f1d67fc9c0380fd", &function_adaba416dfc16839 );
    utility::registersharedfunc( #"stun", #"hash_349a1ff838f53f63", &function_c4c4f539eb76482f );
}

// Namespace ob_stun
// Params 2
// Checksum 0x19d00a91, Offset: 0x119
// Size: 0x25
function function_c4c4f539eb76482f( stundata, target )
{
    apply_stun( stundata, [ target ] );
}

// Namespace ob_stun
// Params 2
// Checksum 0x56a7f5e6, Offset: 0x146
// Size: 0x1f
function function_336faa60d5212254( stundata, potentialtargets )
{
    apply_stun( stundata, potentialtargets );
}

// Namespace ob_stun
// Params 1
// Checksum 0x3ca9eebd, Offset: 0x16d
// Size: 0x55
function function_f3eb76017907e72f( stundata )
{
    stunorigin = stundata.stunorigin ?? self.origin;
    potentialtargets = getplayersandaiarrayinradius( stunorigin, stundata.stunradius );
    apply_stun( stundata, potentialtargets, stunorigin );
}

// Namespace ob_stun
// Params 1
// Checksum 0xaddba737, Offset: 0x1ca
// Size: 0x2dc
function function_adaba416dfc16839( stundata )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    var_a4d3230c75ae013c = [];
    potentialplayertargets = [];
    
    if ( stundata.var_151ed9464ec398ca && stundata.var_595de568155e6bbf )
    {
        alltargets = utility::function_f754506ecfae9afb( self.origin, stundata.var_151ed9464ec398ca, undefined, stundata.var_595de568155e6bbf, 1 );
        
        foreach ( target in alltargets )
        {
            if ( !isplayer( target ) )
            {
                var_a4d3230c75ae013c[ var_a4d3230c75ae013c.size ] = target;
            }
        }
    }
    
    if ( stundata.var_2574d45002fd6e91 && stundata.var_3a79d2bad66cb960 )
    {
        alltargets = utility::function_f754506ecfae9afb( self.origin, stundata.var_2574d45002fd6e91, undefined, stundata.var_3a79d2bad66cb960, 1 );
        
        foreach ( target in alltargets )
        {
            if ( isplayer( target ) )
            {
                potentialplayertargets[ potentialplayertargets.size ] = target;
            }
        }
    }
    
    potentialtargets = arraycombine( var_a4d3230c75ae013c, potentialplayertargets );
    ignorelist = arraycopy( potentialtargets );
    ignorelist[ ignorelist.size ] = self;
    
    if ( stundata.knockbackenemies )
    {
        apply_knockback( stundata, potentialtargets );
    }
    
    if ( stundata.stunenemies )
    {
        if ( stundata.var_996156cbbcea8faa )
        {
            visibletargets = [];
            
            foreach ( ent in potentialtargets )
            {
                canseetarget = trace::ray_trace_passed( self geteye(), ent.origin, ignorelist );
                
                if ( ent != self && canseetarget )
                {
                    if ( !isdefined( visibletargets ) )
                    {
                        visibletargets = [];
                    }
                    
                    visibletargets[ visibletargets.size ] = ent;
                }
            }
            
            potentialtargets = visibletargets;
        }
        
        apply_stun( stundata, potentialtargets, self.origin );
    }
}

// Namespace ob_stun
// Params 0
// Checksum 0x7f42fd99, Offset: 0x4ae
// Size: 0x47
function cancel_stun()
{
    if ( !self.var_cc997278e6e6e01 )
    {
        return;
    }
    
    if ( self.type == "zombie" )
    {
        utility::callsharedfunc( #"zombie", #"clearstunzombie" );
    }
    
    self notify( #"cancel_stun" );
}

// Namespace ob_stun
// Params 3, eflags: 0x4
// Checksum 0xddd49c81, Offset: 0x4fd
// Size: 0x4dd
function private apply_stun( stundata, potentialtargets, stunorigin )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( !isdefined( potentialtargets ) )
    {
        return;
    }
    
    if ( !isdefined( stunorigin ) )
    {
        stunorigin = stundata.stunorigin ?? self.origin;
    }
    
    if ( !isdefined( level.stun_system_throttle ) )
    {
        level.stun_system_throttle = throttle::throttle_initialize( "stun_system_throttle", getdvarint( @"stun_system_throttle_limit", 1 ), level.framedurationseconds );
    }
    
    /#
        if ( stundata.debug )
        {
            debugseconds = 5;
            
            if ( stundata.var_151ed9464ec398ca )
            {
                level thread debug::drawsphere( stunorigin, stundata.var_151ed9464ec398ca, debugseconds, ( 1, 0, 0 ) );
                print3d( stunorigin, "<dev string:x24>", ( 1, 0, 0 ), 1, 1, int( debugseconds / level.framedurationseconds ) );
            }
            
            if ( stundata.var_2574d45002fd6e91 )
            {
                level thread debug::drawsphere( stunorigin, stundata.var_2574d45002fd6e91, debugseconds, ( 0, 0, 1 ) );
                print3d( stunorigin + ( 0, 0, 10 ), "<dev string:x27>", ( 0, 0, 1 ), 1, 1, int( debugseconds / level.framedurationseconds ) );
            }
        }
    #/
    
    sortedtargets = sortbydistance( potentialtargets, stunorigin );
    
    foreach ( ent in sortedtargets )
    {
        if ( !isalive( ent ) || ent.team == self.team || ent is_in_vehicle() )
        {
            continue;
        }
        
        source = stundata.source;
        assert( source, "<dev string:x2e>" );
        
        if ( !isdefined( ent.var_cc997278e6e6e01 ) )
        {
            ent.var_cc997278e6e6e01 = [];
        }
        
        ent.var_cc997278e6e6e01[ source ] = 1;
        stunduration = 0;
        
        if ( ent.type == "zombie" )
        {
            ent utility::callsharedfunc( #"zombie", #"stunZombie", stundata.aistunduration, "stunned_on" );
            stunduration = stundata.aistunduration;
        }
        else if ( ent.subclass == "dawg" || ent.dawg )
        {
            dawg = ent.dawg ?? ent;
            
            if ( "inactive" == dawg.mode )
            {
                continue;
            }
            
            hackeffect = { #hackduration:stundata.aistunduration * 1000, #var_bdd964bba0312052:1 };
            dawg dawg_mp::dawg_hack( hackeffect, self );
        }
        else if ( isagent( ent ) )
        {
            if ( isdefined( ent.callbacks[ #"stun" ] ) || isdefined( level.callbacks[ #"stun" ] ) )
            {
                ent callback::callback( #"stun", { #var_c27a2418f1d8f32d:stundata.var_c27a2418f1d8f32d, #duration:stundata.aistunduration } );
            }
            else
            {
                ent notify( #"flashbang", ent.origin, 1, undefined, self, self.team, stundata.aistunduration );
            }
            
            stunduration = stundata.aistunduration;
            
            if ( stundata.var_d77e705f0ccb6392 )
            {
                namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( stundata.var_d77e705f0ccb6392 );
            }
        }
        else if ( ent.classname == "player" )
        {
            shellshockname = stundata.var_b46f2cd1d2ce3065 ?? %"bomb_stun_mp";
            ent thread shellshock_utility_cpmp::_shellshock( shellshockname, #"stun", stundata.playersstunduration );
            stunduration = stundata.playersstunduration;
            
            if ( stundata.var_eed7703e78988f29 )
            {
                namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( stundata.var_eed7703e78988f29 );
            }
        }
        
        throttle::throttle_wait_in_queue( level.stun_system_throttle, self );
        ent thread function_d738299157923d28( stunduration, source );
    }
}

// Namespace ob_stun
// Params 0, eflags: 0x4
// Checksum 0x40c39b65, Offset: 0x9e2
// Size: 0x31
function private is_in_vehicle()
{
    if ( isplayer( self ) )
    {
        return vehicle::is_in_vehicle();
    }
    else if ( isagent( self ) )
    {
        return self._blackboard.invehicle;
    }
    
    return 0;
}

// Namespace ob_stun
// Params 2, eflags: 0x4
// Checksum 0x3b213268, Offset: 0xa1c
// Size: 0x5a
function private function_d738299157923d28( duration, source )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    utility::waittill_notify_or_timeout( "cancel_stun", duration );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( self.var_cc997278e6e6e01 )
    {
        self.var_cc997278e6e6e01[ source ] = undefined;
    }
}

// Namespace ob_stun
// Params 2, eflags: 0x4
// Checksum 0x3f1fe5b9, Offset: 0xa7e
// Size: 0x137
function private apply_knockback( stundata, potentialtargets )
{
    if ( !isdefined( potentialtargets ) )
    {
        return;
    }
    
    foreach ( ent in potentialtargets )
    {
        if ( !isalive( ent ) || ent.team == self.team )
        {
            continue;
        }
        
        if ( ent.type == "zombie" && ent function_4de5a741f5baa1c4( stundata.var_318512672428e90f ) )
        {
            ent utility::callsharedfunc( #"zombie", #"knockdownzombie", self.origin, stundata.var_b347a841e826d76b );
            continue;
        }
        
        if ( ent.classname == "player" )
        {
            ent knockback( get_knockback_dir( ent ), stundata.var_f01f8e2076f48d47 );
        }
    }
}

// Namespace ob_stun
// Params 1, eflags: 0x4
// Checksum 0x40008188, Offset: 0xbbd
// Size: 0x2b, Type: bool
function private function_4de5a741f5baa1c4( ai_max_tier )
{
    if ( isdefined( ai_max_tier ) )
    {
        tiernumber = ai_utility::get_power_tier();
        return ( ai_max_tier >= tiernumber );
    }
    
    return true;
}

// Namespace ob_stun
// Params 1, eflags: 0x4
// Checksum 0x9296a7f3, Offset: 0xbf1
// Size: 0x37
function private get_knockback_dir( ent )
{
    knockback_dir = ent.origin - self.origin;
    knockback_dir = vectornormalize( knockback_dir );
    return knockback_dir;
}

