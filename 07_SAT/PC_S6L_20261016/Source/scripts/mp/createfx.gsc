// scripts\mp\createfx.gsc  (hash_515715367b555558.gscc) (size: 2896 Bytes / 0xb50 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc4e6a2dd (3303449309)
// size ...... 2896 (0xb50)
// includes .. 4   (offset: 0xa94)
// strings ... 3   (offset: 0xab4)
// dev strs .. 10  (offset: 0xad8)
// exports ... 7   (offset: 0x644)
// cseg ...... 0x81 + 0x5c3 (0x644)
// imports ... 25  (offset: 0x75c)
// animtree1 . 0   (offset: 0xb50)
// animtree2 . 0   (offset: 0xb50)
#using scripts\common\createfx;
#using scripts\common\fx;
#using scripts\common\utility;
#using scripts\mp\common\utility\player;

#namespace createfx;

// Namespace createfx
// Params 0
// Checksum 0x59451a37, Offset: 0x9f
// Size: 0x14e
function createfx()
{
    level.func_position_player = &utility::empty_init_func;
    level.func_position_player_get = &func_position_player_get;
    level.func_loopfxthread = &fx::loopfxthread;
    level.func_oneshotfxthread = &fx::oneshotfxthread;
    level.func_create_loopsound = &fx::create_loopsound;
    level.func_updatefx = &restart_fx_looper;
    level.func_process_fx_rotater = &process_fx_rotater;
    level.func_player_speed = &func_player_speed;
    level.mp_createfx = 1;
    level.callbackstartgametype = &utility::empty_init_func;
    level.callbackplayeractive = &utility::empty_init_func;
    level.callbackplayerconnect = &utility::empty_init_func;
    level.callbackplayerdisconnect = &utility::empty_init_func;
    level.callbackplayerdamage = &utility::empty_init_func;
    level.callbackplayerkilled = &utility::empty_init_func;
    level.callbackplayerlaststand = &utility::empty_init_func;
    level.callbackplayerconnect = &callback_playerconnect;
    level.callbackplayermigrated = &utility::empty_init_func;
    level.var_4524771918fe585f = &utility::empty_init_func;
    level.var_880cfcfec57ca836 = &utility::empty_init_func;
    level.var_16eab40d8f2ae445 = &utility::empty_init_func;
    thread reflectionprobe_hide_hp();
    thread reflectionprobe_hide_front();
    thread func_get_level_fx();
    createfx_common();
    level waittill( #"eternity" );
}

// Namespace createfx
// Params 1
// Checksum 0x7a669cfa, Offset: 0x1f5
// Size: 0x1f
function func_position_player_get( lastplayerorigin )
{
    return level.player.origin;
}

// Namespace createfx
// Params 0
// Checksum 0xc0903aca, Offset: 0x21d
// Size: 0xa6
function callback_playerconnect()
{
    self waittill( #"begin" );
    
    if ( !isdefined( level.player ) )
    {
        spawnpoints = getentarray( "mp_global_intermission", #classname );
        self spawn( spawnpoints[ 0 ].origin, spawnpoints[ 0 ].angles );
        player::updatesessionstate( "playing", "" );
        self.maxhealth = 10000000;
        self.health = 10000000;
        level.player = self;
        thread createfxlogic();
        return;
    }
    
    kick( self getentitynumber() );
}

// Namespace createfx
// Params 0
// Checksum 0x33c19eda, Offset: 0x2cb
// Size: 0x55
function func_player_speed()
{
    scale = level._createfx.player_speed / 190;
    level.player setmovespeedscale( scale );
    setdvar( @"g_speed", level._createfx.player_speed );
}

// Namespace createfx
// Params 0
// Checksum 0xe66dcd0b, Offset: 0x328
// Size: 0x217
function reflectionprobe_hide_hp()
{
    /#
        neutralpoint = getentarray( "<dev string:x24>", #targetname );
        enemypoint = getentarray( "<dev string:x3a>", #targetname );
        friendpoint = getentarray( "<dev string:x56>", #targetname );
        contestpoint = getentarray( "<dev string:x73>", #targetname );
        
        foreach ( zone in neutralpoint )
        {
            zone hide();
        }
        
        foreach ( zone in enemypoint )
        {
            zone hide();
        }
        
        foreach ( zone in friendpoint )
        {
            zone hide();
        }
        
        foreach ( zone in contestpoint )
        {
            zone hide();
        }
    #/
}

// Namespace createfx
// Params 0
// Checksum 0xd45b79d1, Offset: 0x547
// Size: 0xfd
function reflectionprobe_hide_front()
{
    /#
        fzaf = getent( "<dev string:x91>", #targetname );
        
        if ( isdefined( fzaf ) )
        {
            fzaf hide();
        }
        
        fzae = getent( "<dev string:xb1>", #targetname );
        
        if ( isdefined( fzae ) )
        {
            fzae hide();
        }
        
        fzac = getent( "<dev string:xd0>", #targetname );
        
        if ( isdefined( fzac ) )
        {
            fzac hide();
        }
        
        fzxf = getent( "<dev string:xf1>", #targetname );
        
        if ( isdefined( fzxf ) )
        {
            fzxf hide();
        }
        
        fzxe = getent( "<dev string:x10f>", #targetname );
        
        if ( isdefined( fzxe ) )
        {
            fzxe hide();
        }
        
        var_316f8b30d1dcad17 = getent( "<dev string:x12c>", #targetname );
        
        if ( isdefined( var_316f8b30d1dcad17 ) )
        {
            var_316f8b30d1dcad17 hide();
        }
    #/
}

