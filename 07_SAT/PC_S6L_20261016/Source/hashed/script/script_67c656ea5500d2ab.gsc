// script_67c656ea5500d2ab  (hash_67c656ea5500d2ab.gscc) (size: 19668 Bytes / 0x4cd4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1689e68a (378136202)
// size ...... 19668 (0x4cd4)
// includes .. 26  (offset: 0x46cc)
// strings ... 77  (offset: 0x479c)
// dev strs .. 9   (offset: 0x4c64)
// exports ... 50  (offset: 0x2bb4)
// cseg ...... 0x659 + 0x255b (0x2bb4)
// imports ... 160 (offset: 0x3384)
// animtree1 . 0   (offset: 0x4cd4)
// animtree2 . 0   (offset: 0x4cd4)
#using scripts\common\callbacks;
#using scripts\common\gameplay_sound_fx;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\class;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\teams;
#using scripts\mp\equipment;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gameobjects;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\common;
#using scripts\mp\gametypes\prop_util;
#using scripts\mp\globallogic;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\playerlogic;
#using scripts\mp\potg_events;
#using scripts\mp\spawnlogic;

#namespace prop;

// Namespace prop
// Params 0
// Checksum 0x929c6490, Offset: 0x677
// Size: 0x2c4
function main()
{
    if ( getdvar( @"g_mapname" ) == "mp_background" )
    {
        return;
    }
    
    prop_util::function_12dcd008b74a0e45();
    globallogic::init();
    globallogic::setupcallbacks();
    allowed[ 0 ] = game_utility::getgametype();
    gameobjects::main( allowed );
    level.initializematchrules = &game_utility_mp::setcommonrulesfrommatchrulesdata;
    [[ level.initializematchrules ]]();
    level thread game_utility_mp::reinitializematchrulesonmigration();
    common::updatecommongametypedvars();
    callback::add( #"player_spawned", &onspawnplayer );
    callback::add( #"player_death", &onplayerkilled );
    callback::add( #"player_disconnect", &onplayerdisconnect );
    utility::registersharedfunc( #"gametype", #"hash_2bfe88f2d50ff4f7", &function_878289be1d60dbb4 );
    utility::registersharedfunc( #"gametype", #"hash_3f9e7bc9e02f07f7", &function_72c4e4db16ec4ef2 );
    utility::registersharedfunc( #"gametype", #"hash_1cf4167243c9f468", &function_cf15333f745b6cf3 );
    utility::registersharedfunc( #"gametype", #"hash_c2d2d66fa9cdd850", &function_27f9ac3cda6d90bd );
    utility::registersharedfunc( #"gametype", #"hash_db8eabfea7043529", &function_700d838b3b9d9028 );
    utility::registersharedfunc( #"gametype", #"hash_f402b2e32efea4e", &function_622661667a61aaf1 );
    utility::registersharedfunc( #"gametype", #"hash_484850a23fcf55a8", &function_1f3d2436a2463a6f );
    utility::registersharedfunc( #"gametype", #"hash_8c57259192ca7aac", &function_8d78ded8905568d9 );
    utility::registersharedfunc( #"gametype", #"hash_1355093053aab9db", &function_22083e765aa81ca );
    level.teambased = 1;
    level.denyclasschoice = 1;
    level.allowlatecomers = 0;
    level.isprophunt = 1;
    level.var_6888ad4cb966ea89 = 0;
    level.onstartgametype = &onstartgametype;
    level.ontimelimit = &ontimelimit;
    level.getspawnpoint = &getspawnpoint;
    level.onplayerconnect = &onplayerconnect;
    level.modifyplayerdamage = &modifyplayerdamage;
    level.bypassclasschoicefunc = &class::alwaysgamemodeclass;
    level.modeonteamchangedeath = &modeonteamchangedeath;
    level.var_760bf54d2dd70c96 = &function_9b636ef0a653bda8;
    utility::registersharedfunc( #"gametype", #"hash_eac27f8466f4fff2", &function_33156af08e927a34 );
    level.skipdefendersadvantage = 1;
    prop_util::function_98c109222275e806();
    initloadouts();
    callback::add( #"hash_57a74c8771bf7e7", &function_39614c5749ce5e0c );
    
    /#
        setdvarifuninitialized( @"hash_59db1a275cca6db3", 0 );
    #/
}

// Namespace prop
// Params 0, eflags: 0x4
// Checksum 0x918e6b5b, Offset: 0x943
// Size: 0x72
function private function_878289be1d60dbb4()
{
    self allowspectateteam( game[ "attackers" ], 1 );
    thread function_77671bf5c56ad00b();
    isrespawn = istrue( self.var_cdd796b8829a3b3b );
    
    if ( !isrespawn )
    {
        alivecount = teams::getteamdata( self.team, "teamCount" );
        setomnvar( o"ui_axis_alive", alivecount );
        setomnvar( o"ui_axis_lives_remaining", alivecount );
    }
}

// Namespace prop
// Params 0, eflags: 0x4
// Checksum 0xa874af46, Offset: 0x9bd
// Size: 0xd
function private function_72c4e4db16ec4ef2()
{
    self clearsoundsubmix( "mp_cer_prophunt_ally" );
}

// Namespace prop
// Params 0, eflags: 0x4
// Checksum 0x850dd23b, Offset: 0x9d2
// Size: 0x21
function private function_cf15333f745b6cf3()
{
    if ( !level.hide_phase_over )
    {
        self.prop function_5267efca3cdd0656( 1 );
    }
}

// Namespace prop
// Params 0, eflags: 0x4
// Checksum 0x5daccc1b, Offset: 0x9fb
// Size: 0x18
function private function_27f9ac3cda6d90bd()
{
    if ( !level.hide_phase_over )
    {
        function_5267efca3cdd0656( 1 );
    }
}

// Namespace prop
// Params 0, eflags: 0x4
// Checksum 0xc913ae0d, Offset: 0xa1b
// Size: 0xb
function private function_700d838b3b9d9028()
{
    return level.hide_phase_over;
}

// Namespace prop
// Params 0, eflags: 0x4
// Checksum 0xd9131f4c, Offset: 0xa2f
// Size: 0xb
function private function_622661667a61aaf1()
{
    return level.hide_phase_over;
}

// Namespace prop
// Params 0
// Checksum 0x25d73352, Offset: 0xa43
// Size: 0x1af
function onstartgametype()
{
    setclientnamemode( "auto_change" );
    setomnvar( o"ui_allies_no_respawn", 0 );
    setomnvar( o"ui_axis_no_respawn", 0 );
    level.var_7b282ffc18c488c[ game[ "defenders" ] ] = 0;
    level.var_7b282ffc18c488c[ game[ "attackers" ] ] = 0;
    level.var_a4f3d2c6830fb589 = 1;
    
    if ( !isdefined( game[ "switchedsides" ] ) )
    {
        game[ "switchedsides" ] = 0;
    }
    
    if ( game[ "switchedsides" ] )
    {
        oldattackers = game[ "attackers" ];
        olddefenders = game[ "defenders" ];
        game[ "attackers" ] = olddefenders;
        game[ "defenders" ] = oldattackers;
    }
    
    setomnvar( o"ui_prop_team", teams::getteamindex( game[ "defenders" ] ) );
    
    foreach ( entry in level.teamnamelist )
    {
        game_utility_mp::setobjectivetext( entry, &"objectives/prop" );
        
        if ( level.splitscreen )
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/prop" );
        }
        else
        {
            game_utility_mp::setobjectivescoretext( entry, &"objectives/prop_score" );
        }
        
        game_utility_mp::setobjectivehinttext( entry, &"hash_727e930e490e3c66" );
    }
    
    prop_util::populateproplist();
    initspawns();
    thread function_602207dd4d739af2();
    
    /#
        thread function_d6eb479c4a64dfe5();
    #/
}

// Namespace prop
// Params 0
// Checksum 0xf87f31e4, Offset: 0xbfa
// Size: 0x1cd
function function_602207dd4d739af2()
{
    level endon( #"game_ended" );
    level endon( #"round_end" );
    flags::gameflagwait( "prematch_done" );
    gamelogic_mp::pausetimer();
    level.hide_countdown = int( level.prop_bundle.hidetime * 1000 + gettime() );
    setomnvar( o"ui_bomb_timer_endtime", level.hide_countdown );
    level.hide_phase_over = 0;
    
    foreach ( player in level.players )
    {
        player.var_6d89c2f8dc182811 = 0;
        player thread function_6e0b5483824874ac();
    }
    
    thread function_acee9f3b1192605d();
    counttime = int( level.prop_bundle.hidetime );
    
    if ( game[ "roundsPlayed" ] == 0 )
    {
        var_99c8b6c1e54024c2 = 5;
        
        if ( var_99c8b6c1e54024c2 > 0 )
        {
            counttime -= var_99c8b6c1e54024c2;
            wait var_99c8b6c1e54024c2;
        }
    }
    
    countdownendtime = gettime() + counttime * 1000;
    waitframe();
    setomnvar( o"ui_prop_start_countdown_endtime", countdownendtime );
    wait counttime;
    setomnvar( o"ui_prop_start_countdown_endtime", 0 );
    level.hide_phase_over = 1;
    level notify( #"hideCompleted" );
    function_571e64bb747aec49();
    thread prop_util::function_f61dfd9ba88dc237();
    thread prop_util::function_49b508ed4917d47a();
    thread function_d1b695629b9629c4();
    thread function_341d3890eec242ad();
    thread function_4577488520c7406c();
    gamelogic_mp::resumetimer();
}

// Namespace prop
// Params 0
// Checksum 0xbd808487, Offset: 0xdcf
// Size: 0x4a
function function_acee9f3b1192605d()
{
    wait 0.25;
    setomnvar( o"ui_match_timer_hidden", 1 );
    utility::waittill_any_timeout( int( level.prop_bundle.hidetime ), "hideCompleted" );
    setomnvar( o"ui_match_timer_hidden", 0 );
}

// Namespace prop
// Params 0
// Checksum 0x38facb83, Offset: 0xe21
// Size: 0x208
function function_6e0b5483824874ac()
{
    level endon( #"game_ended" );
    level endon( #"round_end" );
    self endon( #"death_or_disconnect" );
    var_1f3d2436a2463a6f = function_1f3d2436a2463a6f();
    
    if ( !isdefined( level.hide_phase_over ) || level.hide_phase_over )
    {
        return;
    }
    
    if ( !var_1f3d2436a2463a6f )
    {
        function_aa3923f0c8c09841( 1 );
        
        foreach ( player in teams::getteamdata( game[ "defenders" ], "players" ) )
        {
            if ( isdefined( player.prop ) )
            {
                player.prop hidefromplayer( self );
            }
        }
    }
    else if ( isdefined( self.prop ) )
    {
        self.prop function_5267efca3cdd0656( 1 );
    }
    
    if ( level.hide_countdown > gettime() )
    {
        level utility::waittill_any_timeout( ( level.hide_countdown - gettime() ) * 0.001, "hideCompleted" );
    }
    
    if ( !var_1f3d2436a2463a6f )
    {
        function_aa3923f0c8c09841( 0 );
        return;
    }
    
    if ( isdefined( self.prop ) )
    {
        self.prop function_5267efca3cdd0656( 0 );
        
        if ( isdefined( self.propclones ) )
        {
            foreach ( clone in self.propclones )
            {
                if ( isdefined( clone ) )
                {
                    clone function_5267efca3cdd0656( 0 );
                }
            }
        }
    }
}

// Namespace prop
// Params 0
// Checksum 0x5bda1cbb, Offset: 0x1031
// Size: 0x112
function function_4577488520c7406c()
{
    level endon( #"game_ended" );
    level endon( #"round_end" );
    
    if ( level.prop_bundle.proproundendoutlineduration == 0 )
    {
        return;
    }
    
    timeleft = gamelogic_mp::gettimeremaining();
    
    if ( timeleft < level.prop_bundle.proproundendoutlineduration )
    {
        return;
    }
    
    waittime = timeleft / 1000 - level.prop_bundle.proproundendoutlineduration;
    wait waittime;
    
    foreach ( player in level.players )
    {
        if ( player function_1f3d2436a2463a6f() && isalive( player ) )
        {
            player function_67f12c01e52cad93();
        }
    }
}

// Namespace prop
// Params 0
// Checksum 0x6fa45708, Offset: 0x114b
// Size: 0x51
function function_67f12c01e52cad93()
{
    level endon( #"game_ended" );
    outlineid = outline::outlineenableforteam( self.prop, game[ "attackers" ], "outline_nodepth_red", "level_script" );
    self waittill( #"death_or_disconnect" );
    outline::outlinedisable( outlineid, self );
}

// Namespace prop
// Params 1
// Checksum 0x2f31ebe9, Offset: 0x11a4
// Size: 0x1e, Type: bool
function function_edf057d322fcc06a( player )
{
    return player function_1f3d2436a2463a6f() && isalive( player );
}

// Namespace prop
// Params 0
// Checksum 0x19e00da2, Offset: 0x11cb
// Size: 0x19f
function function_d1b695629b9629c4()
{
    level endon( #"game_ended" );
    level endon( #"round_end" );
    
    while ( true )
    {
        wait 1;
        
        foreach ( player in level.players )
        {
            if ( function_edf057d322fcc06a( player ) )
            {
                if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
                {
                    if ( isdefined( player.leaderboarddata[ "prop_obj_time" ] ) )
                    {
                        player.leaderboarddata[ "prop_obj_time" ] = player.leaderboarddata[ "prop_obj_time" ] + 1;
                    }
                    
                    if ( isdefined( level.leaderboardfunc[ "prop_obj_time" ] ) )
                    {
                        [[ level.leaderboardfunc[ "prop_obj_time" ] ]]( player, 1 );
                    }
                    
                    assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
                    
                    if ( isdefined( player.pers[ "prop_obj_time" ] ) )
                    {
                        player.pers[ "prop_obj_time" ] = player.pers[ "prop_obj_time" ] + 1;
                    }
                }
                
                player stats::setextrascore0( player.pers[ "prop_obj_time" ], "prop_obj_time" );
            }
        }
    }
}

// Namespace prop
// Params 1
// Checksum 0x768750a8, Offset: 0x1372
// Size: 0xaa
function function_5267efca3cdd0656( shouldhide )
{
    foreach ( player in level.players )
    {
        if ( player.team == game[ "attackers" ] )
        {
            if ( shouldhide )
            {
                self hidefromplayer( player );
                continue;
            }
            
            self showtoplayer( player );
        }
    }
}

// Namespace prop
// Params 1
// Checksum 0xa6faf6b2, Offset: 0x1424
// Size: 0xb0
function function_aa3923f0c8c09841( lock )
{
    if ( lock )
    {
        val::set( "prop_hide_phase", "allow_movement", 0 );
        val::set( "prop_hide_phase", "allow_jump", 0 );
        val::set( "prop_hide_phase", "sprint", 0 );
        val::set( "prop_hide_phase", "melee", 0 );
        val::set( "prop_hide_phase", "lean", 0 );
        val::set( "prop_hide_phase", "slide", 0 );
        val::set( "prop_hide_phase", "offhand_secondary_weapons", 0 );
        val::set( "prop_hide_phase", "usability", 0 );
        return;
    }
    
    val::reset_all( "prop_hide_phase" );
}

// Namespace prop
// Params 0
// Checksum 0x20802849, Offset: 0x14dc
// Size: 0x1cd
function function_341d3890eec242ad()
{
    level endon( #"game_ended" );
    level endon( #"round_end" );
    whistledelay = level.prop_bundle.whistledelay;
    var_17c94075d8e4c2f3 = int( whistledelay * 1000 );
    players = level.players;
    mapcenter = level.mapcenter;
    var_b120dabd35820f2d = level.prop_bundle.var_b120dabd35820f2d;
    var_2fc6a3f83de2cc55 = level.prop_bundle.var_2fc6a3f83de2cc55;
    var_b4639097b2d8de8e = 0;
    
    while ( true )
    {
        var_b4639097b2d8de8e = 0;
        whistleendtime = var_17c94075d8e4c2f3 + gettime();
        waitframe();
        setomnvar( o"ui_whistle_timer_endtime", whistleendtime );
        wait whistledelay;
        setomnvar( o"ui_whistle_timer_endtime", 0 );
        sortedplayers = sortbydistance( players, mapcenter );
        
        foreach ( player in sortedplayers )
        {
            if ( !isdefined( player ) )
            {
                continue;
            }
            
            if ( player function_1f3d2436a2463a6f() && isalive( player ) )
            {
                gameplay_sound_fx::function_28103d3430792dce( player.origin + ( 0, 0, 60 ), #"prop_whistle" );
                var_b4639097b2d8de8e++;
                
                if ( var_b4639097b2d8de8e >= var_b120dabd35820f2d )
                {
                    var_b4639097b2d8de8e = 0;
                    hostmigration::waitlongdurationwithhostmigrationpause( var_2fc6a3f83de2cc55 );
                }
            }
        }
    }
}

// Namespace prop
// Params 1
// Checksum 0x6306e5da, Offset: 0x16b1
// Size: 0x3a
function onplayerconnect( player )
{
    player class::function_e84a99f0f4904c66();
    player.pers[ "gamemodeLoadout" ] = level.proploadouts[ #"prop" ];
}

// Namespace prop
// Params 1
// Checksum 0xf0f86fc, Offset: 0x16f3
// Size: 0x25
function onplayerdisconnect( params )
{
    if ( !function_1f3d2436a2463a6f() )
    {
        thread huntercleanup();
        return;
    }
    
    thread prop_util::propcleanup();
}

// Namespace prop
// Params 0
// Checksum 0xfdcd251, Offset: 0x1720
// Size: 0x8f
function initspawns()
{
    spawnlogic::function_6dbabb72223a4bca();
    spawnlogic::setactivespawnlogic( #"default" );
    spawnkey = spawnlogic::function_d5c160a4110b573e();
    
    if ( spawnlogic::function_5cf82e30c52a895d( spawnkey ) )
    {
        spawnlogic::function_3cdbb94b81729d5f( spawnkey, 1 );
    }
    else
    {
        spawnlogic::function_9bd2654564d3372d( #"start", "start_attackers", "mp_ctf_spawn_allies_start", game[ "attackers" ], 0 );
        spawnlogic::function_9bd2654564d3372d( #"start", "start_defenders", "mp_ctf_spawn_axis_start", game[ "defenders" ], 0 );
    }
    
    spawnlogic::finalizemap();
}

// Namespace prop
// Params 0
// Checksum 0x5c678064, Offset: 0x17b7
// Size: 0x2b
function getspawnpoint()
{
    spawnpoint = spawnlogic::function_3f9d5fcfb93d4190( self, undefined, #"start", undefined, #"start" );
    return spawnpoint;
}

// Namespace prop
// Params 1, eflags: 0x4
// Checksum 0xd2aa2476, Offset: 0x17eb
// Size: 0x70
function private function_92dd64e788a3774e( player )
{
    player endon( #"death_or_disconnect" );
    
    if ( !utility::ent_flag( "loading_over" ) )
    {
        while ( true )
        {
            player waittill( #"luinotifyserver", msg, value );
            
            if ( msg == "versus_done" )
            {
                player utility::ent_flag_set( "loading_over" );
                break;
            }
        }
    }
}

// Namespace prop
// Params 1
// Checksum 0xb5bc9399, Offset: 0x1863
// Size: 0x109
function onspawnplayer( spawndata )
{
    hud_message::function_ef4318a0090caa0f( #"kill" );
    level.var_7b282ffc18c488c[ self.team ]++;
    
    if ( function_1f3d2436a2463a6f() )
    {
        prop_util::function_3dd5ca52fb14c180();
        battlechatter_mp::disablebattlechatter( self );
    }
    else
    {
        self.pers[ "gamemodeLoadout" ] = level.proploadouts[ #"hunter" ];
        class::giveloadout( self.team, "gamemode" );
        thread handlehunter();
    }
    
    if ( isdefined( level.hide_phase_over ) && !level.hide_phase_over )
    {
        thread function_6e0b5483824874ac();
    }
    
    stats::setextrascore0( self.pers[ "prop_obj_time" ] ?? 0, "prop_obj_time" );
    stats::setextrascore1( self.pers[ "prop_survived" ] ?? 0, "prop_survived" );
    stats::setextrascore2( self.pers[ "prop_decoys_destroyed" ] ?? 0, "prop_decoys_destroyed" );
}

// Namespace prop
// Params 0
// Checksum 0xb32687ef, Offset: 0x1974
// Size: 0x238
function initloadouts()
{
    level.proploadouts = [];
    assert( isdefined( level.gametypebundle.var_14a374941dd4696c ), "<dev string:x4a>" );
    
    foreach ( var_471f67719c37edf3 in level.gametypebundle.var_14a374941dd4696c )
    {
        level.var_2442c2061b3eac9a = [];
        classtablebundle = getscriptbundle( var_471f67719c37edf3.bundle );
        assert( isdefined( classtablebundle ), "<dev string:xb3>" );
        assert( isdefined( var_471f67719c37edf3.weapon_type ), "<dev string:xef>" );
        
        foreach ( loadoutentry in classtablebundle.classlist )
        {
            var_79240becd50c909e = hashcat( %"classtableentry:", loadoutentry.entry );
            var_227506a321482ad6 = getscriptbundle( var_79240becd50c909e );
            assert( isdefined( var_227506a321482ad6 ), "<dev string:x108>" + loadoutentry.entry );
            level.var_2442c2061b3eac9a[ level.var_2442c2061b3eac9a.size ] = var_227506a321482ad6;
        }
        
        level.proploadouts[ var_471f67719c37edf3.weapon_type ] = function_3f277febf9d1f0ea( utility::array_random( level.var_2442c2061b3eac9a ) );
    }
    
    /#
        assert( isdefined( level.proploadouts[ #"prop" ] ), "<dev string:x14e>" );
        assert( isdefined( level.proploadouts[ #"hunter" ] ), "<dev string:x18e>" );
    #/
}

// Namespace prop
// Params 1
// Checksum 0x6c340952, Offset: 0x1bb4
// Size: 0x350
function function_3f277febf9d1f0ea( bundle )
{
    loadout = [];
    loadout[ "loadoutArchetype" ] = "archetype_assault";
    loadout[ "loadoutPrimary" ] = bundle.primaryweapon.weapon;
    loadout[ "loadoutPrimaryAttachment" ] = bundle.primaryweapon.attachment1;
    loadout[ "loadoutPrimaryAttachment2" ] = bundle.primaryweapon.attachment2;
    loadout[ "loadoutPrimaryAttachment3" ] = bundle.primaryweapon.attachment3;
    loadout[ "loadoutPrimaryAttachment4" ] = bundle.primaryweapon.attachment4;
    loadout[ "loadoutPrimaryAttachment5" ] = bundle.primaryweapon.attachment5;
    loadout[ "loadoutPrimaryCamo" ] = bundle.primaryweapon.camo;
    loadout[ "loadoutPrimaryReticle" ] = bundle.primaryweapon.reticle;
    loadout[ "loadoutSecondary" ] = bundle.secondaryweapon.weapon;
    loadout[ "loadoutSecondaryAttachment" ] = bundle.secondaryweapon.attachment1;
    loadout[ "loadoutSecondaryAttachment2" ] = bundle.secondaryweapon.attachment2;
    loadout[ "loadoutSecondaryAttachment3" ] = bundle.secondaryweapon.attachment3;
    loadout[ "loadoutSecondaryAttachment4" ] = bundle.secondaryweapon.attachment4;
    loadout[ "loadoutSecondaryAttachment5" ] = bundle.secondaryweapon.attachment5;
    loadout[ "loadoutSecondaryCamo" ] = bundle.secondaryweapon.camo;
    loadout[ "loadoutSecondaryReticle" ] = bundle.secondaryweapon.reticle;
    loadout[ "loadoutMeleeSlot" ] = bundle.tertiaryWeapon.weapon;
    loadout[ "loadoutEquipmentPrimary" ] = bundle.equipment.primary;
    loadout[ "loadoutEquipmentSecondary" ] = bundle.equipment.secondary;
    loadout[ "loadoutStreakType" ] = "assault";
    loadout[ "loadoutKillstreak1" ] = "none";
    loadout[ "loadoutKillstreak2" ] = "none";
    loadout[ "loadoutKillstreak3" ] = "none";
    loadout[ "loadoutSuper" ] = bundle.super;
    loadout[ "loadoutPerks" ] = [ bundle.perks.perk1, bundle.perks.perk2, bundle.perks.perk3, bundle.perks.perkbonus ];
    loadout[ "loadoutGesture" ] = bundle.gesture;
    loadout[ "loadoutFieldUpgrade1" ] = bundle.fieldUpgrades.fieldupgrade1;
    loadout[ "loadoutFieldUpgrade2" ] = bundle.fieldUpgrades.fieldupgrade2;
    return loadout;
}

// Namespace prop
// Params 0
// Checksum 0x5f9e283d, Offset: 0x1f0d
// Size: 0x13, Type: bool
function function_1f3d2436a2463a6f()
{
    return self.team == game[ "defenders" ];
}

// Namespace prop
// Params 0
// Checksum 0xe6e50669, Offset: 0x1f29
// Size: 0x13, Type: bool
function wasprop()
{
    return self.leaving_team == game[ "defenders" ];
}

// Namespace prop
// Params 0
// Checksum 0x52d4eda7, Offset: 0x1f45
// Size: 0x9
function function_8d78ded8905568d9()
{
    return game[ "attackers" ];
}

// Namespace prop
// Params 0
// Checksum 0x76f388a1, Offset: 0x1f57
// Size: 0x9
function function_22083e765aa81ca()
{
    return game[ "defenders" ];
}

// Namespace prop
// Params 2, eflags: 0x4
// Checksum 0xb9829ba4, Offset: 0x1f69
// Size: 0x64
function private function_7ce09faf41533d91( player, prop )
{
    player endon( #"death_or_disconnect" );
    prop endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    player clearentitysoundsubmix( prop, "mp_cer_prophunt_ally", -1 );
    wait 0.2;
    player function_76780be6bf0498e0( prop, "mp_cer_prophunt_ally", -1, 1 );
}

// Namespace prop
// Params 0
// Checksum 0x2d189a68, Offset: 0x1fd5
// Size: 0x9a
function function_77671bf5c56ad00b()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    wait 1;
    
    foreach ( player in level.players )
    {
        thread function_7ce09faf41533d91( player, self );
    }
}

// Namespace prop
// Params 0
// Checksum 0x7151fe90, Offset: 0x2077
// Size: 0xa5
function function_12dfe7f1ec16c38()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    wait 1;
    
    foreach ( player in level.players )
    {
        if ( player function_1f3d2436a2463a6f() )
        {
            thread function_7ce09faf41533d91( self, player );
        }
    }
}

// Namespace prop
// Params 2
// Checksum 0x87ee3695, Offset: 0x2124
// Size: 0x3f, Type: bool
function function_33156af08e927a34( victim, attacker )
{
    return attacker.team == game[ "defenders" ] && level.prop_bundle.isabilityflashandstun;
}

// Namespace prop
// Params 0
// Checksum 0x3581b849, Offset: 0x216c
// Size: 0x11f
function handlehunter()
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    if ( !level.hide_phase_over )
    {
        function_aa3923f0c8c09841( 1 );
    }
    
    self setmovespeedscale( 1 );
    self enableweaponpickup();
    self playershow();
    self setsolid( 1 );
    class::setthirdpersonview();
    self sethidenameplate( 0 );
    self function_b63e3c462f2e452b( ( 0, 0, 0 ) );
    self setpropentity();
    self function_21de5aadd2856aa7();
    thread function_2d0da7f8de64cbbf();
    thread function_12dfe7f1ec16c38();
    self.var_485899a46494a80f = undefined;
    flags::gameflagwait( "prematch_done" );
    primaries = inventory_utility::getcurrentprimaryweaponsminusalt();
    
    foreach ( weapon in primaries )
    {
        function_a1bbe1a5ea74ce28( weapon );
    }
}

// Namespace prop
// Params 1
// Checksum 0xd289c9fe, Offset: 0x2293
// Size: 0x5a
function function_a1bbe1a5ea74ce28( weapon )
{
    maxammo = weaponmaxammo( weapon );
    
    if ( self getweaponammostock( weapon ) < maxammo )
    {
        self setweaponammostock( weapon, maxammo );
    }
    
    clipsize = weaponclipsize( weapon );
    
    if ( self getweaponammoclip( weapon ) < clipsize )
    {
        self setweaponammoclip( weapon, clipsize );
    }
}

// Namespace prop
// Params 0
// Checksum 0x309c8eac, Offset: 0x22f5
// Size: 0x53
function function_2d0da7f8de64cbbf()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    self notify( #"attackerregenammo" );
    self endon( #"attackerregenammo" );
    
    while ( true )
    {
        self waittill( #"reload_ammo_added" );
        function_a1bbe1a5ea74ce28( self getcurrentprimaryweapon() );
    }
}

// Namespace prop
// Params 11
// Checksum 0xee4115e8, Offset: 0x2350
// Size: 0x75
function modifyplayerdamage( einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, var_cdd29ad5d1362c2 )
{
    if ( smeansofdeath == "MOD_FALLING" )
    {
        return 0;
    }
    
    return idamage;
}

// Namespace prop
// Params 1
// Checksum 0x256b89aa, Offset: 0x23ce
// Size: 0x3bf
function onplayerkilled( deathdata )
{
    attacker = deathdata.attacker;
    victim = self;
    prop_util::function_bb805d327039ae4a();
    
    if ( deathdata.deathtype == "deathType_switchingTeams" )
    {
        return;
    }
    
    if ( victim function_1f3d2436a2463a6f() )
    {
        prop_util::function_873c1489cc31954( self.prop.origin, self.prop.info );
        corpse = victim.body;
        
        if ( isdefined( corpse ) )
        {
            corpse delete();
        }
        
        if ( !level.hide_phase_over )
        {
            self.pers[ "lives" ]++;
            self.var_cdd796b8829a3b3b = 1;
            victim thread prop_util::propcleanup( 1 );
            return;
        }
        
        victim thread prop_util::propcleanup();
        
        if ( !attacker function_1f3d2436a2463a6f() )
        {
            foreach ( player in level.players )
            {
                if ( !player function_1f3d2436a2463a6f() )
                {
                    player replenishtactical();
                    continue;
                }
                
                if ( isalive( player ) && player != victim )
                {
                    player thread points::doscoreevent( #"prop_per_survive" );
                    
                    if ( function_edf057d322fcc06a( player ) )
                    {
                        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( player ) ) )
                        {
                            if ( isdefined( player.leaderboarddata[ "prop_survived" ] ) )
                            {
                                player.leaderboarddata[ "prop_survived" ] = player.leaderboarddata[ "prop_survived" ] + 1;
                            }
                            
                            if ( isdefined( level.leaderboardfunc[ "prop_survived" ] ) )
                            {
                                [[ level.leaderboardfunc[ "prop_survived" ] ]]( player, 1 );
                            }
                            
                            assert( isint( 1 ) || isfloat( 1 ), "<dev string:x24>" );
                            
                            if ( isdefined( player.pers[ "prop_survived" ] ) )
                            {
                                player.pers[ "prop_survived" ] = player.pers[ "prop_survived" ] + 1;
                            }
                        }
                        
                        player stats::setextrascore1( player.pers[ "prop_survived" ], "prop_survived" );
                    }
                }
            }
            
            if ( !isdefined( attacker.var_6d89c2f8dc182811 ) )
            {
                attacker.var_6d89c2f8dc182811 = 0;
            }
            
            attacker.var_6d89c2f8dc182811++;
            
            if ( attacker.var_6d89c2f8dc182811 == 3 )
            {
                attacker thread points::doscoreevent( #"triple_prop_kill" );
            }
            
            if ( attacker.var_6d89c2f8dc182811 == level.var_7b282ffc18c488c[ victim.team ] )
            {
                attacker thread points::doscoreevent( #"killed_all_props" );
            }
        }
        
        alivecount = teams::getteamdata( victim.team, "aliveCount" );
        setomnvar( o"ui_axis_alive", alivecount );
        setomnvar( o"ui_axis_lives_remaining", alivecount );
        
        if ( alivecount <= 0 )
        {
            thread setwinner( game[ "attackers" ], game[ "end_reason" ][ "enemies_eliminated" ], game[ "end_reason" ][ "friendlies_eliminated" ] );
        }
        
        return;
    }
    
    if ( attacker function_1f3d2436a2463a6f() )
    {
        attacker potg_events::prop_hunter_elim();
    }
    
    victim thread huntercleanup();
    self.pers[ "lives" ]++;
}

// Namespace prop
// Params 1
// Checksum 0xfd46b217, Offset: 0x2795
// Size: 0x9b
function modeonteamchangedeath( player )
{
    if ( player wasprop() )
    {
        corpse = player.body;
        
        if ( isdefined( corpse ) )
        {
            corpse delete();
        }
        
        player thread prop_util::propcleanup();
    }
    else
    {
        player thread huntercleanup();
    }
    
    alivecount = teams::getteamdata( game[ "defenders" ], "teamCount" );
    
    if ( alivecount <= 0 )
    {
        thread setwinner( game[ "attackers" ], game[ "end_reason" ][ "enemies_eliminated" ], game[ "end_reason" ][ "friendlies_eliminated" ] );
    }
}

// Namespace prop
// Params 0
// Checksum 0x7e88b56e, Offset: 0x2838
// Size: 0x24, Type: bool
function function_9b636ef0a653bda8()
{
    alivecount = teams::getteamdata( game[ "defenders" ], "aliveCount" );
    return alivecount <= 0;
}

// Namespace prop
// Params 0
// Checksum 0x7b878b22, Offset: 0x2865
// Size: 0x2a
function replenishtactical()
{
    equipmentref = equipment_mp::getcurrentequipment( "secondary" );
    
    if ( isdefined( equipmentref ) )
    {
        equipment_mp::incrementequipmentammo( equipmentref, 1 );
    }
}

// Namespace prop
// Params 0
// Checksum 0xed348dc, Offset: 0x2897
// Size: 0xd
function huntercleanup()
{
    self clearsoundsubmix( "mp_cer_prophunt_enemy" );
}

// Namespace prop
// Params 0
// Checksum 0x42ad5237, Offset: 0x28ac
// Size: 0x2a
function ontimelimit()
{
    if ( level.gameended )
    {
        return;
    }
    
    thread setwinner( game[ "defenders" ], game[ "end_reason" ][ "time_limit_reached" ] );
}

// Namespace prop
// Params 3
// Checksum 0xda55a65a, Offset: 0x28de
// Size: 0xe2
function setwinner( winningteam, endreasontext, endreasontextloss )
{
    foreach ( player in level.players )
    {
        if ( player function_1f3d2436a2463a6f() )
        {
            if ( isalive( player ) && winningteam == game[ "defenders" ] )
            {
                player thread points::doscoreevent( #"prop_survival" );
            }
            
            player thread prop_util::propcleanup();
            continue;
        }
        
        player thread huntercleanup();
    }
    
    thread gamelogic_mp::endgame( winningteam, endreasontext, endreasontextloss );
}

// Namespace prop
// Params 1
// Checksum 0xa243ef5c, Offset: 0x29c8
// Size: 0x2e, Type: bool
function function_39614c5749ce5e0c( params )
{
    if ( !level.hide_phase_over || function_1f3d2436a2463a6f() )
    {
        playerlogic::playerhasmoved();
        return true;
    }
    
    return false;
}

// Namespace prop
// Params 0
// Checksum 0x3611a4f1, Offset: 0x29ff
// Size: 0x8e
function function_571e64bb747aec49()
{
    foreach ( player in teams::getteamdata( game[ "attackers" ], "players" ) )
    {
        player.pers[ "distTrackingPassed" ] = 0;
    }
}

/#

    // Namespace prop
    // Params 0
    // Checksum 0xdc9c278, Offset: 0x2a95
    // Size: 0x2f, Type: dev
    function drawalignment()
    {
        while ( true )
        {
            debugaxis( self.origin, self.angles, 10, 1, 0, 1 );
            waitframe();
        }
    }

    // Namespace prop
    // Params 0
    // Checksum 0x23053ede, Offset: 0x2acc
    // Size: 0xe8, Type: dev
    function function_d6eb479c4a64dfe5()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"scr_give_score_allies" ) != 0 )
            {
                points = getdvarint( @"scr_give_score_allies" );
                
                if ( points == -1 )
                {
                    points = getdvarint( @"scr_prop_scorelimit" ) - 1;
                }
                
                gamescore::giveteamscoreforobjective( "<dev string:x1d0>", points, 0 );
                break;
            }
            else if ( getdvarint( @"scr_give_score_axis" ) != 0 )
            {
                points = getdvarint( @"scr_give_score_axis" );
                
                if ( points == -1 )
                {
                    points = getdvarint( @"scr_prop_scorelimit" ) - 1;
                }
                
                gamescore::giveteamscoreforobjective( "<dev string:x1d7>", points, 0 );
                break;
            }
            
            wait 1;
        }
        
        setdevdvar( @"scr_give_score_allies", 0 );
        setdevdvar( @"scr_give_score_axis", 0 );
        thread function_d6eb479c4a64dfe5();
    }

#/
