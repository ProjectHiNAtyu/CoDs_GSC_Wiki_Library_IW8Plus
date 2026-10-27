// scripts\mp\zm\traps\rocket_trap.gsc  (hash_3eee8e23ac8492e5.gscc) (size: 8577 Bytes / 0x2181 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xbd2a7229 (3173675561)
// size ...... 8577 (0x2181)
// includes .. 7   (offset: 0x1f21)
// strings ... 43  (offset: 0x1f59)
// dev strs .. 0   (offset: 0x2181)
// exports ... 16  (offset: 0x1541)
// cseg ...... 0x3c0 + 0x1181 (0x1541)
// imports ... 63  (offset: 0x17c1)
// animtree1 . 0   (offset: 0x2181)
// animtree2 . 0   (offset: 0x2181)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\armor;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\zm\systems\zm_vo;
#using scripts\mp\zm\traps\trap_core;

#namespace rocket_trap;

// Namespace rocket_trap
// Params 0
// Checksum 0x6c7efce9, Offset: 0x3de
// Size: 0x506
function init()
{
    level._effect[ "rocket_explode_vfx" ] = loadfxasset( "vfx_t10_core_strk_warmachine_grenade_explosion_dirt" );
    level._effect[ "mini_rocket" ] = loadfxasset( "vfx_t10_levels_zm_bloodstone_lost_fire_wisp" );
    level utility::flag_wait( "begin_round_logic" );
    trap_core::function_63a557f0f22161af( "rocket_trap_switch", &function_f2714ab92ef08d76, &function_6e3ce8822466efa1 );
    level utility::flag_wait( "rocket_trap_switch_trap_init_finished" );
    level.rocket_trap = spawnstruct();
    level.rocket_trap.var_b3f243feede8456d = [];
    level.rocket_trap.weapons = [ "rocket_trap_proj_weapon", "rocket_trap_proj_weapon_speed_200" ];
    level.rocket_trap.tags = [ "tag_missile_01", "tag_missile_02", "tag_missile_03", "tag_missile_04", "tag_missile_05", "tag_missile_06", "tag_missile_07", "tag_missile_08", "tag_missile_09", "tag_missile_13", "tag_missile_14", "tag_missile_15", "tag_missile_16", "tag_missile_17", "tag_missile_18", "tag_missile_19", "tag_missile_20", "tag_missile_21" ];
    
    foreach ( var_f5d93163bb80f7b in level.var_f301c0b95ea728e2 )
    {
        if ( var_f5d93163bb80f7b.targetname == "rocket_trap_switch" )
        {
            index = level.rocket_trap.var_b3f243feede8456d.size;
            
            foreach ( trap_position in var_f5d93163bb80f7b.trap_positions )
            {
                level.rocket_trap.var_b3f243feede8456d[ index ] = trap_position.trap_scriptable;
                level.rocket_trap.var_b3f243feede8456d[ index ].var_afcdd2e924f2713f = [];
                level.rocket_trap.var_b3f243feede8456d[ index ].var_2f7f114d97aa3dff = [];
                
                foreach ( tag in level.rocket_trap.tags )
                {
                    sub_pos = spawnstruct();
                    sub_pos.tag = tag;
                    tag_origin = level.rocket_trap.var_b3f243feede8456d[ index ] gettagorigin( tag );
                    tag_angles = level.rocket_trap.var_b3f243feede8456d[ index ] gettagangles( tag );
                    sub_pos.angles = tag_angles;
                    sub_pos.origin = tag_origin + anglestoforward( tag_angles ) * 4;
                    level.rocket_trap.var_b3f243feede8456d[ index ].var_afcdd2e924f2713f[ level.rocket_trap.var_b3f243feede8456d[ index ].var_afcdd2e924f2713f.size ] = sub_pos;
                    level.rocket_trap.var_b3f243feede8456d[ index ] function_f0e5bd35c8e1a3c3( sub_pos, tag );
                }
                
                var_3010f232fa3880d9 = utility::getstructarray( trap_position.target, "targetname" );
                
                foreach ( sub_pos in var_3010f232fa3880d9 )
                {
                    level.rocket_trap.var_b3f243feede8456d[ index ].var_2f7f114d97aa3dff[ level.rocket_trap.var_b3f243feede8456d[ index ].var_2f7f114d97aa3dff.size ] = sub_pos;
                }
            }
        }
    }
}

// Namespace rocket_trap
// Params 2, eflags: 0x4
// Checksum 0x1d7cb55a, Offset: 0x8ec
// Size: 0x59
function private function_f0e5bd35c8e1a3c3( rocket_pos, tag )
{
    rocket_pos.mdl = utility::spawn_model( %"sat_zm_machinery_rocket_missile_01", rocket_pos.origin, rocket_pos.angles );
    rocket_pos.mdl linkto( self, tag );
}

// Namespace rocket_trap
// Params 1, eflags: 0x4
// Checksum 0x9f737f60, Offset: 0x94d
// Size: 0x86
function private function_f2714ab92ef08d76( activator )
{
    if ( isdefined( activator ) && !activator utility::ent_flag( "rocket_trap_first_kill_vo" ) )
    {
        if ( !level callback::exists( "on_zombie_ai_killed", &function_47bc6bd1d8806996 ) )
        {
            params = spawnstruct();
            params.activator = activator;
            level callback::add( "on_zombie_ai_killed", &function_47bc6bd1d8806996, params );
        }
    }
    
    self.active = 1;
    thread function_86f9de8dfc20d4e6( activator );
    thread function_85a1fa09392dc5dc();
}

// Namespace rocket_trap
// Params 1, eflags: 0x4
// Checksum 0xdbe33e31, Offset: 0x9db
// Size: 0x4e
function private function_86f9de8dfc20d4e6( activator )
{
    level endon( #"game_ended" );
    self endon( #"hash_7ba3639406d0d454" );
    
    for ( i = 0; i < 15 ; i++ )
    {
        childthread function_497328c29ae7256d( activator );
        wait 1;
    }
}

// Namespace rocket_trap
// Params 1, eflags: 0x4
// Checksum 0xcdbc4cf8, Offset: 0xa31
// Size: 0x3b
function private function_497328c29ae7256d( activator )
{
    thread fire_rocket( activator );
    waittime = randomfloatrange( 0.1, 0.3 );
    wait waittime;
    thread fire_rocket( activator );
}

// Namespace rocket_trap
// Params 0, eflags: 0x4
// Checksum 0x7b3ec1d7, Offset: 0xa74
// Size: 0x11a
function private function_85a1fa09392dc5dc()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    self.trap_scriptable utility::function_32b24db3127bff40( "additional", "replenish" );
    wait 0.8;
    
    while ( true )
    {
        wait 1;
        var_2c073a5c4266ff1e = 0;
        
        foreach ( rocket_pos in self.trap_scriptable.var_afcdd2e924f2713f )
        {
            if ( rocket_pos.fired )
            {
                self.trap_scriptable utility::function_32b24db3127bff40( "replenish_sfx", "playsound" );
                rocket_pos thread function_218870163c5bf7b5();
                var_2c073a5c4266ff1e = 1;
                break;
            }
        }
        
        if ( !var_2c073a5c4266ff1e && !self.active )
        {
            return;
        }
    }
}

// Namespace rocket_trap
// Params 0, eflags: 0x4
// Checksum 0xc599b21b, Offset: 0xb96
// Size: 0x7d
function private function_218870163c5bf7b5()
{
    level endon( #"game_ended" );
    self.fired = 0;
    self.var_270fe673d4042a04 = 1;
    self.mdl setlinkedorigin( ( -9, 0, 0 ) );
    self.mdl show();
    waitframe();
    self.mdl movetolinked( ( 0, 0, 0 ), 1 );
    wait 1;
    self.var_270fe673d4042a04 = 0;
}

// Namespace rocket_trap
// Params 1, eflags: 0x4
// Checksum 0x7932775c, Offset: 0xc1b
// Size: 0x3fe
function private fire_rocket( activator )
{
    level endon( #"game_ended" );
    self endon( #"death" );
    available_rockets = [];
    
    foreach ( rocket_pos in self.trap_scriptable.var_afcdd2e924f2713f )
    {
        if ( !rocket_pos.fired && !rocket_pos.var_270fe673d4042a04 )
        {
            available_rockets[ available_rockets.size ] = rocket_pos;
        }
    }
    
    if ( available_rockets.size == 0 )
    {
        return;
    }
    
    rocket_pos = utility::array_random( available_rockets );
    e_fire_target = utility::array_random( self.trap_scriptable.var_2f7f114d97aa3dff );
    ents = getplayersandaiarrayinradius( e_fire_target.origin, e_fire_target.radius );
    e_targets = [];
    
    foreach ( ent in ents )
    {
        if ( isai( ent ) && isdefined( ent.team ) && ent.team == "team_two_hundred" )
        {
            if ( !isdefined( e_targets ) )
            {
                e_targets = [];
            }
            
            e_targets[ e_targets.size ] = ent;
        }
    }
    
    targetai = utility::array_random( e_targets );
    hit_position = undefined;
    
    if ( targetai )
    {
        nav_pos = getclosestpointonnavmesh( targetai.origin );
        
        if ( nav_pos )
        {
            hit_position = nav_pos;
        }
        else
        {
            hit_position = targetai.origin;
        }
    }
    else
    {
        offset = ( randomintrange( e_fire_target.radius * -1, e_fire_target.radius ), randomintrange( e_fire_target.radius * -1, e_fire_target.radius ), 0 );
        nav_pos = getclosestpointonnavmesh( e_fire_target.origin + offset );
        
        if ( nav_pos )
        {
            hit_position = nav_pos;
        }
        else
        {
            hit_position = e_fire_target.origin;
        }
    }
    
    rocket_pos.fired = 1;
    rocket_pos.mdl hide();
    weapon_name = utility::array_random( level.rocket_trap.weapons );
    var_eb1f96c921ef5095 = rocket_pos.origin;
    fire_target = var_eb1f96c921ef5095 + anglestoforward( rocket_pos.angles ) * 100;
    fire_target -= ( 0, 0, 40 );
    rocket = weapon_utility::_magicbullet( makeweapon( weapon_name ), var_eb1f96c921ef5095, fire_target );
    rocket.targetname = "trap_attacker";
    rocket.activator = activator;
    rocket thread function_a3e3ca0b12668995( hit_position );
    rocket thread function_eb613b321807432c();
    rocket thread rocket_death_watcher( self.attack_entity.activator, self.attack_entity );
    self.trap_scriptable utility::function_7c10ea82c1e305b8( rocket_pos.tag, "on" );
    
    /#
        utility::draw_line_for_time( var_eb1f96c921ef5095, hit_position, 1, 0, 0, 1 );
        sphere( var_eb1f96c921ef5095, 10, ( 1, 0, 0 ), 0, 3 );
        sphere( fire_target, 10, ( 1, 0, 0 ), 0, 3 );
    #/
}

// Namespace rocket_trap
// Params 1, eflags: 0x4
// Checksum 0x4ebfcbda, Offset: 0x1021
// Size: 0x2a
function private function_a3e3ca0b12668995( hit_position )
{
    level endon( #"game_ended" );
    wait 0.05;
    
    if ( self )
    {
        self missile_settargetpos( hit_position );
    }
}

// Namespace rocket_trap
// Params 0, eflags: 0x4
// Checksum 0x8c1208e7, Offset: 0x1053
// Size: 0x7e
function private function_eb613b321807432c()
{
    level endon( #"game_ended" );
    self endon( #"death" );
    
    for ( var_181b14bb07adf969 = self.origin; true ; var_181b14bb07adf969 = var_e6ef1231966449aa )
    {
        waitframe();
        var_e6ef1231966449aa = self.origin;
        delta = var_e6ef1231966449aa - var_181b14bb07adf969;
        
        if ( length( delta ) < 0.0001 )
        {
            continue;
        }
        
        self.angles = vectortoangles( delta );
    }
}

// Namespace rocket_trap
// Params 2, eflags: 0x4
// Checksum 0x6877d0c9, Offset: 0x10d9
// Size: 0x12b
function private rocket_death_watcher( attacker, attack_entity )
{
    self waittill( #"death", attacker, cause, objweapon, meansofdeath );
    
    if ( isdefined( self ) )
    {
        function_de3ec6e92ba86409( self.origin );
        var_d0bf10f61a87b364 = getaiarrayinradius( self.origin, 250, "team_two_hundred" );
        a_ents = getentarrayinradius( undefined, undefined, self.origin, 250, 1 );
        players = [];
        
        foreach ( ent in a_ents )
        {
            if ( isplayer( ent ) )
            {
                if ( !isdefined( players ) )
                {
                    players = [];
                }
                
                players[ players.size ] = ent;
            }
        }
        
        function_393674333c232d49( var_d0bf10f61a87b364, players, attacker, attack_entity );
    }
}

// Namespace rocket_trap
// Params 4, eflags: 0x4
// Checksum 0xbb033b1a, Offset: 0x120c
// Size: 0x202
function private function_393674333c232d49( var_d0bf10f61a87b364, players, attacker, attack_entity )
{
    if ( var_d0bf10f61a87b364 )
    {
        var_4e00ee8d01ee7fa3 = 100;
        
        foreach ( var_ea616919227739f in var_d0bf10f61a87b364 )
        {
            if ( isalive( var_ea616919227739f ) )
            {
                if ( issubstr( var_ea616919227739f.aicategory, "normal" ) )
                {
                    var_4e00ee8d01ee7fa3 = var_ea616919227739f.maxhealth;
                }
                else
                {
                    var_4e00ee8d01ee7fa3 = var_ea616919227739f.maxhealth * 0.05;
                }
                
                var_ea616919227739f utility::ent_flag_set( "rocket_trap_kill" );
                var_ea616919227739f dodamage( var_4e00ee8d01ee7fa3, var_ea616919227739f.origin, attack_entity, attack_entity, "MOD_PROJECTILE" );
            }
        }
    }
    
    if ( players )
    {
        foreach ( player in players )
        {
            if ( isalive( player ) )
            {
                if ( val::get( "damage" ) )
                {
                    var_4e00ee8d01ee7fa3 = player.maxhealth * 0.05;
                    
                    if ( armor::hasarmor() )
                    {
                        armor::setarmorhealth( self.armorhealth - 20 );
                        self playrumbleonentity( "dafg_rumble_light" );
                        earthquake( 0.2, 0.5, self.origin, 100 );
                        continue;
                    }
                    
                    player dodamage( var_4e00ee8d01ee7fa3, player.origin, attack_entity, attack_entity, "MOD_PROJECTILE" );
                }
            }
        }
    }
}

// Namespace rocket_trap
// Params 1, eflags: 0x4
// Checksum 0xa4006501, Offset: 0x1416
// Size: 0x2c
function private function_de3ec6e92ba86409( hit_position )
{
    earthquake( 0.6, 2.5, hit_position, 400 );
    playrumbleonposition( "damage_heavy", hit_position );
}

// Namespace rocket_trap
// Params 1, eflags: 0x4
// Checksum 0xe2417df0, Offset: 0x144a
// Size: 0x34
function private function_6e3ce8822466efa1( activator )
{
    self notify( #"hash_7ba3639406d0d454" );
    self.active = 0;
    level callback::remove( "on_zombie_ai_killed", &function_47bc6bd1d8806996 );
}

// Namespace rocket_trap
// Params 2, eflags: 0x4
// Checksum 0x778788ec, Offset: 0x1486
// Size: 0xbb
function private function_47bc6bd1d8806996( params, s_additional_params )
{
    if ( !isdefined( s_additional_params.activator ) )
    {
        return;
    }
    
    if ( s_additional_params.activator utility::ent_flag( "rocket_trap_first_kill_vo" ) )
    {
        return;
    }
    
    level callback::remove( "on_zombie_ai_killed", &function_47bc6bd1d8806996 );
    s_additional_params.activator utility::ent_flag_set( "rocket_trap_first_kill_vo" );
    var_db75d3de862ce072 = s_additional_params.activator namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01( #"rocket_trap_first_kill_vo" );
    
    if ( !var_db75d3de862ce072 && s_additional_params.activator )
    {
        s_additional_params.activator utility::ent_flag_clear( "rocket_trap_first_kill_vo" );
    }
}

