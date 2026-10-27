// scripts\mp\dmz\gametypes\dmz_task_utils.gsc  (hash_0c0066ee0cb9ef55.gscc) (size: 17567 Bytes / 0x449f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbb3b7075 (3141234805)
// size ...... 17567 (0x449f)
// includes .. 13  (offset: 0x41df)
// strings ... 39  (offset: 0x4247)
// dev strs .. 1   (offset: 0x4493)
// exports ... 66  (offset: 0x2b57)
// cseg ...... 0x4c0 + 0x2697 (0x2b57)
// imports ... 100 (offset: 0x35a7)
// animtree1 . 0   (offset: 0x449f)
// animtree2 . 0   (offset: 0x449f)
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_gametype_dmz;
#using scripts\mp\br\gametypes\br_instance_inventory;
#using scripts\mp\br\gametypes\br_plunder;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\inventory_utility;
#using scripts\mp\common\utility\killstreak_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\gameobjects;
#using scripts\mp\gametypes\activity_manager;
#using scripts\mp\objidpoolmanager;

#namespace dmz_task_utils;

// Namespace dmz_task_utils
// Params 1
// Checksum 0xa5945219, Offset: 0x4de
// Size: 0x61
function task_create( activity )
{
    task = spawnstruct();
    task.teams = [];
    task.mission = activity;
    task.activity = activity;
    task.funcs = [];
    task.index = 0;
    return task;
}

// Namespace dmz_task_utils
// Params 3
// Checksum 0x26426f35, Offset: 0x548
// Size: 0xd9
function function_13fe84cb824c72a8( circleid, locations, size )
{
    if ( !isdefined( self.questcircles ) )
    {
        self.questcircles = [];
    }
    
    foreach ( location in locations )
    {
        index = self.questcircles.size;
        self.questcircles[ index ] = spawnstruct();
        self.questcircles[ index ] game_utility::questcircle_create( circleid, location, size );
    }
}

// Namespace dmz_task_utils
// Params 3
// Checksum 0x406c3bef, Offset: 0x629
// Size: 0x72
function function_ca73a4f7b8d7aacb( circleid, location, size )
{
    if ( !isdefined( self.questcircles ) )
    {
        self.questcircles = [];
    }
    
    index = self.questcircles.size;
    self.questcircles[ index ] = spawnstruct();
    self.questcircles[ index ] game_utility::questcircle_create( circleid, location, size );
}

// Namespace dmz_task_utils
// Params 1
// Checksum 0x5182c79a, Offset: 0x6a3
// Size: 0x99
function function_6277bd2a0d5a28b9( player )
{
    if ( isdefined( self.questcircles ) )
    {
        foreach ( circle in self.questcircles )
        {
            if ( isdefined( circle ) )
            {
                circle game_utility::questcircle_showtoplayer( player );
            }
        }
    }
}

// Namespace dmz_task_utils
// Params 1
// Checksum 0x5861ffdb, Offset: 0x744
// Size: 0x99
function function_1f01bb1108ba0241( player )
{
    if ( isdefined( self.questcircles ) )
    {
        foreach ( circle in self.questcircles )
        {
            if ( isdefined( circle ) )
            {
                circle game_utility::questcircle_hidefromplayer( player );
            }
        }
    }
}

// Namespace dmz_task_utils
// Params 1
// Checksum 0xd50cc436, Offset: 0x7e5
// Size: 0x99
function function_18b83232055b1325( team )
{
    if ( isdefined( self.questcircles ) )
    {
        foreach ( circle in self.questcircles )
        {
            if ( isdefined( circle ) )
            {
                circle function_5b1f02a1690aa24c( team );
            }
        }
    }
}

// Namespace dmz_task_utils
// Params 2
// Checksum 0xd7999a53, Offset: 0x886
// Size: 0x4a
function function_a532b7f17f4920e8( team, circleindex )
{
    if ( !isdefined( self.questcircles ) )
    {
        return;
    }
    
    if ( !isdefined( self.questcircles[ circleindex ] ) )
    {
        return;
    }
    
    self.questcircles[ circleindex ] function_5b1f02a1690aa24c( team );
}

// Namespace dmz_task_utils
// Params 0
// Checksum 0x3fabeacb, Offset: 0x8d8
// Size: 0x8e
function function_e23cad864e9e2023()
{
    if ( isdefined( self.questcircles ) )
    {
        foreach ( circle in self.questcircles )
        {
            if ( isdefined( circle ) )
            {
                circle game_utility::questcircle_delete();
            }
        }
    }
}

// Namespace dmz_task_utils
// Params 1
// Checksum 0xe5a9b5e4, Offset: 0x96e
// Size: 0x38
function function_d0fab7ddae4ada22( index )
{
    if ( isdefined( self.questcircles ) )
    {
        self.questcircles[ index ] game_utility::questcircle_delete();
        self.questcircles[ index ] = undefined;
    }
}

// Namespace dmz_task_utils
// Params 2
// Checksum 0x6e1cc801, Offset: 0x9ae
// Size: 0x21
function function_c7ccd46fc59f189d( origin, radius )
{
    return origin + utility::function_d8f5310928e6277f() * radius;
}

// Namespace dmz_task_utils
// Params 3
// Checksum 0x4ea8b3df, Offset: 0x9d8
// Size: 0xa2
function function_b32612babb51a367( neworigin = self.questcircles[ circleindex ].mapcircle.origin, newradius = self.questcircles[ circleindex ].mapcircle.origin[ 2 ], circleindex = 0 )
{
    self.questcircles[ circleindex ].mapcircle.origin = ( neworigin[ 0 ], neworigin[ 1 ], newradius );
}

// Namespace dmz_task_utils
// Params 2
// Checksum 0xed2cb424, Offset: 0xa82
// Size: 0x1a9
function function_3afd1eb10711323( points, height )
{
    minx = points[ 0 ][ 0 ];
    maxx = points[ 0 ][ 0 ];
    miny = points[ 0 ][ 1 ];
    maxy = points[ 0 ][ 1 ];
    
    foreach ( point in points )
    {
        if ( minx > point[ 0 ] )
        {
            minx = point[ 0 ];
        }
        
        if ( maxx < point[ 0 ] )
        {
            maxx = point[ 0 ];
        }
        
        if ( miny > point[ 1 ] )
        {
            miny = point[ 1 ];
        }
        
        if ( maxy < point[ 1 ] )
        {
            maxy = point[ 1 ];
        }
    }
    
    center = ( ( maxx + minx ) / 2, ( maxy + miny ) / 2, height );
    radiussq = 0;
    
    foreach ( point in points )
    {
        distsq = distance2dsquared( center, point );
        
        if ( radiussq <= distsq )
        {
            radiussq = distsq;
        }
    }
    
    return [ center, sqrt( radiussq ) ];
}

// Namespace dmz_task_utils
// Params 1
// Checksum 0xb03feb07, Offset: 0xc34
// Size: 0x1f5
function function_96037ebc29937337( team )
{
    level endon( #"game_ended" );
    self endon( #"task_ended" );
    wait 3;
    
    while ( true )
    {
        if ( !isdefined( self.questcircles ) || self.questcircles.size == 0 || !isdefined( self.icon ) )
        {
            return;
        }
        
        players = teams::getteamdata( team, "players" );
        
        foreach ( player in players )
        {
            showicon = 1;
            
            foreach ( circle in self.questcircles )
            {
                if ( !isdefined( circle.mapcircle ) )
                {
                    continue;
                }
                
                dist = distance2dsquared( player.origin, circle.mapcircle.origin );
                
                if ( dist <= circle.mapcircle.origin[ 2 ] * circle.mapcircle.origin[ 2 ] )
                {
                    showicon = 0;
                    break;
                }
            }
            
            if ( showicon )
            {
                function_dc6a173a36eef985( player );
                continue;
            }
            
            function_d8d9112f1e68fa2b( player );
        }
        
        wait 1;
    }
}

// Namespace dmz_task_utils
// Params 2
// Checksum 0xd7a175ac, Offset: 0xe31
// Size: 0x1a2
function function_6435c5abd423fd62( team, circleindex )
{
    level endon( #"game_ended" );
    self endon( #"task_ended" );
    wait 3;
    
    while ( true )
    {
        if ( !isdefined( self.questcircles ) || self.questcircles.size == 0 || !isdefined( self.icon ) )
        {
            return;
        }
        
        players = teams::getteamdata( team, "players" );
        
        foreach ( player in players )
        {
            showicon = 1;
            circle = self.questcircles[ circleindex ];
            
            if ( isdefined( circle.mapcircle ) )
            {
                dist = distance2dsquared( player.origin, circle.mapcircle.origin );
                
                if ( dist <= circle.mapcircle.origin[ 2 ] * circle.mapcircle.origin[ 2 ] )
                {
                    showicon = 0;
                    break;
                }
            }
            
            if ( showicon )
            {
                function_dc6a173a36eef985( player );
                continue;
            }
            
            function_d8d9112f1e68fa2b( player );
        }
        
        wait 1;
    }
}

// Namespace dmz_task_utils
// Params 6
// Checksum 0xc9261c48, Offset: 0xfdb
// Size: 0x6c
function function_b08f19f413c2d79c( icon, teamname, location, zoffset, waittime, objectivestate )
{
    level endon( #"game_ended" );
    self endon( #"removeicon" );
    
    if ( isdefined( waittime ) )
    {
        wait waittime;
    }
    else
    {
        waitframe();
    }
    
    function_733f28314a73e615( icon, teamname, location, zoffset, objectivestate );
}

// Namespace dmz_task_utils
// Params 5
// Checksum 0xa821d858, Offset: 0x104f
// Size: 0x72
function function_a541134e628a5f5b( icon, teamname, entity, zoffset, objectivestate )
{
    function_733f28314a73e615( icon, teamname, entity.origin, zoffset, objectivestate );
    objidpoolmanager::update_objective_onentity( self.objidnum, entity );
    
    if ( isdefined( zoffset ) )
    {
        objidpoolmanager::update_objective_setzoffset( self.objidnum, zoffset );
    }
}

// Namespace dmz_task_utils
// Params 5
// Checksum 0x38d12502, Offset: 0x10c9
// Size: 0xc6
function function_733f28314a73e615( icon, teamname, location, zoffset = 0, objectivestate )
{
    self.curorigin = location;
    self.offset3d = ( 0, 0, zoffset );
    gameobjects::requestid( 1, 1, undefined, 1 );
    objidpoolmanager::update_objective_icon( self.objidnum, icon );
    
    if ( isdefined( teamname ) )
    {
        objidpoolmanager::objective_teammask_single( self.objidnum, teamname );
    }
    else
    {
        objective_removeallfrommask( self.objidnum );
    }
    
    objidpoolmanager::update_objective_state( self.objidnum, objectivestate ?? "invisible" );
    objidpoolmanager::update_objective_setbackground( self.objidnum, 4 );
}

// Namespace dmz_task_utils
// Params 1
// Checksum 0x93bff3c3, Offset: 0x1197
// Size: 0x29
function function_450c0c1a45b229d9( newentity )
{
    self.trackingentity = newentity;
    objidpoolmanager::update_objective_onentity( self.objidnum, newentity );
}

// Namespace dmz_task_utils
// Params 1
// Checksum 0xa37c6c7c, Offset: 0x11c8
// Size: 0x31
function function_e8e696b0cfb1838e( teamname )
{
    if ( isdefined( teamname ) && isdefined( self.objidnum ) )
    {
        objidpoolmanager::objective_teammask_single( self.objidnum, teamname );
    }
}

// Namespace dmz_task_utils
// Params 1
// Checksum 0xf79432ba, Offset: 0x1201
// Size: 0x3d
function function_205740d04dd0c548( teamname )
{
    if ( isdefined( teamname ) && isdefined( self.objidnum ) )
    {
        objective_removeteamfrommask( self.objidnum, teamname );
        objective_showtoplayersinmask( self.objidnum );
    }
}

// Namespace dmz_task_utils
// Params 0
// Checksum 0x66fa0bb4, Offset: 0x1246
// Size: 0x27
function function_fc392c6e7813fcf1()
{
    self notify( #"removeicon" );
    
    if ( isdefined( self ) && isdefined( self.objidnum ) )
    {
        gameobjects::releaseid();
    }
}

// Namespace dmz_task_utils
// Params 2
// Checksum 0x847ce4f3, Offset: 0x1275
// Size: 0x5d
function function_b4e5a36fc431be04( entity, zoffset = 50 )
{
    function_b3476f99a8e21fa2( entity.origin );
    
    if ( isdefined( self.icon ) )
    {
        objective_onentity( self.icon, entity );
        objective_setzoffset( self.icon, zoffset );
    }
}

// Namespace dmz_task_utils
// Params 2
// Checksum 0x5ba9c083, Offset: 0x12da
// Size: 0x151
function function_b3476f99a8e21fa2( origin, type = self.activity.type )
{
    self.icon = objidpoolmanager::requestobjectiveid( 99 );
    
    if ( !isdefined( self.icon ) || self.icon == -1 )
    {
        self.icon = undefined;
        return;
    }
    
    self.iconorigin = origin;
    objective_delete( self.icon );
    objective_icon( self.icon, task_geticon( type ) );
    objective_setbackground( self.icon, 4 );
    objective_position( self.icon, origin );
    objective_setplayintro( self.icon, 1 );
    objective_setdescription( self.icon, &"mp_dmz_missions/contract_icon_label" );
    objective_state( self.icon, "current" );
    objidpoolmanager::objective_showdistance( self.icon, 0 );
    objective_sethideelevation( self.icon, 1 );
    function_59c2c5d8363fbea0( self.icon, 1 );
    function_3759e26b1b750f5( self.icon, function_d75a31263aa9c206() );
    objective_addalltomask( self.icon );
    objective_hidefromplayersinmask( self.icon );
}

// Namespace dmz_task_utils
// Params 1, eflags: 0x4
// Checksum 0x52cff34d, Offset: 0x1433
// Size: 0x19b
function private task_geticon( type )
{
    icon = undefined;
    
    switch ( type )
    {
        case #"hash_9e02cd4a0f3ca981":
            icon = "ui_map_icon_obj_assassin";
            break;
        case #"hash_9617cc9a55eccdd4":
            icon = "ui_map_icon_obj_scavenger";
            break;
        case #"hash_7e9cf92ed0a526f1":
            icon = "ui_map_icon_obj_sh_bomb_defuse";
            break;
        case #"hash_5f39d019572500bb":
            icon = "ui_map_icon_obj_recover";
            break;
        case #"hash_ec086b911c1011ec":
            icon = "ui_map_icon_obj_rescue";
            break;
        case #"hash_58f6d6cc1dc3e295":
            icon = "ui_map_icon_obj_bomb_collect";
            break;
        case #"hash_37bb23543c319104":
            icon = "ui_map_icon_obj_hunt";
            break;
        case #"hash_9db32d30f2603c35":
            icon = "ui_map_icon_obj_cargo_delivery";
            break;
        case #"hash_1e754eb11fa62651":
            icon = "ui_map_icon_obj_cargo_ship";
            break;
        case #"hash_2e6b7be09d7fd568":
            icon = "ui_map_icon_obj_geiger_search";
            break;
        case #"hash_bf5597954aaed3d7":
            icon = "ui_map_icon_obj_intel_dmz";
            break;
        case #"hash_82ea0e6e4f123b62":
            icon = "ui_map_icon_obj_trap";
            break;
        case #"hash_4f62da1c4ed6f790":
            icon = "ui_map_icon_obj_most_wanted";
            break;
        case #"hash_be386dc37be6968e":
            icon = "ui_map_icon_obj_dmz_supply";
            break;
        case #"hash_218ddcea32fa5fbc":
            icon = "ui_map_icon_obj_hacker";
            break;
        case #"hash_4aae0f3e58abb932":
            icon = "ui_map_icon_elite_geiger_search";
            break;
        default:
            icon = "ui_map_icon_obj_scavenger";
            break;
    }
    
    return icon;
}

// Namespace dmz_task_utils
// Params 1
// Checksum 0x7f5fbae6, Offset: 0x15d7
// Size: 0x2b
function function_dc6a173a36eef985( player )
{
    if ( isdefined( self.icon ) )
    {
        objidpoolmanager::objective_playermask_addshowplayer( self.icon, player );
    }
}

// Namespace dmz_task_utils
// Params 1
// Checksum 0xef602d93, Offset: 0x160a
// Size: 0x98
function function_678cd11cba7c85a9( team )
{
    if ( !isdefined( self.icon ) )
    {
        return;
    }
    
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        function_dc6a173a36eef985( player );
    }
}

// Namespace dmz_task_utils
// Params 1
// Checksum 0x30d24603, Offset: 0x16aa
// Size: 0x2b
function function_d8d9112f1e68fa2b( player )
{
    if ( isdefined( self.icon ) )
    {
        objidpoolmanager::objective_playermask_hidefrom( self.icon, player );
    }
}

// Namespace dmz_task_utils
// Params 1
// Checksum 0x287310ed, Offset: 0x16dd
// Size: 0x89
function function_1f1750516b1142e3( team )
{
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        function_d8d9112f1e68fa2b( player );
    }
}

// Namespace dmz_task_utils
// Params 0
// Checksum 0x4a688e01, Offset: 0x176e
// Size: 0x2a
function function_3ff46488beb193c7()
{
    if ( isdefined( self.icon ) )
    {
        objidpoolmanager::returnobjectiveid( self.icon );
        self.icon = -1;
    }
}

// Namespace dmz_task_utils
// Params 1
// Checksum 0xc44be33c, Offset: 0x17a0
// Size: 0x34
function function_c74c010e593f5ea5( location )
{
    if ( isdefined( self.icon ) )
    {
        self.iconorigin = location;
        objective_position( self.icon, location );
    }
}

// Namespace dmz_task_utils
// Params 2
// Checksum 0x4fd44941, Offset: 0x17dc
// Size: 0x51
function function_512f23b3619333d1( entity, zoffset = 50 )
{
    if ( isdefined( self.icon ) )
    {
        objective_onentity( self.icon, entity );
        
        if ( isdefined( zoffset ) )
        {
            objective_setzoffset( self.icon, zoffset );
        }
    }
}

// Namespace dmz_task_utils
// Params 2
// Checksum 0x8964e84, Offset: 0x1835
// Size: 0x203
function function_ce0c366b96d23996( weaponnameoverride, omnvaroverride )
{
    self endon( #"death" );
    weaponname = "intel_pickup_phone";
    
    if ( isdefined( weaponnameoverride ) )
    {
        weaponname = weaponnameoverride;
    }
    
    if ( self.insertingarmorplate )
    {
        self notify( #"try_armor_cancel" );
        
        while ( isdefined( self.currentweapon ) && self.currentweapon.basename == "iw9_armor_plate_deploy_mp" )
        {
            waitframe();
        }
        
        waitframe();
    }
    
    self notify( #"cancel_all_killstreak_deployments" );
    
    while ( killstreak_utility::iskillstreakdeployweapon( self getcurrentweapon() ) )
    {
        waitframe();
    }
    
    omnvar = function_acb680faac11b569( weaponname );
    
    if ( isdefined( omnvaroverride ) )
    {
        omnvar = omnvaroverride;
    }
    
    val::set( "show_intel", "weapon_switch", 0 );
    val::set( "show_intel", "mantle", 0 );
    val::set( "show_intel", "prone", 0 );
    val::set( "show_intel", "melee", 0 );
    val::set( "show_intel", "offhand_weapons", 0 );
    val::set( "show_intel", "weapon_pickup", 0 );
    val::set( "show_intel", "usability", 0 );
    val::set( "show_intel", "vehicle_use", 0 );
    currentweapon = self getcurrentweapon();
    animatedweapon = makeweapon( weaponname );
    inventory_utility::_giveweapon( animatedweapon );
    self switchtoweapon( animatedweapon );
    self setclientomnvar( "ui_tablet_usb", omnvar );
    thread function_e18bcc78e79584af();
    wait function_567a671715455a8a( weaponname );
    self takeweapon( animatedweapon );
    
    if ( self.inlaststand )
    {
        if ( isdefined( level.var_449c32a0f392eed7 ) )
        {
            currentweapon = self [[ level.var_449c32a0f392eed7 ]]();
        }
        else
        {
            currentweapon = level.defaultfist;
        }
    }
    
    self switchtoweapon( currentweapon );
    val::reset_all( "show_intel" );
    self setclientomnvar( "ui_tablet_usb", 0 );
    self notify( #"hash_3d52ef2ae4c818b4" );
}

// Namespace dmz_task_utils
// Params 1, eflags: 0x4
// Checksum 0x1bae7804, Offset: 0x1a40
// Size: 0x6c
function private function_acb680faac11b569( weap_name )
{
    switch ( weap_name )
    {
        case #"hash_6971a5b6d5b4c43f":
        case #"hash_83bf32566065a90b":
            return 1;
        case #"hash_1f46dae464ca1c4f":
            return 2;
        case #"hash_c77f7e706b6640ab":
            return 3;
        case #"hash_52ebc6fd88a136a5":
            return 8;
        default:
            return 0;
    }
}

// Namespace dmz_task_utils
// Params 1, eflags: 0x4
// Checksum 0x6572f399, Offset: 0x1ab4
// Size: 0x72
function private function_567a671715455a8a( weap_name )
{
    switch ( weap_name )
    {
        case #"hash_6971a5b6d5b4c43f":
        case #"hash_83bf32566065a90b":
            return 4;
        case #"hash_1f46dae464ca1c4f":
            return 3;
        case #"hash_c77f7e706b6640ab":
            return 4.5;
        case #"hash_52ebc6fd88a136a5":
            return 4;
        case #"hash_280f1b82c041035a":
            return 8;
    }
    
    return 5;
}

// Namespace dmz_task_utils
// Params 0
// Checksum 0x50796f8c, Offset: 0x1b2f
// Size: 0x3f
function function_e18bcc78e79584af()
{
    self endon( #"hash_3d52ef2ae4c818b4" );
    level endon( #"game_ended" );
    self waittill( #"death_or_disconnect" );
    self setclientomnvar( "ui_tablet_usb", 0 );
    val::reset_all( "show_intel" );
}

// Namespace dmz_task_utils
// Params 2
// Checksum 0x761b806f, Offset: 0x1b76
// Size: 0x42
function function_5fad6b062ca5ce96( teammates, cash )
{
    teamsize = float( getdvarint( @"hash_398b5abef8d572fa", teammates.size ) );
    return teamsize ? cash / teamsize : 0;
}

// Namespace dmz_task_utils
// Params 2
// Checksum 0xf16db224, Offset: 0x1bc1
// Size: 0x48
function function_801915892ff1d63e( player, cash )
{
    var_279f2c56d1dc87be = br_instance_inventory::getupgradecount( player, 19 ) ?? 0;
    cashmultiplier = 1 + 0.05 * var_279f2c56d1dc87be;
    return cash * cashmultiplier;
}

// Namespace dmz_task_utils
// Params 2
// Checksum 0xdb8815f, Offset: 0x1c12
// Size: 0x107
function function_e533421ccebd7d79( teamname, cash )
{
    teammates = teams::getteamdata( teamname, "players" );
    
    if ( !isarray( teammates ) || teammates.size == 0 )
    {
        return;
    }
    
    if ( !isdefined( cash ) )
    {
        cash = self.activity.cashreward;
    }
    
    var_a3ed41d0a074b594 = function_5fad6b062ca5ce96( teammates, cash );
    
    foreach ( player in teammates )
    {
        multipliedcash = function_801915892ff1d63e( player, var_a3ed41d0a074b594 );
        var_2992556ccf80d780 = int( ceil( multipliedcash ) );
        player br_plunder::playerplunderpickup( var_2992556ccf80d780 );
    }
}

// Namespace dmz_task_utils
// Params 2
// Checksum 0x8d0af257, Offset: 0x1d21
// Size: 0x104
function function_f15515a374b8ebf2( teamname, cash )
{
    totalcash = 0;
    teammates = teams::getteamdata( teamname, "players" );
    
    if ( !isarray( teammates ) || teammates.size == 0 )
    {
        return;
    }
    
    if ( !isdefined( cash ) )
    {
        cash = self.activity.cashreward;
    }
    
    var_a3ed41d0a074b594 = function_5fad6b062ca5ce96( teammates, cash );
    
    foreach ( player in teammates )
    {
        multipliedcash = function_801915892ff1d63e( player, var_a3ed41d0a074b594 );
        totalcash += multipliedcash;
    }
    
    return int( ceil( totalcash ) );
}

// Namespace dmz_task_utils
// Params 2
// Checksum 0x6c580190, Offset: 0x1e2e
// Size: 0xbf
function task_ended( completingteam, var_4bdc367855270ff8 )
{
    if ( isdefined( completingteam ) )
    {
        players = teams::getteamdata( completingteam, "players" );
        
        if ( isdefined( players ) )
        {
            foreach ( player in players )
            {
                level thread br_gametype_dmz::function_fe978706e2633a0( player );
            }
        }
    }
    
    self.activity activity_manager::activity_taskended( self, completingteam, var_4bdc367855270ff8 );
}

// Namespace dmz_task_utils
// Params 2
// Checksum 0xa8c210e, Offset: 0x1ef5
// Size: 0x74
function function_59e5c04599d5a456( instance, player )
{
    if ( !( isdefined( instance ) && isdefined( instance.task ) ) )
    {
        return;
    }
    
    task = instance.task;
    
    if ( arraycontains( task.teams, player.team ) )
    {
        task task_ended( player.team );
    }
}

// Namespace dmz_task_utils
// Params 2
// Checksum 0x1253efda, Offset: 0x1f71
// Size: 0x8a
function function_be01e8d1cf19ccbc( task, player )
{
    if ( isbrgamemode() )
    {
        return ( isdefined( task ) && isdefined( player ) && task.team == player.team );
    }
    
    return isdefined( task ) && isdefined( task.teams ) && isdefined( player ) && isdefined( player.team ) && arraycontains( task.teams, player.team );
}

// Namespace dmz_task_utils
// Params 1
// Checksum 0x74e70e89, Offset: 0x2003
// Size: 0x55
function function_b98b5c402af55e81( teamname )
{
    assert( isdefined( self.activity.type ), "<dev string:x24>" );
    task_showsplashtoteam( "dmz_generic_" + self.activity.type + "_mission_assigned", teamname );
}

// Namespace dmz_task_utils
// Params 4
// Checksum 0x591fc6ef, Offset: 0x2060
// Size: 0x7f
function function_c64a66646904bc1( splash, contractref, cashreward, teamname )
{
    contractindex = level.var_f9ba6d6273c5cc67.spawndatamap[ contractref ].index;
    params = br_contract_manager::packsplashparambits( contractindex, cashreward );
    br_gametype_dmz::showdmzsplash( splash, teams::getteamdata( teamname, "players" ), undefined, params );
}

// Namespace dmz_task_utils
// Params 2
// Checksum 0xd8b272e8, Offset: 0x20e7
// Size: 0x3e
function task_showsplashtoteam( splash, teamname )
{
    br_gametype_dmz::showdmzsplash( splash, teams::getteamdata( teamname, "players" ), self.node.script_poi );
}

// Namespace dmz_task_utils
// Params 1
// Checksum 0x2ddbba24, Offset: 0x212d
// Size: 0x1e
function function_1526dd6e4ed4bbee( splash )
{
    br_gametype_dmz::showdmzsplash( splash, level.players );
}

// Namespace dmz_task_utils
// Params 2
// Checksum 0x3c1fcc2, Offset: 0x2153
// Size: 0x4b
function function_864f8eee2e38c55a( splash, teamname )
{
    br_gametype_dmz::showdmzsplash( splash, arrayremove( level.players, teams::getteamdata( teamname, "players" ) ), self.node.script_poi );
}

// Namespace dmz_task_utils
// Params 1
// Checksum 0x785f0136, Offset: 0x21a6
// Size: 0x5e
function function_c249649ab8c62a3e( teamname )
{
    if ( !isdefined( level.radiation ) || !level.radiation.spreading )
    {
        wait 5;
        
        if ( !level.var_4bdc367855270ff8 )
        {
            br_gametype_dmz::showdmzsplash( "dmz_contract_reminder", teams::getteamdata( teamname, "players" ) );
        }
    }
}

// Namespace dmz_task_utils
// Params 1
// Checksum 0xd54b3709, Offset: 0x220c
// Size: 0x61
function task_questpointgetradius( point )
{
    radius = 0;
    
    if ( point.spawnflags & 4 )
    {
        radius = 256;
    }
    else if ( point.spawnflags & 2 )
    {
        radius = 128;
    }
    else if ( point.spawnflags & 1 )
    {
        radius = 168;
    }
    
    return radius;
}

// Namespace dmz_task_utils
// Params 0
// Checksum 0x88c20ec8, Offset: 0x2276
// Size: 0x2b
function function_d60b2e95d34418ac()
{
    if ( isdefined( level.var_e7d6fcb6a0103940 ) && level.var_e7d6fcb6a0103940.size > 1 )
    {
        return level.var_e7d6fcb6a0103940;
    }
    
    return [];
}

// Namespace dmz_task_utils
// Params 1
// Checksum 0x717fa725, Offset: 0x22aa
// Size: 0x89
function function_5b1f02a1690aa24c( teamname )
{
    foreach ( player in teams::getteamdata( teamname, "players" ) )
    {
        game_utility::questcircle_showtoplayer( player );
    }
}

// Namespace dmz_task_utils
// Params 1
// Checksum 0x36f280e6, Offset: 0x233b
// Size: 0x89
function function_1f7fc1f084e4ee44( teamname )
{
    foreach ( player in teams::getteamdata( teamname, "players" ) )
    {
        game_utility::questcircle_hidefromplayer( player );
    }
}

// Namespace dmz_task_utils
// Params 2
// Checksum 0x6fc156a0, Offset: 0x23cc
// Size: 0x88
function function_2a90a77ea074c9c2( objidnum, teams )
{
    foreach ( team in teams )
    {
        function_e5bff878b8e56145( objidnum, team );
    }
}

// Namespace dmz_task_utils
// Params 2
// Checksum 0x4339d989, Offset: 0x245c
// Size: 0x9d
function function_e5bff878b8e56145( objidnum, team )
{
    foreach ( player in teams::getteamdata( team, "players" ) )
    {
        objidpoolmanager::objective_unpin_player( objidnum, player );
        objidpoolmanager::function_b3b969f2930890eb( 0, player );
    }
}

// Namespace dmz_task_utils
// Params 3
// Checksum 0x5afd8cc5, Offset: 0x2501
// Size: 0x6f
function function_b0031e082bef723d( inorigin, inangles, task )
{
    cache = spawnscriptable( "br_loot_cache", inorigin, inangles );
    cache setscriptablepartstate( "body", "open_usable" );
    function_e059e95407f1f191( cache, [] );
    cache.task = task;
    task.cache = cache;
    return cache;
}

// Namespace dmz_task_utils
// Params 2
// Checksum 0x6efed892, Offset: 0x2579
// Size: 0x129
function function_e059e95407f1f191( cache, teams )
{
    validplayers = [];
    
    foreach ( team in teams )
    {
        validplayers = arraycombine( validplayers, teams::getteamdata( team, "players" ) );
    }
    
    foreach ( player in level.players )
    {
        if ( arraycontains( validplayers, player ) )
        {
            cache enablescriptableplayeruse( player );
            continue;
        }
        
        cache disablescriptableplayeruse( player );
    }
}

// Namespace dmz_task_utils
// Params 1
// Checksum 0x137342c1, Offset: 0x26aa
// Size: 0x2a
function function_d4ea0f16e1d32f37( cash )
{
    if ( !isdefined( cash ) || cash == 0 )
    {
        return 1;
    }
    
    return int( cash / 25 - 1 );
}

// Namespace dmz_task_utils
// Params 2
// Checksum 0x717371de, Offset: 0x26dd
// Size: 0x1f
function function_d1003180abd8ac5f( player, index )
{
    player br_contract_manager::setquestindexomnvar( index );
}

// Namespace dmz_task_utils
// Params 3
// Checksum 0x26eb6093, Offset: 0x2704
// Size: 0xaf
function function_4a4efabf70334bfb( index, tier, teamname )
{
    foreach ( player in teams::getteamdata( teamname, "players" ) )
    {
        function_d1003180abd8ac5f( player, index );
    }
    
    if ( !isdefined( tier ) )
    {
        tier = 1;
    }
    
    br_contract_manager::setquestrewardtier( tier, teamname );
}

// Namespace dmz_task_utils
// Params 1
// Checksum 0x154c8599, Offset: 0x27bb
// Size: 0x16
function function_9b0ef5309a210b35( player )
{
    player br_contract_manager::setquestindexomnvar( 0 );
}

// Namespace dmz_task_utils
// Params 1
// Checksum 0xde097196, Offset: 0x27d9
// Size: 0x89
function function_a34948873e789a50( teamname )
{
    foreach ( player in teams::getteamdata( teamname, "players" ) )
    {
        function_9b0ef5309a210b35( player );
    }
}

// Namespace dmz_task_utils
// Params 1
// Checksum 0x6b7472b1, Offset: 0x286a
// Size: 0xf2
function function_844c661c74b52ce3( ref )
{
    self.ref = ref;
    self.refindex = br_contract_manager::getquesttableindex( self.ref );
    tier = 1;
    
    if ( isdefined( self.activity ) )
    {
        cashreward = self.activity.cashreward;
        tier = function_d4ea0f16e1d32f37( cashreward );
    }
    
    foreach ( team in self.teams )
    {
        function_4a4efabf70334bfb( self.refindex, tier, team );
    }
}

// Namespace dmz_task_utils
// Params 1
// Checksum 0x714d2fd1, Offset: 0x2964
// Size: 0xad
function function_44b2bf42bbc07d05( teamname )
{
    key = self.activitykey;
    players = teams::getteamdata( teamname, "players" );
    
    foreach ( player in players )
    {
        player.activitykey = key;
    }
}

// Namespace dmz_task_utils
// Params 1
// Checksum 0xf2950052, Offset: 0x2a19
// Size: 0x9d
function function_2f96219ec7ea4fe9( teamname )
{
    if ( isdefined( teamname ) )
    {
        players = teams::getteamdata( teamname, "players" );
        
        foreach ( player in players )
        {
            player.activitykey = undefined;
        }
    }
}

// Namespace dmz_task_utils
// Params 3
// Checksum 0xe9771bae, Offset: 0x2abe
// Size: 0x99
function task_watchcancel( instance, task, player )
{
    task endon( #"bomb_planted" );
    task endon( #"bomb_defused" );
    player endon( #"death_or_disconnect" );
    player endon( #"last_stand_enter" );
    player endon( #"enter_live_ragdoll" );
    player notifyonplayercommand( "cancel", "+weapnext" );
    instance.cancel = 0;
    player waittill( #"cancel" );
    instance.cancel = 1;
}

