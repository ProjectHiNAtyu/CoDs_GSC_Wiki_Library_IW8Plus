// script_87170f8cc7bd7f6  (hash_087170f8cc7bd7f6.gscc) (size: 4266 Bytes / 0x10aa / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x34b6aa98 (884386456)
// size ...... 4266 (0x10aa)
// includes .. 7   (offset: 0xf72)
// strings ... 18  (offset: 0xfaa)
// dev strs .. 0   (offset: 0x109a)
// exports ... 8   (offset: 0xa56)
// cseg ...... 0x220 + 0x836 (0xa56)
// imports ... 32  (offset: 0xb96)
// animtree1 . 0   (offset: 0x109a)
// animtree2 . 1   (offset: 0x109a)
#using script_31ee2a173f3499b7;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\ztron\ztron_bonus_room;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_slayer;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace room_shadow_vault;

// Namespace room_shadow_vault
// Params 0, eflags: 0x5
// Checksum 0xd969a3ca, Offset: 0x23e
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_f3fe20e2bd227922", undefined, undefined, &init );
}

// Namespace room_shadow_vault
// Params 0
// Checksum 0xa57ad855, Offset: 0x25f
// Size: 0xa
function init()
{
    level thread function_9288225f201b79f9();
}

// Namespace room_shadow_vault
// Params 0
// Checksum 0x10d239ba, Offset: 0x271
// Size: 0x11a
function function_9288225f201b79f9()
{
    level utility::flag_wait( "ztron_bonus_room_initialized" );
    var_a8d8980c65b4b0de = ztron_bonus_room::function_98dedbfc79dc3572( "vault" );
    
    foreach ( room in var_a8d8980c65b4b0de )
    {
        room.setupcallback = &function_a6fd1fc06d1f6c4f;
        room.cleanupcallback = &function_61ca1816d0a8df3a;
        room.var_2c482fe40c873005 = utility::getstructarray( "bonus_" + room.name + "_coinChest", "targetname" );
        room.slayermarts = utility::getstructarray( "bonus_" + room.name + "_slayerMart", "targetname" );
        room.timeout = 300;
    }
}

// Namespace room_shadow_vault
// Params 1
// Checksum 0x9ce34f67, Offset: 0x393
// Size: 0xb3
function function_61ca1816d0a8df3a( room )
{
    level.var_8972cc8b6869f399 = 0;
    level notify( #"slayermart_cleanup" );
    
    if ( !level.ztron.var_95d8c7a469393957 )
    {
        foreach ( player in level.players )
        {
            player ztron_ui::function_f7e6c4641e827bf8( 0 );
        }
    }
}

// Namespace room_shadow_vault
// Params 1
// Checksum 0x34fa8a12, Offset: 0x44e
// Size: 0x273
function function_a6fd1fc06d1f6c4f( room )
{
    level endon( #"ztron_game_is_over" );
    level endon( #"bonus_room_expired" );
    level endon( #"hash_26543e77189e41db" );
    level waittill( #"hash_9d2492f7742c7564" );
    level.var_8972cc8b6869f399 = 1;
    
    if ( !isdefined( room.enemyspawnpoints ) )
    {
        return;
    }
    
    foreach ( point in room.enemyspawnpoints )
    {
        room thread ztron_bonus_room::function_bd3a5142e2a2e9d6( point );
    }
    
    foreach ( coinchest in room.var_2c482fe40c873005 )
    {
        level thread function_fb961359a846b86a( coinchest );
    }
    
    if ( !level.ztron.var_95d8c7a469393957 )
    {
        foreach ( slayermart in room.slayermarts )
        {
            level thread ztron_slayer::slayer_arena_slayermart( slayermart, ( 0, 0, 0 ), 0, 0, room.timeout );
        }
        
        foreach ( player in level.players )
        {
            player ztron_ui::function_f7e6c4641e827bf8( 1 );
        }
    }
}

// Namespace room_shadow_vault
// Params 0
// Checksum 0x2d7194d7, Offset: 0x6c9
// Size: 0x61
function function_e170348529786a9a()
{
    level endon( #"bonus_room_completed" );
    trigger = spawn( "trigger_radius", self.origin, 0, 60, 64 );
    trigger thread ztron_util::function_36239518d8da65f0( level, "bonus_room_completed" );
    trigger waittill( #"trigger" );
    trigger delete();
    self notify( #"activated" );
}

#using_animtree( "script_model" );

// Namespace room_shadow_vault
// Params 3
// Checksum 0x497f95f7, Offset: 0x732
// Size: 0x324
function function_fb961359a846b86a( spot, var_46e4fdbe0358d7d8, var_d10c869522c10a02 )
{
    model = "sat_zm_ztron_props_treasure_chest_02_fxanim";
    multix = 1;
    chest_animation = "sat_fxanim_zm_ztron_props_treasure_chest_mid";
    animlength = getanimlength( %sat_fxanim_zm_ztron_props_treasure_chest_mid );
    var_bc1bf648e8aea1f0 = ( 0, 0, 96 );
    origin = spot.origin;
    angles = spot.angles;
    launchz = 700;
    
    if ( isdefined( spot.script_parameters ) )
    {
        args = strtok( spot.script_parameters, ";" );
        launchz = int( args[ 0 ] );
    }
    
    var_46e4fdbe0358d7d8 = var_46e4fdbe0358d7d8 ?? 30;
    var_d10c869522c10a02 = var_d10c869522c10a02 ?? 5;
    chest = utility::spawn_model( model, origin + ( 0, 0, 10 ), angles );
    
    if ( isdefined( chest ) )
    {
        chest thread ztron_util::function_36239518d8da65f0( level, "bonus_room_completed" );
        chest thread function_e170348529786a9a();
        chest waittill( #"activated" );
        wait 1;
        chest playsound( "evt_ztron_pickup_treasure_chest_activation" );
        chest scriptmodelplayanim( chest_animation );
        playfxontag( utility::getfx( "ztron_radial_purple_128" ), chest, "tag_origin" );
        chest playsound( "evt_ztron_pickup_treasure_chest_purple_glowy" );
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
                
                if ( isdefined( chest ) )
                {
                    playfx( utility::getfx( "ztron_radial_purple_256" ), chest.origin + var_bc1bf648e8aea1f0 );
                    chest playsound( "evt_ztron_pickup_treasure_chest_purple_glowy" );
                }
            }
        }
        while ( finishtime > curtime );
        
        if ( isdefined( chest ) )
        {
            var_602e340ee1627051 = chest.origin;
            chest delete();
            playfx( utility::getfx( "ztron_explo_gold" ), var_602e340ee1627051 );
            playfx( utility::getfx( "ztron_explo_gold" ), var_602e340ee1627051 + ( 0, 0, 40 ) );
            playfx( utility::getfx( "ztron_explo_purple" ), var_602e340ee1627051 + ( 40, 0, 40 ) );
            playfx( utility::getfx( "ztron_explo_purple" ), var_602e340ee1627051 + ( 0, 40, 40 ) );
            spawnoptions = ztron_item::function_41854e96b8bf4a06( var_602e340ee1627051 + ( 0, 0, 28 ) );
            ztron_item::function_d3d82aa8c393b166( var_602e340ee1627051, var_46e4fdbe0358d7d8, 140, spawnoptions );
            params = spawnstruct();
            params.launchforce = ( randomintrange( -20, 20 ), randomintrange( -20, 20 ), launchz );
            ztron_item::function_d0a061baefd87906( var_602e340ee1627051 + ( 0, 0, 28 ), var_d10c869522c10a02, 48, undefined, params );
        }
    }
}

