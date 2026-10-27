// scripts\anim\combat_utility.gsc  (hash_13d1c402f1421c35.gscc) (size: 5293 Bytes / 0x14ad / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcbf7999b (3422001563)
// size ...... 5293 (0x14ad)
// includes .. 3   (offset: 0x13dd)
// strings ... 6   (offset: 0x13f5)
// dev strs .. 9   (offset: 0x143d)
// exports ... 18  (offset: 0xbdd)
// cseg ...... 0xbc + 0xb21 (0xbdd)
// imports ... 45  (offset: 0xead)
// animtree1 . 0   (offset: 0x14ad)
// animtree2 . 0   (offset: 0x14ad)
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\common\utility;

#namespace combat_utility;

// Namespace combat_utility
// Params 0
// Checksum 0x92725b32, Offset: 0xda
// Size: 0x2
function shootuntilshootbehaviorchange()
{
    
}

// Namespace combat_utility
// Params 0
// Checksum 0xc4704524, Offset: 0xe4
// Size: 0x2
function initgrenadethrowanims()
{
    
}

// Namespace combat_utility
// Params 0
// Checksum 0x62c5980f, Offset: 0xee
// Size: 0xbd
function throwgrenadeatplayerasap_combat_utility()
{
    assert( utility::issp() && self isbadguy() );
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        if ( level.players[ i ] function_ea1c30d42bd9c659() == 0 )
        {
            aisetgrenadetimer( level.players[ i ], "lethal", 0 );
        }
    }
    
    function_bee5df22fff6b7cc( 1 );
    
    /#
        enemies = getaiarray( "<dev string:x24>" );
        
        if ( enemies.size == 0 )
        {
            return;
        }
        
        for ( i = 0; i < enemies.size ; i++ )
        {
            if ( enemies[ i ].grenadeammo > 0 )
            {
                return;
            }
        }
        
        println( "<dev string:x2d>" );
    #/
}

/#

    // Namespace combat_utility
    // Params 1
    // Checksum 0x84961c73, Offset: 0x1b3
    // Size: 0xa5, Type: dev
    function function_6b6f2fb367e67c7( grenadetimer )
    {
        if ( grenadetimer.isplayertimer )
        {
            for ( i = 0; i < level.players.size ; i++ )
            {
                if ( level.players[ i ] == grenadetimer.player )
                {
                    break;
                }
            }
            
            return ( "<dev string:x7e>" + i + 1 + "<dev string:x86>" + grenadetimer.weapon.basename );
        }
        
        return "<dev string:x88>" + grenadetimer.weapon.basename;
    }

#/

// Namespace combat_utility
// Params 7
// Checksum 0x8e8e6b7b, Offset: 0x260
// Size: 0x42
function trygrenadethrow( throwingat, destination, optionalanimation, armoffset, fastthrow, withbounce, throwinthread )
{
    
}

// Namespace combat_utility
// Params 0
// Checksum 0xe3a1fe8e, Offset: 0x2aa
// Size: 0x93
function getgrenadedropvelocity()
{
    yaw = randomfloat( 360 );
    pitch = randomfloatrange( 30, 75 );
    amntz = sin( pitch );
    cospitch = cos( pitch );
    amntx = cos( yaw ) * cospitch;
    amnty = sin( yaw ) * cospitch;
    speed = randomfloatrange( 100, 200 );
    velocity = ( amntx, amnty, amntz ) * speed;
    return velocity;
}

// Namespace combat_utility
// Params 0
// Checksum 0xbdb7bd1a, Offset: 0x346
// Size: 0x41
function dropgrenade()
{
    if ( isdefined( self.nodropgrenade ) )
    {
        return;
    }
    
    grenadeorigin = self gettagorigin( "tag_accessory_right" );
    velocity = getgrenadedropvelocity();
    self function_de0ec7f52c8250bd( grenadeorigin, velocity, 3 );
}

// Namespace combat_utility
// Params 1
// Checksum 0x2b93e020, Offset: 0x38f
// Size: 0x49
function getpitchtoshootspot( spot )
{
    if ( !isdefined( spot ) )
    {
        return 0;
    }
    
    vectortoenemy = spot - self getshootatpos();
    vectortoenemy = vectornormalize( vectortoenemy );
    pitchdelta = vectortoangles( vectortoenemy )[ 0 ];
    return angleclamp180( pitchdelta );
}

// Namespace combat_utility
// Params 0
// Checksum 0x3e98824e, Offset: 0x3e1
// Size: 0x6e
function watchreloading()
{
    self.isreloading = 0;
    self.lastreloadstarttime = -1;
    
    while ( true )
    {
        self waittill( #"reload_start" );
        self.isreloading = 1;
        self.lastreloadstarttime = gettime();
        
        if ( isdefined( level.battlechatter ) )
        {
            addbattlechatternotify( self, undefined, "reload" );
        }
        
        waittillreloadfinished();
        self.isreloading = 0;
    }
}

// Namespace combat_utility
// Params 0
// Checksum 0x428dafe7, Offset: 0x457
// Size: 0x78
function waittillreloadfinished()
{
    thread timednotify( 4, "reloadtimeout" );
    self endon( #"reloadtimeout" );
    self endon( #"weapon_taken" );
    
    while ( true )
    {
        self waittill( #"reload" );
        weap = self getcurrentweapon();
        
        if ( isnullweapon( weap ) )
        {
            break;
        }
        
        if ( self getcurrentweaponclipammo() >= weaponclipsize( weap ) )
        {
            break;
        }
    }
    
    self notify( #"reloadtimeout" );
}

// Namespace combat_utility
// Params 2
// Checksum 0x58cdf246, Offset: 0x4d7
// Size: 0x22
function timednotify( time, msg )
{
    self endon( msg );
    wait time;
    self notify( msg );
}

// Namespace combat_utility
// Params 0
// Checksum 0x4906ab0e, Offset: 0x501
// Size: 0x1a0
function monitorflash()
{
    self endon( #"death" );
    
    if ( !isdefined( level.neverstopmonitoringflash ) )
    {
        self endon( #"stop_monitoring_flash" );
    }
    
    while ( true )
    {
        amount_distance = undefined;
        origin = undefined;
        amount_angle = undefined;
        attacker = undefined;
        attackerteam = undefined;
        self waittill( #"flashbang", origin, amount_distance, amount_angle, attacker, attackerteam, duration );
        
        if ( self.flashbangimmunity )
        {
            continue;
        }
        
        if ( isdefined( self.script_immunetoflash ) && self.script_immunetoflash != 0 )
        {
            continue;
        }
        
        if ( self.team == attackerteam )
        {
            amount_distance = 3 * ( amount_distance - 0.75 );
            
            if ( amount_distance < 0 )
            {
                continue;
            }
            
            if ( isdefined( self.teamflashbangimmunity ) )
            {
                continue;
            }
        }
        
        if ( utility::function_92f6c5dd7f8b6166( "flashbang", attackerteam ) )
        {
            continue;
        }
        
        var_4fb784d13a0390ce = 0.2;
        
        if ( amount_distance > 1 - var_4fb784d13a0390ce )
        {
            amount_distance = 1;
        }
        else
        {
            amount_distance /= 1 - var_4fb784d13a0390ce;
        }
        
        if ( !isdefined( duration ) )
        {
            duration = 4.5;
        }
        
        duration *= amount_distance;
        
        if ( !self.bhasriotshieldattached && duration < 0.25 )
        {
            continue;
        }
        
        if ( getdvarfloat( @"hash_737dfcd28a218a8f", 0 ) )
        {
            duration = getdvarfloat( @"hash_737dfcd28a218a8f" );
        }
        
        self.flashingteam = attackerteam;
        flashbangstart( duration );
        self notify( #"doFlashBanged", origin, attacker );
    }
}

// Namespace combat_utility
// Params 1
// Checksum 0xc9849318, Offset: 0x6a9
// Size: 0xe2
function flashbangstart( duration )
{
    assert( isdefined( self ) );
    assert( isdefined( duration ) );
    
    if ( self.flashbangimmunity )
    {
        return;
    }
    
    if ( isdefined( self.syncedmeleetarget ) )
    {
        return;
    }
    
    if ( self isinscriptedstate() || asm_bb::bb_isanimscripted() )
    {
        return;
    }
    
    if ( !self.var_74a70e000dc0cbf2 && !self.allowpain )
    {
        return;
    }
    
    newflashendtime = gettime() + int( duration * 1000 );
    
    if ( isdefined( self.flashendtime ) )
    {
        self.flashendtime = int( max( self.flashendtime, newflashendtime ) );
    }
    else
    {
        self.flashendtime = newflashendtime;
        
        if ( isdefined( self.asm ) )
        {
            asm::asm_setstate( "pain_flashed_transition" );
        }
    }
    
    self notify( #"flashed" );
}

// Namespace combat_utility
// Params 0
// Checksum 0x21435428, Offset: 0x793
// Size: 0x7
function fasteranimspeed()
{
    return 1.5;
}

/#

    // Namespace combat_utility
    // Params 0
    // Checksum 0x256438e2, Offset: 0x7a3
    // Size: 0x1d6, Type: dev
    function showgrenadetimers()
    {
        setdvarifuninitialized( @"hash_b4fd9ea4f6486d24", "<dev string:x8c>" );
        huds = undefined;
        playerhuds = undefined;
        
        while ( true )
        {
            if ( getdvarint( @"hash_b4fd9ea4f6486d24" ) == 0 )
            {
                function_90bf7070c1f68ccf( huds );
                function_90bf7070c1f68ccf( playerhuds );
                huds = undefined;
                playerhuds = undefined;
                wait 0.2;
                continue;
            }
            
            if ( !isdefined( huds ) )
            {
                [ huds, playerhuds ] = function_71fa487faf272381();
            }
            
            foreach ( key, hud in huds )
            {
                hud.value = anim.meleechargetimers[ key ] - gettime();
                
                if ( hud.value < 0 )
                {
                    continue;
                }
                
                hud setvalue( hud.value );
            }
            
            foreach ( key, hud in playerhuds )
            {
                hud.value = anim.meleechargeplayertimers[ key ] - gettime();
                
                if ( hud.value < 0 )
                {
                    continue;
                }
                
                hud setvalue( hud.value );
            }
            
            wait 0.05;
        }
    }

    // Namespace combat_utility
    // Params 0
    // Checksum 0xb0a97c89, Offset: 0x981
    // Size: 0x1cd, Type: dev
    function function_71fa487faf272381()
    {
        huds = [];
        count = 0;
        
        foreach ( key, item in anim.meleechargetimers )
        {
            hud = newhudelem();
            hud.x = 80;
            hud.y = 20 + count * 15;
            hud.label = "<dev string:x8e>" + key + "<dev string:x9a>";
            hud setvalue( 0 );
            hud.value = 0;
            huds[ key ] = hud;
            count++;
        }
        
        count++;
        playerhuds = [];
        
        foreach ( key, item in anim.meleechargeplayertimers )
        {
            hud = newhudelem();
            hud.x = 80;
            hud.y = 20 + count * 15;
            hud.label = "<dev string:x9d>" + key + "<dev string:x9a>";
            hud setvalue( 0 );
            hud.value = 0;
            playerhuds[ key ] = hud;
            count++;
        }
        
        return [ huds, playerhuds ];
    }

    // Namespace combat_utility
    // Params 1
    // Checksum 0x967e4f01, Offset: 0xb56
    // Size: 0x87, Type: dev
    function function_90bf7070c1f68ccf( huds )
    {
        if ( !isdefined( huds ) )
        {
            return;
        }
        
        foreach ( hud in huds )
        {
            hud destroy();
        }
    }

#/
