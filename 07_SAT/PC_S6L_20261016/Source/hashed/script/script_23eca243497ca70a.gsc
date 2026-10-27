// script_23eca243497ca70a  (hash_23eca243497ca70a.gscc) (size: 4228 Bytes / 0x1084 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbe35811f (3191177503)
// size ...... 4228 (0x1084)
// includes .. 12  (offset: 0xf64)
// strings ... 11  (offset: 0xfc4)
// dev strs .. 4   (offset: 0x1054)
// exports ... 18  (offset: 0x738)
// cseg ...... 0x199 + 0x59f (0x738)
// imports ... 48  (offset: 0xa08)
// animtree1 . 0   (offset: 0x1084)
// animtree2 . 0   (offset: 0x1084)
#using script_4a7080e904a6380e;
#using script_4c9bd9a3bf3f8cf7;
#using script_72af5a878a9d3397;
#using scripts\common\utility;
#using scripts\mp\bots\bots;
#using scripts\mp\bots\bots_gametype_super_shared;
#using scripts\mp\br\gametypes\br_infils_util;
#using scripts\mp\br\gametypes\br_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\laststand;
#using scripts\mp\meatshield;
#using scripts\mp\playerlogic;

#namespace recycle_manager;

// Namespace recycle_manager
// Params 0
// Checksum 0x82e41211, Offset: 0x1b7
// Size: 0x5b
function initialize()
{
    profilestart();
    level.var_8678bd2c494e7c76 = getdvarint( @"hash_2ea0ae6aac97cb62", 0 );
    
    if ( level.var_8678bd2c494e7c76 )
    {
        level.var_9d90f0aef70465c8 = [];
        
        /#
            var_fc4893776bdf16ca = spawn( "<dev string:x24>", function_dec4df972796c177() );
            var_fc4893776bdf16ca setmodel( "<dev string:x31>" );
        #/
    }
    
    profilestop();
}

// Namespace recycle_manager
// Params 0
// Checksum 0xa0fb503e, Offset: 0x21a
// Size: 0xd
function isenabled()
{
    profilestart();
    profilestop();
    return level.var_8678bd2c494e7c76;
}

// Namespace recycle_manager
// Params 0
// Checksum 0x59b98342, Offset: 0x231
// Size: 0xd
function function_8bdda6f455e12bfd()
{
    profilestart();
    profilestop();
    return level.var_9d90f0aef70465c8;
}

// Namespace recycle_manager
// Params 3
// Checksum 0xcacacbe7, Offset: 0x248
// Size: 0x141
function activate( botinfoarray, botcallback, var_84f55f032a811f8f )
{
    if ( !isenabled() )
    {
        assertmsg( "<dev string:x45>" );
        return;
    }
    
    readybots = [];
    
    foreach ( botprofile in botinfoarray )
    {
        botentity = botprofile.botentity;
        
        if ( !botentity )
        {
            super_bot::function_cb27523a07bf9c83( 2, botprofile, "recycle_manager::activate", "Failed to get bot entity from UI bot profile", "" );
            continue;
        }
        
        if ( !namespace_ef4547f85724edd1::isvalidplayer( botentity ) )
        {
            super_bot::function_cb27523a07bf9c83( 2, botentity, "recycle_manager::activate", "Unexpected DEAD bot for UI bot activation", "" );
            continue;
        }
        
        activateinternal( botentity, botprofile, botcallback );
        readybots[ readybots.size ] = botentity;
        pendingbots = function_8bdda6f455e12bfd();
        pendingbots[ pendingbots.size ] = botentity;
    }
    
    if ( isdefined( var_84f55f032a811f8f ) )
    {
        level notify( var_84f55f032a811f8f );
    }
    
    return readybots;
}

// Namespace recycle_manager
// Params 3, eflags: 0x4
// Checksum 0x4caa9ca3, Offset: 0x392
// Size: 0x77
function private activateinternal( bot, botprofile, botcallback )
{
    bot function_34958e8fb9d58687( 1 );
    bot function_6ca60b30bfd8702f( 1 );
    ui_bot::spawnuibotlogic( bot, botprofile );
    
    if ( isdefined( botcallback ) )
    {
        bot [[ botcallback ]]();
    }
    
    if ( isdefined( level.var_71ba41c0c502d09c ) )
    {
        bot thread [[ level.var_71ba41c0c502d09c ]]();
    }
    
    function_cc9e7b048233b869( bot );
    bot bots::bot_player_spawned();
}

// Namespace recycle_manager
// Params 2
// Checksum 0x24559077, Offset: 0x411
// Size: 0x52, Type: bool
function recycle( statusto, statusfrom )
{
    if ( !isenabled() )
    {
        assertmsg( "<dev string:x7f>" );
        return false;
    }
    
    if ( !recycleinternal() )
    {
        return false;
    }
    
    namespace_ddca46d216b096e2::function_4833f43f9011ad9f( statusto, statusfrom );
    self notify( #"recycled_to_uibot" );
    return true;
}

// Namespace recycle_manager
// Params 0, eflags: 0x4
// Checksum 0x35c280d0, Offset: 0x46c
// Size: 0x78, Type: bool
function private recycleinternal()
{
    if ( !isalive( self ) )
    {
        playerlogic::spawnplayer();
        
        if ( !namespace_ef4547f85724edd1::isvalidplayer( self ) )
        {
            super_bot::function_cb27523a07bf9c83( 2, self, "recycle_manager::recycleinternal", "Failed to recycle bot due to spawn failure", "" );
            return false;
        }
        
        if ( self.br_iseliminated )
        {
            br_utility::unmarkplayeraseliminated( self, "Respawn for recycle to UI bot" );
        }
    }
    
    function_5e66221c75f4be4b();
    function_7d60fba70d78203f();
    function_6ca60b30bfd8702f( 0 );
    function_34958e8fb9d58687( 0 );
    function_1cd0c630dff60bea();
    return true;
}

// Namespace recycle_manager
// Params 0, eflags: 0x4
// Checksum 0x38dcc144, Offset: 0x4ed
// Size: 0x5d
function private function_5e66221c75f4be4b()
{
    profilestart();
    
    if ( player::isinlaststand( self ) )
    {
        thread laststand::exit( "last_stand_exit_bot_recycled", self );
    }
    
    if ( self isonladder() )
    {
        self clearladderstate();
    }
    
    if ( self ishanging() )
    {
        self clearhanging();
    }
    
    if ( self isragdoll() )
    {
        self stopliveragdoll();
    }
    
    meatshield::function_db06fbfec0ffa2eb();
    self.var_ee4e521e94b41b6a = undefined;
    br_infils_util::endprematchskydiving();
    profilestop();
}

// Namespace recycle_manager
// Params 0, eflags: 0x4
// Checksum 0x5e537159, Offset: 0x552
// Size: 0x19
function private function_7d60fba70d78203f()
{
    profilestart();
    self._blackboard.var_2f096baf7ddd5b30 = 0;
    profilestop();
}

// Namespace recycle_manager
// Params 1, eflags: 0x4
// Checksum 0x7466fec4, Offset: 0x573
// Size: 0x32
function private function_6ca60b30bfd8702f( enabled )
{
    profilestart();
    self botsetflag( "disable_all_ai", !enabled );
    
    if ( enabled )
    {
        bots::function_abd267784d89d474();
    }
    else
    {
        bots::function_2bc9768ae531395e();
    }
    
    profilestop();
}

// Namespace recycle_manager
// Params 1, eflags: 0xc
// Checksum 0x9a9d7022, Offset: 0x5ad
// Size: 0x65
function private function_34958e8fb9d58687( enabled )
{
    self notify( #"hash_4c652185ce612d24" );
    self endon( #"hash_4c652185ce612d24" );
    profilestart();
    
    if ( enabled )
    {
        self playershow();
    }
    else
    {
        childthread function_bd7f36c044a6bce7();
    }
    
    self setsolid( enabled );
    self.plotarmor = !enabled;
    self.plotarmortriggerhurt = !enabled;
    player::function_e4f77222086e66b( !enabled );
    profilestop();
}

// Namespace recycle_manager
// Params 0, eflags: 0x4
// Checksum 0xf69ede1a, Offset: 0x61a
// Size: 0x20
function private function_bd7f36c044a6bce7()
{
    self endon( #"death_or_disconnect" );
    self playerhide();
    wait 2;
    self playerhide();
}

// Namespace recycle_manager
// Params 0, eflags: 0x4
// Checksum 0x983359f8, Offset: 0x642
// Size: 0x30
function private function_1cd0c630dff60bea()
{
    profilestart();
    
    if ( !namespace_ef4547f85724edd1::isvalidplayer( self ) )
    {
        profilestop();
        return;
    }
    
    depot_location = function_dec4df972796c177();
    
    if ( depot_location )
    {
        self setorigin( depot_location );
    }
    
    profilestop();
}

// Namespace recycle_manager
// Params 0, eflags: 0x4
// Checksum 0x36ea9193, Offset: 0x67a
// Size: 0x17
function private function_dec4df972796c177()
{
    profilestart();
    profilestop();
    return level.uibotmanager.var_7dc27bc9fa62c763;
}

// Namespace recycle_manager
// Params 1
// Checksum 0xd33ebeec, Offset: 0x69b
// Size: 0x19
function function_82a8830ca0d038c( bot )
{
    profilestart();
    profilestop();
    return bot.var_f8cc0b5f224e4952;
}

// Namespace recycle_manager
// Params 1, eflags: 0x4
// Checksum 0xe6941faa, Offset: 0x6be
// Size: 0x25
function private function_cc9e7b048233b869( bot )
{
    profilestart();
    bot.var_f8cc0b5f224e4952 = 1;
    bot thread function_ea3ddedf4e36be46();
    profilestop();
}

// Namespace recycle_manager
// Params 0, eflags: 0xc
// Checksum 0x23321832, Offset: 0x6eb
// Size: 0x4d
function private function_ea3ddedf4e36be46()
{
    self notify( #"hash_341ff48f88debd2c" );
    self endon( #"hash_341ff48f88debd2c" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    utility::waittill_any( "death", "recycled_to_uibot" );
    self.var_f8cc0b5f224e4952 = undefined;
}

