// scripts\mp\br\gametypes\resurgence\rapid_surge.gsc  (hash_3fa28fa4feb6c570.gscc) (size: 5894 Bytes / 0x1706 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x300750f3 (805785843)
// size ...... 5894 (0x1706)
// includes .. 14  (offset: 0x156a)
// strings ... 20  (offset: 0x15da)
// dev strs .. 0   (offset: 0x1706)
// exports ... 18  (offset: 0xcaa)
// cseg ...... 0x21a + 0xa90 (0xcaa)
// imports ... 50  (offset: 0xf7a)
// animtree1 . 0   (offset: 0x1706)
// animtree2 . 0   (offset: 0x1706)
#using scripts\common\callbacks;
#using scripts\common\omnvar_utility;
#using scripts\common\utility;
#using scripts\mp\br\br_activity_util;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_gametype_resurgence;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\teams;
#using scripts\mp\currency;
#using scripts\mp\hud_util;
#using scripts\mp\loot\common_item;
#using scripts\mp\loot\common_item_currency;
#using scripts\mp\loot\common_kiosk;

#namespace rapid_surge;

// Namespace rapid_surge
// Params 0, eflags: 0x1
// Checksum 0x48e303c0, Offset: 0x238
// Size: 0x15
function autoexec main()
{
    utility::flag_wait( "br_init" );
    init();
}

// Namespace rapid_surge
// Params 0
// Checksum 0xe56466a5, Offset: 0x255
// Size: 0x197
function init()
{
    level.brgametype.var_7d82cf003e8136df = level.gametypebundle.var_2613652964fd7563;
    
    if ( !level.brgametype.var_7d82cf003e8136df || getdvarint( @"scr_br_resurgence_rapid_surge_killswitch", 0 ) == 1 )
    {
        return;
    }
    
    level.brgametype.var_f2f0c12e7018ba68 = getdvarfloat( @"scr_br_resurgence_rapid_surge_reduction", level.gametypebundle.var_f2f0c12e7018ba68 );
    level.brgametype.var_c0312dba53dde18d = getdvarfloat( @"hash_590d41d592f1a3ce", level.gametypebundle.var_c0312dba53dde18d );
    level callback::add( "scripted_item_used", &function_aed4f9542b232b09 );
    level callback::add( "scripted_item_can_use", &can_use_rapid_surge );
    level callback::add( "scripted_item_can_autouse", &function_6b26d29769ec991 );
    level callback::add( #"hash_a20e721cf931b9d0", &function_3fbb5b47b6bb11d );
    level callback::add( #"on_squad_wiped", &function_166b73f0a1d17909 );
    level callback::add( #"hash_eff572fcb538519d", &function_b8d2f1a57e6bb277 );
    utility::registersharedfunc( #"rapid_surge", #"get_rapid_surge_respawn_delay", &get_rapid_surge_respawn_delay );
    utility::registersharedfunc( #"gametype", #"resurgencedisable", &function_1412664f5a522f48 );
    utility::registersharedfunc( #"gametype", #"hash_f858d01d5bc62840", &function_9c154acc294d5343 );
    init_dialogs();
}

// Namespace rapid_surge
// Params 0
// Checksum 0x41bb74dd, Offset: 0x3f4
// Size: 0x28
function init_dialogs()
{
    game[ "dialog" ][ "rare_wzan_orrt" ] = "rare_wzan_orrt";
    game[ "dialog" ][ "rare_wzan_mrrt" ] = "rare_wzan_mrrt";
}

// Namespace rapid_surge
// Params 1
// Checksum 0x17d62dc9, Offset: 0x424
// Size: 0x1d
function can_use_rapid_surge( params )
{
    if ( !isplayer( self ) )
    {
        return 0;
    }
    
    return function_62b2f89e61cfbd1a();
}

// Namespace rapid_surge
// Params 1
// Checksum 0x5859702b, Offset: 0x44a
// Size: 0x14
function function_6b26d29769ec991( params )
{
    return can_use_rapid_surge( params );
}

// Namespace rapid_surge
// Params 0
// Checksum 0xb8c7a49f, Offset: 0x467
// Size: 0x6d, Type: bool
function function_62b2f89e61cfbd1a()
{
    if ( get_squad_rapid_surge_count( self.team ) == 0 && level.brgametype.var_c0312dba53dde18d != 0 )
    {
        return true;
    }
    
    if ( function_21bc75c28d32e0ac() < level.brgametype.var_c0312dba53dde18d )
    {
        return true;
    }
    
    if ( !level.brgametype.respawnenable )
    {
        return true;
    }
    
    return false;
}

// Namespace rapid_surge
// Params 1, eflags: 0x4
// Checksum 0x63a5c6db, Offset: 0x4dd
// Size: 0x23b
function private function_aed4f9542b232b09( params )
{
    islooted = params.bundle.ref == "wz_consumable_rapid_surge";
    var_be30764230341fa1 = params.var_7a6920acc86cb305;
    
    if ( !islooted && !var_be30764230341fa1 || !isdefined( self ) )
    {
        return;
    }
    
    if ( !level.brgametype.respawnenable )
    {
        function_9ebc6e882d3d7045( 1, 200 );
        return;
    }
    
    playerteam = self.team;
    var_ba213bb303aaa05d = get_squad_rapid_surge_count( playerteam ) + 1;
    teams::setteamdata( playerteam, "rapid_surge_count", var_ba213bb303aaa05d );
    reduction = function_21bc75c28d32e0ac();
    reductionpercent = int( reduction * 100 );
    tokenfull = !function_62b2f89e61cfbd1a();
    hud_util::showsplashtoteam( playerteam, tokenfull ? "br_resurgence_rapid_surge_pickup_max" : "br_resurgence_rapid_surge_pickup", reductionpercent );
    var_cffb597d14f196c1 = !tokenfull ? "rare_wzan_orrt" : "rare_wzan_mrrt";
    br_public::brleaderdialogplayer( var_cffb597d14f196c1, self, 1, 0, 0, undefined, "dx_br_brrr_" );
    teamplayers = teams::getteamdata( playerteam, "players" );
    var_40360acc07f5fa82 = function_62b2f89e61cfbd1a();
    var_e7194db7435910db = int( br_gametype_resurgence::getrespawndelay( 1 ) * level.brgametype.var_f2f0c12e7018ba68 );
    br_gametype_resurgence::function_2744f34fc84b001e( self, var_e7194db7435910db, #"rapid_surge_gained" );
    
    foreach ( player in teamplayers )
    {
        player omnvar_utility::function_85d5f88af471ac4b( o"ui_rapid_surge_token", 0, 3, var_ba213bb303aaa05d );
        
        if ( !var_40360acc07f5fa82 )
        {
            player omnvar_utility::function_85d5f88af471ac4b( o"ui_rapid_surge_token", 3, 1, 1 );
        }
    }
    
    return 1;
}

// Namespace rapid_surge
// Params 1
// Checksum 0x414c96d9, Offset: 0x721
// Size: 0x54
function get_squad_rapid_surge_count( playerteam )
{
    if ( !level.brgametype.var_7d82cf003e8136df )
    {
        return 0;
    }
    
    if ( !teams::function_b00ab7e503f33379( playerteam, "rapid_surge_count" ) )
    {
        teams::setteamdata( playerteam, "rapid_surge_count", 0 );
        return 0;
    }
    
    return teams::getteamdata( playerteam, "rapid_surge_count" );
}

// Namespace rapid_surge
// Params 0
// Checksum 0x14049fa6, Offset: 0x77e
// Size: 0x4a
function function_21bc75c28d32e0ac()
{
    var_ed98ccd07bbfc2d9 = get_squad_rapid_surge_count( self.team );
    return min( var_ed98ccd07bbfc2d9 * level.brgametype.var_f2f0c12e7018ba68, level.brgametype.var_c0312dba53dde18d );
}

// Namespace rapid_surge
// Params 1
// Checksum 0x7f6058bd, Offset: 0x7d1
// Size: 0x5a
function get_rapid_surge_respawn_delay( respawndelay )
{
    if ( !level.brgametype.var_7d82cf003e8136df )
    {
        return 1;
    }
    
    reduction = function_21bc75c28d32e0ac();
    var_53192402058b828f = int( ceil( respawndelay * ( 1 - reduction ) ) );
    return var_53192402058b828f;
}

// Namespace rapid_surge
// Params 1
// Checksum 0x8aaee4aa, Offset: 0x834
// Size: 0xe7
function function_166b73f0a1d17909( params )
{
    if ( getdvarint( @"hash_eceb1a6479bb3cea", 0 ) == 0 )
    {
        return;
    }
    
    victim = params.victim;
    
    if ( get_squad_rapid_surge_count( victim.team ) > 0 )
    {
        spawnoptions = common_item::items_initspawnoptions_spawnfromposition( victim.origin, victim.angles );
        item = level common_item::items_spawnitemfromscriptable( "brloot_rapid_surge", 1, spawnoptions );
        lootid = common_item::items_getlootidfromref( "wz_consumable_rapid_surge" );
        typestring = common_item::function_9deb822f286163b1( lootid );
        victim common_item::items_analytics( lootid, undefined, undefined, undefined, undefined, typestring, undefined, undefined, item.type, item.origin, item.count );
    }
}

// Namespace rapid_surge
// Params 0
// Checksum 0x6b5e734, Offset: 0x923
// Size: 0x125
function function_1412664f5a522f48()
{
    foreach ( player in level.players )
    {
        player function_295b289f2e6b2e23();
        player setclientomnvar( o"ui_rapid_surge_token", 0 );
    }
    
    foreach ( team, data in level.teamdata )
    {
        if ( teams::function_b00ab7e503f33379( team, "rapid_surge_count" ) )
        {
            teams::setteamdata( team, "rapid_surge_count", 0 );
        }
    }
    
    common_kiosk::function_8e75a0bbf4978d44( "rapid_surge" );
}

// Namespace rapid_surge
// Params 0, eflags: 0x4
// Checksum 0xf9c145e0, Offset: 0xa50
// Size: 0x2f
function private function_295b289f2e6b2e23()
{
    var_ed98ccd07bbfc2d9 = get_squad_rapid_surge_count( self.team );
    
    if ( var_ed98ccd07bbfc2d9 > 0 )
    {
        function_9ebc6e882d3d7045( var_ed98ccd07bbfc2d9, 50 );
    }
}

// Namespace rapid_surge
// Params 2, eflags: 0x4
// Checksum 0xc011fad5, Offset: 0xa87
// Size: 0x63
function private function_9ebc6e882d3d7045( var_400fd5601ee45aca, tokenvalue )
{
    if ( br::isbrteameliminated( self.team ) )
    {
        return;
    }
    
    var_e3d042d225e57659 = var_400fd5601ee45aca * tokenvalue;
    currency::add_currency_amount( "cash", var_e3d042d225e57659, "rapid_surge_token_conversion" );
    lower_message::setlowermessageomnvar( "br_rapid_surge_conversion", undefined, 3 );
    item_currency::function_b3dc7865b2c24da2( var_e3d042d225e57659 );
}

// Namespace rapid_surge
// Params 1
// Checksum 0x5e8fe4c, Offset: 0xaf2
// Size: 0x4c, Type: bool
function function_3fbb5b47b6bb11d( params )
{
    return level.brgametype.var_7d82cf003e8136df && !level.brgametype.respawnenable && params.itemkey == "rapid_surge";
}

// Namespace rapid_surge
// Params 9
// Checksum 0xa5878b0e, Offset: 0xb47
// Size: 0xa1
function function_9c154acc294d5343( type, value, team, rewardorigin, rewardangles, rewardscriptable, players, squadindex, var_c23fb958032d4041 )
{
    if ( getdvarint( @"hash_403d4560793c6162", 0 ) == 1 && value == "brloot_rapid_surge" )
    {
        if ( var_c23fb958032d4041 function_62b2f89e61cfbd1a() )
        {
            rewardparameters = { #var_7a6920acc86cb305:1 };
            var_c23fb958032d4041 function_aed4f9542b232b09( rewardparameters );
        }
    }
}

// Namespace rapid_surge
// Params 1
// Checksum 0x5c9eaadc, Offset: 0xbf0
// Size: 0xb9
function function_b8d2f1a57e6bb277( params )
{
    if ( getdvarint( @"hash_403d4560793c6162", 0 ) == 1 )
    {
        var_97e554b96f8ee2c6 = params.rewards[ "callback" ];
        
        if ( !isdefined( var_97e554b96f8ee2c6 ) )
        {
            return;
        }
        
        var_ba4a62a813774038 = var_97e554b96f8ee2c6 == "brloot_rapid_surge";
        var_40360acc07f5fa82 = params.player function_62b2f89e61cfbd1a();
        
        if ( var_ba4a62a813774038 && var_40360acc07f5fa82 )
        {
            var_f66479ce4f72eae6 = teams::getteamdata( params.player.team, "players" );
            br_activity_util::displaysplashtoplayers( var_f66479ce4f72eae6, "br_vip_quest_you_killed_the_vip_rapid_surge" );
            return 1;
        }
    }
    
    return 0;
}

