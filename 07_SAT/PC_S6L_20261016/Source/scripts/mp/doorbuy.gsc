// scripts\mp\doorbuy.gsc  (hash_681a06cc8e9fcb34.gscc) (size: 26892 Bytes / 0x690c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x43c712b9 (1137119929)
// size ...... 26892 (0x690c)
// includes .. 10  (offset: 0x6320)
// strings ... 56  (offset: 0x6370)
// dev strs .. 35  (offset: 0x66e8)
// exports ... 42  (offset: 0x475c)
// cseg ...... 0x4b7 + 0x42a5 (0x475c)
// imports ... 167 (offset: 0x4dec)
// animtree1 . 0   (offset: 0x690c)
// animtree2 . 0   (offset: 0x690c)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\content_manager;
#using scripts\mp\currency;
#using scripts\mp\interaction;
#using scripts\mp\weapons;
#using scripts\mp\zm\zm_ui;

#namespace doorbuy;

// Namespace doorbuy
// Params 0
// Checksum 0xbcdb2e93, Offset: 0x4d5
// Size: 0x36
function function_3a9ed49a80b0af77()
{
    level thread _init_doorbuy();
    setdvarifuninitialized( @"hash_56c1e5374b115ae9", 1 );
    
    if ( getdvarint( @"hash_56c1e5374b115ae9", 0 ) )
    {
        level.var_a93ba697bc9fda85 = 1;
    }
}

// Namespace doorbuy
// Params 0
// Checksum 0xcf28ab09, Offset: 0x513
// Size: 0xd3
function _init_doorbuy()
{
    level.a_s_doorbuys = [];
    utility::flag_init( "doorbuy_init_complete" );
    content_manager::function_3209da123476142f( "doorbuy", &on_spawn_doorbuy );
    wait 0.1;
    var_959dbddcfff2592d = utility::getstructarray( "content_destination", "variantname" );
    a_t_doorbuys = getentarray( "zombie_door", #targetname );
    level.var_ef9f0679f84d804a = function_604184d72ddb0eb4( var_959dbddcfff2592d, a_t_doorbuys );
    
    if ( isdefined( var_959dbddcfff2592d ) && var_959dbddcfff2592d.size > 0 )
    {
        level thread function_57c21acc6c9ec2a5( var_959dbddcfff2592d[ 0 ] );
    }
    
    level thread function_8409796a370cd7d( a_t_doorbuys );
    
    if ( level.var_ef9f0679f84d804a == 0 )
    {
        utility::flag_set( "doorbuy_init_complete" );
    }
    
    scriptable::scriptable_addnotifycallback( "buy_debris_activated", &buy_debris_activated );
    
    /#
        level thread init_doorbuy_devgui();
    #/
}

// Namespace doorbuy
// Params 4
// Checksum 0x843ae008, Offset: 0x5ee
// Size: 0x5d
function buy_debris_activated( instance, note, param, var_64ffacba090c91be )
{
    earthquake( 0.3, 2, instance.origin, 300 );
    playrumbleonposition( "damage_light", instance.origin );
    function_41162e3b2e5b672c();
}

// Namespace doorbuy
// Params 2, eflags: 0x4
// Checksum 0x9a5bbe37, Offset: 0x653
// Size: 0x173
function private function_604184d72ddb0eb4( var_959dbddcfff2592d, radiant_doorbuys )
{
    count = 0;
    
    if ( isdefined( var_959dbddcfff2592d ) && var_959dbddcfff2592d.size > 0 )
    {
        destination = var_959dbddcfff2592d[ 0 ];
        
        foreach ( location in destination.locations )
        {
            var_3178977087f30c14 = location.instances[ "doorbuy" ];
            
            if ( isdefined( var_3178977087f30c14 ) )
            {
                foreach ( instance in var_3178977087f30c14.versions )
                {
                    var_1e50e779efcca809 = instance.var_1d6cddfc47031bff[ "doorbuy_trigger" ];
                    
                    if ( isarray( var_1e50e779efcca809 ) )
                    {
                        count += var_1e50e779efcca809.size;
                    }
                }
            }
        }
    }
    
    count += radiant_doorbuys.size;
    return count;
}

// Namespace doorbuy
// Params 0
// Checksum 0xb10b8de9, Offset: 0x7cf
// Size: 0x1c
function function_ebd700ab45c45880()
{
    if ( !isdefined( level.a_s_doorbuys ) )
    {
        return 0;
    }
    
    return level.a_s_doorbuys.size;
}

// Namespace doorbuy
// Params 1
// Checksum 0x250229, Offset: 0x7f4
// Size: 0x118
function function_57c21acc6c9ec2a5( destination )
{
    foreach ( location in destination.locations )
    {
        var_3178977087f30c14 = location.instances[ "doorbuy" ];
        
        if ( isdefined( var_3178977087f30c14 ) )
        {
            foreach ( instance in var_3178977087f30c14.versions )
            {
                content_manager::function_67e4b7678fb21e11( instance );
            }
        }
    }
}

// Namespace doorbuy
// Params 1
// Checksum 0x87b489bf, Offset: 0x914
// Size: 0xf4
function function_8409796a370cd7d( a_t_doorbuys )
{
    foreach ( t_doorbuy in a_t_doorbuys )
    {
        t_doorbuy function_bebb07becf84eb7( a_t_doorbuys );
        assert( isdefined( t_doorbuy.target ) || isdefined( t_doorbuy.target2 ), "<dev string:x24>" + t_doorbuy.origin + "<dev string:x38>" );
        instance = utility::getstruct( t_doorbuy.target ?? t_doorbuy.target2, "targetname" );
        t_doorbuy function_2cc72e030c9278f1( instance, 1 );
    }
}

// Namespace doorbuy
// Params 1, eflags: 0x4
// Checksum 0x9b490592, Offset: 0xa10
// Size: 0xad
function private on_spawn_doorbuy( instance )
{
    var_1e50e779efcca809 = instance.var_1d6cddfc47031bff[ "doorbuy_trigger" ];
    
    if ( isarray( var_1e50e779efcca809 ) )
    {
        foreach ( s_doorbuy_info in var_1e50e779efcca809 )
        {
            s_doorbuy_info function_2cc72e030c9278f1( instance );
            s_doorbuy_info function_bebb07becf84eb7( var_1e50e779efcca809 );
        }
    }
}

// Namespace doorbuy
// Params 1
// Checksum 0x3423dc9f, Offset: 0xac5
// Size: 0xc8
function function_bebb07becf84eb7( var_1e50e779efcca809 )
{
    if ( !isdefined( self.var_fa7d41026092afd2 ) )
    {
        self.var_fa7d41026092afd2 = [];
    }
    
    foreach ( doorbuy_info in var_1e50e779efcca809 )
    {
        if ( self.target == doorbuy_info.target && self != doorbuy_info )
        {
            self.var_fa7d41026092afd2 = arraycombineunique( self.var_fa7d41026092afd2, [ doorbuy_info ] );
        }
    }
}

// Namespace doorbuy
// Params 1
// Checksum 0x10b550a8, Offset: 0xb95
// Size: 0x111
function function_2b67728ef24e3715( n_currency )
{
    if ( !isarray( self.s_doorbuy.var_fa7d41026092afd2 ) )
    {
        return;
    }
    else if ( isarray( self.s_doorbuy.var_fa7d41026092afd2 ) && self.s_doorbuy.var_fa7d41026092afd2.size == 0 )
    {
        return;
    }
    
    foreach ( connected_trigger in self.s_doorbuy.var_fa7d41026092afd2 )
    {
        if ( isdefined( connected_trigger.script_cost ) )
        {
            connected_trigger.script_cost -= n_currency;
            connected_trigger.var_6b6c1bfda2809bae = 1;
        }
    }
}

// Namespace doorbuy
// Params 2, eflags: 0x4
// Checksum 0x3176f3a5, Offset: 0xcae
// Size: 0xd0a
function private function_2cc72e030c9278f1( instance, var_2edab1067afe8daa )
{
    a_doors = [];
    self.instance = instance;
    
    if ( isdefined( self.script_flag_wait ) )
    {
        thread function_47dd8b6065fa9d81( self.script_flag_wait );
    }
    
    if ( isdefined( self.script_modelname ) )
    {
        door = content_manager::spawn_script_model( self, self.script_modelname, 1 );
        door.var_f1be77dc9d0b94af = self.script_timeout;
        door.str_open_sound = self.script_soundalias;
        a_doors[ a_doors.size ] = door;
        
        if ( isent( door ) )
        {
            if ( door isscriptable() )
            {
                assert( door getscriptablehaspart( "<dev string:x51>" ), "<dev string:x56>" + door.origin + "<dev string:x6d>" );
                assert( door getscriptableparthasstate( "<dev string:x51>", "<dev string:x8e>" ), "<dev string:x56>" + door.origin + "<dev string:x95>" );
                assert( door getscriptableparthasstate( "<dev string:x51>", "<dev string:xc6>" ), "<dev string:x56>" + door.origin + "<dev string:xce>" );
                door setscriptablepartstate( "base", "closed" );
            }
            else if ( isdefined( self.target2 ) )
            {
                var_e4a8ca52b7ce7441 = utility::getstruct( self.target2, "targetname" );
                door.v_open_pos = var_e4a8ca52b7ce7441.origin;
                door.var_c469cbb9729b47aa = var_e4a8ca52b7ce7441.angles;
            }
        }
        
        var_3ac3949fdb1ce0b2 = self;
        var_31fca1348e82e1a2 = door;
    }
    else
    {
        var_f2ac270b1ae4d1e6 = utility::getstructarray( self.target2, "targetname" );
        a_doors = [];
        
        if ( isarray( var_f2ac270b1ae4d1e6 ) )
        {
            foreach ( var_828c983a968614fd in var_f2ac270b1ae4d1e6 )
            {
                if ( !isdefined( var_828c983a968614fd.door ) )
                {
                    var_828c983a968614fd.door = content_manager::spawn_script_model( instance, var_828c983a968614fd.script_modelname, 1, undefined, var_828c983a968614fd.origin );
                    var_828c983a968614fd.door.angles = var_828c983a968614fd.angles;
                    var_828c983a968614fd.door.target = var_828c983a968614fd.target;
                    var_828c983a968614fd.door.script_delete = var_828c983a968614fd.script_delete;
                    var_828c983a968614fd.door.var_f1be77dc9d0b94af = var_828c983a968614fd.script_timeout ?? self.script_timeout;
                    var_828c983a968614fd.door.str_open_sound = var_828c983a968614fd.script_soundalias ?? self.script_soundalias;
                }
                
                a_doors[ a_doors.size ] = var_828c983a968614fd.door;
            }
        }
        
        if ( isdefined( self.target2 ) )
        {
            a_door_scriptables = getscriptablearray( self.target2, #targetname );
            a_doors = arraycombineunique( a_doors, a_door_scriptables );
            var_acc3550c7b0f250a = getentitylessscriptablearray( self.target2, #targetname );
            a_doors = arraycombineunique( a_doors, var_acc3550c7b0f250a );
            a_door_ents = getentarray( self.target2, #targetname );
            a_doors = arraycombineunique( a_doors, a_door_ents );
        }
        
        foreach ( door in a_doors )
        {
            if ( isent( door ) )
            {
                if ( door isscriptable() )
                {
                    assert( door getscriptablehaspart( "<dev string:x51>" ), "<dev string:x56>" + door.origin + "<dev string:x6d>" );
                    assert( door getscriptableparthasstate( "<dev string:x51>", "<dev string:x8e>" ), "<dev string:x56>" + door.origin + "<dev string:x95>" );
                    assert( door getscriptableparthasstate( "<dev string:x51>", "<dev string:xc6>" ), "<dev string:x56>" + door.origin + "<dev string:xce>" );
                    door setscriptablepartstate( "base", "closed" );
                    
                    if ( door getscriptablehaspart( "icon" ) && !level.gametypebundle.var_777fb0e05f9d144c )
                    {
                        utility::callsharedfunc( #"scriptable", #"hash_10d5e3bb8a551724", door, "icon" );
                    }
                }
                else if ( isdefined( door.target ) )
                {
                    var_e4a8ca52b7ce7441 = utility::getstruct( door.target, "targetname" );
                    door.v_open_pos = var_e4a8ca52b7ce7441.origin;
                    door.var_c469cbb9729b47aa = var_e4a8ca52b7ce7441.angles;
                    
                    if ( isdefined( var_e4a8ca52b7ce7441.target ) )
                    {
                        door.var_1d5250246632b2e5 = getent( var_e4a8ca52b7ce7441.target, #targetname );
                        
                        if ( isdefined( door.var_1d5250246632b2e5 ) )
                        {
                            door.var_1d5250246632b2e5 notsolid();
                            door.var_1d5250246632b2e5 connectpaths();
                        }
                    }
                }
                else if ( isdefined( door.target2 ) )
                {
                    var_e4a8ca52b7ce7441 = utility::getstruct( door.target2, "targetname" );
                    door.v_open_pos = var_e4a8ca52b7ce7441.origin;
                    door.var_c469cbb9729b47aa = var_e4a8ca52b7ce7441.angles;
                }
                
                if ( door.script_parameters == "bob" )
                {
                    door thread do_bob();
                }
                
                if ( !isdefined( door.var_f1be77dc9d0b94af ) )
                {
                    door.var_f1be77dc9d0b94af = door.script_timeout;
                }
                
                if ( !isdefined( door.str_open_sound ) )
                {
                    door.str_open_sound = door.script_soundalias;
                }
                
                continue;
            }
            
            if ( door isscriptableinstance() )
            {
                assert( door getscriptablehaspart( "<dev string:x51>" ), "<dev string:x56>" + door.origin + "<dev string:x6d>" );
                assert( door getscriptableparthasstate( "<dev string:x51>", "<dev string:x8e>" ), "<dev string:x56>" + door.origin + "<dev string:x95>" );
                assert( door getscriptableparthasstate( "<dev string:x51>", "<dev string:xc6>" ), "<dev string:x56>" + door.origin + "<dev string:xce>" );
                door setscriptablepartstate( "base", "closed" );
                
                if ( door getscriptablehaspart( "icon" ) && !level.gametypebundle.var_777fb0e05f9d144c )
                {
                    utility::callsharedfunc( #"scriptable", #"hash_10d5e3bb8a551724", door, "icon" );
                }
            }
        }
        
        if ( var_2edab1067afe8daa )
        {
            var_31fca1348e82e1a2 = self;
            n_dist_box = distance( self getpointinbounds( 1, 1, 1 ), self getpointinbounds( -1, -1, -1 ) );
            self.radius = n_dist_box;
        }
        else
        {
            var_31fca1348e82e1a2 = self.origin;
        }
    }
    
    if ( level.gametypebundle.var_777fb0e05f9d144c )
    {
        utility::flag_set( "doorbuy_init_complete" );
        return;
    }
    
    if ( !isdefined( self.radius ) )
    {
        self.radius = 80;
    }
    
    if ( !isdefined( self.script_cost ) )
    {
        self.script_cost = 1000;
    }
    
    if ( !isdefined( self.script_currency ) )
    {
        self.script_currency = #"essence";
    }
    
    self.interact = interaction::register_interact( var_31fca1348e82e1a2, self.radius, &doorbuy_used, undefined, undefined, undefined, undefined, "HINT_BUTTON" );
    self.interact interaction::set_interact_hint_callback( &set_interact_hint );
    self.interact sethintonobstruction( "show" );
    
    if ( self.script_noteworthy == "barrier_unpurchaseable_trigger" )
    {
        self.interact setcursorhint( "HINT_NOBUTTON" );
    }
    
    if ( function_f9df5874c38b508a() )
    {
        self.interact sethintinoperable( 1 );
        self.interact setcursorhint( "HINT_NOBUTTON" );
    }
    
    level.a_s_doorbuys[ level.a_s_doorbuys.size ] = self;
    self.interact.var_2edab1067afe8daa = var_2edab1067afe8daa;
    
    if ( isdefined( self.script_tag ) && self.interact tagexists( self.script_tag ) )
    {
        self.interact sethinttag( self.script_tag );
    }
    else if ( self.interact tagexists( "tag_hint" ) )
    {
        self.interact sethinttag( "tag_hint" );
    }
    
    self.interact.s_doorbuy = self;
    self.interact.doors = a_doors;
    minimap_icon = "cp_mp_doorbuy_minimap";
    
    if ( function_f9df5874c38b508a() )
    {
        minimap_icon = "cp_mp_power_door_minimap";
    }
    
    foreach ( door in a_doors )
    {
        if ( !isdefined( door.var_fc824b622a52db8d ) )
        {
            door.var_fc824b622a52db8d = [];
        }
        
        door.var_fc824b622a52db8d = arraycombineunique( door.var_fc824b622a52db8d, [ self.interact ] );
        
        if ( door isscriptable() )
        {
            calloutmarkerping::function_6052d1ed5729bcfc( door );
            continue;
        }
        
        if ( self.script_label == "doorbuy_zipline_doors" )
        {
            continue;
        }
        
        if ( !isdefined( door.minimap_scriptable ) && door.script_noteworthy != "no_minimap" )
        {
            minimap_origin = door.origin;
            minimap_angles = door.angles;
            
            if ( door.script_noteworthy == "override_minimap" )
            {
                assert( isdefined( door.script_label ), "<dev string:x101>" + ( door.targetname ?? door.origin ) + "<dev string:x142>" );
                
                if ( isdefined( door.script_label ) )
                {
                    minimap_struct = utility::getstruct( door.script_label );
                }
                
                if ( isdefined( minimap_struct ) )
                {
                    if ( isdefined( minimap_struct.script_noteworthy ) )
                    {
                        minimap_icon = minimap_struct.script_noteworthy;
                    }
                    
                    minimap_origin = minimap_struct.origin;
                    minimap_angles = minimap_struct.angles;
                    
                    if ( !isdefined( minimap_angles ) )
                    {
                        minimap_angles = ( 0, 0, 0 );
                    }
                }
            }
            
            door.minimap_scriptable = spawnscriptable( minimap_icon, minimap_origin, minimap_angles );
            utility::callsharedfunc( #"scriptable", #"hash_10d5e3bb8a551724", door.minimap_scriptable, "icon" );
        }
        
        target = door.minimap_scriptable ?? door;
        calloutmarkerping::function_6052d1ed5729bcfc( target );
        door.s_doorbuy = self;
        
        if ( !isdefined( door.v_close_pos ) )
        {
            door.v_close_pos = door.origin;
        }
        
        if ( !isdefined( door.v_close_ang ) )
        {
            door.v_close_ang = door.angles;
        }
    }
    
    if ( isvector( var_31fca1348e82e1a2 ) || var_2edab1067afe8daa )
    {
        self.interact.script_delete = 1;
        self.interact.var_c3520c71cf883b16 = 1;
    }
    
    thread setup_door_by_type();
    
    if ( isdefined( level.var_787f52d8df79647f ) )
    {
        self thread [[ level.var_787f52d8df79647f ]]();
    }
    
    if ( level.var_ef9f0679f84d804a > 0 )
    {
        level.var_ef9f0679f84d804a--;
        
        if ( level.var_ef9f0679f84d804a == 0 )
        {
            utility::flag_set( "doorbuy_init_complete" );
        }
        
        return;
    }
    
    assertmsg( "<dev string:x17b>" );
}

// Namespace doorbuy
// Params 1, eflags: 0x4
// Checksum 0x7f9b14cb, Offset: 0x19c0
// Size: 0x7b
function private function_47dd8b6065fa9d81( var_46f1327fcd04fb1e )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    if ( !var_46f1327fcd04fb1e )
    {
        return;
    }
    
    a_str_wait_flags = strtok( var_46f1327fcd04fb1e, ", " );
    level utility::flag_wait_all_array( a_str_wait_flags );
    level utility::flag_wait( "doorbuy_init_complete" );
    
    if ( isdefined( self ) && isdefined( self.interact ) )
    {
        self.interact doorbuy_used();
    }
}

// Namespace doorbuy
// Params 0, eflags: 0x4
// Checksum 0x6ca712d5, Offset: 0x1a43
// Size: 0xf1
function private do_bob()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    start_pos = self.origin;
    start_angles = self.angles;
    random_wait = randomfloat( 3 );
    move_offset = self.script_offset ?? ( 0, 0, 2 );
    var_562085c3a13bb970 = self.script_angles ?? ( 0, 0, 0 );
    move_time = abs( self.script_num ?? 1.5 );
    wait random_wait;
    
    while ( true )
    {
        self moveto( start_pos + move_offset, move_time );
        self rotateby( var_562085c3a13bb970, move_time );
        wait move_time;
        self moveto( start_pos, move_time );
        self rotateby( var_562085c3a13bb970 * -1, move_time );
        wait move_time;
    }
}

// Namespace doorbuy
// Params 0, eflags: 0x4
// Checksum 0xdca99230, Offset: 0x1b3c
// Size: 0x1f
function private get_hint_type()
{
    if ( self.script_noteworthy == "barrier_unpurchaseable_trigger" )
    {
        return "HINT_NOBUTTON";
    }
    
    return "HINT_BUTTON";
}

// Namespace doorbuy
// Params 1, eflags: 0x4
// Checksum 0xcd804716, Offset: 0x1b64
// Size: 0x613
function private function_fba1e29fd1ae8c28( player )
{
    if ( function_b5b0771f2a4adb31( self.script_noteworthy ) )
    {
        return self [[ level.doorbuy_hint_overrides[ self.script_noteworthy ] ]]( player );
    }
    
    hint_data = {};
    hint_data.type = get_hint_type();
    hint_data.buttoncallout = &"SHARED_HINTSTRINGS/HINT_BUY";
    hint_data.var_776a268784e089af = &"SHARED_HINTSTRINGS/COST_ESSENCE";
    hint_data.interactable = 1;
    var_b4dab724fa2a3943 = 0;
    can_afford_only_half_buy = 0;
    
    if ( isplayer( player ) && isdefined( self.script_currency ) && isdefined( self.script_cost ) )
    {
        if ( player currency::can_afford( self.script_currency, int( self.script_cost / 2 ) ) && !self.var_6b6c1bfda2809bae && level.var_a93ba697bc9fda85 )
        {
            var_b4dab724fa2a3943 = 1;
            hint_data.altbuttoncallout = &"SHARED_HINTSTRINGS/HINT_BUY_HALF";
            hint_data.var_492f94db590aab17 = 1;
        }
        
        if ( !player currency::can_afford( self.script_currency, self.script_cost ) )
        {
            if ( player currency::can_afford( self.script_currency, int( self.script_cost / 2 ) ) && !self.var_6b6c1bfda2809bae && level.var_a93ba697bc9fda85 )
            {
                can_afford_only_half_buy = 1;
            }
            else
            {
                hint_data.aux_text = &"SHARED_HINTSTRINGS/NOT_ENOUGH_ESSENCE";
                hint_data.var_776a268784e089af = &"SHARED_HINTSTRINGS/COST_ESSENCE_NOT_ENOUGH";
                hint_data.interactable = 0;
            }
        }
    }
    
    if ( player.var_86a7511c974051e8 )
    {
        player setclientomnvar( "ui_zm_doorbuy_can_afford_only_half_buy", can_afford_only_half_buy );
        player setclientomnvar( "ui_zm_doorbuy_is_doorbuy", var_b4dab724fa2a3943 );
        
        if ( !isbot( player ) )
        {
            player allowreload( !var_b4dab724fa2a3943 );
        }
    }
    
    if ( isdefined( self.script_noteworthy ) )
    {
        switch ( self.script_noteworthy )
        {
            case #"hash_279cf0389419e022":
                hint_data.var_ca8523ea008acd97 = level.var_580dfaea382b5f7b ?? &"shared_hintstrings/doorbuy_barrier_lock_hint";
                hint_data.var_ca8523ea008acd97 = self.var_a0d364b16ee53ab6 ?? hint_data.var_ca8523ea008acd97;
                break;
            case #"hash_fe4be2d2f966a37d":
                if ( isplayer( player ) && isdefined( self.script_currency ) && isdefined( self.script_cost ) && !player currency::can_afford( self.script_currency, self.script_cost ) )
                {
                    hint_data.var_ca8523ea008acd97 = &"SHARED_HINTSTRINGS/DOORBUY_BARRIER_HINT_ESSENCE_NOT_ENOUGH";
                }
                else
                {
                    hint_data.var_ca8523ea008acd97 = &"shared_hintstrings/doorbuy_barrier_hint_essence";
                }
                
                hint_data.title = &"SHARED_HINTSTRINGS/LOCKED_BARRIER";
                hint_data.description = &"SHARED_HINTSTRINGS/UNLOCK_BARRIER";
                break;
            case #"hash_12c639a20c74c99a":
                if ( isplayer( player ) && isdefined( self.script_currency ) && isdefined( self.script_cost ) && !player currency::can_afford( self.script_currency, self.script_cost ) )
                {
                    hint_data.var_ca8523ea008acd97 = &"SHARED_HINTSTRINGS/DOORBUY_AETHER_CHARGE_HINT_ESSENCE_NOT_ENOUGH";
                }
                else
                {
                    hint_data.var_ca8523ea008acd97 = &"shared_hintstrings/doorbuy_aether_charge_hint_essence";
                }
                
                hint_data.title = &"SHARED_HINTSTRINGS/DOORBUY_AETHER_CHARGE_HINT_TITLE";
                hint_data.description = &"SHARED_HINTSTRINGS/DOORBUY_AETHER_CHARGE_HINT_DESCRIPTION";
                break;
            case #"hash_8ca401dfbd7e139a":
                if ( isplayer( player ) && isdefined( self.script_currency ) && isdefined( self.script_cost ) && !player currency::can_afford( self.script_currency, self.script_cost ) )
                {
                    hint_data.var_ca8523ea008acd97 = &"SHARED_HINTSTRINGS/DOORBUY_AETHER_GATEWAY_HINT_ESSENCE_NOT_ENOUGH";
                }
                else
                {
                    hint_data.var_ca8523ea008acd97 = &"SHARED_HINTSTRINGS/DOORBUY_AETHER_GATEWAY_HINT_ESSENCE";
                }
                
                hint_data.title = &"SHARED_HINTSTRINGS/DOORBUY_AETHER_GATEWAY_HINT_TITLE";
                hint_data.description = &"SHARED_HINTSTRINGS/UNLOCK_AETHER_GATE";
                break;
            default:
                if ( isplayer( player ) && isdefined( self.script_currency ) && isdefined( self.script_cost ) && !player currency::can_afford( self.script_currency, self.script_cost ) )
                {
                    hint_data.var_ca8523ea008acd97 = &"SHARED_HINTSTRINGS/DOORBUY_HINT_ESSENCE_NOT_ENOUGH";
                }
                else
                {
                    hint_data.var_ca8523ea008acd97 = &"shared_hintstrings/doorbuy_hint_essence";
                }
                
                hint_data.title = &"SHARED_HINTSTRINGS/LOCKED_BARRIER";
                hint_data.description = &"SHARED_HINTSTRINGS/UNLOCK_BARRIER";
                break;
        }
    }
    else if ( self.script_currency == #"essence" )
    {
        if ( isplayer( player ) && isdefined( self.script_currency ) && isdefined( self.script_cost ) && !player currency::can_afford( self.script_currency, self.script_cost ) )
        {
            hint_data.var_ca8523ea008acd97 = &"SHARED_HINTSTRINGS/DOORBUY_HINT_ESSENCE_NOT_ENOUGH";
        }
        else
        {
            hint_data.var_ca8523ea008acd97 = &"shared_hintstrings/doorbuy_hint_essence";
        }
        
        hint_data.title = &"SHARED_HINTSTRINGS/LOCKED_DOOR";
        hint_data.description = &"SHARED_HINTSTRINGS/UNLOCK_DOOR";
    }
    else
    {
        hint_data.var_ca8523ea008acd97 = &"shared_hintstrings/doorbuy_hint";
        hint_data.title = &"SHARED_HINTSTRINGS/LOCKED_DOOR";
        hint_data.description = &"SHARED_HINTSTRINGS/UNLOCK_DOOR";
    }
    
    return hint_data;
}

// Namespace doorbuy
// Params 1, eflags: 0x4
// Checksum 0xe6e29fd7, Offset: 0x2180
// Size: 0x19, Type: bool
function private function_b5b0771f2a4adb31( script_noteworthy )
{
    return isdefined( level.doorbuy_hint_overrides[ script_noteworthy ] );
}

// Namespace doorbuy
// Params 2
// Checksum 0x2100c6ec, Offset: 0x21a2
// Size: 0x39
function register_doorbuy_hint_override( script_noteworthy, function )
{
    if ( !isdefined( level.doorbuy_hint_overrides ) )
    {
        level.doorbuy_hint_overrides = [];
    }
    
    level.doorbuy_hint_overrides[ script_noteworthy ] = function;
}

// Namespace doorbuy
// Params 2
// Checksum 0x58a6b7aa, Offset: 0x21e3
// Size: 0x221
function set_interact_hint( interact, player )
{
    if ( interact.var_df00f5fbf4a6d195 || player.doorbuy_disabled )
    {
        return { #string:&"", #type:"HINT_NOBUTTON" };
    }
    
    if ( interact.var_be02046fb805072f )
    {
        return [[ interact.var_be02046fb805072f ]]();
    }
    
    if ( interact.s_doorbuy function_f9df5874c38b508a() )
    {
        return { #string:&"shared_hintstrings/doorbuy_power_hint", #type:"HINT_NOBUTTON" };
    }
    
    if ( !player.var_86a7511c974051e8 && !interact.s_doorbuy.var_6b6c1bfda2809bae && level.var_a93ba697bc9fda85 )
    {
        player function_3fca0dce0e38a7cd( interact );
    }
    
    hint_data = interact.s_doorbuy function_fba1e29fd1ae8c28( player );
    return { #interactable:hint_data.interactable, #icon_text_value:interact.s_doorbuy.script_cost, #var_776a268784e089af:hint_data.var_776a268784e089af, #var_492f94db590aab17:hint_data.var_492f94db590aab17, #altbuttoncallout:hint_data.altbuttoncallout, #buttoncallout:hint_data.buttoncallout, #icon:"ui_icon_zm_ping_door_buy", #aux_text:hint_data.aux_text, #description:hint_data.description, #title:hint_data.title, #params:[ interact.s_doorbuy.script_cost ], #string:hint_data.var_ca8523ea008acd97, #type:hint_data.type };
}

// Namespace doorbuy
// Params 0, eflags: 0xc
// Checksum 0x580ba13a, Offset: 0x240c
// Size: 0xbd
function private function_e149dd6f849b963b()
{
    self notify( #"hash_12648a03bd7fc40c" );
    self endon( #"hash_12648a03bd7fc40c" );
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self.var_86a7511c974051e8 = 0;
    self setclientomnvar( "ui_zm_doorbuy_can_afford_only_half_buy", 0 );
    self setclientomnvar( "ui_zm_doorbuy_is_doorbuy", 0 );
    
    if ( !isbot( self ) )
    {
        self notifyonplayercommandremove( "try_partial_doorbuy_kbm", "+reload" );
        self notifyonplayercommandremove( "try_partial_doorbuy_gpad", "-usereload" );
    }
    
    self notify( #"hash_afbf85aa367ae330" );
    self notify( #"hash_3a71a44ce1688f54" );
    self notify( #"hash_b6fb83d581ac6f13" );
    wait 0.1;
    
    if ( self && !isbot( self ) )
    {
        self allowreload( 1 );
    }
}

// Namespace doorbuy
// Params 1, eflags: 0x4
// Checksum 0xa89cd720, Offset: 0x24d1
// Size: 0x99
function private function_bd5676abf02fb1ce( doorbuy_interact )
{
    if ( isdefined( doorbuy_interact ) && isdefined( doorbuy_interact.classname ) && issubstr( doorbuy_interact.classname, "trigger_use_touch" ) )
    {
        if ( self istouching( doorbuy_interact ) )
        {
            return 1;
        }
        else
        {
            thread function_e149dd6f849b963b();
            return 0;
        }
        
        return;
    }
    
    if ( isdefined( doorbuy_interact ) && distancesquared( self.origin, doorbuy_interact.origin ) <= squared( doorbuy_interact.interact_use_range + 16 ) )
    {
        return 1;
    }
    
    thread function_e149dd6f849b963b();
    return 0;
}

// Namespace doorbuy
// Params 1, eflags: 0x4
// Checksum 0xdbf8a938, Offset: 0x2572
// Size: 0x46
function private watch_doorbuy_death( doorbuy_interact )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_afbf85aa367ae330" );
    
    while ( isdefined( doorbuy_interact ) )
    {
        wait 0.1;
    }
    
    thread function_e149dd6f849b963b();
}

// Namespace doorbuy
// Params 1, eflags: 0x4
// Checksum 0xdd3ee58f, Offset: 0x25c0
// Size: 0x44
function private function_6de9218d69c8ab7f( doorbuy_interact )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_3a71a44ce1688f54" );
    
    while ( function_bd5676abf02fb1ce( doorbuy_interact ) )
    {
        wait 0.1;
    }
}

// Namespace doorbuy
// Params 1, eflags: 0x4
// Checksum 0xaa0c57d4, Offset: 0x260c
// Size: 0xc3
function private function_72758843abb969b2( doorbuy_interact )
{
    level endon( #"game_ended" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_b6fb83d581ac6f13" );
    
    while ( true )
    {
        notifies = [ "try_partial_doorbuy_kbm", "try_partial_doorbuy_gpad" ];
        event = utility::waittill_any_in_array_return( notifies );
        isvalidinput = 0;
        
        if ( event == "try_partial_doorbuy_kbm" && !self usinggamepad() )
        {
            isvalidinput = 1;
        }
        
        if ( event == "try_partial_doorbuy_gpad" && self usinggamepad() )
        {
            isvalidinput = 1;
        }
        
        if ( isvalidinput && isdefined( doorbuy_interact ) )
        {
            doorbuy_interact doorbuy_used( self, 1 );
        }
        
        wait 0.2;
    }
}

// Namespace doorbuy
// Params 1, eflags: 0x4
// Checksum 0xee232027, Offset: 0x26d7
// Size: 0x68
function private function_3fca0dce0e38a7cd( doorbuy_interact )
{
    if ( !function_bd5676abf02fb1ce( doorbuy_interact ) )
    {
        return;
    }
    
    self.var_86a7511c974051e8 = 1;
    thread watch_doorbuy_death( doorbuy_interact );
    thread function_6de9218d69c8ab7f( doorbuy_interact );
    thread function_72758843abb969b2( doorbuy_interact );
    
    if ( !isbot( self ) )
    {
        self notifyonplayercommand( "try_partial_doorbuy_kbm", "+reload" );
        self notifyonplayercommand( "try_partial_doorbuy_gpad", "-usereload" );
    }
}

// Namespace doorbuy
// Params 3
// Checksum 0x3b2815d5, Offset: 0x2747
// Size: 0x8fd
function doorbuy_used( player, var_54f8d266ca684f81 = 0, var_a1ae419b85f5d368 = 0 )
{
    if ( function_afd33abc58033464( self.script_noteworthy ) )
    {
        can_use = self [[ level.var_26f6f781a3927035[ self.script_noteworthy ] ]]( player, var_54f8d266ca684f81, var_a1ae419b85f5d368 );
        
        if ( !can_use )
        {
            return;
        }
    }
    
    if ( self.s_doorbuy.script_noteworthy == "barrier_unpurchaseable_trigger" && !var_a1ae419b85f5d368 )
    {
        return;
    }
    
    if ( self.s_doorbuy function_f9df5874c38b508a() )
    {
        if ( !utility::flag( self.s_doorbuy.script_power ) && !level.var_1f0b531f139f7db0 )
        {
            return;
        }
    }
    
    if ( player.doorbuy_disabled || self.var_df00f5fbf4a6d195 )
    {
        return;
    }
    
    if ( var_54f8d266ca684f81 )
    {
        if ( level.var_a93ba697bc9fda85 && player currency::can_afford( self.s_doorbuy.script_currency, int( self.s_doorbuy.script_cost / 2 ) ) && !self.s_doorbuy.var_6b6c1bfda2809bae )
        {
            var_87a61a281906b856 = player currency::get_currency_amount( self.s_doorbuy.script_currency );
            
            if ( var_87a61a281906b856 > 0 )
            {
                half_cost = int( self.s_doorbuy.script_cost / 2 );
                self.s_doorbuy.script_cost -= half_cost;
                self.s_doorbuy.var_6b6c1bfda2809bae = 1;
                self.s_doorbuy.var_82715ba80990f81e = player;
                thread function_2b67728ef24e3715( half_cost );
                player currency::function_b5fe1e05c892a7f3( self.s_doorbuy.script_currency, half_cost );
                
                if ( !isdefined( player.doorbuycount ) )
                {
                    player.doorbuycount = 0;
                }
                
                player.doorbuycount++;
                player zm_ui::function_b814b25c8d99fd02();
                player playsoundtoplayer( "ui_zm_core_door_purchase_partial", player );
                var_779c2c832b8369c1 = utility::getsharedfunc( #"doorbuy", #"hash_1388194a849c420b" );
                
                if ( isfunction( var_779c2c832b8369c1 ) )
                {
                    self thread [[ var_779c2c832b8369c1 ]]( player, 1 );
                }
                
                params = spawnstruct();
                params.cost = half_cost;
                params.currency = self.s_doorbuy.script_currency;
                params.doorbuy_origin = self.s_doorbuy.origin;
                player callback::callback( "doorbuy_contributed", params );
                player thread function_e149dd6f849b963b();
                return;
            }
        }
        else
        {
            player playsoundtoplayer( "ui_zm_core_door_purchase_deny", player );
            return;
        }
    }
    
    if ( isdefined( player ) && isdefined( self.s_doorbuy.script_currency ) && isdefined( self.s_doorbuy.script_cost ) )
    {
        if ( !player currency::attempt_purchase( self.s_doorbuy.script_currency, self.s_doorbuy.script_cost, 1, 1 ) )
        {
            player playsoundtoplayer( "ui_zm_core_door_purchase_deny", player );
            return;
        }
        
        if ( level.var_a93ba697bc9fda85 )
        {
            player thread function_e149dd6f849b963b();
        }
    }
    
    if ( isplayer( player ) )
    {
        if ( !( self.s_doorbuy.var_6b6c1bfda2809bae && self.s_doorbuy.var_82715ba80990f81e == player ) )
        {
            if ( !isdefined( player.doorbuycount ) )
            {
                player.doorbuycount = 0;
            }
            
            player.doorbuycount++;
            player zm_ui::function_b814b25c8d99fd02();
        }
        
        self.s_doorbuy.player_paid = player;
        var_779c2c832b8369c1 = utility::getsharedfunc( #"doorbuy", #"hash_1388194a849c420b" );
        
        if ( isfunction( var_779c2c832b8369c1 ) )
        {
            self thread [[ var_779c2c832b8369c1 ]]( player, 0 );
        }
        
        params = spawnstruct();
        params.cost = self.s_doorbuy.script_cost;
        params.currency = self.s_doorbuy.script_currency;
        params.doorbuy_origin = self.s_doorbuy.origin;
        player callback::callback( "doorbuy_bought", params );
    }
    
    if ( isarray( self.doors ) )
    {
        self.doors = function_5713d46873b29625( self.doors );
        multi_bomb_candidate = 0;
        var_be9c5f516b6a98cf = undefined;
        closest_bomb = undefined;
        
        if ( isdefined( player ) )
        {
            foreach ( door in self.doors )
            {
                if ( door.script_noteworthy == "aether_bomb" )
                {
                    multi_bomb_candidate++;
                    
                    if ( !isdefined( var_be9c5f516b6a98cf ) || distance2dsquared( player.origin, door.origin ) < var_be9c5f516b6a98cf )
                    {
                        var_be9c5f516b6a98cf = distance2dsquared( player.origin, door.origin );
                        closest_bomb = door;
                    }
                }
            }
        }
        
        foreach ( door in self.doors )
        {
            if ( door.script_noteworthy == "aether_bomb" && multi_bomb_candidate > 1 && door != closest_bomb )
            {
                continue;
            }
            
            door thread function_f3160e450543b4f1();
        }
    }
    
    if ( isdefined( self.s_doorbuy.script_flag_set ) )
    {
        var_54196d8915743f8c = strtok( self.s_doorbuy.script_flag_set, ", " );
        
        foreach ( flag in var_54196d8915743f8c )
        {
            if ( !utility::flag( flag ) )
            {
                utility::flag_set( flag );
            }
        }
    }
    
    level notify( #"door_opened", self );
    self.b_doorbuy_opened = 1;
    
    if ( isdefined( self.s_doorbuy.instance ) )
    {
        var_1e50e779efcca809 = self.s_doorbuy.instance.var_1d6cddfc47031bff[ "doorbuy_trigger" ];
        
        if ( isarray( var_1e50e779efcca809 ) )
        {
            foreach ( s_doorbuy_info in var_1e50e779efcca809 )
            {
                if ( isdefined( s_doorbuy_info.interact ) && s_doorbuy_info.interact != self && s_doorbuy_info.interact.var_c3520c71cf883b16 )
                {
                    s_doorbuy_info.interact delete();
                }
            }
        }
    }
    
    interacts = [ self ];
    
    if ( self.var_fa7d41026092afd2.size > 0 )
    {
        interacts = arraycombine( interacts, self.var_fa7d41026092afd2 );
    }
    
    interaction::set_interact_hint_callback();
    waitframe();
    
    foreach ( interact in interacts )
    {
        if ( interact.script_delete )
        {
            interact delete();
            continue;
        }
        
        interact makeunusable();
    }
}

// Namespace doorbuy
// Params 1, eflags: 0x4
// Checksum 0x60c96354, Offset: 0x304c
// Size: 0x19, Type: bool
function private function_afd33abc58033464( script_noteworthy )
{
    return isdefined( level.var_26f6f781a3927035[ script_noteworthy ] );
}

// Namespace doorbuy
// Params 2
// Checksum 0xb18db170, Offset: 0x306e
// Size: 0x39
function function_187e1dcefd0b97f6( script_noteworthy, function )
{
    if ( !isdefined( level.var_26f6f781a3927035 ) )
    {
        level.var_26f6f781a3927035 = [];
    }
    
    level.var_26f6f781a3927035[ script_noteworthy ] = function;
}

// Namespace doorbuy
// Params 0
// Checksum 0xffba1ca8, Offset: 0x30af
// Size: 0x7c1
function function_f3160e450543b4f1()
{
    level endon( #"game_ended" );
    
    if ( !isdefined( self ) )
    {
        return;
    }
    
    if ( self.var_c1c98a810b837560 )
    {
        return;
    }
    
    self endon( #"death" );
    
    if ( isdefined( self.s_doorbuy.script_flag_set ) )
    {
        var_54196d8915743f8c = strtok( self.s_doorbuy.script_flag_set, ", " );
    }
    else
    {
        var_54196d8915743f8c = [];
    }
    
    if ( isdefined( self.script_label ) )
    {
        switch ( self.script_label )
        {
            case #"hash_c74793819e403f51":
                wait 2;
                break;
            case #"hash_636f553f8477a0b":
                self setmodel( "t10_zm_energy_barrier_05_green" );
                break;
            default:
                break;
        }
    }
    
    var_1c4c6c3dbf51118d = 1;
    
    if ( isdefined( self.targetname ) )
    {
        var_1633aeb19852e197 = utility::getstructarray( self.targetname + "_mayh", "targetname" );
        
        foreach ( var_24d6d9cd2ddcc833 in var_1633aeb19852e197 )
        {
            if ( var_24d6d9cd2ddcc833.script_noteworthy == "door_mayh" )
            {
                var_24d6d9cd2ddcc833 thread function_85021eb2917afa72();
                var_1c4c6c3dbf51118d = 0;
            }
        }
    }
    
    if ( self.script_noteworthy == "aether_charge_doorbuy" )
    {
        var_1c4c6c3dbf51118d = 0;
    }
    
    params = spawnstruct();
    params.door = self;
    params.enabled_flags = [];
    
    foreach ( flag in var_54196d8915743f8c )
    {
        if ( !utility::flag( flag ) )
        {
            utility::flag_set( flag );
        }
        
        params.enabled_flags[ params.enabled_flags.size ] = flag;
    }
    
    level callback::callback( "doorbuy_opened", params );
    level callback::callback( "wall_destroyed", params );
    level.any_doorbuy_opened = 1;
    self.var_c1c98a810b837560 = 1;
    self notify( #"doorbuy_opening" );
    
    if ( var_1c4c6c3dbf51118d )
    {
        function_41162e3b2e5b672c();
    }
    
    if ( isent( self ) )
    {
        self connectpaths();
    }
    
    if ( isdefined( self.minimap_scriptable ) )
    {
        self.minimap_scriptable calloutmarkerping::function_608710c894185549();
        self.minimap_scriptable freescriptable();
    }
    
    if ( isarray( self.var_fc824b622a52db8d ) )
    {
        foreach ( interact in self.var_fc824b622a52db8d )
        {
            if ( isdefined( interact ) )
            {
                interact interaction::set_interact_hint_callback();
                interact makeunusable();
            }
        }
    }
    
    if ( self isscriptable() || !isent( self ) && self isscriptableinstance() )
    {
        self setscriptablepartstate( "base", "opening" );
        
        if ( self getscriptablehaspart( "fx" ) )
        {
            self setscriptablepartstate( "fx", "off" );
        }
        
        if ( self getscriptablehaspart( "icon" ) && self getscriptableparthasstate( "icon", "hide" ) )
        {
            utility::ent_flag_wait( "minimap_floor_setup_complete" );
            calloutmarkerping::function_608710c894185549();
            self setscriptablepartstate( "icon", "hide" );
        }
        
        if ( self.script_delete )
        {
            thread delete_door( level.var_7cdfe561c60155c7 );
        }
    }
    else if ( self.script_noteworthy == "trig_rumble_mobile_barrier" )
    {
        self delete();
    }
    else if ( self.script_string == "garage_panel" )
    {
        move_time = 0.5;
        panel_height = 20;
        rotate_sequence = [ self ];
        
        for ( current_panel = self; current_panel.target ; current_panel = next_panel )
        {
            next_panel = getent( current_panel.target, "targetname" );
            rotate_sequence[ rotate_sequence.size ] = next_panel;
        }
        
        rotate_sequence = arrayreverse( rotate_sequence );
        
        foreach ( rotate_panel in rotate_sequence )
        {
            foreach ( panel in rotate_sequence )
            {
                if ( panel != rotate_panel )
                {
                    panel moveto( panel.origin + panel_height * anglestoup( panel.angles ), move_time );
                }
            }
            
            rotate_panel rotateroll( 90, move_time );
            rotate_panel movez( panel_height, move_time );
            
            if ( rotate_panel != rotate_sequence[ rotate_sequence.size - 1 ] )
            {
                wait move_time;
            }
        }
    }
    else
    {
        n_time = self.var_f1be77dc9d0b94af ?? 0;
        n_time = clamp( n_time, 0, 999 );
        
        if ( self.classname != "script_brushmodel" )
        {
            if ( isdefined( self.str_open_sound ) )
            {
                self playsound( self.str_open_sound );
            }
        }
        
        if ( self.classname != "trigger_multiple" )
        {
            self notsolid();
        }
        
        if ( n_time > 0 )
        {
            self.v_closed_pos = self.origin;
            self.var_c3e9a8dee767ec16 = self.angles;
            
            if ( isdefined( self.v_open_pos ) )
            {
                self moveto( self.v_open_pos, n_time );
                
                if ( isdefined( self.var_c469cbb9729b47aa ) )
                {
                    self rotateto( self.var_c469cbb9729b47aa, n_time );
                }
                
                self waittill( #"movedone" );
                
                if ( isdefined( self.var_1d5250246632b2e5 ) )
                {
                    self.var_1d5250246632b2e5 solid();
                    self.var_1d5250246632b2e5 disconnectpaths();
                }
                
                self solid();
                self disconnectpaths();
            }
            else
            {
                self movez( -150, n_time );
                self waittill( #"movedone" );
                self delete();
            }
            
            if ( self.script_delete )
            {
                self delete();
            }
        }
        else if ( self.s_doorbuy.var_870561c2bbbdb6b7 && !self.var_29b8bf859c59528f )
        {
            self hide();
            
            if ( self.classname == "trigger_multiple" )
            {
                self triggerdisable();
            }
        }
        else
        {
            self delete();
        }
    }
    
    if ( self )
    {
        if ( !isdefined( self.v_open_pos ) )
        {
            self.v_open_pos = self.origin;
        }
        
        if ( !isdefined( self.var_c469cbb9729b47aa ) )
        {
            self.var_c469cbb9729b47aa = self.angles;
        }
    }
}

// Namespace doorbuy
// Params 1
// Checksum 0xbf6485f6, Offset: 0x3878
// Size: 0x3b
function delete_door( n_wait )
{
    level endon( #"game_ended" );
    
    if ( !isdefined( n_wait ) )
    {
        n_wait = 0;
    }
    
    wait n_wait;
    
    if ( !isent( self ) )
    {
        self freescriptable();
        return;
    }
    
    self delete();
}

// Namespace doorbuy
// Params 0
// Checksum 0xb2769e24, Offset: 0x38bb
// Size: 0xaf
function get_power_doors()
{
    var_59c4aaad9a034619 = [];
    
    foreach ( doorbuy in level.a_s_doorbuys )
    {
        if ( doorbuy function_f9df5874c38b508a() )
        {
            var_59c4aaad9a034619 = arraycombine( var_59c4aaad9a034619, doorbuy.interact.doors );
            var_59c4aaad9a034619 = function_5713d46873b29625( var_59c4aaad9a034619 );
        }
    }
    
    return var_59c4aaad9a034619;
}

// Namespace doorbuy
// Params 0
// Checksum 0xd116c88b, Offset: 0x3973
// Size: 0x70, Type: bool
function function_f9df5874c38b508a()
{
    var_203048bf8e79d87b = isdefined( self.script_power ) && issubstr( self.script_power, "power" );
    var_99265881bb5ed634 = isdefined( self.script_type ) && ( self.script_type == "power_open" || self.script_type == "power_transform" );
    return var_203048bf8e79d87b || var_99265881bb5ed634;
}

// Namespace doorbuy
// Params 1
// Checksum 0x73bfff54, Offset: 0x39ec
// Size: 0x3f
function function_cf1348629c6352a3( func )
{
    if ( !isdefined( self.var_8a51b1366300646c ) )
    {
        self.var_8a51b1366300646c = [];
    }
    
    self.var_8a51b1366300646c = arraycombineunique( self.var_8a51b1366300646c, [ func ] );
}

// Namespace doorbuy
// Params 2
// Checksum 0xfcabb97b, Offset: 0x3a33
// Size: 0x154
function function_f036c23977df35fc( var_b0e144194be51c26, var_9bf605f73c24cda5 )
{
    doors = get_power_doors();
    b_global_power = !isdefined( var_9bf605f73c24cda5 );
    
    foreach ( door in doors )
    {
        var_a507e285448e8204 = door.script_int == var_9bf605f73c24cda5;
        
        if ( !var_a507e285448e8204 && !b_global_power )
        {
            continue;
        }
        
        assert( isdefined( door.var_8a51b1366300646c ), "<dev string:x1c2>" );
        
        foreach ( func in door.var_8a51b1366300646c )
        {
            door thread [[ func ]]( var_b0e144194be51c26 );
        }
    }
}

// Namespace doorbuy
// Params 1, eflags: 0x4
// Checksum 0x68fb3297, Offset: 0x3b8f
// Size: 0x18
function private function_573923bfcbd19999( b_power_state )
{
    if ( b_power_state )
    {
        thread function_f3160e450543b4f1();
    }
}

// Namespace doorbuy
// Params 1, eflags: 0x4
// Checksum 0x8d91c855, Offset: 0x3baf
// Size: 0x120
function private function_82c21bfa22cb1bf5( b_power_state )
{
    if ( b_power_state )
    {
        foreach ( interact in self.var_fc824b622a52db8d )
        {
            hint_data = interact function_fba1e29fd1ae8c28();
            interact interaction::set_interact_hint_string( hint_data.var_ca8523ea008acd97, interact.script_cost );
            interact sethintinoperable( 0 );
            interact setcursorhint( hint_data.hint_type );
            
            if ( self.script_noteworthy != "no_minimap" )
            {
                self.minimap_scriptable calloutmarkerping::function_608710c894185549();
                self.minimap_scriptable freescriptable();
                self.minimap_scriptable = spawnscriptable( "cp_mp_doorbuy_minimap", self.origin, self.angles );
            }
        }
    }
}

// Namespace doorbuy
// Params 0, eflags: 0x4
// Checksum 0x5fbc719f, Offset: 0x3cd7
// Size: 0x15e
function private setup_door_by_type()
{
    var_5c961989955a899f = self.script_type;
    
    if ( !isdefined( var_5c961989955a899f ) )
    {
        if ( function_f9df5874c38b508a() )
        {
            var_5c961989955a899f = "power_open";
        }
        else
        {
            return;
        }
    }
    
    switch ( var_5c961989955a899f )
    {
        case #"hash_40cb59b986cd76c7":
            foreach ( door in self.interact.doors )
            {
                door function_cf1348629c6352a3( &function_573923bfcbd19999 );
            }
            
            break;
        case #"hash_8ad550d7a39a5a2d":
            foreach ( door in self.interact.doors )
            {
                door function_cf1348629c6352a3( &function_82c21bfa22cb1bf5 );
            }
            
            break;
    }
}

// Namespace doorbuy
// Params 0
// Checksum 0x5925df6d, Offset: 0x3e3d
// Size: 0xa8
function open_all_doorbuys()
{
    level.var_1f0b531f139f7db0 = 1;
    
    foreach ( s_doorbuy in level.a_s_doorbuys )
    {
        if ( isdefined( s_doorbuy.interact ) )
        {
            s_doorbuy.interact thread doorbuy_used();
        }
    }
    
    level.var_1f0b531f139f7db0 = undefined;
}

// Namespace doorbuy
// Params 0, eflags: 0x4
// Checksum 0x364e77f9, Offset: 0x3eed
// Size: 0x6c
function private function_85021eb2917afa72()
{
    level endon( #"game_ended" );
    
    if ( isdefined( self.script_parameters ) && isdefined( self.targetname ) )
    {
        wait 2;
        function_41162e3b2e5b672c();
        spawnmayhem( self.targetname, self.script_parameters, self.origin, self.angles );
        wait 2;
        killmayhem( self.targetname );
    }
}

// Namespace doorbuy
// Params 0
// Checksum 0x56db5caf, Offset: 0x3f61
// Size: 0xa7
function function_41162e3b2e5b672c()
{
    if ( !isent( self ) )
    {
        return;
    }
    
    var_913f116085eb2ee9 = self getlinkedchildren();
    
    if ( isdefined( var_913f116085eb2ee9 ) )
    {
        foreach ( ent in var_913f116085eb2ee9 )
        {
            if ( ent.classname == "grenade" )
            {
                ent weapons::deleteexplosive();
            }
        }
    }
}

/#

    // Namespace doorbuy
    // Params 0, eflags: 0x4
    // Checksum 0xa8b2a1af, Offset: 0x4010
    // Size: 0x46, Type: dev
    function private init_doorbuy_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x1f4>" );
        devgui::add_devgui_func( "<dev string:x201>", "<dev string:x215>", &function_9057649876b078ca, 1 );
        devgui::add_devgui_func( "<dev string:x229>", "<dev string:x23b>", &open_all_doorbuys );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace doorbuy
    // Params 0, eflags: 0x4
    // Checksum 0xd5dff249, Offset: 0x405e
    // Size: 0x6fe, Type: dev
    function private function_9057649876b078ca()
    {
        var_344c87cda146b92c = ( 0, 0, 4 );
        n_text_size = 0.25;
        
        while ( true )
        {
            foreach ( s_doorbuy in level.a_s_doorbuys )
            {
                if ( !isdefined( s_doorbuy.interact ) )
                {
                    continue;
                }
                
                var_d876b0c0fe4d6eba = "<dev string:x24d>";
                
                if ( isdefined( s_doorbuy.script_tag ) && s_doorbuy.interact tagexists( s_doorbuy.script_tag ) )
                {
                    v_position = s_doorbuy.interact gettagorigin( s_doorbuy.script_tag );
                    var_d876b0c0fe4d6eba = s_doorbuy.script_tag;
                }
                else if ( s_doorbuy.interact tagexists( "<dev string:x258>" ) )
                {
                    v_position = s_doorbuy.interact gettagorigin( "<dev string:x258>", 1 );
                    var_d876b0c0fe4d6eba = "<dev string:x258>";
                }
                else
                {
                    v_position = s_doorbuy.interact.origin;
                }
                
                if ( s_doorbuy.interact.var_2edab1067afe8daa )
                {
                    level thread utility::draw_entity_bounds( s_doorbuy.interact, 0.05 );
                }
                else
                {
                    utility::draw_circle( v_position, s_doorbuy.interact.interact_use_range, ( 0, 0, 1 ), 1, 0, 1 );
                }
                
                print3d( v_position, "<dev string:x261>" + s_doorbuy.script_currency, ( 0, 1, 0 ), 1, n_text_size );
                print3d( v_position - var_344c87cda146b92c, "<dev string:x271>" + s_doorbuy.script_cost, ( 0, 1, 0 ), 1, n_text_size );
                str_zone_flags = "<dev string:x278>";
                str_zone_names = "<dev string:x278>";
                
                if ( isdefined( s_doorbuy.script_flag_set ) )
                {
                    var_54196d8915743f8c = strtok( s_doorbuy.script_flag_set, "<dev string:x279>" );
                    
                    foreach ( str_flag in var_54196d8915743f8c )
                    {
                        str_zone_flags = str_zone_flags + str_flag + "<dev string:x27c>";
                    }
                    
                    if ( isdefined( level.zone_manager ) && isarray( level.zone_manager.defs ) )
                    {
                        foreach ( var_e7476cf4916b5a8 in level.zone_manager.defs )
                        {
                            if ( isarray( var_e7476cf4916b5a8.var_c96b1c3cfbbd6aac ) )
                            {
                                foreach ( var_4cdafb4532dd9de4, zone_def_adjacent in var_e7476cf4916b5a8.var_c96b1c3cfbbd6aac )
                                {
                                    if ( isarray( zone_def_adjacent.flags ) )
                                    {
                                        foreach ( str_flag in zone_def_adjacent.flags )
                                        {
                                            if ( arraycontains( var_54196d8915743f8c, str_flag ) )
                                            {
                                                str_zone_names = str_zone_names + var_4cdafb4532dd9de4 + "<dev string:x27c>";
                                                break;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                print3d( v_position - var_344c87cda146b92c * 2, "<dev string:x27e>" + str_zone_flags, ( 0, 1, 0 ), 1, 0.25 );
                print3d( v_position - var_344c87cda146b92c * 3, "<dev string:x28b>" + str_zone_names, ( 0, 1, 0 ), 1, 0.25 );
                print3d( v_position - var_344c87cda146b92c * 4, "<dev string:x29c>" + ( s_doorbuy.script_power ?? "<dev string:x278>" ), ( 0, 1, 0 ), 1, 0.25 );
                
                if ( s_doorbuy.interact.var_c3520c71cf883b16 )
                {
                    var_b7fb3f7044fdbed2 = "<dev string:x2a9>";
                    var_d876b0c0fe4d6eba = "<dev string:x278>";
                }
                else
                {
                    var_b7fb3f7044fdbed2 = "<dev string:x2b1>";
                    var_d876b0c0fe4d6eba = "<dev string:x2b8>" + var_d876b0c0fe4d6eba + "<dev string:x2bf>";
                }
                
                print3d( v_position - var_344c87cda146b92c * 5, "<dev string:x2c1>" + var_b7fb3f7044fdbed2 + var_d876b0c0fe4d6eba, ( 0, 1, 0 ), 1, 0.25 );
                
                if ( isarray( s_doorbuy.interact.doors ) )
                {
                    s_doorbuy.interact.doors = function_5713d46873b29625( s_doorbuy.interact.doors );
                    
                    foreach ( door in s_doorbuy.interact.doors )
                    {
                        line( v_position, door.origin, ( 0, 0, 1 ) );
                        sphere( door.origin, 10, ( 0, 0, 1 ) );
                        
                        if ( door isscriptable() )
                        {
                            print3d( door.origin, "<dev string:x2d3>", ( 0, 1, 0 ), 1, 0.25 );
                            continue;
                        }
                        
                        print3d( door.origin, "<dev string:x2e9>", ( 0, 1, 0 ), 1, 0.25 );
                    }
                }
            }
            
            waitframe();
        }
    }

#/
