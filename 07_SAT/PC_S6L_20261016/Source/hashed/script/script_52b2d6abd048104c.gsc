// script_52b2d6abd048104c  (hash_52b2d6abd048104c.gscc) (size: 8511 Bytes / 0x213f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x49fd8458 (1241351256)
// size ...... 8511 (0x213f)
// includes .. 9   (offset: 0x1f97)
// strings ... 26  (offset: 0x1fdf)
// dev strs .. 0   (offset: 0x213f)
// exports ... 22  (offset: 0x136f)
// cseg ...... 0x2ea + 0x1085 (0x136f)
// imports ... 76  (offset: 0x16df)
// animtree1 . 0   (offset: 0x213f)
// animtree2 . 0   (offset: 0x213f)
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\mp\zm\zm_utility;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace namespace_3b4a83e58739c229;

// Namespace namespace_3b4a83e58739c229
// Params 0, eflags: 0x5
// Checksum 0x15244815, Offset: 0x308
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_5b9291da2b8d0764", #"ztron_item", undefined, &init );
}

// Namespace namespace_3b4a83e58739c229
// Params 0
// Checksum 0x269fa066, Offset: 0x331
// Size: 0x75
function init()
{
    ztron_item::function_5844a9c240f7dc8d( #"tesla_ball", #"use", &useteslaball );
    utility::add_fx( "ztron_tesla_trail", "vfx_ztron_tesla_arc_trail" );
    utility::add_fx( "ztron_tesla_death", "vfx_ztron_tesla_shock_death_impact" );
    ztron_sound::function_4ac735395b173fe( "ztron_pickup_tesla_ball_impact_OS", "evt_ztron_pickup_teslaball_impact" );
    ztron_sound::function_4ac735395b173fe( "ztron_pickup_tesla_ball_launch_OS", "evt_ztron_pickup_teslaball_active_end" );
    ztron_sound::function_4ac735395b173fe( "ztron_pickup_tesla_ball_arc", "evt_ztron_pickup_teslaball_arc" );
}

// Namespace namespace_3b4a83e58739c229
// Params 1
// Checksum 0x5fd7f6c7, Offset: 0x3ae
// Size: 0x6d
function useteslaball( params )
{
    player = params.player;
    itemdata = ztron_item::function_998f2b10462afbf4( params.bundle );
    spawnparams = spawnstruct();
    spawnparams.duration = itemdata.duration;
    activateteslaball( player, spawnparams );
}

// Namespace namespace_3b4a83e58739c229
// Params 2
// Checksum 0x22c9ef63, Offset: 0x423
// Size: 0x352
function activateteslaball( owner, params )
{
    if ( isplayer( owner ) )
    {
        owner endon( #"disconnect" );
    }
    
    one_tesla_ball_triggered_note = ztron_util::function_86d9bcab81b0ff0d( "one_tesla_ball_triggered" );
    all_tesla_balls_triggered_note = ztron_util::function_86d9bcab81b0ff0d( "all_tesla_balls_triggered" );
    kill_tesla_balls_note = ztron_util::function_86d9bcab81b0ff0d( "kill_tesla_balls" );
    tesla_ball_array = owner function_507221a5b74bdae2( params );
    var_7c4d5294acdb33b4 = ztron_item::function_8b0c01e93664327d( self, "tag_origin", tesla_ball_array, params.rotatespeed ?? 180 );
    var_7c4d5294acdb33b4.rotating_ball_count = tesla_ball_array.size;
    
    if ( isdefined( params.maxradius ) && isdefined( params.expandtime ) )
    {
        foreach ( ball in tesla_ball_array )
        {
            target_link_offset = vectornormalize( ball.origin - var_7c4d5294acdb33b4.origin ) * params.maxradius;
            ball movetolinked( target_link_offset, params.expandtime );
        }
    }
    
    foreach ( obj in tesla_ball_array )
    {
        obj thread function_7b9b3e1daa912b05( owner, kill_tesla_balls_note );
        obj thread function_446c20e7ae0f53ca( owner, kill_tesla_balls_note, one_tesla_ball_triggered_note, var_7c4d5294acdb33b4 );
    }
    
    owner function_f7acf92089f9869e( owner );
    duration = params.duration ?? 0;
    
    if ( isplayer( owner ) )
    {
        duration = owner ztron_player_utility::function_10777122eee28fa8( duration, 1 );
    }
    
    while ( !ztron_item::function_4b0636e7b2fc461f() )
    {
        waitframe();
    }
    
    owner thread all_tesla_balls_triggered_watcher( tesla_ball_array.size, one_tesla_ball_triggered_note, all_tesla_balls_triggered_note );
    msg = owner utility::waittill_any_timeout( duration, "kill_shield", "ztron_exit_taken", "clone_shutdown", "ztron_teleporter_taken", "death", "deactive_rune_statue", all_tesla_balls_triggered_note );
    owner function_eadcf98c166579f5( owner );
    
    if ( msg != all_tesla_balls_triggered_note )
    {
        var_3938bba764401841 = 1;
        
        if ( msg == "ztron_exit_taken" || msg == "ztron_teleporter_taken" )
        {
            var_3938bba764401841 = 0;
        }
        
        foreach ( obj in tesla_ball_array )
        {
            if ( isdefined( obj ) )
            {
                obj notify( #"tesla_ball_clean_up", var_3938bba764401841 );
            }
        }
    }
    
    if ( params.endnote )
    {
        owner notify( params.endnote );
    }
}

// Namespace namespace_3b4a83e58739c229
// Params 2
// Checksum 0x3970a872, Offset: 0x77d
// Size: 0x59
function function_7b9b3e1daa912b05( owner, kill_tesla_balls_note )
{
    self notify( #"hash_7f7dee53e90ce7e8" );
    self endon( #"hash_7f7dee53e90ce7e8" );
    self endon( #"death" );
    
    if ( isplayer( owner ) )
    {
        owner waittill( #"disconnect" );
        self notify( kill_tesla_balls_note );
        return;
    }
    
    return;
}

// Namespace namespace_3b4a83e58739c229
// Params 1
// Checksum 0x36ae2c2, Offset: 0x7de
// Size: 0x6c
function function_f7acf92089f9869e( owner )
{
    if ( !isdefined( owner.var_1cdb943212a11a58 ) )
    {
        owner.var_1cdb943212a11a58 = 0;
    }
    
    owner.var_1cdb943212a11a58++;
    
    if ( !isdefined( owner.var_9ee17dc0a71be2b0 ) )
    {
        owner.var_9ee17dc0a71be2b0 = spawnscriptable( "ztron_audio_tesla_ball_powerup", owner.origin, owner.angles );
    }
}

// Namespace namespace_3b4a83e58739c229
// Params 1
// Checksum 0x3ae4199d, Offset: 0x852
// Size: 0x7a
function function_eadcf98c166579f5( owner )
{
    if ( !isdefined( owner.var_1cdb943212a11a58 ) )
    {
        owner.var_1cdb943212a11a58 = 0;
    }
    
    owner.var_1cdb943212a11a58--;
    
    if ( owner.var_1cdb943212a11a58 <= 0 )
    {
        owner.var_1cdb943212a11a58 = 0;
        
        if ( isdefined( owner.var_9ee17dc0a71be2b0 ) )
        {
            owner.var_9ee17dc0a71be2b0 freescriptable();
            owner.var_9ee17dc0a71be2b0 = undefined;
        }
    }
}

// Namespace namespace_3b4a83e58739c229
// Params 3, eflags: 0x4
// Checksum 0x7dbdc31a, Offset: 0x8d4
// Size: 0x4e
function private all_tesla_balls_triggered_watcher( count, var_ce3ec0f00b21086e, final_notify_note )
{
    self endon( #"disconnect" );
    self endon( #"death" );
    
    while ( count > 0 )
    {
        self waittill( var_ce3ec0f00b21086e );
        count--;
    }
    
    self notify( final_notify_note );
}

// Namespace namespace_3b4a83e58739c229
// Params 4, eflags: 0xc
// Checksum 0x9dd9dbe, Offset: 0x92a
// Size: 0x6f
function private function_446c20e7ae0f53ca( owner, kill_tesla_balls_note, var_704b73c2965ee206, var_7c4d5294acdb33b4 )
{
    self notify( #"hash_b564e75a9033aeed" );
    self endon( #"hash_b564e75a9033aeed" );
    self endon( #"death" );
    utility::waittill_any_return( "tesla_ball_clean_up", kill_tesla_balls_note );
    thread teslaballcleanup( 1, var_7c4d5294acdb33b4 );
    
    if ( isdefined( owner ) )
    {
        owner notify( var_704b73c2965ee206 );
    }
}

// Namespace namespace_3b4a83e58739c229
// Params 2, eflags: 0x4
// Checksum 0x5ddd5117, Offset: 0x9a1
// Size: 0x109
function private teslaballcleanup( var_3938bba764401841, var_7c4d5294acdb33b4 )
{
    self endon( #"death" );
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger delete();
    }
    
    centerpos = var_7c4d5294acdb33b4.origin;
    movedir = vectornormalize( self.origin - centerpos + ( 0, 0, 50 ) );
    ztron_item::function_21c3b4ab8aa7468d( [ self ] );
    var_7c4d5294acdb33b4.rotating_ball_count--;
    
    if ( var_7c4d5294acdb33b4.rotating_ball_count <= 0 )
    {
        ztron_item::function_39d7023e3666b11e( var_7c4d5294acdb33b4 );
    }
    
    if ( var_3938bba764401841 )
    {
        force = 260;
        
        if ( isdefined( self.params.force ) )
        {
            force = self.params.force;
        }
        
        thread teslaballlaunch( centerpos, movedir * force );
        wait 5;
    }
    
    ztron_sound::ztron_stopsound( self );
    self delete();
}

// Namespace namespace_3b4a83e58739c229
// Params 2, eflags: 0x4
// Checksum 0x1e7ffef3, Offset: 0xab2
// Size: 0x74
function private teslaballlaunch( origin, force )
{
    self endon( #"death" );
    self unlink();
    self solid();
    
    if ( !self.notcollapse )
    {
        self moveto( origin, 0.5 );
        utility::waittill_notify_or_timeout( "movedone", 1 );
    }
    
    ztron_sound::ztron_playsound( "ztron_pickup_tesla_ball_launch_OS", undefined, self );
    self physicslaunchserver( self.origin, force );
}

// Namespace namespace_3b4a83e58739c229
// Params 1, eflags: 0x4
// Checksum 0x6a9fbb73, Offset: 0xb2e
// Size: 0xc3
function private function_507221a5b74bdae2( params )
{
    angle = 0;
    
    if ( isdefined( params.angle ) )
    {
        angle = params.angle;
    }
    else
    {
        angle = randomint( 360 );
    }
    
    num = 4;
    
    if ( isdefined( params.num ) )
    {
        num = params.num;
    }
    
    deltaangle = 360 / num;
    tesla_ball_array = [];
    
    for ( i = 0; i < num ; i++ )
    {
        ball = createteslaball( angle + i * deltaangle, params );
        
        if ( isdefined( ball ) )
        {
            tesla_ball_array[ tesla_ball_array.size ] = ball;
        }
    }
    
    return tesla_ball_array;
}

// Namespace namespace_3b4a83e58739c229
// Params 2, eflags: 0x4
// Checksum 0x6ef9a585, Offset: 0xbfa
// Size: 0x158
function private createteslaball( angle, params )
{
    ball = utility::spawn_model( "ztron_tesla_ball", self.origin );
    
    if ( !isdefined( ball ) )
    {
        return;
    }
    
    ball notsolid();
    ball enablelinkto();
    ball forcenetfieldhighlod( 1 );
    ball setmoverantilagged( 1 );
    ball markkeyframedmover();
    trigger = spawn( "trigger_radius", ball.origin, 1, 18, 50 );
    
    if ( !isdefined( trigger ) )
    {
        ball delete();
        return;
    }
    
    trigger enablelinkto();
    trigger linkto( ball );
    trigger thread function_57f90ab322c65c4f( self );
    trigger.ball = ball;
    ball.trigger = trigger;
    ball.params = params;
    ball.notcollapse = params.notcollapse;
    radius = 60;
    
    if ( isdefined( params.radius ) )
    {
        radius = params.radius;
    }
    
    ball.origin = self.origin + rotatepointaroundvector( ( 0, 0, 1 ), ( radius, 0, params.zoffset ?? 30 ), angle );
    return ball;
}

// Namespace namespace_3b4a83e58739c229
// Params 1, eflags: 0x4
// Checksum 0x380aee3f, Offset: 0xd5b
// Size: 0x116
function private function_57f90ab322c65c4f( owner )
{
    level endon( #"ztron_game_is_over" );
    self endon( #"death" );
    
    while ( isdefined( self ) && isdefined( owner ) )
    {
        self waittill( #"trigger", ent );
        
        if ( isplayer( ent ) || ent vehicle::is_vehicle() && isplayer( ent.owner ) )
        {
            continue;
        }
        
        if ( ent.team == owner.team || ent.teslahit || ent.tesladeath || ent.ztron.boss )
        {
            continue;
        }
        
        ztron_sound::ztron_playsound( "ztron_pickup_tesla_ball_impact_OS", ent.origin );
        ent thread function_f371fa9b0bab6a4a( owner );
        self.ball.notcollapse = 1;
        self.ball notify( #"tesla_ball_clean_up", 0 );
    }
}

// Namespace namespace_3b4a83e58739c229
// Params 1
// Checksum 0xba0fad3d, Offset: 0xe79
// Size: 0x5d
function function_f371fa9b0bab6a4a( owner )
{
    if ( !isdefined( owner ) )
    {
        return;
    }
    
    if ( isplayer( owner ) )
    {
        owner endon( #"disconnect" );
    }
    
    owner endon( #"death" );
    owner.var_2d5a632e4ce8a2e4 = 1;
    function_26c16a173b019739( self, owner, 0 );
    owner.var_2d5a632e4ce8a2e4 = 0;
}

// Namespace namespace_3b4a83e58739c229
// Params 3, eflags: 0x4
// Checksum 0x3aad8c2c, Offset: 0xede
// Size: 0x14b
function private function_26c16a173b019739( sourceenemy, owner, arcnum )
{
    enemies = function_20d3567797076c78( self.origin, 300 - 20 * arcnum );
    function_dfb67dbee08d8a70( enemies, 1 );
    thread function_8d0eefcc847e34cd( sourceenemy, arcnum, owner );
    ztron_sound::ztron_playsound( "ztron_pickup_tesla_ball_arc", self.origin );
    
    foreach ( guy in enemies )
    {
        if ( guy == self )
        {
            continue;
        }
        
        if ( guy.notesla || guy.ztron.boss )
        {
            continue;
        }
        
        if ( function_2a6a80d070b97183( arcnum + 1, owner.var_2d5a632e4ce8a2e4 ) )
        {
            function_dfb67dbee08d8a70( guy, 0 );
            continue;
        }
        
        owner.var_2d5a632e4ce8a2e4++;
        guy thread function_26c16a173b019739( self, owner, arcnum + 1 );
    }
}

// Namespace namespace_3b4a83e58739c229
// Params 2, eflags: 0x4
// Checksum 0xd755945d, Offset: 0x1031
// Size: 0x62
function private function_dfb67dbee08d8a70( enemy, hit )
{
    if ( !isdefined( enemy ) )
    {
        return;
    }
    
    if ( isarray( enemy ) )
    {
        for ( i = 0; i < enemy.size ; i++ )
        {
            enemy[ i ].teslahit = hit;
        }
        
        return;
    }
    
    enemy.teslahit = hit;
}

// Namespace namespace_3b4a83e58739c229
// Params 2, eflags: 0x4
// Checksum 0xfa2ee9fe, Offset: 0x109b
// Size: 0x90
function private function_20d3567797076c78( origin, distance )
{
    if ( !isdefined( origin ) )
    {
        return [];
    }
    
    teslaenemies = getaiarrayinradius( origin, distance, zm_utility::get_zombie_team() );
    teslaenemies = utility::get_array_of_closest( origin, teslaenemies );
    enemies = [];
    
    for ( i = 0; i < teslaenemies.size ; i++ )
    {
        if ( !isdefined( teslaenemies[ i ] ) || teslaenemies[ i ].teslahit )
        {
            continue;
        }
        
        enemies[ enemies.size ] = teslaenemies[ i ];
    }
    
    return enemies;
}

// Namespace namespace_3b4a83e58739c229
// Params 3
// Checksum 0x806bd263, Offset: 0x1134
// Size: 0x105
function function_8d0eefcc847e34cd( sourceenemy, arcnum, owner )
{
    if ( isplayer( owner ) )
    {
        owner endon( #"disconnect" );
    }
    
    timetowait = 0.2 * arcnum;
    
    if ( timetowait > 0 )
    {
        wait timetowait;
    }
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( isdefined( sourceenemy ) && sourceenemy != self )
    {
        sourceenemy function_8f4b2f7c6a5b3c33( self );
    }
    
    if ( !isalive( self ) || self.ztron.boss )
    {
        return;
    }
    
    self.tesladeath = 1;
    playfx( utility::getfx( "ztron_tesla_death" ), self.origin );
    
    if ( !self.nogib )
    {
        namespace_b76ff2659823e89d::function_6c318bca7bb326e7();
    }
    
    source = undefined;
    
    if ( isplayer( owner ) )
    {
        source = owner;
    }
    
    self dodamage( self.health, self.origin, source, source, "MOD_ELEMENTAL_ELEC" );
}

// Namespace namespace_3b4a83e58739c229
// Params 2, eflags: 0x4
// Checksum 0xf3b07ecd, Offset: 0x1241
// Size: 0x4b, Type: bool
function private function_2a6a80d070b97183( arcnum, var_48048d2d340adf45 )
{
    if ( arcnum >= 5 )
    {
        return true;
    }
    
    if ( var_48048d2d340adf45 >= 20 )
    {
        return true;
    }
    
    radiusdecay = 20 * arcnum;
    
    if ( 300 - radiusdecay <= 0 )
    {
        return true;
    }
    
    return false;
}

// Namespace namespace_3b4a83e58739c229
// Params 1, eflags: 0x4
// Checksum 0x9de86c6e, Offset: 0x1295
// Size: 0xda
function private function_8f4b2f7c6a5b3c33( target )
{
    if ( !isdefined( self ) || !isdefined( target ) )
    {
        wait 0.05;
        return;
    }
    
    origin = self geteye();
    targetorigin = target geteye();
    var_1d57322b17d52eaa = distancesquared( origin, targetorigin ) / squared( 128 );
    timemove = var_1d57322b17d52eaa * 0.05;
    timemove = timemove >= 0.2 ? timemove : 0.2;
    fxorg = utility::spawn_model( "tag_origin", origin );
    
    if ( isdefined( fxorg ) )
    {
        playfxontag( utility::getfx( "ztron_tesla_trail" ), fxorg, "tag_origin" );
        fxorg moveto( targetorigin, timemove );
        fxorg utility::waittill_any_timeout( timemove + 1, "movedone" );
        fxorg delete();
    }
}

