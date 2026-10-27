// scripts\mp\common\equipment\sonar_pulse.gsc  (hash_297a25fa7d2221ea.gscc) (size: 10039 Bytes / 0x2737 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x88728c6f (2289208431)
// size ...... 10039 (0x2737)
// includes .. 23  (offset: 0x2497)
// strings ... 28  (offset: 0x254f)
// dev strs .. 2   (offset: 0x270f)
// exports ... 31  (offset: 0x1483)
// cseg ...... 0x1ff + 0x1284 (0x1483)
// imports ... 98  (offset: 0x195b)
// animtree1 . 0   (offset: 0x2727)
// animtree2 . 1   (offset: 0x2727)
#using scripts\common\callbacks;
#using scripts\common\elevators;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\analyticslog;
#using scripts\mp\chaff_debuff;
#using scripts\mp\challenges;
#using scripts\mp\common\equipment\haywire;
#using scripts\mp\common\killstreaks\uav_bigmap;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\print;
#using scripts\mp\common\utility\teams;
#using scripts\mp\damage;
#using scripts\mp\emp_debuff;
#using scripts\mp\ent_manager;
#using scripts\mp\entityheadicons;
#using scripts\mp\hud_message;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\supers;
#using scripts\mp\weapons;

#namespace sonar_pulse;

// Namespace sonar_pulse
// Params 0, eflags: 0x1
// Checksum 0x96c83361, Offset: 0x21d
// Size: 0x9
function autoexec main()
{
    sonarpulse_init();
}

// Namespace sonar_pulse
// Params 0
// Checksum 0xa55e2d62, Offset: 0x22e
// Size: 0x1f
function sonarpulse_init()
{
    utility::flag_wait( "supers_initialized" );
    weapons::registerusedcallback( "sonar_pulse", &sonarpulse_used );
}

// Namespace sonar_pulse
// Params 1
// Checksum 0xd1199bd2, Offset: 0x255
// Size: 0x4b4
function sonarpulse_used( grenade )
{
    grenade endon( #"death" );
    self endon( #"disconnect" );
    
    /#
        print::printgameaction( "<dev string:x24>", self );
    #/
    
    grenade.superref = "super_sonar_pulse";
    grenade ent_manager::registerspawn( 1, &sonarpulse_destroy );
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_sonar_pulse" );
    thread weapons::monitordisownedgrenade( self, grenade );
    grenade setscriptablepartstate( "visibility", "show", 0 );
    grenade waittill( #"missile_stuck", stuckto );
    
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
    grenade.issuper = 1;
    grenade.superid = level.superglobals.staticsuperdata[ "super_sonar_pulse" ].id;
    grenade.usedcount = 0;
    grenade.deployingplayer = self;
    grenade.headiconid = entityheadicons::setheadicon_equipment( grenade );
    grenade.bundle = bundle;
    weapons::onequipmentplanted( grenade, "sonar_pulse_mp", &sonarpulse_destroy );
    level thread weapons::monitordisownedequipment( self, grenade );
    grenade sentientpoolmanager::registersentient( "Tactical_Static", self );
    maxhealth = grenade.bundle.sonarpulse_health ?? 75;
    hasrugged = isdefined( self.perks[ "specialty_rugged_eqp" ] );
    
    if ( hasrugged )
    {
        maxhealth = grenade.bundle.var_2176f8a6178d2954 ?? 150;
    }
    
    if ( isdefined( self.perks[ "specialty_mod_health_max" ] ) )
    {
        maxhealth = grenade.bundle.var_2176f8a6178d2954 ?? 150;
    }
    
    grenade thread damage::monitordamage( maxhealth, "hitequip", &sonarpulse_handlefataldamage, &sonarpulse_handledamage, 0 );
    grenade emp_debuff::set_apply_emp_callback( &sonarpulse_applyempcallback );
    grenade emp_debuff::function_6e0986f750cd4259( &function_1b9ee0feef8370e8 );
    grenade haywire::function_7f69a1eb3d590f76( &sonarpulse_haywireapplied );
    grenade haywire::function_d7496c23fe4085d4( &function_46e6ea1119bbec0a );
    
    if ( level.killstreak_emp_initialized )
    {
        grenade.ksempapplycallback = &sonarpulse_empapplied;
    }
    
    if ( level.killstreak_emp_initialized )
    {
        grenade.ksempclearcallback = &sonarpulse_empcleared;
    }
    
    grenade chaff_debuff::function_3860212a5ec36b56( &function_ed98571e2819869a );
    grenade chaff_debuff::function_324dd42a2703bc25( &function_32321d3e2e404485 );
    grenade function_a4ebfb83ec0621b9( &sonarpulse_destroy );
    
    if ( isdefined( level.elevators ) )
    {
        foreach ( elevators in level.elevators )
        {
            elevators thread elevators::isentitytouchingdoortrigger( grenade );
        }
    }
    
    if ( isplayer( stuckto ) )
    {
        grenade.owner weapons::grenadestuckto( grenade, stuckto );
        grenade thread function_d63873d0aed644af( stuckto );
    }
    
    var_32745f1dee3c9ef3 = 0;
    
    if ( isdefined( self.perks[ "specialty_uav_buff" ] ) )
    {
        var_32745f1dee3c9ef3 = 1;
    }
    
    if ( utility::issharedfuncdefined( #"chaff", #"add_ent_to_overlapping_chaff_triggers" ) )
    {
        grenade [[ utility::getsharedfunc( #"chaff", #"add_ent_to_overlapping_chaff_triggers" ) ]]( grenade );
    }
    
    utility::callsharedfunc( #"jamming_system", #"hash_b99e77a93a09b9d5", grenade, &function_d3fb867d76466364, &function_bfd507244175de3a );
    grenade thread function_751ed5602a0ee46b( var_32745f1dee3c9ef3 );
    grenade thread sonarpulse_watchtimeout( var_32745f1dee3c9ef3 );
    grenade sonarpulse_enable();
    grenade supers_mp::function_75a8cc70a1a5d51f( &sonarpulse_destroy );
    challenges::function_4fd386d590e901d8( grenade, #"hash_c50cf868c6994df3", #"use" );
    challengeparams = { #fieldupgraderef:"super_sonar_pulse", #fieldupgradeent:grenade, #fieldupgradeowner:grenade.owner };
    callback::callback( #"hash_2af4adf11224c49a", challengeparams );
}

// Namespace sonar_pulse
// Params 1
// Checksum 0x59b8ee2d, Offset: 0x711
// Size: 0x44
function function_d63873d0aed644af( playerstuckto )
{
    self endon( #"death" );
    self endon( #"destroyed" );
    level endon( #"game_ended" );
    playerstuckto waittill( #"death_or_disconnect" );
    self unlink();
}

// Namespace sonar_pulse
// Params 1
// Checksum 0xb5a34067, Offset: 0x75d
// Size: 0x4e
function function_751ed5602a0ee46b( var_32745f1dee3c9ef3 )
{
    self endon( #"death" );
    self endon( #"destroyed" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"enable_sonar" );
        thread function_8d83b19606f24577( var_32745f1dee3c9ef3 );
    }
}

// Namespace sonar_pulse
// Params 1
// Checksum 0xbf8e2891, Offset: 0x7b3
// Size: 0x329
function function_8d83b19606f24577( var_32745f1dee3c9ef3 )
{
    self endon( #"death" );
    self endon( #"destroyed" );
    self endon( #"disable_sonar" );
    level endon( #"game_ended" );
    wait 0.5;
    
    while ( true )
    {
        if ( self.chaffstunned || self.var_d3130663423ace4b )
        {
            wait self.bundle.var_41ab36337938bbaa ?? 2;
            continue;
        }
        
        radarradius = self.bundle.var_fd1586b308e3533 ?? 650;
        var_9e9471f9b493b3b7 = self.bundle.var_c925fa651a362afa ?? 1;
        radarradius = int( radarradius * ( level.var_2ab3ff8456131beb ?? 1 ) );
        thread sonarpulse_playfx( var_9e9471f9b493b3b7 );
        thread function_ef8e6b3bd7b2c631();
        
        if ( isbrgamemode() )
        {
            uav_bigmap::function_c0b3b2a1f1e2ac5e( self.owner.team, self.origin, radarradius, 2.05 );
        }
        
        if ( !game_utility::function_6bf4f7f554c07a7f( self ) )
        {
            var_ee045b40336757c7 = int( var_9e9471f9b493b3b7 * 1000 );
            
            if ( level.teambased )
            {
                players = teams::getteamdata( self.owner.team, "players" );
                
                foreach ( player in players )
                {
                    player.var_7b9ca6eae0591db8 = gettime();
                    player.var_d84690daf210c17d = gettime() + var_ee045b40336757c7;
                    player.var_543ebeda38aa9b7f = radarradius;
                    player.var_484517e462eeec53 = self.origin;
                    player.var_5a9f8ade4d7872c9 = self.owner;
                }
                
                triggerportableradarpingteam( self.origin, self.owner.team, radarradius, var_ee045b40336757c7 );
                level notify( #"hash_a933076aaaf7d216", self.origin, self.owner.team, radarradius, var_ee045b40336757c7 );
            }
            else
            {
                self.owner.var_7b9ca6eae0591db8 = gettime();
                self.owner.var_d84690daf210c17d = gettime() + var_ee045b40336757c7;
                self.owner.var_543ebeda38aa9b7f = radarradius;
                self.owner.var_484517e462eeec53 = self.origin;
                triggerportableradarping( self.origin, self.owner, radarradius, var_ee045b40336757c7 );
                level notify( #"portable_radar_ping", self.origin, self.owner, radarradius, var_ee045b40336757c7 );
            }
        }
        
        wait 2;
    }
}

// Namespace sonar_pulse
// Params 1
// Checksum 0x7ab4c90e, Offset: 0xae4
// Size: 0x64
function sonarpulse_playfx( var_9e9471f9b493b3b7 )
{
    self endon( #"death" );
    self endon( #"destroyed" );
    level endon( #"game_ended" );
    self setscriptablepartstate( "pulse", "active", 0 );
    wait min( 0.1, var_9e9471f9b493b3b7 - 0.5 );
    self setscriptablepartstate( "pulse", "neutral", 0 );
}

// Namespace sonar_pulse
// Params 0
// Checksum 0xa9ad2c88, Offset: 0xb50
// Size: 0x4f
function function_ef8e6b3bd7b2c631()
{
    self endon( #"death" );
    self endon( #"destroyed" );
    level endon( #"game_ended" );
    self setscriptablepartstate( "anims", "open", 0 );
    wait function_ee3bffa751da0219();
    self setscriptablepartstate( "anims", "close", 0 );
}

#using_animtree( "scriptables" );

// Namespace sonar_pulse
// Params 0
// Checksum 0x6b6b62a1, Offset: 0xba7
// Size: 0xf
function function_ee3bffa751da0219()
{
    return getanimlength( %wm_sonar_pulse_ground_open );
}

// Namespace sonar_pulse
// Params 1
// Checksum 0xe5541f9d, Offset: 0xbbf
// Size: 0x76
function sonarpulse_watchtimeout( var_32745f1dee3c9ef3 )
{
    self endon( #"death" );
    self endon( #"destroyed" );
    level endon( #"game_ended" );
    waittime = self.bundle.sonarpulse_timeout ?? 20;
    
    if ( var_32745f1dee3c9ef3 )
    {
        waittime = 20 * ( level.var_1099f076e66a8a09 ?? 1 );
    }
    
    wait waittime;
    sonarpulse_destroy();
}

// Namespace sonar_pulse
// Params 1
// Checksum 0x4e76566f, Offset: 0xc3d
// Size: 0x14b
function function_bcb419ddfcab5534( player )
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

// Namespace sonar_pulse
// Params 1
// Checksum 0x8c5670f0, Offset: 0xd90
// Size: 0x9e
function sonarpulse_handledamage( data )
{
    attacker = data.attacker;
    objweapon = data.objweapon;
    type = data.meansofdeath;
    damage = data.damage;
    modifieddamage = damage;
    modifieddamage = utility::handlemeleedamage( objweapon, type, modifieddamage );
    modifieddamage = damage::handleapdamage( objweapon, type, modifieddamage, attacker );
    weapons::equipmenthit( self.owner, attacker, objweapon, type );
    return modifieddamage;
}

// Namespace sonar_pulse
// Params 1
// Checksum 0xc18367c8, Offset: 0xe37
// Size: 0x52
function sonarpulse_handlefataldamage( data )
{
    attacker = data.attacker;
    
    if ( player_utility::playersareenemies( self.owner, attacker ) )
    {
        attacker thread points::doscoreevent( #"destroyed_equipment" );
    }
    
    sonarpulse_destroy( data );
}

// Namespace sonar_pulse
// Params 1
// Checksum 0x24c5d32b, Offset: 0xe91
// Size: 0x87
function sonarpulse_destroy( data )
{
    hasattacker = 0;
    
    if ( isdefined( data ) && isdefined( data.attacker ) )
    {
        hasattacker = 1;
        sonarpulse_givepointsfordeath( data.attacker );
    }
    
    if ( isdefined( self.headiconid ) )
    {
        entityheadicons::setheadicon_deleteicon( self.headiconid );
    }
    
    thread sonarpulse_delete( hasattacker );
    self setscriptablepartstate( "destroy", "active", 0 );
    self notify( #"destroyed" );
}

// Namespace sonar_pulse
// Params 1
// Checksum 0xa48800d1, Offset: 0xf20
// Size: 0xc5
function sonarpulse_delete( wasdestroyed )
{
    self endon( #"death" );
    
    if ( !isdefined( self ) )
    {
        /#
            iprintln( "<dev string:x38>" );
        #/
    }
    
    utility::callsharedfunc( #"jamming_system", #"hash_216d35a250cd860", self );
    self.exploding = 1;
    sonarpulse_disable();
    
    if ( isdefined( self.owner ) )
    {
        analyticslog::logevent_fieldupgradeexpired( self.owner, self.superid, self.usedcount, istrue( wasdestroyed ) );
        self.owner weapons::removeequip( self );
    }
    
    wait self.bundle.var_d5a8e744ce3d9b29 ?? 2;
    ent_manager::deregisterspawn();
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace sonar_pulse
// Params 1
// Checksum 0x5d03a2ba, Offset: 0xfed
// Size: 0x32
function sonarpulse_givepointsfordeath( attacker )
{
    if ( player_utility::playersareenemies( self.owner, attacker ) )
    {
        attacker thread points::doscoreevent( #"destroyed_equipment" );
    }
}

// Namespace sonar_pulse
// Params 1
// Checksum 0xd3f7747e, Offset: 0x1027
// Size: 0xb4
function sonarpulse_applyempcallback( data )
{
    data.victim endon( #"destroyed" );
    data.victim setscriptablepartstate( "empd", "active", 0 );
    data.victim sonarpulse_disable();
    
    if ( self.bundle.var_65eabebec1161fd2 )
    {
        sonarpulse_destroy( data );
    }
    
    wait self.bundle.var_716b4f7a76e5bc0c ?? 6;
    data.victim setscriptablepartstate( "empd", "neutral", 0 );
    data.victim sonarpulse_enable();
}

// Namespace sonar_pulse
// Params 1
// Checksum 0xb189954e, Offset: 0x10e3
// Size: 0x73
function function_1b9ee0feef8370e8( data )
{
    data.damage = 1000;
    self dodamage( data.damage, data.attacker.origin, data.attacker, data.objweapon, "MOD_EXPLOSIVE", data.objweapon, "none", undefined, 524288, undefined );
}

// Namespace sonar_pulse
// Params 1
// Checksum 0x7d6f13ab, Offset: 0x115e
// Size: 0x80
function sonarpulse_haywireapplied( data )
{
    data.victim endon( #"destroyed" );
    data.victim setscriptablepartstate( "empd", "active", 0 );
    data.victim sonarpulse_disable();
    
    if ( !data.victim.ishaywire )
    {
        data.victim.ishaywire = 1;
    }
}

// Namespace sonar_pulse
// Params 1
// Checksum 0x7be23a02, Offset: 0x11e6
// Size: 0x39
function function_46e6ea1119bbec0a( data )
{
    data.victim setscriptablepartstate( "empd", "neutral", 0 );
    data.victim sonarpulse_enable();
}

// Namespace sonar_pulse
// Params 1
// Checksum 0x58111cc6, Offset: 0x1227
// Size: 0x2c
function function_d3fb867d76466364( portableradar )
{
    portableradar setscriptablepartstate( "empd", "active", 0 );
    portableradar.var_d3130663423ace4b = 1;
}

// Namespace sonar_pulse
// Params 1
// Checksum 0xd68b66c, Offset: 0x125b
// Size: 0x29
function function_bfd507244175de3a( portableradar )
{
    portableradar setscriptablepartstate( "empd", "neutral", 0 );
    portableradar.var_d3130663423ace4b = undefined;
}

// Namespace sonar_pulse
// Params 1
// Checksum 0x220f15a9, Offset: 0x128c
// Size: 0x4f
function sonarpulse_empapplied( data )
{
    data.victim endon( #"destroyed" );
    data.victim setscriptablepartstate( "empd", "active", 0 );
    data.victim sonarpulse_disable();
}

// Namespace sonar_pulse
// Params 1
// Checksum 0x24823c4e, Offset: 0x12e3
// Size: 0x39
function sonarpulse_empcleared( data )
{
    data.victim setscriptablepartstate( "empd", "neutral", 0 );
    data.victim sonarpulse_enable();
}

// Namespace sonar_pulse
// Params 1
// Checksum 0x8ec2d884, Offset: 0x1324
// Size: 0x28
function function_ed98571e2819869a( data )
{
    self setscriptablepartstate( "empd", "active", 0 );
    self.chaffstunned = 1;
}

// Namespace sonar_pulse
// Params 1
// Checksum 0xc92df1b1, Offset: 0x1354
// Size: 0x27
function function_32321d3e2e404485( data )
{
    self setscriptablepartstate( "empd", "neutral", 0 );
    self.chaffstunned = 0;
}

// Namespace sonar_pulse
// Params 0
// Checksum 0x36b8b15e, Offset: 0x1383
// Size: 0x48
function sonarpulse_enable()
{
    if ( isdefined( self.owner ) )
    {
        if ( level.tier1modeenabled )
        {
            self.owner player::showminimap();
        }
    }
    
    thread function_19cea45f93b27f0b( "on", 0.5 );
    self notify( #"enable_sonar" );
}

// Namespace sonar_pulse
// Params 0
// Checksum 0xc424b4bc, Offset: 0x13d3
// Size: 0x54
function sonarpulse_disable()
{
    if ( isdefined( self.owner ) )
    {
        if ( level.tier1modeenabled )
        {
            self.owner player::hideminimap();
        }
    }
    
    function_19cea45f93b27f0b( "off" );
    self setscriptablepartstate( "pulse", "neutral", 0 );
    self notify( #"disable_sonar" );
}

// Namespace sonar_pulse
// Params 2, eflags: 0x4
// Checksum 0x8109056f, Offset: 0x142f
// Size: 0x35
function private function_19cea45f93b27f0b( state, delay )
{
    self endon( #"death" );
    
    if ( delay )
    {
        wait delay;
    }
    
    game_utility::set_scriptable_radar( self, state, 8 );
}

// Namespace sonar_pulse
// Params 1
// Checksum 0xa08ee561, Offset: 0x146c
// Size: 0x17
function function_a4ebfb83ec0621b9( callbackfunction )
{
    self.elevatordoorsclosecallback = callbackfunction;
}

