// scripts\mp\mp_agent_damage.gsc  (hash_7af5dd2bc2cc926d.gscc) (size: 17312 Bytes / 0x43a0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3d08a0a7 (1023975591)
// size ...... 17312 (0x43a0)
// includes .. 25  (offset: 0x3d4c)
// strings ... 92  (offset: 0x3e14)
// dev strs .. 9   (offset: 0x4334)
// exports ... 21  (offset: 0x2ee4)
// cseg ...... 0x6c0 + 0x2824 (0x2ee4)
// imports ... 88  (offset: 0x322c)
// animtree1 . 0   (offset: 0x43a0)
// animtree2 . 0   (offset: 0x43a0)
#using script_3e14de319bce19ea;
#using scripts\common\script;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\weapon;
#using scripts\mp\challenges;
#using scripts\mp\common\equipment\battlerage;
#using scripts\mp\common\killstreaks\killstreaks;
#using scripts\mp\common\utility\damage;
#using scripts\mp\common\utility\damage_utility;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\common\utility\killstreak;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\points;
#using scripts\mp\common\utility\teams;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\common\utility\weapon_utility;
#using scripts\mp\damage;
#using scripts\mp\damage_numbers;
#using scripts\mp\damagefeedback;
#using scripts\mp\events;
#using scripts\mp\gamelogic;
#using scripts\mp\gamescore;
#using scripts\mp\rank;

#namespace mp_agent_damage;

// Namespace mp_agent_damage
// Params 0
// Checksum 0x4e67e7cb, Offset: 0x6de
// Size: 0xb2
function register_ai_damage_callbacks()
{
    level.agent_funcs[ "actor_enemy_lw_base_br" ][ "on_damaged" ] = &callbacksoldieragentdamaged;
    level.agent_funcs[ "actor_enemy_lw_base_br" ][ "gametype_on_damage_finished" ] = &callbacksoldieragentgametypedamagefinished;
    level.agent_funcs[ "actor_enemy_lw_base_br" ][ "gametype_on_killed" ] = &callbacksoldieragentgametypekilled;
    level.agent_funcs[ "actor_enemy_lw_base_juggernaut" ][ "on_damaged" ] = &callbacksoldieragentdamaged;
    level.agent_funcs[ "actor_enemy_lw_base_juggernaut" ][ "gametype_on_damage_finished" ] = &callbacksoldieragentgametypedamagefinished;
    level.agent_funcs[ "actor_enemy_lw_base_juggernaut" ][ "gametype_on_killed" ] = &callbacksoldieragentgametypekilled;
    level.var_74bfb03ca7119ccb = &damage::addattacker;
}

// Namespace mp_agent_damage
// Params 14
// Checksum 0x8edddecd, Offset: 0x798
// Size: 0x9eb
function callbacksoldieragentdamaged( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon, poisedamage )
{
    evictim = self;
    
    if ( !isdefined( evictim.agent_type ) )
    {
        return;
    }
    
    if ( !isdefined( objweapon ) )
    {
        objweapon = sweapon;
    }
    
    if ( smeansofdeath != "MOD_SUICIDE" )
    {
        if ( is_friendly_damage( evictim, einflictor ) )
        {
            /#
                if ( getdvarint( @"g_debugdamage" ) != 0 )
                {
                    println( "<dev string:x24>" );
                }
            #/
            
            return;
        }
    }
    
    if ( !isdefined( eattacker ) )
    {
        eattacker = evictim;
    }
    
    shoulddodamage = should_do_damage_checks( eattacker, idamage, smeansofdeath, sweapon, objweapon, shitloc, evictim );
    
    if ( !shoulddodamage )
    {
        /#
            if ( getdvarint( @"g_debugdamage" ) != 0 )
            {
                println( "<dev string:x38>" );
            }
        #/
        
        return;
    }
    
    idflags |= 4;
    initial_damage = idamage;
    weaponbasename = objweapon.basename;
    weaponclassname = objweapon.classname;
    issuicidebomber = is_suicide_bomber();
    isinlaststand = istrue( eattacker.inlaststand );
    ismeleedamage = smeansofdeath == "MOD_MELEE";
    bulletdamage = utility::isbulletdamage( smeansofdeath ) || smeansofdeath == "MOD_EXPLOSIVE_BULLET" && shitloc != "none";
    isplayerdamage = isplayer( eattacker );
    var_63b931cba592af5d = isplayer( eattacker.owner );
    isjuggernaut = evictim.unittype == "juggernaut";
    headshot = bulletdamage && damage_utility::isheadshot( shitloc, smeansofdeath, eattacker );
    isexplosive = smeansofdeath == "MOD_EXPLOSIVE_BULLET" && shitloc == "none" || smeansofdeath == "MOD_EXPLOSIVE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_GRENADE";
    isfire = smeansofdeath == "MOD_FIRE";
    var_d02a12175c48ec46 = isplayerdamage && isdefined( eattacker.perks[ "specialty_bulletdamage" ] );
    var_14a6204551bdcc5f = eattacker.classname == "script_vehicle" && isplayer( eattacker.owner );
    var_b9d7e6070dcd85ce = var_14a6204551bdcc5f && smeansofdeath == "MOD_CRUSH";
    var_142cad833433619a = eattacker.classname == "script_vehicle" && !isdefined( eattacker.owner );
    var_cd29b35ca8bc1897 = var_142cad833433619a && smeansofdeath == "MOD_CRUSH";
    
    if ( ( isplayerdamage || var_63b931cba592af5d ) && evictim.invulnerable && smeansofdeath != "MOD_SUICIDE" )
    {
        /#
            if ( getdvarint( @"g_debugdamage" ) != 0 )
            {
                println( "<dev string:x55>" );
            }
        #/
        
        return;
    }
    
    if ( isjuggernaut )
    {
        if ( ismeleedamage )
        {
            idamage = 0;
        }
        else
        {
            idamage *= 0.3;
            
            if ( weaponbasename == "thermite_ap_mp" || weaponbasename == "thermite_proj_cp" )
            {
                idamage *= 15;
            }
            
            if ( weaponbasename == "cruise_proj_mp" )
            {
                idamage = self.health + 1000;
            }
        }
        
        if ( var_b9d7e6070dcd85ce )
        {
            var_dcc842d12d61a0a7 = [ "atv" ];
            
            if ( arraycontains( var_dcc842d12d61a0a7, eattacker.vehiclename ) )
            {
                eattacker dodamage( 10000, eattacker.origin, evictim );
            }
            else
            {
                playsoundatpos( self.origin + ( 0, 0, 40 ), "gib_fullbody" );
                idamage = self.health + 1000;
            }
        }
    }
    else if ( isplayerdamage )
    {
        if ( weaponbasename == "throwingknife_mp" || weaponbasename == "shuriken_mp" || weaponbasename == "throwstar_mp" )
        {
            idamage = self.health + 1000;
        }
        
        if ( weaponbasename == "iw9_tur_light_tank_mp" && smeansofdeath == "MOD_PROJECTILE" )
        {
            idamage = self.health + 1000;
        }
    }
    
    if ( self.bhasriotshieldattached )
    {
        if ( shouldblockdamage( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon ) )
        {
            return;
        }
        
        if ( shitloc == "shield" && ( smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_PROJECTILE" ) && idamage > 175 )
        {
            idamage *= 0.05;
            shitloc = "torso_lower";
        }
    }
    
    if ( issuicidebomber )
    {
        if ( weaponbasename == "emp_drone_player_mp" )
        {
            idamage = self.health + 1000;
        }
    }
    
    if ( var_b9d7e6070dcd85ce )
    {
        playsoundatpos( self.origin + ( 0, 0, 40 ), "gib_fullbody" );
    }
    
    if ( var_cd29b35ca8bc1897 )
    {
        if ( self.invuln_to_veh_crush )
        {
            idamage = 0;
            evictim notify( #"veh_crush_damage", eattacker );
        }
    }
    
    if ( isplayerdamage )
    {
        evictim.damaged_by_player = 1;
        
        if ( headshot )
        {
            if ( isjuggernaut )
            {
                idamage = adjust_damage_based_on_weaponclass( idamage, sweapon, weaponclassname, smeansofdeath, eattacker );
            }
        }
        
        if ( var_d02a12175c48ec46 )
        {
            idamage *= 2;
        }
        
        if ( isexplosive )
        {
            increase = idamage * 2.5;
            
            if ( isdefined( level.explosivedamagemod ) )
            {
                increase *= level.explosivedamagemod;
            }
            
            idamage += increase;
        }
        
        if ( isfire )
        {
            idamage += idamage * 3.5;
        }
        
        if ( ismeleedamage && !isjuggernaut )
        {
            if ( evictim.immune_to_melee_damage )
            {
                idamage = 0;
                evictim notify( #"hash_40e58272473adac4", eattacker );
            }
            else
            {
                idamage = 150;
                
                if ( issubstr( weaponbasename, "iw8_knife_mp" ) )
                {
                    idamage = 350;
                }
                
                if ( issubstr( weaponbasename, "iw8_me_" ) )
                {
                    idamage = 350;
                }
                else if ( isdefined( objweapon.muzzle ) )
                {
                    if ( issubstr( objweapon.muzzle, "muzzlemelee" ) )
                    {
                        idamage = 350;
                    }
                    
                    if ( issubstr( objweapon.muzzle, "bayonet" ) )
                    {
                        idamage = 350;
                    }
                }
            }
        }
        
        if ( bulletdamage )
        {
            if ( !headshot )
            {
                if ( !isdefined( level.bullet_damage_scalar ) )
                {
                    level.bullet_damage_scalar = 1;
                }
                
                idamage *= level.bullet_damage_scalar;
            }
            
            idamage *= 1;
        }
    }
    
    if ( weaponbasename == "iw9_tur_light_tank_mp" && smeansofdeath == "MOD_PROJECTILE_SPLASH" )
    {
        idamage *= 2;
    }
    
    if ( isplayerdamage || var_63b931cba592af5d || var_b9d7e6070dcd85ce )
    {
        if ( isplayer( eattacker ) )
        {
            var_23646deaadab01d3 = int( min( idamage, self.health ) );
            damage::function_230e2a69150a8eb4( eattacker, var_23646deaadab01d3, idamage, undefined, objweapon, shitloc );
        }
        
        if ( isdefined( objweapon ) )
        {
            if ( var_63b931cba592af5d )
            {
                eattacker = eattacker.owner;
            }
            
            damage::addattacker( self, eattacker, einflictor, objweapon, idamage, vpoint, vdir, shitloc, timeoffset, smeansofdeath );
        }
        
        if ( idamage >= evictim.health )
        {
            if ( objweapon.basename == "none" )
            {
                if ( isdefined( einflictor ) && isdefined( einflictor.weapon_name ) )
                {
                    objweapon = makeweapon( einflictor.weapon_name );
                }
            }
            
            damage_info_struct = spawnstruct();
            damage_info_struct.einflictor = einflictor;
            damage_info_struct.eattacker = eattacker;
            damage_info_struct.idamage = idamage;
            damage_info_struct.idflags = idflags;
            damage_info_struct.smeansofdeath = smeansofdeath;
            damage_info_struct.sweapon = sweapon;
            damage_info_struct.vpoint = vpoint;
            damage_info_struct.vdir = vdir;
            damage_info_struct.shitloc = shitloc;
            damage_info_struct.timeoffset = timeoffset;
            damage_info_struct.modelindex = modelindex;
            damage_info_struct.partname = partname;
            damage_info_struct.objweapon = objweapon;
        }
    }
    
    /#
        weapon_utility::function_926700ffa3fbe9e( idamage, eattacker, evictim, smeansofdeath, shitloc, einflictor, vpoint );
    #/
    
    idamage = int( min( idamage, evictim.maxhealth ) );
    
    if ( is_flashbang( weaponbasename, objweapon, einflictor ) && smeansofdeath == "MOD_GRENADE_SPLASH" )
    {
        evictim notify( #"flashbang", shitloc, 1, undefined, eattacker, "allies" );
    }
    
    if ( is_gas( weaponbasename ) && smeansofdeath == "MOD_GRENADE_SPLASH" )
    {
        evictim notify( #"flashbang", shitloc, 1, undefined, eattacker, "allies" );
    }
    
    /#
        if ( getdvarint( @"g_debugdamage" ) != 0 && idamage != initial_damage )
        {
            println( "<dev string:x64>" + idamage );
        }
    #/
    
    if ( isdefined( evictim.unittype ) && isdefined( level.agent_funcs[ evictim.unittype ][ "on_damaged_finished" ] ) )
    {
        evictim [[ level.agent_funcs[ evictim.unittype ][ "on_damaged_finished" ] ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, 0, modelindex, partname, poisedamage );
        return;
    }
    
    assert( isdefined( level.agent_funcs[ evictim.agent_type ][ "<dev string:x78>" ] ) );
    evictim [[ level.agent_funcs[ evictim.agent_type ][ "on_damaged_finished" ] ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, 0, modelindex, partname, poisedamage );
}

// Namespace mp_agent_damage
// Params 0, eflags: 0x4
// Checksum 0xb87b3f4e, Offset: 0x118b
// Size: 0x42
function private function_878783e8b6805c95()
{
    if ( !isdefined( level.var_3663dbce801e78e5 ) )
    {
        level.var_3663dbce801e78e5 = 1;
        
        if ( isusingmatchrulesdata() )
        {
            level.var_3663dbce801e78e5 = getmatchrulesdata( "commonOption", "aiKilledScoreEventsEnabled" );
        }
    }
    
    return level.var_3663dbce801e78e5;
}

// Namespace mp_agent_damage
// Params 13
// Checksum 0x1f079ac4, Offset: 0x11d6
// Size: 0xed
function callbacksoldieragentgametypedamagefinished( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, stun_fraction, modelindex, partname )
{
    if ( smeansofdeath == "MOD_SUICIDE" )
    {
        return;
    }
    
    process_damage_feedback( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vdir, vdir, shitloc, timeoffset, self );
    idflags = 0;
    
    if ( !isdefined( self.painsound ) )
    {
        return;
    }
    
    if ( gettime() > self.next_dmg_sound )
    {
        if ( soundexists( self.painsound ) )
        {
            self playsound( self.painsound );
        }
        
        self.next_dmg_sound = gettime() + 500;
    }
}

// Namespace mp_agent_damage
// Params 9
// Checksum 0xbaf829dc, Offset: 0x12cb
// Size: 0xa86
function callbacksoldieragentgametypekilled( einflictor, eattacker, idamage, smeansofdeath, objweapon = nullweapon(), vdir, shitloc, timeoffset, deathanimduration )
{
    if ( isdefined( level.spawnloopupdatefunc ) )
    {
        [[ level.spawnloopupdatefunc ]]( eattacker, objweapon );
    }
    
    if ( smeansofdeath == "MOD_SUICIDE" || self.death_source == "despawn" )
    {
        return;
    }
    
    if ( self.marked_for_death )
    {
        self.marked_for_death = undefined;
    }
    
    if ( isdefined( self.death_info_func ) )
    {
        damage_info_struct = spawnstruct();
        damage_info_struct.einflictor = einflictor;
        damage_info_struct.eattacker = eattacker;
        damage_info_struct.idamage = idamage;
        damage_info_struct.smeansofdeath = smeansofdeath;
        damage_info_struct.sweapon = objweapon;
        damage_info_struct.vdir = vdir;
        damage_info_struct.shitloc = shitloc;
        damage_info_struct.timeoffset = timeoffset;
        damage_info_struct.deathanimduration = deathanimduration;
        thread [[ self.death_info_func ]]( damage_info_struct );
    }
    
    isplayerattacker = isplayer( eattacker );
    var_d0b99d52cabd7872 = isdefined( eattacker ) && isplayer( eattacker.owner );
    var_91a7e639160601bd = eattacker killstreak::isjuggernaut();
    iskillstreakweapon = weapon::iskillstreakweapon( objweapon.basename );
    isvehicleweapon = vehicle::isvehicleweapon( objweapon.basename );
    playerattacker = undefined;
    
    if ( isplayerattacker )
    {
        playerattacker = eattacker;
    }
    else if ( var_d0b99d52cabd7872 )
    {
        playerattacker = eattacker.owner;
    }
    
    if ( isdefined( playerattacker ) )
    {
        if ( isbrgamemode() && isdefined( level.contractmanager ) )
        {
            foreach ( contract in level.contractmanager.contractdata )
            {
                if ( isdefined( contract.funcs[ "onAIKilled" ] ) )
                {
                    foreach ( task in level.contractmanager.currenttasks )
                    {
                        if ( contract.ref == task.type.ref )
                        {
                            task [[ contract.funcs[ "onAIKilled" ] ]]( playerattacker, self );
                        }
                    }
                }
            }
        }
        
        weapongroup = weapon::getweapongroup( objweapon );
        
        if ( !level.disablestattracking )
        {
            if ( !level.var_495da479d5fbbec7 )
            {
                deathdata = spawnstruct();
                deathdata.hitloc = shitloc;
                playerattacker events::function_a2d92a4b5cb17d36( self, objweapon, weapongroup, smeansofdeath, einflictor, deathdata );
            }
            
            events::function_6c7ad7001bc34550( objweapon, smeansofdeath, einflictor );
            
            if ( level.supportsai )
            {
                thread challenges::onagentkilled( self, einflictor, playerattacker, idamage, smeansofdeath, objweapon, playerattacker.modifiers );
            }
            
            utility::callsharedfunc( #"persistent_missions", #"hash_e682e523b41a8ee2", self, playerattacker, objweapon );
            
            if ( isdefined( playerattacker.modifiers ) && playerattacker.modifiers[ "ads" ] )
            {
                playerattacker thread gamelogic_mp::threadedsetweaponstatbyname( objweapon, 1, "ai_ads_kills" );
            }
            
            if ( smeansofdeath == "MOD_HEAD_SHOT" || namespace_4c6ef5221f3fa284::function_5d96d2a079feb03a( shitloc ) )
            {
                playerattacker thread gamelogic_mp::threadedsetweaponstatbyname( objweapon, 1, "ai_headshots" );
            }
        }
        
        playerattacker thread updaterecentagentkills( self, einflictor, objweapon );
        playerattacker thread events::killedplayernotifysys( undefined, self, objweapon, smeansofdeath, weapongroup );
        level thread handle_death_sounds( playerattacker, self, smeansofdeath, shitloc );
        
        if ( !iskillstreakweapon && !isvehicleweapon && !isdefined( playerattacker.perks[ "specialty_explosivebullets" ] ) )
        {
            if ( level.var_dd30bf39c0753f31 )
            {
                playerattacker.var_3f98a27bd6d0f2b3 = 1;
                
                if ( smeansofdeath == "MOD_MELEE" || smeansofdeath == "MOD_MELEE_TAKEDOWN" )
                {
                    if ( playerattacker.modifiers[ "backstab" ] )
                    {
                        playerattacker thread points::doscoreevent( #"melee_backstab" );
                    }
                    else if ( objweapon.damagemodcategory != #"melee" )
                    {
                        playerattacker thread points::doscoreevent( #"gun_butt" );
                    }
                    else
                    {
                        playerattacker thread points::doscoreevent( #"melee" );
                    }
                }
                else if ( playerattacker.modifiers[ "headshot" ] )
                {
                    playerattacker thread points::doscoreevent( #"headshot" );
                }
                else if ( playerattacker.modifiers[ "gunbutt" ] )
                {
                    playerattacker thread points::doscoreevent( #"gun_butt" );
                }
                else
                {
                    playerattacker thread events::killeventtextpopup( #"kill", 0 );
                }
            }
            
            if ( !level.var_dd30bf39c0753f31 )
            {
                playerattacker thread events::killeventtextpopup( #"kill", 0 );
            }
            
            if ( level.agentskillstreakcount > 0 )
            {
                if ( !isdefined( playerattacker.pers[ "agentsKillstreakCount" ] ) )
                {
                    playerattacker.pers[ "agentsKillstreakCount" ] = 1;
                }
                else
                {
                    playerattacker.pers[ "agentsKillstreakCount" ]++;
                }
                
                if ( playerattacker.pers[ "agentsKillstreakCount" ] == level.agentskillstreakcount )
                {
                    if ( playerattacker player::isreallyalive() )
                    {
                        event = #"kill";
                        points = rank::getscoreinfovalue( event );
                        playerattacker killstreaks::givestreakpoints( event, 1, points );
                    }
                    
                    playerattacker.pers[ "agentsKillstreakCount" ] = 0;
                }
            }
            
            if ( isdefined( playerattacker.modifiers ) && function_878783e8b6805c95() && !playerattacker.var_3f98a27bd6d0f2b3 )
            {
                if ( playerattacker.modifiers[ "oneshotkill" ] )
                {
                    playerattacker thread points::doscoreevent( #"one_shot_kill" );
                }
                
                if ( playerattacker.modifiers[ "gunbutt" ] )
                {
                    playerattacker thread points::doscoreevent( #"gun_butt" );
                }
                
                if ( smeansofdeath == "MOD_MELEE" )
                {
                    if ( objweapon == level.defaultfist )
                    {
                        playerattacker thread points::doscoreevent( #"fist_kill" );
                    }
                }
                
                if ( playerattacker.modifiers[ "headshot" ] )
                {
                    playerattacker thread points::doscoreevent( #"headshot" );
                }
                
                if ( playerattacker.modifiers[ "pointblank" ] )
                {
                    playerattacker thread points::doscoreevent( #"pointblank" );
                }
                
                if ( playerattacker.modifiers[ "longshot" ] && !self.var_c847a8cac7b9ddc6 )
                {
                    playerattacker thread points::doscoreevent( #"longshot" );
                }
                
                if ( playerattacker.modifiers[ "backstab" ] )
                {
                    if ( objweapon.basename == "iw8_knife_mp" )
                    {
                        playerattacker thread points::doscoreevent( #"backstab" );
                    }
                }
                
                if ( playerattacker ismantling() )
                {
                    playerattacker thread points::doscoreevent( #"mantle_kill" );
                }
                
                if ( weapon::isthrowingknife( objweapon ) )
                {
                    playerattacker thread points::doscoreevent( #"throwingknife_kill" );
                }
                
                if ( playerattacker.modifiers[ "launcher_impact" ] )
                {
                    playerattacker thread points::doscoreevent( #"launcher_direct_hit" );
                }
            }
        }
        
        if ( isvehicleweapon && isdefined( playerattacker.vehicle ) && isdefined( playerattacker.vehicle.combo ) )
        {
            playerattacker thread points::doscoreevent( #"combo" );
        }
        
        if ( isdefined( self.attackers ) )
        {
            foreach ( player in self.attackers )
            {
                if ( !isdefined( damage::_validateattacker( player ) ) )
                {
                    continue;
                }
                
                if ( player == playerattacker )
                {
                    continue;
                }
                
                if ( self == player )
                {
                    continue;
                }
                
                if ( isdefined( level.assists_disabled ) )
                {
                    continue;
                }
                
                bonusmagnitude = 0;
                assistweapon = undefined;
                
                if ( isdefined( self.attackerdata ) )
                {
                    attackerdata = self.attackerdata[ player.guid ];
                    
                    if ( isdefined( attackerdata ) )
                    {
                        assistweapon = attackerdata.objweapon;
                    }
                    
                    if ( attackerdata.damage >= 35 )
                    {
                        bonusmagnitude = 1;
                    }
                    
                    if ( attackerdata.damage >= 70 )
                    {
                        bonusmagnitude = 2;
                    }
                }
                
                player thread gamescore::processassist( self, assistweapon, bonusmagnitude );
                
                if ( isdefined( player.super ) )
                {
                    if ( player.super.staticdata.ref == "super_battlerage" )
                    {
                        player battlerage::function_19efaee6fff21bf0();
                    }
                }
            }
        }
    }
    
    if ( smeansofdeath == "MOD_CRUSH" && isdefined( eattacker.classname ) && eattacker.classname == "script_vehicle" )
    {
        playsoundatpos( self.origin + ( 0, 0, 18 ), "vehicle_body_hit" );
    }
    
    if ( isdefined( level.removefromtargetmarkeronkillfunc ) )
    {
        level thread [[ level.removefromtargetmarkeronkillfunc ]]( self );
    }
    
    idflags = 0;
    process_damage_feedback( einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vdir, vdir, shitloc, timeoffset, self );
}

// Namespace mp_agent_damage
// Params 2
// Checksum 0x35d2d202, Offset: 0x1d59
// Size: 0x85, Type: bool
function is_friendly_damage( agent, attacker )
{
    if ( isdefined( attacker ) && isdefined( agent ) && isdefined( agent.team ) )
    {
        if ( attacker.team == agent.team )
        {
            return true;
        }
        
        if ( isdefined( attacker.owner ) && attacker.owner.team == agent.team )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace mp_agent_damage
// Params 7
// Checksum 0x36cf50da, Offset: 0x1de7
// Size: 0xd0, Type: bool
function should_do_damage_checks( eattacker, idamage, smeansofdeath, sweapon, objweapon, shitloc, victim )
{
    if ( !isdefined( sweapon ) )
    {
        return false;
    }
    else if ( eattacker != victim && isdefined( eattacker.team ) && eattacker.team == victim.team )
    {
        return false;
    }
    else if ( isdefined( level.should_do_damage_check_func ) && ![[ level.should_do_damage_check_func ]]( eattacker, idamage, smeansofdeath, sweapon, shitloc, victim ) )
    {
        return false;
    }
    else if ( utility::callsharedfunc( #"hash_f83d1f091b9a1e8e", #"isdefibrillator", objweapon ) )
    {
        return false;
    }
    
    return true;
}

// Namespace mp_agent_damage
// Params 0
// Checksum 0x633c9b69, Offset: 0x1ec0
// Size: 0x11, Type: bool
function is_suicide_bomber()
{
    return self.unittype == "suicidebomber";
}

// Namespace mp_agent_damage
// Params 5
// Checksum 0xf5eadcdd, Offset: 0x1eda
// Size: 0xf3
function adjust_damage_based_on_weaponclass( idamage, sweapon, weaponclass, type, attacker )
{
    modifieddamage = idamage;
    
    switch ( weaponclass )
    {
        case #"hash_8cdaf2e4ecfe5b51":
            modifieddamage = min( idamage, 84 );
            break;
        case #"hash_900cb96c552c5e8e":
            modifieddamage = min( idamage, 110 );
            break;
        case #"hash_fa24dff6bd60a12d":
            modifieddamage = min( idamage, 105 );
            break;
        case #"hash_690c0d6a821b42e":
            modifieddamage = min( idamage, 84 );
            break;
        case #"hash_719417cb1de832b6":
            modifieddamage = min( idamage, 75 );
            break;
        case #"hash_6191aaef9f922f96":
            modifieddamage = min( idamage, 130 );
            break;
        default:
            modifieddamage = idamage;
            break;
    }
    
    return idamage;
}

// Namespace mp_agent_damage
// Params 3
// Checksum 0x4d3f5cc6, Offset: 0x1fd6
// Size: 0x26, Type: bool
function is_flashbang( weaponname, objweapon, inflictor )
{
    return weaponname == "flash_grenade_mp";
}

// Namespace mp_agent_damage
// Params 1
// Checksum 0x61eb1b7b, Offset: 0x2005
// Size: 0x14, Type: bool
function is_gas( weaponname )
{
    return weaponname == "gas_mp";
}

// Namespace mp_agent_damage
// Params 4
// Checksum 0x9f9e61b, Offset: 0x2022
// Size: 0x120
function handle_death_sounds( attacker, victim, smeansofdeath, shitloc )
{
    if ( isdefined( victim.deathsound ) && soundexists( victim.deathsound ) )
    {
        playsoundatpos( victim.origin, victim.deathsound );
    }
    
    ent = victim;
    
    if ( smeansofdeath == "MOD_HEAD_SHOT" || namespace_4c6ef5221f3fa284::function_5d96d2a079feb03a( shitloc ) )
    {
        ent playsoundtoplayer( "bullet_impact_headshot_npc", attacker );
        ent playsoundtoteam( "bullet_impact_headshot", attacker.team, attacker );
        ent playsoundtoplayer( "mp_headshot_alert", attacker );
        return;
    }
    
    if ( smeansofdeath == "MOD_MELEE" )
    {
        ent playsoundtoplayer( "mp_kill_alert_quiet", attacker );
        return;
    }
    
    if ( isdefined( ent.animsetname ) && ent.animsetname == "robodog" )
    {
        ent playsoundtoplayer( "mp_kill_alert_robodog", attacker );
        return;
    }
    
    ent playsoundtoplayer( "mp_kill_alert", attacker );
}

// Namespace mp_agent_damage
// Params 11
// Checksum 0xe518dec7, Offset: 0x214a
// Size: 0x6c2
function process_damage_feedback( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, victim )
{
    var_32a2e26fe0e47bec = isdefined( eattacker ) && isdefined( eattacker.classname ) && isdefined( eattacker.classname ) && !isdefined( eattacker.gunner ) && ( eattacker.classname == "script_vehicle" || eattacker.classname == "misc_turret" || eattacker.classname == "script_model" );
    damager = undefined;
    
    if ( var_32a2e26fe0e47bec && isdefined( eattacker.gunner ) )
    {
        damager = eattacker.gunner;
    }
    else if ( isdefined( eattacker ) && isdefined( eattacker.owner ) )
    {
        damager = eattacker.owner;
    }
    else
    {
        damager = eattacker;
    }
    
    isbulletdamage = utility::isbulletdamage( smeansofdeath );
    typehit = isbulletdamage && weapon::isprimaryweapon( sweapon ) ? "standardspread" : "standard";
    bypass_armor = 0;
    
    if ( isdefined( eattacker ) && eattacker.class == "engineer" )
    {
        if ( isdefined( smeansofdeath ) && utility::isbulletdamage( smeansofdeath ) )
        {
            bypass_armor = 1;
        }
    }
    
    if ( isdefined( damager ) && damager != victim && idamage > 0 && shitloc != "shield" )
    {
        waskilled = !isalive( victim ) || isagent( victim ) && idamage >= victim.health;
        
        if ( victim.isjuggernaut )
        {
            if ( victim.isjuggernautrecon )
            {
                typehit = "hitjuggernautrecon";
            }
            else
            {
                typehit = "hitjuggernaut";
            }
        }
        else if ( idflags & 16 )
        {
            typehit = "stun";
        }
        else if ( damage::istacticaldamage( sweapon, smeansofdeath ) && isdefined( victim.perks[ "specialty_stun_resistance" ] ) )
        {
            typehit = "hittacresist";
        }
        else if ( isexplosivedamagemod( smeansofdeath ) && isdefined( victim.perks[ "specialty_blastshield" ] ) && ![[ utility::getsharedfunc( #"specialty_blastshield", #"hash_4caa4d716053e6b8" ) ]]( eattacker, victim, sweapon, smeansofdeath, einflictor, shitloc ) )
        {
            typehit = "hitblastshield";
        }
        else if ( isdefined( victim.perks[ "specialty_pistoldeath" ] ) && isdefined( victim.inlaststand ) && victim.inlaststand == 1 && !victim.hasshownlaststandicon )
        {
            victim.hasshownlaststandicon = 1;
            typehit = "hitlaststand";
        }
        
        if ( victim.focus_fire_attackers.size > 1 )
        {
            typehit = "cp_relic_buff";
        }
        
        hitmarkertype = "standard";
        weapclass = weaponclass( sweapon );
        isspreadweapon = weapclass == "spread";
        headshot = !isspreadweapon && damage_utility::isheadshot( shitloc, smeansofdeath, eattacker );
        allowdamagefeedback = 1;
        suppressaudio = smeansofdeath == "MOD_MELEE";
        timestring = "" + gettime();
        
        if ( isdefined( damager.pelletdmg[ timestring ] ) && !suppressaudio && isspreadweapon && damager.pelletdmg[ timestring ][ victim.guid ] > 1 )
        {
            if ( waskilled )
            {
                suppressaudio = 1;
            }
            else
            {
                allowdamagefeedback = 0;
            }
        }
        
        killingblow = undefined;
        
        if ( victim.health <= idamage )
        {
            killingblow = 1;
        }
        
        headshot = damage_utility::isheadshot( shitloc, smeansofdeath, eattacker );
        
        if ( killingblow )
        {
            if ( isdefined( eattacker ) )
            {
                if ( isplayer( eattacker.owner ) )
                {
                    if ( function_878783e8b6805c95() )
                    {
                        eattacker.owner thread points::doscoreevent( #"kill", sweapon, undefined, undefined, self, undefined, undefined, 1, undefined, 1 );
                    }
                }
                else if ( isplayer( eattacker ) )
                {
                    xpoverride = undefined;
                    
                    if ( isdefined( self.bossname ) )
                    {
                        bossxp = getdvarint( hashcat( @"hash_d3efda60f4581524", self.bossname ), 0 );
                        
                        if ( bossxp > 0 )
                        {
                            xpoverride = bossxp;
                        }
                        else
                        {
                            xpoverride = getdvarint( @"hash_dfcad66b7ba8da13", 500 );
                        }
                    }
                    
                    if ( function_878783e8b6805c95() && !eattacker.var_3f98a27bd6d0f2b3 )
                    {
                        eattacker thread points::doscoreevent( #"kill", sweapon, undefined, xpoverride, self, undefined, undefined, 1, undefined, 1 );
                    }
                    
                    if ( isdefined( self.bossname ) && isdefined( eattacker.team ) && game_utility::function_ee6c5a6c2de518e1() )
                    {
                        foreach ( player in teams::getteamdata( eattacker.team, "players" ) )
                        {
                            if ( isdefined( player ) )
                            {
                                if ( player != eattacker && function_878783e8b6805c95() )
                                {
                                    player thread points::doscoreevent( #"kill", undefined, undefined, xpoverride, self, undefined, undefined, 1, undefined, 1 );
                                }
                                
                                if ( !isdefined( player.bossxp ) )
                                {
                                    player.bossxp = 0;
                                }
                                
                                player.bossxp += xpoverride;
                            }
                        }
                    }
                    
                    if ( smeansofdeath == "MOD_EXECUTION" )
                    {
                        eattacker thread points::doscoreevent( #"execution" );
                    }
                }
            }
        }
        
        if ( allowdamagefeedback )
        {
            if ( isdefined( eattacker ) )
            {
                if ( isdefined( eattacker.owner ) )
                {
                    eattacker.owner thread damagefeedback::updatedamagefeedback( typehit, killingblow, headshot );
                }
                else
                {
                    eattacker thread damagefeedback::updatedamagefeedback( typehit, killingblow, headshot );
                }
            }
        }
    }
    
    if ( isdefined( level.var_9a456b714194b2d9 ) && isdefined( eattacker ) )
    {
        if ( isdefined( eattacker.owner ) )
        {
            eattacker = eattacker.owner;
        }
        
        level [[ level.var_9a456b714194b2d9 ]]( eattacker, victim );
    }
}

// Namespace mp_agent_damage
// Params 13
// Checksum 0x3ef66e12, Offset: 0x2814
// Size: 0x429, Type: bool
function shouldblockdamage( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon )
{
    weaponbasename = objweapon.basename;
    bthermite = 0;
    
    if ( isdefined( einflictor ) && ( issubstr( weaponbasename, "thermite" ) || isdefined( einflictor.weapon_name ) && issubstr( einflictor.weapon_name, "incendiary" ) ) )
    {
        bthermite = 1;
        bhitshield = shitloc == "shield";
        
        if ( bhitshield )
        {
            contents = trace::create_character_contents();
            dirnormalized = vectornormalize( vdir );
            startpos = vpoint - dirnormalized * 12;
            endpos = vpoint + dirnormalized * 12;
            results = trace::ray_trace_detail( startpos, endpos, undefined, contents );
            
            if ( results[ "fraction" ] > 0 && results[ "fraction" ] < 1 )
            {
                metopoint = vpoint - self.origin;
                metopoint = ( metopoint[ 0 ], metopoint[ 1 ], 0 );
                
                if ( vectordot( metopoint, results[ "normal" ] ) < 0 )
                {
                    bhitshield = 0;
                }
            }
            else
            {
                bhitshield = 0;
            }
        }
        
        if ( bhitshield )
        {
            parent = einflictor getlinkedparent();
            
            if ( parent == self )
            {
                self.bhasthermitestucktoshield = 1;
                self.thermitestuckpains = 0;
            }
        }
        else if ( shitloc != "none" )
        {
            self.bhasthermitestucktoshield = 0;
            self.thermitestuckpains = undefined;
        }
    }
    
    if ( shitloc == "shield" )
    {
        if ( bthermite )
        {
            /#
                if ( getdvarint( @"g_debugdamage" ) != 0 )
                {
                    println( "<dev string:x8c>" );
                }
            #/
            
            return true;
        }
    }
    else if ( shitloc == "none" && isdefined( einflictor ) )
    {
        inflictorparent = einflictor getlinkedparent();
        
        if ( self.bhasthermitestucktoshield && bthermite && inflictorparent == self )
        {
            if ( !isdefined( self.thermitestucktoshield ) )
            {
                self.thermitestucktoshield = [ einflictor ];
            }
            else if ( !arraycontains( self.thermitestucktoshield, einflictor ) )
            {
                self.thermitestucktoshield[ self.thermitestucktoshield.size ] = einflictor;
            }
            
            assert( isdefined( self.thermitestuckpains ) );
            
            /#
                if ( getdvarint( @"g_debugdamage" ) != 0 )
                {
                    println( "<dev string:xa5>" );
                }
            #/
            
            self.thermitestuckpains++;
            return true;
        }
        else if ( issubstr( weaponbasename, "molotov" ) )
        {
            var_eeed8d3785de8f69 = einflictor.origin - self.origin;
            var_f7808546b9e756bf = vectornormalize( ( var_eeed8d3785de8f69[ 0 ], var_eeed8d3785de8f69[ 1 ], 0 ) );
            var_eeed8d3785de8f69 = vectornormalize( var_eeed8d3785de8f69 );
            
            if ( vectordot( anglestoforward( self.angles ), var_f7808546b9e756bf ) > 0.5 && -0.98 < var_eeed8d3785de8f69[ 2 ] && var_eeed8d3785de8f69[ 2 ] < 0.98 )
            {
                /#
                    if ( getdvarint( @"g_debugdamage" ) != 0 )
                    {
                        println( "<dev string:xc2>" );
                    }
                #/
                
                return true;
            }
        }
    }
    
    if ( smeansofdeath == "MOD_MELEE" )
    {
        if ( isdefined( eattacker ) )
        {
            metodamage = vectornormalize( eattacker.origin - self.origin );
        }
        else
        {
            metodamage = vectornormalize( vpoint - self.origin );
        }
        
        meforward = anglestoforward( self.angles );
        
        if ( vectordot( meforward, metodamage ) > 0.5 )
        {
            /#
                if ( getdvarint( @"g_debugdamage" ) != 0 )
                {
                    println( "<dev string:xe3>" );
                }
            #/
            
            return true;
        }
    }
    
    return false;
}

// Namespace mp_agent_damage
// Params 0
// Checksum 0xc8548eb9, Offset: 0x2c46
// Size: 0x8
function function_dc9f82a74577dbd9()
{
    return damage_numbers::is_enabled();
}

// Namespace mp_agent_damage
// Params 0
// Checksum 0x9f43afe9, Offset: 0x2c57
// Size: 0x35, Type: bool
function function_e257c518b45c4dbb()
{
    return isdefined( level.gamemodebundle ) && level.gamemodebundle.var_86012212da7b0935 || getdvarint( @"hash_550484f2b30cf121", 0 );
}

// Namespace mp_agent_damage
// Params 0
// Checksum 0xd1607f28, Offset: 0x2c95
// Size: 0x35, Type: bool
function function_e7d118eb7b017fa4()
{
    return isdefined( level.gamemodebundle ) && level.gamemodebundle.var_7e288d244d3717ca || getdvarint( @"hash_1661f35e34f544eb", 0 );
}

// Namespace mp_agent_damage
// Params 15
// Checksum 0x44e4d04e, Offset: 0x2cd3
// Size: 0xc5
function function_eb8ba16055d6da7c( eattacker, etargethit, shitloc, smeansofdeath, sweapon, idamage, vpoint, isimmnue, selement, biscritical, var_4f9d5587bf9a2b1e, var_cd5368faab079fc8 = undefined, var_453f10fe0cab5896 = 0, einflictor = undefined, stype = undefined )
{
    damage_numbers::display( eattacker, etargethit, shitloc, smeansofdeath, sweapon, idamage, vpoint, isimmnue, selement, biscritical, var_4f9d5587bf9a2b1e, var_cd5368faab079fc8, var_453f10fe0cab5896, einflictor, stype );
}

// Namespace mp_agent_damage
// Params 7
// Checksum 0x772b3aa4, Offset: 0x2da0
// Size: 0x53
function function_2b26b84aa6ce249c( player, var_a709140543061007, idamage, vpoint, ielement, itype, var_bbc055a93d3b130b )
{
    damage_numbers::display_direct( player, var_a709140543061007, idamage, vpoint, ielement, itype, var_bbc055a93d3b130b );
}

// Namespace mp_agent_damage
// Params 3
// Checksum 0x1365f3cd, Offset: 0x2dfb
// Size: 0xe9
function updaterecentagentkills( victim, einflictor, objweapon )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self notify( #"hash_2116b2ff90ba9645" );
    self endon( #"hash_2116b2ff90ba9645" );
    
    if ( !isdefined( self.var_eaf5be39c4590dd ) )
    {
        self.var_eaf5be39c4590dd = 0;
    }
    
    self.var_eaf5be39c4590dd++;
    var_bda53394c108f2e = undefined;
    
    if ( isdefined( objweapon ) )
    {
        if ( objweapon.basename == "none" )
        {
            if ( isdefined( einflictor ) && isdefined( einflictor.weapon_name ) )
            {
                var_bda53394c108f2e = einflictor.weapon_name;
            }
        }
        else
        {
            var_bda53394c108f2e = getcompleteweaponname( objweapon );
        }
    }
    
    script::bufferednotify( "update_rapid_agent_kill_buffered", self.var_eaf5be39c4590dd, var_bda53394c108f2e );
    wait 4;
    self.var_eaf5be39c4590dd = 0;
}

