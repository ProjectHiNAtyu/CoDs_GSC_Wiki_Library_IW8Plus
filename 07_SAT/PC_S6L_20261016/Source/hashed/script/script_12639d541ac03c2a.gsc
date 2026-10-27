// script_12639d541ac03c2a  (hash_12639d541ac03c2a.gscc) (size: 11242 Bytes / 0x2bea / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x97334ea3 (2536722083)
// size ...... 11242 (0x2bea)
// includes .. 17  (offset: 0x2802)
// strings ... 54  (offset: 0x288a)
// dev strs .. 7   (offset: 0x2b86)
// exports ... 16  (offset: 0x1a2e)
// cseg ...... 0x4f4 + 0x153a (0x1a2e)
// imports ... 92  (offset: 0x1cae)
// animtree1 . 0   (offset: 0x2bda)
// animtree2 . 1   (offset: 0x2bda)
#using script_31ee2a173f3499b7;
#using script_4ce55cfc81c444ad;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_bonus_room;
#using scripts\mp\zm\ztron\ztron_camera;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_enemy;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;
#using scripts\mp\zm\ztron\ztron_vfx;
#using scripts\mp\zm\ztron\ztron_world_event;

#namespace ztron_arena_island;

// Namespace ztron_arena_island
// Params 0, eflags: 0x5
// Checksum 0xd31cdb1c, Offset: 0x512
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"island", undefined, &arena_init, undefined );
}

// Namespace ztron_arena_island
// Params 0
// Checksum 0x1d7562b8, Offset: 0x533
// Size: 0x9
function arena_init()
{
    thread arena_init_internal();
}

// Namespace ztron_arena_island
// Params 0
// Checksum 0x579625fa, Offset: 0x544
// Size: 0x2a
function arena_init_internal()
{
    waittillframeend();
    ztron_arena::function_c61881897b87656d( "island", &island_init, &island_shutdown );
    utility::add_fx( "dust_puff", "vfx_t10_levels_zm_garnet_cin_ground_impact_dust_ztron" );
}

// Namespace ztron_arena_island
// Params 0
// Checksum 0x802e5b4b, Offset: 0x576
// Size: 0x133
function island_init()
{
    level callback::add( "on_zombie_ai_killed", &on_ai_killed );
    
    if ( level.ztron.game_laps == 0 && !level.ztron.blitzmode )
    {
        level thread papabackintro();
    }
    
    level thread island_special_event();
    level.ztron.var_4610a5d2530c13cd = [];
    var_25636f5a75be5f84 = utility::getstructarray( "island_weapon_chest", "targetname" );
    
    foreach ( chest in var_25636f5a75be5f84 )
    {
        achest = level function_fb961359a846b86a( chest );
        achest thread chest_think();
        level.ztron.var_4610a5d2530c13cd[ level.ztron.var_4610a5d2530c13cd.size ] = achest;
    }
}

// Namespace ztron_arena_island
// Params 0
// Checksum 0x6ef5a37, Offset: 0x6b1
// Size: 0xae
function island_shutdown()
{
    level.ztron.var_d5a46a191654f0dd = undefined;
    level callback::remove( "on_zombie_ai_killed", &on_ai_killed );
    
    foreach ( chest in level.ztron.var_4610a5d2530c13cd )
    {
        if ( isdefined( chest ) )
        {
            chest delete();
        }
    }
}

// Namespace ztron_arena_island
// Params 0
// Checksum 0xd8027c18, Offset: 0x767
// Size: 0xfc
function island_special_event()
{
    level endon( #"ztron_game_is_over", #"arena_deactivated", #"arena_completed" );
    
    while ( true )
    {
        level waittill( #"round_about_to_start" );
        waittillframeend();
        level.ztron.var_d5a46a191654f0dd = [ "top", "right", "left" ];
        
        if ( level.ztron.roundnumber == 1 )
        {
            if ( ztron_arena::function_af7e3641e16060b0() )
            {
                return;
            }
        }
        
        if ( level.ztron.arena_rounds_left == 2 )
        {
            ztron_bonus_room::function_b018ee630661e155( "plunder" );
            level.ztron.var_d5a46a191654f0dd = [ "bottom" ];
        }
        
        if ( level.ztron.arena_rounds_left == 1 )
        {
            level thread function_334c8215dee9ceeb( ( -35353.5, -21867.7, 1 ), 30 );
        }
    }
}

// Namespace ztron_arena_island
// Params 0
// Checksum 0x3fc2ec47, Offset: 0x86b
// Size: 0xf0
function function_9b7c44cc01c03ddd()
{
    self endon( #"death" );
    
    while ( self.gatheritems )
    {
        pickups = sortbydistance( level.ztron.itemdef.spawneditems, self.origin );
        
        foreach ( item in pickups )
        {
            distsq = distancesquared( self.origin, item.origin );
            
            if ( distsq < 2304 )
            {
                level thread ztron_item::clearitem( item );
            }
        }
        
        waitframe();
    }
}

// Namespace ztron_arena_island
// Params 0
// Checksum 0x87df3ec, Offset: 0x963
// Size: 0x964
function papabackintro()
{
    level endon( #"ztron_game_is_over", #"remove_papaback_intro", #"papa_intro_done" );
    note = level utility::waittill_any_return( "teleporter_being_opened", "trigger_papaback_intro" );
    level.ztron.var_9cb1ea9ce77759 = 1;
    level.ztron.var_3678ff7453f3c5cf = "papa_intro_done";
    level utility::flag_set( "arena_hold_teleporter" );
    
    /#
        if ( note == "<dev string:x24>" )
        {
            level.ztron.arena_rounds_left = 0;
            level utility::flag_clear( "<dev string:x3b>" );
            wait 0.1;
            ztron_util::killallenemies();
        }
    #/
    
    ztron_debug::debugmsg( "SQUELCHING UI" );
    ztron_ui::function_4eb411ba146450();
    level ztron_ui::function_f5177e090dadd8f4( 2 );
    ztron_ui::function_2bea9afab8148cc7( 0 );
    var_9aef23294709d60b = utility::getstruct( "island_papaback_intro_spot", "targetname" );
    var_97f9acf1dc133b69 = utility::getstruct( "island_papaback_intro_camera_spot", "targetname" );
    var_c38605c6524b6ae7 = utility::getstructarray( "island_papaback_intro_player_spot", "targetname" );
    treasurespot = utility::getstruct( "island_treasure_papaback_intro", "targetname" );
    assert( isdefined( var_9aef23294709d60b ), "<dev string:x50>" );
    assert( isdefined( var_97f9acf1dc133b69 ), "<dev string:x6c>" );
    assert( isdefined( treasurespot ), "<dev string:x88>" );
    assert( isdefined( var_c38605c6524b6ae7 ), "<dev string:xa6>" );
    assert( var_c38605c6524b6ae7.size == 4, "<dev string:xc3>" );
    
    foreach ( spot in var_c38605c6524b6ae7 )
    {
        spot.spotindex = int( spot.script_noteworthy ?? 0 );
    }
    
    function_7243d45b5d82f431( var_c38605c6524b6ae7, #spotindex, 4 );
    spawnoptions = ztron_item::function_41854e96b8bf4a06( treasurespot.origin + ( 0, 0, 28 ) );
    ztron_item::function_e062f5021d53874e( treasurespot.origin, 30, 128, spawnoptions );
    wait 1;
    
    foreach ( player in level.players )
    {
        player notify( #"ztron_playerdumpfps" );
        player notify( #"kill_shield" );
    }
    
    wait 1;
    level notify( #"papa_intro_begin" );
    ztron_camera::function_90951f3fca05e46a( var_97f9acf1dc133b69.origin, var_97f9acf1dc133b69.angles );
    idx = 0;
    
    foreach ( player in level.players )
    {
        if ( !isalive( player ) || player.ztron.var_2c44544a01cc415e )
        {
            player ztron_player_utility::playerrespawnnow( 0, undefined, 0, 0 );
        }
        
        ztron_player_utility::function_1bb9b2e327c29632( player );
        player ztron_player_utility::function_a9dd68a6d53566b0( 1, var_c38605c6524b6ae7[ idx ].origin, var_c38605c6524b6ae7[ idx ].angles, 1 );
        idx++;
    }
    
    level thread ztron_world_event::function_8137d21072086004( idx );
    ztron_sound::function_ac1e49175da7897d( "gameEvent", "papabackInGameScene" );
    playsoundatpos( ( 0, 0, 0 ), "cin_ztron_rnd_4" );
    org = utility::spawn_model( "tag_origin", var_9aef23294709d60b.origin + ( 0, 0, 1200 ), var_9aef23294709d60b.angles );
    org thread ztron_util::function_36239518d8da65f0( level, "papa_intro_done" );
    papaback = ztron_enemy::function_acee91c445fafd29( ztron_enemy::function_96eea0d09d5640d1( "papaback" ), org.origin, undefined, undefined, 1, 1 );
    papaback notify( #"kill_think" );
    papaback forceteleport( papaback.origin, var_9aef23294709d60b.angles );
    papaback thread ztron_util::function_36239518d8da65f0( level, "papa_intro_done" );
    papaback setcandamage( 0 );
    papaback.var_9f4fae59ff4e962a = 1;
    papaback linkto( org );
    papaback.introorg = org;
    papaback.stfu = 1;
    papaback.ignoreme = 1;
    playfx( utility::getfx( "lightning_b" ), var_9aef23294709d60b.origin );
    wait 1;
    playfx( utility::getfx( "lightning_strike" ), var_9aef23294709d60b.origin );
    org moveto( var_9aef23294709d60b.origin, 0.5 );
    org waittill( #"movedone" );
    playfxontag( utility::getfx( "lightning_ground" ), org, "tag_origin" );
    playfx( utility::getfx( "papaback_intro" ), org.origin + ( 0, 0, 12 ) );
    playfxontag( utility::getfx( "silverback_uplight" ), papaback, "tag_origin" );
    wait 1;
    papaback ztron_dialog::function_7e3f6329d9afcdc1( #"hash_625d688753f434fa", 1 );
    wait 4;
    papaback ztron_dialog::function_7e3f6329d9afcdc1( #"hash_740982c8b879b47", 1 );
    wait 3.5;
    papaback ztron_dialog::function_7e3f6329d9afcdc1( #"hash_625d668753f43194", 1 );
    wait 1;
    papaback.gatheritems = 1;
    papaback thread function_9b7c44cc01c03ddd();
    level.ztron.activeattractors[ level.ztron.activeattractors.size ] = papaback;
    magnetfx = ztron_vfx::function_574a3236c59da7d8( "vfx_ztron_magnet", papaback.origin + ( 0, 0, 20 ) );
    magnetfx thread ztron_util::function_36239518d8da65f0( level, "papa_intro_done" );
    wait 3;
    ztron_vfx::function_4abb26b271676888( magnetfx );
    level.ztron.activeattractors = arrayremove( level.ztron.activeattractors, papaback );
    
    if ( isdefined( org ) )
    {
        playfx( utility::getfx( "ztron_radial_purple_128" ), org.origin );
        playfx( utility::getfx( "ztron_radial_purple_256" ), org.origin + ( 0, 0, 8 ) );
        playfx( utility::getfx( "red_portal_sphere" ), org.origin + ( 0, 0, 48 ) );
        playfx( utility::getfx( "papaback_intro_exit" ), org.origin + ( 0, 0, 24 ) );
    }
    
    wait 0.5;
    roll = randomint( 100 );
    
    if ( roll == 0 )
    {
        papaback ztron_dialog::function_7e3f6329d9afcdc1( #"hash_a91805b5ce7bcbee", 1 );
    }
    else
    {
        papaback ztron_dialog::function_7e3f6329d9afcdc1( #"hash_740992c8b879cfa", 1 );
    }
    
    if ( isdefined( org ) )
    {
        playfxontag( utility::getfx( "lightning_ground" ), org, "tag_origin" );
    }
    
    wait 3.25;
    playfx( utility::getfx( "lightning_strike" ), papaback.origin );
    stopfxontag( utility::getfx( "silverback_uplight" ), papaback, "tag_origin" );
    
    if ( isdefined( org ) )
    {
        org moveto( papaback.origin + ( 0, 0, 1500 ), 2 );
        org utility::waittill_any_timeout( 2.1, "movedone" );
    }
    
    level notify( #"ztron_cutscene_world_event_deactive" );
    
    foreach ( player in level.players )
    {
        player ztron_player_utility::function_a9dd68a6d53566b0( 0 );
    }
    
    ztron_camera::function_b75a71ef33e0e6cc();
    ztron_sound::function_ac1e49175da7897d( "arenaEvent", "arenaActivated", level.ztron.active_arena.name );
    ztron_ui::function_559d7c88c3ffd811();
    level ztron_ui::function_f5177e090dadd8f4( 0 );
    ztron_ui::function_2bea9afab8148cc7( 1 );
    ztron_debug::debugmsg( "UNSQUELCHING UI" );
    level utility::flag_clear( "arena_hold_teleporter" );
    level.ztron.var_9cb1ea9ce77759 = undefined;
    level.ztron.var_3678ff7453f3c5cf = undefined;
    level notify( #"papa_intro_done" );
}

// Namespace ztron_arena_island
// Params 0
// Checksum 0xa37467ae, Offset: 0x12cf
// Size: 0xa1
function function_e170348529786a9a()
{
    level endon( #"ztron_game_is_over", #"arena_deactivated", #"arena_completed" );
    trigger = spawn( "trigger_radius", self.origin, 2, 60, 92 );
    trigger enablelinkto();
    trigger linkto( self );
    trigger thread ztron_util::function_36239518d8da65f0( level, "arena_deactivated" );
    
    while ( true )
    {
        trigger waittill( #"trigger", guy );
        
        if ( isplayer( guy ) )
        {
            break;
        }
    }
    
    trigger delete();
    self notify( #"activated" );
}

// Namespace ztron_arena_island
// Params 1
// Checksum 0x339c497b, Offset: 0x1378
// Size: 0xe9
function function_fb961359a846b86a( chest_spot )
{
    model = "sat_zm_ztron_props_treasure_chest_03_fxanim";
    chest = utility::spawn_model( model, chest_spot.origin, chest_spot.angles );
    
    if ( isdefined( chest_spot.script_noteworthy ) )
    {
        chest.increments = int( chest_spot.script_noteworthy );
    }
    else
    {
        chest.increments = randomintrange( 80, 140 );
    }
    
    chest.origin += ( 0, 0, chest.increments * -1 );
    chest solid();
    chest.surface_origin = getgroundposition( chest.origin, 32, 64, 512 );
    chest thread ztron_util::function_36239518d8da65f0( level, "arena_deactivated" );
    return chest;
}

#using_animtree( "script_model" );

// Namespace ztron_arena_island
// Params 0
// Checksum 0x82e12313, Offset: 0x146a
// Size: 0x363
function chest_think()
{
    self notify( #"hash_209c55cef4f66c42" );
    self endon( #"hash_209c55cef4f66c42" );
    level endon( #"ztron_game_is_over", #"arena_deactivated", #"arena_completed" );
    chest = self;
    chest endon( #"death" );
    msg = level utility::waittill_any_return( "activate_chest", "raise_chest" );
    
    if ( !isdefined( chest ) )
    {
        return;
    }
    
    if ( msg == "raise_chest" )
    {
        chest moveto( chest.origin + ( 0, 0, 1 ), 0.1 );
        chest.increments--;
        
        if ( chest.increments > 0 )
        {
            if ( isdefined( chest.surface_origin ) && chest.increments < 35 )
            {
                playfx( utility::getfx( "dust_puff" ), chest.surface_origin );
            }
            
            chest thread chest_think();
            return;
        }
    }
    
    if ( isdefined( chest.surface_origin ) )
    {
        delta = chest.surface_origin[ 2 ] - chest.origin[ 2 ] - 10;
        
        if ( delta > 0 )
        {
            chest moveto( chest.surface_origin + ( 0, 0, -10 ), 1 );
        }
    }
    
    chest setscriptablepartstate( "body", "vfx_on" );
    playfxontag( utility::getfx( "ztron_radial_purple_128" ), chest, "tag_origin" );
    chest playsound( "evt_ztron_pickup_treasure_chest_purple_glowy" );
    multix = 1;
    chest_animation = "sat_fxanim_zm_ztron_props_treasure_chest_mid";
    animlength = getanimlength( %sat_fxanim_zm_ztron_props_treasure_chest_mid );
    var_bc1bf648e8aea1f0 = ( 0, 0, 96 );
    chest thread function_e170348529786a9a();
    chest waittill( #"activated" );
    chest playsound( "evt_ztron_pickup_treasure_chest_activation" );
    chest scriptmodelplayanim( chest_animation );
    playfxontag( utility::getfx( "ztron_radial_purple_128" ), chest, "tag_origin" );
    curtime = gettime();
    finishtime = curtime + animlength * 1000;
    var_c5ed952d7e61d3c6 = curtime + int( animlength * 0.75 * 1000 );
    var_a6c763d12d573728 = 0;
    
    do
    {
        waitframe();
        curtime = gettime();
        
        if ( curtime > var_c5ed952d7e61d3c6 && !var_a6c763d12d573728 )
        {
            var_a6c763d12d573728 = 1;
            playfx( utility::getfx( "ztron_radial_purple_256" ), chest.origin + var_bc1bf648e8aea1f0 );
            chest playsound( "evt_ztron_pickup_treasure_chest_purple_glowy" );
        }
    }
    while ( finishtime > curtime );
    
    var_602e340ee1627051 = chest.origin;
    playfx( utility::getfx( "ztron_explo_gold" ), var_602e340ee1627051 + ( 0, 0, 40 ) );
    playfx( utility::getfx( "ztron_exp_lg" ), var_602e340ee1627051 );
    itemname = ztron_item::function_f3613b119900d057( #"weapon" );
    
    if ( isdefined( itemname ) )
    {
        pos = var_602e340ee1627051 + ( 0, 0, 30 );
        spawnoptions = ztron_item::function_41854e96b8bf4a06( pos );
        ztron_item::clusteritemspawn( itemname, pos, 3, 60, spawnoptions );
    }
    
    chest delete();
}

// Namespace ztron_arena_island
// Params 1
// Checksum 0xcc09fd65, Offset: 0x17d5
// Size: 0x18
function on_ai_killed( params )
{
    level notify( #"raise_chest" );
}

// Namespace ztron_arena_island
// Params 2
// Checksum 0xfbf45a74, Offset: 0x17f5
// Size: 0x4f
function function_334c8215dee9ceeb( origin, radius )
{
    trigger = spawn( "trigger_radius", origin, 0, radius, 150 );
    
    if ( isdefined( trigger ) )
    {
        trigger thread fire_think();
        trigger thread ztron_util::function_36239518d8da65f0( level, "arena_deactivated" );
    }
}

// Namespace ztron_arena_island
// Params 0, eflags: 0xc
// Checksum 0x509cab92, Offset: 0x184c
// Size: 0x16a
function private fire_think()
{
    self notify( #"hash_214afd6f00e6a846" );
    self endon( #"hash_214afd6f00e6a846" );
    self endon( #"death" );
    tickrate = 500;
    self.script_noteworthy = "island_campfire";
    
    while ( isdefined( self ) )
    {
        self waittill( #"trigger", guy );
        
        if ( !isdefined( guy ) )
        {
            continue;
        }
        
        if ( isplayer( guy && player::isinlaststand( guy ) ) )
        {
            continue;
        }
        
        if ( !isalive( guy ) )
        {
            continue;
        }
        
        if ( guy.no_hazards || guy.ztron.boss )
        {
            continue;
        }
        
        time = gettime();
        
        if ( !isdefined( guy.var_e88a2a8920311baf ) )
        {
            guy.var_e88a2a8920311baf = 0;
        }
        
        if ( guy.var_e88a2a8920311baf > gettime() )
        {
            continue;
        }
        
        guy.var_e88a2a8920311baf = time + tickrate;
        
        if ( isplayer( guy ) )
        {
            guy dodamage( 50, guy.origin, self, self, "MOD_ELEMENTAL_FIRE" );
            guy playrumbleonentity( "damage_med" );
            guy ztron_vfx::burn();
            continue;
        }
        
        if ( isai( guy ) )
        {
            guy ztron_vfx::burn();
            guy function_a4bf1b72c703416( randomfloatrange( 1, 4 ), self );
        }
    }
}

// Namespace ztron_arena_island
// Params 2
// Checksum 0x49f6445c, Offset: 0x19be
// Size: 0x70
function function_a4bf1b72c703416( duration, inflictor )
{
    self notify( #"hash_4c56223f6bff874f" );
    self endon( #"hash_4c56223f6bff874f" );
    self endon( #"death" );
    thread ztron_util::function_ea0a0be5c5468c48( duration, inflictor, "MOD_ELEMENTAL_FIRE", 0 );
    
    while ( true )
    {
        self dodamage( 10, self.origin, inflictor, undefined, "MOD_ELEMENTAL_FIRE" );
        wait 0.25;
    }
}

