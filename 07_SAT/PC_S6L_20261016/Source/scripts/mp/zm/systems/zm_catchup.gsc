// scripts\mp\zm\systems\zm_catchup.gsc  (hash_5d12b85d60e51a75.gscc) (size: 4786 Bytes / 0x12b2 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x47a8fe18 (1202257432)
// size ...... 4786 (0x12b2)
// includes .. 10  (offset: 0x118a)
// strings ... 12  (offset: 0x11da)
// dev strs .. 0   (offset: 0x12b2)
// exports ... 12  (offset: 0xbfa)
// cseg ...... 0x108 + 0xaf2 (0xbfa)
// imports ... 30  (offset: 0xdda)
// animtree1 . 0   (offset: 0x12b2)
// animtree2 . 0   (offset: 0x12b2)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\values;
#using scripts\mp\br\gametypes\br_public;
#using scripts\mp\br\gametypes\br_utility;
#using scripts\mp\currency;
#using scripts\mp\laststand;
#using scripts\mp\loot\common_item_weapon;
#using scripts\mp\zm\zm_player;
#using scripts\mp\zm\zm_utility;

#namespace zm_catchup;

// Namespace zm_catchup
// Params 0, eflags: 0x5
// Checksum 0x70cf40a2, Offset: 0x126
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"zm_catchup", undefined, &init_zm_catchup, undefined );
}

// Namespace zm_catchup
// Params 0
// Checksum 0x753e4a7c, Offset: 0x147
// Size: 0x90
function init_zm_catchup()
{
    level.weapon_rarity_map = [ "legendary":4, "epic":3, "rare":2, "uncommon":1, "common":0 ];
    
    if ( isdefined( level.gametypebundle.var_41f4169e3d0db197 ) )
    {
        level.var_41f4169e3d0db197 = getscriptbundle( level.gametypebundle.var_41f4169e3d0db197 );
    }
    
    callback::add( #"player_spawned", &on_player_spawned );
    callback::add( "on_weapon_rarity_set_complete", &on_weapon_rarity_set );
}

// Namespace zm_catchup
// Params 1
// Checksum 0xf9ce047f, Offset: 0x1df
// Size: 0x40
function on_weapon_rarity_set( params )
{
    if ( params.rarity > 0 && params.weapon == self.var_cc1262e66dbb1c79 )
    {
        self.var_44a573102b9347fc = 1;
    }
}

// Namespace zm_catchup
// Params 1
// Checksum 0xcf79d2, Offset: 0x227
// Size: 0x13d
function on_player_spawned( params )
{
    self endon( #"death_or_disconnect" );
    
    if ( !level.b_zm_game_over )
    {
        val::reset_all( "zm_death" );
    }
    
    self.b_has_spawned_once = 1;
    self.var_de7f96341fb651b = 0;
    b_respawned = istrue( self.var_5c81ab2cabcc273f );
    var_f01f3b644c61c1b5 = self.var_282313ba8fafa8c6 && !self.var_18232bd9949055ad;
    
    if ( var_f01f3b644c61c1b5 )
    {
        if ( zm_player::function_ea92f88903bc485() )
        {
            self.var_18232bd9949055ad = 1;
            return;
        }
    }
    
    if ( b_respawned || var_f01f3b644c61c1b5 )
    {
        set_catchup_items( var_f01f3b644c61c1b5 );
        
        if ( var_f01f3b644c61c1b5 )
        {
            self.var_18232bd9949055ad = 1;
        }
        
        if ( !self.var_dd1463085e5c5240 )
        {
            self.ammo_mod = [];
            self setclientomnvar( "ui_pap_current_ammomod", 0 );
            self.var_66c0acd81fb4e585 = [];
            self setclientomnvar( "ui_pap_current_level", 0 );
        }
    }
    
    self.br_iseliminated = undefined;
    br_public::function_7813786b92d850ff( 0 );
    self.var_25765b441347c2a9 = undefined;
    br_utility::updateplayereliminatedomnvar();
    br_public::setplayerdownedextrainfo( 0 );
    br_public::setplayerbeingrevivedextrainfo( 0 );
    laststand::updatesquadmemberlaststandreviveprogress( self, self, 0, 1 );
    self.var_dd1463085e5c5240 = undefined;
}

// Namespace zm_catchup
// Params 1
// Checksum 0x1bb2078, Offset: 0x36c
// Size: 0x109
function set_catchup_items( var_f01f3b644c61c1b5 )
{
    if ( var_f01f3b644c61c1b5 )
    {
        function_6fe532bf37ebd186();
    }
    else
    {
        current_salvage = currency::get_currency_amount( #"salvage" );
        current_essence = currency::get_currency_amount( #"essence" );
        penalty_salvage = current_salvage * 0.1;
        new_salvage = int( current_salvage - penalty_salvage );
        
        if ( new_salvage % 50 != 0 )
        {
            new_salvage -= new_salvage % 50;
        }
        
        currency::set_currency_amount( #"salvage", new_salvage );
        penalty_essence = current_essence * 0.1;
        new_essence = int( current_essence - penalty_essence );
        
        if ( new_essence % 5 != 0 )
        {
            new_essence -= new_essence % 5;
        }
        
        currency::set_currency_amount( #"essence", new_essence );
        function_6928fc2b96376731();
    }
    
    function_c4e1d3dc45df124e();
    thread function_29aa1f7917a28584();
    thread function_756dfda4109762ac();
    self notify( #"zm_catchup_complete" );
}

// Namespace zm_catchup
// Params 0
// Checksum 0x3d105d9e, Offset: 0x47d
// Size: 0x1cf
function function_c4e1d3dc45df124e()
{
    round_number = zm_utility::get_round_number();
    current_salvage = currency::get_currency_amount( #"salvage" );
    
    if ( round_number >= 1 && round_number <= 5 )
    {
        salvage = level.var_41f4169e3d0db197.var_ce3af7acb578216d ?? 100;
        salvage = ( round_number - 1 ) * salvage;
        
        if ( current_salvage < salvage )
        {
            currency::set_currency_amount( #"salvage", salvage, "respawn" );
        }
        
        return;
    }
    
    if ( round_number >= 6 && round_number <= 10 )
    {
        salvage = level.var_41f4169e3d0db197.var_86acadfd26783a1a ?? 200;
        salvage = ( round_number - 5 ) * salvage;
        
        if ( current_salvage < salvage )
        {
            currency::set_currency_amount( #"salvage", salvage, "respawn" );
        }
        
        return;
    }
    
    if ( round_number >= 11 && round_number <= 20 )
    {
        salvage = level.var_41f4169e3d0db197.var_f934d71f53fc6345 ?? 200;
        salvage = ( round_number - 10 ) * salvage;
        
        if ( current_salvage < salvage )
        {
            currency::set_currency_amount( #"salvage", salvage, "respawn" );
        }
        
        return;
    }
    
    if ( round_number >= 21 && round_number <= 30 )
    {
        salvage = level.var_41f4169e3d0db197.var_5cdba8b9f09ea73 ?? 500;
        salvage = ( round_number - 20 ) * salvage;
        
        if ( current_salvage < salvage )
        {
            currency::set_currency_amount( #"salvage", salvage, "respawn" );
        }
        
        return;
    }
    
    if ( round_number >= 31 )
    {
        salvage = level.var_41f4169e3d0db197.var_8f4bef9a8a38f57c ?? 1000;
        
        if ( current_salvage < salvage )
        {
            currency::set_currency_amount( #"salvage", salvage, "respawn" );
        }
    }
}

// Namespace zm_catchup
// Params 0
// Checksum 0xeac04495, Offset: 0x654
// Size: 0x17b
function function_6928fc2b96376731()
{
    round_number = zm_utility::get_round_number();
    current_essence = currency::get_currency_amount( #"essence" );
    
    if ( round_number >= 2 && round_number <= 7 )
    {
        essence = level.var_41f4169e3d0db197.var_e0ed4fd0c8205580 ?? 500;
        essence = ( round_number - 1 ) * essence;
        
        if ( current_essence < essence )
        {
            currency::set_currency_amount( #"essence", essence, "respawn" );
        }
        
        return;
    }
    
    if ( round_number >= 8 && round_number <= 10 )
    {
        essence = level.var_41f4169e3d0db197.var_1ba4d14d812f4edc ?? 1000;
        essence = ( round_number - 4 ) * essence;
        
        if ( current_essence < essence )
        {
            currency::set_currency_amount( #"essence", essence, "respawn" );
        }
        
        return;
    }
    
    if ( round_number >= 11 && round_number <= 27 )
    {
        essence = level.var_41f4169e3d0db197.var_8b1f40f6a90ce620 ?? 1000;
        essence = ( round_number - 2 ) * essence;
        
        if ( current_essence < essence )
        {
            currency::set_currency_amount( #"essence", essence, "respawn" );
        }
        
        return;
    }
    
    if ( round_number >= 28 )
    {
        essence = level.var_41f4169e3d0db197.var_4e32206285a7bf2 ?? 25000;
        
        if ( current_essence < essence )
        {
            currency::set_currency_amount( #"essence", essence, "respawn" );
        }
    }
}

// Namespace zm_catchup
// Params 0
// Checksum 0xb83a618d, Offset: 0x7d7
// Size: 0x17f
function function_6fe532bf37ebd186()
{
    round_number = zm_utility::get_round_number();
    
    if ( round_number <= 1 )
    {
        essence = level.var_41f4169e3d0db197.var_f8825463ceb96b26 ?? 500;
        currency::set_currency_amount( #"essence", essence, "hotjoin" );
        return;
    }
    
    if ( round_number >= 2 && round_number <= 5 )
    {
        essence = level.var_41f4169e3d0db197.var_3d6cb8aba5bee1f1 ?? 500;
        essence = round_number * essence;
        currency::set_currency_amount( #"essence", essence, "hotjoin" );
        return;
    }
    
    if ( round_number >= 6 && round_number <= 10 )
    {
        essence = level.var_41f4169e3d0db197.var_ad661f3c7b03bcf3 ?? 1000;
        essence = ( round_number - 3 ) * essence;
        currency::set_currency_amount( #"essence", essence, "hotjoin" );
        return;
    }
    
    if ( round_number >= 11 && round_number <= 27 )
    {
        essence = level.var_41f4169e3d0db197.var_f9776a2179937e3f ?? 1000;
        essence = ( round_number - 2 ) * essence;
        currency::set_currency_amount( #"essence", essence, "hotjoin" );
        return;
    }
    
    if ( round_number >= 28 )
    {
        essence = level.var_41f4169e3d0db197.var_9a2f875fcab887c1 ?? 25000;
        currency::set_currency_amount( #"essence", essence, "hotjoin" );
    }
}

// Namespace zm_catchup
// Params 0
// Checksum 0xb3534e8e, Offset: 0x95e
// Size: 0x87
function function_756dfda4109762ac()
{
    self endon( #"death_or_disconnect" );
    
    while ( self.var_44a573102b9347fc )
    {
        if ( isdefined( self.var_cc1262e66dbb1c79 ) && self hasweapon( self.var_cc1262e66dbb1c79 ) )
        {
            newtier = function_833c44c792fc7c23();
            oldtier = item_weapon::function_fb81bd2fe070faa6( self.var_cc1262e66dbb1c79 );
            
            if ( newtier > oldtier )
            {
                item_weapon::function_40e1cbd0e1f47d1a( self.var_cc1262e66dbb1c79, newtier );
            }
            
            break;
        }
        
        waitframe();
    }
}

// Namespace zm_catchup
// Params 0
// Checksum 0x45fb269, Offset: 0x9ed
// Size: 0x88
function function_29aa1f7917a28584()
{
    self endon( #"death_or_disconnect" );
    
    while ( true )
    {
        weapon = self getcurrentweapon();
        
        if ( isdefined( weapon ) && weapon.basename != "none" )
        {
            newtier = function_833c44c792fc7c23();
            oldtier = item_weapon::function_fb81bd2fe070faa6( weapon );
            
            if ( newtier > oldtier )
            {
                item_weapon::function_40e1cbd0e1f47d1a( weapon, newtier );
            }
            
            self notify( #"weapon_catchup_done" );
            break;
        }
        
        waitframe();
    }
}

// Namespace zm_catchup
// Params 0
// Checksum 0xa4bad85c, Offset: 0xa7d
// Size: 0x17c
function function_833c44c792fc7c23()
{
    round_number = zm_utility::get_round_number();
    
    if ( round_number <= 5 )
    {
        rarity = level.var_41f4169e3d0db197.var_ef8c635a634bbdd6 ?? "common";
        return level.weapon_rarity_map[ rarity ];
    }
    else if ( round_number >= 6 && round_number <= 10 )
    {
        rarity = level.var_41f4169e3d0db197.var_8785fd895d1ec3f7 ?? "uncommon";
        return level.weapon_rarity_map[ rarity ];
    }
    else if ( round_number >= 11 && round_number <= 15 )
    {
        rarity = level.var_41f4169e3d0db197.var_6973dbd9dc1fed0a ?? "rare";
        return level.weapon_rarity_map[ rarity ];
    }
    else if ( round_number >= 16 && round_number <= 20 )
    {
        rarity = level.var_41f4169e3d0db197.var_a6a3e7caddeb187f ?? "rare";
        return level.weapon_rarity_map[ rarity ];
    }
    else if ( round_number >= 21 && round_number <= 30 )
    {
        rarity = level.var_41f4169e3d0db197.var_5cdf5b6d9117356c ?? "epic";
        return level.weapon_rarity_map[ rarity ];
    }
    else if ( round_number >= 31 )
    {
        rarity = level.var_41f4169e3d0db197.var_4830141955f6661b ?? "legendary";
        return level.weapon_rarity_map[ rarity ];
    }
    
    return 0;
}

