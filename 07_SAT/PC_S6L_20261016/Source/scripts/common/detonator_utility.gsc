// scripts\common\detonator_utility.gsc  (hash_1f948629cd086cc3.gscc) (size: 8136 Bytes / 0x1fc8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xab02a97e (2869078398)
// size ...... 8136 (0x1fc8)
// includes .. 4   (offset: 0x1eec)
// strings ... 11  (offset: 0x1f0c)
// dev strs .. 3   (offset: 0x1fa4)
// exports ... 25  (offset: 0x13ac)
// cseg ...... 0x126 + 0x1286 (0x13ac)
// imports ... 61  (offset: 0x1794)
// animtree1 . 0   (offset: 0x1fc8)
// animtree2 . 0   (offset: 0x1fc8)
#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\weapon;

#namespace detonator_utility;

// Namespace detonator_utility
// Params 5
// Checksum 0xa8b9d859, Offset: 0x144
// Size: 0x9c
function init( bundle, equipmentname, mine, var_e5a3283424815494, explodefunc )
{
    if ( !bundle.hasdetonator )
    {
        return;
    }
    
    if ( !isdefined( bundle.equipmentref ) )
    {
        bundle.equipmentref = equipmentname;
    }
    
    function_4a0836279bc3967c( equipmentname, mine.owner, mine );
    function_5149e5089db322ec( bundle, 0 );
    function_43043de6eb9207a1( bundle, explodefunc );
    thread watchForDetonation( bundle, mine, equipmentname, var_e5a3283424815494 );
    mine thread explodeonnotify();
}

// Namespace detonator_utility
// Params 4
// Checksum 0x691038f4, Offset: 0x1e8
// Size: 0xdb
function watchForDetonation( bundle, mine, equipmentname, var_e5a3283424815494 )
{
    self endon( #"death_or_disconnect" );
    var_ce86bbddf98563d2 = 0;
    
    if ( utility::issharedfuncdefined( #"game", #"isCommonItemEnabled" ) )
    {
        var_ce86bbddf98563d2 = [[ utility::getsharedfunc( #"game", #"isCommonItemEnabled" ) ]]();
    }
    
    if ( isdefined( level.itemsisenabled ) )
    {
        var_ce86bbddf98563d2 = [[ level.itemsisenabled ]]();
    }
    
    self notify( hashcat( #"watchfordetonation", equipmentname ) );
    var_ac41aa783740250c = var_e5a3283424815494 ?? function_c0263ea762998698( equipmentname );
    thread function_664d0527ed7f3430( bundle, equipmentname, var_ac41aa783740250c, var_ce86bbddf98563d2 );
    function_96e231e5e5c8d68( bundle, equipmentname, var_ce86bbddf98563d2 );
    thread watchforaltdetonation( bundle );
}

// Namespace detonator_utility
// Params 1
// Checksum 0xb734247d, Offset: 0x2cb
// Size: 0xc0
function function_c0263ea762998698( equipmentname )
{
    if ( level.var_b8686b90947d6097 )
    {
        slot = utility::callsharedfunc( #"equipment", #"findequipmentslot", equipmentname );
        
        switch ( slot )
        {
            case #"hash_325cb2e66f67d5b9":
                return "+frag";
            case #"hash_511d3c24fcedcdb1":
                return "+smoke";
            case #"hash_a7832978dd2b6523":
                return "+special";
            default:
                assertmsg( "<dev string:x24>" + slot + "<dev string:x35>" + equipmentname );
                break;
        }
    }
    
    if ( weapon::isequipmentprimary( equipmentname ) )
    {
        return "+frag";
    }
    
    return "+smoke";
}

// Namespace detonator_utility
// Params 4
// Checksum 0xd70dbb87, Offset: 0x393
// Size: 0x1d8
function function_664d0527ed7f3430( bundle, equipmentname, var_ac41aa783740250c, var_ce86bbddf98563d2 )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    self endon( "watchForDetonation" + equipmentname );
    
    if ( !var_ce86bbddf98563d2 )
    {
        self endon( "equipment_taken_" + equipmentname );
    }
    
    var_64e528f2ebeb492d = hashcat( #"give_", equipmentname, "_detonator" );
    
    while ( true )
    {
        if ( var_ac41aa783740250c == "+special" )
        {
            childthread utility::callsharedfunc( #"supers", #"hash_7539ea2b0ba9b967" );
            childthread utility::callsharedfunc( #"supers", #"hash_5f9f3719cc732dd9" );
            childthread utility::callsharedfunc( #"supers", #"hash_eb21ce00d0d2a9ba" );
            self waittill( #"hash_5094f25fe1ca906a", msg );
            currentammo = utility::callsharedfunc( #"equipment", #"getequipmentammo", equipmentname );
            
            if ( validdetonationstate() && !self isgestureplaying() && currentammo == 0 )
            {
                result = function_738c85af66c1aa23( bundle, equipmentname, bundle.var_3919cb6ba09d0e0b );
                
                if ( result )
                {
                    thread utility::callsharedfunc( #"supers", #"hash_9ab85ffac4b7745d" );
                }
            }
            
            continue;
        }
        
        self notifyonplayercommand( var_64e528f2ebeb492d, var_ac41aa783740250c );
        self waittill( var_64e528f2ebeb492d );
        currentammo = utility::callsharedfunc( #"equipment", #"getequipmentammo", equipmentname );
        
        if ( validdetonationstate() && !self isgestureplaying() && currentammo == 0 )
        {
            result = function_738c85af66c1aa23( bundle, equipmentname, bundle.var_3919cb6ba09d0e0b );
            
            if ( result )
            {
                self notifyonplayercommandremove( var_64e528f2ebeb492d, var_ac41aa783740250c );
            }
        }
    }
}

// Namespace detonator_utility
// Params 3
// Checksum 0xeb174e1b, Offset: 0x573
// Size: 0xd1
function function_96e231e5e5c8d68( bundle, equipmentname, var_ce86bbddf98563d2 )
{
    if ( !isdefined( self.var_4373fe41dbc0ba05 ) )
    {
        self.var_4373fe41dbc0ba05 = [];
    }
    
    self.var_4373fe41dbc0ba05[ equipmentname ] = spawnstruct();
    self.var_4373fe41dbc0ba05[ equipmentname ].bundle = bundle;
    self.var_4373fe41dbc0ba05[ equipmentname ].var_ce86bbddf98563d2 = var_ce86bbddf98563d2;
    self.var_4373fe41dbc0ba05[ equipmentname ].var_433a0585b11c3d96 = bundle.var_1ea3eafb58d1abb6 ?? #"use_button";
    self.var_4373fe41dbc0ba05[ equipmentname ].var_48c62b5bfef89fd6 = bundle.var_beeb7ee5ca692515 ?? #"detonate_all";
}

// Namespace detonator_utility
// Params 1
// Checksum 0xb408c9ba, Offset: 0x64c
// Size: 0x139
function watchforaltdetonation( bundle )
{
    self notify( #"hash_e79e30d82fb33158" );
    self endon( #"hash_e79e30d82fb33158" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    
    while ( self usebuttonpressed() )
    {
        waitframe();
    }
    
    while ( true )
    {
        if ( !function_ea10eada926d1f92() )
        {
            waitframe();
            continue;
        }
        
        var_433a0585b11c3d96 = #"use_button";
        var_d565b40120cea137 = [];
        
        foreach ( equipname, data in self.var_4373fe41dbc0ba05 )
        {
            if ( data.var_433a0585b11c3d96 == var_433a0585b11c3d96 )
            {
                var_d565b40120cea137 = arraycombineunique( var_d565b40120cea137, function_c330504fd4a3f502( data.var_48c62b5bfef89fd6, equipname ) );
            }
        }
        
        if ( validdetonationstate() && !self isgestureplaying() )
        {
            function_738c85af66c1aa23( bundle, undefined, undefined, var_d565b40120cea137 );
        }
        
        waitframe();
    }
}

// Namespace detonator_utility
// Params 0
// Checksum 0x6409c5c5, Offset: 0x78d
// Size: 0x84, Type: bool
function function_ea10eada926d1f92()
{
    buttontime = 0;
    updaterate = level.framedurationseconds;
    
    if ( !self usebuttonpressed() )
    {
        return false;
    }
    
    buttontime = 0;
    
    while ( self usebuttonpressed() )
    {
        buttontime += updaterate;
        wait updaterate;
    }
    
    if ( buttontime >= 0.5 )
    {
        return false;
    }
    
    buttontime = 0;
    
    while ( !self usebuttonpressed() && buttontime < 0.25 )
    {
        buttontime += updaterate;
        wait updaterate;
    }
    
    if ( buttontime >= 0.25 )
    {
        return false;
    }
    
    return true;
}

// Namespace detonator_utility
// Params 4
// Checksum 0x14d7240b, Offset: 0x81a
// Size: 0x123
function function_738c85af66c1aa23( bundle, equipmentname, detonationbehavior, var_17583017df778800 = function_c330504fd4a3f502( detonationbehavior, equipmentname ) )
{
    if ( var_17583017df778800.size == 0 )
    {
        return 0;
    }
    
    if ( function_77a3013ce8d7e185( var_17583017df778800 ) )
    {
        foreach ( mine in var_17583017df778800 )
        {
            if ( !mine.bundle.var_f1d2779c04693715 )
            {
                break;
            }
        }
        
        return 0;
    }
    
    detonatorsuccess = weapon::giveandfireoffhandreliable( bundle.var_2116271ddc93a1fc );
    
    if ( detonatorsuccess )
    {
        params = spawnstruct();
        params.mines = var_17583017df778800;
        callback::callback( #"detonate_mines", params );
    }
    
    return detonatorsuccess;
}

// Namespace detonator_utility
// Params 2
// Checksum 0xb22a2561, Offset: 0x946
// Size: 0xb9
function function_c330504fd4a3f502( detonationbehavior, equipmentname )
{
    if ( !equipmentname )
    {
        return [];
    }
    
    switch ( detonationbehavior )
    {
        case #"detonate_all":
            var_17583017df778800 = self.mines[ equipmentname ];
            break;
        case #"detonate_last":
            var_17583017df778800[ 0 ] = utility::function_f1933af772476229( self.mines[ equipmentname ] );
            break;
        case #"detonate_first":
            var_17583017df778800[ 0 ] = utility::array_get_first_item( self.mines[ equipmentname ] );
            break;
        default:
            assertmsg( "<dev string:x45>" + detonationbehavior );
            break;
    }
    
    return var_17583017df778800;
}

// Namespace detonator_utility
// Params 1
// Checksum 0xc8e110d0, Offset: 0xa08
// Size: 0x84, Type: bool
function function_77a3013ce8d7e185( mines )
{
    foreach ( mine in mines )
    {
        if ( mine candetonate() )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace detonator_utility
// Params 2
// Checksum 0x566812, Offset: 0xa95
// Size: 0x58
function function_5149e5089db322ec( bundle, var_8984ca9253585236 )
{
    params = spawnstruct();
    params.bundle = bundle;
    params.var_8984ca9253585236 = var_8984ca9253585236;
    callback::add( #"detonate_mines", &function_1e81bdf9cf185d1e, params );
}

// Namespace detonator_utility
// Params 2
// Checksum 0xb25df7de, Offset: 0xaf5
// Size: 0xfd
function function_1e81bdf9cf185d1e( callbackparams, initparams )
{
    bundle = initparams.bundle;
    var_8984ca9253585236 = initparams.var_8984ca9253585236;
    mines = callbackparams.mines;
    detonated = 0;
    
    if ( isdefined( mines ) )
    {
        foreach ( mine in mines )
        {
            if ( mine candetonate() )
            {
                detonated = 1;
                mine thread detonate( undefined, undefined, var_8984ca9253585236 );
            }
        }
    }
    
    animDetonateCleanup( bundle );
    function_e70cef93d47168b3( bundle, detonated );
}

// Namespace detonator_utility
// Params 3
// Checksum 0xa2cdbc4b, Offset: 0xbfa
// Size: 0x14d
function detonate( attacker, delayoverride, var_8984ca9253585236 )
{
    self endon( #"death" );
    self.owner endon( #"disconnect" );
    self notify( #"pre_detonate" );
    
    if ( isdefined( attacker ) )
    {
        attacker endon( #"disconnect" );
    }
    else
    {
        attacker = self.owner;
    }
    
    if ( self.hasdetonated )
    {
        return;
    }
    
    self.hasdetonated = 1;
    
    if ( self.bundle.var_8e7e56516e13963e )
    {
        self setscriptablepartstate( "effects", "warningTrigger", 0 );
    }
    
    detonation_delay = self.bundle.detonator_detonationdelay ?? 0.1;
    detonation_delay = delayoverride ?? detonation_delay;
    wait detonation_delay;
    params = spawnstruct();
    params.attacker = attacker;
    params.mine = self;
    var_43f55f73fa67bf83 = function_dffb3832274304ad( self.bundle );
    
    if ( var_8984ca9253585236 )
    {
        self.owner thread callback::callback( var_43f55f73fa67bf83, params );
        return;
    }
    
    self.owner callback::callback( var_43f55f73fa67bf83, params );
}

// Namespace detonator_utility
// Params 1
// Checksum 0xb20d20fb, Offset: 0xd4f
// Size: 0x1d
function function_dffb3832274304ad( bundle )
{
    return "explode_" + bundle.useweapon;
}

// Namespace detonator_utility
// Params 2
// Checksum 0xd279c256, Offset: 0xd75
// Size: 0x80
function function_43043de6eb9207a1( bundle, explodefunc )
{
    params = spawnstruct();
    params.bundle = bundle;
    params.explodefunc = explodefunc;
    var_43f55f73fa67bf83 = function_dffb3832274304ad( params.bundle );
    
    if ( !callback::exists( var_43f55f73fa67bf83, &callback_explode, undefined, 1 ) )
    {
        callback::add( var_43f55f73fa67bf83, &callback_explode, params );
    }
}

// Namespace detonator_utility
// Params 2
// Checksum 0x233c69d4, Offset: 0xdfd
// Size: 0x63
function callback_explode( callbackparams, initparams )
{
    mine = callbackparams.mine;
    explodefunc = initparams.explodefunc;
    attacker = callbackparams.attacker;
    
    if ( isdefined( explodefunc ) )
    {
        mine [[ explodefunc ]]( attacker );
    }
}

// Namespace detonator_utility
// Params 0
// Checksum 0x9f5eae06, Offset: 0xe68
// Size: 0x142, Type: bool
function candetonate()
{
    if ( self.isdisabled || self.isjammed || self.chaffstunned )
    {
        return false;
    }
    
    armtime = self.bundle.var_7d42d41b473994d2 ?? 0;
    
    if ( isdefined( self.stucktime ) && self.stucktime + armtime > gettime() )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            self.owner [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( self.bundle.var_198d82ef4e343b4c );
        }
        
        return false;
    }
    
    if ( ( gettime() - self.throwtime ) / 1000 <= self.bundle.var_d19a6b82a41af809 )
    {
        if ( utility::issharedfuncdefined( #"hud", #"showerrormessage" ) )
        {
            self.owner [[ utility::getsharedfunc( #"hud", #"showerrormessage" ) ]]( self.bundle.var_198d82ef4e343b4c );
        }
        
        return false;
    }
    
    return true;
}

// Namespace detonator_utility
// Params 0
// Checksum 0x87a87a9c, Offset: 0xfb3
// Size: 0x4d, Type: bool
function validdetonationstate()
{
    if ( !utility::callsharedfunc( #"player", #"playerisalive" ) )
    {
        return false;
    }
    
    if ( utility::isusingremote() )
    {
        return false;
    }
    
    if ( !isdefined( self.mines ) || self.mines.size <= 0 )
    {
        return false;
    }
    
    return true;
}

// Namespace detonator_utility
// Params 2
// Checksum 0x202cca86, Offset: 0x1009
// Size: 0x93
function animDetonateCleanup( bundle, notify_name )
{
    self endon( #"death_or_disconnect" );
    self notify( hashcat( getxhash( bundle.equipmentref ), "animDetonateCleanup" ) );
    self endon( hashcat( getxhash( bundle.equipmentref ), "animDetonateCleanup" ) );
    var_7daaa868d5ef8034 = bundle.useweapon;
    objweapon = makeweapon( var_7daaa868d5ef8034 );
    wait 1;
    
    if ( self hasweapon( objweapon ) )
    {
        self takeweapon( objweapon );
    }
}

// Namespace detonator_utility
// Params 0
// Checksum 0x941b6b0b, Offset: 0x10a4
// Size: 0xb9
function explodeonnotify()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    self waittill( #"detonateexplosive", attacker );
    params = spawnstruct();
    params.mine = self;
    var_43f55f73fa67bf83 = function_dffb3832274304ad( self.bundle );
    
    if ( isdefined( attacker ) )
    {
        params.attacker = attacker;
        self.owner thread callback::callback( var_43f55f73fa67bf83, params );
        return;
    }
    
    params.attacker = self.owner;
    self.owner thread callback::callback( var_43f55f73fa67bf83, params );
}

// Namespace detonator_utility
// Params 2, eflags: 0x4
// Checksum 0xc0383deb, Offset: 0x1165
// Size: 0xb3
function private function_e70cef93d47168b3( bundle, detonated )
{
    if ( detonated )
    {
        if ( isdefined( bundle.var_a69aa725f60fb779 ) )
        {
            self playlocalsound( bundle.var_a69aa725f60fb779 );
        }
        
        if ( isdefined( bundle.var_a6a3b325f619f08b ) )
        {
            self playsound( bundle.var_a6a3b325f619f08b, self );
        }
        
        level thread namespace_9d8e359c3b1041e5::trysaylocalsoundsharedfunc( self, bundle.var_7d1ec174c6f35ac3 );
        return;
    }
    
    if ( isdefined( bundle.var_8934383a463f6274 ) )
    {
        self playlocalsound( bundle.var_8934383a463f6274 );
    }
    
    if ( isdefined( bundle.var_893d243a46495526 ) )
    {
        self playsound( bundle.var_893d243a46495526, self );
    }
}

// Namespace detonator_utility
// Params 3
// Checksum 0x720e2a27, Offset: 0x1220
// Size: 0x8b
function function_4a0836279bc3967c( equipmentname, owner, mine )
{
    if ( !isdefined( owner.mines ) )
    {
        owner.mines = [];
    }
    
    if ( !isdefined( owner.mines[ equipmentname ] ) )
    {
        owner.mines[ equipmentname ] = [];
    }
    
    entnum = mine getentitynumber();
    owner.mines[ equipmentname ][ entnum ] = mine;
    thread function_41018ebfa95803ab( equipmentname, owner, mine, entnum );
}

// Namespace detonator_utility
// Params 4
// Checksum 0xb5241a4e, Offset: 0x12b3
// Size: 0x8f
function function_365301109dae262e( equipmentname, owner, mine, entnum )
{
    if ( isdefined( mine ) )
    {
        mine notify( hashcat( getxhash( equipmentname ), "removeFromArray" ) );
    }
    
    if ( isdefined( owner ) && isdefined( owner.mines[ equipmentname ] ) )
    {
        owner.mines[ equipmentname ][ entnum ] = undefined;
    }
    
    if ( owner.mines[ equipmentname ].size == 0 )
    {
        owner notify( hashcat( #"watchfordetonation", equipmentname ) );
    }
}

// Namespace detonator_utility
// Params 4
// Checksum 0xec7eb347, Offset: 0x134a
// Size: 0x62
function function_41018ebfa95803ab( equipmentname, owner, mine, entnum )
{
    mine endon( hashcat( getxhash( equipmentname ), "removeFromArray" ) );
    owner endon( #"disconnect" );
    mine waittill( #"death" );
    thread function_365301109dae262e( equipmentname, owner, mine, entnum );
}

