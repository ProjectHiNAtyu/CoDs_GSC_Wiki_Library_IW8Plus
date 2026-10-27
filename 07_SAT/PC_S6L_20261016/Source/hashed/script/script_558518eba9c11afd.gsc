// script_558518eba9c11afd  (hash_558518eba9c11afd.gscc) (size: 3404 Bytes / 0xd4c / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x9382d0e5 (2474823909)
// size ...... 3404 (0xd4c)
// includes .. 6   (offset: 0xcec)
// strings ... 3   (offset: 0xd1c)
// dev strs .. 0   (offset: 0xd4c)
// exports ... 13  (offset: 0x768)
// cseg ...... 0xa8 + 0x6c0 (0x768)
// imports ... 31  (offset: 0x970)
// animtree1 . 0   (offset: 0xd4c)
// animtree2 . 0   (offset: 0xd4c)
#using scripts\common\callbacks;
#using scripts\common\math;
#using scripts\common\utility;
#using scripts\mp\common\utility\player;
#using scripts\mp\common\utility\player_utility;
#using scripts\mp\common\utility\team_utility;

#namespace specialty_ping_enemy_on_spawn;

// Namespace specialty_ping_enemy_on_spawn
// Params 0, eflags: 0x1
// Checksum 0x507a2d3f, Offset: 0xc6
// Size: 0x18
function autoexec main()
{
    level callback::add( #"register_perk", &registerperk );
}

// Namespace specialty_ping_enemy_on_spawn
// Params 1
// Checksum 0x62bcb2ab, Offset: 0xe6
// Size: 0x3f
function registerperk( params )
{
    if ( isdefined( params.var_a2358848c4408242 ) )
    {
        level [[ params.var_a2358848c4408242 ]]( "specialty_ping_enemy_on_spawn", &function_ae0970e964f19c5e, &function_7240c4d084011383, [], &function_f0052d4c28c8b211 );
    }
}

// Namespace specialty_ping_enemy_on_spawn
// Params 0
// Checksum 0x4c4e31b4, Offset: 0x12d
// Size: 0x17
function function_f0052d4c28c8b211()
{
    callback::add( #"player_spawned", &onplayerspawned );
}

// Namespace specialty_ping_enemy_on_spawn
// Params 0, eflags: 0x4
// Checksum 0xdd7914d9, Offset: 0x14c
// Size: 0xaa
function private function_ae0970e964f19c5e()
{
    bundle = self.var_9842326056fd7207 ?? level.perkbundles[ "specialty_ping_enemy_on_spawn" ];
    
    if ( !bundle )
    {
        return;
    }
    
    self.var_c4732c27a3dc4fc6 = { #var_fe58e6b9af6beddf:bundle.var_12d9a45a90683cf ?? 3, #var_e5d697c1330f0cc9:bundle.var_226aa1f3d6fb0059 ?? 5, #var_9bd13f5b0635a5a4:bundle.var_918c1e8e77a8804c ?? 5000, #var_bfa44977e94ae199:bundle.var_e0404199b8098881 ?? 15 };
}

// Namespace specialty_ping_enemy_on_spawn
// Params 0, eflags: 0x4
// Checksum 0x33a8e5a6, Offset: 0x1fe
// Size: 0xc
function private function_7240c4d084011383()
{
    self.var_c4732c27a3dc4fc6 = undefined;
}

// Namespace specialty_ping_enemy_on_spawn
// Params 1
// Checksum 0x6253b10a, Offset: 0x212
// Size: 0x2d
function onplayerspawned( params )
{
    if ( !isdefined( self.perks[ "specialty_ping_enemy_on_spawn" ] ) )
    {
        return;
    }
    
    thread function_38317f3ce21c18d8( 0.2 );
}

// Namespace specialty_ping_enemy_on_spawn
// Params 1, eflags: 0xc
// Checksum 0xc294918a, Offset: 0x247
// Size: 0x82
function private function_38317f3ce21c18d8( delay )
{
    self notify( #"hash_851e58341c7c8497" );
    self endon( #"hash_851e58341c7c8497" );
    self endon( #"death_or_disconnect" );
    level endon( #"game_ended" );
    var_bd17c7edd0822f5d = self;
    
    if ( delay > 0 )
    {
        wait delay;
    }
    
    if ( !isplayer( var_bd17c7edd0822f5d ) )
    {
        return;
    }
    
    var_51c7610d3b8a2032 = var_bd17c7edd0822f5d function_f2ba1de3bcce7175();
    
    if ( !isdefined( var_51c7610d3b8a2032 ) )
    {
        return;
    }
    
    pingtarget( self, var_51c7610d3b8a2032 );
}

// Namespace specialty_ping_enemy_on_spawn
// Params 4
// Checksum 0x5c166176, Offset: 0x2d1
// Size: 0xab, Type: bool
function function_ac09a058df12066d( weaponobj, attacker, inflictor, meansofdeath )
{
    victim = self;
    
    if ( !player_utility::playersareenemies( victim, attacker ) )
    {
        return false;
    }
    
    lastpingtimeseconds = attacker.var_c4732c27a3dc4fc6.lastpingtimeseconds ?? -1;
    
    if ( lastpingtimeseconds > 0 )
    {
        var_80af201340498a0f = gettime() / 1000 - lastpingtimeseconds;
        
        if ( var_80af201340498a0f < attacker.var_c4732c27a3dc4fc6.var_e5d697c1330f0cc9 )
        {
            return false;
        }
    }
    
    return true;
}

// Namespace specialty_ping_enemy_on_spawn
// Params 0, eflags: 0x4
// Checksum 0x18696fa9, Offset: 0x385
// Size: 0xda
function private function_f2ba1de3bcce7175()
{
    var_bd17c7edd0822f5d = self;
    
    if ( !var_bd17c7edd0822f5d.var_c4732c27a3dc4fc6 )
    {
        return;
    }
    
    if ( level.teambased )
    {
        var_be97f42abdee91d5 = team_utility::getotherteam( var_bd17c7edd0822f5d.team );
    }
    else
    {
        var_be97f42abdee91d5 = undefined;
    }
    
    inrangecandidates = player_utility::script_getplayersinradius( var_bd17c7edd0822f5d.origin, var_bd17c7edd0822f5d.var_c4732c27a3dc4fc6.var_9bd13f5b0635a5a4, var_be97f42abdee91d5 );
    validcandidates = var_bd17c7edd0822f5d utility::function_5fdf0884f9b2d470( inrangecandidates, &function_7a4b1a6e8244b540 );
    
    if ( ( validcandidates.size ?? 0 ) <= 0 )
    {
        return;
    }
    
    if ( validcandidates.size == 1 )
    {
        return validcandidates[ 0 ];
    }
    
    [ var_deafd51c13ce1bf1 ] = sortbydistance( validcandidates, var_bd17c7edd0822f5d.origin );
    return var_deafd51c13ce1bf1;
}

// Namespace specialty_ping_enemy_on_spawn
// Params 1, eflags: 0x4
// Checksum 0x8695e3bf, Offset: 0x468
// Size: 0x95, Type: bool
function private function_7a4b1a6e8244b540( var_51c7610d3b8a2032 )
{
    if ( !player::isreallyalive( var_51c7610d3b8a2032 ) )
    {
        return false;
    }
    
    if ( var_51c7610d3b8a2032 isplayerghost() )
    {
        return false;
    }
    
    if ( var_51c7610d3b8a2032 == self )
    {
        return false;
    }
    
    if ( var_51c7610d3b8a2032.team == self.team )
    {
        return false;
    }
    
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"jamming_system" ][ #"hash_f3a152be2dbc14b9" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        istargetjammed = var_51c7610d3b8a2032 [[ var_32dbca3143d9c4a5 ]]();
    }
    else
    {
        istargetjammed = 0;
    }
    
    if ( istargetjammed )
    {
        return false;
    }
    
    return true;
}

// Namespace specialty_ping_enemy_on_spawn
// Params 2, eflags: 0xc
// Checksum 0xff660273, Offset: 0x506
// Size: 0x142
function private function_91ccda3cee679184( attacker, var_51c7610d3b8a2032 )
{
    self notify( #"hash_9e9612528bd1d335" );
    self endon( #"hash_9e9612528bd1d335" );
    var_51c7610d3b8a2032 endon( #"death" );
    var_51c7610d3b8a2032 endon( #"disconnect" );
    endtime = gettime() + attacker.var_c4732c27a3dc4fc6.var_fe58e6b9af6beddf * 1000;
    
    while ( gettime() < endtime )
    {
        if ( !( isdefined( attacker.origin ) && isdefined( var_51c7610d3b8a2032.origin ) ) )
        {
            return;
        }
        
        var_2c6ef5693d530d6 = utility::flatten_vector( var_51c7610d3b8a2032.origin - attacker.origin );
        playerforward = utility::flatten_vector( anglestoforward( attacker.angles ) );
        angle = angleclamp( math::anglebetweenvectorssigned( playerforward, var_2c6ef5693d530d6, ( 0, 0, 1 ) ) );
        angle = angleclamp( angle + 22.5 );
        slicenum = int( floor( angle / 45 ) ) + 1;
        attacker setclientomnvar( "ui_hunter_instinct_minimap_section", slicenum );
        waitframe();
    }
}

// Namespace specialty_ping_enemy_on_spawn
// Params 2, eflags: 0x4
// Checksum 0x323d1356, Offset: 0x650
// Size: 0x118
function private pingtarget( attacker, var_51c7610d3b8a2032 )
{
    if ( !isdefined( attacker.var_c4732c27a3dc4fc6 ) )
    {
        return;
    }
    
    var_51c7610d3b8a2032 endon( #"disconnect" );
    attacker thread function_91ccda3cee679184( attacker, var_51c7610d3b8a2032 );
    attacker function_1fca3a43aa63c0bc( var_51c7610d3b8a2032 );
    attacker.var_c4732c27a3dc4fc6.lastpingtimeseconds = gettime() / 1000;
    attackerentnum = attacker.entnum ?? utility::get_entity_number( attacker );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"perceptive" ][ #"incrementcount" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        var_51c7610d3b8a2032 [[ var_32dbca3143d9c4a5 ]]( attackerentnum );
    }
    
    var_51c7610d3b8a2032 utility::waittill_any_timeout( attacker.var_c4732c27a3dc4fc6.var_fe58e6b9af6beddf, "death" );
    attacker setclientomnvar( "ui_hunter_instinct_minimap_section", 0 );
    var_32dbca3143d9c4a5 = level.sharedfuncs[ #"perceptive" ][ #"decrementcount" ];
    
    if ( isdefined( var_32dbca3143d9c4a5 ) )
    {
        var_51c7610d3b8a2032 [[ var_32dbca3143d9c4a5 ]]( attackerentnum );
    }
}

