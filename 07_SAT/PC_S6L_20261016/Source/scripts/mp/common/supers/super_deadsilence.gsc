// scripts\mp\common\supers\super_deadsilence.gsc  (hash_501e973adc9ad69c.gscc) (size: 5377 Bytes / 0x1501 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbf11ba93 (3205610131)
// size ...... 5377 (0x1501)
// includes .. 11  (offset: 0x1321)
// strings ... 21  (offset: 0x1379)
// dev strs .. 1   (offset: 0x14f1)
// exports ... 13  (offset: 0xab9)
// cseg ...... 0x1d7 + 0x8e2 (0xab9)
// imports ... 55  (offset: 0xcc1)
// animtree1 . 0   (offset: 0x1501)
// animtree2 . 0   (offset: 0x1501)
#using script_74b851b7aa1ef32d;
#using scripts\common\ae_utility;
#using scripts\common\utility;
#using scripts\mp\analyticslog;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\scripted_weapons;
#using scripts\mp\supers;
#using scripts\mp\talking_gun;

#namespace super_deadsilence;

// Namespace super_deadsilence
// Params 0, eflags: 0x1
// Checksum 0xfb6b71be, Offset: 0x1f5
// Size: 0x9
function autoexec main()
{
    superdeadsilence_init();
}

// Namespace super_deadsilence
// Params 0
// Checksum 0xa79a0a86, Offset: 0x206
// Size: 0x67
function superdeadsilence_init()
{
    utility::flag_wait( "supers_initialized" );
    supers_mp::function_48aaa60b2ce7b8a1( "super_deadsilence", undefined, undefined, &superdeadsilence_beginsuper, &superdeadsilence_endsuper, undefined, undefined, undefined, undefined, undefined );
    utility::registersharedfunc( #"super_deadsilence", #"hash_7dff8b8d09af9e50", &superdeadsilence_onkill );
    utility::registersharedfunc( #"super_deadsilence", #"endhudsequence", &superdeadsilence_endhudsequence );
}

// Namespace super_deadsilence
// Params 0
// Checksum 0x63f35790, Offset: 0x275
// Size: 0x16
function superdeadsilence_beginsuper()
{
    result = function_e04c030602184d94();
    return result;
}

// Namespace super_deadsilence
// Params 0, eflags: 0x4
// Checksum 0xbc074998, Offset: 0x294
// Size: 0x5c
function private function_e04c030602184d94()
{
    if ( getdvarint( @"hash_88050a1ca3a6c70f", 0 ) == 1 )
    {
        return 1;
    }
    
    objweapon = scripted_weapons::get_scripted_weapon_object( #"deadsilence_device" );
    deploysuccess = weapon_utility::giveandfireoffhandreliable( objweapon );
    
    if ( deploysuccess )
    {
        return function_8f254f8cb8d45047();
    }
    
    supers_mp::refundsuper();
}

// Namespace super_deadsilence
// Params 0, eflags: 0x4
// Checksum 0x13fb036f, Offset: 0x2f8
// Size: 0x18b, Type: bool
function private function_8f254f8cb8d45047()
{
    perk::giveperk( "specialty_quieter" );
    perk::giveperk( "specialty_no_battle_chatter" );
    superbundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_deadsilence" );
    
    if ( superbundle.deadsilenceghost )
    {
        self setplayerghost( 1 );
    }
    
    self.deadsilencekills = 0;
    self.super.isactive = 1;
    
    if ( isdefined( self.pers[ "deadSilenceTime" ] ) )
    {
        self.deadsilencestarttime = gettime();
    }
    
    self playlocalsound( "deadsilence_start" );
    namespace_5f4bb62dbf67ff87::doonactionscoreevent( 1, "deadSilenceUsed" );
    superdeadsilence_updateuistate( 0 );
    talking_gun::talkinggun_event( self, #"equipment_deployed" );
    thread applyfovpresentation();
    thread superdeadsilence_watchforgameended();
    agents = getaiarrayinradius( self.origin, 2048 );
    
    foreach ( agent in agents )
    {
        if ( agent getthreatsight( self ) >= 1 )
        {
            agent setthreatsight( self, 0 );
        }
    }
    
    challenges::function_a0936b0e5b4550f3( "super_deadsilence", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"use" ) );
    thread function_644f99eec49e37ed();
    return true;
}

// Namespace super_deadsilence
// Params 2
// Checksum 0x8d65ef67, Offset: 0x48c
// Size: 0x26b, Type: bool
function superdeadsilence_endsuper( fromdeath, attacker )
{
    if ( getdvarint( @"hash_88050a1ca3a6c70f", 0 ) == 1 )
    {
        return false;
    }
    
    self setscriptablepartstate( "deadSilenceFX", "end", 0 );
    perk::removeperk( "specialty_quieter" );
    perk::removeperk( "specialty_no_battle_chatter" );
    superbundle = supers_mp::function_5ffd3dfa9cc1e8de( "super_deadsilence" );
    
    if ( superbundle.deadsilenceghost && !self.canghost )
    {
        self setplayerghost( 0 );
    }
    
    self.super.isactive = 0;
    
    if ( isdefined( self.pers[ "deadSilenceTime" ] ) )
    {
        currenttime = gettime();
        timeindeadsilence = currenttime - self.deadsilencestarttime;
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
        {
            if ( isdefined( self.leaderboarddata[ "deadSilenceTime" ] ) )
            {
                self.leaderboarddata[ "deadSilenceTime" ] = self.leaderboarddata[ "deadSilenceTime" ] + timeindeadsilence;
            }
            
            if ( isdefined( level.leaderboardfunc[ "deadSilenceTime" ] ) )
            {
                [[ level.leaderboardfunc[ "deadSilenceTime" ] ]]( self, timeindeadsilence );
            }
            
            assert( isint( timeindeadsilence ) || isfloat( timeindeadsilence ), "<dev string:x24>" );
            
            if ( isdefined( self.pers[ "deadSilenceTime" ] ) )
            {
                self.pers[ "deadSilenceTime" ] = self.pers[ "deadSilenceTime" ] + timeindeadsilence;
            }
        }
    }
    
    if ( game_utility::getgametype() != "infect" )
    {
        analyticslog::logevent_fieldupgradeexpired( self, level.superglobals.staticsuperdata[ "super_deadsilence" ].id, self.deadsilencekills, istrue( fromdeath ) );
    }
    
    thread superdeadsilence_endhudsequence();
    
    if ( utility::issharedfuncdefined( #"br", #"superslotcleanup" ) )
    {
        self [[ utility::getsharedfunc( #"br", #"superslotcleanup" ) ]]();
    }
    
    if ( isdefined( self.var_dbd961dd562aa638 ) )
    {
        challenges::function_a0936b0e5b4550f3( "super_deadsilence", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"end" ), self.var_5f3387e7bb19aea3 );
    }
    
    return false;
}

// Namespace super_deadsilence
// Params 0
// Checksum 0xf0dad208, Offset: 0x700
// Size: 0x17a
function superdeadsilence_onkill()
{
    if ( getdvarint( @"hash_88050a1ca3a6c70f", 0 ) == 1 )
    {
        return;
    }
    
    if ( game_utility::getgametype() != "infect" )
    {
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
        {
            if ( isdefined( self.leaderboarddata[ "deadSilenceKills" ] ) )
            {
                self.leaderboarddata[ "deadSilenceKills" ] = self.leaderboarddata[ "deadSilenceKills" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "deadSilenceKills" ] ) )
            {
                [[ level.leaderboardfunc[ "deadSilenceKills" ] ]]( self, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
            
            if ( isdefined( self.pers[ "deadSilenceKills" ] ) )
            {
                self.pers[ "deadSilenceKills" ] = self.pers[ "deadSilenceKills" ] + 1;
            }
        }
        
        supers_mp::combatrecordsuperkill( "super_deadsilence" );
        self.deadsilencekills++;
        var_9d0c27bce60244ef = supers_mp::getcombatrecordsupermisc( "super_deadsilence" );
        
        if ( self.deadsilencekills > var_9d0c27bce60244ef )
        {
            increment = self.deadsilencekills - var_9d0c27bce60244ef;
            supers_mp::combatrecordsupermisc( "super_deadsilence", increment );
        }
    }
    
    self playlocalsound( "deadsilence_start" );
    superdeadsilence_updateuistate( 1 );
    supers_mp::resetsuperusepercent();
    thread applyfovpresentation();
}

// Namespace super_deadsilence
// Params 0
// Checksum 0xa8eae4d9, Offset: 0x882
// Size: 0x23
function superdeadsilence_endhudsequence()
{
    self endon( #"disconnect" );
    superdeadsilence_updateuistate( 2 );
    wait 1;
    superdeadsilence_updateuistate( -1 );
}

// Namespace super_deadsilence
// Params 1
// Checksum 0x6c1bd81c, Offset: 0x8ad
// Size: 0x24
function superdeadsilence_updateuistate( newstate )
{
    self.deadsilenceuistate = newstate;
    self setclientomnvar( "ui_deadsilence_overlay", newstate );
}

// Namespace super_deadsilence
// Params 0
// Checksum 0x78bc43e2, Offset: 0x8d9
// Size: 0xb0
function applyfovpresentation()
{
    self endon( #"death_or_disconnect" );
    self notify( #"hash_6905fb37f08f5a8e" );
    self endon( #"hash_6905fb37f08f5a8e" );
    self setscriptablepartstate( "deadSilenceFX", "neutral", 0 );
    waitframe();
    self lerpfovbypreset( "zombiedefault" );
    self playlocalsound( "deadsilence_end" );
    self setscriptablepartstate( "deadSilenceFX", "start", 0 );
    duration = self.super.staticdata.usetime;
    var_6fa5c4782dab1b97 = duration - 2;
    utility::waittill_any_timeout_no_endon_death( var_6fa5c4782dab1b97, "super_use_finished" );
    self lerpfovbypreset( "default_2seconds" );
}

// Namespace super_deadsilence
// Params 0
// Checksum 0x5072fda1, Offset: 0x991
// Size: 0x4b
function superdeadsilence_watchforgameended()
{
    self endon( #"death_or_disconnect" );
    self endon( #"super_use_finished" );
    self notify( #"hash_45099c9d5ea5861e" );
    self endon( #"hash_45099c9d5ea5861e" );
    level utility::waittill_any( "game_ended", "prematch_cleanup" );
    thread supers_mp::superusefinished();
}

// Namespace super_deadsilence
// Params 0
// Checksum 0x962768a3, Offset: 0x9e4
// Size: 0xd5
function function_644f99eec49e37ed()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"disconnect" );
    self endon( #"super_use_finished" );
    self.var_5f3387e7bb19aea3 = 0;
    var_a6484291e5d2ef2e = 39.3701;
    playerprevpos = self.origin;
    distanceinches = 0;
    
    while ( isdefined( self.super ) && self.super.isactive )
    {
        if ( true )
        {
            var_d22f255f318cfc7b = self.origin;
            distanceinches += distance( var_d22f255f318cfc7b, playerprevpos );
            playerprevpos = var_d22f255f318cfc7b;
            self.var_5f3387e7bb19aea3 = int( round( distanceinches / var_a6484291e5d2ef2e ) );
        }
        
        wait 0.1;
    }
}

