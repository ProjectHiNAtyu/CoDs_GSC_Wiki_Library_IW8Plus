// scripts\mp\br\gametypes\br_headgear.gsc  (hash_06071a06f8cd1e95.gscc) (size: 4566 Bytes / 0x11d6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x667cb44c (1719448652)
// size ...... 4566 (0x11d6)
// includes .. 2   (offset: 0x1182)
// strings ... 5   (offset: 0x1192)
// dev strs .. 0   (offset: 0x11d6)
// exports ... 25  (offset: 0xb8e)
// cseg ...... 0xf1 + 0xa9d (0xb8e)
// imports ... 18  (offset: 0xf76)
// animtree1 . 0   (offset: 0x11d6)
// animtree2 . 0   (offset: 0x11d6)
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_public;

#namespace br_headgear;

// Namespace br_headgear
// Params 0, eflags: 0x1
// Checksum 0x1369af8f, Offset: 0x10f
// Size: 0x4e
function autoexec headgear_init()
{
    level.headgeardata = spawnstruct();
    level.headgeardata.gear = [];
    utility::registersharedfunc( #"headgear", #"registerheadgear", &registerheadgear );
    level notify( #"headgear_init" );
}

// Namespace br_headgear
// Params 2
// Checksum 0xcc6e72c8, Offset: 0x165
// Size: 0x48
function registerheadgear( headgeartype, headgeardata )
{
    if ( isdefined( level.headgeardata.gear[ headgeartype ] ) )
    {
        return;
    }
    
    level.headgeardata.gear[ headgeartype ] = headgeardata;
}

// Namespace br_headgear
// Params 1
// Checksum 0xa7cc6d6a, Offset: 0x1b5
// Size: 0x2b, Type: bool
function function_8d2d82039f815a8f( headgeartype )
{
    if ( isdefined( headgeartype ) )
    {
        return isdefined( level.headgeardata.gear[ headgeartype ] );
    }
    
    return false;
}

// Namespace br_headgear
// Params 5
// Checksum 0x90eafdeb, Offset: 0x1e9
// Size: 0x6c
function initheadgear( headgeartype, player, headgearhealth, headgearref, headgearmaxhealth )
{
    headgeardata = level.headgeardata.gear[ headgeartype ];
    
    if ( isdefined( headgeardata ) )
    {
        player [[ headgeardata.var_7058909c0850f32f ]]( headgearhealth, headgearref, headgearmaxhealth );
    }
}

// Namespace br_headgear
// Params 1
// Checksum 0x759ae5d4, Offset: 0x25d
// Size: 0xac
function function_1ddf1555ebd88518( player )
{
    var_9faadee9feb3f324 = 0;
    
    foreach ( headgeardata in level.headgeardata.gear )
    {
        var_9faadee9feb3f324 = [[ headgeardata.var_e59404adc566edd0 ]]( player );
        
        if ( var_9faadee9feb3f324 )
        {
            break;
        }
    }
    
    return var_9faadee9feb3f324;
}

// Namespace br_headgear
// Params 1
// Checksum 0xea422a69, Offset: 0x312
// Size: 0xac
function function_915d0e7eb3f5dcdd( player )
{
    anyheadgear = 0;
    
    foreach ( headgeardata in level.headgeardata.gear )
    {
        anyheadgear = [[ headgeardata.var_d4127ffc4a33f741 ]]( player );
        
        if ( anyheadgear )
        {
            break;
        }
    }
    
    return anyheadgear;
}

// Namespace br_headgear
// Params 2
// Checksum 0xe5a48541, Offset: 0x3c7
// Size: 0x57
function hasheadgear( headgeartype, player )
{
    if ( !isdefined( headgeartype ) )
    {
        return 0;
    }
    
    headgeardata = level.headgeardata.gear[ headgeartype ];
    
    if ( isdefined( headgeardata ) )
    {
        return [[ headgeardata.var_d4127ffc4a33f741 ]]( player );
    }
    
    return 0;
}

// Namespace br_headgear
// Params 2
// Checksum 0x7b373708, Offset: 0x427
// Size: 0x4e
function function_cfd0c5842bf60d66( headgeartype, player )
{
    headgeardata = level.headgeardata.gear[ headgeartype ];
    
    if ( isdefined( headgeardata ) )
    {
        return [[ headgeardata.var_e59404adc566edd0 ]]( player );
    }
    
    return 0;
}

// Namespace br_headgear
// Params 1
// Checksum 0x20c995f1, Offset: 0x47e
// Size: 0x43
function function_f95a396894b1ddad( headgeartype )
{
    headgeardata = level.headgeardata.gear[ headgeartype ];
    
    if ( isdefined( headgeardata ) )
    {
        return [[ headgeardata.var_abc222b77737dfda ]]();
    }
    
    return 0;
}

// Namespace br_headgear
// Params 2
// Checksum 0x8bf226bf, Offset: 0x4ca
// Size: 0x4d
function function_6435617c4427123a( headgeartype, player )
{
    headgeardata = level.headgeardata.gear[ headgeartype ];
    
    if ( isdefined( headgeardata ) )
    {
        return [[ headgeardata.var_cbdf8c6be6174cc ]]( player );
    }
}

// Namespace br_headgear
// Params 2
// Checksum 0xe4c57ae, Offset: 0x520
// Size: 0x4e
function function_d26be71b65916bb0( headgeartype, player )
{
    headgeardata = level.headgeardata.gear[ headgeartype ];
    
    if ( isdefined( headgeardata ) )
    {
        return [[ headgeardata.var_d8ed88d301c75991 ]]( player );
    }
    
    return 0;
}

// Namespace br_headgear
// Params 3
// Checksum 0x8cbc49e6, Offset: 0x577
// Size: 0x58
function function_dc1842f4eec31f5c( headgeartype, player, pickup )
{
    headgeardata = level.headgeardata.gear[ headgeartype ];
    
    if ( isdefined( headgeardata ) )
    {
        return [[ headgeardata.var_f8afa4b15f2dfd1a ]]( player, pickup );
    }
    
    return 0;
}

// Namespace br_headgear
// Params 2
// Checksum 0x6a9caf57, Offset: 0x5d8
// Size: 0x4d
function tryrestock( headgeartype, player )
{
    headgeardata = level.headgeardata.gear[ headgeartype ];
    
    if ( isdefined( headgeardata ) )
    {
        player [[ headgeardata.var_395e196a7eb5381e ]]();
    }
}

// Namespace br_headgear
// Params 2
// Checksum 0x75eaa854, Offset: 0x62d
// Size: 0x4d
function function_ba7af88505b7d878( headgeartype, player )
{
    headgeardata = level.headgeardata.gear[ headgeartype ];
    
    if ( isdefined( headgeardata ) )
    {
        player [[ headgeardata.var_4e4dc022e7622dde ]]();
    }
}

// Namespace br_headgear
// Params 1
// Checksum 0xa12d1f21, Offset: 0x682
// Size: 0x16, Type: bool
function function_f3aef09f4c375a4c( player )
{
    return istrue( self.var_e6e238756ba13f0c );
}

// Namespace br_headgear
// Params 2
// Checksum 0x7cfe8fb, Offset: 0x6a1
// Size: 0x7c
function headgearon( headgeartype, request_reason )
{
    var_a161a250030b847a = function_1edc04c11dd22225( headgeartype );
    
    if ( !isdefined( self.requestedheadgear ) )
    {
        self.requestedheadgear = [];
    }
    
    if ( !isdefined( self.requestedheadgear[ headgeartype ] ) )
    {
        self.requestedheadgear[ headgeartype ] = [];
    }
    
    self.requestedheadgear[ headgeartype ][ request_reason ] = 1;
    
    if ( !var_a161a250030b847a )
    {
        thread function_93bad7eb56019c33( headgeartype );
    }
}

// Namespace br_headgear
// Params 2
// Checksum 0xe0142a45, Offset: 0x725
// Size: 0x6b
function headgearoff( headgeartype, request_reason )
{
    if ( !isdefined( self.requestedheadgear ) )
    {
        self.requestedheadgear = [];
    }
    
    if ( !isdefined( self.requestedheadgear[ headgeartype ] ) )
    {
        self.requestedheadgear[ headgeartype ] = [];
    }
    
    self.requestedheadgear[ headgeartype ][ request_reason ] = undefined;
    
    if ( !function_1edc04c11dd22225( headgeartype ) )
    {
        thread function_93bad7eb56019c33( headgeartype );
    }
}

// Namespace br_headgear
// Params 1, eflags: 0x4
// Checksum 0x6d0291b1, Offset: 0x798
// Size: 0x29, Type: bool
function private function_1edc04c11dd22225( headgeartype )
{
    requestreasons = self.requestedheadgear[ headgeartype ];
    return requestreasons.size > 0;
}

// Namespace br_headgear
// Params 1
// Checksum 0xb3c745d1, Offset: 0x7ca
// Size: 0x181
function function_93bad7eb56019c33( headgeartype )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    
    if ( self.var_e6e238756ba13f0c )
    {
        utility::waittill_notify_or_timeout( "head_gear_swap_complete", 2 );
        waitframe();
    }
    
    self notify( #"hash_57130d9bedd7e35" );
    self endon( #"hash_57130d9bedd7e35" );
    self.var_e6e238756ba13f0c = 1;
    waittillframeend();
    headgeardata = level.headgeardata.gear[ headgeartype ];
    function_13d44cc7f77cd45b();
    headgearequipped = istrue( [[ headgeardata.var_e59404adc566edd0 ]]( self ) );
    
    if ( !headgearequipped && function_1edc04c11dd22225( headgeartype ) )
    {
        self setsoundsubmix( "wz2_fly_gasmask" );
        equipheadgear( headgeartype );
        
        switch ( headgeartype )
        {
            case #"hash_4808e1f340e11163":
                var_19af5fb793f62d25 = 1;
                break;
            case #"hash_f86c09e41c83093":
                var_19af5fb793f62d25 = 2;
                break;
            case #"hash_8a1772f5f912c880":
                var_19af5fb793f62d25 = 3;
                break;
            default:
                var_19af5fb793f62d25 = 0;
                break;
        }
    }
    else if ( headgearequipped && !function_1edc04c11dd22225( headgeartype ) )
    {
        self clearsoundsubmix( "wz2_fly_gasmask" );
        removeheadgear( headgeartype );
        var_19af5fb793f62d25 = 0;
    }
    
    if ( isdefined( var_19af5fb793f62d25 ) )
    {
        br_public::updatebrscoreboardstat( "headGearType", var_19af5fb793f62d25 );
    }
    
    self notify( #"head_gear_swap_complete" );
    self.var_e6e238756ba13f0c = 0;
}

// Namespace br_headgear
// Params 1, eflags: 0x4
// Checksum 0xb5c7b218, Offset: 0x953
// Size: 0x87
function private equipheadgear( headgeartype )
{
    self endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    headgeardata = level.headgeardata.gear[ headgeartype ];
    
    if ( [[ headgeardata.var_d8ed88d301c75991 ]]( self ) == 0 )
    {
        return;
    }
    
    if ( isdefined( headgeardata.var_c615929c785b38db ) )
    {
        self [[ headgeardata.var_c615929c785b38db ]]();
    }
    
    self [[ headgeardata.var_ef9b6239a74b7964 ]]();
}

// Namespace br_headgear
// Params 1, eflags: 0x4
// Checksum 0xf55531de, Offset: 0x9e2
// Size: 0x73
function private removeheadgear( headgeartype )
{
    self endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    headgeardata = level.headgeardata.gear[ headgeartype ];
    
    if ( isdefined( headgeardata.var_27498b72660f8f41 ) )
    {
        self [[ headgeardata.var_27498b72660f8f41 ]]();
    }
    
    self [[ headgeardata.var_ce0f1a96b9992941 ]]();
}

// Namespace br_headgear
// Params 3
// Checksum 0x7608f56a, Offset: 0xa5d
// Size: 0x79
function function_43e3a6d7dd5bc804( player, headgeartype, request )
{
    headgeardata = level.headgeardata.gear[ headgeartype ];
    player [[ headgeardata.var_ce0f1a96b9992941 ]]();
    player [[ headgeardata.var_4e4dc022e7622dde ]]();
    
    if ( isdefined( self.headgearrequests ) )
    {
        self.headgearrequests[ request ] = undefined;
    }
}

// Namespace br_headgear
// Params 1
// Checksum 0x66b5094d, Offset: 0xade
// Size: 0x63
function breakheadgear( headgeartype )
{
    headgeardata = level.headgeardata.gear[ headgeartype ];
    self [[ headgeardata.breakfunc ]]();
    
    if ( ![[ headgeardata.var_e59404adc566edd0 ]]( self ) )
    {
        self.headgearrequests = undefined;
        self.headgeartype = undefined;
    }
}

// Namespace br_headgear
// Params 0
// Checksum 0x704763b2, Offset: 0xb49
// Size: 0x45
function function_13d44cc7f77cd45b()
{
    weapobj = makeweapon( "iw8_ges_plyr_loot_pickup" );
    
    if ( self hasweapon( weapobj ) )
    {
        if ( self isgestureplaying( "iw8_ges_pickup_br" ) )
        {
            self stopgestureviewmodel( "iw8_ges_pickup_br", 0, 1 );
        }
        
        self takeweapon( weapobj );
        waitframe();
    }
}

