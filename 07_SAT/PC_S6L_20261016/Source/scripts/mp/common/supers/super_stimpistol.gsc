// scripts\mp\common\supers\super_stimpistol.gsc  (hash_1b633080ceb74fc3.gscc) (size: 7864 Bytes / 0x1eb8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe7ecfdd5 (3891068373)
// size ...... 7864 (0x1eb8)
// includes .. 13  (offset: 0x1d78)
// strings ... 11  (offset: 0x1de0)
// dev strs .. 3   (offset: 0x1e94)
// exports ... 32  (offset: 0x106c)
// cseg ...... 0x16b + 0xf01 (0x106c)
// imports ... 69  (offset: 0x156c)
// animtree1 . 0   (offset: 0x1eb8)
// animtree2 . 0   (offset: 0x1eb8)
#using script_74b851b7aa1ef32d;
#using scripts\common\ae_utility;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\pickups_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\damagefeedback;
#using scripts\mp\laststand;
#using scripts\mp\supers;
#using scripts\mp\teamrevive;

#namespace super_stimpistol;

// Namespace super_stimpistol
// Params 0, eflags: 0x1
// Checksum 0x65504779, Offset: 0x189
// Size: 0x9
function autoexec main()
{
    super_stimpistol_init();
}

// Namespace super_stimpistol
// Params 0
// Checksum 0x1e563d2f, Offset: 0x19a
// Size: 0x1ae
function super_stimpistol_init()
{
    utility::flag_wait( "supers_initialized" );
    supers_mp::function_48aaa60b2ce7b8a1( "super_stimpistol", &super_stimpistol_set, &super_stimpistol_unset, &super_stimpistolbeginuse, &function_f89acde988c6c38c, undefined, undefined, undefined, undefined, undefined );
    level.var_390eff106c4cf73b = getdvarint( @"hash_660a6d69270c9d7c", level.gametypebundle.var_fa2504f991854571 ?? 1 );
    level.var_673c853db1f580e9 = getdvarint( @"hash_3a7a4bf29f0f6e78", level.gametypebundle.var_4cd1ce5ee940412a ?? 0 );
    level.var_7fa624f83b15cde1 = level.gametypebundle.var_9758d515e8a7296 ?? 1;
    level.var_776e3ebd4a88e89c = getdvarint( @"hash_bd6ad02d326bbffc", level.gametypebundle.var_2316869b78d9f4cb ?? 1 );
    level.var_db483dbb91d1e9cb = getdvarint( @"hash_9f96b49415b4afab", level.gametypebundle.var_11ee51fba74cd436 ?? 0 );
    level.var_c561b62a87b4af02 = level.gametypebundle.var_5731b3f81e65432a ?? 1;
    utility::registersharedfunc( #"hash_a4d82011a2a333b3", #"selfreviveready", &function_5544ffc601cb83dd );
    utility::registersharedfunc( #"hash_a4d82011a2a333b3", #"onTake", &function_d678ff0e70a372c8 );
    utility::registersharedfunc( #"hash_a4d82011a2a333b3", #"hash_c646f570f2930be5", &function_b72d883872f352c4 );
    utility::registersharedfunc( #"hash_a4d82011a2a333b3", #"hash_dbfc9b45172a4949", &super_stimpistol_gethostilerevivesenabled );
    
    /#
        level thread function_6816852d3ec9af5d();
    #/
}

/#

    // Namespace super_stimpistol
    // Params 0
    // Checksum 0x42505b73, Offset: 0x350
    // Size: 0xd, Type: dev
    function function_6816852d3ec9af5d()
    {
        level thread function_fab613510afea2a2();
    }

    // Namespace super_stimpistol
    // Params 0
    // Checksum 0xd2001278, Offset: 0x365
    // Size: 0xb6, Type: dev
    function function_fab613510afea2a2()
    {
        while ( true )
        {
            trigger = getdvarint( @"hash_13779b55083ae0e1" );
            setdvar( @"hash_13779b55083ae0e1", 0 );
            
            if ( trigger )
            {
                foreach ( player in level.players )
                {
                    player thread function_c9066b5464e3f157( trigger );
                }
            }
            
            waitframe();
            trigger = 0;
        }
    }

#/

// Namespace super_stimpistol
// Params 1
// Checksum 0x7bb041ae, Offset: 0x423
// Size: 0x2a, Type: bool
function super_stimpistol_isstimpistol( weaponobj )
{
    if ( !isdefined( weaponobj ) )
    {
        return false;
    }
    
    return weaponobj.var_5e3a1c87edc1edd5 == #"hash_a4d82011a2a333b3";
}

// Namespace super_stimpistol
// Params 0
// Checksum 0x40bcc5bf, Offset: 0x456
// Size: 0x2
function function_b45568853e1ddeec()
{
    
}

// Namespace super_stimpistol
// Params 0
// Checksum 0x1bdd3880, Offset: 0x460
// Size: 0x18, Type: bool
function super_stimpistol_gethostilerevivesenabled()
{
    return level.var_390eff106c4cf73b || level.var_673c853db1f580e9;
}

// Namespace super_stimpistol
// Params 0
// Checksum 0x1d9f5bb0, Offset: 0x481
// Size: 0x64
function function_d678ff0e70a372c8()
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    superinfo = supers_mp::getcurrentsuper();
    supers_mp::setsuperisinuse( 1 );
    supers_mp::setsuperisactive( 1 );
    supers_mp::function_e39fe9f7f0484f10( superinfo.staticdata.useweapon, undefined, 100 );
    br_pickups::resetsuper();
}

// Namespace super_stimpistol
// Params 0
// Checksum 0xedead427, Offset: 0x4ed
// Size: 0x30
function function_9b8f8a2d70250f50()
{
    if ( isdefined( self.var_5f87feddcabb8ed ) )
    {
        self.var_5f87feddcabb8ed = undefined;
    }
    
    if ( isdefined( self.var_db30b7b119be2144 ) )
    {
        self.var_db30b7b119be2144 = undefined;
    }
}

// Namespace super_stimpistol
// Params 0
// Checksum 0xdf82f39f, Offset: 0x525
// Size: 0x62, Type: bool
function function_5544ffc601cb83dd()
{
    currentsuper = supers_mp::getcurrentsuper();
    
    if ( !isdefined( currentsuper ) )
    {
        return false;
    }
    
    if ( currentsuper.staticdata.ref != "super_stimpistol" )
    {
        return false;
    }
    
    superammo = supers_mp::function_9e6dc95ca52d8e3f();
    
    if ( superammo > 0 || supers_mp::issuperready() )
    {
        return true;
    }
    
    return false;
}

// Namespace super_stimpistol
// Params 0, eflags: 0x4
// Checksum 0xa3944cf2, Offset: 0x590
// Size: 0x9d
function private super_stimpistol_watchhits()
{
    self notify( #"super_stimpistol_watchhits" );
    self endon( #"super_stimpistol_watchhits" );
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        self waittill( #"bullet_first_impact", impacts );
        
        if ( isdefined( impacts[ 0 ].hitent ) && super_stimpistol_isstimpistol( impacts[ 0 ].weapon ) )
        {
            thread function_b2727f0552367a6b( impacts[ 0 ].hitent, impacts[ 0 ].hitpos, impacts[ 0 ].weapon );
        }
    }
}

// Namespace super_stimpistol
// Params 1, eflags: 0x4
// Checksum 0x2bc1987a, Offset: 0x635
// Size: 0x1e, Type: bool
function private function_7d0101d55b18d965( var_bf6d10a20502a10a )
{
    return isdefined( var_bf6d10a20502a10a ) && isdefined( var_bf6d10a20502a10a.var_56dae150fb12de53 );
}

// Namespace super_stimpistol
// Params 1, eflags: 0x4
// Checksum 0xd4b30bbb, Offset: 0x65c
// Size: 0x1e, Type: bool
function private function_e157e7547721a440( var_bf6d10a20502a10a )
{
    return isdefined( var_bf6d10a20502a10a ) && isdefined( var_bf6d10a20502a10a.var_4c644ebcc7c0ec52 );
}

// Namespace super_stimpistol
// Params 1, eflags: 0x4
// Checksum 0x838ea10e, Offset: 0x683
// Size: 0xad
function private super_stimpistol_tagentashit( stimpistolshooter )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self notify( #"super_stimpistol_tagentashit" );
    self endon( #"super_stimpistol_tagentashit" );
    
    if ( !isdefined( self.var_85e846fdb8674638 ) )
    {
        self.var_85e846fdb8674638 = stimpistolshooter;
    }
    
    if ( isdefined( self.var_8bec82459b31fc31 ) && !self.var_8bec82459b31fc31.inuse )
    {
        self.var_8bec82459b31fc31.inuse = 1;
    }
    
    wait 3;
    
    while ( player::getbeingrevivedinternal() )
    {
        wait 0.1;
    }
    
    self.var_85e846fdb8674638 = undefined;
}

// Namespace super_stimpistol
// Params 3, eflags: 0x4
// Checksum 0xb8db7bc3, Offset: 0x738
// Size: 0xdd
function private function_f47f2eb402842580( hittarget, typeint, var_70f9c4aa33e1763d )
{
    if ( !isdefined( hittarget ) )
    {
        return;
    }
    
    if ( !isplayer( hittarget ) || !isbot( hittarget ) )
    {
        return;
    }
    
    if ( !hittarget.inlaststand && !hittarget.liveragdoll && !var_70f9c4aa33e1763d )
    {
        return;
    }
    
    if ( typeint == 1 )
    {
        damagefeedback::updatehitmarker( "hithealing_stimpistol", 0, 0, 0, "hitlaststand_stimpistol", self getentitynumber() );
    }
    else if ( typeint == 2 )
    {
        damagefeedback::updatehitmarker( "hithealing_stimpistol", 0, 0, 0, "hitcyber_stimpistol", self getentitynumber() );
    }
    
    if ( typeint == 3 )
    {
        damagefeedback::updatehitmarker( "hithealing_stimpistol", 0, 0, 0, undefined, self getentitynumber() );
        return;
    }
    
    damagefeedback::updatehitmarker( "hithealing_stimpistol", 0, 0, 0, undefined, self getentitynumber() );
}

// Namespace super_stimpistol
// Params 0
// Checksum 0xa16551d1, Offset: 0x81d
// Size: 0xc, Type: bool
function function_b72d883872f352c4()
{
    return isdefined( self.var_85e846fdb8674638 );
}

// Namespace super_stimpistol
// Params 1
// Checksum 0x804ea258, Offset: 0x832
// Size: 0x90
function function_7e53405a65113ec5( revivee )
{
    var_bf6d10a20502a10a = spawnstruct();
    var_bf6d10a20502a10a.reviver = self;
    var_bf6d10a20502a10a.revivee = revivee ?? undefined;
    var_bf6d10a20502a10a.var_56dae150fb12de53 = revivee teamrevive::function_3d55f641f566733f();
    var_bf6d10a20502a10a.var_4c644ebcc7c0ec52 = revivee.var_8bec82459b31fc31 ?? undefined;
    var_bf6d10a20502a10a.laststandrevivetimervalue = function_c29ebc4d138c7fd2();
    var_bf6d10a20502a10a.var_5efb6f97c29b1239 = function_454cb071668fffd7();
    return var_bf6d10a20502a10a;
}

// Namespace super_stimpistol
// Params 2
// Checksum 0x7b04c2, Offset: 0x8cb
// Size: 0x5b
function function_e3d81eeb507fc603( shootingplayer, shotplayer )
{
    newweapon = level.superglobals.staticsuperdata[ "super_stimpistol" ].useweapon;
    shootingplayer function_b2727f0552367a6b( shotplayer, shotplayer.origin, newweapon );
}

// Namespace super_stimpistol
// Params 3, eflags: 0x4
// Checksum 0xc947415a, Offset: 0x92e
// Size: 0x27f
function private function_b2727f0552367a6b( hitent, impactpos, weapon )
{
    level endon( #"game_ended" );
    
    if ( isdefined( hitent ) )
    {
        hitent endon( #"death_or_disconnect" );
    }
    
    if ( !super_stimpistol_isstimpistol( weapon ) )
    {
        return;
    }
    
    if ( !isdefined( hitent ) )
    {
        return;
    }
    
    if ( !isplayer( hitent ) || isagent( hitent ) )
    {
        return;
    }
    
    if ( !isdefined( hitent.team ) )
    {
        return;
    }
    
    shotfriendly = hitent.team == self.team;
    
    if ( !shotfriendly && !( level.var_390eff106c4cf73b || level.var_673c853db1f580e9 || level.var_7fa624f83b15cde1 ) )
    {
        return;
    }
    
    hitent thread super_stimpistol_tagentashit( self );
    var_bf6d10a20502a10a = function_7e53405a65113ec5( hitent );
    
    if ( level.var_776e3ebd4a88e89c && ( shotfriendly || !shotfriendly && level.var_390eff106c4cf73b ) )
    {
        if ( isdefined( var_bf6d10a20502a10a.revivee ) && function_e157e7547721a440( var_bf6d10a20502a10a ) && player::isinlaststand( var_bf6d10a20502a10a.revivee ) )
        {
            function_cbb8c8ba05f084f4( var_bf6d10a20502a10a );
            challenges::function_a0936b0e5b4550f3( "super_stimpistol", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"hit" ) );
            function_f47f2eb402842580( hitent, 1 );
            return;
        }
    }
    
    if ( level.var_c561b62a87b4af02 && utility::callsharedfunc( #"health_chunk", #"isenabled" ) && player::isreallyalive( hitent ) && !player::isinlaststand( hitent ) && ( shotfriendly || !shotfriendly && level.var_7fa624f83b15cde1 ) )
    {
        hitent utility::callsharedfunc( #"health_chunk", #"restorechunks", hitent );
        namespace_5f4bb62dbf67ff87::doonactionscoreevent( 1, "superStimHealthRegen", 0 );
        function_f47f2eb402842580( hitent, 3, 1 );
        return;
    }
    
    if ( level.var_db483dbb91d1e9cb && ( shotfriendly || !shotfriendly && level.var_673c853db1f580e9 ) )
    {
        if ( function_7d0101d55b18d965( var_bf6d10a20502a10a ) )
        {
            super_stimpistol_startcyberrevive( var_bf6d10a20502a10a );
            challenges::function_a0936b0e5b4550f3( "super_stimpistol", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"hit" ) );
            function_f47f2eb402842580( hitent, 2 );
            return;
        }
        
        thread super_stimpistol_startcyberrevive_retrythread( hitent );
    }
}

// Namespace super_stimpistol
// Params 1
// Checksum 0x59437c9e, Offset: 0xbb5
// Size: 0xed
function function_cbb8c8ba05f084f4( var_bf6d10a20502a10a )
{
    var_bf6d10a20502a10a.revivee playsoundtoplayer( "weap_stimpistol_plr_hit_revive", var_bf6d10a20502a10a.revivee );
    var_bf6d10a20502a10a.var_4c644ebcc7c0ec52.var_4ee5e9a000363129 = 1;
    
    if ( level.var_390eff106c4cf73b )
    {
        var_bf6d10a20502a10a.var_4c644ebcc7c0ec52.skipteamchecks = 1;
    }
    
    var_bf6d10a20502a10a.reviver.var_e0a3e97f1aea8404 = 1;
    var_bf6d10a20502a10a.var_4c644ebcc7c0ec52 notify( #"trigger", var_bf6d10a20502a10a.reviver );
    
    if ( isdefined( var_bf6d10a20502a10a.revivee ) && var_bf6d10a20502a10a.revivee.team == var_bf6d10a20502a10a.reviver.team )
    {
        namespace_5f4bb62dbf67ff87::doonactionscoreevent( 1, "superStimHeal" );
    }
}

// Namespace super_stimpistol
// Params 1
// Checksum 0x41277d0f, Offset: 0xcaa
// Size: 0x11e
function super_stimpistol_startcyberrevive( var_bf6d10a20502a10a )
{
    var_bf6d10a20502a10a.revivee playsoundtoplayer( "weap_stimpistol_plr_hit_revive", var_bf6d10a20502a10a.revivee );
    var_bf6d10a20502a10a.var_56dae150fb12de53.var_4ee5e9a000363129 = 1;
    var_bf6d10a20502a10a.var_56dae150fb12de53.skipviewmodelanim = 1;
    var_bf6d10a20502a10a.var_56dae150fb12de53.useweapon = undefined;
    var_bf6d10a20502a10a.var_56dae150fb12de53.remoterevive = 1;
    
    if ( level.var_673c853db1f580e9 )
    {
        var_bf6d10a20502a10a.var_56dae150fb12de53.var_a2940755dad79c43 = 1;
    }
    
    teamrevive::function_6036ecefbef406f8( var_bf6d10a20502a10a.var_56dae150fb12de53, "cyber_revive_icon", undefined, var_bf6d10a20502a10a.reviver, undefined, undefined );
    
    if ( isdefined( var_bf6d10a20502a10a.revivee ) && var_bf6d10a20502a10a.revivee.team == var_bf6d10a20502a10a.reviver.team )
    {
        namespace_5f4bb62dbf67ff87::doonactionscoreevent( 1, "superStimHeal" );
    }
}

// Namespace super_stimpistol
// Params 1, eflags: 0x4
// Checksum 0xc5ea8112, Offset: 0xdd0
// Size: 0xdd
function private super_stimpistol_startcyberrevive_retrythread( hitent )
{
    hitent notify( #"super_stimpistol_startcyberrevive_retrythread" );
    hitent endon( #"super_stimpistol_startcyberrevive_retrythread" );
    hitent endon( #"last_stand_enter" );
    hitent endon( #"death_or_disconnect" );
    var_bf6d10a20502a10a = function_7e53405a65113ec5( hitent );
    retrycount = 0;
    
    while ( !function_7d0101d55b18d965( var_bf6d10a20502a10a ) && hitent.liveragdoll && game_utility_mp::isteamreviveenabled() )
    {
        retrycount++;
        wait 1;
        hitent super_stimpistol_tagentashit( self );
        
        if ( function_7d0101d55b18d965( var_bf6d10a20502a10a ) )
        {
            super_stimpistol_startcyberrevive( var_bf6d10a20502a10a );
            challenges::function_a0936b0e5b4550f3( "super_stimpistol", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"hit" ) );
            break;
        }
        
        if ( retrycount >= 5 )
        {
            break;
        }
    }
}

// Namespace super_stimpistol
// Params 0, eflags: 0x4
// Checksum 0xece64d26, Offset: 0xeb5
// Size: 0x22, Type: bool
function private function_454cb071668fffd7()
{
    out = level.teamrevivetime ?? 5;
    return out ?? undefined;
}

// Namespace super_stimpistol
// Params 0, eflags: 0x4
// Checksum 0x6f33ece6, Offset: 0xee0
// Size: 0x1a, Type: bool
function private function_c29ebc4d138c7fd2()
{
    out = laststand::getdefaultlaststandrevivetimervalue();
    return out ?? undefined;
}

// Namespace super_stimpistol
// Params 0
// Checksum 0xa8428fdc, Offset: 0xf03
// Size: 0x37, Type: bool
function super_stimpistolbeginuse()
{
    thread super_stimpistol_watchhits();
    function_a01d9b7b11abd5ca( 0 );
    challenges::function_a0936b0e5b4550f3( "super_stimpistol", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"use" ) );
    return true;
}

// Namespace super_stimpistol
// Params 2
// Checksum 0xf1052b0d, Offset: 0xf43
// Size: 0x34
function function_f89acde988c6c38c( fromdeath, attacker )
{
    self notify( #"super_stimpistol_watchhits" );
    function_a01d9b7b11abd5ca( 1 );
    self.var_88df3826b9b93cb0 = undefined;
}

// Namespace super_stimpistol
// Params 0
// Checksum 0x850d9df7, Offset: 0xf7f
// Size: 0xe
function super_stimpistol_set()
{
    perk::giveperk( "specialty_pistoldeath" );
}

// Namespace super_stimpistol
// Params 0
// Checksum 0x8399e0ee, Offset: 0xf95
// Size: 0x22
function super_stimpistol_unset()
{
    self.var_5f87feddcabb8ed = undefined;
    self.var_db30b7b119be2144 = undefined;
    perk::removeperk( "specialty_pistoldeath" );
}

// Namespace super_stimpistol
// Params 1
// Checksum 0x9f30948f, Offset: 0xfbf
// Size: 0x28
function function_a01d9b7b11abd5ca( b_value = 0 )
{
    if ( b_value )
    {
        self enableweaponpickup();
        return;
    }
    
    self disableweaponpickup();
}

// Namespace super_stimpistol
// Params 0
// Checksum 0xc1d93fd8, Offset: 0xfef
// Size: 0x1e
function function_d889b156d9d41db4()
{
    waittime = 10;
    thread pickups::playerplaygestureweaponanim( "iw9_vm_ges_stimpistol_dart_remove", waittime );
}

/#

    // Namespace super_stimpistol
    // Params 1
    // Checksum 0x38437cd1, Offset: 0x1015
    // Size: 0x57, Type: dev
    function function_c9066b5464e3f157( triggerint )
    {
        if ( triggerint == 1 )
        {
            thread pickups::playerplaygestureweaponanim( "<dev string:x24>", 10 );
            return;
        }
        
        if ( triggerint == 2 )
        {
            thread pickups::playerplaygestureweaponanim( "<dev string:x3d>", 10 );
            return;
        }
        
        if ( triggerint == 3 )
        {
            thread pickups::playerplaygestureweaponanim( "<dev string:x62>", 10 );
        }
    }

#/
