// scripts\mp\zm\systems\zm_third_person.gsc  (hash_7f94434cc7f04b54.gscc) (size: 2412 Bytes / 0x96c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd1f098f6 (3522205942)
// size ...... 2412 (0x96c)
// includes .. 3   (offset: 0x894)
// strings ... 12  (offset: 0x8ac)
// dev strs .. 1   (offset: 0x960)
// exports ... 8   (offset: 0x460)
// cseg ...... 0x12c + 0x334 (0x460)
// imports ... 26  (offset: 0x5a0)
// animtree1 . 0   (offset: 0x96c)
// animtree2 . 0   (offset: 0x96c)
#using scripts\common\callbacks;
#using scripts\common\ui;
#using scripts\common\utility;

#namespace zm_third_person;

// Namespace zm_third_person
// Params 0, eflags: 0x1
// Checksum 0x601a8cbf, Offset: 0x14a
// Size: 0x5e
function autoexec init()
{
    if ( getdvarint( @"zm_third_person", 1 ) == 0 )
    {
        return;
    }
    
    level ui::lui_registercallback( "toggle_camera_view", &switch_camera_view );
    callback::add( #"player_spawned", &function_8f0941e4910c2d09 );
    level.var_c57ff57d8b66d391 = 1;
    callback::add( #"player_connect", &function_1c077eb1ecd1777e );
}

// Namespace zm_third_person
// Params 1, eflags: 0x4
// Checksum 0x8e21565, Offset: 0x1b0
// Size: 0x13
function private function_1c077eb1ecd1777e( params )
{
    thread watch_third_person();
}

// Namespace zm_third_person
// Params 0, eflags: 0x4
// Checksum 0x233bb262, Offset: 0x1cb
// Size: 0x49
function private watch_third_person()
{
    thread function_8f0941e4910c2d09();
    
    if ( !isbot( self ) )
    {
        self notifyonplayercommand( "zm_down_press", "+actionslot 2" );
        self notifyonplayercommand( "zm_down_release", "-actionslot 2" );
        self notifyonplayercommand( "zm_down_toggle", "third_person_toggle" );
    }
    
    thread function_947ad0e23995cada();
}

// Namespace zm_third_person
// Params 0, eflags: 0x4
// Checksum 0x47823d, Offset: 0x21c
// Size: 0x11a
function private function_947ad0e23995cada()
{
    self endon( #"disconnect" );
    var_3cb45f3e8fffbb05 = 0;
    hold_button_time = 500;
    var_2e7980c6e49ab862 = hold_button_time / 1000;
    var_d3081cc8b026a873 = 1000;
    value = undefined;
    
    while ( true )
    {
        if ( var_3cb45f3e8fffbb05 == 0 )
        {
            value = utility::waittill_any_return( "zm_down_press", "zm_down_release", "zm_down_toggle" );
        }
        else
        {
            value = utility::waittill_any_timeout( var_2e7980c6e49ab862, "zm_down_release" );
        }
        
        if ( !isalive( self ) || !isdefined( value ) )
        {
            continue;
        }
        
        if ( isdefined( self.var_6eec07112ad043b8 ) && gettime() < self.var_6eec07112ad043b8 + var_d3081cc8b026a873 )
        {
            var_3cb45f3e8fffbb05 = 0;
            continue;
        }
        
        var_f1a4fb89f4d20731 = 0;
        
        if ( value == "zm_down_release" )
        {
            var_3cb45f3e8fffbb05 = 0;
        }
        else if ( value == "timeout" || value == "zm_down_toggle" )
        {
            var_f1a4fb89f4d20731 = 1;
            var_3cb45f3e8fffbb05 = 0;
        }
        else if ( var_3cb45f3e8fffbb05 == 0 )
        {
            var_3cb45f3e8fffbb05 = gettime();
        }
        
        if ( var_f1a4fb89f4d20731 )
        {
            function_34c3c4b41d5d08ac();
        }
    }
}

// Namespace zm_third_person
// Params 1, eflags: 0x4
// Checksum 0xeb9c8ced, Offset: 0x33e
// Size: 0xb2
function private function_34c3c4b41d5d08ac( override )
{
    if ( !isplayer( self ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    if ( isdefined( self.var_7efe9d6a267112b9 ) )
    {
        return;
    }
    
    if ( isalive( self ) && !self isvehicleactive() && !self.disable_third_person_toggle && !self isemoteactive() )
    {
        var_4e696c1264ef4e4a = self getcamerathirdperson();
        
        if ( isdefined( override ) )
        {
            var_4e696c1264ef4e4a = !override;
        }
        
        self setcamerathirdperson( !var_4e696c1264ef4e4a );
        self setclientomnvar( "ui_toggle_third_person", !var_4e696c1264ef4e4a );
        self notify( #"hash_79c6d8e931c7139d" );
        self setplayerdata( "common", "mpProgression", "thirdPerson", !var_4e696c1264ef4e4a );
    }
}

// Namespace zm_third_person
// Params 1, eflags: 0x4
// Checksum 0x89e282a, Offset: 0x3f8
// Size: 0x4d
function private function_8f0941e4910c2d09( params )
{
    var_2f074dacf1c6f38f = self getplayerdata( "common", "mpProgression", "thirdPerson" );
    
    if ( !isdefined( var_2f074dacf1c6f38f ) )
    {
        return;
    }
    
    if ( var_2f074dacf1c6f38f )
    {
        function_34c3c4b41d5d08ac( 1 );
        return;
    }
    
    function_34c3c4b41d5d08ac( 0 );
}

// Namespace zm_third_person
// Params 1, eflags: 0x4
// Checksum 0x86b09e01, Offset: 0x44d
// Size: 0x13
function private switch_camera_view( entnum )
{
    function_34c3c4b41d5d08ac();
}

