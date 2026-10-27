// scripts\mp\augments\d_mod_augments.gsc  (hash_0282cb529ce24fc9.gscc) (size: 7660 Bytes / 0x1dec / GSC)
// magic .... 0xa0d4353471a vm: Call of Duty: Black Ops 7 (Black Ops 7)
// crc: 0x654b6337 (1699439415)
// size ...... 7660 (0x1dec)
// includes .. 8   (offset: 0x1cd4)
// strings ... 13  (offset: 0x1d14)
// dev strs .. 0   (offset: 0x1dec)
// exports ... 20  (offset: 0x12e0)
// cseg ...... 0x15b + 0x1185 (0x12e0)
// imports ... 53  (offset: 0x1600)
// animtree1 . 0   (offset: 0x1dec)
// animtree2 . 0   (offset: 0x1dec)
#using scripts\common\ai\aitypes\shared\zombie\zombie_utils;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\mp\common\utility\perk;
#using scripts\mp\common\utility\weapon_utility;

#namespace d_mod_augments;

// Namespace d_mod_augments
// Params 0, eflags: 0x5
// Checksum 0x5e38c0f7, Offset: 0x179
// Size: 0x19
function private autoexec __init__system__()
{
    system::register( #"d_mod_augments", undefined, &init_d_mod_augments, undefined );
}

// Namespace d_mod_augments
// Params 0
// Checksum 0xd905c51c, Offset: 0x19a
// Size: 0x6e
function init_d_mod_augments()
{
    if ( !level.zombie_augments_in_use )
    {
        return;
    }
    
    callback::add( "zm_perk_obtained", &function_288f120db5b6defb );
    callback::add( "zm_perk_lost", &function_9e09844df6bf44c7 );
    callback::add( #"hash_474490f7ce8b74d0", &function_2a608bce3de99b7 );
    callback::add( #"reload", &on_player_reload );
    level callback::add( "on_zombie_ai_killed", &d_mod_augments_on_ai_killed );
}

// Namespace d_mod_augments
// Params 1
// Checksum 0x6d15adb2, Offset: 0x210
// Size: 0x1bd
function function_288f120db5b6defb( params )
{
    if ( isdefined( params ) && params.var_ffc1674def575bfa == "specialty_d_mod" )
    {
        doubletimename = #"d_mod_double_time";
        var_a412cc81d7c270c2 = #"d_mod_double_impact";
        var_c639ad492735092a = #"d_mod_double_jeopardy";
        var_4ff8c637dc9191e9 = #"d_mod_double_standard";
        var_cd9a3c2390a0aea0 = #"d_mod_double_or_nothing";
        lowammo = #"d_mod_low_ammo";
        var_20cde71079daf571 = function_dc9acb15abc61746( doubletimename );
        var_a88e0002b97c094a = function_f53a69c1e09d0839( var_a412cc81d7c270c2 );
        var_9e2246be18b53e6e = function_f53a69c1e09d0839( var_c639ad492735092a );
        var_fed5a2678d47388d = function_f53a69c1e09d0839( var_4ff8c637dc9191e9 );
        var_fd89bada26bd63ca = function_f53a69c1e09d0839( var_cd9a3c2390a0aea0 );
        var_f04b4b225f77a883 = function_f53a69c1e09d0839( lowammo );
        fire_time_scale = 80;
        
        if ( var_20cde71079daf571 )
        {
            perk::giveperk( "specialty_fast_rechamber_augment" );
            fire_time_scale = getdvarint( @"hash_e8f497d1da081475", 70 );
        }
        else
        {
            perk::giveperk( "specialty_fast_rechamber" );
            fire_time_scale = getdvarint( @"hash_a99838da0e23cf4e", 80 );
        }
        
        val::set( "d_mod_augments", "fire_time_scale", fire_time_scale );
        
        if ( var_a88e0002b97c094a )
        {
            zombie_utils::function_dfae6a5bd222c586( &d_mod_double_impact_on_ai_damage );
        }
        
        if ( var_9e2246be18b53e6e )
        {
            zombie_utils::function_dfae6a5bd222c586( &d_mod_double_jeopardy_on_ai_damage );
        }
        
        if ( var_fed5a2678d47388d )
        {
            zombie_utils::function_dfae6a5bd222c586( &d_mod_double_standard_on_ai_damage );
        }
        
        if ( var_fd89bada26bd63ca )
        {
            zombie_utils::function_dfae6a5bd222c586( &function_7a95aee0007e3b30 );
        }
        
        if ( var_f04b4b225f77a883 )
        {
            perk::giveperk( "specialty_bulletpenetration" );
        }
    }
}

// Namespace d_mod_augments
// Params 1
// Checksum 0xbee2fab3, Offset: 0x3d5
// Size: 0x106
function function_9e09844df6bf44c7( params )
{
    if ( isdefined( params ) && params.var_ffc1674def575bfa == "specialty_d_mod" )
    {
        doubletimename = #"d_mod_double_time";
        lowammo = #"d_mod_low_ammo";
        var_20cde71079daf571 = function_dc9acb15abc61746( doubletimename );
        var_f04b4b225f77a883 = function_dc9acb15abc61746( lowammo );
        
        if ( var_20cde71079daf571 )
        {
            if ( isdefined( self.perks[ "specialty_fast_rechamber_augment" ] ) )
            {
                perk::removeperk( "specialty_fast_rechamber_augment" );
            }
        }
        else if ( isdefined( self.perks[ "specialty_fast_rechamber" ] ) )
        {
            perk::removeperk( "specialty_fast_rechamber" );
        }
        
        if ( var_f04b4b225f77a883 )
        {
            perk::removeperk( "specialty_bulletpenetration" );
        }
        
        val::reset_all( "d_mod_augments" );
        zombie_utils::function_10c0c35c21e3ed9d( &d_mod_double_impact_on_ai_damage );
        zombie_utils::function_10c0c35c21e3ed9d( &d_mod_double_jeopardy_on_ai_damage );
        zombie_utils::function_10c0c35c21e3ed9d( &d_mod_double_standard_on_ai_damage );
        zombie_utils::function_10c0c35c21e3ed9d( &function_7a95aee0007e3b30 );
    }
}

// Namespace d_mod_augments
// Params 1
// Checksum 0x5cf0f25a, Offset: 0x4e3
// Size: 0xb7
function d_mod_augments_on_ai_killed( params )
{
    if ( isplayer( params.eattacker ) )
    {
        var_9a8f0d0833d785e2 = #"d_mod_double_play";
        player = params.eattacker;
        var_93c345afb508d25a = player function_f53a69c1e09d0839( var_9a8f0d0833d785e2 );
        var_8b2d9d00752fa142 = utility::isbulletdamage( params.smeansofdeath );
        
        if ( var_93c345afb508d25a && !weapon::iswonderweapon( params.objweapon ) && !weapon::iskillstreakweapon( params.objweapon ) && var_8b2d9d00752fa142 )
        {
            player function_d21e05cd3badaafa( var_9a8f0d0833d785e2 );
        }
    }
}

// Namespace d_mod_augments
// Params 1
// Checksum 0x331f826, Offset: 0x5a2
// Size: 0x319
function function_d21e05cd3badaafa( augmentname )
{
    currenttime = gettime();
    
    if ( !isdefined( self.var_ff20bf626a9b2b11 ) )
    {
        self.var_ff20bf626a9b2b11 = { #numkills:1, #killtime:currenttime };
        return;
    }
    
    var_d92dc56ad7d91110 = level.zombie_augments[ augmentname ].var_850d42d79595cc3 * ( 1000 ?? 1500 );
    
    if ( currenttime - self.var_ff20bf626a9b2b11.killtime < var_d92dc56ad7d91110 )
    {
        self.var_ff20bf626a9b2b11.numkills++;
        
        if ( self.var_ff20bf626a9b2b11.numkills >= 2 )
        {
            refundchance = level.zombie_augments[ augmentname ].var_4031b464f013037 ?? 25;
            
            if ( randomintrange( 0, 100 ) < refundchance )
            {
                if ( self.currentweapon.isdualwield )
                {
                    n_clip_current_left = self getweaponammoclip( self.currentweapon, "left" );
                    n_clip_current_right = self getweaponammoclip( self.currentweapon, "right" );
                    var_b11feea92c35d08e = weaponclipsize( self.currentweapon );
                    bonus_ammo = 2;
                    b_refilled = 0;
                    
                    if ( n_clip_current_left < var_b11feea92c35d08e && n_clip_current_right < var_b11feea92c35d08e )
                    {
                        bonus_ammo = 1;
                    }
                    
                    if ( n_clip_current_left < var_b11feea92c35d08e )
                    {
                        amount_to_add = n_clip_current_left + bonus_ammo;
                        amount_to_add = clamp( amount_to_add, 0, var_b11feea92c35d08e );
                        self setweaponammoclip( self.currentweapon, amount_to_add, "left" );
                        b_refilled = 1;
                    }
                    
                    if ( n_clip_current_right < var_b11feea92c35d08e )
                    {
                        amount_to_add = n_clip_current_right + bonus_ammo;
                        amount_to_add = clamp( amount_to_add, 0, var_b11feea92c35d08e );
                        self setweaponammoclip( self.currentweapon, amount_to_add, "right" );
                        b_refilled = 1;
                    }
                    
                    if ( b_refilled )
                    {
                        self.var_ff20bf626a9b2b11.numkills -= 2;
                        
                        if ( self.var_ff20bf626a9b2b11.numkills < 0 )
                        {
                            self.var_ff20bf626a9b2b11.numkills = 0;
                        }
                    }
                }
                else
                {
                    var_83e55048826dcd05 = self getweaponammoclip( self.currentweapon );
                    var_b11feea92c35d08e = weaponclipsize( self.currentweapon );
                    
                    if ( var_83e55048826dcd05 < var_b11feea92c35d08e )
                    {
                        amount_to_add = var_83e55048826dcd05 + 2;
                        amount_to_add = clamp( amount_to_add, 0, var_b11feea92c35d08e );
                        self setweaponammoclip( self.currentweapon, amount_to_add );
                        self.var_ff20bf626a9b2b11.numkills -= 2;
                        
                        if ( self.var_ff20bf626a9b2b11.numkills < 0 )
                        {
                            self.var_ff20bf626a9b2b11.numkills = 0;
                        }
                    }
                }
            }
        }
        
        return;
    }
    
    self.var_ff20bf626a9b2b11 = { #numkills:1, #killtime:currenttime };
}

// Namespace d_mod_augments
// Params 1, eflags: 0x4
// Checksum 0x4170b858, Offset: 0x8c3
// Size: 0xcb
function private d_mod_double_impact_on_ai_damage( sparams )
{
    assert( isplayer( sparams.eattacker ) );
    damage = sparams.idamage ?? 0;
    var_8b2d9d00752fa142 = utility::isbulletdamage( sparams.smeansofdeath ) && isdefined( sparams.sweapon ) && !weapon::iswonderweapon( sparams.sweapon );
    
    if ( var_8b2d9d00752fa142 )
    {
        var_a412cc81d7c270c2 = #"d_mod_double_impact";
        player = sparams.eattacker;
        assert( player function_f53a69c1e09d0839( var_a412cc81d7c270c2 ) );
        damage = function_4b0904a11d2f76ea( player, var_a412cc81d7c270c2, damage );
    }
    
    return damage;
}

// Namespace d_mod_augments
// Params 1, eflags: 0x4
// Checksum 0xcfb1adb1, Offset: 0x997
// Size: 0xd9
function private d_mod_double_jeopardy_on_ai_damage( sparams )
{
    assert( isplayer( sparams.eattacker ) );
    damage = sparams.idamage ?? 0;
    
    if ( self.aicategory == "normal" && !weapon::iswonderweapon( sparams.sweapon ) && !utility::ismeleedamage( sparams.smeansofdeath ) && !weapon_utility::isoffhandweapon( sparams.sweapon ) )
    {
        var_c639ad492735092a = #"d_mod_double_jeopardy";
        player = sparams.eattacker;
        assert( player function_f53a69c1e09d0839( var_c639ad492735092a ) );
        damage = function_a9f34080ed6320e( player, var_c639ad492735092a, damage );
    }
    
    return damage;
}

// Namespace d_mod_augments
// Params 1, eflags: 0x4
// Checksum 0xfc597a4d, Offset: 0xa79
// Size: 0xca
function private d_mod_double_standard_on_ai_damage( sparams )
{
    assert( isplayer( sparams.eattacker ) );
    damage = sparams.idamage ?? 0;
    
    if ( !sparams.biscritical )
    {
        var_8b2d9d00752fa142 = utility::isbulletdamage( sparams.smeansofdeath ) && !weapon::iswonderweapon( sparams.sweapon );
        
        if ( var_8b2d9d00752fa142 )
        {
            var_4ff8c637dc9191e9 = #"d_mod_double_standard";
            player = sparams.eattacker;
            assert( player function_f53a69c1e09d0839( var_4ff8c637dc9191e9 ) );
            damage = function_523ecca33509fc2d( player, var_4ff8c637dc9191e9, damage );
        }
    }
    
    return damage;
}

// Namespace d_mod_augments
// Params 1, eflags: 0x4
// Checksum 0x8637e252, Offset: 0xb4c
// Size: 0xbb
function private function_7a95aee0007e3b30( sparams )
{
    assert( isplayer( sparams.eattacker ) );
    damage = sparams.idamage ?? 0;
    var_8b2d9d00752fa142 = utility::isbulletdamage( sparams.smeansofdeath ) && !weapon::iswonderweapon( sparams.sweapon );
    
    if ( var_8b2d9d00752fa142 )
    {
        var_cd9a3c2390a0aea0 = #"d_mod_double_or_nothing";
        player = sparams.eattacker;
        assert( player function_f53a69c1e09d0839( var_cd9a3c2390a0aea0 ) );
        damage = function_7e74938ec38a4ea7( player, var_cd9a3c2390a0aea0, damage );
    }
    
    return damage;
}

// Namespace d_mod_augments
// Params 3
// Checksum 0x87f9478f, Offset: 0xc10
// Size: 0x153
function function_4b0904a11d2f76ea( player, augmentname, damage )
{
    time = gettime();
    
    if ( !isdefined( self.var_bc4a968773cb6980 ) )
    {
        self.var_bc4a968773cb6980 = [];
    }
    
    if ( !isdefined( self.var_bc4a968773cb6980[ player.guid ] ) )
    {
        self.var_bc4a968773cb6980[ player.guid ] = time;
    }
    else if ( isdefined( self.last_dmg_struct ) && player === self.last_dmg_struct.eattacker )
    {
        var_914f035412123e84 = self.last_dmg_struct.timehit;
        var_c1db94221da7d294 = level.zombie_augments[ augmentname ].var_3f2e8e8a9ddbc1b7 * ( 1000 ?? 3000 );
        
        if ( time - var_914f035412123e84 <= var_c1db94221da7d294 )
        {
            var_8efb19460dd2feae = level.zombie_augments[ augmentname ].var_65766801a3cca6dd / ( 100 ?? 0.5 );
            damage += damage * var_8efb19460dd2feae;
            self.var_bc4a968773cb6980[ player.guid ] = undefined;
        }
        else
        {
            self.var_bc4a968773cb6980[ player.guid ] = undefined;
        }
    }
    
    return damage;
}

// Namespace d_mod_augments
// Params 3
// Checksum 0xd82ecf7d, Offset: 0xd6c
// Size: 0xd6
function function_a9f34080ed6320e( player, augmentname, damage )
{
    healththreshold = level.zombie_augments[ augmentname ].var_421064cedd19c1aa / ( 100 ?? 0.25 );
    
    if ( self.health < self.maxhealth * healththreshold )
    {
        executechance = level.zombie_augments[ augmentname ].var_1bf3a5b84232fbc4 ?? 50;
        
        if ( randomintrange( 0, 100 ) < executechance )
        {
            scoreparams = spawnstruct();
            scoreparams.scoreevent = #"zombie_death_perception_kill";
            player callback::callback( "zombie_score_event", scoreparams );
            damage = self.health;
        }
    }
    
    return damage;
}

// Namespace d_mod_augments
// Params 3
// Checksum 0xb443b724, Offset: 0xe4b
// Size: 0x49
function function_523ecca33509fc2d( player, augmentname, damage )
{
    damagemultiplier = level.zombie_augments[ augmentname ].var_78e55afcbe268c50 ?? 2;
    return damage * damagemultiplier;
}

// Namespace d_mod_augments
// Params 3
// Checksum 0x260c63a6, Offset: 0xe9d
// Size: 0xa0
function function_7e74938ec38a4ea7( player, augmentname, damage )
{
    var_425ecff48d9f56dd = level.zombie_augments[ augmentname ].var_8b8f8877b198b62a ?? 15;
    nodamagechance = level.zombie_augments[ augmentname ].var_a067c9db80fb8401 ?? 5;
    randomint = randomintrange( 0, 100 );
    
    if ( randomint < var_425ecff48d9f56dd )
    {
        damage *= 2;
    }
    else if ( randomint > 100 - nodamagechance )
    {
        damage = 0.01;
    }
    
    return damage;
}

// Namespace d_mod_augments
// Params 1
// Checksum 0x4b59f69a, Offset: 0xf46
// Size: 0x52
function function_f53a69c1e09d0839( augmentname )
{
    funccategory = #"zombie";
    funcname = #"hash_3930894d8d2f0ee6";
    
    if ( utility::issharedfuncdefined( funccategory, funcname ) )
    {
        return utility::callsharedfunc( funccategory, funcname, "specialty_d_mod", augmentname );
    }
    
    return 0;
}

// Namespace d_mod_augments
// Params 1
// Checksum 0x1715bf40, Offset: 0xfa1
// Size: 0x4c
function function_dc9acb15abc61746( augmentname )
{
    funccategory = #"zombie";
    funcname = #"player_has_augment";
    
    if ( utility::issharedfuncdefined( funccategory, funcname ) )
    {
        return utility::callsharedfunc( funccategory, funcname, augmentname );
    }
    
    return 0;
}

// Namespace d_mod_augments
// Params 1, eflags: 0x4
// Checksum 0x39386912, Offset: 0xff6
// Size: 0x1d9
function private d_mod_low_ammo_on_ai_damage( sparams )
{
    assert( isplayer( sparams.eattacker ) );
    assert( sparams.eattacker function_f53a69c1e09d0839( #"d_mod_low_ammo" ) );
    damage = sparams.idamage ?? 0;
    player = sparams.eattacker;
    currentweapon = player getcurrentweapon();
    lowammopercentage = level.zombie_augments[ #"d_mod_low_ammo" ].var_86962d667285a853 ?? 0.3;
    bonusdamagemultiplier = level.zombie_augments[ #"d_mod_low_ammo" ].var_a272373cff312f6e ?? 3;
    lowammocap = level.zombie_augments[ #"d_mod_low_ammo" ].var_fd830621a75f0c41 ?? 30;
    var_18ab53d2e9ae94fb = weaponclipsize( currentweapon );
    
    if ( currentweapon.isdualwield )
    {
        var_18ab53d2e9ae94fb *= 2;
        lowammothreshold = int( var_18ab53d2e9ae94fb * lowammopercentage );
        var_10f86b4dec32390c = player getweaponammoclip( currentweapon, "left" );
        var_7c8419644a8d9d79 = player getweaponammoclip( currentweapon, "right" );
        var_4f67136e338de21 = var_10f86b4dec32390c + var_7c8419644a8d9d79;
        
        if ( lowammothreshold > lowammocap )
        {
            lowammothreshold = lowammocap;
        }
        
        if ( var_4f67136e338de21 < lowammothreshold )
        {
            damage = bonusdamagemultiplier * sparams.idamage;
        }
    }
    else
    {
        lowammothreshold = int( var_18ab53d2e9ae94fb * lowammopercentage );
        var_4f67136e338de21 = player getweaponammoclip( currentweapon );
        
        if ( lowammothreshold > lowammocap )
        {
            lowammothreshold = lowammocap;
        }
        
        if ( var_4f67136e338de21 < lowammothreshold )
        {
            damage = bonusdamagemultiplier * sparams.idamage;
        }
    }
    
    return damage;
}

// Namespace d_mod_augments
// Params 1, eflags: 0x4
// Checksum 0x1d55900d, Offset: 0x11d8
// Size: 0xdd
function private function_2a608bce3de99b7( sparams )
{
    if ( utility::callsharedfunc( #"zombie", #"hash_3930894d8d2f0ee6", "specialty_d_mod", #"d_mod_double_dealer" ) )
    {
        current_weapon = self getcurrentweapon();
        clip_count = 0;
        
        if ( !isdefined( self.var_abcd1ec7d2a92572 ) )
        {
            self.var_abcd1ec7d2a92572 = 0;
        }
        
        if ( current_weapon.isdualwield )
        {
            clip_count_left = self getweaponammoclip( current_weapon, "left" );
            clip_count_right = self getweaponammoclip( current_weapon, "right" );
            clip_count = clip_count_left + clip_count_right;
        }
        else
        {
            clip_count = self getweaponammoclip( current_weapon );
        }
        
        if ( clip_count > 0 )
        {
            self.var_abcd1ec7d2a92572++;
            
            if ( self.var_abcd1ec7d2a92572 >= 4 )
            {
                self.var_abcd1ec7d2a92572 = 0;
            }
        }
    }
}

// Namespace d_mod_augments
// Params 1, eflags: 0x4
// Checksum 0x37edeedd, Offset: 0x12bd
// Size: 0x23
function private on_player_reload( sparams )
{
    if ( isdefined( self.var_abcd1ec7d2a92572 ) )
    {
        self.var_abcd1ec7d2a92572 = 0;
    }
}

