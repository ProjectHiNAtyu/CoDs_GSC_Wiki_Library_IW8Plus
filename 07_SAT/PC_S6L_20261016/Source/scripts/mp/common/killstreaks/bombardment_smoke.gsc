// scripts\mp\common\killstreaks\bombardment_smoke.gsc  (hash_43ab82a549bad267.gscc) (size: 6389 Bytes / 0x18f5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8eef64bb (2398053563)
// size ...... 6389 (0x18f5)
// includes .. 5   (offset: 0x1849)
// strings ... 8   (offset: 0x1871)
// dev strs .. 0   (offset: 0x18f5)
// exports ... 19  (offset: 0xec9)
// cseg ...... 0x122 + 0xda7 (0xec9)
// imports ... 57  (offset: 0x11c1)
// animtree1 . 0   (offset: 0x18f5)
// animtree2 . 0   (offset: 0x18f5)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\killstreaks\killstreak_shared;
#using scripts\common\utility;
#using scripts\mp\ent_manager;

#namespace bombardment_smoke;

// Namespace bombardment_smoke
// Params 0, eflags: 0x1
// Checksum 0xb2ffbd0a, Offset: 0x140
// Size: 0x23
function autoexec main()
{
    utility::flag_init( "bombardment_smoke_initialized" );
    killstreak_shared::registerkillstreakinitfunction( getxhash( "bombardment_smoke" ), &init );
}

// Namespace bombardment_smoke
// Params 0
// Checksum 0x62f00201, Offset: 0x16b
// Size: 0x4d
function init()
{
    namespace_9d8e359c3b1041e5::registerkillstreaksharedfunc( "bombardment_smoke", &function_60b2c0080907385d );
    bundle = level.streakglobals.streakbundles[ "bombardment_smoke" ];
    utility::flag_set( "bombardment_smoke_initialized" );
    thread function_ca7642ac3cd22d57( bundle );
}

// Namespace bombardment_smoke
// Params 1
// Checksum 0x7b728786, Offset: 0x1c0
// Size: 0x6e
function function_ca7642ac3cd22d57( bundle )
{
    level endon( #"game_ended" );
    
    while ( !utility::flag_exist( "bombardment_common_initialized" ) || !utility::flag( "bombardment_common_initialized" ) )
    {
        waitframe();
    }
    
    utility::callsharedfunc( #"bombardment_common", #"register", "bombardment_smoke", bundle.bcdata, &function_9e17699244861696, &function_cb413cc7d1b83efb );
}

// Namespace bombardment_smoke
// Params 6
// Checksum 0xccc88c33, Offset: 0x236
// Size: 0x299
function function_9e17699244861696( streakinfo, var_ff2c40cf5f0d3cc8, var_d0b84b2215b34610, var_2bfd178bc84d73d7, var_e563c7b55d6eb727, var_56aff40dfda39956 )
{
    bcdata = streakinfo.bundle.bcdata;
    payloadcount = bcdata.bc_payload_per_wave;
    payloadindex = var_56aff40dfda39956;
    playerangles = streakinfo.var_37a67976b515ddf;
    linelength = 2 * var_d0b84b2215b34610;
    payloadspacing = linelength / payloadcount;
    var_72de4512767467f6 = payloadspacing / 4;
    t = 1 / ( payloadcount - 1 ) * payloadindex;
    
    if ( !getdvarint( @"hash_7f32924c20b023ec", 0 ) )
    {
        x1 = var_ff2c40cf5f0d3cc8[ 0 ];
        y1 = var_ff2c40cf5f0d3cc8[ 1 ];
        forward = anglestoforward( playerangles );
        v2 = ( x1, y1, var_ff2c40cf5f0d3cc8[ 2 ] ) + var_d0b84b2215b34610 * forward;
        x2 = v2[ 0 ];
        y2 = v2[ 1 ];
        finalpoint = ( ( 1 - t ) * ( x1, y1, 0 )[ 0 ] + t * ( x2, y2, 0 )[ 0 ], ( 1 - t ) * ( x1, y1, 0 )[ 1 ] + t * ( x2, y2, 0 )[ 1 ], 0 );
        a3 = playerangles[ 1 ] + 90 * ( payloadindex % 2 == 0 ? -1 : 1 );
        d3 = var_72de4512767467f6;
    }
    else
    {
        a1 = -90 + playerangles[ 1 ];
        x1 = var_ff2c40cf5f0d3cc8[ 0 ] + var_d0b84b2215b34610 * cos( a1 );
        y1 = var_ff2c40cf5f0d3cc8[ 1 ] + var_d0b84b2215b34610 * sin( a1 );
        a2 = 90 + playerangles[ 1 ];
        x2 = var_ff2c40cf5f0d3cc8[ 0 ] + var_d0b84b2215b34610 * cos( a2 );
        y2 = var_ff2c40cf5f0d3cc8[ 1 ] + var_d0b84b2215b34610 * sin( a2 );
        finalpoint = ( ( 1 - t ) * ( x1, y1, 0 )[ 0 ] + t * ( x2, y2, 0 )[ 0 ], ( 1 - t ) * ( x1, y1, 0 )[ 1 ] + t * ( x2, y2, 0 )[ 1 ], 0 );
        a3 = playerangles[ 1 ];
        d3 = payloadindex % 2 == 0 ? -1 * var_72de4512767467f6 : var_72de4512767467f6;
    }
    
    x3 = finalpoint[ 0 ] + d3 * cos( a3 );
    y3 = finalpoint[ 1 ] + d3 * sin( a3 );
    return ( x3, y3, var_ff2c40cf5f0d3cc8[ 2 ] );
}

// Namespace bombardment_smoke
// Params 3
// Checksum 0xabe99e64, Offset: 0x4d8
// Size: 0x28
function function_cb413cc7d1b83efb( pos, streakinfo, missile )
{
    thread spawnsmoke( pos, streakinfo );
}

// Namespace bombardment_smoke
// Params 2
// Checksum 0x678f3137, Offset: 0x508
// Size: 0x10e
function spawnsmoke( pos, streakinfo )
{
    level endon( #"game_ended" );
    bundle = level.streakglobals.streakbundles[ "bombardment_smoke" ];
    smokescriptable = spawnscriptable( bundle.var_467fc15f214d4af9 ?? "wz_bombardment_smoke", pos );
    trigger = spawntrigger( pos, streakinfo );
    duration = bundle.var_3afb65845fc8ae3e;
    smokeid = utility::callsharedfunc( #"smokemanager", #"register", trigger, trigger.origin, trigger.radius, trigger.height, duration * 1000 );
    wait duration;
    smokescriptable freescriptable();
    smokescriptable notify( #"death" );
    utility::callsharedfunc( #"smokemanager", #"hash_8f0ee43079ae77e3", smokeid );
}

// Namespace bombardment_smoke
// Params 2
// Checksum 0xceb521a2, Offset: 0x61e
// Size: 0x14c
function spawntrigger( pos, streakinfo )
{
    bundle = streakinfo.bundle;
    radius = streakinfo.bundle.var_35568154ed5601b0;
    height = 100;
    duration = bundle.var_3afb65845fc8ae3e;
    trigger = spawn( "trigger_radius", pos, 0, radius, height );
    trigger.smokebundle = bundle;
    trigger.height = height;
    trigger.radius = radius;
    trigger.duration = duration;
    trigger ent_manager::registerspawn( 1, &sweepsmoke );
    trigger thread smoke_watchtriggerenter();
    trigger thread smoke_watchtriggerexit();
    trigger endon( #"death" );
    trigger.owner = self;
    trigger.team = self.team;
    
    /#
        if ( getdvarint( @"hash_bb931cd5c94cc5ad", 0 ) )
        {
            thread function_6c07e8d852573aa1( trigger, streakinfo.bundle.var_3afb65845fc8ae3e );
        }
    #/
    
    trigger thread function_79d0b426941eb5cc( duration );
    return trigger;
}

/#

    // Namespace bombardment_smoke
    // Params 2, eflags: 0x4
    // Checksum 0x307e3fbc, Offset: 0x773
    // Size: 0xae, Type: dev
    function private function_6c07e8d852573aa1( trigger, duration )
    {
        trigger endon( #"death" );
        radius = trigger.radius;
        height = trigger.height;
        durationms = duration * 1000;
        elapsedtime = 0;
        framedurationms = getframeduration();
        
        while ( elapsedtime < durationms )
        {
            cylinder( trigger.origin, trigger.origin + ( 0, 0, height ), radius );
            waitframe();
            elapsedtime += framedurationms;
        }
    }

#/

// Namespace bombardment_smoke
// Params 0, eflags: 0x4
// Checksum 0x7152dc76, Offset: 0x829
// Size: 0x74
function private smoke_watchtriggerenter()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"trigger", player );
        
        if ( !player )
        {
            continue;
        }
        
        if ( self.playersintrigger[ player getentitynumber() ] )
        {
            continue;
        }
        
        if ( isplayer( player ) )
        {
            self.playersintrigger[ player getentitynumber() ] = player;
            player thread smoke_onentertrigger( self );
        }
    }
}

// Namespace bombardment_smoke
// Params 0, eflags: 0x4
// Checksum 0x3e8d581d, Offset: 0x8a5
// Size: 0xd2
function private smoke_watchtriggerexit()
{
    self endon( #"death" );
    
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
            
            if ( player istouching( self ) )
            {
                continue;
            }
            
            self.playersintrigger[ player getentitynumber() ] = undefined;
            player smoke_onexittrigger( self );
        }
        
        waitframe();
    }
}

// Namespace bombardment_smoke
// Params 1
// Checksum 0xf9c31e3c, Offset: 0x97f
// Size: 0x1d1
function smoke_onentertrigger( trigger )
{
    entnum = trigger getentitynumber();
    
    if ( !isdefined( self.var_f7d4c6d621ac90af ) )
    {
        self.var_f7d4c6d621ac90af = [];
    }
    
    self.var_f7d4c6d621ac90af[ entnum ] = trigger;
    
    if ( !isdefined( self.var_a81548e57f6802f0 ) )
    {
        self.var_a81548e57f6802f0 = [];
    }
    
    if ( isagent( self ) )
    {
        self.in_smoke_grenade = 1;
    }
    
    if ( self.var_a81548e57f6802f0.size == 0 )
    {
        foreach ( perk in [ "specialty_blindeye", "specialty_snapshot_counter_smoke" ] )
        {
            utility::callsharedfunc( #"perk", #"giveperk", perk );
            self.var_a81548e57f6802f0[ self.var_a81548e57f6802f0.size ] = perk;
        }
    }
    
    if ( utility::callsharedfunc( #"smokemanager", #"hash_93bde91ae637affe" ) )
    {
        callback::callback( #"hash_68c2b2b3fda7e07f", { #bundle:trigger.smokegrenadebundle, #trigger:trigger, #player:self } );
    }
    else if ( trigger.smokegrenadebundle.var_9e40ef6aa8652378 )
    {
        utility::callsharedfunc( #"molotov", #"clearplayerburning", 1 );
        utility::callsharedfunc( #"napalm_strike", #"hash_50a3e263ce95377", 0.1, 1 );
    }
    
    return entnum;
}

// Namespace bombardment_smoke
// Params 1
// Checksum 0xb52fa3ae, Offset: 0xb59
// Size: 0x139
function smoke_onexittrigger( trigger )
{
    if ( self.var_f7d4c6d621ac90af )
    {
        self.var_f7d4c6d621ac90af[ trigger getentitynumber() ] = undefined;
    }
    
    var_db1fe4d80ea397e6 = self.var_f7d4c6d621ac90af && self.var_f7d4c6d621ac90af.size > 0;
    
    if ( isagent( self ) )
    {
        self.in_smoke_grenade = var_db1fe4d80ea397e6;
    }
    
    if ( !var_db1fe4d80ea397e6 && self.var_a81548e57f6802f0.size > 0 )
    {
        foreach ( perk in [ "specialty_blindeye", "specialty_snapshot_counter_smoke" ] )
        {
            utility::callsharedfunc( #"perk", #"removeperk", perk );
        }
        
        self.var_a81548e57f6802f0 = undefined;
    }
    
    callback::callback( #"playerexitsmoke", { #trigger:trigger, #player:self } );
}

// Namespace bombardment_smoke
// Params 0
// Checksum 0x7cf3124a, Offset: 0xc9a
// Size: 0x3d
function isreallyalive()
{
    return utility::issharedfuncdefined( #"player", #"isreallyalive" ) ? utility::callsharedfunc( #"player", #"isreallyalive" ) : isalive( self );
}

// Namespace bombardment_smoke
// Params 0, eflags: 0x4
// Checksum 0xc4a81e45, Offset: 0xce0
// Size: 0x11b
function private smoke_destroytrigger()
{
    foreach ( player in self.playersintrigger )
    {
        if ( !player )
        {
            continue;
        }
        
        self.playersintrigger[ player getentitynumber() ] = undefined;
        player smoke_onexittrigger( self );
    }
    
    ent_manager::deregisterspawn();
    
    if ( self )
    {
        if ( self.owner.gas_grenade_array )
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

// Namespace bombardment_smoke
// Params 2, eflags: 0x4
// Checksum 0xc595ec36, Offset: 0xe03
// Size: 0x5b
function private function_79d0b426941eb5cc( delaytime, var_7bf155b448f3de04 )
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
    
    thread smoke_destroytrigger();
}

// Namespace bombardment_smoke
// Params 0, eflags: 0x4
// Checksum 0xa39bb68a, Offset: 0xe66
// Size: 0x9
function private sweepsmoke()
{
    thread smoke_destroytrigger();
}

// Namespace bombardment_smoke
// Params 0
// Checksum 0x1082176e, Offset: 0xe77
// Size: 0x22
function function_80571fd11fc278e4()
{
    streakinfo = namespace_9d8e359c3b1041e5::createstreakinfosharedfunc( "bombardment_smoke", self );
    return function_60b2c0080907385d( streakinfo );
}

// Namespace bombardment_smoke
// Params 1
// Checksum 0x389daca5, Offset: 0xea2
// Size: 0x26
function function_60b2c0080907385d( streakinfo )
{
    return utility::callsharedfunc( #"bombardment_common", #"use", streakinfo );
}

