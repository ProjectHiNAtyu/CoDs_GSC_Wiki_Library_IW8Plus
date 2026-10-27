// script_575aaa388a7265a0  (hash_575aaa388a7265a0.gscc) (size: 2120 Bytes / 0x848 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xecbffe65 (3972005477)
// size ...... 2120 (0x848)
// includes .. 3   (offset: 0x794)
// strings ... 10  (offset: 0x7ac)
// dev strs .. 0   (offset: 0x848)
// exports ... 11  (offset: 0x388)
// cseg ...... 0x10c + 0x27c (0x388)
// imports ... 21  (offset: 0x540)
// animtree1 . 0   (offset: 0x848)
// animtree2 . 0   (offset: 0x848)
#using script_aa3bac81ad4fc8e;
#using scripts\common\system;
#using scripts\common\utility;

#namespace zm_bgb_profit_sharing;

// Namespace zm_bgb_profit_sharing
// Params 0, eflags: 0x5
// Checksum 0x7e13653b, Offset: 0x12a
// Size: 0x1d
function private autoexec __init__system__()
{
    system::register( "profit_sharing", #"bgb", &__init__, undefined );
}

// Namespace zm_bgb_profit_sharing
// Params 0
// Checksum 0x6d3fc7ce, Offset: 0x14f
// Size: 0x43
function __init__()
{
    bgb::register( "profit_sharing", "time", 120, &enable, &disable, &validation );
    bgb::register_add_to_player_score_override( "profit_sharing", &function_ed911cdbb38c6719, 1 );
    bgb::function_ecc4426f6a3d4e88( "profit_sharing" );
}

// Namespace zm_bgb_profit_sharing
// Params 0
// Checksum 0xab8dbf3b, Offset: 0x19a
// Size: 0x30
function enable()
{
    self endon( #"disconnect", #"bled_out" );
    thread bgb::player_proximity_watcher( "profit_sharing", 720, &proximity_start, &proximity_end );
}

// Namespace zm_bgb_profit_sharing
// Params 0
// Checksum 0x283b2a1c, Offset: 0x1d2
// Size: 0x22
function disable()
{
    self notify( #"disable_profit_sharing" );
    self notify( "kill_" + "profit_sharing" + "_player_proximity_watcher" );
}

// Namespace zm_bgb_profit_sharing
// Params 0
// Checksum 0xedf2cf15, Offset: 0x1fc
// Size: 0x16, Type: bool
function validation()
{
    if ( level.players.size > 1 )
    {
        return true;
    }
    
    return false;
}

// Namespace zm_bgb_profit_sharing
// Params 3
// Checksum 0x30c74ade, Offset: 0x21b
// Size: 0x36
function function_ed911cdbb38c6719( var_eb8fc40490886d0a, var_18484ecb85b885be, var_f73031792a7a61f4 )
{
    return utility::callsharedfunc( "profit_sharing", #"hash_69e473d4d077e03e", var_eb8fc40490886d0a, var_18484ecb85b885be, var_f73031792a7a61f4 );
}

// Namespace zm_bgb_profit_sharing
// Params 1
// Checksum 0x8bfa494, Offset: 0x25a
// Size: 0x6c
function proximity_start( e_player )
{
    increment_fx_count();
    e_player increment_fx_count();
    str_notify = "profit_sharing_fx_stop_" + self getentitynumber();
    level utility::waittill_any_ents( e_player, "disconnect", e_player, str_notify, self, "disconnect", self, "disable_profit_sharing" );
    
    if ( isdefined( self ) )
    {
        decrement_fx_count();
    }
    
    if ( isdefined( e_player ) )
    {
        e_player decrement_fx_count();
    }
}

// Namespace zm_bgb_profit_sharing
// Params 1
// Checksum 0x2602abbb, Offset: 0x2ce
// Size: 0x28
function proximity_end( e_player )
{
    str_notify = "profit_sharing_fx_stop_" + self getentitynumber();
    e_player notify( str_notify );
}

// Namespace zm_bgb_profit_sharing
// Params 0
// Checksum 0xf62a7a3a, Offset: 0x2fe
// Size: 0x48
function increment_fx_count()
{
    if ( !isdefined( self.var_df10054d91588ec3 ) || self.var_df10054d91588ec3 == 0 )
    {
        self.var_df10054d91588ec3 = 1;
        self setscriptablepartstate( "bgb_profit_sharing", "bgb_fx_on", 0 );
        return;
    }
    
    self.var_df10054d91588ec3++;
}

// Namespace zm_bgb_profit_sharing
// Params 0
// Checksum 0x7d5f33b8, Offset: 0x34e
// Size: 0x3a
function decrement_fx_count()
{
    self.var_df10054d91588ec3--;
    
    if ( self.var_df10054d91588ec3 == 0 )
    {
        self setscriptablepartstate( "bgb_profit_sharing", "bgb_fx_off", 0 );
        self playlocalsound( #"hash_e89f34871bde6238" );
    }
}

