// script_530d9da948e14e79  (hash_530d9da948e14e79.gscc) (size: 3846 Bytes / 0xf06 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5124f60f (1361376783)
// size ...... 3846 (0xf06)
// includes .. 13  (offset: 0xe02)
// strings ... 12  (offset: 0xe6a)
// dev strs .. 0   (offset: 0xf06)
// exports ... 9   (offset: 0x882)
// cseg ...... 0x19c + 0x6e6 (0x882)
// imports ... 37  (offset: 0x9ea)
// animtree1 . 0   (offset: 0xf06)
// animtree2 . 0   (offset: 0xf06)
#using script_31ee2a173f3499b7;
#using script_359c9cda9983c8fc;
#using script_6485a077ba2bd020;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_main;
#using scripts\mp\zm\ztron\ztron_player;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace namespace_394d9d635c80d34;

// Namespace namespace_394d9d635c80d34
// Params 0, eflags: 0x5
// Checksum 0xccaa74ae, Offset: 0x1ba
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_264287452f1bc131", #"ztron_item", undefined, &init );
}

// Namespace namespace_394d9d635c80d34
// Params 0
// Checksum 0x239bacbb, Offset: 0x1e3
// Size: 0x5c
function init()
{
    ztron_item::function_5844a9c240f7dc8d( #"helicopter_side_scroller", #"use", &usehelicopter );
    ztron_item::function_5844a9c240f7dc8d( #"helicopter_side_scroller", #"canautouse", &canautouse );
    utility::registersharedfunc( %"hash_70928681f4fb1025", #"exitStart", &function_f673263c798b41ca );
}

// Namespace namespace_394d9d635c80d34
// Params 1, eflags: 0x4
// Checksum 0x4d56b388, Offset: 0x247
// Size: 0x14
function private canautouse( params )
{
    return namespace_4e282cd6c250c6ed::canautouse( params );
}

// Namespace namespace_394d9d635c80d34
// Params 6, eflags: 0x4
// Checksum 0x7abad636, Offset: 0x264
// Size: 0x59
function private function_f673263c798b41ca( vehicle, seatid, newseatid, player, data, specialexit )
{
    namespace_4e282cd6c250c6ed::function_f673263c798b41ca( vehicle, seatid, newseatid, player, data, specialexit );
    player notifyonplayercommandremove( "side_scroller_vehicle_fire2_press", "+frag" );
}

// Namespace namespace_394d9d635c80d34
// Params 1, eflags: 0x4
// Checksum 0x43be4640, Offset: 0x2c5
// Size: 0x1ae
function private usehelicopter( params )
{
    level endon( #"ztron_game_is_over" );
    owner = params.player;
    owner endon( #"disconnect" );
    
    if ( !isdefined( owner ) || isdefined( owner.ztron.vehicle ) || owner.ztron.vehicleblocked )
    {
        return;
    }
    
    if ( !level.ztron.var_74a3707334cfe144 )
    {
        if ( owner.ztron.var_a4c2f70bbc713f98 )
        {
            owner notify( #"ztron_playerdumpfps" );
            waitframe();
        }
    }
    
    if ( !isdefined( owner.ztron ) )
    {
        owner.ztron = spawnstruct();
    }
    
    helicopter = owner function_740b8302665cfa7b();
    
    if ( !isdefined( helicopter ) )
    {
        return;
    }
    
    owner.ztron.vehicle = helicopter;
    helicopter thread ztron_util::function_1544885c712921f8( owner );
    owner.ztron.vehicleblocked = 1;
    owner ztron_player_utility::playerinvulnerability( 1 );
    itemdata = ztron_item::function_998f2b10462afbf4( params.bundle );
    duration = itemdata.duration ?? 30;
    owner thread function_b2079861dcf45e3f( helicopter );
    owner thread namespace_4e282cd6c250c6ed::helicopterwatchtimeout( duration );
    owner thread namespace_4e282cd6c250c6ed::function_700541b3ad1ae991();
    
    if ( ztron_main::function_4da200e9b8d58a3c() != 3 )
    {
        owner ztron_ui::function_787d89891b886acf( "VEH_EXIT_HINT" );
    }
    
    owner notifyonplayercommand( "side_scroller_vehicle_fire2_press", "+frag" );
}

// Namespace namespace_394d9d635c80d34
// Params 0, eflags: 0x4
// Checksum 0xd9e2e7d, Offset: 0x47b
// Size: 0x1c4
function private function_740b8302665cfa7b()
{
    vehiclespawndata = spawnstruct();
    vehiclespawndata.origin = self.origin + ( 0, 0, 85 );
    vehiclespawndata.angles = ( 0, 90, 0 );
    vehiclespawndata.script_modelname = "xcomp_ztron_sat_mini_heli_light_attack";
    vehiclespawndata.var_305ce2bb6ec0993d = self.ztron.color;
    faildata = spawnstruct();
    helicopter = vehicle::spawn( "veh_ztron_mil_us_heli_medium_side_scroller", vehiclespawndata );
    
    if ( !isdefined( helicopter ) )
    {
        ztron_debug::debugmsg( " ztron spawnZtronHelicopter failed for player:" + self.name + " reason:" + faildata.fail, 1 );
        return;
    }
    
    helicopter.team = self.team;
    helicopter.owner = self;
    helicopter.var_9ba75406da00630d = 1;
    helicopter.no_shell_eject = 1;
    helicopter.var_f4cb64a84a917d5b = 1;
    helicopter.forcefp = 0;
    helicopter.var_826c7bc2c0346845 = 1;
    helicopter.disable_flare = 1;
    helicopter.var_36c9b449d0f1069d = 1;
    level thread vehicle_occupancy::enter( helicopter, "driver", self, undefined, 1 );
    ztron_player::function_37facbabb748eff2();
    helicopter makeunusable();
    helicopter.health = 9999999;
    vfx = "vehicle_light_" + self.ztron.color;
    playfxontagforclients( utility::getfx( vfx ), helicopter, "tag_origin", self );
    return helicopter;
}

// Namespace namespace_394d9d635c80d34
// Params 1, eflags: 0x4
// Checksum 0x231a47b1, Offset: 0x648
// Size: 0xb2
function private function_b2079861dcf45e3f( helicopter )
{
    self endon( #"disconnect" );
    helicopter endon( #"entitydeleted" );
    level endon( #"ztron_game_is_over" );
    
    while ( true )
    {
        msg = utility::waittill_any_return( "side_scroller_vehicle_fire2_press" );
        currenttime = gettime();
        
        if ( !isdefined( helicopter.lastfiretime ) )
        {
            helicopter.lastfiretime = 0;
        }
        
        if ( currenttime - helicopter.lastfiretime > 2000 )
        {
            function_22d75d7639272b3( helicopter );
            helicopter.lastfiretime = currenttime;
            helicopter notify( #"heli_bomb_dropped" );
        }
    }
}

// Namespace namespace_394d9d635c80d34
// Params 2
// Checksum 0xd063f2a, Offset: 0x702
// Size: 0x180
function function_22d75d7639272b3( helicopter, var_ace095d8272e7d34 = undefined )
{
    velocity = helicopter vehicle_getvelocity();
    bombvelocity = ( 0, 350, 0 );
    
    if ( !isdefined( var_ace095d8272e7d34 ) )
    {
        var_ace095d8272e7d34 = helicopter.origin;
    }
    
    if ( velocity[ 1 ] > 0 )
    {
        bombvelocity = ( 0, velocity[ 1 ] + 350, 0 );
    }
    
    originoffset = ( 0, 0, -20 );
    originoffset += ( 0, velocity[ 1 ] * 0.15, velocity[ 2 ] * 0.15 );
    bomb = magicgrenademanual( "sat_ztron_side2_helo_grenade", var_ace095d8272e7d34 + originoffset, bombvelocity, 5, self );
    playsoundatpos( var_ace095d8272e7d34 + originoffset, "exp_ztron_choppergunner_bomb_drop" );
    
    foreach ( otherplayer in level.players )
    {
        if ( !otherplayer.ztron.vehicle )
        {
            continue;
        }
        
        bomb function_9219aa7e250cc209( otherplayer.ztron.vehicle );
    }
    
    bomb thread zombie_triton_lava_bomb::function_f7f5dd74398250bc( 0.2 );
}

