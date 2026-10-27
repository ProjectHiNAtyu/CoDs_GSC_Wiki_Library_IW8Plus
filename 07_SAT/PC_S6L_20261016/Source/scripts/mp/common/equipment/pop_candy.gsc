// scripts\mp\common\equipment\pop_candy.gsc  (hash_1276aa304b2eda02.gscc) (size: 19671 Bytes / 0x4cd7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x840f0ac9 (2215578313)
// size ...... 19671 (0x4cd7)
// includes .. 21  (offset: 0x4957)
// strings ... 48  (offset: 0x49ff)
// dev strs .. 3   (offset: 0x4cb3)
// exports ... 55  (offset: 0x2b83)
// cseg ...... 0x3d5 + 0x27ae (0x2b83)
// imports ... 176 (offset: 0x341b)
// animtree1 . 0   (offset: 0x4cd7)
// animtree2 . 0   (offset: 0x4cd7)
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\emp_debuff;
#using scripts\mp\equipment;
#using scripts\mp\gamelogic;
#using scripts\mp\gamescore;
#using scripts\mp\hud_util;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\talking_gun;

#namespace pop_candy;

// Namespace pop_candy
// Params 0, eflags: 0x1
// Checksum 0x84dd60c6, Offset: 0x3f3
// Size: 0x35
function autoexec main()
{
    level callback::add( #"hash_244314ef9125e636", &function_ca3a49b985b3f353 );
    level callback::add( #"player_laststand", &function_f7054d0660eed0d9 );
    popcandy_init();
}

// Namespace pop_candy
// Params 0
// Checksum 0x2c5ead7c, Offset: 0x430
// Size: 0x1f9
function popcandy_init()
{
    utility::flag_wait( "equipment_initialized" );
    bundle = equipment_mp::function_c90a9aa89b223dd7( "equip_pop_candy" );
    
    if ( !bundle )
    {
        return;
    }
    
    level.pop_candy_data = {};
    level.pop_candy_data.deployweapon = bundle.var_b9c09a91e3baf77c;
    level.pop_candy_data.useweapon = bundle.useweapon;
    setdvarifuninitialized( @"scr_pop_candy_radius", 1500 );
    setdvarifuninitialized( @"hash_c6ca3119971c129a", 1250 );
    setdvarifuninitialized( @"scr_pop_candy_height", 4000 );
    setdvarifuninitialized( @"hash_530b8614084ec7c", 1.75 );
    setdvarifuninitialized( @"hash_48c8c5b7939e8836", 1500 );
    setdvarifuninitialized( @"hash_7c7b1526bb05c131", 3 );
    setdvarifuninitialized( @"hash_ffb3f86c1ecd47d1", 0 );
    setdvarifuninitialized( @"hash_e86bd1bee69ea01a", 0 );
    setdvarifuninitialized( @"scr_pop_candy_duration", 10 );
    setdvarifuninitialized( @"hash_5abceda4251bf9c8", 0.6 );
    setdvarifuninitialized( @"hash_1c125ba60e650e3", 3 );
    setdvarifuninitialized( @"scr_pop_candy_cooldown", 3 );
    setdvarifuninitialized( @"scr_pop_candy_debug", 0 );
    level callback::add( #"player_offhand_pullback", &function_1b365d66cd63ef2f );
    level callback::add( #"equipment_use_success", &function_d5fd544d1ac2c1d2 );
    
    if ( utility::issharedfuncdefined( #"jamming_system", #"hash_eb3c0dbf85c7f9de" ) )
    {
        utility::callsharedfunc( #"jamming_system", #"hash_eb3c0dbf85c7f9de", "equip_pop_candy" );
    }
    
    thread utility::callsharedfunc( #"analytics", #"hash_eb9d0dae8f38111f", { #customend:1, #customstart:1, #customhit:1, #equipref:"equip_pop_candy" } );
}

// Namespace pop_candy
// Params 1
// Checksum 0xaeb66768, Offset: 0x631
// Size: 0x3d
function function_1b365d66cd63ef2f( params )
{
    if ( params.objweapon.basename == function_ef6d520550bbc418() )
    {
        function_b6c3ef42548a766( params.objweapon );
    }
}

// Namespace pop_candy
// Params 1
// Checksum 0xe156a1, Offset: 0x676
// Size: 0x33
function popcandy_on_fire( params )
{
    if ( params.grenade == function_ef6d520550bbc418() )
    {
        function_b6c3ef42548a766( params.grenade );
    }
}

// Namespace pop_candy
// Params 1
// Checksum 0xaf0facff, Offset: 0x6b1
// Size: 0x4c
function function_d5fd544d1ac2c1d2( params )
{
    if ( params.ref == "equip_pop_candy" && self.var_5ef152ad729e326e )
    {
        equipment_mp::setequipmentslotammo( "secondary", self.var_5ef152ad729e326e );
        self.var_5ef152ad729e326e = undefined;
    }
}

// Namespace pop_candy
// Params 1
// Checksum 0x1128a78e, Offset: 0x705
// Size: 0xd3
function function_b6c3ef42548a766( grenade )
{
    challenges::function_3d7a169dbae062fb( "equip_pop_candy", self, undefined, ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"use" ) );
    thread function_2474953d766a5a02();
    thread function_6e09018aa2e60c03( grenade );
    wait 1.75;
    thread function_5d854ee8b71d1a50();
    talking_gun::talkinggun_event( self, #"equipment_deployed" );
    
    /#
        if ( getdvarint( @"scr_pop_candy_debug", 0 ) )
        {
            thread function_d2aa0f0a39eef36();
        }
    #/
    
    if ( !function_95599afb602b5263() )
    {
        function_ec2518e8898e2e71( grenade, 0 );
        return;
    }
    
    objweapon = makeweapon( function_ef6d520550bbc418() );
    thread function_c7f3da95455fb52f( objweapon );
    radarpingenabled = getdvarint( @"hash_e86bd1bee69ea01a", 0 );
    
    if ( radarpingenabled )
    {
        thread function_be9e10e9d9228929();
    }
}

// Namespace pop_candy
// Params 1, eflags: 0x4
// Checksum 0xdad8bad9, Offset: 0x7e0
// Size: 0x54
function private function_6e09018aa2e60c03( grenade )
{
    eventdata = utility::callsharedfunc( #"analytics", #"hash_22a37c3ed1cf5035", { #equipref:"equip_pop_candy", #attacker:self, #einflictor:grenade } );
}

// Namespace pop_candy
// Params 0, eflags: 0x4
// Checksum 0xae8d4249, Offset: 0x83c
// Size: 0x72, Type: bool
function private function_95599afb602b5263()
{
    radius = getdvarfloat( @"scr_pop_candy_radius", 1500 );
    height = getdvarfloat( @"scr_pop_candy_height", 4000 );
    players = getplayersinradius( self.origin, radius, height, undefined, teams::getteamdata( self.team, "players" ) );
    return players && players.size > 0;
}

// Namespace pop_candy
// Params 2, eflags: 0x4
// Checksum 0x507e9230, Offset: 0x8b7
// Size: 0x96
function private function_ec2518e8898e2e71( grenade, success )
{
    if ( !success )
    {
        self.var_5ef152ad729e326e = equipment_mp::getequipmentslotammo( "secondary" );
        lower_message::setlowermessageomnvar( "pop_candy_no_targets", undefined, 5 );
    }
    
    function_a5e08d293e5fa3df( success );
    thread utility::callsharedfunc( #"analytics", #"hash_e348d92f8fdade0c", { #position:self.origin, #equipref:"equip_pop_candy", #owner:self, #ent:grenade } );
}

// Namespace pop_candy
// Params 1, eflags: 0x4
// Checksum 0x670a5e0a, Offset: 0x955
// Size: 0x5f
function private function_a5e08d293e5fa3df( success )
{
    bundle = equipment_mp::function_c90a9aa89b223dd7( "equip_pop_candy" );
    
    if ( !bundle )
    {
        return;
    }
    
    targetsound = success ? bundle.var_afd7a9e1a06f96e5 : bundle.var_cab556401ea48bf8;
    
    if ( targetsound )
    {
        self playlocalsound( targetsound );
    }
}

// Namespace pop_candy
// Params 0
// Checksum 0x6e5dc3bd, Offset: 0x9bc
// Size: 0x88
function function_5d854ee8b71d1a50()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self earthquakeforplayer( 0.1, 1, self.origin, 2000 );
    self setscriptablepartstate( "pop_candy_pulse", "pulse", 0 );
    self setscriptablepartstate( "pop_candy_blast", "initial_blast", 0 );
    utility::waittill_any_timeout( 1, "death" );
    self setscriptablepartstate( "pop_candy_pulse", "off", 0 );
    self setscriptablepartstate( "pop_candy_blast", "off", 0 );
}

// Namespace pop_candy
// Params 0
// Checksum 0x3192cce7, Offset: 0xa4c
// Size: 0x62
function function_be9e10e9d9228929()
{
    radius = getdvarint( @"scr_pop_candy_radius", 1500 );
    sweeptime = getdvarint( @"hash_c6ca3119971c129a", 1250 );
    triggerportableradarping( self.origin, self, radius, sweeptime );
    wait 0.2;
    triggerportableradarping( self.origin, self, radius, sweeptime );
}

// Namespace pop_candy
// Params 2
// Checksum 0x8e26e8c2, Offset: 0xab6
// Size: 0x117, Type: bool
function function_733680205629c9da( attacker, victim )
{
    if ( !isdefined( victim ) )
    {
        return false;
    }
    
    if ( isagent( victim ) )
    {
        return false;
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
        
        if ( !player_utility::playersareenemies( attacker, victim ) )
        {
            return false;
        }
        
        if ( victim utility::isusingremote() )
        {
            return false;
        }
        
        if ( isdefined( victim.perks[ "specialty_blindeye" ] ) )
        {
            attacker iprintlnbold( "Failed to upload virus" );
            return false;
        }
        
        if ( victim [[ utility::getsharedfunc( #"jamming_system", #"hash_f3a152be2dbc14b9" ) ]]() )
        {
            return false;
        }
        
        if ( victim.var_28aa1e3338af6677 )
        {
            return false;
        }
        
        popcandycooldown = getdvarfloat( @"scr_pop_candy_cooldown", 3 );
        
        if ( popcandycooldown > 0 && isdefined( victim.var_a2678850d4bd250a ) && ( gettime() - victim.var_a2678850d4bd250a ) / 1000 < popcandycooldown )
        {
            return false;
        }
        
        return true;
    }
    
    return false;
}

// Namespace pop_candy
// Params 1
// Checksum 0x7dc76f0, Offset: 0xbd6
// Size: 0x17f
function function_c7f3da95455fb52f( objweapon )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self notify( #"hash_55ae1320dedb4542" );
    self endon( #"hash_55ae1320dedb4542" );
    time = getdvarfloat( @"scr_pop_candy_duration", 10 );
    players = function_c272a44d64505a88();
    
    foreach ( player in players )
    {
        function_ede2b0eab20aeb98( player );
        
        if ( !function_733680205629c9da( self, player ) )
        {
            continue;
        }
        
        data = damage_utility::packdamagedata( self, player, 1, objweapon, "MOD_EXPLOSIVE", self, self.origin );
        player thread popcandy_apply_player( data, function_c4e1118de7da4ded( player ) );
        obituary( player, self, objweapon, "MOD_UNKNOWN", [ self, player ] );
        thread utility::callsharedfunc( #"analytics", #"hash_c7076e2f7f3569a0", { #victim:player, #attacker:self, #grenade:objweapon } );
    }
    
    function_ec2518e8898e2e71( objweapon, 1 );
}

// Namespace pop_candy
// Params 1
// Checksum 0x24d143e3, Offset: 0xd5d
// Size: 0x10a
function function_d498ae1c937fab66( target )
{
    if ( !isdefined( self.var_a5475175d0240e61 ) )
    {
        self.var_a5475175d0240e61 = [];
    }
    
    entitynum = target getentitynumber();
    lifeindex = self.matchdatalifeindex ?? 0;
    
    if ( !isdefined( self.var_a5475175d0240e61[ entitynum ] ) || self.var_a5475175d0240e61[ entitynum ] > lifeindex )
    {
        self.var_a5475175d0240e61[ entitynum ] = lifeindex;
        
        if ( utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
        {
            self thread [[ utility::getsharedfunc( #"player", #"doScoreEvent" ) ]]( #"pop_candy_virus_player" );
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

// Namespace pop_candy
// Params 2
// Checksum 0x4c62d47a, Offset: 0xe6f
// Size: 0x1ee
function popcandy_apply_player( data, overridetime )
{
    data.victim notify( #"popcandy_apply_player" );
    data.victim endon( #"popcandy_apply_player" );
    data.victim endon( #"death_or_disconnect" );
    data.victim endon( #"pop_candy_virus_ended" );
    allowremoval = getdvarfloat( @"hash_ffb3f86c1ecd47d1", 0 );
    data.victim thread popcandy_applyvirus( data.attacker );
    data.attacker thread function_d498ae1c937fab66( data.victim );
    gamescore::trackdebuffassist( data.attacker, data.victim, data.objweapon.basename );
    data.victim function_83ca8f5e4526d408();
    
    if ( allowremoval )
    {
        data.victim childthread function_b5e54cac92022e5( data.attacker );
    }
    
    /#
        if ( getdvarint( @"scr_pop_candy_debug", 0 ) )
        {
            data.victim thread function_21dbcf66496ef918( data.attacker );
        }
    #/
    
    data.victim childthread function_36f6c85685b0397e();
    level thread battlechatter_mp::trysaylocalsound( data.attacker, #"bc_equipment_stuck_tracker" );
    msg = function_d9e749ceccee7ec7( data, overridetime );
    
    if ( isdefined( data.victim ) )
    {
        if ( player::isreallyalive( data.attacker ) )
        {
            gamescore::untrackdebuffassist( data.attacker, data.victim, data.objweapon.basename );
        }
    }
}

// Namespace pop_candy
// Params 2
// Checksum 0x9ff0ad7c, Offset: 0x1065
// Size: 0x75
function function_d9e749ceccee7ec7( data, overridetime )
{
    data.victim endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    time = getdvarfloat( @"scr_pop_candy_duration", 10 );
    
    if ( isdefined( overridetime ) )
    {
        time = overridetime;
    }
    
    msg = utility::waittill_notify_or_timeout_return( "pop_candy_cleared", time );
    return msg;
}

// Namespace pop_candy
// Params 1
// Checksum 0x941f1e78, Offset: 0x10e3
// Size: 0x29
function function_c4e1118de7da4ded( victim )
{
    defaulttime = getdvarfloat( @"scr_pop_candy_duration", 10 );
    return defaulttime;
}

// Namespace pop_candy
// Params 1
// Checksum 0x55aba319, Offset: 0x1115
// Size: 0xc3
function popcandy_applyvirus( attacker )
{
    self notify( #"popcandy_applyvirus" );
    self endon( #"popcandy_applyvirus" );
    self endon( #"disconnect" );
    
    if ( isdefined( self.var_28aa1e3338af6677 ) )
    {
        function_3a9f599c88edadb1( 5 );
    }
    
    self setscriptablepartstate( "pop_candy_state", "active" );
    self.var_28aa1e3338af6677 = attacker;
    self.var_772d31b1e5e3ae57 = gettime();
    level thread battlechatter_mp::trysaylocalsound( self, #"bc_equipment_stuck_tracker_self" );
    thread function_5effa0c04d386f55();
    msg = function_a2d4fb69740ce37e( attacker );
    reason = function_d481c91f3f44def3( msg );
    
    if ( isdefined( self.var_28aa1e3338af6677 ) )
    {
        function_3a9f599c88edadb1( reason );
    }
}

// Namespace pop_candy
// Params 0
// Checksum 0x1abd560f, Offset: 0x11e0
// Size: 0xfb
function function_36f6c85685b0397e()
{
    victimplayers = teams::getteamdata( self.team, "players" );
    var_1b8737767e4a0b81 = victimplayers;
    
    foreach ( player in victimplayers )
    {
        if ( !function_733680205629c9da( self, player ) || !isalive( player ) || player br_public::isplayerinorgoingtogulag() )
        {
            filteredplayers = arrayremove( var_1b8737767e4a0b81, player );
        }
    }
    
    victimplayer = utility::get_array_of_closest( self.origin, filteredplayers, undefined, 3 );
    level thread battlechatter_mp::trysaylocalsound( victimplayer, #"bc_equipment_stuck_tracker_hostile" );
}

// Namespace pop_candy
// Params 0
// Checksum 0x9cba59bf, Offset: 0x12e3
// Size: 0x35
function function_2474953d766a5a02()
{
    self endon( #"popcandy_apply_player" );
    self endon( #"death_or_disconnect" );
    self endon( #"pop_candy_virus_cleared" );
    self playsoundatviewheight( #"hash_e1352452c26377b2" );
}

// Namespace pop_candy
// Params 0
// Checksum 0x403a854b, Offset: 0x1320
// Size: 0x34
function function_5effa0c04d386f55()
{
    self endon( #"popcandy_apply_player" );
    self endon( #"death_or_disconnect" );
    self endon( #"pop_candy_virus_cleared" );
    thread function_da29cab503317d66();
    thread function_776b19367cb1b5bb();
}

// Namespace pop_candy
// Params 0
// Checksum 0xb9df620, Offset: 0x135c
// Size: 0x8b
function function_776b19367cb1b5bb()
{
    self endon( #"popcandy_apply_player" );
    self endon( #"death_or_disconnect" );
    self endon( #"pop_candy_virus_cleared" );
    
    while ( true )
    {
        self playlocalsound( #"hash_f5c170361a455859" );
        self playlocalsound( #"hash_d240d8065218778b" );
        emp_debuff::play_scramble( 2 );
        self earthquakeforplayer( 0.07, 1, self.origin, 2000 );
        wait 1;
        
        if ( emp_debuff::function_67d03d9afb12016d( 2 ) )
        {
            emp_debuff::stop_scramble( 2 );
        }
        
        wait 1.8;
    }
}

// Namespace pop_candy
// Params 0
// Checksum 0x4e074caf, Offset: 0x13ef
// Size: 0xaf
function function_da29cab503317d66()
{
    self endon( #"death_or_disconnect" );
    sfxloop = spawn( "script_origin", ( 0, 0, 0 ) );
    sfxloop showonlytoplayer( self );
    sfxloop linkto( self, "tag_origin", ( 0, 0, 50 ), ( 0, 0, 0 ) );
    sfxloop endon( #"death" );
    thread utility::delete_on_death( sfxloop );
    sfxloop playloopsound( #"hash_9e62a55800be3a47" );
    self waittill( "stop sound" + #"hash_9e62a55800be3a47" );
    sfxloop stoploopsound( #"hash_9e62a55800be3a47" );
    sfxloop delete();
}

// Namespace pop_candy
// Params 1
// Checksum 0xf9d5b020, Offset: 0x14a6
// Size: 0x1c5
function function_3a9f599c88edadb1( reason )
{
    if ( isdefined( self ) )
    {
        if ( isplayer( self ) )
        {
            function_86f5fccb34f60fe9( reason );
            
            if ( self.var_475b3adccf14b1f6 )
            {
                function_b9cc2ed4ed9be7df();
            }
            
            if ( isdefined( self getheldoffhand() ) && self getheldoffhand().basename == "t10_walkie_pop_candy_gesture_wz" )
            {
                self releaseoffhand();
            }
            
            thread utility::stop_loop_sound_on_entity( #"hash_9e62a55800be3a47" );
            self.popcandy_inrange = undefined;
            
            if ( isdefined( self.popcandy_objid ) )
            {
                objidpoolmanager::returnobjectiveid( self.popcandy_objid );
                objidpoolmanager::returnobjectiveid( self.var_e3cdc8fac28cc817 );
            }
            
            if ( isdefined( self.popcandy_hud ) )
            {
                self.popcandy_hud destroy();
            }
            
            if ( emp_debuff::function_67d03d9afb12016d( 2 ) )
            {
                emp_debuff::stop_scramble( 2 );
            }
            
            if ( isdefined( self.popcandy_virus ) )
            {
                level.var_656ae20c7105aaf8[ self.popcandy_virus getentitynumber() ] = undefined;
                self.popcandy_virus delete();
            }
            
            self.var_28aa1e3338af6677 = undefined;
            self.var_772d31b1e5e3ae57 = undefined;
            self.downedbypopcandy = undefined;
            self.var_64d6bcaa6fceffb = undefined;
            self.var_35f515a18a15eedb = undefined;
            self.var_475b3adccf14b1f6 = undefined;
            self.popcandy_objid = undefined;
            self.var_e3cdc8fac28cc817 = undefined;
            val::reset_all( "pop_candy_removal" );
            self.var_a2678850d4bd250a = gettime();
        }
        
        self playlocalsound( #"hash_cf0330b101033900" );
        self setscriptablepartstate( "pop_candy_state", "deactivated" );
        
        if ( reason == 2 )
        {
            level thread battlechatter_mp::trysaylocalsound( self, #"bc_equipment_stuck_tracker_removed" );
        }
        
        self notify( "stop sound" + #"hash_9e62a55800be3a47" );
        self notify( #"pop_candy_virus_cleared" );
    }
}

// Namespace pop_candy
// Params 1
// Checksum 0xed940b75, Offset: 0x1673
// Size: 0x2e
function function_b5e54cac92022e5( attacker )
{
    thread function_f88c605c64186b76();
    thread function_5e6b3bd38ee6fc28( attacker );
    function_57d1a6c2aa5619ee( attacker );
    thread function_69652ef37a4767ea( attacker );
}

// Namespace pop_candy
// Params 1
// Checksum 0x74cabaf0, Offset: 0x16a9
// Size: 0x55
function function_a2d4fb69740ce37e( attacker )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    childthread function_817ce3c3c95f1fe8();
    msg = utility::waittill_any_timeout( 10, "popCandy_victimDeath", "pop_candy_virus_ended_early", "pop_candy_virus_emp", "jammer_ping_hidden_started" );
    return msg;
}

// Namespace pop_candy
// Params 0
// Checksum 0xe840fceb, Offset: 0x1707
// Size: 0x1b
function function_817ce3c3c95f1fe8()
{
    self waittill( #"death" );
    self notify( #"popCandy_victimDeath" );
}

// Namespace pop_candy
// Params 0
// Checksum 0x5c018a5a, Offset: 0x172a
// Size: 0xa2
function function_83ca8f5e4526d408()
{
    if ( utility::issharedfuncdefined( #"game", #"requestobjectiveid" ) )
    {
        self.popcandy_objid = [[ utility::getsharedfunc( #"game", #"requestobjectiveid" ) ]]( 99 );
        self.var_e3cdc8fac28cc817 = [[ utility::getsharedfunc( #"game", #"requestobjectiveid" ) ]]( 99 );
        
        if ( getdvarint( @"hash_5cc63a8735deb30b", 0 ) )
        {
            function_a524a4547278290a( self.popcandy_objid, 0 );
        }
        
        function_a524a4547278290a( self.var_e3cdc8fac28cc817, 1 );
        thread function_ca63ba314f1fe013();
    }
}

// Namespace pop_candy
// Params 2
// Checksum 0xd61bdffd, Offset: 0x17d4
// Size: 0x133
function function_a524a4547278290a( objid, var_be871959ad0f20b4 )
{
    if ( !( isdefined( self ) && isdefined( objid ) ) || !objective_isvalid( objid ) )
    {
        return;
    }
    
    var_1cd2507cd336d3e3 = getdvarfloat( @"hash_48c8c5b7939e8836", 1500 ) + 200;
    objstate = var_be871959ad0f20b4 ? "active" : "current";
    icon = var_be871959ad0f20b4 ? "ui_mp_br_icon_pop_candy_virus" : "ui_mp_br_icon_pop_candy_virus";
    showdistance = var_be871959ad0f20b4 ? var_1cd2507cd336d3e3 : var_1cd2507cd336d3e3;
    objidpoolmanager::objective_add_objective( objid, objstate, self.origin, icon, "icon_large" );
    objidpoolmanager::objective_set_play_intro( objid, 0 );
    objidpoolmanager::objective_set_play_outro( objid, 0 );
    objective_settint( objid, 255, 25, 25 );
    objective_setbackground( objid, 1 );
    objective_setzoffset( objid, 85 );
    function_2b8e3d3ae2a6414a( objid, 1 );
    objective_setshowoncompass( objid, var_be871959ad0f20b4, 5 );
    objective_setshowdistance( objid, int( showdistance ) );
    objective_setfadedisabled( objid, 1 );
    objidpoolmanager::update_objective_onentity( objid, self );
    function_ac9886e0e2860e18( objid, var_1cd2507cd336d3e3 - 200, var_1cd2507cd336d3e3 );
    objidpoolmanager::objective_playermask_hidefromallplayers( objid );
}

// Namespace pop_candy
// Params 0
// Checksum 0xf4f1ea41, Offset: 0x190f
// Size: 0x2d2
function function_ca63ba314f1fe013()
{
    self endon( #"death_or_disconnect" );
    self endon( #"pop_candy_virus_cleared" );
    self endon( #"pop_candy_virus_ended" );
    level endon( #"game_ended" );
    var_1cd2507cd336d3e3 = getdvarfloat( @"hash_48c8c5b7939e8836", 1500 );
    playerstates = [];
    waittime = 1;
    
    while ( true )
    {
        if ( !( isdefined( self ) && isdefined( self.popcandy_objid ) ) )
        {
            break;
        }
        
        foreach ( player in level.players )
        {
            if ( player == self || !player_utility::playersareenemies( self, player ) )
            {
                continue;
            }
            
            playerguid = utility::callsharedfunc( #"player", #"getPlayerGuid", player );
            distance = distance2d( self.origin, player.origin );
            
            if ( distance <= var_1cd2507cd336d3e3 )
            {
                if ( !isdefined( playerstates[ playerguid ] ) )
                {
                    playerstates[ playerguid ] = { #inview:0, #inrange:0 };
                }
                
                waittime = distance < var_1cd2507cd336d3e3 ? distance < var_1cd2507cd336d3e3 * 0.3 ? 0.05 : distance < var_1cd2507cd336d3e3 * 0.7 ? 0.08 : 0.1 : ( distance < var_1cd2507cd336d3e3 * 2 ? 1 : distance < var_1cd2507cd336d3e3 * 4 ? 2 : 3 ) + randomfloat( 0.1 );
                
                if ( !playerstates[ playerguid ].inrange )
                {
                    objidpoolmanager::objective_playermask_addshowplayer( self.var_e3cdc8fac28cc817, player );
                    playerstates[ playerguid ].inrange = 1;
                }
                
                if ( player popcandy_cansee( self ) )
                {
                    if ( !playerstates[ playerguid ].inview )
                    {
                        objidpoolmanager::objective_playermask_addshowplayer( self.popcandy_objid, player );
                        playerstates[ playerguid ].inview = 1;
                    }
                }
                else if ( playerstates[ playerguid ].inview )
                {
                    objidpoolmanager::objective_playermask_hidefrom( self.popcandy_objid, player );
                    playerstates[ playerguid ].inview = 0;
                }
                
                continue;
            }
            
            if ( playerstates[ playerguid ] && playerstates[ playerguid ].inrange )
            {
                objidpoolmanager::objective_playermask_hidefrom( self.var_e3cdc8fac28cc817, player );
                playerstates[ playerguid ].inrange = 0;
            }
        }
        
        wait waittime;
    }
}

// Namespace pop_candy
// Params 1
// Checksum 0x2b45f9fc, Offset: 0x1be9
// Size: 0x86, Type: bool
function popcandy_cansee( var_28bf6e85dc304b8f )
{
    within_fov = utility::within_fov( self geteye(), self.angles, var_28bf6e85dc304b8f geteye(), cos( self playergetzoomfov() ) );
    
    if ( !within_fov )
    {
        return false;
    }
    
    trace = trace::ray_trace( self geteye(), var_28bf6e85dc304b8f geteye() );
    ray_trace_passed = trace[ "fraction" ] > 0.9 || trace[ "entity" ] === var_28bf6e85dc304b8f;
    return istrue( ray_trace_passed );
}

// Namespace pop_candy
// Params 0
// Checksum 0xdd63fdd0, Offset: 0x1c78
// Size: 0x86
function function_a5d4f6cdab01d70b()
{
    if ( isdefined( self.super ) && isdefined( self.super.hitcount ) )
    {
        challenges::function_a0936b0e5b4550f3( "equip_pop_candy", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"end" ), self.super.hitcount );
        self.super.hitcount = undefined;
    }
    
    self.var_a5475175d0240e61 = undefined;
    self notify( #"pop_candy_virus_ended" );
}

// Namespace pop_candy
// Params 0
// Checksum 0xc23986d, Offset: 0x1d06
// Size: 0x8b
function function_f88c605c64186b76()
{
    self endon( #"death_or_disconnect" );
    self endon( #"pop_candy_virus_cleared" );
    self endon( #"pop_candy_virus_ended" );
    level endon( #"game_ended" );
    
    if ( !isdefined( self ) || !player::isreallyalive( self ) )
    {
        return;
    }
    
    hinttime = getdvarfloat( @"scr_pop_candy_duration", 10 );
    
    if ( self usinggamepad() )
    {
        thread function_742b6da0743c06eb( &"wz_functionals/pop_candy_hold" );
        return;
    }
    
    thread function_742b6da0743c06eb( &"wz_functionals/pop_candy_hold_kb" );
}

// Namespace pop_candy
// Params 1
// Checksum 0xae3874e2, Offset: 0x1d99
// Size: 0xb6
function function_5e6b3bd38ee6fc28( attacker )
{
    self endon( #"death_or_disconnect" );
    self endon( #"pop_candy_virus_cleared" );
    self endon( #"pop_candy_virus_ended" );
    level endon( #"game_ended" );
    self waittill( #"hash_c07161338c7356e7", saviorplayer, weapon );
    
    if ( isplayer( saviorplayer ) && utility::issharedfuncdefined( #"player", #"doScoreEvent" ) )
    {
        saviorplayer thread utility::callsharedfunc( #"player", #"doScoreEvent", #"destroyed_equipment", weapon );
    }
    
    self notify( #"pop_candy_virus_emp" );
}

// Namespace pop_candy
// Params 1
// Checksum 0xf766d0da, Offset: 0x1e57
// Size: 0x244
function function_69652ef37a4767ea( attacker )
{
    self endon( #"death_or_disconnect" );
    self endon( #"pop_candy_virus_cleared" );
    self endon( #"pop_candy_virus_ended_early" );
    level endon( #"game_ended" );
    self.var_35f515a18a15eedb = 0;
    self.var_475b3adccf14b1f6 = 0;
    holdtime = getdvarfloat( @"hash_7c7b1526bb05c131", 3 );
    duration = getdvarfloat( @"scr_pop_candy_duration", 10 );
    speedscale = getdvarfloat( @"hash_5abceda4251bf9c8", 0.6 );
    
    /#
        if ( getdvarint( @"scr_pop_candy_debug", 0 ) && isai( self ) )
        {
            thread function_1a47dce94e38c345( holdtime, duration );
            return;
        }
    #/
    
    while ( self.var_35f515a18a15eedb < holdtime + 0.35 )
    {
        buttonpressed = self activatekeypressed();
        
        if ( buttonpressed )
        {
            if ( self.var_35f515a18a15eedb >= 0.35 && !self.var_475b3adccf14b1f6 )
            {
                self giveandfireoffhand( makeweapon( "t10_walkie_pop_candy_gesture_wz" ) );
                
                if ( function_ed1c36b6501afd9c() )
                {
                    function_b9cc2ed4ed9be7df();
                    self.var_475b3adccf14b1f6 = 1;
                    self.var_64d6bcaa6fceffb = 1;
                    self setclientomnvar( "ui_securing", 29 );
                    self notify( #"hash_4631059a85a2a652" );
                    self setscriptablepartstate( "pop_candy_state", "removal" );
                    val::set_array( "pop_candy_removal", [ "usability" ], 0 );
                    val::set( "pop_candy_removal", "move_speed_scale", speedscale );
                }
            }
            
            if ( self.var_475b3adccf14b1f6 )
            {
                if ( !function_ed1c36b6501afd9c() || function_ed1c36b6501afd9c() && self function_7d9f109338409783() )
                {
                    function_a67c2ce48c75d52b();
                }
                else
                {
                    progresspercentage = min( ( self.var_35f515a18a15eedb - 0.35 ) / holdtime, 1 );
                    self setclientomnvar( "ui_securing_progress", progresspercentage );
                }
            }
            
            self.var_35f515a18a15eedb += level.framedurationseconds;
        }
        else if ( !buttonpressed && self.var_475b3adccf14b1f6 )
        {
            function_a67c2ce48c75d52b();
        }
        
        waitframe();
    }
    
    self notify( #"pop_candy_virus_ended_early" );
}

// Namespace pop_candy
// Params 1
// Checksum 0x7dabcc70, Offset: 0x20a3
// Size: 0x114
function function_57d1a6c2aa5619ee( attacker )
{
    origin = self.origin + anglestoforward( self.angles ) * 10;
    self.popcandy_virus = spawn( "script_origin", origin );
    self.popcandy_virus linkto( self );
    self.popcandy_virus.trackedplayer = self;
    self.popcandy_virus.owner = attacker;
    self.popcandy_virus.team = attacker.team;
    
    if ( !isdefined( level.trackers ) )
    {
        level.var_656ae20c7105aaf8 = [];
    }
    
    level.var_656ae20c7105aaf8[ self.popcandy_virus getentitynumber() ] = self.popcandy_virus;
    self.popcandy_virus emp_debuff::set_apply_emp_callback( &popcandy_empapplied );
    self.popcandy_virus utility::callsharedfunc( #"emp", #"setemp_applied_callback", &popcandy_empapplied );
}

// Namespace pop_candy
// Params 1
// Checksum 0x2fe41c22, Offset: 0x21bf
// Size: 0x36
function popcandy_empapplied( data )
{
    self.trackedplayer notify( #"hash_c07161338c7356e7", data.attacker, data.objweapon );
}

// Namespace pop_candy
// Params 0
// Checksum 0x24a57e04, Offset: 0x21fd
// Size: 0x1a
function function_b9cc2ed4ed9be7df()
{
    self setclientomnvar( "ui_securing", 0 );
    self setclientomnvar( "ui_securing_progress", 0 );
}

// Namespace pop_candy
// Params 2
// Checksum 0x507a8f64, Offset: 0x221f
// Size: 0x85
function function_742b6da0743c06eb( text, time )
{
    self notify( #"hash_421b0334495ca7af" );
    self endon( #"hash_421b0334495ca7af" );
    self.popcandy_hud = hud_util::createfontstring( "default", 1 );
    self.popcandy_hud hud_util::setpoint( "CENTER", undefined, 0, -90 );
    self.popcandy_hud settext( text );
    self.popcandy_hud.scramblerdisabled = 1;
}

// Namespace pop_candy
// Params 0, eflags: 0x4
// Checksum 0xfbf7fe0c, Offset: 0x22ac
// Size: 0x57
function private function_a67c2ce48c75d52b()
{
    self.var_475b3adccf14b1f6 = 0;
    self.var_35f515a18a15eedb = 0;
    function_b9cc2ed4ed9be7df();
    self notify( #"hash_fba5e0aba00ae29e" );
    self setscriptablepartstate( "pop_candy_state", "active" );
    val::reset_all( "pop_candy_removal" );
    
    if ( function_ed1c36b6501afd9c() )
    {
        self releaseoffhand();
    }
    
    wait 1;
}

// Namespace pop_candy
// Params 1, eflags: 0x4
// Checksum 0x5c4ed395, Offset: 0x230b
// Size: 0x8d
function private function_d481c91f3f44def3( msg )
{
    reason = -1;
    
    if ( !isdefined( msg ) )
    {
        return -1;
    }
    
    switch ( msg )
    {
        case #"hash_d4dde12b38318c68":
            reason = 0;
            break;
        case #"hash_1be935e75103bbe8":
            reason = 0;
            break;
        case #"hash_d48c1f9eceb23eaf":
            reason = 2;
            break;
        case #"hash_a59d9599a7329fe1":
            reason = 3;
            break;
        case #"hash_4404ec5fa0a6ef01":
            reason = 4;
            break;
    }
    
    return reason;
}

// Namespace pop_candy
// Params 0, eflags: 0x4
// Checksum 0xfa118ebe, Offset: 0x23a1
// Size: 0x136
function private function_c272a44d64505a88()
{
    maxoperators = getdvarint( @"hash_1c125ba60e650e3", 3 );
    radius = getdvarfloat( @"scr_pop_candy_radius", 1500 );
    height = getdvarfloat( @"scr_pop_candy_height", 4000 );
    players = getplayersinradius( self.origin, radius, height, undefined, teams::getteamdata( self.team, "players" ) );
    filteredplayers = players;
    
    foreach ( player in players )
    {
        if ( !function_733680205629c9da( self, player ) )
        {
            filteredplayers = arrayremove( filteredplayers, player );
        }
    }
    
    players = filteredplayers;
    
    if ( maxoperators > 0 && players.size > maxoperators )
    {
        players = utility::get_array_of_closest( self.origin, players, undefined, maxoperators );
    }
    
    return players;
}

// Namespace pop_candy
// Params 1, eflags: 0x4
// Checksum 0x64989bad, Offset: 0x24e0
// Size: 0xd4
function private function_6757db0d4993912e( players )
{
    trackedteams = [];
    selectedplayers = [];
    
    foreach ( player in players )
    {
        teamid = player.team;
        
        if ( isdefined( trackedteams[ teamid ] ) )
        {
            continue;
        }
        
        chosenplayer = function_9ce5f65c34a2639b( teamid, player );
        
        if ( isdefined( chosenplayer ) )
        {
            selectedplayers[ selectedplayers.size ] = chosenplayer;
            trackedteams[ teamid ] = 1;
        }
    }
    
    return selectedplayers;
}

// Namespace pop_candy
// Params 2, eflags: 0x4
// Checksum 0x206ed94c, Offset: 0x25bd
// Size: 0x48
function private function_9ce5f65c34a2639b( teamid, player )
{
    team = teams::function_d032b36d01bbbab3( teamid, player.sessionsquadid );
    chosenplayer = utility::array_random( team );
    return chosenplayer;
}

// Namespace pop_candy
// Params 1, eflags: 0x4
// Checksum 0x7de4d35b, Offset: 0x260e
// Size: 0xb6
function private function_86f5fccb34f60fe9( reason )
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    secondsaffected = isdefined( self.var_772d31b1e5e3ae57 ) ? int( ( gettime() - self.var_772d31b1e5e3ae57 ) / 1000 ) : 0;
    downedbypopcandy = istrue( self.downedbypopcandy );
    attemptedremoval = istrue( self.var_64d6bcaa6fceffb );
    self dlog_recordplayerevent( "dlog_event_pop_candy_end", [ "seconds_affected", secondsaffected, "removal_reason", reason, "downed_by_pop_candy", downedbypopcandy, "attempted_removal", attemptedremoval ] );
}

// Namespace pop_candy
// Params 0, eflags: 0x4
// Checksum 0xb0ac9605, Offset: 0x26cc
// Size: 0x2b, Type: bool
function private function_ed1c36b6501afd9c()
{
    currentoffhand = self getheldoffhand();
    return isdefined( currentoffhand ) && currentoffhand.basename == "t10_walkie_pop_candy_gesture_wz";
}

// Namespace pop_candy
// Params 1, eflags: 0x4
// Checksum 0x92242d3a, Offset: 0x2700
// Size: 0x33
function private function_ede2b0eab20aeb98( player )
{
    if ( self == player )
    {
        return;
    }
    
    if ( player_utility::playersareenemies( self, player ) )
    {
        level thread battlechatter_mp::trysaylocalsound( player, #"bc_fieldupgrade_incoming_pop_candy" );
    }
}

// Namespace pop_candy
// Params 1, eflags: 0x4
// Checksum 0xea1fe04f, Offset: 0x273b
// Size: 0xa3
function private function_ca3a49b985b3f353( data )
{
    attacker = data.attacker;
    victim = data.victim;
    
    if ( !isdefined( victim.var_28aa1e3338af6677 ) || !player_utility::playersareenemies( attacker, victim ) )
    {
        return;
    }
    
    weaponobj = level.pop_candy_data.objweapon ?? makeweapon( function_ef6d520550bbc418() );
    attacker thread gamelogic_mp::threadedsetweaponstatbyname( weaponobj, 1, "buff_kills" );
    victim thread gamelogic_mp::threadedsetweaponstatbyname( weaponobj, 1, "killed_while_debuffed_by" );
}

// Namespace pop_candy
// Params 1
// Checksum 0x49ebf015, Offset: 0x27e6
// Size: 0x6b
function function_f7054d0660eed0d9( data )
{
    attacker = data.attacker;
    victim = data.victim;
    
    if ( !( isdefined( victim ) && isdefined( victim.var_28aa1e3338af6677 ) ) || !player_utility::playersareenemies( attacker, victim ) )
    {
        return;
    }
    
    victim.downedbypopcandy = 1;
}

// Namespace pop_candy
// Params 0, eflags: 0x4
// Checksum 0x389b739b, Offset: 0x2859
// Size: 0x1d, Type: bool
function private function_ef6d520550bbc418()
{
    return level.pop_candy_data.useweapon ?? "sat_pop_candy_wz";
}

/#

    // Namespace pop_candy
    // Params 1
    // Checksum 0xb129308, Offset: 0x287f
    // Size: 0x1e3, Type: dev
    function function_21dbcf66496ef918( attacker )
    {
        self endon( #"death_or_disconnect" );
        self endon( #"pop_candy_virus_cleared" );
        self endon( #"pop_candy_virus_ended" );
        level endon( #"game_ended" );
        starttime = gettime();
        duration = getdvarfloat( @"scr_pop_candy_duration", 10 );
        
        while ( true )
        {
            var_1cd2507cd336d3e3 = getdvarfloat( @"hash_48c8c5b7939e8836", 1500 );
            color = ( 1, 0, 0 );
            secondselapsed = ( gettime() - starttime ) / 1000;
            
            if ( attacker popcandy_cansee( self ) )
            {
                color = ( 0, 1, 0 );
            }
            
            thread debug::drawsphere( self geteye() + ( 0, 0, 20 ), 8, 0.05, color );
            print3d( self geteye() + ( 0, 0, 30 ), duration - secondselapsed, color, 1, 1, 1, 1 );
            cylinder( self.origin, self.origin + ( 0, 0, 2 ), var_1cd2507cd336d3e3, color, 1, 1 );
            thread debug::drawline( self.origin, self.origin - ( var_1cd2507cd336d3e3, 0, 0 ), 0.05, color );
            thread debug::drawline( self.origin, self.origin + ( var_1cd2507cd336d3e3, 0, 0 ), 0.05, color );
            thread debug::drawline( self.origin, self.origin - ( 0, var_1cd2507cd336d3e3, 0 ), 0.05, color );
            thread debug::drawline( self.origin, self.origin + ( 0, var_1cd2507cd336d3e3, 0 ), 0.05, color );
            wait 0.05;
        }
    }

    // Namespace pop_candy
    // Params 0
    // Checksum 0x39238ac1, Offset: 0x2a6a
    // Size: 0x8b, Type: dev
    function function_d2aa0f0a39eef36()
    {
        self endon( #"death_or_disconnect" );
        self endon( #"pop_candy_virus_cleared" );
        self endon( #"pop_candy_virus_ended" );
        radius = getdvarfloat( @"scr_pop_candy_radius", 1500 );
        
        while ( true )
        {
            cylinder( self.origin, self.origin + ( 0, 0, 2 ), radius, ( 0, 0, 1 ), 1, 1 );
            wait 0.05;
        }
    }

    // Namespace pop_candy
    // Params 2
    // Checksum 0xa30223a, Offset: 0x2afd
    // Size: 0x86, Type: dev
    function function_1a47dce94e38c345( holdtime, duration )
    {
        self endon( #"death_or_disconnect" );
        self endon( #"pop_candy_virus_cleared" );
        self endon( #"pop_candy_virus_ended_early" );
        wait randomfloatrange( 1, duration - holdtime );
        self.var_475b3adccf14b1f6 = 1;
        self giveandfireoffhand( makeweapon( "<dev string:x24>" ) );
        self setscriptablepartstate( "<dev string:x44>", "<dev string:x54>" );
        wait holdtime;
        self releaseoffhand();
        self notify( #"pop_candy_virus_ended_early" );
    }

#/
