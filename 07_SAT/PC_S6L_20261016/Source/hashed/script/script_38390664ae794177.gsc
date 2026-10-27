// script_38390664ae794177  (hash_38390664ae794177.gscc) (size: 8947 Bytes / 0x22f3 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x8fde696e (2413717870)
// size ...... 8947 (0x22f3)
// includes .. 14  (offset: 0x2097)
// strings ... 30  (offset: 0x2107)
// dev strs .. 5   (offset: 0x22b7)
// exports ... 16  (offset: 0x144b)
// cseg ...... 0x28e + 0x11bd (0x144b)
// imports ... 81  (offset: 0x16cb)
// animtree1 . 0   (offset: 0x22f3)
// animtree2 . 0   (offset: 0x22f3)
#using script_24044d228e735dc0;
#using script_2b3f8b011222f912;
#using script_4ce55cfc81c444ad;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\telemetry_utils;
#using scripts\common\utility;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\zm\ztron\ztron_arena;
#using scripts\mp\zm\ztron\ztron_enemy;
#using scripts\mp\zm\ztron\ztron_enemy_ai;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace namespace_4f6b9f859d8abc98;

// Namespace namespace_4f6b9f859d8abc98
// Params 0
// Checksum 0x7c6eea0, Offset: 0x2ac
// Size: 0x4f
function init()
{
    level.ztron.papabacks = [];
    level.ztron.var_dd451b5b7fad08ef = [];
    ztron_enemy::function_6126d573e5775143( "ztron_papaback", "papaback", &papabackinit, &papabackthink, &function_28cbbfb289c62008, -1, 0 );
}

// Namespace namespace_4f6b9f859d8abc98
// Params 0
// Checksum 0xda54f073, Offset: 0x303
// Size: 0x46e
function papabackinit()
{
    ztron_enemy_ai::function_3ae4286f85e2ef9e();
    ztron_enemy_ai::function_40fd300070feec7c( 5000, 0 );
    
    if ( level.ztron.blitzmode )
    {
        papahealth = int( ( getdvarint( @"hash_91b7986477f2d804", 50000 ) + int( getdvarint( @"hash_8c7f984141f02213", 90000 ) * ztron_util::function_8a7307d20b12f13f() ) ) * 55 / 100 );
    }
    else if ( level.ztron.var_371903e5801e0e08 )
    {
        papahealth = getdvarint( @"hash_91b7986477f2d804", 50000 ) + int( getdvarint( @"hash_8c7f984141f02213", 90000 ) * ztron_util::function_8a7307d20b12f13f() );
    }
    else
    {
        papahealth = getdvarint( @"hash_1834fc040994bf52", 120000 ) + level.ztron.game_laps * getdvarint( @"hash_bea65687d6e1892f", 500000 ) + int( getdvarint( @"hash_9334f9a4352d39cd", 150000 ) * ztron_util::function_8a7307d20b12f13f() );
    }
    
    ztron_ai_zombie::zombie_sethealth( papahealth );
    
    /#
        debughealth = getdvarint( @"hash_ad45b102cb41c149", 0 );
        
        if ( debughealth > 0 )
        {
            self.health = debughealth;
        }
        
        init_papaback_devgui();
    #/
    
    self.ispapaback = 1;
    self.ztron.var_efb305d154bbb2e8 = 0;
    self.ztron.raygununlocked = 0;
    self.var_361a087ab08adc1c = "walk";
    self.var_b08bd953529081c8 = 0;
    self.var_9f4fae59ff4e962a = 0;
    self.var_efb5487ff27de9aa = 0;
    self.nexttaunt = 0;
    self.var_bd41719172c8ad13 = 0;
    self.var_a4d2e235ef544e1e = 0;
    self.var_88ae5f3724191df9 = 0;
    self.shieldfx = "ztron_papaback_shield";
    self.boostfx = "ztron_papaback_boost_trail";
    self.var_432560390d1610f8 = getdvarint( @"hash_13d8e5aea5297f75", 3000 );
    self.var_ef738a1b9d2df5ec = getdvarint( @"hash_44a94bf7e6b859e1", 14000 );
    self.var_41faafa177988527 = getdvarint( @"hash_6ff1f6f85be41c18", 12000 );
    self.var_4a67ce1a0cfcf16b = getdvarint( @"hash_2710669c0d6ecdfe", 14000 );
    self.var_2f91579ea953823f = getdvarint( @"hash_9763fa45892470c0", 12000 );
    self.var_92e1101ef3a515a8 = getdvarint( @"hash_4abdc0b62158e819", 6000 );
    self.tauntcooldown = getdvarint( @"hash_e2c4c387595f32c7", 30000 );
    self.var_82aec136c1f15915 = 18;
    self.var_421016727bb9d576 = 18;
    self.var_7ab9bf674d09ca62 = 14;
    self.var_d1adaf357e2de3fe = 16;
    self.var_b6a628b8647c0e79 = 55;
    self.boostorg = utility::spawn_model( "tag_origin", self.origin, self.angles );
    self.boostorg.owner = self;
    self.trigger = spawn( "trigger_radius", self.origin, 0, 50, 50 );
    self.trigger.owner = self;
    self.trigger thread function_42ead1d2f7b47a40();
    self.trigger enablelinkto();
    self.trigger linkto( self );
    self.trigger triggerdisable();
    orgfx = utility::spawn_model( "tag_origin", self.origin, self.angles );
    orgfx linkto( self );
    self.fxmodel = orgfx;
    self.maxhealth = self.health;
    self.goalradius = 40;
    self.raygunweap = self.weapon;
    self.weapon = nullweapon();
    callback::add( #"on_ai_killed", &function_e497ff45d5cb0af9 );
    playfxontag( utility::getfx( "ztron_player_trail_red" ), self.fxmodel, "tag_origin" );
    ztron_papaback::papabacksetspeed();
    thread function_d91f068c7810a77e();
    function_9d542f9559cdcdc2();
    level.ztron.papabacks[ level.ztron.papabacks.size ] = self;
}

// Namespace namespace_4f6b9f859d8abc98
// Params 0
// Checksum 0x7b25d673, Offset: 0x779
// Size: 0x1e
function papabackthink()
{
    self endon( #"death", #"kill_think" );
    ztron_enemy_ai::function_9a34c1b86e0eec7c();
}

// Namespace namespace_4f6b9f859d8abc98
// Params 1
// Checksum 0xd6b6b184, Offset: 0x79f
// Size: 0xd, Type: bool
function function_28cbbfb289c62008( chance )
{
    return false;
}

// Namespace namespace_4f6b9f859d8abc98
// Params 0
// Checksum 0x327e1079, Offset: 0x7b5
// Size: 0x12c
function function_d91f068c7810a77e()
{
    self endon( #"death" );
    
    while ( !self.rotationjump )
    {
        if ( self.health < self.maxhealth * 0.9 )
        {
            self.rotationjump = 1;
            self.var_421016727bb9d576 = 50;
            self.var_41faafa177988527 = 6000;
            break;
        }
        
        wait 0.5;
    }
    
    self waittill( #"papaback_berserk_triggered" );
    self.ztron.var_efb305d154bbb2e8 = 1;
    self.ztron.raygununlocked = 1;
    self.rotationjump = undefined;
    
    /#
        self.var_28ab931e2c6aab98 = undefined;
    #/
    
    self.var_421016727bb9d576 = 18;
    self.var_ef738a1b9d2df5ec = 7000;
    self.var_41faafa177988527 = 7000;
    self.tauntcooldown = 15000;
    ztron_papaback::papabacksetspeed( "sprint" );
    ztron_dialog::function_7e3f6329d9afcdc1( getxhash( "papaback_berserk" ) );
    playfxontag( utility::getfx( "ztron_papaback_berserk_eye_le" ), self, "J_EyeBall_LE" );
    playfxontag( utility::getfx( "ztron_papaback_berserk_eye_ri" ), self, "J_EyeBall_RI" );
}

// Namespace namespace_4f6b9f859d8abc98
// Params 2
// Checksum 0x4a3ec688, Offset: 0x8e9
// Size: 0xb5
function papabackshield( on = 1, immune = on )
{
    if ( on )
    {
        playfxontag( utility::getfx( self.shieldfx ), self.fxmodel, "tag_origin" );
        
        if ( self getcandamage() && immune )
        {
            self setcandamage( 0 );
        }
        
        self.trigger triggerenable();
        return;
    }
    
    stopfxontag( utility::getfx( self.shieldfx ), self.fxmodel, "tag_origin" );
    
    if ( !self getcandamage() )
    {
        self setcandamage( 1 );
    }
    
    self.trigger triggerdisable();
}

// Namespace namespace_4f6b9f859d8abc98
// Params 0
// Checksum 0xef756c3, Offset: 0x9a6
// Size: 0xe5
function function_42ead1d2f7b47a40()
{
    self endon( #"death", #"kill_think" );
    
    while ( true )
    {
        self waittill( #"trigger", ent );
        
        if ( isplayer( ent ) || ent ztron_enemy_ai::iszombie() && ent.teamshifted )
        {
            ent dodamage( ent.health, self.origin, self.owner, self.owner );
            continue;
        }
        
        if ( ent ztron_enemy_ai::iszombie() && ent.aicategory == "normal" && !ent.ztron.boss && !ent zombie_knockdown::function_19d6107cb6bdff5c() )
        {
            ent zombie_knockdown::function_6fc167d4a3590991( self.origin );
        }
    }
}

// Namespace namespace_4f6b9f859d8abc98
// Params 0
// Checksum 0x9b2412d3, Offset: 0xa93
// Size: 0x75
function function_9d542f9559cdcdc2()
{
    objectiveindex = objidpoolmanager::requestobjectiveid();
    
    if ( objectiveindex != -1 )
    {
        objectoffset = ( 0, 0, 80 );
        objidpoolmanager::objective_add_objective( objectiveindex, "active", self.origin + objectoffset, "ui_icon_zm_ping_enemy_elite" );
        objidpoolmanager::update_objective_size( objectiveindex, "icon_small" );
        objidpoolmanager::update_objective_onentity( objectiveindex, self );
    }
    
    self.objectiveindex = objectiveindex;
}

// Namespace namespace_4f6b9f859d8abc98
// Params 0
// Checksum 0xe1669275, Offset: 0xb10
// Size: 0x2c1
function function_13ba7fd249fe8069()
{
    self notify( #"hash_f236c30b004a7d5a" );
    self endon( #"hash_f236c30b004a7d5a" );
    level endon( #"ztron_exit_taken", #"ztron_teleporter_taken", #"kill_think" );
    spot = ztron_arena::function_c5ca214b01ea2754();
    papaback = ztron_enemy::function_acee91c445fafd29( ztron_enemy::function_96eea0d09d5640d1( "papaback" ), spot.origin, undefined, undefined, 1, 1 );
    papaback.ztron.var_409dbcca0b46e13d = 1;
    papaback thread ztron_util::function_36239518d8da65f0( level, "noPapaBack" );
    
    if ( isdefined( papaback ) )
    {
        papaback endon( #"death" );
        papaback thread function_8534dc95c46f26aa();
        papaback papabackshield( 1 );
        papaback.var_9f4fae59ff4e962a = 1;
        papaback ztron_papaback::papabacksetspeed( "walk" );
        papaback ztron_papaback::function_c2dcc40c67205012( level.ztron.active_arena.center.origin );
        wait 10;
        papaback setbtgoalstationary( 1 );
        papaback ztron_dialog::function_7e3f6329d9afcdc1( getxhash( "textbubble_papaback_2" ) );
        ztron_util::function_40ad6a6cc144aa3f( level.ztron.dialogues[ "DOA_Mamaback_Chasing" ] );
        wait 2;
        papaback clearbtgoal( 1 );
        papaback.gatheritems = 1;
        papaback.goalradius = 32;
        wait 0.1;
        papaback ztron_papaback::papabacksetspeed( "run" );
        level.ztron.activeattractors[ level.ztron.activeattractors.size ] = papaback;
        papaback thread function_c7987c262dfd0b41( squared( 28 ) );
        result = utility::waittill_any_ents_return( papaback, "damage", level, "gather_completed" );
        papaback notify( #"near_goal_done" );
        level.ztron.activeattractors = arrayremove( level.ztron.activeattractors, papaback );
        papaback.gatheritems = undefined;
        papaback.goto_position = undefined;
        
        if ( isdefined( papaback.attractor ) )
        {
            papaback zombie_attractor_manager::function_dcfb4c31f1d97cd2( papaback.attractor );
        }
        
        wait 2;
        papaback ztron_dialog::function_927bb94feca983e8( getxhash( "bubble_message_papaback" ) );
        wait 2;
        papaback ztron_papaback::papabacksetspeed( "run" );
        papaback ztron_enemy_ai::function_29bbc6846013b71b();
        
        if ( isdefined( papaback.favoriteenemy ) )
        {
            papaback getenemyinfo( papaback.favoriteenemy );
        }
        
        while ( true )
        {
            wait 10;
            papaback ztron_dialog::function_927bb94feca983e8( getxhash( "bubble_message_papaback" ) );
        }
    }
}

// Namespace namespace_4f6b9f859d8abc98
// Params 0
// Checksum 0xbfd46685, Offset: 0xdd9
// Size: 0x105
function function_8534dc95c46f26aa()
{
    level endon( #"ztron_game_is_over" );
    self endon( #"death" );
    level utility::waittill_any( "ztron_exit_taken", "ztron_teleporter_taken", "noPapaBack", "kill_think" );
    
    if ( isdefined( self.boostorg ) )
    {
        self.boostorg.angles = self.angles;
        self.boostorg.origin = self.origin;
        waitframe();
        self motionwarpcancel();
        self linkto( self.boostorg );
        targetpos = level.ztron.active_arena.center.origin + ( 0, 0, 500 );
        self.boostorg moveto( targetpos, 0.5 );
        self.boostorg waittill( #"movedone" );
    }
    
    ztron_util::deletemedelay();
}

// Namespace namespace_4f6b9f859d8abc98
// Params 1
// Checksum 0x57b5ba4c, Offset: 0xee6
// Size: 0x71
function function_c7987c262dfd0b41( distsq )
{
    self endon( #"death", #"kill_think" );
    self endon( #"near_goal_done" );
    
    while ( true )
    {
        if ( isdefined( self.goto_position ) && distancesquared( self.origin, self.goto_position ) <= distsq )
        {
            self notify( #"near_goal" );
        }
        
        wait 0.2;
    }
}

// Namespace namespace_4f6b9f859d8abc98
// Params 1
// Checksum 0xd73fcc0b, Offset: 0xf5f
// Size: 0x358
function function_e497ff45d5cb0af9( params )
{
    stopfxontag( utility::getfx( "ztron_papaback_berserk_eye_le" ), self, "J_EyeBall_LE" );
    stopfxontag( utility::getfx( "ztron_papaback_berserk_eye_ri" ), self, "J_EyeBall_RI" );
    
    if ( ztron_util::function_5a0e1527359f13d7() && !level utility::flag( "ztron_game_is_over" ) )
    {
        foreach ( player in level.players )
        {
            if ( telemetry_utils::is_valid_client( player ) )
            {
                telemetry = player.pers[ "telemetry" ];
                
                if ( isdefined( telemetry ) )
                {
                    if ( !isdefined( telemetry.silverback_eliminations ) )
                    {
                        telemetry.silverback_eliminations = 0;
                    }
                    
                    telemetry.silverback_eliminations += 1;
                }
            }
        }
    }
    
    if ( arraycontains( level.ztron.activeattractors, self ) )
    {
        level.ztron.activeattractors = arrayremove( level.ztron.activeattractors, self );
    }
    
    if ( isdefined( self.fxmodel ) )
    {
        stopfxontag( utility::getfx( self.shieldfx ), self.fxmodel, "tag_origin" );
        stopfxontag( utility::getfx( "ztron_player_trail_red" ), self.fxmodel, "tag_origin" );
        stopfxontag( utility::getfx( self.boostfx ), self.fxmodel, "tag_origin" );
        self.fxmodel delete();
        self.fxmodel = undefined;
    }
    
    if ( isdefined( self.trigger ) )
    {
        self.trigger delete();
        self.trigger = undefined;
    }
    
    if ( isdefined( self.introorg ) )
    {
        self.introorg delete();
        self.introorg = undefined;
    }
    
    if ( isdefined( self.outroorg ) )
    {
        self.outroorg delete();
        self.outroorg = undefined;
    }
    
    if ( isdefined( self.boostorg ) )
    {
        self.boostorg delete();
        self.boostorg = undefined;
    }
    
    if ( isdefined( self.objectiveindex ) )
    {
        objidpoolmanager::returnobjectiveid( self.objectiveindex );
        self.objectiveindex = undefined;
    }
    
    if ( isdefined( self.smokingpipe ) )
    {
        if ( isdefined( self.smokingpipe.fxmodel ) )
        {
            stopfxontag( utility::getfx( self.boostfx ), self.smokingpipe.fxmodel, "tag_origin" );
            self.smokingpipe.fxmodel delete();
        }
        
        self.smokingpipe delete();
        self.smokingpipe = undefined;
    }
    
    level.ztron.papabacks = arrayremove( level.ztron.papabacks, self );
}

/#

    // Namespace namespace_4f6b9f859d8abc98
    // Params 0, eflags: 0x4
    // Checksum 0x98a02d3, Offset: 0x12bf
    // Size: 0x44, Type: dev
    function private init_papaback_devgui()
    {
        devgui::function_9082edeb5db93280( "<dev string:x24>" );
        devgui::add_devgui_func( "<dev string:x30>", "<dev string:x55>", &function_3e3af87cf513fd4c );
        devgui::add_devgui_func( "<dev string:x78>", "<dev string:x8d>", &debug_papaback_berserk );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace namespace_4f6b9f859d8abc98
    // Params 0, eflags: 0x4
    // Checksum 0x6c7522bb, Offset: 0x130b
    // Size: 0x9b, Type: dev
    function private function_3e3af87cf513fd4c()
    {
        foreach ( papaback in level.ztron.papabacks )
        {
            papaback.rotationjump = 1;
            papaback.var_28ab931e2c6aab98 = 1;
        }
    }

    // Namespace namespace_4f6b9f859d8abc98
    // Params 0, eflags: 0x4
    // Checksum 0x9e7e1c0c, Offset: 0x13ae
    // Size: 0x9d, Type: dev
    function private debug_papaback_berserk()
    {
        foreach ( papaback in level.ztron.papabacks )
        {
            papaback.rotationjump = 1;
            wait 1;
            papaback notify( #"papaback_berserk_triggered" );
        }
    }

#/
