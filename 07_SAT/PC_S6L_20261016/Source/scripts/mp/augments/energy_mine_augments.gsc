// scripts\mp\augments\energy_mine_augments.gsc  (hash_3dd4276fd1dbbd5e.gscc) (size: 21648 Bytes / 0x5490 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x86bc1af6 (2260474614)
// size ...... 21648 (0x5490)
// includes .. 14  (offset: 0x5098)
// strings ... 55  (offset: 0x5108)
// dev strs .. 0   (offset: 0x5490)
// exports ... 31  (offset: 0x3b58)
// cseg ...... 0x5da + 0x357e (0x3b58)
// imports ... 120 (offset: 0x4030)
// animtree1 . 0   (offset: 0x5490)
// animtree2 . 0   (offset: 0x5490)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\field_upgrades\field_upgrades_energy_mine;
#using scripts\mp\entityheadicons;
#using scripts\mp\interaction;
#using scripts\mp\supers;

#namespace energy_mine_augments;

// Namespace energy_mine_augments
// Params 0, eflags: 0x5
// Checksum 0x903de22e, Offset: 0x5f8
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"energy_mine_augments", undefined, &init_energy_mine_augments, undefined );
}

// Namespace energy_mine_augments
// Params 0
// Checksum 0xa801b0b5, Offset: 0x619
// Size: 0x181
function init_energy_mine_augments()
{
    if ( !level.zombie_augments_in_use )
    {
        return;
    }
    
    level.energy_mine_carousel_throttle = throttle::throttle_initialize( "energy_mine_carousel", 2, level.framedurationseconds ?? 0.1 );
    level._effect[ "energy_mine_sm" ] = loadfxasset( "vfx_t10_gameplay_zm_fld_energy_mine_idle_sm" );
    level._effect[ "energy_mine_sm_explo" ] = loadfxasset( "vfx_t10_gameplay_zm_fld_energy_mine_explo_sm" );
    level._effect[ "energy_mine_split" ] = loadfxasset( "vfx_t10_gameplay_zm_fld_energy_mine_deleting_cover" );
    level._effect[ "energy_mine_carousel" ] = loadfxasset( "vfx_t10_gameplay_zm_fld_energy_mine_idle_base" );
    level._effect[ "energy_mine_carousel_explo" ] = loadfxasset( "vfx_t10_gameplay_zm_fld_energy_mine_explo_base" );
    level._effect[ "energy_mine_spire" ] = loadfxasset( "vfx_t10_gameplay_zm_fld_energy_mine_spire_projectiles" );
    level._effect[ "energy_mine_spire_flash" ] = loadfxasset( "vfx_t10_gameplay_zm_fld_energy_mine_projectiles_emit_flash" );
    level.energy_mine_spires = [];
    callback::add( #"player_connect", &function_23d282e90609c60c );
    callback::add( "base_energy_mine_landed", &base_energy_mine_landed );
    callback::add( "field_upgrade_edit_notify", &function_d93a558ed06975f3 );
    utility::registersharedfunc( #"zombie", #"energy_mine_scatter", &energy_mine_scatter );
    utility::registersharedfunc( #"zombie", #"energy_mine_spire", &energy_mine_spire );
    utility::registersharedfunc( #"zombie", #"energy_mine_smart_mine", &energy_mine_smart_mine );
}

// Namespace energy_mine_augments
// Params 1
// Checksum 0xc1d65083, Offset: 0x7a2
// Size: 0x1d
function function_23d282e90609c60c( sparams )
{
    callback::add( "energy_mine_fired", &energy_mine_fired );
}

// Namespace energy_mine_augments
// Params 1
// Checksum 0xadd26a6c, Offset: 0x7c7
// Size: 0x166
function base_energy_mine_landed( sparams )
{
    if ( isplayer( sparams.player ) )
    {
        if ( sparams.player utility::callsharedfunc( #"zombie", #"player_has_augment", #"energy_mine_siren" ) )
        {
            attractorstruct = spawnstruct();
            attractorstruct.origin = self.origin;
            self.attractorstruct = attractorstruct;
            attractor = zombie_attractor_manager::add_attractor( attractorstruct, 1, 500, 0, undefined, &function_da44d4725c32bb46, 0, undefined, 1 );
            attractor.var_9bc09bc79f28a18e = 1;
            attractorstruct.owner = sparams.player;
            attractorstruct thread siren_attractor_duration( 5 );
        }
        
        if ( sparams.player utility::callsharedfunc( #"zombie", #"player_has_augment", #"energy_mine_recycle" ) )
        {
            self.recycle_interact = interaction::register_interact( self.origin, 92, &on_energy_mine_recycle );
            self.recycle_interact interaction::set_interact_hint_callback( &function_58fdf3c835920880 );
            self.recycle_interact.var_6fdd2f80be44e1bf = self;
            self.recycle_interact.owner = sparams.player;
        }
    }
}

// Namespace energy_mine_augments
// Params 1
// Checksum 0xc499d91a, Offset: 0x935
// Size: 0x1bc
function energy_mine_fired( sparams )
{
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"energy_mine_carousel" ) )
    {
        if ( isdefined( self.carouselmines ) && self.carouselmines.size > 0 )
        {
            foreach ( mine in self.carouselmines )
            {
                energy_mine_carousel_explosion( mine );
            }
            
            cleanup_energy_mine_carousel();
            self notify( #"energy_mine_carousel_started" );
            self notify( #"end_energy_mine_carousel" );
            callback::callback( "energy_mine_carousel_ended", { #ref:"super_energy_mine" } );
        }
        
        thread energy_mine_carousel();
        thread function_393eb6b594bd81be();
        
        if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"energy_mine_siren" ) )
        {
            if ( !isdefined( self.siren_attractor ) )
            {
                self notify( #"start_siren_attractor" );
                
                if ( isdefined( self.siren_attractor ) )
                {
                    zombie_attractor_manager::remove_attractor( self.siren_attractor );
                    self.siren_attractor = undefined;
                }
                
                self.siren_attractor = zombie_attractor_manager::add_attractor( self, 1, 500, 0, undefined, &function_da44d4725c32bb46, 0, undefined, 1 );
                self.siren_attractor.var_9bc09bc79f28a18e = 1;
                self.siren_attractor thread siren_attractor_duration( 5, self );
            }
        }
    }
}

// Namespace energy_mine_augments
// Params 2
// Checksum 0xda71975b, Offset: 0xaf9
// Size: 0x3d, Type: bool
function function_da44d4725c32bb46( attractor, ai )
{
    return isdefined( ai ) && ai.aicategory == "normal" && !ai.var_840153567385cc6b;
}

// Namespace energy_mine_augments
// Params 2
// Checksum 0x9289bc1f, Offset: 0xb3f
// Size: 0x9d
function siren_attractor_duration( duration = 0, player )
{
    level endon( #"game_ended" );
    
    if ( isplayer( player ) )
    {
        player endon( #"start_siren_attractor" );
    }
    
    if ( isdefined( self.origin ) )
    {
        playsoundatpos( self.origin, #"hash_5129cb86c039986b" );
    }
    
    utility::waittill_any_timeout( duration, "end_siren_attractor" );
    zombie_attractor_manager::remove_attractor( self );
    
    if ( isplayer( player ) && isdefined( player.siren_attractor ) )
    {
        player.siren_attractor = undefined;
    }
}

// Namespace energy_mine_augments
// Params 0
// Checksum 0xa0212227, Offset: 0xbe4
// Size: 0xde
function function_393eb6b594bd81be()
{
    self endon( #"death_or_disconnect" );
    self endon( #"end_energy_mine_carousel" );
    self.energy_mine_carousel_zombies = [];
    
    while ( true )
    {
        carouselpos = self.origin;
        
        if ( self isvehicleactive() && isdefined( self.vehicle ) )
        {
            carouselpos = self.vehicle.origin;
        }
        
        zombies = getaiarrayinradius( carouselpos, 104 );
        
        if ( utility::issharedfuncdefined( #"zm", #"hash_275603844e04e7ac" ) )
        {
            zombies = level [[ utility::getsharedfunc( #"zm", #"hash_275603844e04e7ac" ) ]]( zombies, self );
        }
        
        zombies = sortbydistance( zombies, carouselpos );
        self.energy_mine_carousel_zombies = zombies;
        throttle::throttle_wait_in_queue( level.energy_mine_carousel_throttle, self );
    }
}

// Namespace energy_mine_augments
// Params 0, eflags: 0x4
// Checksum 0xbf37d040, Offset: 0xcca
// Size: 0x59
function private function_51bc5c57da854127()
{
    level endon( #"game_ended" );
    self endon( #"energy_mine_carousel_started" );
    self waittill( #"death_or_disconnect" );
    mines = self.carouselmines;
    minerig = self.minerig;
    cleanup_energy_mine_carousel( mines, minerig );
}

// Namespace energy_mine_augments
// Params 2
// Checksum 0x8fee903b, Offset: 0xd2b
// Size: 0x17e
function cleanup_energy_mine_carousel( mines, minerig )
{
    level endon( #"game_ended" );
    
    if ( isplayer( self ) && isdefined( self.carouselmines ) && isdefined( self.minerig ) )
    {
        foreach ( mine in self.carouselmines )
        {
            if ( isdefined( mine.scriptable ) )
            {
                mine.scriptable freescriptable();
                mine delete();
            }
        }
        
        self.carouselmines = [];
        self.minerig delete();
        return;
    }
    
    if ( isdefined( mines ) && isdefined( minerig ) )
    {
        foreach ( mine in mines )
        {
            mine.scriptable freescriptable();
            mine delete();
        }
        
        minerig delete();
    }
}

// Namespace energy_mine_augments
// Params 0
// Checksum 0x26f81677, Offset: 0xeb1
// Size: 0x4fc
function energy_mine_carousel()
{
    self endon( #"death_or_disconnect" );
    self endon( #"end_energy_mine_carousel" );
    thread function_51bc5c57da854127();
    nummines = 3;
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"energy_mine_frequency_boost" ) )
    {
        nummines++;
    }
    
    anglestep = int( 360 / nummines );
    mine_rig = spawn( "script_model", self.origin );
    mine_rig setmodel( "tag_origin" );
    carouselmines = [];
    carouselangle = 0;
    
    for ( i = 0; i < nummines ; i++ )
    {
        mine = spawn( "script_model", self.origin );
        mine setmodel( "tag_origin" );
        playfxontag( utility::getfx( "energy_mine_carousel" ), mine, "tag_origin" );
        ball_scriptable = spawnscriptable( "super_energymine_ball", mine.origin );
        ball_scriptable scriptablesetparententity( mine );
        mine.scriptable = ball_scriptable;
        mine.scriptable setscriptablepartstate( "audio", "planted" );
        mine.team = self.team;
        mineoffset = function_dfbb94c411dbcae2( mine_rig.origin, 72, carouselangle );
        mineoffset -= mine.origin;
        mine linkto( mine_rig, "tag_origin", mineoffset, ( 0, 0, 0 ) );
        carouselmines[ carouselmines.size ] = mine;
        carouselangle += anglestep;
        mine callback::callback( "energy_mine_subtype_landed", { #subtype:"carousel", #ref:"super_energy_mine", #player:self } );
    }
    
    rigangle = 0;
    var_98ea319d81b47c45 = 5;
    mine_rig.origin = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + 32 );
    self.minerig = mine_rig;
    self.carouselmines = carouselmines;
    
    for ( var_6379ef2852dd13c7 = gettime(); self.carouselmines.size > 0 ; var_6379ef2852dd13c7 = gettime() )
    {
        waitframe();
        
        if ( self isvehicleactive() && isdefined( self.vehicle ) )
        {
            mine_rig.origin = ( self.vehicle.origin[ 0 ], self.vehicle.origin[ 1 ], self.vehicle.origin[ 2 ] + 64 );
            mine_rig.angles = ( mine_rig.angles[ 0 ], mine_rig.angles[ 1 ] + 5, mine_rig.angles[ 2 ] );
        }
        else if ( self isonascender() )
        {
            var_46e46e7e7783a5e4 = self getvelocity();
            var_46e46e7e7783a5e4 = vectornormalize( var_46e46e7e7783a5e4 );
            var_46e46e7e7783a5e4 *= 32;
            mine_rig.origin = ( self.origin[ 0 ] + var_46e46e7e7783a5e4[ 0 ], self.origin[ 1 ] + var_46e46e7e7783a5e4[ 1 ], self.origin[ 2 ] + var_46e46e7e7783a5e4[ 2 ] + 32 );
            mine_rig.angles = ( mine_rig.angles[ 0 ], mine_rig.angles[ 1 ] + 5, mine_rig.angles[ 2 ] );
        }
        else
        {
            mine_rig.origin = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + 32 );
            mine_rig.angles = ( mine_rig.angles[ 0 ], mine_rig.angles[ 1 ] + 5, mine_rig.angles[ 2 ] );
        }
        
        if ( isdefined( self.energy_mine_carousel_zombies ) && self.energy_mine_carousel_zombies.size > 0 )
        {
            if ( gettime() - var_6379ef2852dd13c7 > 1000 || gettime() - var_6379ef2852dd13c7 == 0 )
            {
                self.carouselmines = sortbydistance( self.carouselmines, self.energy_mine_carousel_zombies[ 0 ].origin );
                var_123d6a6e2fdc8164 = self.carouselmines[ 0 ];
                self.carouselmines = arrayremove( self.carouselmines, var_123d6a6e2fdc8164 );
                thread energy_mine_carousel_explosion( var_123d6a6e2fdc8164 );
            }
        }
    }
    
    wait 1;
    mine_rig delete();
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    callback::callback( "energy_mine_carousel_ended", { #ref:"super_energy_mine" } );
    self notify( #"end_energy_mine_carousel" );
}

// Namespace energy_mine_augments
// Params 1
// Checksum 0x747c63e3, Offset: 0x13b5
// Size: 0xda
function energy_mine_carousel_explosion( mine )
{
    if ( !isdefined( mine ) )
    {
        return;
    }
    
    mine endon( #"death" );
    mine field_upgrades_energy_mine::play_vfx( "energy_mine_carousel_explo" );
    mine field_upgrades_energy_mine::play_vfx( "energy_mine_sm_explo" );
    
    if ( isdefined( mine.scriptable ) )
    {
        mine.scriptable setscriptablepartstate( "audio", "tripped" );
    }
    
    wait 0.1;
    
    if ( isplayer( self ) && isdefined( mine.scriptable ) )
    {
        mine.scriptable setscriptablepartstate( "audio", "explosion" );
        mine childthread field_upgrades_energy_mine::function_8ad36b9f50d770db( self );
    }
    
    wait 0.2;
    
    if ( isdefined( mine.scriptable ) )
    {
        mine.scriptable freescriptable();
    }
    
    if ( isdefined( mine ) )
    {
        mine delete();
    }
}

// Namespace energy_mine_augments
// Params 1
// Checksum 0xc1e5f5b0, Offset: 0x1497
// Size: 0x1af
function energy_mine_scatter( spawnorigin )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( !isdefined( level.energy_mine_scatter_mine_throttle ) )
    {
        level.energy_mine_scatter_mine_throttle = throttle::throttle_initialize( "energy_mine_scatter_mine_throttle", 1, level.framedurationseconds );
    }
    
    playfx( utility::getfx( "energy_mine_split" ), spawnorigin );
    spawnorigin = ( spawnorigin[ 0 ], spawnorigin[ 1 ], spawnorigin[ 2 ] + 32 );
    var_a33990d84700b4c8 = "energy_mine_ball_mp_small";
    scattermines = [];
    scatterangle = 0;
    nummines = 3;
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"energy_mine_frequency_boost" ) )
    {
        nummines++;
    }
    
    anglestep = int( 360 / nummines );
    
    for ( i = 0; i < nummines ; i++ )
    {
        throwpoint = function_dfbb94c411dbcae2( spawnorigin, 256, scatterangle );
        var_46e46e7e7783a5e4 = vectornormalize( spawnorigin - throwpoint );
        var_46e46e7e7783a5e4 *= 256;
        scattermines[ scattermines.size ] = function_9dd10c3588838afa( spawnorigin, var_46e46e7e7783a5e4, var_a33990d84700b4c8 );
        scatterangle += anglestep;
    }
    
    foreach ( scattermine in scattermines )
    {
        thread function_e1fb32f80e5bdd56( scattermine );
    }
}

// Namespace energy_mine_augments
// Params 1, eflags: 0x4
// Checksum 0x58abad83, Offset: 0x164e
// Size: 0x1d5
function private function_ad4d1326048461a7( var_6fdd2f80be44e1bf )
{
    var_6fdd2f80be44e1bf endon( #"death" );
    
    if ( !isplayer( self ) )
    {
        if ( isdefined( var_6fdd2f80be44e1bf.scriptable ) )
        {
            var_6fdd2f80be44e1bf.scriptable freescriptable();
        }
        
        if ( isdefined( var_6fdd2f80be44e1bf ) )
        {
            var_6fdd2f80be44e1bf delete();
        }
        
        return;
    }
    
    var_f6a8fadde02a1385 = field_upgrades_energy_mine::function_c287671a696a9f67( "energy_mine_deploy_limit" );
    
    if ( isdefined( var_f6a8fadde02a1385 ) )
    {
        var_f6a8fadde02a1385 *= 3;
        
        if ( !isdefined( self.var_895ddef3135379f4 ) )
        {
            self.var_895ddef3135379f4 = [];
        }
        
        self.var_895ddef3135379f4[ self.var_895ddef3135379f4.size ] = var_6fdd2f80be44e1bf;
        
        if ( self.var_895ddef3135379f4.size > var_f6a8fadde02a1385 )
        {
            var_ff4f266f87210854 = utility::array_get_first_item( self.var_895ddef3135379f4 );
            var_ff4f266f87210854.var_ab7ed321b7eab6e3 = 1;
            self.var_895ddef3135379f4 = arrayremove( self.var_895ddef3135379f4, var_ff4f266f87210854 );
        }
    }
    
    fuse_dur = 0.2;
    explosion_dur = 1;
    var_bac341e41f9c413f = field_upgrades_energy_mine::function_c287671a696a9f67( "energy_mine_ai_proximity_distance" );
    var_6fdd2f80be44e1bf field_upgrades_energy_mine::function_b9fadf90493f85a( self, var_bac341e41f9c413f );
    var_6fdd2f80be44e1bf.scriptable setscriptablepartstate( "audio", "tripped" );
    
    if ( isdefined( var_6fdd2f80be44e1bf ) )
    {
        var_6fdd2f80be44e1bf field_upgrades_energy_mine::stop_vfx( "energy_mine_sm" );
        var_6fdd2f80be44e1bf field_upgrades_energy_mine::play_vfx( "energy_mine_sm_explo" );
        wait fuse_dur;
        
        if ( isplayer( self ) )
        {
            var_6fdd2f80be44e1bf.scriptable setscriptablepartstate( "audio", "explosion" );
            var_6fdd2f80be44e1bf childthread field_upgrades_energy_mine::function_8ad36b9f50d770db( self );
        }
        
        wait explosion_dur;
        
        if ( isdefined( self.var_895ddef3135379f4 ) )
        {
            self.var_895ddef3135379f4 = arrayremove( self.var_895ddef3135379f4, var_6fdd2f80be44e1bf );
        }
        
        var_6fdd2f80be44e1bf.scriptable freescriptable();
        var_6fdd2f80be44e1bf delete();
    }
}

// Namespace energy_mine_augments
// Params 0, eflags: 0x4
// Checksum 0xa48857a2, Offset: 0x182b
// Size: 0xb7
function private function_c62f46831f3f5363()
{
    movingplatforminfo = utility::function_7c45b71b8e0d3cff();
    
    if ( isdefined( movingplatforminfo ) && isdefined( movingplatforminfo.groundent ) && isdefined( movingplatforminfo.localorigin ) && isdefined( movingplatforminfo.localangles ) )
    {
        if ( isdefined( self.linkedparent ) )
        {
            self.linkedparent linkto( movingplatforminfo.groundent, "", movingplatforminfo.localorigin, movingplatforminfo.localangles );
            return;
        }
        
        self linkto( movingplatforminfo.groundent, "", movingplatforminfo.localorigin, movingplatforminfo.localangles );
    }
}

// Namespace energy_mine_augments
// Params 0
// Checksum 0x527f1c2a, Offset: 0x18ea
// Size: 0xc2
function function_7a10dd393b16633a()
{
    self endon( #"death" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    offset = ( 0, 0, 8 );
    ent = utility::spawn_tag_origin( self.origin + offset, ( 0, 0, 0 ) );
    ent show();
    ball_scriptable = self.scriptable;
    ball_scriptable scriptableclearparententity();
    waitframe();
    ball_scriptable scriptablesetparententity( ent );
    ent.scriptable = ball_scriptable;
    ent.scriptable setscriptablepartstate( "audio", "planted" );
    playfxontag( utility::getfx( "energy_mine_sm" ), ent, "tag_origin" );
    return ent;
}

// Namespace energy_mine_augments
// Params 1
// Checksum 0x4295a8b, Offset: 0x19b5
// Size: 0x1cf
function function_e1fb32f80e5bdd56( scattermine )
{
    level endon( #"game_ended" );
    var_181b14bb07adf969 = scattermine.origin + ( 1, 1, 1 );
    var_fd3661837ef84f7f = undefined;
    
    while ( true )
    {
        if ( !isdefined( scattermine ) )
        {
            return 0;
        }
        
        moving_platform_info = scattermine utility::function_7c45b71b8e0d3cff();
        
        if ( isdefined( moving_platform_info ) )
        {
            if ( !isdefined( var_fd3661837ef84f7f ) )
            {
                var_fd3661837ef84f7f = moving_platform_info.worldorigin;
            }
            
            ball_offset = scattermine.origin - var_181b14bb07adf969;
            platform_offset = moving_platform_info.worldorigin - var_fd3661837ef84f7f;
            
            if ( distancesquared( platform_offset, ball_offset ) > 0 )
            {
                var_181b14bb07adf969 = scattermine.origin;
                var_fd3661837ef84f7f = moving_platform_info.worldorigin;
            }
            else
            {
                break;
            }
        }
        else if ( distancesquared( scattermine.origin, var_181b14bb07adf969 ) > 0 )
        {
            var_181b14bb07adf969 = scattermine.origin;
        }
        else
        {
            break;
        }
        
        wait 0.4;
    }
    
    waitframe();
    
    if ( !isdefined( scattermine ) )
    {
        return 0;
    }
    
    newent = scattermine function_7a10dd393b16633a();
    
    if ( !isdefined( newent ) )
    {
        if ( isdefined( scattermine.scriptable ) )
        {
            scattermine.scriptable freescriptable();
        }
        
        if ( isdefined( scattermine ) )
        {
            scattermine delete();
        }
        
        return 0;
    }
    
    if ( isdefined( scattermine ) )
    {
        scattermine delete();
    }
    
    scattermine = newent;
    scattermine.team = self.team;
    scattermine thread function_c62f46831f3f5363();
    thread function_ad4d1326048461a7( scattermine );
    scattermine callback::callback( "energy_mine_subtype_landed", { #subtype:"scatter", #ref:"super_energy_mine", #player:self } );
}

// Namespace energy_mine_augments
// Params 3, eflags: 0x4
// Checksum 0x7de3e464, Offset: 0x1b8c
// Size: 0x70
function private function_dfbb94c411dbcae2( center, radius, deg )
{
    x = cos( deg );
    x *= radius;
    x += center[ 0 ];
    y = sin( deg );
    y *= radius;
    y += center[ 1 ];
    z = center[ 2 ];
    return ( x, y, z );
}

// Namespace energy_mine_augments
// Params 3, eflags: 0x4
// Checksum 0xf874cb7b, Offset: 0x1c05
// Size: 0xb5
function private function_9dd10c3588838afa( location, var_8eb93aaf975c2c0d, var_bdb5ee0e261f1a32 )
{
    if ( !isplayer( self ) )
    {
        return;
    }
    
    var_6fdd2f80be44e1bf = magicgrenademanual( var_bdb5ee0e261f1a32, location, var_8eb93aaf975c2c0d, 99999, self );
    var_6fdd2f80be44e1bf.var_9eb0e951b21fa1ff = 1;
    ball_scriptable = spawnscriptable( "super_energymine_ball_small", var_6fdd2f80be44e1bf.origin );
    ball_scriptable scriptablesetparententity( var_6fdd2f80be44e1bf );
    var_6fdd2f80be44e1bf.scriptable = ball_scriptable;
    var_6fdd2f80be44e1bf.scriptable setscriptablepartstate( "audio", "fired" );
    var_6fdd2f80be44e1bf.team = self.team;
    return var_6fdd2f80be44e1bf;
}

// Namespace energy_mine_augments
// Params 1
// Checksum 0x2971b8e5, Offset: 0x1cc3
// Size: 0x5f3
function energy_mine_spire( spawnorigin )
{
    if ( !isdefined( self.energy_mine_spires ) )
    {
        self.energy_mine_spires = [];
    }
    
    if ( !isdefined( spawnorigin ) )
    {
        return;
    }
    
    offset = ( 0, 0, 0 );
    ent = utility::spawn_tag_origin( spawnorigin + offset, ( 0, 0, 0 ) );
    ent show();
    ball_scriptable = spawnscriptable( "super_energymine_ball", ent.origin );
    ball_scriptable scriptableclearparententity();
    ent function_c62f46831f3f5363();
    waitframe();
    ball_scriptable scriptablesetparententity( ent );
    ent.scriptable = ball_scriptable;
    ent.scriptable setscriptablepartstate( "audio", "planted" );
    playfxontag( utility::getfx( "energy_mine_spire" ), ent, "tag_origin" );
    ent.owner = self;
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"energy_mine_siren" ) )
    {
        attractor = zombie_attractor_manager::add_attractor( ent, 1, 500, 0, undefined, &function_da44d4725c32bb46, 0, undefined, 1 );
        attractor.var_9bc09bc79f28a18e = 1;
        ent thread siren_attractor_duration( 5 );
    }
    
    bundle = field_upgrades_energy_mine::get_energy_mine_bundle();
    
    if ( bundle.var_9526fd5c44eee510 && bundle.headicon_enable )
    {
        ent.superref = "super_energy_mine";
        ent.team = self.team;
        ent.headiconid = entityheadicons::setheadicon_fieldupgrade( ent, undefined, ent.origin + ( 0, 0, 70 ) );
    }
    
    ent.spireammo = 20;
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"energy_mine_frequency_boost" ) )
    {
        ent.spireammo = int( ent.spireammo * 1.33 );
    }
    
    ent.spiremaxammo = ent.spireammo;
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"energy_mine_recycle" ) )
    {
        ent.recycle_interact = interaction::register_interact( ent.origin, 92, &on_energy_mine_recycle );
        ent.recycle_interact interaction::set_interact_hint_callback( &function_58fdf3c835920880 );
        ent.recycle_interact.spire = ent;
        ent.recycle_interact.owner = self;
    }
    
    ent callback::callback( "energy_mine_subtype_landed", { #subtype:"spire", #ref:"super_energy_mine", #player:self } );
    self.energy_mine_spires[ self.energy_mine_spires.size ] = ent;
    level.energy_mine_spires[ level.energy_mine_spires.size ] = ent;
    
    if ( level.energy_mine_spires.size >= 6 )
    {
        var_50c6e5db12d300a7 = 0;
        oldspire = level.energy_mine_spires[ 0 ];
        var_3fa4413437815484 = oldspire.origin;
        
        foreach ( player in level.players )
        {
            if ( isdefined( player.energy_mine_spires ) )
            {
                foreach ( index, spire in player.energy_mine_spires )
                {
                    if ( spire == oldspire )
                    {
                        var_50c6e5db12d300a7 = 1;
                        level.energy_mine_spires[ 0 ] = undefined;
                        function_cdc669dbc8ea2101( level.energy_mine_spires );
                        player.energy_mine_spires[ index ] = undefined;
                        
                        if ( isint( index ) )
                        {
                            function_cdc669dbc8ea2101( player.energy_mine_spires );
                        }
                        
                        if ( isdefined( player ) )
                        {
                            player callback::callback( "energy_mine_delay_ended", { #energy_mine_ent:spire, #delay_time:0, #ref:"super_energy_mine" } );
                        }
                        
                        if ( isdefined( var_3fa4413437815484 ) )
                        {
                            playfx( utility::getfx( "energy_mine_split" ), var_3fa4413437815484 );
                        }
                        
                        if ( isdefined( oldspire.scriptable ) )
                        {
                            oldspire.scriptable freescriptable();
                        }
                        
                        if ( isdefined( oldspire ) )
                        {
                            oldspire delete();
                        }
                        
                        break;
                    }
                }
                
                if ( var_50c6e5db12d300a7 )
                {
                    break;
                }
            }
        }
    }
    
    if ( self.energy_mine_spires.size > 3 )
    {
        oldspire = self.energy_mine_spires[ 0 ];
        var_3fa4413437815484 = oldspire.origin;
        self.energy_mine_spires[ 0 ] = undefined;
        function_cdc669dbc8ea2101( self.energy_mine_spires );
        callback::callback( "energy_mine_delay_ended", { #energy_mine_ent:oldspire, #delay_time:0, #ref:"super_energy_mine" } );
        
        if ( isdefined( var_3fa4413437815484 ) )
        {
            playfx( utility::getfx( "energy_mine_split" ), var_3fa4413437815484 );
        }
        
        if ( isdefined( oldspire ) && isdefined( oldspire.scriptable ) )
        {
            oldspire.scriptable freescriptable();
        }
        
        if ( isdefined( oldspire ) )
        {
            oldspire delete();
        }
    }
    
    thread function_f15d679b482a7fe5( ent );
}

// Namespace energy_mine_augments
// Params 2
// Checksum 0x9013500c, Offset: 0x22be
// Size: 0xe3
function find_closest_zombie( origin, zombies )
{
    var_5663bc8051ba1404 = 0;
    var_f726d4c25f1fc503 = undefined;
    
    foreach ( index, zombie in zombies )
    {
        if ( var_5663bc8051ba1404 == 0 )
        {
            var_5663bc8051ba1404 = index;
            var_f726d4c25f1fc503 = distance2dsquared( origin, zombie.origin );
            continue;
        }
        
        distance = distance2dsquared( origin, zombie.origin );
        
        if ( distance < var_f726d4c25f1fc503 )
        {
            var_5663bc8051ba1404 = index;
            var_f726d4c25f1fc503 = distance;
        }
    }
    
    return zombies[ var_5663bc8051ba1404 ];
}

// Namespace energy_mine_augments
// Params 1
// Checksum 0xca2f58b5, Offset: 0x23aa
// Size: 0x6ac
function function_f15d679b482a7fe5( spire )
{
    spire endon( #"death" );
    var_f66a5aeff1b71f8c = level.zombie_augments[ #"energy_mine_spire" ].var_c52236b3c0a6bddc ?? -1;
    start_time = gettime();
    
    while ( spire.spireammo > 0 && isplayer( self ) && ( var_f66a5aeff1b71f8c < 0 || !utility::time_has_passed( start_time, var_f66a5aeff1b71f8c ) ) )
    {
        zombies = getaiarrayinradius( spire.origin, 600 );
        
        if ( utility::issharedfuncdefined( #"zm", #"hash_275603844e04e7ac" ) )
        {
            zombies = level [[ utility::getsharedfunc( #"zm", #"hash_275603844e04e7ac" ) ]]( zombies, self );
        }
        
        var_2f0e7e6815a92743 = getplayersinradius( spire.origin, 600, undefined, 1, [ self ] );
        
        foreach ( player in var_2f0e7e6815a92743 )
        {
            if ( player.team == self.team )
            {
                continue;
            }
            
            if ( player.aether_shroud_active )
            {
                continue;
            }
            
            can_affect = 1;
            
            if ( utility::issharedfuncdefined( #"zm", #"hash_95f8b65e45fc2ef4" ) )
            {
                can_affect = level [[ utility::getsharedfunc( #"zm", #"hash_95f8b65e45fc2ef4" ) ]]( self, player );
            }
            
            if ( !can_affect )
            {
                continue;
            }
            
            zombies[ zombies.size ] = player;
        }
        
        if ( !isdefined( spire.targetzombie ) )
        {
            foreach ( zombie in zombies )
            {
                if ( zombie zombie_utils::function_bf1464d09f4e4b40() )
                {
                    zombies = arrayremove( zombies, zombie );
                }
                else if ( zombie.team == self.team )
                {
                    zombies = arrayremove( zombies, zombie );
                }
                
                if ( zombie.is_living_world_ai && !zombie.var_9686e1897a9ce028 )
                {
                    zombies = arrayremove( zombies, zombie );
                }
            }
            
            if ( zombies.size > 0 )
            {
                var_88f817d755d2b49c = find_closest_zombie( spire.origin, zombies );
                
                if ( isalive( var_88f817d755d2b49c ) )
                {
                    spire.targetzombie = var_88f817d755d2b49c;
                    trace_contents = trace::create_default_contents( 1 );
                    fireorigin = ( spire.origin[ 0 ], spire.origin[ 1 ], spire.origin[ 2 ] + 44 );
                    targetorigin = ( spire.targetzombie.origin[ 0 ], spire.targetzombie.origin[ 1 ], spire.targetzombie.origin[ 2 ] + 44 );
                    traceresults = trace::ray_trace( fireorigin, targetorigin, undefined, trace_contents );
                    
                    if ( traceresults[ "fraction" ] >= 1 )
                    {
                        spire thread function_408ce6f1fd290dea( self );
                    }
                }
            }
        }
        else
        {
            foreach ( zombie in zombies )
            {
                if ( zombie zombie_utils::function_bf1464d09f4e4b40() )
                {
                    zombies = arrayremove( zombies, zombie );
                    continue;
                }
                
                if ( zombie.team == self.team )
                {
                    zombies = arrayremove( zombies, zombie );
                }
            }
            
            if ( zombies.size > 0 )
            {
                var_88f817d755d2b49c = find_closest_zombie( spire.origin, zombies );
                
                if ( isalive( var_88f817d755d2b49c ) && spire.targetzombie != var_88f817d755d2b49c )
                {
                    spire notify( #"spire_stop_firing" );
                    spire.targetzombie = undefined;
                    var_7bbdc3618fd421a4 = 0;
                }
            }
            
            if ( isdefined( spire.targetzombie ) )
            {
                trace_contents = trace::create_default_contents( 1 );
                fireorigin = ( spire.origin[ 0 ], spire.origin[ 1 ], spire.origin[ 2 ] + 44 );
                targetorigin = ( spire.targetzombie.origin[ 0 ], spire.targetzombie.origin[ 1 ], spire.targetzombie.origin[ 2 ] + 44 );
                traceresults = trace::ray_trace( fireorigin, targetorigin, undefined, trace_contents );
                
                if ( traceresults[ "fraction" ] < 1 )
                {
                    spire notify( #"spire_stop_firing" );
                    spire.targetzombie = undefined;
                    var_7bbdc3618fd421a4 = 0;
                }
            }
            
            if ( isdefined( spire.targetzombie ) && ( !isalive( spire.targetzombie ) || spire.targetzombie zombie_utils::function_bf1464d09f4e4b40() || spire.targetzombie.aether_shroud_active ) )
            {
                spire notify( #"spire_stop_firing" );
                spire.targetzombie = undefined;
                var_7bbdc3618fd421a4 = 0;
            }
        }
        
        wait 0.5;
    }
    
    if ( isplayer( self ) )
    {
        self.energy_mine_spires = arrayremove( self.energy_mine_spires, spire );
        callback::callback( "energy_mine_delay_ended", { #energy_mine_ent:spire, #delay_time:0, #ref:"super_energy_mine" } );
    }
    
    playfx( utility::getfx( "energy_mine_split" ), spire.origin );
    spire hide();
    wait 1;
    
    if ( isdefined( spire ) && isdefined( spire.scriptable ) )
    {
        spire.scriptable freescriptable();
    }
    
    if ( isdefined( spire ) )
    {
        spire delete();
    }
}

// Namespace energy_mine_augments
// Params 1
// Checksum 0x9697c7bf, Offset: 0x2a5e
// Size: 0x2ac
function function_408ce6f1fd290dea( player )
{
    self notify( #"hash_6fb418106135ae45" );
    self endon( #"hash_6fb418106135ae45" );
    self endon( #"death" );
    self endon( #"spire_stop_firing" );
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    while ( self.spireammo > 0 && isplayer( player ) )
    {
        if ( isplayer( player ) && isdefined( self.targetzombie ) )
        {
            fireorigin = ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + 44 );
            
            if ( self.targetzombie.energy_mine_spire_offset )
            {
                targetorigin = ( self.targetzombie.origin[ 0 ], self.targetzombie.origin[ 1 ], self.targetzombie.origin[ 2 ] + self.targetzombie.energy_mine_spire_offset );
            }
            else
            {
                targetorigin = self.targetzombie.origin;
            }
            
            var_e36080e56d2441a = self.targetzombie getboundsmidpoint()[ 2 ] * 2 < 60;
            
            if ( var_e36080e56d2441a && targetorigin[ 2 ] <= self.origin[ 2 ] + 16 )
            {
                targetorigin = ( targetorigin[ 0 ], targetorigin[ 1 ], targetorigin[ 2 ] - 16 );
            }
            
            if ( self.targetzombie namespace_b76ff2659823e89d::is_crawling() )
            {
                targetorigin = ( targetorigin[ 0 ], targetorigin[ 1 ], targetorigin[ 2 ] - 32 );
            }
            
            if ( self.targetzombie.subclass == "zombie_galileo_drone" )
            {
                targetorigin = ( targetorigin[ 0 ], targetorigin[ 1 ], targetorigin[ 2 ] - 44 );
            }
            
            var_f32fbd161ca96e3e = targetorigin - self.origin;
            var_f32fbd161ca96e3e = vectornormalize( var_f32fbd161ca96e3e );
            var_f32fbd161ca96e3e *= 1500;
            playsoundatpos( fireorigin, #"hash_32b0bea28ed7a727" );
            playfx( utility::getfx( "energy_mine_spire_flash" ), fireorigin );
            projectile = magicgrenademanual( "energy_mine_ball_mp_spire", fireorigin, var_f32fbd161ca96e3e, 1, player );
            projectile.var_9eb0e951b21fa1ff = 1;
            projectile.team = player.team;
            projectile.angles = vectortoangles( var_f32fbd161ca96e3e );
            projectile_lifetime = {};
            player thread function_d9faabe2f6849ca2( projectile, self, projectile_lifetime );
            player thread function_d9faabe2f6849ca2( projectile, self, projectile_lifetime, 1 );
            player thread function_74bd26bba3b45c6e( projectile, projectile_lifetime );
        }
        
        wait 0.5;
    }
}

// Namespace energy_mine_augments
// Params 2
// Checksum 0x8088aa7, Offset: 0x2d12
// Size: 0x61
function function_74bd26bba3b45c6e( projectile, projectile_lifetime )
{
    level endon( #"game_ended" );
    
    if ( !isplayer( self ) )
    {
        if ( projectile )
        {
            projectile delete();
        }
        
        projectile_lifetime notify( #"hash_896f6af737bdd9ab" );
        return;
    }
    
    wait 1;
    
    if ( isdefined( projectile ) )
    {
        projectile delete();
    }
    
    projectile_lifetime notify( #"hash_896f6af737bdd9ab" );
}

// Namespace energy_mine_augments
// Params 4
// Checksum 0x6bd209b0, Offset: 0x2d7b
// Size: 0x2b3
function function_d9faabe2f6849ca2( projectile, spire, projectile_lifetime, b_check_player )
{
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    projectile_lifetime endon( #"hash_896f6af737bdd9ab" );
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    spireorigin = spire.origin;
    round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( self.origin );
    base_zombie_maxhealth = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
    
    if ( b_check_player )
    {
        projectile waittill( #"projectile_impact_player", aihit );
    }
    else
    {
        projectile waittill( #"projectile_impact_ai", aihit );
    }
    
    if ( isplayer( aihit ) )
    {
        if ( !isdefined( level.zombie_augments[ #"energy_mine_spire" ].energyMineSpireFixedPlayerDamage ) )
        {
            level.zombie_augments[ #"energy_mine_spire" ].energyMineSpireFixedPlayerDamage = field_upgrades_energy_mine::function_c287671a696a9f67( "energyMineSpireFixedPlayerDamage" ) ?? 20;
        }
        
        damage = level.zombie_augments[ #"energy_mine_spire" ].energyMineSpireFixedPlayerDamage;
    }
    else
    {
        aicategory = aihit.aicategory ?? "none";
        
        switch ( aicategory )
        {
            case #"hash_84fcf5e68d7230b2":
                damage = int( base_zombie_maxhealth * 1 );
                break;
            case #"hash_8c089e813083e510":
                damage = int( base_zombie_maxhealth * 0.5 );
                break;
            case #"hash_7b0e2f2ed84f34":
                damage = int( base_zombie_maxhealth * 0.25 );
                break;
            default:
                damage = int( base_zombie_maxhealth * 1 );
                break;
        }
    }
    
    if ( isalive( aihit ) )
    {
        if ( damage >= aihit.health && !isplayer( aihit ) )
        {
            aihit val::set( "zm_allow_give_super_point", "allow_give_super_point", 0 );
            aihit utility::ent_flag_set( "energy_mine_kill" );
        }
        
        sweapon = level.weaponmetadata[ %"energy_mine" ].weaponobj;
        attacker = aihit;
        
        if ( isplayer( self ) )
        {
            attacker = self;
        }
        
        inflictor = spire ?? attacker;
        aihit dodamage( damage, projectile.origin, attacker, inflictor, "MOD_UNKNOWN", sweapon, "none", undefined, 1610678272 );
        
        if ( isdefined( spire ) )
        {
            spire.spireammo--;
        }
    }
}

// Namespace energy_mine_augments
// Params 1
// Checksum 0xc6f7ff2b, Offset: 0x3036
// Size: 0x2a2
function energy_mine_smart_mine( var_6fdd2f80be44e1bf )
{
    var_6fdd2f80be44e1bf endon( #"death" );
    var_f6a8fadde02a1385 = field_upgrades_energy_mine::function_c287671a696a9f67( "energy_mine_deploy_limit" );
    
    if ( isdefined( var_f6a8fadde02a1385 ) )
    {
        if ( !isdefined( self.var_57436ea3d87868a1 ) )
        {
            self.var_57436ea3d87868a1 = [];
        }
        
        self.var_57436ea3d87868a1[ self.var_57436ea3d87868a1.size ] = var_6fdd2f80be44e1bf;
        
        if ( self.var_57436ea3d87868a1.size > var_f6a8fadde02a1385 )
        {
            var_ff4f266f87210854 = utility::array_get_first_item( self.var_57436ea3d87868a1 );
            
            if ( isdefined( var_ff4f266f87210854 ) )
            {
                var_ff4f266f87210854.var_ab7ed321b7eab6e3 = 1;
                self.var_57436ea3d87868a1 = arrayremove( self.var_57436ea3d87868a1, var_ff4f266f87210854 );
            }
        }
    }
    
    var_e356b6c51eb4ed14 = level.zombie_augments[ #"energy_mine_smart_mine" ].var_8d9a010233fba6e4;
    var_bac341e41f9c413f = field_upgrades_energy_mine::function_c287671a696a9f67( "energy_mine_ai_proximity_distance" );
    n_total_detonations = level.zombie_augments[ #"energy_mine_smart_mine" ].var_baef56261ababad1;
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"energy_mine_frequency_boost" ) )
    {
        n_total_detonations++;
    }
    
    fuse_dur = 0.6;
    var_6fdd2f80be44e1bf.var_c7744c7f1d42082c = 0;
    var_6fdd2f80be44e1bf.var_a1beafb04690c830 = n_total_detonations;
    
    while ( var_6fdd2f80be44e1bf.var_c7744c7f1d42082c < n_total_detonations )
    {
        var_6fdd2f80be44e1bf field_upgrades_energy_mine::function_b9fadf90493f85a( self, var_bac341e41f9c413f, var_e356b6c51eb4ed14 );
        
        if ( isdefined( var_6fdd2f80be44e1bf.scriptable ) )
        {
            var_6fdd2f80be44e1bf.scriptable setscriptablepartstate( "audio", "tripped" );
        }
        
        if ( var_6fdd2f80be44e1bf.var_c7744c7f1d42082c == n_total_detonations - 1 )
        {
            var_6fdd2f80be44e1bf field_upgrades_energy_mine::stop_vfx( "energy_mine_stationary" );
        }
        
        var_6fdd2f80be44e1bf field_upgrades_energy_mine::play_vfx( "energy_mine_explosion1" );
        wait fuse_dur;
        
        if ( isdefined( var_6fdd2f80be44e1bf.scriptable ) )
        {
            var_6fdd2f80be44e1bf.scriptable setscriptablepartstate( "audio", "explosion" );
            
            if ( var_6fdd2f80be44e1bf.var_c7744c7f1d42082c != n_total_detonations - 1 )
            {
                var_6fdd2f80be44e1bf.scriptable utility::delaycall( 0.2, &setscriptablepartstate, "audio", "planted" );
            }
        }
        
        if ( isdefined( var_6fdd2f80be44e1bf ) )
        {
            var_6fdd2f80be44e1bf childthread field_upgrades_energy_mine::function_8ad36b9f50d770db( self );
        }
        
        var_6fdd2f80be44e1bf.var_c7744c7f1d42082c++;
        wait 1;
    }
    
    if ( isdefined( var_6fdd2f80be44e1bf.recycle_interact ) )
    {
        var_6fdd2f80be44e1bf.recycle_interact delete();
    }
    
    var_6fdd2f80be44e1bf.scriptable freescriptable();
    var_6fdd2f80be44e1bf delete();
}

// Namespace energy_mine_augments
// Params 1
// Checksum 0x75da8c4b, Offset: 0x32e0
// Size: 0x2bf
function on_energy_mine_recycle( player )
{
    if ( isplayer( player ) && self.owner == player && player utility::callsharedfunc( #"zombie", #"player_has_augment", #"energy_mine_recycle" ) && player.super.staticdata.ref == "super_energy_mine" )
    {
        if ( isdefined( self.var_6fdd2f80be44e1bf ) && !self.var_6fdd2f80be44e1bf.tripped )
        {
            if ( isdefined( player.var_57436ea3d87868a1 ) )
            {
                if ( isdefined( player.var_57436ea3d87868a1 ) && isdefined( self.var_6fdd2f80be44e1bf ) )
                {
                    player.var_57436ea3d87868a1 = arrayremove( player.var_57436ea3d87868a1, self.var_6fdd2f80be44e1bf );
                }
                
                player energy_mine_recycle_give_power( self.var_6fdd2f80be44e1bf );
                
                if ( isdefined( self.var_6fdd2f80be44e1bf.origin ) )
                {
                    playfx( utility::getfx( "energy_mine_split" ), self.var_6fdd2f80be44e1bf.origin );
                    playsoundatpos( self.var_6fdd2f80be44e1bf.origin, #"hash_4114e3167f291748" );
                }
                
                if ( isdefined( self.var_6fdd2f80be44e1bf ) && isdefined( self.var_6fdd2f80be44e1bf.scriptable ) )
                {
                    self.var_6fdd2f80be44e1bf.scriptable freescriptable();
                }
                
                if ( isdefined( self.var_6fdd2f80be44e1bf ) )
                {
                    self.var_6fdd2f80be44e1bf delete();
                }
            }
        }
        else if ( isdefined( self.spire ) )
        {
            if ( isdefined( player.energy_mine_spires ) )
            {
                if ( isdefined( player.energy_mine_spires ) && isdefined( self.spire ) )
                {
                    player.energy_mine_spires = arrayremove( player.energy_mine_spires, self.spire );
                }
                
                player energy_mine_recycle_give_power( self.spire );
                playfx( utility::getfx( "energy_mine_split" ), self.spire.origin );
                playsoundatpos( self.spire.origin, #"hash_4114e3167f291748" );
                
                if ( isdefined( self.spire ) && isdefined( self.spire.scriptable ) )
                {
                    self.spire.scriptable freescriptable();
                }
                
                if ( isdefined( self.spire ) )
                {
                    self.spire delete();
                }
            }
        }
        
        self delete();
    }
}

// Namespace energy_mine_augments
// Params 2
// Checksum 0x3b5b11c9, Offset: 0x35a7
// Size: 0xb8
function function_58fdf3c835920880( usable, player )
{
    if ( isdefined( player ) && isdefined( usable ) )
    {
        if ( usable.owner == player )
        {
            return { #var_26bbd300351fde34:0, #string:&"shared_hintstrings/energy_mine_recycle", #type:"HINT_BUTTON" };
        }
        else
        {
            return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
        }
    }
    
    return { #var_26bbd300351fde34:0, #string:&"", #type:"HINT_NOICON" };
}

// Namespace energy_mine_augments
// Params 1
// Checksum 0xb4afdce, Offset: 0x3668
// Size: 0x1c4
function energy_mine_recycle_give_power( var_b7e295ff6c42e7c1 )
{
    var_c0c4324d255baab3 = supers_mp::getcurrentsuper();
    
    if ( !isalive( self ) || !isdefined( var_c0c4324d255baab3 ) )
    {
        return;
    }
    
    if ( var_c0c4324d255baab3.staticdata.ref != "super_energy_mine" )
    {
        return;
    }
    
    var_78d242958109c27c = 1;
    var_d532e397ecea6843 = 0;
    var_76ebd6ade9c8fd2b = istrue( utility::callsharedfunc( #"zombie", #"player_has_augment", #"energy_mine_spire" ) );
    var_1057dcb625b718ca = istrue( utility::callsharedfunc( #"zombie", #"player_has_augment", #"energy_mine_smart_mine" ) );
    
    if ( isdefined( var_b7e295ff6c42e7c1.spireammo ) && isdefined( var_b7e295ff6c42e7c1.spiremaxammo ) )
    {
        var_78d242958109c27c = var_b7e295ff6c42e7c1.spireammo / var_b7e295ff6c42e7c1.spiremaxammo;
    }
    else if ( var_1057dcb625b718ca )
    {
        difference = var_b7e295ff6c42e7c1.var_a1beafb04690c830 - var_b7e295ff6c42e7c1.var_c7744c7f1d42082c;
        var_78d242958109c27c = difference / var_b7e295ff6c42e7c1.var_a1beafb04690c830;
    }
    
    b_super_ready = supers_mp::issuperready();
    
    if ( !b_super_ready )
    {
        var_d532e397ecea6843 = supers_mp::getsuperpointsneeded() - supers_mp::getcurrentsuperpoints();
    }
    
    if ( isdefined( self.perks[ "specialty_overcharge_field_upgrade" ] ) )
    {
        var_ec53cb5847b1149b = supers_mp::function_7dcdfecb3848b30e();
        
        if ( b_super_ready && !var_ec53cb5847b1149b )
        {
            var_d532e397ecea6843 = supers_mp::getsuperpointsneeded() - self.overclockcharge;
        }
    }
    
    if ( var_d532e397ecea6843 != 0 )
    {
        points_needed_scaled = ceil( var_d532e397ecea6843 / level.superpointsmod );
        points_needed_scaled *= var_78d242958109c27c;
        supers_mp::givesuperpoints( points_needed_scaled );
    }
}

// Namespace energy_mine_augments
// Params 1
// Checksum 0xb59d67fb, Offset: 0x3834
// Size: 0x324
function function_d93a558ed06975f3( sparams )
{
    if ( sparams.superref == "super_energy_mine" && utility::callsharedfunc( #"zombie", #"player_has_augment", #"energy_mine_recycle" ) )
    {
        foreach ( mine in self.var_57436ea3d87868a1 )
        {
            if ( !isdefined( mine.recycle_interact ) )
            {
                mine.recycle_interact = interaction::register_interact( mine.origin, 92, &on_energy_mine_recycle );
                mine.recycle_interact interaction::set_interact_hint_callback( &function_58fdf3c835920880 );
                mine.recycle_interact.var_6fdd2f80be44e1bf = mine;
                mine.recycle_interact.owner = self;
            }
        }
        
        foreach ( spire in self.energy_mine_spires )
        {
            if ( !isdefined( spire.recycle_interact ) )
            {
                spire.recycle_interact = interaction::register_interact( spire.origin, 92, &on_energy_mine_recycle );
                spire.recycle_interact interaction::set_interact_hint_callback( &function_58fdf3c835920880 );
                spire.recycle_interact.spire = spire;
                spire.recycle_interact.owner = self;
            }
        }
        
        return;
    }
    
    foreach ( mine in self.var_57436ea3d87868a1 )
    {
        if ( isdefined( mine.recycle_interact ) )
        {
            mine.recycle_interact delete();
        }
    }
    
    foreach ( spire in self.energy_mine_spires )
    {
        if ( isdefined( spire.recycle_interact ) )
        {
            spire.recycle_interact delete();
        }
    }
}

