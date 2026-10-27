// scripts\mp\ob\systems\ob_skills.gsc  (hash_5b73d916c7a0e419.gscc) (size: 50956 Bytes / 0xc70c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xee28d10b (3995652363)
// size ...... 50956 (0xc70c)
// includes .. 21  (offset: 0xbe58)
// strings ... 81  (offset: 0xbf00)
// dev strs .. 61  (offset: 0xc414)
// exports ... 101 (offset: 0x8c1c)
// cseg ...... 0x702 + 0x851a (0x8c1c)
// imports ... 259 (offset: 0x9be4)
// animtree1 . 0   (offset: 0xc70c)
// animtree2 . 0   (offset: 0xc70c)
#using scripts\common\ai\ai_utility;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\ammomods\ammo_mod;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\equipment;
#using scripts\mp\loot\common_instance_inventory;
#using scripts\mp\loot\common_item;
#using scripts\mp\ob\ob_skill_select;
#using scripts\mp\ob\ob_upgrade_splash;
#using scripts\mp\ob\systems\ob_power_tier;
#using scripts\mp\supers;

#namespace ob_skills;

// Namespace ob_skills
// Params 0, eflags: 0x1
// Checksum 0x13f9540d, Offset: 0x720
// Size: 0x781
function autoexec main()
{
    if ( getdvarint( @"hash_a9e966a0d3e4c6bb", 0 ) )
    {
        return;
    }
    
    if ( !( level.gametypebundle.skills.enableskills ?? level.gamemodebundle.enableskills ) || isbrgamemode() )
    {
        return;
    }
    
    level.var_26a6406c08b4fd65 = [];
    level.skillbundles = [];
    level.var_7b319720bc04b783 = [];
    var_53186a089b55f4a4 = level.gametypebundle.skills.skill_list ?? level.gamemodebundle.skill_list;
    var_ff3e7ab471202f85 = level.gametypebundle.skills.skilltracklist ?? level.gamemodebundle.skilltracklist;
    var_f86fde98285acb67 = getscriptbundle( var_53186a089b55f4a4 );
    var_974155d5d1b9324a = getscriptbundle( var_ff3e7ab471202f85 );
    
    if ( isdefined( var_f86fde98285acb67 ) )
    {
        assert( isdefined( var_f86fde98285acb67 ), getxhashsourcename( var_53186a089b55f4a4 ) + "<dev string:x24>" );
        assert( isdefined( var_974155d5d1b9324a ), getxhashsourcename( var_ff3e7ab471202f85 ) + "<dev string:x3b>" );
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
            
            foreach ( index, skill in skilltrack.skills )
            {
                if ( skill.disabled )
                {
                    continue;
                }
                
                if ( skill.skillbundle )
                {
                    level function_1c254b725136220f( skill.skillbundle, index );
                }
                
                if ( skill.var_8fb259ab28661ccc )
                {
                    level function_1c254b725136220f( skill.var_8fb259ab28661ccc, index );
                }
                
                if ( skill.var_8fb25cab28662365 )
                {
                    level function_1c254b725136220f( skill.var_8fb25cab28662365, index );
                }
                
                if ( skill.var_8fb25bab28662132 )
                {
                    level function_1c254b725136220f( skill.var_8fb25bab28662132, index );
                }
            }
        }
        
        foreach ( index, skill_struct in var_f86fde98285acb67.skills )
        {
            skill = skill_struct.skill;
            
            if ( !skill )
            {
                continue;
            }
            
            skillbundle = getscriptbundle( skill );
            
            if ( level.skillbundles[ skillbundle.skillref ] && level.skillbundles[ skillbundle.skillref ][ skillbundle.skilllevel ] )
            {
                level.skillbundles[ skillbundle.skillref ][ skillbundle.skilllevel ].index = index;
                continue;
            }
            
            level function_1c254b725136220f( skill, index );
        }
        
        foreach ( index, skill_struct in var_f86fde98285acb67.var_f6815ee7c02481fd )
        {
            skill = skill_struct.skill;
            
            if ( !skill )
            {
                continue;
            }
            
            skillbundle = getscriptbundle( skill );
            
            if ( level.skillbundles[ skillbundle.skillref ] && level.skillbundles[ skillbundle.skillref ][ skillbundle.skilllevel ] )
            {
                level.skillbundles[ skillbundle.skillref ][ skillbundle.skilllevel ].index = index;
                continue;
            }
            
            level function_1c254b725136220f( skill, index );
        }
    }
    
    /#
        level thread function_6e917301c3abad5();
    #/
    
    level.skills_init = &init;
    level.var_5e13510a4bcb35a0 = 0;
    
    if ( !level.gametypebundle.var_858d230de58cc743 )
    {
        return;
    }
    
    level.var_858d230de58cc743 = getscriptbundle( level.gametypebundle.var_858d230de58cc743 );
    
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
    
    /#
        initdev();
    #/
    
    if ( getbuildversion() != "SHIP" )
    {
        level thread function_60251d3506f7495();
    }
}

// Namespace ob_skills
// Params 2, eflags: 0x4
// Checksum 0x8c6c64d4, Offset: 0xea9
// Size: 0x1ce
function private function_1c254b725136220f( skill, skillindex )
{
    skillbundle = getscriptbundle( skill );
    skillbundle = function_859d25c07efd92ca( skillbundle );
    assert( skillbundle, getxhashsourcename( skill ) + "<dev string:x57>" );
    
    if ( !skillbundle )
    {
        return;
    }
    
    skillbundle.index = skillindex;
    skillbundle.asset = skill;
    
    if ( !level.skillbundles[ skillbundle.skillref ] )
    {
        level.skillbundles[ skillbundle.skillref ] = [];
        
        if ( skillbundle.abilityref )
        {
            level.skillbundles[ skillbundle.skillref ][ #"ability_dependency" ] = skillbundle.abilityref;
        }
    }
    
    assert( !level.skillbundles[ skillbundle.skillref ][ skillbundle.skilllevel ], getxhashsourcename( skillbundle.skillref ) + "<dev string:x70>" + skillbundle.skilllevel + "<dev string:x83>" + getxhashsourcename( skill ) + "<dev string:x9c>" );
    level.skillbundles[ skillbundle.skillref ][ skillbundle.skilllevel ] = skillbundle;
    
    if ( skillbundle.abilityref )
    {
        if ( !isdefined( level.var_df3fc2ed023c3c0d ) )
        {
            level.var_df3fc2ed023c3c0d = [];
        }
        
        if ( !isdefined( level.var_df3fc2ed023c3c0d[ skillbundle.abilityref ] ) )
        {
            level.var_df3fc2ed023c3c0d[ skillbundle.abilityref ] = [];
        }
        
        level.var_df3fc2ed023c3c0d[ skillbundle.abilityref ][ skillbundle.skilllevel ] = skillbundle;
    }
    
    return skillbundle;
}

// Namespace ob_skills
// Params 3, eflags: 0x4
// Checksum 0xcf382255, Offset: 0x1080
// Size: 0x71
function private function_f8d85d3174f2e33c( slot, var_1078d7a3549450d5, var_27be419a6e61f096 )
{
    if ( !var_1078d7a3549450d5 || !var_27be419a6e61f096 || var_1078d7a3549450d5 == var_27be419a6e61f096 )
    {
        return;
    }
    
    if ( supers_mp::issuperinuse( slot ) )
    {
        return;
    }
    
    currentpoints = supers_mp::getcurrentsuperpoints( slot );
    newpointtotal = currentpoints / var_1078d7a3549450d5 * var_27be419a6e61f096;
    supers_mp::setsuperbasepoints( newpointtotal, undefined, slot );
}

// Namespace ob_skills
// Params 0, eflags: 0x4
// Checksum 0xc1ce06f3, Offset: 0x10f9
// Size: 0xc1
function private function_4b29bd1a99467937()
{
    foreach ( skillref, skilllevels in level.skillbundles )
    {
        exists = utility::issharedfuncdefined( skillref, #"hash_f89602d29c289ca4" );
        
        if ( exists )
        {
            for ( i = 0; i < skilllevels.size ; i++ )
            {
                utility::callsharedfunc( skillref, #"hash_f89602d29c289ca4", skilllevels[ i ] );
            }
        }
    }
}

// Namespace ob_skills
// Params 0, eflags: 0x4
// Checksum 0x4303a75c, Offset: 0x11c2
// Size: 0x195
function private function_b0164324d65dff5()
{
    all_skills = level.skillbundles;
    
    foreach ( skillref, skilllevels in all_skills )
    {
        foreach ( skillbundle in skilllevels )
        {
            skillsweapons = level utility::callsharedfunc( skillref, #"hash_8698c290a2e85469", skillbundle );
            
            if ( skillsweapons )
            {
                assert( isarray( skillsweapons ), "<dev string:x9e>" );
                
                foreach ( weapon in skillsweapons )
                {
                    level.var_7b319720bc04b783[ getxhashasset( weapon ) ] = skillref;
                }
            }
        }
    }
}

/#

    // Namespace ob_skills
    // Params 0, eflags: 0xc
    // Checksum 0xda8d93f5, Offset: 0x135f
    // Size: 0x65, Type: dev
    function private function_6e917301c3abad5()
    {
        self notify( #"hash_fa902190e0205b97" );
        self endon( #"hash_fa902190e0205b97" );
        
        while ( true )
        {
            level waittill( #"hash_7e967560bc92fa01", var_facf97ba9e42d82d );
            
            if ( var_facf97ba9e42d82d.asset_type == "<dev string:xc6>" )
            {
                level function_3ab5bc39b45bbce7( var_facf97ba9e42d82d.asset_name );
            }
        }
    }

    // Namespace ob_skills
    // Params 1, eflags: 0x4
    // Checksum 0x137ed501, Offset: 0x13cc
    // Size: 0x116, Type: dev
    function private function_3ab5bc39b45bbce7( skill )
    {
        skillbundle = getscriptbundle( skill );
        var_b71462f80cd7fe1 = isdefined( skillbundle.abilityref );
        players = level.players;
        
        foreach ( player in players )
        {
            activeskills = player function_94d827e7a50c6f1d( var_b71462f80cd7fe1 );
            skillref = skillbundle.skillref;
            skilllevel = skillbundle.skilllevel;
            
            if ( activeskills[ skillref ] && activeskills[ skillref ] == skilllevel )
            {
                player function_474a08a0c197134( skillref );
                waitframe();
                player function_3ceb333c50dbd4cb( skillref, skilllevel );
            }
        }
    }

    // Namespace ob_skills
    // Params 0, eflags: 0xc
    // Checksum 0xd31034f6, Offset: 0x14ea
    // Size: 0x351, Type: dev
    function private function_9adca665ae5e6f01()
    {
        self notify( #"hash_f4ac22158933b36a" );
        self endon( #"hash_f4ac22158933b36a" );
        assert( isplayer( self ) );
        self endon( #"disconnect" );
        setdvarifuninitialized( @"scr_debug_skills", 0 );
        
        for ( var_490ecec605775920 = undefined; true ; var_490ecec605775920 = msgtext )
        {
            waitframe();
            visible = getdvarint( @"scr_debug_skills", 0 ) != 0;
            
            if ( !visible )
            {
                if ( isdefined( self.var_c821c4f78b8f4ca5 ) )
                {
                    self.var_c821c4f78b8f4ca5 destroy();
                    self.var_c821c4f78b8f4ca5 = undefined;
                }
                
                var_490ecec605775920 = undefined;
                wait randomfloatrange( 0.75, 1.5 );
                continue;
            }
            
            hudelem = self.var_c821c4f78b8f4ca5;
            
            if ( !isdefined( hudelem ) )
            {
                hudelem = newclienthudelem( self );
                hudelem.alignx = "<dev string:xcc>";
                hudelem.aligny = "<dev string:xd1>";
                hudelem.x = 30;
                hudelem.y = 20;
                hudelem.foreground = 1;
                hudelem.color = ( 1, 1, 1 );
                hudelem.fontscale = 0.75;
                self.var_c821c4f78b8f4ca5 = hudelem;
            }
            
            msgtext = "<dev string:xd5>";
            activeskills = function_94d827e7a50c6f1d( 1 );
            
            if ( activeskills.size )
            {
                msgtext = "<dev string:xe6>";
                
                foreach ( key, var_d31f0d4f00dc5b64 in activeskills )
                {
                    msgtext = msgtext + getxhashsourcename( key ) + "<dev string:xfb>" + var_d31f0d4f00dc5b64 + 1 + "<dev string:xff>";
                }
            }
            
            activeskills = function_94d827e7a50c6f1d( 0 );
            
            if ( activeskills.size )
            {
                msgtext += "<dev string:x101>";
                
                foreach ( key, var_d31f0d4f00dc5b64 in activeskills )
                {
                    msgtext = msgtext + getxhashsourcename( key ) + "<dev string:xfb>" + var_d31f0d4f00dc5b64 + 1 + "<dev string:xff>";
                }
            }
            
            if ( self.skilltracks.size )
            {
                msgtext += "<dev string:x10c>";
                
                foreach ( trackdata in self.skilltracks )
                {
                    msgtext = msgtext + getxhashsourcename( trackdata.name ) + "<dev string:xff>";
                }
            }
            
            if ( ( var_490ecec605775920 ?? "<dev string:x117>" ) != msgtext )
            {
                hudelem setdevtext( msgtext );
            }
        }
    }

#/

// Namespace ob_skills
// Params 0
// Checksum 0x9f1675f2, Offset: 0x1843
// Size: 0x450
function init()
{
    foreach ( skillinit in level.var_86bd886a4ac78dd8 )
    {
        [[ skillinit ]]();
    }
    
    level function_4b29bd1a99467937();
    level function_b0164324d65dff5();
    level callback::add( #"player_death", &ob_skills_on_player_death );
    level callback::add( #"player_spawned", &ob_skills_on_player_spawn );
    utility::registersharedfunc( #"skills", #"hash_1f0a435d01dc412b", &function_c204d8ef571d19c0 );
    utility::registersharedfunc( #"skills", #"hash_7839ce6cac4cb514", &function_84e3ce8b5ae14ff );
    utility::registersharedfunc( #"skills", #"hash_785df5a84d4d0b95", &function_feeccf386ffe759c );
    utility::registersharedfunc( #"skills", #"hash_d1b0a8ba618e0ca8", &function_6b10df256881fc0b );
    utility::registersharedfunc( #"skills", #"hash_6dc9835d47a52b35", &function_b4c5928391767e1 );
    utility::registersharedfunc( #"skills", #"hash_a6980b8a3e3542b2", &function_bb9713b6d637debb );
    utility::registersharedfunc( #"skills", #"getsuperpointsneeded", &function_f75f55f1b8571e53 );
    utility::registersharedfunc( #"skills", #"hash_cff4503d5032d9d2", &function_78528ecebd639d6d );
    utility::registersharedfunc( #"skills", #"hash_2ae7f8231121f66c", &function_af49fe6484e3a149 );
    utility::registersharedfunc( #"skills", #"hash_28be1e74b50af850", &function_f210d2df48e0410a );
    utility::registersharedfunc( #"skills", #"hash_b5a7f9c7f63c374a", &function_3d5866519a25bbb8 );
    utility::registersharedfunc( #"skills", #"hash_2fd3deb81c953c81", &function_e2c4a7c719e75fb3 );
    utility::registersharedfunc( #"skills", #"giveskill", &function_3ceb333c50dbd4cb );
    utility::registersharedfunc( #"skills", #"removeskill", &function_474a08a0c197134 );
    utility::registersharedfunc( #"skills", #"apply_invulnerability", &apply_invulnerability );
    utility::registersharedfunc( #"skills", #"hash_79530ea7319d30d6", &function_be2bcf2bcc0a9b2b );
    utility::registersharedfunc( #"ob_skill_tracks", #"hash_e31febe4a760ad29", &function_490747a9a77e888f );
    utility::registersharedfunc( #"ob_skill_tracks", #"hash_20f154cc7ce486fe", &function_6ae0a787a1d6b10b );
    utility::registersharedfunc( #"ob_skill_tracks", #"hash_92aa850c92f2fac0", &function_4be523713b8258fe );
    utility::registersharedfunc( #"ob_skill_tracks", #"hash_9a28d6cd3de8589e", &function_c78e9f8ae3241430 );
    utility::registersharedfunc( #"ob_skill_tracks", #"hash_645ee2bb8bf341ad", &function_2400e270530f4ac8 );
    utility::registersharedfunc( #"ob_skill_tracks", #"hash_89712717ea90983f", &function_6c4914123ec70d29 );
    utility::registersharedfunc( #"ob_skill_tracks", #"fixedloadout", &function_3e90b486de426409 );
    utility::registersharedfunc( #"ob_skill_tracks", #"levelboost", &function_6729084538d6c006 );
    utility::registersharedfunc( #"ob_skill_tracks", #"reset", &ob_skills_reset );
    ui::lui_registercallback( "ob_skill_select_intro_complete", &function_a463aa654aa04df );
    players = level.players;
    
    foreach ( player in players )
    {
        self setclientomnvar( "ui_ob_selectable_skill_index_1", 0 );
        self setclientomnvar( "ui_ob_selectable_skill_index_2", 0 );
        self setclientomnvar( "ui_ob_selectable_skill_index_3", 0 );
    }
}

// Namespace ob_skills
// Params 2
// Checksum 0xb0a499f4, Offset: 0x1c9b
// Size: 0x8e
function function_b667da63ece9b966( var_ad2af75586eccea4, initfunc )
{
    if ( !isxhash( var_ad2af75586eccea4 ) )
    {
        assertmsg( var_ad2af75586eccea4 + "<dev string:x118>" );
        return;
    }
    
    if ( !isfunction( initfunc ) )
    {
        assertmsg( "<dev string:x131>" );
        return;
    }
    
    if ( !isdefined( level.var_86bd886a4ac78dd8 ) )
    {
        level.var_86bd886a4ac78dd8 = [];
    }
    
    assert( !isdefined( level.var_86bd886a4ac78dd8[ var_ad2af75586eccea4 ] ), getxhashsourcename( var_ad2af75586eccea4 ) + "<dev string:x17d>" );
    level.var_86bd886a4ac78dd8[ var_ad2af75586eccea4 ] = initfunc;
}

// Namespace ob_skills
// Params 1, eflags: 0x4
// Checksum 0xc3cb8f07, Offset: 0x1d31
// Size: 0x132
function private function_859d25c07efd92ca( scriptbundle )
{
    if ( !isstruct( scriptbundle ) )
    {
        assert( "<dev string:x192>" );
        return scriptbundle;
    }
    
    scriptbundle.availablegamemodes = undefined;
    scriptbundle.availableoffline = undefined;
    scriptbundle.availableprojects = undefined;
    scriptbundle.name = undefined;
    scriptbundle.categoryname = undefined;
    scriptbundle.description = undefined;
    scriptbundle.effects = undefined;
    scriptbundle.icon = undefined;
    scriptbundle.var_712245a57fc6440b = undefined;
    scriptbundle.var_8df2625eee877b4a = undefined;
    scriptbundle.iconsmall = undefined;
    scriptbundle.var_198ee826e37b2092 = undefined;
    scriptbundle.unlockableprojects = undefined;
    scriptbundle.unlocktype = undefined;
    
    if ( scriptbundle.var_f9e99c9f1364af1a.size <= 0 )
    {
        scriptbundle.var_f9e99c9f1364af1a = undefined;
    }
    
    if ( scriptbundle.var_203d53e7a282f347.size <= 0 )
    {
        scriptbundle.var_203d53e7a282f347 = undefined;
    }
    
    if ( scriptbundle.var_710ff8c0c61b069f.size <= 0 )
    {
        scriptbundle.var_710ff8c0c61b069f = undefined;
    }
    
    if ( scriptbundle.var_fd2544416a5afbbb.size <= 0 )
    {
        scriptbundle.var_fd2544416a5afbbb = undefined;
    }
    
    return scriptbundle;
}

// Namespace ob_skills
// Params 1
// Checksum 0xb28a074a, Offset: 0x1e6c
// Size: 0xcf
function ob_skills_on_player_death( params )
{
    self.var_1f7050a4c29b6a13 = arraycopy( self.activeskills );
    
    foreach ( skillref, rarity in self.activeskills )
    {
        function_474a08a0c197134( skillref );
    }
    
    if ( ob_skill_select::ob_skill_select_is_active() )
    {
        ob_skill_select::close_ob_skill_select();
        self setclientomnvar( "ui_ob_skill_reward_reason", 0 );
        self setclientomnvar( "ui_ob_selectable_skill_index_1", 0 );
        self setclientomnvar( "ui_ob_selectable_skill_index_2", 0 );
    }
}

// Namespace ob_skills
// Params 1
// Checksum 0x6afd9759, Offset: 0x1f43
// Size: 0x4da
function ob_skills_on_player_spawn( params )
{
    if ( level.var_5e13510a4bcb35a0 && isdefined( self.activeskills ) )
    {
        function_d741797888dacd2b();
    }
    
    /#
        thread function_9adca665ae5e6f01();
    #/
    
    if ( !params.revivespawn )
    {
        self.activeskills = [];
        self.var_bcde97a1f15e0648 = [];
        self.var_3ec847b9b5bb1abb = 0;
        self.var_fe6f091fe36c6136 = 0;
        self.skilltracks = [];
    }
    
    if ( isdefined( self.loadoutSkillTracks ) )
    {
        self.skilltracks = self.loadoutSkillTracks;
    }
    
    squad = teams::function_72b89edf6b47c40a( self );
    var_8c5067d0870248c8 = self.var_8c5067d0870248c8 ?? squad.var_8c5067d0870248c8 ?? undefined;
    
    if ( var_8c5067d0870248c8 )
    {
        function_9d7c461c00f2f588( var_8c5067d0870248c8, 1 );
    }
    
    if ( getdvarint( @"hash_badbc3b85aaeddfb", 1 ) )
    {
        if ( params.revivespawn )
        {
            if ( isdefined( self.var_1f7050a4c29b6a13 ) && self.var_1f7050a4c29b6a13.size > 0 )
            {
                waitframe();
                
                foreach ( skillref, rarity in self.var_1f7050a4c29b6a13 )
                {
                    function_3ceb333c50dbd4cb( skillref, rarity, 1, 1 );
                }
                
                self.var_1f7050a4c29b6a13 = undefined;
            }
        }
        else if ( isdefined( self.loadoutskills ) )
        {
            waitframe();
            var_2fcda0c1f18387fe = 5;
            skillcount = 0;
            
            foreach ( var_68ffb124ecf20c1c in self.loadoutskills )
            {
                skillbundle = getscriptbundlefieldvalues( var_68ffb124ecf20c1c, [ #"skillref", #"skilllevel" ] );
                
                if ( isdefined( skillbundle ) )
                {
                    skillcount++;
                    function_3ceb333c50dbd4cb( skillbundle.skillref, skillbundle.skilllevel, undefined, 1 );
                    
                    if ( skillcount % var_2fcda0c1f18387fe == 0 )
                    {
                        skillcount = 0;
                        waitframe();
                    }
                }
            }
            
            self.loadoutskills = undefined;
        }
    }
    else
    {
        if ( isdefined( self.loadoutskills ) )
        {
            waitframe();
            var_2fcda0c1f18387fe = 5;
            skillcount = 0;
            
            foreach ( var_68ffb124ecf20c1c in self.loadoutskills )
            {
                skillbundle = getscriptbundlefieldvalues( var_68ffb124ecf20c1c, [ #"skillref", #"skilllevel" ] );
                
                if ( isdefined( skillbundle ) )
                {
                    skillcount++;
                    function_3ceb333c50dbd4cb( skillbundle.skillref, skillbundle.skilllevel, undefined, 1 );
                    
                    if ( skillcount % var_2fcda0c1f18387fe == 0 )
                    {
                        skillcount = 0;
                        waitframe();
                    }
                }
            }
        }
        
        if ( params.revivespawn && isdefined( self.var_1f7050a4c29b6a13 ) && self.var_1f7050a4c29b6a13.size > 0 )
        {
            foreach ( skillref, rarity in self.var_1f7050a4c29b6a13 )
            {
                function_3ceb333c50dbd4cb( skillref, rarity, 1, 1 );
            }
            
            self.var_1f7050a4c29b6a13 = undefined;
        }
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
            function_c78e9f8ae3241430( self.powertier );
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

// Namespace ob_skills
// Params 0
// Checksum 0xeb941112, Offset: 0x2425
// Size: 0x1ee
function function_6ae0a787a1d6b10b()
{
    combatrating = 1;
    
    if ( self.activeskills )
    {
        foreach ( skillref, skilllevel in self.activeskills )
        {
            if ( function_84e3ce8b5ae14ff( skillref, skilllevel ) != #"end_game" && function_84e3ce8b5ae14ff( skillref, skilllevel ) != #"nightmare" && function_84e3ce8b5ae14ff( skillref, skilllevel ) != #"ability" )
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

// Namespace ob_skills
// Params 2, eflags: 0x4
// Checksum 0x400ebb7, Offset: 0x261c
// Size: 0x51
function private function_d240cf8d1b255cf0( skillref, skilllevel )
{
    function_62a9298a56dec0e( skillref, skilllevel );
    function_91d889f2043c905d( skillref, skilllevel );
    function_57ff2e5d36dc297f( skillref, skilllevel );
    function_740967ee9e2436ec( skillref, skilllevel );
    function_9558ef01c3fdd497( skillref, skilllevel );
    function_1b4d21b03d7c8b2f( skillref, skilllevel );
}

// Namespace ob_skills
// Params 1, eflags: 0x4
// Checksum 0xd9164b8f, Offset: 0x2675
// Size: 0xf5
function private function_9905db6daa265e8f( skillref )
{
    if ( self.skilldata )
    {
        foreach ( fieldxhash in getarraykeys( self.skilldata ) )
        {
            self.skilldata[ fieldxhash ][ skillref ] = undefined;
            
            if ( self.skilldata[ fieldxhash ].size == 0 )
            {
                self.skilldata[ fieldxhash ] = undefined;
            }
        }
        
        function_deb4305a56c1b162( skillref );
    }
    
    if ( self.skilldata.size == 0 )
    {
        self.skilldata = undefined;
    }
    
    utility::delaythreadendon( level.framedurationseconds, "disconnect", &function_87ee9845cb9fe41d, 0 );
}

// Namespace ob_skills
// Params 3, eflags: 0x4
// Checksum 0xf41b91cb, Offset: 0x2772
// Size: 0x9d
function private function_b462f90ad3426fa9( fieldxhash, skillref, value )
{
    assert( fieldxhash, "<dev string:x1b8>" );
    assert( skillref, "<dev string:x1d4>" );
    prevvalue = function_44d6ac51e2d0d975( fieldxhash, skillref );
    
    if ( value != prevvalue )
    {
        if ( !isdefined( self.skilldata ) )
        {
            self.skilldata = [];
        }
        
        if ( !isdefined( self.skilldata[ fieldxhash ] ) )
        {
            self.skilldata[ fieldxhash ] = [];
        }
        
        self.skilldata[ fieldxhash ][ skillref ] = value;
    }
    
    return prevvalue;
}

// Namespace ob_skills
// Params 1, eflags: 0x4
// Checksum 0xf3360489, Offset: 0x2818
// Size: 0x28
function private function_ecb88166f5f9aafd( fieldxhash )
{
    return self.skilldata ? self.skilldata[ fieldxhash ] : undefined;
}

// Namespace ob_skills
// Params 2, eflags: 0x4
// Checksum 0xdbb5011f, Offset: 0x2849
// Size: 0x40
function private function_44d6ac51e2d0d975( fieldxhash, skillref )
{
    if ( self.skilldata && self.skilldata[ fieldxhash ] )
    {
        return self.skilldata[ fieldxhash ][ skillref ];
    }
}

// Namespace ob_skills
// Params 2, eflags: 0x4
// Checksum 0x1590af1, Offset: 0x2892
// Size: 0x4c
function private function_62a9298a56dec0e( skillref, skilllevel )
{
    skillbundle = level.skillbundles[ skillref ][ skilllevel ];
    function_b462f90ad3426fa9( #"hash_ffd1a1ccd059fcd4", skillref, skillbundle.var_8a7e931ef8403306 );
}

// Namespace ob_skills
// Params 2, eflags: 0x4
// Checksum 0xf39be20e, Offset: 0x28e6
// Size: 0x4c
function private function_9558ef01c3fdd497( skillref, skilllevel )
{
    skillbundle = level.skillbundles[ skillref ][ skilllevel ];
    function_b462f90ad3426fa9( #"hash_6d51a40fc283e39e", skillref, skillbundle.var_fd5d1a68b3e94d53 );
}

// Namespace ob_skills
// Params 2, eflags: 0x4
// Checksum 0xafaebab5, Offset: 0x293a
// Size: 0x4c
function private function_91d889f2043c905d( skillref, skilllevel )
{
    skillbundle = level.skillbundles[ skillref ][ skilllevel ];
    function_b462f90ad3426fa9( #"clip_ammo", skillref, skillbundle.var_b5897eb9041c5c6d );
}

// Namespace ob_skills
// Params 2, eflags: 0x4
// Checksum 0xce6d3d12, Offset: 0x298e
// Size: 0x4c
function private function_57ff2e5d36dc297f( skillref, skilllevel )
{
    skillbundle = level.skillbundles[ skillref ][ skilllevel ];
    function_b462f90ad3426fa9( #"hash_fe095f357d0f1c28", skillref, skillbundle.var_d7b45ec30f3ee649 );
}

// Namespace ob_skills
// Params 2, eflags: 0x4
// Checksum 0x62f2c2d, Offset: 0x29e2
// Size: 0x5b
function private function_740967ee9e2436ec( skillref, skilllevel )
{
    skillbundle = level.skillbundles[ skillref ][ skilllevel ];
    function_96f138e210281836( skillref, skillbundle.var_e42104ee9ff4294, 1 );
    function_c886899abb9f359c( skillref, skillbundle.var_384debb260d2cd06, 1 );
}

// Namespace ob_skills
// Params 2, eflags: 0x4
// Checksum 0x1dcb0240, Offset: 0x2a45
// Size: 0x11b
function private function_1b4d21b03d7c8b2f( skillref, skilllevel )
{
    skillbundle = level.skillbundles[ skillref ][ skilllevel ];
    ai_damage_mult = skillbundle.var_2f6dcf180e151dd8;
    player_damage_mult = skillbundle.var_e9c95aa8826a1df;
    
    if ( ai_damage_mult || player_damage_mult )
    {
        function_b462f90ad3426fa9( #"ai_damage_mult", skillref, ai_damage_mult ?? 1 );
        function_b462f90ad3426fa9( #"player_damage_mult", skillref, player_damage_mult ?? 1 );
        function_b462f90ad3426fa9( #"ability_ref", skillref, skillbundle.abilityref );
        
        if ( !self.var_34564defd35a616b )
        {
            zombie_utils::function_dfae6a5bd222c586( &function_a450500b04edb79a );
            agent_utils::function_bc89b9076dd93902( &function_a450500b04edb79a );
            assert( !callback::exists( #"hash_2346898712859996", &ob_skills_onplayerdamaged ) );
            callback::add( #"hash_2346898712859996", &ob_skills_onplayerdamaged );
            self.var_34564defd35a616b = 1;
        }
    }
}

// Namespace ob_skills
// Params 1, eflags: 0x4
// Checksum 0x493d1af, Offset: 0x2b68
// Size: 0xdc
function private function_deb4305a56c1b162( skillref )
{
    assert( self.skilldata, "<dev string:x1ee>" );
    
    if ( self.var_34564defd35a616b )
    {
        ai_damage_data = self.skilldata[ #"ai_damage_mult" ];
        player_damage_data = self.skilldata[ #"player_damage_mult" ];
        
        if ( ( !ai_damage_data || ai_damage_data.size == 0 ) && ( !player_damage_data || player_damage_data.size == 0 ) )
        {
            zombie_utils::function_10c0c35c21e3ed9d( &function_a450500b04edb79a );
            agent_utils::function_def5273cfe3c9109( &function_a450500b04edb79a );
            assert( callback::exists( #"hash_2346898712859996", &ob_skills_onplayerdamaged ) );
            callback::remove( #"hash_2346898712859996", &ob_skills_onplayerdamaged );
            self.var_34564defd35a616b = undefined;
        }
    }
}

// Namespace ob_skills
// Params 1, eflags: 0x4
// Checksum 0x57c8c2ae, Offset: 0x2c4c
// Size: 0x63
function private function_a450500b04edb79a( params )
{
    attacker = params.eattacker;
    
    if ( !attacker || !attacker.skilldata )
    {
        return params.idamage;
    }
    
    return function_679b064302ce77f4( params, attacker, attacker.skilldata[ #"ai_damage_mult" ] );
}

// Namespace ob_skills
// Params 1, eflags: 0x4
// Checksum 0xcaec0706, Offset: 0x2cb8
// Size: 0x6f
function private ob_skills_onplayerdamaged( params )
{
    attacker = params.eattacker;
    
    if ( !attacker || !attacker.skilldata )
    {
        return;
    }
    
    params.idamage = params.victim function_679b064302ce77f4( params, attacker, attacker.skilldata[ #"player_damage_mult" ] );
}

// Namespace ob_skills
// Params 3, eflags: 0x4
// Checksum 0xafba831d, Offset: 0x2d2f
// Size: 0x174
function private function_679b064302ce77f4( params, attacker, var_b2eea1b9a32706f7 )
{
    if ( !var_b2eea1b9a32706f7 )
    {
        return params.idamage;
    }
    
    weapon = params.sweapon ?? params.objweapon;
    
    if ( !weapon )
    {
        return params.idamage;
    }
    
    super_ref = supers_mp::getsuperrefforsuperweapon( weapon );
    
    if ( !super_ref )
    {
        return params.idamage;
    }
    
    ability_ref_data = attacker.skilldata[ #"ability_ref" ];
    
    if ( !ability_ref_data )
    {
        return params.idamage;
    }
    
    var_ef05f6f43312a02a = getxhash( super_ref );
    
    foreach ( skillref in getarraykeys( var_b2eea1b9a32706f7 ) )
    {
        var_34578384de57f6bc = ability_ref_data[ skillref ];
        
        if ( var_ef05f6f43312a02a == var_34578384de57f6bc )
        {
            damage_mult = var_b2eea1b9a32706f7[ skillref ];
            return ( params.idamage * damage_mult );
        }
    }
    
    return params.idamage;
}

// Namespace ob_skills
// Params 2, eflags: 0x4
// Checksum 0xd48a1205, Offset: 0x2eac
// Size: 0xe8
function private function_bb9713b6d637debb( abilityref, points )
{
    var_82a7497bcb70d506 = function_ecb88166f5f9aafd( #"hash_ffd1a1ccd059fcd4" );
    
    if ( !var_82a7497bcb70d506 )
    {
        return points;
    }
    
    var_14ff600126db61f9 = isxhash( abilityref ) ? abilityref : getxhash( abilityref );
    
    foreach ( skillref, var_1110daa6b567a1fb in var_82a7497bcb70d506 )
    {
        if ( var_1110daa6b567a1fb > 0 )
        {
            var_65da82ea06e48e74 = function_10da84f2bec77f8e( skillref );
            
            if ( var_65da82ea06e48e74 == var_14ff600126db61f9 )
            {
                points += points * var_1110daa6b567a1fb;
            }
        }
    }
    
    return points;
}

// Namespace ob_skills
// Params 1, eflags: 0x4
// Checksum 0x53453202, Offset: 0x2f9d
// Size: 0x1d
function private function_f75f55f1b8571e53( abilityref )
{
    return function_f5fee476eccacca0( abilityref, #"hash_6d51a40fc283e39e" );
}

// Namespace ob_skills
// Params 1, eflags: 0x4
// Checksum 0xcf45605d, Offset: 0x2fc3
// Size: 0x1d
function private function_78528ecebd639d6d( abilityref )
{
    return function_f5fee476eccacca0( abilityref, #"clip_ammo" );
}

// Namespace ob_skills
// Params 1, eflags: 0x4
// Checksum 0x18fe4ed6, Offset: 0x2fe9
// Size: 0x1d
function private function_af49fe6484e3a149( abilityref )
{
    return function_f5fee476eccacca0( abilityref, #"hash_fe095f357d0f1c28" );
}

// Namespace ob_skills
// Params 2, eflags: 0x4
// Checksum 0xfe2bf211, Offset: 0x300f
// Size: 0xd8
function private function_f5fee476eccacca0( abilityref, field )
{
    if ( !abilityref )
    {
        return;
    }
    
    var_77e54b067da365cf = function_ecb88166f5f9aafd( field );
    
    if ( !var_77e54b067da365cf )
    {
        return;
    }
    
    var_14ff600126db61f9 = isxhash( abilityref ) ? abilityref : getxhash( abilityref );
    
    foreach ( skillref, value in var_77e54b067da365cf )
    {
        var_65da82ea06e48e74 = function_10da84f2bec77f8e( skillref );
        
        if ( var_65da82ea06e48e74 == var_14ff600126db61f9 )
        {
            return value;
        }
    }
}

// Namespace ob_skills
// Params 6, eflags: 0x4
// Checksum 0x5d8cc832, Offset: 0x30ef
// Size: 0x68
function private function_f721b0a77e8fd0b9( fieldxhash, skillref, slot, value, var_2f3a5b6401c9cc5c, var_6defd201ac3edd5 )
{
    prevvalue = function_b462f90ad3426fa9( fieldxhash, skillref, value );
    
    if ( ( value ?? 0 ) != ( prevvalue ?? 0 ) )
    {
        function_87ee9845cb9fe41d( var_2f3a5b6401c9cc5c );
    }
}

// Namespace ob_skills
// Params 4
// Checksum 0xa35cd8a4, Offset: 0x315f
// Size: 0x62
function function_e2c4a7c719e75fb3( skillref, bonusmaxammo, slot, reloadslot )
{
    field = slot == "primary" ? #"hash_9bb70f7f991a48a" : #"hash_7d73bf9bd1c973ea";
    function_f721b0a77e8fd0b9( field, skillref, slot, bonusmaxammo, reloadslot, 0 );
}

// Namespace ob_skills
// Params 3, eflags: 0x4
// Checksum 0x27f8055e, Offset: 0x31c9
// Size: 0x3a
function private function_96f138e210281836( skillref, var_ae23c0ade44cbe7d, rechargeability )
{
    function_f721b0a77e8fd0b9( #"hash_9ff76e145d7f2145", skillref, "secondary", var_ae23c0ade44cbe7d, rechargeability, 1 );
}

// Namespace ob_skills
// Params 3, eflags: 0x4
// Checksum 0x2f7999c0, Offset: 0x320b
// Size: 0x3a
function private function_c886899abb9f359c( skillref, var_ff5dfcb3c876202a, rechargeability )
{
    function_f721b0a77e8fd0b9( #"hash_ab6c58831806af45", skillref, "secondary", var_ff5dfcb3c876202a, rechargeability, 1 );
}

// Namespace ob_skills
// Params 1, eflags: 0x4
// Checksum 0xe4a1b3b3, Offset: 0x324d
// Size: 0x11a
function private function_87ee9845cb9fe41d( reloadslot )
{
    foreach ( equipref in equipment_mp::function_46b102c55f314986() )
    {
        maxammo = equipment_mp::getequipmentmaxammo( equipref );
        currentammo = equipment_mp::getequipmentammo( equipref );
        newammo = reloadslot || currentammo > maxammo ? maxammo : currentammo;
        equipment_mp::setequipmentammo( equipref, newammo, maxammo );
        tableinfo = equipment_mp::getequipmenttableinfo( equipref );
        
        if ( tableinfo.bundle.issuper )
        {
            if ( newammo >= maxammo )
            {
                supers_mp::function_235acb90dc5ccdbe( #"tactical" );
                continue;
            }
            
            supers_mp::superpointschanged( #"tactical" );
        }
    }
}

// Namespace ob_skills
// Params 1, eflags: 0x4
// Checksum 0xeac644cb, Offset: 0x336f
// Size: 0x192
function private function_f210d2df48e0410a( equipmentref )
{
    bonusmaxammo = 0;
    superref = function_16a6987f98dda085( equipmentref );
    
    if ( superref )
    {
        skilldata = function_ecb88166f5f9aafd( #"hash_9ff76e145d7f2145" );
        
        if ( skilldata )
        {
            foreach ( skillref, bonus in skilldata )
            {
                abilityref = function_10da84f2bec77f8e( skillref );
                
                if ( abilityref == superref )
                {
                    bonusmaxammo += bonus;
                }
            }
        }
    }
    else
    {
        slot = equipment_mp::findequipmentslot( equipmentref );
        
        if ( slot )
        {
            datafield = slot == "primary" ? #"hash_9bb70f7f991a48a" : #"hash_7d73bf9bd1c973ea";
            skilldata = function_ecb88166f5f9aafd( datafield );
            
            if ( skilldata )
            {
                foreach ( bonus in skilldata )
                {
                    bonusmaxammo += bonus ?? 0;
                }
            }
        }
    }
    
    return bonusmaxammo;
}

// Namespace ob_skills
// Params 1, eflags: 0x4
// Checksum 0x5f14bc16, Offset: 0x350a
// Size: 0x4f
function private function_3d5866519a25bbb8( equipmentref )
{
    superref = function_16a6987f98dda085( equipmentref );
    
    if ( superref )
    {
        skilldata = function_ecb88166f5f9aafd( #"hash_ab6c58831806af45" );
        
        if ( skilldata.size > 0 )
        {
            return utility::array_max( skilldata );
        }
    }
}

// Namespace ob_skills
// Params 1, eflags: 0x4
// Checksum 0xe6c6d8de, Offset: 0x3562
// Size: 0x5c
function private function_16a6987f98dda085( equipmentref )
{
    tableinfo = equipment_mp::getequipmenttableinfo( equipmentref );
    superref = tableinfo.bundle.superref;
    
    if ( superref )
    {
        superref = isxhash( superref ) ? superref : getxhash( superref );
    }
    
    return superref;
}

// Namespace ob_skills
// Params 1, eflags: 0x4
// Checksum 0xe0d5ad14, Offset: 0x35c7
// Size: 0x27
function private function_be4b714df46ce505( skill_name )
{
    if ( self.var_76e0ffe10856577c[ skill_name ] )
    {
        self.var_76e0ffe10856577c[ skill_name ] = undefined;
    }
}

// Namespace ob_skills
// Params 1, eflags: 0x4
// Checksum 0xa96c4fae, Offset: 0x35f6
// Size: 0x58, Type: bool
function private function_52dacbf6345f01ea( data )
{
    last_timestamp = data.player.var_76e0ffe10856577c[ data.skill_name ];
    
    if ( !last_timestamp )
    {
        return false;
    }
    
    return gettime() - last_timestamp < data.cooldown * 1000;
}

// Namespace ob_skills
// Params 1, eflags: 0x4
// Checksum 0xd9a23cd8, Offset: 0x3657
// Size: 0x458
function private function_be2bcf2bcc0a9b2b( data )
{
    player = data.player;
    
    if ( data.cooldown && data.skill_name && function_52dacbf6345f01ea( data ) )
    {
        return;
    }
    
    ai_tier = ai_utility::get_power_tier();
    
    if ( !ai_tier || !arraycontains( data.var_3b55b60765b98d29, ai_tier ) )
    {
        return;
    }
    
    if ( randomfloat( 1 ) > data.probability )
    {
        return;
    }
    
    var_5e94b7b011663cfd = data.idamage > self.health;
    weapon = data.sweapon ?? data.objweapon;
    
    if ( !weapon )
    {
        weapon = player getcurrentweapon();
    }
    
    var_41c8d742f46ed3fb = player ammo_mod::get_ammo_mod_name( weapon );
    var_58e7e0121c794d5c = getarraykeys( level.ammo_mods );
    var_58e7e0121c794d5c = arrayremove( var_58e7e0121c794d5c, "none" );
    
    if ( data.var_563eb10bd0071b7d && var_41c8d742f46ed3fb && var_58e7e0121c794d5c.size > 1 )
    {
        var_58e7e0121c794d5c = arrayremove( var_58e7e0121c794d5c, var_41c8d742f46ed3fb );
    }
    
    if ( data.weights_table.size > 0 )
    {
        struct = utility::random_weighted_struct( data.weights_table );
        var_35a7e90f80366839 = struct.ammomod;
    }
    
    if ( !var_35a7e90f80366839 )
    {
        var_35a7e90f80366839 = utility::array_random( var_58e7e0121c794d5c );
    }
    
    player.var_88cc283ee5d29498 = 1;
    var_b1ece7ee0e8bf412 = weapon::buildweapon( level.laststandweapon );
    player ammo_mod::add_ammo_mod_to_weapon( var_b1ece7ee0e8bf412, var_35a7e90f80366839, 0 );
    
    if ( ai_tier == 3 )
    {
        var_1a0a60539bea873f = [ "fw_ammomod":#"fw_big_game", "deadwire":#"deadwire_big_game", "napalmburst":#"napalmburst_big_game", "shadowvortex":#"shadowvortex_big_game", "cryofreeze":#"cryofreeze_big_game", "brainrot":#"brainrot_big_game", "shatterblast":#"shatterblast_big_game", "lightray":#"lightray_big_game" ];
        var_b1487eb1ce65e991 = var_1a0a60539bea873f[ var_35a7e90f80366839 ];
        ammo_mod_xhash = getxhash( var_35a7e90f80366839 );
        var_40c64f99a08dd9de = player.zombie_augments[ ammo_mod_xhash ];
        var_d2c1edec5a9f0994 = level.zombie_augments[ var_b1487eb1ce65e991 ].var_9f9a3afac6467400;
        player.zombie_augments[ ammo_mod_xhash ] = { #majorname:var_b1487eb1ce65e991 };
        level.zombie_augments[ var_b1487eb1ce65e991 ].var_9f9a3afac6467400 = 1;
    }
    
    var_ad5d0f2a4afb15ff = level.perkbundles[ "specialty_elemental_pop" ].var_9de0bd5324529537;
    successfully_triggered = ammo_mod::ammo_mod_response( var_5e94b7b011663cfd, data.inflictor, player, data.idamage, data.idflags, "MOD_PISTOL_BULLET", var_b1ece7ee0e8bf412, data.vpoint, data.vdir, data.shitloc, data.timeoffset, data.modelindex, data.partname, data.objweapon, var_ad5d0f2a4afb15ff, weapon, data.var_b8f3721c1cf18fb7 );
    
    if ( data.cooldown && data.skill_name && successfully_triggered )
    {
        if ( !isdefined( player.var_76e0ffe10856577c ) )
        {
            player.var_76e0ffe10856577c = [];
        }
        
        player.var_76e0ffe10856577c[ data.skill_name ] = gettime();
    }
    
    if ( var_b1487eb1ce65e991 )
    {
        player.zombie_augments[ ammo_mod_xhash ] = var_40c64f99a08dd9de;
        level.zombie_augments[ var_b1487eb1ce65e991 ].var_9f9a3afac6467400 = var_d2c1edec5a9f0994;
    }
    
    player ammo_mod::function_e6267ae500506234( var_b1ece7ee0e8bf412, 0 );
    
    if ( var_41c8d742f46ed3fb != "" && var_41c8d742f46ed3fb != "none" )
    {
        if ( !player ammo_mod::function_ba9b2ecd18bdbdd8( weapon, var_41c8d742f46ed3fb ) )
        {
            player ammo_mod::add_ammo_mod_to_weapon( weapon, var_41c8d742f46ed3fb );
        }
    }
    
    return var_35a7e90f80366839;
}

// Namespace ob_skills
// Params 1
// Checksum 0xfcd4a094, Offset: 0x3ab8
// Size: 0x22
function function_10da84f2bec77f8e( skillref )
{
    return level.skillbundles[ skillref ][ #"ability_dependency" ];
}

// Namespace ob_skills
// Params 2, eflags: 0x4
// Checksum 0xbf1d5e4e, Offset: 0x3ae3
// Size: 0x7d
function private function_74bcf6218fef920f( skillref, skilllevel )
{
    if ( self.isdisconnecting )
    {
        return 1;
    }
    
    function_d240cf8d1b255cf0( skillref, skilllevel );
    
    if ( utility::issharedfuncdefined( skillref, #"ongiveskill" ) )
    {
        skillbundle = level.skillbundles[ skillref ][ skilllevel ];
        success = [[ utility::getsharedfunc( skillref, #"ongiveskill" ) ]]( skillbundle );
    }
    
    return success;
}

// Namespace ob_skills
// Params 1, eflags: 0x4
// Checksum 0x2bff0bf1, Offset: 0x3b69
// Size: 0x26
function private function_94d827e7a50c6f1d( var_b71462f80cd7fe1 )
{
    return var_b71462f80cd7fe1 ? self.var_bcde97a1f15e0648 : self.activeskills;
}

// Namespace ob_skills
// Params 2, eflags: 0x4
// Checksum 0x3b79bc65, Offset: 0x3b98
// Size: 0x33
function private function_fbf937639883bcf9( activeskills, var_b71462f80cd7fe1 )
{
    if ( var_b71462f80cd7fe1 )
    {
        self.var_bcde97a1f15e0648 = activeskills;
        return;
    }
    
    self.activeskills = activeskills;
}

// Namespace ob_skills
// Params 5, eflags: 0x4
// Checksum 0x5a94f52e, Offset: 0x3bd3
// Size: 0x4ba
function private function_f2f16fdf16f40be1( skillref, skilllevel, var_b71462f80cd7fe1, var_fbd8edb1f5026b96, var_cc8f9a53a9ec507f = 0 )
{
    assert( isdefined( level.skillbundles[ skillref ] ), getxhashsourcename( skillref ) + "<dev string:x224>" );
    assert( isdefined( level.skillbundles[ skillref ][ skilllevel ] ), skilllevel + "<dev string:x23b>" + getxhashsourcename( skillref ) + "<dev string:x256>" );
    skilldata = level.skillbundles[ skillref ][ skilllevel ];
    
    if ( !isplayer( self ) )
    {
        assertmsg( "<dev string:x25e>" );
        return;
    }
    
    if ( var_b71462f80cd7fe1 )
    {
        abilityref = function_10da84f2bec77f8e( skillref );
        var_85570ee8e79f6945 = abilityref == supers_mp::getcurrentsuperref( #"tactical" );
        var_c9b3cfa3b72ad9f1 = abilityref == supers_mp::getcurrentsuperref( #"default" );
        
        if ( !var_85570ee8e79f6945 && !var_c9b3cfa3b72ad9f1 )
        {
            assertmsg( getxhashsourcename( abilityref ) + "<dev string:x274>" + getxhashsourcename( skillref ) );
            return;
        }
        
        slot = var_c9b3cfa3b72ad9f1 ? #"default" : #"tactical";
        var_28328bfa2117a938 = supers_mp::getsuperpointsneeded( undefined, slot );
    }
    
    activeskills = function_94d827e7a50c6f1d( var_b71462f80cd7fe1 );
    
    if ( activeskills[ skillref ] && activeskills[ skillref ] == skilllevel )
    {
        if ( !var_fbd8edb1f5026b96 )
        {
            assertmsg( "<dev string:x28b>" + getxhashsourcename( skillref ) + "<dev string:x2a0>" + skilllevel + "<dev string:x2ab>" );
        }
        
        return;
    }
    
    success = function_74bcf6218fef920f( skillref, skilllevel );
    
    if ( success )
    {
        activeskills[ skillref ] = skilllevel;
        self.var_63607c42018684a5[ skilldata.index ] = skillref;
        
        if ( skilldata.var_c5f85fc80a76cf7c.var_eacbf2fc79e9e24d && skilldata.var_c5f85fc80a76cf7c.playerscriptablepartstate && !var_cc8f9a53a9ec507f )
        {
            self setscriptablepartstate( skilldata.var_c5f85fc80a76cf7c.var_eacbf2fc79e9e24d, skilldata.var_c5f85fc80a76cf7c.playerscriptablepartstate );
        }
        
        if ( skilldata.var_c5f85fc80a76cf7c.fullscreenfx && !var_cc8f9a53a9ec507f )
        {
            pbfx_name = self.visibilitymode.darkbackgroundvalue ? %"cer_vismode_nosaturation" : skilldata.var_c5f85fc80a76cf7c.fullscreenfx;
            utility::callsharedfunc( #"fullscreenfx", #"hash_382df7654f0561bd", { #postfxbundlename:pbfx_name }, 1, 1 );
        }
        
        if ( skilldata.var_c5f85fc80a76cf7c.earnedsfx && !var_cc8f9a53a9ec507f )
        {
            self playsoundtoplayer( skilldata.var_c5f85fc80a76cf7c.earnedsfx, self );
        }
        
        if ( !var_cc8f9a53a9ec507f )
        {
            switch ( skillref )
            {
                case #"armor_upgrade":
                case #"health_upgrade":
                case #"move_speed_upgrade":
                    if ( level.var_858d230de58cc743.var_9dd001c13ad03813 )
                    {
                        thread function_5e15678afc7595d4( 2, level.skillbundles[ skillref ][ skilllevel ].index + 1 );
                    }
                    
                    break;
                case #"damage_upgrade":
                    if ( level.var_858d230de58cc743.var_585583c11017b0fd )
                    {
                        thread function_5e15678afc7595d4( 1, level.skillbundles[ skillref ][ skilllevel ].index + 1, skilllevel + 1 );
                    }
                    
                    break;
            }
        }
        
        level callback::callback( #"skill_acquired", { #player:self, #skilllevel:skilllevel, #skillref:skillref } );
    }
    
    if ( success && var_b71462f80cd7fe1 )
    {
        var_b05a7f83f28e157c = supers_mp::getsuperpointsneeded( undefined, slot );
        function_f8d85d3174f2e33c( slot, var_28328bfa2117a938, var_b05a7f83f28e157c );
    }
    
    var_9eb5d60136de1c65 = level.var_858d230de58cc743.var_89b06cbde19c889e ?? 7;
    
    if ( skilldata.var_6040d5f43ca7a49a )
    {
        if ( skilllevel == self.var_3ec847b9b5bb1abb )
        {
            self.var_fe6f091fe36c6136++;
        }
        
        if ( self.var_fe6f091fe36c6136 >= var_9eb5d60136de1c65 )
        {
            self.var_3ec847b9b5bb1abb++;
            self.var_fe6f091fe36c6136 = 0;
        }
    }
    
    function_fbf937639883bcf9( activeskills, var_b71462f80cd7fe1 );
    
    if ( level.var_5e13510a4bcb35a0 )
    {
        function_d741797888dacd2b();
    }
    
    return success;
}

// Namespace ob_skills
// Params 2, eflags: 0x4
// Checksum 0xc161604f, Offset: 0x4096
// Size: 0x1bd
function private function_e364bf60e7c20ace( skillref, var_b71462f80cd7fe1 )
{
    assert( isdefined( level.skillbundles[ skillref ] ), getxhashsourcename( skillref ) + "<dev string:x224>" );
    
    if ( !isplayer( self ) )
    {
        assertmsg( "<dev string:x25e>" );
        return;
    }
    
    activeskills = function_94d827e7a50c6f1d( var_b71462f80cd7fe1 );
    
    if ( !isdefined( activeskills[ skillref ] ) )
    {
        return;
    }
    
    skill = activeskills[ skillref ];
    
    if ( var_b71462f80cd7fe1 )
    {
        abilityref = function_10da84f2bec77f8e( skillref );
        slot = abilityref == supers_mp::getcurrentsuperref( #"default" ) ? #"default" : #"tactical";
        var_b05a7f83f28e157c = supers_mp::getsuperpointsneeded( undefined, slot );
    }
    
    if ( isdefined( skill ) )
    {
        skillbundle = level.skillbundles[ skillref ][ skill ];
        self.var_63607c42018684a5[ skillbundle.index ] = undefined;
        activeskills[ skillref ] = undefined;
        
        if ( utility::issharedfuncdefined( skillref, #"hash_4aa03f4559ac50a5" ) )
        {
            [[ utility::getsharedfunc( skillref, #"hash_4aa03f4559ac50a5" ) ]]( skillbundle );
        }
        
        function_9905db6daa265e8f( skillref );
    }
    
    if ( var_b71462f80cd7fe1 )
    {
        var_28328bfa2117a938 = supers_mp::getsuperpointsneeded( undefined, slot );
        function_f8d85d3174f2e33c( slot, var_b05a7f83f28e157c, var_28328bfa2117a938 );
    }
    
    function_fbf937639883bcf9( activeskills, var_b71462f80cd7fe1 );
    
    if ( level.var_5e13510a4bcb35a0 )
    {
        function_d741797888dacd2b();
    }
    
    function_be4b714df46ce505( skillref );
    level callback::callback( #"skill_removed", { #player:self, #skilllevel:skill, #skillref:skillref } );
}

// Namespace ob_skills
// Params 4
// Checksum 0x3b549435, Offset: 0x425b
// Size: 0x11e
function function_3ceb333c50dbd4cb( skillref, skilllevel, var_fbd8edb1f5026b96, var_cc8f9a53a9ec507f = 0 )
{
    if ( utility::callsharedfunc( #"skills", #"hash_7839ce6cac4cb514", skillref, skilllevel ) == #"end_game" || utility::callsharedfunc( #"skills", #"hash_7839ce6cac4cb514", skillref, skilllevel ) == #"nightmare" )
    {
        skillssettings = level.var_858d230de58cc743;
        
        if ( skillssettings )
        {
            var_637b95f1b52fb538 = getscriptbundle( skillssettings.var_e59f229d9bf9be39 );
            var_637b95f1b52fb538.ref = skillssettings.var_e59f229d9bf9be39;
            var_637b95f1b52fb538.isspecial = 1;
            self.skilltracks[ var_637b95f1b52fb538.lootid ] = var_637b95f1b52fb538;
        }
    }
    
    var_b71462f80cd7fe1 = isdefined( level.skillbundles[ skillref ][ #"ability_dependency" ] );
    return function_f2f16fdf16f40be1( skillref, skilllevel, var_b71462f80cd7fe1, var_fbd8edb1f5026b96, var_cc8f9a53a9ec507f );
}

// Namespace ob_skills
// Params 1
// Checksum 0xe894b053, Offset: 0x4382
// Size: 0x39
function function_474a08a0c197134( skillref )
{
    var_b71462f80cd7fe1 = isdefined( level.skillbundles[ skillref ][ #"ability_dependency" ] );
    function_e364bf60e7c20ace( skillref, var_b71462f80cd7fe1 );
}

// Namespace ob_skills
// Params 0
// Checksum 0x2c8cdc8, Offset: 0x43c3
// Size: 0xe2
function function_39e0389c640eb3b8()
{
    foreach ( skillref, skilllevel in self.activeskills )
    {
        function_474a08a0c197134( skillref );
    }
    
    foreach ( skillref, skilllevel in self.var_bcde97a1f15e0648 )
    {
        function_474a08a0c197134( skillref );
    }
}

// Namespace ob_skills
// Params 1, eflags: 0x4
// Checksum 0xa80a2933, Offset: 0x44ad
// Size: 0x92
function private function_b4c5928391767e1( skillref )
{
    if ( isdefined( level.skillbundles[ skillref ][ self.activeskills[ skillref ] ] ) )
    {
        return level.skillbundles[ skillref ][ self.activeskills[ skillref ] ].index;
    }
    else if ( isdefined( level.skillbundles[ skillref ][ self.var_bcde97a1f15e0648[ skillref ] ] ) )
    {
        return level.skillbundles[ skillref ][ self.var_bcde97a1f15e0648[ skillref ] ].index;
    }
    
    return 0;
}

// Namespace ob_skills
// Params 0, eflags: 0x4
// Checksum 0x2428f601, Offset: 0x4548
// Size: 0xcb
function private function_d741797888dacd2b()
{
    if ( !level.var_5e13510a4bcb35a0 || !isdefined( self.activeskills ) )
    {
        return;
    }
    
    skillrefs = getarraykeys( self.activeskills );
    
    for ( i = 0; i < 5 ; i++ )
    {
        skillindex = function_b4c5928391767e1( skillrefs[ i ] );
        
        if ( skillindex )
        {
            skillindex += 1;
        }
        else
        {
            skillindex = 0;
        }
        
        omnvarindex = i + 1;
    }
    
    skillrefs = getarraykeys( self.var_bcde97a1f15e0648 );
    
    for ( i = 0; i < 2 ; i++ )
    {
        skillindex = function_b4c5928391767e1( skillrefs[ i ] );
        
        if ( skillindex )
        {
            skillindex += 1;
        }
        else
        {
            skillindex = 0;
        }
        
        omnvarindex = i + 1;
    }
}

// Namespace ob_skills
// Params 1
// Checksum 0x5952cbe6, Offset: 0x461b
// Size: 0x17f
function apply_invulnerability( invulnerability_data )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    assert( invulnerability_data.duration > 0, "<dev string:x2c9>" );
    val::set( invulnerability_data.id, "damage", 0 );
    val::set( invulnerability_data.id, "damage_protection_omnvar", "ui_squadmate_show_damage_protection_" + self.sessionuimemberindex );
    
    if ( invulnerability_data.scriptable_part && invulnerability_data.scriptable_state_on )
    {
        self setscriptablepartstate( invulnerability_data.scriptable_part, invulnerability_data.scriptable_state_on, 0 );
    }
    
    if ( invulnerability_data.pbg_post_fx )
    {
        val::set( invulnerability_data.id, "damage_protection_pgb_post_fx", invulnerability_data.pbg_post_fx );
    }
    
    wait invulnerability_data.duration;
    val::reset( invulnerability_data.id, "damage" );
    val::reset( invulnerability_data.id, "damage_protection_omnvar" );
    
    if ( invulnerability_data.scriptable_part && invulnerability_data.scriptable_state_off )
    {
        self setscriptablepartstate( invulnerability_data.scriptable_part, invulnerability_data.scriptable_state_off, 0 );
    }
    
    if ( invulnerability_data.pbg_post_fx )
    {
        val::reset( invulnerability_data.id, "damage_protection_pgb_post_fx" );
    }
}

// Namespace ob_skills
// Params 0
// Checksum 0x72f5a3bc, Offset: 0x47a2
// Size: 0x30
function ob_skills_hint()
{
    utility::callsharedfunc( #"hint", #"add_simple", "hint_skills_use", &"sat_ob/hint_skills_use", 10, undefined, undefined, undefined, undefined, 0 );
}

// Namespace ob_skills
// Params 2
// Checksum 0x595b152b, Offset: 0x47da
// Size: 0x143
function function_4be523713b8258fe( validplayers, activityreward )
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
            player thread ob_skills_hint();
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
        
        player function_490747a9a77e888f();
    }
}

// Namespace ob_skills
// Params 1
// Checksum 0xc0994740, Offset: 0x4925
// Size: 0x30a
function function_2400e270530f4ac8( powertier )
{
    var_a3f9f12d730c3d24 = 0;
    
    foreach ( track in self.skilltracks )
    {
        if ( !track.isspecial )
        {
            var_a3f9f12d730c3d24++;
        }
    }
    
    rule = level.var_4281aa3f0598bb1a[ "AT" ][ powertier ];
    var_5f9ddbb27b1ddd36 = !isdefined( rule.requiredprestige ) || self.operatorprestige >= rule.requiredprestige;
    var_8bcc1968343d1daa = !isdefined( rule.var_104780e73f6503de ) || var_a3f9f12d730c3d24 == rule.var_104780e73f6503de;
    
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
        
        var_8bcc1968343d1daa = !isdefined( rule.var_104780e73f6503de ) || var_a3f9f12d730c3d24 == rule.var_104780e73f6503de;
        
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
        
        var_8bcc1968343d1daa = !isdefined( rule.var_104780e73f6503de ) || var_a3f9f12d730c3d24 == rule.var_104780e73f6503de;
        
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

// Namespace ob_skills
// Params 0
// Checksum 0x24e41eee, Offset: 0x4c38
// Size: 0x4ec
function function_490747a9a77e888f()
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
            function_c78e9f8ae3241430( self.powertier );
            
            if ( !self.selectableskills[ 0 ] && !self.selectableskills[ 1 ] )
            {
                return 0;
            }
        }
        
        skillpicked = function_83c59fc41162abe0();
        
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
        function_474a08a0c197134( selectedskill.skillref );
        waitframe();
    }
    
    success = function_3ceb333c50dbd4cb( selectedskill.skillref, selectedskill.skilllevel );
    
    if ( success )
    {
        if ( selectedtrack )
        {
            self.skilltracks[ selectedtrack.lootid ] = selectedtrack;
            self.pers[ "mostRecentSkillTrackLootID" ] = selectedtrack.lootid;
        }
        
        self.selectableskills = undefined;
        self.selectabletracks = undefined;
        function_c78e9f8ae3241430( self.powertier + 1 );
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
    
    function_fabba520fe40e6ff( var_2a1677bd8ea533f9, selectedskill, var_f916a5e9f77dd0ba, var_7d10ecea58bfbce0 );
    return 1;
}

// Namespace ob_skills
// Params 4
// Checksum 0xf42b6c36, Offset: 0x512d
// Size: 0x269
function function_fabba520fe40e6ff( var_2a1677bd8ea533f9, selectedskill, var_f916a5e9f77dd0ba, var_7d10ecea58bfbce0 )
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

// Namespace ob_skills
// Params 3
// Checksum 0x451e7566, Offset: 0x539e
// Size: 0xed
function function_7162b32a8fde6a4f( skill, updatesplash, forceupdate )
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

// Namespace ob_skills
// Params 0
// Checksum 0x3123bbf0, Offset: 0x5493
// Size: 0x1a2
function function_83c59fc41162abe0()
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
    
    thread function_b1d911affb2a567d();
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

// Namespace ob_skills
// Params 1
// Checksum 0xaef38370, Offset: 0x563d
// Size: 0x18
function function_a463aa654aa04df( params )
{
    self notify( #"ob_skill_select_intro_complete" );
}

// Namespace ob_skills
// Params 0
// Checksum 0xa1f8891a, Offset: 0x565d
// Size: 0xe8
function function_b1d911affb2a567d()
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

// Namespace ob_skills
// Params 1
// Checksum 0xdcaac7ea, Offset: 0x574d
// Size: 0x180
function function_c78e9f8ae3241430( powertier )
{
    var_acecf1de8ec2250a = self.operatorprestige < 3 ? 61 : 77;
    
    if ( powertier >= var_acecf1de8ec2250a )
    {
        return;
    }
    
    if ( self.var_6e6abd7fa4d7b630 )
    {
        function_307fa41bfe51d3ea( self.var_6e6abd7fa4d7b630 );
        self.var_6e6abd7fa4d7b630 = undefined;
    }
    
    if ( !self.selectableskills || self.selectableskills.size < 1 )
    {
        var_31f73ed4015fc20d = function_2400e270530f4ac8( powertier );
        
        if ( var_31f73ed4015fc20d )
        {
            function_307fa41bfe51d3ea( var_31f73ed4015fc20d.skillchoice );
            
            if ( !self.selectableskills || self.selectableskills.size < 1 )
            {
                function_307fa41bfe51d3ea( var_31f73ed4015fc20d.var_cd884d4fa8fa3e72 );
            }
        }
    }
    
    if ( !self.selectableskills || self.selectableskills.size < 1 )
    {
        self.var_832e4f138f18c200 = self.var_4971bba44f275df;
        self.var_4971bba44f275df = "SKILL";
        self.selectableskills = self.selectableskills ?? [];
        validskills = function_9db2a258fabfc063();
        self.selectableskills = function_c01f39e8bab4ca61( validskills[ 0 ], validskills[ 1 ] );
    }
    
    assert( isdefined( self.selectableskills[ 0 ] ) || isdefined( self.selectableskills[ 1 ] ), "<dev string:x2f0>" + powertier + "<dev string:x9c>" );
}

// Namespace ob_skills
// Params 1
// Checksum 0x7c53b016, Offset: 0x58d5
// Size: 0x312
function function_307fa41bfe51d3ea( var_31f73ed4015fc20d )
{
    switch ( var_31f73ed4015fc20d )
    {
        case #"hash_f89a366fb7e1d999":
            var_23308e473685170b = self.skilltracks.size ?? 0;
            tracks = self.var_7abd0979037af008.size ? self.var_7abd0979037af008 : arrayrandomize( level.skilltracklist );
            selectableskills = [];
            selectabletracks = [];
            
            foreach ( track in tracks )
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
                
                startingskill = function_945fd105982c7a2d( track );
                
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
                assertmsg( "<dev string:x319>" );
                function_1c870c7d7bf3805b();
            }
            
            self.var_832e4f138f18c200 = self.var_4971bba44f275df;
            self.var_4971bba44f275df = "NEW_TRACK";
            return;
        case #"hash_49ba77d7d34edcbc":
            skillssettings = level.var_858d230de58cc743;
            
            if ( skillssettings )
            {
                var_4e18ee5e7c3b2610 = getscriptbundle( skillssettings.var_4e18ee5e7c3b2610 );
                function_d7df18fe4eb0664( var_4e18ee5e7c3b2610, 0 );
            }
            
            self.var_832e4f138f18c200 = self.var_4971bba44f275df;
            self.var_4971bba44f275df = "CORE_UPGRADE";
            return;
        case #"hash_bc40f2488f923f8f":
            skillssettings = level.var_858d230de58cc743;
            
            if ( skillssettings )
            {
                var_11ecb72c7a1353cf = getscriptbundle( skillssettings.var_4e18ee5e7c3b2610 );
                function_d7df18fe4eb0664( var_11ecb72c7a1353cf, 1 );
            }
            
            self.var_832e4f138f18c200 = self.var_4971bba44f275df;
            self.var_4971bba44f275df = "CORE_UPGRADE";
            return;
    }
}

// Namespace ob_skills
// Params 0
// Checksum 0x1415006, Offset: 0x5bef
// Size: 0x26f
function function_1c870c7d7bf3805b()
{
    tracks = arrayrandomize( level.skilltracklist );
    selectableskills = [];
    selectabletracks = [];
    
    if ( !isdefined( self.tracksshown ) )
    {
        self.tracksshown = [];
    }
    
    foreach ( track in tracks )
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
        
        startingskill = function_945fd105982c7a2d( track );
        
        if ( startingskill )
        {
            selectableskills[ selectableskills.size ] = startingskill;
            selectabletracks[ selectabletracks.size ] = track;
        }
    }
    
    self.selectableskills = selectableskills;
    self.selectabletracks = selectabletracks;
}

// Namespace ob_skills
// Params 2
// Checksum 0x354be558, Offset: 0x5e66
// Size: 0x59, Type: bool
function function_1056397d183afee( skillref, skilllevel )
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

// Namespace ob_skills
// Params 0
// Checksum 0x497e3f11, Offset: 0x5ec8
// Size: 0x2c7
function function_9db2a258fabfc063()
{
    validskills = [];
    backupskills = [];
    
    foreach ( skilltrack in self.skilltracks )
    {
        var_5ae489862927355f = function_1e9bbdf2ff12b4dd( skilltrack );
        var_f2cfc0d168f95329 = var_5ae489862927355f + 1;
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
            
            skilllevel = function_a0694c3a04745afc( skill.skillref );
            
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

// Namespace ob_skills
// Params 1, eflags: 0x4
// Checksum 0x4d1ca407, Offset: 0x6198
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

// Namespace ob_skills
// Params 2, eflags: 0x4
// Checksum 0x93da2ccb, Offset: 0x6358
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
        orderedskills = function_4ddf4d17fa6a3b5( backupskills );
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

// Namespace ob_skills
// Params 1
// Checksum 0x9d883bc5, Offset: 0x64b9
// Size: 0x1ef
function function_4ddf4d17fa6a3b5( backupskills )
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

// Namespace ob_skills
// Params 1
// Checksum 0xde7e83bc, Offset: 0x66b1
// Size: 0xa4
function function_945fd105982c7a2d( skilltrack )
{
    foreach ( skill in skilltrack.skills )
    {
        if ( skill.var_361cdcaa190a34e3 )
        {
            return level.skillbundles[ skill.skillref ][ 0 ];
        }
    }
}

// Namespace ob_skills
// Params 1
// Checksum 0xf275f916, Offset: 0x675d
// Size: 0xd6, Type: bool
function function_b2c1c2ef3774920d( skilltrack )
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

// Namespace ob_skills
// Params 2
// Checksum 0xcd0929cd, Offset: 0x683c
// Size: 0x20b
function function_d7df18fe4eb0664( track, specialskills )
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
        upgradelevel = function_a0694c3a04745afc( upgraderef );
        
        if ( upgradelevel > 0 )
        {
            var_7040e1db02238e4c = 0;
        }
        
        if ( upgradelevel > var_a5c28ab68469597b && upgradelevel > var_a5c28bb684695bae )
        {
            continue;
        }
        
        if ( !function_1056397d183afee( upgraderef, upgradelevel ) )
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

// Namespace ob_skills
// Params 1
// Checksum 0x1d4839d8, Offset: 0x6a4f
// Size: 0x49
function function_a0694c3a04745afc( skillref )
{
    upgradelevel = 0;
    
    if ( self.activeskills && isdefined( self.activeskills[ skillref ] ) )
    {
        upgradelevel = self.activeskills[ skillref ] + 1;
    }
    
    return upgradelevel;
}

// Namespace ob_skills
// Params 0
// Checksum 0xec6a8eff, Offset: 0x6aa1
// Size: 0x83
function function_5c3dbee52a9cdc5b()
{
    self endon( #"death_or_disconnect" );
    var_631574f297e4a5e5 = 0;
    
    while ( self.var_33d186df2677b56f[ var_631574f297e4a5e5 ] )
    {
        nextsplash = self.var_33d186df2677b56f[ var_631574f297e4a5e5 ];
        function_6c4914123ec70d29( nextsplash.splashtype, nextsplash.splashindex, nextsplash.skilllevel );
        var_631574f297e4a5e5++;
        waitframe();
    }
    
    self.var_33d186df2677b56f = undefined;
    self.var_94f813c2f06c5b75 = undefined;
}

// Namespace ob_skills
// Params 3
// Checksum 0xcd9fc681, Offset: 0x6b2c
// Size: 0xcf
function function_5e15678afc7595d4( splashtype, splashindex, skilllevel )
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
        thread function_5c3dbee52a9cdc5b();
        return;
    }
    
    self.var_33d186df2677b56f[ self.var_94f813c2f06c5b75 ] = newsplash;
    self.var_94f813c2f06c5b75++;
}

// Namespace ob_skills
// Params 3
// Checksum 0x3f1f0a80, Offset: 0x6c03
// Size: 0x79
function function_6c4914123ec70d29( splashtype, splashindex, skilllevel )
{
    self endon( #"death_or_disconnect" );
    self setclientomnvar( "ui_ob_upgrade_splash_type", splashtype );
    self setclientomnvar( "ui_ob_upgrade_splash_asset_index", splashindex );
    self setclientomnvar( "ui_ob_damage_skill_level", skilllevel );
    ob_upgrade_splash::open_ob_upgrade_splash();
    self waittill( #"upgradesplashhide" );
    ob_upgrade_splash::close_ob_upgrade_splash();
    
    while ( ob_upgrade_splash::ob_upgrade_splash_is_active() )
    {
        waitframe();
    }
}

// Namespace ob_skills
// Params 2
// Checksum 0x9f2ebf8a, Offset: 0x6c84
// Size: 0x371
function function_9d7c461c00f2f588( var_8c5067d0870248c8, var_cc8f9a53a9ec507f = 0 )
{
    self notify( #"hash_d631b4e455021d7b" );
    self endon( #"hash_d631b4e455021d7b" );
    assert( isplayer( self ) );
    assert( isdefined( var_8c5067d0870248c8 ) );
    player = self;
    player endon( #"disconnect" );
    
    while ( !isdefined( player.activeskills ) )
    {
        waitframe();
    }
    
    player ob_skills_reset();
    player.var_8c5067d0870248c8 = var_8c5067d0870248c8;
    squad = teams::function_72b89edf6b47c40a( player );
    
    if ( isdefined( squad ) )
    {
        squad.var_8c5067d0870248c8 = var_8c5067d0870248c8;
    }
    
    if ( var_8c5067d0870248c8 > 0 )
    {
        var_ce441c5dd91822a = level.var_bb86f77304f193c4.var_b048aaa76b661eb8[ var_8c5067d0870248c8 - 1 ];
    }
    
    var_63f5d251ce5e4cc7 = level.var_bb86f77304f193c4.var_b048aaa76b661eb8[ var_8c5067d0870248c8 ];
    var_223e3017a8acb28d = var_63f5d251ce5e4cc7.var_9863884f2d02bf19;
    
    if ( var_223e3017a8acb28d )
    {
        skillbundle = level.skillbundles[ #"health_upgrade" ][ var_223e3017a8acb28d - 1 ];
        
        if ( isdefined( skillbundle ) )
        {
            var_89e0d5bc7859d615 = var_ce441c5dd91822a && var_ce441c5dd91822a.var_9863884f2d02bf19 != var_63f5d251ce5e4cc7.var_9863884f2d02bf19;
            function_3ceb333c50dbd4cb( skillbundle.skillref, skillbundle.skilllevel, undefined, var_cc8f9a53a9ec507f || !var_89e0d5bc7859d615 );
        }
    }
    
    var_3a7fb967d38eca8 = var_63f5d251ce5e4cc7.var_60de73fc67dffea8;
    
    if ( var_3a7fb967d38eca8 )
    {
        skillbundle = level.skillbundles[ #"armor_upgrade" ][ var_3a7fb967d38eca8 - 1 ];
        
        if ( isdefined( skillbundle ) )
        {
            var_89e0d5bc7859d615 = var_ce441c5dd91822a && var_ce441c5dd91822a.var_60de73fc67dffea8 != var_63f5d251ce5e4cc7.var_60de73fc67dffea8;
            function_3ceb333c50dbd4cb( skillbundle.skillref, skillbundle.skilllevel, undefined, var_cc8f9a53a9ec507f || !var_89e0d5bc7859d615 );
        }
    }
    
    var_4e511b604e8b02c8 = var_63f5d251ce5e4cc7.var_e85dfdcd7b1359c8;
    
    if ( var_4e511b604e8b02c8 )
    {
        skillbundle = level.skillbundles[ #"move_speed_upgrade" ][ var_4e511b604e8b02c8 - 1 ];
        
        if ( isdefined( skillbundle ) )
        {
            var_89e0d5bc7859d615 = var_ce441c5dd91822a && var_ce441c5dd91822a.var_e85dfdcd7b1359c8 != var_63f5d251ce5e4cc7.var_e85dfdcd7b1359c8;
            function_3ceb333c50dbd4cb( skillbundle.skillref, skillbundle.skilllevel, undefined, var_cc8f9a53a9ec507f || !var_89e0d5bc7859d615 );
        }
    }
    
    var_51a31e11c3f6b95a = var_63f5d251ce5e4cc7.var_4d17635b3a5e4eae;
    
    if ( var_51a31e11c3f6b95a )
    {
        skillbundle = level.skillbundles[ #"damage_upgrade" ][ var_51a31e11c3f6b95a - 1 ];
        
        if ( isdefined( skillbundle ) )
        {
            var_89e0d5bc7859d615 = var_ce441c5dd91822a && var_ce441c5dd91822a.var_4d17635b3a5e4eae != var_63f5d251ce5e4cc7.var_4d17635b3a5e4eae;
            function_3ceb333c50dbd4cb( skillbundle.skillref, skillbundle.skilllevel, undefined, var_cc8f9a53a9ec507f || !var_89e0d5bc7859d615 );
        }
    }
    
    var_7f056493a27459cb = var_63f5d251ce5e4cc7.var_ce3ce9809563cd53;
    
    if ( var_7f056493a27459cb )
    {
        skillbundle = level.skillbundles[ #"equipment_hound" ][ var_7f056493a27459cb - 1 ];
        
        if ( isdefined( skillbundle ) )
        {
            function_3ceb333c50dbd4cb( skillbundle.skillref, skillbundle.skilllevel, undefined, var_cc8f9a53a9ec507f );
        }
    }
}

// Namespace ob_skills
// Params 1
// Checksum 0xfb382c7a, Offset: 0x6ffd
// Size: 0xa4
function function_eee81c6c2c7fdb3( var_64bb57aa2d6e8b35 )
{
    var_8c5067d0870248c8 = var_64bb57aa2d6e8b35.var_8c5067d0870248c8 ?? 0;
    var_8c5067d0870248c8++;
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        player function_9d7c461c00f2f588( var_8c5067d0870248c8 );
    }
}

// Namespace ob_skills
// Params 0
// Checksum 0xae087f90, Offset: 0x70a9
// Size: 0x2df
function ob_skills_reset()
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
            function_474a08a0c197134( skillref );
        }
    }
    
    if ( self.var_bcde97a1f15e0648 )
    {
        skillrefs = getarraykeys( self.var_bcde97a1f15e0648 );
        
        foreach ( skillref in skillrefs )
        {
            function_474a08a0c197134( skillref );
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
    function_c78e9f8ae3241430( self.powertier );
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

// Namespace ob_skills
// Params 1, eflags: 0x4
// Checksum 0xc04e7301, Offset: 0x7390
// Size: 0x322
function private function_6729084538d6c006( params )
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
        assertmsg( "<dev string:x341>" + startingpoint + "<dev string:x357>" );
        return;
    }
    
    ob_skills_reset();
    self endon( #"skills_reset" );
    playerLevel = levelboost.var_7506069a9d6f2ce ?? 0;
    
    if ( isdefined( prestige ) )
    {
        prestige = int( prestige );
        self.operatorprestige = prestige;
        utility::callsharedfunc( #"ob", #"hash_cc4e2bcf7e45b223" );
        
        if ( prestige > 2 && startingpoint >= 13 )
        {
            playerLevel = 77;
        }
    }
    
    for ( i = 0; i < playerLevel ; i++ )
    {
        ob_power_tier::function_72c580641320b75a( { #points:self.powertiernexttierxp } );
    }
    
    if ( exotics )
    {
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
            skillbundle = getscriptbundlefieldvalues( hashcat( %"skill:", itemref ), [ #"skillref", #"hash_cec10972b7814dd0" ] );
            
            if ( skillbundle.skillref )
            {
                function_3ceb333c50dbd4cb( skillbundle.skillref, skillbundle.var_f463fd4a9608ce51, 1 );
            }
        }
        
        return;
    }
    
    if ( levelboost.jailbreak )
    {
        common_item::function_61c2c0251e742ffd( levelboost.jailbreak, undefined, common_item::items_initspawnoptions_spawnfromentity( self ) );
    }
}

// Namespace ob_skills
// Params 2
// Checksum 0x75726bfa, Offset: 0x76ba
// Size: 0x9c0
function function_3e90b486de426409( params, range )
{
    self notify( #"hash_50c8e227b0a7e4" );
    self endon( #"hash_50c8e227b0a7e4" );
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
            assert( fixedloadout, "<dev string:x370>" );
            break;
        case 1:
            fixedloadout = obsettings.var_8aee522e9d0a8d73[ startingpoint - 1 ];
            assert( fixedloadout, "<dev string:x3a3>" );
            break;
        case 2:
            fixedloadout = obsettings.var_c358acd4b1426868[ startingpoint - 1 ];
            assert( fixedloadout, "<dev string:x3d4>" );
            break;
        case 3:
            fixedloadout = obsettings.heavyloadouts[ startingpoint - 1 ];
            assert( fixedloadout, "<dev string:x406>" );
            break;
    }
    
    if ( isdefined( fixedloadout ) )
    {
        ob_skills_reset();
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
            function_3ceb333c50dbd4cb( var_25eeb74d40ac850.skillref, var_25eeb74d40ac850.skilllevel );
        }
        
        equipmentupgrade = fixedloadout.var_7f056493a27459cb;
        
        if ( equipmentupgrade )
        {
            var_f2bea4b59e0a9d63 = getscriptbundle( equipmentupgrade );
            function_3ceb333c50dbd4cb( var_f2bea4b59e0a9d63.skillref, var_f2bea4b59e0a9d63.skilllevel );
        }
        
        var_ed2582865088ff10 = fixedloadout.var_223e3017a8acb28d;
        
        if ( var_ed2582865088ff10 )
        {
            var_3cae7e4d4201cbc9 = getscriptbundle( var_ed2582865088ff10 );
            function_3ceb333c50dbd4cb( var_3cae7e4d4201cbc9.skillref, var_3cae7e4d4201cbc9.skilllevel );
        }
        
        armorupgrade = fixedloadout.var_3a7fb967d38eca8;
        
        if ( armorupgrade )
        {
            var_17ea5aa551181ce2 = getscriptbundle( armorupgrade );
            function_3ceb333c50dbd4cb( var_17ea5aa551181ce2.skillref, var_17ea5aa551181ce2.skilllevel );
        }
        
        speedupgrade = fixedloadout.var_4e511b604e8b02c8;
        
        if ( speedupgrade )
        {
            var_dee0f6fe0c450382 = getscriptbundle( speedupgrade );
            function_3ceb333c50dbd4cb( var_dee0f6fe0c450382.skillref, var_dee0f6fe0c450382.skilllevel );
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
            var_7e39406e9f90be93 = function_945fd105982c7a2d( skilltrack );
            function_3ceb333c50dbd4cb( var_7e39406e9f90be93.skillref, var_7e39406e9f90be93.skilllevel );
            self.skilltracks[ skilltrack.lootid ] = skilltrack;
            self.tracksshown[ skilltrack.lootid ] = 1;
            self.pers[ "mostRecentSkillTrackLootID" ] = skilltrack.lootid;
            numskills--;
        }
        
        var_ce85a46d49696e2b = getdvarint( @"hash_fa536bc1c4c0d1ac", 0 );
        
        for ( i = 0; i < numskills ; i++ )
        {
            validskills = function_9db2a258fabfc063()[ 0 ];
            validskills = arrayrandomize( validskills );
            skillbundle = validskills[ 0 ];
            
            if ( var_ce85a46d49696e2b )
            {
                function_474a08a0c197134( skillbundle.skill.skillref );
            }
            
            function_3ceb333c50dbd4cb( skillbundle.skill.skillref, skillbundle.skilllevel );
        }
        
        var_2d4bf2d42af5448d = utility::callsharedfunc( #"ob_skill_tracks", #"hash_20f154cc7ce486fe" );
        ob_power_tier::function_69df1bfb965b995d( var_2d4bf2d42af5448d, 0 );
        ob_power_tier::function_75cc84297f5ba7ab();
        self.selectableskills = undefined;
        self.selectabletracks = undefined;
        var_acecf1de8ec2250a = self.operatorprestige < 3 ? 61 : 77;
        
        if ( self.powertier < var_acecf1de8ec2250a )
        {
            function_c78e9f8ae3241430( self.powertier );
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
                skillbundle = getscriptbundlefieldvalues( hashcat( %"skill:", itemref ), [ #"skillref", #"hash_cec10972b7814dd0" ] );
                
                if ( skillbundle.skillref )
                {
                    utility::callsharedfunc( #"skills", #"giveskill", skillbundle.skillref, skillbundle.var_f463fd4a9608ce51, 1 );
                }
            }
        }
    }
}

// Namespace ob_skills
// Params 2, eflags: 0x4
// Checksum 0x2cefde16, Offset: 0x8082
// Size: 0x7e
function private function_673f33f699d531fb( skillref, skilllevel )
{
    if ( !skillref )
    {
        assertmsg( "<dev string:x433>" );
        return;
    }
    
    if ( !isdefined( skilllevel ) )
    {
        assertmsg( "<dev string:x461>" );
        return;
    }
    
    skillbundle = level.skillbundles[ skillref ][ skilllevel ];
    
    if ( !skillbundle )
    {
        assertmsg( "<dev string:x491>" + getxhashsourcename( skillref ) );
        return;
    }
    
    return skillbundle;
}

// Namespace ob_skills
// Params 2
// Checksum 0x5cbab47f, Offset: 0x8109
// Size: 0x80
function function_c204d8ef571d19c0( skillref, skilllevel )
{
    skillbundle = function_673f33f699d531fb( skillref, skilllevel );
    
    if ( !skillbundle )
    {
        assertmsg( "<dev string:x4c5>" + getxhashsourcename( skillref ) );
        return 0;
    }
    
    lootid = skillbundle.lootid;
    
    if ( !isdefined( lootid ) )
    {
        assertmsg( "<dev string:x4f9>" + getxhashsourcename( skillref ) );
        return 0;
    }
    
    return lootid;
}

// Namespace ob_skills
// Params 2
// Checksum 0x3b0fffdb, Offset: 0x8192
// Size: 0x82
function function_84e3ce8b5ae14ff( skillref, skilllevel )
{
    skillbundle = function_673f33f699d531fb( skillref, skilllevel );
    
    if ( !skillbundle )
    {
        assertmsg( "<dev string:x529>" + getxhashsourcename( skillref ) );
        return;
    }
    
    skillcategory = skillbundle.skillcategory;
    
    if ( !isxhash( skillbundle.skillcategory ) )
    {
        skillcategory = tolower( skillcategory );
        skillcategory = getxhash( skillcategory );
    }
    
    return skillcategory;
}

// Namespace ob_skills
// Params 2
// Checksum 0xda2da452, Offset: 0x821d
// Size: 0x59
function function_feeccf386ffe759c( skillref, skilllevel )
{
    skillbundle = function_673f33f699d531fb( skillref, skilllevel );
    
    if ( !skillbundle )
    {
        assertmsg( "<dev string:x55f>" + getxhashsourcename( skillref ) );
        return;
    }
    
    return loot::function_c09d31266119497d( skillbundle.rarity );
}

// Namespace ob_skills
// Params 1
// Checksum 0x1eadb140, Offset: 0x827f
// Size: 0x40
function function_6b10df256881fc0b( weapon )
{
    var_5e9f79c4da501125 = level.var_7b319720bc04b783[ weapon.basenamehash ];
    
    if ( !var_5e9f79c4da501125 )
    {
        var_5e9f79c4da501125 = self.skillref;
    }
    
    return var_5e9f79c4da501125;
}

/#

    // Namespace ob_skills
    // Params 0, eflags: 0x4
    // Checksum 0xf45d1e50, Offset: 0x82c8
    // Size: 0x15, Type: dev
    function private function_32b77c2b9dea06a8()
    {
        function_4be523713b8258fe( level.players );
    }

    // Namespace ob_skills
    // Params 0, eflags: 0x4
    // Checksum 0xc44ee27f, Offset: 0x82e5
    // Size: 0x191, Type: dev
    function private initdev()
    {
        var_2007867e0cbe557a = game_utility::getgametype() != "<dev string:x598>";
        
        if ( var_2007867e0cbe557a )
        {
            devgui::function_9082edeb5db93280( "<dev string:x59b>" );
            devgui::add_devgui_command( "<dev string:x5a6>", "<dev string:x5b1>", -1 );
            devgui::add_devgui_func( "<dev string:x5d1>", "<dev string:x5dd>", &function_32b77c2b9dea06a8 );
            
            foreach ( skillref, var_eb5c88c4a11f25e8 in level.skillbundles )
            {
                skillname = getxhashsourcename( skillref );
                
                foreach ( tier, skill in var_eb5c88c4a11f25e8 )
                {
                    devgui::add_devgui_command( "<dev string:x5f5>" + skillname + "<dev string:x5fd>" + tier, "<dev string:x604>" + skillname + "<dev string:x620>" + tier );
                }
                
                devgui::add_devgui_command( "<dev string:x5f5>" + skillname + "<dev string:x640>", "<dev string:x648>" + skillname + "<dev string:x666>", -1 );
            }
            
            devgui::function_77df7fe7dd273e10();
        }
    }

#/

// Namespace ob_skills
// Params 0, eflags: 0x4
// Checksum 0xc64db739, Offset: 0x847e
// Size: 0x1a9
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
            thread function_5a1b92e3376e1474( cheatplayers, cheat_dvars[ #"bot_give_skill_ref" ], cheat_dvars[ #"bot_give_skill_level" ] );
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

// Namespace ob_skills
// Params 0, eflags: 0x4
// Checksum 0xaad35dae, Offset: 0x862f
// Size: 0x101
function private function_d736a179632efa58()
{
    return [ #"remove_all_skills":utility::consume_dvar_int( @"hash_30a3678cc73f1aa1", 0 ), #"remove_skill_ref":utility::consume_dvar( @"hash_1bac5623d57e81ca", "" ), #"hash_7d092ae22f70fefb":utility::consume_dvar_int( @"hash_535db081daa5b42c", -1 ), #"hash_da710ec657b72064":utility::consume_dvar( @"hash_ab9bdc6dc145907f", "" ), #"hash_61eb7867d1ed9bc6":utility::consume_dvar_int( @"hash_92c78b461a5a751c", -1 ), #"bot_give_skill_level":utility::consume_dvar_int( @"bot_give_skill_level", -1 ), #"give_skill_level":utility::consume_dvar_int( @"cheat_give_skill_level", -1 ), #"bot_give_skill_ref":utility::consume_dvar( @"cheat_bot_give_skill_ref", "" ), #"give_skill_ref":utility::consume_dvar( @"cheat_give_skill_ref", "" ) ];
}

// Namespace ob_skills
// Params 3, eflags: 0x4
// Checksum 0x8dd453c2, Offset: 0x8739
// Size: 0xe8
function private function_5a1b92e3376e1474( cheatplayers, give_skill_ref, skill_level )
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
            target_bot function_474a08a0c197134( give_skill_ref_hash );
        }
        
        target_bot function_3ceb333c50dbd4cb( give_skill_ref_hash, skill_level );
        waitframe();
    }
}

// Namespace ob_skills
// Params 3, eflags: 0x4
// Checksum 0xcf30641e, Offset: 0x8829
// Size: 0x154
function private function_cfaedd2455abc1a4( cheatplayers, give_skill_ref, skill_level )
{
    give_skill_ref_xhash = getxhash( give_skill_ref );
    var_ce85a46d49696e2b = getdvarint( @"hash_fa536bc1c4c0d1ac", 0 );
    
    if ( var_ce85a46d49696e2b )
    {
        foreach ( cheatplayer in cheatplayers )
        {
            cheatplayer function_474a08a0c197134( give_skill_ref_xhash );
        }
        
        waitframe();
    }
    
    foreach ( cheatplayer in cheatplayers )
    {
        cheatplayer function_3ceb333c50dbd4cb( give_skill_ref_xhash, skill_level );
        cheatplayer iprintlnbold( "Granted skill: " + give_skill_ref + ", Tier " + skill_level + " (player facing: Tier " + skill_level + 1 + ")" );
        waitframe();
    }
}

// Namespace ob_skills
// Params 3, eflags: 0x4
// Checksum 0xf0f05a4c, Offset: 0x8985
// Size: 0x154
function private function_3545c4fa07d9cd97( cheatplayers, var_4cbe115296f90f3, ability_upgrade_level )
{
    var_868f8bff659ca714 = getxhash( var_4cbe115296f90f3 );
    var_ce85a46d49696e2b = getdvarint( @"hash_fa536bc1c4c0d1ac", 0 );
    
    if ( var_ce85a46d49696e2b )
    {
        foreach ( cheatplayer in cheatplayers )
        {
            cheatplayer function_474a08a0c197134( var_868f8bff659ca714 );
        }
        
        waitframe();
    }
    
    foreach ( cheatplayer in cheatplayers )
    {
        cheatplayer function_3ceb333c50dbd4cb( var_868f8bff659ca714, ability_upgrade_level );
        cheatplayer iprintlnbold( "Granted skill: " + var_4cbe115296f90f3 + ", Tier " + ability_upgrade_level + " (player facing: Tier " + ability_upgrade_level + 1 + ")" );
        waitframe();
    }
}

// Namespace ob_skills
// Params 2, eflags: 0x4
// Checksum 0xdaada717, Offset: 0x8ae1
// Size: 0xa8
function private function_22135cc918df2af5( cheatplayers, remove_skill_ref )
{
    var_4fb7081d1f621291 = getxhash( remove_skill_ref );
    
    foreach ( cheatplayer in cheatplayers )
    {
        cheatplayer function_474a08a0c197134( var_4fb7081d1f621291 );
        cheatplayer iprintlnbold( "Removed skill: " + remove_skill_ref );
        waitframe();
    }
}

// Namespace ob_skills
// Params 1, eflags: 0x4
// Checksum 0x8b273c7b, Offset: 0x8b91
// Size: 0x8b
function private function_60478782bf766bd5( cheatplayers )
{
    foreach ( cheatplayer in cheatplayers )
    {
        cheatplayer function_39e0389c640eb3b8();
        cheatplayer iprintlnbold( "Removed all skills" );
        waitframe();
    }
}

