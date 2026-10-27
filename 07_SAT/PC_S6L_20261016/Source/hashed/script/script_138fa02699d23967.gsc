// script_138fa02699d23967  (hash_138fa02699d23967.gscc) (size: 22697 Bytes / 0x58a9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x7a1ecdf6 (2048839158)
// size ...... 22697 (0x58a9)
// includes .. 20  (offset: 0x5565)
// strings ... 40  (offset: 0x5605)
// dev strs .. 5   (offset: 0x586d)
// exports ... 51  (offset: 0x3ca5)
// cseg ...... 0x415 + 0x3890 (0x3ca5)
// imports ... 135 (offset: 0x449d)
// animtree1 . 0   (offset: 0x58a9)
// animtree2 . 0   (offset: 0x58a9)
#using script_31ee2a173f3499b7;
#using script_79d6ac13cb9dfe42;
#using script_cc7edad3d14d7bf;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\agents\agent_utils;
#using scripts\mp\common\utility\player;
#using scripts\mp\loot\common_item;
#using scripts\mp\zm\ztron\ztron_bonus_room;
#using scripts\mp\zm\ztron\ztron_camera;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_enemy;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_score;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace namespace_2d7c3917ca8e17d2;

// Namespace namespace_2d7c3917ca8e17d2
// Params 0, eflags: 0x5
// Checksum 0x9a0262b3, Offset: 0x433
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_8ea20fc04a2368f", undefined, undefined, &init );
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 0
// Checksum 0x25d88833, Offset: 0x454
// Size: 0x9
function init()
{
    thread function_90e8c0a5f12cb527();
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 0
// Checksum 0x3b4291ee, Offset: 0x465
// Size: 0xe7
function function_90e8c0a5f12cb527()
{
    level utility::flag_wait( "ztron_bonus_room_initialized" );
    var_a8d8980c65b4b0de = ztron_bonus_room::function_98dedbfc79dc3572( "fall_100" );
    assert( var_a8d8980c65b4b0de.size < 2, "<dev string:x24>" );
    
    foreach ( room in var_a8d8980c65b4b0de )
    {
        room function_9f9ae744a7cc1720();
        room.setupcallback = &setupcallback;
        room.var_d822af3942fcbc3d = &playersetup;
        room.var_e1b2540e2c81f811 = 1;
        room.var_d4ea8a279b48a561 = 1;
    }
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 1
// Checksum 0xb212b513, Offset: 0x554
// Size: 0x15
function setupcallback( room )
{
    room function_4ba2ff1987353f42();
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 0
// Checksum 0x99282e03, Offset: 0x571
// Size: 0x128
function function_9f9ae744a7cc1720()
{
    self.var_feda109afe10f2ca = 1;
    self.var_2c90f07c53421d58 = [];
    self.initialspawnpoints = utility::getstructarray( "bonus_fall_100_player_spawnpoint", "targetname" );
    self.lefttop = utility::getstruct( "fall_100_left_top", "targetname" ).origin;
    self.rightbottom = utility::getstruct( "fall_100_right_bottom", "targetname" ).origin;
    self.width = abs( self.rightbottom[ 1 ] - self.lefttop[ 1 ] );
    self.startpoint = ( self.rightbottom[ 0 ] - 35, self.rightbottom[ 1 ], self.lefttop[ 2 ] - 100 );
    self.floorheight = int( ( self.startpoint[ 2 ] - self.rightbottom[ 2 ] ) / 100 );
    self.center = ( self.rightbottom - self.lefttop ) / 2 + self.lefttop;
    function_ce6353c5c17a5215();
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 0
// Checksum 0x30e98302, Offset: 0x6a1
// Size: 0x301
function function_4ba2ff1987353f42()
{
    self.entities = [];
    self.items = [];
    self.var_76f8bd8247ab508a = [];
    self.currentfloor = 0;
    self.exittrigger = undefined;
    self.var_76a1c6d566d98aed = 1;
    ztron_util::slickclipsave();
    level waittill( #"bonus_room_ready" );
    level ztron_ui::function_f5177e090dadd8f4( 2 );
    ztron_ui::function_2bea9afab8148cc7( 0 );
    ztron_util::slickclipsetup();
    
    if ( getdvarint( @"hash_4a96e2b236d93908", 1 ) == 1 )
    {
        level.ztron.var_d77b8b935a461811 = &function_e353c74adcbccfbe;
    }
    else
    {
        level.var_8972cc8b6869f399 = 1;
    }
    
    level.var_5ac542875a6578d7 = 1;
    level.ztron.var_8f5e1fd3d37076cc = getdvarfloat( @"hash_9b69ad203cc64371", 1 );
    setdvar( @"hash_9b69ad203cc64371", 1.8 );
    level.ztron.var_ffe07d19d8b6c7b = 5;
    level.ztron.playerrespawnoverride = &playerrespawnoverride;
    level callback::add( #"player_laststand", &onplayerlaststand );
    setomnvar( "topdown_camera_side_scroll", 1 );
    level callback::add( "on_zombie_ai_killed", &function_36e82b3eaa874d78 );
    thread function_c0c2bd4595240498();
    thread function_1bc608c47c2cf062();
    thread function_58dc2242c9ee1517();
    thread function_50cdbd4410e99489();
    level waittill( #"hash_9d2492f7742c7564" );
    thread function_c66da980a3899cbc();
    
    foreach ( player in level.players )
    {
        player allowmovement( 0 );
        player.ztron.blockboost = 1;
        player thread updateplayerfloor( self );
        player thread disconnectedwatcher();
    }
    
    thread function_742e1c516b636b();
    wait 4;
    setomnvar( "ui_ztron_fall_hundred_current_state", 0 );
    level ztron_sound::ztron_playsound( "countdown_tick" );
    wait 1;
    level ztron_sound::ztron_playsound( "countdown_tick" );
    wait 1;
    level ztron_sound::ztron_playsound( "countdown_tick" );
    wait 1;
    level ztron_sound::ztron_playsound( "countdown_go" );
    
    foreach ( player in level.players )
    {
        player allowmovement( 1 );
        player.ztron.blockboost = 0;
    }
    
    function_b3a11686c427d6eb();
    wait 5;
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 0
// Checksum 0x8f97353a, Offset: 0x9aa
// Size: 0xb2
function function_b3a11686c427d6eb()
{
    size = ( self.width / 2, 100, 5 );
    center = self.rightbottom + ( 0, self.width * -1 / 2, 0 );
    trigger = spawn( "trigger_box", center, 0, size, size );
    trigger.angles = vectortoangles( self.rightbottom - center );
    self.entities[ self.entities.size ] = trigger;
    self.exittrigger = trigger;
    trigger thread function_5a148042076b504a( self );
    
    /#
        thread drawtrigger( trigger );
    #/
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 0
// Checksum 0x29597779, Offset: 0xa64
// Size: 0xfb
function function_58dc2242c9ee1517()
{
    result = level utility::waittill_any_return( "bonus_room_expired", "ztron_game_is_over" );
    playersetup( self, 1 );
    setdvar( @"hash_9b69ad203cc64371", level.ztron.var_8f5e1fd3d37076cc ?? 1 );
    level callback::remove( #"player_laststand", &onplayerlaststand );
    level callback::remove( "on_zombie_ai_killed", &function_36e82b3eaa874d78 );
    level.ztron.var_ffe07d19d8b6c7b = undefined;
    level.ztron.playerrespawnoverride = undefined;
    clearentities();
    setomnvar( "topdown_camera_side_scroll", 0 );
    setomnvar( "ui_ztron_fall_hundred_current_state", -1 );
    ztron_util::slickcliprestore();
    level.var_8972cc8b6869f399 = 0;
    level.var_5ac542875a6578d7 = 0;
    level.ztron.var_d77b8b935a461811 = undefined;
    level ztron_ui::function_f5177e090dadd8f4( 0 );
    ztron_ui::function_2bea9afab8148cc7( 1 );
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 0
// Checksum 0x495bde24, Offset: 0xb67
// Size: 0x1ec
function clearentities()
{
    foreach ( entity in self.entities )
    {
        entity delete();
    }
    
    self.entities = [];
    
    foreach ( item in self.items )
    {
        thread ztron_item::clearitem( item );
    }
    
    self.items = [];
    
    foreach ( platformarray in self.var_76f8bd8247ab508a )
    {
        foreach ( platform in platformarray )
        {
            clearplatform( platform );
        }
    }
    
    self.var_76f8bd8247ab508a = [];
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 1
// Checksum 0xd98dcba3, Offset: 0xd5b
// Size: 0x2b
function onplayerlaststand( params )
{
    self notify( #"hash_41b799d6926e0e3b" );
    self endon( #"hash_41b799d6926e0e3b" );
    self allowmovement( 0 );
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 0
// Checksum 0xc9f26c40, Offset: 0xd8e
// Size: 0x49
function playerrespawnoverride()
{
    self endon( #"disconnect" );
    level endon( #"ztron_game_is_over" );
    point = function_a86488ecc763b2a9();
    self setorigin( point );
    self allowmovement( 1 );
    waitframe();
    thread ztron_player_utility::playerrespawnnow( 0, point, 0, 0 );
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 1
// Checksum 0x8b6a12dd, Offset: 0xddf
// Size: 0x16e
function function_36e82b3eaa874d78( params )
{
    if ( isdefined( self.damagetrigger ) )
    {
        self.damagetrigger delete();
        self.damagetrigger = undefined;
    }
    
    if ( isdefined( self.platform ) )
    {
        self.platform.enemy = undefined;
    }
    
    if ( isplayer( params.eattacker ) )
    {
        room = self.platform.room;
        items = common_item::items_selectfromlist( self.droplist ?? "ztron_item_fall_100_basic_zombie_droplist", 1 );
        spawnoptions = common_item::items_initspawnoptions_spawnfromposition( self.origin + ( 0, 0, 35 ) );
        spawnoptions.var_8934e0ace9b7d996 = 0;
        spawnoptions.var_8958d2ace9e03584 = 1;
        spawnoptions.var_d72f168a0f299753 = 0;
        spawnoptions.var_d7522c8a0f500f6d = 5;
        spawnoptions.var_2321e933cbdf46d8 = 0;
        item = ztron_item::spawnitem( items[ 0 ], self.origin, 0, spawnoptions );
        self.platform.items[ self.platform.items.size ] = item;
    }
    
    thread function_3bcc7e71fb258aa8();
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 0
// Checksum 0xbe8f568b, Offset: 0xf55
// Size: 0x20
function function_3bcc7e71fb258aa8()
{
    waitframe();
    corpse = self getcorpseentity();
    
    if ( corpse )
    {
        corpse delete();
    }
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 0
// Checksum 0x2614ab46, Offset: 0xf7d
// Size: 0x16e
function function_a86488ecc763b2a9()
{
    room = level.ztron.var_8a9067aa4cd65369;
    lowestfloor = function_192b6db187ac7f6d() + -5;
    
    if ( !isdefined( self.reachedfloor ) )
    {
        self.reachedfloor = lowestfloor;
    }
    
    safefloor = int( clamp( self.reachedfloor - 3, lowestfloor + 3, 99 ) );
    safeplatforms = [];
    
    for ( i = safefloor; i <= room.var_76f8bd8247ab508a.size ; i++ )
    {
        currentplatforms = room.var_76f8bd8247ab508a[ i ];
        
        for ( j = 0; j < currentplatforms.size ; j++ )
        {
            if ( currentplatforms[ j ].issafe )
            {
                safeplatforms[ safeplatforms.size ] = j;
            }
        }
        
        if ( safeplatforms.size > 0 )
        {
            safefloor = i;
            break;
        }
    }
    
    safepoint = room.exittrigger.origin;
    
    if ( safeplatforms.size > 0 )
    {
        num = safeplatforms[ randomintrange( 0, safeplatforms.size ) ];
        safepoint = room.var_76f8bd8247ab508a[ safefloor ][ num ].origin + ( 0, 0, 0 );
    }
    else
    {
        assertmsg( "<dev string:x47>" );
    }
    
    return safepoint;
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 0
// Checksum 0x44491bd7, Offset: 0x10f4
// Size: 0x50
function function_c0c2bd4595240498()
{
    self notify( #"hash_a94acff4fe1fb0ac" );
    self endon( #"hash_a94acff4fe1fb0ac" );
    level endon( #"bonus_room_expired" );
    level endon( #"bonus_room_exit_taken" );
    
    while ( isdefined( self ) )
    {
        if ( function_192b6db187ac7f6d() >= 5 )
        {
            ztron_bonus_room::function_9595e8f0926735a4( self );
            return;
        }
        
        waitframe();
    }
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 0
// Checksum 0xbe7fc096, Offset: 0x114c
// Size: 0x5a
function disconnectedwatcher()
{
    level endon( #"bonus_room_expired" );
    level endon( #"bonus_room_exit_taken" );
    sessionidx = self.sessionuimemberindex;
    self waittill( #"disconnect" );
    setomnvar( "ui_ztron_fall_hundred_current_floor_" + sessionidx, -1 );
    setomnvar( "ui_ztron_fall_hundred_rank_" + sessionidx, -1 );
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 2
// Checksum 0xc0aefd9a, Offset: 0x11ae
// Size: 0x1e3
function playersetup( room, var_4659d2db90ce8d11 = 0 )
{
    if ( level utility::flag_exist( "ztron_game_is_over" ) )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        player ztron_camera::function_e53bf7020d2f155d( var_4659d2db90ce8d11 ? 0 : 3 );
        
        if ( !var_4659d2db90ce8d11 || !level.ztron.var_74a3707334cfe144 )
        {
            player val::set( "topdowncamera", "allow_jump", !var_4659d2db90ce8d11 );
            player val::set( "topdowncamera", "crouch", !var_4659d2db90ce8d11 );
        }
        
        if ( var_4659d2db90ce8d11 )
        {
            if ( player.inlaststand && isdefined( level.ztron.playerrespawnoverride ) )
            {
                player thread [[ level.ztron.playerrespawnoverride ]]();
            }
            
            setomnvar( "ui_ztron_fall_hundred_current_floor_" + player.sessionuimemberindex, -1 );
            setomnvar( "ui_ztron_fall_hundred_rank_" + player.sessionuimemberindex, -1 );
            player setjumpheightscale( 1 );
            player setgravityscale( 1 );
            player.damagedtrap = undefined;
            player.reachedfloor = undefined;
            player ztron_ui::function_f7e6c4641e827bf8( 0 );
            continue;
        }
        
        setomnvar( "ui_ztron_fall_hundred_current_floor_" + player.sessionuimemberindex, 0 );
        player setjumpheightscale( 5.5 );
        player setgravityscale( 0.8 );
        player ztron_ui::function_f7e6c4641e827bf8( 1 );
    }
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 0
// Checksum 0xf77b4eaf, Offset: 0x1399
// Size: 0x22e
function function_fef95c9e2240b031()
{
    rewarddata = undefined;
    
    foreach ( data in self.platformdata )
    {
        if ( data.minfloor == 100 )
        {
            rewarddata = data;
            break;
        }
    }
    
    if ( isdefined( rewarddata ) )
    {
        foreach ( data in rewarddata.data )
        {
            params = spawnstruct();
            params.overridelifetime = 9999;
            params.overrideangles = data.angles;
            params.scale = 1;
            params.modelspinning = 0;
            
            if ( data.var_5d94300d10f1345d )
            {
                bundlename = ztron_item::function_71e133b37011bee6( data.name );
                item = ztron_item::spawnitem( bundlename, rewarddata.origin + data.relativepos, 0, undefined, params );
                self.items[ self.items.size ] = item;
            }
            else
            {
                if ( !isdefined( var_144d371eb3935618 ) )
                {
                    var_144d371eb3935618 = common_item::items_selectfromlist( data.name, 1 )[ 0 ];
                }
                
                item = ztron_item::spawnitem( var_144d371eb3935618, rewarddata.origin + data.relativepos, 0, undefined, params );
                self.items[ self.items.size ] = item;
            }
            
            /#
                function_c88f336792c0efe2( item );
            #/
        }
    }
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 1
// Checksum 0x61234fce, Offset: 0x15cf
// Size: 0xa4
function function_5a148042076b504a( room )
{
    self endon( #"death" );
    level endon( #"bonus_room_expired" );
    level endon( #"bonus_room_exit_taken" );
    
    while ( isdefined( self ) )
    {
        self waittill( #"trigger", ent );
        
        if ( isplayer( ent ) && !player::isinlaststand( ent ) )
        {
            ent.reachedfloor = 100;
            setomnvar( "ui_ztron_fall_hundred_current_floor_" + ent.sessionuimemberindex, ent.reachedfloor );
            room notify( #"hash_ba90110b6362c33a" );
            return;
        }
    }
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 0
// Checksum 0xfba54b51, Offset: 0x167b
// Size: 0x279
function function_20e3c39607338376()
{
    self.platformdata = utility::getstructarray( "fall_100_platform", "targetname" );
    
    foreach ( platform in self.platformdata )
    {
        platform.minfloor = 0;
        platform.maxfloor = 100;
        
        if ( isdefined( platform.script_parameters ) )
        {
            parameters = strtok( platform.script_parameters, ";" );
            
            if ( parameters.size > 0 )
            {
                platform.minfloor = int( parameters[ 0 ] );
                
                if ( parameters.size > 1 )
                {
                    platform.maxfloor = int( parameters[ 1 ] );
                }
            }
        }
        
        targets = utility::getstructarray( platform.target, "targetname" );
        
        foreach ( var_7c792fddae2d0fcb in targets )
        {
            var_5d94300d10f1345d = 1;
            
            if ( var_7c792fddae2d0fcb.script_noteworthy == "item" || var_7c792fddae2d0fcb.script_noteworthy == "list" )
            {
                data = spawnstruct();
                data.relativepos = var_7c792fddae2d0fcb.origin - platform.origin;
                data.name = var_7c792fddae2d0fcb.script_label;
                data.angles = var_7c792fddae2d0fcb.angles;
                data.var_5d94300d10f1345d = var_7c792fddae2d0fcb.script_noteworthy == "item";
                
                if ( !isdefined( platform.data ) )
                {
                    platform.data = [];
                }
                
                platform.data[ platform.data.size ] = data;
            }
        }
    }
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 0
// Checksum 0x64f025da, Offset: 0x18fc
// Size: 0x302
function function_492cfb0a83f23298()
{
    num = 2;
    
    if ( self.currentfloor > 40 )
    {
        num = randomintrange( 2, 4 );
    }
    
    bounds = function_decb653c5689e4ca( "sat_zm_ztron_platform_normal" );
    halflength = bounds[ 1 ];
    lengthinterval = self.width / num;
    spawnpoints = [];
    startpoint = self.startpoint + ( 0, 0, self.currentfloor * -1 * self.floorheight );
    rangearray = [];
    
    for ( i = 0; i < num ; i++ )
    {
        start = i * lengthinterval + halflength;
        end = ( i + 1 ) * lengthinterval - halflength;
        
        foreach ( floor in self.var_76f8bd8247ab508a[ self.currentfloor - 1 ] )
        {
            range = floor.origin[ 1 ] - self.lefttop[ 1 ];
            rangestart = range - halflength;
            rangeend = range + halflength;
            
            if ( !( rangeend < start || rangestart > end ) )
            {
                var_ad2e9d14c1165ce6 = clamp( rangestart - start, 0, rangestart );
                var_ad2e9c14c1165ab3 = clamp( end - rangeend, 0, end );
                
                if ( var_ad2e9d14c1165ce6 > var_ad2e9c14c1165ab3 )
                {
                    end = start + var_ad2e9d14c1165ce6 - halflength;
                    continue;
                }
                
                start = end - var_ad2e9c14c1165ab3 + halflength;
            }
        }
        
        if ( start >= 0 && end > start )
        {
            rangearray[ rangearray.size ] = randomfloatrange( start, end );
        }
    }
    
    for ( i = 0; i < rangearray.size - 1 ; i++ )
    {
        dist = rangearray[ i + 1 ] - rangearray[ i ];
        
        if ( dist < 50 + halflength * 2 )
        {
            rangearray[ i + 1 ] = rangearray[ i ] + 50 + halflength * 2;
            continue;
        }
        
        if ( dist > 1000 + halflength * 2 )
        {
            rangearray[ i + 1 ] = rangearray[ i ] + 1000 + halflength * 2;
        }
    }
    
    foreach ( range in rangearray )
    {
        spawnpoints[ spawnpoints.size ] = ( startpoint[ 0 ], self.lefttop[ 1 ] + range, startpoint[ 2 ] );
    }
    
    return spawnpoints;
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 0
// Checksum 0xb81e96dc, Offset: 0x1c07
// Size: 0x27c
function function_1bc608c47c2cf062()
{
    level endon( #"bonus_room_expired" );
    level endon( #"bonus_room_exit_taken" );
    currentheight = self.startpoint[ 2 ];
    
    while ( currentheight > self.rightbottom[ 2 ] + self.floorheight && self.currentfloor < 99 )
    {
        self.currentfloor++;
        spawnpoints = function_492cfb0a83f23298();
        var_76f8bd8247ab508a = [];
        safeindex = -1;
        
        if ( spawnpoints.size > 0 )
        {
            if ( self.currentfloor % 3 == 0 )
            {
                safeindex = randomintrange( 0, spawnpoints.size );
            }
        }
        
        for ( i = 0; i < spawnpoints.size ; i++ )
        {
            platform = utility::spawn_model( "sat_zm_ztron_platform_normal", spawnpoints[ i ], ( 0, 0, 0 ) );
            platform.floor = self.currentfloor;
            platform.room = self;
            var_76f8bd8247ab508a[ var_76f8bd8247ab508a.size ] = platform;
            issafe = safeindex == i ? 1 : 0;
            chanceset = 4;
            
            if ( self.currentfloor <= 10 )
            {
                chanceset = 0;
            }
            else if ( self.currentfloor <= 20 )
            {
                chanceset = 1;
            }
            else if ( self.currentfloor <= 40 )
            {
                chanceset = 2;
            }
            else if ( self.currentfloor <= 80 )
            {
                chanceset = 3;
            }
            
            setupplatform( platform, chanceset, issafe );
            waitframe();
        }
        
        self.var_76f8bd8247ab508a[ self.currentfloor ] = var_76f8bd8247ab508a;
        
        foreach ( platform in var_76f8bd8247ab508a )
        {
            if ( platform.canmove )
            {
                targets = function_b770b6610752361d( platform );
                
                if ( !isdefined( targets[ 0 ] ) || !isdefined( targets[ 1 ] ) )
                {
                    continue;
                }
                
                thread function_7ba98913c0d2be54( platform, targets[ 0 ], targets[ 1 ] );
                break;
            }
        }
        
        currentheight -= self.floorheight;
    }
    
    function_fef95c9e2240b031();
    
    /#
        thread function_f4c77a981e1c2796();
    #/
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 0
// Checksum 0xca18a81d, Offset: 0x1e8b
// Size: 0x100
function function_742e1c516b636b()
{
    level endon( #"bonus_room_expired" );
    level endon( #"bonus_room_exit_taken" );
    self endon( #"room_done" );
    startpos = 0;
    
    while ( true )
    {
        endpos = max( function_192b6db187ac7f6d() + -5, 0 );
        
        if ( endpos >= 0 )
        {
            for ( i = startpos; i < endpos ; i++ )
            {
                platformsarray = self.var_76f8bd8247ab508a[ i ];
                
                foreach ( platform in platformsarray )
                {
                    clearplatform( platform );
                }
            }
            
            startpos = endpos;
        }
        
        wait 1;
    }
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 0
// Checksum 0xb6ecb95a, Offset: 0x1f93
// Size: 0x1b6
function function_ce6353c5c17a5215()
{
    function_20e3c39607338376();
    function_e83b7da014fac6c3( [ 30, 70, 70, 70, 70, 100, 100, 100 ] );
    function_e83b7da014fac6c3( [ 22, 48, 48, 48, 58, 90, 100, 100 ] );
    function_e83b7da014fac6c3( [ 20, 30, 30, 40, 55, 85, 100, 100 ] );
    function_e83b7da014fac6c3( [ 20, 30, 45, 55, 65, 85, 95, 100 ] );
    function_e83b7da014fac6c3( [ 20, 30, 45, 45, 55, 75, 85, 100 ] );
    
    foreach ( platforminfo in self.platforminfo )
    {
        if ( platforminfo.issafe )
        {
            self.var_2c90f07c53421d58[ self.var_2c90f07c53421d58.size ] = platforminfo;
        }
    }
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 1
// Checksum 0x6aa2cbe9, Offset: 0x2151
// Size: 0x2bf
function function_e83b7da014fac6c3( chances )
{
    if ( !isdefined( self.platforminfo ) )
    {
        self.platforminfo = [];
        struct = spawnstruct();
        struct.chance = [];
        struct.func = &function_f2d845115689e541;
        self.platforminfo[ self.platforminfo.size ] = struct;
        struct = spawnstruct();
        struct.chance = [];
        struct.issafe = 1;
        struct.priority = "high";
        struct.func = &function_50fdfcf7abf842af;
        self.platforminfo[ self.platforminfo.size ] = struct;
        struct = spawnstruct();
        struct.chance = [];
        struct.func = &function_dbe50cebe2fefec7;
        self.platforminfo[ self.platforminfo.size ] = struct;
        struct = spawnstruct();
        struct.chance = [];
        struct.func = &function_11cdb353b111e2b6;
        self.platforminfo[ self.platforminfo.size ] = struct;
        struct = spawnstruct();
        struct.chance = [];
        struct.func = &function_5c7854f2c9e5c2e7;
        self.platforminfo[ self.platforminfo.size ] = struct;
        struct = spawnstruct();
        struct.chance = [];
        struct.issafe = 1;
        struct.func = &function_6335ecebf4fd23e7;
        self.platforminfo[ self.platforminfo.size ] = struct;
        struct = spawnstruct();
        struct.chance = [];
        struct.issafe = 1;
        struct.func = &function_c3a78607d759239d;
        self.platforminfo[ self.platforminfo.size ] = struct;
        struct = spawnstruct();
        struct.chance = [];
        struct.func = &function_7b8579d50eac050c;
        self.platforminfo[ self.platforminfo.size ] = struct;
    }
    
    assert( self.platforminfo.size == chances.size, "<dev string:x63>" );
    
    for ( i = 0; i < self.platforminfo.size ; i++ )
    {
        chancearr = self.platforminfo[ i ].chance;
        chancearr[ chancearr.size ] = chances[ i ];
        self.platforminfo[ i ].chance = chancearr;
    }
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 3
// Checksum 0xca53b4c8, Offset: 0x2418
// Size: 0x13b
function setupplatform( platform, chanceset, issafe = 0 )
{
    if ( issafe && self.var_2c90f07c53421d58.size > 0 )
    {
        platforminfo = undefined;
        
        if ( self.currentfloor >= 40 )
        {
            for ( i = 0; i < self.var_2c90f07c53421d58.size ; i++ )
            {
                if ( self.var_2c90f07c53421d58[ i ].priority == "high" )
                {
                    platforminfo = self.var_2c90f07c53421d58[ i ];
                    break;
                }
            }
        }
        else
        {
            platforminfo = self.var_2c90f07c53421d58[ randomintrange( 0, self.var_2c90f07c53421d58.size ) ];
        }
        
        self thread [[ platforminfo.func ]]( platform );
        return;
    }
    
    num = randomint( 100 );
    
    for ( i = 0; i < self.platforminfo.size ; i++ )
    {
        if ( num < self.platforminfo[ i ].chance[ chanceset ] )
        {
            self thread [[ self.platforminfo[ i ].func ]]( platform );
            return;
        }
    }
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 1
// Checksum 0x12af7a0f, Offset: 0x255b
// Size: 0x1bf
function clearplatform( platform )
{
    if ( isdefined( platform.enemy ) )
    {
        if ( isdefined( platform.enemy.damagetrigger ) )
        {
            platform.enemy.damagetrigger delete();
            platform.enemy.damagetrigger = undefined;
        }
        
        platform.enemy agent_utils::despawnagent();
        platform.enemy = undefined;
    }
    
    if ( isdefined( platform.items ) )
    {
        foreach ( item in platform.items )
        {
            thread ztron_item::clearitem( item );
        }
    }
    
    if ( isdefined( platform.traps ) )
    {
        foreach ( ent in platform.traps )
        {
            if ( isstruct( ent ) )
            {
                ent notify( #"destroy_hazard" );
                continue;
            }
            
            if ( isent( ent ) )
            {
                ent delete();
            }
        }
    }
    
    if ( isdefined( platform ) )
    {
        platform delete();
    }
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 1
// Checksum 0xee2839b0, Offset: 0x2722
// Size: 0x1a5
function function_11cdb353b111e2b6( platform )
{
    var_470df22945e7701d = undefined;
    droplist = undefined;
    armoredzombiechance = 0;
    platform.items = [];
    
    if ( platform.floor < 40 )
    {
        armoredzombiechance = 10;
    }
    else if ( platform.floor < 60 )
    {
        armoredzombiechance = 40;
    }
    else
    {
        armoredzombiechance = 80;
    }
    
    num = randomintrange( 0, 100 );
    
    if ( num <= armoredzombiechance )
    {
        var_470df22945e7701d = "light_armored_zombie";
        droplist = "ztron_item_fall_100_light_armored_zombie_droplist";
    }
    else
    {
        var_470df22945e7701d = "basic_zombie";
        droplist = "ztron_item_fall_100_basic_zombie_droplist";
    }
    
    enemydef = ztron_enemy::function_96eea0d09d5640d1( var_470df22945e7701d );
    enemy = ztron_enemy::function_77e1bf43b991b4a( enemydef, 1, platform.origin + ( -7, utility::cointoss() ? 45 : -45, 10 ), 0, undefined, undefined, undefined, undefined, undefined, undefined, 1, 1 );
    
    if ( !isdefined( enemy ) )
    {
        return;
    }
    
    enemy.droplist = droplist;
    enemy.ignoreall = 1;
    bounds = enemy getboundshalfsize();
    damagetrigger = spawn( "trigger_radius", enemy.origin, 0, bounds[ 0 ], bounds[ 2 ] * 2 );
    damagetrigger enablelinkto();
    damagetrigger linkto( enemy );
    enemy.damagetrigger = damagetrigger;
    enemy.platform = platform;
    damagetrigger thread function_b57d268d1742622c();
    
    /#
        enemy thread drawtrigger( damagetrigger );
    #/
    
    platform.enemy = enemy;
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 1
// Checksum 0x1182499, Offset: 0x28cf
// Size: 0x39
function function_6335ecebf4fd23e7( platform )
{
    platform.issafe = 1;
    
    if ( platform.floor > 20 )
    {
        platform.canmove = 1;
    }
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 3
// Checksum 0x4dd4b036, Offset: 0x2910
// Size: 0x1f1
function function_b770b6610752361d( platform, left, right )
{
    platformbounds = function_decb653c5689e4ca( "sat_zm_ztron_platform_normal" );
    contentsoverride = trace::create_contents( 0, 0, 0, 0, 1, 0, 0, 0, 1 );
    lefttrace = trace::sphere_trace( platform.origin, platform.origin + ( 0, -800, 0 ), 5, platform, contentsoverride );
    
    if ( isdefined( lefttrace[ "entity" ] ) )
    {
        left = lefttrace[ "entity" ].origin + ( 0, platformbounds[ 1 ] * 2, 0 );
    }
    else
    {
        left = ( platform.origin[ 0 ], self.lefttop[ 1 ] + platformbounds[ 1 ], platform.origin[ 2 ] );
    }
    
    if ( platform.origin[ 1 ] - left[ 1 ] < 30 || platform.origin[ 1 ] - left[ 1 ] > 500 )
    {
        left = undefined;
    }
    
    righttrace = trace::sphere_trace( platform.origin, platform.origin + ( 0, 800, 0 ), 5, platform, contentsoverride );
    
    if ( isdefined( righttrace[ "entity" ] ) )
    {
        right = righttrace[ "entity" ].origin - ( 0, platformbounds[ 1 ] * 2, 0 );
    }
    else
    {
        right = ( platform.origin[ 0 ], self.rightbottom[ 1 ] - platformbounds[ 1 ], platform.origin[ 2 ] );
    }
    
    if ( right[ 1 ] - platform.origin[ 1 ] < 30 || right[ 1 ] - platform.origin[ 1 ] > 500 )
    {
        right = undefined;
    }
    
    return [ left, right ];
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 3
// Checksum 0xfe49fea1, Offset: 0x2b0a
// Size: 0xac
function function_7ba98913c0d2be54( platform, left, right )
{
    platform endon( #"death" );
    wait randomint( 3 );
    target = utility::cointoss() ? left : right;
    firstmove = 1;
    
    while ( isdefined( platform ) )
    {
        time = randomintrange( 4, 7 );
        
        if ( firstmove )
        {
            time = randomintrange( 3, 5 );
            firstmove = 0;
        }
        
        platform moveto( target, time );
        wait time + randomintrange( 1, 3 );
        target = target == left ? right : left;
    }
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 1
// Checksum 0xd7ff3ed0, Offset: 0x2bbe
// Size: 0x84
function function_f2d845115689e541( platform )
{
    platform setmodel( "sat_zm_ztron_platform_dmg" );
    platform.isbroken = 1;
    platform.issafe = 0;
    platform.canmove = 0;
    var_7089410b4e99793d = self.currentfloor >= 20 && randomintrange( 0, 100 ) > 60 || self.currentfloor > 60;
    
    if ( var_7089410b4e99793d )
    {
        function_50fdfcf7abf842af( platform );
    }
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 2
// Checksum 0xff1fe0a0, Offset: 0x2c4a
// Size: 0x1e1
function function_8adc4846bf5c0c7d( platform, platformdata )
{
    level endon( #"bonus_room_expired" );
    level endon( #"bonus_room_exit_taken" );
    self endon( #"room_done" );
    
    foreach ( data in platformdata )
    {
        if ( !isdefined( platform ) )
        {
            return;
        }
        
        item = undefined;
        params = spawnstruct();
        params.overridelifetime = 9999;
        params.scale = 1;
        params.modelspinning = 0;
        params.overrideangles = data.angles;
        
        if ( data.var_5d94300d10f1345d )
        {
            bundlename = ztron_item::function_71e133b37011bee6( data.name );
            item = ztron_item::spawnitem( bundlename, platform.origin + data.relativepos, 0, undefined, params );
            platform.items[ platform.items.size ] = item;
        }
        else
        {
            if ( !isdefined( var_144d371eb3935618 ) )
            {
                var_144d371eb3935618 = common_item::items_selectfromlist( data.name, 1 )[ 0 ];
            }
            
            item = ztron_item::spawnitem( var_144d371eb3935618, platform.origin + data.relativepos, 0, undefined, params );
            platform.items[ platform.items.size ] = item;
        }
        
        /#
            function_c88f336792c0efe2( item );
        #/
        
        waitframe();
    }
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 1
// Checksum 0xc8683291, Offset: 0x2e33
// Size: 0x135
function function_50fdfcf7abf842af( platform )
{
    platform.issafe = platform.issafe ?? 1;
    platform.canmove = platform.canmove ?? 1;
    platform.items = [];
    validplatforms = [];
    
    foreach ( data in self.platformdata )
    {
        if ( self.currentfloor >= data.minfloor && self.currentfloor <= data.maxfloor )
        {
            validplatforms[ validplatforms.size ] = data;
        }
    }
    
    if ( validplatforms.size == 0 )
    {
        return;
    }
    
    platformdata = validplatforms[ randomintrange( 0, validplatforms.size ) ].data;
    thread function_8adc4846bf5c0c7d( platform, platformdata );
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 1
// Checksum 0x5b156cfc, Offset: 0x2f70
// Size: 0x196
function function_dbe50cebe2fefec7( platform )
{
    platformbounds = function_decb653c5689e4ca( "sat_zm_ztron_platform_normal" );
    spikebounds = function_decb653c5689e4ca( "sat_zm_ztron_props_pungi_sticks" );
    platform.traps = [];
    randomnumber = randomint( 100 );
    
    if ( randomnumber >= 60 )
    {
        pos = ( platform.origin[ 0 ], platform.origin[ 1 ] - platformbounds[ 1 ] + spikebounds[ 1 ] + 5, platform.origin[ 2 ] + 10 );
    }
    else
    {
        pos = ( platform.origin[ 0 ], platform.origin[ 1 ] + platformbounds[ 1 ] - spikebounds[ 1 ], platform.origin[ 2 ] + 10 );
    }
    
    spike = utility::spawn_model( "sat_zm_ztron_props_pungi_sticks", pos );
    platform.traps[ platform.traps.size ] = spike;
    self.entities[ self.entities.size ] = spike;
    trigger = spawn( "trigger_box", pos + ( 0, 0, 20 ), 0, spikebounds, spikebounds );
    
    if ( isdefined( trigger ) )
    {
        trigger thread function_91e092f9e9cb6afd();
        platform.traps[ platform.traps.size ] = trigger;
        self.entities[ self.entities.size ] = trigger;
        
        /#
            thread drawtrigger( trigger );
        #/
    }
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 1
// Checksum 0x93c37fd3, Offset: 0x310e
// Size: 0xde
function function_7b8579d50eac050c( platform )
{
    trap = spawnstruct();
    trap.trigger_height = 100;
    ztron_hazard_electric_pole::function_26b48882ff839ed7( trap, 0, platform.origin + ( -25, 0, 0 ), ( 0, 0, 0 ) );
    platform.traps = [];
    platform.traps[ platform.traps.size ] = trap;
    platform.issafe = 0;
    platform.canmove = 0;
    var_7089410b4e99793d = self.currentfloor >= 20 && randomintrange( 0, 100 ) > 60 || self.currentfloor > 60;
    
    if ( var_7089410b4e99793d )
    {
        function_50fdfcf7abf842af( platform );
    }
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 1
// Checksum 0x47f1a881, Offset: 0x31f4
// Size: 0x184
function function_5c7854f2c9e5c2e7( platform )
{
    platform setmodel( "sat_zm_ztron_platform_spring" );
    trap = spawnstruct();
    trap.origin = platform.origin + ( 10, 0, 0 );
    trap.script_parameters = "velocity;0;0;450";
    trap.script_model = platform;
    trap.angles = ( 0, 0, 0 );
    trap.triggerradius = 64;
    trap.triggerheight = 10;
    var_30e71bcd26a1f3eb = namespace_47c07e1713f6efbc::function_2d48b73f18001723( trap );
    platform.traps = [];
    platform.traps[ platform.traps.size ] = trap;
    params = spawnstruct();
    params.overridelifetime = 9999;
    params.scale = 1;
    params.modelspinning = 0;
    items = common_item::items_selectfromlist( "ztron_item_fall_100_powerups_spawnlist", 1 );
    item = ztron_item::spawnitem( items[ 0 ], platform.origin + ( 0, 0, self.floorheight + 50 ), 0, undefined, params );
    platform.items = [];
    platform.items[ platform.items.size ] = item;
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 1
// Checksum 0x6e159cc7, Offset: 0x3380
// Size: 0x58
function function_c3a78607d759239d( platform )
{
    platform setmodel( "sat_zm_ztron_platform_ice" );
    platform.issafe = 1;
    platform.canmove = 1;
    var_7089410b4e99793d = randomintrange( 0, 100 ) > 75;
    
    if ( var_7089410b4e99793d )
    {
        function_50fdfcf7abf842af( platform );
    }
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 0
// Checksum 0x3391de13, Offset: 0x33e0
// Size: 0x18c
function function_50cdbd4410e99489()
{
    self notify( #"hash_c43f6e8694294911" );
    self endon( #"hash_c43f6e8694294911" );
    level endon( #"bonus_room_expired" );
    level endon( #"bonus_room_exit_taken" );
    self waittill( #"hash_ba90110b6362c33a" );
    var_daad0f8b5bdeb631 = getomnvar( "ui_ztron_fall_hundred_current_state" ) != 2;
    setomnvar( "ui_ztron_fall_hundred_current_state", 1 );
    rankarr = [];
    
    foreach ( player in level.players )
    {
        rankinfo = { #player:player, #floor:player.reachedfloor };
        rankarr[ rankarr.size ] = rankinfo;
    }
    
    rankarr = arraysort( rankarr, undefined, &function_14d6c5bd6383da2b );
    
    for ( i = 0; i < rankarr.size ; i++ )
    {
        if ( i > 3 )
        {
            break;
        }
        
        player = rankarr[ i ].player;
        
        if ( isdefined( player ) )
        {
            setomnvar( "ui_ztron_fall_hundred_rank_" + player.sessionuimemberindex, i + 1 );
        }
    }
    
    if ( var_daad0f8b5bdeb631 )
    {
        wait 20;
        self.exit notify( #"trigger" );
    }
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 2, eflags: 0x4
// Checksum 0x28072e5b, Offset: 0x3574
// Size: 0x2c, Type: bool
function private function_14d6c5bd6383da2b( var_dce4d3847abb0223, var_dce4d4847abb0456 )
{
    return var_dce4d3847abb0223.floor > var_dce4d4847abb0456.floor;
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 0
// Checksum 0xa07178eb, Offset: 0x35a9
// Size: 0x83
function function_c66da980a3899cbc()
{
    self notify( #"hash_82b1dafb8d1890e0" );
    self endon( #"hash_82b1dafb8d1890e0" );
    level endon( #"bonus_room_expired" );
    level endon( #"bonus_room_exit_taken" );
    
    if ( isdefined( self.timeout ) )
    {
        waitingtime = clamp( self.timeout - 20, 0, self.timeout );
        wait waitingtime;
        
        if ( getomnvar( "ui_ztron_fall_hundred_current_state" ) != 1 )
        {
            setomnvar( "ui_ztron_fall_hundred_current_state", 2 );
        }
    }
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 1
// Checksum 0x2f4328f0, Offset: 0x3634
// Size: 0xce
function function_1b720d070a163cd8( room )
{
    self notify( #"hash_f2ff0588682c5c4e" );
    self endon( #"hash_f2ff0588682c5c4e" );
    level endon( #"bonus_room_expired" );
    level endon( #"bonus_room_exit_taken" );
    waittime = self.floor >= 50 ? 0.5 : 0.7;
    wait waittime;
    
    if ( isdefined( self ) )
    {
        forwardvec = room.rightbottom - room.lefttop;
        forwardvec = ( forwardvec[ 0 ], forwardvec[ 1 ], 0 );
        playfx( utility::getfx( "ztron_fall_hundred_broken_platform" ), self.origin, forwardvec );
        ztron_sound::ztron_playsound( "ztron_fragile_platform_broken", self.origin );
        self delete();
    }
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 1
// Checksum 0x72555425, Offset: 0x370a
// Size: 0x191
function updateplayerfloor( room )
{
    self notify( #"hash_da3b3a54ddf87177" );
    self endon( #"hash_da3b3a54ddf87177" );
    level endon( #"bonus_room_expired" );
    level endon( #"bonus_room_exit_taken" );
    self endon( #"disconnect" );
    self.reachedfloor = 0;
    
    while ( true )
    {
        waittillframeend();
        pos = self.origin + ( 0, 0, -5 );
        contentsoverride = trace::create_contents( 0, 0, 0, 0, 1, 0, 0, 0, 1 );
        trace = trace::sphere_trace( self.origin, pos, 10, undefined, contentsoverride, 1, 1 );
        ent = trace[ "entity" ];
        
        if ( isdefined( ent.floor ) )
        {
            if ( ent.isbroken && !ent.deleted )
            {
                ent.deleted = 1;
                ent thread function_1b720d070a163cd8( room );
            }
            
            if ( ent.floor > self.reachedfloor )
            {
                self.reachedfloor = ent.floor;
                setomnvar( "ui_ztron_fall_hundred_current_floor_" + self.sessionuimemberindex, self.reachedfloor );
                score = self.reachedfloor == 100 ? 10000 : 1000;
                ztron_score::function_785f67d24e19bb27( score, #"ztron_score" );
            }
        }
        
        waitframe();
    }
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 0
// Checksum 0x6364fdb0, Offset: 0x38a3
// Size: 0x94
function function_91e092f9e9cb6afd()
{
    self notify( #"hash_7a9e083141d63ab0" );
    self endon( #"hash_7a9e083141d63ab0" );
    self endon( #"death" );
    level endon( #"bonus_room_expired" );
    level endon( #"bonus_room_exit_taken" );
    
    while ( isdefined( self ) )
    {
        self waittill( #"trigger", ent );
        
        if ( ent.no_hazards )
        {
            continue;
        }
        
        if ( isplayer( ent ) )
        {
            ent dodamage( 50, ent.origin, undefined, self, "MOD_IMPACT" );
        }
    }
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 0
// Checksum 0x94bb69fa, Offset: 0x393f
// Size: 0x83
function function_b57d268d1742622c()
{
    self notify( #"hash_4095ef4e009b624a" );
    self endon( #"hash_4095ef4e009b624a" );
    self endon( #"death" );
    level endon( #"bonus_room_expired" );
    level endon( #"bonus_room_exit_taken" );
    
    while ( isdefined( self ) )
    {
        self waittill( #"trigger", ent );
        
        if ( isplayer( ent ) )
        {
            ent dodamage( 50, ent.origin, undefined, self, "MOD_IMPACT" );
        }
    }
}

/#

    // Namespace namespace_2d7c3917ca8e17d2
    // Params 1, eflags: 0x4
    // Checksum 0x6179acbc, Offset: 0x39ca
    // Size: 0x72, Type: dev
    function private drawtrigger( trigger )
    {
        if ( getdvarint( @"hash_a22ca77838e630be", 0 ) )
        {
            level endon( #"ztron_game_is_over" );
            level endon( #"bonus_room_expired" );
            level endon( #"bonus_room_exit_taken" );
            
            while ( isdefined( trigger ) )
            {
                drawtrigger( trigger, ( 0, 1, 0 ), 0, 0, 0, ( 0, 1, 0 ) );
                waitframe();
            }
        }
    }

#/

// Namespace namespace_2d7c3917ca8e17d2
// Params 0
// Checksum 0xa20691c1, Offset: 0x3a44
// Size: 0xc5
function function_192b6db187ac7f6d()
{
    lowestfloor = 100;
    var_9a14b4abf1281fa3 = 0;
    
    foreach ( player in level.players )
    {
        if ( isdefined( player.reachedfloor ) )
        {
            var_9a14b4abf1281fa3 = 1;
            
            if ( player.reachedfloor < lowestfloor )
            {
                lowestfloor = player.reachedfloor;
            }
        }
    }
    
    return var_9a14b4abf1281fa3 ? lowestfloor : 0;
}

// Namespace namespace_2d7c3917ca8e17d2
// Params 1
// Checksum 0x40c579c9, Offset: 0x3b12
// Size: 0x2d
function function_e353c74adcbccfbe( idamage )
{
    var_77eacb1a09c7953b = idamage * 0.45;
    
    if ( var_77eacb1a09c7953b < 40 )
    {
        var_77eacb1a09c7953b = 0;
    }
    
    return var_77eacb1a09c7953b;
}

/#

    // Namespace namespace_2d7c3917ca8e17d2
    // Params 1, eflags: 0x4
    // Checksum 0x50b711e5, Offset: 0x3b48
    // Size: 0x75, Type: dev
    function private function_c88f336792c0efe2( item )
    {
        if ( !isdefined( self.var_bf1d7710e857cb90 ) )
        {
            self.var_bf1d7710e857cb90 = [];
        }
        
        if ( item )
        {
            if ( !isdefined( self.var_bf1d7710e857cb90[ item.var_8593f17418a81b6e ] ) )
            {
                self.var_bf1d7710e857cb90[ item.var_8593f17418a81b6e ] = 1;
                return;
            }
            
            self.var_bf1d7710e857cb90[ item.var_8593f17418a81b6e ]++;
        }
    }

    // Namespace namespace_2d7c3917ca8e17d2
    // Params 0, eflags: 0x4
    // Checksum 0xcf620f6, Offset: 0x3bc5
    // Size: 0xe0, Type: dev
    function private function_f4c77a981e1c2796()
    {
        if ( getdvarint( @"hash_a22ca77838e630be", 0 ) )
        {
            if ( isdefined( self.var_bf1d7710e857cb90 ) )
            {
                x = 500;
                y = 500;
                
                foreach ( item, count in self.var_bf1d7710e857cb90 )
                {
                    ztron_debug::function_7a494955e7b24aa3( x, y, "<dev string:x9a>" + item + "<dev string:xa1>" + count, ( 1, 0, 0 ), 30, 2 );
                    y += 20;
                }
            }
        }
    }

#/
