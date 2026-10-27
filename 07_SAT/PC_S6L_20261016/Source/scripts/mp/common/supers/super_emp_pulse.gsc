// scripts\mp\common\supers\super_emp_pulse.gsc  (hash_7a6e17e009b0c7e5.gscc) (size: 14431 Bytes / 0x385f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x97b26adc (2545052380)
// size ...... 14431 (0x385f)
// includes .. 19  (offset: 0x3573)
// strings ... 36  (offset: 0x360b)
// dev strs .. 1   (offset: 0x3853)
// exports ... 40  (offset: 0x20cb)
// cseg ...... 0x2ff + 0x1dcc (0x20cb)
// imports ... 121 (offset: 0x270b)
// animtree1 . 0   (offset: 0x385f)
// animtree2 . 0   (offset: 0x385f)
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\emp_debuff;
#using scripts\mp\gamescore;
#using scripts\mp\scripted_weapons;
#using scripts\mp\supers;
#using scripts\mp\talking_gun;

#namespace super_emp_pulse;

// Namespace super_emp_pulse
// Params 0, eflags: 0x1
// Checksum 0xa201bd2d, Offset: 0x31d
// Size: 0x9
function autoexec main()
{
    emppulse_init();
}

// Namespace super_emp_pulse
// Params 0
// Checksum 0xe05d0fb6, Offset: 0x32e
// Size: 0x132
function emppulse_init()
{
    utility::flag_wait( "supers_initialized" );
    supers_mp::function_48aaa60b2ce7b8a1( "super_emp_pulse", undefined, &emppulse_unset, &emppulse_beginuse, &function_605654f2a971d056, undefined, &emppulse_ongive, undefined, undefined, undefined );
    utility::registersharedfunc( #"super_emp_pulse", #"hash_74c6903d2738b02c", &function_51c8c54769ba0adf );
    utility::registersharedfunc( #"super_emp_pulse", #"hash_443ff395a15388c5", &function_6d118e44521bcb66 );
    
    if ( !isdefined( level.superglobals.staticsuperdata[ "super_emp_pulse" ] ) )
    {
        return;
    }
    
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_emp_pulse" );
    
    if ( isdefined( bundle.var_db3f56495d27ecf7 ) )
    {
        level.superglobals.staticsuperdata[ "super_emp_pulse" ].deployweapon = bundle.var_db3f56495d27ecf7;
    }
    
    level.superglobals.staticsuperdata[ "super_emp_pulse" ].var_1836be75d110dd2f = &function_fbddc742ed0148cc;
    level.super_emp_pulse_throttle = throttle::throttle_initialize( "super_emp_pulse_throttle", 1, 0.3 );
    
    /#
        level thread function_9ab9f585c7f33526();
    #/
}

// Namespace super_emp_pulse
// Params 0
// Checksum 0x7a4eaaa, Offset: 0x468
// Size: 0xbd
function function_9ab9f585c7f33526()
{
    setdvar( @"hash_65941c6cedcf813d", 0 );
    
    while ( true )
    {
        while ( getdvarint( @"hash_65941c6cedcf813d", 0 ) == 0 )
        {
            wait 0.5;
        }
        
        foreach ( player in level.players )
        {
            player function_77419f587f594a7d();
        }
        
        setdvar( @"hash_65941c6cedcf813d", 0 );
    }
}

// Namespace super_emp_pulse
// Params 0
// Checksum 0x493da792, Offset: 0x52d
// Size: 0x39
function function_51c8c54769ba0adf()
{
    var_dae0649b0fde1bae = level.superglobals.var_da0d0ae8681f98ba[ "super_emp_pulse" ];
    supers_mp::function_2ea603a86a682ab0( var_dae0649b0fde1bae );
    function_6d118e44521bcb66( 1 );
}

// Namespace super_emp_pulse
// Params 0
// Checksum 0xe9a7c697, Offset: 0x56e
// Size: 0x4, Type: bool
function function_fbddc742ed0148cc()
{
    return true;
}

// Namespace super_emp_pulse
// Params 0
// Checksum 0x8d2d0ecf, Offset: 0x57b
// Size: 0x16
function emppulse_beginuse()
{
    result = function_3132cba20f34af14();
    return result;
}

// Namespace super_emp_pulse
// Params 0
// Checksum 0x76a88302, Offset: 0x59a
// Size: 0x1e
function emppulse_unset()
{
    function_6d118e44521bcb66( 0 );
    supers_mp::function_2ea603a86a682ab0( 0 );
    self notify( #"hash_44516ac42a9842dc" );
}

// Namespace super_emp_pulse
// Params 0
// Checksum 0x6e76af04, Offset: 0x5c0
// Size: 0x40
function emppulse_ongive()
{
    var_75be138ef6695394 = level.superglobals.var_da0d0ae8681f98ba[ "super_emp_pulse" ];
    supers_mp::function_2ea603a86a682ab0( var_75be138ef6695394 );
    function_6d118e44521bcb66( 1 );
    thread function_ea179c615d383845();
}

// Namespace super_emp_pulse
// Params 0
// Checksum 0x74629e6c, Offset: 0x608
// Size: 0x69
function function_ea179c615d383845()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"super_use_finished" );
    self endon( #"hash_44516ac42a9842dc" );
    
    while ( true )
    {
        self waittill( #"super_use_charging" );
        
        if ( supers_mp::issuperready() )
        {
            continue;
        }
        
        if ( supers_mp::issuperinuse() )
        {
            continue;
        }
        
        emppulse_unset();
        break;
    }
}

// Namespace super_emp_pulse
// Params 0
// Checksum 0x1a6ca271, Offset: 0x679
// Size: 0x11
function emppulse_ontake()
{
    function_6d118e44521bcb66( 0 );
    supers_mp::function_29f357380e385305();
}

// Namespace super_emp_pulse
// Params 0
// Checksum 0x90ce3a7c, Offset: 0x692
// Size: 0x7c
function function_3132cba20f34af14()
{
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_emp_pulse" );
    
    if ( bundle.weapontype == "OFFHANDWEAPON" )
    {
        return function_77419f587f594a7d( bundle );
    }
    
    objweapon = scripted_weapons::get_scripted_weapon_object( #"ddos_device" );
    deploysuccess = weapon_utility::giveandfireoffhandreliable( objweapon );
    
    if ( deploysuccess )
    {
        return function_77419f587f594a7d( bundle );
    }
    
    return supers_mp::refundsuper();
}

// Namespace super_emp_pulse
// Params 1
// Checksum 0xf07800a0, Offset: 0x716
// Size: 0xdf, Type: bool
function function_77419f587f594a7d( bundle )
{
    time = bundle.emppulsedelaytime ?? 0.65;
    self setclientomnvar( "ui_super_ddos_screen_on", 1 );
    wait time;
    emppulse_ontake();
    thread function_c3a57aa492347d02();
    thread function_9a34eb83c3d52ace();
    thread function_7a5076e8f9efc8c();
    ddos_ent = {};
    ddos_ent.owner = self;
    challenges::function_4fd386d590e901d8( ddos_ent, #"hash_c50cf868c6994df3", #"use" );
    challengeparams = { #fieldupgraderef:"super_emp_pulse", #fieldupgradeent:ddos_ent, #fieldupgradeowner:self };
    ddos_ent callback::callback( #"hash_2af4adf11224c49a", challengeparams );
    talking_gun::talkinggun_event( self, #"equipment_deployed" );
    return true;
}

// Namespace super_emp_pulse
// Params 1
// Checksum 0xef18a598, Offset: 0x7fe
// Size: 0x40
function function_6d118e44521bcb66( isenabled )
{
    if ( isenabled )
    {
        self setclientomnvar( "ui_emp_target_detector_on_give_widget", 1 );
        thread function_ea42c0f9d36201cd();
        return;
    }
    
    self notify( #"hash_21f0faeea2558e01" );
    self setclientomnvar( "ui_emp_target_detector_on_give_widget", 0 );
}

// Namespace super_emp_pulse
// Params 0
// Checksum 0xdec42c2f, Offset: 0x846
// Size: 0xb3
function function_ea42c0f9d36201cd()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_21f0faeea2558e01" );
    maxdist = sqrt( 4562500 );
    
    while ( true )
    {
        numents = function_7517ae25c89781f5( emp_debuff::empdebuff_get_emp_ents( self.origin, maxdist ), self.origin, self.angles ).size;
        numents = int( clamp( numents, 0, 5 ) );
        widgetval = numents + 1;
        self setclientomnvar( "ui_emp_target_detector_on_give_widget", widgetval );
        throttle::throttle_wait_in_queue( level.super_emp_pulse_throttle, self );
    }
}

// Namespace super_emp_pulse
// Params 0
// Checksum 0x75a9f07b, Offset: 0x901
// Size: 0x2c
function function_7a5076e8f9efc8c()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    wait 0.88;
    self setclientomnvar( "ui_super_ddos_screen_on", 0 );
}

// Namespace super_emp_pulse
// Params 0
// Checksum 0x8f7196e6, Offset: 0x935
// Size: 0x4d
function function_c3a57aa492347d02()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self setscriptablepartstate( "DDoSPulse", "pulse", 0 );
    utility::waittill_any( "death", "scramble_clear" );
    self setscriptablepartstate( "DDoSPulse", "off", 0 );
}

// Namespace super_emp_pulse
// Params 1
// Checksum 0xf3baa37, Offset: 0x98a
// Size: 0x377
function function_d5177505a82d3af4( objweapon )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    level endon( #"round_end" );
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_emp_pulse" );
    blastangles = self.angles;
    blastorigin = self.origin;
    step = 100;
    maxdist = 750;
    waittime = 0.1;
    currentdist = step;
    empdist = sqrt( 4562500 );
    possibleplayers = getplayersinradius( self.origin, empdist );
    possibleents = emp_debuff::empdebuff_get_emp_ents( self.origin, empdist );
    var_d0572c11f933f8de = function_84ba22850162ac73( possibleplayers, blastorigin, blastangles );
    var_96d56c64f9183496 = function_7517ae25c89781f5( possibleents, blastorigin, blastangles, 1 );
    slidingdoors = getentarray( "door_trigger", #targetname );
    
    while ( currentdist <= maxdist )
    {
        currentdistsq = currentdist * currentdist;
        playersleft = [];
        
        for ( i = 0; i < var_d0572c11f933f8de.size ; i++ )
        {
            victim = var_d0572c11f933f8de[ i ][ "player" ];
            
            if ( !function_8a11d8f339c02617( self, victim ) )
            {
                continue;
            }
            
            if ( var_d0572c11f933f8de[ i ][ "isPulsed" ] )
            {
                continue;
            }
            
            horizdistsq = var_d0572c11f933f8de[ i ][ "horizDistSq" ];
            vertdistsq = var_d0572c11f933f8de[ i ][ "vertDistSq" ];
            
            if ( horizdistsq + vertdistsq <= currentdistsq )
            {
                data = damage_utility::packdamagedata( self, victim, 1, objweapon, "MOD_EXPLOSIVE", self, self.origin );
                thread emppulse_apply_player( data, emppulse_getduration( victim ) );
                var_d0572c11f933f8de[ i ][ "isPulsed" ] = 1;
                continue;
            }
            
            playersleft[ playersleft.size ] = var_d0572c11f933f8de[ i ];
        }
        
        var_d0572c11f933f8de = playersleft;
        entsleft = [];
        
        for ( j = 0; j < var_96d56c64f9183496.size ; j++ )
        {
            ent = var_96d56c64f9183496[ j ][ "entity" ];
            
            if ( !function_8a11d8f339c02617( self, ent ) )
            {
                continue;
            }
            
            if ( var_96d56c64f9183496[ j ][ "isPulsed" ] )
            {
                continue;
            }
            
            if ( var_96d56c64f9183496[ j ][ "horizDistSq" ] <= currentdistsq )
            {
                if ( var_96d56c64f9183496[ j ][ "vertDistSq" ] <= 4000000 )
                {
                    if ( isagent( ent ) )
                    {
                        ent dodamage( 1, ent.origin, self, self, "MOD_EXPLOSIVE" );
                        ent notify( #"flashbang", ( 0, 0, 0 ), 1, 1, self, self.team, 2 );
                    }
                    
                    data = damage_utility::packdamagedata( self, ent, 1, objweapon, "MOD_EXPLOSIVE", self, self.origin );
                    data.var_4540f9188cfebe7e = bundle.var_79753068e4b78519;
                    thread function_565a076eff3ce127( data, emppulse_getduration( ent ) );
                    var_96d56c64f9183496[ j ][ "isPulsed" ] = 1;
                }
                
                continue;
            }
            
            entsleft[ entsleft.size ] = var_96d56c64f9183496[ j ];
        }
        
        var_96d56c64f9183496 = entsleft;
        
        if ( currentdist < maxdist && currentdist + step >= maxdist )
        {
            currentdist = maxdist;
        }
        else
        {
            currentdist += step;
        }
        
        wait waittime;
    }
}

// Namespace super_emp_pulse
// Params 2
// Checksum 0x66c3375a, Offset: 0xd09
// Size: 0x3ea, Type: bool
function function_8a11d8f339c02617( attacker, victim )
{
    if ( !isdefined( victim ) )
    {
        return false;
    }
    
    if ( level.var_5ee9a89b9f9b984b && isdefined( victim.towerstruct ) && isdefined( victim.towerstruct.uav_station ) )
    {
        if ( !isdefined( victim.towerstruct.uav_station.activeteam ) )
        {
            return true;
        }
        else
        {
            return ( victim.towerstruct.uav_station.activeteam != attacker.team );
        }
    }
    
    if ( level.var_f3618d8d14b87c3d )
    {
        if ( victim.isslidingdoor )
        {
            return true;
        }
    }
    
    if ( level.var_19f47b06ad6b40a4 )
    {
        if ( victim.var_78ff42993c4d2fdf )
        {
            return true;
        }
    }
    
    if ( isdefined( victim.type ) )
    {
        if ( level.var_c7c34c7053a29846 )
        {
            if ( victim.isredeploydrone )
            {
                return true;
            }
        }
        
        if ( isdefined( level.deployablekiosks ) && level.deployablekiosks.var_fe3437bbc52ad866 )
        {
            if ( victim.type == "portable_buy_drone" )
            {
                return ( victim.team != attacker.team );
            }
        }
        
        if ( isdefined( level.br_armory_kiosk ) && level.br_armory_kiosk.var_e253c9f921155d75 )
        {
            if ( issubstr( victim.type, "br_plunder_box" ) )
            {
                return true;
            }
        }
        
        if ( isdefined( level.br_armory_trader ) && level.br_armory_trader.var_d5ce984c3e990698 )
        {
            if ( issubstr( victim.type, "br_armory_trader" ) )
            {
                return true;
            }
        }
    }
    
    if ( isdefined( level.holdprop ) && isdefined( victim.stronghold ) && level.holdprop.canemp )
    {
        if ( !isdefined( victim.stronghold.capturedteam ) )
        {
            return true;
        }
        else
        {
            return ( victim.stronghold.capturedteam != attacker.team );
        }
    }
    
    if ( victim.var_94dbe7695ac27ed7 )
    {
        return true;
    }
    
    if ( isagent( victim ) )
    {
        return true;
    }
    
    if ( isplayer( victim ) )
    {
        if ( victim isplayerheadless() )
        {
            return false;
        }
        
        if ( victim == attacker )
        {
            return false;
        }
        
        if ( !player::isreallyalive( victim ) )
        {
            return false;
        }
        
        if ( !player_utility::playersareenemies( attacker, victim ) && !getdvarint( @"hash_58254c61de76bffe", 0 ) )
        {
            return false;
        }
        
        if ( victim utility::isusingremote() )
        {
            return false;
        }
        
        if ( isdefined( victim.var_7c7055c704fc70b8 ) )
        {
            return false;
        }
        else
        {
            return true;
        }
    }
    else
    {
        if ( victim.isdestroyed )
        {
            return false;
        }
        
        entowner = victim.owner;
        
        if ( isdefined( entowner ) )
        {
            if ( entowner == attacker && !getdvarint( @"hash_58254c61de76bffe", 0 ) )
            {
                return false;
            }
            
            if ( !player_utility::playersareenemies( attacker, entowner ) && !getdvarint( @"hash_58254c61de76bffe", 0 ) )
            {
                return false;
            }
        }
        
        team = victim.team;
        
        if ( isdefined( team ) )
        {
            if ( team == attacker.team && !getdvarint( @"hash_58254c61de76bffe", 0 ) )
            {
                return false;
            }
        }
        
        if ( victim vehicle::is_vehicle() && !vehicle::is_enemy_to_player( victim, attacker ) )
        {
            return false;
        }
        
        if ( isdefined( victim.vehicle ) && victim.vehicle vehicle::is_vehicle() && !vehicle::is_enemy_to_player( victim.vehicle, attacker ) )
        {
            return false;
        }
        
        return true;
    }
    
    return false;
}

// Namespace super_emp_pulse
// Params 2, eflags: 0x4
// Checksum 0xf74df1af, Offset: 0x10fc
// Size: 0x2f
function private function_e083f60285fb9d4f( a, b )
{
    if ( a[ "horizDistSq" ] < b[ "horizDistSq" ] )
    {
        return 1;
    }
    
    return 0;
}

// Namespace super_emp_pulse
// Params 3
// Checksum 0xafeeacdd, Offset: 0x1133
// Size: 0x1b2
function function_84ba22850162ac73( sourcearray, reforigin, refangles )
{
    filteredplayers = [];
    
    foreach ( player in sourcearray )
    {
        if ( !function_8a11d8f339c02617( self, player ) )
        {
            continue;
        }
        
        sourceforward = anglestoforward( refangles );
        sourceup = anglestoup( refangles );
        var_9c8bd9d7fcdfc63b = player.origin - reforigin;
        vertdist = vectordot( var_9c8bd9d7fcdfc63b, sourceup );
        horizdist = vectordot( var_9c8bd9d7fcdfc63b, sourceforward );
        
        if ( abs( vertdist ) > 2000 )
        {
            continue;
        }
        
        if ( abs( horizdist ) > 750 )
        {
            continue;
        }
        
        var_49e5d679a0c24c84 = anglestoforward( refangles );
        anglediff = math::anglebetweenvectorssigned( var_49e5d679a0c24c84, var_9c8bd9d7fcdfc63b, ( 0, 0, 1 ) );
        
        if ( abs( anglediff ) > 110 )
        {
            continue;
        }
        
        index = filteredplayers.size;
        filteredplayers[ index ][ "player" ] = player;
        filteredplayers[ index ][ "vertDistSq" ] = vertdist * vertdist;
        filteredplayers[ index ][ "horizDistSq" ] = horizdist * horizdist;
        filteredplayers[ index ][ "isPulsed" ] = 0;
    }
    
    filteredplayers = arraysort( filteredplayers, undefined, &function_e083f60285fb9d4f );
    return filteredplayers;
}

// Namespace super_emp_pulse
// Params 4
// Checksum 0xca397b5f, Offset: 0x12ee
// Size: 0x1d8
function function_7517ae25c89781f5( sourcearray, reforigin, refangles, sort )
{
    filteredents = [];
    sourceforward = anglestoforward( refangles );
    sourceup = anglestoup( refangles );
    sourceside = anglestoright( refangles );
    
    foreach ( ent in sourcearray )
    {
        if ( !function_8a11d8f339c02617( self, ent ) )
        {
            continue;
        }
        
        var_9c8bd9d7fcdfc63b = ent.origin - reforigin;
        vertdist = vectordot( var_9c8bd9d7fcdfc63b, sourceup );
        
        if ( abs( vertdist ) > 2000 )
        {
            continue;
        }
        
        horizdistsq = pow( vectordot( var_9c8bd9d7fcdfc63b, sourceforward ), 2 ) + pow( abs( vectordot( var_9c8bd9d7fcdfc63b, sourceside ) ), 2 );
        
        if ( abs( horizdistsq ) > 562500 )
        {
            continue;
        }
        
        anglediff = math::anglebetweenvectorssigned( sourceforward, var_9c8bd9d7fcdfc63b, ( 0, 0, 1 ) );
        
        if ( abs( anglediff ) > 110 )
        {
            continue;
        }
        
        index = filteredents.size;
        filteredents[ index ][ "entity" ] = ent;
        filteredents[ index ][ "horizDistSq" ] = horizdistsq;
        filteredents[ index ][ "vertDistSq" ] = vertdist * vertdist;
        filteredents[ index ][ "isPulsed" ] = 0;
    }
    
    if ( sort )
    {
        filteredents = arraysort( filteredents, undefined, &function_e083f60285fb9d4f );
    }
    
    return filteredents;
}

// Namespace super_emp_pulse
// Params 0
// Checksum 0xeab25431, Offset: 0x14cf
// Size: 0x62
function function_9a34eb83c3d52ace()
{
    self endon( #"disconnect" );
    objweapon = scripted_weapons::get_scripted_weapon_object( #"emp_pulse" );
    thread function_ac6456974c2f73b();
    self earthquakeforplayer( 0.2, 1, self.origin, 2000 );
    thread function_7714c47290d5a290( objweapon );
    function_d5177505a82d3af4( objweapon );
    function_605654f2a971d056();
}

// Namespace super_emp_pulse
// Params 0
// Checksum 0xe5007472, Offset: 0x1539
// Size: 0x52
function function_ac6456974c2f73b()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self setscriptablepartstate( "DDoSBlast", "initial_blast", 0 );
    utility::waittill_any_timeout( 1, "death", "scramble_clear" );
    self setscriptablepartstate( "DDoSBlast", "off", 0 );
}

// Namespace super_emp_pulse
// Params 1
// Checksum 0x74afb26b, Offset: 0x1593
// Size: 0x164
function function_7714c47290d5a290( objweapon )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self notify( #"hash_59d4487dd37c5b77" );
    self endon( #"hash_59d4487dd37c5b77" );
    scrambletime = gettime() + 6000;
    waittime = 0.1;
    
    while ( gettime() < scrambletime && !level.gameended )
    {
        players = getplayersinradius( self.origin, 500 );
        
        foreach ( player in players )
        {
            if ( !function_8a11d8f339c02617( self, player ) )
            {
                continue;
            }
            
            if ( !isdefined( player.var_7c7055c704fc70b8 ) )
            {
                data = damage_utility::packdamagedata( self, player, 1, objweapon, "MOD_EXPLOSIVE", self, self.origin );
                player thread emppulse_apply_player( data, emppulse_getduration( player ) );
            }
        }
        
        wait waittime;
    }
    
    self notify( #"scramble_clear" );
}

// Namespace super_emp_pulse
// Params 1
// Checksum 0x2e7d400d, Offset: 0x16ff
// Size: 0x10a
function function_ba09c24ad8a35c48( target )
{
    if ( !isdefined( self.var_d63e1c5704eb4fe0 ) )
    {
        self.var_d63e1c5704eb4fe0 = [];
    }
    
    entitynum = target getentitynumber();
    lifeindex = self.matchdatalifeindex ?? 0;
    
    if ( !isdefined( self.var_d63e1c5704eb4fe0[ entitynum ] ) || self.var_d63e1c5704eb4fe0[ entitynum ] > lifeindex )
    {
        self.var_d63e1c5704eb4fe0[ entitynum ] = lifeindex;
        
        if ( utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
        {
            self thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( #"emped_player" );
        }
        
        if ( isdefined( self.super ) )
        {
            if ( !isdefined( self.super.hitcount ) )
            {
                self.super.hitcount = 1;
            }
            
            self.super.hitcount++;
        }
    }
}

// Namespace super_emp_pulse
// Params 2
// Checksum 0xe8ed55f5, Offset: 0x1811
// Size: 0x1ab
function function_565a076eff3ce127( data, time )
{
    var_6dc1a273e8093071 = 0;
    
    if ( getdvarint( @"hash_10320e52e3e9ab5c", 0 ) )
    {
        var_6dc1a273e8093071 = 1;
    }
    
    attacker = self;
    var_35133ea1d74d7e08 = function_9f2d28ab468acb9a( self );
    victim = data.victim;
    
    if ( !( isdefined( attacker ) && isdefined( victim ) ) )
    {
        return;
    }
    
    if ( victim.var_d3e808f0b14d5c69 > 0 )
    {
        time = victim.var_d3e808f0b14d5c69;
    }
    
    data.time = time;
    
    if ( isdefined( victim.type ) && ( victim.type == "scriptable_uav_tower" || victim.type == "scriptable_br_plunder_box" || victim.isredeploydrone ) )
    {
    }
    else if ( isdefined( var_35133ea1d74d7e08 ) && victim.classname != "trigger_radius" )
    {
        bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_emp_pulse" );
        outlineasset = bundle.emppulsehudoutline ?? "ddos_target_non_player";
        thread outline::function_67e3226e79560595( [ victim ], self, var_35133ea1d74d7e08, time, outlineasset, "perk_superior" );
    }
    
    if ( isdefined( attacker.perks[ "specialty_traceback" ] ) && utility::issharedfuncdefined( #"traceback", #"try_traceback" ) )
    {
        attacker [[ utility::getsharedfunc( #"traceback", #"try_traceback" ) ]]( victim );
    }
    
    thread emp_debuff::function_1fdeda386a85c7c7( data, time, var_6dc1a273e8093071 );
}

// Namespace super_emp_pulse
// Params 1
// Checksum 0x9ceb0227, Offset: 0x19c4
// Size: 0xa0
function function_9f2d28ab468acb9a( attacker )
{
    var_a3535380b20178ff = getdvarint( @"hash_8863a21e430252d5", 0 ) == 1;
    
    if ( !isagent( attacker ) )
    {
        if ( !level.teambased || var_a3535380b20178ff )
        {
            return [ attacker ];
        }
        
        if ( squad_utility::shouldmodesetsquads() )
        {
            return level.squaddata[ attacker.team ][ attacker.sessionsquadid ].players;
        }
        
        return teams::getteamdata( attacker.team, "players" );
    }
}

// Namespace super_emp_pulse
// Params 2
// Checksum 0xd5e9ab7f, Offset: 0x1a6c
// Size: 0x1d5
function emppulse_apply_player( data, overridetime )
{
    data.victim notify( #"emppulse_apply_player" );
    data.victim endon( #"emppulse_apply_player" );
    emp_debuff::apply_emp_struct( data, 0 );
    self setddosjammed( 1 );
    data.victim thread function_4e8674591123c8d8( data.attacker );
    data.attacker thread function_ba09c24ad8a35c48( data.victim );
    gamescore::trackdebuffassist( data.attacker, data.victim, data.objweapon.basename );
    
    if ( isdefined( data.attacker.perks[ "specialty_traceback" ] ) && utility::issharedfuncdefined( #"traceback", #"try_traceback" ) )
    {
        data.attacker [[ utility::getsharedfunc( #"traceback", #"try_traceback" ) ]]( data.victim );
    }
    
    data.victim function_2193180d128dc4bc( 1 );
    msg = function_cab2b1bc3693b4f0( data, overridetime );
    data.victim function_2193180d128dc4bc( 0 );
    
    if ( isdefined( data.victim ) )
    {
        data.victim emp_debuff::remove_emp();
        
        if ( player::isreallyalive( data.attacker ) )
        {
            gamescore::untrackdebuffassist( data.attacker, data.victim, data.objweapon.basename );
        }
        
        self setddosjammed( 0 );
    }
}

// Namespace super_emp_pulse
// Params 1
// Checksum 0xe0600e8e, Offset: 0x1c49
// Size: 0x45
function function_2193180d128dc4bc( scrambleon )
{
    if ( !utility::function_2a082dafe6f4bd5b() )
    {
        return;
    }
    
    assert( isdefined( scrambleon ), "<dev string:x24>" );
    
    if ( scrambleon )
    {
        self visionsetnightforplayer( "iw9_mp_nvg_base_color_ddos" );
        return;
    }
    
    self visionsetnightforplayer( "iw9_mp_nvg_base_color" );
}

// Namespace super_emp_pulse
// Params 2
// Checksum 0x55fc5882, Offset: 0x1c96
// Size: 0x6b
function function_cab2b1bc3693b4f0( data, overridetime )
{
    data.victim endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    time = 6;
    
    if ( isdefined( overridetime ) )
    {
        time = overridetime;
    }
    
    msg = utility::waittill_notify_or_timeout_return( "emp_cleared", time );
    return msg;
}

// Namespace super_emp_pulse
// Params 1
// Checksum 0xf88c2bb8, Offset: 0x1d0a
// Size: 0x94
function emppulse_getduration( victim )
{
    defaulttime = getdvarfloat( @"scr_emp_pulse_duration", 6 );
    
    if ( victim vehicle::is_vehicle() )
    {
        defaulttime = getdvarint( @"hash_10320e52e3e9ab5c", 0 ) ? defaulttime : getdvarfloat( @"hash_820929aec8056e07", 3.5 );
    }
    
    if ( !supers_mp::getcurrentsuper().isinuse )
    {
        return defaulttime;
    }
    
    return clamp( supers_mp::getcurrentsuper().usepercent * defaulttime, 0, defaulttime );
}

// Namespace super_emp_pulse
// Params 1
// Checksum 0xf01881d7, Offset: 0x1da6
// Size: 0x5e
function function_4e8674591123c8d8( jammerent )
{
    self endon( #"disconnect" );
    self endon( #"emp_scramble_off" );
    
    if ( isdefined( self.var_7c7055c704fc70b8 ) )
    {
        function_a6f9d4d51436866e();
    }
    
    self.var_7c7055c704fc70b8 = jammerent;
    thread function_86b06ca575eaff4b( jammerent );
    function_745c1fb8cf6fd41( jammerent );
    function_a6f9d4d51436866e( jammerent );
}

// Namespace super_emp_pulse
// Params 1
// Checksum 0x2978752c, Offset: 0x1e0c
// Size: 0x5d
function function_745c1fb8cf6fd41( jammerent )
{
    level endon( #"game_ended" );
    jammerent endon( #"disconnect" );
    self endon( #"disconnect" );
    jammerent childthread emppulse_watchownerdeath( self );
    childthread function_936a9c3ccce283f9();
    utility::waittill_any_timeout( 6, "empPulse_ownerDeath", "empPulse_victimDeath", "ddos_ended_early" );
}

// Namespace super_emp_pulse
// Params 1
// Checksum 0x77b20d85, Offset: 0x1e71
// Size: 0x1d
function function_a6f9d4d51436866e( jammerent )
{
    self.var_7c7055c704fc70b8 = undefined;
    emp_debuff::clear_emp_scramble();
}

// Namespace super_emp_pulse
// Params 1
// Checksum 0xbd0919d3, Offset: 0x1e96
// Size: 0x26
function emppulse_watchownerdeath( victim )
{
    self waittill( #"death" );
    victim notify( #"empPulse_ownerDeath" );
}

// Namespace super_emp_pulse
// Params 0
// Checksum 0x9e022650, Offset: 0x1ec4
// Size: 0x1b
function function_936a9c3ccce283f9()
{
    self waittill( #"death" );
    self notify( #"empPulse_victimDeath" );
}

// Namespace super_emp_pulse
// Params 1
// Checksum 0x649fd625, Offset: 0x1ee7
// Size: 0x8d
function function_86b06ca575eaff4b( jammerent )
{
    self endon( #"death_or_disconnect" );
    self endon( #"emp_scramble_off" );
    jammerent endon( #"death_or_disconnect" );
    previousstrength = 0;
    scramblerstrength = 0;
    
    while ( true )
    {
        scramblerstrength = function_df2fd805a1c99cc8( jammerent );
        var_7c07fabfd38bcdf3 = scramblerstrength != previousstrength;
        
        if ( previousstrength == 0 || var_7c07fabfd38bcdf3 )
        {
            emp_debuff::stop_emp_scramble( previousstrength );
            emp_debuff::play_emp_scramble( scramblerstrength );
            previousstrength = scramblerstrength;
        }
        
        waitframe();
    }
}

// Namespace super_emp_pulse
// Params 1
// Checksum 0xe475b7c4, Offset: 0x1f7c
// Size: 0xb9
function function_df2fd805a1c99cc8( jammerent )
{
    scramblerradius = 500;
    var_bb2d4f1c40bafd12 = scramblerradius * scramblerradius;
    distancechecksq = distance2dsquared( jammerent.origin, self.origin );
    scramblerstrength = 0;
    
    if ( distancechecksq > var_bb2d4f1c40bafd12 )
    {
        scramblerstrength = 0;
    }
    else if ( distancechecksq >= var_bb2d4f1c40bafd12 * 0.8 )
    {
        scramblerstrength = 1;
    }
    else if ( distancechecksq >= var_bb2d4f1c40bafd12 * 0.6 )
    {
        scramblerstrength = 2;
    }
    else if ( distancechecksq >= var_bb2d4f1c40bafd12 * 0.4 )
    {
        scramblerstrength = 3;
    }
    else if ( distancechecksq >= var_bb2d4f1c40bafd12 * 0.2 )
    {
        scramblerstrength = 4;
    }
    else
    {
        scramblerstrength = 5;
    }
    
    return scramblerstrength;
}

// Namespace super_emp_pulse
// Params 2
// Checksum 0xfe21b4c0, Offset: 0x203e
// Size: 0x8d
function function_605654f2a971d056( fromdeath, attacker )
{
    if ( isdefined( self.super ) && isdefined( self.super.hitcount ) )
    {
        challenges::function_a0936b0e5b4550f3( "super_emp_pulse", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"end" ), self.super.hitcount );
        self.super.hitcount = undefined;
    }
    
    self.var_d63e1c5704eb4fe0 = undefined;
}

