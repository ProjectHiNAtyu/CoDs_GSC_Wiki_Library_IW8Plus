// script_27343267776bd9ef  (hash_27343267776bd9ef.gscc) (size: 13366 Bytes / 0x3436 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x93055a4a (2466601546)
// size ...... 13366 (0x3436)
// includes .. 16  (offset: 0x30ce)
// strings ... 36  (offset: 0x314e)
// dev strs .. 7   (offset: 0x33de)
// exports ... 31  (offset: 0x1faa)
// cseg ...... 0x2ac + 0x1cfe (0x1faa)
// imports ... 103 (offset: 0x2482)
// animtree1 . 0   (offset: 0x3436)
// animtree2 . 0   (offset: 0x3436)
#using script_31ee2a173f3499b7;
#using script_87170f8cc7bd7f6;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\mp\zm\ztron\ztron_bonus_room;
#using scripts\mp\zm\ztron\ztron_camera;
#using scripts\mp\zm\ztron\ztron_enemy;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_slayer;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace namespace_586743fe9d26feaa;

// Namespace namespace_586743fe9d26feaa
// Params 0, eflags: 0x5
// Checksum 0xcd01f75d, Offset: 0x2ca
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_e7dd59a4ab7e2d03", undefined, undefined, &init );
}

// Namespace namespace_586743fe9d26feaa
// Params 0
// Checksum 0xf94656b5, Offset: 0x2eb
// Size: 0x9
function init()
{
    thread function_bf63554424ec5622();
}

// Namespace namespace_586743fe9d26feaa
// Params 0
// Checksum 0x2a24d5cb, Offset: 0x2fc
// Size: 0x2d0
function function_bf63554424ec5622()
{
    level utility::flag_wait( "ztron_bonus_room_initialized" );
    var_a8d8980c65b4b0de = ztron_bonus_room::function_98dedbfc79dc3572( "eggxit" );
    
    if ( var_a8d8980c65b4b0de.size > 0 )
    {
        foreach ( room in var_a8d8980c65b4b0de )
        {
            room.setupcallback = &function_1880d00408ac56f1;
            room.var_d822af3942fcbc3d = &function_8856bcbd9ae9745c;
            room.var_d4ea8a279b48a561 = 1;
            room.cameratriggers = ztron_util::function_2d9de5c7b97db39( "bonus_" + room.name + "_camera_trigger", #script_noteworthy );
            room.motorspots = utility::getstructarray( "bonus_" + room.name + "_pickup_motor", "targetname" );
            room.bossfighttrigger = ztron_util::function_95ca81ff822c3de4( "bonus_" + room.name + "_boss_fight_trigger", #script_noteworthy );
            room.enemyspawns = utility::getstructarray( room.name + "_enemy_spawn", "targetname" );
            room.enemytriggers = ztron_util::function_2d9de5c7b97db39( room.name + "_enemy_trigger", #targetname );
            room.bossspot = utility::getstruct( room.name + "_enemy_spawn_boss", "targetname" );
            room.roomblocker = utility::getstruct( room.name + "_blocker_boss", "targetname" );
            room.var_6b4cf11b7ebac7d4 = getent( room.name + "_blocker_boss_brushmodel", "targetname" );
            
            if ( isdefined( room.var_6b4cf11b7ebac7d4 ) )
            {
                room.var_6b4cf11b7ebac7d4.original_location = room.var_6b4cf11b7ebac7d4.origin;
            }
            
            room.var_2c482fe40c873005 = utility::getstructarray( "bonus_" + room.name + "_coinChest", "targetname" );
            room.slayermarts = utility::getstructarray( "bonus_" + room.name + "_slayerMart", "targetname" );
            room.var_e1b2540e2c81f811 = 1;
        }
    }
    
    /#
        level thread function_ac7ee3673d6e340d();
    #/
}

// Namespace namespace_586743fe9d26feaa
// Params 1
// Checksum 0x50e219c8, Offset: 0x5d4
// Size: 0x1a9
function function_1880d00408ac56f1( room )
{
    setdvar( @"walljump_enabled", 1 );
    level.ztron.var_e65fc3d0de638a87 = 1;
    level.ztron.var_eada0e62460405c1 = 1;
    level.var_8972cc8b6869f399 = 1;
    level thread function_864929147336c9fd( room );
    level thread function_c7c9142af23ede45( room );
    level thread function_f4c3dd8c0480fc68( room );
    ztron_ui::function_f5177e090dadd8f4( 2 );
    function_8be1b6b63593c4bf( room );
    room thread spawnenemies();
    level waittill( #"hash_9d2492f7742c7564" );
    
    foreach ( coinchest in room.var_2c482fe40c873005 )
    {
        level thread room_shadow_vault::function_fb961359a846b86a( coinchest, 17, 5 );
    }
    
    if ( !level.ztron.var_95d8c7a469393957 )
    {
        foreach ( player in level.players )
        {
            player ztron_ui::function_f7e6c4641e827bf8( 1 );
        }
    }
}

// Namespace namespace_586743fe9d26feaa
// Params 1, eflags: 0x4
// Checksum 0x4d148841, Offset: 0x785
// Size: 0xf5
function private function_864929147336c9fd( room )
{
    level endon( #"bonus_room_completed", #"ztron_game_is_over" );
    level waittill( #"hash_a41416bce603e07" );
    slots = utility::array_slice( room.motorspots, 0, level.players.size );
    ztron_item::function_6607be6e510e8f54( slots );
    utility::registersharedfunc( #"motorcycle", #"used", &function_5037c7d84425d125 );
    
    foreach ( player in level.players )
    {
        player thread function_676698873df4ebe2( room );
    }
}

// Namespace namespace_586743fe9d26feaa
// Params 1, eflags: 0x4
// Checksum 0x218cc0eb, Offset: 0x882
// Size: 0x42
function private function_5037c7d84425d125( params )
{
    owner = params.player;
    owner ztron_util::teleport_player( params.origin, params.angles );
}

// Namespace namespace_586743fe9d26feaa
// Params 1, eflags: 0x4
// Checksum 0x95eb0e4c, Offset: 0x8cc
// Size: 0x68
function private function_676698873df4ebe2( room )
{
    level endon( #"bonus_room_expired", #"ztron_game_is_over" );
    self waittill( #"vehicle_enter", vehicle );
    val::set( "eggxit", "vehicle_exit", 0 );
    val::set( "eggxit", "vehicle_seat_switch", 0 );
    level thread function_728b2e3ca14f3a44( room );
}

// Namespace namespace_586743fe9d26feaa
// Params 1, eflags: 0xc
// Checksum 0xaeb7c799, Offset: 0x93c
// Size: 0x207
function private function_728b2e3ca14f3a44( room )
{
    self notify( #"hash_a8c2a0998b4d06ed" );
    self endon( #"hash_a8c2a0998b4d06ed" );
    
    if ( room.playercatched )
    {
        return;
    }
    
    room.playercatched = 1;
    players = [];
    
    foreach ( player in level.players )
    {
        if ( isdefined( player.ztron.vehicle ) )
        {
            continue;
        }
        
        if ( isdefined( room.var_4b936b352886bbc4 ) && arraycontains( room.var_4b936b352886bbc4, player ) )
        {
            continue;
        }
        
        players[ players.size ] = player;
    }
    
    if ( players.size > 0 )
    {
        index = 0;
        
        foreach ( motorspot in room.motorspots )
        {
            if ( isdefined( motorspot.item ) )
            {
                if ( index < players.size )
                {
                    player = players[ index ];
                    
                    if ( player.ztron.var_752bd0f0c94ae04a )
                    {
                        player ztron_player_utility::function_e914a81b9f8ce0c8( motorspot.origin );
                    }
                    else
                    {
                        player thread ztron_util::teleport_player( motorspot.origin, motorspot.angles ?? ( 0, 0, 0 ) );
                    }
                    
                    index++;
                }
            }
        }
    }
}

// Namespace namespace_586743fe9d26feaa
// Params 1, eflags: 0xc
// Checksum 0xeb1eeb5e, Offset: 0xb4b
// Size: 0x189
function private function_c640dfb04d8f315d( room )
{
    self notify( #"hash_291ab08df57717ca" );
    self endon( #"hash_291ab08df57717ca" );
    level endon( #"bonus_room_expired", #"ztron_game_is_over" );
    self endon( #"disconnect" );
    
    if ( !isdefined( room.var_4b936b352886bbc4 ) )
    {
        room.var_4b936b352886bbc4 = [];
    }
    
    while ( room.bossfighttrigger )
    {
        vehicle = self.ztron.vehicle;
        var_8736557eb750d6f5 = self istouching( room.bossfighttrigger );
        var_8736557eb750d6f5 |= vehicle && vehicle istouching( room.bossfighttrigger );
        
        if ( var_8736557eb750d6f5 )
        {
            if ( isdefined( vehicle ) )
            {
                self notify( #"ztron_player_dump_vehicle" );
            }
            
            room.var_4b936b352886bbc4[ room.var_4b936b352886bbc4.size ] = self;
            room notify( #"player_start_boss_fight" );
            
            if ( self.ztron.var_a4c2f70bbc713f98 )
            {
                self notify( #"ztron_playerdumpfps", { #clearforced:1 } );
                waittillframeend();
            }
            
            ztron_camera::function_e53bf7020d2f155d( 0 );
            ztron_camera::function_79d64be315aa51c9( 3 );
            val::set( "topdowncamera", "allow_jump", 0 );
            val::set( "topdowncamera", "crouch", 0 );
            val::set( "topdowncamera", "sprint", 0 );
            self allowwalljump( 0 );
            break;
        }
        
        wait 0.1;
    }
}

// Namespace namespace_586743fe9d26feaa
// Params 1, eflags: 0x4
// Checksum 0x12dfe721, Offset: 0xcdc
// Size: 0x234
function private function_c7c9142af23ede45( room )
{
    level endon( #"bonus_room_expired", #"ztron_game_is_over" );
    
    if ( !isdefined( room.roomblocker.scriptable ) )
    {
        room.roomblocker.scriptable = spawnscriptable( "ztron_room_of_fate_blocker", room.roomblocker.origin, room.roomblocker.angles );
    }
    
    room.roomblocker.scriptable setscriptablepartstate( "ztron_room_of_fate_blocker", "show" );
    
    if ( isdefined( room.var_6b4cf11b7ebac7d4 ) && isdefined( room.var_6b4cf11b7ebac7d4.original_location ) )
    {
        room.var_6b4cf11b7ebac7d4.origin = room.var_6b4cf11b7ebac7d4.original_location;
    }
    
    foreach ( player in level.players )
    {
        player thread function_c640dfb04d8f315d( room );
    }
    
    room waittill( #"player_start_boss_fight" );
    ztron_ui::function_37aad40e39a9fdfe( "slayer_boss_coming_zursa", "zursa" );
    ztron_util::function_40ad6a6cc144aa3f( level.ztron.dialogues[ "DOA_Slayer_Boss_Zursa" ] );
    wait 5;
    spot = room.bossspot;
    zursadef = ztron_enemy::function_96eea0d09d5640d1( "zursa" );
    zursa = ztron_enemy::function_77e1bf43b991b4a( zursadef, 1, spot.origin, 0, undefined, undefined, undefined, undefined, undefined, undefined, 1, 1 );
    
    if ( isdefined( zursa ) )
    {
        zursa.var_63c94fe1b2260b34 = 1;
        zursa callback::add( #"on_ai_killed", &function_cecfedb105f65de5 );
    }
}

// Namespace namespace_586743fe9d26feaa
// Params 1, eflags: 0x4
// Checksum 0xf90959b0, Offset: 0xf18
// Size: 0x174
function private function_cecfedb105f65de5( params )
{
    room = level.ztron.var_8a9067aa4cd65369;
    
    if ( isdefined( room.roomblocker.scriptable ) )
    {
        room.roomblocker.scriptable setscriptablepartstate( "ztron_room_of_fate_blocker", "fade_out" );
    }
    
    if ( isdefined( room.var_6b4cf11b7ebac7d4 ) && isdefined( room.var_6b4cf11b7ebac7d4.original_location ) )
    {
        room.var_6b4cf11b7ebac7d4.origin = room.var_6b4cf11b7ebac7d4.original_location + ( 0, 0, -5000 );
    }
    
    if ( !level.ztron.var_95d8c7a469393957 )
    {
        foreach ( slayermart in room.slayermarts )
        {
            level thread ztron_slayer::slayer_arena_slayermart( slayermart, ( 0, 0, 0 ), 0, 0, room.timeout );
        }
    }
}

// Namespace namespace_586743fe9d26feaa
// Params 0, eflags: 0xc
// Checksum 0x65ad0b20, Offset: 0x1094
// Size: 0xb9
function private spawnenemies()
{
    self notify( #"hash_5046da723e0d58a6" );
    self endon( #"hash_5046da723e0d58a6" );
    level endon( #"bonus_room_expired" );
    level endon( #"bonus_room_exit_taken" );
    thread setupenemies();
    thread function_fc77ee2a6b4ef9cc();
    
    foreach ( enemyspot in self.enemyspawns )
    {
        thread ztron_bonus_room::function_bd3a5142e2a2e9d6( enemyspot );
    }
}

// Namespace namespace_586743fe9d26feaa
// Params 0, eflags: 0x4
// Checksum 0xea5ac80d, Offset: 0x1155
// Size: 0x7c
function private function_fc77ee2a6b4ef9cc()
{
    foreach ( var_a03f3ef026355506 in self.enemytriggers )
    {
        var_a03f3ef026355506 thread function_8929bba4efa13cea( self );
    }
}

// Namespace namespace_586743fe9d26feaa
// Params 0, eflags: 0x4
// Checksum 0xa6b553, Offset: 0x11d9
// Size: 0x33
function private setupenemies()
{
    level callback::add( "on_zombie_ai_spawned", &function_376056eb96b08d23 );
    level waittill( #"deactivate_bonus_room" );
    level callback::remove( "on_zombie_ai_spawned", &function_376056eb96b08d23 );
}

// Namespace namespace_586743fe9d26feaa
// Params 1, eflags: 0x4
// Checksum 0x7a4b09a4, Offset: 0x1214
// Size: 0x3d
function private function_376056eb96b08d23( params )
{
    if ( !self.ztron.boss && self.var_361a087ab08adc1c != "sprint" )
    {
        thread function_38dcc47e0ef5d7c7();
    }
}

// Namespace namespace_586743fe9d26feaa
// Params 0, eflags: 0x4
// Checksum 0x71bcd9e9, Offset: 0x1259
// Size: 0x4e
function private function_38dcc47e0ef5d7c7()
{
    callback::add( "on_zombie_ai_damaged", &function_63f693dae488b6c1 );
    
    while ( true )
    {
        self waittill( #"speed_change" );
        
        if ( self.var_361a087ab08adc1c == "sprint" )
        {
            break;
        }
    }
    
    callback::remove( "on_zombie_ai_damaged", &function_63f693dae488b6c1 );
}

// Namespace namespace_586743fe9d26feaa
// Params 1, eflags: 0x4
// Checksum 0x5ea9fcbd, Offset: 0x12af
// Size: 0xa0
function private function_63f693dae488b6c1( sparams )
{
    victim = self;
    attacker = ztron_util::function_da4039e4c338f818( sparams.eattacker );
    
    if ( victim.var_361a087ab08adc1c != "sprint" )
    {
        if ( !isdefined( victim.favoriteenemy ) && isdefined( attacker ) )
        {
            victim getenemyinfo( attacker );
        }
        
        victim.var_361a087ab08adc1c = "sprint";
        victim zombie_utils::function_a8ce00e0448cb6f0( victim.var_361a087ab08adc1c, "ztron", 4 );
        victim notify( #"speed_change" );
    }
}

// Namespace namespace_586743fe9d26feaa
// Params 1, eflags: 0xc
// Checksum 0x8fa03ab4, Offset: 0x1357
// Size: 0x129
function private function_8929bba4efa13cea( room )
{
    self notify( #"hash_e72ffb213772ce9" );
    self endon( #"hash_e72ffb213772ce9" );
    level endon( #"bonus_room_expired" );
    targetplayer = undefined;
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( isent( ent ) && self function_b0b72d20769d0233() )
        {
            if ( isplayer( ent ) )
            {
                targetplayer = ent;
                break;
            }
            
            if ( ent vehicle::is_vehicle() )
            {
                targetplayer = ent.owner;
                break;
            }
        }
    }
    
    enemyspots = utility::getstructarray( self.target, "targetname" );
    
    foreach ( enemyspot in enemyspots )
    {
        room thread function_8ff21dbddb53a574( enemyspot, targetplayer );
    }
}

// Namespace namespace_586743fe9d26feaa
// Params 2, eflags: 0x4
// Checksum 0x517a4c61, Offset: 0x1488
// Size: 0x37
function private function_8ff21dbddb53a574( enemyspot, targetplayer )
{
    enemyspot.targetplayer = targetplayer;
    ztron_bonus_room::function_bd3a5142e2a2e9d6( enemyspot );
    enemyspot.targetplayer = undefined;
}

// Namespace namespace_586743fe9d26feaa
// Params 2
// Checksum 0x69024205, Offset: 0x14c7
// Size: 0x1d4
function function_8856bcbd9ae9745c( room, var_4659d2db90ce8d11 = 0 )
{
    if ( level utility::flag_exist( "ztron_game_is_over" ) )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( player.ztron.var_a4c2f70bbc713f98 )
        {
            player notify( #"ztron_playerdumpfps" );
        }
        
        if ( var_4659d2db90ce8d11 )
        {
            player notify( #"ztron_player_dump_vehicle" );
            player ztron_camera::function_74296609ac79a40d( 0 );
            player ztron_camera::function_493424525b419e28( 75 );
            player ztron_camera::function_a13b43697fdb6f43( 0 );
            player allowwalljump( 1 );
            player val::reset_all( "eggxit" );
        }
        else
        {
            player ztron_camera::function_79d64be315aa51c9( 0 );
            player function_a9fcba03ce590d94();
        }
        
        player ztron_camera::function_e53bf7020d2f155d( var_4659d2db90ce8d11 ? 0 : 3 );
        
        if ( !var_4659d2db90ce8d11 || !level.ztron.var_74a3707334cfe144 )
        {
            player val::set( "topdowncamera", "allow_jump", !var_4659d2db90ce8d11 );
            player val::set( "topdowncamera", "crouch", !var_4659d2db90ce8d11 );
            player val::set( "topdowncamera", "sprint", 0 );
        }
        
        player.ztron.var_8a46e28ad02229a8 = 0;
        
        if ( var_4659d2db90ce8d11 )
        {
            player setjumpheightscale( 1 );
            continue;
        }
        
        player setjumpheightscale( 4 );
    }
    
    level ztron_camera::function_672265518094104d( !var_4659d2db90ce8d11 );
}

// Namespace namespace_586743fe9d26feaa
// Params 1, eflags: 0x4
// Checksum 0x96bb504, Offset: 0x16a3
// Size: 0x206
function private function_f4c3dd8c0480fc68( room )
{
    result = level utility::waittill_any_return( "bonus_room_expired", "ztron_game_is_over" );
    level.ztron.var_e65fc3d0de638a87 = undefined;
    level.ztron.var_eada0e62460405c1 = undefined;
    level.var_8972cc8b6869f399 = 0;
    ztron_ui::function_f5177e090dadd8f4( 0 );
    utility::registersharedfunc( #"motorcycle", #"used", undefined );
    room.var_4b936b352886bbc4 = undefined;
    room.playercatched = undefined;
    function_8856bcbd9ae9745c( room, 1 );
    
    foreach ( cameratrigger in room.cameratriggers )
    {
        cameratrigger notify( #"deactivate" );
    }
    
    if ( isdefined( room.roomblocker.scriptable ) )
    {
        room.roomblocker.scriptable freescriptable();
        room.roomblocker.scriptable = undefined;
    }
    
    level notify( #"slayermart_cleanup" );
    
    if ( !level.ztron.var_95d8c7a469393957 )
    {
        foreach ( player in level.players )
        {
            player ztron_ui::function_f7e6c4641e827bf8( 0 );
        }
    }
    
    level thread function_50e37dde6d95970( room );
}

// Namespace namespace_586743fe9d26feaa
// Params 1, eflags: 0xc
// Checksum 0x5e310b24, Offset: 0x18b1
// Size: 0x52
function private function_50e37dde6d95970( room )
{
    self notify( #"hash_14fef15c336aaada" );
    self endon( #"hash_14fef15c336aaada" );
    level endon( #"ztron_game_is_over" );
    level waittill( #"round_begin_warm_up" );
    wait 0.1;
    setdvar( @"walljump_enabled", 0 );
}

// Namespace namespace_586743fe9d26feaa
// Params 1, eflags: 0x4
// Checksum 0x1e636ab3, Offset: 0x190b
// Size: 0x87
function private function_8be1b6b63593c4bf( room )
{
    foreach ( cameratrigger in room.cameratriggers )
    {
        cameratrigger thread function_83b8eed6829f4dba();
    }
}

// Namespace namespace_586743fe9d26feaa
// Params 0
// Checksum 0x5a8668b2, Offset: 0x199a
// Size: 0x2e5
function function_83b8eed6829f4dba()
{
    self endon( #"deactivate" );
    self triggerenable();
    thread function_dddc96442c90ad3c();
    params = strtok( self.script_parameters, ";" );
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( ent vehicle::is_vehicle() )
        {
            ent = ent.owner;
        }
        
        if ( !isplayer( ent ) )
        {
            continue;
        }
        
        if ( params[ 0 ] == "top_down" )
        {
            if ( ent.ztron.var_a4c2f70bbc713f98 )
            {
                ent notify( #"ztron_playerdumpfps", { #clearforced:1 } );
                waittillframeend();
            }
            
            ent ztron_camera::function_e53bf7020d2f155d( 0 );
            ent val::set( "topdowncamera", "allow_jump", 0 );
            ent val::set( "topdowncamera", "crouch", 0 );
            ent val::set( "topdowncamera", "sprint", 0 );
            ent allowwalljump( 0 );
            ent.ztron.var_8a46e28ad02229a8 = 0;
            continue;
        }
        
        if ( params[ 0 ] == "fps" )
        {
            if ( !ent.ztron.var_a4c2f70bbc713f98 )
            {
                ent setplayerangles( self.angles );
                ent ztron_camera::function_4cb0fb44c3e8f6ed( -1, 1, 1 );
                ent val::set( "topdowncamera", "allow_jump", 1 );
                ent val::set( "topdowncamera", "crouch", 1 );
                ent val::set( "topdowncamera", "sprint", 1 );
                ent allowwalljump( 0 );
            }
            
            continue;
        }
        
        if ( params[ 0 ] == "tps" )
        {
            if ( ent.ztron.var_a4c2f70bbc713f98 )
            {
                ent notify( #"ztron_playerdumpfps", { #clearforced:1 } );
                waittillframeend();
            }
            
            yaw = params[ 1 ] ? int( params[ 1 ] ) : 0;
            pitch = params[ 2 ] ? int( params[ 2 ] ) : 0;
            zoffset = params[ 3 ] ? int( params[ 3 ] ) : 0;
            needreset = params[ 4 ] == "true";
            ent ztron_camera::function_74296609ac79a40d( yaw );
            ent ztron_camera::function_493424525b419e28( pitch );
            ent ztron_camera::function_a13b43697fdb6f43( zoffset );
            ent val::set( "topdowncamera", "allow_jump", 1 );
            ent val::set( "topdowncamera", "crouch", 1 );
            ent val::set( "topdowncamera", "sprint", 0 );
            ent allowwalljump( 1 );
            ent.ztron.var_8a46e28ad02229a8 = 0;
            
            if ( needreset )
            {
                ent thread function_10d704bb257d5ed2( self );
            }
        }
    }
}

// Namespace namespace_586743fe9d26feaa
// Params 1, eflags: 0xc
// Checksum 0x26958d79, Offset: 0x1c87
// Size: 0x4d
function private function_10d704bb257d5ed2( trigger )
{
    self notify( #"hash_3a5d00749d67020" );
    self endon( #"hash_3a5d00749d67020" );
    
    while ( true )
    {
        if ( !self istouching( trigger ) || !trigger function_b0b72d20769d0233() )
        {
            function_a9fcba03ce590d94();
            break;
        }
        
        waitframe();
    }
}

// Namespace namespace_586743fe9d26feaa
// Params 0, eflags: 0x4
// Checksum 0x5a4f36d1, Offset: 0x1cdc
// Size: 0x15
function private function_dddc96442c90ad3c()
{
    self waittill( #"deactivate" );
    self triggerdisable();
}

// Namespace namespace_586743fe9d26feaa
// Params 0, eflags: 0x4
// Checksum 0x13b18cbb, Offset: 0x1cf9
// Size: 0x5c
function private function_a9fcba03ce590d94()
{
    ztron_camera::function_74296609ac79a40d( 0 );
    ztron_camera::function_493424525b419e28( 15 );
    ztron_camera::function_a13b43697fdb6f43( 72 );
    val::set( "topdowncamera", "allow_jump", 1 );
    val::set( "topdowncamera", "crouch", 1 );
    val::set( "topdowncamera", "sprint", 0 );
    self allowwalljump( 1 );
}

/#

    // Namespace namespace_586743fe9d26feaa
    // Params 0
    // Checksum 0x23cc79d3, Offset: 0x1d5d
    // Size: 0xe4, Type: dev
    function function_991cbe8249052eb()
    {
        room = level.ztron.var_8a9067aa4cd65369;
        
        if ( room.motorspots )
        {
            spot = room.motorspots[ 0 ];
            
            foreach ( player in level.players )
            {
                player thread ztron_util::teleport_player( spot.origin + ( 100, 100, 0 ), spot.angles );
            }
        }
    }

    // Namespace namespace_586743fe9d26feaa
    // Params 0
    // Checksum 0xf248d0c0, Offset: 0x1e49
    // Size: 0xec, Type: dev
    function function_506985a5d8edf91a()
    {
        room = level.ztron.var_8a9067aa4cd65369;
        
        if ( room.playersstarts )
        {
            foreach ( player in level.players )
            {
                idx = player.sessionuimemberindex;
                playerstart = room.playersstarts[ idx ];
                player thread ztron_util::teleport_player( playerstart.origin, playerstart.angles );
            }
        }
    }

    // Namespace namespace_586743fe9d26feaa
    // Params 0
    // Checksum 0xd45e10e3, Offset: 0x1f3d
    // Size: 0x6d, Type: dev
    function function_ac7ee3673d6e340d()
    {
        categoryname = ztron_bonus_room::function_26fbf99313eff547( "<dev string:x24>" );
        devgui::function_9082edeb5db93280( "<dev string:x2b>" );
        devgui::add_devgui_func( "<dev string:x3f>" + categoryname + "<dev string:x4f>", "<dev string:x6a>", &function_991cbe8249052eb );
        devgui::add_devgui_func( "<dev string:x3f>" + categoryname + "<dev string:x8a>", "<dev string:xa4>", &function_506985a5d8edf91a );
        devgui::function_77df7fe7dd273e10();
    }

#/
