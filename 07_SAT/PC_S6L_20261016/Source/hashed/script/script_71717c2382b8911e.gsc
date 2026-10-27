// script_71717c2382b8911e  (hash_71717c2382b8911e.gscc) (size: 4675 Bytes / 0x1243 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfee38c8f (4276325519)
// size ...... 4675 (0x1243)
// includes .. 11  (offset: 0x1133)
// strings ... 14  (offset: 0x118b)
// dev strs .. 0   (offset: 0x1243)
// exports ... 16  (offset: 0xa9f)
// cseg ...... 0x175 + 0x92a (0xa9f)
// imports ... 36  (offset: 0xd1f)
// animtree1 . 0   (offset: 0x1243)
// animtree2 . 0   (offset: 0x1243)
#using script_31ee2a173f3499b7;
#using script_4ce55cfc81c444ad;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\zm\ztron\ztron_bonus_room;
#using scripts\mp\zm\ztron\ztron_camera;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_tutorial;
#using scripts\mp\zm\ztron\ztron_utility;
#using scripts\mp\zm\ztron\ztron_vfx;

#namespace namespace_4ad55357f99ed963;

// Namespace namespace_4ad55357f99ed963
// Params 0, eflags: 0x5
// Checksum 0xa2c9eee5, Offset: 0x193
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_881fb16e521d84ca", undefined, undefined, &init );
}

// Namespace namespace_4ad55357f99ed963
// Params 0
// Checksum 0xdebb9dce, Offset: 0x1b4
// Size: 0x9
function init()
{
    thread initside();
}

// Namespace namespace_4ad55357f99ed963
// Params 0
// Checksum 0x314e88a0, Offset: 0x1c5
// Size: 0xd3
function initside()
{
    level utility::flag_wait( "ztron_bonus_room_initialized" );
    var_a8d8980c65b4b0de = ztron_bonus_room::function_98dedbfc79dc3572( "side_scroller_player" );
    
    if ( var_a8d8980c65b4b0de.size > 0 )
    {
        foreach ( room in var_a8d8980c65b4b0de )
        {
            room.setupcallback = &sidesetup;
            room.var_d822af3942fcbc3d = &function_275188d0796bb347;
            room.var_d4ea8a279b48a561 = 1;
            room.var_e1b2540e2c81f811 = 1;
        }
    }
}

// Namespace namespace_4ad55357f99ed963
// Params 2
// Checksum 0x9e81a6ba, Offset: 0x2a0
// Size: 0x176
function function_275188d0796bb347( room, var_4659d2db90ce8d11 = 0 )
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
            
            player setjumpheightscale( 1 );
        }
        else
        {
            player setjumpheightscale( 4 );
        }
        
        player ztron_ui::function_787d89891b886acf( "JUMP_AGAINST_WALL_HINT", 8, 1 );
    }
    
    level ztron_camera::function_672265518094104d( !var_4659d2db90ce8d11 );
}

// Namespace namespace_4ad55357f99ed963
// Params 1
// Checksum 0xd5c7858c, Offset: 0x41e
// Size: 0xab
function sidesetup( room )
{
    level.ztron.sideviewactive = 1;
    level.var_8972cc8b6869f399 = 1;
    level.var_5ac542875a6578d7 = 1;
    room.var_76a1c6d566d98aed = 1;
    level ztron_ui::function_f5177e090dadd8f4( 2 );
    spawnenemy( room );
    room function_9fb16ae2c245be92();
    setdvar( @"walljump_enabled", 1 );
    level.ztron.var_ffe07d19d8b6c7b = 2;
    level.ztron.playerrespawnoverride = &onplayerrespawn;
    level thread sidecleanup( room );
}

// Namespace namespace_4ad55357f99ed963
// Params 1
// Checksum 0x9658dbaa, Offset: 0x4d1
// Size: 0x9c
function sidecleanup( room )
{
    result = level utility::waittill_any_return( "bonus_room_expired", "ztron_game_is_over" );
    function_275188d0796bb347( room, 1 );
    level.ztron.var_ffe07d19d8b6c7b = undefined;
    level.ztron.playerrespawnoverride = undefined;
    level.var_8972cc8b6869f399 = 0;
    level.ztron.sideviewactive = 0;
    level.var_5ac542875a6578d7 = 0;
    ztron_ui::function_d43781ee65f990d();
    level ztron_ui::function_f5177e090dadd8f4( 0 );
    thread function_c87414f55708c1d3( room );
}

// Namespace namespace_4ad55357f99ed963
// Params 1, eflags: 0xc
// Checksum 0xec4cccbd, Offset: 0x575
// Size: 0x52
function private function_c87414f55708c1d3( room )
{
    self notify( #"hash_dc4c19f49cbee9f9" );
    self endon( #"hash_dc4c19f49cbee9f9" );
    level endon( #"ztron_game_is_over" );
    level waittill( #"round_begin_warm_up" );
    wait 0.1;
    setdvar( @"walljump_enabled", 0 );
}

// Namespace namespace_4ad55357f99ed963
// Params 1
// Checksum 0x3a1db232, Offset: 0x5cf
// Size: 0xc0
function onplayerrespawn( params )
{
    self notify( #"hash_1024a1f5a5703513" );
    self endon( #"hash_1024a1f5a5703513" );
    
    if ( self.ztron.checkpoint.valid )
    {
        spot = self.ztron.checkpoint.origin;
    }
    else
    {
        room = level.ztron.var_8a9067aa4cd65369;
        spot = room.playersstarts[ self.sessionuimemberindex ].origin;
    }
    
    thread function_a6c97d841e5c9801();
    thread ztron_player_utility::playerrespawnnow( 0, spot, 0 );
}

// Namespace namespace_4ad55357f99ed963
// Params 0
// Checksum 0xa1d452a0, Offset: 0x697
// Size: 0x46
function function_a6c97d841e5c9801()
{
    self notify( #"hash_539ddced7d90137a" );
    self endon( #"hash_539ddced7d90137a" );
    self endon( #"disconnect" );
    level endon( #"ztron_game_is_over" );
    self waittill( #"last_stand_exit" );
    ztron_vfx::stopburn();
}

// Namespace namespace_4ad55357f99ed963
// Params 1
// Checksum 0xdae06c5c, Offset: 0x6e5
// Size: 0x9c
function spawnenemy( room )
{
    enemyspawnpoints = room.enemyspawnpoints;
    
    if ( !isdefined( enemyspawnpoints ) )
    {
        return;
    }
    
    foreach ( point in enemyspawnpoints )
    {
        room thread ztron_bonus_room::function_bd3a5142e2a2e9d6( point );
    }
}

// Namespace namespace_4ad55357f99ed963
// Params 0
// Checksum 0x41c0263c, Offset: 0x789
// Size: 0x16, Type: bool
function function_4fd806686bdab01e()
{
    return isdefined( level.ztron.var_8a9067aa4cd65369 );
}

// Namespace namespace_4ad55357f99ed963
// Params 0
// Checksum 0x66a05a80, Offset: 0x7a8
// Size: 0x3d, Type: bool
function function_b15de9c11e1c3e1c()
{
    return isdefined( level.ztron.var_8a9067aa4cd65369 ) && level.ztron.var_8a9067aa4cd65369.type == "side_scroller_player";
}

// Namespace namespace_4ad55357f99ed963
// Params 0, eflags: 0x4
// Checksum 0x93d63f55, Offset: 0x7ee
// Size: 0xd0
function private function_9fb16ae2c245be92()
{
    self.var_e5f9ec88d8c61c3f = utility::getstructarray( "bonus_" + self.name + "_tutorial", "targetname" );
    
    foreach ( crabstruct in self.var_e5f9ec88d8c61c3f )
    {
        crabstruct.crab = ztron_tutorial::function_b18e5953164335be( crabstruct );
        crabstruct.crab thread ztron_util::function_36239518d8da65f0( level, "bonus_room_expired" );
        crabstruct thread crabthink();
    }
}

// Namespace namespace_4ad55357f99ed963
// Params 0, eflags: 0x4
// Checksum 0xd19f927a, Offset: 0x8c6
// Size: 0x42
function private crabthink()
{
    level endon( #"ztron_game_is_over", #"bonus_room_expired" );
    
    while ( true )
    {
        ent = ztron_util::function_2f4d27d87e05d778();
        
        if ( ent )
        {
            function_137ab1714847e305( ent );
            wait 15;
        }
    }
}

// Namespace namespace_4ad55357f99ed963
// Params 1, eflags: 0x4
// Checksum 0x530cc3a2, Offset: 0x910
// Size: 0x18f
function private function_137ab1714847e305( ent )
{
    switch ( int( self.script_noteworthy ) )
    {
        case 1:
            if ( !isdefined( ent.ztron.var_a967d35fe4fb3bdb ) )
            {
                ent.ztron.var_a967d35fe4fb3bdb = 0;
            }
            
            if ( ent.ztron.var_a967d35fe4fb3bdb < 3 )
            {
                self.crab ztron_dialog::function_7e3f6329d9afcdc1( "crab_side_hint_wall_jump", 1 );
                ent.ztron.var_a967d35fe4fb3bdb++;
            }
            
            break;
        case 2:
            if ( !isdefined( ent.ztron.var_1f6e31a0febbe716 ) )
            {
                ent.ztron.var_1f6e31a0febbe716 = 0;
            }
            
            if ( ent.ztron.var_1f6e31a0febbe716 < 3 )
            {
                self.crab ztron_dialog::function_7e3f6329d9afcdc1( "crab_side_hint_zip_line", 1 );
                ent.ztron.var_1f6e31a0febbe716++;
            }
            
            break;
        case 3:
            if ( !self.crab.var_64bdade55f294e67 )
            {
                self.crab ztron_dialog::function_7e3f6329d9afcdc1( "crab_side_hint_welcome", 1 );
                self.crab.var_64bdade55f294e67 = 1;
            }
            
            break;
        default:
            break;
    }
}

