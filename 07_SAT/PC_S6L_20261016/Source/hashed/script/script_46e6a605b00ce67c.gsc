// script_46e6a605b00ce67c  (hash_46e6a605b00ce67c.gscc) (size: 4609 Bytes / 0x1201 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xe08c5382 (3767292802)
// size ...... 4609 (0x1201)
// includes .. 1   (offset: 0x1129)
// strings ... 15  (offset: 0x1131)
// dev strs .. 0   (offset: 0x1201)
// exports ... 23  (offset: 0xa4d)
// cseg ...... 0x139 + 0x914 (0xa4d)
// imports ... 26  (offset: 0xde5)
// animtree1 . 0   (offset: 0x1201)
// animtree2 . 0   (offset: 0x1201)
#using scripts\common\utility;

#namespace namespace_c57c4bda2cd4484a;

// Namespace namespace_c57c4bda2cd4484a
// Params 0
// Checksum 0xf94f4f1c, Offset: 0x157
// Size: 0xc8
function function_be7f75e77fc81607()
{
    self.var_605a1fa29138f284 = [];
    self.var_d9215b502d26ae72 = [];
    self.var_699831e6357c3c22 = 0;
    self.var_873357a0f2b16f48 = 0;
    self.var_ebfc6d979ffe5272 = 0;
    self.var_ed2cd0cad2e0d352 = 0;
    settings = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb;
    self.var_4f9eac1f3bf6e01 = settings.var_e9685e7ae12fd972 ?? 12;
    self.var_7ece0922576fbb69 = settings.var_1c3199f4219d7e01 ?? 12;
    self.var_45e614a524fabcc3 = settings.var_658a0a1d24f4a388 ?? 12;
    self.var_3d39dd0cdeb41dcf = settings.var_6eafa584b790c7c6 ?? 50;
    thread function_4260b3081d72d615();
}

// Namespace namespace_c57c4bda2cd4484a
// Params 2
// Checksum 0x3541cad5, Offset: 0x227
// Size: 0xc2
function function_1604db740fdad59( player, is_detectable )
{
    player_key = player getentitynumber();
    attack_time_record = self.var_605a1fa29138f284[ player_key ];
    
    if ( !attack_time_record || attack_time_record[ 0 ] != player )
    {
        attack_time_record = [ player, 0, is_detectable ];
    }
    else
    {
        attack_time_record[ 2 ] = is_detectable;
    }
    
    self.var_605a1fa29138f284[ player_key ] = attack_time_record;
    
    if ( is_detectable && ( !attack_time_record[ 1 ] || utility::time_has_passed( attack_time_record[ 1 ], getdvarfloat( @"hash_1ee51a608740370b", self.var_4f9eac1f3bf6e01 ) ) ) )
    {
        self.var_d9215b502d26ae72[ self.var_d9215b502d26ae72.size ] = player;
    }
}

// Namespace namespace_c57c4bda2cd4484a
// Params 0
// Checksum 0x8a758d87, Offset: 0x2f1
// Size: 0x30
function function_cfa262d4ab9638ed()
{
    if ( self.var_54536d6f9c8a4837 && !function_6a9f4f7d83b62132( self.var_54536d6f9c8a4837 ) )
    {
        function_f24771760c767129();
    }
    
    function_7336151a606fada9();
}

// Namespace namespace_c57c4bda2cd4484a
// Params 1
// Checksum 0x2f573225, Offset: 0x329
// Size: 0x7b, Type: bool
function function_5d712bb2b5876699( player )
{
    attack_time_record = function_6a9f4f7d83b62132( player );
    
    if ( !isalive( player ) || !attack_time_record )
    {
        return false;
    }
    
    attack_time_record[ 1 ] = gettime();
    player_key = player getentitynumber();
    self.var_605a1fa29138f284[ player_key ] = attack_time_record;
    function_1d6bc834d42f0206( player );
    
    if ( self.var_54536d6f9c8a4837 == player )
    {
        function_f24771760c767129();
    }
    
    return true;
}

// Namespace namespace_c57c4bda2cd4484a
// Params 2
// Checksum 0x986180f9, Offset: 0x3ad
// Size: 0x6a, Type: bool
function function_169e0fd0d1155118( attack_type, target )
{
    if ( !function_4a278f68fa44b37( attack_type ) || self.var_54536d6f9c8a4837 != target )
    {
        return function_5d712bb2b5876699( target );
    }
    
    if ( attack_type == "bomb" )
    {
        self.var_ebfc6d979ffe5272 = gettime();
    }
    else
    {
        self.var_ed2cd0cad2e0d352 = gettime();
    }
    
    return function_5d712bb2b5876699( target );
}

// Namespace namespace_c57c4bda2cd4484a
// Params 0
// Checksum 0x667f4380, Offset: 0x420
// Size: 0x2a
function function_f24771760c767129()
{
    self.var_54536d6f9c8a4837 = undefined;
    self.var_42e524e7266a8e4 = undefined;
    self.var_699831e6357c3c22 = 0;
    self.var_873357a0f2b16f48 = 0;
}

// Namespace namespace_c57c4bda2cd4484a
// Params 0
// Checksum 0x772a06a2, Offset: 0x452
// Size: 0x1d
function function_a6147cfb6703733()
{
    self.var_605a1fa29138f284 = [];
    self.var_d9215b502d26ae72 = [];
    function_f24771760c767129();
}

// Namespace namespace_c57c4bda2cd4484a
// Params 1
// Checksum 0xc84cab1, Offset: 0x477
// Size: 0x25, Type: bool
function function_4a278f68fa44b37( attack_type )
{
    return self.var_54536d6f9c8a4837 && self.var_42e524e7266a8e4 == attack_type;
}

// Namespace namespace_c57c4bda2cd4484a
// Params 0
// Checksum 0xb145ccb1, Offset: 0x4a5
// Size: 0xb
function function_3ff492a8c06c648e()
{
    return self.var_54536d6f9c8a4837;
}

// Namespace namespace_c57c4bda2cd4484a
// Params 0
// Checksum 0xf2cceb93, Offset: 0x4b9
// Size: 0x22, Type: bool
function function_3719f5ec7b5bd679()
{
    return isalive( self.var_54536d6f9c8a4837 ) && function_6a9f4f7d83b62132( self.var_54536d6f9c8a4837 );
}

// Namespace namespace_c57c4bda2cd4484a
// Params 0, eflags: 0x4
// Checksum 0xf13c8468, Offset: 0x4e4
// Size: 0x7d, Type: bool
function private function_a2a89dfdd7337252()
{
    return utility::ent_flag( "in_charge" ) || utility::ent_flag( "in_dash" ) || utility::ent_flag( "in_melee" ) || self.bomb_attack_active || self.wipe_attack_active || self getaiblackboarddynamic( "in_summon_stingers" ) || self getaiblackboarddynamic( "in_full_pain" ) || self getaiblackboarddynamic( "in_immune" ) || self getaiblackboarddynamic( "in_move_turn" );
}

// Namespace namespace_c57c4bda2cd4484a
// Params 1, eflags: 0x4
// Checksum 0xfa1e576f, Offset: 0x56a
// Size: 0x57
function private function_6a9f4f7d83b62132( player )
{
    if ( !player )
    {
        return;
    }
    
    player_key = player getentitynumber();
    attack_time_record = self.var_605a1fa29138f284[ player_key ];
    
    if ( !attack_time_record || attack_time_record[ 0 ] != player || !attack_time_record[ 2 ] )
    {
        return;
    }
    
    return attack_time_record;
}

// Namespace namespace_c57c4bda2cd4484a
// Params 0, eflags: 0x4
// Checksum 0x90087b11, Offset: 0x5ca
// Size: 0x67
function private function_4260b3081d72d615()
{
    self endon( #"death" );
    level endon( #"game_ended" );
    
    while ( true )
    {
        utility::waittill_any_in_array( [ "move_turn_end", "move_turn_orient_end", "dash_cancelled", "bBombEnded", "bchargeended", "bmeleeended" ] );
        function_bad90d05b36fd236();
    }
}

// Namespace namespace_c57c4bda2cd4484a
// Params 0
// Checksum 0x9afd8e45, Offset: 0x639
// Size: 0x16
function function_e70c18ec4d85221f()
{
    if ( function_3719f5ec7b5bd679() )
    {
        self.var_873357a0f2b16f48 = 1;
    }
}

// Namespace namespace_c57c4bda2cd4484a
// Params 0
// Checksum 0x52ef7c07, Offset: 0x657
// Size: 0xc
function function_bad90d05b36fd236()
{
    self.var_873357a0f2b16f48 = 0;
}

// Namespace namespace_c57c4bda2cd4484a
// Params 0
// Checksum 0xce2711ff, Offset: 0x66b
// Size: 0x24
function function_4ba53d85ae1fd91c()
{
    if ( !self.var_873357a0f2b16f48 || !function_3719f5ec7b5bd679() )
    {
        return;
    }
    
    return self.var_54536d6f9c8a4837;
}

// Namespace namespace_c57c4bda2cd4484a
// Params 0
// Checksum 0x96aab4b6, Offset: 0x698
// Size: 0x35, Type: bool
function function_8c043ec24462c79()
{
    return !self.var_ebfc6d979ffe5272 || utility::time_has_passed( self.var_ebfc6d979ffe5272, getdvarfloat( @"hash_cc64c4e5467cc437", self.var_7ece0922576fbb69 ) );
}

// Namespace namespace_c57c4bda2cd4484a
// Params 0
// Checksum 0xfca70e8f, Offset: 0x6d6
// Size: 0x35, Type: bool
function function_b997dd252e9900bd()
{
    return !self.var_ed2cd0cad2e0d352 || utility::time_has_passed( self.var_ed2cd0cad2e0d352, getdvarfloat( @"hash_fa476326aff6ca49", self.var_45e614a524fabcc3 ) );
}

// Namespace namespace_c57c4bda2cd4484a
// Params 0
// Checksum 0x89f8f2d5, Offset: 0x714
// Size: 0x8a, Type: bool
function function_e150aff9299e8439()
{
    if ( self.var_699831e6357c3c22 || !function_3719f5ec7b5bd679() )
    {
        return false;
    }
    
    alternate_attack = self.var_42e524e7266a8e4 == "charge" ? "bomb" : "charge";
    alternate_ready = alternate_attack == "bomb" ? function_8c043ec24462c79() : function_b997dd252e9900bd();
    
    if ( !alternate_ready )
    {
        return false;
    }
    
    self.var_42e524e7266a8e4 = alternate_attack;
    self.var_699831e6357c3c22 = 1;
    return true;
}

// Namespace namespace_c57c4bda2cd4484a
// Params 0, eflags: 0x4
// Checksum 0xc2cfb606, Offset: 0x7a7
// Size: 0x11d
function private function_7336151a606fada9()
{
    if ( self.var_54536d6f9c8a4837 || self.var_d9215b502d26ae72.size == 0 || !isalive( self ) || function_a2a89dfdd7337252() )
    {
        return;
    }
    
    bomb_ready = function_8c043ec24462c79();
    charge_ready = function_b997dd252e9900bd();
    
    if ( !bomb_ready && !charge_ready )
    {
        return;
    }
    
    if ( level.players.size >= 3 )
    {
        self.var_54536d6f9c8a4837 = function_916e534c1686646();
    }
    else
    {
        self.var_54536d6f9c8a4837 = utility::array_random( self.var_d9215b502d26ae72 );
    }
    
    if ( bomb_ready && charge_ready )
    {
        charge_chance = int( clamp( getdvarfloat( @"hash_c1f6ca69932eca51", self.var_3d39dd0cdeb41dcf ), 0, 100 ) );
        self.var_42e524e7266a8e4 = randomint( 100 ) < charge_chance ? "charge" : "bomb";
    }
    else
    {
        self.var_42e524e7266a8e4 = charge_ready ? "charge" : "bomb";
    }
    
    self.var_699831e6357c3c22 = 0;
}

// Namespace namespace_c57c4bda2cd4484a
// Params 0, eflags: 0x4
// Checksum 0x2a61665c, Offset: 0x8cc
// Size: 0xd8
function private function_916e534c1686646()
{
    oldest_candidate = undefined;
    var_80e77949b0aface3 = 0;
    var_cf5599817104885c = 0;
    
    foreach ( candidate in self.var_d9215b502d26ae72 )
    {
        attack_time_record = function_6a9f4f7d83b62132( candidate );
        
        if ( !attack_time_record )
        {
            continue;
        }
        
        engage_time = attack_time_record[ 1 ];
        
        if ( !var_cf5599817104885c || engage_time < var_80e77949b0aface3 )
        {
            oldest_candidate = candidate;
            var_80e77949b0aface3 = engage_time;
            var_cf5599817104885c = 1;
        }
    }
    
    return oldest_candidate;
}

// Namespace namespace_c57c4bda2cd4484a
// Params 1, eflags: 0x4
// Checksum 0xdf110e47, Offset: 0x9ad
// Size: 0xa0
function private function_1d6bc834d42f0206( player )
{
    remaining_candidates = [];
    
    foreach ( candidate in self.var_d9215b502d26ae72 )
    {
        if ( candidate != player )
        {
            remaining_candidates[ remaining_candidates.size ] = candidate;
        }
    }
    
    self.var_d9215b502d26ae72 = remaining_candidates;
}

