// scripts\mp\br\gametypes\br_gametype_highoctane.gsc  (hash_756f5322f5e449b5.gscc) (size: 5890 Bytes / 0x1702 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xcb04d707 (3406092039)
// size ...... 5890 (0x1702)
// includes .. 19  (offset: 0x15b6)
// strings ... 14  (offset: 0x164e)
// dev strs .. 0   (offset: 0x1702)
// exports ... 27  (offset: 0xa7e)
// cseg ...... 0x1b5 + 0x8c9 (0xa7e)
// imports ... 60  (offset: 0xeb6)
// animtree1 . 0   (offset: 0x1702)
// animtree2 . 0   (offset: 0x1702)
#using script_239a365a92ee4476;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br;
#using scripts\mp\br\gametypes\br_gametype_resurgence;
#using scripts\mp\br\gametypes\br_gametypes;
#using scripts\mp\br\gametypes\br_gulag;
#using scripts\mp\br\gametypes\br_pickups;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\common\utility\audio_utility;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\equipment;
#using scripts\mp\ftue\utility\ftue_progress;
#using scripts\mp\ftue\utility\ftue_tip;
#using scripts\mp\hud_message;
#using scripts\mp\loot\common_item_currency;
#using scripts\mp\loot\common_item_redeploy_token;
#using scripts\mp\loot\common_kiosk;

#namespace br_gametype_highoctane;

// Namespace br_gametype_highoctane
// Params 0, eflags: 0x5
// Checksum 0xaf7073ae, Offset: 0x1d3
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_8583453dd41873b7", #"br_ftue", undefined, &init_ftue_highoctane );
}

// Namespace br_gametype_highoctane
// Params 0
// Checksum 0xf92f91c7, Offset: 0x1fc
// Size: 0x1e
function main()
{
    level.var_dd10333ade220938 = &init;
    br::main();
    common_kiosk::function_f687bd211d712b96();
}

// Namespace br_gametype_highoctane
// Params 0
// Checksum 0x1a6000db, Offset: 0x222
// Size: 0x20d
function init()
{
    level.br_highoctane = spawnstruct();
    level.br_highoctane.disabled = 0;
    level.br_highoctane.end_circle = getdvarint( @"hash_98c61313bf26418f", 8 );
    level.br_highoctane.respawn_delay = getdvarfloat( @"hash_1a009f312c991e57", 10 );
    level.br_highoctane.grappling_hook_count = getdvarint( @"hash_b65cceb61432621f", 3 );
    utility::registersharedfunc( #"gametype", #"hash_c58d6a4317d0041e", &playerdropplunderondeath );
    utility::registersharedfunc( #"gametype", #"circletimer", &circletimer );
    utility::registersharedfunc( #"gametype", #"hash_734dfff09080996f", &postplunder );
    utility::registersharedfunc( #"gametype", #"markplayeraseliminatedonkilled", &markplayeraseliminatedonkilled );
    utility::registersharedfunc( #"gametype", #"hash_1de385892cb526fe", &playergulagautowinwait );
    utility::registersharedfunc( #"gametype", #"triggerrespawnoverlay", &triggerrespawnoverlay );
    audio_utility::snd_transient_load( "scriptables_brloot_buystation" );
    level callback::add( "currency_add", &postplunder );
    level callback::add( "currency_sub", &postplunder );
    level callback::add( "currency_set", &postplunder );
    level callback::add( #"hash_bc53f926031ea3f6", &function_d6cc5a041384d57d );
    level callback::add( #"hash_dd3cc659d7255154", &function_d6cc5a041384d57d );
    level callback::add( #"loadout_given", &function_9cd6f2e7c37b4eea );
    br_gametypes::disablefeature( #"gulag" );
    br_gametypes::disablefeature( #"hash_856067c342f8f1a5" );
    br_gametypes::disablefeature( #"hash_b371d9c9c0a6f2f3" );
    thread initcallbacks();
    level.var_557ca452c24fc971 = &spectatorrespawntimer;
}

// Namespace br_gametype_highoctane
// Params 0
// Checksum 0x63cb8fb7, Offset: 0x437
// Size: 0x17
function initcallbacks()
{
    callback::add( #"player_spawned", &onplayerspawned );
}

// Namespace br_gametype_highoctane
// Params 1
// Checksum 0x89ad47fe, Offset: 0x456
// Size: 0x13
function onplayerspawned( params )
{
    updaterespawnstatus();
}

// Namespace br_gametype_highoctane
// Params 0
// Checksum 0x5a44c142, Offset: 0x471
// Size: 0x91, Type: bool
function playercanbuyrespawn()
{
    if ( !isdefined( level.br_highoctane.cost ) )
    {
        level.br_highoctane.cost = common_kiosk::function_a1c1cc5cf66f2de9( "teamrevive" ).cost;
    }
    
    return level.br_prematchstarted && !self.br_iseliminated && !level.br_highoctane.disabled && self.plundercount >= level.br_highoctane.cost;
}

// Namespace br_gametype_highoctane
// Params 2
// Checksum 0xe865e866, Offset: 0x50b
// Size: 0x46, Type: bool
function playerdropplunderondeath( dropstruct, attacker )
{
    if ( self.respawningfromtoken )
    {
        item_currency::remove_currency( { #count:level.br_highoctane.cost } );
    }
    
    return false;
}

// Namespace br_gametype_highoctane
// Params 1
// Checksum 0xce18bd6c, Offset: 0x55a
// Size: 0x61, Type: bool
function circletimer( circleindex )
{
    endcircle = level.br_highoctane.end_circle;
    
    if ( !level.br_highoctane.disabled && circleindex >= endcircle )
    {
        level.br_highoctane.disabled = 1;
    }
    
    return false;
}

// Namespace br_gametype_highoctane
// Params 1
// Checksum 0xf3237d57, Offset: 0x5c4
// Size: 0x44
function postplunder( data )
{
    skipsplash = 0;
    
    if ( isdefined( data ) )
    {
        skipsplash = data.skipsplash || self.health <= 0;
    }
    
    updaterespawnstatus( skipsplash );
}

// Namespace br_gametype_highoctane
// Params 1
// Checksum 0xb32b6370, Offset: 0x610
// Size: 0x5f
function updaterespawnstatus( skipsplash )
{
    if ( playercanbuyrespawn() )
    {
        if ( !br_public::hasrespawntoken() )
        {
            br_pickups::addrespawntoken( 1 );
            
            if ( !skipsplash )
            {
                thread hud_message::showsplash( "br_highoctane_respawn_token_granted" );
            }
        }
        
        return;
    }
    
    if ( br_public::hasrespawntoken() )
    {
        item_redeploy_token::function_16ab0a48337237ef();
        
        if ( !skipsplash )
        {
            thread hud_message::showsplash( "br_highoctane_respawn_token_lost" );
        }
    }
}

// Namespace br_gametype_highoctane
// Params 0
// Checksum 0x1e3b88c3, Offset: 0x677
// Size: 0x34
function function_4b384aa96f4ef0c2()
{
    self playlocalsound( "uin_cer_mp_splash_high_octane" );
    wait 5;
    
    if ( br_public::hasrespawntoken() )
    {
        hud_message::showsplash( "br_highoctane_respawn_token_granted" );
        return;
    }
    
    hud_message::showsplash( "br_highoctane_respawn_token_lost" );
}

// Namespace br_gametype_highoctane
// Params 1
// Checksum 0xef9eeb9e, Offset: 0x6b3
// Size: 0x6e
function function_78c98827d248f06b( timer )
{
    br_gametype_resurgence::function_12b97810099f2b4d();
    br_gametype_resurgence::function_6f6222b4837d3c31( timer );
    br_gametype_resurgence::function_dd217918caad1c89( undefined );
    
    while ( timer > 0 )
    {
        if ( isalive( self ) )
        {
            timer = 0;
        }
        else
        {
            br_gametype_resurgence::function_6f6222b4837d3c31( timer );
        }
        
        wait 1;
        timer--;
    }
    
    br_gametype_resurgence::function_e9f3e6b5a7d226b0();
    br_gametype_resurgence::function_6f6222b4837d3c31( 0 );
    br_gametype_resurgence::function_dd217918caad1c89( undefined );
    self setclientomnvar( "ui_br_highoctane_respawn_state", 0 );
}

// Namespace br_gametype_highoctane
// Params 1
// Checksum 0x49d4866b, Offset: 0x729
// Size: 0x3a
function showrespawntimer( timer )
{
    waittillframeend();
    lower_message::setlowermessageomnvar( "waiting_to_spawn", int( gettime() + timer * 1000 ) );
    br_gulag::setplayeringulagjailextrainfo( 1 );
    hiderespawntimer( timer );
}

// Namespace br_gametype_highoctane
// Params 1
// Checksum 0x233a46c7, Offset: 0x76b
// Size: 0x41
function hiderespawntimer( waittime )
{
    self endon( #"disconnect" );
    
    if ( isdefined( waittime ) )
    {
        wait waittime;
    }
    
    self notify( #"highoctane_hide_timer" );
    br_gulag::setplayeringulagjailextrainfo( 0 );
    lower_message::setlowermessageomnvar( "clear_lower_msg" );
}

// Namespace br_gametype_highoctane
// Params 0
// Checksum 0x1c80287e, Offset: 0x7b4
// Size: 0x22
function getsetplundercountdatanosplash()
{
    data = spawnstruct();
    data.skipsplash = 1;
    return data;
}

// Namespace br_gametype_highoctane
// Params 0
// Checksum 0xde786e4f, Offset: 0x7df
// Size: 0x3, Type: bool
function markplayeraseliminatedonkilled()
{
    return false;
}

// Namespace br_gametype_highoctane
// Params 1
// Checksum 0x3e09b2a9, Offset: 0x7eb
// Size: 0x77
function spectatorrespawntimer( victim )
{
    self notify( #"spectatorrespawntimer" );
    self endon( #"spectatorrespawntimer" );
    self endon( #"disconnect" );
    
    if ( level.br_highoctane.respawn_delay )
    {
        respawndelay = level.br_highoctane.respawn_delay;
        thread function_672a9eb1f3d7bea5( victim );
        showrespawntimer( respawndelay );
    }
}

// Namespace br_gametype_highoctane
// Params 1
// Checksum 0x6d7c866, Offset: 0x86a
// Size: 0x52
function function_672a9eb1f3d7bea5( victim )
{
    self endon( #"spectatorrespawntimer" );
    self endon( #"disconnect" );
    victim endon( #"spawned_player" );
    self endon( #"highoctane_hide_timer" );
    victim waittill( #"disconnect" );
    thread hiderespawntimer();
}

// Namespace br_gametype_highoctane
// Params 2
// Checksum 0xf6a1e32a, Offset: 0x8c4
// Size: 0x7d, Type: bool
function playergulagautowinwait( sponsor, tokenused )
{
    if ( !isdefined( sponsor ) )
    {
        if ( level.br_highoctane.respawn_delay )
        {
            respawndelay = level.br_highoctane.respawn_delay;
            thread showrespawntimer( respawndelay );
            self.respawndelay = respawndelay;
            wait respawndelay;
            self.respawndelay = 0;
            thread function_4b384aa96f4ef0c2();
            return true;
        }
    }
    
    return false;
}

// Namespace br_gametype_highoctane
// Params 1
// Checksum 0x1082bbe8, Offset: 0x94a
// Size: 0xe, Type: bool
function triggerrespawnoverlay( overlaytype )
{
    return true;
}

// Namespace br_gametype_highoctane
// Params 1
// Checksum 0xac5a1430, Offset: 0x961
// Size: 0x3f
function function_d6cc5a041384d57d( params )
{
    if ( level.br_highoctane.grappling_hook_count > 0 )
    {
        params.struct.loadoutequipmentsecondary = "equip_grappling_hook";
    }
}

// Namespace br_gametype_highoctane
// Params 1
// Checksum 0x2b07f560, Offset: 0x9a8
// Size: 0x43
function function_9cd6f2e7c37b4eea( params )
{
    if ( level.br_highoctane.grappling_hook_count > 0 )
    {
        equipment_mp::setequipmentammo( "equip_grappling_hook", level.br_highoctane.grappling_hook_count );
    }
}

// Namespace br_gametype_highoctane
// Params 0, eflags: 0x4
// Checksum 0x5c29b640, Offset: 0x9f3
// Size: 0x27
function private init_ftue_highoctane()
{
    if ( !ftue_progress::ftue_enabled() || !level.br_highoctane )
    {
        return;
    }
    
    namespace_44e8cefed76aa88e::function_feeeaf4be5bd0641( &function_5a7a3a02a258055f );
}

// Namespace br_gametype_highoctane
// Params 0, eflags: 0x4
// Checksum 0xefad5730, Offset: 0xa22
// Size: 0x28
function private function_5a7a3a02a258055f()
{
    ftue_tip::function_d454ba9425f5164c( 59, "highoctaneBuystation", &function_e10b709cfe9ed80 );
    ftue_tip::function_d454ba9425f5164c( 60, "highoctaneAutoBuyback", &function_11b263c092b53a4c );
}

// Namespace br_gametype_highoctane
// Params 1, eflags: 0x4
// Checksum 0x8c8b283c, Offset: 0xa52
// Size: 0x11
function private function_e10b709cfe9ed80( params )
{
    return self isonground();
}

// Namespace br_gametype_highoctane
// Params 1, eflags: 0x4
// Checksum 0x4c73edf, Offset: 0xa6c
// Size: 0x11
function private function_11b263c092b53a4c( params )
{
    return self isonground();
}

