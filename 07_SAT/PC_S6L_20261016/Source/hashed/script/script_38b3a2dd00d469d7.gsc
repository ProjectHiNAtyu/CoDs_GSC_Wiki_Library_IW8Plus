// script_38b3a2dd00d469d7  (hash_38b3a2dd00d469d7.gscc) (size: 10805 Bytes / 0x2a35 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfe17570e (4262942478)
// size ...... 10805 (0x2a35)
// includes .. 13  (offset: 0x27f5)
// strings ... 8   (offset: 0x285d)
// dev strs .. 25  (offset: 0x2901)
// exports ... 31  (offset: 0x1b0d)
// cseg ...... 0xe9 + 0x1a24 (0x1b0d)
// imports ... 66  (offset: 0x1fe5)
// animtree1 . 0   (offset: 0x2a35)
// animtree2 . 0   (offset: 0x2a35)
#using script_691d79163b791604;
#using script_7c4db7d2697593e7;
#using scripts\common\devgui;
#using scripts\common\gameplay_sound_fx;
#using scripts\common\utility;
#using scripts\mp\common\utility\dialog;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\team_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;
#using scripts\mp\gamescore;
#using scripts\mp\hud_message;

#namespace namespace_65703d98c062a7d0;

// Namespace namespace_65703d98c062a7d0
// Params 0
// Checksum 0x76f031ec, Offset: 0x107
// Size: 0xae
function function_ed593bc5a05a19eb()
{
    if ( level.var_1304fc1c8fb51e7b )
    {
        return;
    }
    
    level.var_1304fc1c8fb51e7b = { #var_612b971b8b1c862f:undefined, #var_553aab4d2c8eb9f3:level.var_4e147a96a4a5740d.var_553aab4d2c8eb9f3 ?? 1, #var_9677e94dfea80783:level.var_4e147a96a4a5740d.var_9677e94dfea80783 ?? 1, #taskduration:level.var_4e147a96a4a5740d.taskduration ?? 120, #active:undefined, #var_4b15be3c28955f3d:[], #pool:[], #tasks:[] };
}

// Namespace namespace_65703d98c062a7d0
// Params 2
// Checksum 0x58677222, Offset: 0x1bd
// Size: 0x57
function function_2a85d7cbd3e7f496( player, var_248ed9bc63655911 )
{
    if ( !player || !isplayer( player ) )
    {
        return;
    }
    
    player setclientomnvar( o"hash_90203f5667c6f5ec", var_248ed9bc63655911 ?? 0 );
    player setclientomnvar( "ui_clash_ops_task_completed", 0 );
    player setclientomnvar( "ui_clash_ops_task_failed", 0 );
}

// Namespace namespace_65703d98c062a7d0
// Params 1
// Checksum 0xfb6291ac, Offset: 0x21c
// Size: 0xa5
function function_e2df64b463ccd208( var_248ed9bc63655911 )
{
    foreach ( player in level.players )
    {
        function_2a85d7cbd3e7f496( player, var_248ed9bc63655911 );
        
        if ( var_248ed9bc63655911 && var_248ed9bc63655911 > 0 )
        {
            player thread hud_message::showsplash( #"hash_c24aef19e19686e9" );
        }
    }
}

// Namespace namespace_65703d98c062a7d0
// Params 2
// Checksum 0xa68496ff, Offset: 0x2c9
// Size: 0x93
function function_b6c9a99e105db370( team, task = level.var_1304fc1c8fb51e7b.active )
{
    if ( team == "allies" )
    {
        teamomnvar = o"hash_f44058e4e81218f5";
    }
    else if ( team == "axis" )
    {
        teamomnvar = o"hash_6c841dccb6949fae";
    }
    
    if ( !teamomnvar )
    {
        return;
    }
    
    progress = task.teamprogress[ team ] ?? 0;
    setomnvar( teamomnvar, progress );
}

// Namespace namespace_65703d98c062a7d0
// Params 2
// Checksum 0x82fba897, Offset: 0x364
// Size: 0x16b
function register_task( taskreference, settings )
{
    function_ed593bc5a05a19eb();
    assert( taskreference, "<dev string:x24>" );
    assert( settings, "<dev string:x56>" );
    
    if ( level.var_1304fc1c8fb51e7b.tasks[ taskreference ] )
    {
        assertmsg( "<dev string:x82>" );
        return;
    }
    
    taskdefinition = { #var_35984ea168f26cc6:settings.var_a0b28827c4a84871 ?? 500, #eliminationfilter:settings.eliminationfilter, #eliminationtype:settings.eliminationtype, #description:settings.description, #title:settings.title, #weight:settings.var_d510f1926ab220cf ?? 1, #timelimit:settings.defaulttimelimit ?? level.var_1304fc1c8fb51e7b.taskduration, #scoretarget:settings.var_a689daceff70fb12 ?? 25, #callbacks:settings.callbacks, #taskreference:taskreference };
    level.var_1304fc1c8fb51e7b.tasks[ taskreference ] = taskdefinition;
}

// Namespace namespace_65703d98c062a7d0
// Params 0
// Checksum 0x31147a83, Offset: 0x4d7
// Size: 0x4a
function start()
{
    function_ed593bc5a05a19eb();
    buildpool();
    
    if ( level.var_1304fc1c8fb51e7b.pool.size == 0 )
    {
        assertmsg( "<dev string:xbd>" );
        return;
    }
    
    /#
        level thread function_923ba1180ef69e02();
    #/
    
    level thread runmatch();
}

// Namespace namespace_65703d98c062a7d0
// Params 0
// Checksum 0xc74eac9e, Offset: 0x529
// Size: 0x273
function buildpool()
{
    level.var_1304fc1c8fb51e7b.pool = [];
    
    if ( level.var_4e147a96a4a5740d.tasklist )
    {
        var_248ed9bc63655911 = 1;
        
        foreach ( entry in level.var_4e147a96a4a5740d.tasklist )
        {
            taskdefinition = level.var_1304fc1c8fb51e7b.tasks[ entry.taskreference ];
            assert( taskdefinition, "<dev string:x11c>" + entry.taskreference );
            poolentry = { #eliminationfilter:entry.eliminationfilter ?? taskdefinition.eliminationfilter, #eliminationtype:entry.eliminationtype ?? taskdefinition.eliminationtype, #description:entry.descriptionstring ?? taskdefinition.description, #title:entry.titlestring ?? taskdefinition.title, #var_248ed9bc63655911:var_248ed9bc63655911, #weight:entry.weight ?? taskdefinition.weight, #timelimit:entry.timelimitoverride ?? taskdefinition.timelimit, #var_35984ea168f26cc6:entry.var_35984ea168f26cc6 ?? taskdefinition.var_35984ea168f26cc6, #scoretarget:entry.scoretarget ?? taskdefinition.scoretarget, #callbacks:taskdefinition.callbacks, #taskreference:taskdefinition.taskreference };
            level.var_1304fc1c8fb51e7b.pool[ level.var_1304fc1c8fb51e7b.pool.size ] = poolentry;
            var_248ed9bc63655911++;
        }
    }
}

// Namespace namespace_65703d98c062a7d0
// Params 1
// Checksum 0x1252bc9b, Offset: 0x7a4
// Size: 0x9a
function function_6016e687fa78e592( var_248ed9bc63655911 )
{
    foreach ( entry in level.var_1304fc1c8fb51e7b.pool )
    {
        if ( entry.var_248ed9bc63655911 == var_248ed9bc63655911 )
        {
            return entry;
        }
    }
}

// Namespace namespace_65703d98c062a7d0
// Params 0
// Checksum 0xdfc6bf0e, Offset: 0x847
// Size: 0x62
function runmatch()
{
    level endon( #"game_ended" );
    flags::gameflagwait( "prematch_values_reset" );
    level.dogtagsenabled = undefined;
    
    while ( !level.gameended )
    {
        /#
            function_7513e89d91b57aac();
        #/
        
        task = function_c68f7b5aca9c375a();
        
        if ( !task )
        {
            break;
        }
        
        function_7923e6db55b12da2( task );
    }
}

// Namespace namespace_65703d98c062a7d0
// Params 0
// Checksum 0xf0d7bf1c, Offset: 0x8b1
// Size: 0x2b0
function function_c68f7b5aca9c375a()
{
    forcedtask = function_6016e687fa78e592( level.var_1304fc1c8fb51e7b.var_e5f5d49ac1e3f0fe );
    
    if ( forcedtask )
    {
        level.var_1304fc1c8fb51e7b.var_e5f5d49ac1e3f0fe = undefined;
        level.var_1304fc1c8fb51e7b.var_4b15be3c28955f3d[ level.var_1304fc1c8fb51e7b.var_4b15be3c28955f3d.size ] = forcedtask.var_248ed9bc63655911;
        function_e2df64b463ccd208( forcedtask.var_248ed9bc63655911 );
        return forcedtask;
    }
    
    candidates = [];
    weights = [];
    
    foreach ( entry in level.var_1304fc1c8fb51e7b.pool )
    {
        if ( entry.weight == 0 )
        {
            continue;
        }
        
        if ( arraycontains( level.var_1304fc1c8fb51e7b.var_4b15be3c28955f3d, entry.var_248ed9bc63655911 ) )
        {
            continue;
        }
        
        candidates[ candidates.size ] = entry;
        weights[ weights.size ] = entry.weight;
    }
    
    if ( candidates.size == 0 )
    {
        foreach ( entry in level.var_1304fc1c8fb51e7b.pool )
        {
            if ( entry.weight == 0 )
            {
                continue;
            }
            
            if ( entry.var_248ed9bc63655911 == utility::function_f1933af772476229( level.var_1304fc1c8fb51e7b.var_4b15be3c28955f3d ) )
            {
                continue;
            }
            
            candidates[ candidates.size ] = entry;
            weights[ weights.size ] = entry.weight;
        }
        
        level.var_1304fc1c8fb51e7b.var_4b15be3c28955f3d = [];
    }
    
    if ( candidates.size == 0 )
    {
        return;
    }
    
    chosen = utility::random_weighted( candidates, weights );
    level.var_1304fc1c8fb51e7b.var_4b15be3c28955f3d[ level.var_1304fc1c8fb51e7b.var_4b15be3c28955f3d.size ] = chosen.var_248ed9bc63655911;
    function_e2df64b463ccd208( chosen.var_248ed9bc63655911 );
    return chosen;
}

// Namespace namespace_65703d98c062a7d0
// Params 1
// Checksum 0xd3379529, Offset: 0xb6a
// Size: 0x1ff
function function_7923e6db55b12da2( task )
{
    level.var_1304fc1c8fb51e7b.active = task;
    task.teamprogress = [];
    
    foreach ( team in level.teamnamelist )
    {
        task.teamprogress[ team ] = 0;
        function_b6c9a99e105db370( team, task );
    }
    
    task.starttime = gettime();
    timelimitms = utility::function_4b74c15943231980( task.timelimit );
    setomnvar( o"hash_39915d803edd1647", task.starttime + int( timelimitms ) );
    
    if ( task.callbacks.begin )
    {
        [[ task.callbacks.begin ]]( task );
    }
    
    gameplay_sound_fx::function_e319dc8e16c85fcb( #"hash_2c095264500886f5", level.players );
    level childthread function_3bf5c5d2a5598bd( task );
    level utility::waittill_notify_or_timeout( #"hash_974fecacc94e1b75", task.timelimit );
    
    if ( task.callbacks.end )
    {
        [[ task.callbacks.end ]]( task );
    }
    
    level notify( #"hash_974fecacc94e1b75" );
    winner = function_fa09a5d8a33e7dd1( task );
    awardoutcome( task, winner );
    wait 0.5;
    function_e2df64b463ccd208( 0 );
    setomnvar( o"hash_39915d803edd1647", 0 );
    level.var_1304fc1c8fb51e7b.active = undefined;
}

// Namespace namespace_65703d98c062a7d0
// Params 1
// Checksum 0x9917f812, Offset: 0xd71
// Size: 0x66
function function_3bf5c5d2a5598bd( task )
{
    level endon( #"hash_974fecacc94e1b75", #"game_ended" );
    assert( task.timelimit - 30 > 0, "<dev string:x155>" );
    wait task.timelimit - 30;
    dialog::leaderdialogonplayers( #"hash_aad402724ea6b034", level.players );
}

// Namespace namespace_65703d98c062a7d0
// Params 2
// Checksum 0x29726e4, Offset: 0xddf
// Size: 0x247
function function_3e454447aae37e67( team, amount = 1 )
{
    if ( !level.var_1304fc1c8fb51e7b.active || !team )
    {
        return;
    }
    
    if ( isplayer( self ) )
    {
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
        {
            if ( isdefined( self.leaderboarddata[ "trialPoints" ] ) )
            {
                self.leaderboarddata[ "trialPoints" ] = self.leaderboarddata[ "trialPoints" ] + 1;
            }
            
            if ( isdefined( level.leaderboardfunc[ "trialPoints" ] ) )
            {
                [[ level.leaderboardfunc[ "trialPoints" ] ]]( self, 1 );
            }
            
            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x199>" );
            
            if ( isdefined( self.pers[ "trialPoints" ] ) )
            {
                self.pers[ "trialPoints" ] = self.pers[ "trialPoints" ] + 1;
            }
        }
        
        stats::setextrascore0( self.pers[ "trialPoints" ], "trialPoints" );
        gameplay_sound_fx::playlocalsoundfx( #"hash_fd6947a198eb2093" );
        thread points::doscoreevent( level.var_4e147a96a4a5740d.taskscoreevent );
    }
    
    newscore = ( level.var_1304fc1c8fb51e7b.active.teamprogress[ team ] ?? 0 ) + amount;
    level.var_1304fc1c8fb51e7b.active.teamprogress[ team ] = min( level.var_1304fc1c8fb51e7b.active.scoretarget, newscore );
    function_b6c9a99e105db370( team, level.var_1304fc1c8fb51e7b.active );
    
    if ( level.var_1304fc1c8fb51e7b.active.teamprogress[ team ] >= level.var_1304fc1c8fb51e7b.active.scoretarget )
    {
        level notify( #"hash_974fecacc94e1b75" );
    }
    
    gamescore::giveteamscoreforobjective( team, amount, 0 );
}

// Namespace namespace_65703d98c062a7d0
// Params 1
// Checksum 0xf71161dd, Offset: 0x102e
// Size: 0xea
function function_fa09a5d8a33e7dd1( task )
{
    bestteam = undefined;
    bestvalue = -1;
    tie = 0;
    
    foreach ( team in level.teamnamelist )
    {
        value = task.teamprogress[ team ] ?? 0;
        
        if ( value > bestvalue )
        {
            bestvalue = value;
            bestteam = team;
            tie = 0;
            continue;
        }
        
        if ( value == bestvalue )
        {
            tie = 1;
        }
    }
    
    if ( tie || bestvalue <= 0 )
    {
        return;
    }
    
    return bestteam;
}

// Namespace namespace_65703d98c062a7d0
// Params 2
// Checksum 0x20d0c1d5, Offset: 0x1121
// Size: 0x2c1
function awardoutcome( task, winner )
{
    clash_ops_rewards::ensureinit();
    
    if ( winner )
    {
        winnerplayers = teams::getteamdata( winner, "players" );
        dialog::leaderdialogonplayers( #"trial_success", winnerplayers );
        clash_ops_rewards::function_1abc637181e4ab6c( winner, task );
        gameplay_sound_fx::function_e319dc8e16c85fcb( #"hash_1c98b2ac83635710", winnerplayers );
        
        foreach ( player in winnerplayers )
        {
            player thread hud_message::showsplash( #"hash_5d42f653d75c5dcc" );
            player setclientomnvar( "ui_clash_ops_task_completed", 1 );
        }
        
        loser = team_utility::getotherteam( winner );
        
        if ( loser )
        {
            loserplayers = teams::getteamdata( loser, "players" );
            gameplay_sound_fx::function_e319dc8e16c85fcb( #"hash_e323d123a6f386", loserplayers );
            dialog::leaderdialogonplayers( #"trial_failure", loserplayers );
            
            foreach ( player in loserplayers )
            {
                player thread hud_message::showsplash( #"hash_7022d24ad49b1b7d" );
                player setclientomnvar( "ui_clash_ops_task_failed", 1 );
            }
            
            clash_ops_punish::punish_team( loser );
            level.var_1304fc1c8fb51e7b.var_612b971b8b1c862f = loser;
        }
        
        return;
    }
    
    foreach ( team in level.teamnamelist )
    {
        gamescore::giveteamscoreforobjective( team, level.var_1304fc1c8fb51e7b.var_553aab4d2c8eb9f3, 1 );
        clash_ops_rewards::function_1abc637181e4ab6c( team, task );
    }
    
    if ( level.var_1304fc1c8fb51e7b.var_612b971b8b1c862f )
    {
        clash_ops_punish::punish_team( level.var_1304fc1c8fb51e7b.var_612b971b8b1c862f );
    }
    
    gameplay_sound_fx::function_e319dc8e16c85fcb( #"hash_34d42ac7541fb6e", level.players );
}

// Namespace namespace_65703d98c062a7d0
// Params 0
// Checksum 0xca7f9ef9, Offset: 0x13ea
// Size: 0x15
function function_8f24e9de882ebe79()
{
    return level.var_1304fc1c8fb51e7b.active;
}

// Namespace namespace_65703d98c062a7d0
// Params 1
// Checksum 0x5860b5d5, Offset: 0x1408
// Size: 0x82
function function_33744750fdce2ce( player )
{
    if ( !player.pers[ "trialPoints" ] )
    {
        if ( !isdefined( player.pers[ "trialPoints" ] ) )
        {
            player.pers[ "trialPoints" ] = 0;
        }
    }
    
    if ( !function_8f24e9de882ebe79() )
    {
        return;
    }
    
    clash_ops_rewards::onplayerconnect( player );
    function_2a85d7cbd3e7f496( player, level.var_1304fc1c8fb51e7b.active.var_248ed9bc63655911 );
}

// Namespace namespace_65703d98c062a7d0
// Params 2
// Checksum 0x5ef8e3ea, Offset: 0x1492
// Size: 0xdb
function function_44ac26ccf8918a7( player, spawndata )
{
    if ( !function_8f24e9de882ebe79() )
    {
        return;
    }
    
    clash_ops_rewards::onplayerspawn( player );
    function_2a85d7cbd3e7f496( player, level.var_1304fc1c8fb51e7b.active.var_248ed9bc63655911 );
    function_b6c9a99e105db370( "allies", level.var_1304fc1c8fb51e7b.active );
    function_b6c9a99e105db370( "axis", level.var_1304fc1c8fb51e7b.active );
    callbacks = level.var_1304fc1c8fb51e7b.active.callbacks;
    
    if ( callbacks.onspawn && player )
    {
        player thread [[ callbacks.onspawn ]]( spawndata );
    }
}

// Namespace namespace_65703d98c062a7d0
// Params 1
// Checksum 0x7a175294, Offset: 0x1575
// Size: 0x78
function function_bff624d5c128c599( deathdata )
{
    if ( !function_8f24e9de882ebe79() )
    {
        return;
    }
    
    callbacks = level.var_1304fc1c8fb51e7b.active.callbacks;
    
    if ( callbacks.onkilled && deathdata.victim )
    {
        deathdata.victim thread [[ callbacks.onkilled ]]( deathdata );
    }
}

// Namespace namespace_65703d98c062a7d0
// Params 2
// Checksum 0xfcb99672, Offset: 0x15f5
// Size: 0x6e
function function_58ed6f42d666abc7( player, damagedata )
{
    if ( !function_8f24e9de882ebe79() )
    {
        return;
    }
    
    callbacks = level.var_1304fc1c8fb51e7b.active.callbacks;
    
    if ( callbacks.ondamaged && player )
    {
        player thread [[ callbacks.ondamaged ]]( damagedata );
    }
}

// Namespace namespace_65703d98c062a7d0
// Params 2
// Checksum 0x7fa638ce, Offset: 0x166b
// Size: 0x6e
function function_658cc6d2c8ec3d2( player, disconnectdata )
{
    if ( !function_8f24e9de882ebe79() )
    {
        return;
    }
    
    callbacks = level.var_1304fc1c8fb51e7b.active.callbacks;
    
    if ( callbacks.ondisconnect && player )
    {
        player thread [[ callbacks.ondisconnect ]]( disconnectdata );
    }
}

/#

    // Namespace namespace_65703d98c062a7d0
    // Params 0
    // Checksum 0x6d84fdce, Offset: 0x16e1
    // Size: 0x140, Type: dev
    function function_923ba1180ef69e02()
    {
        level endon( #"game_ended" );
        wait 0.5;
        devgui::function_9082edeb5db93280( "<dev string:x1bf>" );
        devgui::add_devgui_func( "<dev string:x1e0>", "<dev string:x1f1>", &function_e4fe13cbfec396ff );
        devgui::add_devgui_func( "<dev string:x20a>", "<dev string:x21d>", &function_c53c0cb2fd6e96fc );
        devgui::add_devgui_func( "<dev string:x238>", "<dev string:x251>", &function_e708e623dad233e0 );
        devgui::add_devgui_func( "<dev string:x272>", "<dev string:x289>", &function_8b5efa0720db9bad );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x2a8>" );
        
        foreach ( task in level.var_1304fc1c8fb51e7b.pool )
        {
            devgui::function_cd4e263c1f3018ae( function_255ceaf2f2644789( task ), "<dev string:x2ca>" + task.var_248ed9bc63655911, &function_6fd13f78f02673b1, 0, task.var_248ed9bc63655911 );
        }
        
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_65703d98c062a7d0
    // Params 1
    // Checksum 0x6eff220c, Offset: 0x1829
    // Size: 0x87, Type: dev
    function function_255ceaf2f2644789( task )
    {
        if ( isxhash( task.taskreference ) )
        {
            return ( "<dev string:x2e0>" + task.var_248ed9bc63655911 + "<dev string:x2e2>" + getxhashsourcename( task.taskreference ) + "<dev string:x2e5>" + ( task.eliminationtype ? getxhashsourcename( task.eliminationtype ) : "<dev string:x2e9>" ) );
        }
        
        return "<dev string:x2ed>" + task.var_248ed9bc63655911;
    }

    // Namespace namespace_65703d98c062a7d0
    // Params 0
    // Checksum 0x614da823, Offset: 0x18b8
    // Size: 0x59, Type: dev
    function function_7513e89d91b57aac()
    {
        var_e5f5d49ac1e3f0fe = getdvarint( @"hash_f4c058fa5c0668ab", 0 );
        
        if ( var_e5f5d49ac1e3f0fe <= 0 )
        {
            return;
        }
        
        if ( !function_6016e687fa78e592( var_e5f5d49ac1e3f0fe ) )
        {
            return;
        }
        
        level.var_1304fc1c8fb51e7b.var_e5f5d49ac1e3f0fe = var_e5f5d49ac1e3f0fe;
        setdvar( @"hash_f4c058fa5c0668ab", 0 );
    }

    // Namespace namespace_65703d98c062a7d0
    // Params 0
    // Checksum 0xb76ca05, Offset: 0x1919
    // Size: 0x11, Type: dev
    function function_e4fe13cbfec396ff()
    {
        function_57f1fb9dc50f71db( "<dev string:x2f3>" );
    }

    // Namespace namespace_65703d98c062a7d0
    // Params 0
    // Checksum 0x8b34834e, Offset: 0x1932
    // Size: 0x11, Type: dev
    function function_c53c0cb2fd6e96fc()
    {
        function_57f1fb9dc50f71db( "<dev string:x2f8>" );
    }

    // Namespace namespace_65703d98c062a7d0
    // Params 0
    // Checksum 0x865b2887, Offset: 0x194b
    // Size: 0x14, Type: dev
    function function_e708e623dad233e0()
    {
        gamescore::giveteamscoreforobjective( "<dev string:x2f8>", 20, 0 );
    }

    // Namespace namespace_65703d98c062a7d0
    // Params 0
    // Checksum 0x319f2668, Offset: 0x1967
    // Size: 0x14, Type: dev
    function function_8b5efa0720db9bad()
    {
        gamescore::giveteamscoreforobjective( "<dev string:x2f3>", 20, 0 );
    }

    // Namespace namespace_65703d98c062a7d0
    // Params 1
    // Checksum 0x4dfcdf8f, Offset: 0x1983
    // Size: 0x10d, Type: dev
    function function_57f1fb9dc50f71db( team )
    {
        if ( !level.var_1304fc1c8fb51e7b.active )
        {
            return;
        }
        
        foreach ( teamname in level.teamnamelist )
        {
            if ( teamname == team )
            {
                level.var_1304fc1c8fb51e7b.active.teamprogress[ teamname ] = level.var_1304fc1c8fb51e7b.active.scoretarget;
                continue;
            }
            
            level.var_1304fc1c8fb51e7b.active.teamprogress[ teamname ] = 0;
        }
        
        level notify( #"hash_974fecacc94e1b75" );
    }

    // Namespace namespace_65703d98c062a7d0
    // Params 1
    // Checksum 0x68c2bd9d, Offset: 0x1a98
    // Size: 0x75, Type: dev
    function function_6fd13f78f02673b1( params )
    {
        var_248ed9bc63655911 = int( params[ 0 ] );
        task = function_6016e687fa78e592( var_248ed9bc63655911 );
        
        if ( !task )
        {
            return;
        }
        
        level.var_1304fc1c8fb51e7b.var_e5f5d49ac1e3f0fe = var_248ed9bc63655911;
        
        if ( !level.var_1304fc1c8fb51e7b.active )
        {
            return;
        }
        
        level notify( #"hash_974fecacc94e1b75" );
    }

#/
