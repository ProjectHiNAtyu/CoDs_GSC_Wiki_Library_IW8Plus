// scripts\mp\wc\sat_guild_bot.gsc  (hash_686ce2cbc7407a71.gscc) (size: 5080 Bytes / 0x13d8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xfe7a716e (4269437294)
// size ...... 5080 (0x13d8)
// includes .. 5   (offset: 0x1280)
// strings ... 22  (offset: 0x12a8)
// dev strs .. 1   (offset: 0x13cc)
// exports ... 15  (offset: 0xb44)
// cseg ...... 0x1b1 + 0x993 (0xb44)
// imports ... 42  (offset: 0xd9c)
// animtree1 . 0   (offset: 0x13d8)
// animtree2 . 0   (offset: 0x13d8)
#using script_16ea1b94f0f381b3;
#using scripts\anim\battlechatter;
#using scripts\anim\squadmanager;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace sat_guild_bot;

// Namespace sat_guild_bot
// Params 2
// Checksum 0x809333d3, Offset: 0x1cf
// Size: 0xae
function precache( classname, aitypescriptbundle )
{
    if ( isdefined( level.guildbotinit ) )
    {
        return;
    }
    
    level.guildbotinit = 1;
    var_a7504a3b26becde1 = function_d4f1a66123a91e7( aitypescriptbundle );
    
    if ( var_a7504a3b26becde1.explosionvfx )
    {
        level._effect[ "guild_bot_death_explosion" ] = loadfxasset( var_a7504a3b26becde1.explosionvfx );
    }
    
    if ( var_a7504a3b26becde1.disabledvfx )
    {
        level._effect[ "guild_bot_disabled" ] = loadfxasset( var_a7504a3b26becde1.disabledvfx );
    }
    
    level callback::add( "on_agent_spawned", &agent_on_spawned );
}

// Namespace sat_guild_bot
// Params 1, eflags: 0x4
// Checksum 0x1b3c938c, Offset: 0x285
// Size: 0x226
function private agent_on_spawned( params )
{
    agent = params.agent;
    
    if ( !issubstr( agent.agent_type, "guild_bot" ) || issubstr( agent.agent_type, "ally_guild_bot" ) )
    {
        return;
    }
    
    agent setcanusecover( 0 );
    self.goalradius = 4096;
    
    if ( self.agent_damage_callback )
    {
        self.var_5ee871ef271a9323 = self.agent_damage_callback;
    }
    
    self.agent_damage_callback = &function_8f6d340ee3e19bb4;
    self.minpaindamage = 15;
    self.var_c21cefdb0d231840 = 1000;
    self.var_1db1f2ef9c7f9036 = randomintrange( 800, 1400 );
    self.var_aaf12cbad4692c1b = randomintrange( 250, 500 );
    self.var_47627bac27bc94ff = self.var_aaf12cbad4692c1b + 100;
    self.var_e5d5b423587e876 = self.var_aaf12cbad4692c1b;
    self.var_bd7dc728ded0f3d = self.var_aaf12cbad4692c1b - 50;
    self.var_de04c2fb38eec74a = 1;
    self.var_7bd2fc702f01b407 = 1;
    self.dontmeleeme = 0;
    self.var_8ec107c571aa0b8d = &validate_brain_rot;
    self.var_ea900b480a55e803 = &function_56c130576c33f272;
    self.var_4fb7740c7ac5d31d = 0.35;
    self function_74b305f055e8341d( "metal_thick" );
    self.stealth_idledemeanor = "combat";
    self.var_b52fca22f7f1e144 = "combat";
    agent thread squadmanager::addtosquad();
    
    if ( isdefined( self.battlechatter ) )
    {
        self.battlechatter.charoverride = "guib";
    }
    
    utility::registersharedfunc( #"ai_guild_bot", #"hack", &hack );
    utility::registersharedfunc( #"ai_guild_bot_advanced", #"hack", &hack );
    utility::registersharedfunc( #"ai_guild_bot_advanced_short", #"hack", &hack );
    namespace_9d8e359c3b1041e5::emp_debuff_register_sharedfunc( self, &on_emp_applied );
    callback::callback( "GuildBotInitOverride" );
    thread function_10447fee576b73ef();
}

// Namespace sat_guild_bot
// Params 0
// Checksum 0xf5d93f37, Offset: 0x4b3
// Size: 0x14, Type: bool
function validate_brain_rot()
{
    if ( utility::ent_flag( "scene_active" ) )
    {
        return false;
    }
    
    return true;
}

// Namespace sat_guild_bot
// Params 0, eflags: 0x4
// Checksum 0x575ffee0, Offset: 0x4d0
// Size: 0x55
function private function_10447fee576b73ef()
{
    self endon( #"death" );
    self waittill( #"bc_deploy_bots" );
    battlechatter::broadcastnotify( self.origin, 1000, "deploy_equipment", "deploy_bots", { #team:self.team, #otherent:self } );
}

// Namespace sat_guild_bot
// Params 14, eflags: 0x4
// Checksum 0x866c2e4b, Offset: 0x52d
// Size: 0x1bd
function private function_8f6d340ee3e19bb4( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon, poisedamage )
{
    soldierdamage = idamage;
    
    if ( self.var_5ee871ef271a9323 )
    {
        soldierdamage = [[ self.var_5ee871ef271a9323 ]]( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon );
    }
    
    currhealth = self.health - soldierdamage;
    healthpercent = currhealth / self.maxhealth;
    
    if ( healthpercent <= 0.3 )
    {
        utility::function_32b24db3127bff40( "body_damage", "heavy" );
    }
    else if ( healthpercent <= 0.6 )
    {
        utility::function_32b24db3127bff40( "body_damage", "medium" );
    }
    else if ( healthpercent <= 0.9 )
    {
        utility::function_32b24db3127bff40( "body_damage", "light" );
    }
    else
    {
        utility::function_32b24db3127bff40( "body_damage", "off" );
    }
    
    if ( currhealth <= 0 )
    {
        emp = 0;
        
        if ( shitloc == "head" || shitloc == "helmet" || shitloc == "neck" )
        {
            if ( randomint( 100 ) < 30 )
            {
                emp = 1;
            }
        }
        
        /#
            if ( getdvarint( @"hash_635b025bdda2582", 0 ) )
            {
                emp = 1;
            }
        #/
        
        thread explode_on_death( eattacker, emp );
    }
    
    return soldierdamage;
}

// Namespace sat_guild_bot
// Params 2, eflags: 0x4
// Checksum 0x5d5b15bd, Offset: 0x6f3
// Size: 0x3d
function private explode_on_death( eattacker, emp )
{
    self.explodeattacker = eattacker;
    
    if ( isplayer( eattacker ) && emp )
    {
        self.var_ea900b480a55e803 = &function_9a2c15647feb00c5;
    }
}

// Namespace sat_guild_bot
// Params 1, eflags: 0x4
// Checksum 0x2890f87e, Offset: 0x738
// Size: 0x58
function private function_d4f1a66123a91e7( aitypescriptbundle )
{
    aisettingsbundle = getscriptbundle( "aisettingsbundle:" + aitypescriptbundle.aisettingsbundle );
    
    if ( !aisettingsbundle.var_c72b569453167cda )
    {
        return;
    }
    
    var_a7504a3b26becde1 = getscriptbundle( aisettingsbundle.var_c72b569453167cda );
    return var_a7504a3b26becde1;
}

// Namespace sat_guild_bot
// Params 2, eflags: 0x4
// Checksum 0x5f0e1f91, Offset: 0x799
// Size: 0x4b
function private hack( hackeffect, attacker )
{
    if ( !hackeffect.var_96829da7e36878f0 )
    {
        secondsstunned = hackeffect.hackduration * 0.001;
        stun_bot( attacker, secondsstunned );
    }
}

// Namespace sat_guild_bot
// Params 2, eflags: 0x4
// Checksum 0xf39683a6, Offset: 0x7ec
// Size: 0x68
function private stun_bot( attacker, secondsstunned )
{
    self notify( #"flashbang", self.origin, 1, undefined, attacker, attacker.team, secondsstunned );
    disabledfx = utility::getfx( "guild_bot_disabled" );
    
    if ( disabledfx )
    {
        playfx( disabledfx, self.origin );
    }
}

// Namespace sat_guild_bot
// Params 1, eflags: 0x4
// Checksum 0xa6a18d7a, Offset: 0x85c
// Size: 0x97
function private function_9a2c15647feb00c5( corpseent )
{
    corpseent endon( #"death" );
    attacker = self.explodeattacker;
    center = self.origin + ( 0, 0, 40 );
    wait 0.9;
    
    if ( isplayer( attacker ) )
    {
        magicgrenademanual( "sat_guild_bot_death_emp_grenade_ob", center, ( 0, 0, 0 ), 0, attacker );
        return;
    }
    
    magicgrenademanual( "sat_guild_bot_death_emp_grenade_ob", center, ( 0, 0, 0 ), 0 );
}

// Namespace sat_guild_bot
// Params 1, eflags: 0x4
// Checksum 0x378c92b, Offset: 0x8fb
// Size: 0x71
function private function_56c130576c33f272( corpseent )
{
    corpseent endon( #"death" );
    attacker = self.explodeattacker;
    classname = self.classname;
    origin = self.origin;
    wait 1.5;
    explode( attacker, origin, classname );
    
    if ( corpseent )
    {
        corpseent delete();
    }
}

// Namespace sat_guild_bot
// Params 3, eflags: 0x4
// Checksum 0xe31aeaa9, Offset: 0x974
// Size: 0xf5
function private explode( attacker, origin, classname )
{
    aitypescriptbundle = getaitypescriptbundle( classname );
    var_a7504a3b26becde1 = function_d4f1a66123a91e7( aitypescriptbundle );
    
    if ( !var_a7504a3b26becde1 )
    {
        assertmsg( "<dev string:x24>" );
        return;
    }
    
    earthquake( var_a7504a3b26becde1.earthquakescale, var_a7504a3b26becde1.earthquakeduration, origin, var_a7504a3b26becde1.earthquakeradius );
    
    if ( !isplayer( attacker ) )
    {
        attacker = undefined;
    }
    
    radiusdamage( origin, var_a7504a3b26becde1.explosionradius, var_a7504a3b26becde1.explosionmaxdamage, var_a7504a3b26becde1.explosionmindamage, attacker );
    explosionfx = utility::getfx( "guild_bot_death_explosion" );
    
    if ( explosionfx )
    {
        playfx( explosionfx, origin );
    }
    
    playsoundatpos( origin + ( 0, 0, 5 ), #"hash_40ef3497abe6f53f" );
}

// Namespace sat_guild_bot
// Params 1, eflags: 0x4
// Checksum 0x92e26af4, Offset: 0xa71
// Size: 0x6e
function private on_emp_applied( data )
{
    self.var_b98e9791f01fb72d = 1;
    self.stunduration = randomintrange( 3000, 5000 );
    self dodamage( data.damage, self.origin );
    utility::function_32b24db3127bff40( #"emp", #"on" );
    self.stunduration = 0;
    thread function_8fa21fcad4c8b402();
}

// Namespace sat_guild_bot
// Params 0, eflags: 0x4
// Checksum 0x48b6e99c, Offset: 0xae7
// Size: 0x5d
function private function_8fa21fcad4c8b402()
{
    self endon( #"death" );
    
    if ( self.stunendtime )
    {
        delaysec = ( self.stunendtime - gettime() ) * 0.001;
        
        if ( delaysec > 0 )
        {
            wait delaysec;
        }
        
        utility::function_32b24db3127bff40( #"emp", #"off" );
    }
}

