// scripts\mp\common\equipment\advanced_supply_drop.gsc  (hash_2f9865564c75a1d7.gscc) (size: 2545 Bytes / 0x9f1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x870cdd54 (2265767252)
// size ...... 2545 (0x9f1)
// includes .. 9   (offset: 0x935)
// strings ... 8   (offset: 0x97d)
// dev strs .. 0   (offset: 0x9f1)
// exports ... 8   (offset: 0x4f9)
// cseg ...... 0xfc + 0x3fd (0x4f9)
// imports ... 26  (offset: 0x639)
// animtree1 . 0   (offset: 0x9f1)
// animtree2 . 0   (offset: 0x9f1)
#using scripts\common\script;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\airdrop_loadout_crate;
#using scripts\mp\br\gametypes\br_gametype_truckwar;
#using scripts\mp\outofbounds;
#using scripts\mp\supers;
#using scripts\mp\weapons;

#namespace advanced_supply_drop;

// Namespace advanced_supply_drop
// Params 0, eflags: 0x5
// Checksum 0xd45be312, Offset: 0x11a
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"advanced_supply_drop", undefined, undefined, &post_main );
}

// Namespace advanced_supply_drop
// Params 0
// Checksum 0xa05f4cda, Offset: 0x13b
// Size: 0x17
function post_main()
{
    weapons::registerusedcallback( #"advanced_supply_drop_marker", &advanced_supply_drop_marker_used );
}

// Namespace advanced_supply_drop
// Params 1, eflags: 0x4
// Checksum 0x2a2c14f7, Offset: 0x15a
// Size: 0x102
function private advanced_supply_drop_marker_used( grenade )
{
    player = self;
    player endon( #"disconnect" );
    grenade endon( #"explode_end" );
    var_b2f744d16e34e9f0 = player supers_mp::getcurrentsuperref();
    player supers_mp::superusefinished( undefined, undefined, undefined, 1 );
    grenade thread script::notifyafterframeend( "death", "explode_end" );
    player thread advanced_supply_drop_refund_on_death( grenade );
    grenade waittill( #"explode", position );
    player notify( #"advanced_supply_drop_finished" );
    thread advanced_supply_drop_marker_sfx( position );
    
    if ( outofbounds::ispointinoutofbounds( position ) )
    {
        if ( isdefined( grenade ) )
        {
            grenade delete();
        }
        
        if ( isdefined( player.super ) && player supers_mp::getcurrentsuperref() == var_b2f744d16e34e9f0 )
        {
            player supers_mp::setsuperexpended( 0 );
            player supers_mp::refundsuper();
            player supers_mp::givesuper( var_b2f744d16e34e9f0, 1, 1 );
        }
        
        return;
    }
    
    thread airdrop_loadout_crate::spawnloadoutcrate( player, position, 1 );
}

// Namespace advanced_supply_drop
// Params 1
// Checksum 0xc47c2609, Offset: 0x264
// Size: 0x152
function function_59bfaa376651f224( grenade )
{
    player = self;
    player endon( #"disconnect" );
    grenade endon( #"explode_end" );
    grenade thread script::notifyafterframeend( "death", "explode_end" );
    player thread advanced_supply_drop_refund_on_death( grenade );
    
    if ( isdefined( level.var_8828b182d5497d81 ) )
    {
        level thread function_c414630139a61b21( player, grenade );
    }
    
    grenade waittill( #"explode", position );
    player notify( #"advanced_supply_drop_finished" );
    thread advanced_supply_drop_marker_sfx( position );
    
    if ( outofbounds::ispointinoutofbounds( position ) )
    {
        if ( isdefined( grenade ) )
        {
            grenade delete();
        }
        
        if ( isdefined( player.super ) )
        {
            player supers_mp::superusefinished( 1 );
        }
        
        return;
    }
    
    tracecontents = trace::create_default_contents( 1 );
    groundorigin = utility::drop_to_ground( position, 10000, -20000, undefined, tracecontents );
    vehicle = undefined;
    
    if ( isdefined( vehicle ) )
    {
        br_gametype_truckwar::function_172dbee6aed28df8( vehicle, player.team, 1 );
        level thread br_gametype_truckwar::truck_airdrop( vehicle, groundorigin, vehicle.angles, 1 );
    }
    
    if ( isdefined( player.super ) )
    {
        player supers_mp::superusefinished( undefined, undefined, undefined, 1 );
    }
}

// Namespace advanced_supply_drop
// Params 2
// Checksum 0x99a2aa1e, Offset: 0x3be
// Size: 0x6a
function function_c414630139a61b21( player, grenade )
{
    player_team = player.team;
    level.var_8828b182d5497d81[ player_team ] = 1;
    utility::waittill_any_ents( player, "disconnect", grenade, "explode_end", grenade, "explode", grenade, "death" );
    level.var_8828b182d5497d81[ player_team ] = undefined;
}

// Namespace advanced_supply_drop
// Params 1
// Checksum 0xb135379c, Offset: 0x430
// Size: 0x5c
function advanced_supply_drop_refund_on_death( grenade )
{
    player = self;
    player endon( #"disconnect" );
    player endon( #"advanced_supply_drop_finished" );
    grenade waittill( #"death" );
    waitframe();
    
    if ( isdefined( player.super ) )
    {
        player supers_mp::superusefinished( 1 );
    }
}

// Namespace advanced_supply_drop
// Params 1
// Checksum 0xdc3c6a21, Offset: 0x494
// Size: 0x65
function advanced_supply_drop_marker_sfx( position )
{
    smoke_sfx = spawn( "script_origin", position );
    smoke_sfx.targetname = "advanced_supply_drop_marker_sfx";
    smoke_sfx playloopsound( "smoke_carepackage_smoke_lp" );
    wait 21;
    smoke_sfx playsound( "smoke_canister_tail_dissipate" );
    smoke_sfx stoploopsound( "smoke_carepackage_smoke_lp" );
    wait 5;
    smoke_sfx delete();
}

