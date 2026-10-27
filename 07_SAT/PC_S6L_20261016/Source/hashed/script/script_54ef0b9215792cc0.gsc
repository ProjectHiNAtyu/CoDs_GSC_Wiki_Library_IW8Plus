// script_54ef0b9215792cc0  (hash_54ef0b9215792cc0.gscc) (size: 4820 Bytes / 0x12d4 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8665e0fd (2254823677)
// size ...... 4820 (0x12d4)
// includes .. 10  (offset: 0x11dc)
// strings ... 14  (offset: 0x122c)
// dev strs .. 0   (offset: 0x12d4)
// exports ... 10  (offset: 0xb4c)
// cseg ...... 0x1b0 + 0x99c (0xb4c)
// imports ... 43  (offset: 0xcdc)
// animtree1 . 0   (offset: 0x12d4)
// animtree2 . 0   (offset: 0x12d4)
#using script_aa3bac81ad4fc8e;
#using scripts\anim\utility;
#using scripts\common\callbacks;
#using scripts\common\powerups;
#using scripts\common\system;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\loot\common_item;
#using scripts\mp\zm\systems\zone_manager;
#using scripts\mp\zm\zm_player;

#namespace bgb_zm;

// Namespace bgb_zm
// Params 0, eflags: 0x5
// Checksum 0x126111b7, Offset: 0x1ce
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"bgb_zm", #"bgb", &pre_main, undefined );
}

// Namespace bgb_zm
// Params 0, eflags: 0x4
// Checksum 0xfd1e64cd, Offset: 0x1f7
// Size: 0x98
function private pre_main()
{
    utility::registersharedfunc( #"bgb", #"hash_6a2d092be9b7041e", &function_9ecd75f64d86a93f );
    utility::registersharedfunc( #"bgb", #"hash_56f7ba41e3b2f7b8", &function_f6c20f50c45b4e6b );
    utility::registersharedfunc( #"bgb", #"hash_8f6e526f4e3003f9", &function_5e53a4c5e5a4250e );
    utility::registersharedfunc( #"bgb", #"player_proximity_watcher", &player_proximity_watcher );
    utility::registersharedfunc( #"bgb", #"convert_gobblegum", &function_91c0d4bf38001b08 );
}

// Namespace bgb_zm
// Params 3, eflags: 0x4
// Checksum 0xc631a6b3, Offset: 0x297
// Size: 0x6e
function private function_9ecd75f64d86a93f( str_powerup, v_origin, safe_spawn = 0 )
{
    if ( !isdefined( v_origin ) )
    {
        if ( safe_spawn )
        {
            v_origin = function_56fb4a0334398003( v_origin, str_powerup );
            
            if ( !isdefined( v_origin ) )
            {
                return;
            }
        }
        else
        {
            v_origin = bgb::function_d38deee41dc2c68b( 1 );
        }
    }
    
    e_powerup = powerups::powerup_drop( str_powerup, v_origin, undefined, undefined, "gobblegum" );
}

// Namespace bgb_zm
// Params 3, eflags: 0x4
// Checksum 0x73ead114, Offset: 0x30d
// Size: 0x16e
function private function_f6c20f50c45b4e6b( v_origin, str_powerup, var_ec64564690f126b3 = 0 )
{
    if ( isdefined( str_powerup ) )
    {
        root = powerups::get_powerups_root();
        
        if ( !isdefined( root.powerups[ str_powerup ] ) )
        {
            return 0;
        }
    }
    
    if ( !self isonground() && !self isswimming() )
    {
        return 0;
    }
    
    n_count = 1;
    
    if ( var_ec64564690f126b3 )
    {
        n_count = 3;
    }
    
    for ( x = 0; x < n_count ; x++ )
    {
        switch ( x )
        {
            case 1:
                var_b6081b1b6ba5e8b5 = 50;
                v_origin = undefined;
                break;
            case 2:
                var_b6081b1b6ba5e8b5 = 0;
                v_origin = undefined;
                return 1;
            default:
                var_b6081b1b6ba5e8b5 = 100;
                break;
        }
        
        b_passed = 1;
        
        if ( !isdefined( v_origin ) )
        {
            v_origin = bgb::function_d38deee41dc2c68b( 0, var_b6081b1b6ba5e8b5 );
        }
        
        a_ai = getaiarrayinradius( v_origin, 128 );
        
        if ( !trace::ray_trace_passed( self geteye(), v_origin, a_ai ) )
        {
            b_passed = 0;
            continue;
        }
        
        var_313663700b9fea38 = getrandomnavpoint( v_origin, 32 );
        
        if ( !isdefined( var_313663700b9fea38 ) )
        {
            b_passed = 0;
            continue;
        }
        
        if ( !zone_manager::function_65305a611c6226d9( var_313663700b9fea38 ) )
        {
            b_passed = 0;
            continue;
        }
        
        if ( b_passed )
        {
            return 1;
        }
    }
    
    return b_passed;
}

// Namespace bgb_zm
// Params 1, eflags: 0x4
// Checksum 0xe54109f2, Offset: 0x484
// Size: 0xe3, Type: bool
function private function_5e53a4c5e5a4250e( a_v_origin )
{
    if ( !self isonground() && !self isswimming() )
    {
        return false;
    }
    
    a_ai = getaiarrayinradius( self.origin, 256 );
    
    foreach ( v_origin in a_v_origin )
    {
        var_313663700b9fea38 = getrandomnavpoint( v_origin, 32 );
        
        if ( !isdefined( var_313663700b9fea38 ) )
        {
            return false;
        }
        
        if ( !zone_manager::function_65305a611c6226d9( var_313663700b9fea38 ) )
        {
            return false;
        }
        
        if ( !trace::ray_trace_passed( self geteye(), v_origin, a_ai ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace bgb_zm
// Params 4, eflags: 0x4
// Checksum 0xa39c12d7, Offset: 0x570
// Size: 0x1b7
function private player_proximity_watcher( s_bgb_name, var_f1049b8a723a44d5, var_ee74f5c08773dd01, var_9d750119fbee4b60 )
{
    self endon( #"disconnect" );
    self endon( #"last_stand_bleedout" );
    self endon( "kill_" + s_bgb_name + "_player_proximity_watcher" );
    self.var_d2d61a0b77c6612 = [];
    
    while ( true )
    {
        foreach ( e_player in level.players )
        {
            if ( e_player == self )
            {
                continue;
            }
            
            if ( e_player.team != self.team )
            {
                continue;
            }
            
            self.var_d2d61a0b77c6612 = function_5713d46873b29625( self.var_d2d61a0b77c6612 );
            var_f15f0a7869d29e1 = arraycontains( self.var_d2d61a0b77c6612, e_player );
            var_a001a4923b538c6d = zm_player::function_f37cfdf04b932a03( e_player, 0, 1 ) && bgb::function_c697fa83a109543f( var_f1049b8a723a44d5, self, e_player );
            
            if ( !var_f15f0a7869d29e1 && var_a001a4923b538c6d )
            {
                self.var_d2d61a0b77c6612 = arraycombineunique( self.var_d2d61a0b77c6612, [ e_player ] );
                
                if ( isdefined( var_ee74f5c08773dd01 ) )
                {
                    self thread [[ var_ee74f5c08773dd01 ]]( e_player );
                }
                
                continue;
            }
            
            if ( var_f15f0a7869d29e1 && !var_a001a4923b538c6d )
            {
                self.var_d2d61a0b77c6612 = arrayremove( self.var_d2d61a0b77c6612, e_player );
                
                if ( isdefined( var_9d750119fbee4b60 ) )
                {
                    self thread [[ var_9d750119fbee4b60 ]]( e_player );
                }
            }
        }
        
        waitframe();
    }
}

// Namespace bgb_zm
// Params 3, eflags: 0x4
// Checksum 0xabf538da, Offset: 0x72f
// Size: 0x1be
function private function_56fb4a0334398003( v_origin, str_powerup, var_7fc939c89f986074 = 1 )
{
    n_count = 1;
    
    if ( var_7fc939c89f986074 )
    {
        n_count = 6;
    }
    
    for ( x = 0; x < n_count ; x++ )
    {
        switch ( x )
        {
            case 1:
                var_b6081b1b6ba5e8b5 = 100;
                n_radius = 96;
                v_origin = undefined;
                break;
            case 2:
            case 3:
            case 4:
                v_origin = getclosestpointonnavmesh( v_origin );
                
                if ( isdefined( v_origin ) )
                {
                    v_origin += ( 0, 0, powerups::get_powerup_var( "drop_height_offset" ) );
                }
                
                break;
            case 5:
                thread powerups::powerup_activate( str_powerup );
                return;
            default:
                var_b6081b1b6ba5e8b5 = 100;
                n_radius = 32;
                break;
        }
        
        b_passed = 1;
        
        if ( !isdefined( v_origin ) )
        {
            v_origin = bgb::function_d38deee41dc2c68b( 0, var_b6081b1b6ba5e8b5 );
        }
        
        my_zone = zone_manager::get_current_zone();
        spawn_zone = zone_manager::function_90e5c3e2272b0130( v_origin );
        a_ai = getaiarrayinradius( v_origin, 128 );
        
        if ( !trace::ray_trace_passed( self geteye(), v_origin, a_ai ) )
        {
            if ( x < 2 )
            {
                b_passed = 0;
                continue;
            }
            
            if ( my_zone != spawn_zone )
            {
                b_passed = 0;
                continue;
            }
        }
        
        var_313663700b9fea38 = getrandomnavpoint( v_origin, n_radius );
        
        if ( !isdefined( var_313663700b9fea38 ) )
        {
            b_passed = 0;
            continue;
        }
        
        if ( !zone_manager::function_65305a611c6226d9( v_origin ) )
        {
            b_passed = 0;
            continue;
        }
        
        if ( b_passed )
        {
            return v_origin;
        }
    }
    
    return v_origin;
}

// Namespace bgb_zm
// Params 1, eflags: 0x4
// Checksum 0x63eef9bc, Offset: 0x8f6
// Size: 0x1f9
function private function_91c0d4bf38001b08( value )
{
    self endon( #"disconnect" );
    
    if ( self.var_f1dccd054c74a27e[ value ] || bgb::is_enabled( self.var_b02f6e7abbbc8a84[ value ] ) )
    {
        self playlocalsound( #"hash_d8d9c4eb514390a7" );
        return;
    }
    
    scoreparams = spawnstruct();
    var_e86acefb2fb714d5 = 0;
    bgb = self.var_b02f6e7abbbc8a84[ value ];
    scoreparams.var_46993e9f6a989d94 = 1;
    
    switch ( level.bgb[ bgb ].rarity )
    {
        case #"hash_56dca9558042f91d":
            scoreparams.scoreevent = #"hash_65346de69d25e429";
            break;
        case #"hash_9f79c9fc1aa660aa":
            scoreparams.scoreevent = #"hash_1aedbd80718e4f16";
            break;
        case #"hash_c81e81c97be2c6a8":
            scoreparams.scoreevent = #"hash_994a0e69e3d85c44";
            break;
        case #"hash_ca3e413b1500d035":
            scoreparams.scoreevent = #"hash_88499a1ceab7b4c9";
            break;
        case #"hash_b8ce55e0f7e8f868":
            scoreparams.scoreevent = #"hash_5bcbca04816b686c";
            break;
    }
    
    var_29befae4c74639d1 = "cer_zm_vm_ges_bgb_dust_" + self.var_b02f6e7abbbc8a84[ value ];
    thread utility::function_72b6372d2d8c997( var_29befae4c74639d1, 1 );
    utility::waittill_any_timeout( 1, "death", "last_stand_enter", "gesture_stopped", "disconnect", "weapon_gesture_failed" );
    bgb::function_4818e19472b65502( self.var_b02f6e7abbbc8a84[ value ], value, { #var_46993e9f6a989d94:scoreparams.var_46993e9f6a989d94 } );
    bgb::take( value, 1 );
    callback::callback( "zombie_score_event", scoreparams );
    bgb::function_b0af7e10a5498433( "zm_gobblegum_converted", bgb, value );
    waitframe();
}

// Namespace bgb_zm
// Params 1
// Checksum 0x81ce5a0, Offset: 0xaf7
// Size: 0x55
function function_7a5a1a9984bc67bb( currency_amount )
{
    self notify( #"hash_92ee10be2566118d" );
    self endon( #"disconnect" );
    self setclientomnvar( "ui_loot_splash_item_quantity", currency_amount );
    self setclientomnvar( "ui_loot_splash_item_id", 121443 );
    self endon( #"hash_92ee10be2566118d" );
    waitframe();
    common_item::function_dba5cd48d3cd08cb();
}

