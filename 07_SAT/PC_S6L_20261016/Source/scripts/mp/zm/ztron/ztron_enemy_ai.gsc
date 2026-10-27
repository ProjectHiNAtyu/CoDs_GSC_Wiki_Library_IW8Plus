// scripts\mp\zm\ztron\ztron_enemy_ai.gsc  (hash_451a85c4240fcc59.gscc) (size: 16597 Bytes / 0x40d5 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x44ba16f1 (1153046257)
// size ...... 16597 (0x40d5)
// includes .. 26  (offset: 0x3dd1)
// strings ... 27  (offset: 0x3ea1)
// dev strs .. 13  (offset: 0x4035)
// exports ... 41  (offset: 0x28e1)
// cseg ...... 0x1db + 0x2706 (0x28e1)
// imports ... 121 (offset: 0x2f49)
// animtree1 . 0   (offset: 0x40d5)
// animtree2 . 0   (offset: 0x40d5)
#using script_17aac58f7828f476;
#using script_2498b7c75f1dee2d;
#using script_2b3f8b011222f912;
#using script_38390664ae794177;
#using script_54a05cbb2455bc6f;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_attractor_manager;
#using scripts\common\ai\aitypes\shared\zombie\zombie_boss_healthbar;
#using scripts\common\ai\aitypes\shared\zombie\zombie_damage;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\mp\common\utility\stats;
#using scripts\mp\zm\zm_utility;
#using scripts\mp\zm\ztron\ztron_debug;
#using scripts\mp\zm\ztron\ztron_item;
#using scripts\mp\zm\ztron\ztron_main;
#using scripts\mp\zm\ztron\ztron_meta_progression;
#using scripts\mp\zm\ztron\ztron_player_utility;
#using scripts\mp\zm\ztron\ztron_score;
#using scripts\mp\zm\ztron\ztron_utility;
#using scripts\mp\zm\ztron\ztron_vfx;

#namespace ztron_enemy_ai;

// Namespace ztron_enemy_ai
// Params 0
// Checksum 0xf23410e5, Offset: 0x1f9
// Size: 0x53
function init()
{
    namespace_775af9b7afedb6d1::init_scaling_health();
    namespace_ce77b5e0fc016a5a::init_scaling_damage();
    ztron_ai_zombie::init();
    namespace_4f6b9f859d8abc98::init();
    level callback::add( #"on_ai_killed", &onkilled );
    level.ztron.var_805af7b14c9ae458 = [];
    
    /#
        function_ac7ee3673d6e340d();
    #/
}

// Namespace ztron_enemy_ai
// Params 1
// Checksum 0x62b35092, Offset: 0x254
// Size: 0x18f, Type: bool
function function_89146abeaa5fc021( var_71c2b26838e90f44 )
{
    if ( level.ztron.var_87c3bb3342238709 )
    {
        return false;
    }
    
    var_d933d1564d70a53f = ztron_util::function_cdd411b0cc1f9d80().size;
    
    if ( isdefined( level.ztron.active_arena ) && ztron_main::function_4da200e9b8d58a3c() == 1 )
    {
        /#
            if ( getdvarint( @"hash_6d7af5a97a21e4ef", 0 ) >= 1 && var_d933d1564d70a53f > getdvarint( @"hash_6d7af5a97a21e4ef", 0 ) >= 1 )
            {
                return false;
            }
        #/
        
        if ( var_d933d1564d70a53f >= level.ztron.active_arena.var_f3d2bdcb7cafb15b )
        {
            return false;
        }
        
        if ( isdefined( var_71c2b26838e90f44 ) && isdefined( var_71c2b26838e90f44.maxaicount ) && isdefined( var_71c2b26838e90f44.var_2a315804ad341a0d ) )
        {
            if ( ztron_util::function_8d52724a8d58c635( var_71c2b26838e90f44.name ) >= level.players.size * var_71c2b26838e90f44.var_2a315804ad341a0d + var_71c2b26838e90f44.maxaicount )
            {
                return false;
            }
        }
    }
    else if ( isdefined( level.ztron.slayer.active_arena ) && ztron_main::function_4da200e9b8d58a3c() == 5 )
    {
        if ( var_d933d1564d70a53f >= level.ztron.slayer.active_arena.var_f3d2bdcb7cafb15b )
        {
            return false;
        }
    }
    else if ( level.ztron.zombies.size >= 56 )
    {
        return false;
    }
    
    return true;
}

// Namespace ztron_enemy_ai
// Params 1
// Checksum 0x2282494, Offset: 0x3ec
// Size: 0x1b
function function_cbcbdac50ff5a340( type )
{
    self.elementalweakness[ type ] = 1;
}

// Namespace ztron_enemy_ai
// Params 0
// Checksum 0x81d8eb3b, Offset: 0x40f
// Size: 0x7e
function function_9be045fd327cab44()
{
    if ( !isdefined( self.elementalweakness ) )
    {
        self.elementalweakness = [];
    }
    
    self.elementalweakness[ "cold" ] = 0;
    self.elementalweakness[ "electrical" ] = 0;
    self.elementalweakness[ "fire" ] = 0;
    self.elementalweakness[ "toxic" ] = 0;
    self.elementalweakness[ "dark" ] = 0;
    self.elementalweakness[ "light" ] = 0;
}

// Namespace ztron_enemy_ai
// Params 4
// Checksum 0xedaf9564, Offset: 0x495
// Size: 0x110
function function_4e106850bd9eef1a( var_bfc2f13ce7223cb6 = level.ztron.var_511d9835b00f7ac, var_d1ee762fb31789cb = level.ztron.var_acd90810a416574f, var_2a0902dbdcdb29e6 = level.ztron.var_656759d1cfed2e1e, var_95ed4e3781da4583 = level.ztron.var_467d7126f9cbb8f1 )
{
    self.melee_range = var_2a0902dbdcdb29e6;
    self.var_a94ea9449f3053dd = var_95ed4e3781da4583;
    self._blackboard.var_5692974bb0dd3579 = var_bfc2f13ce7223cb6;
    self._blackboard.var_cedd501bdb70cc3f = var_d1ee762fb31789cb;
    self.var_32120addd78eb2d8 = var_bfc2f13ce7223cb6;
    self.var_5ac8458f5c69d67d = var_bfc2f13ce7223cb6;
    self.var_eb4cfef399e23d20 = squared( var_bfc2f13ce7223cb6 );
    self.var_8df7f1dd9e1adb41 = squared( var_bfc2f13ce7223cb6 );
    self.var_31c747f020f83f04 = 1;
}

// Namespace ztron_enemy_ai
// Params 0
// Checksum 0xc49c7af7, Offset: 0x5ad
// Size: 0x2b6
function function_3ae4286f85e2ef9e()
{
    assert( isdefined( self.ztron ) );
    self.ztron.original_origin = self.origin;
    self.ztron.stunned = 0;
    self.ztron.boss = 0;
    self.ztron.thinkrate = 0.25;
    self.ignoreall = 0;
    self.goalradius = 20;
    self.var_1bf51e36e4eb12e = squared( 36 );
    self.startposition = self.origin;
    self.var_1d3299405e3c6030 = 36864;
    self.var_dcf58df96f953d6d = 0;
    self.missed_paths = 0;
    self.lastknowntime = 0;
    self.allowdeath = 1;
    
    if ( !isdefined( self.initial_anim_rate ) )
    {
        self.initial_anim_rate = asm::function_27be172b46a89235();
    }
    
    self.health = level.ztron.var_f1569c16a29ffcbf;
    self.maxhealth = level.ztron.var_f1569c16a29ffcbf;
    var_2ca5e6af223d12de = namespace_4f98d1d7dc3196d::function_de5c10056990b7da( "diseaseInflictor" );
    self.health = int( self.health * ( 1 - 0.07 * var_2ca5e6af223d12de ) );
    self.maxhealth = int( self.maxhealth * ( 1 - 0.07 * var_2ca5e6af223d12de ) );
    self.ztron.var_72db97854a9e0a84 = [];
    self.var_945ef487faad2413 = 0.1;
    self.arenaspawn = ztron_main::function_4da200e9b8d58a3c() == 1;
    self.goto_position = undefined;
    self.var_35bc94cfee6a37e6 = &function_35bc94cfee6a37e6;
    self._blackboard.var_dd1cb4e12c4c12d2 = -1;
    self.aicategory = "normal";
    val::set( "ztron", "allow_give_point", 0 );
    function_9be045fd327cab44();
    
    foreach ( var_aa6be370cb327ab5 in self.var_d6894f01a36b4ff3.elementalweakness )
    {
        function_cbcbdac50ff5a340( var_aa6be370cb327ab5.elementtype );
    }
    
    if ( isai( self ) )
    {
        thread function_7f6bd13ff5f7cb16();
    }
}

// Namespace ztron_enemy_ai
// Params 0
// Checksum 0xcb59f992, Offset: 0x86b
// Size: 0x1b6
function function_1fe6518de995fa9f()
{
    self notify( #"hash_2de0adf2bebc645f" );
    self endon( #"hash_2de0adf2bebc645f" );
    self endon( #"death", #"kill_think" );
    assert( !self.ztron.boss, "<dev string:x24>" );
    self.var_929c96beea68451d = 1;
    self notify( #"hash_eb1f18e1e73238e" );
    thread ztron_util::function_ea0a0be5c5468c48( 22 );
    
    /#
        thread ztron_debug::function_cadec874ded26d36( "<dev string:x31>", ( 1, 0, 0 ), undefined, undefined, 24, "<dev string:x33>" );
    #/
    
    totalwaittime = 0;
    
    while ( true )
    {
        if ( namespace_b76ff2659823e89d::is_crawling() )
        {
            thread ztron_util::function_ea0a0be5c5468c48( randomfloatrange( 2, 7 ) );
            return;
        }
        
        waittime = randomfloatrange( 4, 7 );
        totalwaittime += waittime;
        wait waittime;
        function_dac12bb77573fab( function_301ea1a231b88fb2( self.var_361a087ab08adc1c ) );
        
        /#
            self notify( #"hash_d540b1c664a322f7" );
            
            switch ( self.var_361a087ab08adc1c )
            {
                case #"hash_9710f96c58beeaaa":
                    text = "<dev string:x46>";
                    break;
                case #"hash_eb06fed69a41dab5":
                    text = "<dev string:x50>";
                    break;
                case #"hash_941b91394072b0c1":
                    text = "<dev string:x61>";
                    break;
            }
            
            thread ztron_debug::function_cadec874ded26d36( text, ( 1, 0, 0 ), undefined, undefined, 24, "<dev string:x33>" );
        #/
        
        if ( self.var_361a087ab08adc1c == "super_sprint" )
        {
            remainingtime = 22 - totalwaittime;
            
            if ( remainingtime >= 8 )
            {
                thread ztron_util::function_ea0a0be5c5468c48( randomfloatrange( 2, 7 ) );
            }
            
            return;
        }
    }
}

// Namespace ztron_enemy_ai
// Params 0
// Checksum 0x1f036d75, Offset: 0xa29
// Size: 0xcd
function function_9a34c1b86e0eec7c()
{
    self endon( #"death", #"kill_think" );
    waitframe();
    
    /#
        if ( self.ztron.boss )
        {
            thread function_48f216c0a11eb4();
        }
    #/
    
    while ( true )
    {
        if ( level utility::flag( "ztron_round_spawning" ) == 0 && self.ztron.var_ae555ddb6e30a0b0 && ztron_main::function_4da200e9b8d58a3c() == 1 )
        {
            enemiesleft = level.ztron.zombies.size;
            
            if ( enemiesleft <= 10 && !self.var_929c96beea68451d )
            {
                thread function_1fe6518de995fa9f();
            }
        }
        
        dothink();
        wait self.ztron.thinkrate;
    }
}

// Namespace ztron_enemy_ai
// Params 1
// Checksum 0xfb8b4e4d, Offset: 0xafe
// Size: 0x32, Type: bool
function function_35bc94cfee6a37e6( var_7cb783ab199e109e )
{
    if ( isplayer( var_7cb783ab199e109e ) && var_7cb783ab199e109e.ztron.isboosting )
    {
        return false;
    }
    
    return true;
}

// Namespace ztron_enemy_ai
// Params 0
// Checksum 0x2c1c4353, Offset: 0xb39
// Size: 0x4e
function dothink()
{
    function_29bbc6846013b71b();
    result = function_bad511cea47c9d08();
    
    if ( result == 0 )
    {
        self.var_53610fa5c8a77d1f = function_a4070a89bb704df3();
        
        if ( isdefined( self.var_53610fa5c8a77d1f ) )
        {
            function_83baeab9d0850baa( self.var_53610fa5c8a77d1f );
        }
    }
}

// Namespace ztron_enemy_ai
// Params 0
// Checksum 0x9be0824c, Offset: 0xb8f
// Size: 0x8b
function function_bad511cea47c9d08()
{
    if ( !isdefined( self.ztron ) )
    {
        return 2;
    }
    
    if ( level utility::flag( "ztron_game_is_over" ) )
    {
        function_83baeab9d0850baa( self.origin, 1, 2 );
        return 2;
    }
    
    if ( self.ztron.stunned == 1 )
    {
        return 1;
    }
    
    if ( isdefined( self.goto_position ) )
    {
        function_83baeab9d0850baa( self.goto_position, undefined, 1, -1 );
        return 1;
    }
    
    if ( isdefined( self.favoriteenemy ) )
    {
        return 0;
    }
    
    return 2;
}

// Namespace ztron_enemy_ai
// Params 1
// Checksum 0x5c576cf7, Offset: 0xc23
// Size: 0x15, Type: bool
function function_6f58a8788ecd236d( chance )
{
    return randomint( 100 ) < chance;
}

// Namespace ztron_enemy_ai
// Params 1
// Checksum 0x5b394acb, Offset: 0xc41
// Size: 0xd, Type: bool
function function_c0e03abd31b91d3c( chance )
{
    return false;
}

// Namespace ztron_enemy_ai
// Params 1
// Checksum 0xf472b732, Offset: 0xc57
// Size: 0x1c, Type: bool
function function_8e7da9909f1b2e92( var_de7686972b825674 )
{
    return var_de7686972b825674.var_c741bb4a0e1a028f > gettime();
}

// Namespace ztron_enemy_ai
// Params 2
// Checksum 0xa37e0fe5, Offset: 0xc7c
// Size: 0xcd
function function_40fd300070feec7c( pointvalue, supporthealthbar = 1 )
{
    self.ztron.boss = 1;
    self.var_a8fa61d92872fc74 = 1;
    self.no_hazards = 1;
    self.var_c74f88d55ddb2df0 = 1;
    self.var_840153567385cc6b = 1;
    self.nogib = 1;
    self.pointvalue = pointvalue;
    self.var_eb92c31552620100 = 1;
    self.var_63c94fe1b2260b34 = supporthealthbar;
    self.var_818c06f9a89fb0ba = 0;
    self.aicategory = "boss";
    self.var_5c892400de8437bb = 1;
    self.disallow_knockdown = 1;
    thread function_190996ad2bfd12b6();
    self notify( #"hash_5840d907b9454cb" );
}

// Namespace ztron_enemy_ai
// Params 0
// Checksum 0x80091f18, Offset: 0xd51
// Size: 0xa0
function function_190996ad2bfd12b6()
{
    self endon( #"death" );
    
    while ( !self.ztron_initialized )
    {
        waitframe();
    }
    
    var_e9eaac8242df1b7f = int( self.maxhealth * 0.01 );
    var_f71e53e9778961c8 = 0;
    
    while ( true )
    {
        if ( !isdefined( self.enemy ) )
        {
            if ( var_f71e53e9778961c8 == 0 )
            {
                var_f71e53e9778961c8 = 1;
                wait 8;
                continue;
            }
            
            self.health = int( clamp( self.health + var_e9eaac8242df1b7f, 0, self.maxhealth ) );
        }
        else
        {
            var_f71e53e9778961c8 = 0;
        }
        
        wait 1;
    }
}

// Namespace ztron_enemy_ai
// Params 1
// Checksum 0xad4184a1, Offset: 0xdf9
// Size: 0x79
function function_301ea1a231b88fb2( curspeed )
{
    if ( !isdefined( curspeed ) )
    {
        return "walk";
    }
    
    if ( self.forcespeed )
    {
        return curspeed;
    }
    
    switch ( curspeed )
    {
        case #"hash_bdea5e7441323370":
            return "run";
        case #"hash_9710f96c58beeaaa":
            return "sprint";
        case #"hash_eb06fed69a41dab5":
            return "super_sprint";
        default:
            break;
    }
    
    return "super_sprint";
}

// Namespace ztron_enemy_ai
// Params 1
// Checksum 0x1ff37894, Offset: 0xe7b
// Size: 0x5d
function function_d1f9246886709b7f( curspeed )
{
    switch ( curspeed )
    {
        case #"hash_9710f96c58beeaaa":
            return "walk";
        case #"hash_eb06fed69a41dab5":
            return "run";
        case #"hash_941b91394072b0c1":
            return "sprint";
        default:
            break;
    }
    
    return "walk";
}

// Namespace ztron_enemy_ai
// Params 1
// Checksum 0xe1a068d6, Offset: 0xee1
// Size: 0x3a
function function_dac12bb77573fab( speed )
{
    self.var_361a087ab08adc1c = speed;
    zombie_utils::function_a8ce00e0448cb6f0( self.var_361a087ab08adc1c, "ztron", 4 );
    self notify( #"speed_change" );
}

// Namespace ztron_enemy_ai
// Params 0, eflags: 0x4
// Checksum 0x3f007215, Offset: 0xf23
// Size: 0xc9
function private function_cb351f7b2c4c1983()
{
    if ( self.forcespeed )
    {
        return;
    }
    
    self endon( #"death" );
    
    while ( true )
    {
        wait randomintrange( 3, 6 );
        speed = self.var_361a087ab08adc1c;
        
        if ( !self.arenaspawn && isdefined( self.movement_failures ) && self.movement_failures > 2 )
        {
            self.var_361a087ab08adc1c = function_d1f9246886709b7f( self.var_361a087ab08adc1c );
        }
        
        if ( isdefined( self.var_361a087ab08adc1c ) && speed != self.var_361a087ab08adc1c && !self._blackboard.isunderwater )
        {
            function_dac12bb77573fab( self.var_361a087ab08adc1c );
        }
    }
}

// Namespace ztron_enemy_ai
// Params 0
// Checksum 0x24135057, Offset: 0xff4
// Size: 0x10f
function function_7f6bd13ff5f7cb16()
{
    level endon( #"ztron_game_is_over" );
    self endon( #"death", #"hash_eb1f18e1e73238e" );
    
    while ( !self.ztron_initialized )
    {
        waitframe();
    }
    
    thread function_cb351f7b2c4c1983();
    
    if ( isdefined( level.ztron.var_a593aa94dc733518 ) )
    {
        self.var_361a087ab08adc1c = level.ztron.var_a593aa94dc733518;
    }
    
    if ( !isdefined( self.var_361a087ab08adc1c ) )
    {
        rand = randomintrange( level.ztron.zombie_base_speed - 25, level.ztron.zombie_base_speed + 25 );
        
        if ( rand <= 20 )
        {
            self.var_361a087ab08adc1c = "walk";
        }
        else if ( rand <= 60 )
        {
            self.var_361a087ab08adc1c = "run";
        }
        else
        {
            self.var_361a087ab08adc1c = "sprint";
        }
    }
    
    zombie_utils::function_a8ce00e0448cb6f0( self.var_361a087ab08adc1c, "ztron", 1 );
}

// Namespace ztron_enemy_ai
// Params 1
// Checksum 0xb39622ba, Offset: 0x110b
// Size: 0x4ac
function onkilled( params )
{
    ztron_vfx::function_d97767dbf49f31f5();
    playerattacker = ztron_util::function_da4039e4c338f818( params.eattacker );
    
    if ( isdefined( playerattacker ) )
    {
        element = zombie_damage::get_element( params.sweapon, params.eattacker, params.smeansofdeath );
        playerattacker thread ztron_player_utility::function_9dbd11353321b474( element, self.var_945ef487faad2413 );
        playerattacker ztron_score::function_7febfbfc901efb42( self.pointvalue, self );
        playerattacker stats::function_ee7ea2a7c2c198f3();
        playerattacker.ztron.var_ac97b95694bb8caa += ztron_util::function_bcfd602f958f46bb();
        playerattacker ztron_player_utility::function_c797d87f64b625c0();
        
        if ( self.ztron.var_ae555ddb6e30a0b0 && gettime() < playerattacker.ztron.var_7983e332af5bf628 )
        {
            chance = 2;
            
            if ( playerattacker ztron_fate::hasfate( 2 ) )
            {
                chance++;
                
                if ( playerattacker ztron_fate::function_c93d5c389d532c34( 2, 1 ) )
                {
                    chance += 2;
                }
            }
            
            if ( randomint( 100 ) < chance )
            {
                if ( isdefined( level.ztron.var_1aafcf52beca1b11 ) )
                {
                    if ( gettime() < level.ztron.var_edc387a66e6f8d8c )
                    {
                        itemname = level.ztron.var_1aafcf52beca1b11.itemspawnentry;
                        type = ztron_item::function_8a02cd53a42c0649( itemname );
                    }
                    
                    spawnoptions = ztron_item::function_41854e96b8bf4a06( self.origin + ( 0, 0, 50 ) );
                    ztron_item::requestspawnitem( itemname, self.origin, 12, spawnoptions );
                }
                else if ( randomint( 100 ) < 40 )
                {
                    thread ztron_item::function_4c047b50a640febf( self.origin );
                }
                else
                {
                    if ( isdefined( level.ztron.var_d32751306128fdeb ) )
                    {
                        item = level.ztron.var_d32751306128fdeb[ randomint( level.ztron.var_d32751306128fdeb.size ) ];
                        itemname = item.itemspawnentry;
                        type = ztron_item::function_8a02cd53a42c0649( itemname );
                    }
                    else
                    {
                        itemname = ztron_item::function_f3613b119900d057();
                        type = ztron_item::function_8a02cd53a42c0649( itemname );
                    }
                    
                    if ( ztron_item::canspawnitem( itemname, self.origin, type, 1 ) )
                    {
                        spawnoptions = ztron_item::function_41854e96b8bf4a06( self.origin + ( 0, 0, 50 ) );
                        ztron_item::requestspawnitem( itemname, self.origin, 12, spawnoptions );
                    }
                    else
                    {
                        thread ztron_item::function_4c047b50a640febf( self.origin );
                    }
                }
            }
        }
    }
    
    if ( !level.ztron.var_87c3bb3342238709 && level.ztron.blitzmode && level.ztron.teleporteractive && isdefined( playerattacker ) )
    {
        if ( self.ztron.boss )
        {
            playerattacker.ztron.blitzmode.var_f46ce1edc06a1312++;
        }
        else if ( self.ztron.elite )
        {
            playerattacker.ztron.blitzmode.var_c1602c8627eaecf8++;
        }
        else if ( !self.ztron.var_ae555ddb6e30a0b0 )
        {
            playerattacker.ztron.blitzmode.var_bb5d405632cf9df8++;
        }
        else
        {
            playerattacker.ztron.blitzmode.var_9e1b039eb653064f++;
        }
    }
    
    if ( self.var_ad3261b44a7138d2 )
    {
        self.spawnloc = undefined;
        self.var_ad3261b44a7138d2 = undefined;
    }
    
    if ( self.ztron.boss )
    {
        foreach ( player in level.players )
        {
            player zombie_boss_healthbar::zombie_boss_healthbar_hide();
        }
    }
    
    waitframe();
}

// Namespace ztron_enemy_ai
// Params 0
// Checksum 0xfd55de61, Offset: 0x15bf
// Size: 0xc, Type: bool
function function_f48f3c3ef4cc2e95()
{
    return !self.var_ca546573e73b77e;
}

// Namespace ztron_enemy_ai
// Params 0
// Checksum 0x629551cf, Offset: 0x15d4
// Size: 0x84, Type: bool
function function_2de7df2fa0e74064()
{
    goalpos = self.goalpos;
    radius = self.goalradius;
    height = self.goalheight;
    
    if ( isdefined( self.goto_position ) )
    {
        goalpos = self.goto_position;
    }
    
    if ( abs( self.origin[ 2 ] - goalpos[ 2 ] ) > height )
    {
        return false;
    }
    
    return distance2dsquared( self.origin, goalpos ) <= radius;
}

// Namespace ztron_enemy_ai
// Params 2
// Checksum 0xf3e8befe, Offset: 0x1661
// Size: 0x41
function function_85f702593a1e598a( origin, distance )
{
    pos = getclosestpointonnavmesh( origin );
    
    if ( !isdefined( pos ) || distancesquared( pos, origin ) > distance * distance )
    {
        return;
    }
    
    return pos;
}

// Namespace ztron_enemy_ai
// Params 2
// Checksum 0xb99b4f65, Offset: 0x16ab
// Size: 0x5d
function array_trim( array, size )
{
    newarray = [];
    
    if ( !isarray( array ) )
    {
        return newarray;
    }
    
    for ( i = 0; i < array.size ; i++ )
    {
        if ( i >= size )
        {
            break;
        }
        
        newarray[ i ] = array[ i ];
    }
    
    return newarray;
}

// Namespace ztron_enemy_ai
// Params 4
// Checksum 0xb9b7eb70, Offset: 0x1711
// Size: 0x293
function function_f9824b254168a380( origin, onpath, context, timeoutsec )
{
    assert( isdefined( origin ) );
    self endon( #"death" );
    
    if ( context == 1 || context == 2 )
    {
        adjustedorigin = origin;
    }
    else if ( context == 0 )
    {
        adjustedorigin = origin;
        
        if ( isdefined( self.enemy ) )
        {
            if ( self.var_714c7dd7e33191c9 || self.missed_paths === 10 )
            {
                adjustedorigin = function_85f702593a1e598a( origin, 72 );
                
                if ( !isdefined( adjustedorigin ) )
                {
                    adjustedorigin = origin;
                }
            }
        }
    }
    
    origin = adjustedorigin;
    assert( isdefined( origin ) );
    
    if ( iszombie() && timeoutsec != 0 )
    {
        if ( isdefined( self.attractor ) )
        {
            zombie_attractor_manager::function_dcfb4c31f1d97cd2( self.attractor );
        }
        
        self notify( #"attractor_removed" );
        self.attractor = zombie_attractor_manager::function_7eb1aaa8bc7cc15( { #origin:origin }, 4, undefined, 0 );
        thread attractormonitor( timeoutsec );
    }
    else
    {
        self setgoalpos( origin, 28 );
    }
    
    distsq = distancesquared( self.origin, origin );
    frac = clamp( distsq / 640000, 0, 1 );
    
    if ( isdefined( self.var_361a087ab08adc1c ) )
    {
        if ( self.var_361a087ab08adc1c == "walk" || self.var_66cb8b1b8c4b1053 )
        {
            frac += 0.2;
        }
        
        if ( self.var_361a087ab08adc1c == "sprint" )
        {
            frac -= 0.2;
        }
        
        if ( frac < 0.1 )
        {
            frac = 0.1;
        }
    }
    
    var_ef6707b04adf95df = int( frac * 800 );
    
    if ( var_ef6707b04adf95df < 50 )
    {
        var_ef6707b04adf95df = 50;
    }
    
    if ( var_ef6707b04adf95df > self.ztron.var_8e0af5a657c2a537 )
    {
        var_ef6707b04adf95df = self.ztron.var_8e0af5a657c2a537;
    }
    
    self.var_dcf58df96f953d6d = gettime() + var_ef6707b04adf95df;
    
    if ( !function_f48f3c3ef4cc2e95() && ( !isagent( self ) || !function_2de7df2fa0e74064() ) )
    {
        self.missed_paths = clamp( self.missed_paths + 1, 0, 10 );
        self.var_dcf58df96f953d6d += randomintrange( 200 * self.missed_paths, 500 * self.missed_paths );
        return;
    }
    
    self.missed_paths = 0;
}

// Namespace ztron_enemy_ai
// Params 4
// Checksum 0xd112792e, Offset: 0x19ac
// Size: 0x185
function function_83baeab9d0850baa( origin, force = 0, context = 0, timeoutsec = 0 )
{
    if ( !isdefined( origin ) )
    {
        return;
    }
    
    distsq = distancesquared( origin, self.origin );
    
    if ( distsq > 6250000 )
    {
        if ( !self.ztron.boss && !isdefined( self.target ) )
        {
            thread ztron_util::function_ea0a0be5c5468c48( 1 );
        }
        
        return;
    }
    
    if ( self.ztron.boss && !function_f48f3c3ef4cc2e95() )
    {
        force = 1;
    }
    
    if ( force || gettime() >= self.var_dcf58df96f953d6d )
    {
        var_d39ce4aea8715c9d = 1;
    }
    else
    {
        var_d39ce4aea8715c9d = 0;
    }
    
    if ( !var_d39ce4aea8715c9d )
    {
        distsq = distancesquared( origin, self.goalpos );
        mydistsq = distancesquared( self.origin, self.goalpos );
        scale = max( 1, mydistsq / 65536 );
        deltatolerance = int( self.var_1bf51e36e4eb12e * scale );
        
        if ( distsq > deltatolerance )
        {
            self.var_dcf58df96f953d6d -= 150;
        }
        
        return;
    }
    
    function_f9824b254168a380( origin, function_f48f3c3ef4cc2e95(), context, timeoutsec );
}

// Namespace ztron_enemy_ai
// Params 1, eflags: 0x4
// Checksum 0x93001c2f, Offset: 0x1b39
// Size: 0xf9
function private attractormonitor( timeoutsec )
{
    self endon( #"death" );
    self endon( #"attractor_removed" );
    timeout = timeoutsec > 0 ? gettime() + timeoutsec * 1000 : -1;
    
    while ( true )
    {
        if ( !isdefined( self.attractor ) )
        {
            return;
        }
        
        /#
            if ( getdvarint( @"hash_9b3461253fc4ca60", 0 ) )
            {
                debugstar( self.attractor.source.origin, ( 1, 1, 0 ), 1, "<dev string:x66>" );
            }
        #/
        
        if ( function_2de7df2fa0e74064() && self.ztron.stunned != 1 || timeout > 0 && gettime() > timeout )
        {
            zombie_attractor_manager::function_dcfb4c31f1d97cd2( self.attractor );
            self.attractor = undefined;
        }
        
        waitframe();
    }
}

// Namespace ztron_enemy_ai
// Params 1
// Checksum 0x418180ca, Offset: 0x1c3a
// Size: 0x202
function rankenemy( var_5c237d2ceeb61d76 )
{
    i = 8;
    var_453e53ea07836880 = 16384;
    
    foreach ( ally in var_5c237d2ceeb61d76 )
    {
        ally.rank = i * 50;
        
        if ( self.favoriteenemy === ally )
        {
            ally.rank += 100;
        }
        
        if ( self.lastattacker === ally )
        {
            ally.rank += 40;
        }
        
        distsq = distancesquared( self.origin, ally.origin );
        
        if ( distsq < var_453e53ea07836880 )
        {
            amount = 300 - int( mapfloat( 0, var_453e53ea07836880, 0, 300, distsq ) );
            ally.rank += amount;
        }
        
        i--;
    }
    
    foreach ( ally in var_5c237d2ceeb61d76 )
    {
        ally.rank -= ally.ztron.var_eec47abf4a615dbf * 20;
    }
    
    var_a095dc8f90e6cb98 = function_7243d45b5d82f431( var_5c237d2ceeb61d76, #rank, 1 );
    return var_a095dc8f90e6cb98;
}

// Namespace ztron_enemy_ai
// Params 0
// Checksum 0x1bddf585, Offset: 0x1e45
// Size: 0x24
function function_96263b8586456da3()
{
    self.favoriteenemy = undefined;
    self clearenemy();
    self setgoalpos( self.origin, 4192 );
}

// Namespace ztron_enemy_ai
// Params 0
// Checksum 0xac22dc44, Offset: 0x1e71
// Size: 0x43f
function function_29bbc6846013b71b()
{
    if ( self.birthtime === gettime() )
    {
        return;
    }
    
    if ( self.ignoreall )
    {
        function_96263b8586456da3();
        return;
    }
    
    if ( !isdefined( self.enemy ) )
    {
        self.favoriteenemy = undefined;
    }
    
    time = gettime();
    
    if ( isalive( self.favoriteenemy ) )
    {
        if ( self.lock_favoriteenemy || time < self.ztron.var_81821a7315f1f865 )
        {
            return self.favoriteenemy;
        }
    }
    
    if ( self.team == "allies" )
    {
        myenemies = level.ztron.zombies;
    }
    else
    {
        validtargets = arraycombine( getaiarray( "allies" ), ztron_player_utility::function_f39a4b7692450805() );
        myenemies = [];
        
        foreach ( target in validtargets )
        {
            distsq = distancesquared( self.origin, target.origin );
            
            if ( distsq >= 6250000 )
            {
                continue;
            }
            
            if ( abs( target.origin[ 2 ] - self.origin[ 2 ] ) >= self.var_692c3a2e52e12e8b )
            {
                continue;
            }
            
            if ( self.ignoreclones && target.isclone )
            {
                continue;
            }
            
            if ( target.birthtime == time )
            {
                continue;
            }
            
            if ( target.inlaststand )
            {
                continue;
            }
            
            if ( target.ignoreme || ztron_player_utility::function_baf22e7b5779b533( target ) )
            {
                continue;
            }
            
            myenemies[ myenemies.size ] = target;
        }
    }
    
    sorted = sortbydistance( myenemies, self.origin );
    closest = undefined;
    closestdistsq = squared( 10000 );
    maxconsidered = 6;
    
    foreach ( target in sorted )
    {
        maxconsidered--;
        
        if ( maxconsidered <= 0 )
        {
            break;
        }
        
        origin = target.origin;
        
        if ( self.var_9c3cd818ecb2bf73 && !isdefined( closest ) )
        {
            closest = target;
        }
        
        distsq = distancesquared( self.origin, origin );
        
        if ( self.var_5c892400de8437bb )
        {
            if ( target.ztron.var_c516f6d55a2165b4 || target.ztron.vehicle || target.ztron.usingmutant )
            {
                distsq += 4194304;
            }
        }
        
        var_9c0b3e73ac39b9fb = self.var_eb4cfef399e23d20 ?? level.ztron.var_dbf6eef1a1852eed;
        
        if ( distsq <= var_9c0b3e73ac39b9fb )
        {
            closest = target;
            break;
        }
        
        if ( distsq > closestdistsq )
        {
            continue;
        }
        
        closest = target;
        closestdistsq = distsq;
        
        if ( !ispointonnavmesh( origin ) )
        {
            point = function_85f702593a1e598a( origin, 256 );
            
            if ( !isdefined( point ) )
            {
                continue;
            }
            
            target.last_valid_position = point;
            continue;
        }
        
        target.last_valid_position = origin;
    }
    
    if ( isdefined( closest ) )
    {
        if ( closest != self.favoriteenemy )
        {
            self.favoriteenemy = closest;
        }
        
        self.ztron.var_81821a7315f1f865 = time + randomintrange( 2000, 5000 );
    }
    else
    {
        function_96263b8586456da3();
    }
    
    return self.favoriteenemy;
}

// Namespace ztron_enemy_ai
// Params 0
// Checksum 0x140b0537, Offset: 0x22b9
// Size: 0x129
function function_a4070a89bb704df3()
{
    if ( gettime() > self.enemy.birthtime )
    {
        if ( isdefined( self.enemy.ztron.vehicle ) )
        {
            var_7237854e3be197ca = self.enemy.ztron.var_fe6f1fc8ee223cf0;
            
            if ( isdefined( var_7237854e3be197ca ) )
            {
                return var_7237854e3be197ca;
            }
            
            return self.enemy.ztron.vehicle.origin;
        }
        
        var_7237854e3be197ca = self.enemy.last_valid_position;
        
        if ( isdefined( var_7237854e3be197ca ) )
        {
            return var_7237854e3be197ca;
        }
        
        self.lastknowntime = gettime();
        return self.enemy.origin;
    }
    
    if ( self.lastknowntime + 8000 < gettime() )
    {
        self.var_53610fa5c8a77d1f = undefined;
    }
    
    var_7237854e3be197ca = self.var_53610fa5c8a77d1f;
    
    if ( isdefined( var_7237854e3be197ca ) )
    {
        return var_7237854e3be197ca;
    }
    
    if ( ztron_main::function_4da200e9b8d58a3c() == 1 )
    {
        return self.origin;
    }
    
    return self.startposition;
}

// Namespace ztron_enemy_ai
// Params 0
// Checksum 0x310ff3d9, Offset: 0x23eb
// Size: 0x1a, Type: bool
function iszombie()
{
    return isai( self ) && self.unittype == "zombie";
}

// Namespace ztron_enemy_ai
// Params 0
// Checksum 0x909dbfce, Offset: 0x240e
// Size: 0xb
function function_3df1d2185d2733b5()
{
    return self.initial_anim_rate;
}

// Namespace ztron_enemy_ai
// Params 2
// Checksum 0x73d3e588, Offset: 0x2422
// Size: 0x23c
function function_bc65bed6aed12009( var_da3a1cbbe694b617, new_rate )
{
    self notify( #"hash_de39b7612585cbe7" );
    self endon( #"hash_de39b7612585cbe7" );
    self endon( #"death" );
    self endon( #"disconnect" );
    
    if ( vehicle::is_vehicle() )
    {
        return;
    }
    
    if ( self.var_884cea3cbbe21dad )
    {
        return;
    }
    
    if ( self.timeshifted )
    {
        return;
    }
    
    if ( !isdefined( new_rate ) )
    {
        var_ece703e3d116381c = zm_utility::get_zombie_team();
        
        if ( self.team == var_ece703e3d116381c )
        {
            new_rate = 1.5;
            val::set( "novaBoost", "collide_with_ai_allies", 0 );
            val::set( "novaBoost", "script_pushable_by_ai", 0 );
            val::set( "novaBoost", "script_pushable", 0 );
            val::set( "novaBoost", "ignore_ai_collision", 1 );
        }
        else
        {
            new_rate = 0.65;
        }
    }
    
    if ( isplayer( self ) )
    {
        if ( self.ztron.upgradeMask & 512 )
        {
            return;
        }
        
        thread ztron_player_utility::function_1dc834c65d7c8ea( var_da3a1cbbe694b617, new_rate );
        
        if ( !self.var_410881f05b3bf752 )
        {
            self.var_410881f05b3bf752 = 1;
        }
        
        wait var_da3a1cbbe694b617;
        self.var_410881f05b3bf752 = undefined;
        return;
    }
    
    if ( isagent( self ) && isalive( self ) )
    {
        tag = "tag_origin";
        
        if ( utility::hastag( self.model, "j_spine4" ) )
        {
            tag = "j_spine4";
        }
        
        initial_rate = function_3df1d2185d2733b5();
        
        if ( !isdefined( initial_rate ) )
        {
            initial_rate = 1;
        }
        
        aura_fx = utility::getfx( "nova_juice_me_aura_fx" );
        
        if ( !self.var_410881f05b3bf752 )
        {
            self.var_410881f05b3bf752 = 1;
            asm::function_d82cb83c9c260d49( new_rate );
            ztron_vfx::function_a2884eba34f8ea6b( aura_fx, self, tag, 1 );
        }
        
        movespeed = self.var_361a087ab08adc1c;
        self.var_361a087ab08adc1c = "super_sprint";
        wait var_da3a1cbbe694b617;
        
        if ( !isdefined( self ) )
        {
            return;
        }
        
        val::reset_all( "novaBoost" );
        self.var_361a087ab08adc1c = movespeed;
        self.var_410881f05b3bf752 = undefined;
        asm::function_d82cb83c9c260d49( initial_rate );
        ztron_vfx::aistopfxontag( aura_fx, self, tag );
    }
}

/#

    // Namespace ztron_enemy_ai
    // Params 0, eflags: 0x4
    // Checksum 0x77e19010, Offset: 0x2666
    // Size: 0x44, Type: dev
    function private function_ac7ee3673d6e340d()
    {
        devgui::function_9082edeb5db93280( "<dev string:x70>" );
        devgui::function_cd4e263c1f3018ae( "<dev string:x7c>", "<dev string:x9f>", &function_d35834b08720a8b2 );
        devgui::function_cd4e263c1f3018ae( "<dev string:xb6>", "<dev string:xdc>", &function_d35834b08720a8b2 );
        devgui::function_77df7fe7dd273e10();
    }

    // Namespace ztron_enemy_ai
    // Params 1, eflags: 0x4
    // Checksum 0x866f0e12, Offset: 0x26b2
    // Size: 0x104, Type: dev
    function private function_d35834b08720a8b2( params )
    {
        target_type = params[ 0 ];
        var_95b86e61b2c6a7 = utility::array_random( level.players );
        
        if ( target_type == "<dev string:xf7>" )
        {
            count = 5;
            ai_array = getaiarrayinradius( var_95b86e61b2c6a7.origin, 50000 );
            
            foreach ( ai in arrayrandomize( ai_array ) )
            {
                if ( isalive( ai ) )
                {
                    ai thread function_bc65bed6aed12009( 5 );
                    count--;
                    
                    if ( count <= 0 )
                    {
                        break;
                    }
                }
            }
            
            return;
        }
        
        var_95b86e61b2c6a7 thread function_bc65bed6aed12009( 5 );
    }

    // Namespace ztron_enemy_ai
    // Params 0
    // Checksum 0xb6288ba4, Offset: 0x27be
    // Size: 0x96, Type: dev
    function function_b0f7c20eddb80492()
    {
        if ( !isai( self ) )
        {
            return;
        }
        
        self endon( #"death" );
        
        while ( true )
        {
            line( self.origin, self.goalpos, function_f48f3c3ef4cc2e95() ? ( 0, 1, 0 ) : ( 1, 0, 0 ) );
            box( self.goalpos, 0, function_2de7df2fa0e74064() ? ( 0, 1, 0 ) : ( 1, 0, 0 ) );
            waitframe();
        }
    }

    // Namespace ztron_enemy_ai
    // Params 0
    // Checksum 0x3b570933, Offset: 0x285c
    // Size: 0x85, Type: dev
    function function_48f216c0a11eb4()
    {
        self endon( #"death" );
        threepercent = int( self.maxhealth * 0.03 );
        
        while ( isalive( self ) )
        {
            if ( level.ztron.dev.var_fd17659ef5557a41 )
            {
                self dodamage( threepercent, self.origin, level.players[ 0 ], level.players[ 0 ] );
            }
            
            wait 1;
        }
    }

#/
