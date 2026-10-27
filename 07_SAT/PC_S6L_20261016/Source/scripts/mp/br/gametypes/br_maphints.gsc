// scripts\mp\br\gametypes\br_maphints.gsc  (hash_014bca90b87a324c.gscc) (size: 12791 Bytes / 0x31f7 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5de718c7 (1575426247)
// size ...... 12791 (0x31f7)
// includes .. 6   (offset: 0x2e9f)
// strings ... 27  (offset: 0x2ecf)
// dev strs .. 4   (offset: 0x31c7)
// exports ... 25  (offset: 0x23c3)
// cseg ...... 0x21a + 0x21a9 (0x23c3)
// imports ... 49  (offset: 0x27ab)
// animtree1 . 0   (offset: 0x31f7)
// animtree2 . 0   (offset: 0x31f7)
#using scripts\common\scriptable;
#using scripts\mp\common\utility\debug;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\flags;

#namespace br_maphints;

// Namespace br_maphints
// Params 0
// Checksum 0x9141de67, Offset: 0x238
// Size: 0xac
function init()
{
    if ( getdvarint( @"scr_maphints", 1 ) == 0 )
    {
        return;
    }
    
    level.maphints = [];
    level.maphints[ "keypads" ] = [];
    level.maphints[ "phones" ] = [];
    level.maphints[ "computers" ] = [];
    level thread onplayerconnect();
    level thread init_season3_intel_challenges();
    
    if ( game_utility::getmapname() == "mp_br_mechanics" )
    {
        initlocs_test();
    }
    else
    {
        initlocs_computer();
    }
    
    scriptable::scriptable_addusedcallbackbypart( "maphint_computer", &maphint_computerscriptableused );
    
    if ( false )
    {
        level thread maphint_debugthink();
    }
    
    /#
        level thread function_2431b5d08387b934();
    #/
}

// Namespace br_maphints
// Params 0
// Checksum 0xa017571, Offset: 0x2ec
// Size: 0x383
function initlocs_keypads()
{
    level.maphints[ "keypads" ] = [];
    level.maphints[ "keypads" ][ 0 ] = spawnstruct();
    level.maphints[ "keypads" ][ 0 ].origin = ( -17261, -44265, 40 );
    level.maphints[ "keypads" ][ 1 ] = spawnstruct();
    level.maphints[ "keypads" ][ 1 ].origin = ( -37520, -19013, 237 );
    level.maphints[ "keypads" ][ 2 ] = spawnstruct();
    level.maphints[ "keypads" ][ 2 ].origin = ( -39523, -2395, 30 );
    level.maphints[ "keypads" ][ 3 ] = spawnstruct();
    level.maphints[ "keypads" ][ 3 ].origin = ( -38640, -1902, -103 );
    level.maphints[ "keypads" ][ 4 ] = spawnstruct();
    level.maphints[ "keypads" ][ 4 ].origin = ( -15513, 43307, 105 );
    level.maphints[ "keypads" ][ 5 ] = spawnstruct();
    level.maphints[ "keypads" ][ 5 ].origin = ( 2495, 41096, 1670 );
    level.maphints[ "keypads" ][ 6 ] = spawnstruct();
    level.maphints[ "keypads" ][ 6 ].origin = ( 47600, 34582, 500 );
    level.maphints[ "keypads" ][ 7 ] = spawnstruct();
    level.maphints[ "keypads" ][ 7 ].origin = ( 18622, -34634, -478 );
    level.maphints[ "keypads" ][ 8 ] = spawnstruct();
    level.maphints[ "keypads" ][ 8 ].origin = ( 54279, -33994, 173 );
    level.maphints[ "keypads" ][ 9 ] = spawnstruct();
    level.maphints[ "keypads" ][ 9 ].origin = ( 36350, 13586, 26 );
    level.maphints[ "keypads" ][ 10 ] = spawnstruct();
    level.maphints[ "keypads" ][ 10 ].origin = ( 37390, 13383, -117 );
    
    foreach ( index, hint in level.maphints[ "keypads" ] )
    {
        level.maphints[ "keypads" ][ index ].scriptable = spawnscriptable( "maphint_keypad", hint.origin );
    }
}

// Namespace br_maphints
// Params 0
// Checksum 0x8348ba37, Offset: 0x677
// Size: 0xba
function initlocs_phones()
{
    level.maphints[ "phones" ] = [];
    
    foreach ( index, hint in level.maphints[ "phones" ] )
    {
        level.maphints[ "phones" ][ index ].scriptable = spawnscriptable( "maphint_phone", hint.origin );
    }
}

// Namespace br_maphints
// Params 0
// Checksum 0x9aebbaff, Offset: 0x739
// Size: 0x27f
function initlocs_computer()
{
    level.maphints[ "computers" ] = [];
    level.maphints[ "computers" ][ 0 ] = spawnstruct();
    level.maphints[ "computers" ][ 0 ].origin = ( 8490, -11874, -239 );
    level.maphints[ "computers" ][ 1 ] = spawnstruct();
    level.maphints[ "computers" ][ 1 ].origin = ( -14585, 7982, -175 );
    level.maphints[ "computers" ][ 2 ] = spawnstruct();
    level.maphints[ "computers" ][ 2 ].origin = ( -34140, 3815, -55 );
    level.maphints[ "computers" ][ 3 ] = spawnstruct();
    level.maphints[ "computers" ][ 3 ].origin = ( 5358, 51419, 1080 );
    level.maphints[ "computers" ][ 4 ] = spawnstruct();
    level.maphints[ "computers" ][ 4 ].origin = ( 51078, -39445, 1125 );
    level.maphints[ "computers" ][ 5 ] = spawnstruct();
    level.maphints[ "computers" ][ 5 ].origin = ( 17796, -8300, 1349 );
    level.maphints[ "computers" ][ 6 ] = spawnstruct();
    level.maphints[ "computers" ][ 6 ].origin = ( 37275, -26745, -472 );
    
    foreach ( index, hint in level.maphints[ "computers" ] )
    {
        level.maphints[ "computers" ][ index ].scriptable = spawnscriptable( "maphint_computer", hint.origin );
    }
}

// Namespace br_maphints
// Params 0
// Checksum 0x779c67b8, Offset: 0x9c0
// Size: 0x13a
function initlocs_radio()
{
    level.maphints[ "radios" ] = [];
    level.maphints[ "radios" ][ 0 ] = spawnstruct();
    level.maphints[ "radios" ][ 0 ].origin = ( -21440, 19434, -252 );
    level.maphints[ "radios" ][ 1 ] = spawnstruct();
    level.maphints[ "radios" ][ 1 ].origin = ( 2896, 45445, 1630 );
    
    foreach ( index, hint in level.maphints[ "radios" ] )
    {
        level.maphints[ "radios" ][ index ].scriptable = spawnscriptable( "maphint_radio", hint.origin );
    }
}

// Namespace br_maphints
// Params 5
// Checksum 0x9a01abed, Offset: 0xb02
// Size: 0x4f
function maphint_keypadscriptableused( instance, part, state, player, bautouse )
{
    assert( part == "<dev string:x24>" );
    level thread _maphint_keypadscriptableused( instance, part, state, player, bautouse );
}

// Namespace br_maphints
// Params 5
// Checksum 0x5f9a8f56, Offset: 0xb59
// Size: 0x75
function _maphint_keypadscriptableused( instance, part, state, player, bautouse )
{
    if ( state == "on" )
    {
        playsoundatpos( player.origin, "br_keypad_deny" );
        instance setscriptablepartstate( "maphint_keypad", "off" );
        wait 3;
        instance setscriptablepartstate( "maphint_keypad", "on" );
    }
}

// Namespace br_maphints
// Params 5
// Checksum 0x4496add, Offset: 0xbd6
// Size: 0x4f
function maphint_phonescriptableused( instance, part, state, player, bautouse )
{
    assert( part == "<dev string:x33>" );
    level thread _maphint_phonescriptableused( instance, part, state, player, bautouse );
}

// Namespace br_maphints
// Params 5
// Checksum 0xd5d09a23, Offset: 0xc2d
// Size: 0x75
function _maphint_phonescriptableused( instance, part, state, player, bautouse )
{
    if ( state == "on" )
    {
        playsoundatpos( player.origin, "br_phone_deny" );
        instance setscriptablepartstate( "maphint_phone", "off" );
        wait 3;
        instance setscriptablepartstate( "maphint_phone", "on" );
    }
}

// Namespace br_maphints
// Params 6
// Checksum 0x55be0483, Offset: 0xcaa
// Size: 0x58
function maphint_computerscriptableused( instance, part, state, player, bautouse, usestring )
{
    assert( part == "<dev string:x41>" );
    level thread _maphint_computerscriptableused( instance, part, state, player, bautouse );
}

// Namespace br_maphints
// Params 5
// Checksum 0x12580a8, Offset: 0xd0a
// Size: 0x75
function _maphint_computerscriptableused( instance, part, state, player, bautouse )
{
    if ( state == "on" )
    {
        playsoundatpos( player.origin, "br_computer_deny" );
        instance setscriptablepartstate( "maphint_computer", "off" );
        wait 3;
        instance setscriptablepartstate( "maphint_computer", "on" );
    }
}

// Namespace br_maphints
// Params 0
// Checksum 0xaaece04c, Offset: 0xd87
// Size: 0x350
function initlocs_test()
{
    wait 5;
    level.maphints[ "keypads" ] = [];
    level.maphints[ "keypads" ][ 0 ] = spawnstruct();
    level.maphints[ "keypads" ][ 0 ].origin = ( -237, -2721, 60 );
    level.maphints[ "keypads" ][ 1 ] = spawnstruct();
    level.maphints[ "keypads" ][ 1 ].origin = ( -237, -2721, 260 );
    
    foreach ( hint in level.maphints[ "keypads" ] )
    {
        item = spawnscriptable( "maphint_keypad", hint.origin );
    }
    
    level.maphints[ "phones" ] = [];
    level.maphints[ "phones" ][ 0 ] = spawnstruct();
    level.maphints[ "phones" ][ 0 ].origin = ( -21, -2721, 60 );
    level.maphints[ "phones" ][ 1 ] = spawnstruct();
    level.maphints[ "phones" ][ 1 ].origin = ( -21, -2721, 260 );
    
    foreach ( hint in level.maphints[ "phones" ] )
    {
        item = spawnscriptable( "maphint_phone", hint.origin );
    }
    
    level.maphints[ "computers" ] = [];
    level.maphints[ "computers" ][ 0 ] = spawnstruct();
    level.maphints[ "computers" ][ 0 ].origin = ( 100, -2721, 60 );
    level.maphints[ "computers" ][ 1 ] = spawnstruct();
    level.maphints[ "computers" ][ 1 ].origin = ( 100, -2721, 260 );
    
    foreach ( hint in level.maphints[ "computers" ] )
    {
        item = spawnscriptable( "maphint_computer", hint.origin );
    }
}

// Namespace br_maphints
// Params 0
// Checksum 0x4f361bed, Offset: 0x10df
// Size: 0x25e
function maphint_debugthink()
{
    var_cdf24bbac51524e5 = 1;
    
    while ( true )
    {
        if ( var_cdf24bbac51524e5 )
        {
            foreach ( hint in level.maphints[ "phones" ] )
            {
                thread debug::drawsphere( hint.scriptable.origin, 64, 1, ( 0, 1, 0 ) );
            }
        }
        
        if ( getdvarint( @"hash_87c1bbd83c66bfc9", 0 ) == 1 )
        {
            foreach ( hint in level.maphints[ "keypads" ] )
            {
                hint.scriptable freescriptable();
            }
            
            foreach ( hint in level.maphints[ "phones" ] )
            {
                hint.scriptable freescriptable();
            }
            
            foreach ( hint in level.maphints[ "computers" ] )
            {
                hint.scriptable freescriptable();
            }
            
            initlocs_keypads();
            initlocs_phones();
            initlocs_computer();
        }
        
        wait 1;
    }
}

// Namespace br_maphints
// Params 0
// Checksum 0xb9cca9c3, Offset: 0x1345
// Size: 0x52b
function init_season3_intel_challenges()
{
    level.intelchallengesdata = [];
    flags::gameflaginit( "intel_challenges_setup_complete", 0 );
    currentweek = getdvarint( @"online_challenge_season_and_week", 0 );
    
    for ( row = 0; true ; row++ )
    {
        ref = tablelookupbyrow( "mp/intel_challenges.csv", row, 0 );
        
        if ( !isdefined( ref ) || ref == "" )
        {
            break;
        }
        
        ingame = int( tablelookupbyrow( "mp/intel_challenges.csv", row, 2 ) );
        week = int( tablelookupbyrow( "mp/intel_challenges.csv", row, 1 ) );
        
        if ( week > currentweek && getdvarint( @"scr_intel_challenges_debug", 0 ) == 0 )
        {
            row++;
            continue;
        }
        
        backendevent = tablelookupbyrow( "mp/intel_challenges.csv", row, 3 );
        modelpart = tablelookupbyrow( "mp/intel_challenges.csv", row, 4 );
        originx = float( tablelookupbyrow( "mp/intel_challenges.csv", row, 5 ) );
        originy = float( tablelookupbyrow( "mp/intel_challenges.csv", row, 6 ) );
        originz = float( tablelookupbyrow( "mp/intel_challenges.csv", row, 7 ) );
        origin = ( originx, originy, originz );
        anglesx = float( tablelookupbyrow( "mp/intel_challenges.csv", row, 8 ) );
        anglesy = float( tablelookupbyrow( "mp/intel_challenges.csv", row, 9 ) );
        anglesz = float( tablelookupbyrow( "mp/intel_challenges.csv", row, 10 ) );
        angles = ( anglesx, anglesy, anglesz );
        data = spawnstruct();
        data.ref = ref;
        data.ingame = ingame;
        data.week = week;
        data.backendevent = backendevent;
        data.modelpart = modelpart;
        data.origin = origin;
        data.scriptables = [];
        var_a3f7c0e8836c3d1b = 0;
        
        if ( ingame && !var_a3f7c0e8836c3d1b )
        {
            instance = spawnscriptable( "intel", origin, angles );
            instance.datakey = ref;
            data.scriptables[ 0 ] = instance;
        }
        
        level.intelchallengesdata[ ref ] = data;
    }
    
    ref = "ch_intel_season3_2_7";
    
    if ( isdefined( level.intelchallengesdata[ ref ] ) )
    {
        origin = ( -14280, -15350, -199 );
        angles = ( 0, 0, 0 );
        instance = spawnscriptable( "intel", origin, angles );
        instance.datakey = ref;
        level.intelchallengesdata[ ref ].scriptables[ level.intelchallengesdata[ ref ].scriptables.size ] = instance;
    }
    
    ref = "ch_intel_season3_5_5";
    
    if ( isdefined( level.intelchallengesdata[ ref ] ) )
    {
        origin = ( -25767, -31548, 1595 );
        angles = ( 0, 0, 0 );
        instance = spawnscriptable( "intel", origin, angles );
        instance.datakey = ref;
        level.intelchallengesdata[ ref ].scriptables[ level.intelchallengesdata[ ref ].scriptables.size ] = instance;
        origin = ( 14607, 15419, 1914 );
        angles = ( 0, 0, 0 );
        instance = spawnscriptable( "intel", origin, angles );
        instance.datakey = ref;
        level.intelchallengesdata[ ref ].scriptables[ level.intelchallengesdata[ ref ].scriptables.size ] = instance;
        level.intelchallengesdata[ ref ].collectall = 1;
    }
    
    ref = "ch_intel_7_6";
    
    if ( isdefined( level.intelchallengesdata[ ref ] ) )
    {
        origin = ( 31519, -444, 38 );
        angles = ( 0, 0, 0 );
        instance = spawnscriptable( "intel", origin, angles );
        instance.datakey = ref;
        level.intelchallengesdata[ ref ].scriptables[ level.intelchallengesdata[ ref ].scriptables.size ] = instance;
        origin = ( 31514, -333, 38 );
        angles = ( 0, 0, 0 );
        instance = spawnscriptable( "intel", origin, angles );
        instance.datakey = ref;
        level.intelchallengesdata[ ref ].scriptables[ level.intelchallengesdata[ ref ].scriptables.size ] = instance;
        level.intelchallengesdata[ ref ].collectall = 1;
    }
    
    level thread assignscriptablemodels();
    scriptable::scriptable_addusedcallback( &intelused );
    flags::gameflagset( "intel_challenges_setup_complete" );
}

// Namespace br_maphints
// Params 0
// Checksum 0x839c7ac0, Offset: 0x1878
// Size: 0x11c
function assignscriptablemodels()
{
    wait 1;
    
    foreach ( key, entry in level.intelchallengesdata )
    {
        if ( !entry.ingame )
        {
            continue;
        }
        
        foreach ( instance in level.intelchallengesdata[ key ].scriptables )
        {
            instance setscriptablepartstate( "model", entry.modelpart );
        }
    }
}

/#

    // Namespace br_maphints
    // Params 0
    // Checksum 0x3a7844b2, Offset: 0x199c
    // Size: 0x203, Type: dev
    function function_2431b5d08387b934()
    {
        flags::gameflagwait( "<dev string:x52>" );
        
        while ( true )
        {
            if ( getdvarint( @"scr_intel_challenges_debug", 0 ) == 1 )
            {
                foreach ( key, entry in level.intelchallengesdata )
                {
                    if ( !entry.ingame )
                    {
                        continue;
                    }
                    
                    foreach ( instance in level.intelchallengesdata[ key ].scriptables )
                    {
                        thread debug_utility::drawsphere( instance.origin, 16, level.framedurationseconds, ( 1, 0, 0 ) );
                        print3d( instance.origin, key, ( 1, 1, 1 ), 1, 1, level.frameduration );
                    }
                    
                    if ( level.intelchallengesdata[ key ].scriptables.size == 0 )
                    {
                        origin = entry.origin + ( 0, 0, 36 );
                        thread debug_utility::drawsphere( origin, 16, level.framedurationseconds, ( 1, 0, 0 ) );
                        print3d( origin, key, ( 1, 1, 1 ), 1, 1, level.frameduration );
                    }
                }
            }
            
            waitframe();
        }
    }

#/

// Namespace br_maphints
// Params 2
// Checksum 0xa507de16, Offset: 0x1ba7
// Size: 0x9a
function showintelscriptablestoplayer( player, key )
{
    foreach ( instance in level.intelchallengesdata[ key ].scriptables )
    {
        instance enablescriptableplayeruse( player );
    }
}

// Namespace br_maphints
// Params 2
// Checksum 0x4d65d158, Offset: 0x1c49
// Size: 0x9a
function hideintelscriptablesfromplayer( player, key )
{
    foreach ( instance in level.intelchallengesdata[ key ].scriptables )
    {
        instance disablescriptableplayeruse( player );
    }
}

// Namespace br_maphints
// Params 0
// Checksum 0x207037e1, Offset: 0x1ceb
// Size: 0x2c
function onplayerconnect()
{
    while ( true )
    {
        level waittill( #"connected", player );
        player thread assignintelchallenges();
    }
}

// Namespace br_maphints
// Params 0
// Checksum 0x21da989a, Offset: 0x1d1f
// Size: 0x2f0
function assignintelchallenges()
{
    self endon( #"disconnect" );
    
    foreach ( key, entry in level.intelchallengesdata )
    {
        if ( !entry.ingame )
        {
            continue;
        }
        
        hideintelscriptablesfromplayer( self, key );
    }
    
    self.activeintelchallengekeys = [];
    
    if ( getdvarint( @"scr_intel_challenges_debug", 0 ) == 1 )
    {
        allsteps = [];
        
        foreach ( key, entry in level.intelchallengesdata )
        {
            if ( !entry.ingame )
            {
                continue;
            }
            
            allsteps[ allsteps.size ] = key;
        }
        
        self.activeintelchallengekeys = allsteps;
    }
    else
    {
        currentweek = 3001;
        firstfound = undefined;
        
        foreach ( key, entry in level.intelchallengesdata )
        {
            if ( entry.week < currentweek )
            {
                continue;
            }
            
            if ( currentweek < entry.week )
            {
                currentweek = entry.week;
            }
            
            if ( firstfound < entry.week )
            {
                firstfound = undefined;
            }
            
            completed = self getplayerdata( level.var_6f9b00680ed002d8, "missionComplete", key );
            
            if ( !isdefined( firstfound ) && !completed )
            {
                firstfound = entry.week;
                currentweek++;
                self.activeintelchallengekeys[ self.activeintelchallengekeys.size ] = key;
            }
        }
    }
    
    flags::gameflagwait( "prematch_done" );
    
    foreach ( key, entry in level.intelchallengesdata )
    {
        if ( !entry.ingame )
        {
            continue;
        }
        
        if ( arraycontains( self.activeintelchallengekeys, key ) )
        {
            showintelscriptablestoplayer( self, key );
        }
    }
}

// Namespace br_maphints
// Params 6
// Checksum 0x231e328f, Offset: 0x2017
// Size: 0x1bd
function intelused( instance, part, state, player, bautouse, usestring )
{
    if ( isdefined( instance ) && instance.type == "intel" )
    {
        cancollect = 1;
        
        if ( !arraycontains( player.activeintelchallengekeys, instance.datakey ) )
        {
            cancollect = 0;
        }
        
        if ( instance.datakey == "ch_intel_season3_2_5" )
        {
            if ( !isdefined( player.perks[ "specialty_hack" ] ) )
            {
                cancollect = 0;
                playsoundatpos( player.origin, "br_computer_deny" );
            }
        }
        
        if ( cancollect )
        {
            if ( level.intelchallengesdata[ instance.datakey ].collectall )
            {
                if ( !isdefined( player.pers[ instance.datakey ] ) )
                {
                    player.pers[ instance.datakey ] = 1;
                }
                else
                {
                    player.pers[ instance.datakey ]++;
                }
                
                count = level.intelchallengesdata[ instance.datakey ].scriptables.size;
                
                if ( player.pers[ instance.datakey ] < count )
                {
                    instance disablescriptableplayeruse( player );
                    player playsoundtoplayer( "ui_intel_interact", player );
                    return;
                }
            }
            
            hideintelscriptablesfromplayer( player, instance.datakey );
            player playsoundtoplayer( "ui_intel_interact", player );
        }
    }
}

// Namespace br_maphints
// Params 2
// Checksum 0x2ba5da36, Offset: 0x21dc
// Size: 0x36, Type: bool
function isplayeronintelchallenge( player, ref )
{
    return isdefined( player.activeintelchallengekeys ) && arraycontains( player.activeintelchallengekeys, ref );
}

// Namespace br_maphints
// Params 2
// Checksum 0x38413afc, Offset: 0x221b
// Size: 0xc6
function markintelwithrecondrone( droneowner, ent )
{
    teammates = teams::getfriendlyplayers( droneowner.team, 0 );
    
    foreach ( player in teammates )
    {
        if ( isplayeronintelchallenge( player, ent.datakey ) )
        {
            intelused( ent.scriptable, undefined, undefined, player );
        }
    }
}

// Namespace br_maphints
// Params 0
// Checksum 0xe3481096, Offset: 0x22e9
// Size: 0xda
function function_10a670020830a1e6()
{
    level endon( #"game_ended" );
    
    while ( true )
    {
        self waittill( #"emp_applied", data );
        teammates = teams::getfriendlyplayers( data.attacker, 0 );
        
        foreach ( player in teammates )
        {
            if ( isplayeronintelchallenge( player, self.datakey ) )
            {
                intelused( self.scriptable, undefined, undefined, player );
            }
        }
    }
}

