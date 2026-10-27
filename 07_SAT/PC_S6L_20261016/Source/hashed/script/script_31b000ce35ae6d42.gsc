// script_31b000ce35ae6d42  (hash_31b000ce35ae6d42.gscc) (size: 19606 Bytes / 0x4c96 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7edad840 (2128271424)
// size ...... 19606 (0x4c96)
// includes .. 26  (offset: 0x4756)
// strings ... 76  (offset: 0x4826)
// dev strs .. 6   (offset: 0x4c4e)
// exports ... 44  (offset: 0x2f12)
// cseg ...... 0x5b1 + 0x2961 (0x2f12)
// imports ... 143 (offset: 0x35f2)
// animtree1 . 0   (offset: 0x4c96)
// animtree2 . 0   (offset: 0x4c96)
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\math;
#using scripts\common\scriptable_group_spatial;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\airdrop_scriptbundle;
#using scripts\mp\br\br_activity_util;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_publicevents;
#using scripts\mp\br\gametypes\br_supply_drops;
#using scripts\mp\common\killstreaks\airdrop;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_ammo;
#using scripts\mp\loot\common_item_redeploy_token;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;

#namespace namespace_266026a83ee842e2;

// Namespace namespace_266026a83ee842e2
// Params 0, eflags: 0x5
// Checksum 0xda7ff3c0, Offset: 0x5cf
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_88077e5ca42b81f1", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace namespace_266026a83ee842e2
// Params 0, eflags: 0x4
// Checksum 0x2bc4a15c, Offset: 0x5f8
// Size: 0x28
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "BR_PUBLIC_EVENT_ROYALTY_WEAPON", &activity_type_init );
    br_publicevents::function_54d95495df246a2b( getxhashasset( "BR_PUBLIC_EVENT_ROYALTY_WEAPON" ), &function_323fab1b62a2d5d4 );
}

// Namespace namespace_266026a83ee842e2
// Params 1, eflags: 0x4
// Checksum 0x1287fe13, Offset: 0x628
// Size: 0x224
function private function_323fab1b62a2d5d4( eventinfo )
{
    eventinfo.postinitfunc = &postinitfunc;
    eventinfo.canactivatefunc = &canactivatefunc;
    level callback::add( #"hash_9aafcac01b1facc6", &royaltyweaponpickup );
    level callback::add( #"item_spawn_weapon_obj", &royaltyweapondrop );
    level callback::add( #"hash_28245a6d2061f779", &function_7777c2710b3f61d9 );
    level callback::add( #"player_damaged", &onplayerdamaged );
    level callback::add( #"player_laststand", &function_d8957f2712fd72c8 );
    level callback::add( #"player_laststand_exit", &function_c614aaeb1d4d8bc6 );
    level callback::add( #"killstreak_begin_use", &onkillstreakbeginuse );
    level callback::add( #"killstreak_finish_use", &function_c35bf7a73f65a349 );
    level callback::add( #"player_death", &onplayerdeath );
    level callback::add( #"hash_3a9399925470154c", &function_40b3e153303d109b );
    airdrop_scriptbundle::registerairdrop( "saw_airdrop_royalty_weapon", &royaltyspawnweapon, &function_ec8dc3a0678c3953 );
    level.royaltyweaponstruct = spawnstruct();
    level.royaltyweaponstruct.eventtype = eventinfo.event;
    level.royaltyweaponstruct.var_87aabc2d68ae365c = getdvarint( @"hash_ef1bcad8f4903d8b", 0 );
    level.royaltyweaponstruct.var_f6b881139e7cf6ae = getdvarint( @"hash_f8cb68a4a5e7f8f0", 1 ) == 1;
    level.royaltyweaponstruct.var_7ee824591908dd21 = utility::function_b104528d84ca3561( getdvar( @"hash_8eb73850361e57d7", "1,4" ), "," );
    game[ "dialog" ][ "plane_enters_space" ] = "rowe_wzan_esrw";
    game[ "dialog" ][ "crate_lands_ground" ] = "rowe_wzan_eerw";
    game[ "dialog" ][ "ally_pick_up" ] = "rowe_wzan_pprw";
    game[ "dialog" ][ "player_pick_up" ] = "rowe_wzan_ssrw";
    game[ "dialog" ][ "enemy_pick_up" ] = "rowe_wzan_eprw";
}

// Namespace namespace_266026a83ee842e2
// Params 0, eflags: 0x4
// Checksum 0xfa2c8c71, Offset: 0x854
// Size: 0x46
function private postinitfunc()
{
    /#
        debug_init();
    #/
    
    if ( !utility::issharedfuncdefined( #"br_legendary_supply_drop", #"legendary_supply_oncrateuse" ) )
    {
        utility::registersharedfunc( #"br_legendary_supply_drop", #"legendary_supply_oncrateuse", &br_supply_drops::function_4059aab25747f034 );
    }
}

// Namespace namespace_266026a83ee842e2
// Params 0, eflags: 0x4
// Checksum 0xbbc1d8c5, Offset: 0x8a2
// Size: 0x9, Type: bool
function private canactivatefunc()
{
    return !br_public::function_73ed6e27eb5e7544();
}

// Namespace namespace_266026a83ee842e2
// Params 0, eflags: 0x4
// Checksum 0xcd6dbb31, Offset: 0x8b4
// Size: 0x89
function private activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_ROYALTY_WEAPON", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_ROYALTY_WEAPON", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_ROYALTY_WEAPON", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "BR_PUBLIC_EVENT_ROYALTY_WEAPON", 3, &function_d4acef179eb9f9b2 );
    utility::registersharedfunc( #"royalty", #"hash_35860c8514e61bd1", &function_1e454b1553dbe04 );
    utility::registersharedfunc( #"royalty", #"hash_39fddefef2334f9b", &function_397a71e8d523f7d2 );
}

// Namespace namespace_266026a83ee842e2
// Params 0, eflags: 0x4
// Checksum 0x6418586c, Offset: 0x945
// Size: 0x4d
function private activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activity_instance.var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( activity_instance );
    function_7f30a93f6172d466();
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace namespace_266026a83ee842e2
// Params 0, eflags: 0x4
// Checksum 0xf10550db, Offset: 0x99a
// Size: 0x2aa
function private function_7f30a93f6172d466()
{
    activity_instance = self;
    var_7bb241817fe75a50 = activity_instance.var_332f929de1894b2b;
    
    if ( !isdefined( level.royaltyweaponstruct ) )
    {
        level.royaltyweaponstruct = spawnstruct();
    }
    
    level.royaltyweaponstruct.var_934528bb6fb2f36 = var_7bb241817fe75a50.var_934528bb6fb2f36 ?? 13450;
    level.royaltyweaponstruct.var_3053cb191a06f71a = var_7bb241817fe75a50.var_3053cb191a06f71a ?? 7;
    level.royaltyweaponstruct.var_b0615b737e638e6c = utility::function_b104528d84ca3561( var_7bb241817fe75a50.var_b0615b737e638e6c ?? getdvar( @"hash_dd2eb0efcbbdaabb", "1,3,5" ), "," );
    level.royaltyweaponstruct.var_e63ff54092910a8e = utility::function_b104528d84ca3561( var_7bb241817fe75a50.var_e63ff54092910a8e ?? getdvar( @"hash_9bc41fbaa1a70fef", "1,2,3" ), "," );
    level.royaltyweaponstruct.var_1a8369ff1a22524c = utility::function_d2db822aceef856a( var_7bb241817fe75a50.var_1a8369ff1a22524c ?? getdvar( @"hash_a708041cc0b68785", "0.15,0.25,0.4" ), "," );
    level.royaltyweaponstruct.var_8aa6a2720bfb0796 = var_7bb241817fe75a50.var_8aa6a2720bfb0796 ?? 2400;
    level.royaltyweaponstruct.var_51c272459e6504c4 = var_7bb241817fe75a50.var_51c272459e6504c4 ?? 1575;
    level.royaltyweaponstruct.var_77c4119ccb95b85a = var_7bb241817fe75a50.var_77c4119ccb95b85a ?? 788;
    level.royaltyweaponstruct.var_b419afde9291d8d2 = utility::function_b104528d84ca3561( var_7bb241817fe75a50.var_b419afde9291d8d2 ?? getdvar( @"hash_fef9895a1cc04361", "1420,4250,7090" ), "," );
    level.royaltyweaponstruct.var_d6749e29b5094e5b = var_7bb241817fe75a50.var_d6749e29b5094e5b ?? 14000;
    level.royaltyweaponstruct.uavradius = var_7bb241817fe75a50.uavradius ?? 7000;
    level.royaltyweaponstruct.var_2a6a46f1e5442b6b = var_7bb241817fe75a50.var_2a6a46f1e5442b6b ?? 1500;
    level.royaltyweaponstruct.dropheight = var_7bb241817fe75a50.dropheight ?? 12000;
    level.royaltyweaponstruct.var_84b20951617728e4 = var_7bb241817fe75a50.var_84b20951617728e4 ?? 1000;
}

// Namespace namespace_266026a83ee842e2
// Params 0, eflags: 0x4
// Checksum 0x7af94a8a, Offset: 0xc4c
// Size: 0x1f4
function private function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    lootspawnlist = activity_instance.var_332f929de1894b2b.lootspawnlist ?? "br_royalty_weapon";
    var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( lootspawnlist );
    
    if ( isdefined( var_f67995529827f79.spawnlistname ) && isdefined( var_f67995529827f79.spawncount ) )
    {
        cachespawnlist = var_f67995529827f79.spawnlistname;
        spawncount = var_f67995529827f79.spawncount;
        var_8b5270de14dff72e = common_item::items_selectfromlist( cachespawnlist, spawncount );
        level.var_d5d7151ae2404da = var_8b5270de14dff72e[ randomint( var_8b5270de14dff72e.size ) ];
    }
    
    params = spawnstruct();
    params.intvar = function_a248e93ba82a3367( level.var_d5d7151ae2404da );
    level br_activity_util::displaysplashtoplayers( level.players, "br_pe_royaltyweapon_start", params );
    br_public::brleaderdialog( "plane_enters_space", 1, undefined, 0, 0, undefined, "dx_br_brrw_" );
    activitycustomproperties = activity_definition_utils::function_9129cd8075c85c09( self );
    leveldata = airdrop::getleveldata( "saw_airdrop_royalty_weapon" );
    leveldata.basemodel = activitycustomproperties.cratemodel ?? "military_carepackage_01_br_legendary_classified";
    leveldata.parachutemodel = activitycustomproperties.parachutemodel ?? "saw_mil_lnd_parachute_carepackage_br_classified";
    leveldata.minimapicon = "saw_ui_icon_splash_classified";
    leveldata.headicon = "saw_ui_icon_splash_classified";
    level thread utility::callsharedfunc( #"royalty", #"hash_35860c8514e61bd1", activity_instance );
    eventduration = activitycustomproperties.duration;
    br_activity_util::function_f255dbc3d969ce02( eventduration, 24 );
    activity_instance_common::endactivity( activity_instance, 1 );
}

// Namespace namespace_266026a83ee842e2
// Params 1, eflags: 0x4
// Checksum 0x599bc678, Offset: 0xe48
// Size: 0xac
function private function_a248e93ba82a3367( var_41e10c3dd6531c7f )
{
    var_3d9b7aae46198b03 = -1;
    
    if ( !isdefined( var_41e10c3dd6531c7f ) || var_41e10c3dd6531c7f == "" )
    {
        return var_3d9b7aae46198b03;
    }
    
    subtype = common_item::function_8fb8bfe0d9780c2e( var_41e10c3dd6531c7f );
    
    if ( subtype == "ar" )
    {
        var_3d9b7aae46198b03 = 0;
    }
    else if ( subtype == "sh" )
    {
        var_3d9b7aae46198b03 = 1;
    }
    else if ( subtype == "sn" )
    {
        var_3d9b7aae46198b03 = 2;
    }
    else if ( subtype == "dm" )
    {
        var_3d9b7aae46198b03 = 3;
    }
    else if ( subtype == "sm" )
    {
        var_3d9b7aae46198b03 = 5;
    }
    else if ( subtype == "lm" )
    {
        var_3d9b7aae46198b03 = 4;
    }
    
    return var_3d9b7aae46198b03;
}

// Namespace namespace_266026a83ee842e2
// Params 1, eflags: 0x4
// Checksum 0xc6e187b, Offset: 0xefd
// Size: 0x26
function private activity_ended( activity_succeeded )
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_266026a83ee842e2
// Params 0, eflags: 0x4
// Checksum 0x67e6d647, Offset: 0xf2b
// Size: 0x1c
function private function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace namespace_266026a83ee842e2
// Params 1
// Checksum 0x5df74d86, Offset: 0xf4f
// Size: 0x21, Type: bool
function function_2ac1cfe82f60b117( player )
{
    if ( !isdefined( player ) )
    {
        return false;
    }
    
    return isdefined( player.royaltyweaponobj );
}

// Namespace namespace_266026a83ee842e2
// Params 1
// Checksum 0x1703a288, Offset: 0xf79
// Size: 0x38, Type: bool
function function_397a71e8d523f7d2( weaponobj )
{
    player = self;
    
    if ( !isdefined( weaponobj ) || !isdefined( player ) )
    {
        return false;
    }
    
    return player.royaltyweaponobj == weaponobj;
}

// Namespace namespace_266026a83ee842e2
// Params 1, eflags: 0x4
// Checksum 0x160354f1, Offset: 0xfba
// Size: 0x12d
function private function_1e454b1553dbe04( crate )
{
    overridestruct = {};
    overridestruct.droporigin = br_circle::getnextsafecircleorigin() ?? ( 0, 0, 0 );
    overridestruct.dropheight = level.royaltyweaponstruct.dropheight;
    overridestruct.var_a04c79fab32daf76 = level.royaltyweaponstruct.var_84b20951617728e4;
    var_42a6d4e8eb3aba70 = int( gettime() / 1000 );
    cratesarray = airdrop_scriptbundle::startairdrop( "saw_airdrop_royalty_weapon", undefined, undefined, overridestruct );
    
    foreach ( crate in cratesarray )
    {
        crate.var_42a6d4e8eb3aba70 = var_42a6d4e8eb3aba70;
        crate.var_58ac12c2eaa40e31 = int( gettime() / 1000 );
    }
}

// Namespace namespace_266026a83ee842e2
// Params 1, eflags: 0x4
// Checksum 0x9194727c, Offset: 0x10ef
// Size: 0x95
function private function_621441c3b0533110( player )
{
    var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( "br_carryoverReward" );
    
    if ( isdefined( var_f67995529827f79.spawnlistname ) && isdefined( var_f67995529827f79.spawncount ) )
    {
        spawnlist = var_f67995529827f79.spawnlistname;
        spawncount = var_f67995529827f79.spawncount;
        spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
        common_item::function_38cde6a6acb68ea6( spawnlist, spawncount, spawnoptions );
    }
    
    player playsoundtoplayer( "uin_wz2_loot_container_open_epic", player );
}

// Namespace namespace_266026a83ee842e2
// Params 1, eflags: 0x4
// Checksum 0x3b55bbef, Offset: 0x118c
// Size: 0x93
function private function_ec8dc3a0678c3953( player )
{
    if ( self.var_f35655ccb06b4e7c )
    {
        return;
    }
    
    params = spawnstruct();
    params.intvar = function_a248e93ba82a3367( level.var_d5d7151ae2404da );
    level br_activity_util::displaysplashtoplayers( level.players, "br_pe_royaltyweapon_end", params );
    br_public::brleaderdialog( "crate_lands_ground", 1, undefined, 0, 0, undefined, "dx_br_brrw_" );
    self.var_732f773cb5c27585 = int( gettime() / 1000 );
    self.var_f35655ccb06b4e7c = 1;
}

// Namespace namespace_266026a83ee842e2
// Params 1, eflags: 0x4
// Checksum 0x76c7ae51, Offset: 0x1227
// Size: 0x17f
function private royaltyspawnweapon( crate )
{
    player = self;
    itembundle = getscriptbundle( level.var_d5d7151ae2404da );
    overridecount = 1;
    spawnoptions = common_item::items_initspawnoptions_spawnfromposition( crate.origin + ( 0, 0, 40 ), crate.angles );
    spawneditem = common_item::function_61c2c0251e742ffd( itembundle, overridecount, spawnoptions );
    spawneditem.isroyaltyweapon = 1;
    spawneditem.var_de25c8a26d4b507e = 1;
    player function_49fbd5f1b0b1bbe3( crate );
    wait 1.5;
    
    if ( !isdefined( spawneditem ) )
    {
        return;
    }
    
    id = objidpoolmanager::requestobjectiveid( 1 );
    spawneditem.royaltyobjectiveid = id;
    
    if ( id > -1 )
    {
        objidpoolmanager::objective_add_objective( id, "current", spawneditem.origin ?? spawnoptions.baseorigin, "saw_ui_icon_splash_classified" );
        objidpoolmanager::objective_set_play_intro( id, 0 );
        objective_addalltomask( id );
        objective_showtoplayersinmask( id );
        objective_setbackground( id, 1 );
        objective_setdescription( id, &"saw_classified_weapon/classified_weapon_name" );
        objective_setzoffset( id, 40 );
        function_ac9886e0e2860e18( id, level.royaltyweaponstruct.var_934528bb6fb2f36, level.royaltyweaponstruct.var_934528bb6fb2f36 + 550 );
        function_44a344c68a68f28d( id, 0 );
    }
}

// Namespace namespace_266026a83ee842e2
// Params 1, eflags: 0x4
// Checksum 0xb40617ed, Offset: 0x13ae
// Size: 0x4b0
function private royaltyweaponpickup( params )
{
    player = params.player;
    
    if ( !isdefined( params.instance ) || !params.instance.isroyaltyweapon || !isdefined( player ) )
    {
        return;
    }
    
    var_37857c8b8aed5390 = params.instance.var_de25c8a26d4b507e;
    var_273383de1d4a5408 = function_2ac1cfe82f60b117( player );
    player.royaltyweaponobj = params.objweapon;
    eventtype = var_37857c8b8aed5390 ? "pickup_first_time" : "pickup";
    player function_5932d7e0eb92925e( eventtype, params.objweapon.basename );
    player.var_e0fdb0117b61c2c9 = gettime();
    player thread function_9a6b89918817cdec();
    
    if ( isdefined( params.instance.royaltyobjectiveid ) )
    {
        objidpoolmanager::returnobjectiveid( params.instance.royaltyobjectiveid );
        params.instance.royaltyobjectiveid = undefined;
    }
    
    if ( !var_273383de1d4a5408 && !isdefined( player.var_d69291585b60436f ) )
    {
        circleent = spawnstruct();
        circleent.targetplayer = player;
        circleent game_utility::questcircle_create( "RoyaltyWeapon_Br_Held" );
        circleent function_9a7bfd29c0939106( circleent.targetplayer );
        circleent game_utility::function_d46d8731ed9d281( level.royaltyweaponstruct.var_8aa6a2720bfb0796 );
        circleent game_utility::questcircle_hidefromall();
        circleent thread function_23d99d84f94c5c58( player );
        circleent thread function_3d37d73fc2edfaa5( player );
        circleent thread function_91a7c24f0181ce3c( player );
        circleent thread function_6ffdbafbf00a948a( player );
        player.var_d69291585b60436f = circleent;
    }
    
    if ( !var_273383de1d4a5408 && isdefined( level.var_d846c03ec30479ec ) )
    {
        if ( isdefined( player.perks[ level.var_d846c03ec30479ec ] ) )
        {
            spawnoptions = common_item::items_initspawnoptions_spawnfromentity( player );
            player utility::callsharedfunc( #"perk", #"dropspecialist", spawnoptions );
            player utility::callsharedfunc( #"perk", #"removespecialist" );
        }
        
        player utility::callsharedfunc( #"perk", #"hash_74e8b5fc11eb5789", level.var_d846c03ec30479ec );
        player perk::giveperk( level.var_d846c03ec30479ec );
        player utility::callsharedfunc( #"perk", #"hash_ff6f8c52b04ef8c2" );
        specialistitem = common_item::function_77600f92048df72d( level.perkbundles[ level.var_d846c03ec30479ec ], 1 );
        itemdata = common_item::function_a48ae6cbf7e8c2d5( specialistitem );
        itemcount = 1;
        player thread common_item::function_29cda7adf128f6fb( level.perkbundles[ level.var_d846c03ec30479ec ], itemcount, itemdata );
    }
    
    if ( 0 && !var_273383de1d4a5408 && !player br_public::hasrespawntoken() )
    {
        player item_redeploy_token::function_190ce3e2e0f50a8a();
    }
    
    if ( var_37857c8b8aed5390 )
    {
        player thread function_d9b5a70946614f7e( params.objweapon );
        params.instance.var_de25c8a26d4b507e = undefined;
        holderreference = [ player ];
        teammates = level.teamdata[ player.team ][ "players" ];
        enemies = level.players;
        enemies = arrayremove( enemies, teammates );
        teammates = arrayremove( teammates, holderreference );
        br_public::brleaderdialog( "ally_pick_up", 1, holderreference, undefined, 0, undefined, "dx_br_brrw_" );
        br_public::brleaderdialog( "player_pick_up", 1, teammates, undefined, 0, undefined, "dx_br_brrw_" );
        br_public::brleaderdialog( "enemy_pick_up", 1, enemies, undefined, 0, undefined, "dx_br_brrw_" );
    }
    
    aliveteammates = level.teamdata[ player.team ][ "alivePlayers" ];
    aliveteammates = arrayremove( aliveteammates, player );
    allplayers = level.players;
    allplayers = arrayremove( allplayers, player );
    var_9dd7745b69674a91 = var_37857c8b8aed5390 ? allplayers : aliveteammates;
    paramssplash = spawnstruct();
    paramssplash.playerforplayercard = player;
    level br_activity_util::displaysplashtoplayers( var_9dd7745b69674a91, "br_pe_royaltyweapon_pickup", params );
    level notify( #"royaltyweaponpickedup" );
    
    if ( !var_273383de1d4a5408 )
    {
        player thread function_edbdc9e9b86c9897();
    }
}

// Namespace namespace_266026a83ee842e2
// Params 0, eflags: 0x4
// Checksum 0x6ac09f80, Offset: 0x1866
// Size: 0xc0
function private function_9a6b89918817cdec()
{
    player = self;
    level endon( #"game_ended" );
    player endon( #"hash_1499fb234fcd392f" );
    
    while ( true )
    {
        player waittill( #"weapon_change" );
        
        if ( !player function_397a71e8d523f7d2( player getcurrentweapon() ) )
        {
            if ( isdefined( player.var_e0fdb0117b61c2c9 ) )
            {
                if ( !isdefined( player.var_d8ecd7c472dc1d16 ) )
                {
                    player.var_d8ecd7c472dc1d16 = 0;
                }
                
                player.var_d8ecd7c472dc1d16 += gettime() - player.var_e0fdb0117b61c2c9;
                player.var_e0fdb0117b61c2c9 = undefined;
            }
            
            continue;
        }
        
        player.var_e0fdb0117b61c2c9 = gettime();
    }
}

// Namespace namespace_266026a83ee842e2
// Params 1, eflags: 0x4
// Checksum 0xa49418a8, Offset: 0x192e
// Size: 0xc6
function private function_d9b5a70946614f7e( objweapon )
{
    player = self;
    waitframe();
    var_4b0079de11bf5c6a = weaponmaxammo( objweapon ) - player getweaponammostock( objweapon ) + weaponclipsize( objweapon ) - player getweaponammoclip( objweapon );
    player setweaponammoclip( objweapon, weaponclipsize( objweapon ) );
    player setweaponammostock( objweapon, weaponmaxammo( objweapon ) );
    ammotype = item_ammo::function_b162feeed34a4640( objweapon );
    itembundle = common_item::function_80af1e9daffacc7d( ammotype );
    ammoitem = common_item::function_77600f92048df72d( itembundle, 1 );
    itemdata = common_item::function_a48ae6cbf7e8c2d5( ammoitem );
    itemcount = var_4b0079de11bf5c6a ?? 300;
    player thread common_item::function_29cda7adf128f6fb( itembundle, itemcount, itemdata );
}

// Namespace namespace_266026a83ee842e2
// Params 0, eflags: 0x4
// Checksum 0x77785c1b, Offset: 0x19fc
// Size: 0xe6
function private function_edbdc9e9b86c9897()
{
    player = self;
    level endon( #"game_ended" );
    player endon( #"hash_1499fb234fcd392f" );
    wait 4;
    
    while ( function_2ac1cfe82f60b117( player ) )
    {
        var_2ea137e4de0a7bc3 = player.var_4faf9703bb76fa2d ?? 0;
        var_2c5eb08c8bdd3c00 = level.activeadvanceduavs[ player.team ];
        
        if ( var_2ea137e4de0a7bc3 <= 0 && var_2c5eb08c8bdd3c00 <= 0 )
        {
            var_f00004f256641d01 = level.royaltyweaponstruct.uavradius;
            var_e6a7eafbbb470f6c = level.royaltyweaponstruct.var_2a6a46f1e5442b6b;
            triggerportableradarpingteam( player.origin, player.team, int( var_f00004f256641d01 ), int( var_e6a7eafbbb470f6c ), -1 );
        }
        
        wait 7;
    }
}

// Namespace namespace_266026a83ee842e2
// Params 1, eflags: 0x4
// Checksum 0x753cbd31, Offset: 0x1aea
// Size: 0x78
function private function_9a7bfd29c0939106( player )
{
    circle_radius = 900;
    circle_range_min = 250;
    circle_range_max = 600;
    search_location = ( player.origin[ 0 ], player.origin[ 1 ], circle_radius );
    search_location += math::random_vector_2d() * randomfloatrange( circle_range_min, circle_range_max );
    game_utility::questcircle_move( search_location );
}

// Namespace namespace_266026a83ee842e2
// Params 1, eflags: 0x4
// Checksum 0x2a1c4713, Offset: 0x1b6a
// Size: 0x60
function private function_23d99d84f94c5c58( player )
{
    level endon( #"game_ended" );
    player endon( #"hash_1499fb234fcd392f" );
    
    while ( function_2ac1cfe82f60b117( player ) )
    {
        function_9a7bfd29c0939106( player );
        wait level.royaltyweaponstruct.var_3053cb191a06f71a - ( player.var_bc4e1f54f450ef57 ?? 0 );
    }
}

// Namespace namespace_266026a83ee842e2
// Params 1, eflags: 0x4
// Checksum 0x646e4a27, Offset: 0x1bd2
// Size: 0x13b
function private function_3d37d73fc2edfaa5( player )
{
    level endon( #"game_ended" );
    player endon( #"hash_1499fb234fcd392f" );
    
    while ( function_2ac1cfe82f60b117( player ) )
    {
        game_utility::questcircle_hidefromall();
        var_240edd04ac974884 = level.royaltyweaponstruct.var_d6749e29b5094e5b + ( player.var_ae0f34cba132e23c ?? 0 );
        var_9933b0cd854b77c1 = getplayersinradius( player.origin, var_240edd04ac974884 );
        var_9933b0cd854b77c1 = arrayremove( var_9933b0cd854b77c1, level.teamdata[ player.team ][ "players" ] );
        
        foreach ( enemy in var_9933b0cd854b77c1 )
        {
            game_utility::questcircle_showtoplayer( enemy );
        }
        
        wait level.royaltyweaponstruct.var_3053cb191a06f71a - ( player.var_bc4e1f54f450ef57 ?? 0 );
    }
}

// Namespace namespace_266026a83ee842e2
// Params 1, eflags: 0x4
// Checksum 0x7a49dac2, Offset: 0x1d15
// Size: 0x127
function private function_91a7c24f0181ce3c( player )
{
    level endon( #"game_ended" );
    player endon( #"hash_1499fb234fcd392f" );
    circleindex = level.br_circle.circleindex;
    
    if ( !isdefined( circleindex ) )
    {
        game_utility::function_d46d8731ed9d281( level.royaltyweaponstruct.var_8aa6a2720bfb0796 );
        return;
    }
    
    while ( function_2ac1cfe82f60b117( player ) )
    {
        circleindex = level.br_circle.circleindex;
        
        if ( circleindex >= 6 )
        {
            radiussize = level.royaltyweaponstruct.var_77c4119ccb95b85a;
        }
        else if ( circleindex >= 4 )
        {
            radiussize = level.royaltyweaponstruct.var_51c272459e6504c4;
        }
        else
        {
            radiussize = level.royaltyweaponstruct.var_8aa6a2720bfb0796;
        }
        
        if ( player.royaltyweaponcircleradius )
        {
            radiussize *= 1 - player.royaltyweaponcircleradius;
        }
        
        game_utility::function_d46d8731ed9d281( radiussize );
        utility::waittill_any_ents_return_params( level, "br_circle_set", player, "royaltyWeaponHolderKill" );
    }
}

// Namespace namespace_266026a83ee842e2
// Params 1, eflags: 0x4
// Checksum 0x3cad94fa, Offset: 0x1e44
// Size: 0x21
function private function_6ffdbafbf00a948a( player )
{
    player waittill( #"hash_1499fb234fcd392f" );
    game_utility::questcircle_delete();
}

// Namespace namespace_266026a83ee842e2
// Params 1, eflags: 0x4
// Checksum 0xced62f27, Offset: 0x1e6d
// Size: 0xeb
function private function_7777c2710b3f61d9( params )
{
    player = self;
    
    if ( function_2ac1cfe82f60b117( player ) )
    {
        currentweapons = player getweaponslistprimaries();
        
        foreach ( weapon in currentweapons )
        {
            if ( player.royaltyweaponobj == weapon )
            {
                spawnoptions = common_item::items_initspawnoptions_spawnfromentity( self );
                spawnoptions.isdeathevent = 1;
                player item_weapon::items_weapon_removeweapon( { #spawnoptions:spawnoptions, #weapon:weapon } );
            }
        }
    }
}

// Namespace namespace_266026a83ee842e2
// Params 1, eflags: 0x4
// Checksum 0xc3dcf44a, Offset: 0x1f60
// Size: 0x2aa
function private royaltyweapondrop( params )
{
    player = self;
    
    if ( !isdefined( params.instance ) || !isdefined( player ) || !function_2ac1cfe82f60b117( player ) || !params.weapon.baseweaponlootid )
    {
        return;
    }
    
    if ( !player function_397a71e8d523f7d2( params.weapon ) )
    {
        return;
    }
    
    params.instance.isroyaltyweapon = 1;
    params.instance.critical = 1;
    player.royaltyweaponobj = undefined;
    player.var_d69291585b60436f = undefined;
    player notify( #"hash_1499fb234fcd392f" );
    id = objidpoolmanager::requestobjectiveid( 1 );
    
    if ( id > -1 )
    {
        objidpoolmanager::objective_add_objective( id, "current", params.instance.var_f3441fa93d95027a.finalorigin ?? params.instance.origin, "saw_ui_icon_splash_classified" );
        objidpoolmanager::objective_set_play_intro( id, 0 );
        objective_addalltomask( id );
        objective_showtoplayersinmask( id );
        objective_setbackground( id, 1 );
        objective_setdescription( id, &"saw_classified_weapon/classified_weapon_name" );
        objective_setzoffset( id, 40 );
        function_ac9886e0e2860e18( id, level.royaltyweaponstruct.var_934528bb6fb2f36, level.royaltyweaponstruct.var_934528bb6fb2f36 + 550 );
        function_44a344c68a68f28d( id, 0 );
    }
    
    if ( 0 && player br_public::hasrespawntoken() )
    {
        player item_redeploy_token::function_16ab0a48337237ef( 1 );
    }
    
    params.instance.royaltyobjectiveid = id;
    player utility::callsharedfunc( #"perk", #"removespecialist" );
    player utility::callsharedfunc( #"perk", #"hash_ff6f8c52b04ef8c2" );
    eventtype = player::isreallyalive( player ) ? "drop" : "drop_death";
    
    if ( isdefined( player.var_e0fdb0117b61c2c9 ) )
    {
        if ( !isdefined( player.var_d8ecd7c472dc1d16 ) )
        {
            player.var_d8ecd7c472dc1d16 = 0;
        }
        
        player.var_d8ecd7c472dc1d16 += gettime() - player.var_e0fdb0117b61c2c9;
    }
    
    player function_5932d7e0eb92925e( eventtype, params.weapon.basename );
    level thread function_75c2b615e65e6e20( params.instance );
}

// Namespace namespace_266026a83ee842e2
// Params 1, eflags: 0x4
// Checksum 0xc921d9e1, Offset: 0x2212
// Size: 0x123
function private function_75c2b615e65e6e20( weaponinstance )
{
    player = self;
    level endon( #"royaltyweaponpickedup" );
    level endon( #"game_ended" );
    var_300e731799ff16d3 = level.royaltyweaponstruct.var_7ee824591908dd21[ 0 ] > 0;
    var_586be67d7aca15a = level.royaltyweaponstruct.var_7ee824591908dd21[ 1 ];
    
    while ( true )
    {
        var_89ed9f13198e75fe = scriptable_group_spatial::is_instance_in_gas( weaponinstance );
        var_91a3b97c37a023ae = outofbounds::ispointinoutofbounds( weaponinstance.origin );
        var_fcc73ccf2b823962 = var_89ed9f13198e75fe || var_91a3b97c37a023ae;
        
        if ( var_fcc73ccf2b823962 )
        {
            weaponinstance freescriptable();
            objidpoolmanager::returnobjectiveid( weaponinstance.royaltyobjectiveid );
            currentcircleindex = level.br_circle.circleindex ?? -1;
            var_5d500340ef746827 = var_300e731799ff16d3 && var_fcc73ccf2b823962 && currentcircleindex <= var_586be67d7aca15a;
            
            if ( var_5d500340ef746827 )
            {
                royaltyweaponrespawn();
            }
            
            return;
        }
        
        wait 1;
    }
}

// Namespace namespace_266026a83ee842e2
// Params 0, eflags: 0x4
// Checksum 0x39992e72, Offset: 0x233d
// Size: 0x10f
function private royaltyweaponrespawn()
{
    player = self;
    deflist = activity_definition_utils::function_326a5e04c9b438f5( "BR_PUBLIC_EVENT_ROYALTY_WEAPON" );
    
    if ( deflist.size == 0 )
    {
        return;
    }
    
    variantlist = [];
    
    foreach ( variant, def in deflist )
    {
        variantlist[ variantlist.size ] = variant;
    }
    
    foreach ( variant in variantlist )
    {
        activity_instance_common::function_9b387cb1af0d5b4b( variant );
        return;
    }
}

// Namespace namespace_266026a83ee842e2
// Params 1, eflags: 0x4
// Checksum 0x523fc31b, Offset: 0x2454
// Size: 0x8e
function private function_d8957f2712fd72c8( params )
{
    player = self;
    
    if ( function_2ac1cfe82f60b117( player ) )
    {
        player utility::callsharedfunc( #"perk", #"removespecialist" );
        player utility::callsharedfunc( #"perk", #"hash_ff6f8c52b04ef8c2" );
    }
    
    attacker = params.attacker;
    
    if ( attacker && function_2ac1cfe82f60b117( attacker ) )
    {
        player.var_e25b36cb2efc2c0d = 1;
    }
}

// Namespace namespace_266026a83ee842e2
// Params 1, eflags: 0x4
// Checksum 0x44b0200e, Offset: 0x24ea
// Size: 0x7e
function private onkillstreakbeginuse( params )
{
    player = params.streakinfo.owner;
    streakname = params.streakinfo.streakname;
    
    if ( streakname == "uav" )
    {
        if ( !isdefined( player.var_4faf9703bb76fa2d ) )
        {
            player.var_4faf9703bb76fa2d = 0;
        }
        
        player.var_4faf9703bb76fa2d++;
    }
}

// Namespace namespace_266026a83ee842e2
// Params 1, eflags: 0x4
// Checksum 0x5b8410f7, Offset: 0x2570
// Size: 0x73
function private function_c35bf7a73f65a349( params )
{
    player = params.streakinfo.owner;
    streakname = params.streakinfo.streakname;
    
    if ( isdefined( player.var_4faf9703bb76fa2d ) && streakname == "uav" )
    {
        player.var_4faf9703bb76fa2d--;
    }
}

// Namespace namespace_266026a83ee842e2
// Params 1, eflags: 0x4
// Checksum 0xc1a83b05, Offset: 0x25eb
// Size: 0xf5
function private function_c614aaeb1d4d8bc6( params )
{
    player = self;
    
    if ( function_2ac1cfe82f60b117( player ) )
    {
        if ( params.revived )
        {
            player perk::giveperk( level.var_d846c03ec30479ec );
            player utility::callsharedfunc( #"perk", #"hash_ff6f8c52b04ef8c2" );
        }
        else
        {
            if ( level.royaltyweaponstruct.var_87aabc2d68ae365c == 0 )
            {
                return;
            }
            
            if ( level.royaltyweaponstruct.var_87aabc2d68ae365c == 1 )
            {
                var_4f870f86d63d7fe6 = getplayersinradius( player.origin, 17700 );
            }
            else
            {
                var_4f870f86d63d7fe6 = level.players;
            }
            
            level br_activity_util::displaysplashtoplayers( var_4f870f86d63d7fe6, "br_pe_royaltyweapon_drop" );
        }
    }
    
    if ( params.revived && player.var_e25b36cb2efc2c0d )
    {
        player.var_e25b36cb2efc2c0d = undefined;
    }
}

// Namespace namespace_266026a83ee842e2
// Params 1, eflags: 0x4
// Checksum 0xe815315d, Offset: 0x26e8
// Size: 0x17b
function private onplayerdeath( params )
{
    attacker = params.attacker ?? params.eattacker;
    victim = params.victim;
    
    if ( level.royaltyweaponstruct.var_f6b881139e7cf6ae && function_2ac1cfe82f60b117( attacker ) )
    {
        if ( !isdefined( attacker.royaltyweaponkills ) )
        {
            attacker.royaltyweaponkills = 0;
        }
        
        attacker.royaltyweaponkills++;
        var_b51f04b52d497249 = -1;
        
        for ( i = 0; i < level.royaltyweaponstruct.var_b0615b737e638e6c.size ; i++ )
        {
            if ( attacker.royaltyweaponkills >= level.royaltyweaponstruct.var_b0615b737e638e6c[ i ] )
            {
                var_b51f04b52d497249 = i;
            }
        }
        
        attacker.royaltyweaponcircleradius = level.royaltyweaponstruct.var_1a8369ff1a22524c[ var_b51f04b52d497249 ];
        attacker.var_bc4e1f54f450ef57 = level.royaltyweaponstruct.var_e63ff54092910a8e[ var_b51f04b52d497249 ];
        attacker.var_ae0f34cba132e23c = level.royaltyweaponstruct.var_b419afde9291d8d2[ var_b51f04b52d497249 ];
        attacker notify( #"royaltyWeaponHolderKill" );
    }
    
    if ( victim.var_e25b36cb2efc2c0d )
    {
        victim.var_e25b36cb2efc2c0d = undefined;
    }
}

// Namespace namespace_266026a83ee842e2
// Params 1, eflags: 0x4
// Checksum 0xa77e23f3, Offset: 0x286b
// Size: 0x5a
function private function_40b3e153303d109b( params )
{
    player = self;
    
    if ( function_2ac1cfe82f60b117( player ) )
    {
        player utility::callsharedfunc( #"perk", #"removespecialist" );
        player utility::callsharedfunc( #"perk", #"hash_ff6f8c52b04ef8c2" );
    }
}

// Namespace namespace_266026a83ee842e2
// Params 1, eflags: 0x4
// Checksum 0x6b7b954d, Offset: 0x28cd
// Size: 0xbe
function private onplayerdamaged( params )
{
    attacker = params.eattacker;
    victim = self;
    
    if ( 1 || !isplayer( attacker ) || !isdefined( victim ) || attacker == victim )
    {
        return;
    }
    
    if ( function_2ac1cfe82f60b117( attacker ) && ( params.shitloc == "head" || params.shitloc == "helmet" ) )
    {
        playerweap = attacker getcurrentweapon();
        
        if ( attacker function_397a71e8d523f7d2( playerweap ) )
        {
            currentammo = attacker getweaponammoclip( playerweap );
            attacker setweaponammoclip( playerweap, currentammo + 1 );
        }
    }
}

// Namespace namespace_266026a83ee842e2
// Params 1, eflags: 0x4
// Checksum 0xb5593ef5, Offset: 0x2993
// Size: 0x2a5
function private function_49fbd5f1b0b1bbe3( crate )
{
    player = self;
    playersalive = [];
    
    foreach ( player in level.players )
    {
        if ( player::isreallyalive( player ) )
        {
            playersalive[ playersalive.size ] = player;
        }
    }
    
    teamsalive = [];
    activeteams = [];
    
    for ( i = 0; i < playersalive.size ; i++ )
    {
        player = playersalive[ i ];
        
        if ( !isdefined( activeteams[ player.team ] ) )
        {
            activeteams[ player.team ] = 1;
            teamsalive[ teamsalive.size ] = player.team;
        }
    }
    
    eventparams = [];
    eventparams[ eventparams.size ] = "plane_spawning_time";
    eventparams[ eventparams.size ] = crate.var_42a6d4e8eb3aba70 ?? -1;
    eventparams[ eventparams.size ] = "crate_spawning_time";
    eventparams[ eventparams.size ] = crate.var_58ac12c2eaa40e31 ?? -1;
    eventparams[ eventparams.size ] = "crate_landing_time";
    eventparams[ eventparams.size ] = crate.var_732f773cb5c27585 ?? -1;
    eventparams[ eventparams.size ] = "crate_open_time";
    eventparams[ eventparams.size ] = int( gettime() / 1000 ) ?? -1;
    eventparams[ eventparams.size ] = "crate_x";
    eventparams[ eventparams.size ] = crate.origin[ 0 ] ?? -1;
    eventparams[ eventparams.size ] = "crate_y";
    eventparams[ eventparams.size ] = crate.origin[ 1 ] ?? -1;
    eventparams[ eventparams.size ] = "crate_z";
    eventparams[ eventparams.size ] = crate.origin[ 2 ] ?? -1;
    eventparams[ eventparams.size ] = "is_crate_in_water";
    eventparams[ eventparams.size ] = crate.inwater ?? 0;
    eventparams[ eventparams.size ] = "circle_index";
    eventparams[ eventparams.size ] = level.br_circle.circleindex ?? -1;
    eventparams[ eventparams.size ] = "number_players_alive";
    eventparams[ eventparams.size ] = playersalive.size ?? -1;
    eventparams[ eventparams.size ] = "number_teams_alive";
    eventparams[ eventparams.size ] = teamsalive.size ?? -1;
    eventparams[ eventparams.size ] = "playlist_name";
    eventparams[ eventparams.size ] = getplaylistname() ?? "";
    player dlog_recordplayerevent( "dlog_event_br_royalty_weapon_crate_open", eventparams );
}

// Namespace namespace_266026a83ee842e2
// Params 2, eflags: 0x4
// Checksum 0x3ac1500d, Offset: 0x2c40
// Size: 0x244
function private function_5932d7e0eb92925e( eventtype, weaponname )
{
    player = self;
    keys = getarraykeys( player.perks );
    perkstring = ( player.perks.size ?? 0 ) + " ";
    
    for ( i = 0; i < keys.size ; i++ )
    {
        perk = keys[ i ];
        perk = getsubstr( perk, 10 );
        
        if ( perkstring == ( player.perks.size ?? 0 ) + " " )
        {
            perkstring = perk;
            continue;
        }
        
        perkstring += ", " + perk;
    }
    
    eventparams = [];
    eventparams[ eventparams.size ] = "event_type";
    eventparams[ eventparams.size ] = eventtype ?? "";
    eventparams[ eventparams.size ] = "weapon_name";
    eventparams[ eventparams.size ] = weaponname ?? "";
    eventparams[ eventparams.size ] = "server_time";
    eventparams[ eventparams.size ] = int( gettime() / 1000 ) ?? -1;
    eventparams[ eventparams.size ] = "player_perks";
    eventparams[ eventparams.size ] = perkstring ?? "";
    eventparams[ eventparams.size ] = "player_x";
    eventparams[ eventparams.size ] = player.origin[ 0 ] ?? -1;
    eventparams[ eventparams.size ] = "player_y";
    eventparams[ eventparams.size ] = player.origin[ 1 ] ?? -1;
    eventparams[ eventparams.size ] = "player_z";
    eventparams[ eventparams.size ] = player.origin[ 2 ] ?? -1;
    eventparams[ eventparams.size ] = "kills_player_has_now";
    eventparams[ eventparams.size ] = player.pers[ "telemetry" ].eliminations ?? -1;
    eventparams[ eventparams.size ] = "time_held_royalty_weapon_out";
    eventparams[ eventparams.size ] = int( ( player.var_d8ecd7c472dc1d16 ?? 0 ) / 1000 ) ?? -1;
    eventparams[ eventparams.size ] = "playlist_name";
    eventparams[ eventparams.size ] = getplaylistname() ?? "";
    player dlog_recordplayerevent( "dlog_event_br_royalty_weapon_event", eventparams );
    player.var_e0fdb0117b61c2c9 = undefined;
    player.var_d8ecd7c472dc1d16 = undefined;
}

/#

    // Namespace namespace_266026a83ee842e2
    // Params 0
    // Checksum 0x21460e5a, Offset: 0x2e8c
    // Size: 0x5, Type: dev
    function __debug()
    {
        
    }

    // Namespace namespace_266026a83ee842e2
    // Params 0, eflags: 0x4
    // Checksum 0x39f41ca4, Offset: 0x2e99
    // Size: 0x2e, Type: dev
    function private debug_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x36>", "<dev string:x48>", &debug_start_event );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_266026a83ee842e2
    // Params 0, eflags: 0x4
    // Checksum 0x51004604, Offset: 0x2ecf
    // Size: 0x43, Type: dev
    function private debug_start_event()
    {
        gametype = game_utility::getgametype();
        publiceventtype = gametype == "<dev string:x65>" ? "<dev string:x70>" : "<dev string:x9a>";
        level thread br_publicevents::function_3cacd19bcd0bc75b( publiceventtype );
    }

#/
