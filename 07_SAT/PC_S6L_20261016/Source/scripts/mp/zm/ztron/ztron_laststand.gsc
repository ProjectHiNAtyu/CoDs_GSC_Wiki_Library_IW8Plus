// scripts\mp\zm\ztron\ztron_laststand.gsc  (hash_68fab5bc8899cd7c.gscc) (size: 7255 Bytes / 0x1c57 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6d91279b (1838229403)
// size ...... 7255 (0x1c57)
// includes .. 13  (offset: 0x1b27)
// strings ... 15  (offset: 0x1b8f)
// dev strs .. 0   (offset: 0x1c57)
// exports ... 14  (offset: 0x11c3)
// cseg ...... 0x17c + 0x1047 (0x11c3)
// imports ... 62  (offset: 0x13f3)
// animtree1 . 0   (offset: 0x1c57)
// animtree2 . 0   (offset: 0x1c57)
#using script_31ee2a173f3499b7;
#using script_54a05cbb2455bc6f;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\player;
#using scripts\mp\damage;
#using scripts\mp\laststand;
#using scripts\mp\zm\ztron\ztron_camera;
#using scripts\mp\zm\ztron\ztron_main;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_score;

#namespace ztron_laststand;

// Namespace ztron_laststand
// Params 0
// Checksum 0x8e76c384, Offset: 0x19a
// Size: 0x10
function init()
{
    level.callbackplayerlaststand = &callback_playerlaststand;
}

// Namespace ztron_laststand
// Params 0
// Checksum 0x72ac143c, Offset: 0x1b2
// Size: 0x13a, Type: bool
function function_ce4362928eb7b0c3()
{
    var_de4d455009d9522a = ztron_score::function_4f2852a8848fa4ce();
    
    if ( var_de4d455009d9522a > 0 )
    {
        return true;
    }
    
    docheck = 0;
    
    if ( ztron_main::function_4da200e9b8d58a3c() == 1 )
    {
        docheck = 1;
    }
    else if ( ztron_main::function_4da200e9b8d58a3c() == 5 )
    {
        docheck = 0;
    }
    else if ( ztron_main::function_4da200e9b8d58a3c() == 3 )
    {
        if ( isdefined( level.ztron.var_8a9067aa4cd65369 ) && level.ztron.var_8a9067aa4cd65369.deathallowed )
        {
            docheck = 1;
        }
    }
    
    if ( !docheck )
    {
        return true;
    }
    
    foreach ( player in level.players )
    {
        if ( self == player )
        {
            continue;
        }
        
        var_de4d455009d9522a = player ztron_score::function_4f2852a8848fa4ce();
        
        if ( var_de4d455009d9522a > 0 )
        {
            return true;
        }
        
        if ( player player::isreallyalive() )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace ztron_laststand
// Params 10
// Checksum 0x8acb3d10, Offset: 0x2f5
// Size: 0x104, Type: bool
function callback_playerlaststand( einflictor, attacker, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration )
{
    if ( !isdefined( self.last_stand_count ) )
    {
        self.last_stand_count = 0;
    }
    
    self.last_stand_count++;
    
    if ( player::isinlaststand( self ) )
    {
        return false;
    }
    
    if ( !function_ce4362928eb7b0c3() )
    {
        self.ztron.dead = 1;
        return false;
    }
    
    self notify( #"laststand" );
    deathdata = damage::playerkilled_initdeathdata( einflictor, attacker, self, idamage, 0, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, 0 );
    damage::playerkilled_parameterfixup( deathdata );
    damage::playerkilled_precalc( deathdata );
    deathdata.laststandkill = 1;
    thread enter( deathdata );
    return true;
}

// Namespace ztron_laststand
// Params 0
// Checksum 0x30f0905, Offset: 0x402
// Size: 0xa7
function last_stand_postfx()
{
    if ( isarray( level.gametypebundle.var_74449a611af9eda2 ) )
    {
        foreach ( fx in level.gametypebundle.var_74449a611af9eda2 )
        {
            pbgpostfxbundlestart( self, fx.laststandpbgpostfxbundle );
        }
    }
}

// Namespace ztron_laststand
// Params 1
// Checksum 0xf47f92b6, Offset: 0x4b1
// Size: 0x270
function enter( params )
{
    level endon( #"ztron_game_is_over" );
    self endon( #"disconnect" );
    self endon( #"last_stand_exit" );
    self.inlaststand = 1;
    val::group_set( "laststand", 0 );
    val::set( "zm_laststand", "ignoreme", 1 );
    
    if ( !self.ztron.var_a4c2f70bbc713f98 )
    {
        ztron_camera::function_c84d3066c4f2d6fc();
    }
    else
    {
        thread last_stand_postfx();
    }
    
    self notify( #"last_stand_enter" );
    level notify( #"last_stand_enter", self );
    self setsolid( 0 );
    function_4cc4db36852a8494();
    callback::callback( #"player_laststand", params );
    longbleed = 1;
    bleedouttime = 60;
    
    if ( ztron_fate::hasfate( 6 ) )
    {
        bleedouttime = 40;
    }
    
    if ( ztron_score::function_4f2852a8848fa4ce() > 0 )
    {
        bleedouttime = 5;
        
        if ( self.ztron.healthRegenScale > 1 )
        {
            bleedouttime = 3;
        }
        
        longbleed = 0;
    }
    else if ( !level.ztron.var_95d8c7a469393957 )
    {
        foreach ( player in level.players )
        {
            if ( player == self )
            {
                continue;
            }
            
            if ( player.inlaststand )
            {
                continue;
            }
            
            if ( player.ztron.score.lives < 2 )
            {
                continue;
            }
            
            if ( gettime() < player.ztron.lifedonatecooldown )
            {
                continue;
            }
            
            player ztron_ui::function_787d89891b886acf( "LIFEDONATE_HINT" );
        }
    }
    
    if ( isdefined( level.ztron.var_ffe07d19d8b6c7b ) )
    {
        bleedouttime = level.ztron.var_ffe07d19d8b6c7b;
    }
    
    if ( longbleed && self.ztron.upgradeMask & 32 )
    {
        bleedouttime = int( bleedouttime * 0.75 );
    }
    
    thread laststandtimeout( bleedouttime, longbleed );
}

// Namespace ztron_laststand
// Params 2
// Checksum 0xdd96003e, Offset: 0x729
// Size: 0x15e
function exit( reason, reviver )
{
    if ( !player::isinlaststand( self ) )
    {
        return;
    }
    
    self notify( #"last_stand_exit" );
    level notify( #"last_stand_exit", self );
    self.inlaststand = 0;
    val::group_reset( "laststand" );
    val::reset( "zm_laststand", "ignoreme" );
    self setsolid( 1 );
    
    if ( !self.ztron.var_a4c2f70bbc713f98 )
    {
        ztron_camera::function_28677b8eaecd3c2d();
    }
    
    thread damage_effects::onexitdeathsdoor( 1 );
    thread laststand::last_stand_exit_postfx();
    params = { #reason:reason, #revived:1 };
    callback::callback( #"player_laststand_exit", params );
    self laststandrevive();
    thread function_7ee2bc98c2a16455();
    self.ztron.respawnduration = 0;
    self.ztron.respawnprogress = 0;
    self.ztron.respawnmedics = 0;
    function_51e4dcf6ec6aaf61();
    self.ztron.var_ee46dbdcbbcd7fef = 0;
    setomnvar( "ui_ztron_current_medics_count_" + self.sessionuimemberindex, 0 );
    
    if ( self isconnected() )
    {
        self setclientomnvar( "ui_ztron_zombie_killer_ent_num", -1 );
    }
}

// Namespace ztron_laststand
// Params 0
// Checksum 0xc55d6e71, Offset: 0x88f
// Size: 0x16
function function_7ee2bc98c2a16455()
{
    self endon( #"death_or_disconnect" );
    waitframe();
    function_4cc4db36852a8494();
}

// Namespace ztron_laststand
// Params 0
// Checksum 0xac0269a1, Offset: 0x8ad
// Size: 0xaa
function function_4cc4db36852a8494()
{
    if ( !isdefined( level.gamemodebundle ) )
    {
        self setstance( "stand" );
        return;
    }
    
    var_a4f7e55cfe3459e2 = level.gamemodebundle.var_48ba75867c5a20d2 ?? "NONE";
    
    switch ( var_a4f7e55cfe3459e2 )
    {
        case #"hash_b5d4f2ac1b263b63":
            self setstance( "stand" );
            break;
        case #"hash_a8f9e4a698fa0eeb":
            self setstance( "crouch" );
            break;
        case #"hash_e85597ec7477d565":
            self setstance( "prone" );
            break;
        default:
            break;
    }
}

// Namespace ztron_laststand
// Params 1
// Checksum 0xcc086a05, Offset: 0x95f
// Size: 0x369
function function_e769b0385238b86e( longbleed = 0 )
{
    level endon( #"ztron_game_is_over" );
    self endon( #"disconnect" );
    self endon( #"last_stand_exit" );
    self.ztron.var_ee46dbdcbbcd7fef = 0;
    
    while ( self.ztron.var_2c44544a01cc415e )
    {
        var_b4e106c66b15fd6 = 0;
        self.ztron.respawnmedics = 0;
        players = level.players;
        
        foreach ( player in players )
        {
            if ( player.ztron.var_2c44544a01cc415e )
            {
                continue;
            }
            
            if ( isdefined( player.ztron.vehicle ) || player ztron_player_utility::function_32883fa42c326520() )
            {
                continue;
            }
            
            if ( !isalive( player ) )
            {
                continue;
            }
            
            if ( !isdefined( player.ztron.var_eeeeba1fb45eb3ce ) )
            {
                continue;
            }
            
            distsq = distancesquared( self.origin, player.origin );
            checkdistsq = player ztron_fate::hasfate( 6 ) ? 5184 : 2304;
            
            if ( distsq > checkdistsq )
            {
                continue;
            }
            
            if ( longbleed && player ztron_fate::hasfate( 6 ) && player.ztron.upgradeMask & 268435456 )
            {
                diff = self.ztron.respawnduration - self.ztron.respawnprogress;
                
                if ( diff <= 10000 && self.ztron.respawnprogress > 0 )
                {
                    self.ztron.respawnprogress = self.ztron.respawnduration;
                }
                
                self.ztron.respawnmedics += 0.5;
            }
            
            if ( ztron_fate::hasfate( 6 ) && player ztron_fate::hasfate( 6 ) )
            {
                self.ztron.respawnmedics += 1;
            }
            else
            {
                self.ztron.respawnmedics += player.ztron.var_eeeeba1fb45eb3ce;
            }
            
            var_b4e106c66b15fd6 += 1;
        }
        
        if ( self.ztron.var_ee46dbdcbbcd7fef != var_b4e106c66b15fd6 )
        {
            self.ztron.var_ee46dbdcbbcd7fef = var_b4e106c66b15fd6;
            setomnvar( "ui_ztron_current_medics_count_" + self.sessionuimemberindex, var_b4e106c66b15fd6 );
        }
        
        wait 0.25;
    }
}

// Namespace ztron_laststand
// Params 0
// Checksum 0xd73640a5, Offset: 0xcd0
// Size: 0xf7
function function_51e4dcf6ec6aaf61()
{
    /#
        var_cae096b328e4a875 = 10;
        var_e134e291615409f0 = int( min( 1048576 * var_cae096b328e4a875, 4096000 ) );
        assert( self.ztron.respawnduration <= var_e134e291615409f0 );
        self.ztron.respawnduration = clampint( self.ztron.respawnduration, 0, var_e134e291615409f0 );
    #/
    
    var_2798f51f35bafe01 = 0.1;
    index = self.sessionuimemberindex;
    var_debb2eb9d3bc343f = ( int( self.ztron.respawnprogress * var_2798f51f35bafe01 ) << 12 ) + int( self.ztron.respawnduration * 0.001 );
    setomnvar( "ui_ztron_respawn_timer_" + index, var_debb2eb9d3bc343f );
}

// Namespace ztron_laststand
// Params 2
// Checksum 0xf1e5e9da, Offset: 0xdcf
// Size: 0x46
function function_180feaf95b100a5e( progress, total )
{
    if ( total <= 0 )
    {
        return;
    }
    
    self.health = int( clamp( progress / total * self.maxhealth, 0, self.maxhealth ) );
}

// Namespace ztron_laststand
// Params 0
// Checksum 0x13ae5251, Offset: 0xe1d
// Size: 0x155
function player_nav_obstacle()
{
    level endon( #"ztron_game_is_over" );
    nav_badplace = createnavbadplacebyent( self, 10 );
    v_origin = self.origin;
    var_b053cf64ee757d88 = gettime();
    check_time = var_b053cf64ee757d88;
    var_6787895101874fb4 = 0;
    
    for ( i = 0; i < level.players.size ; i++ )
    {
        if ( level.players[ i ] == self )
        {
            var_6787895101874fb4 = i;
            break;
        }
    }
    
    repulsor_name = "player_" + var_6787895101874fb4 + "_laststand_repulsor";
    createnavrepulsor( repulsor_name, -1, self, 64 );
    
    while ( player::isinlaststand( self ) )
    {
        waitframe();
        
        if ( !isplayer( self ) )
        {
            break;
        }
        
        curr_time = gettime();
        
        if ( curr_time - check_time > 500 )
        {
            check_time = curr_time;
            dist_sqr = distance2dsquared( v_origin, self.origin );
            
            if ( dist_sqr > 64 || dist_sqr > 2 && gettime() - var_b053cf64ee757d88 > 2000 )
            {
                nav_badplace = function_793ef7e253521eac( self, 10 );
                v_origin = self.origin;
                var_b053cf64ee757d88 = curr_time;
            }
        }
    }
    
    if ( isdefined( nav_badplace ) )
    {
        destroynavobstacle( nav_badplace );
    }
    
    destroynavrepulsor( repulsor_name );
}

// Namespace ztron_laststand
// Params 2
// Checksum 0xfeda3330, Offset: 0xf7a
// Size: 0x249
function laststandtimeout( duration, longbleed = 0 )
{
    self endon( #"disconnect" );
    level endon( #"ztron_game_is_over" );
    self endon( #"last_stand_exit" );
    var_eb92d04b516bf7a9 = duration > 5 && !isdefined( level.ztron.var_ffe07d19d8b6c7b );
    self.ztron.var_2c44544a01cc415e = 1;
    self.ztron.respawnduration = duration * 1000;
    self.ztron.respawnprogress = 0;
    self.ztron.respawnmedics = 0;
    function_51e4dcf6ec6aaf61();
    thread player_nav_obstacle();
    thread function_e769b0385238b86e( longbleed );
    var_274ecc0bebb433e6 = level.frameduration;
    var_d6c55fb8302628ef = 0;
    
    while ( self.ztron.respawnprogress < self.ztron.respawnduration )
    {
        if ( var_eb92d04b516bf7a9 && ztron_score::function_4f2852a8848fa4ce() > 0 )
        {
            break;
        }
        
        waitframe();
        progress = var_274ecc0bebb433e6;
        
        if ( self.ztron.respawnmedics > 0 )
        {
            progress += var_274ecc0bebb433e6 * self.ztron.respawnmedics;
            time = gettime();
            
            if ( time > var_d6c55fb8302628ef )
            {
                playfxontag( utility::getfx( "ztron_player_reviving" ), self, "tag_origin" );
                var_d6c55fb8302628ef = time + 2200;
            }
        }
        else
        {
            var_d6c55fb8302628ef = 0;
        }
        
        self.ztron.respawnprogress += progress;
        function_180feaf95b100a5e( self.ztron.respawnprogress, self.ztron.respawnduration );
        function_51e4dcf6ec6aaf61();
    }
    
    if ( isdefined( level.ztron.playerrespawnoverride ) )
    {
        self thread [[ level.ztron.playerrespawnoverride ]]();
        return;
    }
    
    thread ztron_player_utility::playerrespawnnow();
}

