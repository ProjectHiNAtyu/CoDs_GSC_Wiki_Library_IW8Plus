// scripts\mp\common\supers\rallying_cry.gsc  (hash_4d0dabda06ee3496.gscc) (size: 12601 Bytes / 0x3139 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x217a474 (35103860)
// size ...... 12601 (0x3139)
// includes .. 18  (offset: 0x2f69)
// strings ... 15  (offset: 0x2ff9)
// dev strs .. 3   (offset: 0x3115)
// exports ... 39  (offset: 0x1c59)
// cseg ...... 0x17b + 0x1ade (0x1c59)
// imports ... 110 (offset: 0x2271)
// animtree1 . 0   (offset: 0x3139)
// animtree2 . 0   (offset: 0x3139)
#using script_16ea1b94f0f381b3;
#using scripts\asm\asm;
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\challenges_super;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\common;
#using scripts\mp\playerhealth;
#using scripts\mp\rank;
#using scripts\mp\supers;
#using scripts\mp\telemetry_mp;
#using scripts\mp\weapons;

#namespace rallying_cry;

// Namespace rallying_cry
// Params 0, eflags: 0x1
// Checksum 0x454a871d, Offset: 0x199
// Size: 0x18
function autoexec preinit()
{
    level callback::add( #"register_super", &rallying_cry_register );
}

// Namespace rallying_cry
// Params 1
// Checksum 0xa60cb7e5, Offset: 0x1b9
// Size: 0x17b
function rallying_cry_register( params )
{
    staticdata = level.superglobals.staticsuperdata[ "super_rallying_cry" ];
    
    if ( !isdefined( staticdata ) )
    {
        level callback::remove( #"player_spawned", &function_4f2a15c8d5fd6100 );
        return;
    }
    
    bundle = staticdata.bundle;
    
    if ( !isdefined( bundle ) )
    {
        level callback::remove( #"player_spawned", &function_4f2a15c8d5fd6100 );
        return;
    }
    
    level callback::add( #"player_laststand", &onplayerlaststand );
    level callback::add( #"hash_244314ef9125e636", &function_8314535b81f548e );
    level callback::add( #"on_ai_killed", &function_8c5e06ee1e60aeb7 );
    
    if ( isdefined( params.var_a3817c24c60dccd2 ) )
    {
        level [[ params.var_a3817c24c60dccd2 ]]( "super_rallying_cry", undefined, undefined, &rallying_cry_used, undefined, undefined, &rallying_cry_ongive, undefined );
        supers_mp::function_19492daedcf2689a( "super_rallying_cry", &get_use_time );
    }
    
    level callback::add( #"player_spawned", &rallying_cry_monitor );
    callback::add( #"hash_6a8a551945faab9", &function_95cb9e3e72df4d3b );
    thread utility::callsharedfunc( #"analytics", #"hash_eb9d0dae8f38111f", { #customhit:1, #customend:1, #customstart:1, #equipref:"equip_rallying_cry" } );
}

// Namespace rallying_cry
// Params 1
// Checksum 0x2e2e4b67, Offset: 0x33c
// Size: 0x21
function get_use_time( superinfo )
{
    return superinfo.staticdata.usetime;
}

// Namespace rallying_cry
// Params 0
// Checksum 0xe1099d5a, Offset: 0x366
// Size: 0x9
function rallying_cry_ongive()
{
    thread rallying_cry_monitor();
}

// Namespace rallying_cry
// Params 1
// Checksum 0xa10bf6a6, Offset: 0x377
// Size: 0x2b
function rallying_cry_monitor( params )
{
    childthread function_4f2a15c8d5fd6100();
    utility::waittill_any( "remove_super", "rallying_cry_used" );
    function_54797a5c1d8855d3();
}

// Namespace rallying_cry
// Params 1
// Checksum 0x8d3660cf, Offset: 0x3aa
// Size: 0x13b
function onplayerlaststand( deathdata )
{
    attacker = deathdata.attacker;
    victim = deathdata.victim;
    weapon = deathdata.objweapon;
    
    if ( !function_446659c5043033e6( attacker, victim, weapon ) )
    {
        return;
    }
    
    superinfo = attacker.var_86dd4266dc52e57f.owningplayer supers_mp::getcurrentsuper();
    rallyingcryweapon = superinfo.staticdata.objweapon;
    setweaponstats( deathdata, rallyingcryweapon );
    function_c8f6b367de2fa2b3( attacker );
    
    if ( attacker.rallyingcrykills == 3 )
    {
        if ( !isdefined( deathdata.callbackeventdata ) )
        {
            deathdata.callbackeventdata = [];
        }
        
        rallyingcrystruct = {};
        rallyingcrystruct.istriplekill = 1;
        rallyingcrystruct.rallyingcryweapon = superinfo.staticdata.objweapon;
        deathdata.callbackeventdata[ "super_rallying_cry" ] = rallyingcrystruct;
        attacker.var_21877673ec5d4c6f = 1;
    }
}

// Namespace rallying_cry
// Params 1
// Checksum 0x1894ec24, Offset: 0x4ed
// Size: 0x15a
function function_8314535b81f548e( deathdata )
{
    attacker = deathdata.attacker;
    victim = deathdata.victim;
    weapon = deathdata.objweapon;
    
    if ( victim.inlaststand )
    {
        rallyingcrystruct = victim.laststanddowneddata.callbackeventdata[ "super_rallying_cry" ];
        
        if ( rallyingcrystruct.istriplekill )
        {
            victim.laststanddowneddata.attacker thread namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"rally_triple", rallyingcrystruct.rallyingcryweapon );
        }
        
        return;
    }
    
    if ( !function_446659c5043033e6( attacker, victim, weapon ) )
    {
        return;
    }
    
    superinfo = attacker.var_86dd4266dc52e57f.owningplayer supers_mp::getcurrentsuper();
    rallyingcryweapon = superinfo.staticdata.objweapon;
    setweaponstats( deathdata, rallyingcryweapon );
    function_c8f6b367de2fa2b3( attacker );
    
    if ( attacker.rallyingcrykills == 3 )
    {
        attacker thread namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"rally_triple", rallyingcryweapon );
        attacker.var_21877673ec5d4c6f = 1;
    }
}

// Namespace rallying_cry
// Params 3, eflags: 0x4
// Checksum 0x1f2cf58d, Offset: 0x64f
// Size: 0x6b, Type: bool
function private function_446659c5043033e6( attacker, victim, weapon )
{
    if ( !( isdefined( attacker.var_86dd4266dc52e57f.owningplayer ) && isdefined( victim ) && isdefined( weapon ) ) || weapon::iskillstreakweapon( weapon ) )
    {
        return false;
    }
    
    if ( isdefined( attacker.perks[ "specialty_explosivebullets" ] ) )
    {
        return false;
    }
    
    return true;
}

// Namespace rallying_cry
// Params 2, eflags: 0x4
// Checksum 0xccda006d, Offset: 0x6c3
// Size: 0xf2
function private setweaponstats( deathdata, var_747d03e20f618b43 )
{
    attacker = deathdata.attacker;
    owner = attacker.var_86dd4266dc52e57f.owningplayer;
    
    if ( attacker == attacker.var_86dd4266dc52e57f.owningplayer )
    {
        attacker thread gamelogic_mp::threadedsetweaponstatbyname( var_747d03e20f618b43, 1, "kills" );
        attacker thread telemetry_mp::function_89a5d8fb8ed3a4fe( deathdata, attacker, attacker.var_86dd4266dc52e57f.starttime, var_747d03e20f618b43 );
        attacker function_fe706e38d7ba8fd3( var_747d03e20f618b43 );
        return;
    }
    
    attacker.var_86dd4266dc52e57f.owningplayer thread gamelogic_mp::threadedsetweaponstatbyname( var_747d03e20f618b43, 1, "kill_assists" );
    attacker.var_86dd4266dc52e57f.owningplayer thread namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"rallying_cry_assist", var_747d03e20f618b43 );
}

// Namespace rallying_cry
// Params 1, eflags: 0x4
// Checksum 0x345dfa3c, Offset: 0x7bd
// Size: 0x41
function private function_c8f6b367de2fa2b3( attacker )
{
    if ( !isdefined( attacker.rallyingcrykills ) )
    {
        attacker.rallyingcrykills = 0;
    }
    
    attacker.rallyingcrykills += 1;
}

// Namespace rallying_cry
// Params 0
// Checksum 0xf752a9d0, Offset: 0x806
// Size: 0x193
function function_4f2a15c8d5fd6100()
{
    self notify( #"hash_10c799e727e831d" );
    self endon( #"hash_10c799e727e831d" );
    self endon( #"death_or_disconnect" );
    self endon( #"remove_super" );
    self endon( #"rallying_cry_used" );
    super_slot = supers_mp::getsuperslot( "super_rallying_cry" );
    super_name = supers_mp::getcurrentsuperref( super_slot );
    
    if ( super_name != "super_rallying_cry" || !supers_mp::issuperready( undefined, super_slot ) )
    {
        function_54797a5c1d8855d3();
        return;
    }
    
    staticdata = level.superglobals.staticsuperdata[ "super_rallying_cry" ];
    assert( staticdata.usetime > 0, "<dev string:x24>" );
    self.var_7479f7eb16096b39 = { #duration:staticdata.usetime ?? 30, #starttime:gettime(), #owningplayer:self, #bundle:staticdata.bundle };
    buffradius = staticdata.bundle.var_8c8cad243a75c4f6 ?? 700;
    super_name = undefined;
    var_599699c746ab6584 = [];
    var_599699c746ab6584[ var_599699c746ab6584.size ] = self;
    function_ea63c818cabf59c3( var_599699c746ab6584 );
    
    if ( level.teambased )
    {
        while ( true )
        {
            var_599699c746ab6584 = getplayersandaiarrayinradius( self.origin, buffradius, self.team );
            function_ea63c818cabf59c3( var_599699c746ab6584 );
            wait 0.2;
        }
    }
}

// Namespace rallying_cry
// Params 1
// Checksum 0x20414678, Offset: 0x9a1
// Size: 0x2f
function function_ea63c818cabf59c3( nearbyplayers )
{
    self.rallying_cry_targets = nearbyplayers;
    self setclientomnvar( "ui_rallying_cry_target_detector_on_give_widget", int( min( nearbyplayers.size, 8 ) ) );
}

// Namespace rallying_cry
// Params 0
// Checksum 0x1653f1f9, Offset: 0x9d8
// Size: 0x143, Type: bool
function rallying_cry_used()
{
    self endon( #"death_or_disconnect" );
    self notify( #"rallying_cry_used" );
    thread utility::callsharedfunc( #"analytics", #"hash_22a37c3ed1cf5035", { #owner:self, #equipref:"equip_rallying_cry", #ent:self.offhandweapon } );
    
    if ( isbrgamemode() )
    {
        buffcount = function_e8410ef487bfccb1();
        
        if ( buffcount > 0 )
        {
            thread function_de78dba94d41ce60();
        }
    }
    else
    {
        thread function_de78dba94d41ce60();
    }
    
    childthread rallying_cry_used_battlechatter();
    thread utility::callsharedfunc( #"analytics", #"hash_e348d92f8fdade0c", { #position:self.origin, #owner:self, #equipref:"equip_rallying_cry", #ent:self.offhandweapon } );
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_rallying_cry" );
    
    if ( bundle.var_8b9eade13fbfb044 )
    {
        assert( !callback::exists( #"super_cancel", &cancel ) );
        callback::add( #"super_cancel", &cancel );
    }
    
    return true;
}

// Namespace rallying_cry
// Params 0
// Checksum 0x529587c5, Offset: 0xb24
// Size: 0xc
function rallying_cry_used_battlechatter()
{
    wait 3;
    battlechatter_mp::function_f3ffc3fa6aa3a992();
}

// Namespace rallying_cry
// Params 1, eflags: 0x4
// Checksum 0xd61245b7, Offset: 0xb38
// Size: 0xac
function private cancel( params )
{
    if ( isdefined( self.rallying_cry_targets ) )
    {
        foreach ( ent in self.rallying_cry_targets )
        {
            if ( !isplayer( ent ) )
            {
                ent notify( #"cancel_rallying_cry" );
            }
        }
    }
    
    self notify( #"cancel_rallying_cry" );
}

// Namespace rallying_cry
// Params 0
// Checksum 0xaf4898f1, Offset: 0xbec
// Size: 0x14
function function_54797a5c1d8855d3()
{
    waitframe();
    
    if ( isdefined( self ) )
    {
        self setclientomnvar( "ui_rallying_cry_target_detector_on_give_widget", 0 );
    }
}

// Namespace rallying_cry
// Params 0
// Checksum 0xb065bdd9, Offset: 0xc08
// Size: 0xfc
function function_de78dba94d41ce60()
{
    self endon( #"death" );
    self endon( #"disconnect" );
    players = [];
    ai = [];
    
    foreach ( ent in self.rallying_cry_targets )
    {
        if ( ent )
        {
            if ( isplayer( ent ) )
            {
                players[ players.size ] = ent;
                continue;
            }
            
            ai[ ai.size ] = ent;
        }
    }
    
    durationms = int( getrallyingcryduration( self.offhandweapon.basename ) * 1000 );
    function_601be88f42e6cc7( players, durationms );
    function_d48b832af26f7e39( ai, durationms );
}

// Namespace rallying_cry
// Params 2, eflags: 0x4
// Checksum 0x3144a3f6, Offset: 0xd0c
// Size: 0x10d
function private function_601be88f42e6cc7( players, durationms )
{
    if ( players.size == 0 )
    {
        return;
    }
    
    foreach ( player in players )
    {
        function_2fde932c91c4e0d6( player, durationms );
        waitframe();
    }
    
    var_d052b32e8e02410b = players.size - 1;
    
    if ( var_d052b32e8e02410b > 0 )
    {
        var_ce85253276f1221c = rank::getscoreinfovalue( #"rallying_cry_support" ) ?? 0;
        pointsoverride = var_d052b32e8e02410b * var_ce85253276f1221c;
        thread points::doscoreevent( #"rallying_cry_support", undefined, pointsoverride );
        challenges::function_a0936b0e5b4550f3( "super_rallying_cry", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"use" ), var_d052b32e8e02410b );
    }
}

// Namespace rallying_cry
// Params 2, eflags: 0x4
// Checksum 0xa401bb1c, Offset: 0xe21
// Size: 0xd3
function private function_d48b832af26f7e39( aiarray, durationms )
{
    if ( aiarray.size == 0 )
    {
        return;
    }
    
    bundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_rallying_cry" );
    durationseconds = durationms * 0.001;
    
    foreach ( ai in aiarray )
    {
        if ( !ai.var_7d107b7503b87ff5 )
        {
            ai thread function_932d50ea16c39661( durationseconds, bundle );
        }
    }
    
    function_ca8aa285f747978e( aiarray.size, bundle );
}

// Namespace rallying_cry
// Params 0
// Checksum 0xafdb5c27, Offset: 0xefc
// Size: 0x225
function function_e8410ef487bfccb1()
{
    buffradius = self.var_7479f7eb16096b39.bundle.var_8c8cad243a75c4f6 ?? 700;
    
    if ( isbrgamemode() )
    {
        ents = teams::getteamdata( self.team, "players" );
        verifiedents = [];
        
        if ( level.teambased )
        {
            foreach ( ent in ents )
            {
                if ( !isdefined( ent ) )
                {
                    continue;
                }
                
                if ( isagent( ent ) || isplayer( ent ) && lengthsquared( ent.origin - self.origin ) <= squared( buffradius ) )
                {
                    verifiedents[ verifiedents.size ] = ent;
                }
            }
        }
    }
    else
    {
        ents = level.players;
        verifiedents = [];
        
        if ( level.teambased )
        {
            foreach ( ent in ents )
            {
                if ( !isdefined( ent ) )
                {
                    continue;
                }
                
                if ( isdefined( ent.team ) && self.team != ent.team )
                {
                    continue;
                }
                
                if ( isagent( ent ) || isplayer( ent ) && lengthsquared( ent.origin - self.origin ) <= squared( buffradius ) )
                {
                    verifiedents[ verifiedents.size ] = ent;
                }
            }
        }
    }
    
    self.rallying_cry_targets = verifiedents;
    
    if ( isdefined( verifiedents ) )
    {
        return verifiedents.size;
    }
    
    return 0;
}

// Namespace rallying_cry
// Params 2, eflags: 0x4
// Checksum 0xc5e6c2fd, Offset: 0x1129
// Size: 0x77
function private function_2fde932c91c4e0d6( player, durationms )
{
    player.var_86dd4266dc52e57f = self.var_7479f7eb16096b39;
    
    if ( player != self )
    {
        player.rallyingcrybuffs[ self getentitynumber() ] = self.var_7479f7eb16096b39;
    }
    else
    {
        player challenges::tracksuper( self, "super_rallying_cry" );
    }
    
    if ( !player.var_7d107b7503b87ff5 )
    {
        player thread function_a4eeae22a5580705( durationms );
    }
}

// Namespace rallying_cry
// Params 2, eflags: 0x4
// Checksum 0x2f16cf05, Offset: 0x11a8
// Size: 0x82
function private function_932d50ea16c39661( durationseconds, superbundle )
{
    self.var_7d107b7503b87ff5 = 1;
    thread function_55528e8d406c7d1c( superbundle );
    thread function_9407a559bb8f52b3( superbundle );
    results = utility::waittill_any_return_params_or_timeout( durationseconds, "death", "cancel_rallying_cry" );
    result = results[ "message" ];
    
    if ( result == "timeout" )
    {
        self notify( #"rallying_cry_expired" );
    }
    
    self.var_7d107b7503b87ff5 = undefined;
}

// Namespace rallying_cry
// Params 1, eflags: 0x4
// Checksum 0xca2e7135, Offset: 0x1232
// Size: 0x9c
function private function_55528e8d406c7d1c( superbundle )
{
    var_992deb085c5d1272 = superbundle.var_a37a0aac1a7e8cea && !self.var_71690721303970f4 && gettime() > self.birthtime;
    
    if ( !var_992deb085c5d1272 )
    {
        return;
    }
    
    var_e93cd6d9b14201b8 = asm::function_27be172b46a89235();
    var_14f85b5f911198aa = var_e93cd6d9b14201b8 * superbundle.var_a760800c5d3d3eb2;
    asm::function_d82cb83c9c260d49( var_14f85b5f911198aa );
    asm::function_24133a663bba593c();
    utility::waittill_any( "death", "rallying_cry_expired" );
    asm::function_d82cb83c9c260d49( var_e93cd6d9b14201b8 );
}

// Namespace rallying_cry
// Params 1, eflags: 0x4
// Checksum 0xa98a2cf9, Offset: 0x12d6
// Size: 0x9b
function private function_9407a559bb8f52b3( superbundle )
{
    self endon( #"death" );
    self endon( #"rallying_cry_expired" );
    canheal = superbundle.var_67c4331b884d86f9;
    
    if ( !canheal )
    {
        return;
    }
    
    while ( true )
    {
        var_d1632f21496367ab = int( self.maxhealth * superbundle.var_19a86db7deea2fba );
        self.health = minint( self.health + var_d1632f21496367ab, self.maxhealth );
        wait superbundle.var_100a90c82c8a9d1e;
    }
}

// Namespace rallying_cry
// Params 2, eflags: 0x4
// Checksum 0x47fb1542, Offset: 0x1379
// Size: 0x84
function private function_ca8aa285f747978e( var_f636ac0cf3dbcaa3, superbundle )
{
    if ( !superbundle.var_8ff9c7b316352cea )
    {
        return;
    }
    
    scoreeventvalue = rank::getscoreinfovalue( superbundle.var_8ff9c7b316352cea );
    assert( scoreeventvalue, "<dev string:x50>" + getxhashsourcename( superbundle.var_8ff9c7b316352cea ) );
    scaledpoints = var_f636ac0cf3dbcaa3 * scoreeventvalue;
    thread points::doscoreevent( superbundle.var_8ff9c7b316352cea, undefined, scaledpoints );
}

// Namespace rallying_cry
// Params 1, eflags: 0x4
// Checksum 0xb683c17f, Offset: 0x1405
// Size: 0x1b
function private function_a20326d82dcb1a92( values )
{
    values = arraysort( values, undefined, undefined, 1 );
    return values[ 0 ];
}

// Namespace rallying_cry
// Params 1, eflags: 0x4
// Checksum 0x57facd, Offset: 0x1429
// Size: 0xe3
function private function_384f4d1f7f62b68a( bundle )
{
    var_8e4e717e87db1458 = { #meatshieldmultiplier:function_a20326d82dcb1a92( [ bundle.var_a1016b2effb79514, 1 ] ), #jogmultiplier:function_a20326d82dcb1a92( [ bundle.var_af835eda8a6b3cfe, 1.1 ] ), #var_e1f486c6b3b8552f:function_a20326d82dcb1a92( [ bundle.var_d488490b3a0fa6d3, 1.1 ] ), #tacsprintmultiplier:function_a20326d82dcb1a92( [ bundle.var_fcbebaabf3e04081, 1.05 ] ), #sprintmultiplier:function_a20326d82dcb1a92( [ bundle.var_e7a13c1f55c216c2, 1.1 ] ) };
    return var_8e4e717e87db1458;
}

// Namespace rallying_cry
// Params 1, eflags: 0x4
// Checksum 0xe63007f, Offset: 0x1515
// Size: 0x23, Type: bool
function private function_a1c0897a380f58d3( bundle )
{
    return bundle.var_8a4da34680427da1 ?? %"cer_mp_rallyingcry";
}

// Namespace rallying_cry
// Params 1
// Checksum 0x48e2b8ff, Offset: 0x1541
// Size: 0x389
function function_a4eeae22a5580705( durationms )
{
    self notify( #"hash_7c9ee74d6e618f22" );
    self endon( #"hash_7c9ee74d6e618f22" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self.var_7d107b7503b87ff5 = 1;
    bundle = level.superglobals.staticsuperdata[ "super_rallying_cry" ].bundle;
    unlimitedtacsprint = istrue( bundle.var_143f55191ca463e7 );
    var_9ca2f3f1b1b7274b = function_a1c0897a380f58d3( bundle );
    function_349b49faccd2f539( var_9ca2f3f1b1b7274b );
    function_6693aad77cf5906e( bundle );
    playerhealth::function_fd91e6d94cab77e7( #"rallyingcry_regendelay", bundle.var_4fe3631ac477634b ?? 0.6 );
    var_d5483ff9a4fbbd29 = bundle.var_de54c497072f8bbf;
    
    if ( var_d5483ff9a4fbbd29 )
    {
        var_2fe7f9c8243845d4 = bundle.var_203538c714aaa5cb;
        
        if ( var_2fe7f9c8243845d4 || self == self.var_86dd4266dc52e57f.owningplayer )
        {
            function_349b49faccd2f539( var_d5483ff9a4fbbd29 );
        }
    }
    
    buffendtime = gettime() + durationms;
    self function_6a5ef3f0bfda9f86( durationms );
    
    if ( bundle.var_9802200f05c442d6 )
    {
        var_34b74e00f3a88450 = bundle.var_bd65ea09c65de234;
        var_45effadc98bcab0e = bundle.var_1a1e0c3a81a6f4a8;
        validdata = isdefined( var_34b74e00f3a88450 ) && isdefined( var_45effadc98bcab0e );
        assert( validdata, "<dev string:x6c>" );
        
        if ( validdata )
        {
            thread function_e925e63d15da0315( buffendtime, var_9ca2f3f1b1b7274b, var_34b74e00f3a88450, var_45effadc98bcab0e );
        }
    }
    
    var_d6f645db07b18371 = bundle.var_7700f7e607a7c791;
    
    while ( gettime() < buffendtime )
    {
        results = utility::waittill_any_return_params_or_timeout( 0.5, "death", "cancel_rallying_cry" );
        result = results[ "message" ];
        
        if ( result == "death" || result == "cancel_rallying_cry" )
        {
            break;
        }
        
        if ( unlimitedtacsprint )
        {
            self refreshsprinttime();
        }
        
        if ( self.var_fff20d0e22e94e9c )
        {
            continue;
        }
        
        speedmultiplier = function_3e85bd23460c12eb( bundle );
        
        if ( var_d6f645db07b18371 )
        {
            self setmovespeedscale( speedmultiplier );
            continue;
        }
        
        common::function_1f09590404e452e4( "rallying_cry", speedmultiplier );
        weapons::function_4512b7715789e4cf( "rallying_cry", speedmultiplier );
        weapons::updatemovespeedscale();
    }
    
    if ( isplayer( self ) )
    {
        if ( self.var_86dd4266dc52e57f.owningplayer == self )
        {
            challenges::function_ead174660f144273( self, "super_rallying_cry" );
        }
        
        if ( !self.var_fff20d0e22e94e9c )
        {
            if ( var_d6f645db07b18371 )
            {
                self setmovespeedscale( 1 );
            }
            else if ( common::function_8ff835bf23198a0( "rallying_cry" ) )
            {
                common::function_d85a92c557ea5a52( "rallying_cry" );
                weapons::function_986fc44dada307f4( "rallying_cry" );
                weapons::updatemovespeedscale();
            }
        }
        
        playerhealth::function_b1fb4d148779580e( #"rallyingcry_regendelay" );
        function_c42b55e111075196( var_9ca2f3f1b1b7274b );
        function_27391b56e7b0a959( bundle );
    }
    
    self.rallyingcrybuffs = undefined;
    self.var_86dd4266dc52e57f = undefined;
    self.var_7d107b7503b87ff5 = undefined;
    self.rallyingcrykills = undefined;
    
    if ( bundle.var_8b9eade13fbfb044 )
    {
        assert( callback::exists( #"super_cancel", &cancel ) );
        callback::remove( #"super_cancel", &cancel );
    }
    
    self notify( #"rallying_cry_expired" );
}

// Namespace rallying_cry
// Params 4, eflags: 0x4
// Checksum 0x8732dc86, Offset: 0x18d2
// Size: 0xbd
function private function_e925e63d15da0315( buffendtime, overlayasset, duration, frequency )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"death" );
    self endon( #"rallying_cry_expired" );
    var_719a7307afbe507 = ( buffendtime - gettime() ) * 0.001 - duration;
    wait var_719a7307afbe507;
    var_a92bfb378bec6b23 = frequency * 0.5;
    doingfadeout = 0;
    
    while ( true )
    {
        if ( doingfadeout )
        {
            function_349b49faccd2f539( overlayasset );
        }
        else
        {
            function_c42b55e111075196( overlayasset );
        }
        
        doingfadeout = !doingfadeout;
        wait var_a92bfb378bec6b23;
    }
}

// Namespace rallying_cry
// Params 1
// Checksum 0x13defb30, Offset: 0x1997
// Size: 0x35
function function_349b49faccd2f539( overlayasset )
{
    utility::callsharedfunc( #"fullscreenfx", #"hash_382df7654f0561bd", { #postfxbundlename:overlayasset }, 1, 1 );
}

// Namespace rallying_cry
// Params 1
// Checksum 0x33caff40, Offset: 0x19d4
// Size: 0x31
function function_c42b55e111075196( overlayasset )
{
    utility::callsharedfunc( #"fullscreenfx", #"hash_494b07757cd511a5", { #postfxbundlename:overlayasset } );
}

// Namespace rallying_cry
// Params 1, eflags: 0x4
// Checksum 0xa8dbec83, Offset: 0x1a0d
// Size: 0x58
function private function_6693aad77cf5906e( bundle )
{
    var_f9a2c4d46e592dae = bundle.var_d42f375a239392d2 ?? #"hash_ccbac74c3dda9fb0";
    self playsoundtoplayer( var_f9a2c4d46e592dae, self );
    
    if ( bundle.var_374c8a05218f928a )
    {
        self playsoundtoplayer( bundle.var_374c8a05218f928a, self );
    }
}

// Namespace rallying_cry
// Params 1, eflags: 0x4
// Checksum 0x6f9374e4, Offset: 0x1a6d
// Size: 0x38
function private function_27391b56e7b0a959( bundle )
{
    var_c3845cbc058b7d46 = bundle.var_7fee0b63d72b8d77 ?? #"hash_f9d0f7eca43e9cf4";
    self playsoundtoplayer( var_c3845cbc058b7d46, self );
}

// Namespace rallying_cry
// Params 1
// Checksum 0x7a8d7260, Offset: 0x1aad
// Size: 0x71
function function_95cb9e3e72df4d3b( params )
{
    if ( !self.var_63490a14ef1618a3 && self.var_7d107b7503b87ff5 )
    {
        rallyingcryscalar = self.var_86dd4266dc52e57f.bundle.var_e55bd260780df3c4 ?? 1.5;
        params.var_2b32a8de075bfd54 *= rallyingcryscalar;
    }
}

// Namespace rallying_cry
// Params 1, eflags: 0x4
// Checksum 0x17dcd484, Offset: 0x1b26
// Size: 0x89
function private function_8c5e06ee1e60aeb7( params )
{
    if ( isdefined( params.eattacker.var_86dd4266dc52e57f ) )
    {
        superinfo = params.eattacker.var_86dd4266dc52e57f.owningplayer supers_mp::getcurrentsuper();
        rallyingcryweapon = superinfo.staticdata.objweapon;
        setweaponstats( params.eattacker, rallyingcryweapon );
    }
}

// Namespace rallying_cry
// Params 1, eflags: 0x4
// Checksum 0xa7e37b37, Offset: 0x1bb7
// Size: 0x1e
function private function_fe706e38d7ba8fd3( weapon )
{
    thread namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"super_rallying_cry_kill", weapon );
}

// Namespace rallying_cry
// Params 1, eflags: 0x4
// Checksum 0x66768f33, Offset: 0x1bdd
// Size: 0x7b
function private function_3e85bd23460c12eb( bundle )
{
    var_8e4e717e87db1458 = function_384f4d1f7f62b68a( bundle );
    
    if ( self ismeatshieldattacker() )
    {
        return var_8e4e717e87db1458.meatshieldmultiplier;
    }
    
    if ( self crouchbuttonpressed() )
    {
        return var_8e4e717e87db1458.var_e1f486c6b3b8552f;
    }
    
    if ( self issupersprinting() )
    {
        return var_8e4e717e87db1458.tacsprintmultiplier;
    }
    
    if ( self issprinting() )
    {
        return var_8e4e717e87db1458.sprintmultiplier;
    }
    
    return var_8e4e717e87db1458.jogmultiplier;
}

