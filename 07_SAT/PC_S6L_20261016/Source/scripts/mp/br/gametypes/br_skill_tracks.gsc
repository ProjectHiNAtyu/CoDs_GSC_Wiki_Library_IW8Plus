// scripts\mp\br\gametypes\br_skill_tracks.gsc  (hash_0f7379e1a7ba288a.gscc) (size: 6972 Bytes / 0x1b3c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x4ecc40f8 (1322008824)
// size ...... 6972 (0x1b3c)
// includes .. 6   (offset: 0x1a24)
// strings ... 11  (offset: 0x1a54)
// dev strs .. 5   (offset: 0x1b00)
// exports ... 17  (offset: 0x11f8)
// cseg ...... 0x139 + 0x10bf (0x11f8)
// imports ... 45  (offset: 0x14a0)
// animtree1 . 0   (offset: 0x1b3c)
// animtree2 . 0   (offset: 0x1b3c)
#using script_2fe74ee229c972c3;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\mp\br\br_upgrade_splash;
#using scripts\mp\flags;

#namespace br_skill_tracks;

// Namespace br_skill_tracks
// Params 0, eflags: 0x1
// Checksum 0xa74205a9, Offset: 0x157
// Size: 0x225
function autoexec main()
{
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
            function_139571626b6f3228( skilltrack );
            level.skilltracklist[ level.skilltracklist.size ] = skilltrack;
            
            if ( track.var_d37e61d21c0a2c77 )
            {
                level.var_4c1500769aa35467 = skilltrack;
            }
        }
    }
    
    if ( !level.gametypebundle.var_858d230de58cc743 )
    {
        return;
    }
    
    level.var_858d230de58cc743 = getscriptbundle( level.gametypebundle.var_858d230de58cc743 );
    assert( isdefined( level.var_858d230de58cc743 ), getxhashsourcename( level.gametypebundle.var_858d230de58cc743 ) + "<dev string:x40>" );
}

// Namespace br_skill_tracks
// Params 0
// Checksum 0xcbb099be, Offset: 0x384
// Size: 0x8e
function init()
{
    level callback::add( #"player_spawned", &function_2c71ae5a1d3d4c5 );
    level callback::add( #"player_death", &function_c31f710b0ba9dd34 );
    level callback::add( #"elimination_assist", &function_43a742577557b6a4 );
    utility::registersharedfunc( #"bots", #"hash_312dd93312ce98a6", &function_685687c49b437d67 );
    
    /#
        devgui::function_9082edeb5db93280( "<dev string:x65>" );
        devgui::add_devgui_func( "<dev string:x76>", "<dev string:x97>", &function_9a2320d825dc7a24 );
        devgui::function_77df7fe7dd273e10();
    #/
}

// Namespace br_skill_tracks
// Params 1, eflags: 0x4
// Checksum 0xc8a2276, Offset: 0x41a
// Size: 0x119
function private function_139571626b6f3228( skilltrack )
{
    foreach ( var_f8792fbd70e36a4f in skilltrack.skills )
    {
        foreach ( skill in var_f8792fbd70e36a4f.skills )
        {
            if ( skill.disabled )
            {
                var_f8792fbd70e36a4f.skills = arrayremove( var_f8792fbd70e36a4f.skills, skill );
            }
        }
    }
}

// Namespace br_skill_tracks
// Params 2, eflags: 0x4
// Checksum 0xb0b2aeee, Offset: 0x53b
// Size: 0x2dc
function private function_141b75ad9f2d4c95( player, targetlevel )
{
    if ( !level.var_4c1500769aa35467 || targetlevel <= 0 )
    {
        return;
    }
    
    for ( tier = 0; tier < targetlevel ; tier++ )
    {
        var_f8792fbd70e36a4f = level.var_4c1500769aa35467.skills[ tier ];
        
        if ( !var_f8792fbd70e36a4f )
        {
            continue;
        }
        
        targetskills = undefined;
        
        if ( var_f8792fbd70e36a4f.randomize )
        {
            var_484115a92739f1bf = var_f8792fbd70e36a4f.numskills ?? 1;
            var_1d4636e797eb6ee1 = var_f8792fbd70e36a4f.skills.size;
            
            if ( var_484115a92739f1bf < var_1d4636e797eb6ee1 )
            {
                targetskills = [];
                keys = [];
                
                for ( i = 0; i < var_1d4636e797eb6ee1 ; i++ )
                {
                    keys[ i ] = i;
                }
                
                for ( i = 0; i < var_484115a92739f1bf ; i++ )
                {
                    var_5567d6fb509da7b8 = randomintrange( 0, var_1d4636e797eb6ee1 );
                    randomkey = keys[ var_5567d6fb509da7b8 ];
                    randomskill = var_f8792fbd70e36a4f.skills[ randomkey ];
                    targetskills[ targetskills.size ] = randomskill;
                    
                    if ( var_5567d6fb509da7b8 != var_1d4636e797eb6ee1 - 1 )
                    {
                        keys[ var_5567d6fb509da7b8 ] = keys[ var_1d4636e797eb6ee1 - 1 ];
                    }
                    
                    var_1d4636e797eb6ee1--;
                }
            }
        }
        
        if ( !isdefined( targetskills ) )
        {
            targetskills = var_f8792fbd70e36a4f.skills;
        }
        
        var_b79e5a3b46cae70 = 0;
        
        foreach ( skill in targetskills )
        {
            player function_d2dbc96fdcba3144( skill.skillbundle, 0 );
            
            if ( !var_b79e5a3b46cae70 && player.var_b713638c1bc12dc7.size < 18 )
            {
                skillbundle = getscriptbundle( skill.skillbundle );
                
                if ( skillbundle && !skillbundle.disabled )
                {
                    splashindex = level.skillbundles[ skillbundle.skillref ][ skillbundle.skilllevel ].index + 1;
                    slot = player.var_b713638c1bc12dc7.size + 1;
                    player.var_b713638c1bc12dc7[ player.var_b713638c1bc12dc7.size ] = splashindex;
                    var_b79e5a3b46cae70 = 1;
                }
            }
        }
    }
    
    player.skilllevel = targetlevel;
    player setscriptablepartstate( "skill_track_level_up", "tier_" + player.skilllevel + "_down", 0 );
    function_e5480129ccf79226( player );
}

// Namespace br_skill_tracks
// Params 2
// Checksum 0x8898c574, Offset: 0x81f
// Size: 0xf2
function function_51220390e8a3c1f5( player, targetlevel )
{
    if ( !player || !isplayer( player ) )
    {
        return;
    }
    
    player.skilllevel = 0;
    player.var_c1ffac14a5dafd35 = undefined;
    player utility::callsharedfunc( #"skills", #"hash_caf936d46b7e8c96" );
    player setclientomnvar( "ui_bonus_tier", 0 );
    player setclientomnvar( "ui_bonus_remove_tier", level.var_4c1500769aa35467.skills.size );
    player.var_b713638c1bc12dc7 = [];
    
    if ( level.var_4c1500769aa35467 )
    {
        var_acecf1de8ec2250a = level.var_4c1500769aa35467.skills.size;
        targetlevel = max( 0, min( targetlevel, var_acecf1de8ec2250a ) );
    }
    
    if ( targetlevel > 0 )
    {
        function_141b75ad9f2d4c95( player, targetlevel );
    }
    
    wait 0.5;
    player setclientomnvar( "ui_bonus_remove_tier", 0 );
}

// Namespace br_skill_tracks
// Params 1
// Checksum 0xba424f69, Offset: 0x919
// Size: 0xbe
function function_2c71ae5a1d3d4c5( params )
{
    player = params.player;
    
    if ( !player || !isplayer( player ) )
    {
        return;
    }
    
    var_9b8768be66e7caf7 = player.var_d01d32dff288fd81;
    player.var_d01d32dff288fd81 = undefined;
    player.skilllevel = 0;
    player.var_c1ffac14a5dafd35 = undefined;
    player utility::callsharedfunc( #"skills", #"hash_caf936d46b7e8c96" );
    player.var_b713638c1bc12dc7 = [];
    player setclientomnvar( "ui_bonus_tier", 0 );
    player setclientomnvar( "ui_bonus_remove_tier", 0 );
    
    if ( var_9b8768be66e7caf7 )
    {
        function_141b75ad9f2d4c95( player, var_9b8768be66e7caf7 );
    }
}

// Namespace br_skill_tracks
// Params 1
// Checksum 0x911e7279, Offset: 0x9df
// Size: 0xa9
function function_c31f710b0ba9dd34( params )
{
    if ( !flags::gameflag( "prematch_done" ) )
    {
        return;
    }
    
    victim = params.victim;
    
    if ( !victim || !isplayer( victim ) )
    {
        return;
    }
    
    attacker = params.attacker;
    
    if ( attacker && isplayer( attacker ) )
    {
        function_9e97467199778d2f( attacker );
    }
    
    victim.var_b713638c1bc12dc7 = undefined;
    victim setclientomnvar( "ui_bonus_tier", 0 );
    victim setclientomnvar( "ui_bonus_remove_tier", 0 );
    victim setscriptablepartstate( "skill_track_level_up", "off", 0 );
}

// Namespace br_skill_tracks
// Params 1
// Checksum 0x2c2285c5, Offset: 0xa90
// Size: 0x31
function function_43a742577557b6a4( params )
{
    if ( !flags::gameflag( "prematch_done" ) )
    {
        return;
    }
    
    if ( self && isplayer( self ) )
    {
        function_9e97467199778d2f( self );
    }
}

// Namespace br_skill_tracks
// Params 1, eflags: 0x4
// Checksum 0x36fd2114, Offset: 0xac9
// Size: 0x5b
function private function_685687c49b437d67( var_2f55edb7a895b70a )
{
    while ( !self.var_c1ffac14a5dafd35 && self.skilllevel < var_2f55edb7a895b70a )
    {
        var_11de7b33b1439196 = self.skilllevel;
        function_9e97467199778d2f( self );
        
        if ( self.skilllevel == var_11de7b33b1439196 )
        {
            break;
        }
    }
}

// Namespace br_skill_tracks
// Params 1
// Checksum 0x7b960707, Offset: 0xb2c
// Size: 0x251
function function_9e97467199778d2f( player )
{
    if ( !level.var_4c1500769aa35467 )
    {
        return;
    }
    
    playsplash = 0;
    var_f8792fbd70e36a4f = level.var_4c1500769aa35467.skills[ player.skilllevel ];
    
    if ( var_f8792fbd70e36a4f )
    {
        targetskills = undefined;
        
        if ( var_f8792fbd70e36a4f.randomize )
        {
            var_484115a92739f1bf = var_f8792fbd70e36a4f.numskills ?? 1;
            var_1d4636e797eb6ee1 = var_f8792fbd70e36a4f.skills.size;
            
            if ( var_484115a92739f1bf < var_1d4636e797eb6ee1 )
            {
                targetskills = [];
                keys = [];
                
                for ( i = 0; i < var_1d4636e797eb6ee1 ; i++ )
                {
                    keys[ i ] = i;
                }
                
                for ( i = 0; i < var_484115a92739f1bf ; i++ )
                {
                    var_5567d6fb509da7b8 = randomintrange( 0, var_1d4636e797eb6ee1 );
                    randomkey = keys[ var_5567d6fb509da7b8 ];
                    randomskill = var_f8792fbd70e36a4f.skills[ randomkey ];
                    targetskills[ targetskills.size ] = randomskill;
                    
                    if ( var_5567d6fb509da7b8 != var_1d4636e797eb6ee1 - 1 )
                    {
                        keys[ var_5567d6fb509da7b8 ] = keys[ var_1d4636e797eb6ee1 - 1 ];
                    }
                    
                    var_1d4636e797eb6ee1--;
                }
            }
        }
        
        if ( !isdefined( targetskills ) )
        {
            targetskills = var_f8792fbd70e36a4f.skills;
        }
        
        foreach ( skill in targetskills )
        {
            playsplash |= player function_d2dbc96fdcba3144( skill.skillbundle, !playsplash );
        }
    }
    
    player.skilllevel++;
    function_e5480129ccf79226( player );
    level utility::callsharedfunc( #"skill_tracks", #"hash_9e804612aa8be619", player );
    
    if ( playsplash )
    {
        player setscriptablepartstate( "skill_track_level_up", "tier_" + player.skilllevel, 0 );
        
        if ( player.skilllevel >= level.var_4c1500769aa35467.skills.size )
        {
            player.var_c1ffac14a5dafd35 = 1;
        }
    }
}

// Namespace br_skill_tracks
// Params 2
// Checksum 0xfb3bb402, Offset: 0xd85
// Size: 0x10d, Type: bool
function function_d2dbc96fdcba3144( var_a38f88c0b0abecd0, playsplash )
{
    skillbundle = getscriptbundle( var_a38f88c0b0abecd0 );
    
    if ( skillbundle && !skillbundle.disabled )
    {
        if ( playsplash )
        {
            utility::callsharedfunc( #"skills", #"giveskill", skillbundle.skillref, skillbundle.skilllevel, undefined, 1 );
            function_7ad11a3f86012ad9( 2, level.skillbundles[ skillbundle.skillref ][ skillbundle.skilllevel ].index + 1 );
            earnedsfx = skillbundle.var_c5f85fc80a76cf7c.earnedsfx;
            
            if ( earnedsfx )
            {
                self playsoundtoplayer( earnedsfx, self );
            }
        }
        else
        {
            utility::callsharedfunc( #"skills", #"giveskill", skillbundle.skillref, skillbundle.skilllevel );
        }
        
        return true;
    }
    
    return false;
}

// Namespace br_skill_tracks
// Params 0
// Checksum 0xacefff4e, Offset: 0xe9b
// Size: 0x83
function function_769438c405917c0()
{
    self endon( #"death_or_disconnect" );
    var_631574f297e4a5e5 = 0;
    
    while ( self.var_33d186df2677b56f[ var_631574f297e4a5e5 ] )
    {
        nextsplash = self.var_33d186df2677b56f[ var_631574f297e4a5e5 ];
        function_619d3203c1674e5e( nextsplash.splashtype, nextsplash.splashindex, nextsplash.skilllevel );
        var_631574f297e4a5e5++;
        waitframe();
    }
    
    self.var_33d186df2677b56f = undefined;
    self.var_94f813c2f06c5b75 = undefined;
}

// Namespace br_skill_tracks
// Params 3
// Checksum 0x2ed8b432, Offset: 0xf26
// Size: 0xcf
function function_7ad11a3f86012ad9( splashtype, splashindex, skilllevel )
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
        thread function_769438c405917c0();
        return;
    }
    
    self.var_33d186df2677b56f[ self.var_94f813c2f06c5b75 ] = newsplash;
    self.var_94f813c2f06c5b75++;
}

// Namespace br_skill_tracks
// Params 3
// Checksum 0x6ee66477, Offset: 0xffd
// Size: 0xd1
function function_619d3203c1674e5e( splashtype, splashindex, skilllevel )
{
    self endon( #"death_or_disconnect" );
    self setclientomnvar( "ui_ob_upgrade_splash_type", splashtype );
    self setclientomnvar( "ui_ob_upgrade_splash_asset_index", splashindex );
    self setclientomnvar( "ui_ob_damage_skill_level", skilllevel );
    br_upgrade_splash::open_br_upgrade_splash();
    self waittill( #"upgradesplashhide" );
    br_upgrade_splash::close_br_upgrade_splash();
    
    if ( !isdefined( self.var_b713638c1bc12dc7 ) )
    {
        self.var_b713638c1bc12dc7 = [];
    }
    
    if ( self.var_b713638c1bc12dc7.size < 18 )
    {
        slot = self.var_b713638c1bc12dc7.size + 1;
        self.var_b713638c1bc12dc7[ self.var_b713638c1bc12dc7.size ] = splashindex;
    }
    
    while ( br_upgrade_splash::br_upgrade_splash_is_active() )
    {
        waitframe();
    }
}

// Namespace br_skill_tracks
// Params 1
// Checksum 0x49d15e73, Offset: 0x10d6
// Size: 0x9c
function function_e5480129ccf79226( player )
{
    bonustier = min( player.skilllevel, level.var_4c1500769aa35467.skills.size );
    player setclientomnvar( "ui_bonus_tier", bonustier );
    maxtimems = getdvarint( @"hash_e6647378e211af20", 120 ) * 1000;
    progresstime = bonustier / level.var_4c1500769aa35467.skills.size * maxtimems;
    player setclientomnvar( "ui_cranked_timer_time", int( progresstime ) );
}

/#

    // Namespace br_skill_tracks
    // Params 0, eflags: 0x4
    // Checksum 0x3e25d4d5, Offset: 0x117a
    // Size: 0x7e, Type: dev
    function private function_9a2320d825dc7a24()
    {
        foreach ( player in level.players )
        {
            function_9e97467199778d2f( player );
        }
    }

#/
