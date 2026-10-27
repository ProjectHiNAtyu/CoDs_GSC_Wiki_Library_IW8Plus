// scripts\mp\common\equipment\reinforcement_flare.gsc  (hash_602b37a842e7df15.gscc) (size: 7386 Bytes / 0x1cda / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x29020459 (687998041)
// size ...... 7386 (0x1cda)
// includes .. 18  (offset: 0x1ade)
// strings ... 18  (offset: 0x1b6e)
// dev strs .. 6   (offset: 0x1c7a)
// exports ... 23  (offset: 0xebe)
// cseg ...... 0x210 + 0xcae (0xebe)
// imports ... 74  (offset: 0x1256)
// animtree1 . 0   (offset: 0x1cc6)
// animtree2 . 1   (offset: 0x1cc6)
#using scripts\common\ae_utility;
#using scripts\common\devgui;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_analytics;
#using scripts\mp\br\gametypes\br_contract_manager;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_spawnrespawn;
#using scripts\mp\challenges;
#using scripts\mp\common\utility\lower_message;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\rejoin_utility;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\currency;
#using scripts\mp\hud_message;
#using scripts\mp\supers;

#namespace reinforcement_flare;

// Namespace reinforcement_flare
// Params 0, eflags: 0x1
// Checksum 0xa3c7f67, Offset: 0x22e
// Size: 0xa
function autoexec main()
{
    level thread init_when_ready();
}

// Namespace reinforcement_flare
// Params 0
// Checksum 0x97274a31, Offset: 0x240
// Size: 0x22
function init_when_ready()
{
    level endon( #"game_ended" );
    level waittill( #"init_supers" );
    init();
}

// Namespace reinforcement_flare
// Params 0
// Checksum 0x44f4430b, Offset: 0x26a
// Size: 0x1ab
function init()
{
    supers_mp::function_48aaa60b2ce7b8a1( "super_reinforcement_flare", undefined, &reinforcementflare_unset, &function_cc99ae5a45824246, undefined, undefined, &reinforcementflare_give );
    utility::registersharedfunc( #"reinforcement_flare", #"grenadeused", &function_de9d1416a6338c3d );
    level.var_34c93817c87a1f5c = spawnstruct();
    level.var_34c93817c87a1f5c.type = getdvarint( @"scr_reinforcement_flare_type", 3 );
    level.var_34c93817c87a1f5c.delay = getdvarint( @"scr_reinforcement_flare_delay", 1 );
    level.var_34c93817c87a1f5c.raycastheight = getdvarint( @"hash_b6d7a4020f569c04", 5000 );
    level.var_34c93817c87a1f5c.var_8a72fcb4e905bcd = getdvarfloat( @"hash_578ea151ae11d179", 1 );
    level.var_34c93817c87a1f5c.var_34e871b84e55f612 = getdvarint( @"hash_3c8c43e7f91baee4", 0 );
    level.var_34c93817c87a1f5c.enablereminder = getdvarint( @"hash_58392bda66da5795", 1 );
    level.var_34c93817c87a1f5c.var_72740bd502e716f8 = 0;
    level.var_34c93817c87a1f5c.superid = supers_mp::getsuperid( "super_reinforcement_flare" );
    thread utility::callsharedfunc( #"analytics", #"hash_eb9d0dae8f38111f", { #customhit:1, #customend:1, #customstart:1, #equipref:"equip_reinforcement_flare" } );
    init_anim();
    init_dev_gui();
}

#using_animtree( "script_model" );

// Namespace reinforcement_flare
// Params 0
// Checksum 0xbc22116e, Offset: 0x41d
// Size: 0x59
function init_anim()
{
    notes = getnotetracktimes( %misc_vm_flare_gun_fire, "reinforcement_flare_fired" );
    total = getanimlength( %misc_vm_flare_gun_fire );
    
    if ( notes.size > 0 )
    {
        level.var_34c93817c87a1f5c.var_72740bd502e716f8 = total * notes[ 0 ];
    }
}

// Namespace reinforcement_flare
// Params 0
// Checksum 0x25b4814, Offset: 0x47e
// Size: 0x4d
function init_dev_gui()
{
    /#
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_command( "<dev string:x3b>", "<dev string:x4f>" );
        devgui::function_77df7fe7dd273e10();
        devgui::function_9082edeb5db93280( "<dev string:x84>" );
        devgui::add_devgui_command( "<dev string:x3b>", "<dev string:xa9>" );
        devgui::function_77df7fe7dd273e10();
    #/
}

// Namespace reinforcement_flare
// Params 0
// Checksum 0x483023e0, Offset: 0x4d3
// Size: 0xb
function reinforcementflare_give()
{
    function_e6a1bdf56d5115bc( 1 );
}

// Namespace reinforcement_flare
// Params 0
// Checksum 0x7c08d532, Offset: 0x4e6
// Size: 0xa
function reinforcementflare_unset()
{
    function_e6a1bdf56d5115bc( 0 );
}

// Namespace reinforcement_flare
// Params 1
// Checksum 0xb3d7f391, Offset: 0x4f8
// Size: 0x55
function function_e6a1bdf56d5115bc( on )
{
    if ( !level.var_34c93817c87a1f5c.enablereminder )
    {
        return;
    }
    
    superid = on ? level.var_34c93817c87a1f5c.superid : 0;
    supers_mp::function_2ea603a86a682ab0( superid );
}

// Namespace reinforcement_flare
// Params 0
// Checksum 0x5b933dfb, Offset: 0x555
// Size: 0xc8
function function_cc99ae5a45824246()
{
    /#
        if ( getdvarint( @"hash_138efa1711913cad", 0 ) )
        {
            thread function_d2d73671bfebf899();
            wait level.var_34c93817c87a1f5c.var_72740bd502e716f8;
            thread function_27d8434cb476d5cf();
            wait level.var_34c93817c87a1f5c.delay;
            thread hud_message::showsplash( "<dev string:xeb>" );
            points::doscoreevent( #"reinforcement_flare_field_upgrade_used" );
            return 0;
        }
    #/
    
    respawnlist = function_977f2b0ac67b6c64();
    
    if ( !function_338a3347590650df( respawnlist, 1 ) )
    {
        return 0;
    }
    
    self.super.isactive = 1;
    self disableoffhandspecialweapons();
    thread reinforcementflare_use();
    self waittill( #"hash_e1c9d678d0365974", var_b1fc6f15359e32a9 );
    return var_b1fc6f15359e32a9;
}

// Namespace reinforcement_flare
// Params 0
// Checksum 0xc9a3dcd0, Offset: 0x626
// Size: 0x180
function reinforcementflare_use()
{
    thread function_d2d73671bfebf899();
    wait level.var_34c93817c87a1f5c.var_72740bd502e716f8;
    self enableoffhandspecialweapons();
    respawnlist = function_977f2b0ac67b6c64();
    
    if ( !function_338a3347590650df( respawnlist, level.var_34c93817c87a1f5c.var_34e871b84e55f612 ) )
    {
        self notify( #"hash_e1c9d678d0365974", 0 );
        return;
    }
    
    self notify( #"hash_e1c9d678d0365974", 1 );
    thread utility::callsharedfunc( #"analytics", #"hash_22a37c3ed1cf5035", { #owner:self, #equipref:"equip_reinforcement_flare", #ent:self.offhandweapon } );
    function_e6a1bdf56d5115bc( 0 );
    thread function_27d8434cb476d5cf();
    reinforcementflare_respawn( respawnlist );
    wait level.var_34c93817c87a1f5c.delay;
    thread hud_message::showsplash( "br_squadmate_revived" );
    points::doscoreevent( #"reinforcement_flare_field_upgrade_used" );
    br_analytics::function_dbab3fcf4e472e0b( 1, 0 );
    challenges::function_a0936b0e5b4550f3( "super_reinforcement_flare", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"use" ) );
    thread utility::callsharedfunc( #"analytics", #"hash_e348d92f8fdade0c", { #position:self.origin, #owner:self, #equipref:"equip_reinforcement_flare", #ent:self.offhandweapon } );
}

// Namespace reinforcement_flare
// Params 2
// Checksum 0x4822ac9b, Offset: 0x7ae
// Size: 0x6d
function function_338a3347590650df( respawnlist, var_bc8b06acae02fb42 )
{
    if ( !player::isaliveandnotinlaststand( self ) )
    {
        return 0;
    }
    
    if ( var_bc8b06acae02fb42 )
    {
        if ( self isswimunderwater() )
        {
            return reinforcementflare_fail( "reinforcement_flare_underwater", 1 );
        }
        
        if ( function_4a45af3013cc189a() )
        {
            return reinforcementflare_fail( "reinforcement_flare_not_enough_space", 2 );
        }
    }
    
    if ( respawnlist.size < 1 )
    {
        return reinforcementflare_fail( "reinforcement_flare_nobody_to_respawn", 3 );
    }
    
    return 1;
}

// Namespace reinforcement_flare
// Params 0
// Checksum 0x8d879535, Offset: 0x824
// Size: 0x75
function function_d2d73671bfebf899()
{
    weaponname = level.equipment.table[ "equip_reinforcement_flare" ].bundle.useweapon;
    weaponname = weaponname && weaponname != %"super_default_mp" ? weaponname : "reinforcement_flare_mp_br";
    weapon = makeweapon( weaponname );
    weapon_utility::giveandfireoffhandreliable( weapon );
}

// Namespace reinforcement_flare
// Params 0
// Checksum 0x8cabbf1d, Offset: 0x8a1
// Size: 0x119, Type: bool
function function_4a45af3013cc189a()
{
    capsule = self getcollision( self getstance() );
    playerradius = capsule.capsule_radius * 0.5;
    playerheight = capsule.capsule_halfheight + capsule.capsule_midpoint_height + capsule.capsule_radius;
    startpos = self getorigin() + ( 0, 0, playerheight );
    endpos = startpos + ( 0, 0, level.var_34c93817c87a1f5c.raycastheight );
    raycastcontent = trace::create_contents( 0, 0, 1, 1, 0, 1, 1, 1, 0, 1, 0 );
    raycastresult = trace::ray_trace_passed( startpos, endpos, self, raycastcontent );
    
    /#
        if ( getdvarint( @"scr_reinforcement_flare_debug", 0 ) )
        {
            line( startpos, endpos, raycastresult ? ( 0, 1, 0 ) : ( 1, 0, 0 ), 1, 0, 1800 );
        }
    #/
    
    return !raycastresult;
}

// Namespace reinforcement_flare
// Params 2
// Checksum 0xbe0deeb1, Offset: 0x9c3
// Size: 0x37, Type: bool
function reinforcementflare_fail( hint, reason )
{
    self playlocalsound( "fly_pickup_deny" );
    lower_message::setlowermessageomnvar( hint, undefined, 5 );
    br_analytics::function_dbab3fcf4e472e0b( 0, reason );
    return false;
}

// Namespace reinforcement_flare
// Params 0
// Checksum 0x100bb27a, Offset: 0xa03
// Size: 0xba
function function_977f2b0ac67b6c64()
{
    list = [];
    squad = teams::getteamdata( self.team, "players" );
    
    foreach ( squadmate in squad )
    {
        if ( !isdefined( squadmate ) || squadmate == self )
        {
            continue;
        }
        
        if ( squadmate reinforcementflare_iseligibleforteamrevive() )
        {
            list[ list.size ] = squadmate;
        }
    }
    
    return list;
}

// Namespace reinforcement_flare
// Params 0
// Checksum 0xc8823f1b, Offset: 0xac6
// Size: 0x12, Type: bool
function reinforcementflare_iseligibleforteamrevive()
{
    return br_public::iseligibleforteamrevive() || br_public::isplayerwaitingresurgencerespawn();
}

// Namespace reinforcement_flare
// Params 0
// Checksum 0x7b903024, Offset: 0xae1
// Size: 0x7b
function function_27d8434cb476d5cf()
{
    location = self.origin;
    
    if ( self tagexists( "tag_weapon_right" ) )
    {
        location = self gettagorigin( "tag_weapon_right" );
    }
    
    flareoverride = getdvar( @"hash_58d8dfa7b8338078", "" );
    
    if ( flareoverride != "" )
    {
        level br_contract_manager::utilflare_shootflare( location, flareoverride );
    }
    else
    {
        level br_contract_manager::utilflare_shootflare( location, "reinforcement_flare" );
    }
    
    thread function_6d9c797780fb5937();
}

// Namespace reinforcement_flare
// Params 0
// Checksum 0xa961ed5d, Offset: 0xb64
// Size: 0x54
function function_6d9c797780fb5937()
{
    player = self;
    player endon( #"death_or_disconnect" );
    player setscriptablepartstate( "ReinforcementFlare", "on", 0 );
    wait level.var_34c93817c87a1f5c.var_8a72fcb4e905bcd;
    player setscriptablepartstate( "ReinforcementFlare", "off", 0 );
}

// Namespace reinforcement_flare
// Params 1
// Checksum 0x4f0f4d10, Offset: 0xbc0
// Size: 0x22b
function reinforcementflare_respawn( respawnlist )
{
    switch ( level.var_34c93817c87a1f5c.type )
    {
        case 3:
            respawnkeys = arrayrandomize( getarraykeys( respawnlist ) );
            break;
        case 2:
            respawnlist = arraysort( respawnlist, undefined, &function_945bb14f9cec609c );
            respawnkeys = getarraykeys( respawnlist );
            break;
        case 4:
            respawnlist = arraysort( respawnlist, undefined, &function_cfe47ec3cd6ca86a );
            respawnkeys = getarraykeys( respawnlist );
            break;
        default:
            respawnkeys = getarraykeys( respawnlist );
            break;
    }
    
    if ( level.var_34c93817c87a1f5c.type == 1 )
    {
        foreach ( key in respawnkeys )
        {
            squadmate = respawnlist[ key ];
            br_spawnrespawn::br_kioskrevive( squadmate, self, 0, undefined, undefined, undefined, undefined, "reinforcement_flare" );
        }
        
        return;
    }
    
    var_cb1c85ed36bbe18a = respawnlist[ respawnkeys[ 0 ] ];
    
    if ( var_cb1c85ed36bbe18a rejoin_utility::function_e421863f0f4de34() )
    {
        foreach ( key in respawnkeys )
        {
            squadmate = respawnlist[ key ];
            
            if ( !squadmate rejoin_utility::function_e421863f0f4de34() )
            {
                var_cb1c85ed36bbe18a = squadmate;
                break;
            }
        }
    }
    
    br_spawnrespawn::br_kioskrevive( var_cb1c85ed36bbe18a, self, 0, undefined, undefined, undefined, undefined, "reinforcement_flare" );
    
    if ( !isdefined( self.endmatchstats[ "teammatesRedeployed" ] ) )
    {
        self.endmatchstats[ "teammatesRedeployed" ] = 0;
    }
    
    self.endmatchstats[ "teammatesRedeployed" ]++;
}

// Namespace reinforcement_flare
// Params 2
// Checksum 0x725df5f0, Offset: 0xdf3
// Size: 0x4f, Type: bool
function function_945bb14f9cec609c( player1, player2 )
{
    var_8acb99b94911c6af = player1.br_eliminatedtime ?? -1;
    var_5066a78c216a3822 = player2.br_eliminatedtime ?? -1;
    return var_8acb99b94911c6af <= var_5066a78c216a3822;
}

// Namespace reinforcement_flare
// Params 2
// Checksum 0xebb6cdbc, Offset: 0xe4b
// Size: 0x51, Type: bool
function function_cfe47ec3cd6ca86a( player1, player2 )
{
    var_4ef35428c0b7c6e7 = player1 currency::get_currency_amount( "cash" ) ?? 0;
    var_e28df5cabe24e64e = player2 currency::get_currency_amount( "cash" ) ?? 0;
    return var_4ef35428c0b7c6e7 >= var_e28df5cabe24e64e;
}

// Namespace reinforcement_flare
// Params 1
// Checksum 0x1ccca0c6, Offset: 0xea5
// Size: 0x19
function function_de9d1416a6338c3d( grenade )
{
    if ( isdefined( grenade ) )
    {
        grenade delete();
    }
}

