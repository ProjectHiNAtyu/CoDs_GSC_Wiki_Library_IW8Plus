// scripts\mp\common\utility\turret_utility.gsc  (hash_1f6a792c29b7d762.gscc) (size: 7970 Bytes / 0x1f22 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xeee9f164 (4008309092)
// size ...... 7970 (0x1f22)
// includes .. 7   (offset: 0x1dea)
// strings ... 13  (offset: 0x1e22)
// dev strs .. 8   (offset: 0x1ec2)
// exports ... 28  (offset: 0x1356)
// cseg ...... 0x108 + 0x124e (0x1356)
// imports ... 53  (offset: 0x17b6)
// animtree1 . 0   (offset: 0x1f22)
// animtree2 . 0   (offset: 0x1f22)
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\common\utility\player;
#using scripts\mp\parachute;

#namespace turret;

// Namespace turret
// Params 2
// Checksum 0xb836dcdd, Offset: 0x126
// Size: 0x81
function function_537d073bfb1366da( bundle, owner )
{
    if ( isdefined( bundle.var_8dec6bdc3a708bc6 ) )
    {
        self.var_7e833ce89ba46839 = [];
    }
    
    if ( isdefined( bundle.var_4cd82218d59d492a ) )
    {
        self.var_c1832d5edbcefa3c = [];
        
        if ( isdefined( owner ) )
        {
            self.var_b0a0f8d2fdc2409 = { #turretparent:self };
            owner callback::add( #"player_death", &function_880cc87a06ca99ae, self.var_b0a0f8d2fdc2409 );
        }
    }
}

// Namespace turret
// Params 1
// Checksum 0xef7a5d0a, Offset: 0x1af
// Size: 0x3f
function function_2ef86cb867c53ac1( owner )
{
    if ( isdefined( self.var_b0a0f8d2fdc2409 ) && isdefined( owner ) )
    {
        owner callback::remove( #"player_death", &function_880cc87a06ca99ae, self.var_b0a0f8d2fdc2409 );
    }
}

// Namespace turret
// Params 12
// Checksum 0x6a32f114, Offset: 0x1f6
// Size: 0x43a
function turret_getbesttargetdata( turret, bundle, var_6ba2083bab22fff2, var_4ec56492318cf21c, enabletargetlaststand, var_3b13f6a44b83d17f, cleartargetnotify, var_dda8afbd724672cd, var_1a666f31388d53fb, var_ed01e7f61132fd88, ignoreplayerteam, var_1f4b702d01f0df0c )
{
    if ( !isdefined( turret ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    validtargetsdata = function_d598d19fc388ec1b( turret, bundle, var_6ba2083bab22fff2, var_4ec56492318cf21c, enabletargetlaststand, var_3b13f6a44b83d17f, var_dda8afbd724672cd, var_1a666f31388d53fb, ignoreplayerteam, var_1f4b702d01f0df0c );
    bestyaw = 99999;
    besttargetdata = undefined;
    now = gettime();
    var_f12fea9107651f4a = isdefined( turret.owner ) ? turret.owner.guid : "";
    sourceent = turret;
    var_7182eed8003e6900 = turret getlinkedparent();
    
    if ( isdefined( var_7182eed8003e6900 ) )
    {
        sourceent = var_7182eed8003e6900;
    }
    
    sourceangle = angleclamp180( sourceent gettagangles( "tag_origin" )[ 1 ] );
    
    foreach ( targetdata in validtargetsdata )
    {
        targetplayer = function_93d9d997ab45c443( targetdata );
        
        if ( !turret_isvalidtarget( turret, bundle, targetplayer, var_6ba2083bab22fff2, var_4ec56492318cf21c, enabletargetlaststand, var_3b13f6a44b83d17f, var_dda8afbd724672cd, var_1a666f31388d53fb, ignoreplayerteam, var_1f4b702d01f0df0c ) )
        {
            continue;
        }
        
        targetvehicle = function_9d37296f838c74c6( targetdata );
        angle = angleclamp180( vectortoangles( targetplayer.origin - sourceent.origin )[ 1 ] );
        angle = abs( angle - sourceangle );
        
        if ( !var_ed01e7f61132fd88 )
        {
            weaponsarray = targetplayer getweaponslistitems();
            
            foreach ( weapon in weaponsarray )
            {
                weaponclassname = weaponclass( weapon );
                
                if ( weaponclassname == "rocketlauncher" )
                {
                    angle -= 40;
                }
            }
        }
        
        if ( isdefined( targetvehicle ) )
        {
            angle += 20;
        }
        else if ( isdefined( bundle ) )
        {
            priorityapplied = 0;
            targetplayerguid = targetplayer.guid;
            
            if ( isdefined( sourceent.var_c1832d5edbcefa3c ) && isdefined( targetplayerguid ) )
            {
                if ( !isdefined( sourceent.var_c1832d5edbcefa3c[ targetplayerguid ] ) ? 0 : now - sourceent.var_c1832d5edbcefa3c[ targetplayerguid ] < 3000 )
                {
                    angle += bundle.var_4cd82218d59d492a ?? 0;
                    priorityapplied = 1;
                }
            }
            
            if ( !priorityapplied && isdefined( targetplayer.damagedplayers ) )
            {
                if ( !isdefined( targetplayer.damagedplayers[ var_f12fea9107651f4a ] ) ? 0 : now - targetplayer.damagedplayers[ var_f12fea9107651f4a ] < 7000 )
                {
                    angle += bundle.var_ecfc2ed5e0a5c44a ?? 0;
                    priorityapplied = 1;
                }
            }
            
            if ( !priorityapplied && isdefined( sourceent.var_7e833ce89ba46839 ) && isdefined( targetplayerguid ) )
            {
                if ( !isdefined( sourceent.var_7e833ce89ba46839[ targetplayerguid ] ) ? 0 : now - sourceent.var_7e833ce89ba46839[ targetplayerguid ] < 8000 )
                {
                    angle += bundle.var_8dec6bdc3a708bc6 ?? 0;
                    priorityapplied = 1;
                }
            }
        }
        
        if ( bestyaw > angle )
        {
            bestyaw = angle;
            besttargetdata = targetdata;
        }
    }
    
    if ( isdefined( besttargetdata ) && isdefined( cleartargetnotify ) )
    {
        turret thread function_dd9bac00c9444681( besttargetdata, cleartargetnotify );
    }
    
    return besttargetdata;
}

// Namespace turret
// Params 2
// Checksum 0xe6201f20, Offset: 0x639
// Size: 0x74
function turret_settarget( turret, targetdata )
{
    if ( !isdefined( turret ) )
    {
        assertmsg( "<dev string:x5e>" );
        return;
    }
    
    turret.currenttarget = function_93d9d997ab45c443( targetdata );
    
    if ( isdefined( turret.var_9cc64b926699342e ) && !turret.var_9cc64b926699342e )
    {
        turret setturrettargetent( turret.currenttarget, undefined, 0 );
    }
}

// Namespace turret
// Params 1
// Checksum 0xf65f0e8, Offset: 0x6b5
// Size: 0x2f
function turret_cleartarget( turret )
{
    if ( !isdefined( turret ) )
    {
        assertmsg( "<dev string:x94>" );
        return;
    }
    
    turret.currenttarget = undefined;
}

// Namespace turret
// Params 2
// Checksum 0x9c744000, Offset: 0x6ec
// Size: 0x3b
function turret_settargetstate( turret, targetstate )
{
    if ( !isdefined( turret ) )
    {
        assertmsg( "<dev string:xce>" );
        return;
    }
    
    turret.targetstate = targetstate;
}

// Namespace turret
// Params 1
// Checksum 0x2a3706de, Offset: 0x72f
// Size: 0x4f
function function_e26a8e0a98e84a3f( turret )
{
    if ( !isdefined( turret ) )
    {
        assertmsg( "<dev string:x10f>" );
        return;
    }
    
    if ( !isdefined( turret.targetstate ) )
    {
        assertmsg( "<dev string:x150>" );
    }
    
    return turret.targetstate;
}

// Namespace turret
// Params 1
// Checksum 0x232bdec8, Offset: 0x787
// Size: 0x1e, Type: bool
function turret_hastarget( turret )
{
    return isdefined( turret ) && isdefined( turret.currenttarget );
}

// Namespace turret
// Params 2
// Checksum 0x9439d41e, Offset: 0x7ae
// Size: 0x4a
function function_8202b7c43f73cc3b( turret, target )
{
    activetarget = 0;
    
    if ( !isdefined( target ) )
    {
        return 0;
    }
    
    currenttarget = function_f459998ab742b981( turret );
    
    if ( currenttarget == target )
    {
        activetarget = 1;
    }
    
    return activetarget;
}

// Namespace turret
// Params 1
// Checksum 0x7e107d4c, Offset: 0x801
// Size: 0x26
function function_f459998ab742b981( turret )
{
    return turret_hastarget( turret ) ? turret.currenttarget : undefined;
}

// Namespace turret
// Params 1
// Checksum 0x7397e305, Offset: 0x830
// Size: 0x2f
function function_93d9d997ab45c443( targetdata )
{
    if ( !isdefined( targetdata ) )
    {
        assertmsg( "<dev string:x1e9>" );
        return;
    }
    
    return targetdata.targetplayer;
}

// Namespace turret
// Params 1
// Checksum 0x6ef65669, Offset: 0x868
// Size: 0x2f
function function_9d37296f838c74c6( targetdata )
{
    if ( !isdefined( targetdata ) )
    {
        assertmsg( "<dev string:x266>" );
        return;
    }
    
    return targetdata.targetvehicle;
}

// Namespace turret
// Params 3
// Checksum 0x18abbb37, Offset: 0x8a0
// Size: 0x1b6
function turret_canseetarget( turret, potentialtarget, var_4b3d856fb1fd4317 )
{
    contentsoverride = function_ff4fa477bcdf5f49();
    var_847f780b10d918e5 = [ turret ];
    var_cff7c82b0208a00c = 0;
    
    if ( var_4b3d856fb1fd4317 )
    {
        var_cff7c82b0208a00c = potentialtarget vehicle::is_in_vehicle();
        
        if ( var_cff7c82b0208a00c )
        {
            occupiedvehicle = potentialtarget vehicle::get_vehicle();
            var_847f780b10d918e5[ var_847f780b10d918e5.size ] = occupiedvehicle;
            linkedmodels = occupiedvehicle getlinkedchildren();
            
            if ( linkedmodels.size > 0 )
            {
                var_847f780b10d918e5 = arraycombine( var_847f780b10d918e5, linkedmodels );
            }
        }
    }
    
    tracelist = [];
    
    if ( isplayer( potentialtarget ) || isagent( potentialtarget ) )
    {
        headpos = potentialtarget gettagorigin( "j_head", 1 );
        
        if ( isdefined( headpos ) )
        {
            tracelist[ tracelist.size ] = headpos;
        }
        
        midpos = potentialtarget gettagorigin( "j_mainroot", 1 );
        
        if ( isdefined( midpos ) )
        {
            tracelist[ tracelist.size ] = midpos;
        }
    }
    
    tracelist[ tracelist.size ] = potentialtarget.origin;
    canseetarget = 0;
    tracestartpos = turret gettagorigin( "tag_barrel" );
    
    foreach ( traceendpos in tracelist )
    {
        canseetarget = trace::ray_trace_passed( tracestartpos, traceendpos, var_847f780b10d918e5, contentsoverride );
        
        if ( canseetarget )
        {
            break;
        }
        
        wait 0.05;
    }
    
    return canseetarget;
}

// Namespace turret
// Params 1
// Checksum 0x3895c080, Offset: 0xa5f
// Size: 0x18, Type: bool
function function_5edb4fdb2e9ab457( targetdata )
{
    return istrue( targetdata.attackvehicle );
}

// Namespace turret
// Params 1
// Checksum 0x4ff266e3, Offset: 0xa80
// Size: 0x18, Type: bool
function function_c711ec5bf4080c5f( targetdata )
{
    return istrue( targetdata.attacklaststand );
}

// Namespace turret
// Params 1
// Checksum 0x8e3349e7, Offset: 0xaa1
// Size: 0x18, Type: bool
function function_e75ca8dfc13b45c4( targetdata )
{
    return istrue( targetdata.attackparachute );
}

// Namespace turret
// Params 4
// Checksum 0xaa153601, Offset: 0xac2
// Size: 0xd7, Type: bool
function function_460c373aa20e69b2( turret, target, var_18fb6f40b3170c8b, attackanglethreshold )
{
    if ( !turret_hastarget( turret ) && !isdefined( target ) )
    {
        return false;
    }
    
    currenttarget = function_f459998ab742b981( turret );
    
    if ( isdefined( target ) )
    {
        currenttarget = target;
    }
    
    targetlocation = currenttarget.origin;
    
    if ( isdefined( var_18fb6f40b3170c8b ) )
    {
        targetlocation = currenttarget gettagorigin( var_18fb6f40b3170c8b );
    }
    
    if ( !isdefined( attackanglethreshold ) )
    {
        attackanglethreshold = 10;
    }
    
    turretforward = anglestoforward( turret gettagangles( "tag_flash" ) );
    targetdisplace = targetlocation - turret gettagorigin( "tag_flash" );
    anglediff = math::anglebetweenvectors( turretforward, targetdisplace );
    
    if ( anglediff <= attackanglethreshold )
    {
        return true;
    }
    
    return false;
}

// Namespace turret
// Params 10, eflags: 0x4
// Checksum 0xe0cb0f59, Offset: 0xba2
// Size: 0xf5
function private function_d598d19fc388ec1b( turret, bundle, var_6ba2083bab22fff2, var_4ec56492318cf21c, enabletargetlaststand, var_3b13f6a44b83d17f, var_dda8afbd724672cd, var_1a666f31388d53fb, ignoreplayerteam, var_1f4b702d01f0df0c )
{
    turret endon( #"death" );
    level endon( #"game_ended" );
    
    if ( !isdefined( var_6ba2083bab22fff2 ) )
    {
        var_6ba2083bab22fff2 = 5000;
    }
    
    alltargets = function_4bee827f125e4dba( turret, var_6ba2083bab22fff2 );
    finaltargets = [];
    
    for ( i = 0; i < alltargets.size ; i++ )
    {
        targetdata = function_6ed47afa7c978ae6( turret, bundle, alltargets[ i ], var_6ba2083bab22fff2, var_4ec56492318cf21c, enabletargetlaststand, var_3b13f6a44b83d17f, var_dda8afbd724672cd, var_1a666f31388d53fb, ignoreplayerteam, var_1f4b702d01f0df0c );
        
        if ( isdefined( targetdata ) )
        {
            finaltargets[ finaltargets.size ] = targetdata;
        }
        else
        {
            continue;
        }
        
        wait 0.05;
    }
    
    return finaltargets;
}

// Namespace turret
// Params 2, eflags: 0x4
// Checksum 0xec84e18e, Offset: 0xca0
// Size: 0x39
function private function_4bee827f125e4dba( turret, var_6ba2083bab22fff2 )
{
    allpotentialtargets = [];
    allpotentialtargets = utility::function_1b1340a94b43b874( turret.origin, var_6ba2083bab22fff2 );
    return allpotentialtargets;
}

// Namespace turret
// Params 0, eflags: 0x4
// Checksum 0xd25c4e96, Offset: 0xce2
// Size: 0x7e
function private function_ff4fa477bcdf5f49()
{
    character = 0;
    _world = 1;
    glass = 0;
    shotclip = 1;
    item = 0;
    vehicle = 1;
    playerclip = 0;
    ainosight = 1;
    itemclip = 1;
    return trace::create_contents( character, _world, glass, shotclip, item, vehicle, playerclip, ainosight, itemclip );
}

// Namespace turret
// Params 11, eflags: 0x4
// Checksum 0xa5018172, Offset: 0xd69
// Size: 0x147
function private function_6ed47afa7c978ae6( turret, bundle, potentialtarget, var_6ba2083bab22fff2, var_4ec56492318cf21c, enabletargetlaststand, var_3b13f6a44b83d17f, var_dda8afbd724672cd, var_1a666f31388d53fb, ignoreplayerteam, var_1f4b702d01f0df0c )
{
    turret endon( #"death" );
    
    if ( !turret_isvalidtarget( turret, bundle, potentialtarget, var_6ba2083bab22fff2, var_4ec56492318cf21c, enabletargetlaststand, var_3b13f6a44b83d17f, var_dda8afbd724672cd, var_1a666f31388d53fb, ignoreplayerteam, var_1f4b702d01f0df0c ) )
    {
        return;
    }
    
    targetdata = function_59225b6e048280cb();
    canseetarget = turret_canseetarget( turret, potentialtarget, var_4ec56492318cf21c );
    var_cff7c82b0208a00c = undefined;
    occupiedvehicle = undefined;
    
    if ( var_4ec56492318cf21c )
    {
        var_cff7c82b0208a00c = potentialtarget vehicle::is_in_vehicle();
        
        if ( var_cff7c82b0208a00c )
        {
            occupiedvehicle = potentialtarget vehicle::get_vehicle();
        }
    }
    
    if ( canseetarget )
    {
        targetdata.targetplayer = potentialtarget;
        targetdata.targetvehicle = occupiedvehicle ?? undefined;
        targetdata.attackvehicle = var_4ec56492318cf21c && var_cff7c82b0208a00c && isdefined( occupiedvehicle );
        targetdata.attacklaststand = istrue( enabletargetlaststand );
        targetdata.attackparachute = istrue( var_3b13f6a44b83d17f );
    }
    
    return targetdata;
}

// Namespace turret
// Params 11, eflags: 0x4
// Checksum 0xb6f51aa5, Offset: 0xeb9
// Size: 0x26f, Type: bool
function private turret_isvalidtarget( turret, bundle, potentialtarget, var_6ba2083bab22fff2, var_4ec56492318cf21c, enabletargetlaststand, var_3b13f6a44b83d17f, var_dda8afbd724672cd, var_1a666f31388d53fb, ignoreplayerteam, var_1f4b702d01f0df0c )
{
    if ( !isdefined( potentialtarget ) )
    {
        return false;
    }
    
    turretteam = turret.team;
    
    if ( isdefined( var_1a666f31388d53fb ) )
    {
        turretteam = var_1a666f31388d53fb;
    }
    
    if ( potentialtarget.isjuggernaut && bundle.var_dd97fcfa65dac01a )
    {
        return false;
    }
    
    if ( isplayer( potentialtarget ) )
    {
        if ( !turret_isplayeractive( potentialtarget ) )
        {
            return false;
        }
        
        if ( potentialtarget == self.owner )
        {
            /#
                if ( isdefined( var_dda8afbd724672cd ) && getdvarint( var_dda8afbd724672cd, 0 ) )
                {
                    return true;
                }
            #/
            
            return false;
        }
        
        teamtocheck = potentialtarget.pers[ "team" ];
        
        if ( teamtocheck == "spectator" )
        {
            return false;
        }
        
        if ( isdefined( level.teambased ) )
        {
            if ( !isdefined( teamtocheck ) )
            {
                return false;
            }
            
            if ( isdefined( turretteam ) && !ignoreplayerteam )
            {
                if ( level.teambased && teamtocheck == turretteam )
                {
                    return false;
                }
            }
        }
    }
    
    if ( isagent( potentialtarget ) )
    {
        if ( bundle.var_95c03ad691939ed9 )
        {
            return false;
        }
        
        if ( !isalive( potentialtarget ) )
        {
            return false;
        }
        
        if ( isdefined( potentialtarget.agent_type ) && issubstr( potentialtarget.agent_type, "civilian" ) )
        {
            return false;
        }
        
        teamtocheck = potentialtarget.team;
        
        if ( isdefined( turretteam ) && !var_1f4b702d01f0df0c )
        {
            if ( teamtocheck == turretteam )
            {
                return false;
            }
        }
    }
    
    if ( isdefined( potentialtarget.perks[ "specialty_blindeye" ] ) )
    {
        return false;
    }
    
    if ( isdefined( var_6ba2083bab22fff2 ) )
    {
        if ( distancesquared( turret.origin, potentialtarget.origin ) > var_6ba2083bab22fff2 * var_6ba2083bab22fff2 )
        {
            return false;
        }
    }
    
    if ( potentialtarget vehicle::is_in_vehicle() && !var_4ec56492318cf21c )
    {
        return false;
    }
    
    if ( potentialtarget.inlaststand && !enabletargetlaststand )
    {
        return false;
    }
    
    if ( parachute::isparachutegametype() && ( potentialtarget isparachuting() || potentialtarget isskydiving() ) && !var_3b13f6a44b83d17f )
    {
        return false;
    }
    
    if ( potentialtarget.notarget )
    {
        return false;
    }
    
    if ( potentialtarget ismeatshieldvictim() )
    {
        return false;
    }
    
    return true;
}

// Namespace turret
// Params 1, eflags: 0x4
// Checksum 0x9a75bb24, Offset: 0x1131
// Size: 0x30, Type: bool
function private turret_isplayeractive( player )
{
    return isdefined( player ) && player player::isreallyalive() && player.sessionstate == "playing";
}

// Namespace turret
// Params 0, eflags: 0x4
// Checksum 0x9f88a42b, Offset: 0x116a
// Size: 0x51
function private function_59225b6e048280cb()
{
    targetdata = spawnstruct();
    targetdata.targetplayer = undefined;
    targetdata.targetvehicle = undefined;
    targetdata.attackvehicle = 0;
    targetdata.attacklaststand = 0;
    targetdata.attackparachute = 0;
    return targetdata;
}

// Namespace turret
// Params 2, eflags: 0x4
// Checksum 0x3e2f9fdd, Offset: 0x11c4
// Size: 0x64
function private function_dd9bac00c9444681( targetdata, cleartargetnotify )
{
    self endon( #"death" );
    turret_settarget( self, targetdata );
    thread function_aed128710452e6b1( function_93d9d997ab45c443( targetdata ), "death_or_disconnect" );
    
    if ( isdefined( cleartargetnotify ) )
    {
        thread function_aed128710452e6b1( self, cleartargetnotify );
    }
    
    self waittill( #"clear_turret_target" );
    turret_cleartarget( self );
}

// Namespace turret
// Params 2, eflags: 0x4
// Checksum 0x797b6e6a, Offset: 0x1230
// Size: 0x3f
function private function_aed128710452e6b1( ent, notifymsg )
{
    self endon( #"death" );
    self endon( #"clear_turret_target" );
    ent waittill( notifymsg );
    self notify( #"clear_turret_target" );
}

// Namespace turret
// Params 2, eflags: 0x4
// Checksum 0x169a4c9f, Offset: 0x1277
// Size: 0xdf
function private function_880cc87a06ca99ae( params, additionalparams )
{
    if ( !isdefined( params.victim ) )
    {
        return;
    }
    
    if ( !isdefined( params.attacker ) )
    {
        return;
    }
    
    if ( !isdefined( additionalparams ) )
    {
        return;
    }
    
    turretparent = additionalparams.turretparent;
    
    if ( !isdefined( turretparent ) )
    {
        return;
    }
    
    turretowner = turretparent.owner;
    
    if ( !isdefined( turretowner ) )
    {
        return;
    }
    
    if ( turretowner != params.victim )
    {
        return;
    }
    
    attackerguid = params.attacker.guid;
    
    if ( !isdefined( attackerguid ) )
    {
        return;
    }
    
    if ( !isdefined( turretparent.var_c1832d5edbcefa3c ) )
    {
        return;
    }
    
    turretparent.var_c1832d5edbcefa3c[ attackerguid ] = params.deathtime;
}

