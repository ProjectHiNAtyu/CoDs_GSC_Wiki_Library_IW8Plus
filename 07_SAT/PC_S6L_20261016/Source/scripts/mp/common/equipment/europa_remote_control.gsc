// scripts\mp\common\equipment\europa_remote_control.gsc  (hash_07438420158a6c44.gscc) (size: 8127 Bytes / 0x1fbf / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x374fdf8 (57998840)
// size ...... 8127 (0x1fbf)
// includes .. 8   (offset: 0x1d5b)
// strings ... 26  (offset: 0x1d9b)
// dev strs .. 9   (offset: 0x1f53)
// exports ... 25  (offset: 0xfef)
// cseg ...... 0x299 + 0xd56 (0xfef)
// imports ... 83  (offset: 0x13d7)
// animtree1 . 0   (offset: 0x1fbf)
// animtree2 . 0   (offset: 0x1fbf)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scripted_widgets;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\mp\equipment;
#using scripts\mp\loot\common_item;
#using scripts\mp\weapons;

#namespace europa_remote_control;

// Namespace europa_remote_control
// Params 0, eflags: 0x1
// Checksum 0x20b57f44, Offset: 0x2b7
// Size: 0xca
function autoexec function_10205b1754d2678e()
{
    utility::flag_wait( "equipment_initialized" );
    weapons::function_2cd25260a11d5e40( "europa_remote_control", &function_8274f78221c9f47f );
    weapons::registerusedcallback( "europa_remote_control", &function_6b0ec82345009bca );
    callback::add( #"hash_8e420a8ff3313166", &function_36d7c55c5da90ebd );
    callback::add( #"europa_deactivated", &function_361a430fe6f72ad );
    equipment_mp::function_2e4e9b7492b36578( "equip_europa_remote_control" );
    utility::registersharedfunc( #"crafting_table", #"hash_a55f67deb6de0476", &function_e093d4b4011b4deb );
    utility::registersharedfunc( #"europa", #"hash_c7ca27e86991f1a7", &function_9cfb2570d3ffbe03 );
    utility::registersharedfunc( #"europa", #"hash_461d60a67b99be95", &function_3e92469a1fe78459 );
    
    /#
        devgui_init();
    #/
}

// Namespace europa_remote_control
// Params 1, eflags: 0x4
// Checksum 0xace89c88, Offset: 0x389
// Size: 0x32
function private function_36d7c55c5da90ebd( params )
{
    owner = params.owner;
    
    if ( isdefined( owner ) )
    {
        owner function_9cfb2570d3ffbe03();
    }
}

// Namespace europa_remote_control
// Params 1, eflags: 0x4
// Checksum 0x38964900, Offset: 0x3c3
// Size: 0x32
function private function_361a430fe6f72ad( params )
{
    owner = params.owner;
    
    if ( isdefined( owner ) )
    {
        owner function_3e92469a1fe78459();
    }
}

// Namespace europa_remote_control
// Params 4, eflags: 0x4
// Checksum 0xeca6a569, Offset: 0x3fd
// Size: 0x58
function private function_3e049f836185a4b7( itembundle, item, autouse, allowswap )
{
    if ( equipment_mp::hasequipment( "equip_europa_remote_control" ) )
    {
        return 0;
    }
    
    if ( level.var_3b3377d2d3978a1f )
    {
        return self [[ level.var_3b3377d2d3978a1f ]]( itembundle, item, autouse, allowswap );
    }
    
    return 1;
}

// Namespace europa_remote_control
// Params 4, eflags: 0x4
// Checksum 0xcd93e9ab, Offset: 0x45e
// Size: 0x6a
function private function_1f1c593e5efd20a2( itembundle, item, autouse, allowswap )
{
    if ( equipment_mp::hasequipment( "equip_europa_remote_control" ) && !itembundle.togroup == 0 )
    {
        return 0;
    }
    
    if ( level.var_3bcda43567ac2536 )
    {
        return self [[ level.var_3bcda43567ac2536 ]]( itembundle, item, autouse, allowswap );
    }
    
    return 1;
}

// Namespace europa_remote_control
// Params 0, eflags: 0x4
// Checksum 0x34659733, Offset: 0x4d1
// Size: 0x1c7
function private function_9cfb2570d3ffbe03()
{
    if ( isdefined( self.savedtactical ) || self.allyeuropa.europa.deactivating )
    {
        return;
    }
    
    level.var_3b3377d2d3978a1f = undefined;
    level.var_3bcda43567ac2536 = undefined;
    var_a94e36b8cd9ac8b8 = common_item::function_c6f3ef3dcb4c55c0( "tactical", #"hash_9e49dfaa7c147654" );
    var_4c2d4eb23a31322b = common_item::function_c6f3ef3dcb4c55c0( "tactical", #"caninteract" );
    
    if ( var_a94e36b8cd9ac8b8 && var_a94e36b8cd9ac8b8 != &function_3e049f836185a4b7 )
    {
        level.var_3b3377d2d3978a1f = var_a94e36b8cd9ac8b8;
    }
    
    if ( var_4c2d4eb23a31322b && var_4c2d4eb23a31322b != &function_1f1c593e5efd20a2 )
    {
        level.var_3bcda43567ac2536 = var_4c2d4eb23a31322b;
    }
    
    common_item::function_84174b793b5fe9a7( "tactical", #"hash_9e49dfaa7c147654", &function_3e049f836185a4b7 );
    common_item::function_84174b793b5fe9a7( "tactical", #"caninteract", &function_1f1c593e5efd20a2 );
    ref = equipment_mp::getcurrentequipment( "secondary" );
    currammo = equipment_mp::getequipmentammo( ref );
    self.savedtactical = spawnstruct();
    self.savedtactical.ref = ref;
    self.savedtactical.ammo = currammo;
    equipment_mp::takeequipment( "secondary" );
    equipment_mp::giveequipment( "equip_europa_remote_control", "secondary" );
    equipment_mp::setequipmentammo( "equip_europa_remote_control", equipment_mp::getequipmentmaxammo( "equip_europa_remote_control" ) );
    self setclientomnvar( "ui_equipment_is_using_europa_remote_control", 1 );
    
    if ( !self.pers[ "europa_remote_tutorial_message" ] )
    {
        thread show_hud_tutorial_message( &"shared_hintstrings/europa_remote", 3 );
        self.pers[ "europa_remote_tutorial_message" ] = 1;
    }
}

// Namespace europa_remote_control
// Params 2
// Checksum 0x36ff9e57, Offset: 0x6a0
// Size: 0xdd
function show_hud_tutorial_message( tutorial_message_text, message_duration )
{
    self notify( #"hash_9c33a27655c480b" );
    self endon( #"hash_9c33a27655c480b" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    
    if ( !scripted_widgets::is_active( "europa_remote_tutorial_message" ) )
    {
        scripted_widgets::create( "europa_remote_tutorial_message", "scripted_widget_ww_tutorial_message_zm" );
    }
    
    scripted_widgets::set_position( "europa_remote_tutorial_message", 0, 0, 0, 0 );
    scripted_widgets::function_f15c5dfb6c0f57c7( "europa_remote_tutorial_message", "locstring_index", getlocstringindex( tutorial_message_text ) ?? 0 );
    scripted_widgets::set_state( "europa_remote_tutorial_message", "Show" );
    wait message_duration;
    
    if ( !self )
    {
        return;
    }
    
    scripted_widgets::set_state( "europa_remote_tutorial_message", "Hide" );
    wait 1;
    
    if ( self && scripted_widgets::is_active( "europa_remote_tutorial_message" ) )
    {
        scripted_widgets::destroy( "europa_remote_tutorial_message" );
    }
}

// Namespace europa_remote_control
// Params 0, eflags: 0x4
// Checksum 0x460ff2e2, Offset: 0x785
// Size: 0xf1
function private function_3e92469a1fe78459()
{
    if ( !isdefined( self.savedtactical ) )
    {
        return;
    }
    
    equipment_mp::takeequipment( "secondary" );
    common_item::function_84174b793b5fe9a7( "tactical", #"hash_9e49dfaa7c147654", level.var_3b3377d2d3978a1f );
    common_item::function_84174b793b5fe9a7( "tactical", #"caninteract", level.var_3bcda43567ac2536 );
    self setclientomnvar( "ui_equipment_is_using_europa_remote_control", 0 );
    
    if ( self.savedtactical.ref )
    {
        equipment_mp::giveequipment( self.savedtactical.ref, "secondary" );
        equipment_mp::setequipmentammo( self.savedtactical.ref, self.savedtactical.ammo );
    }
    
    level.var_3b3377d2d3978a1f = undefined;
    level.var_3bcda43567ac2536 = undefined;
    self.savedtactical = undefined;
    self notify( #"remote_control_taken" );
}

// Namespace europa_remote_control
// Params 1, eflags: 0x4
// Checksum 0x5040a479, Offset: 0x87e
// Size: 0x17
function private function_e093d4b4011b4deb( ref )
{
    return equipment_mp::hasequipment( "equip_europa_remote_control" );
}

// Namespace europa_remote_control
// Params 1
// Checksum 0xb1299544, Offset: 0x89e
// Size: 0x31
function function_8274f78221c9f47f( params )
{
    self notify( #"remote_control_pull_back" );
    thread function_9ff28589749a708a( params.weaponobject );
    thread function_684b478ef4e49028();
}

// Namespace europa_remote_control
// Params 2
// Checksum 0x3a3aacd8, Offset: 0x8d7
// Size: 0xa9
function function_6b0ec82345009bca( grenade, objweapon )
{
    if ( isdefined( grenade ) )
    {
        grenade delete();
    }
    
    goalpos = self.var_ed00a67f30ab2554;
    
    if ( isdefined( goalpos ) && function_98bf2d1e11b13b17() )
    {
        params = spawnstruct();
        params.owner = self;
        params.pos = goalpos;
        self.allyeuropa utility::callsharedfunc( #"europa", #"hash_5b8a88a5b8ddb5a8", params );
        self notify( #"remote_control_deployed" );
        thread function_c6dcb2d75f710dbc( goalpos );
    }
}

// Namespace europa_remote_control
// Params 0
// Checksum 0x34fff3ba, Offset: 0x988
// Size: 0x1b0
function function_f30e7c9a5045db72()
{
    if ( isdefined( self.allyeuropa ) )
    {
        trace_forward = anglestoforward( self getplayerangles() );
        trace_start = self getcamerathirdperson() ? self getcamerathirdpersonorigin() : self geteye();
        traceresult = trace::ray_trace( trace_start, trace_start + trace_forward * 10000 );
        
        if ( isdefined( traceresult[ "position" ] ) && traceresult[ "fraction" ] < 1 )
        {
            pos = traceresult[ "position" ];
            normal = traceresult[ "normal" ];
            dot = vectordot( normal, ( 0, 0, 1 ) );
            
            /#
                debug_draw = getdvarint( @"scr_europa_remote_debug_draw" );
                
                if ( debug_draw )
                {
                    sphere( pos, 5, ( 1, 0, 0 ), 0, 1 );
                    line( pos, pos + traceresult[ "<dev string:x24>" ] * 100, ( 1, 0, 0 ), 1, 0, 1 );
                }
            #/
            
            if ( function_98bf2d1e11b13b17() && function_803a09268502cd2b( pos ) && dot > 0 )
            {
                if ( !self.allyeuropa utility::callsharedfunc( #"europa", #"hash_aee90f7f15948896", pos ) )
                {
                    return;
                }
                
                closestpos = getclosestpointonnavmesh( pos );
                
                if ( distancesquared( pos, closestpos ) < 10000 )
                {
                    pos = closestpos;
                    
                    /#
                        if ( debug_draw )
                        {
                            sphere( pos, 5, ( 0, 1, 0 ), 0, 1 );
                        }
                    #/
                    
                    goalpos = drop_to_ground( pos );
                    return goalpos;
                }
            }
        }
    }
}

// Namespace europa_remote_control
// Params 1
// Checksum 0x260b0ca4, Offset: 0xb41
// Size: 0x35
function drop_to_ground( pos )
{
    height_offset = ( 0, 0, 1 );
    return utility::drop_to_ground( pos, 24, -300 ) + height_offset;
}

// Namespace europa_remote_control
// Params 1
// Checksum 0x47e58107, Offset: 0xb7f
// Size: 0x26
function function_803a09268502cd2b( goalpos )
{
    return utility::callsharedfunc( #"europa", #"hash_100c40785c43cd05", goalpos );
}

// Namespace europa_remote_control
// Params 0
// Checksum 0x993cf6dd, Offset: 0xbae
// Size: 0x5c, Type: bool
function function_98bf2d1e11b13b17()
{
    europa = self.allyeuropa;
    
    if ( !europa )
    {
        return false;
    }
    
    if ( utility::issharedfuncdefined( #"europa", #"hash_65ff4ac50413534" ) )
    {
        if ( !europa utility::callsharedfunc( #"europa", #"hash_65ff4ac50413534" ) )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace europa_remote_control
// Params 0
// Checksum 0xc79a9d21, Offset: 0xc13
// Size: 0x4b
function function_684b478ef4e49028()
{
    self notify( #"hash_2f9c316522ecf78" );
    self endon( #"hash_2f9c316522ecf78" );
    level endon( #"game_ended" );
    self endon( #"death" );
    
    while ( !self weaponswitchbuttonpressed() )
    {
        waitframe();
    }
    
    self notify( #"remote_control_not_in_hand" );
}

// Namespace europa_remote_control
// Params 1
// Checksum 0x3a5ac03d, Offset: 0xc66
// Size: 0xfb
function function_9ff28589749a708a( objweapon )
{
    self notify( #"hash_bbab425db38eb93" );
    self endon( #"hash_bbab425db38eb93" );
    level endon( #"game_ended" );
    self endon( #"death" );
    self endon( #"remote_control_deployed" );
    self endon( #"remote_control_pull_back" );
    self endon( #"remote_control_not_in_hand" );
    var_c16e8946d253c0ce = undefined;
    self.var_ed00a67f30ab2554 = undefined;
    
    while ( self isthrowinggrenade() )
    {
        goalpos = function_f30e7c9a5045db72();
        
        if ( isdefined( goalpos ) )
        {
            if ( !isdefined( var_c16e8946d253c0ce ) )
            {
                var_c16e8946d253c0ce = spawn( "script_model", goalpos );
                var_c16e8946d253c0ce setmodel( "c_sat_gear_europa_remote_control" );
                var_c16e8946d253c0ce setscriptablepartstate( "play_fx", "green" );
                thread function_a4861d4aa483d5bd( var_c16e8946d253c0ce );
            }
            else
            {
                var_c16e8946d253c0ce.origin = goalpos;
            }
            
            self.var_ed00a67f30ab2554 = goalpos;
        }
        
        waitframe();
    }
    
    self notify( #"remote_control_pull_back_canceled" );
}

// Namespace europa_remote_control
// Params 1
// Checksum 0xe2601c7b, Offset: 0xd69
// Size: 0x4a
function function_a4861d4aa483d5bd( var_c16e8946d253c0ce )
{
    var_c16e8946d253c0ce endon( #"death" );
    utility::waittill_any_return( "death_or_disconnect", "remote_control_taken", "remote_control_pull_back", "remote_control_deployed", "remote_control_pull_back_canceled", "remote_control_not_in_hand" );
    
    if ( var_c16e8946d253c0ce )
    {
        var_c16e8946d253c0ce delete();
    }
}

// Namespace europa_remote_control
// Params 1
// Checksum 0x58654a07, Offset: 0xdbb
// Size: 0xa0
function function_c6dcb2d75f710dbc( goalpos )
{
    commandid = self.allyeuropa.europa.command_id;
    fx_ent_goal = spawn( "script_model", goalpos );
    fx_ent_goal setmodel( "c_sat_gear_europa_remote_control" );
    fx_ent_goal setscriptablepartstate( "play_fx", "blue" );
    notifications = [ "death_or_disconnect", "remote_control_taken", "europa_remove_defend_mark_" + commandid ];
    utility::waittill_any_in_array( notifications );
    fx_ent_goal delete();
}

/#

    // Namespace europa_remote_control
    // Params 0
    // Checksum 0x7ff27c1c, Offset: 0xe63
    // Size: 0x9c, Type: dev
    function dev_get_player()
    {
        if ( isdefined( level.player ) )
        {
            return level.player;
        }
        
        foreach ( player in level.players )
        {
            if ( isalive( player ) )
            {
                return player;
            }
        }
        
        return;
    }

    // Namespace europa_remote_control
    // Params 0
    // Checksum 0x1942e465, Offset: 0xf07
    // Size: 0x5c, Type: dev
    function devgui_init()
    {
        devgui::function_9082edeb5db93280( "<dev string:x2b>" );
        devgui::add_devgui_func( "<dev string:x3c>", "<dev string:x5d>", &function_15732d467b7b6ace );
        devgui::add_devgui_func( "<dev string:x76>", "<dev string:x99>", &function_57f23679a8494261 );
        devgui::add_devgui_func( "<dev string:xb4>", "<dev string:xd0>", &function_bdf752c3da2b0a07, 1 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace europa_remote_control
    // Params 0
    // Checksum 0xc4bf8f9, Offset: 0xf6b
    // Size: 0x2d, Type: dev
    function function_15732d467b7b6ace()
    {
        if ( isdefined( level.europa ) )
        {
            player = dev_get_player();
            player function_9cfb2570d3ffbe03();
        }
    }

    // Namespace europa_remote_control
    // Params 0
    // Checksum 0xcf2a0ad5, Offset: 0xfa0
    // Size: 0x2d, Type: dev
    function function_57f23679a8494261()
    {
        if ( isdefined( level.europa ) )
        {
            player = dev_get_player();
            player function_3e92469a1fe78459();
        }
    }

    // Namespace europa_remote_control
    // Params 0
    // Checksum 0x5a3c5f55, Offset: 0xfd5
    // Size: 0x1a, Type: dev
    function function_bdf752c3da2b0a07()
    {
        devgui::function_3f8a26ec96988e80( "<dev string:xf0>", @"scr_europa_remote_debug_draw" );
    }

#/
