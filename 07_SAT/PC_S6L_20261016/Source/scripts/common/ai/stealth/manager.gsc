// scripts\common\ai\stealth\manager.gsc  (hash_0cb233a7d6343014.gscc) (size: 15205 Bytes / 0x3b65 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x6bd2128a (1808929418)
// size ...... 15205 (0x3b65)
// includes .. 11  (offset: 0x3681)
// strings ... 41  (offset: 0x36d9)
// dev strs .. 20  (offset: 0x3a55)
// exports ... 21  (offset: 0x2695)
// cseg ...... 0x2db + 0x23ba (0x2695)
// imports ... 104 (offset: 0x29dd)
// animtree1 . 0   (offset: 0x3b65)
// animtree2 . 0   (offset: 0x3b65)
#using scripts\common\ai\smartobjects\hunt_checkin;
#using scripts\common\ai\smartobjects\hunt_point;
#using scripts\common\ai\stealth\callbacks;
#using scripts\common\ai\stealth\corpse;
#using scripts\common\ai\stealth\debug;
#using scripts\common\ai\stealth\enemy;
#using scripts\common\ai\stealth\event;
#using scripts\common\ai\stealth\threat_sight;
#using scripts\common\ai\stealth\utility;
#using scripts\common\utility;
#using scripts\common\values;

#namespace stealth_manager;

// Namespace stealth_manager
// Params 0
// Checksum 0xa1f265c, Offset: 0x2f9
// Size: 0x29
function main()
{
    if ( isdefined( level.stealth ) )
    {
        return;
    }
    
    init();
    level thread teams_thread();
    
    /#
        thread debug::debug_manager();
    #/
}

// Namespace stealth_manager
// Params 0
// Checksum 0x7e53e23, Offset: 0x32a
// Size: 0x297
function init()
{
    utility::flag_set( "stealth_enabled" );
    level.stealth = spawnstruct();
    level.stealth.fov = spawnstruct();
    level.stealth.save = spawnstruct();
    level.stealth.corpsesynchtype = "DuringStealth";
    
    if ( !isdefined( level.var_e1e71383753ef63a ) )
    {
        set_stealth_bundle( level.gamemodebundle.stealthbundle );
        level.stealth.var_4f05136f0457bdc4 = level.gamemodebundle.stealthbundle;
    }
    
    /#
        level.stealth.debug = spawnstruct();
        level.stealth.debug.screen = [];
    #/
    
    level.stealth.funcs = [];
    setstealthdetectstate( "hidden" );
    corpse::corpse_init_level();
    event::event_init_level();
    level.stealth.next_sound_wait = 3000;
    level.stealth.head_shot_dist = 8;
    level.stealth.var_a93e300f45cfb89d = 15;
    level.stealth.group = spawnstruct();
    level.stealth.group.flags = [];
    level.stealth.group.groups = [];
    level.stealth.group.ally_groups = [];
    level.stealth.group.death_alert_timeout = [];
    level.stealth.hunting_groups = [];
    set_default_settings();
    init_stealth_volumes();
    init_save();
    level.stealth.min_alert_level_duration = 1;
    setup_stealth_funcs();
    
    if ( !isdefined( anim.smartobjects[ "hunt_point" ] ) )
    {
        hunt_point::main();
    }
    
    if ( !isdefined( anim.smartobjects[ "hunt_checkin" ] ) )
    {
        hunt_checkin::main();
    }
    
    level.bseq = spawnstruct();
    level.bseq.instancedata = [];
    debug::stealth_setup_devgui();
}

// Namespace stealth_manager
// Params 2
// Checksum 0x5454dba, Offset: 0x5c9
// Size: 0x142
function set_stealth_bundle( stealthbundlename, var_d35654bbf84d9b97 )
{
    main();
    
    /#
        if ( getdvarint( @"hash_e6afce2cf5cf7515" ) )
        {
            return;
        }
    #/
    
    if ( !isdefined( stealthbundlename ) )
    {
        return;
    }
    
    if ( isxhashasset( stealthbundlename ) )
    {
        stealthbundle = getscriptbundle( stealthbundlename );
    }
    else if ( isstring( stealthbundlename ) && stealthbundlename != "" )
    {
        stealthbundle = getscriptbundle( "stealthbundle:" + stealthbundlename );
    }
    
    if ( isdefined( stealthbundle ) )
    {
        thread set_stealth_bundle_internal( stealthbundle, stealthbundlename );
        
        if ( var_d35654bbf84d9b97 )
        {
            ais = getaiarray();
            
            foreach ( ai in ais )
            {
                ai setsightconfigtemplateoverride( stealthbundle.sightconfigtemplate );
            }
        }
        
        return;
    }
    
    /#
        if ( isxhashasset( stealthbundlename ) )
        {
            stealthbundlename = getxhashsourcename( stealthbundlename );
        }
    #/
    
    assertmsg( "<dev string:x24>" + stealthbundlename + "<dev string:x35>" );
}

// Namespace stealth_manager
// Params 2, eflags: 0x4
// Checksum 0x1107d09a, Offset: 0x713
// Size: 0x7fd
function private set_stealth_bundle_internal( stealthbundle, stealthbundlename = "undefined" )
{
    self notify( #"set_stealth_bundle_internal" );
    self endon( #"set_stealth_bundle_internal" );
    level.var_e1e71383753ef63a = stealthbundle;
    utility::flag_wait( "stealth_enabled" );
    level.var_e1e71383753ef63a = undefined;
    set_default_settings();
    level.stealth.sightconfigtemplate = stealthbundle.sightconfigtemplate;
    level.stealth.threatsightwidget = stealthbundle.threatsightwidget;
    level.stealth.threatsightanchor = stealthbundle.threatsightanchor;
    level.stealth.stealth_spotted_delay = stealthbundle.var_b396258737f8bbf5;
    level.stealth.var_632863d6fc6beca2 = stealthbundle.var_f05392e3b3509d09;
    level.stealth.sightedsfx = stealthbundle.var_c6d53ea21280fefe;
    level.stealth.spottedsfx = stealthbundle.spottedsfxname;
    level.stealth.var_4f05136f0457bdc4 = stealthbundlename;
    stealthsetusereallightingmodifierforvisibility( istrue( stealthbundle.var_fd369e7da2dede9f ) );
    level.stealth.huntmode = stealthbundle.hunttype ?? "Global";
    
    switch ( level.stealth.huntmode )
    {
        case #"hash_c24b16fb9788caee":
            stealthenablelocalizedhunt( 0 );
            stealthstayincombatoncealerted( 0 );
            break;
        case #"hash_4f2154ac90348b6a":
            stealthenablelocalizedhunt( 1 );
            stealthstayincombatoncealerted( 0 );
            break;
        case #"hash_ad8f23b9b8103745":
            stealthenablelocalizedhunt( 0 );
            stealthstayincombatoncealerted( 1 );
            break;
    }
    
    level.stealth.corpsesynchtype = stealthbundle.corpsesynchtype ?? "DuringStealth";
    
    foreach ( player in level.players )
    {
        setstealthdisguised( player, istrue( stealthbundle.sightdisguised ) );
        
        if ( isdefined( level.var_13c54c7e3c63bb6c ) )
        {
            player [[ level.var_13c54c7e3c63bb6c ]]( istrue( stealthbundle.socialstealth ) );
        }
        
        player val::reset_all( "stealthbundle" );
        
        switch ( level.stealth.corpsesynchtype )
        {
            case #"hash_1d7966a2fa479e24":
                player val::set( "stealthbundle", "ai_corpse_sync", 1 );
                break;
            case #"hash_616703241319aec9":
                break;
        }
    }
    
    setomnvar( "ai_fulllight", stealthbundle.var_4bc546099d4ac7ba ?? 0.01 );
    setomnvar( "ai_nolight", stealthbundle.var_2eef244f67994701 ?? 0 );
    
    if ( isdefined( stealthbundle.eventlist ) )
    {
        val::set( "stealthmanager", "ai_eventlist", stealthbundle.eventlist );
    }
    else
    {
        val::reset( "stealthmanager", "ai_eventlist" );
    }
    
    corpseranges = [];
    corpseranges[ "sight_dist" ] = stealthbundle.corpserangesight ?? 600;
    corpseranges[ "detect_dist" ] = stealthbundle.var_b052899a6e0b08b0 ?? 300;
    corpseranges[ "found_dist" ] = stealthbundle.var_1e3cbc389116a409 ?? 100;
    corpseranges[ "shadow_dist" ] = stealthbundle.var_3e743f878fd37d1f ?? 100;
    corpse::set_corpse_ranges( corpseranges );
    timetodropthreatsight = int( ( stealthbundle.var_8f5ecf2ffb01dd1a ?? 1 ) * 1000 );
    var_fe4ec84e3ed5ba37 = int( ( stealthbundle.var_2fde283d515fb33d ?? 10 ) * 1000 );
    var_4d3b9c856529d37a = int( ( stealthbundle.var_5ff6dc6840244054 ?? 2 ) * 1000 );
    timetolosetargetatlkp = int( ( stealthbundle.var_9f097519a6fb4f44 ?? 5 ) * 1000 );
    timetolosetargetnotatlkp = int( ( stealthbundle.var_4484b27f05e53117 ?? 1 ) * 1000 );
    var_903e608d061755fb = int( ( stealthbundle.var_52ed5aee9ae3aedb ?? 5 ) * 1000 );
    var_888c6959736237f9 = stealthbundle.var_2c1f60b0dee66677 ?? 1200;
    combatpingradius = stealthbundle.var_bb8353177aef36bb ?? 720;
    var_7f9c3047d49a6185 = stealthbundle.var_7298aaf190d9e5d6 ?? 640;
    var_eac11fe1e8a746c9 = stealthbundle.var_895d181c719dcd82 ?? 256;
    fromhuntpingradius = stealthbundle.var_abdf1187102c9672 ?? 720;
    combatgraceperiod = int( ( stealthbundle.aicombatgraceperiod ?? 2 ) * 1000 );
    threatsightdecayrate = stealthbundle.var_7c5bcde160152d61 ?? 1.5;
    curiousenemythreshold = stealthbundle.curiousenemythreshold ?? 0.33;
    var_615216107056ee4 = stealthbundle.coverblownatcombatspeed ?? 0;
    stealthsetdefaulttimetodropthreatsight( timetodropthreatsight );
    function_212f8ad752609f01( var_fe4ec84e3ed5ba37 );
    stealthsetdefaulttimetodropthreatsight_notincombat( var_4d3b9c856529d37a );
    stealthsettimetolosetargetatlkp( timetolosetargetatlkp );
    stealthsettimetolosetargetnotatlkp( timetolosetargetnotatlkp );
    stealthsetmincombattimebeforedrop( var_903e608d061755fb );
    stealthsetinitialcombatpingvisibleradius( var_888c6959736237f9 );
    stealthsetcombatpingradius( combatpingradius );
    stealthsettocombatbyproxpingradius( var_7f9c3047d49a6185 );
    stealthsettocombatbyenemyaiproxpingradius( var_eac11fe1e8a746c9 );
    stealthsettocombatfromhuntpingradius( fromhuntpingradius );
    level.stealth.var_4819c1af33f93f1e = stealthbundle.aidamagerangeperipheral ?? 1500;
    level.stealth.damage_sight_range = stealthbundle.aidamagerangesight ?? 1200;
    level.stealth.damage_auto_range = stealthbundle.aidamagerangeauto ?? 480;
    var_a9249da1098c2478 = stealthbundle.var_a9249da1098c2478 ?? 1;
    var_9930dbd295b53589 = stealthbundle.var_9930dbd295b53589 ?? 1;
    var_47d5ced3df70a1a5 = stealthbundle.var_47d5ced3df70a1a5 ?? 1;
    stealthsetcombatgraceperiod( combatgraceperiod );
    stealthsetthreatsightdecayrate( threatsightdecayrate );
    stealthsetcuriousenemythreshold( curiousenemythreshold );
    stealthsetinvestigatecoverblownatcombatspeed( var_615216107056ee4 );
    function_459b3e696ae60e6d( var_a9249da1098c2478 );
    function_6b6ddae0f4f28998( var_9930dbd295b53589 );
    function_ca032a56cc561288( var_47d5ced3df70a1a5 );
    var_877034ade0c47229 = stealthbundle.var_1fe1763560dc07b7 ?? 0.005;
    var_e8e185a79ba1b978 = stealthbundle.var_178f421821fa0ee4 ?? 120;
    var_4b7c2989d8f63873 = stealthbundle.var_4b7c2989d8f63873 ?? 300;
    function_ee0e9e6a1b61e38e( var_877034ade0c47229 );
    function_48fe7d614016f781( var_e8e185a79ba1b978 );
    function_c401fb26f2bb3234( var_4b7c2989d8f63873 );
    stealth_hidden = [];
    stealth_hidden[ "prone" ] = 9999;
    stealth_hidden[ "crouch" ] = 9999;
    stealth_hidden[ "stand" ] = 9999;
    stealth_spotted = [];
    stealth_spotted[ "prone" ] = 9999;
    stealth_spotted[ "crouch" ] = 9999;
    stealth_spotted[ "stand" ] = 9999;
    utility::set_detect_ranges( stealth_hidden, stealth_spotted );
}

// Namespace stealth_manager
// Params 0
// Checksum 0x919d0036, Offset: 0xf18
// Size: 0x60
function setup_stealth_funcs()
{
    level utility::set_stealth_func( "do_stealth", &utility::do_stealth );
    enemy::set_default_stealth_funcs();
    level.stealth.fngroupspottedflag = &utility::group_spotted_flag;
    level.stealth.fninitenemygame = undefined;
    level.stealth.var_8ef6173c91320106 = &callbacks::stealth_call_filter;
}

// Namespace stealth_manager
// Params 0
// Checksum 0x3b2cdb7f, Offset: 0xf80
// Size: 0x454
function set_default_settings()
{
    stealth_hidden = [];
    stealth_hidden[ "prone" ] = 1000;
    stealth_hidden[ "crouch" ] = 1800;
    stealth_hidden[ "stand" ] = 2800;
    stealth_spotted = [];
    stealth_spotted[ "prone" ] = 1800;
    stealth_spotted[ "crouch" ] = 2500;
    stealth_spotted[ "stand" ] = 4000;
    utility::set_detect_ranges( stealth_hidden, stealth_spotted );
    minrangedarkness_hidden = [];
    minrangedarkness_hidden[ "prone" ] = 130;
    minrangedarkness_hidden[ "crouch" ] = 215;
    minrangedarkness_hidden[ "stand" ] = 300;
    minrangedarkness_spotted = [];
    minrangedarkness_spotted[ "prone" ] = 300;
    minrangedarkness_spotted[ "crouch" ] = 375;
    minrangedarkness_spotted[ "stand" ] = 450;
    utility::set_min_detect_range_darkness( minrangedarkness_hidden, minrangedarkness_spotted );
    var_8dccc0c7cefe4d58 = [];
    var_8dccc0c7cefe4d58[ "prone" ] = 130;
    var_8dccc0c7cefe4d58[ "crouch" ] = 215;
    var_8dccc0c7cefe4d58[ "stand" ] = 300;
    var_1add7de235783339 = [];
    var_1add7de235783339[ "prone" ] = 300;
    var_1add7de235783339[ "crouch" ] = 375;
    var_1add7de235783339[ "stand" ] = 450;
    utility::set_min_detect_range_shadow( minrangedarkness_hidden, minrangedarkness_spotted );
    level.stealth.fov.cosine[ "blind" ] = 0.98;
    level.stealth.fov.cosinebusy[ "blind" ] = 0.98;
    level.stealth.fov.cosinez[ "blind" ] = 0;
    level.stealth.fov.ground[ "blind" ] = 0;
    level.stealth.fov.cosine[ "hidden" ] = 0.7;
    level.stealth.fov.cosinebusy[ "hidden" ] = 0.86;
    level.stealth.fov.cosinez[ "hidden" ] = 0.97;
    level.stealth.fov.ground[ "hidden" ] = 1;
    level.stealth.fov.cosine[ "investigate" ] = 0.7;
    level.stealth.fov.cosinebusy[ "investigate" ] = 0.86;
    level.stealth.fov.cosinez[ "investigate" ] = 0.97;
    level.stealth.fov.ground[ "investigate" ] = 1;
    level.stealth.fov.cosine[ "combat_hunt" ] = 0.7;
    level.stealth.fov.cosinebusy[ "combat_hunt" ] = 0.86;
    level.stealth.fov.cosinez[ "combat_hunt" ] = 0.97;
    level.stealth.fov.ground[ "combat_hunt" ] = 1;
    level.stealth.fov.cosine[ "spotted" ] = 0.01;
    level.stealth.fov.cosinebusy[ "spotted" ] = 0.574;
    level.stealth.fov.cosinez[ "spotted" ] = 0;
    level.stealth.fov.ground[ "spotted" ] = 0;
    corpse::set_corpse_ranges_default();
    event_change( "hidden" );
}

// Namespace stealth_manager
// Params 1
// Checksum 0x40e54696, Offset: 0x13dc
// Size: 0x120
function set_event_distances( array )
{
    foreach ( state, state_array in array )
    {
        assert( state == "<dev string:x43>" || state == "<dev string:x4a>", "<dev string:x52>" );
        
        foreach ( event, value in state_array )
        {
            setstealtheventrange( state, event, value );
            
            if ( getstealthdetectstate() == state )
            {
                seteventdefaultdistance( event, value );
                seteventdistancewhenbusy( event, value );
            }
        }
    }
}

// Namespace stealth_manager
// Params 2
// Checksum 0x1e578f94, Offset: 0x1504
// Size: 0x11e
function set_detect_ranges_internal( hidden, spotted )
{
    var_fe81d9c7dee4ec19 = 0.25;
    
    if ( isdefined( hidden ) )
    {
        setstealthdetectrange( "hidden", "prone", hidden[ "prone" ] );
        setstealthdetectrange( "hidden", "crouch", hidden[ "crouch" ] );
        setstealthdetectrange( "hidden", "stand", hidden[ "stand" ] );
        
        if ( !isdefined( hidden[ "shadow" ] ) )
        {
            hidden = arraycopy( hidden );
            hidden[ "shadow" ] = var_fe81d9c7dee4ec19;
        }
        
        setstealthdetectrange( "hidden", "shadow", hidden[ "shadow" ] );
    }
    
    if ( isdefined( spotted ) )
    {
        setstealthdetectrange( "spotted", "prone", spotted[ "prone" ] );
        setstealthdetectrange( "spotted", "crouch", spotted[ "crouch" ] );
        setstealthdetectrange( "spotted", "stand", spotted[ "stand" ] );
        
        if ( !isdefined( spotted[ "shadow" ] ) )
        {
            spotted = arraycopy( spotted );
            spotted[ "shadow" ] = var_fe81d9c7dee4ec19;
        }
        
        setstealthdetectrange( "spotted", "shadow", spotted[ "shadow" ] );
    }
}

// Namespace stealth_manager
// Params 0
// Checksum 0x4d4cdb7a, Offset: 0x162a
// Size: 0x1c0
function manager_thread()
{
    while ( true )
    {
        utility::flag_wait( "stealth_enabled" );
        threat_sight::threat_sight_set_dvar( 1 );
        
        if ( !playerlootenabled() && level.stealth.corpsesynchtype == "DuringStealth" )
        {
            foreach ( player in level.players )
            {
                player val::set( "stealthbundle", "ai_corpse_sync", 1 );
            }
        }
        
        utility::flag_wait( "stealth_spotted" );
        
        if ( !playerlootenabled() && level.stealth.corpsesynchtype == "DuringStealth" )
        {
            foreach ( player in level.players )
            {
                player val::reset( "stealthbundle", "ai_corpse_sync" );
            }
        }
        
        if ( !utility::flag( "stealth_enabled" ) )
        {
            continue;
        }
        
        event_change( "spotted" );
        utility::flag_waitopen( "stealth_spotted" );
        
        if ( !utility::flag( "stealth_enabled" ) )
        {
            continue;
        }
        
        event_change( "hidden" );
        waittillframeend();
    }
}

// Namespace stealth_manager
// Params 0
// Checksum 0x36d02d0b, Offset: 0x17f2
// Size: 0x152, Type: bool
function anyone_in_combat()
{
    if ( !isdefined( level.stealth ) )
    {
        return false;
    }
    
    if ( stealthgetanyaiincombat() )
    {
        return true;
    }
    
    now = gettime();
    
    if ( now > ( level.stealth.var_2d8aaec46dd267d5 ?? 0 ) )
    {
        level.stealth.var_2d8aaec46dd267d5 = now + 50;
        level.stealth.var_9be35a0934f7debc = undefined;
        ais = getaiunittypearray( "bad_guys", "all" );
        
        foreach ( guy in ais )
        {
            if ( !isdefined( guy.stealth ) && isdefined( guy.enemy ) && guy.enemy == self )
            {
                level.stealth.var_9be35a0934f7debc = 1;
                break;
            }
        }
    }
    
    return istrue( level.stealth.var_9be35a0934f7debc );
}

// Namespace stealth_manager
// Params 0
// Checksum 0x596ea8b0, Offset: 0x194d
// Size: 0x11b, Type: bool
function anyone_in_hunt()
{
    if ( !isdefined( level.stealth ) )
    {
        return false;
    }
    
    now = gettime();
    
    if ( now > ( level.stealth.var_6cb5bdfd0357c19a ?? 0 ) )
    {
        level.stealth.var_6cb5bdfd0357c19a = now + 50;
        level.stealth.var_b4c9ad22497afa63 = undefined;
        ais = getaiunittypearray( "axis" );
        
        foreach ( guy in ais )
        {
            if ( guy isinhunt() )
            {
                level.stealth.var_b4c9ad22497afa63 = 1;
                break;
            }
        }
    }
    
    return istrue( level.stealth.var_b4c9ad22497afa63 );
}

// Namespace stealth_manager
// Params 0
// Checksum 0x939b376c, Offset: 0x1a71
// Size: 0x11b, Type: bool
function function_bd4f6b8ae673c54e()
{
    if ( !isdefined( level.stealth ) )
    {
        return false;
    }
    
    now = gettime();
    
    if ( now > ( level.stealth.var_b903a82846d2e614 ?? 0 ) )
    {
        level.stealth.var_b903a82846d2e614 = now + 50;
        level.stealth.var_3694582d0f76d569 = undefined;
        ais = getaiunittypearray( "axis" );
        
        foreach ( guy in ais )
        {
            if ( guy isininvestigate() )
            {
                level.stealth.var_3694582d0f76d569 = 1;
                break;
            }
        }
    }
    
    return istrue( level.stealth.var_3694582d0f76d569 );
}

// Namespace stealth_manager
// Params 0
// Checksum 0xcaeaf24d, Offset: 0x1b95
// Size: 0x115
function update_stealth_spotted_thread()
{
    waitframe();
    wasspotted = 0;
    
    while ( true )
    {
        bspotted = anyone_in_combat();
        
        if ( bspotted )
        {
            if ( !wasspotted && isdefined( level.stealth.stealth_spotted_delay ) && level.stealth.stealth_spotted_delay > 0 )
            {
                wait level.stealth.stealth_spotted_delay;
                
                if ( !anyone_in_combat() )
                {
                    waitframe();
                    continue;
                }
            }
            
            if ( !utility::flag( "stealth_spotted" ) )
            {
                utility::flag_set( "stealth_spotted" );
                
                if ( isdefined( self.stealth ) )
                {
                    mygroupflagname = utility::get_group_flagname( "stealth_spotted" );
                    utility::flag_set( mygroupflagname );
                }
            }
        }
        else if ( utility::flag( "stealth_spotted" ) )
        {
            utility::flag_clear( "stealth_spotted" );
            
            if ( isdefined( self.stealth ) )
            {
                mygroupflagname = utility::get_group_flagname( "stealth_spotted" );
                utility::flag_clear( mygroupflagname );
            }
        }
        
        wasspotted = bspotted;
        waitframe();
    }
}

// Namespace stealth_manager
// Params 0
// Checksum 0xb2fa4f5e, Offset: 0x1cb2
// Size: 0x98
function teams_thread()
{
    level.stealth.enemies[ "axis" ] = [];
    level.stealth.enemies[ "allies" ] = [];
    
    while ( true )
    {
        utility::flag_wait( "stealth_enabled" );
        level.stealth.enemies[ "axis" ] = level.players;
        level.stealth.enemies[ "allies" ] = getaiarray( "axis" );
        wait 0.05;
    }
}

// Namespace stealth_manager
// Params 1
// Checksum 0x6f946b70, Offset: 0x1d52
// Size: 0x108
function event_change( name )
{
    setstealthdetectstate( name );
    ai_event = getstealtheventrangetable();
    
    foreach ( state, state_array in ai_event )
    {
        if ( state == name )
        {
            foreach ( key, event in state_array )
            {
                seteventdefaultdistance( key, event );
                seteventdistancewhenbusy( key, event );
            }
        }
    }
}

// Namespace stealth_manager
// Params 0
// Checksum 0x9d770b58, Offset: 0x1e62
// Size: 0x4d
function init_save()
{
    utility::flag_init( "stealth_player_nade" );
    level.stealth.save.player_nades = 0;
    
    if ( !utility::issp() )
    {
        return;
    }
    
    utility::array_thread( level.players, &player_grenade_check );
}

// Namespace stealth_manager
// Params 0
// Checksum 0x5cb5c61e, Offset: 0x1eb7
// Size: 0x45
function player_grenade_check()
{
    while ( true )
    {
        self waittill( #"grenade_pullback" );
        utility::flag_set( "stealth_player_nade" );
        self waittill( #"grenade_fire", grenade );
        thread player_grenade_check_dieout( grenade );
    }
}

// Namespace stealth_manager
// Params 1
// Checksum 0x2fc7804c, Offset: 0x1f04
// Size: 0x86
function player_grenade_check_dieout( grenade )
{
    level.stealth.save.player_nades++;
    grenade utility::waittill_notify_or_timeout( "death", 10 );
    level.stealth.save.player_nades--;
    waittillframeend();
    
    if ( !level.stealth.save.player_nades )
    {
        utility::flag_clear( "stealth_player_nade" );
    }
}

// Namespace stealth_manager
// Params 0
// Checksum 0x9a46266e, Offset: 0x1f92
// Size: 0x6bd
function init_stealth_volumes()
{
    level.stealth.combat_volumes = [];
    level.stealth.hunt_volumes = [];
    level.stealth.investigate_volumes = [];
    allvolumes = getentarray( "info_volume_stealth_all", #classname );
    volumes = arraycombine( getentarray( "info_volume_stealth_combat", #classname ), allvolumes );
    
    foreach ( vol in volumes )
    {
        if ( isdefined( vol.script_stealthgroup ) && vol.script_stealthgroup != "-1" )
        {
            assert( isdefined( vol.script_stealthgroup ), "<dev string:x9b>" + vol.origin );
            assert( vol.script_stealthgroup != "<dev string:xc8>" && vol.script_stealthgroup != "<dev string:xcb>", "<dev string:xcc>" + vol.origin );
            groups = strtok( vol.script_stealthgroup, " " );
            
            foreach ( group in groups )
            {
                /#
                    if ( level.var_d2460960855e0301 && ( group == "<dev string:x10f>" || group == "<dev string:x12f>" ) )
                    {
                        vol.ignoregroupassert = 1;
                    }
                    
                    if ( isdefined( level.stealth.combat_volumes[ group ] ) && !vol.ignoregroupassert )
                    {
                        assertmsg( "<dev string:x14f>" + group + "<dev string:x15e>" + vol.origin + "<dev string:x188>" + level.stealth.combat_volumes[ group ].origin );
                    }
                #/
                
                level.stealth.combat_volumes[ group ] = vol;
            }
        }
    }
    
    volumes = arraycombine( getentarray( "info_volume_stealth_hunt", #classname ), allvolumes );
    
    foreach ( vol in volumes )
    {
        if ( isdefined( vol.script_stealthgroup ) && vol.script_stealthgroup != "-1" )
        {
            assert( isdefined( vol.script_stealthgroup ), "<dev string:x18a>" + vol.origin );
            assert( vol.script_stealthgroup != "<dev string:xc8>" && vol.script_stealthgroup != "<dev string:xcb>", "<dev string:x1b5>" + vol.origin );
            groups = strtok( vol.script_stealthgroup, " " );
            
            foreach ( group in groups )
            {
                /#
                    if ( isdefined( level.stealth.hunt_volumes[ group ] ) && !vol.ignoregroupassert )
                    {
                        assertmsg( "<dev string:x14f>" + group + "<dev string:x1f6>" + vol.origin + "<dev string:x188>" + level.stealth.hunt_volumes[ group ].origin );
                    }
                #/
                
                level.stealth.hunt_volumes[ group ] = vol;
            }
        }
    }
    
    volumes = arraycombine( getentarray( "info_volume_stealth_investigate", #classname ), allvolumes );
    
    foreach ( vol in volumes )
    {
        if ( isdefined( vol.script_stealthgroup ) && vol.script_stealthgroup != "-1" )
        {
            assert( isdefined( vol.script_stealthgroup ), "<dev string:x21e>" + vol.origin );
            assert( vol.script_stealthgroup != "<dev string:xc8>" && vol.script_stealthgroup != "<dev string:xcb>", "<dev string:x250>" + vol.origin );
            groups = strtok( vol.script_stealthgroup, " " );
            
            foreach ( group in groups )
            {
                /#
                    if ( isdefined( level.stealth.investigate_volumes[ group ] ) && !vol.ignoregroupassert )
                    {
                        assertmsg( "<dev string:x14f>" + group + "<dev string:x298>" + vol.origin + "<dev string:x188>" + level.stealth.investigate_volumes[ group ].origin );
                    }
                #/
                
                level.stealth.investigate_volumes[ group ] = vol;
            }
        }
    }
}

// Namespace stealth_manager
// Params 0
// Checksum 0x3e31030f, Offset: 0x2657
// Size: 0x3d
function playerlootenabled()
{
    if ( isdefined( level.stealth ) && isdefined( level.stealth.fnplayerlootenabled ) )
    {
        return [[ level.stealth.fnplayerlootenabled ]]();
    }
    
    return 0;
}

