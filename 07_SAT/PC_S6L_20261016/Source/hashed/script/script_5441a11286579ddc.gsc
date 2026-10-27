// script_5441a11286579ddc  (hash_5441a11286579ddc.gscc) (size: 6935 Bytes / 0x1b17 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x47e433f7 (1206137847)
// size ...... 6935 (0x1b17)
// includes .. 13  (offset: 0x199f)
// strings ... 19  (offset: 0x1a07)
// dev strs .. 0   (offset: 0x1b17)
// exports ... 15  (offset: 0xfbb)
// cseg ...... 0x1a3 + 0xe18 (0xfbb)
// imports ... 65  (offset: 0x1213)
// animtree1 . 0   (offset: 0x1b17)
// animtree2 . 0   (offset: 0x1b17)
#using script_4ce55cfc81c444ad;
#using script_54a05cbb2455bc6f;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\zm\zm_utility;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_main;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_score;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace namespace_a6a7fe92789f4ad9;

// Namespace namespace_a6a7fe92789f4ad9
// Params 0, eflags: 0x5
// Checksum 0x2d67f365, Offset: 0x1c1
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_d3d5a8543c11b91c", #"ztron_item", undefined, &init );
}

// Namespace namespace_a6a7fe92789f4ad9
// Params 0
// Checksum 0xa45fe0e1, Offset: 0x1ea
// Size: 0xc0
function init()
{
    ztron_item::function_5844a9c240f7dc8d( #"nuke", #"use", &usenuke );
    ztron_item::function_5844a9c240f7dc8d( #"nuke", #"canautouse", &function_7d25c181433c3617 );
    ztron_item::function_5844a9c240f7dc8d( #"nuke", #"hash_3836c356bfe5bc30", &function_2c983537c15e53e7 );
    ztron_item::function_5844a9c240f7dc8d( #"nuke", #"hash_87300e1dbd3aa856", &function_7d25c181433c3617 );
    utility::add_fx( "ztron_nuke", "vfx_sat_zm_nuke_exp_ztron" );
    ztron_sound::function_4ac735395b173fe( "nuke_explo_OS", "evt_ztron_nuke" );
    ztron_sound::function_4ac735395b173fe( "nuke_drop_lp", "evt_ztron_nuke_drop_loop", 1 );
    ztron_sound::function_4ac735395b173fe( "nuke_ai_sizzle_OS", "evt_ztron_nuke_souls" );
}

// Namespace namespace_a6a7fe92789f4ad9
// Params 1, eflags: 0x4
// Checksum 0x9ac4dda7, Offset: 0x2b2
// Size: 0x8f
function private usenuke( params )
{
    item = params.scriptable;
    
    if ( item.inuse )
    {
        return;
    }
    
    level notify( #"item_picked_up", { #player:params.player, #item:params.scriptable } );
    owner = params.player;
    owner function_bdbdec0a0a38b3a6();
    item ztron_item::function_f580915d21ddba69( owner );
}

// Namespace namespace_a6a7fe92789f4ad9
// Params 1, eflags: 0x4
// Checksum 0x9af4161f, Offset: 0x349
// Size: 0x19, Type: bool
function private function_7d25c181433c3617( params )
{
    return function_d99937c243f5f1d6() < ztron_score::function_b986c55261cc358e();
}

// Namespace namespace_a6a7fe92789f4ad9
// Params 1, eflags: 0x4
// Checksum 0x62f59f2e, Offset: 0x36b
// Size: 0x1c
function private function_2c983537c15e53e7( params )
{
    params.cleanupdisabled = 1;
    return params;
}

// Namespace namespace_a6a7fe92789f4ad9
// Params 4
// Checksum 0x71bfb3b1, Offset: 0x390
// Size: 0x2ee
function deploynuke( var_7e4940959b2b53a0, var_201a7cd42d74f48b = 1, blastradius, verticalcheck )
{
    if ( var_201a7cd42d74f48b )
    {
        nuke = utility::spawn_model( "sat_zm_ztron_power_up_nuke", var_7e4940959b2b53a0 + ( 0, 0, 2000 ) );
        
        if ( isdefined( nuke ) )
        {
            nuke.angles = ( 90, 0, 0 );
            ztron_sound::ztron_playsound( "nuke_drop_lp", undefined, nuke );
            nuke moveto( var_7e4940959b2b53a0, 0.25 );
            nuke waittill( #"movedone" );
            ztron_sound::ztron_stopsound( nuke );
        }
    }
    
    level notify( #"nuke_detonation", { #origin:var_7e4940959b2b53a0 } );
    self notify( #"nuke_dropped" );
    bullshit = var_7e4940959b2b53a0 + ( 0, 0, 92 );
    playfx( utility::getfx( "ztron_nuke" ), bullshit );
    ztron_sound::ztron_playsound( "nuke_explo_OS", var_7e4940959b2b53a0 );
    waitframe();
    
    if ( isdefined( nuke ) )
    {
        nuke delete();
    }
    
    var_26f130d59db084d7 = ztron_main::function_4da200e9b8d58a3c();
    
    if ( var_26f130d59db084d7 == 1 )
    {
        allai = level.ztron.zombies;
    }
    else if ( !isdefined( blastradius ) )
    {
        if ( var_26f130d59db084d7 == 5 )
        {
            blastradius = 1024;
        }
        else if ( var_26f130d59db084d7 == 3 )
        {
            blastradius = 768;
            verticalcheck = 512;
        }
        else
        {
            blastradius = 0;
        }
        
        if ( isdefined( verticalcheck ) )
        {
            potentials = getaiarrayinradius( var_7e4940959b2b53a0, blastradius, zm_utility::get_zombie_team() );
            allai = [];
            
            foreach ( guy in potentials )
            {
                if ( abs( guy.origin[ 2 ] - var_7e4940959b2b53a0[ 2 ] ) > verticalcheck )
                {
                    continue;
                }
                
                allai[ allai.size ] = guy;
            }
        }
        else
        {
            allai = getaiarrayinradius( var_7e4940959b2b53a0, blastradius, zm_utility::get_zombie_team() );
        }
    }
    
    var_3a064c93ea768c54 = [];
    
    foreach ( ai in allai )
    {
        if ( arraycontains( var_3a064c93ea768c54, ai ) )
        {
            continue;
        }
        
        if ( ai.ztron.boss )
        {
            continue;
        }
        
        var_3a064c93ea768c54[ var_3a064c93ea768c54.size ] = ai;
    }
    
    function_6c5906115e825d8f( var_7e4940959b2b53a0, var_3a064c93ea768c54, 1 );
}

// Namespace namespace_a6a7fe92789f4ad9
// Params 1
// Checksum 0x6f631b6f, Offset: 0x686
// Size: 0x1d2
function function_35260497c4cb7b2c( useinventory = 1 )
{
    if ( useinventory && function_d99937c243f5f1d6() <= 0 )
    {
        return;
    }
    
    if ( useinventory )
    {
        function_fdb7287a9e4c2082();
        self playrumbleonentity( "damage_heavy" );
        
        if ( isdefined( self.ztron.var_bfa83a4b1e005de8 ) )
        {
            if ( gettime() < self.ztron.var_bfa83a4b1e005de8 && self.ztron.var_f235f713dade67e7 < self.ztron.var_93a0de915a326de5 )
            {
                ztron_player_utility::function_8e1155bcebb3b7b3( self.ztron.var_2d5d4cafb7f0ffb9 );
                self.ztron.var_f235f713dade67e7++;
            }
            else
            {
                self.ztron.var_bfa83a4b1e005de8 = undefined;
                self.ztron.var_f235f713dade67e7 = undefined;
                self.ztron.var_2d5d4cafb7f0ffb9 = undefined;
            }
        }
        
        if ( isdefined( self.ztron.var_3672c53f92a18974 ) )
        {
            if ( gettime() < self.ztron.var_3672c53f92a18974 )
            {
                ztron_item::function_d2dd7af394ebdbdd( "ztron_extra_life" );
            }
            else
            {
                self.ztron.var_3672c53f92a18974 = undefined;
            }
        }
        
        if ( ztron_fate::function_c93d5c389d532c34( 2, 5 ) )
        {
            params = spawnstruct();
            params.launchforce = ( randomintrange( -10, 10 ), randomintrange( -10, 10 ), 400 );
            ztron_item::function_d0a061baefd87906( self.origin + ( 0, 0, 100 ), 1, 20, undefined, params );
        }
    }
    
    thread ztron_player_utility::turnPlayerShieldOn();
    thread deploynuke( self.origin );
}

// Namespace namespace_a6a7fe92789f4ad9
// Params 4
// Checksum 0x6aec28f8, Offset: 0x860
// Size: 0x418
function function_6c5906115e825d8f( v_location, var_590aef121c9fb611, b_kill_all, var_52807817b8067816 = 128 )
{
    foreach ( ai in var_590aef121c9fb611 )
    {
        if ( isalive( ai ) && !ai.var_7ee152b43c7188e1 && !ai.ignore_nuke_fx )
        {
            ai utility::callsharedfunc( #"zombie", #"stunZombie", 10 );
        }
    }
    
    current_a_ais = function_46f9072493651dc9( var_590aef121c9fb611 );
    current_a_ais = utility::get_array_of_closest( v_location, current_a_ais );
    a_ais_nuked = [];
    var_2ceadd8792a5e20a = var_52807817b8067816 * var_52807817b8067816;
    
    foreach ( ai in current_a_ais )
    {
        if ( !isalive( ai ) )
        {
            continue;
        }
        
        var_3cd2eba2b7ff6812 = 0;
        
        if ( ai.var_190f8e8daa83f8c || ai.magic_bullet_shield )
        {
            var_3cd2eba2b7ff6812 = 1;
        }
        
        if ( var_3cd2eba2b7ff6812 )
        {
            continue;
        }
        
        ai function_669ed7a96571422b( self );
        
        if ( !ai.nuked )
        {
            ai.nuked = 1;
            ai.no_powerups = 1;
            ai.var_a13bed1ac47e1b2c = 1;
            ai.full_gib = 1;
            ai.var_65522105f3bdca37 = randomint( 100 ) < 60 ? 1 : 0;
            a_ais_nuked[ a_ais_nuked.size ] = ai;
            
            if ( utility::issharedfuncdefined( #"zombie_utils", #"setmovespeed" ) )
            {
                ai utility::callsharedfunc( #"zombie_utils", #"setmovespeed", "walk", "nuke", 27 );
            }
        }
    }
    
    killcount = 5;
    var_705bde2c9c26f19a = isplayer( self );
    
    foreach ( var_b4993495b85b42ac in a_ais_nuked )
    {
        if ( !isalive( var_b4993495b85b42ac ) )
        {
            continue;
        }
        
        ztron_sound::ztron_playsound( "nuke_ai_sizzle_OS", var_b4993495b85b42ac.origin, undefined );
        
        if ( var_705bde2c9c26f19a )
        {
            thread ztron_player_utility::function_9dbd11353321b474( "nuke", var_b4993495b85b42ac.var_945ef487faad2413 );
        }
        
        health = var_b4993495b85b42ac.health;
        origin = var_b4993495b85b42ac.origin;
        var_b4993495b85b42ac namespace_b76ff2659823e89d::function_6c318bca7bb326e7( 1 );
        var_b4993495b85b42ac kill( var_b4993495b85b42ac.origin, self );
        ztron_util::function_eb8ba16055d6da7c( self, var_b4993495b85b42ac, undefined, undefined, undefined, health, origin, undefined, undefined, 1 );
        
        if ( issubstr( var_b4993495b85b42ac.subclass, "zombie_base" ) && !var_b4993495b85b42ac.var_65522105f3bdca37 )
        {
            var_24ed309d808c077a = var_b4993495b85b42ac getcorpseentity();
            
            if ( isdefined( var_24ed309d808c077a ) )
            {
                var_24ed309d808c077a thread function_fc12a24729ef4e67();
                v_dir = vectornormalize( var_24ed309d808c077a.origin - v_location + ( 0, 0, 600 ) );
                var_b4993495b85b42ac ztron_util::function_b9c77e54af91a636( v_dir, 10000, var_24ed309d808c077a );
            }
        }
        
        killcount--;
        
        if ( killcount <= 0 )
        {
            killcount = 5;
            waitframe();
        }
    }
}

// Namespace namespace_a6a7fe92789f4ad9
// Params 1, eflags: 0x4
// Checksum 0xa7453f8a, Offset: 0xc80
// Size: 0x54
function private function_669ed7a96571422b( attacker )
{
    utility::ent_flag( "burned" );
    params = spawnstruct();
    params.attacker = attacker;
    params.next_damage_time = gettime();
    callback::callback( "burned", params );
}

// Namespace namespace_a6a7fe92789f4ad9
// Params 0, eflags: 0x4
// Checksum 0x628068a8, Offset: 0xcdc
// Size: 0x81
function private function_fc12a24729ef4e67()
{
    level endon( #"ztron_game_is_over" );
    utility::function_32b24db3127bff40( "burned", "burned_on" );
    wait 3;
    var_80f3576404b5eba0 = 0;
    
    if ( isdefined( self ) )
    {
        var_80f3576404b5eba0 = utility::function_7c10ea82c1e305b8( "burned", "burned_dead" );
    }
    
    if ( var_80f3576404b5eba0 )
    {
        return;
    }
    
    if ( isdefined( self ) )
    {
        utility::function_7c10ea82c1e305b8( "burned", "burned_dead" );
    }
    
    wait 3;
    
    if ( isdefined( self ) )
    {
        utility::function_7c10ea82c1e305b8( "burned", "burned_off" );
    }
}

// Namespace namespace_a6a7fe92789f4ad9
// Params 0
// Checksum 0x9939b577, Offset: 0xd65
// Size: 0xb3
function function_bdbdec0a0a38b3a6()
{
    self.ztron.score.bombs = clampint( self.ztron.score.bombs + 1, 0, ztron_score::function_b986c55261cc358e() );
    params = { #count:self.ztron.score.bombs, #squadmemberindex:self.sessionuimemberindex };
    level callback::callback( #"hash_a170ada7569c82e5", params );
    ztron_dialog::function_927bb94feca983e8( getxhash( "ztron_happy" ) );
}

// Namespace namespace_a6a7fe92789f4ad9
// Params 0
// Checksum 0xc622a11c, Offset: 0xe20
// Size: 0xa3
function function_fdb7287a9e4c2082()
{
    self.ztron.score.bombs = clampint( self.ztron.score.bombs - 1, 0, ztron_score::function_b986c55261cc358e() );
    params = { #count:self.ztron.score.bombs, #squadmemberindex:self.sessionuimemberindex };
    level callback::callback( #"hash_a170ada7569c82e5", params );
}

// Namespace namespace_a6a7fe92789f4ad9
// Params 2
// Checksum 0xd7d5db42, Offset: 0xecb
// Size: 0xc8
function function_8cab6adef8e1bef2( nukecount, forced = 0 )
{
    if ( forced )
    {
        self.ztron.score.bombs = nukecount;
    }
    else
    {
        self.ztron.score.bombs = clampint( nukecount, 0, ztron_score::function_b986c55261cc358e() );
    }
    
    params = { #count:self.ztron.score.bombs, #squadmemberindex:self.sessionuimemberindex };
    level callback::callback( #"hash_a170ada7569c82e5", params );
}

// Namespace namespace_a6a7fe92789f4ad9
// Params 0
// Checksum 0x4308667, Offset: 0xf9b
// Size: 0x1f
function function_d99937c243f5f1d6()
{
    return self.ztron.score.bombs;
}

