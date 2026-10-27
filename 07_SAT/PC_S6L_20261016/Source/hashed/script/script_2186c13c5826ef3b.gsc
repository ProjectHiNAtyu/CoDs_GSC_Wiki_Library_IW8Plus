// script_2186c13c5826ef3b  (hash_2186c13c5826ef3b.gscc) (size: 5737 Bytes / 0x1669 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x55bf155a (1438586202)
// size ...... 5737 (0x1669)
// includes .. 7   (offset: 0x1465)
// strings ... 26  (offset: 0x149d)
// dev strs .. 1   (offset: 0x165d)
// exports ... 12  (offset: 0xe35)
// cseg ...... 0x229 + 0xc0c (0xe35)
// imports ... 36  (offset: 0x1015)
// animtree1 . 0   (offset: 0x1669)
// animtree2 . 0   (offset: 0x1669)
#using scripts\asm\asm;
#using scripts\asm\shared\utility;
#using scripts\common\ai\aitypes\zombie_shade\zombie_shade_loot_consume;
#using scripts\common\callbacks;
#using scripts\common\trace;
#using scripts\common\utility;
#using scripts\common\values;

#namespace zombie_shade_loot_consume_asm;

// Namespace zombie_shade_loot_consume_asm
// Params 1, eflags: 0x4
// Checksum 0xf1164213, Offset: 0x247
// Size: 0x33, Type: bool
function private function_2d492483959b4965( loot_target )
{
    if ( !isdefined( loot_target ) )
    {
        zombie_shade_loot_consume::function_4dfb06dcc4d8d032();
        self._blackboard.var_ee63c958d4e84c96 = 0;
        return false;
    }
    
    return true;
}

// Namespace zombie_shade_loot_consume_asm
// Params 3
// Checksum 0x43fe1520, Offset: 0x283
// Size: 0xd0
function function_a5003adbfd3d3a0b( asmname, statename, params )
{
    if ( isdefined( self.loot_consume.animation_alias ) )
    {
        return choose_anim( statename, self.loot_consume.animation_alias );
    }
    else
    {
        archetype = self.animsetname;
        aliases = archetypegetaliases( archetype, statename );
        
        if ( isdefined( aliases ) )
        {
            self.loot_consume.animation_alias = aliases[ randomint( aliases.size ) ];
        }
    }
    
    if ( isdefined( self.loot_consume.animation_alias ) )
    {
        return choose_anim( statename, self.loot_consume.animation_alias );
    }
}

// Namespace zombie_shade_loot_consume_asm
// Params 2, eflags: 0x4
// Checksum 0x616c99ba, Offset: 0x35c
// Size: 0x53
function private choose_anim( statename, alias )
{
    arcname = utility::function_18bf04f16702b9b2();
    assert( isdefined( arcname ), "<dev string:x24>" );
    animresult = archetypegetrandomalias( arcname, statename, alias );
    
    if ( !isdefined( animresult ) )
    {
        return;
    }
    
    return animresult;
}

// Namespace zombie_shade_loot_consume_asm
// Params 3
// Checksum 0xeb103508, Offset: 0x3b8
// Size: 0x83
function finish_loot_consume( asmname, statename, params )
{
    self._blackboard.var_38c9594200d0e862 = undefined;
    self.loot_consume.animation_alias = undefined;
    self function_786bb6aa1b76c7ee( "is_consuming_loot", 0 );
    
    if ( isdefined( self.var_943ad14007148d84 ) )
    {
        self.var_943ad14007148d84--;
        
        if ( self.var_943ad14007148d84 == 0 )
        {
            utility::ent_flag_clear( "going_to_or_loot_consuming_currently", 1 );
        }
    }
}

// Namespace zombie_shade_loot_consume_asm
// Params 3
// Checksum 0xf7978284, Offset: 0x443
// Size: 0x1b5
function attach_loot_item( asmname, statename, params )
{
    if ( !prep_loot_consume( asmname, statename, params ) )
    {
        return;
    }
    
    self endon( #"death" );
    self endon( #"loot_target_cleared" );
    self endon( #"detach_loot_item" );
    wait 0.7;
    self notify( #"attach_loot_item" );
    loot_target = self.loot_consume.target_data.loot;
    
    if ( isdefined( loot_target ) )
    {
        utility::function_7c10ea82c1e305b8( "loot_consume", "consume" );
        loot_target utility::scriptable_clearparententity();
        loot_anchor = self.loot_consume.anchor;
        
        if ( isdefined( loot_anchor ) )
        {
            var_ab093498d28f3140 = trace::create_item_contents();
            loot_anchor.var_dcb854065ffb333f = loot_target.origin - utility::drop_to_ground( loot_target.origin, 0, -10, undefined, var_ab093498d28f3140 );
            loot_anchor.drop_angles = ( loot_target.angles[ 0 ], self.angles[ 1 ], loot_target.angles[ 2 ] );
            loot_anchor.origin = self gettagorigin( "tag_fx_loot" );
            loot_anchor.angles = self gettagangles( "tag_fx_loot" );
            
            if ( !isdefined( loot_target.linkedparent ) && isdefined( loot_target ) && loot_target isscriptableinstance() )
            {
                loot_target utility::scriptable_setparententity( loot_anchor );
            }
            
            loot_anchor linktoblendtotag( self, "tag_fx_loot", 0 );
            loot_anchor.loot = loot_target;
        }
    }
}

// Namespace zombie_shade_loot_consume_asm
// Params 3
// Checksum 0xbea78f1a, Offset: 0x600
// Size: 0x1a0
function detach_loot_item( asmname, statename, params )
{
    self notify( #"detach_loot_item" );
    utility::function_7c10ea82c1e305b8( "loot_consume", "off" );
    loot_anchor = self.loot_consume.anchor;
    anchored_loot = self.loot_consume.anchor.loot;
    is_consumed = asm::asm_eventfired( asmname, "loot_consumed" );
    var_21c3b67f1a74cd8e = self.var_5e0be30a5816a64d + ( self.loot_consume.anchor.var_dcb854065ffb333f ?? ( 0, 0, 10 ) );
    drop_angles = self.loot_consume.anchor.drop_angles ?? ( 0, self.angles[ 1 ], 0 );
    
    if ( isdefined( loot_anchor ) )
    {
        loot_anchor unlink();
        loot_anchor.loot = undefined;
        loot_anchor.var_dcb854065ffb333f = undefined;
        loot_anchor.drop_angles = undefined;
    }
    
    if ( isdefined( anchored_loot ) )
    {
        if ( !is_consumed )
        {
            loot_anchor.origin = var_21c3b67f1a74cd8e;
            loot_anchor.angles = drop_angles;
            anchored_loot endon( #"death" );
            waitframe();
        }
        
        anchored_loot utility::scriptable_clearparententity();
        
        if ( !is_consumed )
        {
            anchored_loot utility::callsharedfunc( #"item", #"hash_8c623dab98d6f709" );
        }
    }
}

// Namespace zombie_shade_loot_consume_asm
// Params 3
// Checksum 0x4dbbb072, Offset: 0x7a8
// Size: 0x104, Type: bool
function prep_loot_consume( asmname, statename, params )
{
    loot_target = self.loot_consume.target_data.loot;
    
    if ( !function_2d492483959b4965( loot_target ) )
    {
        return false;
    }
    
    align_dir = vectornormalize2( self.origin - loot_target.origin );
    align_point = loot_target.origin + 18 * align_dir;
    self.loot_consume.anchor.origin = ( align_point[ 0 ], align_point[ 1 ], self.origin[ 2 ] );
    self._blackboard.var_38c9594200d0e862 = self.loot_consume.anchor;
    self orientmode( "face point", loot_target.origin );
    return true;
}

// Namespace zombie_shade_loot_consume_asm
// Params 3
// Checksum 0xfe63ad0f, Offset: 0x8b5
// Size: 0x106
function start_loot_consume( asmname, statename, params )
{
    loot_target = self.loot_consume.target_data.loot;
    
    if ( !function_2d492483959b4965( loot_target ) )
    {
        return;
    }
    
    self endon( #"death" );
    self endon( #"loot_target_cleared" );
    self endon( #"stop_loot_consume" );
    val::set( "loot_consume", "script_pushable", 0 );
    val::set( "loot_consume", "script_pushable_by_ai", 0 );
    utility::function_7c10ea82c1e305b8( "loot_consume", "consume" );
    consume_time = self.loot_consume.target_data.consume_time;
    thread function_b11de3c2e773054b( consume_time );
    self function_786bb6aa1b76c7ee( "is_consuming_loot", 1 );
    
    if ( consume_time > 0 )
    {
        wait consume_time;
    }
    else
    {
        waitframe();
    }
    
    asm::asm_fireevent( asmname, "loot_consumed" );
}

// Namespace zombie_shade_loot_consume_asm
// Params 3
// Checksum 0x7c592c1e, Offset: 0x9c3
// Size: 0x47
function stop_loot_consume( asmname, statename, params )
{
    self notify( #"stop_loot_consume" );
    val::reset_all( "loot_consume" );
    utility::function_7c10ea82c1e305b8( "loot_consume", "off" );
}

// Namespace zombie_shade_loot_consume_asm
// Params 3
// Checksum 0xc0871aa7, Offset: 0xa12
// Size: 0x136
function consume_loot( asmname, statename, params )
{
    if ( isdefined( self.loot_consume ) && isdefined( self.loot_consume.target_data ) )
    {
        if ( isdefined( self.loot_consume.target_data.consume_fullness ) )
        {
            self.loot_consume.fullness += self.loot_consume.target_data.consume_fullness;
        }
        
        loot_target = self.loot_consume.target_data.loot;
        callback::callback( "on_loot_consumed", { #loot:loot_target } );
        
        if ( isdefined( loot_target ) )
        {
            loot_target.cleanupdisabled = undefined;
            loot_target.var_415a014f98ba23de = 1;
            level utility::callsharedfunc( #"game", #"hash_46d169cc2f231f1b", loot_target );
        }
        
        zombie_shade_loot_consume::function_4dfb06dcc4d8d032();
        return;
    }
    
    zombie_shade_loot_consume::function_b28479ffb94894e4( 0 );
}

// Namespace zombie_shade_loot_consume_asm
// Params 1, eflags: 0x4
// Checksum 0x167299b0, Offset: 0xb50
// Size: 0x2e5
function private function_b11de3c2e773054b( consume_time )
{
    vfxspawnorigin = self gettagorigin( "tag_fx_loot" );
    loot_consume_scriptable = spawnscriptable( "scriptable_zombie_shade_loot_consume", vfxspawnorigin, ( 0, 0, 1 ) );
    
    if ( isdefined( loot_consume_scriptable ) && isdefined( self.loot_consume.target_data.rarity ) )
    {
        var_87b8900004ec4875 = 4;
        
        if ( self.loot_consume.target_data.subtype == "ww" )
        {
            loot_consume_scriptable setscriptablepartstate( "loot_consume_rarity", "rarity_gold" );
        }
        else
        {
            switch ( self.loot_consume.target_data.rarity )
            {
                case 0:
                    loot_consume_scriptable setscriptablepartstate( "loot_consume_rarity", "rarity_white" );
                    break;
                case 1:
                    loot_consume_scriptable setscriptablepartstate( "loot_consume_rarity", "rarity_green" );
                    break;
                case 2:
                    loot_consume_scriptable setscriptablepartstate( "loot_consume_rarity", "rarity_blue" );
                    break;
                case 3:
                    loot_consume_scriptable setscriptablepartstate( "loot_consume_rarity", "rarity_purple" );
                    break;
                case 4:
                    loot_consume_scriptable setscriptablepartstate( "loot_consume_rarity", "rarity_orange" );
                    break;
            }
        }
        
        loot_consume_msg = utility::waittill_any_in_array_or_timeout( [ "loot_target_cleared", "stop_loot_consume" ], consume_time );
        loot_consume_scriptable setscriptablepartstate( "loot_consume_rarity", "off" );
        
        if ( loot_consume_msg == "timeout" )
        {
            if ( self.loot_consume.target_data.subtype == "ww" )
            {
                loot_consume_scriptable setscriptablepartstate( "loot_consume_size", "large" );
            }
            else
            {
                switch ( self.loot_consume.target_data.rarity )
                {
                    case 0:
                        loot_consume_scriptable setscriptablepartstate( "loot_consume_size", "medium" );
                        break;
                    case 1:
                        loot_consume_scriptable setscriptablepartstate( "loot_consume_size", "medium" );
                        break;
                    case 2:
                        loot_consume_scriptable setscriptablepartstate( "loot_consume_size", "medium" );
                        break;
                    case 3:
                        loot_consume_scriptable setscriptablepartstate( "loot_consume_size", "medium" );
                        break;
                    case 4:
                        loot_consume_scriptable setscriptablepartstate( "loot_consume_size", "large" );
                        break;
                }
            }
            
            wait var_87b8900004ec4875;
        }
        
        loot_consume_scriptable setscriptablepartstate( "loot_consume_rarity", "off" );
        loot_consume_scriptable setscriptablepartstate( "loot_consume_size", "off" );
        loot_consume_scriptable freescriptable();
    }
}

