// scripts\common\whizby.gsc  (hash_44a4ad8c0d35f203.gscc) (size: 8972 Bytes / 0x230c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd80fa0d8 (3624902872)
// size ...... 8972 (0x230c)
// includes .. 6   (offset: 0x2120)
// strings ... 23  (offset: 0x2150)
// dev strs .. 10  (offset: 0x2284)
// exports ... 20  (offset: 0x1420)
// cseg ...... 0x1de + 0x1242 (0x1420)
// imports ... 82  (offset: 0x1740)
// animtree1 . 0   (offset: 0x230c)
// animtree2 . 0   (offset: 0x230c)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;

#namespace whizby;

// Namespace whizby
// Params 1
// Checksum 0x6271cc32, Offset: 0x1fc
// Size: 0xeb
function init( var_15308877f310d9f1 )
{
    setdvarifuninitialized( @"scr_whizby", 1 );
    
    /#
        setdvarifuninitialized( @"scr_debug_whizby", 0 );
        setdvarifuninitialized( @"hash_88bdf4cdc3a1e4cf", "<dev string:x24>" );
        setdvarifuninitialized( @"hash_2df56d8d16c15f71", 0 );
    #/
    
    callback::add( #"player_spawned", &onplayerspawned );
    
    if ( isdefined( level.players ) )
    {
        foreach ( player in level.players )
        {
            player thread whizbythink();
        }
    }
}

// Namespace whizby
// Params 1, eflags: 0x4
// Checksum 0xd39d0ee0, Offset: 0x2ef
// Size: 0x13
function private onplayerspawned( params )
{
    thread whizbythink();
}

// Namespace whizby
// Params 0, eflags: 0x4
// Checksum 0x1c6a2e25, Offset: 0x30a
// Size: 0xe8
function private initplayer()
{
    self.whizby = spawnstruct();
    self.whizby.var_45ef5abc00ebcb00 = -999999;
    self.whizby.var_4cd804d5a20f5070 = -999999;
    self.whizby.lastmag = 1;
    self.whizby.var_fff80f429c8e7aed = -999999;
    self.whizby.var_390e755683e8ce20 = 0;
    function_7518f9728ec08081();
    
    if ( level.gamemodebundle.var_49aaa9409a44488 && function_4042d2fbe6237835( #"hash_404f3e574dfa47be" ) )
    {
        level.gamemodebundle.var_49aaa9409a44488 = 0;
    }
    
    if ( level.gamemodebundle.var_49aaa9409a44488 )
    {
        tempinithud();
    }
}

// Namespace whizby
// Params 0, eflags: 0x4
// Checksum 0x97c91481, Offset: 0x3fa
// Size: 0x65
function private tempinithud()
{
    self setclientomnvar( "ui_whizby_alpha_front", 0 );
    self setclientomnvar( "ui_whizby_alpha_side", 0 );
    self setclientomnvar( "ui_whizby_alpha_back", 0 );
    self setclientomnvar( "ui_whizby_side_angle", 1 );
    self setclientomnvar( "ui_whizby_back_x", 0 );
    self setclientomnvar( "ui_whizby_back_y", 0 );
    self setclientomnvar( "ui_whizby_back_z", 0 );
    self setclientomnvar( "ui_whizby_notify", -999 );
}

// Namespace whizby
// Params 0, eflags: 0x4
// Checksum 0xa86322f5, Offset: 0x467
// Size: 0xc0
function private whizbythink()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    initplayer();
    
    for ( ;; )
    {
        self waittill( #"bulletwhizby", attacker, distance, position, forward );
        
        if ( !utility::isusingremote() )
        {
            thread whizbyeffect( attacker, distance, position, forward );
        }
        
        if ( isplayer( attacker ) )
        {
            weapon = attacker getcurrentweapon();
            
            if ( isdefined( weapon ) && weaponclass( weapon ) == "sniper" )
            {
                namespace_9d8e359c3b1041e5::trysaylocalsoundsharedfunc( self, #"bc_combat_threat_sniper", 0.2 );
            }
        }
        
        namespace_9d8e359c3b1041e5::addrecentattackersharedfunc( attacker );
    }
}

// Namespace whizby
// Params 5
// Checksum 0xaf3f865, Offset: 0x52f
// Size: 0x267
function whizbyeffect( attacker, distance, position, forward, forceweapon )
{
    /#
        if ( getdvarint( @"scr_debug_whizby" ) )
        {
            print3d( position, distance, ( 1, 0, 0 ), 0.7, 0.45, 20 );
        }
    #/
    
    if ( isdefined( level.battlechatter ) && isscriptedai( attacker ) && isalive( attacker ) )
    {
        addbattlechatternotify( attacker, undefined, "shot_at_target", "target_unhurt" );
    }
    
    self notify( #"hash_fe0bee9928a0265d" );
    self endon( #"hash_fe0bee9928a0265d" );
    waittillframeend();
    time = gettime();
    
    if ( !shoulddowhizby( attacker, distance, position, forward, time ) )
    {
        return;
    }
    
    weapon = undefined;
    
    if ( isdefined( forceweapon ) )
    {
        weapon = forceweapon;
    }
    
    if ( isplayer( attacker ) || isbot( attacker ) )
    {
        weapon = attacker getcurrentweapon();
    }
    else if ( isscriptedai( attacker ) )
    {
        weapon = attacker.weapon;
    }
    else
    {
        assertmsg( "<dev string:x25>" );
    }
    
    weapclass = weaponclass( weapon );
    
    /#
        if ( getdvar( @"hash_88bdf4cdc3a1e4cf", "<dev string:x24>" ) != "<dev string:x24>" )
        {
            switch ( getdvar( @"hash_88bdf4cdc3a1e4cf" ) )
            {
                case #"hash_900cb06c552c5063":
                    weapclass = "<dev string:x56>";
                    break;
                case #"hash_28a7ce6c1f1955d9":
                    weapclass = "<dev string:x5e>";
                    break;
                case #"hash_2f69646c2276faf4":
                    weapclass = "<dev string:x68>";
                    break;
            }
        }
    #/
    
    var_d8a6554a114bd44f = weapclass == "rocketlauncher";
    attackercansee = attackercansee( attacker );
    
    if ( var_d8a6554a114bd44f )
    {
        whizbymag = 1;
    }
    else
    {
        whizbymag = function_56398aadb4238567( weapclass, distance, time );
    }
    
    whizbyquake( whizbymag, attackercansee, var_d8a6554a114bd44f );
    
    if ( !var_d8a6554a114bd44f )
    {
        whizby_hud( attacker, position, time, whizbymag, distance, attackercansee );
    }
    
    self.whizby.var_45ef5abc00ebcb00 = time;
    
    if ( !isdefined( attacker.whizby ) )
    {
        attacker.whizby = spawnstruct();
    }
    
    attacker.whizby.var_4cd804d5a20f5070 = time;
    function_7518f9728ec08081();
}

// Namespace whizby
// Params 1
// Checksum 0x398d1fab, Offset: 0x79e
// Size: 0x57
function attackercansee( attacker )
{
    if ( !level.gamemodebundle.var_49aaa9409a44488 )
    {
        return 1;
    }
    
    if ( isplayer( attacker ) || isbot( attacker ) )
    {
        return attacker playercansee( self );
    }
    
    if ( isagent( attacker ) )
    {
        return attacker cansee( self );
    }
}

// Namespace whizby
// Params 5
// Checksum 0xa5b0a9c7, Offset: 0x7fd
// Size: 0x15b, Type: bool
function shoulddowhizby( attacker, distance, position, forward, time )
{
    if ( getdvarint( @"scr_whizby", 1 ) != 1 )
    {
        return false;
    }
    
    if ( !( isdefined( self ) && isdefined( attacker ) && isdefined( distance ) && isdefined( position ) && isdefined( forward ) ) )
    {
        return false;
    }
    
    if ( !isscriptedai( attacker ) && !isplayer( attacker ) )
    {
        return false;
    }
    
    if ( !isalive( attacker ) )
    {
        return false;
    }
    
    if ( self.sessionstate != "playing" )
    {
        return false;
    }
    
    if ( time - self.whizby.var_45ef5abc00ebcb00 < self.whizby.cooldown )
    {
        return false;
    }
    
    if ( !val::get( "whizby" ) )
    {
        return false;
    }
    
    if ( self.nowhizby )
    {
        return false;
    }
    
    if ( isdefined( attacker.perks[ "specialty_stealth_shot" ] ) )
    {
        return false;
    }
    
    if ( isdefined( self.team ) && isdefined( attacker.team ) && !isenemyteam( self.team, attacker.team ) )
    {
        return false;
    }
    
    if ( self.deathsdoor )
    {
        return false;
    }
    
    if ( function_e691eae31d76f5d4( time ) )
    {
        return false;
    }
    
    return true;
}

// Namespace whizby
// Params 1
// Checksum 0x6f4f855c, Offset: 0x961
// Size: 0x4e, Type: bool
function function_e691eae31d76f5d4( time )
{
    if ( !isdefined( self.lastdamagedtime ) )
    {
        return false;
    }
    
    damagedcooldowntime = getdvarint( @"hash_902f31627206f3", 750 );
    
    if ( self.lastdamagedtime + damagedcooldowntime > time )
    {
        return true;
    }
    
    return false;
}

// Namespace whizby
// Params 3
// Checksum 0x369e0803, Offset: 0x9b8
// Size: 0xf3
function whizbyquake( whizbymag, attackercansee, var_d8a6554a114bd44f )
{
    zoomlevel = self playergetzoomfov();
    zoomfactor = math::normalize_value( 4, 65, zoomlevel );
    var_2f8f06e47f16dfeb = math::factor_value( 0.3, 0.85, zoomfactor );
    var_63d33e9181deab62 = math::factor_value( 1, var_2f8f06e47f16dfeb, self playerads() );
    
    if ( var_d8a6554a114bd44f )
    {
        quakemag = 0.3;
        quaketime = 0.58;
    }
    else
    {
        quakemag = math::factor_value( 0.04, 0.2, whizbymag );
        quaketime = math::factor_value( 0.35, 0.35, whizbymag );
    }
    
    quakemag *= var_63d33e9181deab62;
    
    if ( !attackercansee )
    {
        quakemag *= 0.3;
    }
    
    self earthquakeforplayer( quakemag, quaketime, self.origin, 1000 );
}

// Namespace whizby
// Params 6
// Checksum 0xa487b867, Offset: 0xab3
// Size: 0x290
function whizby_hud( attacker, position, time, whizbymag, distance, attackercansee )
{
    if ( !level.gamemodebundle.var_49aaa9409a44488 )
    {
        return;
    }
    
    whizbymag = math::factor_value( 0.2, 1, whizbymag );
    
    if ( !attackercansee )
    {
        whizbymag *= 0.3;
    }
    
    playerang = self getplayerangles();
    eyepos = self geteye();
    playeraxis = anglestoaxis( playerang );
    attackerpos = attacker.origin + ( 0, 0, 50 );
    toattackervec = vectornormalize( attackerpos - eyepos );
    var_fc6127fba68d1fd0 = vectordot( toattackervec, playeraxis[ "forward" ] );
    var_e093625f1ac7ee21 = vectordot( toattackervec, playeraxis[ "right" ] );
    var_ca64d843cc586c90 = vectordot( toattackervec, playeraxis[ "up" ] );
    
    if ( var_fc6127fba68d1fd0 > 0 )
    {
        var_fc6127fba68d1fd0 = 1 - var_fc6127fba68d1fd0;
        var_fc6127fba68d1fd0 *= var_fc6127fba68d1fd0;
        var_fc6127fba68d1fd0 = 1 - var_fc6127fba68d1fd0;
    }
    
    whizybyent = attacker getentitynumber();
    var_5ef7f8cfae79edf = clamp( var_fc6127fba68d1fd0, 0, 1 );
    var_beec6eafe34ffa83 = 1 - abs( var_fc6127fba68d1fd0 );
    var_2020a721fb94beb3 = clamp( -1 * var_fc6127fba68d1fd0, 0, 1 );
    var_8a6242907c4346f6 = function_672304404ec10e3( var_e093625f1ac7ee21, var_ca64d843cc586c90 );
    backorigin = position + -500 * toattackervec;
    var_5ef7f8cfae79edf = math::normalized_float_smooth_out( var_5ef7f8cfae79edf );
    var_2020a721fb94beb3 = math::normalized_float_smooth_out( var_2020a721fb94beb3 );
    var_beec6eafe34ffa83 = math::normalized_float_smooth_out( var_beec6eafe34ffa83 );
    self setclientomnvar( "ui_whizby_alpha_front", var_5ef7f8cfae79edf * whizbymag * 0.6 );
    self setclientomnvar( "ui_whizby_alpha_side", var_beec6eafe34ffa83 * whizbymag * 1 );
    self setclientomnvar( "ui_whizby_alpha_back", var_2020a721fb94beb3 * whizbymag * 0.5 );
    self setclientomnvar( "ui_whizby_side_angle", int( var_8a6242907c4346f6 ) );
    self setclientomnvar( "ui_whizby_ent", whizybyent );
    self setclientomnvar( "ui_whizby_back_x", int( backorigin[ 0 ] ) );
    self setclientomnvar( "ui_whizby_back_y", int( backorigin[ 1 ] ) );
    self setclientomnvar( "ui_whizby_back_z", int( backorigin[ 2 ] ) );
    self setclientomnvar( "ui_whizby_notify", time );
    
    /#
        if ( getdvarint( @"scr_debug_whizby" ) )
        {
            debugwhizby( attacker, position, backorigin, whizbymag, distance );
        }
    #/
}

// Namespace whizby
// Params 2
// Checksum 0x9d188c04, Offset: 0xd4b
// Size: 0x8f
function function_672304404ec10e3( var_e093625f1ac7ee21, var_ca64d843cc586c90 )
{
    var_58d361fc11eda35b = abs( var_e093625f1ac7ee21 ) + abs( var_ca64d843cc586c90 );
    
    if ( var_58d361fc11eda35b > 0 )
    {
        rightfrac = var_e093625f1ac7ee21 / var_58d361fc11eda35b;
        upfrac = var_ca64d843cc586c90 / var_58d361fc11eda35b;
    }
    else
    {
        rightfrac = 1;
        upfrac = 1;
    }
    
    if ( upfrac < 0 )
    {
        angle = 90 * rightfrac;
    }
    else
    {
        angle = 90 + 90 * upfrac;
        
        if ( rightfrac < 0 )
        {
            angle *= -1;
        }
    }
    
    return angle;
}

// Namespace whizby
// Params 3
// Checksum 0xcb9947e6, Offset: 0xde3
// Size: 0xf1
function function_56398aadb4238567( weapclass, distance, time )
{
    basemag = 1;
    whizby_min = randomfloatrange( 0, 0.19 );
    timesincelastreceived = time - self.whizby.var_45ef5abc00ebcb00;
    var_da7b131da1d031a2 = math::normalize_value( 1000, 3000, timesincelastreceived );
    var_b83992a18a8a1112 = math::factor_value( whizby_min, 1, var_da7b131da1d031a2 );
    mag = basemag * var_b83992a18a8a1112;
    var_8b198e086f52b0c2 = self.whizby.lastmag - 0.23;
    self.whizby.lastmag = max( mag, var_8b198e086f52b0c2 );
    return self.whizby.lastmag;
}

// Namespace whizby
// Params 1
// Checksum 0xc78ebaa0, Offset: 0xedd
// Size: 0x112, Type: bool
function playercansee( attacker )
{
    contents = trace::create_contents( 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0 );
    eye = attacker geteye();
    positions = [ self gettagorigin( "J_head" ), self gettagorigin( "J_clavicle_ri" ), self gettagorigin( "J_clavicle_le" ), self gettagorigin( "J_spinelower" ) ];
    
    foreach ( position in positions )
    {
        canseetarget = trace::ray_trace_passed( eye, position, [ attacker, self ], contents );
        
        if ( canseetarget )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace whizby
// Params 0
// Checksum 0x31550831, Offset: 0xff8
// Size: 0x1e
function function_7518f9728ec08081()
{
    self.whizby.cooldown = randomfloatrange( 100, 200 );
}

/#

    // Namespace whizby
    // Params 0
    // Checksum 0x254b6651, Offset: 0x101e
    // Size: 0x73, Type: dev
    function testwhizby()
    {
        setdevdvar( @"scr_whizby", 1 );
        
        if ( isbot( self ) )
        {
            return;
        }
        
        self endon( #"death" );
        self endon( #"disconnect" );
        thread function_c7134dd62b034c3();
        
        while ( true )
        {
            self waittill( #"toggle_whizby" );
            
            if ( getdvarint( @"hash_2df56d8d16c15f71" ) )
            {
                function_380c56530155ff35();
                continue;
            }
            
            thread function_380c56530155ff35();
        }
    }

    // Namespace whizby
    // Params 0
    // Checksum 0x535d633d, Offset: 0x1099
    // Size: 0x46, Type: dev
    function function_c7134dd62b034c3()
    {
        while ( true )
        {
            while ( !self buttonpressed( "<dev string:x6f>" ) )
            {
                wait 0.05;
            }
            
            self notify( #"toggle_whizby" );
            
            while ( self buttonpressed( "<dev string:x6f>" ) )
            {
                wait 0.05;
            }
        }
    }

    // Namespace whizby
    // Params 0
    // Checksum 0xca988320, Offset: 0x10e7
    // Size: 0x24d, Type: dev
    function function_380c56530155ff35()
    {
        self endon( #"toggle_whizby" );
        i = 0;
        dist = [ 10, 25, 50, 75 ];
        attacker = undefined;
        
        foreach ( player in level.players )
        {
            if ( player != self )
            {
                attacker = player;
            }
        }
        
        if ( !isdefined( attacker ) )
        {
            ai = getaiarray();
            
            if ( ai.size > 0 )
            {
                attacker = function_47c86977a18df38b( ai, self.origin, 5000 );
            }
        }
        
        while ( true )
        {
            if ( isdefined( attacker ) )
            {
                vecoffset = anglestoforward( self getplayerangles( 1 ) );
                dirtoattacker = vectornormalize( ( attacker.origin[ 0 ], attacker.origin[ 1 ], 0 ) - ( self.origin[ 0 ], self.origin[ 1 ], 0 ) );
                var_220a111032e15928 = 1;
                vecoffset = rotatevector( dirtoattacker, ( 0, 90 * var_220a111032e15928, 0 ) );
                height = ( 0, 0, randomfloatrange( 45, 65 ) );
                position = self.origin + height + vecoffset * dist[ i ];
                self notify( #"bulletwhizby", attacker, dist[ i ], position, dirtoattacker * -1 );
                i++;
                
                if ( i >= dist.size )
                {
                    i = 0;
                }
            }
            
            if ( !getdvarint( @"hash_2df56d8d16c15f71" ) )
            {
                return;
            }
            
            switch ( getdvar( @"hash_88bdf4cdc3a1e4cf" ) )
            {
                case #"hash_900cb06c552c5063":
                    wait 0.22;
                    break;
                case #"hash_28a7ce6c1f1955d9":
                    wait 0.3;
                    break;
                case #"hash_2f69646c2276faf4":
                    wait 0.75;
                    break;
                default:
                    wait 0.22;
                    break;
            }
        }
    }

    // Namespace whizby
    // Params 5
    // Checksum 0xd13994ac, Offset: 0x133c
    // Size: 0xe4, Type: dev
    function debugwhizby( attacker, position, backorigin, whizbymag, distance )
    {
        if ( isdefined( attacker ) && isdefined( position ) )
        {
            if ( isdefined( attacker.currentweapon ) && attacker tagexists( "<dev string:x7a>" ) )
            {
                start = attacker gettagorigin( "<dev string:x7a>" );
            }
            else
            {
                start = attacker.origin + ( 0, 0, 50 );
            }
            
            line( start, position, ( 1, 0, 0 ), 1, 1, 20 );
            line( backorigin, position, ( 0.5, 0.5, 0.5 ), 1, 1, 20 );
            iprintln( "<dev string:x84>" + distance + "<dev string:x9c>" + whizbymag + "<dev string:xad>" );
        }
    }

#/
