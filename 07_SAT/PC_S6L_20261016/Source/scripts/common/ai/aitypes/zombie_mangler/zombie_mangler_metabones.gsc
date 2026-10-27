// scripts\common\ai\aitypes\zombie_mangler\zombie_mangler_metabones.gsc  (hash_4dd193c0eb974d77.gscc) (size: 2197 Bytes / 0x895 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x2246b0bf (575058111)
// size ...... 2197 (0x895)
// includes .. 8   (offset: 0x795)
// strings ... 15  (offset: 0x7d5)
// dev strs .. 0   (offset: 0x895)
// exports ... 3   (offset: 0x4a1)
// cseg ...... 0x15b + 0x346 (0x4a1)
// imports ... 22  (offset: 0x519)
// animtree1 . 0   (offset: 0x895)
// animtree2 . 0   (offset: 0x895)
#using script_16ea1b94f0f381b3;
#using scripts\asm\asm;
#using scripts\common\ai\aitypes\shared\zombie\zombie_stun;
#using scripts\common\ai\aitypes\zombie_mangler\zombie_mangler_berserk;
#using scripts\common\ai\aitypes\zombie_mangler\zombie_mangler_ranged_attack;
#using scripts\common\metabone;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_mangler_metabones;

// Namespace zombie_mangler_metabones
// Params 0, eflags: 0x1
// Checksum 0x503d664, Offset: 0x179
// Size: 0x21
function autoexec main()
{
    var_fb56e56d94279338 = "zombie_mangler";
    metabone::function_cd947f1a3391c065( var_fb56e56d94279338, &on_metabone_destroyed );
}

// Namespace zombie_mangler_metabones
// Params 1, eflags: 0x4
// Checksum 0x6029e86, Offset: 0x1a2
// Size: 0x2ff
function private on_metabone_destroyed( params )
{
    metabone_name = params.metabone_name;
    metabone::set_metabone_state( metabone_name, "destroyed" );
    metabone::set_metabone_active( metabone_name, 1 );
    scriptable_state_name = "destroyed";
    
    if ( metabone_name == "armored_torso" || metabone_name == "armored_head" )
    {
        namespace_ac69c03f7b7eefc2::function_dd6d54fa5b6feae8( 15, 1 );
    }
    else if ( metabone_name == "j_weapon_spin" )
    {
        namespace_aef48b18f1c4d84c::function_2685f4f10e1b1b49( 0 );
        self function_786bb6aa1b76c7ee( "torpedo_attack_interrupted", 1 );
        utility::function_32b24db3127bff40( "cannon_charge", "default" );
        utility::function_32b24db3127bff40( "cannon_recharge", "default" );
        self.gun_arm_destroyed = 1;
        var_81a4fbc692f40f48 = self.maxhealth * self.var_727f4a2566bea620;
        
        if ( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_4d9464af93daa25c && isdefined( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.manglercannonlootname ) )
        {
            dropchance = self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.var_27b449417905ea78 ?? 0;
            
            if ( randomint( 100 ) < dropchance || level.var_4879283758a678fb )
            {
                self.var_86440d94c4aed335 = 1;
                level.var_4879283758a678fb = undefined;
            }
            
            /#
                if ( getdvarint( @"hash_be96e016c71f234d", 0 ) )
                {
                    self.var_86440d94c4aed335 = 1;
                }
            #/
        }
        
        if ( self.var_86440d94c4aed335 && !self.var_a13bed1ac47e1b2c && !self.var_895476d327fa9e31 )
        {
            pos = self gettagorigin( "j_weapon_spin" );
            spawnoptions = namespace_9d8e359c3b1041e5::initspawnoptions_spawnfrompositionsharedfunc( pos );
            spawnoptions.spawningentity = self;
            namespace_9d8e359c3b1041e5::spawnitemfromscriptablesharedfunc( self.var_d6894f01a36b4ff3.var_d3de1a9faac42deb.manglercannonlootname, 3, spawnoptions );
            scriptable_state_name += "_loot";
        }
        
        self dodamage( var_81a4fbc692f40f48, self.origin, params.eattacker, params.einflictor, "MOD_EXPLOSIVE", undefined, "right_arm_upper", undefined, 65536 );
        
        if ( isalive( self ) )
        {
            namespace_ac69c03f7b7eefc2::function_dd6d54fa5b6feae8( 0, 1 );
        }
        else if ( isplayer( params.eattacker ) )
        {
            params.eattacker namespace_9d8e359c3b1041e5::doscoreeventsharedfunc( #"mangler_mangled" );
        }
    }
    
    if ( !self getaiblackboarddynamic( "in_torpedo_attack" ) && !zombie_stun::is_stunned() && !self isintraverse() )
    {
        if ( isalive( self ) && val::get( "special_pain" ) )
        {
            self notify( #"vox_pain" );
            asm::function_7256f5ba459c840b( "special_pain_in" );
        }
    }
    
    if ( isalive( self ) )
    {
        utility::function_32b24db3127bff40( metabone_name, scriptable_state_name );
    }
}

