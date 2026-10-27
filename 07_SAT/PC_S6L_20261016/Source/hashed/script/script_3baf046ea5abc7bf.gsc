// script_3baf046ea5abc7bf  (hash_3baf046ea5abc7bf.gscc) (size: 4685 Bytes / 0x124d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3d45e8a1 (1027991713)
// size ...... 4685 (0x124d)
// includes .. 8   (offset: 0x1161)
// strings ... 11  (offset: 0x11a1)
// dev strs .. 1   (offset: 0x1241)
// exports ... 12  (offset: 0xb59)
// cseg ...... 0x16d + 0x9ec (0xb59)
// imports ... 36  (offset: 0xd39)
// animtree1 . 0   (offset: 0x124d)
// animtree2 . 0   (offset: 0x124d)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\snapshot;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\entityheadicons;

#namespace specialty_combat_scout;

// Namespace specialty_combat_scout
// Params 0, eflags: 0x5
// Checksum 0xc4d4e0c5, Offset: 0x18b
// Size: 0x18
function private autoexec preinit()
{
    level callback::add( #"register_perk", &registercombatscout );
}

// Namespace specialty_combat_scout
// Params 1, eflags: 0x4
// Checksum 0xa890d72, Offset: 0x1ab
// Size: 0x3f
function private registercombatscout( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_combat_scout", &setcombatscout, &unsetcombatscout, [], &initcombatscout );
    }
}

// Namespace specialty_combat_scout
// Params 0, eflags: 0x4
// Checksum 0x29cd149a, Offset: 0x1f2
// Size: 0x17
function private initcombatscout()
{
    callback::add( #"player_damaged", &function_9645edf92ca4843b );
}

// Namespace specialty_combat_scout
// Params 0, eflags: 0x4
// Checksum 0x12652b39, Offset: 0x211
// Size: 0x14
function private setcombatscout()
{
    self.var_ac5525151377528 = self.var_9842326056fd7207;
}

// Namespace specialty_combat_scout
// Params 0, eflags: 0x4
// Checksum 0xff18a04d, Offset: 0x22d
// Size: 0xc
function private unsetcombatscout()
{
    self.var_ac5525151377528 = undefined;
}

// Namespace specialty_combat_scout
// Params 1, eflags: 0x4
// Checksum 0x2e98c039, Offset: 0x241
// Size: 0xc2
function private function_9645edf92ca4843b( params )
{
    if ( !params.bisbulletdamage )
    {
        return;
    }
    
    victim = params.victim;
    eattacker = params.eattacker;
    
    if ( !isplayer( victim ) || !isplayer( eattacker ) )
    {
        return;
    }
    
    if ( isdefined( eattacker.perks[ "specialty_combat_scout" ] ) )
    {
        attackerdamage = params.idamage > 0 || params.lightarmordamage > 0 || params.heavyarmordamage > 0;
        victim thread combatscout_think( eattacker, attackerdamage, params.objweapon );
    }
}

// Namespace specialty_combat_scout
// Params 3
// Checksum 0x6671a7e8, Offset: 0x30b
// Size: 0x282
function combatscout_think( attacker, attackerdamage, attackerweapon )
{
    victim = self;
    
    if ( !attackerdamage )
    {
        return;
    }
    
    if ( ![[ utility::getsharedfunc( #"player", #"isreallyalive" ) ]]( victim ) )
    {
        return;
    }
    
    if ( victim br_public::isplayeringulag() )
    {
        return;
    }
    
    attackerteam = namespace_9d8e359c3b1041e5::getteamdatasharedfunc( attacker.team, "alivePlayers" );
    
    if ( !isdefined( attackerteam ) )
    {
        return;
    }
    
    if ( isdefined( victim.perks[ "specialty_outline_immunity" ] ) )
    {
        attacker thread combatscout_counter( 2 );
        return;
    }
    
    if ( !isdefined( attacker.var_b82dbf93c67c499b ) )
    {
        attacker.var_b82dbf93c67c499b = 0;
    }
    
    if ( attacker.combatscouttarget == victim )
    {
        return;
    }
    
    if ( isdefined( attacker.combatscouttarget ) && attacker.var_b82dbf93c67c499b <= getdvarint( @"hash_af7d311711d8db9c", 5 ) )
    {
        attacker notify( #"combatScout_targetSwitch" );
        attacker.combatscouttarget = victim;
        attacker combatscout_apply( victim );
        
        if ( isdefined( attacker.perks[ "specialty_combat_tracker" ] ) )
        {
            attacker namespace_9d8e359c3b1041e5::activateperksharedfunc( "specialty_combat_tracker" );
        }
        
        currenttime = gettime();
        
        if ( !isdefined( attacker.var_e906aba59643cfbc ) || currenttime > attacker.var_e906aba59643cfbc + 1500 )
        {
            attacker playlocalsound( "recon_drone_marked_owner" );
            attacker.var_e906aba59643cfbc = gettime();
        }
        
        return;
    }
    
    if ( attacker.var_b82dbf93c67c499b <= getdvarint( @"hash_af7d311711d8db9c", 5 ) )
    {
        foreach ( player in attackerteam )
        {
            if ( player == attacker )
            {
                continue;
            }
            
            if ( player.combatscouttarget == victim )
            {
                return;
            }
        }
        
        attacker.combatscouttarget = victim;
        attacker combatscout_apply( victim );
        
        if ( isdefined( attacker.perks[ "specialty_combat_tracker" ] ) )
        {
            attacker namespace_9d8e359c3b1041e5::activateperksharedfunc( "specialty_combat_tracker" );
        }
    }
}

// Namespace specialty_combat_scout
// Params 3, eflags: 0x4
// Checksum 0xb5f2bd8e, Offset: 0x595
// Size: 0x11b
function private combatscout_apply( victim, marktype, perkbundle )
{
    attacker = self;
    
    if ( isdefined( self.var_ac5525151377528 ) )
    {
        perkbundle = self.var_ac5525151377528;
    }
    else
    {
        perkbundle = level.perkbundles[ "specialty_combat_tracker" ];
    }
    
    checks = function_145e3bdcdffb023( attacker.origin, victim.origin, perkbundle );
    pingtime = checks[ 0 ];
    var_47e2be2a86febe11 = checks[ 1 ];
    currenttime = gettime();
    
    if ( !isdefined( victim.var_1df751ef4d218e4f ) || currenttime > victim.var_1df751ef4d218e4f + 1500 )
    {
        victim snapshot::function_c802f1ac50040a2c();
        victim playlocalsound( "recon_drone_spotted_plr" );
        victim.var_1df751ef4d218e4f = gettime();
    }
    
    victim.var_96ea52dc3dbcbb6e[ attacker.team ] = currenttime;
    victim thread function_67d99b441f000de2( attacker, perkbundle, pingtime, var_47e2be2a86febe11 );
}

// Namespace specialty_combat_scout
// Params 3, eflags: 0x4
// Checksum 0x5b621147, Offset: 0x6b8
// Size: 0x1ee
function private function_145e3bdcdffb023( attackerloc, victimloc, perkbundle )
{
    pingtime = perkbundle.combatscout_duration;
    var_47e2be2a86febe11 = pingtime * 1000;
    dist = distance2d( attackerloc, victimloc );
    
    if ( dist >= 0 && dist <= ( perkbundle.var_794e40de62d0185d ?? 2000 ) )
    {
        marktype = 1;
    }
    else if ( dist > ( perkbundle.var_794e40de62d0185d ?? 2000 ) && dist <= ( perkbundle.var_794e3dde62d011c4 ?? 4000 ) )
    {
        marktype = 2;
    }
    else if ( dist > ( perkbundle.var_794e40de62d0185d ?? 4000 ) )
    {
        marktype = 3;
    }
    
    if ( isdefined( marktype ) )
    {
        returnarr = [];
        
        switch ( marktype )
        {
            case 3:
                pingtime = int( pingtime * ( perkbundle.var_e4db1a6e646cb5b7 ?? 1.6 ) );
                var_47e2be2a86febe11 = int( var_47e2be2a86febe11 * ( perkbundle.var_e4db1a6e646cb5b7 ?? 1.6 ) );
                break;
            case 2:
                pingtime = int( pingtime * ( perkbundle.var_a136ef8df81db571 ?? 1 ) );
                var_47e2be2a86febe11 = int( var_47e2be2a86febe11 * ( perkbundle.var_a136ef8df81db571 ?? 1 ) );
                break;
            case 1:
            default:
                pingtime = int( pingtime * ( perkbundle.var_fe8cff37c71baca5 ?? 0.75 ) );
                var_47e2be2a86febe11 = int( var_47e2be2a86febe11 * ( perkbundle.var_fe8cff37c71baca5 ?? 0.75 ) );
                break;
        }
        
        returnarr[ 0 ] = pingtime;
        returnarr[ 1 ] = var_47e2be2a86febe11;
        return returnarr;
    }
    
    assert( "<dev string:x24>" );
}

// Namespace specialty_combat_scout
// Params 1, eflags: 0x4
// Checksum 0xf0d97346, Offset: 0x8ae
// Size: 0x86
function private combatscout_counter( time )
{
    attacker = self;
    level endon( #"game_ended" );
    attacker endon( #"disconnect" );
    
    if ( isdefined( attacker.var_ed92b61b0a8017a ) )
    {
        return;
    }
    
    if ( !isdefined( time ) )
    {
        time = 1;
    }
    
    attacker.var_ed92b61b0a8017a = 1;
    attacker iprintlnbold( &"killstreaks_hints/recon_no_mark" );
    self playlocalsound( "uin_jup_br_perk_combat_scout_marking_resist", self );
    wait time;
    attacker.var_ed92b61b0a8017a = undefined;
}

// Namespace specialty_combat_scout
// Params 4, eflags: 0x4
// Checksum 0x5e0a4e24, Offset: 0x93c
// Size: 0x21d
function private function_67d99b441f000de2( attacker, perkbundle, waittime, waittimemilliseconds )
{
    victim = self;
    level endon( #"game_ended" );
    attacker.var_b82dbf93c67c499b++;
    
    if ( perkbundle.combatscout_enable_headicon )
    {
        icon = victim entityheadicons::setheadicon_singleimage( attacker.team, "hud_icon_new_marked", 8, 1, 5000, 500, undefined, 1, 1 );
    }
    
    if ( perkbundle.combatscout_enable_outline )
    {
        if ( !isdefined( victim.var_e273e63c335a388f ) )
        {
            if ( squad_utility::shouldmodesetsquads() )
            {
                victim.var_e273e63c335a388f = outline::outlineenableforsquad( victim, attacker.team, attacker.sessionsquadid, perkbundle.var_b50bb7426670707f, "perk_lesser" );
            }
            else
            {
                victim.var_e273e63c335a388f = outline::outlineenableforteam( victim, attacker.team, perkbundle.var_b50bb7426670707f, "perk_lesser" );
            }
        }
    }
    
    if ( perkbundle.var_7d9f8d5029cbae32 )
    {
        triggerportableradarpingteam( victim.origin, attacker.team, 40, waittimemilliseconds );
    }
    
    if ( ( perkbundle.var_7a90f9b2eeda0d63 ?? getdvarint( @"hash_b88b8687aadb27bd", 0 ) ) == 1 )
    {
        utility::waittill_any_ents_or_timeout_return( waittime, victim, "death", attacker, "combatScout_targetSwitch" );
    }
    else
    {
        utility::waittill_any_ents_or_timeout_return( waittime, victim, "death" );
    }
    
    if ( perkbundle.combatscout_enable_headicon )
    {
        entityheadicons::setheadicon_deleteicon( icon );
    }
    
    if ( perkbundle.combatscout_enable_outline )
    {
        if ( isdefined( victim.var_e273e63c335a388f ) )
        {
            outline::outlinedisable( victim.var_e273e63c335a388f, victim );
            victim.var_e273e63c335a388f = undefined;
        }
    }
    
    if ( isdefined( attacker ) && victim == attacker.combatscouttarget )
    {
        attacker.combatscouttarget = undefined;
    }
    
    if ( isdefined( attacker ) )
    {
        attacker.var_b82dbf93c67c499b--;
    }
}

