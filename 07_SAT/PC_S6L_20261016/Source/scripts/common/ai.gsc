// scripts\common\ai.gsc  (hash_659c5b2112e17034.gscc) (size: 21798 Bytes / 0x5526 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3b277e3b (992443963)
// size ...... 21798 (0x5526)
// includes .. 5   (offset: 0x4ff2)
// strings ... 58  (offset: 0x501a)
// dev strs .. 35  (offset: 0x5372)
// exports ... 89  (offset: 0x30ea)
// cseg ...... 0x339 + 0x2db1 (0x30ea)
// imports ... 140 (offset: 0x3ed2)
// animtree1 . 0   (offset: 0x5526)
// animtree2 . 0   (offset: 0x5526)
#using scripts\asm\shared\utility;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\common\values;

#namespace ai;

// Namespace ai
// Params 0
// Checksum 0x51070566, Offset: 0x357
// Size: 0xc1
function ai_init()
{
    flag_name = self.animsetname + "_animsetname_init";
    
    if ( !utility::flag( flag_name ) )
    {
        utility::flag_set( flag_name );
        callback::callback( "on_first_ai_init" );
    }
    
    callback::function_99edd620ee45cd95( #"ai" );
    callback::function_99edd620ee45cd95( self.type );
    callback::function_99edd620ee45cd95( self.animsetname );
    
    if ( isdefined( self.subclass ) )
    {
        callback::function_99edd620ee45cd95( self.subclass );
    }
    
    utility::ent_flag_set( "ai_init_complete" );
    callback::callback( "on_ai_init" );
    utility::registersharedfunc( #"ai", #"hash_c649178f35fe47cf", &function_f4bf821b19c5ec24 );
}

// Namespace ai
// Params 0
// Checksum 0xc7ae5cf1, Offset: 0x420
// Size: 0x44
function function_6560fe052bc053d()
{
    for ( i = 0; i < level.players.size ; i++ )
    {
        player = level.players[ i ];
        player function_9349715a3ded9d8();
    }
}

// Namespace ai
// Params 0
// Checksum 0x2a75ff84, Offset: 0x46c
// Size: 0x8
function function_9349715a3ded9d8()
{
    self function_533d1ea1bc485146();
}

// Namespace ai
// Params 0
// Checksum 0x90cb32f4, Offset: 0x47c
// Size: 0x72
function set_forcegoal()
{
    if ( isdefined( self.set_forcedgoal ) )
    {
        return;
    }
    
    self.oldfightdist = self.pathenemyfightdist;
    self.oldmaxdist = self.pathenemylookahead;
    self.oldmaxsight = self.maxsightdistsqrd;
    self.pathenemyfightdist = 8;
    self.pathenemylookahead = 8;
    self.maxsightdistsqrd = 1;
    self.set_forcedgoal = 1;
}

// Namespace ai
// Params 0
// Checksum 0xb856c1e6, Offset: 0x4f6
// Size: 0x51
function unset_forcegoal()
{
    if ( !isdefined( self.set_forcedgoal ) )
    {
        return;
    }
    
    self.pathenemyfightdist = self.oldfightdist;
    self.pathenemylookahead = self.oldmaxdist;
    self.maxsightdistsqrd = self.oldmaxsight;
    self.set_forcedgoal = undefined;
}

// Namespace ai
// Params 0
// Checksum 0xa2f9e52a, Offset: 0x54f
// Size: 0xd
function disable_exits()
{
    self.disableexits = 1;
}

// Namespace ai
// Params 0
// Checksum 0x787a1143, Offset: 0x564
// Size: 0xc
function enable_exits()
{
    self.disableexits = 0;
}

// Namespace ai
// Params 0
// Checksum 0xe746e265, Offset: 0x578
// Size: 0xc
function disable_turnanims()
{
    self.turnanimsenabled = 0;
}

// Namespace ai
// Params 0
// Checksum 0xddb116c6, Offset: 0x58c
// Size: 0xd
function enable_turnanims()
{
    self.turnanimsenabled = 1;
}

// Namespace ai
// Params 0
// Checksum 0xddebc03c, Offset: 0x5a1
// Size: 0xd
function disable_arrivals()
{
    self.disablearrivals = 1;
}

// Namespace ai
// Params 0
// Checksum 0x287ffb31, Offset: 0x5b6
// Size: 0x19
function enable_arrivals()
{
    self endon( #"death" );
    waittillframeend();
    self.disablearrivals = 0;
}

// Namespace ai
// Params 1
// Checksum 0x43b96ff9, Offset: 0x5d7
// Size: 0x22
function set_rebel( var_ce2840db99be60d0 )
{
    self._blackboard.wildfireenabled = var_ce2840db99be60d0;
}

// Namespace ai
// Params 0
// Checksum 0x47422c9e, Offset: 0x601
// Size: 0x1e
function disable_long_death()
{
    assert( isalive( self ), "<dev string:x24>" );
    self.allowlongdeath = 0;
}

// Namespace ai
// Params 0
// Checksum 0x7fa019af, Offset: 0x627
// Size: 0x1f
function enable_long_death()
{
    assert( isalive( self ), "<dev string:x56>" );
    self.allowlongdeath = 1;
}

// Namespace ai
// Params 1
// Checksum 0x165fa0f1, Offset: 0x64e
// Size: 0x41
function enable_danger_react( duration )
{
    duration *= 1000;
    assert( isai( self ) );
    self.dodangerreact = 1;
    self.dangerreactduration = duration;
    self.neversprintforvariation = undefined;
}

// Namespace ai
// Params 0
// Checksum 0x4aa0763a, Offset: 0x697
// Size: 0x24
function disable_danger_react()
{
    assert( isai( self ) );
    self.dodangerreact = 0;
    self.neversprintforvariation = 1;
}

// Namespace ai
// Params 0
// Checksum 0x21b31109, Offset: 0x6c3
// Size: 0xc
function disable_surprise()
{
    self.newenemyreactiondistsq = 0;
}

// Namespace ai
// Params 0
// Checksum 0xaed2cf19, Offset: 0x6d7
// Size: 0xd
function get_ignoreme()
{
    return val::get( "ignoreme" );
}

// Namespace ai
// Params 1
// Checksum 0x56b06de, Offset: 0x6ed
// Size: 0x4a
function set_ignoreme( val )
{
    assert( issentient( self ), "<dev string:x87>" );
    
    if ( val )
    {
        val::set( "set_ignoreme", "ignoreme", 1 );
        return;
    }
    
    val::reset( "set_ignoreme", "ignoreme" );
}

// Namespace ai
// Params 2
// Checksum 0x34f69ee3, Offset: 0x73f
// Size: 0x4d
function contribute_ignoreme( contributor, val )
{
    assert( issentient( self ), "<dev string:x87>" );
    
    if ( val )
    {
        val::set( contributor, "ignoreme", 1 );
        return;
    }
    
    val::reset( contributor, "ignoreme" );
}

// Namespace ai
// Params 0
// Checksum 0x64adc32b, Offset: 0x794
// Size: 0x1f
function get_ignoreall()
{
    assert( issentient( self ), "<dev string:xa4>" );
    return val::get( "ignoreall" );
}

// Namespace ai
// Params 1
// Checksum 0x69011d79, Offset: 0x7bc
// Size: 0x4a
function set_ignoreall( val )
{
    assert( issentient( self ), "<dev string:xc2>" );
    
    if ( val )
    {
        val::set( "set_ignoreall", "ignoreall", 1 );
        return;
    }
    
    val::reset( "set_ignoreall", "ignoreall" );
}

// Namespace ai
// Params 1
// Checksum 0x2190c1cd, Offset: 0x80e
// Size: 0x53, Type: bool
function spawn_failed( ent )
{
    if ( !isalive( ent ) )
    {
        return true;
    }
    
    if ( utility::issp() && !isdefined( ent.finished_spawning ) )
    {
        ent utility::waittill_any( "finished spawning", "death" );
    }
    
    if ( isalive( ent ) )
    {
        return false;
    }
    
    return true;
}

// Namespace ai
// Params 0
// Checksum 0xd485eae7, Offset: 0x86a
// Size: 0x84
function gun_remove()
{
    if ( isai( self ) )
    {
        utility::script_func( "anim_placeweaponon", self.weapon, "none" );
        return;
    }
    
    if ( isdefined( self.fake_weapon_models ) )
    {
        gun_remove_fake();
        self.var_e39aa0eaeb58fa70 = 1;
        return;
    }
    
    if ( isweapon( self.weapon ) )
    {
        weaponmodel = getweaponmodel( self.weapon );
        
        if ( weaponmodel )
        {
            self detach( weaponmodel, "tag_weapon_right" );
        }
    }
}

// Namespace ai
// Params 0
// Checksum 0x6d55de7b, Offset: 0x8f6
// Size: 0x72
function gun_remove_fake()
{
    if ( isdefined( self.fake_weapon_models ) )
    {
        for ( i = self.fake_weapon_models.size - 1; i >= 0 ; i-- )
        {
            if ( i == 0 )
            {
                self detach( self.fake_weapon_models[ i ], "tag_weapon_right" );
                continue;
            }
            
            self detach( self.fake_weapon_models[ i ] );
        }
        
        self.fake_weapon_models = undefined;
    }
}

// Namespace ai
// Params 1
// Checksum 0xb62288db, Offset: 0x970
// Size: 0xf5
function gun_create_fake( models )
{
    foreach ( model in models )
    {
        if ( issubstr( model, "toprail" ) || issubstr( model, "railcust" ) )
        {
            if ( models.size > 1 )
            {
                models = arrayremove( models, model );
                arrayinsert( models, model, 1 );
            }
        }
    }
    
    for ( i = 0; i < models.size ; i++ )
    {
        if ( i == 0 )
        {
            self attach( models[ i ], "tag_weapon_right" );
            continue;
        }
        
        self attach( models[ i ] );
    }
    
    self.fake_weapon_models = models;
}

// Namespace ai
// Params 0
// Checksum 0x310888f4, Offset: 0xa6d
// Size: 0xb1
function gun_recall()
{
    if ( isai( self ) )
    {
        utility::script_func( "anim_placeweaponon", self.weapon, "right" );
        return;
    }
    
    weaponobject = self.weapon;
    
    if ( isweapon( self.weapon_object ) && !isnullweapon( self.weapon_object ) && isnullweapon( self.weapon ) )
    {
        weaponobject = self.weapon_object;
    }
    
    if ( self.var_e39aa0eaeb58fa70 )
    {
        gun_create_fake( getweaponattachmentworldmodels( weaponobject ) );
        self.var_e39aa0eaeb58fa70 = undefined;
        return;
    }
    
    self attach( getweaponmodel( weaponobject ), "tag_weapon_right" );
}

// Namespace ai
// Params 2
// Checksum 0x671c2b4b, Offset: 0xb26
// Size: 0x94
function set_gunpose( type, gundiscipline )
{
    /#
        validtypes[ "<dev string:xe0>" ] = 1;
        validtypes[ "<dev string:xea>" ] = 1;
        validtypes[ "<dev string:xf3>" ] = 1;
        validtypes[ "<dev string:xf9>" ] = 1;
        validtypes[ "<dev string:xfd>" ] = 1;
        assert( isdefined( validtypes[ type ] ), "<dev string:x105>" + type + "<dev string:x112>" );
    #/
    
    if ( type == "automatic" )
    {
        type = undefined;
    }
    
    self.gunposeoverride = type;
    self.gundiscipline = istrue( gundiscipline );
}

// Namespace ai
// Params 0
// Checksum 0xa86884f3, Offset: 0xbc2
// Size: 0x17
function reset_gunpose()
{
    self.gunposeoverride = undefined;
    self.gundiscipline = 1;
}

// Namespace ai
// Params 2
// Checksum 0x7cef3f70, Offset: 0xbe1
// Size: 0x1f
function poi_enable( val, startstruct )
{
    utility::toggle_poi( val, startstruct );
}

// Namespace ai
// Params 0
// Checksum 0x9732a53e, Offset: 0xc08
// Size: 0x3a
function stop_use_turret()
{
    self notify( #"stop_use_turret" );
    self unlink();
    self._blackboard.requestedturret = undefined;
    self._blackboard.requestedturretpose = undefined;
}

// Namespace ai
// Params 1
// Checksum 0x3e1837f1, Offset: 0xc4a
// Size: 0x113
function magic_bullet_shield( no_death_detection = 0 )
{
    if ( isai( self ) )
    {
        assert( isalive( self ), "<dev string:x129>" );
        assert( !self.delayeddeath, "<dev string:x165>" );
        assert( !self.doinglongdeath, "<dev string:x19c>" );
        assert( !isdefined( self.syncedmeleetarget ) || !self.in_melee, "<dev string:x1d4>" );
    }
    else
    {
        self.health = 100000;
    }
    
    assert( !isdefined( self.magic_bullet_shield ), "<dev string:x232>" );
    
    if ( isai( self ) )
    {
        val::set( "magic_bullet_shield", "attackeraccuracy", 0.1 );
        self.var_bb9911e6ba53bdb3 = self.var_5609d8c260be3f0e;
        self.var_5609d8c260be3f0e = 0;
    }
    
    /#
        if ( !no_death_detection )
        {
            thread magic_bullet_death_detection();
        }
    #/
    
    val::set( "magic_bullet_shield", "damageshield", 1 );
    self.magic_bullet_shield = 1;
}

// Namespace ai
// Params 0
// Checksum 0x62d91f24, Offset: 0xd65
// Size: 0x5b
function stop_magic_bullet_shield()
{
    self notify( #"stop_magic_bullet_shield" );
    assert( self.magic_bullet_shield, "<dev string:x2cd>" );
    val::reset_all( "magic_bullet_shield" );
    self.var_5609d8c260be3f0e = self.var_bb9911e6ba53bdb3 ?? 1;
    self.var_bb9911e6ba53bdb3 = undefined;
    self.magic_bullet_shield = undefined;
}

/#

    // Namespace ai
    // Params 0
    // Checksum 0xd1fa192d, Offset: 0xdc8
    // Size: 0x7c, Type: dev
    function magic_bullet_death_detection()
    {
        self endon( #"stop_magic_bullet_shield" );
        export = self.export;
        entnum = self getentitynumber();
        self waittill( #"death" );
        
        if ( isdefined( self ) )
        {
            assert( 0, "<dev string:x313>" + export + "<dev string:x338>" );
        }
        else
        {
            assert( 0, "<dev string:x313>" + export + "<dev string:x348>" );
        }
        
        export = export;
    }

#/

// Namespace ai
// Params 0
// Checksum 0x48791826, Offset: 0xe4c
// Size: 0x2f
function function_f4bf821b19c5ec24()
{
    if ( self.magic_bullet_shield )
    {
        stop_magic_bullet_shield();
    }
    
    if ( val::get( "damageshield" ) )
    {
        val::nuke( "damageshield" );
    }
}

// Namespace ai
// Params 1
// Checksum 0xae7cee8c, Offset: 0xe83
// Size: 0x3b
function force_long_death_on_back_with_pistol( skipcrawl )
{
    self.forcelongdeath = 4;
    
    if ( skipcrawl )
    {
        self.skipdyingbackcrawl = 1;
    }
    
    self asmsetstate( self.asmname, "choose_long_death" );
}

// Namespace ai
// Params 2
// Checksum 0xe375423f, Offset: 0xec6
// Size: 0xbd
function function_d3e4c703216f33e9( skipcrawl, skipintro )
{
    assert( self asmhasstate( self.asmname, "<dev string:x377>" ), "<dev string:x389>" + self.asmname + "<dev string:x39a>" );
    death_type_array = [ 29, 31, 33, 35 ];
    randind = randomint( 4 );
    self.forcelongdeath = death_type_array[ randind ];
    
    if ( isdefined( skipintro ) )
    {
        self.var_7733428de091931d = skipintro;
    }
    
    if ( isdefined( skipcrawl ) )
    {
        self.skipdyingbackcrawl = skipcrawl;
    }
    
    self asmsetstate( self.asmname, "choose_long_death" );
}

// Namespace ai
// Params 2
// Checksum 0xa6f1cd8d, Offset: 0xf8b
// Size: 0x56
function function_f87586c8c1aaa78d( skipcrawl, skipintro )
{
    self.forcelongdeath = 37;
    
    if ( isdefined( skipintro ) )
    {
        self.var_7733428de091931d = skipintro;
    }
    
    if ( isdefined( skipcrawl ) )
    {
        self.skipdyingbackcrawl = skipcrawl;
    }
    
    self asmsetstate( self.asmname, "choose_long_death" );
}

// Namespace ai
// Params 0
// Checksum 0x34081070, Offset: 0xfe9
// Size: 0xd
function force_long_death_crawling_away()
{
    self.forcelongdeath = 3;
}

// Namespace ai
// Params 0
// Checksum 0x6befcdcb, Offset: 0xffe
// Size: 0xd
function force_long_death_stumbling()
{
    self.forcelongdeath = 2;
}

// Namespace ai
// Params 1
// Checksum 0x389725d2, Offset: 0x1013
// Size: 0x149, Type: bool
function find_and_teleport_to_cover( coverselector )
{
    var_2eeae21cc17eff42 = 0;
    frompoint = undefined;
    searchcentered = 1;
    cover_node = self findbestcovernode( coverselector, var_2eeae21cc17eff42, frompoint, searchcentered );
    
    if ( isdefined( cover_node ) )
    {
        coverangles = cover_node.angles;
        coverorigin = cover_node.origin;
        
        if ( !issubstr( cover_node.type, "Prone" ) )
        {
            if ( issubstr( cover_node.type, "Left" ) )
            {
                coverangles += ( 0, 90, 0 );
            }
            else if ( issubstr( cover_node.type, "Right" ) || issubstr( cover_node.type, "Cover Crouch" ) || issubstr( cover_node.type, "Conceal" ) || issubstr( cover_node.type, "Cover Stand" ) )
            {
                coverangles -= ( 0, 90, 0 );
            }
        }
        
        self forceteleport( coverorigin, coverangles );
        self usecovernode( cover_node, 1 );
        self setgoalnode( cover_node );
        return true;
    }
    
    return false;
}

// Namespace ai
// Params 1
// Checksum 0x5f73625, Offset: 0x1165
// Size: 0x5b, Type: bool
function aigroundturret_requestmount( turret )
{
    if ( self._blackboard.aigroundturretstate == "none" )
    {
        self._blackboard.aigroundturretstate = "turret_mount_requested";
        self._blackboard.aigroundturretref = turret;
        return true;
    }
    
    return false;
}

// Namespace ai
// Params 0
// Checksum 0xdd8f7ebd, Offset: 0x11c9
// Size: 0x37
function aigroundturret_mountcompleted()
{
    if ( self._blackboard.aigroundturretstate == "turret_mount_requested" )
    {
        self._blackboard.aigroundturretstate = "turret_mounted";
    }
}

// Namespace ai
// Params 0
// Checksum 0x9e0afa25, Offset: 0x1208
// Size: 0xa5, Type: bool
function aigroundturret_cancel()
{
    if ( self._blackboard.aigroundturretstate != "none" )
    {
        if ( self._blackboard.aigroundturretstate == "turret_mount_requested" )
        {
            self._blackboard.aigroundturretstate = "none";
            self._blackboard.aigroundturretref = undefined;
            return true;
        }
        else if ( self._blackboard.aigroundturretstate == "turret_mounted" )
        {
            self._blackboard.aigroundturretstate = "turret_dismount_requested";
            return true;
        }
    }
    
    return false;
}

// Namespace ai
// Params 0
// Checksum 0x98252d6e, Offset: 0x12b6
// Size: 0x4a
function aigroundturret_dismountcompleted()
{
    if ( self._blackboard.aigroundturretstate == "turret_dismount_requested" )
    {
        self._blackboard.aigroundturretstate = "none";
        self._blackboard.aigroundturretref = undefined;
    }
}

// Namespace ai
// Params 2
// Checksum 0xa14d17a5, Offset: 0x1308
// Size: 0x56
function ai_operate_turret( turret_operator, turret )
{
    if ( !isalive( turret_operator ) )
    {
        return;
    }
    
    var_21563db4c6325185 = turret_operator aigroundturret_requestmount( turret );
    
    if ( var_21563db4c6325185 )
    {
        turret_operator.ignoreall = 1;
        turret_operator.ignoreme = 1;
    }
}

// Namespace ai
// Params 1
// Checksum 0x50a75570, Offset: 0x1366
// Size: 0x4a
function ai_dismount_turret( turret_operator )
{
    if ( !isalive( turret_operator ) )
    {
        return;
    }
    
    canceled = turret_operator aigroundturret_cancel();
    
    if ( canceled )
    {
        turret_operator.ignoreall = 0;
        turret_operator.ignoreme = 0;
    }
}

// Namespace ai
// Params 4
// Checksum 0x36e16f2e, Offset: 0x13b8
// Size: 0x73
function set_vehicle_hide_values( minhide, maxhide, cooldown, usesuppression )
{
    if ( isai( self ) )
    {
        if ( isdefined( minhide ) )
        {
            self.vehicleminhide = minhide;
        }
        
        if ( isdefined( maxhide ) )
        {
            self.vehiclemaxhide = maxhide;
        }
        
        if ( isdefined( cooldown ) )
        {
            self.var_79f6979827ca5037 = cooldown;
        }
        
        if ( isdefined( usesuppression ) )
        {
            self.vehicleusesuppression = usesuppression;
        }
    }
}

// Namespace ai
// Params 0
// Checksum 0xa2e23d54, Offset: 0x1433
// Size: 0x32
function function_abdc267a17a7f5e6()
{
    if ( isai( self ) )
    {
        self.vehicleminhide = undefined;
        self.vehiclemaxhide = undefined;
        self.var_79f6979827ca5037 = undefined;
        self.vehicleusesuppression = 0;
    }
}

// Namespace ai
// Params 1
// Checksum 0xc66e7059, Offset: 0x146d
// Size: 0x37a
function function_ddafb76466c3a847( strength )
{
    setdvarifuninitialized( @"scr_wind_debug", 0 );
    level.currentwind = strength;
    utility::flag_wait( "scriptables_ready" );
    
    while ( gettime() < 3000 )
    {
        wait 0.1;
    }
    
    guys = getaiarray();
    ents = getentarray();
    
    foreach ( ent in ents )
    {
        if ( ent.script_wind )
        {
            guys[ guys.size ] = ent;
        }
    }
    
    if ( getdvarint( @"scr_wind_debug" ) )
    {
        utility::array_thread( guys, &wind_debug );
    }
    
    foreach ( guy in guys )
    {
        if ( !guy isscriptable() )
        {
            if ( getdvarint( @"scr_wind_debug" ) )
            {
                /#
                    if ( isdefined( guy.model ) )
                    {
                        println( "<dev string:x3bb>" + guy.classname + "<dev string:x3e8>" + guy.model );
                    }
                    else
                    {
                        println( "<dev string:x3bb>" + guy.classname );
                    }
                #/
            }
            
            continue;
        }
        
        switch ( level.currentwind )
        {
            case 0:
                guy setscriptablepartstate( "wind", "0", 0 );
                break;
            case 1:
                guy setscriptablepartstate( "wind", "10", 0 );
                break;
            case 2:
                guy setscriptablepartstate( "wind", "20", 0 );
                break;
            case 3:
                guy setscriptablepartstate( "wind", "30", 0 );
                break;
            case 4:
                guy setscriptablepartstate( "wind", "40", 0 );
                break;
            case 5:
                guy setscriptablepartstate( "wind", "50", 0 );
                break;
            case 6:
                guy setscriptablepartstate( "wind", "60", 0 );
                break;
            case 7:
                guy setscriptablepartstate( "wind", "70", 0 );
                break;
            case 8:
                guy setscriptablepartstate( "wind", "80", 0 );
                break;
            case 9:
                guy setscriptablepartstate( "wind", "90", 0 );
                break;
            case 10:
                guy setscriptablepartstate( "wind", "100", 0 );
                break;
            default:
                assertmsg( "<dev string:x3ea>" + level.currentwind + "<dev string:x3f5>" );
                break;
        }
    }
}

// Namespace ai
// Params 0
// Checksum 0xebb1e1ce, Offset: 0x17ef
// Size: 0x62
function wind_debug()
{
    self endon( #"death" );
    self notify( #"stop_wind_debug" );
    self endon( #"stop_wind_debug" );
    
    while ( true )
    {
        /#
            print3d( self.origin, "<dev string:x404>", ( 1, 1, 1 ), 1, 0.25, 10, 1 );
        #/
        
        wait 0.5;
    }
}

// Namespace ai
// Params 1
// Checksum 0x5e508d49, Offset: 0x1859
// Size: 0x57
function set_deathanim( deathanim )
{
    deathxanim = undefined;
    
    if ( isstring( deathanim ) )
    {
        deathxanim = utility::getanim( deathanim );
    }
    else
    {
        deathxanim = deathanim;
    }
    
    assert( isanimation( deathxanim ) );
    self.deathanim = deathxanim;
    self.isdeathanimdefined = 1;
}

// Namespace ai
// Params 0
// Checksum 0x6b253201, Offset: 0x18b8
// Size: 0x16
function clear_deathanim()
{
    self.deathanim = undefined;
    self.isdeathanimdefined = 0;
}

// Namespace ai
// Params 1
// Checksum 0x1f8d4ee2, Offset: 0x18d6
// Size: 0x35
function set_death_function( death_func )
{
    self.deathfunction = death_func;
    
    if ( isdefined( death_func ) )
    {
        self.isdeathfunctiondefined = 1;
        return;
    }
    
    self.isdeathfunctiondefined = 0;
}

// Namespace ai
// Params 1
// Checksum 0x28557913, Offset: 0x1913
// Size: 0x39
function remove_blackboard_isburning( guy )
{
    waitframe();
    
    if ( !isdefined( guy ) )
    {
        return;
    }
    
    if ( isdefined( guy._blackboard ) )
    {
        guy._blackboard.isburning = undefined;
    }
}

// Namespace ai
// Params 2
// Checksum 0x7efd4a31, Offset: 0x1954
// Size: 0x122
function function_9b5d55d642edff87( grenade, target )
{
    if ( isdefined( target.asmname ) && !target.var_b73c033f1d73bd80 && target asmhaspainstate( target.asmname ) )
    {
        target._blackboard.isburning = 1;
        target.burningtodeath = 0;
        target.burningdirection = undefined;
        target.semtexstuckto = 1;
        enemyright = anglestoright( target.angles );
        var_4ee847e684562943 = vectornormalize( grenade.origin - target.origin );
        
        if ( vectordot( enemyright, var_4ee847e684562943 ) > 0 )
        {
            target.burningdirection = "right";
        }
        else
        {
            target.burningdirection = "left";
        }
        
        target asmevalpaintransition( target.asmname );
        level thread remove_blackboard_isburning( target );
        grenade.stucktoai = target;
    }
}

// Namespace ai
// Params 10
// Checksum 0xdcb5c445, Offset: 0x1a7e
// Size: 0x137
function function_7bcb54b16c07d1ec( num_points, cylinder_origin, cylinder_height, outer_radius, inner_radius, use_throttle, begin_yaw, end_yaw, up_dist = 200, var_9951c1dc0b17c55a )
{
    level endon( #"game_ended" );
    spawn_points = [];
    
    if ( !isdefined( use_throttle ) )
    {
        use_throttle = 1;
    }
    
    throttle_count = 0;
    var_d3fc19555a4576f5 = var_9951c1dc0b17c55a ?? 5;
    
    for ( i = 0; i < num_points ; i++ )
    {
        failed_attempts = 0;
        
        while ( failed_attempts < var_d3fc19555a4576f5 )
        {
            disk_center = cylinder_origin + ( 0, 0, cylinder_height );
            random_point = math::function_562709d61af16bd4( disk_center, outer_radius, inner_radius, begin_yaw, end_yaw );
            ground_point = utility::function_5918594658d3ffba( random_point, up_dist );
            
            if ( isdefined( ground_point ) )
            {
                spawn_points[ spawn_points.size ] = ground_point;
                break;
            }
            else
            {
                failed_attempts++;
            }
            
            if ( use_throttle )
            {
                throttle_count++;
                
                if ( throttle_count % 3 == 0 )
                {
                    waitframe();
                }
            }
        }
    }
    
    return spawn_points;
}

// Namespace ai
// Params 1
// Checksum 0x239a769d, Offset: 0x1bbe
// Size: 0x4f
function set_ai_max_health( max_health )
{
    old_maxhealth = self.maxhealth;
    self.maxhealth = max_health;
    callback::callback( "on_ai_set_max_health", { #new_maxhealth:max_health, #old_maxhealth:old_maxhealth } );
}

// Namespace ai
// Params 6
// Checksum 0xd7a89a42, Offset: 0x1c15
// Size: 0x162
function get_ai_closest( origin, team, species, subclass, max_dist, filter )
{
    all_ai = [];
    
    if ( isdefined( species ) )
    {
        all_ai = getaispeciesarray( team, species );
    }
    else if ( max_dist > 0 )
    {
        all_ai = getaiarrayinradius( origin, max_dist, team );
    }
    else
    {
        all_ai = getaiarray( team );
    }
    
    closest_ai = undefined;
    closest_dist_sqr = isdefined( max_dist ) ? squared( max_dist ) : undefined;
    
    foreach ( ai in all_ai )
    {
        if ( isdefined( subclass ) && ai.subclass != subclass )
        {
            continue;
        }
        
        if ( isdefined( filter ) && ![[ filter ]]( ai ) )
        {
            continue;
        }
        
        dist_sqr = distancesquared( ai.origin, origin );
        
        if ( !isdefined( closest_dist_sqr ) || dist_sqr < closest_dist_sqr )
        {
            closest_ai = ai;
            closest_dist_sqr = dist_sqr;
        }
    }
    
    return closest_ai;
}

// Namespace ai
// Params 5
// Checksum 0xc4a64805, Offset: 0x1d80
// Size: 0xa3
function function_5b4f66c4d86eea91( smokeorigin, duration = 8.25, lightsmokeradius = 250, heavysmokeradius = 150, owner )
{
    if ( lightsmokeradius < heavysmokeradius )
    {
        lightsmokeradius = heavysmokeradius;
    }
    
    assert( !isdefined( owner ) || isplayer( owner ) || isagent( owner ) );
    addActiveSmoke( smokeorigin, duration, lightsmokeradius, heavysmokeradius, isplayer( owner ) || isagent( owner ) ? owner : undefined );
}

// Namespace ai
// Params 0
// Checksum 0xdeb78454, Offset: 0x1e2b
// Size: 0x91
function ai_deathflag()
{
    level.deathflags[ self.script_deathflag ][ "ai" ][ self.unique_id ] = self;
    ai_number = self.unique_id;
    deathflag = self.script_deathflag;
    
    if ( isdefined( self.script_deathflag_longdeath ) )
    {
        function_68ee59bed92c0434();
    }
    else
    {
        self waittill( #"death" );
    }
    
    level.deathflags[ deathflag ][ "ai" ][ ai_number ] = undefined;
    update_deathflag( deathflag );
}

// Namespace ai
// Params 0
// Checksum 0xff4a453d, Offset: 0x1ec4
// Size: 0x1b
function function_68ee59bed92c0434()
{
    self endon( #"death" );
    self waittill( #"long_death" );
}

// Namespace ai
// Params 1
// Checksum 0x47d7951a, Offset: 0x1ee7
// Size: 0xac
function update_deathflag( deathflag )
{
    level notify( "updating_deathflag_" + deathflag );
    level endon( "updating_deathflag_" + deathflag );
    waittillframeend();
    
    foreach ( array in level.deathflags[ deathflag ] )
    {
        if ( getarraykeys( array ).size > 0 )
        {
            return;
        }
    }
    
    utility::flag_set( deathflag );
}

// Namespace ai
// Params 0
// Checksum 0x182275fe, Offset: 0x1f9b
// Size: 0x41
function laser_on_thread()
{
    self endon( #"entitydeleted" );
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    if ( self.health <= 1 )
    {
        return;
    }
    
    self laserforceon();
    self waittill( #"death" );
    self laserforceoff();
}

// Namespace ai
// Params 0
// Checksum 0x8efb57d3, Offset: 0x1fe4
// Size: 0x24
function get_cover_volume_forward()
{
    if ( isdefined( self.goalvolumecoveryaw ) )
    {
        return anglestoforward( ( 0, self.goalvolumecoveryaw, 0 ) );
    }
    
    return;
}

// Namespace ai
// Params 1
// Checksum 0x55b697a5, Offset: 0x2010
// Size: 0x1a9
function set_goal_volume( volume )
{
    if ( self.team == "allies" )
    {
        self.fixednode = 0;
    }
    
    if ( !isdefined( volume ) )
    {
        volume = level.goalvolumes[ self.script_goalvolume ];
        
        if ( !isdefined( volume ) )
        {
            return;
        }
    }
    
    goal = undefined;
    
    if ( isdefined( volume.target ) )
    {
        node = getnode( volume.target, #targetname );
        ent = getent( volume.target, #targetname );
        struct = utility::getstruct( volume.target, "targetname" );
        
        if ( isdefined( node ) )
        {
            goal = node;
            self setgoalnode( goal );
        }
        else if ( isdefined( ent ) )
        {
            goal = ent;
            self setgoalpos( goal.origin );
        }
        else if ( isdefined( struct ) )
        {
            goal = struct;
            self setgoalpos( goal.origin );
        }
        
        if ( isdefined( goal ) )
        {
            if ( isdefined( goal.radius ) && goal.radius != 0 )
            {
                self.goalradius = goal.radius;
            }
            
            if ( isdefined( goal.goalheight ) && goal.goalheight != 0 )
            {
                self.goalheight = goal.goalheight;
            }
        }
    }
    
    if ( isdefined( goal ) )
    {
        self setgoalvolume( volume );
        return;
    }
    
    self setgoalvolumeauto( volume, volume get_cover_volume_forward() );
}

// Namespace ai
// Params 1
// Checksum 0x683b3e45, Offset: 0x21c1
// Size: 0x39
function set_grenadeweapon( types )
{
    offhands = strtok( types, " " );
    self.grenadeweapon = makeweapon( offhands[ randomint( offhands.size ) ] );
}

// Namespace ai
// Params 2
// Checksum 0x30f030ef, Offset: 0x2202
// Size: 0x35
function set_blackboard_cooldown( name, cooldown_ms )
{
    assert( isint( cooldown_ms ) );
    self function_786bb6aa1b76c7ee( name, gettime() + cooldown_ms );
}

// Namespace ai
// Params 1
// Checksum 0xcff60cfb, Offset: 0x223f
// Size: 0x3b
function get_blackboard_cooldown( name )
{
    cooldown_timestamp = self getaiblackboarddynamic( name ) ?? 0;
    cooldown = max( cooldown_timestamp - gettime(), 0 );
    return cooldown;
}

// Namespace ai
// Params 2
// Checksum 0xb9732568, Offset: 0x2283
// Size: 0x3d
function function_3972558ecac29bf2( name, cooldown_ms )
{
    assert( isint( cooldown_ms ) );
    set_blackboard_cooldown( name, max( get_blackboard_cooldown( name ), cooldown_ms ) );
}

// Namespace ai
// Params 2
// Checksum 0x81e42b1b, Offset: 0x22c8
// Size: 0x3d
function function_e8e1e069df6dfd10( name, cooldown_ms )
{
    assert( isint( cooldown_ms ) );
    set_blackboard_cooldown( name, min( get_blackboard_cooldown( name ), cooldown_ms ) );
}

// Namespace ai
// Params 2
// Checksum 0x2802ff90, Offset: 0x230d
// Size: 0x3a
function function_ee66f847eebf97cc( name, cooldown_ms )
{
    assert( isint( cooldown_ms ) );
    set_blackboard_cooldown( name, get_blackboard_cooldown( name ) - cooldown_ms );
}

// Namespace ai
// Params 0
// Checksum 0x13eeba6a, Offset: 0x234f
// Size: 0x22, Type: bool
function is_warlord()
{
    return isdefined( self.subclass ) && issubstr( self.subclass, "warlord" );
}

// Namespace ai
// Params 0
// Checksum 0x68d1ba2b, Offset: 0x237a
// Size: 0x5b, Type: bool
function is_non_base()
{
    if ( self.aicategory == "special" || self.aicategory == "elite" || self.aicategory == "hvt" || self.aicategory == "boss" || is_warlord() )
    {
        return true;
    }
    
    return false;
}

// Namespace ai
// Params 0
// Checksum 0x2e338ed0, Offset: 0x23de
// Size: 0x18, Type: bool
function is_boss()
{
    if ( self.aicategory == "boss" )
    {
        return true;
    }
    
    return false;
}

// Namespace ai
// Params 0
// Checksum 0x648cf74f, Offset: 0x23ff
// Size: 0x2a
function is_floating()
{
    is_floating = self.var_69623111d7e6b9a4 > 0 || self.var_ed3c19fec55b26cc > 0;
    return is_floating;
}

// Namespace ai
// Params 0
// Checksum 0x87ebbb0d, Offset: 0x2432
// Size: 0x3f, Type: bool
function should_do_immediate_ragdoll()
{
    if ( self.do_immediate_ragdoll )
    {
        return true;
    }
    
    if ( self.forceragdollimmediate )
    {
        return true;
    }
    
    if ( self.diedintransition && !isdefined( self.vehicledeathwait ) )
    {
        return true;
    }
    
    return false;
}

// Namespace ai
// Params 2
// Checksum 0x38ee111f, Offset: 0x247a
// Size: 0x344
function go_to_interaction( goto_func, node )
{
    self endon( #"death" );
    
    if ( !node.var_433da69892ae9b9f )
    {
        if ( isdefined( node.target ) )
        {
            node.interactionid = getinteractionidfortargetname( node.target );
            node.interactionidarray = getinteractionidsfortargetname( node.target );
        }
        
        node.var_433da69892ae9b9f = 1;
    }
    
    var_630ad472236f172c = node.script_onlyidle && self.var_7a84781005a5b751;
    
    if ( isdefined( node.interaction ) && ( !isdefined( node.interactionid ) || !function_e0737745ca681ec7( node.interactionid ) ) && !var_630ad472236f172c )
    {
        angles = node.angles;
        
        if ( !isdefined( angles ) )
        {
            angles = ( 0, 0, 0 );
        }
        
        interactiontoks = strtok( node.interaction, "+" );
        interaction = utility::array_random( interactiontoks );
        node.interactionid = spawninteraction( interaction, node.origin, angles );
    }
    
    if ( isdefined( node.interactionidarray ) )
    {
        node.interactionid = utility::array_random( node.interactionidarray );
    }
    
    skipgoto = 0;
    
    if ( node.interactionid )
    {
        interactionorigin = getinteractionorigin( node.interactionid );
        
        if ( distancesquared( node.origin, interactionorigin ) < 9216 )
        {
            skipgoto = 1;
        }
    }
    
    if ( !skipgoto )
    {
        self [[ goto_func ]]( node );
        self waittill( #"goal" );
    }
    
    if ( var_630ad472236f172c )
    {
        return;
    }
    
    if ( isdefined( node.interactionid ) )
    {
        self._blackboard.idlenode = node;
        self.repeatinteraction = istrue( node.repeat_interaction );
        
        /#
            if ( getdvarint( @"hash_75d5a192711fbacb", 0 ) != 0 )
            {
                print3d( self.origin + ( 0, 0, randomintrange( 40, 150 ) ), "<dev string:x40b>" + node.interactionid, ( 1, 1, 1 ), 1, 1, 1000 );
            }
        #/
        
        interactionid = self getinteractionid();
        var_4aa98c5499f1d2c4 = self.var_e3720ab742ffee98;
        
        if ( !isdefined( interactionid ) )
        {
            self function_895b16b8fcd857ba( node.interactionid );
            self.interactionplayed = 1;
            self.var_e3720ab742ffee98 = 1;
        }
        
        self waittill( #"bseq_user_deleted" );
        self._blackboard.idlenode = undefined;
        self.var_e3720ab742ffee98 = var_4aa98c5499f1d2c4;
        self.repeatinteraction = 0;
        
        if ( isdefined( node.interaction ) && isdefined( node.interactionid ) )
        {
            despawninteraction( node.interactionid );
            node.interactionid = undefined;
        }
    }
}

// Namespace ai
// Params 1
// Checksum 0x6fa2e54d, Offset: 0x27c6
// Size: 0xf1
function function_29ab862ec4f51541( aitype_name )
{
    if ( !isdefined( level.var_a706785ff83cb223 ) )
    {
        level.var_a706785ff83cb223 = [];
    }
    
    if ( !isdefined( level.var_d85265655f6db38a ) )
    {
        level.var_d85265655f6db38a = [];
    }
    
    if ( !isdefined( level.var_a706785ff83cb223[ aitype_name ] ) )
    {
        if ( isaitypenamevalid( aitype_name ) )
        {
            aitypescriptbundle = getaitypescriptbundle( aitype_name );
            subclass = getscriptbundlefieldvalue( hashcat( %"hash_138dab78b1b28a0f", aitypescriptbundle.subclass ), "name" );
            aisettingsbundlename = aitypescriptbundle.zombieaisetting;
            aicategory = getscriptbundlefieldvalue( hashcat( %"zombieaisettings:", aisettingsbundlename ), "aicategory" );
            level.var_d85265655f6db38a[ subclass ] = aicategory;
            level.var_a706785ff83cb223[ aitype_name ] = subclass;
            return subclass;
        }
    }
    
    return level.var_a706785ff83cb223[ aitype_name ];
}

// Namespace ai
// Params 2
// Checksum 0xd60b4a14, Offset: 0x28c0
// Size: 0x1df
function set_threatbias_stack_score( threatbias_id, threat_added )
{
    assert( isxhash( threatbias_id ) );
    
    if ( !isdefined( self.threatbias_stack ) )
    {
        self.threatbias_stack = [];
    }
    
    initial_set = !isdefined( self.threatbias_stack[ threatbias_id ] ) && isdefined( threat_added );
    
    if ( initial_set || !( self.threatbias_stack[ threatbias_id ] === threat_added ) )
    {
        self.threatbias_stack[ threatbias_id ] = threat_added;
        final_threatbias = 0;
        
        foreach ( threatbias in self.threatbias_stack )
        {
            if ( isdefined( threatbias ) )
            {
                final_threatbias += threatbias;
            }
        }
        
        self.threatbias = final_threatbias;
        
        /#
            if ( getdvarint( @"debug_threatbias_stack", 0 ) > 0 )
            {
                i = 0;
                
                foreach ( threatbias_id, threatbias_score in self.threatbias_stack )
                {
                    print3d( self.origin + ( 0, 0, 72 + i * 20 ), getxhashsourcename( threatbias_id ) + "<dev string:x424>" + threatbias_score, ( 1, 0, 0 ), 1, 0.6 );
                    i += 1;
                }
            }
        #/
    }
}

// Namespace ai
// Params 1
// Checksum 0xfde63a64, Offset: 0x2aa7
// Size: 0xee
function function_dd7b3233e5b07718( bnocorpse )
{
    /#
        if ( !isdefined( self.group ) )
        {
            assert( self.birthtime < gettime(), "<dev string:x427>" + "<dev string:x458>" + self.origin );
        }
        else
        {
            assert( self.birthtime < gettime(), "<dev string:x45a>" + self.group.group_name + "<dev string:x458>" + self.origin );
        }
    #/
    
    if ( self.birthtime >= gettime() )
    {
        waitframe();
    }
    
    if ( bnocorpse )
    {
        self.nocorpse = 1;
    }
    
    self.died_poorly = 1;
    self.died_poorly_health = self.health;
    self.var_70fbc1727d54c322 = 1;
    
    if ( isdefined( self.magic_bullet_shield ) )
    {
        stop_magic_bullet_shield();
    }
    
    self kill();
}

// Namespace ai
// Params 1
// Checksum 0x2ec68bba, Offset: 0x2b9d
// Size: 0x38, Type: bool
function is_doing_traversal( ai )
{
    assert( isscriptedai( ai ), "<dev string:x48c>" );
    
    if ( ai isintraverse() )
    {
        return true;
    }
    
    if ( ai function_d5dd650fd35ceafb() )
    {
        return true;
    }
    
    return false;
}

// Namespace ai
// Params 4
// Checksum 0x2e0a2e9e, Offset: 0x2bde
// Size: 0xcc
function function_20e2b5e7fcba9f36( origin, max_radius, min_radius, height = 512 )
{
    a_tacpoints = function_7801d05a86b06144( origin, max_radius, min_radius, height );
    
    if ( a_tacpoints.size == 0 )
    {
        return;
    }
    
    foreach ( tacpoint in a_tacpoints )
    {
        if ( !tacpoint.var_6f9c4e415e80942f )
        {
            continue;
        }
        
        return tacpoint;
    }
}

// Namespace ai
// Params 4
// Checksum 0x1a478ba9, Offset: 0x2cb2
// Size: 0xd4
function function_5790e62eb11d12d0( origin, max_radius, min_radius, height = 512 )
{
    a_tacpoints = function_7801d05a86b06144( origin, max_radius, min_radius, height );
    
    if ( a_tacpoints.size == 0 )
    {
        return;
    }
    
    a_tacpoints = arrayrandomize( a_tacpoints );
    
    foreach ( tacpoint in a_tacpoints )
    {
        if ( !tacpoint.var_6f9c4e415e80942f )
        {
            continue;
        }
        
        return tacpoint;
    }
}

// Namespace ai
// Params 4
// Checksum 0xe367e811, Offset: 0x2d8e
// Size: 0xdd
function function_76a020b1e49e4711( origin, max_radius, min_radius, height = 512 )
{
    a_tacpoints = function_7801d05a86b06144( origin, max_radius, min_radius, height );
    
    if ( a_tacpoints.size == 0 )
    {
        return;
    }
    
    valid_tacpoints = [];
    
    foreach ( tacpoint in a_tacpoints )
    {
        if ( !tacpoint.var_6f9c4e415e80942f )
        {
            continue;
        }
        
        valid_tacpoints[ valid_tacpoints.size ] = tacpoint;
    }
    
    return valid_tacpoints;
}

// Namespace ai
// Params 5
// Checksum 0x403989ef, Offset: 0x2e74
// Size: 0xe8
function function_c6bf02d2d6899f3( origin, max_radius, min_radius, height = 512, room_name )
{
    room_tacpoints = [];
    a_tacpoints = function_7801d05a86b06144( origin, max_radius, min_radius, height );
    
    if ( a_tacpoints.size == 0 )
    {
        return;
    }
    
    foreach ( tacpoint in a_tacpoints )
    {
        if ( tacpoint.var_6f9c4e415e80942f != room_name )
        {
            continue;
        }
        
        room_tacpoints[ room_tacpoints.size ] = tacpoint;
    }
    
    return room_tacpoints;
}

// Namespace ai
// Params 4
// Checksum 0xe2d1ca67, Offset: 0x2f65
// Size: 0x15c
function function_18c4c0772893a743( room_data, max_radius, min_radius, height = 512 )
{
    room_tacpoints = [];
    
    foreach ( room in room_data )
    {
        if ( !room.origin || !room.room_name )
        {
            continue;
        }
        
        max_radius = room.max_radius ? room.max_radius : max_radius;
        min_radius = room.min_radius ? room.min_radius : min_radius;
        height = room.height ? room.height : height;
        tacpoints = function_c6bf02d2d6899f3( room.origin, max_radius, min_radius, height, room.room_name );
        room_tacpoints = arraycombine( room_tacpoints, tacpoints );
    }
    
    return room_tacpoints;
}

// Namespace ai
// Params 1
// Checksum 0xf4c28700, Offset: 0x30ca
// Size: 0x20
function function_4aca9a055eaa9c89( remainexposed = 1 )
{
    self.balwayscoverexposed = remainexposed;
}

