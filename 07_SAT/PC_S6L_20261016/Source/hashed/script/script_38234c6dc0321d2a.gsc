// script_38234c6dc0321d2a  (hash_38234c6dc0321d2a.gscc) (size: 17540 Bytes / 0x4484 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x380484f4 (939820276)
// size ...... 17540 (0x4484)
// includes .. 14  (offset: 0x4064)
// strings ... 52  (offset: 0x40d4)
// dev strs .. 11  (offset: 0x4400)
// exports ... 45  (offset: 0x28c4)
// cseg ...... 0x44f + 0x2475 (0x28c4)
// imports ... 135 (offset: 0x2fcc)
// animtree1 . 0   (offset: 0x4484)
// animtree2 . 0   (offset: 0x4484)
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\easing;
#using scripts\common\scriptable;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\weapons\weap_scarabww;
#using scripts\mp\damagefeedback;
#using scripts\mp\interaction;
#using scripts\mp\loot\common_item;
#using scripts\mp\zm\systems\zm_quest;
#using scripts\mp\zm\systems\zm_round_reward_bundle;
#using scripts\mp\zm\systems\zm_save;
#using scripts\mp\zm\systems\zm_vo;

#namespace astral_motes;

// Namespace astral_motes
// Params 0, eflags: 0x5
// Checksum 0x654b7e3f, Offset: 0x46d
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"hash_9e80305c34cf8aeb", undefined, undefined, &init );
}

// Namespace astral_motes
// Params 0
// Checksum 0xe3397caf, Offset: 0x48e
// Size: 0x36
function init()
{
    if ( !getdvarint( @"hash_7e39a2e30610efde", 1 ) )
    {
        return;
    }
    
    level utility::flag_wait_all( "zm_sat_scarab_script_astral_motes_cs_completed" );
    level setup_astral_motes();
    
    /#
        level function_6ba81296e00f0414();
    #/
}

// Namespace astral_motes
// Params 0, eflags: 0x4
// Checksum 0xfd4bf670, Offset: 0x4cc
// Size: 0x202
function private setup_astral_motes()
{
    level.var_15313fda32ee3aa3 = spawnstruct();
    level.var_15313fda32ee3aa3.var_c9b8f22d382189d6 = [];
    level.var_15313fda32ee3aa3.var_6a02f400b41d36dc = utility::getstructarray( "astral_mote_spawn", "targetname" );
    level.var_15313fda32ee3aa3.var_cda555f949bd894f = [];
    level.var_15313fda32ee3aa3.var_6e3c6f36c083ea80 = [];
    
    foreach ( struct in level.var_15313fda32ee3aa3.var_6a02f400b41d36dc )
    {
        if ( struct.script_noteworthy == "forge" )
        {
            level.var_15313fda32ee3aa3.var_cda555f949bd894f[ level.var_15313fda32ee3aa3.var_cda555f949bd894f.size ] = struct;
        }
    }
    
    level.var_15313fda32ee3aa3.s_forge_center = utility::getstruct( "forge_center", "targetname" );
    level.var_15313fda32ee3aa3.var_1f1a821edcdf00b = level.var_15313fda32ee3aa3.s_forge_center.radius;
    level callback::add( "special_round_start", &function_f21caa42fa17f904 );
    
    if ( level zm_quest::function_b0a5181ebe7bb905() )
    {
        level callback::add( "on_round_start", &function_ed06cbc89f507a65 );
    }
    
    level scriptable::scriptable_adddamagedcallback( &function_8c4121fe3b19c9b3 );
    level callback::add( #"hash_db23ebf23acc8885", &function_9816680c54da63c0 );
    level callback::add( "usurped_power_land", &function_4776a0a96ca05cd6 );
    
    if ( level zm_save::function_1dda3554974a999e() )
    {
        level thread function_9f0c629ddc8a82dd();
        return;
    }
    
    level function_b2d1b97cc6d9006e( 6 );
}

// Namespace astral_motes
// Params 0, eflags: 0x4
// Checksum 0x5aa8a4f0, Offset: 0x6d6
// Size: 0x38
function private function_9f0c629ddc8a82dd()
{
    level zm_save::function_1f44a48caae2acbf();
    var_4827f53ab276e8f2 = zm_quest::function_73720cdf21c3cfd7( #"scarab_ww_quest", #"hash_4e4ce48fc0c2da14" );
    level function_b2d1b97cc6d9006e( var_4827f53ab276e8f2 );
}

// Namespace astral_motes
// Params 1, eflags: 0x4
// Checksum 0x820f8d4d, Offset: 0x716
// Size: 0x20
function private function_f21caa42fa17f904( params )
{
    if ( level zm_save::function_1dda3554974a999e() )
    {
        return;
    }
    
    function_b2d1b97cc6d9006e( 6 );
}

// Namespace astral_motes
// Params 1, eflags: 0x4
// Checksum 0xf103215d, Offset: 0x73e
// Size: 0x10e
function private function_ed06cbc89f507a65( params )
{
    if ( level zm_save::function_1dda3554974a999e() )
    {
        return;
    }
    
    n_total_motes = level.var_15313fda32ee3aa3.var_c9b8f22d382189d6.size;
    
    if ( n_total_motes < 4 )
    {
        function_b2d1b97cc6d9006e( 6 );
        return;
    }
    
    var_d72b1982ba01c3b1 = 0;
    
    foreach ( mote in level.var_15313fda32ee3aa3.var_c9b8f22d382189d6 )
    {
        if ( isdefined( mote.current_struct ) && mote.current_struct.script_noteworthy == "forge" )
        {
            var_d72b1982ba01c3b1 = 1;
            break;
        }
    }
    
    if ( !var_d72b1982ba01c3b1 )
    {
        function_c1a01b0c963ba4f1();
    }
}

// Namespace astral_motes
// Params 0, eflags: 0x4
// Checksum 0x6005267, Offset: 0x854
// Size: 0x96
function private function_c1a01b0c963ba4f1()
{
    if ( level.var_15313fda32ee3aa3.var_c9b8f22d382189d6.size >= 18 || level.var_15313fda32ee3aa3.var_cda555f949bd894f.size <= 0 )
    {
        return;
    }
    
    var_480c5932eaad505 = utility::array_random( level.var_15313fda32ee3aa3.var_cda555f949bd894f );
    function_9ff53054c89e44ed( var_480c5932eaad505 );
    level zm_quest::function_4eefe6de31f5ddab( #"scarab_ww_quest", #"hash_4e4ce48fc0c2da14", function_f79b35cb34a606db() );
    level callback::callback( #"hash_cafd4d00f2edf8b6" );
}

// Namespace astral_motes
// Params 1, eflags: 0x4
// Checksum 0x949a29bd, Offset: 0x8f2
// Size: 0x1bd
function private function_b2d1b97cc6d9006e( num_to_spawn )
{
    level utility::flag_wait( "scriptables_ready" );
    
    for ( i = 0; i < num_to_spawn ; i++ )
    {
        if ( level.var_15313fda32ee3aa3.var_c9b8f22d382189d6.size >= 18 )
        {
            return;
        }
        
        if ( i == 0 )
        {
            var_53a7cee5eb8419c6 = level.var_15313fda32ee3aa3.var_cda555f949bd894f;
        }
        else
        {
            var_53a7cee5eb8419c6 = level.var_15313fda32ee3aa3.var_6a02f400b41d36dc;
        }
        
        var_53a7cee5eb8419c6 = arrayrandomize( var_53a7cee5eb8419c6 );
        
        for ( j = 0; j < var_53a7cee5eb8419c6.size ; j++ )
        {
            s_spawn = var_53a7cee5eb8419c6[ j ];
            b_is_valid_spawner = 1;
            
            foreach ( mote in level.var_15313fda32ee3aa3.var_c9b8f22d382189d6 )
            {
                if ( distancesquared( mote.origin, s_spawn.origin ) < squared( 250 ) )
                {
                    b_is_valid_spawner = 0;
                    break;
                }
            }
            
            if ( !b_is_valid_spawner )
            {
                s_spawn = undefined;
                waitframe();
                continue;
            }
            
            break;
        }
        
        if ( !s_spawn )
        {
            continue;
        }
        
        function_9ff53054c89e44ed( s_spawn );
    }
    
    level zm_quest::function_4eefe6de31f5ddab( #"scarab_ww_quest", #"hash_4e4ce48fc0c2da14", function_f79b35cb34a606db() );
    level callback::callback( #"hash_cafd4d00f2edf8b6" );
}

// Namespace astral_motes
// Params 0, eflags: 0x4
// Checksum 0xf54e677c, Offset: 0xab7
// Size: 0x9d
function private function_f79b35cb34a606db()
{
    var_cc0161afe33b0d45 = 0;
    
    foreach ( mote in level.var_15313fda32ee3aa3.var_c9b8f22d382189d6 )
    {
        if ( !mote utility::ent_flag( "mote_moved_from_spawn" ) )
        {
            var_cc0161afe33b0d45++;
        }
    }
    
    return var_cc0161afe33b0d45;
}

// Namespace astral_motes
// Params 2
// Checksum 0x43c601af, Offset: 0xb5d
// Size: 0x171
function function_9ff53054c89e44ed( s_spawn, var_acbf7bfd5fda4971 = 1 )
{
    mote = spawnscriptable( %"sat_zm_scarab_astral_mote", s_spawn.origin, s_spawn.angles );
    mote.e_mover = utility::spawn_model( "tag_origin", s_spawn.origin, s_spawn.angles );
    mote.e_mover.mote = mote;
    mote scriptablesetparententity( mote.e_mover );
    mote.current_struct = s_spawn;
    level.var_15313fda32ee3aa3.var_c9b8f22d382189d6[ level.var_15313fda32ee3aa3.var_c9b8f22d382189d6.size ] = mote;
    mote.var_110cede20771938 = mote.e_mover;
    mote.var_66f56a71f5cd80d7 = &function_67ed7f40bfecabb7;
    
    if ( getdvarint( @"hash_b8ee93201da8c7fc", 1 ) )
    {
        mote function_4ff4796dbc764f93();
    }
    
    if ( var_acbf7bfd5fda4971 )
    {
        mote.e_mover function_616378d7e5b22efb( ( 0, 0, 1 ), 4, 2 );
    }
    
    level callback::callback( #"hash_6d92532e6d7f196d", { #mote:mote } );
    level notify( #"hash_6d92532e6d7f196d" );
    return mote;
}

// Namespace astral_motes
// Params 11, eflags: 0x4
// Checksum 0xe7f5d04b, Offset: 0xcd7
// Size: 0xcc
function private function_8c4121fe3b19c9b3( einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, vpoint, modelindex, partname )
{
    if ( instance.type != %"sat_zm_scarab_astral_mote" )
    {
        return;
    }
    
    if ( instance utility::ent_flag( "mote_moving" ) || instance utility::ent_flag( "mote_in_use" ) )
    {
        return;
    }
    
    if ( weap_scarabww::function_3a1514a781375202( einflictor ) )
    {
        instance.eattacker = eattacker;
        instance thread function_93c1b3bdcf06d895();
        instance thread mote_cleanup_watcher();
    }
}

// Namespace astral_motes
// Params 1, eflags: 0x4
// Checksum 0x69408360, Offset: 0xdab
// Size: 0x64, Type: bool
function private function_cb84dbb1eed98691( mote )
{
    if ( !isdefined( mote ) || mote.type != %"sat_zm_scarab_astral_mote" )
    {
        return false;
    }
    
    if ( mote utility::ent_flag( "mote_moving" ) || mote utility::ent_flag( "mote_in_use" ) || mote utility::ent_flag( "no_grapple" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace astral_motes
// Params 1, eflags: 0x4
// Checksum 0xc920524d, Offset: 0xe18
// Size: 0x52
function private function_9816680c54da63c0( params )
{
    retrieved_scriptable = params.scriptable;
    
    if ( !function_cb84dbb1eed98691( retrieved_scriptable ) )
    {
        return;
    }
    
    if ( isplayer( self ) )
    {
        damagefeedback::updatehitmarker( "standard", undefined, undefined, 0, undefined );
    }
    
    retrieved_scriptable function_aaba290a61861601( self );
}

// Namespace astral_motes
// Params 1, eflags: 0x4
// Checksum 0x45a954c4, Offset: 0xe72
// Size: 0x3f, Type: bool
function private function_67ed7f40bfecabb7( mote )
{
    if ( !isplayer( self ) || !isdefined( level.var_15313fda32ee3aa3 ) || !function_cb84dbb1eed98691( mote ) )
    {
        return false;
    }
    
    mote function_aaba290a61861601( self );
    return true;
}

// Namespace astral_motes
// Params 1, eflags: 0x4
// Checksum 0x931d2baf, Offset: 0xeba
// Size: 0x5e
function private function_aaba290a61861601( player )
{
    if ( self.e_mover )
    {
        self.e_mover notify( #"stop_curve" );
    }
    
    if ( self.current_struct )
    {
        self.current_struct = undefined;
    }
    
    utility::ent_flag_set( "mote_moving" );
    thread function_f5bf920cdaf0efcd( player );
    thread mote_cleanup_watcher();
}

// Namespace astral_motes
// Params 0, eflags: 0xc
// Checksum 0x1e463926, Offset: 0xf20
// Size: 0x5d
function private mote_cleanup_watcher()
{
    self notify( #"hash_d2a87953031ead4" );
    self endon( #"hash_d2a87953031ead4" );
    self endon( #"clean_up_mote" );
    wait 180;
    
    if ( !utility::ent_flag( "mote_in_forge" ) && !self.var_648eef0ab0822c74 && !utility::ent_flag( "mote_in_use" ) )
    {
        thread clean_up_mote();
    }
}

// Namespace astral_motes
// Params 0, eflags: 0x4
// Checksum 0x43d6019b, Offset: 0xf85
// Size: 0x1c8
function private function_93c1b3bdcf06d895()
{
    if ( self.e_mover )
    {
        self.e_mover notify( #"stop_curve" );
    }
    
    utility::ent_flag_set( "mote_moving" );
    v_start_origin = self.e_mover.origin;
    v_launch = self.e_mover.origin + ( 0, 0, 1 ) * 600;
    utility::function_7c10ea82c1e305b8( "body", "idle_forge" );
    self.e_mover moveto( self.e_mover.origin + ( 0, 0, 15 ), 0.6, 0.6 );
    distance = distance( self.e_mover.origin, v_launch );
    move_time = distance / 100;
    level callback::callback( #"hash_3cc6ad69f4fc9bca", { #mote:self } );
    self.e_mover utility::follow_spiral( 10, 50, ( 0, 0, 1 ), 600, move_time, self.e_mover.origin, 3.9, undefined, undefined, 0, 0, move_time * 0.95 );
    
    if ( !self.var_648eef0ab0822c74 )
    {
        self.e_mover moveto( v_start_origin, move_time * 0.7, move_time / 4, move_time / 4 );
        self.e_mover waittill( #"movedone" );
        self notify( #"hash_773759a7b2a12f60" );
        utility::function_7c10ea82c1e305b8( "body", "idle" );
        function_af255fa65d6d08f7( 1 );
    }
}

// Namespace astral_motes
// Params 1, eflags: 0x4
// Checksum 0xf8f7f17c, Offset: 0x1155
// Size: 0x184
function private function_f5bf920cdaf0efcd( player )
{
    self.e_mover endon( #"death" );
    utility::ent_flag_set( "mote_moved_from_spawn" );
    level zm_quest::function_4eefe6de31f5ddab( #"scarab_ww_quest", #"hash_4e4ce48fc0c2da14", function_f79b35cb34a606db() );
    level callback::callback( #"hash_94cf26f78221f00c", { #player:player, #mote:self } );
    self setscriptablepartstate( "body", "grabbed" );
    
    if ( function_1de2a456e1ff2e6e( player ) )
    {
        function_a77af03d7d28b3e1( player );
        return;
    }
    
    player_center_origin = player getcentroid();
    var_e56e6defeb358835 = vectornormalize( self.e_mover.origin - player_center_origin );
    move_to_origin = player_center_origin + var_e56e6defeb358835 * 50;
    move_to_origin = getclosestpointonnavmesh( move_to_origin );
    move_to_origin += ( 0, 0, 50 );
    distance = distance( self.e_mover.origin, move_to_origin );
    move_time = distance / 800;
    jitter_strength = clamp( distance / 100, 0.3, 5 );
    deceleration_time = distance > 350 ? move_time / 5 : move_time / 2;
    self.e_mover function_690ea02774aaaeaf( move_time, move_to_origin, 0, deceleration_time, jitter_strength );
    function_af255fa65d6d08f7();
}

// Namespace astral_motes
// Params 5
// Checksum 0x8fe35d6e, Offset: 0x12e1
// Size: 0x1bf
function function_690ea02774aaaeaf( move_time_sec, move_to_origin, acceleration_time = 0, deceleration_time = 0, jitter_strength = 1 )
{
    self endon( #"death" );
    start_origin = self.origin;
    start_time = gettime();
    time_elapsed = 0;
    var_9e77f887aabaa9f7 = move_time_sec - deceleration_time;
    
    while ( time_elapsed < move_time_sec )
    {
        if ( !isdefined( self ) )
        {
            break;
        }
        
        raw_pct = min( 1, time_elapsed / move_time_sec );
        var_1ccc664edf819117 = easing::ease_power( 0, 1, raw_pct, acceleration_time > 0, deceleration_time > 0 );
        target_pos = ( 1 - var_1ccc664edf819117 ) * start_origin + var_1ccc664edf819117 * move_to_origin;
        
        if ( acceleration_time > 0 && time_elapsed <= acceleration_time )
        {
            jitter_scalar = easing::ease_power( 0, jitter_strength, time_elapsed / acceleration_time, 1, 0 );
        }
        else if ( deceleration_time > 0 && time_elapsed >= var_9e77f887aabaa9f7 )
        {
            jitter_scalar = easing::ease_power( jitter_strength, 0, ( time_elapsed - var_9e77f887aabaa9f7 ) / deceleration_time, 0, 1 );
        }
        else
        {
            jitter_scalar = jitter_strength;
        }
        
        jitter_offset = ( randomfloatrange( -1, 1 ) * jitter_scalar, randomfloatrange( -1, 1 ) * jitter_scalar, randomfloatrange( -1, 1 ) * jitter_scalar );
        new_pos = target_pos + jitter_offset;
        self moveto( new_pos, level.framedurationseconds );
        self waittill( #"movedone" );
        time_elapsed = utility::function_6f5d2e1f1ff70482( gettime() - start_time );
    }
}

// Namespace astral_motes
// Params 0, eflags: 0x4
// Checksum 0x2e8b38d7, Offset: 0x14a8
// Size: 0x43
function private function_4ff4796dbc764f93()
{
    self.interaction = interaction::register_scriptable_interact( self, &function_6c5422647d4d47e2, undefined, undefined, &mote_hint );
    self.interaction.mote = self;
    self setscriptablepartstate( "usable", "usable" );
}

// Namespace astral_motes
// Params 1, eflags: 0x4
// Checksum 0xa7908c96, Offset: 0x14f3
// Size: 0x115
function private function_6c5422647d4d47e2( player )
{
    if ( player && player.interactions_disabled )
    {
        return;
    }
    
    if ( self.mote utility::ent_flag( "mote_in_use" ) || self.mote utility::ent_flag( "mote_in_forge" ) || self.mote utility::ent_flag( "mote_moving" ) || self.mote.var_648eef0ab0822c74 )
    {
        return;
    }
    
    loot_spawn_origin = getclosestpointonnavmesh( self.mote.origin );
    
    if ( loot_spawn_origin && distancesquared( loot_spawn_origin, self.mote.origin ) <= squared( 150 ) )
    {
        if ( !level utility::flag( "first_mote_loot_vo_played" ) )
        {
            level utility::flag_set( "first_mote_loot_vo_played" );
            player utility::delaythread( 1, &namespace_c0b4f2882c9d100f::function_8c1a12974bd11f01, #"hash_711383f504d11112" );
        }
        
        level function_4df7c15a9c9b6d9d( self.mote, loot_spawn_origin );
    }
}

// Namespace astral_motes
// Params 2, eflags: 0x4
// Checksum 0x77509b9b, Offset: 0x1610
// Size: 0x36
function private mote_hint( interact, player )
{
    return { #string:&"", #type:"HINT_NOBUTTON" };
}

// Namespace astral_motes
// Params 2, eflags: 0x4
// Checksum 0x76f4039, Offset: 0x164f
// Size: 0x16e
function private function_4df7c15a9c9b6d9d( mote, loot_spawn_origin )
{
    level endon( #"game_ended" );
    mote setscriptablepartstate( "usable", "off" );
    mote utility::ent_flag_set( "mote_in_use" );
    mote_origin = mote.origin;
    level callback::callback( #"hash_aaf65c4358cf66a2", { #mote:mote } );
    mote clean_up_mote();
    spawnoptions = common_item::function_f5dfaa3bbdf99a33( loot_spawn_origin, mote_origin );
    spawnoptions.var_9161cf0784b6951d = 0;
    spawnoptions.var_2321e933cbdf46d8 = 8;
    spawnoptions.var_34444f0dda11f0d5 = 8;
    spawnoptions.var_18608bd8660b3a19 = 2;
    spawnoptions.var_789c456dda9c8572 = mote_origin;
    var_8b5270de14dff72e = zm_round_reward_bundle::function_8cbad2bff5b7cc1( "sat_zm_scarab_astral_mote_round_rewards", "default" );
    spawnoptions.var_44d5025c8cfbd48e = var_8b5270de14dff72e.size;
    
    if ( utility::percent_chance( 3 ) )
    {
        additionalitems = zm_round_reward_bundle::function_8cbad2bff5b7cc1( "sat_zm_scarab_astral_mote_round_rewards", "default" );
        var_8b5270de14dff72e = arraycombine( var_8b5270de14dff72e, additionalitems );
    }
    
    for ( i = 0; i < var_8b5270de14dff72e.size ; i++ )
    {
        itemspawnentryname = var_8b5270de14dff72e[ i ];
        
        if ( !itemspawnentryname )
        {
            continue;
        }
        
        common_item::function_61c2c0251e742ffd( itemspawnentryname, undefined, spawnoptions );
        wait 0.1;
    }
}

// Namespace astral_motes
// Params 1, eflags: 0x4
// Checksum 0xdfec934e, Offset: 0x17c5
// Size: 0x57, Type: bool
function private function_1de2a456e1ff2e6e( player )
{
    if ( distance2dsquared( player.origin, level.var_15313fda32ee3aa3.s_forge_center.origin ) < squared( level.var_15313fda32ee3aa3.var_1f1a821edcdf00b ) )
    {
        return true;
    }
    
    return false;
}

// Namespace astral_motes
// Params 1, eflags: 0x4
// Checksum 0xa790087a, Offset: 0x1825
// Size: 0x2ad
function private function_a77af03d7d28b3e1( player )
{
    self.e_mover endon( #"death" );
    self setscriptablepartstate( "usable", "off" );
    utility::ent_flag_set( "mote_in_forge" );
    
    if ( level.var_15313fda32ee3aa3.var_6e3c6f36c083ea80.size >= 1 )
    {
        foreach ( mote in level.var_15313fda32ee3aa3.var_6e3c6f36c083ea80 )
        {
            level.var_15313fda32ee3aa3.var_6e3c6f36c083ea80 = arrayremove( level.var_15313fda32ee3aa3.var_6e3c6f36c083ea80, mote );
            mote setscriptablepartstate( "body", "despawn" );
            utility::delaythread( 0.5, &delete_mote, mote );
        }
    }
    
    level.var_15313fda32ee3aa3.var_6e3c6f36c083ea80[ level.var_15313fda32ee3aa3.var_6e3c6f36c083ea80.size ] = self;
    self setscriptablepartstate( "health", "ignore_damage" );
    self setscriptablepartstate( "grapple", "off" );
    utility::ent_flag_set( "mote_moving" );
    var_58d09328015d2828 = player getcentroid();
    var_58d09328015d2828 = ( var_58d09328015d2828[ 0 ], var_58d09328015d2828[ 1 ], level.var_15313fda32ee3aa3.s_forge_center.origin[ 2 ] );
    self.e_mover moveto( var_58d09328015d2828, 1 );
    self.e_mover waittill( #"movedone" );
    level utility::flag_set( "astral_mote_in_forge_area" );
    level callback::callback( #"hash_5c9ab8f9aa9fa81b", { #mote:self } );
    self setscriptablepartstate( "body", "idle_forge" );
    utility::function_7c10ea82c1e305b8( "extra_explosion_fx", "on" );
    var_32b5f0bc77155033 = distance2d( self.e_mover.origin, level.var_15313fda32ee3aa3.s_forge_center.origin );
    self.e_mover utility::follow_spiral( var_32b5f0bc77155033, 150, ( 0, 0, 0 ), 0, 3.5, level.var_15313fda32ee3aa3.s_forge_center.origin, 5 );
    thread function_e9dbcd7d40a34341();
}

// Namespace astral_motes
// Params 0
// Checksum 0x3aa003d3, Offset: 0x1ada
// Size: 0x6e
function function_e9dbcd7d40a34341()
{
    level endon( #"overcharge_motes_active" );
    
    if ( level utility::flag( "overcharge_motes_active" ) )
    {
        return;
    }
    
    while ( true )
    {
        self.e_mover thread utility::follow_circle( 150, 2, level.var_15313fda32ee3aa3.s_forge_center.origin, 1 );
        self.e_mover waittill( #"off_circle_move" );
    }
}

// Namespace astral_motes
// Params 0
// Checksum 0x4929de75, Offset: 0x1b50
// Size: 0x92
function function_9061591a110584b5()
{
    level utility::flag_set( "overcharge_motes_active" );
    
    foreach ( mote in level.var_15313fda32ee3aa3.var_6e3c6f36c083ea80 )
    {
        mote thread function_2c397d66a4054b07();
    }
}

// Namespace astral_motes
// Params 0, eflags: 0x4
// Checksum 0x680e701e, Offset: 0x1bea
// Size: 0x224
function private function_2c397d66a4054b07()
{
    mote = self;
    mote.e_mover endon( #"death" );
    level.var_15313fda32ee3aa3.var_c9b8f22d382189d6 = arrayremove( level.var_15313fda32ee3aa3.var_c9b8f22d382189d6, mote );
    level.var_15313fda32ee3aa3.var_6e3c6f36c083ea80 = arrayremove( level.var_15313fda32ee3aa3.var_6e3c6f36c083ea80, mote );
    mote.e_mover notify( #"interrupt_circle_move" );
    mote.e_mover notify( #"hash_2da5abc0d9cf41ac" );
    mote setscriptablepartstate( "body", "fly_into_forge" );
    mote.e_mover utility::follow_spiral( 150, 0, ( 0, 0, 0 ), 0, 1.5, level.var_15313fda32ee3aa3.s_forge_center.origin, 3 );
    playworldsound( mote.origin, #"hash_f58df4f625baa44f" );
    second_mote = spawnscriptable( %"sat_zm_scarab_astral_mote", mote.origin, mote.angles );
    second_mote setscriptablepartstate( "body", "fly_into_forge" );
    second_mote.e_mover = utility::spawn_model( "tag_origin", mote.origin, mote.angles );
    second_mote utility::scriptable_setparententity( second_mote.e_mover );
    mote function_5a1de8ae888b8b1a( level.scarab_pap_quest.var_c6b9e23aac03b4d0[ 0 ] );
    second_mote function_5a1de8ae888b8b1a( level.scarab_pap_quest.var_c6b9e23aac03b4d0[ 1 ] );
    mote.e_mover waittill( #"off_bezier_curve" );
    level notify( #"motes_in_forge_charged_braziers" );
    mote clean_up_mote( "despawn_explo" );
    second_mote clean_up_mote( "despawn_explo" );
    level utility::flag_clear( "overcharge_motes_active" );
}

// Namespace astral_motes
// Params 1, eflags: 0x4
// Checksum 0x4ab15b8b, Offset: 0x1e16
// Size: 0xa1
function private function_5a1de8ae888b8b1a( brazier )
{
    mote = self;
    start_pos = mote.e_mover.origin;
    end_pos = brazier.origin + ( 0, 0, 25 );
    midpoint = ( start_pos + end_pos ) / 2;
    control_point = midpoint + ( 0, 0, 215 );
    mote.e_mover thread utility::function_8001268940441423( start_pos, end_pos, control_point, 0.75 );
}

// Namespace astral_motes
// Params 1
// Checksum 0x52b3e06e, Offset: 0x1ebf
// Size: 0x116
function clean_up_mote( str_state )
{
    if ( !self )
    {
        return;
    }
    
    if ( self.var_648eef0ab0822c74 )
    {
        return;
    }
    
    self.var_be69453720c739ad = 1;
    self notify( #"clean_up_mote" );
    logstring( "Mote cleaned up at " + self.origin + " with state " + str_state );
    
    if ( arraycontains( level.var_15313fda32ee3aa3.var_c9b8f22d382189d6, self ) )
    {
        level.var_15313fda32ee3aa3.var_c9b8f22d382189d6 = arrayremove( level.var_15313fda32ee3aa3.var_c9b8f22d382189d6, self );
    }
    
    if ( arraycontains( level.var_15313fda32ee3aa3.var_6e3c6f36c083ea80, self ) )
    {
        level.var_15313fda32ee3aa3.var_6e3c6f36c083ea80 = arrayremove( level.var_15313fda32ee3aa3.var_6e3c6f36c083ea80, self );
    }
    
    self setscriptablepartstate( "body", str_state ?? "despawn" );
    utility::delaythread( 1, &delete_mote, self );
    level callback::callback( #"hash_f6fe6e9f66f0e5f4" );
}

// Namespace astral_motes
// Params 1, eflags: 0x4
// Checksum 0xd6b54ced, Offset: 0x1fdd
// Size: 0x4f
function private delete_mote( mote )
{
    assert( !mote.var_648eef0ab0822c74, "<dev string:x24>" );
    
    if ( mote.e_mover )
    {
        mote.e_mover delete();
    }
    
    if ( mote )
    {
        mote freescriptable();
    }
}

// Namespace astral_motes
// Params 1
// Checksum 0x8e1ce039, Offset: 0x2034
// Size: 0x8e
function function_af255fa65d6d08f7( var_92a5b32b3fca8541 = 0 )
{
    level callback::callback( #"hash_aea7afa2ef607bca", { #mote:self } );
    self setscriptablepartstate( "body", "idle" );
    starting_dir = var_92a5b32b3fca8541 ? ( 0, 0, -1 ) : ( 0, 0, 1 );
    self.e_mover function_616378d7e5b22efb( starting_dir, 4, 2 );
    utility::ent_flag_clear( "mote_moving" );
}

// Namespace astral_motes
// Params 1, eflags: 0x4
// Checksum 0xe2cc13f3, Offset: 0x20ca
// Size: 0x171
function private function_4776a0a96ca05cd6( params )
{
    if ( params.var_55bc4979ee147531 )
    {
        if ( !level utility::flag( "its_raining" ) )
        {
            return;
        }
        
        a_motes = getentitylessscriptablearray( %"sat_zm_scarab_astral_mote", undefined, params.var_55bc4979ee147531, 64 );
        
        if ( a_motes.size >= 1 )
        {
            params.equipinfo.b_skip_molotov = 1;
            level utility::delaythread( 0.05, &function_24b3d440708b288, params );
            
            if ( isplayer( params.player ) )
            {
                params.player damagefeedback::updatehitmarker( "standard", undefined, undefined, 0, undefined );
            }
        }
        else
        {
            level function_4c56fc9bf21b715( params.var_55bc4979ee147531, params.player );
        }
        
        foreach ( mote in a_motes )
        {
            if ( !mote utility::ent_flag( "mote_in_use" ) || mote.var_648eef0ab0822c74 )
            {
                level function_c87ccf324024219f( mote, params.player );
            }
        }
    }
}

// Namespace astral_motes
// Params 1, eflags: 0x4
// Checksum 0x5e96f1a8, Offset: 0x2243
// Size: 0x31
function private function_24b3d440708b288( params )
{
    if ( params.equipinfo )
    {
        params.equipinfo.b_skip_molotov = 0;
    }
}

// Namespace astral_motes
// Params 2, eflags: 0x4
// Checksum 0x4fad5705, Offset: 0x227c
// Size: 0xff
function private function_4c56fc9bf21b715( var_55bc4979ee147531, player )
{
    for ( var_8af4bb0185feb88 = 1; var_8af4bb0185feb88 <= 4 ; var_8af4bb0185feb88++ )
    {
        var_5b6fc0847b50a220 = utility::getstruct( "sst_head_center" + var_8af4bb0185feb88 );
        
        if ( level utility::flag( "sst_asey_check" + var_8af4bb0185feb88 ) && !level utility::flag( "sst_made_nice" + var_8af4bb0185feb88 ) )
        {
            if ( distance( var_55bc4979ee147531, var_5b6fc0847b50a220.origin ) <= 64 )
            {
                mote = function_9ff53054c89e44ed( var_5b6fc0847b50a220 );
                mote.var_648eef0ab0822c74 = 1;
                mote.var_8af4bb0185feb88 = var_8af4bb0185feb88;
                
                if ( isplayer( player ) )
                {
                    player damagefeedback::updatehitmarker( "standard", undefined, undefined, 0, undefined );
                }
                
                level function_c87ccf324024219f( mote, player );
                logstring( "expected to find monkey at temple: " + var_8af4bb0185feb88 + " but didn't, so hit failsafe 1" );
                function_edb6620471493f5d( var_5b6fc0847b50a220.origin );
            }
        }
    }
}

// Namespace astral_motes
// Params 0
// Checksum 0x5b204dca, Offset: 0x2383
// Size: 0xfa
function function_716ebb0b24af874a()
{
    level endon( #"sst_made_nice_all" );
    
    while ( true )
    {
        for ( var_8af4bb0185feb88 = 1; var_8af4bb0185feb88 <= 4 ; var_8af4bb0185feb88++ )
        {
            if ( level utility::flag( "sst_asey_check" + var_8af4bb0185feb88 ) && !level utility::flag( "sst_made_nice" + var_8af4bb0185feb88 ) )
            {
                var_5b6fc0847b50a220 = utility::getstruct( "sst_head_center" + var_8af4bb0185feb88 );
                a_motes = getentitylessscriptablearray( %"sat_zm_scarab_astral_mote", undefined, var_5b6fc0847b50a220.origin, 64 );
                
                if ( a_motes.size > 0 )
                {
                    continue;
                }
                
                mote = function_9ff53054c89e44ed( var_5b6fc0847b50a220, 0 );
                mote.var_648eef0ab0822c74 = 1;
                mote.var_8af4bb0185feb88 = var_8af4bb0185feb88;
                logstring( "expected to find monkey at temple: " + var_8af4bb0185feb88 + " but didn't, so hit failsafe 2" );
                function_edb6620471493f5d( var_5b6fc0847b50a220.origin );
            }
        }
        
        wait 1;
    }
}

// Namespace astral_motes
// Params 1, eflags: 0x4
// Checksum 0xf90d6cae, Offset: 0x2485
// Size: 0xfc
function private function_edb6620471493f5d( var_d28da43959472613 )
{
    var_53f00c70fb6e2670 = gettime() / 1000;
    logstring( "monkey found missing at: " + var_53f00c70fb6e2670 + " seconds from level start. Generating snapshot: " );
    
    foreach ( player in level.players )
    {
        var_3dcff50288da379e = player getplayerclientnum();
        client_origin = player.origin;
        var_aadce114e6fbcfe5 = distance( client_origin, var_d28da43959472613 );
        logstring( "Player " + var_3dcff50288da379e + " was at: " + client_origin + " which is " + var_aadce114e6fbcfe5 + " units from expected loc" );
    }
}

// Namespace astral_motes
// Params 2, eflags: 0x4
// Checksum 0xe0d72f3c, Offset: 0x2589
// Size: 0xbf
function private function_c87ccf324024219f( mote, player )
{
    mote utility::ent_flag_set( "mote_in_use" );
    params = spawnstruct();
    params.attacker = player;
    params.origin = mote.origin;
    params.mote = mote;
    
    if ( utility::issharedfuncdefined( #"zm", #"on_deadwire_lightning_strike" ) )
    {
        params thread utility::callsharedfunc( #"zm", #"on_deadwire_lightning_strike", params );
    }
    
    level callback::callback( #"hash_f66882b6a668fd78", params );
    mote clean_up_mote( "despawn_lightning" );
}

/#

    // Namespace astral_motes
    // Params 0, eflags: 0x4
    // Checksum 0xb7b3ce42, Offset: 0x2650
    // Size: 0x70, Type: dev
    function private function_6ba81296e00f0414()
    {
        devgui::function_9082edeb5db93280( "<dev string:x56>" );
        devgui::add_devgui_func( "<dev string:x6e>", "<dev string:x85>", &function_48174472e20b337e );
        devgui::add_devgui_func( "<dev string:x9b>", "<dev string:xb0>", &function_40052c3246f002bf );
        devgui::add_devgui_func( "<dev string:xca>", "<dev string:xde>", &function_f33f91450600ac0e );
        devgui::add_devgui_func( "<dev string:xf1>", "<dev string:x103>", &function_7b835d69bd6ad922 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace astral_motes
    // Params 0, eflags: 0x4
    // Checksum 0xbac767fc, Offset: 0x26c8
    // Size: 0x6e, Type: dev
    function private function_f33f91450600ac0e()
    {
        s_spawn = spawnstruct();
        s_spawn.origin = level.players[ 0 ].origin + ( 0, 0, 48 );
        s_spawn.var_b6a2148450c57614 = level.players[ 0 ].angles;
        function_9ff53054c89e44ed( s_spawn );
    }

    // Namespace astral_motes
    // Params 0, eflags: 0x4
    // Checksum 0x10162566, Offset: 0x273e
    // Size: 0x88, Type: dev
    function private function_48174472e20b337e()
    {
        foreach ( s_spawn in level.var_15313fda32ee3aa3.var_6a02f400b41d36dc )
        {
            function_9ff53054c89e44ed( s_spawn );
        }
    }

    // Namespace astral_motes
    // Params 0, eflags: 0x4
    // Checksum 0x8aaeaf31, Offset: 0x27ce
    // Size: 0x4c, Type: dev
    function private function_40052c3246f002bf()
    {
        random_spawn = level.var_15313fda32ee3aa3.var_cda555f949bd894f[ 0 ];
        mote = function_9ff53054c89e44ed( random_spawn );
        mote function_a77af03d7d28b3e1( level.players[ 0 ] );
    }

    // Namespace astral_motes
    // Params 0, eflags: 0x4
    // Checksum 0x1cb54efc, Offset: 0x2822
    // Size: 0x5, Type: dev
    function private function_ba153e2a8f7206f2()
    {
        
    }

    // Namespace astral_motes
    // Params 0, eflags: 0x4
    // Checksum 0xa5744fdf, Offset: 0x282f
    // Size: 0x95, Type: dev
    function private function_7b835d69bd6ad922()
    {
        /#
            iprintlnbold( "<dev string:x11b>" );
        #/
        
        foreach ( mote in level.var_15313fda32ee3aa3.var_c9b8f22d382189d6 )
        {
            delete_mote( mote );
        }
    }

#/
