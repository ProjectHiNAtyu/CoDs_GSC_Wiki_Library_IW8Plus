// scripts\mp\common\equipment\temp_v_jump_superpower.gsc  (hash_7678fbcfcd1df9d6.gscc) (size: 11092 Bytes / 0x2b54 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2edaa27b (786080379)
// size ...... 11092 (0x2b54)
// includes .. 11  (offset: 0x28ec)
// strings ... 36  (offset: 0x2944)
// dev strs .. 1   (offset: 0x2b48)
// exports ... 30  (offset: 0x19c4)
// cseg ...... 0x27b + 0x1749 (0x19c4)
// imports ... 88  (offset: 0x1e74)
// animtree1 . 0   (offset: 0x2b54)
// animtree2 . 0   (offset: 0x2b54)
#using scripts\common\callbacks;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\common\equipment\temp_v;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\player;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\supers;

#namespace temp_v_jump_superpower;

// Namespace temp_v_jump_superpower
// Params 0, eflags: 0x1
// Checksum 0xc7401bbe, Offset: 0x299
// Size: 0x9
function autoexec main()
{
    init();
}

// Namespace temp_v_jump_superpower
// Params 0
// Checksum 0xa0dd407c, Offset: 0x2aa
// Size: 0x3e
function init()
{
    utility::flag_wait( "supers_initialized" );
    supers_mp::function_48aaa60b2ce7b8a1( "super_high_jump", undefined, undefined, &function_1e60114dd65c682, &function_1fc78018d6ce59e0, undefined, undefined, undefined );
    callback::add( #"hash_657f964d63330123", &function_abaabd328c4f0b84 );
}

// Namespace temp_v_jump_superpower
// Params 1
// Checksum 0xa1be61b9, Offset: 0x2f0
// Size: 0x28, Type: bool
function function_abaabd328c4f0b84( params )
{
    if ( self.superjumpprotected )
    {
        return true;
    }
    
    if ( function_383d4875c41b8831() )
    {
        return true;
    }
    
    return false;
}

// Namespace temp_v_jump_superpower
// Params 0
// Checksum 0x32a195a4, Offset: 0x321
// Size: 0xd9, Type: bool
function function_1e60114dd65c682()
{
    splashref = "super_high_jump" + "_activate";
    
    if ( getdvarint( @"hash_a6321fc4dc1000d7", 0 ) )
    {
        splashref += "_alt";
    }
    
    thread hud_message::showsplash( splashref, undefined, self, undefined, undefined, undefined, 1 );
    current_hud_y = 200;
    powerstruct = spawnstruct();
    powerstruct.hudelem = playerpowersaddhudelem( &"mp_zxp/charged_jump", current_hud_y );
    powerstruct.cooldownsec = getdvarint( @"scr_temp_v_jump_cooldown", 6 );
    powerstruct.ref = "super_jump";
    self.powerstruct = powerstruct;
    function_55c708c5b092a610( 1 );
    thread function_18965c970484c54e();
    thread function_a5367bc4dbaccbad();
    thread function_f9c47ec37512d4d5();
    thread function_64d52a9de1888fc0();
    return true;
}

// Namespace temp_v_jump_superpower
// Params 0
// Checksum 0xf396272c, Offset: 0x403
// Size: 0x8
function function_1e7a7ba4d93f66c0()
{
    return function_1fc78018d6ce59e0();
}

// Namespace temp_v_jump_superpower
// Params 2
// Checksum 0x1bfd6c5, Offset: 0x414
// Size: 0xbb
function function_1fc78018d6ce59e0( fromdeath, attacker )
{
    self endon( #"disconnect" );
    
    while ( !self isonground() && player::isreallyalive( self ) )
    {
        wait 0.1;
    }
    
    thread function_5805871a4ba8cf87();
    self setclientomnvar( "ui_field_upgrade_use", 0 );
    self.powerstruct.hudelem.barelem hud_util::destroyelem();
    self.powerstruct.hudelem hud_util::destroyelem();
    self.powerstruct = undefined;
    function_55c708c5b092a610( 0 );
    self notify( #"superJump_end" );
    thread temp_v::function_6fde086c9d1330d9( undefined, undefined, "super_use_finished" );
}

// Namespace temp_v_jump_superpower
// Params 0
// Checksum 0x79b82cd7, Offset: 0x4d7
// Size: 0x5c
function function_5805871a4ba8cf87()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( !self isonground() && !self isswimming() )
    {
        self.superjumpprotected = 1;
        
        while ( player::isaliveandnotinlaststand( self ) )
        {
            if ( self isonground() )
            {
                waitframe();
                break;
            }
            
            waitframe();
        }
    }
    
    self.superjumpprotected = undefined;
}

// Namespace temp_v_jump_superpower
// Params 0
// Checksum 0x9dbf660d, Offset: 0x53b
// Size: 0x1d
function function_64d52a9de1888fc0()
{
    utility::waittill_any( "death", "last_stand_enter", "player_killed", "tempV_end" );
}

// Namespace temp_v_jump_superpower
// Params 1
// Checksum 0xd9bad51a, Offset: 0x560
// Size: 0x32
function function_55c708c5b092a610( isactive )
{
    if ( isactive )
    {
        val::set( "jump_superpower", "allow_jump", 0 );
        return;
    }
    
    val::reset_all( "jump_superpower" );
}

// Namespace temp_v_jump_superpower
// Params 0
// Checksum 0x3fe50ae2, Offset: 0x59a
// Size: 0x62
function function_a5367bc4dbaccbad()
{
    self endon( #"superJump_end" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        if ( self jumpbuttonpressed() && self isonground() && !self.powerstruct.incooldown )
        {
            playersuperjump();
            continue;
        }
        
        waitframe();
    }
}

// Namespace temp_v_jump_superpower
// Params 0
// Checksum 0x969b5224, Offset: 0x604
// Size: 0x67
function function_f9c47ec37512d4d5()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self endon( #"superJump_end" );
    
    while ( true )
    {
        self waittill( #"hash_76158f9795c6f611" );
        self radiusdamage( self.origin, 256, function_7f4224fe73c6a756(), 50, self, "MOD_CRUSH", "high_jump_mp" );
        thread function_cae30a4d47a1e439();
    }
}

// Namespace temp_v_jump_superpower
// Params 0
// Checksum 0x1e8254fb, Offset: 0x673
// Size: 0x72
function function_7f4224fe73c6a756()
{
    if ( !( isdefined( self.powerstruct ) && isdefined( self.powerstruct.airtime ) ) )
    {
        return 50;
    }
    
    var_5da86aa79d13c6a9 = getdvarfloat( @"hash_710b8f0737994439", 3 );
    multfactor = clamp( self.powerstruct.airtime / var_5da86aa79d13c6a9, 0, 1 );
    return 500 * multfactor;
}

// Namespace temp_v_jump_superpower
// Params 0
// Checksum 0x2a626b38, Offset: 0x6ee
// Size: 0x3f
function function_cae30a4d47a1e439()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self setscriptablepartstate( "heroDiveVfx", "impact", 0 );
    wait 1;
    self setscriptablepartstate( "heroDiveVfx", "off", 0 );
}

// Namespace temp_v_jump_superpower
// Params 2
// Checksum 0xc9adbddb, Offset: 0x735
// Size: 0x43b
function playersuperjump( powerstruct, powerref )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"tempV_end" );
    var_aedc4aa95452d458 = 0.025;
    var_2567142eb6329455 = 0;
    var_57264b3696621053 = 0;
    var_f3dd0d19e337b7bd = 1300;
    var_c8967dd714e558ab = 0.25;
    var_128f7eba76368336 = 1;
    var_c94e8329c2d87e2c = 3;
    shouldoscillate = getdvarint( @"hash_5e1d6a08a06aab7a", var_2567142eb6329455 );
    var_c1cdd62e11b7d616 = getdvarfloat( @"hash_2fc6c2dc7f9c722a", var_aedc4aa95452d458 );
    var_d6176c3e286314b5 = getdvarfloat( @"hash_f3adfe2ba0c4e72e", var_c8967dd714e558ab );
    var_c4f2c4e3a29aab48 = getdvarfloat( @"hash_2a5201ccbcd3b1a1", var_128f7eba76368336 );
    var_2f81976b1022304c = getdvarfloat( @"hash_69111e35067f9d8f", getdvarfloat( @"hash_fc090d66639284d3", var_c94e8329c2d87e2c ) );
    maxjumpvelocity = getdvarfloat( @"hash_fd6822a1c2607510", var_f3dd0d19e337b7bd );
    
    while ( !self jumpbuttonpressed() )
    {
        waitframe();
    }
    
    charge_lock = getdvarint( @"hash_7c6a7ce1709f1eff", var_57264b3696621053 );
    
    if ( charge_lock )
    {
        self.jumplink = spawn( "script_model", self.origin );
        self.jumplink setmodel( "tag_player" );
        self playerlinkto( self.jumplink, "tag_player" );
    }
    
    self.superjumping = 1;
    jumpbar = self.powerstruct.hudelem.barelem;
    fraction = 0;
    up = 1;
    var_99f0d49aff00fc07 = undefined;
    
    while ( self jumpbuttonpressed() )
    {
        jumpbar hud_util::updatebar( fraction, 0 );
        prevfrac = fraction;
        
        if ( up )
        {
            if ( function_b1b620c45e039999() )
            {
                self setscriptablepartstate( "heroDiveVfx", "charge_pause", 0 );
                waitframe();
                continue;
            }
            else if ( function_2b72905101c377a2() )
            {
                up = 0;
            }
            else
            {
                self setscriptablepartstate( "heroDiveVfx", "charge_begin", 0 );
                fraction += var_c1cdd62e11b7d616;
                
                if ( fraction >= 1 )
                {
                    fraction = 1;
                    
                    if ( shouldoscillate )
                    {
                        up = 0;
                    }
                    else if ( var_2f81976b1022304c >= 0 )
                    {
                        if ( !isdefined( var_99f0d49aff00fc07 ) )
                        {
                            var_99f0d49aff00fc07 = gettime() + var_2f81976b1022304c * 1000;
                            thread playerzombiejumpmaxholdwarning( powerref, var_2f81976b1022304c );
                        }
                        
                        if ( gettime() >= var_99f0d49aff00fc07 )
                        {
                            break;
                        }
                    }
                }
                
                if ( prevfrac < var_d6176c3e286314b5 && fraction >= var_d6176c3e286314b5 )
                {
                    jumpbar.bar.color = ( 0, 1, 0 );
                }
            }
        }
        else
        {
            self setscriptablepartstate( "heroDiveVfx", "charge_fail", 0 );
            fraction -= var_c1cdd62e11b7d616;
            
            if ( fraction <= 0 )
            {
                fraction = 0;
                up = 1;
            }
            
            if ( prevfrac > var_d6176c3e286314b5 && fraction <= var_d6176c3e286314b5 )
            {
                jumpbar.bar.color = ( 1, 1, 1 );
            }
        }
        
        waitframe();
    }
    
    self notify( #"hash_c03a7072c36ca50e" );
    
    if ( charge_lock )
    {
        self unlink();
    }
    
    canjump = superjump_canjump();
    
    if ( fraction >= var_d6176c3e286314b5 && canjump )
    {
        if ( fraction < 0.33 )
        {
            self setscriptablepartstate( "heroDiveVfx", "jump_begin_small", 0 );
        }
        else if ( fraction < 0.66 )
        {
            self setscriptablepartstate( "heroDiveVfx", "jump_begin_med", 0 );
        }
        else
        {
            self setscriptablepartstate( "heroDiveVfx", "jump_begin_lrg", 0 );
        }
        
        player_angles = self getplayerangles();
        self setscriptablepartstate( "heroDiveVfx", "jump_begin", 0 );
        thread function_899bc8cee9a0f14d();
        playerapplyjumpvelocity( player_angles, maxjumpvelocity, fraction );
    }
    else
    {
        self setscriptablepartstate( "heroDiveVfx", "charge_fail", 0 );
        
        if ( var_c4f2c4e3a29aab48 )
        {
            jumpbar.bar.frac = 0;
        }
    }
    
    function_44d7d71cd4b9adda( powerstruct, powerref, 1 );
}

// Namespace temp_v_jump_superpower
// Params 0
// Checksum 0xfa7aec7b, Offset: 0xb78
// Size: 0x9, Type: bool
function function_63bafaad2214c27b()
{
    return !superjump_canjump();
}

// Namespace temp_v_jump_superpower
// Params 1
// Checksum 0x29da84ea, Offset: 0xb8a
// Size: 0x10f, Type: bool
function superjump_canjump( raycastheight = 100 )
{
    if ( self isinexecutionattack() || self isinexecutionvictim() )
    {
        return false;
    }
    
    if ( self ismantling() )
    {
        return false;
    }
    
    if ( !self isonground() || self isswimming() )
    {
        return false;
    }
    
    if ( !player::isaliveandnotinlaststand( self ) )
    {
        return false;
    }
    
    if ( self getstance() == "prone" )
    {
        return false;
    }
    
    if ( isdefined( self.carryobject ) )
    {
        return false;
    }
    
    raystart = utility::function_68061c3d21a6d57a();
    radius = 16;
    rayend = utility::function_f02ebab438642e16() + anglestoup( self.angles ) * raycastheight;
    contents = trace::create_default_contents( 1 );
    
    /#
        level thread debug::drawsphere( raystart, radius, 10, ( 0, 1, 0 ) );
        level thread debug::drawsphere( rayend, radius, 10, ( 0, 1, 0 ) );
    #/
    
    if ( !trace::sphere_trace_passed( raystart, rayend, radius, self, contents ) )
    {
        return false;
    }
    
    return true;
}

// Namespace temp_v_jump_superpower
// Params 0
// Checksum 0xdf74378d, Offset: 0xca2
// Size: 0x4a, Type: bool
function function_2b72905101c377a2()
{
    if ( self isinexecutionattack() || self isinexecutionvictim() )
    {
        return true;
    }
    
    if ( !self isonground() || self isswimming() )
    {
        return true;
    }
    
    if ( !player::isaliveandnotinlaststand( self ) )
    {
        return true;
    }
    
    if ( isdefined( self.carryobject ) )
    {
        return true;
    }
    
    return false;
}

// Namespace temp_v_jump_superpower
// Params 0
// Checksum 0xf241d39e, Offset: 0xcf5
// Size: 0x1f, Type: bool
function function_b1b620c45e039999()
{
    if ( self ismantling() )
    {
        return true;
    }
    
    if ( self getstance() == "prone" )
    {
        return true;
    }
    
    return false;
}

// Namespace temp_v_jump_superpower
// Params 2
// Checksum 0x58584fe2, Offset: 0xd1d
// Size: 0x1a3
function playerpowersaddhudelem( label, currenthudy )
{
    hudelem = hud_util::createfontstring( "default", 1.5 );
    hudelem.alignx = "left";
    hudelem.aligny = "top";
    hudelem.horzalign = "left_adjustable";
    hudelem.vertalign = "top_adjustable";
    hudelem.alpha = 1;
    hudelem.glowalpha = 0;
    hudelem.hidewheninmenu = 1;
    hudelem.archived = 0;
    
    if ( isdefined( label ) )
    {
        hudelem.label = label;
    }
    
    barelem = hud_util::createbar( ( 1, 1, 1 ), 160, 14 );
    barelem.x = 13;
    barelem.y = currenthudy;
    barelem.alignx = "left";
    barelem.aligny = "top";
    barelem.horzalign = "left_adjustable";
    barelem.vertalign = "top_adjustable";
    barelem shiftbar();
    barelem.archived = 0;
    barelem.hidewheninmenu = 1;
    barelem.bar.archived = 0;
    barelem.bar.hidewheninmenu = 1;
    hudelem.barelem = barelem;
    return hudelem;
}

// Namespace temp_v_jump_superpower
// Params 4
// Checksum 0x7c55905e, Offset: 0xec9
// Size: 0xf1
function shiftbar( point, relativepoint, xoffset, yoffset )
{
    self.bar.horzalign = self.horzalign;
    self.bar.vertalign = self.vertalign;
    self.bar.alignx = "left";
    self.bar.aligny = self.aligny;
    self.bar.y = self.y + 2;
    self.bar.x = self.x + 2;
    hud_util::updatebar( self.bar.frac );
}

// Namespace temp_v_jump_superpower
// Params 2
// Checksum 0x547c2c94, Offset: 0xfc2
// Size: 0x11c
function playerzombiejumpmaxholdwarning( powerref, time )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"zombie_unset" );
    self endon( #"hash_b05e9bc67fd87802" );
    self endon( #"hash_c03a7072c36ca50e" );
    
    if ( time <= 0 )
    {
        return;
    }
    
    jumpbar = self.powerstruct.hudelem.barelem;
    waittimes = br_circle::array_init_distribute( time, int( time * 5 ), 1 );
    color = 1;
    
    for ( i = 0; i < waittimes.size ; i++ )
    {
        if ( color )
        {
            jumpbar.bar.color = ( 1, 0, 0 );
        }
        else
        {
            jumpbar.bar.color = ( 0, 1, 0 );
        }
        
        wait waittimes[ i ];
        color = !color;
    }
}

// Namespace temp_v_jump_superpower
// Params 3
// Checksum 0xe4f6dcd3, Offset: 0x10e6
// Size: 0x295
function playerapplyjumpvelocity( angledir, maxjumpvelocity, fraction )
{
    var_bec4d8001ab9cc86 = 1;
    player_angles = angledir;
    movementdir = vectornormalize( self getvelocity() );
    forwarddir = anglestoforward( self.angles );
    dot = vectordot( movementdir, forwarddir );
    ismovingforward = dot > 0.875 || dot == 0;
    var_fba9a521784fb5c8 = dot == 0;
    
    if ( !ismovingforward )
    {
        movementtoangles = vectortoangles( movementdir );
        player_angles = ( player_angles[ 0 ], movementtoangles[ 1 ], movementtoangles[ 2 ] );
    }
    
    if ( getdvarint( @"hash_ce6d7d66848cdbcc", var_bec4d8001ab9cc86 ) )
    {
        ground_normal = get_ground_normal();
        
        if ( !isdefined( ground_normal ) )
        {
            ground_normal = ( 0, 0, 1 );
        }
        
        yawangles = ( 0, player_angles[ 1 ], 0 );
        right = anglestoright( yawangles );
        fwd = vectorcross( ground_normal, right );
        [ ground_pitch ] = vectortoangles( fwd );
        min_pitch = -85;
        max_pitch = ground_pitch;
        player_pitch = player_angles[ 0 ];
        
        if ( ground_pitch > 90 || ground_pitch < -90 )
        {
            ground_pitch = ground_pitch % 90 * -1;
        }
        
        if ( player_pitch > ground_pitch )
        {
            player_pitch = ground_pitch;
        }
        
        var_d01e318b66fb6024 = getdvarfloat( @"hash_9ec479015407c245", -45 );
        var_cffb3f8b66d53736 = getdvarfloat( @"hash_9ee78301542e1ffb", 0 );
        frac = ( player_pitch - min_pitch ) / ( max_pitch - min_pitch );
        pitch_correction = var_cffb3f8b66d53736 + frac * ( var_d01e318b66fb6024 - var_cffb3f8b66d53736 );
        player_angles = ( player_pitch + pitch_correction, player_angles[ 1 ], player_angles[ 2 ] );
    }
    
    pitch_add = getdvarfloat( @"hash_cf56037c34ea141f", 0 );
    
    if ( pitch_add != 0 )
    {
        player_angles = ( player_angles[ 0 ] + pitch_add, player_angles[ 1 ], player_angles[ 2 ] );
    }
    
    dir = anglestoforward( player_angles );
    
    if ( var_fba9a521784fb5c8 && getdvarint( @"hash_2a37e3953d179dd8", 0 ) )
    {
        dir = ground_normal;
    }
    
    velocity = dir * fraction * maxjumpvelocity;
    self setorigin( self.origin + ( 0, 0, 20 ) );
    self setvelocity( velocity );
}

// Namespace temp_v_jump_superpower
// Params 3
// Checksum 0x52ad2811, Offset: 0x1383
// Size: 0x52
function function_44d7d71cd4b9adda( powerstruct, powerref, docooldown )
{
    if ( docooldown )
    {
        thread playerpowerstartcooldown( powerstruct, powerref );
    }
    
    if ( isdefined( self.jumplink ) )
    {
        self.jumplink delete();
    }
    
    self.superjumping = undefined;
}

// Namespace temp_v_jump_superpower
// Params 2
// Checksum 0x4bf24114, Offset: 0x13dd
// Size: 0x1d1
function playerpowerstartcooldown( powerstruct, powerref )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"tempv_unset" );
    self endon( #"tempv_set" );
    self endon( #"superJump_end" );
    self endon( #"disablecooldown" );
    
    if ( !isdefined( self.powerstruct ) || self.powerstruct.incooldown )
    {
        return;
    }
    
    powerbar = self.powerstruct.hudelem.barelem;
    
    if ( powerbar.bar.frac > 0 )
    {
        self.powerstruct.incooldown = 1;
        cooldownsec = self.powerstruct.cooldownsec;
        fraction = powerbar.bar.frac;
        cooldownsec *= fraction;
        powerbar.bar.color = ( 1, 0.6, 0 );
        powerbar.bar scaleovertime( cooldownsec, 0, powerbar.height );
        self setclientomnvar( "ui_super_high_jump_progress", int( fraction * 100 ) );
        wait cooldownsec;
        function_55c708c5b092a610( 1 );
        self.powerstruct.incooldown = 0;
        self notify( #"hash_fcbcbca84ae21c05" );
    }
    else
    {
        powerbar hud_util::updatebar( 0, 0 );
    }
    
    powerbar.bar.color = ( 1, 1, 1 );
}

// Namespace temp_v_jump_superpower
// Params 2
// Checksum 0x22373b24, Offset: 0x15b6
// Size: 0x290
function get_ground_normal( traceignore, debug )
{
    if ( !isdefined( traceignore ) )
    {
        ignore = self;
    }
    else
    {
        ignore = traceignore;
    }
    
    if ( !isdefined( debug ) )
    {
        debug = 0;
    }
    
    ignorelist = [ ignore ];
    tracepoints = [ self.origin ];
    i = -1;
    
    while ( i <= 1 )
    {
        j = -1;
        
        while ( j <= 1 )
        {
            corner = ignore getpointinbounds( i, j, 0 );
            corner = ( corner[ 0 ], corner[ 1 ], self.origin[ 2 ] );
            tracepoints[ tracepoints.size ] = corner;
            j += 2;
        }
        
        i += 2;
    }
    
    avgnormal = ( 0, 0, 0 );
    tracehitcount = 0;
    
    foreach ( point in tracepoints )
    {
        trace = trace::_bullet_trace( point + ( 0, 0, 4 ), point + ( 0, 0, -16 ), 0, ignorelist );
        tracehit = trace[ "fraction" ] > 0 && trace[ "fraction" ] < 1;
        
        if ( tracehit )
        {
            avgnormal += trace[ "normal" ];
            tracehitcount++;
        }
        
        /#
            if ( debug )
            {
                if ( tracehit )
                {
                    line( point, point + trace[ "<dev string:x24>" ] * 30, ( 0, 1, 0 ) );
                    continue;
                }
                
                sphere( point, 3, ( 1, 0, 0 ) );
            }
        #/
    }
    
    if ( tracehitcount > 0 )
    {
        avgnormal /= tracehitcount;
        
        /#
            if ( debug )
            {
                line( self.origin, self.origin + avgnormal * 20, ( 1, 1, 1 ) );
            }
        #/
        
        return avgnormal;
    }
    
    /#
        if ( debug )
        {
            sphere( self.origin, 5, ( 1, 0, 0 ) );
        }
    #/
    
    return;
}

// Namespace temp_v_jump_superpower
// Params 0
// Checksum 0x9fb3af02, Offset: 0x184e
// Size: 0x1a
function function_a9b72d9db6c44839()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
}

// Namespace temp_v_jump_superpower
// Params 0
// Checksum 0xa32b8bc8, Offset: 0x1870
// Size: 0x29, Type: bool
function function_383d4875c41b8831()
{
    return isdefined( self.powerstruct ) && self.powerstruct.ref == "super_jump";
}

// Namespace temp_v_jump_superpower
// Params 0
// Checksum 0x40f9402, Offset: 0x18a2
// Size: 0xba
function function_899bc8cee9a0f14d()
{
    self endon( #"death_or_disconnect" );
    self endon( #"superJump_end" );
    level endon( #"game_ended" );
    
    if ( !isdefined( self.powerstruct ) )
    {
        return;
    }
    
    self.powerstruct.airtime = 0;
    
    while ( isdefined( self.powerstruct ) )
    {
        if ( self isonground() )
        {
            if ( self.powerstruct.airtime > 0 )
            {
                break;
            }
        }
        else
        {
            self.powerstruct.airtime += level.framedurationseconds;
        }
        
        waitframe();
    }
    
    function_55c708c5b092a610( 0 );
}

// Namespace temp_v_jump_superpower
// Params 0
// Checksum 0x9d719f2c, Offset: 0x1964
// Size: 0x60
function function_18965c970484c54e()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( #"superJump_end" );
    self endon( #"temp_v_finished" );
    
    while ( true )
    {
        if ( self isonladder() || self ishanging() )
        {
            function_55c708c5b092a610( 0 );
        }
        else
        {
            function_55c708c5b092a610( 1 );
        }
        
        waitframe();
    }
}

