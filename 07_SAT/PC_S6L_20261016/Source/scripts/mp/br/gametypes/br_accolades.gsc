// scripts\mp\br\gametypes\br_accolades.gsc  (hash_194ea2e0ec5f8399.gscc) (size: 42067 Bytes / 0xa453 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc0a6ae2 (202009314)
// size ...... 42067 (0xa453)
// includes .. 6   (offset: 0x94fb)
// strings ... 202 (offset: 0x952b)
// dev strs .. 42  (offset: 0xa13b)
// exports ... 53  (offset: 0x7a23)
// cseg ...... 0xe44 + 0x6bdf (0x7a23)
// imports ... 112 (offset: 0x826b)
// animtree1 . 0   (offset: 0xa453)
// animtree2 . 0   (offset: 0xa453)
#using scripts\common\progression_utility;
#using scripts\common\utility;
#using scripts\mp\bots\bots_gametype_br_super;
#using scripts\mp\common\utility\teams;
#using scripts\mp\currency;
#using scripts\mp\personal_bests;

#namespace br_accolades;

// Namespace br_accolades
// Params 0
// Checksum 0x736f1cec, Offset: 0xe62
// Size: 0x286
function accolades_init()
{
    /#
        setdevdvarifuninitialized( @"hash_cf55e0f95935f5af", 1 );
        setdevdvarifuninitialized( @"hash_ad33abd04b38d2fa", "<dev string:x24>" );
        setdevdvarifuninitialized( @"hash_ad33aad04b38d0c7", "<dev string:x24>" );
        setdevdvarifuninitialized( @"hash_ad33a9d04b38ce94", "<dev string:x24>" );
        setdevdvarifuninitialized( @"hash_ad33a8d04b38cc61", "<dev string:x24>" );
        setdevdvarifuninitialized( @"hash_ad33a7d04b38ca2e", "<dev string:x24>" );
        setdevdvarifuninitialized( @"hash_ad33a6d04b38c7fb", "<dev string:x24>" );
    #/
    
    accoladelist = getscriptbundle( %"hash_2e2c8e9902bd7702" );
    level.var_3abb05bb58a5e16e = [];
    
    if ( isdefined( accoladelist ) )
    {
        if ( isdefined( accoladelist.var_daed3aa9e62ce555 ) )
        {
            foreach ( id, entry in accoladelist.var_daed3aa9e62ce555 )
            {
                if ( isnumber( id ) && isdefined( entry.var_270d090b36f94224 ) )
                {
                    ref = entry.var_270d090b36f94224;
                    
                    if ( !isdefined( level.var_3abb05bb58a5e16e[ ref ] ) )
                    {
                        level.var_3abb05bb58a5e16e[ ref ] = id;
                        continue;
                    }
                    
                    assert( !isdefined( level.var_3abb05bb58a5e16e[ ref ] ) );
                }
            }
        }
        else
        {
            assert( isdefined( accoladelist.var_daed3aa9e62ce555 ), "<dev string:x25>" );
        }
    }
    else
    {
        assert( isdefined( accoladelist ), "<dev string:x79>" );
    }
    
    level.var_c99fd4f0f41403f8 = [];
    level.var_8c7ec39ec0a01732 = [];
    function_14ff37c54fc99e68();
    function_1f53c800b87a9a3f();
    
    if ( getprojectname() == "SAW" && !getdvarint( @"hash_41e4c3b7f2117f55", 0 ) )
    {
        if ( !utility::callsharedfunc( #"gametype", #"hash_95136c4fa46b7d5d" ) )
        {
            function_9cbe2aef9f50888c();
        }
        
        level.var_4bd1e8461213f19 = &function_b6d54caeb842ca34;
    }
    else if ( !utility::callsharedfunc( #"gametype", #"hash_95136c4fa46b7d5d" ) )
    {
        function_56b01033f839770f();
    }
    
    level.var_1b4613a64e689a9a = &function_5e9799a78f31427e;
    
    /#
        if ( getdvarint( @"hash_cc732c73e93ea9d7", 0 ) )
        {
            thread accoladedebug();
        }
    #/
}

// Namespace br_accolades
// Params 1
// Checksum 0xcc0a5ab1, Offset: 0x10f0
// Size: 0x2c8
function function_b6d54caeb842ca34( players )
{
    foreach ( player in players )
    {
        /#
            xuid = player getxuid();
            
            if ( level.br_accolade_debug.forceaccolade[ xuid ].accolade )
            {
                player.var_4f97df463efd71b5 = level.br_accolade_debug.forceaccolade[ xuid ].accolade;
                continue;
            }
        #/
        
        bestref = utility::callsharedfunc( #"gametype", #"hash_ee4ee436d7fa9e38", player );
        
        if ( !isdefined( bestref ) )
        {
            iswinningplayer = level.endgamewinner && level.endgamewinner == player.team;
            var_1cdecb01d1fba8cb = -1;
            bestref = iswinningplayer ? level.var_3fbfef97cd59d942 : level.var_9dcf155eb0d39ebd;
            var_253a9048e8930294 = 1;
            
            foreach ( ref, scaledval in player.var_e52d4a674441a868 )
            {
                if ( level.var_62cdbc0387b3d149[ getxhash( ref ) ] )
                {
                    continue;
                }
                
                if ( scaledval > var_1cdecb01d1fba8cb )
                {
                    var_1cdecb01d1fba8cb = scaledval;
                    bestref = ref;
                    var_253a9048e8930294 = 0;
                }
            }
        }
        
        player.var_4f97df463efd71b5 = bestref;
        var_a4dd02422f990404 = player.var_329a26fdb0abf539[ player.var_4f97df463efd71b5 ] ?? 0;
        scaledval = player.var_e52d4a674441a868[ player.var_4f97df463efd71b5 ] ?? 0;
        player dlog_recordplayerevent( "dlog_event_br_winner_accolade_data", [ "accolade", player.var_4f97df463efd71b5, "is_participation_trophy", var_253a9048e8930294, "value", float( var_a4dd02422f990404 ), "scaled_value", float( scaledval ) ] );
        player.var_235f7c770e4f3bb0 = undefined;
        player.var_329a26fdb0abf539 = undefined;
        player.var_e52d4a674441a868 = undefined;
    }
}

// Namespace br_accolades
// Params 0, eflags: 0x4
// Checksum 0x5348eb68, Offset: 0x13c0
// Size: 0x4a5
function private function_9cbe2aef9f50888c()
{
    tierweight = 2;
    
    foreach ( killtype in [ "pistolKills", "shotgunKills", "smgKills", "assaultKills", "dmrKills", "lmgKills", "sniperKills", "launcherKills", "meleeKills", "killstreakKills", "executions", "vehicleKills", "lethalKills", "stickKills", "oneShotOneKills" ] )
    {
        maxvalue = 10;
        minvalue = 1;
        weight = tierweight;
        accoladeref = killtype;
        
        switch ( killtype )
        {
            case #"hash_abc5f62c513b7dbd":
                accoladeref = "arKills";
                break;
            case #"hash_6238a083590c2832":
            case #"hash_714cd4ea414ab1c4":
            case #"hash_795ef84d5c09f9b8":
            case #"hash_8b559ab97e14140c":
                minvalue = 2;
                maxvalue = 4;
                weight = 5;
                break;
            case #"hash_af094904534b686":
                minvalue = 2;
                maxvalue = 4;
                weight = 3;
                accoladeref = "oneshotkills";
                break;
        }
        
        params = { #weight:weight, #floor:minvalue, #maxvalue:maxvalue, #scoreparams:[ killtype ], #datafunc:&function_8cc3b9237083988e, #scorefunc:&function_eddb6c60c24708f4 };
        
        /#
            params.debugfunc = &function_b77bd2de1f527055;
        #/
        
        register_accolade( tolower( accoladeref ), params );
    }
    
    params = { #weight:3, #floor:1, #maxvalue:5, #scoreparams:[ "rescues", "kioskRevives" ], #datafunc:&function_8cc3b9237083988e, #scorefunc:&function_eddb6c60c24708f4 };
    
    /#
        params.debugfunc = &function_b77bd2de1f527055;
    #/
    
    register_accolade( "reviver", params );
    tierweight = 1;
    params = { #weight:tierweight, #floor:5, #maxvalue:20, #scoreparams:[ "reconDroneMarks", "sensorGrenadeTags", "enemyPlayersPinged" ], #datafunc:&function_8cc3b9237083988e, #scorefunc:&function_eddb6c60c24708f4 };
    
    /#
        params.debugfunc = &function_b77bd2de1f527055;
    #/
    
    register_accolade( "spotter", params );
    params = { #weight:tierweight, #floor:5, #maxvalue:20, #scoreparams:[], #datafunc:&function_80887eaedadb3f52, #scorefunc:&function_84aa228f9df7c6fa };
    
    /#
        params.debugfunc = &function_427482c9792e320b;
    #/
    
    register_accolade( "looter", params );
    tierweight = 0;
    params = { #weight:tierweight, #floor:1, #maxvalue:1, #scoreparams:[], #datafunc:&function_8cc3b9237083988e, #scorefunc:&function_eddb6c60c24708f4, #participationtrophy:1 };
    level.var_9dcf155eb0d39ebd = "downnotout";
    register_accolade( tolower( level.var_9dcf155eb0d39ebd ), params );
    params = { #weight:tierweight, #floor:1, #maxvalue:1, #scoreparams:[], #datafunc:&function_8cc3b9237083988e, #scorefunc:&function_eddb6c60c24708f4, #participationtrophy:1 };
    level.var_3fbfef97cd59d942 = "effortlesswin";
    register_accolade( tolower( level.var_3fbfef97cd59d942 ), params );
}

// Namespace br_accolades
// Params 0, eflags: 0x4
// Checksum 0x9a5c9a7b, Offset: 0x186d
// Size: 0x1568
function private function_56b01033f839770f()
{
    params = spawnstruct();
    params.scenename = "jup_wz_acc_assassin_scene";
    params.scorefunc = &function_eddb6c60c24708f4;
    params.datafunc = &function_8cc3b9237083988e;
    
    /#
        params.debugfunc = &function_b77bd2de1f527055;
    #/
    
    params.scoreparams = [ "executionKills", "meleeKills" ];
    params.maxvalue = 5;
    params.floor = 1;
    params.scale = 1;
    register_accolade( "assassin", params );
    params = spawnstruct();
    params.scenename = "jup_wz_acc_assists_scene";
    params.scorefunc = &function_eddb6c60c24708f4;
    params.datafunc = &function_8cc3b9237083988e;
    
    /#
        params.debugfunc = &function_b77bd2de1f527055;
    #/
    
    params.scoreparams = [ "assists" ];
    params.maxvalue = 8;
    params.floor = 1;
    params.scale = 0;
    register_accolade( "assists", params );
    params = spawnstruct();
    params.scenename = "jup_wz_acc_bigguns_scene";
    params.scorefunc = &function_eddb6c60c24708f4;
    params.datafunc = &function_8cc3b9237083988e;
    
    /#
        params.debugfunc = &function_b77bd2de1f527055;
    #/
    
    params.scoreparams = [ "killstreakKills" ];
    params.maxvalue = 5;
    params.floor = 1;
    params.scale = 1;
    register_accolade( "bigguns", params );
    params = spawnstruct();
    params.scenename = "jup_wz_acc_breacher_scene";
    params.scorefunc = &function_eddb6c60c24708f4;
    params.datafunc = &function_8cc3b9237083988e;
    
    /#
        params.debugfunc = &function_b77bd2de1f527055;
    #/
    
    params.scoreparams = [ "stoppingPowerKills", "bossAgentKills" ];
    
    for ( i = 1; i <= 3 ; i++ )
    {
        params.scoreparams[ params.scoreparams.size ] = "tier" + i + "NormalAgentKills";
        params.scoreparams[ params.scoreparams.size ] = "tier" + i + "EliteAgentKills";
    }
    
    params.maxvalue = 16;
    params.floor = 1;
    params.scale = 0;
    register_accolade( "breacher", params );
    params = spawnstruct();
    params.scenename = "jup_wz_acc_commando_scene";
    params.scorefunc = &function_941672981beea97c;
    params.datafunc = &function_fd4050a549355476;
    
    /#
        params.debugfunc = &function_cb2f9989818e1ddd;
    #/
    
    params.maxvalue = 13;
    params.floor = 1;
    params.scale = 0;
    register_accolade( "commando", params );
    params = spawnstruct();
    params.scenename = "jup_wz_acc_ghost_scene";
    params.scorefunc = &function_eddb6c60c24708f4;
    params.datafunc = &function_8cc3b9237083988e;
    
    /#
        params.debugfunc = &function_b77bd2de1f527055;
    #/
    
    params.scoreparams = [ "deadSilenceKills", "throwingKnifeKills", "killstreakCUAVAssists", "silencedKills" ];
    params.maxvalue = 5;
    params.floor = 1;
    params.scale = 1;
    function_846f267b951ab8dd( "ghost", "killstreakCUAVAssists", 0.5 );
    register_accolade( "ghost", params );
    params = spawnstruct();
    params.scenename = "jup_wz_acc_interrogator_scene";
    params.scorefunc = &function_eddb6c60c24708f4;
    params.datafunc = &function_8cc3b9237083988e;
    
    /#
        params.debugfunc = &function_b77bd2de1f527055;
    #/
    
    params.scoreparams = [ "interrogations" ];
    params.maxvalue = 5;
    params.floor = 1;
    params.scale = 0;
    register_accolade( "interrogator", params );
    params = spawnstruct();
    params.scenename = "jup_wz_acc_killer_scene";
    params.scorefunc = &function_eddb6c60c24708f4;
    params.datafunc = &function_8cc3b9237083988e;
    
    /#
        params.debugfunc = &function_b77bd2de1f527055;
    #/
    
    params.scoreparams = [ "kills" ];
    params.maxvalue = 18;
    params.floor = 1;
    params.scale = 2;
    register_accolade( "killer", params );
    params = spawnstruct();
    params.scenename = "jup_wz_acc_machinist_scene";
    params.scorefunc = &function_eddb6c60c24708f4;
    params.datafunc = &function_8cc3b9237083988e;
    
    /#
        params.debugfunc = &function_b77bd2de1f527055;
    #/
    
    params.scoreparams = [ "smokesUsed", "flashbangHits", "trophySystemHits", "empDroneHits", "gasHits", "stunHits", "decoyHits", "deployableCoverUsed", "shockStickHits" ];
    params.maxvalue = 11;
    params.floor = 1;
    params.scale = 0;
    function_846f267b951ab8dd( "machinist", "decoyHits", 0.1 );
    function_846f267b951ab8dd( "machinist", "deployableCoverUsed", 0.1 );
    function_846f267b951ab8dd( "machinist", "shockStickHits", 0.1 );
    register_accolade( "machinist", params );
    params = spawnstruct();
    params.scenename = "jup_wz_acc_marksman_scene";
    params.scorefunc = &function_eddb6c60c24708f4;
    params.datafunc = &function_8cc3b9237083988e;
    
    /#
        params.debugfunc = &function_b77bd2de1f527055;
    #/
    
    params.scoreparams = [ "headshots", "totalMultikills", "penetrationKills" ];
    params.maxvalue = 9;
    params.floor = 1;
    params.scale = 1;
    register_accolade( "marksman", params );
    params = spawnstruct();
    params.scenename = "jup_wz_acc_medic_scene";
    params.scorefunc = &function_eddb6c60c24708f4;
    params.datafunc = &function_8cc3b9237083988e;
    
    /#
        params.debugfunc = &function_b77bd2de1f527055;
    #/
    
    params.scoreparams = [ "rescues", "kioskRevives" ];
    params.maxvalue = 6;
    params.floor = 1;
    params.scale = 1;
    register_accolade( "medic", params );
    params = spawnstruct();
    params.scenename = "jup_wz_acc_moneybags_scene";
    params.scorefunc = &function_4175044c15676c25;
    params.datafunc = &function_81f48fe88a6adfd;
    
    /#
        params.debugfunc = &function_29d29e9c00e09646;
    #/
    
    params.scoreparams = [ "highestPurchaseCost" ];
    params.maxvalue = 5000;
    params.floor = 20;
    params.scale = 2;
    register_accolade( "moneybags", params );
    params = spawnstruct();
    params.scenename = "jup_wz_acc_pyro_scene";
    params.scorefunc = &function_eddb6c60c24708f4;
    params.datafunc = &function_8cc3b9237083988e;
    
    /#
        params.debugfunc = &function_b77bd2de1f527055;
    #/
    
    params.scoreparams = [ "fragKills", "molotovKills", "launcherKills", "semtexKills", "thermiteKills", "stickyGrenadeKills" ];
    params.maxvalue = 5;
    params.floor = 1;
    params.scale = 0;
    register_accolade( "pyro", params );
    params = spawnstruct();
    params.scenename = "jup_wz_acc_scavenger_scene";
    params.scorefunc = &function_84aa228f9df7c6fa;
    params.datafunc = &function_80887eaedadb3f52;
    
    /#
        params.debugfunc = &function_427482c9792e320b;
    #/
    
    params.maxvalue = 22;
    params.floor = 1;
    params.scale = 0;
    register_accolade( "scavenger", params );
    params = spawnstruct();
    params.scenename = "jup_wz_acc_scout_scene";
    params.scorefunc = &function_eddb6c60c24708f4;
    params.datafunc = &function_8cc3b9237083988e;
    
    /#
        params.debugfunc = &function_b77bd2de1f527055;
    #/
    
    params.scoreparams = [ "reconDroneMarks", "killstreakUAVAssists", "killstreakFalseFlagAssists", "killstreakAUAVAssists", "binocularMarks", "snapshotHits", "tacCamMarks", "spycamMarks" ];
    params.maxvalue = 7;
    params.floor = 1;
    params.scale = 0;
    register_accolade( "scout", params );
    params = spawnstruct();
    params.scenename = "jup_wz_acc_sniper_scene";
    params.scorefunc = &function_eddb6c60c24708f4;
    params.datafunc = &function_8cc3b9237083988e;
    
    /#
        params.debugfunc = &function_b77bd2de1f527055;
    #/
    
    params.scoreparams = [ "longshotKills" ];
    params.maxvalue = 5;
    params.floor = 1;
    params.scale = 1;
    register_accolade( "sniper", params );
    params = spawnstruct();
    params.scenename = "jup_wz_acc_supplier_scene";
    params.scorefunc = &function_eddb6c60c24708f4;
    params.datafunc = &function_8cc3b9237083988e;
    
    /#
        params.debugfunc = &function_b77bd2de1f527055;
    #/
    
    params.scoreparams = [ "munitionsBoxUsed", "armorBoxUsed" ];
    params.maxvalue = 9;
    params.floor = 1;
    params.scale = 0;
    register_accolade( "supplier", params );
    params = spawnstruct();
    params.scenename = "jup_wz_acc_survivor_scene";
    params.scorefunc = &function_eddb6c60c24708f4;
    params.datafunc = &function_8cc3b9237083988e;
    
    /#
        params.debugfunc = &function_b77bd2de1f527055;
    #/
    
    params.scoreparams = [ "damageHealed", "gulagWins", "rescued", "revivedFromKiosk" ];
    params.maxvalue = 59;
    params.floor = 1;
    params.scale = 2;
    function_846f267b951ab8dd( "survivor", "damageHealed", 0.1 );
    register_accolade( "survivor", params );
    params = spawnstruct();
    params.scenename = "jup_wz_acc_teamobjectives_scene";
    params.scorefunc = &function_b5cc5009111cdd3;
    params.datafunc = &function_6574dc42721b7103;
    
    /#
        params.debugfunc = &function_ba9dca5a342f4484;
    #/
    
    params.scoreparams = [ "blacksitesCaptured", "strongholdsCaptured" ];
    params.maxvalue = 5;
    params.floor = 1;
    params.scale = 0;
    register_accolade( "teamobjectives", params );
    params = spawnstruct();
    params.scenename = "jup_wz_acc_trapper_scene";
    params.scorefunc = &function_eddb6c60c24708f4;
    params.datafunc = &function_8cc3b9237083988e;
    
    /#
        params.debugfunc = &function_b77bd2de1f527055;
    #/
    
    params.scoreparams = [ "claymoreKills", "c4Kills", "proximityMineKills" ];
    params.maxvalue = 5;
    params.floor = 1;
    params.scale = 0;
    register_accolade( "trapper", params );
    params = spawnstruct();
    params.scenename = "jup_wz_acc_deadweight_scene";
    params.scorefunc = &function_915ad70efefdda6c;
    params.datafunc = &function_6c50123a61b25c9c;
    
    /#
        params.debugfunc = &function_55527deb696ed76d;
    #/
    
    params.scoreparams = [ "deaths" ];
    params.maxvalue = 1;
    params.floor = 0.001;
    params.scale = 2;
    register_accolade( "deadweight", params );
    params = spawnstruct();
    params.scenename = "jup_wz_acc_highachiever_cool_scene";
    params.scorefunc = &function_bac6190420b39271;
    params.datafunc = &function_8cc3b9237083988e;
    
    /#
        params.debugfunc = &function_b77bd2de1f527055;
    #/
    
    params.scoreparams = [];
    params.maxvalue = 8;
    params.floor = 1;
    params.scale = 0;
    register_accolade( "highachiever_cool", params );
    params = spawnstruct();
    params.scenename = "jup_wz_acc_highachiever_cooler_scene";
    params.scorefunc = &function_bac6190420b39271;
    params.datafunc = &function_8cc3b9237083988e;
    
    /#
        params.debugfunc = &function_b77bd2de1f527055;
    #/
    
    params.scoreparams = [];
    params.maxvalue = 8;
    params.floor = 1;
    params.scale = 0;
    register_accolade( "highachiever_cooler", params );
    params = spawnstruct();
    params.scenename = "jup_wz_acc_highachiever_coolest_scene";
    params.scorefunc = &function_bac6190420b39271;
    params.datafunc = &function_8cc3b9237083988e;
    
    /#
        params.debugfunc = &function_b77bd2de1f527055;
    #/
    
    params.scoreparams = [];
    params.maxvalue = 8;
    params.floor = 1;
    params.scale = 0;
    register_accolade( "highachiever_coolest", params );
    params = spawnstruct();
    params.scenename = "jup_wz_acc_immortal_scene";
    params.scorefunc = &function_bc0be8df35e50053;
    params.datafunc = &function_8cc3b9237083988e;
    
    /#
        params.debugfunc = &function_1efc2cfeb0a75404;
    #/
    
    params.scoreparams = [ "deaths" ];
    register_accolade( "immortal", params );
    params = spawnstruct();
    params.scenename = "jup_wz_acc_medalist_cool_scene";
    params.scorefunc = &function_d303e18ec77f1a07;
    params.datafunc = &function_8cc3b9237083988e;
    
    /#
        params.debugfunc = &function_b77bd2de1f527055;
    #/
    
    params.scoreparams = [];
    params.maxvalue = 8;
    params.floor = 1;
    params.scale = 0;
    register_accolade( "medalist_cool", params );
    params = spawnstruct();
    params.scenename = "jup_wz_acc_medalist_cooler_scene";
    params.scorefunc = &function_d303e18ec77f1a07;
    params.datafunc = &function_8cc3b9237083988e;
    
    /#
        params.debugfunc = &function_b77bd2de1f527055;
    #/
    
    params.scoreparams = [];
    params.maxvalue = 8;
    params.floor = 1;
    params.scale = 0;
    register_accolade( "medalist_cooler", params );
    params = spawnstruct();
    params.scenename = "jup_wz_acc_medalist_coolest_scene";
    params.scorefunc = &function_d303e18ec77f1a07;
    params.datafunc = &function_8cc3b9237083988e;
    
    /#
        params.debugfunc = &function_b77bd2de1f527055;
    #/
    
    params.scoreparams = [];
    params.maxvalue = 8;
    params.floor = 1;
    params.scale = 0;
    register_accolade( "medalist_coolest", params );
    params = spawnstruct();
    params.scenename = "jup_wz_acc_pacifist_scene";
    params.scorefunc = &function_4429a60cda1f1713;
    params.datafunc = &function_8cc3b9237083988e;
    
    /#
        params.debugfunc = &function_c1cd60fa6bd3b1c4;
    #/
    
    params.scoreparams = [ "kills", "assists", "agentKills" ];
    params.maxvalue = 100;
    params.floor = 0;
    params.scale = 0;
    register_accolade( "pacifist", params );
    params = spawnstruct();
    params.scenename = "jup_wz_acc_tryhard_cool_scene";
    params.scorefunc = &function_eddb6c60c24708f4;
    params.datafunc = &function_8cc3b9237083988e;
    
    /#
        params.debugfunc = &function_b77bd2de1f527055;
    #/
    
    params.scoreparams = [];
    register_accolade( "tryhard_cool", params );
    params = spawnstruct();
    params.scenename = "jup_wz_acc_tryhard_cooler_scene";
    params.scorefunc = &function_eddb6c60c24708f4;
    params.datafunc = &function_8cc3b9237083988e;
    
    /#
        params.debugfunc = &function_b77bd2de1f527055;
    #/
    
    params.scoreparams = [];
    register_accolade( "tryhard_cooler", params );
    params = spawnstruct();
    params.scenename = "jup_wz_acc_tryhard_coolest_scene";
    params.scorefunc = &function_eddb6c60c24708f4;
    params.datafunc = &function_8cc3b9237083988e;
    
    /#
        params.debugfunc = &function_b77bd2de1f527055;
    #/
    
    params.scoreparams = [];
    register_accolade( "tryhard_coolest", params );
    params = spawnstruct();
    params.scenename = "jup_wz_acc_weakestlink_scene";
    params.scorefunc = &function_eddb6c60c24708f4;
    params.datafunc = &function_8cc3b9237083988e;
    
    /#
        params.debugfunc = &function_b77bd2de1f527055;
    #/
    
    params.scoreparams = [];
    register_accolade( "weakestlink", params );
}

// Namespace br_accolades
// Params 0, eflags: 0x4
// Checksum 0x8b2db140, Offset: 0x2ddd
// Size: 0x6f
function private function_14ff37c54fc99e68()
{
    level.var_17a6232c5dad4ffe = [ "weakestlink", "deadweight", "tryhard_cool", "tryhard_cooler", "tryhard_coolest", "medalist_cool", "medalist_cooler", "medalist_coolest", "highachiever_cool", "highachiever_cooler", "highachiever_coolest" ];
}

// Namespace br_accolades
// Params 0, eflags: 0x4
// Checksum 0xa0c47eb6, Offset: 0x2e54
// Size: 0x19f
function private function_1f53c800b87a9a3f()
{
    level.var_62cdbc0387b3d149 = [];
    level.var_62cdbc0387b3d149[ #"weakestlink" ] = 1;
    level.var_62cdbc0387b3d149[ #"deadweight" ] = 1;
    level.var_62cdbc0387b3d149[ #"tryhard_cool" ] = 1;
    level.var_62cdbc0387b3d149[ #"tryhard_cooler" ] = 1;
    level.var_62cdbc0387b3d149[ #"tryhard_coolest" ] = 1;
    level.var_62cdbc0387b3d149[ #"medalist_cool" ] = 1;
    level.var_62cdbc0387b3d149[ #"medalist_cooler" ] = 1;
    level.var_62cdbc0387b3d149[ #"medalist_coolest" ] = 1;
    level.var_62cdbc0387b3d149[ #"highachiever_cool" ] = 1;
    level.var_62cdbc0387b3d149[ #"highachiever_cooler" ] = 1;
    level.var_62cdbc0387b3d149[ #"highachiever_coolest" ] = 1;
    var_3f51d0245475f5a2 = strtok( getdvar( @"hash_b534c88be1278728", "" ), " " );
    
    foreach ( accolade in var_3f51d0245475f5a2 )
    {
        level.var_62cdbc0387b3d149[ getxhash( accolade ) ] = 1;
    }
}

// Namespace br_accolades
// Params 2
// Checksum 0xc07ed6d7, Offset: 0x2ffb
// Size: 0x71
function register_accolade( ref, paramstruct )
{
    assert( isdefined( ref ) );
    assert( !isdefined( level.var_c99fd4f0f41403f8[ ref ] ) );
    assert( isdefined( paramstruct ) );
    assert( isdefined( paramstruct.scorefunc ) );
    paramstruct.name = ref;
    level.var_c99fd4f0f41403f8[ ref ] = paramstruct;
}

// Namespace br_accolades
// Params 1, eflags: 0x4
// Checksum 0x9ff124a2, Offset: 0x3074
// Size: 0x1e, Type: bool
function private function_14ba07f756afb4e5( player )
{
    return !( !bots_gametype_br_super::function_3130ca8d103182cd() && isbot( player ) );
}

// Namespace br_accolades
// Params 0
// Checksum 0x4c877cfb, Offset: 0x309b
// Size: 0x134
function function_5e9799a78f31427e()
{
    if ( !function_14ba07f756afb4e5( self ) )
    {
        return;
    }
    
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    foreach ( entry in level.var_c99fd4f0f41403f8 )
    {
        if ( entry.scoreparams.size > 0 )
        {
            foreach ( persval in entry.scoreparams )
            {
                if ( !isdefined( self.pers[ persval ] ) )
                {
                    self.pers[ persval ] = 0;
                }
            }
        }
    }
}

// Namespace br_accolades
// Params 3
// Checksum 0x7b103904, Offset: 0x31d7
// Size: 0x2e
function function_846f267b951ab8dd( accolade, stat, mod )
{
    level.var_8c7ec39ec0a01732[ accolade ][ stat ] = mod;
}

// Namespace br_accolades
// Params 2
// Checksum 0xcc2bf426, Offset: 0x320d
// Size: 0x28, Type: bool
function function_808f90af8000e7f1( accolade, stat )
{
    return level.var_8c7ec39ec0a01732[ accolade ][ stat ] ?? 1;
}

// Namespace br_accolades
// Params 2, eflags: 0x4
// Checksum 0x5d7b26e7, Offset: 0x323e
// Size: 0x261
function private function_915ad70efefdda6c( ref, params )
{
    playerrank = progression_utility::getrank() + 1;
    teammates = teams::getteamdata( self.team, "players" );
    
    if ( teammates.size < 2 || playerrank < 54 )
    {
        totalval = 0;
        self.var_329a26fdb0abf539[ ref ] = totalval;
        self.var_e52d4a674441a868[ ref ] = function_5af9f0891e39fe8c( ref, totalval );
        return;
    }
    
    localkills = self.pers[ "kills" ];
    localscore = self.pers[ "score" ];
    localdeaths = self.pers[ "deaths" ];
    assert( isdefined( localdeaths ) );
    secondbestscore = -1;
    
    foreach ( player in teammates )
    {
        if ( player == self )
        {
            continue;
        }
        
        pkills = player.pers[ "kills" ];
        pdeaths = player.pers[ "deaths" ];
        
        if ( pkills <= localkills || pdeaths >= localdeaths )
        {
            totalval = 0;
            secondbestscore = -1;
            break;
        }
        
        pscore = player.pers[ "score" ];
        
        if ( secondbestscore == -1 || pscore < secondbestscore )
        {
            secondbestscore = pscore;
        }
    }
    
    if ( secondbestscore > 0 )
    {
        var_9d26923f4390bbbf = getdvarfloat( @"hash_be569afee6af87f5", 0.2 );
        scoreadjust = secondbestscore * var_9d26923f4390bbbf;
        var_8bbc3f42a7319325 = ( localscore - scoreadjust ) / ( secondbestscore - scoreadjust );
        totalval = clamp( 1 - var_8bbc3f42a7319325, 0.001, 1 );
    }
    else
    {
        totalval = 0;
    }
    
    self.var_329a26fdb0abf539[ ref ] = totalval;
    self.var_e52d4a674441a868[ ref ] = function_5af9f0891e39fe8c( ref, totalval );
}

// Namespace br_accolades
// Params 2, eflags: 0x4
// Checksum 0x1c4836c2, Offset: 0x34a7
// Size: 0x71
function private function_bc0be8df35e50053( ref, params )
{
    totalval = 0;
    assert( isdefined( self.pers[ "<dev string:xbc>" ] ) );
    
    if ( self.pers[ "deaths" ] == 0 )
    {
        totalval = 0.8;
    }
    
    self.var_329a26fdb0abf539[ ref ] = totalval;
    self.var_e52d4a674441a868[ ref ] = totalval;
}

// Namespace br_accolades
// Params 2, eflags: 0x4
// Checksum 0x50285e37, Offset: 0x3520
// Size: 0x10e
function private function_4175044c15676c25( ref, params )
{
    totalval = 0;
    var_6355b03aa74e720b = currency::get_currency_amount( "cash" );
    
    if ( isdefined( var_6355b03aa74e720b ) )
    {
        totalval += var_6355b03aa74e720b * function_808f90af8000e7f1( ref, "plunderCount" );
    }
    
    if ( isdefined( params ) )
    {
        foreach ( param in params )
        {
            statvalue = self.pers[ param ];
            
            if ( isdefined( statvalue ) )
            {
                totalval += statvalue * function_808f90af8000e7f1( ref, param );
            }
        }
    }
    
    self.var_329a26fdb0abf539[ ref ] = totalval;
    self.var_e52d4a674441a868[ ref ] = function_5af9f0891e39fe8c( ref, totalval );
}

// Namespace br_accolades
// Params 2, eflags: 0x4
// Checksum 0x6891318a, Offset: 0x3636
// Size: 0x320
function private function_d303e18ec77f1a07( ref, params )
{
    if ( level.brgametype.var_aa811c5b6c109904 )
    {
        self.var_329a26fdb0abf539[ ref ] = 0;
        self.var_e52d4a674441a868[ ref ] = 0;
        return;
    }
    
    highestkills = 0;
    highestrevives = 0;
    highestassist = 0;
    highestcontracts = 0;
    highestrespawns = 0;
    successscore = 0;
    currentkills = self.pers[ "kills" ];
    currentrevives = self.pers[ "rescues" ];
    currentassist = self.pers[ "assists" ];
    currentcontracts = self.pers[ "objectivesCompleted" ];
    currentrespawns = self.pers[ "kioskRevives" ];
    textvalue = 0;
    recordname = "";
    var_3003df1e0a33e807 = "";
    
    switch ( ref )
    {
        case #"hash_1d132230c198824":
            highestkills = personal_bests::function_1c98bb816268b0f5( self, "kills_r" );
            highestrevives = personal_bests::function_1c98bb816268b0f5( self, "revives_r" );
            highestassist = personal_bests::function_1c98bb816268b0f5( self, "assist_r" );
            highestcontracts = personal_bests::function_1c98bb816268b0f5( self, "contracts_r" );
            highestrespawns = personal_bests::function_1c98bb816268b0f5( self, "respawns_r" );
            var_3003df1e0a33e807 = "_rolling";
            successscore = 0.8;
            break;
        case #"hash_37f4d05731e98df3":
            highestkills = personal_bests::function_1c98bb816268b0f5( self, "kills_s" );
            highestrevives = personal_bests::function_1c98bb816268b0f5( self, "revives_s" );
            highestassist = personal_bests::function_1c98bb816268b0f5( self, "assist_s" );
            highestcontracts = personal_bests::function_1c98bb816268b0f5( self, "contracts_s" );
            highestrespawns = personal_bests::function_1c98bb816268b0f5( self, "respawns_s" );
            var_3003df1e0a33e807 = "_seasonal";
            successscore = 0.85;
            break;
        case #"hash_ffee7a4392a7837c":
            highestkills = personal_bests::function_1c98bb816268b0f5( self, "kills_c" );
            highestrevives = personal_bests::function_1c98bb816268b0f5( self, "revives_c" );
            highestassist = personal_bests::function_1c98bb816268b0f5( self, "assist_c" );
            highestcontracts = personal_bests::function_1c98bb816268b0f5( self, "contracts_c" );
            highestrespawns = personal_bests::function_1c98bb816268b0f5( self, "respawns_c" );
            var_3003df1e0a33e807 = "_chapter";
            successscore = 0.9;
            break;
    }
    
    totalval = 0;
    
    if ( highestkills < currentkills && currentkills >= 5 )
    {
        totalval = successscore;
        recordname = "pb_kill";
        textvalue = currentkills;
    }
    else if ( highestrevives < currentrevives && currentrevives >= 3 )
    {
        totalval = successscore;
        recordname = "pb_revive";
        textvalue = currentrevives;
    }
    else if ( highestcontracts < currentcontracts && currentcontracts >= 3 )
    {
        totalval = successscore;
        recordname = "pb_contract";
        textvalue = currentcontracts;
    }
    else if ( highestrespawns < currentrespawns && currentrespawns >= 3 )
    {
        totalval = successscore;
        recordname = "pb_return";
        textvalue = currentrespawns;
    }
    
    function_515274487bb2225b( ref, totalval, recordname + var_3003df1e0a33e807, textvalue );
    self.var_329a26fdb0abf539[ ref ] = totalval;
    self.var_e52d4a674441a868[ ref ] = totalval;
}

// Namespace br_accolades
// Params 2, eflags: 0x4
// Checksum 0x2b8a7b42, Offset: 0x395e
// Size: 0x7fc
function private function_bac6190420b39271( ref, params )
{
    if ( !isdefined( level.var_b86b9ee5a392f79 ) )
    {
        level.var_b86b9ee5a392f79 = [];
        level.var_b86b9ee5a392f79[ "kills" ] = 0;
        level.var_b86b9ee5a392f79[ "rescues" ] = 0;
        level.var_b86b9ee5a392f79[ "assists" ] = 0;
        level.var_b86b9ee5a392f79[ "objectivesCompleted" ] = 0;
        level.var_b86b9ee5a392f79[ "kioskRevives" ] = 0;
        
        foreach ( teamate in level.teamdata[ self.team ][ "players" ] )
        {
            temkills = teamate.pers[ "kills" ];
            temrevives = teamate.pers[ "rescues" ];
            temassist = teamate.pers[ "assists" ];
            temcontracts = teamate.pers[ "objectivesCompleted" ];
            temrespawns = teamate.pers[ "kioskRevives" ];
            
            if ( temkills > level.var_b86b9ee5a392f79[ "kills" ] )
            {
                level.var_b86b9ee5a392f79[ "kills" ] = temkills;
            }
            
            if ( temrevives > level.var_b86b9ee5a392f79[ "rescues" ] )
            {
                level.var_b86b9ee5a392f79[ "rescues" ] = temrevives;
            }
            
            if ( temassist > level.var_b86b9ee5a392f79[ "assists" ] )
            {
                level.var_b86b9ee5a392f79[ "assists" ] = temassist;
            }
            
            if ( temcontracts > level.var_b86b9ee5a392f79[ "objectivesCompleted" ] )
            {
                level.var_b86b9ee5a392f79[ "objectivesCompleted" ] = temcontracts;
            }
            
            if ( temrespawns > level.var_b86b9ee5a392f79[ "kioskRevives" ] )
            {
                level.var_b86b9ee5a392f79[ "kioskRevives" ] = temrespawns;
            }
        }
    }
    
    highestkills = 0;
    highestrevives = 0;
    highestassist = 0;
    highestcontracts = 0;
    highestrespawns = 0;
    winrate = 0;
    top5rate = 0;
    top10rate = 0;
    top25rate = 0;
    currentkills = getdvarint( @"hash_539991935690a86a", self.pers[ "kills" ] );
    currentrevives = getdvarint( @"hash_b924a7ffec7e8bb1", self.pers[ "rescues" ] );
    currentassist = getdvarint( @"hash_e21360dea7af2ab", self.pers[ "assists" ] );
    currentcontracts = getdvarint( @"hash_f73e12236112ba9c", self.pers[ "objectivesCompleted" ] );
    currentrespawns = getdvarint( @"hash_57751008667e1135", self.pers[ "kioskRevives" ] );
    currentwins = 0;
    currenttop5 = 0;
    currenttop10 = 0;
    currenttop25 = 0;
    successscore = 0;
    textvalue = 0;
    recordname = "";
    var_3003df1e0a33e807 = "";
    
    switch ( ref )
    {
        case #"hash_cefd45a5f0651582":
            if ( isdefined( level.var_45f0ba87452c0478 ) )
            {
                highestkills = level.var_45f0ba87452c0478[ "kills_r" ];
                highestrevives = level.var_45f0ba87452c0478[ "revives_r" ];
                highestassist = level.var_45f0ba87452c0478[ "assist_r" ];
                highestcontracts = level.var_45f0ba87452c0478[ "contracts_r" ];
                highestrespawns = level.var_45f0ba87452c0478[ "respawns_r" ];
                winrate = level.var_45f0ba87452c0478[ "wins_r" ];
                top5rate = level.var_45f0ba87452c0478[ "top5_r" ];
                top10rate = level.var_45f0ba87452c0478[ "top10_r" ];
                top25rate = level.var_45f0ba87452c0478[ "top25_r" ];
            }
            
            currentwins = personal_bests::function_1c98bb816268b0f5( self, "wins_r" ) + 1;
            currenttop5 = personal_bests::function_1c98bb816268b0f5( self, "top5_r" ) + 1;
            currenttop10 = personal_bests::function_1c98bb816268b0f5( self, "top10_r" ) + 1;
            currenttop25 = personal_bests::function_1c98bb816268b0f5( self, "top25_r" ) + 1;
            successscore = 0.95;
            var_3003df1e0a33e807 = "_rolling";
            break;
        case #"hash_67540269f1b46075":
            if ( isdefined( level.var_45f0ba87452c0478 ) )
            {
                highestkills = level.var_45f0ba87452c0478[ "kills_s" ];
                highestrevives = level.var_45f0ba87452c0478[ "revives_s" ];
                highestassist = level.var_45f0ba87452c0478[ "assist_s" ];
                highestcontracts = level.var_45f0ba87452c0478[ "contracts_s" ];
                highestrespawns = level.var_45f0ba87452c0478[ "respawns_s" ];
                winrate = level.var_45f0ba87452c0478[ "wins_s" ];
                top5rate = level.var_45f0ba87452c0478[ "top5_s" ];
                top10rate = level.var_45f0ba87452c0478[ "top10_s" ];
                top25rate = level.var_45f0ba87452c0478[ "top25_s" ];
            }
            
            currentwins = personal_bests::function_1c98bb816268b0f5( self, "wins_s" ) + 1;
            currenttop5 = personal_bests::function_1c98bb816268b0f5( self, "top5_s" ) + 1;
            currenttop10 = personal_bests::function_1c98bb816268b0f5( self, "top10_s" ) + 1;
            currenttop25 = personal_bests::function_1c98bb816268b0f5( self, "top25_s" ) + 1;
            successscore = 0.98;
            var_3003df1e0a33e807 = "_seasonal";
            break;
        case #"hash_5d9ccfc77ef0e622":
            if ( isdefined( level.var_45f0ba87452c0478 ) )
            {
                highestkills = level.var_45f0ba87452c0478[ "kills_c" ];
                highestrevives = level.var_45f0ba87452c0478[ "revives_c" ];
                highestassist = level.var_45f0ba87452c0478[ "assist_c" ];
                highestcontracts = level.var_45f0ba87452c0478[ "contracts_c" ];
                highestrespawns = level.var_45f0ba87452c0478[ "respawns_c" ];
                winrate = level.var_45f0ba87452c0478[ "wins_c" ];
                top5rate = level.var_45f0ba87452c0478[ "top5_c" ];
                top10rate = level.var_45f0ba87452c0478[ "top10_c" ];
                top25rate = level.var_45f0ba87452c0478[ "top25_c" ];
            }
            
            currentwins = personal_bests::function_1c98bb816268b0f5( self, "wins_c" ) + 1;
            currenttop5 = personal_bests::function_1c98bb816268b0f5( self, "top5_c" ) + 1;
            currenttop10 = personal_bests::function_1c98bb816268b0f5( self, "top10_c" ) + 1;
            currenttop25 = personal_bests::function_1c98bb816268b0f5( self, "top25_c" ) + 1;
            successscore = 1;
            var_3003df1e0a33e807 = "_chapter";
            break;
    }
    
    totalval = 0;
    
    if ( highestkills < currentkills && currentkills >= 5 && highestkills >= level.var_b86b9ee5a392f79[ "kills" ] )
    {
        totalval = successscore;
        recordname = "mb_kill";
        textvalue = currentkills;
    }
    else if ( highestrevives < currentrevives && currentrevives >= 3 && highestrevives >= level.var_b86b9ee5a392f79[ "rescues" ] )
    {
        totalval = successscore;
        recordname = "mb_revive";
        textvalue = currentrevives;
    }
    else if ( highestcontracts < currentcontracts && currentcontracts >= 3 && highestcontracts >= level.var_b86b9ee5a392f79[ "objectivesCompleted" ] )
    {
        totalval = successscore;
        recordname = "mb_contract";
        textvalue = currentcontracts;
    }
    else if ( highestrespawns < currentrespawns && currentrespawns >= 3 && highestrespawns >= level.var_b86b9ee5a392f79[ "kioskRevives" ] )
    {
        totalval = successscore;
        recordname = "mb_return";
        textvalue = currentrespawns;
    }
    
    function_515274487bb2225b( ref, totalval, recordname + var_3003df1e0a33e807, textvalue );
    self.var_329a26fdb0abf539[ ref ] = totalval;
    self.var_e52d4a674441a868[ ref ] = totalval;
}

// Namespace br_accolades
// Params 4, eflags: 0x4
// Checksum 0xf5696b8, Offset: 0x4162
// Size: 0x82
function private function_515274487bb2225b( ref, scorevalue, overridename, textvalue )
{
    if ( scorevalue > 0 && !level.var_62cdbc0387b3d149[ getxhash( ref ) ] )
    {
        if ( !isdefined( self.var_327968da5c5c251f ) || self.var_e9766b6648e4d6d3 < scorevalue )
        {
            self.var_327968da5c5c251f = overridename;
            self.var_e9766b6648e4d6d3 = scorevalue;
            self.var_eaf258efcfee7bdd = textvalue;
        }
    }
}

// Namespace br_accolades
// Params 2, eflags: 0x4
// Checksum 0x96d10b77, Offset: 0x41ec
// Size: 0xa4
function private function_4429a60cda1f1713( ref, params )
{
    totalkills = self.pers[ "kills" ];
    totalassists = self.pers[ "assists" ];
    var_b572c2b4dd213ed2 = self.pers[ "agentKills" ];
    totalval = 100 - 100 * totalkills + 3 * totalassists + 10 * var_b572c2b4dd213ed2;
    self.var_329a26fdb0abf539[ ref ] = totalval;
    self.var_e52d4a674441a868[ ref ] = function_5af9f0891e39fe8c( ref, totalval );
}

// Namespace br_accolades
// Params 2
// Checksum 0x2c53084f, Offset: 0x4298
// Size: 0x108
function function_84aa228f9df7c6fa( ref, params )
{
    totalval = 0;
    
    if ( isdefined( self.lootcachesopened ) )
    {
        totalval += self.lootcachesopened * function_808f90af8000e7f1( ref, "lootCachesOpened" );
    }
    
    if ( isdefined( params ) )
    {
        foreach ( param in params )
        {
            statvalue = self.pers[ param ];
            
            if ( isdefined( statvalue ) )
            {
                totalval += statvalue * function_808f90af8000e7f1( ref, param );
            }
        }
    }
    
    self.var_329a26fdb0abf539[ ref ] = totalval;
    self.var_e52d4a674441a868[ ref ] = function_5af9f0891e39fe8c( ref, totalval );
}

// Namespace br_accolades
// Params 2, eflags: 0x4
// Checksum 0xd2d9abcb, Offset: 0x43a8
// Size: 0x106
function private function_b5cc5009111cdd3( ref, params )
{
    totalval = 0;
    
    if ( isdefined( self.brmissionscompleted ) )
    {
        totalval += self.brmissionscompleted * function_808f90af8000e7f1( ref, "brMissionsCompleted" );
    }
    
    if ( isdefined( params ) )
    {
        foreach ( param in params )
        {
            if ( isdefined( self.pers[ param ] ) )
            {
                totalval += self.pers[ param ] * function_808f90af8000e7f1( ref, param );
            }
        }
    }
    
    self.var_329a26fdb0abf539[ ref ] = totalval;
    self.var_e52d4a674441a868[ ref ] = function_5af9f0891e39fe8c( ref, totalval );
}

// Namespace br_accolades
// Params 2, eflags: 0x4
// Checksum 0x3eac08c7, Offset: 0x44b6
// Size: 0x39
function private function_7a93d1dd6ea83c81( ref, params )
{
    self.var_329a26fdb0abf539[ ref ] = -1;
    self.var_e52d4a674441a868[ ref ] = -1;
}

// Namespace br_accolades
// Params 2, eflags: 0x4
// Checksum 0xf0f9230f, Offset: 0x44f7
// Size: 0x13e
function private function_5af9f0891e39fe8c( ref, value )
{
    data = level.var_c99fd4f0f41403f8[ ref ];
    
    if ( !isdefined( data.floor ) || value < data.floor )
    {
        return -1;
    }
    
    if ( isdefined( data.maxvalue ) )
    {
        value = min( value, data.maxvalue );
        
        if ( isdefined( data.minvalue ) )
        {
            minvalue = data.minvalue;
        }
        else if ( data.scale == 1 )
        {
            minvalue = data.maxvalue * -0.1;
        }
        else
        {
            minvalue = 0;
        }
        
        assert( data.maxvalue > minvalue );
        value = float( value - minvalue ) / float( data.maxvalue - minvalue );
    }
    
    if ( data.scale == 2 )
    {
        value = pow( value, 1.2 );
    }
    
    if ( isdefined( data.weight ) )
    {
        value *= data.weight;
    }
    
    return value;
}

// Namespace br_accolades
// Params 2
// Checksum 0x2a9006d2, Offset: 0x463e
// Size: 0xe4
function function_eddb6c60c24708f4( ref, data_points )
{
    assert( isdefined( data_points ) );
    totalval = 0;
    
    foreach ( data_point in data_points )
    {
        val = self.pers[ data_point ];
        
        if ( isdefined( val ) )
        {
            totalval += val * function_808f90af8000e7f1( ref, data_point );
        }
    }
    
    self.var_329a26fdb0abf539[ ref ] = totalval;
    self.var_e52d4a674441a868[ ref ] = function_5af9f0891e39fe8c( ref, totalval );
}

// Namespace br_accolades
// Params 2, eflags: 0x4
// Checksum 0xdfa2e60b, Offset: 0x472a
// Size: 0x1a6
function private function_941672981beea97c( ref, params )
{
    totalkills = 0;
    addcategories = [ "pistolKills", "shotgunKills", "smgKills", "arKills", "lmgKills", "sniperKills" ];
    subtractcategories = [ "longshotKills", "pointBlankKills" ];
    
    foreach ( statref in addcategories )
    {
        val = self.pers[ statref ];
        
        if ( isdefined( val ) )
        {
            totalkills += val;
        }
    }
    
    foreach ( statref in subtractcategories )
    {
        val = self.pers[ statref ];
        
        if ( isdefined( val ) )
        {
            totalkills -= val;
        }
    }
    
    self.var_329a26fdb0abf539[ ref ] = totalkills;
    self.var_e52d4a674441a868[ ref ] = function_5af9f0891e39fe8c( ref, totalkills );
}

// Namespace br_accolades
// Params 2, eflags: 0x4
// Checksum 0x4a4fafa5, Offset: 0x48d8
// Size: 0x56
function private function_6c50123a61b25c9c( ref, params )
{
    otherstats = [];
    
    if ( isdefined( self.timesdowned ) )
    {
        otherstats[ "timesDowned" ] = self.timesdowned;
    }
    else
    {
        otherstats[ "timesDowned" ] = 0;
    }
    
    return function_10fcd83e29352214( ref, params, otherstats );
}

// Namespace br_accolades
// Params 2, eflags: 0x4
// Checksum 0xc53a9e40, Offset: 0x4937
// Size: 0x5a
function private function_81f48fe88a6adfd( ref, params )
{
    otherstats = [];
    
    if ( isdefined( currency::get_currency_amount( "cash" ) ) )
    {
        otherstats[ "plunderCount" ] = currency::get_currency_amount( "cash" );
    }
    else
    {
        otherstats[ "plunderCount" ] = 0;
    }
    
    return function_10fcd83e29352214( ref, params, otherstats );
}

// Namespace br_accolades
// Params 2
// Checksum 0xaabaaad0, Offset: 0x499a
// Size: 0x56
function function_80887eaedadb3f52( ref, params )
{
    otherstats = [];
    
    if ( isdefined( self.lootcachesopened ) )
    {
        otherstats[ "lootCachesOpened" ] = self.lootcachesopened;
    }
    else
    {
        otherstats[ "lootCachesOpened" ] = 0;
    }
    
    return function_10fcd83e29352214( ref, params, otherstats );
}

// Namespace br_accolades
// Params 2, eflags: 0x4
// Checksum 0xd881e07a, Offset: 0x49f9
// Size: 0x56
function private function_6574dc42721b7103( ref, params )
{
    otherstats = [];
    
    if ( isdefined( self.brmissionscompleted ) )
    {
        otherstats[ "brMissionsCompleted" ] = self.brmissionscompleted;
    }
    else
    {
        otherstats[ "brMissionsCompleted" ] = 0;
    }
    
    return function_10fcd83e29352214( ref, params, otherstats );
}

// Namespace br_accolades
// Params 2, eflags: 0x4
// Checksum 0xeab82ae5, Offset: 0x4a58
// Size: 0x1a1
function private function_fd4050a549355476( ref, params )
{
    totalkills = 0;
    addcategories = [ "pistolKills", "shotgunKills", "smgKills", "arKills", "lmgKills", "sniperKills" ];
    subtractcategories = [ "longshotKills", "pointBlankKills" ];
    
    foreach ( statref in addcategories )
    {
        val = self.pers[ statref ];
        
        if ( isdefined( val ) )
        {
            totalkills += val;
        }
    }
    
    foreach ( statref in subtractcategories )
    {
        val = self.pers[ statref ];
        
        if ( isdefined( val ) )
        {
            totalkills -= val;
        }
    }
    
    otherstats = [];
    otherstats[ "midRangeKills" ] = totalkills;
    return function_10fcd83e29352214( ref, params, otherstats );
}

// Namespace br_accolades
// Params 2
// Checksum 0x4f7c8eac, Offset: 0x4c02
// Size: 0x1e
function function_8cc3b9237083988e( ref, params )
{
    return function_10fcd83e29352214( ref, params );
}

// Namespace br_accolades
// Params 3, eflags: 0x4
// Checksum 0xb52c61ad, Offset: 0x4c29
// Size: 0x1f7
function private function_10fcd83e29352214( ref, persstats, otherstats )
{
    data = spawnstruct();
    data.ref = ref;
    data.statdata = [];
    totalval = 0;
    
    if ( isdefined( persstats ) )
    {
        foreach ( stat in persstats )
        {
            value = 0;
            scaledval = 0;
            
            if ( isdefined( self.pers[ stat ] ) )
            {
                value = self.pers[ stat ];
                scaledval = value * function_808f90af8000e7f1( ref, stat );
                totalval += scaledval;
            }
            
            data.statdata[ stat ][ 0 ] = value;
            data.statdata[ stat ][ 1 ] = scaledval;
        }
    }
    
    if ( isdefined( otherstats ) )
    {
        foreach ( stat, value in otherstats )
        {
            if ( isdefined( value ) )
            {
                scaledval = value * function_808f90af8000e7f1( ref, stat );
                totalval += scaledval;
                data.statdata[ stat ][ 0 ] = value;
                data.statdata[ stat ][ 1 ] = scaledval;
            }
        }
    }
    
    data.value = totalval;
    data.scaledvalue = function_5af9f0891e39fe8c( ref, totalval );
    return data;
}

// Namespace br_accolades
// Params 0
// Checksum 0x57c9d648, Offset: 0x4e29
// Size: 0x261
function function_120eafa7f2ef1e47()
{
    accolades = [];
    
    foreach ( ref, entry in level.var_c99fd4f0f41403f8 )
    {
        assert( isdefined( entry.datafunc ) );
        data = self [[ entry.datafunc ]]( ref, entry.scoreparams );
        accoladedata = spawnstruct();
        accoladedata.ref = ref;
        value = 0;
        scaledvalue = 0;
        
        if ( isdefined( data.value ) )
        {
            value = max( data.value, value );
        }
        
        if ( isdefined( data.scaledvalue ) )
        {
            scaledvalue = max( data.scaledvalue, scaledvalue );
        }
        
        accoladedata.value = value;
        accoladedata.scaledvalue = scaledvalue;
        var_270fb3facb42ea0b = [];
        
        foreach ( sref, entry in data.statdata )
        {
            svalue = 0;
            var_ad173a756af60b26 = 0;
            
            if ( entry.size >= 2 )
            {
                if ( isdefined( entry[ 0 ] ) )
                {
                    svalue = max( 0, entry[ 0 ] );
                }
                
                if ( isdefined( entry[ 1 ] ) )
                {
                    var_ad173a756af60b26 = max( 0, entry[ 1 ] );
                }
            }
            
            var_270fb3facb42ea0b[ var_270fb3facb42ea0b.size ] = [ "stat", sref, "value", svalue, "scaledvalue", var_ad173a756af60b26 ];
        }
        
        accoladedata.stats = var_270fb3facb42ea0b;
        accolades[ accolades.size ] = accoladedata;
    }
    
    return accolades;
}

// Namespace br_accolades
// Params 1
// Checksum 0x659fee60, Offset: 0x5093
// Size: 0x755
function function_8ffb08c901d9d792( winners )
{
    winnerplayers = [];
    
    foreach ( player in winners )
    {
        if ( isplayer( player ) && function_14ba07f756afb4e5( player ) )
        {
            player.var_4f97df463efd71b5 = undefined;
            player.var_235f7c770e4f3bb0 = [];
            player.var_329a26fdb0abf539 = [];
            player.var_e52d4a674441a868 = [];
            player.var_f60031aca22cc8dc = 0;
            winnerplayers[ winnerplayers.size ] = player;
        }
    }
    
    foreach ( ref, entry in level.var_c99fd4f0f41403f8 )
    {
        assert( isdefined( entry.scorefunc ) );
        
        foreach ( player in winnerplayers )
        {
            assert( !isdefined( player.var_329a26fdb0abf539[ ref ] ) );
            assert( !isdefined( player.var_e52d4a674441a868[ ref ] ) );
            player [[ entry.scorefunc ]]( ref, entry.scoreparams );
        }
    }
    
    if ( level.var_4bd1e8461213f19 )
    {
        [[ level.var_4bd1e8461213f19 ]]( winnerplayers );
        return;
    }
    
    foreach ( ref, entry in level.var_c99fd4f0f41403f8 )
    {
        var_2f06c7d44fc7af1c = 0;
        
        foreach ( player in winnerplayers )
        {
            if ( player.var_329a26fdb0abf539[ ref ] > var_2f06c7d44fc7af1c && player.var_e52d4a674441a868[ ref ] >= 0 )
            {
                var_2f06c7d44fc7af1c = player.var_329a26fdb0abf539[ ref ];
            }
            
            player.var_f60031aca22cc8dc += player.var_e52d4a674441a868[ ref ];
        }
        
        foreach ( player in winnerplayers )
        {
            if ( player.var_e52d4a674441a868[ ref ] >= 0 && player.var_329a26fdb0abf539[ ref ] == var_2f06c7d44fc7af1c )
            {
                player.var_235f7c770e4f3bb0[ player.var_235f7c770e4f3bb0.size ] = ref;
            }
        }
    }
    
    var_12ff4473b4def9de = [];
    
    foreach ( player in winnerplayers )
    {
        bestref = function_ee3fdbf51aaa8b56( player );
        
        if ( !isdefined( bestref ) )
        {
            var_1cdecb01d1fba8cb = -1;
            
            foreach ( ref in player.var_235f7c770e4f3bb0 )
            {
                if ( level.var_62cdbc0387b3d149[ getxhash( ref ) ] )
                {
                    continue;
                }
                
                if ( player.var_e52d4a674441a868[ ref ] > var_1cdecb01d1fba8cb )
                {
                    var_1cdecb01d1fba8cb = player.var_e52d4a674441a868[ ref ];
                    bestref = ref;
                }
            }
        }
        
        if ( isdefined( bestref ) )
        {
            player.var_4f97df463efd71b5 = bestref;
            var_12ff4473b4def9de[ var_12ff4473b4def9de.size ] = bestref;
        }
    }
    
    participationawards = [ "survivor", "scout", "scavenger", "ghost" ];
    participationawards = arrayrandomize( participationawards );
    participationawards[ participationawards.size ] = "killer";
    participationawards[ participationawards.size ] = "breacher";
    participationawards[ participationawards.size ] = "moneybags";
    
    for ( i = participationawards.size - 1; i >= 0 ; i-- )
    {
        testref = participationawards[ i ];
        
        if ( arraycontains( var_12ff4473b4def9de, testref ) )
        {
            participationawards[ i ] = undefined;
            
            if ( isint( i ) )
            {
                function_cdc669dbc8ea2101( participationawards );
            }
        }
    }
    
    awardindex = 0;
    
    foreach ( player in winnerplayers )
    {
        var_253a9048e8930294 = 0;
        
        if ( !isdefined( player.var_4f97df463efd71b5 ) )
        {
            assert( awardindex < participationawards.size );
            player.var_4f97df463efd71b5 = participationawards[ awardindex ];
            var_253a9048e8930294 = 1;
            awardindex++;
            var_12ff4473b4def9de[ var_12ff4473b4def9de.size ] = participationawards[ awardindex ];
        }
        
        var_a4dd02422f990404 = player.var_329a26fdb0abf539[ player.var_4f97df463efd71b5 ] ?? 0;
        scaledval = player.var_e52d4a674441a868[ player.var_4f97df463efd71b5 ] ?? 0;
        player dlog_recordplayerevent( "dlog_event_br_winner_accolade_data", [ "accolade", player.var_4f97df463efd71b5, "is_participation_trophy", var_253a9048e8930294, "value", float( var_a4dd02422f990404 ), "scaled_value", float( scaledval ) ] );
        player.var_235f7c770e4f3bb0 = undefined;
        player.var_329a26fdb0abf539 = undefined;
        player.var_e52d4a674441a868 = undefined;
    }
}

// Namespace br_accolades
// Params 1, eflags: 0x4
// Checksum 0x5e49ce6e, Offset: 0x57f0
// Size: 0x4d
function private function_305e0aa767b6b8eb( winners )
{
    for ( i = 0; i < winners.size ; i++ )
    {
        player = winners[ i ];
        
        if ( isplayer( player ) && function_14ba07f756afb4e5( player ) )
        {
            return i;
        }
    }
}

// Namespace br_accolades
// Params 2, eflags: 0x4
// Checksum 0xd467c25f, Offset: 0x5846
// Size: 0x84
function private function_df954600dd3d7ea( winners, index )
{
    assert( index < winners.size );
    assert( isplayer( winners[ index ] ) );
    
    for ( tryindex = ( index + 1 ) % winners.size; tryindex != index ; tryindex = ( index + 1 ) % winners.size )
    {
        player = winners[ tryindex ];
        
        if ( isplayer( player ) && function_14ba07f756afb4e5( player ) )
        {
            return tryindex;
        }
    }
    
    return tryindex;
}

// Namespace br_accolades
// Params 1, eflags: 0x4
// Checksum 0xc85f0bc7, Offset: 0x58d3
// Size: 0x528
function private function_ee3fdbf51aaa8b56( player )
{
    /#
        devaccolade = getdvar( @"hash_7aa741226ec758e3", "<dev string:x24>" );
        
        if ( isdefined( level.var_c99fd4f0f41403f8[ devaccolade ] ) )
        {
            return devaccolade;
        }
        
        stringlist = strtok( getdvar( @"hash_b217b1fd0c1301e2", "<dev string:x24>" ), "<dev string:xc3>" );
        
        if ( stringlist.size > 2 )
        {
            devaccolade = stringlist[ 0 ];
            
            if ( isdefined( level.var_c99fd4f0f41403f8[ devaccolade ] ) )
            {
                stringref = stringlist[ 1 ];
                textvalue = int( stringlist[ 2 ] );
                
                if ( !isnumber( textvalue ) )
                {
                    textvalue = 0;
                }
                
                player function_515274487bb2225b( devaccolade, 999, stringref, textvalue );
                return devaccolade;
            }
        }
    #/
    
    if ( utility::issharedfuncdefined( #"gametype", #"hash_ee4ee436d7fa9e38" ) )
    {
        var_61b7b2a7b1b1ad5d = utility::callsharedfunc( #"gametype", #"hash_ee4ee436d7fa9e38", player );
        
        if ( var_61b7b2a7b1b1ad5d )
        {
            return var_61b7b2a7b1b1ad5d;
        }
    }
    
    if ( player.var_e52d4a674441a868[ "highachiever_coolest" ] > 0 && !level.var_62cdbc0387b3d149[ #"highachiever_coolest" ] )
    {
        return "highachiever_coolest";
    }
    
    if ( player.var_e52d4a674441a868[ "highachiever_cooler" ] > 0 && !level.var_62cdbc0387b3d149[ #"highachiever_cooler" ] )
    {
        return "highachiever_cooler";
    }
    
    if ( player.var_e52d4a674441a868[ "highachiever_cool" ] > 0 && !level.var_62cdbc0387b3d149[ #"highachiever_cool" ] )
    {
        return "highachiever_cool";
    }
    
    if ( player.var_e52d4a674441a868[ "medalist_coolest" ] > 0 && !level.var_62cdbc0387b3d149[ #"medalist_coolest" ] )
    {
        return "medalist_coolest";
    }
    
    if ( player.var_e52d4a674441a868[ "medalist_cooler" ] > 0 && !level.var_62cdbc0387b3d149[ #"medalist_cooler" ] )
    {
        return "medalist_cooler";
    }
    
    if ( player.var_e52d4a674441a868[ "medalist_cool" ] > 0 && !level.var_62cdbc0387b3d149[ #"medalist_cool" ] )
    {
        return "medalist_cool";
    }
    
    var_8b8f4fb949a8a0d8 = 0;
    
    foreach ( ref, entry in level.var_c99fd4f0f41403f8 )
    {
        if ( arraycontains( level.var_17a6232c5dad4ffe, ref ) )
        {
            continue;
        }
        
        if ( player.var_e52d4a674441a868[ ref ] >= 0.75 )
        {
            var_8b8f4fb949a8a0d8++;
        }
    }
    
    if ( var_8b8f4fb949a8a0d8 >= 7 && !level.var_62cdbc0387b3d149[ #"tryhard_coolest" ] )
    {
        return "tryhard_coolest";
    }
    
    if ( var_8b8f4fb949a8a0d8 >= 5 && !level.var_62cdbc0387b3d149[ #"tryhard_cooler" ] )
    {
        return "tryhard_cooler";
    }
    
    if ( var_8b8f4fb949a8a0d8 >= 3 && !level.var_62cdbc0387b3d149[ #"tryhard_cool" ] )
    {
        return "tryhard_cool";
    }
    
    localkills = player.pers[ "kills" ];
    teammates = teams::getteamdata( player.team, "players" );
    
    foreach ( tmate in teammates )
    {
        if ( player == tmate )
        {
            continue;
        }
        
        pkills = tmate.pers[ "kills" ];
        
        if ( localkills >= pkills )
        {
            return;
        }
    }
    
    playerrank = player progression_utility::getrank() + 1;
    
    if ( teammates.size < 2 || playerrank < 54 )
    {
        return;
    }
    
    weakestlinkthreshold = getdvarfloat( @"hash_9c40aa930664958a", 0.25 );
    
    foreach ( ref, entry in level.var_c99fd4f0f41403f8 )
    {
        if ( arraycontains( level.var_17a6232c5dad4ffe, ref ) )
        {
            continue;
        }
        
        if ( player.var_e52d4a674441a868[ ref ] >= weakestlinkthreshold )
        {
            return;
        }
    }
    
    if ( isdefined( level.var_c99fd4f0f41403f8[ "weakestlink" ] ) && !level.var_62cdbc0387b3d149[ #"weakestlink" ] )
    {
        return "weakestlink";
    }
}

// Namespace br_accolades
// Params 3
// Checksum 0xc0e8356b, Offset: 0x5e04
// Size: 0x509
function function_53910fe003f40d9( winners, var_6d87168a0c29eeaa, var_f754ef14b29cf391 )
{
    level.var_2dd8c7a5ed41f9d9 = [];
    
    if ( isdefined( var_f754ef14b29cf391 ) )
    {
        foreach ( idx, winner in winners )
        {
            if ( !isplayer( winner ) || winner iscodcaster() || !function_14ba07f756afb4e5( winner ) )
            {
                continue;
            }
            
            if ( var_f754ef14b29cf391[ idx ] && isdefined( level.var_c99fd4f0f41403f8[ var_f754ef14b29cf391[ idx ] ] ) )
            {
                accoladestruct = { #player:winner, #ref:var_f754ef14b29cf391[ idx ] };
                level.var_2dd8c7a5ed41f9d9[ level.var_2dd8c7a5ed41f9d9.size ] = accoladestruct;
                continue;
            }
            
            assert( isdefined( winner.var_4f97df463efd71b5 ) );
            accoladestruct = { #player:winner, #ref:winner.var_4f97df463efd71b5 };
            level.var_2dd8c7a5ed41f9d9[ level.var_2dd8c7a5ed41f9d9.size ] = accoladestruct;
        }
        
        return;
    }
    
    /#
        if ( getdvarint( @"hash_dc744c8d367adc1a", 0 ) )
        {
            foreach ( ref, entry in level.var_c99fd4f0f41403f8 )
            {
                accoladestruct = spawnstruct();
                accoladestruct.ref = ref;
                accoladestruct.player = level.players[ 0 ];
                level.var_2dd8c7a5ed41f9d9[ level.var_2dd8c7a5ed41f9d9.size ] = accoladestruct;
            }
            
            return;
        }
    #/
    
    switch ( var_6d87168a0c29eeaa )
    {
        case 0:
            return;
        case 1:
            foreach ( player in winners )
            {
                if ( !isplayer( player ) || player iscodcaster() || !function_14ba07f756afb4e5( winner ) )
                {
                    continue;
                }
                
                assert( isdefined( player.var_4f97df463efd71b5 ) );
                accoladestruct = spawnstruct();
                accoladestruct.ref = player.var_4f97df463efd71b5;
                accoladestruct.player = player;
                level.var_2dd8c7a5ed41f9d9[ level.var_2dd8c7a5ed41f9d9.size ] = accoladestruct;
            }
            
            break;
        case 2:
            var_a86d10b3e11c0bfa = arrayrandomize( level.var_c99fd4f0f41403f8 );
            winnerindex = function_305e0aa767b6b8eb( winners );
            
            if ( isdefined( winnerindex ) )
            {
                foreach ( ref, entry in var_a86d10b3e11c0bfa )
                {
                    accoladestruct = spawnstruct();
                    accoladestruct.ref = ref;
                    accoladestruct.player = winners[ winnerindex ];
                    winnerindex = function_df954600dd3d7ea( winners, winnerindex );
                    level.var_2dd8c7a5ed41f9d9[ level.var_2dd8c7a5ed41f9d9.size ] = accoladestruct;
                }
            }
            
            break;
        case 3:
            var_d4506e61003ffc29 = arrayrandomize( level.var_c99fd4f0f41403f8 );
            index = 0;
            
            foreach ( player in winners )
            {
                if ( !isplayer( player ) || player iscodcaster() || !function_14ba07f756afb4e5( winner ) )
                {
                    continue;
                }
                
                accoladestruct = spawnstruct();
                accoladestruct.ref = getarraykey( var_d4506e61003ffc29, index );
                accoladestruct.player = player;
                level.var_2dd8c7a5ed41f9d9[ level.var_2dd8c7a5ed41f9d9.size ] = accoladestruct;
                index++;
            }
            
            break;
        default:
            return;
    }
}

/#

    // Namespace br_accolades
    // Params 0
    // Checksum 0x1320f925, Offset: 0x6315
    // Size: 0x9b2, Type: dev
    function accoladedebug()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            dvar = hashcat( @"hash_3f0db1f9a7328433" );
            dvarvalue = getdvar( dvar, "<dev string:x24>" );
            
            if ( dvarvalue )
            {
                setdvar( dvar, "<dev string:x24>" );
                player = getplayerinstance( dvarvalue );
                
                if ( !isdefined( player ) && dvarvalue == 1 )
                {
                    player = level.players[ 0 ];
                }
                
                if ( isdefined( player ) )
                {
                    foreach ( ref, entry in level.var_c99fd4f0f41403f8 )
                    {
                        player function_b63a6125275d09bf( ref );
                    }
                }
            }
            
            dvar = hashcat( @"hash_e3d738ab702f7f92" );
            dvarvalue = getdvar( dvar, "<dev string:x24>" );
            
            if ( dvarvalue )
            {
                setdvar( dvar, "<dev string:x24>" );
                player = getplayerinstance( dvarvalue );
                
                if ( !isdefined( player ) && dvarvalue == 1 )
                {
                    player = level.players[ 0 ];
                }
                
                if ( isdefined( player ) )
                {
                    foreach ( ref, entry in level.var_c99fd4f0f41403f8 )
                    {
                        player function_a262af3f8e641af( ref );
                    }
                }
            }
            
            dvar = hashcat( @"hash_4ceb5a58a8157672" );
            dvarvalue = getdvar( dvar, "<dev string:x24>" );
            
            if ( dvarvalue )
            {
                setdvar( dvar, "<dev string:x24>" );
                splitval = strtok( dvarvalue, "<dev string:xc3>" );
                
                if ( splitval.size == 2 )
                {
                    player = getplayerinstance( splitval[ 0 ] );
                    accoladeref = splitval[ 1 ];
                }
                else if ( splitval.size == 1 )
                {
                    player = level.players[ 0 ];
                    accoladeref = splitval[ 0 ];
                }
                else
                {
                    continue;
                }
                
                if ( isdefined( level.var_c99fd4f0f41403f8[ accoladeref ] ) )
                {
                    player function_b63a6125275d09bf( accoladeref );
                }
            }
            
            dvar = hashcat( @"hash_5e93c048f094d7bf" );
            dvarvalue = getdvar( dvar, "<dev string:x24>" );
            
            if ( dvarvalue )
            {
                setdvar( dvar, "<dev string:x24>" );
                splitval = strtok( dvarvalue, "<dev string:xc3>" );
                
                if ( splitval.size == 2 )
                {
                    player = getplayerinstance( splitval[ 0 ] );
                    accoladeref = splitval[ 1 ];
                }
                else if ( splitval.size == 1 )
                {
                    player = level.players[ 0 ];
                    accoladeref = splitval[ 0 ];
                }
                else
                {
                    continue;
                }
                
                if ( isdefined( level.var_c99fd4f0f41403f8[ accoladeref ] ) )
                {
                    player function_a262af3f8e641af( accoladeref );
                }
            }
            
            dvar = hashcat( @"hash_9cb0618347057bc3" );
            dvarvalue = getdvar( dvar, "<dev string:x24>" );
            
            if ( dvarvalue && dvarvalue != "<dev string:x24>" )
            {
                setdvar( dvar, "<dev string:x24>" );
                args = strtok( dvarvalue, "<dev string:xc3>" );
                accolade = undefined;
                targetplayer = undefined;
                cmd = "<dev string:xc5>";
                invalidarg = undefined;
                
                if ( !isdefined( level.br_accolade_debug ) )
                {
                    level.br_accolade_debug = {};
                }
                
                if ( !isdefined( level.br_accolade_debug.forceaccolade ) )
                {
                    level.br_accolade_debug.forceaccolade = [];
                }
                
                foreach ( str in args )
                {
                    lcstr = tolower( str );
                    
                    switch ( lcstr )
                    {
                        case #"hash_5a8d14336374968":
                        case #"hash_1dab0b406634b739":
                        case #"hash_26e0c820439ee80b":
                        case #"hash_82dd7c3e206217c2":
                        case #"hash_e0366240399a02f9":
                        case #"hash_e9d9fcb8daba8602":
                            cmd = lcstr;
                            break;
                        default:
                            if ( level.var_3abb05bb58a5e16e[ lcstr ] )
                            {
                                accolade = lcstr;
                            }
                            else
                            {
                                targetplayer = function_9970128b45efc7ef( lcstr );
                                
                                if ( !targetplayer )
                                {
                                    invalidarg = str;
                                }
                            }
                            
                            break;
                    }
                    
                    if ( invalidarg )
                    {
                        break;
                    }
                }
                
                printx = 275;
                printy = 275;
                scale = 1.5;
                displayms = 3000;
                color = ( 1, 1, 1 );
                
                switch ( cmd )
                {
                    case #"hash_26e0c820439ee80b":
                        var_dfde98c8d290436c = 25;
                        lines = [ "<dev string:xf8>", "<dev string:x109>" ];
                        labelsize = lines.size;
                        
                        if ( level.br_accolade_debug.forceaccolade )
                        {
                            foreach ( xuid, struct in level.br_accolade_debug.forceaccolade )
                            {
                                lines[ lines.size ] = struct.player.name + "<dev string:x11b>" + struct.accolade;
                            }
                        }
                        
                        displayms += 3000 * ( lines.size - labelsize );
                        
                        for ( i = 0; i < lines.size ; i++ )
                        {
                            yoffset = var_dfde98c8d290436c * i + ( i > 0 && i < labelsize ? -5 : 0 );
                            x = printx;
                            y = printy + yoffset;
                            printtoscreen2d( x, y, lines[ i ], color, scale, int( displayms / getframeduration() ) );
                        }
                        
                        break;
                    case #"hash_1dab0b406634b739":
                        if ( level.var_279f94bca5c68d06 )
                        {
                            level.var_279f94bca5c68d06.forceaccolade = [];
                        }
                        
                        printtoscreen2d( printx, printy, "<dev string:x11e>", color, scale, int( displayms / getframeduration() ) );
                        break;
                    case #"hash_e0366240399a02f9":
                        accoladerefs = getarraykeys( level.var_c99fd4f0f41403f8 );
                        var_d6134c51135e1a10 = 0;
                        
                        foreach ( player in level.players )
                        {
                            if ( !player )
                            {
                                continue;
                            }
                            
                            xuid = player getxuid();
                            
                            if ( xuid )
                            {
                                level.br_accolade_debug.forceaccolade[ xuid ] = { #player:player, #accolade:utility::array_random( accoladerefs ) };
                                var_d6134c51135e1a10++;
                            }
                        }
                        
                        printtoscreen2d( printx, printy, "<dev string:x13b>" + var_d6134c51135e1a10 + "<dev string:x158>", color, scale, int( displayms / getframeduration() ) );
                        break;
                    default:
                        if ( invalidarg )
                        {
                            resulttext = "<dev string:x161>" + invalidarg + "<dev string:x189>";
                        }
                        else
                        {
                            if ( !isdefined( targetplayer ) )
                            {
                                targetplayer = function_9970128b45efc7ef();
                            }
                            
                            if ( !targetplayer )
                            {
                                resulttext = "<dev string:x18b>";
                                var_54602998648785f0 = 1;
                            }
                            
                            if ( !var_54602998648785f0 )
                            {
                                xuid = targetplayer getxuid();
                                
                                switch ( cmd )
                                {
                                    case #"hash_e9d9fcb8daba8602":
                                        if ( level.br_accolade_debug.forceaccolade[ xuid ] )
                                        {
                                            level.br_accolade_debug.forceaccolade[ xuid ] = undefined;
                                        }
                                        
                                        break;
                                    case #"hash_8ff3986c5518a2e3":
                                        if ( accolade )
                                        {
                                            level.br_accolade_debug.forceaccolade[ xuid ] = { #player:targetplayer, #accolade:accolade };
                                        }
                                        
                                        break;
                                    case #"hash_82dd7c3e206217c2":
                                        accoladerefs = getarraykeys( level.var_c99fd4f0f41403f8 );
                                        level.br_accolade_debug.forceaccolade[ xuid ] = { #player:targetplayer, #accolade:utility::array_random( accoladerefs ) };
                                        break;
                                }
                                
                                resulttext = "<dev string:x189>" + targetplayer.name + "<dev string:x1bb>" + ( level.br_accolade_debug.forceaccolade[ xuid ].accolade ? level.br_accolade_debug.forceaccolade[ xuid ].accolade : "<dev string:x1cf>" );
                            }
                        }
                        
                        printtoscreen2d( printx, printy, resulttext, color, scale, int( displayms / getframeduration() ) );
                        break;
                }
            }
            
            wait 1;
        }
    }

    // Namespace br_accolades
    // Params 1, eflags: 0x4
    // Checksum 0xb6739783, Offset: 0x6ccf
    // Size: 0xb9, Type: dev
    function private getplayerinstance( playername )
    {
        if ( !( isdefined( playername ) && isdefined( level.players ) ) || level.players.size <= 0 )
        {
            return;
        }
        
        foreach ( player in level.players )
        {
            if ( player.name == playername )
            {
                return player;
            }
        }
        
        return;
    }

    // Namespace br_accolades
    // Params 1, eflags: 0x4
    // Checksum 0xf0e7029c, Offset: 0x6d90
    // Size: 0xd2, Type: dev
    function private function_b63a6125275d09bf( ref )
    {
        if ( !isdefined( ref ) || !isdefined( level.var_c99fd4f0f41403f8[ ref ] ) )
        {
            return;
        }
        
        entry = level.var_c99fd4f0f41403f8[ ref ];
        assert( isdefined( entry.scorefunc ) );
        self [[ entry.scorefunc ]]( ref, entry.scoreparams );
        print( "<dev string:x1d4>" + self.name + "<dev string:x1e5>" + ref + "<dev string:x1e8>" + self.var_329a26fdb0abf539[ ref ] + "<dev string:x1ea>" + self.var_e52d4a674441a868[ ref ] + "<dev string:x1ec>" );
        self.var_329a26fdb0abf539[ ref ] = undefined;
        self.var_e52d4a674441a868[ ref ] = undefined;
    }

    // Namespace br_accolades
    // Params 1, eflags: 0x4
    // Checksum 0xf769be9f, Offset: 0x6e6a
    // Size: 0x57, Type: dev
    function private function_a262af3f8e641af( ref )
    {
        entry = level.var_c99fd4f0f41403f8[ ref ];
        assert( isdefined( entry.debugfunc ) );
        self [[ entry.debugfunc ]]( ref, entry.scoreparams );
    }

    // Namespace br_accolades
    // Params 2, eflags: 0x4
    // Checksum 0xff40ec11, Offset: 0x6ec9
    // Size: 0xc1, Type: dev
    function private function_55527deb696ed76d( ref, params )
    {
        totalval = 0;
        detailarr = [];
        assert( isdefined( self.pers[ "<dev string:xbc>" ] ) );
        timesdowned = self.timesdowned ?? 0;
        detailarr[ "<dev string:xbc>" ] = self.pers[ "<dev string:xbc>" ];
        detailarr[ "<dev string:x1ee>" ] = timesdowned;
        totalval = timesdowned + self.pers[ "<dev string:xbc>" ] * 3;
        detailarr[ "<dev string:x1fa>" ] = totalval;
        detailarr[ "<dev string:x200>" ] = max( 0, function_5af9f0891e39fe8c( ref, totalval ) );
        function_e351c19bd3c434b9( ref, detailarr );
    }

    // Namespace br_accolades
    // Params 2, eflags: 0x4
    // Checksum 0x43075fd6, Offset: 0x6f92
    // Size: 0x98, Type: dev
    function private function_1efc2cfeb0a75404( ref, params )
    {
        totalval = 0;
        detailarr = [];
        assert( isdefined( self.pers[ "<dev string:xbc>" ] ) );
        detailarr[ "<dev string:xbc>" ] = self.pers[ "<dev string:xbc>" ];
        
        if ( self.pers[ "<dev string:xbc>" ] == 0 )
        {
            totalval = 0.8;
        }
        
        detailarr[ "<dev string:x1fa>" ] = totalval;
        detailarr[ "<dev string:x200>" ] = totalval;
        function_e351c19bd3c434b9( ref, detailarr );
    }

    // Namespace br_accolades
    // Params 2, eflags: 0x4
    // Checksum 0xb7608f96, Offset: 0x7032
    // Size: 0x17b, Type: dev
    function private function_29d29e9c00e09646( ref, params )
    {
        totalval = 0;
        detailarr = [];
        
        if ( isdefined( currency::get_currency_amount( "<dev string:x20d>" ) ) )
        {
            scaledval = currency::get_currency_amount( "<dev string:x20d>" ) * function_808f90af8000e7f1( ref, "<dev string:x212>" );
            totalval += scaledval;
            detailarr[ "<dev string:x212>" ] = "<dev string:x24>" + currency::get_currency_amount( "<dev string:x20d>" ) + "<dev string:x1ea>" + scaledval + "<dev string:x1ec>";
        }
        
        if ( isdefined( params ) )
        {
            foreach ( param in params )
            {
                if ( isdefined( self.pers[ param ] ) )
                {
                    scaledval = self.pers[ param ] * function_808f90af8000e7f1( ref, param );
                    totalval += scaledval;
                    detailarr[ param ] = "<dev string:x24>" + self.pers[ param ] + "<dev string:x1ea>" + scaledval + "<dev string:x1ec>";
                }
            }
        }
        
        detailarr[ "<dev string:x1fa>" ] = totalval;
        detailarr[ "<dev string:x200>" ] = max( 0, function_5af9f0891e39fe8c( ref, totalval ) );
        function_e351c19bd3c434b9( ref, detailarr );
    }

    // Namespace br_accolades
    // Params 2, eflags: 0x4
    // Checksum 0xdf3c710d, Offset: 0x71b5
    // Size: 0x93, Type: dev
    function private function_c1cd60fa6bd3b1c4( ref, params )
    {
        detailarr = [];
        totalkills = self.pers[ "<dev string:x21f>" ];
        totalassists = self.pers[ "<dev string:x225>" ];
        totalval = 30 - 2 * totalkills + 30 - totalassists;
        detailarr[ "<dev string:x1fa>" ] = totalval;
        detailarr[ "<dev string:x200>" ] = function_5af9f0891e39fe8c( totalval );
        function_e351c19bd3c434b9( ref, detailarr );
    }

    // Namespace br_accolades
    // Params 2
    // Checksum 0xef045941, Offset: 0x7250
    // Size: 0x173, Type: dev
    function function_427482c9792e320b( ref, params )
    {
        totalval = 0;
        detailarr = [];
        
        if ( isdefined( self.lootcachesopened ) )
        {
            scaledval = self.lootcachesopened * function_808f90af8000e7f1( ref, "<dev string:x22d>" );
            totalval += scaledval;
            detailarr[ "<dev string:x22d>" ] = string( self.lootcachesopened ) + "<dev string:x1ea>" + scaledval + "<dev string:x1ec>";
        }
        
        if ( isdefined( params ) )
        {
            foreach ( param in params )
            {
                if ( isdefined( self.pers[ param ] ) )
                {
                    scaledval = self.pers[ param ] * function_808f90af8000e7f1( ref, param );
                    totalval += scaledval;
                    detailarr[ param ] = "<dev string:x24>" + self.pers[ param ] + "<dev string:x1ea>" + scaledval + "<dev string:x1ec>";
                }
            }
        }
        
        detailarr[ "<dev string:x1fa>" ] = totalval;
        detailarr[ "<dev string:x200>" ] = max( 0, function_5af9f0891e39fe8c( ref, totalval ) );
        function_e351c19bd3c434b9( ref, detailarr );
    }

    // Namespace br_accolades
    // Params 2, eflags: 0x4
    // Checksum 0x7d9d802, Offset: 0x73cb
    // Size: 0x173, Type: dev
    function private function_ba9dca5a342f4484( ref, params )
    {
        totalval = 0;
        detailarr = [];
        
        if ( isdefined( self.brmissionscompleted ) )
        {
            scaledval = self.brmissionscompleted * function_808f90af8000e7f1( ref, "<dev string:x23e>" );
            totalval += scaledval;
            detailarr[ "<dev string:x23e>" ] = string( self.brmissionscompleted ) + "<dev string:x1ea>" + scaledval + "<dev string:x1ec>";
        }
        
        if ( isdefined( params ) )
        {
            foreach ( param in params )
            {
                if ( isdefined( self.pers[ param ] ) )
                {
                    scaledval = self.pers[ param ] * function_808f90af8000e7f1( ref, param );
                    totalval += scaledval;
                    detailarr[ param ] = "<dev string:x24>" + self.pers[ param ] + "<dev string:x1ea>" + scaledval + "<dev string:x1ec>";
                }
            }
        }
        
        detailarr[ "<dev string:x1fa>" ] = totalval;
        detailarr[ "<dev string:x200>" ] = max( 0, function_5af9f0891e39fe8c( ref, totalval ) );
        function_e351c19bd3c434b9( ref, detailarr );
    }

    // Namespace br_accolades
    // Params 2, eflags: 0x4
    // Checksum 0x5b7af0d4, Offset: 0x7546
    // Size: 0x1ca, Type: dev
    function private function_cb2f9989818e1ddd( ref, params )
    {
        totalkills = 0;
        detailarr = [];
        addcategories = [ "<dev string:x252>", "<dev string:x25e>", "<dev string:x26b>", "<dev string:x274>", "<dev string:x27c>", "<dev string:x285>" ];
        subtractcategories = [ "<dev string:x291>", "<dev string:x29f>" ];
        
        foreach ( statref in addcategories )
        {
            val = self.pers[ statref ];
            
            if ( isdefined( val ) )
            {
                totalkills += val;
                detailarr[ statref ] = val;
            }
        }
        
        foreach ( statref in subtractcategories )
        {
            val = self.pers[ statref ];
            
            if ( isdefined( val ) )
            {
                totalkills -= val;
                detailarr[ statref ] = -1 * val;
            }
        }
        
        detailarr[ "<dev string:x1fa>" ] = totalkills;
        detailarr[ "<dev string:x200>" ] = max( 0, function_5af9f0891e39fe8c( ref, totalkills ) );
        function_e351c19bd3c434b9( ref, detailarr );
    }

    // Namespace br_accolades
    // Params 2
    // Checksum 0xf2ed8958, Offset: 0x7718
    // Size: 0x123, Type: dev
    function function_b77bd2de1f527055( ref, data_points )
    {
        totalval = 0;
        detailarr = [];
        
        if ( isdefined( data_points ) )
        {
            foreach ( param in data_points )
            {
                if ( isdefined( self.pers[ param ] ) )
                {
                    scaledval = self.pers[ param ] * function_808f90af8000e7f1( ref, param );
                    totalval += scaledval;
                    detailarr[ param ] = "<dev string:x24>" + self.pers[ param ] + "<dev string:x1ea>" + scaledval + "<dev string:x1ec>";
                }
            }
        }
        
        detailarr[ "<dev string:x1fa>" ] = totalval;
        detailarr[ "<dev string:x200>" ] = max( 0, function_5af9f0891e39fe8c( ref, totalval ) );
        function_e351c19bd3c434b9( ref, detailarr );
    }

    // Namespace br_accolades
    // Params 2, eflags: 0x4
    // Checksum 0x1154b9f8, Offset: 0x7843
    // Size: 0xd4, Type: dev
    function private function_e351c19bd3c434b9( ref, detailarr )
    {
        debugstr = "<dev string:x2af>" + self.name + "<dev string:x1e5>" + ref + "<dev string:x1e8>";
        
        if ( detailarr.size > 0 )
        {
            foreach ( key, value in detailarr )
            {
                debugstr += "<dev string:x2c9>" + key + "<dev string:x2cb>" + value + "<dev string:x1e8>";
            }
        }
        
        print( debugstr );
    }

    // Namespace br_accolades
    // Params 1, eflags: 0x4
    // Checksum 0x3eb6a4bf, Offset: 0x791f
    // Size: 0x1d, Type: dev
    function private function_bb6b1b28c82cf8ac( playername )
    {
        return strtok( playername, "<dev string:xc3>" )[ 0 ];
    }

    // Namespace br_accolades
    // Params 1, eflags: 0x4
    // Checksum 0x4c8679b1, Offset: 0x7944
    // Size: 0xdf, Type: dev
    function private function_9970128b45efc7ef( playername )
    {
        if ( playername )
        {
            playername = function_bb6b1b28c82cf8ac( playername );
        }
        
        foreach ( player in level.players )
        {
            if ( playername )
            {
                shortname = function_bb6b1b28c82cf8ac( player.name );
                
                if ( tolower( shortname ) == playername )
                {
                    return player;
                }
                
                continue;
            }
            
            if ( isdefined( player ) && !isbot( player ) && !player isplayerheadless() )
            {
                return player;
            }
        }
    }

#/
