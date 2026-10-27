// script_fd54ba823d404ad  (hash_0fd54ba823d404ad.gscc) (size: 20914 Bytes / 0x51b2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x40593f20 (1079590688)
// size ...... 20914 (0x51b2)
// includes .. 16  (offset: 0x4cc6)
// strings ... 72  (offset: 0x4d46)
// dev strs .. 3   (offset: 0x518e)
// exports ... 40  (offset: 0x3442)
// cseg ...... 0x4ff + 0x2f43 (0x3442)
// imports ... 140 (offset: 0x3a82)
// animtree1 . 0   (offset: 0x51b2)
// animtree2 . 0   (offset: 0x51b2)
#using script_16ea1b94f0f381b3;
#using script_2cd07641bf71242a;
#using script_60cc31ea91d0ad55;
#using script_68af0df7ea34684e;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\shared\zombie\zombie_wander;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\shellshock_utility;
#using scripts\common\throttle;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_neptune_asm;

// Namespace zombie_neptune_asm
// Params 0, eflags: 0x4
// Checksum 0xacef88b, Offset: 0x51d
// Size: 0x53
function private function_cfbb84b3d7bc65b8()
{
    level.scr_anim[ self.animname ][ "spawn" ] = "spawn";
    callback::get_template( self.animsetname ) callback::add( #"hash_696b6f168d1d9c5c", &function_47f8bd07c1e7d621 );
    function_905e2c40b0975497();
    namespace_45591fb25244d549::function_a38858e4f5328064();
}

// Namespace zombie_neptune_asm
// Params 3
// Checksum 0x5b5235e2, Offset: 0x578
// Size: 0x116
function function_2b29c3dcc52e96d8( asmname, statename, params )
{
    if ( self.var_cc3703385f725b39 )
    {
        return;
    }
    
    self.var_cc3703385f725b39 = 1;
    namespace_7e98bc5e3517bf83::zombie_init_ai_asm( &function_cfbb84b3d7bc65b8 );
    self.asm.footsteps = spawnstruct();
    self.asm.footsteps.foot = "invalid";
    self.asm.footsteps.time = 0;
    self.asm.customdata = spawnstruct();
    asm::asm_setmoveplaybackrate( 1 );
    function_ba50a149d8b9071c();
    init_zombie_neptune_move();
    namespace_45591fb25244d549::function_a887d53ac5484b73();
    zombie_traverse_asm::init_zombie_traverse_asm();
    thread zombie_wander::function_c77a8eaa38883b1c();
    self aisetdesiredspeed( 70 );
    thread update_speed();
    callback::add( "on_ai_init", &on_ai_init );
    utility::ent_flag_set( "zombie_asm_init_finished" );
    function_1ec96503c85b8721();
}

// Namespace zombie_neptune_asm
// Params 3
// Checksum 0xf9d0330, Offset: 0x696
// Size: 0x36, Type: bool
function function_e6afd8e763326d76( asmname, statename, params )
{
    return ( self._blackboard.var_e6eb6b873938dee6 & 3 ) == 0;
}

// Namespace zombie_neptune_asm
// Params 1, eflags: 0x4
// Checksum 0xcdfe01b0, Offset: 0x6d5
// Size: 0x2f
function private on_ai_init( params )
{
    callback::remove( "on_ai_init", &on_ai_init );
    zombie_utils::function_a8ce00e0448cb6f0( "run", "aitype_default", 0 );
}

// Namespace zombie_neptune_asm
// Params 1, eflags: 0x4
// Checksum 0xeb802d7f, Offset: 0x70c
// Size: 0x38
function private on_move_speed_changed( params )
{
    if ( asm::asm_currentstatehasflag( self.asmname, "move" ) )
    {
        asm::asm_fireevent_internal( self.asmname, "loop_reroll_anim" );
    }
}

// Namespace zombie_neptune_asm
// Params 0
// Checksum 0x5e3e000f, Offset: 0x74c
// Size: 0x40
function function_59fce2d761088455()
{
    self function_786bb6aa1b76c7ee( "immune", 1 );
    thread namespace_9d8e359c3b1041e5::animscripted_sharedfunc( "spawn", "spawn_end", undefined, undefined, "spawn_animating" );
    self waittill( #"spawn_end" );
    self function_786bb6aa1b76c7ee( "immune", 0 );
}

// Namespace zombie_neptune_asm
// Params 0
// Checksum 0x4034d02f, Offset: 0x794
// Size: 0x22
function function_905e2c40b0975497()
{
    callback::get_template( self.animsetname ) callback::add( "on_move_speed_changed", &on_move_speed_changed );
}

// Namespace zombie_neptune_asm
// Params 0
// Checksum 0x1cf6dede, Offset: 0x7be
// Size: 0x9
function init_zombie_neptune_move()
{
    namespace_56081b33e0a40eac::function_d9c6262c2bdb331c();
}

// Namespace zombie_neptune_asm
// Params 0
// Checksum 0x6b835a75, Offset: 0x7cf
// Size: 0x69
function function_ba50a149d8b9071c()
{
    self function_786bb6aa1b76c7ee( "rockThrowAttackRange", getdvarfloat( @"neptune_melee_range", self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_392b725c9bfec49a ) );
    self.var_13074e3f42234f07 = 0;
    thread function_8ba9019981e893ae();
    thread function_8c9ccf11796f119f();
    self.var_7f8ab9bb9f4957fc = &function_2408adb3cab0c16c;
    utility::ent_flag_set( "rock_throw_range_defined" );
}

// Namespace zombie_neptune_asm
// Params 0, eflags: 0x4
// Checksum 0x790e9356, Offset: 0x840
// Size: 0x3a
function private function_8ba9019981e893ae()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"hash_83ee5e30f2584fb0" );
        function_acecbd9854a299e8( self.var_af954c6a58743ed );
        thread function_45ed64bc33554844();
    }
}

// Namespace zombie_neptune_asm
// Params 0, eflags: 0xc
// Checksum 0xca974819, Offset: 0x882
// Size: 0x4ac
function private function_8c9ccf11796f119f()
{
    self notify( #"hash_87d0417437eeeac9" );
    self endon( #"hash_87d0417437eeeac9" );
    self endon( #"death" );
    var_ae91fff55fe3def4 = 3000;
    
    if ( !isdefined( level.search_for_faraway_enemy_to_rock_throw_throttle ) )
    {
        level.search_for_faraway_enemy_to_rock_throw_throttle = throttle::throttle_initialize( "search_for_faraway_enemy_to_rock_throw_throttle" );
    }
    
    utility::ent_flag_wait_or_timeout( "rock_throw_range_defined", 3 );
    self.var_fd82bd98cea53e6b = 1;
    self.var_8f226316317be5f7 = gettime();
    self.var_fc07172562b0783f = utility::function_4b74c15943231980( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_fc07172562b0783f );
    var_bc820cd4e5bc415d = self.var_fc07172562b0783f * self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_b0985c44c811e5a2;
    var_bff13ea2abe493d3 = squared( self getaiblackboarddynamic( "rockThrowAttackRange" ) );
    
    while ( true )
    {
        throttle::throttle_wait_in_queue( level.search_for_faraway_enemy_to_rock_throw_throttle, self );
        
        if ( level.players.size <= 1 )
        {
            if ( !level callback::exists( #"player_connect", &onspawnconnected ) )
            {
                level callback::add( #"player_connect", &onspawnconnected );
            }
            
            self waittill( #"hash_258f29c1a86861d5" );
            continue;
        }
        
        if ( self getaiblackboarddynamic( "in_neptune_melee" ) || self getaiblackboarddynamic( "neptune_melee_non_main_enemy" ) || self getaiblackboarddynamic( "in_ground_slam" ) || self._blackboard.var_65f32caa86b87a2 || self getaiblackboarddynamic( "neptune_throw_faraway_enemy" ) || self getaiblackboarddynamic( "in_weakspot_break" ) )
        {
            utility::waittill_any_in_array_or_timeout( [ "bmeleeended", "ground_slam_end", "terminate_ranged_attack", "special_pain_end" ], 10 );
        }
        
        if ( !self.var_fd82bd98cea53e6b )
        {
            continue;
        }
        
        if ( !isdefined( self.enemy ) )
        {
            continue;
        }
        
        var_10e0db2f90cb6d99 = 0;
        var_f8463473cca48eb5 = undefined;
        var_36a34f0ff5047bdb = undefined;
        var_d71cfa562fdea265 = self function_f017e352a29a57a1( self.origin, var_ae91fff55fe3def4, 1 );
        var_d71cfa562fdea265 = arrayrandomize( var_d71cfa562fdea265 );
        
        foreach ( farawayenemy in var_d71cfa562fdea265 )
        {
            if ( !isalive( farawayenemy ) || self.enemy == farawayenemy || farawayenemy.inlaststand )
            {
                continue;
            }
            
            var_5b887b669de2491 = distance2dsquared( self.origin, farawayenemy.origin );
            
            if ( var_5b887b669de2491 < var_bff13ea2abe493d3 )
            {
                farawayenemy.var_d90d78fdf7c9ea17 = undefined;
                continue;
            }
            
            if ( !isdefined( farawayenemy.var_d90d78fdf7c9ea17 ) )
            {
                farawayenemy.var_d90d78fdf7c9ea17 = gettime();
            }
            
            if ( gettime() - farawayenemy.var_d90d78fdf7c9ea17 >= var_bc820cd4e5bc415d )
            {
                foreach ( var_9a93b460327f8437 in var_d71cfa562fdea265 )
                {
                    var_9a93b460327f8437.var_d90d78fdf7c9ea17 = undefined;
                }
                
                var_10e0db2f90cb6d99 = var_5b887b669de2491;
                var_f8463473cca48eb5 = farawayenemy;
                var_36a34f0ff5047bdb = 1;
                break;
            }
            
            if ( var_5b887b669de2491 > var_10e0db2f90cb6d99 )
            {
                var_10e0db2f90cb6d99 = var_5b887b669de2491;
                var_f8463473cca48eb5 = farawayenemy;
            }
        }
        
        if ( !var_36a34f0ff5047bdb && gettime() - self.var_8f226316317be5f7 <= self.var_fc07172562b0783f )
        {
            continue;
        }
        
        if ( var_f8463473cca48eb5 )
        {
            if ( !var_36a34f0ff5047bdb )
            {
                foreach ( farawayenemy in var_d71cfa562fdea265 )
                {
                    farawayenemy.var_d90d78fdf7c9ea17 = undefined;
                }
            }
            
            var_36a34f0ff5047bdb = undefined;
            self function_786bb6aa1b76c7ee( "neptune_throw_faraway_enemy", 1 );
            self.var_373e34e4a1fad173 = var_f8463473cca48eb5;
            self.var_8f226316317be5f7 = gettime();
            utility::waittill_notify_or_timeout( "terminate_ranged_attack", 15 );
        }
    }
}

// Namespace zombie_neptune_asm
// Params 1, eflags: 0x4
// Checksum 0xbfdccf44, Offset: 0xd36
// Size: 0x2e
function private onspawnconnected( params )
{
    self notify( #"hash_258f29c1a86861d5" );
    level callback::remove( #"player_connect", &onspawnconnected );
}

// Namespace zombie_neptune_asm
// Params 0, eflags: 0x4
// Checksum 0xc99b75d3, Offset: 0xd6c
// Size: 0x77
function private function_45ed64bc33554844()
{
    self endon( #"death" );
    self endon( #"terminate_ranged_attack" );
    self endon( #"ThrowRock" );
    
    while ( isdefined( self.var_af954c6a58743ed ) )
    {
        attackpos = self.var_af954c6a58743ed.origin;
        self orientmode( "face angle", angleclamp( vectortoyaw( attackpos - self.origin ) ), 1 );
        waitframe();
    }
}

// Namespace zombie_neptune_asm
// Params 5, eflags: 0x4
// Checksum 0x9b74776d, Offset: 0xdeb
// Size: 0x6f
function private function_2408adb3cab0c16c( idamage, eattacker, objweapon, smeansofdeath, vpoint )
{
    if ( isdefined( eattacker.ranged_grenade_damage ) && isdefined( eattacker.grenadeweapon ) && objweapon == eattacker.grenadeweapon )
    {
        idamage = eattacker.ranged_grenade_damage;
    }
    
    return idamage;
}

// Namespace zombie_neptune_asm
// Params 1
// Checksum 0x5de51ada, Offset: 0xe63
// Size: 0x41
function function_acecbd9854a299e8( target_ent )
{
    assert( isdefined( self.grenadeweapon ), "<dev string:x24>" );
    self.ranged_attack_target = target_ent;
    asm::function_7256f5ba459c840b( "ranged_attack_in" );
    thread function_cbeb9e8b9e83ef54();
}

// Namespace zombie_neptune_asm
// Params 3
// Checksum 0xa276ab0, Offset: 0xeac
// Size: 0x1d7
function calc_velocity( start_pos, end_pos, gravity )
{
    var_eeaf170f69282115 = distance( start_pos, end_pos );
    assert( self.var_ec263f0a689ef1dd > 0, "<dev string:x4d>" );
    time = var_eeaf170f69282115 / self.var_ec263f0a689ef1dd;
    delta = end_pos - start_pos;
    vel = delta / time + ( 0, 0, 0.5 * gravity * time );
    var_923f9364c97dbafa = ( end_pos[ 0 ], end_pos[ 1 ], start_pos[ 2 ] ) - start_pos;
    horizontal_displacement = length( var_923f9364c97dbafa );
    
    if ( horizontal_displacement >= self getaiblackboarddynamic( "rockThrowAttackRange" ) )
    {
        var_7a36484912a52548 = getdvarfloat( @"hash_9dedf3d494cfbdda", 40 );
        vertical_displacement = end_pos[ 2 ] - start_pos[ 2 ];
        var_42f5cffff533d18b = gravity * squared( horizontal_displacement );
        var_63ae686ff2e065d9 = 2 * squared( cos( var_7a36484912a52548 ) ) * ( horizontal_displacement * tan( var_7a36484912a52548 ) - vertical_displacement );
        
        if ( var_63ae686ff2e065d9 <= 0 )
        {
            return vel;
        }
        
        leap_speed = sqrt( var_42f5cffff533d18b / var_63ae686ff2e065d9 );
        var_ff86f682a87a4a01 = leap_speed * cos( var_7a36484912a52548 );
        horizontal_vel = vectornormalize( var_923f9364c97dbafa ) * var_ff86f682a87a4a01;
        totaltime = horizontal_displacement / var_ff86f682a87a4a01;
        var_6e4085567c306523 = ( vertical_displacement + 0.5 * gravity * squared( totaltime ) ) / totaltime;
        vel = ( horizontal_vel[ 0 ], horizontal_vel[ 1 ], var_6e4085567c306523 );
        
        /#
            if ( getdvarfloat( @"hash_9436a16f50968ec2", 0 ) )
            {
                line( start_pos, start_pos + vel, ( 0, 0, 1 ), 1, 0, 50 );
            }
        #/
    }
    
    return vel;
}

// Namespace zombie_neptune_asm
// Params 0, eflags: 0x4
// Checksum 0x97befb65, Offset: 0x108c
// Size: 0x32f
function private function_cbeb9e8b9e83ef54()
{
    self endon( #"death" );
    self endon( #"terminate_ranged_attack" );
    thread function_30a6d2141f3a1af1();
    callback::callback( #"hash_2f8220e252370c19" );
    self waittill( #"rockgrabbed", hand );
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    
    switch ( self.n_fight_phase )
    {
        case 1:
            self.grenadeweapon = settings.var_5752d6ade6f9d0dc;
            
            switch ( hand )
            {
                case #"hash_96815ce4f2a3dbc5":
                    self.projectile_attach_tag = "tag_fx_hand_ri";
                    break;
                case #"hash_c9b3133a17a3b2d0":
                    self.projectile_attach_tag = "tag_fx_hand_le";
                    break;
            }
            
            break;
        case 2:
            self.grenadeweapon = settings.var_9954d6711e13b266;
            self.projectile_attach_tag = "tag_fx_center";
            break;
        case 3:
            self.grenadeweapon = settings.var_8521787d422f164;
            self.projectile_attach_tag = "tag_fx_center";
            break;
    }
    
    if ( self.var_d6894f01a36b4ff3.var_4d1ea9cb46a12ea6.size > 0 )
    {
        if ( !self.var_d75eaefe66066143 )
        {
            self.var_d75eaefe66066143 = self.var_d6894f01a36b4ff3.var_4d1ea9cb46a12ea6[ self.n_fight_phase - 1 ].modelname;
            self attach( self.var_d75eaefe66066143, self.projectile_attach_tag );
        }
        
        switch ( self.n_fight_phase )
        {
            case 1:
                switch ( hand )
                {
                    case #"hash_96815ce4f2a3dbc5":
                        self setscriptablepartstate( "Picked", "phase1Right" );
                        break;
                    case #"hash_c9b3133a17a3b2d0":
                        self setscriptablepartstate( "Picked", "phase1Left" );
                        break;
                }
                
                break;
            case 2:
                self setscriptablepartstate( "Picked", "Phase2" );
                break;
            case 3:
                self setscriptablepartstate( "Picked", "Phase3" );
                break;
        }
    }
    
    thread function_37cf1bcc13372a33();
    utility::waittill_notify_or_timeout( "ThrowRock", 8 );
    target = isent( self.ranged_attack_target ) ? self.ranged_attack_target : undefined;
    var_752221f0b48fc623 = self gettagorigin( self.projectile_attach_tag );
    
    if ( isdefined( target ) )
    {
        target_pos = target.origin + ( 0, 0, 40 );
    }
    else
    {
        var_b12503fd9442f475 = 250;
        target_pos = anglestoforward( self.angles ) * var_b12503fd9442f475;
    }
    
    var_267d01d2be2d145 = calc_velocity( var_752221f0b48fc623, target_pos, self function_88d2c65d5eed0e87() * self.grenadeweapon.var_4b34df4cbe697f89 );
    thread function_bf22d281c4651259( var_267d01d2be2d145, var_752221f0b48fc623 );
}

// Namespace zombie_neptune_asm
// Params 2, eflags: 0x4
// Checksum 0x2c9fff32, Offset: 0x13c3
// Size: 0x112
function private function_bf22d281c4651259( var_267d01d2be2d145, var_752221f0b48fc623 )
{
    self endon( #"death" );
    self endon( #"terminate_ranged_attack" );
    
    if ( !isdefined( var_267d01d2be2d145 ) )
    {
        return;
    }
    
    thrown_rock = magicgrenademanual( self.grenadeweapon, var_752221f0b48fc623, var_267d01d2be2d145, self.var_d6894f01a36b4ff3.var_f3ce124063bf11bf, self );
    thrown_rock.angles = self gettagangles( self.projectile_attach_tag );
    thrown_rock setscriptablepartstate( "Picked", "on" );
    
    while ( thrown_rock.origin == var_752221f0b48fc623 )
    {
        waitframe();
    }
    
    waitframe();
    
    if ( isdefined( self.var_d75eaefe66066143 ) )
    {
        self detach( self.var_d75eaefe66066143, self.projectile_attach_tag );
        self.var_d75eaefe66066143 = undefined;
    }
    
    self setscriptablepartstate( "Picked", "off" );
    thread function_31be5b5b68d82913( thrown_rock );
    thread function_edd80625095bda6e( thrown_rock );
    thread function_4a9857d7835e4b65( thrown_rock );
    thread function_c63d4d4fdff2cffe( thrown_rock );
    thread function_c4786c145e01a09a( thrown_rock );
}

// Namespace zombie_neptune_asm
// Params 0, eflags: 0x4
// Checksum 0x67705864, Offset: 0x14dd
// Size: 0x61
function private function_30a6d2141f3a1af1()
{
    utility::waittill_any( "terminate_ranged_attack", "death" );
    
    if ( isdefined( self ) )
    {
        if ( isdefined( self.var_d75eaefe66066143 ) )
        {
            self detach( self.var_d75eaefe66066143, self.projectile_attach_tag );
            self setscriptablepartstate( "Picked", "off" );
        }
        
        self.var_d75eaefe66066143 = undefined;
        self.projectile_attach_tag = undefined;
    }
}

// Namespace zombie_neptune_asm
// Params 0, eflags: 0x4
// Checksum 0xef9cb450, Offset: 0x1546
// Size: 0x10a
function private function_37cf1bcc13372a33()
{
    self endon( #"death" );
    self endon( #"ThrowRock" );
    var_d9c9eafc66983ed2 = self.projectile_attach_tag;
    
    while ( true )
    {
        current_state = self asmgetcurrentstate( self.asmname );
        
        if ( current_state != "ranged_attack_throw" )
        {
            var_752221f0b48fc623 = self gettagorigin( var_d9c9eafc66983ed2 );
            thrown_rock = magicgrenademanual( self.grenadeweapon, var_752221f0b48fc623, ( 0, 0, -1 ), self.var_d6894f01a36b4ff3.var_f3ce124063bf11bf, self );
            thrown_rock.angles = self gettagangles( var_d9c9eafc66983ed2 );
            thrown_rock setscriptablepartstate( "Picked", "on" );
            self setscriptablepartstate( "Picked", "off" );
            thread function_31be5b5b68d82913( thrown_rock );
            thread function_edd80625095bda6e( thrown_rock );
            thread function_4a9857d7835e4b65( thrown_rock );
            thread function_c63d4d4fdff2cffe( thrown_rock );
            thread function_c4786c145e01a09a( thrown_rock );
            break;
        }
        
        waitframe();
    }
}

// Namespace zombie_neptune_asm
// Params 1, eflags: 0x4
// Checksum 0xfea3de0a, Offset: 0x1658
// Size: 0x458
function private function_31be5b5b68d82913( thrown_rock )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    thrown_rock endon( #"missile_stuck" );
    thrown_rock endon( #"missile_bounced" );
    thrown_rock endon( #"projectile_impact_player" );
    thrown_rock endon( #"projectile_impact_ai" );
    var_b3b6fd15e8ca737f = 30;
    var_257455908776e428 = 55;
    var_4a9c5bc83a480351 = 70;
    var_d1568fb876ef3942 = squared( 130 );
    var_d48c127f577d65bf = 10;
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    fightphase = self.n_fight_phase;
    var_f63bb4cb38d334de = self.neptune_damage_scalar;
    
    switch ( fightphase )
    {
        case 1:
            var_5fe784492bbc09fe = var_b3b6fd15e8ca737f;
            break;
        case 2:
            var_5fe784492bbc09fe = var_257455908776e428;
            break;
        case 3:
            var_5fe784492bbc09fe = var_4a9c5bc83a480351;
            break;
    }
    
    can_aoe = can_aoe();
    var_7d08637574e1352 = squared( var_5fe784492bbc09fe );
    
    while ( true )
    {
        if ( !isdefined( thrown_rock ) )
        {
            return;
        }
        
        rockcenter = thrown_rock getcentroid();
        
        if ( fightphase == 3 )
        {
            rockcenter += ( 0, 0, -20 );
        }
        
        trace_result = trace::capsule_get_closest_point( rockcenter, var_5fe784492bbc09fe, var_5fe784492bbc09fe * 2, undefined, 0, [ self, thrown_rock ], trace::create_solid_ai_contents() );
        
        if ( trace_result[ "hittype" ] == "hittype_world" )
        {
            thrown_rock notify( #"hash_3e65d870fb1fa49e" );
            var_cdd779c976c1cffb = thrown_rock.origin;
            thrown_rock delete();
            var_1a919f72f736d773 = utility::drop_to_ground( rockcenter, 100 );
            
            if ( distancesquared( rockcenter, var_1a919f72f736d773 ) < var_7d08637574e1352 )
            {
                impactorigin = var_1a919f72f736d773;
                impactangles = ( 0, 0, 1 );
                
                if ( can_aoe )
                {
                    var_b4f4728c9c9b6813 = impactorigin;
                }
            }
            else
            {
                impactorigin = var_cdd779c976c1cffb;
                var_70e80b53e1b1f756 = vectorcross( ( 0, 0, 1 ), trace_result[ "normal" ] * -1 );
                var_b4dbbe29267fdf4d = vectorcross( trace_result[ "normal" ] * -1, var_70e80b53e1b1f756 );
                impactangles = axistoangles( var_b4dbbe29267fdf4d, var_70e80b53e1b1f756, trace_result[ "normal" ] * -1 );
                
                if ( can_aoe )
                {
                    var_b4f4728c9c9b6813 = utility::drop_to_ground( impactorigin + trace_result[ "normal" ] * var_d48c127f577d65bf, 0 );
                }
            }
            
            var_f8573302f9e072bb = 1;
            break;
        }
        else if ( isplayer( trace_result[ "entity" ] ) || isai( trace_result[ "entity" ] ) )
        {
            thrown_rock notify( #"hash_3e65d870fb1fa49e" );
            thrown_rock delete();
            var_1a919f72f736d773 = utility::drop_to_ground( rockcenter, 0 );
            hitent = trace_result[ "entity" ];
            
            if ( hitent isonground() || distancesquared( hitent.origin, var_1a919f72f736d773 ) <= var_d1568fb876ef3942 )
            {
                impactorigin = var_1a919f72f736d773;
                impactangles = ( 0, 0, 1 );
                
                if ( can_aoe )
                {
                    var_b4f4728c9c9b6813 = impactorigin;
                }
                
                var_f8573302f9e072bb = 1;
            }
            else
            {
                impactorigin = trace_result[ "position" ];
            }
            
            break;
        }
        
        /#
            if ( getdvarfloat( @"hash_9436a16f50968ec2", 0 ) )
            {
                sphere( rockcenter, getdvarfloat( @"hash_fba0c32e7cc40704", var_5fe784492bbc09fe ), ( 1, 1, 1 ), 0, 100 );
            }
        #/
        
        waitframe();
    }
    
    /#
        if ( getdvarfloat( @"hash_9436a16f50968ec2", 0 ) )
        {
            sphere( impactorigin, getdvarfloat( @"hash_fba0c32e7cc40704", 10 ), ( 1, 0, 0 ), 0, 100 );
        }
    #/
    
    if ( var_f8573302f9e072bb )
    {
        var_d6d503636b6905c2 = spawnscriptable( "scriptable_zombie_neptune_rock_impact", impactorigin, impactangles );
        
        if ( isdefined( var_d6d503636b6905c2 ) )
        {
            var_d6d503636b6905c2 thread function_90e2d134f2959ac8( fightphase );
        }
    }
    
    if ( isdefined( var_b4f4728c9c9b6813 ) )
    {
        /#
            if ( getdvarfloat( @"hash_9436a16f50968ec2", 0 ) )
            {
                sphere( var_b4f4728c9c9b6813, getdvarfloat( @"hash_fba0c32e7cc40704", 10 ), ( 1, 0, 1 ), 0, 100 );
            }
        #/
        
        thread function_4286d7c18c414acf( var_b4f4728c9c9b6813, settings );
    }
    
    level function_9b1cb010f1d198b9( fightphase, impactorigin, self, var_f63bb4cb38d334de, settings );
}

// Namespace zombie_neptune_asm
// Params 0
// Checksum 0xaa4a4025, Offset: 0x1ab8
// Size: 0x1a, Type: bool
function can_aoe()
{
    return self.n_fight_phase >= ( self.var_c4e05d5d2ab0f78f ?? 3 );
}

// Namespace zombie_neptune_asm
// Params 1, eflags: 0x4
// Checksum 0xb8fdaa5d, Offset: 0x1adb
// Size: 0x371
function private function_edd80625095bda6e( thrown_rock )
{
    level endon( #"game_ended" );
    thrown_rock endon( #"missile_stuck" );
    thrown_rock endon( #"hash_3e65d870fb1fa49e" );
    thrown_rock endon( #"projectile_impact_player" );
    thrown_rock endon( #"projectile_impact_ai" );
    var_d48c127f577d65bf = 10;
    var_7cbb329a42c75e26 = 150;
    var_b3b6fd15e8ca737f = 30;
    var_257455908776e428 = 55;
    var_4a9c5bc83a480351 = 70;
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    fightphase = self.n_fight_phase;
    var_f63bb4cb38d334de = self.neptune_damage_scalar;
    thrown_rock waittill( #"missile_bounced" );
    var_99f8e049f2adf735 = thrown_rock utility::waittill_any_in_array_or_timeout( [ "projectile_impact_player", "projectile_impact_ai" ], 0.05 );
    
    if ( isdefined( thrown_rock ) )
    {
        rockorigin = thrown_rock.origin;
        rockcenter = thrown_rock getcentroid();
        
        if ( self.n_fight_phase == 3 )
        {
            rockcenter += ( 0, 0, -20 );
        }
        
        thrown_rock delete();
        
        if ( !isalive( self ) )
        {
            return;
        }
        
        if ( var_99f8e049f2adf735 == "timeout" )
        {
            trace_result = trace::capsule_get_closest_point( rockcenter, var_7cbb329a42c75e26, var_7cbb329a42c75e26 * 2, undefined, 0, [ thrown_rock ], trace::create_solid_ai_contents() );
            
            if ( !isdefined( trace_result ) || !isdefined( trace_result[ "normal" ] ) )
            {
                return;
            }
            
            switch ( fightphase )
            {
                case 1:
                    var_7d08637574e1352 = squared( var_b3b6fd15e8ca737f );
                    break;
                case 2:
                    var_7d08637574e1352 = squared( var_257455908776e428 );
                    break;
                case 3:
                    var_7d08637574e1352 = squared( var_4a9c5bc83a480351 );
                    break;
            }
            
            var_1a919f72f736d773 = utility::drop_to_ground( rockcenter, 150 );
            
            if ( distancesquared( trace_result[ "position" ], var_1a919f72f736d773 ) < var_7d08637574e1352 )
            {
                impactorigin = var_1a919f72f736d773;
            }
            else
            {
                impactorigin = trace_result[ "position" ];
            }
            
            level function_9b1cb010f1d198b9( fightphase, impactorigin, self, var_f63bb4cb38d334de, settings );
            var_70e80b53e1b1f756 = vectorcross( ( 0, 0, 1 ), trace_result[ "normal" ] * -1 );
            var_b4dbbe29267fdf4d = vectorcross( trace_result[ "normal" ] * -1, var_70e80b53e1b1f756 );
            var_d6d503636b6905c2 = spawnscriptable( "scriptable_zombie_neptune_rock_impact", rockorigin, axistoangles( var_b4dbbe29267fdf4d, var_70e80b53e1b1f756, trace_result[ "normal" ] * -1 ) );
            
            /#
                if ( getdvarfloat( @"hash_9436a16f50968ec2", 0 ) )
                {
                    line( rockorigin, rockorigin - trace_result[ "<dev string:x8b>" ] * 100, ( 0, 0, 1 ), 1, 0, 500 );
                    line( rockorigin, rockorigin + var_70e80b53e1b1f756 * 100, ( 0, 1, 0 ), 1, 0, 500 );
                    line( rockorigin, rockorigin + var_b4dbbe29267fdf4d * 100, ( 0, 1, 0 ), 1, 0, 500 );
                }
            #/
            
            if ( isdefined( var_d6d503636b6905c2 ) )
            {
                var_d6d503636b6905c2 thread function_90e2d134f2959ac8( fightphase );
            }
            
            if ( can_aoe() )
            {
                var_f4cbaee7b9fb220f = utility::drop_to_ground( rockorigin + trace_result[ "normal" ] * var_d48c127f577d65bf, 0 );
                thread function_4286d7c18c414acf( var_f4cbaee7b9fb220f, settings );
            }
        }
    }
}

// Namespace zombie_neptune_asm
// Params 1, eflags: 0x4
// Checksum 0x7fd669cc, Offset: 0x1e54
// Size: 0x192
function private function_4a9857d7835e4b65( thrown_rock )
{
    level endon( #"game_ended" );
    thrown_rock endon( #"missile_stuck" );
    thrown_rock endon( #"hash_3e65d870fb1fa49e" );
    thrown_rock endon( #"projectile_impact_ai" );
    var_19f299b8d961af85 = 100;
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    fightphase = self.n_fight_phase;
    var_f63bb4cb38d334de = self.neptune_damage_scalar;
    thrown_rock waittill( #"projectile_impact_player", hitplayer );
    thrown_rock utility::waittill_any_in_array_or_timeout( [ "projectile_impact_player", "projectile_impact_ai" ], 0.05 );
    rockcenter = thrown_rock getcentroid();
    thrown_rock delete();
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    var_f345bfeedd81d90b = utility::drop_to_ground( rockcenter, 0 );
    
    if ( hitplayer isonground() || distancesquared( hitplayer.origin, var_f345bfeedd81d90b ) <= squared( var_19f299b8d961af85 ) )
    {
        var_b121262f5c9f58a8 = var_f345bfeedd81d90b;
    }
    
    level function_9b1cb010f1d198b9( fightphase, var_b121262f5c9f58a8 ?? var_f345bfeedd81d90b, self, var_f63bb4cb38d334de, settings );
    
    if ( isdefined( var_b121262f5c9f58a8 ) )
    {
        var_d6d503636b6905c2 = spawnscriptable( "scriptable_zombie_neptune_rock_impact", var_b121262f5c9f58a8, ( 0, 0, 1 ) );
        
        if ( isdefined( var_d6d503636b6905c2 ) )
        {
            var_d6d503636b6905c2 thread function_90e2d134f2959ac8( self.n_fight_phase ?? fightphase );
        }
        
        thread function_4286d7c18c414acf( var_b121262f5c9f58a8, settings );
    }
}

// Namespace zombie_neptune_asm
// Params 1, eflags: 0x4
// Checksum 0xff8bf7f0, Offset: 0x1fee
// Size: 0x171
function private function_c63d4d4fdff2cffe( thrown_rock )
{
    level endon( #"game_ended" );
    thrown_rock endon( #"missile_stuck" );
    thrown_rock endon( #"hash_3e65d870fb1fa49e" );
    thrown_rock endon( #"projectile_impact_player" );
    var_19f299b8d961af85 = 100;
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    fightphase = self.n_fight_phase;
    var_f63bb4cb38d334de = self.neptune_damage_scalar;
    thrown_rock waittill( #"projectile_impact_ai", var_2be4b6c147d5a649 );
    rockcenter = thrown_rock getcentroid();
    thrown_rock delete();
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    var_f7ab2940b37d5860 = utility::drop_to_ground( rockcenter, 0 );
    
    if ( var_2be4b6c147d5a649 isonground() || distancesquared( var_2be4b6c147d5a649.origin, var_f7ab2940b37d5860 ) <= squared( var_19f299b8d961af85 ) )
    {
        var_b121262f5c9f58a8 = var_f7ab2940b37d5860;
    }
    
    level function_9b1cb010f1d198b9( fightphase, var_b121262f5c9f58a8 ?? var_f7ab2940b37d5860, self, var_f63bb4cb38d334de, settings );
    
    if ( isdefined( var_b121262f5c9f58a8 ) )
    {
        var_d6d503636b6905c2 = spawnscriptable( "scriptable_zombie_neptune_rock_impact", var_b121262f5c9f58a8, ( 0, 0, 1 ) );
        
        if ( isdefined( var_d6d503636b6905c2 ) )
        {
            var_d6d503636b6905c2 thread function_90e2d134f2959ac8( self.n_fight_phase ?? fightphase );
        }
        
        thread function_4286d7c18c414acf( var_b121262f5c9f58a8, settings );
    }
}

// Namespace zombie_neptune_asm
// Params 1, eflags: 0x4
// Checksum 0xfc9efef1, Offset: 0x2167
// Size: 0x144
function private function_c4786c145e01a09a( thrown_rock )
{
    level endon( #"game_ended" );
    thrown_rock endon( #"missile_bounced" );
    thrown_rock endon( #"hash_3e65d870fb1fa49e" );
    thrown_rock endon( #"projectile_impact_player" );
    thrown_rock endon( #"projectile_impact_ai" );
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    fightphase = self.n_fight_phase;
    var_f63bb4cb38d334de = self.neptune_damage_scalar;
    thrown_rock waittill( #"missile_stuck", hitent, partname, var_61c69ee04fb623e, velocity, position, normal );
    thrown_rock delete();
    
    if ( !isalive( self ) )
    {
        return;
    }
    
    var_d6d503636b6905c2 = spawnscriptable( "scriptable_zombie_neptune_rock_impact", position, ( 0, 0, 1 ) );
    
    if ( isdefined( var_d6d503636b6905c2 ) )
    {
        var_d6d503636b6905c2 thread function_90e2d134f2959ac8( self.n_fight_phase ?? fightphase );
    }
    
    level function_9b1cb010f1d198b9( fightphase, position, self, var_f63bb4cb38d334de, settings );
    thread function_4286d7c18c414acf( position, settings );
}

// Namespace zombie_neptune_asm
// Params 2, eflags: 0x4
// Checksum 0xb9258c82, Offset: 0x22b3
// Size: 0x541
function private function_4286d7c18c414acf( impactpos, var_842fba137b8c436 )
{
    if ( can_aoe() )
    {
        var_72a0a879ab48590e = getdvarint( @"hash_7aaeb91e3a44cdf4", 10 );
        var_d366bc85b899dcf8 = 5;
        var_a1070fb6169644b7 = 25;
        var_28dc1e2b877264a3 = 200;
        var_7e7092c99f8aa9ba = -12000;
        var_aab4f023f549dee7 = 0.9;
        var_cbe1afdfad47f465 = 0.7;
        var_a775451878b36ec7 = getaiarrayinradius( impactpos, var_a1070fb6169644b7 );
        var_424419ec5b5588c1 = utility::get_average_ground_normal( impactpos, var_a1070fb6169644b7, var_28dc1e2b877264a3, var_7e7092c99f8aa9ba, undefined, var_a775451878b36ec7 );
        var_3d21eec29b566ffb = ( 0, 0, 1 );
        
        if ( vectordot( var_424419ec5b5588c1, var_3d21eec29b566ffb ) < var_aab4f023f549dee7 && vectordot( var_424419ec5b5588c1, var_3d21eec29b566ffb ) >= var_cbe1afdfad47f465 )
        {
            var_95b812f782abbe71 = vectorcross( var_424419ec5b5588c1, var_3d21eec29b566ffb );
            var_d2ab457bcf25a504 = vectorcross( var_424419ec5b5588c1, var_95b812f782abbe71 );
            var_92ef78f1e11c0505 = axistoangles( var_d2ab457bcf25a504, var_95b812f782abbe71, var_424419ec5b5588c1 );
        }
        else
        {
            var_92ef78f1e11c0505 = var_3d21eec29b566ffb;
        }
        
        var_c090b06333e956c = spawnscriptable( "scriptable_zombie_neptune_large_rock_aoe", impactpos, var_92ef78f1e11c0505 );
        
        if ( !isdefined( var_c090b06333e956c ) )
        {
            return;
        }
        
        var_c090b06333e956c endon( #"death" );
        endtime = gettime() + var_842fba137b8c436.var_c4f5411001ce1f61 * 1000;
        
        if ( !isdefined( level.var_8171a2558d74c3e0 ) )
        {
            level.var_8171a2558d74c3e0 = [];
        }
        
        var_46d1b3d844669f25 = level.var_8171a2558d74c3e0.size >= var_d366bc85b899dcf8;
        var_2e18179083cc4185 = [ var_c090b06333e956c, gettime() ];
        var_a3b11b262e868fea = var_2e18179083cc4185;
        
        for ( i = 0; i < level.var_8171a2558d74c3e0.size ; i++ )
        {
            if ( distancesquared( level.var_8171a2558d74c3e0[ i ][ 0 ].origin, impactpos ) < squared( var_842fba137b8c436.var_b81e965f6476a2af ) )
            {
                var_3cd18bcd6960991c = level.var_8171a2558d74c3e0[ i ][ 0 ];
                level.var_8171a2558d74c3e0[ i ] = undefined;
                
                if ( isint( i ) )
                {
                    function_cdc669dbc8ea2101( level.var_8171a2558d74c3e0 );
                }
                
                var_3cd18bcd6960991c freescriptable();
                
                if ( var_46d1b3d844669f25 )
                {
                    var_46d1b3d844669f25 = 0;
                }
                
                break;
            }
            
            if ( var_46d1b3d844669f25 && level.var_8171a2558d74c3e0[ i ][ 1 ] < var_a3b11b262e868fea[ 1 ] )
            {
                var_a3b11b262e868fea = level.var_8171a2558d74c3e0[ i ];
                var_cb32138975f005fe = i;
            }
        }
        
        if ( var_46d1b3d844669f25 )
        {
            level.var_8171a2558d74c3e0[ var_cb32138975f005fe ] = undefined;
            
            if ( isint( var_cb32138975f005fe ) )
            {
                function_cdc669dbc8ea2101( level.var_8171a2558d74c3e0 );
            }
            
            var_a3b11b262e868fea[ 0 ] freescriptable();
        }
        
        level.var_8171a2558d74c3e0[ level.var_8171a2558d74c3e0.size ] = var_2e18179083cc4185;
        var_c090b06333e956c setscriptablepartstate( "aoe", "on" );
        
        while ( gettime() < endtime )
        {
            wait var_842fba137b8c436.var_c31e280d8f0193dc;
            
            if ( !isalive( self ) )
            {
                break;
            }
            
            nearbyents = getplayersandaiarrayinradius( impactpos, var_842fba137b8c436.var_b81e965f6476a2af );
            
            foreach ( nearbyent in nearbyents )
            {
                if ( nearbyent == self )
                {
                    continue;
                }
                
                if ( isplayer( nearbyent ) && !nearbyent.inlaststand && !nearbyent.var_b6f2224be9ed1a1b )
                {
                    if ( nearbyent utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_phd_flopper", #"phdflopper_safe_slide" ) && nearbyent issprintsliding() )
                    {
                        var_5a1beacbe736afa = 0;
                    }
                    else
                    {
                        if ( level.players.size == 1 )
                        {
                            var_5a1beacbe736afa = int( max( var_842fba137b8c436.var_a1a411b0c824e59c - var_72a0a879ab48590e, 1 ) );
                        }
                        else
                        {
                            var_5a1beacbe736afa = int( var_842fba137b8c436.var_a1a411b0c824e59c );
                        }
                        
                        self.turtle_shell_attack_origin = impactpos;
                        nearbyent dodamage( var_5a1beacbe736afa, impactpos, self, self, "MOD_PROJECTILE", undefined, "torso_upper", undefined, 1073741824 );
                        self.turtle_shell_attack_origin = undefined;
                    }
                    
                    continue;
                }
                
                if ( isai( nearbyent ) && nearbyent.team != self.team )
                {
                    var_2513b226dc289d47 = function_e7b2933ee390e524( 0, nearbyent.aicategory ?? "normal", nearbyent.maxhealth );
                    nearbyent dodamage( var_2513b226dc289d47, impactpos, self, self, "MOD_PROJECTILE", undefined, "torso_upper", undefined, 1073741824 );
                }
            }
        }
        
        for ( i = 0; i < level.var_8171a2558d74c3e0.size ; i++ )
        {
            if ( level.var_8171a2558d74c3e0[ i ][ 1 ] == var_2e18179083cc4185[ 1 ] )
            {
                level.var_8171a2558d74c3e0[ i ] = undefined;
                
                if ( isint( i ) )
                {
                    function_cdc669dbc8ea2101( level.var_8171a2558d74c3e0 );
                }
                
                var_c090b06333e956c freescriptable();
                break;
            }
        }
    }
}

// Namespace zombie_neptune_asm
// Params 1, eflags: 0x4
// Checksum 0x1f948bf4, Offset: 0x27fc
// Size: 0x26
function private function_5561bdf083ad6c15( scriptablestate )
{
    utility::function_32b24db3127bff40( "picked", scriptablestate );
    wait 2;
    self freescriptable();
}

// Namespace zombie_neptune_asm
// Params 1, eflags: 0x4
// Checksum 0x97a8bead, Offset: 0x282a
// Size: 0x7f
function private function_90e2d134f2959ac8( fightphase )
{
    switch ( fightphase )
    {
        case 1:
            self setscriptablepartstate( "impact", "small" );
            break;
        case 2:
            self setscriptablepartstate( "impact", "medium" );
            break;
        case 3:
            self setscriptablepartstate( "impact", "large" );
            break;
    }
    
    wait 1.5;
    self freescriptable();
}

// Namespace zombie_neptune_asm
// Params 5, eflags: 0x4
// Checksum 0x169b43f2, Offset: 0x28b1
// Size: 0x420
function private function_9b1cb010f1d198b9( fightphase, impactpoint, neptune, var_f63bb4cb38d334de, var_842fba137b8c436 )
{
    switch ( fightphase )
    {
        case 1:
            var_eb827eb4629f38ce = getdvarfloat( @"hash_498c13ae43f32879", var_842fba137b8c436.var_481e9b839b9d190e );
            var_f286d883770d508b = 0.1;
            break;
        case 2:
            var_eb827eb4629f38ce = getdvarfloat( @"hash_498c13ae43f32879", var_842fba137b8c436.var_2ab5b100a90cdd6d );
            var_f286d883770d508b = 0.4;
            break;
        case 3:
            var_eb827eb4629f38ce = getdvarfloat( @"hash_498c13ae43f32879", var_842fba137b8c436.var_741ee816e924eeb4 );
            var_f286d883770d508b = 0.65;
            break;
    }
    
    /#
        if ( getdvarfloat( @"hash_9436a16f50968ec2", 0 ) )
        {
            sphere( impactpoint, getdvarfloat( @"hash_498c13ae43f32879", var_eb827eb4629f38ce ), ( 1, 1, 1 ), 0, 100 );
        }
    #/
    
    nearbyents = getplayersandaiarrayinradius( impactpoint, var_eb827eb4629f38ce );
    
    foreach ( nearbyent in nearbyents )
    {
        if ( nearbyent == neptune )
        {
            continue;
        }
        
        var_a41166664af6aa52 = distance( impactpoint, nearbyent.origin );
        var_a9e6352b74faa839 = math::lerp_fraction( 0, var_842fba137b8c436.var_b81e965f6476a2af, var_a41166664af6aa52 );
        
        if ( isplayer( nearbyent ) && !nearbyent.inlaststand && !nearbyent.var_b6f2224be9ed1a1b )
        {
            switch ( fightphase )
            {
                case 1:
                    var_5bc5067f190ab937 = var_842fba137b8c436.var_6b74d55315902350;
                    var_d58c2bdde2e2c039 = var_842fba137b8c436.var_5195a386770990a2;
                    break;
                case 2:
                    var_5bc5067f190ab937 = var_842fba137b8c436.var_7dd6e862fc7ed6b5;
                    var_d58c2bdde2e2c039 = var_842fba137b8c436.var_7fbeda66536f327b;
                    break;
                case 3:
                    var_5bc5067f190ab937 = var_842fba137b8c436.var_83b0766f821a32a;
                    var_d58c2bdde2e2c039 = var_842fba137b8c436.var_ff8be28c4f205768;
                    break;
            }
            
            var_bbf445ae8f4290ea = int( math::lerp( var_d58c2bdde2e2c039, var_5bc5067f190ab937, var_a9e6352b74faa839 ) * var_f63bb4cb38d334de );
            nearbyent dodamage( var_bbf445ae8f4290ea, impactpoint, neptune, neptune, "MOD_PROJECTILE", undefined, "torso_upper", undefined, 1073741824 );
            nearbyent knockback_player( impactpoint, var_a9e6352b74faa839 );
            shockasset = var_842fba137b8c436.var_f08f1ba2707e579d;
            
            if ( shockasset )
            {
                nearbyent shellshock_utility::_shellshock( shockasset, #"damage", 1.5 );
            }
            
            continue;
        }
        
        if ( isai( nearbyent ) )
        {
            preventinstantkill = neptune utility::callsharedfunc( #"zombie_neptune", #"hash_fbd76818aa0a93", nearbyent );
            
            if ( !preventinstantkill && var_a9e6352b74faa839 < var_f286d883770d508b && !nearbyent.magic_bullet_shield && !nearbyent val::get( "damageshield" ) )
            {
                nearbyent.forceannihilate = 1;
                nearbyent kill();
                continue;
            }
            
            var_782c8a4ec62e7e4e = function_e7b2933ee390e524( var_a9e6352b74faa839, nearbyent.aicategory ?? "normal", nearbyent.maxhealth );
            
            if ( var_782c8a4ec62e7e4e > nearbyent.health )
            {
                if ( !nearbyent.noragdoll && !nearbyent.script_noragdoll )
                {
                    nearbyent function_79dcf35067f0aa4a( impactpoint, var_a9e6352b74faa839 );
                }
            }
            else if ( nearbyent zombie_knockdown::function_99b2020a564d9c7e( impactpoint ) )
            {
                nearbyent function_29853e0388efeb81( impactpoint, var_a9e6352b74faa839 );
            }
            
            nearbyent dodamage( var_782c8a4ec62e7e4e, impactpoint, neptune, neptune, "MOD_PROJECTILE", undefined, "torso_upper", undefined, 1073741824 );
        }
    }
}

// Namespace zombie_neptune_asm
// Params 3
// Checksum 0x3f8e5884, Offset: 0x2cd9
// Size: 0x12a
function function_e7b2933ee390e524( var_a9e6352b74faa839, aicategory, aimaxhealth )
{
    var_3d062c4caeee83f5 = 0.2;
    var_4464483d28d5ab28 = 0.4;
    var_cd3dffb0a85a0ccb = 0.1;
    var_f16d1c92848e00d6 = 0.3;
    var_d360b362e9076b1f = 0.01;
    var_b8a3a4c15af00b5a = 0.1;
    var_8f788e6251884233 = 0;
    var_55334b8554eb907e = 0;
    
    if ( aicategory == "normal" )
    {
        var_3a5935d846b2c9d1 = math::lerp( var_4464483d28d5ab28, var_3d062c4caeee83f5, var_a9e6352b74faa839 );
        return ( aimaxhealth * var_3a5935d846b2c9d1 );
    }
    
    if ( aicategory == "special" )
    {
        var_3a5935d846b2c9d1 = math::lerp( var_f16d1c92848e00d6, var_cd3dffb0a85a0ccb, var_a9e6352b74faa839 );
        return ( aimaxhealth * var_3a5935d846b2c9d1 );
    }
    
    if ( aicategory == "elite" || aicategory == "hvt" )
    {
        var_3a5935d846b2c9d1 = math::lerp( var_b8a3a4c15af00b5a, var_d360b362e9076b1f, var_a9e6352b74faa839 );
        return ( aimaxhealth * var_3a5935d846b2c9d1 );
    }
    
    if ( aicategory == "boss" )
    {
        var_3a5935d846b2c9d1 = math::lerp( var_55334b8554eb907e, var_8f788e6251884233, var_a9e6352b74faa839 );
        return ( aimaxhealth * var_3a5935d846b2c9d1 );
    }
    
    return 0;
}

// Namespace zombie_neptune_asm
// Params 2, eflags: 0x4
// Checksum 0xd09cff8f, Offset: 0x2e0b
// Size: 0xde
function private knockback_player( impactpoint, var_a9e6352b74faa839 )
{
    var_86e55fb678d98536 = 40;
    var_ee282694c7c4ed9b = 100;
    var_8fb3da75f662707c = 250;
    var_4875c4a245b82147 = vectornormalize2( self.origin - impactpoint );
    var_49942a609994af62 = vectorcross( var_4875c4a245b82147, ( 0, 0, 1 ) );
    var_d750b8a81b34edc6 = math::lerp( var_8fb3da75f662707c, var_ee282694c7c4ed9b, var_a9e6352b74faa839 );
    var_f186e7fac7ca9a06 = getdvarfloat( @"hash_21bfc2f5f654ff20", var_86e55fb678d98536 );
    impactmagnitude = getdvarfloat( @"hash_63a5c8451997935d", var_d750b8a81b34edc6 );
    impactvector = rotatepointaroundvector( var_49942a609994af62, var_4875c4a245b82147, var_f186e7fac7ca9a06 );
    self knockback( impactvector, impactmagnitude, 1 );
}

// Namespace zombie_neptune_asm
// Params 2, eflags: 0x4
// Checksum 0x9e2f1a7a, Offset: 0x2ef1
// Size: 0x6a
function private function_29853e0388efeb81( impactpoint, var_a9e6352b74faa839 )
{
    var_a85e18f6e2a76eef = 25;
    var_f0057641911a379a = 200;
    var_d76388e2199bd98f = 300;
    impactmagnitude = math::lerp( var_d76388e2199bd98f, var_f0057641911a379a, var_a9e6352b74faa839 );
    var_f186e7fac7ca9a06 = var_a85e18f6e2a76eef;
    zombie_knockdown::function_6fc167d4a3590991( impactpoint, impactmagnitude, var_f186e7fac7ca9a06 );
}

// Namespace zombie_neptune_asm
// Params 2, eflags: 0x4
// Checksum 0xfeebc1f, Offset: 0x2f63
// Size: 0xbd
function private function_79dcf35067f0aa4a( impactpoint, var_a9e6352b74faa839 )
{
    var_c31dc26c108992f8 = 45;
    var_f186e7fac7ca9a06 = var_c31dc26c108992f8;
    impactmagnitude = math::lerp( 7000, 5500, var_a9e6352b74faa839 );
    var_4875c4a245b82147 = vectornormalize2( self.origin - impactpoint );
    var_49942a609994af62 = vectorcross( var_4875c4a245b82147, ( 0, 0, 1 ) );
    impactvector = rotatepointaroundvector( var_49942a609994af62, var_4875c4a245b82147, var_f186e7fac7ca9a06 );
    impactvector = impactmagnitude * impactvector;
    self.ragdollimpactvector = impactvector;
    self.ragdollhitloc = "torso_lower";
    self.forceragdollimmediate = 1;
}

// Namespace zombie_neptune_asm
// Params 1, eflags: 0x4
// Checksum 0xb5403490, Offset: 0x3028
// Size: 0x64
function private function_47f8bd07c1e7d621( params )
{
    self aisetdesiredspeed( 70 );
    
    if ( self.n_fight_phase == 3 )
    {
        var_af7ba4bd1f2e8a0f = getdvarfloat( @"hash_41d427bf6a5282f5", 150 );
        zombie_utils::function_a8ce00e0448cb6f0( "sprint", "aitype_default", 0 );
        self function_786bb6aa1b76c7ee( "rockThrowAttackRange", var_af7ba4bd1f2e8a0f );
    }
    
    function_1ec96503c85b8721();
}

// Namespace zombie_neptune_asm
// Params 0
// Checksum 0xa9b97654, Offset: 0x3094
// Size: 0x7e
function function_1ec96503c85b8721()
{
    featurearray = [];
    featurearray[ "fight_phase" ] = self.n_fight_phase;
    alias = self function_805ca5e408d630c0( self.animsetname, "ground_slam", featurearray, 0 );
    
    if ( isdefined( alias ) )
    {
        self function_695b8e1b655c2796( "ground_slam", alias );
    }
    
    alias = self function_805ca5e408d630c0( self.animsetname, "ranged_attack_throw", featurearray, 0 );
    
    if ( isdefined( alias ) )
    {
        self function_695b8e1b655c2796( "ranged_attack_throw", alias );
    }
}

// Namespace zombie_neptune_asm
// Params 3
// Checksum 0x73fccdd1, Offset: 0x311a
// Size: 0x5b
function function_dd170c7e2f01519e( asmname, statename, params )
{
    alias = self.n_fight_phase == 1 ? "hand" : "head";
    animation = asm::asm_lookupanimfromalias( statename, alias );
    return animation;
}

// Namespace zombie_neptune_asm
// Params 3
// Checksum 0xca6c2bea, Offset: 0x317e
// Size: 0x5b
function function_67a47952b52d45c1( asmname, statename, params )
{
    alias = self.n_fight_phase == 3 ? "phase3" : "default";
    animation = asm::asm_lookupanimfromalias( statename, alias );
    return animation;
}

// Namespace zombie_neptune_asm
// Params 0, eflags: 0x4
// Checksum 0xe7435a6d, Offset: 0x31e2
// Size: 0x260
function private update_speed()
{
    self endon( #"death" );
    self.norm_speed = 0;
    var_8087cdad69a61e04 = [ 70, 130 ];
    var_80991007c2fda6e9 = [ 70, 100 ];
    
    while ( true )
    {
        var_316149904859a0e = getdvarfloat( @"phobos_speed", -1 );
        
        if ( var_316149904859a0e > 0 )
        {
            self aisetdesiredspeed( var_316149904859a0e );
            self aisettargetspeed( var_316149904859a0e );
            waitframe();
            continue;
        }
        
        if ( self getaiblackboarddynamic( "in_neptune_melee" ) || self getaiblackboarddynamic( "in_speed_boost" ) )
        {
            waitframe();
            continue;
        }
        
        var_73907523da8accb4 = getdvarfloat( @"hash_d58b71be0fba538a", 2 );
        var_4d395e738e5475e0 = getdvarfloat( @"hash_97b75af75bdcede4", 0.5 );
        var_f94281509c5def5 = getdvarfloat( @"hash_346bfd47215d456d", 250 );
        var_5950ad72c654d5c1 = level.framedurationseconds / var_73907523da8accb4;
        var_7d1a27a574d80981 = level.framedurationseconds / var_4d395e738e5475e0;
        var_1e709a6c59e3ec5d = 0;
        var_12232b932fba82de = var_1e709a6c59e3ec5d;
        is_recently_damaged = isdefined( self.last_dmg_struct.timehit ) && gettime() - self.last_dmg_struct.timehit < var_f94281509c5def5;
        
        if ( is_recently_damaged )
        {
            var_12232b932fba82de = 1;
        }
        
        if ( var_12232b932fba82de > self.norm_speed )
        {
            self.norm_speed = min( self.norm_speed + var_5950ad72c654d5c1, var_12232b932fba82de );
        }
        else if ( var_12232b932fba82de < self.norm_speed )
        {
            self.norm_speed = max( self.norm_speed - var_7d1a27a574d80981, var_12232b932fba82de );
        }
        
        switch ( self.n_fight_phase )
        {
            case 1:
            case 2:
                speed_range = var_8087cdad69a61e04;
                break;
            case 3:
                speed_range = var_80991007c2fda6e9;
                break;
        }
        
        self.current_desired_speed = math::remap( self.norm_speed, 0, 1, speed_range[ 0 ], speed_range[ 1 ] );
        self aisetdesiredspeed( self.current_desired_speed );
        self aisettargetspeed( self.current_desired_speed );
        waitframe();
    }
}

