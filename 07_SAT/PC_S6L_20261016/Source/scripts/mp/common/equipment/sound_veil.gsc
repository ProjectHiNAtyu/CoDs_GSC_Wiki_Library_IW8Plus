// scripts\mp\common\equipment\sound_veil.gsc  (hash_6e1394801a4730cb.gscc) (size: 14249 Bytes / 0x37a9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfb87b8ff (4219975935)
// size ...... 14249 (0x37a9)
// includes .. 25  (offset: 0x340d)
// strings ... 40  (offset: 0x34d5)
// dev strs .. 2   (offset: 0x3791)
// exports ... 43  (offset: 0x1e79)
// cseg ...... 0x2ca + 0x1baf (0x1e79)
// imports ... 127 (offset: 0x2531)
// animtree1 . 0   (offset: 0x37a9)
// animtree2 . 0   (offset: 0x37a9)
#using scripts\anim\combat_utility;
#using scripts\common\ae_utility;
#using scripts\common\elevators;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\analyticslog;
#using scripts\mp\challenges;
#using scripts\mp\common\equipment\haywire;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\print;
#using scripts\mp\common\utility\shellshock_utility;
#using scripts\mp\damage;
#using scripts\mp\emp_debuff;
#using scripts\mp\ent_manager;
#using scripts\mp\entityheadicons;
#using scripts\mp\hud_message;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\shellshock;
#using scripts\mp\supers;
#using scripts\mp\weapons;

#namespace sound_veil;

// Namespace sound_veil
// Params 0, eflags: 0x1
// Checksum 0x14bca2c9, Offset: 0x2e8
// Size: 0x9
function autoexec main()
{
    soundveil_init();
}

// Namespace sound_veil
// Params 0
// Checksum 0xdffe576b, Offset: 0x2f9
// Size: 0x40
function soundveil_init()
{
    utility::flag_wait( "supers_initialized" );
    
    /#
        setdevdvarifuninitialized( @"hash_7ab7001b47624fdc", 0 );
        setdevdvarifuninitialized( @"hash_aa851e1cd1444734", 0 );
    #/
    
    weapons::registerusedcallback( "sound_veil", &soundveil_used );
}

// Namespace sound_veil
// Params 1
// Checksum 0xb1b30839, Offset: 0x341
// Size: 0x39a
function soundveil_used( grenade )
{
    grenade endon( #"death" );
    self endon( #"disconnect" );
    
    /#
        print::printgameaction( "<dev string:x24>", self );
    #/
    
    if ( !isdefined( level.soundveiltargets ) )
    {
        level.soundveiltargets = 0;
    }
    
    grenade ent_manager::registerspawn( 1, &soundveil_destroy );
    thread weapons::monitordisownedgrenade( self, grenade );
    grenade setscriptablepartstate( "visibility", "show", 0 );
    grenade waittill( #"missile_stuck", stuckto );
    
    if ( isdefined( stuckto ) && stuckto vehicle::is_vehicle() )
    {
        grenade.vehicle_stuck = 1;
    }
    
    if ( isdefined( level.var_59abd25eeb5b2fed ) )
    {
        canplant = grenade [[ level.var_59abd25eeb5b2fed ]]();
        
        if ( !canplant )
        {
            supers_mp::refundsuper();
            hud_message::showerrormessage( %"equipment/plant_failed" );
            grenade delete();
            return;
        }
    }
    
    grenade setscriptablepartstate( "plant", "active", 0 );
    grenade setotherent( self );
    grenade setnodeploy( 1 );
    grenade setnonstick( 1 );
    grenade.issuper = 1;
    grenade.superid = level.superglobals.staticsuperdata[ "super_sound_veil" ].id;
    grenade.usedcount = 0;
    grenade.deployingplayer = self;
    grenade.headiconid = entityheadicons::setheadicon_equipment( grenade );
    grenade.activetargets = [];
    trigger = spawn( "trigger_rotatable_radius", grenade.origin, 0, 80, 300 );
    trigger.angles = grenade.angles;
    grenade.trigger = trigger;
    trigger enablelinkto();
    trigger linkto( grenade );
    hasrugged = isdefined( self.perks[ "specialty_rugged_eqp" ] );
    weapons::onequipmentplanted( grenade, "sound_veil_mp", &soundveil_destroy );
    level thread weapons::monitordisownedequipment( self, grenade );
    grenade sentientpoolmanager::registersentient( "Tactical_Static", self );
    maxhealth = hasrugged ? 225 : 150;
    
    if ( isdefined( self.perks[ "specialty_mod_health_max" ] ) )
    {
        maxhealth = 225;
    }
    
    grenade thread damage::monitordamage( maxhealth, "hitequip", &soundveil_handlefataldamage, &soundveil_handledamage, 0 );
    grenade emp_debuff::set_apply_emp_callback( &soundveil_applyempcallback );
    
    if ( level.killstreak_emp_initialized )
    {
        grenade.ksempapplycallback = &soundveil_empapplied;
    }
    
    if ( level.killstreak_emp_initialized )
    {
        grenade.ksempclearcallback = &soundveil_empcleared;
    }
    
    grenade haywire::function_7f69a1eb3d590f76( &function_6cfe31269400c80a );
    grenade function_a4ebfb83ec0621b9( &soundveil_destroy );
    
    if ( isdefined( level.elevators ) )
    {
        foreach ( elevators in level.elevators )
        {
            elevators thread elevators::isentitytouchingdoortrigger( grenade );
        }
    }
    
    grenade soundveil_enable();
    challenges::function_a0936b0e5b4550f3( "super_sound_veil", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"use" ) );
}

// Namespace sound_veil
// Params 2
// Checksum 0x1b5adc24, Offset: 0x6e3
// Size: 0x74
function soundveil_watchtimeout( timeout, var_7ca82e2137d3005d )
{
    self endon( #"destroyed" );
    self notify( #"reset_timeout" );
    self endon( #"reset_timeout" );
    level endon( #"game_ended" );
    result = utility::waittill_any_timeout( timeout, "death" );
    
    if ( var_7ca82e2137d3005d )
    {
        function_e24d36d5426767f8();
        return;
    }
    
    soundveil_destroy();
}

// Namespace sound_veil
// Params 1
// Checksum 0xb4b8088a, Offset: 0x75f
// Size: 0x14b
function function_87f78ea8b7bf57c7( player )
{
    self endon( #"death" );
    self endon( #"destroyed" );
    self endon( #"missile_stuck" );
    player endon( #"disconnect" );
    msg = utility::waittill_any_timeout( 2, "touching_platform" );
    
    if ( msg == "timeout" )
    {
        return;
    }
    
    groundentity = undefined;
    ignoreents = vehicle_getarrayinradius( self.origin, 500, 500 );
    ignoreents[ ignoreents.size ] = self;
    tracecontents = trace::create_contents( 0, 1, 1, 1, 0, 1, 1, 0, 1 );
    tracestart = self.origin;
    var_fbaf852c9cb6dff8 = -2000;
    traceend = self.origin + ( 0, 0, var_fbaf852c9cb6dff8 );
    traceresults = trace::ray_trace( tracestart, traceend, ignoreents, tracecontents );
    groundentity = traceresults[ "entity" ];
    
    if ( isdefined( groundentity ) )
    {
        if ( utility::is_moving_platform_ent( groundentity ) )
        {
            self.origin += ( 0, 0, 1.6 );
            self linkto( groundentity );
        }
    }
}

// Namespace sound_veil
// Params 1
// Checksum 0x373ce7c8, Offset: 0x8b2
// Size: 0xa8
function soundveil_handledamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    modifieddamage = damage;
    modifieddamage = utility::handlemeleedamage( objweapon, type, modifieddamage );
    modifieddamage = damage::handleapdamage( objweapon, type, modifieddamage, attacker );
    
    if ( !isagent( attacker ) )
    {
        weapons::equipmenthit( self.owner, attacker, objweapon, type );
    }
    
    return modifieddamage;
}

// Namespace sound_veil
// Params 1
// Checksum 0xdc8e3698, Offset: 0x963
// Size: 0x5c
function soundveil_handlefataldamage( data )
{
    attacker = data.attacker;
    
    if ( isplayer( attacker ) && player_utility::playersareenemies( self.owner, attacker ) )
    {
        attacker thread points::doscoreevent( #"destroyed_equipment" );
    }
    
    soundveil_destroy( data );
}

// Namespace sound_veil
// Params 1
// Checksum 0xa7e4f996, Offset: 0x9c7
// Size: 0xc1
function soundveil_destroy( data )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    hasattacker = 0;
    
    if ( isdefined( data ) && isdefined( data.attacker ) )
    {
        hasattacker = 1;
        soundveil_givepointsfordeath( data.attacker );
    }
    
    if ( isdefined( self.headiconid ) )
    {
        entityheadicons::setheadicon_deleteicon( self.headiconid );
    }
    
    if ( isdefined( self.navobstacle ) )
    {
        destroynavobstacle( self.navobstacle );
    }
    
    function_5def8499aa94fcf3();
    thread soundveil_delete( hasattacker );
    self setscriptablepartstate( "activate", "neutral", 0 );
    self setscriptablepartstate( "destroy", "active", 0 );
    self notify( #"destroyed" );
}

// Namespace sound_veil
// Params 1
// Checksum 0xbc9cc534, Offset: 0xa90
// Size: 0xe2
function soundveil_delete( wasdestroyed )
{
    self endon( #"death" );
    
    if ( !isdefined( self ) )
    {
        /#
            iprintln( "<dev string:x37>" );
        #/
    }
    
    self.exploding = 1;
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger delete();
    }
    
    if ( isplayer( self.owner ) )
    {
        self.owner challenges::function_a0936b0e5b4550f3( "super_sound_veil", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"end" ), self.usedcount );
        analyticslog::logevent_fieldupgradeexpired( self.owner, self.superid, self.usedcount, istrue( wasdestroyed ) );
        self.owner weapons::removeequip( self );
    }
    
    wait 2;
    ent_manager::deregisterspawn();
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace sound_veil
// Params 1
// Checksum 0x1e44ef1e, Offset: 0xb7a
// Size: 0x3c
function soundveil_givepointsfordeath( attacker )
{
    if ( isplayer( attacker ) && player_utility::playersareenemies( self.owner, attacker ) )
    {
        attacker thread points::doscoreevent( #"destroyed_equipment" );
    }
}

// Namespace sound_veil
// Params 1
// Checksum 0x1bc598e0, Offset: 0xbbe
// Size: 0xaf
function soundveil_applyempcallback( data )
{
    if ( !( isdefined( data ) && isdefined( data.victim ) ) )
    {
        return;
    }
    
    data.victim endon( #"death" );
    data.victim endon( #"destroyed" );
    data.victim setscriptablepartstate( "empd", "active", 0 );
    data.victim soundveil_disable();
    wait 6;
    data.victim setscriptablepartstate( "empd", "neutral", 0 );
    data.victim soundveil_enable();
}

// Namespace sound_veil
// Params 1
// Checksum 0x81a317dd, Offset: 0xc75
// Size: 0x7c
function soundveil_empapplied( data )
{
    if ( !( isdefined( data ) && isdefined( data.victim ) ) )
    {
        return;
    }
    
    data.victim endon( #"death" );
    data.victim endon( #"destroyed" );
    data.victim setscriptablepartstate( "empd", "active", 0 );
    data.victim soundveil_disable();
}

// Namespace sound_veil
// Params 1
// Checksum 0xada3a0be, Offset: 0xcf9
// Size: 0x39
function soundveil_empcleared( data )
{
    data.victim setscriptablepartstate( "empd", "neutral", 0 );
    data.victim soundveil_enable();
}

// Namespace sound_veil
// Params 1
// Checksum 0x2af8eaf9, Offset: 0xd3a
// Size: 0x15
function function_6cfe31269400c80a( data )
{
    soundveil_destroy( data );
}

// Namespace sound_veil
// Params 0
// Checksum 0xaddb1c26, Offset: 0xd57
// Size: 0xb1
function soundveil_enable()
{
    self notify( "enable_" + "super_sound_veil" );
    self setscriptablepartstate( "arm", "active", 0 );
    
    if ( !self.var_90732c8e0fed98f5 && !self.ignoretimeout )
    {
        defaulttimeout = 60;
        
        if ( isbrgamemode() )
        {
            defaulttimeout = 480;
        }
        
        timeoverride = getdvarint( @"hash_aa851e1cd1444734", 0 );
        
        if ( timeoverride > 0 )
        {
            defaulttimeout = timeoverride;
        }
        
        thread soundveil_watchtimeout( defaulttimeout );
    }
    
    if ( self.triggered )
    {
        self setscriptablepartstate( "activate", "active", 0 );
    }
    
    thread function_e85fdf1793e44252();
    self.var_90732c8e0fed98f5 = 1;
}

// Namespace sound_veil
// Params 0
// Checksum 0xf95359f0, Offset: 0xe10
// Size: 0x29d
function function_e85fdf1793e44252()
{
    self endon( #"death" );
    self endon( #"destroyed" );
    self endon( "disable_" + "super_sound_veil" );
    level endon( #"game_ended" );
    self.triggeredents = [];
    
    while ( true )
    {
        self.trigger waittill( #"trigger", triggeredent );
        teamtocheck = triggeredent.team;
        
        if ( !isdefined( teamtocheck ) && isagent( triggeredent ) && isdefined( triggeredent.agentteam ) )
        {
            teamtocheck = triggeredent.agentteam;
        }
        
        if ( teamtocheck == self.owner.team )
        {
            continue;
        }
        
        if ( isagent( triggeredent ) && !arraycontains( self.triggeredents, triggeredent ) )
        {
            if ( self.var_4e0442d9d220816e && !function_c47e5b7eefc84b7e( triggeredent ) )
            {
                continue;
            }
            
            self.triggeredents[ self.triggeredents.size ] = triggeredent;
            triggeredent combat_utility::flashbangstart( 3 );
        }
        
        if ( !self.triggered )
        {
            if ( !function_d0bee71cefc698b7( triggeredent ) )
            {
                continue;
            }
            
            self.triggered = 1;
            thread soundveil_watchtimeout( 20, istrue( self.ignoretimeout ) );
            
            if ( triggeredent.var_c5bc305e9193319f )
            {
                weapons::explosivetrigger( triggeredent, 0 );
            }
            
            self setscriptablepartstate( "trigger", "active", 0 );
            wait 0.35;
            self setscriptablepartstate( "activate", "active", 0 );
            shellshock::grenade_earthquakeatposition( self.origin, 0.25 );
            
            if ( !isdefined( self.vehicle_stuck ) && !isdefined( self.navobstacle ) )
            {
                half_height = 150;
                half_depth = 20;
                up_vec = anglestoup( self.angles );
                shape_center = self.origin + up_vec * half_height - up_vec * half_depth;
                
                if ( game_utility::getgametype() == "koth_horde" )
                {
                    badplace_teams = [ "axis", "allies" ];
                    self.navobstacle = createnavbadplacebyshape( shape_center, self.angles, 8, 90, half_height + 40, badplace_teams );
                }
                else
                {
                    self.navobstacle = createnavbadplacebyshape( shape_center, self.angles, 8, 90, half_height + 40 );
                }
            }
            
            continue;
        }
        
        function_f2424dc679d6e00b( triggeredent );
    }
}

// Namespace sound_veil
// Params 1
// Checksum 0xb2859626, Offset: 0x10b5
// Size: 0xf9, Type: bool
function function_d0bee71cefc698b7( potentialtarget )
{
    if ( potentialtarget vehicle::is_vehicle() )
    {
        if ( !isdefined( potentialtarget.streakinfo ) )
        {
            vehicle = potentialtarget;
            vehicleoccupants = vehicle_occupancy::get_all_occupants( vehicle );
            var_2feff2edc6221bf5 = 0;
            
            if ( vehicleoccupants.size > 0 )
            {
                foreach ( occupant in vehicleoccupants )
                {
                    if ( !function_cf4206e77f466733( occupant, 1 ) )
                    {
                        continue;
                    }
                    
                    var_2feff2edc6221bf5 = 1;
                    break;
                }
            }
            
            if ( !var_2feff2edc6221bf5 )
            {
                return false;
            }
        }
        else
        {
            return false;
        }
    }
    else if ( !function_cf4206e77f466733( potentialtarget ) )
    {
        return false;
    }
    
    return true;
}

// Namespace sound_veil
// Params 3
// Checksum 0x76457442, Offset: 0x11b7
// Size: 0x5f, Type: bool
function function_cf4206e77f466733( potentialtarget, ignoresight, var_748446359a497159 )
{
    if ( !function_b6fa0487aac491a1( potentialtarget, var_748446359a497159 ) )
    {
        return false;
    }
    
    if ( function_edbf33e037c889d7( potentialtarget ) )
    {
        return false;
    }
    
    if ( !function_b36dcabb590d213b( potentialtarget ) && !ignoresight )
    {
        return false;
    }
    
    if ( !soundveil_istargetinrange( potentialtarget ) )
    {
        return false;
    }
    
    return true;
}

// Namespace sound_veil
// Params 1
// Checksum 0xb3d89ad0, Offset: 0x121f
// Size: 0x18, Type: bool
function function_edbf33e037c889d7( potentialtarget )
{
    return istrue( potentialtarget.var_15ebf31c939a06a6 );
}

// Namespace sound_veil
// Params 1
// Checksum 0x986843d2, Offset: 0x1240
// Size: 0x27, Type: bool
function function_b36dcabb590d213b( potentialtarget )
{
    if ( !isdefined( potentialtarget ) )
    {
        return false;
    }
    
    return potentialtarget sightconetrace( self.origin, self ) > 0;
}

// Namespace sound_veil
// Params 1
// Checksum 0x6593f28b, Offset: 0x1270
// Size: 0x4c, Type: bool
function soundveil_istargetinrange( potentialtarget )
{
    if ( ( isplayer( potentialtarget ) || isagent( potentialtarget ) ) && potentialtarget vehicle::is_in_vehicle() )
    {
        potentialtarget = potentialtarget vehicle::get_vehicle();
    }
    
    if ( !potentialtarget istouching( self.trigger ) )
    {
        return false;
    }
    
    return true;
}

// Namespace sound_veil
// Params 3
// Checksum 0x5bd232d3, Offset: 0x12c5
// Size: 0xa4, Type: bool
function function_dc024ac69e0e4718( potentialtarget, var_748446359a497159, var_d604f86de893c726 )
{
    if ( !player::isreallyalive( potentialtarget ) )
    {
        return false;
    }
    
    if ( level.teambased )
    {
        if ( potentialtarget.team == self.owner.team )
        {
            if ( potentialtarget == self.owner )
            {
                if ( var_748446359a497159 || var_d604f86de893c726 )
                {
                    return true;
                }
            }
        }
        else
        {
            return true;
        }
    }
    else if ( potentialtarget == self.owner )
    {
        if ( var_748446359a497159 || var_d604f86de893c726 )
        {
            return true;
        }
    }
    else
    {
        return true;
    }
    
    return false;
}

// Namespace sound_veil
// Params 1
// Checksum 0xf378083c, Offset: 0x1372
// Size: 0xb8, Type: bool
function function_c47e5b7eefc84b7e( potentialtarget )
{
    if ( isdefined( potentialtarget.agent_type ) && issubstr( potentialtarget.agent_type, "civilian" ) )
    {
        return false;
    }
    
    if ( !potentialtarget.isactive )
    {
        return false;
    }
    
    teamtocheck = potentialtarget.team;
    
    if ( !isdefined( teamtocheck ) && isagent( potentialtarget ) && isdefined( potentialtarget.agentteam ) )
    {
        teamtocheck = potentialtarget.agentteam;
    }
    
    if ( isdefined( teamtocheck ) && potentialtarget.team == self.owner.team )
    {
        return false;
    }
    
    return true;
}

// Namespace sound_veil
// Params 2
// Checksum 0x206e9118, Offset: 0x1433
// Size: 0x72, Type: bool
function function_b6fa0487aac491a1( potentialtarget, var_748446359a497159 )
{
    var_d604f86de893c726 = 0;
    
    /#
        var_d604f86de893c726 = getdvarint( @"hash_7ab7001b47624fdc", 0 );
    #/
    
    if ( !isdefined( potentialtarget ) )
    {
        return false;
    }
    
    if ( isplayer( potentialtarget ) && !function_dc024ac69e0e4718( potentialtarget, var_748446359a497159, var_d604f86de893c726 ) )
    {
        return false;
    }
    
    if ( isagent( potentialtarget ) && !function_c47e5b7eefc84b7e( potentialtarget ) )
    {
        return false;
    }
    
    return true;
}

// Namespace sound_veil
// Params 1
// Checksum 0xf70ae029, Offset: 0x14ae
// Size: 0x1a5
function function_f2424dc679d6e00b( enemytarget )
{
    shocktargets = [];
    
    if ( enemytarget vehicle::is_vehicle() )
    {
        if ( !isdefined( enemytarget.streakinfo ) )
        {
            vehicleoccupants = vehicle_occupancy::get_all_occupants( enemytarget );
            
            if ( vehicleoccupants.size > 0 )
            {
                foreach ( occupant in vehicleoccupants )
                {
                    if ( function_cf4206e77f466733( occupant, 1, 1 ) )
                    {
                        shocktargets[ shocktargets.size ] = occupant;
                    }
                }
            }
        }
        else
        {
            return;
        }
    }
    else if ( function_cf4206e77f466733( enemytarget, undefined, 1 ) )
    {
        shocktargets[ shocktargets.size ] = enemytarget;
    }
    
    foreach ( target in shocktargets )
    {
        if ( !isdefined( target ) )
        {
            continue;
        }
        
        function_90ec6f7d2bf6ba7e( target );
        enemytargetid = soundveil_generateid( target );
        function_62487d71d6dc99b0( target, enemytargetid );
        thread function_a10fb4a590302ecc( target, enemytargetid );
        
        if ( isplayer( target ) && !isbot( target ) )
        {
            function_3e6fc8f47953e593( target, enemytargetid );
        }
    }
}

// Namespace sound_veil
// Params 1
// Checksum 0xb6e78e2e, Offset: 0x165b
// Size: 0x5c
function soundveil_generateid( target )
{
    level.soundveiltargets++;
    enemytargetid = 0;
    
    if ( isplayer( target ) && !isbot( target ) )
    {
        enemytargetid = target getxuid();
    }
    else
    {
        enemytargetid = target getentitynumber();
    }
    
    return enemytargetid + "_" + level.soundveiltargets;
}

// Namespace sound_veil
// Params 2
// Checksum 0xaa3988f1, Offset: 0x16c0
// Size: 0x187
function function_a10fb4a590302ecc( enemytarget, enemytargetid )
{
    self endon( #"death" );
    self endon( #"destroyed" );
    self endon( "lost_target_" + enemytargetid );
    self endon( "disable_" + "super_sound_veil" );
    level endon( #"game_ended" );
    var_d604f86de893c726 = 0;
    
    /#
        var_d604f86de893c726 = getdvarint( @"hash_7ab7001b47624fdc", 0 );
        
        if ( var_d604f86de893c726 == 2 )
        {
            return;
        }
    #/
    
    if ( isplayer( enemytarget ) && isplayer( self.owner ) && enemytarget != self.owner )
    {
        self.owner thread points::doscoreevent( #"sound_veil_effect" );
    }
    
    while ( isdefined( enemytarget ) )
    {
        shockfile = %"sound_veil_mp";
        
        if ( isplayer( enemytarget ) )
        {
            if ( isdefined( enemytarget.perks[ "specialty_tac_resist" ] ) || isdefined( enemytarget.perks[ "specialty_tac_resist_br" ] ) )
            {
                shockfile = %"sound_veil_reduced_mp";
            }
        }
        
        if ( isplayer( enemytarget ) || isagent( enemytarget ) )
        {
            enemytarget shellshock_utility_cpmp::_shellshock( shockfile, #"stun", 0.5, 0 );
        }
        
        if ( isdefined( self.owner ) )
        {
            enemytarget dodamage( 1, self.origin, self.owner, self, "MOD_EXPLOSIVE", self.weapon_object, "torso_upper" );
        }
        
        wait 0.5;
    }
}

// Namespace sound_veil
// Params 2
// Checksum 0xce05ddc4, Offset: 0x184f
// Size: 0x35
function function_3e6fc8f47953e593( enemytarget, enemytargetid )
{
    if ( enemytarget utility::isusingremote() )
    {
        thread function_700be5cb9bbf091e( enemytarget, enemytargetid );
        return;
    }
    
    thread function_ad6af304c6bb34bc( enemytarget, enemytargetid );
}

// Namespace sound_veil
// Params 2
// Checksum 0x257278b0, Offset: 0x188c
// Size: 0x72
function function_700be5cb9bbf091e( enemytarget, enemytargetid )
{
    self endon( #"death" );
    self endon( #"destroyed" );
    self endon( "lost_target_" + enemytargetid );
    self endon( "disable_" + "super_sound_veil" );
    level endon( #"game_ended" );
    
    while ( isdefined( enemytarget ) && enemytarget utility::isusingremote() )
    {
        waitframe();
    }
    
    thread function_ad6af304c6bb34bc( enemytarget, enemytargetid );
}

// Namespace sound_veil
// Params 2
// Checksum 0x5e21e859, Offset: 0x1906
// Size: 0xdd
function function_ad6af304c6bb34bc( enemytarget, enemytargetid )
{
    level endon( #"game_ended" );
    var_d604f86de893c726 = 0;
    
    /#
        var_d604f86de893c726 = getdvarint( @"hash_7ab7001b47624fdc", 0 );
        
        if ( var_d604f86de893c726 == 2 )
        {
            return;
        }
    #/
    
    shakeoverride = "player_soundveil_shake_mp";
    var_1d38d06d1b0dc98 = 5;
    
    if ( isdefined( enemytarget.perks[ "specialty_tac_resist" ] ) )
    {
        shakeoverride = "player_soundveil_shake_reduced_mp";
        var_1d38d06d1b0dc98 = 3;
    }
    
    player_utility::function_99d180c3f0ca93b8( enemytarget, shakeoverride, 1 );
    enemytarget emp_debuff::play_emp_scramble( var_1d38d06d1b0dc98 );
    level utility::waittill_any_ents( self, "death", self, "destroyed", self, "lost_target_" + enemytargetid, self, "disable_" + "super_sound_veil" );
    
    if ( isdefined( enemytarget ) )
    {
        player_utility::function_c14762bb6e0b4edb( enemytarget );
        enemytarget emp_debuff::stop_emp_scramble( var_1d38d06d1b0dc98 );
    }
}

// Namespace sound_veil
// Params 2
// Checksum 0x497fd2fb, Offset: 0x19eb
// Size: 0x3d
function function_62487d71d6dc99b0( enemytarget, enemytargetid )
{
    thread function_6345b8f65c38f78b( enemytarget, enemytargetid );
    thread function_855222dc86396ca0( enemytarget, enemytargetid );
    thread function_1bf5daf17558bcd0( enemytarget, enemytargetid );
    thread function_1406cb05a6997336( enemytarget, enemytargetid );
}

// Namespace sound_veil
// Params 2
// Checksum 0x3223c3d6, Offset: 0x1a30
// Size: 0x8a
function function_855222dc86396ca0( enemytarget, enemytargetid )
{
    self endon( #"death" );
    self endon( #"destroyed" );
    self endon( "lost_target_" + enemytargetid );
    self endon( "disable_" + "super_sound_veil" );
    level endon( #"game_ended" );
    
    if ( isplayer( enemytarget ) )
    {
        enemytarget utility::waittill_any( "death_or_disconnect", "killed_player" );
    }
    else
    {
        enemytarget waittill( #"death" );
    }
    
    self notify( "lost_target_" + enemytargetid );
}

// Namespace sound_veil
// Params 2
// Checksum 0x7c059f3c, Offset: 0x1ac2
// Size: 0x95
function function_1bf5daf17558bcd0( enemytarget, enemytargetid )
{
    self endon( #"death" );
    self endon( #"destroyed" );
    self endon( "lost_target_" + enemytargetid );
    self endon( "disable_" + "super_sound_veil" );
    level endon( #"game_ended" );
    
    while ( isdefined( enemytarget ) )
    {
        if ( !isdefined( enemytarget.vehicle ) )
        {
            if ( !function_b36dcabb590d213b( enemytarget ) )
            {
                break;
            }
        }
        
        if ( !soundveil_istargetinrange( enemytarget ) )
        {
            break;
        }
        
        waitframe();
    }
    
    self notify( "lost_target_" + enemytargetid );
}

// Namespace sound_veil
// Params 2
// Checksum 0xc99b5001, Offset: 0x1b5f
// Size: 0x6b
function function_1406cb05a6997336( enemytarget, enemytargetid )
{
    self endon( #"death" );
    self endon( #"destroyed" );
    self endon( "lost_target_" + enemytargetid );
    self endon( "disable_" + "super_sound_veil" );
    level endon( #"game_ended" );
    enemytarget waittill( #"using_remote" );
    self notify( "lost_target_" + enemytargetid );
}

// Namespace sound_veil
// Params 2
// Checksum 0xcffe205e, Offset: 0x1bd2
// Size: 0x5c
function function_6345b8f65c38f78b( enemytarget, enemytargetid )
{
    self endon( #"death" );
    self endon( #"destroyed" );
    level endon( #"game_ended" );
    utility::waittill_any( "lost_target_" + enemytargetid, "disable_" + "super_sound_veil" );
    function_59a6644c2ce364d9( enemytarget );
}

// Namespace sound_veil
// Params 0
// Checksum 0x47c3eb3f, Offset: 0x1c36
// Size: 0x32
function soundveil_disable()
{
    self notify( "disable_" + "super_sound_veil" );
    self setscriptablepartstate( "activate", "neutral", 0 );
    self setscriptablepartstate( "arm", "neutral", 0 );
}

// Namespace sound_veil
// Params 0
// Checksum 0xc95362bf, Offset: 0x1c70
// Size: 0x35
function function_e24d36d5426767f8()
{
    self setscriptablepartstate( "arm", "active", 0 );
    self setscriptablepartstate( "activate", "neutral", 0 );
    self setscriptablepartstate( "trigger", "neutral", 0 );
}

// Namespace sound_veil
// Params 1
// Checksum 0x8f9a31e5, Offset: 0x1cad
// Size: 0x3b
function function_90ec6f7d2bf6ba7e( enemytarget )
{
    enemytarget.var_15ebf31c939a06a6 = 1;
    self.usedcount++;
    self.activetargets[ self.activetargets.size ] = enemytarget;
}

// Namespace sound_veil
// Params 1
// Checksum 0xdddad8a7, Offset: 0x1cf0
// Size: 0x9c, Type: bool
function soundveil_isactivetarget( enemytarget )
{
    if ( isdefined( self ) && self.activetargets.size > 0 )
    {
        foreach ( target in self.activetargets )
        {
            if ( target == enemytarget )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace sound_veil
// Params 1
// Checksum 0x3b77b78f, Offset: 0x1d95
// Size: 0x35
function function_59a6644c2ce364d9( enemytarget )
{
    if ( isdefined( enemytarget ) )
    {
        enemytarget.var_15ebf31c939a06a6 = undefined;
        self.activetargets = arrayremove( self.activetargets, enemytarget );
    }
}

// Namespace sound_veil
// Params 0
// Checksum 0x5a042f7b, Offset: 0x1dd2
// Size: 0x88
function function_5def8499aa94fcf3()
{
    if ( isdefined( self.activetargets ) )
    {
        foreach ( target in self.activetargets )
        {
            function_59a6644c2ce364d9( target );
        }
    }
}

// Namespace sound_veil
// Params 1
// Checksum 0x81a416c0, Offset: 0x1e62
// Size: 0x17
function function_a4ebfb83ec0621b9( callbackfunction )
{
    self.elevatordoorsclosecallback = callbackfunction;
}

