// scripts\common\active_env\arcwire.gsc  (hash_40d4bdd43f3e378a.gscc) (size: 3734 Bytes / 0xe96 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa1371f8b (2704744331)
// size ...... 3734 (0xe96)
// includes .. 2   (offset: 0xd86)
// strings ... 14  (offset: 0xd96)
// dev strs .. 0   (offset: 0xe96)
// exports ... 7   (offset: 0xa62)
// cseg ...... 0x122 + 0x940 (0xa62)
// imports ... 16  (offset: 0xb7a)
// animtree1 . 0   (offset: 0xe96)
// animtree2 . 0   (offset: 0xe96)
#using scripts\common\scriptable;
#using scripts\common\utility;

#namespace arcwire;

// Namespace arcwire
// Params 0
// Checksum 0xfb7e71c2, Offset: 0x140
// Size: 0x29f
function init_arcwire()
{
    utility::flag_wait( "scriptables_ready" );
    scriptable::scriptable_addusedcallbackbypart( "arcwire_transmitter", &arcwire_transmitter_activate );
    scriptable::scriptable_addnotifycallback( "transmitter_damaged", &function_fb950ab48ffdecc9 );
    var_ce5ba7916c9dfde7 = getentitylessscriptablearray( "arcwire_transmitter", #script_noteworthy );
    
    foreach ( scr_transmitter in var_ce5ba7916c9dfde7 )
    {
        if ( scr_transmitter.script_parameters == "singleton" )
        {
            scr_transmitter.var_9524f5b5ce55caac = [];
            
            foreach ( other in var_ce5ba7916c9dfde7 )
            {
                if ( scr_transmitter == other )
                {
                    continue;
                }
                
                if ( scr_transmitter.target == other.target && isdefined( other.script_parameters ) && other.script_parameters == "singleton" )
                {
                    scr_transmitter.var_9524f5b5ce55caac[ scr_transmitter.var_9524f5b5ce55caac.size ] = other;
                }
            }
        }
    }
    
    var_5af9b7b7729fb2df = getentitylessscriptablearray( "arcwire_receiver", #script_noteworthy );
    
    foreach ( scr_receiver in var_5af9b7b7729fb2df )
    {
        if ( scr_receiver getscriptableparthasstate( "arcwire_receiver", "reset" ) )
        {
            scr_receiver.archetype = "toggle";
        }
        else if ( scr_receiver getscriptableparthasstate( "arcwire_receiver", "auto-reset" ) )
        {
            scr_receiver.archetype = "double-action";
        }
        else
        {
            scr_receiver.archetype = "do-once";
        }
        
        scr_receiver scriptable::scriptable_addnotifycallback( "standby", &standby_notify );
        scr_receiver thread arcwire_receiver_listen();
    }
}

// Namespace arcwire
// Params 6, eflags: 0x4
// Checksum 0x43aaa641, Offset: 0x3e7
// Size: 0x54
function private standby_notify( e_instance, str_part, str_state, e_player, b_auto_use, str_use_string )
{
    scr_receiver = e_instance;
    scr_receiver notify( #"standby" );
}

// Namespace arcwire
// Params 6, eflags: 0x4
// Checksum 0x27c1999e, Offset: 0x443
// Size: 0x18a
function private arcwire_transmitter_activate( e_instance, str_part, str_state, e_player, b_auto_use, str_use_string )
{
    scr_transmitter = e_instance;
    
    if ( !isdefined( scr_transmitter.target ) )
    {
        return;
    }
    
    var_5af9b7b7729fb2df = getentitylessscriptablearray( scr_transmitter.target, #targetname );
    
    foreach ( scr_receiver in var_5af9b7b7729fb2df )
    {
        scr_receiver notify( #"activate", scr_transmitter, e_player );
    }
    
    var_4dcdb89cbfda1a62 = getentarray( scr_transmitter.target, #targetname );
    
    foreach ( ent_receiver in var_4dcdb89cbfda1a62 )
    {
        ent_receiver notify( #"activate", scr_transmitter, e_player );
    }
}

// Namespace arcwire
// Params 4, eflags: 0x4
// Checksum 0x9cd71af2, Offset: 0x5d5
// Size: 0x178
function private function_fb950ab48ffdecc9( e_instance, var_fbe21110104b5926, var_acc7ae5f813fa77e, var_533710b0b76c405a )
{
    scr_transmitter = e_instance;
    
    if ( !isdefined( scr_transmitter.target ) )
    {
        return;
    }
    
    var_5af9b7b7729fb2df = getentitylessscriptablearray( scr_transmitter.target, #targetname );
    
    foreach ( scr_receiver in var_5af9b7b7729fb2df )
    {
        scr_receiver notify( #"activate", scr_transmitter, var_533710b0b76c405a );
    }
    
    var_4dcdb89cbfda1a62 = getentarray( scr_transmitter.target, #targetname );
    
    foreach ( ent_receiver in var_4dcdb89cbfda1a62 )
    {
        ent_receiver notify( #"activate", scr_transmitter, var_533710b0b76c405a );
    }
}

// Namespace arcwire
// Params 0, eflags: 0x4
// Checksum 0xdd300dc2, Offset: 0x755
// Size: 0x87
function private arcwire_receiver_listen()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"activate", scr_transmitter, e_user );
        
        if ( isdefined( self.func_is_blocked ) && self [[ self.func_is_blocked ]]() )
        {
            if ( scr_transmitter getscriptablepartstate( "arcwire_transmitter" ) != "blocked" )
            {
                scr_transmitter setscriptablepartstate( "arcwire_transmitter", "blocked" );
            }
            
            continue;
        }
        
        thread arcwire_receiver_activate( scr_transmitter );
    }
}

// Namespace arcwire
// Params 2, eflags: 0x4
// Checksum 0x780e38e0, Offset: 0x7e4
// Size: 0x27e
function private arcwire_receiver_activate( scr_transmitter, e_user )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    str_current_state = self getscriptablepartstate( "arcwire_receiver" );
    
    if ( isdefined( self.var_e516158d7664e8fc ) )
    {
        self thread [[ self.var_e516158d7664e8fc ]]( e_user );
    }
    
    if ( self.archetype == "toggle" )
    {
        str_new_state = str_current_state == "standby" || str_current_state == "reset" ? "set" : "reset";
    }
    else
    {
        str_new_state = "set";
    }
    
    if ( isdefined( scr_transmitter ) )
    {
        scr_transmitter setscriptablepartstate( "arcwire_transmitter", "activate" );
        
        if ( isdefined( scr_transmitter.var_9524f5b5ce55caac ) )
        {
            foreach ( scriptable in scr_transmitter.var_9524f5b5ce55caac )
            {
                scriptable setscriptablepartstate( "arcwire_transmitter", "activate" );
            }
        }
    }
    
    if ( isdefined( self.delay_min ) )
    {
        delay = self.delay_min;
        
        if ( isdefined( self.delay_max ) )
        {
            delay = randomfloatrange( self.delay_min, self.delay_max );
        }
        
        wait delay;
    }
    
    self setscriptablepartstate( "arcwire_receiver", str_new_state );
    self waittill( #"standby" );
    
    if ( self.archetype != "do-once" )
    {
        if ( isdefined( scr_transmitter ) )
        {
            if ( isdefined( scr_transmitter.var_b53261e80c263351 ) )
            {
                wait scr_transmitter.var_b53261e80c263351;
            }
            
            scr_transmitter setscriptablepartstate( "arcwire_transmitter", "standby" );
            
            if ( isdefined( scr_transmitter.var_9524f5b5ce55caac ) )
            {
                foreach ( scriptable in scr_transmitter.var_9524f5b5ce55caac )
                {
                    scriptable setscriptablepartstate( "arcwire_transmitter", "standby" );
                }
            }
        }
    }
}

