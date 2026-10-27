// scripts\mp\ob\systems\ob_skill_tracks.gsc  (hash_03d0100bf79570a1.gscc) (size: 28268 Bytes / 0x6e6c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x13b8cb12 (330877714)
// size ...... 28268 (0x6e6c)
// includes .. 13  (offset: 0x68b4)
// strings ... 64  (offset: 0x691c)
// dev strs .. 24  (offset: 0x6d48)
// exports ... 43  (offset: 0x5160)
// cseg ...... 0x5ec + 0x4b74 (0x5160)
// imports ... 122 (offset: 0x5818)
// animtree1 . 0   (offset: 0x6e6c)
// animtree2 . 0   (offset: 0x6e6c)
#using script_2fe74ee229c972c3;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\loot\common_instance_inventory;
#using scripts\mp\loot\common_item;
#using scripts\mp\ob\ob_skill_select;
#using scripts\mp\ob\ob_upgrade_splash;
#using scripts\mp\ob\systems\ob_power_tier;

#namespace ob_skill_tracks;

// Namespace ob_skill_tracks
// Params 0, eflags: 0x1
// Checksum 0xd8c510e3, Offset: 0x60a
// Size: 0x3f7
function autoexec main()
{
    if ( !getdvarint( @"hash_a9e966a0d3e4c6bb", 0 ) )
    {
        return;
    }
    
    if ( !( level.gametypebundle.skills.enableskills ?? level.gamemodebundle.enableskills ) )
    {
        return;
    }
    
    shared_skills::function_b667da63ece9b966( #"skills_tracks", &init );
    var_ff3e7ab471202f85 = level.gametypebundle.skills.skilltracklist ?? level.gamemodebundle.skilltracklist;
    
    if ( isdefined( var_ff3e7ab471202f85 ) )
    {
        var_974155d5d1b9324a = getscriptbundle( var_ff3e7ab471202f85 );
        assert( isdefined( var_974155d5d1b9324a ), getxhashsourcename( var_ff3e7ab471202f85 ) + "<dev string:x24>" );
        level.skilltracklist = [];
        
        foreach ( index, track in var_974155d5d1b9324a.skilltracklist )
        {
            if ( !track.skilltrack )
            {
                continue;
            }
            
            skilltrack = getscriptbundle( track.skilltrack );
            skilltrack.index = index;
            skilltrack.ref = track.skilltrack;
            skilltrack.isspecial = istrue( track.isspecial );
            skilltrack.var_d37e61d21c0a2c77 = istrue( track.var_d37e61d21c0a2c77 );
            level.skilltracklist[ level.skilltracklist.size ] = skilltrack;
        }
    }
    
    if ( !level.gametypebundle.var_858d230de58cc743 )
    {
        return;
    }
    
    level.var_858d230de58cc743 = getscriptbundle( level.gametypebundle.var_858d230de58cc743 );
    assert( isdefined( level.var_858d230de58cc743 ), getxhashsourcename( level.gametypebundle.var_858d230de58cc743 ) + "<dev string:x40>" );
    
    if ( level.var_858d230de58cc743.var_4281aa3f0598bb1a )
    {
        level.var_4281aa3f0598bb1a = [];
        level.var_4281aa3f0598bb1a[ "AT" ] = [];
        level.var_4281aa3f0598bb1a[ "EVERY" ] = [];
        level.var_4281aa3f0598bb1a[ "ABOVE" ] = [];
        level.var_e5407a42d2fc1f0 = 0;
        
        foreach ( rule in level.var_858d230de58cc743.var_4281aa3f0598bb1a )
        {
            switch ( rule.var_31f73ed4015fc20d )
            {
                case #"hash_fa7cecf6bda5da28":
                    level.var_4281aa3f0598bb1a[ "AT" ][ rule.var_357fcbfb5c1b355f ] = rule;
                    break;
                case #"hash_b6dc0a17d2ed3244":
                    level.var_4281aa3f0598bb1a[ "EVERY" ][ rule.var_1d3ea4dae36a3fd0 ] = rule;
                    break;
                case #"hash_6255df36888fcd0a":
                    level.var_4281aa3f0598bb1a[ "ABOVE" ][ rule.var_357fcbfb5c1b355f ] = rule;
                    break;
                default:
                    break;
            }
            
            if ( rule.skillchoice == "NEW_TRACK" )
            {
                rule.var_54880b4df4a8e32a = level.var_e5407a42d2fc1f0;
                level.var_e5407a42d2fc1f0++;
            }
        }
    }
}

// Namespace ob_skill_tracks
// Params 0
// Checksum 0xf205b4d9, Offset: 0xa09
// Size: 0x203
function init()
{
    level callback::add( #"skill_acquired", &function_2a7f96ce8d50c38f );
    level callback::add( #"player_death", &function_b9a55e2db124cd33 );
    level callback::add( #"player_spawned", &function_71ca51d52380208a );
    utility::registersharedfunc( #"ob_skill_tracks", #"hash_e31febe4a760ad29", &function_c5ba63908b9bcaa7 );
    utility::registersharedfunc( #"ob_skill_tracks", #"hash_20f154cc7ce486fe", &function_315ca51712e9e354 );
    utility::registersharedfunc( #"ob_skill_tracks", #"hash_92aa850c92f2fac0", &function_6af4ae67e2db2ea6 );
    utility::registersharedfunc( #"ob_skill_tracks", #"hash_9a28d6cd3de8589e", &function_d7674fd8579fbcb8 );
    utility::registersharedfunc( #"ob_skill_tracks", #"hash_645ee2bb8bf341ad", &function_5d67d292f2c4697 );
    utility::registersharedfunc( #"ob_skill_tracks", #"hash_89712717ea90983f", &function_1323d25aa379ead1 );
    utility::registersharedfunc( #"ob_skill_tracks", #"fixedloadout", &function_b8fe304aea4f82b1 );
    utility::registersharedfunc( #"ob_skill_tracks", #"levelboost", &function_23888ba187a6e4be );
    utility::registersharedfunc( #"ob_skill_tracks", #"reset", &function_c46c6e25a71dd61a );
    ui::lui_registercallback( "ob_skill_select_intro_complete", &function_a463aa654aa04df );
    players = level.players;
    
    foreach ( player in players )
    {
        self setclientomnvar( "ui_ob_selectable_skill_index_1", 0 );
        self setclientomnvar( "ui_ob_selectable_skill_index_2", 0 );
        self setclientomnvar( "ui_ob_selectable_skill_index_3", 0 );
    }
}

// Namespace ob_skill_tracks
// Params 1, eflags: 0x4
// Checksum 0x4b8f3e05, Offset: 0xc14
// Size: 0x40
function private function_b9a55e2db124cd33( params )
{
    if ( ob_skill_select::ob_skill_select_is_active() )
    {
        ob_skill_select::close_ob_skill_select();
        self setclientomnvar( "ui_ob_skill_reward_reason", 0 );
        self setclientomnvar( "ui_ob_selectable_skill_index_1", 0 );
        self setclientomnvar( "ui_ob_selectable_skill_index_2", 0 );
    }
}

// Namespace ob_skill_tracks
// Params 1, eflags: 0x4
// Checksum 0xbd5b95a0, Offset: 0xc5c
// Size: 0x115
function private function_71ca51d52380208a( params )
{
    if ( !params.revivespawn )
    {
        self.var_3ec847b9b5bb1abb = 0;
        self.var_fe6f091fe36c6136 = 0;
        self.skilltracks = [];
    }
    
    if ( isdefined( self.var_9432219327bb75a3 ) )
    {
        self.skilltracks = self.var_9432219327bb75a3;
    }
    
    if ( !getdvarint( @"scr_disable_power_tier", !getmatchrulesdata( "commonOption", "powerTiersEnabled" ) ) )
    {
        self endon( #"disconnect" );
        
        while ( !isdefined( self.powertier ) )
        {
            waitframe();
        }
        
        if ( !isdefined( self.selectableskills ) )
        {
            function_d7674fd8579fbcb8( self.powertier );
        }
        
        self setclientomnvar( "ui_ob_skill_upgrade_type", 1 );
        
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
            }
        }
    }
}

// Namespace ob_skill_tracks
// Params 1, eflags: 0x4
// Checksum 0x272b70d6, Offset: 0xd79
// Size: 0x2ab
function private function_2a7f96ce8d50c38f( params )
{
    if ( !params.player || !params.skillref || !isdefined( params.skilllevel ) )
    {
        return;
    }
    
    player = params.player;
    skillref = params.skillref;
    skilllevel = params.skilllevel;
    var_cc8f9a53a9ec507f = params.var_cc8f9a53a9ec507f ?? 0;
    waittillframeend();
    
    if ( utility::callsharedfunc( #"skills", #"hash_7839ce6cac4cb514", skillref, skilllevel ) == #"end_game" || utility::callsharedfunc( #"skills", #"hash_7839ce6cac4cb514", skillref, skilllevel ) == #"nightmare" )
    {
        skillssettings = level.var_858d230de58cc743;
        
        if ( skillssettings )
        {
            var_637b95f1b52fb538 = getscriptbundle( skillssettings.var_e59f229d9bf9be39 );
            var_637b95f1b52fb538.ref = skillssettings.var_e59f229d9bf9be39;
            var_637b95f1b52fb538.isspecial = 1;
            player.skilltracks[ var_637b95f1b52fb538.lootid ] = var_637b95f1b52fb538;
        }
    }
    
    skilldata = level.skillbundles[ skillref ][ skilllevel ];
    
    if ( !var_cc8f9a53a9ec507f )
    {
        switch ( skillref )
        {
            case #"armor_upgrade":
            case #"health_upgrade":
            case #"move_speed_upgrade":
                if ( level.var_858d230de58cc743.var_9dd001c13ad03813 )
                {
                    player thread function_49ef4fbfc5ead2c( 2, level.skillbundles[ skillref ][ skilllevel ].index + 1 );
                }
                
                break;
            case #"damage_upgrade":
                if ( level.var_858d230de58cc743.var_585583c11017b0fd )
                {
                    player thread function_49ef4fbfc5ead2c( 1, level.skillbundles[ skillref ][ skilllevel ].index + 1, skilllevel + 1 );
                }
                
                break;
        }
    }
    
    var_9eb5d60136de1c65 = level.var_858d230de58cc743.var_89b06cbde19c889e ?? 7;
    
    if ( skilldata.var_6040d5f43ca7a49a )
    {
        if ( skilllevel == player.var_3ec847b9b5bb1abb )
        {
            player.var_fe6f091fe36c6136++;
        }
        
        if ( player.var_fe6f091fe36c6136 >= var_9eb5d60136de1c65 )
        {
            player.var_3ec847b9b5bb1abb++;
            player.var_fe6f091fe36c6136 = 0;
        }
    }
}

// Namespace ob_skill_tracks
// Params 0, eflags: 0x4
// Checksum 0x13141cd9, Offset: 0x102c
// Size: 0x224
function private function_315ca51712e9e354()
{
    combatrating = 1;
    
    if ( self.activeskills )
    {
        foreach ( skillref, skilllevel in self.activeskills )
        {
            if ( utility::callsharedfunc( #"skills", #"hash_7839ce6cac4cb514", skillref, skilllevel ) != #"end_game" && utility::callsharedfunc( #"skills", #"hash_7839ce6cac4cb514", skillref, skilllevel ) != #"nightmare" && utility::callsharedfunc( #"skills", #"hash_7839ce6cac4cb514", skillref, skilllevel ) != #"ability" )
            {
                combatrating += skilllevel + 1;
            }
        }
    }
    else if ( self.loadoutskills )
    {
        foreach ( var_68ffb124ecf20c1c in self.loadoutskills )
        {
            bundle = getscriptbundlefieldvalues( var_68ffb124ecf20c1c, [ #"skilllevel", #"hash_328ef7b7091f63ce" ] );
            
            if ( isdefined( bundle.skilllevel ) && bundle.skillcategory != #"end_game" && bundle.skillcategory != #"nightmare" && bundle.skillcategory != #"ability" )
            {
                combatrating += bundle.skilllevel + 1;
            }
        }
    }
    
    return combatrating;
}

// Namespace ob_skill_tracks
// Params 0, eflags: 0x4
// Checksum 0x3678c24a, Offset: 0x1259
// Size: 0x30
function private function_23409423a9b51e0a()
{
    utility::callsharedfunc( #"hint", #"add_simple", "hint_skills_use", &"sat_ob/hint_skills_use", 10, undefined, undefined, undefined, undefined, 0 );
}

// Namespace ob_skill_tracks
// Params 2, eflags: 0x4
// Checksum 0x696978be, Offset: 0x1291
// Size: 0x143
function private function_6af4ae67e2db2ea6( validplayers, activityreward )
{
    if ( activityreward )
    {
        return;
    }
    
    if ( isautopilot( self ) )
    {
        self notify( #"hash_ecda19d4dee34737" );
    }
    
    foreach ( player in validplayers )
    {
        if ( getdvarint( @"hash_7d59269051759e99", 1 ) )
        {
            player thread function_23409423a9b51e0a();
        }
        
        if ( getdvarint( @"hash_7d59269051759e99", 1 ) )
        {
            player utility::callsharedfunc( #"hint", #"close", "hint_skills_use", 1 );
        }
        
        var_64a78aa9b96cf074 = self.var_4971bba44f275df == "CORE_UPGRADE" ? level.var_858d230de58cc743.var_edbeb4ea6310eacd : level.var_858d230de58cc743.var_cb94ecdeeec42c5e;
        
        if ( var_64a78aa9b96cf074 )
        {
            player playsoundtoplayer( var_64a78aa9b96cf074, player );
        }
        
        player function_c5ba63908b9bcaa7();
    }
}

// Namespace ob_skill_tracks
// Params 1, eflags: 0x4
// Checksum 0x899c55a3, Offset: 0x13dc
// Size: 0x297
function private function_5d67d292f2c4697( powertier )
{
    rule = level.var_4281aa3f0598bb1a[ "AT" ][ powertier ];
    var_5f9ddbb27b1ddd36 = !isdefined( rule.requiredprestige ) || self.operatorprestige >= rule.requiredprestige;
    var_8bcc1968343d1daa = !isdefined( rule.var_104780e73f6503de ) || self.skilltracks.size == rule.var_104780e73f6503de;
    
    if ( rule && var_5f9ddbb27b1ddd36 && var_8bcc1968343d1daa )
    {
        return rule;
    }
    
    foreach ( rule in level.var_4281aa3f0598bb1a[ "EVERY" ] )
    {
        var_5f9ddbb27b1ddd36 = !isdefined( rule.requiredprestige ) || self.operatorprestige >= rule.requiredprestige;
        
        if ( !var_5f9ddbb27b1ddd36 )
        {
            continue;
        }
        
        var_8bcc1968343d1daa = !isdefined( rule.var_104780e73f6503de ) || self.skilltracks.size == rule.var_104780e73f6503de;
        
        if ( !var_8bcc1968343d1daa )
        {
            continue;
        }
        
        if ( powertier == rule.var_1d3ea4dae36a3fd0 || powertier > rule.var_1d3ea4dae36a3fd0 && ( powertier - rule.var_1d3ea4dae36a3fd0 ) % rule.var_357fcbfb5c1b355f == 0 )
        {
            return rule;
        }
    }
    
    foreach ( rule in level.var_4281aa3f0598bb1a[ "ABOVE" ] )
    {
        var_5f9ddbb27b1ddd36 = !isdefined( rule.requiredprestige ) || self.operatorprestige >= rule.requiredprestige;
        
        if ( !var_5f9ddbb27b1ddd36 )
        {
            continue;
        }
        
        var_8bcc1968343d1daa = !isdefined( rule.var_104780e73f6503de ) || self.skilltracks.size == rule.var_104780e73f6503de;
        
        if ( !var_8bcc1968343d1daa )
        {
            continue;
        }
        
        if ( powertier > rule.var_357fcbfb5c1b355f )
        {
            return rule;
        }
    }
}

// Namespace ob_skill_tracks
// Params 0, eflags: 0x4
// Checksum 0x15668e7e, Offset: 0x167c
// Size: 0x510
function private function_c5ba63908b9bcaa7()
{
    var_2a1677bd8ea533f9 = gettime();
    self endon( #"death_or_disconnect" );
    self endon( #"skills_reset" );
    logstring( "[OB_SKILLS] Showing skill selections [" + ( self.selectableskills[ 0 ].lootid ?? 0 ) + "] and [" + ( self.selectableskills[ 1 ].lootid ?? 0 ) + "] to player [" + ( self.name ?? "" ) + "]" );
    skillssettings = level.var_858d230de58cc743;
    
    if ( skillssettings.var_fe8c5e1fb6b3032b && self.selectableskills[ 0 ].skillref == #"damage_upgrade" )
    {
        skillpicked = 0;
        
        if ( level.var_858d230de58cc743.var_37fb8867a336b4b8 )
        {
            self playsoundtoplayer( level.var_858d230de58cc743.var_37fb8867a336b4b8, self );
        }
    }
    else
    {
        if ( !self.selectableskills[ 0 ] && !self.selectableskills[ 1 ] )
        {
            function_d7674fd8579fbcb8( self.powertier );
            
            if ( !self.selectableskills[ 0 ] && !self.selectableskills[ 1 ] )
            {
                return 0;
            }
        }
        
        skillpicked = function_f9520204c29a34d8();
        
        if ( !self )
        {
            return;
        }
        
        if ( !isdefined( skillpicked ) )
        {
            self.var_6c41ce781dd1b407 = 1;
            return 0;
        }
    }
    
    if ( !self.selectableskills[ skillpicked ] )
    {
        skillpicked = !skillpicked;
    }
    
    var_f916a5e9f77dd0ba = self.selectableskills[ 0 ];
    var_7d10ecea58bfbce0 = self.selectableskills[ 1 ];
    selectedskill = self.selectableskills[ skillpicked ];
    
    if ( self.selectabletracks )
    {
        selectedtrack = self.selectabletracks[ skillpicked ];
        
        if ( !isdefined( self.tracksshown ) )
        {
            self.tracksshown = [];
        }
        
        if ( self.selectabletracks[ 0 ].lootid )
        {
            self.tracksshown[ self.selectabletracks[ 0 ].lootid ] = 1;
        }
        
        if ( self.selectabletracks[ 1 ].lootid )
        {
            self.tracksshown[ self.selectabletracks[ 1 ].lootid ] = 1;
        }
    }
    
    waitframe();
    
    if ( skillpicked == -1 )
    {
        return 0;
    }
    
    logstring( "[OB_SKILLS] Player [" + ( self.name ?? "" ) + "] selected skill [" + ( self.selectableskills[ skillpicked ].lootid ?? 0 ) + "]" );
    
    if ( self.selectableskills[ skillpicked ] )
    {
        var_abbd983ebcd58640 = level.var_858d230de58cc743.var_b3bce724f6c59480 ?? 1;
        self.var_1a158b8a4f9dd2a6[ self.selectableskills[ skillpicked ].skillref ] = var_abbd983ebcd58640;
    }
    
    otherskill = 1;
    
    if ( skillpicked )
    {
        otherskill = 0;
    }
    
    if ( self.selectableskills[ otherskill ] )
    {
        var_39c8f17e8e25156c = level.var_858d230de58cc743.var_cdf13a972110ce94 ?? 1;
        self.var_1a158b8a4f9dd2a6[ self.selectableskills[ otherskill ].skillref ] = var_39c8f17e8e25156c;
    }
    
    if ( isdefined( self.activeskills[ selectedskill.skillref ] ) )
    {
        utility::callsharedfunc( #"skills", #"removeskill", selectedskill.skillref );
        waitframe();
    }
    
    success = utility::callsharedfunc( #"skills", #"giveskill", selectedskill.skillref, selectedskill.skilllevel );
    
    if ( success )
    {
        if ( selectedtrack )
        {
            self.skilltracks[ selectedtrack.lootid ] = selectedtrack;
            self.pers[ "mostRecentSkillTrackLootID" ] = selectedtrack.lootid;
        }
        
        self.selectableskills = undefined;
        self.selectabletracks = undefined;
        function_d7674fd8579fbcb8( self.powertier + 1 );
    }
    
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
    
    function_56b5d621c0401c57( var_2a1677bd8ea533f9, selectedskill, var_f916a5e9f77dd0ba, var_7d10ecea58bfbce0 );
    return 1;
}

// Namespace ob_skill_tracks
// Params 4, eflags: 0x4
// Checksum 0x8a4b72ef, Offset: 0x1b95
// Size: 0x269
function private function_56b5d621c0401c57( var_2a1677bd8ea533f9, selectedskill, var_f916a5e9f77dd0ba, var_7d10ecea58bfbce0 )
{
    player = self;
    eventparams = [];
    eventparams[ eventparams.size ] = "level_up_ts";
    eventparams[ eventparams.size ] = var_2a1677bd8ea533f9 ?? -1;
    eventparams[ eventparams.size ] = "skill_selection_ts";
    eventparams[ eventparams.size ] = gettime() ?? -1;
    eventparams[ eventparams.size ] = "initial_level";
    eventparams[ eventparams.size ] = self.powertier ?? -1;
    eventparams[ eventparams.size ] = "end_level";
    eventparams[ eventparams.size ] = self.powertier + ( 1 ?? -1 );
    eventparams[ eventparams.size ] = "skill_choice_one";
    eventparams[ eventparams.size ] = var_f916a5e9f77dd0ba.skillref ?? #"";
    eventparams[ eventparams.size ] = "skill_choice_one_track";
    eventparams[ eventparams.size ] = var_f916a5e9f77dd0ba.skillcategory ?? "";
    eventparams[ eventparams.size ] = "skill_choice_one_rarity";
    eventparams[ eventparams.size ] = var_f916a5e9f77dd0ba.rarity ?? "";
    eventparams[ eventparams.size ] = "skill_choice_one_level";
    eventparams[ eventparams.size ] = var_f916a5e9f77dd0ba.skilllevel ?? -1;
    eventparams[ eventparams.size ] = "skill_choice_one_max_level";
    eventparams[ eventparams.size ] = var_f916a5e9f77dd0ba.var_f463fd4a9608ce51 ?? -1;
    eventparams[ eventparams.size ] = "skill_choice_two";
    eventparams[ eventparams.size ] = var_7d10ecea58bfbce0.skillref ?? #"";
    eventparams[ eventparams.size ] = "skill_choice_two_track";
    eventparams[ eventparams.size ] = var_7d10ecea58bfbce0.skillcategory ?? "";
    eventparams[ eventparams.size ] = "skill_choice_two_rarity";
    eventparams[ eventparams.size ] = var_7d10ecea58bfbce0.rarity ?? "";
    eventparams[ eventparams.size ] = "skill_choice_two_level";
    eventparams[ eventparams.size ] = var_7d10ecea58bfbce0.skilllevel ?? -1;
    eventparams[ eventparams.size ] = "skill_choice_two_max_level";
    eventparams[ eventparams.size ] = var_7d10ecea58bfbce0.var_f463fd4a9608ce51 ?? -1;
    eventparams[ eventparams.size ] = "chosen_skill";
    eventparams[ eventparams.size ] = selectedskill.skillref ?? #"";
    eventparams[ eventparams.size ] = "playlist_name";
    eventparams[ eventparams.size ] = getplaylistname() ?? "";
    player dlog_recordplayerevent( "dlog_event_ob_player_skill_gained", eventparams );
}

// Namespace ob_skill_tracks
// Params 3, eflags: 0x4
// Checksum 0xed687cf1, Offset: 0x1e06
// Size: 0xed
function private function_36694afff35a3927( skill, updatesplash, forceupdate )
{
    var_9a9be88b4df858d = [];
    var_9a9be88b4df858d[ #"level_up" ] = 1;
    var_9a9be88b4df858d[ #"contract" ] = 2;
    
    if ( !self.shouldshowsplash )
    {
        self.shouldshowsplash = 0;
    }
    
    if ( var_9a9be88b4df858d[ skill.rewardreason ] )
    {
        var_b86bb73c5211b404 = var_9a9be88b4df858d[ skill.rewardreason ];
    }
    else
    {
        var_b86bb73c5211b404 = 0;
    }
    
    if ( !skill.var_a01db2ddad5f20a )
    {
        skill.var_a01db2ddad5f20a = 0;
    }
    
    if ( !skill.rewardtier )
    {
        skill.rewardtier = 0;
    }
    
    if ( updatesplash )
    {
        if ( self.shouldshowsplash == 0 )
        {
            self.shouldshowsplash++;
            return;
        }
        
        self.shouldshowsplash--;
    }
}

// Namespace ob_skill_tracks
// Params 0, eflags: 0x4
// Checksum 0x86484966, Offset: 0x1efb
// Size: 0x1a2
function private function_f9520204c29a34d8()
{
    self endon( #"death_or_disconnect" );
    self endon( #"skills_reset" );
    
    while ( !val::get( "allow_skill_select" ) || self iswingsuitdeployed() || self isvehicleactive() )
    {
        wait 1;
    }
    
    if ( self.selectableskills[ 0 ] )
    {
        self setclientomnvar( "ui_ob_selectable_skill_index_1", self.selectableskills[ 0 ].index + 1 );
    }
    
    if ( self.selectableskills[ 1 ] )
    {
        self setclientomnvar( "ui_ob_selectable_skill_index_2", self.selectableskills[ 1 ].index + 1 );
    }
    
    self setclientomnvar( "ui_ob_skill_reward_reason", 1 );
    utility::waittill_notify_or_timeout( "ob_skill_select_intro_complete", 1.2 );
    
    while ( !val::get( "allow_skill_select" ) || self iswingsuitdeployed() || self isvehicleactive() )
    {
        wait 1;
    }
    
    ob_skill_select::open_ob_skill_select();
    var_332268be8a7aa5cd = self.var_4971bba44f275df == "CORE_UPGRADE" ? level.var_858d230de58cc743.var_a8165267d9e1d0c2 : level.var_858d230de58cc743.var_fd9981ece1b9e68f;
    
    if ( var_332268be8a7aa5cd )
    {
        self playsoundtoplayer( var_332268be8a7aa5cd, self );
    }
    
    thread function_14b84b7a756da45();
    skillpicked = utility::waittill_any_return( "SkillSelectLeft", "SkillSelectRight", "allow_skill_select" );
    ob_skill_select::close_ob_skill_select();
    
    if ( !self )
    {
        return;
    }
    
    self setclientomnvar( "ui_ob_skill_reward_reason", 0 );
    
    if ( skillpicked != "allow_skill_select" )
    {
        return ( skillpicked == "SkillSelectLeft" ? 0 : 1 );
    }
}

// Namespace ob_skill_tracks
// Params 1, eflags: 0x4
// Checksum 0xa942ed9c, Offset: 0x20a5
// Size: 0x18
function private function_a463aa654aa04df( params )
{
    self notify( #"ob_skill_select_intro_complete" );
}

// Namespace ob_skill_tracks
// Params 0, eflags: 0x4
// Checksum 0xb9541cf7, Offset: 0x20c5
// Size: 0xe8
function private function_14b84b7a756da45()
{
    self endon( #"death_or_disconnect" );
    var_45a37781b03ac7f = self.var_4971bba44f275df == "CORE_UPGRADE" ? level.var_858d230de58cc743.var_1765a49615297b82 : level.var_858d230de58cc743.var_4a0f1eec6d4c7f93;
    var_350eb222d79f2014 = self.var_4971bba44f275df == "CORE_UPGRADE" ? level.var_858d230de58cc743.var_367c7016d490277 : level.var_858d230de58cc743.var_a61e6763dec42c58;
    
    if ( !var_45a37781b03ac7f || !var_350eb222d79f2014 )
    {
        return;
    }
    
    self.skillpicked = utility::waittill_any_return( "SkillSelectLeftSFX", "SkillSelectRightSFX" );
    
    if ( self.skillpicked == "SkillSelectLeftSFX" )
    {
        self playsoundtoplayer( var_45a37781b03ac7f, self );
        return;
    }
    
    self playsoundtoplayer( var_350eb222d79f2014, self );
}

// Namespace ob_skill_tracks
// Params 1, eflags: 0x4
// Checksum 0x57a58347, Offset: 0x21b5
// Size: 0x180
function private function_d7674fd8579fbcb8( powertier )
{
    var_acecf1de8ec2250a = self.operatorprestige < 3 ? 61 : 77;
    
    if ( powertier >= var_acecf1de8ec2250a )
    {
        return;
    }
    
    if ( self.var_6e6abd7fa4d7b630 )
    {
        function_d0f05ba56cd59072( self.var_6e6abd7fa4d7b630 );
        self.var_6e6abd7fa4d7b630 = undefined;
    }
    
    if ( !self.selectableskills || self.selectableskills.size < 1 )
    {
        var_31f73ed4015fc20d = function_5d67d292f2c4697( powertier );
        
        if ( var_31f73ed4015fc20d )
        {
            function_d0f05ba56cd59072( var_31f73ed4015fc20d.skillchoice );
            
            if ( !self.selectableskills || self.selectableskills.size < 1 )
            {
                function_d0f05ba56cd59072( var_31f73ed4015fc20d.var_cd884d4fa8fa3e72 );
            }
        }
    }
    
    if ( !self.selectableskills || self.selectableskills.size < 1 )
    {
        self.var_832e4f138f18c200 = self.var_4971bba44f275df;
        self.var_4971bba44f275df = "SKILL";
        self.selectableskills = self.selectableskills ?? [];
        validskills = function_bdf3d0dbb887649b();
        self.selectableskills = function_c01f39e8bab4ca61( validskills[ 0 ], validskills[ 1 ] );
    }
    
    assert( isdefined( self.selectableskills[ 0 ] ) || isdefined( self.selectableskills[ 1 ] ), "<dev string:x65>" + powertier + "<dev string:x8e>" );
}

// Namespace ob_skill_tracks
// Params 1, eflags: 0x4
// Checksum 0x98771ea1, Offset: 0x233d
// Size: 0x312
function private function_d0f05ba56cd59072( var_31f73ed4015fc20d )
{
    switch ( var_31f73ed4015fc20d )
    {
        case #"hash_f89a366fb7e1d999":
            var_23308e473685170b = self.skilltracks.size ?? 0;
            var_83dc00241e2b8d4a = self.var_7abd0979037af008.size ? self.var_7abd0979037af008 : arrayrandomize( level.skilltracklist );
            selectableskills = [];
            selectabletracks = [];
            
            foreach ( track in var_83dc00241e2b8d4a )
            {
                if ( self.tracksshown[ track.lootid ] )
                {
                    continue;
                }
                
                if ( istrue( track.isspecial ) )
                {
                    continue;
                }
                
                if ( getdvarint( hashcat( @"hash_9a65e084422541cb", track.lootid ), 0 ) )
                {
                    continue;
                }
                
                if ( self.skilltracks[ track.lootid ] )
                {
                    continue;
                }
                
                if ( self.disabledtracks[ track.lootid ] )
                {
                    logstring( "[OB_SKILLS] Player [" + ( self.name ?? "" ) + "] Skilltrack Selection: Skilltrack [" + track.ref + "] is disabled for the player" );
                    continue;
                }
                
                startingskill = function_8b36c29974ecb1e5( track );
                
                if ( startingskill )
                {
                    if ( var_23308e473685170b == 0 && istrue( track.var_d37e61d21c0a2c77 ) )
                    {
                        selectableskills[ 0 ] = startingskill;
                        selectabletracks[ 0 ] = track;
                        continue;
                    }
                    
                    selectableskills[ selectableskills.size ] = startingskill;
                    selectabletracks[ selectabletracks.size ] = track;
                }
            }
            
            self.selectableskills = selectableskills;
            self.selectabletracks = selectabletracks;
            
            if ( !selectableskills[ 0 ] || !selectableskills[ 1 ] )
            {
                assertmsg( "<dev string:x90>" );
                function_431d3558224bad53();
            }
            
            self.var_832e4f138f18c200 = self.var_4971bba44f275df;
            self.var_4971bba44f275df = "NEW_TRACK";
            return;
        case #"hash_49ba77d7d34edcbc":
            skillssettings = level.var_858d230de58cc743;
            
            if ( skillssettings )
            {
                var_4e18ee5e7c3b2610 = getscriptbundle( skillssettings.var_4e18ee5e7c3b2610 );
                function_2389826c2ba9a43c( var_4e18ee5e7c3b2610, 0 );
            }
            
            self.var_832e4f138f18c200 = self.var_4971bba44f275df;
            self.var_4971bba44f275df = "CORE_UPGRADE";
            return;
        case #"hash_bc40f2488f923f8f":
            skillssettings = level.var_858d230de58cc743;
            
            if ( skillssettings )
            {
                var_11ecb72c7a1353cf = getscriptbundle( skillssettings.var_4e18ee5e7c3b2610 );
                function_2389826c2ba9a43c( var_11ecb72c7a1353cf, 1 );
            }
            
            self.var_832e4f138f18c200 = self.var_4971bba44f275df;
            self.var_4971bba44f275df = "CORE_UPGRADE";
            return;
    }
}

// Namespace ob_skill_tracks
// Params 0, eflags: 0x4
// Checksum 0x98f7ec3e, Offset: 0x2657
// Size: 0x26f
function private function_431d3558224bad53()
{
    var_83dc00241e2b8d4a = arrayrandomize( level.skilltracklist );
    selectableskills = [];
    selectabletracks = [];
    
    if ( !isdefined( self.tracksshown ) )
    {
        self.tracksshown = [];
    }
    
    foreach ( track in var_83dc00241e2b8d4a )
    {
        if ( self.tracksshown[ track.lootid ] )
        {
            logstring( "[OB_SKILLS] Player [" + ( self.name ?? "" ) + "] Skilltrack Selection: Skilltrack [" + track.ref + "] was already shown" );
        }
        
        if ( track.isspecial )
        {
            logstring( "[OB_SKILLS] Player [" + ( self.name ?? "" ) + "] Skilltrack Selection: Skilltrack [" + track.ref + "] is special" );
            continue;
        }
        
        if ( getdvarint( hashcat( @"hash_9a65e084422541cb", track.lootid ), 0 ) )
        {
            logstring( "[OB_SKILLS] Player [" + ( self.name ?? "" ) + "] Skilltrack Selection: Skilltrack [" + track.ref + "] is disabled" );
            continue;
        }
        
        if ( self.skilltracks[ track.lootid ] )
        {
            logstring( "[OB_SKILLS] Player [" + ( self.name ?? "" ) + "] Skilltrack Selection: Skilltrack [" + track.ref + "] is already owned" );
            continue;
        }
        
        if ( self.disabledtracks[ track.lootid ] )
        {
            logstring( "[OB_SKILLS] Player [" + ( self.name ?? "" ) + "] Skilltrack Selection: Skilltrack [" + track.ref + "] is disabled for the player" );
            continue;
        }
        
        startingskill = function_8b36c29974ecb1e5( track );
        
        if ( startingskill )
        {
            selectableskills[ selectableskills.size ] = startingskill;
            selectabletracks[ selectabletracks.size ] = track;
        }
    }
    
    self.selectableskills = selectableskills;
    self.selectabletracks = selectabletracks;
}

// Namespace ob_skill_tracks
// Params 2, eflags: 0x4
// Checksum 0x452233f1, Offset: 0x28ce
// Size: 0x59, Type: bool
function private function_55f0b722ffefbf76( skillref, skilllevel )
{
    skillbundle = level.skillbundles[ skillref ][ skilllevel ];
    
    if ( !skillbundle )
    {
        return false;
    }
    
    if ( skillbundle.var_6040d5f43ca7a49a && skilllevel > self.var_3ec847b9b5bb1abb )
    {
        return false;
    }
    
    return true;
}

// Namespace ob_skill_tracks
// Params 0, eflags: 0x4
// Checksum 0x90e9e457, Offset: 0x2930
// Size: 0x2b8
function private function_bdf3d0dbb887649b()
{
    validskills = [];
    backupskills = [];
    
    foreach ( skilltrack in self.skilltracks )
    {
        var_5ae489862927355f = function_1e9bbdf2ff12b4dd( skilltrack );
        oncooldown = 0;
        
        foreach ( skill in skilltrack.skills )
        {
            if ( skill.disabled )
            {
                continue;
            }
            
            if ( self.var_1a158b8a4f9dd2a6[ skill.skillref ] )
            {
                oncooldown = 1;
                self.var_1a158b8a4f9dd2a6[ skill.skillref ]--;
            }
            
            skilllevel = function_e7aabc89ab530194( skill.skillref );
            
            if ( skill.var_a641a158f82c38fe && var_5ae489862927355f != 3 )
            {
                continue;
            }
            
            if ( !level.skillbundles[ skill.skillref ][ skilllevel ] )
            {
                continue;
            }
            
            skillbundle = level.skillbundles[ skill.skillref ][ skilllevel ];
            
            if ( skillbundle.disabled )
            {
                continue;
            }
            
            if ( getdvarint( hashcat( @"hash_15ef5d7f9a360a5a", skillbundle.lootid ), 0 ) )
            {
                continue;
            }
            
            if ( skillbundle.skillcategory == #"end_game" || skillbundle.skillcategory == #"nightmare" )
            {
                continue;
            }
            
            if ( skilllevel > var_5ae489862927355f || oncooldown )
            {
                skillstruct = spawnstruct();
                skillstruct.skill = skill;
                skillstruct.skilllevel = skilllevel;
                backupskills[ backupskills.size ] = skillstruct;
            }
            else
            {
                skillstruct = spawnstruct();
                skillstruct.skill = skill;
                skillstruct.skilllevel = skilllevel;
                validskills[ validskills.size ] = skillstruct;
            }
            
            oncooldown = 0;
        }
    }
    
    validskills = arrayrandomize( validskills );
    return [ validskills, backupskills ];
}

// Namespace ob_skill_tracks
// Params 1, eflags: 0x4
// Checksum 0x4502e5f8, Offset: 0x2bf1
// Size: 0x1b8
function private function_1e9bbdf2ff12b4dd( skilltrack )
{
    skilllevels = [];
    skilllevels[ 0 ] = 0;
    skilllevels[ 1 ] = 0;
    skilllevels[ 2 ] = 0;
    var_f8440dd185c5a9ef = 1;
    var_999e4f6cedae3b46 = getdvarint( @"hash_8515c0834d473502", level.var_858d230de58cc743.var_999e4f6cedae3b46 ?? 4 );
    var_983b23f0da063ba8 = getdvarint( @"hash_ea627e12e276295c", level.var_858d230de58cc743.var_983b23f0da063ba8 ?? 4 );
    
    foreach ( skill in skilltrack.skills )
    {
        if ( isdefined( self.activeskills[ skill.skillref ] ) )
        {
            skilllevels[ self.activeskills[ skill.skillref ] ]++;
        }
        
        if ( !skill.var_a641a158f82c38fe && ( !self.activeskills[ skill.skillref ] || self.activeskills[ skill.skillref ] < 2 ) )
        {
            var_f8440dd185c5a9ef = 0;
        }
    }
    
    if ( var_f8440dd185c5a9ef )
    {
        return 3;
    }
    
    if ( skilllevels[ 1 ] + skilllevels[ 2 ] >= var_983b23f0da063ba8 )
    {
        return 2;
    }
    
    if ( skilllevels[ 0 ] + skilllevels[ 1 ] + skilllevels[ 2 ] >= var_999e4f6cedae3b46 )
    {
        return 1;
    }
    
    return 0;
}

// Namespace ob_skill_tracks
// Params 2, eflags: 0x4
// Checksum 0x8bf73f4a, Offset: 0x2db1
// Size: 0x158
function private function_c01f39e8bab4ca61( validskills, backupskills )
{
    if ( !isarray( validskills ) )
    {
        assert( 0 );
        return [];
    }
    
    skill_1 = level.skillbundles[ validskills[ 0 ].skill.skillref ][ validskills[ 0 ].skilllevel ];
    skill_2 = level.skillbundles[ validskills[ 1 ].skill.skillref ][ validskills[ 1 ].skilllevel ];
    
    if ( !skill_1 || !skill_2 )
    {
        orderedskills = function_1f81ff37f6c05b9d( backupskills );
        backupindex = 0;
        
        if ( !skill_1 && orderedskills )
        {
            skill_1 = level.skillbundles[ orderedskills[ backupindex ].skill.skillref ][ orderedskills[ backupindex ].skilllevel ];
            backupindex++;
        }
        
        if ( !skill_2 && orderedskills )
        {
            skill_2 = level.skillbundles[ orderedskills[ backupindex ].skill.skillref ][ orderedskills[ backupindex ].skilllevel ];
        }
    }
    
    return [ skill_1, skill_2 ];
}

// Namespace ob_skill_tracks
// Params 1, eflags: 0x4
// Checksum 0x3fd3e7ee, Offset: 0x2f12
// Size: 0x1ef
function private function_1f81ff37f6c05b9d( backupskills )
{
    skills = [];
    
    for ( skilllevel = 0; skilllevel < 3 ; skilllevel++ )
    {
        skills[ skilllevel ] = [];
        
        for ( cooldown = 0; cooldown < 5 ; cooldown++ )
        {
            skills[ skilllevel ][ cooldown ] = [];
        }
    }
    
    foreach ( skill in backupskills )
    {
        skillcooldown = self.var_1a158b8a4f9dd2a6[ skill.skillref ] ?? 0;
        skilllevel = skill.skilllevel;
        skills[ skilllevel ][ skillcooldown ][ skills[ skilllevel ][ skillcooldown ].size ] = skill;
    }
    
    skill_1 = undefined;
    skill_2 = undefined;
    
    for ( skilllevel = 0; skilllevel < 3 ; skilllevel++ )
    {
        var_ca6d055ebf037681 = skills[ skilllevel ];
        
        for ( cooldown = 0; cooldown < 5 ; cooldown++ )
        {
            var_5ea1a345177a8a04 = var_ca6d055ebf037681[ cooldown ];
            
            foreach ( skill in var_5ea1a345177a8a04 )
            {
                if ( skill )
                {
                    if ( !skill_1 )
                    {
                        skill_1 = skill;
                    }
                    else
                    {
                        skill_2 = skill;
                    }
                    
                    if ( skill_1 && skill_2 )
                    {
                        return [ skill_1, skill_2 ];
                    }
                }
            }
        }
    }
    
    return [ skill_1, skill_2 ];
}

// Namespace ob_skill_tracks
// Params 1, eflags: 0x4
// Checksum 0x9691d2eb, Offset: 0x310a
// Size: 0xa4
function private function_8b36c29974ecb1e5( skilltrack )
{
    foreach ( skill in skilltrack.skills )
    {
        if ( skill.var_361cdcaa190a34e3 )
        {
            return level.skillbundles[ skill.skillref ][ 0 ];
        }
    }
}

// Namespace ob_skill_tracks
// Params 1, eflags: 0x4
// Checksum 0x965878af, Offset: 0x31b6
// Size: 0xd6, Type: bool
function private function_1a9aeccf421f3b55( skilltrack )
{
    if ( !self.activeskills )
    {
        return false;
    }
    
    foreach ( skill in skilltrack.skills )
    {
        if ( !skill.var_a641a158f82c38fe && ( !self.activeskills[ skill.skillref ] || self.activeskills[ skill.skillref ] < 2 ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace ob_skill_tracks
// Params 2, eflags: 0x4
// Checksum 0xa3b7509f, Offset: 0x3295
// Size: 0x20b
function private function_2389826c2ba9a43c( track, specialskills )
{
    var_f36a6a2717cd987c = "";
    var_f36a6d2717cd9f15 = "";
    var_a5c28ab68469597b = 10;
    var_a5c28bb684695bae = 10;
    var_7040e1db02238e4c = 1;
    starterskills = [];
    trackskills = arrayrandomize( track.skills );
    
    foreach ( skill in trackskills )
    {
        upgraderef = skill.skillref;
        upgradelevel = function_e7aabc89ab530194( upgraderef );
        
        if ( upgradelevel > 0 )
        {
            var_7040e1db02238e4c = 0;
        }
        
        if ( upgradelevel > var_a5c28ab68469597b && upgradelevel > var_a5c28bb684695bae )
        {
            continue;
        }
        
        if ( !function_55f0b722ffefbf76( upgraderef, upgradelevel ) )
        {
            continue;
        }
        
        if ( specialskills != istrue( skill.var_a641a158f82c38fe ) )
        {
            continue;
        }
        
        if ( skill.var_361cdcaa190a34e3 )
        {
            if ( level.skillbundles[ upgraderef ] )
            {
                starterskills[ starterskills.size ] = level.skillbundles[ upgraderef ][ upgradelevel ];
            }
        }
        
        if ( var_a5c28ab68469597b >= var_a5c28bb684695bae )
        {
            var_f36a6a2717cd987c = upgraderef;
            var_a5c28ab68469597b = upgradelevel;
            continue;
        }
        
        var_f36a6d2717cd9f15 = upgraderef;
        var_a5c28bb684695bae = upgradelevel;
    }
    
    if ( var_7040e1db02238e4c )
    {
        self.selectableskills = starterskills;
    }
    
    if ( level.skillbundles[ var_f36a6a2717cd987c ] )
    {
        skill_1 = level.skillbundles[ var_f36a6a2717cd987c ][ var_a5c28ab68469597b ];
    }
    
    if ( level.skillbundles[ var_f36a6d2717cd9f15 ] )
    {
        skill_2 = level.skillbundles[ var_f36a6d2717cd9f15 ][ var_a5c28bb684695bae ];
    }
    
    self.selectableskills = [ skill_1, skill_2 ];
}

// Namespace ob_skill_tracks
// Params 1, eflags: 0x4
// Checksum 0xdd8138e7, Offset: 0x34a8
// Size: 0x49
function private function_e7aabc89ab530194( skillref )
{
    upgradelevel = 0;
    
    if ( self.activeskills && isdefined( self.activeskills[ skillref ] ) )
    {
        upgradelevel = self.activeskills[ skillref ] + 1;
    }
    
    return upgradelevel;
}

// Namespace ob_skill_tracks
// Params 0, eflags: 0x4
// Checksum 0x922e6d84, Offset: 0x34fa
// Size: 0x83
function private function_24fb774f373e4713()
{
    self endon( #"death_or_disconnect" );
    var_631574f297e4a5e5 = 0;
    
    while ( self.var_33d186df2677b56f[ var_631574f297e4a5e5 ] )
    {
        nextsplash = self.var_33d186df2677b56f[ var_631574f297e4a5e5 ];
        function_1323d25aa379ead1( nextsplash.splashtype, nextsplash.splashindex, nextsplash.skilllevel );
        var_631574f297e4a5e5++;
        waitframe();
    }
    
    self.var_33d186df2677b56f = undefined;
    self.var_94f813c2f06c5b75 = undefined;
}

// Namespace ob_skill_tracks
// Params 3, eflags: 0x4
// Checksum 0x3534ff43, Offset: 0x3585
// Size: 0xcf
function private function_49ef4fbfc5ead2c( splashtype, splashindex, skilllevel )
{
    newsplash = spawnstruct();
    newsplash.splashtype = splashtype ?? 0;
    newsplash.splashindex = splashindex ?? 0;
    newsplash.skilllevel = skilllevel ?? 0;
    
    if ( !self.var_33d186df2677b56f )
    {
        self.var_33d186df2677b56f = [];
        self.var_94f813c2f06c5b75 = 0;
        self.var_33d186df2677b56f[ self.var_94f813c2f06c5b75 ] = newsplash;
        self.var_94f813c2f06c5b75++;
        thread function_24fb774f373e4713();
        return;
    }
    
    self.var_33d186df2677b56f[ self.var_94f813c2f06c5b75 ] = newsplash;
    self.var_94f813c2f06c5b75++;
}

// Namespace ob_skill_tracks
// Params 3, eflags: 0x4
// Checksum 0x5e4612fa, Offset: 0x365c
// Size: 0x79
function private function_1323d25aa379ead1( splashtype, splashindex, skilllevel )
{
    self endon( #"death_or_disconnect" );
    self setclientomnvar( "ui_ob_upgrade_splash_type", splashtype );
    self setclientomnvar( "ui_ob_upgrade_splash_asset_index", splashindex );
    self setclientomnvar( "ui_ob_damage_skill_level", skilllevel );
    namespace_7d05876ef5beb3c6::open_ob_upgrade_splash();
    self waittill( #"upgradesplashhide" );
    namespace_7d05876ef5beb3c6::close_ob_upgrade_splash();
    
    while ( namespace_7d05876ef5beb3c6::ob_upgrade_splash_is_active() )
    {
        waitframe();
    }
}

// Namespace ob_skill_tracks
// Params 1, eflags: 0x4
// Checksum 0x2c152116, Offset: 0x36dd
// Size: 0x335
function private function_23888ba187a6e4be( params )
{
    assert( isplayer( self ) );
    params = strtok( params, "#" );
    startingpoint = int( params[ 0 ] ?? 0 );
    exotics = int( params[ 1 ] ?? 0 );
    prestige = params[ 2 ];
    
    if ( startingpoint <= 0 )
    {
        return;
    }
    
    levelboost = level.var_bb86f77304f193c4.var_402e89fa59ab5eb8[ startingpoint - 1 ];
    
    if ( !isdefined( levelboost ) )
    {
        assertmsg( "<dev string:xb8>" + startingpoint + "<dev string:xce>" );
        return;
    }
    
    function_c46c6e25a71dd61a();
    self endon( #"skills_reset" );
    var_4ac747f8c7814e07 = levelboost.var_7506069a9d6f2ce ?? 0;
    
    if ( isdefined( prestige ) )
    {
        prestige = int( prestige );
        self.operatorprestige = prestige;
        utility::callsharedfunc( #"ob", #"hash_cc4e2bcf7e45b223" );
        
        if ( prestige > 2 && startingpoint >= 13 )
        {
            var_4ac747f8c7814e07 = 77;
        }
    }
    
    for ( i = 0; i < var_4ac747f8c7814e07 ; i++ )
    {
        ob_power_tier::function_72c580641320b75a( { #points:self.powertiernexttierxp } );
    }
    
    if ( exotics )
    {
        waitframe();
        currentweapon = self function_ca1904a5dd87fd53() ?? self getcurrentweapon();
        
        if ( currentweapon.isalternate )
        {
            currentweapon = currentweapon getnoaltweapon();
        }
        
        utility::callsharedfunc( #"zombie", #"hash_e546039029657cd5", currentweapon, 5 );
        common_item::function_61c2c0251e742ffd( %"hash_6746660b468e32bb", undefined, common_item::items_initspawnoptions_spawnfromentity( self ) );
        var_772b6fa1fa6b086b = function_c11af7a197679429( %"hash_30c2993c80e9147c", prestige > 0 ? 2 : 1 );
        var_66c0b4ed1f8ac764 = function_c11af7a197679429( %"hash_49cf80fc158cd603", prestige > 1 ? 2 : 1 );
        itemnames = arraycombine( var_772b6fa1fa6b086b, var_66c0b4ed1f8ac764 );
        
        foreach ( itemname in itemnames )
        {
            itemref = getscriptbundlefieldvalue( itemname, #"ref" );
            skillbundle = getscriptbundlefieldvalues( hashcat( %"hash_80f4bb558dad723", itemref ), [ #"skillref", #"hash_cec10972b7814dd0" ] );
            
            if ( skillbundle.skillref )
            {
                utility::callsharedfunc( #"skills", #"giveskill", skillbundle.skillref, skillbundle.var_f463fd4a9608ce51, 1 );
            }
        }
        
        return;
    }
    
    if ( levelboost.jailbreak )
    {
        common_item::function_61c2c0251e742ffd( levelboost.jailbreak, undefined, common_item::items_initspawnoptions_spawnfromentity( self ) );
    }
}

// Namespace ob_skill_tracks
// Params 2
// Checksum 0x8298b1aa, Offset: 0x3a1a
// Size: 0xa50
function function_b8fe304aea4f82b1( params, range )
{
    self notify( #"hash_fc30abf17ecde422" );
    self endon( #"hash_fc30abf17ecde422" );
    assert( isplayer( self ) );
    params = strtok( params, "#" );
    startingpoint = int( params[ 0 ] ?? 0 );
    exotics = int( params[ 1 ] ?? 0 );
    prestige = params[ 2 ];
    obsettings = level.var_bb86f77304f193c4;
    fixedloadout = 0;
    
    if ( startingpoint <= 0 )
    {
        return;
    }
    
    switch ( range )
    {
        case 0:
            fixedloadout = obsettings.var_3764937357361866[ startingpoint - 1 ];
            assert( fixedloadout, "<dev string:xe7>" );
            break;
        case 1:
            fixedloadout = obsettings.var_8aee522e9d0a8d73[ startingpoint - 1 ];
            assert( fixedloadout, "<dev string:x11a>" );
            break;
        case 2:
            fixedloadout = obsettings.var_c358acd4b1426868[ startingpoint - 1 ];
            assert( fixedloadout, "<dev string:x14b>" );
            break;
        case 3:
            fixedloadout = obsettings.heavyloadouts[ startingpoint - 1 ];
            assert( fixedloadout, "<dev string:x17d>" );
            break;
    }
    
    if ( isdefined( fixedloadout ) )
    {
        function_c46c6e25a71dd61a();
        weapon = fixedloadout.weapon;
        
        if ( weapon )
        {
            spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
            item = common_item::function_61c2c0251e742ffd( weapon, undefined, spawnoptions );
            common_item::function_2b5e2ff57d5f392( item, 0, 0 );
        }
        
        damageupgrade = fixedloadout.var_51a31e11c3f6b95a;
        
        if ( damageupgrade )
        {
            var_25eeb74d40ac850 = getscriptbundle( damageupgrade );
            utility::callsharedfunc( #"skills", #"giveskill", var_25eeb74d40ac850.skillref, var_25eeb74d40ac850.skilllevel );
        }
        
        equipmentupgrade = fixedloadout.var_7f056493a27459cb;
        
        if ( equipmentupgrade )
        {
            var_f2bea4b59e0a9d63 = getscriptbundle( equipmentupgrade );
            utility::callsharedfunc( #"skills", #"giveskill", var_f2bea4b59e0a9d63.skillref, var_f2bea4b59e0a9d63.skilllevel );
        }
        
        var_ed2582865088ff10 = fixedloadout.var_223e3017a8acb28d;
        
        if ( var_ed2582865088ff10 )
        {
            var_3cae7e4d4201cbc9 = getscriptbundle( var_ed2582865088ff10 );
            utility::callsharedfunc( #"skills", #"giveskill", var_3cae7e4d4201cbc9.skillref, var_3cae7e4d4201cbc9.skilllevel );
        }
        
        armorupgrade = fixedloadout.var_3a7fb967d38eca8;
        
        if ( armorupgrade )
        {
            var_17ea5aa551181ce2 = getscriptbundle( armorupgrade );
            utility::callsharedfunc( #"skills", #"giveskill", var_17ea5aa551181ce2.skillref, var_17ea5aa551181ce2.skilllevel );
        }
        
        speedupgrade = fixedloadout.var_4e511b604e8b02c8;
        
        if ( speedupgrade )
        {
            var_dee0f6fe0c450382 = getscriptbundle( speedupgrade );
            utility::callsharedfunc( #"skills", #"giveskill", var_dee0f6fe0c450382.skillref, var_dee0f6fe0c450382.skilllevel );
        }
        
        skilltracks = [];
        
        if ( fixedloadout.var_24ec338da1d3b415 )
        {
            var_4e5072af1d0bef55 = getscriptbundle( fixedloadout.var_24ec338da1d3b415 );
            var_4e5072af1d0bef55.ref = fixedloadout.var_24ec338da1d3b415;
            var_4e5072af1d0bef55.isspecial = istrue( var_4e5072af1d0bef55.isspecial );
            var_4e5072af1d0bef55.var_d37e61d21c0a2c77 = istrue( var_4e5072af1d0bef55.var_d37e61d21c0a2c77 );
            skilltracks[ skilltracks.size ] = var_4e5072af1d0bef55;
        }
        
        if ( fixedloadout.var_24ec308da1d3ad7c )
        {
            var_4e506faf1d0be8bc = getscriptbundle( fixedloadout.var_24ec308da1d3ad7c );
            var_4e506faf1d0be8bc.ref = fixedloadout.var_24ec308da1d3ad7c;
            var_4e506faf1d0be8bc.isspecial = istrue( var_4e506faf1d0be8bc.isspecial );
            var_4e506faf1d0be8bc.var_d37e61d21c0a2c77 = istrue( var_4e506faf1d0be8bc.var_d37e61d21c0a2c77 );
            skilltracks[ skilltracks.size ] = var_4e506faf1d0be8bc;
        }
        
        if ( fixedloadout.var_24ec318da1d3afaf )
        {
            var_4e5070af1d0beaef = getscriptbundle( fixedloadout.var_24ec318da1d3afaf );
            var_4e5070af1d0beaef.ref = fixedloadout.var_24ec318da1d3afaf;
            var_4e5070af1d0beaef.isspecial = istrue( var_4e5070af1d0beaef.isspecial );
            var_4e5070af1d0beaef.var_d37e61d21c0a2c77 = istrue( var_4e5070af1d0beaef.var_d37e61d21c0a2c77 );
            skilltracks[ skilltracks.size ] = var_4e5070af1d0beaef;
        }
        
        numskills = fixedloadout.var_484115a92739f1bf ?? 0;
        
        if ( isdefined( prestige ) )
        {
            prestige = int( prestige );
            self.operatorprestige = prestige;
            utility::callsharedfunc( #"ob", #"hash_cc4e2bcf7e45b223" );
            
            if ( prestige > 2 && startingpoint >= 13 )
            {
                numskills += 16;
                
                foreach ( skilltrack in level.skilltracklist )
                {
                    if ( !skilltrack.isspecial && !function_389a4f515c2668d4( skilltracks, #ref, skilltrack.ref ) )
                    {
                        skilltracks[ skilltracks.size ] = skilltrack;
                        break;
                    }
                }
            }
        }
        
        foreach ( skilltrack in skilltracks )
        {
            var_7e39406e9f90be93 = function_8b36c29974ecb1e5( skilltrack );
            utility::callsharedfunc( #"skills", #"giveskill", var_7e39406e9f90be93.skillref, var_7e39406e9f90be93.skilllevel );
            self.skilltracks[ skilltrack.lootid ] = skilltrack;
            self.tracksshown[ skilltrack.lootid ] = 1;
            self.pers[ "mostRecentSkillTrackLootID" ] = skilltrack.lootid;
            numskills--;
        }
        
        var_ce85a46d49696e2b = getdvarint( @"hash_fa536bc1c4c0d1ac", 0 );
        
        for ( i = 0; i < numskills ; i++ )
        {
            validskills = function_bdf3d0dbb887649b()[ 0 ];
            validskills = arrayrandomize( validskills );
            skillbundle = validskills[ 0 ];
            
            if ( var_ce85a46d49696e2b )
            {
                utility::callsharedfunc( #"skills", #"removeskill", skillbundle.skill.skillref );
            }
            
            utility::callsharedfunc( #"skills", #"giveskill", skillbundle.skill.skillref, skillbundle.skilllevel );
        }
        
        var_2d4bf2d42af5448d = utility::callsharedfunc( #"ob_skill_tracks", #"hash_20f154cc7ce486fe" );
        ob_power_tier::function_69df1bfb965b995d( var_2d4bf2d42af5448d, 0 );
        ob_power_tier::function_75cc84297f5ba7ab();
        self.selectableskills = undefined;
        self.selectabletracks = undefined;
        var_acecf1de8ec2250a = self.operatorprestige < 3 ? 61 : 77;
        
        if ( self.powertier < var_acecf1de8ec2250a )
        {
            function_d7674fd8579fbcb8( self.powertier );
            upgradetype = 1;
            
            if ( self.var_4971bba44f275df )
            {
                switch ( self.var_4971bba44f275df )
                {
                    case #"hash_3c6a2be723070e29":
                        upgradetype = 3;
                        break;
                    case #"hash_f89a366fb7e1d999":
                        upgradetype = 0;
                        break;
                }
            }
            
            self setclientomnvar( "ui_ob_skill_upgrade_type", upgradetype );
        }
        
        if ( exotics )
        {
            currentweapon = item.weaponobj ?? self function_ca1904a5dd87fd53() ?? self getcurrentweapon();
            
            if ( currentweapon.isalternate )
            {
                currentweapon = currentweapon getnoaltweapon();
            }
            
            utility::callsharedfunc( #"zombie", #"hash_e546039029657cd5", currentweapon, 5 );
            common_item::function_61c2c0251e742ffd( %"hash_6746660b468e32bb", undefined, common_item::items_initspawnoptions_spawnfromentity( self ) );
            var_772b6fa1fa6b086b = function_c11af7a197679429( %"hash_30c2993c80e9147c", prestige > 0 ? 2 : 1 );
            var_66c0b4ed1f8ac764 = function_c11af7a197679429( %"hash_49cf80fc158cd603", prestige > 1 ? 2 : 1 );
            itemnames = arraycombine( var_772b6fa1fa6b086b, var_66c0b4ed1f8ac764 );
            
            foreach ( itemname in itemnames )
            {
                itemref = getscriptbundlefieldvalue( itemname, #"ref" );
                skillbundle = getscriptbundlefieldvalues( hashcat( %"hash_80f4bb558dad723", itemref ), [ #"skillref", #"hash_cec10972b7814dd0" ] );
                
                if ( skillbundle.skillref )
                {
                    utility::callsharedfunc( #"skills", #"giveskill", skillbundle.skillref, skillbundle.var_f463fd4a9608ce51, 1 );
                }
            }
        }
    }
}

// Namespace ob_skill_tracks
// Params 0, eflags: 0x4
// Checksum 0x4bf3c99e, Offset: 0x4472
// Size: 0x303
function private function_c46c6e25a71dd61a()
{
    self notify( #"skills_reset" );
    
    if ( ob_skill_select::ob_skill_select_is_active() )
    {
        ob_skill_select::close_ob_skill_select();
    }
    
    if ( self.activeskills )
    {
        skillrefs = getarraykeys( self.activeskills );
        
        foreach ( skillref in skillrefs )
        {
            utility::callsharedfunc( #"skills", #"removeskill", skillref );
        }
    }
    
    if ( self.var_bcde97a1f15e0648 )
    {
        skillrefs = getarraykeys( self.var_bcde97a1f15e0648 );
        
        foreach ( skillref in skillrefs )
        {
            utility::callsharedfunc( #"skills", #"removeskill", skillref );
        }
    }
    
    self.powertier_xp = 0;
    self.powertiernexttierxp = 0;
    ob_power_tier::function_69df1bfb965b995d( 1 );
    self.var_3ec847b9b5bb1abb = 0;
    self.var_fe6f091fe36c6136 = 0;
    self.skilltracks = [];
    self.tracksshown = [];
    self.var_7abd0979037af008 = [];
    self.var_1f7050a4c29b6a13 = undefined;
    self.pers[ "mostRecentSkillTrackLootID" ] = undefined;
    self.pers[ "powerTier_pendingReward" ] = undefined;
    self.selectableskills = [];
    function_d7674fd8579fbcb8( self.powertier );
    self setclientomnvar( "ui_ob_skill_upgrade_type", 1 );
    
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
        }
    }
    
    if ( common_instance_inventory::isenabled() && level.var_bb86f77304f193c4.var_386f370256579af8 )
    {
        foreach ( var_f56623bd3361d482 in level.var_8f270e6f9451724d )
        {
            common_instance_inventory::function_295a263162af11ac( var_f56623bd3361d482 );
        }
        
        common_instance_inventory::function_295a263162af11ac( #"hash_952f20a0293debc7" );
        common_instance_inventory::function_295a263162af11ac( #"hash_fc1160f8e3c9f8ef" );
    }
}

/#

    // Namespace ob_skill_tracks
    // Params 0, eflags: 0x4
    // Checksum 0x41805a83, Offset: 0x477d
    // Size: 0x15, Type: dev
    function private function_32b77c2b9dea06a8()
    {
        function_6af4ae67e2db2ea6( level.players );
    }

    // Namespace ob_skill_tracks
    // Params 0, eflags: 0x4
    // Checksum 0xe88d1cde, Offset: 0x479a
    // Size: 0x191, Type: dev
    function private initdev()
    {
        var_2007867e0cbe557a = game_utility::getgametype() != "<dev string:x1aa>";
        
        if ( var_2007867e0cbe557a )
        {
            devgui::function_9082edeb5db93280( "<dev string:x1ad>" );
            devgui::add_devgui_command( "<dev string:x1b8>", "<dev string:x1c3>", -1 );
            devgui::add_devgui_func( "<dev string:x1e3>", "<dev string:x1ef>", &function_32b77c2b9dea06a8 );
            
            foreach ( skillref, var_eb5c88c4a11f25e8 in level.skillbundles )
            {
                skillname = getxhashsourcename( skillref );
                
                foreach ( tier, skill in var_eb5c88c4a11f25e8 )
                {
                    devgui::add_devgui_command( "<dev string:x207>" + skillname + "<dev string:x20f>" + tier, "<dev string:x216>" + skillname + "<dev string:x232>" + tier );
                }
                
                devgui::add_devgui_command( "<dev string:x207>" + skillname + "<dev string:x252>", "<dev string:x25a>" + skillname + "<dev string:x278>", -1 );
            }
            
            devgui::function_77df7fe7dd273e10();
        }
    }

#/

// Namespace ob_skill_tracks
// Params 0, eflags: 0x4
// Checksum 0xa6a4018d, Offset: 0x4933
// Size: 0x1a1
function private function_60251d3506f7495()
{
    while ( true )
    {
        waitframe();
        
        if ( !isdefined( level.players ) )
        {
            continue;
        }
        
        cheatplayers = level.players;
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
        
        if ( cheat_dvars[ #"give_skill_ref" ] )
        {
            thread function_cfaedd2455abc1a4( cheatplayers, cheat_dvars[ #"give_skill_ref" ], cheat_dvars[ #"give_skill_level" ] );
        }
        
        if ( cheat_dvars[ #"bot_give_skill_ref" ] )
        {
            thread function_5a1b92e3376e1474( cheatplayers, cheat_dvars[ "bot_give_skill_ref" ], cheat_dvars[ "bot_give_skill_level" ] );
        }
        
        if ( cheat_dvars[ #"hash_da710ec657b72064" ] )
        {
            thread function_3545c4fa07d9cd97( cheatplayers, cheat_dvars[ #"hash_da710ec657b72064" ], cheat_dvars[ #"hash_7d092ae22f70fefb" ] );
        }
        
        if ( cheat_dvars[ #"remove_skill_ref" ] )
        {
            thread function_22135cc918df2af5( cheatplayers, cheat_dvars[ #"remove_skill_ref" ] );
        }
        
        if ( cheat_dvars[ #"remove_all_skills" ] )
        {
            thread function_60478782bf766bd5( cheatplayers );
        }
    }
}

// Namespace ob_skill_tracks
// Params 0, eflags: 0x4
// Checksum 0xad623346, Offset: 0x4adc
// Size: 0x101
function private function_d736a179632efa58()
{
    return [ #"remove_all_skills":utility::consume_dvar_int( @"hash_30a3678cc73f1aa1", 0 ), #"remove_skill_ref":utility::consume_dvar( @"hash_1bac5623d57e81ca", "" ), #"hash_7d092ae22f70fefb":utility::consume_dvar_int( @"hash_535db081daa5b42c", -1 ), #"hash_da710ec657b72064":utility::consume_dvar( @"hash_ab9bdc6dc145907f", "" ), #"hash_61eb7867d1ed9bc6":utility::consume_dvar_int( @"hash_92c78b461a5a751c", -1 ), #"bot_give_skill_level":utility::consume_dvar_int( @"bot_give_skill_level", -1 ), #"give_skill_level":utility::consume_dvar_int( @"cheat_give_skill_level", -1 ), #"bot_give_skill_ref":utility::consume_dvar( @"cheat_bot_give_skill_ref", "" ), #"give_skill_ref":utility::consume_dvar( @"cheat_give_skill_ref", "" ) ];
}

// Namespace ob_skill_tracks
// Params 3, eflags: 0x4
// Checksum 0xbc56697, Offset: 0x4be6
// Size: 0x10e
function private function_5a1b92e3376e1474( cheatplayers, give_skill_ref, var_639ed4b838038c2e )
{
    give_skill_ref_hash = getxhash( give_skill_ref );
    
    foreach ( cheatplayer in cheatplayers )
    {
        target_bot = cheatplayer squad_utility::function_c0c042f61085310b( 1 );
        
        if ( !isdefined( target_bot ) )
        {
            continue;
        }
        
        var_ce85a46d49696e2b = getdvarint( @"hash_fa536bc1c4c0d1ac", 0 );
        
        if ( var_ce85a46d49696e2b )
        {
            target_bot utility::callsharedfunc( #"skills", #"removeskill", give_skill_ref_hash );
        }
        
        target_bot utility::callsharedfunc( #"skills", #"giveskill", give_skill_ref_hash, var_639ed4b838038c2e );
        waitframe();
    }
}

// Namespace ob_skill_tracks
// Params 3, eflags: 0x4
// Checksum 0xdf482a3, Offset: 0x4cfc
// Size: 0x17a
function private function_cfaedd2455abc1a4( cheatplayers, give_skill_ref, var_639ed4b838038c2e )
{
    give_skill_ref_xhash = getxhash( give_skill_ref );
    var_ce85a46d49696e2b = getdvarint( @"hash_fa536bc1c4c0d1ac", 0 );
    
    if ( var_ce85a46d49696e2b )
    {
        foreach ( cheatplayer in cheatplayers )
        {
            cheatplayer utility::callsharedfunc( #"skills", #"removeskill", give_skill_ref_xhash );
        }
        
        waitframe();
    }
    
    foreach ( cheatplayer in cheatplayers )
    {
        cheatplayer utility::callsharedfunc( #"skills", #"giveskill", give_skill_ref_xhash, var_639ed4b838038c2e );
        cheatplayer iprintlnbold( "Granted skill: " + give_skill_ref + ", Tier " + var_639ed4b838038c2e + " (player facing: Tier " + var_639ed4b838038c2e + 1 + ")" );
        waitframe();
    }
}

// Namespace ob_skill_tracks
// Params 3, eflags: 0x4
// Checksum 0x76f1a6a, Offset: 0x4e7e
// Size: 0x17a
function private function_3545c4fa07d9cd97( cheatplayers, var_4cbe115296f90f3, ability_upgrade_level )
{
    var_868f8bff659ca714 = getxhash( var_4cbe115296f90f3 );
    var_ce85a46d49696e2b = getdvarint( @"hash_fa536bc1c4c0d1ac", 0 );
    
    if ( var_ce85a46d49696e2b )
    {
        foreach ( cheatplayer in cheatplayers )
        {
            cheatplayer utility::callsharedfunc( #"skills", #"removeskill", var_868f8bff659ca714 );
        }
        
        waitframe();
    }
    
    foreach ( cheatplayer in cheatplayers )
    {
        cheatplayer utility::callsharedfunc( #"skills", #"giveskill", var_868f8bff659ca714, ability_upgrade_level );
        cheatplayer iprintlnbold( "Granted skill: " + var_4cbe115296f90f3 + ", Tier " + ability_upgrade_level + " (player facing: Tier " + ability_upgrade_level + 1 + ")" );
        waitframe();
    }
}

// Namespace ob_skill_tracks
// Params 2, eflags: 0x4
// Checksum 0xd1904b9a, Offset: 0x5000
// Size: 0xbb
function private function_22135cc918df2af5( cheatplayers, remove_skill_ref )
{
    var_4fb7081d1f621291 = getxhash( remove_skill_ref );
    
    foreach ( cheatplayer in cheatplayers )
    {
        cheatplayer utility::callsharedfunc( #"skills", #"removeskill", var_4fb7081d1f621291 );
        cheatplayer iprintlnbold( "Removed skill: " + remove_skill_ref );
        waitframe();
    }
}

// Namespace ob_skill_tracks
// Params 1, eflags: 0x4
// Checksum 0xe079a5ac, Offset: 0x50c3
// Size: 0x9d
function private function_60478782bf766bd5( cheatplayers )
{
    foreach ( cheatplayer in cheatplayers )
    {
        cheatplayer utility::callsharedfunc( #"skills", #"hash_caf936d46b7e8c96" );
        cheatplayer iprintlnbold( "Removed all skills" );
        waitframe();
    }
}

