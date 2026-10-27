// scripts\mp\br\gametypes\br_plunder.gsc  (hash_0d83c56652e0be18.gscc) (size: 70997 Bytes / 0x11555 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8a072fc9 (2315726793)
// size ...... 70997 (0x11555)
// includes .. 46  (offset: 0x105e1)
// strings ... 178 (offset: 0x10751)
// dev strs .. 43  (offset: 0x11289)
// exports ... 160 (offset: 0xbc19)
// cseg ...... 0x103e + 0xabdb (0xbc19)
// imports ... 381 (offset: 0xd519)
// animtree1 . 1   (offset: 0x114b9)
// animtree2 . 9   (offset: 0x114c5)
#using script_16ea1b94f0f381b3;
#using scripts\common\anim;
#using scripts\common\bots\bots_util;
#using scripts\common\callbacks;
#using scripts\common\interactive;
#using scripts\common\scriptable;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_tracking;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_analytics;
#using scripts\mp\br\gametypes\br_armory_kiosk;
#using scripts\mp\br\gametypes\br_circle;
#using scripts\mp\br\gametypes\br_circle_util;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_instance_inventory;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_publicevents;
#using scripts\mp\br\gametypes\br_quest_util;
#using scripts\mp\cash;
#using scripts\mp\challenges;
#using scripts\mp\common\equipment\fulton;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\debug_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\pickups_utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\stats;
#using scripts\mp\common\utility\teams;
#using scripts\mp\currency;
#using scripts\mp\damagefeedback;
#using scripts\mp\flags;
#using scripts\mp\hostmigration;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_currency;
#using scripts\mp\loot\common_item_database;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\rank;
#using scripts\mp\structspawnconfig;

#namespace br_plunder;

// Namespace br_plunder
// Params 0
// Checksum 0x9afc260c, Offset: 0x105c
// Size: 0x339
function init()
{
    level.br_plunder = spawnstruct();
    level.br_plunder.plunderlimit = 131071;
    level.br_plunder.plunder_items_picked_up = 0;
    level.br_plunder.plunder_value_picked_up = 0;
    level.br_plunder.plunder_items_dropped = 0;
    level.br_plunder.plunder_value_dropped = 0;
    level.br_plunder.kiosk_spent_total = 0;
    level.br_plunder.kiosk_num_purchases = 0;
    level.br_plunder.extraction_balloon_total_plunder = 0;
    level.br_plunder.extraction_balloon_num_completed = 0;
    level.br_plunder.extraction_helicoptor_total_plunder = 0;
    level.br_plunder.extraction_helicoptor_num_completed = 0;
    level.br_plunder.plunder_awarded_by_missions_total = 0;
    callback::add( #"player_laststand_revived", &function_e8542df0e16b7206 );
    level.br_plunder_enabled = getmatchrulesdata( "brData", "plunder" );
    
    if ( bots_util::function_deef484b5b3a3977() )
    {
        level.var_6a8e88d5a8429194.var_a0c5aeb32f12f710 = istrue( level.br_plunder_enabled );
    }
    
    if ( !level.br_plunder_enabled )
    {
        return;
    }
    
    if ( !isdefined( level.minplunderdropondeath ) )
    {
        level.minplunderdropondeath = 0;
    }
    
    setupquantities();
    level thread plunder_economy_shapshot_loop();
    level thread plunder_infils_ready();
    level._effect[ "vfx_extract_smoke" ] = loadfxasset( "vfx_iw8_br_gameplay_adv_supply_drop_marker" );
    level._effect[ "vfx_br_cashLeaderBag" ] = loadfxasset( "vfx_iw8_br_gameplay_money_vip_burst" );
    
    if ( utility::callsharedfunc( #"game", #"isCommonItemEnabled" ) )
    {
        if ( isdefined( level.var_96cc681a7f319f53 ) )
        {
            [[ level.var_96cc681a7f319f53 ]]();
        }
        
        return;
    }
    
    level.br_plunder_enabled = getmatchrulesdata( "brData", "plunder" );
    
    if ( !level.br_plunder_enabled )
    {
        return;
    }
    
    thread setupplunderextractionsites();
    initheliextractanims();
    inithelipropanims();
    var_323b9f2bcb582695 = getmatchrulesdata( "brData", "plunderLobby" );
    level.br_plunder_lobby = var_323b9f2bcb582695 && level.allowprematchdamage;
    initvo();
    initplunderpads();
    level.br_depots = [];
    
    if ( inplunderlivelobby() )
    {
        level.br_plunder_ents = [];
        thread plunderlivelobby();
    }
    
    initplayerplunderevents();
    plunder_initrepositories();
    fulton::fulton_init();
    initteamdatafields();
    inithelirepository();
    
    if ( getdvarint( @"scr_enableplunderpileoverrides", 0 ) == 1 )
    {
        processcashpilevalueoverrides();
    }
    
    br_circle::registercirclecallbacks( 0, &dangercircletick, &dangermulticircletick );
    audio_utility::snd_transient_load( "eqp_extraction_balloon" );
    
    /#
        thread function_a06671470d71635c();
        setdevdvarifuninitialized( @"hash_69a2288a8b47e1b5", 0 );
        setdevdvarifuninitialized( @"hash_f38b8e35f5c48796", 0 );
        
        if ( false )
        {
            debug_calculatecashonground();
        }
        
        level thread function_2f48aabdaff9b0d9();
    #/
}

// Namespace br_plunder
// Params 1
// Checksum 0x73ee2bdd, Offset: 0x139d
// Size: 0x18
function function_e8542df0e16b7206( params )
{
    plunder_allowallrepositoryuseforplayer( self, 1, 1 );
}

// Namespace br_plunder
// Params 3
// Checksum 0x3fc6267d, Offset: 0x13bd
// Size: 0xef
function plunder_economy_shapshot_loop( duration, safecircleent, var_2416571fce2a1220 )
{
    level endon( #"game_ended" );
    level waittill( #"prematch_started" );
    
    while ( true )
    {
        level waittill( #"br_circle_started" );
        activeplayers = [];
        
        foreach ( player in level.players )
        {
            if ( !player br_public::isplayeringulag() && player::isreallyalive( player ) )
            {
                activeplayers[ activeplayers.size ] = player;
            }
        }
        
        br_analytics::branalytics_economy_snapshot( activeplayers );
    }
}

// Namespace br_plunder
// Params 0
// Checksum 0x729af3df, Offset: 0x14b4
// Size: 0xd6
function plunder_infils_ready()
{
    startplunder = getmatchrulesdata( "brData", "plunderStartAmount" );
    var_27abb5ea87c4bbb5 = getmatchrulesdata( "brData", "plunderBotStartAmount" );
    
    if ( !startplunder && !var_27abb5ea87c4bbb5 )
    {
        return;
    }
    
    level waittill( #"infils_ready" );
    
    foreach ( player in level.players )
    {
        player playersetplundercount( isbot( player ) ? var_27abb5ea87c4bbb5 : startplunder );
    }
}

// Namespace br_plunder
// Params 2
// Checksum 0x5f44e120, Offset: 0x1592
// Size: 0x6d
function modify_plunder_itemsinworld( itemname, modification )
{
    if ( utility::callsharedfunc( #"game", #"isCommonItemEnabled" ) )
    {
        return;
    }
    
    if ( level.br_plunder_enabled )
    {
        level.br_plunder.itemsinworld[ itemname ] += modification;
    }
}

// Namespace br_plunder
// Params 0
// Checksum 0xea80704d, Offset: 0x1607
// Size: 0x38f
function setupquantities()
{
    level.br_plunder.quantity = [];
    level.br_plunder.names = [];
    level.br_plunder.names[ level.br_plunder.names.size ] = "brloot_plunder_cash_common_1";
    level.br_plunder.names[ level.br_plunder.names.size ] = "brloot_plunder_cash_uncommon_1";
    level.br_plunder.names[ level.br_plunder.names.size ] = "brloot_plunder_cash_uncommon_2";
    level.br_plunder.names[ level.br_plunder.names.size ] = "brloot_plunder_cash_uncommon_3";
    level.br_plunder.names[ level.br_plunder.names.size ] = "brloot_plunder_cash_rare_1";
    level.br_plunder.names[ level.br_plunder.names.size ] = "brloot_plunder_cash_rare_2";
    level.br_plunder.names[ level.br_plunder.names.size ] = "brloot_plunder_cash_epic_1";
    level.br_plunder.names[ level.br_plunder.names.size ] = "brloot_plunder_cash_epic_2";
    level.br_plunder.names[ level.br_plunder.names.size ] = "brloot_plunder_cash_legendary_1";
    
    for ( i = 0; i < level.br_plunder.names.size ; i++ )
    {
        if ( utility::callsharedfunc( #"game", #"isCommonItemEnabled" ) )
        {
            /#
                if ( !isdefined( level.br_plunder.names[ i ] ) )
                {
                    assertmsg( "<dev string:x24>" + i + "<dev string:x69>" );
                }
            #/
            
            itembundlename = common_item_database::function_ca9ca606e66b5911( level.br_plunder.names[ i ] );
            
            /#
                if ( !isdefined( itembundlename ) )
                {
                    assertmsg( "<dev string:xa3>" + level.br_plunder.names[ i ] + "<dev string:xeb>" );
                }
            #/
            
            itembundle = getscriptbundle( itembundlename );
            
            /#
                if ( !isdefined( itembundle ) )
                {
                    assertmsg( "<dev string:x11a>" + getxhashsourcename( itembundlename ) + "<dev string:xeb>" );
                }
            #/
            
            level.br_plunder.quantity[ i ] = itembundle.spawncount;
        }
        else
        {
            level.br_plunder.quantity[ i ] = level.br_pickups.counts[ level.br_plunder.names[ i ] ];
        }
        
        if ( isdefined( level.br_plunder.quantity[ i - 1 ] ) )
        {
            assert( level.br_plunder.quantity[ i - 1 ] < level.br_plunder.quantity[ i ] );
        }
    }
}

// Namespace br_plunder
// Params 0
// Checksum 0x86317f71, Offset: 0x199e
// Size: 0x71
function initvo()
{
    assert( isdefined( game[ "<dev string:x165>" ] ) );
    game[ "dialog" ][ "plunder_extract_requested" ] = "pxrq_wzan_plnd";
    game[ "dialog" ][ "plunder_extract_chopper_arrive" ] = "pxcr_wzan_plnd";
    game[ "dialog" ][ "plunder_extract_chopper_leave" ] = "pxcl_wzan_plnd";
    game[ "dialog" ][ "plunder_extract_success" ] = "pxcl_wzan_plnd";
    game[ "dialog" ][ "plunder_extract_fail_chopper" ] = "pxfc_wzan_plnd";
}

// Namespace br_plunder
// Params 0
// Checksum 0x5c600abc, Offset: 0x1a17
// Size: 0x1d
function initplunderpads()
{
    level.plunderpads = getentarray( "extract_pad", #targetname );
}

// Namespace br_plunder
// Params 0
// Checksum 0x814ec14c, Offset: 0x1a3c
// Size: 0x49
function playerplaybankanim()
{
    if ( self isswitchingweapon() || self isreloading() || self ismantling() || self isthrowinggrenade() || self israisingweapon() || self ismeleeing() )
    {
        return;
    }
    
    pickups::playerplaygestureweaponanim( "iw8_ges_plyr_cash_handoff", 1.84 );
}

// Namespace br_plunder
// Params 0
// Checksum 0xe59d1471, Offset: 0x1a8d
// Size: 0x90
function playerremoveplunderfrominventory()
{
    foreach ( index, item in self.br_inventory_slots )
    {
        if ( item.scriptablename == "brloot_plunder_cash_uncommon_1" )
        {
            br_public::removeitemfrominventory( index );
            return;
        }
    }
}

// Namespace br_plunder
// Params 1
// Checksum 0xb6a5b5f5, Offset: 0x1b25
// Size: 0x72
function disablealldepotsforplayer( player )
{
    if ( isdefined( level.br_depots ) )
    {
        for ( i = 0; i < level.br_depots.size ; i++ )
        {
            depot = level.br_depots[ i ];
            
            if ( isdefined( depot ) && !depot.disabled )
            {
                depot depotmakeunusabletoplayer( player );
            }
        }
    }
}

// Namespace br_plunder
// Params 1
// Checksum 0xb7cdc63f, Offset: 0x1b9f
// Size: 0x65
function enablealldepotsforplayer( player )
{
    for ( i = 0; i < level.br_depots.size ; i++ )
    {
        depot = level.br_depots[ i ];
        
        if ( isdefined( depot ) && !depot.disabled )
        {
            depot depotmakeusabletoplayer( player );
        }
    }
}

// Namespace br_plunder
// Params 1
// Checksum 0x787ad89e, Offset: 0x1c0c
// Size: 0x33
function depotmakeusabletoplayer( player )
{
    self enableplayeruse( player );
    
    if ( isdefined( self.objectiveiconid ) )
    {
        objidpoolmanager::objective_playermask_addshowplayer( self.objectiveiconid, player );
    }
}

// Namespace br_plunder
// Params 1
// Checksum 0x4f038985, Offset: 0x1c47
// Size: 0x33
function depotmakeunusabletoplayer( player )
{
    self disableplayeruse( player );
    
    if ( isdefined( self.objectiveiconid ) )
    {
        objidpoolmanager::objective_playermask_hidefrom( self.objectiveiconid, player );
    }
}

// Namespace br_plunder
// Params 0
// Checksum 0x634f8eff, Offset: 0x1c82
// Size: 0x35
function depotmakeunsabletoall()
{
    self makeunusable();
    
    if ( isdefined( self.objectiveiconid ) )
    {
        objidpoolmanager::objective_playermask_hidefromall( self.objectiveiconid );
        objidpoolmanager::returnobjectiveid( self.objectiveiconid );
    }
}

// Namespace br_plunder
// Params 1
// Checksum 0xa45a2e70, Offset: 0x1cbf
// Size: 0xd6
function initplayer( revivespawn )
{
    if ( !level.br_plunder_enabled )
    {
        return;
    }
    
    if ( !isdefined( self.plundercount ) )
    {
        self.plundercount = 0;
    }
    
    if ( !isdefined( self.plunderbanked ) )
    {
        self.plunderbanked = 0;
    }
    
    if ( !isdefined( self.haspickedupplunderyet ) )
    {
        self.haspickedupplunderyet = 0;
    }
    
    if ( self.plundercount == 0 )
    {
        startplunder = 0;
        
        if ( !revivespawn && br_instance_inventory::function_926a8f8643d34690() )
        {
            br_instance_inventory::function_38fa0fc4dc8c6178( self );
            startplunder = br_instance_inventory::function_c9159ed09ca117f1( self );
            
            if ( !isdefined( startplunder ) )
            {
                startplunder = 0;
            }
        }
        
        /#
            spawnplunder = getdvarint( @"hash_729ed018713fcb98", 0 );
            
            if ( !revivespawn && spawnplunder > 0 )
            {
                startplunder = spawnplunder;
            }
        #/
        
        playersetplundercount( startplunder );
    }
}

// Namespace br_plunder
// Params 0
// Checksum 0x9fe8bc19, Offset: 0x1d9d
// Size: 0x18
function playerdropplunder()
{
    if ( !level.br_plunder_enabled )
    {
        return;
    }
    
    playersetplundercount( 0 );
}

// Namespace br_plunder
// Params 0
// Checksum 0xfdf2c693, Offset: 0x1dbd
// Size: 0xa3
function bankplunderongameended()
{
    level waittill( #"game_ended" );
    
    foreach ( player in level.players )
    {
        if ( player.plundercount > 0 )
        {
            player playerplunderbank( player.plundercount );
        }
    }
}

// Namespace br_plunder
// Params 4
// Checksum 0xd85cfc9a, Offset: 0x1e68
// Size: 0x16b
function function_b5a41a3178005069( dropstruct, attacker, allowautopickup, var_3b8f1509495546fd )
{
    save = getmatchrulesdata( "brData", "plunderSaveShare" );
    tax = getmatchrulesdata( "brData", "plunderTaxShare" );
    drop = getmatchrulesdata( "brData", "plunderDropShare" );
    totalshares = save + tax + drop;
    saverate = save / totalshares;
    taxrate = tax / totalshares;
    droprate = drop / totalshares;
    salvagecount = currency::get_currency_amount( level.gametypebundle.currencytype );
    var_2b3784454bd82637 = int( min( salvagecount, max( 2, int( salvagecount * saverate ) ) ) + 0.5 );
    var_f6626500e6e11057 = int( salvagecount * droprate );
    currency::set_currency_amount( "salvage", var_2b3784454bd82637 );
    
    if ( salvagecount > 0 && var_3b8f1509495546fd )
    {
        itembundlename = item_currency::function_a3eadb2d3c329589( "salvage", var_f6626500e6e11057 );
        var_3b8f1509495546fd.var_7a166247da860246[ var_3b8f1509495546fd.var_7a166247da860246.size ] = { #quantity:var_f6626500e6e11057, #itemname:itembundlename };
    }
}

// Namespace br_plunder
// Params 4
// Checksum 0x733a55bf, Offset: 0x1fdb
// Size: 0x314
function playerdropplunderondeath( dropstruct, attacker, allowautopickup, var_3b8f1509495546fd )
{
    if ( level.gametypebundle.currencytype == "salvage" )
    {
        function_b5a41a3178005069( dropstruct, attacker, allowautopickup, var_3b8f1509495546fd );
        return;
    }
    
    if ( !level.br_plunder_enabled )
    {
        return;
    }
    
    if ( !isdefined( dropstruct ) )
    {
        dropstruct = pickups::function_f71dd588dc4f6288();
    }
    
    if ( !isdefined( attacker ) )
    {
        attacker = self.attacker ?? self;
    }
    
    if ( utility::callsharedfunc( #"gametype", #"hash_c58d6a4317d0041e", dropstruct, attacker ) )
    {
        return;
    }
    
    var_c0f42c655201487f = self.attacker != self;
    dropinfo = function_45807c0351387038( var_c0f42c655201487f );
    var_a6085d27206e04f0 = dropinfo.var_a6085d27206e04f0;
    var_f8cbc86c55703cf4 = dropinfo.var_f8cbc86c55703cf4;
    currentplunder = dropinfo.plundercount;
    self.plundercountondeath = var_a6085d27206e04f0;
    
    if ( utility::callsharedfunc( #"game", #"isCommonItemEnabled" ) )
    {
        currencytype = level.gametypebundle.currencytype ?? "cash";
        currency::set_currency_amount( "cash", var_a6085d27206e04f0 );
    }
    else
    {
        playersetplundercount( var_a6085d27206e04f0 );
    }
    
    if ( var_f8cbc86c55703cf4 <= 0 )
    {
        return;
    }
    
    plundermod = 1;
    
    if ( self.wasexecuted && isdefined( level.executioncashmultiplier ) )
    {
        plundermod *= level.executioncashmultiplier;
    }
    
    if ( br_publicevents::ispubliceventoftypeactive( %"bloodmoney" ) )
    {
        if ( self.wasexecuted )
        {
            plundermod *= level.br_pe_data[ %"bloodmoney" ].var_c2a36c673b8054d5;
        }
        else
        {
            plundermod *= level.br_pe_data[ %"bloodmoney" ].var_cbb382bf8ba8d81;
        }
    }
    
    if ( isdefined( level.activitymanager ) )
    {
        foreach ( activity in level.activitymanager.var_cc0e4315eede2fec )
        {
            if ( activity.type == "BR_PUBLIC_EVENT_BLOOD_MONEY" )
            {
                if ( self.wasexecuted )
                {
                    plundermod *= activity.var_332f929de1894b2b.executedmultiplier;
                }
                else
                {
                    plundermod *= activity.var_332f929de1894b2b.killmultiplier;
                }
                
                break;
            }
        }
    }
    
    var_f8cbc86c55703cf4 *= plundermod;
    dropstruct.plunder_drop_team = self.team;
    dropcondensedplunder( var_f8cbc86c55703cf4, dropstruct, allowautopickup, var_3b8f1509495546fd );
}

// Namespace br_plunder
// Params 1
// Checksum 0x1da7ee7a, Offset: 0x22f7
// Size: 0x2e5
function function_45807c0351387038( var_c0f42c655201487f )
{
    inflation = getmatchrulesdata( "brData", "plunderInflation" );
    save = getmatchrulesdata( "brData", "plunderSaveShare" );
    tax = getmatchrulesdata( "brData", "plunderTaxShare" );
    drop = getmatchrulesdata( "brData", "plunderDropShare" );
    
    if ( utility::callsharedfunc( #"loot", #"hash_38773b70c1236b0d", "life_insurance" ) )
    {
        insurance = getdvarfloat( @"hash_8c811d887e1f3fa0", 10 );
        save += insurance;
    }
    
    if ( isdefined( self.var_d0d222d2577ebcbf ) )
    {
        newtax = tax * self.var_d0d222d2577ebcbf;
        newdrop = drop * self.var_d0d222d2577ebcbf;
        save += drop - newdrop + tax - newtax;
        drop = newdrop;
        tax = newtax;
    }
    
    if ( utility::callsharedfunc( #"game", #"isCommonItemEnabled" ) )
    {
        plundercount = currency::get_currency_amount( level.gametypebundle.currencytype );
    }
    else
    {
        plundercount = self.plundercount;
    }
    
    if ( isdefined( self.plundercount ) && self.plundercount > 0 )
    {
        plunderinhand = self.plundercount * inflation;
    }
    else
    {
        plunderinhand = 0;
    }
    
    totalshares = save + tax + drop;
    saverate = save / totalshares;
    droprate = drop / totalshares;
    plunderinhand = int( plunderinhand );
    
    if ( isdefined( level.gulag ) && br_public::isplayeringulag() )
    {
        var_a6085d27206e04f0 = plunderinhand;
        var_f8cbc86c55703cf4 = 0;
    }
    else
    {
        minplunderdropondeath = var_c0f42c655201487f ? level.minplunderdropondeath : 0;
        var_4b3cf772a42d22cb = int( min( plunderinhand, int( plunderinhand * saverate ) ) );
        var_4c05d4e4fc75250f = int( max( minplunderdropondeath, int( plunderinhand * droprate ) ) );
        var_1ed1e9a90fe6c429 = round( min( plunderinhand, int( plunderinhand * saverate / 10 ) * 10 ) );
        var_858fd2be9de91075 = round( max( minplunderdropondeath, int( plunderinhand * droprate / 10 ) * 10 ) );
        var_29cda66d58f5a7df = var_4b3cf772a42d22cb - var_1ed1e9a90fe6c429 + var_4c05d4e4fc75250f - var_858fd2be9de91075;
        var_1ed1e9a90fe6c429 = round( ( var_1ed1e9a90fe6c429 + var_29cda66d58f5a7df ) / 10 ) * 10;
    }
    
    dropinfo = spawnstruct();
    dropinfo.var_a6085d27206e04f0 = int( var_1ed1e9a90fe6c429 );
    dropinfo.var_f8cbc86c55703cf4 = int( var_858fd2be9de91075 );
    dropinfo.plundercount = plundercount;
    return dropinfo;
}

// Namespace br_plunder
// Params 1
// Checksum 0x109a0846, Offset: 0x25e5
// Size: 0x231
function takeplunderpickup( pickupent )
{
    if ( !level.br_plunder_enabled )
    {
        return;
    }
    
    amount = 1;
    
    if ( isdefined( pickupent.count ) )
    {
        amount = pickupent.count;
    }
    
    if ( arraycontains( level.br_plunder.names, pickupent.scriptablename ) )
    {
        dropped_by_player = isdefined( pickupent.instance ) && pickupent.instance.var_7971994d2364af58;
        drop_team = isdefined( pickupent.instance ) ? pickupent.instance.drop_team : undefined;
        data = { #drop_team:drop_team, #dropped_by_player:dropped_by_player };
        playerplunderpickup( amount, data, undefined, 1 );
        level.br_plunder.plunder_items_picked_up += 1;
        level.br_plunder.plunder_value_picked_up += amount;
        modify_plunder_itemsinworld( pickupent.scriptablename, -1 );
        type = "loot";
        
        if ( isdefined( pickupent.instance ) && isdefined( pickupent.instance.lootsource ) )
        {
            type = pickupent.instance.lootsource;
        }
        
        br_analytics::trackcashevent( self, type, amount );
        
        if ( dropped_by_player )
        {
            return;
        }
        
        function_d7efc5a9b599e020( 0, amount );
    }
    else
    {
        br_pickups::trypickupitem( pickupent.scriptablename, amount );
    }
    
    params = { #amount:amount, #pickupent:pickupent };
    callback::callback( #"plunder_pickup", params );
    level notify( "collect_cash_" + self.team, self, pickupent.count );
}

// Namespace br_plunder
// Params 0
// Checksum 0x3c50e7f5, Offset: 0x281e
// Size: 0x80
function initplayerplunderevents()
{
    omnvars = [];
    omnvars[ 1 ] = "ui_cash_pickedup";
    omnvars[ 2 ] = "ui_cash_pickedup";
    level.playerplundereventomnvars = omnvars;
    callbacks = [];
    callbacks[ 1 ] = &playerplunderpickupcallback;
    callbacks[ 2 ] = &playerplunderdepositcallback;
    callbacks[ 3 ] = &playerplunderbankcallback;
    callbacks[ 4 ] = &playerplunderlosecallback;
    callbacks[ 5 ] = &playerplunderbankdepositcallback;
    callbacks[ 6 ] = &playerplunderlosedepositcallback;
    level.playerplundereventcallbacks = callbacks;
}

// Namespace br_plunder
// Params 4
// Checksum 0x751a8ebf, Offset: 0x28a6
// Size: 0x62
function playerplunderpickup( amount, data, wasscoreevent, var_d2ccc8d0cad2df42 )
{
    if ( utility::callsharedfunc( #"game", #"isCommonItemEnabled" ) )
    {
        currency::add_currency_amount( "cash", amount );
        return;
    }
    
    data = playerplunderevent( amount, 1, undefined, data, wasscoreevent, var_d2ccc8d0cad2df42 );
}

// Namespace br_plunder
// Params 3
// Checksum 0xf16ba70e, Offset: 0x2910
// Size: 0x2b
function playerplunderdeposit( amount, entity, data )
{
    return playerplunderevent( amount, 2, entity, data );
}

// Namespace br_plunder
// Params 3
// Checksum 0xf232f9c6, Offset: 0x2944
// Size: 0x72
function playerplunderbank( amount, entity, data )
{
    if ( utility::callsharedfunc( #"game", #"isCommonItemEnabled" ) )
    {
        data = playerplunderbankcallback( amount, entity, data );
        function_408935a50816b5c6( data, 3 );
        currency::function_b5fe1e05c892a7f3( "cash", amount );
        return data;
    }
    
    return playerplunderevent( amount, 3, entity, data );
}

// Namespace br_plunder
// Params 2
// Checksum 0xe9cace8b, Offset: 0x29be
// Size: 0x4c
function playerplunderlose( amount, data )
{
    if ( utility::callsharedfunc( #"game", #"isCommonItemEnabled" ) )
    {
        currency::function_b5fe1e05c892a7f3( "cash", amount );
        return;
    }
    
    return playerplunderevent( amount, 4, undefined, data );
}

// Namespace br_plunder
// Params 3
// Checksum 0x62f848ae, Offset: 0x2a13
// Size: 0x60
function playerplunderbankdeposit( amount, entity, data )
{
    if ( utility::callsharedfunc( #"game", #"isCommonItemEnabled" ) )
    {
        data = playerplunderbankdepositcallback( amount, entity, data );
        function_408935a50816b5c6( data, 5 );
        return data;
    }
    
    return playerplunderevent( amount, 5, entity, data );
}

// Namespace br_plunder
// Params 3
// Checksum 0x2080c0ea, Offset: 0x2a7c
// Size: 0x2b
function playerplunderlosedeposit( amount, entity, data )
{
    return playerplunderevent( amount, 6, entity, data );
}

// Namespace br_plunder
// Params 2
// Checksum 0xa1d0d356, Offset: 0x2ab0
// Size: 0x82
function playerplunderkioskpurchase( amount, data )
{
    resultdata = playerplunderevent( amount, 4, undefined, data );
    
    if ( isdefined( resultdata ) )
    {
        perskey = "highestPurchaseCost";
        
        if ( !isdefined( self.pers[ perskey ] ) || self.pers[ perskey ] < amount )
        {
            self.pers[ perskey ] = amount;
        }
    }
    
    function_d7efc5a9b599e020( 4, amount );
    return resultdata;
}

// Namespace br_plunder
// Params 2
// Checksum 0x7e0674c4, Offset: 0x2b3b
// Size: 0x22
function playerplunderdrop( amount, data )
{
    return playerplunderevent( amount, 4, undefined, data );
}

// Namespace br_plunder
// Params 2
// Checksum 0x7a679021, Offset: 0x2b66
// Size: 0x22
function function_5d6f431a1b30d50b( amount, data )
{
    return playerplunderevent( amount, 1, undefined, data );
}

// Namespace br_plunder
// Params 6
// Checksum 0xe085f556, Offset: 0x2b91
// Size: 0x34a
function playerplunderevent( amount, type, entity, data, wasscoreevent, var_d2ccc8d0cad2df42 )
{
    if ( !level.br_plunder_enabled || !isdefined( self.plundercount ) )
    {
        return;
    }
    
    if ( wasscoreevent && amount <= 0 )
    {
        return;
    }
    
    /#
        if ( level.gameended && amount == 0 )
        {
            return;
        }
    #/
    
    assert( isdefined( level.playerplundereventomnvars ), "<dev string:x16c>" );
    assert( amount > 0, "<dev string:x1ae>" );
    
    /#
        validtype = validateplundereventtype( type );
        
        if ( !validtype )
        {
            assertmsg( "<dev string:x227>" );
        }
    #/
    
    if ( type == 2 || type == 3 || type == 4 )
    {
        amount = int( min( self.plundercount, amount ) );
    }
    
    if ( type == 1 && isdefined( self.plunder_pickup_multiplier ) && isdefined( data ) && !data.dropped_by_player )
    {
        is_teammate_drop = self.team == data.drop_team;
        
        if ( !is_teammate_drop )
        {
            amount = int( amount * max( 1, self.plunder_pickup_multiplier ) );
        }
    }
    
    if ( !isdefined( self.plundereventtime ) )
    {
        self.plundereventtime = [];
    }
    
    if ( !isdefined( self.plundereventtotal ) )
    {
        self.plundereventtotal = [];
    }
    
    if ( !isdefined( self.lastplundereventtype ) )
    {
        self.lastplundereventtype = 0;
    }
    
    omnvartype = type == 5 ? 3 : type;
    omnvar = level.playerplundereventomnvars[ omnvartype ];
    plundereventtotal = self.plundereventtotal[ type ];
    plundereventtime = self.plundereventtime[ type ];
    
    if ( !isdefined( plundereventtime ) || gettime() - plundereventtime > 2000 )
    {
        plundereventtotal = 0;
    }
    
    plundereventtotal += amount;
    
    if ( isplayer( self ) && isdefined( omnvar ) )
    {
        omnvarvalue = int( min( plundereventtotal, self.plundercount + amount ) );
        self setclientomnvar( omnvar, omnvarvalue );
    }
    
    self.lastplundereventtype = type;
    self.plundereventtime[ type ] = gettime();
    self.plundereventtotal[ type ] = plundereventtotal;
    plundereventcallback = level.playerplundereventcallbacks[ type ];
    
    if ( isdefined( plundereventcallback ) )
    {
        data = self [[ plundereventcallback ]]( amount, entity, data );
    }
    
    function_408935a50816b5c6( data, type, var_d2ccc8d0cad2df42 );
    
    switch ( type )
    {
        case 2:
        case 3:
        case 4:
            amount *= -1;
            break;
        case 5:
        case 6:
            amount = 0;
            break;
        case 1:
            break;
    }
    
    if ( isdefined( amount ) )
    {
        data.plunderdelta = amount;
        thread playersetplundercount( self.plundercount + amount, data );
    }
    
    return data;
}

// Namespace br_plunder
// Params 3
// Checksum 0x26c09f8b, Offset: 0x2ee4
// Size: 0x1f5
function function_408935a50816b5c6( data, type, var_d2ccc8d0cad2df42 )
{
    if ( !isdefined( data ) && !var_d2ccc8d0cad2df42 )
    {
        return;
    }
    
    if ( isdefined( data.player ) )
    {
        if ( isdefined( data.playersplash ) && data.playersplash != "none" && !data.player br_public::isplayerinorgoingtogulag() )
        {
            if ( data.playersplash != "br_plunder_first_pickup" || !data.player.haspickedupplunderyet && getdvarint( @"hash_9da2f1ebed58b0de", 0 ) == 0 )
            {
                if ( !game_utility::function_a43ada404e8c591f() )
                {
                    data.player thread hud_message::showsplash( data.playersplash, undefined, undefined, undefined, undefined, data.overridesplashlist );
                }
                
                if ( data.playersplash == "br_plunder_first_pickup" )
                {
                    data.player.haspickedupplunderyet = 1;
                }
            }
        }
        
        if ( isdefined( data.playerscoreeventref ) && ( !isdefined( data.playerscoreeventvalue ) || data.playerscoreeventvalue > 0 ) )
        {
            data.player thread points::doscoreevent( data.playerscoreeventref, undefined, data.playerscoreeventvalue );
        }
    }
    
    if ( data.playanimation )
    {
        if ( type == 3 )
        {
            thread playerplaybankanim();
        }
        else if ( type == 2 )
        {
            thread playerplaydepositanim();
        }
    }
    
    if ( isdefined( data.amount ) )
    {
        amount = data.amount;
    }
    
    if ( data.playplundersound && ( type == 3 || type == 2 ) )
    {
        self playsoundtoplayer( "fly_pickup_cash_01", self );
    }
}

// Namespace br_plunder
// Params 2
// Checksum 0x3c42ebb9, Offset: 0x30e1
// Size: 0x9e
function function_d7efc5a9b599e020( trackingtype, amount )
{
    if ( game_utility::getgametype() != "plunder" )
    {
        return;
    }
    
    if ( !isdefined( self.plundertracking ) )
    {
        self.plundertracking = [];
        self.plundertracking[ 0 ] = 0;
        self.plundertracking[ 1 ] = 0;
        self.plundertracking[ 2 ] = 0;
        self.plundertracking[ 3 ] = 0;
        self.plundertracking[ 4 ] = 0;
    }
    
    self.plundertracking[ trackingtype ] += amount;
}

// Namespace br_plunder
// Params 1
// Checksum 0x4557f45b, Offset: 0x3187
// Size: 0xf4
function packextrascore0( data )
{
    if ( !isbrgamemode() )
    {
        return;
    }
    
    if ( game_utility::getgametype() == "kingslayer" || game_utility::getgametype() == "resurgence" || game_utility::getgametype() == "zonecontrol" )
    {
        return;
    }
    
    packedvalue = 0;
    cashvalue = 0;
    
    if ( isdefined( self.plundercount ) )
    {
        cashvalue += self.plundercount;
    }
    
    if ( isdefined( self.plunderbanked ) )
    {
        cashvalue += self.plunderbanked;
    }
    
    cashvalue = int( cashvalue / 10 );
    
    if ( cashvalue > 4095 )
    {
        cashvalue = 4095;
    }
    
    packedvalue = cashvalue;
    missionvalue = 0;
    
    if ( isdefined( self.brmissionscompleted ) )
    {
        missionvalue += self.brmissionscompleted;
    }
    
    if ( missionvalue > 15 )
    {
        missionvalue = 15;
    }
    
    packedvalue += missionvalue << 12;
    stats::setextrascore0( packedvalue );
}

// Namespace br_plunder
// Params 1
// Checksum 0xe0d47aa, Offset: 0x3283
// Size: 0x78
function validateplundereventtype( type )
{
    if ( !isdefined( type ) )
    {
        return 0;
    }
    
    switch ( type )
    {
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
            return 1;
        default:
            return 0;
    }
}

// Namespace br_plunder
// Params 3
// Checksum 0xf2b050e3, Offset: 0x3303
// Size: 0x53
function playerplunderpickupcallback( amount, entity, data = createplayerplundereventdata( self ) )
{
    if ( !self.haspickedupplunderyet )
    {
        data.playersplash = "br_plunder_first_pickup";
        thread br_armory_kiosk::showdiscountsplash();
    }
    
    return data;
}

// Namespace br_plunder
// Params 3
// Checksum 0xf9960e77, Offset: 0x335f
// Size: 0x2a0
function playerplunderdepositcallback( amount, entity, data = createplayerplundereventdata( self ) )
{
    if ( !isdefined( data.playplundersound ) )
    {
        data.playplundersound = 1;
        data.plundersoundamount = undefined;
    }
    
    if ( !isdefined( data.playanimation ) )
    {
        data.playanimation = 1;
    }
    
    if ( isdefined( entity ) )
    {
        leveldataforrepository = plunder_getleveldataforrepository( entity.plunderrepositoryref );
        
        if ( leveldataforrepository.capacity > 0 )
        {
            overflow = entity.plundertotal + amount - leveldataforrepository.capacity;
            
            if ( overflow >= 0 )
            {
                amount -= overflow;
                
                if ( !entity.plunderatcapacity )
                {
                    plunder_repositoryatcapacity( entity );
                }
            }
        }
        
        append = 1;
        
        foreach ( entry in entity.plunder )
        {
            player = entry.player;
            
            if ( player == self )
            {
                entry.plundercount += amount;
                append = 0;
                break;
            }
        }
        
        if ( append )
        {
            entry = spawnstruct();
            entry.player = self;
            entry.team = self.team;
            entry.plundercount = amount;
            entity.plunder[ entity.plunder.size ] = entry;
        }
    }
    
    data.amount = amount;
    entity.plundertotal += amount;
    
    if ( !isdefined( level.teamdata[ self.team ][ "plunderInDeposit" ] ) )
    {
        level.teamdata[ self.team ][ "plunderInDeposit" ] = int( amount );
    }
    else
    {
        level.teamdata[ self.team ][ "plunderInDeposit" ] = level.teamdata[ self.team ][ "plunderInDeposit" ] + int( amount );
    }
    
    return data;
}

// Namespace br_plunder
// Params 3
// Checksum 0xf9c234b7, Offset: 0x3608
// Size: 0x258
function playerplunderbankcallback( amount, entity, data )
{
    assert( amount <= self.plundercount, "<dev string:x257>" );
    
    if ( !isdefined( data ) )
    {
        data = createplayerplundereventdata( self );
    }
    
    if ( !isdefined( data.playersplash ) )
    {
        data.playersplash = "br_plunder_banked";
    }
    
    if ( game_utility::getgametype() == "plunder" )
    {
        data.overridesplashlist = "splash_list_br_plunder_iw9_mp";
    }
    
    if ( !isdefined( data.playerscoreeventref ) )
    {
        gametype = game_utility::getgametype();
        data.playerscoreeventref = gametype == "plunder" || gametype == "risk" ? #"plunder_cash_blood_money" : #"plunder_cash";
    }
    
    if ( !isdefined( data.playerscoreeventvalue ) )
    {
        data.playerscoreeventvalue = int( ( rank::getscoreinfovalue( data.playerscoreeventref ) ?? 1 ) * amount / 10 );
    }
    
    if ( !isdefined( data.playplundersound ) )
    {
        data.playplundersound = 1;
        data.plundersoundamount = undefined;
    }
    
    if ( !isdefined( data.playanimation ) )
    {
        data.playanimation = 1;
    }
    
    self.plunderbanked += amount;
    
    if ( isdefined( level.br_plunder ) && self.plunderbanked > level.br_plunder.plunderlimit )
    {
        self.plunderbanked = level.br_plunder.plunderlimit;
    }
    
    challenges::function_2674338fc4026deb( amount * 100 );
    
    if ( !isdefined( level.teamdata[ self.team ][ "plunderBanked" ] ) )
    {
        level.teamdata[ self.team ][ "plunderBanked" ] = amount;
    }
    else
    {
        level.teamdata[ self.team ][ "plunderBanked" ] = level.teamdata[ self.team ][ "plunderBanked" ] + amount;
    }
    
    utility::callsharedfunc( #"gametype", #"hash_4b66ccf48a0d93c5", data );
    return data;
}

// Namespace br_plunder
// Params 3
// Checksum 0x9a6ebd48, Offset: 0x3869
// Size: 0x2e
function playerplunderlosecallback( amount, entity, data = createplayerplundereventdata( self ) )
{
    return data;
}

// Namespace br_plunder
// Params 3
// Checksum 0x248ca47d, Offset: 0x38a0
// Size: 0x2d7
function playerplunderbankdepositcallback( amount, entity, data = createplayerplundereventdata( self ) )
{
    if ( !isdefined( data.plundersoundamount ) )
    {
        data.plundersoundamount = 0;
    }
    
    data.setplunderifunchanged = 1;
    team = self.team;
    
    if ( isdefined( entity ) && isdefined( entity.plunder ) )
    {
        foreach ( id, entry in entity.plunder )
        {
            if ( entry.player == self )
            {
                team = entry.team;
                
                if ( !isdefined( amount ) )
                {
                    amount = entry.plundercount;
                }
                else
                {
                    amount = min( amount, entry.plundercount );
                }
                
                entry.plundercount -= amount;
                
                if ( entry.plundercount == 0 )
                {
                    entity.plunder[ id ] = undefined;
                }
                
                self.plunderbanked += amount;
                
                if ( isdefined( level.br_plunder ) && self.plunderbanked > level.br_plunder.plunderlimit )
                {
                    self.plunderbanked = level.br_plunder.plunderlimit;
                }
                
                break;
            }
        }
        
        if ( !isdefined( data.playerscoreeventref ) )
        {
            gametype = game_utility::getgametype();
            data.playerscoreeventref = gametype == "plunder" || gametype == "risk" ? #"plunder_cash_blood_money" : #"plunder_cash";
        }
        
        if ( !isdefined( data.playerscoreeventvalue ) )
        {
            data.playerscoreeventvalue = int( ( rank::getscoreinfovalue( data.playerscoreeventref ) ?? 1 ) * amount / 10 );
        }
    }
    
    amount = int( amount );
    level.teamdata[ team ][ "plunderInDeposit" ] = level.teamdata[ team ][ "plunderInDeposit" ] - amount;
    level.teamdata[ team ][ "plunderBanked" ] = level.teamdata[ team ][ "plunderBanked" ] + amount;
    utility::callsharedfunc( #"gametype", #"hash_4b66ccf48a0d93c5", data );
    return data;
}

// Namespace br_plunder
// Params 3
// Checksum 0x81b6658b, Offset: 0x3b80
// Size: 0x188
function playerplunderlosedepositcallback( amount, entity, data = createplayerplundereventdata( self ) )
{
    data.setplunderifunchanged = 1;
    team = self.team;
    
    if ( isdefined( entity ) && isdefined( entity.plunder ) )
    {
        foreach ( id, entry in entity.plunder )
        {
            if ( entry.player == self )
            {
                team = entry.team;
                
                if ( !isdefined( amount ) )
                {
                    amount = entry.plundercount;
                }
                else
                {
                    amount = min( amount, entry.plundercount );
                }
                
                entry.plundercount -= amount;
                
                if ( entry.plundercount == 0 )
                {
                    entity.plunder[ id ] = undefined;
                }
                
                break;
            }
        }
    }
    
    amount = int( amount );
    level.teamdata[ team ][ "plunderInDeposit" ] = level.teamdata[ team ][ "plunderInDeposit" ] - amount;
    return data;
}

// Namespace br_plunder
// Params 1
// Checksum 0x9896fd1c, Offset: 0x3d11
// Size: 0x434
function entityplunderbankalldeposited( data )
{
    if ( !isdefined( self.plunder ) )
    {
        return;
    }
    
    if ( !isdefined( data ) )
    {
        data = createplayerplundereventdata();
    }
    
    data.amounttotal = 0;
    data.teams = [];
    data.numdepositers = 0;
    
    foreach ( id, entry in self.plunder )
    {
        if ( isdefined( entry.player ) || entry.plundercount <= 0 )
        {
            continue;
        }
        
        team = entry.team;
        amount = entry.plundercount;
        assert( isdefined( entry.team ), "<dev string:x285>" );
        level.teamdata[ team ][ "plunderInDeposit" ] = level.teamdata[ team ][ "plunderInDeposit" ] - amount;
        level.teamdata[ team ][ "plunderBanked" ] = level.teamdata[ team ][ "plunderBanked" ] + amount;
        data.amounttotal += amount;
        data.teams[ data.teams.size ] = team;
        self.plunder[ id ] = undefined;
    }
    
    foreach ( entry in self.plunder )
    {
        if ( entry.plundercount <= 0 )
        {
            continue;
        }
        
        player = entry.player;
        team = entry.team;
        amount = entry.plundercount;
        _data = undefined;
        
        if ( isdefined( data ) )
        {
            _data = copyplayerplundereventdata( data, player, team );
        }
        
        _data.dontcallpostplunder = 1;
        _data = player playerplunderbankdeposit( amount, self, _data );
        
        if ( isdefined( _data ) && isdefined( _data.amount ) )
        {
            amount = _data.amount;
        }
        
        data.amounttotal += amount;
        data.teams[ data.teams.size ] = team;
        data.numdepositers++;
    }
    
    method = "fulton";
    
    if ( self.classname == "script_vehicle" )
    {
        method = "little_bird";
    }
    
    data.teams = arrayremoveduplicates( data.teams );
    containsenemyplunder = 0;
    
    if ( data.teams.size > 1 )
    {
        containsenemyplunder = 1;
    }
    else if ( data.teams.size == 1 && data.teams[ 0 ] != self.team )
    {
        containsenemyplunder = 1;
    }
    
    leveldataforrepository = plunder_getleveldataforrepository( self.plunderrepositoryref, undefined, 1 );
    
    if ( isdefined( leveldataforrepository ) && isdefined( leveldataforrepository.extractionmethod ) )
    {
        br_analytics::branalytics_plunder_extraction_success( data.numdepositers, data.amounttotal, leveldataforrepository.extractionmethod, containsenemyplunder, self.origin );
    }
    
    if ( !isdefined( data ) || !data.dontcallpostplunder )
    {
        thread utility::callsharedfunc( #"gametype", #"hash_734dfff09080996f", data );
    }
    
    self.plunder = [];
    return data;
}

// Namespace br_plunder
// Params 2
// Checksum 0x632fba97, Offset: 0x414e
// Size: 0x339
function entityplunderlosealldeposited( dropplunder, data )
{
    if ( !isdefined( self.plunder ) )
    {
        return;
    }
    
    if ( !isdefined( data ) )
    {
        data = createplayerplundereventdata();
    }
    
    data.amounttotal = 0;
    data.teams = [];
    totalamount = 0;
    
    foreach ( id, entry in self.plunder )
    {
        if ( isdefined( entry.player ) || entry.plundercount <= 0 )
        {
            continue;
        }
        
        team = entry.team;
        amount = entry.plundercount;
        assert( isdefined( entry.team ), "<dev string:x285>" );
        level.teamdata[ team ][ "plunderInDeposit" ] = level.teamdata[ team ][ "plunderInDeposit" ] - amount;
        data.amounttotal += amount;
        data.teams[ data.teams.size ] = team;
        self.plunder[ id ] = undefined;
    }
    
    foreach ( entry in self.plunder )
    {
        if ( entry.plundercount <= 0 )
        {
            continue;
        }
        
        player = entry.player;
        team = entry.team;
        amount = entry.plundercount;
        _data = undefined;
        
        if ( isdefined( data ) )
        {
            _data = copyplayerplundereventdata( data, player, team );
        }
        
        _data.dontcallpostplunder = 1;
        player playerplunderlosedeposit( amount, self, _data );
        
        if ( isdefined( _data ) && isdefined( _data.amount ) )
        {
            amount = _data.amount;
        }
        
        data.amounttotal += amount;
        data.teams[ data.teams.size ] = team;
        totalamount += amount;
    }
    
    if ( !isdefined( data ) || !data.dontcallpostplunder )
    {
        thread utility::callsharedfunc( #"gametype", #"hash_734dfff09080996f", data );
    }
    
    self.plunder = [];
    
    if ( dropplunder )
    {
        dropstruct = pickups::function_f71dd588dc4f6288();
        dropplunderbyrarity( data.amounttotal, dropstruct );
    }
    
    return data;
}

// Namespace br_plunder
// Params 2
// Checksum 0xb79d3aca, Offset: 0x4490
// Size: 0x93
function createplayerplundereventdata( player, team )
{
    data = spawnstruct();
    data.player = undefined;
    
    if ( isdefined( player ) )
    {
        data.player = player;
    }
    
    data.playersplash = undefined;
    data.playerscoreeventref = undefined;
    data.playerscoreeventvalue = undefined;
    data.setplunderifunchanged = undefined;
    data.playplundersound = undefined;
    data.plundersoundamount = undefined;
    data.playanimation = undefined;
    return data;
}

// Namespace br_plunder
// Params 3
// Checksum 0xf8cfc006, Offset: 0x452c
// Size: 0x186
function copyplayerplundereventdata( var_64682bf0418f963a, player, team )
{
    data = createplayerplundereventdata();
    
    if ( isdefined( var_64682bf0418f963a.player ) )
    {
        data.player = var_64682bf0418f963a.player;
        player = var_64682bf0418f963a.player;
    }
    else if ( isdefined( player ) )
    {
        data.player = player;
    }
    
    if ( isdefined( var_64682bf0418f963a.playersplash ) )
    {
        data.playersplash = var_64682bf0418f963a.playersplash;
    }
    
    if ( isdefined( var_64682bf0418f963a.playerscoreeventref ) )
    {
        data.playerscoreeventref = var_64682bf0418f963a.playerscoreeventref;
    }
    
    if ( isdefined( var_64682bf0418f963a.playerscoreeventvalue ) )
    {
        data.playerscoreeventvalue = var_64682bf0418f963a.playerscoreeventvalue;
    }
    
    if ( isdefined( var_64682bf0418f963a.setplunderifunchanged ) )
    {
        data.setplunderifunchanged = var_64682bf0418f963a.setplunderifunchanged;
    }
    
    if ( isdefined( var_64682bf0418f963a.playplundersound ) )
    {
        data.playplundersound = var_64682bf0418f963a.playplundersound;
    }
    
    if ( isdefined( var_64682bf0418f963a.plundersoundamount ) )
    {
        data.plundersoundamount = var_64682bf0418f963a.plundersoundamount;
    }
    
    if ( isdefined( var_64682bf0418f963a.playanimation ) )
    {
        data.playanimation = var_64682bf0418f963a.playanimation;
    }
    
    return data;
}

// Namespace br_plunder
// Params 0
// Checksum 0x9442e1e5, Offset: 0x46bb
// Size: 0x3a
function function_3c61b4a05ec0b894()
{
    if ( utility::callsharedfunc( #"game", #"isCommonItemEnabled" ) )
    {
        return currency::get_currency_amount( "cash" );
    }
    
    return self.plundercount ?? 0;
}

// Namespace br_plunder
// Params 2
// Checksum 0x90cbfb50, Offset: 0x46fd
// Size: 0x2d3
function playersetplundercount( plundercount, data )
{
    if ( isbot( self ) || isautopilot( self ) )
    {
        if ( isdefined( self._blackboard ) )
        {
            self._blackboard.var_2b77845002145c3a = plundercount;
        }
    }
    
    if ( utility::callsharedfunc( #"game", #"isCommonItemEnabled" ) )
    {
        currency::set_currency_amount( "cash", plundercount );
        return;
    }
    
    if ( !isdefined( self.plundercount ) )
    {
        self.plundercount = 0;
    }
    
    if ( !level.br_plunder_enabled )
    {
        return;
    }
    
    plunderdelta = plundercount - self.plundercount;
    
    if ( ( !isdefined( data ) || !data.setplunderifunchanged ) && plunderdelta == 0 )
    {
        return;
    }
    
    assert( isint( plundercount ) );
    self.plundercount = plundercount;
    
    if ( isdefined( level.br_plunder ) && self.plundercount > level.br_plunder.plunderlimit )
    {
        hud_message::showerrormessage( %"mp_br_ingame/plunder_held_limit_reached" );
        self.plundercount = level.br_plunder.plunderlimit;
    }
    
    if ( isdefined( level.secondaryvictory ) && isdefined( level.secondaryvictory.var_64e27faf32a25d5d ) )
    {
        self [[ level.secondaryvictory.var_64e27faf32a25d5d ]]();
    }
    
    amount = self.plundercount;
    playersetplunderomnvar( amount );
    
    if ( plundercount > 0 )
    {
        if ( level.plunderusedisabledwhenempty && plunderdelta != 0 )
        {
            plunder_allowallrepositoryuseforplayer( self, 1, 1 );
        }
        
        enablealldepotsforplayer( self );
        
        if ( inplunderlivelobby() && plundercount >= 10 )
        {
            thread playerdelayautobankplunder();
        }
    }
    else
    {
        if ( level.plunderusedisabledwhenempty && plunderdelta != 0 )
        {
            plunder_allowallrepositoryuseforplayer( self, 0, 1 );
        }
        
        disablealldepotsforplayer( self );
    }
    
    if ( isdefined( data ) && isdefined( data.plunderdelta ) )
    {
        plunderdelta = data.plunderdelta;
    }
    
    if ( plunderdelta != 0 )
    {
        if ( !isdefined( level.teamdata[ self.team ][ "plunderTeamTotal" ] ) )
        {
            level.teamdata[ self.team ][ "plunderTeamTotal" ] = 0;
        }
        
        level.teamdata[ self.team ][ "plunderTeamTotal" ] = level.teamdata[ self.team ][ "plunderTeamTotal" ] + plunderdelta;
    }
    
    if ( !isdefined( data ) || !data.dontcallpostplunder )
    {
        thread utility::callsharedfunc( #"gametype", #"hash_734dfff09080996f", data );
    }
}

// Namespace br_plunder
// Params 1
// Checksum 0x50e8663e, Offset: 0x49d8
// Size: 0x15
function playersetplunderomnvar( value )
{
    cash::playersetplunderomnvar( value );
}

// Namespace br_plunder
// Params 4
// Checksum 0x99812961, Offset: 0x49f5
// Size: 0x79
function getpackeddata( value, var_fc55d9b25a5504f6, bitoffset, bitwidth )
{
    mask = ( 1 << bitwidth ) - 1;
    shiftedvalue = ( value & mask ) << bitoffset;
    invertedmask = ~( mask << bitoffset );
    cleanedbase = var_fc55d9b25a5504f6 & invertedmask;
    repackedvalue = cleanedbase + shiftedvalue;
    return repackedvalue;
}

// Namespace br_plunder
// Params 0
// Checksum 0xadbfbe0c, Offset: 0x4a77
// Size: 0x17b
function playergetplunderomnvarbitpackinginfo()
{
    bitoffset = 0;
    bitwidth = 0;
    var_48646764f8a928fa = "";
    
    switch ( self.sessionuimemberindex )
    {
        case 1:
            [ bitoffset, bitwidth, var_48646764f8a928fa ] = [ 0, 17, "ui_br_plunder_count" ];
            break;
        case 2:
            [ bitoffset, bitwidth, var_48646764f8a928fa ] = [ 17, 17, "ui_br_plunder_count" ];
            break;
        case 3:
            [ bitoffset, bitwidth, var_48646764f8a928fa ] = [ 0, 17, "ui_br_plunder_count2" ];
            break;
        case 4:
            [ bitoffset, bitwidth, var_48646764f8a928fa ] = [ 17, 17, "ui_br_plunder_count2" ];
            break;
        default:
            assertmsg( "<dev string:x2b3>" + self.sessionuimemberindex + "<dev string:x2c9>" );
            break;
    }
    
    return [ bitoffset, bitwidth, var_48646764f8a928fa ];
}

// Namespace br_plunder
// Params 3
// Checksum 0x16fb052f, Offset: 0x4bfb
// Size: 0x11e
function dangercircletick( dangercircleorigin, dangercircleradius, thresholdradius )
{
    if ( !level.br_plunder_enabled )
    {
        return;
    }
    
    var_1bdc861911b3625e = dangercircleradius + thresholdradius;
    var_dd57917c4744639e = var_1bdc861911b3625e * var_1bdc861911b3625e;
    
    for ( i = 0; i < level.br_depots.size ; i++ )
    {
        depot = level.br_depots[ i ];
        
        if ( isdefined( depot ) && !depot.disabled && distance2dsquared( dangercircleorigin, depot.origin ) > var_dd57917c4744639e )
        {
            depot function_481140e0b65a73cf();
        }
    }
    
    for ( i = 0; i < level.br_plunder_sites.size ; i++ )
    {
        site = level.br_plunder_sites[ i ];
        
        if ( isdefined( site ) && !site.disabled && distance2dsquared( dangercircleorigin, site.origin ) > var_dd57917c4744639e )
        {
            site function_277b44871a7e6a52();
        }
    }
}

// Namespace br_plunder
// Params 0
// Checksum 0x6085cb9b, Offset: 0x4d21
// Size: 0xf0
function dangermulticircletick()
{
    if ( !level.br_plunder_enabled || !level.br_multi_circle_enabled )
    {
        return;
    }
    
    for ( i = 0; i < level.br_depots.size ; i++ )
    {
        depot = level.br_depots[ i ];
        
        if ( isdefined( depot ) && !depot.disabled && !br_circle_util::ispointinmulticircledanger( depot.origin ) )
        {
            depot function_481140e0b65a73cf();
        }
    }
    
    for ( i = 0; i < level.br_plunder_sites.size ; i++ )
    {
        site = level.br_plunder_sites[ i ];
        
        if ( isdefined( site ) && !site.disabled && !br_circle_util::ispointinmulticircledanger( site.origin ) )
        {
            site function_277b44871a7e6a52();
        }
    }
}

// Namespace br_plunder
// Params 0
// Checksum 0xfd24dcc7, Offset: 0x4e19
// Size: 0x26
function function_481140e0b65a73cf()
{
    depot = self;
    depot.disabled = 1;
    depot depotmakeunsabletoall();
}

// Namespace br_plunder
// Params 0
// Checksum 0x5eb41b09, Offset: 0x4e47
// Size: 0x3a
function function_277b44871a7e6a52()
{
    site = self;
    site.disabled = 1;
    site setscriptablepartstate( site.type, site.disabledstate );
}

// Namespace br_plunder
// Params 0
// Checksum 0x4bebdea5, Offset: 0x4e89
// Size: 0x33
function playerplaydepositanim()
{
    self endon( #"death_or_disconnect" );
    
    if ( !pickups::canplaynotcriticalgesture() || self isgestureplaying() )
    {
        return;
    }
    
    pickups::playerplaygestureweaponanim( "iw8_ges_plyr_cash_handoff", 1.84 );
}

// Namespace br_plunder
// Params 0
// Checksum 0x946b61cb, Offset: 0x4ec4
// Size: 0x89
function cratedropplunder()
{
    if ( !isdefined( self.plunder ) )
    {
        return;
    }
    
    amount = 0;
    
    for ( i = 0; i < self.plunder.size ; i++ )
    {
        amount += self.plunder[ i ].plundercount;
    }
    
    self.angles = ( 0, 0, 0 );
    dropstruct = pickups::function_f71dd588dc4f6288();
    dropplunderbyrarity( amount, dropstruct );
}

// Namespace br_plunder
// Params 2
// Checksum 0x4d77200d, Offset: 0x4f55
// Size: 0x10d
function dropplundersounds( droporigin, numdrops )
{
    if ( numdrops <= 0 )
    {
        return;
    }
    
    sndorigin = droporigin + ( 0, 0, 24 );
    sndalias = "";
    wait 0.5;
    
    switch ( numdrops )
    {
        case 0:
            break;
        case 1:
            sndalias = "fly_drop_cash_coins_01";
            break;
        case 2:
            sndalias = "fly_drop_cash_coins_02";
            break;
        case 3:
            sndalias = "fly_drop_cash_coins_03";
            break;
        case 4:
            sndalias = "fly_drop_cash_coins_04";
            break;
        case 5:
            sndalias = "fly_drop_cash_coins_05";
            break;
        case 6:
        default:
            sndalias = "fly_drop_cash_coins_06";
            break;
    }
    
    assert( soundexists( sndalias ) );
    playsoundatpos( sndorigin, sndalias );
}

// Namespace br_plunder
// Params 3
// Checksum 0x9a78562b, Offset: 0x506a
// Size: 0x26f
function dropplunderbyrarity( amount, dropstruct, numitems )
{
    if ( !level.br_plunder_enabled )
    {
        return;
    }
    
    pickupents = [];
    numspawns = [];
    totalcount = 0;
    maxcount = 6;
    
    if ( isdefined( numitems ) )
    {
        maxcount = numitems;
    }
    
    for ( i = level.br_plunder.quantity.size - 1; i >= 0 ; i-- )
    {
        numspawns[ i ] = int( amount / level.br_plunder.quantity[ i ] );
        numspawns[ i ] = int( clamp( numspawns[ i ], 0, maxcount - totalcount ) );
        totalcount += numspawns[ i ];
        
        if ( amount <= 0 || totalcount >= maxcount )
        {
            break;
        }
        
        amount -= numspawns[ i ] * level.br_plunder.quantity[ i ];
    }
    
    for ( plunderindex = level.br_plunder.quantity.size - 1; plunderindex >= 0 ; plunderindex-- )
    {
        if ( !isdefined( numspawns[ plunderindex ] ) )
        {
            continue;
        }
        
        for ( itemindex = 0; itemindex < numspawns[ plunderindex ] ; itemindex++ )
        {
            spawnoptions = namespace_9d8e359c3b1041e5::function_39104c6ed6c82786( self.origin, self.angles );
            pickupent = namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( level.br_plunder.names[ plunderindex ], level.br_plunder.quantity[ plunderindex ], spawnoptions );
            modify_plunder_itemsinworld( level.br_plunder.names[ plunderindex ], 1 );
            
            if ( isdefined( pickupent ) )
            {
                pickupents[ pickupents.size ] = pickupent;
                
                if ( inplunderlivelobby() )
                {
                    level.br_plunder_ents[ level.br_plunder_ents.size ] = pickupent;
                }
            }
        }
    }
    
    level.br_plunder.plunder_items_dropped += totalcount;
    level.br_plunder.plunder_value_dropped += amount;
    level thread dropplundersounds( self.origin, pickupents.size );
    return pickupents;
}

// Namespace br_plunder
// Params 4
// Checksum 0x77d7a40e, Offset: 0x52e2
// Size: 0x168
function dropcondensedplunder( amount, dropstruct, allowautopickup, var_3b8f1509495546fd )
{
    if ( !level.br_plunder_enabled )
    {
        return;
    }
    
    pickupents = [];
    numspawns = [];
    var_63e602294d3f3917 = 0;
    
    for ( i = level.br_plunder.names.size - 1; i >= 0 ; i-- )
    {
        if ( amount >= level.br_plunder.quantity[ i ] )
        {
            var_63e602294d3f3917 = i;
            break;
        }
    }
    
    spawnoptions = var_3b8f1509495546fd ?? common_item::items_initspawnoptions_spawnfromentity( self );
    dropinfo = common_item::function_d94b7cedcd3ae9d0( spawnoptions );
    itembundlename = common_item_database::function_ca9ca606e66b5911( level.br_plunder.names[ var_63e602294d3f3917 ] );
    level.br_plunder.plunder_items_dropped++;
    level.br_plunder.plunder_value_dropped += amount;
    level thread dropplundersounds( self.origin, 1 );
    return common_item::function_47324f290423b2d1( itembundlename, self.origin, dropinfo.finalorigin, amount, undefined, var_3b8f1509495546fd );
}

// Namespace br_plunder
// Params 0
// Checksum 0xb4efc0ae, Offset: 0x5453
// Size: 0x5d, Type: bool
function isplunderextractionenabled()
{
    if ( br_gametypes::isfeaturedisabled( #"plundersites" ) )
    {
        return false;
    }
    
    var_b597a97699b77735 = getmatchrulesdata( "brData", "plunderSites" );
    return level.br_plunder_enabled && isdefined( level.br_plunder_sites ) && level.br_plunder_sites.size != 0 && var_b597a97699b77735;
}

#using_animtree( "mp_vehicles_always_loaded" );

// Namespace br_plunder
// Params 0
// Checksum 0x921e54c6, Offset: 0x54b9
// Size: 0x5f
function initheliextractanims()
{
    level.scr_anim[ "plunder_extract_heli" ][ "heli_in" ] = %iw8_br_plunder_heli_in;
    level.scr_anim[ "plunder_extract_heli" ][ "heli_loop" ] = %iw8_br_plunder_heli_loop;
    level.scr_anim[ "plunder_extract_heli" ][ "heli_out" ] = %iw8_br_plunder_heli_out;
}

#using_animtree( "script_model" );

// Namespace br_plunder
// Params 0
// Checksum 0xcc399f6c, Offset: 0x5520
// Size: 0xce
function inithelipropanims()
{
    level.scr_animtree[ "plunder_extract_heli" ] = #animtree;
    level.scr_anim[ "plunder_extract_heli" ][ "rope_in" ] = %iw8_br_plunder_heli_rope_in;
    level.scr_anim[ "plunder_extract_heli" ][ "rope_loop" ] = %iw8_br_plunder_heli_rope_loop;
    level.scr_anim[ "plunder_extract_heli" ][ "rope_out" ] = %iw8_br_plunder_heli_rope_out;
    level.scr_anim[ "plunder_extract_heli" ][ "bag_in" ] = %iw8_br_plunder_heli_bag_in;
    level.scr_anim[ "plunder_extract_heli" ][ "bag_loop" ] = %iw8_br_plunder_heli_bag_loop;
    level.scr_anim[ "plunder_extract_heli" ][ "bag_out" ] = %iw8_br_plunder_heli_bag_out;
}

// Namespace br_plunder
// Params 0
// Checksum 0x4e78d6b0, Offset: 0x55f6
// Size: 0x262
function inithelirepository()
{
    var_c3adc6a0cd0d6bd7 = [];
    leveldataforrepository = plunder_getleveldataforrepository( "plunderHelipad1", 1 );
    leveldataforrepository.scriptableusepart = "brloot_plunder_extraction_site_01";
    var_c3adc6a0cd0d6bd7[ var_c3adc6a0cd0d6bd7.size ] = leveldataforrepository;
    leveldataforrepository = plunder_getleveldataforrepository( "plunderHelipad2", 1 );
    leveldataforrepository.scriptableusepart = "brloot_plunder_extraction_site_02";
    var_c3adc6a0cd0d6bd7[ var_c3adc6a0cd0d6bd7.size ] = leveldataforrepository;
    leveldataforrepository = plunder_getleveldataforrepository( "extractHelipadPlunder", 1 );
    leveldataforrepository.scriptableusepart = "brloot_quest_extract_site_plunder";
    var_c3adc6a0cd0d6bd7[ var_c3adc6a0cd0d6bd7.size ] = leveldataforrepository;
    leveldataforrepository = plunder_getleveldataforrepository( "extractHelipadBR", 1 );
    leveldataforrepository.scriptableusepart = "brloot_quest_extract_site_br";
    var_c3adc6a0cd0d6bd7[ var_c3adc6a0cd0d6bd7.size ] = leveldataforrepository;
    
    foreach ( leveldataforrepository in var_c3adc6a0cd0d6bd7 )
    {
        leveldataforrepository.type = 1;
        leveldataforrepository.usetime = 0;
        leveldataforrepository.useeventtype = 3;
        leveldataforrepository.useeventamount = getdvarint( @"scr_plunderheliuseamount", 20000 );
        leveldataforrepository.teamuseonly = 0;
        leveldataforrepository.usefailcapacitymsg = %"mp/cannot_deposit_cash_heli_full";
        leveldataforrepository.usefailextractingmsg = %"mp/cannot_deposit_cash_heli_leaving";
        leveldataforrepository.scriptableusestate = "activedepositcurrent";
        leveldataforrepository.scriptablenousestate = "visiblecurrent";
        leveldataforrepository.extractcountdown = 0;
        leveldataforrepository.extractsilentcountdown = getdvarint( @"scr_plunderhelicountdown", 30 );
        leveldataforrepository.extractcountdownmsg = %"mp/cash_heli_leaving_in_n";
        leveldataforrepository.capacity = 0;
        leveldataforrepository.countdownendcallback = &helicountdownendcallback;
        leveldataforrepository.extractcallback = &heliextractcallback;
        leveldataforrepository.atcapacitycallback = &heliatcapacitycallback;
        leveldataforrepository.extractionmethod = "little_bird";
    }
    
    /#
        setdevdvarifuninitialized( @"scr_plunderheliuseamount", 20000 );
        setdevdvarifuninitialized( @"scr_plunderhelicountdown", 30 );
    #/
}

// Namespace br_plunder
// Params 0
// Checksum 0xcef9631e, Offset: 0x5860
// Size: 0x23c
function getplunderextractionsites()
{
    sites = [];
    
    if ( game_utility::isdonetskmap() )
    {
        sites = getentitylessscriptablearray( "extract_pad", #targetname );
        var_a5f2ebd10f088d55 = getentitylessscriptablearray( "extract_pad_boneyard", #targetname );
        
        if ( var_a5f2ebd10f088d55.size > 0 )
        {
            sites = arraycombine( sites, var_a5f2ebd10f088d55 );
        }
    }
    else
    {
        sites01 = getentitylessscriptablearray( "plunder_extraction_01", #targetname );
        sites02 = getentitylessscriptablearray( "plunder_extraction_02", #targetname );
        sites = arraycombine( sites01, sites02 );
        
        if ( sites.size == 0 )
        {
            sites = getentitylessscriptablearray( "extraction_site", #targetname );
        }
    }
    
    if ( sites.size > 0 )
    {
        foreach ( site in sites )
        {
            site.activestate = "active";
            site.activecurrstate = "activeCurrent";
            site.disabledstate = "visible";
            site.disabledcurrstate = "visible";
            
            if ( level.mapname == "mp_wz2_sierra" )
            {
                site.flightyaw = 270;
            }
        }
        
        return sites;
    }
    
    sites = getentitylessscriptablearray( "plunder_extraction", #targetname );
    
    foreach ( site in sites )
    {
        site.activestate = "visible";
        site.activecurrstate = "visibleCurrent";
        site.disabledstate = "hidden";
    }
    
    return sites;
}

// Namespace br_plunder
// Params 2
// Checksum 0xee09df6c, Offset: 0x5aa4
// Size: 0x44
function function_fdc9cb33bb23d497( structname, sitestruct )
{
    if ( !isdefined( level.br_plunder_sites_start ) )
    {
        level.br_plunder_sites_start = [];
    }
    
    level.br_plunder_sites_start[ level.br_plunder_sites_start.size ] = sitestruct;
    return sitestruct;
}

// Namespace br_plunder
// Params 0
// Checksum 0x1940a88b, Offset: 0x5af1
// Size: 0x4fa
function setupplunderextractionsites()
{
    level.br_plunder_sites = getplunderextractionsites();
    level.br_plunder_site_use_parts = [];
    level.br_plunder_site_use_parts[ level.br_plunder_site_use_parts.size ] = "brloot_plunder_extraction_site";
    level.br_plunder_site_use_parts[ level.br_plunder_site_use_parts.size ] = "brloot_plunder_extraction_site_01";
    level.br_plunder_site_use_parts[ level.br_plunder_site_use_parts.size ] = "brloot_plunder_extraction_site_02";
    level.br_plunder_site_use_parts[ level.br_plunder_site_use_parts.size ] = "brloot_quest_extract_site_br";
    level.br_plunder_site_use_parts[ level.br_plunder_site_use_parts.size ] = "brloot_quest_extract_site_plunder";
    level.br_plunder_site_use_states = [];
    level.br_plunder_site_use_states[ level.br_plunder_site_use_states.size ] = "active";
    level.br_plunder_site_use_states[ level.br_plunder_site_use_states.size ] = "active2";
    level.br_plunder_site_use_states[ level.br_plunder_site_use_states.size ] = "activecurrent";
    level.br_plunder_site_use_states[ level.br_plunder_site_use_states.size ] = "visiblecurrent";
    
    if ( isplunderextractionenabled() && getdvarint( @"hash_28df7f89e6eab57c", 0 ) && getdvarint( @"scr_ssc_enabled", 1 ) )
    {
        foreach ( site in level.br_plunder_sites )
        {
            site setscriptablepartstate( site.type, "hidden" );
        }
        
        structspawnconfig::function_7418a260adaec05( "extraction_site", &function_15cc15845b3ef0b0 );
        structspawnconfig::function_8c0a09968efe9138( "extraction_site", &function_fdc9cb33bb23d497 );
    }
    else if ( !isplunderextractionenabled() )
    {
        platforments = getentarray( "plunder_extraction_visual", #targetname );
        
        foreach ( ent in platforments )
        {
            ent delete();
        }
        
        foreach ( site in level.br_plunder_sites )
        {
            site setscriptablepartstate( site.type, "hidden" );
        }
        
        level.br_plunder_sites = [];
        return;
    }
    
    /#
        level thread function_63408289208e26af();
    #/
    
    flags::gameflagwait( "prematch_done" );
    scriptable::scriptable_addusedcallback( &plundersiteused );
    
    if ( level.matchstartextractsitedelay > 0 && !level.usemilestonephases )
    {
        wait level.matchstartextractsitedelay;
    }
    else if ( level.usemilestonephases )
    {
        flags::gameflagwait( "activate_cash_lzs" );
    }
    
    foreach ( player in level.players )
    {
        if ( isdefined( player ) )
        {
            if ( !br_public::function_379fb7b09f4ef13e() )
            {
                player hud_message::showsplash( "bm_extract_heli_start", undefined, undefined, undefined, undefined, "splash_list_br_plunder_iw9_mp" );
            }
        }
    }
    
    sites = level.br_plunder_sites;
    
    if ( getdvarint( @"hash_28df7f89e6eab57c", 0 ) && getdvarint( @"scr_ssc_enabled", 1 ) )
    {
        sites = level.br_plunder_sites_start;
        level.br_plunder_sites_start = undefined;
    }
    
    foreach ( site in sites )
    {
        scriptablestate = level.showplunderextracticonsinworld && !level.shownonscriptableextracticons ? site.activecurrstate : site.activestate;
        site setscriptablepartstate( site.type, scriptablestate );
    }
}

/#

    // Namespace br_plunder
    // Params 0
    // Checksum 0xfcdf929c, Offset: 0x5ff3
    // Size: 0x189, Type: dev
    function function_63408289208e26af()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            debugsites = getdvarint( @"hash_69a2288a8b47e1b5", 0 );
            
            if ( debugsites )
            {
                break;
            }
            
            waitframe();
        }
        
        scriptable::scriptable_addusedcallback( &plundersiteused );
        
        foreach ( player in level.players )
        {
            if ( isdefined( player ) )
            {
                player hud_message::showsplash( "<dev string:x2f1>" );
            }
        }
        
        foreach ( site in level.br_plunder_sites )
        {
            scriptablestate = level.showplunderextracticonsinworld && !level.shownonscriptableextracticons ? site.activecurrstate : site.activestate;
            site setscriptablepartstate( site.type, scriptablestate );
        }
    }

#/

// Namespace br_plunder
// Params 1
// Checksum 0xbca0eaea, Offset: 0x6184
// Size: 0x12
function function_15cc15845b3ef0b0( structname )
{
    return getallextractspawninstances();
}

// Namespace br_plunder
// Params 0
// Checksum 0x9bc53e5f, Offset: 0x619f
// Size: 0x21
function getallextractspawninstances()
{
    if ( !isplunderextractionenabled() )
    {
        return;
    }
    
    instances = getplunderextractionsites();
    return instances;
}

// Namespace br_plunder
// Params 1
// Checksum 0x41562bc, Offset: 0x61c9
// Size: 0xa9
function setextractspawninstances( instances )
{
    foreach ( site in level.br_plunder_sites )
    {
        if ( !arraycontains( instances, site ) )
        {
            site setscriptablepartstate( site.type, "hidden" );
        }
    }
    
    level.br_plunder_sites = instances;
}

/#

    // Namespace br_plunder
    // Params 1
    // Checksum 0x3f4c5f07, Offset: 0x627a
    // Size: 0x158, Type: dev
    function debugextractsite( site )
    {
        siteent = spawn( "<dev string:x307>", site.origin + ( 0, 0, 1000 ) );
        modelname = "<dev string:x314>";
        vehiclename = "<dev string:x333>";
        
        if ( level.var_b4c8dcabb0437344 )
        {
            modelname = "<dev string:x349>";
            vehiclename = "<dev string:x386>";
        }
        
        siteent setmodel( modelname );
        locationx = site.origin[ 0 ];
        locationy = site.origin[ 1 ];
        offgroundheight = 800;
        groundheight = siteent tracegroundpoint( site.origin );
        trueheight = groundheight + offgroundheight;
        newpos = ( locationx, locationy, trueheight );
        siteent.origin = newpos;
        
        while ( true )
        {
            sphere( newpos, 20, ( 0, 1, 0 ), 0, 1 );
            sphere( ( site.origin[ 0 ], site.origin[ 1 ], groundheight ), 100, ( 0, 1, 1 ), 0, 1 );
            waitframe();
        }
    }

#/

// Namespace br_plunder
// Params 6
// Checksum 0xf6214138, Offset: 0x63da
// Size: 0x18a
function plundersiteused( instance, part, state, player, bautouse, usestring )
{
    if ( !( isdefined( instance ) && isdefined( player ) ) )
    {
        return;
    }
    
    if ( !( isdefined( level.br_plunder_site_use_parts ) && isdefined( level.br_plunder_site_use_states ) ) )
    {
        return;
    }
    
    earlyout = 1;
    
    foreach ( _part in level.br_plunder_site_use_parts )
    {
        if ( _part != part )
        {
            continue;
        }
        
        earlyout = 0;
        break;
    }
    
    if ( earlyout )
    {
        return;
    }
    
    earlyout = 1;
    
    foreach ( _state in level.br_plunder_site_use_states )
    {
        if ( _state != state )
        {
            continue;
        }
        
        earlyout = 0;
        break;
    }
    
    if ( earlyout )
    {
        return;
    }
    
    thread plundersiteusedinternal( instance, part, state, player );
}

// Namespace br_plunder
// Params 4
// Checksum 0x69689351, Offset: 0x656c
// Size: 0x357
function plundersiteusedinternal( instance, part, state, player )
{
    if ( isdefined( instance.disabled ) )
    {
        return;
    }
    
    if ( isdefined( instance.heli ) )
    {
        player playerdenyextraction( undefined, &"KILLSTREAKS/AIR_SPACE_TOO_CROWDED" );
        return;
    }
    
    scriptablestate = level.showplunderextracticonsinworld && !level.shownonscriptableextracticons ? "inuseCurrent" : "inuse";
    instance setscriptablepartstate( instance.type, scriptablestate );
    teamindex = function_f02c63b99c9614c9( level.allteamnamelist, player.team );
    instance.team = teamindex;
    instance function_474bcbb86b733bef( instance.type, teamindex );
    groundorg = getgroundposition( instance.origin, 1 ) + ( 0, 0, -9 );
    heli = player playerspawnextractchopper( groundorg, instance );
    
    if ( isdefined( heli ) )
    {
        heli.site = instance;
        instance.heli = heli;
        instance.team = player.team;
        thread createsmokesignalfx( groundorg );
        player playerthrowsmokesignal();
        
        if ( !br_public::function_379fb7b09f4ef13e() )
        {
            level thread br_public::brleaderdialogteam( "plunder_extract_requested", player.team, 1 );
        }
        
        level thread br::teamsplashbr( "br_extract_heli_incoming", player, player.team, undefined, "splash_list_br_plunder_iw9_mp" );
        heli thread heligotoplunderrepository( instance );
    }
    else
    {
        playerdenyextraction( undefined, &"KILLSTREAKS/AIR_SPACE_TOO_CROWDED" );
        scriptablestate = level.showplunderextracticonsinworld && !level.shownonscriptableextracticons ? instance.activecurrstate : instance.activestate;
        instance setscriptablepartstate( instance.type, scriptablestate );
        return;
    }
    
    if ( level.plunderextractalertnearby )
    {
        skipplayers = teams::function_d032b36d01bbbab3( player.team, player.sessionsquadid );
        nearplayers = utility::playersincylinder( instance.origin, 15000, skipplayers );
        
        foreach ( playerent in nearplayers )
        {
            playerent thread hud_message::showsplash( "br_extract_heli_incoming_them", undefined, player, undefined, undefined, "splash_list_br_plunder_iw9_mp" );
        }
    }
    
    if ( level.moveplunderextractionsitesonuse )
    {
        instance.disabled = 1;
        scriptablestate = level.showplunderextracticonsinworld && !level.shownonscriptableextracticons ? instance.disabledcurrstate : instance.disabledstate;
        instance setscriptablepartstate( instance.type, scriptablestate );
        level thread findnewplunderextractsite( instance );
    }
}

// Namespace br_plunder
// Params 2
// Checksum 0xb29cb201, Offset: 0x68cb
// Size: 0x7c
function _getsingleplunderextractlocations( var_d301a250866cda5a, maxlocations )
{
    if ( var_d301a250866cda5a.size == 0 || maxlocations == 0 )
    {
        return;
    }
    
    site = undefined;
    
    if ( var_d301a250866cda5a.size > 0 )
    {
        var_d301a250866cda5a = arrayrandomize( var_d301a250866cda5a );
        
        for ( i = 0; i < var_d301a250866cda5a.size ; i++ )
        {
            if ( !arraycontains( level.br_plunder_sites, var_d301a250866cda5a[ i ] ) )
            {
                site = var_d301a250866cda5a[ i ];
                break;
            }
        }
    }
    
    return site;
}

// Namespace br_plunder
// Params 1
// Checksum 0x169f44e9, Offset: 0x6950
// Size: 0x158
function findnewplunderextractsite( oldsite )
{
    newsite = _getsingleplunderextractlocations( getallextractspawninstances(), level.maxplunderextractions );
    newsite.disabled = undefined;
    newsite.helidisabled = undefined;
    scriptablestate = level.showplunderextracticonsinworld && !level.shownonscriptableextracticons ? newsite.activecurrstate : newsite.activestate;
    newsite setscriptablepartstate( newsite.type, scriptablestate );
    
    if ( level.showplunderextracticonsinworld && level.shownonscriptableextracticons )
    {
        objidpoolmanager::returnobjectiveid( oldsite.locale.objectiveiconid );
        oldsite.locale.objectiveiconid = -1;
        locale = spawnstruct();
        locale br_quest_util::createquestobjicon( "ui_mp_br_mapmenu_icon_atm", "current", newsite.origin + ( 0, 0, 200 ) );
        newsite.locale = locale;
    }
    
    level.br_plunder_sites = arrayremove( level.br_plunder_sites, oldsite );
    level.br_plunder_sites[ level.br_plunder_sites.size ] = newsite;
}

// Namespace br_plunder
// Params 0
// Checksum 0x9c45f8ba, Offset: 0x6ab0
// Size: 0x1f
function playerthrowsmokesignal()
{
    self endon( #"death_or_disconnect" );
    pickups::playerplaygestureweaponanim( "iw8_ges_plyr_plunder_smoke", 1.867 );
}

// Namespace br_plunder
// Params 2
// Checksum 0xd9ead8dd, Offset: 0x6ad7
// Size: 0x4e
function playerdenyextraction( weaponobject, localizedstring )
{
    self iprintlnbold( localizedstring );
    self playlocalsound( "fly_pickup_deny" );
    
    if ( isdefined( weaponobject ) )
    {
        ammo = self getweaponammoclip( weaponobject );
        self setweaponammoclip( weaponobject, ammo + 1 );
    }
}

// Namespace br_plunder
// Params 1
// Checksum 0xf2e2edd3, Offset: 0x6b2d
// Size: 0xbb
function createsmokesignalfx( position )
{
    wait 1.35;
    fxent = spawn( "script_model", position );
    fxent setmodel( "scr_smoke_grenade" );
    fxent.angles = ( 0, 90, 90 );
    fxent playsound( "smoke_carepackage_expl_trans" );
    fxent playloopsound( "smoke_carepackage_smoke_lp" );
    fxent setscriptablepartstate( "smoke", "on" );
    wait 17;
    fxent endon( #"death" );
    fxent setscriptablepartstate( "smoke", "dissipate" );
    fxent playsound( "smoke_canister_tail_dissipate" );
    wait 1;
    fxent stoploopsound();
    wait 4.5;
    fxent delete();
}

// Namespace br_plunder
// Params 2
// Checksum 0x4d8ade7f, Offset: 0x6bf0
// Size: 0x2db
function playerspawnextractchopper( position, site )
{
    extractgroundpos = position;
    var_9370b5c935fd8b21 = extractgroundpos + ( 0, 0, 2000 );
    spawnposoffset = extractgroundpos + ( 0, 0, 8000 );
    var_ce1eb256270347b7 = extractgroundpos + ( 0, 0, 800 );
    flightyaw = 0;
    flightangles = ( 0, 0, 0 );
    usestructs = getdvarint( @"hash_f38b8e35f5c48796", 0 );
    
    if ( usestructs )
    {
        extractionpad = getextractionpadent( extractgroundpos );
        
        if ( isdefined( extractionpad ) )
        {
            padstruct = extractionpad.script_noteworthy;
            flightangles = padstruct.angles;
        }
        else
        {
            /#
                iprintlnbold( "<dev string:x3b4>" );
            #/
            
            flightyaw = getclearpathflightyaw( site, spawnposoffset, var_9370b5c935fd8b21 );
            flightangles = ( 0, flightyaw, 0 );
        }
    }
    else
    {
        flightyaw = getclearpathflightyaw( site, spawnposoffset, var_9370b5c935fd8b21 );
        flightangles = ( 0, flightyaw, 0 );
    }
    
    if ( getdvarint( @"hash_d5878ca9e558dd32", 0 ) == 1 )
    {
        const_offset_forward = -100;
        const_offset_right = 60;
        dirfwd = anglestoforward( flightangles );
        dirright = anglestoright( flightangles );
        extractgroundpos = extractgroundpos + dirfwd * const_offset_forward + dirright * const_offset_right;
        var_9370b5c935fd8b21 = extractgroundpos + ( 0, 0, 2000 );
        var_ce1eb256270347b7 = extractgroundpos + ( 0, 0, 800 );
    }
    
    enterposition = spawnposoffset - anglestoforward( flightangles ) * 20000;
    
    /#
        if ( getdvarint( @"hash_ea6b7d41418450ea", 0 ) )
        {
            var_50160d6a715578d3 = 1200;
            line( enterposition, var_9370b5c935fd8b21, ( 0, 0, 1 ), 1, 0, var_50160d6a715578d3 );
            line( enterposition, enterposition + ( 0, 0, -2000 ), ( 0, 0, 1 ), 1, 0, var_50160d6a715578d3 );
            line( var_9370b5c935fd8b21, var_ce1eb256270347b7, ( 0.9, 0, 0.9 ), 1, 0, var_50160d6a715578d3 );
            line( var_9370b5c935fd8b21, var_9370b5c935fd8b21 + ( 0, 0, -2000 ), ( 0.9, 0, 0.9 ), 1, 0, var_50160d6a715578d3 );
            line( var_ce1eb256270347b7, extractgroundpos, ( 1, 0, 0 ), 1, 0, var_50160d6a715578d3 );
            line( var_ce1eb256270347b7, var_ce1eb256270347b7 + ( 0, 0, -2000 ), ( 1, 0, 0 ), 1, 0, var_50160d6a715578d3 );
            sphere( extractgroundpos, 10, ( 1, 0, 0 ), 0, var_50160d6a715578d3 );
        }
    #/
    
    heli = spawnheli( self.team, enterposition, var_9370b5c935fd8b21, var_ce1eb256270347b7, extractgroundpos );
    return heli;
}

// Namespace br_plunder
// Params 1
// Checksum 0x93f28ccf, Offset: 0x6ed4
// Size: 0xaf
function getextractionpadent( extractpos )
{
    extractpad = undefined;
    
    foreach ( pad in level.plunderpads )
    {
        if ( isdefined( pad ) && distance2dsquared( pad.origin, extractpos ) <= 10000 )
        {
            extractpad = pad;
            break;
        }
    }
    
    return extractpad;
}

// Namespace br_plunder
// Params 3
// Checksum 0xc031a07e, Offset: 0x6f8c
// Size: 0x175
function getclearpathflightyaw( site, var_9bfc3973acf74366, var_db18f8c567bc3349 )
{
    if ( isdefined( site ) && isdefined( site.flightyaw ) )
    {
        return site.flightyaw;
    }
    
    var_5dcd37deb66bc6d3 = 10;
    contents = trace::create_contents( 0, 1, 1, 1, 1, 0, 1, 1, 0 );
    var_18397e93d9334888 = 0;
    yaw = 0;
    
    while ( yaw < 360 )
    {
        var_18397e93d9334888 += yaw;
        testangles = ( 0, var_18397e93d9334888, 0 );
        approachstartpos = var_9bfc3973acf74366 - anglestoforward( testangles ) * 20000;
        approachendpos = var_db18f8c567bc3349;
        approachtrace = trace::sphere_trace( approachstartpos, approachendpos, 100, undefined, contents, 1 );
        
        if ( approachtrace[ "fraction" ] == 1 )
        {
            /#
                if ( getdvarint( @"hash_ea6b7d41418450ea", 0 ) )
                {
                    line( approachstartpos, approachendpos, ( 0, 1, 0 ), 1, 0, 2000 );
                }
            #/
            
            if ( isdefined( site ) )
            {
                site.flightyaw = var_18397e93d9334888;
            }
            
            return var_18397e93d9334888;
        }
        
        /#
            if ( getdvarint( @"hash_ea6b7d41418450ea", 0 ) )
            {
                line( approachstartpos, approachendpos, ( 1, 0, 0 ), 1, 0, 2000 );
            }
        #/
        
        if ( yaw % 3 == 0 )
        {
            waitframe();
        }
        
        yaw += var_5dcd37deb66bc6d3;
    }
    
    return var_18397e93d9334888;
}

// Namespace br_plunder
// Params 1
// Checksum 0x8526bc3d, Offset: 0x710a
// Size: 0x15e
function drophelicrate( heli )
{
    if ( !isdefined( heli.plunder ) )
    {
        return;
    }
    
    level thread br_public::brleaderdialogteam( "plunder_extract_fail_chopper", self.team, 1 );
    plunder_allowrepositoryuse( self.crate, 0 );
    crate = self.crate;
    self.crate = undefined;
    crate.plunder = heli.plunder;
    startorg = crate.origin;
    end = ( startorg[ 0 ], startorg[ 1 ], -12000 );
    contents = trace::create_contents( 0, 1, 1, 1, 1, 1, 0 );
    trace = trace::ray_trace( startorg, end, heli, contents );
    groundorg = trace[ "position" ];
    dist = startorg[ 2 ] - groundorg[ 2 ];
    
    if ( dist > 0 )
    {
        time = sqrt( 2 * dist / 800 );
        crate moveto( groundorg, time, time, 0 );
        wait time;
    }
    
    crate.origin = groundorg;
    playfx( utility::getfx( "airdrop_crate_impact_ground" ), groundorg );
    entityplunderlosealldeposited( crate, 1 );
    crate thread helicratedelete( heli );
}

// Namespace br_plunder
// Params 3
// Checksum 0x48d61c99, Offset: 0x7270
// Size: 0x9a
function calculatehelitimetoflysec( distinches, speedmph, accelmph )
{
    distmiles = distinches * 1.57828e-05;
    a = 0.5 * accelmph;
    b = speedmph;
    c = -1 * distmiles;
    flytime = ( -1 * b + sqrt( b * b - 4 * a * c ) ) / 2 * a;
    flytime *= 3600;
    flytime += 1.5;
    return flytime;
}

// Namespace br_plunder
// Params 1
// Checksum 0xab406b54, Offset: 0x7313
// Size: 0x51
function calculatehelitimetoarrive( var_f4feabcd5c9f80b8 )
{
    arrivetime = calculatehelitimetoflysec( 20000, 100, 125 );
    descendtime = calculatehelitimetoflysec( var_f4feabcd5c9f80b8, 25, 31.25 );
    totaltime = arrivetime + descendtime;
    return totaltime;
}

// Namespace br_plunder
// Params 1
// Checksum 0x7f04eba3, Offset: 0x736d
// Size: 0xcb
function heligotoplunderrepository( plunderrepository )
{
    self endon( #"death" );
    self endon( #"leaving" );
    groundz = self.extractgroundpos[ 2 ];
    var_f4feabcd5c9f80b8 = self.descendpos[ 2 ] - groundz;
    self.flytime = calculatehelitimetoarrive( var_f4feabcd5c9f80b8 );
    thread heliwatchgameendleave();
    self.preventleave = 1;
    helidescend();
    self.preventleave = undefined;
    
    if ( !level.gameended )
    {
        if ( !br_public::function_379fb7b09f4ef13e() )
        {
            level thread br_public::brleaderdialogteam( "plunder_extract_chopper_arrive", self.team, 1 );
        }
        
        thread heliwaitatplunderrepository( plunderrepository );
        return;
    }
    
    thread helileave( 1 );
}

// Namespace br_plunder
// Params 1
// Checksum 0x24e21437, Offset: 0x7440
// Size: 0xf5
function heliwaitatplunderrepository( plunderrepository )
{
    assert( isdefined( plunderrepository ), "<dev string:x41c>" );
    plunderrepositoryref = undefined;
    
    if ( plunderrepository.type == "brloot_plunder_extraction_site_01" )
    {
        plunderrepositoryref = "plunderHelipad1";
    }
    else if ( plunderrepository.type == "brloot_plunder_extraction_site_02" )
    {
        plunderrepositoryref = "plunderHelipad2";
    }
    else if ( plunderrepository.type == "brloot_quest_extract_site_plunder" )
    {
        plunderrepositoryref = "extractHelipadPlunder";
    }
    else if ( plunderrepository.type == "brloot_quest_extract_site_br" )
    {
        plunderrepositoryref = "extractHelipadBR";
    }
    else
    {
        assertmsg( "<dev string:x466>" );
    }
    
    plunder_registerrepositoryinstance( plunderrepository, plunderrepositoryref );
    players = undefined;
    
    if ( isdefined( self.team ) )
    {
        players = teams::getfriendlyplayers( self.team );
    }
    
    thread plunder_repositorywatchcountdown( plunderrepository, players );
    plunder_updateanchoredwidgetforplayers( plunderrepository, players );
}

// Namespace br_plunder
// Params 1
// Checksum 0xa963ad85, Offset: 0x753d
// Size: 0xae
function helibankplunder( plunderrepository )
{
    if ( !level.gameended && !br_public::function_379fb7b09f4ef13e() )
    {
        level thread br_public::brleaderdialogteam( "plunder_extract_success", self.team, 1 );
    }
    
    data = plunderrepository entityplunderbankalldeposited();
    
    if ( isdefined( data ) && data.amounttotal > 0 )
    {
        level.br_plunder.extraction_helicoptor_total_plunder += data.amounttotal;
        level.br_plunder.extraction_helicoptor_num_completed++;
    }
}

// Namespace br_plunder
// Params 1
// Checksum 0x844afec8, Offset: 0x75f3
// Size: 0x19c
function spawnropeandbag( heli )
{
    ropenode = spawn( "script_model", ( 0, 0, 0 ) );
    ropenode setmodel( "tag_origin" );
    ropenode linkto( heli, "origin_animate_jnt", level.var_b4c8dcabb0437344 ? ( -142.719, 0, 22.931 ) : ( 0, 0, 0 ), ( 0, 0, 0 ) );
    rope = spawn( "script_model", ( 0, 0, 0 ) );
    rope setmodel( "misc_rapelling_rope_01_fiber_br" );
    rope linkto( ropenode, "tag_origin" );
    rope.animname = heli.animname;
    rope animation::setanimtree();
    ropenode animation::anim_first_frame_solo( rope, "rope_in", "tag_origin" );
    crate = spawn( "script_model", ( 0, 0, 0 ) );
    
    if ( level.var_b4c8dcabb0437344 )
    {
        crate setmodel( "br_plunder2_extraction_delivery_bag" );
    }
    else
    {
        crate setmodel( "br_plunder_extraction_delivery_bag" );
    }
    
    crate linkto( ropenode, "tag_origin" );
    crate.animname = heli.animname;
    crate animation::setanimtree();
    ropenode animation::anim_first_frame_solo( crate, "bag_in", "tag_origin" );
    heli.rope = rope;
    heli.crate = crate;
    heli.ropenode = ropenode;
}

// Namespace br_plunder
// Params 5
// Checksum 0x574c7981, Offset: 0x7797
// Size: 0x382
function spawnheli( team, enterpos, descendpos, hoverpos, extractgroundpos )
{
    const_num_flares = 1;
    owner = undefined;
    flightangle = vectortoangles( descendpos * ( 1, 1, 0 ) - enterpos * ( 1, 1, 0 ) );
    modelname = "veh8_mil_air_mindia8_plunder_x";
    vehiclename = "veh_apache_plunder_mp";
    groundposoffset = ( 0, 0, 0 );
    
    if ( level.var_b4c8dcabb0437344 )
    {
        modelname = "xcomp_veh_t10_mil_us_heli_medium_trans_mp_extraction_plunder";
        vehiclename = "veh_t10_mil_us_heli_medium_trans_nophysics_br";
        groundposoffset = ( 126, 0, -20 );
    }
    
    groundposoffset = rotatevector( groundposoffset, flightangle );
    
    if ( level.gametypebundle.var_660795976365e2f0 )
    {
        vehiclename = level.gametypebundle.var_660795976365e2f0;
    }
    
    heli = vehicle_tracking::spawn_helicopter( owner, enterpos, flightangle, vehiclename, modelname );
    
    if ( !isdefined( heli ) )
    {
        return;
    }
    
    heli.damagecallback = &callback_vehicledamage;
    heli.speed = 100;
    heli.accel = 125;
    heli.health = game_utility::getgametype() == "plunder" ? level.extractplunderhelihealth : 1000;
    heli.maxhealth = heli.health;
    heli.team = team;
    heli.owner = owner;
    heli.lifeid = 0;
    heli.flaresreservecount = const_num_flares;
    heli.enterpos = enterpos;
    heli.descendpos = descendpos;
    heli.hoverpos = hoverpos;
    heli.extractgroundpos = extractgroundpos;
    heli.sceneangles = flightangle;
    heli.vehiclename = "magma_plunder_chopper";
    heli.animname = "plunder_extract_heli";
    heli setcandamage( !level.extractplunderheliinvulnerable );
    heli setmaxpitchroll( 10, 25 );
    heli vehicle_setspeed( heli.speed, heli.accel );
    heli sethoverparams( 1, 1, 1 );
    heli setturningability( 0.05 );
    heli setyawspeed( 45, 25, 25, 0.5 );
    heli setotherent( owner );
    heli setvehicleteam( heli.team );
    heli setscriptablepartstate( "engine", "on" );
    
    if ( !level.var_b4c8dcabb0437344 )
    {
        heli setscriptablepartstate( "tail_light", "red" );
        heli setscriptablepartstate( "cockpit_light", "on" );
    }
    
    heli setscriptablepartstate( "infil_lights", "on" );
    heli.scenenode = spawn( "script_model", heli.extractgroundpos + groundposoffset );
    heli.scenenode.angles = heli.sceneangles;
    heli.scenenode setmodel( "tag_origin" );
    heli.scenenode animation::anim_first_frame_solo( heli, "heli_in" );
    spawnropeandbag( heli );
    return heli;
}

// Namespace br_plunder
// Params 1
// Checksum 0x8eaa0f7a, Offset: 0x7b22
// Size: 0x32
function helicratedelete( heli )
{
    plunder_deregisterrepositoryinstance( self );
    self hide();
    
    if ( isdefined( heli ) )
    {
        heli.crate = undefined;
    }
    
    waitframe();
    self delete();
}

// Namespace br_plunder
// Params 0
// Checksum 0x134e9fdd, Offset: 0x7b5c
// Size: 0x155
function helidestroyed()
{
    self endon( #"heli_gone" );
    self waittill( #"death", attacker, meansofdeath, weaponobject, damagelocation );
    plundersum = 0;
    
    if ( isdefined( self.plunder ) )
    {
        foreach ( item in self.plunder )
        {
            plundersum += item.plundercount;
        }
    }
    
    br_analytics::branalytics_plunder_extraction_failure( plundersum, "little_bird", self.extractgroundpos, self.origin );
    thread drophelicrate( self );
    helicleanup();
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( !isdefined( self.largeprojectiledamage ) && !self.isdepot )
    {
        self vehicle_setspeed( 25, 5 );
        thread helicrash( 75 );
        hostmigration::waitlongdurationwithhostmigrationpause( 2.7 );
    }
    
    heliexplode( attacker );
}

// Namespace br_plunder
// Params 0
// Checksum 0xede497b2, Offset: 0x7cb9
// Size: 0x71
function helicleanup()
{
    if ( isdefined( self.rope ) )
    {
        self.rope delete();
    }
    
    if ( isdefined( self.crate ) )
    {
        self.crate thread helicratedelete( self );
    }
    
    if ( isdefined( self.scenenode ) )
    {
        self.scenenode delete();
    }
    
    if ( isdefined( self.ropenode ) )
    {
        self.ropenode delete();
    }
}

// Namespace br_plunder
// Params 1
// Checksum 0xa7ea5b6e, Offset: 0x7d32
// Size: 0xea
function heliexplode( attacker )
{
    explosionposition = self gettagorigin( "tag_origin" ) + ( 0, 0, 40 );
    self radiusdamage( explosionposition, 256, 140, 70, attacker, "MOD_EXPLOSIVE" );
    playfx( utility::getfx( "little_bird_explode" ), explosionposition, anglestoforward( self.angles ), anglestoup( self.angles ) );
    playsoundatpos( explosionposition, "veh_chopper_support_crash" );
    earthquake( 0.8, 1.5, explosionposition, 384 );
    playrumbleonposition( "grenade_rumble", explosionposition );
    physicsexplosionsphere( explosionposition, 500, 200, 1 );
    self notify( #"explode" );
    wait 0.35;
    level thread br::teamsplashbr( "br_extract_heli_shot_down", self.owner, self.team, undefined, "splash_list_br_plunder_iw9_mp" );
    helidelete();
}

// Namespace br_plunder
// Params 0
// Checksum 0x7a73e631, Offset: 0x7e24
// Size: 0x11
function helidelete()
{
    helicleanup();
    vehicle_tracking::delete_vehicle( self );
}

// Namespace br_plunder
// Params 1
// Checksum 0x91b4bd1b, Offset: 0x7e3d
// Size: 0x59
function helicrash( speed )
{
    self endon( #"explode" );
    self notify( #"heli_crashing" );
    self setvehgoalpos( self.origin + ( 0, 0, 100 ), 1 );
    hostmigration::waitlongdurationwithhostmigrationpause( 1.5 );
    self setyawspeed( speed, speed, speed );
}

// Namespace br_plunder
// Params 14
// Checksum 0x6bf6c9fd, Offset: 0x7e9e
// Size: 0x19e
function callback_vehicledamage( inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid )
{
    if ( isdefined( attacker ) )
    {
        if ( isdefined( attacker.owner ) )
        {
            attacker = attacker.owner;
        }
    }
    
    if ( level.extractplunderheliinvulnerable )
    {
        return;
    }
    
    if ( ( attacker == self || isdefined( attacker.pers ) && attacker.pers[ "team" ] == self.team && !level.friendlyfire && level.teambased ) && attacker != self.owner )
    {
        return;
    }
    
    if ( self.health <= 0 )
    {
        return;
    }
    
    damage = killstreak::getmodifiedantikillstreakdamage( attacker, objweapon, meansofdeath, damage, self.maxhealth, 3, 4, 5 );
    killstreaks::killstreakhit( attacker, objweapon, self, meansofdeath, damage );
    attacker damagefeedback::updatedamagefeedback( "" );
    
    if ( self.health - damage <= 900 && !self.smoking )
    {
        self.smoking = 1;
    }
    
    self vehicle_finishdamage( inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname );
}

// Namespace br_plunder
// Params 1
// Checksum 0xb66963d9, Offset: 0x8044
// Size: 0x1e7
function helileave( fromtimeout )
{
    if ( self.tryingtoleave || self.leaving )
    {
        return;
    }
    
    self endon( #"death" );
    self notify( #"hash_8c8d8512d8835926" );
    self.tryingtoleave = 1;
    
    if ( !level.gameended && !br_public::function_379fb7b09f4ef13e() )
    {
        level thread br_public::brleaderdialogteam( "plunder_extract_chopper_leave", self.team, 1 );
    }
    
    plunderrepository = self.site;
    
    if ( isdefined( plunderrepository ) )
    {
        plunder_repositoryclearcountdown( plunderrepository );
        helibankplunder( plunderrepository );
        
        if ( plunderrepository.heli == self )
        {
            plunderrepository.heli = undefined;
            plunderrepository.team = undefined;
            plunderrepository notify( #"hash_9c0cd27aba1401bb" );
        }
        
        plunderrepository thread heli_delayedpadstateupdate( self.site.type );
        self.site = undefined;
    }
    
    self.readytoleave = 1;
    self waittill( #"hash_8182ff35fd9e24b8" );
    self notify( #"leaving" );
    self.leaving = 1;
    self.tryingtoleave = undefined;
    animtime_out = getanimlength( level.scr_anim[ self.animname ][ "heli_out" ] );
    self.scenenode thread animation::anim_single_solo( self, "heli_out" );
    self.ropenode thread animation::anim_single_solo( self.rope, "rope_out", "tag_origin" );
    self.ropenode thread animation::anim_single_solo( self.crate, "bag_out", "tag_origin" );
    thread heli_blima_sfx( self, 2 );
    hostmigration::waitlongdurationwithpause( animtime_out );
    self stoploopsound();
    self notify( #"heli_gone" );
    helidelete();
}

// Namespace br_plunder
// Params 2
// Checksum 0x6945329c, Offset: 0x8233
// Size: 0x7f
function heli_blima_sfx( vehicle, sequence )
{
    switch ( sequence )
    {
        case 0:
            vehicle setscriptablepartstate( "plunder_sfx", "heli_in" );
            break;
        case 1:
            vehicle setscriptablepartstate( "plunder_sfx", "heli_loop" );
            break;
        case 2:
            vehicle setscriptablepartstate( "plunder_sfx", "heli_out" );
            break;
    }
}

// Namespace br_plunder
// Params 1
// Checksum 0xea005794, Offset: 0x82ba
// Size: 0x8a
function heli_delayedpadstateupdate( type )
{
    scriptablestate = level.showplunderextracticonsinworld && !level.shownonscriptableextracticons ? "inuseCurrent" : "inuse";
    self setscriptablepartstate( type, scriptablestate );
    wait 6;
    
    if ( isdefined( self ) )
    {
        scriptablestate = level.showplunderextracticonsinworld && !level.shownonscriptableextracticons ? self.activecurrstate : self.activestate;
        self setscriptablepartstate( type, scriptablestate );
    }
}

// Namespace br_plunder
// Params 0
// Checksum 0xc427c748, Offset: 0x834c
// Size: 0xba
function helidescend()
{
    self endon( #"death" );
    thread heli_blima_sfx( self, 0 );
    animtime_in = getanimlength( level.scr_anim[ self.animname ][ "heli_in" ] );
    self.scenenode thread animation::anim_single_solo( self, "heli_in" );
    self.ropenode thread animation::anim_single_solo( self.rope, "rope_in", "tag_origin" );
    self.ropenode thread animation::anim_single_solo( self.crate, "bag_in", "tag_origin" );
    hostmigration::waitlongdurationwithpause( animtime_in );
    thread heliplayloopanim();
    thread heliplayloopropeanim();
    thread heliplayloopbadanim();
}

// Namespace br_plunder
// Params 0
// Checksum 0x15de1881, Offset: 0x840e
// Size: 0x95
function heliplayloopanim()
{
    self endon( #"death" );
    self.scenenode endon( #"death" );
    animtime = getanimlength( level.scr_anim[ self.animname ][ "heli_loop" ] );
    
    while ( true )
    {
        self.scenenode thread animation::anim_single_solo( self, "heli_loop" );
        wait animtime;
        
        if ( self.readytoleave && !self.preventleave )
        {
            self notify( #"hash_8182ff35fd9e24b8" );
            break;
        }
    }
}

// Namespace br_plunder
// Params 0
// Checksum 0x19c13fe0, Offset: 0x84ab
// Size: 0x74
function heliplayloopropeanim()
{
    self endon( #"death" );
    animtime = getanimlength( level.scr_anim[ self.animname ][ "rope_loop" ] );
    
    while ( true )
    {
        self.ropenode thread animation::anim_single_solo( self.rope, "rope_loop", "tag_origin" );
        wait animtime;
        
        if ( self.readytoleave )
        {
            break;
        }
    }
}

// Namespace br_plunder
// Params 0
// Checksum 0xeed2441e, Offset: 0x8527
// Size: 0x74
function heliplayloopbadanim()
{
    self endon( #"death" );
    animtime = getanimlength( level.scr_anim[ self.animname ][ "bag_loop" ] );
    
    while ( true )
    {
        self.ropenode thread animation::anim_single_solo( self.crate, "bag_loop", "tag_origin" );
        wait animtime;
        
        if ( self.readytoleave )
        {
            break;
        }
    }
}

// Namespace br_plunder
// Params 0
// Checksum 0x51aaf29d, Offset: 0x85a3
// Size: 0x24, Type: bool
function entisalivevehicle()
{
    return isalive( self ) && ( vehicle::is_vehicle() || self.classname == "script_vehicle" );
}

// Namespace br_plunder
// Params 0
// Checksum 0x3a446247, Offset: 0x85d0
// Size: 0x70
function helidestroyvehiclestouchnotify()
{
    self endon( #"leaving" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"touch", vehicle );
        
        if ( isdefined( vehicle ) && vehicle entisalivevehicle() )
        {
            vehicle dodamage( vehicle.health, self.origin, vehicle, vehicle, "MOD_CRUSH" );
        }
    }
}

// Namespace br_plunder
// Params 0
// Checksum 0x62576429, Offset: 0x8648
// Size: 0x29a
function helidestroyvehiclestouchtrace()
{
    self endon( #"leaving" );
    self endon( #"death" );
    radius = 70;
    offsetdown = -80;
    forward = 150;
    middle = 25;
    back = -100;
    
    while ( true )
    {
        vehicles = getentarrayinradius( "script_vehicle", #classname, self.origin, getdvarfloat( @"test_radius", 400 ) );
        
        if ( vehicles.size <= 1 )
        {
            wait 0.5;
            continue;
        }
        
        vehiclecontents = trace::create_vehicle_contents();
        dir = anglestoforward( self.angles );
        origin = self.origin + dir * getdvarfloat( @"test_f", forward ) + ( 0, 0, getdvarfloat( @"test_d", offsetdown ) );
        trace = trace::sphere_trace( origin, origin + ( 0, 0, 1 ), radius, self, vehiclecontents );
        ent = trace[ "entity" ];
        
        if ( isdefined( ent ) && ent entisalivevehicle() )
        {
            ent dodamage( ent.health, self.origin, ent, ent, "MOD_CRUSH" );
            waitframe();
            continue;
        }
        
        origin = self.origin + dir * getdvarfloat( @"test_m", middle ) + ( 0, 0, getdvarfloat( @"test_d", offsetdown ) );
        trace = trace::sphere_trace( origin, origin + ( 0, 0, 1 ), radius, self, vehiclecontents );
        ent = trace[ "entity" ];
        
        if ( isdefined( ent ) && ent entisalivevehicle() )
        {
            ent dodamage( ent.health, self.origin, ent, ent, "MOD_CRUSH" );
            waitframe();
            continue;
        }
        
        origin = self.origin + dir * getdvarfloat( @"test_b", back ) + ( 0, 0, getdvarfloat( @"test_d", offsetdown ) );
        trace = trace::sphere_trace( origin, origin + ( 0, 0, 1 ), radius, self, vehiclecontents );
        ent = trace[ "entity" ];
        
        if ( isdefined( ent ) && ent entisalivevehicle() )
        {
            ent dodamage( ent.health, self.origin, ent, ent, "MOD_CRUSH" );
            waitframe();
            continue;
        }
        
        waitframe();
    }
}

// Namespace br_plunder
// Params 1
// Checksum 0x90255e8c, Offset: 0x88ea
// Size: 0x3d
function tracegroundheight( start )
{
    offgroundheight = 800;
    groundheight = tracegroundpoint( start );
    trueheight = groundheight + offgroundheight;
    return trueheight;
}

// Namespace br_plunder
// Params 1
// Checksum 0xc3c10aa9, Offset: 0x8930
// Size: 0xa7
function tracegroundpoint( start )
{
    self endon( #"death" );
    self endon( #"leaving" );
    var_aa0d98a844610c90 = -99999;
    end = ( start[ 0 ], start[ 1 ], var_aa0d98a844610c90 );
    ignorelist = [ self ];
    contents = trace::create_contents( 0, 1, 0, 1, 1, 0, 1, 1, 0 );
    trc = trace::sphere_trace( start, end, 100, ignorelist, contents, 1 );
    hightrace = trc[ "position" ][ 2 ];
    return hightrace;
}

// Namespace br_plunder
// Params 0
// Checksum 0x7634e759, Offset: 0x89e0
// Size: 0x2f
function heliwatchgameendleave()
{
    self endon( #"death" );
    self endon( #"hash_8c8d8512d8835926" );
    level waittill( #"game_ended" );
    thread helileave( 0 );
}

// Namespace br_plunder
// Params 2
// Checksum 0xa598f0ee, Offset: 0x8a17
// Size: 0x1e
function helicountdownendcallback( entity, fromtimeout )
{
    plunder_repositoryextract( entity );
}

// Namespace br_plunder
// Params 1
// Checksum 0x609e5918, Offset: 0x8a3d
// Size: 0x2f
function heliextractcallback( entity )
{
    if ( isdefined( entity.heli ) )
    {
        entity.heli thread helileave( 1 );
    }
}

// Namespace br_plunder
// Params 1
// Checksum 0xba983d75, Offset: 0x8a74
// Size: 0xc
function heliatcapacitycallback( entity )
{
    
}

// Namespace br_plunder
// Params 0
// Checksum 0x1bf72fa1, Offset: 0x8a88
// Size: 0x9
function plunderlivelobby()
{
    thread autopickupplunder();
}

// Namespace br_plunder
// Params 0
// Checksum 0x9038034, Offset: 0x8a99
// Size: 0x28, Type: bool
function inplunderlivelobby()
{
    return level.br_plunder_enabled && level.br_plunder_lobby && !flags::gameflag( "prematch_done" );
}

// Namespace br_plunder
// Params 0
// Checksum 0x183a9d51, Offset: 0x8aca
// Size: 0x106
function autopickupplunder()
{
    var_7423ad6452d00bcd = 0.1;
    var_7f3d1b3c243476af = 25;
    var_d5caad965ce99c98 = var_7f3d1b3c243476af * var_7f3d1b3c243476af;
    
    while ( inplunderlivelobby() )
    {
        for ( i = 0; i < level.br_plunder_ents.size ; i++ )
        {
            pickupent = level.br_plunder_ents[ i ];
            
            if ( !isdefined( pickupent ) )
            {
                continue;
            }
            
            var_15420ea8800257cb = pickupent.origin;
            
            for ( j = 0; j < level.players.size ; j++ )
            {
                player = level.players[ j ];
                
                if ( !isalive( player ) )
                {
                    continue;
                }
                
                distsq = distancesquared( player.origin, var_15420ea8800257cb );
                
                if ( distsq < var_d5caad965ce99c98 )
                {
                    player br_pickups::brpickupsusecallback( pickupent, player );
                    break;
                }
            }
        }
        
        wait var_7423ad6452d00bcd;
    }
}

// Namespace br_plunder
// Params 0
// Checksum 0x58097176, Offset: 0x8bd8
// Size: 0x51
function playerdelayautobankplunder()
{
    self notify( #"hash_1aa14995227b44d8" );
    self endon( #"hash_1aa14995227b44d8" );
    self endon( #"death_or_disconnect" );
    level endon( #"prematch_done" );
    level endon( #"game_ended" );
    wait 2;
    playerplunderbank( self.plundercount );
}

// Namespace br_plunder
// Params 1
// Checksum 0x41abd5bb, Offset: 0x8c31
// Size: 0xc0
function playerplunderlivelobbydropondeath( smeansofdeath )
{
    if ( !level.br_plunder_enabled )
    {
        return;
    }
    
    if ( inplunderlivelobby() )
    {
        dropall = smeansofdeath == "MOD_MELEE";
        amount = 1;
        
        if ( dropall && isdefined( self.plundercount ) && self.plundercount > 1 )
        {
            amount = self.plundercount;
            playersetplundercount( 0 );
        }
        
        if ( amount <= 0 )
        {
            return;
        }
        
        if ( level.br_plunder_ents.size > 0 )
        {
            level.br_plunder_ents = function_5713d46873b29625( level.br_plunder_ents );
        }
        
        dropstruct = pickups::function_f71dd588dc4f6288();
        return dropcondensedplunder( amount, dropstruct );
    }
}

/#

    // Namespace br_plunder
    // Params 0
    // Checksum 0xb9e7f9d, Offset: 0x8cf9
    // Size: 0xd9, Type: dev
    function function_a06671470d71635c()
    {
        level endon( #"game_ended" );
        
        while ( true )
        {
            if ( getdvarint( @"hash_9b7f60d28a567fea", 0 ) != 0 )
            {
                plunderextractlocations = getallextractspawninstances();
                
                foreach ( location in plunderextractlocations )
                {
                    thread debug_utility::drawsphere( location.origin, 820, 30, ( 0, 1, 0 ) );
                }
                
                setdevdvar( @"hash_9b7f60d28a567fea", 0 );
            }
            
            waitframe();
        }
    }

#/

// Namespace br_plunder
// Params 0
// Checksum 0x2b4974d3, Offset: 0x8dda
// Size: 0x15f
function initteamdatafields()
{
    foreach ( team in level.teamnamelist )
    {
        level.teamdata[ team ][ "plunderTeamTotal" ] = 0;
        level.teamdata[ team ][ "plunderInDeposit" ] = 0;
        level.teamdata[ team ][ "plunderBanked" ] = 0;
    }
    
    if ( game_utility::getgametype() == "risk" )
    {
        foreach ( team in level.teamnamelist )
        {
            level.teamdata[ team ][ "tokensTeamTotal" ] = 0;
            level.teamdata[ team ][ "tokensInDeposit" ] = 0;
            level.teamdata[ team ][ "tokensBanked" ] = 0;
        }
    }
}

// Namespace br_plunder
// Params 1
// Checksum 0xe34cd5e, Offset: 0x8f41
// Size: 0x6d
function getteamplunder( team )
{
    plundercount = 0;
    
    if ( !level.scorerequiresbanking )
    {
        plundercount += level.teamdata[ team ][ "plunderTeamTotal" ];
        plundercount += level.teamdata[ team ][ "plunderInDeposit" ];
    }
    
    plundercount += level.teamdata[ team ][ "plunderBanked" ];
    return plundercount;
}

// Namespace br_plunder
// Params 1
// Checksum 0xada5a48c, Offset: 0x8fb7
// Size: 0x1e
function getteamcarriedplunder( team )
{
    return level.teamdata[ team ][ "plunderTeamTotal" ];
}

// Namespace br_plunder
// Params 1
// Checksum 0xac73234a, Offset: 0x8fde
// Size: 0x1e
function getbankedplunder( team )
{
    return level.teamdata[ team ][ "plunderBanked" ];
}

// Namespace br_plunder
// Params 1
// Checksum 0x13005c3b, Offset: 0x9005
// Size: 0xd8
function getplundernamebyamount( amount )
{
    assert( isdefined( level.br_plunder ) && isdefined( level.br_plunder.quantity ) && isdefined( level.br_plunder.names ), "<dev string:x4c5>" );
    plundername = level.br_plunder.names[ 0 ];
    
    for ( i = level.br_plunder.quantity.size - 1; i > 0 ; i-- )
    {
        if ( amount >= level.br_plunder.quantity[ i ] )
        {
            plundername = level.br_plunder.names[ i ];
            break;
        }
    }
    
    return plundername;
}

// Namespace br_plunder
// Params 2
// Checksum 0xde681466, Offset: 0x90e6
// Size: 0x4d
function playplundersoundbyamount( player, amount )
{
    if ( amount == 0 )
    {
        return;
    }
    
    plundername = getplundernamebyamount( amount );
    soundalias = br_pickups::getcashsoundaliasforplayer( player, plundername );
    player playsoundtoplayer( soundalias, self );
}

// Namespace br_plunder
// Params 0
// Checksum 0x56a15392, Offset: 0x913b
// Size: 0x1f0
function processcashpilevalueoverrides()
{
    overridescalar = getdvarint( @"hash_3c33b53363a2fb48", 1 );
    
    if ( overridescalar <= 1 )
    {
        return;
    }
    
    foreach ( name, value in level.br_pickups.counts )
    {
        if ( !issubstr( name, "brloot_plunder_cash" ) )
        {
            continue;
        }
        
        basevalue = level.br_pickups.counts[ name ];
        newvalue = basevalue * overridescalar;
        level.br_pickups.counts[ name ] = newvalue;
        scriptables = getentitylessscriptablearray( name );
        
        if ( scriptables.size >= 1 )
        {
            foreach ( scriptable in scriptables )
            {
                scriptable.count = newvalue;
            }
        }
    }
    
    for ( i = 0; i < level.br_plunder.names.size ; i++ )
    {
        level.br_plunder.quantity[ i ] = level.br_pickups.counts[ level.br_plunder.names[ i ] ];
    }
}

// Namespace br_plunder
// Params 1
// Checksum 0x47a0f8a5, Offset: 0x9333
// Size: 0x185
function processcashpileovertimemultiplier( multiplier )
{
    foreach ( index, name in level.br_plunder.names )
    {
        level.br_plunder.quantity[ index ] = int( float( level.br_plunder.quantity[ index ] ) * multiplier );
        level.br_pickups.counts[ name ] = level.br_plunder.quantity[ index ];
        scriptables = getentitylessscriptablearray( name );
        
        foreach ( scriptable in scriptables )
        {
            scriptable.count = level.br_plunder.quantity[ index ];
        }
        
        waitframe();
    }
}

// Namespace br_plunder
// Params 0
// Checksum 0x10204ec6, Offset: 0x94c0
// Size: 0xd7
function debug_calculatecashonground()
{
    total = 0;
    
    foreach ( name in level.br_plunder.names )
    {
        scriptables = getentitylessscriptablearray( name );
        total += scriptables.size * level.br_pickups.counts[ name ];
    }
    
    total *= 100;
    level.totalcashongroundatstart = total;
    println( "<dev string:x4fb>" + total );
}

// Namespace br_plunder
// Params 0
// Checksum 0x66aef8c5, Offset: 0x959f
// Size: 0x15c
function plunder_initrepositories()
{
    assert( !isdefined( level.plunderrepositories ), "<dev string:x50d>" );
    level.plunderrepositories = spawnstruct();
    level.plunderrepositories.data = [];
    level.plunderrepositories.instances = [];
    level.plunderrepositories.uniqueinstanceid = 0;
    level.plunderrepositories.teamanchoredwidgetinstances = [];
    level.plunderrepositories.teamanchoredentomnvars = [];
    level.plunderrepositories.teamanchoredinfoomnvars = [];
    
    for ( i = 1; i <= 4 ; i++ )
    {
        level.plunderrepositories.teamanchoredentomnvars[ i ] = "ui_br_plunder_repo_ent_" + i;
        level.plunderrepositories.teamanchoredinfoomnvars[ i ] = "ui_br_plunder_repo_info_" + i;
    }
    
    interactive::interactive_addusedcallback( &plunder_repositoryusecallback, "plunderRepository" );
    scriptable::scriptable_addusedcallback( &plunder_repositoryusescriptablecallback );
    callback::add( #"player_spawned", &plunder_playerspawnedcallback );
    level.plunderusedisabledwhenempty = getdvarint( @"hash_eb449c46ed5955e6", 0 ) > 0;
    
    /#
        setdevdvarifuninitialized( @"hash_eb449c46ed5955e6", 0 );
    #/
}

// Namespace br_plunder
// Params 3
// Checksum 0xb14a8245, Offset: 0x9703
// Size: 0x1df
function plunder_getleveldataforrepository( ref, create, var_e6c819f806ce2c86 )
{
    leveldata = level.plunderrepositories;
    assert( isdefined( leveldata ), "<dev string:x544>" );
    leveldataforrepository = leveldata.data[ ref ];
    
    if ( !isdefined( leveldataforrepository ) )
    {
        if ( create )
        {
            leveldataforrepository = spawnstruct();
            leveldata.data[ ref ] = leveldataforrepository;
            leveldataforrepository.usetime = 0.75;
            leveldataforrepository.useeventtype = 2;
            leveldataforrepository.useeventamount = 250;
            leveldataforrepository.teamuseonly = 1;
            leveldataforrepository.teamanchoredwidget = 0;
            leveldataforrepository.usefaillaststandmsg = %"mp/cannot_deposit_ls";
            leveldataforrepository.usefailvehiclemsg = %"mp/cannot_deposit_vehicle";
            leveldataforrepository.usefailcapacitymsg = %"mp/placeholder_cannot_deposit_full";
            leveldataforrepository.usefailnoplundermsg = %"mp/cannot_deposit_no_cash";
            leveldataforrepository.usefailextractingmsg = %"mp/placeholder_cannot_deposit_leaving";
            leveldataforrepository.scriptableusepart = undefined;
            leveldataforrepository.scriptableusestate = undefined;
            leveldataforrepository.scriptablenousestate = undefined;
            leveldataforrepository.extractcountdown = 60;
            leveldataforrepository.extractsilentcountdown = 0;
            leveldataforrepository.extractcountdownmsg = %"mp/placeholder_leaving_in_n";
            leveldataforrepository.capacity = 2000;
            leveldataforrepository.useshouldsucceedcallback = undefined;
            leveldataforrepository.usecallback = &plunder_repositoryplayerplundereventcallback;
            leveldataforrepository.countdownendcallback = undefined;
            leveldataforrepository.extractcallback = undefined;
            leveldataforrepository.extractionmethod = undefined;
        }
        else
        {
            assert( var_e6c819f806ce2c86, "<dev string:x592>" );
        }
    }
    
    return leveldataforrepository;
}

// Namespace br_plunder
// Params 2
// Checksum 0x9aa9f3cb, Offset: 0x98eb
// Size: 0x141
function plunder_registerrepositoryinstance( entity, ref )
{
    leveldata = level.plunderrepositories;
    assert( isdefined( leveldata ), "<dev string:x5d0>" );
    leveldataforrepository = plunder_getleveldataforrepository( ref );
    entity.plunderrepositoryref = ref;
    entity.startorigin = entity.origin;
    entity.plunder = [];
    entity.plundertotal = 0;
    entity.plunderinstanceid = level.plunderrepositories.uniqueinstanceid;
    level.plunderrepositories.uniqueinstanceid++;
    entity.playersusing = [];
    leveldata.instances[ entity.plunderinstanceid ] = entity;
    assert( !isdefined( leveldataforrepository.teamuseonly ) || isdefined( entity.team ), "<dev string:x61f>" );
    plunder_addanchoredwidgettorepositoryinstance( entity );
    
    if ( !isdefined( leveldataforrepository.scriptableusepart ) )
    {
        entity interactive::interactive_addusedcallbacktoentity( "plunderRepository" );
    }
    
    plunder_allowrepositoryuse( entity, 1 );
}

// Namespace br_plunder
// Params 1
// Checksum 0xf228ab61, Offset: 0x9a34
// Size: 0xd8
function plunder_deregisterrepositoryinstance( entity )
{
    leveldata = level.plunderrepositories;
    assert( isdefined( leveldata ), "<dev string:x652>" );
    entity notify( #"hash_7c251e8cb085f995" );
    plunder_allowrepositoryuse( entity, 0, 1 );
    entity.plunderrepositoryref = undefined;
    entity.plunderusable = undefined;
    entity.plunderatcapacity = undefined;
    entity.startorigin = undefined;
    entity.plunder = undefined;
    entity.plundertotal = undefined;
    plunder_repositoryclearcountdown( entity );
    entity.playersusing = undefined;
    
    if ( isdefined( entity.plunderinstanceid ) )
    {
        leveldata.instances[ entity.plunderinstanceid ] = undefined;
    }
    
    plunder_removeanchoredwidgetfromrepositoryinstance( entity );
    entity interactive::interactive_removeusedcallbackfromentity();
}

// Namespace br_plunder
// Params 1
// Checksum 0x6de2de9b, Offset: 0x9b14
// Size: 0x61, Type: bool
function plunder_repositoryinstanceisregistered( entity )
{
    leveldata = level.plunderrepositories;
    
    if ( !isdefined( leveldata ) )
    {
        return false;
    }
    
    instance = undefined;
    
    if ( isdefined( entity.plunderinstanceid ) )
    {
        instance = leveldata.instances[ entity.plunderinstanceid ];
    }
    
    return instance == entity;
}

// Namespace br_plunder
// Params 3
// Checksum 0x42a6f9ef, Offset: 0x9b7e
// Size: 0x213
function plunder_allowrepositoryuse( entity, bool, var_e6c819f806ce2c86 )
{
    entity notify( #"hash_e8465e769745abf2" );
    assert( var_e6c819f806ce2c86 || isdefined( entity.plunderrepositoryref ), "<dev string:x6a3>" );
    leveldataforrepository = undefined;
    
    if ( isdefined( entity.plunderrepositoryref ) )
    {
        leveldataforrepository = plunder_getleveldataforrepository( entity.plunderrepositoryref, undefined, var_e6c819f806ce2c86 );
    }
    
    if ( isdefined( leveldataforrepository ) )
    {
        if ( isdefined( leveldataforrepository.scriptableusepart ) )
        {
            assert( isdefined( leveldataforrepository.scriptableusestate ), "<dev string:x6e0>" + entity.plunderrepositoryref + "<dev string:x6f5>" );
            assert( isdefined( leveldataforrepository.scriptablenousestate ), "<dev string:x6e0>" + entity.plunderrepositoryref + "<dev string:x71b>" );
            
            if ( bool )
            {
                entity setscriptablepartstate( leveldataforrepository.scriptableusepart, leveldataforrepository.scriptableusestate, 0 );
            }
            else
            {
                entity setscriptablepartstate( leveldataforrepository.scriptableusepart, leveldataforrepository.scriptablenousestate, 0 );
            }
        }
        else if ( bool )
        {
            entity makeusable();
        }
        else
        {
            entity makeunusable();
        }
        
        var_ebc4424c101860a9 = istrue( entity.plunderusable );
        entity.plunderusable = bool ? bool : undefined;
        
        if ( !var_ebc4424c101860a9 )
        {
            if ( bool )
            {
                foreach ( player in level.players )
                {
                    plunder_allowrepositoryuseforplayer( entity, player, plunder_playercanuserepository( entity, player ) );
                }
            }
            
            return;
        }
        
        if ( !bool )
        {
            entity notify( #"hash_50b097dbaaf09d4a" );
        }
    }
}

// Namespace br_plunder
// Params 4
// Checksum 0xc6d8ff16, Offset: 0x9d99
// Size: 0x119
function plunder_allowrepositoryuseforplayer( entity, player, bool, var_e6c819f806ce2c86 )
{
    assert( var_e6c819f806ce2c86 || isdefined( entity.plunderrepositoryref ), "<dev string:x6a3>" );
    leveldataforrepository = undefined;
    
    if ( isdefined( entity.plunderrepositoryref ) )
    {
        leveldataforrepository = plunder_getleveldataforrepository( entity.plunderrepositoryref, undefined, var_e6c819f806ce2c86 );
    }
    
    if ( isdefined( leveldataforrepository ) )
    {
        if ( isdefined( leveldataforrepository.scriptableusepart ) )
        {
            assert( isdefined( leveldataforrepository.scriptableusestate ), "<dev string:x6e0>" + entity.plunderrepositoryref + "<dev string:x6f5>" );
            
            if ( bool )
            {
                entity enablescriptablepartplayeruse( leveldataforrepository.scriptableusepart, player );
            }
            else
            {
                entity disablescriptablepartplayeruse( leveldataforrepository.scriptableusepart, player );
            }
        }
        else if ( bool )
        {
            entity enableplayeruse( player );
        }
        else
        {
            entity disableplayeruse( player );
        }
    }
    
    if ( !bool )
    {
        entity notify( "repository_use_disabled_for_" + player getentitynumber() );
    }
}

// Namespace br_plunder
// Params 3
// Checksum 0x38b8a693, Offset: 0x9eba
// Size: 0xc1
function plunder_allowallrepositoryuseforplayer( player, bool, var_e6c819f806ce2c86 )
{
    leveldata = level.plunderrepositories;
    
    if ( !isdefined( leveldata.instances ) )
    {
        return;
    }
    
    foreach ( instance in leveldata.instances )
    {
        plunder_allowrepositoryuseforplayer( instance, player, bool, 1 );
    }
}

// Namespace br_plunder
// Params 2
// Checksum 0xdff0f362, Offset: 0x9f83
// Size: 0x89, Type: bool
function plunder_playercanuserepository( entity, player )
{
    if ( player vehicle::is_in_vehicle() )
    {
        return false;
    }
    
    if ( player::isinlaststand( player ) )
    {
        return false;
    }
    
    leveldataforrepository = plunder_getleveldataforrepository( entity.plunderrepositoryref );
    
    if ( leveldataforrepository.teamuseonly && isdefined( entity.team ) && player.team != entity.team )
    {
        return false;
    }
    
    return true;
}

// Namespace br_plunder
// Params 3
// Checksum 0x93180701, Offset: 0xa015
// Size: 0x24f
function plunder_playerrepositoryuseshouldsucceed( entity, player, showerror )
{
    leveldataforrepository = plunder_getleveldataforrepository( entity.plunderrepositoryref );
    
    if ( !entity.plunderusable )
    {
        return 0;
    }
    
    if ( leveldataforrepository.useeventtype == 2 || leveldataforrepository.useeventtype == 3 )
    {
        if ( player.plundercount <= 0 && ( !isdefined( player.extractquest_alwaysallowdeposit ) || player.extractquest_helipadid != entity.index ) )
        {
            if ( showerror && isdefined( leveldataforrepository.usefailnoplundermsg ) && leveldataforrepository.usefailnoplundermsg != "" )
            {
                player playlocalsound( "br_plunder_atm_cancel" );
                player hud_message::showerrormessage( leveldataforrepository.usefailnoplundermsg );
            }
            
            return 0;
        }
        else if ( entity.plunderatcapacity )
        {
            if ( showerror && isdefined( leveldataforrepository.usefailcapacitymsg ) && leveldataforrepository.usefailcapacitymsg != "" )
            {
                player playlocalsound( "br_plunder_atm_cancel" );
                player hud_message::showerrormessage( leveldataforrepository.usefailcapacitymsg );
            }
            
            return 0;
        }
    }
    
    if ( player vehicle::is_in_vehicle() )
    {
        if ( showerror && isdefined( leveldataforrepository.usefailvehiclemsg ) && leveldataforrepository.usefailvehiclemsg != "" )
        {
            player playlocalsound( "br_plunder_atm_cancel" );
            player hud_message::showerrormessage( leveldataforrepository.usefailvehiclemsg );
        }
        
        return 0;
    }
    
    if ( player::isinlaststand( player ) )
    {
        if ( showerror && isdefined( leveldataforrepository.usefaillaststandmsg ) && leveldataforrepository.usefaillaststandmsg != "" )
        {
            player playlocalsound( "br_plunder_atm_cancel" );
            player hud_message::showerrormessage( leveldataforrepository.usefaillaststandmsg );
        }
        
        return 0;
    }
    
    if ( player isparachuting() || player isskydiving() )
    {
        return 0;
    }
    
    if ( player isinexecutionattack() || player isinexecutionvictim() )
    {
        return 0;
    }
    
    if ( isdefined( leveldataforrepository.useshouldsucceedcallback ) )
    {
        return [[ leveldataforrepository.useshouldsucceedcallback ]]( entity, player, showerror );
    }
    
    return 1;
}

// Namespace br_plunder
// Params 6
// Checksum 0xbebb617a, Offset: 0xa26d
// Size: 0x140
function plunder_repositoryusescriptablecallback( instance, part, state, player, bautouse, usestring )
{
    if ( !isdefined( instance ) )
    {
        return;
    }
    
    entity = instance.entity;
    
    if ( !isdefined( entity ) || isdefined( entity.forceextractscriptable ) )
    {
        entity = instance;
    }
    
    if ( !plunder_repositoryinstanceisregistered( entity ) )
    {
        return;
    }
    
    leveldataforrepository = plunder_getleveldataforrepository( entity.plunderrepositoryref );
    
    if ( !isdefined( leveldataforrepository.scriptableusepart ) )
    {
        return;
    }
    
    assert( isdefined( leveldataforrepository.scriptableusestate ), "<dev string:x6e0>" + entity.plunderrepositoryref + "<dev string:x6f5>" );
    assert( isdefined( leveldataforrepository.scriptablenousestate ), "<dev string:x6e0>" + entity.plunderrepositoryref + "<dev string:x71b>" );
    
    if ( part != leveldataforrepository.scriptableusepart )
    {
        return;
    }
    
    if ( state != leveldataforrepository.scriptableusestate )
    {
        return;
    }
    
    if ( !plunder_playerrepositoryuseshouldsucceed( entity, player, 1 ) )
    {
        return;
    }
    
    thread plunder_repositoryusecallbackinternal( entity, player );
}

// Namespace br_plunder
// Params 2
// Checksum 0x8d73ecec, Offset: 0xa3b5
// Size: 0x3c
function plunder_repositoryusecallback( entity, player )
{
    if ( !plunder_repositoryinstanceisregistered( entity ) )
    {
        return;
    }
    
    if ( !plunder_playerrepositoryuseshouldsucceed( entity, player, 1 ) )
    {
        return;
    }
    
    thread plunder_repositoryusecallbackinternal( entity, player );
}

// Namespace br_plunder
// Params 2
// Checksum 0x5b31e9f0, Offset: 0xa3f9
// Size: 0x180
function plunder_repositoryusecallbackinternal( entity, player )
{
    entnum = player getentitynumber();
    timestamp = gettime();
    plunder_repositoryenableuserestrictions( player, 1 );
    plunder_allowrepositoryuseforplayer( entity, player, 0 );
    plunder_repositorywatchuse( entity, player );
    
    if ( isdefined( player ) )
    {
        if ( isdefined( entity ) )
        {
            plunder_allowrepositoryuseforplayer( entity, player, 1 );
        }
        
        if ( player player::isreallyalive() )
        {
            plunder_repositoryenableuserestrictions( player, 0 );
        }
        
        player.plunderrepositoryrestricted = undefined;
        
        if ( isplayer( player ) )
        {
            tapuse = 0;
            cleardelay = undefined;
            
            if ( !tapuse && player player::isreallyalive() && !player vehicle::is_in_vehicle() && !player::isinlaststand( player ) )
            {
                if ( entity.extracting )
                {
                    cleardelay = 2;
                }
                else if ( isdefined( player.plunderrepositorywidget ) && isdefined( player.plunderrepositorywidget.useeventtimestamp ) && player.plunderrepositorywidget.useeventtimestamp - gettime() <= 1.5 )
                {
                    cleardelay = 1.5;
                }
            }
            
            thread plunder_clearrepositorywidgetforplayer( player, cleardelay );
        }
    }
    
    if ( isdefined( entity ) && isdefined( entity.playersusing ) )
    {
        entity.playersusing[ entnum ] = undefined;
    }
    
    if ( isplayer( player ) )
    {
        plunder_updateanchoredwidgetforplayers( entity, player );
    }
}

// Namespace br_plunder
// Params 2
// Checksum 0xaeff2c44, Offset: 0xa581
// Size: 0x21f
function plunder_repositorywatchuse( entity, player )
{
    player endon( #"death_or_disconnect" );
    player endon( #"last_stand_enter" );
    entity endon( #"death" );
    entity endon( #"hash_50b097dbaaf09d4a" );
    entity endon( "repository_use_disabled_for_" + player getentitynumber() );
    level endon( #"game_ended" );
    leveldataforrepository = plunder_getleveldataforrepository( entity.plunderrepositoryref );
    entity.playersusing[ player getentitynumber() ] = player;
    plunder_updaterepositorywidgetforplayer( player, entity.plunderinstanceid, leveldataforrepository.type, 1, entity.plundercountdownendtime, entity.plundertotal );
    plunder_sendrepositorywidgetomnvar( player );
    plunder_updateanchoredwidgetforplayers( entity, player );
    entity notify( #"hash_d5584892927785ee" );
    var_8e6b6804888990ba = 0;
    usetime = 0;
    var_627cfe9c5b3085a3 = leveldataforrepository.usetime;
    lastbanktime = 0;
    
    while ( player usebuttonpressed() )
    {
        showmessage = undefined;
        
        if ( var_8e6b6804888990ba )
        {
            var_8e6b6804888990ba = 0;
            showmessage = 0;
        }
        else
        {
            showmessage = 1;
        }
        
        if ( !plunder_playerrepositoryuseshouldsucceed( entity, player, showmessage ) )
        {
            return;
        }
        
        if ( usetime >= var_627cfe9c5b3085a3 )
        {
            var_f72f10f414dc890f = int( min( player.plundercount, leveldataforrepository.useeventamount ) );
            
            if ( isdefined( leveldataforrepository.usecallback ) )
            {
                thread [[ leveldataforrepository.usecallback ]]( entity, player, var_f72f10f414dc890f );
            }
            else
            {
                assertmsg( "<dev string:x743>" + entity.plunderrepositoryref + "<dev string:x75f>" );
            }
            
            lastbanktime = usetime;
            var_627cfe9c5b3085a3 = usetime + leveldataforrepository.usetime;
            
            if ( isdefined( player.plunderrepositorywidget ) )
            {
                player.plunderrepositorywidget.useeventtimestamp = gettime();
            }
            
            var_8e6b6804888990ba = 1;
        }
        
        wait 0.05;
        usetime += 0.05;
    }
}

// Namespace br_plunder
// Params 3
// Checksum 0xa4e660fa, Offset: 0xa7a8
// Size: 0x11a
function plunder_repositoryplayerplundereventcallback( entity, player, amount )
{
    leveldataforrepository = plunder_getleveldataforrepository( entity.plunderrepositoryref );
    
    if ( utility::callsharedfunc( #"game", #"isCommonItemEnabled" ) )
    {
        plundereventcallback = level.playerplundereventcallbacks[ leveldataforrepository.useeventtype ];
        
        if ( isdefined( plundereventcallback ) )
        {
            data = player [[ plundereventcallback ]]( amount, entity, data );
        }
        
        player function_408935a50816b5c6( data, leveldataforrepository.useeventtype );
        player currency::function_b5fe1e05c892a7f3( "cash", amount );
    }
    else
    {
        data = player playerplunderevent( amount, leveldataforrepository.useeventtype, entity );
        
        if ( isdefined( data ) && isdefined( data.amount ) )
        {
            amount = data.amount;
        }
    }
    
    if ( amount > 0 )
    {
        plunder_updaterepositorywidgetforplayer( player, undefined, undefined, undefined, undefined, entity.plundertotal, amount );
        plunder_sendrepositorywidgetomnvar( player );
    }
}

// Namespace br_plunder
// Params 2
// Checksum 0x3913117b, Offset: 0xa8ca
// Size: 0x12f
function plunder_repositoryenableuserestrictions( player, bool )
{
    restrictions = [ "allow_movement", "usability", "weapon_switch", "equipment_primary", "equipment_secondary", "supers", "killstreaks", "fire", "melee", "reload", "ads", "mantle", "mount_top", "mount_side", "execution_attack", "vehicle_use", "cough_gesture" ];
    
    if ( player.plunderrepositoryrestricted && bool )
    {
        return;
    }
    
    if ( !player.plunderrepositoryrestricted && !bool )
    {
        return;
    }
    
    if ( bool )
    {
        player val::set_array( "plunder", restrictions, 0 );
    }
    else
    {
        player val::reset_all( "plunder" );
    }
    
    if ( bool )
    {
        player.plunderrepositoryrestricted = 1;
        return;
    }
    
    player.plunderrepositoryrestricted = undefined;
}

// Namespace br_plunder
// Params 2
// Checksum 0xd8d6eeeb, Offset: 0xaa01
// Size: 0x29d
function plunder_repositorywatchcountdown( entity, players )
{
    entity endon( #"death" );
    entity endon( #"hash_7c251e8cb085f995" );
    entity notify( #"hash_242f84d32bd8a18c" );
    entity endon( #"hash_242f84d32bd8a18c" );
    level endon( #"game_ended" );
    leveldataforrepository = plunder_getleveldataforrepository( entity.plunderrepositoryref );
    
    if ( !isdefined( entity.plundercountdownplayers ) )
    {
        entity.plundercountdownplayers = [];
        entity.plundercountdownupdatetime = 0;
        silentcountdown = leveldataforrepository.extractsilentcountdown ?? 0;
        countdown = leveldataforrepository.extractcountdown ?? 0;
        entity.plundersilentcountdownendtime = gettime() + silentcountdown * 1000;
        entity.plundercountdownendtime = gettime() + ( silentcountdown + countdown ) * 1000;
    }
    
    if ( isdefined( players ) )
    {
        if ( !isarray( players ) )
        {
            players = [ players ];
        }
        
        foreach ( player in players )
        {
            if ( isplayer( player ) )
            {
                entity.plundercountdownplayers[ player getentitynumber() ] = player;
            }
        }
    }
    
    while ( gettime() <= entity.plundercountdownendtime )
    {
        if ( gettime() - entity.plundercountdownupdatetime >= 1000 )
        {
            if ( gettime() > entity.plundersilentcountdownendtime )
            {
                msgvalue = int( max( 0, ( entity.plundercountdownendtime - gettime() ) / 1000 ) );
                
                foreach ( player in entity.plundercountdownplayers )
                {
                    if ( isdefined( player ) )
                    {
                        thread plunder_repositorysendcountdownmessage( player, entity, msgvalue );
                    }
                }
            }
            
            entity.plundercountdownupdatetime = gettime();
        }
        
        wait 0.05;
    }
    
    thread plunder_repositoryendcountdown( entity, 1 );
}

// Namespace br_plunder
// Params 2
// Checksum 0x845c2495, Offset: 0xaca6
// Size: 0x5b
function plunder_repositoryendcountdown( entity, fromtimeout )
{
    plunder_repositoryclearcountdown( entity );
    leveldataforrepository = plunder_getleveldataforrepository( entity.plunderrepositoryref );
    
    if ( isdefined( leveldataforrepository.countdownendcallback ) )
    {
        [[ leveldataforrepository.countdownendcallback ]]( entity, fromtimeout );
    }
}

// Namespace br_plunder
// Params 1
// Checksum 0xac053235, Offset: 0xad09
// Size: 0x3a
function plunder_repositoryclearcountdown( entity )
{
    entity notify( #"hash_242f84d32bd8a18c" );
    entity.plundercountdownplayers = undefined;
    entity.plundercountdownendtime = undefined;
    entity.plundercountdownupdatetime = undefined;
}

// Namespace br_plunder
// Params 3
// Checksum 0xece8db0e, Offset: 0xad4b
// Size: 0x1d6
function plunder_repositorysendcountdownmessage( player, entity, value )
{
    player endon( #"disconnect" );
    player notify( #"hash_b28b14d97f74e3e2" );
    player endon( #"hash_b28b14d97f74e3e2" );
    level endon( #"game_ended" );
    
    if ( !isdefined( player.plundercountdownmessagedata ) )
    {
        player.plundercountdownmessagedata = [];
    }
    
    leveldataforrepository = plunder_getleveldataforrepository( entity.plunderrepositoryref );
    
    if ( isdefined( leveldataforrepository.extractcountdownmsg ) )
    {
        data = spawnstruct();
        data.origin = entity.origin;
        data.msg = leveldataforrepository.extractcountdownmsg;
        data.value = value;
        player.plundercountdownmessagedata[ player.plundercountdownmessagedata.size ] = data;
    }
    
    waittillframeend();
    
    if ( !player br_public::isplayeringulag() && player player::isreallyalive() )
    {
        bestdata = undefined;
        bestdistsqr = 2147483647;
        
        foreach ( data in player.plundercountdownmessagedata )
        {
            testdistsqr = distance2dsquared( player.origin, data.origin );
            
            if ( testdistsqr < bestdistsqr )
            {
                bestdistsqr = testdistsqr;
                bestdata = data;
            }
        }
    }
    
    player.plundercountdownmessagedata = undefined;
}

// Namespace br_plunder
// Params 1
// Checksum 0x2ad71678, Offset: 0xaf29
// Size: 0x72
function plunder_repositoryextract( entity )
{
    entity.extracting = 1;
    plunder_repositoryclearcountdown( entity );
    plunder_allowrepositoryuse( entity, 0 );
    plunder_removeanchoredwidgetfromrepositoryinstance( entity );
    leveldataforrepository = plunder_getleveldataforrepository( entity.plunderrepositoryref );
    
    if ( isdefined( leveldataforrepository.extractcallback ) )
    {
        [[ leveldataforrepository.extractcallback ]]( entity );
    }
}

// Namespace br_plunder
// Params 1
// Checksum 0xde83b779, Offset: 0xafa3
// Size: 0x60
function plunder_repositoryatcapacity( entity )
{
    entity.plunderatcapacity = 1;
    plunder_allowrepositoryuse( entity, 0 );
    leveldataforrepository = plunder_getleveldataforrepository( entity.plunderrepositoryref );
    
    if ( isdefined( leveldataforrepository.atcapacitycallback ) )
    {
        [[ leveldataforrepository.atcapacitycallback ]]( entity );
    }
}

// Namespace br_plunder
// Params 1
// Checksum 0xf573e4, Offset: 0xb00b
// Size: 0x18
function plunder_playerspawnedcallback( params )
{
    plunder_allowallrepositoryuseforplayer( self, 1, 1 );
}

// Namespace br_plunder
// Params 7
// Checksum 0x2577ee80, Offset: 0xb02b
// Size: 0x314
function plunder_updaterepositorywidgetforplayer( player, plunderinstanceid, type, visible, endtime, plundertotal, plundereventamount )
{
    if ( isdefined( visible ) && !visible )
    {
        plunder_clearrepositorywidgetforplayer( player );
        return;
    }
    
    data = player.plunderrepositorywidget;
    
    if ( !isdefined( data ) )
    {
        data = spawnstruct();
        player.plunderrepositorywidget = data;
        data.plunderinstanceid = plunderinstanceid;
        data.type = type;
        data.visible = 0;
        data.endtime = undefined;
        data.plundertotal = undefined;
        data.plundereventamount = undefined;
        data.timestamp = undefined;
        assert( isdefined( data.plunderinstanceid ), "<dev string:x761>" );
        assert( isdefined( data.type ), "<dev string:x7b8>" );
    }
    else if ( isdefined( plunderinstanceid ) && isdefined( data.plunderinstanceid ) && plunderinstanceid != data.plunderinstanceid )
    {
        return;
    }
    
    var_65e5aec3725d1a7f = 0;
    
    if ( visible )
    {
        var_65e5aec3725d1a7f = !data.visible;
        data.visible = 1;
    }
    
    assert( !var_65e5aec3725d1a7f || isdefined( endtime ), "<dev string:x802>" );
    
    if ( isdefined( endtime ) )
    {
        data.endtime = endtime;
    }
    
    assert( !var_65e5aec3725d1a7f || isdefined( plundertotal ), "<dev string:x84e>" );
    
    if ( isdefined( plundertotal ) )
    {
        data.plundertotal = plundertotal;
    }
    
    if ( isdefined( plundereventamount ) )
    {
        assert( !isdefined( data.plundereventamount ) || data.timestamp < gettime(), "<dev string:x89e>" );
        data.plundereventamount = plundereventamount;
        entity = level.plunderrepositories.instances[ data.plunderinstanceid ];
        
        foreach ( _player in entity.playersusing )
        {
            if ( _player != player )
            {
                plunder_updaterepositorywidgetforplayer( player, undefined, undefined, undefined, undefined, plundertotal, undefined );
                plunder_sendrepositorywidgetomnvar( player );
            }
        }
        
        if ( isdefined( entity.team ) )
        {
            plunder_updateanchoredwidgetforplayers( entity, teams::getfriendlyplayers( entity.team ) );
        }
    }
    else if ( data.timestamp < gettime() )
    {
        data.plundereventamount = undefined;
    }
    
    data.timestamp = gettime();
}

// Namespace br_plunder
// Params 2
// Checksum 0xa4977f5a, Offset: 0xb347
// Size: 0x51
function plunder_clearrepositorywidgetforplayer( player, delay )
{
    player endon( #"disconnect" );
    player endon( #"hash_a765d688237168ef" );
    player.plunderrepositorywidget = undefined;
    
    if ( delay > 0 )
    {
        wait delay;
    }
    
    player setclientomnvar( "ui_br_plunder_repository", 0 );
}

// Namespace br_plunder
// Params 1
// Checksum 0x49fe407, Offset: 0xb3a0
// Size: 0x189
function plunder_sendrepositorywidgetomnvar( player )
{
    player notify( #"hash_a765d688237168ef" );
    data = player.plunderrepositorywidget;
    
    if ( !isdefined( data ) )
    {
        player setclientomnvar( "ui_br_plunder_repository", 0 );
        return;
    }
    
    value = 0;
    bit = 0;
    payload = data.visible;
    payloadsize = 1;
    
    if ( isdefined( payload ) )
    {
        value |= int( payload ) << bit;
    }
    
    bit += payloadsize;
    payload = data.type;
    payloadsize = 1;
    
    if ( isdefined( payload ) )
    {
        value |= int( payload ) << bit;
    }
    
    bit += payloadsize;
    payload = data.endtime;
    payloadsize = 14;
    
    if ( isdefined( payload ) )
    {
        payload = int( payload / 250 );
        payload &= 16383;
        value |= int( payload ) << bit;
    }
    
    bit += payloadsize;
    
    if ( data.type == 0 )
    {
        payload = data.plundertotal;
        payloadsize = 10;
        
        if ( isdefined( payload ) )
        {
            payload = int( payload / 5 );
            payload &= 1023;
            value |= int( payload ) << bit;
        }
    }
    
    eventamount = data.plundereventamount;
    
    if ( isdefined( eventamount ) )
    {
        eventamount = int( eventamount / 5 );
        player setclientomnvar( "ui_br_plunder_repository_event_amount", eventamount );
    }
    
    player setclientomnvar( "ui_br_plunder_repository", value );
}

// Namespace br_plunder
// Params 1
// Checksum 0x69095752, Offset: 0xb531
// Size: 0x2cd
function plunder_addanchoredwidgettorepositoryinstance( entity )
{
    leveldata = level.plunderrepositories;
    leveldataforrepository = plunder_getleveldataforrepository( entity.plunderrepositoryref );
    
    if ( !leveldataforrepository.teamanchoredwidget )
    {
        return;
    }
    
    assert( leveldataforrepository.teamuseonly, "<dev string:x8e4>" );
    
    if ( !isdefined( leveldata.teamanchoredwidgetinstances[ entity.team ] ) )
    {
        leveldata.teamanchoredwidgetinstances[ entity.team ] = [];
    }
    
    var_627753e41d328a23 = [];
    
    for ( i = 1; i <= 4 ; i++ )
    {
        var_627753e41d328a23[ i ] = i;
    }
    
    foreach ( instance in leveldata.teamanchoredwidgetinstances[ entity.team ] )
    {
        var_627753e41d328a23[ instance.anchoredwidgetid ] = undefined;
    }
    
    foreach ( anchoredwidgetid in var_627753e41d328a23 )
    {
        entity.anchoredwidgetid = anchoredwidgetid;
        break;
    }
    
    if ( isdefined( entity.anchoredwidgetid ) )
    {
        leveldata.teamanchoredwidgetinstances[ entity.team ][ leveldata.teamanchoredwidgetinstances[ entity.team ].size ] = entity;
        entomnvar = leveldata.teamanchoredentomnvars[ entity.anchoredwidgetid ];
        
        foreach ( player in teams::getfriendlyplayers( entity.team ) )
        {
            player setclientomnvar( entomnvar, entity getentitynumber() );
        }
        
        return;
    }
    
    assertmsg( "<dev string:x924>" + entity.team + "<dev string:x75f>" );
}

// Namespace br_plunder
// Params 1
// Checksum 0xca52d245, Offset: 0xb806
// Size: 0x16b
function plunder_removeanchoredwidgetfromrepositoryinstance( entity )
{
    leveldata = level.plunderrepositories;
    id = entity.anchoredwidgetid;
    
    if ( !isdefined( id ) )
    {
        return;
    }
    
    entity.anchoredwidgetid = undefined;
    leveldata.teamanchoredwidgetinstances[ entity.team ] = arrayremove( leveldata.teamanchoredwidgetinstances[ entity.team ], entity );
    
    if ( leveldata.teamanchoredwidgetinstances[ entity.team ].size == 0 )
    {
        leveldata.teamanchoredwidgetinstances[ entity.team ] = undefined;
    }
    
    entomnvar = leveldata.teamanchoredentomnvars[ id ];
    infoomnvar = leveldata.teamanchoredinfoomnvars[ id ];
    
    foreach ( player in teams::getfriendlyplayers( entity.team ) )
    {
        player setclientomnvar( entomnvar, -1 );
        player setclientomnvar( infoomnvar, 0 );
    }
}

// Namespace br_plunder
// Params 2
// Checksum 0x407172c3, Offset: 0xb979
// Size: 0x1cd
function plunder_updateanchoredwidgetforplayers( entity, players )
{
    leveldata = level.plunderrepositories;
    
    if ( !isdefined( entity.anchoredwidgetid ) )
    {
        return;
    }
    
    if ( !isarray( players ) )
    {
        players = [ players ];
    }
    
    if ( players.size == 0 )
    {
        return;
    }
    
    value = 0;
    bit = 0;
    payload = 1;
    payloadsize = 1;
    value += payload;
    bit += payloadsize;
    payload = entity.plundercountdownendtime;
    payloadsize = 14;
    
    if ( isdefined( payload ) )
    {
        payload /= 250;
        payload = int( min( payload, 16383 ) );
        value += payload << bit;
    }
    
    bit += payloadsize;
    payload = entity.plundertotal;
    payloadsize = 10;
    
    if ( isdefined( payload ) )
    {
        payload /= 5;
        payload = int( min( payload, 1023 ) );
        value += payload << bit;
    }
    
    infoomnvar = leveldata.teamanchoredinfoomnvars[ entity.anchoredwidgetid ];
    
    foreach ( player in players )
    {
        if ( arraycontains( entity.playersusing, player ) )
        {
            player setclientomnvar( infoomnvar, value & -2 );
            continue;
        }
        
        player setclientomnvar( infoomnvar, entity.ispinged ? value & -2 : value );
    }
}

/#

    // Namespace br_plunder
    // Params 0
    // Checksum 0x336e403b, Offset: 0xbb4e
    // Size: 0xcb, Type: dev
    function function_2f48aabdaff9b0d9()
    {
        setdevdvarifuninitialized( @"hash_1ede0bb893291602", 0 );
        
        while ( true )
        {
            if ( getdvarint( @"hash_1ede0bb893291602", 0 ) > 0 )
            {
                foreach ( player in level.players )
                {
                    player playerplunderpickup( getdvarint( @"hash_1ede0bb893291602", 0 ), undefined, 1 );
                }
            }
            
            setdevdvar( @"hash_1ede0bb893291602", 0 );
            wait 1;
        }
    }

#/
