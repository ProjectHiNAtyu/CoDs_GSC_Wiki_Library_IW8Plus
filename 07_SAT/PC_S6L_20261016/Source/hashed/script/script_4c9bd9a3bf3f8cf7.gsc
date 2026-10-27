// script_4c9bd9a3bf3f8cf7  (hash_4c9bd9a3bf3f8cf7.gscc) (size: 30658 Bytes / 0x77c2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xf02e57ba (4029568954)
// size ...... 30658 (0x77c2)
// includes .. 27  (offset: 0x6d7e)
// strings ... 138 (offset: 0x6e56)
// dev strs .. 18  (offset: 0x76e2)
// exports ... 54  (offset: 0x503a)
// cseg ...... 0xf00 + 0x413a (0x503a)
// imports ... 164 (offset: 0x58aa)
// animtree1 . 0   (offset: 0x77c2)
// animtree2 . 0   (offset: 0x77c2)
#using script_23eca243497ca70a;
#using script_2444b97a3516cbb0;
#using script_26ccbfe3954cacf4;
#using script_4a7080e904a6380e;
#using script_72af5a878a9d3397;
#using scripts\common\bots\bots_util;
#using scripts\common\utility;
#using scripts\mp\bots\bots;
#using scripts\mp\bots\bots_gametype_br_super;
#using scripts\mp\bots\bots_gametype_super_shared;
#using scripts\mp\bots\bots_loadout;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_gulag;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_spawnrespawn;
#using scripts\mp\br\gametypes\br_utility;
#using scripts\mp\common\utility\game;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\squad_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\gamelogic;
#using scripts\mp\parachute;
#using scripts\mp\teams;

#namespace ui_bot;

// Namespace ui_bot
// Params 3
// Checksum 0x56a5eaab, Offset: 0xf1e
// Size: 0x1a8, Type: bool
function canberecycled( type = undefined, var_fc7dc7ebd7f2418e = 1, var_47e323e2ad47d813 = 1 )
{
    if ( !isbot( self ) )
    {
        return false;
    }
    
    /#
        if ( manager::function_5038e868414d50c0() )
        {
            return ( type == 5 );
        }
    #/
    
    if ( !isdefined( self ) )
    {
        super_bot::function_cb27523a07bf9c83( 2, undefined, "ui_bot::canberecycled", "failed due to bot is undefined! Skip recycle.", "" );
        return false;
    }
    
    if ( self.var_a68c9cea27c8f116 )
    {
        super_bot::function_cb27523a07bf9c83( 1, self, "ui_bot::canberecycled", "failed due to botForceNoRecycle is true.", "" );
        return false;
    }
    
    if ( var_fc7dc7ebd7f2418e && !function_803f0e3dae4c3631() )
    {
        super_bot::function_cb27523a07bf9c83( 1, self, "ui_bot::canberecycled", "failed due to checkFunctioning && !RecycleFunctioning().", "" );
        return false;
    }
    
    var_b15c4f7d33f88970 = getdvarint( @"hash_ee5db01e337b58a8", 0 );
    var_77eb03c7cfdc21f4 = var_b15c4f7d33f88970 && br_public::isplayeringulag() && !isalive( self );
    
    if ( !var_77eb03c7cfdc21f4 && br_public::isplayerinorgoingtogulag() )
    {
        super_bot::function_cb27523a07bf9c83( 1, self, "ui_bot::canberecycled", "failed due to self br_public::isPlayerInOrGoingToGulag().", "" );
        return false;
    }
    
    if ( var_47e323e2ad47d813 && function_9faf63b8dddbcc93() )
    {
        super_bot::function_cb27523a07bf9c83( 1, self, "ui_bot::canberecycled", "failed due to checkHumanTeammate && self HasHumanTeammate().", "" );
        return false;
    }
    
    if ( self.waitingtospawn )
    {
        super_bot::function_cb27523a07bf9c83( 1, self, "ui_bot::canberecycled", "failed due to self.waitingToSpawn.", "" );
        return false;
    }
    
    if ( !self.var_e97e3258eda72385 )
    {
        super_bot::function_cb27523a07bf9c83( 1, self, "ui_bot::canberecycled", "failed due to !self.btThinkCalled.", "" );
        return false;
    }
    
    return true;
}

// Namespace ui_bot
// Params 0
// Checksum 0xb8bd63cb, Offset: 0x10cf
// Size: 0x3d, Type: bool
function function_803f0e3dae4c3631()
{
    /#
        if ( getdvarint( @"hash_d95f6cfac74fa872", 0 ) )
        {
            return false;
        }
    #/
    
    if ( level.uibotmanager.var_9d03093deceb509e )
    {
        return false;
    }
    
    if ( manager::islategame() )
    {
        return false;
    }
    
    return true;
}

// Namespace ui_bot
// Params 0
// Checksum 0x2ecb5ec1, Offset: 0x1115
// Size: 0x15c, Type: bool
function function_9faf63b8dddbcc93()
{
    if ( !bots_gametype_br_super::function_3130ca8d103182cd() )
    {
        return false;
    }
    
    if ( gamelogic_mp::inprematch() )
    {
        var_8edadc37f77744f7 = 0;
        partymembers = getpartyinfo( var_8edadc37f77744f7 );
        
        foreach ( memberinfo in partymembers )
        {
            if ( !memberinfo.isai && memberinfo.team == self.team )
            {
                return true;
            }
        }
    }
    else
    {
        teammates = teams::getteamdata( self.team, "players" );
        
        foreach ( player in teammates )
        {
            if ( !isbot( player ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace ui_bot
// Params 2
// Checksum 0x85564488, Offset: 0x127a
// Size: 0x56, Type: bool
function tryrecycle( reason = "", type )
{
    super_bot::function_cb27523a07bf9c83( 1, self, "ui_bot::tryrecycle", "reason: " + reason, "" );
    
    if ( canberecycled( type ) )
    {
        recycle( reason, type );
        return true;
    }
    
    return false;
}

// Namespace ui_bot
// Params 2
// Checksum 0xf403c2d, Offset: 0x12d9
// Size: 0x59
function recycle( reason = "unknown reason", type )
{
    assert( isbot( self ) );
    self.uibot.recyclereason = strtok( reason, " " )[ 0 ];
    thread deactivatethread( reason, type );
}

// Namespace ui_bot
// Params 2, eflags: 0x4
// Checksum 0x89ebbb98, Offset: 0x133a
// Size: 0x166
function private deactivatethread( reason = "", type )
{
    if ( recycle_manager::isenabled() && manager::isuibot() )
    {
        super_bot::function_cb27523a07bf9c83( 2, self, "ui_bot::deactivatethread", "early return because this is already a UI bot.", "" );
        return;
    }
    
    isdormant = 0;
    
    if ( manager::function_5c79ebe77f7d0528() )
    {
        isdormant = 1;
        level.uibotmanager.dormantbots = arrayremove( level.uibotmanager.dormantbots, self );
    }
    
    namespace_ef4547f85724edd1::setenemy( undefined );
    botprofile = function_b34875f63c20c9fa( type );
    br_plunder::playersetplundercount( 0 );
    
    if ( recycle_manager::isenabled() )
    {
        if ( !recycle_manager::recycle( "uibot", isdormant ? "dormant" : "active" ) )
        {
            return;
        }
        
        addbotprofile( botprofile, reason );
        self.uibot.var_a29e5f57c1ef9e35 = 1;
        botprofile.botentity = self;
    }
    else
    {
        addbotprofile( botprofile, reason );
        self.uibot.var_a29e5f57c1ef9e35 = 1;
        self.var_872374f4e7788b22 = botprofile;
        bots_gametype_br_super::kickplayer( "uibot", isdormant ? "dormant" : "active" );
    }
    
    level notify( #"ui_bot_counter_updated" );
}

// Namespace ui_bot
// Params 1, eflags: 0x4
// Checksum 0xe1c8bfd5, Offset: 0x14a8
// Size: 0x1e6
function private function_b34875f63c20c9fa( type )
{
    botprofile = {};
    botprofile.uibot = 1;
    botprofile.name = self.name;
    botprofile.team = self.team;
    botprofile.squad = self.sessionsquadid;
    botprofile.gulaguses = self.gulaguses;
    botprofile.operatorcustomization = self.operatorcustomization;
    botprofile.difficulty = self botgetdifficulty();
    botprofile.mind_personality = self.mind_personality;
    botprofile.locked = 0;
    botprofile.plundercount = br_plunder::function_3c61b4a05ec0b894();
    botprofile.xuid = self.xuid;
    assert( isdefined( botprofile.xuid ) );
    botprofile.var_f47c3623b7703db4 = self.var_f47c3623b7703db4 ?? 0;
    botprofile.loadoutfieldupgrade1 = self.loadoutfieldupgrade1 ?? "none";
    botprofile.loadoutFieldUpgrade1Attachments = self.loadoutFieldUpgrade1Attachments ?? [];
    botprofile.loadoutfieldupgrade2 = self.loadoutfieldupgrade2 ?? "none";
    botprofile.loadoutFieldUpgrade2Attachments = self.loadoutFieldUpgrade2Attachments ?? [];
    
    if ( namespace_ddca46d216b096e2::isenabled() )
    {
        assert( isdefined( self.bba_id ) );
        botprofile.bba_id = self.bba_id;
    }
    
    botprofile.pers = self.pers;
    
    /#
        if ( type == 5 )
        {
            botprofile.origin = self getorigin();
        }
    #/
    
    return botprofile;
}

// Namespace ui_bot
// Params 2
// Checksum 0xd7517f77, Offset: 0x1697
// Size: 0x53
function activatesome( count, reason )
{
    for ( i = 0; i < count ; i++ )
    {
        botprofile = function_f5217c40f361a65f();
        
        if ( !isdefined( botprofile ) )
        {
            break;
        }
        
        botprofile activate( reason );
    }
}

// Namespace ui_bot
// Params 2
// Checksum 0xe16ef94a, Offset: 0x16f2
// Size: 0x342
function batchactivatesome( count, reason = "" )
{
    /#
        if ( !level.var_b345e58e92744c1d )
        {
            level.var_b345e58e92744c1d = { #var_a663c9d8d5984403:[], #index:0 };
        }
        
        var_1ccae597fa808a57 = level.var_b345e58e92744c1d.index;
        level.var_b345e58e92744c1d.index++;
        InvalidOpCode( 0x7, "<dev string:x24>", var_1ccae597fa808a57 );
        // Unknown operator ( 0x7, t11, Black Ops 7 )
    #/
    
    var_5df1cae9abd00c67 = function_6ce99bf6d7016a1a();
    var_5a32daf41a69de1 = getavailablebotprofiles( count, var_5df1cae9abd00c67 );
    
    foreach ( profile in var_5a32daf41a69de1 )
    {
        assert( function_2c29e15eca9cd08( profile.xuid, var_5df1cae9abd00c67 ) );
        setbotprofilelocked( profile, 1, reason );
        profile.activereason = reason;
        namespace_ddca46d216b096e2::function_8c422f920ddf62cb( profile, reason );
    }
    
    if ( recycle_manager::isenabled() )
    {
        bots = recycle_manager::activate( var_5a32daf41a69de1, &markuibot, "spawned_bots" );
    }
    else
    {
        bots = level namespace_ef4547f85724edd1::spawnbots( var_5a32daf41a69de1, undefined, &markuibot, undefined, "spawned_bots" );
    }
    
    if ( bots.size < var_5a32daf41a69de1.size )
    {
        super_bot::lograw( 2, "ui_bot::batchactivatesome", var_5a32daf41a69de1.size - bots.size + " bots failed to be spawned. reason: " + reason, "" );
        successcount = 0;
        
        foreach ( profile in var_5a32daf41a69de1 )
        {
            if ( isdefined( profile.bot ) )
            {
                successcount++;
                continue;
            }
            
            profile OnActivationFailed( reason );
        }
        
        assert( successcount == bots.size );
    }
    
    foreach ( bot in bots )
    {
        bot thread resumestatusthread( reason );
    }
    
    /#
        assert( isdefined( var_1ccae597fa808a57 ) && isdefined( level.var_b345e58e92744c1d.var_a663c9d8d5984403[ var_1ccae597fa808a57 ] ) );
        
        if ( level.var_b345e58e92744c1d.var_a663c9d8d5984403[ var_1ccae597fa808a57 ] == 0 )
        {
            level.var_b345e58e92744c1d.var_a663c9d8d5984403[ var_1ccae597fa808a57 ] = { #message:"<dev string:x3e>", #errorcode:0 };
        }
    #/
}

// Namespace ui_bot
// Params 1, eflags: 0x4
// Checksum 0xba7e37d9, Offset: 0x1a3c
// Size: 0x13c
function private resumestatusthread( reason = "" )
{
    bot = self;
    profile = bot.uibotprofile;
    
    if ( bots_util::function_deef484b5b3a3977() )
    {
        if ( !bot.var_e97e3258eda72385 )
        {
            msg = bot utility::waittill_any_in_array_return( [ "bt_think_called", "death_or_disconnect" ] );
            
            if ( !namespace_ef4547f85724edd1::isaliveplayer( bot ) )
            {
                profile OnActivationFailed( "msg=" + msg + " " + reason );
                return;
            }
        }
    }
    else
    {
        assertmsg( "<dev string:x3f>" );
    }
    
    if ( !namespace_ef4547f85724edd1::isvalidplayer( bot ) )
    {
        super_bot::function_cb27523a07bf9c83( 2, profile, "ui_bot::resumestatusthread", "bot become invalid! " + reason, "" );
    }
    
    bot namespace_ef4547f85724edd1::function_4c57819a44d79e03( "Activated - UI Bot" );
    bot clearplotarmortriggerhurt( reason );
    bot showplayer( 1, "ui_bot::ResumeStatusThread()" );
    bot player::function_e4f77222086e66b( 0 );
    br_utility::unmarkplayeraseliminated( bot );
    bot.inblackroom = undefined;
    level notify( #"ui_bot_counter_updated" );
    bot namespace_ddca46d216b096e2::function_4833f43f9011ad9f( "active", "uibot" );
}

// Namespace ui_bot
// Params 2
// Checksum 0x389d9eb0, Offset: 0x1b80
// Size: 0x3d
function showplayer( show, reason )
{
    if ( show )
    {
        player_utility::function_b54a1e23734ef07();
        player_utility::function_4688d689820ff1ed( reason );
        return;
    }
    
    player_utility::function_dbe5a52a6654a982();
    player_utility::function_9d378d725bb4831e( reason );
}

// Namespace ui_bot
// Params 2
// Checksum 0xa34fcf8, Offset: 0x1bc5
// Size: 0x2fe
function activate( reason = "", skiplock = 0 )
{
    /#
        if ( !level.var_b345e58e92744c1d )
        {
            level.var_b345e58e92744c1d = { #var_a663c9d8d5984403:[], #index:0 };
        }
        
        var_1ccae597fa808a57 = level.var_b345e58e92744c1d.index;
        level.var_b345e58e92744c1d.index++;
        InvalidOpCode( 0x7, "<dev string:x70>", var_1ccae597fa808a57 );
        // Unknown operator ( 0x7, t11, Black Ops 7 )
    #/
    
    level endon( #"game_ended" );
    
    if ( !skiplock )
    {
        setbotprofilelocked( self, 1, reason );
    }
    
    assert( self.locked );
    self.activereason = reason;
    namespace_ddca46d216b096e2::function_8c422f920ddf62cb( self, reason );
    
    if ( !function_2c29e15eca9cd08( self.xuid ) )
    {
        /#
            assert( isdefined( var_1ccae597fa808a57 ) && isdefined( level.var_b345e58e92744c1d.var_a663c9d8d5984403[ var_1ccae597fa808a57 ] ) );
            
            if ( level.var_b345e58e92744c1d.var_a663c9d8d5984403[ var_1ccae597fa808a57 ] == 0 )
            {
                level.var_b345e58e92744c1d.var_a663c9d8d5984403[ var_1ccae597fa808a57 ] = { #message:"<dev string:x81>", #errorcode:1 };
            }
        #/
        
        super_bot::function_cb27523a07bf9c83( 2, self, "ui_bot::activate", "Drop UI Bots due to invalid bot profile.", "" );
        OnActivationFailed( reason + "_InvalidBotProfile" );
        return;
    }
    
    if ( recycle_manager::isenabled() )
    {
        bots = recycle_manager::activate( [ self ], &markuibot, "spawned_bots" );
    }
    else
    {
        bots = level namespace_ef4547f85724edd1::spawnbots( [ self ], self.team, &markuibot, undefined, "spawned_bots" );
    }
    
    if ( bots.size == 0 )
    {
        /#
            assert( isdefined( var_1ccae597fa808a57 ) && isdefined( level.var_b345e58e92744c1d.var_a663c9d8d5984403[ var_1ccae597fa808a57 ] ) );
            
            if ( level.var_b345e58e92744c1d.var_a663c9d8d5984403[ var_1ccae597fa808a57 ] == 0 )
            {
                level.var_b345e58e92744c1d.var_a663c9d8d5984403[ var_1ccae597fa808a57 ] = { #message:"<dev string:xa9>", #errorcode:2 };
            }
        #/
        
        OnActivationFailed( reason );
        return;
    }
    
    bot = bots[ 0 ];
    bot resumestatusthread( reason );
    
    /#
        assert( isdefined( var_1ccae597fa808a57 ) && isdefined( level.var_b345e58e92744c1d.var_a663c9d8d5984403[ var_1ccae597fa808a57 ] ) );
        
        if ( level.var_b345e58e92744c1d.var_a663c9d8d5984403[ var_1ccae597fa808a57 ] == 0 )
        {
            level.var_b345e58e92744c1d.var_a663c9d8d5984403[ var_1ccae597fa808a57 ] = { #message:"<dev string:x3e>", #errorcode:0 };
        }
    #/
    
    return bot;
}

// Namespace ui_bot
// Params 1, eflags: 0x4
// Checksum 0x9e0794c, Offset: 0x1ecc
// Size: 0x7f
function private OnActivationFailed( reason = "" )
{
    namespace_ddca46d216b096e2::function_4b93c7b7fe71290c( self, "kickout", "uibot" );
    success = removebotprofile( self, reason + "_OnActivationFailed" );
    
    if ( !success )
    {
        return;
    }
    
    namespace_ddca46d216b096e2::function_8c422f920ddf62cb( self, reason + "_failed" );
    checkgameend();
    super_bot::function_cb27523a07bf9c83( 2, self, "ui_bot::onactivationfailed", "spawn fails! reason: " + reason, "" );
}

// Namespace ui_bot
// Params 0, eflags: 0x4
// Checksum 0x78497c98, Offset: 0x1f53
// Size: 0x4d
function private checkgameend()
{
    team = self.team;
    
    if ( manager::isteameliminated( team ) )
    {
        teams::setteamdata( team, "deathEvent", 0 );
        teams::modifyteamdata( team, "hasSpawned", 1 );
        [[ level.updategameevents ]]();
    }
}

// Namespace ui_bot
// Params 0
// Checksum 0x24737393, Offset: 0x1fa8
// Size: 0x136
function RecoverBotProfile()
{
    botprofile = self.uibotprofile;
    
    if ( isdefined( botprofile ) )
    {
        self.gulaguses = botprofile.gulaguses;
        self.var_f47c3623b7703db4 = botprofile.var_f47c3623b7703db4;
        
        if ( level.br_c130spawndone )
        {
            self.jumped = 1;
        }
        
        self.uibot.var_a29e5f57c1ef9e35 = 0;
        br_plunder::playersetplundercount( botprofile.plundercount );
        
        if ( !recycle_manager::isenabled() )
        {
            arraycopyinplace( botprofile.pers, self.pers );
        }
        
        self.clientid = self.pers[ "clientid" ];
        removebotprofile( botprofile, "RecoverBotProfile" );
        self.loadoutfieldupgrade1 = botprofile.loadoutfieldupgrade1;
        self.loadoutFieldUpgrade1Attachments = botprofile.loadoutFieldUpgrade1Attachments;
        self.loadoutfieldupgrade2 = botprofile.loadoutfieldupgrade2;
        self.loadoutFieldUpgrade2Attachments = botprofile.loadoutFieldUpgrade2Attachments;
        namespace_ddca46d216b096e2::function_8c422f920ddf62cb( botprofile, botprofile.activereason + "_succeeded" );
    }
}

// Namespace ui_bot
// Params 0
// Checksum 0x1e156b6c, Offset: 0x20e6
// Size: 0x55
function laterecoverbotprofile()
{
    if ( isdefined( self.uibotprofile ) )
    {
        self.operatorcustomization = self.uibotprofile.operatorcustomization;
        teams::setmodelfromcustomization();
        self.uibotprofile = undefined;
        super_bot::function_cb27523a07bf9c83( 1, self, "ui_bot::laterecoverbotprofile", "bot late recovered from uiBot.", "" );
    }
}

// Namespace ui_bot
// Params 2, eflags: 0x4
// Checksum 0x18208d8a, Offset: 0x2143
// Size: 0xf3, Type: bool
function private sortuibot( a, b )
{
    teama = level.teamdata[ a.team ];
    teamb = level.teamdata[ b.team ];
    var_ae576ebba9394c2 = teama[ "aliveCount" ] + teama[ "UIBotCount" ];
    var_ae575ebba93928f = teamb[ "aliveCount" ] + teamb[ "UIBotCount" ];
    
    if ( var_ae576ebba9394c2 != var_ae575ebba93928f )
    {
        return ( var_ae576ebba9394c2 < var_ae575ebba93928f );
    }
    
    if ( a.var_f47c3623b7703db4 != b.var_f47c3623b7703db4 )
    {
        return ( a.var_f47c3623b7703db4 < b.var_f47c3623b7703db4 );
    }
    
    if ( recycle_manager::isenabled() )
    {
        return ( isalive( a.botentity ) && !isalive( b.botentity ) );
    }
    
    return false;
}

// Namespace ui_bot
// Params 2, eflags: 0x4
// Checksum 0xad045e39, Offset: 0x223f
// Size: 0x21d
function private addbotprofile( botprofile, reason = "" )
{
    assert( !botprofile.locked );
    assert( isdefined( botprofile.var_f47c3623b7703db4 ) );
    level.uibotmanager.uibots[ level.uibotmanager.uibots.size ] = botprofile;
    size = level.uibotmanager.uibots.size;
    level.uibotmanager.uibots = arraysort( level.uibotmanager.uibots, undefined, &sortuibot );
    team = botprofile.team;
    var_3b183aba658355 = level.teamdata[ team ][ "UIBotCount" ];
    
    if ( var_3b183aba658355 < 0 )
    {
        super_bot::function_cb27523a07bf9c83( 2, botprofile, "ui_bot::addbotprofile", "UIBotCount is negative before adding! UIBotCountOld=" + var_3b183aba658355 + " reason=" + reason, "" );
    }
    
    level.teamdata[ team ][ "UIBotCount" ]++;
    var_f435ec3ab27eceae = level.teamdata[ team ][ "UIBotCount" ];
    var_834fa6e9b20b752e = level.teamdata[ team ][ "UnlockedUIBotCount" ];
    
    if ( var_834fa6e9b20b752e < 0 )
    {
        super_bot::function_cb27523a07bf9c83( 2, botprofile, "ui_bot::addbotprofile", "UnlockedUIBotCount is negative before adding! UnlockedUIBotCountOld=" + var_834fa6e9b20b752e + " reason=" + reason, "" );
    }
    
    level.teamdata[ team ][ "UnlockedUIBotCount" ]++;
    var_951aaee9c04b36d9 = level.teamdata[ team ][ "UnlockedUIBotCount" ];
    super_bot::function_cb27523a07bf9c83( 1, botprofile, "ui_bot::addbotprofile", "size=" + size + " UIBotCountOld=" + var_3b183aba658355 + " UIBotCountNew=" + var_f435ec3ab27eceae + " UnlockedUIBotCountOld=" + var_834fa6e9b20b752e + " UnlockedUIBotCountNew=" + var_951aaee9c04b36d9 + " reason=" + reason, "" );
    validateuibotcount( botprofile );
}

// Namespace ui_bot
// Params 2, eflags: 0x4
// Checksum 0x53acc187, Offset: 0x2464
// Size: 0x1a3, Type: bool
function private removebotprofile( botprofile, reason = "" )
{
    sizebefore = level.uibotmanager.uibots.size;
    level.uibotmanager.uibots = arrayremove( level.uibotmanager.uibots, botprofile );
    
    if ( sizebefore == level.uibotmanager.uibots.size )
    {
        super_bot::function_cb27523a07bf9c83( 2, botprofile, "ui_bot::removebotprofile", "RemoveBotProfile failed! reason=" + reason, "" );
        return false;
    }
    
    if ( !botprofile.locked )
    {
        super_bot::function_cb27523a07bf9c83( 2, botprofile, "ui_bot::removebotprofile", "botProfile is not locked! reason=" + reason, "" );
    }
    
    team = botprofile.team;
    size = level.uibotmanager.uibots.size;
    
    if ( level.teamdata[ team ][ "UIBotCount" ] <= 0 )
    {
        super_bot::function_cb27523a07bf9c83( 2, botprofile, "ui_bot::removebotprofile", "UIBotCount is already 0 before removing! reason=" + reason, "" );
    }
    
    level.teamdata[ team ][ "UIBotCount" ]--;
    super_bot::function_cb27523a07bf9c83( 1, botprofile, "ui_bot::removebotprofile", "size=" + size + " UIBotCount=" + level.teamdata[ team ][ "UIBotCount" ] + " reason=" + reason, "" );
    validateuibotcount( botprofile );
    level notify( #"ui_bot_counter_updated" );
    return true;
}

// Namespace ui_bot
// Params 0
// Checksum 0xad27d612, Offset: 0x2610
// Size: 0x178
function DropUIBotsIfNecessary()
{
    if ( !game_utility_mp::matchmakinggame() )
    {
        return;
    }
    
    if ( !manager::isinitialized() )
    {
        return;
    }
    
    uibots = manager::function_cda6de7e2ba52066();
    
    if ( uibots.size == 0 )
    {
        return;
    }
    
    var_5df1cae9abd00c67 = function_6ce99bf6d7016a1a();
    var_4cd5f6488c8e65e9 = [];
    
    foreach ( profile in uibots )
    {
        if ( !profile.locked && !function_2c29e15eca9cd08( profile.xuid, var_5df1cae9abd00c67 ) )
        {
            var_4cd5f6488c8e65e9[ var_4cd5f6488c8e65e9.size ] = profile;
        }
    }
    
    foreach ( profile in var_4cd5f6488c8e65e9 )
    {
        super_bot::function_cb27523a07bf9c83( 1, profile, "ui_bot::dropuibotsifnecessary", "forcing removal of bot profile due to invalid XUid", "" );
        setbotprofilelocked( profile, 1, "DropUIBotsIfNecessary" );
        removebotprofile( profile, "DropUIBotsIfNecessary" );
    }
}

// Namespace ui_bot
// Params 2, eflags: 0x4
// Checksum 0x9f83b404, Offset: 0x2790
// Size: 0x4c, Type: bool
function private function_2c29e15eca9cd08( var_8c7481ef6674aaec, var_5df1cae9abd00c67 )
{
    if ( !isdefined( var_8c7481ef6674aaec ) || var_8c7481ef6674aaec == "" )
    {
        return true;
    }
    
    if ( !game_utility_mp::matchmakinggame() )
    {
        return true;
    }
    
    if ( !isdefined( var_5df1cae9abd00c67 ) )
    {
        var_5df1cae9abd00c67 = function_6ce99bf6d7016a1a();
    }
    
    return isdefined( var_5df1cae9abd00c67[ int( var_8c7481ef6674aaec ) ] );
}

// Namespace ui_bot
// Params 1
// Checksum 0x4dfc0a90, Offset: 0x27e5
// Size: 0x1c3
function validateuibotcount( botprofile )
{
    team = botprofile.team;
    countinuibotmanager = 0;
    unlockedcountinuibotmanager = 0;
    
    foreach ( uibot in level.uibotmanager.uibots )
    {
        if ( uibot.team == team )
        {
            countinuibotmanager++;
            
            if ( !uibot.locked )
            {
                unlockedcountinuibotmanager++;
            }
        }
    }
    
    countinteamdata = level.teamdata[ team ][ "UIBotCount" ];
    unlockedcountinteamdata = level.teamdata[ team ][ "UnlockedUIBotCount" ];
    
    if ( countinteamdata < 0 )
    {
        super_bot::function_cb27523a07bf9c83( 2, botprofile, "ui_bot::validateuibotcount", "UIBotCount is negative! team=" + team, "" );
    }
    
    if ( unlockedcountinteamdata < 0 )
    {
        super_bot::function_cb27523a07bf9c83( 2, botprofile, "ui_bot::validateuibotcount", "UnlockedUIBotCount is negative! team=" + team, "" );
    }
    
    if ( countinuibotmanager != countinteamdata )
    {
        super_bot::function_cb27523a07bf9c83( 2, botprofile, "ui_bot::validateuibotcount", "UIBotCount mismatch! team=" + team + " countInUIBotManager=" + countinuibotmanager + " countInTeamData=" + countinteamdata, "" );
    }
    
    if ( unlockedcountinuibotmanager != unlockedcountinteamdata )
    {
        super_bot::function_cb27523a07bf9c83( 2, botprofile, "ui_bot::validateuibotcount", "UnlockedUIBotCount mismatch! team=" + team + " unlockedCountInUIBotManager=" + unlockedcountinuibotmanager + " unlockedCountInTeamData=" + unlockedcountinteamdata, "" );
    }
}

// Namespace ui_bot
// Params 3, eflags: 0x4
// Checksum 0xa63d9c7c, Offset: 0x29b0
// Size: 0x1de
function private setbotprofilelocked( botprofile, lock, reason = "" )
{
    team = botprofile.team;
    str = "UnlockedUIBotCount=" + level.teamdata[ team ][ "UnlockedUIBotCount" ] + " reason=" + reason;
    
    if ( lock )
    {
        if ( level.teamdata[ team ][ "UnlockedUIBotCount" ] <= 0 )
        {
            super_bot::function_cb27523a07bf9c83( 2, botprofile, "ui_bot::setbotprofilelocked", "UnlockedUIBotCount <= 0! " + str, "" );
            return;
        }
        
        if ( botprofile.locked )
        {
            super_bot::function_cb27523a07bf9c83( 2, botprofile, "ui_bot::setbotprofilelocked", "profile is locked! " + str, "" );
            return;
        }
        
        botprofile.locked = 1;
        botprofile.var_83caa7f8fa0dbaad = gettime();
        level.teamdata[ team ][ "UnlockedUIBotCount" ]--;
        str = "UnlockedUIBotCount=" + level.teamdata[ team ][ "UnlockedUIBotCount" ] + " reason=" + reason;
        super_bot::function_cb27523a07bf9c83( 1, botprofile, "ui_bot::setbotprofilelocked", "locked a bot profile. " + str, "" );
        return;
    }
    
    if ( !botprofile.locked )
    {
        super_bot::function_cb27523a07bf9c83( 2, botprofile, "ui_bot::setbotprofilelocked", "profile is unlocked! " + str, "" );
        return;
    }
    
    botprofile.locked = 0;
    botprofile.var_83caa7f8fa0dbaad = undefined;
    level.teamdata[ team ][ "UnlockedUIBotCount" ]++;
    str = "UnlockedUIBotCount=" + level.teamdata[ team ][ "UnlockedUIBotCount" ] + " reason=" + reason;
    super_bot::function_cb27523a07bf9c83( 1, botprofile, "ui_bot::setbotprofilelocked", "unlocked a bot profile. " + str, "" );
}

// Namespace ui_bot
// Params 0, eflags: 0x4
// Checksum 0x232872c0, Offset: 0x2b96
// Size: 0xbe
function private markuibot()
{
    self.uibot = spawnstruct();
    self.uibot.var_a29e5f57c1ef9e35 = 1;
    self.uibot.var_191c0906225a5001 = 1;
    
    if ( isdefined( level.uibotmanager.var_7dc27bc9fa62c763 ) )
    {
        spawnpoint = spawnstruct();
        spawnpoint.origin = level.uibotmanager.var_7dc27bc9fa62c763;
        spawnpoint.angles = ( 0, 0, 0 );
        spawnpoint.index = -1;
        self.prespawnspawn = spawnpoint;
        self.inblackroom = 1;
    }
}

// Namespace ui_bot
// Params 0
// Checksum 0xef072973, Offset: 0x2c5c
// Size: 0x1c
function function_19725f864aa10661()
{
    profilestart();
    assert( isbot( self ) );
    self.var_94c132803381c24c = 1;
    profilestop();
}

// Namespace ui_bot
// Params 0
// Checksum 0x53e79c53, Offset: 0x2c80
// Size: 0x16
function function_7f7e3bf95fb723cd()
{
    profilestart();
    
    if ( isbot( self ) )
    {
        self.var_94c132803381c24c = undefined;
    }
    
    profilestop();
}

// Namespace ui_bot
// Params 0
// Checksum 0xcc82814d, Offset: 0x2c9e
// Size: 0x18
function function_9f76c7655b16ed66()
{
    profilestart();
    
    if ( isbot( self ) )
    {
        profilestop();
        return self.var_94c132803381c24c;
    }
    
    profilestop();
    return 0;
}

// Namespace ui_bot
// Params 4
// Checksum 0x95374132, Offset: 0x2cc0
// Size: 0x106
function killsome( count, var_2cc4eb588d7f81a5, reason, var_43ee6a728032df30 )
{
    if ( count <= 0 )
    {
        return;
    }
    
    finalreason = "Killsome_" + reason;
    
    for ( i = 0; i < count ; i++ )
    {
        excludeteam = undefined;
        var_5a32daf41a69de1 = getavailablebotprofiles_internal( var_2cc4eb588d7f81a5 );
        botprofile = function_f5217c40f361a65f( excludeteam, var_5a32daf41a69de1 );
        
        if ( !isdefined( botprofile ) )
        {
            break;
        }
        
        var_d9287068b2cedc72 = botprofile activate( finalreason );
        
        if ( isdefined( var_d9287068b2cedc72 ) )
        {
            if ( var_2cc4eb588d7f81a5 )
            {
                var_d9287068b2cedc72.gulaguses = undefined;
                var_d9287068b2cedc72.var_deee3117dd8405fb = 1;
                var_d9287068b2cedc72.var_43ee6a728032df30 = var_43ee6a728032df30;
            }
            
            wait 1;
            
            if ( bots_gametype_br_super::isvalidbot( var_d9287068b2cedc72 ) )
            {
                var_d9287068b2cedc72.disabledropondeath = 1;
                var_d9287068b2cedc72 function_19725f864aa10661();
                var_d9287068b2cedc72 suicide();
            }
        }
    }
}

// Namespace ui_bot
// Params 2, eflags: 0x4
// Checksum 0x3213871c, Offset: 0x2dce
// Size: 0x160
function private function_5026e092bde66d9b( var_5a32daf41a69de1 = getavailablebotprofiles_internal( 1 ), radius = 7800 )
{
    if ( var_5a32daf41a69de1.size == 0 )
    {
        return;
    }
    
    teammembers = teams::getteamdata( self.team, "players" );
    var_387866edce1dd08f = utility::playersinsphere( self.origin, radius, teammembers );
    
    if ( var_387866edce1dd08f.size == 0 )
    {
        return;
    }
    
    var_c3631e6d9a298952 = [];
    
    for ( i = 0; i < var_5a32daf41a69de1.size ; i++ )
    {
        botprofile = var_5a32daf41a69de1[ i ];
        team = botprofile.team;
        
        if ( !isdefined( var_c3631e6d9a298952[ team ] ) )
        {
            var_c3631e6d9a298952[ team ] = botprofile;
        }
    }
    
    if ( var_387866edce1dd08f.size > 1 )
    {
        var_387866edce1dd08f = function_628bac9faa9d1e86( var_387866edce1dd08f, self.origin );
    }
    
    for ( i = 0; i < var_387866edce1dd08f.size ; i++ )
    {
        player = var_387866edce1dd08f[ i ];
        botprofile = var_c3631e6d9a298952[ player.team ];
        
        if ( !isdefined( botprofile ) )
        {
            continue;
        }
        
        if ( !namespace_ef4547f85724edd1::isvalidplayer( player ) )
        {
            continue;
        }
        
        var_6b9c1eb08419fff4 = { #nearbyplayerpos:player.origin, #botprofile:botprofile };
        return var_6b9c1eb08419fff4;
    }
}

// Namespace ui_bot
// Params 2
// Checksum 0xa14aaa5a, Offset: 0x2f37
// Size: 0x64
function function_f5217c40f361a65f( excludeteam, var_5a32daf41a69de1 = getavailablebotprofiles_internal( 1 ) )
{
    for ( i = 0; i < var_5a32daf41a69de1.size ; i++ )
    {
        botprofile = var_5a32daf41a69de1[ i ];
        
        if ( botprofile.team == excludeteam )
        {
            continue;
        }
        
        return botprofile;
    }
}

// Namespace ui_bot
// Params 2, eflags: 0x4
// Checksum 0x241c73a3, Offset: 0x2fa4
// Size: 0x47
function private getavailablebotprofiles( count, var_5df1cae9abd00c67 )
{
    assert( count > 0 && count <= level.uibotmanager.uibots.size );
    return getavailablebotprofiles_internal( 1, count, var_5df1cae9abd00c67 );
}

// Namespace ui_bot
// Params 2, eflags: 0x4
// Checksum 0xf57f68, Offset: 0x2ff4
// Size: 0x2d0
function private function_75d7cd5f4a3435fa( var_ee3e17bebe445443, var_5a32daf41a69de1 )
{
    if ( var_ee3e17bebe445443 <= 1 )
    {
        return;
    }
    
    if ( !isdefined( var_5a32daf41a69de1 ) )
    {
        var_5a32daf41a69de1 = getavailablebotprofiles_internal( 1 );
    }
    
    if ( var_5a32daf41a69de1.size <= 1 )
    {
        return;
    }
    
    teamdatas = [];
    
    for ( i = 0; i < var_5a32daf41a69de1.size ; i++ )
    {
        team = var_5a32daf41a69de1[ i ].team;
        
        if ( !isdefined( teamdatas[ team ] ) )
        {
            teamdatas[ team ] = { #teamsize:0, #firstindex:i };
        }
        
        teamdatas[ team ].teamsize++;
    }
    
    var_7804c752c049e408 = [];
    
    foreach ( team, data in teamdatas )
    {
        if ( !isdefined( var_7804c752c049e408[ data.teamsize ] ) )
        {
            var_7804c752c049e408[ data.teamsize ] = [];
        }
        
        var_7804c752c049e408[ data.teamsize ][ var_7804c752c049e408[ data.teamsize ].size ] = team;
    }
    
    candidateteams = undefined;
    returncount = undefined;
    maxsquadsize = squad_utility::getmaxsquadsize();
    
    for ( teamsize = var_ee3e17bebe445443; teamsize <= maxsquadsize ; teamsize++ )
    {
        candidateteams = var_7804c752c049e408[ teamsize ];
        
        if ( isdefined( candidateteams ) )
        {
            returncount = var_ee3e17bebe445443;
            break;
        }
    }
    
    if ( !isdefined( candidateteams ) )
    {
        for ( teamsize = var_ee3e17bebe445443 - 1; teamsize >= 2 ; teamsize-- )
        {
            candidateteams = var_7804c752c049e408[ teamsize ];
            
            if ( isdefined( candidateteams ) )
            {
                returncount = teamsize;
                break;
            }
        }
        
        if ( !isdefined( candidateteams ) )
        {
            return;
        }
    }
    
    targetteam = undefined;
    minindex = undefined;
    
    foreach ( team in candidateteams )
    {
        index = teamdatas[ team ].firstindex;
        
        if ( index >= minindex )
        {
            continue;
        }
        
        targetteam = team;
        minindex = index;
    }
    
    var_fc2455e793daac06 = [];
    var_fc2455e793daac06[ 0 ] = var_5a32daf41a69de1[ minindex ];
    
    for ( i = minindex + 1; i < var_5a32daf41a69de1.size ; i++ )
    {
        botprofile = var_5a32daf41a69de1[ i ];
        
        if ( botprofile.team == targetteam )
        {
            var_fc2455e793daac06[ var_fc2455e793daac06.size ] = botprofile;
            
            if ( var_fc2455e793daac06.size >= returncount )
            {
                return var_fc2455e793daac06;
            }
        }
    }
}

// Namespace ui_bot
// Params 3, eflags: 0x4
// Checksum 0xaf5a0c0c, Offset: 0x32cd
// Size: 0x20d
function private getavailablebotprofiles_internal( forwardorder, var_68ef6d428ef175c1, var_5df1cae9abd00c67 )
{
    assert( !isdefined( var_68ef6d428ef175c1 ) || var_68ef6d428ef175c1 > 0 );
    result = [];
    
    if ( level.uibotmanager.uibots.size == 0 )
    {
        return result;
    }
    
    if ( !isdefined( var_68ef6d428ef175c1 ) )
    {
        var_68ef6d428ef175c1 = level.uibotmanager.uibots.size;
    }
    
    if ( forwardorder )
    {
        beginindex = 0;
        endindex = level.uibotmanager.uibots.size;
        increment = 1;
    }
    else
    {
        beginindex = level.uibotmanager.uibots.size - 1;
        endindex = -1;
        increment = -1;
    }
    
    if ( game_utility_mp::matchmakinggame() )
    {
        if ( !isdefined( var_5df1cae9abd00c67 ) )
        {
            var_5df1cae9abd00c67 = function_6ce99bf6d7016a1a();
        }
        
        if ( var_5df1cae9abd00c67.size == 0 )
        {
            super_bot::lograw( 2, "ui_bot::getavailablebotprofiles_internal", "No valid party member XUids found! All uibot profiles are unusable.", "[GhostBot]" );
            return result;
        }
    }
    
    i = beginindex;
    
    while ( i != endindex )
    {
        botprofile = level.uibotmanager.uibots[ i ];
        
        if ( botprofile.locked )
        {
            if ( isdefined( botprofile.var_83caa7f8fa0dbaad ) && gettime() - botprofile.var_83caa7f8fa0dbaad > 30000 && !botprofile.var_8d09f14cd1f78fad )
            {
                botprofile.var_8d09f14cd1f78fad = 1;
                super_bot::function_cb27523a07bf9c83( 2, botprofile, "ui_bot::getavailablebotprofiles_internal", "Bot profile has been locked for a long time! lockedTimeMS=" + botprofile.var_83caa7f8fa0dbaad, "[GhostBot]" );
            }
        }
        else if ( !function_2c29e15eca9cd08( botprofile.xuid, var_5df1cae9abd00c67 ) )
        {
            super_bot::function_cb27523a07bf9c83( 2, botprofile, "ui_bot::getavailablebotprofiles_internal", "Bot profile has an invalid XUid!", "[GhostBot]" );
        }
        else
        {
            result[ result.size ] = botprofile;
            var_68ef6d428ef175c1--;
            
            if ( var_68ef6d428ef175c1 == 0 )
            {
                break;
            }
        }
        
        i += increment;
    }
    
    return result;
}

// Namespace ui_bot
// Params 2
// Checksum 0xe43816d6, Offset: 0x34e3
// Size: 0x5e5
function DeployEngagingBotsThread( var_b24ecf0a1e3b89fb, var_7d1337601407c4b6 )
{
    /#
        if ( !level.var_b345e58e92744c1d )
        {
            level.var_b345e58e92744c1d = { #var_a663c9d8d5984403:[], #index:0 };
        }
        
        var_1ccae597fa808a57 = level.var_b345e58e92744c1d.index;
        level.var_b345e58e92744c1d.index++;
        InvalidOpCode( 0x7, "<dev string:xd8>", var_1ccae597fa808a57 );
        // Unknown operator ( 0x7, t11, Black Ops 7 )
    #/
    
    level endon( #"game_ended" );
    curtime = gettime();
    var_a5818385c7151a07 = function_6f24b57919b11c1b( var_b24ecf0a1e3b89fb, 0 );
    
    if ( isdefined( var_a5818385c7151a07 ) && curtime - var_a5818385c7151a07 < 3000 )
    {
        /#
            assert( isdefined( var_1ccae597fa808a57 ) && isdefined( level.var_b345e58e92744c1d.var_a663c9d8d5984403[ var_1ccae597fa808a57 ] ) );
            
            if ( level.var_b345e58e92744c1d.var_a663c9d8d5984403[ var_1ccae597fa808a57 ] == 0 )
            {
                level.var_b345e58e92744c1d.var_a663c9d8d5984403[ var_1ccae597fa808a57 ] = { #message:"<dev string:xf9>", #errorcode:1 };
            }
        #/
        
        return;
    }
    
    self.engageinfo.var_982d117bcb91e086 = curtime;
    deploydata = function_a6c935fb19135b81( var_7d1337601407c4b6 );
    
    if ( !isdefined( deploydata ) )
    {
        /#
            assert( isdefined( var_1ccae597fa808a57 ) && isdefined( level.var_b345e58e92744c1d.var_a663c9d8d5984403[ var_1ccae597fa808a57 ] ) );
            
            if ( level.var_b345e58e92744c1d.var_a663c9d8d5984403[ var_1ccae597fa808a57 ] == 0 )
            {
                level.var_b345e58e92744c1d.var_a663c9d8d5984403[ var_1ccae597fa808a57 ] = { #message:"<dev string:x127>", #errorcode:2 };
            }
        #/
        
        return;
    }
    
    deployonground = function_488d507e7f603b59( deploydata );
    deploycount = deploydata.botprofiles.size;
    assert( deploycount >= 1 );
    humanname = self.name;
    humanpos = self.origin;
    humanangles = self.angles;
    var_780d54fd4dd5a286 = getdvarint( @"hash_358164e65d640280", level.var_d4909c0acc55763c.var_93264d75eb0d7414 ?? 390 );
    var_780d54fd4dd5a286 = max( var_780d54fd4dd5a286, 390 );
    
    if ( deployonground )
    {
        if ( br::isgulagshutdown() )
        {
            radiusextend = getdvarint( @"hash_f394eba720226431", 3700 );
            var_780d54fd4dd5a286 += radiusextend;
        }
        
        if ( level.uibotmanager.var_d3b6a107b3176710 && isdefined( deploydata.var_44fca6c910d4d347 ) )
        {
            anglerange = getdvarfloat( @"hash_d7323fbd7a4be87b", 90 );
            angles = vectortoangles( deploydata.var_44fca6c910d4d347 - humanpos );
            angle = angles[ 1 ];
            minangle = angle - anglerange * 0.5;
            maxangle = minangle + anglerange;
        }
        else
        {
            minangle = undefined;
            maxangle = undefined;
        }
        
        foreach ( botprofile in deploydata.botprofiles )
        {
            setbotprofilelocked( botprofile, 1, "DeployEngagingBotsThread" );
        }
        
        var_98afeeedc8d034b7 = 0;
        var_68a8183d6a6ee790 = undefined;
        
        for ( deployindex = 0; deployindex < deploycount ; deployindex++ )
        {
            botprofile = deploydata.botprofiles[ deployindex ];
            var_e0a58a13996877ef = deployindex == 0;
            
            if ( var_e0a58a13996877ef )
            {
                centerpos = humanpos;
                radius = var_780d54fd4dd5a286;
            }
            else
            {
                centerpos = var_68a8183d6a6ee790;
                radius = 400;
                wait 1;
            }
            
            bots_gametype_br_super::function_80d2eab106ef949d();
            bot = deployonebotonground( botprofile, centerpos, humanangles, radius, humanname, minangle, maxangle, 1, var_e0a58a13996877ef );
            
            if ( !isdefined( bot ) )
            {
                deployindex++;
                
                while ( deployindex < deploycount )
                {
                    botprofile = deploydata.botprofiles[ deployindex ];
                    setbotprofilelocked( botprofile, 0, "DeployEngagingBotsThread_UnlockAfterDeployFailed" );
                    deployindex++;
                }
                
                break;
            }
            
            if ( var_e0a58a13996877ef && deploycount > 1 )
            {
                var_68a8183d6a6ee790 = bot.origin;
            }
            
            bot postdeploy( deployonground, self, 1 );
            var_98afeeedc8d034b7++;
        }
        
        if ( isdefined( level.uibotmanager.var_e922d98b52d61f52[ var_98afeeedc8d034b7 ] ) )
        {
            level.uibotmanager.var_e922d98b52d61f52[ var_98afeeedc8d034b7 ]++;
        }
    }
    else
    {
        bot = deployonebotinair( deploydata.botprofiles[ 0 ], humanpos, humanangles, var_780d54fd4dd5a286, humanname );
        
        if ( isdefined( bot ) )
        {
            bot postdeploy( deployonground, self, 1 );
            
            if ( isdefined( level.uibotmanager.var_e922d98b52d61f52[ 1 ] ) )
            {
                level.uibotmanager.var_e922d98b52d61f52[ 1 ]++;
            }
        }
    }
    
    /#
        assert( isdefined( var_1ccae597fa808a57 ) && isdefined( level.var_b345e58e92744c1d.var_a663c9d8d5984403[ var_1ccae597fa808a57 ] ) );
        
        if ( level.var_b345e58e92744c1d.var_a663c9d8d5984403[ var_1ccae597fa808a57 ] == 0 )
        {
            level.var_b345e58e92744c1d.var_a663c9d8d5984403[ var_1ccae597fa808a57 ] = { #message:"<dev string:x3e>", #errorcode:0 };
        }
    #/
}

// Namespace ui_bot
// Params 2, eflags: 0x4
// Checksum 0x5d0880ef, Offset: 0x3ad0
// Size: 0xdf
function private function_6f24b57919b11c1b( players, var_1533edc7745d018 )
{
    var_93ab82593997e895 = undefined;
    
    foreach ( player in players )
    {
        lasttime = var_1533edc7745d018 ? player.engageinfo.var_bd9c2877a0cce082 : player.engageinfo.var_982d117bcb91e086;
        
        if ( !isdefined( lasttime ) )
        {
            continue;
        }
        
        if ( lasttime <= var_93ab82593997e895 )
        {
            continue;
        }
        
        var_93ab82593997e895 = lasttime;
    }
    
    return var_93ab82593997e895;
}

// Namespace ui_bot
// Params 1, eflags: 0x4
// Checksum 0x97a33bf6, Offset: 0x3bb8
// Size: 0x118
function private function_a6c935fb19135b81( var_7d1337601407c4b6 )
{
    /#
        if ( isdefined( var_7d1337601407c4b6 ) )
        {
            return function_4c1508ab88c6a1( var_7d1337601407c4b6 );
        }
    #/
    
    deploycount = function_531c7a499297c2f7();
    var_5a32daf41a69de1 = getavailablebotprofiles_internal( 1 );
    
    if ( deploycount > 1 )
    {
        botprofiles = function_75d7cd5f4a3435fa( deploycount, var_5a32daf41a69de1 );
        
        if ( botprofiles.size > 1 )
        {
            return { #botprofiles:botprofiles };
        }
        
        assert( !isdefined( botprofiles ) );
    }
    
    var_6b9c1eb08419fff4 = function_5026e092bde66d9b( var_5a32daf41a69de1 );
    
    if ( isdefined( var_6b9c1eb08419fff4 ) )
    {
        botprofile = var_6b9c1eb08419fff4.botprofile;
        assert( isdefined( botprofile ) );
        var_44fca6c910d4d347 = var_6b9c1eb08419fff4.nearbyplayerpos;
        return { #var_44fca6c910d4d347:var_44fca6c910d4d347, #botprofiles:[ botprofile ] };
    }
    
    botprofile = function_f5217c40f361a65f( self.team, var_5a32daf41a69de1 );
    
    if ( isdefined( botprofile ) )
    {
        return { #botprofiles:[ botprofile ] };
    }
    
    return;
}

// Namespace ui_bot
// Params 0, eflags: 0x4
// Checksum 0xf38c4693, Offset: 0x3cd8
// Size: 0x9a
function private function_531c7a499297c2f7()
{
    weightdata = level.uibotmanager.var_ed63de32b7d40373;
    
    if ( !isdefined( weightdata ) )
    {
        return 1;
    }
    
    target = randomint( weightdata.sum );
    size = weightdata.list.size;
    
    for ( i = 0; i < size ; i++ )
    {
        if ( target < weightdata.list[ i ] )
        {
            return ( i + 1 );
        }
    }
    
    assertmsg( "<dev string:x152>" );
    return 1;
}

// Namespace ui_bot
// Params 1, eflags: 0x4
// Checksum 0x220c37c2, Offset: 0x3d7b
// Size: 0xde
function private function_488d507e7f603b59( deploydata )
{
    deploycount = deploydata.botprofiles.size;
    assert( deploycount >= 1 );
    
    /#
        var_7bfa438d39314912 = getdvarint( @"hash_ab6af73ba6902e7a", 0 );
        
        if ( var_7bfa438d39314912 == 1 || var_7bfa438d39314912 == 2 )
        {
            return ( var_7bfa438d39314912 == 1 );
        }
    #/
    
    if ( deploycount > 1 )
    {
        return 1;
    }
    
    airdeploychance = getdvarfloat( @"hash_e4a177febf5c5689", level.var_d4909c0acc55763c.airdeploychance ?? 0 );
    deploytype = randomfloat( 1 ) < airdeploychance ? 2 : 1;
    deployonground = deploytype == 1 || manager::function_55e0d31727ed1c59() || manager::function_7d5107561790e20e();
    return deployonground;
}

// Namespace ui_bot
// Params 3, eflags: 0x4
// Checksum 0x2d4e853d, Offset: 0x3e62
// Size: 0x94
function private postdeploy( deployonground, human, var_ebb917cb94e00839 )
{
    if ( deployonground )
    {
        if ( !self.var_e2512b84b839d80f )
        {
            thread bots_gametype_br_super::function_2a2373e4cc4e8da0();
        }
    }
    else if ( isdefined( self._blackboard ) )
    {
        self._blackboard.parachutingtarget = human;
    }
    
    self switchtoweapon( self.primaryweapons[ 0 ] );
    
    if ( var_ebb917cb94e00839 && isdefined( human ) )
    {
        human.engageinfo.var_3ab13186bc2c3343 = gettime();
    }
}

// Namespace ui_bot
// Params 4, eflags: 0x4
// Checksum 0x43c2e41f, Offset: 0x3efe
// Size: 0x209
function private logdeployposition( type, origin, bot, name )
{
    mindistancetoplayer = distance( origin, bot.origin );
    var_1aecf75ecfaea148 = bot;
    
    foreach ( player in level.players )
    {
        if ( bots_gametype_br_super::function_af39e3160ea3eca4( player ) )
        {
            distancetoplayer = distance( player.origin, bot.origin );
            
            if ( distancetoplayer < mindistancetoplayer )
            {
                mindistancetoplayer = distancetoplayer;
                var_1aecf75ecfaea148 = player;
            }
        }
    }
    
    str = "Deploy Bot in " + type + " (" + bot.origin[ 0 ] + ", " + bot.origin[ 1 ] + ", " + bot.origin[ 2 ] + ") player:" + name + " (" + origin[ 0 ] + ", " + origin[ 1 ] + ", " + origin[ 2 ] + ")" + " distToPlayer:" + distance( origin, bot.origin ) + " minDistPlayer:" + var_1aecf75ecfaea148.name + " (" + var_1aecf75ecfaea148.origin[ 0 ] + ", " + var_1aecf75ecfaea148.origin[ 1 ] + ", " + var_1aecf75ecfaea148.origin[ 2 ] + ")" + " minDistToPlayer:" + mindistancetoplayer;
    super_bot::function_cb27523a07bf9c83( 1, bot, "ui_bot::logdeployposition", str, "" );
}

// Namespace ui_bot
// Params 9, eflags: 0x4
// Checksum 0x4466280a, Offset: 0x410f
// Size: 0x1be
function private deployonebotonground( botprofile, origin, angles, radius, name, minangle, maxangle, var_f622a33467084174 = 0, aroundhuman = 1 )
{
    level endon( #"game_ended" );
    
    if ( !var_f622a33467084174 )
    {
        setbotprofilelocked( botprofile, 1, "DeployOneBotOnGround" );
    }
    
    deployedpos = botprofile trytogetgrounddeploypositionwithinmultipleframes( origin, angles, radius, minangle, maxangle, aroundhuman );
    
    /#
        if ( botprofile.origin )
        {
            deployedpos = botprofile.origin;
        }
    #/
    
    if ( !isdefined( deployedpos ) )
    {
        if ( function_803f0e3dae4c3631() )
        {
            setbotprofilelocked( botprofile, 0, "DeployOneBotOnGround_FailToGetDeployPos" );
            return;
        }
        
        bot = botprofile activate( "DeployOneBotOnGround_FailToGetDeployPos_LateGame humanName=" + name, 1 );
        
        if ( namespace_ef4547f85724edd1::isvalidplayer( bot ) )
        {
            wait 1;
            
            if ( namespace_ef4547f85724edd1::isvalidplayer( bot ) )
            {
                super_bot::function_cb27523a07bf9c83( 1, bot, "ui_bot::deployonebotonground", "failed to deploy and recycle, let's kick it.", "" );
                bot bots_gametype_br_super::kickplayer();
            }
        }
        
        return;
    }
    
    bot = botprofile activate( "DeployOneBotOnGround humanName=" + name, 1 );
    
    if ( !namespace_ef4547f85724edd1::isvalidplayer( bot ) )
    {
        return;
    }
    
    super_bot::function_cb27523a07bf9c83( 1, bot, "ui_bot::deployonebotonground", "Deploying the bot on the ground, humanName=" + name + " position=" + deployedpos, "" );
    bot function_e3b21c39cf9362df( deployedpos, #"config", "DeployOneBotOnGround" );
    
    if ( getdvarint( @"hash_429176496a1b2fd8", 0 ) )
    {
        logdeployposition( "ground", origin, bot, name );
    }
    
    return bot;
}

// Namespace ui_bot
// Params 6, eflags: 0x4
// Checksum 0x96438355, Offset: 0x42d6
// Size: 0x22b
function private trytogetgrounddeploypositionwithinmultipleframes( origin, angles, radius, minangle, maxangle, aroundhuman )
{
    var_6fa7714037fa6da8 = getdvarint( @"hash_789bfeb36c8e00fd", 999 );
    
    if ( var_6fa7714037fa6da8 != 999 && function_2bb2263ccabf684c() >= var_6fa7714037fa6da8 )
    {
        return;
    }
    
    if ( aroundhuman )
    {
        if ( !br_circle_util::ispointindangercircle( origin ) )
        {
            super_bot::function_cb27523a07bf9c83( 1, self, "ui_bot::trytogetgrounddeploypositionwithinmultipleframes", "no valid bot deploy position found for player, the player is faraway from the circle", "" );
            return;
        }
        
        /#
            if ( getdvarint( @"hash_96ba75c35ec39e87", 0 ) == 1 )
            {
                return ( origin + anglestoforward( angles ) * 100 );
            }
        #/
        
        var_c9aeb888966781c4 = undefined;
    }
    else
    {
        var_c9aeb888966781c4 = 0;
    }
    
    humanplayers = [];
    
    foreach ( player in level.players )
    {
        if ( bots_gametype_br_super::function_af39e3160ea3eca4( player ) )
        {
            humanplayers[ humanplayers.size ] = player;
        }
    }
    
    var_1b22f8bf55c7edcf = getdvarint( @"hash_76f5aae61a557bb6", 1 );
    
    for ( trycount = 0; trycount < 10 ; trycount++ )
    {
        waitframe();
        avoidwater = var_1b22f8bf55c7edcf;
        
        if ( trycount >= 5 && manager::islategame() )
        {
            avoidwater = 0;
        }
        
        poscandidate = function_a95013149a6923b9( origin, humanplayers, radius, minangle, maxangle, var_c9aeb888966781c4, avoidwater );
        
        if ( isdefined( poscandidate ) )
        {
            if ( function_685c23b0b0ebf271( poscandidate ) )
            {
                continue;
            }
            
            if ( !bots_gametype_br_super::function_209a171e55670383( poscandidate, 5 ) )
            {
                return poscandidate;
            }
        }
    }
    
    player = aroundhuman ? "human player" : "first deployed bot";
    super_bot::function_cb27523a07bf9c83( 1, self, "ui_bot::trytogetgrounddeploypositionwithinmultipleframes", "no valid bot deploy position found for player: " + player + "; origin: " + origin + "; radius: " + radius, "" );
}

// Namespace ui_bot
// Params 7
// Checksum 0x55eda143, Offset: 0x450a
// Size: 0x149
function function_a95013149a6923b9( origin, humanplayers, radius, minangle, maxangle, var_c9aeb888966781c4 = getdvarfloat( @"hash_74d198f9030a4630", 0.8 ), avoidwater )
{
    poscandidate = br_circle::getrandompointincircle( origin, radius, var_c9aeb888966781c4, 1, 1, 1, minangle, maxangle, 1 );
    
    if ( br_circle_util::gettimetilldangerforpoint( poscandidate ) < 45 )
    {
        return;
    }
    
    var_f86ef6e3442db565 = radius * var_c9aeb888966781c4;
    
    foreach ( player in humanplayers )
    {
        if ( namespace_ef4547f85724edd1::isvalidplayer( player ) && utility::ispointinsidecircle( player.origin, poscandidate, var_f86ef6e3442db565 ) )
        {
            return;
        }
    }
    
    if ( avoidwater && utility::ispointinwater( poscandidate + ( 0, 0, -15 ) ) )
    {
        return;
    }
    
    return poscandidate;
}

// Namespace ui_bot
// Params 5, eflags: 0x4
// Checksum 0x1fdc9708, Offset: 0x465c
// Size: 0x1b3
function private deployonebotinair( botprofile, origin, angles, radius, name )
{
    setbotprofilelocked( botprofile, 1, "DeployOneBotInAir" );
    bots_gametype_br_super::function_80d2eab106ef949d();
    spawnorigin = br_spawnrespawn::getsafeoriginaroundpoint( origin, radius );
    
    if ( !isdefined( spawnorigin ) )
    {
        setbotprofilelocked( botprofile, 0, "DeployOneBotInAir_FailToGetSafeOrigin" );
        return;
    }
    
    spawnorigin = function_22800623665698e5( spawnorigin, origin, angles );
    
    if ( !isdefined( spawnorigin ) )
    {
        setbotprofilelocked( botprofile, 0, "DeployOneBotInAir_FailToGetAdjustedSpawnPoint" );
        return;
    }
    
    skiplock = 1;
    bot = botprofile activate( "DeployOneBotInAir humanName=" + name, skiplock );
    
    if ( !namespace_ef4547f85724edd1::isvalidplayer( bot ) )
    {
        return;
    }
    
    /#
        if ( botprofile.origin )
        {
            spawnorigin = botprofile.origin + anglestoforward( angles ) * 100;
        }
    #/
    
    spawnangles = br_spawnrespawn::function_46f3bef64ca7cfca( spawnorigin, origin );
    bot setplayerangles( spawnangles );
    bot function_e3b21c39cf9362df( spawnorigin, undefined, "DeployOneBotInAir" );
    super_bot::function_cb27523a07bf9c83( 1, bot, "ui_bot::deployonebotinair", "Deploying the bot in the air, humanName=" + name + " position=" + spawnorigin, "" );
    dropinfo = bot br_plunder::function_45807c0351387038();
    bot br_plunder::playersetplundercount( dropinfo.var_a6085d27206e04f0 );
    falltime = level.parachutedeploydelay ?? 0;
    bot thread parachute::startfreefall( falltime, 0, undefined, undefined, 1 );
    
    if ( getdvarint( @"hash_429176496a1b2fd8", 0 ) )
    {
        logdeployposition( "air", origin, bot, name );
    }
    
    return bot;
}

// Namespace ui_bot
// Params 3, eflags: 0x4
// Checksum 0x7dc5d719, Offset: 0x4818
// Size: 0xf2
function private function_22800623665698e5( spawnorigin, origin, angles )
{
    /#
        if ( getdvarint( @"hash_96ba75c35ec39e87", 0 ) == 1 )
        {
            return ( origin + anglestoforward( angles ) * 100 );
        }
    #/
    
    if ( isdefined( level.respawnheightoverride ) )
    {
        height = level.respawnheightoverride;
    }
    else
    {
        height = parachute::getc130height();
        circleindex = level.br_circle.circleindex;
        
        if ( isdefined( circleindex ) )
        {
            closedindex = br_gulag::getgulagclosedcircleindex();
            var_6bc8d93c53e5729c = circleindex >= closedindex;
            
            if ( var_6bc8d93c53e5729c )
            {
                height *= getdvarfloat( @"hash_a1c2d6b19bb6a568", 0.55 );
            }
        }
    }
    
    dropspawnoffset = ( 0, 0, height );
    spawnorigin = br_public::droptogroundmultitrace( spawnorigin );
    spawnorigin = br::getoffsetspawnorigin( spawnorigin, dropspawnoffset );
    return spawnorigin;
}

// Namespace ui_bot
// Params 4
// Checksum 0x2153df1b, Offset: 0x4913
// Size: 0x7a
function function_e3b21c39cf9362df( deployedpos, giveloadouttype, deployedreason, originalpos = self.origin )
{
    namespace_ddca46d216b096e2::onplayerteleport( self, originalpos, deployedpos, deployedreason );
    self setorigin( deployedpos );
    
    if ( giveloadouttype == #"config" )
    {
        bots_gametype_br_super::function_635abb530bc9f436();
        return;
    }
    
    if ( giveloadouttype == #"standard" )
    {
        br::nakeddrophandleloadout();
    }
}

// Namespace ui_bot
// Params 1
// Checksum 0x30fe2e75, Offset: 0x4995
// Size: 0x2ab
function function_6affd1a72f874d5e( var_b24ecf0a1e3b89fb )
{
    level endon( #"game_ended" );
    curtime = gettime();
    var_a5818385c7151a07 = function_6f24b57919b11c1b( var_b24ecf0a1e3b89fb, 1 );
    
    if ( isdefined( var_a5818385c7151a07 ) && curtime - var_a5818385c7151a07 < 10000 )
    {
        return;
    }
    
    self.engageinfo.var_bd9c2877a0cce082 = curtime;
    radius = getdvarint( @"hash_37748e493a1c8154", 1800 );
    radius = max( radius, 1800 );
    botsnum = getdvarint( @"hash_f0aad7ee9dc03ada", 3 );
    teamsnum = min( botsnum, 3 );
    showlocation = getrandomnavpoint( self.origin, radius );
    humanangles = self.angles;
    var_e8ab5837227f176f = self getentitynumber();
    humanname = self.name;
    spawnedbots = [];
    teamsused = [];
    
    for ( i = 0; i < botsnum ; i++ )
    {
        var_ff3c116398be9b7e = undefined;
        var_5a32daf41a69de1 = getavailablebotprofiles_internal( 1 );
        
        for ( i = 0; i < var_5a32daf41a69de1.size ; i++ )
        {
            botprofile = var_5a32daf41a69de1[ i ];
            
            if ( i < teamsnum )
            {
                if ( arraycontains( teamsused, botprofile.team ) )
                {
                    continue;
                }
                
                var_ff3c116398be9b7e = botprofile;
                teamsused[ teamsused.size ] = botprofile.team;
                break;
            }
            
            if ( botprofile.team == teamsused[ i % int( teamsnum ) ].team )
            {
                var_ff3c116398be9b7e = botprofile;
                break;
            }
        }
        
        if ( !isdefined( var_ff3c116398be9b7e ) )
        {
            continue;
        }
        
        bot = deployonebotonground( var_ff3c116398be9b7e, showlocation, humanangles, 800, humanname );
        
        if ( isdefined( bot ) )
        {
            bot postdeploy( 1, self, 0 );
            bot.var_58aa23b3862fb7d1 = var_e8ab5837227f176f;
            spawnedbots[ spawnedbots.size ] = bot;
        }
    }
    
    self.engageinfo.var_274afb1f185130cd = gettime();
    wait 15;
    
    foreach ( bot in spawnedbots )
    {
        if ( !isdefined( bot ) )
        {
            continue;
        }
        
        bot.var_58aa23b3862fb7d1 = undefined;
    }
}

// Namespace ui_bot
// Params 2
// Checksum 0xae5633b3, Offset: 0x4c48
// Size: 0x8c
function spawnuibotlogic( bot, botprofile )
{
    bot.uibotprofile = botprofile;
    botprofile.bot = bot;
    bot showplayer( 0, "ui_bot::SpawnUIBotLogic()" );
    
    if ( bots::function_d368124e9c5a1809() )
    {
        bot bots_loadout::bot_set_loadout_class();
    }
    
    var_4c413fda28a09aa = getdvarint( @"hash_b7f8b4b89ea6ced1", 15 );
    
    if ( var_4c413fda28a09aa > 0 )
    {
        bot.plotarmortriggerhurt = 1;
        bot thread clearplotarmorthread( var_4c413fda28a09aa );
    }
}

// Namespace ui_bot
// Params 1, eflags: 0x4
// Checksum 0xb5c0e93b, Offset: 0x4cdc
// Size: 0x189
function private clearplotarmorthread( var_4c413fda28a09aa )
{
    self endon( #"clearplotarmorthread" );
    name = self.name;
    id = self getentitynumber();
    health = self.health;
    team = self.team ?? "undefined";
    xuid = self.xuid ?? "undefined";
    bba_id = self.bba_id ?? "undefined";
    reason = utility::waittill_any_in_array_or_timeout( [ "death", "disconnect" ], var_4c413fda28a09aa );
    
    if ( isdefined( self ) )
    {
        if ( namespace_ef4547f85724edd1::isaliveplayer( self ) )
        {
            super_bot::function_cb27523a07bf9c83( 1, self, "ui_bot::clearplotarmorthread", "id=" + id + " health=" + health + " reason=" + reason, "" );
            
            if ( !tryrecycle( "ClearPlotArmorThread timeout" ) )
            {
                super_bot::function_cb27523a07bf9c83( 1, self, "ui_bot::clearplotarmorthread", "failed to recycle, let's kick it.", "" );
                bots_gametype_br_super::kickplayer();
            }
        }
        else
        {
            clearplotarmortriggerhurt( reason );
        }
        
        return;
    }
    
    super_bot::function_cb27523a07bf9c83( 1, undefined, "ui_bot::clearplotarmorthread", "name=" + name + " id=" + id + " team=" + team + " xuid=" + xuid + " BBA_Id=" + bba_id + " reason=" + reason, "" );
}

// Namespace ui_bot
// Params 1, eflags: 0x4
// Checksum 0x775e3990, Offset: 0x4e6d
// Size: 0x7c
function private clearplotarmortriggerhurt( reason = "unknown" )
{
    if ( self.plotarmortriggerhurt )
    {
        self.plotarmortriggerhurt = 0;
        health = self.health ?? "undefined";
        super_bot::function_cb27523a07bf9c83( 1, self, "ui_bot::clearplotarmortriggerhurt", "health=" + health + " reason=" + reason, "" );
        self notify( #"clearplotarmorthread" );
    }
}

/#

    // Namespace ui_bot
    // Params 0
    // Checksum 0xeca1849a, Offset: 0x4ef1
    // Size: 0x57, Type: dev
    function function_92888ac470f1c74()
    {
        cmd = "<dev string:x1a2>";
        namespace_ef4547f85724edd1::adddevguicmd( cmd );
        cmd = "<dev string:x20d>";
        namespace_ef4547f85724edd1::adddevguicmd( cmd );
        cmd = "<dev string:x275>";
        namespace_ef4547f85724edd1::adddevguicmd( cmd );
        cmd = "<dev string:x2df>";
        namespace_ef4547f85724edd1::adddevguicmd( cmd );
        level thread function_d42494a3669e093e();
    }

    // Namespace ui_bot
    // Params 0, eflags: 0x4
    // Checksum 0x1c059ec1, Offset: 0x4f50
    // Size: 0x85, Type: dev
    function private function_d42494a3669e093e()
    {
        level endon( #"game_ended" );
        setdvarifuninitialized( @"hash_96ba75c35ec39e87", 0 );
        var_7ec43a0e5c753ef2 = getdvarint( @"hash_96ba75c35ec39e87", 0 );
        
        while ( true )
        {
            if ( var_7ec43a0e5c753ef2 != getdvarint( @"hash_96ba75c35ec39e87", 0 ) )
            {
                var_7ec43a0e5c753ef2 = getdvarint( @"hash_96ba75c35ec39e87", 0 );
                
                if ( var_7ec43a0e5c753ef2 )
                {
                    iprintln( "<dev string:x356>" );
                }
                else
                {
                    iprintln( "<dev string:x371>" );
                }
            }
            
            wait 1;
        }
    }

    // Namespace ui_bot
    // Params 1, eflags: 0x4
    // Checksum 0x1070599, Offset: 0x4fdd
    // Size: 0x5d, Type: dev
    function private function_4c1508ab88c6a1( index )
    {
        if ( isdefined( level.uibotmanager.uibots[ index ] ) )
        {
            profile = level.uibotmanager.uibots[ index ];
            return { #botprofiles:[ profile ] };
        }
    }

#/
