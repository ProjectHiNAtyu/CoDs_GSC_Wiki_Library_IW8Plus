// script_509ede0e14af6ac2  (hash_509ede0e14af6ac2.gscc) (size: 11541 Bytes / 0x2d15 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x5748263 (91521635)
// size ...... 11541 (0x2d15)
// includes .. 3   (offset: 0x2af1)
// strings ... 36  (offset: 0x2b09)
// dev strs .. 4   (offset: 0x2ce5)
// exports ... 25  (offset: 0x204d)
// cseg ...... 0x234 + 0x1e19 (0x204d)
// imports ... 52  (offset: 0x2435)
// animtree1 . 0   (offset: 0x2d15)
// animtree2 . 0   (offset: 0x2d15)
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\mp\gamelogic;

#namespace namespace_db65df962cb5e2f;

// Namespace namespace_db65df962cb5e2f
// Params 0, eflags: 0x1
// Checksum 0xbb884144, Offset: 0x252
// Size: 0x12d
function autoexec init()
{
    if ( getdvarint( @"hash_dae0631dad1fcd73", 0 ) == 1 )
    {
        return;
    }
    
    level.var_ee980b280f978ae = 1;
    callback::add( #"game_ended", &ongameended );
    callback::add( #"player_disconnect", &onplayerdisconnect );
    callback::add( #"grenade_fire", &function_64af816bf48b7fa0 );
    callback::add( #"player_damaged", &onplayerdamaged );
    utility::registersharedfunc( #"analytics", #"hash_eb9d0dae8f38111f", &function_7c9e3b05d4d51759 );
    utility::registersharedfunc( #"analytics", #"hash_22a37c3ed1cf5035", &function_929352f964cfc255 );
    utility::registersharedfunc( #"analytics", #"hash_e348d92f8fdade0c", &function_f462d80e58c15dac );
    utility::registersharedfunc( #"analytics", #"hash_c7076e2f7f3569a0", &function_ca516d0e3a73dcc0 );
    utility::registersharedfunc( #"analytics", #"hash_8a1c3c9f6fc3016", &function_8b6c1753f5c7714e );
    level.var_ef574efbcf64fb43 = 0;
    level.var_c06e0855fd99b957 = getdvarint( @"hash_6f3839556ced3114", 0 );
}

// Namespace namespace_db65df962cb5e2f
// Params 0, eflags: 0x4
// Checksum 0xce050f9f, Offset: 0x387
// Size: 0x15
function private function_d2a213a701678c9b()
{
    level.var_ef574efbcf64fb43++;
    return level.var_ef574efbcf64fb43;
}

// Namespace namespace_db65df962cb5e2f
// Params 1, eflags: 0x4
// Checksum 0x47961010, Offset: 0x3a5
// Size: 0x15a
function private function_7c9e3b05d4d51759( params )
{
    if ( !isdefined( level.var_6b4168f64ed0ac1f ) )
    {
        level.var_6b4168f64ed0ac1f = [];
    }
    
    if ( !params.equipref )
    {
        return;
    }
    
    level.var_6b4168f64ed0ac1f[ params.equipref ] = [];
    
    if ( params.customstart )
    {
        level.var_6b4168f64ed0ac1f[ params.equipref ][ level.var_6b4168f64ed0ac1f[ params.equipref ].size ] = "start";
    }
    
    if ( params.customhit )
    {
        level.var_6b4168f64ed0ac1f[ params.equipref ][ level.var_6b4168f64ed0ac1f[ params.equipref ].size ] = "hit";
    }
    
    if ( params.customend )
    {
        level.var_6b4168f64ed0ac1f[ params.equipref ][ level.var_6b4168f64ed0ac1f[ params.equipref ].size ] = "end";
    }
    
    if ( params.var_e7d8089975495767 )
    {
        if ( !isdefined( level.var_ac7e180ce19fc13d ) )
        {
            level.var_ac7e180ce19fc13d = [];
        }
        
        level.var_ac7e180ce19fc13d[ params.equipref ] = { #var_e7d8089975495767:params.var_e7d8089975495767 };
    }
    
    return 1;
}

// Namespace namespace_db65df962cb5e2f
// Params 1, eflags: 0x4
// Checksum 0x80061685, Offset: 0x508
// Size: 0x69
function private function_929352f964cfc255( params )
{
    if ( gamelogic_mp::inprematch() && !level.var_c06e0855fd99b957 )
    {
        return;
    }
    
    extractedparams = function_24e7add2fe5a229( params );
    
    if ( !function_c7b1a656bcc1862d( extractedparams, "start" ) )
    {
        return;
    }
    
    data = extractedparams.owner function_4fb68036b3f28338( extractedparams );
    return data;
}

// Namespace namespace_db65df962cb5e2f
// Params 1, eflags: 0x4
// Checksum 0xa1165ba6, Offset: 0x57a
// Size: 0xbd
function private function_f462d80e58c15dac( params )
{
    if ( gamelogic_mp::inprematch() && !level.var_c06e0855fd99b957 )
    {
        return;
    }
    
    extractedparams = function_24e7add2fe5a229( params );
    
    if ( !extractedparams.owner )
    {
        return;
    }
    
    if ( !function_c7b1a656bcc1862d( extractedparams, "end" ) )
    {
        return;
    }
    
    data = extractedparams.owner function_d31021d22ae9d3a( extractedparams );
    
    if ( data )
    {
        data.deathtimestamp = gettime();
        data.deathorigin = extractedparams.position;
        wait 1;
        extractedparams.owner function_df9cddcfc3bbad55( data );
        return 1;
    }
}

// Namespace namespace_db65df962cb5e2f
// Params 1, eflags: 0x4
// Checksum 0x40ce8d21, Offset: 0x63f
// Size: 0x52
function private function_ca516d0e3a73dcc0( params )
{
    if ( gamelogic_mp::inprematch() && !level.var_c06e0855fd99b957 )
    {
        return;
    }
    
    extractedparams = function_24e7add2fe5a229( params );
    
    if ( !function_c7b1a656bcc1862d( extractedparams, "hit" ) )
    {
        return;
    }
    
    return function_1d3218ab226b9d7a( extractedparams );
}

// Namespace namespace_db65df962cb5e2f
// Params 2, eflags: 0x4
// Checksum 0x1c8392c5, Offset: 0x69a
// Size: 0x70
function private function_c7b1a656bcc1862d( params, type )
{
    extractedparams = function_24e7add2fe5a229( params );
    var_d0f965d30c2c0c26 = function_9589a51c75254f75( extractedparams, type );
    assert( var_d0f965d30c2c0c26, "<dev string:x24>" + type + "<dev string:x59>" + ( extractedparams.equipref ?? "<dev string:x68>" ) + "<dev string:x70>" );
    return var_d0f965d30c2c0c26;
}

// Namespace namespace_db65df962cb5e2f
// Params 2, eflags: 0x4
// Checksum 0x6ea4825, Offset: 0x713
// Size: 0x65, Type: bool
function private function_9589a51c75254f75( params, type )
{
    extractedparams = function_24e7add2fe5a229( params );
    equipref = extractedparams.equipref;
    return equipref && level.var_6b4168f64ed0ac1f[ equipref ] && arraycontains( level.var_6b4168f64ed0ac1f[ equipref ], type );
}

// Namespace namespace_db65df962cb5e2f
// Params 1, eflags: 0x4
// Checksum 0x525e0b2c, Offset: 0x781
// Size: 0x80
function private function_64af816bf48b7fa0( params )
{
    if ( gamelogic_mp::inprematch() && !level.var_c06e0855fd99b957 )
    {
        return;
    }
    
    extractedparams = function_24e7add2fe5a229( params );
    
    if ( isvalidgrenade( extractedparams.ent ) )
    {
        if ( !function_9589a51c75254f75( extractedparams, "start" ) )
        {
            function_4fb68036b3f28338( extractedparams );
        }
        
        if ( !function_9589a51c75254f75( extractedparams, "end" ) )
        {
            thread function_89bfaa23f64b7de2( extractedparams );
        }
    }
}

// Namespace namespace_db65df962cb5e2f
// Params 2, eflags: 0x4
// Checksum 0x18badf08, Offset: 0x809
// Size: 0x5b
function private onplayerdamaged( params, additional_params )
{
    if ( gamelogic_mp::inprematch() && !level.var_c06e0855fd99b957 )
    {
        return;
    }
    
    extractedparams = function_24e7add2fe5a229( params );
    
    if ( !function_9589a51c75254f75( extractedparams, "hit" ) )
    {
        function_1d3218ab226b9d7a( extractedparams );
    }
}

// Namespace namespace_db65df962cb5e2f
// Params 1, eflags: 0x4
// Checksum 0x80367e7f, Offset: 0x86c
// Size: 0xc7
function private onplayerdisconnect( params )
{
    if ( gamelogic_mp::inprematch() && !level.var_c06e0855fd99b957 )
    {
        return;
    }
    
    if ( self.var_b2d22f0552f330f4 || !self.var_282f154140c2a661 )
    {
        return;
    }
    
    self.var_b2d22f0552f330f4 = 1;
    
    foreach ( data in arraycopy( self.var_282f154140c2a661 ) )
    {
        function_df9cddcfc3bbad55( data );
    }
}

// Namespace namespace_db65df962cb5e2f
// Params 1, eflags: 0x4
// Checksum 0xbf72ef48, Offset: 0x93b
// Size: 0x148
function private ongameended( params )
{
    if ( gamelogic_mp::inprematch() && !level.var_c06e0855fd99b957 )
    {
        return;
    }
    
    foreach ( player in level.players )
    {
        if ( !player || player.var_b2d22f0552f330f4 || !player.var_282f154140c2a661 )
        {
            continue;
        }
        
        player.var_b2d22f0552f330f4 = 1;
        
        foreach ( data in arraycopy( player.var_282f154140c2a661 ) )
        {
            player function_df9cddcfc3bbad55( data );
        }
    }
}

// Namespace namespace_db65df962cb5e2f
// Params 1, eflags: 0x4
// Checksum 0x8a34f7dc, Offset: 0xa8b
// Size: 0x1d3
function private function_4fb68036b3f28338( params )
{
    extractedparams = function_24e7add2fe5a229( params );
    
    if ( !extractedparams.equipbundle )
    {
        return;
    }
    
    if ( !isdefined( extractedparams.owner.var_282f154140c2a661 ) )
    {
        extractedparams.owner.var_282f154140c2a661 = [];
    }
    
    id = function_d2a213a701678c9b();
    
    if ( isent( extractedparams.ent ) && extractedparams.ent.type != "weapon" )
    {
        extractedparams.ent.eventid = id;
    }
    
    player = extractedparams.owner;
    
    if ( !isdefined( player.var_282f154140c2a661 ) )
    {
        player.var_282f154140c2a661 = [];
    }
    
    data = { #type:extractedparams.equipbundle.equipmenttype, #equipbundle:extractedparams.equipbundle, #eventid:id, #playerdamagedata:[], #equipref:extractedparams.equipref, #ref:extractedparams.itemref, #playerorigin:player.origin, #timestamp:gettime(), #ent:extractedparams.ent, #owner:extractedparams.owner, #var_e73d1866abb04275:1 };
    player.var_282f154140c2a661[ player.var_282f154140c2a661.size ] = data;
    return data;
}

// Namespace namespace_db65df962cb5e2f
// Params 1, eflags: 0x4
// Checksum 0x16f65227, Offset: 0xc67
// Size: 0x48a
function private function_1d3218ab226b9d7a( params )
{
    extractedparams = function_24e7add2fe5a229( params );
    attacker = extractedparams.owner;
    victim = extractedparams.victim;
    ent = extractedparams.ent;
    
    if ( attacker && victim )
    {
        lifetimedata = attacker function_d31021d22ae9d3a( extractedparams );
        
        if ( lifetimedata )
        {
            if ( !isdefined( lifetimedata.playerdamagedata ) )
            {
                lifetimedata.playerdamagedata = [];
            }
            
            id = "";
            
            if ( isplayer( victim ) )
            {
                id = victim getxuid();
            }
            else if ( isbot( victim ) )
            {
                id = victim getplayerunoid();
            }
            
            guid = attacker getguid();
            var_e92d4b90338af943 = victim.inlaststand && ( victim.laststanddowneddata.inflictor == lifetimedata.ent || victim.laststanddowneddata.inflictor.eventid == lifetimedata.eventid );
            var_68819ca065cc7c83 = victim.inlaststand && !var_e92d4b90338af943;
            
            if ( guid && victim.attackerdata[ guid ] && victim.attackerdata[ guid ].attackerent && victim.attackerdata[ guid ].attackerent == attacker )
            {
                var_5731d2416862bf51 = victim.attackerdata[ guid ].inflictor && ( victim.attackerdata[ guid ].inflictor == lifetimedata.ent || victim.attackerdata[ guid ].inflictor.eventid == lifetimedata.eventid );
                killed = var_5731d2416862bf51 && victim.attackerdata[ guid ].killedby;
            }
            
            hdamage = ( extractedparams.healthdamage ? max( extractedparams.healthdamage, 0 ) : 0 ) ?? 0;
            adamage = ( extractedparams.armordamage ? max( extractedparams.armordamage, 0 ) : 0 ) ?? 0;
            
            if ( !lifetimedata.playerdamagedata[ id ] )
            {
                damagedata = { #hits:extractedparams.hits ?? 1, #killed:killed ?? 0, #var_e92d4b90338af943:var_e92d4b90338af943 ?? 0, #var_77b864909d82bb43:var_68819ca065cc7c83 ? hdamage + adamage : 0, #victimpos:victim.origin ?? ( 0, 0, 0 ), #victim:id, #totaldamage:hdamage + adamage ?? 0, #armordamage:!var_68819ca065cc7c83 ? adamage : 0, #healthdamage:!var_68819ca065cc7c83 ? hdamage : 0 };
                lifetimedata.playerdamagedata[ id ] = damagedata;
            }
            else
            {
                damagedata = lifetimedata.playerdamagedata[ id ];
                
                if ( !var_68819ca065cc7c83 )
                {
                    damagedata.healthdamage += hdamage ?? 0;
                    damagedata.armordamage += adamage ?? 0;
                    damagedata.totaldamage = damagedata.healthdamage + ( damagedata.armordamage ?? 0 );
                }
                else
                {
                    damagedata.var_77b864909d82bb43 += hdamage + ( adamage ?? 0 );
                }
                
                damagedata.var_e92d4b90338af943 |= var_e92d4b90338af943 ?? 0;
                damagedata.killed |= killed ?? 0;
                damagedata.hits++;
            }
            
            return damagedata;
        }
    }
}

// Namespace namespace_db65df962cb5e2f
// Params 1, eflags: 0x4
// Checksum 0xdb6ff66b, Offset: 0x10f9
// Size: 0x151
function private function_89bfaa23f64b7de2( params )
{
    extractedparams = function_24e7add2fe5a229( params );
    player = extractedparams.owner;
    level endon( #"game_ended" );
    player endon( #"disconnect" );
    data = function_d31021d22ae9d3a( extractedparams );
    
    if ( !data )
    {
        return;
    }
    
    data notify( #"hash_fc18c3737943e269" );
    data endon( #"hash_fc18c3737943e269" );
    childthread watchfordeath( extractedparams.ent, data );
    
    if ( isvalidgrenade( extractedparams.ent ) )
    {
        childthread watchforexplode( extractedparams.ent, data );
        childthread function_68e79e8e0f7b1e3b( extractedparams.ent, data );
    }
    
    data waittill( #"hash_498271ae1f8f2b6c", pos );
    data.deathorigin = level.var_ac7e180ce19fc13d[ data.equipref ].var_e7d8089975495767 ? player.origin : pos ?? data.deathorigin;
    data.deathtimestamp = gettime();
    wait 1;
    function_df9cddcfc3bbad55( data );
}

// Namespace namespace_db65df962cb5e2f
// Params 2, eflags: 0x4
// Checksum 0xb5fbf262, Offset: 0x1252
// Size: 0x4e
function private watchfordeath( ent, data )
{
    data endon( #"hash_498271ae1f8f2b6c" );
    ent utility::waittill_any( "death", "entitydeleted" );
    waitframe();
    data notify( #"hash_498271ae1f8f2b6c", ent.origin );
}

// Namespace namespace_db65df962cb5e2f
// Params 2, eflags: 0x4
// Checksum 0xc3276783, Offset: 0x12a8
// Size: 0x4b
function private watchforexplode( grenade, data )
{
    data endon( #"hash_498271ae1f8f2b6c" );
    grenade waittill( #"explode", pos );
    data notify( #"hash_498271ae1f8f2b6c", pos );
}

// Namespace namespace_db65df962cb5e2f
// Params 2, eflags: 0x4
// Checksum 0x83f4bee2, Offset: 0x12fb
// Size: 0x48
function private function_68e79e8e0f7b1e3b( grenade, data )
{
    data endon( #"hash_498271ae1f8f2b6c" );
    grenade waittill( #"exploded" );
    data notify( #"hash_498271ae1f8f2b6c", grenade.origin );
}

// Namespace namespace_db65df962cb5e2f
// Params 1, eflags: 0x4
// Checksum 0xed387721, Offset: 0x134b
// Size: 0x36e
function private function_24e7add2fe5a229( params )
{
    if ( params.extractedparams )
    {
        return params;
    }
    
    entity = params.ent ?? params.grenade ?? params.einflictor ?? params.inflictor;
    owner = params.eattacker ?? params.attacker ?? params.owner ?? entity.owner ?? params.player;
    eventid = params.eventid ?? entity.eventid;
    data = function_d31021d22ae9d3a( { #eventid:eventid, #ent:entity, #owner:owner } );
    struct = { #hits:params.hits, #position:params.position ?? params.origin, #equipref:params.equipref ?? data.equipref, #armordamage:params.lightarmordamage ?? params.armordamage ?? 0, #healthdamage:params.idamage ?? params.damage ?? params.healthdamage ?? 0, #victim:params.victim, #ent:entity ?? data.ent, #owner:owner, #extractedparams:1 };
    
    if ( !isdefined( entity ) )
    {
        entity = data.ent;
    }
    
    struct.eventid = eventid ?? data.eventid;
    
    if ( entity )
    {
        if ( !isdefined( struct.owner ) )
        {
            struct.owner = data.owner ?? struct.ent.owner;
        }
        
        struct.itemref = params.itemref ?? data.ref ?? entity.basename ?? entity.weapon_name ?? entity.weapon_object.basename ?? entity.streakinfo.superref;
        
        if ( !isdefined( struct.equipref ) )
        {
            struct.equipref = data.equipref ?? getequipmentref( entity );
        }
        
        struct.equipbundle = level.equipment.table[ struct.equipref ].bundle ?? utility::callsharedfunc( #"equipment", #"getequipmentbundlefromweaponname", struct.itemref );
    }
    
    return struct;
}

// Namespace namespace_db65df962cb5e2f
// Params 1, eflags: 0x4
// Checksum 0x8188fd23, Offset: 0x16c2
// Size: 0xee
function private getequipmentref( var )
{
    if ( !isdefined( var ) )
    {
        return;
    }
    
    eref = var.equipref ?? var.equipmentref ?? var.einflictor.equipmentref ?? utility::callsharedfunc( #"equipment", #"getequipmentreffromweapon", var.grenade.weapon_object ?? var.grenade ?? var.einflictor ?? var );
    
    if ( ( !eref || eref == "" ) && var.basename )
    {
        eref = utility::callsharedfunc( #"equipment", #"getequipmentreffromweapon", makeweapon( var.basename ) );
    }
    
    return eref;
}

// Namespace namespace_db65df962cb5e2f
// Params 1, eflags: 0x4
// Checksum 0x859e4107, Offset: 0x17b9
// Size: 0xb7, Type: bool
function private isvalidgrenade( grenade )
{
    equipbundle = utility::callsharedfunc( #"equipment", #"getequipmentbundlefromweaponname", grenade.weapon_name ?? grenade.basename ?? grenade.weapon_object.basename );
    return equipbundle && equipbundle.equipmenttype == "lethal" || equipbundle.equipmenttype == "tactical" || equipbundle.equipmenttype == "super" || equipbundle.equipmenttype == "equipment_other";
}

// Namespace namespace_db65df962cb5e2f
// Params 1, eflags: 0x4
// Checksum 0x4151ece, Offset: 0x1879
// Size: 0xd9
function private function_d31021d22ae9d3a( params )
{
    player = params.owner;
    
    if ( player.var_282f154140c2a661 )
    {
        foreach ( data in player.var_282f154140c2a661 )
        {
            if ( data.eventid == params.eventid || data.ent == params.ent )
            {
                return data;
            }
        }
    }
}

// Namespace namespace_db65df962cb5e2f
// Params 1, eflags: 0x4
// Checksum 0x540db677, Offset: 0x195a
// Size: 0x8a
function private function_8b6c1753f5c7714e( params )
{
    extractedparams = function_24e7add2fe5a229( params );
    data = function_d31021d22ae9d3a( extractedparams );
    
    if ( isdefined( data ) )
    {
        data.ent = params.newent;
        data.ent.eventid = data.eventid;
    }
    
    if ( !function_9589a51c75254f75( extractedparams, "end" ) )
    {
        thread function_89bfaa23f64b7de2( extractedparams );
    }
}

// Namespace namespace_db65df962cb5e2f
// Params 1, eflags: 0x4
// Checksum 0x5f45567c, Offset: 0x19ec
// Size: 0x661
function private function_df9cddcfc3bbad55( data )
{
    if ( !self )
    {
        return;
    }
    
    damagedataarr = [];
    
    if ( function_97de808fe549b3b7() )
    {
        if ( data.playerdamagedata )
        {
            foreach ( id, vdata in data.playerdamagedata )
            {
                var_655682e2379cabff = [ 12:vdata.killed ?? 0, 11:vdata.var_e92d4b90338af943 ?? 0, 10:vdata.var_77b864909d82bb43 ?? 0, 9:vdata.hits ?? 0, 8:vdata.armordamage ?? 0, 7:vdata.healthdamage ?? 0, vdata.totaldamage ?? 0, 5:distance( data.deathorigin ?? ( 0, 0, 0 ), vdata.victimpos ?? ( 0, 0, 0 ) ), 4:float( vdata.victimpos[ 2 ] ?? 0 ), 3:float( vdata.victimpos[ 1 ] ?? 0 ), 2:float( vdata.victimpos[ 0 ] ?? 0 ), 1:vdata.victim ?? -1 ];
                damagedataarr[ damagedataarr.size ] = var_655682e2379cabff;
            }
        }
        
        self function_ad05aed95a44741e( -6426291541207035023, [ 14:data.type ?? "<missing>", 13:data.deathtimestamp ?? 0, 12:data.timestamp ?? 0, 11:float( data.deathorigin[ 2 ] ?? 0 ), 10:float( data.deathorigin[ 1 ] ?? 0 ), 9:float( data.deathorigin[ 0 ] ?? 0 ), 8:data.ref ?? "<missing>", float( data.playerorigin[ 2 ] ?? 0 ), 6:float( data.playerorigin[ 1 ] ?? 0 ), 5:float( data.playerorigin[ 0 ] ?? 0 ), 4:damagedataarr ?? [] ] );
    }
    else
    {
        if ( data.playerdamagedata )
        {
            foreach ( id, vdata in data.playerdamagedata )
            {
                var_655682e2379cabff = [ "victim_uno_id", vdata.victim ?? -1, "victim_x", float( vdata.victimpos[ 0 ] ?? 0 ), "victim_y", float( vdata.victimpos[ 1 ] ?? 0 ), "victim_z", float( vdata.victimpos[ 2 ] ?? 0 ), "distance", distance( data.deathorigin ?? ( 0, 0, 0 ), vdata.victimpos ?? ( 0, 0, 0 ) ), "damage", vdata.totaldamage ?? 0, "health_damage", vdata.healthdamage ?? 0, "armor_damage", vdata.armordamage ?? 0, "hits", vdata.hits ?? 0, "last_stand_damage", vdata.var_77b864909d82bb43 ?? 0, "put_into_last_stand", vdata.var_e92d4b90338af943 ?? 0, "killed", vdata.killed ?? 0 ];
                damagedataarr[ damagedataarr.size ] = var_655682e2379cabff;
            }
        }
        
        self dlog_recordplayerevent( "dlog_event_equipment_lifetime", [ "victim_data", damagedataarr ?? [], "player_x", float( data.playerorigin[ 0 ] ?? 0 ), "player_y", float( data.playerorigin[ 1 ] ?? 0 ), "player_z", float( data.playerorigin[ 2 ] ?? 0 ), "item_name", data.ref ?? "<missing>", "expire_x", float( data.deathorigin[ 0 ] ?? 0 ), "expire_y", float( data.deathorigin[ 1 ] ?? 0 ), "expire_z", float( data.deathorigin[ 2 ] ?? 0 ), "throw_timestamp", data.timestamp ?? 0, "expire_timestamp", data.deathtimestamp ?? 0, "type", data.type ?? "<missing>" ] );
    }
    
    if ( self.var_282f154140c2a661 )
    {
        self.var_282f154140c2a661 = arrayremove( self.var_282f154140c2a661, data );
    }
}

