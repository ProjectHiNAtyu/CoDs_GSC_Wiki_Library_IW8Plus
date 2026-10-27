// scripts\common\status_effects\status_tracking.gsc  (hash_55cd2da8630bf6e8.gscc) (size: 6116 Bytes / 0x17e4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x1c396cfb (473525499)
// size ...... 6116 (0x17e4)
// includes .. 2   (offset: 0x1660)
// strings ... 0   (offset: 0x1670)
// dev strs .. 31  (offset: 0x1670)
// exports ... 22  (offset: 0x10a8)
// cseg ...... 0x58 + 0x1050 (0x10a8)
// imports ... 14  (offset: 0x1418)
// animtree1 . 0   (offset: 0x17e4)
// animtree2 . 0   (offset: 0x17e4)
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace status_tracking;

// Namespace status_tracking
// Params 0, eflags: 0x1
// Checksum 0x565019ac, Offset: 0x76
// Size: 0x98
function autoexec main()
{
    if ( !getdvarint( @"hash_ab96d4e560e43394", 0 ) && !level.gamemodebundle.var_168d3f1d0b6cf209 )
    {
        level callback::add( #"hash_244314ef9125e636", &function_a34aef984160a893 );
        level callback::add( #"player_death", &onplayerdeath );
        level callback::add( #"player_disconnect", &onplayerdisconnect );
        level.var_38f84e6d5f274bb = { #statustracker:[], #statusguid:-1, #var_8cd831a3c0cc9bdc:-1 };
    }
}

// Namespace status_tracking
// Params 0
// Checksum 0x6c5f0d81, Offset: 0x116
// Size: 0x6e
function function_25399da4af77eea1()
{
    if ( level.gamemodebundle.var_168d3f1d0b6cf209 || getdvarint( @"hash_ab96d4e560e43394", 0 ) )
    {
        return;
    }
    
    level.var_38f84e6d5f274bb.var_8cd831a3c0cc9bdc = level.var_38f84e6d5f274bb.var_8cd831a3c0cc9bdc + 1 & 2147483647;
    return level.var_38f84e6d5f274bb.var_8cd831a3c0cc9bdc;
}

// Namespace status_tracking
// Params 0, eflags: 0x4
// Checksum 0xf8543f71, Offset: 0x18d
// Size: 0x45
function private function_a5de84a2cfd56f30()
{
    level.var_38f84e6d5f274bb.statusguid = level.var_38f84e6d5f274bb.statusguid + 1 & 2147483647;
    return level.var_38f84e6d5f274bb.statusguid;
}

// Namespace status_tracking
// Params 5
// Checksum 0x7c682525, Offset: 0x1db
// Size: 0x174
function applystatus( recipient, var_1e4624a03ea41715, var_8cd831a3c0cc9bdc, statustype, additionalparams )
{
    victimguid = recipient.guid;
    
    if ( !victimguid )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    attackerguid = var_1e4624a03ea41715.guid ?? #"void_guid";
    
    if ( ( var_8cd831a3c0cc9bdc ?? -1 ) < 0 )
    {
        assertmsg( "<dev string:x61>" );
        return;
    }
    
    if ( !statustype )
    {
        assertmsg( "<dev string:xa7>" );
        return;
    }
    
    statustracker = level.var_38f84e6d5f274bb.statustracker;
    
    if ( !isdefined( statustracker[ victimguid ] ) )
    {
        statustracker[ victimguid ] = [];
    }
    
    var_be4e2ebacfe6baea = statustracker[ victimguid ];
    
    if ( !isdefined( var_be4e2ebacfe6baea[ attackerguid ] ) )
    {
        var_be4e2ebacfe6baea[ attackerguid ] = [];
    }
    
    var_d69f8fd224466b7c = var_be4e2ebacfe6baea[ attackerguid ];
    
    if ( !isdefined( var_d69f8fd224466b7c[ var_8cd831a3c0cc9bdc ] ) )
    {
        var_d69f8fd224466b7c[ var_8cd831a3c0cc9bdc ] = [];
    }
    
    var_b331bb5138deb68 = var_d69f8fd224466b7c[ var_8cd831a3c0cc9bdc ];
    statusguid = function_a5de84a2cfd56f30();
    
    if ( !isdefined( var_b331bb5138deb68[ statusguid ] ) )
    {
        var_b331bb5138deb68[ statusguid ] = [];
    }
    
    statusstruct = { #supportscoreevent:additionalparams.supportscoreevent, #timeapplied:gettime(), #statustype:statustype };
    var_b331bb5138deb68[ statusguid ] = statusstruct;
    return statusguid;
}

// Namespace status_tracking
// Params 3
// Checksum 0x5ce692ed, Offset: 0x358
// Size: 0x74
function function_820d05797324eca0( recipient, statustype, additionalparams )
{
    if ( !recipient )
    {
        assertmsg( "<dev string:xe6>" );
        return;
    }
    
    if ( !statustype )
    {
        assertmsg( "<dev string:x132>" );
        return;
    }
    
    if ( !isdefined( recipient.var_2bee526696230275 ) )
    {
        recipient.var_2bee526696230275 = [];
    }
    
    recipient.var_2bee526696230275[ statustype ] = gettime();
}

// Namespace status_tracking
// Params 3
// Checksum 0x7beb08bd, Offset: 0x3d4
// Size: 0x70
function function_646b346a2f15596c( recipient, statustype, additionalparams )
{
    if ( !recipient )
    {
        return;
    }
    
    if ( !statustype )
    {
        assertmsg( "<dev string:x180>" );
        return;
    }
    
    if ( recipient.var_2bee526696230275 )
    {
        recipient.var_2bee526696230275[ statustype ] = undefined;
        
        if ( !recipient.var_2bee526696230275.size )
        {
            recipient.var_2bee526696230275 = undefined;
        }
    }
}

// Namespace status_tracking
// Params 4
// Checksum 0x9d04427, Offset: 0x44c
// Size: 0x4a
function function_67efe0a002b0b0a5( recipient, statustype, expirytime, additionalparams )
{
    if ( !( expirytime > 0 ) )
    {
        assertmsg( "<dev string:x1cf>" );
        return;
    }
    
    wait expirytime;
    function_646b346a2f15596c( recipient, statustype );
}

// Namespace status_tracking
// Params 6
// Checksum 0x4611929b, Offset: 0x49e
// Size: 0x8c
function function_f16113ca997f5b39( recipient, statustype, expirytime, var_1c383e957506b3e2, notifyhash, additionalparams )
{
    if ( !( expirytime > 0 ) )
    {
        assertmsg( "<dev string:x227>" );
        return;
    }
    
    if ( !notifyhash )
    {
        assertmsg( "<dev string:x287>" );
        return;
    }
    
    if ( !var_1c383e957506b3e2 )
    {
        assertmsg( "<dev string:x2e7>" );
        return;
    }
    
    var_1c383e957506b3e2 utility::waittill_notify_or_timeout( notifyhash, expirytime );
    function_646b346a2f15596c( recipient, statustype );
}

// Namespace status_tracking
// Params 5
// Checksum 0x1d51f426, Offset: 0x532
// Size: 0x75
function function_be3ac604aeea243c( recipient, statustype, var_1c383e957506b3e2, notifyhash, additionalparams )
{
    if ( !notifyhash )
    {
        assertmsg( "<dev string:x352>" );
        return;
    }
    
    if ( !var_1c383e957506b3e2 )
    {
        assertmsg( "<dev string:x3a9>" );
        return;
    }
    
    var_1c383e957506b3e2 endon( #"disconnect" );
    var_1c383e957506b3e2 waittill( notifyhash );
    function_646b346a2f15596c( recipient, statustype );
}

// Namespace status_tracking
// Params 6
// Checksum 0xda1a2dcf, Offset: 0x5af
// Size: 0x5f
function function_97d762c26d26677b( recipient, var_1e4624a03ea41715, var_8cd831a3c0cc9bdc, statusguid, expirytime, additionalparams )
{
    if ( !( expirytime > 0 ) )
    {
        assertmsg( "<dev string:x40b>" );
        return;
    }
    
    wait expirytime;
    removestatus( recipient, var_1e4624a03ea41715, var_8cd831a3c0cc9bdc, statusguid );
}

// Namespace status_tracking
// Params 7
// Checksum 0x94713519, Offset: 0x616
// Size: 0x99
function function_6b3c6d51642efdb0( recipient, var_1e4624a03ea41715, var_8cd831a3c0cc9bdc, statusguid, var_1c383e957506b3e2, notifyhash, additionalparams )
{
    if ( !notifyhash )
    {
        assertmsg( "<dev string:x454>" );
        return;
    }
    
    if ( !var_1c383e957506b3e2 )
    {
        assertmsg( "<dev string:x49c>" );
        return;
    }
    
    var_1c383e957506b3e2 endon( #"disconnect" );
    var_1c383e957506b3e2 childthread function_a8b79a9ea3d704d5( recipient, var_1e4624a03ea41715, var_8cd831a3c0cc9bdc, statusguid, notifyhash );
    var_1c383e957506b3e2 waittill( notifyhash );
    removestatus( recipient, var_1e4624a03ea41715, var_8cd831a3c0cc9bdc, statusguid );
}

// Namespace status_tracking
// Params 5, eflags: 0x4
// Checksum 0x41571df, Offset: 0x6b7
// Size: 0x4f
function private function_a8b79a9ea3d704d5( recipient, var_1e4624a03ea41715, var_8cd831a3c0cc9bdc, statusguid, notifyhash )
{
    self endon( notifyhash );
    self waittill( #"disconnect" );
    removestatus( recipient, var_1e4624a03ea41715, var_8cd831a3c0cc9bdc, statusguid );
}

// Namespace status_tracking
// Params 8
// Checksum 0xf1cdf0b8, Offset: 0x70e
// Size: 0xa1
function function_ef445664dd9d9137( recipient, var_1e4624a03ea41715, var_8cd831a3c0cc9bdc, statusguid, expirytime, var_1c383e957506b3e2, notifyhash, additionalparams )
{
    if ( !( expirytime > 0 ) )
    {
        assertmsg( "<dev string:x4ef>" );
        return;
    }
    
    if ( !notifyhash )
    {
        assertmsg( "<dev string:x540>" );
        return;
    }
    
    if ( !var_1c383e957506b3e2 )
    {
        assertmsg( "<dev string:x591>" );
        return;
    }
    
    var_1c383e957506b3e2 utility::waittill_notify_or_timeout( notifyhash, expirytime );
    removestatus( recipient, var_1e4624a03ea41715, var_8cd831a3c0cc9bdc, statusguid );
}

// Namespace status_tracking
// Params 5
// Checksum 0x1542fdaf, Offset: 0x7b7
// Size: 0xff
function removestatus( recipient, var_1e4624a03ea41715, var_8cd831a3c0cc9bdc, statusguid, additionalparams )
{
    victimguid = recipient.guid;
    
    if ( !victimguid )
    {
        return;
    }
    
    attackerguid = var_1e4624a03ea41715.guid ?? #"void_guid";
    
    if ( ( var_8cd831a3c0cc9bdc ?? -1 ) < 0 )
    {
        assertmsg( "<dev string:x5ed>" );
        return;
    }
    
    if ( ( statusguid ?? -1 ) < 0 )
    {
        assertmsg( "<dev string:x634>" );
        return;
    }
    
    statustracker = level.var_38f84e6d5f274bb.statustracker;
    statustracker[ victimguid ][ attackerguid ][ var_8cd831a3c0cc9bdc ][ statusguid ] = undefined;
    
    if ( !statustracker[ victimguid ][ attackerguid ][ var_8cd831a3c0cc9bdc ].size )
    {
        statustracker[ victimguid ][ attackerguid ][ var_8cd831a3c0cc9bdc ] = undefined;
    }
    
    if ( !statustracker[ victimguid ][ attackerguid ].size )
    {
        statustracker[ victimguid ][ attackerguid ] = undefined;
    }
    
    if ( !statustracker[ victimguid ].size )
    {
        statustracker[ victimguid ] = undefined;
    }
}

// Namespace status_tracking
// Params 2
// Checksum 0x374d2af6, Offset: 0x8be
// Size: 0x10a
function function_1195d97831be7b57( var_1e4624a03ea41715, var_8cd831a3c0cc9bdc )
{
    attackerguid = var_1e4624a03ea41715.guid ?? #"void_guid";
    
    if ( ( var_8cd831a3c0cc9bdc ?? -1 ) < 0 )
    {
        assertmsg( "<dev string:x674>" );
        return;
    }
    
    statustracker = level.var_38f84e6d5f274bb.statustracker;
    
    foreach ( victimguid, attackerentries in statustracker )
    {
        if ( !attackerentries[ attackerguid ][ var_8cd831a3c0cc9bdc ] )
        {
            continue;
        }
        
        statustracker[ victimguid ][ attackerguid ][ var_8cd831a3c0cc9bdc ] = undefined;
        
        if ( !statustracker[ victimguid ][ attackerguid ].size )
        {
            statustracker[ victimguid ][ attackerguid ] = undefined;
        }
        
        if ( !statustracker[ victimguid ].size )
        {
            statustracker[ victimguid ] = undefined;
        }
    }
}

// Namespace status_tracking
// Params 3
// Checksum 0x29d1ab69, Offset: 0x9d0
// Size: 0xd5
function function_758095091e5512be( recipient, var_1e4624a03ea41715, var_8cd831a3c0cc9bdc )
{
    victimguid = recipient.guid;
    
    if ( !victimguid )
    {
        assertmsg( "<dev string:x6c9>" );
        return;
    }
    
    attackerguid = var_1e4624a03ea41715.guid ?? #"void_guid";
    
    if ( ( var_8cd831a3c0cc9bdc ?? -1 ) < 0 )
    {
        assertmsg( "<dev string:x712>" );
        return;
    }
    
    statustracker = level.var_38f84e6d5f274bb.statustracker;
    
    if ( !statustracker[ victimguid ][ attackerguid ][ var_8cd831a3c0cc9bdc ] )
    {
        return;
    }
    
    statustracker[ victimguid ][ attackerguid ][ var_8cd831a3c0cc9bdc ] = undefined;
    
    if ( !statustracker[ victimguid ][ attackerguid ].size )
    {
        statustracker[ victimguid ][ attackerguid ] = undefined;
    }
    
    if ( !statustracker[ victimguid ].size )
    {
        statustracker[ victimguid ] = undefined;
    }
}

// Namespace status_tracking
// Params 1, eflags: 0x4
// Checksum 0xa926f72, Offset: 0xaad
// Size: 0x1b5
function private function_a34aef984160a893( params )
{
    victimguid = params.victim.guid;
    
    if ( !victimguid )
    {
        assertmsg( "<dev string:x764>" );
        return;
    }
    
    statustracker = level.var_38f84e6d5f274bb.statustracker;
    
    if ( !statustracker[ victimguid ] )
    {
        return;
    }
    
    foreach ( var_391fe36d290b053f in statustracker[ victimguid ] )
    {
        foreach ( var_a17ea2330d52188 in var_391fe36d290b053f )
        {
            foreach ( individualstatus in var_a17ea2330d52188 )
            {
                individualstatus.timeofdeath = params.deathtime;
            }
        }
    }
}

// Namespace status_tracking
// Params 1, eflags: 0x4
// Checksum 0xc6bd9378, Offset: 0xc6a
// Size: 0x5c
function private onplayerdeath( params )
{
    if ( !params.victim.guid )
    {
        assertmsg( "<dev string:x7af>" );
        return;
    }
    
    level.var_38f84e6d5f274bb.statustracker[ params.victim.guid ] = undefined;
}

// Namespace status_tracking
// Params 1, eflags: 0x4
// Checksum 0x18338431, Offset: 0xcce
// Size: 0x183
function private onplayerdisconnect( params )
{
    if ( !self.guid )
    {
        if ( self.connected )
        {
            assertmsg( "<dev string:x7f2>" );
        }
        
        return;
    }
    
    level.var_38f84e6d5f274bb.statustracker[ self.guid ] = undefined;
    
    foreach ( attackerentries in level.var_38f84e6d5f274bb.statustracker )
    {
        if ( !attackerentries[ self.guid ] )
        {
            continue;
        }
        
        if ( !isdefined( attackerentries[ #"void_guid" ] ) )
        {
            attackerentries[ #"void_guid" ] = [];
        }
        
        foreach ( var_8cd831a3c0cc9bdc, var_a4dc068fc28ab895 in attackerentries[ self.guid ] )
        {
            attackerentries[ #"void_guid" ][ var_8cd831a3c0cc9bdc ] = var_a4dc068fc28ab895;
        }
        
        attackerentries[ self.guid ] = undefined;
    }
}

// Namespace status_tracking
// Params 3
// Checksum 0x56c015b, Offset: 0xe59
// Size: 0x11e, Type: bool
function statusactive( attacker, victim, statustype )
{
    attackerguid = attacker.guid ?? #"void_guid";
    var_c3c4cf80f02eacdd = level.var_38f84e6d5f274bb.statustracker[ victim.guid ][ attackerguid ];
    
    foreach ( statussource in var_c3c4cf80f02eacdd )
    {
        if ( function_389a4f515c2668d4( statussource, #statustype, statustype ) )
        {
            return true;
        }
    }
    
    /#
        if ( !victim.guid )
        {
            assertmsg( "<dev string:x83a>" );
        }
        
        if ( !statustype )
        {
            assertmsg( "<dev string:x877>" );
        }
    #/
    
    return false;
}

// Namespace status_tracking
// Params 2
// Checksum 0xff498c1c, Offset: 0xf80
// Size: 0x128
function function_61a2753e4d5a34a2( requestedinstance, statustype )
{
    var_c3c4cf80f02eacdd = level.var_38f84e6d5f274bb.statustracker[ self.guid ][ self.guid ];
    
    switch ( requestedinstance )
    {
        case #"hash_c4bf47eac7ecc80c":
            foreach ( statussource in var_c3c4cf80f02eacdd )
            {
                if ( function_389a4f515c2668d4( statussource, #statustype, statustype ) )
                {
                    return statussource;
                }
            }
            
            break;
        default:
            assertmsg( "<dev string:x8cf>" );
            break;
    }
    
    /#
        if ( !self.guid )
        {
            assertmsg( "<dev string:x931>" );
        }
        
        if ( !statustype )
        {
            assertmsg( "<dev string:x992>" );
        }
    #/
}

