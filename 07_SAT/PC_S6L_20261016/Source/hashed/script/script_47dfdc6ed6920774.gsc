// script_47dfdc6ed6920774  (hash_47dfdc6ed6920774.gscc) (size: 7516 Bytes / 0x1d5c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x30f53907 (821377287)
// size ...... 7516 (0x1d5c)
// includes .. 7   (offset: 0x1ba4)
// strings ... 25  (offset: 0x1bdc)
// dev strs .. 0   (offset: 0x1d5c)
// exports ... 22  (offset: 0x120c)
// cseg ...... 0x1f1 + 0x101b (0x120c)
// imports ... 52  (offset: 0x157c)
// animtree1 . 0   (offset: 0x1d5c)
// animtree2 . 0   (offset: 0x1d5c)
#using script_6962ddc481c4af49;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_gulag;
#using scripts\mp\br\gametypes\br_twotwo_gulag;
#using scripts\mp\common\utility\perk;
#using scripts\mp\objidpoolmanager;

#namespace namespace_e3920327cb54c3db;

// Namespace namespace_e3920327cb54c3db
// Params 0
// Checksum 0xe405a3f5, Offset: 0x20f
// Size: 0xdc
function function_47f365ba09943ac5()
{
    if ( getdvarint( @"hash_77e2efb75e6cc8ca", 0 ) )
    {
        return;
    }
    
    level.gulag.overtimeascender = getdvarint( @"scr_br_fc_overtime_ascender", 1 );
    br::function_44274c8d804a57fd( &function_54ed78cc17357cf7 );
    br::function_c4ab1bb15d73f6e( &function_d69bd0745a606a64 );
    br_gulag::function_9d1513fbb2a21c4f( "setupArena", &function_35ec7dfedf80f333 );
    
    if ( level.gulag.overtimeascender )
    {
        br_gulag::function_9d1513fbb2a21c4f( "beginNewFight", &function_7702bb79c11c53a4 );
        br_gulag::function_9d1513fbb2a21c4f( "handleEndArena", &function_5c995ec822643cf5 );
        br_gulag::function_9d1513fbb2a21c4f( "respawnCleanup", &function_7d8f74486b574fb7 );
        br_gulag::function_9d1513fbb2a21c4f( "gulagWaittillOvertime", &function_ff2dbf303acbb71a );
        br_gulag::function_c8f7b364fdc4f2d2( "overtimeStart", &function_952d1b07de47c66c );
        br_gulag::function_c8f7b364fdc4f2d2( "overtimeWait", &function_5b296b4a69eaafb1 );
    }
}

// Namespace namespace_e3920327cb54c3db
// Params 1
// Checksum 0x6be924c, Offset: 0x2f3
// Size: 0x28, Type: bool
function function_f8b8053c0f685cb0( arena )
{
    return isdefined( arena.ascenders ) && arena.ascenders.size;
}

// Namespace namespace_e3920327cb54c3db
// Params 1
// Checksum 0x2d4c8ec4, Offset: 0x324
// Size: 0x107
function function_35ec7dfedf80f333( arena )
{
    arena.ascenders = [];
    scriptable_targets = getentitylessscriptablearray( arena.target, #targetname );
    
    foreach ( scriptable_target in scriptable_targets )
    {
        switch ( scriptable_target.script_noteworthy )
        {
            case #"hash_32d233f7333dcec":
                scriptable_target.arena = arena;
                arena.ascenders[ arena.ascenders.size ] = scriptable_target;
                function_ba0f6da3b2ecc5d6( scriptable_target );
                break;
            default:
                break;
        }
    }
}

// Namespace namespace_e3920327cb54c3db
// Params 1
// Checksum 0x5884659a, Offset: 0x433
// Size: 0x142
function function_ba0f6da3b2ecc5d6( instance )
{
    instance.gulagascender = 1;
    targets = getentarray( instance.target, #targetname );
    
    foreach ( target in targets )
    {
        switch ( target.script_noteworthy )
        {
            case #"hash_4d993e901822ff8d":
                assert( !isdefined( instance.rope ) );
                rope = spawnscriptable( "jup_overtime_rope", target.origin );
                target hide();
                instance.rope = rope;
                function_8c4de7c0d5fbf03d( target, rope );
                break;
            default:
                break;
        }
    }
    
    instance.gulagstate = "down";
    thread function_8adf9421b35c7975( instance );
}

// Namespace namespace_e3920327cb54c3db
// Params 2
// Checksum 0x2fceb7fd, Offset: 0x57d
// Size: 0x171
function function_8c4de7c0d5fbf03d( staticrope, rope )
{
    rope.down_origin = rope.origin;
    targets = staticrope utility::getstructarray( staticrope.target, "targetname" );
    
    foreach ( target in targets )
    {
        switch ( target.script_noteworthy )
        {
            case #"hash_f0c78255b6b37d51":
                rope.up_origin = target.origin;
                break;
            default:
                break;
        }
    }
    
    upvec = ( 0, 0, rope.up_origin[ 2 ] - rope.down_origin[ 2 ] );
    rope.origin += upvec;
    rope.angles = vectortoangles( upvec ) + ( 0, 0, 90 );
    rope.upvec = upvec;
}

// Namespace namespace_e3920327cb54c3db
// Params 1
// Checksum 0x9990404f, Offset: 0x6f6
// Size: 0x7b
function function_8adf9421b35c7975( instance )
{
    if ( instance.gulagstate == "up" || instance.gulagstate == "raising" )
    {
        return;
    }
    
    function_6c444ed7000a8a7a( instance );
    instance.gulagstate = "raising";
    instance.rope setscriptablepartstate( "rope", "up" );
    instance.gulagstate = "up";
}

// Namespace namespace_e3920327cb54c3db
// Params 2
// Checksum 0x643740a6, Offset: 0x779
// Size: 0x97
function function_951f199b74754198( arena, instance )
{
    arena endon( #"matchended" );
    
    if ( instance.gulagstate == "down" || instance.gulagstate == "lowering" )
    {
        return;
    }
    
    instance.gulagstate = "lowering";
    instance.rope setscriptablepartstate( "rope", "down" );
    wait 1;
    function_790f76a47f82ee8b( instance );
    instance.gulagstate = "down";
}

// Namespace namespace_e3920327cb54c3db
// Params 1
// Checksum 0x651a7b76, Offset: 0x818
// Size: 0x147
function function_790f76a47f82ee8b( instance )
{
    instance.objidnum = objidpoolmanager::requestobjectiveid();
    
    if ( instance.objidnum == -1 )
    {
        return;
    }
    
    objidpoolmanager::objective_add_objective( instance.objidnum, "current", instance.rope.origin, "ui_map_icon_obj_ascender_rope" );
    objidpoolmanager::update_objective_setbackground( instance.objidnum, 1 );
    objidpoolmanager::update_objective_setzoffset( instance.objidnum, instance.rope.upvec[ 2 ] * -1 + 100 );
    objidpoolmanager::function_eb808b97701a4793( instance.objidnum );
    
    foreach ( player in instance.arena.arenaplayers )
    {
        objidpoolmanager::objective_playermask_addshowplayer( instance.objidnum, player );
    }
}

// Namespace namespace_e3920327cb54c3db
// Params 1
// Checksum 0x81fc5a76, Offset: 0x967
// Size: 0x2c
function function_6c444ed7000a8a7a( instance )
{
    objidpoolmanager::returnobjectiveid( instance.objidnum );
    instance.objidnum = -1;
}

// Namespace namespace_e3920327cb54c3db
// Params 6
// Checksum 0x20f0307b, Offset: 0x99b
// Size: 0x95
function function_54ed78cc17357cf7( instance, player, edgeindex, isvertical, isinverted, isgoingup )
{
    if ( instance.gulagascender && instance.gulagstate != "down" )
    {
        s = spawnstruct();
        s.type = "HINT_NOBUTTON";
        s.string = &"";
        return s;
    }
}

// Namespace namespace_e3920327cb54c3db
// Params 4
// Checksum 0xb76218d2, Offset: 0xa39
// Size: 0x4c
function function_d69bd0745a606a64( instance, player, edgeindex, isinverted )
{
    if ( instance.gulagascender && instance.gulagstate != "down" )
    {
        return 0;
    }
}

// Namespace namespace_e3920327cb54c3db
// Params 1
// Checksum 0xfd26d9df, Offset: 0xa8e
// Size: 0x99
function function_7702bb79c11c53a4( arena )
{
    foreach ( ascender in arena.ascenders )
    {
        level thread function_8adf9421b35c7975( ascender );
        ascender setscriptablepartstate( "top", "use" );
    }
}

// Namespace namespace_e3920327cb54c3db
// Params 1
// Checksum 0x3b718b35, Offset: 0xb2f
// Size: 0x163
function function_5c995ec822643cf5( arena )
{
    foreach ( ascender in arena.ascenders )
    {
        ascender setscriptablepartstate( "top", "off" );
        
        if ( ascender.gulagstate != "up" )
        {
            ascender.rope setscriptablepartstate( "rope", "end" );
        }
        
        function_6c444ed7000a8a7a( ascender );
    }
    
    foreach ( player in arena.arenaplayers )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( isdefined( player.perks[ "specialty_ascender_scale" ] ) )
        {
            player perk::removeperk( "specialty_ascender_scale" );
        }
    }
}

// Namespace namespace_e3920327cb54c3db
// Params 1
// Checksum 0x41a0a8ae, Offset: 0xc9a
// Size: 0x2f
function function_7d8f74486b574fb7( player )
{
    if ( isdefined( player.perks[ "specialty_ascender_scale" ] ) )
    {
        player perk::removeperk( "specialty_ascender_scale" );
    }
}

// Namespace namespace_e3920327cb54c3db
// Params 2
// Checksum 0x17c774c1, Offset: 0xcd1
// Size: 0xda
function function_ff2dbf303acbb71a( arena, overtimelength )
{
    if ( !function_f8b8053c0f685cb0( arena ) || arena.ascenderdisabled )
    {
        return;
    }
    
    foreach ( ascender in arena.ascenders )
    {
        if ( ascender.gulagstate == "up" && arena.time <= overtimelength + 1 )
        {
            level thread function_951f199b74754198( arena, ascender );
        }
    }
}

// Namespace namespace_e3920327cb54c3db
// Params 1
// Checksum 0x89f984e5, Offset: 0xdb3
// Size: 0xbe, Type: bool
function function_952d1b07de47c66c( arena )
{
    if ( !function_f8b8053c0f685cb0( arena ) || arena.ascenderdisabled )
    {
        return false;
    }
    
    foreach ( player in arena.arenaplayers )
    {
        player perk::giveperk( "specialty_ascender_scale" );
        thread function_8e60e891027dcdd4( arena, player );
    }
    
    thread function_e9a48c687862a353( arena );
    return true;
}

// Namespace namespace_e3920327cb54c3db
// Params 1
// Checksum 0x3ff10839, Offset: 0xe7a
// Size: 0xbc
function function_e9a48c687862a353( arena )
{
    arena endon( #"matchended" );
    
    while ( true )
    {
        if ( function_2a8f38e613b32df6( arena ) )
        {
            break;
        }
        
        waitframe();
    }
    
    foreach ( ascender in arena.ascenders )
    {
        ascender.rope setscriptablepartstate( "rope", "idle" );
    }
}

// Namespace namespace_e3920327cb54c3db
// Params 1
// Checksum 0xcb55ed36, Offset: 0xf3e
// Size: 0x57, Type: bool
function function_5b296b4a69eaafb1( arena )
{
    if ( !function_f8b8053c0f685cb0( arena ) || arena.ascenderdisabled )
    {
        return false;
    }
    
    while ( true )
    {
        if ( function_2a8f38e613b32df6( arena ) )
        {
            waitframe();
            continue;
        }
        
        if ( arena.fightover )
        {
            waitframe();
            continue;
        }
        
        break;
    }
    
    return true;
}

// Namespace namespace_e3920327cb54c3db
// Params 1
// Checksum 0xfdfa0c94, Offset: 0xf9e
// Size: 0x8b, Type: bool
function function_2a8f38e613b32df6( arena )
{
    foreach ( player in arena.arenaplayers )
    {
        if ( player isonascender() )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace namespace_e3920327cb54c3db
// Params 2
// Checksum 0x37748733, Offset: 0x1032
// Size: 0x57
function function_8e60e891027dcdd4( arena, player )
{
    arena endon( #"matchended" );
    
    while ( true )
    {
        player waittill( #"ascender_detached", jumpdetach );
        
        if ( !jumpdetach )
        {
            break;
        }
    }
    
    thread ascenderwinner( arena, player );
}

// Namespace namespace_e3920327cb54c3db
// Params 2
// Checksum 0x4688dc84, Offset: 0x1091
// Size: 0x17b
function ascenderwinner( arena, winner )
{
    foreach ( player in arena.arenaplayers )
    {
        if ( isalive( player ) && player != winner )
        {
            if ( namespace_a8afdcd7738e364e::function_373b8665fd6de550() )
            {
                player thread br_gulag::gulagplayerlost( arena, "br_twotwo_gulag_lost_flag", 1 );
                continue;
            }
            
            player thread br_gulag::gulagplayerlost( arena );
        }
    }
    
    foreach ( ascender in arena.ascenders )
    {
        ascender setscriptablepartstate( "top", "off" );
    }
    
    arena notify( #"matchended" );
    
    if ( namespace_a8afdcd7738e364e::function_373b8665fd6de550() )
    {
        winner br_twotwo_gulag::gulagtwotwo_victorysequence( arena, "br_twotwo_gulag_win_flag" );
    }
    
    br_gulag::handleendarena( arena );
    arena notify( #"hash_6c9030906c04e6a4" );
}

