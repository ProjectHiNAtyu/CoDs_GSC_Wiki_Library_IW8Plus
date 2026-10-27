// scripts\mp\common\weapons\br_damage.gsc  (hash_628e51afc62c7d42.gscc) (size: 8269 Bytes / 0x204d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x12b10ecc (313593548)
// size ...... 8269 (0x204d)
// includes .. 11  (offset: 0x1f25)
// strings ... 15  (offset: 0x1f7d)
// dev strs .. 0   (offset: 0x204d)
// exports ... 15  (offset: 0x1651)
// cseg ...... 0x167 + 0x14ea (0x1651)
// imports ... 50  (offset: 0x18a9)
// animtree1 . 0   (offset: 0x204d)
// animtree2 . 0   (offset: 0x204d)
#using scripts\common\ai\aitypes\shared\zombie\zombie_damage;
#using scripts\common\callbacks;
#using scripts\common\game_utility;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_damage;
#using scripts\mp\ai\ai_category;
#using scripts\mp\common\utility\game_utility;
#using scripts\mp\damagefeedback;
#using scripts\mp\mp_agent_damage;

#namespace br_damage;

// Namespace br_damage
// Params 0, eflags: 0x5
// Checksum 0xbdda82f7, Offset: 0x185
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"br_damage", undefined, undefined, &init );
}

// Namespace br_damage
// Params 0, eflags: 0x4
// Checksum 0xf86ac83a, Offset: 0x1a6
// Size: 0x88
function private init()
{
    level callback::add( "on_zombie_ai_spawned", &zombie_damage_on_spawned );
    level callback::add( "on_agent_spawned", &agent_damage_on_spawned );
    level callback::add( "on_zombie_ai_killed", &on_zombie_ai_killed );
    level callback::add( #"on_ai_killed", &function_9238338f068b6568 );
    utility::registersharedfunc( #"damage", #"hash_537f8ab65c181efd", &function_b9480d70719e3987 );
    callback::get_template( "zombie" ) callback::add( "on_zombie_ai_damaged", &on_zombie_ai_damaged );
}

// Namespace br_damage
// Params 1, eflags: 0x4
// Checksum 0x874afb25, Offset: 0x236
// Size: 0xa0
function private agent_damage_on_spawned( params )
{
    agent = params.agent;
    
    if ( agent.unittype != "soldier" && agent.unittype != "juggernaut" && agent.unittype != "dog" )
    {
        return;
    }
    
    agent.agent_damage_callback = &function_88e5812bbeba2168;
    agent.a_n_player_damage = [];
    agent.var_d4b7ed447e2bf50c = [];
    agent callback::add( "on_soldier_ai_damaged", &on_soldier_ai_damaged );
}

// Namespace br_damage
// Params 1, eflags: 0x4
// Checksum 0x2c1b8fc1, Offset: 0x2de
// Size: 0x1a
function private zombie_damage_on_spawned( params )
{
    self.agent_damage_callback = &function_ddf5f982ca376898;
}

// Namespace br_damage
// Params 14
// Checksum 0x309f0783, Offset: 0x300
// Size: 0x905
function function_ddf5f982ca376898( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon, poisedamage )
{
    params = { #objweapon:objweapon, #partname:partname, #modelindex:modelindex, #timeoffset:timeoffset, #shitloc:shitloc, #vdir:vdir, #vpoint:vpoint, #sweapon:sweapon, #smeansofdeath:smeansofdeath, #idflags:idflags, #idamage:idamage, #eattacker:eattacker, #einflictor:einflictor };
    
    if ( utility::issharedfuncdefined( #"zombie_damage", #"builddamagestruct" ) )
    {
        dmg_struct = utility::callsharedfunc( #"zombie_damage", #"builddamagestruct", params );
    }
    
    if ( isdefined( self.last_dmg_struct ) )
    {
        dmg_struct.num_hits = self.last_dmg_struct.num_hits;
    }
    else
    {
        dmg_struct.num_hits = 0;
    }
    
    dmg_struct.num_hits++;
    
    if ( utility::issharedfuncdefined( #"zombie_damage", #"shouldskipdamage" ) )
    {
        if ( utility::callsharedfunc( #"zombie_damage", #"shouldskipdamage", eattacker, objweapon, smeansofdeath ) )
        {
            if ( isplayer( eattacker ) && self.team != eattacker.team )
            {
                eattacker damagefeedback::updatedamagefeedback( "standard", 0 );
            }
            
            return 0;
        }
    }
    
    if ( self.var_7037157e68c4992b == dmg_struct.idamage )
    {
        dmg_struct.var_d33b5d20cf3b0e9b = 1;
        self.var_7037157e68c4992b = undefined;
    }
    
    if ( game_utility::function_c446c60d2979dbfe() )
    {
        dmg_struct.idamage = zombie_damage::function_cef159ba09a96f98( dmg_struct );
    }
    
    if ( utility::issharedfuncdefined( #"zombie_damage", #"adjustdamageunderbarrel" ) )
    {
        dmg_struct.idamage = utility::callsharedfunc( #"zombie_damage", #"adjustdamageunderbarrel", dmg_struct );
    }
    
    if ( utility::issharedfuncdefined( #"zombie_damage", #"adjustdamagerarity" ) )
    {
        dmg_struct.idamage = utility::callsharedfunc( #"zombie_damage", #"adjustdamagerarity", dmg_struct );
    }
    
    if ( utility::issharedfuncdefined( #"zombie_damage", #"hash_5e54d804a8307343" ) )
    {
        dmg_struct.idamage = utility::callsharedfunc( #"zombie_damage", #"hash_5e54d804a8307343", dmg_struct );
    }
    
    if ( utility::issharedfuncdefined( #"zombie_damage", #"adjustdamagespecific" ) )
    {
        dmg_struct.idamage = utility::callsharedfunc( #"zombie_damage", #"adjustdamagespecific", dmg_struct );
    }
    
    if ( utility::issharedfuncdefined( #"zombie_damage", #"adjustdamagemercs" ) )
    {
        dmg_struct.idamage = utility::callsharedfunc( #"zombie_damage", #"adjustdamagemercs", dmg_struct );
    }
    
    if ( utility::issharedfuncdefined( #"zombie_damage", #"hash_db261451b4d687b" ) )
    {
        dmg_struct.idamage = utility::callsharedfunc( #"zombie_damage", #"hash_db261451b4d687b", dmg_struct );
    }
    
    if ( utility::issharedfuncdefined( #"zombie_damage", #"adjustdamageshield" ) )
    {
        dmg_struct.idamage = utility::callsharedfunc( #"zombie_damage", #"adjustdamageshield", dmg_struct );
    }
    
    if ( utility::issharedfuncdefined( #"zombie_damage", #"hash_7b7e42eb24435073" ) )
    {
        dmg_struct.idamage = utility::callsharedfunc( #"zombie_damage", #"hash_7b7e42eb24435073", dmg_struct );
    }
    
    if ( game_utility::function_c446c60d2979dbfe() )
    {
        assert( isdefined( dmg_struct.idamage ) );
    }
    else
    {
        assert( dmg_struct.idamage > 0 && int( dmg_struct.idamage ) > 0 );
    }
    
    if ( utility::issharedfuncdefined( #"zombie_damage", #"adjustdamagekillcallbacks" ) )
    {
        dmg_struct.idamage = utility::callsharedfunc( #"zombie_damage", #"adjustdamagekillcallbacks", dmg_struct );
    }
    
    if ( isdefined( dmg_struct.eattacker ) && isplayer( dmg_struct.eattacker.owner ) )
    {
        dmg_struct.eattacker = dmg_struct.eattacker.owner;
    }
    
    if ( isexplosivedamagemod( smeansofdeath ) )
    {
        if ( utility::issharedfuncdefined( #"thermobaric_grenade", #"thermobaric_additional_explosive_damage" ) )
        {
            dmg_struct.idamage += [[ utility::getsharedfunc( #"thermobaric_grenade", #"thermobaric_additional_explosive_damage" ) ]]( self, eattacker, dmg_struct.idamage );
        }
    }
    
    if ( utility::issharedfuncdefined( #"zombie_damage", #"checkdamagedarmor" ) )
    {
        utility::callsharedfunc( #"zombie_damage", #"checkdamagedarmor", dmg_struct );
    }
    
    if ( utility::issharedfuncdefined( #"zombie_damage", #"checkarmorhitmarker" ) )
    {
        thread utility::callsharedfunc( #"zombie_damage", #"checkarmorhitmarker", dmg_struct.eattacker, dmg_struct.var_4f9d5587bf9a2b1e, "hitarmorlight" );
    }
    
    if ( utility::issharedfuncdefined( #"zombie_damage", #"adjustdamageexposedhead" ) )
    {
        utility::callsharedfunc( #"zombie_damage", #"adjustdamageexposedhead", dmg_struct );
    }
    
    if ( utility::issharedfuncdefined( #"zombie_damage", #"hash_ae192973716b5437" ) )
    {
        utility::callsharedfunc( #"zombie_damage", #"hash_ae192973716b5437", dmg_struct );
    }
    
    if ( utility::issharedfuncdefined( #"zombie_damage", #"damagemetabone" ) )
    {
        utility::callsharedfunc( #"zombie_damage", #"damagemetabone", dmg_struct );
    }
    
    if ( utility::issharedfuncdefined( #"zombie_damage", #"adjustdamagearmor" ) )
    {
        utility::callsharedfunc( #"zombie_damage", #"adjustdamagearmor", dmg_struct );
    }
    
    utility::callsharedfunc( #"zombie_damage", #"hash_35082172ddd8a685", dmg_struct );
    zombie_damage::function_f02b21908b7bd90d( dmg_struct );
    
    if ( self.killondamage )
    {
        dmg_struct.idamage = self.health;
    }
    
    if ( isdefined( eattacker ) && ( isplayer( eattacker ) || isplayer( eattacker.owner ) ) )
    {
        eplayer = eattacker;
        var_2783eb34c3422e11 = undefined;
        
        if ( isplayer( eattacker.owner ) )
        {
            eplayer = eattacker.owner;
        }
        
        if ( isdefined( level.gamemodebundle ) && level.gamemodebundle.var_7e288d244d3717ca || getdvarint( @"hash_1661f35e34f544eb", 0 ) )
        {
            mp_agent_damage::function_eb8ba16055d6da7c( eplayer, self, shitloc, smeansofdeath, objweapon, int( dmg_struct.idamage ), vpoint, 0, undefined, dmg_struct.biscritical, dmg_struct.var_4f9d5587bf9a2b1e );
        }
        
        if ( isplayer( eattacker ) && dmg_struct.idamage > 0 && shitloc != "shield" && !isdefined( var_2783eb34c3422e11 ) )
        {
            eattacker damagefeedback::updatedamagefeedback( "standard", dmg_struct.idamage >= self.health, dmg_struct.biscritical );
        }
    }
    
    self.last_dmg_struct = dmg_struct;
    callback::callback( "on_zombie_ai_damaged", dmg_struct );
    
    if ( isdefined( eattacker ) && isdefined( eattacker.is_quest_ai ) )
    {
        var_dda424c349037c52 = 200;
        
        if ( isdefined( dmg_struct ) && isdefined( dmg_struct.idamage ) )
        {
            dmg_struct.idamage *= var_dda424c349037c52;
        }
    }
    
    var_c354cbe81abad2 = int( dmg_struct.idamage );
    
    if ( !isdefined( var_c354cbe81abad2 ) || var_c354cbe81abad2 < 0 )
    {
        assert( 0 );
        var_c354cbe81abad2 = 0;
    }
    
    return var_c354cbe81abad2;
}

// Namespace br_damage
// Params 1, eflags: 0x4
// Checksum 0x4d224119, Offset: 0xc0e
// Size: 0x100
function private on_zombie_ai_damaged( dmg_struct )
{
    if ( isplayer( dmg_struct.eattacker ) && isdefined( self.a_n_player_damage ) )
    {
        self.a_n_player_damage = arraycombineunique( self.a_n_player_damage, [ dmg_struct.eattacker ] );
    }
    
    vehicle_damage::function_182f0b7ab120aa9b( dmg_struct );
    
    if ( utility::issharedfuncdefined( #"zombie_damage", #"hash_3a2f9b37a2a2d1e2" ) )
    {
        thread utility::callsharedfunc( #"zombie_damage", #"hash_3a2f9b37a2a2d1e2", dmg_struct );
    }
    
    dmg_struct.eattacker notify( #"hash_3a789df9d545be13", self, dmg_struct.einflictor, dmg_struct.idamage, dmg_struct.idflags, dmg_struct.smeansofdeath, dmg_struct.objweapon, dmg_struct.vpoint, dmg_struct.vdir, dmg_struct.shitloc );
}

// Namespace br_damage
// Params 3, eflags: 0x4
// Checksum 0xfd477e54, Offset: 0xd16
// Size: 0x4e
function private function_fd5f6e73cbb5e11( dmg_struct, shitloc, var_951c89546ec50477 )
{
    if ( shitloc == "head" || shitloc == "neck" )
    {
        dmg_struct.biscritical = 1;
    }
    
    return dmg_struct.idamage;
}

// Namespace br_damage
// Params 14
// Checksum 0x3fcf11bd, Offset: 0xd6d
// Size: 0x404
function function_88e5812bbeba2168( einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon, poisedamage )
{
    if ( self.var_a6ecefe6814132d4 )
    {
        return 0;
    }
    
    dmg_struct = spawnstruct();
    dmg_struct.einflictor = einflictor;
    dmg_struct.eattacker = eattacker;
    dmg_struct.idamage = idamage;
    dmg_struct.idflags = idflags;
    dmg_struct.smeansofdeath = smeansofdeath;
    dmg_struct.sweapon = sweapon;
    dmg_struct.vpoint = vpoint;
    dmg_struct.vdir = vdir;
    dmg_struct.shitloc = shitloc;
    dmg_struct.timeoffset = timeoffset;
    dmg_struct.modelindex = modelindex;
    dmg_struct.partname = partname;
    dmg_struct.objweapon = objweapon;
    dmg_struct.biscritical = 0;
    dmg_struct.var_4f9d5587bf9a2b1e = 0;
    
    if ( isdefined( self.last_dmg_struct ) )
    {
        dmg_struct.num_hits = self.last_dmg_struct.num_hits;
    }
    else
    {
        dmg_struct.num_hits = 0;
    }
    
    dmg_struct.num_hits++;
    var_951c89546ec50477 = 0;
    
    if ( utility::issharedfuncdefined( #"zombie", #"get_pap_level" ) && isplayer( dmg_struct.eattacker ) )
    {
        var_951c89546ec50477 = dmg_struct.eattacker utility::callsharedfunc( #"zombie", #"get_pap_level", dmg_struct.objweapon );
    }
    
    if ( var_951c89546ec50477 >= 1 )
    {
        dmg_struct.idamage /= 2;
    }
    
    dmg_struct.idamage = function_fd5f6e73cbb5e11( dmg_struct, shitloc, var_951c89546ec50477 );
    
    if ( isplayer( eattacker ) && utility::issharedfuncdefined( #"player", #"hash_b0979c1a1f9ea686" ) )
    {
        var_4346ca48d4b756d8 = eattacker [[ utility::getsharedfunc( #"player", #"hash_b0979c1a1f9ea686" ) ]]( dmg_struct );
        
        if ( var_4346ca48d4b756d8 != -1 )
        {
            dmg_struct.idamage = var_4346ca48d4b756d8;
        }
    }
    
    dmg_struct.idamage = function_87aebf397086e82f( dmg_struct );
    final_damage = dmg_struct.idamage;
    
    if ( isarray( level.var_e8f6b03121a2f56d ) )
    {
        foreach ( func in level.var_e8f6b03121a2f56d )
        {
            new_damage = self [[ func ]]( dmg_struct );
            
            if ( new_damage != -1 )
            {
                final_damage = new_damage;
            }
        }
    }
    
    if ( self.agentdamagefeedback && eattacker && isplayer( eattacker ) && dmg_struct.idamage > 0 && shitloc != "shield" )
    {
        eattacker damagefeedback::updatedamagefeedback( "standard", dmg_struct.idamage >= self.health, dmg_struct.biscritical );
    }
    
    self.last_dmg_struct = dmg_struct;
    callback::callback( "on_soldier_ai_damaged", dmg_struct );
    return int( final_damage );
}

// Namespace br_damage
// Params 1
// Checksum 0x416ee736, Offset: 0x117a
// Size: 0x78, Type: bool
function function_7dbf55bd3bfe1bc8( dmg_struct )
{
    return isdefined( dmg_struct.einflictor ) && dmg_struct.einflictor vehicle::is_vehicle() && !isdefined( dmg_struct.einflictor.is_neutralizing ) && dmg_struct.smeansofdeath == "MOD_CRUSH" && !isdefined( dmg_struct.einflictor.b_collided );
}

// Namespace br_damage
// Params 1, eflags: 0x4
// Checksum 0xfc3bc14a, Offset: 0x11fb
// Size: 0x141
function private function_87aebf397086e82f( dmg_struct )
{
    attackent = dmg_struct.eattacker ?? dmg_struct.einflictor;
    var_de1f53206b410ff1 = dmg_struct.idamage;
    
    if ( dmg_struct.smeansofdeath == "MOD_CRUSH" && attackent.vehicletype )
    {
        var_e2135a579d15e713 = attackent.var_429d5e520209434f;
        ref = attackent vehicle::get_ref();
        bundledata = vehicle::get_data( ref );
        splatter = ai_category::function_e6e323e14b12152e( self ) == #"normal";
        
        if ( var_e2135a579d15e713 || bundledata )
        {
            var_4a476503463c1c7b = 100;
            
            if ( !splatter )
            {
                if ( getdvarint( @"hash_6509aeb82d1786b4", 0 ) )
                {
                    var_4a476503463c1c7b = 0;
                }
                else
                {
                    var_4a476503463c1c7b = var_e2135a579d15e713.var_7745fa28bf3b3008 ?? bundledata.damage.var_7745fa28bf3b3008 ?? 100;
                }
            }
            
            var_de1f53206b410ff1 = min( self.maxhealth * var_4a476503463c1c7b / 100, var_de1f53206b410ff1 );
        }
    }
    
    return var_de1f53206b410ff1;
}

// Namespace br_damage
// Params 4, eflags: 0x4
// Checksum 0x454f913c, Offset: 0x1345
// Size: 0x1fd
function private function_b9480d70719e3987( vehicle, agent, bpbundle, vehbundle )
{
    var_1889ca0c89277604 = 100;
    
    if ( agent.type == "zombie" && isdefined( agent.aicategory ) )
    {
        switch ( agent.aicategory )
        {
            case #"hash_84fcf5e68d7230b2":
                var_1889ca0c89277604 = bpbundle.var_629984d018f37877 ?? vehbundle.damage.var_629984d018f37877 ?? 0;
                break;
            case #"hash_8c089e813083e510":
                var_1889ca0c89277604 = bpbundle.var_67ee6478ec16e55d ?? vehbundle.damage.var_67ee6478ec16e55d ?? 0;
                break;
            case #"hash_7b0e2f2ed84f34":
                var_1889ca0c89277604 = bpbundle.var_c628f12f50dc18e1 ?? vehbundle.damage.var_c628f12f50dc18e1 ?? 0;
                break;
            case #"hash_4e47eb6c32f5b165":
            case #"hash_7e8a002ed096276c":
                var_1889ca0c89277604 = bpbundle.var_63e605add1ac73ba ?? vehbundle.damage.var_63e605add1ac73ba ?? 0;
                break;
        }
    }
    else if ( ai_category::function_e6e323e14b12152e( agent ) == #"normal" )
    {
        var_1889ca0c89277604 = bpbundle.var_5fd015e4443da02f ?? vehbundle.damage.var_5fd015e4443da02f ?? 0;
    }
    else if ( getdvarint( @"hash_6509aeb82d1786b4", 0 ) )
    {
        var_1889ca0c89277604 = 0;
    }
    else
    {
        var_1889ca0c89277604 = bpbundle.var_328f66d67049c4d7 ?? vehbundle.damage.var_328f66d67049c4d7 ?? 0;
    }
    
    return var_1889ca0c89277604;
}

// Namespace br_damage
// Params 1, eflags: 0x4
// Checksum 0x263676fb, Offset: 0x154b
// Size: 0x66
function private on_soldier_ai_damaged( dmg_struct )
{
    if ( isplayer( dmg_struct.eattacker ) && isdefined( self.a_n_player_damage ) )
    {
        self.a_n_player_damage = arraycombineunique( self.a_n_player_damage, [ dmg_struct.eattacker ] );
    }
    
    if ( function_7dbf55bd3bfe1bc8( dmg_struct ) )
    {
        vehicle_damage::function_182f0b7ab120aa9b( dmg_struct );
    }
}

// Namespace br_damage
// Params 1, eflags: 0x4
// Checksum 0xeffe01dc, Offset: 0x15b9
// Size: 0x7d
function private on_zombie_ai_killed( params )
{
    playerattacker = params.eattacker;
    
    if ( isdefined( playerattacker ) && !isplayer( playerattacker ) && isplayer( playerattacker.owner ) )
    {
        playerattacker = playerattacker.owner;
    }
    
    if ( isplayer( playerattacker ) )
    {
        playerattacker thread mp_agent_damage::updaterecentagentkills( self, params.einflictor, params.objweapon );
    }
}

// Namespace br_damage
// Params 1, eflags: 0x4
// Checksum 0x9157b53f, Offset: 0x163e
// Size: 0x13
function private function_9238338f068b6568( params )
{
    game_utility_common::removefromcharactersarray();
}

