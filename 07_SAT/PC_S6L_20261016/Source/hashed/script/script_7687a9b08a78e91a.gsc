// script_7687a9b08a78e91a  (hash_7687a9b08a78e91a.gscc) (size: 11903 Bytes / 0x2e7f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x673d7aa1 (1732082337)
// size ...... 11903 (0x2e7f)
// includes .. 13  (offset: 0x2a0b)
// strings ... 37  (offset: 0x2a73)
// dev strs .. 43  (offset: 0x2c73)
// exports ... 33  (offset: 0x1b43)
// cseg ...... 0x39e + 0x17a5 (0x1b43)
// imports ... 79  (offset: 0x206b)
// animtree1 . 0   (offset: 0x2e7f)
// animtree2 . 0   (offset: 0x2e7f)
#using scripts\common\devgui;
#using scripts\common\scriptable;
#using scripts\common\utility;
#using scripts\mp\br\gametypes\br_map_quest;
#using scripts\mp\calloutmarkerping;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\damagefeedback;
#using scripts\mp\flags;
#using scripts\mp\loot\common_cache;
#using scripts\mp\loot\common_item;
#using scripts\mp\stationary_notes;

#namespace weapon_testing_plans;

// Namespace weapon_testing_plans
// Params 0, eflags: 0x5
// Checksum 0x6fa12b9d, Offset: 0x3bc
// Size: 0x9
function private autoexec main()
{
    init();
}

// Namespace weapon_testing_plans
// Params 0
// Checksum 0x2ac236ea, Offset: 0x3cd
// Size: 0x6f
function init()
{
    quest = { #on_disabled:&on_disabled, #on_prematch_end:&on_prematch_end, #on_start:&on_start, #on_init:&on_init, #name:"weapon_testing_plans" };
    br_map_quest::register( quest );
    
    /#
        thread function_a58c53d22894d46a();
        initdevgui();
    #/
}

// Namespace weapon_testing_plans
// Params 0
// Checksum 0x6f22453f, Offset: 0x444
// Size: 0x9
function on_init()
{
    function_df92eb822e90aafd();
}

// Namespace weapon_testing_plans
// Params 0
// Checksum 0x2bfaef48, Offset: 0x455
// Size: 0x9
function on_start()
{
    function_c7db8121a93faef3();
}

// Namespace weapon_testing_plans
// Params 0
// Checksum 0xf140c87b, Offset: 0x466
// Size: 0x10
function on_prematch_end()
{
    function_79078bb8bf4d2e79();
    function_3b19c57f6d9e73c1();
}

// Namespace weapon_testing_plans
// Params 0
// Checksum 0xca559faf, Offset: 0x47e
// Size: 0x9
function on_disabled()
{
    thread disablestationarynotes();
}

// Namespace weapon_testing_plans
// Params 0
// Checksum 0x693bbbd1, Offset: 0x48f
// Size: 0x46
function function_c7db8121a93faef3()
{
    stationary_notes::function_2862b36e46b40121( "weapon_testing_plan_a", "stationary_note_weapon_testing_plan_a" );
    stationary_notes::function_2862b36e46b40121( "weapon_testing_plan_b", "stationary_note_weapon_testing_plan_b" );
    stationary_notes::function_2862b36e46b40121( "weapon_testing_plan_c", "stationary_note_weapon_testing_plan_c" );
    stationary_notes::function_2862b36e46b40121( "weapon_testing_plan_d", "stationary_note_weapon_testing_plan_d" );
}

// Namespace weapon_testing_plans
// Params 0
// Checksum 0x9f9dc7cf, Offset: 0x4dd
// Size: 0x13
function function_79078bb8bf4d2e79()
{
    calloutmarkerping::function_572853cf60de7300( "weapon_testing_plans_dummy", "ping_objective_go_generic" );
}

// Namespace weapon_testing_plans
// Params 0
// Checksum 0xf94c63d1, Offset: 0x4f8
// Size: 0x294
function function_df92eb822e90aafd()
{
    weapontestingplans = [];
    var_82515603ee4f736d = getscriptbundle( %"hash_784899428c858c7b" );
    
    foreach ( var_71de864a0c0207ae in var_82515603ee4f736d.var_e3948006798267c7 )
    {
        var_1807717870027ffd = getxhashhexname( var_71de864a0c0207ae.weapontestingplan );
        killswitch = hashcat( @"hash_928b6f76708507c0", var_1807717870027ffd, "_disabled" );
        
        if ( getdvarint( killswitch, 0 ) )
        {
            continue;
        }
        
        plan = spawnstruct();
        weapontestingtasks = [];
        weapontestingperks = [];
        var_31828a805a3b1719 = getscriptbundle( var_71de864a0c0207ae.weapontestingplan );
        
        foreach ( var_9646dcde143d09fa in var_31828a805a3b1719.var_bae14566823bf84b )
        {
            var_bf4c5477bb8fda3f = getscriptbundle( var_9646dcde143d09fa.weapontestingtask );
            weapontestingtasks[ weapontestingtasks.size ] = var_bf4c5477bb8fda3f;
        }
        
        foreach ( var_faa564b3e2ffebb1 in var_31828a805a3b1719.var_39a8399c38d37ba6 )
        {
            weapontestingperks[ weapontestingperks.size ] = var_faa564b3e2ffebb1.perkref;
        }
        
        plan.tasks = weapontestingtasks;
        plan.perkrewards = weapontestingperks;
        plan.scoreevent = var_31828a805a3b1719.scoreevent ?? "";
        plan.var_74030fcf087ad767 = var_31828a805a3b1719.var_74030fcf087ad767 ?? "";
        weapontestingplans[ weapontestingplans.size ] = plan;
    }
    
    level.weapontestingplans = weapontestingplans;
}

// Namespace weapon_testing_plans
// Params 3
// Checksum 0x51e58010, Offset: 0x794
// Size: 0x7b
function function_e84ca23e035eb20e( planid, taskid, var_6353fbd5008dead2 )
{
    eventparams = [ "plan_id", planid, "task_id", taskid, "plan_completed", var_6353fbd5008dead2, "team", self.team ];
    self dlog_recordplayerevent( "dlog_event_br_weapon_testing_plans_completion", eventparams );
}

// Namespace weapon_testing_plans
// Params 0
// Checksum 0x83efa8c8, Offset: 0x817
// Size: 0x1a0
function function_3b19c57f6d9e73c1()
{
    var_591179e11fe1684 = getentitylessscriptablearray( "weapon_testing_dummy", #targetname );
    
    if ( var_591179e11fe1684.size <= 0 )
    {
        return;
    }
    
    var_59ac0d787dcd536d = clamp( getdvarint( @"scr_weapon_testing_plans_dummy_count", 4 ), 0, var_591179e11fe1684.size - 1 );
    var_26ac7d0063938940 = [];
    
    for ( i = 0; i < var_59ac0d787dcd536d ; i++ )
    {
        var_9f90e74d62ecbd4d = utility::random_key( var_591179e11fe1684 );
        var_26ac7d0063938940[ var_26ac7d0063938940.size ] = var_591179e11fe1684[ var_9f90e74d62ecbd4d ];
        var_591179e11fe1684[ var_9f90e74d62ecbd4d ] = undefined;
        
        if ( isint( var_9f90e74d62ecbd4d ) )
        {
            function_cdc669dbc8ea2101( var_591179e11fe1684 );
        }
    }
    
    scriptable::scriptable_adddamagedcallback( &function_26e59941580ff806 );
    
    foreach ( dummy in var_26ac7d0063938940 )
    {
        dummy setscriptablepartstate( "base", "visible" );
    }
    
    foreach ( dummy in var_591179e11fe1684 )
    {
        dummy setscriptablepartstate( "base", "disabled" );
    }
    
    level.var_9385f203880b542a = var_26ac7d0063938940;
}

// Namespace weapon_testing_plans
// Params 0
// Checksum 0x7cf3528f, Offset: 0x9bf
// Size: 0x10c
function function_83cc93a10cc02fcc()
{
    var_372cf0a4647c709a = [];
    
    foreach ( var_1ec16cd81870859b, plan in level.weapontestingplans )
    {
        var_372cf0a4647c709a[ var_1ec16cd81870859b ] = [];
        
        foreach ( taskindex, task in plan.tasks )
        {
            var_372cf0a4647c709a[ var_1ec16cd81870859b ][ taskindex ] = task.hitcount ?? 1;
        }
    }
    
    return var_372cf0a4647c709a;
}

// Namespace weapon_testing_plans
// Params 11
// Checksum 0x786b043e, Offset: 0xad4
// Size: 0x90
function function_26e59941580ff806( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance.type === "weapon_testing_plans_dummy" )
    {
        function_60a63096805cb69b( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname );
    }
}

// Namespace weapon_testing_plans
// Params 11
// Checksum 0x85e029f4, Offset: 0xb6c
// Size: 0xa7
function function_60a63096805cb69b( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( !isplayer( eattacker ) )
    {
        instance setscriptablepartstate( "health", "base_health" );
        return;
    }
    
    if ( !instance.dead )
    {
        function_e7618125b23b5eaa( eattacker, objweapon, instance );
    }
    
    eattacker function_4ababdc6c8ee6b0( objweapon, instance );
}

// Namespace weapon_testing_plans
// Params 3
// Checksum 0x4306aabf, Offset: 0xc1b
// Size: 0xc8
function function_e7618125b23b5eaa( eattacker, objweapon, instance )
{
    instance.dead = 1;
    eattacker damagefeedback::updatehitmarker( "standard", 0, 0, 0, undefined );
    impactstate = function_dd01dfa571b21cdb( objweapon ) ? "large_" : "small_";
    instance.impactindex = instance.impactindex === "01" ? "02" : "01";
    waitframe();
    instance setscriptablepartstate( "impact", impactstate + instance.impactindex );
    instance setscriptablepartstate( "health", "base_health" );
    instance.dead = 0;
}

// Namespace weapon_testing_plans
// Params 1
// Checksum 0x60f1c7b7, Offset: 0xceb
// Size: 0x5d, Type: bool
function function_dd01dfa571b21cdb( objweapon )
{
    switch ( objweapon.classname )
    {
        case #"hash_6191aaef9f922f96":
        case #"hash_61e969dacaaf9881":
        case #"hash_e224d0b635d0dadd":
        case #"hash_fa24dff6bd60a12d":
            return !objweapon.ismelee;
    }
    
    return false;
}

// Namespace weapon_testing_plans
// Params 2
// Checksum 0x6139de6a, Offset: 0xd51
// Size: 0x11d
function function_4ababdc6c8ee6b0( objweapon, instance )
{
    if ( !isdefined( self.var_372cf0a4647c709a ) )
    {
        self.var_372cf0a4647c709a = function_83cc93a10cc02fcc();
    }
    
    foreach ( var_1ec16cd81870859b, plan in level.weapontestingplans )
    {
        foreach ( taskindex, task in plan.tasks )
        {
            function_54f13e062fcf9a53( var_1ec16cd81870859b, taskindex, objweapon, instance );
        }
    }
}

// Namespace weapon_testing_plans
// Params 4
// Checksum 0x10ac4920, Offset: 0xe76
// Size: 0xdd
function function_54f13e062fcf9a53( var_1ec16cd81870859b, taskindex, objweapon, instance )
{
    if ( self.var_372cf0a4647c709a[ var_1ec16cd81870859b ][ taskindex ] == 0 )
    {
        return;
    }
    
    task = level.weapontestingplans[ var_1ec16cd81870859b ].tasks[ taskindex ];
    weaponconfirmed = function_da28767ceae5be33( objweapon, task.weapontype );
    
    if ( !weaponconfirmed )
    {
        return;
    }
    
    distanceconfirmed = function_883c16151d56591c( task, self, instance );
    
    if ( !distanceconfirmed )
    {
        return;
    }
    
    self.var_372cf0a4647c709a[ var_1ec16cd81870859b ][ taskindex ] -= 1;
    
    if ( self.var_372cf0a4647c709a[ var_1ec16cd81870859b ][ taskindex ] == 0 )
    {
        function_e89910dbf4ec67fa( var_1ec16cd81870859b, taskindex, instance );
    }
}

// Namespace weapon_testing_plans
// Params 2
// Checksum 0xed60e7fe, Offset: 0xf5b
// Size: 0x19b, Type: bool
function function_da28767ceae5be33( objweapon, var_7a0004c628d662fb )
{
    var_f0b916f2fac7a02d = weaponclass( objweapon.basename );
    
    switch ( var_7a0004c628d662fb )
    {
        case #"hash_40a94c5d9e4e265b":
            if ( objweapon.ismelee )
            {
                return true;
            }
            
            break;
        case #"hash_690c0d6a821b42e":
        case #"hash_6191aaef9f922f96":
        case #"hash_719417cb1de832b6":
        case #"hash_8cdaf2e4ecfe5b51":
        case #"hash_900cb96c552c5e8e":
        case #"hash_fa24dff6bd60a12d":
            if ( var_f0b916f2fac7a02d === var_7a0004c628d662fb )
            {
                return !objweapon.ismelee;
            }
            
            break;
        case #"hash_61e969dacaaf9881":
            if ( var_f0b916f2fac7a02d === var_7a0004c628d662fb || objweapon.basename === "iw8_la_kgolf_kp" || objweapon.basename === "jup_jp26_la_mike32_mp" )
            {
                return !objweapon.ismelee;
            }
            
            break;
        case #"hash_e224d0b635d0dadd":
            if ( var_f0b916f2fac7a02d === var_7a0004c628d662fb && objweapon.basename != "iw8_la_kgolf_kp" && objweapon.basename != "jup_jp26_la_mike32_mp" )
            {
                return !objweapon.ismelee;
            }
            
            break;
        case #"hash_8059d93d3568c07":
        case #"hash_5d11ac1131cddab1":
        case #"hash_c9a436974fe60919":
        case #"hash_fa1e80f6bd5b8e72":
            if ( objweapon.var_5e3a1c87edc1edd5 === var_7a0004c628d662fb )
            {
                return true;
            }
            
            break;
    }
    
    return false;
}

// Namespace weapon_testing_plans
// Params 3
// Checksum 0x5f367d86, Offset: 0x10ff
// Size: 0xc6, Type: bool
function function_883c16151d56591c( task, player, instance )
{
    var_3a444812a9926ec = utility::function_3a444812a9926ec( player.origin, instance.origin );
    
    if ( task.mindistance && task.maxdistance )
    {
        return ( var_3a444812a9926ec >= task.mindistance && var_3a444812a9926ec <= task.maxdistance );
    }
    else if ( task.mindistance )
    {
        return ( var_3a444812a9926ec >= task.mindistance );
    }
    else if ( task.maxdistance )
    {
        return ( var_3a444812a9926ec <= task.maxdistance );
    }
    
    return true;
}

// Namespace weapon_testing_plans
// Params 3
// Checksum 0x4f44318c, Offset: 0x11ce
// Size: 0x11d
function function_e89910dbf4ec67fa( var_1ec16cd81870859b, taskindex, instance )
{
    instance setscriptablepartstate( "task", "completed" );
    var_6353fbd5008dead2 = function_56c8f4bc0887bd8( var_1ec16cd81870859b, instance );
    
    foreach ( player in teams::getteamdata( self.team, "players" ) )
    {
        if ( !isdefined( player.var_372cf0a4647c709a ) )
        {
            player.var_372cf0a4647c709a = function_83cc93a10cc02fcc();
        }
        
        player.var_372cf0a4647c709a[ var_1ec16cd81870859b ][ taskindex ] = 0;
        player points::doscoreevent( #"hash_b483c22475076799" );
        player function_e84ca23e035eb20e( var_1ec16cd81870859b, taskindex, var_6353fbd5008dead2 );
    }
    
    if ( var_6353fbd5008dead2 )
    {
        function_2a21c0d0e681a20e( var_1ec16cd81870859b, instance );
    }
}

// Namespace weapon_testing_plans
// Params 2
// Checksum 0xde0fe458, Offset: 0x12f3
// Size: 0x93, Type: bool
function function_56c8f4bc0887bd8( var_1ec16cd81870859b, instance )
{
    foreach ( var_e8b6f88d9bc6d19e in self.var_372cf0a4647c709a[ var_1ec16cd81870859b ] )
    {
        if ( var_e8b6f88d9bc6d19e > 0 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace weapon_testing_plans
// Params 2
// Checksum 0x68195ef5, Offset: 0x138f
// Size: 0x165
function function_2a21c0d0e681a20e( var_1ec16cd81870859b, instance )
{
    plan = level.weapontestingplans[ var_1ec16cd81870859b ];
    scoreevent = plan.scoreevent;
    perkrewards = plan.perkrewards;
    
    foreach ( player in teams::getteamdata( self.team, "players" ) )
    {
        if ( scoreevent != "" )
        {
            player points::doscoreevent( getxhash( scoreevent ) );
        }
        
        foreach ( perkreward in perkrewards )
        {
            player perk::giveperk( perkreward );
        }
    }
    
    thread function_ec742aff53c3d47d( plan, instance );
}

// Namespace weapon_testing_plans
// Params 2
// Checksum 0xd3d569b1, Offset: 0x14fc
// Size: 0x75
function function_ec742aff53c3d47d( plan, instance )
{
    level endon( #"game_ended" );
    var_f67995529827f79 = common_cache::function_73fc13f2febd3a2( plan.var_74030fcf087ad767 );
    spawnoptions = common_item::items_initspawnoptions_spawnfromentity( instance );
    waitframe();
    common_item::function_577fe3f000fcb275( 0.1, var_f67995529827f79.spawncount, var_f67995529827f79.spawnlist, spawnoptions );
}

// Namespace weapon_testing_plans
// Params 0
// Checksum 0xe2757be1, Offset: 0x1579
// Size: 0x90
function disablestationarynotes()
{
    level endon( #"game_ended" );
    utility::flag_wait( "scriptables_ready" );
    notestruct = utility::getstruct( "weapon_testing_plan_a", "targetname" );
    stationary_notes::function_a35cbe30981a01bb( notestruct );
    notestruct = utility::getstruct( "weapon_testing_plan_b", "targetname" );
    stationary_notes::function_a35cbe30981a01bb( notestruct );
    notestruct = utility::getstruct( "weapon_testing_plan_c", "targetname" );
    stationary_notes::function_a35cbe30981a01bb( notestruct );
    notestruct = utility::getstruct( "weapon_testing_plan_d", "targetname" );
    stationary_notes::function_a35cbe30981a01bb( notestruct );
}

/#

    // Namespace weapon_testing_plans
    // Params 1
    // Checksum 0x71043ae6, Offset: 0x1611
    // Size: 0xfb, Type: dev
    function function_1f83ea8a521d2b01( params )
    {
        dummyindex = int( params[ 0 ] );
        
        if ( !flags::gameflag( "<dev string:x24>" ) )
        {
            assertmsg( "<dev string:x32>" );
            return;
        }
        else if ( !level.var_9385f203880b542a.size )
        {
            assertmsg( "<dev string:x6e>" );
            return;
        }
        else if ( dummyindex > level.var_9385f203880b542a.size - 1 )
        {
            assertmsg( "<dev string:x8b>" );
            return;
        }
        
        dummy = level.var_9385f203880b542a[ dummyindex ];
        level.players[ 0 ] setorigin( dummy.origin + anglestoforward( dummy.angles ) * 60 );
        player_angles = dummy.angles + ( 0, 180, 0 );
        level.players[ 0 ] setplayerangles( player_angles );
    }

    // Namespace weapon_testing_plans
    // Params 0
    // Checksum 0xbf25d52c, Offset: 0x1714
    // Size: 0x4c, Type: dev
    function function_a58c53d22894d46a()
    {
        level waittill( #"prematch_started" );
        level.var_9cb60f4f86ef6bb7 = [];
        function_55dd4935fc60da47( "<dev string:xc5>" );
        function_55dd4935fc60da47( "<dev string:xdb>" );
        function_55dd4935fc60da47( "<dev string:xf1>" );
        function_55dd4935fc60da47( "<dev string:x107>" );
    }

    // Namespace weapon_testing_plans
    // Params 1
    // Checksum 0xbc0f9f2, Offset: 0x1768
    // Size: 0x75, Type: dev
    function function_55dd4935fc60da47( structname )
    {
        noteid = stationary_notes::function_a00bdf6db2844306( structname );
        
        if ( !isdefined( noteid ) || getdvarint( hashcat( @"hash_edfea81b4d377fe", noteid ) ) )
        {
            return;
        }
        
        plan = utility::getstruct( structname, "<dev string:x11d>" );
        
        if ( plan )
        {
            level.var_9cb60f4f86ef6bb7[ level.var_9cb60f4f86ef6bb7.size ] = plan;
        }
    }

    // Namespace weapon_testing_plans
    // Params 1
    // Checksum 0xbdcefabf, Offset: 0x17e5
    // Size: 0x115, Type: dev
    function function_270144b683a0287( params )
    {
        var_1ec16cd81870859b = int( params[ 0 ] );
        
        if ( !flags::gameflag( "<dev string:x24>" ) )
        {
            assertmsg( "<dev string:x128>" );
            return;
        }
        else if ( !level.var_9cb60f4f86ef6bb7.size )
        {
            assertmsg( "<dev string:x163>" );
            return;
        }
        else if ( var_1ec16cd81870859b > level.var_9cb60f4f86ef6bb7.size - 1 )
        {
            assertmsg( "<dev string:x17f>" );
            return;
        }
        
        plan = level.var_9cb60f4f86ef6bb7[ var_1ec16cd81870859b ];
        adjustedorigin = plan.origin + ( 0, 0, -35 );
        level.players[ 0 ] setorigin( adjustedorigin + anglestoforward( plan.angles ) * 60 );
        player_angles = plan.angles + ( 0, 180, 0 );
        level.players[ 0 ] setplayerangles( player_angles );
    }

    // Namespace weapon_testing_plans
    // Params 1
    // Checksum 0xb8294bdd, Offset: 0x1902
    // Size: 0xf5, Type: dev
    function function_e5c27710ddf39949( params )
    {
        impactstate = params[ 0 ];
        
        foreach ( weapontestingdummy in level.var_9385f203880b542a )
        {
            weapontestingdummy.impactindex = weapontestingdummy.impactindex === "<dev string:x1b8>" ? "<dev string:x1bb>" : "<dev string:x1b8>";
            weapontestingdummy setscriptablepartstate( "<dev string:x1be>", impactstate + weapontestingdummy.impactindex );
            weapontestingdummy setscriptablepartstate( "<dev string:x1c5>", "<dev string:x1cc>" );
            weapontestingdummy setscriptablepartstate( "<dev string:x1d8>", "<dev string:x1dd>" );
        }
    }

    // Namespace weapon_testing_plans
    // Params 0
    // Checksum 0x409d2e21, Offset: 0x19ff
    // Size: 0x2c, Type: dev
    function function_db3e3e1983ee6ce8()
    {
        level.players[ 0 ].var_372cf0a4647c709a = level.players[ 0 ] function_83cc93a10cc02fcc();
    }

    // Namespace weapon_testing_plans
    // Params 0
    // Checksum 0x686668d, Offset: 0x1a33
    // Size: 0x110, Type: dev
    function initdevgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x1e7>" + "<dev string:x1f6>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x20c>", "<dev string:x21d>", &function_1f83ea8a521d2b01 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x225>", "<dev string:x236>", &function_1f83ea8a521d2b01 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x23e>", "<dev string:x24f>", &function_1f83ea8a521d2b01 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x257>", "<dev string:x268>", &function_1f83ea8a521d2b01 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x270>", "<dev string:x280>", &function_270144b683a0287 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x287>", "<dev string:x297>", &function_270144b683a0287 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x29e>", "<dev string:x2ae>", &function_270144b683a0287 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2b5>", "<dev string:x2c5>", &function_270144b683a0287 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x2cc>", "<dev string:x2f2>", &function_e5c27710ddf39949 );
        devgui::function_cd4e263c1f3018ae( "<dev string:x305>", "<dev string:x32b>", &function_e5c27710ddf39949 );
        devgui::add_devgui_func( "<dev string:x33e>", "<dev string:x356>", &function_db3e3e1983ee6ce8 );
        devgui::function_77df7fe7dd273e10();
    }

#/
