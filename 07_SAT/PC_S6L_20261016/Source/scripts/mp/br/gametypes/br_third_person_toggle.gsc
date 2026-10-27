// scripts\mp\br\gametypes\br_third_person_toggle.gsc  (hash_305f0b63d23a7816.gscc) (size: 3598 Bytes / 0xe0e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xef271fe8 (4012318696)
// size ...... 3598 (0xe0e)
// includes .. 6   (offset: 0xc9e)
// strings ... 23  (offset: 0xcce)
// dev strs .. 1   (offset: 0xe02)
// exports ... 9   (offset: 0x736)
// cseg ...... 0x207 + 0x52f (0x736)
// imports ... 35  (offset: 0x89e)
// animtree1 . 0   (offset: 0xe0e)
// animtree2 . 0   (offset: 0xe0e)
#using scripts\common\callbacks;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\mp\common\utility\connect_event_aggregator;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\operator;

#namespace br_third_person_toggle;

// Namespace br_third_person_toggle
// Params 0, eflags: 0x1
// Checksum 0xfb942323, Offset: 0x225
// Size: 0x58
function autoexec function_45b639930fc7be78()
{
    if ( !level.gametypebundle.var_ef8b60468f8f3d13 )
    {
        return;
    }
    
    level.var_c57ff57d8b66d391 = 1;
    connect_event_aggregator::registeronconnectcallback( &function_f920fea48ca9cec3 );
    callback::add( #"player_spawned", &function_f211ce0104d7ece2 );
    level ui::lui_registercallback( "toggle_camera_view", &function_cc2b9d82ff228048 );
}

// Namespace br_third_person_toggle
// Params 0, eflags: 0x4
// Checksum 0x38abcd04, Offset: 0x285
// Size: 0x4e
function private function_f920fea48ca9cec3()
{
    self endon( #"disconnect" );
    
    if ( !isbot( self ) )
    {
        self notifyonplayercommand( "third_person_down_press", "+actionslot 2" );
        self notifyonplayercommand( "third_person_down_release", "-actionslot 2" );
        self notifyonplayercommand( "third_person_toggle", "third_person_toggle" );
    }
    
    thread function_5b4c404324c53c39();
}

// Namespace br_third_person_toggle
// Params 1, eflags: 0x4
// Checksum 0x77b6b841, Offset: 0x2db
// Size: 0x3b
function private function_f211ce0104d7ece2( params )
{
    var_2f074dacf1c6f38f = self getclientomnvar( "ui_toggle_third_person" );
    
    if ( var_2f074dacf1c6f38f )
    {
        thirdpersontoggle( 1 );
        return;
    }
    
    thirdpersontoggle( 0 );
}

// Namespace br_third_person_toggle
// Params 1, eflags: 0x4
// Checksum 0xbb4b6e62, Offset: 0x31e
// Size: 0x13
function private function_cc2b9d82ff228048( value )
{
    thirdpersontoggle();
}

// Namespace br_third_person_toggle
// Params 0, eflags: 0x4
// Checksum 0xd18fa927, Offset: 0x339
// Size: 0x12b
function private function_5b4c404324c53c39()
{
    self endon( #"disconnect" );
    var_3cb45f3e8fffbb05 = 0;
    hold_button_time = 500;
    var_2e7980c6e49ab862 = hold_button_time / 1000;
    value = undefined;
    
    while ( true )
    {
        if ( var_3cb45f3e8fffbb05 == 0 )
        {
            value = utility::waittill_any_return( "third_person_down_press", "third_person_down_release", "third_person_toggle" );
        }
        else
        {
            value = utility::waittill_any_timeout( var_2e7980c6e49ab862, "third_person_down_release" );
        }
        
        if ( !isalive( self ) || !isdefined( value ) )
        {
            continue;
        }
        
        var_f1a4fb89f4d20731 = 0;
        
        if ( value == "third_person_down_release" )
        {
            var_3cb45f3e8fffbb05 = 0;
        }
        else if ( value == "timeout" )
        {
            if ( isdefined( self.var_bdfee86a924703e2 ) && gettime() - self.var_bdfee86a924703e2 <= hold_button_time )
            {
                var_f1a4fb89f4d20731 = 0;
            }
            else if ( self getclientomnvar( "loot_container_open" ) != 0 )
            {
                var_f1a4fb89f4d20731 = 0;
            }
            else
            {
                var_f1a4fb89f4d20731 = 1;
            }
            
            var_3cb45f3e8fffbb05 = 0;
        }
        else if ( value == "third_person_toggle" )
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
            thirdpersontoggle();
        }
    }
}

// Namespace br_third_person_toggle
// Params 1, eflags: 0x4
// Checksum 0x966f5684, Offset: 0x46c
// Size: 0x91
function private thirdpersontoggle( override )
{
    if ( !isplayer( self ) )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    if ( !function_df9891e65ed5dc6c() )
    {
        return;
    }
    
    if ( isalive( self ) && !self isvehicleactive() && !self.disable_third_person_toggle )
    {
        var_4e696c1264ef4e4a = self getcamerathirdperson();
        
        if ( isdefined( override ) )
        {
            var_4e696c1264ef4e4a = !override;
        }
        
        self setcamerathirdperson( !var_4e696c1264ef4e4a );
        self setclientomnvar( "ui_toggle_third_person", !var_4e696c1264ef4e4a );
        
        if ( !isdefined( override ) )
        {
            thirdpersonanalytics( var_4e696c1264ef4e4a );
        }
    }
}

// Namespace br_third_person_toggle
// Params 0, eflags: 0x4
// Checksum 0xb4045ac4, Offset: 0x505
// Size: 0x36, Type: bool
function private function_df9891e65ed5dc6c()
{
    player = self;
    
    if ( player.disable_third_person_toggle )
    {
        return false;
    }
    
    if ( player isinexecutionattack() || player isinexecutionvictim() )
    {
        return false;
    }
    
    return true;
}

// Namespace br_third_person_toggle
// Params 1, eflags: 0x4
// Checksum 0xfd47e480, Offset: 0x544
// Size: 0x1f2
function private thirdpersonanalytics( var_4e696c1264ef4e4a )
{
    player = self;
    
    if ( !isdefined( player.var_593e0290995d195e ) )
    {
        player.var_593e0290995d195e = int( gettime() / 1000 );
    }
    else
    {
        player.var_593e0290995d195e = int( gettime() / 1000 ) - player.var_593e0290995d195e;
    }
    
    circleindex = -1;
    
    if ( isdefined( level.br_circle ) && isdefined( level.br_circle.circleindex ) )
    {
        circleindex = level.br_circle.circleindex;
    }
    
    operatorref = player operator::getoperatorref() ?? %"";
    operatorskin = player operator::function_cc5d60d5178c5007() ?? %"";
    params = [ "player_xuid", player getxuid(), "team", player.team, "player_entity_num", player getentitynumber(), "playlist_id", getplaylistid(), "playlist_name", getplaylistname(), "game_type", game_utility::getgametype(), "sub_game_type", game_utility::getgametype(), "circle_index", circleindex, "third_person", var_4e696c1264ef4e4a, "since_last_toggle", player.var_593e0290995d195e, "map", level.mapname, "operator_ref", operatorref, "operator_skin", operatorskin ];
    player dlog_recordplayerevent( "dlog_event_br_third_person_toggle", params );
}

