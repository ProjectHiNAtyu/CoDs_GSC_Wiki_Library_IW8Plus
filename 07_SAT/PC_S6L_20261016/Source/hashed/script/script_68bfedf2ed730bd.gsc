// script_68bfedf2ed730bd  (hash_068bfedf2ed730bd.gscc) (size: 23204 Bytes / 0x5aa4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2bb8e586 (733537670)
// size ...... 23204 (0x5aa4)
// includes .. 14  (offset: 0x562c)
// strings ... 71  (offset: 0x569c)
// dev strs .. 2   (offset: 0x5a8c)
// exports ... 70  (offset: 0x3bd0)
// cseg ...... 0x650 + 0x3580 (0x3bd0)
// imports ... 124 (offset: 0x46c0)
// animtree1 . 0   (offset: 0x5aa4)
// animtree2 . 0   (offset: 0x5aa4)
#using script_6962ddc481c4af49;
#using scripts\common\script;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_gulag;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_spawnrespawn;
#using scripts\mp\br\gametypes\br_twotwo_gulag;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\points;
#using scripts\mp\entityheadicons;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\loot\common_cache;
#using scripts\mp\objidpoolmanager;

#namespace namespace_a974e4dd85555bc2;

// Namespace namespace_a974e4dd85555bc2
// Params 0
// Checksum 0xfca76835, Offset: 0x66e
// Size: 0x45
function function_f3d31c54c906d814()
{
    function_3a0a24e84c84b37e();
    utility::registersharedfunc( #"hash_c3feadabb9698ca3", #"hash_c96c38e2c1dbf64d", &function_7f05505c2a486c8a );
    utility::registersharedfunc( #"hash_c3feadabb9698ca3", #"hash_7a56a72be10adcea", &function_f721a5d796c20f3d );
}

// Namespace namespace_a974e4dd85555bc2
// Params 0
// Checksum 0x41479813, Offset: 0x6bb
// Size: 0x15
function function_3a0a24e84c84b37e()
{
    game[ "dialog" ][ "gulag_jailer_intro" ] = "ruls_jalr_guin";
}

// Namespace namespace_a974e4dd85555bc2
// Params 4
// Checksum 0x4841d277, Offset: 0x6d8
// Size: 0x95
function function_59a96018edc0b5f3( var_955a2d535589a3bc, outlinecolor, var_552e541e8e65fca2, var_2cb993e412d25e45 )
{
    player = self;
    
    if ( !( isdefined( player ) && isdefined( var_955a2d535589a3bc ) ) )
    {
        return;
    }
    
    if ( isplayer( var_955a2d535589a3bc ) && !var_955a2d535589a3bc.gulag )
    {
        return;
    }
    
    if ( isplayer( player ) && !player br_public::isplayerinorgoingtogulag() )
    {
        return;
    }
    
    if ( !isdefined( outlinecolor ) )
    {
        outlinecolor = "outline_nodepth_orange";
    }
    
    var_955a2d535589a3bc hudoutlineenableforclient( player, outlinecolor );
    player thread gulag_hideplayeroutlinetoplayer( var_955a2d535589a3bc, var_552e541e8e65fca2, var_2cb993e412d25e45 );
}

// Namespace namespace_a974e4dd85555bc2
// Params 3
// Checksum 0xa65c2030, Offset: 0x775
// Size: 0xaf
function gulag_hideplayeroutlinetoplayer( var_a4e80db5d449a08, var_552e541e8e65fca2, var_2cb993e412d25e45 )
{
    if ( !isdefined( var_a4e80db5d449a08 ) )
    {
        return;
    }
    
    player = self;
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( var_552e541e8e65fca2 > 0 )
    {
        var_a4e80db5d449a08 utility::waittill_any_timeout( var_552e541e8e65fca2, "disconnect", "gulag_end", "hidePlayerOutlineToPlayer" );
    }
    else
    {
        var_a4e80db5d449a08 utility::waittill_any( "disconnect", "gulag_end", "hidePlayerOutlineToPlayer" );
    }
    
    if ( isdefined( var_a4e80db5d449a08 ) )
    {
        var_a4e80db5d449a08 hudoutlinedisableforclient( player );
    }
    
    wait 0.5;
    
    if ( var_2cb993e412d25e45 )
    {
        player thread function_59a96018edc0b5f3( var_a4e80db5d449a08, "outline_nodepth_green" );
    }
}

// Namespace namespace_a974e4dd85555bc2
// Params 1
// Checksum 0xae4b0554, Offset: 0x82c
// Size: 0x4f
function function_be4992d4e815be55( var_552e541e8e65fca2 )
{
    player = self;
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    player endon( #"gulag_end" );
    wait var_552e541e8e65fca2;
    player notify( #"hidePlayerOutlineToPlayer" );
}

// Namespace namespace_a974e4dd85555bc2
// Params 2
// Checksum 0x665fb152, Offset: 0x883
// Size: 0x79
function function_fdb0518b89ed7532( arena, showdelay = 0 )
{
    var_9110bbc4b1a9391 = 10;
    
    if ( showdelay > 0 )
    {
        wait showdelay;
        var_9110bbc4b1a9391 -= showdelay;
    }
    
    function_df890ade791a1d43( arena.var_efd329dcea50284d, arena.var_a6d852dcb4a74527, var_9110bbc4b1a9391 );
    function_df890ade791a1d43( arena.var_a6d852dcb4a74527, arena.var_efd329dcea50284d, var_9110bbc4b1a9391 );
}

// Namespace namespace_a974e4dd85555bc2
// Params 3, eflags: 0x4
// Checksum 0x2644b9bb, Offset: 0x904
// Size: 0x1e9
function private function_df890ade791a1d43( teama, teamb, var_9110bbc4b1a9391 )
{
    if ( !isdefined( teama ) )
    {
        return;
    }
    
    foreach ( p in teama )
    {
        if ( !isdefined( p ) )
        {
            continue;
        }
        
        foreach ( teammate in teama )
        {
            if ( !isdefined( teammate ) )
            {
                continue;
            }
            
            if ( teammate == p )
            {
                continue;
            }
            
            if ( level.var_56c3cc3dc37f1728.var_c590eb8406743f8e )
            {
                p thread function_59a96018edc0b5f3( teammate, "outline_nodepth_green", undefined, 0 );
            }
            
            entnum = teammate getentitynumber();
            valueomnvar = function_5e73872079fb2681( entnum );
            p setclientomnvar( "ui_br_twotwo_gulag_player_state", valueomnvar );
        }
        
        if ( isdefined( teamb ) )
        {
            foreach ( enemyp in teamb )
            {
                p thread function_59a96018edc0b5f3( enemyp, "outline_nodepth_red", var_9110bbc4b1a9391 );
            }
        }
    }
}

// Namespace namespace_a974e4dd85555bc2
// Params 1
// Checksum 0xc8378875, Offset: 0xaf5
// Size: 0x7a
function function_f442e90c459422( var_140de37ac76d55d4 )
{
    var_93ec7c7a6a65fa6e = self;
    
    if ( level.var_56c3cc3dc37f1728.var_3d03f046485d4942 )
    {
        var_93ec7c7a6a65fa6e setscriptablepartstate( "second_chance_door_dom_gulag", "door_move_up", 0 );
        var_140de37ac76d55d4 setscriptablepartstate( "second_chance_door_dom_gulag", "door_move_up", 0 );
        return;
    }
    
    var_93ec7c7a6a65fa6e setscriptablepartstate( "second_chance_door_dom_gulag", "door_move_up_slowly", 0 );
    var_140de37ac76d55d4 setscriptablepartstate( "second_chance_door_dom_gulag", "door_move_up_slowly", 0 );
}

// Namespace namespace_a974e4dd85555bc2
// Params 1
// Checksum 0x2f3ba1e0, Offset: 0xb77
// Size: 0xa5
function function_8b8c3fdbb7db7634( escapestruct )
{
    level endon( #"game_ended" );
    escapestruct.var_7ddc8630712addd3 setscriptablepartstate( "second_chance_door_dom_gulag", "door_move_down", 0 );
    escapestruct.var_f99b1f300f99e8dd setscriptablepartstate( "second_chance_door_dom_gulag", "door_move_down", 0 );
    wait level.var_56c3cc3dc37f1728.var_17fa9f4050417220;
    escapestruct.var_7ddc8630712addd3 setscriptablepartstate( "second_chance_door_dom_gulag", "door_standing_still", 0 );
    escapestruct.var_f99b1f300f99e8dd setscriptablepartstate( "second_chance_door_dom_gulag", "door_standing_still_unusable", 0 );
    escapestruct.dooropen = 0;
}

// Namespace namespace_a974e4dd85555bc2
// Params 1
// Checksum 0x7dac554b, Offset: 0xc24
// Size: 0x43
function function_5b016a1dc9286846( escapestruct )
{
    player = self;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    objective_addclienttomask( escapestruct.objid, player );
    objective_showtoplayersinmask( escapestruct.objid );
}

// Namespace namespace_a974e4dd85555bc2
// Params 1
// Checksum 0xe0dc1899, Offset: 0xc6f
// Size: 0xb9
function function_37851954e6b398ce( arena )
{
    escapestruct = self;
    
    foreach ( p in arena.arenaplayers )
    {
        if ( !isdefined( p ) || p.gulagdoor == escapestruct )
        {
            continue;
        }
        
        objidpoolmanager::objective_playermask_hidefrom( escapestruct.objid, p );
    }
}

// Namespace namespace_a974e4dd85555bc2
// Params 0
// Checksum 0xcf302c3f, Offset: 0xd30
// Size: 0x3e
function function_b688da6d50811b1()
{
    player = self;
    player endon( #"disconnect" );
    level endon( #"game_ended" );
    wait 11;
    
    if ( !player br_public::isplayerinorgoingtogulag() )
    {
        player kill();
    }
}

// Namespace namespace_a974e4dd85555bc2
// Params 2
// Checksum 0x12260fa7, Offset: 0xd76
// Size: 0x67
function function_c95ee1c1f2c475cd( headicon, var_b9da3c3df190ceae )
{
    playershowto = self;
    level endon( #"game_ended" );
    var_b9da3c3df190ceae endon( #"watchheadicondelete" );
    utility::waittill_any_ents( playershowto, "death", playershowto, "disconnect", playershowto, "gulag_end" );
    
    if ( !isdefined( playershowto ) )
    {
        return;
    }
    
    removeclientfromheadiconmask( headicon, playershowto );
}

// Namespace namespace_a974e4dd85555bc2
// Params 2
// Checksum 0xc80d94e6, Offset: 0xde5
// Size: 0x60
function gulag_watchheadicondelete( headicon, playershowto )
{
    var_b9da3c3df190ceae = self;
    level endon( #"game_ended" );
    utility::waittill_any_ents( var_b9da3c3df190ceae, "death", var_b9da3c3df190ceae, "disconnect", var_b9da3c3df190ceae, "gulag_end" );
    var_b9da3c3df190ceae notify( #"watchheadicondelete" );
    entityheadicons::setheadicon_deleteicon( headicon );
}

// Namespace namespace_a974e4dd85555bc2
// Params 1
// Checksum 0x82e5541f, Offset: 0xe4d
// Size: 0x153
function function_ca1a299149bce909( arena )
{
    foreach ( escapestruct in arena.escapestructs )
    {
        objid = objidpoolmanager::requestobjectiveid( 99 );
        
        if ( objid != -1 )
        {
            doorcenter = ( escapestruct.var_7ddc8630712addd3.origin + escapestruct.var_f99b1f300f99e8dd.origin ) / 2;
            offset = ( doorcenter - escapestruct.origin ) * 0.9;
            objidpoolmanager::objective_add_objective( objid, "current", escapestruct.origin + ( offset[ 0 ], offset[ 1 ], 60 ), "ui_mp_br_icon_gulag_exit_objective" );
            objidpoolmanager::update_objective_setbackground( objid, 1 );
            objidpoolmanager::objective_playermask_hidefromall( objid );
            objidpoolmanager::objective_set_play_intro( objid, 0 );
        }
        else
        {
            println( "<dev string:x24>" );
        }
        
        escapestruct.objid = objid;
    }
}

// Namespace namespace_a974e4dd85555bc2
// Params 0
// Checksum 0xd4f5b29e, Offset: 0xfa8
// Size: 0x29
function function_7fea090e43708ff1()
{
    player = self;
    player.var_b1abfa3404387f68 = 0;
    player.var_349e7cce4865e43c = 0;
}

// Namespace namespace_a974e4dd85555bc2
// Params 0
// Checksum 0x4ca5663c, Offset: 0xfd9
// Size: 0x5b, Type: bool
function function_831861a029b85f4c()
{
    player = self;
    
    if ( level.usegulag && isdefined( level.var_56c3cc3dc37f1728 ) && !level.var_56c3cc3dc37f1728.var_b91427da7e498253 && isplayer( player ) && player br_public::isplayeringulag() )
    {
        return false;
    }
    
    return true;
}

// Namespace namespace_a974e4dd85555bc2
// Params 1
// Checksum 0xdea2f33c, Offset: 0x103d
// Size: 0x135
function function_bf71a0a0d9ead210( arena )
{
    player = self;
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    
    if ( !isdefined( arena.bestscore ) )
    {
        arena.bestscore = 0;
    }
    
    var_bdb7d57037304f19 = function_2ad5c45f25f08d17();
    [ totalscore, var_62641735a61336ee, var_32532b1f42ae5263, playeraccuracy, var_eab3cd8a0924188c, starscore ] = function_4d00d0098c63413b( var_bdb7d57037304f19 );
    player function_6d8ba63adc2d78f4( player.gulagkills, var_bdb7d57037304f19, playeraccuracy );
    isbestscore = 0;
    
    if ( totalscore > arena.bestscore )
    {
        isbestscore = 1;
        arena.bestscore = totalscore;
    }
    
    player function_3b3e7febe8c1226a( isbestscore, starscore, totalscore );
    player thread points::doscoreevent( #"br_ai_gulag_score", undefined, int( totalscore / 450 ) * 10 );
}

// Namespace namespace_a974e4dd85555bc2
// Params 1
// Checksum 0x10e6881c, Offset: 0x117a
// Size: 0x484
function function_4d00d0098c63413b( var_bdb7d57037304f19 )
{
    player = self;
    finalscore = 0;
    var_3d84428518702cd6 = 0;
    
    if ( level.var_56c3cc3dc37f1728.var_bb3c05689c4c9669 > 0 )
    {
        var_3d84428518702cd6 = level.var_56c3cc3dc37f1728.var_bb3c05689c4c9669;
    }
    
    var_62641735a61336ee = 0;
    
    if ( level.var_56c3cc3dc37f1728.var_c94a3da7ef9b6603 )
    {
        var_e7f017ee990be01b = strtok( level.var_56c3cc3dc37f1728.var_c94a3da7ef9b6603, " " );
        i = 0;
        
        while ( i < var_e7f017ee990be01b.size )
        {
            if ( int( var_e7f017ee990be01b[ i ] ) >= var_bdb7d57037304f19 )
            {
                if ( isdefined( var_e7f017ee990be01b[ i - 1 ] ) )
                {
                    var_62641735a61336ee = int( var_e7f017ee990be01b[ i - 1 ] );
                }
                else
                {
                    var_62641735a61336ee = int( var_e7f017ee990be01b[ i + 1 ] );
                }
                
                break;
            }
            
            i += 2;
        }
    }
    
    var_32532b1f42ae5263 = 0;
    
    if ( isdefined( player.gulagkills ) && isdefined( level.var_56c3cc3dc37f1728.var_3e70447761a06062 ) && level.var_56c3cc3dc37f1728.var_3e70447761a06062 != "" )
    {
        var_eba411a55978a294 = strtok( level.var_56c3cc3dc37f1728.var_3e70447761a06062, " " );
        i = 0;
        
        while ( i < var_eba411a55978a294.size )
        {
            if ( int( var_eba411a55978a294[ i ] ) <= player.gulagkills )
            {
                if ( isdefined( var_eba411a55978a294[ i + 1 ] ) )
                {
                    var_32532b1f42ae5263 = int( var_eba411a55978a294[ i + 1 ] );
                }
                else
                {
                    var_32532b1f42ae5263 = int( var_eba411a55978a294[ i - 1 ] );
                }
                
                break;
            }
            
            i += 2;
        }
    }
    
    var_c53cac93f2e9d7ae = 0;
    var_fba06cf0d0bcff1a = 0;
    
    if ( player.var_645eef13705c0695 > 0 && isdefined( level.var_56c3cc3dc37f1728.var_27bcd306379bddc3 ) && level.var_56c3cc3dc37f1728.var_27bcd306379bddc3 != "" )
    {
        var_e7ced69bfde207db = strtok( level.var_56c3cc3dc37f1728.var_27bcd306379bddc3, " " );
        
        if ( player.var_82aa9e2a587b9dd7 > 0 && isdefined( player.var_645eef13705c0695 ) && player.var_645eef13705c0695 > 0 )
        {
            var_fba06cf0d0bcff1a = int( player.var_82aa9e2a587b9dd7 / player.var_645eef13705c0695 * 100 );
        }
        
        i = 0;
        
        while ( i < var_e7ced69bfde207db.size )
        {
            if ( int( var_e7ced69bfde207db[ i ] ) <= var_fba06cf0d0bcff1a )
            {
                if ( isdefined( var_e7ced69bfde207db[ i + 1 ] ) )
                {
                    var_c53cac93f2e9d7ae = int( var_e7ced69bfde207db[ i + 1 ] );
                }
                else
                {
                    var_c53cac93f2e9d7ae = int( var_e7ced69bfde207db[ i - 1 ] );
                }
                
                break;
            }
            
            i += 2;
        }
    }
    
    var_eab3cd8a0924188c = 0;
    
    if ( level.var_56c3cc3dc37f1728.var_75404b003ec660be )
    {
        var_f4bade956aa3d80 = strtok( level.var_56c3cc3dc37f1728.var_75404b003ec660be, " " );
        
        if ( !isdefined( player.var_f4ced78321048739 ) )
        {
            var_eab3cd8a0924188c = int( var_f4bade956aa3d80[ 1 ] );
        }
        else
        {
            i = 0;
            
            while ( i < var_f4bade956aa3d80.size )
            {
                if ( int( var_f4bade956aa3d80[ i ] ) >= player.var_f4ced78321048739 )
                {
                    if ( isdefined( var_f4bade956aa3d80[ i - 1 ] ) )
                    {
                        var_eab3cd8a0924188c = int( var_f4bade956aa3d80[ i - 1 ] );
                    }
                    else
                    {
                        var_eab3cd8a0924188c = int( var_f4bade956aa3d80[ i + 1 ] );
                    }
                    
                    break;
                }
                
                i += 2;
            }
        }
    }
    
    finalscore = var_3d84428518702cd6 + var_62641735a61336ee + var_32532b1f42ae5263 + var_c53cac93f2e9d7ae + var_eab3cd8a0924188c;
    starscore = 0;
    
    if ( level.var_56c3cc3dc37f1728.var_a3566f7e80af1e0a )
    {
        var_8f19636ff212a49c = strtok( level.var_56c3cc3dc37f1728.var_a3566f7e80af1e0a, " " );
        i = 0;
        
        while ( i < var_8f19636ff212a49c.size )
        {
            if ( int( var_8f19636ff212a49c[ i ] ) > finalscore )
            {
                if ( isdefined( var_8f19636ff212a49c[ i - 1 ] ) )
                {
                    starscore = int( var_8f19636ff212a49c[ i - 1 ] );
                }
                else
                {
                    starscore = int( var_8f19636ff212a49c[ i + 1 ] );
                }
                
                break;
            }
            
            i += 2;
        }
    }
    
    player.var_716f2b98a73614d0 = finalscore;
    player.starscorepoints = starscore;
    return [ finalscore, var_62641735a61336ee, var_32532b1f42ae5263, var_fba06cf0d0bcff1a, var_eab3cd8a0924188c, starscore ];
}

// Namespace namespace_a974e4dd85555bc2
// Params 3
// Checksum 0x5ea81cc0, Offset: 0x1607
// Size: 0x72
function function_6d8ba63adc2d78f4( playerkills, playertime, playeraccuracy )
{
    player = self;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( !isdefined( playerkills ) || playerkills < 0 )
    {
        playerkills = 0;
    }
    
    playertime = int( playertime / 100 );
    omnvarvalue = function_89943b6cdef1a133( playerkills, playertime, playeraccuracy );
    player setclientomnvar( "ui_br_ai_gulag_end_score", omnvarvalue );
}

// Namespace namespace_a974e4dd85555bc2
// Params 3
// Checksum 0xe7f28d7b, Offset: 0x1681
// Size: 0xb9
function function_89943b6cdef1a133( playerkills, playertime, playeraccuracy )
{
    playerkillsmax = 31;
    var_420969cd7c1c9a38 = 1023;
    var_cf010b45c01fb340 = 1023;
    assert( playerkills >= 0 && playerkills <= playerkillsmax );
    assert( playertime >= 0 && playertime <= var_420969cd7c1c9a38 );
    assert( playeraccuracy >= 0 && playeraccuracy <= var_cf010b45c01fb340 );
    packedval = int( playerkills ) & playerkillsmax;
    packedval += ( int( playertime ) & var_420969cd7c1c9a38 ) << 5;
    packedval += ( int( playeraccuracy ) & var_cf010b45c01fb340 ) << 15;
    return packedval;
}

// Namespace namespace_a974e4dd85555bc2
// Params 3
// Checksum 0x6692f19c, Offset: 0x1743
// Size: 0x55
function function_3b3e7febe8c1226a( isbestscore, playerstars, playerscore )
{
    player = self;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    omnvarvalue = function_edb39dfdf6ba1a1( isbestscore, playerstars, playerscore );
    player setclientomnvar( "ui_br_ai_gulag_end_score_best", omnvarvalue );
}

// Namespace namespace_a974e4dd85555bc2
// Params 3
// Checksum 0x7cf9f0a8, Offset: 0x17a0
// Size: 0xba
function function_edb39dfdf6ba1a1( isbestscore, playerstars, playerscore )
{
    var_2b170e2157e13008 = 1;
    var_3f71c01bf59e41d6 = 7;
    playerscoremax = 268435455;
    assert( isbestscore >= 0 && isbestscore <= var_2b170e2157e13008 );
    assert( playerstars >= 0 && playerstars <= var_3f71c01bf59e41d6 );
    assert( playerscore >= 0 && playerscore <= playerscoremax );
    packedval = int( isbestscore ) & var_2b170e2157e13008;
    packedval += ( int( playerstars ) & var_3f71c01bf59e41d6 ) << 1;
    packedval += ( int( playerscore ) & playerscoremax ) << 4;
    return packedval;
}

// Namespace namespace_a974e4dd85555bc2
// Params 1
// Checksum 0xb49ce5a8, Offset: 0x1863
// Size: 0x43
function function_5e73872079fb2681( teammateenum )
{
    var_8df5a2a4ebc56983 = 255;
    assert( teammateenum >= 0 && teammateenum <= var_8df5a2a4ebc56983 );
    packedval = int( teammateenum ) & var_8df5a2a4ebc56983;
    return packedval;
}

// Namespace namespace_a974e4dd85555bc2
// Params 1
// Checksum 0x7ee6e385, Offset: 0x18af
// Size: 0x90
function function_1ecc4ba3f2877c6b( arena )
{
    objid = objidpoolmanager::requestobjectiveid( 99 );
    
    if ( objid != -1 )
    {
        objidpoolmanager::objective_add_objective( objid, "current", arena.center + ( 0, 0, -60 ), "hud_icon_objective_skeleton_key" );
        objidpoolmanager::update_objective_setbackground( objid, 1 );
        objidpoolmanager::objective_playermask_hidefromall( objid );
        objidpoolmanager::objective_set_play_intro( objid, 0 );
    }
    else
    {
        println( "<dev string:x4e>" );
    }
    
    arena.var_a98408151b6ba3bc = objid;
}

// Namespace namespace_a974e4dd85555bc2
// Params 2
// Checksum 0x348144b4, Offset: 0x1947
// Size: 0xe4
function function_30f8f49dae1ba5e8( arena, position )
{
    if ( !isdefined( arena.var_a98408151b6ba3bc ) )
    {
        return;
    }
    
    objective_position( arena.var_a98408151b6ba3bc, position + ( 0, 0, 20 ) );
    
    foreach ( p in arena.arenaplayers )
    {
        if ( !isdefined( p ) )
        {
            continue;
        }
        
        objective_addclienttomask( arena.var_a98408151b6ba3bc, p );
        objective_showtoplayersinmask( arena.var_a98408151b6ba3bc );
    }
}

// Namespace namespace_a974e4dd85555bc2
// Params 1
// Checksum 0xdbcb853c, Offset: 0x1a33
// Size: 0xad
function function_e4960e6de235bd4d( arena )
{
    if ( !isdefined( arena.var_a98408151b6ba3bc ) )
    {
        return;
    }
    
    foreach ( p in arena.arenaplayers )
    {
        if ( !isdefined( p ) )
        {
            continue;
        }
        
        objidpoolmanager::objective_playermask_hidefrom( arena.var_a98408151b6ba3bc, p );
    }
}

// Namespace namespace_a974e4dd85555bc2
// Params 1
// Checksum 0x5ebe2ee1, Offset: 0x1ae8
// Size: 0x71, Type: bool
function function_64591ecc14010927( arena )
{
    if ( level.var_56c3cc3dc37f1728.var_e4e46cc4a1abab24 <= 0 )
    {
        return false;
    }
    
    if ( level.var_56c3cc3dc37f1728.var_e4e46cc4a1abab24 == 1 )
    {
        return true;
    }
    else if ( level.var_56c3cc3dc37f1728.var_e4e46cc4a1abab24 == 2 )
    {
        if ( !arena.var_e55af00897688334 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_a974e4dd85555bc2
// Params 1, eflags: 0x4
// Checksum 0xc6254dea, Offset: 0x1b62
// Size: 0x8a, Type: bool
function private function_cf25329f3740bc27( arenas )
{
    foreach ( arena in arenas )
    {
        if ( arena.matches.size > 0 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace namespace_a974e4dd85555bc2
// Params 1, eflags: 0x4
// Checksum 0x79ff9589, Offset: 0x1bf5
// Size: 0x157
function private function_c049caa41d3e176a( arenas )
{
    var_66765a032f3622f4 = undefined;
    
    foreach ( arena in arenas )
    {
        if ( !br_gulag::isarenaenabled( arena, self ) )
        {
            continue;
        }
        
        foreach ( match in arena.matches )
        {
            if ( match.size < 2 )
            {
                allycounter = br_gulag::function_eb595854335a8ead( match );
                
                if ( match.size >= 2 || allycounter < 1 )
                {
                    if ( arena.fightover )
                    {
                        return arena;
                    }
                    
                    if ( !isdefined( var_66765a032f3622f4 ) )
                    {
                        break;
                    }
                    
                    var_66765a032f3622f4 = arena;
                    break;
                }
            }
        }
    }
    
    return var_66765a032f3622f4;
}

// Namespace namespace_a974e4dd85555bc2
// Params 1, eflags: 0x4
// Checksum 0x3a8b8588, Offset: 0x1d55
// Size: 0x1bf
function private function_2a62f94a74ab393e( arenas )
{
    var_ee40d1c4bbd18f2 = 99;
    bestarena = undefined;
    
    foreach ( arena in arenas )
    {
        if ( !br_gulag::isarenaenabled( arena, self ) )
        {
            continue;
        }
        
        if ( arena.matches.size > var_ee40d1c4bbd18f2 )
        {
            continue;
        }
        
        if ( arena.matches.size == var_ee40d1c4bbd18f2 )
        {
            if ( arena.fightover && !bestarena.fightover )
            {
                bestarena = arena;
                continue;
            }
        }
        
        match = arena.matches[ arena.matches.size - 1 ];
        
        if ( match.size > 0 )
        {
            foreach ( player in match )
            {
                var_cd9b803b84c3188c = br_gulag::function_eb595854335a8ead( match );
                
                if ( var_cd9b803b84c3188c < 2 )
                {
                    var_ee40d1c4bbd18f2 = arena.matches.size;
                    bestarena = arena;
                }
            }
            
            continue;
        }
        
        var_ee40d1c4bbd18f2 = arena.matches.size;
        bestarena = arena;
    }
    
    return bestarena;
}

// Namespace namespace_a974e4dd85555bc2
// Params 2
// Checksum 0x5c21b17d, Offset: 0x1f1d
// Size: 0x12f
function gulag_playergetnextarena( overridearenas, forceoverride )
{
    if ( level.var_56c3cc3dc37f1728.var_f7686e810b4850dc )
    {
        if ( !forceoverride )
        {
            overridearenas = undefined;
        }
        
        return br_gulag::playergetnextarena( overridearenas );
    }
    
    var_43ee6a728032df30 = getdvarint( @"hash_8bdee07fa09e810a", -1 );
    
    if ( var_43ee6a728032df30 > -1 )
    {
        return level.gulag.arenas[ var_43ee6a728032df30 ];
    }
    
    if ( !level.gulag.multiarena )
    {
        return br_gulag::function_164f7b989c5be26b( overridearenas );
    }
    
    arenas = forceoverride ? overridearenas : level.gulag.arenas;
    
    if ( function_cf25329f3740bc27( arenas ) )
    {
        return br_gulag::function_70336e6d7f6b43c( arenas );
    }
    
    bestarena = function_c049caa41d3e176a( arenas );
    
    if ( isdefined( bestarena ) )
    {
        return bestarena;
    }
    
    arenas = overridearenas ?? level.gulag.arenas;
    bestarena = function_2a62f94a74ab393e( arenas );
    
    if ( isdefined( bestarena ) )
    {
        return bestarena;
    }
    
    script::demoforcesre( "[GULAG] gulag_playerGetNextArena : could not find a proper gulag arena. Returning a random arena" );
    return arenas[ randomint( arenas.size ) ];
}

// Namespace namespace_a974e4dd85555bc2
// Params 1
// Checksum 0x142013e6, Offset: 0x2055
// Size: 0xe0
function function_92219d23681fc17e( arena )
{
    arenacenter = arena.center;
    lootcaches = getlootscriptablearray( "br_loot_cache_gulag" );
    
    foreach ( cache in lootcaches )
    {
        if ( distance( cache.origin, arenacenter ) < 8000 )
        {
            items = getscriptablelootcachecontents( cache );
            common_cache::function_a09e7cf5bad99b64( cache, items );
            cache setscriptablepartstate( "body", "closed_usable" );
        }
    }
}

// Namespace namespace_a974e4dd85555bc2
// Params 1
// Checksum 0xf7859d8d, Offset: 0x213d
// Size: 0x121
function function_bc8c8f723d5d7be8( player )
{
    if ( isdefined( level.gulag ) && isdefined( level.gulag.arenas ) )
    {
        for ( i = 0; i < level.gulag.arenas.size ; i++ )
        {
            currentarena = level.gulag.arenas[ i ];
            
            foreach ( arenaplayer in currentarena.arenaplayers )
            {
                if ( !isdefined( arenaplayer ) )
                {
                    continue;
                }
                
                if ( arenaplayer == player )
                {
                    arena = level.gulag.arenas[ i ];
                    return arena;
                }
            }
        }
    }
}

// Namespace namespace_a974e4dd85555bc2
// Params 1
// Checksum 0x23f3008f, Offset: 0x2267
// Size: 0xfd
function function_b137a10652cd5cd6( player )
{
    for ( i = 0; i < level.gulag.arenas.size ; i++ )
    {
        currentarena = level.gulag.arenas[ i ];
        
        foreach ( jailedplayers in currentarena.jailedplayers )
        {
            if ( !isdefined( jailedplayers ) )
            {
                continue;
            }
            
            if ( jailedplayers == player )
            {
                arena = level.gulag.arenas[ i ];
                return arena;
            }
        }
    }
}

// Namespace namespace_a974e4dd85555bc2
// Params 1
// Checksum 0x6d8815f1, Offset: 0x236d
// Size: 0xb4
function function_b558242d36918a10( arena )
{
    if ( isdefined( arena.var_f2bd026a83c7bd98 ) )
    {
        foreach ( var_13386901e02d8aa9 in arena.var_f2bd026a83c7bd98 )
        {
            if ( !isdefined( var_13386901e02d8aa9 ) )
            {
                continue;
            }
            
            var_13386901e02d8aa9 freescriptable();
        }
        
        arena.var_f2bd026a83c7bd98 = [];
        function_e4960e6de235bd4d( arena );
    }
}

// Namespace namespace_a974e4dd85555bc2
// Params 1
// Checksum 0x4d17b5c0, Offset: 0x2429
// Size: 0x10a
function function_477878ad94e018cc( arena )
{
    foreach ( escapestruct in arena.escapestructs )
    {
        escapestruct.var_7ddc8630712addd3 setscriptablepartstate( "second_chance_door_dom_gulag", "door_standing_still", 0 );
        escapestruct.var_7ddc8630712addd3.origin = escapestruct.var_7ddc8630712addd3.initiallocation;
        escapestruct.var_f99b1f300f99e8dd setscriptablepartstate( "second_chance_door_dom_gulag", "door_standing_still", 0 );
        escapestruct.var_f99b1f300f99e8dd.origin = escapestruct.var_f99b1f300f99e8dd.initiallocation;
    }
}

// Namespace namespace_a974e4dd85555bc2
// Params 1
// Checksum 0x5529d1f5, Offset: 0x253b
// Size: 0xac
function function_94b45d10e2b08d56( arena )
{
    foreach ( loot in arena.lootpickedup )
    {
        if ( !isdefined( loot ) )
        {
            continue;
        }
        
        loot setscriptablepartstate( loot.type, "visible" );
    }
    
    arena.lootpickedup = [];
}

// Namespace namespace_a974e4dd85555bc2
// Params 2
// Checksum 0x35deca03, Offset: 0x25ef
// Size: 0x11d, Type: bool
function function_f721a5d796c20f3d( attacker, victim )
{
    if ( !namespace_a8afdcd7738e364e::function_3da7ed4f19aeb4( "gulag2v2Teams" ) )
    {
        return false;
    }
    
    arena = function_bc8c8f723d5d7be8( attacker );
    
    if ( !isdefined( arena ) )
    {
        return false;
    }
    
    if ( isplayer( victim ) && isplayer( attacker ) && victim.gulag && attacker.gulag )
    {
        var_ce9f341055de2e7d = arraycontains( arena.var_efd329dcea50284d, attacker );
        var_7d6f5393b3902fcc = arraycontains( arena.var_efd329dcea50284d, victim );
        var_67ebed6970dc872b = undefined;
        var_fd14631197b7bf28 = undefined;
        
        if ( isdefined( arena.var_a6d852dcb4a74527 ) )
        {
            var_67ebed6970dc872b = arraycontains( arena.var_a6d852dcb4a74527, attacker );
            var_fd14631197b7bf28 = arraycontains( arena.var_a6d852dcb4a74527, victim );
        }
        
        if ( var_ce9f341055de2e7d && var_7d6f5393b3902fcc || isdefined( var_67ebed6970dc872b ) && isdefined( var_fd14631197b7bf28 ) && var_67ebed6970dc872b && var_fd14631197b7bf28 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_a974e4dd85555bc2
// Params 2
// Checksum 0xc1de41fb, Offset: 0x2715
// Size: 0x13f, Type: bool
function function_7f05505c2a486c8a( attacker, victim )
{
    if ( !namespace_a8afdcd7738e364e::function_3da7ed4f19aeb4( "gulag2v2Teams" ) || !( isdefined( victim ) && isdefined( attacker ) ) )
    {
        return false;
    }
    
    if ( victim.team != attacker.team )
    {
        return false;
    }
    
    arena = function_bc8c8f723d5d7be8( attacker );
    
    if ( !isdefined( arena ) )
    {
        return false;
    }
    
    if ( isplayer( victim ) && isplayer( attacker ) && victim.gulag && attacker.gulag )
    {
        if ( victim.team == attacker.team )
        {
            var_ce9f341055de2e7d = arraycontains( arena.var_efd329dcea50284d, attacker );
            var_7d6f5393b3902fcc = arraycontains( arena.var_efd329dcea50284d, victim );
            var_67ebed6970dc872b = arraycontains( arena.var_a6d852dcb4a74527, attacker );
            var_fd14631197b7bf28 = arraycontains( arena.var_a6d852dcb4a74527, victim );
            
            if ( var_ce9f341055de2e7d && var_fd14631197b7bf28 || var_7d6f5393b3902fcc && var_67ebed6970dc872b )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace namespace_a974e4dd85555bc2
// Params 1
// Checksum 0x4d3bd7be, Offset: 0x285d
// Size: 0x21e
function function_450dd20dff271c0f( arena )
{
    player = self;
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    player freezecontrols( 1 );
    player freezelookcontrols( 1 );
    wait 1;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    wait 0.1;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    var_dc6cbc7b4e046acb = player.origin + ( 0, 0, 600 );
    var_aa95b976eea8fbe4 = player.origin + ( 0, 0, 72 );
    camera = spawn( "script_model", var_dc6cbc7b4e046acb );
    camera setmodel( "tag_origin" );
    camera.angles = ( 60, player.angles[ 1 ], 0 );
    player.var_4c255bf36f953253 = camera;
    player cameralinkto( camera, "tag_origin", 1, 1 );
    wait 2.5;
    camera rotateto( ( 20, player.angles[ 1 ], 0 ), 1.7, 0.5, 0.5 );
    wait 0.5;
    var_b77235c1a5ef9121 = undefined;
    
    if ( namespace_a8afdcd7738e364e::function_3d1f225aa0b4d926( "isGulagJailTimeoutVariation" ) )
    {
        var_b77235c1a5ef9121 = namespace_a8afdcd7738e364e::function_2af099d01df1a89c( "isGulagJailTimeoutVariation", arena );
    }
    
    if ( var_b77235c1a5ef9121 )
    {
        player thread hud_message::showsplash( "br_twotwo_one_v_one_gulag_match_intro" );
    }
    else
    {
        player thread hud_message::showsplash( "br_twotwo_gulag_match_intro" );
    }
    
    wait 2.2;
    
    if ( !( isdefined( camera ) && isdefined( player ) ) )
    {
        return;
    }
    
    camera moveto( var_aa95b976eea8fbe4, 1.3, 0.5, 0.5 );
    camera rotateto( player.angles, 0.8, 0.3, 0.3 );
    wait 1.5;
    
    if ( !( isdefined( camera ) && isdefined( player ) ) )
    {
        return;
    }
    
    player cameraunlink();
    player freezecontrols( 0 );
    player freezelookcontrols( 0 );
    wait 0.5;
    
    if ( !( isdefined( camera ) && isdefined( player ) ) )
    {
        return;
    }
    
    camera delete();
    player.var_4c255bf36f953253 = undefined;
}

// Namespace namespace_a974e4dd85555bc2
// Params 1
// Checksum 0x62023f84, Offset: 0x2a83
// Size: 0x23d
function function_d6c2a472902940a0( arena )
{
    player = self;
    level endon( #"game_ended" );
    level endon( #"gulag_break" );
    player endon( #"disconnect" );
    player thread function_9485d3b58fac8fe1( arena );
    player utility::waittill_notify_or_timeout( "gulag_player_ready_loadout", 2 );
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    xcam = "wz_gulag_player_acknowledge_l_xcam";
    animationname = "wz_gulag_player_acknowledge_l";
    
    if ( player.var_5159a4807b5d254f == 2 )
    {
        xcam = "wz_gulag_player_acknowledge_r_xcam";
        animationname = "wz_gulag_player_acknowledge_r";
    }
    
    primaryweaponobj = player getcurrentweapon();
    
    if ( isdefined( primaryweaponobj ) && primaryweaponobj.classname == "pistol" )
    {
        animationname += "_pistol";
    }
    
    player thread function_61271384688bce9d( "gulag_jailer_intro", arena );
    
    if ( level.var_56c3cc3dc37f1728.var_8af2e58b47aa35e4 )
    {
        player freezecontrols( 1 );
    }
    
    player dontinterpolate();
    wait 0.8;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( isdefined( player.var_c9936bbb7d91d9e ) )
    {
        player setorigin( player.var_c9936bbb7d91d9e );
        player.var_c9936bbb7d91d9e = undefined;
    }
    
    if ( isdefined( player.var_76b83eb6e332f534 ) )
    {
        player setplayerangles( player.var_76b83eb6e332f534 );
        player.var_76b83eb6e332f534 = undefined;
    }
    
    wait 0.2;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player br_spawnrespawn::function_24b79e9319c6f02f();
    player playxcam( xcam, 0, player.origin, player.angles );
    player playanimscriptsceneevent( "scripted_scene", animationname );
    xcamlength = getxcamlength( xcam );
    wait xcamlength - 0.75;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player br_spawnrespawn::function_1d2f70d591e967bc();
    wait 0.7;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( level.var_56c3cc3dc37f1728.var_8af2e58b47aa35e4 )
    {
        player freezecontrols( 0 );
    }
    
    if ( level.var_56c3cc3dc37f1728.var_efea3ef64b08393a )
    {
        player inventory_utility::function_c13571020bd38158( 0 );
        player thread inventory_utility::takegunlessweapon();
    }
    
    player br_spawnrespawn::function_24b79e9319c6f02f();
}

// Namespace namespace_a974e4dd85555bc2
// Params 1
// Checksum 0x5b1f7e79, Offset: 0x2cc8
// Size: 0xea
function function_758ca4f092f7ee12( arena )
{
    player = self;
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    wait 1;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player thread function_9485d3b58fac8fe1( arena );
    player utility::waittill_notify_or_timeout( "gulag_player_ready_loadout", 2 );
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    if ( isdefined( player.var_76b83eb6e332f534 ) )
    {
        player setplayerangles( player.var_76b83eb6e332f534 );
        player.var_76b83eb6e332f534 = undefined;
    }
    
    if ( isdefined( player.var_c9936bbb7d91d9e ) )
    {
        player setorigin( player.var_c9936bbb7d91d9e );
        player.var_c9936bbb7d91d9e = undefined;
    }
    
    player thread function_61271384688bce9d( "gulag_jailer_intro", arena );
    blackscreenup = player br_spawnrespawn::playeriscinematiclayeron();
    
    if ( blackscreenup )
    {
        player br_spawnrespawn::function_24b79e9319c6f02f();
    }
}

// Namespace namespace_a974e4dd85555bc2
// Params 1
// Checksum 0xd91bc61d, Offset: 0x2dba
// Size: 0x143
function function_9485d3b58fac8fe1( arena )
{
    player = self;
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    
    if ( player.gulagloadoutindex == 1 )
    {
        loadout = arena.var_ea4065d0d89fba8e;
    }
    else
    {
        loadout = arena.var_812d15ec6bae363c;
    }
    
    if ( level.var_56c3cc3dc37f1728.var_bb2129b99cb3e2 )
    {
        loadout = arena.var_ea4065d0d89fba8e;
    }
    
    if ( level.var_56c3cc3dc37f1728.forceloadoutindex >= 0 )
    {
        loadout = br_twotwo_gulag::function_f260414997e5fda6( level.var_56c3cc3dc37f1728.forceloadoutindex );
    }
    
    assert( isdefined( loadout ) );
    
    if ( !isdefined( loadout ) )
    {
        loadout = br_twotwo_gulag::function_f260414997e5fda6( level.var_56c3cc3dc37f1728.forceloadoutindex[ 0 ] );
    }
    
    var_1754831c895ea5e5 = loadout[ "loadoutPrimary" ];
    
    for ( primaryweaponobj = player getcurrentweapon(); primaryweaponobj.basename != var_1754831c895ea5e5 ; primaryweaponobj = player getcurrentweapon() )
    {
        wait 0.1;
        
        if ( !isdefined( player ) )
        {
            return;
        }
    }
    
    player notify( #"gulag_player_ready_loadout" );
}

// Namespace namespace_a974e4dd85555bc2
// Params 0
// Checksum 0xf0976edd, Offset: 0x2f05
// Size: 0x16, Type: bool
function function_5320bbf12a78971d()
{
    return istrue( level.var_56c3cc3dc37f1728.var_1b3298506268556 );
}

// Namespace namespace_a974e4dd85555bc2
// Params 0
// Checksum 0xc0ddd91a, Offset: 0x2f24
// Size: 0x26, Type: bool
function function_12030517f4bdcb8e()
{
    if ( namespace_a8afdcd7738e364e::function_373b8665fd6de550() && level.var_56c3cc3dc37f1728.var_6dfdf6fe1791a5aa )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_a974e4dd85555bc2
// Params 2
// Checksum 0x24fd03e, Offset: 0x2f53
// Size: 0x13b
function function_61271384688bce9d( dialog, arena )
{
    if ( !level.var_56c3cc3dc37f1728.var_e4e46cc4a1abab24 )
    {
        return;
    }
    
    player = self;
    
    if ( !( isdefined( player ) && isdefined( game[ "dialog" ][ dialog ] ) ) )
    {
        return;
    }
    
    soundname = tolower( "dx_br_brgj_" + game[ "dialog" ][ dialog ] );
    soundlocation = undefined;
    
    if ( isdefined( arena.audio_struct ) && level.var_56c3cc3dc37f1728.var_3243cbda03e751d )
    {
        soundlocation = arena.audio_struct.origin;
    }
    else
    {
        soundlocation = player.origin;
    }
    
    if ( soundexists( soundname ) )
    {
        if ( isent( arena.var_892eb236abb37a28 ) )
        {
            player playsoundtoplayer( soundname, player, arena.var_892eb236abb37a28 );
        }
        else
        {
            soundlength = lookupsoundlength( soundname, 1 ) / 1000;
            player queuedialogforplayer( #"queue1", soundname, dialog, soundlength, undefined, undefined, soundlocation, soundlength );
        }
        
        return;
    }
    
    script::demoforcesre( "missing VO " + soundname );
}

// Namespace namespace_a974e4dd85555bc2
// Params 0
// Checksum 0xad95d5fc, Offset: 0x3096
// Size: 0x9f
function function_86f9f7643fc8bc16()
{
    player = self;
    player.arenastarttime = gettime();
    player.gulagkills = 0;
    player.var_e47f2b0c6f184dcb = 0;
    arena = function_bc8c8f723d5d7be8( player );
    
    for ( i = 0; i < level.gulag.arenas.size ; i++ )
    {
        if ( arena == level.gulag.arenas[ i ] )
        {
            player.gulagarenaindex = i;
        }
    }
}

// Namespace namespace_a974e4dd85555bc2
// Params 1
// Checksum 0x5c5e368, Offset: 0x313d
// Size: 0x2be
function function_1a2c173510516f99( var_a615837bd2c5bc39 )
{
    player = self;
    
    if ( !isdefined( player ) )
    {
        return;
    }
    
    eventparams = [];
    eventparams[ eventparams.size ] = "waiting_duration";
    waitingduration = function_13ca9c4d0179ac3c();
    eventparams[ eventparams.size ] = waitingduration;
    eventparams[ eventparams.size ] = "gulag_duration";
    gulagduration = function_2ad5c45f25f08d17();
    eventparams[ eventparams.size ] = gulagduration;
    eventparams[ eventparams.size ] = "gulag_ai_kills";
    var_4aceeb2cdab267ba = function_5f3a79d4df6c62cf();
    eventparams[ eventparams.size ] = var_4aceeb2cdab267ba;
    eventparams[ eventparams.size ] = "gulag_pickups";
    var_20bac69d2ed0470 = function_6f90956531ff0ba6();
    eventparams[ eventparams.size ] = var_20bac69d2ed0470;
    eventparams[ eventparams.size ] = "gulag_cargo_hold";
    var_68b39e6485fccbaa = function_9891f246e375b957();
    eventparams[ eventparams.size ] = var_68b39e6485fccbaa;
    eventparams[ eventparams.size ] = "gulag_cargo_cable";
    var_cab90748da717ade = function_f8df68020042aa4();
    eventparams[ eventparams.size ] = var_cab90748da717ade;
    eventparams[ eventparams.size ] = "gulag_cargo_camera";
    var_5f621c0300e20e16 = function_76d2083bbe2ac758();
    eventparams[ eventparams.size ] = var_5f621c0300e20e16;
    eventparams[ eventparams.size ] = "gulag_cargo_vent";
    var_1e26c937ce55e2c6 = function_7d551b9d4d077170();
    eventparams[ eventparams.size ] = var_1e26c937ce55e2c6;
    eventparams[ eventparams.size ] = "gulag_cargo_bag";
    var_708998e5315476d9 = function_bfc51eac147490b7();
    eventparams[ eventparams.size ] = var_708998e5315476d9;
    eventparams[ eventparams.size ] = "gulag_end";
    
    if ( !isdefined( var_a615837bd2c5bc39 ) )
    {
        var_a615837bd2c5bc39 = "br_gulag_winner";
    }
    
    eventparams[ eventparams.size ] = var_a615837bd2c5bc39;
    eventparams[ eventparams.size ] = "gulag_people";
    var_674f22fb77ad60dc = function_e2309516a6d99777();
    eventparams[ eventparams.size ] = var_674f22fb77ad60dc;
    eventparams[ eventparams.size ] = "gulag_ai_num";
    var_11bd5a0eb2ff1451 = function_6d5ce86e6f9615e();
    eventparams[ eventparams.size ] = var_11bd5a0eb2ff1451;
    eventparams[ eventparams.size ] = "gulag_ai_accuracy";
    playeraccuracy = function_c556e54487f738b1();
    eventparams[ eventparams.size ] = playeraccuracy;
    eventparams[ eventparams.size ] = "gulag_ai_damage_taken";
    playerdamagetaken = function_c27cfd238a7effa8();
    eventparams[ eventparams.size ] = playerdamagetaken;
    eventparams[ eventparams.size ] = "gulag_ai_score";
    playerscore = function_d887eb79a4e92163( var_a615837bd2c5bc39 );
    eventparams[ eventparams.size ] = playerscore;
    eventparams[ eventparams.size ] = "gulag_ai_stars";
    playerstars = function_66bb88467822a8bd( var_a615837bd2c5bc39 );
    eventparams[ eventparams.size ] = playerstars;
    eventparams[ eventparams.size ] = "gulag_damage_to_ai";
    var_426458f4c5ecc1b5 = function_901ae1c871381ef7();
    eventparams[ eventparams.size ] = var_426458f4c5ecc1b5;
    eventparams[ eventparams.size ] = "gulag_pickup_key";
    var_ebda41e4cf4aa514 = function_266743ac60157fce();
    eventparams[ eventparams.size ] = var_ebda41e4cf4aa514;
    eventparams[ eventparams.size ] = "gulag_arena_index";
    var_7cb73b6fd401d8ac = function_2796a86dd8eb0f5e();
    eventparams[ eventparams.size ] = var_7cb73b6fd401d8ac;
    dlog_recordevent( "dlog_event_ai_gulag", eventparams );
}

// Namespace namespace_a974e4dd85555bc2
// Params 0
// Checksum 0x5b602319, Offset: 0x3403
// Size: 0x39
function function_13ca9c4d0179ac3c()
{
    player = self;
    
    if ( !isdefined( player.waitingduration ) )
    {
        return -1;
    }
    
    duration = player.waitingduration;
    return duration;
}

// Namespace namespace_a974e4dd85555bc2
// Params 0
// Checksum 0x5e091446, Offset: 0x3445
// Size: 0x3e
function function_2ad5c45f25f08d17()
{
    player = self;
    
    if ( !isdefined( player.arenastarttime ) )
    {
        return -1;
    }
    
    duration = gettime() - player.arenastarttime;
    return duration;
}

// Namespace namespace_a974e4dd85555bc2
// Params 0
// Checksum 0xe16814ae, Offset: 0x348c
// Size: 0x2d
function function_5f3a79d4df6c62cf()
{
    player = self;
    
    if ( !isdefined( player.gulagaikills ) )
    {
        return -1;
    }
    
    return player.gulagaikills;
}

// Namespace namespace_a974e4dd85555bc2
// Params 0
// Checksum 0x7f2a8864, Offset: 0x34c2
// Size: 0x2d
function function_6f90956531ff0ba6()
{
    player = self;
    
    if ( !isdefined( player.var_e47f2b0c6f184dcb ) )
    {
        return -1;
    }
    
    return player.var_e47f2b0c6f184dcb;
}

// Namespace namespace_a974e4dd85555bc2
// Params 0
// Checksum 0x278efb4b, Offset: 0x34f8
// Size: 0x2c
function function_9891f246e375b957()
{
    player = self;
    
    if ( !isdefined( player.var_a5f44cd24240ec39 ) )
    {
        return 0;
    }
    
    return player.var_a5f44cd24240ec39;
}

// Namespace namespace_a974e4dd85555bc2
// Params 0
// Checksum 0xb563275c, Offset: 0x352d
// Size: 0x2c
function function_f8df68020042aa4()
{
    player = self;
    
    if ( !isdefined( player.var_d5080517305b223e ) )
    {
        return 0;
    }
    
    return player.var_d5080517305b223e;
}

// Namespace namespace_a974e4dd85555bc2
// Params 0
// Checksum 0xf4d18c94, Offset: 0x3562
// Size: 0x2c
function function_76d2083bbe2ac758()
{
    player = self;
    
    if ( !isdefined( player.var_773ce8d494b9ddf6 ) )
    {
        return 0;
    }
    
    return player.var_773ce8d494b9ddf6;
}

// Namespace namespace_a974e4dd85555bc2
// Params 0
// Checksum 0x85e82e6b, Offset: 0x3597
// Size: 0x2c
function function_7d551b9d4d077170()
{
    player = self;
    
    if ( !isdefined( player.var_3b005191bff230a6 ) )
    {
        return 0;
    }
    
    return player.var_3b005191bff230a6;
}

// Namespace namespace_a974e4dd85555bc2
// Params 0
// Checksum 0x62965eb2, Offset: 0x35cc
// Size: 0x2c
function function_bfc51eac147490b7()
{
    player = self;
    
    if ( !isdefined( player.var_a90b6a04ba2bd139 ) )
    {
        return 0;
    }
    
    return player.var_a90b6a04ba2bd139;
}

// Namespace namespace_a974e4dd85555bc2
// Params 0
// Checksum 0xf3249d5a, Offset: 0x3601
// Size: 0x2c
function function_266743ac60157fce()
{
    player = self;
    
    if ( !isdefined( player.var_245c13045821ff74 ) )
    {
        return 0;
    }
    
    return player.var_245c13045821ff74;
}

// Namespace namespace_a974e4dd85555bc2
// Params 0
// Checksum 0xfe4e95e8, Offset: 0x3636
// Size: 0x2d
function function_2796a86dd8eb0f5e()
{
    player = self;
    
    if ( !isdefined( player.gulagarenaindex ) )
    {
        return -1;
    }
    
    return player.gulagarenaindex;
}

// Namespace namespace_a974e4dd85555bc2
// Params 0
// Checksum 0xbac1a3e1, Offset: 0x366c
// Size: 0x45
function function_e2309516a6d99777()
{
    player = self;
    arena = function_bc8c8f723d5d7be8( player );
    
    if ( !( isdefined( arena ) && isdefined( arena.var_856ffb24070a6fa8 ) ) )
    {
        return -1;
    }
    
    return arena.var_856ffb24070a6fa8;
}

// Namespace namespace_a974e4dd85555bc2
// Params 0
// Checksum 0x61d4f225, Offset: 0x36ba
// Size: 0x45
function function_6d5ce86e6f9615e()
{
    player = self;
    arena = function_bc8c8f723d5d7be8( player );
    
    if ( !( isdefined( arena ) && isdefined( arena.var_4bf13b3afd1652bc ) ) )
    {
        return -1;
    }
    
    return arena.var_4bf13b3afd1652bc;
}

// Namespace namespace_a974e4dd85555bc2
// Params 1
// Checksum 0x7557d945, Offset: 0x3708
// Size: 0x77
function function_c556e54487f738b1( var_a615837bd2c5bc39 )
{
    player = self;
    var_fba06cf0d0bcff1a = 0;
    
    if ( player.var_82aa9e2a587b9dd7 > 0 && isdefined( player.var_645eef13705c0695 ) && player.var_645eef13705c0695 > 0 )
    {
        var_fba06cf0d0bcff1a = int( player.var_82aa9e2a587b9dd7 / player.var_645eef13705c0695 * 100 );
    }
    
    return var_fba06cf0d0bcff1a;
}

// Namespace namespace_a974e4dd85555bc2
// Params 1
// Checksum 0xecaed6e0, Offset: 0x3788
// Size: 0x50
function function_d887eb79a4e92163( var_a615837bd2c5bc39 )
{
    player = self;
    
    if ( var_a615837bd2c5bc39 == "lost" )
    {
        return -1;
    }
    
    playerscore = 0;
    
    if ( isdefined( player.var_716f2b98a73614d0 ) )
    {
        playerscore = player.var_716f2b98a73614d0;
    }
    
    return playerscore;
}

// Namespace namespace_a974e4dd85555bc2
// Params 1
// Checksum 0x4640c22, Offset: 0x37e1
// Size: 0x50
function function_66bb88467822a8bd( var_a615837bd2c5bc39 )
{
    player = self;
    
    if ( var_a615837bd2c5bc39 == "lost" )
    {
        return -1;
    }
    
    playerstars = 0;
    
    if ( isdefined( player.starscorepoints ) )
    {
        playerstars = player.starscorepoints;
    }
    
    return playerstars;
}

// Namespace namespace_a974e4dd85555bc2
// Params 0
// Checksum 0x80596880, Offset: 0x383a
// Size: 0x2c
function function_901ae1c871381ef7()
{
    player = self;
    
    if ( !isdefined( player.var_78480a5a6128b940 ) )
    {
        return 0;
    }
    
    return player.var_78480a5a6128b940;
}

// Namespace namespace_a974e4dd85555bc2
// Params 1
// Checksum 0xc4b273a1, Offset: 0x386f
// Size: 0x43
function function_c27cfd238a7effa8( var_a615837bd2c5bc39 )
{
    player = self;
    playerdamagetaken = 0;
    
    if ( player.var_f4ced78321048739 > 0 )
    {
        playerdamagetaken = player.var_f4ced78321048739;
    }
    
    return playerdamagetaken;
}

// Namespace namespace_a974e4dd85555bc2
// Params 0
// Checksum 0x38a894e4, Offset: 0x38bb
// Size: 0x154
function function_c197be32faf2846d()
{
    player = self;
    player.arenastarttime = undefined;
    player.var_e47f2b0c6f184dcb = undefined;
    player.twotwoteam = undefined;
    player.gulagkills = undefined;
    player.gulagaikills = undefined;
    player.var_78480a5a6128b940 = undefined;
    player.var_245c13045821ff74 = undefined;
    player.var_82aa9e2a587b9dd7 = undefined;
    player.var_645eef13705c0695 = undefined;
    player.gulagarenaindex = undefined;
    player.var_49d21abc4829e837 = undefined;
    player.var_8174792fa5d2c5c6 = undefined;
    player.var_af961c15588d75f1 = undefined;
    player.var_8c2127ad940d0a2e = undefined;
    player.var_7f500be3e94a799c = undefined;
    player.var_4d30b739505bbabf = undefined;
    player.var_f4ced78321048739 = undefined;
    player.var_716f2b98a73614d0 = undefined;
    player.starscorepoints = undefined;
    player.var_30d27a6f168d83e1 = undefined;
    player.gulagendtime = undefined;
    player.gulagdoor = undefined;
    player.waitingduration = undefined;
    player.var_a5f44cd24240ec39 = undefined;
    player.var_d5080517305b223e = undefined;
    player.var_773ce8d494b9ddf6 = undefined;
    player.var_3b005191bff230a6 = undefined;
    player.var_a90b6a04ba2bd139 = undefined;
    player.var_52a4aad8e6eafc68 = "none";
}

// Namespace namespace_a974e4dd85555bc2
// Params 8
// Checksum 0xed4dfc48, Offset: 0x3a17
// Size: 0x1b8
function function_665623608268e376( label, value, point, relativepoint, xoffset, yoffset, color, istimer )
{
    player = self;
    fontscale = 1.5;
    fontelem = newclienthudelem( player );
    
    if ( istimer )
    {
        fontelem.elemtype = "timer";
    }
    else
    {
        fontelem.elemtype = "font";
    }
    
    fontelem.font = "default";
    fontelem.fontscale = fontscale;
    fontelem.basefontscale = fontscale;
    fontelem.x = 0;
    fontelem.y = 0;
    fontelem.width = 0;
    fontelem.height = int( level.fontheight * fontscale );
    fontelem.xoffset = 0;
    fontelem.yoffset = 0;
    fontelem.children = [];
    fontelem hud_util::setparent( level.uiparent );
    fontelem.hidden = 0;
    fontelem.archived = 0;
    fontelem.alpha = 1;
    fontelem hud_util::setpoint( point, relativepoint, xoffset, yoffset );
    
    if ( isdefined( label ) )
    {
        fontelem.label = label;
    }
    
    if ( isdefined( value ) )
    {
        fontelem setvalue( value );
    }
    
    if ( isdefined( color ) )
    {
        fontelem.color = color;
    }
    
    return fontelem;
}

