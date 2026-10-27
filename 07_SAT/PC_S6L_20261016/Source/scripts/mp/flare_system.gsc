// scripts\mp\flare_system.gsc  (hash_2c4d02238ab7dde6.gscc) (size: 6643 Bytes / 0x19f3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x69cdb036 (1775087670)
// size ...... 6643 (0x19f3)
// includes .. 2   (offset: 0x1947)
// strings ... 5   (offset: 0x1957)
// dev strs .. 4   (offset: 0x19c3)
// exports ... 23  (offset: 0xfe7)
// cseg ...... 0xb8 + 0xf2f (0xfe7)
// imports ... 47  (offset: 0x137f)
// animtree1 . 0   (offset: 0x19f3)
// animtree2 . 0   (offset: 0x19f3)
#using scripts\common\utility;
#using scripts\mp\common\utility\killstreak_utility;

#namespace flare_system;

// Namespace flare_system
// Params 0, eflags: 0x1
// Checksum 0x4d529bec, Offset: 0xd6
// Size: 0xf2
function autoexec main()
{
    utility::registersharedfunc( #"flare_system", #"defender_init", &defender_init );
    utility::registersharedfunc( #"flare_system", #"hash_bb66c31dec02b91a", &function_c8e5791b1d17b773 );
    utility::registersharedfunc( #"flare_system", #"hash_c402efcb2b8bce33", &function_2147b3e064b6646e );
    utility::registersharedfunc( #"flare_system", #"attacker_fire_missile", &attacker_fire_missile );
    utility::registersharedfunc( #"flare_system", #"hash_1101719e6ff74ce", &function_66fd13f12a68fa71 );
    utility::registersharedfunc( #"flare_system", #"hash_aa84d9f6a2574574", &function_74bf52055c564baf );
    utility::registersharedfunc( #"flare_system", #"hash_58a53f4881a5cfa7", &function_411ad6c6c718aeea );
    utility::registersharedfunc( #"flare_system", #"hash_93285145eafb4db4", &function_fdbb7d1acba3bf49 );
}

// Namespace flare_system
// Params 7
// Checksum 0xc32a9fb1, Offset: 0x1d0
// Size: 0x16f
function defender_init( numflares, var_ab12a9a4eebfb9bc, var_2ab7104cd7df6e87, canlockon = 1, var_f737c7e70dd29b99, var_9455a1d404771ffc, var_38a19c2c30440ebe )
{
    assert( numflares >= 0, "<dev string:x24>" );
    assert( var_ab12a9a4eebfb9bc >= 0, "<dev string:x46>" );
    assert( var_2ab7104cd7df6e87 >= 0, "<dev string:x7c>" );
    self.flaresystem = {};
    self.flaresystem.incomingmissiles = [];
    self.flaresystem.lockingattackers = [];
    self.flaresystem.numflares = numflares;
    self.flaresystem.var_8fa187d5c8db09ff = var_ab12a9a4eebfb9bc * 1000;
    self.flaresystem.lockontimegraceperiod = var_2ab7104cd7df6e87 * 1000;
    self.flaresystem.var_bd957d1ed0892590 = self.flaresystem.var_8fa187d5c8db09ff * -1;
    self.flaresystem.var_9455a1d404771ffc = var_9455a1d404771ffc;
    self.flaresystem.var_38a19c2c30440ebe = var_38a19c2c30440ebe;
    function_411ad6c6c718aeea( canlockon );
    
    if ( !var_f737c7e70dd29b99 )
    {
        thread function_4a2907d5a476c5b3();
        thread _watch_owner_remote_control();
    }
}

// Namespace flare_system
// Params 0
// Checksum 0x96838740, Offset: 0x347
// Size: 0xda, Type: bool
function function_66fd13f12a68fa71()
{
    if ( !function_74bf52055c564baf() )
    {
        return false;
    }
    
    self.flaresystem.numflares -= 1;
    self.flaresystem.var_bd957d1ed0892590 = gettime();
    
    foreach ( missile in self.flaresystem.incomingmissiles )
    {
        missile.var_935a78de5fd11f63 = 1;
    }
    
    return true;
}

// Namespace flare_system
// Params 0
// Checksum 0xbb7067f6, Offset: 0x42a
// Size: 0x5e, Type: bool
function function_74bf52055c564baf()
{
    if ( !self.flaresystem )
    {
        return false;
    }
    
    if ( self.flaresystem.numflares <= 0 )
    {
        return false;
    }
    
    if ( gettime() - self.flaresystem.var_bd957d1ed0892590 < self.flaresystem.var_8fa187d5c8db09ff )
    {
        return false;
    }
    
    return true;
}

// Namespace flare_system
// Params 2, eflags: 0x4
// Checksum 0x872b6bf1, Offset: 0x491
// Size: 0xa2
function private _attacker_watch_death( attacker, target )
{
    attacker waittill( #"death" );
    
    if ( target.flaresystem )
    {
        if ( attacker )
        {
            target.flaresystem.lockingattackers[ attacker.entnum ?? utility::get_entity_number( attacker ) ] = undefined;
        }
        
        target.flaresystem.lockingattackers = utility::function_8391781ea0784541( target.flaresystem.lockingattackers, 1 );
        target notify( #"hash_f5f6e51c77f7726e" );
    }
}

// Namespace flare_system
// Params 1
// Checksum 0xcbea29b7, Offset: 0x53b
// Size: 0xea
function function_2147b3e064b6646e( target )
{
    if ( !( isdefined( target ) && isdefined( target.flaresystem ) ) )
    {
        return;
    }
    
    target.var_8fbeda1e21b4eff7 = gettime() + 100;
    num = self.entnum ?? utility::get_entity_number( self );
    
    if ( !target.flaresystem.lockingattackers[ num ] )
    {
        if ( target.flaresystem.var_9455a1d404771ffc )
        {
            target [[ target.flaresystem.var_9455a1d404771ffc ]]( { #attacker:self } );
        }
        
        target.flaresystem.lockingattackers[ num ] = self;
        level thread _attacker_watch_death( self, target );
        target notify( #"hash_f5f6e51c77f7726e" );
        target thread function_79817ecc7491b5c2( self );
    }
}

// Namespace flare_system
// Params 1, eflags: 0x4
// Checksum 0x4c1231fb, Offset: 0x62d
// Size: 0xa0
function private function_79817ecc7491b5c2( attacker )
{
    while ( true )
    {
        wait 0.1;
        
        if ( !self )
        {
            break;
        }
        
        if ( self.var_8fbeda1e21b4eff7 < gettime() )
        {
            if ( attacker )
            {
                self.flaresystem.lockingattackers[ attacker.entnum ?? utility::get_entity_number( attacker ) ] = undefined;
            }
            
            self.flaresystem.lockingattackers = utility::function_8391781ea0784541( self.flaresystem.lockingattackers, 1 );
            self notify( #"hash_f5f6e51c77f7726e" );
            break;
        }
    }
}

// Namespace flare_system
// Params 0, eflags: 0x4
// Checksum 0xfbfc5ef5, Offset: 0x6d5
// Size: 0x28b
function private function_5c6b6501d798569c()
{
    self endon( #"death", #"hash_8037fbace13ee354" );
    self.owner endon( #"disconnect" );
    target = self;
    targetowner = target.owner;
    bundle = killstreak_utility::function_f943c0602acdc2af( self.streakname );
    var_2f21424924f77505 = bundle.var_2de6ec9894dabde6 ?? "missile_incoming";
    var_5c8c674d3faf5260 = bundle.var_f68b92309b8fbad0 ?? "missile_locked";
    
    while ( true )
    {
        self waittill( #"hash_f5f6e51c77f7726e" );
        assert( target.owner == targetowner );
        
        if ( !target.flaresystem.canlockon || target.flaresystem.var_432f3791a903498c )
        {
            if ( targetowner )
            {
                targetowner function_47457b9ec007482e( "ui_veh_warning", 2, 1, 0 );
                targetowner function_47457b9ec007482e( "ui_veh_warning", 4, 1, 0 );
            }
            
            target _stop_alarm();
            continue;
        }
        
        target.flaresystem.incomingmissiles = function_f943bef551ff028c( target.flaresystem.incomingmissiles );
        
        if ( target.flaresystem.incomingmissiles.size > 0 )
        {
            if ( targetowner )
            {
                targetowner function_47457b9ec007482e( "ui_veh_warning", 4, 1, 1 );
                targetowner function_47457b9ec007482e( "ui_veh_warning", 2, 1, 0 );
            }
            
            target _play_alarm( var_2f21424924f77505 );
            continue;
        }
        else
        {
            if ( targetowner )
            {
                targetowner function_47457b9ec007482e( "ui_veh_warning", 4, 1, 0 );
            }
            
            target _stop_alarm();
        }
        
        if ( target.flaresystem.var_38a19c2c30440ebe )
        {
            target.flaresystem.lockingattackers = utility::function_8391781ea0784541( target.flaresystem.lockingattackers, 1 );
            
            if ( target.flaresystem.lockingattackers.size > 0 )
            {
                if ( targetowner )
                {
                    targetowner function_47457b9ec007482e( "ui_veh_warning", 2, 1, 1 );
                    targetowner function_47457b9ec007482e( "ui_veh_warning", 4, 1, 0 );
                }
                
                target _play_alarm( var_5c8c674d3faf5260 );
                continue;
            }
            
            if ( targetowner )
            {
                targetowner function_47457b9ec007482e( "ui_veh_warning", 2, 1, 0 );
            }
            
            target _stop_alarm();
        }
    }
}

// Namespace flare_system
// Params 1
// Checksum 0xd8eab7dd, Offset: 0x968
// Size: 0xbe
function function_c8e5791b1d17b773( target )
{
    if ( isarray( target ) )
    {
        assert( "<dev string:xbd>" );
        return #"lockon_failed";
    }
    
    if ( !target )
    {
        return #"lockon_failed";
    }
    
    if ( !target.flaresystem )
    {
        return #"lockon_success";
    }
    
    if ( !target.flaresystem.canlockon )
    {
        return #"lockon_failed";
    }
    
    if ( gettime() - target.flaresystem.var_bd957d1ed0892590 < target.flaresystem.lockontimegraceperiod )
    {
        return #"lockon_failed";
    }
    
    return #"lockon_success";
}

// Namespace flare_system
// Params 0, eflags: 0x4
// Checksum 0xc18484f5, Offset: 0xa2f
// Size: 0x63
function private _create_alarm()
{
    assert( !self.alarm_model );
    self.alarm_model = spawn( "script_origin", self.origin );
    self.alarm_model linkto( self );
    self.alarm_model hide();
    self.alarm_model showtoplayer( self.owner );
}

// Namespace flare_system
// Params 0, eflags: 0x4
// Checksum 0xe14473df, Offset: 0xa9a
// Size: 0x23
function private _delete_alarm()
{
    _stop_alarm();
    
    if ( self.alarm_model )
    {
        self.alarm_model delete();
    }
}

// Namespace flare_system
// Params 1, eflags: 0x4
// Checksum 0x56634581, Offset: 0xac5
// Size: 0x76
function private _play_alarm( soundname )
{
    if ( self.alarm_model )
    {
        if ( self.alarm_model.soundname != soundname )
        {
            self.alarm_model.soundname = soundname;
            self.alarm_model stoploopsound();
            self.alarm_model playloopsound( self.alarm_model.soundname );
        }
    }
}

// Namespace flare_system
// Params 0, eflags: 0x4
// Checksum 0x6ab162eb, Offset: 0xb43
// Size: 0x2f
function private _stop_alarm()
{
    if ( self.alarm_model )
    {
        self.alarm_model.soundname = undefined;
        self.alarm_model stoploopsound();
    }
}

// Namespace flare_system
// Params 0, eflags: 0xc
// Checksum 0xf8a74a43, Offset: 0xb7a
// Size: 0x82
function private function_4a2907d5a476c5b3()
{
    self notify( #"hash_a9d3602704b311a4" );
    self endon( #"hash_a9d3602704b311a4" );
    self endon( #"hash_8037fbace13ee354" );
    self waittill( #"death" );
    _delete_alarm();
    
    if ( self.owner )
    {
        self.owner function_47457b9ec007482e( "ui_veh_warning", 2, 1, 0 );
        self.owner function_47457b9ec007482e( "ui_veh_warning", 4, 1, 0 );
    }
    
    self notify( #"hash_8037fbace13ee354" );
}

// Namespace flare_system
// Params 0, eflags: 0xc
// Checksum 0xe50839d0, Offset: 0xc04
// Size: 0xdf
function private _watch_owner_remote_control()
{
    self notify( #"hash_7fe8d0bf8b4ac601" );
    self endon( #"hash_7fe8d0bf8b4ac601" );
    self endon( #"hash_8037fbace13ee354" );
    assert( self.owner );
    
    if ( !self.owner )
    {
        return;
    }
    
    if ( !self.owner utility::isusingremote() )
    {
        self.owner waittill( #"using_remote" );
    }
    
    _create_alarm();
    thread function_5c6b6501d798569c();
    self.owner waittill( #"stopped_using_remote" );
    _delete_alarm();
    
    if ( self.owner )
    {
        self.owner function_47457b9ec007482e( "ui_veh_warning", 2, 1, 0 );
        self.owner function_47457b9ec007482e( "ui_veh_warning", 4, 1, 0 );
    }
    
    self notify( #"hash_8037fbace13ee354" );
}

// Namespace flare_system
// Params 2
// Checksum 0x69098c9b, Offset: 0xceb
// Size: 0xb8
function attacker_fire_missile( missile, target )
{
    if ( !( isdefined( self ) && isdefined( missile ) && isdefined( target.flaresystem ) ) )
    {
        return;
    }
    
    target.flaresystem.incomingmissiles[ missile.entnum ?? utility::get_entity_number( missile ) ] = missile;
    target.flaresystem.lockingattackers[ self.entnum ?? utility::get_entity_number( self ) ] = undefined;
    target notify( #"hash_f5f6e51c77f7726e" );
    
    if ( target.flaresystem )
    {
        target thread function_fb005b489d89e7e9( missile );
    }
    
    target thread _monitor_missile_explode( missile );
}

// Namespace flare_system
// Params 1
// Checksum 0xe9cc6f2c, Offset: 0xdab
// Size: 0x43
function function_411ad6c6c718aeea( canlockon )
{
    if ( self.flaresystem )
    {
        self.flaresystem.canlockon = canlockon ? 1 : undefined;
        self notify( #"hash_f5f6e51c77f7726e" );
    }
}

// Namespace flare_system
// Params 1
// Checksum 0x281403de, Offset: 0xdf6
// Size: 0x43
function function_fdbb7d1acba3bf49( isactive )
{
    if ( self.flaresystem )
    {
        self.flaresystem.var_432f3791a903498c = isactive ? undefined : 1;
        self notify( #"hash_f5f6e51c77f7726e" );
    }
}

// Namespace flare_system
// Params 1, eflags: 0x4
// Checksum 0xe5574417, Offset: 0xe41
// Size: 0x63
function private _monitor_missile_explode( missile )
{
    missile waittill( #"explode" );
    
    if ( !self.flaresystem )
    {
        return;
    }
    
    if ( missile )
    {
        self.flaresystem.incomingmissiles[ missile.entnum ?? utility::get_entity_number( missile ) ] = undefined;
    }
    
    self notify( #"hash_f5f6e51c77f7726e" );
}

// Namespace flare_system
// Params 1, eflags: 0x4
// Checksum 0xea7b2719, Offset: 0xeac
// Size: 0x98
function private function_fb005b489d89e7e9( missile )
{
    missile endon( #"explode" );
    
    while ( isdefined( self ) && isdefined( missile ) )
    {
        if ( missile.var_935a78de5fd11f63 && distancesquared( missile.origin, self.origin ) < 4000000 )
        {
            missile notify( #"cleartargetlockedontobyprojectile" );
            flare = _create_flare_decoy();
            missile missile_settargetent( flare );
            missile function_ef26e5628fa6042e( 1 );
            missile notify( #"missile_pairedwithflare" );
            break;
        }
        
        waitframe();
    }
}

// Namespace flare_system
// Params 0, eflags: 0x4
// Checksum 0x8677d1a9, Offset: 0xf4c
// Size: 0x7d
function private _create_flare_decoy()
{
    flare = spawn( "script_origin", self.origin + ( 0, 0, -256 ) );
    flare.targetname = "_create_flare_decoy";
    flare.angles = self.angles;
    flare movegravity( ( 0, 0, -1 ), 5 );
    flare thread _flares_delete_after_time( 5 );
    return flare;
}

// Namespace flare_system
// Params 1, eflags: 0x4
// Checksum 0x9c07b48a, Offset: 0xfd2
// Size: 0x15
function private _flares_delete_after_time( delaydelete )
{
    wait delaydelete;
    self delete();
}

