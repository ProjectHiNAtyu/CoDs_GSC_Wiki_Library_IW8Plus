// script_2f94849b5aff8f5a  (hash_2f94849b5aff8f5a.gscc) (size: 4734 Bytes / 0x127e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfbc9f614 (4224316948)
// size ...... 4734 (0x127e)
// includes .. 5   (offset: 0x1186)
// strings ... 15  (offset: 0x11ae)
// dev strs .. 0   (offset: 0x127e)
// exports ... 10  (offset: 0xd2a)
// cseg ...... 0x1a4 + 0xb86 (0xd2a)
// imports ... 23  (offset: 0xeba)
// animtree1 . 0   (offset: 0x127e)
// animtree2 . 0   (offset: 0x127e)
#using script_2c8ce58377654932;
#using script_33cd8a7250381109;
#using scripts\mp\common\utility\trigger;
#using scripts\mp\gametypes\skirmish_util;
#using scripts\mp\hud_message;

#namespace namespace_a0bf8ee672af8086;

// Namespace namespace_a0bf8ee672af8086
// Params 8
// Checksum 0x4c70751c, Offset: 0x1c2
// Size: 0x14a
function function_cda6f4dac114bdbd( activitytype, activityname, activitylocation, activityshow, activityhide, activityfocus, activityobject, activityzone )
{
    self endon( #"game_ended" );
    self waittill( #"activity_unlocked" );
    activitytrigger = spawn( "trigger_radius", activitylocation + ( 0, 0, level.var_fd5a14340d3320e9 * -1 ), 0, level.var_fd5a14340d3320e9, level.var_fd5a14340d3320e9 * 2 );
    trigger::makeenterexittrigger( activitytrigger, &function_f75f61241bfdf2a7, &function_2d48344bae366b03 );
    activitytrigger.activitytype = activitytype;
    activitytrigger.activityname = activityname;
    activitytrigger.activityfocus = activityfocus;
    activitytrigger.activityshow = activityshow;
    activitytrigger.activityhide = activityhide;
    activitytrigger.activityobject = activityobject;
    
    if ( activitytype == #"secure" )
    {
        activitytrigger enablelinkto();
        activitytrigger linkto( activityobject );
    }
    
    level.var_85b177faa9935b2a.running[ activitytype ][ activityname ].activitytrigger = activitytrigger;
}

// Namespace namespace_a0bf8ee672af8086
// Params 1, eflags: 0x4
// Checksum 0xa43faa65, Offset: 0x314
// Size: 0x8d
function private function_471f1fdff7d8eb7f( activityobject )
{
    self.var_b34a3f453cfe9ffe = activityobject;
    
    if ( !isdefined( self.var_2c4f16e89cedf224 ) )
    {
        self.var_2c4f16e89cedf224 = [];
    }
    
    self.var_2c4f16e89cedf224[ self.var_2c4f16e89cedf224.size ] = activityobject.objidnum;
    self setclientomnvar( "ui_focused_objective_index", self.var_2c4f16e89cedf224[ 0 ] );
    
    if ( activityobject.activitytype == #"secure" )
    {
        self.var_1deff603af6f44b2 = activityobject;
        thread function_16aa1e0f34495129();
    }
}

// Namespace namespace_a0bf8ee672af8086
// Params 0, eflags: 0x4
// Checksum 0x18cc36aa, Offset: 0x3a9
// Size: 0xe1
function private function_16aa1e0f34495129()
{
    level endon( #"disconnect" );
    level endon( #"game_ended" );
    self endon( #"hash_e05b1b6558d36625" );
    
    while ( self.var_1deff603af6f44b2 )
    {
        scoremult = skirmish_util::function_afc407a06438534e( self.var_1deff603af6f44b2 ) ? 2 : 1;
        self setclientomnvar( "ui_skr_transmit_nearby_transmit_progress_friendly", self.var_1deff603af6f44b2.teamprogress[ self.team ] / 20 * scoremult );
        self setclientomnvar( "ui_skr_transmit_nearby_transmit_progress_enemy", ( self.team == "axis" ? self.var_1deff603af6f44b2.teamprogress[ "allies" ] : self.var_1deff603af6f44b2.teamprogress[ "axis" ] ) / 20 * scoremult );
        waitframe();
    }
}

// Namespace namespace_a0bf8ee672af8086
// Params 0
// Checksum 0x6115d64a, Offset: 0x492
// Size: 0x19
function function_b6c6158306afa9d8()
{
    self.var_2c4f16e89cedf224 = [];
    self setclientomnvar( "ui_focused_objective_index", -1 );
}

// Namespace namespace_a0bf8ee672af8086
// Params 1
// Checksum 0x523ae733, Offset: 0x4b3
// Size: 0x9a
function function_edfaa54bcb41517d( focusedobj )
{
    self.var_b34a3f453cfe9ffe = undefined;
    self.var_2c4f16e89cedf224 = arrayremove( self.var_2c4f16e89cedf224, focusedobj.objidnum );
    
    if ( self.var_2c4f16e89cedf224.size != 0 )
    {
        self setclientomnvar( "ui_focused_objective_index", self.var_2c4f16e89cedf224[ 0 ] );
    }
    else
    {
        self setclientomnvar( "ui_focused_objective_index", -1 );
    }
    
    if ( focusedobj.activitytype == #"secure" )
    {
        self notify( #"hash_e05b1b6558d36625" );
        self.var_1deff603af6f44b2 = undefined;
    }
}

// Namespace namespace_a0bf8ee672af8086
// Params 1, eflags: 0x4
// Checksum 0x243100ad, Offset: 0x555
// Size: 0x49
function private function_e8b6a4bc3e20b809( trigger )
{
    function_471f1fdff7d8eb7f( trigger.activityobject );
    
    if ( trigger.activitytype == #"secure" )
    {
        trigger.activityobject namespace_e965e5c30872dcae::function_868bd071bd89616( self );
    }
}

// Namespace namespace_a0bf8ee672af8086
// Params 2, eflags: 0x4
// Checksum 0x45485e00, Offset: 0x5a6
// Size: 0x22c
function private function_f75f61241bfdf2a7( player, trigger )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( skirmish_util::function_afc407a06438534e( trigger ) )
    {
        namespace_ccc9a50b2d185e5::function_75e6074c25cd3167( player, trigger );
    }
    
    foreach ( activitytype in level.var_85b177faa9935b2a.running )
    {
        foreach ( objective in activitytype )
        {
            if ( isdefined( objective.activitytrigger ) && objective.activitytrigger != trigger )
            {
                [[ objective.activitytrigger.activityhide ]]( objective.activitytrigger.activityobject, player );
            }
        }
    }
    
    if ( player.classname == "script_vehicle" )
    {
        player.inactivityzone = 1;
        
        if ( isdefined( player.occupants ) )
        {
            foreach ( passenger in player.occupants )
            {
                passenger function_e8b6a4bc3e20b809( trigger );
                passenger.invehicle = player;
            }
        }
        
        return;
    }
    
    player function_e8b6a4bc3e20b809( trigger );
}

// Namespace namespace_a0bf8ee672af8086
// Params 2, eflags: 0x4
// Checksum 0xcccf538, Offset: 0x7da
// Size: 0x25a
function private function_2d48344bae366b03( player, trigger )
{
    if ( !isplayer( player ) )
    {
        return;
    }
    
    if ( skirmish_util::function_afc407a06438534e( trigger ) )
    {
        namespace_ccc9a50b2d185e5::function_e6efed248e069b22( player, trigger );
    }
    
    foreach ( activitytype in level.var_85b177faa9935b2a.running )
    {
        foreach ( objective in activitytype )
        {
            if ( isdefined( objective.activitytrigger ) && objective.activitytrigger != trigger )
            {
                [[ objective.activitytrigger.activityshow ]]( objective.activitytrigger.activityobject, player );
            }
        }
    }
    
    if ( player.classname == "script_vehicle" )
    {
        player.inactivityzone = 0;
        
        if ( isdefined( player.occupants ) )
        {
            foreach ( passenger in player.occupants )
            {
                passenger function_edfaa54bcb41517d( trigger.activityobject );
            }
        }
        
        return;
    }
    
    if ( !( isdefined( player.invehicle ) && player.invehicle.inactivityzone ) )
    {
        player function_edfaa54bcb41517d( trigger.activityobject );
    }
}

// Namespace namespace_a0bf8ee672af8086
// Params 3
// Checksum 0x7eeca2ed, Offset: 0xa3c
// Size: 0x2ee
function function_b119ccd8bdd22fa5( activitytype, activityname, winningteam )
{
    var_84d2fdc51186038e = "dom";
    
    if ( activitytype == #"destroy" )
    {
        var_84d2fdc51186038e = "destroy";
    }
    else if ( activitytype == #"secure" )
    {
        var_84d2fdc51186038e = "secure";
    }
    
    if ( isdefined( level.var_85b177faa9935b2a.running[ activitytype ][ activityname ].activitytrigger ) )
    {
        activitytrigger = level.var_85b177faa9935b2a.running[ activitytype ][ activityname ].activitytrigger;
        
        foreach ( ent in activitytrigger.triggerenterents )
        {
            if ( isdefined( ent ) )
            {
                if ( isplayer( ent ) )
                {
                    actualscore = undefined;
                    
                    if ( activitytype == #"secure" )
                    {
                        secureinstance = level.var_85b177faa9935b2a.running[ activitytype ][ activityname ].activityobject;
                        var_b9b74b48fa884c8f = secureinstance.var_98a051b80739a41e;
                        var_b8ef9992ea47b27 = 0;
                        
                        if ( secureinstance.teamprogress && secureinstance.teamprogress[ ent.team ] )
                        {
                            actualscore = secureinstance.teamprogress[ ent.team ];
                            var_b8ef9992ea47b27 = 1;
                        }
                        
                        var_259d6175ec2b7ffb = !var_b8ef9992ea47b27;
                    }
                    else
                    {
                        var_b8ef9992ea47b27 = ent.team == winningteam;
                        var_259d6175ec2b7ffb = !var_b8ef9992ea47b27;
                        var_b9b74b48fa884c8f = var_b8ef9992ea47b27 && ent.var_bf516d5ed5a5050d == 1;
                    }
                    
                    if ( var_b8ef9992ea47b27 )
                    {
                        if ( var_b9b74b48fa884c8f )
                        {
                            ent hud_message::function_78fedf6f526825f4( "skirmish_objective_" + var_84d2fdc51186038e + "_heat_completed", level.gametypebundle.var_e662dd7f27d462eb, actualscore );
                        }
                        else
                        {
                            ent hud_message::function_78fedf6f526825f4( "skirmish_objective_" + var_84d2fdc51186038e + "_completed", level.gametypebundle.var_e662dd7f27d462eb, actualscore );
                        }
                    }
                    else if ( var_259d6175ec2b7ffb )
                    {
                        ent playsoundtoplayer( "uin_sat_skirmish_objective_complete_by_enemies", ent );
                        ent hud_message::function_78fedf6f526825f4( "skirmish_objective_" + var_84d2fdc51186038e + "_failed", level.gametypebundle.var_e662dd7f27d462eb );
                    }
                }
                
                function_2d48344bae366b03( ent, activitytrigger );
            }
        }
        
        activitytrigger delete();
        level.var_85b177faa9935b2a.running[ activitytype ][ activityname ].activitytrigger = undefined;
    }
}

