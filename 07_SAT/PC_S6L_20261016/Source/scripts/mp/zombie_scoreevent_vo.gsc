// scripts\mp\zombie_scoreevent_vo.gsc  (hash_5142c4d3accf253f.gscc) (size: 1073 Bytes / 0x431 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9526c297 (2502345367)
// size ...... 1073 (0x431)
// includes .. 4   (offset: 0x411)
// strings ... 0   (offset: 0x431)
// dev strs .. 0   (offset: 0x431)
// exports ... 5   (offset: 0x24d)
// cseg ...... 0x58 + 0x1f5 (0x24d)
// imports ... 9   (offset: 0x315)
// animtree1 . 0   (offset: 0x431)
// animtree2 . 0   (offset: 0x431)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\battlechatter_mp;

#namespace zombie_scoreevent_vo;

// Namespace zombie_scoreevent_vo
// Params 0, eflags: 0x5
// Checksum 0x8a380b8e, Offset: 0x76
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zombie_scoreevent_vo", undefined, &init_zombie_scoreevent_vo, undefined );
}

// Namespace zombie_scoreevent_vo
// Params 0
// Checksum 0xed1c2c5a, Offset: 0x97
// Size: 0x36
function init_zombie_scoreevent_vo()
{
    level callback::add( #"on_ai_killed", &on_ai_killed );
    utility::registersharedfunc( #"sound", #"play_scoreevent_vo", &play_scoreevent_vo );
}

// Namespace zombie_scoreevent_vo
// Params 1, eflags: 0x4
// Checksum 0xf42608fd, Offset: 0xd5
// Size: 0x14b
function private on_ai_killed( params )
{
    if ( !isplayer( params.eattacker ) )
    {
        return;
    }
    
    squadid = params.eattacker.sessionsquadid ?? 0;
    str_subclass = self.subclass;
    n_vo_delay = self.var_e29cf96ffe5ad58e ?? 0.7;
    
    if ( !( isdefined( str_subclass ) && isdefined( self.firstkillbattlechatter ) ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_660ad9b7bb75126 ) )
    {
        level.var_660ad9b7bb75126 = [];
    }
    
    if ( !isdefined( level.var_660ad9b7bb75126[ squadid ] ) )
    {
        level.var_660ad9b7bb75126[ squadid ] = [];
    }
    
    if ( isdefined( level.var_f47ecf60e4790ad6 ) && ![[ level.var_f47ecf60e4790ad6 ]]( params.eattacker, self.firstkillbattlechatter ) )
    {
        return;
    }
    
    if ( isdefined( level.var_660ad9b7bb75126[ squadid ][ str_subclass ] ) )
    {
        return;
    }
    
    level.var_660ad9b7bb75126[ squadid ][ str_subclass ] = 1;
    b_success = battlechatter_mp::trysaylocalsound( params.eattacker, self.firstkillbattlechatter, n_vo_delay );
    
    if ( !b_success )
    {
        level.var_660ad9b7bb75126[ squadid ][ str_subclass ] = undefined;
    }
}

// Namespace zombie_scoreevent_vo
// Params 2, eflags: 0x4
// Checksum 0x615d0e3d, Offset: 0x228
// Size: 0x25
function private play_scoreevent_vo( player, battlechatterasset )
{
    level thread battlechatter_mp::trysaylocalsound( player, battlechatterasset, 0.7 );
}

