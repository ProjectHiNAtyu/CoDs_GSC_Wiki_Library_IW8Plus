// script_2e6a95dfe7dfc5f8  (hash_2e6a95dfe7dfc5f8.gscc) (size: 5747 Bytes / 0x1673 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8f40d1d7 (2403389911)
// size ...... 5747 (0x1673)
// includes .. 12  (offset: 0x1547)
// strings ... 13  (offset: 0x15a7)
// dev strs .. 3   (offset: 0x164f)
// exports ... 16  (offset: 0xbf7)
// cseg ...... 0x1a3 + 0xa54 (0xbf7)
// imports ... 57  (offset: 0xe77)
// animtree1 . 0   (offset: 0x1673)
// animtree2 . 0   (offset: 0x1673)
#using script_26ccbfe3954cacf4;
#using script_44f4640b93ab1b47;
#using script_4c9bd9a3bf3f8cf7;
#using script_72af5a878a9d3397;
#using scripts\common\bots\bots_util;
#using scripts\common\utility;
#using scripts\mp\bots\bots;
#using scripts\mp\bots\bots_gametype_br;
#using scripts\mp\bots\bots_gametype_br_super;
#using scripts\mp\bots\bots_gametype_super_shared;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;

#namespace dormant_bot;

// Namespace dormant_bot
// Params 0
// Checksum 0x7fa4d62e, Offset: 0x1c1
// Size: 0x1f3
function thinkthread()
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"recycled_to_uibot" );
    self waittill( #"hash_52fb89278ab14e49" );
    assert( isbot( self ) );
    
    if ( !manager::function_5c79ebe77f7d0528() )
    {
        wait getdvarint( @"hash_de394b7049bf2445", 20 );
    }
    
    if ( level.uibotmanager.var_9d03093deceb509e )
    {
        if ( manager::function_5c79ebe77f7d0528() )
        {
            activate();
        }
        
        return;
    }
    
    cansuspend = 0;
    var_c87b90defee542c7 = undefined;
    
    while ( true )
    {
        var_5c79ebe77f7d0528 = manager::function_5c79ebe77f7d0528();
        
        if ( level.uibotmanager.var_9d03093deceb509e )
        {
            if ( var_5c79ebe77f7d0528 )
            {
                activate();
            }
            
            break;
        }
        
        var_4f8a92ebabf37ee = canberecycled();
        
        if ( var_5c79ebe77f7d0528 )
        {
            /#
                if ( getdvarint( @"hash_70561094fa4e91b5", 0 ) )
                {
                    if ( namespace_ef4547f85724edd1::isvalidplayer( self ) )
                    {
                        var_4f8a92ebabf37ee = 1;
                    }
                }
            #/
            
            if ( !var_4f8a92ebabf37ee )
            {
                activate();
                var_c87b90defee542c7 = undefined;
            }
            else
            {
                var_63732717d792a35a = bots_gametype_br::bot_is_in_gas() || uav_manager::function_ed10eddbbc9b44ea() || var_c87b90defee542c7 < gettime();
                
                if ( var_63732717d792a35a )
                {
                    unsuspend();
                    var_c87b90defee542c7 = undefined;
                }
                else if ( cansuspend )
                {
                    suspend();
                    var_bf485d1c2289bb48 = 10000;
                    var_c87b90defee542c7 = gettime() + var_bf485d1c2289bb48;
                }
            }
        }
        else if ( var_4f8a92ebabf37ee )
        {
            tryrecycle( "unengaged and range [2D dist = (default), height = (default)] meets for (default) ms and not witnessed" );
        }
        
        msg = utility::waittill_any_in_array_or_timeout( [ "off_navmesh", "death", "dormant_bot_suspending_chance" ], 1 );
        cansuspend = 0;
        
        if ( msg == "off_navmesh" )
        {
            success = manager::tryrecycle( 4 );
            
            if ( success )
            {
                return;
            }
            
            continue;
        }
        
        if ( msg == "dormant_bot_suspending_chance" )
        {
            cansuspend = 1;
        }
    }
}

// Namespace dormant_bot
// Params 0, eflags: 0x4
// Checksum 0xb8a682fd, Offset: 0x3bc
// Size: 0x28
function private function_c78a19e4d28c53dc()
{
    return getdvarint( @"hash_8f312094be1c23b0", level.var_d4909c0acc55763c.var_9a3562c68022f2a0 ?? 30000 );
}

// Namespace dormant_bot
// Params 3
// Checksum 0xe04b5d88, Offset: 0x3ed
// Size: 0x233, Type: bool
function canberecycled( dist2d, height, inactiveduration )
{
    if ( level.uibotmanager.var_9d03093deceb509e )
    {
        return false;
    }
    
    if ( !bots_gametype_br_super::isvalidbot( self ) )
    {
        return false;
    }
    
    if ( self.var_a68c9cea27c8f116 )
    {
        return false;
    }
    
    if ( ui_bot::function_9faf63b8dddbcc93() )
    {
        return false;
    }
    
    if ( bots_gametype_br_super::function_8225394f018d1121() )
    {
        return false;
    }
    
    if ( player::isinlaststand( self ) )
    {
        return false;
    }
    
    if ( !isdefined( self.uibot ) )
    {
        return false;
    }
    
    curtime = gettime();
    
    if ( !bots_gametype_br_super::function_31a63867ce36c66() )
    {
        self.uibot.var_1a13c6bab9a07635 = curtime;
        return false;
    }
    
    if ( !isdefined( dist2d ) )
    {
        dist2d = getdvarint( @"hash_d0dc9e305f43690", level.var_d4909c0acc55763c.var_e2e4a589c43da0d6 ?? 5900 );
    }
    
    if ( !isdefined( height ) )
    {
        height = getdvarint( @"hash_68e3358ad64bef77", 5900 );
    }
    
    if ( dist2d > 0 && height > 0 )
    {
        players = function_d63fe6a4c08ba6f5( self.origin, dist2d, height, 0, self );
        
        foreach ( player in players )
        {
            if ( !isbot( player ) )
            {
                self.uibot.var_1a13c6bab9a07635 = curtime;
                return false;
            }
        }
    }
    
    if ( bots_gametype_br_super::function_98c886e7b2c20b9c() )
    {
        return false;
    }
    
    if ( !isdefined( inactiveduration ) )
    {
        inactiveduration = function_c78a19e4d28c53dc();
    }
    
    if ( !isdefined( self.uibot.var_1a13c6bab9a07635 ) )
    {
        self.uibot.var_1a13c6bab9a07635 = curtime;
    }
    
    if ( curtime - self.uibot.var_1a13c6bab9a07635 >= inactiveduration )
    {
        if ( bots_gametype_br_super::function_d0fa014a2d896bdc() )
        {
            self.uibot.var_1a13c6bab9a07635 = curtime;
        }
        else
        {
            return true;
        }
    }
    
    return false;
}

// Namespace dormant_bot
// Params 0
// Checksum 0x1adac7f7, Offset: 0x629
// Size: 0x2f
function function_b4f756a19929b41f()
{
    inactiveduration = function_c78a19e4d28c53dc();
    self.uibot.var_1a13c6bab9a07635 = gettime() - inactiveduration;
}

// Namespace dormant_bot
// Params 1
// Checksum 0x56702b8a, Offset: 0x660
// Size: 0xa9, Type: bool
function tryrecycle( reason )
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
    
    if ( !bots_gametype_br_super::isvalidbot( self ) )
    {
        return false;
    }
    
    if ( !isdefined( reason ) )
    {
        reason = "unknown reason";
    }
    
    println( "<dev string:x24>" + self getentitynumber() + "<dev string:x2f>" + self.name + "<dev string:x31>" + reason );
    self.uibot.recyclereason = strtok( reason, " " )[ 0 ];
    thread recyclethread();
    return true;
}

// Namespace dormant_bot
// Params 0, eflags: 0x4
// Checksum 0x2a5574f, Offset: 0x712
// Size: 0x10
function private recyclethread()
{
    deactivate();
    function_bef4090567ea7c0a();
}

// Namespace dormant_bot
// Params 1, eflags: 0x4
// Checksum 0x8ed80f27, Offset: 0x72a
// Size: 0x2b
function private function_9273be4d7a15f689( isdormant )
{
    if ( bots_util::function_deef484b5b3a3977() )
    {
        self._blackboard.var_2f096baf7ddd5b30 = isdormant;
    }
}

// Namespace dormant_bot
// Params 0, eflags: 0x4
// Checksum 0xd031e34, Offset: 0x75d
// Size: 0x99
function private deactivate()
{
    if ( !manager::function_5c79ebe77f7d0528() )
    {
        namespace_ddca46d216b096e2::function_4833f43f9011ad9f( "dormant" );
        namespace_ef4547f85724edd1::function_4c57819a44d79e03( "Deactivated - Dormant" );
        function_9273be4d7a15f689( 1 );
        self.uibot.var_5c79ebe77f7d0528 = 1;
        self.uibot.dormantstarttime = gettime();
        namespace_ef4547f85724edd1::setenemy( undefined );
        level.uibotmanager.dormantbots[ level.uibotmanager.dormantbots.size ] = self;
        level notify( #"ui_bot_counter_updated" );
    }
}

// Namespace dormant_bot
// Params 0
// Checksum 0xbbe8f551, Offset: 0x7fe
// Size: 0x8b
function activate()
{
    if ( manager::function_5c79ebe77f7d0528() )
    {
        namespace_ddca46d216b096e2::function_4833f43f9011ad9f( "active" );
        namespace_ef4547f85724edd1::function_4c57819a44d79e03( "Activated - Dormant" );
        self.uibot.var_5c79ebe77f7d0528 = 0;
        function_9273be4d7a15f689( 0 );
        level.uibotmanager.dormantbots = arrayremove( level.uibotmanager.dormantbots, self );
        level notify( #"ui_bot_counter_updated" );
        self notify( #"dormant_bot_activated" );
        unsuspend();
    }
}

// Namespace dormant_bot
// Params 0, eflags: 0x4
// Checksum 0x30b46788, Offset: 0x891
// Size: 0xa0
function private function_bef4090567ea7c0a()
{
    assert( manager::function_5c79ebe77f7d0528() );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self endon( #"dormant_bot_activated" );
    level endon( #"hash_3b64378f01c42702" );
    
    while ( !manager::islategame() )
    {
        while ( level.uibotmanager.var_ed76632de07e73f4 == gettime() )
        {
            waitframe();
        }
        
        profilestart();
        
        if ( function_333ac38e029beaa2() )
        {
            level.uibotmanager.var_ed76632de07e73f4 = gettime();
            ui_bot::recycle( "dormant recycle to ui bot" );
            profilestop();
            return;
        }
        
        profilestop();
        wait 1;
    }
}

// Namespace dormant_bot
// Params 0, eflags: 0x4
// Checksum 0xaa897a0f, Offset: 0x939
// Size: 0x18f, Type: bool
function private function_333ac38e029beaa2()
{
    if ( uav_manager::function_ed10eddbbc9b44ea() )
    {
        return false;
    }
    
    if ( !ui_bot::function_803f0e3dae4c3631() )
    {
        return false;
    }
    
    slotcount = manager::function_fc996d837292d79e();
    
    if ( !isdefined( slotcount ) )
    {
        slotcount = getdvarint( @"hash_f3a6b99340f5a95f", 60 );
    }
    
    hasslot = level.uibotmanager.uibots.size < slotcount;
    
    if ( !hasslot )
    {
        return false;
    }
    
    if ( ui_bot::function_9faf63b8dddbcc93() )
    {
        return false;
    }
    
    if ( !function_79d2a0b5b245acee( self ) )
    {
        return false;
    }
    
    if ( bots_gametype_br_super::function_98c886e7b2c20b9c() )
    {
        return false;
    }
    
    if ( bots_gametype_br_super::function_d0fa014a2d896bdc() )
    {
        return false;
    }
    
    var_23ed539c4746866f = getdvarfloat( @"hash_811d9e9ee926ee58", 2000 ) * getdvarfloat( @"hash_811d9e9ee926ee58", 2000 );
    teammembers = teams::getteamdata( self.team, "players" );
    nearbyteammates = bots_gametype_br_super::function_ed2438a9aac046ff( teammembers, 1, var_23ed539c4746866f );
    
    foreach ( teammate in nearbyteammates )
    {
        if ( !namespace_ef4547f85724edd1::isvalidplayer( teammate ) )
        {
            continue;
        }
        
        if ( !teammate manager::function_5c79ebe77f7d0528() )
        {
            return false;
        }
        
        if ( !function_79d2a0b5b245acee( teammate ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace dormant_bot
// Params 1, eflags: 0x4
// Checksum 0x5f8f689c, Offset: 0xad1
// Size: 0x78, Type: bool
function private function_79d2a0b5b245acee( teammember )
{
    if ( teammember bots_gametype_br_super::function_8225394f018d1121() )
    {
        return false;
    }
    
    if ( !teammember ui_bot::canberecycled( undefined, 0, 0 ) )
    {
        return false;
    }
    
    var_150ab6b5614bc555 = gettime() - teammember.uibot.dormantstarttime >= getdvarint( @"hash_3b0dbf95a91a8233", 5000 );
    
    if ( !var_150ab6b5614bc555 && !teammember bots_gametype_br::bot_is_in_gas() )
    {
        return false;
    }
    
    return true;
}

// Namespace dormant_bot
// Params 0
// Checksum 0x4c4749b9, Offset: 0xb52
// Size: 0x16, Type: bool
function issuspended()
{
    return istrue( self.uibot.issuspended );
}

// Namespace dormant_bot
// Params 0, eflags: 0x4
// Checksum 0xfdb0c6ad, Offset: 0xb71
// Size: 0x43
function private suspend()
{
    if ( !issuspended() )
    {
        self.uibot.issuspended = 1;
        bots_gametype_br_super::botsuspend( 1 );
        namespace_ef4547f85724edd1::function_4c57819a44d79e03( "Deactivated - Dormant(Suspended)" );
        self notify( #"bot_suspended" );
    }
}

// Namespace dormant_bot
// Params 0, eflags: 0x4
// Checksum 0xd6f6baab, Offset: 0xbbc
// Size: 0x3b
function private unsuspend()
{
    if ( issuspended() )
    {
        self.uibot.issuspended = 0;
        bots_gametype_br_super::botsuspend( 0 );
        namespace_ef4547f85724edd1::function_4c57819a44d79e03( "Deactivated - Dormant" );
        bots::bot_restart_think_threads();
    }
}

