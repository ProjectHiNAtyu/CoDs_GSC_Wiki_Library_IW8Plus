// script_14d95c611b71b01  (hash_014d95c611b71b01.gscc) (size: 9945 Bytes / 0x26d9 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x884b1f43 (2286624579)
// size ...... 9945 (0x26d9)
// includes .. 8   (offset: 0x23b9)
// strings ... 49  (offset: 0x23f9)
// dev strs .. 4   (offset: 0x26a9)
// exports ... 16  (offset: 0x188d)
// cseg ...... 0x42f + 0x145e (0x188d)
// imports ... 71  (offset: 0x1b0d)
// animtree1 . 0   (offset: 0x26d9)
// animtree2 . 0   (offset: 0x26d9)
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\ai\ai_category;

#namespace zombie_health_bar;

// Namespace zombie_health_bar
// Params 0, eflags: 0x1
// Checksum 0xa0d0121c, Offset: 0x44d
// Size: 0x5c
function autoexec init_shared_funcs()
{
    utility::registersharedfunc( #"zombie_health_bar", #"init", &init_zombie_health_bar );
    utility::registersharedfunc( #"zombie_health_bar", #"show_health_bar", &show_health_bar );
    utility::registersharedfunc( #"zombie_health_bar", #"hide_health_bar", &hide_health_bar );
}

// Namespace zombie_health_bar
// Params 2
// Checksum 0x7b420151, Offset: 0x4b1
// Size: 0x245
function init_zombie_health_bar( entitymask, var_7d08054f2298e92a )
{
    if ( level.gametypebundle.var_2b2b2b9d474b70a )
    {
        return;
    }
    
    level.var_69ca1da6a51846f1 = [];
    
    if ( isdefined( level.projectbundle.aicategorylist ) )
    {
        categorybundle = getscriptbundle( level.projectbundle.aicategorylist );
        
        if ( isdefined( categorybundle ) )
        {
            foreach ( i, category in categorybundle.aicategorylist )
            {
                level.var_69ca1da6a51846f1[ category.ref ] = i + 1;
            }
        }
    }
    
    level callback::add( #"player_connect", &function_4948b481d67eb32e );
    level callback::add( #"hash_cc06eb1d45f33a0c", &function_775d799654b9b10b );
    level callback::add( #"player_leave_squad", &function_775d799654b9b10b );
    level callback::add( "killed_body_cloned", &on_killed_body_cloned );
    level.var_e24ae894c9026032 = throttle::throttle_initialize( "zombie_health_bar_update", getdvarint( @"hash_f1e6f827c6b38d", 2 ) );
    level.var_a7f34ec531059e61 = entitymask ?? createentitytypemask( [ "etype_ai", "etype_vehicle", "etype_turret" ] );
    level.var_846781221226ddae = istrue( var_7d08054f2298e92a );
    
    if ( !isdefined( level.var_d903fb657b446a4e ) )
    {
        level.var_d903fb657b446a4e = [];
    }
    
    level.difficulty_to_int[ "difficulty_undefined" ] = 0;
    level.difficulty_to_int[ "difficulty_easy" ] = 1;
    level.difficulty_to_int[ "difficulty_normal" ] = 2;
    level.difficulty_to_int[ "difficulty_hard" ] = 3;
    level.difficulty_to_int[ "difficulty_darkaether" ] = 4;
    level.difficulty_to_int[ "difficulty5" ] = 5;
    level.difficulty_to_int[ "difficulty6" ] = 6;
}

// Namespace zombie_health_bar
// Params 1, eflags: 0x4
// Checksum 0xdb33e19a, Offset: 0x6fe
// Size: 0x13
function private function_4948b481d67eb32e( params )
{
    thread function_20005c77e96e4bae();
}

// Namespace zombie_health_bar
// Params 1, eflags: 0x4
// Checksum 0x21104ace, Offset: 0x719
// Size: 0x13
function private function_775d799654b9b10b( params )
{
    thread hide_health_bar();
}

// Namespace zombie_health_bar
// Params 1
// Checksum 0x9d04592b, Offset: 0x734
// Size: 0xf1
function on_killed_body_cloned( params )
{
    playerattacker = params.eattacker;
    
    if ( isdefined( playerattacker ) && !isplayer( playerattacker ) && isplayer( playerattacker.owner ) )
    {
        playerattacker = playerattacker.owner;
    }
    
    if ( isplayer( playerattacker ) )
    {
        var_f8c8d8dc36ccd59 = self getentitynumber();
        
        if ( var_f8c8d8dc36ccd59 == playerattacker.var_e53b7c492f1d1a8c )
        {
            var_3bc73cc045a63be = 0;
            
            if ( isdefined( self.last_dmg_struct ) )
            {
                var_3bc73cc045a63be = istrue( self.last_dmg_struct.biscritical );
            }
            
            playerattacker function_c67975f4a693a431( "ui_target_last_dmg_crit", var_3bc73cc045a63be );
            corpse = zombie_utils::function_4e99fb1239980783( params );
            
            if ( isdefined( corpse ) )
            {
                var_dd450b05ffe139f7 = corpse getentitynumber();
                playerattacker setclientomnvar( "ui_target_corpse_entity_num", var_dd450b05ffe139f7 );
            }
        }
    }
}

// Namespace zombie_health_bar
// Params 4
// Checksum 0xfdafc11, Offset: 0x82d
// Size: 0xca
function function_c67975f4a693a431( omnvarname, value, omnvarnotify, var_ced12ecbfca36840 )
{
    if ( !isdefined( value ) )
    {
        return;
    }
    
    value = int( clamp( value, -1, 2147483646 ) );
    var_667b7d0ae074fc0f = isdefined( self.targethealthinfo[ omnvarname ] );
    var_abaebd714af3eb68 = var_667b7d0ae074fc0f && value != self.targethealthinfo[ omnvarname ];
    
    if ( !var_667b7d0ae074fc0f || var_abaebd714af3eb68 )
    {
        self setclientomnvar( omnvarname, value );
        
        if ( isdefined( omnvarnotify ) && var_abaebd714af3eb68 && var_ced12ecbfca36840 == self.targethealthinfo[ "ui_target_entity_num" ] )
        {
            self setclientomnvar( omnvarnotify, gettime() );
        }
        
        self.targethealthinfo[ omnvarname ] = value;
    }
}

// Namespace zombie_health_bar
// Params 0
// Checksum 0x6bd2a91b, Offset: 0x8ff
// Size: 0x86b
function function_20005c77e96e4bae()
{
    self endon( #"disconnect" );
    self.var_e53b7c492f1d1a8c = -1;
    self.targethealthinfo = [];
    self.var_75e1facf90094025 = 0;
    var_dd07a0d9238b357f = 0;
    var_292167189b7dd1b9 = 0;
    var_d676e0de706f7b87 = 0;
    var_cdaf81e9972abf82 = undefined;
    var_900454972682a76a = -1;
    var_380f1c80ff1ed6e3 = 0;
    var_a988e6cf13b77a02 = 0;
    setdvarifuninitialized( @"hash_6d6c52eb3ebea9e6", 1000 );
    var_69740f67c85d2915 = getdvarint( @"hash_6d6c52eb3ebea9e6" );
    tracecontents = trace::create_contents( 1, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 0 );
    
    while ( true )
    {
        if ( self.sessionstate != "playing" )
        {
            waitframe();
            continue;
        }
        
        viewer = self;
        tracestart = undefined;
        var_30736d696a032221 = cos( 30 );
        
        if ( isplayer( viewer ) && viewer getcamerathirdperson() )
        {
            tracestart = viewer getcamerathirdpersonorigin();
            var_30736d696a032221 = cos( 80 );
        }
        else if ( issentient( self.vehicle ) )
        {
            viewer = self.vehicle;
            tracestart = viewer geteye() + ( 0, 0, self getplayerviewheight() / 2 );
        }
        else
        {
            tracestart = viewer getvieworigin();
        }
        
        playerangles = self getplayerangles();
        playerlookdir = anglestoforward( playerangles );
        tracedist = 2500;
        
        if ( self playerads() || isdefined( var_cdaf81e9972abf82 ) && var_cdaf81e9972abf82.var_7191d4cef2584a89 )
        {
            tracedist = 7500;
        }
        
        traceend = tracestart + playerlookdir * tracedist;
        traceradius = distance( tracestart, traceend );
        var_413c0caeb58e4e10 = 0;
        var_aabe89fe02c4b1ef = getentitiesinradiusfrompartitiongrid( tracestart, traceradius, level.var_a7f34ec531059e61, [ self ] );
        hitentity = undefined;
        
        foreach ( additional_ent in level.var_d903fb657b446a4e )
        {
            if ( isalive( additional_ent ) )
            {
                var_aabe89fe02c4b1ef = arraycombineunique( var_aabe89fe02c4b1ef, [ additional_ent ] );
            }
        }
        
        foreach ( ent in var_aabe89fe02c4b1ef )
        {
            if ( !ent.var_24954f14e27b448d || !ent val::get( "show_healthbar" ) )
            {
                continue;
            }
            
            var_c527272f7a17e566 = vectordot( playerlookdir, vectornormalize( ent.origin - viewer.origin ) );
            
            if ( var_c527272f7a17e566 > var_30736d696a032221 )
            {
                var_413c0caeb58e4e10 = 1;
                var_10906dc66b1c7aaf = ent.var_10906dc66b1c7aaf;
                
                if ( var_10906dc66b1c7aaf > 0 && distancesquared( ent.origin, viewer.origin ) < squared( var_10906dc66b1c7aaf ) )
                {
                    if ( isdefined( ent.var_67509ae578e4ed55 ) && ent [[ ent.var_67509ae578e4ed55 ]]( var_c527272f7a17e566 ) )
                    {
                        hitentity = ent;
                        break;
                    }
                    
                    point = tracestart + playerlookdir * distance( ent getcentroid(), tracestart );
                    var_f9ce72cecd9e7223 = ent getcentroid() + ent getboundshalfsize();
                    var_f9f168cecdc4a3dd = ent getcentroid() - ent getboundshalfsize();
                    var_42d8a0ae3cde96c4 = math::function_47d0ed373b25c699( point, var_f9f168cecdc4a3dd, var_f9ce72cecd9e7223 );
                    
                    if ( var_42d8a0ae3cde96c4 )
                    {
                        hitentity = ent;
                    }
                }
                
                break;
            }
        }
        
        waitframe();
        
        if ( var_413c0caeb58e4e10 )
        {
            ignoreents = [];
            ignoreents[ ignoreents.size ] = self;
            var_6fe8e27e7e659e6e = self isvehicleactive();
            results = physics_raycast( tracestart, traceend, tracecontents, ignoreents, var_6fe8e27e7e659e6e, "physicsquery_closest", 0, 1 );
            
            if ( results.size )
            {
                results = results[ 0 ];
            }
            else
            {
                results = [ "hittype":"hittype_none", "contact_normal":( 0, 0, 0 ), "normal":( 0, 0, 0 ), "shape_position":traceend, "position":traceend, "distance":0, "surfaceflags":0, "fraction":1 ];
            }
            
            var_7510e3d4e7162779 = isdefined( results[ "entity" ] ) && results[ "entity" ].var_24954f14e27b448d && results[ "entity" ] val::get( "show_healthbar" );
            hitentity = var_7510e3d4e7162779 ? results[ "entity" ] : hitentity;
            frametime = gettime();
            var_d9fec33f7cdd28ec = hitentity.var_24954f14e27b448d && hitentity val::get( "show_healthbar" ) && !( level.var_846781221226ddae && hitentity.team == self.team );
            
            if ( !isbrgamemode() && var_d9fec33f7cdd28ec && hitentity.team != self.team )
            {
                var_9c8c3ee485dcac7a = utility::iszm() ? "zmHealthbarVisible" : "obHealthbarVisible";
                gamerprofilevalue = self.pers[ "sharedGamerProfiles" ][ var_9c8c3ee485dcac7a ];
                
                if ( gamerprofilevalue )
                {
                    switch ( gamerprofilevalue )
                    {
                        case 0:
                            var_d9fec33f7cdd28ec = 0;
                            break;
                        case 1:
                            var_d9fec33f7cdd28ec = 1;
                            break;
                    }
                    
                    if ( hitentity.type == "zombie" )
                    {
                        switch ( gamerprofilevalue )
                        {
                            case 2:
                                var_d9fec33f7cdd28ec = hitentity.aicategory == "normal";
                                break;
                            case 3:
                                var_d9fec33f7cdd28ec = hitentity.aicategory != "normal";
                                break;
                        }
                    }
                    else if ( ai_category::function_e6e323e14b12152e( hitentity ) != #"unknown" )
                    {
                        var_b26255e96e371089 = ai_category::function_4c80eeabb07939c1( hitentity.kiastring ) || ai_category::function_76252ef8d8fa6517( hitentity.kiastring );
                        
                        switch ( gamerprofilevalue )
                        {
                            case 2:
                                var_d9fec33f7cdd28ec = !var_b26255e96e371089;
                                break;
                            case 3:
                                var_d9fec33f7cdd28ec = var_b26255e96e371089;
                                break;
                        }
                    }
                    else
                    {
                        assert( "<dev string:x24>" );
                    }
                }
            }
            
            if ( var_d9fec33f7cdd28ec )
            {
                var_dd07a0d9238b357f = 1;
                self.var_75e1facf90094025 = 0;
            }
            else if ( self.var_75e1facf90094025 )
            {
                var_cdaf81e9972abf82 = undefined;
                var_900454972682a76a = -1;
                self.var_75e1facf90094025 = 0;
            }
            else if ( isdefined( var_cdaf81e9972abf82 ) )
            {
                if ( var_dd07a0d9238b357f )
                {
                    var_380f1c80ff1ed6e3 = frametime;
                    var_dd07a0d9238b357f = 0;
                    var_292167189b7dd1b9 = 1;
                }
                
                if ( var_380f1c80ff1ed6e3 + var_69740f67c85d2915 > frametime && ( !isdefined( var_cdaf81e9972abf82.using_fake_health ) || !var_a988e6cf13b77a02 ) )
                {
                    hitentity = var_cdaf81e9972abf82;
                    var_d9fec33f7cdd28ec = 1;
                }
                else
                {
                    var_cdaf81e9972abf82.var_ec7fc0485821787b = 0;
                    var_cdaf81e9972abf82 = undefined;
                    var_900454972682a76a = -1;
                }
            }
            
            if ( var_d9fec33f7cdd28ec )
            {
                show_health_bar( hitentity, viewer );
                entitynum = hitentity getentitynumber();
                
                if ( entitynum != var_900454972682a76a )
                {
                    if ( isdefined( var_cdaf81e9972abf82 ) )
                    {
                        var_cdaf81e9972abf82.var_ec7fc0485821787b = 0;
                    }
                    
                    var_cdaf81e9972abf82 = hitentity;
                    var_900454972682a76a = entitynum;
                    var_cdaf81e9972abf82 thread function_45f5232348145a3f( self );
                }
            }
            else if ( var_292167189b7dd1b9 )
            {
                hide_health_bar();
                var_292167189b7dd1b9 = 0;
            }
            
            if ( isdefined( hitentity ) && hitentity.var_80bfd8beda20e707 )
            {
                function_b17c0db957526b2b( hitentity );
                var_d676e0de706f7b87 = 1;
            }
            else if ( var_d676e0de706f7b87 )
            {
                function_c67975f4a693a431( "ui_target_nameplate_vis", 0 );
                var_d676e0de706f7b87 = 0;
            }
        }
        else if ( isdefined( self.targethealthinfo[ "ui_target_entity_num" ] ) && self.targethealthinfo[ "ui_target_entity_num" ] != -1 )
        {
            hide_health_bar();
        }
        
        throttle::throttle_wait_in_queue( level.var_e24ae894c9026032, self );
    }
}

// Namespace zombie_health_bar
// Params 2
// Checksum 0xad40e6ac, Offset: 0x1172
// Size: 0x4c2
function show_health_bar( hitentity, viewer )
{
    if ( isdefined( hitentity.using_fake_health ) )
    {
        assert( !isdefined( hitentity.var_cce7c67ea2da8902 ) || hitentity.var_cce7c67ea2da8902 <= 2147483646 );
        assert( !isdefined( hitentity.var_d165d33ad4f00e17 ) || hitentity.var_d165d33ad4f00e17 <= 2147483646 );
    }
    else
    {
        assert( !isdefined( hitentity.health ) || hitentity.health <= 2147483646 );
        assert( !isdefined( hitentity.maxhealth ) || hitentity.maxhealth <= 2147483646 );
    }
    
    stateid = 0;
    
    if ( hitentity zombie_utils::function_bf1464d09f4e4b40() && self.team == hitentity.team && !hitentity.var_6298584c895e2be0 )
    {
        stateid = 1;
    }
    else if ( hitentity.var_6298584c895e2be0 )
    {
        stateid = 2;
    }
    
    categoryid = 0;
    
    if ( isdefined( hitentity.aicategory ) )
    {
        categoryid = level.var_69ca1da6a51846f1[ hitentity.aicategory ] ?? categoryid;
    }
    
    var_9b6e47c336e3ded2 = hitentity.nameindex ?? 0;
    settingsid = hitentity.healthbarsettingsid ?? -1;
    entitynum = undefined;
    
    if ( isdefined( hitentity.parententnum ) )
    {
        entitynum = hitentity.parententnum;
    }
    else
    {
        entitynum = hitentity getentitynumber();
    }
    
    self.var_e53b7c492f1d1a8c = entitynum;
    var_e7b67b42155f71ee = -1;
    
    if ( !utility::iszm() && ( ai_category::function_e6e323e14b12152e( hitentity ) == #"elite" || ai_category::function_e6e323e14b12152e( hitentity ) == #"hvt" ) )
    {
        var_e7b67b42155f71ee = 7;
    }
    else if ( isdefined( hitentity.difficulty ) && isdefined( level.difficulty_to_int ) )
    {
        var_e7b67b42155f71ee = level.difficulty_to_int[ hitentity.difficulty ];
    }
    
    if ( hitentity.classname == "player" )
    {
        if ( hitentity.team == viewer.team )
        {
            stateid = 2;
        }
        else
        {
            stateid = 3;
        }
    }
    
    var_fd441ecec31b0171 = hitentity get_status_effects_flags();
    clientid = -1;
    
    if ( isdefined( hitentity.clientid ) && hitentity.classname == "player" )
    {
        clientid = entitynum;
    }
    
    armorPlateCount = 0;
    
    if ( isdefined( hitentity.platecarrierlevel ) )
    {
        armorPlateCount = hitentity.platecarrierlevel;
    }
    
    function_c67975f4a693a431( "ui_target_settings", settingsid );
    function_c67975f4a693a431( "ui_target_category", categoryid );
    function_c67975f4a693a431( "ui_target_difficulty", var_e7b67b42155f71ee );
    function_c67975f4a693a431( "ui_target_plate_count", armorPlateCount );
    function_c67975f4a693a431( "ui_target_name_index", var_9b6e47c336e3ded2 );
    function_c67975f4a693a431( "ui_target_state", stateid, "ui_target_state_notify", entitynum );
    function_c67975f4a693a431( "ui_target_client_id", clientid );
    function_c67975f4a693a431( "ui_target_status_effects", var_fd441ecec31b0171 );
    armorhealthval = -1;
    maxarmorhealthval = -1;
    
    if ( isdefined( hitentity.armorhealth ) )
    {
        armorhealthval = hitentity.armorhealth;
        maxarmorhealthval = hitentity.maxarmorhealth;
    }
    
    function_c67975f4a693a431( "ui_target_armor_health", armorhealthval, "ui_target_armor_notify", entitynum );
    function_c67975f4a693a431( "ui_target_max_armor_health", maxarmorhealthval, "ui_target_armor_notify", entitynum );
    var_3bc73cc045a63be = 0;
    
    if ( isdefined( hitentity.last_dmg_struct ) )
    {
        var_3bc73cc045a63be = istrue( hitentity.last_dmg_struct.biscritical );
    }
    
    function_c67975f4a693a431( "ui_target_last_dmg_crit", var_3bc73cc045a63be );
    
    if ( isdefined( hitentity.using_fake_health ) )
    {
        function_c67975f4a693a431( "ui_target_max_health", hitentity.var_d165d33ad4f00e17, "ui_target_health_notify", entitynum );
        function_c67975f4a693a431( "ui_target_health", hitentity.var_cce7c67ea2da8902, "ui_target_health_notify", entitynum );
        var_a988e6cf13b77a02 = hitentity.var_cce7c67ea2da8902 <= 0;
    }
    else
    {
        function_c67975f4a693a431( "ui_target_max_health", hitentity.maxhealth, "ui_target_health_notify", entitynum );
        function_c67975f4a693a431( "ui_target_health", hitentity.health, "ui_target_health_notify", entitynum );
    }
    
    function_c67975f4a693a431( "ui_target_entity_num", entitynum );
}

// Namespace zombie_health_bar
// Params 0
// Checksum 0x672d82ac, Offset: 0x163c
// Size: 0x24
function get_status_effects_flags()
{
    flags = 0;
    
    if ( self.var_7d107b7503b87ff5 )
    {
        flags |= 1;
    }
    
    return flags;
}

// Namespace zombie_health_bar
// Params 0
// Checksum 0x6821525, Offset: 0x1669
// Size: 0x1e
function hide_health_bar()
{
    function_c67975f4a693a431( "ui_target_entity_num", -1 );
    function_c67975f4a693a431( "ui_target_client_id", -1 );
}

// Namespace zombie_health_bar
// Params 1
// Checksum 0x7476ca0e, Offset: 0x168f
// Size: 0x47
function function_45f5232348145a3f( var_7ec3d3be60a69589 )
{
    self.var_ec7fc0485821787b = 1;
    var_ef15f021280b9404 = function_456e9715230ed8fe( var_7ec3d3be60a69589 );
    
    if ( !isdefined( var_ef15f021280b9404 ) && isdefined( var_7ec3d3be60a69589 ) )
    {
        var_7ec3d3be60a69589.var_75e1facf90094025 = 1;
    }
}

// Namespace zombie_health_bar
// Params 1
// Checksum 0xcebdfba1, Offset: 0x16de
// Size: 0x44
function function_456e9715230ed8fe( var_7ec3d3be60a69589 )
{
    self endon( #"death" );
    
    while ( isdefined( var_7ec3d3be60a69589 ) && self.var_ec7fc0485821787b && isalive( self ) )
    {
        waitframe();
    }
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    return 1;
}

// Namespace zombie_health_bar
// Params 1
// Checksum 0xb4d52cf3, Offset: 0x172b
// Size: 0x89
function function_b17c0db957526b2b( hitentity )
{
    settingsid = hitentity.healthbarsettingsid ?? -1;
    var_9b6e47c336e3ded2 = hitentity.nameindex ?? 0;
    entitynum = hitentity getentitynumber();
    function_c67975f4a693a431( "ui_target_settings", settingsid );
    function_c67975f4a693a431( "ui_target_name_index", var_9b6e47c336e3ded2 );
    function_c67975f4a693a431( "ui_target_entity_num", entitynum );
    function_c67975f4a693a431( "ui_target_nameplate_vis", 1 );
}

// Namespace zombie_health_bar
// Params 1
// Checksum 0x77367fe, Offset: 0x17bc
// Size: 0xa5
function function_fe8a1246b153d8d9( var_f4c3b461b46544d9 )
{
    if ( !isdefined( level.var_d903fb657b446a4e ) )
    {
        level.var_d903fb657b446a4e = [];
    }
    
    if ( isai( var_f4c3b461b46544d9 ) )
    {
        assertmsg( "<dev string:x61>" );
        return;
    }
    else if ( !var_f4c3b461b46544d9.var_24954f14e27b448d && !var_f4c3b461b46544d9 val::get( "show_healthbar" ) )
    {
        assertmsg( "<dev string:xd6>" );
        return;
    }
    
    level.var_d903fb657b446a4e = arraycombineunique( level.var_d903fb657b446a4e, [ var_f4c3b461b46544d9 ] );
    assert( level.var_d903fb657b446a4e.size < 50, "<dev string:x151>" );
}

// Namespace zombie_health_bar
// Params 1
// Checksum 0xd499d918, Offset: 0x1869
// Size: 0x24
function function_4e46258837da5995( ent_to_remove )
{
    level.var_d903fb657b446a4e = arrayremove( level.var_d903fb657b446a4e, ent_to_remove );
}

