// scripts\mp\common\field_upgrades\field_upgrades_energy_mine.gsc  (hash_533b5daa4ff3e374.gscc) (size: 18397 Bytes / 0x47dd / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3e67037e (1046938494)
// size ...... 18397 (0x47dd)
// includes .. 17  (offset: 0x42e1)
// strings ... 73  (offset: 0x4369)
// dev strs .. 6   (offset: 0x4795)
// exports ... 30  (offset: 0x2ef5)
// cseg ...... 0x69f + 0x2856 (0x2ef5)
// imports ... 118 (offset: 0x33a5)
// animtree1 . 0   (offset: 0x47dd)
// animtree2 . 0   (offset: 0x47dd)
#using script_16ea1b94f0f381b3;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\metabone;
#using scripts\common\system;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\mp\common\field_upgrades\field_upgrades;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\equipmentroundscaling;
#using scripts\mp\supers;

#namespace field_upgrades_energy_mine;

// Namespace field_upgrades_energy_mine
// Params 0, eflags: 0x5
// Checksum 0x365ee82c, Offset: 0x6bd
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"energy_mine", undefined, undefined, &init );
}

// Namespace field_upgrades_energy_mine
// Params 0
// Checksum 0x396b340, Offset: 0x6de
// Size: 0x21d
function init()
{
    superbundle = field_upgrades::function_1fcc83f10e7752e5( "super_energy_mine" );
    
    if ( !isdefined( superbundle ) )
    {
        return;
    }
    
    level._effect[ "energy_mine_stationary" ] = loadfxasset( "vfx_jup_ob_gameplay_zm_fld_energy_mine_lvl1_orb" );
    level._effect[ "energy_mine_explosion1" ] = loadfxasset( "vfx_t10_gameplay_zm_fld_energy_mine_lvl1_activate" );
    level._effect[ "energy_mine_explosion3" ] = loadfxasset( "vfx_jup_ob_gameplay_zm_fld_energy_mine_lvl5_activate" );
    level._effect[ "energy_mine_explosion4" ] = loadfxasset( "vfx_t10_gameplay_zm_fld_energy_mine_lvl5_activate_fre_boost" );
    utility::flag_wait( "supers_initialized" );
    supers_mp::function_48aaa60b2ce7b8a1( "super_energy_mine", &set_energy_mine, &unset_energy_mine, &begin_use_energy_mine, &function_985cbaadae8a7e56, undefined, &set_energy_mine );
    supers_mp::registersuperextraweapon( "super_energy_mine", "energy_mine_ball_mp" );
    utility::registersharedfunc( #"zm_energy_mine", #"delete_energy_mine", &function_6896d1c4a283bd40 );
    level.mdl_ball_array = [];
    
    /#
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_command( "<dev string:x3a>", "<dev string:x4b>" );
        devgui::add_devgui_command( "<dev string:x78>", "<dev string:x8c>" );
        devgui::function_77df7fe7dd273e10();
    #/
    
    sweapon = undefined;
    
    if ( isdefined( level.weaponmetadata[ %"energy_mine" ] ) )
    {
        if ( !isdefined( level.weaponmetadata[ %"energy_mine" ].weaponobj ) )
        {
            sweapon = makeweapon( level.weaponmetadata[ %"energy_mine" ].weapon );
            level.weaponmetadata[ %"energy_mine" ].weaponobj = sweapon;
        }
        else
        {
            sweapon = level.weaponmetadata[ %"energy_mine" ].weaponobj;
        }
    }
    
    if ( utility::issharedfuncdefined( #"medal", #"register_on_kill_medal_callback", 0 ) && isdefined( sweapon ) )
    {
        utility::callsharedfunc( #"medal", #"register_on_kill_medal_callback", sweapon.basename, &on_killed_medal );
    }
}

// Namespace field_upgrades_energy_mine
// Params 0
// Checksum 0xf4ccd189, Offset: 0x903
// Size: 0x47
function set_energy_mine()
{
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"energy_mine_high_capacity" ) && !isdefined( self.perks[ "specialty_overcharge_field_upgrade" ] ) )
    {
        perk::giveperk( "specialty_overcharge_field_upgrade" );
    }
}

// Namespace field_upgrades_energy_mine
// Params 0
// Checksum 0xf3d975f4, Offset: 0x952
// Size: 0x46
function unset_energy_mine()
{
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"energy_mine_high_capacity" ) && isdefined( self.perks[ "specialty_overcharge_field_upgrade" ] ) )
    {
        perk::removeperk( "specialty_overcharge_field_upgrade" );
    }
}

// Namespace field_upgrades_energy_mine
// Params 0
// Checksum 0x5313f95, Offset: 0x9a0
// Size: 0xd6, Type: bool
function begin_use_energy_mine()
{
    bundle = level.field_upgrade_bundles[ "super_energy_mine" ];
    
    if ( isdefined( bundle ) )
    {
        energymineweapon = bundle.offhandweapon;
        deploysuccess = field_upgrades::field_upgrade_play_gesture( energymineweapon, "super_energy_mine" );
        
        if ( deploysuccess )
        {
            callback::callback( "energy_mine_fired" );
            self.energy_mine_kill_count = 0;
            
            if ( !utility::callsharedfunc( #"zombie", #"player_has_augment", #"energy_mine_carousel" ) )
            {
                if ( bundle.var_8b9eade13fbfb044 && !callback::exists( #"super_cancel", &cancel ) )
                {
                    callback::add( #"super_cancel", &cancel );
                }
                
                thread fire_energy_mine();
            }
            
            return true;
        }
    }
    
    return false;
}

// Namespace field_upgrades_energy_mine
// Params 2
// Checksum 0xfdcb8769, Offset: 0xa7f
// Size: 0x16, Type: bool
function function_985cbaadae8a7e56( fromdeath, attacker )
{
    return false;
}

// Namespace field_upgrades_energy_mine
// Params 1, eflags: 0x4
// Checksum 0xa222c22b, Offset: 0xa9e
// Size: 0xde
function private cancel( params )
{
    self notify( #"cancel_mdl_ball" );
    
    if ( self.mdl_ball_projectile )
    {
        delete_mdl_ball( self.mdl_ball_projectile );
        self.mdl_ball_projectile = undefined;
    }
    
    if ( isarray( self.mdl_ball_array ) )
    {
        foreach ( var_6fdd2f80be44e1bf in self.mdl_ball_array )
        {
            var_6fdd2f80be44e1bf notify( #"cancel_explosion" );
            delete_mdl_ball( var_6fdd2f80be44e1bf );
        }
        
        self.mdl_ball_array = undefined;
    }
}

// Namespace field_upgrades_energy_mine
// Params 0
// Checksum 0xe708474f, Offset: 0xb84
// Size: 0x46
function fire_energy_mine()
{
    level endon( #"game_ended" );
    currentweapon = self getcurrentweapon();
    
    if ( !currentweapon.isdualwield )
    {
        self setscriptablepartstate( "wand_fx", "wand_on_energy_mine", 0 );
    }
    
    set_energy_ball();
}

// Namespace field_upgrades_energy_mine
// Params 0
// Checksum 0x325a3e38, Offset: 0xbd2
// Size: 0x562
function set_energy_ball()
{
    self endon( #"cancel_mdl_ball" );
    forward = anglestoforward( self getplayerangles() );
    var_bdd4cb6e363cdd81 = "energy_mine_ball_mp";
    result = vehicle::is_in_vehicle();
    
    if ( result )
    {
        seatid = vehicle_occupancy::get_occupant_seat( self.vehicle, self );
        data = vehicle_occupancy::function_759b1ac7685fb992( self.vehicle, self, seatid );
        
        if ( isdefined( data.origin ) )
        {
            location = data.origin;
            self.mdl_ball_projectile = function_7cec33c69b90d56a( location, forward * 1, var_bdd4cb6e363cdd81 );
        }
        else
        {
            location = self.vehicle.origin + ( 0, 0, 10 );
            self.mdl_ball_projectile = function_7cec33c69b90d56a( location, forward * 1, var_bdd4cb6e363cdd81 );
        }
    }
    else
    {
        upvector = ( 0, 0, 1 );
        var_d97b6d1cae515316 = 10;
        var_9ee1fd1c9c6aaba8 = 30;
        var_c1ccbf4cfe217a83 = 400;
        origin = self gettagorigin( "j_wrist_le", 1 );
        
        if ( !isdefined( origin ) )
        {
            origin = self gettagorigin( "tag_accessory_left" );
        }
        
        var_1efb0219d589ac0e = origin + upvector * var_d97b6d1cae515316 + forward * var_9ee1fd1c9c6aaba8;
        var_8eb93aaf975c2c0d = forward * var_c1ccbf4cfe217a83 + self getvelocity();
        self.mdl_ball_projectile = function_7cec33c69b90d56a( var_1efb0219d589ac0e, var_8eb93aaf975c2c0d, var_bdd4cb6e363cdd81 );
    }
    
    var_6fdd2f80be44e1bf = self.mdl_ball_projectile;
    
    if ( isdefined( var_6fdd2f80be44e1bf ) )
    {
        var_76ebd6ade9c8fd2b = istrue( utility::callsharedfunc( #"zombie", #"player_has_augment", #"energy_mine_spire" ) );
        var_1057dcb625b718ca = istrue( utility::callsharedfunc( #"zombie", #"player_has_augment", #"energy_mine_smart_mine" ) );
        var_6fdd2f80be44e1bf function_c915df19dca16ca3();
        
        if ( self && !isalive( self ) )
        {
            delete_mdl_ball( var_6fdd2f80be44e1bf );
            return 0;
        }
        
        if ( var_76ebd6ade9c8fd2b )
        {
            spawnorigin = var_6fdd2f80be44e1bf.origin;
            utility::callsharedfunc( #"zombie", #"energy_mine_spire", spawnorigin );
            
            if ( isdefined( var_6fdd2f80be44e1bf.recycle_interact ) )
            {
                var_6fdd2f80be44e1bf.recycle_interact delete();
            }
            
            if ( isdefined( var_6fdd2f80be44e1bf ) && isdefined( var_6fdd2f80be44e1bf.scriptable ) )
            {
                var_6fdd2f80be44e1bf.scriptable freescriptable();
            }
            
            if ( isdefined( var_6fdd2f80be44e1bf ) )
            {
                var_6fdd2f80be44e1bf delete();
                self.mdl_ball_projectile = undefined;
            }
        }
        else if ( var_1057dcb625b718ca )
        {
            newent = var_6fdd2f80be44e1bf function_970f23549c6c00bf();
            
            if ( isdefined( newent ) )
            {
                energymineparams = spawnstruct();
                energymineparams.player = self;
                energymineparams.ref = "super_energy_mine";
                newent callback::callback( "base_energy_mine_landed", energymineparams );
                energymineparams.subtype = "smart";
                newent callback::callback( "energy_mine_subtype_landed", energymineparams );
            }
            
            if ( !isdefined( newent ) )
            {
                delete_mdl_ball( var_6fdd2f80be44e1bf );
                return 0;
            }
            
            if ( isdefined( var_6fdd2f80be44e1bf ) )
            {
                var_6fdd2f80be44e1bf delete();
                self.mdl_ball_projectile = undefined;
            }
            
            var_6fdd2f80be44e1bf = newent;
            var_6fdd2f80be44e1bf.team = self.team;
            var_6fdd2f80be44e1bf thread function_c62f46831f3f5363();
            
            if ( !isdefined( self.mdl_ball_array ) )
            {
                self.mdl_ball_array = [];
            }
            
            self.mdl_ball_array[ self.mdl_ball_array.size ] = var_6fdd2f80be44e1bf;
            level.mdl_ball_array[ level.mdl_ball_array.size ] = var_6fdd2f80be44e1bf;
            utility::callsharedfunc( #"zombie", #"energy_mine_smart_mine", var_6fdd2f80be44e1bf );
        }
        else
        {
            newent = var_6fdd2f80be44e1bf function_970f23549c6c00bf();
            
            if ( isdefined( newent ) )
            {
                energymineparams = spawnstruct();
                energymineparams.player = self;
                energymineparams.ref = "super_energy_mine";
                newent callback::callback( "base_energy_mine_landed", energymineparams );
                var_f4c4aa84e3b5bdcd = istrue( utility::callsharedfunc( #"zombie", #"player_has_augment", #"energy_mine_scatter_mine" ) );
                
                if ( var_f4c4aa84e3b5bdcd )
                {
                    callback::callback( "energy_mine_scatter_started", { #ref:"super_energy_mine", #player:self } );
                }
                
                energymineparams.subtype = var_f4c4aa84e3b5bdcd ? "scatter" : "base";
                newent callback::callback( "energy_mine_subtype_landed", energymineparams );
            }
            
            if ( !isdefined( newent ) )
            {
                delete_mdl_ball( var_6fdd2f80be44e1bf );
                return 0;
            }
            
            if ( isdefined( var_6fdd2f80be44e1bf ) )
            {
                var_6fdd2f80be44e1bf delete();
                self.mdl_ball_projectile = undefined;
            }
            
            var_6fdd2f80be44e1bf = newent;
            var_6fdd2f80be44e1bf.team = self.team;
            var_6fdd2f80be44e1bf thread function_c62f46831f3f5363();
            thread function_d8a99b09669dec77( var_6fdd2f80be44e1bf );
            
            if ( !isdefined( self.mdl_ball_array ) )
            {
                self.mdl_ball_array = [];
            }
            
            self.mdl_ball_array[ self.mdl_ball_array.size ] = var_6fdd2f80be44e1bf;
            level.mdl_ball_array[ level.mdl_ball_array.size ] = var_6fdd2f80be44e1bf;
        }
        
        return;
    }
    
    delete_mdl_ball( var_6fdd2f80be44e1bf );
    assertmsg( var_bdd4cb6e363cdd81 + "<dev string:xbc>" );
    return 0;
}

// Namespace field_upgrades_energy_mine
// Params 1, eflags: 0x4
// Checksum 0x7436d96e, Offset: 0x113c
// Size: 0x146
function private delete_mdl_ball( var_6fdd2f80be44e1bf )
{
    if ( isarray( self.mdl_ball_array ) && var_6fdd2f80be44e1bf )
    {
        self.mdl_ball_array = arrayremove( self.mdl_ball_array, var_6fdd2f80be44e1bf );
    }
    
    if ( !isplayer( self ) && isarray( level.mdl_ball_array ) && var_6fdd2f80be44e1bf )
    {
        level.mdl_ball_array = arrayremove( level.mdl_ball_array, var_6fdd2f80be44e1bf );
    }
    
    if ( var_6fdd2f80be44e1bf.recycle_interact )
    {
        var_6fdd2f80be44e1bf.recycle_interact delete();
    }
    
    if ( isdefined( var_6fdd2f80be44e1bf ) && isdefined( var_6fdd2f80be44e1bf.scriptable ) )
    {
        var_6fdd2f80be44e1bf.scriptable freescriptable();
    }
    
    if ( var_6fdd2f80be44e1bf )
    {
        var_6fdd2f80be44e1bf delete();
        var_6fdd2f80be44e1bf = undefined;
    }
    
    if ( !isplayer( self ) )
    {
        return;
    }
    
    bundle = level.field_upgrade_bundles[ "super_energy_mine" ];
    
    if ( bundle.var_8b9eade13fbfb044 && ( !isarray( self.mdl_ball_array ) || self.mdl_ball_array.size == 0 ) && callback::exists( #"super_cancel", &cancel ) )
    {
        callback::remove( #"super_cancel", &cancel );
    }
}

// Namespace field_upgrades_energy_mine
// Params 0, eflags: 0x4
// Checksum 0x2421d348, Offset: 0x128a
// Size: 0xb
function private function_6896d1c4a283bd40()
{
    level delete_mdl_ball( self );
}

// Namespace field_upgrades_energy_mine
// Params 3, eflags: 0x4
// Checksum 0x62d32ba5, Offset: 0x129d
// Size: 0x96
function private function_7cec33c69b90d56a( location, var_8eb93aaf975c2c0d, var_bdb5ee0e261f1a32 )
{
    var_6fdd2f80be44e1bf = magicgrenademanual( var_bdb5ee0e261f1a32, location, var_8eb93aaf975c2c0d, 99999, self );
    var_6fdd2f80be44e1bf.var_9eb0e951b21fa1ff = 1;
    ball_scriptable = spawnscriptable( "super_energymine_ball", var_6fdd2f80be44e1bf.origin );
    ball_scriptable scriptablesetparententity( var_6fdd2f80be44e1bf );
    var_6fdd2f80be44e1bf.scriptable = ball_scriptable;
    var_6fdd2f80be44e1bf.scriptable setscriptablepartstate( "audio", "fired" );
    return var_6fdd2f80be44e1bf;
}

// Namespace field_upgrades_energy_mine
// Params 0, eflags: 0x4
// Checksum 0x5fa99a1c, Offset: 0x133c
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

// Namespace field_upgrades_energy_mine
// Params 0
// Checksum 0xd8c024bc, Offset: 0x13fb
// Size: 0xfe
function function_c915df19dca16ca3()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    var_181b14bb07adf969 = self.origin + ( 1, 1, 1 );
    var_fd3661837ef84f7f = undefined;
    
    while ( true )
    {
        moving_platform_info = utility::function_7c45b71b8e0d3cff();
        
        if ( isdefined( moving_platform_info ) )
        {
            if ( !isdefined( var_fd3661837ef84f7f ) )
            {
                var_fd3661837ef84f7f = moving_platform_info.worldorigin;
            }
            
            ball_offset = self.origin - var_181b14bb07adf969;
            platform_offset = moving_platform_info.worldorigin - var_fd3661837ef84f7f;
            
            if ( distancesquared( platform_offset, ball_offset ) > 0 )
            {
                var_181b14bb07adf969 = self.origin;
                var_fd3661837ef84f7f = moving_platform_info.worldorigin;
            }
            else
            {
                break;
            }
        }
        else if ( distancesquared( self.origin, var_181b14bb07adf969 ) > 0 )
        {
            var_181b14bb07adf969 = self.origin;
        }
        else
        {
            break;
        }
        
        wait 0.4;
    }
}

// Namespace field_upgrades_energy_mine
// Params 0
// Checksum 0xb6bd9410, Offset: 0x1501
// Size: 0xb9
function function_970f23549c6c00bf()
{
    self endon( #"death" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    offset = ( 0, 0, 0 );
    ent = utility::spawn_tag_origin( self.origin + offset, ( 0, 0, 0 ) );
    ent show();
    ball_scriptable = self.scriptable;
    ball_scriptable scriptableclearparententity();
    waitframe();
    ball_scriptable scriptablesetparententity( ent );
    ent.scriptable = ball_scriptable;
    ent.scriptable setscriptablepartstate( "audio", "planted" );
    ent play_vfx( "energy_mine_stationary" );
    return ent;
}

// Namespace field_upgrades_energy_mine
// Params 1
// Checksum 0x5937dd6b, Offset: 0x15c3
// Size: 0x4b8
function function_d8a99b09669dec77( var_6fdd2f80be44e1bf )
{
    var_6fdd2f80be44e1bf endon( #"death" );
    var_f6a8fadde02a1385 = function_c287671a696a9f67( "energy_mine_deploy_limit" );
    
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
        
        params = { #var_6fdd2f80be44e1bf:var_6fdd2f80be44e1bf };
        callback::callback( "energy_mine_ball_spawned", params );
    }
    
    fuse_dur = 0.6;
    explosion_dur = 1;
    var_bac341e41f9c413f = function_c287671a696a9f67( "energy_mine_ai_proximity_distance" );
    var_6fdd2f80be44e1bf function_b9fadf90493f85a( self, var_bac341e41f9c413f );
    var_6fdd2f80be44e1bf.tripped = 1;
    var_6fdd2f80be44e1bf.scriptable setscriptablepartstate( "audio", "tripped" );
    var_f4c4aa84e3b5bdcd = istrue( utility::callsharedfunc( #"zombie", #"player_has_augment", #"energy_mine_scatter_mine" ) );
    
    if ( isdefined( var_6fdd2f80be44e1bf.recycle_interact ) )
    {
        var_6fdd2f80be44e1bf.recycle_interact delete();
    }
    
    if ( var_f4c4aa84e3b5bdcd )
    {
        if ( isdefined( var_6fdd2f80be44e1bf ) )
        {
            var_6fdd2f80be44e1bf stop_vfx( "energy_mine_stationary" );
            var_6fdd2f80be44e1bf play_vfx( "energy_mine_explosion1" );
            wait fuse_dur;
            
            if ( isplayer( self ) )
            {
                if ( isdefined( var_6fdd2f80be44e1bf ) && isdefined( var_6fdd2f80be44e1bf.scriptable ) )
                {
                    var_6fdd2f80be44e1bf.scriptable setscriptablepartstate( "audio", "explosion" );
                }
                
                if ( isdefined( var_6fdd2f80be44e1bf ) )
                {
                    var_6fdd2f80be44e1bf childthread function_8ad36b9f50d770db( self );
                }
            }
        }
        
        wait fuse_dur;
        
        if ( isdefined( var_6fdd2f80be44e1bf.attractorstruct ) )
        {
            var_6fdd2f80be44e1bf.attractorstruct notify( #"end_siren_attractor" );
        }
        
        utility::callsharedfunc( #"zombie", #"energy_mine_scatter", var_6fdd2f80be44e1bf.origin );
        wait explosion_dur;
        
        if ( isdefined( self.var_57436ea3d87868a1 ) && isdefined( var_6fdd2f80be44e1bf ) )
        {
            self.var_57436ea3d87868a1 = arrayremove( self.var_57436ea3d87868a1, var_6fdd2f80be44e1bf );
        }
        
        delete_mdl_ball( var_6fdd2f80be44e1bf );
        return;
    }
    
    if ( isdefined( var_6fdd2f80be44e1bf ) )
    {
        var_6fdd2f80be44e1bf stop_vfx( "energy_mine_stationary" );
        
        if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"energy_mine_frequency_boost" ) )
        {
            var_6fdd2f80be44e1bf play_vfx( "energy_mine_explosion4" );
        }
        else
        {
            var_6fdd2f80be44e1bf play_vfx( "energy_mine_explosion3" );
        }
        
        wait fuse_dur;
        
        if ( isplayer( self ) )
        {
            if ( isdefined( var_6fdd2f80be44e1bf ) && isdefined( var_6fdd2f80be44e1bf.scriptable ) )
            {
                var_6fdd2f80be44e1bf.scriptable setscriptablepartstate( "audio", "explosion" );
            }
            
            if ( isdefined( var_6fdd2f80be44e1bf ) )
            {
                var_6fdd2f80be44e1bf childthread function_8ad36b9f50d770db( self );
            }
        }
        
        n_extra_explosion = function_c287671a696a9f67( "energy_mine_base_extra_explosion" );
        
        if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"energy_mine_frequency_boost" ) )
        {
            n_extra_explosion += 1;
        }
        
        for ( i = 0; i < n_extra_explosion ; i++ )
        {
            wait explosion_dur;
            
            if ( isplayer( self ) )
            {
                if ( isdefined( var_6fdd2f80be44e1bf ) && isdefined( var_6fdd2f80be44e1bf.scriptable ) )
                {
                    var_6fdd2f80be44e1bf.scriptable setscriptablepartstate( "audio", "explosion" );
                }
                
                if ( isdefined( var_6fdd2f80be44e1bf ) )
                {
                    var_6fdd2f80be44e1bf childthread function_8ad36b9f50d770db( self );
                }
                
                continue;
            }
            
            break;
        }
        
        if ( isdefined( var_6fdd2f80be44e1bf.attractorstruct ) )
        {
            var_6fdd2f80be44e1bf.attractorstruct notify( #"end_siren_attractor" );
        }
        
        callback::callback( "energy_mine_delay_ended", { #energy_mine_ent:var_6fdd2f80be44e1bf, #delay_time:explosion_dur, #ref:"super_energy_mine" } );
        wait explosion_dur;
        
        if ( isplayer( self ) )
        {
            if ( isdefined( self.var_57436ea3d87868a1 ) && isdefined( var_6fdd2f80be44e1bf ) )
            {
                self.var_57436ea3d87868a1 = arrayremove( self.var_57436ea3d87868a1, var_6fdd2f80be44e1bf );
            }
            
            delete_mdl_ball( var_6fdd2f80be44e1bf );
            return;
        }
        
        if ( isdefined( var_6fdd2f80be44e1bf ) )
        {
            if ( var_6fdd2f80be44e1bf.recycle_interact )
            {
                var_6fdd2f80be44e1bf.recycle_interact delete();
            }
            
            if ( isdefined( var_6fdd2f80be44e1bf ) && isdefined( var_6fdd2f80be44e1bf.scriptable ) )
            {
                var_6fdd2f80be44e1bf.scriptable freescriptable();
            }
            
            if ( var_6fdd2f80be44e1bf )
            {
                var_6fdd2f80be44e1bf delete();
            }
        }
    }
}

// Namespace field_upgrades_energy_mine
// Params 3
// Checksum 0x64832249, Offset: 0x1a83
// Size: 0x168
function function_b9fadf90493f85a( e_player, n_radius, var_e356b6c51eb4ed14 = 0 )
{
    self endon( #"death" );
    
    while ( true )
    {
        if ( !isplayer( e_player ) )
        {
            return;
        }
        
        if ( self.var_ab7ed321b7eab6e3 )
        {
            return;
        }
        
        var_317a1fff030a6aa1 = e_player get_proximity_enemies( n_radius, self.origin, 0 );
        var_563c84cd7c4fb595 = e_player get_enemy_turrets( n_radius, self.origin );
        
        if ( var_317a1fff030a6aa1.size > 0 )
        {
            foreach ( target in var_317a1fff030a6aa1 )
            {
                if ( target.aicategory == "special" || target.aicategory == "elite" || target.aicategory == "hvt" )
                {
                    return;
                }
            }
        }
        
        if ( var_e356b6c51eb4ed14 > 0 )
        {
            if ( var_317a1fff030a6aa1.size >= var_e356b6c51eb4ed14 || var_563c84cd7c4fb595.size >= var_e356b6c51eb4ed14 )
            {
                return;
            }
        }
        else if ( var_317a1fff030a6aa1.size || var_563c84cd7c4fb595.size )
        {
            return;
        }
        
        waitframe();
    }
}

// Namespace field_upgrades_energy_mine
// Params 2
// Checksum 0x648c86c8, Offset: 0x1bf3
// Size: 0xc9
function vehicle_damage_checks( var_e7b645d747b24dab, params )
{
    if ( isdefined( params.player ) && isdefined( params.vehicle ) )
    {
        if ( !params.vehicle utility::ent_flag_exist( "convoy_energy_mine_stopped" ) )
        {
            params.player callback::callback( "energy_mine_convoy_stopped", params );
            params.vehicle utility::ent_flag_init( "convoy_energy_mine_stopped" );
        }
        
        if ( var_e7b645d747b24dab >= params.vehicle.health || isdefined( params.vehicle.burningdown ) )
        {
            params.vehicle utility::ent_flag_init( "energy_mine_kill" );
        }
    }
}

// Namespace field_upgrades_energy_mine
// Params 1
// Checksum 0x5292eb43, Offset: 0x1cc4
// Size: 0x979
function function_8ad36b9f50d770db( player )
{
    self endon( #"cancel_explosion" );
    
    if ( !isplayer( player ) )
    {
        return;
    }
    
    var_d0a9d177707a4448 = self.origin;
    var_4222ba307df1d46d = spawnstruct();
    
    if ( !isdefined( level.energy_mine_vehicle_throttle ) )
    {
        level.energy_mine_vehicle_throttle = throttle::throttle_initialize( "energy_mine_vehicle_throttle", 1, level.framedurationseconds );
    }
    
    var_a134472124fa2713 = spawnstruct();
    
    if ( !isdefined( level.energy_mine_ai_throttle ) )
    {
        level.energy_mine_ai_throttle = throttle::throttle_initialize( "energy_mine_ai_throttle", 1, level.framedurationseconds );
    }
    
    var_9875e4b080fe8141 = function_c287671a696a9f67( "energy_mine_explosion_radius" );
    sweapon = "none";
    
    if ( isdefined( level.weaponmetadata[ %"energy_mine" ] ) )
    {
        if ( !isdefined( level.weaponmetadata[ %"energy_mine" ].weaponobj ) )
        {
            sweapon = makeweapon( level.weaponmetadata[ %"energy_mine" ].weapon );
            level.weaponmetadata[ %"energy_mine" ].weaponobj = sweapon;
        }
        else
        {
            sweapon = level.weaponmetadata[ %"energy_mine" ].weaponobj;
        }
    }
    
    var_e7b645d747b24dab = function_c287671a696a9f67( "energy_mine_env_damage" );
    self radiusdamage( var_d0a9d177707a4448, var_9875e4b080fe8141, var_e7b645d747b24dab, var_e7b645d747b24dab, player, "MOD_EXPLOSIVE", sweapon, 1 );
    vehicles = vehicle_getarrayinradius( var_d0a9d177707a4448, var_9875e4b080fe8141 );
    var_1c6810b516e22b44 = spawnstruct();
    var_1c6810b516e22b44.player = player;
    
    foreach ( vehicle in vehicles )
    {
        if ( isdefined( vehicle ) )
        {
            var_1c6810b516e22b44.vehicle = vehicle;
            can_affect = 1;
            
            if ( isplayer( vehicle.owner ) )
            {
                if ( utility::issharedfuncdefined( #"zm", #"hash_95f8b65e45fc2ef4" ) )
                {
                    can_affect = level [[ utility::getsharedfunc( #"zm", #"hash_95f8b65e45fc2ef4" ) ]]( self, vehicle.owner );
                }
            }
            
            if ( !can_affect )
            {
                continue;
            }
            
            if ( isdefined( vehicle.owner ) && isdefined( vehicle.owner.team ) && isdefined( self.team ) && vehicle.owner.team != self.team )
            {
                vehicle_damage_checks( var_e7b645d747b24dab, var_1c6810b516e22b44 );
            }
            else if ( isdefined( vehicle.team ) && vehicle.team != player.team )
            {
                vehicle_damage_checks( var_e7b645d747b24dab, var_1c6810b516e22b44 );
            }
            
            if ( isdefined( self ) && isdefined( var_d0a9d177707a4448 ) && isdefined( sweapon ) && isplayer( player ) )
            {
                vehicle dodamage( var_e7b645d747b24dab, var_d0a9d177707a4448, player, self, "MOD_EXPLOSIVE", sweapon );
            }
        }
        
        throttle::throttle_wait_in_queue( level.energy_mine_vehicle_throttle, var_4222ba307df1d46d );
    }
    
    turrets = player get_enemy_turrets( var_9875e4b080fe8141, var_d0a9d177707a4448 );
    
    foreach ( turret in turrets )
    {
        if ( isdefined( turret ) )
        {
            turret dodamage( turret.maxhealth, var_d0a9d177707a4448, player, self, "MOD_EXPLOSIVE", sweapon );
        }
    }
    
    var_aa450e92420bce = 0;
    var_317a1fff030a6aa1 = player get_proximity_enemies( var_9875e4b080fe8141, var_d0a9d177707a4448, 1 );
    soldier_base_dmg = function_c287671a696a9f67( "energy_mine_ai_soldier_damage" ) ?? 100;
    var_12041ab62206c8f9 = function_c287671a696a9f67( "energy_mine_ai_base_damage_percent" ) ?? 2.5;
    var_ad0b57921bc96bf4 = function_c287671a696a9f67( "energy_mine_ai_minumum_damage" ) ?? 50;
    var_375c3e35770652f = 0;
    
    foreach ( ai in var_317a1fff030a6aa1 )
    {
        damage = 0;
        var_9d8e21d3683980ea = 0;
        
        if ( ai && ( ai.type == "human" || ai.unittype == "soldier" ) )
        {
            damage = soldier_base_dmg;
        }
        else
        {
            round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( var_d0a9d177707a4448 );
            zombie_base_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
            damage = int( zombie_base_health * var_12041ab62206c8f9 );
            var_9d8e21d3683980ea = 1;
        }
        
        if ( damage == 0 )
        {
            current_round = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( var_d0a9d177707a4448 );
            var_5454f57201136c19 = function_c287671a696a9f67( "energy_mine_env_damage" );
            damage = namespace_35d7a88a59082733::function_4a6cf9bafc91e53( var_5454f57201136c19, current_round, "frag_grenade", ai.aicategory, ai.maxhealth, ai.var_a03f571fe06a52b8 );
        }
        
        if ( function_c287671a696a9f67( "energy_mine_enable_player_damage" ) )
        {
            if ( isplayer( ai ) )
            {
                damage = function_c287671a696a9f67( "energy_mine_player_damage" );
            }
        }
        
        hitlocation = ai get_ai_hit_location();
        
        if ( damage >= ai.health && !isplayer( ai ) )
        {
            ai utility::ent_flag_init( "energy_mine_kill" );
            ai utility::ent_flag_set( "energy_mine_kill" );
            ai val::set( "insta_kill", "kill_on_damage", 1 );
            ai val::set( "zm_allow_give_super_point", "allow_give_super_point", 0 );
            
            if ( isplayer( player ) && utility::issharedfuncdefined( #"medal", #"track_rapid_kill", 0 ) )
            {
                player utility::callsharedfunc( #"medal", #"track_rapid_kill", "energy_mine", sweapon );
            }
        }
        
        if ( damage < var_ad0b57921bc96bf4 )
        {
            damage = var_ad0b57921bc96bf4;
        }
        
        idflags = 536936448 | ( var_9d8e21d3683980ea ? 1073741824 : 0 );
        ai dodamage( damage, ai.var_c3680fdb0b9459a2 ?? ai.origin, player, self, "MOD_EXPLOSIVE", sweapon, hitlocation, undefined, idflags );
        ai.var_c3680fdb0b9459a2 = undefined;
        
        if ( !isalive( ai ) && !ai.var_33df89471a965163 )
        {
            ai.var_33df89471a965163 = 1;
            v_dir = ai.origin - var_d0a9d177707a4448;
            var_24ed309d808c077a = ai getcorpseentity();
            
            if ( var_375c3e35770652f < 5 )
            {
                if ( isdefined( var_24ed309d808c077a ) )
                {
                    launchx = clamp( v_dir[ 0 ] * 5000, -5000, 5000 );
                    launchy = clamp( v_dir[ 1 ] * 5000, -5000, 5000 );
                    launchz = clamp( ( v_dir[ 2 ] + 150 ) * 5000, 0, 5000 );
                    v_launch = ( launchx, launchy, launchz );
                    var_24ed309d808c077a startragdollfromimpact( "torso_lower", v_launch );
                    var_375c3e35770652f++;
                }
            }
        }
        
        throttle::throttle_wait_in_queue( level.energy_mine_ai_throttle, var_a134472124fa2713 );
        var_aa450e92420bce++;
        
        if ( var_aa450e92420bce == 3 )
        {
            var_aa450e92420bce = 0;
            waitframe();
        }
    }
    
    var_320758f2946bf86 = damage_utility::function_cf1c753aefa70ea1( player.team );
    var_aa450e92420bce = 0;
    var_257031d3a591e483 = var_9875e4b080fe8141 * var_9875e4b080fe8141;
    
    foreach ( ent in var_320758f2946bf86 )
    {
        if ( distancesquared( ent.origin, var_d0a9d177707a4448 ) <= var_257031d3a591e483 )
        {
            damage = 0;
            var_9d8e21d3683980ea = 0;
            round_difficulty = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( var_d0a9d177707a4448 );
            zombie_base_health = namespace_9d8e359c3b1041e5::function_870440d8340968c0( "zombie_base", round_difficulty );
            damage = int( zombie_base_health * var_12041ab62206c8f9 );
            var_9d8e21d3683980ea = 1;
            
            if ( damage == 0 )
            {
                current_round = namespace_9d8e359c3b1041e5::function_57de0ca2e80536a1( var_d0a9d177707a4448 );
                var_5454f57201136c19 = function_c287671a696a9f67( "energy_mine_env_damage" );
                damage = namespace_35d7a88a59082733::function_4a6cf9bafc91e53( var_5454f57201136c19, current_round, "frag_grenade" );
            }
            
            idflags = 536936448 | ( var_9d8e21d3683980ea ? 1073741824 : 0 );
            ent dodamage( damage, ent.origin, player, self, "MOD_EXPLOSIVE", sweapon, hitlocation, undefined, idflags );
            throttle::throttle_wait_in_queue( level.energy_mine_ai_throttle, var_a134472124fa2713 );
            var_aa450e92420bce++;
            
            if ( var_aa450e92420bce == 3 )
            {
                var_aa450e92420bce = 0;
                waitframe();
            }
        }
    }
}

// Namespace field_upgrades_energy_mine
// Params 3
// Checksum 0xcb303659, Offset: 0x2645
// Size: 0xb5
function function_689c49c2f68e773f( player, var_317a1fff030a6aa1, v_origin )
{
    var_7f3cf1897bbf6846 = 3;
    
    foreach ( ai in var_317a1fff030a6aa1 )
    {
        if ( !isalive( ai ) )
        {
            continue;
        }
        
        ai thread function_e58ba5c20dc935cc( var_7f3cf1897bbf6846 );
        ai zombie_stun::stun_ai( var_7f3cf1897bbf6846 );
        waitframe();
    }
}

// Namespace field_upgrades_energy_mine
// Params 0, eflags: 0x4
// Checksum 0x3838741b, Offset: 0x2702
// Size: 0x1f2
function private get_ai_hit_location()
{
    if ( self.aicategory == "boss" )
    {
        return;
    }
    
    hitlocation = "none";
    
    if ( isdefined( self.metabones ) )
    {
        var_caf4e9a8e6600876 = [];
        metabones_def = metabone::get_metabones_def( self.metabones.bundle_name );
        
        if ( isdefined( metabones_def ) )
        {
            foreach ( metabone in metabones_def.metabones )
            {
                if ( !self.metabones.info[ metabone.name ].is_active )
                {
                    continue;
                }
                
                if ( metabone::is_metabone_destroyed( metabone.name ) )
                {
                    continue;
                }
                
                if ( !isdefined( metabone.hitlocations ) )
                {
                    continue;
                }
                
                foreach ( metabone_hit_loc in metabone.hitlocations )
                {
                    var_caf4e9a8e6600876[ var_caf4e9a8e6600876.size ] = metabone_hit_loc.hitlocation;
                }
            }
            
            if ( var_caf4e9a8e6600876.size > 0 )
            {
                hitlocation = var_caf4e9a8e6600876[ randomintrange( 0, var_caf4e9a8e6600876.size ) ];
            }
        }
    }
    
    if ( hitlocation == "head" || hitlocation == "neck" || hitlocation == "helmet" )
    {
        hitlocation = "none";
    }
    
    return hitlocation;
}

// Namespace field_upgrades_energy_mine
// Params 3
// Checksum 0x284d90df, Offset: 0x28fd
// Size: 0x25c
function get_proximity_enemies( n_radius, v_origin, var_785b9da2e4305e41 )
{
    a_ai_all_query = physics_querypoint( v_origin, n_radius, trace::create_character_contents(), undefined, "physicsquery_all" );
    var_a7d1d717be62a064 = [];
    
    foreach ( var_777f6f64f92fa683 in a_ai_all_query )
    {
        entity = var_777f6f64f92fa683[ "entity" ];
        
        if ( isalive( entity ) && ( isagent( entity ) || isplayer( entity ) ) )
        {
            can_affect = 1;
            
            if ( isplayer( entity ) )
            {
                if ( utility::issharedfuncdefined( #"zm", #"hash_95f8b65e45fc2ef4" ) )
                {
                    can_affect = level [[ utility::getsharedfunc( #"zm", #"hash_95f8b65e45fc2ef4" ) ]]( self, entity );
                }
            }
            else if ( isagent( entity ) )
            {
                if ( utility::issharedfuncdefined( #"zm", #"hash_8e5cbc74839b479b" ) )
                {
                    can_affect = level [[ utility::getsharedfunc( #"zm", #"hash_8e5cbc74839b479b" ) ]]( self, entity );
                }
            }
            
            if ( !can_affect )
            {
                continue;
            }
            
            var_a7d1d717be62a064[ var_a7d1d717be62a064.size ] = entity;
            
            if ( entity.aicategory == "boss" )
            {
                entity.var_c3680fdb0b9459a2 = var_777f6f64f92fa683[ "position" ];
            }
        }
    }
    
    var_317a1fff030a6aa1 = [];
    
    foreach ( ai in var_a7d1d717be62a064 )
    {
        if ( !isalive( ai ) )
        {
            continue;
        }
        
        if ( ai.team == self.team )
        {
            continue;
        }
        
        var_317a1fff030a6aa1[ var_317a1fff030a6aa1.size ] = ai;
    }
    
    if ( var_785b9da2e4305e41 )
    {
        var_317a1fff030a6aa1 = sortbydistance( var_317a1fff030a6aa1, v_origin );
    }
    
    return var_317a1fff030a6aa1;
}

// Namespace field_upgrades_energy_mine
// Params 2
// Checksum 0xe9d6cd48, Offset: 0x2b62
// Size: 0x141
function get_enemy_turrets( n_radius, v_origin )
{
    a_all_turrets = getentarrayinradius( "misc_turret", #classname, v_origin, n_radius );
    a_targets = [];
    
    foreach ( turret in a_all_turrets )
    {
        if ( !isdefined( turret ) )
        {
            continue;
        }
        
        if ( turret.team == self.team )
        {
            continue;
        }
        
        can_affect = 1;
        
        if ( isplayer( turret.owner ) )
        {
            if ( utility::issharedfuncdefined( #"zm", #"hash_95f8b65e45fc2ef4" ) )
            {
                can_affect = level [[ utility::getsharedfunc( #"zm", #"hash_95f8b65e45fc2ef4" ) ]]( self, turret.owner );
            }
        }
        
        if ( !can_affect )
        {
            continue;
        }
        
        a_targets[ a_targets.size ] = turret;
    }
    
    return a_targets;
}

// Namespace field_upgrades_energy_mine
// Params 1
// Checksum 0x1f9f40a, Offset: 0x2cac
// Size: 0x1f
function play_vfx( str_vfx_label )
{
    playfxontag( utility::getfx( str_vfx_label ), self, "tag_origin" );
}

// Namespace field_upgrades_energy_mine
// Params 1
// Checksum 0x964b45e5, Offset: 0x2cd3
// Size: 0x1f
function stop_vfx( str_vfx_label )
{
    stopfxontag( utility::getfx( str_vfx_label ), self, "tag_origin" );
}

// Namespace field_upgrades_energy_mine
// Params 1
// Checksum 0xfa36ccd7, Offset: 0x2cfa
// Size: 0x24
function function_e58ba5c20dc935cc( duration )
{
    level endon( #"game_ended" );
    self endon( #"death" );
}

// Namespace field_upgrades_energy_mine
// Params 1
// Checksum 0x5964a9bc, Offset: 0x2d26
// Size: 0x19
function function_c287671a696a9f67( var_92718a0fa1b5dcae )
{
    return field_upgrades::function_5f728868b18ef0c0( "super_energy_mine", var_92718a0fa1b5dcae );
}

// Namespace field_upgrades_energy_mine
// Params 0
// Checksum 0x886d891f, Offset: 0x2d48
// Size: 0xd
function get_energy_mine_bundle()
{
    return field_upgrades::function_55abafe10f7fd36b( "super_energy_mine" );
}

// Namespace field_upgrades_energy_mine
// Params 4, eflags: 0x4
// Checksum 0x864bb5d3, Offset: 0x2d5e
// Size: 0x197
function private on_killed_medal( victim, einflictor, smeansofdeath, sweapon )
{
    self.energy_mine_kill_count++;
    victim.is_lethal_or_super_kill = 1;
    
    if ( self.energy_mine_kill_count == 10 )
    {
        namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"medal_deathtrap" );
        
        if ( utility::issharedfuncdefined( #"sound", #"play_scoreevent_vo", 0 ) )
        {
            utility::callsharedfunc( #"sound", #"play_scoreevent_vo", self, #"bc_super_energy_mine_success" );
        }
    }
    
    if ( self.energy_mine_kill_count == 20 )
    {
        if ( utility::issharedfuncdefined( #"player", #"doScoreEvent", 0 ) )
        {
            utility::callsharedfunc( #"player", #"doScoreEvent", #"medal_fullycharged" );
        }
        
        if ( utility::issharedfuncdefined( #"challenges", #"hash_4dbee06d8fb19056" ) )
        {
            utility::callsharedfunc( #"challenges", #"hash_4dbee06d8fb19056", #"medal_fullycharged" );
        }
    }
    
    params = { #highest_multi_kills:1, #stats:"kills", #inflictor:einflictor, #ref:"super_energy_mine", #field_upgrade:"energy_mine", #victim:victim, #player:self };
    callback::callback( "on_field_upgrade_kill_track", params );
}

