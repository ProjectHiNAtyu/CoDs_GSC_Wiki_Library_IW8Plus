// scripts\mp\gametypes\grind.gsc  (hash_183ba55fed386936.gscc) (size: 16473 Bytes / 0x4059 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc4684055 (3295166549)
// size ...... 16473 (0x4059)
// includes .. 24  (offset: 0x3c39)
// strings ... 43  (offset: 0x3cf9)
// dev strs .. 9   (offset: 0x3fe1)
// exports ... 39  (offset: 0x26a9)
// cseg ...... 0x326 + 0x2383 (0x26a9)
// imports ... 124 (offset: 0x2cc1)
// animtree1 . 0   (offset: 0x4059)
// animtree2 . 0   (offset: 0x4059)
#using script_45dbfb1869cdd1bd;
#using scripts\common\callbacks;
#using scripts\common\gameplay_sound_fx;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\globallogic;
#using scripts\mp\hud_message;
#using scripts\mp\matchdata;
#using scripts\mp\objectiveiconstates;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\persistence;
#using scripts\mp\rank;
#using scripts\mp\spawnlogic;

#namespace grind;

// Namespace grind
// Params 0
// Checksum 0x8952e8ac, Offset: 0x344
// Size: 0x10a
function main()
{
    globallogic::init();
    globallogic::setupcallbacks();
    level.initializematchrules = &initializematchrules;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    updategametypedvars();
    level.teambased = 1;
    level thread function_fd09ce0b3128742f();
    level.onstartgametype = &onstartgametype;
    level.getspawnpoint = &getspawnpoint;
    level.modeonspawnplayer = &onspawnplayer;
    level.var_40cd999d911308e0 = &game_utility_mp::function_abefb3841cda328e;
    level.var_e16ef107a3dd572b = &game_utility_mp::function_90ed3e9fed444ef5;
    collectibles::initialize();
    callback::add( #"hash_64d5ef3aec7665f8", &function_616ab6b4ec977c84 );
    callback::add( #"hash_163ce3e6ccfcab8d", &function_6402fe41e96c7cad );
    callback::add( #"collectible_on_spawned", &collectiblespawned );
    callback::add( #"player_disconnect", &on_player_disconnect );
    allowed[ 0 ] = game_utility::getgametype();
    game_utility_mp::clean_up_entities( allowed );
}

// Namespace grind
// Params 0
// Checksum 0xff934f69, Offset: 0x456
// Size: 0x114
function initializematchrules()
{
    game_utility_mp::setcommonrulesfrommatchrulesdata();
    setdynamicdvar( @"scr_grind_banktime", getmatchrulesdata( "grindData", "bankTime" ) );
    setdynamicdvar( @"scr_grind_bankrate", getmatchrulesdata( "grindData", "bankRate" ) );
    setdynamicdvar( @"hash_722cc2fa81e65d71", getmatchrulesdata( "grindData", "bankCaptureTime" ) );
    setdynamicdvar( @"scr_grind_bankdisable", getmatchrulesdata( "grindData", "bankDisable" ) );
    setdynamicdvar( @"scr_grind_bankdisabletags", getmatchrulesdata( "grindData", "bankDisableTags" ) );
    setdynamicdvar( @"scr_grind_bankdisabletime", getmatchrulesdata( "grindData", "bankDisableTime" ) );
    setdynamicdvar( @"scr_grind_megabanklimit", getmatchrulesdata( "grindData", "megaBankLimit" ) );
    setdynamicdvar( @"scr_grind_megabankbonusks", getmatchrulesdata( "grindData", "megaBankBonusKS" ) );
    setdynamicdvar( @"hash_a25f426674b2ea4d", getmatchrulesdata( "grindData", "megaBankBonus" ) );
    setdynamicdvar( @"scr_grind_promode", 0 );
}

// Namespace grind
// Params 0
// Checksum 0xe6f5bcd, Offset: 0x572
// Size: 0xf0
function onstartgametype()
{
    setclientnamemode( "auto_change" );
    
    if ( !isdefined( game[ "switchedsides" ] ) )
    {
        game[ "switchedsides" ] = 0;
    }
    
    game_utility_mp::setobjectivetext( "allies", &"objectives/war" );
    game_utility_mp::setobjectivetext( "axis", &"objectives/war" );
    
    if ( level.splitscreen )
    {
        game_utility_mp::setobjectivescoretext( "allies", &"objectives/war" );
        game_utility_mp::setobjectivescoretext( "axis", &"objectives/war" );
    }
    else
    {
        game_utility_mp::setobjectivescoretext( "allies", &"objectives/war_score" );
        game_utility_mp::setobjectivescoretext( "axis", &"objectives/war_score" );
    }
    
    game_utility_mp::setobjectivehinttext( "allies", &"objectives/war_hint" );
    game_utility_mp::setobjectivehinttext( "axis", &"objectives/war_hint" );
    initspawns();
    
    /#
        level thread function_8366280ce767d087();
        level thread function_874c9c65c735a78a();
    #/
}

// Namespace grind
// Params 0
// Checksum 0xf0c9e60b, Offset: 0x66a
// Size: 0x14c
function updategametypedvars()
{
    common::updatecommongametypedvars();
    level.banktime = dvars::dvarfloatvalue( "bankTime", 2, 0, 10 );
    level.bankrate = dvars::dvarintvalue( "bankRate", 1, 1, 10 );
    level.bankcapturetime = dvars::dvarintvalue( "bankCaptureTime", 0, 0, 10 );
    level.bankdisable = dvars::dvarintvalue( "bankDisable", 1, 0, 1 );
    level.bankdisabletags = dvars::dvarintvalue( "bankDisableTags", 0, 0, 50 );
    level.bankdisabletime = dvars::dvarintvalue( "bankDisableTime", 0, 0, 120 );
    level.megabanklimit = dvars::dvarintvalue( "megaBankLimit", 5, 5, 15 );
    level.megabankbonusks = dvars::dvarintvalue( "megaBankBonusKS", 1, 0, 10 );
    level.megabankbonus = dvars::dvarintvalue( "megaBankBonus", 150, 0, 750 );
    scorelimit = getmatchrulesdata( "commonOption", "scoreLimit" );
    
    if ( scorelimit == 0 && level.bankdisabletags == 0 )
    {
        level.bankdisable = 0;
        return;
    }
    
    if ( level.bankdisabletags == 0 && scorelimit > 0 )
    {
        level.bankdisabletags = int( scorelimit );
    }
}

// Namespace grind
// Params 1
// Checksum 0x123f9610, Offset: 0x7be
// Size: 0x2e
function onspawnplayer( revivespawn )
{
    self.isscoring = 0;
    hud_message::function_ef4318a0090caa0f( #"bank_tags" );
    updatetags( self );
}

// Namespace grind
// Params 0
// Checksum 0x8176bd4d, Offset: 0x7f4
// Size: 0x51
function monitorjointeam()
{
    self endon( #"disconnect" );
    
    while ( true )
    {
        utility::waittill_any( "joined_team", "joined_spectators" );
        
        if ( !isdefined( self.collectible_amount ) )
        {
            self.collectible_amount = 0;
        }
        
        self setclientomnvar( "ui_grind_tags", self.collectible_amount );
    }
}

// Namespace grind
// Params 1
// Checksum 0xc4fb44cf, Offset: 0x84d
// Size: 0x2c
function hidehudelementongameend( hudelement )
{
    level waittill( #"game_ended" );
    
    if ( isdefined( hudelement ) )
    {
        hudelement.alpha = 0;
    }
}

// Namespace grind
// Params 0
// Checksum 0xfdc5df9f, Offset: 0x881
// Size: 0xae
function runzonethink()
{
    level endon( #"game_ended" );
    self endon( "stop_trigger" + self.objectivekey );
    
    while ( true )
    {
        self.trigger waittill( #"trigger", player );
        
        if ( self.disabled )
        {
            continue;
        }
        
        if ( self.teamsusing.size > 1 )
        {
            continue;
        }
        
        if ( isagent( player ) )
        {
            continue;
        }
        
        if ( !isplayer( player ) )
        {
            continue;
        }
        
        if ( player.isscoring )
        {
            continue;
        }
        
        player.isscoring = 1;
        player thread processscoring( player, self );
    }
}

// Namespace grind
// Params 2, eflags: 0x4
// Checksum 0x46b37e35, Offset: 0x937
// Size: 0x3f1
function private processscoring( player, zone )
{
    level endon( #"game_ended" );
    player endon( #"death_or_disconnect" );
    
    while ( !zone.disabled && zone.teamsusing.size == 1 && player::isreallyalive( player ) && player istouching( zone.trigger ) && zone.teamsusing[ 0 ] == player.team )
    {
        player_tag_amount = function_6fb6ab62baa79c56( player );
        var_12073fffe0d3b34f = level.bankrate;
        
        if ( player_tag_amount > 0 )
        {
            namespace_1cdb218d68ef13f6::set_objective_icon_state( zone.objectiveid, hashcat( #"hash_98c6f33a574b3323", zone.objectivekey ) );
            
            if ( player_tag_amount >= level.megabanklimit )
            {
                var_12073fffe0d3b34f = level.megabanklimit;
                
                if ( zone.scriptable getscriptablehaspart( #"bank_sounds" ) && zone.scriptable getscriptableparthasstate( #"bank_sounds", #"mega_bank" ) )
                {
                    zone.scriptable setscriptablepartstate( #"bank_sounds", #"mega_bank" );
                }
                else
                {
                    player gameplay_sound_fx::function_1ef72f46669e3816( #"hash_fe6bd5625050a85f", player );
                }
                
                points = rank::getscoreinfovalue( #"tag_score" );
                points *= level.megabanklimit;
                
                if ( !isdefined( player.perks[ "specialty_killstreak_to_scorestreak" ] ) )
                {
                    player killstreaks::givestreakpoints( #"capture", level.megabankbonusks );
                }
                
                player thread points::doscoreevent( #"mega_bank", undefined, points + level.megabankbonus );
                
                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
                {
                    if ( isdefined( player.leaderboarddata[ "tagsMegaBanked" ] ) )
                    {
                        player.leaderboarddata[ "tagsMegaBanked" ] = player.leaderboarddata[ "tagsMegaBanked" ] + level.megabanklimit;
                    }
                    
                    if ( isdefined( level.leaderboardfunc[ "tagsMegaBanked" ] ) )
                    {
                        [[ level.leaderboardfunc[ "tagsMegaBanked" ] ]]( player, level.megabanklimit );
                    }
                    
                    assert( isint( level.megabanklimit ) || isfloat( level.megabanklimit ), "<dev string:x24>" );
                    
                    if ( isdefined( player.pers[ "tagsMegaBanked" ] ) )
                    {
                        player.pers[ "tagsMegaBanked" ] = player.pers[ "tagsMegaBanked" ] + level.megabanklimit;
                    }
                }
            }
            else
            {
                if ( zone.scriptable getscriptablehaspart( #"bank_sounds" ) && zone.scriptable getscriptableparthasstate( #"bank_sounds", #"hash_9a1adf9baa01f4b7" ) )
                {
                    zone.scriptable setscriptablepartstate( #"bank_sounds", #"hash_9a1adf9baa01f4b7" );
                }
                else
                {
                    player gameplay_sound_fx::function_1ef72f46669e3816( #"token_banked", player );
                }
                
                player thread points::doscoreevent( #"tag_score" );
            }
            
            scoreamount( player, var_12073fffe0d3b34f, zone );
            
            if ( isdefined( level.var_feb5ffcd580afd63 ) )
            {
                player [[ level.var_feb5ffcd580afd63 ]]();
            }
        }
        else
        {
            player.isscoring = 0;
            namespace_1cdb218d68ef13f6::set_objective_icon_state( zone.objectiveid, hashcat( #"bank_", zone.objectivekey ) );
            break;
        }
        
        wait level.banktime;
    }
}

// Namespace grind
// Params 3
// Checksum 0x35101e2f, Offset: 0xd30
// Size: 0x2a3
function scoreamount( player, numtags, zone )
{
    function_55b02c72f44d28d7( player, numtags );
    gamescore::giveteamscoreforobjective( player.team, numtags, 0 );
    
    if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
    {
        if ( isdefined( player.leaderboarddata[ "confirmed" ] ) )
        {
            player.leaderboarddata[ "confirmed" ] = player.leaderboarddata[ "confirmed" ] + numtags;
        }
        
        if ( isdefined( level.leaderboardfunc[ "confirmed" ] ) )
        {
            [[ level.leaderboardfunc[ "confirmed" ] ]]( player, numtags );
        }
        
        assert( isint( numtags ) || isfloat( numtags ), "<dev string:x24>" );
        
        if ( isdefined( player.pers[ "confirmed" ] ) )
        {
            player.pers[ "confirmed" ] = player.pers[ "confirmed" ] + numtags;
        }
    }
    
    player persistence::statsetchild( "round", "confirmed", player.pers[ "confirmed" ] );
    player stats::setextrascore0( player.pers[ "confirmed" ], "confirmed" );
    
    if ( level.bankdisable )
    {
        zone.tagsdeposited += numtags;
        
        if ( zone.tagsdeposited >= level.bankdisabletags )
        {
            deactivate_grindzone( zone );
            zone.scriptable setscriptablepartstate( #"flag", #"off" );
            zone.scriptable setscriptablepartstate( #"pulse", #"off" );
            
            if ( zone.objectivekey )
            {
                foreach ( entry in level.teamnamelist )
                {
                    dialog::statusdialog( hashcat( #"hash_78a687b1b9d1318b", zone.objectivekey ), entry );
                }
            }
            
            if ( level.bankdisabletime == 0 )
            {
                return;
            }
            
            zone thread waitthenenablezone();
        }
    }
}

// Namespace grind
// Params 0
// Checksum 0x4d8378e2, Offset: 0xfdb
// Size: 0xbb
function waitthenenablezone()
{
    level endon( #"game_ended" );
    wait level.bankdisabletime;
    activate_grindzone( self );
    
    if ( self.objectivekey )
    {
        foreach ( entry in level.teamnamelist )
        {
            dialog::statusdialog( hashcat( #"hash_ce9b41d1984d3ac6", self.objectivekey ), entry );
        }
    }
}

// Namespace grind
// Params 0
// Checksum 0xf7d98ee1, Offset: 0x109e
// Size: 0xe2
function initspawns()
{
    if ( getdvarint( @"hash_742caa13b3c2e685" ) )
    {
        return;
    }
    
    spawnlogic::function_6dbabb72223a4bca();
    spawnlogic::setactivespawnlogic( #"default" );
    spawnkey = spawnlogic::function_d5c160a4110b573e();
    
    if ( spawnlogic::function_5cf82e30c52a895d( spawnkey ) )
    {
        spawnlogic::function_3cdbb94b81729d5f( spawnkey );
    }
    else
    {
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_attackers", "mp_tdm_spawn_allies_start", game[ "attackers" ] );
        spawnlogic::function_9bd2654564d3372d( #"start", #"start_defenders", "mp_tdm_spawn_axis_start", game[ "defenders" ] );
        spawnlogic::function_17e08e497a9b4136( #"primary", #"primary", "mp_tdm_spawn" );
        spawnlogic::function_17e08e497a9b4136( #"fallback", #"fallback", "mp_tdm_spawn_secondary", 1 );
    }
    
    spawnlogic::finalizemap();
}

// Namespace grind
// Params 0
// Checksum 0x9f51d183, Offset: 0x1188
// Size: 0x9
function getspawnpoint()
{
    return spawnlogic::function_3f9d5fcfb93d4190( self );
}

// Namespace grind
// Params 2
// Checksum 0x85ececd, Offset: 0x119a
// Size: 0xe1
function function_532ea54f8f712494( slabel, vorigin )
{
    grind_locations = getentarray( "grind_location", #targetname );
    assert( isdefined( slabel ) && ( slabel == "<dev string:x4a>" || slabel == "<dev string:x4c>" ), "<dev string:x4e>" );
    
    foreach ( obj in grind_locations )
    {
        if ( obj.script_label == slabel )
        {
            obj.origin = vorigin;
        }
    }
}

/#

    // Namespace grind
    // Params 0
    // Checksum 0x1a8f87bb, Offset: 0x1283
    // Size: 0x198, Type: dev
    function function_8366280ce767d087()
    {
        self endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_ec6d489d470bc2ad" ) != 0 )
            {
                foreach ( player in level.players )
                {
                    if ( player.team == "<dev string:x7d>" )
                    {
                        addtags( player, getdvarint( @"hash_ec6d489d470bc2ad" ) );
                    }
                }
                
                break;
            }
            else if ( getdvarint( @"hash_6f6849bde2dd82a2" ) != 0 )
            {
                foreach ( player in level.players )
                {
                    if ( player.team == "<dev string:x84>" )
                    {
                        addtags( player, getdvarint( @"hash_6f6849bde2dd82a2" ) );
                    }
                }
                
                break;
            }
            
            wait 1;
        }
        
        setdevdvar( @"hash_ec6d489d470bc2ad", 0 );
        setdevdvar( @"hash_6f6849bde2dd82a2", 0 );
        thread function_8366280ce767d087();
    }

    // Namespace grind
    // Params 0
    // Checksum 0x92ec1c1d, Offset: 0x1423
    // Size: 0xa2, Type: dev
    function function_874c9c65c735a78a()
    {
        self endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"scr_give_score_allies" ) != 0 )
            {
                gamescore::giveteamscoreforobjective( "<dev string:x7d>", getdvarint( @"scr_give_score_allies" ), 0 );
                break;
            }
            else if ( getdvarint( @"scr_give_score_axis" ) != 0 )
            {
                gamescore::giveteamscoreforobjective( "<dev string:x84>", getdvarint( @"scr_give_score_axis" ), 0 );
                break;
            }
            
            wait 1;
        }
        
        setdevdvar( @"scr_give_score_allies", 0 );
        setdevdvar( @"scr_give_score_axis", 0 );
        thread function_874c9c65c735a78a();
    }

#/

// Namespace grind
// Params 1, eflags: 0x4
// Checksum 0x7b9beb12, Offset: 0x14cd
// Size: 0x106
function private function_616ab6b4ec977c84( params )
{
    if ( isdefined( params.collectible ) )
    {
        if ( isdefined( params.collectible.scriptable ) && params.collectible.scriptable getscriptablehaspart( #"sounds" ) && params.collectible.scriptable getscriptableparthasstate( #"sounds", #"pickup_sound" ) )
        {
            params.collectible.scriptable setscriptablepartstate( #"sounds", #"pickup_sound" );
        }
        
        if ( isdefined( params.player ) && params.collectible.collectible_amount > 0 )
        {
            addtags( params.player, params.collectible.collectible_amount );
        }
    }
}

// Namespace grind
// Params 1, eflags: 0x4
// Checksum 0x9e5525be, Offset: 0x15db
// Size: 0x106
function private function_6402fe41e96c7cad( params )
{
    if ( isdefined( params.collectible ) )
    {
        if ( isdefined( params.collectible.scriptable ) && params.collectible.scriptable getscriptablehaspart( #"sounds" ) && params.collectible.scriptable getscriptableparthasstate( #"sounds", #"pickup_sound" ) )
        {
            params.collectible.scriptable setscriptablepartstate( #"sounds", #"pickup_sound" );
        }
        
        if ( isdefined( params.player ) && params.collectible.collectible_amount > 0 )
        {
            addtags( params.player, params.collectible.collectible_amount );
        }
    }
}

// Namespace grind
// Params 1, eflags: 0x4
// Checksum 0xd3c27330, Offset: 0x16e9
// Size: 0xb5
function private collectiblespawned( params )
{
    if ( isdefined( params.collectible ) && isdefined( params.collectible.scriptable ) && params.collectible.scriptable getscriptablehaspart( #"sounds" ) && params.collectible.scriptable getscriptableparthasstate( #"sounds", #"dropped_sound" ) )
    {
        params.collectible.scriptable setscriptablepartstate( #"sounds", #"dropped_sound" );
    }
}

// Namespace grind
// Params 0, eflags: 0x4
// Checksum 0x4bfc1a39, Offset: 0x17a6
// Size: 0x1cf
function private function_fd09ce0b3128742f()
{
    if ( isdefined( level.var_532ea54f8f712494 ) )
    {
        [[ level.var_532ea54f8f712494 ]]();
    }
    
    var_c0b8324094e2898b = getentarray( "grind_location", #targetname );
    triggers = [];
    
    for ( index = 0; index < var_c0b8324094e2898b.size ; index++ )
    {
        triggers[ triggers.size ] = var_c0b8324094e2898b[ index ];
    }
    
    utility::flag_wait( "scriptables_ready" );
    
    foreach ( trigger in triggers )
    {
        trigger.objectivekey = trigger.script_label;
        zone = {};
        zone.trigger = trigger;
        zone.objectivekey = trigger.objectivekey;
        zone.origin = trigger.origin;
        zone.angles = trigger.angles;
        zone.owning_team = "neutral";
        zone.playersusing = [];
        zone.teamsusing = [];
        zone.tagsdeposited = 0;
        function_739a47b02c9061c4( zone );
        construct_grindzone( zone );
        trigger::makeenterexittrigger( zone.trigger, &function_586eed6f7f023bdf, &function_c8668d6d025acadb );
        trigger.zone = zone;
    }
    
    utility::flag_set( "zones_ready" );
}

// Namespace grind
// Params 1, eflags: 0x4
// Checksum 0xc1ebbb4c, Offset: 0x197d
// Size: 0xfb
function private function_739a47b02c9061c4( zone )
{
    /#
        if ( isdefined( zone.objectiveid ) )
        {
            assert( !isdefined( zone.objectiveid ), "<dev string:x89>" + zone.objectiveid + "<dev string:x97>" + zone.trigger.objectivekey + "<dev string:xa2>" );
        }
    #/
    
    zone.objectiveid = objidpoolmanager::requestobjectiveid();
    objidpoolmanager::objective_playermask_showtoall( zone.objectiveid );
    objidpoolmanager::update_objective_ownerteam( zone.objectiveid, "neutral" );
    objidpoolmanager::update_objective_position( zone.objectiveid, zone.origin );
    objidpoolmanager::update_objective_state( zone.objectiveid, "current" );
    objidpoolmanager::objective_set_play_intro( zone.objectiveid, 0 );
    objidpoolmanager::objective_set_play_outro( zone.objectiveid, 0 );
}

// Namespace grind
// Params 1, eflags: 0x4
// Checksum 0xd84b41f5, Offset: 0x1a80
// Size: 0xe8
function private construct_grindzone( zone )
{
    assert( isdefined( zone ) );
    objidpoolmanager::objective_playermask_showtoall( zone.objectiveid );
    objidpoolmanager::update_objective_ownerteam( zone.objectiveid, zone.owning_team );
    objidpoolmanager::update_objective_position( zone.objectiveid, zone.origin );
    objidpoolmanager::update_objective_state( zone.objectiveid, "current" );
    zone.tagsdeposited = 0;
    zone.scriptable_ref = common::get_gametype_asset( #"hash_1d04b4804e950a06" );
    assert( isdefined( zone.scriptable_ref ), #"hash_f7e35926afd4a778" );
    zone.scriptable = function_9c6a197257af453f( zone );
    zone thread runzonethink();
    function_189e3abd34812de5( zone );
}

// Namespace grind
// Params 1, eflags: 0x4
// Checksum 0x2c4c70c8, Offset: 0x1b70
// Size: 0x106
function private function_9c6a197257af453f( zone )
{
    tracestart = zone.origin + ( 0, 0, 32 );
    traceend = zone.origin + ( 0, 0, -32 );
    contentoverride = trace::create_contents( 1, 1, 1, 1, 0, 1, 1 );
    ignoreents = [];
    trace = trace::ray_trace( tracestart, traceend, ignoreents, contentoverride );
    upangles = vectortoangles( trace[ "normal" ] );
    baseeffectforward = anglestoforward( upangles );
    scriptable = spawn( "script_model", zone.origin );
    scriptable setmodel( zone.scriptable_ref );
    scriptable.angles = generateaxisanglesfromforwardvector( baseeffectforward, scriptable.angles );
    return scriptable;
}

// Namespace grind
// Params 1, eflags: 0x4
// Checksum 0x6371b84d, Offset: 0x1c7f
// Size: 0xc4
function private function_189e3abd34812de5( zone )
{
    if ( zone.disabled )
    {
        return;
    }
    
    zone.owning_team = "neutral";
    objidpoolmanager::update_objective_sethot( zone.objectiveid, 0 );
    objidpoolmanager::update_objective_ownerteam( zone.objectiveid, "neutral" );
    namespace_1cdb218d68ef13f6::set_objective_icon_state( zone.objectiveid, hashcat( #"bank_", zone.objectivekey ) );
    zone.scriptable setscriptablepartstate( #"flag", #"idle" );
    zone.scriptable setscriptablepartstate( #"pulse", #"off" );
}

// Namespace grind
// Params 1, eflags: 0x4
// Checksum 0xddb00245, Offset: 0x1d4b
// Size: 0xef
function private deactivate_grindzone( zone )
{
    if ( !zone.disabled )
    {
        foreach ( player in zone.playersusing )
        {
            player.isscoring = 0;
        }
        
        zone.disabled = 1;
        zone.tagsdeposited = 0;
        zone.disabled = 1;
        zone.playersusing = [];
        zone.teamsusing = [];
        objidpoolmanager::objective_playermask_hidefromallplayers( zone.objectiveid );
    }
}

// Namespace grind
// Params 1, eflags: 0x4
// Checksum 0x972651fc, Offset: 0x1e42
// Size: 0xee
function private activate_grindzone( zone )
{
    if ( zone.disabled )
    {
        zone.disabled = 0;
        zone.scriptable setscriptablepartstate( #"flag", #"idle" );
        zone.scriptable setscriptablepartstate( #"pulse", #"off" );
        objidpoolmanager::objective_playermask_showtoall( zone.objectiveid );
        objidpoolmanager::update_objective_ownerteam( zone.objectiveid, "neutral" );
        objidpoolmanager::update_objective_position( zone.objectiveid, zone.origin );
        objidpoolmanager::update_objective_state( zone.objectiveid, "current" );
        objidpoolmanager::objective_set_play_intro( zone.objectiveid, 0 );
        objidpoolmanager::objective_set_play_outro( zone.objectiveid, 0 );
    }
}

// Namespace grind
// Params 1, eflags: 0x4
// Checksum 0x271963b, Offset: 0x1f38
// Size: 0xbb
function private function_7b5211eff16aa52( zone )
{
    if ( zone.disabled )
    {
        return;
    }
    
    zone.owning_team = zone.teamsusing[ 0 ];
    zone.scriptable setscriptablepartstate( #"flag", zone.owning_team );
    objidpoolmanager::objective_playermask_showtoall( zone.objectiveid );
    objidpoolmanager::update_objective_ownerteam( zone.objectiveid, zone.owning_team );
    objidpoolmanager::update_objective_position( zone.objectiveid, zone.origin );
    objidpoolmanager::update_objective_state( zone.objectiveid, "current" );
}

// Namespace grind
// Params 1, eflags: 0x4
// Checksum 0x56475962, Offset: 0x1ffb
// Size: 0x5f
function private on_player_disconnect( params )
{
    if ( self.interactedzone )
    {
        self.interactedzone.playersusing = arrayremove( self.interactedzone.playersusing, self );
        function_279df20960825516( self.interactedzone, self );
        self.interactedzone = undefined;
    }
}

// Namespace grind
// Params 2, eflags: 0x4
// Checksum 0xe15dc826, Offset: 0x2062
// Size: 0x110
function private function_586eed6f7f023bdf( enteredplayer, trigger )
{
    zone = trigger.zone;
    
    if ( zone.disabled )
    {
        return;
    }
    
    zone.playersusing = arraycombineunique( zone.playersusing, [ enteredplayer ] );
    enteredplayer.interactedzone = zone;
    
    foreach ( playerusing in zone.playersusing )
    {
        zone.teamsusing = arraycombineunique( zone.teamsusing, [ playerusing.team ] );
    }
    
    function_279df20960825516( zone, enteredplayer );
}

// Namespace grind
// Params 2, eflags: 0x4
// Checksum 0xac9f7a60, Offset: 0x217a
// Size: 0x95
function private function_c8668d6d025acadb( exitedplayer, trigger )
{
    zone = trigger.zone;
    
    if ( zone.disabled )
    {
        return;
    }
    
    exitedplayer.interactedzone = undefined;
    zone.playersusing = arrayremove( zone.playersusing, exitedplayer );
    function_279df20960825516( zone, exitedplayer );
    
    if ( exitedplayer.isscoring )
    {
        exitedplayer.isscoring = 0;
    }
    
    exitedplayer notify( #"zone_exit" );
}

// Namespace grind
// Params 2, eflags: 0x4
// Checksum 0xba0642ff, Offset: 0x2217
// Size: 0x156
function private function_279df20960825516( zone, player )
{
    if ( zone.disabled )
    {
        return;
    }
    
    zone.teamsusing = [];
    
    foreach ( playerusing in zone.playersusing )
    {
        zone.teamsusing = arraycombineunique( zone.teamsusing, [ playerusing.team ] );
    }
    
    if ( zone.teamsusing.size == 0 )
    {
        function_189e3abd34812de5( zone );
        return;
    }
    
    if ( zone.teamsusing.size == 1 )
    {
        if ( zone.owning_team == "none" )
        {
            grindzone_onuncontested( zone );
        }
        
        function_7b5211eff16aa52( zone );
        return;
    }
    
    if ( zone.teamsusing.size > 1 && zone.owning_team != "none" )
    {
        grindzone_oncontested( zone );
    }
}

// Namespace grind
// Params 1, eflags: 0x4
// Checksum 0xb7d27a9a, Offset: 0x2375
// Size: 0x93
function private grindzone_onunoccupied( params )
{
    zone = params.zone;
    
    if ( zone.disabled )
    {
        return;
    }
    
    function_189e3abd34812de5( zone );
    level notify( #"zone_unoccupied" );
    dlog_recordevent( "dlog_event_mp_objective_ownership_changed", [ "key", zone.objectivekey, "team", "neutral", "match_time_ms", matchdata::function_47550968a937b67e( gettime() ) ] );
}

// Namespace grind
// Params 1, eflags: 0x4
// Checksum 0x5dcf79ba, Offset: 0x2410
// Size: 0x116
function private grindzone_oncontested( zone )
{
    level notify( #"zone_contested" );
    
    foreach ( playerusing in zone.playersusing )
    {
        if ( playerusing.isscoring )
        {
            playerusing.isscoring = 0;
        }
    }
    
    zone.owning_team = "none";
    objidpoolmanager::update_objective_sethot( zone.objectiveid, 1 );
    namespace_1cdb218d68ef13f6::set_objective_icon_state( zone.objectiveid, hashcat( #"contested_", zone.objectivekey ) );
    zone.scriptable setscriptablepartstate( #"flag", #"contested" );
}

// Namespace grind
// Params 1, eflags: 0x4
// Checksum 0x30ea2d72, Offset: 0x252e
// Size: 0x58
function private grindzone_onuncontested( zone )
{
    if ( zone.disabled )
    {
        return;
    }
    
    objidpoolmanager::update_objective_sethot( zone.objectiveid, 0 );
    namespace_1cdb218d68ef13f6::set_objective_icon_state( zone.objectiveid, hashcat( #"bank_", zone.objectivekey ) );
}

// Namespace grind
// Params 2, eflags: 0x4
// Checksum 0xb9fcc762, Offset: 0x258e
// Size: 0x57
function private addtags( player, var_b6748b0fbdc778a9 )
{
    if ( isdefined( player.collectible_amount ) )
    {
        player.collectible_amount += var_b6748b0fbdc778a9;
        player setclientomnvar( "ui_grind_tags", player.collectible_amount, 1 );
    }
}

// Namespace grind
// Params 2, eflags: 0x4
// Checksum 0xcb1d9f0a, Offset: 0x25ed
// Size: 0x58
function private function_55b02c72f44d28d7( player, var_9f054d60a79f1056 )
{
    if ( player.collectible_amount > 0 )
    {
        player.collectible_amount -= var_9f054d60a79f1056;
        player setclientomnvar( "ui_grind_tags", player.collectible_amount, 1 );
    }
}

// Namespace grind
// Params 1, eflags: 0x4
// Checksum 0x6b1c80e5, Offset: 0x264d
// Size: 0x27
function private function_6fb6ab62baa79c56( player )
{
    if ( isdefined( player.collectible_amount ) )
    {
        return player.collectible_amount;
    }
}

// Namespace grind
// Params 1, eflags: 0x4
// Checksum 0x21954bad, Offset: 0x267c
// Size: 0x2d
function private updatetags( player )
{
    if ( isdefined( self.collectible_amount ) )
    {
        self setclientomnvar( "ui_grind_tags", self.collectible_amount );
    }
}

