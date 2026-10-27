// script_69309f364b954ca5  (hash_69309f364b954ca5.gscc) (size: 2122 Bytes / 0x84a / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc9129727 (3373438759)
// size ...... 2122 (0x84a)
// includes .. 5   (offset: 0x7e6)
// strings ... 4   (offset: 0x80e)
// dev strs .. 0   (offset: 0x84a)
// exports ... 8   (offset: 0x4da)
// cseg ...... 0xbe + 0x41c (0x4da)
// imports ... 16  (offset: 0x61a)
// animtree1 . 0   (offset: 0x84a)
// animtree2 . 0   (offset: 0x84a)
#using scripts\common\callbacks;
#using scripts\mp\common\utility\outline;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\teams;

#namespace specialty_downed_enemy_outline;

// Namespace specialty_downed_enemy_outline
// Params 0, eflags: 0x5
// Checksum 0xb520f317, Offset: 0xdc
// Size: 0x44
function private autoexec preinit()
{
    level callback::add( #"register_perk", &function_74809e5f60bff148 );
    level callback::add( #"player_laststand", &function_3a49debcd5f98521 );
    level callback::add( #"player_laststand_exit", &removeoutline );
}

// Namespace specialty_downed_enemy_outline
// Params 1, eflags: 0x4
// Checksum 0xef6af8a9, Offset: 0x128
// Size: 0x3a
function private function_74809e5f60bff148( params )
{
    if ( isdefined( params.var_bf34439fc0ca3cec ) )
    {
        level [[ params.var_bf34439fc0ca3cec ]]( "specialty_downed_enemy_outline", &setspecialty, &unsetspecialty, [] );
    }
}

// Namespace specialty_downed_enemy_outline
// Params 0, eflags: 0x4
// Checksum 0x487cd49a, Offset: 0x16a
// Size: 0x7e
function private setspecialty()
{
    player = self;
    
    if ( isdefined( player.var_9842326056fd7207 ) )
    {
        player.var_471a4d7193221a28 = player.var_9842326056fd7207.var_52c971d9054a1776 * player.var_9842326056fd7207.var_52c971d9054a1776;
        player.var_f920742efc47fdd3 = player.var_9842326056fd7207.var_c29f7107e26bc0d8 ?? "sat_outline_nodepth_downed_enemy";
    }
}

// Namespace specialty_downed_enemy_outline
// Params 0, eflags: 0x4
// Checksum 0x8d2ded64, Offset: 0x1f0
// Size: 0x25
function private unsetspecialty()
{
    player = self;
    player.var_471a4d7193221a28 = undefined;
    player.var_f920742efc47fdd3 = undefined;
}

// Namespace specialty_downed_enemy_outline
// Params 1, eflags: 0x4
// Checksum 0x7eb09499, Offset: 0x21d
// Size: 0x61
function private function_3a49debcd5f98521( params )
{
    victim = self;
    
    if ( !isplayer( params.attacker ) )
    {
        return;
    }
    
    if ( player_utility::isfriendly( victim.team, params.attacker ) )
    {
        return;
    }
    
    victim thread function_10eee6c3b8b49fd9( params.attacker );
}

// Namespace specialty_downed_enemy_outline
// Params 1, eflags: 0x4
// Checksum 0x5719be2e, Offset: 0x286
// Size: 0x1f8
function private function_10eee6c3b8b49fd9( attacker )
{
    victim = self;
    victim endon( #"hash_4540ab1734233790" );
    victim endon( #"disconnected" );
    level endon( #"game_ended" );
    
    while ( player::isinlaststand( victim ) )
    {
        var_d5a224a9b2ebe217 = [];
        outlineasset = "sat_outline_nodepth_downed_enemy";
        attackerallies = [];
        
        if ( teams::function_b00ab7e503f33379( attacker.team, "alivePlayers" ) )
        {
            attackerallies = teams::getteamdata( attacker.team, "alivePlayers" );
        }
        
        foreach ( p in attackerallies )
        {
            if ( !isdefined( p ) )
            {
                continue;
            }
            
            if ( !isdefined( p.perks[ "specialty_downed_enemy_outline" ] ) )
            {
                continue;
            }
            
            if ( !isdefined( p.var_471a4d7193221a28 ) )
            {
                continue;
            }
            
            if ( distance2dsquared( p.origin, victim.origin ) > p.var_471a4d7193221a28 )
            {
                continue;
            }
            
            if ( var_d5a224a9b2ebe217.size == 0 && isdefined( p.var_f920742efc47fdd3 ) )
            {
                outlineasset = p.var_f920742efc47fdd3;
            }
            
            var_d5a224a9b2ebe217[ var_d5a224a9b2ebe217.size ] = p;
        }
        
        if ( isdefined( victim.var_c28ab510c06c5f70 ) )
        {
            outline::outlinedisable( victim.var_c28ab510c06c5f70, victim );
            victim.var_c28ab510c06c5f70 = undefined;
        }
        
        if ( var_d5a224a9b2ebe217.size > 0 )
        {
            outlineid = outline::function_cc0ba57bbdf62b90( victim, var_d5a224a9b2ebe217, outlineasset, "level_script" );
            victim.var_c28ab510c06c5f70 = outlineid;
        }
        
        wait 1;
    }
}

// Namespace specialty_downed_enemy_outline
// Params 1, eflags: 0x4
// Checksum 0x2edeb667, Offset: 0x486
// Size: 0x54
function private removeoutline( params )
{
    victim = self;
    
    if ( isdefined( victim.var_c28ab510c06c5f70 ) )
    {
        victim notify( #"hash_4540ab1734233790" );
        outline::outlinedisable( victim.var_c28ab510c06c5f70, victim );
        victim.var_c28ab510c06c5f70 = undefined;
    }
}

