// scripts\mp\playerhealth.gsc  (hash_65a96ea484cf876d.gscc) (size: 21482 Bytes / 0x53ea / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x355c3446 (895235142)
// size ...... 21482 (0x53ea)
// includes .. 14  (offset: 0x4fbe)
// strings ... 29  (offset: 0x502e)
// dev strs .. 27  (offset: 0x520e)
// exports ... 60  (offset: 0x34de)
// cseg ...... 0x2de + 0x3200 (0x34de)
// imports ... 135 (offset: 0x3e3e)
// animtree1 . 0   (offset: 0x53ea)
// animtree2 . 0   (offset: 0x53ea)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\damage_effects;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\analyticslog;
#using scripts\mp\battlechatter_mp;
#using scripts\mp\common\utility\dvars;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\damage;
#using scripts\mp\damage_effects_cp_mp;
#using scripts\mp\operator;
#using scripts\mp\playerhealth;

#namespace playerhealth;

// Namespace playerhealth
// Params 0
// Checksum 0x61119586, Offset: 0x2fc
// Size: 0x20a
function gethealthperframe()
{
    var_f5df6bbd89fe1a2c = level.sharedfuncs[ #"player" ][ #"getgametypehealthperframe" ];
    
    if ( isdefined( var_f5df6bbd89fe1a2c ) )
    {
        healthperframe = self [[ var_f5df6bbd89fe1a2c ]]();
    }
    else if ( isdefined( self.perks[ "specialty_regenfaster" ] ) && isdefined( level.regenfasterhealthmod ) )
    {
        healthperframe *= level.regenfasterhealthmod;
    }
    else if ( isdefined( level.regenhealthaddfunc ) )
    {
        healthperframe = [[ level.regenhealthaddfunc ]]( healthperframe );
    }
    else
    {
        healthperframe = level.var_6c2d489f9cc9f171;
    }
    
    if ( isdefined( self.callbacks[ #"hash_6a8a551945faab9" ] ) || isdefined( level.callbacks[ #"hash_6a8a551945faab9" ] ) )
    {
        callbackparams = { #var_2b32a8de075bfd54:1 };
        callback::callback( #"hash_6a8a551945faab9", callbackparams );
        healthperframe *= callbackparams.var_2b32a8de075bfd54;
    }
    
    foreach ( func in level.var_193330891de44648 )
    {
        var_179405d3d055edbb = self [[ func ]]( healthperframe );
        
        if ( isdefined( var_179405d3d055edbb ) )
        {
            healthperframe *= var_179405d3d055edbb;
        }
    }
    
    /#
        assert( level.var_6a872024f536a219 * 0.05 == level.var_6c2d489f9cc9f171, "<dev string:x24>" );
        var_5f8f0145ec31566b = getdvarint( @"hash_9e41eb34980a2301", 0 );
        
        if ( var_5f8f0145ec31566b )
        {
            print( gettime() + "<dev string:x7e>" + self getentitynumber() + "<dev string:x7e>" + self.name + "<dev string:x80>" + healthperframe );
        }
    #/
    
    return healthperframe;
}

// Namespace playerhealth
// Params 1
// Checksum 0x5cecee9f, Offset: 0x50f
// Size: 0xb4
function function_dad947b5395370a9( healinginstance )
{
    var_fa68c3662d6e7eb6 = function_b2900ab8be3b86ba( healinginstance.naturalheal );
    
    if ( var_fa68c3662d6e7eb6 < 1 )
    {
        var_6abcbf9c7f325c85 = minint( self.maxhealth, int( function_818fe7b2394cad59() * var_fa68c3662d6e7eb6 ) );
    }
    else
    {
        var_6abcbf9c7f325c85 = self.maxhealth;
    }
    
    if ( isdefined( healinginstance.options.amount ) )
    {
        var_6abcbf9c7f325c85 = minint( var_6abcbf9c7f325c85, self.health + healinginstance.options.amount - healinginstance.amounthealed );
    }
    
    return var_6abcbf9c7f325c85;
}

// Namespace playerhealth
// Params 1
// Checksum 0xebda9c66, Offset: 0x5cc
// Size: 0x34, Type: bool
function function_b2900ab8be3b86ba( naturalheal )
{
    if ( naturalheal )
    {
        return ( self.var_fa68c3662d6e7eb6 ?? level.var_95f549187374781d ?? 1 );
    }
    
    return true;
}

// Namespace playerhealth
// Params 0
// Checksum 0xe09c6553, Offset: 0x609
// Size: 0xb3
function function_b1147c0ebe8a1da4()
{
    result = self.health;
    
    foreach ( healinginstance in self.playerhealth.current_healing )
    {
        var_5fc006a5e7de01d9 = function_dad947b5395370a9( healinginstance ) - self.health;
        result += var_5fc006a5e7de01d9;
    }
    
    return result;
}

// Namespace playerhealth
// Params 0, eflags: 0x4
// Checksum 0xe4fef658, Offset: 0x6c5
// Size: 0x1a5
function private function_8e01852aacc4a944()
{
    assert( isplayer( self ) );
    var_df19a43f18b9ce5c = 0;
    
    if ( !isdefined( self.var_20856856a4b63054 ) )
    {
        return var_df19a43f18b9ce5c;
    }
    
    if ( level.gamemodebundle.var_299489b0e05c5de1 )
    {
        buff = 0;
        debuff = 0;
        
        foreach ( mod in self.var_20856856a4b63054 )
        {
            if ( mod > buff )
            {
                buff = mod;
                continue;
            }
            
            if ( mod < debuff )
            {
                debuff = mod;
            }
        }
        
        var_df19a43f18b9ce5c = buff + debuff;
    }
    else
    {
        foreach ( mod in self.var_20856856a4b63054 )
        {
            var_df19a43f18b9ce5c += mod;
        }
        
        /#
            var_5f8f0145ec31566b = getdvarint( @"hash_9e41eb34980a2301", 0 );
            
            if ( var_5f8f0145ec31566b )
            {
                print( gettime() + "<dev string:x7e>" + self getentitynumber() + "<dev string:x7e>" + self.name + "<dev string:xb6>" + var_df19a43f18b9ce5c );
            }
        #/
    }
    
    return var_df19a43f18b9ce5c;
}

// Namespace playerhealth
// Params 1
// Checksum 0xd21af802, Offset: 0x873
// Size: 0xc8
function function_77704251ecdece64( var_50d23e5838bd6be8 )
{
    var_48243cfe0bb2061e = level.healthregendelayms ?? 5000;
    var_2fb3f07a31e3c9dc = function_97e22750fdd64dee( var_48243cfe0bb2061e );
    var_a707c89155190f49 = function_5a3fa7a8e145d81();
    var_2fb3f07a31e3c9dc += var_a707c89155190f49 * 1000;
    
    if ( isdefined( var_50d23e5838bd6be8 ) )
    {
        var_10e9e1fdbbd10ab0 = gettime();
        var_10e9e1fdbbd10ab0 -= var_50d23e5838bd6be8;
        var_2fb3f07a31e3c9dc -= var_10e9e1fdbbd10ab0;
    }
    
    /#
        var_5f8f0145ec31566b = getdvarint( @"hash_9e41eb34980a2301", 0 );
        
        if ( var_5f8f0145ec31566b )
        {
            print( gettime() + "<dev string:x7e>" + self getentitynumber() + "<dev string:x7e>" + self.name + "<dev string:xe4>" + var_2fb3f07a31e3c9dc );
        }
    #/
    
    return max( var_2fb3f07a31e3c9dc, 0 );
}

// Namespace playerhealth
// Params 0, eflags: 0x4
// Checksum 0xf0243b7f, Offset: 0x944
// Size: 0xa2
function private function_5a3fa7a8e145d81()
{
    assert( isplayer( self ) );
    
    if ( !isdefined( self.var_20700df5a59aee1 ) )
    {
        return 0;
    }
    
    var_458586d8905cc7b6 = 0;
    
    foreach ( delay in self.var_20700df5a59aee1 )
    {
        var_458586d8905cc7b6 += delay;
    }
    
    return var_458586d8905cc7b6;
}

// Namespace playerhealth
// Params 0, eflags: 0x4
// Checksum 0x6cc9de7a, Offset: 0x9ef
// Size: 0x110
function private function_b42dc3fb4bfbeb97()
{
    self endon( #"death_or_disconnect", #"enter_live_ragdoll" );
    
    while ( true )
    {
        self waittill( #"damage", idamage, eattacker, vhitdir, vpoint, smeansofdeath );
        
        if ( isdefined( level.var_b63e67e000417e97 ) && !self [[ level.var_b63e67e000417e97 ]]( idamage, eattacker, vhitdir, vpoint, smeansofdeath ) )
        {
            continue;
        }
        
        if ( isdefined( level.var_a7ab4a7d847b718a ) && ( !isbrgamemode() || idamage > 1 ) )
        {
            self notify( level.var_a7ab4a7d847b718a );
        }
        
        /#
            var_5f8f0145ec31566b = getdvarint( @"hash_9e41eb34980a2301", 0 );
            
            if ( var_5f8f0145ec31566b )
            {
                if ( isdefined( idamage ) )
                {
                    print( gettime() + "<dev string:x7e>" + self getentitynumber() + "<dev string:x7e>" + self.name + "<dev string:x108>" + idamage );
                }
            }
        #/
        
        thread naturalhealthregen( smeansofdeath );
    }
}

// Namespace playerhealth
// Params 5, eflags: 0x4
// Checksum 0x3a17973c, Offset: 0xb07
// Size: 0x325
function private healovertime( var_c9665e209413ca28, forcedregen = 0, naturalheal = 1, regenspeedmod = 1, options )
{
    if ( !player::isreallyalive() || self.var_f180f5a67f79ba56 )
    {
        return;
    }
    
    naturalheal = naturalheal && !self.battlerageactive && !self.laststandhealisactive;
    
    if ( naturalheal && ishealing() )
    {
        return;
    }
    
    /#
        var_5f8f0145ec31566b = getdvarint( @"hash_9e41eb34980a2301", 0 );
        
        if ( var_5f8f0145ec31566b )
        {
            print( gettime() + "<dev string:x7e>" + self getentitynumber() + "<dev string:x7e>" + self.name + "<dev string:x12a>" );
        }
    #/
    
    if ( isdefined( self.perks[ "specialty_survivor" ] ) && !self.healthregendisabled )
    {
        namespace_9d8e359c3b1041e5::activateperksharedfunc( "specialty_survivor" );
    }
    
    if ( !isdefined( self.playerhealth ) )
    {
        self.playerhealth = {};
    }
    
    if ( !isdefined( self.playerhealth.current_healing ) )
    {
        self.playerhealth.current_healing = [];
    }
    
    healing = { #options:options, #regenspeedmod:regenspeedmod, #naturalheal:naturalheal, #forcedregen:forcedregen, #var_c9665e209413ca28:var_c9665e209413ca28, #amounthealed:0, #starttime:gettime() };
    self.playerhealth.current_healing[ self.playerhealth.current_healing.size ] = healing;
    
    if ( options.var_a979d89e08fec370 )
    {
        self setclientomnvar( "ui_perk_sprint_health_regen_state", 2 );
    }
    
    var_88538c6812fb6832 = istrue( self.adrenalinepoweractive );
    starthealth = self.health;
    
    if ( level.gamemodebundle.var_e60b353ab6286751 )
    {
        thread damage_effects::function_7f61c7c682c86d02( gethealthperframe(), 1, 1 );
    }
    
    function_31abb52ed9183752( healing, var_c9665e209413ca28, forcedregen, naturalheal, regenspeedmod, options );
    
    if ( !self )
    {
        return;
    }
    
    self.playerhealth.current_healing = arrayremove( self.playerhealth.current_healing, healing );
    
    if ( self.playerhealth.current_healing.size == 0 )
    {
        self.playerhealth.current_healing = undefined;
    }
    
    if ( isdefined( self.var_2fa0b0aec130a5f1 ) )
    {
        self thread [[ level.sharedfuncs[ #"super_med_box" ][ #"hash_99bbb77633bdc9e1" ] ]]();
    }
    
    if ( options.var_a979d89e08fec370 )
    {
        self setclientomnvar( "ui_perk_sprint_health_regen_state", 1 );
    }
    
    if ( self.health >= self.maxhealth )
    {
        onfullhealth( starthealth, naturalheal, var_88538c6812fb6832, options );
        updatedeathsdoor();
        function_422b3e88b85c7745();
    }
}

// Namespace playerhealth
// Params 6, eflags: 0x4
// Checksum 0x46101922, Offset: 0xe34
// Size: 0x2a6
function private function_31abb52ed9183752( healinginstance, var_c9665e209413ca28, forcedregen, naturalheal, regenspeedmod, options )
{
    if ( var_c9665e209413ca28 )
    {
        self notify( hashcat( var_c9665e209413ca28, "_healOverTimeThink" ) );
        self endon( hashcat( var_c9665e209413ca28, "_healOverTimeThink" ) );
    }
    
    self endon( #"death_or_disconnect", #"enter_live_ragdoll" );
    damageendon = level.var_a7ab4a7d847b718a ?? #"damage";
    self endon( damageendon );
    level endon( #"game_ended" );
    fractionalhealth = 0;
    
    if ( isdefined( level.sharedfuncs[ #"bodysize" ][ #"hash_72910efb9e693a00" ] ) )
    {
        regenspeedmod *= self [[ level.sharedfuncs[ #"bodysize" ][ #"hash_72910efb9e693a00" ] ]]().healthregenratescale;
    }
    
    if ( !isdefined( self.var_e6a8138052022574 ) )
    {
        self.var_e6a8138052022574 = 1;
    }
    
    var_6abcbf9c7f325c85 = function_dad947b5395370a9( healinginstance );
    var_d5a27e324027f015 = function_d5a27e324027f015( var_6abcbf9c7f325c85, naturalheal );
    var_57d7450ef7a9c202 = isdefined( level.sharedfuncs[ #"health_chunk" ][ #"hash_bc96117656a280bf" ] ) && self [[ level.sharedfuncs[ #"health_chunk" ][ #"hash_bc96117656a280bf" ] ]]();
    
    if ( var_d5a27e324027f015 && !var_57d7450ef7a9c202 )
    {
        damage_effects::function_c0599ac395bb08c4();
    }
    
    while ( var_d5a27e324027f015 )
    {
        function_3331e0ef96880808( forcedregen );
        fractionalhealth += gethealthperframe() * regenspeedmod * self.var_e6a8138052022574;
        self.maxhealth = self.maxhealth;
        newhealth = int( clamp( fractionalhealth + self.health, 0, var_6abcbf9c7f325c85 ) );
        healedamount = newhealth - self.health;
        
        if ( healedamount > 0 )
        {
            self.health = newhealth;
            healinginstance.amounthealed += healedamount;
        }
        
        /#
            if ( getdvarint( @"scr_display_health_regen", 0 ) )
            {
                iprintln( self.name + "<dev string:x147>" + self.health );
            }
        #/
        
        function_a07d939efcfb8cf3( healedamount );
        fractionalhealth %= 1;
        
        if ( !var_57d7450ef7a9c202 )
        {
            updatedeathsdoor();
            function_422b3e88b85c7745();
        }
        
        wait 0.05;
        var_6abcbf9c7f325c85 = function_dad947b5395370a9( healinginstance );
        var_d5a27e324027f015 = function_d5a27e324027f015( var_6abcbf9c7f325c85, naturalheal );
    }
}

// Namespace playerhealth
// Params 0
// Checksum 0x732346c7, Offset: 0x10e2
// Size: 0x12b
function init()
{
    level.healthregendelayms = getmatchrulesdata( "commonOption", "healthRegen" ) * getmatchrulesdata( "commonOption", "healthRegenMultiplier" ) * 1000;
    level.healthregendisabled = level.healthregendelayms <= 0;
    level.playerhealth_regularregendelay = level.healthregendelayms;
    
    if ( !isdefined( level.var_95f549187374781d ) )
    {
        level.var_95f549187374781d = level.gametypebundle.var_1a4d63fee7069f3d;
    }
    
    if ( isusingmatchrulesdata() )
    {
        level.var_df984a778b312c7f = getmatchrulesdata( "commonOption", "deathsDoorEnterPct" );
        level.var_b487d47112fa93d = getmatchrulesdata( "commonOption", "deathsDoorExitPct" );
    }
    else
    {
        level.var_df984a778b312c7f = dvars::getoverridedvarfloatexceptmatchrulesvalues( dvars::function_1165fde71640a2d1( "deathsDoorEnterPct" ), @"hash_e4f93d764d11874d" );
        level.var_b487d47112fa93d = dvars::getoverridedvarfloatexceptmatchrulesvalues( dvars::function_1165fde71640a2d1( "deathsDoorExitPct" ), @"hash_b84edc242cc61abf" );
    }
    
    if ( !isdefined( level.var_6a872024f536a219 ) )
    {
        function_c3d7b8dc910dfe1a( 40 );
    }
    
    callback::add( #"player_spawned", &onplayerspawned );
    damage_effects_cp_mp::init();
}

// Namespace playerhealth
// Params 0
// Checksum 0x9049f218, Offset: 0x1215
// Size: 0x2b
function init_playerhealth()
{
    if ( !isdefined( level.var_6a872024f536a219 ) )
    {
        function_c3d7b8dc910dfe1a( 40 );
    }
    
    /#
        setdevdvarifuninitialized( @"hash_9e41eb34980a2301", 0 );
    #/
}

// Namespace playerhealth
// Params 1, eflags: 0x4
// Checksum 0xa575c050, Offset: 0x1248
// Size: 0x84
function private function_a07d939efcfb8cf3( healedamount )
{
    foreach ( callback in self.var_5a3853b4d19d0ad9 )
    {
        self [[ callback ]]( healedamount );
    }
}

// Namespace playerhealth
// Params 1, eflags: 0x4
// Checksum 0xf3077310, Offset: 0x12d4
// Size: 0xc0
function private onplayerspawned( params )
{
    thread manageplayerregen();
    self visionsetthermalforplayer( game[ "thermal_vision" ] );
    damage_effects_cp_mp::initdamageeffects();
    damage_effects::function_a9ae7b1d997859e9();
    
    if ( isbrgamemode() )
    {
        foreach ( squadmate in teams::getteamdata( self.team, "players" ) )
        {
            if ( squadmate != self )
            {
                function_5db69f9bfcfb4989( squadmate );
            }
        }
    }
}

// Namespace playerhealth
// Params 1, eflags: 0x4
// Checksum 0x68578212, Offset: 0x139c
// Size: 0x24
function private function_5db69f9bfcfb4989( squadmate )
{
    function_8b3862fe2f0a24e1( squadmate, squadmate.temphealth ?? 0 );
}

// Namespace playerhealth
// Params 0, eflags: 0x4
// Checksum 0xd30e2d42, Offset: 0x13c8
// Size: 0x9
function private function_cfa438ee37420701()
{
    thread function_69c47baa4505986();
}

// Namespace playerhealth
// Params 0, eflags: 0x4
// Checksum 0xaffbfce9, Offset: 0x13d9
// Size: 0x1c
function private function_a739e1b00a171073()
{
    if ( isdefined( self.var_feac7068b038689e ) )
    {
        self [[ self.var_feac7068b038689e ]]();
    }
}

// Namespace playerhealth
// Params 1, eflags: 0x4
// Checksum 0x153b4754, Offset: 0x13fd
// Size: 0x5e
function private function_3331e0ef96880808( forcedregen )
{
    if ( isdefined( self.var_1df4cb162da5b972 ) )
    {
        self [[ self.var_1df4cb162da5b972 ]]();
    }
    
    if ( isdefined( self.var_a5d6f4ed935e5707 ) && !forcedregen && self.health != self.maxhealth )
    {
        self [[ self.var_a5d6f4ed935e5707 ]]();
    }
}

/#

    // Namespace playerhealth
    // Params 0
    // Checksum 0xb18ad085, Offset: 0x1463
    // Size: 0x189, Type: dev
    function player_health_debug()
    {
        if ( getdvarint( @"nodebug", 0 ) >= 1 )
        {
            return;
        }
        
        self endon( #"disconnect" );
        self.debughealthhud = { #active:0, #var_6b3b2438ea4b7672:[] };
        
        while ( isdefined( self ) )
        {
            if ( getdvarint( @"player_debughealth" ) && !self.debughealthhud.active )
            {
                thread player_health_debug_think();
                self.debughealthhud.active = 1;
            }
            
            if ( !getdvarint( @"player_debughealth" ) && self.debughealthhud.active )
            {
                self notify( #"hash_ab96dcf28a4c5ec8" );
                
                foreach ( hudelm in self.debughealthhud.var_6b3b2438ea4b7672 )
                {
                    self.debughealthhud.var_6b3b2438ea4b7672 = arrayremove( self.debughealthhud.var_6b3b2438ea4b7672, hudelm );
                    hudelm destroy();
                }
                
                self.debughealthhud.active = 0;
            }
            
            waitframe();
        }
    }

    // Namespace playerhealth
    // Params 0
    // Checksum 0x670790ac, Offset: 0x15f4
    // Size: 0x269, Type: dev
    function player_health_debug_think()
    {
        self endon( #"hash_ab96dcf28a4c5ec8" );
        function_721cef0ad966605d( "<dev string:x150>" );
        function_721cef0ad966605d( "<dev string:x157>" );
        function_721cef0ad966605d( "<dev string:x15d>" );
        
        while ( true )
        {
            waittillframeend();
            
            if ( utility::damageflag( 2 ) )
            {
                color = ( 1, 0, 0 );
            }
            else
            {
                color = ( 0, 1, 0 );
            }
            
            self.debughealthhud.var_6b3b2438ea4b7672[ "<dev string:x150>" ] setvalue( self.health );
            self.debughealthhud.var_6b3b2438ea4b7672[ "<dev string:x150>" ].color = color;
            self.debughealthhud.var_6b3b2438ea4b7672[ "<dev string:x157>" ] setvalue( self.poise );
            self.debughealthhud.var_6b3b2438ea4b7672[ "<dev string:x157>" ].color = ( 0, 0, 1 );
            
            if ( isalive( self ) )
            {
                if ( utility::damageflag( 2 ) )
                {
                    if ( utility::damageflag( 1 ) )
                    {
                        deathshieldtime = getdeathsshieldduration();
                        self.debughealthhud.var_6b3b2438ea4b7672[ "<dev string:x15d>" ] setdevtext( "<dev string:x168>" + string( deathshieldtime ) + "<dev string:x189>" );
                        self.debughealthhud.var_6b3b2438ea4b7672[ "<dev string:x15d>" ].color = ( 0, 1, 0 );
                    }
                    else
                    {
                        deathsdoortime = getdeathsdoorduration();
                        self.debughealthhud.var_6b3b2438ea4b7672[ "<dev string:x15d>" ] setdevtext( "<dev string:x192>" + string( deathsdoortime ) + "<dev string:x189>" );
                        self.debughealthhud.var_6b3b2438ea4b7672[ "<dev string:x15d>" ].color = ( 1, 0, 0 );
                    }
                }
                else
                {
                    self.debughealthhud.var_6b3b2438ea4b7672[ "<dev string:x15d>" ] setdevtext( "<dev string:x1af>" );
                }
            }
            else
            {
                self.debughealthhud.var_6b3b2438ea4b7672[ "<dev string:x15d>" ] setdevtext( "<dev string:x1af>" );
            }
            
            waitframe();
        }
    }

    // Namespace playerhealth
    // Params 1
    // Checksum 0xde5fc679, Offset: 0x1865
    // Size: 0x112, Type: dev
    function function_721cef0ad966605d( id )
    {
        ybase = 10;
        rowspacing = 15;
        yoffset = self.debughealthhud.var_6b3b2438ea4b7672.size * rowspacing;
        hudelm = newclienthudelem( self );
        hudelm.sort = 10;
        hudelm.x = 85;
        hudelm.y = ybase + yoffset * self.debughealthhud.var_6b3b2438ea4b7672.size;
        hudelm.fontscale = 1;
        hudelm.alignx = "<dev string:x1b0>";
        hudelm.aligny = "<dev string:x1b5>";
        hudelm.horzalign = "<dev string:x1b9>";
        hudelm.vertalign = "<dev string:x1b9>";
        hudelm.sort = 1;
        self.debughealthhud.var_6b3b2438ea4b7672[ id ] = hudelm;
    }

#/

// Namespace playerhealth
// Params 2, eflags: 0x4
// Checksum 0x983b6d6a, Offset: 0x197f
// Size: 0x5a
function private regendelaytimeoutthread( var_6847c7313f966b3f, timeoutmilliseconds )
{
    level endon( #"game_ended" );
    self notify( hashcat( var_6847c7313f966b3f, "_regenDelayTimeoutThread" ) );
    self endon( hashcat( var_6847c7313f966b3f, "_regenDelayTimeoutThread" ) );
    utility::waittill_any_timeout( timeoutmilliseconds * 0.001, "death_or_disconnect" );
    function_c690215778ca5c25( var_6847c7313f966b3f );
}

// Namespace playerhealth
// Params 3
// Checksum 0x55086793, Offset: 0x19e1
// Size: 0x39
function function_e32a83bf4c298600( var_c9665e209413ca28, regenspeedmod, options )
{
    self notify( #"force_regeneration" );
    thread healovertime( var_c9665e209413ca28, 1, 0, regenspeedmod, options );
}

// Namespace playerhealth
// Params 2, eflags: 0x4
// Checksum 0x29090163, Offset: 0x1a22
// Size: 0x5a
function private regenmodifiertimeoutthread( var_6847c7313f966b3f, timeoutmilliseconds )
{
    level endon( #"game_ended" );
    self notify( hashcat( var_6847c7313f966b3f, "_regenModifierTimeoutThread" ) );
    self endon( hashcat( var_6847c7313f966b3f, "_regenModifierTimeoutThread" ) );
    utility::waittill_any_timeout( timeoutmilliseconds * 0.001, "death_or_disconnect" );
    function_b1fb4d148779580e( var_6847c7313f966b3f );
}

// Namespace playerhealth
// Params 1
// Checksum 0x5612bb2b, Offset: 0x1a84
// Size: 0x49
function function_d7d82c8b22e0a4fe( var_3605f07a4a862405 )
{
    assert( isdefined( var_3605f07a4a862405 ), "<dev string:x1c4>" );
    
    if ( !isdefined( level.var_193330891de44648 ) )
    {
        level.var_193330891de44648 = [];
    }
    
    level.var_193330891de44648[ level.var_193330891de44648.size ] = var_3605f07a4a862405;
}

// Namespace playerhealth
// Params 1
// Checksum 0xddf9531, Offset: 0x1ad5
// Size: 0x62
function function_bdfdee3e2bcb10d8( callbackfunc )
{
    if ( !isdefined( self.var_5a3853b4d19d0ad9 ) )
    {
        self.var_5a3853b4d19d0ad9 = [];
    }
    
    if ( !arraycontains( self.var_5a3853b4d19d0ad9, callbackfunc ) )
    {
        if ( !isdefined( self.var_5a3853b4d19d0ad9 ) )
        {
            self.var_5a3853b4d19d0ad9 = [];
        }
        
        self.var_5a3853b4d19d0ad9[ self.var_5a3853b4d19d0ad9.size ] = callbackfunc;
    }
}

// Namespace playerhealth
// Params 1
// Checksum 0x63d0d9e9, Offset: 0x1b3f
// Size: 0xc1
function function_10c1119ceda4e777( var_3605f07a4a862405 )
{
    assert( isdefined( var_3605f07a4a862405 ), "<dev string:x1c4>" );
    
    if ( !isdefined( level.var_193330891de44648 ) )
    {
        level.var_193330891de44648 = [];
    }
    
    foreach ( func in level.var_193330891de44648 )
    {
        if ( func == var_3605f07a4a862405 )
        {
            level.var_193330891de44648 = arrayremove( level.var_193330891de44648, var_3605f07a4a862405 );
        }
    }
}

// Namespace playerhealth
// Params 1
// Checksum 0xd6d9b04c, Offset: 0x1c08
// Size: 0x3d
function function_bb4ad93e7c8b503( callbackfunc )
{
    existingindex = function_f02c63b99c9614c9( self.var_5a3853b4d19d0ad9 ?? [], callbackfunc );
    
    if ( isdefined( existingindex ) )
    {
        self.var_5a3853b4d19d0ad9[ existingindex ] = undefined;
    }
}

// Namespace playerhealth
// Params 1
// Checksum 0xf973dcb5, Offset: 0x1c4d
// Size: 0x31d
function function_97e22750fdd64dee( var_b9d2b1b4bad64970 )
{
    if ( utility::issharedfuncdefined( #"bodysize", #"hash_72910efb9e693a00" ) )
    {
        config = utility::callsharedfunc( #"bodysize", #"hash_72910efb9e693a00" );
        var_b9d2b1b4bad64970 = int( ceil( var_b9d2b1b4bad64970 * config.healthregendelayscale ) );
    }
    
    var_9324e0a9dd513ad3 = var_b9d2b1b4bad64970;
    
    if ( !isdefined( self.regendelayspeed ) )
    {
        self.regendelayspeed = 1;
    }
    
    if ( isdefined( level.regendelayspeedfunc ) )
    {
        self.regendelayspeed = [[ level.regendelayspeedfunc ]]( self.regendelayspeed );
        
        /#
            var_5f8f0145ec31566b = getdvarint( @"hash_9e41eb34980a2301", 0 );
            
            if ( var_5f8f0145ec31566b )
            {
                print( gettime() + "<dev string:x7e>" + self getentitynumber() + "<dev string:x7e>" + self.name + "<dev string:x21e>" + self.regendelayspeed );
            }
        #/
    }
    
    if ( isdefined( self.var_dd77805de9dcde7d ) )
    {
        var_b9d2b1b4bad64970 = self.var_dd77805de9dcde7d * 1000;
        var_c11c01e620a7eebb = level.gamemodebundle.var_a3629526fb6c00e1 ?? 0;
        regenscalar = max( 2 - function_8e01852aacc4a944() - self.regendelayspeed, var_c11c01e620a7eebb );
        var_b9d2b1b4bad64970 *= regenscalar;
    }
    else if ( isdefined( self.var_2fa0b0aec130a5f1 ) )
    {
        var_b9d2b1b4bad64970 = ceil( var_9324e0a9dd513ad3 * self.var_2fa0b0aec130a5f1 );
    }
    else if ( isdefined( self.var_6766e63f66e2b11c ) )
    {
        var_b9d2b1b4bad64970 = ceil( var_9324e0a9dd513ad3 * self.var_6766e63f66e2b11c );
    }
    else if ( isdefined( self.var_25bf7beec81510cb ) )
    {
        var_b9d2b1b4bad64970 = ceil( var_9324e0a9dd513ad3 * self.var_25bf7beec81510cb );
    }
    else
    {
        var_c11c01e620a7eebb = level.gamemodebundle.var_a3629526fb6c00e1 ?? 0;
        regenscalar = max( 2 - function_8e01852aacc4a944() - self.regendelayspeed, var_c11c01e620a7eebb );
        
        if ( isdefined( level.var_845b45f01d427c37 ) && isdefined( self.perks[ "specialty_elasomer_pads" ] ) )
        {
            regenscalar *= level.var_845b45f01d427c37;
        }
        
        if ( isdefined( level.healthregendelayms ) )
        {
            var_b9d2b1b4bad64970 = ceil( level.healthregendelayms * regenscalar );
        }
        else if ( isdefined( self.gs.healthregendelay ) )
        {
            var_b9d2b1b4bad64970 = self.gs.healthregendelay * 1000 * regenscalar;
        }
        else
        {
            var_b9d2b1b4bad64970 = ceil( 5000 * regenscalar );
        }
        
        if ( getdvarint( @"scr_override_health_regen_delay_ms", -1 ) > 0 )
        {
            regendelayoverride = getdvarint( @"scr_override_health_regen_delay_ms", -1 );
            var_b9d2b1b4bad64970 = ceil( regendelayoverride * regenscalar );
        }
        
        if ( !isdefined( self.var_6e8d4ecf936120c ) )
        {
            self.var_6e8d4ecf936120c = 1;
        }
        
        var_b9d2b1b4bad64970 *= self.var_6e8d4ecf936120c;
        
        if ( isdefined( self.var_2dee1a7166e0cdae ) )
        {
            var_b9d2b1b4bad64970 *= self.var_2dee1a7166e0cdae;
        }
    }
    
    return var_b9d2b1b4bad64970;
}

// Namespace playerhealth
// Params 1
// Checksum 0xcfcf17a4, Offset: 0x1f73
// Size: 0x28
function function_c3d7b8dc910dfe1a( var_6a872024f536a219 )
{
    level.var_6a872024f536a219 = var_6a872024f536a219;
    level.var_6c2d489f9cc9f171 = var_6a872024f536a219 * 0.05;
}

// Namespace playerhealth
// Params 0, eflags: 0x4
// Checksum 0x1acf8c6, Offset: 0x1fa3
// Size: 0x141
function private function_6138636f20e23f2e()
{
    if ( isdefined( self.var_2fa0b0aec130a5f1 ) )
    {
        if ( !self.var_34ef1f0b170c89ce )
        {
            self thread [[ level.sharedfuncs[ #"super_med_box" ][ #"hash_99bbb77633bdc9e1" ] ]]();
            self thread [[ level.sharedfuncs[ #"super_med_box" ][ #"hash_215504b71852c2e7" ] ]]();
        }
        else
        {
            self thread [[ level.sharedfuncs[ #"super_med_box" ][ #"hash_215504b71852c2e7" ] ]]();
        }
    }
    else if ( isdefined( self.medboxhealed ) )
    {
        self thread [[ level.sharedfuncs[ #"super_med_box" ][ #"hash_99bbb77633bdc9e1" ] ]]();
    }
    
    /#
        var_5f8f0145ec31566b = getdvarint( @"hash_9e41eb34980a2301", 0 );
        
        if ( var_5f8f0145ec31566b )
        {
            print( gettime() + "<dev string:x7e>" + self getentitynumber() + "<dev string:x7e>" + self.name + "<dev string:x25e>" );
        }
    #/
    
    while ( self.healthregendisabled || !val::get( "health_regen" ) || self.var_d70dae05b0831219 )
    {
        waitframe();
    }
    
    self.var_ff0ca47e67c7854b = gettime();
    thread function_69c47baa4505986();
}

// Namespace playerhealth
// Params 2, eflags: 0x4
// Checksum 0x34962ce5, Offset: 0x20ec
// Size: 0x134
function private function_8b3862fe2f0a24e1( player, temphealth )
{
    if ( !isdefined( player ) || !isdefined( temphealth ) )
    {
        return;
    }
    
    squadindex = player.sessionuimemberindex;
    
    if ( squadindex == -1 )
    {
        squadindex = player.var_64f4581741c21af7;
    }
    
    if ( !isdefined( squadindex ) )
    {
        return;
    }
    
    defaultmaxhealth = level.var_c5f79b69dee05dec;
    
    if ( !isdefined( defaultmaxhealth ) || abs( defaultmaxhealth ) < 0.0001 )
    {
        defaultmaxhealth = 1;
    }
    
    var_b803e97722b6ed19 = clamp( temphealth / defaultmaxhealth, 0, 1 );
    teammates = teams::getteamdata( player.team, "players" );
    
    foreach ( teammate in teammates )
    {
        teammate setclientomnvar( "ui_temp_health_ratio_squad_index_" + squadindex, var_b803e97722b6ed19 );
    }
}

// Namespace playerhealth
// Params 2
// Checksum 0x8d7ce0d, Offset: 0x2228
// Size: 0x111
function function_ed81022bf9702b0a( player, temphealth )
{
    if ( !getdvarint( @"hash_dc32c11f3de5ca09", 1 ) )
    {
        return;
    }
    
    if ( temphealth <= 0 )
    {
        return;
    }
    
    if ( !level.var_c5f79b69dee05dec )
    {
        damage::function_e91c31c1d200656d( &function_258a7fdb81b318ba );
        damage::function_6d459163ecf4555d( &function_fa70864c4a05297a );
    }
    
    if ( !isdefined( level.var_c5f79b69dee05dec ) )
    {
        level.var_c5f79b69dee05dec = player.maxhealth;
    }
    
    if ( player.temphealth >= temphealth )
    {
        return;
    }
    
    if ( !player.temphealth )
    {
        player callback::add( #"player_damaged", &function_de998ef7ce15542 );
    }
    
    player.maxhealth = level.var_c5f79b69dee05dec + temphealth;
    player.temphealth = temphealth;
    player setclientomnvar( "ui_br_player_temp_health", int( floor( temphealth ) ) );
    player setclientomnvar( "ui_br_player_max_temp_health", int( floor( temphealth ) ) );
    
    if ( isbrgamemode() )
    {
        function_8b3862fe2f0a24e1( player, temphealth );
    }
}

// Namespace playerhealth
// Params 1, eflags: 0x4
// Checksum 0xb860f563, Offset: 0x2341
// Size: 0x42
function private function_fa70864c4a05297a( params )
{
    if ( !params.victim.temphealth )
    {
        return params.idflags;
    }
    
    return params.idflags | 134217728;
}

// Namespace playerhealth
// Params 2, eflags: 0x4
// Checksum 0x449361e8, Offset: 0x238c
// Size: 0x40
function private function_258a7fdb81b318ba( hittype, params )
{
    if ( hittype != "standard" )
    {
        return;
    }
    
    if ( !params.victim.temphealth )
    {
        return;
    }
    
    return "hittemphealth";
}

// Namespace playerhealth
// Params 1
// Checksum 0xf5641a08, Offset: 0x23d5
// Size: 0xdf
function function_de998ef7ce15542( params )
{
    self.temphealth -= params.idamage;
    self setclientomnvar( "ui_br_player_temp_health", int( floor( max( self.temphealth, 0 ) ) ) );
    
    if ( isbrgamemode() )
    {
        function_8b3862fe2f0a24e1( self, self.temphealth );
    }
    
    if ( self.temphealth <= 0 )
    {
        self.temphealth = undefined;
        self.maxhealth = level.var_c5f79b69dee05dec;
        callback::remove( #"player_damaged", &function_de998ef7ce15542 );
        self setclientomnvar( "ui_br_player_max_temp_health", 0 );
        return;
    }
    
    self.maxhealth -= min( self.maxhealth - 1, params.idamage );
}

// Namespace playerhealth
// Params 3
// Checksum 0x8fcc652d, Offset: 0x24bc
// Size: 0x4d
function function_2e811cdf4da0ed04( var_6847c7313f966b3f, var_c636c7b82f91692e, var_90a4457ecdccb37 )
{
    var_6847c7313f966b3f = getxhash( var_6847c7313f966b3f );
    result = function_de992c905ef699ed( var_6847c7313f966b3f, var_c636c7b82f91692e );
    
    if ( isdefined( var_90a4457ecdccb37 ) )
    {
        thread regendelaytimeoutthread( var_6847c7313f966b3f, var_90a4457ecdccb37 );
    }
    
    return result;
}

// Namespace playerhealth
// Params 2, eflags: 0x4
// Checksum 0xc74c684d, Offset: 0x2512
// Size: 0x7a, Type: bool
function private function_de992c905ef699ed( var_6847c7313f966b3f, var_c636c7b82f91692e )
{
    assert( isdefined( var_6847c7313f966b3f ) );
    assert( isfloat( var_c636c7b82f91692e ) );
    assert( isplayer( self ) );
    
    if ( !isdefined( self.var_20700df5a59aee1 ) )
    {
        self.var_20700df5a59aee1 = [];
    }
    
    if ( isdefined( self.var_20700df5a59aee1[ var_6847c7313f966b3f ] ) )
    {
        return false;
    }
    
    self.var_20700df5a59aee1[ var_6847c7313f966b3f ] = var_c636c7b82f91692e;
    function_cfa438ee37420701();
    return true;
}

// Namespace playerhealth
// Params 3
// Checksum 0x2fceb27d, Offset: 0x2595
// Size: 0x4d
function function_fd91e6d94cab77e7( var_6847c7313f966b3f, var_3fb8036bd24c0c51, var_90a4457ecdccb37 )
{
    var_6847c7313f966b3f = getxhash( var_6847c7313f966b3f );
    result = function_1c09d41102918c3e( var_6847c7313f966b3f, var_3fb8036bd24c0c51 );
    
    if ( isdefined( var_90a4457ecdccb37 ) )
    {
        thread regenmodifiertimeoutthread( var_6847c7313f966b3f, var_90a4457ecdccb37 );
    }
    
    return result;
}

// Namespace playerhealth
// Params 2, eflags: 0x4
// Checksum 0xab0c2a88, Offset: 0x25eb
// Size: 0xe1, Type: bool
function private function_1c09d41102918c3e( var_6847c7313f966b3f, var_3fb8036bd24c0c51 )
{
    assert( isdefined( var_6847c7313f966b3f ) );
    assert( isfloat( var_3fb8036bd24c0c51 ) );
    assert( isplayer( self ) );
    
    if ( !isdefined( self.var_20856856a4b63054 ) )
    {
        self.var_20856856a4b63054 = [];
    }
    
    if ( isdefined( self.var_20856856a4b63054[ var_6847c7313f966b3f ] ) )
    {
        return false;
    }
    else
    {
        self.var_20856856a4b63054[ var_6847c7313f966b3f ] = var_3fb8036bd24c0c51;
        
        /#
            var_5f8f0145ec31566b = getdvarint( @"hash_9e41eb34980a2301", 0 );
            
            if ( var_5f8f0145ec31566b )
            {
                print( gettime() + "<dev string:x7e>" + self getentitynumber() + "<dev string:x7e>" + self.name + "<dev string:x286>" + ( isxhash( var_6847c7313f966b3f ) ? getxhashsourcename( var_6847c7313f966b3f ) : var_6847c7313f966b3f ) );
            }
        #/
        
        function_cfa438ee37420701();
        return true;
    }
    
    return false;
}

// Namespace playerhealth
// Params 0
// Checksum 0xe32ff77e, Offset: 0x26d5
// Size: 0x23
function function_3b68d99b4a5f15e3()
{
    if ( isdefined( self.var_ff0ca47e67c7854b ) )
    {
        return function_77704251ecdece64( self.var_ff0ca47e67c7854b );
    }
    
    return;
}

// Namespace playerhealth
// Params 1
// Checksum 0x8875ea45, Offset: 0x2700
// Size: 0x59, Type: bool
function function_c690215778ca5c25( var_6847c7313f966b3f )
{
    assert( isdefined( var_6847c7313f966b3f ) );
    assert( isplayer( self ) );
    var_6847c7313f966b3f = getxhash( var_6847c7313f966b3f );
    
    if ( !( isdefined( self ) && isdefined( self.var_20700df5a59aee1[ var_6847c7313f966b3f ] ) ) )
    {
        return false;
    }
    
    self.var_20700df5a59aee1[ var_6847c7313f966b3f ] = undefined;
    function_cfa438ee37420701();
    return true;
}

// Namespace playerhealth
// Params 1
// Checksum 0x80e36bb0, Offset: 0x2762
// Size: 0xd8, Type: bool
function function_b1fb4d148779580e( var_6847c7313f966b3f )
{
    assert( isdefined( var_6847c7313f966b3f ) );
    assert( isplayer( self ) );
    
    if ( !( isdefined( self ) && isdefined( self.var_20856856a4b63054 ) ) )
    {
        return false;
    }
    
    var_6847c7313f966b3f = getxhash( var_6847c7313f966b3f );
    
    if ( isdefined( self.var_20856856a4b63054[ var_6847c7313f966b3f ] ) )
    {
        self.var_20856856a4b63054[ var_6847c7313f966b3f ] = undefined;
        
        /#
            var_5f8f0145ec31566b = getdvarint( @"hash_9e41eb34980a2301", 0 );
            
            if ( var_5f8f0145ec31566b )
            {
                print( gettime() + "<dev string:x7e>" + self getentitynumber() + "<dev string:x7e>" + self.name + "<dev string:x2b1>" + ( isxhash( var_6847c7313f966b3f ) ? getxhashsourcename( var_6847c7313f966b3f ) : var_6847c7313f966b3f ) );
            }
        #/
        
        self notify( hashcat( var_6847c7313f966b3f, "_end" ) );
        function_cfa438ee37420701();
        return true;
    }
    
    return false;
}

// Namespace playerhealth
// Params 1
// Checksum 0x9aea928e, Offset: 0x2843
// Size: 0x9a
function updatedeathsdoor( smeansofdeath )
{
    healthratio = self.health / self.maxhealth;
    
    if ( healthratio > self.var_b487d47112fa93d && !self.inlaststand )
    {
        damage_effects::onexitdeathsdoor( 1 );
    }
    
    if ( ( healthratio <= self.var_df984a778b312c7f || self.inlaststand ) && !utility::isusingremote() && !self.ignoredeathsdoor && !ishealing() )
    {
        damage_effects::onenterdeathsdoor( smeansofdeath );
    }
}

// Namespace playerhealth
// Params 0
// Checksum 0xe436c7c4, Offset: 0x28e5
// Size: 0x59
function function_422b3e88b85c7745()
{
    if ( self.health < self.maxhealth && !ishealing() && !damage_effects::isdeathsdoor() && !self.damage.var_afe3644f2b88911 )
    {
        damage_effects::function_ab7f2385c14d2139( 1 );
        return;
    }
    
    damage_effects::function_a19591252686e9dd();
}

// Namespace playerhealth
// Params 0, eflags: 0xc
// Checksum 0x5b979494, Offset: 0x2946
// Size: 0x10e
function private function_69c47baa4505986()
{
    self notify( #"hash_268ac2b84c917985" );
    self endon( #"hash_268ac2b84c917985" );
    
    if ( !isdefined( self.var_ff0ca47e67c7854b ) )
    {
        return;
    }
    
    self endon( #"death_or_disconnect", #"enter_live_ragdoll" );
    self.var_264be95670df90e3 = function_77704251ecdece64( self.var_ff0ca47e67c7854b );
    wait self.var_264be95670df90e3 * 0.001;
    
    if ( level.gametype == "dungeons" )
    {
        while ( utility::damageflag( 2 ) )
        {
            waitframe();
        }
    }
    
    /#
        var_5f8f0145ec31566b = getdvarint( @"hash_9e41eb34980a2301", 0 );
        
        if ( var_5f8f0145ec31566b )
        {
            print( gettime() + "<dev string:x7e>" + self getentitynumber() + "<dev string:x7e>" + self.name + "<dev string:x2d7>" );
        }
    #/
    
    self.var_264be95670df90e3 = undefined;
    self.var_ff0ca47e67c7854b = undefined;
    
    if ( self.health < self.maxhealth )
    {
        thread healovertime( #"regeneration" );
    }
}

// Namespace playerhealth
// Params 1
// Checksum 0x698bd2ea, Offset: 0x2a5c
// Size: 0x7f
function function_284cd76924b8c5ae( player )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    damagenotify = level.var_a7ab4a7d847b718a ?? #"damage";
    player utility::waittill_any( #"death", damagenotify, #"force_regeneration", #"hash_6752b3d195492f9e", #"healed", #"naturalhealthregen", #"vampirism", #"spawned_player" );
}

// Namespace playerhealth
// Params 0
// Checksum 0xb3d73cf0, Offset: 0x2ae3
// Size: 0x18, Type: bool
function ishealing()
{
    return self.playerhealth.current_healing.size > 0;
}

// Namespace playerhealth
// Params 0
// Checksum 0x8810e765, Offset: 0x2b04
// Size: 0x9d
function manageplayerregen()
{
    self.deathsdoor = 0;
    self.deathsdoorsfx = 0;
    self.hasdonepainbreathloopthislife = 0;
    self.poisehealing = 0;
    self.var_b487d47112fa93d = level.var_b487d47112fa93d;
    self.var_df984a778b312c7f = level.var_df984a778b312c7f;
    self stoplocalsound( #"deaths_door_out" );
    self stoplocalsound( #"deaths_door_in" );
    thread damage_effects::function_e8cba6f10a4635e9();
    thread function_b42dc3fb4bfbeb97();
    utility::callsharedfunc( #"poise", #"hash_44bd8927cbac7543" );
    
    /#
        thread player_health_debug();
    #/
}

// Namespace playerhealth
// Params 1, eflags: 0x4
// Checksum 0x7317f369, Offset: 0x2ba9
// Size: 0x11a
function private naturalhealthregen( smeansofdeath )
{
    /#
        var_5f8f0145ec31566b = getdvarint( @"hash_9e41eb34980a2301", 0 );
        
        if ( var_5f8f0145ec31566b )
        {
            print( gettime() + "<dev string:x7e>" + self getentitynumber() + "<dev string:x7e>" + self.name + "<dev string:x2fd>" );
        }
    #/
    
    if ( !player::isreallyalive( self ) )
    {
        return;
    }
    
    if ( level.healthregendisabled )
    {
        return;
    }
    
    self.var_ff0ca47e67c7854b = undefined;
    self.var_264be95670df90e3 = undefined;
    self notify( #"naturalhealthregen" );
    self endon( #"naturalhealthregen", #"death_or_disconnect", #"enter_live_ragdoll" );
    level endon( #"game_ended" );
    
    while ( level.healthregendisabled && utility::isusingremote() )
    {
        waitframe();
    }
    
    updatedeathsdoor( smeansofdeath );
    function_422b3e88b85c7745();
    
    if ( self.explosiveregenhaltactive )
    {
        utility::waittill_notify_or_timeout( "end_explosiveRegenHalt", self.var_1bf40eeb0eeec0f4 );
        self notify( #"end_explosiveregenhalt" );
    }
    
    function_6138636f20e23f2e();
}

// Namespace playerhealth
// Params 4
// Checksum 0xc05961da, Offset: 0x2ccb
// Size: 0x478
function onfullhealth( starthealth, var_f0a7eb31a76581b3, var_88538c6812fb6832, options )
{
    function_a739e1b00a171073();
    self notify( #"healed" );
    level notify( #"healed", self );
    amounthealed = self.health - starthealth;
    
    if ( var_88538c6812fb6832 )
    {
        damage::combatrecordtacticalstat( "equip_adrenaline", amounthealed );
        
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
        {
            if ( isdefined( self.leaderboarddata[ "stimDamageHealed" ] ) )
            {
                self.leaderboarddata[ "stimDamageHealed" ] = self.leaderboarddata[ "stimDamageHealed" ] + amounthealed;
            }
            
            if ( isdefined( level.leaderboardfunc[ "stimDamageHealed" ] ) )
            {
                [[ level.leaderboardfunc[ "stimDamageHealed" ] ]]( self, amounthealed );
            }
            
            assert( isint( amounthealed ) || isfloat( amounthealed ), "<dev string:x320>" );
            
            if ( isdefined( self.pers[ "stimDamageHealed" ] ) )
            {
                self.pers[ "stimDamageHealed" ] = self.pers[ "stimDamageHealed" ] + amounthealed;
            }
        }
        
        analyticslog::logevent_playerhealed( self, amounthealed, self );
        callback::callback( "on_heal_done", { #amounthealed:amounthealed, #player:self } );
    }
    
    if ( isdefined( self.pers[ "damageHealed" ] ) )
    {
        if ( !( istrue( game[ "practiceRound" ] ) || istrue( level.disablestattracking ) || isagent( self ) ) )
        {
            if ( isdefined( self.leaderboarddata[ "damageHealed" ] ) )
            {
                self.leaderboarddata[ "damageHealed" ] = self.leaderboarddata[ "damageHealed" ] + amounthealed;
            }
            
            if ( isdefined( level.leaderboardfunc[ "damageHealed" ] ) )
            {
                [[ level.leaderboardfunc[ "damageHealed" ] ]]( self, amounthealed );
            }
            
            assert( isint( amounthealed ) || isfloat( amounthealed ), "<dev string:x320>" );
            
            if ( isdefined( self.pers[ "damageHealed" ] ) )
            {
                self.pers[ "damageHealed" ] = self.pers[ "damageHealed" ] + amounthealed;
            }
        }
    }
    
    if ( var_f0a7eb31a76581b3 && !options.nobattlechatter )
    {
        level thread battlechatter_mp::trysaylocalsound( self, #"bc_status_player_recover" );
    }
    
    if ( options.var_a979d89e08fec370 )
    {
        self setclientomnvar( "ui_perk_sprint_health_regen_state", 0 );
    }
    
    if ( isdefined( self.callbacks[ #"hash_42a51c712c475d6" ] ) || isdefined( level.callbacks[ #"hash_42a51c712c475d6" ] ) )
    {
        params = { #maxhealth:self.health, #var_f0a7eb31a76581b3:var_f0a7eb31a76581b3, #weaponobj:self getcurrentprimaryweapon() };
        callback::callback( #"hash_42a51c712c475d6", params );
    }
    
    if ( level.gamemodebundle.var_7bd25e2787349232 )
    {
        if ( !self.inlaststand && !self ismeatshieldvictim() && !self isinexecutionvictim() )
        {
            damage_effects::function_a9ae7b1d997859e9();
        }
    }
    else
    {
        thread damage_effects::removeoldattackersovertime();
    }
    
    if ( !level.gameended && !utility::isusingremote() )
    {
        if ( level.gamemodebundle.var_9fca605755fb380a == #"hash_6b808ce6a5a4ce47" )
        {
            if ( amounthealed > 30 )
            {
                self playlocalsound( operator::isfemale() ? #"Fem_breathing_better" : #"breathing_better" );
            }
            else if ( amounthealed > 5 )
            {
                self playlocalsound( operator::isfemale() ? #"fem_breathing_better_light" : #"breathing_better_light" );
            }
        }
        else
        {
            self playlocalsound( operator::isfemale() ? #"Fem_breathing_better" : #"breathing_better" );
        }
    }
    
    utility::callsharedfunc( #"helmet", #"hash_d62d9d829b13dfb0", self );
    
    /#
        var_5f8f0145ec31566b = getdvarint( @"hash_9e41eb34980a2301", 0 );
        
        if ( var_5f8f0145ec31566b )
        {
            print( gettime() + "<dev string:x7e>" + self getentitynumber() + "<dev string:x7e>" + self.name + "<dev string:x346>" + amounthealed );
        }
    #/
}

// Namespace playerhealth
// Params 2, eflags: 0x4
// Checksum 0x7d5c43ea, Offset: 0x314b
// Size: 0x4f, Type: bool
function private function_d5a27e324027f015( var_6abcbf9c7f325c85, naturalheal )
{
    return self.health < var_6abcbf9c7f325c85 && !self isspectatinganyone() && val::get( "health_regen" ) && ( !self.healthregendisabled || !naturalheal );
}

// Namespace playerhealth
// Params 1
// Checksum 0x29b49930, Offset: 0x31a3
// Size: 0x32
function function_5be24c25b7e649ba( disabled = 1 )
{
    self.damage.var_afe3644f2b88911 = disabled;
    function_422b3e88b85c7745();
}

// Namespace playerhealth
// Params 4
// Checksum 0xf89fb4b2, Offset: 0x31dd
// Size: 0x5c
function forcehealthregen( player, naturalheal = 0, regenspeedmod, options )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player notify( #"force_regeneration" );
    player thread healovertime( #"regeneration", 1, naturalheal, regenspeedmod, options );
}

// Namespace playerhealth
// Params 5
// Checksum 0xabce7d67, Offset: 0x3241
// Size: 0x93
function forcehealthregendelay( player, naturalheal = 0, time = 1, regenspeedmod, options )
{
    if ( !isdefined( player ) )
    {
        return;
    }
    
    player endon( #"death_or_disconnect", #"enter_live_ragdoll", #"healovertimethink" );
    wait time;
    player notify( #"force_regeneration" );
    player thread healovertime( #"regeneration", 1, naturalheal, regenspeedmod, options );
}

// Namespace playerhealth
// Params 0
// Checksum 0x231cf8b9, Offset: 0x32dc
// Size: 0x15
function getdeathsdoorduration()
{
    return self.gs.deathsdoorduration;
}

// Namespace playerhealth
// Params 0
// Checksum 0x6424f905, Offset: 0x32fa
// Size: 0x29
function getdeathsshieldduration()
{
    return self.gs.invultime_deathshieldduration * self.gs.scripteddeathshielddurationscale;
}

// Namespace playerhealth
// Params 0
// Checksum 0x4659dbf9, Offset: 0x332c
// Size: 0x17, Type: bool
function function_818fe7b2394cad59()
{
    return level.var_c5f79b69dee05dec ?? self.maxhealth;
}

// Namespace playerhealth
// Params 0
// Checksum 0xa4ec9511, Offset: 0x334c
// Size: 0x191
function getgametypehealthperframe()
{
    var_323216367db74545 = getdvarint( @"scr_override_health_regen_per_sec", 0 );
    
    if ( var_323216367db74545 > 0 )
    {
        healthperframe = var_323216367db74545 * 0.05;
    }
    else
    {
        healthperframe = level.var_6c2d489f9cc9f171;
    }
    
    if ( self.battlerageactive && getdvarint( @"hash_dc1416e8c8672f24", 0 ) )
    {
        if ( isdefined( level.sharedfuncs[ #"battlerage" ][ #"hash_180f842b74797065" ] ) )
        {
            var_8ef9d8b1e5be9bea = [[ level.sharedfuncs[ #"battlerage" ][ #"hash_180f842b74797065" ] ]]() * 0.05;
        }
        
        healthperframe = max( var_8ef9d8b1e5be9bea ?? 0, healthperframe );
    }
    
    if ( self.adrenalinepoweractive )
    {
        if ( isdefined( level.sharedfuncs[ #"adrenaline" ][ #"hash_180f842b74797065" ] ) )
        {
            var_8ef9d8b1e5be9bea = [[ level.sharedfuncs[ #"adrenaline" ][ #"hash_180f842b74797065" ] ]]() * 0.05;
        }
        
        healthperframe = max( var_8ef9d8b1e5be9bea ?? 0, healthperframe );
    }
    else if ( isdefined( self.perks[ "specialty_regenfaster" ] ) )
    {
        healthperframe *= level.regenfasterhealthmod;
    }
    
    if ( isdefined( level.sharedfuncs[ #"gametype" ][ #"hash_600fd2dcca71f7b3" ] ) )
    {
        healthperframe = [[ level.sharedfuncs[ #"gametype" ][ #"hash_600fd2dcca71f7b3" ] ]]( healthperframe );
    }
    
    return healthperframe;
}

