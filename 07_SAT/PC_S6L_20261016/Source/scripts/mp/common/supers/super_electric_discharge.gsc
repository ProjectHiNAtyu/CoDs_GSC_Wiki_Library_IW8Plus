// scripts\mp\common\supers\super_electric_discharge.gsc  (hash_05fa29f2a86f9ead.gscc) (size: 8400 Bytes / 0x20d0 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x16da15b5 (383391157)
// size ...... 8400 (0x20d0)
// includes .. 14  (offset: 0x1e80)
// strings ... 32  (offset: 0x1ef0)
// dev strs .. 0   (offset: 0x20d0)
// exports ... 21  (offset: 0x12d8)
// cseg ...... 0x25f + 0x1079 (0x12d8)
// imports ... 73  (offset: 0x1620)
// animtree1 . 0   (offset: 0x20d0)
// animtree2 . 0   (offset: 0x20d0)
#using scripts\common\ae_utility;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\weapon;
#using scripts\mp\challenges;
#using scripts\mp\common\equipment\shock_stick;
#using scripts\mp\common\equipment\temp_v;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\player;
#using scripts\mp\emp_debuff;
#using scripts\mp\hud_message;
#using scripts\mp\shellshock;
#using scripts\mp\supers;

#namespace super_electric_discharge;

// Namespace super_electric_discharge
// Params 0, eflags: 0x1
// Checksum 0xa053bcb9, Offset: 0x27d
// Size: 0x9
function autoexec main()
{
    electricdischarge_init();
}

// Namespace super_electric_discharge
// Params 0
// Checksum 0xd6d566a7, Offset: 0x28e
// Size: 0xbb
function electricdischarge_init()
{
    utility::flag_wait( "supers_initialized" );
    supers_mp::function_48aaa60b2ce7b8a1( "super_electric_discharge", undefined, undefined, &function_17518d864d37d664, &function_15c998e310072ce4, undefined, undefined, undefined );
    val::group_register( "electricFire", [ "usability", "mantle", "armor", "supers", "killstreaks", "ladder", "melee", "execution_attack", "execution_victim" ] );
    utility::registersharedfunc( "super_electric_discharge", #"hash_e7f5542d22f154eb", &function_b8e9660f2a314ea );
    utility::registersharedfunc( "super_electric_discharge", #"endsuper", &function_15c998e310072ce4 );
}

// Namespace super_electric_discharge
// Params 0
// Checksum 0xe408f4a5, Offset: 0x351
// Size: 0x34
function function_17518d864d37d664()
{
    perk::giveperk( "specialty_blastshield" );
    result = function_f480f6348d8cf430();
    
    if ( !result )
    {
        perk::removeperk( "specialty_blastshield" );
    }
    
    return result;
}

// Namespace super_electric_discharge
// Params 0
// Checksum 0xb9ef3740, Offset: 0x38e
// Size: 0x46
function function_f480f6348d8cf430()
{
    if ( self isinexecutionattack() || self isinexecutionvictim() )
    {
        return 0;
    }
    
    thread hud_message::showsplash( "super_electric_discharge" + "_activate", undefined, self, undefined, undefined, undefined, 1 );
    self setscriptablepartstate( "superpowers", "electric_charge", 0 );
    return function_8cae331642b4d60e( undefined );
}

// Namespace super_electric_discharge
// Params 1
// Checksum 0x8dea0d28, Offset: 0x3dd
// Size: 0x136
function function_b8e9660f2a314ea( killstreakbundle )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    
    if ( self isinexecutionattack() || self isinexecutionvictim() )
    {
        return 0;
    }
    
    objweapon = makeweapon( "electric_discharge_mp" );
    heldoffhand = weapon::getgrenadeinpullback();
    
    if ( isdefined( heldoffhand ) && !isnullweapon( heldoffhand ) && heldoffhand != objweapon )
    {
        self.var_ac1fd60b757c54a = gettime();
    }
    
    if ( isdefined( self.var_ac1fd60b757c54a ) )
    {
        lastfiretime = self.var_ac1fd60b757c54a;
        
        if ( ( gettime() - lastfiretime ) / 1000 <= 1.5 )
        {
            return 0;
        }
    }
    
    if ( !function_5d64ce0aa1b44370() )
    {
        return 0;
    }
    
    self giveandfireoffhand( objweapon );
    val::group_set( "electricFire", 0 );
    result = function_b671cb4baa66a417();
    val::group_reset( "electricFire" );
    
    if ( result == "offhand_fired" || result == "timeout" )
    {
        return function_8cae331642b4d60e( killstreakbundle );
    }
    else if ( !isdefined( result ) || result == "death" )
    {
        self.var_ac1fd60b757c54a = undefined;
    }
    
    return 0;
}

// Namespace super_electric_discharge
// Params 0
// Checksum 0x8fcbb333, Offset: 0x51c
// Size: 0xc, Type: bool
function function_350a92f61ecb33b6()
{
    thread function_b8e9660f2a314ea( undefined );
    return true;
}

// Namespace super_electric_discharge
// Params 1, eflags: 0x4
// Checksum 0x7c346e68, Offset: 0x531
// Size: 0x71, Type: bool
function private function_8cae331642b4d60e( killstreakbundle )
{
    self notify( #"electric_blast_succeed" );
    self.var_ac1fd60b757c54a = gettime();
    
    if ( !isdefined( killstreakbundle ) )
    {
        self.super.isactive = 1;
        challenges::function_a0936b0e5b4550f3( "super_electric_discharge", ae_utility::function_2d1565a236387b2( #"loadout_item_method", #"use" ) );
    }
    
    thread electricdischarge_blast( killstreakbundle );
    return true;
}

// Namespace super_electric_discharge
// Params 0, eflags: 0x4
// Checksum 0xf410ef39, Offset: 0x5ab
// Size: 0x7a, Type: bool
function private function_5d64ce0aa1b44370()
{
    return player::isreallyalive( self ) && !player::isinlaststand( self ) && !self isonascender() && !self isonladder() && !self ismantling() && !self ishanging() && !self isinfreefall() && !self isparachuting() && !self isdiving() && !self ismeleeing() && !self isswitchingweapon() && !utility::isusingremote();
}

// Namespace super_electric_discharge
// Params 0, eflags: 0x4
// Checksum 0xee9d43fb, Offset: 0x62e
// Size: 0x44
function private function_b671cb4baa66a417()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    thread function_3dab93957a5641dd();
    result = utility::waittill_any_timeout( 0.9, "offhand_fired", "electric_blast_fail" );
    return result;
}

// Namespace super_electric_discharge
// Params 0
// Checksum 0xfc40814d, Offset: 0x67b
// Size: 0x52
function function_3dab93957a5641dd()
{
    self endon( #"disconnect" );
    self endon( #"electric_blast_succeed" );
    failblast = 0;
    
    while ( true )
    {
        if ( !function_5d64ce0aa1b44370() )
        {
            failblast = 1;
            break;
        }
        
        waitframe();
    }
    
    if ( failblast )
    {
        self notify( #"electric_blast_fail" );
    }
}

// Namespace super_electric_discharge
// Params 1, eflags: 0x4
// Checksum 0xbbe8918a, Offset: 0x6d5
// Size: 0x2a6
function private electricdischarge_blast( killstreakbundle )
{
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    thread function_15dbbd79b22e4e51();
    blastorigin = self.origin;
    blastangles = self.angles;
    step = 100;
    maxdist = isdefined( killstreakbundle ) ? killstreakbundle.electricdischarge_radius : 400;
    waittime = 0.1;
    currentdist = step;
    shockdata = function_23d98e039a552ac9();
    possibleplayers = utility::function_1b1340a94b43b874( self.origin, maxdist );
    var_d51eb95f460b110a = function_1293b51557137296( possibleplayers, blastorigin, shockdata );
    possibleents = emp_debuff::empdebuff_get_emp_ents();
    var_54f1799d880f7c72 = function_555f8930e51a1377( possibleents, blastorigin );
    
    while ( currentdist <= maxdist )
    {
        currentdistsq = currentdist * currentdist;
        var_9efdf63bfa0798b1 = [];
        
        foreach ( playerinfo in var_d51eb95f460b110a )
        {
            victim = playerinfo[ "player" ];
            var_a8640e403ed3ee1d = playerinfo[ "distanceSQ" ];
            
            if ( var_a8640e403ed3ee1d <= currentdistsq )
            {
                function_ba95ba871aa9061e( victim, shockdata );
                continue;
            }
            
            var_9efdf63bfa0798b1[ var_9efdf63bfa0798b1.size ] = playerinfo;
        }
        
        var_d51eb95f460b110a = var_9efdf63bfa0798b1;
        var_79b674af5e011569 = [];
        
        foreach ( entinfo in var_54f1799d880f7c72 )
        {
            ent = entinfo[ "entity" ];
            var_a8640e403ed3ee1d = entinfo[ "distanceSQ" ];
            
            if ( var_a8640e403ed3ee1d <= currentdistsq )
            {
                function_c2d44cea0913f987( ent );
                continue;
            }
            
            var_79b674af5e011569[ var_79b674af5e011569.size ] = entinfo;
        }
        
        var_54f1799d880f7c72 = var_79b674af5e011569;
        currentdist += step;
        wait waittime;
    }
    
    if ( !isdefined( killstreakbundle ) )
    {
        self.super.isactive = 0;
    }
    
    wait 1;
    self notify( #"finished_electric_blast" );
}

// Namespace super_electric_discharge
// Params 3
// Checksum 0xd352bf10, Offset: 0x983
// Size: 0xf0
function function_1293b51557137296( sourcearray, reforigin, shockdata )
{
    filteredplayers = [];
    
    foreach ( player in sourcearray )
    {
        if ( !isdefined( player ) )
        {
            continue;
        }
        
        if ( player == self )
        {
            continue;
        }
        
        if ( !player shock_stick::shockstick_canbehaywire( shockdata, 1 ) )
        {
            continue;
        }
        
        index = filteredplayers.size;
        filteredplayers[ index ][ "player" ] = player;
        filteredplayers[ index ][ "distanceSQ" ] = distancesquared( player.origin, reforigin );
    }
    
    return filteredplayers;
}

// Namespace super_electric_discharge
// Params 2
// Checksum 0x51aa6d6f, Offset: 0xa7c
// Size: 0x188
function function_555f8930e51a1377( sourcearray, reforigin )
{
    filteredents = [];
    
    foreach ( ent in sourcearray )
    {
        if ( !isdefined( ent ) || ent.isdestroyed )
        {
            continue;
        }
        
        if ( ent vehicle::is_vehicle() )
        {
            if ( !vehicle::is_enemy_to_player( ent, self ) && !vehicle::is_neutral_to_player( ent, self ) )
            {
                continue;
            }
        }
        else
        {
            var_7ad50cdbb03c5d89 = undefined;
            var_9c6c16bd6fe37abe = undefined;
            
            if ( isdefined( ent.owner ) )
            {
                var_7ad50cdbb03c5d89 = ent.owner.team;
                var_9c6c16bd6fe37abe = ent.owner;
            }
            else if ( isdefined( ent.team ) )
            {
                var_7ad50cdbb03c5d89 = ent.team;
            }
            
            if ( var_7ad50cdbb03c5d89 == self.team && var_9c6c16bd6fe37abe != self )
            {
                continue;
            }
        }
        
        index = filteredents.size;
        filteredents[ index ][ "entity" ] = ent;
        filteredents[ index ][ "distanceSQ" ] = distancesquared( ent.origin, reforigin );
    }
    
    return filteredents;
}

// Namespace super_electric_discharge
// Params 0
// Checksum 0xa04449fc, Offset: 0xc0d
// Size: 0xd0
function function_15dbbd79b22e4e51()
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    shakeduration = 0.75;
    var_39bbe706cd34d2ec = 0.25;
    var_39deeb06cd5b2370 = 0.15;
    var_39def506cd5b396e = 0.08;
    radiusscalemax = 200;
    radiusscalemid = 400;
    radiusscalemin = 600;
    shellshock::artillery_earthquake( self.origin, shakeduration, var_39bbe706cd34d2ec, var_39deeb06cd5b2370, var_39def506cd5b396e, radiusscalemax, radiusscalemid, radiusscalemin, undefined, 1, 1 );
    self setscriptablepartstate( "superpowers", "electric_blast", 0 );
    utility::waittill_any( "finished_electric_blast", "death" );
    self setscriptablepartstate( "superpowers", "off", 0 );
}

// Namespace super_electric_discharge
// Params 2
// Checksum 0xe9e91f08, Offset: 0xce5
// Size: 0x2b
function function_ba95ba871aa9061e( victim, shockdata )
{
    thread function_2be5813838cfed7( victim, shockdata.weapon, shockdata );
}

// Namespace super_electric_discharge
// Params 3
// Checksum 0xf53afeb9, Offset: 0xd18
// Size: 0x1b3
function function_2be5813838cfed7( victim, weaponobj, shockdata )
{
    self endon( #"disconnect" );
    victim endon( #"death_or_disconnect" );
    victim endon( #"haywire_cleared" );
    level endon( #"game_ended" );
    var_fe21c79ec13013d3 = shockdata.tableinfo.bundle.shockstick_tickinterval;
    totalshocktime = shockdata.tableinfo.bundle.var_c8bb02c8c8cd0442;
    
    if ( !isdefined( victim.var_99702520a6704748 ) )
    {
        victim.var_99702520a6704748 = 0;
    }
    
    victim.var_99702520a6704748++;
    
    if ( isdefined( victim.var_c3c0ab538286d048 ) )
    {
        if ( ( gettime() - victim.var_c3c0ab538286d048 ) / 1000 <= totalshocktime )
        {
            var_867e471e7074a065 = victim.var_99702520a6704748;
            totalshocktime = int( totalshocktime / var_867e471e7074a065 );
        }
    }
    
    shockendtime = gettime() + totalshocktime * 1000;
    victim.var_c3c0ab538286d048 = gettime();
    thread function_8ccf94dabf0cb177( victim, totalshocktime );
    
    while ( gettime() < shockendtime )
    {
        shockdata thread shock_stick::shockstick_applyhaywire( victim, shockdata.weapon, 0 );
        damage = isplayer( victim ) ? 3 : 5;
        
        if ( victim isswimming() )
        {
            damage *= 2;
        }
        
        victim dodamage( damage, victim.origin, self, self, "MOD_EXPLOSIVE", weaponobj, "torso_upper" );
        wait var_fe21c79ec13013d3;
    }
}

// Namespace super_electric_discharge
// Params 2
// Checksum 0xe8661ac8, Offset: 0xed3
// Size: 0x69
function function_8ccf94dabf0cb177( victim, totalshocktime )
{
    victim endon( #"disconnect" );
    victim notify( #"hash_9f6a4fabe9d92e6a" );
    victim endon( #"hash_9f6a4fabe9d92e6a" );
    level endon( #"game_ended" );
    victim utility::waittill_any_timeout( totalshocktime, "death", "last_stand_enter" );
    victim.var_99702520a6704748 = 0;
}

// Namespace super_electric_discharge
// Params 1
// Checksum 0x704ba7b5, Offset: 0xf44
// Size: 0x153
function function_c2d44cea0913f987( ent )
{
    electricweapon = makeweapon( "electric_discharge_mp" );
    
    if ( isdefined( ent ) )
    {
        if ( ent vehicle::is_vehicle() )
        {
            if ( ent.exfilhelicopter )
            {
                return;
            }
            else if ( isdefined( ent.bossname ) )
            {
                healthdamage = 200;
                
                if ( isdefined( ent.maxhealth ) )
                {
                    healthdamage = ent.maxhealth / 6;
                }
                
                ent dodamage( healthdamage, ent.origin, self, self, "MOD_EXPLOSIVE", electricweapon );
            }
            else if ( ent vehicle::is_killstreak() )
            {
                ent dodamage( 9999, ent.origin, self, self, "MOD_EXPLOSIVE", electricweapon );
            }
            else
            {
                ent.dontspawnhusk = 1;
                damagedata = spawnstruct();
                damagedata.attacker = self;
                damagedata.inflictor = ent;
                damagedata.objweapon = ent.objweapon;
                damagedata.meansofdeath = "MOD_EXPLOSIVE";
                ent vehicle::explode( damagedata );
            }
            
            return;
        }
        
        ent dodamage( 9999, ent.origin, self, self, "MOD_EXPLOSIVE", electricweapon );
    }
}

// Namespace super_electric_discharge
// Params 2
// Checksum 0xc0ff1f37, Offset: 0x109f
// Size: 0xa1, Type: bool
function function_15c998e310072ce4( var_84cc01f9d7273b1b, iskillstreak )
{
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    shouldfinish = 0;
    dontclear = 0;
    
    if ( !var_84cc01f9d7273b1b )
    {
        self waittill( #"finished_electric_blast" );
    }
    
    if ( isdefined( self.super ) && !iskillstreak )
    {
        self.super.isactive = 0;
    }
    
    perk::removeperk( "specialty_blastshield" );
    thread temp_v::function_6fde086c9d1330d9( shouldfinish, dontclear, "super_use_finished", istrue( iskillstreak ) );
    return true;
}

// Namespace super_electric_discharge
// Params 1
// Checksum 0x22914622, Offset: 0x1149
// Size: 0x18e
function function_23d98e039a552ac9( killstreakbundle )
{
    shockdata = spawnstruct();
    shockdata.tableinfo = weapon::getequipmenttableinfo( "equip_shockstick" );
    shockdata.owner = self;
    shockdata.team = self.team;
    shockdata.origin = self.origin;
    shockdata.weapon = makeweapon( "electric_discharge_mp" );
    duration = isdefined( killstreakbundle ) ? killstreakbundle.var_5c968add1d7fde16 : 5;
    shockdata.tableinfo.var_f3447a3874df563f = 0;
    shockdata.tableinfo.var_9891ed88bcd38fd2 = 1;
    shockdata.tableinfo.var_c6920ebeb7833310 = 1;
    shockdata.tableinfo.var_cd1e9f6afbf90d3a = 1;
    shockdata.tableinfo.bundle.var_f232776b54e76cfa = 0.3;
    shockdata.tableinfo.bundle.var_860545b754d7ecc0 = duration;
    shockdata.tableinfo.bundle.var_c8bb02c8c8cd0442 = duration;
    shockdata.tableinfo.bundle.shockstick_tickinterval = 0.2;
    return shockdata;
}

