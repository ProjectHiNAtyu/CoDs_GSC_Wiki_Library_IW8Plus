// script_5bcddb9b3157c08c  (hash_5bcddb9b3157c08c.gscc) (size: 1232 Bytes / 0x4d0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x71dc6942 (1910270274)
// size ...... 1232 (0x4d0)
// includes .. 1   (offset: 0x47c)
// strings ... 2   (offset: 0x484)
// dev strs .. 3   (offset: 0x4a8)
// exports ... 4   (offset: 0x2f4)
// cseg ...... 0xa6 + 0x24e (0x2f4)
// imports ... 7   (offset: 0x394)
// animtree1 . 0   (offset: 0x4d0)
// animtree2 . 0   (offset: 0x4d0)
#using scripts\common\utility;

#namespace namespace_9bde28f6fb0d35d1;

// Namespace namespace_9bde28f6fb0d35d1
// Params 4
// Checksum 0x6dde8a2e, Offset: 0xc4
// Size: 0xfd
function function_faf7ed88035696ef( var_5e9f79c4da501125, boost_duration, var_8114f7a539248a1, end_notify )
{
    self endon( end_notify );
    self endon( #"death_or_disconnect" );
    assert( var_5e9f79c4da501125, "<dev string:x24>" );
    assert( boost_duration > 0, "<dev string:x41>" );
    assert( var_8114f7a539248a1 > 0, "<dev string:x68>" );
    
    if ( self.var_3b2945185cdb3574 && self.var_3b2945185cdb3574 != var_5e9f79c4da501125 )
    {
        return;
    }
    
    self.var_3b2945185cdb3574 = var_5e9f79c4da501125;
    skill_index = utility::callsharedfunc( #"skills", #"hash_6dc9835d47a52b35", var_5e9f79c4da501125 ) + 1;
    self setclientomnvar( "ui_skill_boost_active_skill_index", skill_index );
    percentage_boost = min( boost_duration / var_8114f7a539248a1, 1 );
    self setclientomnvar( "ui_skill_boost_active_fill_percentage", percentage_boost );
    thread function_93236e3c1438aa71( "ui_skill_boost_active_fill_percentage", boost_duration, var_8114f7a539248a1, end_notify, var_5e9f79c4da501125 );
}

// Namespace namespace_9bde28f6fb0d35d1
// Params 1
// Checksum 0x435e5242, Offset: 0x1c9
// Size: 0x53
function function_4d56ceca482a18bb( var_5e9f79c4da501125 )
{
    assert( var_5e9f79c4da501125, "<dev string:x24>" );
    
    if ( var_5e9f79c4da501125 && self.var_3b2945185cdb3574 != var_5e9f79c4da501125 )
    {
        return;
    }
    
    self setclientomnvar( "ui_skill_boost_active_fill_percentage", 0 );
    self setclientomnvar( "ui_skill_boost_active_skill_index", 0 );
    self.var_3b2945185cdb3574 = undefined;
}

// Namespace namespace_9bde28f6fb0d35d1
// Params 5, eflags: 0xc
// Checksum 0x21661, Offset: 0x224
// Size: 0xd0
function private function_93236e3c1438aa71( progress_omnvar, boost_duration, var_8114f7a539248a1, end_notify, skill_name )
{
    self notify( #"hash_ded01897b659c53e" );
    self endon( #"hash_ded01897b659c53e" );
    self endon( end_notify );
    self endon( #"death_or_disconnect" );
    boost_duration_ms = boost_duration * 1000;
    max_duration_ms = var_8114f7a539248a1 * 1000;
    end_time = gettime() + boost_duration_ms;
    
    while ( gettime() < end_time )
    {
        remaining_ms = end_time - gettime();
        progress = remaining_ms / max_duration_ms;
        self setclientomnvar( progress_omnvar, progress );
        wait 0.05;
    }
    
    function_4d56ceca482a18bb( skill_name );
}

