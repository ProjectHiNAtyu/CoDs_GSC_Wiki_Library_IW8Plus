// scripts\mp\ob\systems\ob_power_tier.gsc  (hash_79385a9417dacb61.gscc) (size: 13931 Bytes / 0x366b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x608a7ed7 (1619689175)
// size ...... 13931 (0x366b)
// includes .. 8   (offset: 0x32fb)
// strings ... 41  (offset: 0x333b)
// dev strs .. 16  (offset: 0x35a7)
// exports ... 22  (offset: 0x260b)
// cseg ...... 0x3cc + 0x223f (0x260b)
// imports ... 76  (offset: 0x297b)
// animtree1 . 0   (offset: 0x366b)
// animtree2 . 0   (offset: 0x366b)
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\telemetry_utils;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\gametypes\ob;
#using scripts\mp\loot\common_item;

#namespace ob_power_tier;

// Namespace ob_power_tier
// Params 0, eflags: 0x1
// Checksum 0x8e33c7f3, Offset: 0x3ea
// Size: 0xc0
function autoexec main()
{
    if ( getdvarint( @"scr_disable_power_tier", !getmatchrulesdata( "commonOption", "powerTiersEnabled" ) ) || isbrgamemode() )
    {
        return;
    }
    
    level callback::add( #"player_spawned", &powertier_onspawn );
    level callback::add( #"player_death", &function_8a902db19c3079d6 );
    level callback::add( #"hash_3b81ca15a16b5585", &function_72c580641320b75a );
    level callback::add( #"skill_acquired", &function_4b9999f24a7eac62 );
    level callback::add( #"skill_removed", &function_4b9999f24a7eac62 );
    utility::registersharedfunc( #"powertier", #"power_tier_kill_reward_used", &function_3862fd3e38b21121 );
    
    /#
        initdev();
    #/
}

// Namespace ob_power_tier
// Params 0
// Checksum 0xdab7fc27, Offset: 0x4b2
// Size: 0x6f
function function_6d4cdb24ee2c66c0()
{
    if ( !isplayer( self ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    if ( !isdefined( self.powertier ) )
    {
        return 0;
    }
    
    var_c96d3e7dca74c40b = self.powertier - 1 + ( self.var_1db23e0735771ec5 ?? 0 ) + ( self.var_38cdb896b8360654 ?? 0 ) ?? 0;
    return int( max( 0, var_c96d3e7dca74c40b ) );
}

// Namespace ob_power_tier
// Params 1
// Checksum 0x5e336c46, Offset: 0x52a
// Size: 0x139
function powertier_onspawn( params )
{
    if ( !isdefined( self.powertier ) )
    {
        self.powertier_xp = 0;
        self.var_1db23e0735771ec5 = 0;
        self.var_38cdb896b8360654 = 0;
        self.pers[ "telemetry" ].gained_power = 0;
        function_69df1bfb965b995d( 1, 0 );
    }
    else
    {
        function_69df1bfb965b995d( self.powertier, 0 );
    }
    
    if ( getdvarint( @"hash_999856e13671157f", 1 ) )
    {
        self.var_24954f14e27b448d = 1;
    }
    
    self.laststandmaxhealth = level.laststandhealth;
    
    if ( self.pers[ "powerTier_pendingReward" ] )
    {
        self.powertier_xp = self.pers[ "powerTier_powerTierXP" ];
        self.powertiernexttierxp = self.pers[ "powerTier_powerTierNextTierXP" ];
        thread function_ef05c43368e714fa();
    }
    
    waittillframeend();
    var_d0ac98140d602f14 = getdvarint( @"hash_df50efcbcc9d73f", level.var_858d230de58cc743.var_d0ac98140d602f14 ?? 0 );
    
    if ( params.revivespawn && var_d0ac98140d602f14 )
    {
        function_3a1a3b1e6169c47a( var_d0ac98140d602f14, 1 );
    }
}

// Namespace ob_power_tier
// Params 1
// Checksum 0xdd0f342c, Offset: 0x66b
// Size: 0xc2
function function_8a902db19c3079d6( params )
{
    victim = params.victim;
    
    if ( !victim || !isplayer( victim ) )
    {
        return;
    }
    
    var_ae19f81f2a78a8c8 = level.var_858d230de58cc743.var_ae19f81f2a78a8c8;
    
    if ( var_ae19f81f2a78a8c8 )
    {
        spawn_options = common_item::function_bc5ff2958b71a708( victim.origin );
        item = common_item::function_61c2c0251e742ffd( var_ae19f81f2a78a8c8, undefined, spawn_options );
        item function_7653c765b6c7b815();
        item enablescriptableplayeruse( victim );
        attacker = params.attacker;
        
        if ( attacker && isplayer( attacker ) )
        {
            item enablescriptableplayeruse( attacker );
        }
    }
}

// Namespace ob_power_tier
// Params 1
// Checksum 0x7ad9ad33, Offset: 0x735
// Size: 0x3a5
function function_72c580641320b75a( params )
{
    if ( !level.var_858d230de58cc743.var_d1c4712963f44757 )
    {
        return;
    }
    
    var_acecf1de8ec2250a = self.operatorprestige < 3 ? 61 : 77;
    
    if ( self.powertier >= var_acecf1de8ec2250a )
    {
        return;
    }
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    self endon( #"death_or_disconnect" );
    self endon( #"skills_reset" );
    
    if ( !self.pers[ "powerTier_pendingReward" ] )
    {
        /#
            if ( getdvarint( @"hash_cba6ac45aa726a70", 0 ) )
            {
                debug::function_9d6fee9cf5908ddc( "<dev string:x7a>" + self.powertier_xp );
            }
            
            if ( getdvarint( @"hash_d085b6a8a2285a3a", 0 ) )
            {
                debug::function_9d6fee9cf5908ddc( "<dev string:x85>" + self.powertier_xp );
            }
        #/
        
        self.powertier_xp += params.points;
        self.pers[ "telemetry" ].gained_power = self.pers[ "telemetry" ].gained_power + params.points;
        ob::function_2c2ba98432629961();
        
        if ( self.var_52ebca6bcb51dc20 )
        {
            self.powertier_xp = clampint( self.powertier_xp, 0, self.powertiernexttierxp - 1 );
        }
        
        if ( self.powertier_xp >= self.powertiernexttierxp )
        {
            self.pers[ "powerTier_pendingReward" ] = 1;
            self.pers[ "powerTier_xpParams" ] = params;
            self.pers[ "powerTier_powerTierXP" ] = self.powertier_xp;
            self.pers[ "powerTier_powerTierNextTierXP" ] = self.powertiernexttierxp;
            function_75cc84297f5ba7ab( 0, params.event );
            logstring( "[OB_POWER_TIER] Player [" + ( self.name ?? "" ) + "] earned skill with " + self.powertier_xp + "/" + self.powertiernexttierxp + " xp points." );
            thread play_power_tier_fx( 1 );
            utility::callsharedfunc( #"ob_skill_tracks", #"hash_92aa850c92f2fac0", [ self ] );
            
            if ( self.var_6c41ce781dd1b407 )
            {
                return;
            }
            
            self.powertier_xp -= self.powertiernexttierxp;
            self.powertier_xp = maxint( self.powertier_xp, 0 );
            self.skillpicked = undefined;
            self.pers[ "powerTier_pendingReward" ] = 0;
            function_69df1bfb965b995d( self.powertier + 1, 1 );
            logstring( "[OB_POWER_TIER] Player [" + ( self.name ?? "" ) + "] combat rating increased." );
            
            if ( self.powertier < var_acecf1de8ec2250a || !level.var_858d230de58cc743.var_ef04ed6afc2d4b75 )
            {
                var_2bdca540cb1e51c3 = self.var_832e4f138f18c200 == "CORE_UPGRADE" ? level.var_858d230de58cc743.var_969aa65b21ab595a : level.var_858d230de58cc743.var_5bb06be1c6dd46c9;
                
                if ( var_2bdca540cb1e51c3 )
                {
                    self playsoundtoplayer( var_2bdca540cb1e51c3, self );
                }
            }
            else
            {
                self playsoundtoplayer( level.var_858d230de58cc743.var_ef04ed6afc2d4b75, self );
            }
        }
    }
    
    function_b03835d70ce9355d( params.event, params.points );
    function_75cc84297f5ba7ab();
}

// Namespace ob_power_tier
// Params 2
// Checksum 0x9c810fc8, Offset: 0xae2
// Size: 0x8b
function function_b03835d70ce9355d( xp_source, xp_amount )
{
    player = self;
    eventparams = [];
    eventparams[ eventparams.size ] = "xp_earned_ts";
    eventparams[ eventparams.size ] = gettime() ?? -1;
    eventparams[ eventparams.size ] = "xp_source";
    eventparams[ eventparams.size ] = xp_source ?? #"";
    eventparams[ eventparams.size ] = "xp_amount";
    eventparams[ eventparams.size ] = xp_amount ?? 0;
    player dlog_recordplayerevent( "dlog_event_ob_player_skill_xp_earned", eventparams );
}

// Namespace ob_power_tier
// Params 1
// Checksum 0xaec27e0d, Offset: 0xb75
// Size: 0x84
function function_3862fd3e38b21121( params )
{
    var_5bc5678a675b1341 = getdvarint( @"hash_19cbbbc7563acd26", level.var_858d230de58cc743.var_5bc5678a675b1341 ?? 0 );
    
    for ( i = 0; i < var_5bc5678a675b1341 ; i++ )
    {
        var_74ea1d6c42ad51a1 = self.powertiernexttierxp - self.powertier_xp;
        function_72c580641320b75a( { #points:var_74ea1d6c42ad51a1 } );
    }
}

// Namespace ob_power_tier
// Params 2
// Checksum 0x8e144f29, Offset: 0xc01
// Size: 0xc08
function function_3a1a3b1e6169c47a( var_d9affdc6b4777920, var_749d3d2595c17ae5 )
{
    if ( !self.powertier )
    {
        return;
    }
    
    if ( var_749d3d2595c17ae5 )
    {
        while ( self.var_1f7050a4c29b6a13 )
        {
            waitframe();
        }
    }
    else if ( self.var_1f7050a4c29b6a13.size )
    {
        var_c9839c614bfae27c = 1;
        self.activeskills = self.var_1f7050a4c29b6a13;
    }
    else if ( self.isdisconnecting )
    {
        var_c9839c614bfae27c = 1;
    }
    
    logstring( "[OB_POWER_TIER] Player [" + ( self.name ?? "" ) + "] losing " + var_d9affdc6b4777920 + " from power tier " + self.powertier + "." );
    var_27060f81362044b3 = clampint( var_d9affdc6b4777920, 0, self.powertier - 1 );
    var_3ce9289a5c028701 = var_27060f81362044b3;
    self.var_eaa1e4853aa390e9 = var_27060f81362044b3;
    self.var_e045a890094e3bfc = 0;
    self.var_fbd4b2fd37c7ce47 = 0;
    
    foreach ( skillref, skilllevel in self.activeskills )
    {
        skillbundle = level.skillbundles[ skillref ][ skilllevel ];
        skillcategory = skillbundle.skillcategory;
        
        if ( skillcategory == #"end_game" )
        {
            self.var_e045a890094e3bfc += skilllevel + 1;
            
            if ( !var_c9839c614bfae27c )
            {
                utility::callsharedfunc( #"skills", #"removeskill", skillref );
            }
            else
            {
                self.activeskills[ skillref ] = undefined;
            }
            
            continue;
        }
        
        if ( skillcategory == #"nightmare" )
        {
            self.var_fbd4b2fd37c7ce47 += skilllevel + 1;
            
            if ( !var_c9839c614bfae27c )
            {
                utility::callsharedfunc( #"skills", #"removeskill", skillref );
                continue;
            }
            
            self.activeskills[ skillref ] = undefined;
        }
    }
    
    var_cd1b743bdad198b1 = [];
    
    foreach ( skilltrack in self.skilltracks )
    {
        if ( !skilltrack.isspecial )
        {
            var_cd1b743bdad198b1[ var_cd1b743bdad198b1.size ] = skilltrack;
        }
    }
    
    self.skilltracks = var_cd1b743bdad198b1;
    self.var_1db23e0735771ec5 = 0;
    self.var_38cdb896b8360654 = 0;
    var_e48e2da022db5569 = [];
    
    for ( i = 0; i < var_27060f81362044b3 ; i++ )
    {
        var_31f73ed4015fc20d = utility::callsharedfunc( #"ob_skill_tracks", #"hash_645ee2bb8bf341ad", self.powertier - 1 - i );
        
        if ( var_31f73ed4015fc20d.skillchoice == "NEW_TRACK" && var_31f73ed4015fc20d.var_54880b4df4a8e32a < self.skilltracks.size )
        {
            mostRecentSkillTrackLootID = self.pers[ "mostRecentSkillTrackLootID" ];
            
            if ( mostRecentSkillTrackLootID && self.skilltracks[ mostRecentSkillTrackLootID ] )
            {
                var_683c0d561cbb5672 = self.skilltracks[ mostRecentSkillTrackLootID ];
                self.skilltracks[ mostRecentSkillTrackLootID ] = undefined;
                self.pers[ "mostRecentSkillTrackLootID" ] = undefined;
            }
            else
            {
                var_683c0d561cbb5672 = self.skilltracks[ self.skilltracks.size - 1 ];
                self.skilltracks[ self.skilltracks.size - 1 ] = undefined;
            }
            
            foreach ( skill in var_683c0d561cbb5672.skills )
            {
                skillref = skill.skillref;
                skilllevel = self.activeskills[ skillref ];
                
                if ( isdefined( skilllevel ) )
                {
                    var_e48e2da022db5569[ var_e48e2da022db5569.size ] = { #skilllevel:skilllevel, #skillref:skillref };
                }
            }
        }
    }
    
    var_b56a86f9fbb7dbe4 = getscriptbundlefieldvalue( level.var_858d230de58cc743.var_4e18ee5e7c3b2610, #"skills" );
    
    if ( self.powertier < 61 )
    {
        var_49777dc332f0c37b = 1;
        
        foreach ( skill in var_b56a86f9fbb7dbe4 )
        {
            skilllevel = self.activeskills[ skill.skillref ];
            
            if ( !isdefined( skilllevel ) )
            {
                var_49777dc332f0c37b = 0;
                break;
            }
            
            skillbundle = level.skillbundles[ skill.skillref ][ skilllevel ];
            
            if ( skilllevel != skillbundle.var_f463fd4a9608ce51 )
            {
                var_49777dc332f0c37b = 0;
                break;
            }
        }
        
        if ( var_49777dc332f0c37b )
        {
            var_67a4a9f5144b1aa1 = 0;
            var_426779e9ebb4b75c = 0;
            
            for ( powertier = self.powertier - var_27060f81362044b3; powertier < 61 ; powertier++ )
            {
                var_31f73ed4015fc20d = utility::callsharedfunc( #"ob_skill_tracks", #"hash_645ee2bb8bf341ad", powertier );
                
                if ( var_31f73ed4015fc20d.skillchoice == "DAMAGE_UPGRADE" )
                {
                    var_67a4a9f5144b1aa1++;
                    continue;
                }
                
                if ( var_31f73ed4015fc20d.skillchoice == "SURVIVAL_UPGRADE" )
                {
                    var_426779e9ebb4b75c++;
                }
            }
        }
    }
    
    powertier = self.powertier;
    
    while ( var_3ce9289a5c028701 && self.activeskills.size )
    {
        var_31f73ed4015fc20d = utility::callsharedfunc( #"ob_skill_tracks", #"hash_645ee2bb8bf341ad", powertier - 1 );
        var_54579d84c01579de = undefined;
        
        if ( var_67a4a9f5144b1aa1 || !isdefined( var_67a4a9f5144b1aa1 ) && var_31f73ed4015fc20d.skillchoice == "DAMAGE_UPGRADE" )
        {
            activeskills = [];
            
            foreach ( skill in var_b56a86f9fbb7dbe4 )
            {
                skilllevel = self.activeskills[ skill.skillref ];
                
                if ( isdefined( skilllevel ) && skill.var_a641a158f82c38fe )
                {
                    skillbundle = level.skillbundles[ skill.skillref ][ skilllevel ];
                    activeskills[ activeskills.size ] = { #skillbundle:skillbundle, #skilllevel:skilllevel };
                }
            }
            
            if ( activeskills.size )
            {
                activeskills = function_7243d45b5d82f431( activeskills, #skilllevel, 1 );
                var_54579d84c01579de = activeskills[ 0 ].skillbundle;
                
                if ( var_67a4a9f5144b1aa1 )
                {
                    var_67a4a9f5144b1aa1--;
                }
            }
        }
        else if ( var_426779e9ebb4b75c || !isdefined( var_426779e9ebb4b75c ) && var_31f73ed4015fc20d.skillchoice == "SURVIVAL_UPGRADE" )
        {
            activeskills = [];
            
            foreach ( skill in var_b56a86f9fbb7dbe4 )
            {
                skilllevel = self.activeskills[ skill.skillref ];
                
                if ( isdefined( skilllevel ) && !skill.var_a641a158f82c38fe )
                {
                    skillbundle = level.skillbundles[ skill.skillref ][ skilllevel ];
                    activeskills[ activeskills.size ] = { #skillbundle:skillbundle, #skilllevel:skilllevel };
                }
            }
            
            if ( activeskills.size )
            {
                activeskills = function_7243d45b5d82f431( activeskills, #skilllevel, 1 );
                var_54579d84c01579de = activeskills[ 0 ].skillbundle;
                
                if ( var_426779e9ebb4b75c )
                {
                    var_426779e9ebb4b75c--;
                }
            }
        }
        else if ( var_e48e2da022db5569.size )
        {
            skill = var_e48e2da022db5569[ var_e48e2da022db5569.size - 1 ];
            var_54579d84c01579de = level.skillbundles[ skill.skillref ][ skill.skilllevel ];
            
            if ( skill.skilllevel == 0 )
            {
                var_e48e2da022db5569[ var_e48e2da022db5569.size - 1 ] = undefined;
            }
            else
            {
                skill.skilllevel--;
            }
        }
        else
        {
            var_5081ac841a5ad337 = 0;
            
            foreach ( skillref, skilllevel in self.activeskills )
            {
                skillbundle = level.skillbundles[ skillref ][ skilllevel ];
                
                if ( skillbundle.skillcategory == #"end_game" || skillbundle.skillcategory == #"nightmare" || skillbundle.skillcategory == #"core_stat" )
                {
                    continue;
                }
                
                if ( skillbundle.var_f463fd4a9608ce51 == 0 )
                {
                    var_54579d84c01579de = skillbundle;
                    break;
                }
                
                if ( skilllevel >= var_5081ac841a5ad337 )
                {
                    var_5081ac841a5ad337 = skilllevel;
                    var_54579d84c01579de = skillbundle;
                }
            }
        }
        
        if ( var_54579d84c01579de )
        {
            if ( !var_c9839c614bfae27c )
            {
                utility::callsharedfunc( #"skills", #"removeskill", var_54579d84c01579de.skillref );
                
                if ( var_54579d84c01579de.skilllevel > 0 )
                {
                    utility::callsharedfunc( #"skills", #"giveskill", var_54579d84c01579de.skillref, var_54579d84c01579de.skilllevel - 1, 1, 1 );
                }
            }
            else if ( var_54579d84c01579de.skilllevel > 0 )
            {
                self.activeskills[ var_54579d84c01579de.skillref ] = var_54579d84c01579de.skilllevel - 1;
            }
            else
            {
                self.activeskills[ var_54579d84c01579de.skillref ] = undefined;
            }
            
            var_3ce9289a5c028701--;
            powertier--;
            continue;
        }
        
        assertmsg( "<dev string:x91>" + var_3ce9289a5c028701 + "<dev string:xb8>" + powertier );
        break;
    }
    
    self.powertier_xp = 0;
    self.pers[ "powerTier_powerTierXP" ] = 0;
    self.powertier -= var_27060f81362044b3 - var_3ce9289a5c028701;
    function_69df1bfb965b995d( self.powertier, 0 );
    self.selectableskills = undefined;
    utility::callsharedfunc( #"ob_skill_tracks", #"hash_9a28d6cd3de8589e", self.powertier );
    self setclientomnvar( "ui_ob_selectable_skill_index_1", 0 );
    self setclientomnvar( "ui_ob_selectable_skill_index_2", 0 );
    
    if ( self.var_4971bba44f275df )
    {
        switch ( self.var_4971bba44f275df )
        {
            case #"hash_3c6a2be723070e29":
                self setclientomnvar( "ui_ob_skill_upgrade_type", 3 );
                break;
            case #"hash_f89a366fb7e1d999":
                self setclientomnvar( "ui_ob_skill_upgrade_type", 0 );
                break;
            default:
                self setclientomnvar( "ui_ob_skill_upgrade_type", 1 );
                break;
        }
    }
    else
    {
        self setclientomnvar( "ui_ob_skill_upgrade_type", 1 );
    }
    
    function_75cc84297f5ba7ab();
}

// Namespace ob_power_tier
// Params 1
// Checksum 0x92462c8a, Offset: 0x1811
// Size: 0x330
function function_4b9999f24a7eac62( params )
{
    player = params.player;
    
    if ( !player || !params.skillref || !isdefined( params.skilllevel ) )
    {
        return;
    }
    
    skillbundle = level.skillbundles[ params.skillref ][ params.skilllevel ];
    skillcategory = skillbundle.skillcategory;
    
    if ( skillcategory != #"end_game" && skillcategory != #"nightmare" )
    {
        return;
    }
    
    if ( player.var_8480709ca4977987 )
    {
        return;
    }
    
    player.var_8480709ca4977987 = 1;
    waittillframeend();
    player.var_8480709ca4977987 = 0;
    
    if ( !player )
    {
        return;
    }
    
    player.var_1db23e0735771ec5 = 0;
    player.var_38cdb896b8360654 = 0;
    var_da5f024e634b003d = [];
    var_f56ba134dee7c7b8 = 0;
    var_3734788617a9bbff = 0;
    var_fc419f63efbf887c = player.operatorprestige > 0 ? 2 : 1;
    var_fadc9939f3f5d597 = player.operatorprestige > 1 ? 2 : 1;
    var_cec6d7babfd60567 = getdvarint( @"hash_d52ea7779919a84c", 1 );
    
    foreach ( skillref, skilllevel in player.activeskills )
    {
        skillbundle = level.skillbundles[ skillref ][ skilllevel ];
        
        switch ( getxhash( skillbundle.skillcategory ) )
        {
            case #"end_game":
                var_f56ba134dee7c7b8++;
                
                if ( var_cec6d7babfd60567 && var_f56ba134dee7c7b8 > var_fc419f63efbf887c )
                {
                    var_da5f024e634b003d[ var_da5f024e634b003d.size ] = skillbundle.skillref;
                    break;
                }
                
                player.var_1db23e0735771ec5 += skilllevel + 1;
                break;
            case #"nightmare":
                var_3734788617a9bbff++;
                
                if ( var_cec6d7babfd60567 && var_3734788617a9bbff > var_fadc9939f3f5d597 )
                {
                    var_da5f024e634b003d[ var_da5f024e634b003d.size ] = skillbundle.skillref;
                    break;
                }
                
                player.var_38cdb896b8360654 += skilllevel + 1;
                break;
        }
    }
    
    foreach ( skillref in var_da5f024e634b003d )
    {
        player utility::callsharedfunc( #"skills", #"removeskill", skillref );
    }
    
    player function_75cc84297f5ba7ab();
}

// Namespace ob_power_tier
// Params 2
// Checksum 0x7276b2a1, Offset: 0x1b49
// Size: 0x157
function function_69df1bfb965b995d( powertier, playfx )
{
    if ( self.powertier != powertier )
    {
        telemetry_utils::function_bce6584b90db3f0d( "power_tier_" + ( self.powertier ?? 0 ) + "_" + ( powertier ?? 0 ) );
        level callback::callback( #"hash_6c71d319dc089c27", { #powertier:powertier, #player:self, #event:#"hash_f806b55b771c5da0" } );
    }
    
    self.powertier = powertier;
    var_858d230de58cc743 = level.var_858d230de58cc743;
    powertierxprequired = 500;
    
    foreach ( var_91b83336928ed4d9 in var_858d230de58cc743.var_a35da1eac33aeefb )
    {
        if ( powertier >= var_91b83336928ed4d9.powertierxplevel )
        {
            powertierxprequired = var_91b83336928ed4d9.powertierxprequired;
            continue;
        }
        
        break;
    }
    
    self.powertiernexttierxp = powertierxprequired;
    ob::function_332da4f77cda494();
}

// Namespace ob_power_tier
// Params 0
// Checksum 0x35b6c2aa, Offset: 0x1ca8
// Size: 0x1b2
function function_ef05c43368e714fa()
{
    self endon( #"disconnect" );
    self.pers[ "powerTier_pendingReward" ] = 1;
    function_75cc84297f5ba7ab();
    logstring( "[OB_POWER_TIER] Player [" + ( self.name ?? "" ) + "] restored skill selection with " + self.powertier_xp + "/" + self.powertiernexttierxp + " xp points." );
    utility::callsharedfunc( #"ob_skill_tracks", #"hash_92aa850c92f2fac0", [ self ] );
    
    if ( self.var_6c41ce781dd1b407 )
    {
        return;
    }
    
    if ( self.powertier_xp >= self.powertiernexttierxp )
    {
        self.powertier_xp -= self.powertiernexttierxp;
        self.powertier_xp = maxint( self.powertier_xp, 0 );
    }
    
    self.skillpicked = undefined;
    self.pers[ "powerTier_pendingReward" ] = 0;
    function_69df1bfb965b995d( self.powertier + 1, 1 );
    logstring( "[OB_POWER_TIER] Player [" + ( self.name ?? "" ) + "] combat rating increased after restoring rewards." );
    
    if ( self.pers[ "powerTier_xpParams" ] )
    {
        function_b03835d70ce9355d( self.pers[ "powerTier_xpParams" ].event, self.pers[ "powerTier_xpParams" ].points );
    }
    
    function_75cc84297f5ba7ab();
    
    if ( level.var_858d230de58cc743.var_5bb06be1c6dd46c9 )
    {
        self playsoundtoplayer( level.var_858d230de58cc743.var_5bb06be1c6dd46c9, self );
    }
}

// Namespace ob_power_tier
// Params 2
// Checksum 0xa74e5654, Offset: 0x1e62
// Size: 0x86
function function_49df213d9360b40a( tier, powertier_xp )
{
    assert( isplayer( self ) );
    function_69df1bfb965b995d( tier, 0 );
    combatrating = utility::callsharedfunc( #"ob_skill_tracks", #"hash_20f154cc7ce486fe" );
    
    if ( self.powertier != combatrating )
    {
        self.powertier = combatrating;
    }
    
    self.powertier_xp = clampint( powertier_xp, 0, 16383 );
    function_75cc84297f5ba7ab( 1 );
}

// Namespace ob_power_tier
// Params 2
// Checksum 0x80c75f36, Offset: 0x1ef0
// Size: 0x2a6
function function_75cc84297f5ba7ab( restore = 0, rewardevent )
{
    self setclientomnvar( "ui_ob_power_tier_restore", restore );
    self setclientomnvar( "ui_ob_power_tier", function_6d4cdb24ee2c66c0() );
    var_acecf1de8ec2250a = self.operatorprestige < 3 ? 61 : 77;
    
    if ( self.powertier >= var_acecf1de8ec2250a )
    {
        self setclientomnvar( "ui_ob_power_tier_xp", 1 );
        self setclientomnvar( "ui_ob_power_tier_next_level_xp", 1 );
    }
    else
    {
        self setclientomnvar( "ui_ob_power_tier_xp", clampint( self.powertier_xp, 0, 16383 ) );
        self setclientomnvar( "ui_ob_power_tier_next_level_xp", clampint( self.powertiernexttierxp, 0, 16383 ) );
    }
    
    squadmemberindex = self.sessionuimemberindex;
    
    if ( !( isdefined( squadmemberindex ) && isdefined( self.team ) ) || self.isdisconnecting || squadmemberindex >= level.maxsquadsize || squadmemberindex < 0 )
    {
        return;
    }
    
    squadmates = level.teamdata[ self.team ][ "players" ];
    
    if ( isdefined( level.squaddata[ self.team ][ self.sessionsquadid ] ) )
    {
        squadmates = level.squaddata[ self.team ][ self.sessionsquadid ].players;
    }
    
    foreach ( player in squadmates )
    {
        if ( player.sessionuimemberindex < level.maxsquadsize )
        {
            powertier = player function_6d4cdb24ee2c66c0();
            
            foreach ( player2 in squadmates )
            {
                if ( player2 isconnected() && !player2.isdisconnecting )
                {
                    player2 setclientomnvar( "ui_ob_power_tier_squad_index_" + player.sessionuimemberindex, powertier );
                }
            }
        }
    }
}

// Namespace ob_power_tier
// Params 1
// Checksum 0x14b03d43, Offset: 0x219e
// Size: 0x50
function play_power_tier_fx( duration )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    self setscriptablepartstate( "power_tier_fx", "super_fx_on", 0 );
    wait duration;
    self setscriptablepartstate( "power_tier_fx", "super_fx_off", 0 );
}

// Namespace ob_power_tier
// Params 0
// Checksum 0x418e2c08, Offset: 0x21f6
// Size: 0xd
function function_52ebca6bcb51dc20()
{
    self.var_52ebca6bcb51dc20 = 1;
}

// Namespace ob_power_tier
// Params 0
// Checksum 0x6dc73549, Offset: 0x220b
// Size: 0xc
function function_2c3d5a09659f6e69()
{
    self.var_52ebca6bcb51dc20 = undefined;
}

/#

    // Namespace ob_power_tier
    // Params 0, eflags: 0x4
    // Checksum 0x325136a6, Offset: 0x221f
    // Size: 0x81, Type: dev
    function private initdev()
    {
        var_2007867e0cbe557a = game_utility::getgametype() != "<dev string:xe3>";
        
        if ( var_2007867e0cbe557a )
        {
            devgui::function_9082edeb5db93280( "<dev string:xe6>" );
            devgui::add_devgui_command( "<dev string:xf5>", "<dev string:xfe>" );
            devgui::add_devgui_command( "<dev string:x120>", "<dev string:x12c>" );
            devgui::add_devgui_command( "<dev string:x14f>", "<dev string:x156>" );
            devgui::add_devgui_command( "<dev string:x173>", "<dev string:x17c>" );
            devgui::function_77df7fe7dd273e10();
        }
        
        level thread function_60251d3506f7495();
    }

    // Namespace ob_power_tier
    // Params 0, eflags: 0x4
    // Checksum 0x209cdde3, Offset: 0x22a8
    // Size: 0x190, Type: dev
    function private function_60251d3506f7495()
    {
        while ( true )
        {
            if ( !isdefined( level.players ) )
            {
                waitframe();
                continue;
            }
            
            cheatplayers = level.players;
            clientnum = int( getdvar( @"hash_13d8008e8edc58d5", "<dev string:x199>" ) );
            
            if ( clientnum != -1 )
            {
                setdvar( @"hash_13d8008e8edc58d5", "<dev string:x199>" );
                client = utility::function_3bc2c606a1c39e2f( clientnum );
                
                if ( isplayer( client ) )
                {
                    cheatplayers = [ client ];
                }
            }
            
            var_6e4cf32910d62e5b = getdvar( @"cheat_player" );
            
            if ( isdefined( var_6e4cf32910d62e5b ) )
            {
                foreach ( player in level.players )
                {
                    if ( player.name == var_6e4cf32910d62e5b )
                    {
                        cheatplayers = [ player ];
                        break;
                    }
                }
            }
            
            cheat_dvars = function_d736a179632efa58();
            
            if ( cheat_dvars[ #"power_tier_cap" ] )
            {
                thread function_4fa7c278b9f1d95b( cheatplayers, cheat_dvars[ #"power_tier_cap" ] );
            }
            
            if ( cheat_dvars[ #"power_tiers" ] )
            {
                thread function_f71122bb8436370e( cheatplayers, cheat_dvars[ #"power_tiers" ] );
            }
            
            waitframe();
        }
    }

    // Namespace ob_power_tier
    // Params 0, eflags: 0x4
    // Checksum 0xd322b5d6, Offset: 0x2440
    // Size: 0x3b, Type: dev
    function private function_d736a179632efa58()
    {
        return [ #"power_tiers":utility::consume_dvar_int( @"hash_964f41754c917503", 0 ), #"power_tier_cap":utility::consume_dvar_int( @"hash_3c2cba353ca2e863", 0 ) ];
    }

    // Namespace ob_power_tier
    // Params 2, eflags: 0x4
    // Checksum 0xe305310c, Offset: 0x2483
    // Size: 0x9f, Type: dev
    function private function_4fa7c278b9f1d95b( cheatplayers, power_tier_cap )
    {
        foreach ( cheatplayer in cheatplayers )
        {
            if ( power_tier_cap == 1 )
            {
                cheatplayer function_52ebca6bcb51dc20();
            }
            else
            {
                cheatplayer function_2c3d5a09659f6e69();
            }
            
            waitframe();
        }
    }

    // Namespace ob_power_tier
    // Params 2, eflags: 0x4
    // Checksum 0x5e886165, Offset: 0x252a
    // Size: 0xe1, Type: dev
    function private function_f71122bb8436370e( cheatplayers, power_tiers )
    {
        power_tiers = clampint( power_tiers, 1, 99 );
        
        foreach ( cheatplayer in cheatplayers )
        {
            for ( i = 0; i < power_tiers ; i++ )
            {
                params = spawnstruct();
                params.points = cheatplayer.powertiernexttierxp - cheatplayer.powertier_xp;
                cheatplayer function_72c580641320b75a( params );
            }
            
            waitframe();
        }
    }

#/
