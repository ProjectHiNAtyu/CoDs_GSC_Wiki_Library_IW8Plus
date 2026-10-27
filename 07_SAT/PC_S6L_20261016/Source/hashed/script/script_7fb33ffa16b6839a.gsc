// script_7fb33ffa16b6839a  (hash_7fb33ffa16b6839a.gscc) (size: 24639 Bytes / 0x603f / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xd11204 (13701636)
// size ...... 24639 (0x603f)
// includes .. 22  (offset: 0x56a7)
// strings ... 132 (offset: 0x5757)
// dev strs .. 5   (offset: 0x6003)
// exports ... 20  (offset: 0x44af)
// cseg ...... 0x8d4 + 0x3bdb (0x44af)
// imports ... 98  (offset: 0x47cf)
// animtree1 . 0   (offset: 0x603f)
// animtree2 . 0   (offset: 0x603f)
#using scripts\common\ae_utility;
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\status_effects\status_effects;
#using scripts\common\throttle;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\weapon;
#using scripts\mp\ai\ai_category;
#using scripts\mp\ammomods\ammo_mod;
#using scripts\mp\armor;
#using scripts\mp\challenges;
#using scripts\mp\class;
#using scripts\mp\common\utility\damage;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\weapon;
#using scripts\mp\crossbow;
#using scripts\mp\dragonsbreath;
#using scripts\mp\events;
#using scripts\mp\gameplay_telemetry;
#using scripts\mp\weapons;

#namespace zombie_shared_challenges;

// Namespace zombie_shared_challenges
// Params 0, eflags: 0x1
// Checksum 0x17f35fcc, Offset: 0x8f2
// Size: 0xc
function autoexec main()
{
    level.var_2bcb353fe65f5ebd = {};
}

// Namespace zombie_shared_challenges
// Params 5
// Checksum 0xda78fe1a, Offset: 0x906
// Size: 0x7fc
function function_e7dd3022963df094( attacker, inflictor, weapon, meansofdeath, victimstruct = undefined )
{
    if ( !isdefined( victimstruct ) )
    {
        victimstruct = {};
    }
    
    victimstruct.subclass = self.subclass;
    victimstruct.aicategory = self.aicategory;
    victimstruct.origin = self.origin;
    victimstruct.angles = self.angles;
    victimstruct.var_facda4eb36c515c8 = self.var_facda4eb36c515c8;
    victimstruct.tesla_storm_stunned = self.tesla_storm_stunned;
    victimstruct.frost_blast_active = self.frost_blast_kill;
    victimstruct.energy_mine_kill = utility::ent_flag( "energy_mine_kill" );
    victimstruct.mary_paris_kill = utility::ent_flag( "mary_paris_kill" );
    victimstruct.cyclone_kill = utility::ent_flag( "cyclone_kill" ) || self.var_2bd1a7d96fc4b2c5;
    victimstruct.killed_by_dark_flare = self.killed_by_dark_flare;
    victimstruct.napalm_burned = utility::ent_flag( "napalm_burned" );
    victimstruct.cryofreeze_active = utility::ent_flag( "cryofreeze_active" );
    victimstruct.deadwire_active = utility::ent_flag( "deadwire_stun_kill" ) || utility::ent_flag( "deadwire_stunned" );
    victimstruct.shadowvortex_active = self.shadow_vortex_killed;
    victimstruct.shatterbast_active = self.killed_by_shatterblast;
    victimstruct.brainrot_active = isdefined( self.var_bd22ba6c600a23a3 );
    victimstruct.fireworks_active = utility::ent_flag( "fw_damage" );
    victimstruct.ent_flag_struct = {};
    victimstruct.ent_flag_struct.ent_flag = self.ent_flag;
    victimstruct.team = self.team;
    victimstruct.var_f142682e078001d1 = weapons::isstunnedorblinded();
    
    if ( utility::issharedfuncdefined( #"zombie", #"hash_d7f49b93c0ea3526" ) )
    {
        victimstruct.var_f142682e078001d1 = victimstruct.var_f142682e078001d1 || utility::getsharedfunc( #"zombie", #"hash_d7f49b93c0ea3526" );
    }
    
    victimstruct.type = self.type;
    victimstruct.unittype = self.unittype;
    victimstruct.var_d3a7b3f093df2ff1 = self.var_d3a7b3f093df2ff1;
    victimstruct.var_e26538d32bf084ea = gettime();
    victimstruct.a_n_player_damage = self.a_n_player_damage;
    victimstruct.var_5a2b7510798c980b = self.var_5a2b7510798c980b;
    victimstruct.last_dmg_struct = self.last_dmg_struct;
    victimstruct.var_1480bf6f03b7e0be = self.var_1480bf6f03b7e0be;
    victimstruct.status_effect_cold = status_effects::function_e947cf9a9f176b2e( "slow", "cold" );
    victimstruct.status_effect_burn = status_effects::function_e947cf9a9f176b2e( "burn", "fire" );
    victimstruct.status_effect_electrical = status_effects::function_e947cf9a9f176b2e( "stun", "electrical" );
    victimstruct.var_8a1185d821a93b21 = self.var_8a1185d821a93b21;
    victimstruct.var_2b0a191e23e4d460 = utility::function_9f2c41c1dcc8c94( #"blackhole_pulled", #"blackhole_pulled_on" );
    victimstruct.var_f1daab3ca831723 = self.var_f1daab3ca831723;
    victimstruct.var_7ff4a6a3ceadd15e = self.var_7ff4a6a3ceadd15e;
    victimstruct.var_81b406cea4293e1d = self.var_81b406cea4293e1d;
    victimstruct.lastsnapshotgrenadetime = self.lastsnapshotgrenadetime;
    victimstruct.in_smoke_grenade = self.in_smoke_grenade;
    victimstruct.target_attractor = self.target_attractor;
    victimstruct.var_a8e9ab5fba96d982 = self.var_a8e9ab5fba96d982;
    victimstruct.var_6b1845284e358d3e = self.var_6b1845284e358d3e;
    victimstruct.var_1ea85eb65d2a34e = status_effects::function_fa35fc2723e956eb( "slow", "drillgun_sonic_pulse_slow" );
    victimstruct.electric_cherry_kill = self.electric_cherry_kill;
    victimstruct.var_c13640c265c43c23 = self.var_c13640c265c43c23;
    victimstruct.napalmburst_incendiary_burnt = self.napalmburst_incendiary_burnt;
    victimstruct.var_3a889a3334c81c31 = isent( inflictor ) ? inflictor getlinkedparent() : undefined;
    victimstruct.weapon_basenamehash = weapon.basenamehash;
    victimstruct.var_7f8f0ee3e5799bcc = self.last_dmg_struct.objweapon.var_1616e6fbba9a722d;
    victimstruct.var_443189a33694d681 = status_effects::function_fa35fc2723e956eb( "stun", "electric_cherry" );
    victimstruct.killed_by_melee_macchiato = self.killed_by_melee_macchiato;
    victimstruct.killed_by_phd_flopper = self.killed_by_phd_flopper;
    victimstruct.killed_by_phd_slider = self.killed_by_phd_slider;
    victimstruct.var_c513c9032dfc2f0d = self.var_c513c9032dfc2f0d;
    victimstruct.var_cda6c8bc587acedf = self.var_cda6c8bc587acedf;
    victimstruct.var_2259f0a89be4759f = self.var_2259f0a89be4759f;
    victimstruct.var_455a1156e4873285 = self.var_455a1156e4873285;
    victimstruct.var_56d69f6ef35661b0 = self.var_56d69f6ef35661b0;
    victimstruct.killed_by_jumppad = utility::ent_flag( "ft_jp_kill" );
    victimstruct.var_d1bd56975b2c12be = utility::ent_flag( "dinj_lifedrain_kill" );
    victimstruct.var_a00e421c491cccb3 = isagent( attacker ) && isplayer( attacker.var_fb2e0070ae6f04e4 ) || isplayer( self.var_fb2e0070ae6f04e4 );
    victimstruct.var_dd22e69947766504 = self.var_dd22e69947766504;
    victimstruct.difficulty = self.difficulty;
    victimstruct.emp_grenade_tracker = self.emp_grenade_tracker;
    victimstruct.var_406b99690f112c = self.var_406b99690f112c;
    victimstruct.debuffinfo = self.debuffinfo;
    victimstruct.napalmburst_proc_weapon = self.napalmburst_proc_weapon;
    
    if ( victimstruct.weapon_basenamehash == %"rcxd" && meansofdeath == "MOD_UNKNOWN" )
    {
        victimstruct.var_592c67bb7c3220ba = 1;
    }
    
    victimstruct.var_b52498c11832e4ea = self.var_8bf8675d01bdec8b;
    victimstruct.var_96527d1d3c7cdb7e = self.var_96527d1d3c7cdb7e;
    victimstruct.var_b57d118f387faec7 = self.var_b57d118f387faec7;
    victimstruct.var_1229e9bf5e1e066e = self.var_cc997278e6e6e01[ "super_mega_jump" ];
    victimstruct.var_dcf8da1beef94913 = self.var_dcf8da1beef94913;
    victimstruct.var_c178d7c040cef582 = self._blackboard.var_79b2d8d61c6ef8b1;
    victimstruct.b_glocke_drop_floating = isdefined( self.var_a2dfc645220488d );
    
    if ( isplayer( attacker ) && attacker.var_3bf72dcd2775aa78 == weapon )
    {
        victimstruct.var_81b4cdec2f289400 = 1;
    }
    
    victimstruct.var_9908bb4c86f01f8f = function_b23fb0c74ffd6362( attacker );
    victimstruct.var_31bef6a9b871492e = inflictor.subclass == "zombie_methone" && meansofdeath == "MOD_EXPLOSIVE";
    return victimstruct;
}

// Namespace zombie_shared_challenges
// Params 0
// Checksum 0x651f9835, Offset: 0x110b
// Size: 0xc
function function_6856007c45873b25()
{
    self.var_8bf8675d01bdec8b = undefined;
}

// Namespace zombie_shared_challenges
// Params 0
// Checksum 0x3493cb58, Offset: 0x111f
// Size: 0x52
function function_4ad0ff93baeb9d8()
{
    self notify( #"hash_564aae42e98eb6b2" );
    self endon( #"hash_564aae42e98eb6b2" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    wait 0.1;
    
    if ( !self )
    {
        return;
    }
    
    self.var_a680cce7c744e61d = 0;
    self.var_45a4ac1d19aac911 = [];
}

// Namespace zombie_shared_challenges
// Params 4
// Checksum 0x8fe00ac2, Offset: 0x1179
// Size: 0x1d2b
function function_814eb8fe3432a1ca( victimstruct, objweapon, meansofdeath, inflictor )
{
    if ( !isdefined( level.var_f2fe63a22820fc3d ) )
    {
        level.var_f2fe63a22820fc3d = [ "hit_loc":0, "attachment_flags":0, "mask5":0, "mask4":0, "mask3":0, "mask2":0, "mask":0 ];
    }
    
    self.modifiers = arraycopy( level.var_f2fe63a22820fc3d );
    weapongroup = weapon::getweapongroup( objweapon );
    deathdata = {};
    callback::callback( #"hash_2709fd1dd4cef88d", { #deathdata:deathdata, #inflictor:inflictor, #meansofdeath:meansofdeath, #weapongroup:weapongroup, #objweapon:objweapon, #victim:victimstruct } );
    curtime = gettime();
    var_1819ea4dc4ef3a41 = {};
    
    if ( !isdefined( level.playerChallengesOnAgentAiKilled_throttle ) )
    {
        level.playerChallengesOnAgentAiKilled_throttle = throttle::throttle_initialize( "playerChallengesOnAgentAiKilled_throttle", 1 );
    }
    
    throttle::throttle_wait_in_queue( level.playerChallengesOnAgentAiKilled_throttle, var_1819ea4dc4ef3a41 );
    
    if ( isweapon( objweapon ) && !weapon::iskillstreakweapon( objweapon ) && isplayer( self ) )
    {
        attackerisinflictor = events::attackerisinflictor( self, inflictor, objweapon, meansofdeath );
        attackervelocity = self getvelocity();
        var_13ceed07351526e8 = vectornormalize( attackervelocity );
        var_2bf59c61b6d17e33 = anglestoforward( self getplayerangles() );
        var_f4061506239fc0bd = vectordot( var_2bf59c61b6d17e33, var_13ceed07351526e8 );
        var_7c42446588b35c76 = length2dsquared( attackervelocity );
        
        if ( isdefined( victimstruct.attackerposition ) )
        {
            attackerposition = victimstruct.attackerposition;
        }
        else
        {
            attackerposition = self.origin;
        }
        
        if ( isdefined( attackervelocity ) )
        {
            if ( attackervelocity[ 0 ] != 0 || attackervelocity[ 1 ] != 0 || attackervelocity[ 2 ] != 0 )
            {
                self.modifiers[ "moving_kill" ] = 1;
                self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"moving_kill" ) );
            }
        }
        
        isbulletdamage = utility::isbulletdamage( meansofdeath );
        ismeleedamage = utility::ismeleedamage( meansofdeath );
        
        if ( ( isbulletdamage || ismeleedamage ) && isdefined( var_f4061506239fc0bd ) && isdefined( var_7c42446588b35c76 ) )
        {
            if ( abs( var_f4061506239fc0bd ) < 0.8 && var_7c42446588b35c76 > 50 )
            {
                self.modifiers[ "strafing_kill" ] = 1;
                self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"strafing_kill" ) );
            }
        }
        
        if ( meansofdeath == "MOD_EXECUTION" )
        {
            self.modifiers[ "execution" ] = 1;
            self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"execution" ) );
        }
        
        if ( !( isdefined( objweapon ) && isdefined( objweapon.basename ) ) || objweapon.basename == "none" )
        {
            return;
        }
        
        if ( function_75bc0d7afac9c681( victimstruct, objweapon, meansofdeath, curtime, weapongroup ) )
        {
            self.modifiers[ "oneshotkill" ] = 1;
            self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"1shot1kill" ) );
        }
        
        if ( meansofdeath == "MOD_MELEE" || meansofdeath == "MOD_MELEE_TAKEDOWN" )
        {
            self.modifiers[ "melee" ] = 1;
            self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"melee" ) );
            
            if ( weapongroup != "weapon_melee" && weapongroup != "weapon_melee2" )
            {
                self.modifiers[ "gunbutt" ] = 1;
                self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"gunbutt" ) );
            }
        }
        
        if ( meansofdeath != "MOD_GRENADE" && meansofdeath == "MOD_HEAD_SHOT" )
        {
            self.modifiers[ "headshot" ] = 1;
            self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"headshot" ) );
        }
        
        if ( !self isnightvisionon() )
        {
            self.modifiers[ "withoutnvgs" ] = 1;
            self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"withoutnvgs" ) );
        }
        
        if ( attackerisinflictor )
        {
            var_cf0ff034c880563a = events::getshotdistancetype( self, objweapon, meansofdeath, attackerposition, victimstruct.origin );
            killdist = math::round_float( distance( attackerposition, victimstruct.origin ) / 39.37, 2 );
            gameplay_telemetry::function_f98fbe3bbb2ed9f1( "lastKillRange", undefined, killdist, 0 );
            
            switch ( var_cf0ff034c880563a )
            {
                case #"hash_e1ae7daca67ccc55":
                    self.modifiers[ "pointblank" ] = 1;
                    self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"shortrange" ) );
                    break;
                case #"hash_bbddd8225d923d3":
                    self.modifiers[ "longshot" ] = 1;
                    self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"longrange" ) );
                    self setclientomnvar( "ui_longshot_dist", killdist );
                    self setclientomnvar( "ui_longshot_special", events::islongshotspecial( attackerposition, victimstruct.origin, objweapon ) );
                    break;
                case #"hash_4364fa08acd17954":
                    self.modifiers[ "longshot" ] = 1;
                    self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"longrange" ) );
                    self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"verylongrange" ) );
                    self.modifiers[ "very_longshot" ] = 1;
                    self setclientomnvar( "ui_longshot_dist", killdist );
                    self setclientomnvar( "ui_longshot_special", events::islongshotspecial( attackerposition, victimstruct.origin, objweapon ) );
                    break;
            }
            
            if ( self.focusbreath || self.lastshotfiredtime == self.var_1395863480400423 && curtime - self.var_c06462955efc0a91 <= 6000 )
            {
                self.modifiers[ "holdingbreath" ] = 1;
                self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"holdbreath" ) );
            }
            
            if ( class::isweaponsilenced( objweapon ) )
            {
                self.modifiers[ "silencedkill" ] = 1;
                self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"silenced" ) );
            }
            
            if ( victimstruct.var_f142682e078001d1 )
            {
                self.modifiers[ "victimimpairedkill" ] = 1;
                self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"victim_impaired" ) );
                self.modifiers[ "detectedimpairedkill" ] = 1;
                self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"detected_impaired" ) );
            }
            
            if ( events::issurvivorkill( self ) )
            {
                self.modifiers[ "low_health_kill" ] = 1;
                self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"lowhealth" ) );
            }
            
            if ( events::function_853f2fa3d548d7ec( self ) )
            {
                self.modifiers[ "airborne" ] = 1;
                self.modifiers[ "mask5" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask5" ], ae_utility::function_2d1565a236387b2( #"hash_7f94e41c1787f8ae", #"airborne" ) );
            }
            
            if ( self playermount() >= 0.5 )
            {
                self.modifiers[ "mounted" ] = 1;
                self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"mounted" ) );
            }
            
            if ( self ishanging() )
            {
                self.modifiers[ "ledgehanging" ] = 1;
                self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"ledgehanging" ) );
            }
            
            var_40e8eb384fdbadaa = objweapon.inventorytype;
            
            if ( ( isbulletdamage || var_40e8eb384fdbadaa == "primary" ) && !objweapon.ismelee )
            {
                self.modifiers[ "bullet_damage" ] = 1;
                remainingammo = self getweaponammoclip( objweapon );
                
                if ( remainingammo <= 0 )
                {
                    self.modifiers[ "last_bullet_kill" ] = 1;
                    self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"lastbullet" ) );
                }
                
                modeauto = objweapon.isauto;
                modesemi = objweapon.issemiauto;
                burstfirecount = objweapon.burstcount;
                
                if ( modeauto )
                {
                    self.modifiers[ "full_auto_kill" ] = 1;
                    self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"full_auto_kill" ) );
                }
                
                if ( modesemi || burstfirecount == 1 )
                {
                    self.modifiers[ "semi_auto_kill" ] = 1;
                    self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"semi_auto_kill" ) );
                }
                else if ( burstfirecount > 1 )
                {
                    self.modifiers[ "burst_kill" ] = 1;
                    self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"burst_kill" ) );
                }
                
                if ( player::isplayerads() )
                {
                    var_94b790c6d08a5f7b = self function_25af1328b3e8da54( self.currentprimaryweapon );
                    
                    if ( var_94b790c6d08a5f7b )
                    {
                        self.modifiers[ "tac_stance" ] = 1;
                        self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"tac_stance_kill" ) );
                    }
                    else
                    {
                        self.modifiers[ "ads" ] = 1;
                        self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"ads" ) );
                    }
                }
                else
                {
                    self.modifiers[ "hipfire" ] = 1;
                    self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"hipfire" ) );
                }
            }
            
            if ( weapons::isstunnedorblinded() )
            {
                self.modifiers[ "impaired" ] = 1;
                self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"enemystunned" ) );
            }
            
            if ( events::events_issliding() )
            {
                self.modifiers[ "slidekill" ] = 1;
                self.modifiers[ "sliding" ] = 1;
                self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"slide" ) );
            }
            else if ( self isonladder() )
            {
                self.modifiers[ "onladder" ] = 1;
                self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"onladder" ) );
            }
            else if ( events::function_853f2fa3d548d7ec( self ) )
            {
                if ( ( weapon::iscacprimaryorsecondary( objweapon ) || weapon::isthrowingknife( objweapon ) ) && !weapon::iskillstreakweapon( objweapon.basename ) && !self.assistedsuicide )
                {
                    self.modifiers[ "jumpkill" ] = 1;
                    self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"jumpkill" ) );
                }
            }
            
            vehicle = player_utility::getvehicle( 1 );
            
            if ( !isdefined( vehicle ) )
            {
                stance = self getstance();
                
                switch ( stance )
                {
                    case #"hash_c6775c88e38f7803":
                        self.modifiers[ "standing_kill" ] = 1;
                        self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"standing" ) );
                        break;
                    case #"hash_d91940431ed7c605":
                        self.modifiers[ "prone_kill" ] = 1;
                        self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"prone" ) );
                        break;
                    case #"hash_3fed0cbd303639eb":
                        self.modifiers[ "crouch_kill" ] = 1;
                        self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"crouch" ) );
                        break;
                }
            }
        }
        else if ( weapongroup == "weapon_projectile" )
        {
            if ( isdefined( inflictor ) && isdefined( inflictor.adsfire ) )
            {
                if ( inflictor.adsfire )
                {
                    self.modifiers[ "ads" ] = 1;
                    self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"ads" ) );
                }
                else
                {
                    self.modifiers[ "hipfire" ] = 1;
                    self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"hipfire" ) );
                }
            }
        }
        
        vehicle = player_utility::getvehicle( 1 );
        
        if ( isdefined( vehicle ) )
        {
            self.modifiers[ "in_vehicle" ] = 1;
            self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"invehicle" ) );
        }
        
        if ( isdefined( inflictor ) && inflictor.isequipment && meansofdeath == "MOD_IMPACT" && !weapon::isthrowingknife( objweapon ) )
        {
            self.modifiers[ "item_impact" ] = 1;
        }
        
        if ( damage::islauncherdirectimpactdamage( objweapon, meansofdeath ) )
        {
            self.modifiers[ "launcher_impact" ] = 1;
        }
        
        if ( damage::islauncherdirectimpactdamage( objweapon, meansofdeath, 1 ) )
        {
            self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"launcher_impact" ) );
        }
        
        if ( isdefined( self.lastadsstarttime ) && curtime - self.lastadsstarttime <= 500 && ( weapongroup == "weapon_sniper" || weapongroup == "weapon_dmr" ) )
        {
            self.modifiers[ "quickscope" ] = 1;
            self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"quickscope" ) );
        }
        
        if ( isdefined( self.lastweaponchangetime ) && curtime - self.lastweaponchangetime <= 2500 )
        {
            self.modifiers[ "weapon_change_kill" ] = 1;
            self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"weaponswap" ) );
        }
        
        if ( isdefined( self.lastreloadtime ) && curtime - self.lastreloadtime <= 5000 )
        {
            self.modifiers[ "reload_kill" ] = 1;
            self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"recentreload" ) );
        }
        
        if ( isdefined( self.var_ec0a10d5cbcfca21 ) && curtime - self.var_ec0a10d5cbcfca21 <= 5000 )
        {
            self.modifiers[ "after_sprint_kill" ] = 1;
            self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"after_sprint_kill" ) );
        }
        
        if ( objweapon == self.secondaryweaponobj )
        {
            self.modifiers[ "secondary_weapon" ] = 1;
            self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"usingsecondaryweapon" ) );
        }
        
        if ( self.inlaststand )
        {
            self.modifiers[ "last_stand" ] = 1;
            self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"laststand" ) );
        }
        
        if ( self isinvehicleleanout() )
        {
            self.modifiers[ "vehiclelean" ] = 1;
            self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"vehiclelean" ) );
        }
        
        if ( meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_HEAD_SHOT" || weaponclass( objweapon ) == "spread" )
        {
            thread function_4ad0ff93baeb9d8();
            
            if ( !isdefined( self.var_a680cce7c744e61d ) )
            {
                self.var_a680cce7c744e61d = 1;
            }
            else
            {
                self.var_a680cce7c744e61d++;
                
                if ( self.var_a680cce7c744e61d >= 2 )
                {
                    events::collateralae( self.var_a680cce7c744e61d );
                }
            }
            
            level callback::callback( #"hash_bc5df80f274f1e34", { #victimstruct:victimstruct, #player:self } );
        }
        else if ( meansofdeath == "MOD_PROJECTILE" || meansofdeath == "MOD_PROJECTILE_SPLASH" )
        {
            thread function_4ad0ff93baeb9d8();
            level callback::callback( #"hash_bc5df80f274f1e34", { #victimstruct:victimstruct, #player:self } );
        }
        
        if ( isdefined( meansofdeath ) )
        {
            switch ( meansofdeath )
            {
                case #"hash_d8646db4e6ee3658":
                    self.modifiers[ "fire_damage" ] = 1;
                    self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"fire" ) );
                    break;
                case #"hash_b1078ff213fddba6":
                    self.modifiers[ "impact_damage" ] = 1;
                    self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"equipmentimpact" ) );
                    break;
                case #"hash_abb1587cdc6def23":
                    self.modifiers[ "crush_damage" ] = 1;
                    self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"crush" ) );
                    break;
                default:
                    break;
            }
        }
        
        if ( isdefined( objweapon.basename ) && issubstr( objweapon.basename, "molotov" ) || issubstr( objweapon.basename, "thermite" ) || dragonsbreath::isdragonsbreathweapon( objweapon ) || crossbow::isthermitecrossbow( objweapon ) )
        {
            self.modifiers[ "fire_damage" ] = 1;
            self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"fire" ) );
        }
        
        if ( isdefined( inflictor ) && isdefined( inflictor.equipmentref ) && isdefined( victimstruct.var_3a889a3334c81c31 ) )
        {
            if ( inflictor.equipmentref == "equip_c4" || inflictor.equipmentref == "equip_claymore" )
            {
                stuckto = victimstruct.var_3a889a3334c81c31;
                
                if ( isdefined( stuckto ) && stuckto.helperdronetype == "radar_drone_recon" )
                {
                    self.modifiers[ "recon_drone_explosive" ] = 1;
                    self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"recondroneexplosive" ) );
                    
                    if ( level.challengesallowed && isdefined( stuckto.owner ) )
                    {
                        self.recondroneteammate = stuckto.owner;
                    }
                }
                else if ( isdefined( stuckto ) && stuckto vehicle::is_vehicle() )
                {
                    self.modifiers[ "vehicle_explosive" ] = 1;
                    self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"vehicleexplosive" ) );
                    
                    if ( stuckto vehicle::ishelicopter() )
                    {
                        self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"helicopter_explosive" ) );
                    }
                }
            }
        }
        
        if ( vehicle::isvehicleweapon( objweapon ) && meansofdeath == "MOD_EXPLOSIVE" )
        {
            self.modifiers[ "vehicle_explosive" ] = 1;
            self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"vehicleexplosive" ) );
            
            if ( weapon::function_cbb4475c36fea5db( objweapon ) )
            {
                self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"helicopter_explosive" ) );
            }
        }
        
        if ( armor::hasarmor() )
        {
            self.modifiers[ "wearingarmor" ] = 1;
            self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"wearingarmor" ) );
        }
        
        if ( armor::function_70d2a998e632c76() )
        {
            self.modifiers[ "fullarmor" ] = 1;
            self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"fullarmor" ) );
        }
        
        if ( meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_GRENADE_SPLASH" )
        {
            if ( isdefined( inflictor.iscooked ) && inflictor.iscooked )
            {
                self.modifiers[ "with_cooked_grenade_kill" ] = 1;
                self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"hash_5b4eb501eaf86d4e" ) );
            }
        }
        
        events::function_60636f66ff66ed50( objweapon, meansofdeath, inflictor, victimstruct );
        function_70ae8d7b39b577e1( objweapon, meansofdeath, inflictor );
        zoomlevel = self playergetzoomfov();
        
        if ( zoomlevel <= 22 )
        {
            self.modifiers[ "extreme_magnification_kill" ] = 1;
            self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"extreme_magnification_kill" ) );
        }
        
        if ( objweapon.isalternate )
        {
            self.modifiers[ "isaltmode" ] = 1;
            self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"isaltmode" ) );
        }
        
        if ( self isswimming() )
        {
            self.modifiers[ "mask" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield1", #"swimming" ) );
            
            if ( self isswimunderwater() )
            {
                self.modifiers[ "mask2" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask2" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield2", #"underwater" ) );
            }
        }
    }
}

// Namespace zombie_shared_challenges
// Params 3
// Checksum 0x891bd29a, Offset: 0x2eac
// Size: 0x28
function function_70ae8d7b39b577e1( objweapon, meansofdeath, inflictor )
{
    function_3e62458da73d4202( inflictor, objweapon );
}

// Namespace zombie_shared_challenges
// Params 0
// Checksum 0x2cd16687, Offset: 0x2edc
// Size: 0x70
function function_ebe3b18f036aacae()
{
    var_cf912a2c4e4d5e37 = function_4209fa4b8a47cf80();
    elementalmodifiers = 0;
    
    if ( isplayer( self.var_bd22ba6c600a23a3 ) )
    {
        elementalmodifiers = challenges::function_a23641f33e985edb( elementalmodifiers, var_cf912a2c4e4d5e37[ #"brainrot" ] );
        elementalmodifiers = challenges::function_a23641f33e985edb( elementalmodifiers, var_cf912a2c4e4d5e37[ #"toxic" ] );
        elementalmodifiers = challenges::function_a23641f33e985edb( elementalmodifiers, var_cf912a2c4e4d5e37[ #"ammomod" ] );
    }
    
    return elementalmodifiers;
}

// Namespace zombie_shared_challenges
// Params 3
// Checksum 0x92c94bc8, Offset: 0x2f55
// Size: 0x57f
function function_216bb7c532af802f( victim, meansofdeath, objweapon )
{
    elementalmodifiers = 0;
    
    if ( !victim )
    {
        return elementalmodifiers;
    }
    
    var_cf912a2c4e4d5e37 = function_4209fa4b8a47cf80();
    
    if ( meansofdeath )
    {
        if ( isdefined( level.sharedfuncs[ #"zombie" ][ #"get_weapon_element" ] ) )
        {
            var_5e5a2456deacd236 = utility::callsharedfunc( #"zombie", #"get_weapon_element", objweapon, self, meansofdeath );
        }
        else if ( isdefined( level.sharedfuncs[ #"ob" ][ #"getweaponelement" ] ) )
        {
            var_5e5a2456deacd236 = utility::callsharedfunc( #"ob", #"getweaponelement", objweapon, self, meansofdeath );
        }
        else
        {
            assertmsg( "<dev string:x24>" );
            return elementalmodifiers;
        }
        
        if ( !isdefined( victim.var_5a2b7510798c980b ) )
        {
            victim.var_5a2b7510798c980b = [];
        }
        
        if ( var_5e5a2456deacd236 == "fire" || meansofdeath == "MOD_ELEMENTAL_FIRE" )
        {
            elementalmodifiers = challenges::function_a23641f33e985edb( elementalmodifiers, var_cf912a2c4e4d5e37[ #"fire" ] );
            victim.var_5a2b7510798c980b[ "fire" ] = gettime();
        }
        else if ( var_5e5a2456deacd236 == "cold" || meansofdeath == "MOD_ELEMENTAL_COLD" )
        {
            elementalmodifiers = challenges::function_a23641f33e985edb( elementalmodifiers, var_cf912a2c4e4d5e37[ #"cold" ] );
            victim.var_5a2b7510798c980b[ "cold" ] = gettime();
        }
        else if ( var_5e5a2456deacd236 == "electrical" || meansofdeath == "MOD_ELEMENTAL_ELEC" )
        {
            elementalmodifiers = challenges::function_a23641f33e985edb( elementalmodifiers, var_cf912a2c4e4d5e37[ #"electric" ] );
            victim.var_5a2b7510798c980b[ "electrical" ] = gettime();
        }
        else if ( var_5e5a2456deacd236 == "toxic" || meansofdeath == "MOD_ELEMENTAL_TOXIC" )
        {
            elementalmodifiers = challenges::function_a23641f33e985edb( elementalmodifiers, var_cf912a2c4e4d5e37[ #"toxic" ] );
            victim.var_5a2b7510798c980b[ "toxic" ] = gettime();
        }
        
        if ( meansofdeath == "MOD_EXPLOSIVE" || meansofdeath == "MOD_PROJECTILE" || meansofdeath == "MOD_PROJECTILE_SPLASH" || meansofdeath == "MOD_GRENADE_SPLASH" )
        {
            elementalmodifiers = challenges::function_a23641f33e985edb( elementalmodifiers, var_cf912a2c4e4d5e37[ #"explosive" ] );
        }
    }
    
    if ( isplayer( self ) )
    {
        if ( !isdefined( self.var_581a52d13206a1ea ) )
        {
            self.var_581a52d13206a1ea = [];
        }
    }
    
    ammomoduse = "";
    ammomods_active = int( 0 );
    
    if ( victim.napalm_burned )
    {
        elementalmodifiers = challenges::function_a23641f33e985edb( elementalmodifiers, var_cf912a2c4e4d5e37[ #"napalmburst" ] );
        ammomoduse = #"napalmburst";
        ammomods_active++;
    }
    
    if ( victim.cryofreeze_active )
    {
        elementalmodifiers = challenges::function_a23641f33e985edb( elementalmodifiers, var_cf912a2c4e4d5e37[ #"cryofreeze" ] );
        ammomoduse = #"cryofreeze";
        ammomods_active++;
    }
    
    if ( victim.shadowvortex_active )
    {
        elementalmodifiers = challenges::function_a23641f33e985edb( elementalmodifiers, var_cf912a2c4e4d5e37[ #"shadowvortex" ] );
        ammomoduse = #"shadowvortex";
        ammomods_active++;
    }
    
    if ( victim.deadwire_active )
    {
        elementalmodifiers = challenges::function_a23641f33e985edb( elementalmodifiers, var_cf912a2c4e4d5e37[ #"deadwire" ] );
        ammomoduse = #"deadwire";
        ammomods_active++;
    }
    
    if ( victim.shatterbast_active )
    {
        elementalmodifiers = challenges::function_a23641f33e985edb( elementalmodifiers, var_cf912a2c4e4d5e37[ #"shatterblast" ] );
        ammomoduse = #"shatterblast";
        ammomods_active++;
    }
    
    if ( victim.brainrot_active )
    {
        elementalmodifiers = challenges::function_a23641f33e985edb( elementalmodifiers, var_cf912a2c4e4d5e37[ #"brainrot" ] );
        ammomoduse = #"brainrot";
        ammomods_active++;
    }
    
    if ( victim.fireworks_active )
    {
        elementalmodifiers = challenges::function_a23641f33e985edb( elementalmodifiers, var_cf912a2c4e4d5e37[ #"fireworks" ] );
        ammomoduse = #"fireworks";
        ammomods_active++;
    }
    
    if ( isplayer( self ) )
    {
        primary_weapons = self getweaponslistprimaries();
        
        foreach ( primary in primary_weapons )
        {
            if ( ammo_mod::function_ba9b2ecd18bdbdd8( primary, ammomoduse ) )
            {
                self.var_581a52d13206a1ea[ ammomoduse ] = 1;
                break;
            }
        }
        
        if ( ammomods_active > 1 )
        {
            if ( utility::issharedfuncdefined( #"medal", #"track_rapid_kill", 0 ) )
            {
                utility::callsharedfunc( #"medal", #"track_rapid_kill", "multi_ammomod" );
            }
        }
        
        if ( ammomods_active >= 1 )
        {
            if ( utility::issharedfuncdefined( #"medal", #"track_rapid_kill", 0 ) )
            {
                utility::callsharedfunc( #"medal", #"track_rapid_kill", "ammomod" );
            }
            
            elementalmodifiers = challenges::function_a23641f33e985edb( elementalmodifiers, var_cf912a2c4e4d5e37[ #"ammomod" ] );
        }
    }
    
    var_138121e726290b4 = 0;
    
    if ( victim.status_effect_burn )
    {
        var_138121e726290b4++;
    }
    
    if ( victim.status_effect_cold )
    {
        var_138121e726290b4++;
    }
    
    if ( victim.status_effect_electrical )
    {
        var_138121e726290b4++;
    }
    
    if ( var_138121e726290b4 > 1 )
    {
        elementalmodifiers = challenges::function_a23641f33e985edb( elementalmodifiers, var_cf912a2c4e4d5e37[ #"elemental_combo" ] );
    }
    
    return elementalmodifiers;
}

// Namespace zombie_shared_challenges
// Params 2, eflags: 0x4
// Checksum 0x717c6623, Offset: 0x34dd
// Size: 0x7b
function private function_3e62458da73d4202( inflictor, objweapon )
{
    if ( objweapon && weapon::getequipmenttype( objweapon ) == "lethal" )
    {
        self.modifiers[ "equipment_kill" ] = 1;
        self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"lethal_equipment_kill" ) );
    }
}

// Namespace zombie_shared_challenges
// Params 1
// Checksum 0xa56048c1, Offset: 0x3560
// Size: 0x149
function function_920a35d38f329ffb( victim )
{
    if ( victim.var_a8e9ab5fba96d982 )
    {
        var_e4c269673b34bfd6 = 1;
        var_6af9f8eb05fab28 = 1;
        self.var_7576e5f315dd11f5 = undefined;
        self.modifiers[ "concussed_kill" ] = 1;
        self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"hash_16c89bd5de678bcb" ) );
    }
    
    if ( var_e4c269673b34bfd6 )
    {
        self.var_e4c269673b34bfd6 = undefined;
        self.modifiers[ "tactical_kill" ] = 1;
        self.modifiers[ "mask3" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask3" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield3", #"your_tactical_kill" ) );
    }
    
    if ( var_6af9f8eb05fab28 )
    {
        self.var_6af9f8eb05fab28 = undefined;
        self.modifiers[ "impaired_by_tactical_kill" ] = 1;
        self.modifiers[ "mask4" ] = challenges::function_a23641f33e985edb( self.modifiers[ "mask4" ], ae_utility::function_2d1565a236387b2( #"kill_bitfield4", #"impaired_by_tactical_kill" ) );
    }
}

// Namespace zombie_shared_challenges
// Params 5, eflags: 0x4
// Checksum 0xd17aca22, Offset: 0x36b1
// Size: 0xb3, Type: bool
function private function_75bc0d7afac9c681( victimstruct, objweapon, meansofdeath, curtime, weapongroup )
{
    if ( weapongroup == "other" || weapongroup == "weapon_projectile" )
    {
        return false;
    }
    
    if ( meansofdeath == "MOD_MELEE" || meansofdeath == "MOD_EXPLOSIVE" )
    {
        return false;
    }
    
    if ( isdefined( victimstruct.var_d3a7b3f093df2ff1 ) && isdefined( victimstruct.var_e26538d32bf084ea ) )
    {
        timediff = abs( victimstruct.var_d3a7b3f093df2ff1 - victimstruct.var_e26538d32bf084ea );
        
        if ( timediff <= 25 )
        {
            return true;
        }
    }
    
    return false;
}

// Namespace zombie_shared_challenges
// Params 2
// Checksum 0xb67ac121, Offset: 0x376d
// Size: 0xc1
function function_f603dd218dbf4618( victim, var_8fbc19b2e70842b5 = 0 )
{
    var_8fbc19b2e70842b5 = function_1a859eae7ac0e40a( victim.subclass, var_8fbc19b2e70842b5, victim.var_facda4eb36c515c8 );
    var_8fbc19b2e70842b5 = function_b0abe2f61f80210( victim, var_8fbc19b2e70842b5 );
    
    if ( victim.type == "zombie" )
    {
        typexhash = getxhash( victim.type );
        
        if ( !typexhash )
        {
            println( "<dev string:x5e>" + victim.type );
            return var_8fbc19b2e70842b5;
        }
        
        var_db09b7f06940fbdd = function_b74ae84b0e591a1();
        
        if ( isdefined( var_db09b7f06940fbdd[ typexhash ] ) )
        {
            var_8fbc19b2e70842b5 = challenges::function_a23641f33e985edb( var_8fbc19b2e70842b5, var_db09b7f06940fbdd[ typexhash ] );
        }
    }
    
    return var_8fbc19b2e70842b5;
}

// Namespace zombie_shared_challenges
// Params 3, eflags: 0x4
// Checksum 0x744d4805, Offset: 0x3837
// Size: 0x1c4
function private function_1a859eae7ac0e40a( subclass, var_8fbc19b2e70842b5 = 0, var_facda4eb36c515c8 )
{
    if ( !subclass )
    {
        println( "<dev string:xae>" );
        return var_8fbc19b2e70842b5;
    }
    
    if ( var_facda4eb36c515c8 )
    {
        foreach ( struct in var_facda4eb36c515c8 )
        {
            if ( !isdefined( struct.bit ) )
            {
                continue;
            }
            
            var_8fbc19b2e70842b5 = challenges::function_a23641f33e985edb( var_8fbc19b2e70842b5, struct.bit );
        }
        
        return var_8fbc19b2e70842b5;
    }
    
    var_db09b7f06940fbdd = function_b74ae84b0e591a1();
    var_a39f27d577f5053d = getxhash( subclass );
    
    if ( issubstr( subclass, "_mega" ) )
    {
        if ( isdefined( var_db09b7f06940fbdd[ #"mega" ] ) )
        {
            var_8fbc19b2e70842b5 = challenges::function_a23641f33e985edb( var_8fbc19b2e70842b5, var_db09b7f06940fbdd[ #"mega" ] );
        }
        
        subclass = removesubstr( subclass, "_mega" );
        var_a39f27d577f5053d = getxhash( subclass );
    }
    else if ( issubstr( subclass, "_hvt" ) )
    {
        if ( isdefined( var_db09b7f06940fbdd[ #"hvt" ] ) )
        {
            var_8fbc19b2e70842b5 = challenges::function_a23641f33e985edb( var_8fbc19b2e70842b5, var_db09b7f06940fbdd[ #"hvt" ] );
        }
        
        subclass = removesubstr( subclass, "_hvt" );
        var_a39f27d577f5053d = getxhash( subclass );
    }
    else if ( issubstr( subclass, "_boss" ) )
    {
        subclass = removesubstr( subclass, "_boss" );
        var_a39f27d577f5053d = getxhash( subclass );
    }
    
    if ( isdefined( var_db09b7f06940fbdd[ var_a39f27d577f5053d ] ) )
    {
        var_8fbc19b2e70842b5 = challenges::function_a23641f33e985edb( var_8fbc19b2e70842b5, var_db09b7f06940fbdd[ var_a39f27d577f5053d ] );
    }
    
    return var_8fbc19b2e70842b5;
}

// Namespace zombie_shared_challenges
// Params 2, eflags: 0x4
// Checksum 0xd3167f0b, Offset: 0x3a04
// Size: 0xc6
function private function_b0abe2f61f80210( victim, var_8fbc19b2e70842b5 = 0 )
{
    if ( !victim )
    {
        println( "<dev string:xe3>" );
        return var_8fbc19b2e70842b5;
    }
    
    enemycategory = ai_category::function_e6e323e14b12152e( victim );
    var_21a9b7bd9b0c356e = function_e56d7e27d2c774fd();
    
    if ( enemycategory != #"unknown" )
    {
        var_8fbc19b2e70842b5 = challenges::function_a23641f33e985edb( var_8fbc19b2e70842b5, var_21a9b7bd9b0c356e[ enemycategory ] );
    }
    else
    {
        println( "<dev string:x11a>" + getxhashsourcename( enemycategory ) );
    }
    
    if ( enemycategory == #"hvt" )
    {
        var_8fbc19b2e70842b5 = challenges::function_a23641f33e985edb( var_8fbc19b2e70842b5, var_21a9b7bd9b0c356e[ #"elite" ] );
    }
    
    var_8fbc19b2e70842b5 = challenges::function_a23641f33e985edb( var_8fbc19b2e70842b5, var_21a9b7bd9b0c356e[ #"any" ] );
    return var_8fbc19b2e70842b5;
}

// Namespace zombie_shared_challenges
// Params 1
// Checksum 0xb9235081, Offset: 0x3ad3
// Size: 0x56, Type: bool
function function_b23fb0c74ffd6362( player )
{
    return isplayer( player ) && ( player.var_57436ea3d87868a1.size > 0 || player.toxic_growth_array.size > 0 || player.mary_paris_mdl || player utility::ent_flag( "field_upgrade_in_use" ) );
}

// Namespace zombie_shared_challenges
// Params 2
// Checksum 0x587f1858, Offset: 0x3b32
// Size: 0xfc
function function_e755757ca2b10ec9( sweapon, victimstruct )
{
    if ( isplayer( self.var_bd22ba6c600a23a3 ) && isweapon( self.var_6d31abe6b171ada8 ) )
    {
        return self.var_6d31abe6b171ada8;
    }
    
    if ( victimstruct.napalm_burned )
    {
        if ( isweapon( victimstruct.napalmburst_proc_weapon ) )
        {
            if ( victimstruct.weapon_basenamehash == %"none" || !victimstruct.weapon_basenamehash )
            {
                return victimstruct.napalmburst_proc_weapon;
            }
        }
        else if ( isweapon( self.var_156510188aec02a4 ) && self hasweapon( self.var_156510188aec02a4 ) && sweapon.basename && issubstr( sweapon.basename, "molotov_zm_napalmburst" ) )
        {
            return self.var_156510188aec02a4;
        }
    }
    
    if ( !isweapon( sweapon ) )
    {
        sweapon = nullweapon();
    }
    
    return sweapon;
}

// Namespace zombie_shared_challenges
// Params 0, eflags: 0x4
// Checksum 0x4b6cb036, Offset: 0x3c37
// Size: 0x46d
function private function_b74ae84b0e591a1()
{
    if ( isdefined( level.var_2bcb353fe65f5ebd.var_b793b5b66b879627 ) && level.var_2bcb353fe65f5ebd.var_b793b5b66b879627.size != 0 )
    {
        return level.var_2bcb353fe65f5ebd.var_b793b5b66b879627;
    }
    
    var_b793b5b66b879627 = [];
    var_b793b5b66b879627[ #"zombie_base" ] = ae_utility::function_2d1565a236387b2( #"zm_zombie_type_bitfield", #"zombie_base" );
    var_b793b5b66b879627[ #"zombie_hellhound" ] = ae_utility::function_2d1565a236387b2( #"zm_zombie_type_bitfield", #"zombie_hellhound" );
    var_b793b5b66b879627[ #"zombie_mangler" ] = ae_utility::function_2d1565a236387b2( #"zm_zombie_type_bitfield", #"zombie_mangler" );
    var_b793b5b66b879627[ #"zombie_mimic" ] = ae_utility::function_2d1565a236387b2( #"zm_zombie_type_bitfield", #"zombie_mimic" );
    var_b793b5b66b879627[ #"zombie_parasite" ] = ae_utility::function_2d1565a236387b2( #"zm_zombie_type_bitfield", #"zombie_parasite" );
    var_b793b5b66b879627[ #"zombie_triton" ] = ae_utility::function_2d1565a236387b2( #"zm_zombie_type_bitfield", #"zombie_triton" );
    var_b793b5b66b879627[ #"zombie_abom" ] = ae_utility::function_2d1565a236387b2( #"zm_zombie_type_bitfield", #"zombie_abom" );
    var_b793b5b66b879627[ #"zombie_amalgam" ] = ae_utility::function_2d1565a236387b2( #"zm_zombie_type_bitfield", #"zombie_amalgam" );
    var_b793b5b66b879627[ #"zombie_disciple" ] = ae_utility::function_2d1565a236387b2( #"zm_zombie_type_bitfield", #"zombie_disciple" );
    var_b793b5b66b879627[ #"zombie_ghoul" ] = ae_utility::function_2d1565a236387b2( #"zm_zombie_type_bitfield", #"zombie_ghoul" );
    var_b793b5b66b879627[ #"zombie_vermin" ] = ae_utility::function_2d1565a236387b2( #"zm_zombie_type_bitfield", #"zombie_vermin" );
    var_b793b5b66b879627[ #"zombie_boss_quartz" ] = ae_utility::function_2d1565a236387b2( #"zm_zombie_type_bitfield", #"zombie_boss_quartz" );
    var_b793b5b66b879627[ #"zombie_boss_kala_arm" ] = ae_utility::function_2d1565a236387b2( #"zm_zombie_type_bitfield", #"zombie_boss_kala_arm" );
    var_b793b5b66b879627[ #"zombie_base_armored_light" ] = ae_utility::function_2d1565a236387b2( #"zm_zombie_type_bitfield", #"zombie_base_armored_light" );
    var_b793b5b66b879627[ #"zombie_base_armored_heavy" ] = ae_utility::function_2d1565a236387b2( #"zm_zombie_type_bitfield", #"zombie_base_armored_heavy" );
    var_b793b5b66b879627[ #"zombie_mangler_death" ] = ae_utility::function_2d1565a236387b2( #"zm_zombie_type_bitfield", #"zombie_mangler_death" );
    var_b793b5b66b879627[ #"zombie_shade" ] = ae_utility::function_2d1565a236387b2( #"zm_zombie_type_bitfield", #"zombie_shade" );
    var_b793b5b66b879627[ #"zombie_abom_bichon" ] = ae_utility::function_2d1565a236387b2( #"zm_zombie_type_bitfield", #"zombie_abom_bichon" );
    var_b793b5b66b879627[ #"zombie_hermes" ] = ae_utility::function_2d1565a236387b2( #"zm_zombie_type_bitfield", #"zombie_hermes" );
    var_b793b5b66b879627[ #"zombie_callisto" ] = ae_utility::function_2d1565a236387b2( #"zm_zombie_type_bitfield", #"zombie_callisto" );
    var_b793b5b66b879627[ #"zombie_mimic_emp" ] = ae_utility::function_2d1565a236387b2( #"zm_zombie_type_bitfield", #"zombie_mimic_emp" );
    var_b793b5b66b879627[ #"zombie_galileo" ] = ae_utility::function_2d1565a236387b2( #"zm_zombie_type_bitfield", #"zombie_galileo" );
    var_b793b5b66b879627[ #"zombie_methone" ] = ae_utility::function_2d1565a236387b2( #"zm_zombie_type_bitfield", #"zombie_methone" );
    var_b793b5b66b879627[ #"zombie_base_toxic" ] = ae_utility::function_2d1565a236387b2( #"zm_zombie_type_bitfield", #"zombie_base_toxic" );
    var_b793b5b66b879627[ #"zombie" ] = ae_utility::function_2d1565a236387b2( #"zm_zombie_type_bitfield", #"zombie" );
    var_b793b5b66b879627[ #"zombie_disciple_falkner" ] = ae_utility::function_2d1565a236387b2( #"zm_zombie_type_bitfield", #"zombie_disciple_falkner" );
    var_b793b5b66b879627[ #"zombie_disciple_elder" ] = ae_utility::function_2d1565a236387b2( #"zm_zombie_type_bitfield", #"zombie_disciple_elder" );
    var_b793b5b66b879627[ #"zombie_disciple_skoll" ] = ae_utility::function_2d1565a236387b2( #"zm_zombie_type_bitfield", #"zombie_disciple_skoll" );
    level.var_2bcb353fe65f5ebd.var_b793b5b66b879627 = var_b793b5b66b879627;
    return level.var_2bcb353fe65f5ebd.var_b793b5b66b879627;
}

// Namespace zombie_shared_challenges
// Params 0
// Checksum 0x5a091fd7, Offset: 0x40ad
// Size: 0x179
function function_e56d7e27d2c774fd()
{
    if ( isdefined( level.var_2bcb353fe65f5ebd.var_7082008e6d8504cd ) && level.var_2bcb353fe65f5ebd.var_7082008e6d8504cd.size != 0 )
    {
        return level.var_2bcb353fe65f5ebd.var_7082008e6d8504cd;
    }
    
    var_7082008e6d8504cd = [];
    var_7082008e6d8504cd[ #"any" ] = ae_utility::function_2d1565a236387b2( #"zm_zombie_type_bitfield", #"any" );
    var_7082008e6d8504cd[ #"special" ] = ae_utility::function_2d1565a236387b2( #"zm_zombie_type_bitfield", #"special" );
    var_7082008e6d8504cd[ #"elite" ] = ae_utility::function_2d1565a236387b2( #"zm_zombie_type_bitfield", #"elite" );
    var_7082008e6d8504cd[ #"normal" ] = ae_utility::function_2d1565a236387b2( #"zm_zombie_type_bitfield", #"normal" );
    var_7082008e6d8504cd[ #"advanced" ] = ae_utility::function_2d1565a236387b2( #"zm_zombie_type_bitfield", #"advanced" );
    var_7082008e6d8504cd[ #"boss" ] = ae_utility::function_2d1565a236387b2( #"zm_zombie_type_bitfield", #"boss" );
    var_7082008e6d8504cd[ #"hvt" ] = ae_utility::function_2d1565a236387b2( #"zm_zombie_type_bitfield", #"hvt" );
    level.var_2bcb353fe65f5ebd.var_7082008e6d8504cd = var_7082008e6d8504cd;
    return level.var_2bcb353fe65f5ebd.var_7082008e6d8504cd;
}

// Namespace zombie_shared_challenges
// Params 0
// Checksum 0x27784aab, Offset: 0x422f
// Size: 0x27f
function function_4209fa4b8a47cf80()
{
    if ( level.var_2bcb353fe65f5ebd.var_7d7d0fc1c11f1668.size )
    {
        return level.var_2bcb353fe65f5ebd.var_7d7d0fc1c11f1668;
    }
    
    var_7d7d0fc1c11f1668 = [];
    var_7d7d0fc1c11f1668[ #"fire" ] = ae_utility::function_2d1565a236387b2( #"zm_elemental_ammomod_bitfield", #"fire" );
    var_7d7d0fc1c11f1668[ #"cold" ] = ae_utility::function_2d1565a236387b2( #"zm_elemental_ammomod_bitfield", #"cold" );
    var_7d7d0fc1c11f1668[ #"toxic" ] = ae_utility::function_2d1565a236387b2( #"zm_elemental_ammomod_bitfield", #"toxic" );
    var_7d7d0fc1c11f1668[ #"electric" ] = ae_utility::function_2d1565a236387b2( #"zm_elemental_ammomod_bitfield", #"electric" );
    var_7d7d0fc1c11f1668[ #"explosive" ] = ae_utility::function_2d1565a236387b2( #"zm_elemental_ammomod_bitfield", #"explosive" );
    var_7d7d0fc1c11f1668[ #"napalmburst" ] = ae_utility::function_2d1565a236387b2( #"zm_elemental_ammomod_bitfield", #"napalmburst" );
    var_7d7d0fc1c11f1668[ #"brainrot" ] = ae_utility::function_2d1565a236387b2( #"zm_elemental_ammomod_bitfield", #"brainrot" );
    var_7d7d0fc1c11f1668[ #"cryofreeze" ] = ae_utility::function_2d1565a236387b2( #"zm_elemental_ammomod_bitfield", #"cryofreeze" );
    var_7d7d0fc1c11f1668[ #"deadwire" ] = ae_utility::function_2d1565a236387b2( #"zm_elemental_ammomod_bitfield", #"deadwire" );
    var_7d7d0fc1c11f1668[ #"lightray" ] = ae_utility::function_2d1565a236387b2( #"zm_elemental_ammomod_bitfield", #"lightray" );
    var_7d7d0fc1c11f1668[ #"shadowvortex" ] = ae_utility::function_2d1565a236387b2( #"zm_elemental_ammomod_bitfield", #"shadowvortex" );
    var_7d7d0fc1c11f1668[ #"shatterblast" ] = ae_utility::function_2d1565a236387b2( #"zm_elemental_ammomod_bitfield", #"shatterblast" );
    var_7d7d0fc1c11f1668[ #"elemental_combo" ] = ae_utility::function_2d1565a236387b2( #"zm_elemental_ammomod_bitfield", #"elemental_combo" );
    var_7d7d0fc1c11f1668[ #"ammomod" ] = ae_utility::function_2d1565a236387b2( #"zm_elemental_ammomod_bitfield", #"ammomod" );
    var_7d7d0fc1c11f1668[ #"fireworks" ] = ae_utility::function_2d1565a236387b2( #"zm_elemental_ammomod_bitfield", #"fireworks" );
    level.var_2bcb353fe65f5ebd.var_7d7d0fc1c11f1668 = var_7d7d0fc1c11f1668;
    return level.var_2bcb353fe65f5ebd.var_7d7d0fc1c11f1668;
}

