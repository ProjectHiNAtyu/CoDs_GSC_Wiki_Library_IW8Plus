// script_3b8234f2e17b5beb  (hash_3b8234f2e17b5beb.gscc) (size: 21441 Bytes / 0x53c1 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x33362128 (859185448)
// size ...... 21441 (0x53c1)
// includes .. 17  (offset: 0x4f59)
// strings ... 60  (offset: 0x4fe1)
// dev strs .. 13  (offset: 0x5315)
// exports ... 65  (offset: 0x31b1)
// cseg ...... 0x56c + 0x2c45 (0x31b1)
// imports ... 167 (offset: 0x3bd9)
// animtree1 . 0   (offset: 0x53c1)
// animtree2 . 0   (offset: 0x53c1)
#using script_31ee2a173f3499b7;
#using script_4610d4deaba537e;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\mp\zm\ztron\ztron_bonus_room;
#using scripts\mp\zm\ztron\ztron_camera;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_enemy;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;
#using scripts\mp\zm\ztron\ztron_vfx;

#namespace ztron_bonus_room_racing;

// Namespace ztron_bonus_room_racing
// Params 0, eflags: 0x5
// Checksum 0x4af62ae7, Offset: 0x58a
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"ztron_bonus_room_racing", undefined, undefined, &init );
}

// Namespace ztron_bonus_room_racing
// Params 0
// Checksum 0x7fc5c1d9, Offset: 0x5ab
// Size: 0x9
function init()
{
    thread initracing();
}

// Namespace ztron_bonus_room_racing
// Params 0
// Checksum 0xd91b9aa6, Offset: 0x5bc
// Size: 0xed
function initracing()
{
    level utility::flag_wait( "ztron_bonus_room_initialized" );
    var_a8d8980c65b4b0de = ztron_bonus_room::function_98dedbfc79dc3572( "racing" );
    
    if ( var_a8d8980c65b4b0de.size > 0 )
    {
        foreach ( room in var_a8d8980c65b4b0de )
        {
            room function_a694d688d7c0d5fe();
        }
    }
    
    ztron_sound::function_4ac735395b173fe( "race_lose", "evt_ztron_moto_lose" );
    ztron_sound::function_4ac735395b173fe( "race_win", "evt_ztron_moto_lose" );
    utility::add_fx( "ztron_racing_finish_sparkler", "vfx_sat_zm_racing_fireworks_sparklers_ztron" );
    utility::add_fx( "ztron_racing_finish_firework", "vfx_sat_zm_racing_shooting_fireworks_ztron" );
    
    /#
        level thread function_ac7ee3673d6e340d();
    #/
}

// Namespace ztron_bonus_room_racing
// Params 1, eflags: 0x4
// Checksum 0x70c3436e, Offset: 0x6b1
// Size: 0x35
function private function_b8ca4a67e46eaaa6( mode )
{
    switch ( mode )
    {
        case 6:
            return 0.2;
        default:
            return;
    }
}

// Namespace ztron_bonus_room_racing
// Params 1, eflags: 0x4
// Checksum 0x3a725f9, Offset: 0x6ee
// Size: 0x33
function private function_903ad0895928478e( mode )
{
    switch ( mode )
    {
        case 6:
            return 1450;
        default:
            return;
    }
}

// Namespace ztron_bonus_room_racing
// Params 0
// Checksum 0x5cc0a1da, Offset: 0x729
// Size: 0x3d
function getmaxlaps()
{
    if ( level.players.size > 1 )
    {
        return self.config.var_308dd2cb207f117f;
    }
    
    return self.config.maxlaps;
}

// Namespace ztron_bonus_room_racing
// Params 0
// Checksum 0x4bbb468e, Offset: 0x76e
// Size: 0x3d
function getmaxtime()
{
    if ( level.players.size > 1 )
    {
        return self.config.maxtimemulti;
    }
    
    return self.config.maxtime;
}

// Namespace ztron_bonus_room_racing
// Params 0
// Checksum 0x42871110, Offset: 0x7b3
// Size: 0x2c7
function function_a694d688d7c0d5fe()
{
    self.checkpoints = [];
    
    for ( checkpointidx = 1; true ; checkpointidx++ )
    {
        trigger = ztron_util::function_95ca81ff822c3de4( "bonus_" + self.name + "_checkpoint_" + checkpointidx, #targetname );
        
        if ( !isdefined( trigger ) )
        {
            break;
        }
        
        self.checkpoints[ self.checkpoints.size ] = trigger;
    }
    
    self.deceleratetriggers = ztron_util::function_2d9de5c7b97db39( "bouns_" + self.name + "_trigger_decelerate", #targetname );
    self.enemyspawns = utility::getstructarray( self.name + "_enemy_spawn", "targetname" );
    self.var_cc880e54222672c2 = utility::getstructarray( "bonus_" + self.name + "_pickup_lap", "targetname" );
    self.var_117137ae9dce540c = ztron_enemy::function_96eea0d09d5640d1( "riser_zombie" );
    self.var_1cc61434ff08a13e = getdvarfloat( @"hash_f09ab43897541ef5", 15 );
    self.notimeout = 1;
    self.var_7ea107d140fc9891 = 1;
    self.var_6b2a50c8a5ac28ec = getdvarfloat( @"hash_887b901d05c89a4e", 0.5 ) * 1000;
    self.setupcallback = &racingsetup;
    self.var_d822af3942fcbc3d = &function_df7c238a227306;
    function_f24881c00f3afc0f( "basic_zombie", 50 );
    level thread function_93906a8ed9c0d6f8();
    
    if ( self.name == "racing2" )
    {
        self.config = { #playerkeybinding:#"racing_motor", #maxtimemulti:getdvarint( @"hash_dc18f4097ea9f4dc", 115 ), #maxtime:getdvarint( @"hash_c1940c497c905c06", 135 ), #var_308dd2cb207f117f:getdvarint( @"hash_7c1f81d8588fe6d3", 3 ), #maxlaps:getdvarint( @"hash_f2b0b07de297d559", 3 ), #forcecamera:2 };
        return;
    }
    
    var_8d64eaf484601d1f = getdvarint( @"hash_12202845e7a09a61", 0 ) == 1 ? #"racing_fps" : #"racing";
    self.config = { #playerkeybinding:var_8d64eaf484601d1f, #maxtimemulti:getdvarint( @"hash_c2c8a9a07fb4e0dc", 65 ), #maxtime:getdvarint( @"hash_2421421f4bc6a806", 85 ), #var_308dd2cb207f117f:getdvarint( @"hash_62cf376f599ad2d3", 5 ), #maxlaps:getdvarint( @"hash_553de653b1ce2159", 5 ) };
}

// Namespace ztron_bonus_room_racing
// Params 2
// Checksum 0x486984f, Offset: 0xa82
// Size: 0x6e
function function_f24881c00f3afc0f( name, weight )
{
    if ( !isdefined( self.aidefs ) )
    {
        self.aidefs = [];
    }
    
    aidef = spawnstruct();
    aidef.name = name;
    aidef.weight = weight;
    self.aidefs[ self.aidefs.size ] = aidef;
}

// Namespace ztron_bonus_room_racing
// Params 0
// Checksum 0x4fcc7085, Offset: 0xaf8
// Size: 0x58
function function_efda273ce793e5e8()
{
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( isent( ent ) && self function_b0b72d20769d0233() )
        {
            if ( isplayer( ent ) )
            {
                return ent;
            }
            
            if ( ent vehicle::is_vehicle() )
            {
                return ent.owner;
            }
        }
    }
}

// Namespace ztron_bonus_room_racing
// Params 0
// Checksum 0xf143bbe0, Offset: 0xb58
// Size: 0x9f
function function_d79cecd86fe9aca9()
{
    self notify( #"hash_c1125608125da5e" );
    self endon( #"hash_c1125608125da5e" );
    room = self;
    
    foreach ( player in level.players )
    {
        player thread function_c26e438adcc633cb( room );
    }
}

// Namespace ztron_bonus_room_racing
// Params 1
// Checksum 0x5fd20882, Offset: 0xbff
// Size: 0x3d
function function_2db667aebb5ce8b0( checkpointidx = 1 )
{
    if ( checkpointidx > 0 && checkpointidx <= self.checkpoints.size )
    {
        return self.checkpoints[ checkpointidx - 1 ];
    }
}

// Namespace ztron_bonus_room_racing
// Params 1
// Checksum 0x4455f9d2, Offset: 0xc45
// Size: 0xdb
function function_c26e438adcc633cb( room )
{
    self notify( #"hash_22741b669929ada4" );
    self endon( #"hash_22741b669929ada4" );
    level endon( #"bonus_room_expired", #"bonus_room_exit_taken" );
    self endon( #"racing_finished", #"death_or_disconnect" );
    checkpointidx = 1;
    
    for ( trigger = room function_2db667aebb5ce8b0( checkpointidx ); trigger ; trigger = room function_2db667aebb5ce8b0( checkpointidx ) )
    {
        trigger triggerenable();
        player = trigger function_efda273ce793e5e8();
        
        if ( player == self )
        {
            var_6b95443a076acf83 = checkpointidx == room.checkpoints.size;
            
            if ( var_6b95443a076acf83 )
            {
                checkpointidx = 1;
                level notify( #"hash_80159d2dceecdcaa", self );
                continue;
            }
            
            checkpointidx += 1;
        }
    }
}

// Namespace ztron_bonus_room_racing
// Params 0
// Checksum 0x179bb231, Offset: 0xd28
// Size: 0x10
function function_f22bdc4ea8b3151d()
{
    thread function_894a1475a4cf32a7();
    thread function_98d6b09d2f701a49();
}

// Namespace ztron_bonus_room_racing
// Params 0
// Checksum 0x74300f59, Offset: 0xd40
// Size: 0x1a0
function function_894a1475a4cf32a7()
{
    while ( true )
    {
        self waittill( #"hash_cd4b7e27f519c92" );
        var_ba91c5e2711c9c23 = self.lapsfinished + 1 == self.maxlaps;
        
        if ( var_ba91c5e2711c9c23 )
        {
            wait 5;
            fxarr = [];
            var_5609d54fd64109b2 = utility::getstructarray( "bonus_" + self.name + "_firework_slope", "targetname" );
            
            foreach ( spot in var_5609d54fd64109b2 )
            {
                fx = ztron_vfx::function_574a3236c59da7d8( "ztron_racing_finish_sparkler", spot.origin );
                fx thread ztron_util::function_36239518d8da65f0( level, "bonus_room_completed" );
                fxarr[ fxarr.size ] = fx;
            }
            
            self waittill( #"racing_finished", reason );
            
            if ( reason != "complete" )
            {
                foreach ( fx in fxarr )
                {
                    ztron_vfx::function_4abb26b271676888( fx );
                }
            }
            
            break;
        }
    }
}

// Namespace ztron_bonus_room_racing
// Params 0
// Checksum 0xd28b99b2, Offset: 0xee8
// Size: 0xf8
function function_98d6b09d2f701a49()
{
    self waittill( #"racing_finished", reason );
    
    if ( reason == "complete" )
    {
        fxarr = [];
        var_235968c1a230fc55 = utility::getstructarray( "bonus_" + self.name + "_firework_end", "targetname" );
        
        foreach ( spot in var_235968c1a230fc55 )
        {
            fx = ztron_vfx::function_574a3236c59da7d8( "ztron_racing_finish_firework", spot.origin );
            fx thread ztron_util::function_36239518d8da65f0( level, "bonus_room_completed" );
            fxarr[ fxarr.size ] = fx;
        }
    }
}

// Namespace ztron_bonus_room_racing
// Params 1
// Checksum 0xf51bc917, Offset: 0xfe8
// Size: 0x68
function racingend( reason )
{
    self notify( #"hash_7ee0abeb669afd22" );
    self endon( #"hash_7ee0abeb669afd22" );
    ztron_ui::function_9e17b295214b44f6();
    self notify( #"racing_finished", reason );
    ztron_util::killallenemies();
    
    if ( reason == "complete" )
    {
        wait 2;
    }
    
    level thread ztron_item::function_25f69b2b896fd56();
    wait 10;
    self notify( #"room_done" );
}

// Namespace ztron_bonus_room_racing
// Params 0
// Checksum 0x1c3be618, Offset: 0x1058
// Size: 0x166
function racingranking()
{
    level endon( #"bonus_room_expired" );
    level endon( #"bonus_room_exit_taken" );
    self endon( #"racing_finished" );
    var_6f6b352605192da8 = getdvarint( @"hash_1d4dba36bfcaca1a", 1 );
    var_6060c4b5870217c6 = [];
    
    while ( true )
    {
        level waittill( #"hash_80159d2dceecdcaa", player );
        player playsound( "evt_ztron_moto_lap_complete" );
        player function_4a181a7d350c37a6( self );
        player function_e43c9d934f4e2372( var_6f6b352605192da8 );
        
        if ( player.ztron.lapscount > self.lapsfinished )
        {
            self.lapsfinished = player.ztron.lapscount;
            self notify( #"hash_cd4b7e27f519c92" );
            function_c58c62ed2d45a66a( self.lapsfinished, self.maxlaps );
        }
        
        if ( !var_6060c4b5870217c6[ self.lapsfinished ] )
        {
            function_cd5774363154c247( getdvarint( @"hash_84c35813e76776b4", 4 ) );
            var_6060c4b5870217c6[ self.lapsfinished ] = 1;
        }
        
        if ( self.lapsfinished >= self.maxlaps )
        {
            ztron_sound::ztron_playsound( "race_win" );
            thread function_66e839ff0d760b56( player );
            thread function_738dba8133e3697c( player );
            thread racingend( "complete" );
            break;
        }
    }
}

// Namespace ztron_bonus_room_racing
// Params 2
// Checksum 0x9c7de57, Offset: 0x11c6
// Size: 0x168
function function_bd3a5142e2a2e9d6( enemyspot, chance = 30 )
{
    level endon( #"bonus_room_expired" );
    level endon( #"bonus_room_exit_taken" );
    self endon( #"racing_finished" );
    ignoreallchance = getdvarint( @"hash_62ca61192f4b2e17", 50 );
    
    while ( true )
    {
        wait randomfloatrange( 5, 10 );
        function_a826c35ecc42c6f4( enemyspot );
        aitypedef = self.var_117137ae9dce540c;
        
        if ( !isdefined( aitypedef ) )
        {
            continue;
        }
        
        roll = randomint( 100 );
        currentenemy = ztron_util::function_cdd411b0cc1f9d80().size;
        
        if ( currentenemy >= self.var_1cc61434ff08a13e )
        {
            continue;
        }
        
        if ( roll < chance )
        {
            ztron_debug::debugmsg( "spawnEnemyAtSpot " + enemyspot.var_a627b2efd7f2bc9c );
            ai = ztron_enemy::function_acee91c445fafd29( aitypedef, enemyspot.origin, undefined, undefined, 1, 1 );
            
            if ( isdefined( ai ) )
            {
                ai.var_c837be1b82645ee5 = 1;
                ai.var_d910b0444df26d0a = ( 0, 0, 64 );
                ai.var_d1da80fea1e9d5b7 = 80000;
                ai.ignoreall = randomint( 100 ) < ignoreallchance;
                ai animmode( "normal" );
            }
        }
    }
}

// Namespace ztron_bonus_room_racing
// Params 1
// Checksum 0x83b52d94, Offset: 0x1336
// Size: 0x149
function function_a826c35ecc42c6f4( enemyspot )
{
    totalweight = 0;
    
    foreach ( aidef in self.aidefs )
    {
        totalweight += aidef.weight;
    }
    
    randweight = randomint( totalweight );
    sumweight = 0;
    
    foreach ( aidef in self.aidefs )
    {
        sumweight += aidef.weight;
        
        if ( randweight <= sumweight )
        {
            enemyspot.var_a627b2efd7f2bc9c = aidef.name;
            break;
        }
    }
}

// Namespace ztron_bonus_room_racing
// Params 0
// Checksum 0xe8088a49, Offset: 0x1487
// Size: 0xac
function function_eefa07785c38ef3d()
{
    level endon( #"bonus_room_expired" );
    level endon( #"bonus_room_exit_taken" );
    self endon( #"racing_finished" );
    self waittill( #"hash_cd4b7e27f519c92" );
    
    foreach ( enemyspot in self.enemyspawns )
    {
        thread function_bd3a5142e2a2e9d6( enemyspot );
    }
}

// Namespace ztron_bonus_room_racing
// Params 0
// Checksum 0x8e90b85d, Offset: 0x153b
// Size: 0x10d
function function_cfae50a88e8c42f5()
{
    level endon( #"bonus_room_expired" );
    level endon( #"bonus_room_exit_taken" );
    self endon( #"racing_finished" );
    level waittill( #"hash_a41416bce603e07" );
    var_8260f0f996dc9927 = self.var_cc880e54222672c2;
    
    foreach ( point in var_8260f0f996dc9927 )
    {
        ref = point.script_label;
        
        if ( issubstr( ref, "gem" ) )
        {
            point.itemscale = 2;
        }
    }
    
    ztron_item::function_6607be6e510e8f54( var_8260f0f996dc9927 );
    
    while ( true )
    {
        self waittill( #"hash_cd4b7e27f519c92" );
        wait 5;
        ztron_item::function_6607be6e510e8f54( var_8260f0f996dc9927 );
    }
}

// Namespace ztron_bonus_room_racing
// Params 1
// Checksum 0x6ba676d6, Offset: 0x1650
// Size: 0xd0
function function_66e839ff0d760b56( player )
{
    player endon( #"disconnect" );
    player waittill( #"round_begin" );
    player.ztron.var_5ef717c9a93891c3 = 1;
    item = player ztron_item::function_d2dd7af394ebdbdd( "scripted_weapon_sat_lm_ztronjetgun" );
    item utility::waittill_any( "item_bombed", "death" );
    player utility::waittill_any_timeout( 0.5, "new_weapon_pack" );
    player.ztron.default_weapon_bundle = %"hash_7b269d83e9f2bfac";
    player thread ztron_player_utility::resetdefaultweapon( "round_over" );
    player waittill( #"round_over" );
    player.ztron.var_5ef717c9a93891c3 = 0;
}

// Namespace ztron_bonus_room_racing
// Params 0
// Checksum 0xea99a733, Offset: 0x1728
// Size: 0xec
function function_93906a8ed9c0d6f8()
{
    self notify( #"hash_710a14d3e7c5ae25" );
    self endon( #"hash_710a14d3e7c5ae25" );
    level endon( #"bonus_room_expired" );
    level endon( #"bonus_room_exit_taken" );
    level.ztron.var_ba63d1919e189979 = [ 0, 0, 0, 0, 0, 0 ];
    assert( level.ztron.var_ba63d1919e189979.size == 6 );
    idx = 0;
    lastkill = 0;
    
    while ( true )
    {
        level waittill( #"hash_a5e05e14886b4ce3" );
        timecur = gettime();
        level.ztron.var_ba63d1919e189979[ idx ] = ( timecur - lastkill ) / 1000;
        lastkill = timecur;
        idx = ( idx + 1 ) % 6;
    }
}

// Namespace ztron_bonus_room_racing
// Params 0
// Checksum 0x7b6c8343, Offset: 0x181c
// Size: 0x9a, Type: bool
function function_2d0e72355efa5110()
{
    var_ac0a4814166d8fe5 = 0;
    var_d29ad8be341522be = 0;
    
    for ( i = 0; i < 6 ; i++ )
    {
        if ( level.ztron.var_ba63d1919e189979[ i ] > 0 )
        {
            var_d29ad8be341522be += level.ztron.var_ba63d1919e189979[ i ];
            var_ac0a4814166d8fe5++;
        }
    }
    
    if ( var_ac0a4814166d8fe5 == 0 )
    {
        return true;
    }
    
    avg = var_d29ad8be341522be / var_ac0a4814166d8fe5;
    ztron_debug::debugmsg( "Redins Clock Credit avg is:" + avg );
    return avg > 2.5;
}

// Namespace ztron_bonus_room_racing
// Params 1
// Checksum 0x2977f9e0, Offset: 0x18bf
// Size: 0x103
function function_6ed4bb386145f46( params )
{
    playerattacker = ztron_util::function_da4039e4c338f818( params.eattacker );
    
    if ( isdefined( playerattacker ) )
    {
        playerattacker function_1ad422387c987de4();
        playerattacker function_e43c9d934f4e2372( getdvarint( @"hash_5a76c996a7068d39", 1 ) );
        room = level.ztron.var_8a9067aa4cd65369;
        
        if ( isdefined( room ) )
        {
            level notify( #"hash_a5e05e14886b4ce3" );
            waittillframeend();
            ztron_debug::debugmsg( "AI was run over" );
            
            if ( function_2d0e72355efa5110() )
            {
                room function_cd5774363154c247( getdvarint( @"hash_b85bf39310657a34", 1 ) );
                ztron_debug::debugmsg( "Redins Clock time bonus was given" );
            }
            else
            {
                ztron_debug::debugmsg( "Redins Clock time bonus was NOT given" );
            }
            
            if ( room.var_e68a8c489de53202 > 0 )
            {
                thread function_4c047b50a640febf( self.origin );
                room.var_e68a8c489de53202--;
                return;
            }
            
            ztron_debug::debugmsg( "Coin drop skipped due to too many coins being pulled from AI" );
        }
    }
}

// Namespace ztron_bonus_room_racing
// Params 1
// Checksum 0xdd023c36, Offset: 0x19ca
// Size: 0x1a1
function function_3b65527f0d644808( room )
{
    level endon( #"bonus_room_expired" );
    level endon( #"bonus_room_exit_taken" );
    room endon( #"racing_finished" );
    self.ztron.var_3d071c4fb28f7921 = 0;
    
    while ( true )
    {
        vehicle = self.ztron.vehicle;
        
        if ( isdefined( vehicle ) )
        {
            var_3d071c4fb28f7921 = 0;
            
            foreach ( decelerateTrigger in room.deceleratetriggers )
            {
                if ( vehicle istouching( decelerateTrigger ) )
                {
                    var_3d071c4fb28f7921 = 1;
                    break;
                }
            }
            
            if ( self.ztron.var_3d071c4fb28f7921 != var_3d071c4fb28f7921 )
            {
                self.ztron.var_3d071c4fb28f7921 = var_3d071c4fb28f7921;
                var_d1cd6c2d8086cdb = "decelerateTrigger";
                
                if ( var_3d071c4fb28f7921 )
                {
                    vehicle notify( #"interupt_change_speed" );
                    utility::ent_flag_init( "vehicle_change_speed" );
                    vehicle thread ztron_util::function_5bd5e2f5c01a2138( getdvarfloat( @"hash_4b6266e48525ccaf", 0.4 ), 1, var_d1cd6c2d8086cdb );
                }
                else if ( !utility::ent_flag( "vehicle_change_speed" ) )
                {
                    vehicle thread ztron_util::function_5bd5e2f5c01a2138( undefined, 0.5, var_d1cd6c2d8086cdb );
                }
            }
        }
        
        waitframe();
    }
}

// Namespace ztron_bonus_room_racing
// Params 0
// Checksum 0x38a23a0b, Offset: 0x1b73
// Size: 0x7c
function function_25af042b108dbe76()
{
    foreach ( player in level.players )
    {
        player thread function_3b65527f0d644808( self );
    }
}

// Namespace ztron_bonus_room_racing
// Params 1
// Checksum 0x4d18dcae, Offset: 0x1bf7
// Size: 0x1c8
function racinggameplay( room )
{
    level endon( #"bonus_room_expired" );
    level endon( #"bonus_room_exit_taken" );
    room endon( #"racing_finished" );
    var_fff481de2cd633f2 = 10;
    room.racingstart = 0;
    
    /#
        var_fff481de2cd633f2 = getdvarfloat( @"hash_8c0e32744fdd13a4", 10 );
    #/
    
    wait var_fff481de2cd633f2;
    
    if ( !room.config.forcecamera && !( getdvarint( @"hash_12202845e7a09a61", 0 ) == 1 ) )
    {
        level thread ztron_ui::function_6e791be3702fa2a8( "CAMERA_HINT", 0, 10, 1 );
    }
    
    level thread ztron_ui::function_96897bdfbaa6298b();
    wait 3;
    ztron_ui::function_d03865600d43ade();
    room.racingstart = 1;
    
    foreach ( player in level.players )
    {
        player ztron_util::fade_in();
    }
    
    room notify( #"hash_81db7678101ed9de" );
    room.var_5aaac6ae7212dcf9 = gettime();
    room function_cd5774363154c247();
    
    while ( true )
    {
        wait 1;
        curtime = gettime();
        endtime = room function_41d8c7d2489f3868();
        
        if ( curtime >= endtime )
        {
            ztron_sound::ztron_playsound( "race_lose" );
            ztron_ui::function_37aad40e39a9fdfe( "racing_failed" );
            room thread racingend( "timeout" );
            break;
        }
    }
}

// Namespace ztron_bonus_room_racing
// Params 1
// Checksum 0x7980e0ae, Offset: 0x1dc7
// Size: 0x177
function racingsetup( room )
{
    level.ztron.var_bcfb9c8ab89ea6e6 = &ztron_ui::function_767b331f1efd12c9;
    level.ztron.var_51d579634a79a25d = &function_f7a0d2fd496882ba;
    
    if ( room.name == "racing2" )
    {
        level.ztron.var_465e06d2221e50da = &function_b8ca4a67e46eaaa6;
        level.ztron.var_c8e8ffbf87a3fba = &function_903ad0895928478e;
    }
    
    room.maxlaps = room getmaxlaps();
    room.maxtime = room getmaxtime();
    room.var_5aaac6ae7212dcf9 = 0;
    room.timebonus = 0;
    room.lapsfinished = 0;
    room.var_76a1c6d566d98aed = 1;
    room thread function_25af042b108dbe76();
    room thread function_d79cecd86fe9aca9();
    room thread racingranking();
    room thread function_cfae50a88e8c42f5();
    room thread function_eefa07785c38ef3d();
    room thread function_f22bdc4ea8b3151d();
    level thread racingcleanup( room );
    level callback::add( "on_zombie_ai_killed", &function_6ed4bb386145f46 );
    level function_dd7e1d9564b05fb6( room );
    ztron_ui::function_4f292e068db3b5ab();
    ztron_ui::function_47fba147a5ea5291( room.config.playerkeybinding );
    level waittill( #"hash_9d2492f7742c7564" );
    level thread racinggameplay( room );
}

// Namespace ztron_bonus_room_racing
// Params 1
// Checksum 0x1440c27a, Offset: 0x1f46
// Size: 0xf7
function racingcleanup( room )
{
    result = level utility::waittill_any_return( "bonus_room_expired", "ztron_game_is_over", "bonus_room_exit_taken" );
    room.var_5aaac6ae7212dcf9 = 0;
    level.ztron.var_bcfb9c8ab89ea6e6 = undefined;
    level.ztron.var_ccad830a7a66e349 = undefined;
    level.ztron.var_51d579634a79a25d = undefined;
    level.ztron.var_465e06d2221e50da = undefined;
    level.ztron.var_c8e8ffbf87a3fba = undefined;
    function_6c5f1efdb7e097f7();
    ztron_ui::function_44e8216813f94f57();
    ztron_ui::function_f07e07779189a689();
    level callback::remove( "on_zombie_ai_killed", &function_6ed4bb386145f46 );
    
    if ( isdefined( self.clifftrigger ) )
    {
        self.clifftrigger triggerdisable();
    }
    
    if ( isdefined( self.finishtrigger ) )
    {
        self.finishtrigger triggerdisable();
    }
}

// Namespace ztron_bonus_room_racing
// Params 1
// Checksum 0x5eab1bba, Offset: 0x2045
// Size: 0x10d
function function_ee38de75db3e903e( room )
{
    self notify( #"hash_751999e66974c986" );
    self endon( #"hash_751999e66974c986" );
    
    if ( isbot( self ) )
    {
        return;
    }
    
    level endon( #"bonus_room_expired" );
    level endon( #"bonus_room_exit_taken" );
    room endon( #"racing_finished" );
    player = self;
    player notifyonplayercommand( "ztron_racing_input_switch_camera", "+weapnext" );
    
    if ( !isdefined( player.ztron.var_a2ffbb8c10b1bfe0 ) )
    {
        player.ztron.var_a2ffbb8c10b1bfe0 = 0;
    }
    
    while ( true )
    {
        player waittill( #"ztron_racing_input_switch_camera" );
        currenttime = gettime();
        
        if ( currenttime - player.ztron.var_a2ffbb8c10b1bfe0 > room.var_6b2a50c8a5ac28ec )
        {
            player.ztron.var_a2ffbb8c10b1bfe0 = currenttime;
            player function_d326597589d919cb( room );
        }
        
        waitframe();
    }
}

// Namespace ztron_bonus_room_racing
// Params 2
// Checksum 0xfeeb2067, Offset: 0x215a
// Size: 0x110
function function_d326597589d919cb( room, camera )
{
    if ( isdefined( room.config.forcecamera ) )
    {
        camera = room.config.forcecamera;
    }
    else if ( !isdefined( camera ) )
    {
        if ( !isdefined( self.ztron.racingcamera ) )
        {
            camera = 0;
        }
        else
        {
            camera = self.ztron.racingcamera + 1;
            
            if ( camera > 2 )
            {
                camera = 0;
            }
        }
    }
    
    self.ztron.racingcamera = camera;
    
    if ( camera == 0 )
    {
        ztron_camera::function_79d64be315aa51c9( 5 );
        return;
    }
    
    if ( camera == 1 )
    {
        ztron_camera::function_e53bf7020d2f155d( 4 );
        return;
    }
    
    if ( camera == 2 )
    {
        ztron_camera::function_79d64be315aa51c9( 4 );
        
        if ( self.ztron.var_6c9316880701de57 )
        {
            self.ztron.var_6c9316880701de57 = 0;
            thread function_15e447a2584c3c16();
        }
    }
}

// Namespace ztron_bonus_room_racing
// Params 0
// Checksum 0xf0145aea, Offset: 0x2272
// Size: 0x87
function function_15e447a2584c3c16()
{
    if ( !isdefined( self ) )
    {
        return;
    }
    
    playerforward = anglestoforward( self.angles );
    targetpos = self.origin + playerforward * 295 + ( 0, 0, 20 );
    var_4a7abb2df607f5ef = spawn( "script_model", targetpos );
    var_4a7abb2df607f5ef setmodel( "tag_origin" );
    self function_2c809dbea97c1579( var_4a7abb2df607f5ef );
    wait 1;
    
    if ( self )
    {
        self function_2c809dbea97c1579();
    }
    
    var_4a7abb2df607f5ef delete();
}

// Namespace ztron_bonus_room_racing
// Params 1
// Checksum 0x37c9c15f, Offset: 0x2301
// Size: 0x16
function updateinput( player )
{
    player thread function_ee38de75db3e903e( self );
}

// Namespace ztron_bonus_room_racing
// Params 14, eflags: 0x4
// Checksum 0x4d1be9e3, Offset: 0x231f
// Size: 0x81
function private vehicledamagecallback( inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid )
{
    
}

// Namespace ztron_bonus_room_racing
// Params 0, eflags: 0x4
// Checksum 0x72539ea1, Offset: 0x23a9
// Size: 0x1f
function private function_7c25e6fd0125dd67()
{
    if ( self.name == "racing2" )
    {
        return "ztron_motorcycle";
    }
    
    return "ztron_sat_firefly_pluto";
}

// Namespace ztron_bonus_room_racing
// Params 1, eflags: 0xc
// Checksum 0x55b87fbd, Offset: 0x23d1
// Size: 0x92
function private function_e32a3100b40e562( room )
{
    self notify( #"hash_82b3e5f3dc7f464f" );
    self endon( #"hash_82b3e5f3dc7f464f" );
    self endon( #"disconnect" );
    vehicleref = room function_7c25e6fd0125dd67();
    thread ztron_item::function_bdebc9f850639d13( vehicleref );
    self waittill( #"vehicle_enter", vehicle );
    self.ztron.var_6c9316880701de57 = 1;
    vehicle.damagecallback = &vehicledamagecallback;
    thread function_929a0d20e8ad318f();
}

// Namespace ztron_bonus_room_racing
// Params 0, eflags: 0xc
// Checksum 0x1c978a4a, Offset: 0x246b
// Size: 0x48
function private resetchicken()
{
    self notify( #"hash_1fd9512c2da55af1" );
    self endon( #"hash_1fd9512c2da55af1" );
    self endon( #"disconnect" );
    self endon( #"laststand" );
    self endon( #"death" );
    wait 1;
    namespace_3d206415c2287a2b::function_45920a7a5797b159();
}

// Namespace ztron_bonus_room_racing
// Params 0
// Checksum 0x81ee3e91, Offset: 0x24bb
// Size: 0x95
function function_929a0d20e8ad318f()
{
    self notify( #"hash_70d6a194c53c765d" );
    self endon( #"hash_70d6a194c53c765d" );
    vehicle = self.ztron.vehicle;
    vehicle endon( #"death", #"vehicle_exit" );
    function_3c89c110a80d86fd();
    
    while ( vehicle )
    {
        vehicle waittill( #"hash_bb79d9019a5cc3bb" );
        vehicle playsound( "evt_ztron_moto_boost_engaged" );
        function_3c89c110a80d86fd();
        
        /#
            if ( self.infinitebooster )
            {
                function_e43c9d934f4e2372();
            }
        #/
    }
}

// Namespace ztron_bonus_room_racing
// Params 1
// Checksum 0xe660cf6a, Offset: 0x2558
// Size: 0x1b4
function function_df7c238a227306( room )
{
    room.var_e68a8c489de53202 = getdvarint( @"hash_7d4040f40083170a", 50 );
    thread function_9e6261cf71706fe3( room );
    
    foreach ( player in level.players )
    {
        player val::set( "bonus_room_racing", "vehicle_exit", 0 );
        player val::set( "bonus_room_racing", "vehicle_seat_switch", 0 );
        player.ztron.var_8a46e28ad02229a8 = 1;
        player thread function_e32a3100b40e562( room );
        player thread resetchicken();
        player function_d326597589d919cb( room, 0 );
        player ztron_camera::function_1873609edbd36982();
        player.ztron.lapscount = 0;
        player.ztron.var_64b82f77cc71cbb = getdvarint( @"hash_27a87455409fb7a5", 3 );
        player.ztron.var_f1dedafb1b347117 = 0;
        player.ztron.racinggems = 0;
        player.ztron.racingcoins = 0;
        player.ztron.var_8a9067aa4cd65369 = room;
        player function_c2d179ec3b8ec13( room );
        room updateinput( player );
    }
}

// Namespace ztron_bonus_room_racing
// Params 1
// Checksum 0xe76af258, Offset: 0x2714
// Size: 0x186
function function_9e6261cf71706fe3( room )
{
    result = level utility::waittill_any_return( "bonus_room_expired", "bonus_room_exit_taken" );
    
    foreach ( player in level.players )
    {
        player val::reset_all( "bonus_room_racing" );
        player ztron_camera::function_e53bf7020d2f155d( 0 );
        player ztron_camera::function_9d2ce447580a6290();
        player notify( #"ztron_player_dump_vehicle" );
        player.ztron.racingsideview = 0;
        player.ztron.lapscount = undefined;
        player.ztron.var_f1dedafb1b347117 = undefined;
        player.ztron.var_64b82f77cc71cbb = undefined;
        player.ztron.racinggems = undefined;
        player.ztron.racingcoins = undefined;
        player.ztron.var_8a9067aa4cd65369 = undefined;
        
        if ( !isbot( player ) )
        {
            player notifyonplayercommandremove( "ztron_racing_input_booster", "+gostand" );
            player notifyonplayercommandremove( "ztron_racing_input_switch_camera", "+weapnext" );
        }
    }
}

// Namespace ztron_bonus_room_racing
// Params 2, eflags: 0x4
// Checksum 0xdb558d90, Offset: 0x28a2
// Size: 0x2b
function private function_c58c62ed2d45a66a( finishedlaps, maxlaps )
{
    if ( finishedlaps == maxlaps - 1 )
    {
        ztron_ui::function_37aad40e39a9fdfe( "racing_last_lap" );
    }
}

// Namespace ztron_bonus_room_racing
// Params 1, eflags: 0x4
// Checksum 0xd3bf2bfc, Offset: 0x28d5
// Size: 0x3f
function private function_738dba8133e3697c( winnerplayer )
{
    level endon( #"bonus_room_expired" );
    level endon( #"bonus_room_exit_taken" );
    ztron_ui::function_16f36d279c740aa( winnerplayer );
    wait 5;
    ztron_ui::function_37aad40e39a9fdfe( "racing_complete" );
}

// Namespace ztron_bonus_room_racing
// Params 1, eflags: 0x4
// Checksum 0xc77560a5, Offset: 0x291c
// Size: 0x6b
function private function_dd7e1d9564b05fb6( room )
{
    var_a9fd009c96fde6fc = {};
    var_a9fd009c96fde6fc.maxlaps = room.maxlaps;
    var_a9fd009c96fde6fc.timelimits = room.maxtime;
    var_a9fd009c96fde6fc.var_6f328661d639ec04 = getdvarint( @"hash_27a87455409fb7a5", 3 );
    ztron_ui::function_6447749c19d2e5ac( var_a9fd009c96fde6fc );
}

// Namespace ztron_bonus_room_racing
// Params 1, eflags: 0x4
// Checksum 0x13945a83, Offset: 0x298f
// Size: 0x66
function private function_c2d179ec3b8ec13( room )
{
    ztron_ui::function_f262d9b2b1d0c583( room.maxlaps - self.ztron.lapscount );
    ztron_ui::function_3ff205a35de1fb9d( self.ztron.var_f1dedafb1b347117 );
    ztron_ui::function_2c4a59567887a7dc( self.ztron.racingcoins );
}

// Namespace ztron_bonus_room_racing
// Params 2, eflags: 0x4
// Checksum 0x5bc00e44, Offset: 0x29fd
// Size: 0x85
function private function_4a181a7d350c37a6( room, finishedlaps = 1 )
{
    if ( isdefined( self.ztron.lapscount ) )
    {
        self.ztron.lapscount += finishedlaps;
        ztron_ui::function_f262d9b2b1d0c583( room.maxlaps - self.ztron.lapscount );
    }
}

// Namespace ztron_bonus_room_racing
// Params 0, eflags: 0x4
// Checksum 0x76050686, Offset: 0x2a8a
// Size: 0x40
function private function_3c89c110a80d86fd()
{
    vehicle = self.ztron.vehicle;
    
    if ( isdefined( vehicle ) )
    {
        var_879f9c6e1348316e = vehicle function_b7849eea71b4a5ef();
        ztron_ui::function_30b8cab14b533909( var_879f9c6e1348316e );
    }
}

// Namespace ztron_bonus_room_racing
// Params 1, eflags: 0x4
// Checksum 0xa24e5455, Offset: 0x2ad2
// Size: 0x85
function private function_e43c9d934f4e2372( var_d4d947f5aca423a4 = 1 )
{
    vehicle = self.ztron.vehicle;
    
    if ( isdefined( vehicle ) && var_d4d947f5aca423a4 > 0 )
    {
        var_879f9c6e1348316e = vehicle function_b7849eea71b4a5ef();
        var_879f9c6e1348316e = int( clamp( var_879f9c6e1348316e + var_d4d947f5aca423a4, 0, self.ztron.var_64b82f77cc71cbb ) );
        vehicle function_6d2086d31b79dc2b( var_879f9c6e1348316e );
        ztron_ui::function_30b8cab14b533909( var_879f9c6e1348316e );
    }
}

// Namespace ztron_bonus_room_racing
// Params 1, eflags: 0x4
// Checksum 0xc41b34bd, Offset: 0x2b5f
// Size: 0x70
function private function_1ad422387c987de4( killedinc = 1 )
{
    if ( isdefined( self.ztron.var_f1dedafb1b347117 ) )
    {
        self.ztron.var_f1dedafb1b347117 += killedinc;
        ztron_ui::function_3ff205a35de1fb9d( self.ztron.var_f1dedafb1b347117 );
    }
}

// Namespace ztron_bonus_room_racing
// Params 1, eflags: 0x4
// Checksum 0xe79d575c, Offset: 0x2bd7
// Size: 0x70
function private function_a10e79bde51fc2d1( var_f82d724e8912d0e5 = 1 )
{
    if ( isdefined( self.ztron.racinggems ) )
    {
        self.ztron.racinggems += var_f82d724e8912d0e5;
        ztron_ui::function_2c4a59567887a7dc( self.ztron.racinggems );
    }
}

// Namespace ztron_bonus_room_racing
// Params 0, eflags: 0x4
// Checksum 0x7390473b, Offset: 0x2c4f
// Size: 0x9
function private function_d32a11e7bd71f3b6()
{
    function_a10e79bde51fc2d1();
}

// Namespace ztron_bonus_room_racing
// Params 1, eflags: 0x4
// Checksum 0x19964f4e, Offset: 0x2c60
// Size: 0x70
function private function_96ab8e3b5bca3301( var_f00dce2e4ba82322 = 1 )
{
    if ( isdefined( self.ztron.racingcoins ) )
    {
        self.ztron.racingcoins += var_f00dce2e4ba82322;
        ztron_ui::function_2c4a59567887a7dc( self.ztron.racingcoins );
    }
}

// Namespace ztron_bonus_room_racing
// Params 0, eflags: 0x4
// Checksum 0xb5a872b0, Offset: 0x2cd8
// Size: 0x9
function private function_f7a0d2fd496882ba()
{
    function_a10e79bde51fc2d1();
}

// Namespace ztron_bonus_room_racing
// Params 1
// Checksum 0xcd497e19, Offset: 0x2ce9
// Size: 0x68
function function_4c047b50a640febf( spot )
{
    waittillframeend();
    pos = spot + ( 0, 0, 30 );
    spawnoptions = ztron_item::function_41854e96b8bf4a06( pos );
    qty = 1;
    ztron_item::clusteritemspawn( level.ztron.var_7833ff35a7f394ec, pos, qty, 36, spawnoptions );
}

// Namespace ztron_bonus_room_racing
// Params 0, eflags: 0x4
// Checksum 0xdae922d7, Offset: 0x2d59
// Size: 0x23
function private function_41d8c7d2489f3868()
{
    return self.var_5aaac6ae7212dcf9 + ( self.maxtime + self.timebonus ) * 1000;
}

// Namespace ztron_bonus_room_racing
// Params 1, eflags: 0x4
// Checksum 0xe454f4ba, Offset: 0x2d85
// Size: 0x45
function private function_cd5774363154c247( bonustimes = 0 )
{
    self.timebonus += bonustimes;
    endtimems = function_41d8c7d2489f3868();
    ztron_ui::function_55784a0916b0cb86( endtimems, bonustimes );
}

// Namespace ztron_bonus_room_racing
// Params 0, eflags: 0x4
// Checksum 0xfca1ef8b, Offset: 0x2dd2
// Size: 0xb
function private function_6c5f1efdb7e097f7()
{
    ztron_ui::function_55784a0916b0cb86( 0, 0 );
}

/#

    // Namespace ztron_bonus_room_racing
    // Params 0
    // Checksum 0x3a3bcdf5, Offset: 0x2de5
    // Size: 0xfb, Type: dev
    function function_86b2a55f469f17db()
    {
        room = level.ztron.var_8a9067aa4cd65369;
        
        if ( room.checkpoints.size > 0 )
        {
            lastcheckpoint = room.checkpoints[ room.checkpoints.size - 1 ];
            
            if ( isdefined( lastcheckpoint ) )
            {
                foreach ( player in level.players )
                {
                    player ztron_util::teleport_player( lastcheckpoint.origin + ( 0, 0, 100 ), player.angles );
                }
            }
        }
    }

    // Namespace ztron_bonus_room_racing
    // Params 0
    // Checksum 0x9c65c246, Offset: 0x2ee8
    // Size: 0x8d, Type: dev
    function function_209bdb2332da4791()
    {
        foreach ( player in level.players )
        {
            player.infinitebooster = !player.infinitebooster;
        }
    }

    // Namespace ztron_bonus_room_racing
    // Params 0
    // Checksum 0x26c735f7, Offset: 0x2f7d
    // Size: 0x86, Type: dev
    function function_5c26b665553a2fec()
    {
        foreach ( player in level.players )
        {
            level notify( #"hash_80159d2dceecdcaa", player );
            break;
        }
    }

    // Namespace ztron_bonus_room_racing
    // Params 0
    // Checksum 0x2748cbe4, Offset: 0x300b
    // Size: 0x9d, Type: dev
    function debug_show_checkpoints()
    {
        room = level.ztron.var_8a9067aa4cd65369;
        
        foreach ( trigger in room.checkpoints )
        {
            trigger thread ztron_debug::drawtrigger();
        }
    }

    // Namespace ztron_bonus_room_racing
    // Params 0
    // Checksum 0x3f263032, Offset: 0x30b0
    // Size: 0x2f, Type: dev
    function function_30e9a25f39ba6d7d()
    {
        room = level.ztron.var_8a9067aa4cd65369;
        room function_cd5774363154c247( 30 );
    }

    // Namespace ztron_bonus_room_racing
    // Params 0
    // Checksum 0x2756a2cf, Offset: 0x30e7
    // Size: 0xca, Type: dev
    function function_ac7ee3673d6e340d()
    {
        categoryname = ztron_bonus_room::function_26fbf99313eff547( "<dev string:x24>" );
        devgui::function_9082edeb5db93280( "<dev string:x2b>" );
        devgui::add_devgui_func( "<dev string:x3f>" + categoryname + "<dev string:x4f>", "<dev string:x6c>", &function_86b2a55f469f17db );
        devgui::add_devgui_func( "<dev string:x3f>" + categoryname + "<dev string:x8e>", "<dev string:xa0>", &function_209bdb2332da4791 );
        devgui::add_devgui_func( "<dev string:x3f>" + categoryname + "<dev string:xb7>", "<dev string:xc7>", &function_5c26b665553a2fec );
        devgui::add_devgui_func( "<dev string:x3f>" + categoryname + "<dev string:xdc>", "<dev string:xee>", &debug_show_checkpoints );
        devgui::add_devgui_func( "<dev string:x3f>" + categoryname + "<dev string:x105>", "<dev string:x114>", &function_30e9a25f39ba6d7d );
        devgui::function_77df7fe7dd273e10();
    }

#/
