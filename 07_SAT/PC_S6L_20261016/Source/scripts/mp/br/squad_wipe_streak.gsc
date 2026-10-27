// scripts\mp\br\squad_wipe_streak.gsc  (hash_59e04d513b6f6e86.gscc) (size: 9977 Bytes / 0x26f9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x589b3e92 (1486569106)
// size ...... 9977 (0x26f9)
// includes .. 11  (offset: 0x2271)
// strings ... 60  (offset: 0x22c9)
// dev strs .. 15  (offset: 0x2645)
// exports ... 20  (offset: 0x1871)
// cseg ...... 0x55d + 0x1314 (0x1871)
// imports ... 56  (offset: 0x1b91)
// animtree1 . 0   (offset: 0x26f9)
// animtree2 . 0   (offset: 0x26f9)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_gametype_resurgence;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\teams;

#namespace squad_wipe_streak;

// Namespace squad_wipe_streak
// Params 0, eflags: 0x5
// Checksum 0xafe232fa, Offset: 0x57b
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"squad_wipe_streak_system", undefined, undefined, &squad_wipe_streak_system_init );
}

// Namespace squad_wipe_streak
// Params 0
// Checksum 0xad87093d, Offset: 0x59c
// Size: 0x93
function squad_wipe_streak_system_init()
{
    if ( getdvarint( @"hash_ed2161e847be7d53", 0 ) )
    {
        return;
    }
    
    if ( level.gametypebundle.var_3ced6f0a7db412d5 )
    {
        level callback::add( #"register_team_data", &register_team_data );
        level callback::add( #"on_squad_wiped", &on_squad_wiped );
    }
    
    if ( level.gametypebundle.var_5db5bae60ad1d589 )
    {
        level callback::add( #"on_squad_eliminated", &on_squad_eliminated_count );
        register_dialog();
    }
    
    /#
        debug_init();
    #/
}

// Namespace squad_wipe_streak
// Params 0, eflags: 0x4
// Checksum 0x40f5c00c, Offset: 0x637
// Size: 0xb1
function private register_dialog()
{
    game[ "dialog" ][ "squad_wipe_streak_" + "leader" ] = "rsec_wzan_rwsl_01";
    game[ "dialog" ][ "squad_wipe_streak_" + "kill_leader" ] = "rsec_wzan_rwsk";
    game[ "dialog" ][ "squad_wipe_streak_" + "fun_killer" ] = "rses_wzan_rwsf";
    game[ "dialog" ][ "squad_wipe_streak_" + "milestone" ] = "rses_wzan_rwsm";
    game[ "dialog" ][ "squad_count_" + "ten_squads" ] = "rsre_wzan_rtsr";
    game[ "dialog" ][ "squad_count_" + "five_squads" ] = "rsre_wzan_rfsr";
    game[ "dialog" ][ "squad_count_" + "three_squads" ] = "rsre_wzan_rtss";
}

// Namespace squad_wipe_streak
// Params 1, eflags: 0x4
// Checksum 0x9541b99f, Offset: 0x6f0
// Size: 0x309
function private on_squad_wiped( params )
{
    attackers = params.attackers;
    victim = params.victim;
    
    if ( !isdefined( victim ) )
    {
        if ( getdvarint( @"hash_30bdc56c2a2ef592", 1 ) )
        {
            logstring( "[SQUAD WIPE] There was no victim." );
        }
        
        return;
    }
    
    if ( !isdefined( victim.attacker ) )
    {
        if ( getdvarint( @"hash_30bdc56c2a2ef592", 1 ) )
        {
            logstring( "[SQUAD WIPE] There was no attacker on the victim." );
        }
        
        return;
    }
    
    if ( !isdefined( attackers ) || attackers.size == 0 )
    {
        if ( getdvarint( @"hash_30bdc56c2a2ef592", 1 ) )
        {
            logstring( "[SQUAD WIPE] There were no attackers for the victim." );
        }
        
        return;
    }
    
    if ( !isplayer( victim.attacker ) )
    {
        if ( getdvarint( @"hash_30bdc56c2a2ef592", 1 ) )
        {
            logstring( "[SQUAD WIPE] Attacker wasn't a player it was: " + ( victim.attacker.classname ?? "undefined" ) );
        }
        
        return;
    }
    
    if ( victim.attacker == victim )
    {
        if ( getdvarint( @"hash_30bdc56c2a2ef592", 1 ) )
        {
            logstring( "[SQUAD WIPE] Attacker was the victim, it was a suicide? Player: " + victim.name + " Team: " + victim.team );
        }
        
        return;
    }
    
    found_attacker = arraycontains( attackers, victim.attacker );
    
    if ( !found_attacker )
    {
        attackersprint = "";
        
        if ( isdefined( attackers ) )
        {
            attackersprint += "Attackers size " + attackers.size + "  Attackers: ";
            
            foreach ( attacker in attackers )
            {
                attackersprint += " ";
                attackersprint += isdefined( attacker ) ? attacker.name : "undefined";
            }
        }
        else
        {
            attackersprint = "Undefined attackers list";
        }
        
        assert( 0, "<dev string:x24>" + "<dev string:x46>" + attackersprint );
    }
    
    params = { #notification:"team_wiped", #victim:victim, #attacker:victim.attacker, #td_property:"squad_wipes" };
    level function_b2d210efe2b507de( params );
    attacker_streak = level teams::getteamdata( victim.attacker.team, "squad_wipes" );
    
    if ( getdvarint( @"hash_30bdc56c2a2ef592", 1 ) )
    {
        logstring( "[SQUAD WIPE] Attacker: " + victim.attacker.name + " | Victim: " + victim.name + " | Attacker Wipe Count: " + attacker_streak );
    }
}

// Namespace squad_wipe_streak
// Params 1, eflags: 0x4
// Checksum 0x9e54bbf1, Offset: 0xa01
// Size: 0xad
function private on_squad_eliminated_count( params )
{
    switch ( params.remaining_team_count )
    {
        case 10:
            dialog = "squad_count_" + "ten_squads";
            break;
        case 5:
            dialog = "squad_count_" + "five_squads";
            break;
        case 3:
            dialog = "squad_count_" + "three_squads";
            break;
        default:
            dialog = undefined;
            break;
    }
    
    if ( isdefined( dialog ) )
    {
        br_public::brleaderdialog( dialog, 1, undefined, undefined, 1, undefined, "dx_br_smis_" );
    }
}

// Namespace squad_wipe_streak
// Params 1, eflags: 0x4
// Checksum 0xc1066180, Offset: 0xab6
// Size: 0x4f6
function private function_b2d210efe2b507de( params )
{
    td_property = params.td_property;
    attacker = params.attacker;
    victim = params.victim;
    notification = params.notification;
    dialogues = [];
    level teams::modifyteamdata( attacker.team, td_property, 1 );
    victim_streak = level teams::getteamdata( victim.team, "curr_" + td_property );
    
    if ( victim_streak > 0 )
    {
        dialogues[ dialogues.size ] = { #priority:50, #dialog:"fun_killer" };
        
        if ( getdvarint( @"hash_30bdc56c2a2ef592", 1 ) )
        {
            logstring( "[SQUAD WIPE COMMON] " + attacker.team + " stopped team " + victim.team + " that was on a streak of " + victim_streak );
        }
    }
    
    best_team = function_586d3f997c420117( td_property );
    
    if ( isdefined( best_team ) )
    {
        if ( best_team.team == victim.team )
        {
            dialogues[ dialogues.size ] = { #priority:75, #dialog:"kill_leader" };
            
            if ( getdvarint( @"hash_30bdc56c2a2ef592", 1 ) )
            {
                logstring( "[SQUAD WIPE COMMON] " + attacker.team + " eliminated the best team " + victim.team );
            }
        }
    }
    
    level teams::setteamdata( victim.team, "curr_" + td_property, 0 );
    level teams::modifyteamdata( attacker.team, "curr_" + td_property, 1 );
    attacker_streak = level teams::getteamdata( attacker.team, "curr_" + td_property );
    best_attacker_streak = level teams::getteamdata( attacker.team, "best_" + td_property );
    
    if ( attacker_streak > best_attacker_streak )
    {
        level teams::setteamdata( attacker.team, "best_" + td_property, attacker_streak );
    }
    
    level set_team_wipestreak( attacker.team, attacker_streak, td_property, notification );
    level notify( notification + "_" + victim.team );
    prev_best = best_team;
    best_team = function_586d3f997c420117( td_property );
    
    if ( isdefined( best_team ) )
    {
        if ( !isdefined( prev_best ) || isdefined( prev_best ) && prev_best.team != best_team.team )
        {
            dialogues[ dialogues.size ] = { #priority:100, #dialog:"leader" };
            
            if ( getdvarint( @"hash_30bdc56c2a2ef592", 1 ) )
            {
                logstring( "[SQUAD WIPE COMMON] " + best_team.team + " became the best team beating team " + ( !isdefined( prev_best ) ? "none" : prev_best.team ) + " with count of " + best_team.streak );
            }
        }
    }
    
    if ( attacker_streak > 1 && attacker_streak % 2 == 1 )
    {
        dialogues[ dialogues.size ] = { #priority:25, #dialog:"milestone" };
        
        if ( getdvarint( @"hash_30bdc56c2a2ef592", 1 ) )
        {
            logstring( "[SQUAD WIPE COMMON] " + attacker.team + " is on a consecutive streak at " + attacker_streak );
        }
    }
    
    if ( dialogues.size > 0 )
    {
        selected_entry = dialogues[ 0 ];
        
        if ( dialogues.size > 1 )
        {
            foreach ( entry in dialogues )
            {
                if ( entry.priority >= selected_entry.priority )
                {
                    selected_entry = entry;
                }
            }
        }
        
        if ( level.gametypebundle.var_c11b16e0c17d7f14 )
        {
            br_public::brleaderdialogteam( "squad_wipe_streak_" + selected_entry.dialog, attacker.team, 1, 2.5, undefined, "dx_br_smis_" );
            
            if ( getdvarint( @"hash_30bdc56c2a2ef592", 1 ) )
            {
                logstring( "[SQUAD WIPE COMMON] Playing dialog: " + selected_entry.dialog + " to " + attacker.team );
            }
        }
    }
    
    if ( level.gametypebundle.var_5db06ed56b3edaa )
    {
        squad_wipe_shoot_flare( victim );
    }
    
    challenges::function_d2b9666e88748bb0( params.attacker, attacker_streak );
    function_599bd06f45ea28df( attacker_streak, victim_streak );
}

// Namespace squad_wipe_streak
// Params 1, eflags: 0x4
// Checksum 0x938290c5, Offset: 0xfb4
// Size: 0x101
function private function_586d3f997c420117( td_property )
{
    best_team = { #team:undefined, #streak:0 };
    
    foreach ( team in level.teamnamelist )
    {
        streak = level teams::getteamdata( team, "curr_" + td_property );
        
        if ( streak > 0 && streak > best_team.streak )
        {
            best_team.streak = streak;
            best_team.team = team;
        }
    }
    
    return best_team.streak > 0 ? best_team : undefined;
}

// Namespace squad_wipe_streak
// Params 1
// Checksum 0x224761af, Offset: 0x10be
// Size: 0xca
function squad_wipe_shoot_flare( victim )
{
    trace_height = 5000;
    var_bfd60cc8b96329a8 = killstreak_utility::getkillstreakairstrikeheightent();
    
    if ( isdefined( var_bfd60cc8b96329a8 ) )
    {
        trace_height = var_bfd60cc8b96329a8.origin[ 2 ];
    }
    
    contents = trace::create_contents( 0, 1, 1 );
    trace = trace::ray_trace( ( victim.origin[ 0 ], victim.origin[ 1 ], trace_height ), victim.origin, [ victim ], contents );
    outpos = trace[ "position" ] ?? victim.origin;
    utility::delaythread( 0.2, &function_2d2bfe6bff0ba19f, outpos );
}

// Namespace squad_wipe_streak
// Params 1, eflags: 0x4
// Checksum 0x695ee4a5, Offset: 0x1190
// Size: 0x26
function private function_2d2bfe6bff0ba19f( outpos )
{
    level endon( #"game_ended" );
    br_contract_manager::utilflare_shootflare( outpos, "elimination_flare" );
}

// Namespace squad_wipe_streak
// Params 2, eflags: 0x4
// Checksum 0x701ee3c, Offset: 0x11be
// Size: 0x64, Type: bool
function private function_9149b1f6d6757978( a, b )
{
    if ( !isdefined( a.br_eliminatedtime ) )
    {
        a.br_eliminatedtime = -1;
    }
    
    if ( !isdefined( b.br_eliminatedtime ) )
    {
        b.br_eliminatedtime = -1;
    }
    
    return a.br_eliminatedtime <= b.br_eliminatedtime;
}

// Namespace squad_wipe_streak
// Params 4, eflags: 0x4
// Checksum 0x8692c44, Offset: 0x122b
// Size: 0x11e
function private set_team_wipestreak( team, streak, td_property, notification )
{
    level endon( #"game_ended" );
    timer = get_wipestreak_timer();
    
    if ( level.gametypebundle.var_cef73dde709e6ce7 && streak > 1 )
    {
        timer += get_team_wipestreak_timer( team );
    }
    
    level thread function_baadcdb21b960eae( team, timer, td_property, notification );
    timer = int( gettime() + timer * 1000 );
    
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        player setclientomnvar( "ui_br_squad_wipe_streak_timer_end_ms", timer );
        player setclientomnvar( "ui_br_squad_wipe_streak_count", streak );
    }
}

// Namespace squad_wipe_streak
// Params 0, eflags: 0x4
// Checksum 0xb0cdbea8, Offset: 0x1351
// Size: 0x15
function private get_wipestreak_timer()
{
    return level.gametypebundle.var_aa6c25084772080a;
}

// Namespace squad_wipe_streak
// Params 1, eflags: 0x4
// Checksum 0xa421e525, Offset: 0x136f
// Size: 0xc8
function private get_team_wipestreak_timer( team )
{
    timer = 0;
    
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        timer = player getclientomnvar( "ui_br_squad_wipe_streak_timer_end_ms" );
        
        if ( timer > 0 )
        {
            timer -= gettime();
            timer *= 0.001;
            break;
        }
    }
    
    assert( timer > 0, "<dev string:xa7>" );
    return timer;
}

// Namespace squad_wipe_streak
// Params 4, eflags: 0x4
// Checksum 0xfe0fe130, Offset: 0x1440
// Size: 0x111
function private function_baadcdb21b960eae( team, time, td_property, notification )
{
    level endon( #"game_ended" );
    level endon( notification + "_" + team );
    level endon( "wipestreak_ended_" + team );
    level notify( "wipestreak_timer_" + team );
    level endon( "wipestreak_timer_" + team );
    wait time;
    
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        player setclientomnvar( "ui_br_squad_wipe_streak_timer_end_ms", 0 );
        player setclientomnvar( "ui_br_squad_wipe_streak_count", 0 );
    }
    
    level teams::setteamdata( team, "curr_" + td_property, 0 );
    level notify( "wipestreak_ended_" + team );
}

// Namespace squad_wipe_streak
// Params 1, eflags: 0x4
// Checksum 0x508af43e, Offset: 0x1559
// Size: 0xb8
function private register_team_data( params )
{
    foreach ( team in level.teamnamelist )
    {
        level.teamdata[ team ][ "squad_wipes" ] = 0;
        level.teamdata[ team ][ "curr_squad_wipes" ] = 0;
        level.teamdata[ team ][ "best_squad_wipes" ] = 0;
    }
}

// Namespace squad_wipe_streak
// Params 2, eflags: 0x4
// Checksum 0x64a3f86d, Offset: 0x1619
// Size: 0x3e
function private function_599bd06f45ea28df( attacker_streak, victim_streak )
{
    dlog_recordevent( "dlog_event_br_squad_wipe", [ "attacker_streak", attacker_streak, "victim_streak", victim_streak ] );
}

/#

    // Namespace squad_wipe_streak
    // Params 0
    // Checksum 0x1f98bf7c, Offset: 0x165f
    // Size: 0x7f, Type: dev
    function debug_init()
    {
        setdvarifuninitialized( @"hash_980df9696fd73176", get_wipestreak_timer() );
        devgui::function_9082edeb5db93280( "<dev string:xdf>" );
        devgui::add_devgui_func( "<dev string:xee>", "<dev string:x106>", &function_26472d97f393cdab );
        devgui::add_devgui_func( "<dev string:x122>", "<dev string:x13a>", &function_368da4e3f892abda );
        devgui::add_devgui_dvar( "<dev string:x14e>", "<dev string:x15f>" );
        devgui::add_devgui_func( "<dev string:x17f>", "<dev string:x18f>", &br_gametype_resurgence::disablerespawn );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace squad_wipe_streak
    // Params 0
    // Checksum 0x719a8453, Offset: 0x16e6
    // Size: 0x51, Type: dev
    function function_26472d97f393cdab()
    {
        shoot_pos = level.players[ 0 ].origin + anglestoforward( level.players[ 0 ].angles ) * 240;
        br_contract_manager::utilflare_shootflare( shoot_pos, "<dev string:x1a6>" );
    }

    // Namespace squad_wipe_streak
    // Params 0
    // Checksum 0xa02f16ea, Offset: 0x173f
    // Size: 0x132, Type: dev
    function function_368da4e3f892abda()
    {
        if ( !isdefined( level.teamdata[ level.players[ 0 ].team ][ "<dev string:x1b8>" ] ) )
        {
            setdvar( @"hash_6ffa7b0113bccfb7", 0 );
            register_team_data();
        }
        
        player = level.players[ 0 ];
        
        foreach ( player in level.players )
        {
            if ( !player ishost() )
            {
                break;
            }
        }
        
        assert( !player ishost(), "<dev string:x1c4>" );
        player.attacker = level.players[ 0 ];
        params = { #victim:player, #attackers:[ level.players[ 0 ] ] };
        on_squad_wiped( params );
    }

#/
