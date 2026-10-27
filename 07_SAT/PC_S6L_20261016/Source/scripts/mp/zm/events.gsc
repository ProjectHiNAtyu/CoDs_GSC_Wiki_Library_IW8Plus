// scripts\mp\zm\events.gsc  (hash_37d8b0e4df36cd3f.gscc) (size: 12401 Bytes / 0x3071 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x212da59d (556639645)
// size ...... 12401 (0x3071)
// includes .. 8   (offset: 0x2c29)
// strings ... 65  (offset: 0x2c69)
// dev strs .. 4   (offset: 0x3041)
// exports ... 16  (offset: 0x21f9)
// cseg ...... 0x48f + 0x1d6a (0x21f9)
// imports ... 52  (offset: 0x2479)
// animtree1 . 0   (offset: 0x3071)
// animtree2 . 0   (offset: 0x3071)
#using scripts\common\callbacks;
#using scripts\common\status_effects\status_effects;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\stats;
#using scripts\mp\rank;
#using scripts\mp\zm\points;

#namespace events;

// Namespace events
// Params 0
// Checksum 0x69dbe1e7, Offset: 0x4ad
// Size: 0x137
function init()
{
    level.var_77a4f74d2e0f92b9 = int( tablelookupbyrow( "zm/scoreinfo/perroundxp.csv", 0, 0 ) ) ?? 0;
    level.var_536e537c16b0dbe3 = int( tablelookupbyrow( "zm/scoreinfo/perroundxp.csv", 0, 1 ) ) ?? 375;
    level.operator_xp_scalar = int( tablelookupbyrow( "zm/scoreinfo/perroundxp.csv", 0, 2 ) ) ?? 1;
    level.var_b944b5394f202d3e = [];
    level.var_b944b5394f202d3e[ "default" ] = 0;
    level.var_bd91396632e13224 = 1;
    
    if ( getdvarint( @"hash_827c38f8b953c541", 0 ) == 1 )
    {
        level.var_110f2535c830f34d = &get_custom_weapon_xp;
    }
    
    level thread onplayerconnect();
    level.var_2365b76f19ea37ea = &function_92b70ecfc2f8e086;
    level callback::add( #"on_ai_killed", &zm_event_on_ai_killed );
    level callback::add( "zombie_score_event", &zm_score_event );
    level callback::add( "on_round_start", &on_round_start );
    level callback::add( "on_round_end", &on_round_end );
    level callback::add( "zm_exfil_success", &on_player_exfil_success );
    level callback::add( "on_ai_acquire_attractor", &on_ai_acquire_attractor );
    function_52ee8d0788e2dfcb( "default", 1 );
}

// Namespace events
// Params 1
// Checksum 0x35f89759, Offset: 0x5ec
// Size: 0x3e
function on_round_start( params )
{
    var_c34f5bcaf57ca322 = level.var_6781718da4f78d1c.roundnumber ?? 1;
    function_52ee8d0788e2dfcb( "default", var_c34f5bcaf57ca322 );
}

// Namespace events
// Params 1
// Checksum 0x4c36d933, Offset: 0x632
// Size: 0x16f
function on_round_end( params )
{
    var_c34f5bcaf57ca322 = level.var_6781718da4f78d1c.roundnumber ?? 1;
    
    if ( !isdefined( level.highestroundreached ) )
    {
        level.highestroundreached = 0;
    }
    
    if ( var_c34f5bcaf57ca322 > level.highestroundreached )
    {
        level.highestroundreached = var_c34f5bcaf57ca322;
    }
    else
    {
        return;
    }
    
    if ( var_c34f5bcaf57ca322 % 5 == 0 )
    {
        foreach ( player in level.players )
        {
            if ( !isplayer( player ) )
            {
                continue;
            }
            
            if ( var_c34f5bcaf57ca322 > 20 )
            {
                player points::zm_do_score_event( #"hash_a6b665a4cef7cada" );
                continue;
            }
            
            if ( var_c34f5bcaf57ca322 > 15 )
            {
                player points::zm_do_score_event( #"hash_5475b90e9ac026d9" );
                continue;
            }
            
            if ( var_c34f5bcaf57ca322 > 10 )
            {
                player points::zm_do_score_event( #"hash_54793c0e9ac33b49" );
                continue;
            }
            
            if ( var_c34f5bcaf57ca322 > 5 )
            {
                player points::zm_do_score_event( #"hash_54793f0e9ac34062" );
                continue;
            }
            
            player points::zm_do_score_event( #"hash_edae8208dc74fff2" );
        }
    }
}

// Namespace events
// Params 1
// Checksum 0xa478c275, Offset: 0x7a9
// Size: 0x136
function on_player_exfil_success( params )
{
    var_c34f5bcaf57ca322 = level.var_6781718da4f78d1c.roundnumber ?? 1;
    a_exfil_players = params.a_exfil_players ?? level.players;
    
    foreach ( player in a_exfil_players )
    {
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( var_c34f5bcaf57ca322 > 20 )
        {
            player points::zm_do_score_event( #"hash_192c314ff5fda9fe" );
            continue;
        }
        
        if ( var_c34f5bcaf57ca322 == 20 )
        {
            player points::zm_do_score_event( #"hash_188ab6b725d38f25" );
            continue;
        }
        
        if ( var_c34f5bcaf57ca322 >= 15 )
        {
            player points::zm_do_score_event( #"hash_188e41b725d6b12d" );
            continue;
        }
        
        if ( var_c34f5bcaf57ca322 >= 10 )
        {
            player points::zm_do_score_event( #"hash_188e3cb725d6a8ae" );
        }
    }
}

// Namespace events
// Params 1
// Checksum 0x40a07a70, Offset: 0x8e7
// Size: 0x7a
function on_ai_acquire_attractor( params )
{
    if ( params.target_attractor.var_9bc09bc79f28a18e && isplayer( params.target_attractor.source.owner ) )
    {
        params.target_attractor.source.owner points::zm_do_score_event( #"distracted" );
    }
}

// Namespace events
// Params 2
// Checksum 0x72ae3a4f, Offset: 0x969
// Size: 0x31c
function function_52ee8d0788e2dfcb( objective, round )
{
    if ( round > level.var_77a4f74d2e0f92b9 )
    {
        round = level.var_77a4f74d2e0f92b9;
    }
    
    row = level.var_b944b5394f202d3e[ objective ] * level.var_77a4f74d2e0f92b9 + round;
    parameters = spawnstruct();
    parameters.objective = tablelookupbyrow( "zm/scoreinfo/perroundxp.csv", row, 0 );
    parameters.round = tablelookupbyrow( "zm/scoreinfo/perroundxp.csv", row, 1 );
    
    if ( parameters.objective == objective && int( parameters.round ) == round )
    {
        var_cda8327f0b3e6cbf = float( tablelookupbyrow( "zm/scoreinfo/perroundxp.csv", row, 2 ) );
        var_cda8337f0b3e6ef2 = float( tablelookupbyrow( "zm/scoreinfo/perroundxp.csv", row, 3 ) );
        var_cda8347f0b3e7125 = float( tablelookupbyrow( "zm/scoreinfo/perroundxp.csv", row, 4 ) );
        var_cda82d7f0b3e61c0 = float( tablelookupbyrow( "zm/scoreinfo/perroundxp.csv", row, 5 ) );
        var_9707f3b283717725 = float( tablelookupbyrow( "zm/scoreinfo/perroundxp.csv", row, 6 ) );
        var_9707f0b28371708c = float( tablelookupbyrow( "zm/scoreinfo/perroundxp.csv", row, 7 ) );
        var_9707f1b2837172bf = float( tablelookupbyrow( "zm/scoreinfo/perroundxp.csv", row, 8 ) );
        var_9707eeb283716c26 = float( tablelookupbyrow( "zm/scoreinfo/perroundxp.csv", row, 9 ) );
        var_aa99cdb0f41ffd4e = int( tablelookupbyrow( "zm/scoreinfo/perroundxp.csv", row, 10 ) );
        var_aa99ccb0f41ffb1b = int( tablelookupbyrow( "zm/scoreinfo/perroundxp.csv", row, 11 ) );
        var_aa99cbb0f41ff8e8 = int( tablelookupbyrow( "zm/scoreinfo/perroundxp.csv", row, 12 ) );
        var_aa99d2b0f420084d = int( tablelookupbyrow( "zm/scoreinfo/perroundxp.csv", row, 13 ) );
        matchbonus_limit = float( tablelookupbyrow( "zm/scoreinfo/perroundxp.csv", row, 14 ) );
        parameters.scoreevent = [ var_cda8327f0b3e6cbf, var_cda8337f0b3e6ef2, var_cda8347f0b3e7125, var_cda82d7f0b3e61c0 ];
        parameters.weaponxp = [ var_9707f3b283717725, var_9707f0b28371708c, var_9707f1b2837172bf, var_9707eeb283716c26 ];
        parameters.ekialimit = [ var_aa99cdb0f41ffd4e, var_aa99ccb0f41ffb1b, var_aa99cbb0f41ff8e8, var_aa99d2b0f420084d ];
        parameters.matchbonus_limit = matchbonus_limit;
        level.var_caeb00173dfb20f1 = parameters;
    }
    
    foreach ( player in level.players )
    {
        player.var_8379371012c369d9 = 0;
    }
}

// Namespace events
// Params 0
// Checksum 0xd6ea59d5, Offset: 0xc8d
// Size: 0x2b
function onplayerconnect()
{
    for ( ;; )
    {
        level waittill( #"connected", player );
        player.var_8379371012c369d9 = 0;
    }
}

// Namespace events
// Params 1
// Checksum 0x262aebb9, Offset: 0xcc0
// Size: 0xed
function get_custom_weapon_xp( eventstring )
{
    weapon_xp = rank::getscoreinfocategory( eventstring, #"weaponxpoverride" );
    
    if ( !isdefined( weapon_xp ) )
    {
        return 0;
    }
    
    ekiaratio = self.var_8379371012c369d9 / level.var_caeb00173dfb20f1.ekialimit[ level.players.size - 1 ];
    xpratio = 1;
    
    if ( ekiaratio > 1 )
    {
        if ( ekiaratio < 1.25 )
        {
            xpratio *= 0.5;
        }
        else if ( ekiaratio < 1.5 )
        {
            xpratio *= 0.25;
        }
        else
        {
            xpratio *= 0.1;
        }
    }
    
    weapon_xp *= level.var_caeb00173dfb20f1.weaponxp[ level.players.size - 1 ];
    weapon_xp *= xpratio;
    return int( weapon_xp );
}

// Namespace events
// Params 1, eflags: 0x4
// Checksum 0xe273dd4, Offset: 0xdb6
// Size: 0x18
function private get_weapon_postfix( weapon_name_hash )
{
    return level.var_399a49f01414bc69[ weapon_name_hash ];
}

// Namespace events
// Params 2
// Checksum 0x20cfbba9, Offset: 0xdd7
// Size: 0x232
function function_47dc9b24caa6ae1f( base_kia, var_9b672797eb3d6743 )
{
    if ( !isdefined( base_kia ) )
    {
        if ( isagent( self ) && self.subclass )
        {
            assertmsg( "<dev string:x24>" + self.subclass + "<dev string:x46>" );
        }
        else
        {
            assertmsg( "<dev string:x56>" );
        }
        
        base_kia = #"zombie_kia";
    }
    
    if ( base_kia == #"zombie_kia" )
    {
        var_afdd7c74e32f8475 = hashcat( #"zombie_kia", var_9b672797eb3d6743 );
    }
    else if ( base_kia == #"zombie_kia_special" )
    {
        var_afdd7c74e32f8475 = hashcat( #"zombie_kia_special", var_9b672797eb3d6743 );
    }
    else if ( base_kia == #"zombie_kia_elite" )
    {
        var_afdd7c74e32f8475 = hashcat( #"zombie_kia_elite", var_9b672797eb3d6743 );
    }
    else if ( base_kia == #"hellhound_kia" )
    {
        var_afdd7c74e32f8475 = hashcat( #"hellhound_kia", var_9b672797eb3d6743 );
    }
    else if ( base_kia == #"soldier_kia" )
    {
        var_afdd7c74e32f8475 = hashcat( #"soldier_kia", var_9b672797eb3d6743 );
    }
    else if ( base_kia == #"hash_a7dd56a700330c54" )
    {
        var_afdd7c74e32f8475 = hashcat( #"hash_a7dd56a700330c54", var_9b672797eb3d6743 );
    }
    else if ( base_kia == #"hash_2a7922a73e6eb69" )
    {
        var_afdd7c74e32f8475 = hashcat( #"hash_2a7922a73e6eb69", var_9b672797eb3d6743 );
    }
    else if ( base_kia == #"zombie_kia_mission_kill" || base_kia == #"zombie_kia_mission_kill_special" || base_kia == #"zombie_kia_mission_kill_elite" )
    {
        var_afdd7c74e32f8475 = hashcat( base_kia, var_9b672797eb3d6743 );
    }
    else if ( base_kia == #"zombie_kia_melee" )
    {
        var_afdd7c74e32f8475 = hashcat( base_kia, var_9b672797eb3d6743 );
    }
    else if ( base_kia == #"zombie_kia_special_melee" )
    {
        var_afdd7c74e32f8475 = hashcat( base_kia, var_9b672797eb3d6743 );
    }
    else if ( base_kia == #"zombie_kia_elite_melee" )
    {
        var_afdd7c74e32f8475 = hashcat( base_kia, var_9b672797eb3d6743 );
    }
    else if ( base_kia == #"hash_dceb96d9beebf4a" )
    {
        var_afdd7c74e32f8475 = hashcat( base_kia, var_9b672797eb3d6743 );
    }
    else
    {
        var_afdd7c74e32f8475 = base_kia;
    }
    
    var_afdd7c74e32f8475 = getxhash( var_afdd7c74e32f8475 );
    
    if ( !isdefined( level.scoreinfo[ var_afdd7c74e32f8475 ] ) )
    {
        var_afdd7c74e32f8475 = base_kia;
    }
    
    return var_afdd7c74e32f8475;
}

// Namespace events
// Params 1, eflags: 0x4
// Checksum 0xa57e9105, Offset: 0x1012
// Size: 0x4d
function private function_84f30ea0dfcb027d( player )
{
    if ( isplayer( player ) )
    {
        playerid = player getentitynumber();
        
        if ( isdefined( self.var_d4b7ed447e2bf50c[ playerid ] ) )
        {
            return self.var_d4b7ed447e2bf50c[ playerid ];
        }
    }
    
    return level.weaponnone;
}

// Namespace events
// Params 8
// Checksum 0xc772387c, Offset: 0x1068
// Size: 0x6d7
function function_92b70ecfc2f8e086( victim, eattacker, einflictor, smeansofdeath, sweapon, shitloc, typestring, kiastring )
{
    if ( !val::get( "allow_give_point" ) )
    {
        return;
    }
    
    if ( self.var_698cf8d8d4a8cbb9 )
    {
        return;
    }
    
    if ( isdefined( self.last_dmg_struct ) && isplayer( self.last_dmg_struct.var_bd22ba6c600a23a3 ) || isplayer( self.var_bd22ba6c600a23a3 ) )
    {
        return;
    }
    
    if ( eattacker.var_74828b8c6990f0b2 && isplayer( eattacker.owner ) )
    {
        eattacker = eattacker.owner;
    }
    
    if ( !isplayer( eattacker ) && isplayer( eattacker.var_bd22ba6c600a23a3 ) )
    {
        return;
    }
    
    var_8bcb4a2be0e18c36 = 0;
    
    if ( kiastring == #"hash_a7dd56a700330c54" || kiastring == #"hash_2a7922a73e6eb69" )
    {
        var_8bcb4a2be0e18c36 = 1;
    }
    
    var_7912b7fee009f972 = kiastring;
    var_b731155ec1b5e49b = get_weapon_postfix( sweapon.basenamehash );
    
    if ( isdefined( victim.var_e797f68de73ece4e ) )
    {
        kiastring = function_47dc9b24caa6ae1f( kiastring, victim.var_e797f68de73ece4e );
    }
    else if ( isdefined( var_b731155ec1b5e49b ) )
    {
        kiastring = function_47dc9b24caa6ae1f( kiastring, var_b731155ec1b5e49b );
    }
    else
    {
        if ( isdefined( victim.var_bb4d607514eb37ce ) )
        {
            kiastring = function_47dc9b24caa6ae1f( kiastring, victim.var_bb4d607514eb37ce );
        }
        
        binvehicle = 0;
        
        if ( isdefined( einflictor.vehicletype ) )
        {
            if ( einflictor.streakname == "rcxd" )
            {
                kiastring = function_47dc9b24caa6ae1f( kiastring, "_rcxd" );
            }
            
            if ( einflictor.streakname == "ground_drone_unit" )
            {
                kiastring = function_47dc9b24caa6ae1f( kiastring, "_gdu" );
            }
            else
            {
                kiastring = function_47dc9b24caa6ae1f( kiastring, "_vehicle" );
            }
        }
        
        if ( self.last_dmg_struct.biscritical || self.var_1480bf6f03b7e0be.biscritical )
        {
            if ( self.last_dmg_struct.smeansofdeath == "MOD_MELEE" || self.var_1480bf6f03b7e0be.smeansofdeath == "MOD_MELEE" )
            {
                kiastring = function_47dc9b24caa6ae1f( kiastring, "_melee" );
            }
            
            if ( self.last_dmg_struct.eattacker == eattacker || self.var_1480bf6f03b7e0be.eattacker == eattacker )
            {
                kiastring = function_47dc9b24caa6ae1f( kiastring, "_critical" );
                eattacker stats::setextrascore2( eattacker.pers[ "extrascore2" ] + 1 );
            }
        }
        else if ( smeansofdeath == "MOD_MELEE" && !isdefined( self.var_1480bf6f03b7e0be ) )
        {
            kiastring = function_47dc9b24caa6ae1f( kiastring, "_melee" );
        }
    }
    
    var_3edd9547c2f1faad = 0;
    
    if ( einflictor.var_2364be08b6facb67 || self.var_2364be08b6facb67 )
    {
        var_3edd9547c2f1faad = 1;
    }
    
    if ( isdefined( self.var_5d3022108c155ed4 ) )
    {
        kiastring = self.var_5d3022108c155ed4;
    }
    
    var_9d1684eeabdc4400 = 0;
    
    if ( self.var_e797f68de73ece4e == "_fog" )
    {
        var_9d1684eeabdc4400 = 1;
    }
    
    sinfo = spawnstruct();
    sinfo.smeansofdeath = smeansofdeath;
    sinfo.shitloc = shitloc;
    sinfo.victim = victim;
    sinfo.aicategory = victim.aicategory;
    sinfo.var_8bcb4a2be0e18c36 = var_8bcb4a2be0e18c36;
    sinfo.var_9d1684eeabdc4400 = var_9d1684eeabdc4400;
    sinfo.var_3edd9547c2f1faad = var_3edd9547c2f1faad;
    
    if ( self.last_dmg_struct.biscritical )
    {
        sinfo.biscritical = 1;
    }
    
    eattacker points::zm_do_score_event( kiastring, sweapon, undefined, undefined, victim, undefined, undefined, undefined, undefined, undefined, sinfo );
    eattacker.var_8379371012c369d9++;
    
    if ( isdefined( self.a_n_player_damage ) )
    {
        if ( self.a_n_player_damage.size > 0 )
        {
            foreach ( player in self.a_n_player_damage )
            {
                if ( eattacker == player )
                {
                    continue;
                }
                
                if ( isplayer( player ) )
                {
                    if ( self.var_1480bf6f03b7e0be.biscritical )
                    {
                        if ( smeansofdeath == "MOD_MELEE" || self.var_1480bf6f03b7e0be.smeansofdeath == "MOD_MELEE" )
                        {
                            kiastring = function_47dc9b24caa6ae1f( kiastring, "_melee" );
                        }
                        
                        if ( self.var_1480bf6f03b7e0be.eattacker == player )
                        {
                            var_7912b7fee009f972 = function_47dc9b24caa6ae1f( var_7912b7fee009f972, "_critical" );
                            player stats::setextrascore2( player.pers[ "extrascore2" ] + 1 );
                        }
                    }
                    
                    var_af019b261d1e4ac3 = function_84f30ea0dfcb027d( player );
                    player points::zm_do_score_event( var_7912b7fee009f972, var_af019b261d1e4ac3 );
                    player.var_8379371012c369d9++;
                    
                    if ( player.pers[ "assists" ] < 999 )
                    {
                        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
                        {
                            if ( isdefined( player.leaderboarddata[ "assists" ] ) )
                            {
                                player.leaderboarddata[ "assists" ] = player.leaderboarddata[ "assists" ] + 1;
                            }
                            
                            if ( isdefined( level.leaderboardfunc[ "assists" ] ) )
                            {
                                [[ level.leaderboardfunc[ "assists" ] ]]( player, 1 );
                            }
                            
                            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x81>" );
                            
                            if ( isdefined( player.pers[ "assists" ] ) )
                            {
                                player.pers[ "assists" ] = player.pers[ "assists" ] + 1;
                            }
                        }
                        
                        player.assists = player.pers[ "assists" ];
                    }
                }
            }
        }
    }
    
    zm_track_rapid_kills( victim, eattacker, einflictor, smeansofdeath, sweapon, shitloc, typestring, kiastring );
    
    if ( isdefined( level.var_a3797ac7329f1d8d ) )
    {
        eattacker [[ level.var_a3797ac7329f1d8d ]]( victim, einflictor, smeansofdeath, sweapon );
    }
}

// Namespace events
// Params 8, eflags: 0x4
// Checksum 0x76134c12, Offset: 0x1747
// Size: 0x5cf
function private zm_track_rapid_kills( victim, eattacker, einflictor, smeansofdeath, sweapon, shitloc, typestring, kiastring )
{
    if ( isplayer( eattacker ) )
    {
        if ( !isdefined( eattacker.rapidkill_data ) )
        {
            eattacker.rapidkill_data = [];
        }
        
        eattacker points::track_rapidkill( "general" );
        
        if ( isdefined( smeansofdeath ) )
        {
            eattacker points::track_rapidkill( smeansofdeath, sweapon, victim );
        }
        
        if ( isdefined( sweapon ) && isdefined( smeansofdeath ) && sweapon.classname != "turret" && ( sweapon.inventorytype == "primary" || sweapon.inventorytype == "altmode" ) && smeansofdeath != "MOD_MELEE" && !points::is_field_upgrade_weapons( sweapon ) )
        {
            eattacker points::track_rapidkill( "primary", sweapon, victim );
            
            if ( isdefined( victim.last_dmg_struct ) && victim.last_dmg_struct.biscritical )
            {
                eattacker points::track_rapidkill( "critical", sweapon, victim );
            }
        }
        
        if ( isdefined( smeansofdeath ) && !points::is_killstreak_weapons( sweapon ) && !points::is_field_upgrade_weapons( sweapon ) && smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_GRENADE_SPLASH" )
        {
            eattacker points::track_rapidkill( "single_explosive_kill", sweapon, victim );
        }
        
        if ( isdefined( eattacker.vehicle ) )
        {
            if ( utility::isvehiclecrushdamage( einflictor, smeansofdeath ) )
            {
                if ( utility::issharedfuncdefined( #"sound", #"play_scoreevent_vo", 0 ) )
                {
                    utility::callsharedfunc( #"sound", #"play_scoreevent_vo", eattacker, #"bc_scoreevent_zm_vehilcekill" );
                }
                
                eattacker points::track_rapidkill( "vehicle_crush_or_kill", undefined, victim );
                var_4b227d8dcfcfcd76 = 1;
            }
            else if ( eattacker.currentweapon.classname == "turret" )
            {
                eattacker points::track_rapidkill( "vehicle_crush_or_kill", undefined, victim );
                var_4b227d8dcfcfcd76 = 1;
            }
        }
        
        if ( eattacker killstreak::isjuggernaut() || points::is_killstreak_weapons( sweapon ) )
        {
            eattacker points::track_rapidkill( "killstreak_kill", undefined, victim );
        }
        
        if ( isdefined( victim.target_attractor ) )
        {
            if ( victim.target_attractor.source.weapon_name === points::function_2f5082d7ee39b1dc( "equip_decoy" ) && eattacker === victim.target_attractor.source.owner )
            {
                victim.is_tatical_kill = 1;
                eattacker points::track_rapidkill( "decoy_grenade", undefined, victim );
            }
        }
        
        if ( sweapon.classname == "throwingknife" )
        {
            if ( sweapon.basename === points::function_2f5082d7ee39b1dc( "equip_combataxe" ) )
            {
                victim.is_lethal_or_super_kill = 1;
                eattacker points::track_rapidkill( "combataxe", undefined, victim );
                eattacker points::track_rapidkill( "combataxe_single_throw", sweapon, victim );
            }
        }
        
        if ( eattacker utility::function_1fe82b95e465ee6c( #"hash_29a97a3a45b445e4" ) || isdefined( eattacker.rapidkill_data[ "adrenaline_or_self_revive" ] ) && eattacker.rapidkill_data[ "adrenaline_or_self_revive" ].rapidkill_count > 0 )
        {
            eattacker points::track_rapidkill( "adrenaline_or_self_revive", undefined, victim );
        }
        
        if ( !isdefined( eattacker.no_damage_kill_count ) )
        {
            eattacker.no_damage_kill_count = 0;
        }
        
        if ( !var_4b227d8dcfcfcd76 )
        {
            eattacker.no_damage_kill_count++;
        }
        
        if ( isdefined( sweapon ) && isdefined( smeansofdeath ) )
        {
            var_5e5a2456deacd236 = points::zm_get_weapon_element( sweapon, eattacker, smeansofdeath );
            var_12f86adcdc0f31a4 = "none";
            
            if ( var_5e5a2456deacd236 == "fire" || smeansofdeath == "MOD_ELEMENTAL_FIRE" )
            {
                if ( !isdefined( einflictor ) || einflictor.weapon_name != "hellhound_molotov" )
                {
                    eattacker points::track_rapidkill( "elemental_kill_fire", sweapon, victim );
                    var_12f86adcdc0f31a4 = #"fire_damage_weakness_kill";
                }
            }
            else if ( var_5e5a2456deacd236 == "cold" || smeansofdeath == "MOD_ELEMENTAL_COLD" )
            {
                eattacker points::track_rapidkill( "elemental_kill_cold", sweapon, victim );
                var_12f86adcdc0f31a4 = #"cold_damage_weakness_kill";
            }
            else if ( var_5e5a2456deacd236 == "electrical" || smeansofdeath == "MOD_ELEMENTAL_ELEC" )
            {
                eattacker points::track_rapidkill( "elemental_kill_electrical", sweapon, victim );
                var_12f86adcdc0f31a4 = #"electric_damage_weakness_kill";
            }
            else if ( var_5e5a2456deacd236 == "toxic" || smeansofdeath == "MOD_ELEMENTAL_TOXIC" )
            {
                eattacker points::track_rapidkill( "elemental_kill_toxic", sweapon, victim );
                var_12f86adcdc0f31a4 = #"toxic_damage_weakness_kill";
            }
            
            if ( isarray( self.elementalweakness ) && self.elementalweakness[ var_5e5a2456deacd236 ] && var_12f86adcdc0f31a4 != "none" )
            {
                eattacker points::zm_do_score_event( var_12f86adcdc0f31a4 );
            }
        }
        
        var_138121e726290b4 = 0;
        
        if ( status_effects::function_e947cf9a9f176b2e( "burn", "fire" ) )
        {
            eattacker points::track_rapidkill( "burn_kill", sweapon, victim );
            var_138121e726290b4++;
        }
        
        if ( status_effects::function_e947cf9a9f176b2e( "slow", "cold" ) )
        {
            eattacker points::track_rapidkill( "freeze_kill", sweapon, victim );
            var_138121e726290b4++;
        }
        
        if ( status_effects::function_e947cf9a9f176b2e( "stun", "electrical" ) )
        {
            eattacker points::track_rapidkill( "electrocuted_kill", sweapon, victim );
            var_138121e726290b4++;
        }
        
        if ( var_138121e726290b4 > 1 )
        {
            eattacker points::track_rapidkill( "multielement_kill", sweapon, victim );
        }
    }
}

// Namespace events
// Params 1
// Checksum 0x715e10e3, Offset: 0x1d1e
// Size: 0x7c
function zm_score_event( sparams )
{
    if ( isplayer( self ) && isdefined( sparams.scoreevent ) )
    {
        scoreevent = sparams.scoreevent;
        
        if ( sparams.var_46993e9f6a989d94 )
        {
            eventinfo = { #var_46993e9f6a989d94:sparams.var_46993e9f6a989d94 };
        }
        
        points::zm_do_score_event( scoreevent, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, eventinfo );
    }
}

// Namespace events
// Params 1
// Checksum 0x44da3d1a, Offset: 0x1da2
// Size: 0x457
function zm_event_on_ai_killed( sparams )
{
    if ( !val::get( "allow_give_point" ) )
    {
        return;
    }
    
    if ( isdefined( sparams.eattacker ) && isplayer( sparams.eattacker.var_bd22ba6c600a23a3 ) )
    {
        if ( utility::issharedfuncdefined( #"hash_86f4e49ae129fde9", #"hash_7467f5003c091d84", 0 ) && sparams.eattacker.var_c6e8f7a48520dc46 )
        {
            utility::callsharedfunc( #"hash_86f4e49ae129fde9", #"hash_7467f5003c091d84" );
            kia_string = function_47dc9b24caa6ae1f( self.kiastring, self.var_e797f68de73ece4e );
        }
        else if ( sparams.eattacker.var_b7d346480d1fc488 )
        {
            kia_string = function_47dc9b24caa6ae1f( self.kiastring, "_hatchling" );
        }
        else if ( sparams.eattacker.var_8784eb75b9be9390 )
        {
            kia_string = function_47dc9b24caa6ae1f( self.kiastring, "_hellping_hound" );
        }
        else
        {
            kia_string = function_47dc9b24caa6ae1f( self.kiastring, "_brot" );
        }
        
        player = sparams.eattacker.var_bd22ba6c600a23a3;
        victim = sparams.eattacker;
        player points::zm_do_score_event( kia_string, undefined, undefined, undefined, victim );
    }
    
    var_3ef9e08869fe49bc = 0;
    
    if ( isplayer( self.var_bd22ba6c600a23a3 ) )
    {
        if ( utility::issharedfuncdefined( #"hash_86f4e49ae129fde9", #"hash_7467f5003c091d84", 0 ) && self.var_c6e8f7a48520dc46 )
        {
            utility::callsharedfunc( #"hash_86f4e49ae129fde9", #"hash_7467f5003c091d84" );
            kia_string = function_47dc9b24caa6ae1f( self.kiastring, self.var_e797f68de73ece4e );
        }
        else if ( self.var_b7d346480d1fc488 )
        {
            var_3ef9e08869fe49bc = 1;
        }
        else
        {
            kia_string = function_47dc9b24caa6ae1f( self.kiastring, "_brot" );
        }
        
        if ( !var_3ef9e08869fe49bc )
        {
            victim = self;
            self.var_bd22ba6c600a23a3 points::zm_do_score_event( kia_string, undefined, undefined, undefined, victim );
        }
    }
    
    if ( isdefined( sparams.eattacker ) && isplayer( sparams.eattacker.owner ) && !var_3ef9e08869fe49bc )
    {
        if ( !isdefined( sparams.eattacker.owner.rapidkill_data ) )
        {
            sparams.eattacker.owner.rapidkill_data = [];
        }
        
        if ( sparams.eattacker.streakname == "sentry_turret" )
        {
            sparams.eattacker.owner points::track_rapidkill( "killstreak_kill", undefined, victim );
        }
        
        if ( sparams.eattacker.classname == "script_vehicle" )
        {
            sparams.eattacker.owner points::track_rapidkill( "vehicle_crush_or_kill", undefined, victim );
        }
    }
    
    if ( isplayer( sparams.eattacker ) && isdefined( sparams.einflictor ) && sparams.einflictor.weapon_name == "hellhound_molotov" )
    {
        einflictor = sparams.einflictor;
        
        if ( isdefined( einflictor.var_d7594a5edcf54e30 ) )
        {
            einflictor [[ einflictor.var_d7594a5edcf54e30 ]]();
        }
    }
    
    if ( isdefined( self ) && isdefined( sparams.eattacker.trap_scriptable ) && isdefined( level.var_655315530ac9b6a1 ) && !var_3ef9e08869fe49bc )
    {
        sparams.eattacker [[ level.var_655315530ac9b6a1 ]]( self, sparams.eattacker );
        return;
    }
    
    if ( isdefined( self ) && isdefined( sparams.einflictor.trap_scriptable ) && isdefined( level.var_655315530ac9b6a1 ) && !var_3ef9e08869fe49bc )
    {
        sparams.einflictor [[ level.var_655315530ac9b6a1 ]]( self, sparams.einflictor );
    }
}

