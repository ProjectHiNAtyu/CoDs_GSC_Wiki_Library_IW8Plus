// scripts\mp\augments\deadshot_augments.gsc  (hash_6a61482844224cea.gscc) (size: 6923 Bytes / 0x1b0b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd030e9f2 (3492866546)
// size ...... 6923 (0x1b0b)
// includes .. 7   (offset: 0x19db)
// strings ... 15  (offset: 0x1a13)
// dev strs .. 0   (offset: 0x1b0b)
// exports ... 18  (offset: 0x105f)
// cseg ...... 0x19b + 0xec4 (0x105f)
// imports ... 51  (offset: 0x132f)
// animtree1 . 0   (offset: 0x1b0b)
// animtree2 . 0   (offset: 0x1b0b)
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\mp\common\utility\perk;
#using scripts\mp\gametypes\common;
#using scripts\mp\weapons;

#namespace deadshot_augments;

// Namespace deadshot_augments
// Params 0, eflags: 0x5
// Checksum 0x745cdf1a, Offset: 0x1b9
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"deadshot_augments", undefined, &init_deadshot_augments, undefined );
}

// Namespace deadshot_augments
// Params 0
// Checksum 0x7182b505, Offset: 0x1da
// Size: 0x69
function init_deadshot_augments()
{
    if ( !level.zombie_augments_in_use )
    {
        return;
    }
    
    callback::add( "zm_perk_obtained", &function_288f120db5b6defb );
    callback::add( "zm_perk_lost", &function_9e09844df6bf44c7 );
    callback::add( #"on_ai_killed", &on_ai_killed );
    callback::add( "on_player_augment_given", &function_a7e9de41b8fb5ec9 );
    callback::add( "on_player_augment_taken", &function_80f707ccc57dbad3 );
}

// Namespace deadshot_augments
// Params 1
// Checksum 0x6d2a6a55, Offset: 0x24b
// Size: 0x1bf
function function_288f120db5b6defb( params )
{
    if ( params.var_ffc1674def575bfa == "specialty_deadshot" )
    {
        if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"deadshot_piercing_rounds" ) )
        {
            self.var_8fbd699dbed14e85[ #"deadshot_piercing_rounds" ] = 1;
        }
        
        if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"deadshot_steady" ) )
        {
            perk::giveperk( "specialty_gungho" );
            perk::giveperk( "specialty_jump_aim_scale" );
            perk::giveperk( "specialty_fastsprintout" );
            perk::giveperk( "specialty_dexterity" );
        }
        
        if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"deadshot_gunslinger" ) )
        {
            perk::giveperk( "specialty_bulletaccuracy" );
        }
        
        deadshot_first_strike_name = #"deadshot_first_strike";
        deadshot_critical_efficiency_name = #"deadshot_critical_efficiency";
        deadshot_fmj_name = #"deadshot_fmj";
        var_e7f28d2ecb6c2ff1 = #"hash_77edf3a400766200";
        var_f21e11ebcd3fb759 = function_f27a2bfb4902ca5e( deadshot_first_strike_name );
        var_b2eb7d4c3ef3b7bf = function_f27a2bfb4902ca5e( deadshot_critical_efficiency_name );
        var_cf985ceb6eaecae5 = function_f27a2bfb4902ca5e( deadshot_fmj_name );
        var_dcc83386dbe56838 = function_f27a2bfb4902ca5e( var_e7f28d2ecb6c2ff1 );
        
        if ( var_f21e11ebcd3fb759 )
        {
            zombie_utils::function_dfae6a5bd222c586( &deadshot_first_strike_on_ai_damage );
        }
        
        if ( var_b2eb7d4c3ef3b7bf )
        {
            thread deadshot_critical_efficiency_thread();
            zombie_utils::function_dfae6a5bd222c586( &deadshot_critical_efficiency_on_ai_damage );
        }
        
        if ( var_cf985ceb6eaecae5 )
        {
            zombie_utils::function_dfae6a5bd222c586( &deadshot_fmj_on_ai_damage );
        }
        
        if ( var_dcc83386dbe56838 )
        {
            zombie_utils::function_dfae6a5bd222c586( &function_71bb946e6640a456 );
        }
    }
}

// Namespace deadshot_augments
// Params 1
// Checksum 0xfad3abba, Offset: 0x412
// Size: 0x109
function function_9e09844df6bf44c7( params )
{
    if ( params.var_ffc1674def575bfa == "specialty_deadshot" )
    {
        if ( self.var_8fbd699dbed14e85[ #"deadshot_piercing_rounds" ] )
        {
            self.var_8fbd699dbed14e85[ #"deadshot_piercing_rounds" ] = undefined;
        }
        
        if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"deadshot_steady" ) )
        {
            perk::removeperk( "specialty_gungho" );
            perk::removeperk( "specialty_jump_aim_scale" );
            perk::removeperk( "specialty_fastsprintout" );
            perk::removeperk( "specialty_dexterity" );
        }
        
        if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"deadshot_gunslinger" ) )
        {
            perk::removeperk( "specialty_bulletaccuracy" );
        }
        
        self notify( #"hash_d5e050b582b3e10e" );
        zombie_utils::function_10c0c35c21e3ed9d( &deadshot_first_strike_on_ai_damage );
        zombie_utils::function_10c0c35c21e3ed9d( &deadshot_critical_efficiency_on_ai_damage );
        zombie_utils::function_10c0c35c21e3ed9d( &deadshot_fmj_on_ai_damage );
        zombie_utils::function_10c0c35c21e3ed9d( &function_71bb946e6640a456 );
    }
}

// Namespace deadshot_augments
// Params 1, eflags: 0x4
// Checksum 0x335137b, Offset: 0x523
// Size: 0x57
function private function_a7e9de41b8fb5ec9( params )
{
    if ( params.augmenttype == #"deadshot" && utility::callsharedfunc( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb", "specialty_deadshot" ) )
    {
        register_augment( params.augmentname );
    }
}

// Namespace deadshot_augments
// Params 1, eflags: 0x4
// Checksum 0x95886923, Offset: 0x582
// Size: 0x192
function private function_80f707ccc57dbad3( params )
{
    if ( params.augmenttype == #"deadshot" && utility::callsharedfunc( #"hash_e7a7d049d5f06935", #"hash_81cf46be569bf3bb", "specialty_deadshot" ) )
    {
        if ( !function_f27a2bfb4902ca5e( params.augmentname ) )
        {
            unregister_augment( params.augmentname );
        }
        
        if ( params.augment )
        {
            foreach ( var_3ed5ab4f786c9181 in params.augment.var_cafcc8be001cb0de )
            {
                if ( !function_f27a2bfb4902ca5e( var_3ed5ab4f786c9181 ) )
                {
                    unregister_augment( var_3ed5ab4f786c9181 );
                }
            }
            
            foreach ( var_3ed5ab4f786c9181 in params.augment.var_41a892151199064a )
            {
                if ( !function_f27a2bfb4902ca5e( var_3ed5ab4f786c9181 ) )
                {
                    unregister_augment( var_3ed5ab4f786c9181 );
                }
            }
        }
    }
}

// Namespace deadshot_augments
// Params 1, eflags: 0x4
// Checksum 0x7260ef19, Offset: 0x71c
// Size: 0x91
function private register_augment( augment_name )
{
    unregister_augment( augment_name );
    
    if ( augment_name == #"deadshot_first_strike" )
    {
        zombie_utils::function_dfae6a5bd222c586( &deadshot_first_strike_on_ai_damage );
        return;
    }
    
    if ( augment_name == #"deadshot_critical_efficiency" )
    {
        thread deadshot_critical_efficiency_thread();
        zombie_utils::function_dfae6a5bd222c586( &deadshot_critical_efficiency_on_ai_damage );
        return;
    }
    
    if ( augment_name == #"deadshot_fmj" )
    {
        zombie_utils::function_dfae6a5bd222c586( &deadshot_fmj_on_ai_damage );
        return;
    }
    
    if ( augment_name == #"hash_77edf3a400766200" )
    {
        zombie_utils::function_dfae6a5bd222c586( &function_71bb946e6640a456 );
    }
}

// Namespace deadshot_augments
// Params 1, eflags: 0x4
// Checksum 0xb203483a, Offset: 0x7b5
// Size: 0x8d
function private unregister_augment( augment_name )
{
    if ( augment_name == #"deadshot_first_strike" )
    {
        zombie_utils::function_10c0c35c21e3ed9d( &deadshot_first_strike_on_ai_damage );
        return;
    }
    
    if ( augment_name == #"deadshot_critical_efficiency" )
    {
        self notify( #"hash_d5e050b582b3e10e" );
        zombie_utils::function_10c0c35c21e3ed9d( &deadshot_critical_efficiency_on_ai_damage );
        return;
    }
    
    if ( augment_name == #"deadshot_fmj" )
    {
        zombie_utils::function_10c0c35c21e3ed9d( &deadshot_fmj_on_ai_damage );
        return;
    }
    
    if ( augment_name == #"hash_77edf3a400766200" )
    {
        zombie_utils::function_10c0c35c21e3ed9d( &function_71bb946e6640a456 );
    }
}

// Namespace deadshot_augments
// Params 1
// Checksum 0xc8cd86d2, Offset: 0x84a
// Size: 0x52
function function_f27a2bfb4902ca5e( augmentname )
{
    funccategory = #"zombie";
    funcname = #"hash_3930894d8d2f0ee6";
    
    if ( utility::issharedfuncdefined( funccategory, funcname ) )
    {
        return utility::callsharedfunc( funccategory, funcname, "specialty_deadshot", augmentname );
    }
    
    return 0;
}

// Namespace deadshot_augments
// Params 1, eflags: 0x4
// Checksum 0x575982e4, Offset: 0x8a5
// Size: 0xea
function private deadshot_first_strike_on_ai_damage( sparams )
{
    assert( isplayer( sparams.eattacker ) );
    assert( sparams.eattacker function_f27a2bfb4902ca5e( #"deadshot_first_strike" ) );
    damage = sparams.idamage ?? 0;
    
    if ( !sparams.sweapon.ismelee && sparams.smeansofdeath != "MOD_MELEE" && sparams.biscritical && self.health == self.maxhealth )
    {
        var_2b5d1dc7ccc7c88 = level.zombie_augments[ #"deadshot_first_strike" ].var_883197ffe5ffe739 ?? 1;
        damage += damage * var_2b5d1dc7ccc7c88;
    }
    
    return damage;
}

// Namespace deadshot_augments
// Params 0, eflags: 0xc
// Checksum 0x2d65afa7, Offset: 0x998
// Size: 0x5c
function private deadshot_critical_efficiency_thread()
{
    self notify( #"hash_b7930b774aecab60" );
    self endon( #"hash_b7930b774aecab60" );
    self endon( #"death_or_disconnect" );
    self endon( #"hash_d5e050b582b3e10e" );
    
    while ( true )
    {
        self waittill( #"weapon_fired" );
        self.var_23d222901fd86844 = deadshot_critical_efficiency_passed();
        wait 0.05;
    }
}

// Namespace deadshot_augments
// Params 0, eflags: 0x4
// Checksum 0x63871cbf, Offset: 0x9fc
// Size: 0x49, Type: bool
function private deadshot_critical_efficiency_passed()
{
    reloadpercent = level.zombie_augments[ #"deadshot_critical_efficiency" ].var_572a2ba4c713871 ?? 0.25;
    reloadpercent *= 100;
    
    if ( utility::percent_chance( reloadpercent ) )
    {
        return true;
    }
    
    return false;
}

// Namespace deadshot_augments
// Params 1, eflags: 0x4
// Checksum 0xe3cc63df, Offset: 0xa4e
// Size: 0x182
function private deadshot_critical_efficiency_on_ai_damage( sparams )
{
    assert( isplayer( sparams.eattacker ) );
    assert( sparams.eattacker function_f27a2bfb4902ca5e( #"deadshot_critical_efficiency" ) );
    damage = sparams.idamage ?? 0;
    
    if ( sparams.biscritical )
    {
        player = sparams.eattacker;
        currentweapon = player getcurrentweapon();
        
        if ( !currentweapon.ismelee )
        {
            if ( player.var_23d222901fd86844 )
            {
                player.var_23d222901fd86844 = undefined;
                
                if ( currentweapon.isdualwield )
                {
                    n_clip_current_left = player getweaponammoclip( currentweapon, "left" );
                    n_clip_current_right = player getweaponammoclip( currentweapon, "right" );
                    var_b11feea92c35d08e = weaponclipsize( currentweapon );
                    
                    if ( n_clip_current_left < var_b11feea92c35d08e )
                    {
                        n_clip_current_left += 1;
                        player setweaponammoclip( currentweapon, n_clip_current_left, "left" );
                    }
                    
                    if ( n_clip_current_right < var_b11feea92c35d08e )
                    {
                        n_clip_current_right += 1;
                        player setweaponammoclip( currentweapon, n_clip_current_right, "right" );
                    }
                }
                else
                {
                    clipcount = player getweaponammoclip( currentweapon );
                    clipmax = weaponclipsize( currentweapon );
                    
                    if ( clipcount < clipmax )
                    {
                        clipcount++;
                        player setweaponammoclip( currentweapon, clipcount );
                        player playlocalsound( "uin_perk_aug_deadshot_criteff" );
                    }
                }
            }
        }
    }
    
    return damage;
}

// Namespace deadshot_augments
// Params 1, eflags: 0x4
// Checksum 0xe53c1ebe, Offset: 0xbd9
// Size: 0xa7
function private deadshot_fmj_on_ai_damage( sparams )
{
    assert( isplayer( sparams.eattacker ) );
    assert( sparams.eattacker function_f27a2bfb4902ca5e( #"deadshot_fmj" ) );
    damage = sparams.idamage ?? 0;
    
    if ( sparams.biscritical )
    {
        var_2b5d1dc7ccc7c88 = level.zombie_augments[ #"deadshot_fmj" ].var_3b1cf687f89667a6 ?? 0.05;
        damage += damage * var_2b5d1dc7ccc7c88;
    }
    
    return damage;
}

// Namespace deadshot_augments
// Params 1, eflags: 0x4
// Checksum 0xb30c0884, Offset: 0xc89
// Size: 0x1bb
function private function_71bb946e6640a456( sparams )
{
    assert( isplayer( sparams.eattacker ) );
    assert( sparams.eattacker function_f27a2bfb4902ca5e( #"hash_77edf3a400766200" ) );
    damage = sparams.idamage ?? 0;
    player = sparams.eattacker;
    
    if ( !isdefined( player.var_7e58da4ba1db7867 ) )
    {
        player.var_7e58da4ba1db7867 = self;
    }
    
    if ( player.var_7e58da4ba1db7867 == self )
    {
        if ( isdefined( self.last_dmg_struct ) && player === self.last_dmg_struct.eattacker )
        {
            time = gettime();
            var_914f035412123e84 = self.last_dmg_struct.timehit;
            
            if ( time - var_914f035412123e84 <= 3000 )
            {
                if ( !isdefined( self.var_75a1365fb1f7bfec ) )
                {
                    self.var_75a1365fb1f7bfec = 0;
                }
                
                self.var_75a1365fb1f7bfec++;
                var_2b5d1dc7ccc7c88 = level.zombie_augments[ #"hash_77edf3a400766200" ].var_875eed6900842e11 ?? 0.02;
                var_bc302a7745c697c0 = level.zombie_augments[ #"hash_77edf3a400766200" ].var_ba79e88780fa6479 ?? 0.2;
                var_2b5d1dc7ccc7c88 *= self.var_75a1365fb1f7bfec;
                
                if ( var_2b5d1dc7ccc7c88 > var_bc302a7745c697c0 )
                {
                    var_2b5d1dc7ccc7c88 = var_bc302a7745c697c0;
                }
                
                damage += damage * var_2b5d1dc7ccc7c88;
            }
            else
            {
                self.var_75a1365fb1f7bfec = 0;
            }
        }
    }
    else
    {
        player.var_7e58da4ba1db7867 = self;
    }
    
    return damage;
}

// Namespace deadshot_augments
// Params 1
// Checksum 0x35cb65b7, Offset: 0xe4d
// Size: 0x19f
function on_ai_killed( sparams )
{
    if ( isplayer( sparams.eattacker ) )
    {
        if ( sparams.eattacker utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_deadshot", #"deadshot_dead_heat" ) )
        {
            distance = distance2dsquared( sparams.eattacker.origin, self.origin );
            range_activation = level.zombie_augments[ #"deadshot_dead_heat" ].var_7d46474d7abc5b31 ?? 45;
            range_activation *= range_activation;
            
            if ( distance <= range_activation )
            {
                duration = level.zombie_augments[ #"deadshot_dead_heat" ].duration ?? 5;
                speedup = level.zombie_augments[ #"deadshot_dead_heat" ].var_f6160cc5a29861b2 ?? 0.05;
                
                if ( !sparams.eattacker common::function_8ff835bf23198a0( "deadshot_dead_heat" ) )
                {
                    sparams.eattacker weapons::addextramovespeed( "deadshot_dead_heat", speedup );
                    sparams.eattacker common::function_ac4bf3256b2545e3( "deadshot_dead_heat", speedup );
                    sparams.eattacker weapons::updatemovespeedscale();
                    sparams.eattacker playlocalsound( #"hash_11fb3861267ea078" );
                }
                
                sparams.eattacker thread deadshot_dead_heat_timer( duration );
            }
        }
    }
}

// Namespace deadshot_augments
// Params 1
// Checksum 0x933b0f70, Offset: 0xff4
// Size: 0x6b
function deadshot_dead_heat_timer( duration )
{
    self notify( #"hash_95a5bdb9d24645c5" );
    self endon( #"hash_95a5bdb9d24645c5" );
    self endon( #"disconnect" );
    wait duration;
    
    if ( common::function_8ff835bf23198a0( "deadshot_dead_heat" ) )
    {
        weapons::removeextramovespeed( "deadshot_dead_heat" );
        common::function_d85a92c557ea5a52( "deadshot_dead_heat" );
        weapons::updatemovespeedscale();
        self.var_58b35c5c77c81be7 = 0;
    }
    
    waitframe();
}

