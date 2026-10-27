// script_2fe74ee229c972c3  (hash_2fe74ee229c972c3.gscc) (size: 12926 Bytes / 0x327e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x605bf731 (1616639793)
// size ...... 12926 (0x327e)
// includes .. 7   (offset: 0x2fd6)
// strings ... 10  (offset: 0x300e)
// dev strs .. 39  (offset: 0x308e)
// exports ... 27  (offset: 0x20fa)
// cseg ...... 0xf8 + 0x2002 (0x20fa)
// imports ... 85  (offset: 0x2532)
// animtree1 . 0   (offset: 0x327e)
// animtree2 . 0   (offset: 0x327e)
#using script_59143e62a1ecdc59;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\supers;

#namespace shared_skills;

// Namespace shared_skills
// Params 0, eflags: 0x1
// Checksum 0x16bd3cb0, Offset: 0x116
// Size: 0x26d
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
    
    level.skillbundles = [];
    level.var_7b319720bc04b783 = [];
    var_53186a089b55f4a4 = level.gametypebundle.skills.skill_list ?? level.gamemodebundle.skill_list;
    
    if ( isdefined( var_53186a089b55f4a4 ) )
    {
        var_f86fde98285acb67 = getscriptbundle( var_53186a089b55f4a4 );
        assert( isdefined( var_f86fde98285acb67 ), getxhashsourcename( var_53186a089b55f4a4 ) + "<dev string:x24>" );
        skills = var_f86fde98285acb67.skills ?? [];
        
        foreach ( index, skill_struct in skills )
        {
            skill = skill_struct.skill;
            
            if ( skill )
            {
                level function_1c254b725136220f( skill, index );
            }
        }
        
        var_f6815ee7c02481fd = var_f86fde98285acb67.var_f6815ee7c02481fd ?? [];
        
        foreach ( index, skill_struct in var_f6815ee7c02481fd )
        {
            skill = skill_struct.skill;
            
            if ( skill )
            {
                level function_1c254b725136220f( skill, index );
            }
        }
    }
    
    /#
        level thread function_6e917301c3abad5();
    #/
    
    level.skills_init = &init;
    
    if ( level.gametypebundle.var_858d230de58cc743 )
    {
        level.var_858d230de58cc743 = getscriptbundle( level.gametypebundle.var_858d230de58cc743 );
    }
    
    /#
        initdev();
    #/
    
    if ( getbuildversion() != "SHIP" )
    {
        level thread function_60251d3506f7495();
    }
}

// Namespace shared_skills
// Params 2, eflags: 0x4
// Checksum 0xf2a6c55d, Offset: 0x38b
// Size: 0x157
function private function_1c254b725136220f( skill, skillindex )
{
    skillbundle = getscriptbundle( skill );
    skillbundle = function_12555e7d94002a8( skillbundle );
    assert( skillbundle, getxhashsourcename( skill ) + "<dev string:x3b>" );
    
    if ( !skillbundle )
    {
        return;
    }
    
    skillbundle.index = skillindex;
    assert( !level.skillbundles[ skillbundle.skillref ][ skillbundle.skilllevel ], getxhashsourcename( skillbundle.skillref ) + "<dev string:x54>" + skillbundle.skilllevel + "<dev string:x67>" + getxhashsourcename( skill ) + "<dev string:x80>" );
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

// Namespace shared_skills
// Params 0
// Checksum 0x711c2951, Offset: 0x4eb
// Size: 0x132
function init()
{
    foreach ( skillinit in level.var_86bd886a4ac78dd8 )
    {
        [[ skillinit ]]();
    }
    
    namespace_64a89dd78801462c::init();
    level function_4b29bd1a99467937();
    level function_b0164324d65dff5();
    level callback::add( #"player_death", &skills_on_player_death );
    level callback::add( #"player_spawned", &skills_on_player_spawn );
    utility::registersharedfunc( #"skills", #"giveskill", &skills_giveskill );
    utility::registersharedfunc( #"skills", #"removeskill", &function_9e89d12cb994c6e2 );
    utility::registersharedfunc( #"skills", #"hash_caf936d46b7e8c96", &function_8d4955e34f89528a );
    utility::registersharedfunc( #"skills", #"hash_6dc9835d47a52b35", &function_9806153ccc39456e );
}

// Namespace shared_skills
// Params 2
// Checksum 0x31921b94, Offset: 0x625
// Size: 0x8e
function function_b667da63ece9b966( var_ad2af75586eccea4, initfunc )
{
    if ( !isxhash( var_ad2af75586eccea4 ) )
    {
        assertmsg( var_ad2af75586eccea4 + "<dev string:x82>" );
        return;
    }
    
    if ( !isfunction( initfunc ) )
    {
        assertmsg( "<dev string:x9b>" );
        return;
    }
    
    if ( !isdefined( level.var_86bd886a4ac78dd8 ) )
    {
        level.var_86bd886a4ac78dd8 = [];
    }
    
    assert( !isdefined( level.var_86bd886a4ac78dd8[ var_ad2af75586eccea4 ] ), getxhashsourcename( var_ad2af75586eccea4 ) + "<dev string:xe7>" );
    level.var_86bd886a4ac78dd8[ var_ad2af75586eccea4 ] = initfunc;
}

// Namespace shared_skills
// Params 1, eflags: 0x4
// Checksum 0x351645ea, Offset: 0x6bb
// Size: 0x132
function private function_12555e7d94002a8( scriptbundle )
{
    if ( !isstruct( scriptbundle ) )
    {
        assert( "<dev string:xfc>" );
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

// Namespace shared_skills
// Params 0, eflags: 0x4
// Checksum 0x19a2b12b, Offset: 0x7f6
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
                assert( isarray( skillsweapons ), "<dev string:x122>" );
                
                foreach ( weapon in skillsweapons )
                {
                    level.var_7b319720bc04b783[ getxhashasset( weapon ) ] = skillref;
                }
            }
        }
    }
}

// Namespace shared_skills
// Params 0, eflags: 0x4
// Checksum 0x70776aca, Offset: 0x993
// Size: 0x10d
function private function_4b29bd1a99467937()
{
    foreach ( skillref, skilllevels in level.skillbundles )
    {
        exists = utility::issharedfuncdefined( skillref, #"hash_f89602d29c289ca4" );
        
        if ( exists )
        {
            foreach ( skillbundle in skilllevels )
            {
                utility::callsharedfunc( skillref, #"hash_f89602d29c289ca4", skillbundle );
            }
        }
    }
}

// Namespace shared_skills
// Params 1, eflags: 0x4
// Checksum 0x2d887d8c, Offset: 0xaa8
// Size: 0x9b
function private skills_on_player_death( params )
{
    self.var_1f7050a4c29b6a13 = arraycopy( self.activeskills );
    
    foreach ( skillref, rarity in self.activeskills )
    {
        function_9e89d12cb994c6e2( skillref );
    }
}

// Namespace shared_skills
// Params 1, eflags: 0x4
// Checksum 0x31395cce, Offset: 0xb4b
// Size: 0x1e4
function private skills_on_player_spawn( params )
{
    /#
        thread function_9adca665ae5e6f01();
    #/
    
    if ( !params.revivespawn )
    {
        self.activeskills = [];
    }
    
    if ( params.revivespawn )
    {
        if ( isdefined( self.var_1f7050a4c29b6a13 ) && self.var_1f7050a4c29b6a13.size > 0 )
        {
            waitframe();
            
            foreach ( skillref, rarity in self.var_1f7050a4c29b6a13 )
            {
                skills_giveskill( skillref, rarity, 1, 1 );
            }
            
            self.var_1f7050a4c29b6a13 = undefined;
        }
        
        return;
    }
    
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
                skills_giveskill( skillbundle.skillref, skillbundle.skilllevel, undefined, 1 );
                
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

// Namespace shared_skills
// Params 2, eflags: 0x4
// Checksum 0xcdc528, Offset: 0xd37
// Size: 0x7d
function private function_ca32a1f7793ee661( skillref, skilllevel )
{
    if ( self.isdisconnecting )
    {
        return 1;
    }
    
    namespace_64a89dd78801462c::function_4b8f034991c3fe5d( skillref, skilllevel );
    
    if ( utility::issharedfuncdefined( skillref, #"ongiveskill" ) )
    {
        skillbundle = level.skillbundles[ skillref ][ skilllevel ];
        success = [[ utility::getsharedfunc( skillref, #"ongiveskill" ) ]]( skillbundle );
    }
    
    return success;
}

// Namespace shared_skills
// Params 4, eflags: 0x4
// Checksum 0x223b51de, Offset: 0xdbd
// Size: 0x378
function private function_d9de377beb1143bf( skillref, skilllevel, var_fbd8edb1f5026b96, var_cc8f9a53a9ec507f = 0 )
{
    assert( isdefined( level.skillbundles[ skillref ] ), getxhashsourcename( skillref ) + "<dev string:x14a>" );
    assert( isdefined( level.skillbundles[ skillref ][ skilllevel ] ), skilllevel + "<dev string:x161>" + getxhashsourcename( skillref ) + "<dev string:x17c>" );
    
    if ( !isplayer( self ) )
    {
        assertmsg( "<dev string:x184>" );
        return;
    }
    
    activeskills = self.activeskills ?? [];
    
    if ( activeskills[ skillref ] && activeskills[ skillref ] == skilllevel )
    {
        if ( !var_fbd8edb1f5026b96 )
        {
            assertmsg( "<dev string:x19a>" + getxhashsourcename( skillref ) + "<dev string:x1af>" + skilllevel + "<dev string:x1ba>" );
        }
        
        return;
    }
    
    skilldata = level.skillbundles[ skillref ][ skilllevel ];
    
    if ( skilldata.abilityref )
    {
        var_85570ee8e79f6945 = skilldata.abilityref == supers_mp::getcurrentsuperref( #"tactical" );
        var_c9b3cfa3b72ad9f1 = skilldata.abilityref == supers_mp::getcurrentsuperref( #"default" );
        
        if ( !var_85570ee8e79f6945 && !var_c9b3cfa3b72ad9f1 )
        {
            assertmsg( getxhashsourcename( skilldata.abilityref ) + "<dev string:x1d8>" + getxhashsourcename( skillref ) );
            return;
        }
        
        slot = var_c9b3cfa3b72ad9f1 ? #"default" : #"tactical";
        var_28328bfa2117a938 = supers_mp::getsuperpointsneeded( undefined, slot );
    }
    
    success = function_ca32a1f7793ee661( skillref, skilllevel );
    
    if ( success )
    {
        activeskills[ skillref ] = skilllevel;
        
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
        
        if ( var_28328bfa2117a938 )
        {
            var_b05a7f83f28e157c = supers_mp::getsuperpointsneeded( undefined, slot );
            namespace_64a89dd78801462c::function_6a7d11fd91f732df( slot, var_28328bfa2117a938, var_b05a7f83f28e157c );
        }
        
        level callback::callback( #"skill_acquired", { #var_cc8f9a53a9ec507f:var_cc8f9a53a9ec507f, #player:self, #skilllevel:skilllevel, #skillref:skillref } );
    }
    
    self.activeskills = activeskills;
    return success;
}

// Namespace shared_skills
// Params 1, eflags: 0x4
// Checksum 0x61e126ba, Offset: 0x113e
// Size: 0x1ee
function private function_ecff4f9b685d17a8( skillref )
{
    assert( isdefined( level.skillbundles[ skillref ] ), getxhashsourcename( skillref ) + "<dev string:x14a>" );
    
    if ( !isplayer( self ) )
    {
        assertmsg( "<dev string:x184>" );
        return;
    }
    
    skilllevel = self.activeskills[ skillref ];
    
    if ( !isdefined( skilllevel ) )
    {
        return;
    }
    
    skilldata = level.skillbundles[ skillref ][ skilllevel ];
    
    if ( skilldata )
    {
        if ( skilldata.abilityref )
        {
            var_85570ee8e79f6945 = skilldata.abilityref == supers_mp::getcurrentsuperref( #"tactical" );
            var_c9b3cfa3b72ad9f1 = skilldata.abilityref == supers_mp::getcurrentsuperref( #"default" );
            
            if ( !var_85570ee8e79f6945 && !var_c9b3cfa3b72ad9f1 )
            {
                assertmsg( getxhashsourcename( skilldata.abilityref ) + "<dev string:x1d8>" + getxhashsourcename( skillref ) );
                return;
            }
            
            slot = var_c9b3cfa3b72ad9f1 ? #"default" : #"tactical";
            var_b05a7f83f28e157c = supers_mp::getsuperpointsneeded( undefined, slot );
        }
        
        if ( utility::issharedfuncdefined( skillref, #"hash_4aa03f4559ac50a5" ) )
        {
            skillbundle = level.skillbundles[ skillref ][ skilllevel ];
            [[ utility::getsharedfunc( skillref, #"hash_4aa03f4559ac50a5" ) ]]( skillbundle );
        }
        
        namespace_64a89dd78801462c::function_c399dada8a4f94b2( skillref );
        level callback::callback( #"skill_removed", { #player:self, #skilllevel:skilllevel, #skillref:skillref } );
        
        if ( var_b05a7f83f28e157c )
        {
            var_28328bfa2117a938 = supers_mp::getsuperpointsneeded( undefined, slot );
            namespace_64a89dd78801462c::function_6a7d11fd91f732df( slot, var_b05a7f83f28e157c, var_28328bfa2117a938 );
        }
    }
    
    self.activeskills[ skillref ] = undefined;
}

// Namespace shared_skills
// Params 4, eflags: 0x4
// Checksum 0x53ee3369, Offset: 0x1334
// Size: 0x3b
function private skills_giveskill( skillref, skilllevel, var_fbd8edb1f5026b96, var_cc8f9a53a9ec507f = 0 )
{
    return function_d9de377beb1143bf( skillref, skilllevel, var_fbd8edb1f5026b96, var_cc8f9a53a9ec507f );
}

// Namespace shared_skills
// Params 1, eflags: 0x4
// Checksum 0x9cd4313e, Offset: 0x1378
// Size: 0x15
function private function_9e89d12cb994c6e2( skillref )
{
    function_ecff4f9b685d17a8( skillref );
}

// Namespace shared_skills
// Params 0, eflags: 0x4
// Checksum 0x14e674b4, Offset: 0x1395
// Size: 0x7b
function private function_8d4955e34f89528a()
{
    foreach ( skillref, skilllevel in self.activeskills )
    {
        function_9e89d12cb994c6e2( skillref );
    }
}

// Namespace shared_skills
// Params 1, eflags: 0x4
// Checksum 0x6655f80a, Offset: 0x1418
// Size: 0x92
function private function_9806153ccc39456e( skillref )
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

/#

    // Namespace shared_skills
    // Params 0, eflags: 0x4
    // Checksum 0x41c68d1c, Offset: 0x14b3
    // Size: 0x17b, Type: dev
    function private initdev()
    {
        var_2007867e0cbe557a = game_utility::getgametype() != "<dev string:x1ef>";
        
        if ( var_2007867e0cbe557a )
        {
            devgui::function_9082edeb5db93280( "<dev string:x1f2>" );
            devgui::add_devgui_command( "<dev string:x1fd>", "<dev string:x208>", -1 );
            
            foreach ( skillref, var_eb5c88c4a11f25e8 in level.skillbundles )
            {
                skillname = getxhashsourcename( skillref );
                
                foreach ( tier, skill in var_eb5c88c4a11f25e8 )
                {
                    devgui::add_devgui_command( "<dev string:x228>" + skillname + "<dev string:x230>" + tier, "<dev string:x237>" + skillname + "<dev string:x253>" + tier );
                }
                
                devgui::add_devgui_command( "<dev string:x228>" + skillname + "<dev string:x273>", "<dev string:x27b>" + skillname + "<dev string:x299>", -1 );
            }
            
            devgui::function_77df7fe7dd273e10();
        }
    }

#/

// Namespace shared_skills
// Params 0, eflags: 0x4
// Checksum 0x500ac799, Offset: 0x1636
// Size: 0x17f
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
            thread function_cfaedd2455abc1a4( cheatplayers, cheat_dvars[ #"give_skill_ref" ], cheat_dvars[ #"give_skill_level" ], cheat_dvars[ #"hash_61eb7867d1ed9bc6" ] );
        }
        
        if ( cheat_dvars[ #"bot_give_skill_ref" ] )
        {
            thread function_5a1b92e3376e1474( cheatplayers, cheat_dvars[ "bot_give_skill_ref" ], cheat_dvars[ "bot_give_skill_level" ] );
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

// Namespace shared_skills
// Params 0, eflags: 0x4
// Checksum 0x68db2ba7, Offset: 0x17bd
// Size: 0xc8
function private function_d736a179632efa58()
{
    return [ #"remove_all_skills":utility::consume_dvar_int( @"hash_30a3678cc73f1aa1", 0 ), #"remove_skill_ref":utility::consume_dvar( @"hash_1bac5623d57e81ca", "" ), #"hash_61eb7867d1ed9bc6":utility::consume_dvar_int( @"hash_92c78b461a5a751c", -1 ), #"bot_give_skill_level":utility::consume_dvar_int( @"bot_give_skill_level", -1 ), #"give_skill_level":utility::consume_dvar_int( @"cheat_give_skill_level", -1 ), #"bot_give_skill_ref":utility::consume_dvar( @"cheat_bot_give_skill_ref", "" ), #"give_skill_ref":utility::consume_dvar( @"cheat_give_skill_ref", "" ) ];
}

// Namespace shared_skills
// Params 4, eflags: 0x4
// Checksum 0xfaf3c7cd, Offset: 0x188e
// Size: 0xf1
function private function_5a1b92e3376e1474( cheatplayers, give_skill_ref, skill_level, is_exotic )
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
            target_bot function_9e89d12cb994c6e2( give_skill_ref_hash );
        }
        
        target_bot skills_giveskill( give_skill_ref_hash, skill_level );
        waitframe();
    }
}

// Namespace shared_skills
// Params 4, eflags: 0x4
// Checksum 0x2db555e4, Offset: 0x1987
// Size: 0x15d
function private function_cfaedd2455abc1a4( cheatplayers, give_skill_ref, skill_level, is_exotic )
{
    give_skill_ref_xhash = getxhash( give_skill_ref );
    var_ce85a46d49696e2b = getdvarint( @"hash_fa536bc1c4c0d1ac", 0 );
    
    if ( var_ce85a46d49696e2b )
    {
        foreach ( cheatplayer in cheatplayers )
        {
            cheatplayer function_9e89d12cb994c6e2( give_skill_ref_xhash );
        }
        
        waitframe();
    }
    
    foreach ( cheatplayer in cheatplayers )
    {
        cheatplayer skills_giveskill( give_skill_ref_xhash, skill_level );
        cheatplayer iprintlnbold( "Granted skill: " + give_skill_ref + ", Tier " + skill_level + " (player facing: Tier " + skill_level + 1 + ")" );
        waitframe();
    }
}

// Namespace shared_skills
// Params 2, eflags: 0x4
// Checksum 0xf390d4fa, Offset: 0x1aec
// Size: 0xa8
function private function_22135cc918df2af5( cheatplayers, remove_skill_ref )
{
    var_4fb7081d1f621291 = getxhash( remove_skill_ref );
    
    foreach ( cheatplayer in cheatplayers )
    {
        cheatplayer function_9e89d12cb994c6e2( var_4fb7081d1f621291 );
        cheatplayer iprintlnbold( "Removed skill: " + remove_skill_ref );
        waitframe();
    }
}

// Namespace shared_skills
// Params 1, eflags: 0x4
// Checksum 0x8165f3c0, Offset: 0x1b9c
// Size: 0x8b
function private function_60478782bf766bd5( cheatplayers )
{
    foreach ( cheatplayer in cheatplayers )
    {
        cheatplayer function_8d4955e34f89528a();
        cheatplayer iprintlnbold( "Removed all skills" );
        waitframe();
    }
}

/#

    // Namespace shared_skills
    // Params 0, eflags: 0xc
    // Checksum 0xab01d641, Offset: 0x1c2f
    // Size: 0x65, Type: dev
    function private function_6e917301c3abad5()
    {
        self notify( #"hash_97ad6958db771538" );
        self endon( #"hash_97ad6958db771538" );
        
        while ( true )
        {
            level waittill( #"hash_7e967560bc92fa01", var_facf97ba9e42d82d );
            
            if ( var_facf97ba9e42d82d.asset_type == "<dev string:x29b>" )
            {
                level function_3ab5bc39b45bbce7( var_facf97ba9e42d82d.asset_name );
            }
        }
    }

    // Namespace shared_skills
    // Params 1, eflags: 0x4
    // Checksum 0xc0660a70, Offset: 0x1c9c
    // Size: 0x102, Type: dev
    function private function_3ab5bc39b45bbce7( skill )
    {
        skillbundle = getscriptbundle( skill );
        players = level.players;
        
        foreach ( player in players )
        {
            activeskills = player.activeskills;
            skillref = skillbundle.skillref;
            skilllevel = skillbundle.skilllevel;
            
            if ( activeskills[ skillref ] && activeskills[ skillref ] == skilllevel )
            {
                player function_9e89d12cb994c6e2( skillref );
                waitframe();
                player skills_giveskill( skillref, skilllevel );
            }
        }
    }

    // Namespace shared_skills
    // Params 0, eflags: 0xc
    // Checksum 0xc6f0b447, Offset: 0x1da6
    // Size: 0x354, Type: dev
    function private function_9adca665ae5e6f01()
    {
        self notify( #"hash_23a22a448267223b" );
        self endon( #"hash_23a22a448267223b" );
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
                hudelem.alignx = "<dev string:x2a1>";
                hudelem.aligny = "<dev string:x2a6>";
                hudelem.x = 30;
                hudelem.y = 20;
                hudelem.foreground = 1;
                hudelem.color = ( 1, 1, 1 );
                hudelem.fontscale = 0.75;
                self.var_c821c4f78b8f4ca5 = hudelem;
            }
            
            msgtext = "<dev string:x2aa>";
            activeskills = self.activeskills;
            
            if ( activeskills.size )
            {
                msgtext = "<dev string:x2bb>";
                
                foreach ( key, var_d31f0d4f00dc5b64 in activeskills )
                {
                    msgtext = msgtext + getxhashsourcename( key ) + "<dev string:x2d0>" + var_d31f0d4f00dc5b64 + 1 + "<dev string:x2d4>";
                }
            }
            
            activeskills = self.activeskills;
            
            if ( activeskills.size )
            {
                msgtext += "<dev string:x2d6>";
                
                foreach ( key, var_d31f0d4f00dc5b64 in activeskills )
                {
                    msgtext = msgtext + getxhashsourcename( key ) + "<dev string:x2d0>" + var_d31f0d4f00dc5b64 + 1 + "<dev string:x2d4>";
                }
            }
            
            if ( self.skilltracks.size )
            {
                msgtext += "<dev string:x2e1>";
                
                foreach ( trackdata in self.skilltracks )
                {
                    msgtext = msgtext + getxhashsourcename( trackdata.name ) + "<dev string:x2d4>";
                }
            }
            
            if ( ( var_490ecec605775920 ?? "<dev string:x2ec>" ) != msgtext )
            {
                hudelem setdevtext( msgtext );
            }
        }
    }

#/
