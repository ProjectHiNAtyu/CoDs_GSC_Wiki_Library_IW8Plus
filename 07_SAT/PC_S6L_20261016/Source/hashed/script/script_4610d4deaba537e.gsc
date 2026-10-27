// script_4610d4deaba537e  (hash_04610d4deaba537e.gscc) (size: 16021 Bytes / 0x3e95 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc9d21abe (3385989822)
// size ...... 16021 (0x3e95)
// includes .. 15  (offset: 0x3a95)
// strings ... 42  (offset: 0x3b0d)
// dev strs .. 4   (offset: 0x3da9)
// exports ... 36  (offset: 0x2799)
// cseg ...... 0x4de + 0x22bb (0x2799)
// imports ... 114 (offset: 0x2d39)
// animtree1 . 1   (offset: 0x3ddd)
// animtree2 . 10  (offset: 0x3df5)
#using script_31ee2a173f3499b7;
#using script_4ce55cfc81c444ad;
#using script_530d9da948e14e79;
#using script_54a05cbb2455bc6f;
#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\stats;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_save;
#using scripts\mp\zm\ztron\ztron_sound;
#using scripts\mp\zm\ztron\ztron_utility;

#namespace namespace_3d206415c2287a2b;

// Namespace namespace_3d206415c2287a2b
// Params 0, eflags: 0x5
// Checksum 0xdb73be6c, Offset: 0x4fc
// Size: 0x21
function private autoexec __init__system__()
{
    system::register( #"hash_21c60714b66585a8", #"ztron_item", undefined, &init );
}

// Namespace namespace_3d206415c2287a2b
// Params 0
// Checksum 0xa53e0c74, Offset: 0x525
// Size: 0x101
function init()
{
    ztron_item::function_5844a9c240f7dc8d( #"chicken", #"use", &usechicken );
    ztron_item::function_5844a9c240f7dc8d( #"chicken", #"postspawnitem", &function_6d67434c1c46df29 );
    ztron_item::function_5844a9c240f7dc8d( #"chicken", #"hash_3836c356bfe5bc30", &function_2c983537c15e53e7 );
    ztron_item::function_5844a9c240f7dc8d( #"big_chicken", #"postspawnitem", &function_30149567ccbf022f );
    ztron_item::function_5844a9c240f7dc8d( #"big_chicken", #"canautouse", &canautouse );
    ztron_item::function_5844a9c240f7dc8d( #"big_chicken", #"hash_3836c356bfe5bc30", &function_2c983537c15e53e7 );
    initanims();
    ztron_sound::function_4ac735395b173fe( "chicken_intro_OS", "evt_ztron_pickup_chicken_squawk" );
    ztron_sound::function_4ac735395b173fe( "chicken_death_OS", "evt_ztron_pickup_chicken_explode" );
    ztron_sound::function_4ac735395b173fe( "ztron_pickup_chicken_despawn", "evt_ztron_pickup_chicken_explode" );
    ztron_sound::function_4ac735395b173fe( "chicken_spinout", "evt_ztron_pickup_chicken_squawk_spinout" );
}

#using_animtree( "script_model" );

// Namespace namespace_3d206415c2287a2b
// Params 0
// Checksum 0x725d5205, Offset: 0x62e
// Size: 0x15c
function initanims()
{
    level.scr_animtree[ "chicken" ] = #animtree;
    level.scr_anim[ "chicken" ][ "idle1" ] = %ai_sat_zm_a_chicken_idle;
    level.scr_anim[ "chicken" ][ "idle2" ] = %ai_sat_zm_a_chicken_idle_a;
    level.scr_anim[ "chicken" ][ "idle3" ] = %ai_sat_zm_a_chicken_idle_peck;
    level.scr_anim[ "chicken" ][ "dance" ] = %ai_sat_zm_a_chicken_react_to_front_notrans;
    level.scr_anim[ "chicken" ][ "up_down" ] = %ai_sat_zm_a_chicken_react_up_down;
    level.scr_anim[ "chicken" ][ "move" ] = %ai_sat_zm_a_chicken_run;
    level.scr_animtree[ "big_chicken" ] = #animtree;
    level.scr_anim[ "big_chicken" ][ "idle1" ] = %ai_sat_zm_a_chicken_idle_big;
    level.scr_anim[ "big_chicken" ][ "idle2" ] = %ai_sat_zm_a_chicken_idle_a_big;
    level.scr_anim[ "big_chicken" ][ "idle3" ] = %ai_sat_zm_a_chicken_idle_peck_big;
    level.scr_anim[ "big_chicken" ][ "dance" ] = %ai_sat_zm_a_chicken_react_to_front_notrans_big;
}

// Namespace namespace_3d206415c2287a2b
// Params 2, eflags: 0x4
// Checksum 0xabee2eff, Offset: 0x792
// Size: 0x63
function private function_ced3baf8f447828a( owner, duration )
{
    duration = owner ztron_player_utility::function_10777122eee28fa8( duration );
    
    if ( owner ztron_fate::hasfate( 3 ) )
    {
        duration += 60;
    }
    
    if ( owner.ztron.var_2588c7465d7536b2 & 1 )
    {
        duration = int( duration * 1.25 );
    }
    
    return int( duration );
}

// Namespace namespace_3d206415c2287a2b
// Params 1, eflags: 0x4
// Checksum 0x5befb6c5, Offset: 0x7fe
// Size: 0x5e
function private usechicken( params )
{
    player = params.player;
    itemdata = ztron_item::function_998f2b10462afbf4( params.bundle );
    chicken = player addchicken( 0, itemdata.duration );
    return chicken;
}

// Namespace namespace_3d206415c2287a2b
// Params 2, eflags: 0x4
// Checksum 0xfa8b0b46, Offset: 0x865
// Size: 0x35
function private function_6d67434c1c46df29( item, params )
{
    item thread chickenanimation();
    ztron_sound::ztron_playsound( "chicken_intro_OS", item.origin );
}

// Namespace namespace_3d206415c2287a2b
// Params 1, eflags: 0x4
// Checksum 0x5b8c117d, Offset: 0x8a2
// Size: 0x1b
function private function_2c983537c15e53e7( params )
{
    params.modelspinning = 0;
    return params;
}

// Namespace namespace_3d206415c2287a2b
// Params 1
// Checksum 0x62937c3b, Offset: 0x8c6
// Size: 0xd3
function function_2af6c4919b45de97( killspecial = 0 )
{
    foreach ( chicken in self.ztron.var_1a211bbcccca1c46 )
    {
        if ( !isdefined( chicken ) )
        {
            continue;
        }
        
        if ( chicken.special && !killspecial )
        {
            continue;
        }
        
        if ( chicken.expireondeath == 0 && !killspecial )
        {
            continue;
        }
        
        chicken chickenkill();
    }
}

// Namespace namespace_3d206415c2287a2b
// Params 0, eflags: 0xc
// Checksum 0xfd904e22, Offset: 0x9a1
// Size: 0x97
function private function_3d6efafc07468d96()
{
    self notify( #"hash_15ff69352b999983" );
    self endon( #"hash_15ff69352b999983" );
    msg = utility::waittill_any_return( "death", "disconnect", "laststand" );
    killspecial = 0;
    
    if ( msg == "laststand" && self.ztron.var_8487be91b45f17c5 )
    {
        thread function_3d6efafc07468d96();
        return;
    }
    else if ( msg == "death" || msg == "disconnect" )
    {
        killspecial = 1;
    }
    
    function_2af6c4919b45de97( killspecial );
}

// Namespace namespace_3d206415c2287a2b
// Params 0, eflags: 0x4
// Checksum 0x6a145454, Offset: 0xa40
// Size: 0xf, Type: bool
function private function_ece805392fec369d()
{
    return self.lifetime ?? 0;
}

// Namespace namespace_3d206415c2287a2b
// Params 6
// Checksum 0x3a639f5c, Offset: 0xa58
// Size: 0x335
function addchicken( fated, time = 30, expireondeath = 1, var_b7f5e49ecc16e85 = 0, storebought = 0, var_4f41655560136ded = 0 )
{
    profilestart();
    
    if ( !isdefined( self.ztron.var_1a211bbcccca1c46 ) )
    {
        self.ztron.var_1a211bbcccca1c46 = [];
    }
    
    thread function_3d6efafc07468d96();
    model = fated ? "ztron_fated_chicken" : "ztron_chicken";
    chicken = utility::spawn_model( model, self.origin + ( 0, 0, 30 ), self.angles );
    
    if ( !isdefined( chicken ) )
    {
        profilestop();
        return;
    }
    
    chicken.expireondeath = expireondeath;
    chicken notsolid();
    chicken enablelinkto();
    chicken forcenetfieldhighlod( 1 );
    chicken setmoverantilagged( 1 );
    chicken markkeyframedmover();
    orb = utility::spawn_model( "tag_origin", self.origin + ( 0, 0, 30 ), self.angles );
    
    if ( !isdefined( orb ) )
    {
        chicken delete();
        profilestop();
        return;
    }
    
    orb notsolid();
    chicken linkto( orb );
    chicken.orb = orb;
    chicken.owner = self;
    chicken.ischicken = 1;
    chicken.killcount = 0;
    chicken.team = self.team;
    chicken.special = fated;
    chicken.weapon = function_1699e3c5c5730d82( self );
    chicken thread chickenanimation();
    
    if ( !chicken.special )
    {
        chicken thread function_f5df1bf6b9db4f49( self );
    }
    
    if ( !var_4f41655560136ded )
    {
        time = function_ced3baf8f447828a( self, time );
    }
    
    if ( storebought )
    {
        save = spawnstruct();
        save.ref = "ztron_store_chicken_5min";
        save.entity = chicken;
        save.var_c93abd0f18db7640 = &function_ece805392fec369d;
        thread ztron_save::function_70c11aca4f83fcda( save );
    }
    
    chicken thread function_27674391a60e5bc( self, time );
    chicken thread function_7e29896a37779d4f( self );
    chicken thread function_20746f1a073a5c00();
    chicken thread function_d5d1529f241960bb();
    chicken thread function_f47ace3260211293();
    
    if ( var_b7f5e49ecc16e85 )
    {
        chicken thread function_997935e5c9771d1f();
    }
    
    if ( fated )
    {
        chicken thread function_d5962942419dae8f();
    }
    
    function_788ac8f58867dd47( chicken );
    chicken thread function_106754af6e624ec0( self );
    
    if ( !isdefined( self.ztron.var_fefb4fe9ce470900 ) )
    {
        self.ztron.var_fefb4fe9ce470900 = 0;
    }
    
    self.ztron.var_fefb4fe9ce470900 += 1;
    stats::setextrascore3( self.ztron.var_fefb4fe9ce470900 );
    profilestop();
    return chicken;
}

// Namespace namespace_3d206415c2287a2b
// Params 0
// Checksum 0x72dc59cd, Offset: 0xd97
// Size: 0xb6
function function_997935e5c9771d1f()
{
    self endon( #"death" );
    
    if ( !isdefined( self.lifetime ) )
    {
        return;
    }
    
    self.var_63c94fe1b2260b34 = 1;
    self.var_818c06f9a89fb0ba = 4;
    self.var_36dfdbd7ab796f0f = 5;
    self.using_fake_health = 1;
    self.var_cce7c67ea2da8902 = self.lifetime;
    self.var_d165d33ad4f00e17 = self.var_cce7c67ea2da8902;
    
    while ( self.var_cce7c67ea2da8902 >= 0 && !self.spinningout )
    {
        wait 1;
        self.var_cce7c67ea2da8902 = self.lifetime;
    }
    
    self.forceclearhealthbar = 1;
    self.var_63c94fe1b2260b34 = 0;
}

// Namespace namespace_3d206415c2287a2b
// Params 0
// Checksum 0x90c73435, Offset: 0xe55
// Size: 0x4a
function chickenkill()
{
    if ( self.special )
    {
        owner = self.owner;
        self delete();
        
        if ( isplayer( owner ) )
        {
            owner function_45920a7a5797b159();
        }
        
        return;
    }
    
    self notify( #"spin_out" );
}

// Namespace namespace_3d206415c2287a2b
// Params 1
// Checksum 0x37026c79, Offset: 0xea7
// Size: 0x144
function function_45920a7a5797b159( reset = 1 )
{
    if ( !isdefined( self.ztron.var_1a211bbcccca1c46 ) )
    {
        return;
    }
    
    self.ztron.var_1a211bbcccca1c46 = function_5713d46873b29625( self.ztron.var_1a211bbcccca1c46 );
    self.var_59393117e387a377 = reset;
    nextleader = self;
    stackindex = 0;
    
    foreach ( chicken in self.ztron.var_1a211bbcccca1c46 )
    {
        if ( chicken.spinningout )
        {
            continue;
        }
        
        nextleader.mychicken = chicken;
        chicken.myleader = nextleader;
        chicken.stackindex = stackindex;
        chicken.var_59393117e387a377 = reset;
        nextleader = chicken;
        stackindex++;
    }
}

// Namespace namespace_3d206415c2287a2b
// Params 0, eflags: 0xc
// Checksum 0xaaa9d06, Offset: 0xff3
// Size: 0x147
function private chickenanimation()
{
    self notify( #"hash_87b1ef8f2d5eabba" );
    self endon( #"hash_87b1ef8f2d5eabba" );
    self endon( #"death" );
    self useanimtree( #animtree );
    self.animname = "chicken";
    curanim = "idle1";
    
    while ( isdefined( self ) )
    {
        if ( self.spinningout || self.var_872d8089fdf42151 )
        {
            curanim = "up_down";
        }
        else if ( self.ismoving )
        {
            curanim = "move";
        }
        
        if ( isdefined( self.orb ) )
        {
            self.angles = self.orb.angles;
        }
        
        thread animation::anim_single_solo( self, curanim );
        waittime = getanimlength( level.scr_anim[ "chicken" ][ curanim ] );
        utility::waittill_any_timeout( waittime, "anim_interrupt", "spinning_out" );
        self stopanimscripted();
        
        switch ( randomint( 3 ) )
        {
            case 0:
                curanim = "idle1";
                break;
            case 1:
                curanim = "idle2";
                break;
            case 2:
                curanim = "idle3";
                break;
        }
    }
}

// Namespace namespace_3d206415c2287a2b
// Params 1
// Checksum 0xd386dbe6, Offset: 0x1142
// Size: 0x155
function function_42b365e741b732ea( maxchickens = 5 )
{
    self notify( #"hash_806c55fb8379008e" );
    self endon( #"hash_806c55fb8379008e" );
    self.ztron.var_1a211bbcccca1c46 = function_5713d46873b29625( self.ztron.var_1a211bbcccca1c46 );
    
    do
    {
        flocksize = self.ztron.var_1a211bbcccca1c46.size;
        tokill = flocksize - maxchickens;
        
        if ( tokill > 0 )
        {
            foreach ( chicken in self.ztron.var_1a211bbcccca1c46 )
            {
                if ( chicken.special )
                {
                    continue;
                }
                
                if ( chicken.spinningout )
                {
                    assertmsg( "<dev string:x24>" );
                    tokill--;
                    continue;
                }
                
                chicken chickenkill();
                tokill--;
                break;
            }
            
            function_45920a7a5797b159();
            waitframe();
        }
    }
    while ( tokill > 0 );
}

// Namespace namespace_3d206415c2287a2b
// Params 1, eflags: 0x4
// Checksum 0x1c6f9c59, Offset: 0x129f
// Size: 0x117
function private function_788ac8f58867dd47( chicken )
{
    self.ztron.var_1a211bbcccca1c46 = function_5713d46873b29625( self.ztron.var_1a211bbcccca1c46 );
    
    if ( chicken.special && self.ztron.var_1a211bbcccca1c46.size > 0 )
    {
        arrayinsert( self.ztron.var_1a211bbcccca1c46, chicken, 0 );
    }
    else
    {
        self.ztron.var_1a211bbcccca1c46[ self.ztron.var_1a211bbcccca1c46.size ] = chicken;
    }
    
    function_45920a7a5797b159();
    
    if ( self.ztron.var_1a211bbcccca1c46.size == 5 )
    {
        callback::callback( #"hash_6c71d319dc089c27", { #player:self, #event:#"sat_doa_fowlfivepiece" } );
    }
    
    if ( self.ztron.var_1a211bbcccca1c46.size > 5 )
    {
        thread function_42b365e741b732ea();
    }
}

// Namespace namespace_3d206415c2287a2b
// Params 1, eflags: 0xc
// Checksum 0xe1c2e3a5, Offset: 0x13be
// Size: 0x287
function private function_f5df1bf6b9db4f49( player )
{
    self notify( #"hash_8249f5efc9b0c622" );
    self endon( #"hash_8249f5efc9b0c622" );
    self endon( #"death" );
    self waittill( #"spin_out" );
    assert( !self.special, "<dev string:x5f>" );
    ztron_debug::debugmsg( "Chicken spinning out" );
    self.spinningout = 1;
    self notify( #"spinning_out" );
    self.spinouttime = 0;
    self.myleader = undefined;
    
    if ( isdefined( player ) )
    {
        self.orb.origin = ( self.orb.origin[ 0 ], self.orb.origin[ 1 ], player.origin[ 2 ] + 12 );
        player.ztron.var_1a211bbcccca1c46[ self.stackindex ] = undefined;
        
        if ( isint( self.stackindex ) )
        {
            function_cdc669dbc8ea2101( player.ztron.var_1a211bbcccca1c46 );
        }
        
        player function_45920a7a5797b159();
        ztron_debug::debugmsg( "\t chicken owned by player: " + player.ztron.color );
        weapon = function_1699e3c5c5730d82( player );
        
        if ( isnullweapon( weapon ) )
        {
            weapon = self.weapon;
        }
        
        assert( !isnullweapon( weapon ), "<dev string:x8b>" );
        self.spinouttime = randomfloatrange( 5, 8 );
        self.orb rotatevelocity( ( 0, 180, 0 ), self.spinouttime );
        
        while ( self.spinouttime > 0 )
        {
            extrawait = weaponfire( player, weapon );
            interval = 0.15 + extrawait;
            ztron_sound::ztron_playsound( "chicken_spinout", self.origin, self );
            wait interval;
            self.spinouttime -= interval;
        }
    }
    
    playfx( utility::getfx( "chicken_explode" ), self.origin );
    ztron_sound::ztron_stopsound( self );
    ztron_sound::ztron_playsound( "chicken_death_OS", self.origin );
    
    if ( isdefined( self.orb ) )
    {
        self.orb delete();
    }
    
    if ( isdefined( self ) )
    {
        self delete();
    }
}

// Namespace namespace_3d206415c2287a2b
// Params 1, eflags: 0x4
// Checksum 0xb477cd13, Offset: 0x164d
// Size: 0x191
function private function_1699e3c5c5730d82( player )
{
    var_e3e3991216952c = player.ztron.var_e3e3991216952c;
    
    if ( level.ztron.blitzmode )
    {
        if ( player.ztron.var_2588c7465d7536b2 & 274877906944 )
        {
            var_e3e3991216952c = 2;
        }
        else if ( player.ztron.var_2588c7465d7536b2 & 137438953472 )
        {
            var_e3e3991216952c = max( 1, var_e3e3991216952c );
        }
    }
    
    if ( self.special )
    {
        if ( self.owner ztron_fate::function_c93d5c389d532c34( 3, 2 ) )
        {
            var_e3e3991216952c = 2;
        }
        else if ( self.owner ztron_fate::function_c93d5c389d532c34( 3, 1 ) )
        {
            var_e3e3991216952c = max( 1, var_e3e3991216952c );
        }
        
        if ( player.ztron.var_1e1a895196cdfff7.var_860deaeca058d557 )
        {
            return player.ztron.var_1e1a895196cdfff7.var_860deaeca058d557[ var_e3e3991216952c ];
        }
    }
    
    if ( player.ztron.var_1e1a895196cdfff7.chickenweapon )
    {
        return player.ztron.var_1e1a895196cdfff7.chickenweapon[ var_e3e3991216952c ];
    }
    
    return player.ztron.var_1e1a895196cdfff7.weaponobj[ var_e3e3991216952c ];
}

// Namespace namespace_3d206415c2287a2b
// Params 2, eflags: 0x4
// Checksum 0xd953d05, Offset: 0x17e6
// Size: 0x298
function private weaponfire( player, weapon )
{
    if ( self.var_872d8089fdf42151 )
    {
        return 0;
    }
    
    extrawait = 0;
    angles = ( self.angles[ 0 ], self.angles[ 1 ], 0 );
    
    if ( isdefined( player ) )
    {
        if ( player.ztron.var_a4c2f70bbc713f98 )
        {
            viewangles = player getplayerangles();
            angles = ( viewangles[ 0 ], self.angles[ 1 ], 0 );
        }
    }
    
    forward = anglestoforward( angles );
    offset = forward * 12 + ( 0, 0, 20 );
    start = self.origin + offset;
    end = start + forward * 256;
    assert( !isnullweapon( weapon ), "<dev string:x8b>" );
    
    if ( player.ztron.var_1e1a895196cdfff7.var_b154c382310b3535 )
    {
        stacksize = 1;
        
        if ( isdefined( player ) )
        {
            stacksize = player.ztron.var_1a211bbcccca1c46.size;
        }
        
        if ( stacksize > player.ztron.var_1e1a895196cdfff7.var_b154c382310b3535 && self.stackindex >= player.ztron.var_1e1a895196cdfff7.var_b154c382310b3535 )
        {
            if ( self.special )
            {
                weapon = player.ztron.var_1e1a895196cdfff7.var_c2e4b5f9b21824c4[ player.ztron.var_e3e3991216952c ];
            }
            else
            {
                weapon = player.ztron.var_1e1a895196cdfff7.var_68dc3f96a6b65d1c[ player.ztron.var_e3e3991216952c ];
            }
            
            assert( isdefined( weapon ), "<dev string:xa1>" );
        }
    }
    
    scriptmodelsetweapon( self, weapon );
    ztron_debug::debugmsg( "\t Chicken Weapon: " + weapon.basename + " start: " + start + " end: " + end );
    
    if ( isdefined( self.owner ) )
    {
        projectile = magicbullet( weapon, start, end, self.owner, self );
    }
    
    if ( isdefined( projectile ) )
    {
        projectile.chicken = self;
    }
    
    return extrawait;
}

// Namespace namespace_3d206415c2287a2b
// Params 2, eflags: 0xc
// Checksum 0x5fdcd431, Offset: 0x1a87
// Size: 0xaa
function private function_27674391a60e5bc( player, time )
{
    self notify( #"hash_deeffa69cedb13b3" );
    self endon( #"hash_deeffa69cedb13b3" );
    level endon( #"ztron_game_is_over" );
    self endon( #"spinning_out" );
    self endon( #"death" );
    
    if ( self.special )
    {
        return;
    }
    
    self.lifetime = time;
    
    while ( self.lifetime > 0 )
    {
        while ( !ztron_item::function_4b0636e7b2fc461f() )
        {
            waitframe();
            continue;
        }
        
        wait 1;
        self.lifetime -= 1;
    }
    
    chickenkill();
}

// Namespace namespace_3d206415c2287a2b
// Params 1, eflags: 0xc
// Checksum 0x1195153b, Offset: 0x1b39
// Size: 0xb2
function private function_7e29896a37779d4f( player )
{
    self notify( #"hash_68ef4c0ee8ce031c" );
    self endon( #"hash_68ef4c0ee8ce031c" );
    self endon( #"death" );
    self endon( #"spinning_out" );
    player endon( #"disconnect" );
    thread detectfireevent( player );
    
    while ( true )
    {
        self waittill( #"chicken_fire" );
        weapon = function_1699e3c5c5730d82( player );
        extrawait = weaponfire( player, weapon );
        extrawait += weapon.firetime - 0.05;
        
        if ( extrawait > 0 )
        {
            wait extrawait;
            continue;
        }
        
        waitframe();
    }
}

// Namespace namespace_3d206415c2287a2b
// Params 1, eflags: 0x4
// Checksum 0xe03c3b36, Offset: 0x1bf3
// Size: 0x15f
function private detectfireevent( player )
{
    player endon( #"disconnect" );
    self endon( #"death" );
    
    while ( isdefined( self ) && !self.spinningout )
    {
        if ( isdefined( player.ztron.vehicle ) )
        {
            msg = player.ztron.vehicle utility::waittill_any_timeout( 0.1, "weapon_fired", "missile_fire", "heli_bomb_dropped", "death" );
        }
        else
        {
            msg = player utility::waittill_any_timeout( 0.1, "weapon_fired" );
        }
        
        if ( isdefined( player.ztron.vehicle ) && player.ztron.vehicle.var_36c9b449d0f1069d && ( msg == "missile_fire" || msg == "heli_bomb_dropped" ) )
        {
            function_be9d7ce58e86fd9b( player );
            continue;
        }
        
        if ( msg == "weapon_fired" && player isshooting() )
        {
            var_8ca4f32f09590cd3 = level.ztron.var_8a9067aa4cd65369.name == "rail_shooter";
            
            if ( !var_8ca4f32f09590cd3 )
            {
                self notify( #"chicken_fire" );
            }
        }
    }
}

// Namespace namespace_3d206415c2287a2b
// Params 1, eflags: 0x4
// Checksum 0xa5a5577d, Offset: 0x1d5a
// Size: 0x70
function private function_be9d7ce58e86fd9b( player )
{
    currenttime = gettime();
    
    if ( !isdefined( self.var_aa725789043e7c4e ) || currenttime - self.var_aa725789043e7c4e > 2000 )
    {
        player namespace_394d9d635c80d34::function_22d75d7639272b3( player.ztron.vehicle, self.origin );
        self.var_aa725789043e7c4e = currenttime;
    }
}

// Namespace namespace_3d206415c2287a2b
// Params 0, eflags: 0x4
// Checksum 0x5f581d0e, Offset: 0x1dd2
// Size: 0x2
function private function_20746f1a073a5c00()
{
    
}

// Namespace namespace_3d206415c2287a2b
// Params 0, eflags: 0x4
// Checksum 0xa634d868, Offset: 0x1ddc
// Size: 0x22
function private function_d5d1529f241960bb()
{
    self endon( #"death" );
    wait 0.25;
    ztron_sound::ztron_playsound( "chicken_intro_OS", undefined, self );
}

// Namespace namespace_3d206415c2287a2b
// Params 1, eflags: 0xc
// Checksum 0x96d0d5ac, Offset: 0x1e06
// Size: 0x393
function private function_106754af6e624ec0( player )
{
    self notify( #"hash_f7d3d7ce66b68f3f" );
    self endon( #"hash_f7d3d7ce66b68f3f" );
    self endon( #"death", #"spinning_out" );
    player endon( #"disconnect" );
    self.myleader.var_59393117e387a377 = 1;
    force = 0;
    var_ac4454a7bf468d9f = 0;
    forcedist = squared( 72 );
    
    while ( isdefined( self.myleader ) )
    {
        if ( self.myleader.var_59393117e387a377 )
        {
            offset = isdefined( self.myleader.ztron.vehicle ) ? 100 : 25;
            self.followpoints = [];
            self.followpoints[ 0 ] = self.myleader.origin + anglestoforward( self.myleader.angles ) * offset * -1;
            self.myleader.var_59393117e387a377 = 0;
            thread function_58a2f9f80b4e7286( self.myleader );
            movetime = 0.2;
            self.orb moveto( self.followpoints[ 0 ], movetime );
            wait movetime;
        }
        
        if ( isplayer( self.myleader ) )
        {
            angles = self.myleader getplayerangles();
        }
        else
        {
            angles = self.myleader.angles;
        }
        
        self.orb.angles = ( angles[ 0 ], angles[ 1 ], 0 );
        
        if ( self.var_872d8089fdf42151 )
        {
            waitframe();
            continue;
        }
        
        movetime = 0.04;
        moving = 0;
        var_6e7c34d37edf1d3b = 0;
        pointnum = isdefined( self.myleader.ztron.vehicle ) ? 10 : 5;
        
        if ( distancesquared( self.origin, self.myleader.origin ) > forcedist && self.followpoints.size > 0 )
        {
            var_6e7c34d37edf1d3b = 1;
            moving = 1;
        }
        else if ( self.followpoints.size > pointnum || self.normmove > 0 )
        {
            movetime = function_638d781c402d38e2();
            moving = 1;
        }
        
        if ( self.ismoving != moving )
        {
            self notify( #"anim_interrupt" );
        }
        
        self.ismoving = moving;
        point = self.followpoints[ 0 ];
        
        if ( self.ismoving && isdefined( point ) )
        {
            self.followpoints = arrayremove( self.followpoints, point );
            
            if ( var_6e7c34d37edf1d3b && self.followpoints.size == 0 )
            {
                offset = isdefined( self.myleader.ztron.vehicle ) ? 100 : 25;
                point = vectornormalize( self.origin - self.myleader.origin ) * offset + self.myleader.origin;
            }
            
            self.orb moveto( point, movetime );
            wait movetime;
            continue;
        }
        
        waitframe();
    }
}

// Namespace namespace_3d206415c2287a2b
// Params 0, eflags: 0x4
// Checksum 0x9523dcb0, Offset: 0x21a1
// Size: 0xdf
function private function_638d781c402d38e2()
{
    movetime = 0.04;
    movetimechanged = 0;
    
    if ( isplayer( self.myleader ) )
    {
        self.normmove = length2d( self.myleader getnormalizedmovement() );
        movetimechanged = 1;
    }
    else if ( isdefined( self.myleader.normmove ) )
    {
        self.normmove = self.myleader.normmove;
        movetimechanged = 1;
    }
    
    if ( movetimechanged )
    {
        behind = self.followpoints.size - 5;
        magnitude = clamp( self.normmove + behind * 0.2, 0, 1 );
        movetime = mapfloat( 0, 1, 0.04, 0.2, 1 - magnitude );
    }
    
    return movetime;
}

// Namespace namespace_3d206415c2287a2b
// Params 1, eflags: 0xc
// Checksum 0xb8deac3e, Offset: 0x2289
// Size: 0x132
function private function_58a2f9f80b4e7286( leader )
{
    self notify( #"hash_255da96ad0d29b0a" );
    self endon( #"hash_255da96ad0d29b0a" );
    self endon( #"death" );
    self endon( #"spinning_out" );
    var_e8d6037ed42403b6 = isplayer( leader );
    
    if ( var_e8d6037ed42403b6 )
    {
        leader endon( #"disconnect" );
    }
    else
    {
        leader endon( #"death" );
        leader endon( #"spinning_out" );
    }
    
    waitframe();
    followpoint = self.origin;
    
    while ( isdefined( leader ) )
    {
        if ( self.followpoints.size <= 10 && distance2dsquared( leader.origin, followpoint ) > squared( 3 ) && !leader.inlaststand )
        {
            followpoint = leader.origin;
            
            if ( var_e8d6037ed42403b6 )
            {
                zoffset = leader.ztron.var_a4c2f70bbc713f98 ? 10 : 30;
                followpoint += ( 0, 0, zoffset );
            }
            
            self.followpoints[ self.followpoints.size ] = followpoint;
        }
        
        waitframe();
    }
}

// Namespace namespace_3d206415c2287a2b
// Params 0, eflags: 0xc
// Checksum 0x1f07091, Offset: 0x23c3
// Size: 0x3f
function private function_f47ace3260211293()
{
    self notify( #"hash_5d63a9815f3eb514" );
    self endon( #"hash_5d63a9815f3eb514" );
    self endon( #"death" );
    level utility::waittill_any( "ztron_game_is_over", "clear_active_item" );
    chickenkill();
}

// Namespace namespace_3d206415c2287a2b
// Params 0, eflags: 0xc
// Checksum 0xadfef2d7, Offset: 0x240a
// Size: 0x21a
function private function_d5962942419dae8f()
{
    self notify( #"hash_f93055d837a68fc1" );
    self endon( #"hash_f93055d837a68fc1" );
    self endon( #"death", #"spinning_out" );
    
    while ( true )
    {
        var_d58fdb2e9a90197c = randomintrange( 720, 1800 );
        
        if ( self.owner ztron_fate::function_c93d5c389d532c34( 3, 3 ) )
        {
            var_d58fdb2e9a90197c = randomintrange( 600, 1800 );
        }
        
        /#
        #/
        
        while ( var_d58fdb2e9a90197c > 0 )
        {
            while ( level.ztron.var_291105dfc6b5a9b8 != 1 || level utility::flag( "ztron_round_paused" ) || !level utility::flag( "ztron_round_spawning" ) || level.hostmigrationtimer )
            {
                waitframe();
            }
            
            wait 1;
            var_d58fdb2e9a90197c--;
        }
        
        self.var_872d8089fdf42151 = 1;
        wait 5;
        roll = randomint( 100 );
        wait 0.6;
        
        if ( self.owner ztron_fate::function_c93d5c389d532c34( 3, 3 ) )
        {
            roll -= 15;
        }
        
        if ( roll < 15 )
        {
            spawnitem = "ztron_golden_egg";
        }
        else
        {
            spawnitem = "ztron_egg";
        }
        
        bundlename = ztron_item::function_71e133b37011bee6( spawnitem );
        offset = ( 0, 0, self.owner.ztron.var_a4c2f70bbc713f98 ? 10 : 30 );
        spot = ztron_util::function_3fe38741460a4a49( self.origin, 80 ) + offset;
        ztron_item::requestspawnitem( bundlename, self.origin );
        self unlink();
        self.var_872d8089fdf42151 = undefined;
        self.orb.origin = spot;
        self linkto( self.orb );
        self.origin = self.orb.origin;
        self stopanimscripted();
        self notify( #"anim_interrupt" );
        self.owner function_45920a7a5797b159( 1 );
    }
}

// Namespace namespace_3d206415c2287a2b
// Params 2, eflags: 0x4
// Checksum 0x56f4abc8, Offset: 0x262c
// Size: 0x4a
function private function_30149567ccbf022f( item, params )
{
    item thread function_5e712e2808c3c9c3();
    item thread function_64d909ced69f1577();
    ztron_ui::function_37aad40e39a9fdfe( "fidolina_saved" );
    ztron_sound::ztron_playsound( "chicken_intro_OS", item.origin );
}

// Namespace namespace_3d206415c2287a2b
// Params 1, eflags: 0x4
// Checksum 0x9ffc94e4, Offset: 0x267e
// Size: 0xd, Type: bool
function private canautouse( params )
{
    return false;
}

// Namespace namespace_3d206415c2287a2b
// Params 0, eflags: 0xc
// Checksum 0xafb1cdc1, Offset: 0x2694
// Size: 0x6b
function private function_64d909ced69f1577()
{
    self notify( #"hash_a9d6eb37d3381dda" );
    self endon( #"hash_a9d6eb37d3381dda" );
    self endon( #"death" );
    wait 2;
    var_10df1186bf9265d9 = randomint( 3 ) + 1;
    ref = "ztron_big_chicken_0" + var_10df1186bf9265d9;
    xref = getxhash( ref );
    ztron_dialog::function_7e3f6329d9afcdc1( xref, 0, 0 );
}

// Namespace namespace_3d206415c2287a2b
// Params 0, eflags: 0xc
// Checksum 0xd9d061dd, Offset: 0x2707
// Size: 0x92
function private function_5e712e2808c3c9c3()
{
    self notify( #"hash_211d4796efba4f8" );
    self endon( #"hash_211d4796efba4f8" );
    self endon( #"death" );
    self useanimtree( #animtree );
    self.animname = "big_chicken";
    curanim = "dance";
    
    while ( isdefined( self ) )
    {
        thread animation::anim_single_solo( self, curanim );
        waittime = getanimlength( level.scr_anim[ "big_chicken" ][ curanim ] );
        utility::waittill_any_timeout( waittime, "anim_interrupt", "spinning_out" );
    }
}

