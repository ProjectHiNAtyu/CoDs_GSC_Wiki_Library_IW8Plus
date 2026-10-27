// scripts\common\achievements\sat_achievements.gsc  (hash_041ca196ee82fad4.gscc) (size: 11494 Bytes / 0x2ce6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8c830a0e (2357398030)
// size ...... 11494 (0x2ce6)
// includes .. 4   (offset: 0x2a16)
// strings ... 42  (offset: 0x2a36)
// dev strs .. 0   (offset: 0x2ce6)
// exports ... 31  (offset: 0x1e46)
// cseg ...... 0x485 + 0x19c1 (0x1e46)
// imports ... 51  (offset: 0x231e)
// animtree1 . 0   (offset: 0x2ce6)
// animtree2 . 0   (offset: 0x2ce6)
#using scripts\common\callbacks;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\weapon;

#namespace sat_achievements;

// Namespace sat_achievements
// Params 0, eflags: 0x1
// Checksum 0x8281385e, Offset: 0x4a3
// Size: 0x42
function autoexec preinit()
{
    if ( level.gamemodebundle.achievementcontext == #"hash_7d59253a5aa3a366" )
    {
        function_e76eb29b5e689479();
    }
    
    level.throttle_sat_achievements = throttle::throttle_initialize( "sat_achievements", 2 );
}

// Namespace sat_achievements
// Params 0
// Checksum 0x667506d9, Offset: 0x4ed
// Size: 0x17
function function_e76eb29b5e689479()
{
    callback::add( #"hash_6c71d319dc089c27", &function_4097242dc269636e );
}

// Namespace sat_achievements
// Params 0
// Checksum 0x98abc827, Offset: 0x50c
// Size: 0x17
function function_e3b9dbbabcedac0a()
{
    callback::remove( #"hash_6c71d319dc089c27", &function_4097242dc269636e );
}

// Namespace sat_achievements
// Params 1, eflags: 0x4
// Checksum 0x818f846e, Offset: 0x52b
// Size: 0x24c
function private function_4097242dc269636e( params )
{
    event = params.event;
    
    switch ( event )
    {
        case #"hash_44cee0689be43248":
            onelimination( params );
            break;
        case #"hash_1f36538689dd6873":
            onkill( params );
            break;
        case #"on_nemesis_kill":
            function_b5ebf85e0f8deb3d( params );
            break;
        case #"on_game_end_mp":
            ongameendmp( params );
            break;
        case #"hash_cda961d5172beeff":
            function_6c412555494241f( params );
            break;
        case #"on_activated_killstreak":
            onkillstreakactivated( params );
            break;
        case #"on_destroyed_equipment":
            function_f56cc326196bc3b8( params );
            break;
        case #"on_destroyed_killstreak":
            onkillstreakdestroyed( params );
            break;
        case #"hash_47ff65c901bd4d04":
            function_262a4cda88e17e71( params );
            break;
        case #"on_ai_killed":
            function_56654cd020a2788f( params );
            break;
        case #"hash_26b81ca74d58f961":
            function_5045ac60c067cd2d( params );
            break;
        case #"zm_mq_quest_complete":
            function_72596495ce0cf3b6( params );
            break;
        case #"zm_sq_quest_complete":
            function_6cadbc193a63e700( params );
            break;
        case #"zm_on_round_start":
            on_zm_round_start( params );
            break;
        case #"zm_on_gobblegum_consumed":
            function_89dedee6aef63ffd( params );
            break;
        case #"hash_8202d0016fc358bc":
            function_2cc0248bd9302971( params );
            break;
        case #"achievement_simple":
            function_8011a799f03be048( params );
            break;
        case #"on_tutorial_completed":
            function_32a4c646b5b6512e( params );
            break;
        case #"hash_99edec2fa59480a2":
            function_481f3bcefb448335( params );
            break;
        case #"hash_5a10347d25f1082c":
            function_b9d8de7fe45b87e6( params );
            break;
        case #"hash_f806b55b771c5da0":
            function_bc933051d1b6fb95( params );
            break;
        case #"hash_57a7e5817efb1d97":
            function_1078adcc99249e6f( params );
            break;
        default:
            break;
    }
}

// Namespace sat_achievements
// Params 1, eflags: 0x4
// Checksum 0x225044cd, Offset: 0x77f
// Size: 0xec
function private onkill( params )
{
    player = params.attacker;
    
    if ( level.gamemodebundle.aegamemode == "ZM" )
    {
        return;
    }
    
    if ( !function_d105e100bc8affcf( player ) )
    {
        return;
    }
    
    if ( player.var_c36e159445e2a48b == 3 )
    {
        player function_1105733d932ce839( "sat_mp_legitimatestrategy", 1 );
    }
    
    if ( params.var_6c2c150894af98a9.iswalljump && params.isprimary )
    {
        player function_1105733d932ce839( "sat_mp_freshmoves", 1 );
    }
    
    if ( params.objweapon.basenamehash == %"sat_ks_sniper_briefcase_mp" && player.sniperbriefcasekills == 3 )
    {
        player function_1105733d932ce839( "sat_mp_farsight", 1 );
    }
    
    onelimination( params );
}

// Namespace sat_achievements
// Params 1, eflags: 0x4
// Checksum 0x2cf3b739, Offset: 0x873
// Size: 0x64
function private function_b5ebf85e0f8deb3d( params )
{
    player = params.attacker;
    
    if ( !function_d105e100bc8affcf( player ) )
    {
        return;
    }
    
    progress = player function_8ede130f867b0ec4( #"achievements", #"archenemy", 1 );
    player function_1105733d932ce839( "sat_mp_archenemy", progress );
}

// Namespace sat_achievements
// Params 1, eflags: 0x4
// Checksum 0x9bd6eb94, Offset: 0x8df
// Size: 0x9e
function private onelimination( params )
{
    player = params.attacker;
    
    if ( !function_d105e100bc8affcf( player ) )
    {
        return;
    }
    
    if ( player.var_c7f9996ef2343f2a )
    {
        progress = player function_8ede130f867b0ec4( #"achievements", #"perfected", 1 );
        player function_1105733d932ce839( "sat_mp_perfected", progress );
    }
    
    progress = player function_8ede130f867b0ec4( #"achievements", #"destroyer", 1 );
    player function_1105733d932ce839( "sat_mp_destroyer", progress );
}

// Namespace sat_achievements
// Params 1, eflags: 0x4
// Checksum 0x2293c6d8, Offset: 0x985
// Size: 0x1ad
function private ongameendmp( params )
{
    winner = params.winner;
    
    if ( !isdefined( winner ) )
    {
        return;
    }
    
    if ( !level.teambased )
    {
        if ( isarray( winner ) )
        {
            foreach ( win in winner )
            {
                if ( function_d105e100bc8affcf( win ) )
                {
                    progress = win function_8ede130f867b0ec4( #"achievements", #"frontlineoffensive", 1 );
                    win function_1105733d932ce839( "sat_mp_frontlineoffensive", progress );
                }
            }
        }
        else if ( function_d105e100bc8affcf( winner ) )
        {
            progress = winner function_8ede130f867b0ec4( #"achievements", #"frontlineoffensive", 1 );
            winner function_1105733d932ce839( "sat_mp_frontlineoffensive", progress );
        }
        
        return;
    }
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        player = level.players[ i ];
        
        if ( !function_d105e100bc8affcf( player ) )
        {
            continue;
        }
        
        if ( player.pers[ "team" ] == winner )
        {
            progress = player function_8ede130f867b0ec4( #"achievements", #"frontlineoffensive", 1 );
            player function_1105733d932ce839( "sat_mp_frontlineoffensive", progress );
        }
    }
}

// Namespace sat_achievements
// Params 1, eflags: 0x4
// Checksum 0xfc836971, Offset: 0xb3a
// Size: 0x80
function private function_6c412555494241f( params )
{
    potgscene = params.potgscene;
    
    if ( function_d105e100bc8affcf( potgscene.primaryentity ) )
    {
        player = potgscene.primaryentity;
        progress = player function_8ede130f867b0ec4( #"achievements", #"glamorshot", 1 );
        player function_1105733d932ce839( "sat_mp_glamorshot", progress );
    }
}

// Namespace sat_achievements
// Params 1, eflags: 0x4
// Checksum 0x7dd2af0b, Offset: 0xbc2
// Size: 0x9c
function private onkillstreakactivated( params )
{
    if ( level.gamemodebundle.aegamemode == "ZM" || level.gamemodebundle.aegamemode == "WC" )
    {
        return;
    }
    
    player = params.player;
    
    if ( function_d105e100bc8affcf( player ) )
    {
        progress = player function_8ede130f867b0ec4( #"achievements", #"callingforbackup", 1 );
        player function_1105733d932ce839( "sat_mp_callingforbackup", progress );
    }
}

// Namespace sat_achievements
// Params 1, eflags: 0x4
// Checksum 0x63ac967d, Offset: 0xc66
// Size: 0x7f
function private onkillstreakdestroyed( params )
{
    player = params.player;
    
    if ( !function_d105e100bc8affcf( player ) )
    {
        return;
    }
    
    weapon = params.weapon;
    
    if ( weapon.basenamehash == %"sat_smart_seeker_projectile" || weapon.basenamehash == %"sat_smart_seeker_projectile_distant_targets" )
    {
        function_1e635a79ab115680( player );
    }
}

// Namespace sat_achievements
// Params 1, eflags: 0x4
// Checksum 0xeccf148f, Offset: 0xced
// Size: 0x93
function private function_f56cc326196bc3b8( params )
{
    player = params.player;
    
    if ( !function_d105e100bc8affcf( player ) )
    {
        return;
    }
    
    inflictor = params.inflictor;
    
    if ( inflictor.weapon_object.basenamehash == %"sat_smart_seeker_projectile" || inflictor.weapon_object.basenamehash == %"sat_smart_seeker_projectile_distant_targets" )
    {
        function_1e635a79ab115680( player );
    }
}

// Namespace sat_achievements
// Params 1, eflags: 0x4
// Checksum 0x48556f57, Offset: 0xd88
// Size: 0xa7
function private function_262a4cda88e17e71( params )
{
    attacker = params.attacker;
    victim = params.victim;
    equipment = params.equipment;
    
    if ( equipment && equipment.equipmentref == "equip_dart_mark_zero" && equipment.var_ec2a7a632e045ea6 )
    {
        if ( distancesquared( attacker.origin, victim.origin ) >= 1395000 )
        {
            attacker function_1105733d932ce839( "sat_mp_pathfinder", 1 );
        }
    }
}

// Namespace sat_achievements
// Params 1, eflags: 0x4
// Checksum 0x625a5a18, Offset: 0xe37
// Size: 0x55
function private function_8011a799f03be048( params )
{
    assert( isstring( params.var_b321eb6cdb8168ba ) );
    assert( isplayer( params.player ) );
    params.player giveachievement( params.var_b321eb6cdb8168ba );
}

// Namespace sat_achievements
// Params 1, eflags: 0x4
// Checksum 0x96d9289, Offset: 0xe94
// Size: 0xf6
function private function_72596495ce0cf3b6( params )
{
    a_players = params.var_be82617e5e8087bd ?? level.players;
    
    foreach ( player in a_players )
    {
        if ( !function_d105e100bc8affcf( player ) )
        {
            continue;
        }
        
        if ( params.questname == #"zm_sat_firefly_mq" )
        {
            player function_1105733d932ce839( "sat_zm_dusttodust", 1 );
            logstring( "====SAT ACHIEVEMENT " + "sat_zm_dusttodust" + " PROGRESS FOR " + player.name + ": " + 1 );
        }
    }
}

// Namespace sat_achievements
// Params 1, eflags: 0x4
// Checksum 0x66935e5, Offset: 0xf92
// Size: 0x2ed
function private function_6cadbc193a63e700( params )
{
    a_players = params.var_be82617e5e8087bd ?? level.players;
    
    foreach ( player in a_players )
    {
        if ( !function_d105e100bc8affcf( player ) )
        {
            continue;
        }
        
        if ( params.questname == #"zm_sat_firefly_dmps_ee" )
        {
            player function_1105733d932ce839( "sat_zm_goodsoldiers", 1 );
            logstring( "====SAT ACHIEVEMENT " + "sat_zm_goodsoldiers" + " PROGRESS FOR " + player.name + ": " + 1 );
            continue;
        }
        
        if ( params.questname == #"zm_sat_firefly_slorpy_quest" && isdefined( params.perk ) )
        {
            var_3855921db69dece1 = level.sharedfuncs[ #"player" ][ #"getplayerdata" ];
            var_36678a5af3ec5595 = level.sharedfuncs[ #"player" ][ #"setplayerdata" ];
            n_drinks = 0;
            var_c273d80297afa9b6 = undefined;
            
            switch ( params.perk )
            {
                case #"hash_4485ea5afc8ef4ec":
                    var_c273d80297afa9b6 = #"hash_6dcfb8613be32e82";
                    break;
                case #"hash_5b88c6956390309e":
                    var_c273d80297afa9b6 = #"hash_50091e34fcd341fc";
                    break;
                case #"hash_8ce81fd37af3e66b":
                    var_c273d80297afa9b6 = #"hash_7a67e99930866e59";
                    break;
                case #"hash_47874f94af82bbae":
                    var_c273d80297afa9b6 = #"hash_7c5e19efee6247a7";
                    break;
            }
            
            player builtin [[ var_36678a5af3ec5595 ]]( level.var_cd0f81c4b3df62f7, #"achievements", var_c273d80297afa9b6, 1 );
            
            if ( player builtin [[ var_3855921db69dece1 ]]( level.var_cd0f81c4b3df62f7, #"achievements", #"hash_6dcfb8613be32e82" ) )
            {
                n_drinks++;
            }
            
            if ( player builtin [[ var_3855921db69dece1 ]]( level.var_cd0f81c4b3df62f7, #"achievements", #"hash_50091e34fcd341fc" ) )
            {
                n_drinks++;
            }
            
            if ( player builtin [[ var_3855921db69dece1 ]]( level.var_cd0f81c4b3df62f7, #"achievements", #"hash_7a67e99930866e59" ) )
            {
                n_drinks++;
            }
            
            if ( player builtin [[ var_3855921db69dece1 ]]( level.var_cd0f81c4b3df62f7, #"achievements", #"hash_7c5e19efee6247a7" ) )
            {
                n_drinks++;
            }
            
            player function_1105733d932ce839( "sat_zm_mixologist", n_drinks );
            logstring( "====SAT ACHIEVEMENT " + "sat_zm_mixologist" + " PROGRESS FOR " + player.name + ": " + n_drinks );
        }
    }
}

// Namespace sat_achievements
// Params 1, eflags: 0x4
// Checksum 0x4340671, Offset: 0x1287
// Size: 0x1bb
function private on_zm_round_start( params )
{
    if ( getxhash( level.gametype ) == #"hash_280e25dd3ca205d4" || getxhash( level.gametype ) == #"hash_68a3206c1d3453ee" )
    {
        if ( params.roundnumber <= 2 || utility::callsharedfunc( #"zombie", #"hash_8b52dcc4e869e5e5" ) )
        {
            foreach ( player in level.players )
            {
                player.var_ca89751c44ed34b0 = 1;
            }
        }
        
        if ( params.roundnumber >= 30 )
        {
            foreach ( player in level.players )
            {
                if ( !function_d105e100bc8affcf( player ) || !player.var_ca89751c44ed34b0 )
                {
                    continue;
                }
                
                player function_1105733d932ce839( "sat_zm_survivalfittest", 1 );
                logstring( "====SAT ACHIEVEMENT " + "sat_zm_survivalfittest" + " PROGRESS FOR " + player.name + ": " + 1 );
            }
        }
    }
}

// Namespace sat_achievements
// Params 1
// Checksum 0x36f3051c, Offset: 0x144a
// Size: 0x98
function function_89dedee6aef63ffd( params )
{
    player = self;
    
    if ( !function_d105e100bc8affcf( player ) )
    {
        return;
    }
    
    if ( !isdefined( player.var_421d73548796d387 ) )
    {
        player.var_421d73548796d387 = 0;
    }
    
    player.var_421d73548796d387++;
    player function_1105733d932ce839( "sat_zm_chewonthis", player.var_421d73548796d387 );
    logstring( "====SAT ACHIEVEMENT " + "sat_zm_chewonthis" + " PROGRESS FOR " + player.name + ": " + player.var_421d73548796d387 );
}

// Namespace sat_achievements
// Params 1, eflags: 0x4
// Checksum 0x7238961f, Offset: 0x14ea
// Size: 0xe3
function private function_2cc0248bd9302971( params )
{
    if ( params.newstage >= 4 && !level.var_af6ac0182161b54e )
    {
        foreach ( player in level.players )
        {
            if ( !function_d105e100bc8affcf( player ) )
            {
                continue;
            }
            
            player function_1105733d932ce839( "sat_zm_youlikeupgrades", 1 );
            logstring( "====SAT ACHIEVEMENT " + "sat_zm_youlikeupgrades" + " PROGRESS FOR " + player.name + ": " + 1 );
        }
    }
}

// Namespace sat_achievements
// Params 1, eflags: 0x4
// Checksum 0x6e53f482, Offset: 0x15d5
// Size: 0x8e
function private function_bc933051d1b6fb95( params )
{
    player = params.player;
    
    if ( !function_d105e100bc8affcf( player ) )
    {
        return;
    }
    
    powertier = params.powertier;
    
    if ( !powertier || powertier < 61 )
    {
        return;
    }
    
    player function_1105733d932ce839( "sat_wc_turbocharged", 1 );
    logstring( "====SAT ACHIEVEMENT " + "sat_wc_turbocharged" + " PROGRESS FOR " + player.name + ": " + 1 );
}

// Namespace sat_achievements
// Params 1, eflags: 0x4
// Checksum 0xaf7279e4, Offset: 0x166b
// Size: 0xb0
function private function_1078adcc99249e6f( params )
{
    player = params.player;
    
    if ( !function_d105e100bc8affcf( player ) )
    {
        return;
    }
    
    regiondifficulty = params.regiondifficulty;
    
    if ( regiondifficulty != "difficulty_darkaether" )
    {
        return;
    }
    
    progress = player function_8ede130f867b0ec4( #"achievements", #"hash_568db61cc7e1ab66", 1 );
    player function_1105733d932ce839( "sat_wc_complete10assignments", progress );
    logstring( "====SAT ACHIEVEMENT " + "sat_wc_complete10assignments" + " PROGRESS FOR " + player.name + ": " + progress );
}

// Namespace sat_achievements
// Params 1, eflags: 0x4
// Checksum 0x9cb6bf9f, Offset: 0x1723
// Size: 0x88
function private function_b9d8de7fe45b87e6( params )
{
    player = params.player;
    
    if ( !function_d105e100bc8affcf( player ) )
    {
        return;
    }
    
    distancemeter = params.distancemeter;
    
    if ( distancemeter < 800 )
    {
        return;
    }
    
    player function_1105733d932ce839( "sat_wc_glide800m", 1 );
    logstring( "====SAT ACHIEVEMENT " + "sat_wc_glide800m" + " PROGRESS FOR " + player.name + ": " + 1 );
}

// Namespace sat_achievements
// Params 1, eflags: 0x4
// Checksum 0x93b49f0c, Offset: 0x17b3
// Size: 0x7e
function private function_481f3bcefb448335( params )
{
    player = params.player;
    
    if ( !function_d105e100bc8affcf( player ) )
    {
        return;
    }
    
    progress = params.var_ffc5536b7d66d3b3;
    player function_1105733d932ce839( "sat_wc_loremaster", progress );
    logstring( "====SAT ACHIEVEMENT " + "sat_wc_loremaster" + " PROGRESS FOR " + player.name + ": " + progress );
}

// Namespace sat_achievements
// Params 1, eflags: 0x4
// Checksum 0xc445b6f3, Offset: 0x1839
// Size: 0x2ff
function private function_56654cd020a2788f( params )
{
    if ( isplayer( params.eattacker.var_bd22ba6c600a23a3 ) )
    {
        player = params.eattacker.var_bd22ba6c600a23a3;
    }
    else if ( isplayer( params.eattacker.owner ) )
    {
        player = params.eattacker.owner;
    }
    else if ( isplayer( params.eattacker ) )
    {
        player = params.eattacker;
    }
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( !isagent( self ) )
    {
        return;
    }
    
    if ( !function_d105e100bc8affcf( player ) )
    {
        logstring( "====SAT ACHIEVEMENT Achievements are somehow disabled for player " + player.name + " so no agent kill-based achievements are being tracked" );
        return;
    }
    
    if ( level.gamemodebundle.aegamemode == "ZM" )
    {
        if ( player.ismutantinjection && isdefined( player.var_ffc19da7b9004b02 ) && arraycontains( player.var_ffc19da7b9004b02, self ) )
        {
            player thread function_c49f19cd02ca79fa( "sat_zm_yoursoulismine", 1, #"hash_b3af697bc851af83" );
        }
        
        if ( isarray( self.a_n_player_damage ) )
        {
            foreach ( assistplayer in self.a_n_player_damage )
            {
                if ( !isplayer( assistplayer ) || assistplayer == player )
                {
                    continue;
                }
                
                player thread function_c49f19cd02ca79fa( "sat_zm_corpseaplenty", 1, #"zm_eliminations" );
            }
        }
        
        player thread function_c49f19cd02ca79fa( "sat_zm_corpseaplenty", 1, #"zm_eliminations" );
        
        if ( self.aicategory == "elite" && self.var_dd22e69947766504 )
        {
            player thread function_c49f19cd02ca79fa( "sat_zm_intesitea", 1 );
        }
        
        if ( ( self.var_2259f0a89be4759f || self.var_282c85074c0691df ) && self.last_dmg_struct.biscritical )
        {
            player thread function_c49f19cd02ca79fa( "sat_zm_poisonparadise", 1, #"hash_43e26bdf8be2fcc1" );
        }
        
        if ( utility::ent_flag( "fw_damage" ) )
        {
            player thread function_c49f19cd02ca79fa( "sat_zm_enforcedfreedom", 1, #"hash_d93e9bc38723ced4" );
        }
    }
    
    if ( level.gamemodebundle.aegamemode == "WC" )
    {
        weapon = params.sweapon;
        
        if ( weapon::function_52f1736c4c1b06d4( weapon ) )
        {
            player thread function_c49f19cd02ca79fa( "sat_wc_purveyoroffinegoods", 1, #"hash_c033429ea1310766" );
        }
    }
}

// Namespace sat_achievements
// Params 3, eflags: 0x4
// Checksum 0x445bf74f, Offset: 0x1b40
// Size: 0x9e
function private function_c49f19cd02ca79fa( var_7fbb1b6fdc3285a1, var_f208f4f1a3745e92 = 1, var_ac4e1047711ec2d0 )
{
    self endon( #"disconnect" );
    throttle::throttle_wait_in_queue( level.throttle_sat_achievements, self );
    
    if ( isdefined( var_ac4e1047711ec2d0 ) )
    {
        progress = function_8ede130f867b0ec4( #"achievements", var_ac4e1047711ec2d0, var_f208f4f1a3745e92 );
    }
    else
    {
        progress = 1;
    }
    
    self function_1105733d932ce839( var_7fbb1b6fdc3285a1, progress );
    logstring( "====SAT ACHIEVEMENT " + var_7fbb1b6fdc3285a1 + " PROGRESS FOR " + self.name + ": " + progress );
}

// Namespace sat_achievements
// Params 1, eflags: 0x4
// Checksum 0xcbb4d7b8, Offset: 0x1be6
// Size: 0x62
function private function_5045ac60c067cd2d( params )
{
    player = params.player;
    
    if ( function_d105e100bc8affcf( player ) )
    {
        progress = player function_8ede130f867b0ec4( #"achievements", #"decoratedveteran", 1 );
        player function_1105733d932ce839( "sat_global_decoratedveteran", progress );
    }
}

// Namespace sat_achievements
// Params 1, eflags: 0x4
// Checksum 0xdf2b2b44, Offset: 0x1c50
// Size: 0x52
function private function_1e635a79ab115680( player )
{
    if ( !isdefined( player.var_dc672a5d2ddc186c ) )
    {
        player.var_dc672a5d2ddc186c = 0;
    }
    
    player.var_dc672a5d2ddc186c++;
    
    if ( player.var_dc672a5d2ddc186c == 5 )
    {
        player function_1105733d932ce839( "sat_mp_notinmyhouse", 1 );
    }
}

// Namespace sat_achievements
// Params 1
// Checksum 0xe7abcac1, Offset: 0x1caa
// Size: 0x9f
function function_d105e100bc8affcf( player )
{
    if ( !isplayer( player ) )
    {
        return 0;
    }
    
    if ( level.var_1ca6e1d1e2be7825 )
    {
        return 0;
    }
    
    if ( !isdefined( player.var_d105e100bc8affcf ) )
    {
        var_d105e100bc8affcf = level.sharedfuncs[ #"player" ][ #"hash_d65b880897cec134" ];
        
        if ( isplayer( player ) )
        {
            if ( isdefined( var_d105e100bc8affcf ) )
            {
                player.var_d105e100bc8affcf = player [[ var_d105e100bc8affcf ]]();
            }
            else
            {
                player.var_d105e100bc8affcf = 0;
            }
        }
        else
        {
            return 0;
        }
    }
    
    return player.var_d105e100bc8affcf;
}

// Namespace sat_achievements
// Params 3
// Checksum 0x40457c4c, Offset: 0x1d52
// Size: 0xba
function function_8ede130f867b0ec4( var_e5722437d6d6b780, name, count )
{
    currentprogress = 0;
    var_3855921db69dece1 = level.sharedfuncs[ #"player" ][ #"getplayerdata" ];
    var_36678a5af3ec5595 = level.sharedfuncs[ #"player" ][ #"setplayerdata" ];
    
    if ( isbuiltinmethod( var_3855921db69dece1 ) && isbuiltinmethod( var_36678a5af3ec5595 ) )
    {
        currentprogress = self builtin [[ var_3855921db69dece1 ]]( level.var_cd0f81c4b3df62f7, var_e5722437d6d6b780, name );
        currentprogress += count;
        self builtin [[ var_36678a5af3ec5595 ]]( level.var_cd0f81c4b3df62f7, var_e5722437d6d6b780, name, currentprogress );
    }
    
    return currentprogress;
}

// Namespace sat_achievements
// Params 1, eflags: 0x4
// Checksum 0x54792deb, Offset: 0x1e15
// Size: 0x31
function private function_32a4c646b5b6512e( params )
{
    player = params.player;
    player function_1105733d932ce839( "sat_mp_readyforaction", 1 );
}

