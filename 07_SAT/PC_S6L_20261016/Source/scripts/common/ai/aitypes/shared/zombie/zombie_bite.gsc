// scripts\common\ai\aitypes\shared\zombie\zombie_bite.gsc  (hash_3d40ac27f779e9e9.gscc) (size: 2077 Bytes / 0x81d / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x223cf952 (574421330)
// size ...... 2077 (0x81d)
// includes .. 3   (offset: 0x7c9)
// strings ... 5   (offset: 0x7e1)
// dev strs .. 0   (offset: 0x81d)
// exports ... 10  (offset: 0x45d)
// cseg ...... 0xb3 + 0x3aa (0x45d)
// imports ... 17  (offset: 0x5ed)
// animtree1 . 0   (offset: 0x81d)
// animtree2 . 0   (offset: 0x81d)
#using script_5490321f01c7322e;
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;

#namespace zombie_bite;

// Namespace zombie_bite
// Params 0
// Checksum 0x429f1606, Offset: 0xd1
// Size: 0x22
function init_zombie_bite_global()
{
    callback::get_template( self.animsetname ) callback::add( "on_move_speed_changed", &function_1801079a8006a658 );
}

// Namespace zombie_bite
// Params 0
// Checksum 0xa20a276f, Offset: 0xfb
// Size: 0x17
function init_zombie_bite()
{
    thread function_7dd4da0f8d263515();
    self.var_93255cd6b1efde94 = &function_93255cd6b1efde94;
}

// Namespace zombie_bite
// Params 2
// Checksum 0x83dea031, Offset: 0x11a
// Size: 0xa8
function register_bite_settings( damage_amount, range )
{
    self.var_6c41e8e873b7594e = damage_amount ?? 30;
    self.melee_range = range;
    self._blackboard.var_5692974bb0dd3579 = int( self.melee_range );
    self._blackboard.var_cedd501bdb70cc3f = 64;
    self._blackboard.var_f98a47aa5cd0dadf = 64;
    self._blackboard.var_1bd0bf55c51aed3d = 65;
    zombie_utils::function_7ae8d980fd719e78( "melee_range", self.melee_range );
}

// Namespace zombie_bite
// Params 2
// Checksum 0xd3ca3a4c, Offset: 0x1ca
// Size: 0x39
function function_315c60e1577b91fb( movetype, var_b789ce8f4921d298 )
{
    if ( !isdefined( self.var_dffa63487147355d ) )
    {
        self.var_dffa63487147355d = [];
    }
    
    self.var_dffa63487147355d[ movetype ] = var_b789ce8f4921d298;
}

// Namespace zombie_bite
// Params 1
// Checksum 0x500cf7db, Offset: 0x20b
// Size: 0x75
function function_1801079a8006a658( params )
{
    if ( isdefined( self._blackboard.movetype ) && isdefined( self.var_dffa63487147355d[ self._blackboard.movetype ] ) )
    {
        self._blackboard.var_cedd501bdb70cc3f = self.var_dffa63487147355d[ self._blackboard.movetype ];
    }
}

// Namespace zombie_bite
// Params 1
// Checksum 0x4605f5d, Offset: 0x288
// Size: 0x2a
function function_8381b313b5dc8112( target_ent )
{
    self.var_b8aa448716dd6230 = target_ent;
    callback::callback( "on_is_bite_started" );
    zombie_bite_asm::request_bite_asm_state();
}

// Namespace zombie_bite
// Params 0, eflags: 0x4
// Checksum 0xc08f209b, Offset: 0x2ba
// Size: 0xf8
function private function_93255cd6b1efde94()
{
    assert( isdefined( self.melee_range ) && isdefined( self.var_6c41e8e873b7594e ) );
    var_90ec0886f9ccf215 = self melee( undefined, self.var_6c41e8e873b7594e, self.melee_range, 16, 16 );
    params = spawnstruct();
    params.damage = self.var_6c41e8e873b7594e;
    params.origin = self.origin + anglestoforward( self.angles ) * self.melee_range + ( 0, 0, 1 ) * self.height * 0.5;
    params.meansofdeath = "MOD_MELEE";
    
    /#
        recordsphere( params.origin, 5, ( 1, 0, 0 ) );
    #/
    
    callback::callback( "damage_point", params );
}

// Namespace zombie_bite
// Params 0, eflags: 0x4
// Checksum 0xdb082848, Offset: 0x3ba
// Size: 0x5b
function private function_7dd4da0f8d263515()
{
    self endon( #"death" );
    
    while ( true )
    {
        self waittill( #"hash_9f6d1fd5ff565730" );
        function_8381b313b5dc8112( self.enemy );
        thread function_9aa00dbf27fb48c7();
        self waittill( #"bmeleeended" );
        self.bite_state_requested = 0;
        self.in_melee = 0;
    }
}

// Namespace zombie_bite
// Params 0, eflags: 0x4
// Checksum 0xc0715753, Offset: 0x41d
// Size: 0x40
function private function_9aa00dbf27fb48c7()
{
    self endon( #"death" );
    self endon( #"bmeleeended" );
    self waittill( #"hit_melee" );
    
    if ( isdefined( self.var_93255cd6b1efde94 ) )
    {
        [[ self.var_93255cd6b1efde94 ]]();
    }
}

