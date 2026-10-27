// scripts\mp\augments\w_mod_augments.gsc  (hash_5a7c11800e9d754e.gscc) (size: 6392 Bytes / 0x18f8 / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x882b7ebb (2284551867)
// size ...... 6392 (0x18f8)
// includes .. 6   (offset: 0x170c)
// strings ... 32  (offset: 0x173c)
// dev strs .. 0   (offset: 0x18f8)
// exports ... 8   (offset: 0x1150)
// cseg ...... 0x4b1 + 0xc9f (0x1150)
// imports ... 38  (offset: 0x1290)
// animtree1 . 0   (offset: 0x18f8)
// animtree2 . 0   (offset: 0x18f8)
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\mp\common\utility\player;
#using scripts\mp\loot\common_item;

#namespace w_mod_augments;

// Namespace w_mod_augments
// Params 0, eflags: 0x5
// Checksum 0xa3934fc6, Offset: 0x4cf
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"w_mod_augments", undefined, &__init__, undefined );
}

// Namespace w_mod_augments
// Params 0
// Checksum 0xb92be405, Offset: 0x4f0
// Size: 0xa
function __init__()
{
    level thread function_6f8fc62e43d13c78();
}

// Namespace w_mod_augments
// Params 0
// Checksum 0xdbfffec1, Offset: 0x502
// Size: 0x22a
function function_6f8fc62e43d13c78()
{
    if ( !level.zombie_augments_in_use )
    {
        return;
    }
    
    level endon( #"game_ended" );
    level utility::flag_init( "specialty_w_mod" + "init_complete" );
    level utility::flag_wait_all( "StartGameTypeCallbackFinished", "zombie_perks_init_complete" );
    level callback::add( #"player_laststand", &on_player_laststand_enter );
    level._effect[ #"hash_2a684a928a5dd8f" ] = loadfxasset( "vfx_sat_gameplay_zm_ai_wisp_tea_demon_zmb_torso" );
    level._effect[ #"hash_93971f82ae437f49" ] = loadfxasset( "vfx_sat_gameplay_zm_ai_perks_wisp_tea_mask_demon_spawn" );
    level._effect[ #"hash_6659da075453fd88" ] = loadfxasset( "vfx_sat_gameplay_zm_ai_perks_wisp_tea_mask_demon_despawn" );
    level._effect[ #"hash_80c26c82fcf8ebb9" ] = loadfxasset( "vfx_sat_gameplay_zm_ai_wisp_tea_fox_zmb_torso" );
    level._effect[ #"hash_5baf54eacd7a7567" ] = loadfxasset( "vfx_sat_gameplay_zm_ai_perks_wisp_tea_mask_fox_spawn" );
    level._effect[ #"hash_992e554b534e8d46" ] = loadfxasset( "vfx_sat_gameplay_zm_ai_perks_wisp_tea_mask_fox_despawn" );
    level._effect[ #"hash_843d08e37251f378" ] = loadfxasset( "vfx_sat_gameplay_zm_ai_wisp_tea_woman_zmb_torso" );
    level._effect[ #"hash_ad3493b14b5b7d40" ] = loadfxasset( "vfx_sat_gameplay_zm_ai_perks_wisp_tea_mask_woman_spawn" );
    level._effect[ #"hash_6e59b73b485e3531" ] = loadfxasset( "vfx_sat_gameplay_zm_ai_perks_wisp_tea_mask_woman_despawn" );
    level._effect[ #"hash_d2b87a5dcdb38013" ] = loadfxasset( "vfx_sat_gameplay_zm_ai_perks_wisp_tea_healing_beam" );
    level._effect[ #"hash_89ddd4c33fdc812f" ] = loadfxasset( "vfx_sat_gameplay_zm_ai_wisp_tea_monkey_zmb_torso" );
    level._effect[ #"hash_1cdb17a0743e8169" ] = loadfxasset( "vfx_sat_gameplay_zm_ai_perks_wisp_tea_mask_monkey_spawn" );
    level._effect[ #"hash_654e4e06906f08a8" ] = loadfxasset( "vfx_sat_gameplay_zm_ai_perks_wisp_tea_mask_monkey_despawn" );
    utility::registersharedfunc( #"zombie", #"hash_22cc15f7a077344e", &function_97f496c5e9959e0b );
    utility::registersharedfunc( #"zombie", #"hash_4e197dc8416370b7", &function_3261d57de871a6f8 );
    utility::registersharedfunc( #"zombie", #"hash_b8d2e46cea84f289", &function_def91c7d2751461c );
}

// Namespace w_mod_augments
// Params 2
// Checksum 0x8ebcc44, Offset: 0x734
// Size: 0x25e
function function_def91c7d2751461c( var_8721240534cfb99a, var_8fd3eb7841f45192 )
{
    if ( var_8721240534cfb99a )
    {
        switch ( var_8721240534cfb99a )
        {
            case #"hash_dc5681c813beb7e0":
                if ( var_8fd3eb7841f45192 == "damage" )
                {
                    return level._effect[ #"hash_843d08e37251f378" ];
                }
                else if ( var_8fd3eb7841f45192 == "spawn" )
                {
                    return level._effect[ #"hash_ad3493b14b5b7d40" ];
                }
                else if ( var_8fd3eb7841f45192 == "despawn" )
                {
                    return level._effect[ #"hash_6e59b73b485e3531" ];
                }
                
                break;
            case #"hash_22f6f1e31df884e2":
                if ( var_8fd3eb7841f45192 == "damage" )
                {
                    return level._effect[ #"hash_2a684a928a5dd8f" ];
                }
                else if ( var_8fd3eb7841f45192 == "spawn" )
                {
                    return level._effect[ #"hash_93971f82ae437f49" ];
                }
                else if ( var_8fd3eb7841f45192 == "despawn" )
                {
                    return level._effect[ #"hash_6659da075453fd88" ];
                }
                
                break;
            case #"hash_7fd044710be6dd31":
                if ( var_8fd3eb7841f45192 == "damage" )
                {
                    return level._effect[ #"hash_80c26c82fcf8ebb9" ];
                }
                else if ( var_8fd3eb7841f45192 == "spawn" )
                {
                    return level._effect[ #"hash_5baf54eacd7a7567" ];
                }
                else if ( var_8fd3eb7841f45192 == "despawn" )
                {
                    return level._effect[ #"hash_992e554b534e8d46" ];
                }
                
                break;
            case #"hash_cbbcbb077a1e7eda":
                if ( var_8fd3eb7841f45192 == "damage" )
                {
                    return level._effect[ #"hash_89ddd4c33fdc812f" ];
                }
                else if ( var_8fd3eb7841f45192 == "spawn" )
                {
                    return level._effect[ #"hash_1cdb17a0743e8169" ];
                }
                else if ( var_8fd3eb7841f45192 == "despawn" )
                {
                    return level._effect[ #"hash_654e4e06906f08a8" ];
                }
                
                break;
            default:
                if ( var_8fd3eb7841f45192 == "damage" )
                {
                    return level._effect[ #"w_mod_damage" ];
                }
                else if ( var_8fd3eb7841f45192 == "spawn" )
                {
                    return level._effect[ #"w_mod_spawn" ];
                }
                else if ( var_8fd3eb7841f45192 == "despawn" )
                {
                    return level._effect[ #"w_mod_despawn" ];
                }
                
                break;
        }
    }
}

// Namespace w_mod_augments
// Params 1, eflags: 0x4
// Checksum 0xf1a0157f, Offset: 0x99a
// Size: 0x203
function private on_player_laststand_enter( params )
{
    self endon( #"disconnect" );
    self endon( #"healing_aura_healed" );
    level endon( #"game_ended" );
    
    if ( utility::callsharedfunc( #"zombie", #"player_has_augment", #"w_mod_savior" ) )
    {
        if ( !isdefined( self.w_mod_savior_uses ) )
        {
            self.w_mod_savior_uses = 3;
        }
        
        if ( self.var_4fd5ac47a9bd8c18 && !self.beingrevived && self.w_mod_savior_uses > 0 )
        {
            val::set( "w_mod_savior", "toggle_remote_revive", 1 );
            n_timeout = 8;
            
            while ( player::isinlaststand( self ) && !self.var_cc09887c7db65ab5 )
            {
                if ( n_timeout <= 0 )
                {
                    break;
                }
                
                waitframe();
                n_timeout -= level.framedurationseconds;
            }
            
            if ( isdefined( self.var_4fd5ac47a9bd8c18 ) )
            {
                if ( !self.beingrevived && self.laststandreviveent )
                {
                    self.beingremoterevived = 1;
                    reviveent = self.laststandreviveent;
                    reviveent.var_fc2c12f6a236b9db = "last_stand_revived_w_mod_savior";
                    reviveent notify( #"trigger", self );
                    self.var_4fd5ac47a9bd8c18.can_target = 0;
                    self.var_4fd5ac47a9bd8c18.idle_forward_offset = 30;
                    self.var_4fd5ac47a9bd8c18.idle_right_offset = 30;
                }
                
                self waittill( #"laststand_revived" );
                
                if ( isdefined( self.var_4fd5ac47a9bd8c18 ) )
                {
                    self.var_4fd5ac47a9bd8c18 utility::callsharedfunc( #"w_mod", #"delete_wisp", self );
                }
                
                val::set( "w_mod_savior", "toggle_remote_revive", 0 );
                self.w_mod_savior_uses--;
                utility::callsharedfunc( #"zombie", #"hash_f99b1e81a50f8886", 0, 1 );
            }
        }
    }
}

// Namespace w_mod_augments
// Params 0
// Checksum 0xe563190e, Offset: 0xba5
// Size: 0x1e3
function function_97f496c5e9959e0b()
{
    self notify( #"hash_30bf4b62eb782e1e" );
    self endon( #"hash_30bf4b62eb782e1e" );
    self endon( #"disconnect" );
    level endon( #"game_ended" );
    self.var_4fd5ac47a9bd8c18 endon( #"wisp_death" );
    waitframe();
    
    while ( self.var_4fd5ac47a9bd8c18 )
    {
        if ( !isplayer( self ) )
        {
            return;
        }
        
        if ( utility::ent_flag( "disable_player_heal_items" ) )
        {
            return;
        }
        
        heal_threshold = level.zombie_augments[ #"w_mod_pretty_mask" ].var_3bf97c69a5c529e2;
        
        if ( self.health <= self.maxhealth * heal_threshold && !player::isinlaststand( self ) )
        {
            var_7306b73201c61041 = level.zombie_augments[ #"w_mod_pretty_mask" ].var_ae6fc800338f2f27;
            new_health = self.health + var_7306b73201c61041;
            self.health = int( clamp( float( new_health ), 0, float( self.maxhealth ) ) );
            heal_cooldown = maxint( 0, level.zombie_augments[ #"w_mod_pretty_mask" ].var_64f881458c4906ae - 2 );
            
            if ( self.var_4fd5ac47a9bd8c18.e_mover )
            {
                beam = playfxontagsbetweenclients( level._effect[ #"hash_d2b87a5dcdb38013" ], self.var_4fd5ac47a9bd8c18.e_mover, "tag_origin", self, "j_spineupper" );
                self.var_8cfbf5cf0100bf52 = beam;
            }
            
            utility::function_7c10ea82c1e305b8( "w_mod_heal", "on" );
            wait 2;
            utility::function_7c10ea82c1e305b8( "w_mod_heal", "off" );
            
            if ( beam )
            {
                beam delete();
            }
            
            wait heal_cooldown;
        }
        
        waitframe();
    }
}

// Namespace w_mod_augments
// Params 0
// Checksum 0xdfd74dd5, Offset: 0xd90
// Size: 0x3c0
function function_3261d57de871a6f8()
{
    self notify( #"hash_32a2e9b187b9480c" );
    self endon( #"hash_32a2e9b187b9480c" );
    level endon( #"game_ended" );
    self endon( #"disconnect" );
    self.var_4fd5ac47a9bd8c18 endon( #"wisp_death" );
    waitframe();
    
    while ( self.var_4fd5ac47a9bd8c18 )
    {
        if ( !isplayer( self ) )
        {
            return;
        }
        
        searchradius = self.var_4fd5ac47a9bd8c18.var_bb035c0551548452;
        pickuprange = level.zombie_augments[ #"w_mod_fetcher" ].var_e1044df17459a4d1;
        var_6d176fcb3c3e3b7f = level.zombie_augments[ #"w_mod_fetcher" ].var_567343017f2060e5;
        var_49e9c9e6e839111e = getlootscriptablearrayinradius( undefined, undefined, self.origin, searchradius );
        var_22bf8c092e113a6e = getscriptablearrayinradius( "powerup", "script_noteworthy", self.origin, searchradius );
        var_49e9c9e6e839111e = arraycombine( var_49e9c9e6e839111e, var_22bf8c092e113a6e );
        
        if ( var_49e9c9e6e839111e.size > 0 )
        {
            while ( self.var_4fd5ac47a9bd8c18 && !self.var_4fd5ac47a9bd8c18.fetcher_target && var_49e9c9e6e839111e.size )
            {
                waitframe();
                scriptable = function_47c86977a18df38b( var_49e9c9e6e839111e, self.var_4fd5ac47a9bd8c18.origin, searchradius );
                
                if ( !isdefined( scriptable ) )
                {
                    var_49e9c9e6e839111e = function_5713d46873b29625( var_49e9c9e6e839111e );
                    continue;
                }
                
                if ( scriptable.disable )
                {
                    var_49e9c9e6e839111e = arrayremove( var_49e9c9e6e839111e, scriptable );
                    continue;
                }
                
                itembundlename = common_item::function_33a2c00e46263d99( scriptable );
                itembundle = common_item::function_6b8ff3d5f2688336( scriptable );
                
                if ( common_item::function_5f81801cb8c86ac2( itembundlename, itembundle, scriptable, 1 ) )
                {
                    self.var_4fd5ac47a9bd8c18.fetcher_target = scriptable;
                    continue;
                }
                
                if ( scriptable.e_powerup && scriptable.e_powerup.str_powerup != "nuke" )
                {
                    self.var_4fd5ac47a9bd8c18.fetcher_target = scriptable;
                    continue;
                }
                
                var_49e9c9e6e839111e = arrayremove( var_49e9c9e6e839111e, scriptable );
            }
            
            if ( self.var_4fd5ac47a9bd8c18.fetcher_target )
            {
                if ( !arraycontains( var_49e9c9e6e839111e, self.var_4fd5ac47a9bd8c18.fetcher_target ) )
                {
                    self.var_4fd5ac47a9bd8c18.fetcher_target = undefined;
                }
            }
            
            if ( isplayer( self ) && self.var_4fd5ac47a9bd8c18 && self.var_4fd5ac47a9bd8c18.fetcher_target )
            {
                if ( distance( self.var_4fd5ac47a9bd8c18.origin, self.var_4fd5ac47a9bd8c18.fetcher_target.origin ) < pickuprange )
                {
                    if ( self.var_4fd5ac47a9bd8c18.fetcher_target.e_powerup )
                    {
                        powerup = self.var_4fd5ac47a9bd8c18.fetcher_target.e_powerup;
                        
                        if ( powerup.e_trigger )
                        {
                            powerup.e_trigger notify( #"trigger", self );
                        }
                    }
                    else if ( !self.var_4fd5ac47a9bd8c18.fetcher_target.disable )
                    {
                        common_item::function_96119bed8ab4c5d9( self.var_4fd5ac47a9bd8c18.fetcher_target, 1, 0, 0 );
                    }
                }
            }
        }
        else if ( self.var_4fd5ac47a9bd8c18.fetcher_target )
        {
            self.var_4fd5ac47a9bd8c18.fetcher_target = undefined;
        }
        
        wait var_6d176fcb3c3e3b7f;
    }
}

