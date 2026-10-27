// script_1cee1a5a4bff028c  (hash_1cee1a5a4bff028c.gscc) (size: 22327 Bytes / 0x5737 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa300c400 (2734736384)
// size ...... 22327 (0x5737)
// includes .. 23  (offset: 0x53b3)
// strings ... 36  (offset: 0x546b)
// dev strs .. 15  (offset: 0x567b)
// exports ... 53  (offset: 0x38bf)
// cseg ...... 0x2b7 + 0x3608 (0x38bf)
// imports ... 153 (offset: 0x4107)
// animtree1 . 0   (offset: 0x5737)
// animtree2 . 0   (offset: 0x5737)
#using script_294e8d1ebcb1de03;
#using script_6f0f2451a4e38c15;
#using script_a21e0b6e7d19063;
#using scripts\common\activity_nexus\activity_common;
#using scripts\common\activity_nexus\activity_definition_utils;
#using scripts\common\activity_nexus\activity_instance_common;
#using scripts\common\activity_nexus\activity_participation;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\omnvar_utility;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_inventory;
#using scripts\mp\loot\common_item;
#using scripts\mp\objidpoolmanager;

#namespace activity_br_item_extraction;

// Namespace activity_br_item_extraction
// Params 0, eflags: 0x5
// Checksum 0xb3b45f43, Offset: 0x2d5
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"activity_br_item_extraction", #"activity_common", &function_538033a540e63c70, undefined );
}

// Namespace activity_br_item_extraction
// Params 0, eflags: 0x4
// Checksum 0x9b3a4499, Offset: 0x2fe
// Size: 0x13
function private function_538033a540e63c70()
{
    activity_common::registeractivitytype( "BR_ITEM_EXTRACTION", &activity_type_init );
}

// Namespace activity_br_item_extraction
// Params 0
// Checksum 0x3b67817, Offset: 0x319
// Size: 0x14b
function activity_type_init()
{
    activity_common::function_944074f3079c1d4e( "BR_ITEM_EXTRACTION", 0, &activity_setup );
    activity_common::function_944074f3079c1d4e( "BR_ITEM_EXTRACTION", 1, &function_477932e3884ea1fd );
    activity_common::function_944074f3079c1d4e( "BR_ITEM_EXTRACTION", 2, &activity_ended );
    activity_common::function_944074f3079c1d4e( "BR_ITEM_EXTRACTION", 3, &function_d4acef179eb9f9b2 );
    activity_common::function_2dd4f07fa5c3e911( "PlayerJoin", &player_joined_activity, "BR_ITEM_EXTRACTION" );
    activity_common::function_2dd4f07fa5c3e911( "PlayerLeave", &player_left_activity, "BR_ITEM_EXTRACTION" );
    
    if ( !isdefined( level.activity_br_item_extraction ) )
    {
        level.activity_br_item_extraction = {};
    }
    
    if ( !isdefined( level.activity_br_item_extraction.var_4af0992a19ca4ea3 ) )
    {
        level.activity_br_item_extraction.var_4af0992a19ca4ea3 = [];
    }
    
    level.activity_br_item_extraction.var_f8c35c185a5850fa = 0;
    elite_ironclad_dialogs::init();
    register_activity_variant_definition( "wz_sat_activity_elite_ironclad_item_extraction", "BR_ITEM_EXTRACTION" + "_IRONCLAD_VARIANT", 1 );
    br_extraction_heli::init();
    scriptable::scriptable_addusedcallback( &function_6a60a6d3a8f61c4b );
    level callback::add( #"player_item_pickup", &on_item_pickup );
    level callback::add( #"player_item_drop", &function_40d1ae0558dff795 );
    level callback::add( #"hash_28245a6d2061f779", &function_5539d745896a3e95 );
    init_dev_gui();
}

// Namespace activity_br_item_extraction
// Params 3, eflags: 0x4
// Checksum 0x479e8d42, Offset: 0x46c
// Size: 0x199
function private register_activity_variant_definition( var_ae0304b47d4d08f, base_variant, var_9bca08d7b929df32 )
{
    activity_definition_utils::function_74af1ab4059e3c06( var_ae0304b47d4d08f, base_variant );
    activity_definition = hashcat( %"activitydefinition:", var_ae0304b47d4d08f );
    var_cd6d759b2c772946 = getscriptbundle( activity_definition );
    
    if ( var_cd6d759b2c772946 )
    {
        custom_properties = activity_definition_utils::function_9129cd8075c85c09( var_cd6d759b2c772946 );
        
        if ( custom_properties )
        {
            foreach ( config in custom_properties.extractionpoint.var_b59ac5ef3d4327ca )
            {
                var_e1b39de90a62f3a0 = { #var_5528f3a78ba13fd:config.var_fad3d4498c4629ea, #most_wanted_delay:config.var_573e625340496906, #most_wanted_visual:config.var_a9b788afade39d4f, #marker_image:config.var_3e005c33c41ff58, #var_9bca08d7b929df32:var_9bca08d7b929df32, #activity_variant:base_variant, #var_30fb0dee6ae5648:config.itemspawnentry };
                level.activity_br_item_extraction.var_4af0992a19ca4ea3[ level.activity_br_item_extraction.var_4af0992a19ca4ea3.size ] = var_e1b39de90a62f3a0;
            }
        }
    }
}

// Namespace activity_br_item_extraction
// Params 0
// Checksum 0xb261853f, Offset: 0x60d
// Size: 0x6e
function activity_setup()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    if ( !isdefined( activity_instance.var_332f929de1894b2b ) )
    {
        activity_instance.var_332f929de1894b2b = activity_definition_utils::function_9129cd8075c85c09( activity_instance );
    }
    
    activity_instance.analytics = { #start_time:gettime() };
    activity_instance_common::function_46135a69bddfec2c( activity_instance );
}

// Namespace activity_br_item_extraction
// Params 0
// Checksum 0xb0cf32cd, Offset: 0x683
// Size: 0x137
function function_477932e3884ea1fd()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    activating_player = activity_instance.playerparticipants[ 0 ];
    activity_instance.team = activating_player.team;
    activity_instance.extraction_completed = 0;
    
    foreach ( item in level.activity_br_item_extraction.var_4af0992a19ca4ea3 )
    {
        optional_params = { #most_wanted_delay:item.most_wanted_delay, #most_wanted_visual:item.most_wanted_visual };
        namespace_44f3cc5922e3a432::function_39c5432728e178d7( activity_instance, item.var_30fb0dee6ae5648, item.marker_image, optional_params );
    }
    
    thread function_650c08f48b281412();
}

// Namespace activity_br_item_extraction
// Params 0, eflags: 0x4
// Checksum 0x71c74d6a, Offset: 0x7c2
// Size: 0x279
function private function_650c08f48b281412()
{
    activity_instance = self;
    activity_instance endon( #"activity_ended" );
    activity_instance endon( #"instance_destroyed" );
    
    while ( true )
    {
        foreach ( site in level.var_b0df233e1945b2d5 )
        {
            currentparticipants = self.playerparticipants;
            var_dfb98770582d70f0 = 0;
            
            foreach ( player in currentparticipants )
            {
                if ( function_ddc61045c1a24138( player, site.var_52b44a1dde5e0fc, activity_instance.var_332f929de1894b2b ) )
                {
                    var_dfb98770582d70f0 = 1;
                    break;
                }
            }
            
            if ( !var_dfb98770582d70f0 )
            {
                function_4dc91baf7a990985( site, activity_instance.team );
            }
        }
        
        if ( !function_de5175e57ae31c13( activity_instance.var_332f929de1894b2b ) )
        {
            activating_player = activity_instance.playerparticipants[ 0 ];
            
            if ( activating_player )
            {
                foreach ( id in level.activity_br_item_extraction.var_4af0992a19ca4ea3 )
                {
                    activating_player function_3f77cca03aad1c97( activity_instance.var_332f929de1894b2b, id.var_30fb0dee6ae5648, 0 );
                }
                
                level.teamdata[ activating_player.team ][ activity_instance.varianttag ] = undefined;
                function_67ff5226fe085ece( activating_player.team );
                activity_instance_common::endactivity( activity_instance, activity_instance.extraction_completed );
            }
        }
        
        wait 1;
    }
}

// Namespace activity_br_item_extraction
// Params 1, eflags: 0x4
// Checksum 0xae05f0cd, Offset: 0xa43
// Size: 0x37
function private get_extraction_site( valid_item_type )
{
    if ( !isdefined( level.var_b0df233e1945b2d5 ) )
    {
        level.var_b0df233e1945b2d5 = [];
    }
    
    return level.var_b0df233e1945b2d5[ valid_item_type.var_30fb0dee6ae5648 ];
}

// Namespace activity_br_item_extraction
// Params 3, eflags: 0x4
// Checksum 0xfc89f103, Offset: 0xa83
// Size: 0x1e9
function private function_e72f9829b437b69a( team, valid_item_type, activating_player_origin )
{
    activity_instance = self;
    variant_data = activity_instance.var_332f929de1894b2b;
    variant_tag = activity_instance.varianttag;
    selected_site = get_extraction_site( valid_item_type );
    
    if ( selected_site )
    {
        function_28c04d7ba3ac6285( selected_site, team );
        return selected_site;
    }
    
    var_273e7110f5838e2d = function_a87d35429879e73e();
    var_c00493a990fe968f = function_4eb8b071b23aa229( variant_data, activating_player_origin, variant_data.var_81e3e56e59ecbd49.var_de478ebe8ee1a747, variant_data.var_81e3e56e59ecbd49.var_4bd03a412257a615 );
    
    if ( !var_c00493a990fe968f.available_sites.size )
    {
        return;
    }
    
    selected_site = function_53c5309991671ec9( var_c00493a990fe968f.available_sites, activating_player_origin, var_273e7110f5838e2d, variant_data );
    
    if ( !isdefined( selected_site ) )
    {
        return;
    }
    
    selected_site.var_38bd5898b3e30d3b = function_15f3abc96be8be8e( variant_data, valid_item_type.var_30fb0dee6ae5648 );
    selected_site setscriptablepartstate( variant_data.extractionpoint.var_38d5f40723870464, selected_site.var_38bd5898b3e30d3b.activatestate );
    selected_site.interact_hint_callback = &function_734106c4239b501c;
    selected_site.var_dc43d363f1de45af = &function_dc43d363f1de45af;
    selected_site.callback_heli_left = &callback_heli_left;
    selected_site.var_c2528ae64573b7a4 = &function_c2528ae64573b7a4;
    selected_site.var_106bc96555268bdf = &function_106bc96555268bdf;
    selected_site.var_7f332a185f67270d = variant_data;
    selected_site.var_40e83f8afde1b0e5 = variant_tag;
    selected_site.var_52b44a1dde5e0fc = valid_item_type;
    function_28c04d7ba3ac6285( selected_site, team );
    level.var_b0df233e1945b2d5[ valid_item_type.var_30fb0dee6ae5648 ] = selected_site;
    return selected_site;
}

// Namespace activity_br_item_extraction
// Params 2, eflags: 0x4
// Checksum 0xd2a5663a, Offset: 0xc75
// Size: 0x165
function private function_28c04d7ba3ac6285( selected_site, team )
{
    if ( !isdefined( selected_site.scriptedobjid ) )
    {
        selected_site.scriptedobjid = objidpoolmanager::requestobjectiveid( 1 );
        objidpoolmanager::objective_add_objective( selected_site.scriptedobjid, "active", selected_site.origin, selected_site.var_38bd5898b3e30d3b.var_bf8548a205a71f4d, "icon_large" );
        function_38b84cb3d4357dd7( selected_site.scriptedobjid );
        objective_setdescription( selected_site.scriptedobjid, selected_site.var_38bd5898b3e30d3b.var_87e946762e81546a );
        objective_setzoffset( selected_site.scriptedobjid, 200 );
        objective_setplayintro( selected_site.scriptedobjid, 1 );
        objidpoolmanager::function_7c18c3f099912ff7( selected_site.scriptedobjid, 1 );
        objidpoolmanager::function_9d4895ed38151e46( selected_site.scriptedobjid, 1 );
        objidpoolmanager::function_b1d5cb1069461e4f( selected_site.scriptedobjid, 1 );
        function_d41df5f2abfdf2b4( selected_site, selected_site.var_38bd5898b3e30d3b.var_3ded336bba8610f4 );
    }
    
    if ( isdefined( level.activity_br_item_extraction.excludeteam ) )
    {
        function_14dff8a9bef5bbc0( selected_site, level.activity_br_item_extraction.excludeteam );
    }
    
    function_14dff8a9bef5bbc0( selected_site, team );
}

// Namespace activity_br_item_extraction
// Params 2, eflags: 0x4
// Checksum 0x9c881a46, Offset: 0xde2
// Size: 0x9b
function private function_d41df5f2abfdf2b4( site, var_b161e87fdc906fdf )
{
    var_dc10495f590deded = ( 0, 0, 0 );
    var_dc01b6bac8d24e0 = var_b161e87fdc906fdf;
    var_21f669501225774f = strtok( var_dc01b6bac8d24e0, " " );
    var_dc10495f590deded = ( float( var_21f669501225774f[ 0 ] ) * 255, float( var_21f669501225774f[ 1 ] ) * 255, float( var_21f669501225774f[ 2 ] ) * 255 );
    objidpoolmanager::function_373aaf492aabde6f( site.scriptedobjid, int( var_dc10495f590deded[ 0 ] ), int( var_dc10495f590deded[ 1 ] ), int( var_dc10495f590deded[ 2 ] ) );
}

// Namespace activity_br_item_extraction
// Params 2, eflags: 0x4
// Checksum 0xbd3c3bf7, Offset: 0xe85
// Size: 0xb2
function private function_14dff8a9bef5bbc0( site, team )
{
    players = teams::getfriendlyplayers( team );
    
    foreach ( player in players )
    {
        objective_addclienttomask( site.scriptedobjid, player );
    }
    
    objective_showtoplayersinmask( site.scriptedobjid );
}

// Namespace activity_br_item_extraction
// Params 2, eflags: 0x4
// Checksum 0xd7fe86ac, Offset: 0xf3f
// Size: 0xb2
function private function_4dc91baf7a990985( site, team )
{
    players = teams::getfriendlyplayers( team );
    
    foreach ( player in players )
    {
        objective_removeclientfrommask( site.scriptedobjid, player );
    }
    
    objective_showtoplayersinmask( site.scriptedobjid );
}

// Namespace activity_br_item_extraction
// Params 1, eflags: 0x4
// Checksum 0x6858a27, Offset: 0xff9
// Size: 0x117
function private function_67ff5226fe085ece( team )
{
    foreach ( site in level.var_b0df233e1945b2d5 )
    {
        players = teams::getfriendlyplayers( team );
        
        foreach ( player in players )
        {
            objective_removeclientfrommask( site.scriptedobjid, player );
        }
        
        objective_showtoplayersinmask( site.scriptedobjid );
    }
}

// Namespace activity_br_item_extraction
// Params 0, eflags: 0x4
// Checksum 0x2a2fa6be, Offset: 0x1118
// Size: 0xb9
function private disable_extraction_site()
{
    if ( level.var_b0df233e1945b2d5 && level.var_b0df233e1945b2d5[ self.var_52b44a1dde5e0fc.var_30fb0dee6ae5648 ] )
    {
        site = level.var_b0df233e1945b2d5[ self.var_52b44a1dde5e0fc.var_30fb0dee6ae5648 ];
        site setscriptablepartstate( site.type, "hidden" );
        objective_delete( site.scriptedobjid );
        objidpoolmanager::returnobjectiveid( site.scriptedobjid );
        site.scriptedobjid = undefined;
        level.var_b0df233e1945b2d5[ self.var_52b44a1dde5e0fc.var_30fb0dee6ae5648 ] = undefined;
    }
}

// Namespace activity_br_item_extraction
// Params 4, eflags: 0x4
// Checksum 0xaeb50f00, Offset: 0x11d9
// Size: 0x66
function private function_53c5309991671ec9( available_sites, activating_player_origin, var_273e7110f5838e2d, variant_data )
{
    target_point = calculate_target_point( activating_player_origin, var_273e7110f5838e2d, variant_data.var_81e3e56e59ecbd49.var_25ee74a0b60823c8 );
    selected_site = function_9d17f49460bff68f( available_sites, target_point );
    return selected_site;
}

// Namespace activity_br_item_extraction
// Params 1, eflags: 0x4
// Checksum 0x41ce8b34, Offset: 0x1248
// Size: 0xe5
function private function_2184073149c7e0cb( var_ecb9921629bc6efc )
{
    result = [];
    
    foreach ( str in var_ecb9921629bc6efc )
    {
        str = removesubstr( str, " " );
        str = function_1b44a8bef83e8e02( str, ")" );
        str = function_41bec0232e24ee41( str, "(" );
        components = strtok( str, "," );
        
        if ( components.size == 3 )
        {
            result[ result.size ] = ( float( components[ 0 ] ), float( components[ 1 ] ), float( components[ 2 ] ) );
        }
    }
    
    return result;
}

// Namespace activity_br_item_extraction
// Params 1, eflags: 0x4
// Checksum 0xc33d4ed4, Offset: 0x1336
// Size: 0xf5, Type: bool
function private is_invalid_site( position )
{
    var_1658712739308067 = [ ( -29848, 3976, -300.212 ) ];
    var_d125b1ea708b1ce5 = strtok( getdvar( @"hash_74e287c148837506", "" ), ";" );
    var_d125b1ea708b1ce5 = function_2184073149c7e0cb( var_d125b1ea708b1ce5 );
    
    if ( var_d125b1ea708b1ce5 && var_d125b1ea708b1ce5.size > 0 )
    {
        var_1658712739308067 = arraycombine( var_1658712739308067, var_d125b1ea708b1ce5 );
    }
    
    var_117b29d22ff9660d = 40000;
    
    foreach ( invalid_position in var_1658712739308067 )
    {
        if ( distancesquared( invalid_position, position ) <= var_117b29d22ff9660d )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace activity_br_item_extraction
// Params 4, eflags: 0x4
// Checksum 0x8e696c, Offset: 0x1434
// Size: 0x215
function private function_4eb8b071b23aa229( variant_data, activating_player_origin, var_268810e4b839e944, var_38791a615ff95cea )
{
    sites = getentitylessscriptablearray( variant_data.var_81e3e56e59ecbd49.targetname, #targetname );
    var_636b5b269a4210b = var_268810e4b839e944 * 0.1;
    
    while ( var_268810e4b839e944 >= 0 )
    {
        var_268810e4b839e944 = max( var_268810e4b839e944, 1 );
        var_4fed0a604d766702 = var_268810e4b839e944 * var_268810e4b839e944;
        available_sites = [];
        
        foreach ( site in sites )
        {
            if ( is_invalid_site( site.origin ) )
            {
                continue;
            }
            
            if ( site getscriptablepartstate( variant_data.extractionpoint.var_38d5f40723870464 ) != "hidden" )
            {
                continue;
            }
            
            if ( !br_circle_util::ispointindangercircle( site.origin ) )
            {
                continue;
            }
            
            if ( !br_circle_util::function_3199bf5530fd0bc2( site.origin ) )
            {
                continue;
            }
            
            if ( isdefined( var_268810e4b839e944 ) )
            {
                var_9612e55d981ec3c6 = distance2dsquared( site.origin, activating_player_origin );
                
                if ( var_9612e55d981ec3c6 < var_4fed0a604d766702 )
                {
                    continue;
                }
            }
            
            if ( isdefined( var_38791a615ff95cea ) && getdvarint( @"hash_11d3297f8023f42f", 0 ) == 0 )
            {
                var_ad33ac744517d83b = br_circle_util::gettimetilldangerforpoint( site.origin );
                
                if ( var_ad33ac744517d83b < var_38791a615ff95cea )
                {
                    continue;
                }
            }
            
            available_sites[ available_sites.size ] = site;
        }
        
        if ( available_sites.size )
        {
            return { #var_268810e4b839e944:var_268810e4b839e944, #available_sites:available_sites };
        }
        
        var_268810e4b839e944 -= var_636b5b269a4210b;
    }
    
    return { #var_268810e4b839e944:1, #available_sites:available_sites };
}

// Namespace activity_br_item_extraction
// Params 0, eflags: 0x4
// Checksum 0x6119a1ec, Offset: 0x1652
// Size: 0xf5
function private function_a87d35429879e73e()
{
    exclude_team = level.activity_br_item_extraction.excludeteam;
    
    if ( !isdefined( exclude_team ) )
    {
        return;
    }
    
    team_players = level.teamdata[ exclude_team ][ "players" ];
    
    if ( !team_players.size )
    {
        return;
    }
    
    team_centroid = ( 0, 0, 0 );
    
    foreach ( player in team_players )
    {
        team_centroid += player.origin * ( 1, 1, 0 );
    }
    
    return team_centroid * 1 / team_players.size;
}

// Namespace activity_br_item_extraction
// Params 3, eflags: 0x4
// Checksum 0x77144c0b, Offset: 0x1750
// Size: 0x5c
function private calculate_target_point( activating_player_origin, var_273e7110f5838e2d, var_4eac745d2bc8f2f3 )
{
    var_4767a91840deb0e9 = activating_player_origin * ( 1, 1, 0 );
    
    if ( !isdefined( var_273e7110f5838e2d ) )
    {
        return var_4767a91840deb0e9;
    }
    
    direction = vectornormalize( var_273e7110f5838e2d - var_4767a91840deb0e9 );
    return var_273e7110f5838e2d + direction * var_4eac745d2bc8f2f3;
}

// Namespace activity_br_item_extraction
// Params 2, eflags: 0x4
// Checksum 0x6467b920, Offset: 0x17b5
// Size: 0xf0
function private function_9d17f49460bff68f( sites, target_point )
{
    var_4b22821b73373a65 = undefined;
    closest_dist = undefined;
    var_b76cce0f57f9d5d6 = target_point * ( 1, 1, 0 );
    
    foreach ( site in sites )
    {
        dist = distance2dsquared( site.origin * ( 1, 1, 0 ), var_b76cce0f57f9d5d6 );
        
        if ( !isdefined( closest_dist ) || dist < closest_dist )
        {
            closest_dist = dist;
            var_4b22821b73373a65 = site;
        }
    }
    
    return var_4b22821b73373a65;
}

// Namespace activity_br_item_extraction
// Params 1
// Checksum 0x7c224d45, Offset: 0x18ae
// Size: 0x244
function on_item_pickup( params )
{
    foreach ( valid_item in level.activity_br_item_extraction.var_4af0992a19ca4ea3 )
    {
        itembundlename = params.itembundlename;
        
        if ( getdvarint( @"hash_331df572494d4516", 1 ) && itembundlename == valid_item.var_30fb0dee6ae5648 )
        {
            player = params.player;
            team = player.team;
            activity_variant = valid_item.activity_variant;
            
            if ( !function_88ff8516e053646d( player, valid_item.var_9bca08d7b929df32 ) )
            {
                if ( !valid_item.var_5528f3a78ba13fd || !level.activity_br_item_extraction.var_f8c35c185a5850fa )
                {
                    if ( !activity_participation::function_7d9e88b09010d55a( player, activity_variant ) )
                    {
                        activity_instance = activity_instance_common::createactivityinstance( "BR_ITEM_EXTRACTION", activity_variant );
                        activity_participation::function_bc67362dace4370c( activity_instance, player );
                        activity_instance function_e72f9829b437b69a( team, valid_item, player.origin );
                        level.teamdata[ team ][ activity_variant ] = activity_instance;
                        item_config = function_15f3abc96be8be8e( activity_instance.var_332f929de1894b2b, itembundlename );
                        elite_ironclad_dialogs::function_86e69830b4062c31( { #team:team, #var_22392512aa68e918:item_config.var_56d6426f76f5e619, #scope:3 } );
                    }
                    else
                    {
                        activity_instance = level.teamdata[ team ][ activity_variant ];
                        activity_instance function_e72f9829b437b69a( team, valid_item, player.origin );
                    }
                    
                    player function_3f77cca03aad1c97( activity_instance.var_332f929de1894b2b, itembundlename, 1 );
                }
                
                return;
            }
            
            extraction_site = get_extraction_site( valid_item );
            
            if ( extraction_site )
            {
                extraction_site disable_extraction_site();
            }
            
            return;
        }
    }
}

// Namespace activity_br_item_extraction
// Params 1
// Checksum 0x96447cdb, Offset: 0x1afa
// Size: 0x11c
function function_40d1ae0558dff795( params )
{
    player = self;
    team = player.team;
    
    foreach ( valid_item in level.activity_br_item_extraction.var_4af0992a19ca4ea3 )
    {
        itembundlename = params.itembundlename;
        
        if ( itembundlename == valid_item.var_30fb0dee6ae5648 )
        {
            activity_variant = valid_item.activity_variant;
            
            if ( activity_participation::function_7d9e88b09010d55a( player, activity_variant ) )
            {
                activity_instance = level.teamdata[ team ][ activity_variant ];
                player function_3f77cca03aad1c97( activity_instance.var_332f929de1894b2b, itembundlename, 0 );
            }
        }
    }
}

// Namespace activity_br_item_extraction
// Params 6, eflags: 0x4
// Checksum 0x113b8272, Offset: 0x1c1e
// Size: 0xd0
function private function_6a60a6d3a8f61c4b( instance, part, state, player, bautouse, usestring )
{
    if ( instance.var_7f332a185f67270d )
    {
        activity_bundle_variant = instance.var_7f332a185f67270d;
        
        if ( function_fa21ab17da1ac516( part, state, player, instance.var_52b44a1dde5e0fc, activity_bundle_variant, instance.var_38bd5898b3e30d3b.depositstate ) )
        {
            function_772d5be3382bbb50( instance, player );
        }
        
        if ( function_fa21ab17da1ac516( part, state, player, instance.var_52b44a1dde5e0fc, activity_bundle_variant, instance.var_38bd5898b3e30d3b.activatestate ) )
        {
            extraction_site_used( instance, player );
        }
    }
}

// Namespace activity_br_item_extraction
// Params 2, eflags: 0x4
// Checksum 0x6841b9c4, Offset: 0x1cf6
// Size: 0x39f
function private function_772d5be3382bbb50( instance, player )
{
    activity_instance = level.teamdata[ player.team ][ instance.var_40e83f8afde1b0e5 ];
    assert( activity_instance, "<dev string:x24>" );
    activity_bundle_variant = instance.var_7f332a185f67270d;
    var_e58a447d6c913557 = function_ddc61045c1a24138( player, instance.var_52b44a1dde5e0fc, activity_bundle_variant );
    player function_3f77cca03aad1c97( activity_bundle_variant, var_e58a447d6c913557.var_30fb0dee6ae5648, 2 );
    player utility::callsharedfunc( #"item", #"hash_5dd38e63b8ac14a4", var_e58a447d6c913557.type );
    elite_ironclad_dialogs::function_86e69830b4062c31( { #team:instance.team, #var_22392512aa68e918:instance.var_38bd5898b3e30d3b.var_5329c18a0baffd08, #scope:3 } );
    elite_ironclad_dialogs::function_86e69830b4062c31( { #var_22392512aa68e918:instance.var_38bd5898b3e30d3b.var_b853a5d7806cf84c, #scope:1 } );
    
    if ( instance.heli )
    {
        instance.heli notify( #"item_extraction_successful" );
    }
    
    if ( level.elite_ironclad.cq_team && getdvarint( @"hash_30b4430deb1884b0", 0 ) )
    {
        if ( activity_bundle_variant.extractionpoint.var_da62884a6a2f7bb9 )
        {
            player thread hud_message::showsplash( activity_bundle_variant.extractionpoint.var_da62884a6a2f7bb9, undefined, undefined, undefined, undefined, activity_bundle_variant.extractionpoint.splashlist );
        }
        
        player challenges::function_bf3b05129da76942();
    }
    else
    {
        if ( activity_bundle_variant.extractionpoint.var_da62884a6a2f7bb9 )
        {
            level thread br::teamsplashbr( activity_bundle_variant.extractionpoint.var_da62884a6a2f7bb9, undefined, activity_instance.team, undefined, activity_bundle_variant.extractionpoint.splashlist );
        }
        
        players = activity_instance.playerparticipants;
        
        foreach ( var_bfc406e13364643f in players )
        {
            var_bfc406e13364643f challenges::function_bf3b05129da76942();
        }
    }
    
    activity_instance.extraction_completed = 1;
    
    if ( getdvarint( @"hash_90dcd8e603e53b73", 1 ) )
    {
        function_eac55a8c71fc4829( activity_instance );
        level.activity_br_item_extraction.var_f8c35c185a5850fa = 1;
    }
    
    player dlog_recordplayerevent( "dlog_event_br_elite_ironclad_extract", [ "start_time", activity_instance.analytics.start_time ?? 0, "extract_time", gettime(), "extracted_element", var_e58a447d6c913557.var_30fb0dee6ae5648 ?? "unknown" ] );
    
    if ( level.activity_br_item_extraction.var_f8da97d5c4800447 )
    {
        [[ level.activity_br_item_extraction.var_f8da97d5c4800447 ]]( level.activity_br_item_extraction.var_6422f22bc9fee1b4, player );
    }
}

// Namespace activity_br_item_extraction
// Params 1, eflags: 0x4
// Checksum 0xf8f8799b, Offset: 0x209d
// Size: 0x1d8
function private function_eac55a8c71fc4829( activity_instance )
{
    foreach ( valid_item in level.activity_br_item_extraction.var_4af0992a19ca4ea3 )
    {
        foreach ( player in level.players )
        {
            var_aa428fed24d02e9b = player utility::callsharedfunc( #"item", #"hash_d7e5d2a8b89b1a12", "super" );
            var_1020c4415305bd08 = player utility::callsharedfunc( #"item", #"hash_d7e5d2a8b89b1a12", "killstreak" );
            
            if ( valid_item.var_5528f3a78ba13fd && var_aa428fed24d02e9b.name == valid_item.var_30fb0dee6ae5648 )
            {
                player utility::callsharedfunc( #"item", #"hash_5dd38e63b8ac14a4", "super" );
            }
            
            if ( valid_item.var_5528f3a78ba13fd && var_1020c4415305bd08.name == valid_item.var_30fb0dee6ae5648 )
            {
                player utility::callsharedfunc( #"item", #"hash_5dd38e63b8ac14a4", "killstreak" );
            }
        }
    }
}

// Namespace activity_br_item_extraction
// Params 1, eflags: 0x4
// Checksum 0x72ca7500, Offset: 0x227d
// Size: 0x111, Type: bool
function private function_de5175e57ae31c13( activity_bundle_variant )
{
    currentparticipants = self.playerparticipants;
    
    foreach ( player in currentparticipants )
    {
        foreach ( valid_item in level.activity_br_item_extraction.var_4af0992a19ca4ea3 )
        {
            if ( function_ddc61045c1a24138( player, valid_item, activity_bundle_variant ) )
            {
                return true;
            }
        }
    }
    
    return false;
}

// Namespace activity_br_item_extraction
// Params 3, eflags: 0x4
// Checksum 0x113a6415, Offset: 0x2397
// Size: 0x15f
function private function_ddc61045c1a24138( player, valid_item_type, activity_bundle_variant )
{
    if ( valid_item_type.var_5528f3a78ba13fd && level.activity_br_item_extraction.var_f8c35c185a5850fa )
    {
        return 0;
    }
    
    var_aa428fed24d02e9b = player utility::callsharedfunc( #"item", #"hash_d7e5d2a8b89b1a12", "super" );
    var_1020c4415305bd08 = player utility::callsharedfunc( #"item", #"hash_d7e5d2a8b89b1a12", "killstreak" );
    
    if ( var_aa428fed24d02e9b && ( !isdefined( valid_item_type ) || var_aa428fed24d02e9b.name == valid_item_type.var_30fb0dee6ae5648 ) && function_15f3abc96be8be8e( activity_bundle_variant, var_aa428fed24d02e9b.name ) )
    {
        return { #type:"super", #var_30fb0dee6ae5648:var_aa428fed24d02e9b.name };
    }
    
    if ( var_1020c4415305bd08 && ( !isdefined( valid_item_type ) || var_1020c4415305bd08.name == valid_item_type.var_30fb0dee6ae5648 ) && function_15f3abc96be8be8e( activity_bundle_variant, var_1020c4415305bd08.name ) )
    {
        return { #type:"killstreak", #var_30fb0dee6ae5648:var_1020c4415305bd08.name };
    }
}

// Namespace activity_br_item_extraction
// Params 3, eflags: 0x4
// Checksum 0x328a7435, Offset: 0x24ff
// Size: 0x161
function private function_3f77cca03aad1c97( activity_bundle_variant, item_spawn_entry, extraction_state )
{
    player = self;
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    omnvar_name = function_e992f516a53f5b44( activity_bundle_variant, item_spawn_entry );
    
    if ( !isdefined( omnvar_name ) || omnvar_name == "" )
    {
        return;
    }
    
    teammates = teams::getteamdata( player.team, "players" );
    squad_index_max = 3;
    squad_index = 0;
    squad_index = int( player.sessionuimemberindex ) & squad_index_max;
    
    foreach ( player in teammates )
    {
        var_a77b48162cc41f04 = 3;
        assert( extraction_state >= 0 && extraction_state <= var_a77b48162cc41f04 );
        assert( squad_index >= 0 && squad_index <= squad_index_max );
        player omnvar_utility::function_85d5f88af471ac4b( omnvar_name, 0, 2, int( extraction_state ) & var_a77b48162cc41f04 );
        player omnvar_utility::function_85d5f88af471ac4b( omnvar_name, 2, 2, squad_index );
    }
}

// Namespace activity_br_item_extraction
// Params 2, eflags: 0x4
// Checksum 0xd125bf96, Offset: 0x2668
// Size: 0xe7
function private function_e992f516a53f5b44( activity_bundle_variant, item_spawn_entry )
{
    if ( !isdefined( activity_bundle_variant.extractionpoint ) || !isdefined( activity_bundle_variant.extractionpoint.var_b59ac5ef3d4327ca ) )
    {
        return;
    }
    
    if ( !isdefined( item_spawn_entry ) )
    {
        return;
    }
    
    foreach ( config in activity_bundle_variant.extractionpoint.var_b59ac5ef3d4327ca )
    {
        if ( item_spawn_entry )
        {
            if ( config.itemspawnentry == item_spawn_entry )
            {
                return config.var_e2c6da573ff45a83;
            }
        }
    }
}

// Namespace activity_br_item_extraction
// Params 2, eflags: 0x4
// Checksum 0xedeea19f, Offset: 0x2758
// Size: 0x6e, Type: bool
function private function_88ff8516e053646d( player, var_9bca08d7b929df32 )
{
    if ( !isdefined( level.activity_br_item_extraction.excludeteam ) )
    {
        return false;
    }
    
    if ( var_9bca08d7b929df32 && player.team == level.activity_br_item_extraction.excludeteam && !getdvarint( @"hash_e24eea867cf51d59", 0 ) )
    {
        return true;
    }
    
    return false;
}

// Namespace activity_br_item_extraction
// Params 6, eflags: 0x4
// Checksum 0x55b2bd59, Offset: 0x27cf
// Size: 0x89, Type: bool
function private function_fa21ab17da1ac516( part, state, player, valid_item_type, activity_bundle_variant, valid_state )
{
    if ( function_88ff8516e053646d( player, valid_item_type.var_9bca08d7b929df32 ) )
    {
        return false;
    }
    
    if ( !function_ffb62d66afa99768( part, state, activity_bundle_variant.extractionpoint.var_38d5f40723870464, valid_state ) )
    {
        return false;
    }
    
    if ( !function_ddc61045c1a24138( player, valid_item_type, activity_bundle_variant ) )
    {
        return false;
    }
    
    return true;
}

// Namespace activity_br_item_extraction
// Params 4, eflags: 0x4
// Checksum 0xbef6c41b, Offset: 0x2861
// Size: 0x3a, Type: bool
function private function_ffb62d66afa99768( part, state, valid_part, valid_state )
{
    if ( part != valid_part || state != valid_state )
    {
        return false;
    }
    
    return true;
}

// Namespace activity_br_item_extraction
// Params 2, eflags: 0x4
// Checksum 0xe8d0dd33, Offset: 0x28a4
// Size: 0x1f1
function private extraction_site_used( instance, player )
{
    activity_bundle_variant = instance.var_7f332a185f67270d;
    var_370c23b8ac4aeb33 = activity_bundle_variant.extractionpoint.var_b93327d6e72ffb79;
    instance setscriptablepartstate( instance.type, instance.var_38bd5898b3e30d3b.inusestate );
    instance.team = function_f02c63b99c9614c9( level.allteamnamelist, player.team );
    function_d41df5f2abfdf2b4( instance, instance.var_38bd5898b3e30d3b.var_9d51237c6c6eb4ea );
    heli = player br_extraction_heli::function_e5e8ddf0aca9ebe0( instance, var_370c23b8ac4aeb33 );
    
    if ( isdefined( heli ) )
    {
        if ( instance.var_dc43d363f1de45af )
        {
            instance [[ instance.var_dc43d363f1de45af ]]( var_370c23b8ac4aeb33 );
        }
        
        groundorg = getgroundposition( instance.origin, 1 ) + ( 0, 0, -9 );
        thread function_8795995ce91a2674( groundorg, var_370c23b8ac4aeb33 );
        
        if ( activity_bundle_variant.extractionpoint.var_2ac94ac4723dbf2c )
        {
            level thread br::teamsplashbr( activity_bundle_variant.extractionpoint.var_2ac94ac4723dbf2c, player, player.team, undefined, activity_bundle_variant.extractionpoint.splashlist );
        }
        
        elite_ironclad_dialogs::function_86e69830b4062c31( { #var_22392512aa68e918:instance.var_38bd5898b3e30d3b.var_bb9704371b9f5c59, #scope:1 } );
        return;
    }
    
    instance setscriptablepartstate( instance.type, instance.var_38bd5898b3e30d3b.activatestate );
    function_d41df5f2abfdf2b4( instance, instance.var_38bd5898b3e30d3b.var_3ded336bba8610f4 );
}

// Namespace activity_br_item_extraction
// Params 2, eflags: 0x4
// Checksum 0xb787022e, Offset: 0x2a9d
// Size: 0xcb
function private function_8795995ce91a2674( position, var_370c23b8ac4aeb33 )
{
    wait 1.5;
    fxent = spawn( "script_model", position );
    fxent setmodel( "scr_smoke_grenade" );
    fxent.angles = ( 0, 90, 90 );
    fxent playsound( "smoke_carepackage_expl_trans" );
    fxent playloopsound( "smoke_carepackage_smoke_lp" );
    fxent setscriptablepartstate( "smoke", "on" );
    wait 17 + ( var_370c23b8ac4aeb33 ?? 0 );
    fxent endon( #"death" );
    fxent setscriptablepartstate( "smoke", "dissipate" );
    fxent playsound( "smoke_canister_tail_dissipate" );
    wait 1;
    fxent stoploopsound();
    wait 4.5;
    fxent delete();
}

// Namespace activity_br_item_extraction
// Params 1
// Checksum 0x368c411c, Offset: 0x2b70
// Size: 0x2f
function activity_ended( activity_succeeded )
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
    namespace_44f3cc5922e3a432::cleanup_all_markers( activity_instance );
}

// Namespace activity_br_item_extraction
// Params 0
// Checksum 0xc9ab750b, Offset: 0x2ba7
// Size: 0x1c
function function_d4acef179eb9f9b2()
{
    activity_instance = self;
    activity_instance endon( #"instance_destroyed" );
}

// Namespace activity_br_item_extraction
// Params 1
// Checksum 0x8f9b14d2, Offset: 0x2bcb
// Size: 0xc
function player_joined_activity( relevant_info_struct )
{
    
}

// Namespace activity_br_item_extraction
// Params 1
// Checksum 0x764f5d96, Offset: 0x2bdf
// Size: 0xc
function player_left_activity( relevant_info_struct )
{
    
}

// Namespace activity_br_item_extraction
// Params 2
// Checksum 0xdf1372f5, Offset: 0x2bf3
// Size: 0x30
function callback_heli_left( type, var_e97d65fb61a95460 )
{
    self setscriptablepartstate( type, self.var_38bd5898b3e30d3b.inusestate );
}

// Namespace activity_br_item_extraction
// Params 1
// Checksum 0x383abeef, Offset: 0x2c2b
// Size: 0x69
function function_dc43d363f1de45af( var_370c23b8ac4aeb33 )
{
    descend_time = getanimlength( level.scr_anim[ "plunder_extract_heli" ][ "heli_in" ] );
    total_time = ( var_370c23b8ac4aeb33 ?? 0 ) + descend_time;
    final_time = gettime() + int( total_time * 1000 );
    setomnvar( "ui_br_reach_extraction_platform_timer", final_time );
}

// Namespace activity_br_item_extraction
// Params 2
// Checksum 0xf1d6fcc7, Offset: 0x2c9c
// Size: 0x3b
function function_c2528ae64573b7a4( type, var_e97d65fb61a95460 )
{
    self setscriptablepartstate( type, self.var_38bd5898b3e30d3b.depositstate );
    setomnvar( "ui_br_reach_extraction_platform_timer", 0 );
}

// Namespace activity_br_item_extraction
// Params 2
// Checksum 0xd6963288, Offset: 0x2cdf
// Size: 0x4b
function function_106bc96555268bdf( type, var_e97d65fb61a95460 )
{
    self setscriptablepartstate( type, self.var_38bd5898b3e30d3b.activatestate );
    function_d41df5f2abfdf2b4( self, self.var_38bd5898b3e30d3b.var_3ded336bba8610f4 );
}

// Namespace activity_br_item_extraction
// Params 2, eflags: 0x4
// Checksum 0x24bd70e1, Offset: 0x2d32
// Size: 0x1fd
function private function_734106c4239b501c( usable, player )
{
    activity_bundle_variant = usable.var_7f332a185f67270d;
    var_e58a447d6c913557 = function_ddc61045c1a24138( player, usable.var_52b44a1dde5e0fc, activity_bundle_variant );
    
    if ( !var_e58a447d6c913557 )
    {
        return { #interactable:0, #string:usable.var_38bd5898b3e30d3b.var_b29a4ed047077bff, #type:"HINT_NOBUTTON" };
    }
    
    if ( function_88ff8516e053646d( player, usable.var_52b44a1dde5e0fc.var_9bca08d7b929df32 ) )
    {
        return { #interactable:0, #string:usable.var_38bd5898b3e30d3b.var_f015da9a2794fc2e, #type:"HINT_NOBUTTON" };
    }
    
    state = usable getscriptablepartstate( usable.type );
    var_97e96fa9deea1150 = activity_bundle_variant.extractionpoint.var_38d5f40723870464;
    
    if ( function_ffb62d66afa99768( usable.type, state, var_97e96fa9deea1150, usable.var_38bd5898b3e30d3b.activatestate ) )
    {
        return { #string:usable.var_38bd5898b3e30d3b.var_c4563dd23eddfbdb, #type:"HINT_BUTTON" };
    }
    else if ( function_ffb62d66afa99768( usable.type, state, var_97e96fa9deea1150, usable.var_38bd5898b3e30d3b.depositstate ) )
    {
        return { #string:usable.var_38bd5898b3e30d3b.var_70758d6e1ae9c2e0, #type:"HINT_BUTTON" };
    }
    
    return { #interactable:0, #string:&"", #type:"HINT_NODISPLAY" };
}

// Namespace activity_br_item_extraction
// Params 2, eflags: 0x4
// Checksum 0x65708a50, Offset: 0x2f38
// Size: 0xa5
function private function_15f3abc96be8be8e( activity_bundle_variant, item_type )
{
    foreach ( config in activity_bundle_variant.extractionpoint.var_b59ac5ef3d4327ca )
    {
        if ( config.itemspawnentry == item_type )
        {
            return config;
        }
    }
}

// Namespace activity_br_item_extraction
// Params 1, eflags: 0x4
// Checksum 0x629b55c3, Offset: 0x2fe6
// Size: 0x202
function private function_5539d745896a3e95( params )
{
    player = self;
    spawn_options = common_item::items_initspawnoptions_spawnfromentity( player );
    spawn_options.var_7a166247da860246 = [];
    
    foreach ( valid_item in level.activity_br_item_extraction.var_4af0992a19ca4ea3 )
    {
        var_aa428fed24d02e9b = player utility::callsharedfunc( #"item", #"hash_d7e5d2a8b89b1a12", "super" );
        var_1020c4415305bd08 = player utility::callsharedfunc( #"item", #"hash_d7e5d2a8b89b1a12", "killstreak" );
        
        if ( var_aa428fed24d02e9b.name == valid_item.var_30fb0dee6ae5648 )
        {
            player common_inventory::function_38ff1a66cd956902( spawn_options );
        }
        
        if ( var_1020c4415305bd08.name == valid_item.var_30fb0dee6ae5648 )
        {
            player common_inventory::function_4b4cbbe1c5a19189( spawn_options );
        }
    }
    
    if ( spawn_options.var_7a166247da860246.size )
    {
        foreach ( item in spawn_options.var_7a166247da860246 )
        {
            spawned_item = common_item::function_61c2c0251e742ffd( item.itemname, 1, spawn_options );
            
            if ( spawned_item )
            {
                namespace_44f3cc5922e3a432::on_player_leave( player, spawned_item, item.itemname );
            }
        }
    }
}

// Namespace activity_br_item_extraction
// Params 0, eflags: 0x4
// Checksum 0x40f543fc, Offset: 0x31f0
// Size: 0x63
function private init_dev_gui()
{
    /#
        devgui::function_9082edeb5db93280( "<dev string:x82>" );
        devgui::add_devgui_func( "<dev string:x9f>", "<dev string:xc3>", &function_81e7ec8fb44e9653, 0, 1 );
        devgui::add_devgui_func( "<dev string:xe7>", "<dev string:x108>", &function_cb3eda9579cd6fd7, 0, 1 );
        devgui::add_devgui_func( "<dev string:x129>", "<dev string:x137>", &function_d1c54ff293befcf3, 0, 1 );
        devgui::function_77df7fe7dd273e10();
    #/
}

/#

    // Namespace activity_br_item_extraction
    // Params 0, eflags: 0x4
    // Checksum 0x79350f2, Offset: 0x325b
    // Size: 0x7f, Type: dev
    function private function_d1c54ff293befcf3()
    {
        foreach ( player in level.players )
        {
            player function_5539d745896a3e95( {} );
        }
    }

    // Namespace activity_br_item_extraction
    // Params 0, eflags: 0x4
    // Checksum 0x22e1f54b, Offset: 0x32e2
    // Size: 0xd, Type: dev
    function private function_81e7ec8fb44e9653()
    {
        function_e3b08b8a275d7e1b( undefined );
    }

    // Namespace activity_br_item_extraction
    // Params 0, eflags: 0x4
    // Checksum 0xd7289a21, Offset: 0x32f7
    // Size: 0x55, Type: dev
    function private function_cb3eda9579cd6fd7()
    {
        random_pos = br_circle::getrandompointinboundssafecircle( 0.1, 0.9 );
        ground_pos = getgroundposition( random_pos, 1 );
        selected_site = function_e3b08b8a275d7e1b( ground_pos );
        
        if ( !selected_site )
        {
            print( "<dev string:x145>" );
        }
    }

    // Namespace activity_br_item_extraction
    // Params 1, eflags: 0x4
    // Checksum 0x1ab16b85, Offset: 0x3354
    // Size: 0x56b, Type: dev
    function private function_e3b08b8a275d7e1b( var_273e7110f5838e2d )
    {
        if ( !isdefined( level.activity_br_item_extraction.quest_circle_array ) )
        {
            level.activity_br_item_extraction.quest_circle_array = [];
        }
        
        foreach ( circle in level.activity_br_item_extraction.quest_circle_array )
        {
            circle delete();
        }
        
        level.activity_br_item_extraction.quest_circle_array = [];
        activating_player = level.players[ 0 ];
        random_pos = br_circle::getrandompointinboundssafecircle( 0.1, 0.9 );
        ground_pos = getgroundposition( random_pos, 1 );
        activating_player setorigin( ground_pos );
        activating_player_origin = activating_player.origin;
        activity_definition = hashcat( %"activitydefinition:", "<dev string:x14e>" );
        var_cd6d759b2c772946 = getscriptbundle( activity_definition );
        custom_properties = activity_definition_utils::function_9129cd8075c85c09( var_cd6d759b2c772946 );
        sites = getentitylessscriptablearray( custom_properties.var_81e3e56e59ecbd49.targetname, #targetname );
        
        foreach ( site in sites )
        {
            tmp = {};
            tmp game_utility::questcircle_create( "<dev string:x17d>", site.origin, 750 );
            tmp game_utility::questcircle_showtoall();
            level.activity_br_item_extraction.quest_circle_array[ level.activity_br_item_extraction.quest_circle_array.size ] = tmp.mapcircle;
        }
        
        var_c00493a990fe968f = function_4eb8b071b23aa229( custom_properties, activating_player_origin, custom_properties.var_81e3e56e59ecbd49.var_de478ebe8ee1a747, custom_properties.var_81e3e56e59ecbd49.var_4bd03a412257a615 );
        activating_player game_utility::questcircle_create( "<dev string:x190>", activating_player.origin, var_c00493a990fe968f.var_268810e4b839e944 );
        activating_player game_utility::questcircle_showtoall();
        level.activity_br_item_extraction.quest_circle_array[ level.activity_br_item_extraction.quest_circle_array.size ] = activating_player.mapcircle;
        
        if ( !var_c00493a990fe968f.available_sites.size )
        {
            return;
        }
        
        selected_site = function_53c5309991671ec9( var_c00493a990fe968f.available_sites, activating_player_origin, var_273e7110f5838e2d, custom_properties );
        
        if ( selected_site )
        {
            print( "<dev string:x19b>" + selected_site.origin );
        }
        
        if ( var_273e7110f5838e2d )
        {
            tmp = {};
            tmp game_utility::questcircle_create( "<dev string:x1aa>", var_273e7110f5838e2d, custom_properties.var_81e3e56e59ecbd49.var_25ee74a0b60823c8 );
            tmp game_utility::questcircle_showtoall();
            level.activity_br_item_extraction.quest_circle_array[ level.activity_br_item_extraction.quest_circle_array.size ] = tmp.mapcircle;
            target_point = calculate_target_point( activating_player_origin, var_273e7110f5838e2d, custom_properties.var_81e3e56e59ecbd49.var_25ee74a0b60823c8 );
            tmp2 = {};
            tmp2 game_utility::questcircle_create( "<dev string:x17d>", target_point, 750 );
            tmp2 game_utility::questcircle_showtoall();
            level.activity_br_item_extraction.quest_circle_array[ level.activity_br_item_extraction.quest_circle_array.size ] = tmp2.mapcircle;
        }
        
        foreach ( site in var_c00493a990fe968f.available_sites )
        {
            if ( selected_site && site == selected_site )
            {
                continue;
            }
            
            site game_utility::questcircle_create( "<dev string:x190>", site.origin, 1500 );
            site game_utility::questcircle_showtoall();
            level.activity_br_item_extraction.quest_circle_array[ level.activity_br_item_extraction.quest_circle_array.size ] = site.mapcircle;
        }
        
        if ( selected_site )
        {
            selected_site game_utility::questcircle_create( "<dev string:x1bc>", selected_site.origin, 3000 );
            selected_site game_utility::questcircle_showtoall();
            level.activity_br_item_extraction.quest_circle_array[ level.activity_br_item_extraction.quest_circle_array.size ] = selected_site.mapcircle;
        }
        
        return selected_site;
    }

#/
