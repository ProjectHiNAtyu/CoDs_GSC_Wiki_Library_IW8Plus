// scripts\common\ai\aitypes\zombie_base\zombie_base_knockdown.gsc  (hash_4d74c7d12528d777.gscc) (size: 1378 Bytes / 0x562 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x3abf3d7f (985611647)
// size ...... 1378 (0x562)
// includes .. 4   (offset: 0x512)
// strings ... 4   (offset: 0x532)
// dev strs .. 0   (offset: 0x562)
// exports ... 6   (offset: 0x2c6)
// cseg ...... 0xaf + 0x217 (0x2c6)
// imports ... 12  (offset: 0x3b6)
// animtree1 . 0   (offset: 0x562)
// animtree2 . 0   (offset: 0x562)
#using scripts\common\ai\aitypes\shared\zombie\zombie_knockdown;
#using scripts\common\ai\aitypes\zombie_base\zombie_base_dismemberment;
#using scripts\common\callbacks;
#using scripts\common\values;

#namespace zombie_base_knockdown;

// Namespace zombie_base_knockdown
// Params 0
// Checksum 0x36de9d86, Offset: 0xcd
// Size: 0x42
function init_knockdown_global()
{
    callback::get_template( self.animsetname ) callback::add( "on_zombie_ai_damaged", &on_damaged );
    callback::get_template( self.animsetname ) callback::add( "on_is_crawling_changed", &on_is_crawling_changed );
}

// Namespace zombie_base_knockdown
// Params 0
// Checksum 0x69edc96e, Offset: 0x117
// Size: 0x1a
function function_578cd83f268c0cc3()
{
    self.var_fdef03e624fbbbda = self.health * 0.01;
}

// Namespace zombie_base_knockdown
// Params 1, eflags: 0x4
// Checksum 0x40e79610, Offset: 0x139
// Size: 0xf4
function private on_damaged( params )
{
    if ( isexplosivedamagemod( params.smeansofdeath ) && ( !isdefined( params.einflictor ) || !params.einflictor.prevent_knockdown ) && !function_49dc4fbcd837f760( params.sweapon ) )
    {
        knockdown_chance = params.einflictor.knockdown_chance;
        
        if ( knockdown_chance )
        {
            if ( randomint( 100 ) > knockdown_chance )
            {
                return params.idamage;
            }
        }
        
        if ( params.idamage > self.var_fdef03e624fbbbda )
        {
            if ( !self.var_d6894f01a36b4ff3.var_f001a67fabfe81b9 )
            {
                zombie_knockdown::function_a113e6ee43535d37( params.vpoint, params.idamage );
            }
        }
    }
    
    return params.idamage;
}

// Namespace zombie_base_knockdown
// Params 1, eflags: 0x4
// Checksum 0xe6d193fe, Offset: 0x236
// Size: 0x23
function private on_is_crawling_changed( params )
{
    val::set( "is_crawling", "disallow_knockdown", namespace_b76ff2659823e89d::is_crawling() );
}

// Namespace zombie_base_knockdown
// Params 1, eflags: 0x4
// Checksum 0xeabd3bda, Offset: 0x261
// Size: 0x64, Type: bool
function private function_49dc4fbcd837f760( weapon_object )
{
    if ( isdefined( weapon_object ) && isdefined( weapon_object.basename ) && isdefined( level.var_ef6fc50ff40f47a8 ) )
    {
        if ( arraycontains( level.var_ef6fc50ff40f47a8, weapon_object.basename ) || arraycontains( level.var_ef6fc50ff40f47a8, getweaponrootstring( weapon_object ) ) )
        {
            return true;
        }
    }
    
    return false;
}

