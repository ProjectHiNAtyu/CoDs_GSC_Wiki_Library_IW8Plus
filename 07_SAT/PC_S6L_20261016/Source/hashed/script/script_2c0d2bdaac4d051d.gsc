// script_2c0d2bdaac4d051d  (hash_2c0d2bdaac4d051d.gscc) (size: 3435 Bytes / 0xd6b / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x21d8e229 (567861801)
// size ...... 3435 (0xd6b)
// includes .. 5   (offset: 0xc4f)
// strings ... 18  (offset: 0xc77)
// dev strs .. 0   (offset: 0xd6b)
// exports ... 4   (offset: 0x8df)
// cseg ...... 0x209 + 0x6d6 (0x8df)
// imports ... 24  (offset: 0x97f)
// animtree1 . 0   (offset: 0xd6b)
// animtree2 . 0   (offset: 0xd6b)
#using scripts\common\utility;
#using scripts\mp\destructibles\destructibles;
#using scripts\mp\destructibles\destructibles_actions;
#using scripts\mp\zm\maps\zm_sat_mantis\zm_sat_mantis_boss_fight;
#using scripts\mp\zm\systems\zm_quest;

#namespace namespace_a2abfdbbd7a98995;

// Namespace namespace_a2abfdbbd7a98995
// Params 1
// Checksum 0x540c1fcf, Offset: 0x227
// Size: 0x590
function init_musical_item( mi_index )
{
    self.black_dome = spawnscriptable( %"sat_zm_sat_scriptable_mantis_boss_dome", self.origin, self.angles );
    self.black_dome.original_position = self.origin;
    self.black_dome.clip = getent( "boss_black_dome_clip_" + self.script_noteworthy, #targetname );
    self.black_dome.clip.original_position = self.black_dome.clip.origin;
    self.black_chulk = spawnscriptable( %"sat_zm_sat_scriptable_mantis_boss_chulk", self.origin, self.angles );
    var_751e6dc3652cf617 = self.angles;
    
    if ( self.script_noteworthy == "piano" )
    {
        var_751e6dc3652cf617 = self.angles + ( 0, 90, 0 );
    }
    
    self.mdl = utility::spawn_model( "tag_origin", self.origin, var_751e6dc3652cf617 );
    self.mdl.sbl = spawnscriptable( %"sat_zm_sat_scriptable_mantis_boss_key_item", ( 0, 0, 0 ), var_751e6dc3652cf617, self.mdl );
    
    if ( self.mdl.sbl )
    {
        self.mdl.sbl setscriptablepartstate( "model", self.script_noteworthy );
    }
    
    level utility::flag_set( "musical_item_ready" );
    
    switch ( self.script_noteworthy )
    {
        case #"hash_38434bb3eae5dbbe":
            sub_item_tag = "tag_music_sheet";
            sub_item_model = "sat_sfh_furniture_upright_piano_wood_01_fxanim";
            break;
        case #"hash_dfd682f46b386c18":
            sub_item_tag = "tag_monkey_cymbals";
            sub_item_model = "sat_zm_toy_chest_fxanim";
            break;
        case #"hash_af2c03b69065d1e8":
            sub_item_tag = "tag_music_box";
            sub_item_model = "sat_zm_fireplace_stone_dmg_01_fxanim";
            break;
    }
    
    temp_mdl = utility::spawn_model( sub_item_model, self.origin, var_751e6dc3652cf617 + var_751e6dc3652cf617 );
    waitframe();
    sub_item_origin = temp_mdl gettagorigin( sub_item_tag );
    sub_item_angles = temp_mdl gettagangles( sub_item_tag );
    temp_mdl delete();
    s_sub_item = spawnstruct();
    s_sub_item.origin = sub_item_origin;
    s_sub_item.angles = sub_item_angles;
    s_sub_item.mdl = utility::spawn_model( "tag_origin", sub_item_origin, sub_item_angles );
    s_sub_item.mdl.sbl = spawnscriptable( %"sat_zm_sat_scriptable_mantis_boss_key_item_attachment", ( 0, 0, 0 ), ( 0, 0, 0 ), s_sub_item.mdl );
    s_sub_item.mdl.sbl setscriptablepartstate( "model", self.script_noteworthy );
    self.var_a5f3683b57323812 = s_sub_item;
    level utility::flag_wait( "boss_fight_phase_1_start" );
    var_bc0a9622e27b8552 = [];
    
    foreach ( index, pos in self.var_5374fb111c0954f1 )
    {
        pos.parent = self;
        pos.sbl = spawnscriptable( "sat_destructible_souleater_cyst_boss_fight", pos.origin, pos.angles );
        destructible::function_919f39b38db04950( pos.sbl );
        pos.sbl.parent = pos;
        pos.sbl.event_name = self.script_noteworthy + string( index );
        pos.sbl.harvest_radius = level.s_dark_heart.phase_data[ "phase_1" ].var_82e753b3361faa56;
        pos.sbl.required_souls = level.s_dark_heart.phase_data[ "phase_1" ].var_6b2da2f8e23f91cc;
        pos.sbl.var_f1254bfe6aa67aa4 = 1;
        pos.sbl.mi_index = mi_index;
        pos.sbl destructible::remove_action( "destructible_destruction", destructible_actions::function_ac2ba61b9f601475( #"hash_369d1e10810f20b7" ) );
        pos.sbl destructible::function_12e4a9779677a8b8( "destructible_destruction", { #execute:&function_f20d47192d6eabe6 } );
        thread spawn_beam( pos );
        var_bc0a9622e27b8552[ var_bc0a9622e27b8552.size ] = self.script_noteworthy + string( index );
    }
    
    self.wait_flags = var_bc0a9622e27b8552;
    level utility::flag_wait_all_array( var_bc0a9622e27b8552 );
    self.b_released = 1;
    zm_sat_mantis_boss_fight::release_holdout( self );
    zm_sat_mantis_boss_fight::function_3176083662ac618d( 0 );
}

// Namespace namespace_a2abfdbbd7a98995
// Params 1, eflags: 0x4
// Checksum 0x382679ee, Offset: 0x7bf
// Size: 0x96
function private function_f20d47192d6eabe6( params )
{
    self setscriptablepartstate( "body", "destruction" );
    self.parent.lock_beam_vfx delete();
    self.parent.beam_tag delete();
    zm_quest::function_5b5c737326035ea( self.parent.sbl.mi_index );
    level utility::flag_set( self.event_name );
    level notify( #"hash_810948727828101d", self.event_name );
}

// Namespace namespace_a2abfdbbd7a98995
// Params 1, eflags: 0x4
// Checksum 0x2ca2e769, Offset: 0x85d
// Size: 0x82
function private spawn_beam( pos )
{
    pos.beam_tag = utility::spawn_model( "tag_origin", pos.origin, pos.angles );
    pos.lock_beam_vfx = playfxontagsbetweenclients( level._effect[ "cyst_tether_beam" ], pos.beam_tag, "tag_origin", pos.parent.mdl, "tag_origin" );
}

