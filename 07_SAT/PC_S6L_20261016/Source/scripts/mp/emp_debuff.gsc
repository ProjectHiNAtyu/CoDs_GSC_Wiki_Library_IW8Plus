// scripts\mp\emp_debuff.gsc  (hash_03a5ffaead56e45b.gscc) (size: 17638 Bytes / 0x44e6 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x285cf438 (677180472)
// size ...... 17638 (0x44e6)
// includes .. 8   (offset: 0x4252)
// strings ... 36  (offset: 0x4292)
// dev strs .. 8   (offset: 0x4486)
// exports ... 58  (offset: 0x2d9e)
// cseg ...... 0x2f3 + 0x2aab (0x2d9e)
// imports ... 91  (offset: 0x36ae)
// animtree1 . 0   (offset: 0x44e6)
// animtree2 . 0   (offset: 0x44e6)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_occupancy;
#using scripts\common\weapon;
#using scripts\mp\common\utility\player;
#using scripts\mp\vehicles\vehicle_hack;

#namespace emp_debuff;

// Namespace emp_debuff
// Params 0
// Checksum 0x60783e42, Offset: 0x311
// Size: 0x10a
function emp_debuff_init()
{
    if ( utility::issharedfuncdefined( #"emp", #"init" ) )
    {
        [[ utility::getsharedfunc( #"emp", #"init" ) ]]();
    }
    
    utility::registersharedfunc( #"emp", #"hash_71bd51894f6f9085", &function_8e7eab19cbf5630c );
    utility::registersharedfunc( #"emp", #"hash_eaae99751be55dfa", &empdebuff_get_emp_ents );
    utility::registersharedfunc( #"emp", #"hash_106f69968890541b", &can_be_empd );
    utility::registersharedfunc( #"emp", #"hash_5bc4b139d38210ad", &apply_emp_struct );
    utility::registersharedfunc( #"emp", #"hash_c22686576f84955f", &play_emp_scramble );
    utility::registersharedfunc( #"emp", #"hash_fb0ad9860238a077", &stop_emp_scramble );
    utility::registersharedfunc( #"emp", #"hash_9330c9a73c217db8", &remove_emp );
}

// Namespace emp_debuff
// Params 3
// Checksum 0x60d67367, Offset: 0x423
// Size: 0xef
function function_1fdeda386a85c7c7( data, time, var_6dc1a273e8093071 )
{
    if ( level.gameended )
    {
        return;
    }
    
    if ( !isdefined( time ) || time <= 0 )
    {
        time = 6;
    }
    
    var_d025772c6532022e = 0;
    
    if ( var_6dc1a273e8093071 && data.victim vehicle::is_vehicle() && data.victim function_3a7131767e718c6f() )
    {
        var_d025772c6532022e = 1;
    }
    
    if ( var_d025772c6532022e )
    {
        function_a525b0717db39dbc( data );
    }
    
    apply_emp_struct( data );
    function_68ebbeb6a8cb271e( data, time );
    
    if ( isdefined( data.victim ) )
    {
        if ( var_d025772c6532022e )
        {
            function_676975e440db5ff9( data );
        }
        else
        {
            data.victim remove_emp();
        }
        
        return;
    }
    
    if ( isdefined( data.var_7b73c6ca5484bd94 ) )
    {
        function_9632b1f633b1ee9f( data );
    }
}

// Namespace emp_debuff
// Params 0
// Checksum 0x7e29251f, Offset: 0x51a
// Size: 0x51
function function_3a7131767e718c6f()
{
    if ( vehicle::is_killstreak() )
    {
        if ( self.vehiclename == "pac_sentry" || self.vehiclename == "radar_drone_recon" || self.vehiclename == "assault_drone" )
        {
            return 1;
        }
        else
        {
            return 0;
        }
        
        return;
    }
    
    return 1;
}

// Namespace emp_debuff
// Params 1
// Checksum 0x1e54977, Offset: 0x573
// Size: 0xa4
function function_676975e440db5ff9( data )
{
    driver = data.var_7b73c6ca5484bd94;
    empcount = data.victim _get_emp_count();
    
    if ( data.var_8c8d23ed7561af15 || empcount <= 1 || data.victim.isdestroyed )
    {
        data.victim clear_emp();
        
        if ( isdefined( driver ) )
        {
            function_9632b1f633b1ee9f( data );
        }
        
        return;
    }
    
    data.victim remove_emp();
}

// Namespace emp_debuff
// Params 1
// Checksum 0xa58dc9b8, Offset: 0x61f
// Size: 0x2d
function function_9632b1f633b1ee9f( data )
{
    data.var_7b73c6ca5484bd94 setclientomnvar( "ui_emp_button_combo_show", 0 );
    data.var_7b73c6ca5484bd94 = undefined;
}

// Namespace emp_debuff
// Params 1
// Checksum 0xdf1e7ad2, Offset: 0x654
// Size: 0xf0
function function_a525b0717db39dbc( data )
{
    vehicle = data.victim;
    notifylist = [ "death", "buttonComboSuccess", "buttonComboReplaced", "buttonComboEarlyExit" ];
    
    if ( data.victim is_empd() )
    {
        function_ccb375d36091d5d6( data );
    }
    
    if ( isdefined( vehicle.helperdronetype ) )
    {
        notifylist[ notifylist.size ] = "drone_exit";
    }
    else if ( vehicle vehicle::is_killstreak() && vehicle.vehiclename == "pac_sentry" )
    {
        notifylist[ notifylist.size ] = "leaving_control";
    }
    else
    {
        notifylist = utility::array_insert_array( notifylist, [ "vehicle_owner_update", "driver_exit" ], 0 );
        data.var_2d20fe25f7bff212 = 1;
    }
    
    data thread function_128a23fa6602ee93( notifylist );
}

// Namespace emp_debuff
// Params 1
// Checksum 0xc9b035ba, Offset: 0x74c
// Size: 0x45
function function_ccb375d36091d5d6( data )
{
    level endon( #"game_ended" );
    data.victim endon( #"death" );
    data.victim notify( #"buttonComboReplaced" );
    waitframe();
}

// Namespace emp_debuff
// Params 1
// Checksum 0xcf77324b, Offset: 0x799
// Size: 0x134
function function_128a23fa6602ee93( notifylist )
{
    self.victim endon( #"emp_cleared" );
    self.victim notify( #"hash_d686e1f93c901e46" );
    self.victim endon( #"hash_d686e1f93c901e46" );
    driver = undefined;
    
    if ( !self.var_2d20fe25f7bff212 )
    {
        driver = self.victim.owner;
        driver endon( #"disconnect" );
    }
    
    childthread function_3f158a07ed37b030();
    
    while ( true )
    {
        if ( !isdefined( self ) )
        {
            break;
        }
        
        if ( !isdefined( self.victim ) )
        {
            break;
        }
        
        if ( self.var_2d20fe25f7bff212 || self.victim.ispiloted )
        {
            if ( self.var_2d20fe25f7bff212 )
            {
                driver = vehicle_occupancy::get_driver( self.victim );
                
                if ( isdefined( driver ) )
                {
                    childthread function_9084e811c4d63c10( self.victim, driver );
                }
            }
            
            if ( isdefined( driver ) )
            {
                shouldcontinue = function_218d982b531e00( driver, notifylist );
                
                if ( !shouldcontinue )
                {
                    break;
                }
            }
            else
            {
                waitframe();
            }
            
            continue;
        }
        
        wait 0.1;
    }
}

// Namespace emp_debuff
// Params 2
// Checksum 0xcb4df522, Offset: 0x8d5
// Size: 0xbc
function function_218d982b531e00( driver, notifylist )
{
    self.var_7b73c6ca5484bd94 = driver;
    self.var_7b73c6ca5484bd94 setclientomnvar( "ui_emp_button_combo_show", 1 );
    childthread function_d183c4fdb1a98cbc();
    childthread function_f05d5d7fa5c2de87( self.var_7b73c6ca5484bd94 );
    childthread function_3e4ae1cf64f66600();
    msg = self.victim utility::waittill_any_in_array_return_no_endon_death( notifylist );
    
    if ( isdefined( self.var_7b73c6ca5484bd94 ) )
    {
        function_9632b1f633b1ee9f( self );
    }
    
    if ( msg == "death" || msg == "buttonComboSuccess" || msg == "buttonComboReplaced" || msg == "buttonComboEarlyExit" )
    {
        return 0;
    }
    
    return 1;
}

// Namespace emp_debuff
// Params 0
// Checksum 0x856545a1, Offset: 0x999
// Size: 0x2d
function function_3e4ae1cf64f66600()
{
    level utility::waittill_any( "game_ended", "round_end_finished", "start_game_ended" );
    self.victim notify( #"buttonComboEarlyExit" );
}

// Namespace emp_debuff
// Params 0
// Checksum 0xcc16967c, Offset: 0x9ce
// Size: 0x5b
function function_d183c4fdb1a98cbc()
{
    maxduration = self.empdurationremaining;
    
    while ( true )
    {
        percentageleft = self.empdurationremaining / 6;
        
        if ( isdefined( self.var_7b73c6ca5484bd94 ) )
        {
            self.var_7b73c6ca5484bd94 setclientomnvar( "ui_emp_button_combo_duration", percentageleft );
        }
        
        waitframe();
    }
}

// Namespace emp_debuff
// Params 0
// Checksum 0xfef5395d, Offset: 0xa31
// Size: 0x3e
function function_3f158a07ed37b030()
{
    self.empdurationremaining = 6;
    
    while ( self.empdurationremaining > 0 )
    {
        self.empdurationremaining -= level.framedurationseconds;
        waitframe();
    }
}

// Namespace emp_debuff
// Params 2
// Checksum 0x74f53cc1, Offset: 0xa77
// Size: 0x54
function function_9084e811c4d63c10( vehicle, driver )
{
    driver endon( #"disconnect" );
    vehicle endon( #"death" );
    driver utility::waittill_any( "vehicle_seat_exit", "death", "killed_player" );
    vehicle notify( #"driver_exit" );
}

// Namespace emp_debuff
// Params 2
// Checksum 0xf5569604, Offset: 0xad3
// Size: 0x5f
function function_68ebbeb6a8cb271e( data, time )
{
    data.victim endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    data.victim utility::waittill_any_timeout( time, "emp_cleared", "buttonComboSuccess", "death", "player_killed_no_faux_death" );
}

// Namespace emp_debuff
// Params 1
// Checksum 0xa9c1454f, Offset: 0xb3a
// Size: 0xae
function function_f05d5d7fa5c2de87( driver )
{
    self.victim notify( #"hash_1fb7f27da123c3dd" );
    self.victim endon( #"hash_1fb7f27da123c3dd" );
    driver endon( #"disconnect" );
    
    while ( true )
    {
        driver waittill( #"luinotifyserver", message, value );
        
        if ( message == "button_combo_success" && value == 1 )
        {
            self.victim notify( #"buttonComboSuccess" );
            driver notify( #"ddos_ended_early" );
            self.var_8c8d23ed7561af15 = 1;
        }
        
        waitframe();
    }
}

// Namespace emp_debuff
// Params 4
// Checksum 0xc41beec, Offset: 0xbf0
// Size: 0x538
function apply_emp_struct( data, disablehud, disablemechanics, var_91428b466152d050 )
{
    assert( isdefined( data ), "<dev string:x24>" );
    assert( isdefined( data.attacker ), "<dev string:x45>" );
    assert( isdefined( data.victim ), "<dev string:x71>" );
    
    if ( isdefined( data.victim.perks[ "specialty_emp_immunity" ] ) )
    {
        return;
    }
    
    assert( isdefined( data.objweapon ), "<dev string:x9b>" );
    assert( isweapon( data.objweapon ), "<dev string:xc8>" );
    ddos_struct = undefined;
    
    if ( data.objweapon.var_25b0062cbe4d9c99 == #"emp_pulse" )
    {
        ddos_struct = {};
        
        if ( !isdefined( ddos_struct.challengedata ) )
        {
            ddos_struct.challengedata = {};
        }
        
        ddos_struct.challengedata.bitmodifiers = [];
        ddos_struct.superref = "super_emp_pulse";
        ddos_struct.challengedata.bitmodifiers[ ddos_struct.challengedata.bitmodifiers.size ] = #"hash_3b08d1916ccd4cda";
        data.inflictor = ddos_struct;
    }
    
    if ( !isdefined( data.damage ) )
    {
        data.damage = 1;
    }
    
    if ( !isdefined( data.meansofdeath ) )
    {
        data.meansofdeath = "MOD_EXPLOSIVE";
    }
    
    if ( !isdefined( data.point ) )
    {
        data.point = ( 0, 0, 0 );
    }
    
    if ( !isdefined( data.direction_vec ) )
    {
        data.direction_vec = ( 0, 0, 0 );
    }
    
    if ( !isdefined( data.modelname ) )
    {
        data.modelname = 0;
    }
    
    if ( !isdefined( data.partname ) )
    {
        data.partname = "";
    }
    
    if ( !isdefined( data.tagname ) )
    {
        data.tagname = 0;
    }
    
    if ( !isdefined( data.damageflags ) )
    {
        data.damageflags = 0;
    }
    
    if ( !isdefined( data.hitloc ) )
    {
        data.hitloc = "none";
    }
    
    if ( !isdefined( data.timeoffset ) )
    {
        data.timeoffset = 0;
    }
    
    if ( !isdefined( data.victim.empcount ) )
    {
        data.victim.empcount = 0;
    }
    
    if ( !isdefined( data.reason ) )
    {
        data.reason = "DDOS";
    }
    
    data.victim.empcount++;
    data.victim notify( #"emp_started", data );
    
    if ( isent( data.victim ) && isplayer( data.victim ) )
    {
        data.victim thread function_affa5f8b70eecf8f( data, disablehud, disablemechanics, var_91428b466152d050 );
    }
    
    empstartcallback = function_8b41dd5fdf0e0f7a( data.victim );
    
    if ( empstartcallback && data.reason == "DDOS" )
    {
        data.victim thread [[ empstartcallback ]]( data );
    }
    
    if ( isdefined( data.victim.empapplycallback ) )
    {
        data.victim thread [[ data.victim.empapplycallback ]]( data );
    }
    
    var_524da505a73a6a91 = function_d1154318fbceb76d( data.victim );
    
    if ( var_524da505a73a6a91 && data.reason == "AKILO_APEX_EMP" )
    {
        data.victim thread [[ var_524da505a73a6a91 ]]( data );
    }
    
    if ( isdefined( data.victim.ksempapplycallback ) )
    {
        data.victim thread [[ data.victim.ksempapplycallback ]]( data );
    }
    
    if ( data.inflictor.var_7563c9e8d353ca9a )
    {
        data.attacker thread [[ data.inflictor.var_7563c9e8d353ca9a ]]( data );
    }
    
    if ( ddos_struct )
    {
        if ( isplayer( data.victim ) )
        {
            return;
        }
        
        challengeparams = { #fieldupgraderef:"super_emp_pulse", #fieldupgradeent:ddos_struct, #victim:data.victim, #attacker:data.attacker };
        callback::callback( #"field_upgrade_hit", challengeparams );
    }
    
    data.victim notify( #"emp_applied", data );
}

// Namespace emp_debuff
// Params 0
// Checksum 0x1798807c, Offset: 0x1130
// Size: 0x5b
function remove_emp()
{
    if ( !isdefined( self.empcount ) )
    {
        return;
    }
    
    self.empcount--;
    empremovecallback = get_remove_emp_callback( self );
    
    if ( empremovecallback )
    {
        self thread [[ empremovecallback ]]();
    }
    
    self notify( #"emp_removed" );
    
    if ( self.empcount == 0 )
    {
        clear_emp( 0 );
    }
}

// Namespace emp_debuff
// Params 1
// Checksum 0xf88c2c5d, Offset: 0x1193
// Size: 0x6a
function clear_emp( fromdeath )
{
    if ( isdefined( self.empcount ) )
    {
        self.empcount = undefined;
        
        if ( isent( self ) && isplayer( self ) )
        {
            thread function_ce8a6316af0250fd( istrue( fromdeath ) );
        }
        else if ( isdefined( self.empclearcallback ) )
        {
            self thread [[ self.empclearcallback ]]( istrue( fromdeath ) );
        }
        
        self notify( #"emp_cleared" );
    }
}

// Namespace emp_debuff
// Params 1
// Checksum 0x1407cf40, Offset: 0x1205
// Size: 0x6a
function allow_emp( status )
{
    if ( isplayer( self ) )
    {
        _allow_emp_player( status );
        return;
    }
    
    if ( !isdefined( self.empnotallowed ) )
    {
        self.empnotallowed = 0;
    }
    
    if ( status )
    {
        assert( self.empnotallowed > 0, "<dev string:xfb>" );
        self.empnotallowed--;
        return;
    }
    
    self.empnotallowed++;
}

// Namespace emp_debuff
// Params 0
// Checksum 0x40d2a8c5, Offset: 0x1277
// Size: 0x23, Type: bool
function function_2270caa3506a92b3()
{
    if ( self.exploding )
    {
        return false;
    }
    else if ( self.empnotallowed )
    {
        return false;
    }
    
    return true;
}

// Namespace emp_debuff
// Params 0
// Checksum 0x87b812dd, Offset: 0x12a3
// Size: 0x47
function can_be_empd()
{
    if ( isplayer( self ) )
    {
        return function_eefa2335318c809e();
    }
    else if ( isagent( self ) )
    {
        return function_ea32aecc2925fb09();
    }
    else if ( self.exploding )
    {
        return 0;
    }
    else if ( self.empnotallowed )
    {
        return 0;
    }
    
    return 1;
}

// Namespace emp_debuff
// Params 0
// Checksum 0x7611e4e6, Offset: 0x12f3
// Size: 0xd, Type: bool
function is_empd()
{
    return self.empcount > 0;
}

// Namespace emp_debuff
// Params 0
// Checksum 0x54e263a8, Offset: 0x1309
// Size: 0x1e
function emp_debuff_get_emp_count()
{
    if ( isdefined( self.empcount ) )
    {
        return self.empcount;
    }
    
    return 0;
}

// Namespace emp_debuff
// Params 1
// Checksum 0x77ddd906, Offset: 0x132f
// Size: 0x17
function set_apply_emp_callback( applycallback )
{
    self.empapplycallback = applycallback;
}

// Namespace emp_debuff
// Params 1
// Checksum 0x1cceac87, Offset: 0x134e
// Size: 0x17
function function_6e0986f750cd4259( applycallback )
{
    self.var_524da505a73a6a91 = applycallback;
}

// Namespace emp_debuff
// Params 1
// Checksum 0xff96a9da, Offset: 0x136d
// Size: 0x50
function function_d1154318fbceb76d( entity )
{
    var_7237854e3be197ca = entity.var_524da505a73a6a91;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    if ( entity && entity vehicle::is_vehicle() && !entity vehicle::is_husk() )
    {
        return &vehicle_hack::function_9bbdc002b60edf61;
    }
}

// Namespace emp_debuff
// Params 1
// Checksum 0x90bf4d5, Offset: 0x13c5
// Size: 0x17
function set_start_emp_callback( startcallback )
{
    self.empstartcallback = startcallback;
}

// Namespace emp_debuff
// Params 1
// Checksum 0xb547567a, Offset: 0x13e4
// Size: 0x50
function function_8b41dd5fdf0e0f7a( entity )
{
    var_7237854e3be197ca = entity.empstartcallback;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    if ( entity && entity vehicle::is_vehicle() && !entity vehicle::is_husk() )
    {
        return &vehicle_hack::emp_start_callback;
    }
}

// Namespace emp_debuff
// Params 1
// Checksum 0x7f231043, Offset: 0x143c
// Size: 0x17
function function_9d033e783cc3378( clearcallback )
{
    self.empremovecallback = clearcallback;
}

// Namespace emp_debuff
// Params 1
// Checksum 0x1cc408c2, Offset: 0x145b
// Size: 0x50
function get_remove_emp_callback( entity )
{
    var_7237854e3be197ca = entity.empremovecallback;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    if ( entity && entity vehicle::is_vehicle() && !entity vehicle::is_husk() )
    {
        return &vehicle_hack::emp_remove_callback;
    }
}

// Namespace emp_debuff
// Params 1
// Checksum 0x1e4c8112, Offset: 0x14b3
// Size: 0x17
function set_clear_emp_callback( clearcallback )
{
    self.empclearcallback = clearcallback;
}

// Namespace emp_debuff
// Params 1
// Checksum 0x1914c16a, Offset: 0x14d2
// Size: 0x40
function add_emp_ent( ent )
{
    data = _emp_get_level_data();
    id = ent getentitynumber();
    data.ents[ id ] = ent;
    return id;
}

// Namespace emp_debuff
// Params 2
// Checksum 0x8c89f19, Offset: 0x151b
// Size: 0x2f
function play_scramble( scramblelevel, isjammer )
{
    if ( isjammer )
    {
        function_23339a8a84d1fbd5( scramblelevel );
        return;
    }
    
    play_emp_scramble( scramblelevel );
}

// Namespace emp_debuff
// Params 2
// Checksum 0x592f8868, Offset: 0x1552
// Size: 0x2f
function stop_scramble( scramblelevel, isjammer )
{
    if ( isjammer )
    {
        function_5fe901df82a4dc8b( scramblelevel );
        return;
    }
    
    stop_emp_scramble( scramblelevel );
}

// Namespace emp_debuff
// Params 2
// Checksum 0xa9877cbd, Offset: 0x1589
// Size: 0x53
function function_67d03d9afb12016d( scramblelevel, var_fddfd3341b09e1e9 )
{
    if ( var_fddfd3341b09e1e9 )
    {
        return ( isdefined( self.var_91b62dd5b67835ca ) && isdefined( self.var_91b62dd5b67835ca[ scramblelevel ] ) );
    }
    
    return isdefined( self.empscramblelevels ) && isdefined( self.empscramblelevels[ scramblelevel ] );
}

// Namespace emp_debuff
// Params 2
// Checksum 0x38b66a83, Offset: 0x15e4
// Size: 0x7c
function play_emp_scramble( scramblelevel, var_e3060be073913045 )
{
    if ( scramblelevel == 0 )
    {
        return;
    }
    
    if ( !isdefined( self.empscramblelevels ) )
    {
        self.empscramblelevels = [];
    }
    
    var_cdf1652d61c7ff64 = self.empscramblelevels[ scramblelevel ];
    
    if ( !isdefined( var_cdf1652d61c7ff64 ) )
    {
        var_cdf1652d61c7ff64 = 0;
    }
    
    self.empscramblelevels[ scramblelevel ] = var_cdf1652d61c7ff64 + 1;
    _update_emp_scramble();
    
    if ( var_e3060be073913045 )
    {
        player::function_509b2945fa3a9b48( 1, 1 );
    }
}

// Namespace emp_debuff
// Params 2
// Checksum 0x8601f457, Offset: 0x1668
// Size: 0x7b
function stop_emp_scramble( scramblelevel, var_4a8314a653e6e08 )
{
    if ( scramblelevel == 0 )
    {
        return;
    }
    
    if ( !self.empscramblelevels[ scramblelevel ] )
    {
        return;
    }
    
    self.empscramblelevels[ scramblelevel ] -= 1;
    
    if ( self.empscramblelevels[ scramblelevel ] == 0 )
    {
        self.empscramblelevels[ scramblelevel ] = undefined;
    }
    
    _update_emp_scramble();
    
    if ( var_4a8314a653e6e08 )
    {
        player::function_509b2945fa3a9b48( 0 );
    }
}

// Namespace emp_debuff
// Params 0
// Checksum 0x3dfbc443, Offset: 0x16eb
// Size: 0x58
function clear_emp_scramble()
{
    self.empscramblelevels = [];
    _update_emp_scramble();
    
    if ( isdefined( self.empclearcallback ) )
    {
        self thread [[ self.empclearcallback ]]( 0 );
    }
    
    self notify( #"emp_scramble_off" );
    
    if ( self.var_b0ba2077de866a7c )
    {
        self.var_b0ba2077de866a7c = 0;
        player::function_509b2945fa3a9b48( 0 );
    }
}

// Namespace emp_debuff
// Params 0, eflags: 0x4
// Checksum 0x959a9329, Offset: 0x174b
// Size: 0x9d
function private _update_emp_scramble()
{
    highestlevel = 0;
    
    foreach ( scramblelevel, _ in self.empscramblelevels )
    {
        if ( scramblelevel > highestlevel )
        {
            highestlevel = scramblelevel;
        }
    }
    
    if ( isplayer( self ) )
    {
        self setclientomnvar( "ui_scrambler_strength", highestlevel );
    }
}

// Namespace emp_debuff
// Params 0, eflags: 0x4
// Checksum 0xa5074dbf, Offset: 0x17f0
// Size: 0x95
function private function_30ddcad19b4f39d7()
{
    highestlevel = 0;
    
    foreach ( scramblelevel, _ in self.var_91b62dd5b67835ca )
    {
        if ( scramblelevel > highestlevel )
        {
            highestlevel = scramblelevel;
        }
    }
    
    self setclientomnvar( "ui_jammer_strength", highestlevel );
}

// Namespace emp_debuff
// Params 1
// Checksum 0x1f0b824a, Offset: 0x188d
// Size: 0x63
function function_23339a8a84d1fbd5( scramblelevel )
{
    if ( scramblelevel == 0 )
    {
        return;
    }
    
    if ( !isdefined( self.var_91b62dd5b67835ca ) )
    {
        self.var_91b62dd5b67835ca = [];
    }
    
    var_718caaba1a64a76b = self.var_91b62dd5b67835ca[ scramblelevel ];
    
    if ( !isdefined( var_718caaba1a64a76b ) )
    {
        var_718caaba1a64a76b = 0;
    }
    
    self.var_91b62dd5b67835ca[ scramblelevel ] = var_718caaba1a64a76b + 1;
    function_30ddcad19b4f39d7();
}

// Namespace emp_debuff
// Params 1
// Checksum 0xc016f8cb, Offset: 0x18f8
// Size: 0x85
function function_5fe901df82a4dc8b( scramblelevel )
{
    if ( scramblelevel == 0 )
    {
        return;
    }
    
    assert( isdefined( self.var_91b62dd5b67835ca ), "<dev string:x130>" );
    assert( isdefined( self.var_91b62dd5b67835ca[ scramblelevel ] ), "<dev string:x162>" );
    self.var_91b62dd5b67835ca[ scramblelevel ] -= 1;
    
    if ( self.var_91b62dd5b67835ca[ scramblelevel ] == 0 )
    {
        self.var_91b62dd5b67835ca[ scramblelevel ] = undefined;
    }
    
    function_30ddcad19b4f39d7();
}

// Namespace emp_debuff
// Params 2
// Checksum 0xc56e8ebf, Offset: 0x1985
// Size: 0x40
function play_scramble_for_player_until_cleared( player, scramblelevel )
{
    player play_emp_scramble( scramblelevel );
    utility::waittill_any( "emp_cleared", "death" );
    
    if ( isdefined( player ) )
    {
        player stop_emp_scramble( scramblelevel );
    }
}

// Namespace emp_debuff
// Params 2
// Checksum 0x999a2a5a, Offset: 0x19cd
// Size: 0x40
function function_2eb2a0b9290e24a7( player, scramblelevel )
{
    player play_emp_scramble( scramblelevel );
    utility::waittill_any( "dronegun_emp_cleared", "death" );
    
    if ( isdefined( player ) )
    {
        player stop_emp_scramble( scramblelevel );
    }
}

// Namespace emp_debuff
// Params 1, eflags: 0x4
// Checksum 0x2b9a5f92, Offset: 0x1a15
// Size: 0x45
function private _allow_emp_player( status )
{
    if ( utility::issharedfuncdefined( #"emp", #"hash_24292c1f5df2e9dd" ) )
    {
        self [[ utility::getsharedfunc( #"emp", #"hash_24292c1f5df2e9dd" ) ]]( status );
    }
}

// Namespace emp_debuff
// Params 0, eflags: 0x4
// Checksum 0xdec0e188, Offset: 0x1a62
// Size: 0x1f
function private _get_emp_count()
{
    if ( !isdefined( self.empcount ) )
    {
        return 0;
    }
    
    return self.empcount;
}

// Namespace emp_debuff
// Params 0, eflags: 0x4
// Checksum 0x59ff4660, Offset: 0x1a89
// Size: 0x34, Type: bool
function private function_eefa2335318c809e()
{
    if ( !player::isreallyalive() )
    {
        return false;
    }
    
    return !isdefined( self.perks[ "specialty_empimmune" ] ) && !isdefined( self.perks[ "specialty_emp_immunity" ] );
}

// Namespace emp_debuff
// Params 0, eflags: 0x4
// Checksum 0x8e38e6ef, Offset: 0x1ac6
// Size: 0x8
function private function_ea32aecc2925fb09()
{
    return player::isreallyalive();
}

// Namespace emp_debuff
// Params 4, eflags: 0x4
// Checksum 0x82185c00, Offset: 0x1ad7
// Size: 0xc0
function private function_affa5f8b70eecf8f( data, disablehud, disablemechanics, var_91428b466152d050 )
{
    if ( utility::issharedfuncdefined( #"emp", #"hash_1ffae9c7bf3f1bac" ) )
    {
        self [[ utility::getsharedfunc( #"emp", #"hash_1ffae9c7bf3f1bac" ) ]]( data );
    }
    
    if ( disablehud )
    {
        self setempjammed( 1 );
    }
    else if ( var_91428b466152d050 )
    {
        self setempjammed( 0, 1 );
    }
    
    self setscriptablepartstate( #"playeremp", #"on", 0 );
    
    if ( disablemechanics )
    {
        val::set( "emp", "killstreaks", 0 );
        val::set( "emp", "supers", 0 );
    }
}

// Namespace emp_debuff
// Params 1, eflags: 0x4
// Checksum 0x7a853286, Offset: 0x1b9f
// Size: 0x3e
function private function_ce8a6316af0250fd( fromdeath )
{
    self setempjammed( 0 );
    self setscriptablepartstate( #"playeremp", #"off", 0 );
    
    if ( !fromdeath )
    {
        val::reset_all( "emp" );
    }
}

// Namespace emp_debuff
// Params 0, eflags: 0x4
// Checksum 0x67780cff, Offset: 0x1be5
// Size: 0x32
function private _emp_init()
{
    data = spawnstruct();
    level.emp = data;
    level.emp.ents = [];
}

// Namespace emp_debuff
// Params 0, eflags: 0x4
// Checksum 0xfcd21c3d, Offset: 0x1c1f
// Size: 0x20
function private _emp_get_level_data()
{
    if ( !isdefined( level.emp ) )
    {
        _emp_init();
    }
    
    return level.emp;
}

// Namespace emp_debuff
// Params 4
// Checksum 0x8ca134a9, Offset: 0x1c48
// Size: 0x86
function emp_debuff_register( entity, applycallback, startcallback, clearcallback )
{
    if ( isdefined( applycallback ) )
    {
        entity set_apply_emp_callback( applycallback );
    }
    
    if ( isdefined( startcallback ) )
    {
        entity set_start_emp_callback( startcallback );
    }
    
    if ( isdefined( clearcallback ) )
    {
        entity set_clear_emp_callback( clearcallback );
    }
    
    if ( !isdefined( level.var_49399f27bf890a57 ) )
    {
        level.var_49399f27bf890a57 = [];
    }
    
    if ( isdefined( entity ) )
    {
        level.var_49399f27bf890a57[ entity getentitynumber() ] = entity;
    }
}

// Namespace emp_debuff
// Params 1
// Checksum 0x4bac637f, Offset: 0x1cd6
// Size: 0x71
function emp_debuff_deregister( entity )
{
    if ( !isdefined( level.var_49399f27bf890a57 ) )
    {
        return;
    }
    
    if ( !isdefined( entity ) )
    {
        return;
    }
    
    entity set_apply_emp_callback( undefined );
    entity set_start_emp_callback( undefined );
    entity set_clear_emp_callback( undefined );
    entitynumber = entity getentitynumber();
    
    if ( !isdefined( level.var_49399f27bf890a57[ entitynumber ] ) )
    {
        return;
    }
    
    level.var_49399f27bf890a57[ entitynumber ] = undefined;
}

// Namespace emp_debuff
// Params 3, eflags: 0x4
// Checksum 0xca36cc6b, Offset: 0x1d4f
// Size: 0x49, Type: bool
function private function_6f38be1550255478( ents, optionalorigin, var_1f592e6215a3dc4d )
{
    if ( isdefined( optionalorigin ) )
    {
        if ( distancesquared( self.origin, optionalorigin ) > var_1f592e6215a3dc4d )
        {
            return false;
        }
    }
    
    if ( arraycontains( ents, self ) )
    {
        return false;
    }
    
    return true;
}

// Namespace emp_debuff
// Params 2
// Checksum 0xa6ac3e5, Offset: 0x1da1
// Size: 0xf87
function empdebuff_get_emp_ents( optionalorigin, optionalradius )
{
    data = _emp_get_level_data();
    radiussquared = undefined;
    
    if ( isdefined( optionalradius ) )
    {
        radiussquared = optionalradius * optionalradius;
    }
    
    ents = [];
    
    foreach ( ent in data.ents )
    {
        if ( isdefined( ent ) && ent can_be_empd() && ent function_6f38be1550255478( ents, optionalorigin, radiussquared ) )
        {
            ents[ ents.size ] = ent;
        }
    }
    
    allmines = weapon::function_3aafcaf7ff6dea9e();
    
    foreach ( mine in allmines )
    {
        if ( isdefined( mine ) && mine function_2270caa3506a92b3() && mine function_6f38be1550255478( ents, optionalorigin, radiussquared ) )
        {
            ents[ ents.size ] = mine;
        }
    }
    
    turrets = getentarray( "misc_turret", #classname );
    
    foreach ( turret in turrets )
    {
        if ( isdefined( turret ) && turret function_2270caa3506a92b3() && turret function_6f38be1550255478( ents, optionalorigin, radiussquared ) )
        {
            ents[ ents.size ] = turret;
        }
    }
    
    if ( isdefined( level.activekillstreaks ) )
    {
        foreach ( streak in level.activekillstreaks )
        {
            if ( isdefined( streak ) && streak function_2270caa3506a92b3() && streak function_6f38be1550255478( ents, optionalorigin, radiussquared ) )
            {
                ents[ ents.size ] = streak;
            }
        }
    }
    
    if ( isdefined( level.vehicle ) )
    {
        foreach ( vehicles in level.vehicle.instances )
        {
            foreach ( vehicle in vehicles )
            {
                if ( isdefined( vehicle ) && vehicle function_2270caa3506a92b3() && vehicle function_6f38be1550255478( ents, optionalorigin, radiussquared ) )
                {
                    ents[ ents.size ] = vehicle;
                }
            }
        }
    }
    
    if ( isdefined( level.trackers ) )
    {
        foreach ( tracker in level.trackers )
        {
            if ( isdefined( tracker ) && tracker function_2270caa3506a92b3() && tracker function_6f38be1550255478( ents, optionalorigin, radiussquared ) )
            {
                ents[ ents.size ] = tracker;
            }
        }
    }
    
    if ( isdefined( level.var_49399f27bf890a57 ) )
    {
        foreach ( equipment in level.var_49399f27bf890a57 )
        {
            if ( isdefined( equipment ) && equipment function_2270caa3506a92b3() && equipment function_6f38be1550255478( ents, optionalorigin, radiussquared ) )
            {
                ents[ ents.size ] = equipment;
            }
        }
    }
    
    if ( isdefined( level.smokeairdropdrones ) )
    {
        foreach ( drone in level.smokeairdropdrones )
        {
            if ( isdefined( drone ) && !drone.isdestroyed && drone function_6f38be1550255478( ents, optionalorigin, radiussquared ) )
            {
                ents[ ents.size ] = drone;
            }
        }
    }
    
    if ( isdefined( level.var_ccf919fdf6fa4c06 ) )
    {
        foreach ( object in level.var_ccf919fdf6fa4c06 )
        {
            if ( object function_6f38be1550255478( ents, optionalorigin, radiussquared ) )
            {
                ents[ ents.size ] = object;
            }
        }
    }
    
    if ( isdefined( level.holdprop ) && isdefined( level.fortressstruct ) && isdefined( level.fortressstruct.chosenfortresses ) && level.holdprop.canemp )
    {
        foreach ( stronghold in level.fortressstruct.chosenfortresses )
        {
            if ( isdefined( stronghold ) && isdefined( stronghold.task ) && isdefined( stronghold.task.holdpoint ) && isdefined( stronghold.task.holdpoint.trigger ) && stronghold.task.holdpoint.trigger function_6f38be1550255478( ents, optionalorigin, radiussquared ) )
            {
                ents[ ents.size ] = stronghold.task.holdpoint.trigger;
            }
        }
    }
    
    if ( isdefined( level.agentarray ) )
    {
        foreach ( agent in level.agentarray )
        {
            if ( isdefined( agent ) && agent can_be_empd() && agent function_6f38be1550255478( ents, optionalorigin, radiussquared ) )
            {
                ents[ ents.size ] = agent;
            }
        }
    }
    
    if ( level.var_5ee9a89b9f9b984b )
    {
        foreach ( towerstruct in level.uavtowers )
        {
            if ( isdefined( towerstruct ) && isdefined( towerstruct.uav_station ) && towerstruct.uav_station function_6f38be1550255478( ents, optionalorigin, radiussquared ) )
            {
                ents[ ents.size ] = towerstruct.uav_station;
            }
        }
    }
    
    if ( level.var_c7c34c7053a29846 && isdefined( level.redeploy_drone_info_struct ) )
    {
        if ( isdefined( level.redeploy_drone_info_struct.var_dc2234786c8913dd ) )
        {
            foreach ( dronescriptable in level.redeploy_drone_info_struct.var_dc2234786c8913dd )
            {
                if ( !dronescriptable.b_occupied )
                {
                    continue;
                }
                
                if ( dronescriptable function_6f38be1550255478( ents, optionalorigin, radiussquared ) )
                {
                    ents[ ents.size ] = dronescriptable;
                }
            }
        }
        
        if ( isdefined( level.redeploy_drone_info_struct.movingdrones ) )
        {
            foreach ( droneent in level.redeploy_drone_info_struct.movingdrones )
            {
                if ( droneent function_6f38be1550255478( ents, optionalorigin, radiussquared ) )
                {
                    ents[ ents.size ] = droneent;
                }
            }
        }
    }
    
    if ( level.var_c7c34c7053a29846 && utility::issharedfuncdefined( #"superredeploydronebeacon", #"hash_3dd4fa0f710a2eff" ) )
    {
        drones = [[ utility::getsharedfunc( #"superredeploydronebeacon", #"hash_3dd4fa0f710a2eff" ) ]]();
        assert( isdefined( drones ) );
        
        foreach ( dronescriptable in drones )
        {
            if ( !isdefined( dronescriptable ) )
            {
                continue;
            }
            
            if ( !dronescriptable.b_occupied )
            {
                continue;
            }
            
            if ( dronescriptable function_6f38be1550255478( ents, optionalorigin, radiussquared ) )
            {
                ents[ ents.size ] = dronescriptable;
            }
        }
    }
    
    foreach ( drone in level.package_airdrop.activedrones )
    {
        if ( drone.var_92c7f6e9874d8adc && drone function_6f38be1550255478( ents, optionalorigin, radiussquared ) )
        {
            ents[ ents.size ] = drone;
        }
    }
    
    if ( level.deployablekiosks.var_e253c9f921155d75 )
    {
        foreach ( buystation in level.deployablekiosks.buystations )
        {
            if ( buystation function_6f38be1550255478( ents, optionalorigin, radiussquared ) )
            {
                ents[ ents.size ] = buystation;
            }
        }
    }
    
    if ( level.huntdrones )
    {
        foreach ( drone in level.huntdrones )
        {
            if ( drone function_6f38be1550255478( ents, optionalorigin, radiussquared ) )
            {
                ents[ ents.size ] = drone;
            }
        }
    }
    
    if ( isdefined( level.slidingdoors ) )
    {
        foreach ( door in level.slidingdoors )
        {
            if ( door function_6f38be1550255478( ents, optionalorigin, radiussquared ) )
            {
                ents[ ents.size ] = door;
            }
        }
    }
    
    if ( isdefined( level.scriptable_garage_doors ) )
    {
        foreach ( door in level.scriptable_garage_doors )
        {
            if ( door function_6f38be1550255478( ents, optionalorigin, radiussquared ) )
            {
                ents[ ents.size ] = door;
            }
        }
    }
    
    if ( isdefined( level.var_23141adfd483bfa9 ) )
    {
        foreach ( object in level.var_23141adfd483bfa9 )
        {
            if ( object function_6f38be1550255478( ents, optionalorigin, radiussquared ) )
            {
                ents[ ents.size ] = object;
            }
        }
    }
    
    foreach ( player in level.players )
    {
        if ( !isplayer( player ) && player can_be_empd() && player function_6f38be1550255478( ents, optionalorigin, radiussquared ) )
        {
            ents[ ents.size ] = player;
        }
    }
    
    return ents;
}

// Namespace emp_debuff
// Params 3
// Checksum 0xaf4c43e2, Offset: 0x2d31
// Size: 0x6d
function function_8e7eab19cbf5630c( entity, empcallback, empclearedcallback )
{
    entity set_apply_emp_callback( empcallback );
    entity set_clear_emp_callback( empclearedcallback );
    entity.var_94dbe7695ac27ed7 = 1;
    
    if ( !isdefined( level.var_ccf919fdf6fa4c06 ) )
    {
        level.var_ccf919fdf6fa4c06 = [];
    }
    
    level.var_ccf919fdf6fa4c06[ level.var_ccf919fdf6fa4c06.size ] = entity;
}

