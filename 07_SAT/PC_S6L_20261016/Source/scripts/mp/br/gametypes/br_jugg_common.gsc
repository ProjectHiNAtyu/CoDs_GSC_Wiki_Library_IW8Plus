// scripts\mp\br\gametypes\br_jugg_common.gsc  (hash_5b1a7d2a95d1348b.gscc) (size: 15880 Bytes / 0x3e08 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xef86c3c1 (4018586561)
// size ...... 15880 (0x3e08)
// includes .. 17  (offset: 0x3ab0)
// strings ... 36  (offset: 0x3b38)
// dev strs .. 20  (offset: 0x3d04)
// exports ... 45  (offset: 0x2460)
// cseg ...... 0x338 + 0x2128 (0x2460)
// imports ... 130 (offset: 0x2b68)
// animtree1 . 0   (offset: 0x3e08)
// animtree2 . 0   (offset: 0x3e08)
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\airdrop_scriptbundle;
#using scripts\mp\br\gametypes\br_c130airdrop;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\killstreaks\juggernaut;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\player;
#using scripts\mp\hud_util;
#using scripts\mp\juggernaut;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_item;

#namespace br_jugg_common;

// Namespace br_jugg_common
// Params 0
// Checksum 0x1d0bd023, Offset: 0x356
// Size: 0x1cb
function init()
{
    assert( isdefined( level.c130deliveriesinprogress ) );
    level.addjuggfunctionality = &addjuggfunctionality;
    level.clearbrinventory = &dropallunusableitems;
    utility::registersharedfunc( #"br_juggernaut", #"oncrateactivate", &legacyoncrateactivate );
    utility::registersharedfunc( #"br_juggernaut", #"oncrateuse", &legacyoncrateuse );
    utility::registersharedfunc( #"br_juggernaut", #"oncratedestroy", &oncratedestroy );
    level thread br_c130airdrop::init();
    level.activejuggernauts = [];
    level.brjuggsettings = [];
    level.var_87dcbe75f0888a71 = [];
    init_br_jugg_setting( "br_juggdrop_incoming_splash_setting", "br_juggdrop_incoming" );
    level thread initbrjuggconfig();
    
    /#
        setdevdvarifuninitialized( @"scr_br_jugg_num_drops", 3 );
        setdevdvarifuninitialized( @"hash_fca632f39743dfa8", 0 );
        setdevdvarifuninitialized( @"hash_7ed2e5c3764afc91", 20000 );
        setdevdvarifuninitialized( @"hash_5ac354aab53a33fe", 9600 );
        setdevdvarifuninitialized( @"hash_4c96c13074cf77e5", 5 );
        setdevdvarifuninitialized( @"hash_4b258e12bbf733e3", 300 );
        setdevdvarifuninitialized( @"hash_14531681ab16f185", 30 );
        setdevdvarifuninitialized( @"hash_656b5e056fdbf096", 0 );
        setdevdvarifuninitialized( @"hash_3372053939d80fa4", 0 );
        setdevdvarifuninitialized( @"hash_d4b2c13dead25aac", 0 );
        setdevdvarifuninitialized( @"hash_90fb266842b5bc2a", 1 );
        setdevdvarifuninitialized( @"hash_a9e8e75fb57047aa", 1.25 );
        level thread function_b93ce441ec752eb7();
        level thread function_22a3965836467258();
    #/
    
    callback::add( #"br_callouts_initialized", &initpostmain );
    callback::add( #"game_ended", &matchenddlogs );
}

// Namespace br_jugg_common
// Params 1
// Checksum 0x5d71d98f, Offset: 0x529
// Size: 0x1d
function initpostmain( params )
{
    initdroplocations();
    level.numactivejuggdrops = 0;
}

// Namespace br_jugg_common
// Params 0
// Checksum 0x965d8f54, Offset: 0x54e
// Size: 0x100
function initbrjuggconfig()
{
    level endon( #"game_ended" );
    level waittill( #"hash_64c4c3e529bcdb13" );
    level.var_32beadb10d765f2d = utility::function_49a778e73bbb0f58( @"hash_8bdba732f0732c95", "1.0,1.0,1.0,1.0", level.streakglobals.streakbundles[ "juggernaut" ].var_30b4e508d5421dfc );
    level.var_32beadb10d765f2d = utility::function_d2db822aceef856a( level.var_32beadb10d765f2d, "," )[ level.maxsquadsize - 1 ] ?? 1;
    level.brjuggconfig = function_b2cf09b0259c40cb();
    
    if ( level.brjuggconfig.airdropasset )
    {
        level.var_236a38f198a8e72a = level.brjuggconfig.airdropasset;
        airdrop_scriptbundle::registerairdrop( level.var_236a38f198a8e72a, &oncrateuse, &oncrateactivate, &oncratedestroy );
        return;
    }
    
    logstring( "br_jugg_common::initbrjuggconfig" + "No airdrop asset defined in the juggernaut config!" );
}

// Namespace br_jugg_common
// Params 0
// Checksum 0x8eb08527, Offset: 0x656
// Size: 0x14a
function function_b2cf09b0259c40cb()
{
    var_1a346e7c0b45e1dc = level.streakglobals.streakbundles[ "juggernaut" ].juggernautconfig;
    
    if ( !var_1a346e7c0b45e1dc )
    {
        logstring( "[br_jugg_common::createBRJuggConfig] No juggernaut config found! The juggernaut config will not be initialized." );
        return;
    }
    
    config = juggernaut::jugg_createconfig( var_1a346e7c0b45e1dc );
    config.overheatlimit = 100;
    config.overheatcooldown = 3;
    config.overheatreductiontime = 1;
    config.overheatreductionrate = 0.5;
    config.overheatreductionamount = 5;
    config.infiniteammo = 0;
    config.maxhealth = getdvarint( @"hash_3218524c6270a8ea", config.maxhealth );
    config.maxhealth = int( config.maxhealth * ( level.var_32beadb10d765f2d ?? 1 ) );
    config.startinghealth = config.maxhealth;
    config.vehiclecankillhealth = int( config.maxhealth / config.maxvehicledamagedivisor );
    juggernaut::function_2ef6e7bd444b89ea( config );
    return config;
}

// Namespace br_jugg_common
// Params 10
// Checksum 0x2f916bcf, Offset: 0x7a9
// Size: 0xcf
function onplayerkilled( einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid )
{
    if ( isplayer( attacker ) && attacker killstreak::isjuggernaut() )
    {
        healthRegenScale = getdvarfloat( @"hash_ee5d6c86090456ee", 0.166667 );
        var_fb75c5339ecc8b0b = int( attacker.maxhealth * healthRegenScale );
        attacker restorehealth( var_fb75c5339ecc8b0b );
    }
    
    if ( isdefined( self ) && killstreak::isjuggernaut() )
    {
        self.ignoredeathsdoor = undefined;
    }
}

// Namespace br_jugg_common
// Params 1
// Checksum 0x57022079, Offset: 0x880
// Size: 0x55
function restorehealth( var_fb75c5339ecc8b0b )
{
    newhealth = self.health + var_fb75c5339ecc8b0b;
    
    if ( newhealth > self.maxhealth )
    {
        newhealth = self.maxhealth;
    }
    
    self.health = newhealth;
    self notify( #"jugg_health_regen" );
}

// Namespace br_jugg_common
// Params 0
// Checksum 0x3c74a5af, Offset: 0x8dd
// Size: 0x59
function addjuggfunctionality()
{
    juggconfig = self.juggcontext.juggconfig;
    useoverheat = getdvarint( @"hash_fca632f39743dfa8", 0 );
    
    if ( useoverheat )
    {
        thread watchoverheat( juggconfig );
        thread watchheatreduction( juggconfig );
    }
    
    thread mangagedeathsdoor( juggconfig );
}

// Namespace br_jugg_common
// Params 0
// Checksum 0x87cc5937, Offset: 0x93e
// Size: 0x9b
function dropallunusableitems()
{
    if ( utility::issharedfuncdefined( #"gametype", #"hash_ded3090518300d77" ) )
    {
        utility::callsharedfunc( #"gametype", #"hash_ded3090518300d77" );
        return;
    }
    
    spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
    common_inventory::inventory_dropammo( spawnoptions );
    common_inventory::inventory_dropweapons( spawnoptions );
    common_inventory::function_dea44924bc39c69a( spawnoptions );
    common_inventory::function_22b6752ea0b8d004( spawnoptions );
    common_inventory::function_c06d8f2a85102c39( spawnoptions );
    common_inventory::function_7191bfc32dde4117( spawnoptions );
    common_inventory::function_bea629729eedb95d( spawnoptions );
    common_inventory::function_457446259943ace1( spawnoptions );
    common_inventory::function_8f0b4f273c78dd61( spawnoptions );
}

// Namespace br_jugg_common
// Params 0
// Checksum 0xdd1e9b2d, Offset: 0x9e1
// Size: 0x111
function initdroplocations()
{
    if ( !isdefined( level.calloutglobals.namelocations ) || level.calloutglobals.namelocations.size == 0 )
    {
        println( "<dev string:x24>" );
        return;
    }
    
    level.juggdroplocations = [];
    
    foreach ( index, loc in level.calloutglobals.namelocations )
    {
        newlocationstruct = { #occupied:0, #origin:loc.origin, #id:index };
        level.juggdroplocations[ level.juggdroplocations.size ] = newlocationstruct;
    }
}

// Namespace br_jugg_common
// Params 2
// Checksum 0x9b86880a, Offset: 0xafa
// Size: 0x1fe
function getdroplocationnearcurrentcircle( radiusbuffer, var_7806d73790c18cf2 )
{
    location = undefined;
    
    if ( level.juggdroplocations.size > 0 )
    {
        foreach ( locinfo in level.juggdroplocations )
        {
            if ( !ispointnearcurrentsafecircle( locinfo, radiusbuffer ) )
            {
                continue;
            }
            
            if ( locinfo.occupied )
            {
                continue;
            }
            
            if ( function_7d56350293647ac1( locinfo.origin ) )
            {
                continue;
            }
            
            if ( isnearactivejugg( locinfo.origin ) )
            {
                continue;
            }
            
            if ( function_26fec83e59e63569( locinfo.origin, var_7806d73790c18cf2 ) )
            {
                continue;
            }
            
            location = locinfo;
            locinfo.occupied = 1;
            break;
        }
        
        if ( !isdefined( location ) )
        {
            /#
                iprintlnbold( "<dev string:xb6>" );
            #/
            
            location = createjuggdroplocation();
        }
    }
    else
    {
        locationoverride = undefined;
        
        /#
            iprintlnbold( "<dev string:x11d>" );
            
            if ( level.mapname == "<dev string:x193>" )
            {
                foreach ( player in level.players )
                {
                    if ( isdefined( player ) )
                    {
                        locationoverride = br_circle::getrandompointinboundscircle( player.origin, 1000 );
                        break;
                    }
                }
            }
        #/
        
        location = createjuggdroplocation( locationoverride );
    }
    
    return location;
}

// Namespace br_jugg_common
// Params 2
// Checksum 0x3d648912, Offset: 0xd01
// Size: 0xc1, Type: bool
function function_26fec83e59e63569( droplocation, var_7806d73790c18cf2 )
{
    mindist = getdvarint( @"hash_5ac354aab53a33fe", 9600 );
    mindistsq = mindist * mindist;
    
    foreach ( dropcircle in var_7806d73790c18cf2 )
    {
        if ( distance2dsquared( droplocation, dropcircle.origin ) < mindistsq )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_jugg_common
// Params 2
// Checksum 0x9277357, Offset: 0xdcb
// Size: 0xa5, Type: bool
function ispointnearcurrentsafecircle( locinfo, radiusbuffer )
{
    if ( level.br_circle_disabled || !isdefined( level.br_circle ) || level.br_circle.circleindex < 0 )
    {
        return true;
    }
    
    safecircleorigin = br_circle::getsafecircleorigin();
    safecircleradius = br_circle::getsafecircleradius();
    mindist = safecircleradius + radiusbuffer;
    mindistsq = mindist * mindist;
    
    if ( distance2dsquared( locinfo.origin, safecircleorigin ) <= mindistsq )
    {
        return true;
    }
    
    return false;
}

// Namespace br_jugg_common
// Params 1
// Checksum 0x534c58fc, Offset: 0xe79
// Size: 0xd9, Type: bool
function function_7d56350293647ac1( droplocation )
{
    mindist = getdvarint( @"hash_7ed2e5c3764afc91", 20000 );
    
    /#
        if ( level.mapname == "<dev string:x193>" )
        {
            mindist = 1000;
        }
    #/
    
    mindistsq = mindist * mindist;
    
    foreach ( drop in level.c130successfulairdrops )
    {
        if ( distance2dsquared( droplocation, drop.origin ) < mindistsq )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_jugg_common
// Params 1
// Checksum 0x51d52e9f, Offset: 0xf5b
// Size: 0xd1, Type: bool
function isnearactivejugg( droplocation )
{
    var_928ee3861b68e958 = br_circle::getsafecircleradius();
    mindistance = int( var_928ee3861b68e958 - var_928ee3861b68e958 / 3 );
    mindistancesq = mindistance * mindistance;
    
    foreach ( jugg in level.activejuggernauts )
    {
        if ( isdefined( jugg ) && distance2dsquared( droplocation, jugg.origin ) < mindistancesq )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace br_jugg_common
// Params 1
// Checksum 0xf880390d, Offset: 0x1035
// Size: 0xc8
function createjuggdroplocation( locationoverride )
{
    newlocation = spawnstruct();
    
    if ( isdefined( locationoverride ) )
    {
        newlocation.origin = locationoverride;
    }
    else
    {
        numtries = 10;
        
        while ( !isdefined( newlocation.origin ) )
        {
            potentiallocation = br_circle::getrandompointinboundssafecircle();
            
            if ( level.activejuggernauts.size > 0 )
            {
                if ( !isnearactivejugg( potentiallocation ) )
                {
                    newlocation.origin = potentiallocation;
                }
            }
            else
            {
                newlocation.origin = potentiallocation;
            }
            
            numtries--;
            
            if ( numtries == 0 && !isdefined( newlocation.origin ) )
            {
                newlocation.origin = potentiallocation;
            }
            
            waitframe();
        }
    }
    
    return newlocation;
}

// Namespace br_jugg_common
// Params 4
// Checksum 0x425a3967, Offset: 0x1106
// Size: 0x137
function showdroplocations( var_419250dda2338c55, initialdrop, showbeacon = 1, showquestcircle = 1 )
{
    level endon( #"game_ended" );
    radiusbuffer = 50000;
    
    if ( initialdrop )
    {
        if ( !level.br_circle_disabled )
        {
            level waittill( #"br_circle_set" );
        }
    }
    else
    {
        radiusbuffer = 0;
    }
    
    droplocations = [];
    
    for ( i = 0; i < var_419250dda2338c55 ; i++ )
    {
        dropcircle = getdroplocationnearcurrentcircle( radiusbuffer, droplocations );
        
        if ( showbeacon )
        {
            dropcircle.beacon = spawn( "script_model", dropcircle.origin );
            dropcircle.beacon setmodel( "ks_airdrop_crate_br" );
            dropcircle.beacon setscriptablepartstate( "jugg_drop_beacon", "on", 0 );
        }
        
        if ( showquestcircle )
        {
            dropcircle game_utility::questcircle_create( "Juggernaut_Br", dropcircle.origin, 5000 );
            dropcircle game_utility::questcircle_showtoall();
        }
        
        droplocations[ droplocations.size ] = dropcircle;
    }
    
    return droplocations;
}

// Namespace br_jugg_common
// Params 6
// Checksum 0x55b6177f, Offset: 0x1246
// Size: 0x1ef
function startdeliveries( droplocations, source, objective_state_override, showsplash = 1, var_2eb0f4a1ee34f2a3 = 5, var_e5997dd5a718245 = 10 )
{
    level endon( #"game_ended" );
    
    /#
        if ( level.mapname == "<dev string:x193>" )
        {
            setdvar( @"hash_d313f3ed75dbff0f", 100 );
        }
    #/
    
    if ( !level.var_236a38f198a8e72a )
    {
        assertmsg( "<dev string:x1a3>" + "<dev string:x1c3>" );
        return;
    }
    
    if ( showsplash )
    {
        splash_name = get_br_jugg_setting( "br_juggdrop_incoming_splash_setting" );
        hud_util::showsplashtoall( splash_name );
    }
    
    foreach ( dropcircle in droplocations )
    {
        droparea = function_bc66d85667452aa( dropcircle );
        dropcircle function_4fe21ad5cf317f57( droparea );
        overridestruct = { #dropradius:droparea.radius, #droporigin:droparea.origin };
        [ crate ] = airdrop_scriptbundle::startairdrop( level.var_236a38f198a8e72a, undefined, undefined, overridestruct );
        crate.circleindex = level.br_circle.circleindex;
        level.var_87dcbe75f0888a71[ level.var_87dcbe75f0888a71.size ] = crate;
        wait randomfloatrange( var_2eb0f4a1ee34f2a3, var_e5997dd5a718245 );
    }
}

// Namespace br_jugg_common
// Params 1, eflags: 0x4
// Checksum 0xe4386aec, Offset: 0x143d
// Size: 0x77
function private function_4fe21ad5cf317f57( droparea )
{
    dropcircle = self;
    dropcircle.origin = droparea.origin;
    dropcircle.dropradius = droparea.radius;
    
    if ( isdefined( dropcircle.beacon ) )
    {
        dropcircle.beacon.origin = dropcircle.origin;
    }
}

// Namespace br_jugg_common
// Params 1, eflags: 0x4
// Checksum 0x9e2e844b, Offset: 0x14bc
// Size: 0xcc
function private function_bc66d85667452aa( dropcircle )
{
    droparea = { #radius:dropcircle.dropradius ?? 5000, #origin:dropcircle.origin };
    
    if ( level.br_circle_disabled || !level.br_circle || level.br_circle.circleindex < 0 )
    {
        return droparea;
    }
    
    safecircleorigin = br_circle::getsafecircleorigin();
    safecircleradius = br_circle::getsafecircleradius();
    var_2ac036881147312e = { #radius:safecircleradius, #origin:safecircleorigin };
    return airdrop_scriptbundle::function_7d52124313f56a( droparea, safecircleorigin, safecircleradius, 0, undefined, var_2ac036881147312e );
}

// Namespace br_jugg_common
// Params 1
// Checksum 0x44615ae1, Offset: 0x1591
// Size: 0xe0
function watchoverheat( juggconfig )
{
    self endon( #"death_or_disconnect" );
    self endon( #"juggernaut_end" );
    level endon( #"game_ended" );
    heatlimit = juggconfig.overheatlimit;
    heatcooldown = juggconfig.overheatcooldown;
    juggconfig.heatcounter = 0;
    
    while ( true )
    {
        self waittill( #"weapon_fired" );
        juggconfig.heatcounter++;
        juggconfig.lastheatupdate = gettime();
        
        if ( juggconfig.heatcounter >= heatlimit )
        {
            iprintlnbold( "OVERHEAT" );
            val::set( "overheat_cooldown", "fire", 0 );
            wait heatcooldown;
            iprintlnbold( "COOLDOWN" );
            val::reset_all( "overheat_cooldown" );
        }
    }
}

// Namespace br_jugg_common
// Params 1
// Checksum 0x2df958d2, Offset: 0x1679
// Size: 0xde
function watchheatreduction( juggconfig )
{
    self endon( #"death_or_disconnect" );
    self endon( #"juggernaut_end" );
    level endon( #"game_ended" );
    heatreductiontime = juggconfig.overheatreductiontime;
    heatreductionrate = juggconfig.overheatreductionrate;
    heatreductionamount = juggconfig.overheatreductionamount;
    
    while ( true )
    {
        if ( juggconfig.heatcounter > 0 && gettime() - juggconfig.lastheatupdate >= heatreductiontime * 1000 )
        {
            var_3f0cda8f9348357c = juggconfig.heatcounter - heatreductionrate;
            
            if ( var_3f0cda8f9348357c < 0 )
            {
                var_3f0cda8f9348357c = 0;
            }
            
            juggconfig.heatcounter = int( var_3f0cda8f9348357c );
        }
        
        wait 0.05;
    }
}

// Namespace br_jugg_common
// Params 1
// Checksum 0x1a637fa1, Offset: 0x175f
// Size: 0xdd
function mangagedeathsdoor( juggconfig )
{
    self endon( #"death_or_disconnect" );
    self endon( #"juggernaut_end" );
    level endon( #"game_ended" );
    var_c5de6a56223f4f3f = 5;
    
    while ( true )
    {
        result = utility::waittill_any_return( "deaths_door_enter", "jugg_health_regen" );
        healed = 1;
        
        if ( result == "deaths_door_enter" )
        {
            healed = 0;
            self.ignoredeathsdoor = 1;
            wait var_c5de6a56223f4f3f;
        }
        else if ( result == "jugg_health_regen" )
        {
            healthratio = self.health / self.maxhealth;
            
            if ( healthratio >= 0.75 )
            {
                if ( self.ignoredeathsdoor )
                {
                    self.ignoredeathsdoor = undefined;
                }
            }
        }
        
        damage_effects::onexitdeathsdoor( healed );
    }
}

// Namespace br_jugg_common
// Params 1
// Checksum 0x492461af, Offset: 0x1844
// Size: 0x1e
function oncrateactivate( initialactivation )
{
    juggernaut::oncrateactivated( initialactivation );
    oncrateactivatecommon( initialactivation );
}

// Namespace br_jugg_common
// Params 1, eflags: 0x4
// Checksum 0x5ceee929, Offset: 0x186a
// Size: 0x15
function private legacyoncrateactivate( initialactivation )
{
    oncrateactivatecommon( initialactivation );
}

// Namespace br_jugg_common
// Params 1, eflags: 0x4
// Checksum 0x990ee01, Offset: 0x1887
// Size: 0x3a
function private oncrateactivatecommon( initialactivation )
{
    utility::callsharedfunc( #"gametype", #"hash_e6d6845fcecb4257", initialactivation );
    
    if ( initialactivation )
    {
        thread watchcratetimeout();
        thread watchcrategastimeout();
    }
}

// Namespace br_jugg_common
// Params 0
// Checksum 0x28f3c3db, Offset: 0x18c9
// Size: 0x5e
function watchcratetimeout()
{
    self endon( #"death" );
    cratetimeout = getdvarint( @"hash_4b258e12bbf733e3", 300 );
    
    if ( cratetimeout > 0 )
    {
        wait cratetimeout;
        level.var_87dcbe75f0888a71 = arrayremove( level.var_87dcbe75f0888a71, self );
        function_5c7b11daf6c3bd75( "time_out" );
        airdrop::destroycrate();
    }
}

// Namespace br_jugg_common
// Params 0
// Checksum 0x1e58fe8d, Offset: 0x192f
// Size: 0xd5
function watchcrategastimeout()
{
    self endon( #"death" );
    
    if ( level.br_circle_disabled )
    {
        return;
    }
    
    crategastimeout = getdvarint( @"hash_14531681ab16f185", 30 );
    
    while ( true )
    {
        wait 0.05;
        
        if ( !isdefined( level.br_circle ) || level.br_circle.circleindex < 0 )
        {
            continue;
        }
        
        dangercircleorigin = br_circle::getdangercircleorigin();
        dangercircleradius = br_circle::getdangercircleradius();
        
        if ( distance2dsquared( dangercircleorigin, self.origin ) > dangercircleradius * dangercircleradius )
        {
            break;
        }
    }
    
    wait crategastimeout;
    level.var_87dcbe75f0888a71 = arrayremove( level.var_87dcbe75f0888a71, self );
    function_5c7b11daf6c3bd75( "destroyed_in_gas" );
    airdrop::destroycrate();
}

// Namespace br_jugg_common
// Params 1
// Checksum 0xe77ac10a, Offset: 0x1a0c
// Size: 0x2d
function oncrateuse( crate )
{
    player = self;
    crate oncrateusecommon( player );
    crate juggernaut::oncratecaptured( player );
}

// Namespace br_jugg_common
// Params 2, eflags: 0x4
// Checksum 0xc30b59b8, Offset: 0x1a41
// Size: 0x33
function private legacyoncrateuse( player, leveldata )
{
    oncrateusecommon( player );
    
    if ( leveldata.destroyoncapture )
    {
        cratecleanup();
    }
}

// Namespace br_jugg_common
// Params 1, eflags: 0x4
// Checksum 0x984f977e, Offset: 0x1a7c
// Size: 0xae
function private oncrateusecommon( player )
{
    if ( !isdefined( self.data ) )
    {
        self.data = {};
    }
    
    self.data.config = structcopy( level.brjuggconfig, 1 );
    player.jugg_source = self.source;
    utility::callsharedfunc( #"gametype", #"hash_db9e9fbfcdcfb4a1", player );
    notifycapturetoplayers( player );
    level.var_87dcbe75f0888a71 = arrayremove( level.var_87dcbe75f0888a71, self );
    self.usedtime = gettime();
    function_5c7b11daf6c3bd75( "used" );
}

// Namespace br_jugg_common
// Params 1
// Checksum 0x108e6444, Offset: 0x1b32
// Size: 0xec
function notifycapturetoplayers( owner )
{
    notifyorigin = self.origin;
    notifyrange = 5000;
    playersinrange = utility::playersincylinder( notifyorigin, notifyrange, owner );
    
    foreach ( player in playersinrange )
    {
        if ( player::isreallyalive( player ) )
        {
            soundtoplay = "br_jugg_capture_positive";
            
            if ( player.team != owner.team )
            {
                soundtoplay = "br_jugg_capture_negative";
            }
            
            player playlocalsound( soundtoplay );
        }
    }
}

// Namespace br_jugg_common
// Params 1
// Checksum 0x1c1fb274, Offset: 0x1c26
// Size: 0x38
function oncratedestroy( immediate )
{
    utility::callsharedfunc( #"gametype", #"hash_e1d2e49075bc408", immediate );
    level.numactivejuggdrops--;
    cratecleanup();
}

// Namespace br_jugg_common
// Params 0
// Checksum 0x86780f7b, Offset: 0x1c66
// Size: 0xa9
function cratecleanup()
{
    if ( isdefined( self.dropcircle ) )
    {
        self.dropcircle.occupied = 0;
        self.dropcircle game_utility::questcircle_delete();
        
        if ( isdefined( self.dropcircle.beacon ) )
        {
            self.dropcircle.beacon setscriptablepartstate( "jugg_drop_beacon", "off" );
            self.dropcircle.beacon delete();
        }
    }
    
    if ( isdefined( level.c130successfulairdrops ) )
    {
        level.c130successfulairdrops = arrayremove( level.c130successfulairdrops, self );
    }
}

// Namespace br_jugg_common
// Params 3
// Checksum 0x4c528c90, Offset: 0x1d17
// Size: 0x80
function init_br_jugg_setting( name, value, source = "default" )
{
    if ( !isdefined( level.brjuggsettings[ source ] ) )
    {
        level.brjuggsettings[ source ] = [];
    }
    
    assert( !isdefined( level.brjuggsettings[ source ][ name ] ), "<dev string:x21a>" + name + "<dev string:x25a>" + source );
    level.brjuggsettings[ source ][ name ] = value;
}

// Namespace br_jugg_common
// Params 2
// Checksum 0x96b0d763, Offset: 0x1d9f
// Size: 0x38, Type: bool
function get_br_jugg_setting( name, source )
{
    return level.brjuggsettings[ source ][ name ] ?? level.brjuggsettings[ "default" ][ name ];
}

// Namespace br_jugg_common
// Params 0
// Checksum 0x3b7da803, Offset: 0x1de0
// Size: 0x11
function getcrateusetime()
{
    return getdvarfloat( @"hash_4c96c13074cf77e5", 5 );
}

// Namespace br_jugg_common
// Params 1
// Checksum 0x44be337d, Offset: 0x1dfa
// Size: 0x24
function getnumdrops( defaultdrops = 3 )
{
    return getdvarint( @"scr_br_jugg_num_drops", defaultdrops );
}

// Namespace br_jugg_common
// Params 0
// Checksum 0xf225b09f, Offset: 0x1e27
// Size: 0x14
function getjuggdamagescale()
{
    return getdvarfloat( @"hash_90fb266842b5bc2a", 1 );
}

// Namespace br_jugg_common
// Params 0
// Checksum 0x23e03704, Offset: 0x1e44
// Size: 0x14
function getminigundamagescale()
{
    return getdvarfloat( @"hash_a9e8e75fb57047aa", 1.25 );
}

// Namespace br_jugg_common
// Params 1
// Checksum 0xe1606c71, Offset: 0x1e61
// Size: 0x101
function function_5c7b11daf6c3bd75( reason )
{
    crate = self;
    player = utility::array_get_first_item( crate.playerscaptured );
    playerid = player ? player getplayerunoid() : "-1";
    dlog_recordevent( "dlog_event_br_jugg_crate_info", [ "spawn_time", crate.birthtime, "circle_index", crate.circleindex ?? -1, "pos_x", crate.destination[ 0 ], "pos_y", crate.destination[ 1 ], "used_time", crate.usedtime ?? -1, "player_id", playerid, "reason", reason ] );
}

// Namespace br_jugg_common
// Params 1
// Checksum 0xe9fba9d, Offset: 0x1f6a
// Size: 0x8a
function matchenddlogs( params )
{
    foreach ( crate in level.var_87dcbe75f0888a71 )
    {
        crate function_5c7b11daf6c3bd75( "end_of_match" );
    }
}

/#

    // Namespace br_jugg_common
    // Params 0
    // Checksum 0x8b155f7f, Offset: 0x1ffc
    // Size: 0x174, Type: dev
    function function_b93ce441ec752eb7()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            testjuggdrop = getdvarint( @"hash_656b5e056fdbf096", 0 );
            
            if ( !testjuggdrop )
            {
                waitframe();
                continue;
            }
            
            var_419250dda2338c55 = getnumdrops();
            
            if ( level.mapname == "<dev string:x193>" )
            {
                var_419250dda2338c55 = 1;
            }
            
            dropcircles = showdroplocations( var_419250dda2338c55 );
            hud_util::showsplashtoall( "<dev string:x267>" );
            
            foreach ( drop in dropcircles )
            {
                if ( !level.var_236a38f198a8e72a )
                {
                    assertmsg( "<dev string:x27c>" + "<dev string:x1c3>" );
                    return;
                }
                
                overridestruct = { #dropradius:drop.dropradius ?? 5000, #droporigin:drop.origin };
                airdrop_scriptbundle::startairdrop( level.var_236a38f198a8e72a, undefined, undefined, overridestruct );
                wait randomfloatrange( 5, 10 );
            }
            
            setdvar( @"hash_656b5e056fdbf096", 0 );
        }
    }

    // Namespace br_jugg_common
    // Params 0
    // Checksum 0x6947c113, Offset: 0x2178
    // Size: 0x25f, Type: dev
    function function_22a3965836467258()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            testjuggdrop = getdvarint( @"hash_3372053939d80fa4", 0 );
            
            if ( !testjuggdrop )
            {
                waitframe();
                continue;
            }
            
            firstplayer = undefined;
            
            foreach ( player in level.players )
            {
                if ( player::isreallyalive( player ) )
                {
                    firstplayer = player;
                    break;
                }
            }
            
            dropcircle = undefined;
            starttrace = firstplayer.origin + ( 0, 0, 10000 );
            endtrace = firstplayer.origin - ( 0, 0, 20000 );
            contents = trace::create_contents( 0, 1, 1, 1, 0, 0, 1, 1, 1 );
            trace = trace::ray_trace( starttrace, endtrace, firstplayer, contents );
            
            if ( isdefined( trace ) && trace[ "<dev string:x29e>" ] != "<dev string:x2a6>" )
            {
                dropcircle = createjuggdroplocation( trace[ "<dev string:x2b3>" ] );
                dropcircle.beacon = spawn( "<dev string:x2bc>", dropcircle.origin );
                dropcircle.beacon setmodel( "<dev string:x2c9>" );
                dropcircle.beacon setscriptablepartstate( "<dev string:x2dd>", "<dev string:x2ee>", 0 );
                dropcircle game_utility::questcircle_create( "<dev string:x2f1>", dropcircle.origin, 5000 );
                dropcircle game_utility::questcircle_showtoall();
            }
            
            if ( isdefined( dropcircle ) )
            {
                if ( !level.var_236a38f198a8e72a )
                {
                    assertmsg( "<dev string:x2ff>" + "<dev string:x1c3>" );
                    return;
                }
                
                overridestruct = { #droporigin:dropcircle.origin };
                airdrop_scriptbundle::startairdrop( level.var_236a38f198a8e72a, undefined, undefined, overridestruct );
            }
            else
            {
                iprintlnbold( "<dev string:x323>" );
            }
            
            setdvar( @"hash_3372053939d80fa4", 0 );
        }
    }

    // Namespace br_jugg_common
    // Params 1
    // Checksum 0xda9ad49f, Offset: 0x23df
    // Size: 0x81, Type: dev
    function function_4a1f3e623fdab1d4( player )
    {
        level endon( #"game_ended" );
        usingparachute = 0;
        
        while ( true )
        {
            toggleparachute = getdvarint( @"hash_d4b2c13dead25aac", 0 );
            
            if ( !toggleparachute )
            {
                waitframe();
                continue;
            }
            
            if ( !usingparachute )
            {
                usingparachute = 1;
            }
            else
            {
                usingparachute = 0;
            }
            
            player skydive_setdeploymentstatus( usingparachute );
            player skydive_setbasejumpingstatus( usingparachute );
            setdvar( @"hash_d4b2c13dead25aac", 0 );
        }
    }

#/
