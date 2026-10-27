// scripts\common\gas_shared.gsc  (hash_03f19c48da26ed31.gscc) (size: 38571 Bytes / 0x96ab / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe5be66d8 (3854460632)
// size ...... 38571 (0x96ab)
// includes .. 20  (offset: 0x919f)
// strings ... 58  (offset: 0x923f)
// dev strs .. 16  (offset: 0x95e7)
// exports ... 112 (offset: 0x631b)
// cseg ...... 0x510 + 0x5e0b (0x631b)
// imports ... 230 (offset: 0x749b)
// animtree1 . 0   (offset: 0x96ab)
// animtree2 . 0   (offset: 0x96ab)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\gas_common;
#using scripts\common\gasmask;
#using scripts\common\math;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\armor;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\ent_manager;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_item;
#using scripts\mp\operator;
#using scripts\mp\scripted_weapons;

#namespace gas_shared;

// Namespace gas_shared
// Params 0, eflags: 0x1
// Checksum 0xb27bdbb0, Offset: 0x52e
// Size: 0x11b
function autoexec init()
{
    level.var_543424c9692792ce = {};
    utility::registersharedfunc( #"gas", #"hash_220661f5c1a54532", &addcallback );
    utility::registersharedfunc( #"gas", #"hash_87b583f48f67914e", &gas_createtrigger );
    utility::registersharedfunc( #"gas", #"hash_43bf0d88a1c3c9b8", &function_bba6138e6a808cab );
    utility::registersharedfunc( #"gas", #"hash_72b9083857205f79", &function_5e51d190d7d16b43 );
    utility::registersharedfunc( #"gas", #"hash_b1acc2201b601807", &function_5d3eec27833372c4 );
    utility::registersharedfunc( #"gas", #"destroy_trigger", &gas_destroytrigger );
    callback::add( #"player_death", &onplayerdeath );
    callback::add( #"player_laststand_death", &function_7287ce7611d8022c );
    callback::add( #"player_laststand", &function_d8957f2712fd72c8 );
    callback::add( #"player_laststand_exit", &function_c614aaeb1d4d8bc6 );
    function_77f94a5d30254901();
}

// Namespace gas_shared
// Params 0, eflags: 0x4
// Checksum 0x106b37b6, Offset: 0x651
// Size: 0xbf
function private function_77f94a5d30254901()
{
    function_7ffa1259fee7dcf6( "coughing", &gas_startcoughing, &function_e1e5525d97c82236, &function_c8758239aeff157d );
    function_7ffa1259fee7dcf6( "blurred_vision", &gas_applyblur, &gas_removeblur, &function_c8758239aeff157d );
    function_7ffa1259fee7dcf6( "vision", &function_f1479e9c70fb245, &function_471b86d63c315c09, &function_7bd9ef1061ea87a6 );
    function_7ffa1259fee7dcf6( "speed_redux", &gas_applyspeedredux, &gas_removespeedredux, &function_c8758239aeff157d );
    function_7ffa1259fee7dcf6( "decoy_hallucination", &function_aea67a015f481d4d, &function_8b9b4730128ae629, &function_2b07fb15b1a54bf8 );
    function_7ffa1259fee7dcf6( "fake_gun_hallucination", &function_f8cf0ebb89c75fe8, &function_d86efee1a27dd624, &function_d3fa6a59f40c42ad );
    function_7ffa1259fee7dcf6( "fake_radar_pings_hallucination", &function_690694d33079c37c, &function_be56abfd2c49fff0, &function_e50acd40c2cebf13 );
}

// Namespace gas_shared
// Params 4
// Checksum 0x3fcfa614, Offset: 0x718
// Size: 0xb2
function function_7ffa1259fee7dcf6( key, var_a5c6ef4081fd661d, var_b95b40e89f830791, var_5dd462bbe94a110e )
{
    assert( !level.var_543424c9692792ce.gaseffects[ key ], "<dev string:x24>" + key );
    
    if ( !isdefined( level.var_543424c9692792ce.gaseffects ) )
    {
        level.var_543424c9692792ce.gaseffects = [];
    }
    
    level.var_543424c9692792ce.gaseffects[ key ] = { #condition:var_5dd462bbe94a110e, #stop:var_b95b40e89f830791, #start:var_a5c6ef4081fd661d };
}

// Namespace gas_shared
// Params 8
// Checksum 0x692ffc03, Offset: 0x7d2
// Size: 0x223
function function_5d3eec27833372c4( gastype, gasbundle, onentertrigger, onexittrigger, oncreatetrigger, ondestroytrigger, var_733c007748d94a07, var_644fdac5e6457e80 )
{
    assert( !level.var_543424c9692792ce.gassettings[ gastype ], "<dev string:x52>" + gastype );
    assert( gasbundle, "<dev string:x7d>" );
    
    if ( !isdefined( level.var_543424c9692792ce.gassettings ) )
    {
        level.var_543424c9692792ce.gassettings = [];
    }
    
    gassettings = { #bundle:isxhashasset( gasbundle ) ? getscriptbundle( gasbundle ) : gasbundle };
    level.var_543424c9692792ce.gassettings[ gastype ] = gassettings;
    
    if ( onentertrigger )
    {
        addcallback( gastype, #"enter_gas_trigger", onentertrigger );
    }
    
    if ( onexittrigger )
    {
        addcallback( gastype, #"exit_gas_trigger", onexittrigger );
    }
    
    if ( oncreatetrigger )
    {
        addcallback( gastype, #"gas_trigger_created", oncreatetrigger );
    }
    
    if ( ondestroytrigger )
    {
        addcallback( gastype, #"gas_trigger_destroyed", ondestroytrigger );
    }
    
    if ( var_733c007748d94a07 )
    {
        addcallback( gastype, #"gas_assist", var_733c007748d94a07 );
    }
    
    if ( var_644fdac5e6457e80 )
    {
        addcallback( gastype, #"gas_kill", var_644fdac5e6457e80 );
    }
    
    function_7ed3c1f1a333a742( gastype );
    function_54705b19d82c0427( gassettings.bundle );
    
    if ( gassettings.bundle.var_9297d79dfd44a0eb && isdefined( gassettings.bundle.gas_hallucination_settings.var_bd4adedaf25dae10 ) )
    {
        gassettings.tryspawndecoysthrottle = throttle::throttle_initialize( "gas_common_trySpawnDecoysThrottle_" + gastype, gassettings.bundle.gas_hallucination_settings.var_bd4adedaf25dae10 );
    }
    
    return { #createtrigger:&gas_createtrigger };
}

// Namespace gas_shared
// Params 3
// Checksum 0xb18cc245, Offset: 0x9fe
// Size: 0xe3
function addcallback( gastype, callbackhash, func )
{
    if ( !isdefined( level.var_543424c9692792ce.callbacks ) )
    {
        level.var_543424c9692792ce.callbacks = [];
    }
    
    if ( !isdefined( level.var_543424c9692792ce.callbacks[ gastype ] ) )
    {
        level.var_543424c9692792ce.callbacks[ gastype ] = [];
    }
    
    if ( !isdefined( level.var_543424c9692792ce.callbacks[ gastype ][ callbackhash ] ) )
    {
        level.var_543424c9692792ce.callbacks[ gastype ][ callbackhash ] = [];
    }
    
    level.var_543424c9692792ce.callbacks[ gastype ][ callbackhash ][ level.var_543424c9692792ce.callbacks[ gastype ][ callbackhash ].size ] = func;
}

// Namespace gas_shared
// Params 3
// Checksum 0xdf5e2119, Offset: 0xae9
// Size: 0x72
function removecallback( gastype, callbackhash, func )
{
    callbacks = level.var_543424c9692792ce.callbacks[ gastype ][ callbackhash ];
    
    if ( callbacks && arraycontains( callbacks, func ) )
    {
        level.var_543424c9692792ce.callbacks[ gastype ][ callbackhash ] = arrayremove( callbacks, func );
    }
}

// Namespace gas_shared
// Params 1, eflags: 0x4
// Checksum 0xb7ded564, Offset: 0xb63
// Size: 0x6c
function private function_7ed3c1f1a333a742( gastype )
{
    gasbundle = level.var_543424c9692792ce.gassettings[ gastype ].bundle;
    effectarr = function_7149f02ec28d37ef( gasbundle );
    level.var_543424c9692792ce.gassettings[ gastype ].effects = effectarr;
}

// Namespace gas_shared
// Params 1, eflags: 0x4
// Checksum 0x3e7c2b8, Offset: 0xbd7
// Size: 0x3d
function private function_7bb62c1ab5803da6( vfxname )
{
    level._effect[ vfxname ] = loadfxasset( vfxname );
    assert( level._effect[ vfxname ] != 0, "<dev string:xb9>" + vfxname );
}

// Namespace gas_shared
// Params 1, eflags: 0x4
// Checksum 0x6e87829a, Offset: 0xc1c
// Size: 0x167
function private function_54705b19d82c0427( gasbundle )
{
    if ( gasbundle.hasvfx )
    {
        foreach ( vfxentry in gasbundle.var_f7b54b29ec895bb5 )
        {
            function_7bb62c1ab5803da6( vfxentry.vfx );
        }
        
        foreach ( vfxentry in gasbundle.var_ede7470622bd7af9 )
        {
            function_7bb62c1ab5803da6( vfxentry.vfx );
        }
        
        if ( gasbundle.var_3e397d40801796fc && gasbundle.var_d689c400699104e8 )
        {
            function_7bb62c1ab5803da6( gasbundle.var_d689c400699104e8 );
        }
    }
    
    if ( gasbundle.ashvfx )
    {
        function_7bb62c1ab5803da6( gasbundle.ashvfx );
    }
}

// Namespace gas_shared
// Params 11
// Checksum 0xe41115e0, Offset: 0xd8b
// Size: 0x3f3
function gas_createtrigger( gastype, position, owner, team, duration, scale = 1, radius, height, offset = -74.25, triggerinfo, params )
{
    if ( !position )
    {
        return;
    }
    
    if ( !function_8804575c4f9bba15( gastype ) )
    {
        return;
    }
    
    gasbundle = level.var_543424c9692792ce.gassettings[ gastype ].bundle;
    
    if ( !isdefined( radius ) )
    {
        radius = gasbundle.radius ?? 256;
    }
    
    if ( !isdefined( height ) )
    {
        height = gasbundle.height ?? 225;
    }
    
    if ( !isdefined( duration ) )
    {
        duration = gasbundle.duration ?? 6.5;
    }
    
    radius = int( radius * scale );
    height = int( height * scale );
    offset = int( offset * scale );
    trigger = spawn( "trigger_radius", position + ( 0, 0, offset ), 0, radius, height );
    trigger ent_manager::registerspawn( 1, &sweepgas );
    trigger.gastype = gastype;
    badplace = createnavbadplacebybounds( position + ( 0, 0, offset ), ( radius, radius, height ), ( 0, 0, 0 ) );
    trigger.height = height;
    trigger.radius = radius;
    trigger.duration = duration;
    trigger endon( #"death" );
    trigger.owner = owner;
    trigger.team = team;
    trigger.playersintrigger = [];
    trigger.var_a8d0289a93e5a155 = [];
    trigger.badplace = badplace;
    trigger.impactlocation = triggerinfo.impact_location;
    trigger.weaponobj = triggerinfo.weaponobj;
    
    if ( owner )
    {
        if ( !isdefined( owner.gas_grenade_array ) )
        {
            owner.gas_grenade_array = [];
        }
        
        owner.gas_grenade_array[ owner.gas_grenade_array.size ] = trigger;
    }
    
    trigger.effects = function_7149f02ec28d37ef( gasbundle );
    trigger thread gas_watchtriggerenter();
    trigger thread gas_watchtriggerexit();
    
    /#
        thread drawdebugtrigger( trigger );
    #/
    
    trigger thread gas_destroytriggerdelayed( duration, "gas_cleared" );
    
    if ( !isdefined( level.var_9f723c1b2e8c3484 ) )
    {
        level.var_9f723c1b2e8c3484 = [];
    }
    
    level.var_9f723c1b2e8c3484[ level.var_9f723c1b2e8c3484.size ] = trigger;
    
    if ( gasbundle.var_cd425e7ce91ca69a )
    {
        trigger thread function_cf2564bde6b65120();
    }
    
    if ( gasbundle.var_e4a1e3b4e7b84f97 )
    {
        trigger thread function_ce601d6f64265108( position );
    }
    
    if ( gasbundle.hasvfx )
    {
        if ( !isdefined( trigger.var_67323b79f803c91b ) )
        {
            trigger.var_67323b79f803c91b = params.var_67323b79f803c91b;
        }
        
        trigger thread gas_spawnvfx( gasbundle );
    }
    
    if ( level.var_543424c9692792ce.callbacks[ gastype ][ #"gas_trigger_created" ] )
    {
        foreach ( func in level.var_543424c9692792ce.callbacks[ gastype ][ #"gas_trigger_created" ] )
        {
            [[ func ]]( trigger );
        }
    }
    
    return trigger;
}

// Namespace gas_shared
// Params 0, eflags: 0x4
// Checksum 0x5c334b04, Offset: 0x1187
// Size: 0x24b
function private gas_destroytrigger()
{
    gastype = self.gastype;
    
    if ( !function_8804575c4f9bba15( gastype ) )
    {
        return;
    }
    
    gasbundle = level.var_543424c9692792ce.gassettings[ gastype ].bundle;
    
    foreach ( player in self.playersintrigger )
    {
        if ( !player )
        {
            continue;
        }
        
        self.playersintrigger[ player getentitynumber() ] = undefined;
        player gas_onexittrigger( self );
    }
    
    if ( level.var_543424c9692792ce.callbacks[ gastype ][ #"gas_trigger_destroyed" ] )
    {
        foreach ( func in level.var_543424c9692792ce.callbacks[ gastype ][ #"gas_trigger_destroyed" ] )
        {
            [[ func ]]( self );
        }
    }
    
    ent_manager::deregisterspawn();
    
    if ( self.badplace )
    {
        destroynavobstacle( self.badplace );
    }
    
    function_2ec0742b370570ec();
    function_f868e26483893e95( gasbundle );
    
    if ( self )
    {
        if ( isdefined( self.owner ) && self.owner.gas_grenade_array )
        {
            self.owner.gas_grenade_array = arrayremove( self.owner.gas_grenade_array, self );
        }
        
        self delete();
    }
    
    if ( level.var_9f723c1b2e8c3484 && isarray( level.var_9f723c1b2e8c3484 ) )
    {
        level.var_9f723c1b2e8c3484 = function_5713d46873b29625( level.var_9f723c1b2e8c3484 );
    }
}

// Namespace gas_shared
// Params 0, eflags: 0x4
// Checksum 0x695ce83c, Offset: 0x13da
// Size: 0x137
function private function_2ec0742b370570ec()
{
    if ( self.vfx.nodes )
    {
        foreach ( node in self.vfx.nodes )
        {
            node.var_9bbd31826cee69c8 = 1;
        }
    }
    
    if ( self.vfx.var_8e75e58d217a7d4e )
    {
        foreach ( vfx in self.vfx.var_8e75e58d217a7d4e )
        {
            function_10392a0d3005a35c( vfx, 1 );
        }
    }
}

// Namespace gas_shared
// Params 1, eflags: 0x4
// Checksum 0xd8a1caf, Offset: 0x1519
// Size: 0x3e
function private function_f868e26483893e95( gasbundle )
{
    if ( gasbundle.hasvfx && gasbundle.var_ede7470622bd7af9.size > 0 )
    {
        function_9b8b630de0c1b751( gasbundle.var_ede7470622bd7af9 );
    }
}

// Namespace gas_shared
// Params 2, eflags: 0x4
// Checksum 0x29d2136c, Offset: 0x155f
// Size: 0x5b
function private gas_destroytriggerdelayed( delaytime, var_7bf155b448f3de04 )
{
    self endon( #"death" );
    
    if ( self.owner )
    {
        self.owner utility::waittill_notify_or_timeout( "disconnect", delaytime );
    }
    else
    {
        wait delaytime;
    }
    
    if ( var_7bf155b448f3de04 )
    {
        self notify( var_7bf155b448f3de04 );
    }
    
    thread gas_destroytrigger();
}

// Namespace gas_shared
// Params 0, eflags: 0x4
// Checksum 0xf504ba8e, Offset: 0x15c2
// Size: 0x9
function private sweepgas()
{
    thread gas_destroytrigger();
}

// Namespace gas_shared
// Params 0, eflags: 0x4
// Checksum 0x5a5b3651, Offset: 0x15d3
// Size: 0x10a
function private gas_watchtriggerenter()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger", entity );
        
        if ( !entity )
        {
            continue;
        }
        
        if ( isplayer( entity ) || isagent( entity ) )
        {
            if ( !function_8de1f4bd0dc11222( entity ) )
            {
                function_46b9f83bbf1c0ab3( entity );
            }
            
            continue;
        }
        
        if ( entity vehicle::is_vehicle() )
        {
            players = vehicle_occupancy::get_all_occupants( entity );
            
            foreach ( player in players )
            {
                if ( !player istouching( self ) || function_8de1f4bd0dc11222( player ) )
                {
                    continue;
                }
                
                function_46b9f83bbf1c0ab3( player );
            }
        }
    }
}

// Namespace gas_shared
// Params 1, eflags: 0x4
// Checksum 0x50080d51, Offset: 0x16e5
// Size: 0x120
function private function_46b9f83bbf1c0ab3( player )
{
    if ( !player )
    {
        return;
    }
    
    if ( self.playersintrigger[ player getentitynumber() ] )
    {
        return;
    }
    
    if ( level.teambased && player != self.owner && player_utility::isfriendly( self.team, player ) )
    {
        return;
    }
    
    if ( isplayer( player ) )
    {
        self.playersintrigger[ player getentitynumber() ] = player;
        player thread gas_onentertrigger( self );
        return;
    }
    
    if ( isagent( player ) && ( !arraycontains( self.var_a8d0289a93e5a155, player ) || player.flashendtime < gettime() ) )
    {
        self.var_a8d0289a93e5a155[ self.var_a8d0289a93e5a155.size ] = player;
        var_db64af969d554147 = !function_3952ad77f15ea883( player );
        
        if ( player.radimmune || var_db64af969d554147 )
        {
            return;
        }
        
        player notify( #"flashbang", player.origin, 1, 1, self.owner, "axis", 9 );
    }
}

// Namespace gas_shared
// Params 1
// Checksum 0xc74680eb, Offset: 0x180d
// Size: 0x70
function function_3952ad77f15ea883( agent )
{
    aibundle = getaitypescriptbundle( agent.classname );
    
    if ( aibundle.aitypesettingsbundle )
    {
        aitypebundle = getscriptbundle( getxhashasset( "ai_type_settings:" + aibundle.aitypesettingsbundle ) );
        return ( aitypebundle && aitypebundle.var_85390472889f7b52 != "False" );
    }
}

// Namespace gas_shared
// Params 0, eflags: 0x4
// Checksum 0x6728b25, Offset: 0x1885
// Size: 0x11a
function private gas_watchtriggerexit()
{
    self endon( #"death" );
    
    if ( !function_8804575c4f9bba15( self.gastype ) )
    {
        return;
    }
    
    typedata = level.var_543424c9692792ce.gassettings[ self.gastype ];
    
    while ( true )
    {
        foreach ( id, player in self.playersintrigger )
        {
            if ( !player )
            {
                self.playersintrigger[ id ] = undefined;
                continue;
            }
            
            if ( !player isreallyalive() )
            {
                continue;
            }
            
            if ( player istouching( self ) && !function_8de1f4bd0dc11222( player ) )
            {
                continue;
            }
            
            self.playersintrigger[ player getentitynumber() ] = undefined;
            player gas_onexittrigger( self );
        }
        
        waitframe();
    }
}

// Namespace gas_shared
// Params 0, eflags: 0xc
// Checksum 0xa4963048, Offset: 0x19a7
// Size: 0x121
function private function_9b94a623facf2238()
{
    self notify( #"hash_af6df2af7bbf3425" );
    self endon( #"hash_af6df2af7bbf3425" );
    self endon( #"death_or_disconnect" );
    var_3908df94b9e59d59 = function_a40ecb649536fb15();
    
    while ( self.gastriggerstouching && self.gastriggerstouching.size > 0 )
    {
        var_73c2867d081f5280 = function_a40ecb649536fb15();
        updaterequired = 0;
        
        foreach ( triggerid, neweffects in var_73c2867d081f5280 )
        {
            currenteffects = var_3908df94b9e59d59[ triggerid ] ?? [];
            diff = arraydifference( currenteffects, neweffects );
            
            if ( diff.size > 0 )
            {
                updaterequired = 1;
                break;
            }
        }
        
        if ( updaterequired )
        {
            thread function_a69c34d26ff631da();
        }
        
        var_3908df94b9e59d59 = var_73c2867d081f5280;
        wait 0.1;
    }
}

// Namespace gas_shared
// Params 0, eflags: 0x4
// Checksum 0xc875c9d9, Offset: 0x1ad0
// Size: 0xb8
function private function_a40ecb649536fb15()
{
    var_73c2867d081f5280 = [];
    
    foreach ( trigger in self.gastriggerstouching )
    {
        if ( trigger.gastype )
        {
            triggerid = trigger getentitynumber();
            var_73c2867d081f5280[ triggerid ] = function_bd56cac6abcc92d4( [ trigger.gastype ] );
        }
    }
    
    return var_73c2867d081f5280;
}

// Namespace gas_shared
// Params 1, eflags: 0x4
// Checksum 0xaa0b9093, Offset: 0x1b91
// Size: 0x170
function private gas_onentertrigger( trigger )
{
    gastype = trigger.gastype;
    
    if ( !function_8804575c4f9bba15( gastype ) )
    {
        return;
    }
    
    typedata = level.var_543424c9692792ce.gassettings[ gastype ];
    
    if ( !isdefined( self.gastriggerstouching ) )
    {
        self.gastriggerstouching = [];
    }
    
    entnum = trigger getentitynumber();
    
    if ( self.gastriggerstouching[ entnum ] )
    {
        return;
    }
    
    self.gastriggerstouching[ entnum ] = trigger;
    
    if ( self.gastriggerstouching.size >= 1 )
    {
        thread function_a69c34d26ff631da();
        thread function_9b94a623facf2238();
    }
    
    if ( level.var_543424c9692792ce.callbacks[ gastype ][ #"enter_gas_trigger" ] )
    {
        foreach ( func in level.var_543424c9692792ce.callbacks[ gastype ][ #"enter_gas_trigger" ] )
        {
            [[ func ]]( trigger );
        }
    }
    
    self notify( #"hash_9292d26860c37712", trigger );
    return entnum;
}

// Namespace gas_shared
// Params 1, eflags: 0x4
// Checksum 0xca60e52, Offset: 0x1d0a
// Size: 0x18f
function private gas_onexittrigger( trigger )
{
    gastype = trigger.gastype;
    
    if ( !function_8804575c4f9bba15( gastype ) )
    {
        return;
    }
    
    triggerid = trigger getentitynumber();
    assert( isdefined( triggerid ), "<dev string:xd3>" );
    
    if ( trigger.var_c09e8e5e1a57097a )
    {
        playerid = self getentitynumber();
        assert( isdefined( playerid ), "<dev string:x108>" );
        trigger.playersintrigger[ playerid ] = undefined;
    }
    
    if ( !self.gastriggerstouching || !self.gastriggerstouching[ triggerid ] )
    {
        return;
    }
    
    self.gastriggerstouching[ triggerid ] = undefined;
    self.lastgastouchtime = gettime();
    thread function_a69c34d26ff631da();
    self notify( "gas_exited_" + triggerid );
    self notify( #"gas_clear_cough" );
    
    if ( level.var_543424c9692792ce.callbacks[ gastype ][ #"exit_gas_trigger" ] )
    {
        foreach ( func in level.var_543424c9692792ce.callbacks[ gastype ][ #"exit_gas_trigger" ] )
        {
            [[ func ]]( trigger );
        }
    }
}

// Namespace gas_shared
// Params 1, eflags: 0x4
// Checksum 0x7f80d7db, Offset: 0x1ea1
// Size: 0x192
function private function_bd56cac6abcc92d4( uniquetypes )
{
    var_a1f868a83636fb93 = [];
    
    foreach ( gastype in uniquetypes )
    {
        gassettings = level.var_543424c9692792ce.gassettings[ gastype ];
        gasbundle = gassettings.bundle;
        var_e1ac71d946f149dc = isdefined( gasbundle.var_e3a69ec65090b6c7 ) && !gasbundle.var_e3a69ec65090b6c7 && isinlaststand();
        
        if ( function_c12cbea90e8fad9( gastype ) || var_e1ac71d946f149dc )
        {
            continue;
        }
        
        gaseffects = gassettings.effects;
        
        foreach ( effect in gaseffects )
        {
            if ( !var_a1f868a83636fb93[ effect ] && function_2f66a7fbae6711a1( gastype, effect ) )
            {
                var_a1f868a83636fb93[ effect ] = gastype;
            }
        }
    }
    
    return var_a1f868a83636fb93;
}

// Namespace gas_shared
// Params 0
// Checksum 0xb0928632, Offset: 0x203c
// Size: 0x333
function function_a69c34d26ff631da()
{
    self notify( #"hash_62ff6022836ce130" );
    self endon( #"hash_62ff6022836ce130" );
    uniquetypes = [];
    typetriggers = [];
    
    foreach ( trigger in self.gastriggerstouching )
    {
        if ( !trigger.gastype )
        {
            continue;
        }
        
        if ( !isdefined( typetriggers[ trigger.gastype ] ) )
        {
            typetriggers[ trigger.gastype ] = [];
        }
        
        typetriggers[ trigger.gastype ][ typetriggers[ trigger.gastype ].size ] = trigger;
        
        if ( !arraycontains( uniquetypes, trigger.gastype ) )
        {
            uniquetypes[ uniquetypes.size ] = trigger.gastype;
        }
    }
    
    finalvals = function_bd56cac6abcc92d4( uniquetypes );
    
    if ( !isdefined( self.var_699daefc42231499 ) )
    {
        self.var_699daefc42231499 = [];
    }
    
    foreach ( effect, data in level.var_543424c9692792ce.gaseffects )
    {
        var_edb5a60063202de7 = isdefined( finalvals[ effect ] );
        var_183d94f2fbc508c6 = isdefined( self.var_699daefc42231499[ effect ] );
        var_9648ae302774790c = finalvals[ effect ] && self.var_699daefc42231499[ effect ] && finalvals[ effect ] != self.var_699daefc42231499[ effect ];
        
        if ( var_edb5a60063202de7 != var_183d94f2fbc508c6 || var_9648ae302774790c )
        {
            params = { #effect:effect };
            
            if ( !var_edb5a60063202de7 || var_9648ae302774790c )
            {
                params.gastype = self.var_699daefc42231499[ effect ];
                function_1e7279544138cffa( params );
            }
            
            if ( var_edb5a60063202de7 )
            {
                params.gastype = finalvals[ effect ];
                params.trigger = typetriggers[ finalvals[ effect ] ][ 0 ];
                
                foreach ( trigger in self.gastriggerstouching )
                {
                    if ( trigger.var_5aa2dbecb4d59fa1 && trigger.gastype == finalvals[ effect ] )
                    {
                        params.attacker = trigger.owner;
                        break;
                    }
                }
                
                thread function_8734a491fd64a9d( params );
            }
        }
    }
}

// Namespace gas_shared
// Params 1, eflags: 0x4
// Checksum 0xc0af4d67, Offset: 0x2377
// Size: 0x7a
function private function_8734a491fd64a9d( params )
{
    effect = params.effect;
    data = level.var_543424c9692792ce.gaseffects[ effect ];
    self.var_699daefc42231499[ effect ] = params.gastype;
    
    if ( data.start )
    {
        self [[ data.start ]]( params );
    }
}

// Namespace gas_shared
// Params 1, eflags: 0x4
// Checksum 0x562dd0d, Offset: 0x23f9
// Size: 0x6e
function private function_1e7279544138cffa( params )
{
    effect = params.effect;
    data = level.var_543424c9692792ce.gaseffects[ effect ];
    
    if ( data.stop )
    {
        self [[ data.stop ]]( params );
    }
    
    self.var_699daefc42231499[ effect ] = undefined;
}

// Namespace gas_shared
// Params 2, eflags: 0x4
// Checksum 0xc9173ce1, Offset: 0x246f
// Size: 0x48
function private function_2f66a7fbae6711a1( gastype, effect )
{
    data = level.var_543424c9692792ce.gaseffects[ effect ];
    return self [[ data.condition ]]( gastype, effect );
}

// Namespace gas_shared
// Params 0
// Checksum 0x433ac299, Offset: 0x24c0
// Size: 0xbc
function function_7a2b30d9581bbdcf()
{
    self notify( #"hash_1d2ed4b053e278f8" );
    self endon( #"hash_1d2ed4b053e278f8" );
    self.var_fbd9557189406237 = undefined;
    
    if ( self.gastriggerstouching )
    {
        foreach ( trigger in self.gastriggerstouching )
        {
            if ( !trigger )
            {
                continue;
            }
            
            gas_onexittrigger( trigger );
        }
    }
    
    self.gastriggerstouching = undefined;
}

// Namespace gas_shared
// Params 1
// Checksum 0x963c6cbb, Offset: 0x2584
// Size: 0xe6
function function_7149f02ec28d37ef( gasbundle )
{
    effectarr = [];
    
    if ( gasbundle.var_879cd7c9b363ea4c )
    {
        effectarr[ effectarr.size ] = "coughing";
    }
    
    if ( gasbundle.var_28d1cb2c8222acb2 )
    {
        effectarr[ effectarr.size ] = "blurred_vision";
    }
    
    if ( gasbundle.var_e4b60549095a7588 )
    {
        effectarr[ effectarr.size ] = "vision";
    }
    
    if ( gasbundle.var_50a45bc1ecaa3e18 )
    {
        effectarr[ effectarr.size ] = "speed_redux";
    }
    
    if ( gasbundle.var_d5662f10fb8ebbd4 )
    {
        if ( gasbundle.var_9297d79dfd44a0eb )
        {
            effectarr[ effectarr.size ] = "decoy_hallucination";
        }
        
        if ( gasbundle.var_a1daa5c5b9781c83 )
        {
            effectarr[ effectarr.size ] = "fake_radar_pings_hallucination";
        }
    }
    
    if ( gasbundle.var_dd3edc26dee549d5 )
    {
        if ( gasbundle.var_fbd2cb2b48b397b4 )
        {
            effectarr[ effectarr.size ] = "fake_gun_hallucination";
        }
    }
    
    return effectarr;
}

// Namespace gas_shared
// Params 0, eflags: 0xc
// Checksum 0xe9bd405, Offset: 0x2673
// Size: 0x2b8
function private function_cf2564bde6b65120()
{
    self notify( #"hash_7662b263acc92bc0" );
    self endon( #"hash_7662b263acc92bc0" );
    level endon( #"game_ended" );
    self endon( #"death" );
    gastype = self.gastype;
    
    if ( !function_8804575c4f9bba15( gastype ) )
    {
        return;
    }
    
    typedata = level.var_543424c9692792ce.gassettings[ gastype ];
    gasbundle = typedata.bundle;
    var_b43028fdb746779d = gasbundle.var_1e47b7b8da86afe;
    gasdamage = gasbundle.var_dff4a5226bca9144;
    var_c0db39d69d09fc9f = gasbundle.playerdamageperiod;
    spawnprotectionduration = ( gasbundle.var_e9fcacfe751a08d6 ?? 0 ) * 1000;
    var_e3a69ec65090b6c7 = gasbundle.var_e3a69ec65090b6c7;
    
    while ( true )
    {
        currenttime = gettime();
        
        foreach ( player in self.playersintrigger )
        {
            if ( !player || !player.origin )
            {
                continue;
            }
            
            if ( !player isreallyalive() )
            {
                continue;
            }
            
            if ( currenttime - player.lastspawntime < spawnprotectionduration )
            {
                continue;
            }
            
            if ( player function_c12cbea90e8fad9( self.gastype ) )
            {
                continue;
            }
            
            if ( !var_e3a69ec65090b6c7 && player isinlaststand() )
            {
                continue;
            }
            
            if ( player function_f6b90ef26d1a0d71( self.gastype ) )
            {
                continue;
            }
            
            finalmod = 1;
            finalmod += player.var_a5ac861674d151de ?? 0;
            var_ec046358d0fa17ae = gasdamage * finalmod;
            
            if ( self.owner )
            {
                player dodamage( var_ec046358d0fa17ae, player.origin, self.owner, self, "MOD_GRENADE", self.weapon );
                continue;
            }
            
            if ( var_b43028fdb746779d )
            {
                player dodamage( var_ec046358d0fa17ae, player.origin, player, self, "MOD_TRIGGER_HURT", "danger_circle_br" );
                player armor::damagearmor( var_ec046358d0fa17ae );
                continue;
            }
            
            player dodamage( var_ec046358d0fa17ae, player.origin, player, self, "MOD_TRIGGER_HURT" );
        }
        
        wait var_c0db39d69d09fc9f;
    }
}

// Namespace gas_shared
// Params 1, eflags: 0x4
// Checksum 0xe22c73a7, Offset: 0x2933
// Size: 0x8c
function private gas_spawnvfx( gasbundle )
{
    self.vfx = spawnstruct();
    
    if ( !gasbundle.hasvfx )
    {
        return;
    }
    
    if ( gasbundle.var_f7b54b29ec895bb5.size > 0 )
    {
        if ( !isdefined( self.vfx.var_8e75e58d217a7d4e ) )
        {
            self.vfx.var_8e75e58d217a7d4e = function_9b8b630de0c1b751( gasbundle.var_f7b54b29ec895bb5 );
        }
    }
    
    if ( gasbundle.var_3e397d40801796fc )
    {
        function_a9def26977d4457b( gasbundle );
    }
}

// Namespace gas_shared
// Params 1, eflags: 0x4
// Checksum 0x948b8279, Offset: 0x29c7
// Size: 0xd7
function private function_9b8b630de0c1b751( vfxlist )
{
    vfxs = [];
    spawnpos = self.var_67323b79f803c91b ?? utility::drop_to_ground( self.origin );
    
    foreach ( vfxentry in vfxlist )
    {
        fx = playfxanydistance( utility::getfx( vfxentry.vfx ), spawnpos, undefined, undefined, undefined, 0, 1, 1 );
        vfxs[ vfxs.size ] = fx;
    }
    
    return vfxs;
}

// Namespace gas_shared
// Params 1, eflags: 0x4
// Checksum 0x8a8e6a45, Offset: 0x2aa7
// Size: 0xb5
function private function_a9def26977d4457b( gasbundle )
{
    assert( gasbundle.var_d689c400699104e8 );
    assert( gasbundle.var_8f80aab43e67a378 );
    assert( gasbundle.var_a7ecb5cb195d9ccd );
    ringnodes = function_13c0d21d7d023982( self.origin, self.radius, gasbundle.var_de74eb9c164dcf60, gasbundle.var_a7ecb5cb195d9ccd );
    level thread function_1f07f3ff200c9f41( ringnodes, gasbundle.var_d689c400699104e8, gasbundle.var_8f80aab43e67a378 );
    self.vfx.nodes = ringnodes;
}

// Namespace gas_shared
// Params 4, eflags: 0x4
// Checksum 0x2bf690a6, Offset: 0x2b64
// Size: 0x1a7
function private function_13c0d21d7d023982( origin, maxradius, var_879b577a5277fd1a, var_a7ecb5cb195d9ccd )
{
    radius = maxradius * var_879b577a5277fd1a;
    circleperimeter = 6.28318 * radius;
    nodescount = int( floor( circleperimeter / var_a7ecb5cb195d9ccd ) );
    ringpoints = math::function_2f40252ef1a28501( origin, radius, nodescount );
    refresh_steps = 3;
    nodegroups = [];
    
    foreach ( idx, point in ringpoints )
    {
        node = function_8d04e99c83ad0066( point );
        var_5ec38e2163b1b527 = idx % refresh_steps;
        
        if ( !isdefined( nodegroups[ var_5ec38e2163b1b527 ] ) )
        {
            nodegroups[ var_5ec38e2163b1b527 ] = [];
        }
        
        nodegroups[ var_5ec38e2163b1b527 ][ nodegroups[ var_5ec38e2163b1b527 ].size ] = node;
    }
    
    sortedarray = [];
    
    foreach ( array in nodegroups )
    {
        sortedarray = arraycombine( sortedarray, array );
    }
    
    return sortedarray;
}

// Namespace gas_shared
// Params 1, eflags: 0x4
// Checksum 0xfb370c0d, Offset: 0x2d14
// Size: 0x4e
function private function_8d04e99c83ad0066( origin )
{
    spawnpos = utility::drop_to_ground( origin );
    node = { #angles:( 0, 0, 0 ), #origin:spawnpos };
    return node;
}

// Namespace gas_shared
// Params 3, eflags: 0x4
// Checksum 0xced52eeb, Offset: 0x2d6b
// Size: 0x13b
function private function_1f07f3ff200c9f41( nodearray, vfxname, vfxduration )
{
    level endon( #"game_ended" );
    throttlewait = vfxduration / nodearray.size;
    
    while ( nodearray.size > 0 )
    {
        toremove = [];
        
        foreach ( node in nodearray )
        {
            if ( node.var_9bbd31826cee69c8 )
            {
                if ( node.vfx )
                {
                    node.vfx delete();
                    toremove[ toremove.size ] = node;
                }
                
                wait throttlewait;
                continue;
            }
            
            if ( !isdefined( node.vfx ) )
            {
                spawnvfxnode( node, vfxname, vfxduration );
            }
            
            triggerfx( node.vfx );
            
            /#
                node.var_db7d7f5ceb1d3f6f = gettime();
            #/
            
            wait throttlewait;
        }
        
        nodearray = arrayremove( nodearray, toremove );
    }
}

// Namespace gas_shared
// Params 3, eflags: 0x4
// Checksum 0xdd59115d, Offset: 0x2eae
// Size: 0x6f
function private spawnvfxnode( node, vfxname, vfxduration )
{
    var_7237854e3be197ca = node.vfx;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    node.vfx = spawnfx( utility::getfx( vfxname ), node.origin );
    
    /#
        node thread function_ce287dbbcf2d89d0( node, vfxduration );
    #/
}

// Namespace gas_shared
// Params 1, eflags: 0x4
// Checksum 0x131472ec, Offset: 0x2f25
// Size: 0xc1
function private function_aea67a015f481d4d( params )
{
    gastype = params.gastype;
    
    if ( !function_8804575c4f9bba15( gastype ) )
    {
        return;
    }
    
    gassettings = level.var_543424c9692792ce.gassettings[ gastype ];
    gas_common::function_190e9b395a23e44a( gassettings.bundle, gassettings.tryspawndecoysthrottle );
    
    if ( self getscriptablehaspart( #"cradle_gas" ) && self getscriptablepartstate( #"cradle_gas", 1, 1 ) != #"enter_gas" )
    {
        self.var_fbd9557189406237 = 1;
        self setscriptablepartstate( #"cradle_gas", #"enter_gas" );
    }
}

// Namespace gas_shared
// Params 1, eflags: 0x4
// Checksum 0x7d58e9a, Offset: 0x2fee
// Size: 0x1d
function private function_8b9b4730128ae629( params )
{
    gas_common::function_81ce0d0c1e1afdea();
    self.var_955518e3fd692fbd = undefined;
}

// Namespace gas_shared
// Params 1, eflags: 0x4
// Checksum 0xdd6a08d2, Offset: 0x3013
// Size: 0x1e4
function private function_690694d33079c37c( params )
{
    gastype = params.gastype;
    attacker = params.attacker ?? params.trigger.owner;
    effect = params.effect ?? "fake_radar_pings_hallucination";
    attackerteam = attacker.team;
    self notify( "gas_createFakeRadarPings_" + gastype );
    self endon( "gas_createFakeRadarPings_" + gastype );
    
    if ( !function_8804575c4f9bba15( gastype ) )
    {
        return;
    }
    
    gasbundle = level.var_543424c9692792ce.gassettings[ gastype ].bundle;
    
    if ( !gasbundle.var_a1daa5c5b9781c83 )
    {
        return;
    }
    
    self endon( #"death_or_disconnect" );
    self endon( #"hash_daa4a3490ea5acfd" );
    self endon( #"hash_d917200fb349a58a" );
    
    while ( self.var_699daefc42231499[ effect ] )
    {
        gasbundle = level.var_543424c9692792ce.gassettings[ gastype ].bundle;
        numberping = randomintrange( gasbundle.var_c2ee0381a75b28c0 ?? 5, gasbundle.var_c2cb1981a735116a ?? 10 );
        pinglocationenemyteams( self.origin, attackerteam, self, numberping, gasbundle.radarpingmagnitude ?? 10, self, gasbundle.var_e4caee4552b9cbb1 ?? 500, gasbundle.var_b48e9411101e0ecf ?? 3000, gasbundle.var_b46b82110ff79f81 ?? 4500 );
        wait randomfloatrange( gasbundle.var_e74702897e4c7109 ?? 0.5, gasbundle.var_e723f4897e260a87 ?? 2 );
    }
}

// Namespace gas_shared
// Params 1, eflags: 0x4
// Checksum 0x232257b9, Offset: 0x31ff
// Size: 0x18
function private function_be56abfd2c49fff0( params )
{
    self notify( #"hash_d917200fb349a58a" );
}

// Namespace gas_shared
// Params 1, eflags: 0x4
// Checksum 0xf828a4c7, Offset: 0x321f
// Size: 0x14f
function private function_f8cf0ebb89c75fe8( params )
{
    gastype = params.gastype;
    
    if ( !function_8804575c4f9bba15( gastype ) )
    {
        return;
    }
    
    self notify( "gas_runFakeGunfireSFX_" + gastype );
    self endon( "gas_runFakeGunfireSFX_" + gastype );
    self endon( #"hash_daa4a3490ea5acfd" );
    self endon( #"hash_364c219248b93153" );
    self endon( #"death_or_disconnect" );
    attacker = params.attacker ?? params.trigger.owner;
    effect = params.effect ?? "fake_gun_hallucination";
    
    while ( self && self.var_699daefc42231499[ effect ] )
    {
        gunfirex = randomfloatrange( -1000, 1000 );
        gunfirey = randomfloatrange( -1000, 1000 );
        var_7c170ceae0649b57 = [ #"teamselect", self getentitynumber() ];
        gunfireentity = spawnscriptable( "equip_gas_hallucination_gunfire_sat_mp_noentity", self.origin + ( gunfirex, gunfirey, 0 ), undefined, undefined, var_7c170ceae0649b57 );
        gunfireentity thread function_f9e50e2e1cd43f9f();
        wait randomfloatrange( 0.5, 2 );
    }
}

// Namespace gas_shared
// Params 0, eflags: 0x4
// Checksum 0xa8592bbe, Offset: 0x3376
// Size: 0x1b
function private function_f9e50e2e1cd43f9f()
{
    self endon( #"death" );
    wait 2;
    
    if ( self )
    {
        self freescriptable();
    }
}

// Namespace gas_shared
// Params 1, eflags: 0x4
// Checksum 0x28481313, Offset: 0x3399
// Size: 0x18
function private function_d86efee1a27dd624( params )
{
    self notify( #"hash_364c219248b93153" );
}

// Namespace gas_shared
// Params 1, eflags: 0x4
// Checksum 0x43559080, Offset: 0x33b9
// Size: 0x128
function private gas_startcoughing( params )
{
    gastype = params.gastype;
    trigger = params.trigger;
    fromimpact = params.fromimpact;
    effect = params.effect ?? "coughing";
    
    if ( !function_8804575c4f9bba15( gastype ) )
    {
        return;
    }
    
    self notify( "gas_startCoughing_" + gastype );
    self endon( "gas_startCoughing_" + gastype );
    triggerid = trigger getentitynumber();
    self endon( "gas_exited_" + triggerid );
    self endon( #"death_or_disconnect" );
    gasbundle = level.var_543424c9692792ce.gassettings[ gastype ].bundle;
    childthread startloopingcoughaudio( trigger.owner );
    
    while ( self.var_699daefc42231499[ effect ] )
    {
        gas_applycough( trigger.owner, fromimpact, gastype );
        wait gasbundle.coughinterval ?? 1;
    }
}

// Namespace gas_shared
// Params 3, eflags: 0x4
// Checksum 0x7cc8f491, Offset: 0x34e9
// Size: 0xbe
function private gas_applycough( attacker, fromimpact, gastype )
{
    if ( !function_8804575c4f9bba15( gastype ) )
    {
        return;
    }
    
    self notify( "gas_applyCough_" + gastype );
    self endon( "gas_applyCough_" + gastype );
    
    if ( isinlaststand() )
    {
        return;
    }
    
    if ( function_c12cbea90e8fad9( gastype ) )
    {
        return;
    }
    
    var_f51647acde95eb6d = isdefined( self.perks[ "specialty_gas_grenade_resist" ] );
    var_b660048a0793257a = self == attacker;
    
    if ( !var_b660048a0793257a && var_f51647acde95eb6d )
    {
        return;
    }
    
    isheavy = fromimpact && !var_b660048a0793257a;
    
    if ( !self.gascoughinprogress || fromimpact )
    {
        thread gas_queuecough( isheavy, gastype );
    }
}

// Namespace gas_shared
// Params 2, eflags: 0x4
// Checksum 0xd1baa75b, Offset: 0x35af
// Size: 0x139
function private gas_queuecough( isheavy, gastype )
{
    if ( !function_8804575c4f9bba15( gastype ) )
    {
        return;
    }
    
    self endon( #"death_or_disconnect" );
    self endon( #"gas_clear_cough" );
    self notify( "gas_queue_cough_" + gastype );
    self endon( "gas_queue_cough_" + gastype );
    var_458c575e2b8c77cf = gettime() + 1000;
    
    while ( gas_coughisblocked( gastype ) )
    {
        waitframe();
    }
    
    if ( isheavy && gettime() > var_458c575e2b8c77cf )
    {
        isheavy = 0;
    }
    
    gasbundle = level.var_543424c9692792ce.gassettings[ gastype ].bundle;
    var_59e59df3ffdd9fa0 = getdvarint( @"hash_ae9ab8441d241bbc", gasbundle.var_59e59df3ffdd9fa0 ?? 0 );
    
    if ( var_59e59df3ffdd9fa0 )
    {
        thread utility::callsharedfunc( #"hash_fe35fdf5089ada26", #"hash_e2f87d36729a4f5a" );
    }
    
    if ( gasbundle.playcoughaudio )
    {
        thread utility::callsharedfunc( #"hash_fe35fdf5089ada26", #"playcoughaudio" );
    }
    
    if ( gasbundle.coughanimation != "NoAnimation" )
    {
        thread gas_begincoughinganimation( isheavy, gastype );
    }
}

// Namespace gas_shared
// Params 2, eflags: 0x4
// Checksum 0x57bd8be, Offset: 0x36f0
// Size: 0x2d2
function private gas_begincoughinganimation( isheavy, gastype )
{
    if ( !function_8804575c4f9bba15( gastype ) )
    {
        return;
    }
    
    self endon( #"death_or_disconnect" );
    self endon( #"gas_clear_cough" );
    self notify( "gas_begin_coughing_" + gastype );
    self endon( "gas_begin_coughing_" + gastype );
    
    if ( !isnullweapon( self getheldoffhand() ) )
    {
        childthread gas_takeheldoffhand();
    }
    
    self.gascoughinprogress = 1;
    gasbundle = level.var_543424c9692792ce.gassettings[ gastype ].bundle;
    coughdata = isheavy ? gasbundle.var_3e58cea97b04b271 : gasbundle.var_ac3a268db530a24;
    duration = coughdata.duration ?? ( isheavy ? 3.33 : 1.833 );
    val::set( gastype, "supers", 0 );
    
    if ( gasbundle.var_abb136511f52c9be )
    {
        val::set( gastype, "supersprint", 0 );
    }
    
    switch ( gasbundle.coughanimation )
    {
        case #"hash_832c121afa3d72d4":
            gesture = coughdata.gesture ?? ( isheavy ? "iw9_ges_gas_cough_long" : "iw9_ges_gas_cough" );
            currweapon = self getcurrentweapon();
            
            if ( currweapon.basename != "none" )
            {
                self playgestureviewmodel( gesture, undefined, 1 );
            }
            
            wait duration;
            break;
        case #"hash_7fd831d2caaf514b":
            var_af26ed837ee66f07 = scripted_weapons::get_scripted_weapon_object( gasbundle.var_ac3a268db530a24.var_a108ee957ed714ed ?? #"gas_cough_light" );
            var_4e22443d07a9c648 = scripted_weapons::get_scripted_weapon_object( gasbundle.var_3e58cea97b04b271.var_a108ee957ed714ed ?? #"gas_cough_heavy" );
            
            if ( self hasweapon( var_af26ed837ee66f07 ) )
            {
                inventory_utility::_takeweapon( var_af26ed837ee66f07 );
            }
            
            if ( self hasweapon( var_4e22443d07a9c648 ) )
            {
                inventory_utility::_takeweapon( var_4e22443d07a9c648 );
            }
            
            weaponobj = isheavy ? var_4e22443d07a9c648 : var_af26ed837ee66f07;
            self giveandfireoffhand( weaponobj );
            childthread gas_monitorcoughweaponfired( weaponobj );
            childthread gas_monitorcoughweapontaken( weaponobj );
            childthread gas_monitorcoughduration( duration );
            utility::waittill_any( "gas_coughWeaponFired", "gas_coughWeaponTaken", "gas_coughDuration" );
            
            if ( self hasweapon( weaponobj ) )
            {
                inventory_utility::_takeweapon( weaponobj );
            }
            
            break;
        default:
            break;
    }
    
    if ( gasbundle.var_abb136511f52c9be )
    {
        val::reset( gastype, "supersprint" );
    }
    
    val::reset( gastype, "supers" );
    self.gascoughinprogress = undefined;
}

// Namespace gas_shared
// Params 1, eflags: 0x4
// Checksum 0xeacd798d, Offset: 0x39ca
// Size: 0x1c1
function private function_e1e5525d97c82236( params )
{
    gastype = params.gastype;
    gasbundle = level.var_543424c9692792ce.gassettings[ gastype ].bundle;
    self.gascoughinprogress = undefined;
    
    if ( params.force )
    {
        self notify( #"gas_clear_cough" );
    }
    
    stoploopingcoughaudio();
    
    if ( gasbundle.var_abb136511f52c9be )
    {
        val::reset( gastype, "supersprint" );
    }
    
    val::reset( gastype, "supers" );
    
    if ( isreallyalive() )
    {
        if ( params.force )
        {
            if ( gasbundle.var_bc54c682c67a3440 )
            {
                self stopgestureviewmodel( gasbundle.var_ac3a268db530a24.gesture ?? "iw9_ges_gas_cough" );
                self stopgestureviewmodel( gasbundle.var_3e58cea97b04b271.gesture ?? "iw9_ges_gas_cough_long" );
            }
            else
            {
                var_af26ed837ee66f07 = scripted_weapons::get_scripted_weapon_object( gasbundle.var_ac3a268db530a24.var_a108ee957ed714ed ?? #"gas_cough_light" );
                var_4e22443d07a9c648 = scripted_weapons::get_scripted_weapon_object( gasbundle.var_3e58cea97b04b271.var_a108ee957ed714ed ?? #"gas_cough_heavy" );
                
                if ( var_af26ed837ee66f07 && self hasweapon( var_af26ed837ee66f07 ) )
                {
                    inventory_utility::_takeweapon( var_af26ed837ee66f07 );
                }
                
                if ( var_4e22443d07a9c648 && self hasweapon( var_4e22443d07a9c648 ) )
                {
                    inventory_utility::_takeweapon( var_4e22443d07a9c648 );
                }
            }
        }
        
        if ( self.gastakenweaponobj && isreallyalive() )
        {
            gas_restoreheldoffhand();
        }
    }
}

// Namespace gas_shared
// Params 1, eflags: 0x4
// Checksum 0x79a7e0b0, Offset: 0x3b93
// Size: 0x5e
function private gas_monitorcoughweaponfired( var_2d0bf388453117d1 )
{
    self endon( #"gas_coughWeaponTaken" );
    self endon( #"gas_coughDuration" );
    
    while ( true )
    {
        self waittill( #"offhand_fired", weaponobj );
        
        if ( issameweapon( weaponobj, var_2d0bf388453117d1 ) )
        {
            break;
        }
    }
    
    self notify( #"gas_coughWeaponFired" );
}

// Namespace gas_shared
// Params 1, eflags: 0x4
// Checksum 0x1a8423b4, Offset: 0x3bf9
// Size: 0x3e
function private gas_monitorcoughweapontaken( var_2d0bf388453117d1 )
{
    self endon( #"gas_coughWeaponFired" );
    self endon( #"gas_coughDuration" );
    
    while ( self hasweapon( var_2d0bf388453117d1 ) )
    {
        waitframe();
    }
    
    self notify( #"gas_coughWeaponTaken" );
}

// Namespace gas_shared
// Params 1, eflags: 0x4
// Checksum 0xcc8ecd28, Offset: 0x3c3f
// Size: 0x33
function private gas_monitorcoughduration( coughduration )
{
    self endon( #"gas_coughWeaponTaken" );
    self endon( #"gas_coughWeaponFired" );
    wait coughduration;
    self notify( #"gas_coughDuration" );
}

// Namespace gas_shared
// Params 1, eflags: 0x4
// Checksum 0xb0d12da5, Offset: 0x3c7a
// Size: 0x44
function private enableloopingcoughaudio( wpzone )
{
    if ( !isdefined( self.loopingcoughaudio ) )
    {
        self.loopingcoughaudio = 0;
    }
    
    self.loopingcoughaudio++;
    
    if ( self.loopingcoughaudio == 1 )
    {
        thread startloopingcoughaudio( wpzone );
    }
}

// Namespace gas_shared
// Params 0, eflags: 0x4
// Checksum 0x42377415, Offset: 0x3cc6
// Size: 0x52
function private disableloopingcoughaudio()
{
    if ( !isdefined( self.loopingcoughaudio ) )
    {
        return;
    }
    
    self.loopingcoughaudio--;
    assert( self.loopingcoughaudio >= 0, "<dev string:x13c>" );
    
    if ( self.loopingcoughaudio == 0 )
    {
        thread stoploopingcoughaudio();
        self.loopingcoughaudio = undefined;
    }
}

// Namespace gas_shared
// Params 1, eflags: 0x4
// Checksum 0x5cf5d628, Offset: 0x3d20
// Size: 0x295
function private startloopingcoughaudio( wpzone )
{
    self endon( #"death_or_disconnect" );
    self endon( #"hash_9d76019069d13f3c" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        waittime = randomfloatrange( 5, 7 );
        
        if ( !loopingcoughaudioissupressed() )
        {
            soundalias = "generic_cough_3_enemy_1";
            
            if ( self.operatorcustomization )
            {
                if ( wpzone )
                {
                    zoneteam = wpzone.team;
                }
                else
                {
                    zoneteam = "allies";
                }
                
                if ( self.team == zoneteam )
                {
                    if ( operator::isfemale() )
                    {
                        cough_amount = game[ "dialogue" ][ "allies_female_cough" ].size;
                        current_cough = randomint( cough_amount );
                        soundalias = game[ "dialogue" ][ "allies_female_cough" ][ current_cough ];
                    }
                    else
                    {
                        cough_amount = game[ "dialogue" ][ "allies_male_cough" ].size;
                        current_cough = randomint( cough_amount );
                        soundalias = game[ "dialogue" ][ "allies_male_cough" ][ current_cough ];
                    }
                }
                else if ( operator::isfemale() )
                {
                    cough_amount = game[ "dialogue" ][ "axis_female_cough" ].size;
                    current_cough = randomint( cough_amount );
                    soundalias = game[ "dialogue" ][ "axis_female_cough" ][ current_cough ];
                }
                else
                {
                    cough_amount = game[ "dialogue" ][ "axis_male_cough" ].size;
                    current_cough = randomint( cough_amount );
                    soundalias = game[ "dialogue" ][ "axis_male_cough" ][ current_cough ];
                }
            }
            else
            {
                cough_amount = game[ "dialogue" ][ "axis_male_cough" ].size;
                current_cough = randomint( cough_amount );
                soundalias = game[ "dialogue" ][ "axis_male_cough" ][ current_cough ];
            }
            
            if ( !isai( self ) )
            {
                self playlocalsound( "gas_player_cough" );
            }
            
            if ( utility::ismp() && game_utility::getgametype() != "ob" )
            {
                enemyteams = arrayremove( level.teamnamelist, self.team );
                self playsoundtoteam( soundalias, self.team, self, self );
                self playsoundtoteam( soundalias, enemyteams[ 0 ], self, self );
                
                if ( enemyteams[ 1 ] )
                {
                    self playsoundtoteam( soundalias, enemyteams[ 1 ], self, self );
                }
            }
            else if ( game_utility::getgametype() == "ob" )
            {
                if ( isplayer( self ) )
                {
                    enemyteams = arrayremove( level.teamnamelist, self.team );
                    self playsoundtoteam( soundalias, self.team, self, self );
                    
                    if ( enemyteams[ 0 ] )
                    {
                        self playsoundtoteam( soundalias, enemyteams[ 0 ], self, self );
                    }
                }
                else
                {
                    self playsoundonmovingent( soundalias );
                }
            }
            
            wait waittime;
            continue;
        }
        
        wait 1;
    }
}

// Namespace gas_shared
// Params 0, eflags: 0x4
// Checksum 0x9edd0195, Offset: 0x3fbd
// Size: 0xe
function private stoploopingcoughaudio()
{
    self notify( #"hash_9d76019069d13f3c" );
}

// Namespace gas_shared
// Params 0, eflags: 0x4
// Checksum 0xc3c51cfa, Offset: 0x3fd3
// Size: 0x22
function private enableloopingcoughaudiosupression()
{
    if ( !isdefined( self.loopingcoughaudiosupression ) )
    {
        self.loopingcoughaudiosupression = 0;
    }
    
    self.loopingcoughaudiosupression++;
}

// Namespace gas_shared
// Params 0, eflags: 0x4
// Checksum 0x60b274f7, Offset: 0x3ffd
// Size: 0x33
function private disableloopingcoughaudiosupression()
{
    if ( !isdefined( self.loopingcoughaudiosupression ) )
    {
        return;
    }
    
    self.loopingcoughaudiosupression--;
    assert( self.loopingcoughaudiosupression >= 0, "<dev string:x185>" );
}

// Namespace gas_shared
// Params 0, eflags: 0x4
// Checksum 0x9f6b549b, Offset: 0x4038
// Size: 0xd, Type: bool
function private loopingcoughaudioissupressed()
{
    return self.loopingcoughaudiosupression > 0;
}

// Namespace gas_shared
// Params 0, eflags: 0x4
// Checksum 0x2c6ebff, Offset: 0x404e
// Size: 0x22
function private clearloopingcoughaudio()
{
    self notify( #"hash_9d76019069d13f3c" );
    self.loopingcoughaudio = undefined;
    self.loopingcoughaudiosupression = undefined;
}

// Namespace gas_shared
// Params 1, eflags: 0x4
// Checksum 0xc9c6aa8e, Offset: 0x4078
// Size: 0x3aa
function private gas_applyspeedredux( params )
{
    gastype = params.gastype;
    
    if ( !function_8804575c4f9bba15( gastype ) )
    {
        return;
    }
    
    self endon( #"death_or_disconnect" );
    self notify( #"gas_modify_speed" );
    self endon( #"gas_modify_speed" );
    gasbundle = level.var_543424c9692792ce.gassettings[ gastype ].bundle;
    
    if ( isdefined( self.gasspeedmod ) )
    {
        if ( self.gasspeedmod < ( gasbundle.var_67d2eab6a1faf36a ?? -0.15 ) )
        {
            if ( isdefined( self.perks[ "specialty_gas_grenade_resist" ] ) )
            {
                if ( isdefined( self.perks[ "specialty_veteran" ] ) )
                {
                    namespace_9d8e359c3b1041e5::activateperksharedfunc( "specialty_veteran" );
                }
                else
                {
                    namespace_9d8e359c3b1041e5::activateperksharedfunc( "specialty_tac_resist" );
                }
                
                self.gasspeedmod = gasbundle.var_67d2eab6a1faf36a ?? -0.15;
                function_a0f5c85d465c5f0a( "gasSpeedMod", self.gasspeedmod );
                function_11a0a06c67c80f4d( "gasSpeedMod", 2 );
                function_a9e2a151b937eac5();
                return;
            }
            
            if ( self.gastriggerstouching )
            {
                foreach ( trigger in self.gastriggerstouching )
                {
                    if ( trigger && trigger.owner == self )
                    {
                        /#
                            if ( getdvarint( @"hash_6c7fd12a611ca1e8", 0 ) == 1 )
                            {
                                self.gasspeedmod = 0;
                                function_a0f5c85d465c5f0a( "<dev string:x1e2>", self.gasspeedmod );
                                function_11a0a06c67c80f4d( "<dev string:x1e2>", 2 );
                                break;
                            }
                        #/
                        
                        self.gasspeedmod = gasbundle.var_67d2eab6a1faf36a ?? -0.15;
                        function_a0f5c85d465c5f0a( "gasSpeedMod", self.gasspeedmod );
                        function_11a0a06c67c80f4d( "gasSpeedMod", 2 );
                        function_a9e2a151b937eac5();
                        return;
                    }
                }
            }
        }
    }
    else
    {
        self.gasspeedmod = 0;
        
        if ( !function_8ff835bf23198a0( "gasSpeedMod" ) )
        {
            function_ac4bf3256b2545e3( "gasSpeedMod", self.gasspeedmod );
            function_11a0a06c67c80f4d( "gasSpeedMod", 2 );
        }
    }
    
    var_eff79089a25249fe = gasbundle.var_1a56e275658a3b0d ?? -0.35;
    
    if ( isdefined( self.perks[ "specialty_gas_grenade_resist" ] ) )
    {
        var_eff79089a25249fe = gasbundle.var_67d2eab6a1faf36a ?? -0.15;
    }
    else if ( self.gastriggerstouching )
    {
        foreach ( trigger in self.gastriggerstouching )
        {
            if ( trigger && trigger.owner == self )
            {
                /#
                    if ( getdvarint( @"hash_6c7fd12a611ca1e8", 0 ) == 1 )
                    {
                        break;
                    }
                #/
                
                var_eff79089a25249fe = gasbundle.var_67d2eab6a1faf36a ?? -0.15;
            }
        }
    }
    
    gas_modifyspeed( var_eff79089a25249fe );
    self.gasspeedmod = var_eff79089a25249fe;
    function_a9e2a151b937eac5();
}

// Namespace gas_shared
// Params 1, eflags: 0x4
// Checksum 0xece5ed2b, Offset: 0x442a
// Size: 0x7b
function private gas_removespeedredux( params )
{
    self endon( #"death_or_disconnect" );
    self notify( #"gas_modify_speed" );
    self endon( #"gas_modify_speed" );
    
    if ( !isdefined( self.gasspeedmod ) )
    {
        return;
    }
    
    gas_modifyspeed( 0 );
    self.gasspeedmod = undefined;
    
    if ( function_8ff835bf23198a0( "gasSpeedMod" ) )
    {
        function_d85a92c557ea5a52( "gasSpeedMod" );
    }
    
    if ( isreallyalive() )
    {
        function_a9e2a151b937eac5();
    }
}

// Namespace gas_shared
// Params 1, eflags: 0xc
// Checksum 0x56dfaa6d, Offset: 0x44ad
// Size: 0xaf
function private gas_modifyspeed( var_eff79089a25249fe )
{
    self notify( #"hash_e0c68b32c07f3e46" );
    self endon( #"hash_e0c68b32c07f3e46" );
    timeelapsed = 0;
    
    while ( timeelapsed <= 0.65 )
    {
        timeelapsed += 0.05;
        
        if ( !self.gasspeedmod )
        {
            return;
        }
        
        self.gasspeedmod = math::lerp( self.gasspeedmod, var_eff79089a25249fe, min( 1, timeelapsed / 0.65 ) );
        function_a0f5c85d465c5f0a( "gasSpeedMod", self.gasspeedmod );
        function_11a0a06c67c80f4d( "gasSpeedMod", 2 );
        function_a9e2a151b937eac5();
        wait 0.05;
    }
}

// Namespace gas_shared
// Params 1, eflags: 0x4
// Checksum 0xc4446b25, Offset: 0x4564
// Size: 0x1f2
function private gas_applyblur( params )
{
    gastype = params.gastype;
    effect = params.effect ?? "blurred_vision";
    
    if ( !function_8804575c4f9bba15( gastype ) )
    {
        return;
    }
    
    self endon( #"death_or_disconnect" );
    self notify( #"hash_1f7a3b28c814e517" );
    self endon( #"hash_1f7a3b28c814e517" );
    typedata = level.var_543424c9692792ce.gassettings[ gastype ];
    gasbundle = typedata.bundle;
    shockassetname = gasbundle.heavyshock ?? %"gas_grenade_heavy_mp";
    
    if ( isdefined( self.perks[ "specialty_gas_grenade_resist" ] ) )
    {
        shockassetname = gasbundle.lightshock ?? %"gas_grenade_light_mp";
    }
    else if ( self.gastriggerstouching )
    {
        foreach ( trigger in self.gastriggerstouching )
        {
            if ( trigger && trigger.owner == self )
            {
                /#
                    if ( getdvarint( @"hash_6c7fd12a611ca1e8", 0 ) == 1 )
                    {
                        break;
                    }
                #/
                
                shockassetname = gasbundle.lightshock ?? %"gas_grenade_light_mp";
            }
        }
    }
    
    function_dcb13d23fa969d90( gastype );
    
    while ( self.var_699daefc42231499[ effect ] )
    {
        shellshock_utility_cpmp::_shellshock( shockassetname, #"gas", 0.75, 0 );
        wait 0.3;
    }
}

// Namespace gas_shared
// Params 1, eflags: 0x4
// Checksum 0xcda26d85, Offset: 0x475e
// Size: 0x80
function private function_dcb13d23fa969d90( gastype )
{
    if ( !function_8804575c4f9bba15( gastype ) )
    {
        return;
    }
    
    gasbundle = level.var_543424c9692792ce.gassettings[ gastype ].bundle;
    var_e5e3f7fdc72e8f26 = gasbundle.heavyshock ?? %"gas_grenade_heavy_mp";
    shellshock_utility_cpmp::_shellshock( var_e5e3f7fdc72e8f26, #"stun", 0.75, 0, 100 );
}

// Namespace gas_shared
// Params 1, eflags: 0x4
// Checksum 0xfe05df7c, Offset: 0x47e6
// Size: 0x5d
function private gas_removeblur( params )
{
    gasbundle = level.var_543424c9692792ce.gassettings[ params.gastype ].bundle;
    self notify( #"hash_1f7a3b28c814e517" );
    
    if ( isreallyalive() )
    {
        shellshock_utility_cpmp::_stopshellshock();
    }
}

// Namespace gas_shared
// Params 1, eflags: 0x4
// Checksum 0xe9d9166, Offset: 0x484b
// Size: 0x108
function private function_f1479e9c70fb245( params )
{
    gastype = params.gastype;
    
    if ( !function_8804575c4f9bba15( gastype ) )
    {
        return;
    }
    
    typedata = level.var_543424c9692792ce.gassettings[ gastype ];
    gasbundle = typedata.bundle;
    
    if ( gasbundle.pbgpostfxbundle )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fullscreenfx" ][ #"hash_382df7654f0561bd" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self [[ var_32dbca3143d9c4a5 ]]( { #postfxbundlename:gasbundle.pbgpostfxbundle }, 1, 1 );
        }
    }
    
    if ( gasbundle.ashvfx )
    {
        playfxontagforclients( utility::getfx( gasbundle.ashvfx ), self, "tag_eye", self );
    }
    
    if ( gasbundle.var_1c18f319569965b4 )
    {
        val::set( gastype, "show_ui_gasmask_overlay", 1 );
    }
}

// Namespace gas_shared
// Params 1, eflags: 0x4
// Checksum 0x9020267b, Offset: 0x495b
// Size: 0xf3
function private function_471b86d63c315c09( params )
{
    gasbundle = level.var_543424c9692792ce.gassettings[ params.gastype ].bundle;
    gastype = params.gastype;
    
    if ( gasbundle.pbgpostfxbundle )
    {
        var_32dbca3143d9c4a5 = level.sharedfuncs[ #"fullscreenfx" ][ #"hash_494b07757cd511a5" ];
        
        if ( isdefined( var_32dbca3143d9c4a5 ) )
        {
            self [[ var_32dbca3143d9c4a5 ]]( { #postfxbundlename:gasbundle.pbgpostfxbundle } );
        }
    }
    
    if ( gasbundle.ashvfx )
    {
        stopfxontagforclients( utility::getfx( gasbundle.ashvfx ), self, "tag_eye", self );
    }
    
    if ( gasbundle.var_1c18f319569965b4 )
    {
        val::reset( gastype, "show_ui_gasmask_overlay" );
    }
}

// Namespace gas_shared
// Params 0
// Checksum 0x946a8106, Offset: 0x4a56
// Size: 0x1cd
function gas_takeheldoffhand()
{
    if ( self.gastakenweaponobj )
    {
        gas_restoreheldoffhand();
    }
    
    self endon( #"hash_24e08adb990efce0" );
    self.gastakenweaponobj = self getheldoffhand();
    equipmentref = utility::callsharedfunc( #"equipment", #"getequipmentreffromweapon", self.gastakenweaponobj );
    
    if ( equipmentref && utility::callsharedfunc( #"equipment", #"hash_3ac567741b56536d", equipmentref ) )
    {
        self.gastakenweaponammo = utility::callsharedfunc( #"equipment", #"getequipmentammo", equipmentref );
        inventory_utility::_takeweapon( self.gastakenweaponobj );
        wait 0.05;
        thread gas_restoreheldoffhand();
    }
    
    superref = utility::callsharedfunc( #"supers", #"hash_65348a5eaf5c44d7", self.gastakenweaponobj );
    
    if ( superref )
    {
        currentsuperref = utility::callsharedfunc( #"supers", #"getcurrentsuperref" );
        
        if ( currentsuperref == superref )
        {
            self.gastakenweaponammo = self getammocount( self.gastakenweaponobj );
            inventory_utility::_takeweapon( self.gastakenweaponobj );
            wait 0.05;
            thread gas_restoreheldoffhand();
        }
    }
    
    isgesture = utility::callsharedfunc( #"weapons", #"hash_b8e796d000003888", self.gastakenweaponobj );
    
    if ( isgesture )
    {
        inventory_utility::_takeweapon( self.gastakenweaponobj );
        wait 0.05;
        thread gas_restoreheldoffhand();
    }
    
    self.gastakenweaponammo = self getammocount( self.gastakenweaponobj );
    inventory_utility::_takeweapon( self.gastakenweaponobj );
    wait 0.05;
    thread gas_restoreheldoffhand();
}

// Namespace gas_shared
// Params 0
// Checksum 0x3a03b455, Offset: 0x4c2b
// Size: 0x2b3
function gas_restoreheldoffhand()
{
    self notify( #"hash_24e08adb990efce0" );
    superref = utility::callsharedfunc( #"supers", #"hash_65348a5eaf5c44d7", self.gastakenweaponobj );
    
    if ( superref )
    {
        currentsuperref = utility::callsharedfunc( #"supers", #"getcurrentsuperref" );
        
        if ( currentsuperref == superref )
        {
            inventory_utility::_giveweapon( self.gastakenweaponobj );
            self assignweaponoffhandspecial( self.gastakenweaponobj );
            self setweaponammoclip( self.gastakenweaponobj, self.gastakenweaponammo );
            self.gastakenweaponobj = undefined;
            self.gastakenweaponammo = undefined;
        }
        
        return;
    }
    
    equipmentref = utility::callsharedfunc( #"equipment", #"getequipmentreffromweapon", self.gastakenweaponobj );
    
    if ( equipmentref && utility::callsharedfunc( #"equipment", #"hash_3ac567741b56536d", equipmentref ) )
    {
        inventory_utility::_giveweapon( self.gastakenweaponobj );
        slot = utility::callsharedfunc( #"equipment", #"findequipmentslot", equipmentref );
        assert( slot == "<dev string:x1ee>" || slot == "<dev string:x1f6>", "<dev string:x200>" + equipmentref + "<dev string:x225>" );
        
        if ( slot == "primary" )
        {
            self assignweaponoffhandprimary( self.gastakenweaponobj );
        }
        else if ( slot == "secondary" )
        {
            self assignweaponoffhandsecondary( self.gastakenweaponobj );
        }
        
        utility::callsharedfunc( #"equipment", #"hash_2f937acac312c547", equipmentref, self.gastakenweaponammo );
        self.gastakenweaponobj = undefined;
        self.gastakenweaponammo = undefined;
        return;
    }
    
    isgesture = utility::callsharedfunc( #"weapons", #"hash_b8e796d000003888", self.gastakenweaponobj );
    
    if ( isgesture )
    {
        if ( self.gestureweapon == self.gastakenweaponobj.basename )
        {
            inventory_utility::_giveweapon( self.gastakenweaponobj );
            self.gastakenweaponobj = undefined;
        }
        
        return;
    }
    
    var_b9d1c21ecd1b752 = utility::callsharedfunc( #"supers", #"hash_d0c1f597fe066ed4", self.gastakenweaponobj );
    
    if ( var_b9d1c21ecd1b752 )
    {
        self.gastakenweaponobj = undefined;
        return;
    }
    
    inventory_utility::_giveweapon( self.gastakenweaponobj );
    self setweaponammoclip( self.gastakenweaponobj, self.gastakenweaponammo );
    self.gastakenweaponobj = undefined;
    self.gastakenweaponammo = undefined;
}

// Namespace gas_shared
// Params 1, eflags: 0xc
// Checksum 0x25a3548d, Offset: 0x4ee6
// Size: 0xa1
function private function_ce601d6f64265108( position )
{
    self notify( #"hash_c4690c4ae0e308ae" );
    self endon( #"hash_c4690c4ae0e308ae" );
    self endon( #"death" );
    gasbundle = level.var_543424c9692792ce.gassettings[ self.gastype ].bundle;
    wait 0.1;
    
    while ( true )
    {
        function_b6fbb9865eba37ee( gasbundle.gasmaskdamage ?? 5, position );
        wait gasbundle.var_264afc2795b62777 ?? 1;
    }
}

// Namespace gas_shared
// Params 2, eflags: 0xc
// Checksum 0xf8f96add, Offset: 0x4f8f
// Size: 0x324
function private function_b6fbb9865eba37ee( gasmaskdamage, position )
{
    self notify( #"hash_96b28888fdd294a8" );
    self endon( #"hash_96b28888fdd294a8" );
    gasbundle = level.var_543424c9692792ce.gassettings[ self.gastype ].bundle;
    
    if ( !gasbundle.var_e4a1e3b4e7b84f97 || !common_inventory::inventory_isenabled() )
    {
        return;
    }
    
    if ( gasbundle.var_ac1e8a222103ae97 )
    {
        foreach ( player in self.playersintrigger )
        {
            if ( ( player.gasmaskhealth ?? 0 ) > 0 && !player getinairpocket() )
            {
                player gasmask::processdamage( gasmaskdamage );
                
                if ( common_inventory::function_5c64d2b24a8c3e18() )
                {
                    player common_inventory::function_6525f6bbec67b15e( level.var_6a8b6f867f6e7ad4, gasmaskdamage );
                }
            }
        }
    }
    
    checkorigin = self.impactlocation ?? position ?? self.origin;
    var_f5201d302bbaf59e = [];
    
    if ( gasbundle.var_e1137deb7ec68126 )
    {
        if ( gasbundle.gasmaskscriptables )
        {
            foreach ( struct in gasbundle.gasmaskscriptables )
            {
                var_f5201d302bbaf59e[ var_f5201d302bbaf59e.size ] = struct.scriptable;
            }
        }
        
        if ( !var_f5201d302bbaf59e || var_f5201d302bbaf59e.size <= 0 )
        {
            var_f5201d302bbaf59e = [ "brloot_equip_gasmask", "brloot_equip_gasmask_durable" ];
        }
        
        var_6b3cd44c8b012487 = getlootscriptablearrayinradius( var_f5201d302bbaf59e, undefined, checkorigin, self.radius );
        
        for ( index = var_6b3cd44c8b012487.size - 1; index >= 0 ; index-- )
        {
            gasmask = var_6b3cd44c8b012487[ index ];
            
            if ( !gasmask )
            {
                continue;
            }
            
            zdisplacement = gasmask.origin[ 2 ] - checkorigin[ 2 ];
            
            if ( gasmask.var_69c7f935014de621 || abs( zdisplacement ) > self.height || gasmask function_363477bc8bd88260() )
            {
                continue;
            }
            
            newhealth = int( gasmask.count - gasmaskdamage );
            
            if ( newhealth <= 0 )
            {
                gasmask setscriptablepartstate( gasmask.type, "death" );
                gasmask common_item::items_scriptable_waitandcleanup( 1 );
                continue;
            }
            
            gasmask.count = newhealth;
        }
    }
}

// Namespace gas_shared
// Params 0
// Checksum 0x1bbdca8d, Offset: 0x52bb
// Size: 0x7e, Type: bool
function function_363477bc8bd88260()
{
    if ( self && level.decon_station.instances && level.decon_station.radius )
    {
        stations = function_6a293b884c444a20( level.decon_station.instances, self.origin, level.decon_station.radius ).size ?? 0;
        return ( stations > 0 );
    }
    
    return false;
}

// Namespace gas_shared
// Params 1, eflags: 0x4
// Checksum 0xef6e5871, Offset: 0x5342
// Size: 0x49
function private function_c0c793c680b85744( trigger )
{
    return { #weapon:trigger.weapon, #owner:trigger.owner, #gastype:trigger.gastype };
}

// Namespace gas_shared
// Params 1, eflags: 0x4
// Checksum 0xb40eb89b, Offset: 0x5394
// Size: 0x1e4
function private onplayerdeath( params )
{
    victim = params.victim;
    
    if ( victim isinlaststand() )
    {
        return;
    }
    
    attacker = params.inflictor.gastype && player_utility::playersareenemies( params.inflictor.owner, victim ) ? params.inflictor.owner : params.attacker;
    
    if ( params.inflictor.gastype && player_utility::playersareenemies( params.inflictor.owner, victim ) )
    {
        killer = params.inflictor.owner;
        function_c8b5c2a0ccc2b079( killer, params.inflictor.gastype );
    }
    
    if ( victim.gastriggerstouching )
    {
        foreach ( trigger in victim.gastriggerstouching )
        {
            if ( ( !killer || trigger.owner != killer ) && trigger.gastype && player_utility::playersareenemies( trigger.owner, victim ) )
            {
                function_e041a80e36f5438e( trigger.owner, trigger.gastype );
            }
        }
    }
}

// Namespace gas_shared
// Params 1, eflags: 0x4
// Checksum 0x3d1f6ed4, Offset: 0x5580
// Size: 0x181
function private function_d8957f2712fd72c8( params )
{
    victim = params.victim;
    
    if ( params.inflictor.gastype )
    {
        killer = params.inflictor.owner;
        victim.var_8bff21e695949a36 = function_c0c793c680b85744( params.inflictor );
    }
    
    if ( victim.gastriggerstouching && victim.gastriggerstouching.size > 0 )
    {
        foreach ( trigger in victim.gastriggerstouching )
        {
            if ( ( !killer || trigger.owner != killer ) && trigger.gastype && player_utility::playersareenemies( trigger.owner, victim ) )
            {
                if ( !isdefined( victim.var_662ef4a19bc94022 ) )
                {
                    victim.var_662ef4a19bc94022 = [];
                }
                
                victim.var_662ef4a19bc94022[ victim.var_662ef4a19bc94022.size ] = function_c0c793c680b85744( trigger );
            }
        }
    }
}

// Namespace gas_shared
// Params 1, eflags: 0x4
// Checksum 0x689dbb74, Offset: 0x5709
// Size: 0x21
function private function_c614aaeb1d4d8bc6( params )
{
    if ( params.revived )
    {
        function_dbb4e05b73eb8c60();
    }
}

// Namespace gas_shared
// Params 1, eflags: 0x4
// Checksum 0xbdb42a0, Offset: 0x5732
// Size: 0xfa
function private function_7287ce7611d8022c( params )
{
    victim = self;
    
    if ( victim.var_8bff21e695949a36 )
    {
        function_c8b5c2a0ccc2b079( victim.var_8bff21e695949a36.owner, victim.var_8bff21e695949a36.gastype );
    }
    
    if ( victim.var_662ef4a19bc94022 )
    {
        foreach ( assistdata in victim.var_662ef4a19bc94022 )
        {
            function_e041a80e36f5438e( assistdata.owner, assistdata.gastype );
        }
    }
    
    function_dbb4e05b73eb8c60();
}

// Namespace gas_shared
// Params 0
// Checksum 0x2ce49181, Offset: 0x5834
// Size: 0x16
function function_dbb4e05b73eb8c60()
{
    self.var_662ef4a19bc94022 = undefined;
    self.var_8ccb2a8649d03cbf = undefined;
}

// Namespace gas_shared
// Params 2, eflags: 0x4
// Checksum 0xa956d50a, Offset: 0x5852
// Size: 0xc5
function private function_c8b5c2a0ccc2b079( player, gastype )
{
    if ( level.var_543424c9692792ce.callbacks[ gastype ][ #"gas_kill" ] )
    {
        foreach ( func in level.var_543424c9692792ce.callbacks[ gastype ][ #"gas_kill" ] )
        {
            [[ func ]]( player );
        }
    }
}

// Namespace gas_shared
// Params 2, eflags: 0x4
// Checksum 0xcd5f37d8, Offset: 0x591f
// Size: 0xc5
function private function_e041a80e36f5438e( player, gastype )
{
    if ( level.var_543424c9692792ce.callbacks[ gastype ][ #"gas_assist" ] )
    {
        foreach ( func in level.var_543424c9692792ce.callbacks[ gastype ][ #"gas_assist" ] )
        {
            [[ func ]]( player );
        }
    }
}

// Namespace gas_shared
// Params 1
// Checksum 0x3bad176b, Offset: 0x59ec
// Size: 0x43
function function_bba6138e6a808cab( bundle )
{
    if ( getdvarint( @"hash_f1d37bcc38551bd5", 0 ) )
    {
        return 0;
    }
    
    return bundle ? bundle.var_6b917fa1fc3c2547 && bundle.gassettings : 1;
}

// Namespace gas_shared
// Params 1
// Checksum 0x28dd145d, Offset: 0x5a38
// Size: 0x23, Type: bool
function function_5e51d190d7d16b43( gastype )
{
    return isdefined( level.var_543424c9692792ce.gassettings[ gastype ] );
}

// Namespace gas_shared
// Params 1
// Checksum 0xb8f09102, Offset: 0x5a64
// Size: 0x6d, Type: bool
function function_8804575c4f9bba15( gastype )
{
    if ( !gastype )
    {
        assert( gastype, "<dev string:x240>" );
        return false;
    }
    
    if ( !level.var_543424c9692792ce.gassettings[ gastype ] )
    {
        assert( level.var_543424c9692792ce.gassettings[ gastype ], "<dev string:x255>" + gastype + "<dev string:x26d>" );
        return false;
    }
    
    return true;
}

// Namespace gas_shared
// Params 0
// Checksum 0xafe14234, Offset: 0x5ada
// Size: 0x25, Type: bool
function function_112ba29b0a8fbe36()
{
    return isreallyalive() && self.gastriggerstouching && self.gastriggerstouching.size > 0;
}

// Namespace gas_shared
// Params 0
// Checksum 0x66f9da5c, Offset: 0x5b08
// Size: 0x37, Type: bool
function gas_shouldtakeheldoffhand()
{
    switch ( self getheldoffhand().basename )
    {
        case #"hash_3102ab88c5c102fc":
            return false;
        default:
            return true;
    }
    
    return false;
}

// Namespace gas_shared
// Params 1
// Checksum 0xedc601a1, Offset: 0x5b48
// Size: 0x7e
function gas_coughisblocked( gastype )
{
    if ( !function_8804575c4f9bba15( gastype ) )
    {
        return;
    }
    
    if ( function_c12cbea90e8fad9( gastype ) )
    {
        return 1;
    }
    
    if ( !val::get( "cough_gesture" ) )
    {
        return 1;
    }
    
    if ( !val::get( "offhand_weapons" ) )
    {
        return 1;
    }
    
    if ( !isnullweapon( self getheldoffhand() ) && !gas_shouldtakeheldoffhand() )
    {
        return 1;
    }
    
    if ( isinlaststand() )
    {
        return 1;
    }
    
    if ( self isreloading() )
    {
        return 1;
    }
    
    return 0;
}

// Namespace gas_shared
// Params 1
// Checksum 0x95634115, Offset: 0x5bcf
// Size: 0x25, Type: bool
function function_8de1f4bd0dc11222( player )
{
    if ( player function_65267a768ced48a0() )
    {
        return true;
    }
    
    if ( player getinairpocket() )
    {
        return true;
    }
    
    return false;
}

// Namespace gas_shared
// Params 1
// Checksum 0xb4bbf9b4, Offset: 0x5bfd
// Size: 0x48, Type: bool
function function_c12cbea90e8fad9( gastype )
{
    if ( !function_8804575c4f9bba15( gastype ) )
    {
        return true;
    }
    
    if ( isdefined( self.perks[ "specialty_gas_immunity" ] ) )
    {
        return true;
    }
    
    if ( self function_65267a768ced48a0() )
    {
        return true;
    }
    
    if ( self getinairpocket() )
    {
        return true;
    }
    
    return false;
}

// Namespace gas_shared
// Params 2, eflags: 0x4
// Checksum 0xeeb3f1dc, Offset: 0x5c4e
// Size: 0x1e, Type: bool
function private function_c8758239aeff157d( gastype, effect )
{
    return !function_f6b90ef26d1a0d71( gastype );
}

// Namespace gas_shared
// Params 2, eflags: 0x4
// Checksum 0x1cad80f9, Offset: 0x5c75
// Size: 0x1c, Type: bool
function private function_7bd9ef1061ea87a6( gastype, effect )
{
    return !function_50712faea48df1b5();
}

// Namespace gas_shared
// Params 2, eflags: 0x4
// Checksum 0xdfa47c2, Offset: 0x5c9a
// Size: 0x76, Type: bool
function private function_2b07fb15b1a54bf8( gastype, effect )
{
    if ( !function_a7d2179c401b72a2( gastype, effect ) )
    {
        return false;
    }
    
    gassettings = level.var_543424c9692792ce.gassettings[ gastype ];
    
    if ( gassettings.bundle.var_3bf335bc738ca153 && isdefined( self.perks[ "specialty_gas_grenade_resist" ] ) )
    {
        return false;
    }
    
    return true;
}

// Namespace gas_shared
// Params 2, eflags: 0x4
// Checksum 0xc8970be1, Offset: 0x5d19
// Size: 0x76, Type: bool
function private function_e50acd40c2cebf13( gastype, effect )
{
    if ( !function_a7d2179c401b72a2( gastype, effect ) )
    {
        return false;
    }
    
    gassettings = level.var_543424c9692792ce.gassettings[ gastype ];
    
    if ( gassettings.bundle.var_368c6c61aacaa6ab && isdefined( self.perks[ "specialty_gas_grenade_resist" ] ) )
    {
        return false;
    }
    
    return true;
}

// Namespace gas_shared
// Params 2, eflags: 0x4
// Checksum 0x3c1c8780, Offset: 0x5d98
// Size: 0x76, Type: bool
function private function_d3fa6a59f40c42ad( gastype, effect )
{
    if ( !function_a7d2179c401b72a2( gastype, effect ) )
    {
        return false;
    }
    
    gassettings = level.var_543424c9692792ce.gassettings[ gastype ];
    
    if ( gassettings.bundle.var_e3ca95b46d50bf9e && isdefined( self.perks[ "specialty_gas_grenade_resist" ] ) )
    {
        return false;
    }
    
    return true;
}

// Namespace gas_shared
// Params 2, eflags: 0x4
// Checksum 0x8ecad3b3, Offset: 0x5e17
// Size: 0x2f, Type: bool
function private function_a7d2179c401b72a2( gastype, effect )
{
    if ( function_50712faea48df1b5() )
    {
        return false;
    }
    
    if ( function_f6b90ef26d1a0d71( gastype ) )
    {
        return false;
    }
    
    return true;
}

// Namespace gas_shared
// Params 0, eflags: 0x4
// Checksum 0xf70a46c4, Offset: 0x5e4f
// Size: 0x12, Type: bool
function private function_50712faea48df1b5()
{
    return isdefined( self.perks[ "specialty_hallucination_immunity" ] );
}

// Namespace gas_shared
// Params 1, eflags: 0x4
// Checksum 0x356466bd, Offset: 0x5e6a
// Size: 0x5d, Type: bool
function private function_f6b90ef26d1a0d71( gastype )
{
    gasbundle = level.var_543424c9692792ce.gassettings[ gastype ].bundle;
    
    if ( gasbundle.var_f78edad5395fcae && ( self.gasmaskhealth ?? 0 ) > 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace gas_shared
// Params 0
// Checksum 0x4c48f94c, Offset: 0x5ed0
// Size: 0x3d
function isreallyalive()
{
    return utility::issharedfuncdefined( #"player", #"isreallyalive" ) ? utility::callsharedfunc( #"player", #"isreallyalive" ) : isalive( self );
}

// Namespace gas_shared
// Params 0
// Checksum 0xd8d81f76, Offset: 0x5f16
// Size: 0x1a
function function_a9e2a151b937eac5()
{
    return utility::callsharedfunc( #"player", #"updatemovespeed" );
}

// Namespace gas_shared
// Params 2
// Checksum 0x5479740, Offset: 0x5f39
// Size: 0x30
function function_ac4bf3256b2545e3( name, scaler )
{
    return utility::callsharedfunc( #"player", #"hash_8622afcf80deaeac", name, scaler );
}

// Namespace gas_shared
// Params 2
// Checksum 0xb1e6425e, Offset: 0x5f72
// Size: 0x30
function function_11a0a06c67c80f4d( name, filter )
{
    return utility::callsharedfunc( #"player", #"hash_b885d6037185a56e", name, filter );
}

// Namespace gas_shared
// Params 2
// Checksum 0xf08a3ca0, Offset: 0x5fab
// Size: 0x30
function function_a0f5c85d465c5f0a( name, scaler )
{
    return utility::callsharedfunc( #"player", #"hash_f42c37ef5b209a91", name, scaler );
}

// Namespace gas_shared
// Params 1
// Checksum 0x12907383, Offset: 0x5fe4
// Size: 0x26
function function_d85a92c557ea5a52( name )
{
    return utility::callsharedfunc( #"player", #"hash_a769545511e9bef", name );
}

// Namespace gas_shared
// Params 1
// Checksum 0x70c3b29d, Offset: 0x6013
// Size: 0x26
function function_8ff835bf23198a0( name )
{
    return utility::callsharedfunc( #"player", #"hash_1f1ccdc6843fdbb", name );
}

// Namespace gas_shared
// Params 0
// Checksum 0xb67b01f4, Offset: 0x6042
// Size: 0x1b
function isinlaststand()
{
    return utility::callsharedfunc( #"player", #"hash_a53ceb859c8f1796", self );
}

// Namespace gas_shared
// Params 2
// Checksum 0xf15aa2c1, Offset: 0x6066
// Size: 0x30
function function_3e896977ce2b8f2f( attacker, inflictor )
{
    return utility::callsharedfunc( #"damage", #"hash_49ae9b9932fe5bd0", attacker, inflictor );
}

// Namespace gas_shared
// Params 1
// Checksum 0xe8a84e06, Offset: 0x609f
// Size: 0x26
function buildweapon( weapon )
{
    return utility::callsharedfunc( #"weapons", #"hash_e8487ac95841b053", weapon );
}

// Namespace gas_shared
// Params 7
// Checksum 0xc313c71a, Offset: 0x60ce
// Size: 0x64
function monitordamage( maxhealth, damagefeedback, ondeathfunc, modifydamagefunc, biskillstreak, rumble, resetdamagetaken )
{
    return utility::callsharedfunc( #"damage", #"monitordamage", maxhealth, damagefeedback, ondeathfunc, modifydamagefunc, biskillstreak, rumble, resetdamagetaken );
}

/#

    // Namespace gas_shared
    // Params 1, eflags: 0x4
    // Checksum 0xbc4c8b24, Offset: 0x613b
    // Size: 0xdc, Type: dev
    function private drawdebugtrigger( trigger )
    {
        trigger endon( #"death" );
        level endon( #"game_ended" );
        draw_version = getdvarint( @"hash_94521eb2fc22ae59", 0 );
        
        while ( true )
        {
            switch ( draw_version )
            {
                case 1:
                    drawentitybounds( trigger, ( 1, 0, 0 ), 0, 1 );
                    break;
                case 2:
                    cylinder( trigger.origin, trigger.origin + ( 0, 0, trigger.height ), trigger.radius, ( 1, 0, 0 ), 0, 1 );
                    break;
                default:
                    return;
            }
            
            waitframe();
        }
    }

    // Namespace gas_shared
    // Params 2, eflags: 0x4
    // Checksum 0x3eca57c3, Offset: 0x621f
    // Size: 0xfc, Type: dev
    function private function_ce287dbbcf2d89d0( node, vfxduration )
    {
        level endon( #"game_ended" );
        node.vfx endon( #"death" );
        vfxdurationms = vfxduration * 1000;
        
        while ( true )
        {
            shoulddraw = getdvarint( @"hash_b473595c8304dbaa", 0 );
            
            if ( !shoulddraw )
            {
                waitframe();
                continue;
            }
            
            color = ( 1, 0, 0 );
            
            if ( node.var_db7d7f5ceb1d3f6f )
            {
                var_d9a778bd2f17eef1 = gettime() - node.var_db7d7f5ceb1d3f6f;
                t = var_d9a778bd2f17eef1 / vfxdurationms;
                color = lerp( ( 0, 1, 0 ), ( 1, 0, 0 ), t );
            }
            
            sphere( node.origin, 50, color, 1 );
            waitframe();
        }
    }

#/
