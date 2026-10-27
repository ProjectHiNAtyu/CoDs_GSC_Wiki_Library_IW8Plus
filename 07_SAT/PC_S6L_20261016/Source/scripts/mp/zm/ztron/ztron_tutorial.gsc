// scripts\mp\zm\ztron\ztron_tutorial.gsc  (hash_4cbc77054fb47f6c.gscc) (size: 8368 Bytes / 0x20b0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9ed49e08 (2664734216)
// size ...... 8368 (0x20b0)
// includes .. 4   (offset: 0x1f4c)
// strings ... 27  (offset: 0x1f6c)
// dev strs .. 0   (offset: 0x20b0)
// exports ... 29  (offset: 0x13e0)
// cseg ...... 0x2a8 + 0x1138 (0x13e0)
// imports ... 54  (offset: 0x1868)
// animtree1 . 0   (offset: 0x20b0)
// animtree2 . 0   (offset: 0x20b0)
#using script_4ce55cfc81c444ad;
#using scripts\common\utility;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace ztron_tutorial;

// Namespace ztron_tutorial
// Params 1
// Checksum 0xd877a2d, Offset: 0x2c6
// Size: 0xd7
function function_b18e5953164335be( spot )
{
    if ( isdefined( spot ) )
    {
        crabmodel = utility::spawn_model( "sat_zm_ztron_props_tutorial_crab", spot.origin, spot.angles );
        crabmodel.ztron = spawnstruct();
        crabmodel.ztron.bubblecooldown = 0;
        
        if ( randomint( 100 ) > 50 )
        {
            sword = utility::spawn_model( "sat_zm_ztron_props_crab_pirate_sword", spot.origin, spot.angles );
            sword enablelinkto();
            sword thread ztron_util::function_f7544bfa701db406( crabmodel );
            sword linkto( crabmodel, "tag_origin", ( 23, -26, -12 ), ( 0, -12, 0 ) );
        }
    }
    
    return crabmodel;
}

// Namespace ztron_tutorial
// Params 0
// Checksum 0xd5e2ae8b, Offset: 0x3a6
// Size: 0x79
function function_4c5b1b7fd5fb2b4e()
{
    if ( isdedicatedserver() && !ztron_util::function_5ba0edd1761596a2() )
    {
        return;
    }
    
    tutorialspot = utility::getstruct( self.name + "_tutorial", "targetname" );
    self.tutorialent = function_b18e5953164335be( tutorialspot );
    
    if ( isdefined( self.tutorialent ) )
    {
        self.tutorialent thread crab_tutorial();
        self.tutorialent thread function_4de0204b510df457();
    }
}

// Namespace ztron_tutorial
// Params 0
// Checksum 0x5203b1d8, Offset: 0x427
// Size: 0x2e
function function_4de0204b510df457()
{
    level utility::waittill_any( "arena_completed", "advancedStart", "ztron_game_is_over" );
    self notify( #"stop_tutorial" );
    ztron_util::deletemedelay( 3 );
}

// Namespace ztron_tutorial
// Params 2
// Checksum 0x12de134a, Offset: 0x45d
// Size: 0xda, Type: bool
function function_c849d14b0658bc99( player, minlevel )
{
    if ( !isdefined( self ) || !isdefined( self.ztron ) )
    {
        return false;
    }
    
    if ( !isdefined( level.ztron.active_arena ) )
    {
        return false;
    }
    
    if ( level.ztron.roundnumber < minlevel )
    {
        return false;
    }
    
    if ( self.ztron.bubbleactive )
    {
        return false;
    }
    
    if ( gettime() < self.ztron.bubblecooldown )
    {
        return false;
    }
    
    if ( level.ztron.var_9cb1ea9ce77759 )
    {
        return false;
    }
    
    if ( isdefined( player ) && distancesquared( self.origin, player.origin ) > 90000 )
    {
        return false;
    }
    
    return true;
}

// Namespace ztron_tutorial
// Params 1
// Checksum 0xc200d8fd, Offset: 0x540
// Size: 0x48f
function crab_tutorial( delaytalking )
{
    level endon( #"ztron_game_is_over" );
    self endon( #"stop_tutorial" );
    
    if ( level.var_87d0c668ebe44c24 )
    {
        return;
    }
    
    if ( !isdefined( self ) || level.players.size > 1 )
    {
        return;
    }
    
    thread function_846b66d0a75d6d1f();
    level.ztron.var_99648006e32822f7 = [];
    level.ztron.var_99648006e32822f7[ level.ztron.var_99648006e32822f7.size ] = &function_e5886f6aff2a40d;
    level.ztron.var_99648006e32822f7[ level.ztron.var_99648006e32822f7.size ] = &function_a274393907491deb;
    level.ztron.var_99648006e32822f7[ level.ztron.var_99648006e32822f7.size ] = &function_d0e1947b7397e103;
    level.ztron.var_99648006e32822f7[ level.ztron.var_99648006e32822f7.size ] = &function_954bb801807a5c00;
    level.ztron.var_99648006e32822f7[ level.ztron.var_99648006e32822f7.size ] = &function_84c1fd231d22fbf7;
    level.ztron.var_99648006e32822f7[ level.ztron.var_99648006e32822f7.size ] = &function_2d14cbe36a7e549c;
    level.ztron.var_99648006e32822f7[ level.ztron.var_99648006e32822f7.size ] = &function_a1d29e504fd5d6f3;
    level.ztron.var_99648006e32822f7[ level.ztron.var_99648006e32822f7.size ] = &function_1db0328a3db8b5fb;
    level.ztron.var_99648006e32822f7[ level.ztron.var_99648006e32822f7.size ] = &function_d32b48f0d4628b15;
    level.ztron.var_99648006e32822f7[ level.ztron.var_99648006e32822f7.size ] = &function_d54bd06fc2685c06;
    level.ztron.var_99648006e32822f7[ level.ztron.var_99648006e32822f7.size ] = &function_82349cd090a76f15;
    level.ztron.var_99648006e32822f7[ level.ztron.var_99648006e32822f7.size ] = &function_795b55efe9b57f1f;
    level.ztron.var_99648006e32822f7[ level.ztron.var_99648006e32822f7.size ] = &function_2343eeab4bd5b320;
    level.ztron.var_99648006e32822f7[ level.ztron.var_99648006e32822f7.size ] = &function_55d24ef73f6e962;
    level.ztron.var_99648006e32822f7[ level.ztron.var_99648006e32822f7.size ] = &function_ae6bccb5f35f6607;
    level waittill( #"round_about_to_start" );
    wait 5;
    
    while ( true )
    {
        foreach ( tryblock in level.ztron.var_99648006e32822f7 )
        {
            result = self [[ tryblock ]]();
            
            if ( isdefined( result ) && result.success )
            {
                result.tryblock = tryblock;
                break;
            }
        }
        
        if ( result.remove )
        {
            level.ztron.var_99648006e32822f7 = arrayremove( level.ztron.var_99648006e32822f7, result.tryblock );
        }
        
        if ( result.addback )
        {
            level.ztron.var_99648006e32822f7[ level.ztron.var_99648006e32822f7.size ] = result.tryblock;
        }
        
        waittime = 1;
        
        if ( isdefined( result.waittime ) )
        {
            waittime = result.waittime;
        }
        
        wait waittime;
    }
}

// Namespace ztron_tutorial
// Params 0
// Checksum 0x250b35b6, Offset: 0x9d7
// Size: 0x67
function function_f857df9b57df9116()
{
    if ( !isdefined( self.bubblespot ) )
    {
        self.bubbleforward = anglestoright( self.angles );
        self.bubblespot = self.origin + 13 * self.bubbleforward;
    }
    
    playfx( utility::getfx( "crab_bubbles" ), self.bubblespot, self.bubbleforward );
}

// Namespace ztron_tutorial
// Params 1
// Checksum 0xd3a65dda, Offset: 0xa46
// Size: 0x45
function function_59b355957644682a( var_5bd2fa07aad9409d )
{
    function_f857df9b57df9116();
    function_7b0de27d6b91ff9c();
    ztron_dialog::function_927bb94feca983e8( getxhash( var_5bd2fa07aad9409d ), 0, 0 );
    self.ztron.bubblecooldown = gettime() + 15000;
}

// Namespace ztron_tutorial
// Params 1
// Checksum 0xf72e338e, Offset: 0xa93
// Size: 0x4e, Type: bool
function function_e5313195f2ef217d( minlevel )
{
    player = level.players[ 0 ];
    
    if ( !player.ztron.var_8a4455464a940cd9 )
    {
        return false;
    }
    
    if ( function_c849d14b0658bc99( player, minlevel ) )
    {
        return true;
    }
    
    return false;
}

// Namespace ztron_tutorial
// Params 4
// Checksum 0x12229191, Offset: 0xaea
// Size: 0x91
function createresult( success = 0, remove = 0, waittime = undefined, addback = 0 )
{
    result = spawnstruct();
    result.success = success;
    result.remove = remove;
    result.waittime = waittime;
    result.addback = addback;
    return result;
}

// Namespace ztron_tutorial
// Params 0
// Checksum 0xa7bd59f8, Offset: 0xb84
// Size: 0x27
function function_e5886f6aff2a40d()
{
    profilestart();
    
    if ( function_e5313195f2ef217d( 1 ) )
    {
        function_59b355957644682a( "crab_greeting" );
    }
    
    profilestop();
    return createresult( 1, 1, 8 );
}

// Namespace ztron_tutorial
// Params 0
// Checksum 0xa952dcdd, Offset: 0xbb5
// Size: 0x90
function function_84c1fd231d22fbf7()
{
    profilestart();
    self endon( #"stop_tutorial" );
    level endon( #"ztron_game_is_over" );
    player = level.players[ 0 ];
    
    if ( function_e5313195f2ef217d( 1 ) && ztron_util::function_cdd411b0cc1f9d80().size > 0 && player.ztron.score.var_59f1f1595961cbe > 0 )
    {
        function_59b355957644682a( "crab_boost_hint" );
        profilestop();
        return createresult( 1, 1, 8 );
    }
    
    profilestop();
    return createresult();
}

// Namespace ztron_tutorial
// Params 0
// Checksum 0xdefaf307, Offset: 0xc4f
// Size: 0x91
function function_2d14cbe36a7e549c()
{
    profilestart();
    self endon( #"stop_tutorial" );
    level endon( #"ztron_game_is_over" );
    player = level.players[ 0 ];
    
    if ( function_e5313195f2ef217d( 2 ) && ztron_util::function_cdd411b0cc1f9d80().size > 8 && player.ztron.score.bombs > 0 )
    {
        function_59b355957644682a( "crab_bomb_hint" );
        profilestop();
        return createresult( 1, 1, 8 );
    }
    
    profilestop();
    return createresult();
}

// Namespace ztron_tutorial
// Params 0
// Checksum 0x920ff7b8, Offset: 0xcea
// Size: 0xc8
function function_a1d29e504fd5d6f3()
{
    profilestart();
    self endon( #"stop_tutorial" );
    level endon( #"ztron_game_is_over" );
    player = level.players[ 0 ];
    showhint = 0;
    
    for ( index = 0; index < 3 ; index++ )
    {
        slot = index + 1;
        
        if ( isdefined( player.var_b02f6e7abbbc8a84[ slot ] ) && player.var_b02f6e7abbbc8a84[ slot ] != "none" )
        {
            showhint = 1;
            break;
        }
    }
    
    if ( function_e5313195f2ef217d( 2 ) && showhint )
    {
        function_59b355957644682a( "crab_gum_hint" );
        profilestop();
        return createresult( 1, 1, 8 );
    }
    
    profilestop();
    return createresult();
}

// Namespace ztron_tutorial
// Params 0
// Checksum 0xc4c4023b, Offset: 0xdbc
// Size: 0x89
function function_954bb801807a5c00()
{
    profilestart();
    showhint = 0;
    player = level.players[ 0 ];
    
    if ( player.ztron.var_c5c31e76e1c42198 != player.ztron.default_weapon_bundle )
    {
        showhint = 1;
    }
    
    if ( showhint && function_e5313195f2ef217d( 1 ) )
    {
        function_59b355957644682a( "crab_hint_context_weapon" );
        profilestop();
        return createresult( 1, 1, 8 );
    }
    
    profilestop();
    return createresult();
}

// Namespace ztron_tutorial
// Params 0
// Checksum 0xfbf8767, Offset: 0xe4f
// Size: 0x8b
function function_795b55efe9b57f1f()
{
    profilestart();
    showhint = 0;
    player = level.players[ 0 ];
    
    if ( player.ztron.var_a4c2f70bbc713f98 )
    {
        showhint = 1;
    }
    
    if ( showhint && function_e5313195f2ef217d( 3 ) && !level.ztron.var_74a3707334cfe144 )
    {
        function_59b355957644682a( "crab_hint_context_firstperson" );
        profilestop();
        return createresult( 1, 1, 8 );
    }
    
    profilestop();
    return createresult();
}

// Namespace ztron_tutorial
// Params 0
// Checksum 0xded63565, Offset: 0xee4
// Size: 0x47
function function_82349cd090a76f15()
{
    profilestart();
    
    if ( function_e5313195f2ef217d( 2 ) && !level.ztron.var_74a3707334cfe144 )
    {
        function_59b355957644682a( "crab_hint_context_changeview" );
        profilestop();
        return createresult( 1, 1, 8 );
    }
    
    profilestop();
    return createresult();
}

// Namespace ztron_tutorial
// Params 0
// Checksum 0x762223d9, Offset: 0xf35
// Size: 0x76
function function_1db0328a3db8b5fb()
{
    profilestart();
    showhint = 0;
    player = level.players[ 0 ];
    
    if ( player.ztron.var_1a211bbcccca1c46.size > 0 )
    {
        showhint = 1;
    }
    
    if ( showhint && function_e5313195f2ef217d( 1 ) )
    {
        function_59b355957644682a( "crab_hint_context_chicken" );
        profilestop();
        return createresult( 1, 1, 8 );
    }
    
    profilestop();
    return createresult();
}

// Namespace ztron_tutorial
// Params 0
// Checksum 0x1bba7a2f, Offset: 0xfb5
// Size: 0xed
function function_d32b48f0d4628b15()
{
    profilestart();
    
    if ( function_e5313195f2ef217d( 1 ) )
    {
        foreach ( item in level.ztron.itemdef.spawneditems )
        {
            bundlename = ztron_item::function_2f7a695f25056625( item );
            itemtype = getscriptbundlefieldvalue( bundlename, #"genericstring" );
            
            if ( itemtype == #"money" )
            {
                function_59b355957644682a( "crab_hint_context_treasure" );
                profilestop();
                return createresult( 1, 1, 8 );
            }
        }
    }
    
    profilestop();
    return createresult();
}

// Namespace ztron_tutorial
// Params 0
// Checksum 0x4b05bee, Offset: 0x10ac
// Size: 0x2f
function function_2343eeab4bd5b320()
{
    profilestart();
    
    if ( function_e5313195f2ef217d( 4 ) )
    {
        function_59b355957644682a( "crab_hint_context_poppy" );
        profilestop();
        return createresult( 1, 1, 8 );
    }
    
    profilestop();
    return createresult();
}

// Namespace ztron_tutorial
// Params 0
// Checksum 0xa09f5c55, Offset: 0x10e5
// Size: 0x60
function function_a274393907491deb()
{
    profilestart();
    openexits = level.ztron.active_arena.openexits;
    
    if ( openexits.size > 0 && function_e5313195f2ef217d( 1 ) )
    {
        function_59b355957644682a( "crab_hint_exit" );
        profilestop();
        return createresult( 1, 0, 8 );
    }
    
    profilestop();
    return createresult();
}

// Namespace ztron_tutorial
// Params 0
// Checksum 0x15e0cfad, Offset: 0x114f
// Size: 0x61
function function_d0e1947b7397e103()
{
    profilestart();
    openteleporter = level.ztron.active_arena.teleportertrigger;
    
    if ( isdefined( openteleporter ) && function_e5313195f2ef217d( 4 ) )
    {
        function_59b355957644682a( "crab_hint_teleporter" );
        profilestop();
        return createresult( 1, 1, 8, 1 );
    }
    
    profilestop();
    return createresult();
}

// Namespace ztron_tutorial
// Params 1
// Checksum 0xc2ab073a, Offset: 0x11ba
// Size: 0x5d
function function_6e9e682693a19713( minlevel )
{
    profilestart();
    
    if ( isdefined( level.ztron.slayer.var_41aef428e6e941da ) && function_e5313195f2ef217d( 4 ) )
    {
        function_59b355957644682a( "crab_hint_slayer_arena" );
        profilestop();
        return createresult( 1, 1, 8, 1 );
    }
    
    profilestop();
    return createresult();
}

// Namespace ztron_tutorial
// Params 0
// Checksum 0xfda24f9b, Offset: 0x1221
// Size: 0x2d
function function_55d24ef73f6e962()
{
    profilestart();
    
    if ( function_e5313195f2ef217d( 3 ) )
    {
        function_59b355957644682a( "crab_map_hint" );
        profilestop();
        return createresult( 1, 1 );
    }
    
    profilestop();
    return createresult();
}

// Namespace ztron_tutorial
// Params 0
// Checksum 0x44238fcf, Offset: 0x1258
// Size: 0x6a
function function_d54bd06fc2685c06()
{
    profilestart();
    player = level.players[ 0 ];
    
    if ( function_e5313195f2ef217d( 1 ) && player.ztron.score.multix == 1 )
    {
        function_59b355957644682a( "crab_score_hint" );
        profilestop();
        return createresult( 1, 1 );
    }
    
    profilestop();
    return createresult();
}

// Namespace ztron_tutorial
// Params 0
// Checksum 0x70ba48e9, Offset: 0x12cc
// Size: 0x31
function function_ae6bccb5f35f6607()
{
    profilestart();
    
    if ( function_e5313195f2ef217d( 1 ) )
    {
        function_59b355957644682a( "crab_rumor" );
        profilestop();
        return createresult( 1, 1, 5, 1 );
    }
    
    profilestop();
    return createresult();
}

// Namespace ztron_tutorial
// Params 0, eflags: 0xc
// Checksum 0xafee09d6, Offset: 0x1307
// Size: 0x8e
function private function_846b66d0a75d6d1f()
{
    self notify( #"hash_190e881d7fb9fe19" );
    self endon( #"hash_190e881d7fb9fe19" );
    self endon( #"ztron_game_is_over" );
    level.ztron.var_98b3d7b76e30093b = self;
    level.ztron.var_8d18c04616c2ee18 = self getentitynumber();
    self waittill( #"death_or_disconnect" );
    level.ztron.var_98b3d7b76e30093b = undefined;
    level.ztron.var_8d18c04616c2ee18 = undefined;
    function_7b0de27d6b91ff9c();
}

// Namespace ztron_tutorial
// Params 0, eflags: 0x4
// Checksum 0xbc402730, Offset: 0x139d
// Size: 0x15
function private function_92280210494314d4()
{
    return level.ztron.var_8d18c04616c2ee18;
}

// Namespace ztron_tutorial
// Params 0, eflags: 0x4
// Checksum 0x31aa5872, Offset: 0x13bb
// Size: 0x25
function private function_7b0de27d6b91ff9c()
{
    var_8d18c04616c2ee18 = function_92280210494314d4();
    setomnvar( "ui_ztron_crab_ent_num", var_8d18c04616c2ee18 ?? -1 );
}

