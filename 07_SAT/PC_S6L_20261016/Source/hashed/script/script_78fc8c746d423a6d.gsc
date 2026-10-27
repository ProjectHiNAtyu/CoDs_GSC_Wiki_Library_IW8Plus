// script_78fc8c746d423a6d  (hash_78fc8c746d423a6d.gscc) (size: 12143 Bytes / 0x2f6f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa6cfb32f (2798629679)
// size ...... 12143 (0x2f6f)
// includes .. 15  (offset: 0x2d1b)
// strings ... 32  (offset: 0x2d93)
// dev strs .. 3   (offset: 0x2f4b)
// exports ... 32  (offset: 0x1c93)
// cseg ...... 0x20d + 0x1a86 (0x1c93)
// imports ... 97  (offset: 0x2193)
// animtree1 . 0   (offset: 0x2f6f)
// animtree2 . 0   (offset: 0x2f6f)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\br\gametypes\br_gametype_dmz;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\loot;
#using scripts\mp\common\utility\teams;
#using scripts\mp\loot\common_item;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;
#using scripts\mp\poi;

#namespace dmz_weapon_case;

// Namespace dmz_weapon_case
// Params 0, eflags: 0x5
// Checksum 0x3d5a8017, Offset: 0x22b
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"item_weapon_case", #"common_item_database", undefined, &init );
}

// Namespace dmz_weapon_case
// Params 0, eflags: 0x4
// Checksum 0x277bca8c, Offset: 0x254
// Size: 0x14c
function private init()
{
    wcenabled = getmatchrulesdata( "commonOption", "wcEnabled" );
    
    if ( !wcenabled )
    {
        return;
    }
    
    wcdata = getmatchrulesdata( "commonOption", "wcData" );
    
    if ( !isdefined( wcdata ) || wcdata == "" )
    {
        return;
    }
    
    wcbundlename = hashcat( %"hash_31706c654b9d3b54", wcdata );
    weaponcasedata = getscriptbundle( wcbundlename );
    
    if ( !isdefined( weaponcasedata ) )
    {
        return;
    }
    
    level.weaponcasedata = weaponcasedata;
    common_item::function_4b30c091d3b04a25( "weapon_case" );
    common_item::function_84174b793b5fe9a7( "weapon_case", #"use", &use_weapon_case );
    common_item::function_84174b793b5fe9a7( "weapon_case", #"hash_2cc40f197e06aed7", &function_2d458a2363557a6c );
    common_item::function_84174b793b5fe9a7( "weapon_case", #"hash_e2da6c78fc49f200", &function_aaacc5f72c43e443 );
    callback::add( #"hash_c15c682d6a5dcae0", &onplayerentergulag );
    callback::add( #"hash_438552ad6e5b08a0", &function_c94b44f4b59ca287 );
    callback::add( #"hash_43fa020e1f5bd32e", &function_36ff74238715beee );
    utility::registersharedfunc( level.weaponcasedata.scriptablename, #"delete", &function_54a27e1f66c40f78 );
}

// Namespace dmz_weapon_case
// Params 4, eflags: 0x4
// Checksum 0xeb8b6575, Offset: 0x3a8
// Size: 0x3c
function private use_weapon_case( itembundle, item, autouse, var_981c264073bf1154 )
{
    function_bf253c2fc1f9391b( item, self );
    return item.count;
}

// Namespace dmz_weapon_case
// Params 4, eflags: 0x4
// Checksum 0x86aae5f1, Offset: 0x3ed
// Size: 0x10b
function private function_2d458a2363557a6c( scriptable, count, positioningdata, spawnoptions )
{
    weaponcase = spawnscriptable( scriptable, positioningdata.finalorigin, positioningdata.finalangles, undefined, positioningdata.payload, spawnoptions.payload );
    
    if ( !isdefined( level.weaponcaseinfo ) )
    {
        level.weaponcaseinfo = { #scriptable:weaponcase };
        weaponcase.criticalitem = 1;
        
        if ( level.weaponcasedata.var_fc67963f0f36efd8 )
        {
            function_861c2821c1eedae0( weaponcase.origin );
        }
        else
        {
            level.weaponcaseinfo.objidnum = -1;
        }
        
        function_442d479723b5162b( weaponcase.origin );
    }
    
    function_2e24e07e0783c84d( weaponcase, spawnoptions.spawningentity, positioningdata.finalorigin );
    return weaponcase;
}

// Namespace dmz_weapon_case
// Params 5, eflags: 0x44 variadic
// Checksum 0x8fdc054f, Offset: 0x501
// Size: 0x47
function private function_aaacc5f72c43e443( player, itembundle, item, ... )
{
    function_bf253c2fc1f9391b( item, player, 1 );
    return item.count;
}

// Namespace dmz_weapon_case
// Params 0
// Checksum 0x3ceba3c5, Offset: 0x551
// Size: 0xbf
function function_e1e53cf44ecd226()
{
    var_7237854e3be197ca = level.var_e1e53cf44ecd226;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    if ( game_utility::getgametype() != "dmz" )
    {
        level.var_e1e53cf44ecd226 = "no_one";
        return level.var_e1e53cf44ecd226;
    }
    
    if ( game_utility::function_87c1e942653b7c63() || level.mapname == "mp_br_mechanics" )
    {
        trainchance = getdvarint( @"hash_5c2cb9fc4042e027", 40 );
        
        if ( trainchance > 0 && randomint( 100 ) < trainchance )
        {
            level.var_e1e53cf44ecd226 = "train";
            return level.var_e1e53cf44ecd226;
        }
    }
    
    level.var_e1e53cf44ecd226 = "boss";
    return level.var_e1e53cf44ecd226;
}

// Namespace dmz_weapon_case
// Params 0, eflags: 0x4
// Checksum 0x2912b232, Offset: 0x619
// Size: 0x141, Type: bool
function private function_54a27e1f66c40f78()
{
    if ( isdefined( self.linkedparent ) && self.linkedparent vehicle::is_vehicle() && self.linkedparent vehicle::get_ref() == %"hash_1dd941f8f4026e3" )
    {
        return false;
    }
    
    contents = trace::create_itemclip_contents();
    trace = trace::ray_trace( self.origin, self.origin - ( 0, 0, 10000 ), undefined, contents );
    
    if ( !( isdefined( trace[ "position" ] ) && isdefined( trace[ "fraction" ] ) ) || trace[ "fraction" ] >= 0.99 || outofbounds::ispointinoutofbounds( trace[ "position" ] ) )
    {
        onnavmesh = getclosestpointonnavmesh( self.origin );
        trace = trace::ray_trace( onnavmesh, onnavmesh - ( 0, 0, 1000 ), undefined, contents );
    }
    
    if ( !( isdefined( trace[ "position" ] ) && isdefined( trace[ "normal" ] ) && isdefined( trace[ "fraction" ] ) ) || trace[ "fraction" ] >= 0.99 )
    {
        return false;
    }
    
    utility::scriptable_clearparententity();
    self.origin = trace[ "position" ];
    return true;
}

// Namespace dmz_weapon_case
// Params 3, eflags: 0x4
// Checksum 0xccf5b4eb, Offset: 0x763
// Size: 0x1f4
function private function_2e24e07e0783c84d( scriptable, owner, finalorigin )
{
    if ( !isdefined( level.weaponcaseinfo ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    if ( level.weaponcaseinfo.currentowner )
    {
        level.weaponcaseinfo.currentowner utility::callsharedfunc( #"mission_manager", #"hash_519b4132a9591b27" );
    }
    
    level.weaponcaseinfo.currentowner = undefined;
    level.weaponcaseinfo.scriptable = scriptable;
    scriptable.criticalitem = 1;
    
    if ( level.weaponcasedata.var_fc67963f0f36efd8 && level.weaponcaseinfo.objidnum != -1 )
    {
        level notify( #"hash_620582a5ac25efa9" );
        objective_setplayintro( level.weaponcaseinfo.objidnum, 0 );
        objective_disableping( level.weaponcaseinfo.objidnum, istrue( level.weaponcasedata.disablepingalways ) );
        objidpoolmanager::objective_playermask_showtoall( level.weaponcaseinfo.objidnum );
    }
    
    if ( isplayer( owner ) )
    {
        splash = level.weaponcasedata.var_c7aefb7593173b5c;
        
        if ( splash )
        {
            teammates = arrayremove( level.teamdata[ owner.team ][ "players" ], owner );
            br_gametype_dmz::showdmzsplash( splash, teammates, undefined, undefined, owner );
        }
        
        splash = level.weaponcasedata.var_7db15f95f43f261d;
        
        if ( splash )
        {
            br_gametype_dmz::showdmzsplash( splash, [ owner ] );
        }
        
        function_fc282487f8790106( owner, owner.health <= 0 );
    }
}

// Namespace dmz_weapon_case
// Params 1, eflags: 0x4
// Checksum 0x2856fdea, Offset: 0x95f
// Size: 0x20c
function private function_36ff74238715beee( params )
{
    if ( !isdefined( params.lootid ) || params.lootid == 0 )
    {
        return;
    }
    
    if ( !isdefined( params.quantity ) || params.quantity == 0 )
    {
        return;
    }
    
    if ( common_item::function_9deb822f286163b1( params.lootid ) != "weapon_case" )
    {
        return;
    }
    
    if ( !isdefined( level.weaponcaseinfo ) )
    {
        level.weaponcaseinfo = { #scriptable:params.cache };
        
        if ( level.weaponcasedata.var_fc67963f0f36efd8 )
        {
            function_861c2821c1eedae0( params.cache.origin );
        }
        else
        {
            level.weaponcaseinfo.objidnum = -1;
        }
        
        function_442d479723b5162b( params.cache.origin );
    }
    
    if ( level.weaponcaseinfo.currentowner )
    {
        level.weaponcaseinfo.currentowner utility::callsharedfunc( #"mission_manager", #"hash_519b4132a9591b27" );
    }
    
    level.weaponcaseinfo.currentowner = undefined;
    level.weaponcaseinfo.scriptable = params.cache;
    
    if ( level.weaponcaseinfo.objidnum != -1 )
    {
        level notify( #"hash_620582a5ac25efa9" );
        objective_setplayintro( level.weaponcaseinfo.objidnum, 0 );
        objective_disableping( level.weaponcaseinfo.objidnum, level.weaponcasedata.var_28d5a6cfe2d3b01c || level.weaponcasedata.disablepingalways );
        objidpoolmanager::objective_playermask_showtoall( level.weaponcaseinfo.objidnum );
    }
}

// Namespace dmz_weapon_case
// Params 3, eflags: 0x4
// Checksum 0xfd1752d9, Offset: 0xb73
// Size: 0x4d5
function private function_bf253c2fc1f9391b( scriptable, player, frombackpack = 0 )
{
    /#
        if ( getdvarint( @"hash_66bc111ba4ab2224", 0 ) == 1 )
        {
            foreach ( testplayer in arrayrandomize( level.players ) )
            {
                if ( isbot( testplayer ) )
                {
                    player = testplayer;
                    break;
                }
            }
        }
    #/
    
    objid = level.weaponcaseinfo.objidnum;
    showingsplash = 0;
    
    if ( !isdefined( level.weaponcaseinfo.lastteam ) || isdefined( player.team ) && player.team != level.weaponcaseinfo.lastteam )
    {
        if ( objid != -1 )
        {
            objective_setownerteam( objid, player.team );
            objective_setprogressteam( objid, player.team );
            objective_setpulsate( objid, 1 );
        }
        
        if ( level.weaponcasedata.var_afd3209116f7c306 )
        {
            showingsplash = 1;
            defaultsplash = level.weaponcasedata.pickedupsplash;
            
            if ( isdefined( level.var_58b40dfb9a19948c ) )
            {
                defaultsplash = [[ level.var_58b40dfb9a19948c ]]();
            }
            
            splash = level.weaponcaseinfo.pickedupbefore ? level.weaponcasedata.transfersplash : defaultsplash;
            level.weaponcaseinfo.pickedupbefore = 1;
            
            if ( splash )
            {
                players = level.players;
                
                if ( level.weaponcasedata.var_6e09bd1c0794e506 )
                {
                    players = arrayremove( level.players, player );
                }
                
                br_gametype_dmz::showdmzsplash( splash, players, poi::poi_findpoioriginisin( player.origin, undefined, undefined, 1 ) );
            }
            
            level thread function_c3590bd28a55e055( player );
        }
        
        utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"weapon_case_pickup_self", player.team );
        
        if ( level.mapname != "mp_bio_lab" )
        {
            utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"weapon_case_pickup_enemy", arrayremove( level.players, teams::getteamdata( player.team, "players" ) ) );
        }
    }
    
    if ( objid != -1 )
    {
        if ( level.weaponcasedata.var_28d5a6cfe2d3b01c || level.weaponcasedata.disablepingalways )
        {
            objective_disableping( objid, level.weaponcasedata.var_28d5a6cfe2d3b01c || level.weaponcasedata.disablepingalways );
            calloutmarkerping::function_73084f64fa34a5a8( objid );
        }
    }
    
    if ( level.weaponcasedata.var_afd3209116f7c306 )
    {
        splash = level.weaponcasedata.var_70d22bb73c2d03cd;
        
        if ( splash )
        {
            teammates = arrayremove( teams::getteamdata( player.team, "players" ), player );
            br_gametype_dmz::showdmzsplash( splash, teammates, undefined, undefined, player );
        }
        
        splash = level.weaponcasedata.var_6e09bd1c0794e506;
        
        if ( splash )
        {
            br_gametype_dmz::showdmzsplash( splash, [ player ] );
        }
    }
    
    if ( objid != -1 && !showingsplash )
    {
        objidpoolmanager::objective_playermask_showtoall( objid );
    }
    
    if ( level.weaponcaseinfo.lastteam != player.team )
    {
        level thread br_public::brleaderdialogteam( "weaponcase_myTeam_found", player.team, 1, 2, undefined );
    }
    
    level.weaponcaseinfo.currentowner = player;
    level.weaponcaseinfo.lastteam = player.team;
    level.weaponcaseinfo.scriptable = undefined;
    
    if ( !frombackpack )
    {
        player utility::callsharedfunc( #"exfil", #"hash_97a39adf2bfd5d8c" );
        player utility::callsharedfunc( #"mission_manager", #"hash_9d613b7948baa5de" );
    }
    
    function_5eb4077427916e2f( player );
}

// Namespace dmz_weapon_case
// Params 1, eflags: 0x4
// Checksum 0x9e58b980, Offset: 0x1050
// Size: 0x5f
function private onplayerentergulag( options )
{
    if ( !isdefined( level.weaponcaseinfo ) )
    {
        return;
    }
    
    objid = level.weaponcaseinfo.objidnum;
    
    if ( !isdefined( objid ) || objid == -1 )
    {
        return;
    }
    
    objidpoolmanager::objective_playermask_hidefrom( objid, options.player );
}

// Namespace dmz_weapon_case
// Params 1, eflags: 0x4
// Checksum 0x2984e2b7, Offset: 0x10b7
// Size: 0x5f
function private function_c94b44f4b59ca287( options )
{
    if ( !isdefined( level.weaponcaseinfo ) )
    {
        return;
    }
    
    objid = level.weaponcaseinfo.objidnum;
    
    if ( !isdefined( objid ) || objid == -1 )
    {
        return;
    }
    
    objidpoolmanager::objective_playermask_addshowplayer( objid, options.player );
}

// Namespace dmz_weapon_case
// Params 1
// Checksum 0x2c24ce66, Offset: 0x111e
// Size: 0x4f, Type: bool
function isweaponcase( lootid )
{
    if ( !isdefined( level.weaponcasedata.scriptablename ) )
    {
        return false;
    }
    
    wclootid = loot::function_d3e3bcaea591a6a2( level.weaponcasedata.scriptablename );
    return lootid == wclootid;
}

// Namespace dmz_weapon_case
// Params 1, eflags: 0x4
// Checksum 0x638b8bee, Offset: 0x1176
// Size: 0xa5
function private function_c3590bd28a55e055( var_5b2075a06ef16da1 )
{
    objid = level.weaponcaseinfo.objidnum;
    
    if ( level.weaponcasedata.var_fc67963f0f36efd8 && objid != -1 )
    {
        objective_setplayintro( level.weaponcaseinfo.objidnum, 0 );
        level notify( #"hash_620582a5ac25efa9" );
        level endon( #"hash_620582a5ac25efa9" );
        objidpoolmanager::objective_playermask_hidefromall( objid );
        wait 3.8;
        objective_setplayintro( objid, 1 );
        objidpoolmanager::objective_playermask_showtoall( objid );
        waitframe();
        objective_setplayintro( objid, 0 );
    }
}

// Namespace dmz_weapon_case
// Params 1
// Checksum 0x2193ef24, Offset: 0x1223
// Size: 0xaf
function function_487c6d8d32e756da( player )
{
    if ( hasweaponcase( player ) )
    {
        objidpoolmanager::returnobjectiveid( level.weaponcaseinfo.objidnum );
        utility::callsharedfunc( #"overlord", #"hash_399ec4a29126e3f5", #"weapon_case_extract_self", player.team );
        utility::callsharedfunc( #"overlord", #"hash_82f680233629c231", #"weapon_case_extract_enemy", arrayremove( level.players, teams::getteamdata( player.team, "players" ) ) );
        level notify( #"weaponcase_extracted" );
    }
}

// Namespace dmz_weapon_case
// Params 1
// Checksum 0x92c7fa03, Offset: 0x12da
// Size: 0x2f, Type: bool
function didextractwithweaponcase( player )
{
    return isdefined( level.var_5dc1d3cb32947991 ) && level.var_5dc1d3cb32947991[ player.guid ];
}

// Namespace dmz_weapon_case
// Params 1
// Checksum 0xa33bdff4, Offset: 0x1312
// Size: 0x139
function function_7a94d3bdaf4c4656( players )
{
    if ( !isdefined( level.weaponcaseinfo ) )
    {
        return;
    }
    
    if ( !isdefined( level.var_5dc1d3cb32947991 ) )
    {
        level.var_5dc1d3cb32947991 = [];
    }
    
    owner = level.weaponcaseinfo.currentowner;
    
    if ( isdefined( owner ) && arraycontains( players, owner ) )
    {
        foreach ( teammember in players )
        {
            if ( !isdefined( teammember ) )
            {
                continue;
            }
            
            if ( teammember.team != owner.team )
            {
                continue;
            }
            
            level.var_5dc1d3cb32947991[ teammember.guid ] = 1;
        }
        
        var_fcd0963e63aba3c1 = arrayremove( level.players, players );
        br_gametype_dmz::showdmzsplash( "dmz_lootbox_extracted_generic", var_fcd0963e63aba3c1, owner.closestpoi );
    }
}

// Namespace dmz_weapon_case
// Params 1
// Checksum 0x714909fc, Offset: 0x1453
// Size: 0xb6
function function_90286fea6c965c26( player )
{
    if ( !isdefined( level.var_5dc1d3cb32947991 ) )
    {
        level.var_5dc1d3cb32947991 = [];
    }
    
    var_6124d2db07475748 = level.var_5dc1d3cb32947991[ player.guid ];
    var_53db67c94dfe6ca3 = isdefined( function_cf850474d4bf8706( player ) ) ? 1 : 0;
    
    if ( !isdefined( var_6124d2db07475748 ) )
    {
        return 0;
    }
    
    assert( var_6124d2db07475748 >= var_53db67c94dfe6ca3, "<dev string:x60>" );
    
    if ( isdefined( level.var_5dc1d3cb32947991[ player.guid ] ) )
    {
        return ( ( var_6124d2db07475748 - var_53db67c94dfe6ca3 ) * level.br_pickups.br_value[ level.var_eea2d65da08adce2 ] );
    }
    
    return 0;
}

// Namespace dmz_weapon_case
// Params 1
// Checksum 0x25f3437f, Offset: 0x1512
// Size: 0x13b
function function_d75239ecfae46313( player )
{
    if ( !isdefined( level.var_5dc1d3cb32947991 ) )
    {
        level.var_5dc1d3cb32947991 = [];
    }
    
    var_6124d2db07475748 = level.var_5dc1d3cb32947991[ player.guid ];
    
    if ( !isdefined( var_6124d2db07475748 ) || var_6124d2db07475748 == 0 )
    {
        return [];
    }
    
    if ( !( isdefined( level.br_pickups ) && isdefined( level.br_pickups.br_weapontoscriptable ) ) )
    {
        assertmsg( "<dev string:xa8>" );
        return [];
    }
    
    if ( !isdefined( level.var_9997cc98df6aff3 ) )
    {
        array = arraycopy( level.br_pickups.br_weapontoscriptable );
        function_cdc669dbc8ea2101( array );
        level.var_9997cc98df6aff3 = arrayrandomize( array );
    }
    
    if ( !isdefined( level.randomweaponindex ) )
    {
        level.randomweaponindex = 0;
    }
    
    rewards = [];
    rewards[ 0 ] = level.br_pickups.var_2e379e316c36bf4a[ level.var_9997cc98df6aff3[ level.randomweaponindex ] ];
    level.randomweaponindex = ( level.randomweaponindex + 1 ) % level.var_9997cc98df6aff3.size;
    return rewards;
}

// Namespace dmz_weapon_case
// Params 0
// Checksum 0xa333afcb, Offset: 0x1656
// Size: 0xc, Type: bool
function function_7537c1a799b06954()
{
    return isdefined( level.weaponcaseinfo );
}

// Namespace dmz_weapon_case
// Params 1
// Checksum 0x8abbaa18, Offset: 0x166b
// Size: 0x15, Type: bool
function hasweaponcase( player )
{
    return isdefined( function_cf850474d4bf8706( player ) );
}

// Namespace dmz_weapon_case
// Params 1
// Checksum 0xe7263b46, Offset: 0x1689
// Size: 0x3d
function function_cf850474d4bf8706( player )
{
    if ( isdefined( level.weaponcaseinfo ) && level.weaponcaseinfo.currentowner == player )
    {
        return level.weaponcaseinfo;
    }
}

// Namespace dmz_weapon_case
// Params 1, eflags: 0x4
// Checksum 0xe20a7457, Offset: 0x16ce
// Size: 0x137
function private function_861c2821c1eedae0( origin )
{
    objid = objidpoolmanager::requestobjectiveid( 99 );
    level.weaponcaseinfo.objidnum = objid;
    
    if ( objid == -1 )
    {
        return;
    }
    
    objective_setlabel( objid, level.weaponcasedata.targetlabel );
    objective_setpings( objid, 1 );
    objective_setzoffset( objid, ( 0, 0, 80 )[ 2 ] );
    objective_icon( objid, level.weaponcasedata.icontexture );
    function_3759e26b1b750f5( objid, function_c182766395482505() );
    objective_setbackground( objid, 1 );
    objective_state( objid, "current" );
    objective_position( objid, origin );
    objective_setownerteam( objid, undefined );
    objective_setprogressteam( objid, undefined );
    function_ac9886e0e2860e18( objid, level.weaponcasedata.var_1e1ecace3b3c2a63, level.weaponcasedata.var_ee7bc8b53cebd37e );
    objective_disableping( objid, istrue( level.weaponcasedata.disablepingalways ) );
    objidpoolmanager::update_objective_objectiveid( objid, 16 );
    objective_setplayintro( objid, 0 );
    objidpoolmanager::objective_playermask_showtoall( objid );
    level thread function_731c426eac32accd();
}

// Namespace dmz_weapon_case
// Params 0, eflags: 0x4
// Checksum 0x3a574fb, Offset: 0x180d
// Size: 0x16b
function private function_731c426eac32accd()
{
    level endon( #"game_ended" );
    level endon( #"weaponcase_extracted" );
    
    while ( true )
    {
        if ( level.weaponcaseinfo.currentowner && !level.weaponcaseinfo.currentowner.extracted )
        {
            if ( level.weaponcasedata.objectiveonentity )
            {
                objective_onentity( level.weaponcaseinfo.objidnum, level.weaponcaseinfo.currentowner );
            }
            else
            {
                objective_position( level.weaponcaseinfo.objidnum, level.weaponcaseinfo.currentowner.origin );
            }
        }
        else if ( level.weaponcaseinfo.scriptable )
        {
            objective_position( level.weaponcaseinfo.objidnum, level.weaponcaseinfo.scriptable.origin );
        }
        else
        {
            objidpoolmanager::returnobjectiveid( level.weaponcaseinfo.objidnum );
            return;
        }
        
        objective_ping( level.weaponcaseinfo.objidnum );
        wait level.weaponcasedata.pingdelay;
    }
}

// Namespace dmz_weapon_case
// Params 1
// Checksum 0x5eab603d, Offset: 0x1980
// Size: 0x33
function function_cb7c3412ac32b9b9( origin )
{
    anyone = level.players[ 0 ];
    anyone weaponcaseanalytics( "init", origin );
}

// Namespace dmz_weapon_case
// Params 1, eflags: 0x4
// Checksum 0xafb94672, Offset: 0x19bb
// Size: 0x33
function private function_442d479723b5162b( origin )
{
    anyone = level.players[ 0 ];
    anyone weaponcaseanalytics( "spawned", origin );
}

// Namespace dmz_weapon_case
// Params 1, eflags: 0x4
// Checksum 0x33099cd, Offset: 0x19f6
// Size: 0x25
function private function_5eb4077427916e2f( player )
{
    player weaponcaseanalytics( "pickup", player.origin );
}

// Namespace dmz_weapon_case
// Params 2, eflags: 0x4
// Checksum 0x3e0d0fd3, Offset: 0x1a23
// Size: 0x30
function private function_fc282487f8790106( player, var_ac04173567e15761 )
{
    player weaponcaseanalytics( "drop", player.origin, var_ac04173567e15761 );
}

// Namespace dmz_weapon_case
// Params 3, eflags: 0x4
// Checksum 0x3922d48d, Offset: 0x1a5b
// Size: 0x1b8
function private weaponcaseanalytics( type, position, var_ac04173567e15761 = 0 )
{
    eventparams = [];
    eventparams[ eventparams.size ] = "event_type";
    eventparams[ eventparams.size ] = type;
    assert( isstring( eventparams[ eventparams.size - 1 ] ) );
    eventparams[ eventparams.size ] = "team_name";
    eventparams[ eventparams.size ] = self.team;
    assert( isstring( eventparams[ eventparams.size - 1 ] ) );
    eventparams[ eventparams.size ] = "playlist_name";
    eventparams[ eventparams.size ] = getplaylistname();
    assert( isstring( eventparams[ eventparams.size - 1 ] ) );
    eventparams[ eventparams.size ] = "circle_index";
    eventparams[ eventparams.size ] = getcircleindex();
    assert( isnumber( eventparams[ eventparams.size - 1 ] ) );
    eventparams[ eventparams.size ] = "map_name";
    eventparams[ eventparams.size ] = level.mapname;
    assert( isstring( eventparams[ eventparams.size - 1 ] ) );
    eventparams[ eventparams.size ] = "position_x";
    eventparams[ eventparams.size ] = position[ 0 ];
    assert( isnumber( eventparams[ eventparams.size - 1 ] ) );
    eventparams[ eventparams.size ] = "position_y";
    eventparams[ eventparams.size ] = position[ 1 ];
    assert( isnumber( eventparams[ eventparams.size - 1 ] ) );
    eventparams[ eventparams.size ] = "position_z";
    eventparams[ eventparams.size ] = position[ 2 ];
    assert( isnumber( eventparams[ eventparams.size - 1 ] ) );
    eventparams[ eventparams.size ] = "owner_killed";
    eventparams[ eventparams.size ] = var_ac04173567e15761;
    assert( isboolean( eventparams[ eventparams.size - 1 ] ) );
    self dlog_recordplayerevent( "dlog_event_br_weapon_case", eventparams );
}

// Namespace dmz_weapon_case
// Params 0, eflags: 0x4
// Checksum 0xb3517db7, Offset: 0x1c1b
// Size: 0x4b
function private getcircleindex()
{
    circleindex = -1;
    
    if ( isdefined( level.br_circle ) && isdefined( level.br_circle.circleindex ) )
    {
        circleindex = level.br_circle.circleindex;
    }
    
    return circleindex;
}

// Namespace dmz_weapon_case
// Params 1, eflags: 0x4
// Checksum 0xd56eb7c0, Offset: 0x1c6f
// Size: 0x23, Type: bool
function private isboolean( value )
{
    return isnumber( value ) && ( value == 1 || value == 0 );
}

