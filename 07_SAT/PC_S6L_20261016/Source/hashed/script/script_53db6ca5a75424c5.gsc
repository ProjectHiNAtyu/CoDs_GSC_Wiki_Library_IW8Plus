// script_53db6ca5a75424c5  (hash_53db6ca5a75424c5.gscc) (size: 1648 Bytes / 0x670 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0xa7649638 (2808387128)
// size ...... 1648 (0x670)
// includes .. 3   (offset: 0x5d8)
// strings ... 9   (offset: 0x5f0)
// dev strs .. 0   (offset: 0x670)
// exports ... 5   (offset: 0x3dc)
// cseg ...... 0x12b + 0x2b1 (0x3dc)
// imports ... 11  (offset: 0x4a4)
// animtree1 . 0   (offset: 0x670)
// animtree2 . 0   (offset: 0x670)
#using scripts\common\ai\aitypes\shared\zombie\zombie_init;
#using scripts\common\callbacks;
#using scripts\common\utility;

#namespace zombie_diana_asm;

// Namespace zombie_diana_asm
// Params 0, eflags: 0x4
// Checksum 0xa01ed46f, Offset: 0x149
// Size: 0x9e
function private function_9f4f9cc3821ece50()
{
    callback::get_template( self.animsetname ) callback::add( "on_vantage_point_changed", &on_vantage_point_changed );
    level.scr_anim[ self.animname ][ "intro_finish" ] = "intro_finish";
    level.scr_anim[ self.animname ][ "assault_rounds_intro" ] = "assault_rounds_intro";
    level.scr_anim[ self.animname ][ "assault_rounds_outro" ] = "assault_rounds_outro";
    level.scr_anim[ self.animname ][ "ch_sat_zm_hornet_pap_smash_grab_diana" ] = "ch_sat_zm_hornet_pap_smash_grab_diana";
}

// Namespace zombie_diana_asm
// Params 3
// Checksum 0x3ad1328c, Offset: 0x1ef
// Size: 0x59
function function_29efc5afcb6c6999( asmname, statename, params )
{
    if ( self.var_cc3703385f725b39 )
    {
        return;
    }
    
    self.var_cc3703385f725b39 = 1;
    zombie_init::zombie_init_ai_asm( &function_9f4f9cc3821ece50 );
    self animmode( "noclip" );
    utility::ent_flag_set( "zombie_asm_init_finished" );
}

// Namespace zombie_diana_asm
// Params 0
// Checksum 0x6997de1c, Offset: 0x250
// Size: 0x53
function function_729178a2d5099f2e()
{
    featurearray = [];
    featurearray[ "vantage_point_move_direction" ] = self.var_7bd8c0a747b9f670;
    alias = self function_805ca5e408d630c0( self.animsetname, "move", featurearray, 0 );
    
    if ( isdefined( alias ) )
    {
        self function_695b8e1b655c2796( "move", alias );
    }
}

// Namespace zombie_diana_asm
// Params 1, eflags: 0x4
// Checksum 0xf40df35d, Offset: 0x2ab
// Size: 0x131
function private on_vantage_point_changed( params )
{
    function_729178a2d5099f2e();
    traversalattributes = {};
    traversalattributes.startpos = self.vantagepoints[ params.var_315c3f93aa18970f ].origin;
    traversalattributes.endpos = self.vantagepoints[ params.var_dc86ce9c653750f0 ].origin;
    traversalattributes.angles = self.vantagepoints[ params.var_dc86ce9c653750f0 ].angles;
    self.var_880d535ffe6db36f = { #angles:traversalattributes.angles, #origin:traversalattributes.endpos };
    
    if ( traversalattributes.startpos && traversalattributes.endpos && traversalattributes.angles )
    {
        self settraversalattributes( traversalattributes.startpos, traversalattributes.endpos, traversalattributes.angles, traversalattributes.endpos );
    }
}

