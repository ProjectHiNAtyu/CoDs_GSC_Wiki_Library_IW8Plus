// scripts\mp\ob\activities\ob_activity_sagittarius_sniper_boss.gsc  (hash_29f10005ee7ec78c.gscc) (size: 32350 Bytes / 0x7e5e / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xc8aa0a0 (210411680)
// size ...... 32350 (0x7e5e)
// includes .. 15  (offset: 0x7902)
// strings ... 79  (offset: 0x797a)
// dev strs .. 11  (offset: 0x7dd6)
// exports ... 72  (offset: 0x52a2)
// cseg ...... 0x859 + 0x4a49 (0x52a2)
// imports ... 212 (offset: 0x5de2)
// animtree1 . 0   (offset: 0x7e5e)
// animtree2 . 0   (offset: 0x7e5e)
#using scripts\anim\shared;
#using scripts\asm\asm;
#using scripts\common\ai;
#using scripts\common\ai\ai_spawn_director;
#using scripts\common\ai\aitypes\shared\zombie\zombie_boss_healthbar;
#using scripts\common\snapshot;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\weapon;
#using scripts\mp\common\supers\combat_hologram;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\teams;
#using scripts\mp\loot\common_item;
#using scripts\mp\mp_agent;
#using scripts\mp\ob\ob_interactions_util;

#namespace ob_activity_sagittarius_sniper_boss;

// Namespace ob_activity_sagittarius_sniper_boss
// Params 4
// Checksum 0xfd002d9d, Offset: 0x877
// Size: 0x4de
function start_fight( var_cd7e11dc688992d4, var_340fa56540948d3a, var_e84ec435344e1e1d, var_f0be246ade1f8db8 )
{
    var_cd7e11dc688992d4.var_340fa56540948d3a = arraycopy( var_340fa56540948d3a );
    var_cd7e11dc688992d4.var_e84ec435344e1e1d = var_e84ec435344e1e1d;
    var_cd7e11dc688992d4.var_f0be246ade1f8db8 = var_f0be246ade1f8db8;
    
    if ( !isdefined( var_cd7e11dc688992d4.add_player_callbacks ) )
    {
        var_cd7e11dc688992d4.add_player_callbacks = [];
    }
    
    var_cd7e11dc688992d4.add_player_callbacks[ var_cd7e11dc688992d4.add_player_callbacks.size ] = &function_c46343db016dfe68;
    
    if ( !isdefined( var_cd7e11dc688992d4.remove_player_callbacks ) )
    {
        var_cd7e11dc688992d4.remove_player_callbacks = [];
    }
    
    var_cd7e11dc688992d4.remove_player_callbacks[ var_cd7e11dc688992d4.remove_player_callbacks.size ] = &function_5d9641b9f3f725aa;
    boss = mp_agent::spawnnewagentaitype( "sat_sag_boss_sniper", ( 30508, -2820, 2072 ), ( 0, 180, 0 ), "team_hundred_ninety" );
    boss ai::set_death_function( &boss_death_function );
    boss.maxhealth = getdvarint( @"sag_boss_health", 750 );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( var_cd7e11dc688992d4.team, var_cd7e11dc688992d4.sessionsquadid );
    
    if ( var_64bb57aa2d6e8b35.players.size > 1 )
    {
        perplayerincrease = getdvarint( @"hash_5a236d31541ee10d", 250 );
        boss.maxhealth += perplayerincrease * var_64bb57aa2d6e8b35.players.size;
    }
    
    boss.health = boss.maxhealth;
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        boss getenemyinfo( player );
        player thread function_a44a747b0ec5ec1c( var_cd7e11dc688992d4, boss );
    }
    
    boss forcethreatupdate();
    boss setallowshooting( 0 );
    boss allowedstances( "stand", "crouch" );
    boss.deathanimmode = "nophysics";
    boss.noragdoll = 1;
    weapon = weapon::buildweapon( "sat_sn_caspian_blank_ob_boss_mp" );
    boss.weapon = weapon;
    boss giveweapon( weapon );
    boss setspawnweapon( weapon );
    boss.primaryweapon = weapon;
    boss.agent_damage_callback = &function_1858b2985f7fbf58;
    boss.var_24954f14e27b448d = 0;
    boss.cannotmelee = 1;
    boss.disablebulletwhizbyreaction = 1;
    boss.runngunenabled = 0;
    boss.disabledodge = 1;
    boss.aggressivemode = 0;
    boss.var_63f1ffef1eafa4e4 = 1;
    boss.allowlongdeath = 0;
    boss.agentdamagefeedback = 1;
    boss.var_85723cc4de5b8147 = int( 4000 );
    boss.paincooldown = int( 5000 );
    boss.allowpain = 1;
    boss.var_a3c852607ea89f1c = 1;
    var_cd7e11dc688992d4.boss = boss;
    boss.maxsightdistsqrd = squared( 8000 );
    boss.anchor = spawn( "script_model", boss.origin );
    boss.anchor setmodel( "tag_origin" );
    boss thread utility::delete_on_death( boss.anchor );
    boss.fake_laser = spawn( "script_model", boss getmuzzlepos() );
    boss.fake_laser setmodel( "tag_laser" );
    boss.fake_laser setmoverlaserweapon( boss.weapon );
    boss.fake_laser setotherent( boss );
    boss setsightconfigtemplateoverride( "default_extremerange" );
    boss.var_49c678fbef06d966 = ( 30783, -3068, 2011 );
    boss.var_35a87fda742ebe1c = ( 0, 180, 0 );
    
    if ( true )
    {
        thread function_1d6fd27b0c10c72a( boss, var_64bb57aa2d6e8b35, var_cd7e11dc688992d4 );
        thread function_9a6a4ef73bb1fed5( boss, var_64bb57aa2d6e8b35, var_cd7e11dc688992d4 );
    }
    
    thread function_5e91522ecd9babf6( boss, var_cd7e11dc688992d4 );
    function_36df4fbdb86bce5b();
    function_17ee39e3953c3bc3( boss, var_64bb57aa2d6e8b35.players );
    changestate( boss, function_ebff478bbb36c0b6(), var_cd7e11dc688992d4 );
    return boss;
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 0
// Checksum 0xe2b0cd66, Offset: 0xd5e
// Size: 0x5d, Type: bool
function boss_death_function()
{
    animindex = asm::asm_lookupanimfromalias( "animscripted", "sat_mp_ob_sag_priya_death" );
    
    if ( isdefined( animindex ) )
    {
        shared::dropallaiweapons();
        self aisetanim( "animscripted", animindex );
    }
    
    function_9a0c3e295b99df0b( 0 );
    
    if ( self.fake_laser )
    {
        self.fake_laser delete();
    }
    
    return isdefined( animindex );
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 1
// Checksum 0x60a246ad, Offset: 0xdc4
// Size: 0x83
function function_365c8f6480690c2e( var_cd7e11dc688992d4 )
{
    var_cd7e11dc688992d4.add_player_callbacks = arrayremove( var_cd7e11dc688992d4.add_player_callbacks, &function_c46343db016dfe68 );
    var_cd7e11dc688992d4.remove_player_callbacks = arrayremove( var_cd7e11dc688992d4.remove_player_callbacks, &function_5d9641b9f3f725aa );
    var_cd7e11dc688992d4.available_boss_teleport_structs = undefined;
    var_cd7e11dc688992d4.unavailable_boss_teleport_structs = undefined;
    var_cd7e11dc688992d4.var_426dc020a9612958 = undefined;
    var_cd7e11dc688992d4.var_e84ec435344e1e1d = undefined;
    var_cd7e11dc688992d4.var_f0be246ade1f8db8 = undefined;
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 2, eflags: 0x4
// Checksum 0xe5780f12, Offset: 0xe4f
// Size: 0x63
function private function_c46343db016dfe68( player, var_cd7e11dc688992d4 )
{
    if ( var_cd7e11dc688992d4.boss && player && player zombie_boss_healthbar::function_44d523f97fcaa324() )
    {
        player zombie_boss_healthbar::zombie_boss_healthbar_show( "ob_boss_sagittarius_sniper", var_cd7e11dc688992d4.boss );
    }
    
    player thread function_a44a747b0ec5ec1c( var_cd7e11dc688992d4, var_cd7e11dc688992d4.boss );
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 2, eflags: 0x4
// Checksum 0xced66795, Offset: 0xeba
// Size: 0x3e
function private function_5d9641b9f3f725aa( player, var_cd7e11dc688992d4 )
{
    if ( var_cd7e11dc688992d4.boss && player && player zombie_boss_healthbar::function_44d523f97fcaa324() )
    {
        player zombie_boss_healthbar::zombie_boss_healthbar_hide();
    }
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 3, eflags: 0x4
// Checksum 0x2b881fd3, Offset: 0xf00
// Size: 0x4e
function private function_5bc27d979f2dbb5e( var_cad029c2ab7a4f73, var_42322f2afdbd8587, logicfunction )
{
    state = { #logicfunction:logicfunction, #var_42322f2afdbd8587:var_42322f2afdbd8587, #var_cad029c2ab7a4f73:var_cad029c2ab7a4f73 };
    return state;
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 4, eflags: 0x4
// Checksum 0xd1a7b9fb, Offset: 0xf57
// Size: 0x3c
function private changestate( boss_agent, new_state, var_cd7e11dc688992d4, custom_data = undefined )
{
    thread function_8657a859d4be65a6( boss_agent, new_state, var_cd7e11dc688992d4, custom_data );
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 4, eflags: 0x4
// Checksum 0xa59ae200, Offset: 0xf9b
// Size: 0xd2
function private function_8657a859d4be65a6( boss_agent, new_state, var_cd7e11dc688992d4, custom_data )
{
    boss_agent endon( #"death" );
    
    if ( boss_agent.current_state && boss_agent.current_state.var_42322f2afdbd8587 )
    {
        [[ boss_agent.current_state.var_42322f2afdbd8587 ]]( boss_agent, var_cd7e11dc688992d4, custom_data );
    }
    
    boss_agent notify( #"state_change" );
    boss_agent.current_state = new_state;
    
    if ( new_state.var_cad029c2ab7a4f73 )
    {
        [[ new_state.var_cad029c2ab7a4f73 ]]( boss_agent, var_cd7e11dc688992d4, custom_data );
    }
    
    if ( new_state.logicfunction )
    {
        thread [[ new_state.logicfunction ]]( boss_agent, var_cd7e11dc688992d4, custom_data );
    }
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 14, eflags: 0x4
// Checksum 0x6c833803, Offset: 0x1075
// Size: 0x229
function private function_1858b2985f7fbf58( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon, poisedamage )
{
    if ( self.starting_teleport || self.magic_bullet_shield )
    {
        return 0;
    }
    
    if ( self.var_62841ed8b6a4c46a )
    {
        return 1;
    }
    
    minamount = getdvarint( @"hash_cedcc708fcb8d1b3", 50 );
    
    if ( idamage < minamount )
    {
        idamage = minamount;
    }
    
    if ( isdefined( objweapon ) )
    {
        classname = weaponclass( objweapon );
    }
    
    if ( classname == "sniper" )
    {
        maxamount = getdvarint( @"hash_fa0045bb6d0e8a0a", 150 );
    }
    else
    {
        maxamount = getdvarint( @"hash_618530c01101e33c", 150 );
    }
    
    if ( idamage > maxamount )
    {
        /#
            iprintlnbold( "<dev string:x24>" + idamage + "<dev string:x2d>" + maxamount );
        #/
        
        idamage = maxamount;
    }
    else
    {
        /#
            iprintlnbold( "<dev string:x24>" + idamage );
        #/
    }
    
    if ( !self.var_59744494df977198 || gettime() > self.var_59744494df977198 + 1000 )
    {
        self.var_59744494df977198 = gettime() + 300;
        self.var_6e3d35fff42551c1 = 0;
    }
    
    function_9a0c3e295b99df0b( 0 );
    
    if ( gettime() <= self.var_59744494df977198 )
    {
        if ( self.var_6e3d35fff42551c1 + idamage <= 150 )
        {
            self.var_6e3d35fff42551c1 += idamage;
            return idamage;
        }
        else if ( self.var_6e3d35fff42551c1 + idamage > 150 )
        {
            self.var_6e3d35fff42551c1 += max( 0, 150 - self.var_6e3d35fff42551c1 + idamage );
            return max( 0, 150 - self.var_6e3d35fff42551c1 + idamage );
        }
    }
    
    return 0;
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 3, eflags: 0x4
// Checksum 0xc22fb049, Offset: 0x12a7
// Size: 0xfd
function private function_1d6fd27b0c10c72a( boss_agent, var_64bb57aa2d6e8b35, var_cd7e11dc688992d4 )
{
    var_cd7e11dc688992d4 endon( #"squad_left_match" );
    boss_agent endon( #"death" );
    
    while ( true )
    {
        boss_agent waittill( #"damage_update", amount );
        
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            player zombie_boss_healthbar::healthbar_set_health( boss_agent.health, boss_agent.maxhealth );
            player zombie_boss_healthbar::function_db02000f515bd5c6( boss_agent.health );
        }
    }
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 3, eflags: 0x4
// Checksum 0x8b18db50, Offset: 0x13ac
// Size: 0x152
function private function_9a6a4ef73bb1fed5( boss_agent, var_64bb57aa2d6e8b35, var_cd7e11dc688992d4 )
{
    var_cd7e11dc688992d4 endon( #"squad_left_match" );
    boss_agent waittill( #"death" );
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        player zombie_boss_healthbar::healthbar_set_health( boss_agent.health, boss_agent.maxhealth );
        player zombie_boss_healthbar::function_db02000f515bd5c6( boss_agent.health );
    }
    
    wait 3;
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        player zombie_boss_healthbar::zombie_boss_healthbar_hide();
    }
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 2, eflags: 0x4
// Checksum 0x4e18fcec, Offset: 0x1506
// Size: 0xb1
function private setactivecamo( boss_agent, value )
{
    if ( value )
    {
        boss_agent hide();
        
        if ( 1 && !boss_agent.magic_bullet_shield )
        {
            boss_agent ai::magic_bullet_shield();
        }
    }
    else
    {
        boss_agent show();
        
        if ( 1 && boss_agent.magic_bullet_shield )
        {
            boss_agent ai::stop_magic_bullet_shield();
        }
        
        if ( boss_agent.weapon != boss_agent.primaryweapon )
        {
            boss_agent shared::forceuseweapon( boss_agent.primaryweapon, "primary" );
        }
    }
    
    boss_agent function_7f8988ce63c1623d( !value );
    boss_agent.var_61448bc4bce6b00e = value;
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 0, eflags: 0x4
// Checksum 0xf80394af, Offset: 0x15bf
// Size: 0x17
function private function_a56dc8e5b22b9b39()
{
    return function_5bc27d979f2dbb5e( &function_406c0c54cb28458d, &function_45b25688f9e65dc5, &function_80e824b3e30e9f42 );
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 3, eflags: 0x4
// Checksum 0x216de2cd, Offset: 0x15df
// Size: 0x4f
function private function_406c0c54cb28458d( boss_agent, var_cd7e11dc688992d4, custom_data )
{
    boss_agent.var_55cfe9b6599e7834 = 0;
    var_cd7e11dc688992d4 notify( #"hash_5242863dc17b5295" );
    
    if ( boss_agent.magic_bullet_shield )
    {
        boss_agent ai::stop_magic_bullet_shield();
    }
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 3, eflags: 0x4
// Checksum 0x95cfbf46, Offset: 0x1636
// Size: 0x5c
function private function_45b25688f9e65dc5( boss_agent, var_cd7e11dc688992d4, custom_data )
{
    boss_agent.favoriteenemy = undefined;
    boss_agent.var_55cfe9b6599e7834 = 1;
    boss_agent.pain_taken = 0;
    boss_agent motionwarpcancel();
    boss_agent unlink();
    boss_agent function_9a0c3e295b99df0b( 0 );
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 3, eflags: 0x4
// Checksum 0x3534c228, Offset: 0x169a
// Size: 0x1f9
function private function_80e824b3e30e9f42( boss_agent, var_cd7e11dc688992d4, custom_data )
{
    boss_agent endon( #"death" );
    boss_agent endon( #"state_change" );
    logstring( "[SAG_BOSS_FIGHT] - Squad " + var_cd7e11dc688992d4.sessionsquadid + " - Start Boss fighting logic" );
    var_638191ea309f38a0 = 0;
    var_64bb57aa2d6e8b35 = teams::getsquaddata( var_cd7e11dc688992d4.team, var_cd7e11dc688992d4.sessionsquadid );
    boss_agent childthread function_9ac6a60016374a43( boss_agent );
    boss_agent childthread sniper_laser_hack();
    boss_agent function_2ef9eb3349906d00( 15000 );
    
    while ( var_638191ea309f38a0 < 1000 )
    {
        var_a84bf2f015aa45b6 = 0;
        childthread findtarget( boss_agent, var_64bb57aa2d6e8b35, 1, 60, 20250000 );
        boss_agent waittill( #"target_found", target_player, var_abbe13756ecd0b92 );
        
        if ( var_64bb57aa2d6e8b35.var_2c44544a01cc415e )
        {
            var_a84bf2f015aa45b6 = 3;
            break;
        }
        
        if ( target_player )
        {
            var_a84bf2f015aa45b6 = chargeshot( boss_agent, target_player, var_64bb57aa2d6e8b35, 1 );
        }
        else
        {
            /#
                iprintlnbold( "<dev string:x3e>" );
            #/
            
            break;
        }
        
        if ( var_a84bf2f015aa45b6 == 0 )
        {
            function_8b051bbcd7ef3883( boss_agent, target_player, var_64bb57aa2d6e8b35 );
        }
        else if ( var_a84bf2f015aa45b6 == 1 )
        {
            wait 3;
        }
        else if ( var_a84bf2f015aa45b6 == 2 )
        {
            delay = 0;
            
            if ( delay )
            {
                wait delay;
            }
            
            /#
                iprintlnbold( "<dev string:x4b>" );
            #/
            
            break;
        }
        else if ( var_a84bf2f015aa45b6 == 4 )
        {
            /#
                iprintlnbold( "<dev string:x6b>" );
            #/
        }
        
        var_638191ea309f38a0++;
    }
    
    /#
        if ( var_638191ea309f38a0 >= 1000 )
        {
            iprintlnbold( "<dev string:x9d>" );
        }
    #/
    
    customdata = undefined;
    
    if ( var_a84bf2f015aa45b6 == 3 )
    {
        customdata = { #squadrespawn:1 };
    }
    
    changestate( boss_agent, function_412c927b46c623a7(), var_cd7e11dc688992d4, customdata );
    logstring( "[SAG_BOSS_FIGHT] - Squad " + var_cd7e11dc688992d4.sessionsquadid + " - End Boss fighting logic" );
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 5, eflags: 0x4
// Checksum 0xb29538b7, Offset: 0x189b
// Size: 0x340
function private findtarget( boss_agent, var_64bb57aa2d6e8b35, var_426e58ed5fef146f, max_time, var_75954ceb198e0261 )
{
    target_player = undefined;
    timeout_timer = max_time;
    use_timeout = timeout_timer != -1;
    
    while ( !target_player )
    {
        waitframe();
        potentialtargets = [];
        prioritytargets = [];
        var_abbe13756ecd0b92 = 1;
        
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            if ( player::isreallyalive( player ) && !player::isinlaststand( player ) )
            {
                var_abbe13756ecd0b92 = 0;
                cantrace = trace::ray_trace_passed( boss_agent geteye(), player geteye(), [ boss_agent, player ] );
                distance_to_player = distance2dsquared( player.origin, boss_agent.origin );
                
                if ( ( boss_agent cansee( player ) || cantrace ) && distance_to_player <= var_75954ceb198e0261 )
                {
                    if ( player iswingsuitdeployed() && distance_to_player < squared( 1500 ) )
                    {
                        prioritytargets[ prioritytargets.size ] = player;
                        continue;
                    }
                    
                    potentialtargets[ potentialtargets.size ] = player;
                }
            }
        }
        
        if ( var_426e58ed5fef146f )
        {
            foreach ( otherplayer in level.players )
            {
                if ( var_64bb57aa2d6e8b35.players && arraycontains( var_64bb57aa2d6e8b35.players, otherplayer ) )
                {
                    continue;
                }
                
                if ( !player::isreallyalive( otherplayer ) || player::isinlaststand( otherplayer ) )
                {
                    continue;
                }
                
                if ( distance2dsquared( boss_agent.origin, otherplayer.origin ) < var_75954ceb198e0261 )
                {
                    if ( withinfov( otherplayer geteye(), otherplayer.angles, boss_agent geteye(), cos( 25 ) ) )
                    {
                        cantrace = trace::ray_trace_passed( boss_agent geteye(), otherplayer geteye(), [ boss_agent, otherplayer ] );
                        
                        if ( boss_agent cansee( otherplayer ) && cantrace )
                        {
                            prioritytargets[ prioritytargets.size ] = otherplayer;
                        }
                    }
                }
            }
        }
        
        if ( use_timeout )
        {
            timeout_timer -= level.framedurationseconds;
            
            /#
                iprintln( "<dev string:xcf>" + timeout_timer );
            #/
        }
        
        if ( prioritytargets.size )
        {
            target_player = utility::array_random( prioritytargets );
        }
        else if ( potentialtargets.size )
        {
            target_player = utility::array_random( potentialtargets );
        }
        
        if ( use_timeout && timeout_timer <= 0 )
        {
            break;
        }
        
        if ( target_player || var_abbe13756ecd0b92 )
        {
            break;
        }
    }
    
    boss_agent notify( #"target_found", target_player, var_abbe13756ecd0b92 );
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 4, eflags: 0x4
// Checksum 0xaf22765e, Offset: 0x1be3
// Size: 0x2c3
function private chargeshot( boss_agent, target_player, var_64bb57aa2d6e8b35, var_426e58ed5fef146f )
{
    boss_agent endon( #"death" );
    var_a84bf2f015aa45b6 = 0;
    boss_agent.favoriteenemy = target_player;
    boss_agent.shootpos = target_player geteye();
    var_1bff30f286863bc8 = 1.5 + 1.5 * boss_agent.health / boss_agent.maxhealth;
    
    if ( boss_agent.var_61448bc4bce6b00e )
    {
        while ( boss_agent.var_61448bc4bce6b00e )
        {
            waitframe();
        }
        
        wait 0.1;
    }
    
    if ( !target_player || !target_player isconnected() )
    {
        var_a84bf2f015aa45b6 = 4;
    }
    else
    {
        boss_agent function_9a0c3e295b99df0b( 1 );
        target_player warn_target_player();
        
        while ( true )
        {
            var_1bff30f286863bc8 -= level.framedurationseconds;
            boss_agent setaimangles( vectortoangles( boss_agent getmuzzlepos() - target_player geteye() ) );
            
            if ( var_1bff30f286863bc8 <= 0 )
            {
                break;
            }
            
            if ( var_64bb57aa2d6e8b35.var_2c44544a01cc415e )
            {
                var_a84bf2f015aa45b6 = 3;
                break;
            }
            
            players = var_426e58ed5fef146f ? level.players : var_64bb57aa2d6e8b35.players;
            
            foreach ( player in players )
            {
                var_c3722bfbc8e96eec = 422500;
                
                if ( player.vehicle && distancesquared( player.vehicle.origin, boss_agent.origin ) <= var_c3722bfbc8e96eec )
                {
                    var_a84bf2f015aa45b6 = 2;
                    break;
                }
                
                if ( distancesquared( player.origin, boss_agent.origin ) <= var_c3722bfbc8e96eec )
                {
                    var_a84bf2f015aa45b6 = 2;
                    break;
                }
            }
            
            if ( boss_agent.pain_taken )
            {
                var_a84bf2f015aa45b6 = 1;
                boss_agent.pain_taken = 0;
            }
            
            if ( var_a84bf2f015aa45b6 != 0 )
            {
                break;
            }
            
            /#
                iprintln( "<dev string:xed>" + var_1bff30f286863bc8 );
            #/
            
            waitframe();
            
            if ( !target_player || !target_player isconnected() || !player::isreallyalive( target_player ) || player::isinlaststand( target_player ) )
            {
                var_a84bf2f015aa45b6 = 4;
                break;
            }
        }
        
        if ( target_player && target_player isconnected() )
        {
            target_player notify( #"remove_outline" );
        }
        
        boss_agent function_9a0c3e295b99df0b( 0 );
    }
    
    return var_a84bf2f015aa45b6;
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 3, eflags: 0x4
// Checksum 0x50c68db4, Offset: 0x1eaf
// Size: 0x206
function private function_8b051bbcd7ef3883( boss_agent, target_player, var_64bb57aa2d6e8b35 )
{
    boss_agent.accuracy = 1;
    boss_agent setaimangles( vectortoangles( boss_agent geteye() - target_player geteye() ) );
    cantrace = trace::ray_trace_passed( boss_agent geteye(), target_player geteye(), [ boss_agent, target_player ] );
    
    if ( boss_agent cansee( target_player ) && cantrace )
    {
        boss_agent shoot( 1, target_player );
        boss_agent notify( #"boss_shooting" );
        
        /#
            iprintlnbold( "<dev string:x109>" );
        #/
        
        boss_agent.accuracy = 1;
        
        switch ( var_64bb57aa2d6e8b35.players.size )
        {
            case 1:
                var_f093a4b11d98e45a = 0.25;
                var_6972fe32e211091f = 0.5;
                break;
            case 2:
                var_f093a4b11d98e45a = 0.5;
                var_6972fe32e211091f = 1;
                break;
            case 3:
                var_f093a4b11d98e45a = 0.65;
                var_6972fe32e211091f = 1;
                break;
            case 4:
                var_f093a4b11d98e45a = 0.75;
                var_6972fe32e211091f = 1;
                break;
        }
        
        /#
            var_f093a4b11d98e45a = getdvarfloat( @"hash_326f7ddad422c778", var_f093a4b11d98e45a );
            var_6972fe32e211091f = getdvarfloat( @"hash_bea099845e6a60c4", var_6972fe32e211091f );
        #/
        
        damage = target_player.armorhealth * var_6972fe32e211091f + target_player.maxhealth * var_f093a4b11d98e45a;
        
        if ( boss_agent.var_2f2674a099ec8ddf || boss_agent.var_a70ca2ccef8d069b )
        {
            /#
                iprintlnbold( "<dev string:x118>" );
            #/
            
            damage = 5;
            boss_agent.var_2f2674a099ec8ddf = undefined;
        }
        
        if ( !target_player dodamage( damage, boss_agent.origin, boss_agent, undefined, "MOD_RIFLE_BULLET", boss_agent.weapon, undefined, undefined, 65536 ) )
        {
            /#
                iprintlnbold( "<dev string:x125>" );
            #/
        }
    }
    
    wait 1;
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 0, eflags: 0x4
// Checksum 0xda5c3108, Offset: 0x20bd
// Size: 0x89
function private warn_target_player()
{
    self hudoutlineviewmodelenable( "snapshotgrenade" );
    
    if ( !isdefined( self.markedomnvar ) )
    {
        snapshot::function_c802f1ac50040a2c();
    }
    
    if ( !self.var_d2def215077d3542 )
    {
        self.var_d2def215077d3542 = gettime();
    }
    
    if ( self.var_d2def215077d3542 >= gettime() )
    {
        if ( soundexists( "fup_vision_pulse_enemy_detected" ) )
        {
            self playsoundtoplayer( "fup_vision_pulse_enemy_detected", self );
        }
        
        self.var_d2def215077d3542 = gettime() + 9000;
    }
    
    self playsoundtoplayer( "sfx_sag_priya_glint", self );
    thread function_bd455ac71bc01659();
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 0, eflags: 0x4
// Checksum 0xb26653d, Offset: 0x214e
// Size: 0x27
function private function_bd455ac71bc01659()
{
    self endon( #"disconnect" );
    utility::waittill_any_timeout( 3, "last_stand_enter", "remove_outline" );
    self hudoutlineviewmodeldisable();
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 1, eflags: 0x4
// Checksum 0x4a70d3be, Offset: 0x217d
// Size: 0x39
function private function_9ac6a60016374a43( boss_agent )
{
    while ( true )
    {
        boss_agent waittill( #"pain" );
        boss_agent.pain_taken = 1;
        boss_agent function_82d726e652dd6663();
    }
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 2, eflags: 0x4
// Checksum 0x218bfc78, Offset: 0x21be
// Size: 0x47b
function private function_5e91522ecd9babf6( boss_agent, var_cd7e11dc688992d4 )
{
    boss_agent endon( #"death" );
    boss_agent.var_e16400de2dc108b7 = boss_agent.health > boss_agent.maxhealth ? boss_agent.maxhealth : boss_agent.health;
    boss_agent.var_3baa0b4349cf905a = boss_agent.armorhealth > boss_agent.maxarmorhealth ? boss_agent.maxarmorhealth : boss_agent.armorhealth;
    health_threshold = boss_agent.maxhealth * 0.5;
    armor_threshhold = boss_agent.maxarmorhealth * 0.5;
    boss_agent.dropdamage = 0;
    
    while ( true )
    {
        boss_agent waittill( #"damage", amount, attacker, direction_vec, damagelocation, meansofdeath );
        logstring( "[SAG_BOSS_FIGHT] - Squad " + var_cd7e11dc688992d4.sessionsquadid + " - Boss damage received, damage received :" + amount );
        adjusteddamage = amount;
        maxamount = 150;
        
        if ( boss_agent.starting_teleport || boss_agent.var_62841ed8b6a4c46a || boss_agent.magic_bullet_shield )
        {
            boss_agent.health += amount;
            continue;
        }
        
        if ( !isplayer( attacker ) )
        {
            if ( !attacker.owner || !isplayer( attacker.owner ) )
            {
                boss_agent.health += amount;
                continue;
            }
        }
        
        /#
            if ( getdvarint( @"hash_618530c01101e33c", 150 ) != 150 )
            {
                maxamount = getdvarint( @"hash_618530c01101e33c", 150 );
            }
        #/
        
        if ( amount > maxamount )
        {
            diff = amount - maxamount;
            boss_agent.health += diff;
            adjusteddamage = maxamount;
        }
        
        boss_agent.dropdamage += adjusteddamage;
        boss_agent notify( #"damage_update", adjusteddamage );
        logstring( "[SAG_BOSS_FIGHT] - Squad " + var_cd7e11dc688992d4.sessionsquadid + " - Boss damage received, new boss health :" + boss_agent.health );
        var_a6f490f3298d187f = boss_agent.var_3baa0b4349cf905a > 0 && boss_agent.var_3baa0b4349cf905a - boss_agent.armorhealth >= armor_threshhold;
        var_5e10e6e9f0dcee88 = boss_agent.health > 0 && boss_agent.var_e16400de2dc108b7 - boss_agent.health >= health_threshold;
        should_change_state = var_a6f490f3298d187f || var_5e10e6e9f0dcee88;
        
        if ( var_a6f490f3298d187f )
        {
            boss_agent.var_3baa0b4349cf905a = boss_agent.armorhealth;
        }
        else if ( var_5e10e6e9f0dcee88 )
        {
            boss_agent.var_e16400de2dc108b7 = boss_agent.health;
        }
        
        var_227611953a4fa00b = getdvarint( @"hash_d9c4919b4168f0d", 75 );
        
        if ( boss_agent.dropdamage >= var_227611953a4fa00b )
        {
            boss_agent.var_72a9ce888d691133 = 1;
            boss_agent.dropdamage = 0;
        }
        
        if ( should_change_state )
        {
            logstring( "[SAG_BOSS_FIGHT] - Squad " + var_cd7e11dc688992d4.sessionsquadid + " - Boss damage received, moving to next area" );
            boss_agent notify( #"starting_teleport" );
            changestate( boss_agent, function_4adb3573ba72b8ca(), var_cd7e11dc688992d4, { #cradlespawn:1 } );
            continue;
        }
        
        if ( !boss_agent.var_f3055f8314397ec0 )
        {
            logstring( "[SAG_BOSS_FIGHT] - Squad " + var_cd7e11dc688992d4.sessionsquadid + " - Boss damage received, moving to next location" );
            teleporttimer = 0.3;
            
            /#
                if ( getdvarfloat( @"hash_f2a14b7c8083416b", 0.3 ) != 0.3 )
                {
                    teleporttimer = getdvarfloat( @"hash_f2a14b7c8083416b", 0.3 );
                }
            #/
            
            boss_agent.var_f3055f8314397ec0 = gettime() + teleporttimer * 1000;
            boss_agent thread function_3efd2635625c97c( var_cd7e11dc688992d4 );
        }
    }
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 1, eflags: 0x4
// Checksum 0x865149da, Offset: 0x2641
// Size: 0x6b
function private function_3efd2635625c97c( var_cd7e11dc688992d4 )
{
    self endon( #"death" );
    self endon( #"state_change" );
    self endon( #"starting_teleport" );
    
    while ( gettime() <= self.var_f3055f8314397ec0 )
    {
        waitframe();
    }
    
    self.var_f3055f8314397ec0 = undefined;
    changestate( self, function_412c927b46c623a7(), var_cd7e11dc688992d4, { #cradlespawn:1 } );
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 1, eflags: 0x4
// Checksum 0x7b4c126b, Offset: 0x26b4
// Size: 0x96
function private try_spawn_wave( var_cd7e11dc688992d4 )
{
    if ( self.health <= self.maxhealth * 0.48 && !var_cd7e11dc688992d4 utility::ent_flag( "reinforce_wave_2" ) )
    {
        var_cd7e11dc688992d4 utility::ent_flag_set( "reinforce_wave_2" );
        function_cf72e85f14a03cc8( var_cd7e11dc688992d4 );
    }
    
    if ( self.health <= self.maxhealth * 0.28 && !var_cd7e11dc688992d4 utility::ent_flag( "reinforce_wave_3" ) )
    {
        var_cd7e11dc688992d4 utility::ent_flag_set( "reinforce_wave_3" );
        function_cf72e85f14a03cc8( var_cd7e11dc688992d4 );
    }
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 2, eflags: 0x4
// Checksum 0x13aaee65, Offset: 0x2752
// Size: 0xf2
function private try_spawn_item( boss_agent, var_cd7e11dc688992d4 )
{
    if ( boss_agent.var_72a9ce888d691133 )
    {
        if ( !isdefined( boss_agent.numdrops ) )
        {
            boss_agent.numdrops = 0;
        }
        
        spawnoptions = common_item::items_initspawnoptions_spawnfromposition( boss_agent.origin, boss_agent.angles );
        item = %"itemspawnentry:ob_sat_item_ammo";
        common_item::function_61c2c0251e742ffd( item, undefined, spawnoptions );
        
        if ( boss_agent.numdrops % 2 == 0 )
        {
            item = %"hash_35298bd2d2aff71f";
            spawnoptions = common_item::items_initspawnoptions_spawnfromposition( boss_agent.origin, boss_agent.angles + ( 0, randomintrange( 50, 100 ), 0 ) );
            common_item::function_61c2c0251e742ffd( item, undefined, spawnoptions );
        }
        
        boss_agent.var_72a9ce888d691133 = 0;
        boss_agent.numdrops++;
    }
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 0, eflags: 0x4
// Checksum 0xda52a9df, Offset: 0x284c
// Size: 0x26
function private function_82d726e652dd6663()
{
    self endon( #"death" );
    self.allow_pain = 0;
    wait 3;
    self.allowpain = 1;
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 0, eflags: 0x4
// Checksum 0xd7cdedf1, Offset: 0x287a
// Size: 0x17
function private function_412c927b46c623a7()
{
    return function_5bc27d979f2dbb5e( &function_54b8a5899010fd93, &function_48118096be41cc27, &function_790bc6535457c8dc );
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 3, eflags: 0x4
// Checksum 0xba675b84, Offset: 0x289a
// Size: 0x50
function private function_54b8a5899010fd93( boss_agent, var_cd7e11dc688992d4, custom_data )
{
    var_cd7e11dc688992d4 notify( #"hash_c6d72151e1bb9ed0" );
    boss_agent notify( #"starting_teleport" );
    boss_agent.starting_teleport = 1;
    boss_agent function_9a0c3e295b99df0b( 0 );
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 3, eflags: 0x4
// Checksum 0x873f950b, Offset: 0x28f2
// Size: 0x2b
function private function_48118096be41cc27( boss_agent, var_cd7e11dc688992d4, custom_data )
{
    var_cd7e11dc688992d4 notify( #"hash_5bc666f4704dcb89" );
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 3, eflags: 0x4
// Checksum 0x1a165b44, Offset: 0x2925
// Size: 0x318
function private function_790bc6535457c8dc( boss_agent, var_cd7e11dc688992d4, custom_data )
{
    boss_agent endon( #"death" );
    logstring( "[SAG_BOSS_FIGHT] - Squad " + var_cd7e11dc688992d4.sessionsquadid + " - Start Boss teleport to a new location logic" );
    boss_agent function_c56d96ce96146c58();
    
    if ( custom_data.cradlespawn )
    {
        thread function_e45e05e11ba30330( boss_agent, var_cd7e11dc688992d4 );
    }
    
    wait 1;
    setactivecamo( boss_agent, 1 );
    boss_agent.starting_teleport = undefined;
    try_spawn_item( boss_agent, var_cd7e11dc688992d4 );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( var_cd7e11dc688992d4.team, var_cd7e11dc688992d4.sessionsquadid );
    
    if ( custom_data && custom_data.squadrespawn || var_64bb57aa2d6e8b35.var_2c44544a01cc415e )
    {
        respawntime = gettime() + 20000;
        playerclose = 0;
        
        while ( gettime() < respawntime && !playerclose )
        {
            if ( isdefined( var_cd7e11dc688992d4.var_dde5404226c05288 ) )
            {
                foreach ( player in var_64bb57aa2d6e8b35.players )
                {
                    if ( distance( player.origin, var_cd7e11dc688992d4.var_dde5404226c05288.origin ) < var_cd7e11dc688992d4.var_dde5404226c05288.radius )
                    {
                        playerclose = 1;
                    }
                }
            }
            
            waitframe();
        }
    }
    else
    {
        var_3e4b734300d5b8aa = getdvarint( @"hash_6d03c07c4102eedf", 4 );
        wait var_3e4b734300d5b8aa;
    }
    
    if ( function_852f0736e869897c( var_cd7e11dc688992d4 ) )
    {
        while ( function_852f0736e869897c( var_cd7e11dc688992d4 ) )
        {
            waitframe();
        }
        
        var_cb67baaa2eb98b72 = 7;
        
        /#
            var_cb67baaa2eb98b72 = getdvarint( @"hash_74b177406715ab5e", 7 );
        #/
        
        wait var_cb67baaa2eb98b72;
    }
    
    var_64bb57aa2d6e8b35 = teams::getsquaddata( var_cd7e11dc688992d4.team, var_cd7e11dc688992d4.sessionsquadid );
    
    if ( var_64bb57aa2d6e8b35.var_2c44544a01cc415e )
    {
        wait 20;
    }
    
    var_a1e68c33991c906f = function_2f25458f6c323bbc( var_cd7e11dc688992d4, var_cd7e11dc688992d4.var_88fe9ac3bec1f92e );
    teleportorigin = function_4590e1d8b89b0fdf( var_a1e68c33991c906f.origin, boss_agent );
    teleportboss( boss_agent, teleportorigin, var_a1e68c33991c906f.angles );
    logstring( "[SAG_BOSS_FIGHT] - Squad " + var_cd7e11dc688992d4.sessionsquadid + " - Boss teleported to a new location" );
    changestate( boss_agent, function_a56dc8e5b22b9b39(), var_cd7e11dc688992d4 );
    wait randomfloatrange( 0.1, 0.5 );
    wait 0.5;
    boss_agent.var_2f2674a099ec8ddf = 1;
    setactivecamo( boss_agent, 0 );
    logstring( "[SAG_BOSS_FIGHT] - Squad " + var_cd7e11dc688992d4.sessionsquadid + " - End Boss teleport to a new location logic" );
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 2
// Checksum 0xa45b3536, Offset: 0x2c45
// Size: 0x6a
function function_4590e1d8b89b0fdf( origin, boss_agent )
{
    var_b718a4324486dcc = origin;
    traceresults = trace::ray_trace( var_b718a4324486dcc + ( 0, 0, 10 ), var_b718a4324486dcc + ( 0, 0, -10 ), boss_agent );
    
    if ( isdefined( traceresults[ "position" ] ) )
    {
        var_b718a4324486dcc = traceresults[ "position" ];
    }
    
    return var_b718a4324486dcc;
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 1, eflags: 0x4
// Checksum 0x463187f2, Offset: 0x2cb8
// Size: 0xcd
function private function_852f0736e869897c( var_cd7e11dc688992d4 )
{
    var_64bb57aa2d6e8b35 = teams::getsquaddata( var_cd7e11dc688992d4.team, var_cd7e11dc688992d4.sessionsquadid );
    allplayersdown = 1;
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        if ( player::isreallyalive( player ) && !player::isinlaststand( player ) )
        {
            allplayersdown = 0;
        }
    }
    
    return allplayersdown;
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 0, eflags: 0x4
// Checksum 0xc735410c, Offset: 0x2d8e
// Size: 0x17
function private function_4adb3573ba72b8ca()
{
    return function_5bc27d979f2dbb5e( &function_21fde730a4a6d9a6, &function_3cdef17bce110e10, &hologramlogic );
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 3, eflags: 0x4
// Checksum 0x56199d5c, Offset: 0x2dae
// Size: 0x2b
function private function_21fde730a4a6d9a6( boss_agent, var_cd7e11dc688992d4, custom_data )
{
    var_cd7e11dc688992d4 notify( #"hash_125fb82cce5e15d8" );
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 3, eflags: 0x4
// Checksum 0xfef179e7, Offset: 0x2de1
// Size: 0x1e
function private function_3cdef17bce110e10( boss_agent, var_cd7e11dc688992d4, custom_data )
{
    
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 3, eflags: 0x4
// Checksum 0x862a2137, Offset: 0x2e07
// Size: 0x14a
function private hologramlogic( boss_agent, var_cd7e11dc688992d4, custom_data )
{
    boss_agent endon( #"death" );
    logstring( "[SAG_BOSS_FIGHT] - Squad " + var_cd7e11dc688992d4.sessionsquadid + " - Start hologram logic" );
    
    if ( custom_data.cradlespawn )
    {
        thread function_e45e05e11ba30330( boss_agent, var_cd7e11dc688992d4 );
    }
    
    wait 1;
    setactivecamo( boss_agent, 1 );
    hologram_origin = custom_data.hologram_origin ?? boss_agent.origin;
    hologram_angles = custom_data.hologram_angles ?? boss_agent.angles;
    [ hologram, success ] = boss_agent deploy_hologram( var_cd7e11dc688992d4, hologram_origin, hologram_angles, custom_data.var_60449b0e7a40e25e );
    changestate( boss_agent, function_e5ae5bca248abee5(), var_cd7e11dc688992d4 );
    [[ var_cd7e11dc688992d4.var_f0be246ade1f8db8 ]]( hologram.origin, 150, var_cd7e11dc688992d4 );
    var_cd7e11dc688992d4 utility::ent_flag_wait( "hologram_scanned" );
    logstring( "[SAG_BOSS_FIGHT] - Squad " + var_cd7e11dc688992d4.sessionsquadid + " - End hologram logic" );
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 0, eflags: 0x4
// Checksum 0xcbd26a99, Offset: 0x2f59
// Size: 0x17
function private function_e5ae5bca248abee5()
{
    return function_5bc27d979f2dbb5e( &function_d32e4ada1261a74d, &function_a31e2826ff096785, &function_4efa1de3681bf202 );
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 3, eflags: 0x4
// Checksum 0xba0902c7, Offset: 0x2f79
// Size: 0x2a8
function private function_d32e4ada1261a74d( boss_agent, var_cd7e11dc688992d4, custom_data )
{
    var_f229ec93d9afcea4 = 0;
    boss_agent notify( #"starting_teleport" );
    logstring( "[SAG_BOSS_FIGHT] - Squad " + var_cd7e11dc688992d4.sessionsquadid + " - Start Boss teleport to new area enter" );
    
    if ( !isdefined( var_cd7e11dc688992d4.var_88fe9ac3bec1f92e ) )
    {
        var_cd7e11dc688992d4.var_88fe9ac3bec1f92e = 0;
    }
    else
    {
        var_f229ec93d9afcea4 = var_cd7e11dc688992d4.var_88fe9ac3bec1f92e >= var_cd7e11dc688992d4.var_340fa56540948d3a.size - 1;
        var_cd7e11dc688992d4.var_88fe9ac3bec1f92e = clampint( var_cd7e11dc688992d4.var_88fe9ac3bec1f92e + 1, 0, var_cd7e11dc688992d4.var_340fa56540948d3a.size - 1 );
    }
    
    if ( !var_f229ec93d9afcea4 )
    {
        var_cd7e11dc688992d4.available_boss_teleport_structs = arraycopy( var_cd7e11dc688992d4.var_340fa56540948d3a[ var_cd7e11dc688992d4.var_88fe9ac3bec1f92e ] );
        
        if ( false )
        {
            var_cd7e11dc688992d4.unavailable_boss_teleport_structs = [];
        }
        else
        {
            foreach ( struct in var_cd7e11dc688992d4.available_boss_teleport_structs )
            {
                if ( struct.script_noteworthy == "initial_spawn" )
                {
                    var_cd7e11dc688992d4.initial_spawn_struct = struct;
                    var_cd7e11dc688992d4.var_bee4ca05a8d0937c = struct;
                }
            }
            
            var_cd7e11dc688992d4.var_426dc020a9612958 = 0;
        }
        
        boss_agent.ignoreall = 1;
        boss_agent.var_2f2674a099ec8ddf = 1;
        
        if ( true )
        {
            var_64bb57aa2d6e8b35 = teams::getsquaddata( var_cd7e11dc688992d4.team, var_cd7e11dc688992d4.sessionsquadid );
            
            foreach ( player in var_64bb57aa2d6e8b35.players )
            {
                if ( player zombie_boss_healthbar::function_44d523f97fcaa324() )
                {
                    player zombie_boss_healthbar::zombie_boss_healthbar_hide();
                }
            }
        }
    }
    else
    {
        changestate( boss_agent, function_412c927b46c623a7(), var_cd7e11dc688992d4 );
    }
    
    logstring( "[SAG_BOSS_FIGHT] - Squad " + var_cd7e11dc688992d4.sessionsquadid + " - End Boss teleport to new area enter" );
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 3, eflags: 0x4
// Checksum 0xb370b95a, Offset: 0x3229
// Size: 0xe4
function private function_a31e2826ff096785( boss_agent, var_cd7e11dc688992d4, custom_data )
{
    boss_agent.ignoreall = 0;
    
    if ( true )
    {
        var_64bb57aa2d6e8b35 = teams::getsquaddata( var_cd7e11dc688992d4.team, var_cd7e11dc688992d4.sessionsquadid );
        
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            if ( !player zombie_boss_healthbar::function_44d523f97fcaa324() )
            {
                player zombie_boss_healthbar::zombie_boss_healthbar_show( "ob_boss_sagittarius_sniper", boss_agent );
            }
        }
    }
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 3, eflags: 0x4
// Checksum 0xe3cb1d1a, Offset: 0x3315
// Size: 0x17a
function private function_4efa1de3681bf202( boss_agent, var_cd7e11dc688992d4, custom_data )
{
    boss_agent endon( #"death" );
    boss_agent endon( #"state_change" );
    logstring( "[SAG_BOSS_FIGHT] - Squad " + var_cd7e11dc688992d4.sessionsquadid + " - Start Boss teleport to new area logic" );
    setactivecamo( boss_agent, 1 );
    try_spawn_item( boss_agent, var_cd7e11dc688992d4 );
    wait 1;
    
    if ( isdefined( var_cd7e11dc688992d4.initial_spawn_struct ) )
    {
        var_a1e68c33991c906f = var_cd7e11dc688992d4.initial_spawn_struct;
        var_cd7e11dc688992d4.initial_spawn_struct = undefined;
    }
    else
    {
        var_a1e68c33991c906f = function_2f25458f6c323bbc( var_cd7e11dc688992d4, var_cd7e11dc688992d4.var_88fe9ac3bec1f92e );
    }
    
    teleportorigin = function_4590e1d8b89b0fdf( var_a1e68c33991c906f.origin, boss_agent );
    teleportboss( boss_agent, teleportorigin, var_a1e68c33991c906f.angles );
    boss_agent function_fa32376aaa88a7a2( boss_agent.origin, 10000 );
    function_9358c93954184fef( var_cd7e11dc688992d4 );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( var_cd7e11dc688992d4.team, var_cd7e11dc688992d4.sessionsquadid );
    [[ var_cd7e11dc688992d4.var_e84ec435344e1e1d ]]( boss_agent, var_64bb57aa2d6e8b35, var_cd7e11dc688992d4 );
    setactivecamo( boss_agent, 0 );
    wait 0.25;
    changestate( boss_agent, function_a56dc8e5b22b9b39(), var_cd7e11dc688992d4 );
    logstring( "[SAG_BOSS_FIGHT] - Squad " + var_cd7e11dc688992d4.sessionsquadid + " - End Boss teleport to new area logic" );
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 1, eflags: 0x4
// Checksum 0x2bf886e, Offset: 0x3497
// Size: 0x2e
function private function_9358c93954184fef( var_cd7e11dc688992d4 )
{
    var_cd7e11dc688992d4.ent_flag[ "hologram_scanned" ] = undefined;
    var_cd7e11dc688992d4 utility::ent_flag_wait( "hologram_scanned" );
    wait 3;
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 0, eflags: 0x4
// Checksum 0xaeae4c0c, Offset: 0x34cd
// Size: 0x17
function private function_ebff478bbb36c0b6()
{
    return function_5bc27d979f2dbb5e( &function_95aba27b554159ee, &function_b545863c47a1a3f8, &function_572d10950e564a69 );
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 3, eflags: 0x4
// Checksum 0xde3165d8, Offset: 0x34ed
// Size: 0x3a
function private function_95aba27b554159ee( boss_agent, var_cd7e11dc688992d4, custom_data )
{
    boss_agent.var_a70ca2ccef8d069b = 1;
    boss_agent.var_62841ed8b6a4c46a = 1;
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 3, eflags: 0x4
// Checksum 0xadff7c9, Offset: 0x352f
// Size: 0x57
function private function_b545863c47a1a3f8( boss_agent, var_cd7e11dc688992d4, custom_data )
{
    boss_agent.var_62841ed8b6a4c46a = 0;
    boss_agent.var_a70ca2ccef8d069b = undefined;
    boss_agent.health = boss_agent.maxhealth;
    boss_agent function_9a0c3e295b99df0b( 0 );
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 3, eflags: 0x4
// Checksum 0x9e113456, Offset: 0x358e
// Size: 0x11a
function private function_572d10950e564a69( boss_agent, var_cd7e11dc688992d4, custom_data )
{
    boss_agent endon( #"death" );
    boss_agent endon( #"state_change" );
    logstring( "[SAG_BOSS_FIGHT] - Squad " + var_cd7e11dc688992d4.sessionsquadid + " - Start Boss first encounter" );
    teleportboss( boss_agent, boss_agent.origin, boss_agent.angles );
    childthread function_9987739aa9c89441( boss_agent, var_cd7e11dc688992d4 );
    boss_agent childthread function_cdc899bd2f7510b8( var_cd7e11dc688992d4 );
    boss_agent childthread function_edce4044f3c53241();
    boss_agent childthread function_74bbfda48244fe06();
    boss_agent waittill( #"hash_1466dc16c6fac9d9" );
    boss_agent ai::magic_bullet_shield();
    boss_agent function_c56d96ce96146c58();
    logstring( "[SAG_BOSS_FIGHT] - Squad " + var_cd7e11dc688992d4.sessionsquadid + " - End Boss first encounter" );
    changestate( boss_agent, function_4adb3573ba72b8ca(), var_cd7e11dc688992d4, { #var_60449b0e7a40e25e:1, #hologram_angles:boss_agent.var_35a87fda742ebe1c, #hologram_origin:boss_agent.var_49c678fbef06d966 } );
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 2, eflags: 0x4
// Checksum 0xdcec6dbc, Offset: 0x36b0
// Size: 0xf1
function private function_9987739aa9c89441( boss_agent, var_cd7e11dc688992d4 )
{
    boss_agent endon( #"death" );
    boss_agent endon( #"hash_1466dc16c6fac9d9" );
    boss_agent childthread sniper_laser_hack();
    boss_agent function_2ef9eb3349906d00( 15000 );
    var_64bb57aa2d6e8b35 = teams::getsquaddata( var_cd7e11dc688992d4.team, var_cd7e11dc688992d4.sessionsquadid );
    
    while ( true )
    {
        find_target_max_distance = 256000000;
        childthread findtarget( boss_agent, var_64bb57aa2d6e8b35, 0, -1, find_target_max_distance );
        boss_agent waittill( #"target_found", target_player, var_abbe13756ecd0b92 );
        
        if ( target_player )
        {
            var_a84bf2f015aa45b6 = chargeshot( boss_agent, target_player, var_64bb57aa2d6e8b35, 0 );
            
            if ( var_a84bf2f015aa45b6 == 0 )
            {
                function_8b051bbcd7ef3883( boss_agent, target_player, var_64bb57aa2d6e8b35 );
            }
            
            if ( target_player )
            {
                target_player notify( #"remove_outline" );
            }
        }
        
        waitframe();
    }
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 1, eflags: 0x4
// Checksum 0x1cb8f17d, Offset: 0x37a9
// Size: 0xf5
function private function_cdc899bd2f7510b8( var_cd7e11dc688992d4 )
{
    self endon( #"hash_1466dc16c6fac9d9" );
    self endon( #"death" );
    
    while ( true )
    {
        var_64bb57aa2d6e8b35 = teams::getsquaddata( var_cd7e11dc688992d4.team, var_cd7e11dc688992d4.sessionsquadid );
        
        foreach ( player in var_64bb57aa2d6e8b35.players )
        {
            if ( distancesquared( self.origin, player.origin ) < squared( 2000 ) )
            {
                self notify( #"hash_1466dc16c6fac9d9" );
                return;
            }
        }
        
        waitframe();
    }
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 0, eflags: 0x4
// Checksum 0x48528678, Offset: 0x38a6
// Size: 0x54
function private function_edce4044f3c53241()
{
    self endon( #"hash_1466dc16c6fac9d9" );
    self endon( #"death" );
    timeout = getdvarint( @"hash_61392f191cc54790", 60 );
    wait 13;
    self.var_a70ca2ccef8d069b = 0;
    wait timeout - 13;
    self notify( #"hash_1466dc16c6fac9d9" );
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 0, eflags: 0x4
// Checksum 0x766521e9, Offset: 0x3902
// Size: 0x84
function private function_74bbfda48244fe06()
{
    self endon( #"hash_1466dc16c6fac9d9" );
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"damage", amount, attacker );
        
        if ( !isplayer( attacker ) || attacker.owner && !isplayer( attacker.owner ) )
        {
            continue;
        }
        
        self notify( #"hash_1466dc16c6fac9d9" );
        break;
    }
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 3, eflags: 0x4
// Checksum 0x3f375b23, Offset: 0x398e
// Size: 0xd3
function private teleportboss( boss_agent, origin, angles )
{
    boss_agent.var_f3055f8314397ec0 = undefined;
    boss_agent notify( #"hash_8badeffa9766b47d" );
    boss_agent motionwarpcancel();
    boss_agent unlink();
    boss_agent.anchor.angles = ( 0, 0, 0 );
    boss_agent.anchor.origin = origin;
    boss_agent forceteleport( origin, ( 0, 0, 0 ), 100000 );
    boss_agent linkto( boss_agent.anchor, "tag_origin", ( 0, 0, 0 ), ( 0, 0, 0 ) );
    boss_agent thread function_fa91de401dfce56c();
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 0, eflags: 0x4
// Checksum 0xe3b5c5f8, Offset: 0x3a69
// Size: 0xb5
function private function_fa91de401dfce56c()
{
    self endon( #"death" );
    self endon( #"hash_8badeffa9766b47d" );
    
    while ( true )
    {
        /#
            if ( getdvarint( @"sag_boss_show", 0 ) > 0 )
            {
                self.anchor utility::draw_ent_axis();
            }
        #/
        
        if ( !isdefined( self.favoriteenemy ) )
        {
            waitframe();
            continue;
        }
        
        desireddir = vectortoangles( self.favoriteenemy geteye() - self getmuzzlepos() );
        additionalangles = getdvarint( @"hash_f4e89618a6e34e44", 10 );
        self.anchor.angles = ( 0, desireddir[ 1 ] + additionalangles, 0 );
        waitframe();
    }
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 2, eflags: 0x4
// Checksum 0x5eb03d4b, Offset: 0x3b26
// Size: 0x4f7
function private function_2f25458f6c323bbc( var_cd7e11dc688992d4, var_88fe9ac3bec1f92e )
{
    var_a1e68c33991c906f = undefined;
    cos_45 = cos( 45 );
    teleportmaxdist = getdvarint( @"hash_ed88db33fe22774d", 4000 );
    
    if ( true )
    {
        potentialstructs = [];
        var_64bb57aa2d6e8b35 = teams::getsquaddata( var_cd7e11dc688992d4.team, var_cd7e11dc688992d4.sessionsquadid );
        
        while ( !isdefined( var_a1e68c33991c906f ) )
        {
            foreach ( index, struct in var_cd7e11dc688992d4.available_boss_teleport_structs )
            {
                canuse = 0;
                toofar = 0;
                tooclose = 0;
                var_dcf773053ddf2564 = 0;
                
                foreach ( player in var_64bb57aa2d6e8b35.players )
                {
                    if ( !withinfov2d( player.origin, player getplayerangles(), struct.origin, cos_45 ) )
                    {
                        continue;
                    }
                    
                    if ( distancesquared( player.origin, struct.origin ) > squared( teleportmaxdist ) )
                    {
                        continue;
                    }
                    
                    if ( distancesquared( player.origin, struct.origin ) < squared( 1800 ) )
                    {
                        tooclose = 1;
                    }
                    
                    if ( var_cd7e11dc688992d4.var_bee4ca05a8d0937c && distancesquared( var_cd7e11dc688992d4.var_bee4ca05a8d0937c.origin, struct.origin ) < squared( 1200 ) )
                    {
                        var_dcf773053ddf2564 = 1;
                    }
                    
                    if ( trace::ray_trace_passed( struct.origin + ( 0, 0, 60 ), player geteye(), var_64bb57aa2d6e8b35.players ) )
                    {
                        canuse = 1;
                    }
                }
                
                if ( !toofar && !tooclose && !var_dcf773053ddf2564 && canuse && !arraycontains( potentialstructs, struct ) )
                {
                    potentialstructs[ potentialstructs.size ] = struct;
                    
                    /#
                        if ( getdvarint( @"sag_boss_show", 0 ) > 0 )
                        {
                            sphere( struct.origin, 16, undefined, undefined, 300 );
                        }
                    #/
                }
                
                if ( potentialstructs.size >= 5 )
                {
                    break;
                }
                
                if ( index % 5 == 0 )
                {
                    wait 0.05;
                }
            }
            
            if ( potentialstructs.size )
            {
                var_64bb57aa2d6e8b35 = teams::getsquaddata( var_cd7e11dc688992d4.team, var_cd7e11dc688992d4.sessionsquadid );
                
                if ( var_64bb57aa2d6e8b35.players.size == 1 )
                {
                    structs = utility::get_array_of_closest( var_64bb57aa2d6e8b35.players[ 0 ].origin, potentialstructs, undefined, 2 );
                    var_a1e68c33991c906f = utility::array_random( structs );
                }
                else
                {
                    var_a1e68c33991c906f = utility::array_random( potentialstructs );
                }
                
                var_cd7e11dc688992d4.var_bee4ca05a8d0937c = var_a1e68c33991c906f;
                
                /#
                    if ( getdvarint( @"sag_boss_show", 0 ) > 0 )
                    {
                        sphere( var_a1e68c33991c906f.origin, 16, ( 0, 1, 0 ), undefined, 300 );
                    }
                #/
                
                return var_a1e68c33991c906f;
            }
            
            wait 0.05;
        }
    }
    else if ( false )
    {
        var_a1e68c33991c906f = utility::array_random( var_cd7e11dc688992d4.available_boss_teleport_structs );
        var_cd7e11dc688992d4.available_boss_teleport_structs = arrayremove( var_cd7e11dc688992d4.available_boss_teleport_structs, var_a1e68c33991c906f );
        
        if ( var_cd7e11dc688992d4.var_bee4ca05a8d0937c )
        {
            var_cd7e11dc688992d4.available_boss_teleport_structs[ var_cd7e11dc688992d4.available_boss_teleport_structs.size ] = var_cd7e11dc688992d4.var_bee4ca05a8d0937c;
            var_cd7e11dc688992d4.var_bee4ca05a8d0937c = undefined;
        }
        
        var_fbb4a6bb9713b262 = var_cd7e11dc688992d4.available_boss_teleport_structs.size <= 0;
        
        if ( !var_fbb4a6bb9713b262 )
        {
            var_cd7e11dc688992d4.unavailable_boss_teleport_structs[ var_cd7e11dc688992d4.unavailable_boss_teleport_structs.size ] = var_a1e68c33991c906f;
        }
        else
        {
            var_cd7e11dc688992d4.var_bee4ca05a8d0937c = var_a1e68c33991c906f;
        }
        
        if ( var_fbb4a6bb9713b262 )
        {
            var_cd7e11dc688992d4.available_boss_teleport_structs = var_cd7e11dc688992d4.unavailable_boss_teleport_structs;
            var_cd7e11dc688992d4.unavailable_boss_teleport_structs = [];
        }
    }
    else
    {
        var_a1e68c33991c906f = var_cd7e11dc688992d4.available_boss_teleport_structs[ var_cd7e11dc688992d4.var_426dc020a9612958 ];
        var_cd7e11dc688992d4.var_426dc020a9612958 = ( var_cd7e11dc688992d4.var_426dc020a9612958 + 1 ) % var_cd7e11dc688992d4.available_boss_teleport_structs.size;
    }
    
    return var_a1e68c33991c906f;
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 0, eflags: 0x4
// Checksum 0xbe0ee17f, Offset: 0x4026
// Size: 0x1e1
function private sniper_laser_hack()
{
    if ( !isdefined( self.var_216497b1ab46d9d4 ) )
    {
        self.var_216497b1ab46d9d4 = 0.93;
    }
    
    while ( isalive( self ) && isdefined( self.fake_laser ) )
    {
        if ( !isdefined( self.favoriteenemy ) )
        {
            self.fake_laser laseroff();
            self.fake_laser laserforceoff();
            muzzlepos = self getmuzzlepos();
            self.fake_laser.origin = muzzlepos;
            self.fake_laser.angles = self getmuzzleangle();
            
            while ( !isdefined( self.favoriteenemy ) )
            {
                muzzlepos = self getmuzzlepos();
                self.fake_laser.origin = muzzlepos;
                self.fake_laser.angles = self getmuzzleangle();
                waitframe();
            }
        }
        
        self.fake_laser dontinterpolate();
        muzzlepos = self getmuzzlepos();
        self.fake_laser.origin = muzzlepos + ( 0, 0, -4 );
        desireddir = vectornormalize( self.favoriteenemy geteye() - muzzlepos );
        muzzledir = self getmuzzledir();
        desireddir = vectornormalize( ( desireddir[ 0 ], desireddir[ 1 ], 0 ) );
        muzzledir = vectornormalize( ( muzzledir[ 0 ], muzzledir[ 1 ], 0 ) );
        dot = vectordot( desireddir, muzzledir );
        
        if ( dot < self.var_216497b1ab46d9d4 )
        {
            self.fake_laser.angles = self getmuzzleangle();
        }
        else
        {
            self.fake_laser.angles = vectortoangles( self.favoriteenemy geteye() - self.fake_laser.origin );
        }
        
        waitframe();
    }
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 4
// Checksum 0x188d9e7f, Offset: 0x420f
// Size: 0x2aa
function deploy_hologram( var_cd7e11dc688992d4, holo_origin, holo_angles, var_60449b0e7a40e25e = 0 )
{
    logstring( "[SAG_BOSS_FIGHT] - Squad " + var_cd7e11dc688992d4.sessionsquadid + " - Start deploying hologram" );
    hologram_equipment = magicgrenademanual( "sat_combat_hologram_ob", holo_origin + ( 0, 0, 15 ), ( 0, 0, -10 ) );
    msg = hologram_equipment utility::waittill_any_timeout( 5, "missile_stuck" );
    hologram_equipment.angles = ( hologram_equipment.angles[ 0 ], holo_angles[ 1 ] + 90, hologram_equipment.angles[ 2 ] );
    hologram_equipment setmodel( "projectile_sat_combat_hologram" );
    hologram_equipment setscriptablepartstate( #"active", #"active", 0 );
    hologram_equipment.owner = self;
    hologram_equipment.grenadeowner = self;
    hologram_equipment.team = self.team;
    logstring( "[SAG_BOSS_FIGHT] - Squad " + var_cd7e11dc688992d4.sessionsquadid + " - Deploying hologram at pos :" + hologram_equipment.origin + ", angles :" + hologram_equipment.angles );
    show_head_icon = 0;
    hologram_equipment combat_hologram::function_28bf72d5a6dace11( holo_angles, 0, %"sat_ind_pl_violet_proto_skin", "sat_cin_sag_priya_hologram_idle", "sat_cin_sag_priya_hologram_idle", self.weapon, 12, show_head_icon );
    hologram_equipment thread combat_hologram::combatholo_activate( hologram_equipment.owner, show_head_icon );
    decoy = hologram_equipment.decoy;
    
    if ( var_60449b0e7a40e25e )
    {
        var_64bb57aa2d6e8b35 = teams::getsquaddata( var_cd7e11dc688992d4.team, var_cd7e11dc688992d4.sessionsquadid );
        function_17ee39e3953c3bc3( decoy, var_64bb57aa2d6e8b35.players );
        function_17ee39e3953c3bc3( hologram_equipment, var_64bb57aa2d6e8b35.players );
        function_17ee39e3953c3bc3( decoy.weaponent, var_64bb57aa2d6e8b35.players );
        function_17ee39e3953c3bc3( decoy.hitreactent, var_64bb57aa2d6e8b35.players );
    }
    
    var_cd7e11dc688992d4 notify( #"hash_43d681b55f223ff7", hologram_equipment.origin );
    thread function_7ed3bb8a056fe13e( hologram_equipment, var_cd7e11dc688992d4 );
    thread function_c1ba75bb3a338e7f( hologram_equipment );
    var_cd7e11dc688992d4.decoy = decoy;
    logstring( "[SAG_BOSS_FIGHT] - Squad " + var_cd7e11dc688992d4.sessionsquadid + " - End deploying hologram" );
    return [ hologram_equipment, msg != "timeout" ];
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 2, eflags: 0x4
// Checksum 0x8aa32f25, Offset: 0x44c2
// Size: 0x18c
function private function_7ed3bb8a056fe13e( hologram_equipment, var_cd7e11dc688992d4 )
{
    hologram_equipment endon( #"death" );
    var_cd7e11dc688992d4 utility::ent_flag_wait( "echo_unit_spotted" );
    useent = spawn( "script_model", hologram_equipment.origin + ( 0, 0, 60 ) );
    useent makeusable();
    useent setcursorhint( "HINT_NOICON" );
    useent sethintstring( &"sat_ob_activities/pisces_scan" );
    useent setuseholdduration( "duration_none" );
    useent sethintonobstruction( "show" );
    useent setusefov( 100 );
    useent setuserange( 100 );
    useent sethintdisplayrange( 100 );
    function_c158f5286841367f( useent, var_cd7e11dc688992d4 );
    var_cd7e11dc688992d4 utility::ent_flag_set( "hologram_dropped" );
    
    while ( true )
    {
        useent waittill( #"trigger", player );
        function_969394bb6b968c9( useent, var_cd7e11dc688992d4 );
        var_fab006cdb4f6e516 = ob_interactions_util::function_c7b5806740384a61( "earpiece_press_sat_ob", player, 5, undefined, 1, 1, 1, -1, "ClinkInteractions" );
        
        if ( var_fab006cdb4f6e516 )
        {
            logstring( "[SAG_BOSS_FIGHT] - Squad " + var_cd7e11dc688992d4.sessionsquadid + " - Hologram Interaction completed" );
            var_cd7e11dc688992d4 utility::ent_flag_set( "hologram_scanned" );
            var_cd7e11dc688992d4 utility::ent_flag_clear( "hologram_dropped" );
            useent delete();
            hologram_equipment thread combat_hologram::combatholo_destroy( undefined, 1 );
            var_cd7e11dc688992d4.decoy = undefined;
            return;
        }
        
        wait 0.5;
        function_c158f5286841367f( useent, var_cd7e11dc688992d4 );
    }
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 1, eflags: 0x4
// Checksum 0x8daacef3, Offset: 0x4656
// Size: 0xb1
function private function_c1ba75bb3a338e7f( hologram_equipment )
{
    hologram_equipment endon( #"death" );
    hologram_equipment.decoy setcandamage( 1 );
    hologram_equipment.decoy.health = 10000;
    
    while ( true )
    {
        hologram_equipment.decoy utility::waittill_any_timeout( randomfloatrange( 2, 3 ), "damage" );
        hologram_equipment.decoy.hitreactent setscriptablepartstate( #"hitreact_fx", #"enemy_triggered", 0 );
        hologram_equipment.decoy.health = 10000;
    }
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 2, eflags: 0x4
// Checksum 0xbab2e1f1, Offset: 0x470f
// Size: 0xbc
function private function_c158f5286841367f( ent, var_cd7e11dc688992d4 )
{
    var_64bb57aa2d6e8b35 = teams::getsquaddata( var_cd7e11dc688992d4.team, var_cd7e11dc688992d4.sessionsquadid );
    ent disableplayeruseforallplayers();
    
    foreach ( player in var_64bb57aa2d6e8b35.players )
    {
        ent enableplayeruse( player );
    }
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 2, eflags: 0x4
// Checksum 0x55715529, Offset: 0x47d3
// Size: 0x1c
function private function_969394bb6b968c9( ent, var_cd7e11dc688992d4 )
{
    ent disableplayeruseforallplayers();
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 1, eflags: 0x4
// Checksum 0x3481c868, Offset: 0x47f7
// Size: 0xa8
function private function_cf72e85f14a03cc8( var_cd7e11dc688992d4 )
{
    if ( !var_cd7e11dc688992d4.boss_reinforce_wave )
    {
        var_cd7e11dc688992d4.boss_reinforce_wave = 0;
    }
    
    if ( !level.var_de21a4f8a9ede214[ var_cd7e11dc688992d4.var_ee4dff6c24f787f8 ][ var_cd7e11dc688992d4.boss_reinforce_wave ] )
    {
        return;
    }
    
    wave_name = level.var_de21a4f8a9ede214[ var_cd7e11dc688992d4.var_ee4dff6c24f787f8 ][ var_cd7e11dc688992d4.boss_reinforce_wave ];
    requestid = ai_spawn_director::lookup_spawn_request( wave_name );
    
    if ( isdefined( requestid ) )
    {
        function_ef57f478f96b050c( requestid, 1 );
        var_cd7e11dc688992d4.boss_reinforce_wave++;
    }
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 0, eflags: 0x4
// Checksum 0x13901767, Offset: 0x48a7
// Size: 0xec
function private function_36df4fbdb86bce5b()
{
    level.var_de21a4f8a9ede214 = [];
    level.var_de21a4f8a9ede214[ 0 ] = [];
    level.var_de21a4f8a9ede214[ 1 ] = [];
    level.var_de21a4f8a9ede214[ 2 ] = [];
    level.var_de21a4f8a9ede214[ 0 ][ 0 ] = "sat_ob_sag_path_1_priya_vtol_1";
    level.var_de21a4f8a9ede214[ 0 ][ 1 ] = "sat_ob_sag_path_1_priya_vtol_2";
    level.var_de21a4f8a9ede214[ 0 ][ 2 ] = "sat_ob_sag_path_1_priya_vtol_3";
    level.var_de21a4f8a9ede214[ 1 ][ 0 ] = "sat_ob_sag_path_2_priya_vtol_1";
    level.var_de21a4f8a9ede214[ 1 ][ 1 ] = "sat_ob_sag_path_2_priya_vtol_2";
    level.var_de21a4f8a9ede214[ 1 ][ 2 ] = "sat_ob_sag_path_2_priya_vtol_3";
    level.var_de21a4f8a9ede214[ 2 ][ 0 ] = "sat_ob_sag_path_3_priya_vtol_1";
    level.var_de21a4f8a9ede214[ 2 ][ 1 ] = "sat_ob_sag_path_3_priya_vtol_2";
    level.var_de21a4f8a9ede214[ 2 ][ 2 ] = "sat_ob_sag_path_3_priya_vtol_3";
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 2, eflags: 0xc
// Checksum 0x260c4068, Offset: 0x499b
// Size: 0x81
function private function_a44a747b0ec5ec1c( var_cd7e11dc688992d4, boss_agent )
{
    self notify( #"hash_6b3942c37d4c9e99" );
    self endon( #"hash_6b3942c37d4c9e99" );
    
    if ( true )
    {
        boss_agent endon( #"death" );
        self endon( #"disconnect" );
        
        while ( true )
        {
            self waittill( #"spawned" );
            wait 1;
            
            if ( zombie_boss_healthbar::function_44d523f97fcaa324() )
            {
                zombie_boss_healthbar::zombie_boss_healthbar_hide();
                zombie_boss_healthbar::zombie_boss_healthbar_show( "ob_boss_sagittarius_sniper", boss_agent );
            }
        }
    }
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 0, eflags: 0x4
// Checksum 0x941f968e, Offset: 0x4a24
// Size: 0x1f
function private function_c56d96ce96146c58()
{
    playfx( level._effect[ "sat_cradle_death" ], self.origin );
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 2, eflags: 0x4
// Checksum 0xef19a090, Offset: 0x4a4b
// Size: 0x286
function private function_e45e05e11ba30330( boss_agent, var_cd7e11dc688992d4 )
{
    if ( !boss_agent.var_12f9b62539b70a3a )
    {
        boss_agent.var_12f9b62539b70a3a = 0;
        boss_agent.num_cradle_spawns = 0;
    }
    
    boss_agent.var_12f9b62539b70a3a++;
    min_tries = getdvarint( @"hash_2271807aa2cb548d", 1 );
    var_ad74ec9ccf80e37a = getdvarint( @"hash_224e6a7aa2a4dc73", 3 );
    var_96b3ed3398c47344 = getdvarint( @"hash_c71a79edb0863dd8", 30 );
    do_spawn = 0;
    
    if ( boss_agent.var_12f9b62539b70a3a >= min_tries )
    {
        if ( randomint( 100 ) > var_96b3ed3398c47344 || boss_agent.var_12f9b62539b70a3a >= var_ad74ec9ccf80e37a )
        {
            do_spawn = 1;
        }
    }
    
    if ( isdefined( level.var_777b5ed7edd75e81 ) )
    {
        function_c6b02655798b70fa( var_cd7e11dc688992d4 );
        level.var_777b5ed7edd75e81 = undefined;
        do_spawn = 0;
    }
    
    bosshealth = boss_agent.health / boss_agent.maxhealth;
    Wave = [];
    
    if ( bosshealth <= 0.1 )
    {
        Wave = [ "long", "lmg" ];
    }
    else if ( bosshealth <= 0.2 )
    {
        Wave = [ "long", "rpg" ];
    }
    else if ( bosshealth <= 0.35 )
    {
        Wave = [ "lmg" ];
    }
    else if ( bosshealth <= 0.5 )
    {
        Wave = [ "rpg" ];
    }
    else if ( bosshealth <= 0.65 )
    {
        Wave = [ "long" ];
    }
    else
    {
        do_spawn = 0;
    }
    
    if ( do_spawn )
    {
        foreach ( type in Wave )
        {
            requestid = ai_spawn_director::spawn_request( "ai_encounter:sat_ob_sag_priya_cradle_" + type, boss_agent.origin, 128, 1, 1 );
            ai_spawn_director::add_spawned_callback( requestid, &function_e9c8af8538a1a182, var_cd7e11dc688992d4 );
        }
        
        boss_agent.var_12f9b62539b70a3a = 0;
        boss_agent.num_cradle_spawns++;
        var_cd7e11dc688992d4 notify( #"cradle_spawn" );
    }
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 1, eflags: 0x4
// Checksum 0x13e3a6d2, Offset: 0x4cd9
// Size: 0xba
function private function_c6b02655798b70fa( var_cd7e11dc688992d4 )
{
    foreach ( Wave in level.var_777b5ed7edd75e81 )
    {
        iprintlnbold( Wave );
        requestid = ai_spawn_director::spawn_request( "ai_encounter:sat_ob_sag_priya_cradle_" + Wave, self.origin, 128, 1, 1 );
        ai_spawn_director::add_spawned_callback( requestid, &function_e9c8af8538a1a182, var_cd7e11dc688992d4 );
    }
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 1, eflags: 0x4
// Checksum 0xe5638350, Offset: 0x4d9b
// Size: 0xc8
function private function_9a0c3e295b99df0b( state )
{
    if ( state )
    {
        if ( self.sniper_fx_on )
        {
            return;
        }
        
        if ( self.fake_laser )
        {
            self.fake_laser laseron();
            self.fake_laser laserforceon();
        }
        
        playfxontag( level._effect[ "sag_boss_sniper_glint" ], self, "tag_eye" );
        self.sniper_fx_on = 1;
        return;
    }
    
    if ( !self.sniper_fx_on )
    {
        return;
    }
    
    if ( self.fake_laser )
    {
        self.fake_laser laseroff();
        self.fake_laser laserforceoff();
    }
    
    stopfxontag( level._effect[ "sag_boss_sniper_glint" ], self, "tag_eye" );
    self.sniper_fx_on = 0;
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 4, eflags: 0x4
// Checksum 0xd824bcd8, Offset: 0x4e6b
// Size: 0x31
function private function_e9c8af8538a1a182( requestid, var_cd7e11dc688992d4, agent, var_1e29e18b1e9a4ba0 )
{
    thread function_d5ee4406e8bab537( agent, var_cd7e11dc688992d4 );
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 2, eflags: 0x4
// Checksum 0xb6919a8e, Offset: 0x4ea4
// Size: 0x14d
function private function_d5ee4406e8bab537( agent, var_cd7e11dc688992d4 )
{
    agent endon( #"death" );
    
    if ( isagent( agent ) )
    {
        wait 0.1;
        
        while ( agent.vehicle )
        {
            waitframe();
        }
        
        var_64bb57aa2d6e8b35 = teams::getsquaddata( var_cd7e11dc688992d4.team, var_cd7e11dc688992d4.sessionsquadid );
        
        while ( !isdefined( var_64bb57aa2d6e8b35.players ) )
        {
            var_64bb57aa2d6e8b35 = teams::getsquaddata( var_cd7e11dc688992d4.team, var_cd7e11dc688992d4.sessionsquadid );
            wait 0.1;
        }
        
        closest_player = function_47c86977a18df38b( var_64bb57aa2d6e8b35.players, agent.origin );
        agent getenemyinfo( closest_player );
        agent forcethreatupdate();
        agent function_fa32376aaa88a7a2( agent.origin, 10000 );
        
        if ( agent.agent_type && issubstr( agent.agent_type, "rusher" ) )
        {
            agent thread cradle_rusher_think( var_cd7e11dc688992d4, agent.origin );
            return;
        }
        
        agent enabletraversals( 0 );
        agent.goalradius = 1024;
        agent.goalheight = 100;
    }
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 2, eflags: 0x4
// Checksum 0x7864c04e, Offset: 0x4ff9
// Size: 0x123
function private cradle_rusher_think( var_cd7e11dc688992d4, og_origin )
{
    self endon( #"death" );
    volume = self getgoalvolume();
    
    while ( true )
    {
        var_64bb57aa2d6e8b35 = teams::getsquaddata( var_cd7e11dc688992d4.team, var_cd7e11dc688992d4.sessionsquadid );
        
        if ( !isdefined( var_64bb57aa2d6e8b35.players ) )
        {
            self cleargoalentity();
            self setgoalvolume( volume );
            wait 1;
            continue;
        }
        
        closest_player = function_cbe26fa436f0eb74( var_cd7e11dc688992d4, self.origin );
        
        if ( isdefined( volume ) )
        {
            og_origin = volume.origin;
        }
        
        if ( isdefined( closest_player ) && distance2dsquared( closest_player.origin, og_origin ) < squared( 4000 ) )
        {
            self.ignoreall = 0;
            self.goalradius = 128;
            self setgoalentity( closest_player );
            wait 3;
            continue;
        }
        else
        {
            self.ignoreall = 1;
            self cleargoalentity();
            self setgoalpos( og_origin );
            self.goalradius = 2048;
        }
        
        wait 3;
    }
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 2, eflags: 0x4
// Checksum 0xaef6eae3, Offset: 0x5124
// Size: 0xe8
function private function_cbe26fa436f0eb74( var_cd7e11dc688992d4, pos )
{
    var_64bb57aa2d6e8b35 = teams::getsquaddata( var_cd7e11dc688992d4.team, var_cd7e11dc688992d4.sessionsquadid );
    alivemembers = [];
    
    foreach ( member in var_64bb57aa2d6e8b35.players )
    {
        if ( !player::isreallyalive( member ) || player::isinlaststand( member ) )
        {
            continue;
        }
        
        alivemembers[ alivemembers.size ] = member;
    }
    
    if ( alivemembers.size )
    {
        return function_47c86977a18df38b( alivemembers, pos );
    }
}

// Namespace ob_activity_sagittarius_sniper_boss
// Params 2, eflags: 0x4
// Checksum 0x286380ee, Offset: 0x5215
// Size: 0x8d
function private function_17ee39e3953c3bc3( ent, players )
{
    ent hide();
    
    foreach ( player in players )
    {
        ent showtoplayer( player );
    }
}

