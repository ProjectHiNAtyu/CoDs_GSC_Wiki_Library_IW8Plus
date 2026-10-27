// scripts\mp\common\utility\trigger.gsc  (hash_208a12cbcccbfa63.gscc) (size: 6899 Bytes / 0x1af3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6cfa47ad (1828341677)
// size ...... 6899 (0x1af3)
// includes .. 4   (offset: 0x1a43)
// strings ... 11  (offset: 0x1a63)
// dev strs .. 1   (offset: 0x1ae7)
// exports ... 19  (offset: 0x1213)
// cseg ...... 0x19b + 0x1078 (0x1213)
// imports ... 42  (offset: 0x150b)
// animtree1 . 0   (offset: 0x1af3)
// animtree2 . 0   (offset: 0x1af3)
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\interaction;

#namespace trigger;

// Namespace trigger
// Params 0
// Checksum 0xe57d5010, Offset: 0x1b9
// Size: 0x40c
function triggerutilityinit()
{
    enterexittriggers = getentarray( "trigger_multiple_mp_enterexit", #classname );
    
    foreach ( trigger in enterexittriggers )
    {
        makeenterexittrigger( trigger );
    }
    
    var_f6a12f4c7e5f1498 = getentarray( "trigger_multiple_flag_set", #classname );
    
    foreach ( trigger in var_f6a12f4c7e5f1498 )
    {
        trigger function_c78a2fbdc2a6450d();
        trigger thread function_f6a12f4c7e5f1498( trigger.script_flag );
    }
    
    var_b9601b064ab62685 = getentarray( "trigger_multiple_flag_clear", #classname );
    
    foreach ( trigger in var_b9601b064ab62685 )
    {
        trigger function_c78a2fbdc2a6450d();
        trigger thread function_f6a12f4c7e5f1498( undefined, trigger.script_flag );
    }
    
    var_2a9b405988dccebe = getentarray( "trigger_multiple_flag_set_touching", #classname );
    
    foreach ( trigger in var_2a9b405988dccebe )
    {
        trigger function_c78a2fbdc2a6450d();
        trigger thread function_7d2bac578e9bd697();
    }
    
    var_5b4e2994c14c6750 = getnoentvolumearray( "noent_volume_trigger_flag_set", #classname );
    
    foreach ( trigger in var_5b4e2994c14c6750 )
    {
        trigger function_c78a2fbdc2a6450d();
        trigger thread function_f6a12f4c7e5f1498( trigger.script_flag );
    }
    
    var_bc490d258d591b0d = getnoentvolumearray( "noent_volume_trigger_flag_clear", #classname );
    
    foreach ( trigger in var_bc490d258d591b0d )
    {
        trigger function_c78a2fbdc2a6450d();
        trigger thread function_f6a12f4c7e5f1498( undefined, trigger.script_flag );
    }
    
    var_a4494990e39b18f4 = getnoentvolumearray( "noent_volume_trigger_flag_set_touching", #classname );
    
    foreach ( trigger in var_a4494990e39b18f4 )
    {
        trigger function_c78a2fbdc2a6450d();
        trigger thread function_7d2bac578e9bd697();
    }
}

// Namespace trigger
// Params 2, eflags: 0x4
// Checksum 0x87e36176, Offset: 0x5cd
// Size: 0xa6
function private function_f6a12f4c7e5f1498( set_flag, clear_flag )
{
    assert( isdefined( set_flag ) || isdefined( clear_flag ) || isdefined( self.script_flag_set ) || isdefined( self.script_ent_flag_set ) || isdefined( self.script_flag_clear ) || isdefined( self.script_ent_flag_clear ) );
    trigger = self;
    trigger endon( #"death_or_disconnect" );
    
    while ( true )
    {
        trigger waittill( #"trigger", other );
        thread function_acdddeb93afd5c20( trigger, set_flag, clear_flag, other );
    }
}

// Namespace trigger
// Params 4, eflags: 0x4
// Checksum 0xf7157392, Offset: 0x67b
// Size: 0xf1
function private function_acdddeb93afd5c20( trigger, set_flag, clear_flag, other )
{
    trigger utility::script_delay();
    
    if ( isdefined( set_flag ) && isdefined( other ) )
    {
        utility::flag_set( set_flag, other );
    }
    
    if ( isdefined( clear_flag ) )
    {
        utility::flag_clear( clear_flag );
    }
    
    if ( isdefined( trigger.script_flag_set ) && isdefined( other ) )
    {
        utility::flag_set( trigger.script_flag_set, other );
    }
    
    if ( isdefined( trigger.script_ent_flag_set ) && isdefined( other ) )
    {
        other utility::ent_flag_set( trigger.script_ent_flag_set );
    }
    
    if ( isdefined( trigger.script_flag_clear ) )
    {
        utility::flag_clear( trigger.script_flag_clear );
    }
    
    if ( isdefined( trigger.script_ent_flag_clear ) && isdefined( other ) )
    {
        other utility::ent_flag_clear( trigger.script_ent_flag_clear );
    }
}

// Namespace trigger
// Params 0, eflags: 0x4
// Checksum 0x114790d2, Offset: 0x774
// Size: 0x6b
function private function_7d2bac578e9bd697()
{
    self endon( #"death_or_disconnect" );
    
    if ( !isdefined( self.script_flag ) && !isdefined( self.script_ent_flag_set ) )
    {
        assertmsg( "<dev string:x24>" );
    }
    
    while ( true )
    {
        self waittill( #"trigger", other );
        function_af729507dfab30( other, self.script_flag );
    }
}

// Namespace trigger
// Params 2, eflags: 0x4
// Checksum 0x3897f689, Offset: 0x7e7
// Size: 0x7c
function private function_af729507dfab30( ent, flag )
{
    id = ent getentitynumber();
    
    if ( self.touching_array[ id ] != ent )
    {
        firsttouching = 0;
        
        if ( !isdefined( self.touching_array ) )
        {
            self.touching_array = [];
            firsttouching = 1;
        }
        
        self.touching_array[ id ] = ent;
        
        if ( firsttouching )
        {
            thread function_5bd1b2e2b259c345( flag );
        }
    }
}

// Namespace trigger
// Params 1, eflags: 0x4
// Checksum 0xba919fdb, Offset: 0x86b
// Size: 0x158
function private function_5bd1b2e2b259c345( flag )
{
    trigger = self;
    trigger utility::script_delay();
    
    while ( isdefined( trigger ) )
    {
        foreach ( key, ent in trigger.touching_array )
        {
            if ( !isalive( ent ) || !ent istouching( trigger ) )
            {
                trigger.touching_array[ key ] = undefined;
                
                if ( isdefined( trigger.script_ent_flag_set ) && isdefined( ent ) )
                {
                    ent utility::ent_flag_clear( trigger.script_ent_flag_set );
                }
                
                continue;
            }
            
            if ( isdefined( ent ) )
            {
                if ( isdefined( trigger.script_ent_flag_set ) )
                {
                    ent utility::ent_flag_set( trigger.script_ent_flag_set );
                }
            }
        }
        
        if ( trigger.touching_array.size == 0 )
        {
            trigger.touching_array = undefined;
            break;
        }
        
        if ( isdefined( flag ) )
        {
            utility::flag_set( flag );
        }
        
        wait 0.25;
    }
    
    if ( isdefined( flag ) )
    {
        utility::flag_clear( flag );
    }
}

// Namespace trigger
// Params 0, eflags: 0x4
// Checksum 0x309476a4, Offset: 0x9cb
// Size: 0x2e
function private function_c78a2fbdc2a6450d()
{
    if ( isdefined( self.script_flag_true ) )
    {
        level thread function_8e82df2d33d0f11b( self );
    }
    
    if ( isdefined( self.script_flag_false ) )
    {
        level thread function_74508e1e89cee826( self );
    }
}

// Namespace trigger
// Params 1, eflags: 0x4
// Checksum 0x656e7ccb, Offset: 0xa01
// Size: 0x3c
function private function_74508e1e89cee826( trigger )
{
    tokens = utility::create_flags_and_return_tokens( trigger.script_flag_false );
    trigger function_35d1d64ad0af8c75( tokens );
    trigger utility::update_trigger_based_on_flags();
}

// Namespace trigger
// Params 1, eflags: 0x4
// Checksum 0x9d7ff4cb, Offset: 0xa45
// Size: 0x3c
function private function_8e82df2d33d0f11b( trigger )
{
    tokens = utility::create_flags_and_return_tokens( trigger.script_flag_true );
    trigger function_35d1d64ad0af8c75( tokens );
    trigger utility::update_trigger_based_on_flags();
}

// Namespace trigger
// Params 1, eflags: 0x4
// Checksum 0xf540525a, Offset: 0xa89
// Size: 0x6e
function private function_35d1d64ad0af8c75( tokens )
{
    for ( i = 0; i < tokens.size ; i++ )
    {
        flag = tokens[ i ];
        
        if ( !isdefined( level.trigger_flags[ flag ] ) )
        {
            level.trigger_flags[ flag ] = [];
        }
        
        level.trigger_flags[ flag ][ level.trigger_flags[ flag ].size ] = self;
    }
}

// Namespace trigger
// Params 8
// Checksum 0x709b8975, Offset: 0xaff
// Size: 0x5d
function makeenterexittrigger( trigger, enterfunc, exitfunc, var_6f7dcdd5c355e916, var_bf88e70ecb0e80ca, filterfunc, payload, var_333384ff46564ab3 )
{
    trigger thread triggerenterthink( enterfunc, exitfunc, var_6f7dcdd5c355e916, var_bf88e70ecb0e80ca, filterfunc, payload, var_333384ff46564ab3 );
}

// Namespace trigger
// Params 7
// Checksum 0x4c4fcc15, Offset: 0xb64
// Size: 0x1b5
function triggerenterthink( enterfunc, exitfunc, var_6f7dcdd5c355e916, var_bf88e70ecb0e80ca, filterfunc, payload, var_333384ff46564ab3 = 0 )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"hash_73537c07898a047a" );
    self endon( #"hash_bf0ef46ecac5ff4a" );
    
    if ( !isdefined( self.triggerenterents ) )
    {
        self.triggerenterents = [];
    }
    
    if ( !isdefined( self.var_a06757bbd3e0917e ) )
    {
        self.var_a06757bbd3e0917e = [];
    }
    
    triggerenterents = [];
    triggerinsidetimes = [];
    thread triggerexitthink( exitfunc, var_bf88e70ecb0e80ca, payload, triggerenterents, triggerinsidetimes );
    
    while ( true )
    {
        self waittill( #"trigger", triggeringent );
        onentertrigger( triggeringent, triggerenterents, triggerinsidetimes, enterfunc, var_6f7dcdd5c355e916, filterfunc, payload );
        
        if ( var_333384ff46564ab3 && triggeringent vehicle::is_vehicle() )
        {
            var_e6705f650f2da26e = vehicle_occupancy::get_data( triggeringent vehicle::get_ref() );
            
            if ( var_e6705f650f2da26e )
            {
                occupants = vehicle_occupancy::get_all_occupants( triggeringent, 0 );
                
                foreach ( occupant in occupants )
                {
                    onentertrigger( occupant, triggerenterents, triggerinsidetimes, enterfunc, var_6f7dcdd5c355e916, filterfunc, payload );
                }
            }
        }
    }
}

// Namespace trigger
// Params 7
// Checksum 0x98c4817b, Offset: 0xd21
// Size: 0x121
function onentertrigger( triggeringent, triggerenterents, triggerinsidetimes, enterfunc, var_6f7dcdd5c355e916, filterfunc, payload )
{
    if ( isdefined( filterfunc ) )
    {
        if ( isdefined( payload ) )
        {
            if ( [[ filterfunc ]]( triggeringent, self, payload ) )
            {
                return;
            }
        }
        else if ( [[ filterfunc ]]( triggeringent, self ) )
        {
            return;
        }
    }
    
    var_b7c8a4ca6242065a = triggeringent getentitynumber();
    
    if ( !isdefined( triggerenterents[ var_b7c8a4ca6242065a ] ) )
    {
        self notify( #"hash_dc7414dbd8411b32", triggeringent );
        
        if ( isdefined( enterfunc ) )
        {
            if ( isdefined( payload ) )
            {
                triggeringent thread [[ enterfunc ]]( triggeringent, self, payload );
            }
            else
            {
                triggeringent thread [[ enterfunc ]]( triggeringent, self );
            }
        }
        
        if ( isdefined( var_6f7dcdd5c355e916 ) )
        {
            triggeringent notify( var_6f7dcdd5c355e916, self );
        }
        
        triggerenterents[ var_b7c8a4ca6242065a ] = triggeringent;
        triggerinsidetimes[ var_b7c8a4ca6242065a ] = gettime();
        
        if ( !isdefined( self.var_a06757bbd3e0917e[ var_b7c8a4ca6242065a ] ) )
        {
            self.triggerenterents[ var_b7c8a4ca6242065a ] = triggeringent;
            self.var_a06757bbd3e0917e[ var_b7c8a4ca6242065a ] = 0;
        }
        
        self.var_a06757bbd3e0917e[ var_b7c8a4ca6242065a ]++;
    }
    else
    {
        triggerinsidetimes[ var_b7c8a4ca6242065a ] = gettime();
    }
    
    assert( triggerenterents.size == triggerinsidetimes.size );
}

// Namespace trigger
// Params 5
// Checksum 0xa4f2331a, Offset: 0xe4a
// Size: 0x20f
function triggerexitthink( exitfunc, var_bf88e70ecb0e80ca, payload, triggerenterents, triggerinsidetimes )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"hash_73537c07898a047a" );
    
    while ( true )
    {
        waittillframeend();
        
        if ( triggerenterents.size == 0 )
        {
            if ( self.var_87a6308415df7e60 )
            {
                self notify( #"forceExitFuncsComplete" );
                break;
            }
            
            waitframe();
            continue;
        }
        
        assert( triggerenterents.size == triggerinsidetimes.size );
        var_db4ed034d94db8b0 = gettime();
        
        foreach ( entid, ent in triggerenterents )
        {
            if ( !isdefined( ent ) )
            {
                triggerenterents[ entid ] = undefined;
                triggerinsidetimes[ entid ] = undefined;
                self.var_a06757bbd3e0917e[ entid ]--;
                
                if ( self.var_a06757bbd3e0917e[ entid ] == 0 )
                {
                    self.triggerenterents[ entid ] = undefined;
                    self.var_a06757bbd3e0917e[ entid ] = undefined;
                }
                
                continue;
            }
            
            assert( isdefined( triggerinsidetimes[ entid ] ) );
            
            if ( triggerinsidetimes[ entid ] < var_db4ed034d94db8b0 || self.var_87a6308415df7e60 )
            {
                self notify( #"hash_4c6655a461df2ba4", ent );
                
                if ( isdefined( exitfunc ) )
                {
                    if ( isdefined( payload ) )
                    {
                        ent thread [[ exitfunc ]]( ent, self, payload );
                    }
                    else
                    {
                        ent thread [[ exitfunc ]]( ent, self );
                    }
                }
                
                if ( isdefined( var_bf88e70ecb0e80ca ) )
                {
                    ent notify( var_bf88e70ecb0e80ca, self );
                }
                
                triggerenterents[ entid ] = undefined;
                triggerinsidetimes[ entid ] = undefined;
                self.var_a06757bbd3e0917e[ entid ]--;
                
                if ( self.var_a06757bbd3e0917e[ entid ] == 0 )
                {
                    self.triggerenterents[ entid ] = undefined;
                    self.var_a06757bbd3e0917e[ entid ] = undefined;
                }
            }
        }
        
        if ( self.var_87a6308415df7e60 )
        {
            self notify( #"forceExitFuncsComplete" );
            break;
        }
        
        waitframe();
    }
}

// Namespace trigger
// Params 2
// Checksum 0x63f2300b, Offset: 0x1061
// Size: 0x8f
function cleanup_enter_exit_trigger( trigger, var_87a6308415df7e60 )
{
    level endon( #"game_ended" );
    trigger endon( #"death" );
    
    if ( var_87a6308415df7e60 )
    {
        trigger notify( #"hash_bf0ef46ecac5ff4a" );
        trigger.var_87a6308415df7e60 = var_87a6308415df7e60;
        trigger utility::waittill_notify_or_timeout( "forceExitFuncsComplete", 1 );
        trigger.var_87a6308415df7e60 = undefined;
    }
    
    trigger notify( #"hash_73537c07898a047a" );
    trigger.triggerenterents = undefined;
    trigger.var_a06757bbd3e0917e = undefined;
}

// Namespace trigger
// Params 0
// Checksum 0x200d5849, Offset: 0x10f8
// Size: 0xac
function init_gesture_triggers()
{
    utility::flag_wait( "StartGameTypeCallbackFinished" );
    waitframe();
    triggerarray = getentarray( "gesture_trigger", #script_noteworthy );
    
    if ( !isdefined( triggerarray ) )
    {
        return;
    }
    
    foreach ( gesture_trigger in triggerarray )
    {
        interaction::register_scriptable_interact( gesture_trigger, undefined, undefined, &function_e5dae724a3931388 );
    }
}

// Namespace trigger
// Params 1
// Checksum 0xc811143f, Offset: 0x11ac
// Size: 0x20
function use_gesture_trigger( var_b242caa3b76bfde5 )
{
    if ( !isdefined( var_b242caa3b76bfde5 ) )
    {
        return;
    }
    
    self giveandfireoffhand( makeweapon( var_b242caa3b76bfde5 ) );
}

// Namespace trigger
// Params 1
// Checksum 0x17a28296, Offset: 0x11d4
// Size: 0x3f
function function_e5dae724a3931388( player )
{
    grenadename = "";
    
    if ( isdefined( self.targetname ) )
    {
        grenadename = self.targetname;
    }
    
    player use_gesture_trigger( grenadename );
}

